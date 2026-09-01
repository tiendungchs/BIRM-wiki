# GPQA — the benchmark whose difficulty is measured against a human holding a search engine

**448 four-way multiple-choice questions (546 extended, 198 "Diamond") in biology, physics and chemistry, written by people holding or pursuing a PhD in the question's own subdomain, validated twice by other in-domain experts and three times by equally-credentialed experts *from other fields* who are given unrestricted internet access and unlimited time. The number the benchmark exists to produce is not an accuracy but a difference: in-domain experts 65%, skilled non-experts with the web 34%, chance 25%. That 31-point gap is the wiki's only direct measurement of how much of an expert's competence is *not* retrievable, and it is measured per item at authoring time rather than asserted.**

> **Provenance.** Rein, Hou, Stickland, Petty, Pang, Dirani, Michael & Bowman 2023, *GPQA: A Graduate-Level Google-Proof Q&A Benchmark* (`raw/rein-2023-gpqa-benchmark.md`). All numbers are the paper's own; the wiki has no post-2023 GPQA scores at source. GPQA = Graduate-Level Google-Proof Q&A. RLHF = Reinforcement Learning from Human Feedback. CoT = chain of thought.

---

## The artefact

| Split | Rule | Count | Expert acc. | Non-expert acc. | "Sufficient expertise?" |
|---|---|---|---|---|---|
| Extended | everything collected | 546 | 64.8% | 34.1% | 90.7% |
| **GPQA (main)** | ≥1/2 experts agree ∧ ≤2/3 non-experts correct | 448 | 71.9%* | 30.4%* | 93.5% |
| **Diamond** | 2/2 experts agree ∧ ≤1/3 non-experts correct | 198 | 81.3%* | 22.1%* | 97.0% |

`*` **is the authors' own asterisk**: main and Diamond were *selected* on validator accuracy, so their human baselines are selection-biased upward and their non-expert baselines biased downward. The unbiased human numbers are the Extended row. Any later claim of the form "model beats the 81.3% PhD baseline" is quoting a filtered statistic against an unfiltered model score — the paper states the true value lies between the two rows and does not estimate it.

| Property | Value |
|---|---|
| Format | 4-way multiple choice; questions written to be answerable *without* the choices, so a free-response version is possible |
| Median length | 561 characters / 146 tokens (question + choices) |
| Domains | Physics 227 (quantum mechanics 64, high-energy 46, general 43, astrophysics 42, …), chemistry 214 (organic 144, general 64, …), biology 105 (molecular 85, genetics 20) |
| Side information | A written explanation per item: why the key is right *and why each distractor is plausible but wrong* |
| Leakage defence | Pre-registered canary string embedded in the dataset + a request never to post items in plain text or as images |
| Held out | 18 questions kept unreleased |

---

## The construction protocol: difficulty bought with an incentive structure

Four stages — write → expert validation 1 (answer + feedback) → revision by the writer → expert validation 2 (answer + feedback, no further revision) → three non-expert validations. 61 contractors, all in or through a PhD, hired on Upwork; ~$95/hour effective, $150/hour ceiling.

The design content is in **what each party is paid for**, because the two goals (objective *and* hard) pull against each other and the payment schedule is what holds both:

| Role | Base | Bonus for **objectivity** | Bonus for **difficulty** |
|---|---|---|---|
| Question writer | $10 | $20 per expert validator who answers **correctly** (×2) | $15 per non-expert who answers **incorrectly** (×3), plus **$30 for both at once** (2/2 experts right ∧ ≥2/3 non-experts wrong) |
| Expert validator | $10 | $10 for answering correctly; $10 to validator #1 if validator #2 then answers correctly (i.e. paid for *feedback that improves objectivity*) | $5 if the majority of non-experts is wrong |
| Non-expert validator | $10 | — | $30 for answering correctly (paid to *break* the item) |

**Two features worth stealing.** (i) The writer is paid a *conjunction* bonus, not two independent bonuses — the cheap degenerate strategies (write something trivially checkable; write something incoherent) each forfeit half the schedule and the conjunction premium. (ii) Validator #1 is paid on validator #2's outcome, which is the only place in the wiki's benchmark inventory where an annotator is compensated for the *downstream* effect of their feedback rather than for their own answer.

**Non-expert validation is the actual instrument.** Non-experts are the *same population* — question writers and expert validators in other fields — with unrestricted web access (LLM assistants forbidden), a 15-minute floor, and no near-domain assignment (a physicist may not validate any other physics subdomain; organic chemists may not validate biology). Median time 30 minutes, mean 37, top quintile ≥45. Qualitatively: one non-expert wrote a computer simulation to attack a physics item; several read research papers, occasionally the question writer's own.

