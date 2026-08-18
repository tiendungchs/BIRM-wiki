# Architectural Gaps

What a brain-inspired reasoning model needs and no current architecture supplies. Updated after every ingest that opens or closes a gap, and rewritten at each lint pass.

**Status key:** `OPEN` — no known solution · `PARTIAL` — solved in a restricted setting · `CONTESTED` — candidate solutions exist and disagree.

| # | Gap | Why it blocks the target | Best current answer | Status |
|---|---|---|---|---|
| G1 | **Two-level separation is never transferred** | The meta-graph / instance-graph split ([[wiki/concepts/latent-graph-discovery.md]]) is the wiki's central requirement, yet every mechanism in the neuroscience→AI track record transferred a *representation* or a *schedule*, never a factorization | TEM's `p = f(g, x)`; CLS's two anatomical systems; meta-RL's weights-vs-activity | `PARTIAL` |
| G2 | **Consolidation is offline-only in machines** | Replay in AI is a training-time device that stops at deployment; the hippocampus replays for life. No architecture converts instance-graph experience into meta-graph structure *during* deployment | [[wiki/concepts/complementary-learning-systems.md]] — replay buffers, episodic control | `OPEN` |
| G3 | **The task distribution `p(T)` is always hand-built** | Meta-learning's inner loop generalizes exactly as far as the outer loop's task family and no further — the mechanism behind LLM knowledge-boundedness | [[wiki/concepts/meta-learning.md]] | `OPEN` |
| G4 | **Rich internal models must be learned without hand-crafted priors** | Simulation-based planning presupposes a model; acquiring that model *is* latent graph discovery, so planning currently sits on an unfilled dependency | Deep generative environment models produce coherent rollouts but are not used for control | `OPEN` |
| G5 | **No control policy over simulation** | Nothing decides when to plan, how deep to roll out, which branch to expand, or when to stop — on either the biological or the machine side. The prefrontal-queries-hippocampus proposal is a sketch | [[wiki/concepts/simulation-based-planning.md]] | `OPEN` |
| G6 | **Non-stationary topology** | The edge set rewrites within an episode; models score ~15–20% even when every rewrite is legible, controllable and bounded | Lifting rule-state into the node restores stationarity at a tractability cost | `OPEN` |
| G7 | **Vocabulary co-discovery across environments** | Latent action/primitive alphabets are learned per-domain (LAPA, AdaWorld) or on synthetic domains (NEO); none generalizes across structurally distinct environments | See the architecture table on [[wiki/concepts/latent-graph-discovery.md]] | `PARTIAL` |
| G8 | **Backward transfer vs. protection** | Weight protection stops forgetting but also stops later evidence from improving an earlier solution; brains revise old knowledge | [[wiki/concepts/continual-learning.md]] — EWC forbids revision by construction | `OPEN` |
| G9 | **Credit assignment across behavioural timescales** | Local-rule approximations to backprop address depth, not the seconds-to-days eligibility problem a reasoning agent faces | [[wiki/concepts/biologically-plausible-credit-assignment.md]] | `OPEN` |
| G10 | **Far transfer is unexplained on both sides** | Neuroscience has no account of how humans transfer abstract structure to new domains, so the transfer channel has nothing to send on the wiki's central capability | Grid-like codes during abstract categorization are the only direct lead | `OPEN` |

---

## How gaps are used

A gap is worth recording only if it is *actionable*: it names a mechanism the wiki would adopt if it existed. Gaps that reduce to "the problem is hard" are folded into the open-problems section of the relevant concept page instead.

Gaps feed [[wiki/priority-tasks.md]], which turns them into the next things to read or write.
