# Core Knowledge

**A small set of innate, domain-specific systems of abstract concepts — each with a defined input condition, a defined subset of entities it applies to, and its own principles — which guide learning top-down from the start rather than being abstracted bottom-up from sensation.**

Core knowledge is the concrete content of the **architecture lever** ([[wiki/concepts/shortcut-learning.md]], gap G16): where the wiki has so far said only "the intended solution must be paid for with inductive bias", this page names a specific, enumerated, empirically defended set of priors that biology already pays for. In the core framing it is a **pre-installed partial meta-graph** — node types, edge labels and constraints fixed in advance, so instance binding can be one-shot.

> **Provenance.** Two sources. **Spelke & Kinzler 2007** (`raw/spelke-2007-core-knowledge.md`) is the primary statement: four core systems — objects, agents, number, geometry — plus a *candidate* fifth for social partners, each identified by its **signature limits**. **Revencu & Csibra 2023** is a critical commentary on Spelke's *What Babies Know*, vol. 1 (2022), reporting a later six-system inventory and the composition argument; claims attributed to **Spelke 2022** are second-hand through it. Where the two inventories differ, both are carried and the divergence is logged under open problems.

---

## The systems

| System | Applies to | Core principles | Signature limit (Spelke & Kinzler 2007) |
|---|---|---|---|
| **Objects** | Mid-sized bodies that move cohesively — *not* sand piles or liquids | **Cohesion** (move as connected bounded wholes), **continuity** (connected, unobstructed paths), **contact** (no interaction at a distance) | ~3 objects at once in infants, 4 in monkeys, 3–4 in adult multiple-object tracking; no sub-systems for ecologically salient kinds (foods, artifacts); non-object substances excluded outright |
| **Agents** | Entities acting instrumentally on the environment | **Goal-directedness**, **efficiency** of means, **contingency**, **reciprocity**, **gaze direction** — and explicitly *not* cohesion, continuity or contact | Applies to entities with no perceptible face or body; inanimate motion is never read as goal-directed and is not mirrored |
| **Number** | Sets of objects, sequences of sounds, sequences of actions | Approximate cardinality, comparable and combinable by addition and subtraction | **Scalar variability**: imprecision grows linearly with cardinal value ⇒ a **ratio limit** on discriminability — 2.0 at 6 months, 1.15–1.3 in adults |
| **Places / geometry** | The surrounding extended-surface layout | Distance, angle and **sense** (handedness) relations among extended surfaces | Blind to non-geometric layout properties (surface colour, odour); fails on the geometry of *movable object arrays* and on arrays that move |
| **Social beings** | Potential social partners and in-group members | Group membership, cued most powerfully by **native language and accent** (also race, gender) | *Candidate* system in 2007, promoted to core in 2022; its cues are set by exposure (below) |
| **Forms** | Shapes and object kinds | Kind membership from form | Present in the 2022 inventory only; no signature limit stated in either source |

The two agent-side systems are the pair Spelke needs later: `SOCIAL AGENT` is claimed to be their intersection. Note the inventory is not stable across the two sources — 4 + 1 candidate (2007) vs. 6 (2022) — and no stated criterion licensed the change.

---

## The architectural specification

Each row is a design property, not a description of infants.

| Property | Statement | Consequence for a model |
|---|---|---|
| **Domain-specific and abstract** | Each system is a cluster of interconnected abstract concepts, universal because its domain recurs across ecological niches | The prior is over *relations in a domain*, not over feature statistics — the `g` side of the factorization, installed rather than learned |
| **Selective / entry-gated** | A system applies only to a subset of entities *and* only to a subset of their properties. A pile of sand fails cohesion, so it never enters the object system at all | A prior that carries its own **applicability test**. Machine priors do not (gap G21) |
| **Input is perceptual representations, not sensation** | Inputs are the outputs of perceptual systems, not sensory information — a third layer between perception and thought | Rejects the perception/thought dichotomy; the prior sits on an intermediate code, so it is not a data-preprocessing bias |
| **Attention-dependent activation** | Activation is not automatic; systems **compete for limited attentional resources** | Selection is not an efficiency measure here — it is the *reason* several systems cannot be pooled at once ([[wiki/concepts/attention.md]]) |
| **Modular / encapsulated** | Operation is not influenced by the organism's beliefs about the world | Buys robustness, pays with information isolation — the composition problem below |
| **Bidirectional principles** | Concepts state expectations in both directions (action-on-contact ⟺ no-action-at-a-distance) | A principle is a constraint on the edge set, not a one-way predictor |

