# fcANN (Functional Connectivity-Based Attractor Neural Network)

**Take the resting-state functional connectome of the whole human brain, use it *directly* as the coupling matrix of a continuous-state Hopfield network (`J = −Λ = −Σ⁻¹`, the negative inverse covariance of regional time series), and run the standard relaxation `σ_i(t+1) = L(β Σ_j J_ij σ_j(t)) + noise`. With two hyperparameters and no fitting, the network has four attractor states that (i) coincide with the leading eigenvectors of `J`, (ii) reproduce resting-state occupancy, flow and non-Gaussian structure, and (iii) predict task-evoked and disease-related changes as *perturbations of the same landscape*.** Englert et al. 2026, *eLife* 98725.

The wiki's first attractor model fitted to a whole brain rather than to a circuit, and its first **empirical test of a prediction that free-energy minimisation makes about the *geometry* of a network's attractors**: they should be approximately orthogonal.

> **Provenance.** `raw/englert-2026-brain-attractor-dynamics.md` — *Functional connectivity-based attractor dynamics of the human brain in rest, task, and disease*, eLife 98725 (2026). The theory it implements is Spisak & Friston 2025 (FEP-ANNs), not itself in `raw/`.

---

## The model

| Object | Definition |
|---|---|
| Units | `m = 122` functional parcels (BASC atlas), state `σ_i ∈ [−1,1]`, continuous Bernoulli / truncated exponential `p(σ_i) ∝ e^{κ_i σ_i}` |
| Steady state | `p*(σ) ∝ exp( Σ_i b_i σ_i + ½ Σ_ij J^S_ij σ_i σ_j )` — the Boltzmann form, but derived from the free-energy principle rather than assumed |
| Couplings | `J = −Λ = −Σ⁻¹`: regularised **partial correlations** of resting-state fMRI, group-averaged, standardised. No structural (diffusion) connectivity, no biophysics |
| Inference (fast) | `σ_i(t+1) = L(β Σ_{j≠i} J_ij σ_j(t)) + noise`, `L` = Langevin sigmoid; deterministic (`noise = 0`) finds attractors, stochastic samples trajectories |
| Learning (slow, **not run here**) | `ΔJ_ij ∝ σ_i σ_j − L(b_i + Σ_{k≠i} J_ik σ_k) σ_j` — observed correlation (Hebbian) minus *predicted* correlation (anti-Hebbian); a contrastive predictive-coding rule |
| Hyperparameters | **two**: `β` = 0.04 (inverse temperature ⇒ 4 attractors) and `ε` = 0.37 (noise), both coarsely set once on study 1 and never re-tuned |
| Bias | `b = 0` throughout; external input enters as an added *control signal* per iteration |

**Interpretation supplied by the theory.** `β` is the **precision of the prior**: the attractors encoded in `J` are macro-scale priors, the previous state plus input is the likelihood, and the stochastic update is MCMC sampling from the posterior. `β → ∞` recovers a binary Hopfield net that ignores its input entirely — infinite prior precision.

**Why a symmetric matrix is enough even if the brain is not symmetric.** Split `J = J^S + J^A`. Only `J^S` enters `p*`; the antisymmetric part induces solenoidal flow *tangential to the level sets of* `p*`, breaking detailed balance (a non-equilibrium steady state) without changing the stationary distribution. So a directionless correlation measure suffices to reconstruct the landscape — while saying nothing about the traversal on it.

---

## Results

