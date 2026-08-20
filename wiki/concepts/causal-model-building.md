# Causal Model Building

**Learning is the construction of a model that resembles, at an abstract level, the process that actually generated the data — as opposed to fitting a rule that predicts the data (Lake et al. 2017).**

This is the wiki's sharpest statement of what a "graph" is *for*. Pattern recognition treats prediction as primary; model building treats explanation as primary, and prediction as one query among many. In the core framing ([[wiki/concepts/latent-graph-discovery.md]]) the distinction is whether the recovered edges correspond to the environment's generative steps or merely to correlations sufficient for the training objective — which is exactly the difference between an intended edge and a shortcut ([[wiki/concepts/shortcut-learning.md]]).

> **Provenance.** Lake, Ullman, Tenenbaum & Gershman 2017 (`raw/lake-2017-machines-learn-think-like-people.md`). Causality is one of three ingredients of rapid model building there, with [[wiki/concepts/compositionality.md]] and learning-to-learn ([[wiki/concepts/meta-learning.md]]).

---

## The causality spectrum

Not every generative model is causal. A generative model assigns a probability distribution over data; a **causal** model's generative steps resemble the steps by which the data were actually produced.

| Position | Example | What it buys |
|---|---|---|
| Discriminative | Convolutional classifier: `P(y\|X)` | Nothing beyond the trained query |
| Generative, non-causal | Deep belief network, variational autoencoder — compelling digits by steps bearing "little resemblance to the actual process of writing" | Sampling, density; no purchase on new tasks |
| Generative, weakly causal | DRAW: recurrent generation through an *attentional window*, "only a crude approximation to the true causal process of drawing with a pen"; generalizes from one example but "too broadly, in ways that are not especially human-like" | Partial one-shot transfer |
| **Causal** | Bayesian Program Learning: a concept *is* a motor program — an abstract causal description of how to produce examples ([[wiki/entities/bayesian-program-learning.md]]) | Classification, generation, parsing, and generation of *new concepts*, from one example |

**The transferable claim:** causality is a matter of degree and it is *paid for with training data of the right type*. The deep models above were trained without access to causal data (how characters are actually produced) and without any incentive to recover the true process — so the failure is attributed to the supervision signal, not to the architecture class. That is the training-data lever of [[wiki/concepts/shortcut-learning.md]], applied to the generative process rather than to the input distribution.

---

### The counter-position: do *not* model the generative process

LeCun 2022 argues the opposite of this page's premise, and the argument is not about causality but about what a model is allowed to *ignore* ([[wiki/entities/h-jepa.md]], [[wiki/empirical-tensions.md]] T18):

- A generative model must account for every detail of its output. Carpet texture, leaves in wind and ripples on a pond are not predictable at any useful horizon, and a generative model can only handle them by pushing them into a latent variable — it cannot **discard** them, because it has no abstract representation of `y` to discard them from.
- A joint-embedding predictive architecture predicts the *representation* of `y`, so its encoder may drop unpredictable detail outright. "Generative latent-variable models are not capable of eliminating irrelevant details."
- The recommendation is therefore explicit: **advocate against generative architectures** for world models.

**Where the two positions actually collide.** They agree that prediction-of-everything is the wrong objective. They disagree about whether the surviving model must be *invertible into the generative process*: this page's richness criterion (parse, generate, create) requires an inverse that a non-generative energy function does not provide, since a JEPA "cannot easily be used to predict `y` from `x`". So the non-generative route buys abstraction at the cost of four of the six richness queries — which is either a fatal loss of the evaluation protocol or a demonstration that the protocol was over-specified, and nothing in either source decides which.

### Which data mode establishes causality

The source's five modes of information gathering (full table on [[wiki/entities/h-jepa.md]]) put a sharper edge on this page's "causal data may be unavailable" problem. Passive observation and active foveation yield correlational structure; active egomotion yields viewpoint structure. Only two modes yield causal structure, and one of them is free:

- **Passive agency** — watching *another* agent act — supports inference of the causal effects of actions with no action of one's own. This is the cheap channel, and it is the same one Bayesian inverse planning exploits. What it buys is now measured: 8 observed trajectories are enough to fix another agent's goal preferences and rationality to the point of predicting its next trial ([[wiki/entities/hbtom.md]]) — though only where the observer's *own* model of the environment's dynamics is already correct, which is precisely what passive agency does not supply.
- **Active agency** — acting oneself — is the only mode that supports causal models of one's *own* effects, and it is where the exploration/exploitation problem enters.

The stated open question is the split: how much of a world model is reachable without agency at all. That is the quantitative form of this page's causal-data problem, and no source in the wiki answers it.

---

## Analysis-by-synthesis

