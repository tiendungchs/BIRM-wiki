# Wiki Schema — Brain-Inspired Models for Abstract Reasoning

This file is the operating contract for this wiki. Every interaction follows these rules. Read this file at the start of every session before doing anything else.

---

## Mission

This wiki is a persistent, compounding knowledge base for research on **brain-inspired machine learning models capable of abstract reasoning**. The human curates sources and asks questions. The LLM writes and maintains all wiki content — summaries, entity pages, concept pages and cross-references. Nothing is re-derived from scratch; everything builds on what is already in the wiki.

**Primary purpose: brainstorming.** The wiki is a thinking tool first. Synthesis, architectural speculation, cross-paper connections, and general domain knowledge are first-class content. Every page should move thinking forward, not merely report what sources say.

---

## Directory Layout

```
BIRM-Wiki/
├── CLAUDE.md                   ← this file: schema and operating rules
├── raw/                        ← source documents (Markdown / plain text only)
│   └── originals/              ← archived PDFs, kept for provenance; never ingested
├── tools/
│   ├── qmd-index.sh            ← hybrid BM25+vector search script
└── wiki/                       ← all LLM-generated content
    ├── overview.md             ← high-level synthesis of the research area
    ├── priority-tasks.md       ← current priority tasks identified from lint passes
    ├── architectural-gaps.md   ← INDEX of architectural gaps: one line per gap, no prose
    ├── empirical-tensions.md   ← INDEX of empirical tensions: one line per tension, no prose
    ├── glossary.md             ← abbreviation expansions
    ├── gaps/                   ← one file per gap (g001.md …); closed/ holds retired gaps
    ├── tensions/               ← one file per tension (t001.md …); closed/ holds retired tensions
    ├── index-concepts.md       ← concepts list
    ├── index-entities.md       ← models, benchmarks, biological systems list
    ├── entities/               ← models, benchmarks, biological systems
    ├── concepts/               ← core ideas, techniques, mechanisms
```

**Rules:**
- All wiki content lives under `wiki/`.
- File names: lowercase, hyphens for spaces, `.md` extension. Example: `wiki/concepts/working-memory.md`.
- Sources in `raw/` must be Markdown or plain text.

---

## Page Format

**Entity pages** (`wiki/entities/`): one page per **model, framework, or biological system**. No researcher pages.
- Models: architecture table → key results → limitations → comparison table to related models → **Connections**
- Biological systems: anatomy/function → computational role → how it maps to model components → **Connections**
- Use tables and bullet points over prose.

**Concept pages** (`wiki/concepts/`): one page per core mechanism or idea.
- Structure: one-line bold definition → key equations/formalisms → evidence/instantiations table → open problems → **Connections**
- Equations preferred over prose where possible.
- Every concept page must show how the concept applies to building a reasoning model.

**Connections section** (required on all concept and entity pages):
- Appears at the end of every concept and entity page.
- Each entry: `**[[wiki/path/page.md]]** — one sentence explaining *how* these pages relate` (the mechanism of the relationship, not just that they are related).
- Links should be bidirectional: if A connects to B, B must connect to A.
- Updated whenever a new ingest creates a new relationship.

**Overview** (`wiki/overview.md`): the master synthesis. Updated after every 10 ingests or when a major insight changes the picture. Sections: The Central Thesis → Master Problem Framing: Latent Graph Discovery → Current best understanding → Key open problems → Promising directions → Major controversies.

**wiki/index-concepts.md** — concepts list only. Same format. Updated when a new concept page is created.

**wiki/index-entities.md** — models, benchmarks, and biological systems. Same format. Updated when a new entity page is created.

---

## Operations

The four core operations live as project skills under `.claude/skills/`. Invoke the skill — do not improvise the procedure.

| Operation | Skill | Trigger |
|---|---|---|
| ACQUIRE | `wiki-acquire` | The ingest queue is empty or thin; the user asks what to collect or read next; a lint pass leaves acquisition tasks blocked on curation; the user drops freshly clipped files in `raw/` |
| INGEST | `wiki-ingest` | User drops a source in `raw/` and says "ingest [filename]", or asks for a paper/article/talk to be filed |
| QUERY | `wiki-query` | User asks any substantive question about the domain or the wiki's contents |
| LINT | `wiki-lint` | User says "lint the wiki" / asks for an audit; also suggest it after roughly every 20 ingests |

---

## Web Search

Use WebSearch/WebFetch when:
- The user asks for it explicitly
- A lint pass reveals a factual gap that a quick search could fill
- A lint pass identifies important sub-topics that need follow-up sources

After fetching, create a `raw/` file if the source is reliable and worth an ingest.

---

## Search (qmd)

**Re-index everything (wiki pages + raw sources):**
```bash
./tools/qmd-index.sh
```

**To search at the start of any INGEST or QUERY:**
```bash
./tools/qmd-index.sh search "query terms"          # wiki/ only (default)
./tools/qmd-index.sh search --raw "query terms"    # raw/ sources only
./tools/qmd-index.sh search --all "query terms"    # both
```

Fall back to `grep -r "terms" wiki/` if qmd errors.

A hit under `wiki/gaps/` or `wiki/tensions/` is a registry row, not a page — cite it by id (`G37`) and link the registry index unless the detail itself is the point.

## Decision-making

- `[[wiki/concepts/latent-graph-discovery.md]]` - **CORE PROBLEM FRAMING** — the unified problem: infer hidden graph structure from observations and navigate it; subsumes all task types; read when faced with a decision regarding the wiki content
- **Maintenance is key:** keep in mind when faced with a decision reagarding the wiki's structure.

---

## Conventions

- Internal links: `[[wiki/concepts/working-memory.md]]` — always use full path from repo root.
- Full expansion of all abbreviations (e.g. FT (Full-Term)), except terms that are really common (e.g AI, NN, ML, DNA, etc) or too long (AMPA (α-amino-3-hydroxy-5-methyl-4-isoxazolepropionic acid receptor)), in that case, they will be stored in `wiki/glossary.md`.
- Never modify a page without reading it.
- Gitlog is changelog. Commit only what you touched.
- Don't read between the line. Do only what is asked.
- Minimize prose: prefer tables, bullet points, equations.