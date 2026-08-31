# Sparse Expert Routing

**Partition a layer's parameters into `E` experts, and let a router send each unit of input to a small subset of them: the parameter count is then decoupled from the compute per example, and *which* parameters run becomes a discrete, readable decision the architecture makes at every layer.**

> **Provenance.** Fedus, Dean & Zoph 2022, *A Review of Sparse Expert Models in Deep Learning* (`raw/fedus-2022-sparse-expert-models-review.md`). A survey by the Switch Transformer authors, so its empirical rows are citations to others' work (and to their own); the wiki takes it as the **anchor for routing as an architectural primitive** and as the source for the routing taxonomy, the load-balance problem, the upstream/downstream dissociation, and the expert-specialisation evidence. Individual systems (Shazeer et al. 2017, Fedus et al. 2022b) have their own entity pages.

The page exists because the wiki has needed a router for a long time (`G12`, `G91`, `T283`, `P17`) and has only ever discussed routers that select among *stored structures*. This literature is the one place where routing is the object of study at scale, and it reports two things the wiki did not have: a taxonomy of what a router can be, and the finding that **a large fraction of the win survives when the router is not learned at all**.

---

## The primitive

For token embedding `x` and router weights `W_r ∈ ℝ^{E×d}`:

```
h(x) = W_r x                          router logits, one per expert
p(x) = softmax(h(x))
y     = Σ_{i ∈ topk(p)} p_i(x) · E_i(x)
```

The gradient to `W_r` exists only through the **scaling by `p_i`** — the argmax itself is non-differentiable. This is Shazeer et al. 2017's escape from the reinforcement-learning formulation of expert selection (the problem is otherwise a bandit; Bengio et al. 2015, Clark et al. 2022 do use REINFORCE with negative cross-entropy as reward).

| Quantity | Definition | Why a builder cares |
|---|---|---|
| `k` | Experts per token | Shazeer conjectured `k ≥ 2` was necessary ("compare and optimise the relative performance"); Switch showed `k = 1` competitive, corroborated by Clark et al. 2022. **The conjecture was wrong**, and it was the reason routing cost 2× for four years |
| Capacity factor `CF` | Expert batch size `= CF·(B/E)` | The all2all communication cost, and the *drop rate*: a token routed to a full expert receives **no computation at all** and passes through unchanged |
| Expert frequency | Fraction of layers made sparse | 1.0 (Switch), 0.5 (GShard, GLaM, DeepSpeed-MoE — the convention), 0.25 (ST-MoE); 0.5–1.0 recommended |
| Effective parameter count (EPC) | Dense-equivalent parameter count derived from FLOPs and `E` under a conjectured bilinear loss (Clark et al. 2022) | Cross-entropy is a power law in EPC, so sparse and dense models land on one curve — the only quantity that makes them comparable |

---

## The routing taxonomy

Read the `E × T` matrix of router scores and ask along which axis the top-`k` is taken. The survey's three classes, plus what each buys:

| Class | Mechanism | What it solves | What it costs |
|---|---|---|---|
| **Token chooses top-`k` experts** (Shazeer 2017, GShard, Switch) | Argmax along the expert axis | Simplest; the default | Load imbalance is *unconstrained* — needs an auxiliary balance loss, and overflowing experts drop tokens |
| **Expert chooses top-`k` tokens** (Zhou et al. 2022) | Argmax along the token axis | Load balance **by construction** — no auxiliary loss, no linear assignment | Some tokens get no expert, others get all of them. This is a *feature*: it is adaptive computation, allocated implicitly per token |
| **Global assignment** (BASE, S-BASE) | Linear assignment (BASE) or optimal transport (S-BASE) maximising total routing score under an equal-tokens-per-expert constraint | Exact balance, no greedy failure | Two extra all2all primitives per pass; tokens must be shuffled first because same-sentence tokens are correlated |
| **Static / non-learned** (Hash Layers; DEMix; language-specific sublayers) | A hash of the input token id, or a hand-declared domain/language label | No router to train, no imbalance (choose the hash to balance before training), no instability | No context-sensitivity whatsoever — see `T296` |

**The unexplored quadrant the survey names.** Nothing looks along *both* axes without paying the global cost: let each token pick its preferred experts, then let each expert choose among the tokens that picked it. That is a deferred-acceptance/stable-matching step, `O(T·k)` messages rather than a global assignment, and it does not appear in the literature.

