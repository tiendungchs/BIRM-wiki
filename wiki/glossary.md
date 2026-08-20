# Glossary

Abbreviations used across the wiki. Per the schema, terms are expanded in place on first use *unless* they are near-universal (AI, ML, NN, DNA) or unwieldy — those live here.

## Machine learning

| Abbrev. | Expansion | Note |
|---|---|---|
| PCA | Principal Component Analysis | Projection onto the leading eigenvectors of the input correlation matrix; the fixed point of plain Hebbian learning on a linear unit, and of a Hebbian layer with lateral inhibition ([[wiki/concepts/synaptic-plasticity.md]]) |
| BHN | Binary Hopfield Network | The classical bipolar-state network with symmetric weights and asynchronous threshold updates ([[wiki/entities/hopfield-network.md]]) |
| CAM | Content-Addressable Memory | A store retrieved by (part of) its contents rather than by an address; the Hopfield network is the standard model and [[wiki/entities/btsp-cam.md]] the binary-weight, non-recurrent alternative |
| CHN | Continuous Hopfield Network | Float-valued states; exponential capacity and one-step convergence, and the update is transformer self-attention (Ramsauer et al. 2020) |
| MHN | Modern Hopfield Network (Dense Associative Memory) | Hopfield network with a steep nonlinearity applied to the state–pattern overlap, giving polynomial or exponential item capacity ([[wiki/entities/dense-sequence-memory.md]]) |
| BM / RBM | Boltzmann Machine / Restricted Boltzmann Machine | Stochastic Hopfield network with hidden units, trained contrastively; *restricted* = bipartite visible↔hidden only, which makes whole layers updatable in parallel ([[wiki/entities/boltzmann-machine.md]]) |
| GPI | Generalized PseudoInverse rule | Decorrelates stored patterns inside the separation function, `Σ_ν O⁺_{μν} m^ν`; perfect sequence recall for linearly independent patterns ([[wiki/entities/dense-sequence-memory.md]]) |
| TAN | Temporal Association Network | Sompolinsky & Kanter 1986: symmetric "fast synapse" hold term plus asymmetric "slow synapse" transition term, capacity `≈0.1N`; the linear special case of the `MixedNet` |
| AIT | Algorithmic Information Theory | Kolmogorov complexity and its relatives; the formal language of both [[wiki/concepts/universal-induction.md]] and [[wiki/concepts/skill-acquisition-efficiency.md]] |
| LSA | Latent Semantic Analysis | Word meaning from a factorised document co-occurrence matrix; read here as a retrieved-context model of semantic learning |
| DSL | Domain-Specific Language | A restricted program space to search over; ARC's proposed solver hard-codes core-knowledge priors as one |
| LoT | Language of Thought | The claim that thought is conducted in recursively combinable typed expressions with a compositional semantics ([[wiki/concepts/language-of-thought.md]]) |
| PLoT | Probabilistic Language of Thought | LoT with a distribution over expressions, so concept learning is posterior inference over sentences of the internal language ([[wiki/concepts/language-of-thought.md]]) |
| GD | Generalization Difficulty | `H(Sol^θ_T \| TrainSol^opt_{T,C}) / H(Sol^θ_T)` — how far the shortest curriculum-optimal program must be edited to work at evaluation |
| AIXI | AI with (X) Induction (I) | Hutter's uncomputable universal agent; the formal ceiling ([[wiki/entities/aixi.md]]) |
| AIXItl | AIXI bounded to length `l̃` and per-cycle time `t̃` | Computable reduction of AIXI; dominates all self-certifying policies within those bounds |
| AIµ | The same agent with the *true* environment prior `µ` | Plain expectimax; optimal by construction, and the reference AIXI is measured against |
| CLS | Complementary Learning Systems | Fast hippocampal / slow cortical memory pair; also the name of the theory |
| Go-CLS | Generalization-Optimized Complementary Learning Systems | Sun et al. 2023's theory: consolidate a relation only while transport lowers generalization error |
| SNR | Signal-to-Noise Ratio | In Go-CLS, `σ_w²/σ_ε²` of the environment's mapping — the wiki's operational definition of a relation's *predictability* |
| CNN | Convolutional Neural Network | |
| AR | Activation Relaxation | Credit-assignment scheme whose equilibrium activations *are* the backpropagation gradients ([[wiki/concepts/biologically-plausible-credit-assignment.md]]) |
| DFA | Direct Feedback Alignment | Output error wired straight to every hidden layer |
| TP | Target Propagation | Credit assignment by propagating layerwise *targets* through learned inverses instead of gradients ([[wiki/concepts/biologically-plausible-credit-assignment.md]]) |
| DTP | Difference Target Propagation | TP plus a linear reconstruction-error correction; the published version still backpropagates through the penultimate layer |
| SDTP | Simplified Difference Target Propagation | DTP with that last gradient removed — fully gradient-free and weight-transport-free (Bartunov et al. 2018) |
| AO-SDTP | Auxiliary-Output SDTP | SDTP whose output layer carries extra random features of the penultimate layer, to raise target diversity |
| LC | Locally-Connected (layer) | Convolution-style receptive fields **without** weight sharing; the biologically defensible version of a convnet |
| DNC | Differentiable Neural Computer | Controller + external memory matrix addressed by content, write-order links and a usage-based free list, trained end to end ([[wiki/entities/differentiable-neural-computer.md]]). **Collision:** Arnsten et al. 2010 use DNC for *Dynamic Network Connectivity*; this wiki spells that one out ([[wiki/concepts/dynamic-network-connectivity.md]]) |
| NTM | Neural Turing Machine | The DNC's predecessor: same controller/memory split, but addressing is content plus index-shift, with no de-allocation and no write-order record across address jumps |
| bAbI | (not an abbreviation) | 20 synthetic question-answering tasks over short generated stories, each a set of constraints on an underlying graph; the DNC's language benchmark |
| DAGGER | Dataset Aggregation | Imitation-learning scheme mixing the expert and the learner's own policy so training states match the states the learner will actually visit |
| DNN | Deep Neural Network | |
| DQN | Deep Q-Network | Deep RL agent for Atari; origin of experience replay in deep RL |
| DRAW | Deep Recurrent Attentive Writer | Attentional generative model that builds an image incrementally |
| DRL | Deep Reinforcement Learning | |
| e-prop | Eligibility Propagation | Forward-only local credit assignment for spiking networks |
| ENU | Evolvable Neural Unit | Evolved somatic/synaptic compartment model with gated update dynamics |
| EBM | Energy-Based Model | A scalar compatibility function `F(x,y)` treated as fundamental, with no normalisation ([[wiki/concepts/energy-based-models.md]]) |
| EWC | Elastic Weight Consolidation | Fisher-weighted quadratic penalty protecting important weights |
| FA | Feedback Alignment | Fixed random backward weights in place of the forward transpose |
| NGRAD | Neural Gradient Representation by Activity Differences | Lillicrap et al. 2020's claim that every local approximation to backpropagation encodes gradients as activity differences; disputed in [[wiki/empirical-tensions.md]] T70 |
| GAN | Generative Adversarial Network | Contrastive EBM in which the contrastive samples come from a trainable generator |
| H-JEPA | Hierarchical JEPA | JEPAs stacked so higher levels predict further ahead on coarser representations ([[wiki/entities/h-jepa.md]]) |
| HiT-JEPA | Hierarchical Interactions of Trajectory Semantics via a JEPA | The first trained JEPA stack; levels differ in sequence *resolution* rather than prediction horizon ([[wiki/entities/hit-jepa.md]]) |
| H3 | Hexagonal Hierarchical Geospatial Indexing System (Uber) | Multi-resolution hexagonal tiling of the globe; the input tokeniser in [[wiki/entities/hit-jepa.md]] |
| IC / TC | Intrinsic Cost / Trainable Critic | The immutable and learned halves of LeCun 2022's cost module |
| InfoNCE | Information Noise-Contrastive Estimation | The standard multi-sample contrastive loss |
| i.i.d. | independent and identically distributed | Train and test drawn from the same distribution; the assumption behind standard benchmarking |
| JEA | Joint Embedding Architecture | Two encoders, energy = distance between their outputs |
| JEPA | Joint Embedding Predictive Architecture | JEA plus a predictor from `s_x` to `s_y`, optionally latent-conditioned; non-generative |
| KL | Kullback–Leibler divergence | `KL(P‖Q) = H(P,Q) − H(P)` — the surprise due purely to a wrong model, asymmetric in its arguments ([[wiki/concepts/divergence-objectives.md]]) |
| K(x) | Kolmogorov complexity | Length of the shortest program printing `x` |
| LGD | Latent Graph Discovery | The wiki's core problem framing |
| LSTM | Long Short-Term Memory | Gated recurrent architecture |
| STSP | Short-Term Synaptic Plasticity | Transient (<1 s) activity-induced change in synaptic efficacy — the Tsodyks–Markram `u`/`a` variables; the carrier of an activity-silent memory ([[wiki/entities/stsp-working-memory-rnn.md]], [[wiki/entities/stp-flickering-cann.md]]) |
| RPE | Reward Prediction Error | Received minus expected reward; the signal phasic dopamine is standardly read as carrying, and in [[wiki/entities/meta-rl-agent.md]] also a candidate network *input* |
| PFN | Prefrontal Network | Wang et al. 2018's name for prefrontal cortex plus the striatal and mediodorsal-thalamic nodes it loops with, modelled as one recurrent network ([[wiki/entities/meta-rl-agent.md]]) |
| UCB | Upper Confidence Bound | Optimism-under-uncertainty bandit algorithm; one of the baselines the frozen-weight meta-RL inner learner matches |
| MUA | Multi-Unit Activity | Spiking pooled across the neurons near one electrode, without spike sorting |
| GRU | Gated Recurrent Unit | Gated recurrent architecture with one fewer gate than LSTM; the gradient-trained baseline in [[wiki/entities/hag-reservoir.md]] |
| RC | Reservoir Computing | Map an input stream through a fixed random recurrent network and train only a linear readout ([[wiki/entities/hag-reservoir.md]]) |
| ESN | Echo State Network | The discrete-time rate-based instance of RC; `x[t+1] = σ(Wx[t] + W_in u[t] + b)` with only `W_out` trained |
| HAG | Hebbian Architecture Generation | Grows an ESN's recurrent edges from an empty matrix by homeostasis-gated long-window correlation (Cazalets et al. 2025) |
| IP | Intrinsic Plasticity | Per-neuron gain/bias adaptation toward a target output distribution; the standard plastic-reservoir baseline |
| CEVD | Cumulative Explained Variance Dimensionality | Fewest principal components reaching a variance threshold (0.9); a *linear* effective-dimensionality estimate, subject to the curvature caveat in [[wiki/concepts/population-geometry.md]] |
| NRMSE | Normalized Root Mean Square Error | Forecasting error metric |
| LVEBM | Latent-Variable Energy-Based Model | `F(x,y) = min_z E(x,y,z)`; the latent parameterises which relationship holds |
| MCTS | Monte Carlo Tree Search | Forward search used to improve a value function or policy |
| BIC | Bayesian Information Criterion | Model comparison score penalising parameter count; the COIN-vs-dual-rate comparison is reported as ΔBIC in nats ([[wiki/entities/coin-model.md]]) |
| COIN | COntextual INference | Heald et al. 2021's nonparametric Bayesian model of motor learning ([[wiki/entities/coin-model.md]]) |
| DP | Dirichlet Process | Prior over distributions with an unbounded number of components; the "sticky" variant biases self-transition |
| GEM | Griffiths–Engen–McCloskey distribution | The stick-breaking construction generating the global mixing weights of a hierarchical Dirichlet process |
| HDP | Hierarchical Dirichlet Process | Dirichlet processes sharing a common base measure, so components are shared across groups; supplies the two-level split in [[wiki/concepts/contextual-inference.md]] |
| SMC | Sequential Monte Carlo | Particle filtering; COIN's inference scheme ("particle learning") is an instance |
| MDL | Minimum Description Length | Total code length = model description + data-given-model; the *adjusted* compression rate in [[wiki/concepts/prediction-compression-equivalence.md]] is this two-part code |
| BPE | Byte-Pair Encoding | Sub-word tokenizer built by iteratively merging frequent byte pairs; a lossless pre-compressor sitting in front of the model |
| MPC | Model-Predictive Control | Plan over a horizon, execute the first action, replan (receding horizon) |
| meta-RL | Meta-Reinforcement Learning | Outer RL over tasks producing a second RL algorithm in recurrent activity |
| o.o.d. | out-of-distribution | Test data systematically different from training data; the only regime that separates a shortcut from the intended rule |
| PDP | Parallel Distributed Processing | 1980s movement; origin of distributed representations in cognitive modelling |
| RL | Reinforcement Learning | |
| RNN | Recurrent Neural Network | |
| SNN | Spiking Neural Network | Binary, time-located events instead of real-valued rates |
| SP / CF / FM / EX | Sequence Prediction / Classification / Function Minimization / supervised learning by EXamples | Hutter 2000's problem classes; the first two are passive, the last two active |
| SS | Sign-Symmetry | Feedback weights random in magnitude, sign-matched to the forward weights |
| SSL | Self-Supervised Learning | Training on dependencies within the input; here, pattern completion of unobserved parts |
| TD | Temporal Difference (learning) | Learns from successive predictions rather than final outcomes |
| BPTT | Backpropagation Through Time | Credit assignment in recurrent nets by unrolling; truncation length bounds the gradient horizon, not necessarily the model's memory |
| ELBO | Evidence Lower Bound | The variational objective maximised in place of the intractable log-likelihood |
| VAE / VQ-VAE | Variational / Vector-Quantized Auto-Encoder | Noise- and quantisation-based latent-capacity regularisers |
| VICReg | Variance-Invariance-Covariance Regularization | Non-contrastive JEPA criterion: variance hinge per component + covariance decorrelation, applied to each branch separately ([[wiki/entities/vicreg.md]]) |
| ξ | Universal semimeasure | `Σ_p 2^-l(p)` over programs producing the observed string; dominates every enumerable semimeasure |
| SR | Successor Representation | Discounted expected future state occupancy, `S = ΣγⁿTⁿ`; value is `Sr` ([[wiki/concepts/successor-representation.md]]) |
| DR | Default Representation | SR-like representation built for default behaviour and linearly updatable when rewards change; from linear RL |
| CSCG | Clone-Structured Cognitive Graph | Hidden Markov model with a frozen clone pool per observation ([[wiki/entities/cscg.md]]) |
| TEM | Tolman-Eichenbaum Machine | Path-integrating structural code plus relational memory ([[wiki/entities/tolman-eichenbaum-machine.md]]) |
| TEM-t | TEM-transformer | TEM rewritten as a transformer with recurrent, action-generated position encodings ([[wiki/entities/tem-transformer.md]]) |
| SMP | Spatial Memory Pipeline | TEM's sibling, trained from egocentric pixels with a machine-learning memory network |
| RC | Recurrent Collateral | The CA3→CA3 axon collaterals, ~1.2×10⁴ per neuron in rat, the substrate of the autoassociative attractor ([[wiki/entities/rolls-treves-hippocampal-model.md]]) |
| mf / pp | Mossy Fibre / Perforant Path | Dentate→CA3 write path (~46 per CA3 cell, strong, randomizing) and entorhinal→CA3 read path (~3,600, weak, generalizing) |
| CANN | Continuous Attractor Neural Network | Recurrent network whose weights support a continuum of stable states; the classical path-integration substrate ([[wiki/concepts/attractor-dynamics.md]]) |
| GCQ | Grid-like Code Quantization | Vector quantisation whose codebook is a CANN's bump-attractor set and whose codeword is selected by the action sequence, compressing space and time jointly ([[wiki/entities/gcq.md]]) |
| GC | Grid-like Code | Periodic bump-patterned population activity used as a general-purpose code, in entorhinal cortex and beyond ([[wiki/concepts/path-integration.md]]) |
| STE | Straight-Through Estimator | Copy the gradient across a non-differentiable discrete step (quantisation) as if it were the identity |
| FSQ | Finite Scalar Quantization | VQ-VAE with a *predefined*, non-learned codebook obtained by per-dimension scalar rounding ([[wiki/empirical-tensions.md]] T150) |
| FID / FVD | Fréchet Inception / Video Distance | Distance between feature distributions of generated and real images / videos; the standard generative-fidelity metric |
| PSNR | Peak Signal-to-Noise Ratio | Pixel-level reconstruction fidelity, in decibels |
| A-CANN | Adaptive Continuous Attractor Neural Network | CANN plus a slow negative-feedback adaptation current `τ_v dV/dt = −V + mU`; `m > τ/τ_v` destabilises the bump into a travelling wave ([[wiki/entities/adaptive-cann.md]]) |
| SFA | Spike-Frequency Adaptation | Slow activity-dependent hyperpolarising current that suppresses a neuron's own sustained firing; the adaptation substrate in A-CANN |
| STD | Short-Term Depression | Activity-dependent depletion of releasable synaptic resources; the presynaptic alternative to SFA as an adaptation mechanism |
| STP | Short-Term Plasticity | Activity-dependent, seconds-scale modulation of synaptic efficacy `u·x` (Tsodyks–Markram); facilitation `τ_f` and depression-recovery `τ_r`, with `τ_f > τ_r` producing a post-activity rebound ([[wiki/entities/stp-flickering-cann.md]]) |
| LFP | Local Field Potential | The low-frequency extracellular signal from which theta phase and power are estimated |
| VCO | Velocity-Coupled Oscillator | Path integration by phase interference between theta and velocity-modulated dendritic oscillations |
| EM | Expectation-Maximisation | Alternating latent-inference / parameter-update algorithm; how CSCG is trained |
| DoG / DoS | Difference-of-Gaussians / Difference-of-Softmaxes | Centre–surround readout target functions in deep grid-cell models; DoS (used in code, DoG in text) is what actually produces lattices, because the readout correlation matrix plays the role of the attractor interaction kernel ([[wiki/concepts/objective-identifiability.md]]) |
| PI | Path Integration | Updating a position estimate by integrating self-motion ([[wiki/concepts/path-integration.md]]) |
| PR | Participation Ratio | Linear measure of a representation's intrinsic dimensionality; correlates with linear "neural predictivity" of neural data, which may confound model-brain comparisons |
| fcANN | functional connectivity-based Attractor Neural Network | Whole-brain Hopfield network whose couplings are the negative inverse covariance of regional fMRI time series ([[wiki/entities/fcann.md]]) |
| FEP-ANN | Free-Energy-Principle Attractor Neural Network | Class of attractor networks derived from free-energy minimisation; its learning rule drives attractors toward orthogonality ([[wiki/concepts/predictive-coding-free-energy.md]]) |
| K-S network | Kanter–Sompolinsky projector network | Attractor network with mutually orthogonal stored states, equal to the positive-eigenvalue eigenvectors of the coupling matrix; maximal capacity, error-free recall ([[wiki/concepts/energy-based-models.md]]) |
| MCMC | Markov-Chain Monte Carlo | Sampling from a distribution by a stochastic transition chain; stochastic attractor relaxation is read as MCMC over the posterior ([[wiki/entities/fcann.md]]) |
| NESS | Non-Equilibrium Steady State | Stationary distribution maintained by circulating (solenoidal) probability flow; what asymmetric couplings produce |
| SLAM | Simultaneous Localization And Mapping | Building a map while self-localizing in it; solved by trained recurrent networks without grid units emerging |
| dANN | dendritic Artificial Neural Network | Feedforward net with a fixed dendrite→soma tree mask and restricted input sampling ([[wiki/entities/dendritic-ann.md]]) |
| vANN / sANN / pdANN | vanilla / sparse / partly-dendritic ANN | dANN's controls: fully connected, randomly sparse, and tree-structured-but-fully-sampled-input |
| LRF / GRF | Local / Global Receptive Field | dANN input-sampling rules: receptive-field centre drawn per dendrite (LRF, best-performing) or per soma (GRF) |
| eHebb | error-based Hebbian plasticity | `ΔW_{ℓ−1,ℓ} ∝ −e_ℓ e_{ℓ−1}ᵀ` — outer product of post- and pre-synaptic *error* signals rather than activations; drives forward weights toward the transpose of fixed random feedback (Shervani-Tabar & Rosenbaum 2023) |
| MLP | Multi-Layer Perceptron | Plain fully-connected feedforward stack; the default comparator or head in most architectures here |
| KAN | Kolmogorov-Arnold Network | Learnable univariate activation functions on the *edges* summed at the nodes, in place of fixed activations with learnable node weights; the basis of [[wiki/entities/kan-ode.md]] |
| KAT | Kolmogorov-Arnold representation Theorem | `f(x) = Σ_q Φ_q(Σ_p φ_{q,p}(x_p))` — every continuous multivariate function is a finite composition of univariate ones; the KAN's licence, as the universal approximation theorem is the MLP's |
| Neural ODE | Neural Ordinary Differential Equation | A network used as a gradient-getter, `du/dt = NN(u,t)`, integrated by a standard ODE solver with gradients taken by the adjoint method; makes a dynamics model continuous-time and grid-agnostic |
| RBF | Radial Basis Function | `ψ(r) = exp(−r²/2h²)` on a grid of centres; the basis used in place of B-splines in the KAN-ODE implementation |
| SINDy | Sparse Identification of Nonlinear Dynamics | Sparse regression of a system's derivative onto a hand-supplied library of candidate functions; interpretable within the library and blind outside it |
| PINN | Physics-Informed Neural Network | Puts the known governing equations in the loss as a soft constraint; interpretable, but requires the governing law up front |
| GNN | Graph Neural Network | Message-passing network over an explicit node/edge set; the backbone of [[wiki/entities/neuromatch.md]] |
| GIN | Graph Isomorphism Network | The maximally expressive message-passing GNN under the Weisfeiler-Lehman test; the ceiling NeuroMatch's identity injection is designed to exceed |
| GraphSAGE | Graph SAmple and aggreGatE | Inductive GNN layer: a *learned aggregator* over sampled neighbours, so embeddings can be produced for nodes unseen during training — the property [[wiki/entities/irene.md]] credits for handling evaluation-set entities |
| BIB | Baby Intuitions Benchmark | Gridworld videos of agents pursuing objects, 8 familiarisation trials + 1 paired plausible/implausible test trial, built from infant expectations ([[wiki/entities/hbtom.md]], [[wiki/entities/irene.md]]) |
| VoE | Violation of Expectation | Developmental paradigm scored here as: does the model's prediction error rise more on the implausible continuation than on the plausible one? Free parameter — which moment of the error trace counts ([[wiki/empirical-tensions.md]] T146) |
| MDP / POMDP | (Partially Observable) Markov Decision Process | State–action–reward formalism, with *partially observable* meaning the agent sees an observation rather than the state — the setting every navigation task in the wiki actually sits in |
| PDDL | Planning Domain Definition Language | Hand-written symbolic action schemas (preconditions, effects); the form in which [[wiki/entities/hbtom.md]]'s environment dynamics are *supplied* rather than learned ([[wiki/empirical-tensions.md]] T21) |
| SSM / RSSM | (Recurrent) State-Space Model | A latent-dynamics world model: `p(z_t\|z_{t-1},a_{t-1})` plus `p(x_t\|z_t)`, trained on the ELBO; the recurrent variant (PlaNet, Dreamer) is what makes latent-space rollout possible without decoding each step |
| PPDDL | Probabilistic PDDL | PDDL with stochastic action effects; the target language DeepSym's distilled decision tree emits ([[wiki/concepts/affordance-grounded-symbols.md]]) |
| AUROC | Area Under the Receiver Operating Characteristic curve | Ranking metric on balanced samples; disputed as a retrieval measure because it hides class skew ([[wiki/empirical-tensions.md]] T22) |
| TPR / FPR | True / False Positive Rate | Detection rates; the pair AUROC summarises and precision does not follow from |
| BFS | Breadth-First Search | Uninformed shortest-path search; the query-generation procedure in NeuroMatch's training set and a cost signal read out of lateral prefrontal cortex ([[wiki/concepts/cognitive-map.md]]) |
| CMAC | Cerebellar Model Articulation Controller | Albus 1971: a sparse-distributed store with *error-gated* writing, `ΔC = g(p̂_u − s_u)/K` applied only when the retrieval error exceeds tolerance ([[wiki/entities/sparse-distributed-memory.md]]) |
| SDM | Sparse Distributed Memory | Kanerva's random-address store; capacity `τ ≈ 0.10·M`, per-read confidence `\|s_u\|` ([[wiki/entities/sparse-distributed-memory.md]]) |
| ReLU | Rectified Linear Unit | `max(0, x)`; the nonlinearity the predictive-coding energy's projected-gradient dynamics project onto ([[wiki/concepts/energy-based-models.md]]) |
| UMAP | Uniform Manifold Approximation and Projection | Nonlinear dimensionality reduction used to visualise population state spaces; a *display*, not a measurement — the wiki's geometric claims rest on CCGP/PS instead ([[wiki/concepts/population-geometry.md]]) |
| PGD | Projected Gradient Descent | Gradient step followed by projection back onto a constraint set; the nudged-phase dynamics of a predictive-coding network are PGD with step size 1 ([[wiki/concepts/energy-based-models.md]]) |
| VF2 / FastPFP / IsoRankN / MFinder | (algorithm names, not abbreviations) | Classical exact or approximate subgraph-matching and network-alignment algorithms; the combinatorial baselines that [[wiki/entities/neuromatch.md]] amortises away ([[wiki/concepts/subgraph-matching.md]]) |
| STA | Spacetime Attractor | One attractor population per future timestep, so a whole trajectory is represented at once ([[wiki/entities/spacetime-attractor.md]]) |
| TRNN | Transient Recurrent Neural Network | RNN whose delay-period activity decays to baseline while the memory survives in short-term synaptic state ([[wiki/entities/trnn.md]]) |
| BPL | Bayesian Program Learning | Concept learning by inferring a generative program with reusable parts ([[wiki/entities/bayesian-program-learning.md]]) |
| HaSH | (Vector) Hippocampal Scaffolded Heteroassociative Memory | Prestructured grid-module scaffold plus heteroassociative binding, giving exponential capacity with provably convex basins ([[wiki/entities/vector-hash.md]]) |
| EFE | Expected Free Energy | The active-inference objective over policies: a linear reward term plus one convex term whose gradient is curiosity ([[wiki/concepts/expected-free-energy.md]]) |
| FFG | Forney-style Factor Graph | Factor-graph convention in which nodes are factors and edges are variables; the representation in which each entropy correction to expected free energy becomes a local rewrite of one factor kernel ([[wiki/concepts/expected-free-energy.md]]) |
| BP / VBP | Belief Propagation / Value Belief Propagation | Sum-product message passing on a factor graph; VBP is the variant carrying the planning entropy correction `+Σ_t H[q(u_t\|x_{t-1})]`, i.e. cross-entropy planning ([[wiki/concepts/expected-free-energy.md]]) |
| VFE | Variational Free Energy | The perceptual-inference objective — an upper bound on surprise, minimised over beliefs about the current state ([[wiki/concepts/predictive-coding-free-energy.md]]) |
| PBWM | Prefrontal Cortex / Basal Ganglia Working Memory | O'Reilly & Frank's model in which basal-ganglia Go/NoGo gating learns the *write policy* of a prefrontal store ([[wiki/entities/pbwm.md]]) |
| Go / NoGo | (striatal pathway names) | The direct (Go) and indirect (NoGo) striatal pathways; in [[wiki/entities/pbwm.md]] they are the two learned votes on whether a stripe is updated |
| PVLV | Primary Value, Learned Value | PBWM's dopamine model: two Rescorla–Wagner systems (`PVe/PVi`, `LVe/LVi`) that reproduce the dopamine firing record with no temporal-difference prediction chain |
| 1-2-AX | (task name) | Hierarchical working-memory task: an outer digit cue selects which of two inner letter sequences (A→X or B→Y) is the target — the wiki's standard test that a store can hold two nested contexts ([[wiki/entities/pbwm.md]]) |
| HRL | Hierarchical Reinforcement Learning | Reinforcement learning over temporally extended actions rather than primitive ones; the framework [[wiki/concepts/temporal-abstraction-options.md]] formalises as options |
| PPO | Proximal Policy Optimization | The standard clipped-surrogate policy-gradient baseline; on this wiki it is the *flat, primitive-action* control that hierarchical agents are scored against |
| CKA | Centered Kernel Alignment | A similarity measure between two representations that needs no unit correspondence, so it compares models with disjoint architectures ([[wiki/concepts/representation-probing.md]]) |
| HMM | Hidden Markov Model | Discrete latent state with a stochastic transition matrix; the rung of the agent ladder between a plain autoencoder and a full transition model, and the generative form [[wiki/entities/cscg.md]] refines with cloning |
| SVM | Support Vector Machine | Max-margin linear classifier; the standard decoder used as a probe when the question is whether a variable is *linearly* readable from a population |
| SOM | Self-Organizing Map | Kohonen's topographic quantiser — neighbouring units come to code neighbouring inputs; the classical unsupervised route to a metric-preserving code. **Not** to be confused with `Sst`/somatostatin interneurons in the neuroscience section |
| WL | Weisfeiler–Leman test | The graph-isomorphism colour-refinement heuristic that bounds the expressivity of message-passing graph networks; the ceiling [[wiki/concepts/subgraph-matching.md]] anchoring is claimed to lift |
| LRAS | Local Random Access Sequence modeling | Autoregressive modeling over *locally quantised* RGB and optical-flow patches where each content token is paired with a **pointer** token naming its spatial location, so the sequence can be assembled in any order and a sparse localised intervention is two appended tokens; the backbone of [[wiki/entities/spelkenet.md]] |
| SAM / SAM2 | Segment Anything Model | The supervised point-promptable segmentation baseline; its ontology is visual distinctiveness, which is why it segments logos, shadows and sub-parts that never move independently |
| CWM | Counterfactual World Model | Bear et al.'s regression-trained video predictor probed by copying an RGB patch to a new location in a masked target frame; the deterministic predecessor of statistical counterfactual probing, and the source of its blur failure ([[wiki/concepts/counterfactual-probing.md]]) |
| AR / AP / EA | Average Recall / Average Precision / Edit Adherence | Segmentation and editing metrics: fraction of ground-truth segments detected, fraction of predicted segments matched (both averaged over Intersection-over-Union thresholds 0.5–0.99), and the Intersection-over-Union between predicted and ground-truth segments *in the edited image* |
| Otsu's method | — | Threshold chosen to maximise between-class variance of an observed histogram; the one *derived* rather than hand-set threshold among the wiki's discretisation mechanisms |
| RRAM / MRAM | Resistive / Magnetoresistive Random-Access Memory | Non-volatile in-memory-compute substrates; the hardware assumption behind the neuromorphic cost arguments ([[wiki/entities/spiking-neural-networks.md]], [[wiki/entities/hami.md]]) |

