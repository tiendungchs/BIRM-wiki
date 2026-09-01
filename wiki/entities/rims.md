# RIMs — Recurrent Independent Mechanisms

**`k_T` separately-parameterised recurrent cells that run their own default dynamics in parallel, of which only the top-`k_A` are updated at each step — selection made by each cell *querying the input from its own hidden state* and winning if it attends to the input more than to an appended null row, with the winners then reading from all cells (active or not) through a residual attention step.**

> **Provenance.** Goyal, Lamb, Hoffmann, Sodhani, Levine, Bengio & Schölkopf 2019, *Recurrent Independent Mechanisms*, arXiv:1909.10893 (`raw/goyal-2019-recurrent-independent-mechanisms.md`). Seven task families (copying, adding, sequential MNIST at held-out resolutions, bouncing balls, BabyAI/MiniGrid object-picking, the full Atari suite under PPO, WMT→IWSLT transfer, half-cheetah imitation from pixels); the authors state that outperforming optimised baselines is explicitly *not* the goal. Internal project name: "Blocks".

The page exists because RIMs is the wiki's **only router whose input is a module's own state rather than the token**. Every routing system held here — [[wiki/entities/sparsely-gated-moe.md]], [[wiki/entities/switch-transformer.md]], the whole taxonomy on [[wiki/concepts/sparse-expert-routing.md]] — computes `softmax(W_r x)` from the input and is therefore, at the limit, a function of token identity (`T296`). RIMs inverts the direction of the query, which makes context-dependence structural rather than hoped-for, and it is the concrete architecture behind the modularity prediction [[wiki/concepts/independent-causal-mechanisms.md]] states and does not test.

---

## Architecture

| Stage | Equation | Note |
|---|---|---|
| **Input construction** | `X = ∅ ⊕ x_t` | A row of zeros prepended to the input set. This null row is the whole selection mechanism |
| **Input attention** (per module `k`) | `A^(in)_k = softmax( h_t W^q_k (X W^e)ᵀ / √d_e ) X W^v` | `θ^(in)_k = (W^q_k, W^e, W^v)`. **The query weights are per-module; the key/value weights are shared.** Opposite of a Transformer, where the attention parameters are produced on the input side |
| **Selection** | `S_t = top-k_A` modules by *least* attention mass on the null row | Averaged over heads. Ties the activation decision to a module's own recurrent state, so the same `x_t` activates different modules in different contexts |
| **Independent dynamics** | `h̃_{t,k} = LSTM(h_{t,k}, A^(in)_k ; θ^(D)_k)` for `k ∈ S_t`; `h_{t+1,k} = h_{t,k}` otherwise | Private LSTM/GRU parameters per module. Inactive modules are **untouched memory** — and the gradient still flows through them |
| **Communication** | `h_{t+1,k} = softmax( Q_{t,k} K_{t,:}ᵀ / √d_e ) V_{t,:} + h̃_{t,k}`, `k ∈ S_t` | Active modules query; **all** modules (active or not) supply keys and values — a dormant module is still a readable store. Residual, 4 heads, per-module `(W̃^q_k, W̃^e_k, W̃^v_k)` |
| **Spatial variant** | Same input attention over CNN feature positions; top-`k_A` selected **per spatial position** | Makes activation sparse across space as well as time |

Hyperparameters: Adam, lr `7·10⁻⁴`, batch 64; input keys 64, input values `4 × RIM size`, 4 input heads, dropout 0.1; communication keys/values 32, 4 heads, dropout 0.1. Two new hyperparameters over an LSTM: `k_T` and `k_A`.

**Parameter accounting, which the results tables do not.** At matched *hidden size* RIMs has **fewer** recurrent parameters than an LSTM, because the recurrent matrix is block-diagonal (`k_T` blocks of `h/k_T`) rather than dense; the attention machinery adds a small number back. So the LSTM baselines below are over-parameterised relative to RIMs, not under — and the authors separately checked that raising an LSTM from 256 to 512 units does not close the bouncing-ball gap, so the wins are not a capacity effect in either direction.

### The paper's own property table

