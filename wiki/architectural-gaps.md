# Architectural Gaps

What a brain-inspired reasoning model needs and no current architecture supplies. Updated after every ingest that opens or closes a gap, and rewritten at each lint pass.

**Status key:** `OPEN` — no known solution · `PARTIAL` — solved in a restricted setting · `CONTESTED` — candidate solutions exist and disagree.

> **Provenance:** every row below is derived from [[wiki/concepts/latent-graph-discovery.md]] alone — no source has been ingested yet. The `Best current answer` column therefore records *mechanisms the framing names*, not architectures the wiki has checked. Each is a claim to be confirmed, revised, or killed by the ingest that first touches it.

| # | Gap | Why it blocks the target | Best current answer | From | Status |
|---|---|---|---|---|---|
| G1 | **Two-level separation is a requirement with no demonstrated instance** | Meta-graph and instance-graph co-occur in every observation; a flat learner fits the mixture `E_θ[p(obs\|θ)]`, which no individual instance follows — so it cannot transfer at all | Factorized latent space `p = f(g, x)` + two learning rates (slow W, fast M) | Two-Level Graph Hierarchy; Hardness 1 | `PARTIAL` |
| G2 | **De-aliasing without a hand-built state space** | The same observation recurs at structurally distinct graph positions; without path-sensitive identity the model merges nodes that must stay distinct | Clone cells, or identity carried by path-integrated `g` | Hardness 3 | `PARTIAL` |
| G3 | **Nothing enforces path-consistency of `g`** | The structural code is only a graph position if it *commutes* — same position reached by any path. No training signal or architectural constraint is named that makes it so; without it `g` degenerates into a second content code | — (requirement stated, no mechanism) | Architectural Requirements | `OPEN` |
| G4 | **Vocabulary co-discovery at scale** | When the alphabet of edge labels is itself latent, primitives *and* their semantics must be induced jointly with structure. Learnable embeddings are necessary but not sufficient; nothing does this beyond toy domains without a hand-given DSL | Learnable observation + action embeddings | Hardness 2; Open Problems | `OPEN` |
| G5 | **No joint discover-and-navigate loop** | Hard tasks give no discovery-then-use phase separation: the graph estimate must update *while* it is being searched. Architectures that assume a fixed model at inference time cannot express this | Joint loop (update estimate and navigate concurrently) — named, not built | Hardness 4 | `OPEN` |
| G6 | **Spurious edges survive training** | Correlational edges work in-distribution and fail out of it. Invariance across environments is the stated fix, but it presupposes an environment partition the model is not given | Invariant causal edge discovery; explicit intermediate-node traversal | Hardness 5 | `OPEN` |
| G7 | **Non-stationary topology is tractable only under untested conditions** | Lifting rule-state into the node (`s' = (base_state, rule_config)`) restores stationarity in principle, but the lifted space is `(base) × (rule-configs)` — learnable only if rule-config factorizes and rewrites are sparse, legible, bounded, and meta-stationary. Nothing tests whether real domains meet that | Rule-state lifting; rewrite generator → slow W, active edge set → fast M | Hardness 6 | `OPEN` |
| G8 | **Rule reification has no implementation** | The biological reading — a rule represented as a first-class node with its own factorized code, so rule-change is an ordinary edge — is the mechanism that would make G7 cheap. No architecture represents its own transition rules as navigable content | — (biological reading only) | Hardness 6, biological reading | `OPEN` |
| G9 | **W is flat; there is no third tier** | Two levels suffice only while the rewrite is expressible in the base vocabulary. Self-amendment that edits the rule-changing rules needs a distinct rewrite-graph level, and W itself would have to be a discoverable graph rather than a parameter blob | — | Open Problems; Architectural Requirements | `OPEN` |
| G10 | **Self-generated intermediate nodes are unreliable** | Multi-hop traversal requires the model to materialize its own intermediate states; when it does, they are not dependable graph positions, so errors compound along the path | — | Open Problems | `OPEN` |
| G11 | **No mechanism for the non-embeddable symbolic slice** | The navigation frame is warranted where structure is orderable, continuous, or transition-sampled. Modular arithmetic, syntactic recursion and type-checking admit no metric embedding — if navigation does not reach them, a second mechanism is needed and none is named | — | Epistemic status; Open Problems | `OPEN` |
| G12 | **No routing policy between structure types** | Given a metric/transition-sampled module and a declarative/relational one, nothing decides which structure goes where. The arbitration is a prerequisite for G11's second mechanism to be usable at all | — | Open Problems | `OPEN` |
| G13 | **No tractable system covers all six hardness sources** | AIXI is the only known system that does, and it fails on computability. Every real architecture is a bounded-program approximation that drops whichever sources its search budget cannot reach — and there is no principled account of which to drop | AIXI as the formal ceiling; bounded approximations unscored | Formal Ceiling | `OPEN` |

---

## How gaps are used

A gap is worth recording only if it is *actionable*: it names a mechanism the wiki would adopt if it existed. Gaps that reduce to "the problem is hard" are folded into the open-problems section of the relevant concept page instead.

**Dependency structure.** These are not independent. G1 is the root — G2 and G3 are the conditions under which its factorization is meaningful, and G9 is what happens when it is applied to itself. G7→G8 and G11→G12 are each a problem followed by the mechanism that would dissolve it. G13 is the accounting frame for all of them: an architecture is scored by which hardness sources it reaches, not by whether it "works".

**What would close one.** A gap closes when an ingest supplies an architecture that (a) instantiates the named mechanism and (b) is tested on a task where the corresponding latent variable is actually hidden. An architecture that assumes away the latent variable does not count as evidence.