Perception as inversion of a generative process (Bever & Poeppel 2010; Neisser 1966; Eden 1962; Halle & Stevens 1962). The canonical cases:

| Case | Inverted process | Payoff |
|---|---|---|
| Speech | Vocal-tract movements — the motor theory (Liberman et al. 1967) | Explains acoustic variability and blending of cues across adjacent phonemes, which a direct acoustic classifier must absorb as noise |
| Characters | Pen strokes, sub-strokes, relations | One-shot classification at human level; parses match human parses |
| Scenes / games | The game engine that produces the frames | Inference = explaining pixels as objects and their interactions (agent steps on floe ⇒ floe deactivates) |

**Inversion need not be literal.** Causality "does not have to be a literal inversion of the actual generative mechanisms" — the character model treats concepts as motor programs, not as configurations of specific muscles. The requirement is abstract-level correspondence, which is what makes the criterion usable for a machine that does not share the generator's hardware.

---

## Causality as the glue

Why some features stick to a concept and others wash away, even when equally applicable (Murphy & Medin 1985):

| Phenomenon | Explanation |
|---|---|
| "Flammable" attaches to wood, not to money, though true of both | Causal role derived from the *function* of the object |
| "Can fly", "has wings", "has feathers" co-occur; other equally frequent triples do not | A deeper common cause binds them |
| The causal network among a category's features changes how people categorize new examples (Rehder 2003; Rehder & Hastie 2001) | The category is the causal structure, not the feature list |
| How you *learn to write* a novel character changes later perception and categorization of it (Freyd 1983, 1987) | The acquired generative process is part of the recovered concept |

The last row is the strongest of these for a machine: it is behavioural evidence that the representation retains the *production* process rather than the product, and it is directly testable in a model (train two systems on identical images with different stroke-order supervision; the representations should differ).

---

## The richness criterion

A concept is not a classifier. On the source's account, acquiring a concept delivers a bundle of abilities "for free", and they "hang together" (Solomon, Medin & Lynch 1999; Markman & Ross 2003):

| Query | Character version | Frostbite version |
|---|---|---|
| Classify | Recognize new instances from one example | Recognize game objects |
| Generate | Draw new examples | Play |
| Parse | Decompose into parts and relations | Segment the screen into objects and interactions |
| Create | Generate *new concepts* in the style of an alphabet | Invent game variants |
| Explain / communicate | Say what the concept is | Teach a friend to play |
| Re-goal | — | Play for any of ~11 arbitrary new goals (lowest score, closest to 300 without going over, touch every floe once, die as fast as possible) with little or no retraining |

**This is an evaluation protocol, and the wiki needs one** (gap G17). It certifies structure *without* a distribution shift: hold the model fixed, issue queries it was not trained on, and count which ones it answers. A shortcut rule is by construction a mapping to one output type, so it fails every row but the first. Its weakness is the mirror of its strength — it detects the *absence* of a model but a system trained multi-task on all six queries could pass without any of them coming "for free".

---

## Quantitative evidence for the model-building gap

| Comparison | Number |
|---|---|
| DQN on Frostbite vs. professional gamer | 200M frames ≈ **924 hours** of game time (plus ~8× experience replay) for <10% of human score; the human had ~2 hours. Improved variants reach 83% and 96%, still after hundreds of hours; at 2 hours they are near random play (~1.5%) |
| Humans on Frostbite | Better-than-chance within minutes; two of the authors matched or beat the professional's score after **15–20 minutes**, having watched ~2 minutes of expert play on video |
| Transfer (Actor-mimic) | Pre-train on 13 games (~4M frames each ≈ 18.5 h/game); new games then reach in 1–2M frames what took 4–5M — still orders of magnitude above human |
| AlphaGo vs. Lee Sedol | 28.4M expert positions + ~100M self-play games, vs. ~**50,000** games in Lee's lifetime |
| One-shot characters | People classify a novel character from **one** example; deep convolutional classifiers pre-trained on 5 alphabets have ~5× the human error rate (23% vs 4%), ~2–3× after 30 alphabets |

**The rebuttal, and the reply.** Objection: the comparison is unfair because humans arrive with vast prior experience. Reply: agreed — and that *is* the claim. "People never start completely from scratch, and that is the secret to their success." The research question is then not "why is the network slow" but **"what form does prior knowledge take, and how is it constructed?"** — which is the wiki's meta-graph question with the sample-efficiency argument attached.

---

## Why not just scale

The source's argument against expecting causal structure to emerge from more data and compute, stated as a claim about *search space* rather than about capacity:

