# Baba Is AI — the benchmark where the rules are objects the agent can push

**A MiniGrid re-implementation of *Baba Is You* in which the transition rules are movable word tiles inside the observation, so a solver must break, make and re-order the rules of the environment rather than obey them — and three frontier multimodal models that reach 100% on the plain-navigation version collapse to 14.7–20.0% once winning requires composing two rule edits.**

> **Provenance.** Cloos, Jens, Naim, Kuo, Cases, Barbu & Cueva 2024, *Baba Is AI: Break the Rules to Beat the Benchmark* (`raw/cloos-2024-baba-is-ai-benchmark.md`, arXiv 2407.13729v2; ICML 2024 workshop format). Environment built on Gymnasium MiniGrid; code at `github.com/nacloos/baba-is-ai`. Evaluated models: GPT-4o, Gemini-1.5-Pro and Gemini-1.5-Flash, all May 2024, chosen as the then top-two of the Chatbot Arena leaderboard plus the cheap tier.

**Why it matters here.** Every other benchmark in the wiki hides a *fixed* latent structure and asks the solver to recover it. This one puts the structure on the table as manipulable content and asks the solver to **edit** it. That makes it the wiki's first instrument aimed at hardness source **6** of [[wiki/concepts/latent-graph-discovery.md]] — non-stationary topology — and, more sharply, the first test of the *tractability conditions* gap **G7** says nobody had tested.

---

## The environment

| Element | Content |
|---|---|
| Substrate | Gymnasium MiniGrid, grid-world, 2-D, rendered as an image |
| Objects | `baba` (the usual controlled avatar, a white triangle), `door`, `key`, `ball`, `wall` |
| Rule tiles | Movable blocks bearing words: nouns (`baba`, `door`, `key`, `ball`, `wall`), the copula `is`, properties (`you`, `win`, `stop`) |
| **Activation predicate** | A rule is active **iff** its three tiles are *horizontally aligned* in the form `{noun} is {property}`. Nothing else makes a rule true |
| Effect of an active rule | `X is you` → the agent controls `X`; `X is win` → touching `X` ends the episode as a win; `X is stop` → `X` is impassable |
| Rewrite operator | Pushing a tile. Breaking a rule = push one of its three tiles out of alignment; making a rule = push a tile into alignment |

The activation predicate is the whole design: **the rule set is a function of the object positions**, so the same primitive action (push) either moves a token or rewrites the transition function depending on what it is pushing. There is no separate rule-editing interface.