| Question | Result | Null model |
|---|---|---|
| **Are the attractors the eigenvectors of `J`?** (K-S projector test) | Yes — leading eigenvectors match attractor states, eigenvalue rank tracks fractional occupancy | Phase-randomised time series (NM1), no such alignment |
| **Is the connectome a *good* attractor network?** | Median **383 iterations to converge vs 3543.5** for a degree- and symmetry-preserving permutation — ~9× faster | Permuted couplings (NM2) |
| Number / structure of attractors | 4 at `β` = 0.04, in **symmetric ± pairs**; count grows with `β` | — |
| Attractor identity | `internal ↔ external context` (PC1) × `perception ↔ action` (PC2); Neurosynth maps land in the expected quadrants (vision = external-perception, working memory/language = internal-action, autobiographical memory = internal-perception) | — |
| Replicability | mean `r = 0.93` across three sites/scanners/sequences; robust to noise added to `J` (more so than nodal strength) | — |
| Variance explained in held-out fMRI | `R² = 0.399` in-sample, **0.396 out-of-sample** — above the data's *own* first two PCs (0.370 / 0.364) | bootstrap |
| Resting dynamics | occupancy ≈ ¾ on the first attractor pair, ¼ on the second, matching empirical; bimodal state distribution reproduced; flow field `r = 0.88` | covariance-matched Gaussian (NM3), shuffled time order (NM4) |
| Task = perturbation | Pain shifts states toward the action attractor and *raises energy*; a meta-analytic pain map injected at **SNR = 0.005** reproduces the empirical flow (`r = 0.46`) including a "**ghost attractor**" on the basin boundary | condition-label shuffling (NM5) |
| One-region control | Adding/subtracting the *same* SNR = 0.005 signal in nucleus accumbens alone reproduces up- vs down-regulation flow differences (`r = 0.62`), with no re-optimisation | NM5 |
| Disease = altered landscape | ASD-vs-control connectomes, run through the same machinery, predict the empirical flow difference (`r = 0.66`, `p = 0.009`): more return-to-centre on the internal/external axis, more excursion on action/perception | group-label shuffling |

**Self-regulation changed the *position* on the landscape but not the energy** (`p = 0.37`), whereas pain changed both — the model separates "moved to a different state" from "driven up the landscape", which no descriptive dynamic-connectivity method does.

---

## Why the orthogonality result matters for building a model

Attractor networks whose attractors are mutually orthogonal are **Kanter–Sompolinsky projector networks**: maximal storage capacity and *error-free* recall, with the attractors equal to the positive-eigenvalue eigenvectors of `J`. This is not what Hebbian storage of random patterns gives, so the alignment is a signature, not a tautology.

| Consequence | Statement |
|---|---|
| **Capacity** | Orthogonalisation is the cheapest route to the capacity ceiling — no steeper read-out nonlinearity ([[wiki/entities/dense-sequence-memory.md]]), no context mask ([[wiki/entities/context-modular-memory-network.md]]), no address space ([[wiki/entities/vector-hash.md]]) required |
| **The rule that gets you there** | The FEP learning rule above is claimed to be **the only known local, incremental, single-phase rule that approximates a K-S network**; the alternative ("dreaming"/unlearning nets) needs two phases |
| **Priors that span rather than enumerate** | Orthogonal attractors span the subspace of interest efficiently, so posterior sampling generalises to unseen points *inside that subspace* — a stated generalisation mechanism, not just a storage one |
| **Detection** | Eigenvector-attractor alignment is a cheap test any built network can be subjected to, on its own weights, with no labels — the wiki's list of internal instruments ([[wiki/concepts/representation-probing.md]]) gains a purely structural one |

**(brainstorm)** The wiki's separation/completion knob (G38) and this page's orthogonality are the same quantity at two scales: pattern separation *makes* stored items orthogonal at write time by sparsifying the code, while the contrastive rule here *drives* them orthogonal by subtracting what the network already predicts. The second form is attractive for a machine store because it needs no sparsity constraint and no allocation decision — the anti-Hebbian term is exactly "do not re-store what you can already reconstruct", which is also the cheapest imaginable answer to *when to write* (G19).

---

## Limitations

- **No structure, no biophysics.** The model cannot say anything about polysynaptic mechanism, and by construction cannot study structure–function coupling. The proposed fix (use diffusion MRI as a sparsity mask on `J` and *train* with the FEP rule) is future work.
- **Stationary connectome** assumed; dynamic connectivity is claimed to be re-expressed as multistable fluctuation around a fixed landscape ("latent functional connectivity"), which is an interpretation rather than a demonstration.
- **The learning rule is never run.** Every result here is inference on a landscape read off the data; the self-orthogonalisation claim is tested only as a *signature* in the fitted weights.
- **Four attractors is a choice for tractability**, not a finding; `β` and the projection's 2 dimensions discard most of the reconstructed state space.
- **Correlational throughout.** `J = −Σ⁻¹` is a directionless statistical estimate; a good fit of a Boltzmann-form model to covariance is close to guaranteed for the *distribution*, and the non-trivial content is in the convergence-speed, eigenvector-alignment, flow and perturbation results, not in the fit itself.
- **The attractor–function mapping is called "somewhat speculative" by the authors**; the internal/external × perception/action labelling comes from meta-analytic overlap, not from a task manipulation of each axis.

---

## Comparison