| Method | Modular memory | Sparse information flow | Modular computation flow | Modular parameterisation |
|---|---|---|---|---|
| LSTM / RNN | ✗ | ✗ | ✗ | ✗ |
| Relational RNN (RMC) | ✓ | ✗ | ✓ | ✗ |
| NTM | ✓ | ✓ | ✗ | ✗ |
| Sparse Attentive Backtracking | ✗ | ✓ | ✗ | ✗ |
| IndRNN | ✓ | ✗ | ✗ | ✓ |
| **RIMs** | ✓ | ✓ | ✓ | ✓ |

Read as a design statement rather than a scoreboard: the four columns are independent axes, and **only the fourth (private parameters per module) is what makes a module separately adaptable** — the property [[wiki/concepts/independent-causal-mechanisms.md]] actually requires. Every mixture-of-experts system in the wiki has column 4; none has columns 1 and 3, because experts are stateless.

---

## Key results

All out-of-distribution: train on one setting, test on a systematically different one.

| Task | Train → test shift | RIMs | Best baseline |
|---|---|---|---|
| **Copying** (CE, last 10 steps) | dormant span 50 → **200** | **0.00** at `(k_T,k_A)` = (6,4), (6,3), (6,2), (5,2) | RMC 0.13; Transformer 0.54; NTM 2.54; LSTM-600 3.56; LSTM-300 4.32 — *all* score 0.00 in-distribution |
| **Sequential MNIST** (accuracy) | 14×14 → 16×16 / 19×19 / 24×24 | **90.0 / 73.4 / 38.1** at (6,4) | Transformer 91.2 / 51.6 / 22.9; RMC 89.58 / 54.23 / 27.75; EntNet 89.2 / 52.4 / 23.5; LSTM-600 84.5 / 52.2 / 21.9; DNC 87.2 / 44.1 / 19.8 |
| **Bouncing balls** (rollout CE, 15 frames in → 35 out) | 4 balls → 6–8; 6–8 → 4; unoccluded → **curtain** | Lower CE than LSTM in every shift; F1 above LSTM and RMC on the partial-observation variant | LSTM at 256 *and* 512 units — the gap is not capacity |
| **BabyAI object-picking** (partial obs., sparse reward) | known → **novel distractors** | Perfect on known distractors; strongly above LSTM on novel, not perfect | LSTM struggles even on known distractors |
| **Atari, PPO** | drop-in LSTM→RIMs, `k_T`=6, `k_A`=4/5, *no hyperparameter search*, identical PPO settings | Large relative score improvement across the suite (3 trials/game) | LSTM-PPO |
| **WMT → IWSLT14 en→de** (BLEU) | parliamentary/news → transcribed speech | 23.71 single-task; **24.23** multi-task (en→de + en→fr, shared encoder) | Transformer 22.89 / 22.92; LSTM 21.32 / **20.37** |
| **Half-cheetah imitation from pixels** | clean → joint noise | Drops, but far less than LSTM | LSTM collapses |

**The translation row is the sharpest single number in the paper and is easy to miss.** Adding a second language pair **hurts** the LSTM (21.32 → 20.37) and **helps** RIMs (23.71 → 24.23), while leaving the Transformer flat. Multi-task interference is the failure a modular parameterisation is supposed to prevent, and this is the one place the paper measures interference directly rather than measuring OOD accuracy and inferring modularity from it.

---

## Ablations, and what they actually show

Copying, CE on the last 10 steps, train span 50 / test span 200 (`h_dim` scaled with `k_T`):

| Configuration | Train | Test |
|---|---|---|
| **Full RIMs** (input attention + communication) | 0.00 | **0.00** across `k_T` ∈ {6, 9, 16, 24} for most `k_A` |
| Input attention, **no communication** | 0.2 – 3.3 | 0.56 – 5.0 — *fails to fit even in-distribution* |
| **No input attention**, full communication, `k_T`=6, `k_A`=6 | 0.0 | 0.7 |
| **No input attention**, full communication, `k_T`=1, `k_A`=1, `h`=512 | 0.0 | **0.2** |

