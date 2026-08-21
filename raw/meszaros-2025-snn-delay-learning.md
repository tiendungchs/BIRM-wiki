---
title: "Efficient event-based delay learning in spiking neural networks"
source: "https://www.nature.com/articles/s41467-025-65394-8#Abs1"
author:
  - "[[Balázs Mészáros]]"
  - "[[James C. Knight]]"
  - "[[Thomas Nowotny]]"
published: 2025-11-24
created: 2026-06-26
description: "Spiking Neural Networks compute using sparse communication and are attracting increased attention as a more energy-efficient alternative to traditional Artificial Neural Networks. While standard Artificial Neural Networks are stateless, spiking neurons are stateful and hence intrinsically recurrent, making them well-suited for spatio-temporal tasks. However, the duration of this intrinsic memory is limited by synaptic and membrane time constants. Delays are a powerful additional mechanism and, in this paper, we propose an event-based training method for Spiking Neural Networks with delays, grounded in the EventProp formalism, which enables the calculation of exact gradients with respect to weights and delays. Our method supports multiple spikes per neuron and introduces a delay learning algorithm that can, in contrast to previous methods, also be applied to recurrent Spiking Neural Networks. We evaluate our method on a simple sequence detection task, as well as the Yin-Yang, Spiking Heidelberg Digits, Spiking Speech Commands and Braille letter reading datasets, demonstrating that our algorithm can optimise delays from suboptimal initial conditions and enhance classification accuracy compared to architectures without delays. We also find that recurrent delays are particularly beneficial in small networks. Finally, we show that our approach uses less than half the memory of the current state-of-the-art delay-learning method and is up to 26 × faster. Inspired by how neurons in the brain communicate, Spiking Neural Networks are gaining attention as efficient models for solving spatiotemporal AI tasks. The authors introduce a training method for synaptic delays, improving accuracy on benchmark tasks while being faster and more efficient."
tags:
  - "clippings"
---
## Abstract

Spiking Neural Networks compute using sparse communication and are attracting increased attention as a more energy-efficient alternative to traditional Artificial Neural Networks. While standard Artificial Neural Networks are stateless, spiking neurons are stateful and hence intrinsically recurrent, making them well-suited for spatio-temporal tasks. However, the duration of this intrinsic memory is limited by synaptic and membrane time constants. Delays are a powerful additional mechanism and, in this paper, we propose an event-based training method for Spiking Neural Networks with delays, grounded in the EventProp formalism, which enables the calculation of exact gradients with respect to weights and delays. Our method supports multiple spikes per neuron and introduces a delay learning algorithm that can, in contrast to previous methods, also be applied to recurrent Spiking Neural Networks. We evaluate our method on a simple sequence detection task, as well as the Yin-Yang, Spiking Heidelberg Digits, Spiking Speech Commands and Braille letter reading datasets, demonstrating that our algorithm can optimise delays from suboptimal initial conditions and enhance classification accuracy compared to architectures without delays. We also find that recurrent delays are particularly beneficial in small networks. Finally, we show that our approach uses less than half the memory of the current state-of-the-art delay-learning method and is up to 26 × faster.

## Introduction

Artificial Neural Networks (ANNs) have gained immense popularity and seen significant improvements over the past decade. However, commonly used models are very energy intensive [^1], whereas the human brain has an estimated power budget of only 20 W [^2]. It might, therefore, be beneficial to again turn to neuroscience for inspiration. One reason for the brain’s better efficiency is that neurons in the brain transmit sparse binary events called spikes, while the units in ANNs typically communicate real-valued activation values densely in time and space. Spiking Neural Networks (SNNs) leverage the sparse communication patterns of biological neurons for machine learning (ML) and are particularly efficient on neuromorphic systems designed to provide efficient hardware platforms for brain-like computing [^3] [^4] [^5]. Like ANNs, SNNs are universal function approximators, suggesting they could enable an energy-efficient future for ML. Therefore, researchers are increasingly focusing on training SNNs on popular ML tasks, for instance, in the fields of computer vision [^6] and natural language processing [^7]. Since individual spiking neurons rely on hidden temporal dynamics, they have ‘implicit recurrence’ so, even SNNs with feedforward architectures, have theoretical advantages for temporal processing over feedforward networks of stateless units. However, despite this potential, achieving or beating the performance of ANNs using SNNs remains a significant challenge.

The most commonly used training algorithm in ANNs is gradient descent. However, the non-differentiable transitions at spike times cause mathematical complications when calculating gradients in SNNs. To overcome this issue, some researchers do not train SNNs directly but instead train ANNs and then transfer the weights to an SNN for inference [^8] [^9]. However, because this approach typically uses spike counts to represent the activations of ANN units, it does not fully leverage the potential energy savings of sparse spiking in SNNs. While there are more efficient encoding alternatives [^10], one time step in the ANN is still mapped to many timesteps in the SNN and the efficiency of SNNs is not leveraged at training time.

Another popular solution is to discretise the network dynamics and use Backpropagation Through Time (BPTT) with ‘surrogate gradients’ to smooth the threshold function in the backward pass [^11] [^12]. However, this method requires storing neuron state variables at every time step for the backward pass, meaning that memory requirements scale linearly with sequence length. This limits the maximum number of time steps in a trial to a few hundred. Furthermore, this method also does not exploit the increased efficiency of sparse spiking during the backward pass.

Bohte et al.[^11] were the first to show how to calculate exact gradients in SNNs, by providing recursive relations for the gradient that can be implicitly computed using backpropagation. Alternatively, with some constraints on the time constants of neurons, analytic expressions for the time of the next spike of a leaky integrate-and-fire (LIF) can be derived and differentiated [^13] [^14], enabling the calculation of gradients. However, more generally, neurons in SNNs exhibit hybrid dynamics (a longstanding focus in optimal control theory [^15]), combining continuous changes between spikes with discontinuous state transitions at spike times. The link between neural network training and optimal control has been well established [^16], and the adjoint method – a staple of optimal control – has been used to derive gradients for smoothed spiking neuron models without reset [^17]. Also using the adjoint method, Wunderlich and Pehle [^18] developed the EventProp algorithm for calculating exact gradients in SNNs of integrate-and-fire neurons and ‘exponential synapses’. The backward pass in EventProp combines a system of ordinary differential equations for the adjoint variables of the neuron dynamics with purely event-based backward transmission of error signals at spike times, making the best use of the hybrid nature of SNNs. Wunderlich and Pehle tested their method on latency-encoded MNIST [^19] and the Yin-Yang datasets [^20]. More recently, Nowotny et al.[^21] extended EventProp to the more challenging benchmarks of the Spiking Heidelberg Digits (SHD) and Spiking Speech Commands [^22], using loss shaping to overcome issues caused by exact gradients not containing information about spike creation and deletion. The time and space complexity of EventProp enables very efficient GPU training of large models on long sequences [^21], hardware-in-the-loop training [^23], and even training on neuromorphic hardware [^24].

Spiking neurons’ implicit recurrence is characterised by temporal parameters such as the membrane and synaptic time constants. Research has shown that optimising these [^25] [^26] can enhance network performance. Delays are another mechanism for temporal processing, and recent work indicates the utility of learnable delays for temporal tasks [^27] [^28], In biological neural networks, synaptic delays arise naturally due to the spatial structure of the network and can be modified to facilitate coincidence detection [^29] and learning [^30]. From a computational perspective, the inclusion of delays has been shown to significantly increase network capacity [^31] and Maass and Schmitt [^32] demonstrated that an SNN with *k* adjustable delays can compute a much richer class of functions than a network with *k* adjustable weights. Furthermore, neuromorphic systems such as SpiNNaker [^33] and Loihi [^34] are specifically designed to accommodate synaptic delays, so that SNNs with delays can still be efficiently deployed. Adding delays to SNNs has recently gained popularity, with several models treating them as learnable parameters and obtaining state-of-the-art performance on classification tasks [^27] [^28] [^35]. Grappolini and Subramoney [^36] even showed that networks can be trained to comparable performance with pure synaptic delay learning. However, most of these methods are based on surrogate gradients [^27] [^28] [^37], which do not allow the event-based nature of SNNs to be exploited at training time, and some use temporal convolutions to implement delays [^27] [^38], which results in large overheads in memory and computation. DelGrad [^39] was the first exact gradient-based delay learning method, but so far it has only been implemented in feedforward networks where each neuron only emits one spike per trial. No prior work has implemented delay learning for recurrent connections.

Here, we extend EventProp to incorporate heterogeneous and learnable delays and implement our extended version in mlGeNN [^40] [^41] – a spike-based ML library built on the GPU-optimized GeNN simulator [^42] [^43] [^44]. GeNN generates GPU kernels for efficiently simulating networks of neurons which communicate with sparse events using a *hybrid* simulation strategy where the forward and backward dynamics of each neuron are updated every timestep, but synapses are only updated in timesteps where their presynaptic neurons produce a spike. This hybrid strategy differs from the purely time-driven approach (typically used to implement SNNs with standard ML libraries), where neurons and synapses are updated every timestep and also from purely event-based simulators where both neurons and synapses are only updated at spike times. All three approaches have advantages and disadvantages. While a purely timestep-based approach is inherently wasteful, standard ML libraries counteract the inherent inefficiency with highly GPU-optimised matrix multiplication routines to multiply neuron outputs with weights. Pure event-based simulators make efficient use of the event-based nature of SNNs and produce precise spike times, unconstrained by a timestep grid, but this comes at a cost. Only a limited subset of neuron models [^45] [^46] have dynamics that can be directly interpolated between events, algorithms and data structures become increasingly complicated if recurrent connectivity and delays are required [^47] and, the perceived computational advantage of event-based simulation dwindles rapidly as the frequency of events increases [^48]. For example, each input in the SHD dataset fires at ~10 spikes per second. If we consider a hidden neuron densely connected to these inputs, it receives 7000 spikes per second, meaning that an event-based neuron would have to update 7× more frequently than one simulated using a 1 ms timestep.

Nowotny et al.[^21] described the initial GeNN implementation of EventProp, which has subsequently been implemented as a ‘compiler’ [^41] for mlGeNN. Here, we have added delays to the mlGeNN EventProp compiler, enabling the easy exploration of delay learning in a wide range of network architectures. When using our method, increasing the range of delays only requires enlarging a *per-neuron* buffer, resulting in a much lower memory overhead than convolution-based approaches and thus allowing efficient handling of long delays. Our method further allows the outputs of neurons to feed into general spike- and/or voltage-dependent loss functions, offering great flexibility in designing training objectives. Our approach outperforms prior work using EventProp on the SHD and SSC datasets [^21] – achieving superior performance with almost 5× fewer parameters. Additionally, we demonstrate a speedup of up to 26× and memory savings of over 2× compared to surrogate-gradient-based dilated convolutions implemented in PyTorch [^27].

## Results

The EventProp algorithm is an application of the adjoint method for calculating sensitivities in hybrid dynamical systems [^49] [^50] to the problem of calculating the gradient of a loss function in an SNN. From an ML perspective, it can be considered an event-driven form of the popular BPTT gradient descent-based learning in RNNs. The difference is that the gradient computation employs a hybrid approach: the derivatives are determined through both continuous differential equations and discrete state transitions of adjoint variables that occur at saved spike times.

