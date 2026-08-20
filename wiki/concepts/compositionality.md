# Compositionality

**New representations are constructed by combining primitive elements, so a finite vocabulary generates an infinite set of representable things — and a new concept costs only the *arrangement*, because the parts already exist (Lake et al. 2017).**

In the core framing ([[wiki/concepts/latent-graph-discovery.md]]) compositionality is what makes the meta-graph *productive*: the shared level stores primitives, sub-parts, parts and relations, and an instance-graph is a particular arrangement of them. This is why instantiation can be binding rather than learning — the hierarchy `primitives → sub-parts → parts → object template → exemplar` is a re-use ladder, and only the top rung is new per concept ([[wiki/entities/bayesian-program-learning.md]]).

> **Provenance.** Lake, Ullman, Tenenbaum & Gershman 2017 (`raw/lake-2017-machines-learn-think-like-people.md`), which names compositionality as one of three ingredients of rapid model building, alongside causality ([[wiki/concepts/causal-model-building.md]]) and learning-to-learn ([[wiki/concepts/meta-learning.md]]). The composition *problem* — how outputs of separate modules are joined at all — is stated on [[wiki/concepts/core-knowledge.md]] and gaps G21–G22; this page is about composition *within* a vocabulary, which is the tractable half.

---

## The formal claim

| Property | Statement | Consequence for a model |
|---|---|---|
| **Productivity** | An infinite number of representations from a finite set of primitives — infinitely many thoughts, sentences, concepts (Fodor 1975; Fodor & Pylyshyn 1988; Marcus 2001; Piantadosi 2011) | The concept space is *generated*, not enumerated; the learner searches programs, not points |
| **Partonomy** | Parts compose from sub-parts, forming a part-whole hierarchy (Miller & Johnson-Laird 1976; Tversky & Hemenway 1984) | Recursion in the representation, so depth is a free parameter rather than an architecture choice |
| **Efficient description** | A function hierarchy compactly describes higher-level functions, like a part hierarchy for a complex scene (Bienenstock, Geman & Potter 1997) | The MDL argument of the two-level hierarchy, restated: `\|primitives\| + N·\|arrangement\|` beats `N·\|concept\|` |
| **Structural description** | A visual concept is a composition of *parts and relations* — two wheels joined by a platform, supporting a post, holding handlebars (Biederman 1987; Marr & Nishihara 1978; Winston 1975) | Relations are first-class content, not implicit in a feature vector — the edge set, made explicit |
| **Coherence is missing** | Free combination of parts is not enough; a composition must hang together. "Compositionality and learning-to-learn provide the parts, causality provides the glue" | A composer needs a second, non-combinatorial criterion — see below and gap G22 |

**Where compositionality does *not* depend on prior learning.** Bottom-up parts-based decomposition from geometry alone (Hoffman & Richards 1984) supplies primitives without a learned library, which matters because the usual route — parts and relations reused from previously learned concepts — makes compositionality a *special case of learning-to-learn* and therefore inherits its knowledge-boundedness limit.

---

## Instantiations

| Domain | Primitives | Relations | Source |
|---|---|---|---|
| **Handwritten characters** | Pen sub-strokes → strokes | `attached along`, `attached at start`, spatial offsets | Lake, Salakhutdinov & Tenenbaum 2015 ([[wiki/entities/bayesian-program-learning.md]]) |
| **Novel objects** | Wheels, motors, handlebars, platforms | `attached`, `powered by`, `supports` | Lake et al. 2017, Fig. 1B |
| **Spoken words** | Phonemes | Sequence | Lake, Lee, Glass & Tenenbaum 2014 |
| **Actions / dance** | Primitive body movements | Sequence, simultaneity | Lake et al. 2017 |
| **Game scenes** | Object *types* (bird, fish, ice floe, igloo), each instantiated many times | Intuitive physics and intuitive psychology "as glue" | Object-oriented RL (Diuk, Cohen & Littman 2008) |
| **Latent transformations** | VQ codebook symbols with no stipulated meaning, semantics supplied by one shared executor | Sequence (concatenation only — no arity, no binding) | Baek et al. 2026 ([[wiki/entities/neo-neural-theorizer.md]]) |
| **Spatial relations in a text-only LLM** | Three direction vectors in the residual stream — `left`, `above`, `in front` — with inverses as negation (`r_right = −r_left`) | Vector addition: `µ_{above-and-right} ≈ µ_above + µ_right` at cos 0.993 / 6.0° inside a fitted 3-D subspace (0.395 / 66.7° in the raw stream) | Tehenan et al. 2025 ([[wiki/concepts/linear-representation-hypothesis.md]]) |
| **Goals** | Sub-goals defined as *reaching a given object* | Sequencing into a larger goal | Hierarchical DQN (Kulkarni et al. 2016) — the reported route to playing sparse-reward games such as Montezuma's Revenge |