- Evolution can build the ingredients, by massively parallel stochastic hill-climbing over millions of years with innumerable dead ends — so their existence is not mysterious.
- But that search explores **structural variations in architecture**, and "gradient-based learning in weight space is not prepared to do" that.
- Architecture innovation is currently performed by *researchers*, not algorithms: "exploration and creative innovation in the space of network architectures have not yet been made algorithmic."
- If it were made algorithmic (genetic programming, structure search), its dynamics "may look much more like the slow random hill-climbing of evolution than the smooth, methodical progress of stochastic gradient descent."

Recorded as gap G29. Note this is the wiki's third distinct argument that the target cannot be reached by optimizing a fixed model: the identifiability argument ([[wiki/concepts/shortcut-learning.md]] — the intended rule is not a function of the data), the compressibility argument ([[wiki/concepts/universal-induction.md]] — the shortest program need not expose structure), and now the search-space argument.

---

## Open problems

- **No procedure grades causal fidelity.** The "causality spectrum" is stated with examples at each end and no measure in between, so "model A is more causal than model B" is currently a judgement call.
- **Causal data may be unavailable.** The character result depends on stroke-order data. For most domains the generative trace is not observable, and nothing says how much causal structure survives when only the products are seen.
- **Discriminative causal-direction learning does not scale to hierarchies.** Data-driven causal-direction classifiers (Lopez-Paz et al. 2015) outperform prior methods on pairwise tasks, but "it is unclear how to apply the approach to inferring rich hierarchies of latent causal variables" — which is the only case the wiki cares about.
- **Explanation vs. compression.** Model building is defined against prediction, but a model that explains is also one that compresses; nothing here separates the two, and [[wiki/concepts/universal-induction.md]] says the shortest program need not be the causal one (gap G26).
- **The richness criterion may be gameable.** Multi-task training on all six queries would pass the protocol without any of the abilities being consequences of a single underlying model.

---

## Connections

- **[[wiki/concepts/latent-graph-discovery.md]]** — states what the discovered edges are supposed to *be*: steps of the generative process rather than sufficient predictors, which is the difference between an intended edge and a spurious one.
- **[[wiki/concepts/compositionality.md]]** — the paired ingredient: composition supplies the parts and causality supplies the coherence that makes an arrangement legal rather than merely possible.
- **[[wiki/concepts/shortcut-learning.md]]** — the same distinction from the failure side: a shortcut is a non-causal generative story that fits; this page adds that the fix is partly a *training-data* lever, since the models criticized were never given causal data or an incentive to recover the process.
- **[[wiki/entities/bayesian-program-learning.md]]** — the worked causal model: concepts as motor programs, evaluated by the richness criterion rather than by classification accuracy alone.
- **[[wiki/concepts/simulation-based-planning.md]]** — a causal model of a domain is precisely the environment model a planner rolls out, and the re-goaling row of the richness criterion is the flexibility only model-based control supplies.
- **[[wiki/concepts/amortized-inference.md]]** — the cost side: causal models are expensive to invert, and amortization is the proposed route to using one in real time.
- **[[wiki/concepts/core-knowledge.md]]** — intuitive physics and intuitive psychology are the two earliest causal models, and the source treats extending them into other domains as the primary job of learning.
- **[[wiki/concepts/universal-induction.md]]** — the formal counterweight: the provably sufficient bias selects the *shortest* program, not the causally faithful one, so simplicity and causal fidelity can come apart.
- **[[wiki/concepts/meta-learning.md]]** — learning-to-learn is claimed to transfer well only over causal, compositional representations, which makes causal structure a precondition for the transfer meta-learning is supposed to deliver rather than an independent ingredient.
- **[[wiki/concepts/predictive-coding-free-energy.md]]** — the rival account of the same target: a generative model inverted continuously by residual minimisation, where "causal" is not a separate criterion but a consequence of predicting one's own sensorimotor consequences.
- **[[wiki/entities/h-jepa.md]]** — the direct rival: it argues *against* generative world models precisely because they cannot discard unpredictable detail, which trades this page's richness queries for the ability to abstract (T18), and its five data-gathering modes say which kinds of experience can establish causal structure at all.
- **[[wiki/concepts/neuroscience-ai-transfer.md]]** — supplies the reverse constraint on that channel: cognitive plausibility as the surer foundation, with biological plausibility claims judged too under-determined to rule mechanisms in or out.
- **[[wiki/entities/hbtom.md]]** — the passive-agency channel quantified: inverting a planner over another agent's trajectories recovers its utilities without acting, and the model's own hand-written dynamics show what that channel does *not* deliver.
- **[[wiki/concepts/affordance-grounded-symbols.md]]** — the cheapest source of the causal training data this page says fidelity has to be paid for: an effect predictor's inputs *are* interventions, so grouping situations by intervention response yields categories carved causally rather than perceptually (Taniguchi et al. 2023).
