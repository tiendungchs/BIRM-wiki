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

### Wave 26 — anchored to `../BIRM/STATUS.md` § Requests to the wiki: how a want is built, and whether a terminal signal alone builds one

Three requests from the sibling project are still open or open-in-part, and all three are
acquisition problems rather than writing problems. The wave buys one block per request.

**R4 (open, narrowed 2026-09-20)** — *learned wants from a reward channel alone*. The wiki holds
wanting as a **state-set gain on a recalled cue** ([[wiki/concepts/incentive-salience.md]], `κ·r + γV`)
and conditioned reinforcement as a **localisation** ([[wiki/entities/amygdala.md]]) with "no clean
psychological decomposition" ([[wiki/concepts/valuation-system-decomposition.md]]). What it has
never held is the **chain**: `primary reward → cue → cue-of-a-cue → activity`, and any evidence the
chain reaches an activity that never predicted a primary reward. `DESIGN.md` § 2 leaves every
intermediate goal to be learned from the two end channels, so this is the only mechanism the wiki
offers for a new want and it is held in pieces. Block A buys the chain, its limit, and its one
measured double dissociation.

**R5 (answered as a map 2026-09-20)** — *drives beyond the terminal reward*. The map exists
([[wiki/concepts/intrinsic-motivation-typology.md]], [[wiki/concepts/learning-progress.md]]) and two
cells of it are empty in a way that blocks a step-9 decision: **effort** is "a cost subtracted where
control is deployed, its form unmeasured" ([[wiki/concepts/expected-value-of-control.md]]), and the
**pull past a sufficient win** has no page at all. Block B buys the effort cost as a measured
quantity and the developmental evidence for a drive that runs with the terminal reward switched off.

**R2 (partly answered; the rest is `G72`)** — *intermediate goals invented under sparse terminal
reward alone*. Six mechanism pages from wave 21, **none of which infers success from the terminal
signal**: the goal space is designer-given ([[wiki/concepts/hindsight-goal-relabelling.md]]), or
there is no reward at all ([[wiki/concepts/eigenoption-discovery.md]]), or a decomposition is scored
only once proposed ([[wiki/concepts/optimal-hierarchy-criterion.md]]). Block C buys the four
architectures that claim what `G72` asks — subgoals out of a terminal-only signal — plus the one
result that reaches a sparse terminal reward while inferring nothing, as the negative control.

**Probe results, all 2026-09-20.** `pmc.ncbi.nlm.nih.gov` renders `PMC2648534`, `PMC3058375`,
`PMC5413864`, `PMC4445645`, `PMC7531891` and `PMC7293160` in full (body, figures, methods).
`ar5iv.labs.arxiv.org` renders `1609.05140` with equations inline; `1703.01161`, `1802.06070` and
`2101.04882` all build (`arxiv.org/html/<id>` also answers `200` for these four — either URL clips).
`nature.com` and `link.springer.com` answer `303` to their identity providers — **gated, therefore
`clip`** per the skill's rule, and both publishers are reachable through the institution
(wave 22–24 precedent). `learnmem.cshlp.org` answers `403` to `WebFetch`: a bot-block, not a paywall
verdict — Learning & Memory is free after 12 months and CSHL is not an excluded venue, so the row
stays `clip`; if the browser disagrees, the fallback is the `.full.pdf` at the same path.
Two rows take the `pdf` route because the publisher (APA `psycnet`) serves no HTML at all: both
author/repository copies answer `200 application/pdf`.
`science.org` is **excluded** and holds Poli 2020 — row B3 is the PMC mirror, which is the open
Science Advances deposit and complete. `annualreviews.org` is **excluded** and holds Shenhav et al.
2017, *Toward a rational and mechanistic account of mental effort*, which has **no PMC deposit**:
dropped, and `G89`/the effort half of R5 is worked from rows B1–B2 instead.
No target duplicates a `_work/manifest.tsv` row (477 rows checked).

#### A — R4: the chain from a primary reward to a want that has none