The last two rows are the ones this wiki has least of: composition at the level of **object types** and at the level of **goals**, rather than at the level of visual parts. Both give the same economy — many repetitions of one type share one model — and the goal row is the only cited mechanism in the source for making delayed sparse reward tractable, which is gap G20's problem approached from the representation side rather than from the update rule.

---

## What deep networks have, and what they lack

| Present | Absent |
|---|---|
| Part-like features in deeper layers; new object types activate novel combinations of feature detectors (Zeiler & Fergus 2014) | Explicit representations of **objects, identity, and relations** |
| Convolutional invariance makes repeated instances of one object share features | A notion of **coherence** over novel configurations |
| Neural networks used for efficient inference in structured generative models that explicitly represent *the number of objects in a scene* (Eslami et al. 2016) | Composition at the level of goals, except where sub-goals are hand-defined over given object representations |
| Differentiable programming: stacks, queues, random-access memory folded into gradient-based learners (Neural Turing Machine, Differentiable Neural Computer — [[wiki/entities/differentiable-neural-computer.md]], Neural Programmer-Interpreter) — "genuine programs, albeit in a representation more like assembly language" | The programs learned are algorithms over data structures, not causal models of a domain ([[wiki/concepts/working-memory.md]]) |

**The same failure, now with paired-image controls and a decade of scale behind it** (Bordes et al. 2024, [[wiki/concepts/cross-modal-grounding.md]]). Vision-language models trained on 400M–1.8B image–caption pairs name objects at or above supervised-ImageNet level and fail the arrangement:

| Instrument | Design | Result |
|---|---|---|
| **Winoground** | Two images, two captions differing *only in word order* ("some plants surrounding a lightbulb" / "a lightbulb surrounding some plants"); both pairings must be scored | Fails — and the failure is the field's standing puzzle |
| **ARO** | Negatives by swapping relation, attribute or order ("A horse eating grass" → "grass eating a horse"); no negative *image* | Fails, but the design admits a language-prior shortcut |
| **PUG** | Synthetic scenes built one element at a time — background, then animal, then the animal moved left or right | **Not better than random chance on spatial relations**, with object recognition in the same scenes intact |

The third row is the one that closes the argument: because the scene is rendered twice with a single relation changed, "did not recognise the object" is excluded by construction, so the deficit is localised to the relation slot and nowhere else. **Objects are nodes and they bind; relations are edges and they do not** — at any scale yet tried, through any of the four training paradigms.

**The diagnostic failure.** A caption network gets the objects in a scene right and their causal relations wrong (Lake et al. 2017, Fig. 6 — a man being thrown off a horse captioned "a woman riding a horse on a dirt road"; a crashed airplane captioned "an airplane is parked on the tarmac"). Objects without relations is exactly the signature of a feature-set model: the parts are recovered, the arrangement is not represented at all, so the caption defaults to the arrangement most frequent in training. This is [[wiki/concepts/shortcut-learning.md]] localized to the relation slot.

---

## Reading in the core framing