**Top-down, not bottom-up.** The hypothesis is set explicitly against empiricist development — knowledge accruing slowly from sensory input organized into increasingly abstract representations by domain-general learning. That empiricist picture is the one current deep learning implements.

---

## Evidence that this is hard-coded

| Argument | Evidence |
|---|---|
| Adult-like and **all-or-none** application by 5 months | Van de Walle et al. 1998 |
| **Existence proof of hard-codability** | Newborn chicks show an analogous object system with no prior visual or tactile experience of solid objects (Chiandetti & Vallortigara 2011) |
| Not shaped by learning | Despite lifetime experience, mature adult object cognition shows the same signatures found in infants (Scholl 2001) |
| Absence at birth is confounded, not evidence against | (i) behavioural measures before 3–6 months are limited by slowly developing cortico-motor top-down connections (Blumberg & Adolph 2023); (ii) the system depends on perceptual representations (e.g. motion analyzers) that may not be mature at birth |
| **Present with no visual experience** — objects | Newborn human infants and newly hatched chicks perceive object boundaries and complete partly occluded shapes (Valenza et al.; Regolin & Vallortigara 1995; Lea et al. 1996) (Spelke & Kinzler 2007) |
| **Present at birth** — agents and social partners | Newborns use gaze direction to interpret action (Farroni et al. 2004); newborns prefer the sound of the native language over a foreign one (Mehler et al. 1988; Moon et al. 1993) (Spelke & Kinzler 2007) |
| **Phylogenetically shared** | The same signature limits appear in adult monkeys (object set size 4; ratio-limited number; sensitivity to what a competitor can see) and in chicks, i.e. the systems predate the human lineage (Spelke & Kinzler 2007) |

The chick result is the load-bearing one for this wiki: it says relational priors of this kind are *installable*, so the architecture lever is not merely necessary but sufficient to place them.

---

## Signature limits as the identification criterion

The methodological core of Spelke & Kinzler 2007, and the most directly transferable part: **a core system is identified not by its content but by the profile of failures it produces**, held constant across ages, species, cultures and tasks. Content can be mimicked by learning; a quantitative limit that does not move cannot.

| Invariance probed | Result |
|---|---|
| **Across development** | Object set-size limit ~3 in infants, 3–4 in adult multiple-object tracking; adults also fail to track entities that violate cohesion and continuity (Scholl & Pylyshyn 1999; vanMarle & Scholl 2003; Marino & Scholl 2005) |
| **Across species** | Monkeys' object representations obey continuity and contact with a set-size limit of 4 (Hauser & Carey 2003; Santos 2004); monkeys and humans both discriminate large numbers of sounds with a ratio limit and add/subtract them |
| **Across culture, without language for the domain** | The **Pirahã** — reported to lack number words beyond 'two' and possibly recursion — still distinguish objects from non-objects and track them with the same set-size signature (Everett 2005; Gordon 2004). The **Mundurukú**, with no verbal counting routine and little schooling, show the same ratio limit as educated French adults and perform approximate addition/subtraction (Pica et al. 2004); they also extract geometry from pictures and maps (Dehaene et al. 2006) |
| **Under resource stress** | When attentional resources are stretched, learned fine-grained distinctions (foods, tools) stop guiding object representations while **core properties continue to do so** (Leslie et al. 1998); disoriented adults revert from landmarks to pure layout geometry under verbal or spatial interference (Hermer-Vazquez et al. 1999) |