| # | Target | Clip URL | Venue | Route | Closes | Settles | Status |
|---|---|---|---|---|---|---|---|
| 1 | Gewirtz & Davis 2000, *Using Pavlovian higher-order conditioning paradigms to investigate the neural substrates of emotional learning and memory* | `https://learnmem.cshlp.org/content/7/5/257.full` | Learn. Mem. 7:257–266 | `clip` | `T359`, `G119`, `G118` | **The chain itself, stated as three separable memories.** First-order conditioning, second-order conditioning and *sensory preconditioning* are the three links R4 asks about, and the review's point is that they dissociate neurally — second-order fear conditioning needs NMDA receptors in the basolateral amygdala, and sensory preconditioning builds a link between two cues **with no reward present at all**. That last case is the strongest form of R4's question ("can the chain reach what never predicted a primary reward?") posed as an experiment rather than a speculation. The wiki's conditioned-reinforcement claim is currently one sentence on [[wiki/entities/amygdala.md]] with no source that runs the paradigm | `open` |
| 2 | Hackenberg 2009, *Token reinforcement: a review and analysis* | `https://pmc.ncbi.nlm.nih.gov/articles/PMC2648534/` | J. Exp. Anal. Behav. 91(2):257–286 | `clip` | `G119`, `G118`, `T367` | **The chain as a schedule, with the exchange rate exposed as a parameter.** A token is a conditioned reinforcer whose value is set by the schedule that converts it to a primary reward — which is exactly the quantity `DESIGN.md` § 2 needs and no wiki page states: *how much* an intermediate goal is worth relative to the terminal one, as a function of how many steps separate them. Also supplies the **symmetrical law of effect** — gains and losses measured in one currency, token-earning against token-loss — which is the behavioural counterpart of the two-channel question R1 closed on physiology, and the only source in reach that prices the two against each other | `open` |
| 3 | Flagel, Clark, Robinson, Mayo, Czuj, Willuhn, Akers, Clinton, Phillips & Akil 2011, *A selective role for dopamine in stimulus–reward learning* | `https://pmc.ncbi.nlm.nih.gov/articles/PMC3058375/` | Nature 469:53–57 | `clip` | `G118`, `T359`, `T355` | **`G118`'s `Closes when` asks for a double dissociation between an outcome's stored worth and the pursuit it commands; this is that dissociation, measured.** Sign-trackers and goal-trackers both *learn* the cue–reward relation, but a dopamine antagonist abolishes the cue's acquired pull in one group and leaves the learning intact in the other — the evaluative term and the motivational term separated by a drug rather than by an argument. [[wiki/concepts/incentive-salience.md]] asserts the split and cites no experiment in which one half is removed while the other survives | `open` |
| 4 | Sharpe, Chang, Liu, Batchelor, Mueller, Ahmed, Gardner, Schoenbaum & Iordanova 2017, *Dopamine transients are sufficient and necessary for acquisition of model-based associations* | `https://pmc.ncbi.nlm.nih.gov/articles/PMC5413864/` | Nat. Neurosci. 20:735–742 | `clip` | `G119`, `T367`, `G72` | **The single sharpest row on the wave for R4's remainder.** Optogenetic dopamine transients are shown to be sufficient and necessary for learning a **cue→cue** association in sensory preconditioning — a teaching signal with no reward in it, driving a link between two neutral stimuli. If the wiki's reward channel can write associations that predict nothing rewarding, then the chain to activities with no primary reward has a mechanism, and `G119`'s admissibility relation (which signal may update which learner) acquires its first biological instance: the same transient is a reinforcer for the model-based system and not a value update | `open` |
| 5 | Murayama 2022, *A reward-learning framework of knowledge acquisition: an integrated account of curiosity, interest, and intrinsic–extrinsic rewards* | `https://motivationsciencelab.com/wp-content/uploads/2022/01/Murayama_2022_A-reward-learning-framework-of-knowledge-acquisition.pdf` | Psychol. Rev. 129(1):175–198 | `pdf` | `G72`, `T360`, `G89` | **The only framework in reach that states R4's terminal case as a mechanism rather than a phenomenon.** Knowledge acquisition is itself the reinforcer, and *long-term development* — repeated reinforcement over months, not trials — is what turns a momentary curiosity into a stable interest in an activity that never predicted food, money or safety. That is the chain R4 asks for, run to its end. APA serves no HTML: download this author copy into `raw/`, I run `./tools/pdf2md.sh`, manifest flagged `LOSSY` (the Reading repository copy `centaur.reading.ac.uk/102242/1/Murayama_PR_accepted.pdf` is the accepted manuscript and also answers `200` if this one fails) | `open` |
| 6 | Williams 1994, *Conditioned reinforcement: neglected or outmoded explanatory construct?* | `https://link.springer.com/article/10.3758/BF03210950` | Psychon. Bull. Rev. 1:457–475 | `clip` | `T359`, `G119` | **The adversarial row, and it should be read against rows 1–5 rather than with them.** The paper's question is whether conditioned reinforcement is a real strengthening process or a redescription of stimulus control — i.e. whether the chain R4 wants to build on exists as a *mechanism* at all. A design that plans to bootstrap every intermediate goal from two end channels is betting on exactly the construct under attack here, and the wiki currently holds no statement of what the construct is accused of failing to explain | `open` |

