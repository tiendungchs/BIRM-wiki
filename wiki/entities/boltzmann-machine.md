# Boltzmann Machine

**A Hopfield network with two modifications — units update *stochastically* by sampling `P(s_i = +1) = σ(2 Σ_j w_ij s_j / T)`, and some units are *hidden* — which converts a store that recalls what it was shown into a generative model of the distribution that produced it. Training is contrastive: `Δw_ij ∝ ⟨s_i s_j⟩_data − ⟨s_i s_j⟩_free`, the second term measured while the network runs with nothing clamped.** Hinton & Sejnowski 1983; Ackley, Hinton & Sejnowski 1985.

> **Provenance.** `raw/talk-nd-boltzmann-machines.txt` — an explainer talk (no author, no date), the sequel to the Hopfield exposition behind [[wiki/entities/hopfield-network.md]]. **No experiments, no numbers, no capacity theorem**; everything here is textbook derivation. It is ingested for one reason: it is the wiki's only complete account of how an energy landscape becomes a *sampler*, which is the step [[wiki/concepts/energy-based-models.md]] names as the whole problem (pushing energy up off the data) without saying what a network actually does about it. Claims sourced only here are marked `(tentative)`.

---

## The two modifications, and what each buys

| # | Modification | Statement | What it adds that Hopfield cannot do |
|---|---|---|---|
| 1 | **Stochastic update** | Instead of `s_i ← sgn(y_i)`, sample `s_i = +1` with probability `σ(2y_i/T)`, `y_i = Σ_j w_ij s_j` | The state no longer stops at the nearest minimum: it *visits* states with frequency `∝ exp(−E/T)`. Escapes local minima; makes the network a generator rather than a recogniser |
| 2 | **Hidden units** | Some units correspond to no component of the data; visible count = data dimension (a 32×32 image ⟹ 1024 visible), hidden count is a free design choice. **Update rule is identical for both types** | Higher-order correlations become representable. The stored object stops being the data and becomes a *latent feature code* for it |

Everything else — symmetric weights, zero diagonal, energy `E = −½ Σ w_ij s_i s_j`, locality — is unchanged. The architectural distance from the wiki's baseline is two lines of code, and the distance in what is learned is memorisation → distribution.

---

## Why the sigmoid is derived, not chosen — and why `Z` never appears in the update

The Boltzmann distribution `p(S) = exp(−E(S)/T) / Z`, `Z = Σ_S exp(−E(S)/T)`, is the only form consistent with (i) transition probability multiplying over equal energy steps and (ii) normalisation. Applied to a single unit:

| Step | Statement |
|---|---|
| Two candidate states | `s_i = +1` vs `s_i = −1`, rest of the network fixed. `E = −s_i y_i + E_rest` |
| Ratio | `P(+1)/P(−1) = exp(−ΔE/T)`, and `E_rest` **cancels** |
| Energy gap | `ΔE = E(−1) − E(+1) = 2 y_i` |
| Result | `P(s_i = +1) = 1/(1 + exp(−2y_i/T)) = σ(2y_i/T)` |

**This is the load-bearing fact for a builder.** The partition function `Z` sums over `2^N` states and is intractable for any interesting network — but a *ratio* of two states differing in one unit is a local quantity, so a globally normalised distribution is sampled by updates that see only a unit's own input field. Global statistics, local mechanism: Gibbs sampling is what makes an energy landscape usable without ever evaluating it. The same cancellation is why the wiki's other energy models can afford to be unnormalised ([[wiki/concepts/energy-based-models.md]]) — nothing that *runs* the model needs `Z`; only something that *scores* it does.

**Temperature is the third knob.** `T → 0` recovers the deterministic Hopfield update exactly (`σ` → step function); large `T` makes the state a random walk indifferent to the weights. It is a hyperparameter set by how creative the output should be `(tentative)` — the wiki's clearest instance of a single scalar interpolating between retrieval and generation.

---

## Learning: the negative phase is the whole difficulty

Maximise `Σ_p log P(x^p)`. Substituting the Boltzmann form gives

```
log P(x) = −E(x)/T − log Z
```

so maximum likelihood is **two opposing forces**: deepen the well under each training pattern, and *raise* the energy surface everywhere else (minimise `Z`, which sums over all states). Without the second, the model could lower every state's energy at once and change no probability. Differentiating gives the **contrastive Hebbian rule**:

| Term | Expression | Measured how | Reads as |
|---|---|---|---|
| **Positive (Hebbian)** | `+⟨s_i s_j⟩_data` | Clamp the visible units to a training pattern, let hidden units settle by the stochastic rule, average `s_i s_j` | Strengthen what co-occurs in reality |
| **Negative (anti-Hebbian)** | `−⟨s_i s_j⟩_free` | Start from a random state, run *all* units freely to equilibrium, sample, repeat, average | Weaken what the model hallucinates on its own |

