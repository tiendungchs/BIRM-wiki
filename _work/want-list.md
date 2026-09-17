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

### Wave 21 — the BIRM requests `R1`, `R2`, `R4`, `R5`

Targets for the four open rows of `../BIRM/STATUS.md` § Requests to the wiki. Each is anchored to a
registry row as usual; the request number is carried in the *Closes* column after the `G`/`T` token,
because a request closes only when `../BIRM/DESIGN.md` has been updated from the ingest.

**Probe results, all 16 fetched 2026-09-17.** Nature-family URLs answer `303 → idp.nature.com`
(session wall to `WebFetch`, not a paywall verdict); `cell.com`, `pnas.org`, `sciencedirect.com`
and `annualreviews.org` answer `403` (bot-block, likewise not a verdict) — all `clip` through the
institution. PLOS, Frontiers and `ar5iv` rendered full text with equations inline and are still
`clip`, not `self`: they carry the figures and formalism a `WebFetch` markdown pass flattens.

#### `R1` — appetitive and aversive as separate circuits

| # | Target | Clip URL | Venue | Route | Closes | Settles | Status |
|---|---|---|---|---|---|---|---|
| 1 | Namburi et al. 2015, *A circuit mechanism for differentiating positive and negative associations* | `https://www.nature.com/articles/nature14366` | Nature 520(7549):675–678 | `clip` | `T355`, `G116` · `R1` | **The row that decides whether two channels is a biological fact or a design choice.** Basolateral amygdala neurons projecting to nucleus accumbens versus centromedial amygdala undergo *opposing* synaptic changes after reward versus fear conditioning — separation by projection target, with the cognition held fixed. It is also the design `G116` asks for: valence crossed against a fixed behavioural read-out | `open` |
| 2 | Hu, Cui & Yang 2020, *Circuits and functions of the lateral habenula in health and in disease* | `https://www.nature.com/articles/s41583-020-0292-4` | Nat. Rev. Neurosci. 21(5):277–295 | `clip` | `T355`, `T132`, `T133` · `R1` | **The habenula is named in four wiki rows and has no page.** The anti-reward hub's afferents (limbic forebrain, basal ganglia) and efferents (every major midbrain neuromodulatory system) are the wiring that would make an aversive channel a channel rather than a sign bit. Basis for an entity page | `open` |
| 3 | Matsumoto & Hikosaka 2007, *Lateral habenula as a source of negative reward signals in dopamine neurons* | `https://www.nature.com/articles/nature05860` | Nature 447(7148):1111–1115 | `clip` | `T355`, `G116` · `R1` | The primary measurement of the inversion: habenula neurons excited by the no-reward-predicting target and inhibited by the reward-predicting one, dopamine neurons the mirror image, in one task. `T355` asks what the second channel carries; this is the upstream source it would have to come from | `open` |
| 4 | Shabel, Wang, Monk, Aronson & Malinow 2019, *Stress transforms lateral habenula reward responses into punishment signals* | `https://www.pnas.org/doi/full/10.1073/pnas.1903334116` | PNAS 116(25):12488–12493 (probe `403`, bot-block) | `clip` | `T355` · `R1` | **The "made too easy to trigger" half of `R1`, on the aversive side.** The same cells' responses change *sign* under chronic stress, so the aversive channel's gain is a state variable and not a constant — which is a claim about the channel form in `DESIGN.md` § 3, not only about the circuit | `open` |
| 5 | Robinson & Berridge 2025, *The incentive-sensitization theory of addiction 30 years on* | `https://www.annualreviews.org/content/journals/10.1146/annurev-psych-011624-024031` | Annu. Rev. Psychol. (probe `403`, bot-block) | `clip` | `G118` · `R1`, `R4` | The same question on the appetitive side: what happens when the reward channel is made hypersensitive. Wanting grows without liking growing — the double dissociation `G118`'s `Closes when` demands, here in its pathological limit, and the wiki holds only the 2016 statement of the split | `open` |
| 6 | Cardinal, Parkinson, Hall & Everitt 2002, *Emotion and motivation: the role of the amygdala, ventral striatum, and prefrontal cortex* | `https://www.sciencedirect.com/science/article/abs/pii/S0149763402000076` | Neurosci. Biobehav. Rev. 26(3):321–352 (abstract-only to the probe → institutional HTML) | `clip` | `G118`, `G116` · `R1`, `R4` | The one review that treats appetitive and aversive conditioning, and **conditioned reinforcement**, as one anatomy: basolateral amygdala for a cue's access to the current value of the specific outcome, central nucleus for brainstem arousal. Serves both requests from one ingest | `open` |