Intuitively, in an SNN, synaptic weights can only affect the network activity, and hence cause loss, at times when a spike is transmitted. The adjoint variables track the potential loss caused by each neuron, and their value at the time of a spike quantifies how much loss that spike contributed to the overall loss, essentially assigning responsibility or “blame” to both the spike event and the synaptic weights involved. For output neurons, blame for loss is directly added to the adjoint variable corresponding to the membrane dynamics (jump in ***λ*** <sub><i>V</i></sub> of the output neuron where ${V}_{\max }$ occurred in Fig. [1](https://www.nature.com/articles/s41467-025-65394-8#Fig1)), while for internal neurons, it propagates backward from downstream connections (jumps in ***λ*** <sub><i>V</i></sub> of the hidden neuron at saved spike times in Fig. [1](https://www.nature.com/articles/s41467-025-65394-8#Fig1)). The gradient for each synaptic weight (*w* <sub><i>j</i> <i>i</i></sub>) accumulates across pre-synaptic firing events, capturing the moments when that connection influenced the post-synaptic neuron’s behaviour and consequently affected network performance. The differential equations governing the adjoint variables precisely track how input fluctuations drive membrane changes that ultimately impact the loss – whether by triggering spikes or directly affecting the output neuron’s contribution to the loss function.

![Fig. 1: Illustration of the original EventProp formalism without delays.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs41467-025-65394-8/MediaObjects/41467_2025_65394_Fig1_HTML.png?as=webp)

Fig. 1: Illustration of the original EventProp formalism without delays.

Here, we derive an extended EventProp formalism that extends the original algorithm in both, that it can be applied to SNNs with delays and that it enables learning of suitable delays, i.e. to calculate gradients of a loss function with respect to delays. Although the EventProp formalism accommodates various neuron models [^51], for simplicity, we will describe it for the LIF neurons and exponential current-based synapses employed by Wunderlich and Pehle [^18].

The forward pass of the SNN is described by first-order ordinary differential equations for the dynamics of the current **I** and voltage **V**; and discontinuous jumps in the variables at the occurrence of spikes (see Table [1](https://www.nature.com/articles/s41467-025-65394-8#Tab1)). Note that this only differs from the forward pass described by Wunderlich and Pehle [^18] due to the delay *d* <sub><i>m</i> <i>n</i></sub> between neuron *n* and neuron *m* which causes the *k* -th jump in the network in the current *I* <sub><i>m</i></sub> of neuron *m* caused by a spike in neuron *n* at time ${t}_{k}^{{{{\rm{spike}}}}}$ to occur at time ${t}_{k}^{{{{\rm{spike}}}}}+{d}_{mn}$, see also Fig. [2](https://www.nature.com/articles/s41467-025-65394-8#Fig2), top. If all *d* <sub><i>m</i> <i>n</i></sub> are zero, this reverts back to the original EventProp formalism.

**Table 1 Forward and backward propagation of a Leaky Integrate-and-Fire (LIF) neuron**

![Fig. 2: Illustration of the extended EventProp algorithm for SNNs with delays.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs41467-025-65394-8/MediaObjects/41467_2025_65394_Fig2_HTML.png?as=webp)

Fig. 2: Illustration of the extended EventProp algorithm for SNNs with delays.

To obtain the backward pass for our network with delays, we take the derivative of the loss function with respect to a weight, *w* <sub><i>j</i> <i>i</i></sub>. The loss function can depend directly on spike timing (which is compatible with the gradient calculation because LIF neuron spike times vary smoothly with weight changes), or it can be expressed as an integral over the voltage **V** (where the integral effectively smooths out the discontinuities that would otherwise make the gradient calculation difficult when spikes occur).

$$
\frac{{{{\rm{d}}}}{{{\mathscr{L}}}}}{{{{\rm{d}}}}{w}_{ji}}=\frac{{{{\rm{d}}}}}{{{{\rm{d}}}}{w}_{ji}}\left[{l}_{p}({{{\mathscr{S}}}})+\int_{t=0}^{T}{l}_{V}({{{\bf{V}}}},t){{{\rm{d}}}}t\right],
$$

(1)

where *l* <sub><i>p</i></sub> is the loss term that depends on the set of output spike times ${{{\mathscr{S}}}}\equiv \{{t}_{k}^{{{{\rm{spike}}}}}\,| \,k=1,\ldots,{N}_{{{{\rm{spike}}}}}\}$, and *l* <sub><i>V</i></sub> is the voltage-dependent loss. Following the adjoint method, we then add Lagrange multipliers ***λ*** <sub><i>I</i></sub> and ***λ*** <sub><i>V</i></sub>, multiplied by the continuous dynamics, which can be interpreted as dynamic constraints,

$$
\frac{{{{\rm{d}}}}{{{\mathscr{L}}}}}{{{{\rm{d}}}}{w}_{ji}}=\frac{{{{\rm{d}}}}}{{{{\rm{d}}}}{w}_{ji}}\left[{l}_{p}({{{\mathscr{S}}}})+\int_{t=0}^{T}\left[{l}_{V}({{{\bf{V}}}},t)+{{{{\boldsymbol{\lambda }}}}}_{V}{{{{\bf{f}}}}}_{V}+{{{{\boldsymbol{\lambda }}}}}_{I}{{{{\bf{f}}}}}_{I}\right]{{{\rm{d}}}}t\right],
$$

(2)

where ${{{{\bf{f}}}}}_{V}\equiv {\tau }_{{{{\rm{m}}}}}\dot{{{{\bf{V}}}}}+{{{\bf{V}}}}-{{{\bf{I}}}}$ encodes the voltage dynamics constraint and ${{{{\bf{f}}}}}_{I}\equiv {\tau }_{{{{\rm{s}}}}}\dot{{{{\bf{I}}}}}+{{{\bf{I}}}}$ the current dynamics constraint.

The essence of the original EventProp derivation was to split the integral in ([2](https://www.nature.com/articles/s41467-025-65394-8#Equ2)) at the *N* <sub>spike</sub> spike times ${t}_{k}^{{{{\rm{spike}}}}}$ when the jumps occur. Between the jumps, everything is well-defined and the standard adjoint method is easily applied – resulting in the backward dynamics for the adjoint variables. With some work (see derivations by Wunderlich and Pehle [^18]), the values of adjoint variables before and after jump times in the backward pass can then be defined so that the remaining expression for the gradient becomes a simple sum over ***λ*** <sub><i>I</i></sub> values at spike times, leading to an event-based weight update rule:

$$
\frac{{{{\rm{d}}}}{{{\mathscr{L}}}}}{{{{\rm{d}}}}{w}_{ji}}=-{\tau }_{{{{\rm{s}}}}}{\sum}_{\left\{{t}_{k}^{{{{\rm{spike}}}}}\,| n(k)=i\right\}}{\lambda }_{I,j}{| }_{{t}_{k}^{{{{\rm{spike}}}}}}.
$$

(3)

We apply a similar approach here, but in our network with delays, spike emission and arrival times become separate events. We address this by extending the set of spike times to the set of all event times that include both spike emission times ${t}_{k}^{{{{\rm{spike}}}}}$ and spike arrival times ${t}_{k}^{{{{\rm{spike}}}}}+{d}_{mn(k)}$, where *n* (*k*) is the index of the neuron that fired the *k* <sup>th</sup> spike:

$$
{{{\mathscr{E}}}}\equiv {{{\mathscr{S}}}}\cup \{{t}_{k}^{{{{\rm{spike}}}}}+{d}_{m,n(k)}\,| \,k=1,\ldots,{N}_{{{{\rm{spike}}}}},m=1,\ldots,N\}.
$$

(4)

We denote the elements of this set as ${t}_{k}^{{{{\rm{event}}}}}\in {{{\mathscr{E}}}}$ and assume that they are ordered such that ${t}_{k}^{{{{\rm{event}}}}}\le {t}_{k{\prime} }^{{{{\rm{event}}}}}$ for $k < k{\prime}$. We can then proceed in the same way as in the original EventProp derivation. The resulting backward pass becomes computable because all delays are nonnegative, meaning that by the time we compute the adjoint variables for the spiking neuron *i* at time *t*, the adjoint variables for the postsynaptic neurons *j* receiving the spike at time *t* + *d* <sub><i>j</i> <i>i</i></sub> will have already been calculated before, in backward time (see Fig. [2](https://www.nature.com/articles/s41467-025-65394-8#Fig2), bottom).

After extensive calculations (Section “Methods”), we arrive at a formula that remains fully event-based for synaptic actions in the backward pass and thus can be efficiently computed,

$$
\frac{{{{\rm{d}}}}{{{\mathscr{L}}}}}{{{{\rm{d}}}}{w}_{ji}}=-{\tau }_{{{{\rm{s}}}}}{\sum}_{\left\{{t}_{k}^{{{{\rm{spike}}}}}\,| n(k)=i\right\}}{\lambda }_{I,j}{| }_{{t}_{k}^{{{{\rm{spike}}}}}+{d}_{ji}}.
$$

(5)

Using the same approach, we can also derive the derivative of the loss function with respect to the delays *d* <sub><i>j</i> <i>i</i></sub>. Remarkably, the derived backward dynamics of the adjoint variables remain the same, meaning that using the exact same ***λ*** <sub><i>I</i></sub> and ***λ*** <sub><i>V</i></sub> dynamics in the backward pass, we *can also perform gradient descent on synaptic delays in an event-based manner*. The resulting formula for the delay gradients is

$$
\frac{{{{\rm{d}}}}{{{\mathscr{L}}}}}{{{{\rm{d}}}}{d}_{ji}}=-{w}_{ji}{\sum}_{\left\{{t}_{k}^{{{{\rm{spike}}}}}\,| n(k)=i\right\}}({\lambda }_{I,j}-{\lambda }_{V,j}){| }_{{t}_{k}^{{{{\rm{spike}}}}}+{d}_{ji}}.
$$

(6)

We thus end up with an event-based weight and delay learning algorithm, which enables delay learning in networks with multiple recurrently-connected layers and with multiple spikes per neuron.

### Sequence detection task

To test the effectiveness of our method, we evaluated it in various machine learning settings. First, we generated a simple binary classification task that can be solved with perfect accuracy using optimal delays. Specifically, we used two LIF neurons connected to two LI neurons (see Table [1](https://www.nature.com/articles/s41467-025-65394-8#Tab1)), with all connection strengths set to 1. The task involves two classes:

- Class 1: The first input neuron emits a spike at 0 ms, and the second emits a spike at 10 ms.
- Class 2: The first input neuron emits a spike at 10 ms, and the second emits a spike at 0 ms.

The output of the network is determined based on the maximum voltage reached by the two output neurons, each corresponding to one of the output classes. The class associated with the neuron that reaches the higher voltage is selected as the network’s prediction. We can observe that having 10 in the diagonals and 0 everywhere else in our 2 × 2 delay matrix solves the task. We started with the least optimal delay distribution – delays on the diagonals being 0, and 10 everywhere else – and, with the learning rate set to 1, we achieve 100% accuracy after encountering both examples 6 times. This result demonstrates that, by introducing our delay updates into the learning framework, SNNs become capable of not only coincidence but sequence detection. Figure [3](https://www.nature.com/articles/s41467-025-65394-8#Fig3) illustrates the gradient calculation in this task.

![Fig. 3: Illustration of the learning updates in the sequence detection task.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs41467-025-65394-8/MediaObjects/41467_2025_65394_Fig3_HTML.png?as=webp)

Fig. 3: Illustration of the learning updates in the sequence detection task.

### Yin-Yang dataset

We also experimented with the Yin-Yang dataset [^20], which has been tested using both EventProp (without delays) [^18] and DelGrad [^39], see Fig. [4](https://www.nature.com/articles/s41467-025-65394-8#Fig4). Similarly to DelGrad, we looked at feedforward networks and varied the size of the hidden layer from 5 to 30. We initialised all delays at 0, allowing them to evolve in the range of 0–10 during training. DelGrad also applies a sigmoid on the delays, but in our experiments we deemed it unnecessary. Otherwise, our implementation is very close to DelGrad – we implemented a similar weight-bumping mechanism, and allowed neurons to only spike once by increasing the refractory period to a value higher than the sequence length. We also trained using the time-invariant mean squared error loss [^39], see section “Methods” for derivation. Our findings are similar to DelGrad – with a fixed number of parameters, networks perform similarly (i.e. halving the number of hidden neurons does not decrease performance if delays are introduced). If the number of parameters is not a constraining factor, training delays *and* weights is always advantageous. We achieve the same performance, which is expected, given the equivalence of the gradients [^52].

![Fig. 4: Yin-Yang results.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs41467-025-65394-8/MediaObjects/41467_2025_65394_Fig4_HTML.png?as=webp)

Fig. 4: Yin-Yang results.

### Spiking Heidelberg digits

Nowotny, Turner, and Knight [^21] achieved state-of-the-art results on SHD with a ‘delay line’ approach, which involved creating 10 copies of the input and cumulatively delaying each by 30 ms. While this architecture achieved high accuracy, it required a large number of parameters, so we instead experimented with learnt delays in the input-to-hidden and hidden-to-hidden connections. For controlling the training dynamics in the hidden population, a target firing rate needs to be set, with the corresponding spike regularisation strength. We kept our target firing rate fixed at 14 spikes per example and treated the regularisation strength as a tunable hyperparameter, which we optimised using 10-fold cross-validation, leaving one speaker out of the training set in each fold. Tuning this parameter was crucial (particularly for networks with recurrent connectivity) and once we identified the best-performing model in cross-validation, we retrained it with the same parameters on the full training set. We enforced early stopping if training accuracy did not improve for 15 epochs. Using this methodology, our best model achieved a training accuracy of 98.47 ± 0.4% and a test accuracy of 93.24 ± 1.0% as depicted in Fig. [5](https://www.nature.com/articles/s41467-025-65394-8#Fig5). This configuration included 512 hidden neurons with recurrent connections. The feedforward delays were initialised from a uniform distribution in the range of 0–150 ms, while the recurrent delays were all initialised to 0 ms. The difference between these results and those reported using the ‘delay line’ approach (93.5 ± 0.7% [^21]) are not statistically significant (*p* = 0.442, t-test, *n* = 8), and we achieved them with around 5 times fewer parameters. We also experimented with different hidden layer sizes and feedforward models. We found that decreasing the hidden neuron number to 256 does not significantly decrease the accuracy for either architecture. However, if we decrease the number of neurons even further to 128, we observe a significant drop for the feedforward architecture but not for the recurrent one. Increasing the hidden layer to 1024 neurons leads to overfitting.

![Fig. 5: Spiking Heidelberg Digits results.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs41467-025-65394-8/MediaObjects/41467_2025_65394_Fig5_HTML.png?as=webp)

Fig. 5: Spiking Heidelberg Digits results.

While state-of-the-art models – such as the work by Hammouamri, Khalfaoui-Hassani, and Masquelier [^27], Deckers et al.[^35], and Sun et al.[^53] – reported higher accuracies, these were obtained using the test set for validation and early stopping, rather than using a separate validation set. Schöne et al.[^54] mention that they also evaluate in this way to achieve a “fair comparison to others”. However, as Baronig et al.[^55] argued, not only is this not methodologically “clean” but it may also not be entirely fair due to potential overfitting (we note that the highest test accuracy we observed was 95.32%). Furthermore, we also note that model performance on the SHD dataset is nearing saturation, with the best-performing models achieving an accuracy of around 93%. Following Isaksson et al.[^56] and Nowotny [^57], we calculated the Bayesian confidence intervals with naive assumptions on error rates. 93% accuracy has overlapping confidence intervals with higher accuracies (e.g., 94% and 95%), indicating that further improvements in accuracy are likely not statistically meaningful given the test set size (2264) [^57].

### Spiking speech commands

SSC is significantly more challenging than SHD as the audio recordings were created in noisy environments, and the dataset has more classes. We initially experimented with single recurrent hidden layer architectures similar to those employed by Nowotny, Turner, and Knight [^21] and, after replacing the delay line inputs with learnable delays, we achieved similar performance. Interestingly, we observed little to no benefit of adding delays to larger networks but, as we decreased the number of hidden neurons, the delays became highly beneficial. While many state-of-the-art models use deeper architectures with more hidden layers [^27] [^55] [^58], we found that deeper architectures with recurrent connections became highly unstable even without delays in the connections. Therefore, to improve upon previous results, we explored deeper *feedforward* architectures with delays and found the best performing architecture to be a model with 2 feedforward hidden layers.

Our results are shown in Fig. [6](https://www.nature.com/articles/s41467-025-65394-8#Fig6). Our best model achieved a training accuracy of 79.6 ± 1.0%, a validation accuracy of 78.1 ± 1.0% (*n*  = 8) and a test accuracy of 76.1 ± 1.0%. We also experimented with smaller models, which as expected, achieved a lower training accuracies. Compared to other SNNs with delays, we observe that we outperform Sadovsky, Jakubec, and Jarina [^59], with their test accuracy results at 72.03%. Deckers et al.[^35] introduced a constrained adaptive LIF neuron model to a delayed network and reached 80.23% test accuracy. They also tested LIF models, achieving 75.94%, which we slightly outperformed.

![Fig. 6: Spiking Speech Commands results.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs41467-025-65394-8/MediaObjects/41467_2025_65394_Fig6_HTML.png?as=webp)

Fig. 6: Spiking Speech Commands results.

### Braille letter reading

As highlighted by Walters et al.[^60], most neuromorphic benchmarks contain more spatial than temporal information. Although the SHD and SSC datasets *do* contain temporal information, it may not be important enough to require the fine timesteps our approach enables. Therefore, we also evaluated our approach on a braille letter reading dataset [^61].

We again trained, validated and tested 2-layer feedforward and single-layer recurrent networks with and without delays and with hidden layers of various sizes (64, 128, 256, 512, 1024) on the 70: 10: 20 training, validation, and test splits provided by Müller-Cleve et al.[^61]. The results shown in Fig. [7](https://www.nature.com/articles/s41467-025-65394-8#Fig7) show a similar pattern to the SSC results – introducing delays in large recurrent networks shows no benefit, but adding them to smaller networks significantly improves performance.

![Fig. 7: Braille letter reading results.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs41467-025-65394-8/MediaObjects/41467_2025_65394_Fig7_HTML.png?as=webp)

Fig. 7: Braille letter reading results.

Our best-performing model had two feedforward hidden layers, with 1024 neurons each, and achieved 83.1 ± 1.5% on the test set. This model outperforms the recurrent network with a single hidden layer of 450 neurons and 8 input copies described in the original publication [^61], which obtained a test accuracy of 80.9 ± 0.3%. Our smaller feedforward network with hidden layers of size 256 achieved a test accuracy of 81.0 ± 0.7% so also outperformed Müller-Cleve et al.[^61], with half the number of parameters. Additionally, Müller-Cleve et al.[^61] evaluated their models using an 80: 20 training-test split without a validation set, which is problematic for the same reasons identified in SHD dataset studies. Pedersen et al.[^62] previously trained on this dataset but simplified it to 7 classes to accommodate the Xylo chip [^63]. We are not aware of any other research involving delay learning on this dataset.

### Training efficiency

Finally, we benchmarked our training procedure against the Dilated Convolution implementation provided by Hammouamri, Khalfaoui-Hassani, and Masquelier [^27] using PyTorch 2.5.1 and SpikingJelly 0.0.0.0.15 [^64]. Because the Dilated Convolution method does not support recurrent delays, we benchmarked feedforward models with 2 hidden layers. We measured the peak memory utilisation of mlGeNN using the “nvidia-smi” command line tool – as GeNN allocates memory from CUDA directly – and of PyTorch using torch.cuda.max\_memory\_allocated – so details of the memory allocator are disregarded.

The benchmarking results are illustrated in Fig. [8](https://www.nature.com/articles/s41467-025-65394-8#Fig8). Because increasing the maximum number of delay slots in mlGeNN only involves increasing the size of a *per-neuron* buffer rather than increasing the size of a *per-synapse* kernel, longer delays have much lower memory requirements in mlGeNN (Fig. [8](https://www.nature.com/articles/s41467-025-65394-8#Fig8) A). Similarly, the increasing computational cost of convolving larger and larger kernels means that training time increases rapidly when using Dilated Convolutions (Fig. [8](https://www.nature.com/articles/s41467-025-65394-8#Fig8) B), whereas with mlGeNN, there is only a very small initial increase in training time as the maximum number of delay timesteps increases. Other gradient-based delay learning methods [^28] [^37] [^38] do not use temporal convolutions, so their memory and computational requirements would not grow *as* quickly, but they are all still based on dense BPTT so – based on benchmarking performed by Nowotny, Turner, and Knight [^21] – we would still expect mlGeNN to be significantly faster and use less memory.

![Fig. 8: Comparing cost of training networks with delays using EventProp and mlGeNN against Dilated Convolutions (DC) implemented using SpikingJelly and PyTorch.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs41467-025-65394-8/MediaObjects/41467_2025_65394_Fig8_HTML.png?as=webp)

Fig. 8: Comparing cost of training networks with delays using EventProp and mlGeNN against Dilated Convolutions (DC) implemented using SpikingJelly and PyTorch.

The slight increase in mlGeNN training time observed as the maximum number of delay timesteps increases is likely due to the effects of caching on the delay buffers. These buffers are allocated in GPU global memory, so the efficiency of updating them depends on whether they persist in the GPU’s caches for long enough for locality in the delays to be exploited. At the large batch sizes used for these experiments, the complete buffers will not fit in the 6 MiB L2 cache of the RTX A5000 GPU so the effects seen here are likely due to an increase in the rate at which delay buffer data gets evicted from the cache as the size of the buffers increases.

## Discussion

Delays in Spiking Neural Networks have been extensively studied from both machine learning and computational neuroscience perspectives, with recent interest spurred by their ability to improve performance in machine learning applications [^27] [^37]. Delays can be efficiently implemented on several neuromorphic chips [^33] [^34], but, as is the case with much of current neuromorphic research, there is a lack of focus on delay *learning* algorithms that could be implemented on future neuromorphic hardware. Instead, many methods rely on arithmetically intensive approaches that are only practical on GPUs, such as convolutions in networks trained with BPTT with surrogate gradients. Our method combines the best of both worlds: its theoretical foundations enable efficient implementation on neuromorphic hardware (EventProp has already been implemented in SpiNNaker 2 [^33]), while our GeNN-based implementation takes advantage of readily available GPU hardware. This versatility allows us to address a broader range of platforms while improving performance on complex temporal tasks.

The beneficial scaling of EventProp allows long sequence lengths and hence finer timesteps, which might offer enhanced precision in spatio-temporal tasks. However, leading models on SHD and SSC employ large timesteps of 10 or even 25 ms [^27] [^58] and, while these coarser time grids may have been primarily chosen to fit within GPU memory, they could also simplify the tasks by reducing their effective sequence length (assuming high temporal precision is not required). This reflects a broader challenge in SNN research: while neuromorphic architectures are appealing for their energy efficiency and temporal precision, it remains unclear how much temporal precision is needed for any given task and how it is best exploited in practice. Timestep length also has additional relevance for delay learning, as delays are discretised to integer multiples of the timestep. However, our previous work indicates that the speech recognition tasks considered here may not require precise delays [^65].

Another open question regards initialisation. While synaptic weights can be initialised in a straightforward manner by sampling from a normal distribution centred around zero, the initialisation of delays is less intuitive. Experimental observations of delay distributions are challenging to interpret [^66], and the optimal distribution may depend heavily on the task. We followed the common approach of initialising delays with values sampled from uniform distributions [^27]. However, interestingly, we observed that while a few delays grew considerably, most remained relatively short. This distribution might reflect a small-world network structure, where most neurons connect to nearby neighbours (short delays) with only a few long-range connections (long delays).

As we show across multiple datasets, recurrent delays can offer substantial advantages when implementing networks with stricter size constraints. However, initialising recurrent delay distributions poses additional computational challenges. Initialising feedforward delays within the range $[0,{d}_{\max }]$ is logical, as adding a homogeneous delay *x* would yield the same outcomes within the range $[x,{d}_{\max }+x]$. However, this symmetry does not extend to recurrent delays, making their initialisation significantly more complex. Recent studies have focused on optimising delay distributions at the network level [^67], but the question of layer-specific initialisation remains open.

This work showed the benefit of delays on datasets commonly used to benchmark SNNs. Exploring them in other tasks where they could be particularly beneficial (e.g. sound localisation [^68], or motion detection [^69] [^70]) is an interesting avenue for future work.

## Methods

### Theory

#### Learning weights in networks with delay

We start by defining our two differential equations in the implicit form for the membrane potentials and input currents, respectively.

$$
{{{{\bf{f}}}}}_{V}\equiv {\tau }_{{{{\rm{m}}}}}\dot{{{{\bf{V}}}}}+{{{\bf{V}}}}-{{{\bf{I}}}}=0
$$

(7)

$$
{{{{\bf{f}}}}}_{I}\equiv {\tau }_{{{{\rm{s}}}}}\dot{{{{\bf{I}}}}}+{{{\bf{I}}}}=0
$$

(8)

In the following, we will assume that all event times ${{{\mathscr{E}}}}$ are distinct, both in terms of spikes occurring and of spikes arriving. In continuous time, this is not unlikely, but also, as argued in ref. [^18], the equations do not break down if spikes occur or arrive at the same time. Then,

$$
\frac{{{{\rm{d}}}}{{{\mathscr{L}}}}}{{{{\rm{d}}}}{w}_{ji}}=\frac{{{{\rm{d}}}}}{{{{\rm{d}}}}{w}_{ji}}\left[{l}_{p}({{{\mathscr{S}}}})+{\sum}_{{t}_{k}^{{{{\rm{event}}}}}\in {{{\mathscr{E}}}}}\int_{{t}_{k}^{{{{\rm{event}}}}}}^{{t}_{k+1}^{{{{\rm{event}}}}}}\left[{l}_{V}({{{\bf{V}}}},t)+{{{{\boldsymbol{\lambda }}}}}_{V}\cdot {{{{\bf{f}}}}}_{V}+{{{{\boldsymbol{\lambda }}}}}_{I}\cdot {{{{\bf{f}}}}}_{I}\right]{{{\rm{d}}}}t\right]
$$

(9)

where we have added the product of adjoint variables and dynamics functions to the loss function as the adjoint method dictates. This is possible because for solutions of the forward dynamics, **f** <sub><i>V</i></sub> and **f** <sub><i>I</i></sub> are identically zero at all times. Using

$$
\frac{\partial {{{{\bf{f}}}}}_{V}}{\partial {w}_{ji}}={\tau }_{{{{\rm{m}}}}}\frac{{{{\rm{d}}}}}{{{{\rm{d}}}}t}\frac{\partial {{{\bf{V}}}}}{\partial {w}_{ji}}+\frac{\partial {{{\bf{V}}}}}{\partial {w}_{ji}}-\frac{\partial {{{\bf{I}}}}}{\partial {w}_{ji}}
$$

(10)

$$
\frac{\partial {{{{\bf{f}}}}}_{I}}{\partial {w}_{ji}}={\tau }_{{{{\rm{s}}}}}\frac{{{{\rm{d}}}}}{{{{\rm{d}}}}t}\frac{\partial {{{\bf{I}}}}}{\partial {w}_{ji}}+\frac{\partial {{{\bf{I}}}}}{\partial {w}_{ji}},
$$

(11)

we can apply the derivative on the right-hand side of ([9](https://www.nature.com/articles/s41467-025-65394-8#Equ9)) to obtain

$$
\begin{aligned}
\frac{{{{\rm{d}}}}{{{\mathscr{L}}}}}{{{{\rm{d}}}}{w}_{ji}}= 	 {\sum}_{{t}_{k}^{{{{\rm{spike}}}}}\in {{{\mathscr{S}}}}}\frac{\partial {l}_{p}}{\partial {t}_{k}^{{{{\rm{spike}}}}}}\frac{{{{\rm{d}}}}{t}_{k}^{{{{\rm{spike}}}}}}{{{{\rm{d}}}}{w}_{ji}}\\ 	 +{\sum}_{{t}_{k}^{{{{\rm{event}}}}}\in {{{\mathscr{E}}}}}\int_{{t}_{k}^{{{{\rm{event}}}}}}^{{t}_{k+1}^{{{{\rm{event}}}}}}\left[\frac{\partial {l}_{V}}{\partial {{{\bf{V}}}}}\cdot \frac{\partial {{{\bf{V}}}}}{\partial {w}_{ji}}+{{{{\boldsymbol{\lambda }}}}}_{V}\cdot \left({\tau }_{{{{\rm{m}}}}}\frac{{{{\rm{d}}}}}{{{{\rm{d}}}}t}\frac{\partial {{{\bf{V}}}}}{\partial {w}_{ji}}+\frac{\partial {{{\bf{V}}}}}{\partial {w}_{ji}}-\frac{\partial {{{\bf{I}}}}}{\partial {w}_{ji}}\right)\right.\\ 	 \left.+{{{{\boldsymbol{\lambda }}}}}_{I}\cdot \left({\tau }_{{{{\rm{s}}}}}\frac{{{{\rm{d}}}}}{{{{\rm{d}}}}t}\frac{\partial {{{\bf{I}}}}}{\partial {w}_{ji}}+\frac{\partial {{{\bf{I}}}}}{\partial {w}_{ji}}\right)\right]{{{\rm{d}}}}t\\ 	 +{l}_{V,k+1}^{-}\frac{{{{\rm{d}}}}{t}_{k+1}^{{{{\rm{event}}}}}}{{{{\rm{d}}}}{w}_{ji}}-{l}_{V,k}^{+}\frac{{{{\rm{d}}}}{t}_{k}^{{{{\rm{event}}}}}}{{{{\rm{d}}}}{w}_{ji}}
\end{aligned}
$$

(12)

Using partial integration, we can rewrite

$$
\int_{{t}_{k}^{{{{\rm{event}}}}}}^{{t}_{k+1}^{{{{\rm{event}}}}}}{{{{\boldsymbol{\lambda }}}}}_{V}\cdot \frac{{{{\rm{d}}}}}{{{{\rm{d}}}}t}\frac{\partial {{{\bf{V}}}}}{\partial {w}_{ji}}{{{\rm{d}}}}t=-\int_{{t}_{k}^{{{{\rm{event}}}}}}^{{t}_{k+1}^{{{{\rm{event}}}}}}{\dot{{{{\boldsymbol{\lambda }}}}}}_{V}\cdot \frac{\partial {{{\bf{V}}}}}{\partial {w}_{ji}}{{{\rm{d}}}}t+{\left[{{{{\boldsymbol{\lambda }}}}}_{V}\cdot \frac{\partial {{{\bf{V}}}}}{\partial {w}_{ji}}\right]}_{{t}_{k}^{{{{\rm{event}}}}}}^{{t}_{k+1}^{{{{\rm{event}}}}}}
$$

(13)

and

$$
\int_{{t}_{k}^{{{{\rm{event}}}}}}^{{t}_{k+1}^{{{{\rm{event}}}}}}{{{{\boldsymbol{\lambda }}}}}_{I}\cdot \frac{{{{\rm{d}}}}}{{{{\rm{d}}}}t}\frac{\partial {{{\bf{I}}}}}{\partial {w}_{ji}}{{{\rm{d}}}}t=-\int_{{t}_{k}^{{{{\rm{event}}}}}}^{{t}_{k+1}^{{{{\rm{event}}}}}}{\dot{{{{\boldsymbol{\lambda }}}}}}_{I}\cdot \frac{\partial {{{\bf{I}}}}}{\partial {w}_{ji}}{{{\rm{d}}}}t+{\left[{{{{\boldsymbol{\lambda }}}}}_{I}\cdot \frac{\partial {{{\bf{I}}}}}{\partial {w}_{ji}}\right]}_{{t}_{k}^{{{{\rm{event}}}}}}^{{t}_{k+1}^{{{{\rm{event}}}}}}.
$$

(14)

Inserting this into ([12](https://www.nature.com/articles/s41467-025-65394-8#Equ12)), we get

$$
\begin{aligned}
\frac{{{{\rm{d}}}}{{{\mathscr{L}}}}}{{{{\rm{d}}}}{w}_{ji}}= 	 {\sum}_{{t}_{k}^{{{{\rm{spike}}}}}\in {{{\mathscr{S}}}}}\frac{\partial {l}_{p}}{\partial {t}_{k}^{{{{\rm{spike}}}}}}\frac{{{{\rm{d}}}}{t}_{k}^{{{{\rm{spike}}}}}}{{{{\rm{d}}}}{w}_{ji}}\\ 	 +{\sum}_{{t}_{k}^{{{{\rm{event}}}}}\in {{{\mathscr{E}}}}}\int_{{t}_{k}^{{{{\rm{event}}}}}}^{{t}_{k+1}^{{{{\rm{event}}}}}}\left[\left(\frac{\partial {l}_{V}}{\partial {{{\bf{V}}}}}-{\tau }_{{{{\rm{m}}}}}{\dot{{{{\boldsymbol{\lambda }}}}}}_{V}+{{{{\boldsymbol{\lambda }}}}}_{V}\right)\cdot \frac{\partial {{{\bf{V}}}}}{\partial {w}_{ji}}+(-{\tau }_{{{{\rm{s}}}}}{\dot{{{{\boldsymbol{\lambda }}}}}}_{I}+{{{{\boldsymbol{\lambda }}}}}_{I}-{{{{\boldsymbol{\lambda }}}}}_{V})\cdot \frac{\partial {{{\bf{I}}}}}{\partial {w}_{ji}}\right]{{{\rm{d}}}}t\\ 	 +{\tau }_{{{{\rm{m}}}}}{\left[{{{{\boldsymbol{\lambda }}}}}_{V}\cdot \frac{\partial {{{\bf{V}}}}}{\partial {w}_{ji}}\right]}_{{t}_{k}^{{{{\rm{event}}}}}}^{{t}_{k+1}^{{{{\rm{event}}}}}}+{\tau }_{{{{\rm{s}}}}}{\left[{{{{\boldsymbol{\lambda }}}}}_{I}\cdot \frac{\partial {{{\bf{I}}}}}{\partial {w}_{ji}}\right]}_{{t}_{k}^{{{{\rm{event}}}}}}^{{t}_{k+1}^{{{{\rm{event}}}}}}\\ 	 +{l}_{V,k+1}^{-}\frac{{{{\rm{d}}}}{t}_{k+1}^{{{{\rm{event}}}}}}{{{{\rm{d}}}}{w}_{ji}}-{l}_{V,k}^{+}\frac{{{{\rm{d}}}}{t}_{k}^{{{{\rm{event}}}}}}{{{{\rm{d}}}}{w}_{ji}}
\end{aligned}
$$

(15)

where the last two terms arise from the derivative of the bounds of the integral in the Leibniz rule. We now define the backwards dynamics of the adjoint variables as usual [^18],

$$
{\tau }_{{{{\rm{m}}}}}{{{{\boldsymbol{\lambda }}}}}_{V}^{{\prime} }=-{{{{\boldsymbol{\lambda }}}}}_{V}-\frac{\partial {l}_{V}}{\partial {{{\bf{V}}}}}
$$

(16)

$$
{\tau }_{{{{\rm{s}}}}}{{{{\boldsymbol{\lambda }}}}}_{I}^{{\prime} }=-{{{{\boldsymbol{\lambda }}}}}_{I}+{{{{\boldsymbol{\lambda }}}}}_{V}
$$

(17)

which cancels the terms containing $\frac{\partial {{{\bf{V}}}}}{\partial {w}_{ji}}$ and $\frac{\partial {{{\bf{I}}}}}{\partial {w}_{ji}}$, so that we get

$$
\begin{aligned}
\frac{{{{\rm{d}}}}{{{\mathscr{L}}}}}{{{{\rm{d}}}}{w}_{ji}} =	 {\sum}_{{t}_{k}^{{{{\rm{spike}}}}}\in {{{\mathscr{S}}}}}\frac{\partial {l}_{p}}{\partial {t}_{k}^{{{{\rm{spike}}}}}}\frac{{{{\rm{d}}}}{t}_{k}^{{{{\rm{spike}}}}}}{{{{\rm{d}}}}{w}_{ji}}+{\sum}_{{t}_{k}^{{{{\rm{event}}}}}\in {{{\mathscr{E}}}}}\left({l}_{V,k}^{-}\frac{{{{\rm{d}}}}{t}_{k}^{{{{\rm{event}}}}}}{{{{\rm{d}}}}{w}_{ji}}-{l}_{V,k}^{+}\frac{{{{\rm{d}}}}{t}_{k}^{{{{\rm{event}}}}}}{{{{\rm{d}}}}{w}_{ji}}\right.\\ 	+\left.{\left.\left[{\tau }_{{{{\rm{m}}}}}\left({{{{\boldsymbol{\lambda }}}}}_{V}^{-}\cdot \frac{\partial {{{{\bf{V}}}}}^{-}}{\partial {w}_{ji}}-{{{{\boldsymbol{\lambda }}}}}_{V}^{+}\cdot \frac{\partial {{{{\bf{V}}}}}^{+}}{\partial {w}_{ji}}\right)+{\tau }_{{{{\rm{s}}}}}\left({{{{\boldsymbol{\lambda }}}}}_{I}^{-}\cdot \frac{\partial {{{{\bf{I}}}}}^{-}}{\partial {w}_{ji}}-{{{{\boldsymbol{\lambda }}}}}_{I}^{+}\cdot \frac{\partial {{{{\bf{I}}}}}^{+}}{\partial {w}_{ji}}\right)\right]\right\vert }_{{t}_{k}^{{{{\rm{event}}}}}}\right)
\end{aligned}
$$

(18)

The sum over events in ${{{\mathscr{E}}}}$ extends over spike emission times ${t}_{k}^{{{{\rm{spike}}}}}$ and spike arrival times. We first focus on the spike emission times ${t}_{k}^{{{{\rm{spike}}}}}$. Before the jump at ${t}_{k}^{{{{\rm{spike}}}}}$ we have,

$$
{V}_{n(k)}^{-}-\vartheta=0,
$$

(19)

where *n* (*k*) denotes the spiking neuron at event *k*. If we take the derivative of this equation, we get, using the chain rule,

$$
\frac{\partial {V}_{n(k)}^{-}}{\partial {w}_{ji}}+{\dot{V}}_{n(k)}^{-}\frac{{{{\rm{d}}}}{t}_{k}^{{{{\rm{spike}}}}}}{{{{\rm{d}}}}{w}_{ji}}=0
$$

(20)

$$
\Rightarrow \quad \frac{{{{\rm{d}}}}{t}_{k}^{{{{\rm{spike}}}}}}{{{{\rm{d}}}}{w}_{ji}}=-\frac{1}{{\dot{V}}_{n(k)}^{-}}\frac{\partial {V}_{n(k)}^{-}}{\partial {w}_{ji}},
$$

(21)

and after the jump,

$$
{V}_{n(k)}^{+}=0
$$

(22)

$$
\Rightarrow \quad \frac{\partial {V}_{n(k)}^{+}}{\partial {w}_{ji}}+{\dot{V}}_{n(k)}^{+}\frac{{{{\rm{d}}}}{t}_{k}^{{{{\rm{spike}}}}}}{{{{\rm{d}}}}{w}_{ji}}=0\,.
$$

(23)

Inserting ([21](https://www.nature.com/articles/s41467-025-65394-8#Equ21)) into ([23](https://www.nature.com/articles/s41467-025-65394-8#Equ23)) we obtain as usual [^18]

$$
\frac{\partial {V}_{n(k)}^{+}}{\partial {w}_{ji}}=\frac{{\dot{V}}_{n(k)}^{+}}{{\dot{V}}_{n(k)}^{-}}\frac{\partial {V}_{n(k)}^{-}}{\partial {w}_{ji}}.
$$

(24)

For the current *I* <sub><i>n</i> (<i>k</i>)</sub>, there is no jump at ${t}_{k}^{{{{\rm{spike}}}}}$, and also not in its derivative: ${I}_{n(k)}^{+}={I}_{n(k)}^{-}$ and ${\dot{I}}_{n(k)}^{+}={\dot{I}}_{n(k)}^{-}$ implies

$$
\frac{\partial {I}_{n(k)}^{+}}{\partial {w}_{ji}}=\frac{\partial {I}_{n(k)}^{-}}{\partial {w}_{ji}}.
$$

(25)

Let us now consider what happens at the spike arrival times, when the spike *k* at ${t}_{k}^{{{{\rm{spike}}}}}$ is received at all the postsynaptic neurons *m* at times ${t}_{k}^{{{{\rm{spike}}}}}+{d}_{mn(k)}$ (i.e. we look at ${{{\mathscr{E}}}}\setminus {{{\mathscr{S}}}}$). Note that this is where EventProp with delays becomes substantially different from standard EventProp, where spike emission and arrival times are the same. At spike arrival, the input current of the receiving neurons jumps,

$$
{I}_{m}^{+}={I}_{m}^{-}+{w}_{mn(k)}.
$$

(26)

By taking the derivative with respect to *w* <sub><i>j</i> <i>i</i></sub>, we get

$$
\frac{\partial {I}_{m}^{+}}{\partial {w}_{ji}}+{\dot{I}}_{m}^{+}\frac{{{{\rm{d}}}}{t}_{k}^{{{{\rm{spike}}}}}}{{{{\rm{d}}}}{w}_{ji}}=\frac{\partial {I}_{m}^{-}}{\partial {w}_{ji}}+{\dot{I}}_{m}^{-}\frac{{{{\rm{d}}}}{t}_{k}^{{{{\rm{spike}}}}}}{{{{\rm{d}}}}{w}_{ji}}+{\delta }_{in(k)}{\delta }_{jm},
$$

(27)

where we have used that $\frac{{{{\rm{d}}}}({t}_{k}^{{{{\rm{spike}}}}}+{d}_{mn(k)})}{{{{\rm{d}}}}{w}_{ji}}=\frac{{{{\rm{d}}}}{t}_{k}^{{{{\rm{spike}}}}}}{{{{\rm{d}}}}{w}_{ji}}$. Now, using the dynamics equations for **I**, we also have

$$
{\tau }_{{{{\rm{s}}}}}{\dot{I}}_{m}^{+}={\tau }_{{{{\rm{s}}}}}{\dot{I}}_{m}^{-}-{w}_{mn(k)},
$$

(28)

and hence,

$$
\begin{aligned}
\frac{\partial {I}_{m}^{+}}{\partial {w}_{ji}}=	 \frac{\partial {I}_{m}^{-}}{\partial {w}_{ji}}+{\tau }_{{{{\rm{s}}}}}^{-1}{w}_{mn(k)}\frac{{{{\rm{d}}}}{t}_{k}^{{{{\rm{spike}}}}}}{{{{\rm{d}}}}{w}_{ji}}+{\delta }_{in(k)}{\delta }_{jm}\\ =	\frac{\partial {I}_{m}^{-}}{\partial {w}_{ji}}+{\left.\left[\frac{1}{{\tau }_{{{{\rm{s}}}}}{\dot{V}}_{n(k)}^{-}}{w}_{mn(k)}\frac{\partial {V}_{n(k)}^{-}}{\partial {w}_{ji}}\right]\right\vert }_{{t}_{k}^{{{{\rm{spike}}}}}+{d}_{mn(k)}}+{\delta }_{in(k)}{\delta }_{jm}
\end{aligned}
$$

(29)

where we have used ([21](https://www.nature.com/articles/s41467-025-65394-8#Equ21)) to replace $\frac{{{{\rm{d}}}}{t}_{k}^{{{{\rm{spike}}}}}}{{{{\rm{d}}}}{w}_{ji}}$. Since we have ${V}_{m}^{+}={V}_{m}^{-}$ for non-spiking neurons,

$$
\frac{\partial {V}_{m}^{+}}{\partial {w}_{ji}}+{\dot{V}}_{m}^{+}\frac{{{{\rm{d}}}}{t}_{k}^{{{{\rm{spike}}}}}}{{{{\rm{d}}}}{w}_{ji}}=\frac{\partial {V}_{m}^{-}}{\partial {w}_{ji}}+{\dot{V}}_{m}^{-}\frac{{{{\rm{d}}}}{t}_{k}^{{{{\rm{spike}}}}}}{{{{\rm{d}}}}{w}_{ji}}.
$$

(30)

From Eq. ([26](https://www.nature.com/articles/s41467-025-65394-8#Equ26)) and the dynamics equations for **V** we know

$$
{\tau }_{{{{\rm{m}}}}}{\dot{V}}_{m}^{+}={\tau }_{{{{\rm{m}}}}}{\dot{V}}_{m}^{-}+{w}_{mn(k)}.
$$

(31)

Putting this together, we get

$$
\frac{\partial {V}_{m}^{+}}{\partial {w}_{ji}}=\frac{\partial {V}_{m}^{-}}{\partial {w}_{ji}}-{\tau }_{{{{\rm{m}}}}}^{-1}{w}_{mn(k)}\frac{{{{\rm{d}}}}{t}_{k}^{{{{\rm{event}}}}}}{{{{\rm{d}}}}{w}_{ji}}
$$

(32)

$$
=\frac{\partial {V}_{m}^{-}}{\partial {w}_{ji}}+{\left.\left[\frac{1}{{\tau }_{{{{\rm{m}}}}}{\dot{V}}_{n(k)}^{-}}{w}_{mn(k)}\frac{\partial {V}_{n(k)}^{-}}{\partial {w}_{ji}}\right]\right\vert }_{{t}_{k}^{{{{\rm{spike}}}}}+{d}_{mn(k)}}
$$

(33)

We now can insert the expressions ([21](https://www.nature.com/articles/s41467-025-65394-8#Equ21)), ([25](https://www.nature.com/articles/s41467-025-65394-8#Equ25)), ([24](https://www.nature.com/articles/s41467-025-65394-8#Equ24)) and ([33](https://www.nature.com/articles/s41467-025-65394-8#Equ33)) into ([18](https://www.nature.com/articles/s41467-025-65394-8#Equ18)) and reorder terms according to which spike the jumps originate from, we get

$$
\begin{aligned}
\frac{{{{\rm{d}}}}{{{\mathscr{L}}}}}{{{{\rm{d}}}}{w}_{ji}} =	{\sum}_{{t}_{k}^{{{{\rm{spike}}}}}\in {{{\mathscr{S}}}}}\left[\frac{\partial {V}_{n(k)}^{-}}{\partial {w}_{ji}}\left[{\tau }_{{{{\rm{m}}}}}\left({\lambda }_{V,n(k)}^{-}-\frac{{\dot{V}}_{n(k)}^{+}}{{\dot{V}}_{n(k)}^{-}}{\lambda }_{V,n(k)}^{+}\right)+\frac{1}{{\dot{V}}_{n(k)}^{-}}\left(-\frac{\partial {l}_{p}}{\partial {t}_{k}^{{{{\rm{spike}}}}}}+{l}_{V}^{+}-{l}_{V}^{-}\right)\right]\right.\\ 	 {\left.\left.+{\tau }_{{{{\rm{s}}}}}({\lambda }_{I,n(k)}^{-}-{\lambda }_{I,n(k)}^{+})\frac{\partial {I}_{n(k)}^{-}}{\partial {w}_{ji}}\right]\right\vert }_{{t}_{k}^{{{{\rm{spike}}}}}}\\ 	+{\sum}_{m}\left[{\tau }_{{{{\rm{m}}}}}({\lambda }_{V,m}^{-}-{\lambda }_{V,m}^{+})\frac{\partial {V}_{m}^{-}}{\partial {w}_{ji}}+{\tau }_{{{{\rm{s}}}}}({\lambda }_{I,m}^{-}-{\lambda }_{I,m}^{+})\frac{\partial {I}_{m}^{-}}{\partial {w}_{ji}}\right]{| }_{{t}_{k}^{{{{\rm{spike}}}}}+{d}_{mn(k)}}\\ 	+{\left.\left[\frac{\partial {V}_{n(k)}^{-}}{\partial {w}_{ji}}\frac{1}{{\dot{V}}_{n(k)}^{-}}\right]\right\vert }_{{t}_{k}^{{{{\rm{spike}}}}}}{\left.\left[{w}_{mn(k)}({\lambda }_{I,m}^{+}-{\lambda }_{V,m}^{+})\right]\right\vert }_{{t}_{k}^{{{{\rm{spike}}}}}+{d}_{mn(k)}}-{\left.\left[{\tau }_{{{{\rm{s}}}}}{\delta }_{in(k)}{\delta }_{jm}{\lambda }_{I,m}^{+}\right]\right\vert }_{{t}_{k}^{{{{\rm{spike}}}}}+{d}_{mn(k)}}.
\end{aligned}
$$

(34)

Interestingly, after this detailed work, we find that the update of *λ* <sub><i>V</i></sub> of the spiking neuron is the same as without delays, apart from taking the receiving neurons’ corresponding *λ* <sub><i>V</i></sub> and *λ* <sub><i>I</i></sub> at the delayed time.

$$
\begin{aligned}
{\lambda }_{V,n(k)}^{-} =	{\left.\left[\frac{{\dot{V}}_{n(k)}^{+}}{{\dot{V}}_{n(k)}^{-}}{\lambda }_{V,n(k)}^{+}+\frac{1}{{\tau }_{{{{\rm{m}}}}}{\dot{V}}_{n(k)}^{-}}\left(\frac{\partial {l}_{p}}{\partial {t}_{k}^{{{{\rm{spike}}}}}}+{l}_{V}^{-}-{l}_{V}^{+}\right)\right]\right\vert }_{{t}_{k}^{{{{\rm{spike}}}}}}\\ 	+{\left.\left[\frac{1}{{\tau }_{{{{\rm{m}}}}}{\dot{V}}_{n(k)}^{-}}\right]\right\vert }_{{t}_{k}^{{{{\rm{spike}}}}}}{\sum}_{m}{w}_{mn(k)}{\left.\left[({\lambda }_{V,m}^{+}-{\lambda }_{I,m}^{+})\right]\right\vert }_{{t}_{k}^{{{{\rm{spike}}}}}+{d}_{mn(k)}}
\end{aligned}
$$

(35)

$$
{\lambda }_{V,m}^{-}={\lambda }_{V,m}^{+},\,{{\mbox{if}}}\,\,m\ne n(k)
$$

(36)

$$
{{{{\boldsymbol{\lambda }}}}}_{I}^{-}={{{{\boldsymbol{\lambda }}}}}_{I}^{+}.
$$

(37)

The gradient is then given by

$$
\frac{{{{\rm{d}}}}{{{\mathscr{L}}}}}{{{{\rm{d}}}}{w}_{ji}}=-{\tau }_{{{{\rm{s}}}}}{\sum}_{{t}_{k}^{{{{\rm{spike}}}}}\in {{{\mathscr{S}}}}}{\delta }_{in(k)}{\lambda }_{I,j}{| }_{{t}_{k}^{{{{\rm{spike}}}}}+{d}_{jn(k)}}=-{\tau }_{{{{\rm{s}}}}}{\sum}_{\left\{{t}_{k}^{{{{\rm{spike}}}}}\,| n(k)=i\right\}}{\lambda }_{I,j}{| }_{{t}_{k}^{{{{\rm{spike}}}}}+{d}_{ji}}.
$$

(38)

#### Learning delays

In the following, we will derive the gradients for delays *d* <sub><i>j</i> <i>i</i></sub> similarly to our weight gradient derivations. We start again with the standard approach for the adjoint method,

$$
\frac{{{{\rm{d}}}}{{{\mathscr{L}}}}}{{{{\rm{d}}}}{d}_{ji}}=\frac{{{{\rm{d}}}}}{{{{\rm{d}}}}{d}_{ji}}\left[{l}_{p}({{{\mathscr{S}}}})+{\sum}_{{t}_{k}^{{{{\rm{event}}}}}\in {{{\mathscr{E}}}}}\int_{{t}_{k}^{{{{\rm{event}}}}}}^{{t}_{k+1}^{{{{\rm{event}}}}}}\left[{l}_{V}({{{\bf{V}}}},t)+{{{{\boldsymbol{\lambda }}}}}_{V}\cdot {{{{\bf{f}}}}}_{V}+{{{{\boldsymbol{\lambda }}}}}_{I}\cdot {{{{\bf{f}}}}}_{I}\right]{{{\rm{d}}}}t\right]
$$

(39)

$$
\frac{\partial {{{{\bf{f}}}}}_{V}}{\partial {d}_{ji}}={\tau }_{{{{\rm{m}}}}}\frac{{{{\rm{d}}}}}{{{{\rm{d}}}}t}\frac{\partial {{{\bf{V}}}}}{\partial {d}_{ji}}+\frac{\partial {{{\bf{V}}}}}{\partial {d}_{ji}}-\frac{\partial {{{\bf{I}}}}}{\partial {d}_{ji}}
$$

(40)

$$
\frac{\partial {{{{\bf{f}}}}}_{I}}{\partial {d}_{ji}}={\tau }_{{{{\rm{s}}}}}\frac{{{{\rm{d}}}}}{{{{\rm{d}}}}t}\frac{\partial {{{\bf{I}}}}}{\partial {d}_{ji}}+\frac{\partial {{{\bf{I}}}}}{\partial {d}_{ji}}.
$$

(41)

Therefore,

$$
\begin{aligned}
\frac{{{{\rm{d}}}}{{{\mathscr{L}}}}}{{{{\rm{d}}}}{d}_{ji}}=	 {\sum}_{{t}_{k}^{{{{\rm{spike}}}}}\in {{{\mathscr{S}}}}}\frac{\partial {l}_{p}}{\partial {t}_{k}^{{{{\rm{spike}}}}}}\frac{{{{\rm{d}}}}{t}_{k}^{{{{\rm{spike}}}}}}{{{{\rm{d}}}}{d}_{ji}}\\ 	+{\sum}_{{t}_{k}^{{{{\rm{event}}}}}\in {{{\mathscr{E}}}}}\int_{{t}_{k}^{{{{\rm{event}}}}}}^{{t}_{k+1}^{{{{\rm{event}}}}}}\left[\frac{\partial {l}_{V}}{\partial {{{\bf{V}}}}}\cdot \frac{\partial {{{\bf{V}}}}}{\partial {d}_{ji}}+{{{{\boldsymbol{\lambda }}}}}_{V}\cdot \left({\tau }_{{{{\rm{m}}}}}\frac{{{{\rm{d}}}}}{{{{\rm{d}}}}t}\frac{\partial {{{\bf{V}}}}}{\partial {d}_{ji}}+\frac{\partial {{{\bf{V}}}}}{\partial {d}_{ji}}-\frac{\partial {{{\bf{I}}}}}{\partial {d}_{ji}}\right)\right.\\ 	\left.+{{{{\boldsymbol{\lambda }}}}}_{I}\cdot \left({\tau }_{{{{\rm{s}}}}}\frac{{{{\rm{d}}}}}{{{{\rm{d}}}}t}\frac{\partial {{{\bf{I}}}}}{\partial {d}_{ji}}+\frac{\partial {{{\bf{I}}}}}{\partial {d}_{ji}}\right)\right]{{{\rm{d}}}}t\\ 	+{l}_{V,k+1}^{-}\frac{{{{\rm{d}}}}{t}_{k+1}^{{{{\rm{event}}}}}}{{{{\rm{d}}}}{d}_{ji}}-{l}_{V,k}^{+}\frac{{{{\rm{d}}}}{t}_{k}^{{{{\rm{event}}}}}}{{{{\rm{d}}}}{d}_{ji}}.
\end{aligned}
$$

(42)

Then, using partial integration,

$$
\int_{{t}_{k}^{{{{\rm{event}}}}}}^{{t}_{k+1}^{{{{\rm{event}}}}}}{{{{\boldsymbol{\lambda }}}}}_{V}\cdot \frac{{{{\rm{d}}}}}{{{{\rm{d}}}}t}\frac{\partial {{{\bf{V}}}}}{\partial {d}_{ji}}{{{\rm{d}}}}t=-\int_{{t}_{k}^{{{{\rm{event}}}}}}^{{t}_{k+1}^{{{{\rm{event}}}}}}{\dot{{{{\boldsymbol{\lambda }}}}}}_{{{{\bf{V}}}}}\cdot \frac{\partial {{{\bf{V}}}}}{\partial {d}_{ji}}{{{\rm{d}}}}t+{\left[{{{{\boldsymbol{\lambda }}}}}_{V}\cdot \frac{\partial {{{\bf{V}}}}}{\partial {d}_{ji}}\right]}_{{t}_{k}^{{{{\rm{event}}}}}}^{{t}_{k+1}^{{{{\rm{event}}}}}}
$$

(43)

$$
\int_{{t}_{k}^{{{{\rm{event}}}}}}^{{t}_{k+1}^{{{{\rm{event}}}}}}{{{{\boldsymbol{\lambda }}}}}_{I}\cdot \frac{{{{\rm{d}}}}}{{{{\rm{d}}}}t}\frac{\partial {{{\bf{I}}}}}{\partial {d}_{ji}}{{{\rm{d}}}}t=-\int_{{t}_{k}^{{{{\rm{event}}}}}}^{{t}_{k+1}^{{{{\rm{event}}}}}}{\dot{{{{\boldsymbol{\lambda }}}}}}_{I}\cdot \frac{\partial {{{\bf{I}}}}}{\partial {d}_{ji}}{{{\rm{d}}}}t+{\left[{{{{\boldsymbol{\lambda }}}}}_{I}\cdot \frac{\partial {{{\bf{I}}}}}{\partial {d}_{ji}}\right]}_{{t}_{k}^{{{{\rm{event}}}}}}^{{t}_{k+1}^{{{{\rm{event}}}}}}
$$

(44)

and hence,

$$
\begin{aligned}
\frac{{{{\rm{d}}}}{{{\mathscr{L}}}}}{{{{\rm{d}}}}{d}_{ji}}=	{\sum}_{{t}_{k}^{{{{\rm{spike}}}}}\in S}\frac{\partial {l}_{p}}{\partial {t}_{k}^{{{{\rm{spike}}}}}}\frac{{{{\rm{d}}}}{t}_{k}^{{{{\rm{spike}}}}}}{{{{\rm{d}}}}{d}_{ji}}\\ 	{\sum}_{{t}_{k}^{{{{\rm{event}}}}}\in {{{\mathscr{E}}}}}\left[\int_{{t}_{k}^{{{{\rm{event}}}}}}^{{t}_{k+1}^{{{{\rm{event}}}}}}\left(\frac{\partial {l}_{V}}{\partial {{{\bf{V}}}}}-{\tau }_{{{{\rm{m}}}}}{\dot{{{{\boldsymbol{\lambda }}}}}}_{V}+{{{{\boldsymbol{\lambda }}}}}_{V}\right)\cdot \frac{\partial {{{\bf{V}}}}}{\partial {d}_{ji}}+(-{\tau }_{{{{\rm{s}}}}}{\dot{{{{\boldsymbol{\lambda }}}}}}_{I}+{{{{\boldsymbol{\lambda }}}}}_{I}-{{{{\boldsymbol{\lambda }}}}}_{V})\cdot \frac{\partial {{{\bf{I}}}}}{\partial {d}_{ji}}\right]{{{\rm{d}}}}t\\ 	+{\tau }_{{{{\rm{m}}}}}{\left[{{{{\boldsymbol{\lambda }}}}}_{V}\cdot \frac{\partial {{{\bf{V}}}}}{\partial {d}_{ji}}\right]}_{{t}_{k}^{{{{\rm{event}}}}}}^{{t}_{k+1}^{{{{\rm{event}}}}}}+{\tau }_{{{{\rm{s}}}}}{\left[{{{{\boldsymbol{\lambda }}}}}_{I}\cdot \frac{\partial {{{\bf{I}}}}}{\partial {d}_{ji}}\right]}_{{t}_{k}^{{{{\rm{event}}}}}}^{{t}_{k+1}^{{{{\rm{event}}}}}}+{l}_{V,k+1}^{-}\frac{{{{\rm{d}}}}{t}_{k+1}^{{{{\rm{event}}}}}}{{{{\rm{d}}}}{d}_{ji}}-{l}_{V,k}^{+}\frac{{{{\rm{d}}}}{t}_{k}^{{{{\rm{event}}}}}}{{{{\rm{d}}}}{d}_{ji}}.
\end{aligned}
$$

(45)

If we now define the adjoint dynamics as usual, the terms in the integral disappear, and we are left with

$$
\begin{aligned}
\frac{{{{\rm{d}}}}{{{\mathscr{L}}}}}{{{{\rm{d}}}}{d}_{ji}}=	 {\sum}_{{t}_{k}^{{{{\rm{spike}}}}}\in {{{\mathscr{S}}}}}\frac{\partial {l}_{p}}{\partial {t}_{k}^{{{{\rm{spike}}}}}}\frac{{{{\rm{d}}}}{t}_{k}^{{{{\rm{spike}}}}}}{{{{\rm{d}}}}{d}_{ji}}\\ 	+{\sum}_{{t}_{k}^{{{{\rm{event}}}}}\in {{{\mathscr{E}}}}}{l}_{V,k}^{-}\frac{{{{\rm{d}}}}{t}_{k}^{{{{\rm{event}}}}}}{{{{\rm{d}}}}{d}_{ji}}-{l}_{V,k}^{+}\frac{{{{\rm{d}}}}{t}_{k}^{{{{\rm{event}}}}}}{{{{\rm{d}}}}{d}_{ji}} \\ 	+{\left.\left[{\tau }_{{{{\rm{m}}}}}\left({{{{\boldsymbol{\lambda }}}}}_{V}^{-}\cdot \frac{\partial {{{{\bf{V}}}}}^{-}}{\partial {d}_{ji}}-{{{{\boldsymbol{\lambda }}}}}_{V}^{+}\cdot \frac{\partial {{{{\bf{V}}}}}^{+}}{\partial {d}_{ji}}\right)+{\tau }_{{{{\rm{s}}}}}\left({{{{\boldsymbol{\lambda }}}}}_{I}^{-}\cdot \frac{\partial {{{{\bf{I}}}}}^{-}}{\partial {d}_{ji}}-{{{{\boldsymbol{\lambda }}}}}_{I}^{+}\cdot \frac{\partial {{{{\bf{I}}}}}^{+}}{\partial {d}_{ji}}\right)\right]\right\vert }_{{t}_{k}^{{{{\rm{event}}}}}}.
\end{aligned}
$$

(46)

Let’s now again first consider the spike emission times ${t}_{k}^{{{{\rm{spike}}}}}$ and the spiking neuron *n* (*k*). Before the jump:

$$
\frac{\partial {V}_{n(k)}^{-}}{\partial {d}_{ji}}+{\dot{V}}_{n(k)}^{-}\frac{{{{\rm{d}}}}{t}_{k}^{{{{\rm{spike}}}}}}{{{{\rm{d}}}}{d}_{ji}}=0
$$

(47)

$$
\Rightarrow \quad \frac{{{{\rm{d}}}}{t}_{k}^{{{{\rm{spike}}}}}}{{{{\rm{d}}}}{d}_{ji}}=-\frac{1}{{\dot{V}}_{n(k)}^{-}}\frac{\partial {V}_{n(k)}^{-}}{\partial {d}_{ji}},
$$

(48)

and after the jump:

$$
\frac{\partial {V}_{n(k)}^{+}}{\partial {d}_{ji}}+{\dot{V}}_{n(k)}^{+}\frac{{{{\rm{d}}}}{t}_{k}^{{{{\rm{spike}}}}}}{{{{\rm{d}}}}{d}_{ji}}=0
$$

(49)

$$
\Rightarrow \quad \frac{\partial {V}_{n(k)}^{+}}{\partial {d}_{ji}}=\frac{{\dot{V}}_{n(k)}^{+}}{{\dot{V}}_{n(k)}^{-}}\frac{\partial {V}_{n(k)}^{-}}{\partial {d}_{ji}}.
$$

(50)

There is no jump in *I* <sub><i>n</i> (<i>k</i>)</sub> or its time derivative at ${t}_{k}^{{{{\rm{spike}}}}}$ which analogous to above implies

$$
\frac{\partial {I}_{n(k)}^{+}}{\partial {d}_{ji}}=\frac{\partial {I}_{n(k)}^{-}}{\partial {d}_{ji}}.
$$

(51)

Turning to spike arrival times ${t}_{k}^{{{{\rm{event}}}}}\in {{{\mathscr{E}}}}\backslash {{{\mathscr{S}}}}$, when the spike at ${t}_{k}^{{{{\rm{spike}}}}}$ arrives at the post-synaptic neurons *m*, we get

$$
{I}_{m}^{+}={I}_{m}^{-}+{w}_{mn(k)},
$$

(52)

and hence,

$$
\frac{\partial {I}_{m}^{+}}{\partial {d}_{ji}}+{\dot{I}}_{m}^{+}\frac{{{{\rm{d}}}}{t}_{k}^{{{{\rm{event}}}}}}{{{{\rm{d}}}}{d}_{ji}}=\frac{\partial {I}_{m}^{-}}{\partial {d}_{ji}}+{\dot{I}}_{m}^{-}\frac{{{{\rm{d}}}}{t}_{k}^{{{{\rm{event}}}}}}{{{{\rm{d}}}}{d}_{ji}}.
$$

(53)

Using the dynamics of **I**, ([52](https://www.nature.com/articles/s41467-025-65394-8#Equ52)) implies

$$
{\tau }_{{{{\rm{s}}}}}{\dot{I}}_{m}^{+}={\tau }_{{{{\rm{s}}}}}{\dot{I}}_{m}^{-}-{w}_{mn(k)},
$$

(54)

and hence

$$
\frac{\partial {I}_{m}^{+}}{\partial {d}_{ji}}=\frac{\partial {I}_{m}^{-}}{\partial {d}_{ji}}+{\tau }_{{{{\rm{s}}}}}^{-1}{w}_{mn(k)}\frac{{{{\rm{d}}}}{t}_{k}^{{{{\rm{event}}}}}}{{{{\rm{d}}}}{d}_{ji}}
$$

(55)

$$
=\frac{\partial {I}_{m}^{-}}{\partial {d}_{ji}}-\frac{1}{{\tau }_{{{{\rm{s}}}}}{\dot{V}}_{n(k)}^{-}}{w}_{mn(k)}\frac{\partial {V}_{n(k)}^{-}}{\partial {d}_{ji}}+{\delta }_{in(k)}{\delta }_{jm}\frac{{w}_{mn(k)}}{{\tau }_{{{{\rm{s}}}}}},
$$

(56)

where the term involving the spiking neuron *n* (*k*) stems from the derivative of the spike time ${t}_{k}^{{{{\rm{event}}}}}$ with respect to *d* <sub><i>j</i> <i>i</i></sub> using ([48](https://www.nature.com/articles/s41467-025-65394-8#Equ48)) and the last term from the derivative of the delay by itself (since $\frac{\partial {t}_{k}^{{{{\rm{event}}}}}}{\partial {d}_{ji}}=\frac{\partial ({t}_{k}^{{{{\rm{spike}}}}}+{d}_{ji})}{\partial {d}_{ji}}=\frac{\partial {t}_{k}^{{{{\rm{spike}}}}}}{\partial {d}_{ji}}+1$). Note that this is where the derivations begin to differ from when we were taking the derivative with respect to *w* <sub><i>j</i> <i>i</i></sub>. For the voltages,

$$
\frac{\partial {V}_{m}^{+}}{\partial {d}_{ji}}+{\dot{V}}_{m}^{+}\frac{{{{\rm{d}}}}{t}_{k}^{{{{\rm{event}}}}}}{{{{\rm{d}}}}{d}_{ji}}=\frac{\partial {V}_{m}^{-}}{\partial {d}_{ji}}+{\dot{V}}_{m}^{-}\frac{{{{\rm{d}}}}{t}_{k}^{{{{\rm{event}}}}}}{{{{\rm{d}}}}{d}_{ji}},
$$

(57)

and using the dynamics of **V** and ([52](https://www.nature.com/articles/s41467-025-65394-8#Equ52)),

$$
{\tau }_{{{{\rm{m}}}}}{\dot{V}}_{m}^{+}={\tau }_{{{{\rm{m}}}}}{\dot{V}}_{m}^{-}+{w}_{mn(k)},
$$

(58)

which put together gives

$$
\frac{\partial {V}_{m}^{+}}{\partial {d}_{ji}}=\frac{\partial {V}_{m}^{-}}{\partial {d}_{ji}}-{\tau }_{{{{\rm{m}}}}}^{-1}{w}_{mn}\frac{{{{\rm{d}}}}{t}_{k}^{{{{\rm{event}}}}}}{{{{\rm{d}}}}{d}_{ji}}
$$

(59)

$$
=\frac{\partial {V}_{m}^{-}}{\partial {d}_{ji}}+\frac{1}{{\tau }_{{{{\rm{m}}}}}{\dot{V}}_{n(k)}^{-}}{w}_{mn(k)}\frac{\partial {V}_{n(k)}^{-}}{\partial {d}_{ji}}-{\delta }_{in(k)}{\delta }_{jm}\frac{{w}_{mn(k)}}{{\tau }_{{{{\rm{m}}}}}},
$$

(60)

where the last term again arises from the derivative of the delay *d* <sub><i>m</i> <i>n</i> (<i>k</i>)</sub> in ${t}_{k}^{{{{\rm{event}}}}}$ with respect to *d* <sub><i>j</i> <i>i</i></sub>. Taking everything together, we get

$$
\frac{d{{{\mathscr{L}}}}}{d{d}_{ji}}={\sum}_{{t}_{k}^{{{{\rm{spike}}}}}\in {{{\mathscr{S}}}}}\left[\frac{\partial {V}_{n(k)}^{-}}{\partial {d}_{ji}}\left[{\tau }_{{{{\rm{m}}}}}\left({\lambda }_{V,n(k)}^{-}-\frac{{\dot{V}}_{n(k)}^{+}}{{\dot{V}}_{n(k)}^{-}}{\lambda }_{V,n(k)}^{+}\right)+\frac{1}{{\dot{V}}_{n(k)}^{-}}\left(-\frac{\partial {l}_{p}}{\partial {t}_{k}^{{{{\rm{spike}}}}}}+{l}_{V}^{+}-{l}_{V}^{-}\right)\right]\right.
$$

(61)

$$
{\left.\left.+{\tau }_{{{{\rm{s}}}}}({\lambda }_{I,n(k)}^{-}-{\lambda }_{I,n(k)}^{+})\frac{\partial {I}_{n}^{-}}{\partial {d}_{ji}}\right]\right\vert }_{{t}_{k}^{{{{\rm{spike}}}}}}
$$

(62)

$$
+{\sum}_{m}{\left.\left[{\tau }_{{{{\rm{m}}}}}({\lambda }_{V,m}^{-}-{\lambda }_{V,m}^{+})\frac{\partial {V}_{m}^{-}}{\partial {d}_{ji}}+{\tau }_{{{{\rm{s}}}}}({\lambda }_{I,m}^{-}-{\lambda }_{I,m}^{+})\frac{\partial {I}_{m}^{-}}{\partial {d}_{ji}}\right]\right\vert }_{{t}_{k}^{{{{\rm{spike}}}}}+{d}_{mn(k)}}
$$

(63)

$$
+{\left.\left[\frac{\partial {V}_{n}^{-}}{\partial {d}_{ji}}\frac{1}{{\dot{V}}_{n(k)}^{-}}\right]\right\vert }_{{t}_{k}^{{{{\rm{spike}}}}}}{\left.\left[{w}_{mn(k)}({\lambda }_{I,m}^{+}-{\lambda }_{V,m}^{+})\right]\right\vert }_{{t}_{k}^{{{{\rm{spike}}}}}+{d}_{mn(k)}}
$$

(64)

$$
-{\left.\left[{w}_{mn(k)}{\delta }_{in(k)}{\delta }_{jm}({\lambda }_{I,m}^{+}-{\lambda }_{V,m}^{+})\right]\right\vert }_{{t}_{k}^{{{{\rm{spike}}}}}+{d}_{mn(k)}}.
$$

(65)

So, using the usual trick

$$
\frac{{\dot{V}}_{n(k)}^{+}}{{\dot{V}}_{n(k)}^{-}}=\frac{\vartheta }{{\tau }_{{{{\rm{m}}}}}{\dot{V}}_{n(k)}^{-}}+1,
$$

(66)

we again arrive at the same jump conditions as usual,

$$
\begin{array}{rcl}{\lambda }_{V,n(k)}^{-}&=&{\left.\left[{\lambda }_{V,n(k)}^{+}+\frac{1}{{\tau }_{{{{\rm{m}}}}}{\dot{V}}_{n(k)}^{-}}\left[\vartheta \cdot {\lambda }_{V,n(k)}^{+}+\frac{\partial {l}_{p}}{\partial {t}_{k}^{{{{\rm{spike}}}}}}+{l}_{V}^{-}-{l}_{V}^{+}\right]\right]\right\vert }_{{t}_{k}^{{{{\rm{spike}}}}}}\\ &&+{\left.\left[\frac{1}{{\tau }_{{{{\rm{m}}}}}{\dot{V}}_{n(k)}^{-}}\right]\right\vert }_{{t}_{k}^{{{{\rm{spike}}}}}}{\sum}_{m}{w}_{mn(k)}{\left.\left[{\lambda }_{V,m}^{+}-{\lambda }_{I,m}^{+}\right]\right\vert }_{{t}_{k}^{{{{\rm{spike}}}}}+{d}_{mn(k)}}\end{array}
$$

(67)

$$
{\lambda }_{V,m}^{-}={\lambda }_{V,m}^{+},\,{{\mbox{if}}}\,\,m\ne n(k)
$$

(68)

$$
{{{{\boldsymbol{\lambda }}}}}_{I}^{-}={{{{\boldsymbol{\lambda }}}}}_{I}^{+},
$$

(69)

but the gradient updates take the form

$$
\begin{aligned}
\frac{{{{\rm{d}}}}{{{\mathscr{L}}}}}{{{{\rm{d}}}}{d}_{ji}}=-{\sum}_{{t}_{k}^{{{{\rm{spike}}}}}\in {{{\mathscr{S}}}}}{w}_{ji}{\delta }_{in(k)}{\left.({\lambda }_{I,j}-{\lambda }_{V,j})\right\vert }_{{t}_{k}^{{{{\rm{spike}}}}}+{d}_{jn(k)}} \\=-{w}_{ji}{\sum}_{\left\{{t}_{k}^{{{{\rm{spike}}}}}\,| n(k)=i\right\}}{\left.({\lambda }_{I,j}-{\lambda }_{V,j})\right\vert }_{{t}_{k}^{{{{\rm{spike}}}}}+{d}_{ji}}.
\end{aligned}
$$

(70)

#### Time-invariant mean squared error loss

Following Göltz et al.[^39], we use the time-invariant mean squared error loss of output spike times for the Yin-Yang benchmark

$$
{{{{\mathscr{L}}}}}_{\Delta {{{\rm{MSE}}}}}=\frac{1}{2}{\sum}_{i\ne c}{\left({t}_{i}-{t}_{c}-{\Delta }_{t}\right)}^{2},
$$

(71)

where *c* is the true class of the current input and *t* <sub><i>i</i></sub>, *t* <sub><i>c</i></sub> denote the first spike time in the respective output neurons. In the EventProp formalism, this is a spike-time dependent loss *l* <sub><i>p</i></sub> and, therefore, drives jumps in ***λ*** <sub><i>V</i>,<i>i</i></sub> in output neuron *i* at spike times ${t}_{k}^{{{{\rm{spike}}}}}$ in the backward pass (see Table [1](https://www.nature.com/articles/s41467-025-65394-8#Tab1)) by

$$
\frac{\partial {l}_{p}}{\partial {t}_{k}^{{{{\rm{spike}}}}}}=\left\{\begin{array}{ll}({t}_{i}-{t}_{c}-{\Delta }_{t})&{{{\rm{if}}}}\,n(k)=i,{t}_{k}^{{{{\rm{spike}}}}}={t}_{i},i\ne c\\ {\sum}_{i\ne c}-({t}_{i}-{t}_{c}-{\Delta }_{t})&{{{\rm{if}}}}\,n(k)=c,{t}_{k}^{{{{\rm{spike}}}}}={t}_{c}\\ 0&\,{\mbox{otherwise}}\,\end{array}\right.
$$

(72)

### Implementation

We implemented all of our work in the mlGeNN framework [^40] [^41] to exploit the the efficiency of event-based learning. In all of our experiments, we used the parameters from previous EventProp work [^21], apart from spike regularisation strengths, number of hidden layers and recurrent connections. We did not implement heterogeneous and trainable time constants, so that the independent effect of delays would be more clear. For our experiments on the SHD and SSC datasets, we adopted the data augmentation approaches described by Nowotny, Turner, and Knight [^21], which were designed to improve generalization. Specifically, we implemented the following augmentations:

- Input Shifting: We randomly shifted all inputs by a value within the range of (−40, 40).
- Input Blending: We blended two inputs from the same class by aligning their centres of mass and randomly selecting spikes from each input with a probability of 0.5.

For SSC we only used the shift augmentation. For the Yin-Yang dataset we decreased the learning rate on both weights and delays at the end of each epoch. On SHD and SSC, we implemented an “ease-in” scheduler on the weight learning rate, starting from 0.001 times the learning rate, increasing it at the end of each batch, until it reached the final value. For our chosen hyperparameters, see Tables [2](https://www.nature.com/articles/s41467-025-65394-8#Tab2) – [5](https://www.nature.com/articles/s41467-025-65394-8#Tab5). GeNN already provided an efficient implementation of spike transmission with per-synapse delays [^43] – allowing the EventProp forward pass to be implemented efficiently. However, the ***λ*** <sub><i>V</i></sub> transitions in the backward pass require access to postsynaptic ***λ*** values with a per-synapse delay ($\left[{\lambda }_{V,m}^{+}-{\lambda }_{I,m}^{+}\right]{| }_{{t}_{k}^{{{{\rm{spike}}}}}+{d}_{mn(k)}}$ from Equation: ([35](https://www.nature.com/articles/s41467-025-65394-8#Equ35))). This required a small extension to GeNN’s existing system for providing delayed access to postsynaptic variables from a synapse model [^42] in order to enable it to use the per-synapse delays used for spike transmission in the forward pass.

**Table 2 Yin-Yang parameters**

**Table 3 SHD parameters**

**Table 4 SSC parameters**

**Table 5 Braille reading parameters**

## Data availability

The data underlying our results are available at [https://doi.org/10.25377/sussex.29414015](https://doi.org/10.25377/sussex.29414015).

## Code availability

All experiments were carried out using the GeNN 5.1.0 [^71] an mlGeNN 2.3.0 [^72]. The latest versions of both libraries are also available at [https://github.com/genn-team/](https://github.com/genn-team/). The code to train and evaluate the models described in this work are available at [https://doi.org/10.5281/zenodo.17236061](https://doi.org/10.5281/zenodo.17236061).
