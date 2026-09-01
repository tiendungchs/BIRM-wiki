# Level-plan execution prompts

Standalone prompts for the remaining steps of the design-ladder pass. Each is
written to be pasted after a `/clear` — it carries its own context and does not
depend on the conversation that produced it.

**Step 0 is done** (commit `881e2fc`): every row in `wiki/gaps/` and
`wiki/tensions/` carries a `**Level:**` token, `tools/registry-index.py`
validates and tabulates it, and both index pages document the key.
**Step 1 (a `Bears on` field per row) was dropped** — none of the steps below
assume it exists. The spec stays in `_brainstorm/`; it is not wiki content.

**Execution order is 3 → 2 → 4 → 5**, not numeric. Step 3 promotes the
instrument rows out of `L4`; step 2 then deletes from `L4`. Running 2 first
would delete instrument rows that step 3 would have saved.

---

## Step 3 — split the `L4` band and promote the instruments

> **Context.** Both registries now carry a `**Level:**` token on every detail
> file: `L0` behaviour · `L1` decomposition · `L2` signal flow (including what
> is *denied* to a reader) · `L3` realization · `L4` substrate/instrument ·
> `META`. The key is in the header prose of `wiki/architectural-gaps.md` and
> `wiki/empirical-tensions.md`. `L4` currently holds 115 rows and is doing two
> unrelated jobs, which is why it is both the largest band and the
> least-cited (mean 2.7 citations vs. 6.9 at `L0`).
>
> **The two jobs.** (a) *Instrument* rows ask whether a measurement means what
> it names — "does this score measure the ability it is named after", "does
> this probe license the claim drawn from it". These are **not** deferrable:
> they gate every `L0` claim that would rest on them, and `G17` — the wiki's
> single most-cited row at 46 — is one of them. (b) *Substrate* rows are
> biological or methodological facts with no consequence for any design
> decision until a realization is chosen.
>
> **Task.** Add `L0-INSTR` to `LEVELS` in `tools/registry-index.py` and to the
> Level key prose on both index pages, defined as: *a row whose subject is the
> validity of a measurement rather than a property of the model; worked at
> `L0` priority because an unvalidated instrument cannot settle an `L0`
> claim.* Then walk every current `L4` row (`grep -l 'Level:\*\* `L4`'
> wiki/gaps/*.md wiki/tensions/*.md`), open it, and re-token it `L0-INSTR` or
> leave it `L4`. The test is one question: **does this row's resolution change
> what a score or a probe is allowed to be evidence for?** Yes → `L0-INSTR`.
> No → stays `L4`.
>
> Expect roughly 70 to move; do not force that number, and record the real
> count. `G17 G31 G36 G41 G44 G87 G108` are gap-side candidates.
>
> **Second half — collapse the benchmark band.** `T204`–`T228` are 25 separate
> `LIVE` rows that are all evidence *for* `G17` ("no evaluation protocol can
> certify structure discovery") rather than independent disputes:
>
> ```
> T204(5) T205(5) T206(3) T207(5) T208(2) T209(1) T210(3) T211(2) T212(2)
> T213(4) T214(3) T215(3) T216(3) T218(4) T219(3) T220(5) T221(5) T222(7)
> T223(5) T224(2) T225(2) T226(2) T227(1) T228(3)
> ```
>
> (Parenthesised numbers are current citation counts. `T217` is deliberately
> absent — it is classified `L2` and belongs to step 4's queue, not here.)
>
> Read `wiki/gaps/g017.md` and all 24 rows. Fold each one's *finding* into
> `g017.md` as evidence — one line each, keeping the source citation — then
> `git mv` the tension file to `wiki/tensions/closed/` with a one-line note in
> its `Status` section saying it was absorbed into `G17` and why. Any row that
> turns out to carry a dispute `G17` does not already make is **kept**, not
> folded; say which ones and why.
>
> Every concept and entity page citing an absorbed row must be updated to cite
> `G17` instead — `tools/registry-index.py` errors on a row cited by nothing,
> and `./tools/wiki-stats.sh` check `S14` will catch stragglers.
>
> **Done when** `python3 tools/registry-index.py` and `./tools/wiki-stats.sh`
> both pass clean, and the tally line shows the new `L0-INSTR` band. Commit
> with a message saying what moved and what the real instrument count was.

---

## Step 2 — cut the dead weight

> **Context.** Read the Step 3 context block above for the Level ladder; it
> applies here unchanged. **Run this only after step 3**, because step 3
> promotes instrument rows out of `L4` and this step deletes from `L4`.
>
> **Why.** Mean citation count falls monotonically down the ladder (`L0` 6.9,
> `L2` 5.4, `L1` 4.3, `L3` 3.8, `L4` 2.7). The wiki's own cross-referencing
> already knows which rows are dead weight; nothing has ever acted on it. A
> registry row earns its place by being *actionable* — it names a mechanism
> the wiki would adopt if it existed. A row that is at `L3`/`L4`, cited by at
> most one page, and named nowhere in `_brainstorm/birm-spec.md` fails that
> test on all three counts at once.
>
> **The set** — 42 rows, computed as `Level ∈ {L3, L4}` ∧ `Cited by ≤ 1` ∧ not
> named in `_brainstorm/birm-spec.md`:
>
> ```
> G36 G87
> T36 T43 T53 T54 T60 T61 T69 T70 T71 T72 T73 T74 T84 T91 T105 T109 T114
> T115 T123 T126 T150 T176 T190 T193 T196 T198 T201 T227 T239 T243 T246
> T248 T255 T258 T260 T261 T280 T295 T313 T322
> ```
>
> Regenerate rather than trust the list — step 3 will have moved `G36`, `G87`
> and several `T` rows to `L0-INSTR`, and **anything now at `L0-INSTR` is
> excluded**:
>
> ```bash
> { grep '^| G' wiki/architectural-gaps.md; grep '^| T' wiki/empirical-tensions.md; } \
>  | awk -F'|' '{gsub(/ /,"",$2); c=$(NF-2); gsub(/ /,"",c); l=$(NF-4); gsub(/[ `]/,"",l);
>                if ((l=="L3"||l=="L4") && c<=1) print $2}' | sort > /tmp/cand.txt
> grep -o '`G[0-9]\+`\|`T[0-9]\+`' _brainstorm/birm-spec.md | tr -d '`' | sort -u > /tmp/spec.txt
> comm -23 /tmp/cand.txt /tmp/spec.txt
> ```
>
> `T4 T24 T26 T209 T284` match on level and citation but **are** named in the
> spec — leave them.
>
> **Task.** Open each candidate. Retire it only if all three hold: it is still
> `L3`/`L4` after step 3; no `Closes when` condition it states would change a
> decision in `_brainstorm/birm-spec.md` §11 or §12; and its content is
> already carried by the concept page that cites it. `git mv` to
> `wiki/gaps/closed/` or `wiki/tensions/closed/` and add one line to its
> `Status` section: demoted as an implementation or substrate detail, no
> design decision depends on it. **Do not delete the file**, and do not strip
> the row's content from the concept page that cites it — the finding stays as
> prose, only the registry row goes.
>
> A candidate you decide to keep is a useful result: say which and why, since
> it means the level or the citation count is wrong and should be fixed
> instead.
>
> **Done when** `python3 tools/registry-index.py` and `./tools/wiki-stats.sh`
> pass clean. Commit with the count retired and the count spared.

---

## Step 4 — work the `L1`/`L2` backlog into the spec

> **Context.** Both registries carry a `**Level:**` token (`L0` behaviour ·
> `L1` decomposition · `L2` signal flow, including what is *denied* to a
> reader · `L3` realization · `L4` substrate/instrument · `META`); the key is
> in the header prose of both index pages.
>
> `_brainstorm/birm-spec.md` is the buildable spec — organs (§3), buses with
> an **architecturally-denied** column (§4), the per-step trace (§5), a
> decision ledger (§11) and open slots (§12). It is **brainstorm, not wiki
> content**; it stays in `_brainstorm/`. Its editing rules R1–R6 are in its
> own header and in `CLAUDE.md` — in particular **R6**: body sections state
> what the spec *is* plus a bare ledger id, and never why a decision came to
> be. Provenance lives in §11's `Supersedes` column and §13's changelog.
>
> **The problem this step fixes.** The spec has ever named only 102 of the
> wiki's 434 registry rows. **104 rows at `L1` and `L2` — the two levels the
> spec exists to answer — have never entered a design decision.** The wiki
> keeps generating questions the spec never consumes. This is the actual
> backlog, and it needs no new ingests.
>
> **The queue**, citation-ordered. Work it top-down, **one batch of 5–8 rows
> per session**, `L2` before `L1` (signal flow constrains decomposition less
> than the reverse, and the `L2` rows are better cited):
>
> `L2` — 53 rows:
> ```
> G77(8) G60(8) T162(7) G22(7) T217(6) T94(5) T314(5) T152(5) G99(5) T98(4)
> T56(4) T46(4) T127(4) T108(4) G51(4) T273(3) T257(3) T251(3) T131(3) G97(3)
> G96(3) G85(3) G84(3) G57(3) T81(2) T42(2) T278(2) T276(2) T262(2) T250(2)
> T249(2) T185(2) T138(2) T135(2) T133(2) T110(2) T99(1) T97(1) T89(1) T66(1)
> T35(1) T268(1) T259(1) T252(1) T235(1) T136(1) T121(1) T117(1) T101(1)
> T100(1) G88(1) G86(1) G71(1)
> ```
>
> `L1` — 51 rows:
> ```
> G68(15) G67(14) G9(9) G69(9) T269(7) T173(7) T156(7) T28(6) T289(5) T88(4)
> T45(4) T327(4) T27(4) T183(4) T96(3) T51(3) T319(3) T180(3) T130(3) T111(3)
> T86(2) T82(2) T80(2) T79(2) T48(2) T40(2) T306(2) T303(2) T267(2) T199(2)
> T191(2) T151(2) T142(2) T132(2) T107(2) T104(2) G81(2) T95(1) T90(1) T62(1)
> T47(1) T274(1) T266(1) T244(1) T203(1) T194(1) T178(1) T163(1) T11(1)
> T103(1) G98(1)
> ```
>
> Regenerate before starting, since steps 2–3 will have shifted it:
> ```bash
> { grep '^| G' wiki/architectural-gaps.md; grep '^| T' wiki/empirical-tensions.md; } \
>  | awk -F'|' '{gsub(/ /,"",$2); c=$(NF-2); gsub(/ /,"",c); l=$(NF-4); gsub(/[ `]/,"",l);
>                if (l=="L2"||l=="L1") print $2"\t"l"\t"c}' | sort > /tmp/q.tsv
> grep -o '`G[0-9]\+`\|`T[0-9]\+`' _brainstorm/birm-spec.md | tr -d '`' | sort -u > /tmp/spec.txt
> join -v1 -t$'\t' /tmp/q.tsv /tmp/spec.txt | sort -t$'\t' -k2,2 -k3,3nr
> ```
>
> **Per row, in order:**
> 1. Read the detail file and every source it cites. **Read no new sources** —
>    this step spends the wiki, it does not grow it.
> 2. Decide which spec object the row bears on: an organ in §3, a bus row or a
>    `Denied` cell in §4, a step in §5, or a §12 open slot.
> 3. Write the decision as a ledger row in §11 with a `D<n>` id and an R1
>    status token (`ASSUMED` / `SOURCED` / `MEASURED` / `CONTESTED`), and edit
>    the body cell it settles. Under R3, a quantity with no number is written
>    `?` and opened as a §12 slot — **never invent a plausible number**.
> 4. If the row's `Closes when` is now satisfied, `git mv` it to `closed/`.
>    Usually it will not be: the spec *takes a position* on the row, which is
>    not the same as the literature settling it. Say which happened.
> 5. Append a §13 changelog line naming the wave and the rows touched.
>
> A row the spec cannot take a position on is a real finding — record it as a
> §12 open slot with its cheapest close, rather than forcing a decision.
>
> **Done when** the batch's rows each have a `D` row or an `O` slot,
> `python3 tools/registry-index.py` and `./tools/wiki-stats.sh` pass, and the
> commit message names the rows consumed and the decisions made.

---

## Step 5 — stop the regrowth

> **This is the load-bearing step.** Steps 2–4 are a one-time cut and a
> one-time backlog burn. Without this one they undo themselves within about
> fifty ingests, because nothing in the ingest procedure has ever constrained
> which *level* a new registry row may be opened at.
>
> **Context.** Every row in `wiki/gaps/` and `wiki/tensions/` carries a
> `**Level:**` token — `L0` behaviour · `L1` decomposition · `L2` signal flow
> (including what is *denied* to a reader) · `L3` realization · `L4`
> substrate/instrument · `L0-INSTR` measurement validity, worked at `L0`
> priority · `META`. `tools/registry-index.py` validates the token, emits it
> as a column and prints a per-level tally. The key prose is in the headers of
> `wiki/architectural-gaps.md` and `wiki/empirical-tensions.md`.
>
> The measured problem: the gap table was already 76% `L0`–`L2`, but the
> tension table was 59% `L3`+`L4`, and those rows were the least-cited in the
> wiki. Ingests were opening rows at whatever level the source happened to
> discuss, so the registry tracked the literature's structure instead of the
> spec's.
>
> **Task — three edits.**
>
> 1. **`.claude/skills/wiki-ingest/SKILL.md` step 9** (the contradiction rule
>    that creates tensions) and **step 10** (registry edits): add the
>    admission rule. An ingest may open a registry row **only** if the row is
>    `L0`, `L1`, `L2` or `L0-INSTR`, **or** if it closes an existing `§12`
>    open slot in `_brainstorm/birm-spec.md`. A source's `L3`/`L4` content is
>    still ingested — it goes into the body of the relevant concept or entity
>    page, where it is found by search when a realization is finally chosen —
>    but it does **not** get a registry row. Require the new row's
>    `**Level:**` token to be written at creation time; the tool already
>    hard-errors without it.
>
> 2. **`CLAUDE.md`, under `## Decision-making`**: add the ladder as a
>    standing rule, in the same register as the existing entries — one line
>    naming the level order `L0 → L1 → L2` as a priority order, one line
>    stating that `L3`/`L4` material lives in page bodies rather than in the
>    registries, and one naming `L0-INSTR` as worked at `L0` priority because
>    an unvalidated instrument cannot settle an `L0` claim.
>
> 3. **`.claude/skills/wiki-lint/SKILL.md`**: add a check to the audit list —
>    report the per-level tally that `tools/registry-index.py` prints, and
>    flag any `L3`/`L4` row created since the previous lint, plus any row
>    cited by ≤1 page, as a demotion candidate. This is what makes the cut
>    self-maintaining instead of a thing that has to be re-run by hand.
>
> Consider also adding it to `./tools/wiki-stats.sh` as a numbered check
> alongside `S14`/`S17` so it fails mechanically rather than by judgement.
>
> **Done when** the three files are edited, `./tools/wiki-stats.sh` passes,
> and the commit message states the admission rule in one sentence.