| qrel | Query relevance judgments | The binary matrix `A ∈ {0,1}^{m×n}` saying which documents are relevant to which query; its sign-rank lower-bounds the embedding dimension needed to realize it |
| sign-rank | — | The smallest rank of a real matrix whose entries match the signs of a given ±1 matrix; the no-margin version of the retrieval dimension bound |
| BM25 | Best Matching 25 | The standard sparse lexical retrieval score; a very high-dimensional sparse vector, which is why it escapes the dense-embedding dimension bound and why it collapses under synonym substitution |
| MaxSim | Maximum Similarity | The late-interaction operator of multi-vector retrievers (ColBERT): score a pair by summing, over query tokens, the max similarity to any document token |
| MRL | Matryoshka Representation Learning | Training so that truncated prefixes of an embedding remain usable, which is how deployed vectors are shrunk below their native dimension |

## Neuroscience

| Abbrev. | Expansion | Note |
|---|---|---|
| CHC | Cattell-Horn-Carroll theory | The dominant hierarchical model of human cognitive abilities: `g` factor → broad abilities → task-specific skills; maps onto extreme / broad / local generalization |
| Gf / Gc | Fluid / Crystallized intelligence | Cattell 1971: skill-acquisition ability vs. accumulated knowledge. ARC targets Gf only |
| IRT / CTT | Item Response Theory / Classical Test Theory | Psychometric standards for reliability and validity that Chollet 2019 imports into AI evaluation |
| CS / US | Conditioned Stimulus / Unconditioned Stimulus | Conditioning terminology; second-order conditioning motivated TD learning |
| fMRI | functional Magnetic Resonance Imaging | |
| BOLD | Blood-Oxygen-Level-Dependent | The fMRI contrast; driven more by perisynaptic activity than by spiking, which is why it cannot resolve dentate gyrus from CA3 ([[wiki/concepts/pattern-separation-completion.md]]) |
| DG | Dentate Gyrus | Sparse-firing granule-cell layer receiving entorhinal input; the hippocampus's pattern separator, and the only site of adult neurogenesis in the hippocampus |
| CA1 / CA3 | Cornu Ammonis fields 1 and 3 | CA3 is the recurrent auto-associative field (pattern completion), with *diluted* recurrence (~2–4%); CA1 carries hippocampal output — as a linear relay (Yassa & Stark 2011) or as a competitive recombination stage (Rolls 2013), [[wiki/empirical-tensions.md]] T33 |
| NREM / SWS | Non-Rapid-Eye-Movement sleep / Slow-Wave Sleep | The deep, non-dreaming sleep stages; SWS is the deepest (stages 3–4), the window in which sharp-wave-ripple replay and slow oscillations coincide |
| SWA | Slow-Wave Activity | EEG spectral power in the 0.8–4.6 Hz band during slow-wave sleep, maximal over prefrontal derivations; the variable that predicts overnight memory retention and whose generator is medial prefrontal cortex ([[wiki/concepts/complementary-learning-systems.md]]) |
| PSG | PolySomnoGraphy | Overnight recording of EEG, eye movements and muscle tone used to stage sleep |
| SWR | Sharp-Wave/Ripple | Large-amplitude hippocampal local-field deflection with a nested high-frequency oscillation, during immobility and sleep; the window in which offline sequence reactivation and offline edge construction occur ([[wiki/concepts/offline-replay.md]]) |
| dCA1 | dorsal CA1 | The dorsal (septal) portion of hippocampal field CA1 — the standard rodent recording and optogenetic target for spatial and relational tasks |
| mPFC | medial PreFrontal Cortex | Frontal region carrying abstract task models; represents the inferred outcome in the sensory-preconditioning task (Barron et al. 2020) |
| EC | Entorhinal Cortex | The hippocampus's main cortical input/output; layer II projects to both DG and CA3, and carries the grid code ([[wiki/concepts/abstract-structural-codes.md]]) |
| CREB | cAMP-Responsive Element-Binding protein | Transcription factor phosphorylated for hours after learning or LTP; raises cell-wide excitability by reducing K⁺ conductance and thereby biases which neurons are allocated to a memory ([[wiki/concepts/memory-allocation-excitability.md]]) |
| AHP | After-HyperPolarization | K⁺-mediated dip in membrane potential following a spike train; its size sets spike-frequency adaptation, and shrinking it is how CREB raises excitability |
| ERK | Extracellular signal-Regulated Kinase | Kinase activated at a potentiated synapse (via synGAP/Ras downstream of CaMKII) that diffuses from dendrite to soma — the dendritic arm of the two-pathway CREB gate |
| CaMKII / CaMKIV | Ca²⁺/calmodulin-dependent protein Kinase II / IV | II sustains the LTP cascade at the synapse; IV phosphorylates CREB in the nucleus downstream of somatic action potentials — the somatic arm of the same gate |
| IEG | Immediate-Early Gene | Activity-dependent genes (e.g. Arc) whose expression maps which neurons were recently active — a population-level imaging method |
| NMDAR | N-methyl-D-aspartate Receptor | Coincidence-detecting glutamate receptor; its NR1 subunit is the standard knockout target for testing plasticity-dependence of a computation |
| NMDA spike | N-methyl-D-aspartate spike | Regenerative dendritic event triggered by 8–20 co-active synapses clustered within 20–300 µm and 1–5 ms; depolarizes the cell for 50–200 ms without necessarily firing it ([[wiki/concepts/dendritic-computation.md]]) |
| SDR | Sparse Distributed Representation | High-dimensional binary code with 0.5–3% of bits active; the regime in which subsampled overlap detection has closed-form, near-zero error ([[wiki/concepts/sparse-distributed-representations.md]]) |
| LIF | Leaky Integrate-and-Fire | Standard spiking-neuron model: membrane potential integrates input, spikes at threshold, resets |
| EPSP | Excitatory PostSynaptic Potential | Depolarizing voltage transient evoked by one presynaptic spike; its half-width (250 µs in the barn-owl model, 500–800 µs in chicken) sets the coincidence window of the receiving cell ([[wiki/concepts/temporal-coding.md]]) |
| EPSC | Excitatory PostSynaptic Current | The voltage-clamp counterpart of the EPSP; its amplitude in pA is the standard read-out of synaptic strength, and the variable spike-timing potentiation is measured to depend on — significant LTP essentially only below 500 pA ([[wiki/concepts/synaptic-plasticity.md]]) |
| d-AP-5 | d-2-Amino-5-PhosphonoValerate | NMDA-receptor antagonist; the standard pharmacological test that a plasticity effect is NMDA-dependent |
| ITD | Interaural Time Difference | Arrival-time difference of a sound at the two ears; the latent variable a coincidence detector over tuned delays recovers, and the barn owl's cue for azimuth |
| LTP / LTD | Long-Term Potentiation / Depression | Lasting strengthening / weakening of a synapse |
| cAMP | cyclic Adenosine MonoPhosphate | Second messenger; in prefrontal spines it opens HCN directly and KCNQ via protein kinase A, shunting the synapse — high cAMP disconnects the network and impairs working memory while *strengthening* long-term consolidation ([[wiki/concepts/dynamic-network-connectivity.md]]) |
| HCN | Hyperpolarization-activated Cyclic Nucleotide-gated channel | Cation channel opened directly by cAMP; located in prefrontal spine heads and necks, where it gates the synaptic input rather than setting somatic excitability |
| KCNQ (Kv7) | K-Channel voltage-gated, Q subfamily | K⁺ channel opened by protein kinase A downstream of cAMP; closed by muscarinic acetylcholine receptors (the "M-current"). A mutation preventing protein kinase A from opening KCNQ2/3 causes childhood epilepsy |
| SK channel | Small-conductance Ca²⁺-activated K⁺ channel | Negative feedback on recurrent excitation: NMDA Ca²⁺ opens it, which shunts the synapse. Blocking it (apamin) improves working memory |
| TRPC | Transient Receptor Potential Canonical channel | Depolarizing current that strengthens prefrontal network connections when cAMP is low |
| mGluR1/5 | metabotropic Glutamate Receptor 1/5 | Perisynaptic receptors engaged by glutamate spillover; Gq → IP₃ → intracellular Ca²⁺ → SK, i.e. a second negative-feedback route. Inhibited by RGS4 |
| RGS4 | Regulator of G-protein Signaling 4 | Perisynaptic brake on mGluR1/5–Gq signalling; markedly reduced in prefrontal cortex in schizophrenia and in Alzheimer's disease |
| PDE4 | PhosphoDiEsterase type 4 | Enzyme family hydrolysing cAMP; loss of activity lets cAMP build up and collapses prefrontal network firing. Activated by DISC1 |
| DISC1 | Disrupted In SChizophrenia 1 | Spine protein that activates PDE4 under high cAMP, co-localised with HCN channels; translocated in a large pedigree with high rates of mental illness |
| α2A-AR | alpha-2A Adrenergic Receptor | Norepinephrine receptor that inhibits cAMP production, closing HCN/KCNQ and strengthening prefrontal connections; its agonist guanfacine is used clinically for distractibility and poor impulse control |
| D1R | Dopamine D1 Receptor | Raises cAMP; moderate stimulation shunts inputs from dissimilarly tuned neurons (noise reduction), high stimulation suppresses all firing — the inverted-U |
| α7 nAChR | alpha-7 nicotinic Acetylcholine Receptor | Nicotinic receptor located directly on prefrontal spines beside the NMDA synapse; an agonist partially rescues ketamine-induced working-memory deficits |
| PKA / PKC | Protein Kinase A / C | A transduces cAMP (opens KCNQ); C is driven by Ca²⁺ and α1 adrenergic signalling under stress and is implicated in dendritic spine loss |
| MEG | Magnetoencephalography | |
| MTL | Medial Temporal Lobe | Hippocampus and surrounding cortex |
| TCM | Temporal Context Model | Howard & Kahana's drifting-context model of episodic recall, extended to the entorhinal place code ([[wiki/entities/temporal-context-model.md]]) |
| CRP | Conditional Response Probability | Probability of recalling an item at lag `+k`/`−k` from the one just recalled; the standard measure of temporal contiguity in free recall |
| DMS / DNMS | Delayed (Non-)Match to Sample | Recognition tasks over a delay; the animal analogue of a recency test |
| PFC | Prefrontal Cortex | |
| DBS | Deep Brain Stimulation | Chronic electrical stimulation through implanted electrodes; in psychiatry it is delivered continuously at 50–130 Hz and its mechanism is contested. Used in this wiki as the one *interventional* handle on the human control loop ([[wiki/concepts/cognitive-control.md]]) |
| VCVS | Ventral internal Capsule / Ventral Striatum | White-matter DBS target carrying prefrontal↔striatal fibres; the only psychiatric DBS site to pass blinded trials, in both depression and obsessive-compulsive disorder. Stimulating it raises task-induced prefrontal theta (Widge et al. 2019) |
| MSIT | Multi-Source Interference Task | Conflict task: report the digit that differs from its flankers, with a non-intuitive digit→button mapping on interference trials. The affective variant adds an emotionally arousing distractor image |
| MADRS | Montgomery–Åsberg Depression Rating Scale | Clinician-rated depression severity; response conventionally a 50% drop |
| YBOCS | Yale–Brown Obsessive–Compulsive Scale | Obsessive-compulsive symptom severity; response conventionally a 35% drop |
| SPN | Spiny Projection Neuron | GABAergic principal neuron of the striatum, ~90% of its cells; splits ~50/50 into a D₁-expressing direct-pathway and a D₂-expressing indirect-pathway population ([[wiki/entities/basal-ganglia.md]]) |
| GPe / GPi | Globus Pallidus, external / internal segment | Basal-ganglia relay (GPe, the indirect pathway's only striatal target) and output nucleus (GPi); both are autonomous pacemakers, which is what lets purely inhibitory striatal projections drive the output in both directions |
| SNr / SNc | Substantia Nigra pars Reticulata / pars compacta | SNr is the second, tonically inhibitory output nucleus (head and eye movements, where GPi handles axial and limb); SNc is the dopamine source innervating the striatum |
| D2R | Dopamine D2 Receptor | Gi/o-coupled, on indirect-pathway SPNs; inhibits adenylyl cyclase — under a dopamine transient it lowers excitability and biases glutamatergic synapses toward endocannabinoid-dependent LTD, the exact opposite of D1R on direct-pathway SPNs |
| A2a | Adenosine A2a Receptor | Gs-coupled, expressed on indirect-pathway SPNs, sharing D1R's cyclic AMP → protein kinase A → DARPP-32 cascade; supplies the LTP arm those cells cannot get from dopamine, so the two arms of striatal opponency have independent handles |
| eCB | Endocannabinoid | Anandamide and 2-arachidonylglycerol; generated postsynaptically, diffuse retrogradely to presynaptic CB1 receptors and cut glutamate release — the induction mechanism of striatal LTD |
| MEF2 | Myocyte Enhancer Factor 2 | Transcription factor dephosphorylated by calcineurin downstream of L-type Ca²⁺ entry; drives *Arc*/*Nur77* and the spine elimination that homeostatically cancels a sustained pathway imbalance |
| STN | SubThalamic Nucleus | Basal-ganglia node and DBS target; its stimulation *increases* impulsive responding under conflict, the opposite behavioural profile to VCVS ([[wiki/concepts/cognitive-control.md]]) |
| FEF | Frontal Eye Field | Prefrontal oculomotor area holding a retinotopic priority map; no object selectivity, earliest and largest spatial selection ([[wiki/concepts/priority-map.md]]) |
| VPA | Ventral PreArcuate cortex | Region forward of FEF on the prearcuate gyrus (likely areas 45A/12, possibly 46v); holds the search template and computes target–template similarity; proposed homologue of the human inferior frontal junction ([[wiki/concepts/priority-map.md]]) |
| VPS | Ventral bank of the Principal Sulcus | Adjacent prefrontal region; needed for switching the search template, not for applying a repeated one ([[wiki/concepts/priority-map.md]]) |
| V4 | Visual area 4 | Mid-level extrastriate area selective for colour, orientation and shape; carries both feature and spatial attentional gain, delivered by separately ablatable controllers ([[wiki/concepts/priority-map.md]]) |
| IT | InferoTemporal cortex | Late ventral-stream object-recognition cortex; object-selective but shows feature *selection* later (189 ms) than either frontal area |
| IFJ (IFJa / IFJp) | Inferior Frontal Junction (anterior / posterior subdivision) | Human region implicated in top-down control of object/feature-based attention (Baldauf & Desimone 2014); proposed homologue of macaque VPA; IFJp carries the preparatory template over a delay ([[wiki/concepts/priority-map.md]]) |
| PEF | Parietal Eye Field | Posterior IFJ-adjacent/parietal oculomotor parcel of the HCP-MMP1 atlas; carries delay-period template information and does not overlap the vLPFC parcel ([[wiki/concepts/priority-map.md]]) |
| FFA | Fusiform Face Area | Face-selective ventral-stream region; the face counterpart of PPA |
| dLPFC / vLPFC | dorsolateral / ventrolateral PreFrontal Cortex | Lateral prefrontal subdivisions; in cued search the dorsal one carries the cue identity and the ventral one the memory-retrieved associate ([[wiki/concepts/priority-map.md]]) |
| SPL / IPS | Superior Parietal Lobule / IntraParietal Sulcus | Dorsal parietal attention and working-memory regions; IPS is where the target identity is parked when the template holds a proxy ([[wiki/concepts/priority-map.md]]) |
| RF | Receptive Field | The region of the sensory surface a unit responds to |
| dva | degrees of visual angle | Standard unit of retinal eccentricity and stimulus size |
| HD cell | Head Direction cell | Fires as a function of head orientation in the navigational plane; the heading half of a cognitive map ([[wiki/concepts/cognitive-map.md]]) |
| PPA | Parahippocampal Place Area | Scene/landmark-selective region; perceptual identification of the local place or context |
| RSC | Retrosplenial Complex | Parieto-occipital-sulcus region (partly overlapping Brodmann area 29/30) that anchors the map: heading codes in local and global reference frames |
| OPA | Occipital Place Area | Scene region near the transverse occipital sulcus; boundaries and local navigational affordances |
| MVPA / RSA | Multi-Voxel Pattern Analysis / Representational Similarity Analysis | Decoding from distributed fMRI patterns; RSA compares pattern similarity structure to a hypothesised representational geometry |
| MIND | Manifold Inference from Neural Dynamics | Nonlinear dimensionality reduction that builds its distance metric from estimated *transition* probabilities between population states rather than from the state cloud alone, so it suits data with sequential activity (Low, Lewallen et al. 2018; applied to CA1 by Nieh et al. 2021, [[wiki/concepts/population-geometry.md]]) |
| LLE | Local Linear Embedding | Learns the map between latent coordinates and population activity in both directions, which is what lets neural data be *reconstructed* from `d` latents and cross-validated on held-out trials |
| GPR | Gaussian Process Regression | Smooth nonlinear regression from manifold coordinates to a task variable; the standard decoder for reading position, evidence or choice off a latent embedding — linear decoders generally fail on the same data |
| SO(d) | Special Orthogonal group of degree `d` | Rotations of a `d`-dimensional embedding; `SO(5)` has 10 generators, and one element of it is what aligns two animals' neural manifolds — the "pose" parameter against a reusable geometry |
| MDS | MultiDimensional Scaling | Embeds a distance matrix in low dimensions for visualisation; used to read a graph back out of a neural similarity matrix (Garvert et al. 2017) |
| ROI / SVC | Region Of Interest / Small-Volume Correction | An anatomically or independently defined set of voxels, and multiple-comparison correction restricted to it — the standard way an fMRI claim about a small structure such as entorhinal cortex is made |
| GMV | Grey-Matter Volume | Structural-MRI morphometric measure; declines across most of cortex from childhood to adulthood, but *rises* in entorhinal cortex over ages 8–25 (Qu et al. 2026) |
| FA / SC | Fractional Anisotropy / Structural Connectivity | Diffusion-MRI measure of directional water diffusion in white matter, used as a proxy for tract integrity; "structural connectivity" between two regions here means mean FA in the tracts joining them |
| CCA | Canonical Correlation Analysis | Finds paired linear combinations of two variable sets that maximally correlate; used to relate a set of neural cognitive-map measures to a set of IQ subtest scores |
| SPM (Raven's) | Standard Progressive Matrices | Non-verbal matrix-completion test, the standard psychometric measure of fluid reasoning; distinct from Statistical Parametric Mapping, the fMRI software |
| WISC | Wechsler Intelligence Scale for Children | Multi-subtest IQ battery (digit span, block design, similarities, coding, comprehension) |
| FWE | Family-Wise Error | Correction controlling the probability of *any* false positive across the tested voxels; stricter than false-discovery-rate control |
| fMRI adaptation | (repetition suppression) | Reduced response to a stimulus similar to its predecessor; recovery from it is used as a proxy for representational distance between the two |
| CHL | Contrastive Hebbian Learning | Two-phase rule `Δw ∝ ⟨ρρ⟩_clamped − ⟨ρρ⟩_free`; the fully clamped (`β → ∞`) limit of equilibrium propagation ([[wiki/concepts/equilibrium-propagation.md]]) |
| STDP | Spike-Timing-Dependent Plasticity | Hebbian rule whose sign depends on pre/post spike order |
| BCM | Bienenstock–Cooper–Munro theory | Stabilised Hebbian rule with a *sliding* modification threshold on postsynaptic activity — potentiation above it, depression below — so the rule is metaplastic by construction ([[wiki/concepts/synaptic-plasticity.md]]) |
| GHA | Generalized Hebbian Algorithm | Deflation-based extension of Oja's rule that extracts successive principal components rather than only the first |
| V1 | Primary Visual Cortex | Simple/complex cells; origin of convolutional architecture |
| V2 / V2M | Secondary Visual Cortex / its Medial subdivision | Site of reported rat grid, place and head-direction cells that persist in darkness ([[wiki/concepts/distributed-reference-frames.md]]) |
| S1 / S1HL | Primary Somatosensory Cortex / its HindLimb area | Site of reported rat grid, place and head-direction cells that persist after whisker trimming |
| PPC | Posterior Parietal Cortex | Bridges perception, action and cognition; the candidate site of the egocentric→allocentric transform |
| OFC | OrbitoFrontal Cortex | Value and goal coding; shows grid-like fMRI modulation in conceptual tasks and location-selective tuning in rat |
| vmPFC / dmPFC | ventromedial / dorsomedial PreFrontal Cortex | Carry the hexadirectional signal in conceptual and social-hierarchy tasks |
| ACC / PCC | Anterior / Posterior Cingulate Cortex | Also report grid-like modulation; PCC carries the magnitude half of the social-space vector code |
| MEC / LEC | Medial / Lateral Entorhinal Cortex | Structural (grid-like, path-integrating) and sensory input streams to hippocampus respectively |
| OVC / BVC / GVC | Object-Vector / Border-Vector / Goal-Vector Cell | Local bases: fire at a given distance and direction from any object, border or goal ([[wiki/concepts/compositionality.md]]) |
| ESR | Event-Specific Rate | Per-lap deviation from the mean firing at a cell's peak location; measures non-spatial (which-lap) selectivity while ignoring spatial selectivity ([[wiki/entities/tolman-eichenbaum-machine.md]]) |
| Splitter cell | — | Fires at the same location differently depending on the trajectory through it; a latent-state code |
| CX | Central Complex | Midline insect brain region containing the ellipsoid body; site of the fly heading compass ([[wiki/entities/fly-central-complex.md]]) |
| EB | Ellipsoid Body | Toroidal neuropil of the CX whose columnar (EBw.s) neurons tile a ring and carry a single heading bump |
| PVA | Population Vector Average | Circular mean of a ring population's activity, weighted by rate; the decoder that reads heading off the EB bump |
| GCaMP | Genetically encoded Calcium indicator (GFP + Calmodulin + M13) | Fluorescent activity reporter; GCaMP6f is the fast variant used for two-photon population imaging |
| GABA | γ-aminobutyric acid | The principal inhibitory transmitter; "GABAergic" = inhibitory interneuron ([[wiki/concepts/inhibitory-control-of-coding.md]]) |
| ACG | Autocorrelogram | Spike-train autocorrelation; its *rise time* is one of the six features that separate interneuron families physiologically |
| CV2 | Second coefficient of variation of interspike intervals | `2\|ISI_{i+1} − ISI_i\|/(ISI_{i+1} + ISI_i)`, averaged over spikes — a local firing-irregularity measure, the single most informative cell-class feature |
| SPW-R | Sharp-Wave Ripple | 100–250 Hz hippocampal population burst; the replay carrier ([[wiki/concepts/offline-replay.md]]) |
| ChR2 | Channelrhodopsin-2 | Light-gated cation channel used to activate (and thereby "opto-tag") a genetically defined cell population |
| CCK | Cholecystokinin | Peptide marking a basket-cell type inside the *Id2* interneuron family (the *Sncg* subfamily) |
| NGF | NeuroGliaForm cell | Late-spiking, densely arborising interneuron of the *Id2* family; in CA1 it sits in the stratum lacunosum moleculare and gates entorhinal against CA3 input onto pyramidal dendrites ([[wiki/concepts/inhibitory-control-of-coding.md]]) |
| NDNF | Neuron-Derived Neurotrophic Factor | Marker gene for hippocampal neurogliaform cells; NDNF-Cre mice are how that population is targeted ([[wiki/concepts/memory-allocation-excitability.md]]) |
| SLM | Stratum Lacunosum Moleculare | Most distal layer of CA1, where the temporoammonic (entorhinal→CA1) path terminates and NDNF⁺ neurogliaform cells reside |
| GAD67 | Glutamic Acid Decarboxylase 67 | GABA-synthesising enzyme; the standard immunohistochemical marker for inhibitory neurons |
| TRAP2 | Targeted Recombination in Active Populations (Fos2A-iCreER) | Tamoxifen-gated Cre driven by the *Fos* promoter; permanently labels the neurons active during a chosen window, the standard engram-tagging tool |
| CNO | Clozapine *N*-oxide | Ligand for DREADD chemogenetic receptors; the drug that switches an engineered inhibition or excitation on |
| ASD / TDC | Autism Spectrum Disorder / Typically Developing Control | Group labels in the ABIDE resting-state dataset used to test whether a connectome-derived attractor model predicts altered dynamics ([[wiki/entities/fcann.md]]) |
| CEBRA | Consistent Embedding of high-dimensional Recordings using Auxiliary variables | Contrastive latent-embedding method used to decode position from neural populations |
| CCGP | Cross-Condition Generalization Performance | Train a linear decoder on one set of conditions, test on held-out ones: the standard score for whether a population code is *abstract* ([[wiki/concepts/population-geometry.md]]) |
| BCI | Brain–Computer Interface | Closed-loop cursor control from recorded population activity; the experimenter owns the whole activity→behaviour map, which is what makes learnability testable ([[wiki/concepts/manifold-constrained-learning.md]]) |
| IM | Intrinsic Manifold | The subspace spanned by a population's natural co-modulation patterns, estimated as the column space of the factor-analysis loading matrix; predicts which new activity patterns are learnable ([[wiki/concepts/manifold-constrained-learning.md]]) |
| PD | Preferred Direction | The movement direction eliciting a motor unit's maximal firing; changes in PD are the classical single-cell signature of sensorimotor learning |
| BTSP | Behavioral Timescale Synaptic Plasticity | Seconds-wide eligibility window gated by a dendritic plateau; produces a place field from one traversal, and a binary-weight content-addressable memory at the population level ([[wiki/concepts/synaptic-plasticity.md]], [[wiki/entities/btsp-cam.md]], [[wiki/empirical-tensions.md]] T13) |
| SMA / pre-SMA | Supplementary Motor Area / pre-Supplementary Motor Area | Medial premotor cortex on the dorsal medial wall; pre-SMA is the more rostral, more abstract of the pair and carries *response tactic* rather than movement ([[wiki/concepts/policy-abstraction-hierarchy.md]], [[wiki/entities/medial-prefrontal-cortex.md]]) |
| PMd | Dorsal Premotor Cortex | Where an arbitrary cue→action mapping is stored once learned ([[wiki/concepts/arbitrary-sensorimotor-mapping.md]]) |
| LEC II / LEC III | Lateral Entorhinal Cortex, layer II / layer III | The non-spatial entorhinal stream — object and item content — entering the hippocampus alongside the medial (grid) stream ([[wiki/entities/spiking-tem.md]]) |
| MEC II / MEC III | Medial Entorhinal Cortex, layer II / layer III | Layer II grid cells phase-precess; layer III cells phase-lock and are trained to predict layer II one step ahead ([[wiki/entities/spiking-tem.md]], [[wiki/concepts/temporal-coding.md]]) |
| NAc | Nucleus Accumbens | Ventral striatum; the second coincidence gate downstream of the control layer, where hippocampal and prefrontal input converge ([[wiki/entities/hippocampal-prefrontal-channel.md]]) |
| VTC | Ventral Temporal Cortex | The object-selective end of the ventral visual stream |
| SWR | Sharp-Wave Ripple | Hippocampal high-frequency burst during rest and slow-wave sleep; the event replay rides on ([[wiki/concepts/offline-replay.md]]) |
| RPE | Reward Prediction Error | `r + γV(s′) − V(s)`; the quantity dopamine phasic firing is standardly read as reporting, and which [[wiki/entities/pbwm.md]]'s PVLV contests |
| DLPFC | Dorsolateral Prefrontal Cortex | The lateral control tier: rule and task-set coding, and the region whose coupling — not activation — separates good from poor learners ([[wiki/concepts/arbitrary-sensorimotor-mapping.md]], [[wiki/concepts/cognitive-control.md]]) |
| VTA | Ventral Tegmental Area | Midbrain dopamine source projecting to ventral striatum and cortex; paired with SNc as the origin of the broadcast scalar in [[wiki/concepts/reward-prediction-error.md]] |
| OLM | Oriens–Lacunosum Moleculare interneuron | Somatostatin-expressing hippocampal interneuron innervating distal CA1 dendrites; the addressed target of the place-cell→interneuron potentiation in [[wiki/concepts/inhibitory-control-of-coding.md]] |
| VIP | Vasoactive Intestinal Peptide interneuron | Disinhibitory interneuron class (VIP⁺ inhibits SOM⁺/PV⁺); one of the three marker-defined channels through which coding-level control is exerted |
| MBON | Mushroom Body Output Neuron | *Drosophila* readout neuron whose synaptic weights carry the learned valence; the invertebrate case in the consolidation table ([[wiki/concepts/generalization-optimized-consolidation.md]]) |

## Benchmarks

| Abbrev. | Expansion | Note |
|---|---|---|
| ARC / ARC-AGI | Abstraction and Reasoning Corpus (for Artificial General Intelligence) | Chollet's grid-transformation benchmark; the wiki page describes the 2019 original ([[wiki/entities/arc-agi.md]]) |
| GLUE / SuperGLUE | General Language Understanding Evaluation | Multi-task NLP benchmarks; tasks are known to developers, so they measure skill breadth, not developer-aware generalization |
| FMNIST / KMNIST / EMNIST | Fashion / Kuzushiji / Extended MNIST | MNIST drop-in replacements of increasing difficulty (clothing, Hiragana, 47 balanced letter+digit classes); the dANN benchmark suite with MNIST and CIFAR-10 |
| CCN | Computational Cognitive Neuroscience | A model class, not a field label: models constrained to fit neurobiological *and* behavioural data at once, which is the filter Helie et al. 2013 apply to get 19 basal-ganglia models out of ~25 years of literature ([[wiki/entities/basal-ganglia.md]]) |
| TAS | Temporal Action Segmentation | Partition a continuous observation sequence into contiguous segments and assign each a discrete skill label; unsupervised when neither boundaries nor labels are given ([[wiki/entities/hisd.md]]) |
| ASOT | Action Segmentation with Optimal Transport | Xu & Gould 2024's TAS method: an unbalanced optimal-transport plan from frames to `K` skill prototypes, regularised by a Gromov–Wasserstein temporal-consistency term; the segmentation stage of [[wiki/entities/hisd.md]] |
| GW | Gromov–Wasserstein | Optimal-transport distance comparing *intra*-space cost matrices rather than points across spaces; here it is what penalises nearby frames receiving different skill labels |
| CFG / PCFG | (Probabilistic) Context-Free Grammar | `(N, Σ, P, S₀)` — non-terminals, terminals, productions, start symbol; the probabilistic variant assigns rule probabilities and can marginalise over noisy parses ([[wiki/entities/hisd.md]]) |
| MoF / mIoU | Mean-over-Frames / mean Intersection-over-Union | Segmentation metrics: frame-wise accuracy (class-imbalance sensitive) and per-class overlap (penalises both over- and under-segmentation) |
| PU classifier | Positive-Unlabelled classifier | Trained from positive examples plus unlabelled data with no confirmed negatives; used to learn option initiation sets `I` and termination functions `β` from segmented observations |
| BC | Behavioural Cloning | Supervised imitation — fit `π(a\|s)` to demonstration state–action pairs, with no environment interaction and no reward |
| CEM | Cross-Entropy Method | Derivative-free optimiser: sample candidates from a Gaussian, keep the top-`k`, refit mean and variance, repeat; the planner used by [[wiki/entities/v-jepa-2.md]] and [[wiki/entities/adaworld.md]] to minimise a goal-distance energy over action sequences |
| ViT | Vision Transformer | Transformer over image/video patches (here `2×16×16` tubelets); sizes referenced as ViT-S/L/H/g at 22M/300M/600M/1B parameters |
| RoPE | Rotary Position Embedding | Relative position encoded by rotating query/key feature pairs; the 3D variant splits the feature dimension into time/height/width thirds and rotates each separately ([[wiki/entities/v-jepa-2.md]]) |
| EMA | Exponential Moving Average | A slowly-trailing copy of a network's weights; in JEPA training it produces the prediction targets. It prevents collapse only *jointly with* an asymmetric predictor on the online branch — either alone collapses ([[wiki/entities/byol.md]], G34) |
| BYOL | Bootstrap Your Own Latent | The negative-free joint-embedding learner whose EMA target + online predictor asymmetry the whole JEPA lineage inherited ([[wiki/entities/byol.md]]) |
| MLLM | Multimodal Large Language Model | An LLM fed projected visual encoder outputs as input tokens (the LLaVA recipe); the setting of tension T149 |
| VLA | Vision-Language-Action model | A vision-language backbone fine-tuned by behavioural cloning to emit actions directly, with no world model and no planning — Octo is the wiki's instance |
| VidQA | Video Question Answering | Open-language QA over video clips; the benchmark family (PerceptionTest, MVP, TempCompass, TemporalBench, TOMATO, TVBench, MVBench) used to score encoders after LLM alignment |
| SIGReg | Sketched-Isotropic-Gaussian Regularizer | Anti-collapse term: project embeddings onto `M` random unit directions and penalise each 1-D projection's Epps–Pulley distance from `N(0,1)`; by Cramér–Wold this matches the joint to `N(0, I)`. Introduced in [[wiki/entities/lejepa.md]] (Balestriero & LeCun 2025), where the `N(0,I)` target is *derived* as the probe-risk minimiser; applied to a world model in [[wiki/entities/lewm.md]]. **Weak-SIGReg** (Akbar 2026) is the second-moment truncation: `‖Cov(ZS^⊤) − I_K‖_F` on a random sketch, `O(CK)` memory, usable as a supervised optimisation stabiliser on internal layers |
| Muon | — | Optimiser that orthogonalises the update matrix before applying it; used in [[wiki/entities/lejepa.md]] §Part 8 as the *update-geometry* counterpart to SIGReg's representation-geometry constraint, with the two measured to compose additively |
| LeJEPA | Latent-Euclidean JEPA | The SIGReg + multi-view-prediction objective with one coefficient, no predictor and no teacher ([[wiki/entities/lejepa.md]]) |
| Epps–Pulley | — | Normality test comparing the empirical characteristic function to `N(0,1)`'s in weighted `ℓ₂`; chosen over moment- and CDF-based tests for bounded gradients, differentiability and `O(N)` distributed cost ([[wiki/entities/lejepa.md]]) |
| SWA | Stochastic Weight Averaging | A running average of the encoder weights used at evaluation; in [[wiki/entities/lejepa.md]] it is what remains of teacher–student once collapse is handled by the loss (+~3 points on ViTs, 0 on ResNets) |
| LeWM | LeWorldModel | The 15M end-to-end pixel JEPA built on SIGReg ([[wiki/entities/lewm.md]]) |
| PLDM | Predictive Latent Dynamics Model | The other end-to-end pixel JEPA, trained with a seven-term VICReg-derived objective; LeWM's closest baseline |
| DINOv2 | — | Self-supervised ViT foundation encoder: DINO image-level + iBOT patch-level cross-entropy against an EMA teacher, teacher output centered or Sinkhorn–Knopp-normalised, plus KoLeo ([[wiki/entities/dinov2.md]]) |
| iBOT | image BERT pre-Training with Online Tokenizer | Masked-patch self-distillation: mask patches for the student, predict the EMA teacher's tokens at those positions; DINOv2's patch-level term |
| KoLeo | Kozachenko–Leonenko | Differential-entropy estimator used as a spread regulariser: `−(1/n) Σ log min_{j≠i}‖x_i − x_j‖`, i.e. penalise small nearest-neighbour spacings ([[wiki/entities/dinov2.md]]) |
| DINOv3 | — | The 7B/16 successor: same objective on a 1.69B-image corpus with constant (unscheduled) hyperparameters, plus a **Gram anchoring** phase and post-hoc high-resolution adaptation and distillation ([[wiki/entities/dinov3.md]]) |
| Gram anchoring | — | `L_Gram = ‖X_S X_Sᵀ − X_G X_Gᵀ‖_F²` between the patch-similarity (Gram) matrices of a student and an *earlier iterate of itself*; constrains relations among tokens while leaving the features free up to any inner-product-preserving transformation ([[wiki/entities/dinov3.md]], G34) |
| LVD-1689M | Large Visual Dataset | DINOv3's corpus: 1.69B images from a 17B pool, curated by 5-level hierarchical `k`-means with balanced sampling, mixed with retrieval-curated and raw datasets |
| CorLoc | Correct Localization | Unsupervised object-discovery metric: fraction of images whose predicted box overlaps a ground-truth box at IoU > 0.5 |
| ConvNeXt (CNX) | — | A convolutional architecture with transformer-era design choices; no CLS token, no attention — DINOv3 distils its ViT-7B into one, crossing an architecture-family boundary |
| DPT | Dense Prediction Transformer | Decoder head that assembles ViT tokens from several depths into a dense pixel-wise map; the depth and canopy-height head in [[wiki/entities/dinov3.md]] |
| VGGT | Visual Geometry Grounded Transformer | Feed-forward multi-view 3D system (camera pose, depth, point maps) built on a frozen DINO backbone; improves on all metrics when its DINOv2 encoder is swapped for DINOv3 |
| LiT | Locked-image Tuning | Align a text encoder to a **frozen** image encoder by a contrastive objective; DINOv3's dino.txt matches text against the CLS token *concatenated with* mean-pooled patches, which is what buys dense open-vocabulary segmentation |
| SK | Sinkhorn–Knopp | Iterative matrix scaling toward doubly-stochastic; used (3 iterations, from SwAV) to force a batch's prototype assignments toward equipartition |
| SwAV | Swapping Assignments between Views | Clustering-based SSL whose batch-level equipartition constraint DINOv2 borrows as a teacher normalisation |
| LVD-142M | Large Visual Dataset | DINOv2's pretraining corpus: 142M images retrieved from a deduplicated 744M web pool as nearest neighbours of curated seed datasets, with no metadata or text |
| LayerScale | — | Per-channel learnable scaling on each residual branch; in DINOv2 it costs linear-probe accuracy and buys training stability at scale |
| SwiGLU | Swish-Gated Linear Unit | Gated feed-forward variant used in DINOv2's from-scratch ViTs |
| DINO-WM | DINO World Model | Latent world model built on a frozen DINOv2 encoder; the frozen-foundation-encoder branch of the JEPA control lineage |
| AdaLN | Adaptive Layer Normalization | Conditioning by predicting a normalisation layer's scale and shift from a conditioning vector; zero-initialised in LeWM so action conditioning enters gradually |
| VLM | Vision-Language Model | Any model mapping images (or video) and text into a common computation; four training families — contrastive, masking, generative, pretrained-backbone ([[wiki/concepts/cross-modal-grounding.md]]) |
| NCE | Noise-Contrastive Estimation | Train an energy model by discriminating data from samples of an arbitrary *noise* distribution, substituted for the intractable model distribution; the ancestor of InfoNCE |
| CLIP | Contrastive Language–Image Pre-training | Two randomly-initialised encoders trained with InfoNCE on 400M web image–caption pairs into one shared space; the field's default vision encoder |
| SigLIP | Sigmoid Loss for Language–Image Pre-training | CLIP with the original binary-cross-entropy NCE loss instead of the multi-class InfoNCE; better zero-shot at small batch sizes |
| MLM / MIM | Masked Language / Image Modeling | Predict masked tokens or patches from the unmasked remainder |
| ARO | Attribution, Relation, and Order | Benchmark of caption negatives made by swapping a relation, attribute or word order; no paired negative image ([[wiki/concepts/cross-modal-grounding.md]]) |
| PUG | Photorealistic Unreal Graphics | Rendered scenes built one element at a time, so a single spatial relation can be varied with everything else fixed; VLMs score at chance on it |
| DCI | Densely Captioned Images | 7,805 images segmented with Segment Anything and human-annotated at >1000 words each; supports crop–caption matching |
| DataComp | — | Benchmark that fixes CLIP's architecture and hyperparameters and competes on the *dataset*, showing data pruning beats the scaling law |
| LIMIT | — | 50k-document retrieval dataset built from the densest qrel matrix that fits ~1000 top-2 queries (all `C(46,2)` pairs), instantiated as *`Jon likes Apples`* / *`who likes Apples?`*; every single-vector embedding model fails it ([[wiki/concepts/retrieval-capacity.md]]) |
| MTEB / BEIR | Massive Text Embedding Benchmark / Benchmarking IR | The field's standard embedding leaderboards; scores on them are uncorrelated with LIMIT |
| IB | Information Bottleneck | Find a code maximally informative about the sample and minimally informative about the nuisance (here, the distortion applied); Barlow Twins' `λ` is its trade-off parameter ([[wiki/entities/barlow-twins.md]]) |
| LARS | Layer-wise Adaptive Rate Scaling | The large-batch optimiser every ImageNet-scale SSL method in the wiki trains with (BYOL, Barlow Twins) |
| W-MSE | Whitening Mean Squared Error | Cholesky-whiten each batch of embeddings exactly, then take a cosine similarity — the *hard*-whitening counterpart to Barlow Twins' soft decorrelation; 66.3% ImageNet linear eval |
| IMAX | — | Becker & Hinton 1992: maximise `log det C(Z^A − Z^B) − log det C(Z^A + Z^B)` between twin networks; a genuine information quantity of the same two-term shape as Barlow Twins, which did not scale to ImageNet |
| VL-JEPA | Vision-Language JEPA | A JEPA predicting a *text encoder's* embedding of the answer from video + a text query, with the decoder invoked only on demand ([[wiki/entities/vl-jepa.md]]) |
| VQA | Visual Question Answering | Answer a natural-language question about an image or video; *discriminative* VQA scores a fixed candidate set, *open-ended* VQA generates the answer |
| CIDEr | Consensus-based Image Description Evaluation | TF-IDF-weighted n-gram agreement between a generated caption and multiple references; the standard captioning metric |
| SugarCrepe++ / VISLA | — | Text-only hard-negative triplet benchmarks: two paraphrases of one image description plus a negative made by replacing or **swapping** an object, attribute or relation; score = paraphrase similarity above both negative similarities ([[wiki/entities/vl-jepa.md]]) |
| WorldPrediction-WM | — | Given initial and final world-state images, pick which of four action video clips explains the transition — inverse dynamics scored as a 4-way choice |
| PE / PE-Core | Perception Encoder | Meta's image–text contrastive encoder family; the strongest CLIP-style baseline in the 2025 comparisons |
| TOT | Text-Only Task | Evaluation protocol that scores a vision–language model's *text* encoder with no image involved |
