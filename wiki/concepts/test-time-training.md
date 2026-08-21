# Test-Time Training

**Fine-tune the model's own weights on the demonstration pairs of the single instance being solved, producing a different model for every task, then read the answer straight out of that model — adaptation as a weight update at inference rather than as a search over programs.**

> **Provenance.** Chollet, Knoop, Kamradt & Landers 2024, *ARC Prize 2024: Technical Report* (`raw/chollet-2024-arc-prize-report.md`), which surveys the technique across the 2024 competition; the primary implementations (Akyürek et al., MindsAI, Barbadillo, Bonnet & MacFarlane) are **secondary here** — reported, not read at source. The ARChitects are the exception: read at source in Franzen, Disselhoff & Hartmann 2025 ([[wiki/entities/poe-arc-solver.md]], `raw/franzen-2025-product-of-experts-arc.md`). Also called test-time fine-tuning (TTFT). First observed on ARC by Jack Cole and Mohamed Osman in 2023.

The wiki's fast-level ([[wiki/concepts/complementary-learning-systems.md]]) written into *weights at deployment*, with no outer loop that trained for it — which is what distinguishes it from [[wiki/concepts/meta-learning.md]] and is the reason it is worth a page.

---

## The measurement that makes it load-bearing

| Regime on ARC-AGI-1 | Best score |
|---|---|
| Static inference transduction (frozen model, prompt only, any size) | **≤ 11%** |
| Transduction with test-time training | 47.5% (semi-private) · 53.5% (private, competition winner) |
| Direct prompting of 2024 frontier models (pass@1) | 4.5–18% |

**No static-inference transduction solution has ever scored above 11%** ([[wiki/entities/arc-agi.md]]). Everything at the top of the transduction column trains at test time. This is the cleanest number in the wiki for the claim that the frozen-weights paradigm — train once, then infer — cannot reach a task it was not trained on, and that the deficit is not fixed by scale (the benchmark survived a ~50,000× pretraining scale-up).

---

## Where it sits: the memorization/recombination spectrum

The report's own framing, and the most useful idea in it. Both program search and TTT recombine pre-existing building blocks; they differ in *how many* blocks and *how deep* the recombination.

| | Building blocks | Count | Recombination depth | Mechanism |
|---|---|---|---|---|
| **Discrete program search** | Generic programming primitives / DSL entries | Small (tens) | Deep — long compositions | Enumeration or LLM-guided search |
| **Test-time training** | Vector functions latent in pretrained weights | Vast (a whole pretraining corpus) | Shallow — one gradient trajectory | Gradient descent on ~3 labelled pairs |
| **Latent program search** (Bonnet & MacFarlane) | Points in the model's latent space | Continuous | — | Random search + gradient descent over a *program representation*, neither fine-tuning nor discrete search |

**(brainstorm) What this says for the wiki's vocabulary problem.** G4 asks where the edge vocabulary comes from. TTT's answer is: it is already there, unlabelled and untyped, distributed across pretrained weights, and the demonstration pairs act as a *selector* on it rather than as evidence for a search. That is a genuinely different reading of [[wiki/concepts/program-induction.md]]'s cost 1 — the library is neither authored nor induced but *dredged*, and the price is that nothing about it is inspectable, composable or transferable to the next task, because the adapted model is thrown away.

---

## Induction and transduction solve different tasks

The single most reusable empirical fact in the report, and it is an ensemble result, not a ranking:

- **Induction** — infer a program from the demonstration pairs, then execute it on the test input.
- **Transduction** — condition on the demonstration pairs *and* the test input, emit the output grid directly.
- Best induction-only ≈ **40%**. Best transduction-only ≈ **40%**. The sets of tasks they solve are *significantly distinct*, and every 2024 top score (ARChitects, Barbadillo, Akyürek, Berman) is an ensemble of both.

This has been visible since transduction first scored above zero in late 2023 and was investigated by Li et al., *Combining Induction and Transduction for Abstract Reasoning* (ARC Prize 2024 first-place paper, not ingested).