**(brainstorm) The machine version of the criterion.** The wiki's standing complaint is that "architecture X has prior P" is unfalsifiable (open problems below; gap G17). Signature limits supply the missing test, in two runnable forms:

1. **Constant-under-perturbation.** An installed prior should show a *quantitative constant* — a capacity, a Weber ratio, an entry threshold — that survives scaling, retraining and domain shift. If the claimed module's signature moves with the training distribution, it was a learned feature, not an installed prior.
2. **The resource-stress probe.** Squeeze the budget (shrink the attention window, the context, the step count) and see which behaviours survive. Biology's answer is that the *learned* distinctions degrade first and the core ones last. That ordering is a direct, cheap experiment on any trained model, and it turns "which of these regularities is architectural?" into a measurement.

Both cut against the usual practice of certifying a prior by average accuracy on a benchmark: the diagnostic evidence is in the **failure profile**, not the success rate.

---

## Number: an installed content-invariant code

The number system is the clearest case in the wiki of a `g`-side code that is installed rather than trained.

| Property | Statement | Architectural reading |
|---|---|---|
| **Approximate, with scalar variability** | Imprecision grows linearly with cardinal value, producing a ratio limit on discriminability (Izard 2006) | A log-compressed magnitude line: noise proportional to signal, so the code is *relational* (ratios) rather than absolute |
| **Modality-invariant** | Applies to object arrays, sound sequences and produced or perceived action sequences; cross-modal comparison is **as accurate as within-modality** (Barth et al. 2003, 2005) | Not a bundle of per-modality magnitude estimates with a conversion step — one shared code. This is `g` with `x` stripped off, measured behaviourally |
| **Combinable** | Approximate addition and subtraction, in infants (McCrink & Wynn 2004), monkeys, unschooled Mundurukú adults and untutored preschoolers | The installed fragment carries *operations*, not just a representation — the minimal metric meta-graph: one ordered dimension closed under + and − |
| **Precision develops, format does not** | Ratio limit tightens 2.0 (6 months) → 1.15–1.3 (adults), while the ratio-limited *form* never changes | **The prior fixes the format; learning tunes the noise.** A clean template for installing priors in a model: hard-code the representational form, leave its precision as a trained parameter |

The last row is the one to steal. It resolves an implicit false choice in the architecture lever — install *or* learn — into a split: **format installed, resolution learned**.

---

## Geometry: the `g`/`x` split, dissociated in behaviour

| Finding | Source |
|---|---|
| Disoriented children and animals reorient by **layout geometry alone** — ignoring surface colour, odour and distinctive landmark objects | Cheng 1986; Hermer & Spelke 1996; Margules & Gallistel 1988; Wang et al. 1999; Lee et al. |
| The same children **fail** to reorient by the geometry of an *array of objects*, and fail to use array geometry when the array moves | Gouteux & Spelke 2001; Lourenco et al. 2005 |
| When landmarks *are* used, two dissociable processes are at work: a **reorientation process sensitive only to geometry** plus an **associative process** linking local layout regions to specific objects | Cheng 1986; Lee et al. |
| Adults use landmarks far more, but revert to surface geometry under verbal or spatial interference | Hermer-Vazquez et al. 1999; Newcombe 2005 |

**(brainstorm)** This is the wiki's factorization `p = f(g, x)` showing up as *two behaviourally separable channels* rather than as a modelling convenience: a structural channel that computes position from geometry and is content-blind by construction, and an associative channel that binds content to local positions. Three consequences:

- The structural channel's failure mode is **aliasing** — a rectangular room is geometrically symmetric, so heading is recoverable only up to that symmetry. The content channel is what breaks the tie. That is hardness source 3 / gap G2 with a different answer from the wiki's default: de-alias by *adding a content channel over a structural one*, not by path-integrating `g`.
- The entry condition is doing visible work: geometry applies to **extended surfaces**, not to movable objects. A layout prior that fired on object arrays would be actively wrong, because movable things do not predict where you are. This is gap G23's entry test earning its keep, with a stated reason.
- The stress-order (landmarks first to go, geometry last) says the structural channel is the *default* and the content channel is the elaboration — the opposite of how a trained model allocates, where content features are cheapest and dominate ([[wiki/concepts/shortcut-learning.md]]).

