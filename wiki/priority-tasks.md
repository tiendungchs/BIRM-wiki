# Priority Tasks

What to read or write next. Derived from [[wiki/architectural-gaps.md]], from open problems on concept pages, and from lint passes. Reordered whenever a gap opens or closes.

**Status:** eleven sources ingested (Hassabis et al. 2017; Geirhos et al. 2020; Schmidgall et al. 2023; Revencu & Csibra 2023; Hutter 2000; Spelke & Kinzler 2007; Butz 2016; Lake et al. 2017; Richards et al. 2019; Chollet 2019; LeCun 2022). The concept skeleton is still mostly single-sourced from surveys and needs primary sources behind it. Gap G17 now makes an evaluation instrument a precondition for the comparison work in P6, and the new gaps G21–G23 open a whole column — what the model is *given* — that no queued source yet covers on the machine side.

## Now

| # | Task | Why | Blocked on |
|---|---|---|---|
| P1 | Continue the current wave in `priority-ingest.md` | Ten of eleven concept pages rest on one secondary source; wave 0 supplies the framings that will test them | — |
| P2 | Ingest the primary sources behind the pages just created — `graves-2016-differentiable-neural-computer.md`, `constantinescu-2016-gridlike-code-concepts.md`, `whittington-2017-predictive-coding-approximates-backprop.md`, `wang-2018-pfc-meta-rl-system.md` | Each replaces a survey paraphrase with a checkable result, and each is the trigger for its entity page | Wave order in `_work/ingest-queue.md` |
| P3 | Acquire sources for artefacts with no file in `raw/`: deep Q-network / experience replay, elastic weight consolidation, progressive networks, episodic control, Monte Carlo tree search | These are named on five concept pages and in [[wiki/index-entities.md]] with no source behind them; claims about them are currently second-hand | Human curation (or a web search pass) |

## Next

| # | Task | Why | Blocked on |
|---|---|---|---|
| P4 | ~~Write the core-knowledge concept page~~ **done**; ~~replace the second-hand system inventory and evidence with the primary source~~ **done** (Spelke & Kinzler 2007: signature limits, the four+one inventory, cross-cultural evidence, defeasibility). Remaining: the **intuitive-physics half** — no source yet gives a *computational* account of the object system, only its behavioural signatures | The composition argument and the unitary-vs-graded dispute are still second-hand through Revencu & Csibra 2023, and nothing in the wiki says what computes an entry condition (G23) | `lake-2017-machines-learn-think-like-people.md`, plus a source on gated/conditional inductive bias (P9) |
| P5 | Decide whether disentangled/compositional representation deserves its own page — **now leaning yes** | Invoked on three pages as a passing claim, and [[wiki/concepts/core-knowledge.md]] now carries a full composition-across-modules section (gaps G21–G22) that will outgrow a section on a priors page as soon as a second source arrives | A source with an actual disentanglement or compositional-architecture result |
| P6 | Score architectures against the six hardness sources, per the placeholder in [[wiki/concepts/latent-graph-discovery.md]] | The scoring table is the wiki's comparison instrument and is still empty | Enough architecture pages to compare; **and an o.o.d. column** — per G17 an i.i.d. result cannot enter this table |
| P7 | Acquire sources for the controlled-shortcut benchmarks (Shift-MNIST / biased CelebA / unfair dSprites) and for ObjectNet / ImageNet-C | These are the only listed instruments where the intended rule is known by construction, so they are what turns "did this architecture recover structure?" into a measurement (G17) | Human curation (or a web search pass) |
| P9 | Acquire a source on *conditional* or gated inductive bias (mixture-of-experts routing, typed/sorted representations, neuro-symbolic type systems) | G23 says every machine prior applies unconditionally while every core system carries an entry test; nothing in `raw/` addresses gated priors, and G23 is the precondition for stacking priors at all | Human curation (or a web search pass) |
| P8 | ~~Write the inductive-bias page, or decide it belongs inside [[wiki/concepts/shortcut-learning.md]]~~ **partly done** — [[wiki/concepts/three-component-framework.md]] now carries the control surface, the canonical bias catalogue and the three-vs-four-lever dispute (T15). Remaining: a concrete bias-vs-solution *result*. **The loss lever is now written up and closed negatively** — [[wiki/concepts/divergence-objectives.md]] shows cross-entropy depends only on `Q`, so it cannot in principle prefer the structural rule | The four levers (architecture, data, loss, optimizer) are now the wiki's stated control surface for G16; currently they live in one section of one page | A second source with a concrete bias-vs-solution result — `deletang-2023-language-modeling-compression.md` (ingested) and `talk-nd-cross-entropy-first-principles.txt` (ingested) both bore on the loss lever; what is still missing is an *architecture*- or *data*-lever result |
| P10 | Find an objective function whose optimum is the `g`/`x` factorization — or a source that argues none exists | Gap G30: the factorization is specified architecturally and has no trainable target, so no learning rule can ascend toward it and no measurement scores distance from it. The nearest candidate shapes are constrained code length (G26), a path-commutativity residual, and now the informativeness/predictability/latent-parsimony quadruple of [[wiki/concepts/energy-based-models.md]] — the last of which has a source but no result, and comes with G34 attached | A source on structure-sensitive or disentanglement objectives; `deletang-2023-language-modeling-compression.md` bears on the loss lever |
| P11 | Ingest a source with an actual **JEPA-family empirical result** — `raw/bardes-2022-vicreg.md`, `raw/assran-2023-i-jepa.md`, `raw/assran-2025-v-jepa-2.md`, `raw/balestriero-2025-lejepa.md` are all in `raw/` | [[wiki/entities/h-jepa.md]] is the wiki's most complete design and carries zero evidence. Every claim on it — that non-contrastive training scales, that stacking produces an abstraction hierarchy, that planning works on the result — is currently the author's expectation | Wave order; these sit later in `_work/ingest-queue.md` |

## Standing

| # | Task | Why |
|---|---|---|
| S1 | Keep `Connections` bidirectional | A one-way link is a maintenance defect; caught at each lint pass |
| S2 | Lint after ~every 20 ingests | Structural decay (orphans, thin pages, unexpanded abbreviations) accumulates silently |
| S3 | Re-run `./tools/qmd-index.sh` after each ingest | The search index is what the next ingest reads first; a stale index hides existing pages and causes duplicates |