#### `R2` — intermediate goals under a terminal signal alone

| # | Target | Clip URL | Venue | Route | Closes | Settles | Status |
|---|---|---|---|---|---|---|---|
| 7 | Ribas-Fernandes et al. 2011, *A neural signature of hierarchical reinforcement learning* | `https://www.cell.com/neuron/fulltext/S0896-6273(11)00499-5` | Neuron 71(2):370–379 (probe `403`; open mirror `pmc.ncbi.nlm.nih.gov/articles/PMC3145918/` if the session fails) | `clip` | `G33` · `R2` | **The mechanism candidate `R2` asks biology for.** A *pseudo-reward* prediction error, measured in anterior cingulate cortex at a subgoal no primary reward marked — an internal signal that makes a self-set intermediate goal trainable by the same rule as a real one | `open` |
| 8 | Solway et al. 2014, *Optimal behavioral hierarchy* | `https://journals.plos.org/ploscompbiol/article?id=10.1371%2Fjournal.pcbi.1003779` | PLoS Comput. Biol. 10(8):e1003779 | `clip` | `G33` · `R2` | `G33` closes on a configurator that *selects* a subgoal sequence and has no criterion for selecting; this states one — Bayesian model evidence, equivalently the bits needed to specify a hierarchical policy — and reports that the optimum cuts the task graph at **topological bottlenecks**, which humans find unprompted. Directly readable against [[wiki/concepts/latent-graph-discovery.md]] | `open` |
| 9 | Machado, Bellemare & Bowling 2017, *A Laplacian framework for option discovery in reinforcement learning* | `https://ar5iv.labs.arxiv.org/html/1703.00956` | ICML 2017 / arXiv:1703.00956 (probe: full text, MathML) | `clip` | `G33`, `G61` · `R2` | The reward-free extreme of `R2`: **eigenpurposes** `rᵉ(s,s′) = eᵀ(φ(s′) − φ(s))` — subgoals read off the eigenvectors of the transition graph's Laplacian, with the environment reward never consulted, each option acting at its own timescale. The `G61` half: an exploration set derived from structure rather than scheduled | `open` |
| 10 | Andrychowicz et al. 2017, *Hindsight experience replay* | `https://arxiv.org/html/1707.01495v3` | NeurIPS 2017 / arXiv:1707.01495 (arXiv HTML build flagged experimental; fall back to `ar5iv.labs.arxiv.org/html/1707.01495`) | `clip` | `G72`, `G33` · `R2` | **The literal form of `R2`'s question in machine learning: a binary terminal reward and nothing else.** Every trajectory is relabelled with the goal it actually reached, so the subgoal curriculum is manufactured from failures rather than designed. The cheapest existing answer, and the baseline any BIRM claim about invented intermediate goals must beat | `open` |

#### `R4` — learned wants from a reward channel alone