**Two more that resist the taxonomy.** THOR selects two experts **uniformly at random** at both training *and* inference and gains 2 BLEU over standard MoE. DTS-Gate and Dua et al. 2021 start dense (every token to every expert) and *anneal* to top-1 — no load-balance loss needed, because the specialisation that makes balance natural is grown rather than imposed. Batch Prioritized Routing decides *who gets dropped* by routing score rather than sequence position, which matters for vision (no causal order) and was also found to help language models.

---

## Load balance is the whole engineering problem

The naive failure is a rich-get-richer collapse: a slightly-favoured expert receives more tokens, trains faster, becomes more favoured. The remedies partition exactly as the taxonomy does — **penalise imbalance** (auxiliary loss, Shazeer 2017), **constrain it away** (BASE/S-BASE assignment), **make it structurally impossible** (expert-choice routing, hashing), or **grow out of it** (dense-to-sparse annealing). A wiki reading: load balance is not a systems detail imported from distributed training, it is the [[wiki/concepts/representational-collapse.md]] problem stated over a discrete selection variable, and the four remedies are the same four families that appear wherever a discrete latent must not collapse.

---

## Scaling: the upstream/downstream dissociation

This is the row that matters most for a reasoning model, because the dissociation runs *along the reasoning axis*.

| Phase | Finding |
|---|---|
| **Upstream (pre-training)** | Consistent, large, reliable gains. GShard +13.5 BLEU at 600B; Switch 4–7× wall-clock speed-up over FLOP-matched T5; cross-entropy a power law in EPC. Gains diminish past 256 experts, and extrapolation implies no benefit past ~900B dense-equivalent — but at 130B training tokens, i.e. far off the Chinchilla-optimal token budget, so the extrapolation is unsafe |
| **Upstream, out-of-domain** | Already worse: Artetxe et al. 2021 find MoE scaling much better *in-domain* than dense and materially worse out-of-domain |
| **Downstream, knowledge-heavy** | Better. GLaM beats GPT-3 (175B) zero/one-shot at 49% of the inference FLOPs and 65% less power; BIG-Bench measures ~2× improvement over FLOP-matched dense across 161 tasks |
| **Downstream, reasoning-heavy** | **Worse at matched pre-training perplexity.** A 1.6T/2048-expert Switch model with the FLOPs of a 2B dense model fine-tunes poorly on SuperGLUE; Artetxe et al. find worse fine-tuning on HellaSwag, PIQA, Winogrande |
| **Calibration** | Sparse models match the expected calibration error of a **10× larger dense model** (BIG-Bench) — a free win the survey flags as unexplained |

**The repair, and it is a design rule.** Fewer, larger experts. The 1.6T/2048-expert model fine-tunes badly; the best-fine-tuning Switch variant has 128 experts and the FLOPs of an 11B dense model. GLaM (64 experts) and ST-MoE (fine-tuning state of the art, beating PaLM-540B on SuperGLUE at ~20× less pre-training and ~40× less inference FLOPs) both sit at ≤64 large experts. **Read as a statement about capacity: extra parameters at fixed FLOPs buy knowledge, and reasoning is bought by FLOPs.** Sparsity trades exactly the resource that reasoning needs, and the trade is only favourable up to a point that current practice puts near 64 experts.

**(brainstorm) The obvious consequence for this wiki has not been tested anywhere in the literature the survey reviews.** Every reported evaluation routes *tokens*. Nothing routes a **step of a computation** — and the reasoning deficit is precisely what one would predict if the router's granularity is wrong: a token is not a unit of reasoning, so a per-token expert choice cannot allocate parameters to a *sub-problem*. The cheap test is an expert-choice router over the hidden states of a chain of intermediate steps rather than over tokens, scored on a task where step identity is known ([[wiki/concepts/refinement-loop.md]]).

---

## Expert specialisation is real, shallow, and readable

The survey's strongest claim for the wiki is not about efficiency: **a sparse expert model publishes a small set of integers per input**, so its internal decomposition can be read off without interpreting any weights ([[wiki/concepts/representation-probing.md]]).