---

## What the design measures: the expertise gap

| Domain | *n* | Expert | Non-expert | **Δ** | GPT-4 few-shot CoT |
|---|---|---|---|---|---|
| Chemistry | 214 | 72.0% | 31.4% | **40.6** | 31.8% |
| Physics | 227 | 57.3% | 32.5% | **24.8** | 37.0% |
| Biology | 105 | 66.7% | 43.2% | **23.5** | 58.1% |

Δ is the paper's expertise gap. Read as an instrument rather than as a table of results, it says three things the wiki did not have:

1. **Expertise is not information access.** A PhD in another science, motivated by a $30 bonus, given the whole internet and 37 minutes, gets 9 points over chance. Whatever the expert has is a *compiled* ability to select and apply, not a document they could have found. This is a measurement against the common reading of "crystallized knowledge" as retrievable content — see [[wiki/architectural-gaps.md]] G17.
2. **The gap is domain-specific and does not track machine difficulty.** Chemistry has the largest human gap (40.6) and is GPT-4's *worst* domain (31.8%); biology has the smallest gap (23.5) and is its best (58.1%). Human-hard and model-hard are close to orthogonal here, which is the same dissociation ARC reports from the other end.
3. **A retrieval baseline is a cheap benchmark-hygiene control.** Any benchmark can run it: hand the item to a competent non-specialist with a search engine and a stopwatch. It bounds the shortcut "the answer is on the web" without needing to know what the intended ability is — which is exactly the precondition the partition instruments in [[wiki/concepts/shortcut-learning.md]] require and this one does not. The paper also reports the classical version (Appendix A.2): simple classifiers on surface features of the question and choices cannot infer the key, so there are no "easy tells".

---

## Baselines — and the result that a search tool buys nothing

| System | Extended | Main | Diamond |
|---|---|---|---|
| Llama-2-70B-chat, few-shot CoT | 30.4 | 29.1 | 28.1 |
| GPT-3.5-turbo-16k, few-shot CoT | 28.2 | 28.0 | 29.6 |
| GPT-4, few-shot CoT | 38.7 | 39.7 | 38.8 |
| **GPT-4 + search** (self-ask; backs off to CoT on abstention) | **39.4** | 41.0 | 38.8 |
| Expert validators | 65.4 | 72.5* | 81.2* |
| Non-expert validators | 33.9 | 30.5* | 21.9* |

Few-shot CoT exemplars are the *question writers' own explanations* — in-domain, detailed, unoptimised for any model.

**The load-bearing negative result.** Adding an internet search tool moves GPT-4 by **+0.7 points** (38.7 → 39.4 on Extended) while raising the abstention rate from **4.0% to 37.2%** on the main set, so heavily that the reported score needs a back-off to the closed-book answer to be comparable at all. The machine reproduces the human control condition: retrieval does not substitute for compiled expertise even when the retriever is the strongest model available. The authors' own reading is charitable — models "struggle to use tools effectively" and prompt changes were not swept — but the direction agrees with the 34% human number obtained by people who are extremely good at search.

*(brainstorm)* The abstention figure is the more interesting half and nobody has chased it. A closed-book model answers 96% of the time; the same model with evidence in front of it declines a third of the time. If that is calibration — the retrieved documents let it *notice* that it cannot ground the answer — then the search tool improved the system's self-knowledge by ~33 points while improving its accuracy by ~0, and the benchmark scored only the second. That would make GPQA + a search tool the cheapest available probe of whether a model knows what it does not know ([[wiki/concepts/precision-weighting.md]]), and it is unmeasured because abstention was engineered away by the back-off rather than reported as an outcome.

---

## The objectivity ceiling — a benchmark that measures its own noise floor

Expert accuracy is a *lower* bound on objectivity, because experts also make mistakes. The paper's instrument: after answering, show the validator the key and the writer's explanation and ask whether the item is uncontroversially correct — then hand-classify all 191 second-validator errors on Extended.

| Category of the validator's own post-hoc feedback | Share of errors |
|---|---|
| Question good — clear mistake identified (25.1%) / demonstrates understanding (7.9%) / no description (12.6%) | **45.6%** |
| Unsure — disclaims expertise (16.8%) / expresses doubt (7.3%) | 24.1% |
| Question bad — answer arguable (7.9%) / assumptions missing (8.4%) / answer wrong (12.0%) | **28.3%** |

