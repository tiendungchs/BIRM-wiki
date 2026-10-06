# Priority Tasks

What to read or write next. Derived from [[wiki/architectural-gaps.md]], from open problems on concept pages, and from lint passes. Reordered whenever a gap opens or closes. Closed rows are deleted — the gitlog is the changelog.

## Now

| # | Task | Why | Blocked on |
|---|---|---|---|
| P35 | **Run `T405`'s forced-action test** — the machine half costs nothing | Force an agent's actions by an external controller for `N` trials under zero reward, release, measure the logit bias by `N`. Model-free cache (A) predicts no bias; value-free habit store (B, [[wiki/concepts/value-free-habit.md]]) predicts bias growing in `N`. `L1`, and the first row in the file whose discriminating experiment needs no environment reward | Ready to attempt |
| P36 | **Acquire wave 29** — 5 filed (521+1+5), 1 clipped unfiled, 4 on the want-list | Anchored on the targets lint(29) left unacquired and wave 28's three. **Filed** (`8e2dbcd`, wave-29 block): `T407`'s reverse case (Bowles et al. 2007, PNAS); the perirhinal-cortex page (Brown & Aggleton 2001, Nat. Rev. Neurosci., not independent of the Aggleton-lab pages); `T408`'s active-vs-passive record (Shinder & Taube 2014 ×2; Dugué et al. 2017, eLife, cerebellar re-encoding of self-generated head motion). **Clipped, not filed**: Dale & Cullen 2017, Cereb. Cortex — macaque ventral posterior lateral thalamus cancels actively generated vestibular input (~80%) only when the sensory consequence matches the motor expectation (`T408`, Position B); the filename fails clip-check. **On `_work/want-list.md`**: `G101` (Sherwood et al. 2020 via PMC8463089 — the OUP route was the unreachable one; Herculano-Houzel & Kaas 2011), `T405` (Greenstreet et al. 2025, a value-free action prediction error — not design (i)), `T406` (Nachum et al. 2019). `T405` design (i): no source found | Human clipping (want-list P1–P4); filing the Dale & Cullen clip |
| P33 | **Back one agent's subgoal currency, and give it a balance** (`G125`, `G127`) | Cheapest `L1` experiment in the file. `G125`: per-option scalar `w_o ∈ [0,1]`, `r̃ = w_o` on termination, Pavlovian update. Read-outs: farming failure gone? `w_o` → empirical P(reward)? survives devaluation until run unbacked? `G127`: accumulate `r̃` in a policy-visible register, deliver to critic on its own schedule; test = ED/UD preference reversal | Ready to attempt |
| P29 | **Four-cell valence × action design on a wiki agent** (`G116`) | Every result behind `T122`/`T85` populates only the congruent cells. Score a Go/No-Go gating agent ([[wiki/entities/pbwm.md]] first) on all four at matched difficulty; predicted deficit in `reward × No-Go` and `punishment × Go` | Ready to attempt |
| P17 | **Run the two routers head to head** (`T283`) | Generative (Bayes over models) vs discriminative router: two wiki entities take opposite sides, never run on each other's benchmark. `T283` closes on an experiment, not a source — the discriminative side is already paged (Shazeer 2017, Fedus 2022 ×2, Andreas 2016). Also supplies `G12`/`G91`'s router | Ready to attempt |
| P4 | **Ablate the interface** — learnable hybrid unit vs fixed converter, matched architecture | `T235` is `LIVE — B asserted, not measured`. [[wiki/concepts/transthalamic-context-routing.md]]: an inter-module edge carries two cargoes on two routes — the second channel may be what to ablate | Ready to attempt |
| P12 | **Re-price `G37` against the retrieval result** | [[wiki/entities/cn-dpm.md]]: forgetting 0.0, gating 48.18% at 5 components, 31.14% at 20. `G37` is the fastest-growing cell in the file | Ready to attempt |
| P6 | **Score one joint-embedding model on held-out *transformations*** | [[wiki/concepts/manifold-untangling.md]]'s criterion is stronger than the linear probes 17 entity pages report; one protocol change re-prices all of them and supplies `L6`'s column | Ready to attempt |
| P5 | **Report units-to-competence for anything** | Only admissible evidence for the spiking substrate if its advantage is unit count (`T234`). Derivable from existing runs | Ready to attempt |
| P22 | **Run the effective-model ladder on one wiki architecture** | [[wiki/concepts/multi-token-embedding.md]]: replace each component with the simplest stand-in, report accuracy per rung. Runnable on [[wiki/entities/othellogpt.md]] (= `P13`(a)) | Ready to attempt |
| P7 | **Run `I8` and `I9` against the wiki's own entity pages** | The two instruments needing only the model itself; tests the inventory's cost ordering as a claim | Ready to attempt |
| P23 | **Re-score one benchmark null under a second frame** (`T291`) | Cooperative vs competitive framing flips comparative-cognition results. Every wiki null used one frame → ambiguous between absent and undeployed capability (`G102`) | Ready to attempt |
| P10 | **Run the `g`/`x` objective search, collapse filter first** | `G30` is the deepest gap. A candidate must separate a real structural code from a constant `g` ([[wiki/concepts/representational-collapse.md]]) | Ready to attempt |
| P9 | **Build the write-mask experiment (`G52`), and `G64` with it** | Cheapest concrete architecture proposal. Baseline: uniform reservoir sampling, which beat every priority rule tested | `P4` |
| P8 | **Collect a per-item human error *profile* on one benchmark** | [[wiki/concepts/human-baseline.md]] job 4, `F4`: aggregate parity is compatible with an orthogonal mechanism (.90 vs .91 accuracy at 0.06 profile correlation) | Human curation, or a re-analysis request |