---

## Priors with slots

The social system is innate in *structure* but its cues are fixed by early exposure, which makes it the best-specified template on this page for a prior that is neither fully hard-coded nor fully learned.

| Finding | Source |
|---|---|
| 3-month-olds prefer own-race faces — but the preference tracks family and community composition: Israeli infants from Caucasian families prefer Caucasian faces, Ethiopian infants from African families prefer African faces, and Israeli infants from African families in a Caucasian-majority community show **no consistent preference** | Bar-Haim et al. 2006; Kelly et al. 2005 |
| 6-month-olds look longer at the woman who spoke to them in their **native language**, with speaker and language counterbalanced | Kinzler & Spelke 2005 |
| 12-month-olds accept food preferentially from a native-language speaker over a French speaker | McKee 2006 |
| Infants prefer faces of their primary caregiver's gender | Quinn et al. 2002 |

**(brainstorm)** The design pattern: **structure installed, binding argument left open and filled once, early, from ambient statistics** — an imprinting slot. Spelke's own argument for why *language* rather than race is the reliable cue is a statement about the environment of evolutionary adaptedness (races rarely co-occurred; both genders always did; languages varied sharply between neighbouring groups), i.e. the slot's filler is chosen for *variance across groups and constancy within a group*. That criterion is computable: a machine could select which observable to bind an installed grouping prior to by exactly that statistic, with no supervision. It is also the cleanest reply available to [[wiki/empirical-tensions.md]] T10 — such a prior is neither architecture-only nor data-only; it is architecture with a data-shaped hole.

---

## Core priors are defeasible, and symbols are what defeat them

| Where core knowledge is *wrong* | Where it gets overridden |
|---|---|
| At the smallest and largest scales objects are neither cohesive nor continuous, and space is not Euclidean or three-dimensional | Cosmologists and particle physicists test non-Euclidean, higher-dimensional space and reason with massless, discontinuously moving particles (Randall 2005; Hawking 2002) |
| Mathematicians work with numbers outside the core domains | Symbolic arithmetic, built on but not limited by the approximate system (Dehaene 1997; Feigenson et al. 2004) |
| Intentions depart from overt goal-directed action, deliberately or not | Children revise agent concepts on learning biological processes — eating, breathing (Carey 1985, 2001) |
| Naive object mechanics produces systematic errors in adults | Preschoolers change their concept of number when they **learn to count** (Wynn 1990; Spelke 2000) |

Core representations are veridical and adaptive **at the scales at which humans and other animals perceive and act**, and false outside them; conceptual change is possible and is not confined to academic science.

**Consequence for a model.** An installed prior must be a **strong, revisable default**, not an inviolable constraint — logged as [[wiki/empirical-tensions.md]] T11 against this page's own "principles delete candidate edges" reading. A prior implemented as a hard constraint has no path to physics; a prior implemented as a weak regularizer is washed out by data and buys nothing.

**(brainstorm)** The override mechanism in every case listed is an **external symbol system** — a counting routine, a formal geometry, a scientific notation, a biological vocabulary. That is the same lever T8 nominates for composition across modules. So the two open problems on this page, *how do the fragments compose* and *how does a fragment get overridden*, have one candidate answer, and a sharper prediction: a symbol system that could do neither should do both, or neither. This also explains the wiki's own asymmetry — a large language model has the pruner and the override channel and lacks the core fragments; an infant has the fragments and neither.

---

## Reading in the core framing