| Model | Observed specialisation | Depth of the concept |
|---|---|---|
| Shazeer 2017 (2048 experts, WMT EnFr) | Words around *innovation*; the article "a"; synonyms of *speed* | Mixed — one semantic field, one function word |
| BASE Layers | Quantities/numbers (`year, years, billion, millions, tonnes`), possessives, subword fragments, verb clusters, single-letter tokens | Lexical class, keyed on the **preceding** token |
| ST-MoE (encoder–decoder) | Sentinel tokens, punctuation, conjunctions & articles, verbs, colour/spatial visual descriptors, proper names, counting | Mostly shallow; **clear in the encoder, unclear in the decoder** |
| LIMoE (multimodal) | Textures (solid, striped), plants, hands, eyes, wheels, door handles, words | Spans basic texture → high-level object, and separates modalities |

Three qualifications the survey states plainly and the wiki should carry: (1) the specialisation is overwhelmingly **lexical/perceptual, not relational** — no expert in any reported study specialises in a *relation* or a *rule*; (2) the analyses read the identity of the routed token, but the embedding already carries context from self-attention, so any *contextual* specialisation is invisible to the method used; (3) the decoder's apparent lack of specialisation "may either signal a difficult to discern pattern or no useful pattern", which is undecided.

**(brainstorm) This is the wiki's cheapest available handle on [[wiki/concepts/emergent-modularity.md]].** That page's claim is that modules are the *output* of a process, not an input to it. A sparse expert model is the one architecture here in which that claim is directly measurable: the modules are enumerated by construction, the assignment is a discrete integer per input, and the question "did a module for X emerge?" reduces to a contingency table between expert id and any labelling of the inputs. The finding to date — modules emerge, and they are lexical rather than relational — is a *negative* result for the hypothesis that relational structure will fall out of scale plus a routing bottleneck.

---

## Instability, and where it comes from

Sparse models diverge more often, and more often at scale (GShard at 1T with bfloat16; Switch-XXL; ST-MoE multilingual; LIMoE multimodal). The catalogue of fixes is informative because every one of them targets the **router**, not the experts:

| Fix | Mechanism |
|---|---|
| float32 for the router only (Switch) | The routing softmax is where roundoff decides a discrete outcome |
| **Router z-loss** (ST-MoE) | Penalise large router logits directly — keeps the softmax out of its saturating regime, and *improves quality* as well as stability |
| Smaller initialisation scale (Switch); expert-gradient scaling by `1/√E` (Artetxe et al.) | Each expert sees batch `B/E`, so its gradient statistics are not those of a dense layer of the same shape |
| Skip NaN/Inf batches, restart from checkpoint (GLaM) | Not a fix, a containment |

**The common cause is that a continuous score is being used to make a discrete decision.** Small numerical perturbations flip an argmax, which changes which parameters receive gradient, which changes the score — a positive-feedback path that dense models do not have. The same structure recurs anywhere a discrete latent is trained by a relaxation (Gumbel-softmax temperature, ignition thresholds in [[wiki/concepts/ignition.md]]), and the router z-loss is the cheapest known instance of the general remedy: **regularise the logit scale, not the decision**.

---

## Reading in the core framing

| This page | Latent-graph reading |
|---|---|
| The router | A learned function from an observation to a **node of the meta-graph** — the selection `G12` asks for, at token granularity and with no notion of structure type |
| Experts | Subgraphs given dedicated parameters; the wiki's only architecture where the partition is declared up front and the *contents* are learned |
| Load balance | A prior forcing the discovered partition to be uniform in mass, which is a strong and probably wrong assumption about any real structure distribution |
| Token-granularity routing | The reason the reasoning deficit is unsurprising: the routed unit is not the unit over which the graph is defined |
| Expert-choice routing | Adaptive computation obtained for free — the number of experts a token receives is an emergent per-input compute budget, and is the only mechanism in this literature that varies compute rather than parameters |

---

## Open problems

