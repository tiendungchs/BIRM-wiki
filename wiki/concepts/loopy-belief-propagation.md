# Loopy Belief Propagation Over Chained Bottlenecks — Integration as a Decoding Problem

**Wire the low-dimensional latents of several modality-specific autoencoders directly to each other. The resulting graph has cycles, so exact inference is unavailable — but iterating local message passing on it anyway converges, in practice, to a good approximation of the joint posterior over one shared latent world state. That is precisely the structure of a **turbo-code**: two or more decoders exchanging extrinsic beliefs over a loopy graph, reaching within a fraction of a decibel of the Shannon limit on a noisy channel. The proposal is that multi-modal integration in cortex *is* this decoding operation, that each modality is a noisy encoding of one underlying world state rather than a separate thing to be fused, and that synchrony is the scheduler that decides when a round of message passing is allowed to converge.**

> **Provenance.** Safron 2022, Front. Comput. Neurosci. 16:642397 (`raw/safron-2022-integrated-world-modeling-theory.md`), framework context at [[wiki/entities/integrated-world-modeling-theory.md]]. **Theory only — no implementation, no simulation, no data.** The underlying identity (turbo decoding is loopy belief propagation) is McEliece, MacKay & Cheng 1998 and is not in dispute; the cortical mapping is the paper's hypothesis.

---

## The algorithm

Belief propagation on a factor graph, run regardless of cycles:

```
m_{i→j}^{(t+1)}(x_j) ∝ Σ_{x_i} ψ_ij(x_i, x_j) φ_i(x_i) Π_{k ∈ N(i)\{j}} m_{k→i}^{(t)}(x_i)
b_i(x_i)             ∝ φ_i(x_i) Π_{k ∈ N(i)} m_{k→i}(x_i)
```

| Property | On a tree | On a loopy graph |
|---|---|---|
| Fixed point | Exact marginals, one sweep | Stationary point of the **Bethe free energy**; approximate marginals |
| Convergence | Guaranteed | Not guaranteed — can oscillate or diverge; damping and scheduling matter |
| Empirical behaviour | — | Excellent where the loops are long and the graph is sparse. This is why turbo and low-density parity-check codes work |
| What the exclusion of `m_{j→i}` buys | Correctness | **Extrinsic information only** — each decoder passes what it learned *independently* of what it was told, which is what keeps a loopy exchange from amplifying its own belief |

**The extrinsic-information rule is the transferable engineering content.** A module must not send back the part of its belief that came from the module it is answering. Without that exclusion the loop is a positive-feedback amplifier on its own prior. Every "modules exchange embeddings and iterate" design in machine learning passes the *full* activation, and therefore has no analogue of this safeguard.

---

## The claimed cortical realisation

| Coding object | Claimed substrate | Notes |
|---|---|---|
| Constituent decoders | Folded variational-autoencoder hierarchies — one per modality / cortical stream | Encoder in superficial pyramidal cells, generative decoder in deep pyramidal cells; see [[wiki/concepts/predictive-coding-free-energy.md]] |
| The interleaver / coupling | High-bandwidth reciprocal connectivity between association cortices, chaining the **bottlenecks** rather than the full representations | The cycles live in the rich club ([[wiki/concepts/connectome-hubs-and-cores.md]]) |
| A message | A quantised packet of **sufficient statistics** carried at gamma; slower bands carry the descending estimates | [[wiki/concepts/inter-areal-synchrony.md]] |
| A completed round | A transient synchronous complex — the paper's "self-organizing harmonic mode" — whose formation both requires and produces convergence | Identified with [[wiki/concepts/ignition.md]] |
| The output | The approximate joint posterior, and the MAP estimate taken from it | This is what gets broadcast; commitment is `argmax` of a converged loopy posterior |

**The restriction the paper imposes on itself:** any synchronous complex can be read as a turbo-code at some level of abstraction, but only complexes spanning **multiple modalities** are claimed to do the work. A single-stream loop refines one estimate; a cross-modal loop buys *inferential synergy* — a joint estimate strictly better than what either stream reaches alone, which is the whole reason the coupling is worth its wiring cost.

---

## Why a builder should care

| Consequence | Detail |
|---|---|
| **Fusion without a fusion module** | No concatenation, no cross-attention block, no jointly trained head. Modalities couple by sharing latent variables and exchanging extrinsic messages, so a modality can be added or removed without retraining the others — the property every late-fusion architecture in the wiki lacks |
| **The bandwidth cost is a latency purchase** | The rich club consumes up to ~50% of cortical metabolism. The justification offered is *rounds to convergence*: dense reciprocal wiring reduces the number of noisy transactions needed before an estimate is reliable enough to act on. Rounds-against-wiring-cost is measurable in any message-passing network and nobody reports it |
| **A commit criterion that is not a threshold** | "Commit when the loop converges" replaces a confidence threshold or a fixed step budget. It is content-dependent by construction: ambiguous input takes more rounds. See [[wiki/concepts/evidence-accumulation.md]], whose missing stopping rule this addresses from a third direction |
| **Iteration count is the compute dial** | The same graph run for more rounds gives a better posterior — inference-time compute that changes the *estimate* rather than the depth of the network ([[wiki/concepts/test-time-training.md]], [[wiki/concepts/refinement-loop.md]]) |
| **Failure to converge is informative** | The paper's circularity claim: only coherent, well-evidenced models let loopy message passing converge efficiently. Non-convergence is then a signal that the current model does not fit — a free novelty detector, and the same quantity a system would want in order to decide to *learn* rather than to act |