| Core-knowledge element | Latent-graph reading |
|---|---|
| A core system | A pre-installed fragment of the meta-graph: node type + edge vocabulary + constraints, given rather than discovered |
| Entry condition (cohesive movement ⇒ object) | A **type test** that routes an observation to the fragment that governs it — the missing routing policy of gap G12, supplied by the prior rather than learned |
| Principles (continuity, action-on-contact) | Constraints on which edges may exist — a prior that deletes candidate edges rather than reweighting them. But deletion must be **defeasible**: the principles are false at very small and very large scales and are overridden by conceptual change (below, [[wiki/empirical-tensions.md]] T11) |
| Instantiation on a particular scene | Instance-graph binding — one-shot, because the schema is already there |
| Six systems, no cross-talk | Six disconnected meta-graph components with no edges between them. **The graph is pre-installed but disconnected** |
| Composition across systems | Adding the missing inter-component edges — the entire problem below |

**(brainstorm)** This inverts the wiki's default reading of hardness source 2 (unknown vocabulary). Core knowledge says the vocabulary is *not* discovered for the primitive domains — it is given, and what must be discovered is how to *combine* given vocabularies. Vocabulary co-discovery (gap G4) may therefore be the wrong target for a first architecture: the tractable version is vocabulary *composition* from a fixed seed set.

---

## The composition problem

Modularity plus attentional competition jointly imply that core systems **cannot exchange information**. A creature with only core systems cannot entertain "Mary broke the five bottles she liked" — that content requires outputs of the number, object, agent and social systems at once, and both encapsulation and attentional competition block the combination.

Animals do combine core representations, by association or by evolved special-purpose mechanisms, but the combination is **neither productive nor systematic**: being able to represent "X prefers Y" does not guarantee being able to represent "Y prefers X" (Fodor & Pylyshyn 1988). Humans, alone, get productivity. Where from?

| | **Spelke 2022** | **Revencu & Csibra 2023** |
|---|---|---|
| Composition machinery | **Acquired** — the syntax and compositional semantics of a natural language, learned from linguistic input | **Innate language of thought** — core-system outputs are already in a common format; compositional machinery (plus conjunction, disjunction, negation) is bolted on top |
| Why reject the rival | An innate language of thought **overgenerates**: the infant would not know which concepts and beliefs are useful in its culture, which subset applies in a situation, or which propositions are true — a combinatorial explosion | The natural-language route **undergenerates**: core concepts are taken for granted by everyone and so are rarely uttered, while many linguistic units (logical operators, tense/aspect morphemes, modal verbs) have no core-system counterpart. The interface is not bidirectional |
| Innate endowment | Language-*learning* capacities only: sensitivity to speech and prosody, and an abstract content-word / function-word distinction | Semantics + syntax sufficient to underlie both language acquisition and cross-system composition |
| First composed concept | `SOCIAL AGENT` at 10 months (agent ∩ social), extended by `MENTAL STATES` at 12 months; yields Gricean pragmatics for free and accelerates word learning | Contested: no natural-language expression highlights the agent ∩ social intersection, so no input could point at it; and successful ball-vs-doll individuation (below) suggests an earlier composite |

**The dilemma is the transferable content.** Any composition mechanism must answer in *both* directions at once:

- **Externally driven** (a teacher, a corpus, linguistic supervision) → **undergenerates**: the supervision signal does not cover the primitives, because what everyone already assumes is what nobody says.
- **Internally driven** (the machinery composes on its own) → **overgenerates**: nothing explains why only a handful of the astronomically many available compositions are ever built. Spelke's own account inherits this the moment composition is granted, so the combinatorial explosion is not solved but **postponed** — pushed slightly later in development (gap G22).

**The equivocation problem.** If language is what brings core systems into a common representational format, then core concepts are of a *different kind* from the concepts used as building blocks of thought — so they cannot be used straightforwardly as primitives for the concepts the learner lacks. An architecture that seeds priors and then expects a general composer to operate over them owes a specification of the translation layer, and no source in the wiki supplies one.

**The escape hatch, and why it does not help.** Spelke concedes that language-deprived deaf children invent their own gestural language, so `SOCIAL AGENT` may depend only on those features of language children can *reinvent* — presumably the capacity to generate open-ended expressions. Revencu & Csibra: at that point the reinvented features are indistinguishable from the pre-linguistic language of thought the account was built to avoid.

