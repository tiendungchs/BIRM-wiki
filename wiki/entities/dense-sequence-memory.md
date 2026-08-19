# DenseNet / MixedNet (Dense Associative Sequence Memory)

**Take the asymmetric Hopfield chain — weights that map each stored pattern to its successor — and pass the pattern–state overlap through a strong nonlinearity before it drives the next state. The nonlinearity suppresses cross-talk, and the maximal storable *sequence length* goes from linear in the neuron count to polynomial (`f(x) = x^d`) or exponential (`f(x) = e^{(N−1)(x−1)}`).** Chaudhry, Zavatone-Veth, Krotov & Pehlevan 2023, NeurIPS.

The wiki's first capacity theory for **sequence** memory that is not a chain of independent one-step retrievals, and the first source here that treats the *interaction function* — how overlap is converted into drive — as the design variable, rather than the code, the sparsity, or the address space.

> **Provenance.** `raw/chaudhry-2023-long-sequence-hopfield-memory.md` — *Long Sequence Hopfield Memory*, 37th Conference on Neural Information Processing Systems (NeurIPS 2023).

---

## The models

`N` neurons, state `S(t) ∈ {−1,+1}^N`, stored sequence `ξ¹ → ξ² → … → ξ^P → ξ¹` (periodic), patterns i.i.d. Rademacher unless stated. Overlap `m^μ(S) = (1/N) Σ_j ξ_j^μ S_j`.

| Model | Update rule | What it is |
|---|---|---|
| `SeqNet` | `S(t+1) = sgn( Σ_μ ξ^{μ+1} m^μ(S) )`, i.e. `J_ij = (1/N) Σ_μ ξ_i^{μ+1} ξ_j^μ` | The classical temporally asymmetric Hebbian chain (Hopfield 1982 with asymmetric weights; Sompolinsky & Kanter 1986). Capacity **linear in `N`** |
| `DenseNet` | `S(t+1) = sgn( Σ_μ ξ^{μ+1} f(m^μ(S)) )`, `f` monotone increasing | Dense Associative Memory / Modern Hopfield separation applied to the *asymmetric* weights |
| **Polynomial `DenseNet`** | `f(x) = x^d` | Transition capacity **polynomial in `N` of degree `d`** — the same scaling as the symmetric Modern Hopfield Network, because with self-interaction excluded the single-bitflip probabilities coincide exactly |
| **Exponential `DenseNet`** | `f(x) = e^{(N−1)(x−1)}` (`f(1)=1`, everything else → 0 exponentially fast) | **Exponential in `N`** sequence capacity — `P ∼ β^{N−1}/(αN)` |
| Generalized pseudoinverse (**GPI**) | `S(t+1) = sgn( Σ_μ ξ^{μ+1} f( Σ_ν O⁺_{μν} m^ν ) )`, `O` the pattern overlap matrix | Decorrelation *inside* the separation function; reduces to Kanter–Sompolinsky (1987) at `f(x)=x`. **Perfect full-sequence recall whenever the patterns are linearly independent** |
| `MixedNet` | `S(t+1) = sgn( f_S(m^μ(t)) · ξ^μ + λ f_A(m̄^μ(t)) · ξ^{μ+1} )` summed over `μ`, with `m̄^μ` the overlap against a low-pass filtered state `S̄(t) = Σ_{ρ≤τ} w(ρ) S(t−ρ)` | Symmetric ("fast synapse") term holds the current pattern, asymmetric ("slow synapse") term pushes to the next — the Temporal Association Network (Sompolinsky & Kanter 1986, `P ≈ 0.1N`) with both terms made nonlinear. This is where **variable dwell time** comes from |

**Where the capacity comes from, in one line.** The bitflip probability is `P[C < −f(1)]` where the cross-talk `C` is a sum of `P−1` i.i.d. terms, one per non-target pattern, each passed through `f`. Making `f` steep collapses every off-target term toward zero while leaving `f(1)=1`, so the signal-to-noise ratio at fixed `P` rises and the tolerable `P` rises with it. **Capacity is bought at the read-out nonlinearity, not at the code and not at the learning rule** — nothing about how the weights are written changes.

