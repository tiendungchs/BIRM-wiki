---
title: "Liquid Time-constant Networks"
source: "https://www.emergentmind.com/topics/liquid-time-constant-networks"
author:
published: 2026-01-08
created: 2026-06-20
description: "Liquid Time-constant Networks (LTCs) are biologically inspired, continuous-time RNNs that dynamically adjust memory and enhance sequence modeling performance."
tags:
  - "clippings"
---
Chrome Extension

- Liquid Time-constant Networks are biologically inspired continuous-time recurrent architectures that dynamically adjust neuron time constants based on internal state and external input.
- They utilize neural ODE formulations and solver-free variants to achieve efficient numerical integration, robust stability, and enhanced generalization in temporal tasks.
- LTCs have been applied to time-series prediction, control, and embedded AI, demonstrating improved accuracy, reduced computational costs, and scalability over traditional methods.

Liquid Time-constant Networks ([LTCs](https://www.emergentmind.com/topics/good-locally-testable-codes-ltcs)) are a class of biologically inspired, [continuous-time recurrent neural network](https://www.emergentmind.com/topics/continuous-time-recurrent-neural-network-ctrnn) architectures in which each unit's effective time constant is dynamically modulated by its internal state and external input, yielding adaptive memory profiles and enhanced expressivity. Distinguished from classical [RNNs](https://www.emergentmind.com/topics/recurrent-neural-networks-rnns) by their [neural ordinary differential equation](https://www.emergentmind.com/topics/neural-ordinary-differential-equation) ([ODE](https://www.emergentmind.com/topics/neural-ordinary-differential-equation-ode-models)) formulation, LTCs support both stable bounded trajectories and robust generalization in temporal sequence modeling. This paradigm extends to closed-form solver-free architectures, graph-based multi-agent models, and physics-informed learning pipelines, underpinning state-of-the-art performance in time-series prediction, control, and embedded AI contexts ([Hasani et al., 2020](https://www.emergentmind.com/papers/2006.04439), [Hasani et al., 2018](https://www.emergentmind.com/papers/1811.00321), [Bidollahkhani et al., 2023](https://www.emergentmind.com/papers/2304.08691), [Hasani et al., 2021](https://www.emergentmind.com/papers/2106.13898), [Zong et al., 8 Oct 2025](https://www.emergentmind.com/papers/2510.07578), [Nerrise et al., 2024](https://www.emergentmind.com/papers/2401.09631), [Hasani et al., 2022](https://www.emergentmind.com/papers/2209.12951), [Marino et al., 2024](https://www.emergentmind.com/papers/2404.13982), [Nielsen et al., 2023](https://www.emergentmind.com/papers/2306.04997)).

## 1\. Mathematical Foundations and Biological Inspiration

[LTC](https://www.emergentmind.com/topics/liquid-time-constant-network-ltc) models are formulated as systems of first-order ODEs wherein each neuron (or hidden channel) evolves according to a modulated leak and drive mechanism. The core update for neuron $i$ reads:

$$
\tau_i(h, x)\,\frac{d h_i(t)}{d t} = -h_i(t) + \sum_{j=1}^N W_{ij}\,g_{ij}(h, x) + b_i,
$$

where $h(t)$ is the hidden state vector, $x(t)$ the external input, and $g_{ij}$ typically a sigmoidal gating function blending aspects of membrane state and applied input ([Hasani et al., 2020](https://www.emergentmind.com/papers/2006.04439), [Hasani et al., 2018](https://www.emergentmind.com/papers/1811.00321)). The time constant $\tau_i(h, x)$ is parametrized as an adaptive, input- and state-dependent quantity, inspired by the conductance modulation of biological neurons. The continuous-time LTC cell thus generalizes classical leaky-integrate-and-fire models and analog circuit ODEs, endowing the network with activity-dependent memory horizons ([Hasani et al., 2018](https://www.emergentmind.com/papers/1811.00321)). This formulation admits matrix representations for larger populations, e.g.,

$$
\dot{h}(t) = -\left(\tau^{-1} + f(h, x)\right)\odot h(t) + f(h, x)\odot A,
$$

with learnable vectors $\tau$, $A$ and a gating [MLP](https://www.emergentmind.com/topics/primitive-specific-multilayer-perceptron-mlp) $f(·)$ ([Hasani et al., 2020](https://www.emergentmind.com/papers/2006.04439), [Zong et al., 8 Oct 2025](https://www.emergentmind.com/papers/2510.07578)).

## 2\. Adaptive Memory and Liquid Time-constant Mechanisms

The distinguishing feature of LTCs is the "liquid" time constant, manifesting as:

$$
\tau_i(h, x)\,\frac{d h_i(t)}{d t} = -h_i(t) + \sum_{j=1}^N W_{ij}\,g_{ij}(h, x) + b_i,
$$
0

for the 
$$
\tau_i(h, x)\,\frac{d h_i(t)}{d t} = -h_i(t) + \sum_{j=1}^N W_{ij}\,g_{ij}(h, x) + b_i,
$$
1th channel, where high gating input 
$$
\tau_i(h, x)\,\frac{d h_i(t)}{d t} = -h_i(t) + \sum_{j=1}^N W_{ij}\,g_{ij}(h, x) + b_i,
$$
2 accelerates hidden state decay; low gating preserves longer memory ([Hasani et al., 2020](https://www.emergentmind.com/papers/2006.04439)). This enables neurons to flexibly transition between short-term adaptation and sustained integration according to the temporal structure of input, in contrast with fixed-memory profiles of classical RNNs or LSTM/GRU cells. Adaptive time constants are also leveraged as explicit update gates in CT-GRU and gated [RNN](https://www.emergentmind.com/topics/multimodal-recurrent-neural-network-rnn) analogues ([Bidollahkhani et al., 2023](https://www.emergentmind.com/papers/2304.08691)).

## 3\. Numerical Integration, Expressivity, and Stability

LTC ODEs are generally stiff and are integrated by variable-step Runge–Kutta methods or custom fused solvers combining explicit and implicit Euler steps ([Hasani et al., 2020](https://www.emergentmind.com/papers/2006.04439), [Bidollahkhani et al., 2023](https://www.emergentmind.com/papers/2304.08691)). Notably, LTC variants such as Closed-form Continuous-depth (CfC) networks use a tightly-bounded analytical approximation, avoiding internal ODE solvers and permitting direct feed-forward computation ([Hasani et al., 2021](https://www.emergentmind.com/papers/2106.13898)):

$$
\tau_i(h, x)\,\frac{d h_i(t)}{d t} = -h_i(t) + \sum_{j=1}^N W_{ij}\,g_{ij}(h, x) + b_i,
$$
3

This framework ensures scalability and dramatically reduced training/inference cost—up to 
$$
\tau_i(h, x)\,\frac{d h_i(t)}{d t} = -h_i(t) + \sum_{j=1}^N W_{ij}\,g_{ij}(h, x) + b_i,
$$
4 speed-up on standard benchmarks ([Hasani et al., 2021](https://www.emergentmind.com/papers/2106.13898)).

Theoretical results guarantee boundedness and stability for all liquid time-constant settings:

- For weights 
	$$
	\tau_i(h, x)\,\frac{d h_i(t)}{d t} = -h_i(t) + \sum_{j=1}^N W_{ij}\,g_{ij}(h, x) + b_i,
	$$
	5 and bias 
	$$
	\tau_i(h, x)\,\frac{d h_i(t)}{d t} = -h_i(t) + \sum_{j=1}^N W_{ij}\,g_{ij}(h, x) + b_i,
	$$
	6, hidden states are bounded as

$$
\tau_i(h, x)\,\frac{d h_i(t)}{d t} = -h_i(t) + \sum_{j=1}^N W_{ij}\,g_{ij}(h, x) + b_i,
$$
7

and system time-constants satisfy strict bounds determined by parameter maxima ([Hasani et al., 2020](https://www.emergentmind.com/papers/2006.04439), [Hasani et al., 2018](https://www.emergentmind.com/papers/1811.00321)).

LTCs exhibit superior expressive power in latent trajectory space, as measured by increased trajectory length of hidden states, implying richer temporal encoding compared to CT-RNNs and [neural ODEs](https://www.emergentmind.com/topics/neural-ordinary-differential-equations-neural-odes) ([Hasani et al., 2020](https://www.emergentmind.com/papers/2006.04439)).

## 4\. Architectures, Variants, and Software Implementations

LTC-SE augments the original LTC cell with modular [code](https://www.emergentmind.com/topics/karpathy-agent-code) organization, gate enhancements (CT-GRU-style update/reset gates), configurable ODE solvers, input-mapping strategies, and full TensorFlow 2.x support ([Bidollahkhani et al., 2023](https://www.emergentmind.com/papers/2304.08691)). This enables direct comparison across continuous-time (CTRNN, NODE) and discrete-time (LSTM, GRU) recurrent models in unified environments, with LTC-SE displaying improved accuracy (by up to 
$$
\tau_i(h, x)\,\frac{d h_i(t)}{d t} = -h_i(t) + \sum_{j=1}^N W_{ij}\,g_{ij}(h, x) + b_i,
$$
8– 
$$
\tau_i(h, x)\,\frac{d h_i(t)}{d t} = -h_i(t) + \sum_{j=1}^N W_{ij}\,g_{ij}(h, x) + b_i,
$$
9\\% absolute), reduced computational depth (by $h(t)$ 0– $h(t)$ 1\\%), and lower memory usage ([Bidollahkhani et al., 2023](https://www.emergentmind.com/papers/2304.08691)).

The extension to graph domains, such as the [Liquid-Graph Time-Constant Network](https://www.emergentmind.com/topics/liquid-graph-time-constant-network-lgtc) (LGTC), generalizes the adaptive time-constant mechanism to [multi-agent systems](https://www.emergentmind.com/topics/multi-agent-systems-mas) by coupling nodes via graph filters and stabilizing via matrix contraction analysis ([Marino et al., 2024](https://www.emergentmind.com/papers/2404.13982)). LGTC and its solver-free closed-form variants (CfGC) admit transparent stability guarantees and enable efficiency improvements in multi-agent control, e.g., flocking with reduced communication overhead and scalable agent counts ([Marino et al., 2024](https://www.emergentmind.com/papers/2404.13982)).

[Liquid-S4](https://www.emergentmind.com/topics/liquid-s4) leverages a diagonal-plus-low-rank ("DPLR") decomposition for the state-space operator, producing fast [causal convolutions](https://www.emergentmind.com/topics/causal-convolutions) with additional liquid kernel terms that encode multi-way input correlations, yielding state-of-the-art performance in long-sequence modeling (avg. 87.32% LRA, 96.78% Speech Commands with 30% fewer parameters than S4) ([Hasani et al., 2022](https://www.emergentmind.com/papers/2209.12951)).

Solver-free CfC and Liquid-S4 architectures demonstrate that LTC principles can be preserved in closed-form discrete layers, maintaining accuracy while eliminating ODE solver bottlenecks ([Hasani et al., 2021](https://www.emergentmind.com/papers/2106.13898), [Hasani et al., 2022](https://www.emergentmind.com/papers/2209.12951)).

## 5\. Empirical Performance and Benchmark Results

LTCs and their variants exhibit competitive or superior performance in a range of sequence modeling and prediction domains:

- Time-series prediction: across gesture, occupancy, activity, sequential MNIST, traffic, power, and ozone datasets, LTCs outperform or match RNN, LSTM, GRU, CT-RNN, and [neural ODE](https://www.emergentmind.com/topics/neural-ordinary-differential-equation-neural-ode-module) baselines ([Hasani et al., 2020](https://www.emergentmind.com/papers/2006.04439), [Zong et al., 8 Oct 2025](https://www.emergentmind.com/papers/2510.07578)).
- mmWave blockage prediction: sparse LTC networks achieve 97.85%–99.60% accuracy for $h(t)$ 2 prediction, surpassing deep baselines, with strong generalization to scenario variations ([Nielsen et al., 2023](https://www.emergentmind.com/papers/2306.04997)).
- Magnetic navigation: physics-informed LTCs reduce aeromagnetic compensation RMSE by 58%–64% relative to classical Tolles-Lawson or LSTM/MLP/CNN models ([Nerrise et al., 2024](https://www.emergentmind.com/papers/2401.09631)).
- [Long Range Arena](https://www.emergentmind.com/topics/long-range-arena-lra) (LRA): Liquid-S4 extends LTCs to SSMs, attaining SOTA with 87.32% average accuracy and parameter savings ([Hasani et al., 2022](https://www.emergentmind.com/papers/2209.12951)).
- Neuromorphic edge: sparse LTCs implemented as [Neural Circuit Policies](https://www.emergentmind.com/topics/neural-circuit-policies-ncps) (NCPs) are deployed on Loihi-2 hardware, achieving >91% CIFAR-10 accuracy at sub-milliJoule energy per frame ([Zong et al., 8 Oct 2025](https://www.emergentmind.com/papers/2510.07578)).
- Multi-agent graph control: LGTC/CfGC match centralized expert policies in flocking with high scalability and stable dynamics, reducing communications compared to [GGNNs](https://www.emergentmind.com/topics/gated-graph-neural-networks-ggnns) ([Marino et al., 2024](https://www.emergentmind.com/papers/2404.13982)).

## 6\. Advantages, Limitations, and Comparative Analysis

Principal advantages of LTCs include continuous-time causality, input-dependent adaptive memory, parametric flexibility, robust OOD generalization, energy-efficient neuromorphic deployment, and solver-free speedups (for CfC/Liquid-S4) ([Zong et al., 8 Oct 2025](https://www.emergentmind.com/papers/2510.07578), [Hasani et al., 2021](https://www.emergentmind.com/papers/2106.13898), [Hasani et al., 2022](https://www.emergentmind.com/papers/2209.12951)). Parameter counts are often lower (e.g., 12K for LTC vs. 22K for LSTM), memory usage is reduced by ~10%, and accuracy matches or exceeds mature RNN/LSTM pipelines on numerous sequence tasks ([Zong et al., 8 Oct 2025](https://www.emergentmind.com/papers/2510.07578)).

Limitations encompass sensitivity to ODE solver selection (for stiff regimes), increased compute and memory burden for vanilla LTC/BPTT relative to discrete RNNs, immature software/tooling ecosystem, and scaling challenges for very large or irregular input domains ([Zong et al., 8 Oct 2025](https://www.emergentmind.com/papers/2510.07578)). Solver-free variants (CfC, Liquid-S4) address many such concerns, but may slightly degrade throughput compared to RNNs under certain workloads.

## 7\. Applications, Future Directions, and Outlook

LTC networks are deployed for:

- Learning dynamical models underlying robotics, autonomous driving, and multi-agent control;
- Embedded systems, where adaptive memory and solver-free execution enable energy-efficient processing (quantization/pruning supported in LTC-SE);
- Causal inference over temporally streaming sensors;
- Physics-informed modeling, including signal denoising and navigation;
- [Hybrid models](https://www.emergentmind.com/topics/hybrid-models) combining attention (Transformer-LTC) or graph inductive biases;
- [Reinforcement learning](https://www.emergentmind.com/topics/reinforcement-learning-q-learning) via neural simulators.

Active research directions focus on scalable, stability-guaranteed solver methods, efficient training schemes (adjoint, checkpointing), improved OOD robustness (online/continual learning, invariance regularization), hardware co-design for edge/neuromorphic contexts, and unification with modern [attention mechanisms](https://www.emergentmind.com/topics/attention-mechanisms) ([Zong et al., 8 Oct 2025](https://www.emergentmind.com/papers/2510.07578), [Bidollahkhani et al., 2023](https://www.emergentmind.com/papers/2304.08691), [Hasani et al., 2022](https://www.emergentmind.com/papers/2209.12951)).

A plausible implication is that the liquid time-constant paradigm, by shifting memory adaptation from manual architectural tuning into learnable continuous-time dynamics, embeds a versatile inductive bias that may prove fundamental to the next generation of scalable, robust, and resource-efficient neural sequence models.

References (9)

1.

[Liquid Time-constant Networks](https://www.emergentmind.com/papers/2006.04439) (2020)

2.

[Liquid Time-constant Recurrent Neural Networks as Universal Approximators](https://www.emergentmind.com/papers/1811.00321) (2018)

3.

[LTC-SE: Expanding the Potential of Liquid Time-Constant Neural Networks for Scalable AI and Embedded Systems](https://www.emergentmind.com/papers/2304.08691) (2023)

4.

[Closed-form Continuous-time Neural Models](https://www.emergentmind.com/papers/2106.13898) (2021)

5.

[Accuracy, Memory Efficiency and Generalization: A Comparative Study on Liquid Neural Networks and Recurrent Neural Networks](https://www.emergentmind.com/papers/2510.07578) (2025)

6.

7.

[Liquid Structural State-Space Models](https://www.emergentmind.com/papers/2209.12951) (2022)

8.

[Liquid-Graph Time-Constant Network for Multi-Agent Systems Control](https://www.emergentmind.com/papers/2404.13982) (2024)

9.

[Blockage Prediction in Directional mmWave Links Using Liquid Time Constant Network](https://www.emergentmind.com/papers/2306.04997) (2023)

### Topic to Video (Beta)

No one has generated a video about this topic yet.

### Whiteboard

No one has generated a whiteboard explanation for this topic yet.

### Follow Topic

Get notified by email when new papers are published related to **Liquid Time-constant Networks**.

### Continue Learning

1. [How do liquid time-constant mechanisms modulate memory dynamics compared to classical RNNs?](https://www.emergentmind.com/search?q=In+the+context+of+Liquid+Time-constant+Networks%2C+how+do+liquid+time-constant+mechanisms+modulate+memory+dynamics+compared+to+classical+RNNs%3F&search_mode=research)
2. [What numerical integration methods are most effective for handling the stiffness of LTC ODEs?](https://www.emergentmind.com/search?q=In+the+context+of+Liquid+Time-constant+Networks%2C+what+numerical+integration+methods+are+most+effective+for+handling+the+stiffness+of+LTC+ODEs%3F&search_mode=research)
3. [How do solver-free architectures like CfC and Liquid-S4 maintain competitive performance without explicit ODE solvers?](https://www.emergentmind.com/search?q=In+the+context+of+Liquid+Time-constant+Networks%2C+how+do+solver-free+architectures+like+CfC+and+Liquid-S4+maintain+competitive+performance+without+explicit+ODE+solvers%3F&search_mode=research)
4. [What are the implications of LTC designs for energy-efficient deployment in neuromorphic and embedded systems?](https://www.emergentmind.com/search?q=In+the+context+of+Liquid+Time-constant+Networks%2C+what+are+the+implications+of+LTC+designs+for+energy-efficient+deployment+in+neuromorphic+and+embedded+systems%3F&search_mode=research)
5. [Find recent papers about adaptive continuous-time neural networks.](https://www.emergentmind.com/search?q=Find+recent+papers+about+adaptive+continuous-time+neural+networks.&search_mode=search)