Discounting only errors the validator themselves diagnosed gives an **objectivity rate of 73.6%** (76.4% under the permissive reading). Raw post-hoc agreement runs higher (80.1% / 85.4%) and the authors decline to use it, on the grounds that a validator may defer to the writer rather than verify — a caveat the wiki should keep, because it is the human version of the reviewer-pleasing bias in agent panels ([[wiki/concepts/external-verification.md]]).

**So roughly a quarter of Extended has no uncontroversially correct answer.** Diamond is filtered to raise this, but by a criterion (validator accuracy) correlated with objectivity rather than measuring it. The practical consequence for reading any GPQA score: the instrument has an unestimated ceiling below 100%, and the 448-item main set gives >80% power only for effects of roughly **10 accuracy points** (50%→60%), so most published GPQA deltas are within noise of each other.

---

## Why the questions are hard *for a human*, and what a builder should take

The paper never analyses its items cognitively, but the six printed examples share a structure worth naming. Each is a **multi-hop chain over compiled domain facts where every hop is individually looked-up-able and the composition is not**: identify a fluxional isomer mixture → count dienes → count approach directions → multiply (4×4 = 16); or read an NMR shift → infer the reaction class → infer the industrial process → name the periodic-table group of the catalyst. The distractors are, by design and by payment, the answers produced by getting exactly one hop wrong.

*(brainstorm)* That makes GPQA a **composition benchmark wearing a knowledge benchmark's clothes**, and it explains the 40.6-point chemistry gap without invoking secret knowledge: search returns the hops, not the chain, and a non-expert cannot tell which of the retrieved facts is the one that binds. Three consequences for architecture:

1. The failure mode it should elicit is the one [[wiki/entities/gsm8k.md]]'s perturbation derivatives isolate — quantity attachment and irrelevant-clause sensitivity — but in a domain where no template exists to perturb. Nobody has built the GSM-Symbolic analogue of GPQA, and the item explanations shipped with the dataset are exactly the material needed to author one (each explanation states the chain, so each hop is a legal perturbation site).
2. The distractor set is a *labelled catalogue of near-miss reasoning*, one wrong hop each. It is the same asset ConceptARC's error typology had to be built by hand ([[wiki/entities/conceptarc.md]]), shipped here for free and never used: scoring *which* distractor a model picks partitions its errors by the hop it dropped, at no annotation cost.
3. The 4-way multiple-choice format caps how much of this is legible, and the authors state the items were written to survive free-response conversion. The candidate set is the standard shortcut channel ([[wiki/entities/raven.md]], where distractors alone are worth >90%); GPQA's classifier check rules out surface tells but not elimination-by-plausibility, which is precisely the strategy a strong language model has and a non-expert human does not.

---

## Where it sits: difficulty defined relative to *what*

| | **GPQA** | [[wiki/entities/anli.md]] | [[wiki/entities/arc-agi.md]] / [[wiki/entities/arc-agi-2.md]] | [[wiki/entities/conceptarc.md]] |
|---|---|---|---|---|
| Difficulty is relative to | **A skilled human with unrestricted search, timed** | The current model under test | The stated Core Knowledge priors | A concept inventory, humans at ceiling |
| Item difficulty | **Measured per item** (3 non-expert attempts, minutes logged) | Measured per item (tries, seconds, model-wrong) | Asserted per benchmark | Asserted |
| Selection rule | Hard for humans **and** hard for AI | Whatever the model gets wrong | **Easy for humans, hard for AI** | Easy for humans, hard for AI |
| Ground-truth reliability | **Measured: 73.6–76.4%** | Two verifiers per test item | Assumed exact | Assumed exact |
| Saturation | Fixed set; leakage defended by canary only | Impossible by construction | Structural | Fixed set |
| Marginal cost per item | **~$125 writer + ~$85 validation, PhD labour** | ~5 min writer + 2 verifiers | High, one-off | High, one-off |

The **selection-rule row is the disagreement**. ARC Prize's stated principle is that a task both humans and machines find hard "isolates only accumulated knowledge", and excludes crystallized ability on those grounds ([[wiki/concepts/skill-acquisition-efficiency.md]]); GPQA deliberately selects for exactly that quadrant and then measures that the accumulated ability is not retrievable. Recorded as [[wiki/architectural-gaps.md]] G17.

## The scalable-oversight frame, and the one thing it adds to verification

