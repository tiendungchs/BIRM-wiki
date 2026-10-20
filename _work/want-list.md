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

**Wave 31 — block A: the lateral frontoparietal ↔ medial prefrontal coupling.** Topic set by the
user (2026-10-20): the connections between the lateral frontoparietal network
([[wiki/entities/lateral-frontoparietal-network.md]]) and medial prefrontal cortex, the default
network's one non-core node ([[wiki/entities/default-mode-network.md]]). The block is built from the
registry rows that boundary touches, not from the topic: the **arbitrator and the measurement
clause** of `G90` (an internal mode competing with the input-driven one, "with the anticorrelation
measured without global-signal normalisation"; the arbitrator candidate Buckner 2008 calls
preliminary — a frontoparietal system interposed between the two — has no primary in `raw/`),
`T264` (anticorrelation with *and* without global signal regression on the same data and regions —
"no source currently does"), `T257` (who drives whom), `T267` (midline hubs: broadcast or
generate), and two artefacts the LFPN page cites second-hand with no file: Wendelken et al. 2008
(seven pages; `I36`'s second reversal *and* Parsons' subtraction-artefact reading of the same
contrast) and Hammer et al. 2019 (the default-mode-is-a-cost result). Not on the list: Buckner 2008,
Raichle 2001, Menon 2023, Gao 2013, Tripathi 2025, Shine 2016, Wendelken 2012 — already in `raw/`.

**Probe results, 2026-10-20.** `pmc.ncbi.nlm.nih.gov` answers the fetcher with a reCAPTCHA shell on
first contact but serves the full article to a plain client: Vincent 2008, Fox 2009, Chai 2012,
Keller 2013, Spreng 2010, Spreng 2013 and Dixon 2018 all come back as full HTML with Methods,
Results, Discussion, tables and figure captions (11–16 k words each including references). Both
items are `clip`, not `self`: the figures are what the wiki needs and the fetcher does not carry
them. `direct.mit.edu` (Wendelken 2008) and `sciencedirect.com` (Hammer 2019) answer `403` to the
fetcher, as ScienceDirect did in wave 30; MIT Press and Elsevier are institution-reachable HTML, so
`clip` — **unverified by probe**: if either shows a paywall, report it and the row is retired.
Neither has a PMC mirror (checked by PMID 18052787 and 30218770).

### Block A — the lateral frontoparietal ↔ medial prefrontal coupling (`G90`, `T264`, `T257`, `T267`, `T335`)