| Compositional element | Latent-graph reading |
|---|---|
| Primitive library | The meta-graph's node and edge vocabulary — hardness source 2, if it must be induced; given, if it is installed ([[wiki/concepts/core-knowledge.md]]) |
| Parts and sub-parts | Intermediate nodes; the partonomy is a path in the generative hierarchy |
| Relations between parts | The typed edges the whole framing is about, appearing here inside a single concept rather than between states of the world |
| A concept = an arrangement | An instance-graph over the shared vocabulary — one-shot because only the arrangement is new |
| New concept from related concepts | Meta-graph reuse under a *different* binding — the operation [[wiki/concepts/meta-learning.md]] optimizes for |

**(brainstorm)** Compositionality sharpens gap G10 (unreliable self-generated intermediate nodes) into something testable. If a concept is a program over parts, then the model can be asked to *parse* — to emit its own intermediate structure — and the parse can be scored against human parses, which the character work does directly (Lake, Salakhutdinov & Tenenbaum 2012). Parsing is therefore a cheap probe for whether a model's intermediate nodes are real: a model that classifies well and parses badly has features, not parts. That is a G17-class instrument that needs no distribution shift, only a second query against the *same* representation. **This has now been built** — OTIB's support/query protocol is exactly a second query against the same representation, and the model that scores 0.994 on the first and 0.000 on the second is the wiki's cleanest demonstration that fit and structure are separable measurements ([[wiki/entities/neo-neural-theorizer.md]]).

---

## Bases that come pre-credit-assigned, and when factorisation stops paying

The hippocampal-formation models supply a vocabulary of *spatial* bases and one strong claim about what composition is for (Whittington et al. 2022).

| Basis type | Cells | Property |
|---|---|---|
| **Local bases** | Object-vector, border-vector, reward and goal-vector cells | Code *any* object/border/goal, irrespective of where it is — a slot with a free filler |
| **Global bases** | Grid cells | Describe information equally across the whole space |

Two exports:

**1. Composition can carry value, not just structure.** If a goal-vector basis is learned with a policy or value already attached, then a new goal configuration is handled by composing bases rather than by learning — the only online work is *inferring which bases apply*. Credit assignment becomes a retrieval-and-compose problem ([[wiki/concepts/cognitive-map.md]]). What makes this possible is that the bases path-integrate: one instance at the goal generates the rest for free ([[wiki/concepts/path-integration.md]]).

**2. Factorisation is a trade-off with a predicted switch.** Grid cells were thought factorised from everything non-spatial, but they *warp* toward consistently rewarded locations — and a warped code is by definition environment-specific, so it does not transfer. The proposed rule:

> When the set of tasks an animal faces is itself factorised, the representations for those tasks will be factorised; when task components always co-occur in the same combination, a bespoke entangled code is cheaper.

Storing one warped representation beats storing and combining many bases *if you never switch tasks*. This is the first statement in the wiki that compositional representation has a **cost** and that a non-compositional code can be the correct answer — and it makes a falsifiable prediction (vary how often reward configurations change; watch grid warping appear and disappear). Nothing controls this knob in a machine (gap G40).