- **`T296`: whether the router must be learned at all.** Hash Layers' random fixed routing is competitive; THOR's uniform-random selection *beats* learned routing by 2 BLEU. If a learned router's advantage over a fixed partition is small, then everything the wiki wants from routing — structure-type selection, context-sensitivity — is not what these models' routers are doing.
- **No relational expert has ever been observed.** Every reported specialisation is lexical, perceptual or modality-level. Whether this is a limit of the routing granularity, of the interpretability method (which cannot see contextual specialisation), or of the objective, is unseparated.
- **Optimal expert count and size are unknown as a function of task**, and known to point in opposite directions for pre-training (many small) and transfer (few large). No theory predicts the crossover.
- **Calibration improving by 10× effective FLOPs is unexplained**, and would be worth a great deal in this wiki ([[wiki/concepts/certification-instruments.md]]) if the mechanism were known — a plausible but untested account is ensembling over the `k` selected experts.
- **Heterogeneous experts are unattempted.** Every deployed system uses identical experts for hardware reasons; experts differing in depth or width would make the routing decision an adaptive-computation decision as well as a parameter decision.
- **The parametric/non-parametric boundary is unmeasured.** Sparse experts and retrieval expand capacity by the same amount for the same reason, one in weights and one in a corpus, and no work reported here trades them off against each other.

---

## Connections

- **[[wiki/concepts/attention.md]]** — the same softmax selection with the target changed: attention selects over *inputs* and leaves the parameters fixed, a router selects over *parameters* and leaves the input fixed, and both are `softmax(W x)` over a set — which is why the router inherits attention's saturation problem and needs the router z-loss where attention needs `1/√d_k`.
- **[[wiki/concepts/emergent-modularity.md]]** — the one architecture in the wiki where that page's central claim is directly measurable: experts are enumerated modules whose assignment is a readable integer, and the measured outcome so far is that emergent modules are lexical and perceptual, never relational.
- **[[wiki/concepts/integration-segregation-balance.md]]** — supplies the actuator that page says is missing, and shows why it is not enough: a top-`k` router *is* a dispersion knob over modules, but `k` and the capacity factor are design-time constants, so the routing dispersion cannot be moved by task demand the way the brain's participation coefficient is.
- **[[wiki/entities/transformer.md]]** — the host: sparse expert layers substitute for the feed-forward block at a frequency of 0.25–1.0, and Switch found the same substitution on the `q`/`k`/`v` projections materially more unstable, which localises where conditional parameters can be inserted.
- **[[wiki/concepts/representation-probing.md]]** — routing makes probing unnecessary for one question: the expert assignment is already a discrete label per input, so the model's internal partition is read directly rather than decoded — though the survey's own caveat, that the routed embedding already carries self-attention context, means the *contents* of that partition still need probing.
- **[[wiki/concepts/representational-collapse.md]]** — load balance is collapse over a discrete selection variable: without a penalty, an assignment, or a structural constraint, a favoured expert receives more tokens, trains faster and is favoured more, which is the rich-get-richer path in its cleanest form.
- **[[wiki/concepts/continual-learning.md]]** — the modularity end of this literature is a continual-learning proposal: DEMix trains one expert per pre-training domain and selects by domain matching, Branch-Train-Merge makes each expert a *fully independent* language model trainable asynchronously and composable after the fact, and Aljundi-style setups add experts over time — all of which buy forgetting-freedom by never sharing parameters, at the cost of never sharing them.
- **[[wiki/concepts/policy-abstraction-hierarchy.md]]** — the biological alternative to routing, and it is the opposite design: frontal cortex engages *all* orders of rule from the first trial and attenuates the unrewarded ones, where a top-`k` router commits before computing, so the brain's answer to "which module" is run-all-and-prune and this literature's is select-then-run.
- **[[wiki/concepts/ignition.md]]** — the same discrete-commit problem with the opposite failure mode: an MoE router commits every layer for every token with a threshold-free argmax, so it can never fail to publish, where ignition has a threshold and can, and the router z-loss is what a threshold-free commit needs in place of a criterion.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the router is a candidate answer to the navigation half at the wrong granularity: it maps an observation to one of `E` parameter sets, which is node selection over a flat, uniformly-weighted, learned partition — no structure among the experts, no edges, and a load-balance prior that forces the partition to be uniform in mass.
- **[[wiki/concepts/refinement-loop.md]]** — the granularity fix this page's central deficit points at: every sparse expert model routes *tokens*, and its measured weakness is precisely on reasoning-heavy transfer, which is what one predicts if the routed unit is not the unit over which the problem decomposes — routing a step of a refinement loop rather than a token is the experiment nobody has run.
