# Displacement Codes

**A relation between two locations is itself represented in the same modular format as a location — obtained by subtracting two grid states module by module — so "where B is relative to A" is a vector of the same type as "where A is", and navigation, object composition and analogy become one operation.**

> **Provenance.** `raw/hawkins-2019-framework-intelligence-cortical-grid-cells.md` — Hawkins, Lewis, Klukas, Purdy & Ahmad, *Front. Neural Circuits* 12:121, 2019. The cell class this page is named for (**displacement cells**) is introduced there as a *prediction*: it has never been recorded. Everything below is architecture, not measurement, unless a row says otherwise.

---

## The algebra: two complementary operators over one code

| Operator | Signature | Cell class | Wiki page |
|---|---|---|---|
| **Forward** | `Location1 + Displacement ⇒ Location2` | grid cells | [[wiki/concepts/path-integration.md]] |
| **Inverse** | `Location2 − Location1 ⇒ Displacement` | displacement cells | this page |

The pair is closed: the output of either is a legal input to the other. That closure, not the subtraction itself, is the content — it is what lets a relation be an *argument* rather than only a result.

**Modular ambiguity is inherited, and so is the capacity fix.** One displacement module cannot name a unique offset (a cell coding "two right, one up" also fires for "five over, four up") for the same reason one grid module cannot name a unique place. Reading `M` modules jointly makes the displacement unique, with capacity exponential in `M` (Fiete et al. 2008, via the source). So the displacement code is not a difference *scalar*; it is a residue-number-system code over the same moduli as the location code.

---

## Same space vs different spaces — one operator, two readings

| Two locations are… | The displacement is… | What it is used for |
|---|---|---|
| in the **same** object/environment space | a **movement** | point-to-point navigation: "what action gets me from **a** to **b**" — no search, one subtraction |
| in **two different** object spaces | a **composite object** | "the logo, at *this* offset, on the cup" — a single vector naming both the relation and the pair of relata |

The second row is the load-bearing one. A displacement vector between two object spaces is claimed to be **unique to the pair of objects**, not merely to their offset — so the vector *is* the compositional representation, and an object is stored as a **set of displacement vectors** over previously learned parts rather than as a set of (feature, location) pairs.

Four properties follow directly, and they are exactly the properties [[wiki/concepts/compositionality.md]] asks an operator for:

| Property | Mechanism |
|---|---|
| **Part reuse** | The logo is learned once, in its own space; placing it costs one vector |
| **Hierarchy** | A displacement placing the logo on the cup implicitly carries every sub-object of the logo — no re-description of the parts |
| **Recursion** | The logo may contain a picture of a cup with a logo; nothing in the format bounds the depth |
| **Behaviour** | A part that *moves* relative to the whole (a stapler opening) is a **sequence** of displacement vectors — object behaviour reduces to high-order sequence learning over displacement modules, the same machinery as sequence memory, with open and close distinguished only by order |

**(brainstorm) Why this is more than binding.** [[wiki/concepts/vector-symbolic-binding.md]] also composes by a vector operation, but its roles are *arbitrary random vectors*: two similar arrangements get uncorrelated codes, and similarity between compositions must be recovered by unbinding first. A displacement code's "role" is a **metric offset in a modular basis**, so nearby arrangements have nearby codes and the composition is directly comparable across object pairs. That is the property an analogy over relations needs ([[wiki/concepts/analogical-mapping.md]]) and the one a random binding operator deliberately destroys.

---

## The attentional precondition: composition requires serialisation

The subtraction needs two location states, and a column holds one at a time. The source's mechanism:

1. Attend object A → cortical grid cells **anchor** into A's space; current location read out.
2. Shift attention to object B → the *same* grid cells **re-anchor** into B's space, at the same physical point.
3. Displacement cells read the difference across the two anchorings.

So **each act of composition costs one attentional shift**, and attention is not a filter here but the operator that makes the second operand exist. This is also where the account is thinnest: re-anchoring — selecting which grid cells in each module are active on entering a learned space — is named and never specified, and it is the anchoring problem `G39` in its object-centric form.

---

## Predicted substrate, and the reinterpretation it forces

