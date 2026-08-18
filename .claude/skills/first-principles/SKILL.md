---
name: first-principles
description: Method for hard or ambiguous problems - new system design, unfamiliar code, a bug that resists the quick fix, or judging whether a proposed approach is sound. Forces the framing question that makes the problem collapse before any implementation starts. Use when the path forward is unclear, when a design is growing more parts than the problem has, when you are about to commit to a non-trivial architecture, or when explaining a system to someone.
---

# First-Principles Problem Solving

## The core claim

Every hard problem has a framing in which it becomes easy. The work is finding
that framing, not powering through the wrong one.

The failure mode this skill prevents: reaching for mechanism before the problem
has been stated precisely enough to make the mechanism obvious. Code written in
that state is usually correct-looking, over-parameterized, and solving a problem
adjacent to the real one.

Spend the first portion of any hard task on three questions, in order:

1. What exactly do we want to happen? (behavior, stated concretely)
2. Why does the obvious approach fail? (specifically, with numbers)
3. What quantity, if it existed, would make the answer fall out?

Do not write implementation until all three have answers.

---

## Stage 1 — Frame

### 1. Open with a scenario, not a category

Bad: "we need caching." Good: "a user opens the dashboard, we hit the same
three endpoints we hit thirty seconds ago, and it takes 4s."

State the problem as one specific thing happening to one specific actor. If you
cannot produce a concrete instance, you do not yet know what you are solving.
Categories hide the constraint; instances expose it.

**Ask:** *Give me one concrete case, start to finish. What actually happens?*

### 2. Kill the naive approach explicitly, with numbers

Write down the dumbest solution that could work. Then say precisely why it
fails - a count, a bound, a rate, a cost. Not "that wouldn't scale."

This is not a formality. The specific reason it fails is the shape of the real
solution. "Scanning every record is O(n) over 40M rows at 200ms" tells you that
you need an index, not a rewrite. If the naive approach turns out *not* to fail,
you are done; ship it.

**Ask:** *What is the stupidest version of this? Now: at what number does it break, exactly?*

### 3. Ask what behavior you want before how it works

Describe the desired input/output behavior in cases you can verify by hand,
including the edge cases that distinguish this problem from its neighbors.
Three or four worked examples is usually enough. This becomes the test suite,
and it constrains the design far more than architecture discussion does.

**Ask:** *If this worked perfectly, what would it do on these four inputs? What would it refuse to do?*

### 4. Steal a structure from a problem already solved

Look for a domain where a structurally identical problem is already routine and
import its solution wholesale. Not a loose metaphor - a mapping where you can
name what corresponds to what, and where the mapping breaks.

Search order: elsewhere in this codebase, the standard library, a neighboring
field, physics/biology/economics. The best borrowings come from far away,
because near ones you have already tried.

**Ask:** *Who already solves a problem shaped like this one, and what do they call it?*

### 5. Invent the quantity that turns search into descent

The highest-leverage move available. If you can define a single number that
measures how bad the current state is, and show that local moves reduce it, you
have replaced "search an enormous space" with "roll downhill" - and the answer
becomes the minimum rather than something you have to find.

Applies far outside math. Define the score, the invariant, the health metric,
the thing that must monotonically improve. Then every subsequent decision is
"does this lower the number?"

**Ask:** *What single number would tell me I'm getting warmer? Can any local step reduce it?*

### 6. Factor into independent pieces, then recompose

Look for parts that vary independently and separate them hard. Two mechanisms
tangled into one are far more than twice as difficult to reason about; the same
two, cleanly split, are each easy and can be recombined in configurations you
did not design for.

The tell that you've factored correctly: each piece can be described, tested,
and broken in isolation, and reused in a context you haven't built yet.

**Ask:** *Which parts of this vary independently? What am I holding together that wants to come apart?*

---

## Stage 2 — Build

### 7. Shrink to a toy you can hold in your head — and label it a toy

Cut the problem to the smallest instance that still contains the difficulty.
Two dimensions instead of a thousand. Three states instead of a billion. One
user, one file, one request. Work it end to end by hand until the mechanism is
obvious, then scale up.

Non-negotiable: say out loud that the toy is a toy, and say what it distorts.
An unlabeled simplification silently becomes a false belief about the system.
"I'm assuming single-tenant here; multi-tenant changes the locking story" costs
one sentence and prevents a class of later bugs.

**Ask:** *What is the smallest version that still has the hard part in it? What does shrinking it hide?*

### 8. Build the minimum that works, then add one modification at a time

Get the simplest version fully working before adding anything. Then extend by
single, named modifications, where each one is independently justified and
independently reversible.

A complex design is trustworthy only if it is reachable as a short chain of
small deltas from a simple design that worked. If you cannot narrate the chain,
you do not understand the complex version - you assembled it.

**Ask:** *What is the shortest chain of single changes from the simplest working thing to this? Is each link necessary?*

### 9. Answer the objection at the moment it arises

