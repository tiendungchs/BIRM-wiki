---
name: codebase-design
description: Shared vocabulary for designing deep modules. Use when the user wants to design or improve a module's interface, find deepening opportunities, decide where a seam goes, make code more testable or AI-navigable, or when another skill needs the deep-module vocabulary. Covers learned modules (a trained block whose interface is a representation) as well as authored code; an L1/L2 instrument only, not for L0 behaviour or L3 realization questions.
---

# Codebase Design

Design **deep modules**: a lot of behaviour behind a small interface, placed at a clean seam, testable through that interface. Use this language and these principles wherever code is being designed or restructured. The aim is leverage for callers, locality for maintainers, and testability for everyone.

## Scope

This skill is an **`L1`/`L2` instrument** on the design ladder (see `CLAUDE.md` and the level key in `wiki/architectural-gaps.md`). It settles which modules exist and where their boundaries fall (`L1`), and what crosses each boundary and what is denied across it (`L2`). It does **not** answer `L0` — what the system must do and what counts as evidence it did — or `L3` — how a module does its job: loss, rule, operator, constant. Do not invoke it on a row sitting at those levels; a seam argued before its behavioural contract is written is a guess with a diagram.

Where the module is **learned** — a trained block whose interface is a representation nobody authored — read [Learned seams](#learned-seams) before applying anything below. Several of the rules in this file invert there.

## Glossary

Use these terms exactly: don't substitute "component," "service," "API," or "boundary." Consistent language is the whole point.

**Module**: anything with an interface and an implementation. Deliberately scale-agnostic: a function, class, package, or tier-spanning slice. _Avoid_: unit, component, service.

**Interface**: everything a caller must know to use the module correctly: the type signature, but also invariants, ordering constraints, error modes, required configuration, and performance characteristics. An interface also has a **negative half**: what a caller is guaranteed *not* to be able to see. In a codebase the negative half is usually slack (encapsulation you may quietly widen); in a learned system it is load-bearing — a module that can read the answer channel is a different architecture from one that cannot, even when every other fact about the seam is identical. State the denials as part of the interface, not as a note about the implementation. _Avoid_: API, signature (too narrow, they refer only to the type-level surface).

**Implementation**: what's inside a module, its body of code. Distinct from **Adapter**: a thing can be a small adapter with a large implementation (a Postgres repo) or a large adapter with a small implementation (an in-memory fake). Reach for "adapter" when the seam is the topic; "implementation" otherwise.

**Depth**: leverage at the interface. The amount of behaviour a caller (or test) can exercise per unit of interface they have to learn. A module is **deep** when a large amount of behaviour sits behind a small interface, **shallow** when the interface is nearly as complex as the implementation.

**Seam** _(Michael Feathers)_: a place where you can alter behaviour without editing in that place; the *location* at which a module's interface lives. Where to put the seam is its own design decision, distinct from what goes behind it. _Avoid_: boundary (overloaded with DDD's bounded context).

