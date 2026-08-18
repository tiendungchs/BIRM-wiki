---
title: "Spike frequency adaptation: bridging neural models and neuromorphic applications"
source: "https://pmc.ncbi.nlm.nih.gov/articles/PMC11053160/"
author:
  - "[[Chittotosh Ganguly]]"
  - "[[Sai Sukruth Bezugam]]"
  - "[[Elisabeth Abs]]"
  - "[[Melika Payvand]]"
  - "[[Sounak Dey]]"
  - "[[Manan Suri]]"
published:
created: 2026-06-20
description: "The human brain’s unparalleled efficiency in executing complex cognitive tasks stems from neurons communicating via short, intermittent bursts or spikes. This has inspired Spiking Neural Networks (SNNs), now incorporating neuron models with spike ..."
tags:
  - "clippings"
---
. 2024 Feb 1;3:22. doi: [10.1038/s44172-024-00165-9](https://doi.org/10.1038/s44172-024-00165-9)

## Abstract

The human brain’s unparalleled efficiency in executing complex cognitive tasks stems from neurons communicating via short, intermittent bursts or spikes. This has inspired Spiking Neural Networks (SNNs), now incorporating neuron models with spike frequency adaptation (SFA). SFA adjusts these spikes’ frequency based on recent neuronal activity, much like an athlete’s varying sprint speed. SNNs with SFA demonstrate improved computational performance and energy efficiency. This review examines various adaptive neuron models in computational neuroscience, highlighting their relevance in artificial intelligence and hardware integration. It also discusses the challenges and potential of these models in driving the development of energy-efficient neuromorphic systems.

---

This review explores adaptive neuron models from computational neuroscience, emphasizing their significance in the future development of power efficient artificial intelligence applications and hardware integration.

## Introduction

Spiking neural networks (SNNs) are inspired by their biological counterparts in which information is transmitted mostly through all-or-none events called spikes. Owing to the co-location of memory and computation within a spiking neuron, event-based asynchronous data processing, and sparse activations of nodes across the network, SNNs are inherently more power efficient compared to traditional deep neural networks that use continuous valued activation functions for the neurons– [^1]. SNNs, often mentioned as the third-generation artificial neural networks [^3], are particularly suitable for temporal feature extraction and learning, as well as faster convergence to solutions for optimization problems,[^4]. Based on factors such as application requirement, computational complexity, and ease of implementation, different spiking neuron models are used in SNNs such as the Hodgkin–Huxley model, leaky-integrate and fire model, Izhikevich model and spike response model– [^6]. However, integrate and fire models [^7] which mimic the activities of a biological neuron via functionalities of a simple resistance–capacitance electrical circuit are very popular due to their simple and elegant mathematical structure. An enhanced version of the integrate and fire model is the leaky integrate and fire (LIF) model which also takes the membrane voltage leak into account. SFA, i.e. increase in the inter-spike interval (ISI) over time for a regular spike train, is an intrinsic feature of biological neurons. In this paper, we will focus on SFA as an important feature to explore in SNNs.

In recent SNN models, adaptive neurons have been used to process temporal signals– [^9]. A recurrent spiking neural network (RSNN) aided with neurons with SFA is investigated in ref. [^9], and is termed a long short-term memory neural network (LSNN). The addition of adaptive neurons improved the neural network’s computational efficiency, compared to typical training using backpropagation through time (BPTT). The authors achieved an accuracy of 93.7% on sequential MNIST (SMNIST) and 66.7% on speech recognition (TIMIT data set). It has been demonstrated that the computational efficiency of RSNN has approached that of traditional long–short-term memory networks with neurons capable of SFA. The authors show that sparsely connected RSNNs with sparse firing can achieve all the above-mentioned tasks. The network can accomplish them due to the control of spike timings by SFA. In refs.,[^11], the authors enhanced the temporal computing capabilities of SNN enabled through SFA. In ref. [^11], a single exponential model with two adaptation parameters has been used, while in ref. [^13], a double exponential model with four parameters has been used for the same working memory task. It has been observed that for a working memory of 1200 ms, a double exponential model with high SFA converges much faster.

In [^12] authors have utilized SFA for the development of a computational neurobiological model of language. For language processing short-term storage and integration of information in working memory is necessary. In the study, the authors offer a paradigm in which memory is sustained by intrinsic plasticity, which modulates spike rates. It has been shown that adaptive alterations via SFA produce memory on timescales ranging from milliseconds to seconds. The data is kept in adaptive conductances, which reduce firing rates and can be retrieved directly without the need for storage-based retrieval. Memory span is systematically connected to the adaptation time constant and baseline neuronal excitability levels. When adaptation is long-lasting, interference effects within memory develop.

Over the last few years, there has been an exponential increase in the research on adaptive neuron models. Though the major research is done in the neuroscience domain, it is slowly gaining momentum also in the domain of electronics and computer science, thanks to its increasing potential use in AI-based applications (Fig. [1](#Fig1)). In this survey, we discuss the different adaptive neuron models and the corresponding SNN frameworks where these models have been employed. The adaptive neuron models from the computational neuroscience domain are described and the use of these models in engineering applications is highlighted. The remainder of the paper is organized as follows: Reasons for using adaptive neuron models are presented in the section “Why an adaptive neuron model”. A detailed discussion of the available adaptive neuron models in the computational neuroscience literature is provided in the section “Description of adaptive neuron models”. Section “State-of-the-art case studies with ALIF in SNN” considers selected applications that have been carried out employing adaptive neuron models. Section “Hardware implementations of Adaptive neurons” presents hardware implementations of adaptive neuron models. The open challenges, road ahead, and future opportunities are presented in the section “Discussion and road ahead”.

![Fig. 1](https://cdn.ncbi.nlm.nih.gov/pmc/blobs/ed99/11053160/41f8d7499cad/44172_2024_165_Fig1_HTML.jpg)

Research on SFA has evolved significantly, expanding into diverse fields. The data, gathered from the Web of Science using keywords like “Spike rate adaptation", “Adaptive threshold" AND “neuron", and “Spike frequency adaptation" from 1990 to 2022, highlights growth in SFA research, initially rooted in neuroscience but now also prominent in computer science and electronics hardware. The milestones chart depicts key developments, the bar diagram represents total publications over time, and the pie charts break down the research focus across different periods. Future directions include harnessing SFA and emerging technologies for sustainable and innovative AI applications. AHP after hyperpolarization, STDP spike-timing-dependent plasticity

## Why an adaptive neuron model

Understanding and implementing SFA—which is observed widely in the biological neurons—in both computational models and hardware, could be leveraged to get a step closer to making artificial neural network computations more (power-) efficient. Here we first explain the biological phenomenon of SFA followed by its potential advantages in biology and for artificial intelligence.

### The biological phenomenon of spike frequency adaptation

In biology, if a neuron is stimulated in a repeated and prolonged fashion, for example by constant sensory stimulation or artificially by applying an electric current, it first shows a strong onset response, followed by an increase in the time between spikes. Hence the spike rate attenuates and the so-called spike frequency adaptation takes place. Experimental data from the Allen Institute show that [^11] a substantial fraction of excitatory neurons of the neocortex, ranging from 20% in the mouse visual cortex to 40% in the human frontal lobe, exhibit SFA as shown in Fig. [2](#Fig2) a, b. There can be different causes for SFA: *First*, short-term depression of the synapse through depletion of the synaptic vesicle pool. This means that at the connection site between neurons, the signal from the pre-synaptic neuron cannot be transmitted to the next neuron. *Second*, by an increase in the spiking threshold of the post-synaptic neuron due to the activation of potassium channels by calcium, which has a subtractive effect on the input current. Hence, the same input current that previously caused a spike does not lead to a spike anymore. *Third*, lateral and feedback inhibition in the local network reduces the effect of excitatory inputs in a delayed fashion [^14]. Therefore, like in the second case, spike generation is hampered.

![Fig. 2](https://cdn.ncbi.nlm.nih.gov/pmc/blobs/ed99/11053160/7b6f94addcc7/44172_2024_165_Fig2_HTML.jpg)

Biological neurons show SFA after prolonged stimulation. The response of two sample neurons from the Allen brain cell database 32 against a 1 s long step current is shown. Both neurons show SFA seen as an increase in the ISI. a Neuron from human temporal lobe (cell 601950719, sweep 44); b Neuron from mouse visual cortex (cell 595511209, sweep 33). c LIF, and d Adaptive LIF receiving an input Poisson spike train for 150 ms. Plot of membrane potential, u ( t ), and corresponding threshold potential, v th are shown. The equations for LIF and ALIF are Eqs. ( 2 ) and ( 5 ). Parameters used in the adaptive threshold model shown (Eq. ( )):, θ 0 = 7 mV, and τ = 100 ms. LIF leaky integrate and fire, ALIF adaptive threshold leaky integrate and fire.

Based on the biological description a large variety of spiking neuron models has been proposed in the literature, which implement SFA in different ways.

### Advantages of spike frequency adaptation

From a biological standpoint, multiple advantages of the SFA mechanism have been observed. First, it lowers the metabolic costs, by facilitating sparse coding [^15]: When there is no significant information in the presented inputs, as the input is either being repeated or there is a high-intensity constant stimulant, the firing rate is decreased leading to a reduction in metabolic cost and hence power consumption. Moreover, the separation of high-frequency signals from noisy environments is facilitated by SFA [^16]. In addition, SFA can be seen as a simple form of short-term memory on the single-cell level [^17].

In other words, SFA improves the efficiency [^18] and accuracy of the neural code and hence optimizes information transmission [^19]. SFA can be seen as an adaptation of the spike output range to the statistical range of the environment, meaning that it contrasts fluctuations of the input rather than its absolute intensity [^20]. Thereby noise is reduced and, as mentioned above, repetitive information is suppressed which leads to an increase in entropy. Consequently, the detection of a salient stimulus can be enhanced [^21]. These biological advantages of SFA can also be exploited for low-power and high-entropy computations in artificial neural networks.

To introduce SFA in spiking neural networks, a neuron model can be used which includes an adaptive threshold property [^22]. SSNs with these kinds of neurons learn quickly, even without synaptic plasticity [^23]. Moreover, SFA helps in attaining higher computational efficiency in SNNs [^11]. For example, to achieve a store-and-recall cycle (working memory) of duration 1200 ms, a single exponential adaptive model requires a decay constant, *τ* <sub>a</sub>  = 1200 ms in ref. [^11], while a double exponential adaptive threshold model requires decay constants of *τ* <sub>a1</sub>  = 30 ms and *τ* <sub>a2</sub>  = 300 ms [^13] —the latter being more efficient and sophisticated with four adaptation parameters compared to two parameters in ref. [^11].

A comparison between baseline LIF behavior vs. SFA behavior through an adaptive LIF model is shown in Fig. [2](#Fig2) c, d. In order to mimic constant current stimulation in the spiking domain, a high-frequency Poisson spike train (*f*  = 1000 Hz of 150 ms duration, i.e. a spike is available at every time-step, *d* *t*) is applied to both LIF and adaptive LIF models. It can be observed that the LIF model produces 14 spikes, compared to 9 spikes for the adaptive model in the observed 150 ms time bin, leading to less spike handling operation in subsequent network layers. Moreover, the LIF model generates a spike train at a constant ISI of 11 ms, whereas SFA is observed in the spike train generated from the ALIF model. An ISI of 13 ms is observed for the first spike, and a non-decreasing ISI is observed further. Continuous adaptation of threshold voltage with every output spike for the ALIF model compared to the fixed threshold voltage for the LIF model leads to this SFA behavior.

In refs.,,[^11], authors showed that SFA is also crucial for computation through spiking neurons. This function is particularly instrumental in overcoming the vanishing gradient problem in liquid state machines and RSNNs through the employment of an adaptive threshold, which serves as the source of SFA, within the gradient calculation process. Furthermore, the studies provided evidence that SNNs equipped with SFA neurons are capable of achieving accuracy levels comparable to those found in artificial neural networks using long short-term memory networks.

Furthermore, the memory bottleneck in neural computation must be carefully considered, as memory access often consumes more time than computation itself, according to Wulf and McKee [^24]. Within this context, the role of SFA becomes pertinent. Due to SFA, there is a decrease in spike frequency, leading to a corresponding reduction in the number of synaptic memory accesses, which are contingent on a pre-synaptic spike from the preceding layer. When compared to LIF models, this reduction in spikes has the potential to decrease computational efficiency. Further studies, as referenced in refs.,,[^13], demonstrates that the benefits of SFA allow for a reduction in the number of neurons required to achieve similar accuracy in various spatio-temporal tasks. This reduction contributes to a decrease in both the area and energy footprint for the corresponding application.

## Description of adaptive neuron models

In this review paper, we have considered adaptive models based on the premise of the LIF framework. LIF models are popular in SNNs due to their simplicity, computational efficiency, and ability to capture some essential aspects of temporal character. Their simplicity makes LIF models amenable to theoretical analysis, which enables studying fundamental properties of SNNs, such as stability, dynamics, and network analysis. It is important to note that LIF models have their advantages but are still simplified abstractions of real biological neurons. An essential feature of a neuron missing in LIF is *spike frequency adaptation*.

Adaptive LIF models encompass all benefits of a LIF model and use a dynamic threshold that changes based on the neuron’s recent activity. This mechanism can lead to more sophisticated information processing, as the neuron’s sensitivity to input can be modulated by its recent firing history. With a more complex adaptation mechanism, the model attains higher efficiency with less iteration,,[^10]. ALIF can replicate the phenomenon of SFA, where neurons become less responsive to repeated input spikes over time. This feature allows SNNs to capture more nuanced response patterns and better represent certain types of neural processing, increasing the computational efficiency as proven in the paper,,[^10]. ALIF models can be easily combined with synaptic plasticity rules to study learning and memory processes in SNN. The adaptive behavior of these models allows for a more realistic exploration of synaptic strength changes and their impact on network function. ALIF models can also be implemented on neuromorphic hardware platforms, taking advantage of their more biologically plausible nature.

### Leaky integrate and fire model

As already mentioned, LIF models are popularly used to mimic the spiking behavior of a neuron. The evolution of membrane potential, *u* (*t*) in an LIF model can be written as,[^7]

|  | 1 |
| --- | --- |

where *τ* is the “leaky" time constant of the membrane, *R* is the membrane resistance, *I* (*t*) is the injected current, and *v* <sub>rest</sub> is the resting potential of the cell. In discrete time for spiking input Eq. ([1](#Equ1)) may be written as

|  | 2 |
| --- | --- |

In SNN applications, *R* is assumed to be unity and

|  | 3 |
| --- | --- |

where *w* <sub><em>i</em></sub> is the synaptic weight between target neuron and *i* th pre-synaptic neuron and *x* <sub><em>i</em></sub> (*δ* <sub><em>i</em></sub>) corresponding spiking input to the *i* th pre-synaptic neuron. When membrane potential, *u* (*t*) at *t*  =  *t* <sup>(<em>f</em>)</sup> crosses a predefined fixed threshold, , a spike is generated i.e.

|  | 4 |
| --- | --- |

### Adaptive LIF

In adaptive LIF, a time-dependent function *θ* (*t*) is added to the fixed threshold, after every spike causing an adaptation of the threshold. The threshold potential, *v* <sub>th</sub> (*t*), gradually returns to its steady state value depending on threshold adaptation time constant *τ* <sub><em>θ</em></sub>. The expression for adaptive threshold is thus given as [^7]

|  | 5 |
| --- | --- |

where the function *θ* (*t*) is

|  | 6 |
| --- | --- |

when membrane potential, *u* (*t*) reaches a threshold, it is reset to *v* <sub>rest</sub>

|  | 7 |
| --- | --- |

### Double EXponential Adaptive Threshold (DEXAT)

A Double EXponential Adaptive Threshold (DEXAT) neuron model has been proposed by Shaban et al.[^13]. The authors demonstrated that the proposed DEXAT model provides higher accuracy, faster convergence, and flexible long short-term memory (working memory in neuroscience terms) compared to existing counter parts in the literature.

The membrane potential dynamics are described through Eq. ([1](#Equ1)). The threshold adaptation rule is given by the following set of equations:

|  | 8 |
| --- | --- |

|  | 9 |
| --- | --- |

|  | 10 |
| --- | --- |

where and control the evolution of adaptive threshold with time, where *τ* <sub><em>b</em> 1</sub> and *τ* <sub><em>b</em> 2</sub> are threshold adaptation time constants and *β* <sub>1</sub> and *β* <sub>2</sub> are two scaling factors (*β* <sub>1</sub>, *β* <sub>2</sub>  > 0). For each spike *z* <sub><em>j</em></sub> (*t*), threshold potential increases by .

### Multi-time scale adaptive threshold

In this model, the behavior of the membrane potential is governed by Eq. ([1](#Equ1)) as well. The threshold potential is also increased from its present value whenever a spike is generated. The threshold gradually decays to the resting potential, *v* <sub>rest</sub> depending on the decay time constants. The rule for threshold update [^29] is given below:

|  | 11 |
| --- | --- |

where *t* <sub><em>i</em></sub> is the *i* th spike time. The form of *H* (*t*) is described as

|  | 12 |
| --- | --- |

where *L* is the number of threshold time constants, *τ* <sub><em>j</em></sub> is *j* th time constant (*j*  = 1, 2, …, *L*) and *α* <sub><em>j</em></sub> is the weight of the *j* th time constant.

### Adaptive Exponential (AdEx) LIF

Adaptive exponential LIF model involves two state parameters, membrane potential, *u* (*t*) and adaptation variables *w* <sub><em>k</em></sub> to explain various spiking dynamics,[^7]. The evolution of *u* (*t*) and *w* <sub><em>k</em></sub> are described by the following equations:

|  | 13 |
| --- | --- |

|  | 14 |
| --- | --- |

A popular choice of *f* (*u*) is mentioned in ref. [^7]

|  | 15 |
| --- | --- |

where Δ <sub><em>T</em></sub> is the sharpness parameter, *v* <sub>th</sub> threshold potential, *w* <sub><em>k</em></sub> adaptation current, *a* <sub><em>k</em></sub> adaptation parameter, *b* <sub><em>k</em></sub> amount by which adaptation current increases after threshold.

### Spike response model

The spike response model (SRM) is a generalization of the leaky integrate-and-fire model [^7]. In contrast to the LIF model, SRM includes refractoriness behavior in the model equation itself. While the membrane potential of an integrate-and-fire model is described using coupled differential equations, SRM is formulated using filters.

The membrane potential, *u* (*t*), in the presence of an external current, *I* (*t*), is given below as mentioned in refs.,[^7]

|  | 16 |
| --- | --- |

Here, the function, *k* (*t*), describes the filter of the voltage response to a current pulse. Input current *I* (*t*) is filtered with a filter *k* (*t*) and produces corresponding input potential . A spike occurs when the membrane potential, *u* (*t*), reaches the threshold *v* <sub>th</sub> (*t*). The membrane potential after a spike is described by a function *η* (*t*). The function, *η* (*t*) models the refractory behavior after a spike. The set *F* is a collection of all spike times before *t* and is defined as

|  | 17 |
| --- | --- |

The threshold for a spike generation in SRM is not fixed and is time-dependent, denoted by *v* <sub>th</sub> (*t*). A spike is generated when the membrane potential, *u* (*t*) crosses the dynamic threshold *v* <sub>th</sub> (*t*). The expression of spike time *t* <sup>(<em>f</em>)</sup> is given as

|  | 18 |
| --- | --- |

A standard model of the dynamic threshold is

|  | 19 |
| --- | --- |

Here, is the threshold in the absence of spiking for a long duration. The threshold potential is increased by the function *θ* (*t*) after each output spike for *t* <sup>(<em>f</em>)</sup>  <  *t*.

In SRM, when the input is a spike train, the equation for membrane potential *u* (*t*) is modified as:

|  | 20 |
| --- | --- |

where *w* <sub><em>j</em></sub> is the weight of the synapse connected to the target post-synaptic neuron through *j* th pre-synaptic neuron. *F* <sub><em>j</em></sub> is the set of all spike times of *j* th pre-synaptic neuron. The spike time of *g* <sub>th</sub> spike from *j* th pre-synaptic neuron is denoted by . The function *ε* (*t*) denotes spike response function.

### Generalized LIF (GLIF)

Researchers of the Allen Institute for Brain Science proposed five Generalized Leaky Integrate and Fire (GLIF) models by updating the baseline LIF model [^31]. Three primary factors that have been considered while updating the baseline LIF model are: (i) membrane and threshold potential reset rule after a spike, (ii) slow affecting current from Na <sup>+</sup> and K <sup>+</sup> channels which have been activated during a spiking phenomenon, (iii) changes in threshold potential caused by sub-threshold potential and spikes [^32]. Five GLIF models are found in the literature, namely GLIF-I to GLIF-V. The details of the five GLIF models are as follows:

#### GLIF-I

Basic LIF model as described in the section ”Leaky integrate and fire model ”.

#### GLIF-II

GLIF-II incorporates biologically reset rule on top of the GLIF-I. The equation for spike-induced threshold is

|  | 21 |
| --- | --- |

When membrane potential *u* (*t*) ≥  *v* <sub>th</sub>  +  *θ* <sub>s</sub>, it resets to

|  | 22 |
| --- | --- |

where *f* <sub>v</sub> is the multiplicative coefficient and a threshold component *δ* *θ* <sub>s</sub> has been added after every spike to *θ* <sub>s</sub> (*t*).

#### GLIF-III

Slow fluctuating currents for the activated Na <sup>+</sup> and K <sup>+</sup> ion channels for a spike have been included in GLIF-III. These current components are modeled below as described in refs.,[^31]:

|  | 23 |
| --- | --- |

Like GLIF II, if *u* (*t*) ≥  *v* <sub>th</sub>, the membrane potential *u* (*t*) is reset to *v* <sub>r</sub> and current components *I* <sub><em>j</em></sub> (*t*) are updated as

|  | 24 |
| --- | --- |

where *k* <sub><em>j</em></sub>, *R* <sub><em>j</em></sub>, and *A* <sub><em>j</em></sub> are post-spike current time constant, a multiplicative constant (typically *R* <sub><em>j</em></sub>  = 1) and after-spike current amplitude, respectively.

#### GLIF-IV

It combines both GLIF-II and GLIF-III models. It has both biologically defined reset, after spike current components and a spike induced threshold potential,[^31].

#### GLIF-V

Along with after-spike currents *I* <sub><em>j</em></sub> (*t*)−s, and spike-induced threshold component *θ* <sub>s</sub> (*t*), a sub-threshold potential-induced threshold variable *θ* <sub>u</sub> (*t*) is defined in GLIF-V. The model has four state parameters viz. *u* (*t*), *I* <sub><em>j</em></sub> (*t*), *θ* <sub>s</sub> (*t*) and *θ* <sub>v</sub> (*t*),[^31]. When *u* (*t*) ≥  *θ* <sub>v</sub>  +  *θ* <sub>s</sub>, a spike is generated and state variables are updated following the reset rule described below:

|  | 25 |
| --- | --- |

where *a* and *b* <sub>u</sub> are adaptation index of sub-threshold potential dependent threshold component and sub-threshold potential-induced threshold time constant.

The computational complexity of the available neuron models reported in the literature is calculated in terms of the number of arithmetic operations (number of arithmetic additions and multiplications) required in an iteration. A summary of the computational complexity of the adaptive spiking neuron models is reported in Table [1](#Tab1).

##### Table 1.

Summary of a selection of adaptive neuron models based on computational complexity

<table><thead><tr><th colspan="1" rowspan="1">Model</th><th colspan="1" rowspan="1">Membrane potential equation</th><th colspan="1" rowspan="1">Adaptive threshold equation</th><th colspan="1" rowspan="1">Number of arithmetic operations required per iteration</th></tr></thead><tbody><tr><td colspan="1" rowspan="1">LIF</td><td colspan="1" rowspan="1"></td><td colspan="1" rowspan="1">fixed threshold</td><td colspan="1" rowspan="1">10</td></tr><tr><td colspan="1" rowspan="1">Adaptive LIF</td><td colspan="1" rowspan="1"></td><td colspan="1" rowspan="1"></td><td colspan="1" rowspan="1">6 <em>F</em>  + 10</td></tr><tr><td colspan="1" rowspan="1">DEXAT</td><td colspan="1" rowspan="1"></td><td colspan="1" rowspan="1"> +  <em>β</em> <sub>2</sub> <em>b</em> <sub><em>j</em> 2</sub> (<em>t</em>)</td><td colspan="1" rowspan="1">29</td></tr><tr><td colspan="1" rowspan="1">Multi-scale adaptive threshold</td><td colspan="1" rowspan="1"></td><td colspan="1" rowspan="1"><em>v</em> <sub>th</sub> (<em>t</em>) = ∑ <sub><em>i</em></sub> <em>H</em> (<em>t</em> − <em>t</em> <sub><em>i</em></sub>) +  <em>v</em> <sub>rest</sub></td><td colspan="1" rowspan="1">5 <em>L</em> <em>F</em>  + 10</td></tr><tr><td colspan="1" rowspan="1">SRM</td><td colspan="1" rowspan="1"><em>u</em> (<em>t</em>) = ∑ <sub><em>f</em> ∈ <em>F</em></sub> <em>η</em> (<em>t</em>  −  <em>t</em> <sup>(<em>f</em>)</sup>)</td><td colspan="1" rowspan="1"><em>u</em> (<em>t</em>) = ∑ <sub><em>f</em> ∈ <em>F</em></sub> <em>η</em> (<em>t</em>  −  <em>t</em> <sup>(<em>f</em>)</sup>) +  <em>v</em> <sub>rest</sub></td><td colspan="1" rowspan="1">2 <em>N</em> <em>F</em>  + 8 <em>F</em> <sub><em>p</em></sub> <em>N</em></td></tr><tr><td colspan="1" rowspan="1">Adaptive Exponential Model</td><td colspan="1" rowspan="1">− <em>R</em> ∑ <em>w</em> <sub><em>k</em></sub>  +  <em>R</em> <em>I</em> (<em>t</em>)</td><td colspan="1" rowspan="1"></td><td colspan="1" rowspan="1">2 <em>N</em> <sub>ad</sub> <em>F</em>  + 7 <em>N</em> <sub>ad</sub>  + 13</td></tr><tr><td colspan="1" rowspan="1">GLIF I</td><td colspan="1" rowspan="1"></td><td colspan="1" rowspan="1">fixed threshold</td><td colspan="1" rowspan="1">10</td></tr><tr><td colspan="1" rowspan="1">GLIF II</td><td colspan="1" rowspan="1"></td><td colspan="1" rowspan="1"></td><td colspan="1" rowspan="1">13</td></tr><tr><td colspan="1" rowspan="1">GLIF III</td><td colspan="1" rowspan="1"></td><td colspan="1" rowspan="1"><em>j</em>  = 1, 2, …, <em>N</em></td><td colspan="1" rowspan="1">4 <em>N</em> <sub>ad</sub>  + 10</td></tr><tr><td colspan="1" rowspan="1">GLIF IV</td><td colspan="1" rowspan="1"></td><td colspan="1" rowspan="1"><em>I</em> <sub><em>j</em></sub> (<em>t</em> <sub>+</sub>) =  <em>R</em> <sub><em>j</em></sub> <em>I</em> <sub><em>j</em></sub> (<em>t</em> <sub>−</sub>) +  <em>A</em> <sub><em>j</em></sub></td><td colspan="1" rowspan="1">4 <em>N</em> <sub>ad</sub>  + 14</td></tr><tr><td colspan="1" rowspan="1">GLIF V</td><td colspan="1" rowspan="1"></td><td colspan="1" rowspan="1"><em>I</em> <sub><em>j</em></sub> (<em>t</em> <sub>+</sub>) =  <em>R</em> <sub><em>j</em></sub> <em>I</em> <sub><em>j</em></sub> (<em>t</em> <sub>−</sub>) +  <em>A</em> <sub><em>j</em></sub></td><td colspan="1" rowspan="1">4 <em>N</em> <sub>ad</sub>  + 24</td></tr></tbody></table>

[Open in a new tab](https://pmc.ncbi.nlm.nih.gov/articles/PMC11053160/table/Tab1/)

*N* is the number of pre-synaptic neurons connected to the target neuron, *L* is the number of the exponential kernels used to approximate threshold potential, *N* <sub><em>a</em> <em>d</em></sub> is the number of adaptation variables used in the model equation, *F* and *F* <sub>p</sub> are the number of spikes generated in the target neuron and connected pre-synaptic neuron respectively.

While the number of arithmetic operations per iteration required is often used as a proxy for computational complexity, it’s essential to recognize that it doesn’t linearly correlate with power consumption. Energy efficiency depends on various factors, including hardware design, memory access patterns, and algorithmic optimizations.

## State-of-the-art case studies with ALIF in SNN

In this section, we will discuss a selection of applications that use the aforementioned adaptive neuron models.

The GLIF-II model has been used in refs. – [^9] to implement STORE-RECALL, video recognition, image classification, delayed XOR, and cognitive computational tasks. The property of SFA through the ALIF model is exploited in the above works. On the Google speech data-set, delayed XOR, and cognitive computation task 12 *A* *X*, authors in ref. [^11] have achieved an accuracy of 90.88 ± 0.22%, 95.19 ± 0.014%, and 92.89% respectively. In ref. [^9], an accuracy of 93.7% on SMNIST and 66.7% on speech recognition (TIMIT data-set) have been obtained. Bellec et al.[^10] have performed a STORE-RECALL task of 1200 ms with a classification rate of 95% in 50 iterations.

The learning algorithm used in refs.,[^9] BPTT. A learning algorithm, called e-prop for RSNNs, which is an alternative to BPTT is proposed in ref. [^10].

Multiple spatio-temporal applications were shown in [^13] using DEXAT neuron model. One of the simplest benchmarks was done through STORE and RECALL task, where working memory is considered as the time gap between STORE and RECALL instructions. An LSNN consisting of 10 LIF and 10 DEXAT neurons was used for the task. The network was trained for 200 ms with a minimum desired decision error of 0.05. The results indicate that to achieve a working memory of 1200 ms, *τ* <sub><em>b</em> 1</sub> and *τ* <sub><em>b</em> 2</sub> need to be 30 and 300 ms, respectively. However, increasing *τ* <sub><em>b</em> 2</sub> to 500 ms led to an even faster convergence of the LSNN network for the same working memory. Compared to the working memory value with the DEXAT model, these values of *τ* <sub><em>b</em> 1</sub> and *τ* <sub><em>b</em> 2</sub> are much smaller. However, in ref. [^11] the value of single threshold adaptation time constant *τ* <sub><em>b</em></sub> is comparable to working memory, which is a clear disadvantage compared to the model [^13].

A system-level simulation of LSNN with DEXAT reported classification accuracy of 96.1% on sequential MNIST (SMNIST) i.e. converging in 30% fewer epochs to a higher accuracy. Further, they evaluated a spatio-temporal voice recognition application using the Google Speech Command (GSC) dataset. They had achieved a 91% accuracy using a single hidden recurrent layer.

Using two hidden layers of GLIF-II and varying adaptation time values for each layer,[^34] demonstrated an accuracy of 92.1% on the GSC data set. In addition, the study shows the usefulness of adaptive neurons for tasks with an inherent temporal dimension, such as the categorization of ECG wave patterns (accuracy 85.9%) and gesture recognition using a radar spectrogram.

Wade et al. [^35] used a variant of adaptive LIF (Eq. ([5](#Equ5))) for classification tasks. A supervised learning algorithm called *Synaptic Weight Association Training* (SWAT), a variant of STDP, is used here. It provides a classification accuracy of 95.3%, 96.7%, and 95.25% for Iris, Wisconsin Breast Cancer, and TI46 speech corpus data-sets, respectively. The membrane potential dynamics of the model used here are governed by Eq. ([1](#Equ1)).

An SNN-based computing paradigm has been proposed to provide immunity from device variations for memristive nanodevices in ref. [^36]. The neuron model used in this paper is LIF in nature. A dynamic threshold is designed through homeostasis. The adaptive threshold and lateral inhibition help a specific group of neurons to respond to a particular stimulus [^36]. The network is tested on the MNIST data-set. It achieves a maximum of 93.5% accuracy with 300 output neurons. A system-level simulation shows that the designed device can tolerate parameter variation up to 50% of the standard deviation of parameter values.

In [^37], Diehl et al. created An SNN with an ALIF model for digit recognition on the MNIST benchmark. The model is a synaptic conductance-based LIF and an adaptive threshold has been implemented following Eq. ([5](#Equ5)). The average classification accuracies on the MNIST data-set of 82.9%, 87%, 91.9%, and 95% have been achieved by the model of 100, 400, 1600, and 6400 neurons, respectively.

Recently, Jiang et al.[^38] demonstrated the use of adaptive neurons for arrhythmia detection on edge devices with a non-recurrent SNN. In [^39], authors have shown the potential of adaptive neurons used on event-based sensor data for unsupervised optical flow estimation. Encoding international morse code was demonstrated by adjusting the threshold of neurons adaptively in an SNN through reinforcement learning [^40]. In ref. [^11], authors have shown that SFA can help in efficient network computations for temporally dispersed data. Using the same neuron model in ref. [^41] a sparse RSNN, based on ALIF was used successfully to extract relations between words and sentences in a text in order to answer questions about the text. Apart from the adaptive neuron models discussed in the section “Description of adaptive neuron models”, a few additional adaptive neuron models have been explored in the literature. Details of those models and associated applications are highlighted below.

In ref. [^42], author proposed an adaptive threshold module (ATM) for An SNN based architecture. ATM algorithm controls internal threshold potential. This ATM is used to control output firing rate, which helps to to extract the information encoded in input stimulus. The model is validated on speech TIDIGITS and RWCP data-sets.

The model is tested against Poisson spike trains for various frequencies and lengths, TIDIGITS Speech and RWCP data-sets. For a Poisson spike train of 300 Hz with 4000 patterns, ATM model with two-phase classifier shows an accuracy of 96.1%. The accuracy for TIDIGITS and RWCP data-sets are 99.5% and 97.64%, respectively.

Another variant of ALIF has been proposed in ref. [^43] and has been implemented on feed-forward SNN using STDP. The model is validated through MNIST data-set. The maximum achieved classification accuracy with MNIST data-set is 82%.

The selected works presented in this section are summarized in Table- [2](#Tab2).

### Table 2.

Summary of the selected works using adaptive neuron models

<table><thead><tr><th colspan="1" rowspan="1">Work</th><th colspan="1" rowspan="1">Neuron model</th><th colspan="1" rowspan="1">Adaptation equation</th><th colspan="1" rowspan="1">Learning rule</th><th colspan="1" rowspan="1">Performance</th></tr></thead><tbody><tr><td colspan="1" rowspan="1">Wade et al. <sup><a href="#fn:35">35</a></sup></td><td colspan="1" rowspan="1">Adaptive LIF</td><td colspan="1" rowspan="1"></td><td colspan="1" rowspan="1">BCM rule with STDP</td><td colspan="1" rowspan="1">95.3% on Iris, 96.7% for Wisconsin data-sets, 95.25% for TI46 speech corpus</td></tr><tr><td colspan="1" rowspan="1">Querlioz et al. <sup><a href="#fn:36">36</a></sup></td><td colspan="1" rowspan="1">LIF and homeostasis</td><td colspan="1" rowspan="1"></td><td colspan="1" rowspan="1">Customized STDP</td><td colspan="1" rowspan="1">93.5% on MNIST dataset</td></tr><tr><td colspan="1" rowspan="1">Amin <sup><a href="#fn:42">42</a></sup></td><td colspan="1" rowspan="1">Modified SRM</td><td colspan="1" rowspan="1"> +  <em>v</em> <sub><em>t</em> <em>h</em></sub> (<em>t</em> <sub><em>i</em> −1</sub>)</td><td colspan="1" rowspan="1">Local Learning Rule <em>w</em> <sub><em>i</em></sub>  =  <em>β</em> <sub>1</sub> <em>t</em> <sub><em>i</em></sub> or</td><td colspan="1" rowspan="1">96.1% Poisson spike train, 99.5% for TIDIGITS data set, 97.64% for RWCP data set</td></tr><tr><td colspan="1" rowspan="1">Liu et al. <sup><a href="#fn:43">43</a></sup></td><td colspan="1" rowspan="1">Adaptive LIF</td><td colspan="1" rowspan="1"></td><td colspan="1" rowspan="1">STDP</td><td colspan="1" rowspan="1">82% on MNIST data-set</td></tr><tr><td colspan="1" rowspan="1">Diehl et al. <sup><a href="#fn:37">37</a></sup></td><td colspan="1" rowspan="1">LIF and homeostasis</td><td colspan="1" rowspan="1"> + ∑ <sub><em>f</em></sub> <em>θ</em> <sub>0</sub></td><td colspan="1" rowspan="1">STDP with pre and post-synaptic traces</td><td colspan="1" rowspan="1">95% on MNIST data-set</td></tr><tr><td colspan="1" rowspan="1">Salaj et al. <sup><a href="#fn:11">11</a></sup> Bellec et al.,<sup><a href="#fn:9">9</a></sup></td><td colspan="1" rowspan="1">Adaptive LIF</td><td colspan="1" rowspan="1"><em>A</em> <sub><em>j</em></sub> (<em>t</em>) =  <em>v</em> <sub>th</sub>  +  <em>β</em> <em>a</em> <sub><em>j</em></sub> (<em>t</em>), <em>a</em> <sub><em>j</em></sub> (<em>t</em>  +  <em>δ</em> <em>t</em>) =  <em>ρ</em> <sub><em>j</em></sub> <em>a</em> <sub><em>j</em></sub> (<em>t</em>) + (1− <em>ρ</em> <sub><em>j</em></sub>) <em>z</em> <sub><em>j</em></sub> (<em>t</em>) <em>δ</em> (<em>t</em>)</td><td colspan="1" rowspan="1">BPTT,<sup><a href="#fn:9">9</a></sup>, E-PROP <sup><a href="#fn:10">10</a></sup></td><td colspan="1" rowspan="1"><sup><a href="#fn:11">11</a></sup> 90.88 ± 0.22% on Google speech data-set 95.19 ± 0.014% on Delayed XOR 92.89% on Cognitive computation task 12 <em>A</em> <em>X</em> <sup><a href="#fn:9">9</a></sup> 93.7% on SMNIST 66.8% on speech recognition (TIMIT data-set) <sup><a href="#fn:10">10</a></sup> STORE-RECALL task of 1200 ms with classification rate of 95%</td></tr><tr><td colspan="1" rowspan="1">Shaban et al. <sup><a href="#fn:13">13</a></sup></td><td colspan="1" rowspan="1">DEXAT</td><td colspan="1" rowspan="1"> +  <em>β</em> <sub>2</sub> <em>b</em> <sub><em>j</em> 2</sub> (<em>t</em>)</td><td colspan="1" rowspan="1">BPTT</td><td colspan="1" rowspan="1">Working memory of 1200 ms, For <em>τ</em> <sub><em>b</em> 1</sub>  = 30 ms and <em>τ</em> <sub><em>b</em> 2</sub>  = 300 ms. 96.1% on SMNIST, 91% on GSC data set</td></tr><tr><td colspan="1" rowspan="1">Yin et al. <sup><a href="#fn:34">34</a></sup></td><td colspan="1" rowspan="1">Adaptive LIF</td><td colspan="1" rowspan="1"><em>η</em> <sub><em>t</em></sub>  =  <em>ρ</em> <em>η</em> <sub><em>t</em> −1</sub>  + (1− <em>ρ</em>) <em>S</em> <sub><em>t</em> −1</sub>, <em>v</em> <sub>th</sub>  =  <em>b</em> <sub>0</sub>  +  <em>β</em> <em>η</em> <sub><em>t</em></sub></td><td colspan="1" rowspan="1">BPPT, Surrogate-Gradient, and Multi-Gaussian</td><td colspan="1" rowspan="1">Multiple performances on various datasets</td></tr><tr><td colspan="1" rowspan="1">Vallés et al. <sup><a href="#fn:39">39</a></sup></td><td colspan="1" rowspan="1">LIF and homeostasis</td><td colspan="1" rowspan="1"></td><td colspan="1" rowspan="1">STDP</td><td colspan="1" rowspan="1">-</td></tr><tr><td colspan="1" rowspan="1">Rao et al <sup><a href="#fn:41">41</a></sup></td><td colspan="1" rowspan="1">LIF and after hyper-polarizing currents</td><td colspan="1" rowspan="1"><em>i</em> <sub>AHP,<em>j</em></sub> [<em>t</em>  + Δ <em>t</em>] =  <em>α</em> <sub>AHP</sub> <em>i</em> <sub>AHP,<em>j</em></sub> [<em>t</em>]− <em>β</em> <em>z</em> <sub><em>j</em></sub> [<em>t</em>]</td><td colspan="1" rowspan="1">Surrogate gradient (BPTT)</td><td colspan="1" rowspan="1">96.09% on SMNIST</td></tr></tbody></table>

[Open in a new tab](https://pmc.ncbi.nlm.nih.gov/articles/PMC11053160/table/Tab2/)

Further, a comparison of the neuron models listed in Table [2](#Tab2) in terms of flop counts is provided in Table [3](#Tab3).

### Table 3.

<table><thead><tr><th colspan="1" rowspan="1">Model</th><th colspan="1" rowspan="1">Number of arithmetic operations required per Iteration</th></tr></thead><tbody><tr><td colspan="1" rowspan="1">LIF</td><td colspan="1" rowspan="1">2 <em>N</em>  + 6</td></tr><tr><td colspan="1" rowspan="1">Wade et al.<sup><a href="#fn:35">35</a></sup></td><td colspan="1" rowspan="1">2 <em>N</em>  + 12</td></tr><tr><td colspan="1" rowspan="1">Querlioz et al.<sup><a href="#fn:36">36</a></sup></td><td colspan="1" rowspan="1">2 <em>N</em>  + 11</td></tr><tr><td colspan="1" rowspan="1">Amin <sup><a href="#fn:42">42</a></sup></td><td colspan="1" rowspan="1">4 <em>N</em>  + 4</td></tr><tr><td colspan="1" rowspan="1">Liu et al.<sup><a href="#fn:43">43</a></sup></td><td colspan="1" rowspan="1">8 <em>NF</em>  + 12</td></tr><tr><td colspan="1" rowspan="1">Diehl et al.<sup><a href="#fn:37">37</a></sup></td><td colspan="1" rowspan="1">6 <em>F</em>  + 22</td></tr><tr><td colspan="1" rowspan="1">Salaj et al.<sup><a href="#fn:11">11</a></sup> Bellec et al.,<sup><a href="#fn:9">9</a></sup></td><td colspan="1" rowspan="1">2 <em>N</em>  + 17</td></tr><tr><td colspan="1" rowspan="1">Shaban et al.<sup><a href="#fn:13">13</a></sup></td><td colspan="1" rowspan="1">2 <em>N</em>  + 25</td></tr><tr><td colspan="1" rowspan="1">Yin et al.<sup><a href="#fn:34">34</a></sup></td><td colspan="1" rowspan="1">2 <em>N</em>  + 18</td></tr><tr><td colspan="1" rowspan="1">Vallés et al.<sup><a href="#fn:39">39</a></sup></td><td colspan="1" rowspan="1">11 <em>NS</em> −1</td></tr><tr><td colspan="1" rowspan="1">Rao et al.<sup><a href="#fn:41">41</a></sup></td><td colspan="1" rowspan="1">3 <em>N</em>  + 19</td></tr></tbody></table>

[Open in a new tab](https://pmc.ncbi.nlm.nih.gov/articles/PMC11053160/table/Tab3/)

*N* is the number of connections to the target neuron, *F* is number of spikes produced by the target neuron in an observation interval, and *S* is the number of synapses between a connected pre-synaptic neuron and the target neuron.

*Observation:* Tables [1](#Tab1) and [3](#Tab3) illustrate that the number of arithmetic operations required to implement LIF and DEXAT models is not the same. In Table [1](#Tab1), an external current injection is assumed following the traditional approach for a single isolated neuron; whereas in Table [3](#Tab3), the numbers are reported when those isolated neurons are used together to implement a spiking network, where input current is described through Eq. ([3](#Equ3)).

In the next section, we discuss hardware implementations of adaptive neurons and highlight different simulators that support adaptive neurons.

## Hardware implementations of adaptive neurons

The integration of SFA models within hardware has progressively manifested as a seminal approach to augmenting the efficiency of AI hardware, with promising applications in neuromorphic computing. Existing *Commercial Off-the-Shelf* (COTS) platforms, deploying Leaky Integrate-and-Fire (LIF) neuron blocks as fundamental units, have seen several studies for implementing SFA neurons in multicompartment neuron configurations,– [^25].

The recent developments in the field, such as the work by Bezugam et al.[^25] have proven the feasibility of achieving resource utilization with reduced neuron count. Further, Intel’s Loihi-2 architecture has ventured into adding ALIF models, heralding a promising avenue in *Non-Volatile Memory* (NVM) based hardware.

Parallel to these advancements, hardware implementations of neuron models such as Integrate and Fire (IF), LIF– [^46] and Adaptive Exponential LIF– [^48] have been widely reported, encompassing complementary metal oxide semiconductor (CMOS). Moreover, many designs have exploited emerging resistive memory technologies for such implementations, such as using RRAM [^50], PCM [^51], and CBRAM– [^52]. Recently, superconducting device, 2D material-based device neuron circuits had shown SFA,[^54].

Digital implementation of modified AdEx neuron models on FPGA further amplifies the possibilities– [^56]. Innovations such as [^58] demonstrate improvements in speed and footprint without compromising neuronal dynamics. The utilization of quantized versions of DEXAT neuron models [^13] represents another noteworthy advancement (see Fig. [3](#Fig3)). Notably, the integration of SFA within FPGA has led to the development of a pre-synaptic spike-driven architecture, which significantly reduces resource utilization and buffer size for caching events, while maintaining accurate task-solving performance [^59].

![Fig. 3](https://cdn.ncbi.nlm.nih.gov/pmc/blobs/ed99/11053160/33a1e33fbb61/44172_2024_165_Fig3_HTML.jpg)

DEXAT neuron threshold circuit (digital, NVM based) 13, AdEX 77, Mihalas-Niebur 78 analog CMOS adaptive neuron circuits. NVM non-volatile memory, SFA spike frequency adaptation.

The confluence of these developments underlines the multidimensional potential of SFA within neuromorphic hardware. The exploration of digital circuits, analog designs, and emerging NVM devices presents a diverse spectrum of opportunities and challenges. The emergence of space-efficient and low-power circuits constructed with advanced 3D integration technologies indicates the path forward.

The adoption and adaptation of SFA within neuromorphic hardware demonstrate a forward-thinking approach in both design complexity and efficiency. This integration harbors significant potential not only in optimizing resource utilization but also in paving the way for future innovations. The collaborative intersection between various technologies and methodologies emphasizes the vibrant dynamism in this field. As evidenced by recent developments, the application of SFA in hardware is not a mere theoretical prospect but a tangible trajectory that stands to redefine the next generation of neuromorphic computing.

### Simulators supporting adaptive neuron models

Various simulators support adaptive neuron models for building SNN. The function of the AdEx neuron model is based on polarizing and hyperpolarizing currents supported by PyNN [^60], BRIAN2 [^61] and NEST [^62]. Neko [^63], FABLE [^64] and Norse [^65] are SNN simulation frameworks based on PyTorch that enable the ALIF neuron model for constructing Recurrent-SNN. Here, the ALIF neuron model is a state function in which the membrane voltage and neuron threshold are updated with every iteration. More hardware-realistic neuromorphic circuit simulation is shown in [^57]. While this list encapsulates a range of simulators pivotal to SFA-based SNN simulation, it is imperative to note that the spiking neural network landscape is rich and continually expanding, with numerous other simulators also playing crucial roles in advancing this field.

Different factors, along with the adaptive neuron model, that play a vital role in accomplishing a particular task using SNN are highlighted in the next section.

## Discussion and road ahead

The preceding exploration of SFA has offered significant insights into its principles, neuron models, applications, and hardware implementations. As the field advances, the complexity and potential of SFA continue to unfold, demanding innovative approaches and broader research horizons.

In this section, as shown in Fig. [4](#Fig4) we identify remaining challenges (Fig. [4](#Fig4) a) and delineate a roadmap for future research (Fig. [4](#Fig4) b), building upon the scientific understanding cultivated herein. By synthesizing the current state of the field with a forward-looking perspective (Fig. [4c](#Fig4)), we aim to contribute a decisive and thoughtful conclusion to the ongoing discourse on SFA.

![Fig. 4](https://cdn.ncbi.nlm.nih.gov/pmc/blobs/ed99/11053160/ccb4a6bc28a9/44172_2024_165_Fig4_HTML.jpg)

The diagram unveils a the multifaceted open challenges yet to be thoroughly addressed for fully leveraging the merits of SFA, b outlines a methodological roadmap for the progressive development of SFA, and c pinpoints the promising avenues and untapped potential for future research and innovative applications.

### Challenges and roadmap

#### Encoding techniques in SFA

Traditional spike encoders such as Poisson [^37], rate-based encoding [^66], and population encoding [^11], often struggle to capture the complex dynamics inherent to SFA, potentially leading to information loss,[^18]. In the context of biological systems, neural adaptation serves as a crucial tool for calibrating sensitivity across diverse intensity gradients, illuminating the need for specialized SFA-based encoders designed to emulate these biological nuances [^68]. The issue becomes more pronounced when translating these principles into hardware systems. Here, temporal sensitivity to presynaptic spikes is elevated within SFA-based neurons; a slight misalignment in spike timing can result in considerable information loss, unlike in non-SFA neurons, where pre-synaptic spike timing allows for greater flexibility. This dilemma necessitates an exploration of dynamical encoding schemes inspired by information theory, a venture that could substantially reduce information attrition. The scant existing research into the compatibility of these encoding techniques with SFA-based neural networks further emphasizes the urgent need for novel strategies. Such innovation will not only minimize the loss of information but also expand the practical applicability of SFA in encoding, presenting a significant frontier in neural computation.

#### Learning algorithms and adaptive neurons

The deployment of learning rules and adaptive neurons in SFA presents unique challenges, despite some recent advancements. The utilization of the pseudo-gradient by Salaj et al.[^11] in BPTT and the online version of BPTT (Eprop) [^27] represents a noteworthy stride towards accommodating SFA dynamics in learning. These developments incorporate adaptive thresholds but falter when the number of layers increases significantly. With an escalation in layers, there may be fewer spikes exhibiting SFA, rendering the employment of SFA-based pseudo-gradient costly and less effective. Furthermore, many properties intrinsic to SFA, such as temporal sensitivity, adaptation to stimulus statistics, and independent firing transitions, still await integration into learning algorithms. The ALIF [^11], although aligned with certain biological properties, falls at the lower end of the biological realism spectrum. Exploration of other neuron models, with unique features complementing SFA, is needed. Additionally, higher-order spike response models (SRMs) could provide enhanced dynamics that may augment learning but require profound investigation. The search for learning rules aligned with SFAs complexities remains a challenge, necessitating innovative algorithms to optimize adaptive neuron functionality.

In the future, research in SFA-based neuron models could focus on how the different implementation options for SFA (intrinsic changes of the spiking threshold vs. inhibitory input vs. short-term synaptic plasticity), including their different time-scales, affect the coding properties of a network. Hence, investigate if some motifs are more suitable for certain computations than others. In addition, it would be interesting to investigate how adaptation propagates across layers, which would help in understanding how SFA occurring in one brain region affects the computation in its downstream regions.

#### Network architecture and connectivity

Recent studies underscore the complexity and potential advantages of integrating diverse neuron types within an RSNN [^69], reflecting the intricate interactions present in biological networks,[^11]. The introduction of sparsity into networks can lead to challenges with SFA-based neurons, as the heavily decreased input firing may conflict with the unique properties of these neurons. This raises both potential benefits and problems in terms of information processing and network efficiency. Consequently, the careful selection of the location of SFA neurons within the network becomes an essential criterion. Notably, the regularization of the firing rate of output neurons in unsupervised SNNs, such as through homeostasis as seen in the work of Diehl and Cook, highlights that even before SFA-based networks were prevalent, there were instances of support for multiple neuron types,[^36]. Exploration into graph-based Hopfield networks for combinatorial optimization offers a promising avenue, as evidenced by the recent demonstration of a thermal neuron exhibiting SFA behavior [^70]. However, this field remains largely under-researched. The challenge, therefore, lies in systematically understanding and capitalizing on the unique dynamics of SFA, considering architecture design, optimization strategies, connectivity schemes, and the nuanced interplay with sparsity.

#### Hyperparameter tuning and mathematical complexity of SFA models

The hyperparameter tuning of SFA models poses a complex problem, demanding an intricate balance between biological formalism and computational efficiency. The grid-based search methods typically employed may fall short in such complex scenarios. An exploration of advanced optimization techniques, such as Bayesian optimization or gradient-based optimization, is suggested as a possible avenue for more intelligently and efficiently navigating the parameter space specific to SFA models. Systematic ablation studies could enhance this process by elucidating the effects of individual parameters and their interactions, potentially leading to a deeper understanding of hyperparameter significance. The computational cost of implementing adaptive neurons in SFA, especially when involving higher-order synapse models like SRM, adds to the mathematical complexity. Innovative algorithmic refinement and numerical approximations tailored to SFA’s unique characteristics are proposed as potential solutions, though further research is needed to confirm their effectiveness. Developing methods that capture essential dynamics without unnecessary computational overhead, specifically aligned with the nonlinear and stochastic elements of SFA, maybe a productive direction for reducing arithmetic demands. These suggestions represent possible paths for enhancing the adaptability and efficiency of SFA models but require rigorous testing and validation to determine their actual impact and viability.

#### Integration and hardware compatibility

Implementing SFA in contemporary digital and hybrid systems poses a nuanced challenge. In prevailing COTS neuromorphic computing platforms, LIF neurons are prevalent, often symbolizing a less biologically plausible approach. Though SFA can be attained using multi-compartment LIF neurons,[^25], this methodology might hinder efficiency in certain contexts. Striking an optimal balance between speed, footprint, and neuronal dynamics is an area demanding intensive exploration. The inherent challenges with analog circuits and scalability, particularly in analog circuit-based neurons, present substantial hurdles. Techniques focused on minimizing resource consumption through pre-synaptic spike-driven architecture may warrant comprehensive investigation to align with the progressing requirements of neuromorphic computing. This can significantly decrease the memory access. It’s important to note that many state-of-the-art implementations utilize synchronous software models. However, asynchronous processing can potentially lead to further energy savings and computational advantages in SNNs. Future work may explore the integration of asynchronous mechanisms within these models to better align with biological neural systems

The advent of emerging technologies and the research in volatile resistive memory devices offer a promising frontier for the area-efficient development of adaptive neurons on analog hardware,[^71]. This approach can obviate the need for large capacitors, allowing the adjustment of time constants based on programming current, thus playing a crucial role in tuning the adaptation time constant for RSNNs.

The coming era may well witness robust advancements supporting SFA-based neurons, fostering a vibrant nexus between biological realism, technology, and emergent computational paradigms. However, the pathway is fraught with complexities related to scalability and the inherent challenges with analog circuits. The integration of these technologies may signify an essential step in enhancing the biological veracity and computational capacity of neuromorphic systems.

### Future opportunities

#### Sustainable AI acceleration through emerging NVM devices exploiting SFA

A compelling avenue for future exploration lies in the convergence of SFA and emerging NVM technologies to propel the development of next-generation, sustainable AI hardware. Notably, recent research [^13] has demonstrated that the nonlinear conductance changes intrinsic to NVM devices can be harnessed as a mechanism for threshold adaptation in SFA neurons. By capitalizing on this synergy, AI hardware can tap into the inherent adaptiveness of SFA to dynamically modulate neural responses. The programmable threshold behavior, facilitated by NVM’s non-linear conductance change, aligns seamlessly with SFA’s temporal sensitivity. This tandem approach not only enhances energy efficiency by eliminating the need for static threshold levels but also fosters inherent fault tolerance, mitigating variations in NVM devices. Furthermore, the incorporation of SFA-based NVM hybrid systems holds promise for constructing highly efficient memory and energy architectures. The adaptability of SFA can enable selective information filtering, thereby minimizing memory access and bolstering resource efficiency. NVM’s natural properties, integrated with SFA, pave the way for optimized AI accelerators that balance performance, energy consumption, and memory utilization.

#### Real-time adaptation in dynamic environments

SFA’s intrinsic ability to prevent neural saturation ensures that SNNs remain sensitive to fluctuating environments. For critical real-time applications such as autonomous vehicles and robotic systems, the incorporation of SFA may offer novel strategies for achieving both instantaneous adaptability and long-term stability. This facet of SFA could lead to groundbreaking advancements in real-time decision-making algorithms and adaptive control systems.

#### Continuous learning and temporal feature extraction

The inclusion of adaptation in neuron models through SFA introduces longer time constants that may significantly aid in learning temporal features of the input. By exploiting the extra available time scales, the network can enhance online learning convergence time and provide a more nuanced understanding of temporal dynamics. This could foster advancements in speech recognition, time-series prediction, and online learning systems, where temporal relationships are essential.

#### Enhanced robustness against adversarial attacks

Recent studies have underscored the inherent resilience of SNNs to specific adversarial perturbations– [^73]. The selective responsiveness of SFA to changes in input layers, acting as a form of firewall, could further amplify this robustness. This opens avenues to develop advanced defenses against adversarial attacks and contributes to the fortification of network security. Implementing SFA in robust models may lead to novel mechanisms to mitigate threats in cybersecurity.

#### Regularization and meta-learning

SFA’s ability to adapt to input frequency could serve as a form of regularization, potentially preventing overfitting in deep learning scenarios. In the context of meta-learning, where catastrophic forgetting is a significant concern,[^75], SFA’s adaptive thresholds may enable the network to discern underlying patterns across different tasks. This adaptation process may play a vital role in solving complex meta-learning challenges, including multi-modal learning and cross-domain adaptation, thereby aligning with advanced research directions.

The exploration of synergies between SNNs, SFA neurons, and NVM technologies presents intriguing possibilities. While still at an experimental stage, the future opportunities discussed offer a glimpse of potential pathways that could contribute to more efficient, robust, and adaptive AI systems. These innovations might shape the next phase of computational intelligence, yet their realization will depend on sustained research, collaboration, and a keen understanding of the complex interplay between these cutting-edge technologies.

## Supplementary information

[Peer Review File](https://pmc.ncbi.nlm.nih.gov/articles/instance/11053160/bin/44172_2024_165_MOESM1_ESM.pdf) <sup>(3.8MB, pdf)</sup>

## Acknowledgements

S.S.B.’s work was partially supported by the USA National Science Foundation award #2318152. E.A. was supported by the European Union’s Horizon 2020 research and innovation program under the Marie Skłodowska-Curie grant agreement No. 101031746. M.P. was supported by SNSF Starting Grant Project UNITE (TMSGI2-211461).

## Author contributions

C.G., S.S.B., S.D., M.S conceptualized the review. C.G., S.S.B. prepared the original draft, and S.S.B. lead on the manuscript revisions. E.A. enriched the content with a neuroscience perspective, authored specific segments, and participated in reviews. M.P., S.D., and M.S. provided key insights, contributed to particular subsections, and aided in manuscript refinement.

## Peer review

### Peer review information

*Communications Engineering* thanks the anonymous reviewers for their contribution to the peer review of this work. Primary Handling Editors: Miranda Vinay and Rosamund Daw. A peer review file is available.

## Competing interests

The authors declare no competing interests.

## Footnotes

**Publisher’s note** Springer Nature remains neutral with regard to jurisdictional claims in published maps and institutional affiliations.

These authors contributed equally: Chittotosh Ganguly, Sai Sukruth Bezugam.

## Supplementary information

The online version contains supplementary material available at 10.1038/s44172-024-00165-9.

## References

## Associated Data

*This section collects any data citations, data availability statements, or supplementary materials included in this article.*

[^1]: 1.Indiveri G, Liu S-C. Memory and information processing in neuromorphic systems. Proc. IEEE. 2015;103:1379–1397. doi: 10.1109/JPROC.2015.2444094. \[[DOI](https://doi.org/10.1109/JPROC.2015.2444094)\] \[[Google Scholar](https://scholar.google.com/scholar_lookup?journal=Proc.%20IEEE&title=Memory%20and%20information%20processing%20in%20neuromorphic%20systems&author=G%20Indiveri&author=S-C%20Liu&volume=103&publication_year=2015&pages=1379-1397&doi=10.1109/JPROC.2015.2444094&)\]

[^2]: 3.Furber, S. Digital neuromorphic technology—current and future prospects. *Natl Sci. Rev.*10.1093/nsr/nwad283. [https://academic.oup.com/nsr/advance-article-pdf/doi/10.1093/nsr/nwad283/52818955/nwad283.pdf](https://academic.oup.com/nsr/advance-article-pdf/doi/10.1093/nsr/nwad283/52818955/nwad283.pdf) (2023). \[[DOI](https://doi.org/10.1093/nsr/nwad283)\] \[[PMC free article](https://pmc.ncbi.nlm.nih.gov/articles/PMC10989295/)\] \[[PubMed](https://pubmed.ncbi.nlm.nih.gov/38577676/)\]

[^3]: 4.Maass W. Networks of spiking neurons: the third generation of neural network models. Neural networks. 1997;10:1659–1671. doi: 10.1016/S0893-6080(97)00011-7. \[[DOI](https://doi.org/10.1016/S0893-6080\(97\)00011-7)\] \[[Google Scholar](https://scholar.google.com/scholar_lookup?journal=Neural%20networks&title=Networks%20of%20spiking%20neurons:%20the%20third%20generation%20of%20neural%20network%20models&author=W%20Maass&volume=10&publication_year=1997&pages=1659-1671&doi=10.1016/S0893-6080\(97\)00011-7&)\]

[^4]: 5.Davies M, et al. Advancing neuromorphic computing with loihi: a survey of results and outlook. Proc. IEEE. 2021;109:911–934. doi: 10.1109/JPROC.2021.3067593. \[[DOI](https://doi.org/10.1109/JPROC.2021.3067593)\] \[[Google Scholar](https://scholar.google.com/scholar_lookup?journal=Proc.%20IEEE&title=Advancing%20neuromorphic%20computing%20with%20loihi:%20a%20survey%20of%20results%20and%20outlook&author=M%20Davies&volume=109&publication_year=2021&pages=911-934&doi=10.1109/JPROC.2021.3067593&)\]

[^5]: 6.Taherkhani A, et al. A review of learning in biologically plausible spiking neural networks. Neural Netw. 2020;122:253–272. doi: 10.1016/j.neunet.2019.09.036. \[[DOI](https://doi.org/10.1016/j.neunet.2019.09.036)\] \[[PubMed](https://pubmed.ncbi.nlm.nih.gov/31726331/)\] \[[Google Scholar](https://scholar.google.com/scholar_lookup?journal=Neural%20Netw.&title=A%20review%20of%20learning%20in%20biologically%20plausible%20spiking%20neural%20networks&author=A%20Taherkhani&volume=122&publication_year=2020&pages=253-272&pmid=31726331&doi=10.1016/j.neunet.2019.09.036&)\]

[^6]: 7.Ponulak F, Kasinski A. Introduction to spiking neural networks: information processing, learning and applications. Acta Neurobiol. Exp. 2011;71:409–433. doi: 10.55782/ane-2011-1862. \[[DOI](https://doi.org/10.55782/ane-2011-1862)\] \[[PubMed](https://pubmed.ncbi.nlm.nih.gov/22237491/)\] \[[Google Scholar](https://scholar.google.com/scholar_lookup?journal=Acta%20Neurobiol.%20Exp.&title=Introduction%20to%20spiking%20neural%20networks:%20information%20processing,%20learning%20and%20applications&author=F%20Ponulak&author=A%20Kasinski&volume=71&publication_year=2011&pages=409-433&pmid=22237491&doi=10.55782/ane-2011-1862&)\]

[^7]: 12.Gerstner, W., Kistler, W. M., Naud, R. & Paninski, L. *Neuronal Dynamics: From Single Neurons to Networks and Models of Cognition* (Cambridge University Press, 2014).

[^8]: 14.Ganguly C, Chakrabarti S. A discrete time framework for spike transfer process in a cortical neuron with asynchronous epsp, ipsp, and variable threshold. IEEE Trans. Neural Syst. Rehabil. Eng. 2020;28:772–781. doi: 10.1109/TNSRE.2020.2975203. \[[DOI](https://doi.org/10.1109/TNSRE.2020.2975203)\] \[[PubMed](https://pubmed.ncbi.nlm.nih.gov/32086215/)\] \[[Google Scholar](https://scholar.google.com/scholar_lookup?journal=IEEE%20Trans.%20Neural%20Syst.%20Rehabil.%20Eng.&title=A%20discrete%20time%20framework%20for%20spike%20transfer%20process%20in%20a%20cortical%20neuron%20with%20asynchronous%20epsp,%20ipsp,%20and%20variable%20threshold&author=C%20Ganguly&author=S%20Chakrabarti&volume=28&publication_year=2020&pages=772-781&pmid=32086215&doi=10.1109/TNSRE.2020.2975203&)\]

[^9]: 15.Bellec, G., Salaj, D., Subramoney, A., Legenstein, R. & Maass, W. Long short-term memory and learning-to-learn in networks of spiking neurons. In *Proc. 32nd International Conference on Neural Information Processing Systems*, NIPS’18, 795–805 (Curran Associates Inc., Red Hook, NY, USA, 2018). **RSNNs with SFA neurons helped in reaching accuracy in par with LSTM and also showed prospects of meta learning through SNNs**.

[^10]: 16.Bellec G, et al. A solution to the learning dilemma for recurrent networks of spiking neurons. Nat. Commun. 2020;11:3625. doi: 10.1038/s41467-020-17236-y. \[[DOI](https://doi.org/10.1038/s41467-020-17236-y)\] \[[PMC free article](https://pmc.ncbi.nlm.nih.gov/articles/PMC7367848/)\] \[[PubMed](https://pubmed.ncbi.nlm.nih.gov/32681001/)\] \[[Google Scholar](https://scholar.google.com/scholar_lookup?journal=Nat.%20Commun.&title=A%20solution%20to%20the%20learning%20dilemma%20for%20recurrent%20networks%20of%20spiking%20neurons&author=G%20Bellec&volume=11&publication_year=2020&pages=3625&pmid=32681001&doi=10.1038/s41467-020-17236-y&)\]

[^11]: 17.Salaj D, et al. Spike frequency adaptation supports network computations on temporally dispersed information. Elife. 2021;10:e65459. doi: 10.7554/eLife.65459. \[[DOI](https://doi.org/10.7554/eLife.65459)\] \[[PMC free article](https://pmc.ncbi.nlm.nih.gov/articles/PMC8313230/)\] \[[PubMed](https://pubmed.ncbi.nlm.nih.gov/34310281/)\] \[[Google Scholar](https://scholar.google.com/scholar_lookup?journal=Elife&title=Spike%20frequency%20adaptation%20supports%20network%20computations%20on%20temporally%20dispersed%20information&author=D%20Salaj&volume=10&publication_year=2021&pages=e65459&pmid=34310281&doi=10.7554/eLife.65459&)\]

[^12]: 18.Fitz H, et al. Neuronal spike-rate adaptation supports working memory in language processing. Proc. Natl Acad. Sci. USA. 2020;117:20881–20889. doi: 10.1073/pnas.2000222117. \[[DOI](https://doi.org/10.1073/pnas.2000222117)\] \[[PMC free article](https://pmc.ncbi.nlm.nih.gov/articles/PMC7456144/)\] \[[PubMed](https://pubmed.ncbi.nlm.nih.gov/32788365/)\] \[[Google Scholar](https://scholar.google.com/scholar_lookup?journal=Proc.%20Natl%20Acad.%20Sci.%20USA&title=Neuronal%20spike-rate%20adaptation%20supports%20working%20memory%20in%20language%20processing&author=H%20Fitz&volume=117&publication_year=2020&pages=20881-20889&pmid=32788365&doi=10.1073/pnas.2000222117&)\]

[^13]: 19.Shaban A, Bezugam SS, Suri M. An adaptive threshold neuron for recurrent spiking neural networks with nanodevice hardware implementation. Nat. Commun. 2021;12:1–11. doi: 10.1038/s41467-021-24427-8. \[[DOI](https://doi.org/10.1038/s41467-021-24427-8)\] \[[PMC free article](https://pmc.ncbi.nlm.nih.gov/articles/PMC8270926/)\] \[[PubMed](https://pubmed.ncbi.nlm.nih.gov/34244491/)\] \[[Google Scholar](https://scholar.google.com/scholar_lookup?journal=Nat.%20Commun.&title=An%20adaptive%20threshold%20neuron%20for%20recurrent%20spiking%20neural%20networks%20with%20nanodevice%20hardware%20implementation&author=A%20Shaban&author=SS%20Bezugam&author=M%20Suri&volume=12&publication_year=2021&pages=1-11&pmid=34244491&doi=10.1038/s41467-021-24427-8&)\]

[^14]: 20.Benda J. Neural adaptation. Curr. Biol. 2021;31:R110–R116. doi: 10.1016/j.cub.2020.11.054. \[[DOI](https://doi.org/10.1016/j.cub.2020.11.054)\] \[[PubMed](https://pubmed.ncbi.nlm.nih.gov/33561404/)\] \[[Google Scholar](https://scholar.google.com/scholar_lookup?journal=Curr.%20Biol.&title=Neural%20adaptation&author=J%20Benda&volume=31&publication_year=2021&pages=R110-R116&pmid=33561404&doi=10.1016/j.cub.2020.11.054&)\]

[^15]: 21.Farkhooi F, Froese A, Muller E, Menzel R, Nawrot MP. Cellular adaptation facilitates sparse and reliable coding in sensory pathways. PLoS Comput. Biol. 2013;9:e1003251. doi: 10.1371/journal.pcbi.1003251. \[[DOI](https://doi.org/10.1371/journal.pcbi.1003251)\] \[[PMC free article](https://pmc.ncbi.nlm.nih.gov/articles/PMC3789775/)\] \[[PubMed](https://pubmed.ncbi.nlm.nih.gov/24098101/)\] \[[Google Scholar](https://scholar.google.com/scholar_lookup?journal=PLoS%20Comput.%20Biol.&title=Cellular%20adaptation%20facilitates%20sparse%20and%20reliable%20coding%20in%20sensory%20pathways&author=F%20Farkhooi&author=A%20Froese&author=E%20Muller&author=R%20Menzel&author=MP%20Nawrot&volume=9&publication_year=2013&pages=e1003251&pmid=24098101&doi=10.1371/journal.pcbi.1003251&)\]

[^16]: 22.Benda J, Longtin A, Maler L. Spike-frequency adaptation separates transient communication signals from background oscillations. J. Neurosci. 2005;25:2312–2321. doi: 10.1523/JNEUROSCI.4795-04.2005. \[[DOI](https://doi.org/10.1523/JNEUROSCI.4795-04.2005)\] \[[PMC free article](https://pmc.ncbi.nlm.nih.gov/articles/PMC6726095/)\] \[[PubMed](https://pubmed.ncbi.nlm.nih.gov/15745957/)\] \[[Google Scholar](https://scholar.google.com/scholar_lookup?journal=J.%20Neurosci.&title=Spike-frequency%20adaptation%20separates%20transient%20communication%20signals%20from%20background%20oscillations&author=J%20Benda&author=A%20Longtin&author=L%20Maler&volume=25&publication_year=2005&pages=2312-2321&pmid=15745957&doi=10.1523/JNEUROSCI.4795-04.2005&)\]

[^17]: 23.Marder E, Abbott L, Turrigiano GG, Liu Z, Golowasch J. Memory from the dynamics of intrinsic membrane currents. Proc. Natl Acad. Sci. USA. 1996;93:13481–13486. doi: 10.1073/pnas.93.24.13481. \[[DOI](https://doi.org/10.1073/pnas.93.24.13481)\] \[[PMC free article](https://pmc.ncbi.nlm.nih.gov/articles/PMC33634/)\] \[[PubMed](https://pubmed.ncbi.nlm.nih.gov/8942960/)\] \[[Google Scholar](https://scholar.google.com/scholar_lookup?journal=Proc.%20Natl%20Acad.%20Sci.%20USA&title=Memory%20from%20the%20dynamics%20of%20intrinsic%20membrane%20currents&author=E%20Marder&author=L%20Abbott&author=GG%20Turrigiano&author=Z%20Liu&author=J%20Golowasch&volume=93&publication_year=1996&pages=13481-13486&pmid=8942960&doi=10.1073/pnas.93.24.13481&)\]

[^18]: 24.Adibi M, McDonald JS, Clifford CW, Arabzadeh E. Adaptation improves neural coding efficiency despite increasing correlations in variability. J. Neurosci. 2013;33:2108–2120. doi: 10.1523/JNEUROSCI.3449-12.2013. \[[DOI](https://doi.org/10.1523/JNEUROSCI.3449-12.2013)\] \[[PMC free article](https://pmc.ncbi.nlm.nih.gov/articles/PMC6619115/)\] \[[PubMed](https://pubmed.ncbi.nlm.nih.gov/23365247/)\] \[[Google Scholar](https://scholar.google.com/scholar_lookup?journal=J.%20Neurosci.&title=Adaptation%20improves%20neural%20coding%20efficiency%20despite%20increasing%20correlations%20in%20variability&author=M%20Adibi&author=JS%20McDonald&author=CW%20Clifford&author=E%20Arabzadeh&volume=33&publication_year=2013&pages=2108-2120&pmid=23365247&doi=10.1523/JNEUROSCI.3449-12.2013&)\]

[^19]: 25.Brenner N, Bialek W, Van Steveninck RdR. Adaptive rescaling maximizes information transmission. Neuron. 2000;26:695–702. doi: 10.1016/S0896-6273(00)81205-2. \[[DOI](https://doi.org/10.1016/S0896-6273\(00\)81205-2)\] \[[PubMed](https://pubmed.ncbi.nlm.nih.gov/10896164/)\] \[[Google Scholar](https://scholar.google.com/scholar_lookup?journal=Neuron&title=Adaptive%20rescaling%20maximizes%20information%20transmission&author=N%20Brenner&author=W%20Bialek&author=RdR%20Van%20Steveninck&volume=26&publication_year=2000&pages=695-702&pmid=10896164&doi=10.1016/S0896-6273\(00\)81205-2&)\]

[^20]: 26.Laughlin S. A simple coding procedure enhances a neuron’s information capacity. Z. Naturforsch. c. 1981;36:910–912. doi: 10.1515/znc-1981-9-1040. \[[DOI](https://doi.org/10.1515/znc-1981-9-1040)\] \[[PubMed](https://pubmed.ncbi.nlm.nih.gov/7303823/)\] \[[Google Scholar](https://scholar.google.com/scholar_lookup?journal=Z.%20Naturforsch.%20c&title=A%20simple%20coding%20procedure%20enhances%20a%20neuron%E2%80%99s%20information%20capacity&author=S%20Laughlin&volume=36&publication_year=1981&pages=910-912&pmid=7303823&doi=10.1515/znc-1981-9-1040&)\]

[^21]: 27.Gutnisky DA, Dragoi V. Adaptive coding of visual information in neural populations. Nature. 2008;452:220–224. doi: 10.1038/nature06563. \[[DOI](https://doi.org/10.1038/nature06563)\] \[[PubMed](https://pubmed.ncbi.nlm.nih.gov/18337822/)\] \[[Google Scholar](https://scholar.google.com/scholar_lookup?journal=Nature&title=Adaptive%20coding%20of%20visual%20information%20in%20neural%20populations&author=DA%20Gutnisky&author=V%20Dragoi&volume=452&publication_year=2008&pages=220-224&pmid=18337822&doi=10.1038/nature06563&)\]

[^22]: 28.Benda J, Maler L, Longtin A. Linear versus nonlinear signal transmission in neuron models with adaptation currents or dynamic thresholds. J. Neurophysiol. 2010;104:2806–2820. doi: 10.1152/jn.00240.2010. \[[DOI](https://doi.org/10.1152/jn.00240.2010)\] \[[PubMed](https://pubmed.ncbi.nlm.nih.gov/21045213/)\] \[[Google Scholar](https://scholar.google.com/scholar_lookup?journal=J.%20Neurophysiol.&title=Linear%20versus%20nonlinear%20signal%20transmission%20in%20neuron%20models%20with%20adaptation%20currents%20or%20dynamic%20thresholds&author=J%20Benda&author=L%20Maler&author=A%20Longtin&volume=104&publication_year=2010&pages=2806-2820&pmid=21045213&doi=10.1152/jn.00240.2010&)\]

[^23]: 29.Subramoney, A., Bellec, G., Scherr, F., Legenstein, R. & Maass, W. Revisiting the role of synaptic plasticity and network dynamics for fast learning in spiking neural networks. Preprint at *bioRxiv* 10.1101/2021.01.25.428153 (2021).

[^24]: 30.Wulf WA, McKee SA. Hitting the memory wall: Implications of the obvious. SIGARCH Comput. Archit. News. 1995;23:20–24. doi: 10.1145/216585.216588. \[[DOI](https://doi.org/10.1145/216585.216588)\] \[[Google Scholar](https://scholar.google.com/scholar_lookup?journal=SIGARCH%20Comput.%20Archit.%20News&title=Hitting%20the%20memory%20wall:%20Implications%20of%20the%20obvious&author=WA%20Wulf&author=SA%20McKee&volume=23&publication_year=1995&pages=20-24&doi=10.1145/216585.216588&)\]

[^25]: 31.Bezugam, S. S., Shaban, A. & Suri, M. Neuromorphic recurrent spiking neural networks for emg gesture classification and low power implementation on loihi. In *2023 IEEE International Symposium on Circuits and Systems (ISCAS)*, 1–5 (IEEE, 2023).

[^26]: 32.Zhang, S. et al. Long short-term memory with two-compartment spiking neuron. 10.48550/arXiv.2307.07231 (2023).

[^27]: 33.Bellec G, et al. A solution to the learning dilemma for recurrent networks of spiking neurons. Nat. Commun. 2020;11:1–15. doi: 10.1038/s41467-020-17236-y. \[[DOI](https://doi.org/10.1038/s41467-020-17236-y)\] \[[PMC free article](https://pmc.ncbi.nlm.nih.gov/articles/PMC7367848/)\] \[[PubMed](https://pubmed.ncbi.nlm.nih.gov/32681001/)\] \[[Google Scholar](https://scholar.google.com/scholar_lookup?journal=Nat.%20Commun.&title=A%20solution%20to%20the%20learning%20dilemma%20for%20recurrent%20networks%20of%20spiking%20neurons&author=G%20Bellec&volume=11&publication_year=2020&pages=1-15&pmid=32681001&doi=10.1038/s41467-020-17236-y&)\]

[^28]: 34.Abbott, L. F. & Dayan, P.*Theoretical Neuroscience*, Vol. 60 (MIT Press, 2001).

[^29]: 35.Kobayashi R, Tsubo Y, Shinomoto S. Made-to-order spiking neuron model equipped with a multi-timescale adaptive threshold. Front. Comput. Neurosci. 2009;3:9. doi: 10.3389/neuro.10.009.2009. \[[DOI](https://doi.org/10.3389/neuro.10.009.2009)\] \[[PMC free article](https://pmc.ncbi.nlm.nih.gov/articles/PMC2722979/)\] \[[PubMed](https://pubmed.ncbi.nlm.nih.gov/19668702/)\] \[[Google Scholar](https://scholar.google.com/scholar_lookup?journal=Front.%20Comput.%20Neurosci.&title=Made-to-order%20spiking%20neuron%20model%20equipped%20with%20a%20multi-timescale%20adaptive%20threshold&author=R%20Kobayashi&author=Y%20Tsubo&author=S%20Shinomoto&volume=3&publication_year=2009&pages=9&pmid=19668702&doi=10.3389/neuro.10.009.2009&)\]

[^30]: 36.Jolivet, R., Timothy, J. & Gerstner, W. The spike response model: a framework to predict neuronal spike trains. *Artif. Neural Netw. Neural Inf. Process.* 846–853 (2003).

[^31]: 37.*Allen Institute for Brain Science. Allen Cell Types Database, Technical White Paper: Neuronal Models GLIF*. [http://help.brain-map.org](http://help.brain-map.org/) (2022).

[^32]: 38.Allen Institute for Brain Science. *Allen Cell Types Database*. [http://celltypes.brain-map.org](http://celltypes.brain-map.org/) (2020).

[^33]: 39.Teeter C, et al. Generalized leaky integrate-and-fire models classify multiple neuron types. Nat. Commun. 2018;9:1–15. doi: 10.1038/s41467-017-02717-4. \[[DOI](https://doi.org/10.1038/s41467-017-02717-4)\] \[[PMC free article](https://pmc.ncbi.nlm.nih.gov/articles/PMC5818568/)\] \[[PubMed](https://pubmed.ncbi.nlm.nih.gov/29459723/)\] \[[Google Scholar](https://scholar.google.com/scholar_lookup?journal=Nat.%20Commun.&title=Generalized%20leaky%20integrate-and-fire%20models%20classify%20multiple%20neuron%20types&author=C%20Teeter&volume=9&publication_year=2018&pages=1-15&pmid=29459723&doi=10.1038/s41467-017-02717-4&)\]

[^34]: 40.Yin B, Corradi F, Bohté SM. Accurate and efficient time-domain classification with adaptive spiking recurrent neural networks. Nat. Mach. Intell. 2021;3:905–913. doi: 10.1038/s42256-021-00397-w. \[[DOI](https://doi.org/10.1038/s42256-021-00397-w)\] \[[Google Scholar](https://scholar.google.com/scholar_lookup?journal=Nat.%20Mach.%20Intell.&title=Accurate%20and%20efficient%20time-domain%20classification%20with%20adaptive%20spiking%20recurrent%20neural%20networks&author=B%20Yin&author=F%20Corradi&author=SM%20Boht%C3%A9&volume=3&publication_year=2021&pages=905-913&doi=10.1038/s42256-021-00397-w&)\]

[^35]: 41.Wade JJ, McDaid LJ, Santos JA, Sayers HM. Swat: a spiking neural network training algorithm for classification problems. IEEE Trans. Neural Netw. 2010;21:1817–1830. doi: 10.1109/TNN.2010.2074212. \[[DOI](https://doi.org/10.1109/TNN.2010.2074212)\] \[[PubMed](https://pubmed.ncbi.nlm.nih.gov/20876015/)\] \[[Google Scholar](https://scholar.google.com/scholar_lookup?journal=IEEE%20Trans.%20Neural%20Netw.&title=Swat:%20a%20spiking%20neural%20network%20training%20algorithm%20for%20classification%20problems&author=JJ%20Wade&author=LJ%20McDaid&author=JA%20Santos&author=HM%20Sayers&volume=21&publication_year=2010&pages=1817-1830&pmid=20876015&doi=10.1109/TNN.2010.2074212&)\]

[^36]: 42.Querlioz D, Bichler O, Dollfus P, Gamrat C. Immunity to device variations in a spiking neural network with memristive nanodevices. IEEE Trans. Nanotechnol. 2013;12:288–295. doi: 10.1109/TNANO.2013.2250995. \[[DOI](https://doi.org/10.1109/TNANO.2013.2250995)\] \[[Google Scholar](https://scholar.google.com/scholar_lookup?journal=IEEE%20Trans.%20Nanotechnol.&title=Immunity%20to%20device%20variations%20in%20a%20spiking%20neural%20network%20with%20memristive%20nanodevices&author=D%20Querlioz&author=O%20Bichler&author=P%20Dollfus&author=C%20Gamrat&volume=12&publication_year=2013&pages=288-295&doi=10.1109/TNANO.2013.2250995&)\]

[^37]: 43.Diehl PU, Cook M. Unsupervised learning of digit recognition using spike-timing-dependent plasticity. Front. Comput. Neurosci. 2015;9:99. doi: 10.3389/fncom.2015.00099. \[[DOI](https://doi.org/10.3389/fncom.2015.00099)\] \[[PMC free article](https://pmc.ncbi.nlm.nih.gov/articles/PMC4522567/)\] \[[PubMed](https://pubmed.ncbi.nlm.nih.gov/26941637/)\] \[[Google Scholar](https://scholar.google.com/scholar_lookup?journal=Front.%20Comput.%20Neurosci.&title=Unsupervised%20learning%20of%20digit%20recognition%20using%20spike-timing-dependent%20plasticity&author=PU%20Diehl&author=M%20Cook&volume=9&publication_year=2015&pages=99&pmid=26941637&doi=10.3389/fncom.2015.00099&)\]

[^38]: 44.Jiang J, et al. Mspan: a memristive spike-based computing engine with adaptive neuron for edge arrhythmia detection. Front. Neurosci. 2021;15:761127. doi: 10.3389/fnins.2021.761127. \[[DOI](https://doi.org/10.3389/fnins.2021.761127)\] \[[PMC free article](https://pmc.ncbi.nlm.nih.gov/articles/PMC8715923/)\] \[[PubMed](https://pubmed.ncbi.nlm.nih.gov/34975373/)\] \[[Google Scholar](https://scholar.google.com/scholar_lookup?journal=Front.%20Neurosci.&title=Mspan:%20a%20memristive%20spike-based%20computing%20engine%20with%20adaptive%20neuron%20for%20edge%20arrhythmia%20detection&author=J%20Jiang&volume=15&publication_year=2021&pages=761127&pmid=34975373&doi=10.3389/fnins.2021.761127&)\]

[^39]: 45.Paredes-Vallés F, Scheper KY, De Croon GC. Unsupervised learning of a hierarchical spiking neural network for optical flow estimation: From events to global motion perception. IEEE Trans. Pattern Anal. Mach. Intell. 2019;42:2051–2064. doi: 10.1109/TPAMI.2019.2903179. \[[DOI](https://doi.org/10.1109/TPAMI.2019.2903179)\] \[[PubMed](https://pubmed.ncbi.nlm.nih.gov/30843817/)\] \[[Google Scholar](https://scholar.google.com/scholar_lookup?journal=IEEE%20Trans.%20Pattern%20Anal.%20Mach.%20Intell.&title=Unsupervised%20learning%20of%20a%20hierarchical%20spiking%20neural%20network%20for%20optical%20flow%20estimation:%20From%20events%20to%20global%20motion%20perception&author=F%20Paredes-Vall%C3%A9s&author=KY%20Scheper&author=GC%20De%20Croon&volume=42&publication_year=2019&pages=2051-2064&pmid=30843817&doi=10.1109/TPAMI.2019.2903179&)\]

[^40]: 46.Bethi Y, Xu Y, Cohen G, Van Schaik A, Afshar S. An optimized deep spiking neural network architecture without gradients. IEEE Access. 2022;10:97912–97929. doi: 10.1109/ACCESS.2022.3200699. \[[DOI](https://doi.org/10.1109/ACCESS.2022.3200699)\] \[[Google Scholar](https://scholar.google.com/scholar_lookup?journal=IEEE%20Access&title=An%20optimized%20deep%20spiking%20neural%20network%20architecture%20without%20gradients&author=Y%20Bethi&author=Y%20Xu&author=G%20Cohen&author=A%20Van%20Schaik&author=S%20Afshar&volume=10&publication_year=2022&pages=97912-97929&doi=10.1109/ACCESS.2022.3200699&)\]

[^41]: 47.Rao A, Plank P, Wild A, Maass W. A long short-term memory for ai applications in spike-based neuromorphic hardware. Nat. Mach. Intell. 2022;4:467–479. doi: 10.1038/s42256-022-00480-w. \[[DOI](https://doi.org/10.1038/s42256-022-00480-w)\] \[[Google Scholar](https://scholar.google.com/scholar_lookup?journal=Nat.%20Mach.%20Intell.&title=A%20long%20short-term%20memory%20for%20ai%20applications%20in%20spike-based%20neuromorphic%20hardware&author=A%20Rao&author=P%20Plank&author=A%20Wild&author=W%20Maass&volume=4&publication_year=2022&pages=467-479&doi=10.1038/s42256-022-00480-w&)\]

[^42]: 48.Amin HH. Automated adaptive threshold-based feature extraction and learning for spiking neural networks. IEEE Access. 2021;9:97366–97383. doi: 10.1109/ACCESS.2021.3094262. \[[DOI](https://doi.org/10.1109/ACCESS.2021.3094262)\] \[[Google Scholar](https://scholar.google.com/scholar_lookup?journal=IEEE%20Access&title=Automated%20adaptive%20threshold-based%20feature%20extraction%20and%20learning%20for%20spiking%20neural%20networks&author=HH%20Amin&volume=9&publication_year=2021&pages=97366-97383&doi=10.1109/ACCESS.2021.3094262&)\]

[^43]: 49.Liu D, Yue S. Fast unsupervised learning for visual pattern recognition using spike timing dependent plasticity. Neurocomputing. 2017;249:212–224. doi: 10.1016/j.neucom.2017.04.003. \[[DOI](https://doi.org/10.1016/j.neucom.2017.04.003)\] \[[Google Scholar](https://scholar.google.com/scholar_lookup?journal=Neurocomputing&title=Fast%20unsupervised%20learning%20for%20visual%20pattern%20recognition%20using%20spike%20timing%20dependent%20plasticity&author=D%20Liu&author=S%20Yue&volume=249&publication_year=2017&pages=212-224&doi=10.1016/j.neucom.2017.04.003&)\]

[^44]: 50.Aamir SA, et al. A mixed-signal structured adex neuron for accelerated neuromorphic cores. IEEE Trans. Biomed. Circuits Syst. 2018;12:1027–1037. doi: 10.1109/TBCAS.2018.2848203. \[[DOI](https://doi.org/10.1109/TBCAS.2018.2848203)\] \[[PubMed](https://pubmed.ncbi.nlm.nih.gov/30047897/)\] \[[Google Scholar](https://scholar.google.com/scholar_lookup?journal=IEEE%20Trans.%20Biomed.%20Circuits%20Syst.&title=A%20mixed-signal%20structured%20adex%20neuron%20for%20accelerated%20neuromorphic%20cores&author=SA%20Aamir&volume=12&publication_year=2018&pages=1027-1037&pmid=30047897&doi=10.1109/TBCAS.2018.2848203&)\]

[^45]: 52.Plank, P. *Implementation of Novel Networks of Spiking Neurons on the Intel Loihi Chip*. Ph.D. thesis, TU Garz (2021).

[^46]: 53.Lapique L. Recherches quantitatives sur l’excitation electrique des nerfs traitee comme une polarization. J. Physiol. Pathol. 1907;9:620–635. \[[Google Scholar](https://scholar.google.com/scholar_lookup?journal=J.%20Physiol.%20Pathol.&title=Recherches%20quantitatives%20sur%20l%E2%80%99excitation%20electrique%20des%20nerfs%20traitee%20comme%20une%20polarization&author=L%20Lapique&volume=9&publication_year=1907&pages=620-635&)\]

[^47]: 55.Hazan, A. & Tsur, E. E. Neuromorphic spike timing dependent plasticity with adaptive oz spiking neurons. In *2021 IEEE Biomedical Circuits and Systems Conference (BioCAS)*, 1–4 (IEEE, 2021).

[^48]: 56.Qiao N, et al. A reconfigurable on-line learning spiking neuromorphic processor comprising 256 neurons and 128k synapses. Front. Neurosci. 2015;9:141. doi: 10.3389/fnins.2015.00141. \[[DOI](https://doi.org/10.3389/fnins.2015.00141)\] \[[PMC free article](https://pmc.ncbi.nlm.nih.gov/articles/PMC4413675/)\] \[[PubMed](https://pubmed.ncbi.nlm.nih.gov/25972778/)\] \[[Google Scholar](https://scholar.google.com/scholar_lookup?journal=Front.%20Neurosci.&title=A%20reconfigurable%20on-line%20learning%20spiking%20neuromorphic%20processor%20comprising%20256%20neurons%20and%20128k%20synapses&author=N%20Qiao&volume=9&publication_year=2015&pages=141&pmid=25972778&doi=10.3389/fnins.2015.00141&)\]

[^49]: 58.Rubino A, Livanelioglu C, Qiao N, Payvand M, Indiveri G. Ultra-low-power fdsoi neural circuits for extreme-edge neuromorphic intelligence. IEEE Trans. Circuits Syst. I: Regular Pap. 2020;68:45–56. doi: 10.1109/TCSI.2020.3035575. \[[DOI](https://doi.org/10.1109/TCSI.2020.3035575)\] \[[Google Scholar](https://scholar.google.com/scholar_lookup?journal=IEEE%20Trans.%20Circuits%20Syst.%20I:%20Regular%20Pap.&title=Ultra-low-power%20fdsoi%20neural%20circuits%20for%20extreme-edge%20neuromorphic%20intelligence&author=A%20Rubino&author=C%20Livanelioglu&author=N%20Qiao&author=M%20Payvand&author=G%20Indiveri&volume=68&publication_year=2020&pages=45-56&doi=10.1109/TCSI.2020.3035575&)\]

[^50]: 59.Dalgaty, T. et al. Hybrid cmos-rram neurons with intrinsic plasticity. In *2019 IEEE International Symposium on Circuits and Systems (ISCAS)*, 1–5 (IEEE, 2019).

[^51]: 60.Tuma T, Pantazi A, Le Gallo M, Sebastian A, Eleftheriou E. Stochastic phase-change neurons. Nat. Nanotechnol. 2016;11:693. doi: 10.1038/nnano.2016.70. \[[DOI](https://doi.org/10.1038/nnano.2016.70)\] \[[PubMed](https://pubmed.ncbi.nlm.nih.gov/27183057/)\] \[[Google Scholar](https://scholar.google.com/scholar_lookup?journal=Nat.%20Nanotechnol.&title=Stochastic%20phase-change%20neurons&author=T%20Tuma&author=A%20Pantazi&author=M%20Le%20Gallo&author=A%20Sebastian&author=E%20Eleftheriou&volume=11&publication_year=2016&pages=693&pmid=27183057&doi=10.1038/nnano.2016.70&)\]

[^52]: 61.Van Schaik A. Building blocks for electronic spiking neural networks. Neural Netw. 2001;14:617–628. doi: 10.1016/S0893-6080(01)00067-3. \[[DOI](https://doi.org/10.1016/S0893-6080\(01\)00067-3)\] \[[PubMed](https://pubmed.ncbi.nlm.nih.gov/11665758/)\] \[[Google Scholar](https://scholar.google.com/scholar_lookup?journal=Neural%20Netw.&title=Building%20blocks%20for%20electronic%20spiking%20neural%20networks&author=A%20Van%20Schaik&volume=14&publication_year=2001&pages=617-628&pmid=11665758&doi=10.1016/S0893-6080\(01\)00067-3&)\]

[^53]: 67.Muñoz-Martin, I. et al. A siox rram-based hardware with spike frequency adaptation for power-saving continual learning in convolutional neural networks. In *2020 IEEE Symposium on VLSI Technology*, 1–2 (IEEE, 2020).

[^54]: 68.Crotty P, Segall K, Schult D. Biologically realistic behaviors from a superconducting neuron model. IEEE Trans. Appl. Supercond. 2023;33:1–6. doi: 10.1109/TASC.2023.3242901. \[[DOI](https://doi.org/10.1109/TASC.2023.3242901)\] \[[Google Scholar](https://scholar.google.com/scholar_lookup?journal=IEEE%20Trans.%20Appl.%20Supercond.&title=Biologically%20realistic%20behaviors%20from%20a%20superconducting%20neuron%20model&author=P%20Crotty&author=K%20Segall&author=D%20Schult&volume=33&publication_year=2023&pages=1-6&doi=10.1109/TASC.2023.3242901&)\]

[^55]: 69.Thakar K, Rajendran B, Lodha S. Ultra-low power neuromorphic obstacle detection using a two-dimensional materials-based subthreshold transistor. npj 2D Mater. Appl. 2023;7:68. doi: 10.1038/s41699-023-00422-z. \[[DOI](https://doi.org/10.1038/s41699-023-00422-z)\] \[[Google Scholar](https://scholar.google.com/scholar_lookup?journal=npj%202D%20Mater.%20Appl.&title=Ultra-low%20power%20neuromorphic%20obstacle%20detection%20using%20a%20two-dimensional%20materials-based%20subthreshold%20transistor&author=K%20Thakar&author=B%20Rajendran&author=S%20Lodha&volume=7&publication_year=2023&pages=68&doi=10.1038/s41699-023-00422-z&)\]

[^56]: 70.Gomar S, Ahmadi A. Digital multiplierless implementation of biological adaptive-exponential neuron model. IEEE Trans. Circuits Syst. I: Regular Papers. 2013;61:1206–1219. doi: 10.1109/TCSI.2013.2286030. \[[DOI](https://doi.org/10.1109/TCSI.2013.2286030)\] \[[Google Scholar](https://scholar.google.com/scholar_lookup?journal=IEEE%20Trans.%20Circuits%20Syst.%20I:%20Regular%20Papers&title=Digital%20multiplierless%20implementation%20of%20biological%20adaptive-exponential%20neuron%20model&author=S%20Gomar&author=A%20Ahmadi&volume=61&publication_year=2013&pages=1206-1219&doi=10.1109/TCSI.2013.2286030&)\]

[^57]: 72.Picardo SM, Shaik JB, Singhal S, Goel N. Enabling efficient rate and temporal coding using reliability-aware design of a neuromorphic circuit. Int. J. Circuit Theory Appl. 2022;50:4234–4250. doi: 10.1002/cta.3395. \[[DOI](https://doi.org/10.1002/cta.3395)\] \[[Google Scholar](https://scholar.google.com/scholar_lookup?journal=Int.%20J.%20Circuit%20Theory%20Appl.&title=Enabling%20efficient%20rate%20and%20temporal%20coding%20using%20reliability-aware%20design%20of%20a%20neuromorphic%20circuit&author=SM%20Picardo&author=JB%20Shaik&author=S%20Singhal&author=N%20Goel&volume=50&publication_year=2022&pages=4234-4250&doi=10.1002/cta.3395&)\]

[^58]: 73.Haghiri S, Ahmadi A. A novel digital realization of adex neuron model. IEEE Trans. Circuits Syst. II: Express Briefs. 2019;67:1444–1448. \[[Google Scholar](https://scholar.google.com/scholar_lookup?journal=IEEE%20Trans.%20Circuits%20Syst.%20II:%20Express%20Briefs&title=A%20novel%20digital%20realization%20of%20adex%20neuron%20model&author=S%20Haghiri&author=A%20Ahmadi&volume=67&publication_year=2019&pages=1444-1448&)\]

[^59]: 74.Gao T, Deng B, Wang J, Yi G. Presynaptic spike-driven plasticity based on eligibility trace for on-chip learning system. Front. Neurosci. 2023;17:1107089. doi: 10.3389/fnins.2023.1107089. \[[DOI](https://doi.org/10.3389/fnins.2023.1107089)\] \[[PMC free article](https://pmc.ncbi.nlm.nih.gov/articles/PMC9997725/)\] \[[PubMed](https://pubmed.ncbi.nlm.nih.gov/36908804/)\] \[[Google Scholar](https://scholar.google.com/scholar_lookup?journal=Front.%20Neurosci.&title=Presynaptic%20spike-driven%20plasticity%20based%20on%20eligibility%20trace%20for%20on-chip%20learning%20system&author=T%20Gao&author=B%20Deng&author=J%20Wang&author=G%20Yi&volume=17&publication_year=2023&pages=1107089&pmid=36908804&doi=10.3389/fnins.2023.1107089&)\]

[^60]: 75.Davison AP, et al. Pynn: a common interface for neuronal network simulators. Front. Neuroinform. 2009;2:11. doi: 10.3389/neuro.11.011.2008. \[[DOI](https://doi.org/10.3389/neuro.11.011.2008)\] \[[PMC free article](https://pmc.ncbi.nlm.nih.gov/articles/PMC2634533/)\] \[[PubMed](https://pubmed.ncbi.nlm.nih.gov/19194529/)\] \[[Google Scholar](https://scholar.google.com/scholar_lookup?journal=Front.%20Neuroinform.&title=Pynn:%20a%20common%20interface%20for%20neuronal%20network%20simulators&author=AP%20Davison&volume=2&publication_year=2009&pages=11&pmid=19194529&doi=10.3389/neuro.11.011.2008&)\]

[^61]: 76.Stimberg M, Brette R, Goodman DF. Brian 2, an intuitive and efficient neural simulator. eLife. 2019;8:e47314. doi: 10.7554/eLife.47314. \[[DOI](https://doi.org/10.7554/eLife.47314)\] \[[PMC free article](https://pmc.ncbi.nlm.nih.gov/articles/PMC6786860/)\] \[[PubMed](https://pubmed.ncbi.nlm.nih.gov/31429824/)\] \[[Google Scholar](https://scholar.google.com/scholar_lookup?journal=eLife&title=Brian%202,%20an%20intuitive%20and%20efficient%20neural%20simulator&author=M%20Stimberg&author=R%20Brette&author=DF%20Goodman&volume=8&publication_year=2019&pages=e47314&pmid=31429824&doi=10.7554/eLife.47314&)\]

[^62]: 77.Gewaltig M-O, Diesmann M. Nest (neural simulation tool) Scholarpedia. 2007;2:1430. doi: 10.4249/scholarpedia.1430. \[[DOI](https://doi.org/10.4249/scholarpedia.1430)\] \[[Google Scholar](https://scholar.google.com/scholar_lookup?journal=Scholarpedia&title=Nest%20\(neural%20simulation%20tool\)&author=M-O%20Gewaltig&author=M%20Diesmann&volume=2&publication_year=2007&pages=1430&doi=10.4249/scholarpedia.1430&)\]

[^63]: 78.Zhao, Z., Wycoff, N., Getty, N., Stevens, R. & Xia, F. Neko: a library for exploring neuromorphic learning rules. In *International Conference on Neuromorphic Systems 2021*, 1–5 (ACM, 2021).

[^64]: 79.Pang, M., Li, Y., Li, Z. & Zhang, Y. Fable: A development and computing framework for brain-inspired learning algorithms. In *2023 International Joint Conference on Neural Networks (IJCNN)*, 1–10 (IEEE, 2023).

[^65]: 80.Pehle, C. & Pedersen, J. E. Norse—a deep learning library for spiking neural networks 10.5281/zenodo.4422025. Documentation: [https://norse.ai/docs/](https://norse.ai/docs/) (2021).

[^66]: 81.Kumar M, Bezugam SS, Khan S, Suri M. Fully unsupervised spike-rate-dependent plasticity learning with oxide-based memory devices. IEEE Trans. Electron Devices. 2021;68:3346–3352. doi: 10.1109/TED.2021.3077346. \[[DOI](https://doi.org/10.1109/TED.2021.3077346)\] \[[Google Scholar](https://scholar.google.com/scholar_lookup?journal=IEEE%20Trans.%20Electron%20Devices&title=Fully%20unsupervised%20spike-rate-dependent%20plasticity%20learning%20with%20oxide-based%20memory%20devices&author=M%20Kumar&author=SS%20Bezugam&author=S%20Khan&author=M%20Suri&volume=68&publication_year=2021&pages=3346-3352&doi=10.1109/TED.2021.3077346&)\]

[^67]: 82.Li, L. et al. Dynamical information encoding in neural adaptation. In *2016 38th Annual International Conference of the IEEE Engineering in Medicine and Biology Society (EMBC)*, 3060–3063 (IEEE, 2016). \[[DOI](https://doi.org/10.1109/EMBC.2016.7591375)\] \[[PubMed](https://pubmed.ncbi.nlm.nih.gov/28268957/)\]

[^68]: 83.Hildebrandt KJ, Ronacher B, Hennig RM, Benda J. A neural mechanism for time-window separation resolves ambiguity of adaptive coding. PLoS Biol. 2015;13:e1002096. doi: 10.1371/journal.pbio.1002096. \[[DOI](https://doi.org/10.1371/journal.pbio.1002096)\] \[[PMC free article](https://pmc.ncbi.nlm.nih.gov/articles/PMC4356587/)\] \[[PubMed](https://pubmed.ncbi.nlm.nih.gov/25761097/)\] \[[Google Scholar](https://scholar.google.com/scholar_lookup?journal=PLoS%20Biol.&title=A%20neural%20mechanism%20for%20time-window%20separation%20resolves%20ambiguity%20of%20adaptive%20coding&author=KJ%20Hildebrandt&author=B%20Ronacher&author=RM%20Hennig&author=J%20Benda&volume=13&publication_year=2015&pages=e1002096&pmid=25761097&doi=10.1371/journal.pbio.1002096&)\]

[^69]: 84.Maass, W. How can neuromorphic hardware attain brain-like functional capabilities? *Natl. Sci. Rev.*10.1093/nsr/nwad301, nwad301 (2023). \[[DOI](https://doi.org/10.1093/nsr/nwad301)\] \[[PMC free article](https://pmc.ncbi.nlm.nih.gov/articles/PMC10989294/)\] \[[PubMed](https://pubmed.ncbi.nlm.nih.gov/38577672/)\]

[^70]: 85.Kim, K. M. et al. Computing with heat using biocompatible mott neurons. *Research Square preprint* 10.21203/rs.3.rs-3134569/v1 (2023).

[^71]: 86.Wang Y-H, et al. Redox memristors with volatile threshold switching behavior for neuromorphic computing. J. Electron. Sci. Technol. 2022;20:100177. doi: 10.1016/j.jnlest.2022.100177. \[[DOI](https://doi.org/10.1016/j.jnlest.2022.100177)\] \[[Google Scholar](https://scholar.google.com/scholar_lookup?journal=J.%20Electron.%20Sci.%20Technol.&title=Redox%20memristors%20with%20volatile%20threshold%20switching%20behavior%20for%20neuromorphic%20computing&author=Y-H%20Wang&volume=20&publication_year=2022&pages=100177&doi=10.1016/j.jnlest.2022.100177&)\]

[^72]: 87.Wang W, et al. Volatile resistive switching memory based on ag ion drift/diffusion part I: Numerical modeling. IEEE Trans. Electron Devices. 2019;66:3795–3801. doi: 10.1109/TED.2019.2928890. \[[DOI](https://doi.org/10.1109/TED.2019.2928890)\] \[[Google Scholar](https://scholar.google.com/scholar_lookup?journal=IEEE%20Trans.%20Electron%20Devices&title=Volatile%20resistive%20switching%20memory%20based%20on%20ag%20ion%20drift/diffusion%20part%20I:%20Numerical%20modeling&author=W%20Wang&volume=66&publication_year=2019&pages=3795-3801&doi=10.1109/TED.2019.2928890&)\]

[^73]: 88.Sharmin, S., Rathi, N., Panda, P. & Roy, K. Inherent adversarial robustness of deep spiking neural networks: Effects of discrete input encoding and non-linear activations. In *Computer Vision–ECCV 2020: 16th European Conference, Glasgow, UK, August 23–28, 2020, Proceedings, Part XXIX 16*, 399–414 (Springer, 2020).

[^74]: 91.Liang, L. et al. Exploring adversarial attack in spiking neural networks with spike-compatible gradient. *IEEE Trans. Neural Netw. Learn. Syst.* (2021). \[[DOI](https://doi.org/10.1109/TNNLS.2021.3106961)\] \[[PubMed](https://pubmed.ncbi.nlm.nih.gov/34473634/)\]

[^75]: 92.Finn, C., Abbeel, P. & Levine, S. Model-agnostic meta-learning for fast adaptation of deep networks. In *International Conference on Machine Learning* 1126–1135 (PMLR, 2017).

[^76]: 93.Yang S, Tan J, Chen B. Robust spike-based continual meta-learning improved by restricted minimum error entropy criterion. Entropy. 2022;24:455. doi: 10.3390/e24040455. \[[DOI](https://doi.org/10.3390/e24040455)\] \[[PMC free article](https://pmc.ncbi.nlm.nih.gov/articles/PMC9031894/)\] \[[PubMed](https://pubmed.ncbi.nlm.nih.gov/35455118/)\] \[[Google Scholar](https://scholar.google.com/scholar_lookup?journal=Entropy&title=Robust%20spike-based%20continual%20meta-learning%20improved%20by%20restricted%20minimum%20error%20entropy%20criterion&author=S%20Yang&author=J%20Tan&author=B%20Chen&volume=24&publication_year=2022&pages=455&pmid=35455118&doi=10.3390/e24040455&)\]

[^77]: 94.Brette R, Gerstner W. Adaptive exponential integrate-and-fire model as an effective description of neuronal activity. J. Neurophysiol. 2005;94:3637–3642. doi: 10.1152/jn.00686.2005. \[[DOI](https://doi.org/10.1152/jn.00686.2005)\] \[[PubMed](https://pubmed.ncbi.nlm.nih.gov/16014787/)\] \[[Google Scholar](https://scholar.google.com/scholar_lookup?journal=J.%20Neurophysiol.&title=Adaptive%20exponential%20integrate-and-fire%20model%20as%20an%20effective%20description%20of%20neuronal%20activity&author=R%20Brette&author=W%20Gerstner&volume=94&publication_year=2005&pages=3637-3642&pmid=16014787&doi=10.1152/jn.00686.2005&)\]

[^78]: 95.Mihalaş Ş, Niebur E. A generalized linear integrate-and-fire neural model produces diverse spiking behaviors. Neural Comput. 2009;21:704–718. doi: 10.1162/neco.2008.12-07-680. \[[DOI](https://doi.org/10.1162/neco.2008.12-07-680)\] \[[PMC free article](https://pmc.ncbi.nlm.nih.gov/articles/PMC2954058/)\] \[[PubMed](https://pubmed.ncbi.nlm.nih.gov/18928368/)\] \[[Google Scholar](https://scholar.google.com/scholar_lookup?journal=Neural%20Comput.&title=A%20generalized%20linear%20integrate-and-fire%20neural%20model%20produces%20diverse%20spiking%20behaviors&author=%C5%9E%20Mihala%C5%9F&author=E%20Niebur&volume=21&publication_year=2009&pages=704-718&pmid=18928368&doi=10.1162/neco.2008.12-07-680&)\]