**(brainstorm) The nearest thing in machine learning is not multimodal fusion but decoding, and that is a usable reframe.** A joint-embedding model asks *what representation makes these two views agree?* A turbo-decoder asks *what single latent word, sent through two different noisy channels, produced both of these observations?* The second has an explicit noise model per channel and therefore knows which modality to trust where — modality-specific precision falls out of the channel statistics instead of being a learned attention weight ([[wiki/concepts/precision-weighting.md]]). It also predicts the failure mode: with a bad channel model, the loop confidently converges to the wrong word, which is what confabulation looks like from inside.

**(brainstorm) The unimplemented experiment is small.** Take two frozen unimodal encoders, tie a low-dimensional slice of each latent to the other through a learned pairwise factor, and run damped belief propagation for `T` rounds at inference. Report accuracy against `T`, and rounds-to-convergence against input ambiguity. If the framework has content, both curves are non-trivial; if they are flat, the loop is decoration. Nothing in the source or in this wiki has run it.

---

## Open problems

| Problem | State |
|---|---|
| **No convergence guarantee, and no biological account of what enforces one** | Synchrony is nominated as the scheduler, and the circularity ("convergence produces the synchrony that produces convergence") is stated as a feature. It is also the standard description of an unregularised positive-feedback loop, and nothing here separates the two cases |
| **What are the factors `ψ_ij`?** | The paper says plasticity performs an implicit architecture search that yields the graph. It does not say what the pairwise potentials are, how they are learned, or against what objective |
| **The message is claimed to be a sufficient statistic — of what family?** | Gaussian messages make this cheap and are the obvious first implementation; the source is silent, and the choice determines everything about cost |
| **No account of how many rounds are affordable** | Cortex gets on the order of 100–300 ms per commit. At realistic conduction delays that is a small number of rounds — which is a hard constraint on the hypothesis and is never costed |
| **Extrinsic-information discipline has no neural correspondent** | Nothing in the proposal says which anatomical arrangement stops a region from returning its own prior, and without it the scheme's own convergence argument fails |

---

## Connections

- **[[wiki/entities/integrated-world-modeling-theory.md]]** — the framework this primitive was extracted from, which adds the condition that a converged posterior only counts as a world model if it is coherent in space, time and cause for an embodied controller.
- **[[wiki/concepts/ignition.md]]** — the same event under two descriptions: ignition is the dateable commit, convergence of the loop is the computation that justifies committing, so this page supplies the answer to *why now* that the threshold account leaves as a free parameter.
- **[[wiki/entities/global-neuronal-workspace.md]]** — supplies the content the broadcast carries: the workspace's occupant becomes the MAP estimate of an approximate joint posterior rather than an unspecified "representation", and the exclusivity of ignition becomes the argmax step.
- **[[wiki/concepts/predictive-coding-free-energy.md]]** — the constituent decoders: each stream in the loop is a folded encoder/decoder hierarchy minimising the same residual, so this page is what happens *between* hierarchies where that page describes what happens within one.
- **[[wiki/concepts/cross-modal-grounding.md]]** — the alternative to contrastive fusion: modalities as noisy channels carrying one latent word rather than as views to be aligned, which gives per-channel noise models where a contrastive objective gives a single shared rate bound.
- **[[wiki/concepts/inter-areal-synchrony.md]]** — the physical carrier and the scheduler: gamma packets as messages, slower bands as descending estimates, and phase alignment as the mechanism that decides which regions are participating in the current round.
- **[[wiki/concepts/connectome-hubs-and-cores.md]]** — why the loops live where they do: the rich club is the only place with enough reciprocal bandwidth to run many rounds cheaply, and this page recasts its metabolic cost as a purchase of convergence speed.
- **[[wiki/concepts/precision-weighting.md]]** — falls out rather than being learned: a channel's noise model determines how much its message moves the joint estimate, which is modality-specific precision derived from the coding scheme.
- **[[wiki/concepts/evidence-accumulation.md]]** — a third answer to the missing stopping rule: stop when the messages stop changing, which makes the number of steps a function of input ambiguity instead of a tuned threshold.
- **[[wiki/concepts/amortized-inference.md]]** — the trade-off partner: this page is iterative inference at query time, amortisation is the trained shortcut past it, and the two compose as a natural fast/slow pair where the amortised guess initialises the loop.
- **[[wiki/concepts/test-time-training.md]]** — the same compute-at-inference lever with a different target: rounds of message passing improve the *estimate* on a fixed graph where test-time training improves the *parameters*, and the source's unfolding argument says the recurrence is what makes either robust to intervention.
- **[[wiki/concepts/attractor-dynamics.md]]** — the alternative reading of the same convergence: a settled loopy posterior and a reached attractor are the same trajectory described in belief space versus state space, and the difference is whether the fixed point is interpreted as a marginal.
- **[[wiki/concepts/vector-symbolic-binding.md]]** — the rival account of what a shared latent space is for: binding by algebraic superposition and unbinding by inverse operation, against binding by iterated probabilistic agreement, with the second paying rounds where the first pays dimensionality.