#### B — R5: what pulls once the terminal reward is already collected

| # | Target | Clip URL | Venue | Route | Closes | Settles | Status |
|---|---|---|---|---|---|---|---|
| 7 | Kool & Botvinick 2018, *Mental labour* | `https://www.nature.com/articles/s41562-018-0401-9` | Nat. Hum. Behav. 2:899–908 | `clip` | `G89`, `T364`, `G118` | **Effort as a priced quantity, which is the form [[wiki/concepts/expected-value-of-control.md]] says is unmeasured.** The review is the cost-benefit account stated as a decision problem: when is effort declined, and what sets its intensity once accepted. R5 asks whether effort must be its own quantity or can be learned from the two channels, and this is the source that says what the quantity would have to be — a cost in the same currency as the reward it is traded against, with the exchange rate an empirical object | `open` |
| 8 | Westbrook & Braver 2015, *Cognitive effort: a neuroeconomic approach* | `https://pmc.ncbi.nlm.nih.gov/articles/PMC4445645/` | Cogn. Affect. Behav. Neurosci. 15:395–415 | `clip` | `G118`, `T364`, `G89` | **Row 7's measurements, and the half that touches `G118`.** The neuroeconomic framing makes effort *discountable* — an outcome's motivational pull falls with the effort required, by a measurable function — which is the same separation `G118` wants between what an outcome is worth and what it commands. Pair with row 7 at ingest: one states the decision problem, the other the elicited curves and the dopaminergic evidence that individual differences in effort discounting are a valuation parameter, not a capacity limit | `open` |
| 9 | Poli, Serino, Mars & Hunnius 2020, *Infants tailor their attention to maximize learning* | `https://pmc.ncbi.nlm.nih.gov/articles/PMC7531891/` | Sci. Adv. 6:eabb5053 | `clip` | `T370`, `T358`, `G89` | **`T370` is `LIVE` on two citing pages and both sides currently rest on group means from adult free play; this is the trial-by-trial version in 8-month-olds.** Surprise, environmental predictability and *learning progress* are entered as separate regressors against looking time and saccadic latency, so the row's central confound — learning progress against plain novelty (`T358`) — is addressed by design rather than by argument. It is also the wiki's only route to a **per-participant** operating point, which is precisely what `T370`'s `Closes when` asks for instead of a mean | `open` |
| 10 | Gopnik 2020, *Childhood as a solution to explore–exploit tensions* | `https://pmc.ncbi.nlm.nih.gov/articles/PMC7293160/` | Phil. Trans. R. Soc. B 375:20190502 | `clip` | `T370`, `G72`, `T366` | **The life-history argument for a period in which the terminal reward is deliberately switched off.** Children are cast as high-temperature explorers protected from the consequences of exploration by caregiving, and the claim is that the *sequence* — explore-first, exploit-later, with a developmentally scheduled transition — beats any fixed trade-off. That is a scheduling answer to R5's question ("what pulls once the task is solved?") and a direct constraint on `G72`: an architecture that must infer its own objective may need its exploration budget set exogenously rather than by a criterion it computes | `open` |
| 11 | Eisenberger 1992, *Learned industriousness* | `https://homepages.se.edu/cvonbergen/files/2013/01/Learned-Industriousness.pdf` | Psychol. Rev. 99(2):248–267 | `pdf` | `G118`, `T359`, `T362` | **The bridge between block A and block B, and the only mechanism in reach by which a *cost* becomes a want.** The claim is that reward delivered for high effort conditions reward value onto the sensation of effort itself, lowering effort's aversiveness and generalising across tasks — i.e. the block-A chain applied to an internal state rather than to an external cue, producing a durable trait. For R5 it is the sharpest available answer to "is the pull past a sufficient win learned from the two channels, or a separate quantity?": this says learned, and says by what rule. APA serves no HTML — download this copy into `raw/`, `./tools/pdf2md.sh`, manifest flagged `LOSSY` | `open` |

#### C — R2 / `G72`: subgoals out of a terminal signal alone

