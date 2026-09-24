# Want-list — sources to acquire

Produced by the `wiki-acquire` skill, part A. Consumed by the human's Obsidian Web Clipper.
Nothing is clipped that is not on this list; every row names the registry row it settles.

**This file holds the ACTIVE want-list only.** A row leaves it the moment it is filed
(it is then tracked in `_work/manifest.tsv` and `_work/ingest-queue.md`) or the moment it
is judged unreachable (recorded once under the wave's *Not acquired* line in
`_work/ingest-queue.md`, then dropped). No archive, no history — the gitlog is the changelog.

**Access:** institutional (UBO Brest) — a paywall is not a filter. The filter is **HTML vs PDF**:
a PDF conversion is lossy on exactly the equations and figures the wiki needs.

**Route column:** `clip` = human, Obsidian Web Clipper · `self` = Claude fetches and writes `raw/` ·
`pdf` = last resort, `./tools/pdf2md.sh`, flagged `LOSSY`.

**Status column:** `open` → `clipped` → `filed` (then the row is deleted from this file).

After clipping, drop the files in `raw/` and run:

```bash
./tools/clip-check.sh              # validate every untracked file in raw/
./tools/clip-check.sh --manifest raw/<file>.md   # then file the manifest row
```

---

## Active

**Wave 27 — what a connection buys, what runs out, and what a measurement is allowed to claim.**
Twenty targets. Unlike wave 26, this wave is not anchored on the sibling project's requests: it is
anchored on the registries themselves, and specifically on rows whose `Closes when` names a
measurement that a *published* source may already have run. Every row below names the `G`/`T` row it
serves and the decision that row currently cannot make.

**What the three carried acquire rows in [[wiki/priority-tasks.md]] did with this pass:**

- **`P25` (`G101`, edge-density scaling)** — worked, block A. This is the wave's largest block
  because `G101` is answerable from two directions the wiki has never put side by side: the machine
  side varies edge count at a *fixed* unit count as a matter of routine, and the biological side now
  has a per-neuron complexity index that prices dendritic surface and synaptic nonlinearity
  directly. `G101` is `L3`, so per `CLAUDE.md` these four land as concept/entity prose, not as new
  registry rows.
- **`P17` (`T283`, generative vs discriminative router)** — **not worked, and it should stop being
  an acquire row.** `T283`'s `Closes when` asks for CH-HNN's gating accuracy against ground truth
  and for the two routers on each other's benchmark. That is an experiment, not a source; and the
  discriminative pole is already paged from primary sources (`raw/shazeer-2017-…`,
  `raw/fedus-2022-switch-transformers.md`, `raw/fedus-2022-sparse-expert-models-review.md`,
  `raw/andreas-2016-neural-module-networks.md`). *Suggested edit: re-file `P17` as an experiment row
  in the `Now` table and strike its `Blocked on: human curation or a web-search pass`.*
- **`P19` (Shift-MNIST, unfair dSprites)** — **not worked**, on the row's own reasoning: it records
  that [[wiki/entities/waterbirds.md]] closed `I1`'s image half with a chosen confound rate, a
  worst-group read-out and the regularisation reversal, which makes the two remaining benchmarks
  redundant with it rather than blocking. *Suggested edit: retire `P19`.*

