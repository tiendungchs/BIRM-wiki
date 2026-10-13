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

**Wave 30 — what a bounded predictor must internalize.** Theme set by the user (2026-10-13): an agent
dropped into a generated world at one state and one position, seeing a small part of the state,
needs higher-level laws only because its view, memory and time are limited; the world itself runs on
base rules and a generator and never uses a higher-level law. The wave is built from the registry
rows that framing touches, not from the theme: the open **price on computation** (`G107`, `T135`,
`G86`, `G24`, `G25`, `G98`), the **cost of fast learning in generality** (`T93`, `G23`, `T16`, `G35`,
`G26`, `T155`), and **why a higher-level law exists for an observer at all** (`G27`, `G92`, `G31`,
`G81`, `G2`). `G107` and `G24` are `L3`: their sources land as prose in concept bodies, as `G101`'s did
(`P25`), and open no registry row. Not on the list: Daw, Niv & Dayan 2005, Kool & Botvinick 2018,
Shenhav 2013, Hutter 2000, Delétang 2023, Tishby 2015, Sun 2023, Kumaran 2016, Wang 2018 — already in `raw/`.

**Probe results, 2026-10-13.** `journals.plos.org` renders Keramati et al. 2011 in full (seven
equations as images). `ar5iv.labs.arxiv.org` renders Ortega & Braun 2013, Shalizi & Crutchfield 2001,
Shalizi & Moore 2003, Israeli & Goldenfeld 2006 and Bialek et al. 2001 in full with equations;
`arxiv.org/html/2402.09090` renders Rosas et al. 2024 in full. ar5iv has **no** rendering for
`1408.2048`, `1207.4167` (both redirect to the abstract) or `cs/9505103` (fatal conversion error):
those three are `pdf`. `nature.com` answers `303` to its identity provider for Callaway et al. 2022:
gated, so `clip`, as in the wave-29 precedent. `sciencedirect.com`, `cell.com`, `mdpi.com` and
`royalsocietypublishing.org` answer `403` to the fetcher; the Cell Press and MDPI pages are
institution- or openly-reachable HTML, so `clip`. Lieder & Griffiths 2020 is Behavioral and Brain
Sciences (`cambridge.org`, excluded): the author copy at `cocosci.princeton.edu` is the route. Simon
1955 (Oxford QJE) and Simon 1956 (APA PsycNet) are PDF-only at their publishers. Scholarpedia's
*Algorithmic probability* was dropped: its HTTPS certificate is expired and it answers only over
plain HTTP, so neither `self` nor a clean `clip`; Rathmanner & Hutter 2011 takes its place.

### Block A — the price of a computation (`G107`, `T135`, `G86`, `G24`, `G25`, `G98`)

