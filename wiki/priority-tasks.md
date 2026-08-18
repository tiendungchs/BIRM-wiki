# Priority Tasks

What to read or write next. Derived from [[wiki/architectural-gaps.md]], from open problems on concept pages, and from lint passes. Reordered whenever a gap opens or closes.

**Status:** the corpus (303 sources) is renamed, classified and wave-ordered; ingest is running from wave 0. Most tasks below are therefore *scheduled* rather than blocked — they name what a coming wave must deliver, so that the wave is read with a question in hand.

## Now

| # | Task | Why | Blocked on |
|---|---|---|---|
| P1 | Finish wave 0 (foundations) — 15 sources | Creates the shared vocabulary every later wave folds into; `overview.md` cannot be honest until the framing sources (Chollet, Lake, LeCun, Spelke, Hutter) are in | — |
| P2 | Decide T2 (grid codes as general organizer) with wave 2 evidence | It is the wiki's load-bearing bet: if the navigation lens fails on non-embeddable structure, the core framing needs a second mechanism | wave 2 (32 sources) |
| P3 | Give the two-level separation gap (G1) a page of its own | It is currently distributed across four pages; it is the wiki's central architectural claim and deserves a single statement | wave 2 (TEM sources) |

## Next

| # | Task | Why | Blocked on |
|---|---|---|---|
| P4 | Entity pages for TEM, CSCG, DNC, AIXI | All four are already argued about on [[wiki/concepts/latent-graph-discovery.md]] with no page behind them — the wiki asserts their capabilities without a place to check them | waves 0, 2, 5 |
| P5 | A predictive-coding page, written to serve *both* its normative role and its credit-assignment role | It is the only candidate that resolves T3 and offers a rival to the navigation framing at the same time | wave 6 |
| P6 | Systems-consolidation page: does consolidation copy episodes or transform them into schemas? | Closes or sharpens G2, the deployment-time consolidation gap | wave 4 |
| P7 | Working-memory and prefrontal-control pages | Wave 5 is the largest wave (35 sources) and currently has zero scaffolding to fold into | wave 5 |

## Standing

| # | Task | Why |
|---|---|---|
| P8 | Keep the architecture table on [[wiki/concepts/latent-graph-discovery.md]] in sync | It is the wiki's scoreboard: every model entity page must add or update a row stating which hardness sources it satisfies |
| P9 | Every new page adds reciprocal Connections entries | Bidirectionality is a schema rule; unilateral links are the first symptom of decay |
| P10 | Run `./tools/qmd-index.sh` after each wave | Search quality gates the ingest procedure itself |
