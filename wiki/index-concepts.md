# Index — Concepts

Every page in `wiki/concepts/`. One line each: what the concept *is*, and what it is load-bearing for.

| Page | What it is | Load-bearing for |
|---|---|---|
| [[wiki/concepts/latent-graph-discovery.md]] | **CORE PROBLEM FRAMING.** Infer a hidden relational graph from observations, then navigate it | Everything — the problem every other page is answering a piece of |
| [[wiki/concepts/neuroscience-ai-transfer.md]] | The methodological premise: import the brain's computational/algorithmic solutions, not its biophysics | Why a brain-inspired model at all; what counts as evidence for a mechanism |
| [[wiki/concepts/complementary-learning-systems.md]] | Fast sparse hippocampal store + slow distributed neocortical store, coupled by replay | The biological derivation of the slow-W / fast-M split |
| [[wiki/concepts/meta-learning.md]] | Slow outer loop over a task family shapes a fast inner learner | The optimization statement of the two-level hierarchy; explains in-context learning's ceiling |
| [[wiki/concepts/continual-learning.md]] | Learn a sequence of tasks without catastrophic forgetting | The mechanism by which slow W is written across environment families |
| [[wiki/concepts/biologically-plausible-credit-assignment.md]] | Deep credit assignment from locally available signals | Whether the meta-graph learner is realizable in neural / neuromorphic substrate |
| [[wiki/concepts/simulation-based-planning.md]] | Act by rolling an internal model forward and evaluating imagined outcomes | The *use* half of latent graph discovery: path search over the discovered graph |

**Coverage note.** Wave 0 of the ingest queue (foundations) is in progress; this index is expected to grow steeply through waves 2–6. Gaps currently known are tracked in [[wiki/architectural-gaps.md]] and [[wiki/priority-tasks.md]].