The source places displacement cells in **layer 5 thick-tufted pyramidal cells**, on a connectivity argument: those cells are simultaneously (i) the cortex's subcortical motor output and (ii), via an axon branch to higher-order thalamic relays, a feedforward input to hierarchically higher cortex. Guillery & Sherman read that branch as an **efference copy** of a motor command. The source offers instead that one cell class alternates between two representations — a movement (sent subcortically) and a composite object (sent up) — disambiguated at the destination by oscillatory phase or firing pattern. Recorded as [[wiki/empirical-tensions.md]] `T344`; no experiment separates them, and the disambiguation mechanism is named without being specified.

---

## Open problems

- **The cell class does not exist yet.** No recording anywhere; the whole page is a prediction with a connectivity argument behind its location and nothing behind its existence.
- **Commensurability is assumed, not derived.** Subtracting a location in cup-space from a location in logo-space is only defined if the two spaces share moduli, scale and orientation. Nothing allocates a module set to a new object, and nothing checks that two object spaces are comparable before differencing them — `G43` restated inside a single column.
- **No learning rule.** How a displacement module's tuning is acquired, and how the (object pair → displacement) association is stored, is unstated. Contrast [[wiki/entities/tolman-eichenbaum-machine.md]], where the analogous binding is a written memory with an equation.
- **What selects the two operands.** Attention supplies serialisation but nothing says *which* pair of objects to difference, which is the same unresolved controller [[wiki/concepts/attention.md]] carries.
- **Dimensionality is assumed known.** Composition across spaces presupposes each object's space has already been given the right dimensionality — which the source itself lists as one of the three things a column must discover, with no mechanism.

---

## Connections

- **[[wiki/concepts/vector-coding.md]]** — the measured half of this page's algebra: object-vector cells implement the agent-to-object case allocentrically, with a metric role code that generalises over the referent, which converts "a relation is a vector in the location format" from a prediction into a recording — and leaves the object-to-object case, where neither endpoint is the agent, still unmeasured.
- **[[wiki/concepts/path-integration.md]]** — the forward operator this page inverts; together they close a two-operator algebra over one modular code, which is what makes a relation storable in the same format as a position and therefore usable as an argument to a further relation.
- **[[wiki/concepts/compositionality.md]]** — supplies a composition operator with a *metric*: a part-whole description is one vector naming both relata and their offset, hierarchy and recursion come free from the format, and an object's behaviour is a sequence in the same space — at the cost of requiring the two spaces to be commensurate.
- **[[wiki/concepts/vector-symbolic-binding.md]]** — the same "relation as a vector" move with the opposite choice of role code: random and similarity-destroying there, a metric offset in a shared modular basis here, so displacement codes keep arrangement similarity that binding deliberately randomises.
- **[[wiki/entities/thousand-brains-theory.md]]** — the theory that introduces this operator, and the reason it is needed: with thousands of object-anchored frames, relating two objects *is* relating two frames, so composition and frame-conversion are the same computation.
- **[[wiki/concepts/distributed-reference-frames.md]]** — the operator that would make that page's concurrent frames usable: a displacement between two frames is the coordinate conversion the page's Prediction 4 asks for, run between objects rather than between egocentric and allocentric.
- **[[wiki/concepts/analogical-mapping.md]]** — a displacement vector is a relation whose *similarity structure survives*, so "A is to B as C is to D" becomes a comparison of two displacement vectors rather than a graph match — the cheap version of structure mapping, available only because the role code is metric.
- **[[wiki/concepts/simulation-based-planning.md]]** — the planner this operator implies: the movement needed to reach a goal is one subtraction rather than a rollout, which is the same trade path integration makes and extends it to reaching a location *in another object's space*.
- **[[wiki/concepts/attention.md]]** — attention as the operator that supplies the second operand: composition requires re-anchoring the same grid population into a second object's space, so each compositional step costs one attentional shift and the shift is constitutive rather than selective.
- **[[wiki/concepts/canonical-cortical-microcircuit.md]]** — the anatomy the substrate claim is read off: layer-5 thick-tufted cells as both subcortical driver output and, via a thalamic branch, feedforward input to higher areas — an edge that graph contains and leaves functionally uninterpreted.
- **[[wiki/concepts/latent-graph-discovery.md]]** — makes edges first-class objects in the framing: with locations and displacements in one format, the discovered graph's *edges* are representable and composable, not just its nodes.
