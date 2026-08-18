---
title: "Closed-form continuous-time neural networks - Nature Machine Intelligence"
source: "https://www.nature.com/articles/s42256-022-00556-7"
author:
  - "[[Ramin Hasani]]"
  - "[[Mathias Lechner]]"
  - "[[Alexander Amini]]"
  - "[[Lucas Liebenwein]]"
  - "[[Aaron Ray]]"
  - "[[Max Tschaikowski]]"
  - "[[Gerald Teschl]]"
  - "[[Daniela Rus]]"
published: 2022-11-15
created: 2026-06-22
description: "Continuous-time neural networks are a class of machine learning systems that can tackle representation learning on spatiotemporal decision-making tasks. These models are typically represented by continuous differential equations. However, their expressive power when they are deployed on computers is bottlenecked by numerical differential equation solvers. This limitation has notably slowed down the scaling and understanding of numerous natural physical phenomena such as the dynamics of nervous systems. Ideally, we would circumvent this bottleneck by solving the given dynamical system in closed form. This is known to be intractable in general. Here, we show that it is possible to closely approximate the interaction between neurons and synapses—the building blocks of natural and artificial neural networks—constructed by liquid time-constant networks efficiently in closed form. To this end, we compute a tightly bounded approximation of the solution of an integral appearing in liquid time-constant dynamics that has had no known closed-form solution so far. This closed-form solution impacts the design of continuous-time and continuous-depth neural models. For instance, since time appears explicitly in closed form, the formulation relaxes the need for complex numerical solvers. Consequently, we obtain models that are between one and five orders of magnitude faster in training and inference compared with differential equation-based counterparts. More importantly, in contrast to ordinary differential equation-based continuous networks, closed-form networks can scale remarkably well compared with other deep learning instances. Lastly, as these models are derived from liquid networks, they show good performance in time-series modelling compared with advanced recurrent neural network models. Physical dynamical processes can be modelled with differential equations that may be solved with numerical approaches, but this is computationally costly as the processes grow in complexity. In a new approach, dynamical processes are modelled with closed-form continuous-depth artificial neural networks. Improved efficiency in training and inference is demonstrated on various sequence modelling tasks including human action recognition and steering in autonomous driving."
tags:
  - "clippings"
---
## Abstract

Continuous-time neural networks are a class of machine learning systems that can tackle representation learning on spatiotemporal decision-making tasks. These models are typically represented by continuous differential equations. However, their expressive power when they are deployed on computers is bottlenecked by numerical differential equation solvers. This limitation has notably slowed down the scaling and understanding of numerous natural physical phenomena such as the dynamics of nervous systems. Ideally, we would circumvent this bottleneck by solving the given dynamical system in closed form. This is known to be intractable in general. Here, we show that it is possible to closely approximate the interaction between neurons and synapses—the building blocks of natural and artificial neural networks—constructed by liquid time-constant networks efficiently in closed form. To this end, we compute a tightly bounded approximation of the solution of an integral appearing in liquid time-constant dynamics that has had no known closed-form solution so far. This closed-form solution impacts the design of continuous-time and continuous-depth neural models. For instance, since time appears explicitly in closed form, the formulation relaxes the need for complex numerical solvers. Consequently, we obtain models that are between one and five orders of magnitude faster in training and inference compared with differential equation-based counterparts. More importantly, in contrast to ordinary differential equation-based continuous networks, closed-form networks can scale remarkably well compared with other deep learning instances. Lastly, as these models are derived from liquid networks, they show good performance in time-series modelling compared with advanced recurrent neural network models.

## Main

Continuous neural network architectures built by ordinary differential equations (ODEs) [^2] are expressive models useful in modelling data with complex dynamics. These models transform the depth dimension of static neural networks and the time dimension of recurrent neural networks (RNNs) into a continuous vector field, enabling parameter sharing, adaptive computations and function approximation for non-uniformly sampled data.

These continuous-depth (time) models have shown promise in density estimation applications [^3] [^4] [^5] [^6], as well as modelling sequential and irregularly sampled data [^1] [^7] [^8] [^9].

While ODE-based neural networks with careful memory and gradient propagation design [^9] perform competitively with advanced discretized recurrent models on relatively small benchmarks, their training and inference are slow owing to the use of advanced numerical differential equation (DE) solvers [^10]. This becomes even more troublesome as the complexity of the data, task and state space increases (that is, requiring more precision) [^11], for instance, in open-world problems such as medical data processing, self-driving cars, financial time-series and physics simulations.

The research community has developed solutions for resolving this computational overhead and for facilitating the training of neural ODEs, for instance by relaxing the stiffness of a flow by state augmentation techniques [^4] [^12], reformulating the forward pass as a root-finding problem [^13], using regularization schemes [^14] [^15] [^16] or improving the inference time of the network [^17].