GPQA's stated purpose is not capability evaluation. It is a substrate for **sandwiching**: a non-expert supervisor, an unreliable model, and a ground truth neither can reach alone — the setting where debate, market-making and recursive reward modelling are supposed to beat open-ended web search. The design condition is that the non-expert's *unaided* baseline be low, or the protocol has a trivial solution.

The paper adopts Irving & Askell's nine desiderata for such datasets and claims seven: true answers known; false answers plausible; experts know more than the supervisor; **the definitive argument is longer than the supervisor can afford**; some checkable facts exist; no easy tells; realistic tasks. It concedes two: available data (448 items) and testing known biases.

**Why that list belongs on this wiki.** [[wiki/concepts/external-verification.md]] ranks acceptance tests by how much of the derivation they can see, and closes with the observation that nothing scores partial progress in a non-verifiable domain. Irving & Askell's desiderata are the specification for the rung *below* the ladder's bottom: what a domain must look like for a **verifier weaker than the generator** to extract truth anyway. Criterion 5 (some checkable facts) is the hinge — it says the weak checker's leverage comes from the derivation decomposing into pieces that are individually cheap to check even when the whole is not, which is the PRM argument transposed from a trained scorer onto a human, and it is why GPQA's items are multi-hop chains rather than atomic recall.

*(brainstorm)* This is also the closest thing the wiki has to a specification for an **internal** weak verifier, the open problem that page cannot close. The Goodhart objection is that a learned checker inside the same system is not independent. Irving & Askell's criteria suggest the independence that matters is not architectural but *economic*: the checker must be unable to afford the full derivation while still being able to spot-check pieces of it. A cheap, myopic, high-precision internal critic that samples steps at random is not compromised by sharing weights with the generator in the way a full-trace scorer is — it is compromised only where the generator can predict which step gets sampled.

---

## Limitations

- **Small (448 main / 198 Diamond).** Not usable for training; ~10-point effects needed for 80% power.
- **Human baselines on the released subsets are selection-biased**, flagged by the authors, and are the numbers most often quoted downstream.
- **~26% of Extended is estimated non-objective**, and the filtered subsets' true rate is not measured.
- **Non-experts are unusually strong** (PhDs in other sciences), so 34% is an upper bound on non-expert accuracy and will not transfer to other annotator pools; the authors instruct re-measurement per experiment.
- **Leakage defence is a canary string and a norm**, not a private set — weaker than [[wiki/entities/arc-agi.md]]'s withheld evaluation split, and the failure mode is the distribution-level overfitting recorded in G17 rather than item memorisation.
- **Sourcing bias.** Upwork, no demographic or regional balance, no claim of representativeness over questions arising in scientific practice; the authors note masculine-default pronouns in some items.
- **Multiple choice.** Free-response conversion was designed for and never run.
- **Proxy gap.** The target is supervising *superhuman* systems on questions no human can answer; the paper's own proposed fix is a set of currently-open questions expected to be settled soon, which nobody has built.

---

## Connections