---

## Capacity results

| Quantity | Result |
|---|---|
| Transition capacity `P_T` (one correct step) vs. sequence capacity `P_S` (all `P` steps correct) | Union bound: `P_S` is smaller by roughly a factor `P`. Polynomial: `P_T/P_S ∼ d+1`, a **bounded** gap. Exponential: the gap **diverges with `N`** |
| Polynomial `DenseNet` | `P_T, P_S` polynomial in `N`, degree set by `d`. Rigorous asymptotic lower bound available by adapting Demircigil et al. (2017) |
| Exponential `DenseNet` | Exponential in `N`; simulation confirms the scaling but deviates substantially from the Gaussian theory for `P_S` |
| **Capacity is not monotone in `d`** | For fixed `N` there is a `d_max` beyond which capacity *falls* — the factorial in the moment expansion outgrows the exponential. Also true of the symmetric MHN. A builder must choose `d` for the network size, not maximise it |
| Why the exponential theory breaks at small `N` | With `f` exponential each cross-talk term is a *product* of i.i.d. variables → lognormal; the sum is a mixture of lognormals, strongly non-Gaussian. Excess kurtosis *rises* with `N` up to `N ≈ 56`, so increasing `N` at fixed `P` cuts cross-talk variance but fattens its tails — competing effects, and the regime accessible to simulation is the bad one |
| `MixedNet` (analysed at `τ = 1`) | Capacity scales as `min(d_S, d_A)`, times a factor `γ_{d_S,d_A}`. Cross-talk variance is **bimodal**, which is the technical novelty relative to the pure `DenseNet` |
| Correlated (biased) patterns, `P(ξ=±1) = (1±ε)/2` | Signal dominates only if `P < ε^{−(2d+1)} + 1`. So the nonlinearity buys robustness to correlation *at an exponential rate in `d`*, but never removes the constraint — for any `ε ≠ 0` there is a `P` at which the constant bias overwhelms the signal |

**The correlated-data result is the one to remember.** 200,000 MovingMNIST frames (`N = 784`, 10,000 concatenated 20-frame subsequences of two digits sliding through each other). `SeqNet` and Polynomial `DenseNet`s up to `d ≈ 50` recall **nothing** — not a part of any image — *despite being well inside the capacity predicted by the uncorrelated theory*. The Exponential `DenseNet` recalls the whole sequence perfectly. GPI restores high capacity for Polynomial `DenseNet`s at large bias (but is numerically unstable in the exponential case, small pseudoinverse eigenvalues).

**Timing needs more nonlinearity than order does.** `MixedNet` at `N=100, τ=5, P=40`: `d_S=d_A=1` (= Temporal Association Network) fails outright; `d=2` recovers the correct *order* but not the dwell time; `d=10` recovers order **and** timing. Two failure modes, two thresholds — a sequence memory can be right about what comes next and wrong about when.

---

## The two-body (biologically plausible) form

A degree-`d` polynomial interaction is a `(d+1)`-body synapse — biologically impossible, and for the exponential case an infinite-body one. The fix is Krotov & Hopfield's (2021) bipartite reformulation, adapted to asymmetric weights by using **two** weight matrices instead of a matrix and its transpose:

| | Definition |
|---|---|
| Visible units `v_j` | The `N` neurons of the dynamics |
| Hidden units `h_μ` | **One per stored pattern** (`P` of them) — a "memory neuron" |
| Visible → hidden | `W_{jμ} = ξ_j^μ / N`; hidden activation applies `f` — **the nonlinearity lives in the hidden unit's transfer function, not in the synapse** |
| Hidden → visible | `M_{μj} = ξ_j^{μ+1}` (`DenseNet`) or `ξ_j^μ + λ ξ_j^{μ+1}` (`MixedNet`) |
| Update | `h_μ = f(Σ_j W_{jμ} v_j)`, `v_j(t+1) = sgn(Σ_μ M_{μj} h_μ)` |

