# IRENE — Intuitive Reasoning Network

**A relational graph encoder over the scene plus a transformer over the eight familiarisation trials, trained only to predict the agent's next grid position, and scored by how much that prediction breaks on a surprising ninth trial.**

> **Provenance.** Bortoletto, Shi & Bulling 2023 (`raw/bortoletto-2023-irene-intuitive-reasoning-network.md`), AAAI 2024. Evaluated on the Baby Intuitions Benchmark (BIB), the same episodes [[wiki/entities/hbtom.md]] is scored on. Three seeds, single V100.

Its value to the wiki is not the state of the art it claims but the **control it supplies**: IRENE reads the *same symbolic scene description* the Bayesian model reads — BIB's per-frame JSON, never the pixels — so "the structured model was handed the state space" ([[wiki/empirical-tensions.md]] T21) no longer explains the gap between them. What is left over when input is matched is the difference between an authored generative model of an agent and a learned next-position predictor, and that difference is now measurable.

---

## Architecture

| Stage | Content |
|---|---|
| **Nodes** | One per entity in a frame (sampled at 3 FPS). Features: `type` and `shape` one-hot, `position` `(x,y)` normalised to `[−1,1]`, `colour` (3 channels) in `[0,1]` |
| **Edges** | Four hand-written spatial predicate families (after Jiang et al. 2021): **local directional** (8 adjacency directions, `x_a = x_b ± l ∧ …`), **remote directional** (4 comparisons, `x_a > x_b` etc., no adjacency needed), **aligned** (`x_a = x_b ∨ y_a = y_b`), **adjacent** (`\|Δx\| ≤ l ∧ \|Δy\| ≤ l`) |
| **Feature fusion** | `v^{t,s,c} = f_{F1}(ReLU(⊕_k f_k(v^k)))` over type/shape/colour, then `v′ = f_{F2}(ReLU(f_pos(v^pos) ⊕ v^{t,s,c}))` — position enters *after* the identity features, at hidden dim 96 |
| **State encoder** | Relational GNN: 2 GraphSAGE layers **per edge type** (separate weights, LSTM aggregation), ELU; state embedding `h_{ij} = AvgPooling(φ(v′, e))` |
| **Context encoder** | Per familiarisation trial `i`, the sequence `f_proj({h_{ij}} ⊕ {a_{ij}}) ⊕ CTX_i` through a 6-layer, 4-head transformer; trial representation is the output `CTX′_i`; context is the plain mean `c = (1/8) Σ_i CTX′_i` |
| **Prediction net** | Same state encoder on the test frame; `a_pred = ρ(c ⊕ h_{9j})`, MLP 256-128-256 → 2 outputs = the agent's next `(x,y)` |
| **Training** | 32 epochs, Adam, `η = 5·10⁻⁴`, batch 32, on BIB's four training tasks; the loss is next-position regression and nothing else |
| **Expectedness readout** | `max_t` mean-squared prediction error over the test-trial frames (the benchmark's convention); a pair is scored correct if the unexpected trial's max error exceeds the expected trial's |

**The whole intuitive-psychology content sits in the readout, not in the model.** There is no goal variable, no rationality variable, no belief, no agent identity slot — only a 96-d pooled scene vector, an averaged 8-trial context vector, and a regression head. Whatever "preference" IRENE has must be encoded in `c` as a side effect of predicting positions.

---

## Results — violation-of-expectation accuracy on BIB (%)

Max-error readout, mean of 3 seeds; HBToM column is *not* comparable (different expectedness definition, classifiers fitted on a purpose-built synthetic set) and is shown only for scale.

| Task | BC-MLP | BC-RNN | Video-RNN | VT | **IRENE** | (HBToM) |
|---|---|---|---|---|---|---|
| Preference | 26.3 | 48.3 | 47.6 | **80.8** | 48.5 | 99.7 |
| Multi-Agent | 48.7 | 48.2 | 50.3 | 49.2 | **74.9** | 99.2 |
| Inaccessible Goal | 76.9 | 81.6 | 74.0 | 85.5 | **85.8** | 99.7 |
| Eff. Path Control | 94.0 | 92.8 | **99.2** | 97.5 | 98.1 | 94.9 |
| Eff. Time Control | 99.1 | 99.1 | 99.9 | 99.7 | **100.0** | 97.2 |
| Eff. Irrational Agent | 73.8 | 56.5 | 50.1 | **34.1** | **85.7** | 96.6 |
| *Efficient Action avg* | 88.8 | 82.5 | 83.1 | 77.1 | **94.7** | 96.0 |
| Inst. No Barrier | 98.8 | 98.8 | **99.7** | 97.9 | 78.4 | 98.8 |
| Inst. Inconsequential Barrier | 55.2 | 78.2 | 77.0 | **91.9** | 52.4 | 97.0 |
| Inst. Blocking Barrier | 47.1 | 56.8 | 62.9 | 64.2 | **83.5** | 99.7 |
| *Instrumental Action avg* | 67.0 | 77.9 | 79.9 | **84.7** | 71.5 | 98.5 |

All differences to baselines significant at `α = 0.05, p < 0.01` except Preference vs BC-RNN and Time Control vs Video-RNN.

**The load-bearing reading is the anti-correlation between columns, not the bolding.** VT wins Preference (80.8) while scoring **34.1 — far below chance — on Irrational Agent**; IRENE wins Irrational Agent (85.7) while sitting at chance on Preference (48.5). No neural model in the table is above chance on both. Two models, each with a "state of the art" claim, fail on disjoint halves of the same five-task battery, and the average that gets reported hides it. Compare the one model that is uniformly high (HBToM, 96–99.7) — with the entire agent model authored.

---

## Where IRENE *loses*, and why that is the interesting part

IRENE is worse than every baseline on Instrumental **No Barrier** (78.4 vs 97.9–99.7) and **Inconsequential Barrier** (52.4 vs 78.2–91.9), and the paper's own explanation is that those subtasks are **solvable by the heuristic "head straight for the goal object"** — a model that never learned barriers applies it and wins; a model that did learn them does not. The Blocking Barrier subtask, where the heuristic fails, reverses the ordering (83.5 vs 47.1–64.2).

So the *Instrumental Action average* — the number by which VT (84.7) beats IRENE (71.5) — is dominated by two subtasks a shortcut solves. This is [[wiki/concepts/shortcut-learning.md]]'s congruent/incongruent partition arriving from the other direction: instead of a shortcut inflating a score, **refusing the shortcut deflates one**, and averaging over an unbalanced subtask mix makes the less heuristic model look worse. Any benchmark with a heuristic-solvable majority prices reasoning negatively.

---

## Ablations — which component buys which task

| BIB task | LSTM context | GCN state enc. | Local edges only | Remote edges only | **Full IRENE** |
|---|---|---|---|---|---|
| Preference | 48.2 | 49.7 | 50.0 | 50.7 | 48.5 |
| Multi-Agent | 49.7 (chance) | 50.3 (chance) | **98.0** | 50.0 (chance) | 74.9 |
| Inaccessible Goal | 84.8 | 58.1 | 41.7 | 71.6 | 85.8 |
| Eff. Path Control | 97.3 | 94.7 | **31.8** | 90.8 | 98.1 |
| Eff. Time Control | 99.9 | 98.5 | **37.2** | 99.3 | 100.0 |
| Eff. Irrational Agent | 52.4 (chance) | 89.3 | **99.4** | 79.2 | 85.7 |
| Inst. Blocking Barrier | 83.2 | 48.0 | 45.6 | 83.1 | 83.5 |

*(Absolute-score table; the paper's Table 2 reprints the IRENE column with Multi-Agent at 79.4 and Inaccessible-Goal/Remote at 80.6 where Tables 1/5 give 74.9 and 71.6 — an unresolved internal inconsistency, and the quoted "+48.9 % over Video-RNN" implies 74.9.)*

Three findings worth exporting:

1. **The edge vocabulary is task-specific and no single choice dominates.** Local-only edges take Multi-Agent to 98.0 and Irrational Agent to 99.4 — *both better than the full model* — while destroying Path Control (31.8) and Time Control (37.2), because local adjacency leaves the agent node isolated whenever nothing is next to it. Remote-only is near-full everywhere except Multi-Agent, which drops to chance. The full model's union is a compromise that is optimal on nothing. This is gap **G12** in miniature: the relational vocabulary that a task needs is task-dependent, and the architecture has no way to select one — it must be handed the union and dilute.
2. **Cross-trial binding needs both a set-structured encoder and a non-recurrent context.** Swapping the transformer for an LSTM sends Multi-Agent *and* Irrational Agent to chance while leaving everything else intact; swapping GraphSAGE for GCN destroys the obstacle tasks (Inaccessible Goal 58.1, Blocking Barrier 48.0). Only the conjunction reaches 74.9 on Multi-Agent. The paper's proposed reason for GraphSAGE is **inductivity** — a learned aggregator embeds nodes never seen in training, which is what evaluation-set entities are.
3. **Nothing anyone tried moves Preference.** Every row of the ablation table, every training-task subset, both readout statistics: 46.5–50.7. Preference is the one task where the required latent (this agent likes *that* object) has to persist across trials *and* survive a change in the object's position, and a next-position regressor trained on expected-only test trials appears to have no gradient toward it.

---

## Training-task composition — the first curriculum ablation in the wiki's BIB material

BIB's training split has four tasks: **S** Single-Object, **P** No-Navigation Preference, **M** Single-Object Multi-Agent, **I** Agent-Blocked Instrumental Action. IRENE was retrained on all 15 non-empty subsets.

| Observation | Numbers |
|---|---|
| **The matched training task alone does not buy the matched evaluation task** | Training on **M** only: Multi-Agent 51.5 (chance). Training on **P** only: Preference 48.5, unchanged. Reason given for M: in M the preferred object sits next to the agent, so the agent barely moves and the model never learns movement dynamics |
| **An unrelated task supplies the missing ingredient** | **MP** → Multi-Agent 80.4, the best score in the whole study, because P is where the agent traverses the grid |
| **Adding a third, unrelated task destroys it again** | **IMP** → Multi-Agent 51.4. I (trapped agent, key, lock) shares no structure with Multi-Agent and interferes |
| **Dropping a task can raise an average** | **MPS** (no I) → Instrumental Action average 80.4 vs full training's 71.5 — entirely because omitting barrier knowledge restores the straight-line heuristic that wins No Barrier (84.8) and Inconsequential Barrier (92.7), while Blocking Barrier collapses to 63.6 |
| **Full training is best overall but not per-task** | IMPS total average 75.4 vs MPS 75.1 |

**(brainstorm)** This is the sharpest instance the wiki has of gap **G32**: transfer between training and evaluation tasks here is **non-monotone and non-local** — the useful ingredient is a *behavioural statistic* (does the agent traverse the grid?) rather than task identity, and adding data that lacks it is worse than not adding data. A curriculum designer that reasoned over task labels would pick M for Multi-Agent and get chance. The generalisable rule is that the curriculum unit should be the *distribution of latent-variable variation* a task induces, not the task's name.

---

## Metric fragility — the readout statistic changes the ranking

Expectedness is `max_t` prediction error by benchmark convention; Gandhi et al. justify max over mean, Hein et al. report the opposite.

| Task | VT max | VT mean | IRENE max | IRENE mean |
|---|---|---|---|---|
| Multi-Agent | 49.2 | 49.1 | **74.9** | 63.6 |
| Eff. Irrational Agent | 34.1 | 29.5 | **85.7** | 81.2 |
| Inst. Blocking Barrier | 64.2 | 82.1 | 83.5 | **99.4** |
| Inst. Action avg | 84.7 | 92.6 | 71.5 | 78.5 |

A 16-point swing on Blocking Barrier (83.5 → 99.4) and an 11-point swing the other way on Multi-Agent, from a choice of summary statistic over frames that no theory fixes. **The violation-of-expectation protocol certifies a *relative* judgement without labels or distribution shift (its virtue, gap G17) — but only after a free parameter, "which moment of the error trace counts as surprise", has been chosen; and that parameter is fitted, informally, on the results.** Recorded as [[wiki/empirical-tensions.md]] T146.

---

## Comparison to infants

Against z-scored looking times from Stojnić et al. 2023 on a BIB subset: IRENE's expected/unexpected pattern aligns with infants on Inaccessible Goal, Efficient Action, Inefficient Action and Instrumental Action — it is the only model that is more surprised by the unexpected outcome in **Inefficient Action**, where the others invert. Multi-Agent is an outlier for *every* model *and* for the infants, who did not react as the benchmark predicts. Alignment on the aggregate direction says nothing about the mechanism: the same profile is produced here by a next-position regressor with no agent variable at all ([[wiki/concepts/shortcut-learning.md]], Morgan's Canon).

---

## What it is evidence for

| Claim | Strength |
|---|---|
| **Symbolic input is not what separates HBToM from neural baselines** | Strong. Matched input, same episodes, and IRENE is still at chance on Preference (48.5 vs 99.7) and 25 points down on Multi-Agent. Directly weakens Position B of T21 |
| **A relational encoder + set-structured context recovers *some* cross-trial, per-entity binding** | Moderate. Multi-Agent 74.9 vs ~48–50 for all prior neural models is real and needs both components; but 74.9 is not 99.2, and the mean-error readout drops it to 63.6 |
| **Prediction error as a surprise signal is fundamentally under-typed** | Strong, by construction. A scalar max-MSE cannot say *which* expectation broke, so a task whose two continuations differ in the same positional magnitude is invisible to it — which is a candidate account of the Preference floor |
| **Learning barriers costs benchmark points** | Strong within BIB, and a general warning about subtask averaging |
| **The model "reasons" about goals and preferences** | Weak. No latent in the model corresponds to a goal or a preference; the claim rests entirely on downstream accuracy |

---

## Comparison table

| | **IRENE** | [[wiki/entities/hbtom.md]] | VT (Hein & Diepold 2022) |
|---|---|---|---|
| Input | Symbolic scene graph from BIB JSON | Symbolic states from BIB JSON | Video frames via CNN |
| Agent model | None — implicit in a pooled context vector | Explicit: `θ_n` preferences, `β_n` rationality, Boltzmann-over-Q policy | None |
| Cross-trial mechanism | Mean of 8 transformer `CTX` embeddings | Dirichlet–categorical conjugate update | Cross-attention over frames |
| Environment dynamics | Learned implicitly by next-position regression | Hand-written PDDL + A\* | Learned implicitly |
| Surprise readout | `max_t` MSE, scalar | Product of three per-latent TV/likelihood surprises, each through a fitted logistic | `max_t` MSE, scalar |
| Preference / Multi-Agent | 48.5 / 74.9 | 99.7 / 99.2 | 80.8 / 49.2 |
| Irrational Agent | 85.7 | 96.6 | 34.1 |

---

## Open problems

- **Preference is untouched by anything in the paper.** No architecture variant, curriculum subset or readout moves it off chance. Either the required latent is not learnable from next-position regression on expected-only training trials, or a scalar error readout cannot express its violation.
- **The scalar readout is the prime suspect and was never varied structurally.** HBToM's decomposition of surprise *by latent* is exactly what IRENE lacks; nothing prevents attaching several typed prediction heads to the same encoder and reading their errors separately.
- **The edge vocabulary is authored.** All four relation families are hand-written predicates over grid coordinates, so IRENE discovers node embeddings and edge *weights*, never edge *existence* or edge *types* — the same corner of [[wiki/concepts/latent-graph-discovery.md]] HBToM occupies, reached by a different route.
- **No belief variable**, as in HBToM: false belief is out of reach for the whole BIB line.
- **The reported tables disagree with each other** (Multi-Agent 74.9 vs 79.4; Inaccessible-Goal/Remote 71.6 vs 80.6) and no erratum exists.
- **Benchmark scarcity is the stated bottleneck.** The authors could not evaluate on AGENT because no code or data was released, and report that re-implementation from the paper failed — one reason no published model compares on both.

---

## Connections

- **[[wiki/entities/hbtom.md]]** — the matched-input control for it: same benchmark, same symbolic JSON, no authored agent model, and the gap survives — which is what converts T21 from "the state space explains it" to "the state space does not explain most of it".
- **[[wiki/concepts/shortcut-learning.md]]** — the cleanest instance of a shortcut *penalising* the model that refuses it: IRENE loses 20–40 points on the two Instrumental subtasks solvable by heading straight at the goal, so the subtask average rewards heuristics and the aggregate hides a reversal.
- **[[wiki/concepts/core-knowledge.md]]** — refines the agent-system status line: deep networks on inverse-planning scenarios do not fail uniformly, they fail *complementarily*, with no neural model above chance on both Preference and Irrational Agent.
- **[[wiki/concepts/latent-graph-discovery.md]]** — a second BIB row with the same latent (which object the agent wants) but a learned instead of authored use of it; nodes, edge types and dynamics are all given, so the only thing discovered is an embedding.
- **[[wiki/concepts/event-segmentation.md]]** — the negative control for the typed-boundary argument: a single scalar max-MSE surprise signal cannot say which expectation was violated, and the tasks IRENE floors on are exactly the ones whose violation is not a positional-magnitude violation.
- **[[wiki/concepts/meta-learning.md]]** — a curriculum ablation with a non-monotone result: the matched training task alone gives chance, an unrelated task supplies the missing behavioural statistic, and a third destroys it again — so the outer-loop task distribution cannot be selected by task identity.
- **[[wiki/concepts/subgraph-matching.md]]** — the same relational-GNN toolkit (message passing over typed edges, learned aggregators) applied to a scene rather than to a query graph, and with the same limitation: the edge set is supplied by hand-written predicates.
- **[[wiki/concepts/simulation-based-planning.md]]** — the contrast case for inverse planning: IRENE reaches comparable or better scores on efficiency subtasks with **no** forward planner and no utility inversion, so those subtasks do not license the inference that a planner is being inverted.
- **[[wiki/concepts/compositionality.md]]** — objects are recovered and relations are supplied here, which is the opposite arrangement to the caption-network failure: given the relation slot for free, the model still cannot bind a preference to an entity.
- **[[wiki/entities/arc-agi.md]]** — the other benchmark-design pole: ARC withholds the transformation and supplies no state, BIB supplies the state and withholds the disposition; IRENE shows the second design is still not saturated by a model that reads the state.
- **[[wiki/concepts/violation-of-expectation.md]]** — the protocol this page's results are scored by, and where this page's discovery (the error statistic is a free parameter worth 16 points) sits alongside the control that fixes a different one: a matched untrained-network null, which no BIB number here has.
- **[[wiki/entities/agent-benchmark.md]]** — the benchmark this page's authors wanted and could not run, and the one that answers the same "matched inputs" question with the opposite sign: matching *symbols* leaves the structured model's advantage intact (this page), matching *pixels* takes both models to .65 and .51.
- **[[wiki/concepts/cross-modal-grounding.md]]** — the control that generalises this page's null: hand-supplied typed spatial relations fail to produce binding here, and language-supplied relational vocabulary fails at web scale there, so the deficit is neither the architecture's lack of edges nor the corpus's lack of relational words.