## Next

| # | Task | Why | Blocked on |
|---|---|---|---|
| P28 | **Write the missing overview sections** | Thematic body ends at section 17; ~167 of 521 sources sit outside it. Owed: (i) router and edge (MoE, deep-RL artefacts, continual-learning baselines, IRM, robustness instruments); (ii) per-tension adjudications; (iii) arrangement, objective, parts that reject; (iv) cortical channel and its rulers (waves 22–23: `T371` `T374` `T376` `T377` `T378` `T379` `T341` — a revision to the thesis); (v) what a store's discreteness is a property of (wave 25: `K^max = α_n N^{n−1}`, `T389` `T392`–`T394` `G123` `G124`); (vi) how a want is built (wave 26: `G125`–`G129` — no self-generated motivational quantity has an update rule); (vii) what a connection buys and what a measurement may claim (wave 27: `G101`, `T405`, `T406`, higher-order interactions, amnesic probing, causal scrubbing); (viii) the Papez loop as two efferent routes, a content wire and a clock wire that merge one synapse later, and the integrator whose input is not a sensor (wave 28: `T381`, `T407`, `T408`, `G54`, `G39`, `G92`). (vi) is the warmest | Ready to attempt |
| P25 | **Edge-density scaling** (`G101`) | 2.75× cortical volume on 1.25× the neurons — the difference is connections; no wiki result says what a higher synapse-per-unit ratio buys. Wave-27 block A acquired it (Mocanu 2018, RigL, Galakhova 2022, Aizenbud 2026); `L3`, so it lands as prose — now ingested: [[wiki/entities/sparse-evolutionary-training.md]], [[wiki/entities/rigl.md]], [[wiki/entities/human-supragranular-pyramidal-neuron.md]], [[wiki/concepts/neuron-complexity-index.md]]. Cross-species invariance unsettled (`P36`) | Ready to attempt |
| P24 | **Give one architecture a growth schedule** (`G100`) | [[wiki/concepts/developmental-heterochrony.md]]: a vector of per-module phase offsets over a conserved trajectory, sparse (~4% of components). Nothing in the wiki has a growth schedule | Ready to attempt |
| P11 | **Score architectures against the six hardness sources** | A facet vector, not a scalar (`G13`). 118 entity pages, instrument still empty | Ready to attempt |
| P13 | **Run the two specified-and-unrun world-model experiments** — (a) probe/ablate OthelloGPT end-game features (`T157`/`T158`); (b) LeJEPA rescaled-loss checkpoint ranking vs a patch-token probe | `P22` supplies the method for (a); `T285`: every "not decomposable" verdict so far dissolved under a better frame | Ready to attempt |
| P14 | **Merge the two de-aliasing mechanisms on paper**: [[wiki/entities/cscg.md]]'s frozen clone pools vs path-integrated position | Clone pools are the rate-level answer to element distinctness, which one spiking neuron computes in a single unit (`G80`) | — |
| P15 | **Run the `γ_effective` readout** | `T141` is `LIVE`: if the kernel is hyperbolic, `δ` is an error on a quantity with no stationary value function | Ready to attempt |
| P16 | **Instrument one existing store with a read log** | Log *which* structure was retrieved; score schedule separately from contents. Number to beat: [[wiki/entities/cn-dpm.md]] gate at 31.14% (20 components) | Ready to attempt |