Consequences a builder should note:

1. **Capacity is linear in the *total* neuron count** (`N + P`) — the exponential scaling is exponential in the *visible* count only. The many-body synapse has been traded for a wide hidden layer, which is the same trade [[wiki/entities/sparse-distributed-memory.md]] makes (`M ≫ N` hard locations, one plastic layer) with the roles of the two matrices swapped: SDM's fixed matrix is on the *address* side, here it is on both.
2. **Asymmetry is a second matrix, not a transpose.** `W` reads which pattern you are in; `M` writes which pattern you go to. Separating them is what makes the store a *transition* store rather than a state store, and it costs one matrix.
3. **A gating port that no other memory in the wiki has.** Inhibiting hidden unit `μ` removes exactly one *transition* from the dynamics. Mapped onto anatomy: motor cortex = visible units, thalamic units = hidden units (each encoding a motor motif), basal ganglia = the external network that silences them — the cortico-basal-ganglia-thalamo-cortical loop as context-dependent gating of a sequence memory. Compare the same architecture in zebra-finch song generation (thalamocortical loops).

---

## What it contributes

| Claim | Why it matters here |
|---|---|
| **Sequence capacity is a separate quantity from item capacity, and the two scale differently** | Every store in the wiki reports how many *items* it holds. This reports how many *steps* can be chained before one bit flips and the trajectory leaves the sequence forever — and the transition/sequence gap can diverge, so a memory that is excellent at single-step retrieval can be useless at rollout |
| **A steeper read-out nonlinearity is a capacity knob orthogonal to sparsity** | The wiki's separation knobs are all *representational* (active fraction, address space, orthogonalization). This one leaves the code untouched and changes only how overlap becomes drive — and it is a single scalar `d` with a computable optimum `d_max(N)` |
| **Correlated real data breaks capacity theory by orders of magnitude** | The uncorrelated bound is not merely loose on MovingMNIST, it is *qualitatively* wrong (predicted fine, recalls nothing). Any capacity number in this wiki derived from i.i.d. random patterns should be read as an upper bound that real data may miss entirely ([[wiki/entities/rolls-treves-hippocampal-model.md]], [[wiki/entities/sparse-distributed-memory.md]], [[wiki/entities/vector-hash.md]] all assume near-orthogonal codes) |
| **Dwell time is a nonlinearity threshold** | `MixedNet` separates "next state" from "when to leave the current state" into two terms with two nonlinearities, and the timing term needs the stronger one. Variable-duration states are a prerequisite for hierarchical action, and this prices them |
| **Deleting a memory neuron deletes a transition** | Gating at the hidden layer of a bipartite associative memory is a per-edge control signal — the closest thing in the wiki to an addressable *edge* switch in an attractor store |

**(brainstorm) The hidden layer is an adjacency list.** With one hidden unit per stored pattern and `M_{μj}` naming its successor, the bipartite `DenseNet` is literally an edge table: `W` matches the current state to a node, `f` sharpens the match into a near-one-hot selection, `M` emits the successor. Branching — the property [[wiki/entities/sparse-distributed-memory.md]]'s pointer chains and [[wiki/entities/vector-hash.md]]'s velocity code both lack — needs only *several* hidden units sharing an antecedent and a selection signal among them, which is exactly the port the basal-ganglia gating story already supplies. Nothing in the paper does this: its sequence is a single cycle with one successor per state. But the gap between "sequence memory" and "graph memory" here is a selection rule over hidden units, not a new architecture.

**(brainstorm) `f` is a temperature, and it should probably be scheduled.** `f(x)=x^d` with a fixed `d` commits the store to one separation/completion bias for its lifetime, and the paper shows the optimum `d_max` depends on `N` and (via the bias analysis) on the correlation structure of what is stored. [[wiki/entities/sparse-distributed-memory.md]] derives the analogous knob as a function of *load* (`p ∝ (MT)^{−1/3}`). The two put together suggest the missing object is a load- and correlation-dependent schedule for `d` — cheap to implement (one scalar in the hidden-unit transfer function) and, as far as this wiki knows, unbuilt.

