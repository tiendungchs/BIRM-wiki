---
name: tdd
description: Test-driven development. Use when the user wants to build features or fix bugs test-first, mentions "red-green-refactor", wants integration tests, or is testing the code around a model — task generators, eval harnesses, scorers, probes, and the ablations that check what a reader is denied.
---

# Test-Driven Development

TDD is the red → green loop. This skill is the reference that makes that loop produce tests worth keeping: what a good test is, where tests go, the anti-patterns, and the rules of the loop. Every section applies on every cycle: consult them before and during the loop, not after.

When exploring the codebase, take test names and interface vocabulary from the project's own domain language — the project instructions (`CLAUDE.md`), `wiki/glossary.md`, and the registry rows the code serves. Do not cite a `CONTEXT.md` in a repo that has none.

## Scope

A project that trains a model has three layers, and this loop governs two of them.

| Layer | Examples | This skill |
|---|---|---|
| **Authored code** | graph builder, binding ops, task generator, replay buffer, checkpoint IO | Applies verbatim. |
| **Scaffolding and instruments** | eval harness, scorer, probe-fitting code, ablation runner, leakage checks | Applies, and is the highest-value target. An instrument nobody tested cannot settle a claim (`L0-INSTR`); a scorer whose bugs are unknown is a result whose meaning is unknown. |
| **Learned behaviour** | "does this factorization generalize compositionally" | **Does not apply.** That is an experiment, not a test — see [Where the loop stops](#where-the-loop-stops). |

## Where the loop stops

Four rules below invert at a learned module, so do not carry them across:

- **Red-before-green assumes passing the test is the definition of done and that you write only enough code to pass it.** Nothing you write makes a learned module pass; the optimizer does or does not, and the failure does not localize to a line.
- **The anti-tautology rule demands an independent source of truth.** For a research claim no such value exists — that is what makes it research. Its substitute is a baseline plus a threshold fixed in advance and reported over seeds, which is different epistemics rather than a stricter assertion.
- **"Test at the public interface" assumes the interface is readable.** A learned seam is not; a claim crosses it only through an instrument whose validity was established separately (`codebase-design`, *Learned seams*). "The probe converged" is not "the seam carries it."
- **Vertical slicing lets the next test respond to the last cycle; an experiment must pre-register its metric and threshold before seeing results.** Both are right in their own layer. Likewise "refactoring is not part of the loop": a decomposition change in a learned system preserves nothing, so retraining after one is a new experiment, and the old eval is kept as the only evidence the redesign helped.

The one thing the loop *does* reach at a learned seam is a denial — see [Testing a denial](#testing-a-denial).

## What a good test is

Tests verify behavior through public interfaces, not implementation details. Code can change entirely; tests shouldn't. A good test reads like a specification: "a bound pair is recoverable by unbinding" tells you exactly what capability exists, and it survives refactors because it doesn't care about internal structure.

See [tests.md](tests.md) for examples and [mocking.md](mocking.md) for mocking guidelines.

## Seams: where tests go

A **seam** is the public boundary you test at: the interface where you observe behavior without reaching inside. Tests live at seams, never against internals.

**Test only at pre-agreed seams.** Before writing any test, write down the seams under test and confirm them with the user. No test is written at an unconfirmed seam. You can't test everything, so agreeing the seams up front is how testing effort lands on the critical paths and complex logic instead of every edge case.

Ask: "What's the public interface, and which seams should we test?"

When the shape of that interface is itself in question (how deep the module is, where the seam belongs, what the interface should expose), call the Skill tool with "codebase-design" for the vocabulary. It is the shared source of the module, interface, depth, seam, adapter, leverage and locality terms, and it is a reference to consult, not a session to run.

## Testing a denial

An interface has a negative half: what a reader is guaranteed *not* to see. In authored code that half is usually slack. In a trained system it is load-bearing — a block that can read the answer channel is a different architecture from one that cannot — and unlike everything else about a learned seam, **it is executable**. This is the one red → green cycle that reaches into the model:

- Shuffle, zero, or ablate the channel the reader must not use, and assert the score collapses to chance.
- Assert the *reverse* too: ablating a channel the reader is supposed to use must hurt. A denial test that passes because nothing works is not evidence.
- Run it against the trained checkpoint, not a fresh one — the leak you are hunting is one training discovered.

A denial stated in an `L2` row and never ablated is an assumption, not a property of the system.

## Anti-patterns

- **Implementation-coupled**: mocks internal collaborators, tests private methods, or verifies through a side channel (querying the database instead of using the interface). The tell: the test breaks when you refactor but behavior hasn't changed.
  - _Around a model_: asserting exact weight values, layer names, or module call order instead of behaviour on held-out input.
- **Tautological**: the assertion recomputes the expected value the way the code does (`expect(add(a, b)).toBe(a + b)`, a snapshot derived by hand the same way, a constant asserted equal to itself), so it passes by construction and can never disagree with the code. Expected values must come from an independent source of truth: a known-good literal, a worked example, the spec.
  - _Around a model_: scoring with the same loss the model minimized, evaluating on the training distribution, or any metric whose expected value the objective itself defines.
- **Horizontal slicing**: writing all tests first, then all implementation. Bulk tests verify _imagined_ behavior: you test the _shape_ of things rather than behavior a caller depends on, the tests go insensitive to real changes, and you commit to test structure before understanding the implementation. Work in **vertical slices** instead: one test → one implementation → repeat, each test a **tracer bullet** that responds to what the last cycle taught you.

## Rules of the loop

- **Red before green.** Write the failing test first, then only enough code to pass it. Don't anticipate future tests or add speculative features.
- **One slice at a time.** One seam, one test, one minimal implementation per cycle.
- **Refactoring is not part of the loop.** It belongs to the review stage (see the `code-review` skill), not the red → green implementation cycle.