**(brainstorm)** For a machine the dilemma has a shape the developmental debate does not force: a model can be given both an internal composer *and* an external corpus, and the corpus's job is then not to *supply* composition but to *prune* it — the linguistic environment as a selector over an internally generated composition space, not as its source. That reading makes the current large-language-model setup a candidate answer to gap G22 rather than to G21, and it predicts that what such a model lacks is the composer, not the pruner.

---

## Are core systems unitary?

Spelke needs them to be: all-or-none operation is what distinguishes a core system from the graded, dissociable `SOCIAL AGENT` construct. Revencu & Csibra argue unity fails even for objects.

| Claim | Evidence |
|---|---|
| **For unity** — violating one principle suspends them all | Infants shown an object-looking entity that moves non-cohesively stop expecting continuous motion or persistence under occlusion (Huntley-Fenner et al. 2002) |
| **Against** — principles dissociate in adults | Spatiotemporal continuity separates from cohesion (teleportation in science fiction is intelligible); remote controls violate action-on-contact without demoting the object |
| **Against** — infants respond to *which* principle was violated | Infants selectively explore according to the violation observed — banging solidity-violating objects against the table (Stahl & Feigenson 2015). Under a unitary system, one violation should suspend all objecthood assumptions rather than produce a violation-specific behaviour |
| **Against** — the agent domain dissociates too | Intentional-but-non-phenomenal (robots) vs. phenomenal-but-non-intentional (infants); this was Spelke's reason for denying `SOCIAL AGENT` core status, and it applies to objects as well |

Recorded as T9 in [[wiki/empirical-tensions.md]].

**(brainstorm)** The graded reading is the better architecture regardless of who wins developmentally. A prior implemented as *n* independently violable constraints, each producing its own prediction error, gives two things the monolithic version cannot: (i) partial applicability — an entity can be object-like on continuity and not on contact, which is what most real domains actually require; (ii) a **violation-typed error signal**, which is exactly the intrinsic-motivation signal that directs exploration at the specific principle that broke. A single on/off module can only report "not an object", which tells the learner nothing about where to look.

---

## De-aliasing by system membership

A mechanism the commentary surfaces as a puzzle for Spelke, which reads as an architectural gift here.

| Experiment | Result |
|---|---|
| Xu & Carey 1996 — duck and truck emerge in turn from behind an occluder | 10-month-olds **fail**: they do not expect two objects. Both entities are typed by the *same* system |
| Bonatti et al. 2002 (also Decarli et al. 2020; Surian & Caldi 2010) — a ball and a baby doll | Infants **succeed**. The two entities fall under *different* core systems (object vs. agent) |

**System membership functions as an identity feature.** In the framing this is hardness source 3 / gap G2: two occurrences that alias on appearance-and-position are separated for free by the module that types them, with no path-integrated `g` required.

The catch is the same attentional bottleneck: if the two systems compete for attention, how are both outputs simultaneously active enough to drive individuation? The mechanism that gives free de-aliasing depends on exactly the pooling that modularity is said to forbid. Either way one of Spelke's claims gives: if the two entities *are* held in one composite representation, then `SOCIAL AGENT` at 10 months is not the first composition.

---

## Open problems

