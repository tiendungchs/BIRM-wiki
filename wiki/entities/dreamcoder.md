# DreamCoder

**Grow the domain-specific language and the search strategy over it at the same time: a wake phase that solves tasks, an *abstraction* sleep phase that refactors the solutions and compresses out reusable fragments into new library primitives, and a *dreaming* sleep phase that trains a recognition network on replayed and fantasised problems.** Ellis, Wong, Nye, Sablé-Meyer, Cary, Morales, Hewitt, Solar-Lezama & Tenenbaum 2021, PLDI / arXiv:2006.08381. Source: `raw/ellis-2021-dreamcoder.md`.

This is the wiki's first-hand source for **library learning**, cited second-hand on four pages until now ([[wiki/concepts/program-induction.md]] cost 3, [[wiki/concepts/language-of-thought.md]] §4, [[wiki/empirical-tensions.md]] T155 Position A, [[wiki/entities/bayesian-program-learning.md]]). It is the only system in the wiki that **learns the prior over programs rather than being handed it**, and it does so by an objective — description length charged over the *solved corpus plus the library* — that is exactly the "length under enforced re-use" T155 asks for, arrived at from the library side.

---

## Architecture

| Element | Commitment |
|---|---|
| **Hypothesis space** | Polymorphically typed λ-calculus: conditionals, variables, higher-order functions, ability to define new functions |
| **Prior** | A library `L` defining a generative model `P[ρ\|L]` over programs; `P[L]` is a description-length prior over libraries |
| **Likelihood** | `P[x\|ρ]` — 0/1 for input–output tasks, a generative probability for probabilistic programs |
| **Posterior proposer** | Recognition network `Q(ρ\|x)`, architecture chosen for the domain's observation type (CNN for images) |
| **Objective** | Maximise a lower bound on `P[L\|X]` over a task set `X`, by the three alternating updates below |

The three updates, iterated (20 wake/sleep cycles is the standard run):

| Phase | Update | Mechanism |
|---|---|---|
| **Wake** | `ρ_x = argmax P[ρ\|x,L]` over programs `Q(ρ\|x)` ranks highly | Enumerate programs in decreasing probability under `Q`, test `P[x\|ρ] > 0`; keep a beam of `k = 5` and marginalise over it in the sleep updates |
| **Abstraction** (slow-wave analogue) | `L = argmax_L P[L] · Π_x max_{ρ a refactoring of ρ_x} P[x\|ρ] P[ρ\|L]` | Refactor each solved program into semantically equivalent forms, find the fragment whose adoption most shortens `−log P[L] + Σ_x −log P[x\|ρ]P[ρ\|L]`, add it, repeat until no gain |
| **Dreaming** (REM analogue) | Train `Q(ρ\|x) ≈ P[ρ\|x,L]` on `x ∼ X` (**replay**) and `x ∼ L` (**fantasy**), 50/50 | Not classic wake–sleep: fantasies are *problems*, which the system then **solves with the same search as waking**, and `Q` is trained on the solutions found |

### The two design decisions that carry the result

**1. Compress out *semantic* reuse, not syntactic reuse.** A candidate primitive is not a repeated subtree; it is a subtree of some *refactoring*. Fig. 3's worked case: two list programs written in a bare primitive set share no syntax, and refactoring both exposes `map`. The cost is that code refactors in infinitely many ways, so the number of λ-calculus evaluation steps separating a program from its refactoring is bounded (at **3**, without performance loss), leaving ~`10¹⁴` refactorings for the two programs in that figure. These are represented, not enumerated: a **version space** (version-space algebras + equivalence graphs, built by a dynamic program) with `10⁶` nodes, polynomial in program size, exponential only in the evaluation bound. Minutes instead of centuries.

**2. Train `Q` for MAP, not for the posterior.** `Q` maximises `E[log Q((argmax_ρ P[ρ|x,L]) | x)]` — all probability mass on **one** member of each set of syntactically distinct but semantically equivalent programs. This is **learned symmetry breaking**, replacing the hand-coded symmetry breaking that conventional synthesisers depend on.

### The two bootstraps

- **Library on library.** Each cycle's abstraction builds on primitives from earlier cycles, giving multi-layered hierarchies: `filter` → `maximum` → `nth largest` → `sort`.
- **Generative and recognition on each other.** A more specialised library makes richer fantasies, which train a better `Q`, which solves more tasks in waking, which feed the next library.
- **They attack orthogonal axes of the combinatorial explosion**: higher-level library routines cut the **depth** of search; `Q` down-weights unlikely branches, cutting its **breadth**.

