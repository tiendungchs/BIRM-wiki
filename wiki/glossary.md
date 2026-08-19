# Glossary

Abbreviations used across the wiki. Per the schema, terms are expanded in place on first use *unless* they are near-universal (AI, ML, NN, DNA) or unwieldy — those live here.

## Machine learning

| Abbrev. | Expansion | Note |
|---|---|---|
| AIT | Algorithmic Information Theory | Kolmogorov complexity and its relatives; the formal language of both [[wiki/concepts/universal-induction.md]] and [[wiki/concepts/skill-acquisition-efficiency.md]] |
| DSL | Domain-Specific Language | A restricted program space to search over; ARC's proposed solver hard-codes core-knowledge priors as one |
| GD | Generalization Difficulty | `H(Sol^θ_T \| TrainSol^opt_{T,C}) / H(Sol^θ_T)` — how far the shortest curriculum-optimal program must be edited to work at evaluation |
| AIXI | AI with (X) Induction (I) | Hutter's uncomputable universal agent; the formal ceiling ([[wiki/entities/aixi.md]]) |
| AIXItl | AIXI bounded to length `l̃` and per-cycle time `t̃` | Computable reduction of AIXI; dominates all self-certifying policies within those bounds |
| AIµ | The same agent with the *true* environment prior `µ` | Plain expectimax; optimal by construction, and the reference AIXI is measured against |
| CLS | Complementary Learning Systems | Fast hippocampal / slow cortical memory pair; also the name of the theory |
| CNN | Convolutional Neural Network | |
| DFA | Direct Feedback Alignment | Output error wired straight to every hidden layer |
| DNC | Differentiable Neural Computer | Controller + external memory matrix, trained end to end |
| DNN | Deep Neural Network | |
| DQN | Deep Q-Network | Deep RL agent for Atari; origin of experience replay in deep RL |
| DRAW | Deep Recurrent Attentive Writer | Attentional generative model that builds an image incrementally |
| DRL | Deep Reinforcement Learning | |
| e-prop | Eligibility Propagation | Forward-only local credit assignment for spiking networks |
| ENU | Evolvable Neural Unit | Evolved somatic/synaptic compartment model with gated update dynamics |
| EBM | Energy-Based Model | A scalar compatibility function `F(x,y)` treated as fundamental, with no normalisation ([[wiki/concepts/energy-based-models.md]]) |
| EWC | Elastic Weight Consolidation | Fisher-weighted quadratic penalty protecting important weights |
| FA | Feedback Alignment | Fixed random backward weights in place of the forward transpose |
| GAN | Generative Adversarial Network | Contrastive EBM in which the contrastive samples come from a trainable generator |
| H-JEPA | Hierarchical JEPA | JEPAs stacked so higher levels predict further ahead on coarser representations ([[wiki/entities/h-jepa.md]]) |
| IC / TC | Intrinsic Cost / Trainable Critic | The immutable and learned halves of LeCun 2022's cost module |
| InfoNCE | Information Noise-Contrastive Estimation | The standard multi-sample contrastive loss |
| i.i.d. | independent and identically distributed | Train and test drawn from the same distribution; the assumption behind standard benchmarking |
| JEA | Joint Embedding Architecture | Two encoders, energy = distance between their outputs |
| JEPA | Joint Embedding Predictive Architecture | JEA plus a predictor from `s_x` to `s_y`, optionally latent-conditioned; non-generative |
| KL | Kullback–Leibler divergence | `KL(P‖Q) = H(P,Q) − H(P)` — the surprise due purely to a wrong model, asymmetric in its arguments ([[wiki/concepts/divergence-objectives.md]]) |
| K(x) | Kolmogorov complexity | Length of the shortest program printing `x` |
| LGD | Latent Graph Discovery | The wiki's core problem framing |
| LSTM | Long Short-Term Memory | Gated recurrent architecture |
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
| VAE / VQ-VAE | Variational / Vector-Quantized Auto-Encoder | Noise- and quantisation-based latent-capacity regularisers |
| VICReg | Variance-Invariance-Covariance Regularization | Non-contrastive JEPA criterion: variance hinge per component + covariance decorrelation |
| ξ | Universal semimeasure | `Σ_p 2^-l(p)` over programs producing the observed string; dominates every enumerable semimeasure |
| SR | Successor Representation | Discounted expected future state occupancy, `S = ΣγⁿTⁿ`; value is `Sr` ([[wiki/concepts/successor-representation.md]]) |
| DR | Default Representation | SR-like representation built for default behaviour and linearly updatable when rewards change; from linear RL |
| CSCG | Clone-Structured Cognitive Graph | Hidden Markov model with a frozen clone pool per observation ([[wiki/entities/cscg.md]]) |
| TEM | Tolman-Eichenbaum Machine | Path-integrating structural code plus relational memory ([[wiki/entities/tolman-eichenbaum-machine.md]]) |
| SMP | Spatial Memory Pipeline | TEM's sibling, trained from egocentric pixels with a machine-learning memory network |
| CANN | Continuous Attractor Neural Network | Recurrent network whose weights support a continuum of stable states; the classical path-integration substrate |
| VCO | Velocity-Coupled Oscillator | Path integration by phase interference between theta and velocity-modulated dendritic oscillations |
| EM | Expectation-Maximisation | Alternating latent-inference / parameter-update algorithm; how CSCG is trained |

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
| CA1 / CA3 | Cornu Ammonis fields 1 and 3 | CA3 is the recurrent auto-associative field (pattern completion); CA1 relays hippocampal output and transforms input linearly |
| EC | Entorhinal Cortex | The hippocampus's main cortical input/output; layer II projects to both DG and CA3, and carries the grid code ([[wiki/concepts/abstract-structural-codes.md]]) |
| IEG | Immediate-Early Gene | Activity-dependent genes (e.g. Arc) whose expression maps which neurons were recently active — a population-level imaging method |
| NMDAR | N-methyl-D-aspartate Receptor | Coincidence-detecting glutamate receptor; its NR1 subunit is the standard knockout target for testing plasticity-dependence of a computation |
| LIF | Leaky Integrate-and-Fire | Standard spiking-neuron model: membrane potential integrates input, spikes at threshold, resets |
| LTP / LTD | Long-Term Potentiation / Depression | Lasting strengthening / weakening of a synapse |
| MEG | Magnetoencephalography | |
| MTL | Medial Temporal Lobe | Hippocampus and surrounding cortex |
| PFC | Prefrontal Cortex | |
| HD cell | Head Direction cell | Fires as a function of head orientation in the navigational plane; the heading half of a cognitive map ([[wiki/concepts/cognitive-map.md]]) |
| PPA | Parahippocampal Place Area | Scene/landmark-selective region; perceptual identification of the local place or context |
| RSC | Retrosplenial Complex | Parieto-occipital-sulcus region (partly overlapping Brodmann area 29/30) that anchors the map: heading codes in local and global reference frames |
| OPA | Occipital Place Area | Scene region near the transverse occipital sulcus; boundaries and local navigational affordances |
| MVPA / RSA | Multi-Voxel Pattern Analysis / Representational Similarity Analysis | Decoding from distributed fMRI patterns; RSA compares pattern similarity structure to a hypothesised representational geometry |
| STDP | Spike-Timing-Dependent Plasticity | Hebbian rule whose sign depends on pre/post spike order |
| V1 | Primary Visual Cortex | Simple/complex cells; origin of convolutional architecture |
| MEC / LEC | Medial / Lateral Entorhinal Cortex | Structural (grid-like, path-integrating) and sensory input streams to hippocampus respectively |
| OVC / BVC / GVC | Object-Vector / Border-Vector / Goal-Vector Cell | Local bases: fire at a given distance and direction from any object, border or goal ([[wiki/concepts/compositionality.md]]) |
| Splitter cell | — | Fires at the same location differently depending on the trajectory through it; a latent-state code |

## Benchmarks

| Abbrev. | Expansion | Note |
|---|---|---|
| ARC / ARC-AGI | Abstraction and Reasoning Corpus (for Artificial General Intelligence) | Chollet's grid-transformation benchmark; the wiki page describes the 2019 original ([[wiki/entities/arc-agi.md]]) |
| GLUE / SuperGLUE | General Language Understanding Evaluation | Multi-task NLP benchmarks; tasks are known to developers, so they measure skill breadth, not developer-aware generalization |