- **Communication is load-bearing, more than sparsity is.** Removing it breaks *training*, not just transfer.
- **Sparsity level is forgiving**: 30–70% activation is optimal on copying; on Atari `k_A`=5 marginally beats 4 and both are close.
- **Too few active modules hurts optimisation; too many attenuates the generalisation gain.** The authors state both directions and set `k_A` by hand.
- **The row the paper does not read.** A **single** module with no input attention and no modularity at all scores 0.2 test CE — better than *every* input-attention-without-communication configuration, and better than the 6-module no-attention variant. What that variant retains is the residual self-attention path. This is consistent with the paper's own alternative explanation, offered in its related work and never separated from the modularity account: IndRNN shows that **smaller recurrent transition matrices mitigate vanishing/exploding gradients**, and inactive RIMs pass their state forward by identity, so a 200-step dormant span is a literal skip connection. **The copying and sequential-MNIST wins are compatible with a gradient-path result rather than a specialisation result, and no experiment here distinguishes them.** The translation, distractor and bouncing-ball rows are not vulnerable to this reading; the two long-span synthetic rows — the paper's headline evidence — are.

---

## Specialisation: observed, then lost

The one direct probe of what the modules encode (bouncing balls, `k_T`=6 with each module confined to a fixed non-overlapping horizontal strip of the image by a masked per-module encoder, `k_A`=4, 4 balls):

> Early in training, module activations correlate strongly with the locations of the four balls. **Later in training the correlation deteriorates** — "the predictable dynamics of the system do not necessitate constant attention."

Three things a builder should take from this, and they are all uncomfortable:

1. **The specialisation was imposed, not discovered.** It was made visible by hard-masking each module to 1/6 of the input. The unconstrained model's decomposition is unmeasured.
2. **The specialisation is a transient of the learning curve.** It appears while prediction is bad and dissolves as prediction improves — so a module-to-object correspondence measured at convergence would have shown nothing, and the reported alignment is an artefact of an under-trained model.
3. **What specialises is temporal phase and spatial region, never a relation.** The copying-task activation pattern separates "receiving" from "dormant"; the ball probe separates image strips. This extends the negative result on [[wiki/concepts/sparse-expert-routing.md]] — every emergent module ever observed is lexical, perceptual, temporal or spatial — to an architecture built specifically to escape it, and adds a *decay* that the mixture-of-experts literature never looked for.

Other analyses: sequential-MNIST module-masking figures (mask one module, observe the effect on the others) across `k_T` ∈ {4,5}, `k_A` ∈ {2,3,4}; RL efference-copy variant (feed previous actions, rewards and instructions into the activation decision) reported as improving Atari in preliminary experiments and not included.

---

## What this contributes that no other routing system in the wiki does

| Property | Mixture-of-experts ([[wiki/concepts/sparse-expert-routing.md]]) | RIMs |
|---|---|---|
| Router input | The token embedding `x` | **The module's own recurrent state `h_{t,k}`** |
| Router parameters | One shared `W_r ∈ ℝ^{E×d}` | **Private `W^q_k` per module** — no shared router, so no rich-get-richer path through a single matrix |
| Context-dependence | Hoped for; unproven, and a fixed hash competes (`T296`) | **Structural** — the query is a function of history, so the same input routes differently depending on state |
| Load balance | An auxiliary loss, an assignment, a hash, or an anneal | **No balance mechanism at all**, and none reported necessary — plausibly because a module that stops winning also stops updating its state, which does not make it *less* likely to win later |
| Abstention | Absent; a wrong expert is taken. Switch's overflow-rerouting result says a wrong module is worse than none | **First-class**: the null row makes "nothing here for me" the default, and the selection is a comparison against it |
| Module state | None — experts are stateless functions | A full recurrent state that **persists while dormant** and is still readable by the winners |
| Compute budget | `k` fixed by design | `k_A` fixed by design — same defect, explicitly flagged as future work |
| Heterogeneity | Identical experts, forced by hardware | Identical in the paper, but nothing forbids otherwise; the constraint that binds MoE (compute-to-I/O ratio ≥ cluster compute-to-bandwidth) does not apply at these sizes |

