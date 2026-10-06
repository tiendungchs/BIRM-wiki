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

**Wave 28 — the Papez loop as a loop.** Five targets, from a query on 2026-10-06 that found the
wiki holds the loop node by node (anterior thalamic nuclei, retrosplenial and posterior cingulate
cortex, subiculum, entorhinal cortex) but has no page for the mammillary bodies, the fornix or the
hippocampus proper, and no source that traces the circuit as a circuit. Every row names the `G`/`T`
row it serves and the decision that row currently cannot make. Anchors: `T381` (is the medial
diencephalon a relay for the hippocampal stream or a co-equal second stream — its `Closes when`
needs the two streams cut separately, which needs their anatomy stated separately), `G39` (nothing
anchors a retrieved structure to the present situation — biology does it with the head-direction
signal this loop carries), `T383` (is the egocentric↔allocentric conversion one region's
operation), `G43` (nothing arbitrates between concurrent frames) and `T101` (reuniens versus
anterior thalamus as the controller's route into the store).

**Probe results, 2026-10-06.** `pmc.ncbi.nlm.nih.gov/articles/PMC5608081/` renders Bubb 2017 in
full, nine section headings; `frontiersin.org` renders Jankowski 2013 in full with five figures.
`nature.com` answers `303` to its identity provider on both rows — **gated, therefore `clip`**, per
the wave-27 precedent. `cambridge.org` serves Aggleton & Brown 1999 as an abstract page with a
"Get access" block and no HTML full text — a 1999 paper, so the `pdf` route applies by the skill's
own table (pre-2000 → user downloads the PDF, `./tools/pdf2md.sh`, `LOSSY`). `journals.sagepub.com`
answers `403` to `WebFetch` (bot-block; the PMC mirror is used instead). Taube 2007, *The head
direction signal: origins and sensory-motor integration*, is on `annualreviews.org` — an **excluded
venue** — so the head-direction row is filled by Cullen & Taube 2017 in Nature Neuroscience instead.

| # | Target | Clip URL | Venue | Route | Closes | Settles | Status |
|---|---|---|---|---|---|---|---|
| P1 | Bubb, Kinnavane & Aggleton 2017, *Hippocampal–diencephalic–cingulate networks for memory and emotion: an anatomical guide* | `https://pmc.ncbi.nlm.nih.gov/articles/PMC5608081/` | Brain Neurosci. Adv. 1:2398212817723443 | `clip` | `T381`, `G39` | **The loop's anatomy stated as two routes, which is what `T381`'s `Closes when` presupposes.** Tract-tracing in rat, monkey and human separates a subcortical diencephalic route (fornix → mammillary bodies → anterior thalamus) from a cortical cingulate route (subiculum → retrosplenial → cingulate), both arising mostly from posterior hippocampus. The row cannot be scored until "cut the hippocampal stream downstream of its diencephalic branch point" names a tract; this is the source that names it. Read first: it is the wave's only survey, and it is the modern replacement for Papez 1937. The wiki will then have the mammillary bodies and the fornix as prose on a page rather than as rows in a wiring table | `open` |
| P2 | Vann & Aggleton 2004, *The mammillary bodies: two memory systems in one?* | `https://www.nature.com/articles/nrn1299` | Nat. Rev. Neurosci. 5(1):35–44 | `clip` | `T381`, `G39` | **The medial/lateral split as a functional claim, which is the subtraction the anterior-thalamic page leans on.** Lateral mammillary carries the head-direction signal to the anterodorsal nucleus; medial mammillary carries a theta-modulated signal to the anteromedial and anteroventral nuclei. If the two divisions are two memory systems, then "cutting only the heading pathway costs little memory" is a statement about one of them, and `T381`'s Position B inherits a mechanism; for `G39` it is the source for *what* the heading channel delivers to the anchoring operation and what it does not | `open` |
| P3 | Aggleton & Brown 1999, *Episodic memory, amnesia, and the hippocampal–anterior thalamic axis* | `https://www.cambridge.org/core/journals/behavioral-and-brain-sciences/article/episodic-memory-amnesia-and-the-hippocampalanterior-thalamic-axis/810189AC34B388075020FA6E6C61F000` | Behav. Brain Sci. 22(3):425–444 | `pdf` (`LOSSY`) | `T381` | **Position B's original statement, with the prediction the 2022 review says cannot be tested.** The "extended hippocampal system" (hippocampus, fornix, mammillary bodies, anterior thalamic nuclei) is required for recollection and not for familiarity-based recognition, and the diencephalon projects back to the temporal lobe rather than merely receiving from it. The wiki holds this second-hand through Aggleton & O'Mara 2022; the primary is where the recollection/familiarity dissociation is argued from lesion data rather than asserted, and the BBS commentaries are the one place Position A answers it directly. Fallback PDF: ORCA eprint 34930 (Cardiff repository) | `open` |
| P4 | Cullen & Taube 2017, *Our sense of direction: progress, controversies and challenges* | `https://www.nature.com/articles/nn.4658` | Nat. Neurosci. 20(11):1465–1473 | `clip` | `G39`, `T383`, `G43` | **The head-direction chain end to end, and how landmarks reset it — which is `G39`'s stability ranking measured in one circuit.** Dorsal tegmental nucleus → lateral mammillary → anterodorsal thalamus → postsubiculum → entorhinal cortex, with vestibular input generating the signal and visual landmarks correcting it. `G39` asks how a retrieved structure is oriented to the present situation; the landmark-reset rules (which cue wins, how fast, what happens under cue conflict) are that question answered for heading, and the cue-conflict data are the rodent measurement `G43` lacks. For `T383` it states what retrosplenial cortex receives from this chain before any translation is claimed. Substitute for Taube 2007 (Annual Reviews, excluded) | `open` |
| P5 | Jankowski, Ronnqvist, Tsanov, Vann, Wright, Erichsen, Aggleton & O'Mara 2013, *The anterior thalamus provides a subcortical circuit supporting memory and spatial navigation* | `https://www.frontiersin.org/journals/systems-neuroscience/articles/10.3389/fnsys.2013.00045/full` | Front. Syst. Neurosci. 7:45 | `clip` | `T381`, `T101` | **The anterior thalamus as a navigation circuit in its own right, with the per-nucleus recordings the 2022 review summarises as a table whose cells the clip lost.** Head-direction, place and theta-modulated units by nucleus, the theta relationship to hippocampal theta, and the tegmental input that reaches the hippocampus through nothing else. `T101` turns on whether reuniens or the anterior thalamus is the controller's route into the store; this is the primary for the anterior-thalamic side's spatial cargo, and for `T381` it is the recording-level evidence that the diencephalic stream carries codes rather than relaying them | `open` |

Five rows: four `clip`, one `pdf`. Block closes nothing by itself; it gives `T381` the tract-level
anatomy its `Closes when` needs, gives `G39` the one biological anchoring mechanism measured end to
end, and makes the mammillary bodies and the fornix pageable.