- **[[wiki/concepts/skill-acquisition-efficiency.md]]** — the explicit opposite pole: that page's measure charges priors and excludes crystallized ability on the argument that a task hard for humans and machines alike isolates only accumulated knowledge; GPQA selects that quadrant on purpose and measures that its "accumulated knowledge" survives 37 minutes of unrestricted search by a PhD in a neighbouring science (G17).
- **[[wiki/concepts/external-verification.md]]** — supplies the specification for the rung *below* the ladder: seven desiderata for a domain in which a verifier **weaker** than the generator can still extract truth, with "some checkable facts" as the hinge — the process-reward argument transposed from a trained scorer onto a human supervisor who cannot afford the full derivation.
- **[[wiki/concepts/shortcut-learning.md]]** — contributes a benchmark-hygiene control that needs no knowledge of the intended ability: a timed retrieval baseline (skilled non-specialist + web) bounds the "it was findable" shortcut per item, complementing the surface-feature classifier check that GPQA also passes.
- **[[wiki/entities/anli.md]]** — the same move (difficulty defined relative to a solver, measured per item at authoring time, paid for by bonus) with the solver swapped: ANLI adversarially targets the current model and cannot name what it withholds; GPQA adversarially targets a human with a search engine and can, because the writer ships the reasoning chain.
- **[[wiki/entities/gsm8k.md]]** — the perturbation protocol GPQA lacks and is unusually well-equipped for: every item ships an explanation stating its hop chain, so each hop is a legal Symbolic-style perturbation site, and no such derivative exists.
- **[[wiki/entities/math-dataset.md]]** — the adjacent design decision made the other way: MATH buys auto-gradeable free generation with a `\boxed{}` delimiter and inherits grader false negatives; GPQA buys exact grading with a 4-way candidate set and inherits the elimination-by-plausibility channel that a strong language model has and its human non-expert control does not.
- **[[wiki/entities/conceptarc.md]]** — GPQA ships for free the asset ConceptARC's near-miss error typology had to be hand-annotated: each distractor is a labelled one-hop-wrong trajectory, so which distractor a model picks partitions its errors at zero annotation cost.
- **[[wiki/entities/raven.md]]** — the reason the multiple-choice format is a standing risk here: on RAVEN the candidate set alone is worth >90%, and GPQA's defence (no surface tells) rules out classifier-detectable cues but not plausibility-based elimination.
- **[[wiki/concepts/metacognitive-efficiency.md]]** — reclassifies the abstention result: a rise from 4% to 37% with accuracy flat is a *criterion shift* at matched first-order performance, i.e. metacognitive **bias**, and it is readable as improved self-knowledge only if confidence sensitivity is separately shown to be positive and unchanged in both arms (Schwiedrzik et al. 2011's logic) — which nobody measured, and which this benchmark's 4-way multiple-choice format would actually permit.
- **[[wiki/concepts/precision-weighting.md]]** — the unmeasured result in the baselines: giving GPT-4 a search tool leaves accuracy flat and raises abstention from 4% to 37%, i.e. the evidence may have improved the system's estimate of its own uncertainty while leaving its answers unchanged, and the back-off protocol discarded that signal.
- **[[wiki/concepts/problem-framing.md]]** — where the expertise gap probably lives: the retrieved facts are available to the non-expert, the *selection* of which fact binds is not, which is framing-before-solving measured as a 24–41-point difference between two populations with equal access to the information.
- **[[wiki/concepts/certification-instruments.md]]** — a benchmark whose difficulty is defined against a timed human retrieval baseline, i.e. an instrument whose reference system is itself the controlled variable rather than a fixed denominator.
- **[[wiki/entities/frontiermath.md]]** — the wiki's other self-auditing benchmark, and the reason the two audits are not comparable: both are authored to order by credentialed experts under an explicit anti-shortcut incentive and both measure their own ground truth (73.6–76.4% objectivity here, ~10% error rate there), but GPQA's items can be re-checked by anyone and FrontierMath's are held by one organisation.
- **[[wiki/concepts/human-baseline.md]]** — the only baseline in the wiki run as a *control*: the non-expert arm holds motivation, time and web access fixed and removes only domain training, converting a definitional argument into a 31-point measurement. Its released subsets' human numbers are selection-biased upward by the authors' own asterisk.
- **[[wiki/entities/olymmath.md]]** — the complementary half of the self-audit: GPQA measures its own ground-truth objectivity and its non-expert control but asserts its contamination defence; OlymMATH measures its contamination (`n`-gram `δ` against rewrites) and collects no human baseline at all — and no benchmark in the wiki does both.
- **[[wiki/entities/hle-verified.md]]** — the audit this benchmark never followed through on: GPQA measures its own non-objectivity at 23.6–26.4% and re-scores nothing against it, while HLE-Verified repairs 1,143 items and reports what the defects did to the leaderboard (ordering intact, gaps halved, hard-item sub-leaderboard spurious). Its 689-item *uncertain* set is also the abstention signal GPQA collected and discarded — models flagged as unable to determine an answer are scored as wrong in both, when the item may have no determinate answer.
- **[[wiki/entities/hle.md]]** — the cheap end of the same two requirements: HLE screens non-searchability with a model-difference test (a model *with* search answers correctly, the same model without does not) instead of paid out-of-field PhDs holding a search engine, and gets the same null — removing the searchable items barely moves frontier accuracy, as a search tool barely moves GPT-4 here. Both benchmarks also measure their own reliability and both find a floor (15.4% disagreement vs 23.6–26.4% non-objectivity) larger than the score differences they report.
- **[[wiki/concepts/selective-prediction.md]]** — the 4.0% → 37.2% abstention shift at flat accuracy is a move along the coverage axis with no move on the risk axis, i.e. a measured point where the risk–coverage curve is **flat** and the rejections carried no information; and this benchmark's 4-way closed response set makes it one of the two slices where max-softmax selective risk could actually be scored (`T320`).