| # | Target | Clip URL | Venue | Route | Closes | Settles | Status |
|---|---|---|---|---|---|---|---|
| A1 | Vincent, Kahn, Snyder, Raichle & Buckner 2008, *Evidence for a frontoparietal control system revealed by intrinsic functional connectivity* | `https://pmc.ncbi.nlm.nih.gov/articles/PMC2604839/` | J. Neurophysiol. 100(6) | `clip` | `G90`, `T257` | **The primary for the arbitrator candidate `G90` has carried as "preliminary" since its opening.** Three resting datasets (`n = 105`): a system of lateral prefrontal, anterior cingulate and inferior parietal cortex that is correlated with *both* the default (hippocampal–cortical) and dorsal attention systems while those two are anticorrelated with each other, and sits spatially between them. This is the "frontoparietal system anatomically interposed" that `g090.md` and the default-network page cite as Vincent 2007b with no file. It supplies the anatomy of the arbitrator candidate and the first measurement of what "interposed" means (shared positive coupling, not a third anticorrelation) | `open` |
| A2 | Fox, Zhang, Snyder & Raichle 2009, *The global signal and observed anticorrelated resting state brain networks* | `https://pmc.ncbi.nlm.nih.gov/articles/PMC2694109/` | J. Neurophysiol. 101(6) | `clip` | `T264`, `G90` | **`T264`'s closing condition, run by the authors of the anticorrelation itself.** The same data and seed regions analysed with and without global signal regression: the global signal is spatially uniform rather than concentrated in either network, regression shifts every correlation negative by a computable amount, and several features of the default/task-positive anticorrelation survive without it. `T264` says no source reports both on the same data; this one does, with the magnitude. `G90`'s measurement clause ("anticorrelation measured without global-signal normalisation") is answered or refused here | `open` |
| A3 | Chai, Nieto Castañón, Öngür & Whitfield-Gabrieli 2012, *Anticorrelations in resting state networks without global signal regression* | `https://pmc.ncbi.nlm.nih.gov/articles/PMC3230748/` | NeuroImage 59(2) | `clip` | `T264` | **The LFPN–mPFC anticorrelation specifically, with the global signal replaced by a noise model.** Seed in medial prefrontal cortex; bilateral DLPFC and IPL — the lateral frontoparietal nodes — are anticorrelated under CompCor (3, 5, 10 noise components) as well as under global regression, with peak `t` tabulated for each (L DLPFC `10.84` under regression vs `7.02–9.67` under CompCor; L IPL `10.53` vs `8.67–12.25`). It is the one source whose table is exactly the pair the user asked about, at the resolution `T264` needs, and it names the residual worry (regression gives the largest values, partly by the negative shift) | `open` |
| A4 | Keller, Bickel, Honey, Groppe, Entz, Craddock, Lado, Kelly, Milham & Mehta 2013, *Neurophysiological investigation of spontaneous correlated and anticorrelated fluctuations of the BOLD signal* | `https://pmc.ncbi.nlm.nih.gov/articles/PMC3652257/` | J. Neurosci. 33(15) | `clip` | `T264`, `G90` | **Whether the anticorrelation is neural, decided outside the haemodynamic signal.** Electrocorticography in five patients: both positive and negative BOLD correlations have counterparts in spontaneous high-gamma power, with no global regression in the neural signal at all; and global regression of the BOLD data produces some anticorrelations the electrophysiology does not show while improving the overall match. That is `T264` Position A and Position B each given a region of validity, and it is the only route to `G90`'s measurement clause that does not depend on a regression choice | `open` |
| A5 | Spreng, Stevens, Chamberlain, Gilmore & Schacter 2010, *Default network activity, coupled with the frontoparietal control network, supports goal-directed cognition* | `https://pmc.ncbi.nlm.nih.gov/articles/PMC2914129/` | NeuroImage 53(1) | `clip` | `G90`, `T267` | **The sign of the LFPN–default coupling flipped to positive by task design, in one experiment.** Autobiographical planning versus visuospatial planning: the frontoparietal control network is engaged by both, and couples to the default network in the first and to the dorsal attention network in the second. The default-network page says nothing names the variable that flips the coupling's sign; this is the first study to flip it under control, with "internal content that is goal-directed" as the candidate. It is also the untested cooperation case the LFPN page's Parsons section asks for (internally directed retrieval *with* an executive demand), and `T267`'s broadcasting-vs-generating question put to the control network's partner choice | `open` |
| A6 | Spreng, Sepulcre, Turner, Stevens & Schacter 2013, *Intrinsic architecture underlying the relations among the default, dorsal attention, and frontoparietal control networks of the human brain* | `https://pmc.ncbi.nlm.nih.gov/articles/PMC3816715/` | J. Cogn. Neurosci. 25(1) | `clip` | `G90`, `T338` | **The interposed system resolved node by node, and the LFPN's integrator lands on the default side.** Graph analysis on resting connectivity with task-defined nodes: default and dorsal attention share almost no positive edges, the frontoparietal control network is interconnected with both, and its nodes sort three ways — **left rostrolateral prefrontal cortex and left anterior IPL are default-aligned**, bilateral DLPFC and right RLPFC dorsal-attention-aligned, medial superior prefrontal and bilateral BA 6 dual-aligned, with only the last two directly connected to both under partial correlation. For `G90` that turns "a frontoparietal arbitrator" into a two-node claim; for `T338` it puts the left-lateralised integrator the whole LFPN page is built on in the default network's coupling set, which neither position there predicts | `open` |
| A7 | Dixon, De La Vega, Mills, Andrews-Hanna, Spreng, Cole & Christoff 2018, *Heterogeneity within the frontoparietal control network and its relationship to the default and dorsal attention networks* | `https://pmc.ncbi.nlm.nih.gov/articles/PMC5816169/` | PNAS 115(7):E1598 | `clip` | `G90`, `T257` | **The LFPN split by which of its two neighbours each half talks to, across nine conditions.** Hierarchical clustering and classification of within-network connectivity give two subsystems — FPCN-A coupled to the default network, FPCN-B to dorsal attention — replicated over four datasets and rest plus eight tasks, with the degree of separation varying by task. For `G90` the arbitrator stops being one system with one gain: half of it is wired to the internal mode and half to the external one, and "arbitration" is the balance between the halves. For `T257` it names the frontoparietal subsystem the default network would be driving (A) and the one the salience network would be handing control to (B), which the two positions have so far treated as one target. Figure 2 was corrected (PMC5879721) | `open` |
| A8 | Wendelken, Nakhabenko, Donohue, Carter & Bunge 2008, *"Brain is to thought as stomach is to ??": Investigating the role of rostrolateral prefrontal cortex in relational reasoning* | `https://direct.mit.edu/jocn/article/20/4/682/4490/Brain-Is-to-Thought-as-Stomach-Is-to-Investigating` | J. Cogn. Neurosci. 20(4) | `clip` | `T335`, `I36` | **Cited on seven pages with no file, and read two incompatible ways on the same page.** Analogy *completion* (three terms, infer the fourth) recruited medial BA 10 and left BA 8; *comparison* (all four terms given) recruited bilateral RLPFC and VLPFC more — the one contrast in which the lateral integrator and medial prefrontal cortex swap within a single task. The LFPN page uses it as `I36`'s second reversal (relational demand dissociated from difficulty) and, via Parsons, as a subtraction artefact; `T335` names it as the confound that could dissolve the matrix-vs-analogy dissociation (response mode collinear with format). The primary decides what the contrast and baseline actually were. MIT Press HTML, institution route, unprobed (`403` to the fetcher) | `open` |
| A9 | Hammer, Paul, Hillman, Kramer, Cohen & Barbey 2019, *Individual differences in analogical reasoning revealed by multivariate task-based functional brain imaging* | `https://www.sciencedirect.com/science/article/pii/S1053811918308310` | NeuroImage 184:993 | `clip` | `G90`, `T241` | **The default-network-is-a-cost result, and medial prefrontal cortex on both sides of it.** `n = 229`, multiple-kernel learning: analogy ability tracks greater activation in a prefrontal executive network and a visuospatial network and *lower* activation in the default network — and the single strongest positive predictor is **dorsomedial prefrontal cortex**, a default-network node by the Buckner 2008 anatomy. The LFPN page carries only the sign of the default relation, second-hand; the primary says which medial tier is on which side, which is what `T241`'s content-vs-topology reading and `G90`'s sign-of-coupling clause both need. Also: individual-difference regions only partly overlap the group difficulty map, a direct instance of the LFPN page's "relational demand is not difficulty". ScienceDirect HTML, institution route, unprobed (`403` to the fetcher) | `open` |