| # | Target | Clip URL | Venue | Route | Closes | Settles | Status |
|---|---|---|---|---|---|---|---|
| A1 | Simon 1955, *A behavioral model of rational choice* | `https://academic.oup.com/qje/article/69/1/99/1919737` | Q. J. Econ. 69(1) | `pdf` | `G107`, `G86` | **The first stopping rule whose threshold is set at run time.** Satisficing: search stops when an alternative clears an aspiration level, and the aspiration level rises or falls with how easily alternatives were found. `G107` asks for a price on computation that an agent sets from a quantity it measures; `G86` asks for one scalar coupling a stopping rule to memory. This is the primary source for both ideas, cited nowhere in the wiki. The institution has Oxford; the article is a PDF, so `LOSSY` | `open` |
| A2 | Simon 1956, *Rational choice and the structure of the environment* | `https://doi.org/10.1037/h0042769` | Psychol. Rev. 63(2) | `pdf` | `G23` | **A prior's adequacy stated as a condition on the environment.** The paper shows that an organism with one need, a short memory and a limited view can satisfice with trivial rules *given* the environment's structure (clue density, path lengths), and names the structure a rule depends on. `G23` says machine priors are unconditional and a prior needs an entry test: this is the earliest statement that a simple rule's rationality is conditional, with the condition written out. APA serves PDF only: `LOSSY` | `open` |
| A3 | Keramati, Dezfouli & Piray 2011, *Speed/accuracy trade-off between the habitual and the goal-directed processes* | `https://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1002055` | PLoS Comput. Biol. 7(5) | `clip` | `T135` | **Position B's primary, cited on four pages with no file in `raw/`.** Arbitration as value of perfect information: deliberate when the expected gain from the tree's estimate over the cache's exceeds the cost of deliberation time. It is the one model that predicts `T135`'s discriminating result (response deadline shifts control to the cache) and it has reaction-time predictions the wiki has never read first-hand (reversal learning, number of choices). Full HTML, equations 1–7 | `open` |
| A4 | Hay, Russell, Tolpin & Shimony 2012, *Selecting computations: theory and applications* | `https://arxiv.org/pdf/1408.2048` | UAI 2012 | `pdf` | `G107`, `T135` | **The price of a computation derived from the decision it would improve.** A metalevel MDP whose actions are computations and whose reward is the change in expected utility of the object-level decision; the paper proves myopic value of computation is not optimal and gives the correction. `G107`'s `Closes when` needs a price computed at run time from a measured quantity; this is the formal object, with its known failure. No HTML anywhere (ar5iv redirects to the abstract): `LOSSY` | `open` |
| A5 | Russell & Subramanian 1995, *Provably bounded-optimal agents* | `https://arxiv.org/pdf/cs/9505103` | J. Artif. Intell. Res. 2 | `pdf` | `G25`, `G107` | **What optimality means for an agent that cannot compute the optimal action.** Bounded optimality: the best *program* for a given machine and environment class, not the best action. `G25` says optimality cannot be certified for an agent whose actions shape its data; this is the one certification that survives that objection, and it says which part of the agent carries the price (`G107`): the program, not the choice. ar5iv conversion fails: `LOSSY` | `open` |
| A6 | Ortega & Braun 2013, *Thermodynamics as a theory of decision-making with information processing costs* | `https://ar5iv.labs.arxiv.org/html/1204.6481` | Proc. R. Soc. A 469(2153) | `clip` | `G107` | **Utility and computation made commensurable.** A free-energy functional in which deviation from a prior policy is priced in bits by one inverse temperature; the optimum is a Boltzmann policy, satisficing and the certainty equivalent fall out, and the limit cases recover the fully rational and the fully habitual agent. `g107.md` names commensurability as the missing precondition for a run-time price; this is the construction that supplies it, with the price still a free constant. Full ar5iv rendering | `open` |
| A7 | Lieder & Griffiths 2020, *Resource-rational analysis: understanding human cognition as the optimal use of limited computational resources* | `https://cocosci.princeton.edu/papers/liederresource.pdf` | Behav. Brain Sci. 43:e1 | `pdf` | `G107`, `T135`, `T104` | **The method that turns a hand-set compute price into a derived quantity.** Five-step procedure: fix the function, posit the resources and their cost, derive the optimal algorithm, compare with behaviour, iterate. It subsumes `T135`'s two positions as different cost models and gives `T104` its framing (is the capacity limit a resource or a chosen margin). Behavioral and Brain Sciences is Cambridge, excluded; the author copy carries the target article, the commentaries and the response: `LOSSY` | `open` |
| A8 | Callaway, van Opheusden, Gul, Das, Krueger, Griffiths & Lieder 2022, *Rational use of cognitive resources in human planning* | `https://www.nature.com/articles/s41562-022-01332-8` | Nat. Hum. Behav. 6(8) | `clip` | `G24` | **A planning depth set by a computed quantity, in humans.** Planning as a metalevel MDP over which node to expand; the optimal policy is derived and participants, in a mouse-tracking task, switch strategy with the reward structure as the optimal policy does, and no single heuristic (best-first included) fits. `G24` asks for a horizon the agent computes that tracks the task's reward timescale; this is the behavioural existence proof. Gated HTML, institution route | `open` |
| A9 | Dasgupta & Gershman 2021, *Memory as a computational resource* | `https://doi.org/10.1016/j.tics.2020.12.008` | Trends Cogn. Sci. 25(3) | `clip` | `G98` | **A rule for what belongs in a store: reuse value against recomputation cost.** Memoization and its distributed form, amortization, across imagery, arithmetic, planning and inference. `G98` (what belongs in weights and what in an addressable store, cited by one page) has no criterion at all; this review states one and reports the behavioural signatures that would test it. Cell Press HTML, institution route | `open` |