---

## Key results

| Domain | Setup | Result |
|---|---|---|
| **List processing** | 218 tasks (50/50 split), 15 I/O examples each, generic functional basis | ~20 new routines learned; rediscovers `filter`. `Sort List` becomes **5 calls, < 10 min search**; the same program in base primitives is **32 calls**, ~`10⁷²` years of brute force |
| **Text editing** | Train on 128 auto-generated tasks; test on the 108 SyGuS-2017 problems | **3.7% → 79.6%** (10 min/problem), mean search **235 s → 40 s**; **84.3%** at the competition budget (1 h, 8 CPUs) vs **82.4%** for the winner CVC4 — and with *one* generic learned library where SyGuS supplies a hand-engineered library **per problem** |
| **LOGO graphics** | 160 images (50/50), pen + control flow + angle/distance arithmetic, 20 cycles | Learns parametric routines for polygons, circles, spirals — the object types of its visual world, unsupervised — plus **radial symmetry as a learned higher-order function** |
| **Tower building** | 107 block-copy tasks (50/50) | Learns parametric **options** (Sutton et al. 1999) — arches, staircases, bridges — as library entries ([[wiki/concepts/temporal-abstraction-options.md]]) |
| **Probabilistic regexes** | 256 web-crawled CSV columns, 5 strings each | Infers generative concepts for dates, times, currency; generates new instances and plausible near-misses |
| **Symbolic regression** | Rational functions / polynomials ≤ deg 4; real parameters fitted by inner-loop gradient descent, penalised by BIC | Recovers the right *number* of continuous parameters (3 for `1.7x²−2.1x+1.8`, 2 for `2.3/(x−2.8)`) |
| **Physics** | 60 AP/MCAT laws, from only `map`/`fold` + arithmetic | **93% after 8 cycles**; learns inner products, vector sums, norms, then an **inverse-square-law schema** shared by Newton's law and Coulomb's — a change of basis from list processing to physics |
| **Origami** | 20 intro-CS tasks, from a 1959 Lisp subset + the Y-combinator only | Solves all 20; reinvents `fold`, then `unfold`, then defines `map`, `zip`, `length`, ranges in terms of them — retracing the discovery of origami programming. **~5 days on 64 CPUs (~1 CPU-year)** |

### Ablations — what each phase is worth

Baselines: no-dreaming, no-abstraction, Exploration-Compression (compress syntactic reuse, no refactoring), a RobustFill neural synthesiser trained on the initial library, 24 h/task type-directed **enumeration** (up to 4·10⁸ programs per task), and two **Memorize** variants that add whole task solutions to the library without compressing.

- The full system solves the most held-out tasks in **every** domain, and generally fastest (mean 54.1 s, median 15.0 s). Both sleep phases contribute substantively.
- The synergy is largest in the *generative* domains: on LOGO and towers no alternative exceeds **60%** of held-out tasks while DreamCoder approaches **100%**.
- **Library depth correlates with tasks solved, `r = 0.79`.** The recognition model raises performance *at every depth* and also produces deeper libraries — so amortisation does not merely speed search up, it changes what gets abstracted.
- **Memorize losing is the discriminator for T155:** adding solutions wholesale gives the same expressivity and the same reuse opportunity; only *compression across the corpus* yields primitives that transfer.
- Typical convergence: ~1 day on 20–100 CPUs.

### Representational realignment

Over learning, the similarity structure of the recognition network's activations converges on the similarity structure of the *code components* used to solve the tasks (`p < 10⁻⁴`, χ² pre/post). t-SNE of the learned task similarities groups tasks by shared abstraction rather than surface form — the machine analogue of experts classifying physics problems by governing principle where novices classify by surface features (Chi et al. 1981). **This is the wiki's cleanest measurement that a learned symbolic vocabulary reorganises a neural embedding, rather than the two merely coexisting.**

---

## What it does to the four standing costs of [[wiki/concepts/program-induction.md]]

