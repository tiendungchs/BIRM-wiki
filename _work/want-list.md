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

### Wave 23 — the posterior exit from the hippocampal formation

From a QUERY pass on which part of the hippocampal circuit the wiki has left underexplored.
The answer was an **asymmetry, not a topic**: the *anterior* exit (subiculum → medial prefrontal
cortex, direct and via nucleus reuniens) holds ~31,900 words across six pages
([[wiki/entities/hippocampal-prefrontal-channel.md]], [[wiki/entities/nucleus-reuniens.md]],
[[wiki/entities/medial-prefrontal-cortex.md]], [[wiki/entities/mediodorsal-thalamus.md]],
[[wiki/entities/entorhinal-cortex.md]], [[wiki/concepts/hippocampal-long-axis.md]]), while the
*posterior* exit — subiculum → retrosplenial cortex → posterior cingulate, precuneus, posterior
parietal, anterior thalamus — holds **no page at all**. Retrosplenial cortex is named in 19 files,
the subiculum in 12, posterior parietal in 19, the anterior thalamic nuclei in 4 (one mention
each); none is the subject of a single `G` or `T` row, and `raw/` has no file about any of them.

The hole is load-bearing rather than merely large. Four existing pages already hand retrosplenial
cortex a job and then drop it: it is the indirect route the medial-temporal↔prefrontal edge
actually takes at rest ([[wiki/entities/default-mode-network.md]]), the cortical store consolidated
maps end up in ([[wiki/concepts/cognitive-map.md]], [[wiki/concepts/complementary-learning-systems.md]]),
the anchoring mechanism `G39` is missing, and the local↔global heading transform `G43` needs. And
[[wiki/entities/entorhinal-cortex.md]] records that retrosplenial input reaches medial entorhinal
cortex **almost exclusively in layer V** — the comparator sublamina that receives the hippocampal
return — which is `G110`'s "control applied to the interface, not the module" with a measured
instance nobody has cashed.

Block A acquires the route as **anatomy**; block B acquires the **computation** run on it.

**Probe results, all 2026-09-18.** `nature.com` answers `303 → idp.nature.com` (session wall to
`WebFetch`, not a paywall verdict) and `cell.com` answers `403` (bot-block, likewise not a verdict)
— both have precedent in `raw/` from wave 22, both `clip`. `elifesciences.org` *renders* to
`WebFetch` but truncates at roughly 65% of body text (Discussion, Simulations 4–5 and Methods all
cut), so row 6 is `clip` and **not** `self` despite eLife being open access — the skill's `self`
bar is faithful rendering, not open access. No target on this wave sits on an excluded venue, and
none duplicates a `_work/manifest.tsv` row.

#### A — the route as anatomy

| # | Target | Clip URL | Venue | Route | Closes | Settles | Status |
|---|---|---|---|---|---|---|---|
| 1 | Vann, Aggleton & Maguire 2009, *What does the retrosplenial cortex do?* | `https://www.nature.com/articles/nrn2733` | Nat. Rev. Neurosci. 10:792–802 | `clip` | `G39`, `G43` | **The wiki assigns this region two jobs and holds no source for either.** [[wiki/concepts/cognitive-map.md]] gives it anchoring (`G39`) and the local↔global heading transform (`G43`), and [[wiki/concepts/complementary-learning-systems.md]] gives it the cortical map store — all three second-hand. This is the review that states the thesis behind them: the region's function is **translation between perspectives** of one environment, which is exactly the operator `G39`'s `Closes when` asks for and no wiki architecture has | `open` |
| 2 | Foster, Koslov, Aponik-Gremillion et al. 2023, *A tripartite view of the posterior cingulate cortex* | `https://www.nature.com/articles/s41583-022-00661-x` | Nat. Rev. Neurosci. 24:173–189 | `clip` | `T267`, `T256` | **`T267` cannot be worked while three regions with three different answers carry one label.** [[wiki/entities/default-mode-network.md]] writes "PCC/Rsp" as a single hub — its strongest and most consistent node. This splits it into dorsal posterior cingulate (executive), ventral posterior cingulate (mnemonic) and retrosplenial (spatial), each with its own connectivity. `T267` asks which function those hubs serve; `T256`'s precuneus dispute is the same node-definition failure one node over, and both inherit the answer | `open` |
| 3 | Aggleton & O'Mara 2022, *The anterior thalamic nuclei: core components of a tripartite episodic memory system* | `https://www.nature.com/articles/s41583-022-00591-8` | Nat. Rev. Neurosci. 23:505–516 | `clip` | `T101`, `G52` | **The wiki holds two thalamic relay entities and both serve the prefrontal route.** `T101` ("can the control layer address the episodic store directly, or only through a relay?") is `LEANING` on [[wiki/entities/nucleus-reuniens.md]] alone — a single relay is an existence proof, not a comparison. The anterior thalamic nuclei are the *posterior* route's relay, on the fornix → mammillary → anterior thalamus → cingulate loop, and give `T101` its second case and `G52` its second inter-module edge with state of its own | `open` |
| 4 | Cembrowski, Phillips, DiLisio et al. 2018, *Dissociable structural and functional hippocampal outputs via distinct subiculum cell classes* | `https://www.cell.com/cell/fulltext/S0092-8674(18)30311-8` | Cell 173(5):1280–1292.e18 | `clip` | `T340`, `T28` | **`T340`'s `Closes when` is output routing measured under stream-typed input; this measures the router.** Population and single-cell RNA-seq split the dorsal subiculum into two adjacent subregions differing in long-range input, local wiring, **projection target** and intrinsic properties — so the store's output stage is typed by cell class rather than being one bus. Every hippocampal projection on every wiki page originates here, and the wiki has never held the subiculum as anything but a waypoint | `open` |
| 5 | Kinman, Kraus & Cembrowski 2026, *The subiculum: cell-type-specific composition, computation, and function* | `https://www.cell.com/trends/neurosciences/fulltext/S0166-2236(26)00028-7` | Trends Neurosci. 49(4):278–291 | `clip` | `T340`, `G14` | The survey row that makes row 4 a framework rather than one result: distinct excitatory subtypes occupying distinct spatial subdomains, each producing a **specialised spatial domain of hippocampal output to a distinct target**. `G14` wants a consolidation channel selective about what transports; a store whose output stage is partitioned by destination is the anatomy under which "selective transport" is a wiring fact rather than a gating hypothesis | `open` |