### Block B — what fast learning costs in generality (`T93`, `G23`, `T16`, `G35`, `G26`, `T155`)

| # | Target | Clip URL | Venue | Route | Closes | Settles | Status |
|---|---|---|---|---|---|---|---|
| B1 | Botvinick, Ritter, Wang, Kurth-Nelson, Blundell & Hassabis 2019, *Reinforcement learning, fast and slow* | `https://www.cell.com/trends/cognitive-sciences/fulltext/S1364-6613(19)30061-0` | Trends Cogn. Sci. 23(5) | `clip` | `T93`, `G23` | **The speed-versus-generality trade stated as a bias-variance claim.** Episodic RL and meta-RL learn fast because a slow process installed an inductive bias, and a bias that buys speed narrows what can be learned; the paper makes the trade explicit and names the two slow processes. `T93` asks whether abstraction enables generalization or only speeds it; `G23` asks what an installed prior's entry test is. Cited second-hand on two pages, no file. Open access at Cell; institution route if gated | `open` |
| B2 | Bialek, Nemenman & Tishby 2001, *Predictability, complexity, and learning* | `https://ar5iv.labs.arxiv.org/html/physics/0007070` | Neural Comput. 13(11) | `clip` | `T16`, `G35` | **What a predictor must keep is the subextensive part of the past, and its size measures the model class.** Predictive information `I_pred(T)`: the mutual information between past and future; it is the unique measure of complexity that is finite for learnable processes, and its growth rate (logarithmic, with coefficient `K/2` for `K` parameters) is the learning curve. `T16` and `G35` argue over charging parameters to the message; this paper derives the charge from the data's own statistics. Full ar5iv rendering | `open` |
| B3 | Solomonoff 1964, *A formal theory of inductive inference, Part I* | `https://www.sciencedirect.com/science/article/pii/S0019995864902232/pdf` | Inf. Control 7(1) | `pdf` | `T16`, `G26` | **The primary source for Position A of `T16`, cited on four pages with no file.** The universal prior, its four equivalent constructions and the argument that it is the only prior a predictor with no further knowledge can hold. `G26` says nothing selects hypotheses by structure rather than by length; the paper is where length was first made the criterion, and where its justification can be read against `G26`'s objection. Elsevier open archive, PDF scan: `LOSSY` | `open` |
| B4 | Rathmanner & Hutter 2011, *A philosophical treatise of universal induction* | `https://www.mdpi.com/1099-4300/13/6/1076/htm` | Entropy 13(6) | `clip` | `T16`, `G26` | **The readable form of B3, with the objections.** Epicurus, Occam, Bayes and Turing combined into Solomonoff induction, then the known problems: the choice of reference machine, the structure-blindness of a length prior, the gap between the mixture's asymptotic guarantee and a single finite program. The last is `T16`'s own caveat (passive mixture against finite-horizon program), so this is the source that keeps the two regimes apart. Open HTML; MDPI blocks the fetcher | `open` |
| B5 | Chater & Vitányi 2003, *Simplicity: a unifying principle in cognitive science?* | `https://www.cell.com/trends/cognitive-sciences/fulltext/S1364-6613(02)00005-0` | Trends Cogn. Sci. 7(1) | `clip` | `T155` | **One simplicity prior across perception, language and induction, with its evidence.** The claim that the cognitive system selects the shortest description, instantiated in perceptual organization, grammar induction and similarity. `T155` asks whether a simplicity prior selects structure or destroys it; this is the strongest statement of the selecting side in cognition, and it lists the cases where the prior and the human answer agree. Cell Press HTML, institution route | `open` |

### Block C — why a higher-level law exists for an observer (`G27`, `G92`, `G31`, `G81`, `G2`, `G98`)