Here, we derive a closed-form continuous-depth model that has the modelling capabilities of ODE-based models but does not require any solver to model data (Fig. [1](https://www.nature.com/articles/s42256-022-00556-7#Fig1)).

![Fig. 1: Neural and synapse dynamics.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs42256-022-00556-7/MediaObjects/42256_2022_556_Fig1_HTML.png?as=webp)

Fig. 1: Neural and synapse dynamics.

Intuitively, in this work, we replace the integration (that is, solution) of a nonlinear DE describing the interaction of a neuron with its input nonlinear synaptic connections, with their corresponding nonlinear operators. This could be achieved in principle using functional Taylor expansions (in the spirit of the Volterra series) [^18]. However, in the particular case of liquid time-constant (LTC) networks, we can leverage a closed-form expression for the system’s response to input. This allows one to evaluate the system’s response to exogenous input (*I*) and recurrent inputs from hidden states (*x*) as a function of time. One way of looking at this is to regard the closed-form solution as the application of a nonlinear forward operator to the inputs of each hidden state or neuron in the network, where the outputs of one neuron constitute the inputs for others. Effectively, this rests on approximating a conductance-based model with a neural mass model, of the kind used in the dynamic causal modelling of real neuronal networks [^19].

The proposed continuous neural networks yield considerably faster training and inference speeds while being as expressive as their ODE-based counterparts. We provide a derivation for the approximate closed-form solution to a class of continuous neural networks that explicitly models time. We demonstrate how this transformation can be formulated into a novel neural model and scaled to create flexible, performant and fast neural architectures on challenging sequential datasets.

### Deriving an approximate closed-form solution for neural interactions

Two neurons interact with each other through synapses as shown in Fig. [1](https://www.nature.com/articles/s42256-022-00556-7#Fig1). There are three principal mechanisms for information propagation in natural brains that are abstracted away in the current building blocks of deep learning systems: (1) neural dynamics are typically continuous processes described by DEs (see the dynamics of *x* (*t*) in Fig. [1](https://www.nature.com/articles/s42256-022-00556-7#Fig1)), (2) synaptic release is much more than scalar weights, involving a nonlinear transmission of neurotransmitters, the probability of activation of receptors and the concentration of available neurotransmitters, among other nonlinearities (see *S* (*t*) in Fig. [1](https://www.nature.com/articles/s42256-022-00556-7#Fig1)) and (3) the propagation of information between neurons is induced by feedback and memory apparatuses (see how *I* (*t*) stimulates *x* (*t*) through a nonlinear synapse *S* (*t*) which also has a multiplicative difference of potential to the postsynaptic neuron accounting for a negative feedback mechanism). One could read *I* (*t*) as a mixture of exogenous input to the (neural) network and presynaptic inputs from other neurons that result in a depolarization *x* (*t*). This depolarization is mediated by the current *S* (*t*) that depends upon depolarization and a reversal threshold *A*. LTC networks [^1], which are expressive continuous-depth models obtained by a bilinear approximation [^20] of a neural ODE formulation [^2], are designed on the basis of these mechanisms. Correspondingly, we take their ODE semantics and approximate a closed-form solution for the scalar case of a postsynaptic neuron receiving an input stimulus from a presynaptic source through a nonlinear synapse.

To this end, we apply the theory of linear ODEs [^21] to analytically solve the dynamics of an LTC DE as shown in Fig. [1](https://www.nature.com/articles/s42256-022-00556-7#Fig1). We then simplify the solution to the point where there is one integral left to solve. This integral compartment, $\int\nolimits_{0}^{t}f(I(s))\,{\mathrm{d}}s$ in which *f* is a positive, continuous, monotonically increasing and bounded nonlinearity, is challenging to solve in closed form since it has dependencies on an input signal *I* (*s*) that is arbitrarily defined (such as real-world sensory readouts). To approach this problem, we discretize *I* (*s*) into piecewise constant segments and obtain the discrete approximation of the integral in terms of the sum of piecewise constant compartments over intervals. This piecewise constant approximation inspired us to introduce an approximate closed-form solution for the integral $\int\nolimits_{0}^{t}f(I(s))\,{\mathrm{d}}s$ that is provably tight when the integral appears as the exponent of an exponential decay, which is the case for LTCs. We theoretically justify how this closed-form solution represents LTCs’ ODE semantics and is as expressive (Fig. [1](https://www.nature.com/articles/s42256-022-00556-7#Fig1)).

### Explicit time dependence

We then dissect the properties of the obtained closed-form solution and design a new class of neural network models we call closed-form continuous-depth networks (CfC). CfCs have an explicit time dependence in their formulation that does not require a numerical ODE solver to obtain their temporal rollouts. Thus, they maximize the trade-off between accuracy and efficiency of solvers. Formally, this property corresponds to obtaining lower time complexity for models without numerical instabilities and errors as illustrated in Table [1](https://www.nature.com/articles/s42256-022-00556-7#Tab1) (left). For example, Table [1](https://www.nature.com/articles/s42256-022-00556-7#Tab1) (left) shows that the complexity of a *p* th-order numerical ODE solver is ${{{\mathcal{O}}}}(Kp)$, where *K* is the number of ODE steps, while a CfC system (which has explicit time dependence) requires ${{{\mathcal{O}}}}(\tilde{K})$, where *K* is the exogenous input time steps, which are typically one to three orders of magnitude smaller than *K*. Moreover, the approximation error of a *p* th-order numerical ODE solver scales with ${{{\mathcal{O}}}}({\epsilon }^{p+1})$, whereas CfCs are closed-form continuous-time systems, thus the notion of approximation error becomes irrelevant to them.

**Table 1 Computational complexity of models**

This explicit time dependence allows CfCs to perform computations at least one order of magnitude faster in terms of training and inference time compared with their ODE-based counterparts, without loss of accuracy.

### Sequence and time-step prediction efficiency

In sequence modelling tasks, one can perform predictions based on an entire sequence of observations, or perform auto-regressive modelling where the model predicts the next time-step output given the current time-step input. Table [1](https://www.nature.com/articles/s42256-022-00556-7#Tab1) (right) depicts the time complexity of different neural network instances at inference, for a given sequence of length *n* and a neural network of *k* number of hidden units. We observe that the complexity of ODE-based networks and Transformer modules is at least an order of magnitude higher than that of discrete RNNs and CfCs in both sequence prediction and auto-regressive modelling (time-step prediction) frameworks.

This is desirable because not only do CfCs establish a continuous flow similar to ODE models [^1] to achieve better expressivity in representation learning but they do so with the efficiency of discrete RNN models.

### CfCs: flexible deep models for sequential tasks

Additionally, CfCs are equipped with novel time-dependent gating mechanisms that explicitly control their memory. CfCs are as expressive as their ODE-based peers and can be supplied with mixed memory architectures [^9] to avoid gradient issues in sequential data processing applications with long-range dependences. Beyond accuracy and performance metrics, our results indicate that, when considering accuracy per compute time, CfCs exhibit over 150 fold improvements over ODE-based compartments. We perform a diverse set of advanced time-series modelling experiments and present the performance and speed gain achievable by using CfCs in tasks with long-term dependences, irregular data and modelling physical dynamics, among others.

### Deriving a closed-form solution

In this section, we derive an approximate closed-form solution for LTC networks, an expressive subclass of time-continuous models. We discuss how the scalar closed-form expression derived from a small LTC system can inspire the design of CfC models. In this regard, we define the LTC semantics. We then state the main theorem that computes a closed-form approximation of a given LTC system for the scalar case. To prove the theorem, we first find the integral solution of the given LTC ODE system. We then compute a closed-form analytical solution for the integral solution for the case of piecewise constant inputs. Afterward, we generalize the closed-form solution of the piecewise constant inputs to the case of arbitrary inputs with our novel approximation and finally provide sharpness results (that is, measure the rate and accuracy of an approximation error) for the derived solution.

The hidden state of an LTC network is determined by the solution of the following initial value problem (IVP) [^1]:

 $\frac{d \mathbf{x}}{d t} = - \left[\right. w_{\tau} + f \left(\right. \mathbf{x} , \mathbf{I} , \theta \left.\right) \left]\right. \bigodot \mathbf{x} \left(\right. t \left.\right) + A \bigodot f \left(\right. \mathbf{x} , \mathbf{I} , \theta \left.\right) ,$ 
$$
\frac{{\mathrm{d}}{{{\bf{x}}}}}{{\mathrm{d}}t}=-\left[{w}_{\tau }+f({{{\bf{x}}}},{{{\bf{I}}}},\theta )\right]\odot {{{\bf{x}}}}(t)+A\odot f({{{\bf{x}}}},{{{\bf{I}}}},\theta ),
$$

(1)

where at a time step *t*, **x** <sup>(<i>D</i> ×1)</sup> (*t*) defines the hidden state of a LTC layer with *D* cells, and **I** <sup>(<i>m</i> ×1)</sup> (*t*) is an exogenous input to the system with *m* features. Here, ${w}_{\tau }^{(D\times 1)}$ is a time-constant parameter vector, *A* <sup>(<i>D</i> ×1)</sup> is a bias vector, *f* is a neural network parametrized by *θ* and ⊙ is the Hadamard product. The dependence of *f* (.) on **x** (*t*) denotes the posibility of having recurrent connections.

The full proof of theorem 1 is given in [Methods](https://www.nature.com/articles/s42256-022-00556-7#Sec28). The theorem formally demonstrates that the approximated closed-form solution for the given LTC system is given by equation ([2](https://www.nature.com/articles/s42256-022-00556-7#Equ2)) and that this approximation is tightly bounded with bounds given in the proof.

In the following, we show an illustrative example of this tightness result in practice. To do this, we first present an instantiation of LTC networks and their approximate closed-form expressions. Extended Data Fig. [1](https://www.nature.com/articles/s42256-022-00556-7#Fig3) shows a liquid network with two neurons and five synaptic connections. The network receives an input signal *I* (*t*). Extended Data Fig. [1](https://www.nature.com/articles/s42256-022-00556-7#Fig3) further derives the DE expression for the network along with its closed-form approximate solution. In general, it is possible to compile an LTC network into its closed-form expression as illustrated in Extended Data Fig. [1](https://www.nature.com/articles/s42256-022-00556-7#Fig3). This compilation can be performed using Algorithm 1 provided in [Methods](https://www.nature.com/articles/s42256-022-00556-7#Sec28).

### Theorem 1

*Given an LTC system determined by the IVP in equation (*[1](https://www.nature.com/articles/s42256-022-00556-7#Equ1)*), constructed by one cell, receiving a single-dimensional time-series exogenous input I(t) with no self-connections, the following expression is an approximation of its closed-form solution:*

 $x \left(\right. t \left.\right) \approx \left(\right. x_{0} - A \left.\right) e^{- \left[\right. w_{\tau} + f \left(\right. I \left(\right. t \left.\right) , \theta \left.\right) \left]\right. t} f \left(\right. - I \left(\right. t \left.\right) , \theta \left.\right) + A .$ 
$$
x(t)\approx ({x}_{0}-A){\mathrm{e}}^{-[{w}_{\tau }+f(I(t),\theta )]t}f(-I(t),\theta )+A.
$$

(2)

### Tightness of the closed-form solution in practice

Figure [2](https://www.nature.com/articles/s42256-022-00556-7#Fig2) shows an LTC-based network trained for autonomous driving [^22]. The figure further illustrates how close the proposed solution fits the actual dynamics exhibited from a single-neuron ODE given the same parametrization. The details of this experiment are given in [Methods](https://www.nature.com/articles/s42256-022-00556-7#Sec28).

![Fig. 2: Tightness of the closed-form solution in practice.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs42256-022-00556-7/MediaObjects/42256_2022_556_Fig2_HTML.png?as=webp)

Fig. 2: Tightness of the closed-form solution in practice.

We next show how to design a novel neural network instance inspired by this closed-form solution that has well-behaved gradient properties and approximation capabilities.

### Designing CfC models from the solution

Leveraging the scalar closed-form solution expressed by equation ([2](https://www.nature.com/articles/s42256-022-00556-7#Equ2)), we can now distil this model into a neural network model that can be trained at scale. The solution provides a grounded theoretical basis for solving scalar continuous-time dynamics, and it is important to translate this theory into a practical neural network model which can be integrated into larger representation learning systems equipped with gradient descent optimizers. Doing so requires careful attention to potential gradient and expressivity issues that can arise during optimization, which we will outline in this section.

Formally, the hidden states, **x** (*t*) <sup>(<i>D</i> ×1)</sup> with *D* hidden units at each time step *t*, can be obtained explicitly as

 $\mathbf{x} \left(\right. t \left.\right) = B \bigodot e^{- \left[\right. w_{\tau} + f \left(\right. \mathbf{x} , \mathbf{I} ; \theta \left.\right) \left]\right. t} \bigodot f \left(\right. - \mathbf{x} , - \mathbf{I} ; \theta \left.\right) + A ,$ 
$$
{{{\bf{x}}}}(t)=B\odot {\mathrm{e}}^{-[{w}_{\tau }+f({{{\bf{x}}}},{{{\bf{I}}}};\theta )]t}\odot f(-{{{\bf{x}}}},-{{{\bf{I}}}};\theta )+A,
$$

(3)

where *B* <sup>(<i>D</i>)</sup> collapses (*x* <sub>0</sub>  −  *A*) of equation ([2](https://www.nature.com/articles/s42256-022-00556-7#Equ2)) into a parameter vector. *A* <sup>(<i>D</i>)</sup> and ${w}_{\tau }^{(D)}$ are system’s parameter vectors, while **I** (*t*) <sup>(<i>m</i> ×1)</sup> is an *m* -dimensional input at each time step *t*, *f* is a neural network parametrized by $\theta =\{{W}_{Ix}^{(m\times D)},{W}_{xx}^{(D\times D)},{b}_{x}^{(D)}\}$ and ⊙ is the Hadamard (element-wise) product. While the neural network presented in equation ([3](https://www.nature.com/articles/s42256-022-00556-7#Equ3)) can be proven to be a universal approximator as it is an approximation of an ODE system [^1] [^2], in its current form, it has trainability issues which we point out and resolve shortly.

### Resolving the gradient issues

The exponential term in equation ([3](https://www.nature.com/articles/s42256-022-00556-7#Equ3)) drives the system’s first part (exponentially fast) to 0 and the entire hidden state to *A*. This issue becomes more apparent when there are recurrent connections and causes vanishing gradient factors when trained by gradient descent [^23]. To reduce this effect, we replace the exponential decay term with a reversed sigmoidal nonlinearity *σ* (.). This nonlinearity is approximately 1 at *t*  = 0 and approaches 0 in the limit *t*  →  *∞*. However, unlike exponential decay, its transition happens much more smoothly, yielding a better condition on the loss surface.

### Replacing biases by learnable instances

Next, we consider the bias parameter *B* to be part of the trainable parameters of the neural network *f* ( −  **x**, −  **I**; *θ*) and choose to use a new network instance instead of *f* (presented in the exponential decay factor). We also replace *A* with another neural network instance, *h* (. ) to enhance the flexibility of the model. To obtain a more general network architecture, we allow the nonlinearity *f* (− **x**, − **I**; *θ*) present in equation ([3](https://www.nature.com/articles/s42256-022-00556-7#Equ3)) to have both shared (backbone) and independent (*g* (. )) network compartments.

### Gating balance

The time-decaying sigmoidal term can play a gating role if we additionally multiply *h* (. ) with (1 −  *σ* (. )). This way, the time-decaying sigmoid function stands for a gating mechanism that interpolates between the two limits of *t*  → − *∞* and *t*  →  *∞* of the ODE trajectory.

### Backbone

Instead of learning all three neural network instances *f*, *g* and *h* separately, we have them share the first few layers in the form of a backbone that branches out into these three functions. As a result, the backbone allows our model to learn shared representations, thereby speeding up and stabilizing the learning process. More importantly, this architectural prior enables two simultaneous benefits: (1) Through the shared backbone, a coupling between the time constant of the system and its state nonlinearity is established that exploits causal representation learning evident in a liquid neural network [^1] [^24]. (2) through separate head network layers, the system has the ability to explore temporal and structural dependences independently of each other.

These modifications result in the CfC neural network model:

 $\textbf{x} \left(\right. t \left.\right) = \underset{t i m e - c o n t i n u o u s g a t i n g}{\underbrace{\sigma \left(\right. - f \left(\right. \textbf{x} , \textbf{I} ; \theta_{f} \left.\right) \textbf{t} \left.\right)}} \bigodot g \left(\right. \textbf{x} , \textbf{I} ; \theta_{g} \left.\right) + \underset{t i m e - c o n t i n u o u s g a t i n g}{\underbrace{\left[\right. 1 - \sigma \left(\right. - \left[\right. f \left(\right. \textbf{x} , \textbf{I} ; \theta_{f} \left.\right) \left]\right. \textbf{t} \left.\right) \left]\right.}} \bigodot h \left(\right. \textbf{x} , \textbf{I} ; \theta_{h} \left.\right) .$ 
$$
{\textbf{x}}(t) = \underbrace{\sigma(-f({\textbf{x}}, {\textbf{I}};\theta_f) {{\textbf{t}}})}_{{{\rm{time}}\text{-}{\rm{continuous}}\,{\rm{gating}}}} \odot g({\textbf{x}},{\textbf{I}};\theta_g) + \underbrace{\left[ 1 -\sigma(-[f({\textbf{x}}, {\textbf{I}};\theta_f)] {{\textbf{t}}}) \right]}_{{{\rm{time}}\text{-}{\rm{continuous}}\,{\rm{gating}}}} \odot h({\textbf{x}},{\textbf{I}};\theta_h).
$$

(4)

The CfC architecture is illustrated in Extended Data Fig. [2](https://www.nature.com/articles/s42256-022-00556-7#Fig4). The neural network instances could be selected arbitrarily. The time complexity of the algorithm is equivalent to that of discretized recurrent networks [^25], being at least one order of magnitude faster than ODE-based networks.

### The procedure to account for the explicit time dependence

CfCs are continuous-depth models that can set their temporal behaviour based on the task under test. For time-variant datasets (for example, irregularly sampled time series, event-based data and sparse data), the *t* for each incoming sample is set based on its time stamp or order. For sequential applications where the time of the occurrence of a sample does not matter, *t* is sampled as many times as the batch length, with equidistant intervals within two hyperparameters *a* and *b*.

### Experiments with CfCs

We now assess the performance of CfCs in a series of sequential data processing tasks compared with advanced, recurrent models. We first approach solving conventional sequential data modelling tasks (for example, bit-stream prediction, sentiment analysis on text data, medical time-series prediction, human activity recognition, sequential image processing and robot kinematics modelling), and compare CfC variants with an extensive set of advanced RNN baselines. We then evaluate how CfCs compare with LTC-based neural circuit policies (NCPs) [^22] in real-world autonomous lane-keeping tasks.

### CfC network variants

To evaluate the proposed modifications we applied to the closed-form solution network described by equation ([3](https://www.nature.com/articles/s42256-022-00556-7#Equ3)), we test four variants of the CfC architecture: (1) the closed-form solution network (Cf-S) obtained by equation ([3](https://www.nature.com/articles/s42256-022-00556-7#Equ3)), (2) the CfC without the second gating mechanism (CfC-noGate), a variant that does not have the 1 −  *σ* instance shown in Extended Data Fig. [2](https://www.nature.com/articles/s42256-022-00556-7#Fig4), (3) The CfC model (CfC) expressed by equation ([4](https://www.nature.com/articles/s42256-022-00556-7#Equ4)) and (4) the CfC wrapped inside a mixed memory architecture (that is, where the CfC defines the memory state of an RNN, for instance, a long short-term memory (LSTM)), a variant we call CfC-mmRNN. Each of these four proposed variants leverages our proposed solution and thus is at least one order of magnitude faster than continuous-time ODE models.

To investigate their representation learning power, in the following we extensively evaluate CfCs on a series of sequence modelling tasks. The objective is to test the effectiveness of the CfCs in learning spatiotemporal dynamics, compared with a wide range of advanced models.

### Baselines

We compare CfCs with a diverse set of advanced algorithms developed for sequence modelling by both discretized and continuous mechanisms. These baselines are given in full in [Methods](https://www.nature.com/articles/s42256-022-00556-7#Sec28).

### Human activity recognition

The human activity dataset [^7] contains 6,554 sequences of humans demonstrating activities such as walking, lying, sitting, etc. The input space is formed of 561-dimensional inertial sensor measurements per time step, recorded from the user’s smartphone [^26], being categorized into six group of activities (per time step) as output.

We set up our dataset split (training, validation and test) to carefully reflect the modifications made by Rubanova et al.[^7] on this task. The results of this experiment are reported in Table [2](https://www.nature.com/articles/s42256-022-00556-7#Tab2). We observe that not only do the CfC variants Cf-S, CfC-noGate and CfC-mmRNN outperform other models with a high margin, but they do so with a speed-up of more than 8,752% over the best-performing ODE-based instance (Latent-ODE-ODE). The reason for such a large speed difference is the complexity of the dataset dynamics that causes the ODE solvers of ODE-based models such as Latent-ODE-ODE to compute many steps upon stiff dynamics. This issue does not exist for closed-form models as they do not use any ODE solver to account for dynamics. The hyperparameter details of this experiment are provided in Extended Data Fig. [3](https://www.nature.com/articles/s42256-022-00556-7#Fig5).

**Table 2 Human activity recognition, per time-step classification**

### Physical dynamics modelling

The Walker2D dataset consists of kinematic simulations of the MuJoCo physics engine [^27] (see [Methods](https://www.nature.com/articles/s42256-022-00556-7#Sec28) for more details). As shown in Table [3](https://www.nature.com/articles/s42256-022-00556-7#Tab3), CfCs outperform the other baselines by a large margin, supporting their strong capability to model irregularly sampled physical dynamics with missing phases. It is worth mentioning that, on this task, CfCs even outperform transformers by a considerable, 18% margin. The hyperparameter details of this experiment are provided in Extended Data Fig. [3](https://www.nature.com/articles/s42256-022-00556-7#Fig5).

**Table 3 Per time-step regression**

### Event-based sequential image processing

We next assess the performance of CfCs on a challenging sequential image processing task. This task is generated from the sequential modified National Institute of Standards and Technology (MNIST) dataset following the steps described in [Methods](https://www.nature.com/articles/s42256-022-00556-7#Sec28). Moreover, the hyperparameter details of this experiment are provided in Extended Data Fig. [4](https://www.nature.com/articles/s42256-022-00556-7#Fig6).

Table [4](https://www.nature.com/articles/s42256-022-00556-7#Tab4) summarizes the results on this event-based sequence classification task. We observe that models such as ODE-RNN, CT-RNN, GRU-ODE and LSTMs struggle to learn a good representation of the input data and therefore show poor performance. In contrast, RNNs endowed with explicit memory, such as bi-directional RNNs, GRU-D, Lipschitz RNN, coRNN, CT-LSTM and ODE-LSTM, perform well on this task. All CfC variants perform well on this task and establish the state-of-the-art on this task, with CfC-mmRNN achieving 98.09% and CfC-noGate achieving 96.99% accuracy in classifying irregularly sampled sequences. It is worth mentioning that they do so around 200–400% faster than ODE-based models such as GRU-ODE and ODE-RNN.

**Table 4 Event-based sequence classification on irregularly sequential MNIST**

### Regularly and irregularly sampled bit-stream XOR

The bit-stream XOR dataset [^9] considers the classification of bit streams by implementing an XOR function in time. That is, each item in the sequence contributes equally to the correct output. The details are given in [Methods](https://www.nature.com/articles/s42256-022-00556-7#Sec28).

Extended Data Fig. [5](https://www.nature.com/articles/s42256-022-00556-7#Fig7) compares the performance of many RNN baselines. Many architectures such as Augmented LSTM, CT-GRU, GRU-D, ODE-LSTM, coRNN and Lipschitz RNN, and all variants of CfC, can successfully solve the task with 100% accuracy when the bit-stream samples are equidistant from each other. However, when the bit-stream samples arrive at non-uniform distances, only architectures that are immune to the vanishing gradient in irregularly sampled data can solve the task. These include GRU-D, ODE-LSTM, CfC and CfC-mmRNNs. ODE-based RNNs cannot solve the event-based encoding tasks regardless of their choice of solvers, as they have vanishing/exploding gradient issues [^9]. The hyperparameter details of this experiment are provided in Extended Data Fig. [4](https://www.nature.com/articles/s42256-022-00556-7#Fig6).

### PhysioNet Challenge

The PhysioNet Challenge 2012 dataset considers the prediction of the mortality of 8,000 patients admitted to the intensive care unit. The features represent time series of medical measurements taken during the first 48 h after admission. The data are irregularly sampled in time and over features, that is, only a subset of the 37 possible features is given at each time point. We perform the same test–train split and preprocessing as in ref. [^7], and report the area under the curve (AUC) on the test set as a metric in Extended Data Fig. [6](https://www.nature.com/articles/s42256-022-00556-7#Fig8). We observe that CfCs perform competitively to other baselines while performing 160 times faster in terms of training time compared with ODE-RNN and 220 times compared with continuous latent models. CfCs are also, on average, three times faster than advanced discretized gated recurrent models. The hyperparameter details of this experiment are provided in Extended Data Fig. [7](https://www.nature.com/articles/s42256-022-00556-7#Fig9).

### Sentiment analysis using IMDB

The Internet Movie Database (IMDB) sentiment analysis dataset [^28] consists of 25,000 training and 25,000 test sentences (see [Methods](https://www.nature.com/articles/s42256-022-00556-7#Sec28) for more details). Extended Data Fig. [8](https://www.nature.com/articles/s42256-022-00556-7#Fig10) shows how CfCs equipped with mixed memory instances outperform advanced RNN benchmarks. The hyperparameter details of this experiment are provided in Extended Data Fig. [7](https://www.nature.com/articles/s42256-022-00556-7#Fig9).

### Performance of CfCs in autonomous driving

In this experiment, our objective is to evaluate how robustly CfCs learn to perform autonomous navigation in comparison with their ODE-based counterparts, LTC networks. The task is to map incoming high-dimensional pixel observations to steering curvature commands. The details of this experiment are given in [Methods](https://www.nature.com/articles/s42256-022-00556-7#Sec28).

We observe that CfCs similar to NCPs demonstrate a consistent attention pattern in each subtask while maintaining their attention profile under heavy noise as depicted in Extended Data Fig. [10c](https://www.nature.com/articles/s42256-022-00556-7#Fig12). This is while the attention profile of other networks such as CNNs and LSTMs is hindered by added input noise (Extended Data Fig. [10c](https://www.nature.com/articles/s42256-022-00556-7#Fig12)).

This experiment empirically validates that CfCs possess similar robustness properties to their ODE counterparts, that is, LTC-based networks. Moreover, similar to NCPs, CfCs are parameter efficient. They performed the end-to-end autonomous lane-keeping task with around 4,000 trainable parameters in their RNN component (Extended Data Fig. [9](https://www.nature.com/articles/s42256-022-00556-7#Fig11)).

## Scope, discussion and conclusions

We introduce a closed-form continuous-time neural model built from an approximate closed-form solution of LTC networks that possess the strong modelling capabilities of ODE-based networks while being notably faster, more accurate, and stable. These closed-form continuous-time models achieve this by explicit time-dependent gating mechanisms and having a LTC modulated by neural networks. A discussion of related research on continuous-time models is given in [Methods](https://www.nature.com/articles/s42256-022-00556-7#Sec28).

For large-scale time-series prediction tasks, and where closed-loop performance matters [^24], CfCs can bring great value. This is because they capture the flexible, causal and continuous-time nature of ODE-based networks, such as LTC networks, while being more efficient. A discussion on how to use different variants of CfCs is provided in [Methods](https://www.nature.com/articles/s42256-022-00556-7#Sec28). On the other hand, implicit ODE- and partial differential equation-based models [^17] [^29] [^30] [^31] can be beneficial in solving continuously defined physics problems and control tasks. Moreover, for generative modelling, continuous normalizing flows built by ODEs are the suitable choice of model as they ensure invertibility, unlike CfCs [^2]. This is because DEs guarantee invertibility (that is, under uniqueness conditions [^6], one can run them backwards in time). CfCs only approximate ODEs and therefore no longer necessarily form a bijection [^32].

### What are the limitations of CfCs?

CfCs might express vanishing gradient problems. To avoid this, for tasks that require long-term dependences, it is better to use them together with mixed memory networks [^9] (as in the CfC variant CfC-mmRNN) or with proper parametrization of their transition matrices [^33] [^34]. Moreover, we speculate that inferring causality from ODE-based networks might be more straightforward than a closed-form solution [^24]. It would also be beneficial to assess whether verifying a continuous neural flow [^35] is more tractable by using an ODE representation of the system or its closed form.

For problems such as language modelling where a large amount of sequential data and substantial computational resources are available, transformers [^36] and their variants are great choices of models. CfCs could bring value when: (1) data have limitations and irregularities (for example, medical data, financial time series, robotics [^37] and closed-loop control, and multi-agent autonomous systems in supervised and reinforcement learning schemes [^38]), (2) the training and inference efficiency of a model is important (for example, embedded applications [^39] [^40] [^41]) and (3) when interpretability matters [^42].

### Ethics statement

All authors acknowledge the Global Research Code on the development, implementation and communication of this research. For the purpose of transparency, we have included this statement on inclusion and ethics. This work cites a comprehensive list of research from around the world on related topics.

## Methods

### Proof of theorem 1

*Proof.* In the single-dimensional case, the IVP in equation ([1](https://www.nature.com/articles/s42256-022-00556-7#Equ1)) becomes linear in *x* as follows:

 $\frac{d}{d t} x \left(\right. t \left.\right) = - \left[\right. w_{\tau} + f \left(\right. I \left(\right. t \left.\right) \left.\right) \left]\right. \cdot x \left(\right. t \left.\right) + A f \left(\right. I \left(\right. t \left.\right) \left.\right) .$ 
$$
\frac{{\mathrm{d}}}{{\mathrm{d}}t}x(t)=-\left[{w}_{\tau }+f(I(t))\right]\cdot x(t)+Af(I(t)).
$$

(5)

Therefore, we can use the theory of linear ODEs to obtain an integral closed-form solution (section 1.10 in ref. [^21]) consisting of two nested integrals. The inner integral can be eliminated by means of integration by substitution [^43]. The remaining integral expression can then be solved in the case of piecewise constant inputs and approximated in the case of general inputs. The three steps of the proof are outlined below.

### Integral closed-form solution of LTC

We consider the ODE semantics of a single neuron that receives some arbitrary continuous input signal *I* and has a positive, bounded, continuous and monotonically increasing nonlinearity *f*:

 $\frac{d}{d t} x \left(\right. t \left.\right) = - \left[\right. w_{\tau} + f \left(\right. I \left(\right. t \left.\right) \left.\right) \left]\right. \cdot x \left(\right. t \left.\right) + A \cdot \left[\right. w_{\tau} + f \left(\right. I \left(\right. t \left.\right) \left.\right) \left]\right. .$ 
$$
\frac{{\mathrm{d}}}{{\mathrm{d}}t}x(t)=-\left[{w}_{\tau }+f(I(t))\right]\cdot x(t)+A\cdot \left[{w}_{\tau }+f(I(t))\right].
$$

*Assumption*. We assumed a second constant value *w* <sub><i>τ</i></sub> in the above representation of a single LTC neuron. This is done to introduce symmetry in the structure of the ODE, yielding a simpler expression for the solution. The inclusion of this second constant may appear to profoundly alter the dynamics. However, as shown below, numerical experiments suggest that this simplifying assumption has a marginal effect on the ability to approximate LTC cell dynamics.

Using the variation of constants formula (section 1.10 in ref. [^21]), we obtain after some simplifications:

 $x \left(\right. t \left.\right) = \left(\right. x \left(\right. 0 \left.\right) - A \left.\right) e^{- w_{\tau} t - \int_{0}^{t} f \left(\right. I \left(\right. s \left.\right) \left.\right) d s} + A .$ 
$$
x(t)=(x(0)-A){\mathrm{e}}^{-{w}_{\tau }t-\int\nolimits_{0}^{t}f(I(s)){\mathrm{d}}s}+A.
$$

(6)

### Analytical LTC solution for piecewise constant inputs

The derivation of a useful closed-form expression of *x* requires us to solve the integral expression $\int\nolimits_{0}^{t}f(I(s))\,{\mathrm{d}}s$ for any *t*  ≥ 0. Fortunately, the integral $\int\nolimits_{0}^{t}f(I(s))\,{\mathrm{d}}s$ enjoys a simple closed-form expression for piecewise constant inputs *I*. Specifically, assume that we are given a sequence of time points

 $0 = \tau_{0} < \tau_{1} < \tau_{2} < \ldots < \tau_{n - 1} < \tau_{n} = \infty ,$ 
$$
0={\tau }_{0} < {\tau }_{1} < {\tau }_{2} < \ldots < {\tau }_{n-1} < {\tau }_{n}=\infty ,
$$

such that ${\tau }_{1},\ldots ,{\tau }_{n-1}\in {\mathbb{R}}$ and *I* (*t*) =  *γ* <sub><i>i</i></sub> for all *t*  ∈ \[*τ* <sub><i>i</i></sub>; *τ* <sub><i>i</i> +1</sub>) with 0 ≤  *i*  ≤ *n*  − 1. Then, it holds that

 $\int_{0}^{t} f \left(\right. I \left(\right. s \left.\right) \left.\right) d s = f \left(\right. \gamma_{k} \left.\right) \left(\right. t - \tau_{k} \left.\right) + \sum_{i = 0}^{k - 1} ⁡ f \left(\right. \gamma_{i} \left.\right) \left(\right. \tau_{i + 1} - \tau_{i} \left.\right) ,$ 
$$
\int\nolimits_{0}^{t}f(I(s))\,{\mathrm{d}}s=f({\gamma }_{k})(t-{\tau }_{k})+\mathop{\sum }\limits_{i=0}^{k-1}f({\gamma }_{i})({\tau }_{i+1}-{\tau }_{i}),
$$

(7)

when *τ* <sub><i>k</i></sub>  ≤  *t*  <  *τ* <sub><i>k</i> +1</sub> for some 0 ≤  *k*  ≤  *n*  − 1 (as usual, one defines $\mathop{\sum }\nolimits_{i = 0}^{-1}:= 0$). With this, we have

 $x \left(\right. t \left.\right) = \left(\right. x \left(\right. 0 \left.\right) - A \left.\right) e^{- w_{\tau} t} e^{- f \left(\right. \gamma_{k} \left.\right) \left(\right. t - \tau_{k} \left.\right) - \sum_{i = 0}^{k - 1} ⁡ f \left(\right. \gamma_{i} \left.\right) \left(\right. \tau_{i + 1} - \tau_{i} \left.\right)} + A ,$ 
$$
x(t)=(x(0)-A){{\mathrm{e}}}^{-{w}_{\tau }t}{{\mathrm{e}}}^{-f({\gamma }_{k})(t-{\tau }_{k})-\mathop{\sum }\limits_{i = 0}^{k-1}f({\gamma }_{i})({\tau }_{i+1}-{\tau }_{i})}+A,
$$

(8)

when *τ* <sub><i>k</i></sub>  ≤  *t*  <  *τ* <sub><i>k</i> +1</sub> for some 0 ≤  *k*  ≤  *n*  − 1. While any continuous input can be approximated arbitrarily well by a piecewise constant input [^43], a tight approximation may require a large number of discretization points *τ* <sub>1</sub>, …, *τ* <sub><i>n</i></sub>. We address this next.

### Analytical LTC approximation for general inputs

Inspired by equations ([7](https://www.nature.com/articles/s42256-022-00556-7#Equ7)) and ([8](https://www.nature.com/articles/s42256-022-00556-7#Equ8)), the next result provides an analytical approximation of *x* (*t*).

### Lemma 1

*For any Lipschitz continuous, positive, monotonically increasing and bounded f and continuous input signal I(t), we approximate x(t) in equation (*[6](https://www.nature.com/articles/s42256-022-00556-7#Equ6)*) as*

 $\overset{\sim}{x} \left(\right. t \left.\right) = \left(\right. x \left(\right. 0 \left.\right) - A \left.\right) e^{- \left[\right. w_{\tau} t + f \left(\right. I \left(\right. t \left.\right) \left.\right) t \left]\right.} f \left(\right. - I \left(\right. t \left.\right) \left.\right) + A .$ 
$$
\tilde{x}(t)=(x(0)-A){{\mathrm{e}}}^{-\left[{w}_{\tau }t+f(I(t))t\right]}f(-I(t))+A.
$$

(9)

*Then,* $| x(t)-\tilde{x}(t)| \le | x(0)-A| {{\mathrm{e}}}^{-{w}_{\tau }t}$ *for all t*   *≥*   *0\. Writing c*   *\=*   *x(0)*   *−*   *A for convenience, we can obtain the following sharpness results, additionally:*

1. *For any t*   *≥*   *0, we have* $\sup \left\{ \frac{1}{c}(x(t)-\tilde{x}(t))| I:[0;t]\to {\mathbb{R}} \right\}={{\mathrm{e}}}^{-{w}_{\tau }t}$ *.*
2. *For any t*   *≥*   *0, we have* $\inf \left\{ \frac{1}{c}(x(t)-\tilde{x}(t))| I:[0;t]\to {\mathbb{R}} \right\}={{\mathrm{e}}}^{-{w}_{\tau }t}({{\mathrm{e}}}^{-t}-1)$ *.*

*Above, the supremum and infimum are meant to be taken across all continuous input signals. These statements settle the question about the worst-case errors of the approximation. The first statement implies, in particular, that our bound is sharp.*

The full proof is given in the next section. Lemma 1 demonstrates that the integral solution we obtained and shown in equation ([6](https://www.nature.com/articles/s42256-022-00556-7#Equ6)) is tightly close to the approximate closed-form solution we proposed in equation (9). Note that, as *w* <sub><i>τ</i></sub> is positively defined, the derived bound between equations ([6](https://www.nature.com/articles/s42256-022-00556-7#Equ6)) and (9) ensures an exponentially decaying error as time goes by. Therefore, we have the statement of the theorem. □

### Proof of lemma 1

We start by noting that

 $x \left(\right. t \left.\right) - \overset{\sim}{x} \left(\right. t \left.\right) = c e^{- w_{\tau} t} \left[\right. e^{- \int_{0}^{t} f \left(\right. I \left(\right. s \left.\right) \left.\right) d s} - e^{- f \left(\right. I \left(\right. t \left.\right) \left.\right) t} f \left(\right. - I \left(\right. t \left.\right) \left.\right) \left]\right. .$ 
$$
x(t)-\tilde{x}(t)=c\,{{\mathrm{e}}}^{-{w}_{\tau }t}\left[{{\mathrm{e}}}^{-\int\nolimits_{0}^{t}f(I(s)){\mathrm{d}}s}-{{\mathrm{e}}}^{-f(I(t))t}f(-I(t))\right].
$$

Since 0 ≤  *f*  ≤ 1, we conclude that ${{\mathrm{e}}}^{-\int\nolimits_{0}^{t}f(I(s)){\mathrm{d}}s}\in [0;1]$ and e <sup>− <i>f</i> (<i>I</i> (<i>t</i>)) <i>t</i></sup> *f* (− *I* (*t*)) ∈ \[0; 1\]. This shows that $| x(t)-\tilde{x}(t)| \le | c| {{\mathrm{e}}}^{-{w}_{\tau }t}$. To see the sharpness results, pick some arbitrary small *ε*  > 0 and a sufficiently large *C*  > 0 such that *f* (− *C*) ≤  *ε* and 1 −  *ε*  ≤  *f* (*C*). With this, for any 0 <  *δ*  <  *t*, we consider the piecewise constant input signal *I* such that *I* (*s*) = − *C* for *s*  ∈ \[0; *t*  −  *δ*\] and *I* (*s*) =  *C* for *s*  ∈ (*t*  −  *δ*; *t*\]. Then, it can be noted that

 $e^{- \int_{0}^{t} f \left(\right. I \left(\right. s \left.\right) \left.\right) d s} - e^{- f \left(\right. I \left(\right. t \left.\right) \left.\right) t} f \left(\right. - I \left(\right. t \left.\right) \left.\right) \geq \\ e^{- \epsilon t - \delta \cdot 1} - e^{- \left(\right. 1 - \epsilon \left.\right) \cdot t} \epsilon \rightarrow 1 , w h e n \epsilon , \delta \rightarrow 0 .$ 
$$
\begin{array}{l}{{\mathrm{e}}}^{-\int\nolimits_{0}^{t}f(I(s)){\mathrm{d}}s}-{{\mathrm{e}}}^{-f(I(t))t}f(-I(t))\ge \\ {{\mathrm{e}}}^{-\varepsilon t-\delta \cdot 1}-{{\mathrm{e}}}^{-(1-\varepsilon )\cdot t}\varepsilon \to 1,\,\,{{{\rm{when}}}}\,\,\varepsilon ,\delta \to 0\end{array}.
$$

Statement 1 follows by noting that there exists a family of continuous signals ${I}_{n}:[0;t]\to {\mathbb{R}}$ such that ∣ *I* <sub><i>n</i></sub> ( ⋅ )∣ ≤  *C* for all *n*  ≥ 1 and *I* <sub><i>n</i></sub>  →  *I* pointwise as *n*  →  *∞*. This is because

 $\underset{n \rightarrow \infty}{lim} ⁡ \left|\right. \int_{0}^{t} f \left(\right. I \left(\right. s \left.\right) \left.\right) d s - \int_{0}^{t} f \left(\right. I_{n} \left(\right. s \left.\right) \left.\right) d s \left|\right. \leq \\ \underset{n \rightarrow \infty}{lim} ⁡ \int_{0}^{t} \left|\right. f \left(\right. I \left(\right. s \left.\right) \left.\right) - f \left(\right. I_{n} \left(\right. s \left.\right) \left.\right) \left|\right. d s \leq \underset{n \rightarrow \infty}{lim} ⁡ L \int_{0}^{t} \left|\right. I \left(\right. s \left.\right) - I_{n} \left(\right. s \left.\right) \left|\right. d s \\ = 0 ,$ 
$$
\begin{array}{l}\mathop{\lim }\limits_{n\to \infty }\left|\right.\int\nolimits_{0}^{t}f(I(s))\,{\mathrm{d}}s-\int\nolimits_{0}^{t}f({I}_{n}(s))\,{\mathrm{d}}s\left|\right.\le \\ \mathop{\lim }\limits_{n\to \infty }\int\nolimits_{0}^{t}|\, f(I(s))-f({I}_{n}(s))| \,{\mathrm{d}}s\le \mathop{\lim }\limits_{n\to \infty }L\int\nolimits_{0}^{t}| I(s)-{I}_{n}(s)| \, {\mathrm{d}}s\\ =0\end{array},
$$

where *L* is the Lipschitz constant of *f*, and the last identity is due to the dominated convergence theorem [^43]. To see statement 2, we first note that the negation of the signal − *I* provides us with

 $e^{- \int_{0}^{t} f \left(\right. - I \left(\right. s \left.\right) \left.\right) d s} - e^{- f \left(\right. - I \left(\right. t \left.\right) \left.\right) t} f \left(\right. I \left(\right. t \left.\right) \left.\right) \leq \\ e^{- \left(\right. 1 - \epsilon \left.\right) \left(\right. t - \delta \left.\right) - \delta \cdot 0} - e^{- \epsilon \cdot t} \left(\right. 1 - \epsilon \left.\right) \rightarrow e^{- t} - 1 ,$ 
$$
\begin{array}{l}{{\mathrm{e}}}^{-\int\nolimits_{0}^{t}f(-I(s)){\mathrm{d}}s}-{{\mathrm{e}}}^{-f(-I(t))t}f(I(t))\le \\ {{\mathrm{e}}}^{-(1-\varepsilon )(t-\delta )-\delta \cdot 0}-{{\mathrm{e}}}^{-\varepsilon \cdot t}(1-\varepsilon )\to {{\mathrm{e}}}^{-t}-1,\end{array}
$$

if *ε*, *δ*  → 0. The fact that the left-hand side of the last inequality must be at least e <sup>− <i>t</i></sup>  − 1 follows by observing that ${{\mathrm{e}}}^{-t}\le {{\mathrm{e}}}^{-\int\nolimits_{0}^{t}f(I^{\prime} (s)){\mathrm{d}}s}$ and e <sup>− <i>f</i> (<i>I</i> <i>″</i> (<i>t</i>)) <i>t</i></sup> *f* ( −  *I* *″* (*t*)) ≤ 1 for any $I^{\prime} ,I^{\prime\prime} :[0;t]\to {\mathbb{R}}$. □

### Compiling LTC architectures into their closed-form equivalent

In general, it is possible to compile the architecture of an LTC network into its closed-form version. This compilation allows us to speed up the training and inference time of ODE-based networks as the closed-form variant does not require complex ODE solvers to compute outputs. Algorithm 1 provides the instructions on how to transfer the architecture of an LTC network into its closed-form variant. Here, *W* <sub>Adj</sub> corresponds to the adjacency matrix that maps exogenous inputs to hidden states and the coupling among hidden states. This adjacency matrix can have an arbitrary sparsity (that is, there is no need to use a directed acyclic graph for the coupling between neurons).

### Algorithm 1

**Translate the architecture of an LTC network into its closed-form variant**

  **Inputs:** LTC inputs **I** <sup>(<i>N</i> × <i>T</i>)</sup> (*t*), the activity **x** <sup>(<i>H</i> × <i>T</i>)</sup> (*t*) and initial states **x** <sup>(<i>H</i> ×1)</sup> (0) of LTC neurons and the adjacency matrix for synapses ${W}_{Adj}^{[(N+H)* (N+H)]}$

 LTC ODE solver with step of Δ *t*

 time-instance vectors of inputs, ${{{{\bf{t}}}}}_{I(t)}^{(1\times T)}$

 time-instance of LTC neurons **t** <sub><b>x</b> (<i>t</i>)</sub>    ∇ time might be sampled irregularly

 LTC neuron parameter *τ* <sup>(<i>H</i> ×1)</sup>

 LTC network synaptic parameters { *σ* <sup>(<i>N</i> × <i>H</i>)</sup>, *μ* <sup>(<i>N</i> × <i>H</i>)</sup>, *A* <sup>(<i>N</i> × <i>H</i>)</sup> }

  **Outputs:** LTC closed-form approximation of hidden state neurons, ${\hat{{{{\bf{x}}}}}}^{(N\times T)}(t)$

  **x** <sub>pre</sub> (*t*) =  *W* <sub>Adj</sub>  × \[*I* <sub>0</sub> … *I* <sub><i>N</i></sub>, *x* <sub>0</sub> … *x* <sub><i>H</i></sub>\]   ∇ all presynaptic signals to nodes

  **for** *i* th neuron in neurons 1 to *H* **do**

   **for** *j* in Synapses to *i* th neuron **do**

   ${\hat{x}}_{i}+=({x}_{0}-{A}_{ij}){\mathrm{e}}^{\left[\left.-{t}_{x(t)}\odot \left(1/{\tau }_{i}+\frac{1}{1+{e}^{(-{\sigma }_{ij}({x}_{pr{e}_{ij}}-{\mu }_{ij}))}}\right)\right)\right]}\odot \frac{1}{1+{\mathrm{e}}^{({\sigma }_{ij}({x}_{\mathrm{pre}_{ij}}-{\mu }_{ij}))}}+{A}_{ij}$

   **end for**

  **end for**

  **return** $\hat{{{{\bf{x}}}}}(t)$

### Experimental details of the tightness experiment

We took a trained NCP [^22], which consists of a perception module and an LTC-based network [^1] that possesses 19 neurons and 253 synapses. The network was trained to steer a self-driving vehicle autonomously. We used recorded real-world test runs of the vehicle for a lane-keeping task governed by this network. The records included the inputs, outputs and all the LTC neurons’ activities and parameters. To perform a numerical evaluation of our theory to determine whether our proposed closed-form solution for LTC neurons is good enough in practice as well, we inserted the parameters for individual neurons and synapses of the DEs into the closed-form solution (similar to the representations shown in Extended Data Fig. [1b,c](https://www.nature.com/articles/s42256-022-00556-7#Fig3)) and emulated the structure of the ODE-based LTC networks. We then visualized the output neuron’s dynamics of the ODE (in blue) and of the closed-form solution (in red). As illustrated in Fig. [2](https://www.nature.com/articles/s42256-022-00556-7#Fig2), we observed that the behaviour of the ODE is captured by the closed-form solution with a mean squared error of 0.006. This experiment provides numerical evidence for the tightness results presented in our theory. Hence, the closed-form solution contains the main properties of liquid networks in approximating dynamics.

### Baseline models

The example baseline models considered include some variations of classical auto-regressive RNNs, such as an RNN with concatenated Δ *t* (RNN-Δ *t*), a recurrent model with moving average on missing values (RNN-impute), RNN-Decay [^7], LSTMs [^44] and gated recurrent units (GRUs) [^45]. We also report results for a variety of encoder–decoder ODE-RNN-based models, such as RNN-VAE, latent variable models with RNNs, and with ODEs, all from ref. [^7].

Furthermore, we include models such as interpolation prediction networks (IP-Net) [^46], set functions for time series (SeFT) [^47], CT-RNN [^48], CT-GRU [^49], CT-LSTM [^50], GRU-D [^51], PhasedLSTM [^52] and bi-directional RNNs [^53]. Finally, we benchmarked CfCs against competitive recent RNN architectures with the premise of tackling long-term dependences, such as Legandre memory units [^54], high-order polynomial projection operators (Hippo) [^55], orthogonal recurrent models (expRNNs) [^56], mixed memory RNNs such as ODE-LSTMs [^9], coupled oscillatory RNNs (coRNN) [^57] and Lipschitz RNN [^58].

### Experimental details for the Walker2D dataset

This task is designed based on the Walker2d-v2 OpenAI gym [^59] environment using data from four different stochastic policies. The objective is to predict the physics state in the next time step. The training and testing sequences are provided at irregularly sampled intervals. We report the squared error on the test set as a metric.

### Description of the event-based MNIST experiment

We first sequentialize each image by transforming each 28 × 28 image into a long series of length 784. The objective is to predict the class corresponding to each image from the long input sequence. Advanced sequence modelling frameworks such as coRNN [^57], Lipschitz RNN [^58] and mixed memory ODE-LSTM [^9] can solve this task very well with accuracy of up to 99.0%. However, we aim to make the task even more challenging by sparsifying the input vectors with event-like irregularly sampled mechanisms. To this end, in each vector input (that is, flattened image), we transform each consecutive occurrence of values into one event. For instance, within the long binary vector of an image, the sequence 1, 1, 1, 1 is transformed to (1, *t*  = 4) (ref. [^9]). This way, sequences of length 784 are condensed into event-based irregularly sampled sequences of length 256 that are far more challenging to handle than equidistance input signals. A recurrent model now has to learn to memorize input information of length 256 while keeping track of the time lags between the events.

### Description of the event-based XOR encoding experiment

The bit streams are provided in densely sampled and event-based sampled formats. The densely sampled version simply represents an incoming bit as an input event. The event-based sampled version transmits only bit changes to the network, that is, multiple equal bits are packed into a single input event. Consequently, the densely sampled variant is a regular sequence classification problem, whereas the event-based encoding variant represents an irregularly sampled sequence classification problem.

### Experimental details of the IMDB dataset experiment

Each sentence corresponds to either positive or negative sentiment. We tokenize the sentences in a word-by-word fashion with a vocabulary consisting of the 20,000 words occurring most frequently in the dataset. We map each token to a vector using trainable word embedding. The word embedding is initialized randomly. No pretraining of the network or word embedding is performed.

### Setting of the driving experiment

It has been shown that models based on LTC networks are more robust when trained on offline demonstrations and tested online in closed loop with their environments, in many end-to-end robot control tasks such as mobile robots [^60], autonomous ground vehicles [^22] and autonomous aerial vehicles [^24] [^61]. This robustness in decision-making (that is, their flexibility in learning and executing the task from demonstrations despite environmental or observational disturbances and distributional shifts) originates from their model semantics that formally reduces to dynamic causal models [^20] [^24]. Intuitively, LTC-based networks learn to extract a good representation of the task they are given (for example, their attention maps indicate what representation they have learned to focus on the road with more attention to the road’s horizon) and maintain this understanding under heavy distribution shifts. An example is illustrated in Extended Data Fig. [10](https://www.nature.com/articles/s42256-022-00556-7#Fig12).

In this experiment, we aim to investigate whether CfC models and their variants, such as CfC-mmRNN, possess this robustness characteristic (maintaining their attention map under distribution shifts and added noise), similar to their ODE counterparts (LTC-based networks called NCPs [^22]).

We start by training neural network architectures that possess a convolutional head stacked with the choice of RNN. The RNN compartment of the networks is replaced by LSTM networks, NCPs [^22], Cf-S, CfC-NoGate and CfC-mmRNN. We also trained a fully convolutional neural network for the sake of proper comparison. Our training pipeline followed an imitation learning approach with paired pixel-control data from a 30 Hz BlackFly PGE-23S3C red–green–blue camera, collected by a human expert driver across a variety of rural driving environments, including different times of day, weather conditions and seasons of the year. The original 3 h data set was further augmented to include off-orientation recovery data using a privileged controller [^62] and a data-driven view synthesizer [^63]. The privileged controller enabled the training of all networks using guided policy learning [^64]. After training, all networks were transferred on-board our full-scale autonomous vehicle (Lexus RX450H, retrofitted with drive-by-wire capability). The vehicle was consistently started at the centre of the lane, initialized with each trained model and run to completion at the end of the road. If the model exited the bounds of the lane, a human safety driver intervened and restarted the model from the centre of the road at the intervention location. All models were tested with and without noise added to the sensory inputs to evaluate robustness.

The testing environment consisted of 1 km of private test road with unlabelled lane markers, and we observed that all trained networks were able to successfully complete the lane-keeping task at a constant velocity of 30 km h <sup>−1</sup>. Extended Data Fig. [10](https://www.nature.com/articles/s42256-022-00556-7#Fig12) provides an insight into how these networks reach driving decisions. To this end, we computed the attention of each network while driving by using the VisualBackProp algorithm [^65].

### Related works on continuous-time models

#### Continuous-time models

Machine learning, control theory and dynamical systems merge at models with continuous-time dynamics [^60] [^66] [^67] [^68] [^69]. In a seminal work, Chen et al.[^2] [^7] revived the class of continuous-time neural networks [^48] [^70], with neural ODEs. These continuous-depth models give rise to vector field representations and a set of functions that were not possible to generate before with discrete neural networks. These capabilities enabled flexible density estimation [^3] [^4] [^5] [^71] [^72] as well as performant modelling of sequential and irregularly sampled data [^1] [^7] [^8] [^9] [^58]. In this paper, we showed how to relax the need for an ODE solver to realize an expressive continuous-time neural network model for challenging time-series problems.

#### Improving neural ODEs

ODE-based neural networks are as good as their ODE solvers. As the complexity or the dimensionality of the modelling task increases, ODE-based networks demand a more advanced solver that largely impacts their efficiency [^17], stability [^13] [^15] [^73] [^74] [^75] and performance [^1]. A large body of research has studied how to improve the computational overhead of these solvers, for example, by designing hypersolvers [^17], deploying augmentation methods [^4] [^12], pruning [^6] or regularizing the continuous flows [^14] [^15] [^16]. To enhance the performance of an ODE-based model, especially in time-series modelling tasks [^76], solutions for stabilizing their gradient propagation have been provided [^9] [^58] [^77]. In this work, we showed that CfCs improve the scalability, efficiency and performance of continuous-depth neural models.

### Which CfC variants to choose in different applications

Our extensive experimental results demonstrate that different CfC variants, namely Cf-S, CfC-noGate, vanilla CfC and CfC-mmRNN, achieve comparable results to each other while one comes on top depending on the nature of the data set. We suggest using CfC in most cases where the sequence length is up to a couple of hundred steps. To capture longer-range dependences, we recommend CfC-mmRNN. The Cf-S variant is effective when we aim to obtain the fastest inference time. CfC-noGate could be tested as a hyperparameter when using the vanilla CfC as the primary choice of model.

### Description of hyperparameters

The hyperparameters used in our experimental results are as follows:

- clipnorm: the gradient clipping norm (that is, the global norm clipping threshold)
- optimizer: the weight update preconditioner (for example, Adam, Stochastic Gradient Descent with momentum, etc.)
- batch\_size: the number of samples used to compute the gradients
- hidden size: the number of RNN units
- epochs: the number of passes over the training dataset
- base\_lr: the initial learning rate
- decay\_lr: the factor by which the learning rate is multiplied after each epoch
- backbone\_activation: the activation function of the backbone layers
- backbone\_dr: the dropout rate of the backbone layers
- forget\_bias: the forget gate bias (for mmRNN and LSTM)
- backbone\_units: the number of hidden units per backbone layer
- backbone\_layers: the number of backbone layers
- weight\_decay: the L2 weight regularization factor
- *τ* <sub>data</sub>: the constant factor by which the elapsed time input is multiplied (default value 1)
- init: the gain of the Xavier uniform distribution for the weight initialization (default value 1)

## Data availability

All data and materials used in the analysis are openly available at [https://github.com/raminmh/CfC](https://github.com/raminmh/CfC) under an Apache 2.0 license for the purposes of reproducing and extending the analysis.

## Code availability

All code and materials used in the analysis are openly available at [https://github.com/raminmh/CfC](https://github.com/raminmh/CfC) under an Apache 2.0 license for the purposes of reproducing and extending the analysis ([https://doi.org/10.5281/zenodo.7135472](https://doi.org/10.5281/zenodo.7135472)).

## Change history

- ### 29 November 2022
	A Correction to this paper has been published: [https://doi.org/10.1038/s42256-022-00597-y](https://doi.org/10.1038/s42256-022-00597-y)

## References

## Acknowledgements

This research was supported in part by the AI2050 program at Schmidt Futures (grant G-22-63172), the Boeing Company, and the United States Air Force Research Laboratory and the United States Air Force Artificial Intelligence Accelerator and was accomplished under cooperative agreement number FA8750-19-2-1000. The views and conclusions contained in this document are those of the authors and should not be interpreted as representing the official policies, either expressed or implied, of the United States Air Force or the U.S. Government. The U.S. Government is authorized to reproduce and distribute reprints for Government purposes, notwithstanding any copyright notation herein. This work was further supported by The Boeing Company and Office of Naval Research grant N00014-18-1-2830. M.T. is supported by the Poul Due Jensen Foundation, grant 883901. M.L. was supported in part by the Austrian Science Fund under grant Z211-N23 (Wittgenstein Award). A.A. was supported by the National Science Foundation Graduate Research Fellowship Program. We thank T.-H. Wang, P. Kao, M. Chahine, W. Xiao, X. Li, L. Yin and Y. Ben for useful suggestions and for testing of CfC models to confirm the results across other domains.

## Ethics declarations

### Competing interests

The authors declare no competing interest.

## Peer review

### Peer review information

*Nature Machine Intelligence* thanks Karl Friston and the other, anonymous, reviewer(s) for their contribution to the peer review of this work.

## Additional information

**Publisher’s note** Springer Nature remains neutral with regard to jurisdictional claims in published maps and institutional affiliations.

## Extended data

### Extended Data Fig. 1 Instantiation of LTCs in ODE and closed-form representations.

a) A sample LTC network with two nodes and five synapses. b) the ODE representation of this two-neuron system. c) the approximate closed-form representation of the network.

### Extended Data Fig. 2 Closed-form Continuous-depth neural architecture.

A backbone neural network layer delivers the input signals into three head networks g, f and h. f acts as a *liquid* time-constant for the sigmoidal time-gates of the network. g and h construct the nonlinearities of the overall CfC network.

### Extended Data Fig. 3 Hyperparameters for Human activity and Walker.

List of hyperparameters used to obtain results in Human activity and Walker2D Experiments.

### Extended Data Fig. 4 Hyperparameters for ET-sMNIST and Bit-stream XOR.

List of hyperparameters used to obtain results in Event-based MNIST and Bit-stream XOR Experiments.

### Extended Data Fig. 5 Bit-stream XOR sequence classification.

The performance values (accuracy %) for all baseline models are reproduced from [^9]. Numbers present mean ± standard deviations, (n=5). **Note**: The performance of models marked by † are reported from [^9]. Bold declares highest accuracy and best time per epoch (min).

### Extended Data Fig. 6 PhysioNet.

AUC stands for area under curve. Numbers present mean ± standard deviations, (n=5). **Note:** The performance of the models marked by † are reported from [^7] and the ones with \* from [^78]. Bold declares highest AUC score and best time per epoch (min).

### Extended Data Fig. 7 Hyperparameters for Physionet and IMDB.

List of hyperparameters used to obtain results in Physionet and IMDB sentiment classification experiments.

### Extended Data Fig. 8 Results on the IMDB datasets.

The experiment is performed without any pretraining or pretrained word-embeddings. Thus, we excluded advanced attention-based models [^78] [^79] such as Transformers [^36] and RNN structures that use pretraining. Numbers present mean ± standard deviations, (n=5). **Note:** The performance of the models marked by † are reported from [^55], and \* are reported from [^57]. The n/a standard deviation denotes that the original report of these experiments did not provide the statistics of their analysis. Bold declares highest accuracy and best time per epoch (min).

### Extended Data Fig. 9 Lane-keeping models’ parameter count.

CfC and NCP networks perform lane-keeping in unseen scenarios with a compact representation.

### Extended Data Fig. 10 Attention Profile of networks.

Trained networks receive unseen inputs (first column in each tab) and generate acceleration and steering commands. We use the Visual-Backprop algorithm [^65] to compute the saliency maps of the convolutional part of each network. a) results for networks tested on data collected in summer. b) results for networks tested on data collected in winter. c) results for inputs corrupted by a zero-mean Gaussian noise with variance, *σ* <sup>2</sup>  = 0.35.

## Rights and permissions

**Open Access** This article is licensed under a Creative Commons Attribution 4.0 International License, which permits use, sharing, adaptation, distribution and reproduction in any medium or format, as long as you give appropriate credit to the original author(s) and the source, provide a link to the Creative Commons license, and indicate if changes were made. The images or other third party material in this article are included in the article’s Creative Commons license, unless indicated otherwise in a credit line to the material. If material is not included in the article’s Creative Commons license and your intended use is not permitted by statutory regulation or exceeds the permitted use, you will need to obtain permission directly from the copyright holder. To view a copy of this license, visit [http://creativecommons.org/licenses/by/4.0/](http://creativecommons.org/licenses/by/4.0/).

[^1]: Hasani, R., Lechner, M., Amini, A., Rus, D. & Grosu, R. Liquid time-constant networks. In *Proc. of AAAI Conference on Artificial Intelligence* 35(9), 7657–7666 (AAAI, 2021).

[^2]: Chen, T. Q., Rubanova, Y., Bettencourt, J. & Duvenaud, D. K. Neural ordinary differential equations. In *Proc. of Advances in Neural Information Processing Systems* (Eds. Bengio, S. et al.) 6571–6583 (NeurIPS, 2018).

[^3]: Grathwohl, W., Chen, R. T., Bettencourt, J., Sutskever, I. & Duvenaud, D. Ffjord: free-form continuous dynamics for scalable reversible generative models. In *International Conference on Learning Representations* (2018). [https://openreview.net/forum?id=rJxgknCcK7](https://openreview.net/forum?id=rJxgknCcK7)

[^4]: Dupont, E., Doucet, A. & Teh, Y. W. Augmented neural ODEs. In *Proc. of* *Advances in Neural Information Processing Systems* (Eds. Wallach, H. et al.) 3134–3144 (NeurIPS, 2019).

[^5]: Yang, G. et al. Pointflow: 3D point cloud generation with continuous normalizing flows. In *Proc. of the IEEE/CVF International Conference on Computer Vision* 4541–4550 (IEEE, 2019).

[^6]: Liebenwein, L., Hasani, R., Amini, A. & Daniela, R. Sparse flows: pruning continuous-depth models. In *Proc. of Advances in Neural Information Processing Systems* (Eds. Ranzato, M. et al.) 22628–22642 (NeurIPS, 2021).

[^7]: Rubanova, Y., Chen, R. T. & Duvenaud, D. Latent Neural ODEs for irregularly-sampled time series. In *Proc. of Advances in Neural Information Processing Systems* (Eds. Wallach, H. et al.) 32 (NeurIPS, 2019).

[^8]: Gholami, A., Keutzer, K. & Biros, G. ANODE: unconditionally accurate memory-efficient gradients for neural ODEs. In *Proceedings of the 28th International Joint Conference on Artificial Intelligence* 730–736 (IJCAI, 2019).

[^9]: Lechner, M. & Hasani, R. Learning long-term dependencies in irregularly-sampled time series. Preprint at [https://arxiv.org/abs/2006.04418](https://arxiv.org/abs/2006.04418) (2020).

[^10]: Prince, P. J. & Dormand, J. R. High order embedded Runge–Kutta formulae. *J. Comput. Appl. Math.* **7**, 67–75 (1981).

[Article](https://doi.org/10.1016%2F0771-050X%2881%2990010-3) [MathSciNet](http://www.ams.org/mathscinet-getitem?mr=611953) [MATH](http://www.emis.de/MATH-item?0449.65048) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=High%20order%20embedded%20Runge%E2%80%93Kutta%20formulae&journal=J.%20Comput.%20Appl.%20Math.&doi=10.1016%2F0771-050X%2881%2990010-3&volume=7&pages=67-75&publication_year=1981&author=Prince%2CPJ&author=Dormand%2CJR)

[^11]: Raissi, M., Perdikaris, P. & Karniadakis, G. E. Physics-informed neural networks: a deep learning framework for solving forward and inverse problems involving nonlinear partial differential equations. *J. Comput. Phys.* **378**, 686–707 (2019).

[Article](https://doi.org/10.1016%2Fj.jcp.2018.10.045) [MathSciNet](http://www.ams.org/mathscinet-getitem?mr=3881695) [MATH](http://www.emis.de/MATH-item?1415.68175) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Physics-informed%20neural%20networks%3A%20a%20deep%20learning%20framework%20for%20solving%20forward%20and%20inverse%20problems%20involving%20nonlinear%20partial%20differential%20equations&journal=J.%20Comput.%20Phys.&doi=10.1016%2Fj.jcp.2018.10.045&volume=378&pages=686-707&publication_year=2019&author=Raissi%2CM&author=Perdikaris%2CP&author=Karniadakis%2CGE)

[^12]: Massaroli, S., Poli, M., Park, J., Yamashita, A. & Asma, H. Dissecting neural ODEs. In *Proc. of 33th Conference on Neural Information Processing Systems* (Eds. Larochelle, H. et al.) (NeurIPS*,* 2020).

[^13]: Bai, S., Kolter, J. Z. & Koltun, V. Deep equilibrium models. *Adv. Neural Inform. Process. Syst.* **32**, 690–701 (2019).

[Google Scholar](http://scholar.google.com/scholar_lookup?&title=Deep%20equilibrium%20models&journal=Adv.%20Neural%20Inform.%20Process.%20Syst.&volume=32&pages=690-701&publication_year=2019&author=Bai%2CS&author=Kolter%2CJZ&author=Koltun%2CV)

[^14]: Finlay, C., Jacobsen, J.-H., Nurbekyan, L. & Oberman, A. M. How to train your neural ODE: the world of Jacobian and kinetic regularization. In *International Conference on Machine Learning* (Eds. Daumé III, H. & Singh, A.) 3154–3164 (PMLR, 2020).

[^15]: Massaroli, S. et al. Stable Neural Flows. Preprint at [https://arxiv.org/abs/2003.08063](https://arxiv.org/abs/2003.08063) (2020).

[^16]: Kidger, P., Chen, R. T. & Lyons, T. “Hey, that’s not an ODE”: Faster ODE Adjoints via Seminorms. In *Proceedings of the 38th International Conference on Machine Learning* (Eds. Meila, M. & Zhang, T.) 139 (PMLR, 2021).

[^17]: Poli, M. et al. Hypersolvers: toward fast continuous-depth models. In *Proc. of Advances in Neural Information Processing Systems* (Eds. Larochelle, H.) 21105–21117 (NeurIPS, 2020).

[^18]: Schumacher, J., Haslinger, R. & Pipa, G. Statistical modeling approach for detecting generalized synchronization. *Phys. Rev. E* **85**, 056215 (2012).

[Article](https://doi.org/10.1103%2FPhysRevE.85.056215) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Statistical%20modeling%20approach%20for%20detecting%20generalized%20synchronization&journal=Phys.%20Rev.%20E&doi=10.1103%2FPhysRevE.85.056215&volume=85&publication_year=2012&author=Schumacher%2CJ&author=Haslinger%2CR&author=Pipa%2CG)

[^19]: Moran, R., Pinotsis, D. A. & Friston, K. Neural masses and fields in dynamic causal modeling. *Front. Comput. Neurosci.* **7**, 57 (2013).

[Article](https://doi.org/10.3389%2Ffncom.2013.00057) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Neural%20masses%20and%20fields%20in%20dynamic%20causal%20modeling&journal=Front.%20Comput.%20Neurosci.&doi=10.3389%2Ffncom.2013.00057&volume=7&publication_year=2013&author=Moran%2CR&author=Pinotsis%2CDA&author=Friston%2CK)

[^20]: Friston, K. J., Harrison, L. & Penny, W. Dynamic causal modelling. *Neuroimage* **19**, 1273–1302 (2003).

[Article](https://doi.org/10.1016%2FS1053-8119%2803%2900202-7) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Dynamic%20causal%20modelling&journal=Neuroimage&doi=10.1016%2FS1053-8119%2803%2900202-7&volume=19&pages=1273-1302&publication_year=2003&author=Friston%2CKJ&author=Harrison%2CL&author=Penny%2CW)

[^21]: Perko, L. *Differential Equations and Dynamical Systems* (Springer-Verlag, 1991).

[Book](https://link.springer.com/doi/10.1007/978-1-4684-0392-3) [MATH](http://www.emis.de/MATH-item?0717.34001) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Differential%20Equations%20and%20Dynamical%20Systems&doi=10.1007%2F978-1-4684-0392-3&publication_year=1991&author=Perko%2CL)

[^22]: Lechner, M. et al. Neural circuit policies enabling auditable autonomy. *Nat. Mach. Intell.* **2**, 642–652 (2020).

[Article](https://doi.org/10.1038%2Fs42256-020-00237-3) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Neural%20circuit%20policies%20enabling%20auditable%20autonomy&journal=Nat.%20Mach.%20Intell.&doi=10.1038%2Fs42256-020-00237-3&volume=2&pages=642-652&publication_year=2020&author=Lechner%2CM)

[^23]: Hochreiter, S. *Untersuchungen zu dynamischen neuronalen netzen*. Diploma, Technische Universität München 91 (1991).

[^24]: Vorbach, C., Hasani, R., Amini, A., Lechner, M. & Rus, D. Causal navigation by continuous-time neural networks. In *Proc. of Advances in Neural Information Processing Systems* (Eds. Ranzato, M. et al.) 12425–12440 (NeurIPS, 2021).

[^25]: Hasani, R. et al. Response characterization for auditing cell dynamics in long short-term memory networks. In *Proc. of 2019 International Joint Conference on Neural Networks* 1–8 (IEEE, 2019).

[^26]: Anguita, D., Ghio, A., Oneto, L., Parra Perez, X. & Reyes Ortiz, J. L. A public domain dataset for human activity recognition using smartphones. In *Proc. of the 21st International European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning* 437–442 (i6doc, 2013).

[^27]: Todorov, E., Erez, T. & Tassa, Y. MuJoCo: a physics engine for model-based control. In *Proc. of 2012 IEEE/RSJ International Conference on Intelligent Robots and Systems* 5026–5033 (IEEE, 2012).

[^28]: Maas, A. et al. Learning word vectors for sentiment analysis. In *Proc. of the 49th Annual Meeting of the Association for Computational Linguistics: Human Language Technologies* 142–150 (ACM, 2011).

[^29]: Lu, L., Jin, P., Pang, G., Zhang, Z. & Karniadakis, G. E. Learning nonlinear operators via deeponet based on the universal approximation theorem of operators. *Nat. Mach. Intell.* **3**, 218–229 (2021).

[Article](https://doi.org/10.1038%2Fs42256-021-00302-5) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Learning%20nonlinear%20operators%20via%20deeponet%20based%20on%20the%20universal%20approximation%20theorem%20of%20operators&journal=Nat.%20Mach.%20Intell.&doi=10.1038%2Fs42256-021-00302-5&volume=3&pages=218-229&publication_year=2021&author=Lu%2CL&author=Jin%2CP&author=Pang%2CG&author=Zhang%2CZ&author=Karniadakis%2CGE)

[^30]: Karniadakis, G. E. et al. Physics-informed machine learning. *Nat. Rev. Phys.* **3**, 422–440 (2021).

[Article](https://doi.org/10.1038%2Fs42254-021-00314-5) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Physics-informed%20machine%20learning&journal=Nat.%20Rev.%20Phys.&doi=10.1038%2Fs42254-021-00314-5&volume=3&pages=422-440&publication_year=2021&author=Karniadakis%2CGE)

[^31]: Wang, S., Wang, H. & Perdikaris, P. Learning the solution operator of parametric partial differential equations with physics-informed deeponets. *Sci. Adv.* **7**, eabi8605 (2021).

[Article](https://doi.org/10.1126%2Fsciadv.abi8605) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Learning%20the%20solution%20operator%20of%20parametric%20partial%20differential%20equations%20with%20physics-informed%20deeponets&journal=Sci.%20Adv.&doi=10.1126%2Fsciadv.abi8605&volume=7&publication_year=2021&author=Wang%2CS&author=Wang%2CH&author=Perdikaris%2CP)

[^32]: Rezende, D. & Mohamed, S. Variational inference with normalizing flows. In *Proc. of International Conference on Machine Learning* (Eds. Bach, F. & Blei, D.) 1530–1538 (PMLR, 2015).

[^33]: Gu, A., Goel, K. & Re, C. Efficiently modeling long sequences with structured state spaces. In *Proc. of International Conference on Learning Representations* (2022). [https://openreview.net/forum?id=uYLFoz1vlAC](https://openreview.net/forum?id=uYLFoz1vlAC)

[^34]: Hasani, R. et al. Liquid structural state-space models. Preprint at [https://arxiv.org/abs/2209.12951](https://arxiv.org/abs/2209.12951) (2022).

[^35]: Grunbacher, S. et al. On the verification of neural ODEs with stochastic guarantees. *Proc. AAAI Conf. Artif. Intell.* **35**, 11525–11535 (2021).

[Google Scholar](http://scholar.google.com/scholar_lookup?&title=On%20the%20verification%20of%20neural%20ODEs%20with%20stochastic%20guarantees&journal=Proc.%20AAAI%20Conf.%20Artif.%20Intell.&volume=35&pages=11525-11535&publication_year=2021&author=Grunbacher%2CS)

[^36]: Vaswani, A. et al. Attention is all you need. In *Proc. of Advances in Neural Information Processing Systems* (Eds. Guyon, I. et al.) 5998–6008 (NeurIPS, 2017).

[^37]: Lechner, M., Hasani, R., Grosu, R., Rus, D. & Henzinger, T. A. Adversarial training is not ready for robot learning. In *2021 IEEE International Conference on Robotics and Automation (ICRA)* 4140–4147 (IEEE, 2021).

[^38]: Brunnbauer, A. et al. Latent imagination facilitates zero-shot transfer in autonomous racing. In *2022 International Conference on Robotics and Automation (ICRA)* 7513–7520 (IEEE, 2021).

[^39]: Hasani, R. M., Haerle, D. & Grosu, R. Efficient modeling of complex analog integrated circuits using neural networks. In *Proc. of 12th Conference on Ph.D. Research in Microelectronics and Electronics* 1–4 (IEEE, 2016).

[^40]: Wang, G., Ledwoch, A., Hasani, R. M., Grosu, R. & Brintrup, A. A generative neural network model for the quality prediction of work in progress products. *Appl. Soft Comput.* **85**, 105683 (2019).

[Article](https://doi.org/10.1016%2Fj.asoc.2019.105683) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=A%20generative%20neural%20network%20model%20for%20the%20quality%20prediction%20of%20work%20in%20progress%20products&journal=Appl.%20Soft%20Comput.&doi=10.1016%2Fj.asoc.2019.105683&volume=85&publication_year=2019&author=Wang%2CG&author=Ledwoch%2CA&author=Hasani%2CRM&author=Grosu%2CR&author=Brintrup%2CA)

[^41]: DelPreto, J. et al. Plug-and-play supervisory control using muscle and brain signals for real-time gesture and error detection. *Auton. Robots* **44**, 1303–1322 (2020).

[Article](https://link.springer.com/doi/10.1007/s10514-020-09916-x) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Plug-and-play%20supervisory%20control%20using%20muscle%20and%20brain%20signals%20for%20real-time%20gesture%20and%20error%20detection&journal=Auton.%20Robots&doi=10.1007%2Fs10514-020-09916-x&volume=44&pages=1303-1322&publication_year=2020&author=DelPreto%2CJ)

[^42]: Hasani, R. *Interpretable Recurrent Neural Networks in Continuous-Time Control Environments*. PhD dissertation, Technische Univ. Wien (2020).

[^43]: Rudin, W. *Principles of Mathematical Analysis, 3rd edn.* (McGraw-Hill, 1976).

[^44]: Hochreiter, S. & Schmidhuber, J. Long short-term memory. *Neural Comput.* **9**, 1735–1780 (1997).

[Article](https://doi.org/10.1162%2Fneco.1997.9.8.1735) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Long%20short-term%20memory&journal=Neural%20Comput.&doi=10.1162%2Fneco.1997.9.8.1735&volume=9&pages=1735-1780&publication_year=1997&author=Hochreiter%2CS&author=Schmidhuber%2CJ)

[^45]: Chung, J., Gulcehre, C., Cho, K. & Bengio, Y. Empirical evaluation of gated recurrent neural networks on sequence modeling. Preprint at [https://arxiv.org/abs/1412.3555](https://arxiv.org/abs/1412.3555) (2014).

[^46]: Shukla, S. N. & Marlin, B. Interpolation–prediction networks for irregularly sampled time series. In *Proc. of International Conference on Learning Representations* (2018). [https://openreview.net/forum?id=r1efr3C9Ym](https://openreview.net/forum?id=r1efr3C9Ym)

[^47]: Horn, M., Moor, M., Bock, C., Rieck, B. & Borgwardt, K. Set functions for time series. In *Proc. of International Conference on Machine Learning* (Eds. Daumé III, H. & Singh, A.) 4353–4363 (PMLR, 2020).

[^48]: Funahashi, K.-i & Nakamura, Y. Approximation of dynamical systems by continuous time recurrent neural networks. *Neural Netw.* **6**, 801–806 (1993).

[Article](https://doi.org/10.1016%2FS0893-6080%2805%2980125-X) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Approximation%20of%20dynamical%20systems%20by%20continuous%20time%20recurrent%20neural%20networks&journal=Neural%20Netw.&doi=10.1016%2FS0893-6080%2805%2980125-X&volume=6&pages=801-806&publication_year=1993&author=Funahashi%2CK-i&author=Nakamura%2CY)

[^49]: Mozer, M. C., Kazakov, D. & Lindsey, R. V. Discrete event, continuous time RNNs. Preprint at [https://arxiv.org/abs/1710.04110](https://arxiv.org/abs/1710.04110) (2017).

[^50]: Mei, H. & Eisner, J. The neural Hawkes process: a neurally self-modulating multivariate point process. In *Proc. of 31st International Conference on Neural Information Processing Systems* (Eds. Guyon, I. et al.) 6757–6767 (Curran Associates Inc., 2017).

[^51]: Che, Z., Purushotham, S., Cho, K., Sontag, D. & Liu, Y. Recurrent neural networks for multivariate time series with missing values. *Sci. Rep.* **8**, 1–12 (2018).

[Article](https://doi.org/10.1038%2Fs41598-018-24271-9) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Recurrent%20neural%20networks%20for%20multivariate%20time%20series%20with%20missing%20values&journal=Sci.%20Rep.&doi=10.1038%2Fs41598-018-24271-9&volume=8&pages=1-12&publication_year=2018&author=Che%2CZ&author=Purushotham%2CS&author=Cho%2CK&author=Sontag%2CD&author=Liu%2CY)

[^52]: Neil, D., Pfeiffer, M. & Liu, S.-C. Phased LSTM: accelerating recurrent network training for long or event-based sequences. In *Proc. of 30th International Conference on Neural Information Processing Systems* (Eds. Lee, D. D. et al.) 3889–3897 (Curran Associates Inc., 2016).

[^53]: Schuster, M. & Paliwal, K. K. Bidirectional recurrent neural networks. *IEEE Trans. Signal Process.* **45**, 2673–2681 (1997).

[Article](https://doi.org/10.1109%2F78.650093) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Bidirectional%20recurrent%20neural%20networks&journal=IEEE%20Trans.%20Signal%20Process.&doi=10.1109%2F78.650093&volume=45&pages=2673-2681&publication_year=1997&author=Schuster%2CM&author=Paliwal%2CKK)

[^54]: Voelker, A. R., Kajić, I. & Eliasmith, C. Legendre memory units: continuous-time representation in recurrent neural networks. In *Proceedings of the 33rd International Conference on Neural Information Processing Systems* (Eds. Wallach, H. et al.) 15570–15579 (ACM, 2019).

[^55]: Gu, A., Dao, T., Ermon, S., Rudra, A. & Ré, C. Hippo: recurrent memory with optimal polynomial projections. In *Proc. of Advances in Neural Information Processing Systems* (Eds. Larochelle, H. et al.) 1474–1487 (NeurIPS, 2020).

[^56]: Lezcano-Casado, M. & Martınez-Rubio, D. Cheap orthogonal constraints in neural networks: a simple parametrization of the orthogonal and unitary group. In *Proc. of International Conference on Machine Learning* (Eds. Chaudhuri, K. & Salakhutdinov, R.) 3794–3803 (PMLR, 2019).

[^57]: Rusch, T. K. & Mishra, S. Coupled oscillatory recurrent neural network (coRNN): an accurate and (gradient) stable architecture for learning long time dependencies. In *Proc. of International Conference on Learning Representations* (2021). [https://openreview.net/forum?id=F3s69XzWOia](https://openreview.net/forum?id=F3s69XzWOia)

[^58]: Erichson, N. B., Azencot, O., Queiruga, A., Hodgkinson, L. & Mahoney, M. W. Lipschitz recurrent neural networks. In *Proc. of International Conference on Learning Representations* (2021). [https://openreview.net/forum?id=-N7PBXqOUJZ](https://openreview.net/forum?id=-N7PBXqOUJZ)

[^59]: Brockman, G. et al. OpenAI gym. Preprint at [https://arxiv.org/abs/1606.01540](https://arxiv.org/abs/1606.01540) (2016).

[^60]: Lechner, M., Hasani, R., Zimmer, M., Henzinger, T. A. & Grosu, R. Designing worm-inspired neural networks for interpretable robotic control. In *Proc. of International Conference on Robotics and Automation* 87–94 (IEEE, 2019).

[^61]: Tylkin, P. et al. Interpretable autonomous flight via compact visualizable neural circuit policies. *IEEE Robot. Autom. Lett.* **7**, 3265–3272 (2022).

[Article](https://doi.org/10.1109%2FLRA.2022.3146555) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Interpretable%20autonomous%20flight%20via%20compact%20visualizable%20neural%20circuit%20policies&journal=IEEE%20Robot.%20Autom.%20Lett.&doi=10.1109%2FLRA.2022.3146555&volume=7&pages=3265-3272&publication_year=2022&author=Tylkin%2CP)

[^62]: Amini, A. et al. Vista 2.0: An open, data-driven simulator for multimodal sensing and policy learning for autonomous vehicles. In *2022 International Conference on Robotics and Automation (ICRA)* 2419–2426 (IEEE, 2022).

[^63]: Amini, A. et al. Learning robust control policies for end-to-end autonomous driving from data-driven simulation. *IEEE Robot. Autom. Lett.* **5**, 1143–1150 (2020).

[^64]: Levine, S. & Koltun, V. Guided policy search. In *Proc. of International Conference on Machine Learning* (Eds. Dasgupta, S. & McAllester, D.) 1–9 (PMLR, 2013).

[^65]: Bojarski, M. et al. VisualBackProp: efficient visualization of CNNs for autonomous driving. In *Proc. of IEEE International Conference on Robotics and Automation* 1–8 (IEEE, 2018).

[^66]: Zhang, H., Wang, Z. & Liu, D. A comprehensive review of stability analysis of continuous-time recurrent neural networks. *IEEE Trans. Neural Netw. Learn. Syst* **25**, 1229–1262 (2014).

[Article](https://doi.org/10.1109%2FTNNLS.2014.2317880) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=A%20comprehensive%20review%20of%20stability%20analysis%20of%20continuous-time%20recurrent%20neural%20networks&journal=IEEE%20Trans.%20Neural%20Netw.%20Learn.%20Syst&doi=10.1109%2FTNNLS.2014.2317880&volume=25&pages=1229-1262&publication_year=2014&author=Zhang%2CH&author=Wang%2CZ&author=Liu%2CD)

[^67]: Weinan, E. A proposal on machine learning via dynamical systems. *Commun. Math. Stat.* **5**, 1–11 (2017).

[Article](https://link.springer.com/doi/10.1007/s40304-017-0103-z) [MathSciNet](http://www.ams.org/mathscinet-getitem?mr=3627592) [MATH](http://www.emis.de/MATH-item?1380.37154) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=A%20proposal%20on%20machine%20learning%20via%20dynamical%20systems&journal=Commun.%20Math.%20Stat.&doi=10.1007%2Fs40304-017-0103-z&volume=5&pages=1-11&publication_year=2017&author=Weinan%2CE)

[^68]: Lu, Z., Pu, H., Wang, F., Hu, Z. & Wang, L. The expressive power of neural networks: a view from the width. In *Proc. of Advances in Neural Information Processing Systems* (Eds. Guyon, I. et al.) 30 (Curran Associates, Inc 2017).

[^69]: Li, Q., Chen, L., Tai, C. et al. Maximum principle based algorithms for deep learning. *J. Mach. Learn. Res.* **18**, 5998–6026 (2018).

[^70]: Cohen, M. A. & Grossberg, S. Absolute stability of global pattern formation and parallel memory storage by competitive neural networks. *IEEE Trans. Syst. Man Cybern.* **5**, 815–826 (1983).

[Article](https://doi.org/10.1109%2FTSMC.1983.6313075) [MathSciNet](http://www.ams.org/mathscinet-getitem?mr=730500) [MATH](http://www.emis.de/MATH-item?0553.92009) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Absolute%20stability%20of%20global%20pattern%20formation%20and%20parallel%20memory%20storage%20by%20competitive%20neural%20networks&journal=IEEE%20Trans.%20Syst.%20Man%20Cybern.&doi=10.1109%2FTSMC.1983.6313075&volume=5&pages=815-826&publication_year=1983&author=Cohen%2CMA&author=Grossberg%2CS)

[^71]: Mathieu, E. & Nickel, M. Riemannian continuous normalizing flows. In *Proc. of Advances in Neural Information Processing Systems* Vol. 33 (eds Larochelle et al.) 2503–2515 (Curran Associates, Inc., 2020).

[^72]: Hodgkinson, L., van der Heide, C., Roosta, F. & Mahoney, M. W. Stochastic normalizing flows. In *Proc. of Advances in Neural Information Processing Systems* (Eds. Larochelle, H. et al.) 5933–5944 (NeurIPS, 2020).

[^73]: Haber, E., Lensink, K., Treister, E. & Ruthotto, L. IMEXnet a forward stable deep neural network. In Proc*. of International Conference on Machine Learning* (Eds. Chaudhuri, K. & Salakhutdinov, R.) 2525–2534 (PMLR, 2019).

[^74]: Chang, B., Chen, M., Haber, E. & Chi, E. H. AntisymmetricRNN: a dynamical system view on recurrent neural networks. In *International Conference on Learning Representations* (2018). [https://openreview.net/forum?id=ryxepo0cFX](https://openreview.net/forum?id=ryxepo0cFX)

[^75]: Lechner, M., Hasani, R., Rus, D. & Grosu, R. Gershgorin loss stabilizes the recurrent neural network compartment of an end-to-end robot learning scheme. In *Proc. of IEEE International Conference on Robotics and Automation* 5446–5452 (IEEE, 2020).

[^76]: Gleeson, P., Lung, D., Grosu, R., Hasani, R. & Larson, S. D. c302: a multiscale framework for modelling the nervous system of *Caenorhabditis elegans*. *Philos.Trans. R. Soc. B* **373**, 20170379 (2018).

[Article](https://doi.org/10.1098%2Frstb.2017.0379) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=c302%3A%20a%20multiscale%20framework%20for%20modelling%20the%20nervous%20system%20of%20Caenorhabditis%20elegans&journal=Philos.Trans.%20R.%20Soc.%20B&doi=10.1098%2Frstb.2017.0379&volume=373&publication_year=2018&author=Gleeson%2CP&author=Lung%2CD&author=Grosu%2CR&author=Hasani%2CR&author=Larson%2CSD)

[^77]: Li, X., Wong, T.-K. L., Chen, R. T. & Duvenaud, D. Scalable gradients for stochastic differential equations. In *Proc. of International Conference on Artificial Intelligence and Statistics* 3870–3882 (PMLR, 2020).

[^78]: Shukla, S. N. & Marlin, B. M. Multi-time attention networks for irregularly sampled time series. In *International Conference on Learning Representations* (2020). [https://openreview.net/forum?id=4c0J6lwQ4\_](https://openreview.net/forum?id=4c0J6lwQ4_)

[^79]: Xiong, Y. et al. Nyströmformer: a Nyström-based algorithm for approximating self-attention. In *Proceedings of the AAAI Conference on Artificial Intelligence* Vol. 35, No. 16, pp. 14138–14148 (AAAI, 2021).