The null-row mechanism deserves separate emphasis. It converts the top-`k` selection from *"which `k` modules score highest"* into *"which modules clear a learned, input-dependent reserve price"* — a threshold comparison rather than a ranking. The paper then throws that away by taking a fixed-size top-`k_A` over the result, which is exactly the step that reintroduces the hand-set budget. **(brainstorm) Selecting every module that beats its null row, with no `k_A` at all, is a one-line change that would make the active set size adaptive per step and give a ponder-cost-free analogue of [[wiki/concepts/adaptive-computation-time.md]] on the *width* axis instead of the depth axis. Nothing in the paper or in the wiki does this, and the paper names "dynamic ways of controlling how many RIMs to activate" as open.**

---

## Reading in the core framing

| Element | [[wiki/concepts/latent-graph-discovery.md]] reading |
|---|---|
| Modules | Nodes whose **semantics are learned**, unlike a standard graph network where node identity is tied to an input entity. The paper says so explicitly |
| Communication attention | Edges **parameterised and recomputed every step** — the topology is dynamic, where a graph network's is fixed and given |
| `S_t` | The traversed subgraph at time `t`; the dormant complement is state that persists without being visited |
| The null row | A per-node relevance test against the current observation — the closest thing in the wiki to a learned "does this node apply here" predicate |
| `k_T`, `k_A` | Vertex count and per-step traversal width, both architectural constants ([[wiki/concepts/node-definition-problem.md]]) |

---

## Limits

- **`k_T` and `k_A` are hand-set**, with a stated trade-off in both directions and no rule. Same defect class as ACT's `τ` (`G107`) on a different axis.
- **The decoder is shared and unstructured.** Module states are concatenated and fed to one decoder; the authors flag that a shared decoder can fail to generalise even when the modules do, and propose no fix.
- **No module is ever transferred, frozen, ablated across tasks, or counted.** The ICM prediction the paper invokes — *few modules need to change under a distribution shift* — is tested only through aggregate end-to-end accuracy. "How many modules had to change?" is unmeasured here as everywhere.
- **No random-routing control.** THOR's uniform-random expert selection *beats* learned MoE routing by 2 BLEU; RIMs never runs the equivalent (activate a random `k_A` each step), so the paper's own ablations cannot separate "the selection is right" from "the sparsity is enough" — `T296` at module granularity.
- **The two headline synthetic results admit a gradient-path explanation** the paper supplies and does not exclude (above).
- **Baselines are not tuned** and the authors say so; Atari ran with no hyperparameter search at all.
- **Specialisation is transient and was only visible under an imposed input mask** (above).

---

## Connections