When the design does something that would make a careful reader ask "wait, why
that?", answer it right there - in a comment, in the PR body, in the
explanation. Do not defer, and do not silently rely on the reader not noticing.

The reliable prompt: read your own work as a skeptic and note every point where
you would object. Each unanswered objection is either a gap in the design or a
gap in the write-up, and you cannot tell which until you write the answer.

**Ask:** *Where would a sharp reviewer stop and say "hang on"? What do I say there?*

---

## Stage 3 — Stress

### 10. Find the breaking point before you ship

Every design has a capacity limit, a degradation mode, and a set of assumptions
that make it correct. State all three explicitly. "Guaranteed to converge, but
only while the weights stay symmetric" is a complete claim; "it converges" is
not.

Also name the *early* failure - the conditions under which the thing degrades
well before its theoretical limit. Systems rarely fail at the documented
ceiling; they fail when inputs are correlated, adversarial, or skewed in a way
the happy path never was.

**Ask:** *What is the hard limit? What makes it fail early? What assumption, if violated, makes it silently wrong rather than loudly broken?*

### 11. Measure the thing that actually distinguishes the options

Pick the metric that separates a system that understands the problem from one
that memorizes cases. Often it is not the headline number but the shape: how
fast it improves, how it does on inputs it hasn't seen, what it costs at the
margin.

Then keep a running quantitative tally as you go, and check where the mass
actually lands. It is routine to spend the whole effort optimizing the part
that turns out to hold a third of the cost. Count before you optimize.

**Ask:** *What number would change my mind? Where does the cost actually sit - have I counted, or assumed?*

### 12. Verify against something you did not fit to

The strongest evidence a model is right is that it predicts something you did
not build it to explain, and that prediction holds. In engineering: does the
design handle a case nobody designed it for? Does the abstraction produce a
free feature? Do the tests you wrote after the fact pass unmodified?

Confirming that the code does what you told it to do is not verification.

**Ask:** *What does this predict that I never designed for - and is that true?*

---

## Anti-patterns

- **Mechanism before motivation.** Presenting or building the *how* before the
  *why we want this at all* is the single most common failure. If someone
  cannot say what behavior a component enables, the component is unjustified.
- **Unlabeled simplification.** Simplifying is required. Not flagging it is how
  a working assumption becomes a false belief.
- **Vague failure claims.** "Won't scale," "too slow," "not clean" - all
  unfalsifiable and all useless for design. Replace with a number.
- **Complexity with no chain back to simple.** If you can't derive the design
  as small steps from an obviously-correct one, you can't defend it.
- **Selling instead of bounding.** Any proposal that names no limit is
  incomplete. State the limit yourself, before review does.
- **Optimizing before counting.** Attention gets the attention; the cost is
  usually somewhere else.

---

## Compressed checklist

```
FRAME
  [ ] Concrete scenario, not a category
  [ ] Naive approach written down and killed with a specific number
  [ ] Desired behavior on 3-4 hand-checkable cases
  [ ] Structure borrowed from a solved problem (mapping named)
  [ ] The one number that says "warmer" - if one exists
  [ ] Independent parts separated

BUILD
  [ ] Toy version worked end to end, and labeled as a toy
  [ ] Minimum working version, then one delta at a time
  [ ] Every "wait, why?" answered where it arises

STRESS
  [ ] Hard limit + early degradation + correctness assumptions, all stated
  [ ] Measured on what distinguishes, not what flatters; costs counted
  [ ] Checked against something not fit to
```

---

## Provenance

Distilled from four explainers that solve genuinely hard problems by asking
better questions rather than by applying heavier machinery:

- 3Blue1Brown, *Attention in transformers* — https://youtu.be/eMlx5fFNoYc
- Artem Kirsanov, *Hopfield networks* — https://youtu.be/1WPJdAW-sFo
- Artem Kirsanov, *Boltzmann machines* — https://youtu.be/_bqa_I5hNAo
- Artem Kirsanov, *Building a cognitive map (TEM)* — https://youtu.be/cufOEzoVMVA

The moves above are the ones all four share. Concretely, in the source
material: "mole" in three sentences and recognizing a song at a party (1);
Levinthal's paradox — folding by search would exceed the age of the universe
(2); "before we dive into the matrix multiplications, think about the kind of
behavior we want" (3); protein folding imported into memory retrieval, and gas
thermodynamics into neuron updates (4); defining *energy* so that recall becomes
rolling downhill instead of searching (5); learning-shapes-the-landscape vs
inference-descends-it, and factoring *where* from *what* (6); "pretend tokens
are always words," "visualize it as two dimensions," "I'm making up this example
of adjectives updating nouns" (7); one attention head → many → many layers, and
Hopfield → +stochasticity → +hidden units → RBM (8); "now you might be
wondering, is it guaranteed to converge?" (9); capacity is 0.14N, and lower if
patterns are correlated; convergence holds only for symmetric weights (10);
measuring accuracy growth against *nodes* visited rather than *edges* (11);
grid cells were never hard-coded — they emerged, and the model's prediction
about remapping was then confirmed in real recordings (12).