| # | Target | Clip URL | Venue | Route | Closes | Settles | Status |
|---|---|---|---|---|---|---|---|
| 11 | Zhang, Berridge, Tindell, Smith & Aldridge 2009, *A neural computational model of incentive salience* | `https://journals.plos.org/ploscompbiol/article?id=10.1371%2Fjournal.pcbi.1000437` | PLoS Comput. Biol. 5(7):e1000437 | `clip` | `G118`, `T356` · `R4` | **The only running two-term model the wiki can reach.** `wanting = κ(state) · V̂(cue)`, where `κ` re-values a cue with no new learning — the independently ablatable pair `G118`'s `Closes when` specifies, and position A of `T356` in closed form rather than as a citation | `open` |
| 12 | Gottlieb & Oudeyer 2018, *Towards a neuroscience of active sampling and curiosity* | `https://www.nature.com/articles/s41583-018-0078-0` | Nat. Rev. Neurosci. 19(12):758–770 | `clip` | `G72`, `T358` · `R4`, `R5` | `R4`'s hardest sub-question — can the chain reach activities that never predicted a primary reward — put as a distinction between *sampling* (reduce uncertainty in a known task) and *search* (find out what the tasks are). Preferences over cognitive states as the heuristic; the open case `G72` needs, where rewards are sparse and **unknown in advance** | `open` |

#### `R5` — drives beyond the terminal reward

| # | Target | Clip URL | Venue | Route | Closes | Settles | Status |
|---|---|---|---|---|---|---|---|
| 13 | Oudeyer & Kaplan 2007, *What is intrinsic motivation? A typology of computational approaches* | `https://www.frontiersin.org/journals/neurorobotics/articles/10.3389/neuro.12.006.2007/full` | Front. Neurorobot. 1:6 (probe: full text, formulas inline) | `clip` | `G72`, `G30` · `R5` | **The map `R5` is missing.** Knowledge-based against competence-based against morphological, each with an explicit reward formula — uncertainty motivation `r(e) = C/P(e)`, information gain, **learning progress**, flow. It says which of `R5`'s candidates are the same quantity under two names and which are genuinely separate, before any of them is built | `open` |
| 14 | Ten, Kaushik, Oudeyer & Gottlieb 2021, *Humans monitor learning progress in curiosity-driven exploration* | `https://www.nature.com/articles/s41467-021-26196-w` | Nat. Commun. 12 (2021), doi `10.1038/s41467-021-26196-w` | `clip` | `G89`, `T358` · `R5` | Learning progress as its **own measured quantity** allocating free-exploration time, not as the replay priority the wiki currently holds it as ([[wiki/concepts/replay-prioritisation.md]]). `G89` wants an architecture that models its own competence; this is the behavioural evidence that biology does, with the assay stated | `open` |
| 15 | Shenhav, Botvinick & Cohen 2013, *The expected value of control* | `https://www.cell.com/neuron/fulltext/S0896-6273(13)00607-7` | Neuron 79(2):217–240 (probe `403`, bot-block) | `clip` | `G102`, `T356` · `R5` | The effort half of `R5` as an explicit *subtracted* term with an anatomy: expected payoff, amount of control to be invested, cost of cognitive effort. `G102` wants a standing dispositional gate distinct from task reward before the valuation, not a magnitude at choice time — this is the closest existing formalism | `open` |
| 16 | Salge, Glackin & Polani 2013, *Empowerment — an introduction* | `https://ar5iv.labs.arxiv.org/html/1310.1863` | arXiv:1310.1863 (probe: full text, equations inline) | `clip` | `G30` · `R5` | `G30` lists empowerment as a candidate objective and has never held its definition. Here it is closed-form — `𝔈 := C(Aₜ → Sₜ₊₁) = max_{p(aₜ)} I(Sₜ₊₁; Aₜ)` — a task-independent quantity to climb once the terminal reward is reached, plus a continuous-domain approximation that makes it computable | `open` |

**Counts.** Wave 21: 16 targets, all `clip`, none `self`, none `pdf`. With the two Wave-20 leftovers
above, **18 open rows** — one wave (`S2`). By request: `R1` 6, `R2` 4, `R4` 2 (plus rows 5 and 6,
which serve it too), `R5` 4 (plus row 12). `R3` is closed on the BIRM side as a code lookup and has
no row here.