| Cost | Status after DreamCoder |
|---|---|
| **1. Somebody authors the library** | **Reduced, not paid.** The *domain* vocabulary is learned — vector algebra and inverse-square laws were never given, nor was `fold`. What remains authored is a generic basis: control flow, higher-order functions, recursion, types. The paper's stated position is that this is the right trade (the "sketching" argument) and that blank-slate learning is possible but a bad route — origami cost a CPU-year |
| **2. Search is intractable** | **Attacked on both axes and measured separately** — library depth cuts search depth, `Q` cuts search breadth, and the ablations show each is load-bearing. Where this conflicts with the ARC evidence that amortisation buys nothing, see [[wiki/empirical-tensions.md]] T309 |
| **3. The prior is doing unadvertised work** | **This is the page's contribution.** The prior is now *learned*, and its update rule is stated: adopt the refactoring fragment that most shortens library + corpus. Expressivity is unchanged; what changes is which programs are short — so "the DSL" is a moving target by construction |
| **4. Discrete search inherits nothing from a failure** | **Unpaid.** Waking is still enumerate-and-test; a rejected program returns one bit. `Q` re-ranks the enumeration but does not receive gradient from a near-miss |

---

## Limitations

| Limitation | Detail |
|---|---|
| **Crisp symbolic domains only** | The paper concedes it: solutions are well captured by symbolic forms even where inputs are pixels. Pervasive noise and uncertainty are named as the key open challenge |
| **Compute** | ~1 day on 20–100 CPUs typical; ~1 CPU-year for origami. The refactoring version space is exponential in the evaluation-step bound (set to 3) |
| **Tasks are given** | Waking samples random training tasks; the system never *generates* its own problems, chooses a curriculum, or acts on curiosity — the paper's own stated next step |
| **One domain at a time** | Eight separate runs with eight separate libraries. A cross-domain library — a metalearned "language of thought" that differentiates into domains — is proposed and not attempted (this is [[wiki/concepts/language-of-thought.md]]'s installed/acquired dispute in machine form) |
| **No aliasing, no simultaneity** | Complete input–output pairs, clean discovery-then-use separation. The two hardness sources of [[wiki/concepts/latent-graph-discovery.md]] that program induction cannot state are untouched |
| **No arity-driven typing of *learned* primitives** | Types exist and prune search, but they are the base language's types; nothing decides a new primitive's signature by what the domain needs (contrast [[wiki/entities/neural-module-networks.md]]) |

---

## Comparison

| System | Library origin | Prior over programs | Search | What separates it from DreamCoder |
|---|---|---|---|---|
| **DreamCoder** | Grown from a generic basis by corpus compression over refactorings | **Learned**, updated each cycle | Enumeration ranked by a recognition net trained on replays + fantasies | — |
| [[wiki/entities/bayesian-program-learning.md]] | Primitives learned in pre-training; **relation types authored** | Fixed hierarchical prior | Bottom-up proposals + local search | Two levels but no growth: the library never deepens across tasks |
| [[wiki/entities/neo-neural-theorizer.md]] | Induced from raw observation pairs (VQ codebook), semantics from one shared executor | MDL weight `λ`, fixed | Amortised proposer + sampling | Authors nothing, but symbols compose by concatenation only — no arity, no binding — and MDL *within an instance* destroys the vocabulary past `λ = 1.2` (T155) |
| [[wiki/entities/ilp-arc-synthesizer.md]] | **Authored** — 7 predicates | Clause length | Generative clauses, free rejection | Pays cost 1 in full and gets cost 4 back: its own generated objects supply negatives |
| [[wiki/entities/arc-vsa-solver.md]] | **Authored** — 11 operations | **Cross-demonstration reuse** (minimum hitting set), not length | Similarity-pruned | The other route to "reuse, not brevity": DreamCoder charges reuse across *tasks* by compression, this charges it across *demonstrations* by a hitting-set cost |
| [[wiki/concepts/test-time-training.md]] (transduction) | The pretraining corpus, implicitly | Implicit in the weights | One gradient trajectory | No program object, hence no library and no abstraction phase — DreamCoder is the constructive answer to why anyone wants the object |

---

## Biological reading

The two sleep phases are the paper's deliberate nod to the two-stage structure of biological sleep, and the mapping is stated as speculation, not as a model:

| DreamCoder phase | Biological analogue | What is shared |
|---|---|---|
| **Abstraction** | Slow-wave sleep | Formation and consolidation of **declarative** abstractions from the day's episodes ([[wiki/concepts/complementary-learning-systems.md]]) |
| **Dreaming** | REM / fast-wave sleep | **Procedural** skill, episodic replay *and* generative dreaming in one phase ([[wiki/concepts/offline-replay.md]]) |

**Why this matters beyond the analogy** — it is a *working* instance of gap G14's missing channel: the abstraction phase transports what the fast per-task solver discovered about single instances into a revision of the shared structure, and the transported object is a named, reusable primitive rather than a weight update. Two features a builder should carry: the selection criterion is **recurrence across the corpus** (a fragment must pay for itself across several solutions), and the phase **terminates by its own objective** — it stops adding primitives when no addition raises the posterior, which is the regulator G14 says nobody has.

**(brainstorm)** The fantasy half also supplies a mechanism the replay literature does not: replay in the wiki is always *of* something experienced, filtered by a transfer prior. DreamCoder's dreams are **novel programs sampled from the consolidated library and then solved** — recombinations never experienced, generated specifically because the recognition net cannot be trained on 100–200 tasks. If the same argument holds biologically, REM's function would be *coverage of the recombination space of consolidated abstractions*, and the empirical signature would be that dream content becomes more compositionally structured as expertise grows — which is exactly what Fig. 4D→E shows in the model.

---

## Connections

- **[[wiki/concepts/program-induction.md]]** — the family this instantiates, and the source of the four costs the table above scores: DreamCoder is the only member that learns its own prior, which converts cost 3 from an objection into an update rule.
- **[[wiki/concepts/language-of-thought.md]]** — supplies the machine form of that page's "the effective language of thought changes with learning": adding a library entry leaves expressivity unchanged and changes which thoughts are short, with the physics run as the worked change-of-basis.
- **[[wiki/concepts/amortized-inference.md]]** — the recognition net is the wake–sleep amortiser in its canonical form, with two additions the concept page did not have: the MAP objective as *learned symmetry breaking*, and the measurement that amortisation deepens the library rather than only speeding search.
- **[[wiki/concepts/offline-replay.md]]** — splits offline processing into two phases with different jobs (abstract vs. train the proposer) and adds fantasy alongside replay, which is a job the biological replay literature does not assign.
- **[[wiki/concepts/complementary-learning-systems.md]]** — a machine two-speed system where the slow store holds *symbolic* abstractions rather than distributed weights, so consolidation is compression over a corpus and its stopping rule is an explicit posterior.
- **[[wiki/concepts/compositionality.md]]** — the two-level MDL argument (`|primitives| + N·|arrangement|`) run as an optimisation rather than asserted, with library depth vs. tasks-solved (`r = 0.79`) as the measurement.
- **[[wiki/concepts/temporal-abstraction-options.md]]** — learned tower routines are parametric options obtained by *compressing solved plans*, which is an option-discovery rule that needs no reward, no bottleneck statistic and no termination condition.
- **[[wiki/entities/bayesian-program-learning.md]]** — the same two-level factorization with the library frozen: BPL shows what an installed hierarchy buys in sample efficiency, DreamCoder shows the hierarchy can be grown.
- **[[wiki/entities/neo-neural-theorizer.md]]** — the opposite corner of the same trade: NEO authors no primitives but cannot type or bind them and measures MDL destroying its vocabulary within an instance, where DreamCoder authors a generic basis and charges length across the corpus.
- **[[wiki/entities/neural-module-networks.md]]** — the complement on typing: NMN gets composition legality as a decidable type check but authors every signature, DreamCoder learns the primitives inside a typed λ-calculus without ever choosing a new one's signature from task demand.
- **[[wiki/entities/arc-agi.md]]** — the benchmark that forbids authoring the library and where this method's amortisation has not paid, which is the whole of T309.
- **[[wiki/entities/arc-vsa-solver.md]]** — the same "reuse, not brevity" selection reached from the demonstration side by a minimum hitting set, against DreamCoder's compression across tasks.
- **[[wiki/concepts/latent-graph-discovery.md]]** — a running instance of meta-graph growth: the library *is* the meta-graph, and the abstraction phase is the only ingested mechanism that edits it from instance solutions.
- **[[wiki/entities/sme.md]]** — the matching side of the same commitment: SME requires relations to be re-represented into a canonical language before they can be identical, and DreamCoder's abstraction phase is a mechanism that *builds* such a canonical language by refactoring.
