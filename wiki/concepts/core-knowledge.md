# Core Knowledge

**A small set of innate, domain-specific systems of abstract concepts — each with a defined input condition, a defined subset of entities it applies to, and its own principles — which guide learning top-down from the start rather than being abstracted bottom-up from sensation.**

Core knowledge is the concrete content of the **architecture lever** ([[wiki/concepts/shortcut-learning.md]], gap G16): where the wiki has so far said only "the intended solution must be paid for with inductive bias", this page names a specific, enumerated, empirically defended set of priors that biology already pays for. In the core framing it is a **pre-installed partial meta-graph** — node types, edge labels and constraints fixed in advance, so instance binding can be one-shot.

> **Provenance.** All content here is from Revencu & Csibra 2023, a critical commentary on Spelke's *What Babies Know*, vol. 1 (2022). Positions attributed to **Spelke 2022** are reported by the commentary; positions attributed to **Revencu & Csibra 2023** are the commentary's own. The primary source (`raw/spelke-2007-core-knowledge.md`) is not yet ingested, so the empirical detail here is second-hand.

---

## The systems

| System | Applies to | Core concepts / principles |
|---|---|---|
| **Objects** | Mid-sized bodies that move cohesively — *not* piles of sand | Cohesion, continuity, action-on-contact (equivalently: no-action-at-a-distance) |
| **Places** | Navigable spatial layouts | Geometry of the surrounding surface layout |
| **Number** | Magnitudes of sets of objects and sequences of events | Approximate magnitude comparison |
| **Forms** | Shapes and object kinds | Kind membership from form |
| **Agents** | Entities acting instrumentally on the environment | Efficiency of action (actor → object, dyadic) |
| **Social beings** | Individuals who engage with one another | Engagement (actor → partner, dyadic) |

The two agent-side systems are the pair Spelke needs later: `SOCIAL AGENT` is claimed to be their intersection.

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

The chick result is the load-bearing one for this wiki: it says relational priors of this kind are *installable*, so the architecture lever is not merely necessary but sufficient to place them.

---

## Reading in the core framing

| Core-knowledge element | Latent-graph reading |
|---|---|
| A core system | A pre-installed fragment of the meta-graph: node type + edge vocabulary + constraints, given rather than discovered |
| Entry condition (cohesive movement ⇒ object) | A **type test** that routes an observation to the fragment that governs it — the missing routing policy of gap G12, supplied by the prior rather than learned |
| Principles (continuity, action-on-contact) | Hard constraints on which edges may exist, i.e. a prior that deletes candidate edges instead of reweighting them |
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
- **How many systems, and who individuates them?** Six are enumerated. Nothing says the list is complete, or what principle would settle whether a candidate (shared intentionality; communication) is a seventh core system or a composite.
- **What computes the entry condition?** "Moves cohesively ⇒ object system" presupposes a cohesion detector upstream of the system it gates. That detector is itself a learned or installed perceptual competence and nothing here specifies it.

---

## Connections

- **[[wiki/concepts/latent-graph-discovery.md]]** — supplies the pre-installed case: six meta-graph fragments given rather than discovered, with the discovery problem displaced from vocabulary induction onto composition across fragments.
- **[[wiki/concepts/shortcut-learning.md]]** — names the specific content of the architecture lever, the only lever that can supply the `g`/`x` split the data cannot; and the entry condition is a prior that applies *conditionally*, unlike every machine prior on that page.
- **[[wiki/concepts/attention.md]]** — attention here is not an efficiency device but the binding bottleneck: competition for a limited attentional resource is the stated mechanism preventing outputs of two modules from being pooled into one representation.
- **[[wiki/concepts/abstract-structural-codes.md]]** — a core system is a structural code with its domain fixed in advance, so it exhibits content invariance by construction and shows what `g` looks like when it is installed rather than trained.
- **[[wiki/concepts/neuroscience-ai-transfer.md]]** — a candidate transfer of a *prior* rather than a mechanism, and the chick result is the strongest evidence in the wiki that such a prior is installable at all.
- **[[wiki/concepts/meta-learning.md]]** — core knowledge is the limiting case of the outer loop: the meta-graph fixed by evolution instead of by optimization over a task distribution, which is why instance binding can be one-shot.
- **[[wiki/concepts/complementary-learning-systems.md]]** — the entry condition types an observation before it is stored, so system membership supplies a discrete tag that does the de-aliasing work otherwise assigned to sparse conjunctive coding in the fast store.
- **[[wiki/concepts/simulation-based-planning.md]]** — the object system's principles (continuity, action-on-contact) are exactly the transition constraints a forward model needs, so core knowledge is a candidate specification for the environment model a planner rolls out.