| # | Target | Clip URL | Venue | Route | Closes | Settles | Status |
|---|---|---|---|---|---|---|---|
| C1 | Shalizi & Crutchfield 2001, *Computational mechanics: pattern and prediction, structure and simplicity* | `https://ar5iv.labs.arxiv.org/html/cond-mat/9907176` | J. Stat. Phys. 104 | `clip` | `G27`, `G98` | **A discretisation criterion the model computes: two histories are one state iff they predict the same future.** Causal states are the unique minimal sufficient statistic for prediction, and the ε-machine over them is a latent graph read off a stream. `G27`'s `Closes when` asks for nodes carved from a continuous stream by a criterion the model computes; this is that criterion with its optimality and uniqueness proofs, and it prices the store (`G98`) as the statistical complexity `C_µ`. Cited on no page under this name. Full ar5iv rendering | `open` |
| C2 | Shalizi & Moore 2003, *What is a macrostate? Subjective observations and objective dynamics* | `https://ar5iv.labs.arxiv.org/html/cond-mat/0303625` | arXiv cond-mat/0303625 | `clip` | `G27`, `G92` | **The user's framing made formal: a higher level exists because of what an observer can see.** Macrostates are the causal states of a coarse-grained observation; a level of description is objective when those states are Markov, and emergence is a gain in prediction efficiency per bit stored. Supplies `G27` the test for whether a carving is a level and `G92` a derivation of where the observer's description boundary falls. Full ar5iv rendering | `open` |
| C3 | Israeli & Goldenfeld 2006, *Coarse-graining of cellular automata, emergence, and the predictability of complex systems* | `https://ar5iv.labs.arxiv.org/html/nlin/0508033` | Phys. Rev. E 73:026203 | `clip` | `G31` | **Predictability is a property of the coarse-graining, not of the system.** Computationally irreducible automata, rule 110 included, become predictable once coarse-grained, and the fraction of rules that admit a coarse-graining is bounded by Kolmogorov complexity. `G31` says generalization difficulty is uncomputable and unapproximated; this result says the quantity is undefined until the observer's resolution is fixed, which changes what an approximation must take as input. Full ar5iv rendering | `open` |
| C4 | Rosas, Geiger, Luppi, Seth, Polani, Gastpar & Mediano 2024, *Software in the natural world: a computational approach to hierarchical emergence* | `https://arxiv.org/html/2402.09090` | arXiv 2402.09090 | `clip` | `G92`, `G27` | **A level is software when its causal states are closed to the level below.** Computational closure, built on C1's ε-machines, with worked cases (Ehrenfest diffusion, Ising, modular random walks, attractor memory retrieval) and a hierarchy of nested levels. The world runs only the base rules; a higher law is a closed macro-process an observer can run without the micro state. Gives `G92` a boundary criterion that does not need efference copy and `G27` a test on real dynamics. Full arXiv HTML | `open` |
| C5 | Singh, James & Rudary 2004, *Predictive state representations: a new theory for modeling dynamical systems* | `https://arxiv.org/pdf/1207.4167` | UAI 2004 | `pdf` | `G81`, `G2` | **State defined as a set of predictions about observables, with no hidden-state ontology.** A system-dynamics matrix over histories and tests; its rank is the number of core tests, and the PSR built on them is at least as compact as any POMDP of the same system. `G81` says no graph-discovery mechanism estimates edges through an observation model; `G2` asks for de-aliasing without a hand-built state space. Here the observation model *is* the state. No HTML (ar5iv redirects to the abstract): `LOSSY` | `open` |

Nineteen rows: twelve `clip`, seven `pdf`, no `self`. Block A closes nothing alone: it gives
`T135` its Position B primary and the deadline-manipulation logic for its discriminating experiment,
and gives `G107` the three constructions (value of computation, bounded optimality, information-cost
free energy) a run-time price could be built from. Block B gives `T16` both primaries and the
measure (`I_pred`) under which `G35`'s parameter charge is derived rather than imposed. Block C gives
`G27` a computable carving criterion with proofs and `G92` two boundary criteria that do not need
an action stream, which is the one route `g092.md`'s `Closes when` currently names.