**Reading.** A benchmark whose tasks split cleanly by *solution modality* is evidence that the task set is not one competence — which is gap G12 (no routing policy between structure types) appearing as a leaderboard artefact. Nobody has a router; the state of the art runs both and takes the union, which costs the sum and buys the disjunction.

---

## What TTT actually requires

Four ingredients, all of them authored, which is where the honesty of the technique lives.

| Ingredient | Instantiation | What it smuggles in |
|---|---|---|
| **More ARC-like data to pretrain on** | Re-ARC (Hodel — a programmatic reimplementation of the 400 training tasks, so instances can be sampled without limit); ARC-Heavy / ARC-Potpourri (Ellis et al. — 400,000 additional ARC-like tasks) | The experience cap that [[wiki/concepts/skill-acquisition-efficiency.md]] says a benchmark must impose is restored on the *task* and defeated on the *instance* |
| **Augmentations of the test instance** | Rotations, reflections, colour permutations, transposes applied to the demonstration pairs before fine-tuning | The invariance group — i.e. the geometry/objectness priors, supplied as a data operation rather than as a DSL |
| **Fine-tuning strategy** | LoRA or full fine-tuning on the augmented demonstration pairs of *this* task | — |
| **2D-aware architecture** | 2D attention or 2D positional encodings (Puget/NVIDIA, "A 2D nGPT Model for ARC Prize") | The grid's topology, as an architectural prior |