## Structural work

| # | Task | Why |
|---|---|---|
| L36 | **Write the associative-memory *store* page** | Mechanism on 22 pages, concept page on none (7 concept / 15 entity). [[wiki/concepts/key-value-memory.md]] owns the address half; the storage rule and its capacity bound are scattered across [[wiki/concepts/attractor-dynamics.md]], [[wiki/concepts/retrieval-capacity.md]] and five entity pages. Primary sources on disk. Highest-value structural row |
| L40 | **Adjudicate the 45 rows cited by ≤ 1 concept/entity page** — *ruling needed* | Unchanged at lint(30). Lint(29) tally: 6 gaps (`G55` `G86` `G87` `G88` `G98` `G103`), 39 tensions (`T9`…`T380`). Step 5's second demotion criterion: each is re-levelled or `git mv`d to `closed/`. None is `L3`/`L4`, so `S19` cannot reach them; not acted on without a ruling |
| L41 | **Reconcile `AD`'s head-direction fraction** — *ruling needed* | [[wiki/entities/anterior-thalamic-nuclei.md]]'s three-nuclei table gives `AD` ~60% heading cells (Aggleton & O'Mara 2022); the same page's Cullen & Taube paragraph and [[wiki/entities/head-direction-system.md]] give ~50%. Two sources, two numbers, neither page names the gap. Fix is one clause naming both sources |
| L42 | **Move the `AD` manifold section to the head-direction page?** — *ruling needed* | [[wiki/entities/anterior-thalamic-nuclei.md]] (44 KB, four sources) carries Chaudhuri 2019's ring/cone result, which is about the heading population, not the nuclei's memory role. [[wiki/entities/head-direction-system.md]] now exists and links to it only by mention. Not overloaded by size (median page 23 KB, largest 148 KB); a placement question |
| L43 | **Update retrosplenial's meeting-point claim** | [[wiki/entities/retrosplenial-cortex.md]]'s Connections entry to [[wiki/entities/mammillary-bodies.md]] still calls retrosplenial cortex the most plausible site where heading and theta meet. The mammillary page's own entry, and [[wiki/entities/anterior-thalamic-nuclei.md]], already record Jankowski 2013's earlier meeting point in `AV`. One sentence |
| L44 | **Add `VR` to the glossary, or rule it common** | On 12 pages, expanded inline on none consistently, absent from [[wiki/glossary.md]]. Wave 28 used it in a registry row (`T408`) |
| L39 | **Write a dynamic-sparse-training concept page** | Prune-and-regrow is on two entity pages ([[wiki/entities/sparse-evolutionary-training.md]], [[wiki/entities/rigl.md]]) and cited from 8 more; `G101` is `L3`, so its content belongs in a concept body, which does not exist. Evci 2020 (the mask that only wins while it moves) sits inside the RigL page with no home of its own |
| L38 | **Re-verify carried rows that assert something is missing** — *ruling needed: `S22`?* | `L20`/`P26` asserted a page missing that had existed six days. Mechanical half: any row claiming a page/file/source is missing, while the link resolves on disk → hard fail. Judgement half stays with lint |
| L37 | **Work down `S21`'s 215 grandfathered one-way row references** | Baseline exact (0 stale). Proposed quota: 20 oldest pairs per pass → retired in 11 passes. Only row in the file with a finite, counted end state |
| L34 | **Enforce `ACQUIRE` before a wave enters `raw/`** — *choice pending* | Waves 26–27 followed the order voluntarily; nothing requires it. Options: `ACQUIRE` in reconcile mode over unqueued files, or `S15` distinguishing queued rows with/without a gap tag |
| L31 | **`T276` and `T344`: one wire, four proposed cargoes** — *ruling needed* | Not merged. Precedent favours a sibling note: `S12` resolved four such pairs that way (`T373`↔`T377`, `T374`↔`T376`, `T378`↔`T379`, `T341`↔`T380`) |
| L29 | **Make [[wiki/concepts/latent-graph-discovery.md]] navigable** | 146 KB, largest page, and the CLAUDE.md tiebreaker. Cheapest probe: count sections reachable from its opening framing. Waves 25–26 are not reachable from it |
| L27 | **Read the 108 grandfathered `L3`/`L4` rows directly** | Flat for nine passes. `S19` holds the entry point; neither demotion criterion reaches the block. Population — gaps `L0=28 L0-INSTR=13 L1=23 L2=44 L3=18 L4=1 META=1`; tensions `L0=38 L0-INSTR=64 L1=77 L2=86 L3=73 L4=16 META=6` (lint 30) |
| L22 | **Escape `\|` inside table cells** | `S4` violations come in two classes: escaping (notation-heavy waves — conditional/cardinality bars in inline code) and short rows (any wave). Tally over five passes: 1/7, 0/1, 6/7, 7/7, 1/1 escaping |
| L17 | **Audit `Closes when` fields against their evidence** | `S17`: 0 unset over 484 rows; ~290 criteria still unread against their evidence |
| L16 | **Insert glossary rows by section, not by append** | `S13` catches duplicate keys, not rows under the wrong heading (64 ML rows once sat under `## Benchmarks`) nor one key with two meanings (`CPM`, `PC`) |
| L8 | **Mark one `Connections` edge per page as primary** | 9,454 untyped edges over 411 pages; density per page now flat |
| L6 | **Decide whether the 17 joint-embedding entity pages stay separate** | Several defer their central claim to [[wiki/concepts/representational-collapse.md]]; shared comparison table missing from most. `P6` supplies its column |

## Standing

| # | Rule | Last state |
|---|---|---|
| S1 | Keep `Connections` bidirectional | 0 on entry at lint(30) |
| S2 | Lint after ~every 20 ingests | Last pass after 5 (lint(30), user-requested) |
| S3 | Re-run `./tools/qmd-index.sh` after each ingest | A stale index hides existing pages and causes duplicates |
| S4 | Check table rows by column count — reset expected width at every table boundary | 1 on entry at lint(30) (`P("old" \| studied)` in inline code), escaping, repaired; see `L22` |
| S5 | Overview's source count is checked and exits non-zero | Repaired to 521 at lint(30) |
| S5b | Overview's tension count likewise | Repaired to 360 at lint(30) |
| S6 | Write abbreviations the way the glossary lists them | `CPM` split into a two-sense row at lint(28) |
| S7 | A concept reaching ~50% of a host page is a page — and the host need not be a page | Converse case live: `L36` |
| S8 | Every cited `G`/`T` identifier has a row; no row shares an identifier | Clean |
| S9 | A number quoted against a human is incomplete without its protocol; a capability number without its frame (`T291`) | — |
| S10 | Every published self-count names the command that produces it — and something runs it | Held |
| S11 | Check source integrity through `https://status.claude.com/api/v2/incidents.json`, not the status page | Clean window through wave 28: three elevated-error incidents since lint(29) (2026-09-29 14:00–14:59 UTC, all products; 2026-10-05 12:40–13:10 UTC, Fable 5.1; 2026-10-06 12:24–12:43 UTC, Opus 5.5); no commit inside any of them |
| S12 | Check both registries for cross-topic duplicates by reading, not by `grep` | 0 merges at lint(30) (`T407` read against `T358`; `T408` against `T31`, `T46`, `T344`) |
| S13 | No glossary key may appear twice | Clean; blind to one key with two meanings (`S6`) |
| S14 | A registry row and its carrying pages must cite each other, both directions | 0 uncited gaps, 0/360 uncited tensions (lint(30)) |
| S15 | The queue must reconcile exactly against `raw/` | OK at lint(30): 521+1+0 |
| S18 | A gap's `## From` names its carrying pages; each should cite the gap back | 0 on entry at lint(30) |
| S19 | The level-admission rule | Clean; 108 grandfathered (`L27`) |
| S20 | A pending queue row must be *true* | OK; not yet exercised against a real defect |
| S21 | A registry row that names another row must be named back | 1 on entry at lint(30) (`T407` → `G42`), repaired; 215 grandfathered (`L37`) |