| # | Target | Clip URL | Venue | Route | Closes | Settles | Status |
|---|---|---|---|---|---|---|---|
| 12 | Bacon, Harb & Precup 2017, *The Option-Critic Architecture* | `https://ar5iv.labs.arxiv.org/html/1609.05140` | AAAI 2017; arXiv 1609.05140 | `clip` | `G33`, `G72`, `T367` | **The strongest published claim that a terminal-only signal is enough to invent intermediate goals, and the wiki cites none of it.** Intra-option policies *and their termination conditions* are differentiated end-to-end from the task reward with no subgoal, pseudo-reward or demonstration supplied — which is R2's question stated as a gradient. It also carries the failure that any design in this row inherits: without a termination regulariser the options collapse to primitives, so "learned from the terminal signal alone" is true only with a term that prices option duration, and nothing says what that term should be | `open` |
| 13 | Vezhnevets, Osindero, Schaul, Heess, Jaderberg, Silver & Kavukcuoglu 2017, *FeUdal Networks for Hierarchical Reinforcement Learning* | `https://ar5iv.labs.arxiv.org/html/1703.01161` | ICML 2017; arXiv 1703.01161 | `clip` | `G33`, `T367`, `G60` | **A subgoal that is a *direction in a learned latent space*, not a state — the one design in reach whose goal space is neither designer-given nor enumerated.** `T367` asks whether the subgoal-level error rides its own channel or the reward channel masked by the running option; this architecture answers *own channel* explicitly, with the manager trained by a transition-policy gradient and the worker by an intrinsic reward for following the direction. That makes it the counterpart to [[wiki/concepts/pseudo-reward-prediction-error.md]]'s biology and the paired case for row 12's single-channel design | `open` |
| 14 | Eysenbach, Gupta, Ibarz & Levine 2018, *Diversity Is All You Need: Learning Skills without a Reward Function* | `https://ar5iv.labs.arxiv.org/html/1802.06070` | ICLR 2019; arXiv 1802.06070 | `clip` | `G72`, `T365`, `T366` | **The control for rows 12–13: skills discovered with the reward channel disconnected entirely.** Maximising the mutual information between a latent skill index and the states it visits yields a set of behaviours that a downstream task can select among — the same shape as [[wiki/concepts/eigenoption-discovery.md]]'s graph-derived options but with the objective stated over the policy rather than over the Laplacian, which gives `T365` a second position ("neither bottlenecks nor eigenpurposes — discriminability") and gives `G72` the exact experiment R2 needs: does the terminal signal *add* anything to the decomposition, or only select from one that was already there? | `open` |
| 15 | OpenAI, Plappert, Sampedro, Xu, Akkaya, Kosaraju, Welinder, D'Sa, Petron, Pinto de Oliveira, Paino, McGrew, Ribas, Schneider & Zaremba 2021, *Asymmetric self-play for automatic goal discovery in robotic manipulation* | `https://ar5iv.labs.arxiv.org/html/2101.04882` | arXiv 2101.04882 | `clip` | `G72`, `T366`, `G33` | **A goal *generator* trained adversarially against the goal solver, which is the only construction in reach that satisfies [[wiki/concepts/hindsight-goal-relabelling.md]]'s constraint (a) — goals reachable-but-not-yet-reached — by building reachability in rather than assuming it.** Alice proposes by acting, so every goal is demonstrably attainable and Bob learns from her trajectory under sparse reward alone. For `T366` it is the widest goal set anyone has trained on with a measured effect on held-out tasks; for `G72` it is a partial answer with its limit visible, since the *space* of goals is still the environment's state space | `open` |
| 16 | Ecoffet, Huizinga, Lehman, Stanley & Clune 2021, *First return, then explore* | `https://www.nature.com/articles/s41586-020-03157-9` | Nature 590:580–586 | `clip` | `G72`, `G33`, `T358` | **The negative control the block needs, and the reason `G72` is not closed by rows 12–15.** Go-Explore reaches sparse terminal rewards that defeated every intrinsically-motivated method by *archiving states and returning to them before exploring* — no subgoal, no goal inference, no criterion for what counts as success beyond the score the environment emits. If the hardest terminal-reward-only benchmarks fall to bookkeeping over the state space, then "invent intermediate goals" is not forced by sparsity, and R2's premise needs restating as a claim about generalisation rather than about reachability. Also `T358`'s cleanest case: detachment from previously visited states is a novelty *penalty* failure mode, diagnosed rather than asserted | `open` |