**Adapter**: a concrete thing that satisfies an interface at a seam. Describes *role* (what slot it fills), not substance (what's inside). _Collision_: in machine learning "adapter" standardly means a LoRA-style parameter-efficient fine-tuning module — substance, not role. When both senses are live in a discussion, say **seam adapter** for this one and let the ML sense keep the bare word.

**Leverage**: what callers get from depth. More capability per unit of interface they learn. One implementation pays back across N call sites and M tests.

**Locality**: what maintainers get from depth. Change, bugs, knowledge, and verification concentrate in one place rather than spreading across callers. Fix once, fixed everywhere.

## Deep vs shallow

**Deep module** = small interface + lots of implementation:

```
┌─────────────────────┐
│   Small Interface   │  ← Few methods, simple params
├─────────────────────┤
│                     │
│  Deep Implementation│  ← Complex logic hidden
│                     │
└─────────────────────┘
```

**Shallow module** = large interface + little implementation (avoid):

```
┌─────────────────────────────────┐
│       Large Interface           │  ← Many methods, complex params
├─────────────────────────────────┤
│  Thin Implementation            │  ← Just passes through
└─────────────────────────────────┘
```

When designing an interface, ask:

- Can I reduce the number of methods?
- Can I simplify the parameters?
- Can I hide more complexity inside?

## Principles

- **Depth is a property of the interface, not the implementation.** A deep module can be internally composed of small, mockable, swappable parts; they just aren't part of the interface. A module can have **internal seams** (private to its implementation, used by its own tests) as well as the **external seam** at its interface.
- **The deletion test.** Imagine deleting the module. If complexity vanishes, it was a pass-through. If complexity reappears across N callers, it was earning its keep.
- **The interface is the test surface.** Callers and tests cross the same seam. If you want to test *past* the interface, the module is probably the wrong shape.
- **One adapter means a hypothetical seam. Two adapters means a real one.** Don't introduce a seam unless something actually varies across it.

## Designing for testability

Authored code; for a learned module see [Learned seams](#learned-seams) instead. Good interfaces make testing natural:

1. **Accept dependencies, don't create them.**

   ```typescript
   // Testable
   function processOrder(order, paymentGateway) {}

   // Hard to test
   function processOrder(order) {
     const gateway = new StripeGateway();
   }
   ```

2. **Return results, don't produce side effects.**

   ```typescript
   // Testable
   function calculateDiscount(cart): Discount {}

   // Hard to test
   function applyDiscount(cart): void {
     cart.total -= discount;
   }
   ```

3. **Small surface area.** Fewer methods = fewer tests needed. Fewer params = simpler test setup.

## Relationships

- A **Module** has exactly one **Interface** (the surface it presents to callers and tests).
- **Depth** is a property of a **Module**, measured against its **Interface**.
- A **Seam** is where a **Module**'s **Interface** lives.
- An **Adapter** sits at a **Seam** and satisfies the **Interface**.
- **Depth** produces **Leverage** for callers and **Locality** for maintainers.

## Learned seams

A **learned seam** is one whose interface is a representation produced by training rather than authored by a person: a latent bus between two blocks, an attention read, a discrete code, a replayed trace. The vocabulary above still holds — module, interface, seam, denial — but four rules change.

**1. The cost of an interface is paid by the downstream block, not by a reader.** Depth is still leverage per unit of interface, but the unit is not "methods and params a programmer must learn"; those counters measure nothing here, and a wide latent bus is a *large* interface even though it is one tensor. The cost to measure is the sample complexity of decoding the seam: how much data the downstream block needs before it uses the representation correctly. Narrowing a learned interface means reducing that, not reducing tensor count.

**2. The interface is not the test surface; an instrument is.** You cannot assert on a learned representation. You fit a probe, and a probe is a trained decoder whose success is confounded — it may be reading structure the seam does not carry, or the decoder may be supplying the structure itself. A claim crosses a learned seam only through an instrument whose validity has been established separately. That validity is its own question, worked at `L0` priority (`L0-INSTR`). "The probe converged" is not "the seam is verified."

**3. Do not replace tests — add them.** [DEEPENING.md](DEEPENING.md)'s *replace, don't layer* assumes a behaviour-preserving refactor. A change of decomposition in a learned system preserves nothing: the deepened module is a different model. The old evaluation at the old decomposition is the only evidence that the redesign was an improvement, so keep it and add the new one. Delete an eval only when it has been shown invalid, never because the architecture moved past it.

**4. Depth trades against legibility, and legibility sometimes wins.** A monolithic end-to-end network is *maximally deep* by the definition in this file — enormous behaviour, an interface of tokens in and tokens out — and is exactly the thing a factorized architecture exists to avoid. So depth is a goal only where the hidden complexity is **not the object of study**. Where the factorization *is* the claim — a two-level separation, a consolidation channel, a routing policy — a shallower module with a legible, inspectable interface beats a deeper one, and the extra interface is the deliverable rather than a cost. Decide which case you are in before reaching for the deepening moves.

## Rejected framings

- **Depth as ratio of implementation-lines to interface-lines** (Ousterhout): rewards padding the implementation. We use depth-as-leverage instead.
- **"Interface" as the TypeScript `interface` keyword or a class's public methods**: too narrow: interface here includes every fact a caller must know.
- **"Boundary"**: overloaded with DDD's bounded context. Say **seam** or **interface**.

## Going deeper

- **Deepening a cluster given its dependencies**, see [DEEPENING.md](DEEPENING.md): dependency categories, seam discipline, and replace-don't-layer testing.
- **Exploring alternative interfaces**, see [DESIGN-IT-TWICE.md](DESIGN-IT-TWICE.md): spin up parallel sub-agents to design the interface several radically different ways, then compare on depth, locality, and seam placement.
