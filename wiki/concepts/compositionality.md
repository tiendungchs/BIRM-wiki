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
| **Efficient description** | A function hierarchy compactly describes higher-level functions, like a part hierarchy for a complex scene (Bienenstock, Geman & Potter 1997) | The MDL argument of the two-level hierarchy, restated: `|primitives| + N·|arrangement|` beats `N·|concept|` |
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
| **Goals** | Sub-goals defined as *reaching a given object* | Sequencing into a larger goal | Hierarchical DQN (Kulkarni et al. 2016) — the reported route to playing sparse-reward games such as Montezuma's Revenge |

The last two rows are the ones this wiki has least of: composition at the level of **object types** and at the level of **goals**, rather than at the level of visual parts. Both give the same economy — many repetitions of one type share one model — and the goal row is the only cited mechanism in the source for making delayed sparse reward tractable, which is gap G20's problem approached from the representation side rather than from the update rule.

---

## What deep networks have, and what they lack

| Present | Absent |
|---|---|
| Part-like features in deeper layers; new object types activate novel combinations of feature detectors (Zeiler & Fergus 2014) | Explicit representations of **objects, identity, and relations** |
| Convolutional invariance makes repeated instances of one object share features | A notion of **coherence** over novel configurations |
| Neural networks used for efficient inference in structured generative models that explicitly represent *the number of objects in a scene* (Eslami et al. 2016) | Composition at the level of goals, except where sub-goals are hand-defined over given object representations |
| Differentiable programming: stacks, queues, random-access memory folded into gradient-based learners (Neural Turing Machine, Differentiable Neural Computer, Neural Programmer-Interpreter) — "genuine programs, albeit in a representation more like assembly language" | The programs learned are algorithms over data structures, not causal models of a domain ([[wiki/concepts/working-memory.md]]) |

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

**(brainstorm)** Compositionality sharpens gap G10 (unreliable self-generated intermediate nodes) into something testable. If a concept is a program over parts, then the model can be asked to *parse* — to emit its own intermediate structure — and the parse can be scored against human parses, which the character work does directly (Lake, Salakhutdinov & Tenenbaum 2012). Parsing is therefore a cheap probe for whether a model's intermediate nodes are real: a model that classifies well and parses badly has features, not parts. That is a G17-class instrument that needs no distribution shift, only a second query against the *same* representation.

---

## Open problems

- **Coherence has no operational definition.** "Causality is the glue" names the requirement without saying what computes it. The wiki's only mechanised candidate is composition-as-relaxation to a joint free-energy minimum, where a composition that has no low-energy state is simply never built ([[wiki/concepts/predictive-coding-free-energy.md]], gap G22).
- **Where does the primitive library come from?** Every instantiation above uses a hand-specified or pre-trained primitive set. Bottom-up geometric decomposition is the only cited route that does not, and it is restricted to shape.
- **Compositionality of goals is barely explored.** Sub-goals in hierarchical DQN are defined *by the experimenter* over object representations that are also given. Nothing induces the sub-goal vocabulary.
- **Systematicity is not tested.** Being able to represent "X prefers Y" does not guarantee "Y prefers X" (Fodor & Pylyshyn 1988), and no benchmark in the wiki checks the symmetric case — so "architecture X composes" remains unfalsifiable ([[wiki/concepts/core-knowledge.md]], open problems).
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
