---
name: prototype
description: Build a throwaway prototype to answer a modeling or design question. Use when the user wants to sanity-check whether a mechanism, representation, or training setup behaves the way the wiki claims before it becomes real code.
---

# Prototype

A prototype is **throwaway code that answers one question**. Here the question is almost always about a *mechanism*: does this update rule converge, does this representation actually hold the structure the wiki says it does, does this task generator produce the cases we need.

## 1. State the question

Write the question at the top of the file, in one paragraph, before any code. Name where it comes from: a wiki page (`[[wiki/concepts/…]]`), a gap id (`G37`), a tension id (`T22`). A prototype that answers the wrong question is pure waste, and the pointer is what lets the answer flow back into the wiki afterwards.

Good questions have a verdict:

- "Does binding-by-superposition survive 50 items at d=1024, or does crosstalk swamp readout?"
- "Does this relational task generator actually produce cases a shortcut solver fails?"
- "Is the message-passing update the wiki describes stable, or does it blow up past ~10 steps?"

## 2. Pick the smallest shape that gives a verdict

- **A single script** with a `if __name__ == "__main__":` block that prints numbers. Default.
- **A pure function set** over arrays/tensors when the question is about a transformation, not a training loop.
- **A tiny synthetic dataset plus a few hundred training steps** when the question is about learnability. Toy dimensions, minutes not hours.
- **A notebook** only if the user asks for one; a script that prints is easier to re-run and to diff.

Keep the part that answers the question **pure and liftable**: no globals, no argument parsing tangled into it, no plotting inside it. Once the question is settled, that function or module drops into the real code unchanged; the driver around it is scaffolding.

## 3. Rules

1. **Throwaway from day one, and marked as such.** Put it next to what it prototypes for, and name it so a casual reader can see it is a prototype, not production.
2. **Trivial to run.** One command, no flags required: `python <path>` and it prints a verdict.
3. **Deterministic.** Seed everything (`random`, `numpy`, the framework RNG) and print the seed. A prototype whose answer changes between runs has answered nothing.
4. **Toy scale.** The smallest dimensions and step counts that can still show the effect. More than a few minutes means shrink it.
5. **No persistence, no config system, no CLI.** Constants at the top of the file. Persistence is what a prototype *checks*, never what it depends on.
6. **Skip the polish.** No tests, no error handling beyond what makes it runnable, no abstractions, no "what if we want X later".
7. **Surface the state.** Print the full relevant quantity at every step of interest — losses, norms, accuracies, the decoded item — so the run reads as evidence, not as a single pass/fail.
8. **Report the verdict honestly.** A prototype that says "no, this does not work" is a success. Say what was measured, at what scale, and what would change the answer.

## 4. Capture it when done

Fold the validated mechanism into the real code, and fold the *answer* back into the wiki: it usually lands as evidence on a concept page, or as a status change on the gap/tension row the question came from (`wiki/gaps/gNNN.md`, `wiki/tensions/tNNN.md`). Then keep the prototype itself as a primary source — commit it to a throwaway branch, out of main, with a pointer to that branch next to the claim it settled. Main keeps only the validated decision.

## Anti-patterns

- **Don't add tests.** A prototype that needs tests is no longer a prototype.
- **Don't generalise.** One question, one answer.
- **Don't scale up to make it convincing.** If a toy run is ambiguous, the question is wrong, not the scale.
- **Don't blur the mechanism and the driver.** If the pure part reads globals or prints, it is no longer liftable.
- **Don't let a prototype drift into the model.** The moment it grows a config file or a second question, stop and start real code.