- **[[wiki/concepts/sparse-expert-routing.md]]** — the taxonomy this architecture does not fit: every class there takes the top-`k` of `softmax(W_r x)` computed from the *input* by a shared router, where RIMs computes it from each module's *own recurrent state* with private query weights and a null-row reserve price — which makes context-dependence structural rather than hoped-for, and needs no balance loss.
- **[[wiki/concepts/independent-causal-mechanisms.md]]** — the architecture that page's fourth downstream prediction asks for: modules with private parameters and default dynamics that interact sparsely, motivated explicitly by Sparse Mechanism Shift — and it inherits that page's open problem intact, since nothing here counts how many modules a shift touches.
- **[[wiki/concepts/emergent-modularity.md]]** — the sharpest available negative for that page's central claim, and a new failure mode: the one module-to-object correspondence ever measured in this architecture was visible only under an imposed spatial mask and **decayed over training** as prediction improved, so emergent modules can be a transient of the learning curve rather than a property of the converged model.
- **[[wiki/concepts/adaptive-computation-time.md]]** — the same conditional-computation question on the orthogonal axis: ACT varies how many *times* one parameter set runs and learns the count; RIMs varies *how many modules* run and fixes the count by hand — and the null row is already a per-module halting test that the fixed top-`k_A` discards, which is the untried combination.
- **[[wiki/concepts/attention.md]]** — the machine implementation of biased competition (Desimone & Duncan 1995) that page carries as the biological story: the query originates in the module (a top-down bias from a maintained state), competition among modules for the input is the selection, and losers are suppressed by being frozen rather than by having their gain reduced — including the maintained "what I am currently tracking" register that page says softmax attention conspicuously lacks.
- **[[wiki/concepts/latent-graph-discovery.md]]** — a graph network whose *node semantics are learned* and whose *topology is recomputed every step*, which the paper states as its own reading; what it still hands over is the vertex count `k_T` and the traversal width `k_A`.
- **[[wiki/concepts/node-definition-problem.md]]** — the vertex set declared as a hyperparameter and its contents left to training, with the one probe of what the vertices came to mean showing the correspondence dissolving as the model improved.
- **[[wiki/concepts/working-memory.md]]** — a store whose slots have *their own transition dynamics* rather than being passive registers: an unselected module is untouched memory that is still readable by the selected ones, so maintenance and computation are the same substrate.
- **[[wiki/entities/differentiable-neural-computer.md]]** — the memory-model comparison the paper runs and wins (87.2 / 44.1 / 19.8 vs 90.0 / 73.4 / 38.1 on held-out MNIST resolutions), and the design contrast: an external memory has one shared update rule applied to passive cells, RIMs gives each cell its own update rule and no external controller.
- **[[wiki/entities/transformer.md]]** — inverted on both axes: a Transformer computes attention parameters on the input side and lets every element interact every step, RIMs puts the query parameters on the module side and forbids interaction by default; it beats the Transformer on all three held-out MNIST resolutions while losing at the training resolution (90.0 vs 91.2), which is the signature of an inductive bias rather than of capacity.
- **[[wiki/entities/universal-transformer.md]]** — the other Wave-17 conditional-computation source and the complementary halving: that model shares one parameter set across depth and varies the step count per position, RIMs holds the step count fixed and varies which of many parameter sets run — so between them the two axes of conditional computation are covered, and neither sets its own budget.
- **[[wiki/entities/switch-transformer.md]]** — supplies the constraint RIMs' null row answers: rerouting an overflowed token to its second-choice expert buys nothing, i.e. a wrong module is worse than no module — which is exactly what a comparison against an appended null option implements and what a plain top-`k` argmax cannot.
- **[[wiki/entities/neural-module-networks.md]]** — the other architecture in the wiki where routing granularity is not the token, and the opposite trade: NMN gets *relational* specialisation and typed arity by having the layout supplied by an unlearned parser, RIMs learns the selection end-to-end and gets only temporal/spatial specialisation — so relational modules and a learned router have never yet been obtained together.
- **[[wiki/concepts/learned-world-models.md]]** — the setting the argument is pitched at: a transition model factorised into mechanisms that are independent by default should need only a few parts re-learned per shift, and the bouncing-ball rows (train 4 balls → test 6–8, and an occluding curtain) are the wiki's cleanest test of object-count and occlusion invariance in a learned forward model.
- **[[wiki/concepts/cognitive-control.md]]** — the paper's own cognitive framing: activated modules read external input and correspond to controlled processing, dormant modules to habitual processing outside conscious access, with affordance selection (Cisek & Kalaska 2010) offered as the account of the Atari gains — an architecture where the automatic/controlled split is a per-step selection rather than two systems.
- **[[wiki/concepts/global-neuronal-workspace.md]]** — the same "few modules interact at a time" bottleneck without the bus: RIMs' communication is all-to-all attention among `k_T` modules (`O(k_T²)`), so it buys sparsity in *who computes* rather than in *who can reach whom*, and there is no exclusive commit — which is `G91` untouched from a system that otherwise looks like a workspace.
- **[[wiki/concepts/continual-learning.md]]** — the interference measurement the modularity claim needs and rarely gets: adding a second translation task *lowers* an LSTM's transfer BLEU (21.32 → 20.37) and *raises* RIMs' (23.71 → 24.23) at comparable parameter counts, which is task interference priced directly rather than inferred from an OOD gap.
