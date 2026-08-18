# Wiki Schema — Brain-Inspired Models for Abstract Reasoning

This file is the operating contract for this wiki. Every interaction follows these rules. Read this file at the start of every session before doing anything else.

---

## Mission

This wiki is a persistent, compounding knowledge base for research on **brain-inspired machine learning models capable of abstract reasoning**. The human curates sources and asks questions. The LLM writes and maintains all wiki content — summaries, entity pages, concept pages, cross-references, and filed query answers. Nothing is re-derived from scratch; everything builds on what is already in the wiki.

**Primary purpose: brainstorming.** The wiki is a thinking tool first. Synthesis, architectural speculation, cross-paper connections, and general domain knowledge are first-class content — sources are useful but not required. Every page should move thinking forward, not merely report what sources say.

---

## Directory Layout

```
PersonalWiki/
├── CLAUDE.md                   ← this file: schema and operating rules
├── index.md                    ← lightweight routing file (links to wiki indexes)
├── log.md                      ← append-only chronological log
├── raw/                        ← immutable source documents (never modify)
│   └── assets/                 ← locally downloaded images
├── tools/
│   └── qmd-index.sh            ← hybrid BM25+vector search script
└── wiki/                       ← all LLM-generated content
    ├── overview.md             ← high-level synthesis of the research area
    ├── priority-tasks.md       ← current priority tasks identified from lint passes
    ├── architectural-gaps.md   ← current architectural gaps, updated each digest
    ├── empirical-tensions.md   ← current empirical tensions, updated each digest
    ├── glossary.md             ← abbreviation expansions
    ├── index-papers.md         ← papers list
    ├── index-concepts.md       ← concepts list
    ├── index-entities.md       ← models, benchmarks, biological systems list
    ├── entities/               ← models, benchmarks, biological systems
    ├── concepts/               ← core ideas, techniques, mechanisms
    ├── papers/                 ← per-paper summary pages
    └── queries/                ← filed answers to significant queries
```

**Rules:**
- Never modify files under `raw/`. They are the source of truth.
- All wiki content lives under `wiki/` or at the root (index.md, log.md).
- File names: lowercase, hyphens for spaces, `.md` extension. Example: `wiki/concepts/working-memory.md`.

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

**Paper pages** (`wiki/papers/`): **source stubs only** — not full summaries.
- Structure: Citation line → key computational insights as bullet points → Limitations (2–3 lines) → links to relevant concept/entity pages
- Target length: ~200 words. No TL;DR, no detailed results section, no extensive background.
- Full detail lives in the concept/entity pages the paper informs.

**Query pages** (`wiki/queries/`): filed answers to significant questions.
Structure: Question → Answer (full, with citations to wiki pages) → Implications → Follow-up questions.

**Overview** (`wiki/overview.md`): the master synthesis. Updated after every 10 ingests or when a major insight changes the picture. Sections: The Central Thesis → Master Problem Framing: Latent Graph Discovery → Current best understanding → Key open problems → Promising directions → Major controversies.

**index.md** — lightweight routing file only: links to `wiki/architectural-gaps.md`, `priority-tasks.md`, `empirical-tensions.md`, `wiki/index-papers.md`, `wiki/index-concepts.md`, `wiki/index-entities.md`, and the queries list. Keep it under 30 lines.

**wiki/index-papers.md** — papers list only. Each entry: `- [Title](path) — one-line description`. Updated after each ingest.

**wiki/index-concepts.md** — concepts list only. Same format. Updated when a new concept page is created.

**wiki/index-entities.md** — models, benchmarks, and biological systems. Same format. Updated when a new entity page is created.

---

## Operations

The three core operations live as project skills under `.claude/skills/`. Invoke the skill — do not improvise the procedure from memory.

| Operation | Skill | Trigger |
|---|---|---|
| INGEST | `wiki-ingest` | User drops a source in `raw/` and says "ingest [filename]", or asks for a paper/article/talk to be filed |
| QUERY | `wiki-query` | User asks any substantive question about the domain or the wiki's contents |
| LINT | `wiki-lint` | User says "lint the wiki" / asks for an audit; also suggest it after roughly every 20 ingests |

Each skill owns its step list, scope limits, and `log.md` append. This file owns the schema they follow: directory layout, page formats, and the conventions below.

---

## Web Search

Use WebSearch/WebFetch when:
- The user asks for it explicitly
- A lint pass reveals a factual gap that a quick search could fill
- A lint pass identifies important sub-topics that need follow-up sources

After fetching, treat the result as an ephemeral source: extract relevant facts into existing wiki pages rather than creating a `raw/` file (which is for curated sources only).

---

## Search (qmd)

**Re-index all wiki pages:**
```bash
./tools/qmd-index.sh
```

**To search at the start of any INGEST or QUERY:**
```bash
./tools/qmd-index.sh search "query terms"
```

Fall back to `grep -r "terms" wiki/` if qmd errors.

## Domain Taxonomy

This wiki covers the intersection of neuroscience-inspired AI and abstract reasoning. Key top-level categories:

**Concepts:**
- `latent-graph-discovery` — **CORE PROBLEM FRAMING** — the unified problem: infer hidden graph structure from observations and navigate it; subsumes all task types
- `abstract-reasoning` — the target capability: analogical reasoning, systematic generalization, rule learning, compositional generalization
- `working-memory` — short-term state maintenance mechanisms (biological and artificial)
- `attention` — selective routing of information (transformers, cortical columns, etc.)
- `hierarchical-representations` — multi-level feature abstraction
- `predictive-coding` — error-minimization frameworks (Friston, Rao & Ballard)
- `neuromodulation` — dopamine, acetylcholine signals mapped to learning rate / gating
- `sparse-distributed-representations` — SDR theory, HTM
- `binding-problem` — how features get associated into coherent objects
- `compositional-generalization` — combining known primitives in novel ways
- `meta-learning` — learning to learn; few-shot generalization

---

## Conventions

- - Internal links: `[[wiki/concepts/working-memory.md]]` — always use full path from repo root.
- Full expansion of all abbreviations (e.g. FT (Full-Term)), except terms that are really common (e.g AI, NN, ML, DNA, etc) or too long (AMPA (α-amino-3-hydroxy-5-methyl-4-isoxazolepropionic acid receptor)), in that case, they will be stored in `wiki/glossary.md`.
- **Editing existing lines:** never reconstruct an Edit `old_string` from memory — copy the exact current text, including markdown emphasis markers, whitespace, and link formatting. `wiki/glossary.md` in particular bolds *some* abbreviation keys inconsistently (`| **DLPFC** | ...` vs. `| PFC | ...`) with no rule; always grep/read the target row first and match it verbatim.
- Uncertainty: prefix claims with `(tentative)` when based on non-scientific source or the user has flagged doubt.
- Quote policy: keep direct quotes minimal and always cite the source slug.
- Minimize prose: prefer tables, bullet points, equations. Every sentence must carry information relevant to building a reasoning model.