`Δw_ij = η(⟨s_i s_j⟩_data − ⟨s_i s_j⟩_free)`. When the two averages agree the model's distribution matches the data's and learning stops — the fixed point is a *moment-matching* condition, and no error signal, no target and no backward pass appears anywhere. The rule is fully local: each synapse needs only the two units it connects, in two operating conditions.

**Hidden units are learned with no target ever specified.** In the positive phase they are free (only the visible units are clamped); in the negative phase everything is free; the same rule updates the weights that touch them. What the hidden layer should represent is never stated, and the features it develops are whatever lowers `Z`-corrected data energy. This is the first point in the wiki's attractor lineage where a store *invents* the code it stores in, rather than being handed patterns by another system ([[wiki/concepts/latent-graph-discovery.md]] G1).

---

## What it costs relative to the baseline

| Property | [[wiki/entities/hopfield-network.md]] | Boltzmann machine |
|---|---|---|
| Write | **One shot**, closed form `w_ij = (1/n)Σ ξ_i^p ξ_j^p` | **Iterative**, two phases, many passes over the data — no closed form exists because `Z` couples every weight to every state |
| Inference | Descent, guaranteed to halt at a fixed point | Sampling, never halts; correctness requires reaching *equilibrium*, and nothing certifies that it has |
| What is stored | The training patterns | The distribution they were drawn from — including states never shown |
| Cue behaviour | Completion to the nearest stored pattern | Completion to a *sample* from the conditional, so the same cue can give different answers |
| Cost driver | `N²` synapses | The negative phase: an expectation over the model's whole state space, re-estimated after every weight change |

**The first row is a fork the wiki now has to own** ([[wiki/empirical-tensions.md]] T62): one-shot instance storage and distribution learning are not two settings of one rule, and no source here has tried both writes on one weight matrix.

**The negative phase is exactly the cost [[wiki/concepts/energy-based-models.md]] predicts.** That page classifies contrastive-divergence/MCMC training as sample-contrastive and states the price — energy is raised only where a contrastive sample was placed, so the number needed can grow exponentially in `dim(y)`. Here that abstraction has a mechanism attached: the free-running phase *is* the sample placement, and its cost is the reason the whole family was displaced by backpropagation.

---

## Restricted Boltzmann machine (RBM)

| Change | Consequence |
|---|---|
| Forbid visible–visible and hidden–hidden connections; keep only the bipartite visible↔hidden weights | Given all hidden states, the visible units are **conditionally independent** of each other, and vice versa |
| ⟹ | Whole layers update **in parallel** in one step (block Gibbs), instead of one unit at a time because each unit's field depends on every other |
| Claimed trade | "Retains much of the expressive power" at dramatically lower cost `(tentative)` — the change that made the family practical |

The bipartite form is the same structural move as [[wiki/entities/dense-sequence-memory.md]]'s two-body rewriting of a dense associative memory: replacing all-to-all coupling among *content* units with a hidden layer that mediates it, which buys parallelism and individually addressable hidden units at the price of no direct visible–visible constraint.

---

## Why this page matters to the wiki's framing

**(brainstorm) Noise is the fourth way to buy back the motion symmetry forbids.** [[wiki/entities/hopfield-network.md]] notes that `W = Wᵀ` guarantees convergence and thereby forbids going anywhere, and the wiki holds three fixes: an asymmetric term ([[wiki/entities/dense-sequence-memory.md]]), a slow adaptation current ([[wiki/entities/adaptive-cann.md]]), short-term depression ([[wiki/entities/stp-flickering-cann.md]]). This is the fourth, and the only one that leaves the energy function untouched: the landscape is exactly the Hopfield landscape, and temperature alone decides whether the state rests in a basin or tours them. It is also the cheapest available answer to that page's "no mechanism systematically cycles through alternative interpretations" (Necker-cube) gap — alternation is what a sampler does by default.

**(brainstorm) The negative phase says what offline replay is *for*, in one term.** [[wiki/concepts/offline-replay.md]] holds that hippocampal replay appears to sample from a generative model rather than rehearse recorded episodes, and that its deepest proposed job is organising sequences into structure — but the *computational* reason to sample from your own model, rather than from stored data, is unstated there. Here it is a gradient term: `⟨s_i s_j⟩_free` cannot be obtained from data, only from free-running the network, so an offline free-running phase is **required by maximum likelihood**, not merely useful. This is the Crick–Mitchison "unlearning" reading of sleep given an objective, and it predicts the sign: what the network produces spontaneously and the data does not should be *weakened*. It also matches that page's "dream argument" — unguided noise-driven firing builds bizarre states — with the missing half: the bizarre states are the training signal, consumed with a minus sign.