- **No criterion for compositionality.** Spelke grants all animals an associative, non-productive way of combining core representations, and reserves productive composition for humans. Nothing specifies what would count as evidence for one rather than the other — so "architecture X composes" is currently unfalsifiable, the same defect gap G17 identifies for structure discovery.
- **Is attentional competition real or a measurement artefact?** Tasks involving both agents and objects may be harder simply because several systems take objects as input, so pre-/post-10-month success patterns may measure the infant's *attention-allocation policy* rather than concept acquisition. Every developmental milestone cited for composition inherits this confound.
- **An untested prediction.** Spelke holds that social-agent concepts do *not* compete for attention with other core systems. Adults automatically compute another agent's perspective during an unrelated dot-estimation task (Samson et al. 2010); the prediction that construing the agent as *social* would make that interference disappear has not been tested.
- **How many systems, and who individuates them?** Four plus one candidate in 2007; six in 2022, with `Forms` added and `Social beings` promoted. **No stated criterion licensed either change**, and no signature limit is given for `Forms` in either source — so the inventory is currently a list, not a derivation, and nothing settles whether a candidate (shared intentionality; communication) is a seventh system or a composite.
- **Signature limits identify a system; they do not prove it innate.** Constancy across ages, species and cultures is equally consistent with every learner facing the same problem with the same resources. Only the newborn and newly hatched results (infants, chicks) carry innateness, and they cover objects, gaze and native-language preference — not number, not geometry.
- **What sets the developmental tuning?** Numerical precision improves from ratio 2.0 to 1.15–1.3 with no account of what drives it. If it is ordinary experience, the same experience is available to a trained model and the format/precision split has an implementation; if it is maturation, it does not.
- **What computes the entry condition?** "Moves cohesively ⇒ object system" presupposes a cohesion detector upstream of the system it gates. That detector is itself a learned or installed perceptual competence and nothing here specifies it.

---

## Connections

- **[[wiki/concepts/latent-graph-discovery.md]]** — supplies the pre-installed case: six meta-graph fragments given rather than discovered, with the discovery problem displaced from vocabulary induction onto composition across fragments.
- **[[wiki/concepts/shortcut-learning.md]]** — names the specific content of the architecture lever, and inverts its stress-ordering: under resource pressure biology sheds the learned content features first and keeps the structural ones, where a trained model does the opposite; the only lever that can supply the `g`/`x` split the data cannot; and the entry condition is a prior that applies *conditionally*, unlike every machine prior on that page.
- **[[wiki/concepts/attention.md]]** — attention here is not an efficiency device but the binding bottleneck: competition for a limited attentional resource is the stated mechanism preventing outputs of two modules from being pooled into one representation; and adult object-based attention inherits the object system's entry conditions, failing entirely on entities that violate cohesion or continuity.
- **[[wiki/concepts/abstract-structural-codes.md]]** — a core system is a structural code with its domain fixed in advance, so it exhibits content invariance by construction; the number system supplies the behavioural measurement (cross-modal comparison as accurate as within-modal) and the geometry system supplies a `g`/`x` split dissociated in behaviour rather than assumed by a model.
- **[[wiki/concepts/working-memory.md]]** — the object system's set-size limit (~3 infants, 4 monkeys, 3–4 adult tracking) is the same capacity bound working memory reports, so the installed prior and the active store may be limited by one resource rather than two.
- **[[wiki/concepts/neuroscience-ai-transfer.md]]** — a candidate transfer of a *prior* rather than a mechanism, and the chick result is the strongest evidence in the wiki that such a prior is installable at all.
- **[[wiki/concepts/meta-learning.md]]** — core knowledge is the limiting case of the outer loop: the meta-graph fixed by evolution instead of by optimization over a task distribution, which is why instance binding can be one-shot.
- **[[wiki/concepts/complementary-learning-systems.md]]** — the entry condition types an observation before it is stored, so system membership supplies a discrete tag that does the de-aliasing work otherwise assigned to sparse conjunctive coding in the fast store.
- **[[wiki/concepts/simulation-based-planning.md]]** — the object system's principles (continuity, action-on-contact) are exactly the transition constraints a forward model needs, so core knowledge is a candidate specification for the environment model a planner rolls out.
- **[[wiki/concepts/universal-induction.md]]** — the formal challenge to innateness: for an ideal inductor, knowledge presented as the *first observation* replaces `K(µ)` by `K(µ|z)`, so a prior and a first-cycle input are interchangeable up to an `O(1)` interpreter ([[wiki/empirical-tensions.md]] T10) — and the same source supplies the counter, that evolution may have encoded incompressible (`Ω`-like) information no `O(1)` program reaches.
- **[[wiki/entities/aixi.md]]** — the agent for which that equivalence is proved; the "boundary between implementation and training is unsharp" claim is its most direct attack on this page's architecture lever.