#### B — the computation run on that route

| # | Target | Clip URL | Venue | Route | Closes | Settles | Status |
|---|---|---|---|---|---|---|---|
| 6 | Bicanski & Burgess 2018, *A neural-level model of spatial memory and imagery* | `https://elifesciences.org/articles/33752` | eLife 7:e33752 | `clip` | `G39`, `G43` | **The highest-value row on the wave: an implemented model that performs the transform the wiki only names.** Egocentric parietal representations interface with allocentric medial-temporal ones **via retrosplenial gain fields**, with place, head-direction, grid, boundary-vector and object-vector cells in one modular account that also runs imagery, scene construction, novelty detection and mental navigation. `G39` (anchor a retrieved structure to the present situation) and `G43` (arbitrate between concurrent reference frames) both have `Closes when` conditions this addresses directly, and the wiki currently has no candidate mechanism for either. Predecessor Byrne, Becker & Burgess 2007 (Psych. Rev.) not requested — this supersedes it | `open` |
| 7 | Alexander & Nitz 2015, *Retrosplenial cortex maps the conjunction of internal and external spaces* | `https://www.nature.com/articles/nn.4058` | Nat. Neurosci. 18(8):1143–1151 | `clip` | `G43`, `T47` | **`T47`'s head-to-head, measured in one population.** Retrosplenial ensembles conjunctively encode progress through the current route, position in the larger environment, and the animal's own turning action — three frames at once, in one ensemble, on one track. `T47` asks whether concurrent structural codes are independent frames or one code read out in many places, is `LIVE` on 3 citing pages, and has never held a recording that puts the candidate frames in the same neurons. `G43` gets its first empirical constraint on the reconciliation rule | `open` |
| 8 | Alexander, Place, Starrett, Chrastil & Nitz 2023, *Rethinking retrosplenial cortex: perspectives and predictions* | `https://www.cell.com/neuron/fulltext/S0896-6273(22)01027-3` | Neuron 111(2):150–175 | `clip` | `G43`, `G110` | The negative result that keeps rows 1 and 6 honest: the authors argue retrosplenial anatomy and dynamics fit **multiple** sensorimotor and cognitive processes and *no* isolated function — the same function-to-structure failure [[wiki/concepts/function-to-structure-inference.md]] records for the default network, arriving at the region the wiki was about to hand a single job. Their positive proposal (relate spatial perspectives, generate predictions about environmental interactions) is the one that has to survive it, and the layer-V targeting in [[wiki/entities/entorhinal-cortex.md]] is where `G110` reads it | `open` |

**Counts.** 8 targets, **all `clip`**, none `self`, none `pdf`. Block A closes work on `G39`,
`G43`, `G52`, `G14`, `T28`, `T101`, `T256`, `T267` and `T340`; block B on `G39`, `G43`, `G110`
and `T47`. Nothing dropped at resolution — no target resolved to an excluded venue. Two rows are
deliberately paired against each other: row 1 assigns retrosplenial cortex a function and row 8
argues no single function fits, so the pair is ingested as a tension candidate rather than as a
settled account.

**Expected pages after ingest** (per the QUERY pass's Option A): `wiki/entities/retrosplenial-cortex.md`
and `wiki/entities/subiculum.md`, plus a likely concept page on the allocentric↔egocentric
transform from row 6.