**Probe results, all 2026-09-23/24.** `ar5iv.labs.arxiv.org` renders `1604.06057`, `1805.08296`,
`1712.00948`, `1810.12894`, `2002.06038`, `1705.05363`, `1911.11134`, `2006.01764`, `2008.04948`,
`1809.09401`, `2212.10509` and `2006.00995` in full, equations and figure captions inline.
`arxiv.org/html/2310.11511v1` exists (post-2023 native HTML). `journals.plos.org` renders in full.
`nature.com` answers `303` to its identity provider on both Nature Communications rows — **gated,
therefore `clip`** per the skill's rule, and both articles are open access, so the browser will
serve the full text. `cell.com` (Trends in Cognitive Sciences, Neuron) and `pnas.org` answer `403`
to `WebFetch`: a **bot-block, not a paywall verdict** — Cell Press, Neuron and PNAS are all in the
skill's preferred-venue table and reachable through the institution (waves 22–24 precedent).
`pmc.ncbi.nlm.nih.gov` answered a reCAPTCHA page on `PMC13367794` during this pass — transient
bot-throttling, not a gate; PMC is always open, and the bibliographic detail was confirmed from the
publisher record instead. `alignmentforum.org` returns a **JavaScript shell** to `WebFetch` (header
and title only): the Web Clipper renders it in a real browser, so the row stays `clip`, and the
fallback is the greaterwrong mirror of the same post id.

**Dropped, and the row that stays unsettled.** Sherwood, Miller, Karl, Stimpson, Phillips, Jacobs,
Hof, Raghanti & Smaers 2020, *Invariant synapse density and neuronal connectivity scaling in primate
neocortical evolution* — synapse density over 25 primate species, the single most direct read on
`G101`'s biological half. It is in **Cerebral Cortex** (`academic.oup.com/cercor`, **excluded
venue**), has **no PMC deposit**, and the Trinity institutional-repository record is a landing page
whose only full-text link is the same `cercor` DOI. `G101`'s cross-species invariance claim therefore
stays unsettled; rows A3 and A4 work the per-neuron side of it instead.
No target duplicates a `_work/manifest.tsv` row (493 rows checked) or a file in `raw/` (484 checked).

#### A — `G101`: what an edge buys that a unit does not

`G101` (`L3`, `OPEN`, 3 cites): *nothing in the wiki scales edge density rather than unit count, and
no result says what a higher synapse-per-unit ratio buys.* `Closes when` an experiment scales edge
density at fixed unit count and separates the effect from adding units.

| # | Target | Clip URL | Venue | Route | Closes | Settles | Status |
|---|---|---|---|---|---|---|---|
| A1 | Mocanu, Mocanu, Stone, Nguyen, Gibescu & Liotta 2018, *Scalable training of artificial neural networks with adaptive sparse connectivity inspired by network science* | `https://www.nature.com/articles/s41467-018-04316-3` | Nat. Commun. 9:2383 | `clip` | `G101` | **The edge budget as the independent variable, with the unit count held fixed.** Sparse evolutionary training keeps the layer widths of a dense network and removes a fixed fraction of the *connections*, then re-grows them during training — so the topology, not the width, is what varies. This is `G101`'s experiment with the sign flipped: it prices what edges are *worth removing*, and the Erdős–Rényi → scale-free drift it reports is a claim about which edge distribution a task wants. Fallback URL if the publisher misbehaves: `https://ar5iv.labs.arxiv.org/html/1707.04780` | `open` |
| A2 | Evci, Gale, Menick, Castro & Elsen 2020, *Rigging the lottery: making all tickets winners* | `https://ar5iv.labs.arxiv.org/html/1911.11134` | ICML 2020 | `clip` | `G101` | **The only probed source that reports accuracy at a matched parameter count with connectivity varied — which is `G101`'s separation, stated as a control.** RigL's Figure 2 runs a sparse network against a *Small-Dense* network of equal parameter count (74.6% vs 72.1%, ResNet-50/ImageNet at 80% sparsity), so the gain is attributable to *where* the edges are rather than to how many there are. Read A1 and A2 as one pair: A1 varies density, A2 holds the budget and varies the topology | `open` |
| A3 | Galakhova, Hunt, Wilbers, Heyer, de Kock, Mansvelder & Goriounova 2022, *Evolution of cortical neurons supporting human cognition* | `https://www.cell.com/trends/cognitive-sciences/fulltext/S1364-6613(22)00208-X` | Trends Cogn. Sci. 26(11):909–922 | `clip` | `G101`, `G105` | **The biological statement of why `G101` is not a unit-count question.** Human supragranular expansion is argued to come from dendritic size and complexity and from fast signalling properties rather than from neuron number, with the per-individual correlation to cognitive ability — i.e. the wiki's scaling arguments are indexing the wrong variable. It also supplies the claim `G105` needs downstream: a single human neuron performing computations "similar to a multilayered network", which is an `n`-ary integration claim about one unit | `open` |
| A4 | Aizenbud, Yoeli, Beniaguev, de Kock, London & Segev 2026, *Dendritic morphology and synaptic nonlinearities enhance functional complexity in human cortical neurons* | `https://pmc.ncbi.nlm.nih.gov/articles/PMC13367794/` | PNAS 123(28):e2533168123 | `clip` | `G101`, `G105`, `T234` | **The sharpest row on the wave for `G101`, because it prices the ratio instead of describing it.** The Functional Complexity Index is a deep-learning read-out of a single cell's input–output map, so the human–rat gap is *decomposed* into expanded dendritic surface plus denser and more nonlinear NMDA signalling — a number for what a synapse-per-unit increase buys, at a unit count of exactly one. It also re-prices `T234` (whether the spiking substrate's advantage is unit *count*) from the other direction, and the layerwise divergence (complexity peaking in L2/3 in humans, L5 in rats) is an allocation claim no wiki architecture can express | `open` |

