# Priority Tasks

What to read or write next. Derived from [[wiki/architectural-gaps.md]], from open problems on concept pages, and from lint passes. Reordered whenever a gap opens or closes.

**Status:** one source ingested (Hassabis et al. 2017). The wiki now has a concept skeleton; every page on it is single-sourced from a survey and needs primary sources behind it.

## Now

| # | Task | Why | Blocked on |
|---|---|---|---|
| P1 | Continue the current wave in `priority-ingest.md` | Nine concept pages rest on one secondary source; wave 0 supplies the framings that will test them | — |
| P2 | Ingest the primary sources behind the pages just created — `graves-2016-differentiable-neural-computer.md`, `constantinescu-2016-gridlike-code-concepts.md`, `whittington-2017-predictive-coding-approximates-backprop.md`, `wang-2018-pfc-meta-rl-system.md` | Each replaces a survey paraphrase with a checkable result, and each is the trigger for its entity page | Wave order in `_work/ingest-queue.md` |
| P3 | Acquire sources for artefacts with no file in `raw/`: deep Q-network / experience replay, elastic weight consolidation, progressive networks, episodic control, Monte Carlo tree search | These are named on five concept pages and in [[wiki/index-entities.md]] with no source behind them; claims about them are currently second-hand | Human curation (or a web search pass) |

## Next

| # | Task | Why | Blocked on |
|---|---|---|---|
| P4 | Write the core-knowledge / intuitive-physics concept page | Hassabis names object, space and number priors as a key missing ingredient; the wiki has no page for it | `spelke-2007-core-knowledge.md`, `lake-2017-machines-learn-think-like-people.md` |
| P5 | Decide whether disentangled/compositional representation deserves its own page | It is invoked on three pages (recombination in planning, transfer, factorized `p = f(g, x)`) but only as a passing claim here | A source with an actual disentanglement result |
| P6 | Score architectures against the six hardness sources, per the placeholder in [[wiki/concepts/latent-graph-discovery.md]] | The scoring table is the wiki's comparison instrument and is still empty | Enough architecture pages to compare |

## Standing

| # | Task | Why |
|---|---|---|
| S1 | Keep `Connections` bidirectional | A one-way link is a maintenance defect; caught at each lint pass |
| S2 | Lint after ~every 20 ingests | Structural decay (orphans, thin pages, unexpanded abbreviations) accumulates silently |
| S3 | Re-run `./tools/qmd-index.sh` after each ingest | The search index is what the next ingest reads first; a stale index hides existing pages and causes duplicates |