Worked instance (paper's Fig. 1): `baba is you` active, `is win` incomplete, `wall is stop` active and the wall separates the agent from the free `door` tile. Winning plan = **break `wall is stop` → make `door is win` → goto `door`**. Neither edit is optional and the order is forced.

The three properties combine into positions the wiki has no other example of:

- **`X is win` makes the objective part of the state.** The goal is not given by the harness; it is *read off* the grid, and where the win rule is incomplete the agent must **author its own success condition** before any goal-directed behaviour is defined. This is gap **G72** (*nothing infers what counts as success*) posed as a solvable task rather than as a missing module — the objective is legible, editable, and there are usually several admissible choices.
- **`X is you` makes the agent's own body an editable rule.** The paper's hardest environment (Fig. 6, right) traps the avatar behind a `wall is stop` rule whose tiles sit in a corner and cannot be pushed out of line; the only solution is to break `baba is you` and make `key is you`, i.e. **transfer control to a different body on the far side of the wall**, then use that body to make `door is win`. Identity is a rewritable edge.
- **Superficially identical layouts require different solutions.** Fig. 6 shows three environments with the same object inventory and three distinct winning plans (one of them: break `wall is stop`, push the `wall` *noun* tile to build `wall is win`, walk into a wall block). Nearest-neighbour matching on the image is worthless by construction — the same non-retrievability property [[wiki/entities/math-perturb.md]] engineers for mathematics, here obtained for free from the rule semantics.

---

## Protocol

| Step | Content |
|---|---|
| Input modality | **A static image of the initial configuration.** No symbolic state, no text rendering of the grid — deliberately, against the prior practice of converting visual input to text before evaluating LLMs |
| Instructions | Text description of objects, tiles, and the alignment predicate for rule activation |
| Action space | A **high-level plan**, not low-level control: `break{rule}`, `make{rule}`, `goto{object}`, usable only on objects and tiles actually present |
| In-context learning | **10** (image, winning plan) pairs; the model must generate its own reasoning steps deriving each plan from its image, then **state a general algorithm**, then apply it |
| Scoring | **Exact match** between the final response and the winning plan; 5 samples per test environment; 5 random seeds, each with different in-context and test items |

No search, no execution, no environment feedback, no retry: the plan is emitted once from one image. What is measured is *plan synthesis under a stated rule semantics*, not control.

---

## Results

### 1 · The distractor ladder — relevance filtering costs accuracy even when the distractor is inert

Five environments, each adding exactly one irrelevant element to the same task (*go to the object named in the active win rule*):

| # | Added | Effect |
|---|---|---|
| 1 | nothing (fresh variants of the in-context environments) | GPT-4o **100%** |
| 2 | a **distractor object** | 100% (GPT-4o) |
| 3 | a **distractor noun tile** | 100% |
| 4 | distractor object **and** noun tile | 100% |
| 5 | distractor object **and an active distractor rule** — e.g. `door is win` is active but there is no door, so the other rule `ball is win` governs | **substantial drop for all three models** |

Then the same ladder is re-run with a grey wall down the middle of every environment, its `wall is stop` rule **initialised inactive** — so the wall is causally inert and only adds tiles and geometry. **Mean accuracy falls for all three models at every rung.** Gemini-1.5-Flash outperforms Gemini-1.5-Pro throughout, which is the paper's own "surprisingly".

Two readings the wiki should carry:

- **An active rule that refers to a non-existent object is the sharpest distractor.** Rungs 2–4 add material that is irrelevant *as content*; rung 5 adds material that is irrelevant only because a **binding check fails** (the rule's noun has no referent in the scene). Filtering it needs the rule and the object inventory to be cross-checked, not either alone.
- **Causal inertness is not perceptual inertness.** The wall's rule is off, so nothing about the task's solution changes; accuracy drops anyway. Whatever the models do is a function of the number of rule-shaped things in the image rather than of the rule *state*, which is precisely the failure the alignment predicate was designed to make checkable.

### 2 · Rule-composition holdout — the headline failure

In-context demonstrations cover three winning strategies:

```
goto{object}
make{rule},  goto{object}
break{rule}, goto{object}
```

Test requires the unseen composition:

```
break{rule}, make{rule}, goto{object}
```

**Accuracy is low for all three models**, and stays low under rotation — the authors alternate which three of the four strategies are shown and which is held out, with the same result. Nothing about the held-out plan is new except its *length in rewrites*: both edits, both primitives and the concatenation pattern (`edit, goto`) were demonstrated.

### 3 · The mixed-rule-manipulation set (Fig. 6 environments)

| Model | Accuracy (mean ± SD, %) |
|---|---|
| Gemini-1.5-Flash | **20.0 ± 29.28** |
| GPT-4o | 17.33 ± 28.15 |
| Gemini-1.5-Pro | 14.67 ± 20.66 |

**Every standard deviation exceeds its mean.** Across 5 seeds — where a seed fixes both the in-context examples and the test items — the outcome is close to all-or-nothing per seed. The measured quantity is therefore substantially *which demonstrations were drawn*, not a stable model property; no result on this set separates the three models, and the paper does not claim it does.

### 4 · Error taxonomy (Appendix B)

| Error | Description | What it implicates |
|---|---|---|
| **Grounding mistake** | The plan refers to an object not present — GPT-4o names "a ball (the blue circle)" in a scene containing no ball | The object inventory is confabulated from the rule vocabulary; the noun tiles supply names that the perception step then hallucinates referents for |
| **Path-planning mistake** | The plan asserts the path to the door is blocked by the key when it is not | Occupancy is misread from the image, so the *precondition* of `goto` is evaluated against a wrong state |

Both errors are upstream of rule reasoning: they are failures to build the scene graph the rule semantics quantifies over. This is the same layering [[wiki/entities/agent-benchmark.md]] measured with its derenderer ablation — a structured reasoner behind a broken state estimator — except here the state estimator and the reasoner are the same forward pass and cannot be ablated apart.

---

## What it decides for a builder

**1 · It is the first test of G7's tractability conditions, and they are met by construction.** [[wiki/concepts/latent-graph-discovery.md]] argues that a rewriting topology is learnable after lifting rule-state into the node, `s' = (base_state, rule_config)`, *if* rule-config factorises and rewrites are sparse, legible, bounded and meta-stationary. Baba Is AI satisfies every clause:

| Condition | How the environment satisfies it |
|---|---|
| **Factorises** | `rule_config` = a set of independent `{noun} is {property}` triples over a small vocabulary |
| **Sparse** | One rewrite per tile push; a plan is 1–3 edits |
| **Legible** | The rule is *written in the observation*, in words, in the instruction language |
| **Bounded** | `|nouns| × |properties|` ≈ 15 possible rules, of which a handful are instantiable per level |
| **Meta-stationary** | The activation predicate (horizontal alignment) never changes, in any level, ever |

Frontier models score 14.7–20.0%. **So satisfying the tractability conditions is not sufficient**, and the wiki's standing position on hardness source 6 — that the lift is the answer where the conditions hold — is downgraded from "solved in principle" to "solved in principle, unrealised in the best case anybody has built" (T229). What the conditions buy is that the *problem is well-posed*; the missing thing is a solver that searches over rewrites at all.

**2 · Rule reification is supplied from outside (G8), and it still does not get used.** Gap G8 wants a rule represented as a first-class node so that rule-change is an ordinary edge. Here the environment does that job: the rule *is* an object, with a position, a perceptual code, and the same action affordance (push) as every other object. A solver need not discover reification — it needs only to notice that the affordance applies. **(brainstorm)** That is a strong argument that G8's residue is not representational but *policy*: the models plainly parse the rules (they follow them when following suffices, rung 1–4 at 100%) and do not consider editing them. The action set over rule-nodes is present, legible and unused — which points at G61 (exploration is never part of the selector) rather than at the code.

**3 · Composition over *editing* primitives is a distinct axis from composition over content.** The wiki's compositional generalisation evidence — [[wiki/entities/pgm.md]]'s held-out `[relation, object, attribute]` triples, [[wiki/entities/mlc.md]]'s episode-resampled grammars, [[wiki/entities/pcfg-set.md]]'s unrolled constituents — all withhold a combination of things the solver *describes*. This withholds a combination of things the solver *does to the world*, where each primitive changes the transition function under which the next primitive is evaluated. `break; make; goto` is not a longer sentence; it is a sequence of three different environments. See [[wiki/concepts/compositionality.md]].

**4 · It separates framing from optimisation without needing a rule report.** [[wiki/concepts/problem-framing.md]]'s split is normally measured by asking the solver to state its rule ([[wiki/concepts/rule-level-evaluation.md]], I15). Here the *plan* is the framing and the environment is the optimiser, so the rung-5 and inert-wall results are direct measurements of framing failure: nothing about executing `goto` changed between rung 4 and rung 5, only which of the visible facts are relevant. Gap **G73** in its cheapest available form.

**5 · Supplies instrument I22** to [[wiki/concepts/certification-instruments.md]] — the additive distractor ladder plus the rotated primitive-composition holdout.

---

## Comparison

| | **Baba Is AI** | [[wiki/entities/arc-agi.md]] / [[wiki/entities/conceptarc.md]] | [[wiki/entities/bib.md]] / [[wiki/entities/agent-benchmark.md]] |
|---|---|---|---|
| Latent structure | **Visible and editable** | Hidden, fixed | Hidden, fixed |
| What the solver outputs | A plan of world edits | A grid | A surprise rating |
| Held-out axis | A **composition of rewrite primitives** | A transformation / a concept instantiation | A concept, or a physical configuration |
| Distractor control | An additive ladder, one distractor kind per rung, plus a causally inert one | None systematic | Item types authored one-per-heuristic |
| Human baseline | **None** | 73% `pass@1` (ConceptARC), 415 participants | .91 single rater / 1.00 ensemble |
| Perception | Image, unavoidable | Text or image, and the choice costs 40–60 points (T215) | Ground truth **and** derenderer, ablated |

---

## Limitations

- **No human baseline, no non-LLM baseline, no chance level.** Exact match against a single winning plan gives no reference system, so 17% is uninterpretable in the way [[wiki/concepts/human-baseline.md]] requires. The game is commercially successful and hard for humans too; nobody measured it.
- **SD > mean everywhere on the hard set.** Five seeds, five samples; the reported spread admits "one seed solved, four at zero". No confidence intervals, no per-environment breakdown.
- **Three models, one vintage, all LLMs.** May 2024 GPT-4o and Gemini-1.5. No reasoning-effort models, no search, no agentic loop, no RL agent trained in the environment — which is the obvious control, since MiniGrid ships with one.
- **The primitives are handed over.** `break`/`make`/`goto` are the paper's decomposition, not the solver's. The interesting version of gap **G33** — decide *that* a rule is a thing you can break — is short-circuited by the action vocabulary.
- **A unique winning plan is assumed.** Scoring is exact match; environments with several valid solutions would be scored wrong for a correct answer, and no admissibility check is reported.
- **The plan is never executed.** A plan that is right about the rules and wrong about geometry scores the same as a plan that is wrong about the rules — the two error classes in Appendix B are diagnosed by hand rather than separated by the metric.
- **Nothing tests self-amendment (G9).** The activation predicate is fixed; no level lets the agent edit the rule about what makes rules active. That third tier — self-amendment, gap **G9** — is what a rule-rewriting game like Nomic supplies and this environment does not. [[wiki/entities/fluxx.md]], now in the wiki, turns out not to supply it either — its recency-override rule and turn machinery are never editable — but it does supply the two tiers between: rewrites performed by *other* agents, and a win condition that is itself a card any opponent can replace.

---

## Connections

- **[[wiki/concepts/latent-graph-discovery.md]]** — the wiki's first benchmark aimed at hardness source 6: the edge set rewrites within an episode *because the agent rewrites it*, and every tractability condition the page requires for the `(base_state, rule_config)` lift is satisfied by construction while the best available solvers still score under 20%.
- **[[wiki/concepts/compositionality.md]]** — a held-out composition whose elements are **world edits rather than descriptions**, so each primitive changes the transition function the next one is evaluated under; `break; make; goto` fails while `make; goto` and `break; goto` are both demonstrated.
- **[[wiki/concepts/problem-framing.md]]** — framing failure measured without a rule report: between the fourth and fifth rungs of the distractor ladder the optimisation problem is unchanged and only the relevance judgement differs, and that is where the accuracy goes.
- **[[wiki/concepts/certification-instruments.md]]** — supplies **I22**, the additive distractor ladder (one irrelevancy per rung, including a causally inert one) plus the rotated primitive-composition holdout.
- **[[wiki/concepts/rule-level-evaluation.md]]** — the complementary read-out: that instrument asks a solver to *state* the rule it used on a fixed-rule task, this benchmark asks it to *change* the rule and reads the answer off the plan, so a stated rule is not needed to see which stage failed.
- **[[wiki/entities/agent-benchmark.md]]** — the same layering of a state estimator under a reasoner, without the ablation: AGENT can put a derenderer behind BIPaCK and price perception at .96 → .65, whereas here the grounding and path-planning errors of Appendix B are in the same forward pass as the plan and cannot be separated from it.
- **[[wiki/entities/pgm.md]]** — the held-out-abstraction design this one transposes from generated relational items to acted-upon environments: PGM declares which `[relation, object, attribute]` triple is withheld, this declares which *sequence of rewrites* is withheld.
- **[[wiki/entities/mlc.md]]** — the positive control the benchmark lacks: resampling the latent rule per episode takes systematic generalisation from 0% to 100% on a fixed architecture, and nobody has trained an agent that way *in* Baba Is AI, where the latent is the rule set and the resampling is free.
- **[[wiki/entities/conceptarc.md]]** — the fixed-rule counterpart in the same visual-grid family: both present a small grid whose transformation is latent, and this one makes the transformation an object in the grid.
- **[[wiki/entities/math-perturb.md]]** — obtains for free what that benchmark buys with two expert rewrites per item: three superficially identical layouts with the same objects and three different winning plans, so retrieval of a nearest solved instance is provably useless.
- **[[wiki/concepts/temporal-abstraction-options.md]]** — the action vocabulary is a hand-written option set (`break`, `make`, `goto`) with the option's own precondition (the referenced tile must exist) checked by the solver rather than the environment, which is where the grounding errors enter.
- **[[wiki/concepts/simulation-based-planning.md]]** — planning where the *model itself* is part of the state: rolling out `break{wall is stop}` changes the dynamics under which the rest of the rollout must be evaluated, so a planner needs a transition function indexed by rule-config rather than a fixed one.
- **[[wiki/entities/fluxx.md]]** — the unimplemented, unmeasured extension of the same design: same five G7 tractability clauses satisfied, but the rewrites are exogenous and adversarial, the goal is a replaceable card rather than an editable rule, the conflict predicate is semantic ("contradicts") and therefore arbitrated by an external ruling database rather than decided by tile alignment, and rewrites settle *retroactively inside* the current turn.
- **[[wiki/concepts/affordance-grounded-symbols.md]]** — the environment collapses the object/rule type distinction into a single affordance: `push` applies identically to a ball and to the word `is`, so effect-equivalence over this agent's repertoire puts the rule tiles and the game objects in one symbol class and the *effect* of the push is what separates them.