---

## Comparison — how the wiki's stores handle sequences

| | `DenseNet`/`MixedNet` | [[wiki/entities/vector-hash.md]] | [[wiki/entities/sparse-distributed-memory.md]] | [[wiki/entities/stp-flickering-cann.md]] |
|---|---|---|---|---|
| Sequence mechanism | Asymmetric weights, state → successor state | Store the **2-D velocity**; manifold dynamics regenerate the state | Pointer chain: word stored at the previous word's address | None (two static maps) |
| Sequence capacity | Polynomial or **exponential** in `N` | ~1.5×10⁵ steps (velocity-coded); its asymmetric-Hopfield baseline ≈ 50 steps | Demonstrated at 6 steps; capacity not separately derived | — |
| Cost per step | `O(N)` bits — the whole successor pattern | `log|actions|` bits | `O(N)` bits | — |
| Branching | No (one successor per pattern; the hidden layer could support it — see brainstorm) | No (unstructured shift) | No (an address with two successors averages them) | — |
| Correlated patterns | Catastrophic without GPI or an exponential `f` | Handled by construction (addresses are content-free) | Degrades (clustered data wastes locations) | — |
| Variable dwell time | **Yes** (`MixedNet`, `τ` steps) | No | No | Implicitly, via short-term plasticity |
| Confidence read-out | No | Recognition via mean rate | `\|s_u\|` per bit | No |

The `SeqNet` row of this table is the ≈50-step asymmetric-Hopfield baseline Vector-HaSH reports and dismisses. This paper's claim is that the baseline was weak for a removable reason — the interaction function — which puts the two designs in direct tension ([[wiki/empirical-tensions.md]] T57).

---

## Limitations

| Limit | Consequence |
|---|---|
| **The patterns are given, never learned** | Weights are written from known `ξ^μ` by an outer-product rule. Nothing here discovers states, segments a stream into them, or decides what should be a pattern — [[wiki/concepts/event-segmentation.md]] and [[wiki/concepts/latent-graph-discovery.md]] are entirely upstream |
| **One deterministic cycle** | Periodic boundary conditions, one successor per state, no branching, no policy, no context. It is a tape, not a graph |
| Theory rests on two uncontrolled approximations | Union bounds on the single-bitflip probability, and a Gaussian approximation to the cross-talk. The authors decline to control the Edgeworth error, and for the Exponential `DenseNet` the approximation is *known* to be bad in the simulated range |
| Simulations are small (`N ≤ 100` for capacity curves) | The regime where the exponential model's theory and simulation disagree is exactly the regime that can be simulated; the claimed scaling is extrapolation |
| **GPI needs the pattern overlap matrix and its pseudoinverse** | Non-local, batch, and numerically unstable in the exponential case. The one mechanism that fixes correlated recall is the one with no online or biological implementation |
| `MixedNet` analysis only at `τ = 1` | The variable-timing capacity — the thing the model exists for — is demonstrated numerically and derived only in the single-step-memory special case |
| Bipartite form costs one hidden unit per stored pattern | Capacity is linear in total neurons; the exponential scaling is a statement about the visible layer only, i.e. about how much can be packed *per feature neuron*, not per synapse |
| Fixed-point capacity only | Basin sizes, noise robustness and probability of *converging* to the next pattern from a perturbed state are not addressed — the paper flags these as the harder open definitions |

---

## Connections

