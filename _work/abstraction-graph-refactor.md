# Abstraction-graph refactor — working page

Temporary. Holds the decisions of the 27-29 October 2026 grilling sessions and the pass plan, so each pass can be run in a fresh session with full context. Delete when pass 7 is committed. Read [[wiki/concepts/abstraction-graph.md]] and `CLAUDE.md` before any pass.

---

## 1. What the page is, after this session

- The page reasons **from the problem side** (world, reasoning benchmarks, games) toward the brain. It is a set of **predictions** about how an ideal bounded agent would internalise, compress and retrieve its world's structure. The predictions may be wrong; evolution may have found cleverer, simpler or more roundabout ways.
- Derivation order: **setup → limits → `L0` features → consequences → `L1` rows → Correspondence (brain)**.
- `L0` is the **first-principles frontier**. It is pushed further over time. A feature is deleted only when it is wrong or genuinely irrelevant. A feature that forces no row stays (horizon, generality ordering stay).
- The requirements table is **where the frontier currently meets the brain**, not a selection criterion on `L0`.
- The brain never adds a row. A region mechanism no row predicts is recorded as a **miss** on this page (§ Correspondence misses), not as a row.

## 2. Decisions (settled)

| # | Decision |
|---|---|
| D1 | Table stays `L1`. `L2` content (row 6's three legs, row 14's two readings, right-frontal vs rostrolateral dispute) is evicted to the region pages; `L3` (row 11) leaves the table, the `L0` paragraph "plasticity falls out of the node kind" stays |
| D2 | Unit of a row: one `L0` feature (stated, or a consequence written into `L0`) → the `L1` component it forces. Construction is canonical: for each feature, the minimal component that holds it |
| D3 | Admission: a row is required if without it the abstraction graph would not look the way it looks; admissible only if `L1` and derived from the question "how would an ideal bounded agent internalise and compress its world's structure" |
| D4 | Completeness check is **one-directional**: every row must cite a feature; a feature need not force a row |
| D5 | `L0` gains a **"follows from"** column on every `L0` table, citing a limit or an earlier feature; a feature citing nothing is marked **posited**. Every consequence a row uses is written into `L0` as a stated feature (e.g. relations as objects ⇒ relations between relations) |
| D6 | Limits are upstream of the graph, in two groups, closed list, at the top of the page: **from the setup** (partial perception, time, energy, finite experience, a goal that sets the query distribution) and **to exclude the degenerate agents** (memory, to exclude the lookup table; compute, to exclude the simulator). The second group is a definitional choice and the page says so |
| D7 | The **setup paragraph** (an agent in a world with a goal, perceiving a sliver of the state at a time; the analogy of every reasoning benchmark) lives on [[wiki/concepts/latent-graph-discovery.md]]; this page cites it |
| D8 | Brain column renamed **Correspondence**, capped at region + owning page + registry ID. Grades: `necessity` (lesion/perturbation on the predicted function), `candidate` (correlational or model of the region), `none`, `contradicted` (tissue demonstrably does it another way). Contest = a tension ID in the cell, not a grade |
| D9 | Correspondence names only regions with an entity page; otherwise `none`. Regions named today without a page go to `wiki/priority-tasks.md` as acquisition targets |
| D10 | **Correspondence misses** section under the table: what the three key regions have that no row predicts, one line each; a registry row only when sharp enough to be a tension. Audited against [[wiki/entities/lateral-frontoparietal-network.md]], [[wiki/entities/medial-prefrontal-cortex.md]], [[wiki/entities/hippocampal-formation.md]] only |
| D11 | Status column = Correspondence only. Realisation status, the reference-model column and the Tests table are **removed**; instruments and realisations are the dev project's job |
| D12 | Predictions P1–P7 stay as a **Predictions** list, one line each, citing the feature each follows from, no instrument |
| D13 | **Unplaced** list under the table for demoted rows: component forced by a limit with no feature in between, one line saying which limit forces it and which feature is missing |
| D14 | Row 5 repaired: "two registers per node, access cost and precision, on different timescales"; "parallel stores" moves to Correspondence. Row 10 demoted to Unplaced. Row 14 kept, its feature written into `L0` |
| D15 | Renumber (no stable IDs) in `L0` section order; sweep the citing pages |
| D16 | Holding-state store table moves to a **new concept page** (memory stores side by side); this page keeps one sentence: the stores run in parallel, not as a ladder |
| D17 | CLAUDE.md abstraction-graph bullet reworded: the table is where first-principles predictions about an ideal bounded agent meet the brain; a mechanism is load-bearing when it is the Correspondence of a row; a model page cites the row it approximates. Title "Architectural requirements" kept |
| D18 | Row-to-model pairings lost with the model column: user re-homes them later (model page Connections cite the row). Not part of these passes |
| D19 | Table is the sixteen rows of §5, in `L0` section order. The AND-OR controller is forced by the Edge (framing = choosing `R` moves to Predictions); the precondition check is forced by Fidelity alone (an exact rule's precondition is its binding); the store that outlives the episode is forced by the Node (a schema transfers across situations), "meta-graph" dropped from its text |
| D20 | Three rows added from walking the loop observation → facts → applicable schemas → chain → prediction → next observation → offline compression: a **generaliser** (Fidelity's induction sentence), **content-addressed retrieval** from lit facts to applicable schemas (Direction: derivation runs upward), a **comparator** routing prediction error along the provenance cone (Precision: updated by evidence) |
| D21 | Parallel stores: D14 stands (Correspondence of the two-registers row only); the claim itself is stated on the stores page; the last pass audits the claim, which the user is still skeptical of |
| D22 | Grading: a lesion null on the predicted function grades `candidate`, with the null stated in the cell; no fifth grade |
| D23 | **Replaces D9's `none`.** A region without an entity page is cited in the cell by a priority-task ID (`P<n>`), one task per region, created in the last pass; the ID is swapped for the page link when the page is ingested. A sub-region carried on a network page (inferior parietal, dorsolateral, rostrolateral nodes of lateral-frontoparietal-network) is cited as "node, page" plus the pending `P<n>` |
| D24 | A mechanism with no region (cortical coarse-graining, option initiation sets): name the region where the mechanism is measured, else `none` |
| D25 | A perturbation that hits the row's component on a neighbouring function grades `necessity` with the gap stated in the cell (what the row predicts that the experiment did not test) |
| D26 | Unplaced holds old row 10 (experience selection: finite experience + time + a goal, no feature) and the **individuator** (which parts of the sliver are one individual, and is it the one from the last step: partial perception + time; the Node's individual sort has no persistence feature). Query generation is out of scope: one line under "How this page is used" says the query is posed by the goal, not by the table |

## 3. Pre-audit of the current fourteen rows

| Outcome | Rows |
|---|---|
| Derived from a stated `L0` feature, `L1` — keep, renumber | 1, 2a, 2b, 3, 4, 6, 7, 8, 9, 12, 13 |
| Keep after repair (D14) | 5 |
| Keep; consequence to be written into `L0` (relations as objects ⇒ relations between relations) | 14 |
| Demote to Unplaced (forced by a limit, no feature) | 10 |
| Drop from table (`L3`) | 11 |

`L0` features forcing no row today (all stay, D4): horizon axis, generality ordering, OR-edges as alternative derivations, innate provenance value, precision propagation, meta-graph as least general generalisation.

## 4. Passes

One commit per pass. Each pass starts by reading this page, CLAUDE.md and the files it touches.

| Pass | Scope | Files | Done when |
|---|---|---|---|
| 1 | Setup paragraph (D7): agent, world, goal, sliver perception; setup limits named; link to this page | `wiki/concepts/latent-graph-discovery.md` | Paragraph in place, Connections entry to abstraction-graph updated |
| 2 | Limits section (D6) at the top of the page; "follows from" column on Two graphs / Nodes and edges / Three axes / Agent-side attributes / Budgets (D5); posited marks; consequences needed by rows written in (D5, D14) | `wiki/concepts/abstraction-graph.md` | Every `L0` row cites a limit or feature or is marked posited |
| 3 | **Draft** the re-derived table in § 5 below: ID, requirement, forced by (feature), Correspondence cell, grade. User reviews row by row | this page | **Done** (29 October 2026): every row approved |
| 4 | Three `L0` sentences only (D5 for the rows of D20): Direction's "derivation runs upward from premises" written as a stated feature, not notation, naming the retrieval row it forces; Fidelity's induction sentence naming the generaliser row; Precision's "updated by evidence" naming the comparator row. Nothing else | `wiki/concepts/abstraction-graph.md` | Each of rows 8, 9, 12 cites a sentence in `L0` that names it |
| 5 | Apply: replace the table with § 5; remove model column, Tests table, realisation status (D11); add Correspondence misses (D10), Unplaced (D13, D26), Predictions (D12, framing = choosing `R` among them); evict `L2` to region pages (D1); rewrite "How this page is used" (query posed by the goal, D26) | `wiki/concepts/abstraction-graph.md`, region pages receiving `L2` | Page matches §1–§2; no `L2` dispute left in a cell |
| 6 | Stores concept page (D16): the nine-row holding-state table, bidirectional Connections with every page the table cites; index-concepts row; one sentence left here; the parallel-stores claim stated there as that page's `L1` claim | new `wiki/concepts/<stores>.md`, `wiki/index-concepts.md`, `wiki/concepts/abstraction-graph.md`, cited pages | Page exists, links bidirectional |
| 7 | Sweep (D15, D23, D17): renumber row citations on the pages listed below; CLAUDE.md bullet; one priority-task row per region in § 6, IDs written back into the Correspondence cells; glossary if new abbreviations; **audit the parallel-stores claim** (D21): list what on the cited pages shows the stores are not stages of one another, and what would show they are | pages below, `CLAUDE.md`, `wiki/priority-tasks.md` | No stale row number anywhere (`grep "row [0-9]"` against the new numbering); audit written on the stores page; this page deleted |

Pages citing the table by row number (sweep scope for pass 7; re-grep in pass 7, since "rows 2a, 9 and 11" escapes the simple pattern):

- `wiki/concepts/exact-coarse-graining.md`
- `wiki/concepts/hippocampal-long-axis.md`
- `wiki/concepts/latent-graph-discovery.md`
- `wiki/concepts/simulation-based-planning.md`
- `wiki/entities/lateral-frontoparietal-network.md`
- `wiki/entities/medial-prefrontal-cortex.md`
- `wiki/entities/hippocampal-formation.md`

## 5. Re-derived table (pass 3 draft — approved 29 October 2026)

Old row numbers in the last column. `P<n>`: priority-task ID to be created in pass 7 (D23).

| # | Requirement | Forced by (`L0` feature) | Correspondence | Grade | Old |
|---|---|---|---|---|---|
| 1 | Store items are typed schemas with free variables: relations held as objects | Node | inferior parietal node, [[wiki/entities/lateral-frontoparietal-network.md]]: activation scales with relation count, items and relations separate load currencies; posterior-lesion null at `n = 74` (Mole 2025); `G104`; page pending `P<n>` | candidate | 1 |
| 2 | A store that outlives the episode that lit a schema | Node: a schema transfers across situations, so it must outlive the episode | [[wiki/entities/medial-prefrontal-cortex.md]]: remote-delay lesion deficits across six tasks, the mapping stored there by ~30 d; `T97`; gap: what is measured is a ground-fact mapping, not a schema | necessity, gap stated | 13 |
| 3 | A binder for ground facts: content joined to a position or context in one shot | Edge, exact instantiation at the fact end | [[wiki/entities/hippocampal-formation.md]]: CA1 one-shot write, long-axis binding of non-adjacent elements; CA1 NMDA-receptor deletion in the week after training blocks the memory ([[wiki/concepts/complementary-learning-systems.md]]); gap: no encoding-time perturbation on any page | necessity, gap stated | 2a |
| 4 | A binder for schemas: which element of the instance fills which free variable (role-filler alignment) | Edge, exact instantiation at the schema end | rostrolateral node, [[wiki/entities/lateral-frontoparietal-network.md]] and [[wiki/entities/lateral-frontal-pole.md]]: 0.33 cc left lesion abolishes analogy and spares match (Urbanski 2016); `T336`; own page pending `P<n>` | necessity | 2b |
| 5 | An AND-OR controller: choose the derivation to expand, stop at lit premises | Edge: OR alternatives, expand until every premise is lit | dorsolateral node of [[wiki/entities/lateral-frontoparietal-network.md]]: effort scales with difficulty, not with relational structure; same tissue as row 10 at the resolution of necessity; `G73`; page pending `P<n>` | candidate | 8 |
| 6 | A lossy abstraction operator with an error register `ε` per coarse concept | Fidelity, lossy | operator: the hippocampal long axis, place fields widening tenfold dorsal to ventral ([[wiki/entities/hippocampal-formation.md]], [[wiki/concepts/hippocampal-long-axis.md]]); `ε` register: no tissue named, `none` for that half | candidate | 4 |
| 7 | Precondition check at the stated grain before a lossy schema is applied | Fidelity, lossy: `ε` holds only at the grain it was estimated at | ventral tier of [[wiki/entities/medial-prefrontal-cortex.md]] receives only the coarse end of the long axis, so the grain it checks at is fixed anatomically ([[wiki/concepts/hippocampal-long-axis.md]]); anatomy only, no perturbation | candidate | 12 |
| 8 | A generaliser: instances to a schema with free variables, values to a coarse variable | Fidelity: induction lights a deep node from many shallow lit facts | the slow learner extracting the association among items it already represents ([[wiki/entities/medial-prefrontal-cortex.md]], [[wiki/concepts/complementary-learning-systems.md]]); CA1 as recombiner, `T33`; no perturbation on generalisation itself on any page | candidate | new (D20) |
| 9 | Content-addressed retrieval: from lit facts to the schemas whose preconditions they fill | Direction: derivation runs upward from premises to conclusion | [[wiki/entities/hippocampal-formation.md]]: cue-dependent completion returns every candidate and the controller selects (Preston & Eichenbaum 2013, [[wiki/concepts/schema-assimilation.md]]); the perturbation result is on the controller, not on retrieval | candidate | new (D20) |
| 10 | Variable-length chaining: an inference-time loop whose length is set by the query | Length | dorsal-tier prefrontal to basal-ganglia loop, [[wiki/entities/medial-prefrontal-cortex.md]], rat, human homologue not established; dorsolateral node of [[wiki/entities/lateral-frontoparietal-network.md]] scales with difficulty; `G107`; page pending `P<n>` | candidate | 3 |
| 11 | Width: `k` mutually irreducible structures co-held apart while a conclusion forms | Width | rostrolateral node of [[wiki/entities/lateral-frontoparietal-network.md]]: fan-in lesion (Urbanski 2016) or right frontal parallel occupancy (Mole 2025, `n = 247`); `T336`, `T338`; same tissue as row 4 | necessity | 14 |
| 12 | A comparator: score each prediction against the next observation, route the error along the provenance cone to precision, `ε`, suppression and cache value | Precision: updated by evidence, step scaled by information gained | value channel: [[wiki/entities/ventral-tegmental-area.md]], dopamine transients necessary and sufficient for the learning product ([[wiki/concepts/state-prediction-error.md]]); state channel: entorhinal layer Vb as comparator, brainstorm only ([[wiki/entities/entorhinal-cortex.md]]); gap: routing along a provenance cone untested | necessity, gap stated | new (D20) |
| 13 | A context-gated suppressor for refuted nodes | Suppressed: never deleted, context-gated | ventral tier of [[wiki/entities/medial-prefrontal-cortex.md]]: inactivation makes dorsal hippocampus retrieve both the licensed and the unlicensed representation; legs (i)–(iii) evicted to [[wiki/entities/hippocampal-prefrontal-channel.md]] and the region page (D1); infralimbic extinction leg pending `P<n>`; `G110`, `T98`; gap: refutation of a lit schema untested | necessity, gap stated | 6 |
| 14 | A provenance pointer per lit node | Provenance | [[wiki/entities/hippocampal-formation.md]]: reinstatement of the intermediary at choice time (Barron et al. 2020, [[wiki/concepts/offline-replay.md]]); `G71` | candidate | 9 |
| 15 | Access cost and precision as separate registers per node, on different timescales | Two registers per node | the stores side by side (stores page, pass 6); precision register per [[wiki/concepts/precision-weighting.md]]; no single tissue; `T392`, `T135` | candidate | 5 |
| 16 | A cache policy approximating `frequency × value × cost saved / memory` | Cache objective | [[wiki/entities/hippocampal-formation.md]]: replay priority fits gain × need ([[wiki/concepts/simulation-based-planning.md]]); frequency gate: dorsolateral striatum lesion leaves learning intact and keeps overtrained pressing devaluation-sensitive ([[wiki/entities/basal-ganglia.md]]); `T81` | candidate | 7 |

Dropped from the table: old 10 → Unplaced (D26); old 11 → `L3`, the `L0` plasticity paragraph stays (D1).

**Unplaced (D13, D26)**

| Component | Forced by (limit) | Missing feature |
|---|---|---|
| Experience selection priced by `λ` | finite experience + time + a goal | none between the limits and the component; `G129` |
| An individuator: which parts of the sliver are one individual, and is it the one from the last step | partial perception + time | the Node's individual sort has no persistence-across-observations feature |

**The loop the three new rows came from** (for pass 5's "How this page is used"): observation → factorise into typed facts over individuals (3, Unplaced individuator) → light the schemas the facts match (9) → bind and check (4, 7) → iterate: chain, hold `k`, choose, stop (10, 11, 5, 6) → prediction at horizon `h`, lit with provenance (14) → next observation: compare and credit (12) → offline: generalise and decide what to keep lit (8, 16). The query is posed by the goal, outside the table.

## 6. Regions named without an entity page (for priority-tasks, pass 7)

Compiled from the § 5 Correspondence cells. One priority-task row each (D23); the `P<n>` is written back into every cell that cites the region.

| Region | Cells | Carried today on |
|---|---|---|
| Inferior parietal cortex | 1 | [[wiki/entities/lateral-frontoparietal-network.md]] |
| Dorsolateral prefrontal cortex | 5, 10 | [[wiki/entities/lateral-frontoparietal-network.md]] |
| Rostrolateral prefrontal cortex, as a page of its own | 4, 11 | [[wiki/entities/lateral-frontoparietal-network.md]], [[wiki/entities/lateral-frontal-pole.md]] |
| Infralimbic cortex | 13 | [[wiki/entities/medial-prefrontal-cortex.md]], [[wiki/entities/basal-ganglia.md]] |

"Cortical coarse-graining" is dropped: it names no region (D24).