**3. Where the knob has been read off a brain, it is set to *factorise*.** Zheng et al. 2024 put two relational structures over one set of objects — a transition graph learned the previous day, and lifetime semantic taxonomy — and found both mapped in the hippocampal formation with **non-overlapping** clusters (semantic posterior, transition anterior; each effect ≈ 0 in the other's region of interest), with no conjunctive code detectable ([[wiki/concepts/cognitive-map.md]]). The conditions are the ones rule 2 says should favour *entangling*: the two structures always co-occur (they are carried by the very same items, on every trial), and no task ever required either. The brain factorises anyway. Two readings, and they price the rule differently:

| Reading | Statement | What it would mean for a builder |
|---|---|---|
| **Factorisation is the default, entangling is the exception** | Rule 2's switch fires only for a specific pressure (a reward configuration held constant), and absent that pressure separate structures stay separate | Cheap: default to factored, and warp only under a detected constant | 
| **The rule's argument is acquisition, not co-occurrence** | The two structures differ in *mode and timescale of acquisition* (implicit/one day vs explicit/a lifetime) — the source's own framing — so what recombines across episodes is the acquisition process, not the content | Expensive: the controller must key on *how* a structure was learned, a variable no machine architecture records |

Neither is testable in the design, because the confounds are total (recency, explicitness, relation type and consolidation stage all covary). What the result does settle is the direction of the null hypothesis: a single embedding whose metric mixes all available relations over an item is not what the biological system builds, so an architecture that learns one distance function per entity is not the conservative choice.

---

## Open problems

- **Coherence has no operational definition.** "Causality is the glue" names the requirement without saying what computes it. The wiki's only mechanised candidate is composition-as-relaxation to a joint free-energy minimum, where a composition that has no low-energy state is simply never built ([[wiki/concepts/predictive-coding-free-energy.md]], gap G22).
- **Where does the primitive library come from?** Every instantiation above except the last uses a hand-specified or pre-trained primitive set. Bottom-up geometric decomposition is the only *cited* route that does not, and it is restricted to shape. **The wiki now has one worked answer**: fit the vocabulary and one shared execution operator jointly to raw observation pairs, and primitives that never appear in isolation are still recovered (primitiveness 1.000 at 33% composition coverage, [[wiki/entities/neo-neural-theorizer.md]]) — in synthetic domains, with ≤8 primitives, and with the pressure supplied by two terms nobody would have predicted: a decode–encode consistency loss on *intermediate* states, and a simplicity weight that destroys the vocabulary if set 20% too high.
- **Compositionality of goals is barely explored.** Sub-goals in hierarchical DQN are defined *by the experimenter* over object representations that are also given. Nothing induces the sub-goal vocabulary.
- **The cheapest possible composition operator has now been *found* rather than built, and it is addition.** A 3B language model nobody trained for it holds spatial relations as directions whose sums approximate the directly-learned composites, with opposites as negations — i.e. a finite primitive set generating unseen arrangements by vector arithmetic, which is this page's productivity claim with the arrangement operator costing zero parameters. Three caveats keep it from being a mechanism: the additivity holds only after projection onto a fitted 3-D subspace ([[wiki/empirical-tensions.md]] T159); the composed direction is never steered, so composition is a geometric observation while only the *atomic* relations are shown causal; and the composites tested (`above and right`) do appear in the training corpus of English, so this is composition *observed*, not composition *generalised* to a held-out arrangement — the length-OOD test OTIB runs has no counterpart here.
- **Systematicity is not tested, and the benchmarks that try are scoreable by a collapsed model.** Winoground/ARO/SUGARCREPE-style tests are binary discriminations resolved by `argmax`, which does not handle ties — so a model whose parameters are all zero, assigning both captions the same representation, wins every item where the correct caption is listed first (Bordes et al. 2024). Any published compositionality number produced without a tie check is uninterpretable, and the fix is an epsilon of noise ([[wiki/concepts/cross-modal-grounding.md]]).
- **Systematicity is not tested.** Being able to represent "X prefers Y" does not guarantee "Y prefers X" (Fodor & Pylyshyn 1988), and no benchmark in the wiki checks the symmetric case — so "architecture X composes" remains unfalsifiable ([[wiki/concepts/core-knowledge.md]], open problems). **Productivity now is** (OTIB's length-OOD split: compose 4–8 primitives having trained on 1–3), and the *instrument* generalises further than its benchmark — induce a structure from a support pair, execute it on a query pair, and the gap between the two scores separates "fits this instance" from "recovered the mechanism" with one number ([[wiki/entities/neo-neural-theorizer.md]]). That is the G17-class probe this page's brainstorm asked for, in a machine, and it says nothing about the symmetric case.
- **Compositionality and learning-to-learn are entangled.** Parts and relations are themselves products of previous learning, so the sample-efficiency credit assigned to compositionality may belong to the pre-training that supplied the parts.

---

## Connections

- **[[wiki/concepts/latent-graph-discovery.md]]** — supplies the productivity of the meta-graph: a finite installed vocabulary generates an unbounded set of instance-graphs, which is why binding can be one-shot.
- **[[wiki/concepts/causal-model-building.md]]** — the paired ingredient: composition supplies the parts, causality supplies the coherence criterion that decides which arrangements are legal, and neither is sufficient alone.
- **[[wiki/concepts/meta-learning.md]]** — compositionality is *what* learning-to-learn transfers when it works: the transferred object is a library of parts and relations, not a weight initialization, and the source claims transfer is weak in deep networks precisely because the representation is not compositional.
- **[[wiki/entities/bayesian-program-learning.md]]** — the worked instantiation: a five-level compositional hierarchy over pen strokes, with one-shot human-level classification as the result.
- **[[wiki/concepts/core-knowledge.md]]** — the installed-vocabulary case, and the harder problem this page brackets: composing *across* encapsulated modules with different formats (gap G21), as opposed to composing within one vocabulary.
- **[[wiki/concepts/shortcut-learning.md]]** — the caption failure (objects right, relations wrong) is a shortcut localized to the relation slot: a model with no explicit relation representation defaults to the most frequent arrangement in training.
- **[[wiki/concepts/simulation-based-planning.md]]** — constructive recombination, listed there as a property machines lack, *is* compositionality applied to imagined scenarios; a planner cannot recombine what the representation does not factor.
- **[[wiki/concepts/working-memory.md]]** — differentiable programming (external memory, stacks, queues) is the machine-learning route to composition over data structures, and the source's candidate for uniting program induction with gradient learning.
- **[[wiki/concepts/abstract-structural-codes.md]]** — a part-relation description is content-invariant by construction: the same relation set applies to wheels, strokes or ice floes, which is what a structural code `g` is supposed to give.
- **[[wiki/concepts/predictive-coding-free-energy.md]]** — the one mechanised proposal for coherence: hold two encodings active and let mutual constraint satisfaction settle, so compositions with no low-energy state are never formed.
- **[[wiki/entities/arc-agi.md]]** — makes compositional reuse the *evaluation criterion*: the proposed solver searches a domain-specific language and recombines sub-programs that worked on earlier tasks, so scoring well requires the productivity this page describes rather than merely exhibiting it.
- **[[wiki/concepts/energy-based-models.md]]** — composition of *goals* is free where composition of modules is not: cost terms combine by addition of energies, so several simultaneous constraints form one objective without any binding mechanism.
- **[[wiki/concepts/intelligence-density.md]]** — makes composition constitutive rather than instrumental: meaning over a domain *is* the correct selection and ordering of primitive functions, so a system that generalizes necessarily holds a compositional arrangement, and syntax fails to be semantics exactly when the arrangement does not generalize.
- **[[wiki/concepts/subgraph-matching.md]]** — composition dictating a training schedule: subgraph containment composes across message-passing layers, so a matcher must be trained on monotonically growing queries (+6% AUROC, lower variance) rather than on the full distribution at once (Ying et al. 2020).
- **[[wiki/concepts/contextual-inference.md]]** — the counterexample that shows retrieval and composition are separable: it gets allocation and graded retrieval over an unbounded memory library right while the memories remain exchangeable atoms with no internal structure to compose (Heald et al. 2021).
- **[[wiki/concepts/path-integration.md]]** — a second, algebraic kind of composition: actions compose by addition with closure enforced by the update rule, which is the only case in the wiki where a composition's coherence is guaranteed rather than checked.
- **[[wiki/concepts/successor-representation.md]]** — the default-representation variant composes at the level of cell types (grid × border to represent an inserted barrier) with no retraining, which is composition of *state-space bases* rather than of concepts.
- **[[wiki/entities/tolman-eichenbaum-machine.md]]** — learns factorised entorhinal bases from next-observation prediction, and marks the boundary: space and task were learned in one fixed pairing, so a T-maze-to-W-maze change breaks it.
- **[[wiki/concepts/cognitive-map.md]]** — the one measurement of this page's factorise-vs-entangle knob in a brain: two relational structures over the same objects are held in separate hippocampal territory rather than fused, which sets the default to factored and leaves *what selects between them* unaccounted for (Zheng et al. 2024).
- **[[wiki/concepts/distributed-reference-frames.md]]** — a third kind: an object-anchored frame makes a feature's position *relative to the object* the reusable unit, so a part-whole description carries a metric with it, and recognition is a consensus rule over many such descriptions rather than a single parse.
- **[[wiki/concepts/inhibitory-control-of-coding.md]]** — a mechanism for the factorise-vs-entangle decision (G40) that costs no new representation: two inhibitory channels with different fan-in widths over one excitatory population, the broadly-innervated one (*Pvalb*, *Sst*) averaging over contexts and enforcing generalization, the sparsely-innervated one (*Id2*) inheriting context specificity and enforcing splitting.
- **[[wiki/concepts/sparse-distributed-representations.md]]** — offers a disjunctive primitive the wiki otherwise lacks: a Boolean-OR union tests membership in a set of patterns without enumerating them, which is the representation a rule needs when applied to an unbounded instance set — bounded, on the numbers given, at 4–16 patterns per slot before mix-and-match errors bite.
- **[[wiki/entities/thousand-brains-theory.md]]** — part-whole description with a metric attached and a consensus rule over it: a feature's position relative to the object transfers across scenes, and an object is recognised as the unique hypothesis surviving intersection across columns at matched locations.
- **[[wiki/concepts/manifold-constrained-learning.md]]** — the recombine-versus-extend boundary drawn at the network level: new patterns *within* an existing low-dimensional basis are learnable in hours, patterns requiring new basis directions are not, which is the source's own proposed split between combinatorial and transformational creativity and makes vocabulary extension the expensive operation (Sadtler et al. 2014). Tightened one level: inside the basis the population does not even generate new patterns over hours, it re-labels existing ones with new intents, so fast learning is re-binding an existing vocabulary rather than recombining it (Golub et al. 2018).
- **[[wiki/entities/pbwm.md]]** — binding by routing: a control input decides which memory stripe an item is gated into, so the same filler reaches different slots and novel sequences generalize — and the authors' own limit (each stripe must learn to encode its fillers, each reader must learn to decode that stripe) measures exactly how far this is from a symbolic variable.
- **[[wiki/entities/differentiable-neural-computer.md]]** — the primary source for the differentiable-programming row: pointers (a memory row's content naming another row) are what let composition run over data structures, and are also why the learned program reads as assembly rather than as a causal model.
- **[[wiki/concepts/arbitrary-sensorimotor-mapping.md]]** — the layer underneath that is explicitly *not* compositional: an arbitrary cue→action edge shares no structure with any other, so it cannot be derived from parts — every compositional system needs a non-compositional binding store supplying the primitives it recombines (Wise & Murray 2000).
- **[[wiki/concepts/controller-knowledge-vs-process.md]]** — supplies a compositional format for *plans* that no sequence model here implements: a partially ordered stored event sequence commits only the necessary precedences, so two such plans interleave without either being rewritten, which total-order episodes cannot do.
- **[[wiki/concepts/control-unity-and-diversity.md]]** — supplies the network-topology numbers this page argues for without quantifying: white-matter modularity *and* global efficiency both predict control ability in the same sample, and modularity mediates its developmental rise — so the target is modular specialization plus high-bandwidth cross-module paths, both computable on any multi-module model (Friedman & Robbins 2021).
- **[[wiki/concepts/skill-acquisition-efficiency.md]]** — names the mechanism that would actually score well on a conversion-rate measure — recombining sub-programs that worked on earlier tasks, so experience amortises as reusable vocabulary rather than as data.
- **[[wiki/entities/neuromatch.md]]** — a curriculum justified by composition: the order constraint composes across message-passing layers, so query complexity has to grow monotonically during training (+6%).
- **[[wiki/concepts/temporal-abstraction-options.md]]** — the failure that names the requirement in the action domain: options cannot express the overlap between "spread jam on bread" and "spread icing on a cake", because an option is an atom with a policy attached rather than a manoeuvre composed with its arguments — so quasi-hierarchical human behaviour is evidence for factorising the *unit of skill* itself (Botvinick, Niv & Barto 2009).
- **[[wiki/entities/hami.md]]** — the cheapest possible compositional store: quantise two factors independently and pair the symbols, and novel combinations of seen components come free, with no binding operator, no variable and no recursion — which sets the floor that any richer proposal on this page has to beat (Poursiami et al. 2025).
- **[[wiki/entities/hisd.md]]** — a context-free grammar induced over *behaviour*: terminals are unsupervised skills, non-terminals are subroutines, recursive depth is emergent rather than specified, and the productivity is bought by the same digram-uniqueness invariant that makes the compression lossless — with this page's predicted failure attached, since an over-separated terminal alphabet (noisy Minecraft skills) leaves no substring to share and the grammar degenerates to one private parse per episode (Harvey et al. 2026).
- **[[wiki/concepts/affordance-grounded-symbols.md]]** — primitives grounded rather than stipulated, plus a measurable factorisation test: split the symbol code and recombine the parts, and factorise only if effect prediction is unchanged — a criterion unavailable to any objective scored on reconstruction (gap G40).
- **[[wiki/concepts/learned-world-models.md]]** — compositionality bought from an external vocabulary: factorising video generation along language primitives generalises a world model to unseen object–action combinations, which is the undergenerating horn of G22 traded for a working system (RoboDreamer, in Long et al. 2025).
- **[[wiki/entities/irene.md]]** — the complement of the caption-network failure: hand the model the relation slot for free (typed spatial edges, message passing) and objects-plus-relations still does not yield binding — a preference stays unbound to the agent that held it, at chance across every architecture and curriculum variant tried.
- **[[wiki/entities/kan-ode.md]]** — a compositional decomposition of *function space* rather than of concepts, and the wiki's clearest case of one being usable: the Kolmogorov-Arnold theorem writes any multivariate continuous function as a finite composition of univariate ones, and putting the learnable parameters in those univariate factors is exactly what makes the learned dynamics individually plottable and symbolically extractable.
- **[[wiki/entities/adaworld.md]]** — the cheapest composition mechanism in the wiki and the least tested: two induced action codes are merged by averaging them in a continuous latent space, which also does duty as *within*-action denoising over 100 samples — so the same operation is claimed to both average out variation and combine distinct meanings, on one qualitative figure.
- **[[wiki/entities/neo-neural-theorizer.md]]** — the primitive library induced rather than supplied, and the parse-based instrument this page proposed for G17 built as a benchmark protocol: transferability (support pair → query pair) scores the arrangement, not the fit.
- **[[wiki/concepts/linear-representation-hypothesis.md]]** — composition reduced to arithmetic: if primitives are directions, an arrangement is a weighted sum and an inverse is a negation, which makes this page's productivity claim a measurable angle — and supplies the caveat that the measurement is taken in a fitted subspace rather than in the space the network computes in.
- **[[wiki/concepts/program-induction.md]]** — the reduction that makes composition literal: parts are sub-programs and productivity is code re-use, so this page's criteria become the search space's closure properties.
- **[[wiki/concepts/language-of-thought.md]]** — the claim that the composition this page describes is carried by a syntax over discrete typed expressions, with productivity and systematicity as its two diagnostics (Fodor & Pylyshyn 1988).
- **[[wiki/concepts/cross-modal-grounding.md]]** — this page's relation-slot deficit measured at web scale with the confound removed: PUG re-renders one scene with a single spatial relation changed, and models that recognise every object in it score at chance on which relation holds.
- **[[wiki/concepts/retrieval-capacity.md]]** — the retrieval-side price of composition: logical operators over attributes make all `C(n,k)` subsets askable, while a similarity-ranked store can address only `(1+1/γ)^d` of them, so a rule over an unbounded instance set cannot be answered by a precomputed key per instance and must be scored jointly at query time.
- **[[wiki/entities/dinov2.md]]** — a part vocabulary emerging from an objective that never mentions parts: PCA components of patch tokens split foreground from background and then align *object parts* across pose, style and category, and patch-feature assignment matches a plane's wing to a bird's wing — structural correspondence without a compositional prior or a symbolic slot anywhere in the model.