**(brainstorm) TTT does not remove the authored prior; it relocates it from the DSL to the augmentation group.** A DSL says *these are the operations*. An augmentation set says *these transformations must not change the answer* — the same core-knowledge content ([[wiki/concepts/core-knowledge.md]]) stated as an invariance instead of as a generator. That is a strictly weaker commitment (an invariance constrains without enumerating) and it is why the technique scales to tasks a DSL author never anticipated, but it is not prior-free, and any efficiency claim that ignores the augmentation set is measuring the wrong system ([[wiki/concepts/skill-acquisition-efficiency.md]]'s channel-1 objection).

---

## The augmentation group as a rejector

The ARChitects' contribution is not the fine-tuning but the **selection criterion: prefer the candidate solution that is stable under the augmentations**. Solve the task in several augmented frames, keep what agrees.

This is the wiki's cheapest instance of G68 (everything is a proposer; nothing is a rejector) on this benchmark, and its acceptance test is *not* the generator: the invariance group is supplied from outside, so a model that is confidently wrong in one frame is caught by a frame it did not expect. It is the same move [[wiki/entities/corethink-compositional-reasoner.md]] measures as consensus across demonstrations and [[wiki/entities/arc-vsa-solver.md]] measures as cross-demonstration reuse — three different populations to agree over (augmented frames, demonstrations, samples), one mechanism.

**Read at source, the criterion is sharper than "keep what agrees"** ([[wiki/entities/poe-arc-solver.md]], Franzen et al. 2025). It is a *product* of the candidate's likelihoods under all 16 augmentations — log-linear pooling, `P̄(s) = (1/Z)∏_j [P̂(φ_j(s)|φ_j(p))]^{1/m}` — and the aggregator is not a free choice: on the same candidate set, `max` scores 63.5%, the mean 66.6%, `min` 68.8%, the product **71.6%**. The two rules that let one dissenting view *veto* are the two that win, and believing the most confident view is the worst rule available. The accompanying theorem, `KL(P‖P̄) = (1/m)Σ_j KL(P‖P̂_j) + log Z` with `log Z ≤ 0`, says the ensemble beats a randomly chosen single view *by exactly the amount the views disagree* — so cross-view inconsistency, which is a defect of the learned `P̂`, is the resource the selector runs on. Its stated cause is the autoregressive factorization: the decoder commits to the first cell before computing what determines it, and re-reading the answer in a permuted frame changes which commitment is being tested.

The ablation ladder on ARC-AGI-1 public eval (NeMo-Minitron-8B) also prices the fine-tuning against the machinery around it: baseline 18.3% → **+TTT 44.5%** → +16 augmented frames 62.5% → +product-of-experts selection 67.6% → +threshold DFS search **71.6%**. Test-time training is the single largest component (+26.2) and is still under 40% of the final score; the rest is inference-time machinery over a frozen prior.

---

## Instantiations (ARC Prize 2024, as reported)

| System | Base model | What is distinctive | Score |
|---|---|---|---|
| **the ARChitects** ([[wiki/entities/poe-arc-solver.md]]) | NeMo-Minitron-8B, 64-token vocabulary | Novel augmentations + product-of-experts selection over them + threshold DFS candidate generation | 53.5% private (1st place); **71.6% public eval** post-competition at $0.02/task |
| **MindsAI** | Salesforce T5 series, pretrained on public eval + synthetic | Pioneered TTT on ARC (2023); not open-sourced, hence ineligible | 55.5% private (highest of 2024) |
| **Akyürek et al.** | 8B parameters | The technique's reference paper | 47.5% semi-private · 53% public eval |
| **OmniARC** (Barbadillo) | Qwen2.5-0.5B-Instruct | Pretrained on *multiple* program-induction tasks, then TTT; ensembled with program synthesis | 40% private (2nd place) |
| **Bonnet & MacFarlane** | — | Search the *latent* space rather than the weights | Paper award, 3rd |

**2025 update, on the harder benchmark** ([[wiki/entities/arc-agi-2.md]], Chollet et al. 2026). TTT is still what wins the open competition: NVARC took ARC Prize 2025 at **24.03%** on the ARC-AGI-2 private set at **$0.20/task**, building on the 2024 ARChitects stack with heavy synthetic data generation; MindsAI's TTT pipeline (test-time fine-tuning + augmentation ensembles + tokenizer dropout) took 3rd at 12.64%. Two facts worth separating out of that:

- **The technique transfers across benchmark generations; its tuning does not.** The unmodified 2024 ARChitects system scored 56% on ARC-AGI-1 and **2.5%** on ARC-AGI-2. Their 2025 rebuild — a 2D-aware *masked-diffusion* language model with recursive self-refinement and perspective-based scoring — reached 16.53%.
- **The technique is now one member of a family rather than the family** ([[wiki/concepts/refinement-loop.md]]): the same propose-and-check-per-task loop runs in symbolic program space, natural-language program space and chain-of-thought, and the zero-pretraining variants (TRM 7M parameters, CompressARC 76K) run it in weight space *from a random initialisation*, which makes "what is the pretrained library for?" an open question about this page's central framing rather than a settled one.

The 0.5B result matters: OmniARC reaches 40% with a model three orders of magnitude smaller than a frontier system, under a 12-hour single-P100 budget with no internet. Whatever TTT buys is not bought with capacity.

---

## Open problems

- **No stopping criterion.** Fine-tuning on ~3 pairs has no held-out set. How many steps, at what learning rate, before the model has memorised the demonstrations rather than the rule, is decided by hand on the public split — which is a developer-side prior on a benchmark designed to exclude them.
- **The adapted model is discarded.** Nothing accumulates: task `n+1` starts from the same base weights. This is gap G14 (no consolidation channel: instance structure never becomes meta structure) in its purest form — TTT builds an instance-level model every time and never writes anything back, so a system solving 100 ARC tasks has learned nothing from the first 99.
- **Why does it work at all, given catastrophic forgetting?** Gradient descent on three examples of a novel task in an 8B model is exactly the regime [[wiki/concepts/continual-learning.md]] says destroys prior knowledge, and here the prior knowledge is the entire point. Nothing in the report explains what protects it; LoRA's low rank is a plausible but untested mechanism.
- **Not productionizable yet.** The report's own forecast: TTT is harder to put into a serving stack than program synthesis, so it lags by "a couple of years" — a deployment fact that shapes which technique gets research attention, and therefore a selection pressure on the field rather than on the models.
- **Is the inner loop the *right* inner loop?** TTT does gradient descent because that is what is available, not because anything meta-trained it to adapt. [[wiki/entities/mlc.md]] is the controlled comparison: an outer loop over an episode distribution buys the same competence with no weight update at test time at all. Nobody has run both on the same task family.

---

## Connections

- **[[wiki/entities/arc-agi.md]]** — the benchmark that produced both the technique and its sharpest measurement (≤11% without it), and where the ≤11% figure is the wiki's evidence that frozen inference fails on developer-novel tasks.
- **[[wiki/concepts/meta-learning.md]]** — the same inner-loop/outer-loop anatomy with the outer loop deleted: TTT runs an inner adaptation with no meta-training that shaped it, so it is what meta-learning looks like when the task distribution is unavailable.
- **[[wiki/concepts/complementary-learning-systems.md]]** — the fast/slow split with the fast level implemented as gradients into the slow level's own weights, which is the arrangement CLS exists to warn against — and the reason the "why no forgetting" question above is open.
- **[[wiki/concepts/program-induction.md]]** — the opposite end of the memorization/recombination spectrum: deep recombination of few generic primitives vs. shallow recombination of a vast latent library, with the measured fact that the two solve *different* tasks and only their ensemble is state of the art.
- **[[wiki/concepts/synaptic-plasticity.md]]** — the only other family in the wiki that writes weights during deployment; TTT is that commitment made with backpropagation and a labelled loss instead of a local rule.
- **[[wiki/concepts/skill-acquisition-efficiency.md]]** — where the technique is priced: the demonstration pairs are the `E` term spent as gradient steps, while the augmentation group and the 400,000-task synthetic corpus are `P`, so a TTT score is only interpretable alongside both.
- **[[wiki/concepts/core-knowledge.md]]** — the priors enter as an invariance group (rotations, reflections, colour permutations) rather than as an enumerated operation set, which is a weaker and more scalable way to install the same content.
- **[[wiki/concepts/external-verification.md]]** — stability-under-augmentation is an acceptance test whose criterion is external to the generator (the invariance group is supplied, not learned), sitting a rung above majority vote because the samples are *forced* to differ.
- **[[wiki/concepts/amortized-inference.md]]** — the reverse trade: amortisation compiles a search into a fast forward pass, TTT spends a training run to buy one forward pass' worth of answer, and the two set the same free parameter from opposite ends.
- **[[wiki/entities/mlc.md]]** — the controlled alternative: meta-training over an episode distribution produces test-time adaptation *in activations*, with no gradient at test time, and reaches 100% on a comparable infer-the-latent-rule task — which makes "is the weight update necessary?" an answerable question.
- **[[wiki/entities/transformer.md]]** — the substrate all reported instantiations run on, with the ARC-specific modification being 2D attention and 2D positional encodings rather than anything about the training loop.
- **[[wiki/entities/arc-agi-2.md]]** — the re-authored benchmark where this technique still tops the open leaderboard (NVARC 24.03%, built on the 2024 ARChitects stack plus synthetic data), while the *unmodified* 2024 system scores 2.5% — so the technique transfers across benchmark generations and its tuning does not.
- **[[wiki/concepts/refinement-loop.md]]** — the generalisation of this page: TTT is the weight-space instance of a per-task propose-and-check loop that also runs in symbolic program space, natural-language program space and chain-of-thought, with the substrate turning out to be the least important variable.
- **[[wiki/entities/poe-arc-solver.md]]** — the primary source for this page's top-scoring instantiation: the same TTT recipe with the selection step specified exactly (product of augmented likelihoods, with a proof), reaching 71.6% on ARC-AGI-1 public eval at $0.02/task, and 53% on Sudoku *without* TTT — which shows the weight update buys nothing when the rule is shared across instances rather than latent in each one.