- **[[wiki/concepts/energy-based-models.md]]** — the asymmetric case the energy formalism does not cover: with `J ≠ Jᵀ` there is no Lyapunov function and retrieval is not relaxation to a minimum but a driven traversal, so "attractor memory" splits into a landscape (symmetric) part and a transition (asymmetric) part, and the `MixedNet` is the explicit mixture of the two with `λ` setting the ratio.
- **[[wiki/entities/vector-hash.md]]** — the rival answer to the same question: store the increment on a low-dimensional manifold (`log|actions|` bits/step) versus store the successor state and sharpen the read-out (`O(N)` bits/step but exponential capacity in `N`); Vector-HaSH's ≈50-step asymmetric-Hopfield baseline is this paper's `SeqNet` ([[wiki/empirical-tensions.md]] T57).
- **[[wiki/entities/sparse-distributed-memory.md]]** — the same one-fixed-matrix/one-plastic-matrix bipartite skeleton with the fixed matrix moved from the address side to both sides, and the same trade of many-body interaction for a wide hidden layer; SDM's load-dependent sparsity schedule is the knob this paper leaves as a constant `d`.
- **[[wiki/entities/rolls-treves-hippocampal-model.md]]** — the biological capacity theory this one is the machine dual of: there capacity is bought with sparsity and fan-in (`p_max ≈ kC/(a ln(1/a))`), here with the steepness of the read-out at fixed code, and both collapse on correlated patterns for the same cross-talk reason.
- **[[wiki/concepts/synaptic-plasticity.md]]** — supplies the write rule these models assume (temporally asymmetric Hebbian / spike-timing-dependent plasticity gives exactly `J_ij ∝ Σ_μ ξ_i^{μ+1} ξ_j^μ`), and this page supplies the payoff and its ceiling: what such a rule can store is linear in `N` unless a nonlinearity is added downstream of it.
- **[[wiki/concepts/inhibitory-control-of-coding.md]]** — a concrete computational job for inhibition that is neither sparsification nor normalization: silencing one hidden "memory neuron" deletes one *transition*, so a basal-ganglia-like inhibitory pathway becomes a per-edge gate on a sequence memory.
- **[[wiki/concepts/working-memory.md]]** — sequence recall as an alternative to active maintenance: `MixedNet`'s symmetric term holds a state for `τ` steps and its asymmetric term releases it, which is a gate and a dwell timer built from the same weights rather than from a separate controller.
- **[[wiki/concepts/offline-replay.md]]** — prices the substrate replay runs on: a stored trajectory can only be re-expressed for as many steps as the sequence capacity allows, and the transition/sequence capacity gap says single-step reactivation success does not imply the whole trajectory replays.
- **[[wiki/concepts/pattern-separation-completion.md]]** — separation applied at the read-out rather than at the code: `f(m)` widens the gap between the target's overlap and every other pattern's without changing sparsity or dimensionality, and the biased-pattern bound `P < ε^{−(2d+1)}+1` is the price of skipping the representational fix.
- **[[wiki/concepts/latent-graph-discovery.md]]** — a transition store with the discovery layer absent: nodes are supplied, edges are one-successor-per-node, and the only thing derived is how many edges can be chained before the trajectory is lost — which is the capacity budget any discovered graph would have to be stored within.
- **[[wiki/entities/context-modular-memory-network.md]]** — the adjacent granularity of the same idea: silencing one hidden memory neuron here deletes one stored *transition*, while a context mask there deletes a whole *set of states* from the landscape — edge-level versus subgraph-level gating of an attractor store, and neither model supplies the signal that drives the gate.
- **[[wiki/entities/fcann.md]]** — sharpens the symmetric/asymmetric split this page relies on: the antisymmetric component of a coupling matrix leaves the steady-state distribution untouched and only induces solenoidal flow tangential to its level sets, so `MixedNet`'s hold term owns the landscape and its transition term owns a circulation that no energy function can see.
- **[[wiki/entities/hopfield-network.md]]** — the symmetric baseline this page breaks in two places at once: dropping `J = Jᵀ` turns fixed points into transitions, and steepening the overlap nonlinearity attacks the same `≈0.14N` capacity without touching the code.
- **[[wiki/entities/boltzmann-machine.md]]** — the same bipartite move made for a different payoff: replacing all-to-all coupling among content units with a mediating hidden layer gives conditional independence and parallel layer updates there (the restricted form), and individually gateable per-transition units here.
