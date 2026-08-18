# Why There Are Complementary Learning Systems in the Hippocampus and Neocortex

**Summary of:** McClelland, J. L., McNaughton, B. L., & O'Reilly, R. C. (1995). *Psychological Review*, 102(3), 419–457.

---

## The Core Question

Damage to the hippocampus causes amnesia for recent events while sparing very old memories — a pattern called **temporally graded retrograde amnesia**. Why would a memory system be built this way? The authors argue this isn't an arbitrary quirk of biology but reflects a deep computational necessity, which they uncover by studying how artificial neural networks learn.

## The Proposed Architecture: Two Complementary Systems

| | **Neocortex** | **Hippocampal System** |
|---|---|---|
| **Learning speed** | Slow | Fast |
| **Role** | Builds structured, generalizable knowledge (semantic memory, skills, concepts) | Rapidly stores specific episodes and arbitrary associations |
| **Mechanism** | Small, overlapping, interleaved weight changes across many experiences | Sparse, highly distinct ("conjunctive") representations that avoid overlap |
| **Analogy** | A slow-learning student who gradually grasps general principles | A scratchpad that captures today's events in detail |

The hippocampus acts as a **teacher** to the neocortex: it stores an experience quickly, then "replays" it later (including during sleep) so the neocortex can slowly absorb it without disrupting everything else it already knows.

## Why Two Systems? The Catastrophic Interference Problem

The key computational insight comes from connectionist (neural network) modeling:

- **Interleaved learning works.** When a network learns many examples *gradually*, mixed in with other examples, it discovers the shared structure of a domain (e.g., that robins, canaries, and sparrows are all birds with similar properties). This was demonstrated with Rumelhart's (1990) semantic network simulation, which progressively differentiated concepts from coarse categories (plant vs. animal) to fine ones (bird vs. fish) — mirroring how children's conceptual knowledge develops (Keil, 1979).

- **Focused (rapid) learning fails catastrophically.** If a network instead tries to learn something new *quickly*, by training intensively on it alone, it overwrites and corrupts previously learned knowledge. McCloskey and Cohen (1989) demonstrated this "catastrophic interference" dramatically: a network taught a new list of word pairs almost completely destroyed its memory for an old list — far worse than the mild forgetting seen in humans.

**The conclusion:** A single network can't both learn quickly *and* preserve structured knowledge. Evolution's solution is to split the job — a fast hippocampal system for one-shot storage, and a slow neocortical system for extracting durable, generalizable structure, with the hippocampus feeding the cortex a steady, interleaved diet of "replays."

## Answering the Two Key Questions

1. **Why is a hippocampus needed at all, if memory ultimately lives in the neocortex?**
 → To store new information without instantly overwriting existing cortical knowledge.

2. **Why does consolidation take so long (sometimes 15+ years)?**
 → Because incorporating new material safely requires interleaving it gradually with everything else the cortex already knows — rapid changes would cause interference.

## Modeling Retrograde Amnesia

The authors built simple simulations treating the hippocampus as a "black box" trace that decays over time and is occasionally reinstated in a cortical network. These simulations successfully reproduced real data from:

- **Kim & Fanselow (1992)** — fear conditioning in rats
- **Zola-Morgan & Squire (1990)** — object discrimination in monkeys
- **Winocur (1990)** — food preference learning in rats
- **Squire & Cohen (1979)** — human ECT patients' memory for TV shows

They formalized this into a simple two-compartment mathematical model (hippocampal strength decaying over time, neocortical strength slowly accumulating via consolidation), which fit all four datasets reasonably well using just a handful of parameters (decay rate, consolidation rate, initial trace strengths).

## Other Key Ideas

- **Quasi-regular domains:** Real-world facts (e.g., details of JFK's assassination) are rarely *purely* arbitrary — they share structure with other knowledge even while having idiosyncratic details. The cortex can absorb the shared parts relatively easily; arbitrary/idiosyncratic parts take longer and may be lost if hippocampal decay outpaces consolidation. This explains why long-term memory tends to become "schematic" — the gist survives, details fade.
- **Why slow learning is required, in general:** Drawing on statistical learning theory, the authors show that discovering true structure in a noisy, variable environment requires small, gradual weight adjustments — large rapid changes overfit to single experiences rather than capturing population-level regularities.
- **Spared learning in amnesia:** Hippocampal amnesics can still slowly acquire skills, simple cue-outcome associations, and repeated material — consistent with this still being learned (slowly) directly in the cortex or other intact systems.
- **Infantile amnesia & age effects:** The model suggests neocortical learning rates may be higher early in life (to bootstrap structure quickly) and slow with age — potentially explaining both infantile amnesia and why retrograde amnesia gradients seem longer in older human patients than in young animals.
- **Relation to other theories:** The paper situates itself against ideas like Marr's archicortex theory, Squire's declarative memory framework, O'Keefe & Nadel's cognitive map theory, and "binding"/indexing theories (Teyler & Discenna) — arguing these are often complementary rather than competing, but that this account is the first to give a *principled computational reason* why consolidation must be slow and retrograde amnesia must be temporally graded.

## Bottom Line

The brain has two memory systems because **fast learning and structured, generalizable knowledge are computationally incompatible in a single network.** The hippocampus buys time — storing new experiences quickly and safely — while slowly replaying them so the neocortex can weave them into its existing web of knowledge without catastrophic interference. The "cost" of this safety is the long, gradual process we observe as memory consolidation.