#### B — `T367` / `G33` / `G126`: the subgoal channel, and what schedule it runs on

`T367` (`L2`, `LIVE`, **14 cites** — the wiki's most-cited live `L2` row): *is the subgoal-level
prediction error carried on its own channel, or on the reward channel with the running option as a
mask?* Its own file names a cheaper experiment than the anatomy in `Closes when`: **three
architectures now span gradient-coupled single channel, gradient-severed simultaneous dual channel,
and phase-separated dual channel, and no source runs both schedules on one architecture.** The wiki
holds the single-channel pole ([[wiki/entities/option-critic.md]]) and one own-channel instance
([[wiki/entities/feudal-networks.md]]) and nothing else. Block B buys the missing schedules.

| # | Target | Clip URL | Venue | Route | Closes | Settles | Status |
|---|---|---|---|---|---|---|---|
| B1 | Kulkarni, Narasimhan, Saeedi & Tenenbaum 2016, *Hierarchical deep reinforcement learning: integrating temporal abstraction and intrinsic motivation* | `https://ar5iv.labs.arxiv.org/html/1604.06057` | NIPS 2016 | `clip` | `T367`, `G33`, `G126` | **The phase-separated dual channel, and the wiki's missing third architecture for `T367`.** h-DQN gives the meta-controller and the controller *separate* critics with separate replay, the lower one trained on a hand-specified intrinsic reward for reaching an object; the two are trained in alternating phases rather than simultaneously. Under the row's own brainstorm this is the schedule that makes calibration vacuous and staleness certain, so it is the prediction to check. For `G33` it is the honest negative: the subgoal *set* is designer-given, so a configurator selecting from the world model's own state is still unbuilt | `open` |
| B2 | Nachum, Gu, Lee & Levine 2018, *Data-efficient hierarchical reinforcement learning* | `https://ar5iv.labs.arxiv.org/html/1805.08296` | NeurIPS 2018 | `clip` | `T367`, `G126` | **The gradient-severed simultaneous dual channel, and it names staleness as its central problem.** HIRO's lower level sees only a goal vector and its own intrinsic distance reward; the levels train *at the same time*, which makes the higher level's transitions invalid as the lower policy changes — and the off-policy relabelling correction exists precisely to repair that. `T367`'s brainstorm predicts staleness is self-correcting under simultaneity: HIRO is the source that says what the correction costs | `open` |
| B3 | Levy, Konidaris, Platt & Saenko 2019, *Learning multi-level hierarchies with hindsight* | `https://ar5iv.labs.arxiv.org/html/1712.00948` | ICLR 2019 | `clip` | `T367`, `G33` | **Three levels trained in parallel, which is the schedule variable pushed to its limit.** HAC's claim is the first successful *parallel* learning of a 3-level hierarchy in continuous state and action spaces, achieved with two hindsight transition types that manufacture a stationary target for a level whose subordinate is still moving. Read against B1 and B2 this completes the schedule axis: alternating (B1), simultaneous with an importance correction (B2), simultaneous with a counterfactual relabelling (B3) — one comparison, three papers, and `T367` can then be re-priced on performance without any anatomy | `open` |

#### C — `G129` / `T358`: the intrinsic reward that runs out

`G129` (`L1`, `OPEN`, 7 cites): *every intrinsic reward in the wiki is exhausted by learning; none
reads the structure of the agent's own store, so none can grow.* `Closes when` an agent's intrinsic
reward is a query over its own store **and** its per-step profile is shown to differ from every
exhaustible bonus. The wiki cannot currently run that comparison, because **it holds no primary
source for any of the three baselines the row names** — novelty, prediction error, learning progress
(only [[wiki/concepts/learning-progress.md]]'s typology, Oudeyer 2007, is paged). Block C buys the
control condition.

| # | Target | Clip URL | Venue | Route | Closes | Settles | Status |
|---|---|---|---|---|---|---|---|
| C1 | Pathak, Agrawal, Efros & Darrell 2017, *Curiosity-driven exploration by self-supervised prediction* | `https://ar5iv.labs.arxiv.org/html/1705.05363` | ICML 2017 | `clip` | `G129`, `T358` | **`G129`'s prediction-error baseline, and the paper that shows why the exhaustion is not a bug but the definition.** ICM's reward *is* forward-model error in an inverse-dynamics feature space, so it falls to zero exactly where the model becomes right — monotone decreasing by construction. Its feature-space choice is also the wiki's cleanest statement of the noisy-TV failure, which is the discrimination `T358`'s irreversibility measure needs | `open` |
| C2 | Burda, Edwards, Storkey & Klimov 2018, *Exploration by random network distillation* | `https://ar5iv.labs.arxiv.org/html/1810.12894` | ICLR 2019 | `clip` | `G129`, `T358` | **`G129`'s novelty baseline, in the form the row must beat.** RND's bonus is the error of a predictor chasing a fixed random target, so it is a pure state-visitation count in disguise: it decays with exposure and cannot rise, whatever the domain size. It is also the first agent past average human performance on Montezuma's Revenge without demonstrations, so the baseline is not a straw man | `open` |
| C3 | Badia, Sprechmann, Vitvitskyi, Guo, Piot, Kapturowski, Tieleman, Arjovsky, Pritzel, Bolt & Blundell 2020, *Never give up: learning directed exploration strategies* | `https://ar5iv.labs.arxiv.org/html/2002.06038` | ICLR 2020 | `clip` | `G129`, `T358`, `G123` | **The closest published attempt at `G129`'s non-exhaustion, and the row turns on whether it counts.** NGU multiplies an *episodic* novelty term by a *lifelong* RND modulator specifically to keep the bonus from vanishing over training — but both factors are still visitation statistics, not a query over what the agent knows, so the profile can be held up rather than made non-monotonic. Reading it is how `G129` learns whether "reads the structure of its own store" is a real distinction or a restatement of episodic memory; the episodic-memory read per step also bears on `G123` | `open` |

#### D — `G105`: a relation among three or more

`G105` (`L0`, `OPEN`, 11 cites): *every graph-discovery mechanism in the wiki estimates pairs;
nothing infers a relation among three or more elements from data.* `Closes when` a learner infers an
`n`-ary relation directly — **not by composing or thresholding pairwise scores** — and recovers
structure no pairwise estimator on the same data can.

| # | Target | Clip URL | Venue | Route | Closes | Settles | Status |
|---|---|---|---|---|---|---|---|
| D1 | Young, Petri & Peixoto 2021, *Hypergraph reconstruction from network data* | `https://ar5iv.labs.arxiv.org/html/2008.04948` | Commun. Phys. 4:135 | `clip` | `G105`, `G16`, `G17` | **The single most on-target row of the wave: it is `G105`'s `Closes when`, already run.** A Bayesian generative model infers latent hyperedges from *pairwise* observations, and its stated baseline is maximal-clique decomposition — i.e. exactly the "thresholding pairwise scores" that `G105` rules out — which it beats in description length. It also hands `G16` (the intended graph is not identifiable from data alone) a worked case where identifiability is bought with a parsimony prior instead of an assumption, and `G17` a certification criterion that is not a downstream task score | `open` |
| D2 | Battiston, Cencetti, Iacopini, Latora, Lucas, Patania, Young & Petri 2020, *Networks beyond pairwise interactions: structure and dynamics* | `https://ar5iv.labs.arxiv.org/html/2006.01764` | Phys. Rep. 874:1–92 | `clip` | `G105` | **The survey that says what a pairwise representation structurally cannot hold** — and it is the wave's only `S`-tier row, so it is read first in block D and mined for vocabulary rather than for results. Long (≈90 pages): read for the representation taxonomy (hypergraph vs simplicial complex, and what each one forbids) and for the dynamics results where higher-order coupling changes the *qualitative* outcome, not the constant. Ingest at a survey's grain; individual dynamics results are out of scope | `open` |
| D3 | Feng, You, Zhang, Ji & Gao 2019, *Hypergraph neural networks* | `https://ar5iv.labs.arxiv.org/html/1809.09401` | AAAI 2019 | `clip` | `G105`, `G12` | **The precise negative control for `G105`, and it should be filed as one.** HGNN's convolution consumes an `n`-ary relation, which is what the wiki lacks — but the hypergraph it consumes is *constructed beforehand by k-nearest-neighbour thresholding of pairwise feature distances*, which is verbatim the move `G105` excludes. So the pair D1/D3 separates the two halves of the row: inference of higher-order structure (D1, done) from use of it once given (D3, done), leaving the gap exactly where `G105` says it is. The typed-input side also feeds `G12`'s routing question | `open` |

#### E — `G123`: a store that reads twice

`G123` (`L2`, `OPEN`, 5 cites): *every store in the wiki reads once per query, so no retrieval can be
revised.* `Closes when` an architecture re-runs its read on unchanged input and shows the benefit
comes from **re-deciding**, not from spending more compute.

| # | Target | Clip URL | Venue | Route | Closes | Settles | Status |
|---|---|---|---|---|---|---|---|
| E1 | Trivedi, Balasubramanian, Khot & Sabharwal 2023, *Interleaving retrieval with chain-of-thought reasoning for knowledge-intensive multi-step questions* | `https://ar5iv.labs.arxiv.org/html/2212.10509` | ACL 2023 | `clip` | `G123` | **The re-read, with its single-read control — and with `G123`'s compute confound left open, which is the useful part.** IRCoT alternates one reasoning step with one retrieval, each step's last sentence becoming the next query, and beats a one-step retriever by 11–21 recall points on four multi-hop sets. But the baseline is not compute-matched, so this row *does not* close `G123`: it supplies the architecture and leaves the control to be run. File the missing control as the gap's remainder | `open` |
| E2 | Asai, Wu, Wang, Sil & Hajishirzi 2023, *Self-RAG: learning to retrieve, generate, and critique through self-reflection* | `https://arxiv.org/html/2310.11511v1` | ICLR 2024 | `clip` | `G123`, `G15`, `G107` | **Re-deciding made explicit as a learned decision, which is the half of `G123` that E1 does not have.** Reflection tokens let the model decide *whether* to retrieve and then critique what came back, so the number of reads is a policy output rather than a schedule — which makes it a candidate for `G15` (no control policy over simulation) and for `G107` (the compute/accuracy exchange rate is a hand-set constant everywhere in the wiki: here it is at least trained). Read E1 first: E1 is the mechanism, E2 is the controller over it | `open` |

#### F — `G113` / `G109`: what a probe is allowed to claim

`G113` (`L0-INSTR`, `OPEN`, 4 cites): *a probe that perturbs the system to read it is certified
read-only by a null, and no instrument in the wiki has a positive control for non-interference.*
`Closes when` a perturbation-based read-out reports a positive control, so the claim rests on a
demonstrated detection threshold rather than on a failure to reject.

| # | Target | Clip URL | Venue | Route | Closes | Settles | Status |
|---|---|---|---|---|---|---|---|
| F1 | Elazar, Ravfogel, Jacovi & Goldberg 2021, *Amnesic probing: behavioral explanation with amnesic counterfactuals* | `https://ar5iv.labs.arxiv.org/html/2006.00995` | TACL 9:160–175 | `clip` | `G113`, `G109`, `G108` | **The controls, named and run — this is `G113`'s `Closes when` in a published method.** Iterative null-space projection removes a property from a representation and the behavioural effect is measured; crucially it reports a **random-direction removal** control (same rank reduction, no targeted information) and a **selectivity** control (re-concatenate the removed feature and re-fit). The first is the detection-threshold positive control the row asks for; the second is the discrimination that separates damage from removal. Also the method `G109`'s lesion profile needs, and `G108`'s selection criterion has to survive | `open` |
| F2 | Chan et al. 2022 (Redwood Research), *Causal scrubbing: a method for rigorously testing interpretability hypotheses* | `https://www.alignmentforum.org/posts/JvZhhzycHu2Yd57RN/causal-scrubbing-a-method-for-rigorously-testing` | Alignment Forum (Redwood Research) | `clip` | `G113`, `G17` | **The strongest available statement that an ablation must be *behaviour-preserving* to license a claim — the general form of F1's control.** Resampling ablations replace a component's input with one the hypothesis says is equivalent, so the null is "the hypothesis permits this swap" rather than "we failed to detect a change"; the recovered-performance fraction is a graded score on an interpretation, which is what `G17` asks for and no wiki instrument reports. `WebFetch` sees only the page shell (JavaScript render) — clip in the browser; mirror fallback `https://www.greaterwrong.com/posts/JvZhhzycHu2Yd57RN` | `open` |

#### G — `T2` / `G112`: which carrier holds the fast store

`T2` (`L1`, `LIVE`, 10 cites) asks whether the fast level is a separate store or recurrent activity,
and its status note says the row may **dissolve** into a change of basis — the real variables being
the fast level's degrees of freedom and decay timescale. `G112` (`L0-INSTR`, 7 cites) sharpens it:
the synaptic and activity solutions are provably the same function on structured sequence tasks.
The wiki's canonical synaptic-working-memory source, Mongillo, Barak & Tsodyks 2008, is **permanently
unobtainable** (`science.org`, excluded, recorded at wave 20 row 9).

| # | Target | Clip URL | Venue | Route | Closes | Settles | Status |
|---|---|---|---|---|---|---|---|
| G1 | Barak & Tsodyks 2007, *Persistent activity in neural networks with dynamic synapses* | `https://journals.plos.org/ploscompbiol/article?id=10.1371%2Fjournal.pcbi.0030035` | PLOS Comput. Biol. 3(2):e35 | `clip` | `T2`, `G112` | **The open-venue replacement for the wave-20 casualty, by two of its three authors, and it is the analysis `T2` actually needs.** It works out what short-term synaptic dynamics do to the *existence and stability* of attractor states — i.e. it treats the weight carrier and the activity carrier inside one model rather than as rival architectures, which is precisely the "change of basis" `T2`'s status note suspects. Read for the decay timescale and the degrees of freedom, the two variables the row says the dispute reduces to. Note the published correction (PLOS Comput. Biol. 3(5):e104) fixes equation symbols — clip it too if the clipper takes it cheaply | `open` |

#### H — `G110`: control applied to the interface, not the module

`G110` (`arrangement`, `L2`, `OPEN`, 7 cites): *top-down control is always applied to a module or its
output; nothing applies it to the interface that feeds the module.* The wiki holds the anatomy of
higher-order thalamic input (`raw/neske-2025-…`) but no result in which deactivating the relay
changes what the cortical reader can do.

| # | Target | Clip URL | Venue | Route | Closes | Settles | Status |
|---|---|---|---|---|---|---|---|
| H1 | Zhou, Schafer & Desimone 2016, *Pulvinar-cortex interactions in vision and attention* | `https://www.cell.com/neuron/fulltext/S0896-6273(15)01040-5` | Neuron 89(1):209–220 | `clip` | `G110`, `G122` | **The causal result `G110` is missing: the interface is deactivated and the reader's attentional effect collapses, while its sensory drive largely does not.** Pulvinar inactivation reduces attentional modulation of firing rate and gamma synchrony in V4 with a severe behavioural deficit in the affected field, yet attention *in the pulvinar itself* appears to reflect its cortical input — so the relay is not the source of the control signal but is necessary for its expression. That is an arrangement no wiki architecture has: a gateway whose removal costs the selection, not the signal. Cell Press answers `403` to `WebFetch` (bot-block); institutionally reachable | `open` |

#### I — `G121`: what devaluation-insensitivity identifies

`G121` (`L0-INSTR`, `OPEN`, 6 cites): *devaluation-insensitive responding is the wiki's definition of
a habit, and it does not identify one.* This is the row wave 26 opened and could not work, because
every source it acquired uses the assay it questions.

| # | Target | Clip URL | Venue | Route | Closes | Settles | Status |
|---|---|---|---|---|---|---|---|
| I1 | Miller, Shenhav & Ludvig 2019, *Habits without values* | `https://pmc.ncbi.nlm.nih.gov/articles/PMC6548181/` | Psychol. Rev. 126(2):292–311 | `clip` | `G121`, `T85`, `G119` | **The argument that the wiki's habit definition is the wrong kind of thing, made by severing habit from model-free reinforcement learning altogether.** Model-free control still computes and compares *values*, so it is not value-free and therefore not a habit in the traditional sense; the authors propose a distinct value-free class whose actions are triggered by the stimulus without evaluation. If that class exists, `G121`'s confound is worse than stated — devaluation-insensitivity is compatible with model-free value-based control, value-free control, and sensitized cue-triggered wanting, three mechanisms and one read-out. Open-access deposit; a bioRxiv v4 is the fallback | `open` |

---

**Handover.** 20 targets, all `clip`, 0 `self`, 0 `pdf` — the first wave in the file's history with
no lossy route, which is what preferring PMC, PLOS and ar5iv over publisher PDFs buys.

- **A (4)** prices `G101`'s ratio from both sides; lands as `L3` prose, no new registry rows.
- **B (3)** completes `T367`'s schedule axis so the wiki's most-cited live `L2` row can be re-priced
  on performance without waiting for cell-type-identified recording.
- **C (3)** buys `G129`'s and `T358`'s missing control condition — the three exhaustible bonuses the
  rows are defined against.
- **D (3)** is the wave's sharpest block: D1 is `G105`'s `Closes when` already run, D3 is its
  negative control.
- **E (2)**, **F (2)**, **G (1)**, **H (1)**, **I (1)** each buy one named measurement for one row.

Ingest pairings the list asks for: **A1 before A2** (density varied, then budget held and topology
varied); **B1 → B2 → B3** in schedule order (alternating, simultaneous+correction,
simultaneous+relabelling); **C1/C2 before C3** (the two exhaustible baselines before the attempt to
escape them); **D2 first in its block** as the survey, then D1, then D3 as the control;
**E1 before E2** (mechanism, then the controller over it); **F1 before F2** (the specific control,
then its general form).

Two priority-tasks edits are suggested above and **not applied**: re-file `P17` as an experiment row,
retire `P19`.