| | **fcANN** | [[wiki/entities/rolls-treves-hippocampal-model.md]] | [[wiki/entities/context-modular-memory-network.md]] | [[wiki/entities/vector-hash.md]] |
|---|---|---|---|---|
| Where the weights come from | **Measured** (inverse covariance of activity) | Derived from anatomy + Hebbian storage | Hebbian storage + external mask | Frozen random projection of a grid code |
| Scale | 122 whole-brain parcels | one CA3 circuit | abstract `N` | abstract `N` |
| Attractor geometry | Approximately **orthogonal** (eigenvectors of `J`) | Sparse random patterns, correlated basins | Set by the mask per context | Prestructured, convex, equal-sized |
| Capacity claim | Maximal (K-S) but **not measured here** | `p_max ≈ kC/(a ln(1/a))` | ≈7–40× Hopfield, conditional on context | `∏_i K_i`, store grows logarithmically |
| What perturbation means | Small additive control signal moves the trajectory; "ghost attractors" | — | Context mask deletes minima | — |

---

## Connections

- **[[wiki/concepts/energy-based-models.md]]** — the empirical instance of the landscape-as-model claim at brain scale, and the source of two refinements: attractor orthogonality (K-S projector) as the capacity-optimal landscape geometry, and the `J = J^S + J^A` decomposition showing that asymmetry adds solenoidal flow *without* changing the energy landscape.
- **[[wiki/concepts/predictive-coding-free-energy.md]]** — the theory this model implements: attractors are priors, relaxation is posterior sampling, `β` is prior precision, and the learning rule is contrastive predictive coding — so "concepts are free-energy minima" gets its first measurement in a real nervous system.
- **[[wiki/concepts/population-geometry.md]]** — the same object seen as geometry rather than dynamics: the attractors are the principal axes of the population's state space, and they explain *more* held-out variance than PCs fitted to the data itself, which is the strongest available argument that the landscape is a mechanism and not a summary.
- **[[wiki/entities/dense-sequence-memory.md]]** — the complementary half: this page's `J^S` fixes the stationary distribution while its `J^A` supplies the circulating flow, which is exactly the symmetric-hold / asymmetric-transition split of `MixedNet`, now with the statement that the antisymmetric part is invisible to the energy function.
- **[[wiki/entities/context-modular-memory-network.md]]** — the rival route to the same target: raise usable capacity by *masking* one landscape per context (external control signal, capacity conditional on it) versus *orthogonalising* the stored states so no masking is needed.
- **[[wiki/entities/rolls-treves-hippocampal-model.md]]** — the microscale counterpart: an attractor network whose weights are derived from anatomy and whose capacity is computed, against one whose weights are measured from activity and whose capacity is only argued.
- **[[wiki/concepts/contextual-inference.md]]** — the disease and task results are the same claim in a different vocabulary: a condition is not a set of regional activations but a change in which basin the system occupies and how it flows between them.
- **[[wiki/concepts/simulation-based-planning.md]]** — supplies a scale for the control signal a policy over dynamics would need: SNR ≈ 0.005 injected in one region measurably redirects whole-brain trajectories, i.e. steering an attractor system is cheap relative to its intrinsic dynamics.
- **[[wiki/concepts/representation-probing.md]]** — adds a label-free structural probe to the instrument list: compare a trained network's attractors with the eigenvectors of its own coupling matrix, and compare its convergence time with a degree-preserving permutation of those couplings.
- **[[wiki/entities/hopfield-network.md]]** — the model this page instantiates at whole-brain scale with two substitutions: couplings measured (`J = −Σ⁻¹`) instead of Hebbian-written, and continuous states instead of bipolar ones; `β → ∞` here recovers the classical binary network exactly.
- **[[wiki/entities/boltzmann-machine.md]]** — the same Boltzmann steady-state form with the couplings *learned* by a two-phase contrastive rule rather than read off the inverse covariance; this page's stochastic relaxation is that page's sampler run on a landscape nobody trained, which is why the single-phase-vs-two-phase comparison of learning rules is stated in both places.
- **[[wiki/concepts/biologically-plausible-credit-assignment.md]]** — supplies the reason this page's rule can be single-phase: under the equilibrium-propagation frame a free-energy network's *free* phase already sits at the global minimum, so the anti-Hebbian term of a contrastive rule is identically zero — the single-phase property is derived from which energy is minimised, not from a different rule (Whittington & Bogacz 2019).