**(brainstorm) Two phases is the biological weak point, and it is the wiki's known one.** [[wiki/concepts/biologically-plausible-credit-assignment.md]] lists contrastive Hebbian learning as a local rule of unknown bias/variance, and [[wiki/entities/fcann.md]] states the sharper complaint directly: the free-energy learning rule `ΔJ_ij ∝ σ_iσ_j − L(b_i + Σ_k J_ik σ_k)σ_j` is claimed to be the only known local, incremental, **single-phase** rule approximating an orthogonal-storage network, whereas the dreaming/unlearning nets need two. Read side by side, the two rules differ only in what supplies the subtracted term — a second global phase requiring a wake/sleep switch, versus the network's own instantaneous prediction of its correlations. That comparison is the concrete form of the question of whether a brain needs sleep for this reason or merely for a cheaper one.

**Maximum likelihood here is forward KL, so the mode-covering optimum applies.** ([[wiki/concepts/divergence-objectives.md]]) The objective is `argmax Σ log P(x^p)` under the data — mode-covering by construction, so a Boltzmann machine trained on a one-to-many transition assigns mass *between* the branches in its distribution. What rescues it operationally is that the model is used by *sampling*, not by taking its mean: the blur is in `p`, and a sample from `p` is still a definite state. That is a general point the wiki should carry — a mode-covering objective is only fatal for architectures whose output is the distribution's summary statistic.

---

## Open problems

- **Equilibrium is assumed, never certified.** Both phases require averages "at equilibrium"; nothing here bounds the mixing time, and for a rugged landscape (the same ruggedness that stores memories) it can be exponential. The whole learning rule rests on an unmeasured quantity.
- **The negative phase cost scales with the state space, not the data.** Sample-contrastive, therefore exponential in the worst case ([[wiki/concepts/energy-based-models.md]]); the non-contrastive alternative (regularise the low-energy *volume*) is not available in this formulation.
- **No capacity theory.** The talk gives none, and the classical `≈0.14N` does not transfer — with hidden units the object stored is not a pattern count.
- **Nothing chooses the number of hidden units or the temperature.** Both are free hyperparameters, and both change what the model is, not merely how well it fits.
- **Superseded in practice.** Displaced by multi-layer networks trained by backpropagation; the surviving exports are the two principles — model uncertainty explicitly, learn abstract features with no target for them `(tentative)`.

---

## Connections

- **[[wiki/entities/hopfield-network.md]]** — the object this modifies, and by exactly two changes: replace `sgn` with a sampled sigmoid and add unclamped units. The energy function, the symmetry, the locality and the `w_ii = 0` constraint are all inherited unchanged, so every capacity and spurious-minimum property of that page is the starting condition here.
- **[[wiki/concepts/energy-based-models.md]]** — supplies the mechanism behind that page's central claim that pushing data energy down is trivial and pushing everything else up is the whole problem: `−log Z` is the "everything else", and the free-running negative phase is how a network estimates its gradient. The page's contrastive-vs-regularised table lists MCMC/contrastive divergence; this is that row written out.
- **[[wiki/concepts/divergence-objectives.md]]** — the objective is maximum likelihood, i.e. forward KL, so the mode-covering optimum described there applies to the fitted landscape; the qualification this page adds is that a sampled read-out never emits the covered average.
- **[[wiki/concepts/offline-replay.md]]** — gives replay a term in an objective: `⟨s_i s_j⟩_free` is only obtainable by running the network with nothing clamped, so an offline generative phase is mandated by maximum likelihood, with the samples entering the weight update *negatively* (the unlearning reading of sleep).
- **[[wiki/concepts/biologically-plausible-credit-assignment.md]]** — the canonical two-phase local rule: no weight transport, no backward pass, each synapse using only its own two units, at the price of a global wake/sleep switch and an equilibrium assumption that no biological timescale is offered for.
- **[[wiki/concepts/synaptic-plasticity.md]]** — Hebbian and anti-Hebbian terms in one rule, with the sign set by whether the network is being driven by the world or by itself; this is the clearest statement in the wiki that a plasticity rule's *phase context* carries as much information as its pre/post product.
- **[[wiki/concepts/predictive-coding-free-energy.md]]** — that page describes its own substrate as "a highly modular, distributed restricted Boltzmann machine" and approximates the intractable global attractor by local interactive adjustment; this page is that approximation named — Gibbs sampling with `Z` cancelled out of every local update.
- **[[wiki/entities/fcann.md]]** — the same Boltzmann form arrived at from the opposite direction: couplings measured (`J = −Σ⁻¹`) rather than learned, with deterministic relaxation for attractors and *stochastic* relaxation used as a generative model of brain dynamics — i.e. this page's sampler run on a landscape nobody trained.
- **[[wiki/entities/dense-sequence-memory.md]]** — the same bipartite move for a different reason: hidden units mediating what would otherwise be all-to-all coupling among content units, giving parallel updates here and per-transition gateable units there.
- **[[wiki/entities/hidden-state-inference-remapping.md]]** — proposes a *mixture* of the object on this page as the implementation of a nonparametric latent-state posterior, so each basin becomes the feature configuration of one inferred hidden state.
