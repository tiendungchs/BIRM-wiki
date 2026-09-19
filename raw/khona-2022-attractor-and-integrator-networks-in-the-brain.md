---
title: "Attractor and integrator networks in the brain - Nature Reviews Neuroscience"
source: "https://www.nature.com/articles/s41583-022-00642-0"
author:
  - "[[Mikail Khona]]"
  - "[[Ila R. Fiete]]"
published: 2022-11-03
created: 2026-09-19
description: "In this Review, we describe the singular success of attractor neural network models in describing how the brain maintains persistent activity states for working memory, corrects errors and integrates noisy cues. We consider the mechanisms by which simple and forgetful units can organize to collectively generate dynamics on the long timescales required for such computations. We discuss the myriad potential uses of attractor dynamics for computation in the brain, and showcase notable examples of brain systems in which inherently low-dimensional continuous-attractor dynamics have been concretely and rigorously identified. Thus, it is now possible to conclusively state that the brain constructs and uses such systems for computation. Finally, we highlight recent theoretical advances in understanding how the fundamental trade-offs between robustness and capacity and between structure and flexibility can be overcome by reusing and recombining the same set of modular attractors for multiple functions, so they together produce representations that are structurally constrained and robust but exhibit high capacity and are flexible. Attractor network dynamics can support several computations performed by the brain. In their Review, Khona and Fiete introduce different attractor dynamics and their computational utility, describe evidence of attractor networks across the brain and explain how such networks could be recombined to increase their flexibility and versatility."
tags:
  - "clippings"
---
## Abstract

In this Review, we describe the singular success of attractor neural network models in describing how the brain maintains persistent activity states for working memory, corrects errors and integrates noisy cues. We consider the mechanisms by which simple and forgetful units can organize to collectively generate dynamics on the long timescales required for such computations. We discuss the myriad potential uses of attractor dynamics for computation in the brain, and showcase notable examples of brain systems in which inherently low-dimensional continuous-attractor dynamics have been concretely and rigorously identified. Thus, it is now possible to conclusively state that the brain constructs and uses such systems for computation. Finally, we highlight recent theoretical advances in understanding how the fundamental trade-offs between robustness and capacity and between structure and flexibility can be overcome by reusing and recombining the same set of modular attractors for multiple functions, so they together produce representations that are structurally constrained and robust but exhibit high capacity and are flexible.

## Introduction

One of biology’s grand challenges is to explain how order and complex function spring from inanimate physical systems composed of much simpler parts. The brain creates order in its representations of the world and performs complex functions through the collective interactions of simpler elements. In this Review, we describe and evaluate the hypothesis that attractor dynamics in widespread regions of the CNS have a key role in constructing some of these representations, generating long timescales to support integration and memory functions and endowing all these functions with robustness. We review the specific predictions of attractor-based models and the now extensive body of work testing these predictions. Thus, we illustrate that the theory and validation of computation with attractor dynamics in the brain is one of the biggest success stories in systems neuroscience.

Some of the first formal circuit-level models of brain function focused on the problem of [associative memory](https://www.nature.com/articles/s41583-022-00642-0#Glos1) and how neural circuits might generate spatially distributed, stable patterns of activity that could function as such a memory [^1] [^2] [^3] [^4]. [Hopfield networks](https://www.nature.com/articles/s41583-022-00642-0#Glos2), with multiple stable states constructed by inscribing input patterns into connection weights, were proposed more than four decades ago [^3] [^5] [^6]. Network models possessing a continuous set of stable states that could be used to represent continuous variables were also first proposed in the same period [^7]. Subsequently, many canonical brain circuits for motor control, sensory amplification and memory, motion integration, evidence integration, decision-making and spatial navigation have been modelled using the same general principle — that a set of states can be stabilized through collective [positive feedback](https://www.nature.com/articles/s41583-022-00642-0#Glos3) [^8] [^9] [^10] [^11] [^12] [^13] [^14] [^15] [^16] [^17].

Because these are circuit-level models, but were typically inspired by experimental characterization of neurons recorded singly or a few at a time, the patterns of connectivity and the cell–activity correlations in the models automatically became novel and relatively specific predictions about the population dynamics and architecture of such circuits. As we discuss below, the combination of these prediction-rich (yet conceptually simple) models, modern experimental breakthroughs in the acquisition of cellular-resolution population activity data and novel and rigorous analyses of such data on the basis of the model predictions has provided much evidence that the brain constructs and exploits attractor networks for performing several essential computations.

We begin by defining attractors, and then describe proposed mechanisms for the construction of attractor network models in neuroscience. We provide an overview of why attractor networks can be important for computation in the brain and highlight criteria for determining whether a system has non-trivial attractor dynamics. We also discuss examples of brain circuits with non-trivial attractor dynamics. We end with a summary of new directions in our understanding of how these simple circuits could contribute to flexible computation through reuse in multiple contexts.

## What are attractors?

To define an attractor, we first define a dynamical system and its states. A dynamical system is a set of variables together with all the rules that determine their changes in value with the passage of time. The value of these variables at any given instant is called the state of the system at that moment. The state is a point (vector) in the [state space](https://www.nature.com/articles/s41583-022-00642-0#Glos4) of the dynamical system. An attractor is the minimal set of states in a state space, to which all nearby states eventually flow with time [^18]. One simple example of an attractor is a stable fixed point: all neighbouring states flow to it. Transferring these crisp mathematical definitions to the context of the brain involves challenges and simplifications that revolve around identifying a sufficiently self-contained system and the variables necessary to determine its dynamics.

### Defining the state of a neural system

Inherent in the definition of a dynamical system is the assumption that there are no external dynamical inputs to the system (or, equivalently, that the system definition includes all such external variables).

The first simplification in characterizing the dynamics of a neural circuit is to assume that, at least on the timescale of interest, the system evolves in an [autonomous](https://www.nature.com/articles/s41583-022-00642-0#Glos5) way. Given that subcircuits in the brain are interconnected with others, and that the brain itself interacts with the world, it is impossible to isolate these circuits completely into autonomous systems. However, we may define a notion of ‘effectively autonomous’ dynamics, whereby inputs do not vary over time and are untuned, in the sense that they do not provide differential drive to subsets of the putative set of attractor states.

The second simplification is in defining the states of the system. The changes in state of a circuit in the brain over time may depend on the detailed pattern of all the spikes in all neurons, the levels of associated ions, neurotransmitters and modulators, and even the states of the ion channels. The weights and connections between neurons may be considered as parameters (rather than variables) on short timescales, but are themselves variables if considering a longer timescale. One widely used simplification in describing a neural circuit on the timescale of seconds is to use just the spiking outputs of the neurons in the circuit as the states, often further simplified as time-varying spike rates. If such a description is sufficient to predict the state changes of the system at the relevant timescales, it can be viewed as a reasonable dynamical system model of the circuit. Although spike or spike-rate descriptions ignore subcellular and molecular variables to make the grossly simplifying assumption that the relevant circuit dynamics are governed by spikes, the state space of a vertebrate microcircuit described in this way is nevertheless very high-dimensional, comprising the number of neurons in the circuit, which can be in the order of 10 <sup>2</sup> –10 <sup>7</sup> cells. As we discuss below, such simplified models can nevertheless yield rich and accurate predictions about neural circuits.

Attractors exist in various flavours: an attractor may consist of a single state, a set of discrete states, a set of states that effectively behave as a continuous set or many such near-continuous sets (Fig. [1](https://www.nature.com/articles/s41583-022-00642-0#Fig1)). If a set of attractor states traces out a shape in state space that is approximately continuous and locally [Euclidean](https://www.nature.com/articles/s41583-022-00642-0#Glos6), it is known as an attractor manifold. Nonlinear continuous-attractor manifolds can be curved and topologically complex (for example, resembling rings, tori and so on; Fig. [1c,d](https://www.nature.com/articles/s41583-022-00642-0#Fig1), rightmost column) [^19] [^20]. States on an attractor may be stationary, or might flow along the attractor to trace out trajectories that are periodic (known as limit cycles; Fig. [1f](https://www.nature.com/articles/s41583-022-00642-0#Fig1), rightmost column) or chaotic (that is, with dynamics that are inherently unpredictable owing to high sensitivity to small changes in the state [^21]).

![Fig. 1: Mechanisms of attractor formation.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs41583-022-00642-0/MediaObjects/41583_2022_642_Fig1_HTML.png?as=webp)

Fig. 1: Mechanisms of attractor formation.

Various combinations of such attractors, of different dimensions, geometries and topologies, may coexist in different regions of the state space of a single dynamical system. Typically, the set of attractors in a dynamical system comprises a small subset of the state space, and attractor manifolds are usually much lower-dimensional than the state space. In cases in which a system has multiple attractor states, the initial condition determines the attractor state to which the system flows.

### Attractors in the presence of noise

Any real physical system unavoidably behaves non-deterministically from the perspective of a model of the system. This is because one cannot observe and describe all variables, and all uncharacterized variables together with true stochastic sources of variation (such as synaptic signalling noise from stochastic vesicle release [^22]; fluctuations in ion concentrations during processes such as spike initiation [^23] and calcium signalling; or fluctuations in small copy numbers of proteins [^24]) serve as effective sources of noise in the model. Noise can disrupt states so they do not strictly localize to the attractor described in a noise-free version of the model, and can drive the system to escape from an attractor over time. However, the general idea of attractor states remains, in that, if the system is initialized near such a state, it tends to flow towards it and subsequently remains localized around it, for extended periods.

Because attractor states are where systems tend to localize (when not externally driven), they should be observable in the autonomous dynamics of real systems. This basic property is the basis for the most fundamental and robust tests of attractor dynamics in neural systems, as we discuss below. In a nutshell, the central signatures of attractors in real systems (discussed in more detail in later sections of this Review) can be summarized as: the localization of the states of a system to a lower-dimensional subset; the flow of the states towards the subset after perturbation; and the long-time and (effectively) autonomous stability of states in that subset.

## Construction and mechanisms

The general principle underlying the formation of [non-trivial attractor states](https://www.nature.com/articles/s41583-022-00642-0#Glos7) in neural circuits is strong recurrent positive feedback. Positive feedback fights activity decay to stabilize certain states, and has been posited [^25] [^26] [^27] [^28] to be the basis for the stabilization of memory traces and [persistent activity](https://www.nature.com/articles/s41583-022-00642-0#Glos8) in the brain. Which states become stabilized into attractors depends on how the network sculpts the positive feedback, which, according to the [synaptic hypothesis](https://www.nature.com/articles/s41583-022-00642-0#Glos9), is determined by synaptic weights [^29] [^30] [^31].

In general, characterizing the relationship between structure and function in a large collection of interacting elements is extremely difficult [^32]. For example, a large collection of simple polar three-atom molecules of hydrogen and oxygen give rise to the emergent phenomena we associate with water — such as liquidness, wetness and freezing into a solid — that cannot be predicted through intuition or by drawing box and arrow diagrams. Nevertheless, the transitions and properties of emergent states can be described relatively simply, with very few key parameters and variables.

One way to characterize the relationship between synaptic weights and attractor dynamics is to ask what attractor states a given set of weights produces (the ‘forward’ problem). With a given set of weights, one can simulate a circuit and explore the resulting dynamics to find attractors of the system. A more powerful method, the Lyapunov function approach, holds for [symmetric weight matrices](https://www.nature.com/articles/s41583-022-00642-0#Glos10) (*W* <sub><i>ij</i></sub>  =  *W* <sub><i>ji</i></sub>) and rate-based neural dynamics. For this class of models, a generalized energy function (the Lyapunov function), which is a function of the weights and neural activation function [^2] [^5] [^6], analytically specifies the network’s dynamics. Stable and unstable attractor states are the energy minima and maxima of the derived landscape, respectively, and the network’s state flows downhill towards the attractors (Fig. [2e](https://www.nature.com/articles/s41583-022-00642-0#Fig2)) in the way a ball rolls down a gravitational potential.

![Fig. 2: The utility of low-dimensional attractor networks.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs41583-022-00642-0/MediaObjects/41583_2022_642_Fig2_HTML.png?as=webp)

Fig. 2: The utility of low-dimensional attractor networks.

Another way to characterize the relationship between attractors and network structure is to consider the ‘inverse’ problem: given a set of attractors, what network structure could generate it? Neuroscientists want to solve the inverse problem to make predictions about underlying mechanisms and, because neural activations are more readily observed than synaptic weights, the inverse problem is more frequently encountered than the forward problem. By contrast, evolution, the brain and artificially intelligent systems must solve the inverse problem to be able to perform computations that require a given type of attractor dynamics (discussed below). Theoretical neuroscience has discovered some solutions to the inverse problem for different types of attractors, as we describe below.

### Discrete attractors

A well-known prescription for creating a set of discrete attractors at user-defined points is given by the Hopfield model [^5] (Fig. [1a](https://www.nature.com/articles/s41583-022-00642-0#Fig1)). Input patterns of neural activation are inscribed into the network weights through a Hebbian-like learning rule, such that co-active neurons are connected by excitatory interactions and inhibit all the rest. Thus, these patterns stabilize themselves and become attractor states. If a sufficiently small number of patterns are learned, they can be retrieved from partial or corrupted versions of the stored states, and thus the network can be said to store content-addressable memories. More generally, the attractors of simple rate-based networks with arbitrary symmetric weight matrices and without communication delays consist entirely of fixed points. Some non-symmetric networks can also support point attractors [^33], but not generically, and they can require additional mechanisms such as [homeostatic plasticity](https://www.nature.com/articles/s41583-022-00642-0#Glos11) [^34] [^35].

Attractor states in Hopfield-like networks typically have highly overlapping neural memberships, even when they are well separated in the state space (Fig. [1a](https://www.nature.com/articles/s41583-022-00642-0#Fig1), middle column). Thus, there is not a clear notion of distinct ‘cell assemblies’. In a special case of Hopfield networks, neurons are partitioned into largely disjointed groups with self-excitation within groups and inhibition between groups. In these winner-take-all (WTA) networks, the attractor states consist of largely non-overlapping active cell groups, which might then be called ‘assemblies’ (Fig. [1b](https://www.nature.com/articles/s41583-022-00642-0#Fig1)).

### Continuous attractors

How can one construct networks with a continuum of stationary attractor states? Weight matrices with a particular symmetry (across the diagonal) give rise to discrete attractors, as we have seen. If the weights instead exhibit a continuous symmetry — for example, if the weight profiles are invariant across neurons (they look the same at each neuron, thus the symmetry is translational) — then the set of formed attractors will be related by the same symmetry and could thus form a continuous set.

The general principle for the formation of stationary continuous attractors is pattern formation [^36] [^37] [^38] [^39] [^40] [^41] [^42]. Simple and spatially local competitive interactions across the neural sheet lead to the emergence of spatially structured activity patterns that are stable states: neurons with excitatory coupling between them become co-active and suppress the rest of their neighbours through inhibition in what is known as a linear Turing instability [^36].

Three conditions are generally sufficient (although not strictly necessary) to provide a solution to the inverse problem for forming stationary continuous attractors (Box [1](https://www.nature.com/articles/s41583-022-00642-0#Sec8)). First, the system must include [nonlinear neurons](https://www.nature.com/articles/s41583-022-00642-0#Glos12) with saturating responses or inhibition-dominated recurrent interactions and a uniform excitatory drive [^7] [^10] [^15] [^17] [^43] [^44] to keep network activity bounded. Second, the system must involve sufficiently strong recurrent weights with competitive dynamics in the form of local excitation or disinhibition, with broader inhibition, to drive spontaneous pattern formation through the Turing instability [^10] [^15] [^17] [^36] [^37] [^38] [^39] [^40] [^41] [^42] [^45] [^46] [^47]; these patterns become the attractor states. Last, the system requires some continuous symmetry in the weights (a continuous weight symmetry is one where as some variable is varied continuously, the weights remain invariant), such as translational or rotational invariance (Fig. [1c,d](https://www.nature.com/articles/s41583-022-00642-0#Fig1)), to ensure a continuum of attractor states.

A special set of networks generate continuous-attractor dynamics without pattern formation: those with linear, planar or hyperplanar attractors that are generated by neurons with linear or near-linear response functions. In circuits of linear neurons, the feedback within the network is a linear function of activity (*Wr*, where *W* is the weight matrix and *r* are the neural activities), as is the activity decay (given by − *r*). Such networks can stabilize non-zero activity states simply by tuning positive feedback to cancel the decay. The matrix *W* can direct feedback in state space; if feedback is directed largely along one dimension, the network can support a line attractor (Fig. [1e](https://www.nature.com/articles/s41583-022-00642-0#Fig1)). If it is directed equally along two or more dimensions, it can support a plane or hyperplane attractor. To create long-lived attractors requires that the network feedback magnitude is finely tuned to precisely cancel the decay [^9] [^48], in contrast to pattern-forming continuous-attractor systems where the weight shapes (but not magnitudes) are tuned to maintain continuous symmetry across neurons.

### Non-stationary continuous attractors

Large non-symmetric networks with nonlinear neurons and strong connectivity generically exhibit limit-cycle attractors or chaotic dynamics [^49] [^50]. Just as point attractors emerge generically in large networks with strong symmetric weights and bounded state spaces, chaotic attractors emerge generically in large recurrent networks with strong asymmetric weights. Adequate asymmetries are easily achieved if excitatory and inhibitory synapses emerge from distinct sets of neurons [^49], as biologically necessitated by Dale’s law.

Despite the complexity of chaotic dynamics, chaotic attractors are also highly structured in that they typically exist in a relatively low number of dimensions compared with the number of neurons in the network [^51]. Non-symmetric networks that are dominated by inhibition exhibit a single attractor at zero activity, although the flow towards the attractor in response to perturbations can involve large transients in neural activation that temporarily move the state further away from the attractor [^52] [^53].

## Attractors for neural computation

A system could theoretically be perfectly tuned such that every point in state space is a neutrally stable attractor, and thus the system has maximally high-dimensional attractor dynamics. However, because the robustness of attractor networks is related to the low-dimensionality of the attractor states (as discussed below), the system would lose most of its interesting computational properties: error correction or noise tolerance, [nearest-neighbour computation](https://www.nature.com/articles/s41583-022-00642-0#Glos13), pattern completion and content-addressable memory. It could perform integration, but with no robustness to noise. As such, networks with low-dimensional attractor dynamics exhibit myriad properties that can be vital for computation in the brain These include robust representation, memory, sequence generation, integration, and robust classification and decision-making — ideas that have been extensively explored in the literature. In a later section, we describe how, although attractor dynamics may be rigid and invariant as needed for the roles listed above, recent theoretical and experimental findings are beginning to reveal how these rigid constructions may also be exploited to perform flexible computation through reuse and recombination across tasks.

### Representation and memory

A representation of a set of inputs means the assignment of inputs to representational states (not necessarily on a one-to-one basis), with the ability to reproducibly retrieve those states (‘labels’) when cued. Attractor networks provide a stable internal set of states that can be used for reproducible representation of discrete or analogue variables, by mapping states in the world to the attractor states. One way to achieve this mapping is through a feedforward learning process that associates each external state with an internal attractor state (Fig. [2a](https://www.nature.com/articles/s41583-022-00642-0#Fig2)).

An attractor network can exhibit two kinds of memory. The first is in the structure of the weights, which specify the set of all attractors. If these weights are specified through an input-driven learning process, this is a form of long-term memory about the inputs. The second kind of memory is the ability to maintain persistent activity in a stationary attractor state: if a system with multiple stationary attractor states is initialized in one of them, it will tend to remain at or near the same state for some time. In other words, the activation levels of the neurons contributing to that state persist while the system remains in the state. This persistent activity response is thus a form of short-term memory of the input that initialized the circuit. If these persistent memory states can be activated without an explicit address, using just the content (or partial content) of the memory, they are content-addressable.

The short-term memory function of attractors depends on the prior formation of stable states through long-term plasticity. For instance, in Hopfield-like networks, states cannot persist if they were not first trained to be attractor states. Even models of short-term memory that are based on [presynaptic facilitation](https://www.nature.com/articles/s41583-022-00642-0#Glos14), rather than persistent activity, rely implicitly on prior long-term associative plasticity to construct recurrently stabilized neural ensembles that can be reinstated by random inputs [^54]. (Additionally, these models are not activity-silent in the delay period, in the sense that they would require ongoing activity to refresh the facilitation state over longer delays and to generate robustness against random background activity that would facilitate different synapses.) In other words, these presynaptic facilitation models cannot explain short-term memory for entirely novel inputs; however, combinations of attractors could enable more flexible short-term memory, as we discuss later.

### De-noising representations and memories

If representational states are attractors, then the representations are robust in the sense that they perform de-noising: if the input cues or initial conditions reflect noisy or corrupted versions of an attractor state, the dynamics drive the state to a point on the representational attractor (Fig. [2b](https://www.nature.com/articles/s41583-022-00642-0#Fig2), inset). When attractors form a continuous manifold of dimension $K\ll N$, where *N* is the number of neurons in the circuit, all noise in *N* – *K* dimensions is erased. A noise ball of unit radius in *N* dimensions (corresponding to random independent noise per neuron) has a projection of size only ~ $\sqrt{K/N}\ll 1$ along *K* dimensions. If *K* is low-dimensional, as is often the case, and *N* ranges from 10 <sup>2</sup> to 10 <sup>7</sup> as estimated before for common microcircuits, this constitutes a massive reduction in the sensitivity of the state to internal or input noise (Fig. [2b](https://www.nature.com/articles/s41583-022-00642-0#Fig2)). Thus, most noise is rendered impotent by attractor dynamics.

De-noising owing to attractor dynamics is especially important for memory maintenance as, otherwise, noise-induced deviations would accumulate and grow over time. Discrete attractors continually erase all noise by mapping perturbed states back to the point attractor, resulting in zero drift. With continuous attractors as memory states, all noise orthogonal to the manifold is corrected; thus, there is a net reduction of the effects of noise by the factor $\sim \sqrt{K\,/\,N}\ll 1$ (refs.[^45] [^55]). However, all states on the attractor manifold are neutrally stable, so the state can drift along the attractor. As such, components of noise along the *K* attractor dimensions are not internally corrected and cause an accumulating drift away from the initial state, with variance proportional to *KT* / *N*, where *T* is the elapsed time [^15] [^45] [^55] [^56]. Thus, through the 1/ *N* decrease in variance, even continuous memory states can be well stabilized in sufficiently large attractor networks.

Although content-addressable long-term memory and error reduction can be instantiated through feedforward computations involving only a few steps [^57] [^58] [^59] in place of attractor dynamics, recurrent attractor dynamics are indispensable for the generation of persistent activity states (and thus for short-term memory through persistent activity [^60] [^61]) and integration, as we discuss below.

### Robust classification

When there are finitely many separated attractors (each a discrete attractor or a continuous manifold), states that are not initially on one of the attractors will flow to one of the attractors. An input to the network can then be classified according to the attractor to which the network state flows after initialization by the input. We can now identify inputs based on the attractors they flow to, a mechanism of classification. If the dynamics of the network further correctly assign corrupted versions of an input to the same attractor state as the uncorrupted input, this constitutes robust classification. In other words, the dynamical basins of attraction of the network must align with the Voronoi regions of the attractor states (that is, corrupted inputs that are closest in distance to one of the uncorrupted inputs should flow to that input’s attractor through the dynamics and not another). This is approximately the case for attractor networks operating well below capacity, but typically deteriorates when attractor networks are pushed towards their capacity [^62].

### Integration

Single neurons integrate their inputs, but usually can only do this over the timescales associated with their membrane capacitances, typically 10–100 ms. Continuous-attractor dynamics can enable neural circuits to integrate over much longer timescales (in the order of about 1–100 s).

A pattern-forming continuous-attractor network requires an additional mechanism to gain the functionality of an integrator: a way to shift the internal state along the attractor in response to an input that encodes changes in the external variable (Fig. [2d](https://www.nature.com/articles/s41583-022-00642-0#Fig2), left). Conceptually, the simplest way to build a shift mechanism is by a copy-and-offset construction: construct multiple copies or subpopulations of the attractor network, each with slightly offset (asymmetric) weights in the sense that active neurons centre their excitation or point of maximal disinhibition slightly offset from themselves on the neural sheet (for example, see that the network in Fig. [1g](https://www.nature.com/articles/s41583-022-00642-0#Fig1) is a slightly asymmetric version of the network in Fig. [1c](https://www.nature.com/articles/s41583-022-00642-0#Fig1)). The states in each such network will then form a limit-cycle attractor, with patterns of activity flowing in the direction of the asymmetry in each copy. If opposing copies are coupled together, the pattern is stabilized through a push–pull balance. A velocity input whose components project differentially to the copies will break the push–pull balance, driving the pattern along the flow direction of the more active copy (Fig. [1g](https://www.nature.com/articles/s41583-022-00642-0#Fig1)). Thus, the total direction and magnitude of the shift of the pattern, corresponding to movement along the attractor manifold, represents the time integral of the velocity input to the network. This common principle unifies the mechanisms across diverse integrator models [^12] [^13] [^15] [^63] [^64].

### Decision-making

If, instead of a velocity signal, the input to an integrator network consisted of temporally varying positive and negative evidence in support of each of two options [^65] (Fig. [2d](https://www.nature.com/articles/s41583-022-00642-0#Fig2), right) (or in the case of multiple options, evidence vectors instead of velocity vectors [^66]), the network would integrate those inputs and thus perform evidence accumulation.

Decision-making can be viewed as a selection process applied to an integrator that is based on a readout that detects when the integrator state has accumulated enough evidence and moved past a decision threshold [^56] [^67]. The selection process can be external to the integrator, in the form of a readout circuit that detects such threshold crossings and outputs the decision. Alternatively, the selection process can be built into the dynamics of the integrator itself, in the form of a more complex attractor landscape, in which the states move along a continuous attractor but, at some point, the continuous attractor gives way to a pair of discrete attractors, towards which the states flow (Fig. [2e](https://www.nature.com/articles/s41583-022-00642-0#Fig2)). Neural WTA models implement such a hybrid analogue–discrete computation [^16] [^65] [^66] [^68] [^69] [^70]. The parameters of WTA networks determine the balance between integration dynamics and competitive dynamics, and thus how well the network integrates later evidence: when the network is tuned to be a perfect integrator, its response to inputs is gradual, and small amounts of evidence cause (reversible) flow along the continuous-attractor manifold. In cases in which competition dominates, the response to evidence is a fast flow towards one of the discrete attractors; beyond a point, the flow is nearly irreversible, leading to rapid decision-making and the discounting of later evidence [^71].

Neural WTA networks can leverage specific neural non-linearities to accurately and rapidly (in ∼log(*N*) time) make the best decision among *N* alternatives, even if the presented data are noisy (fluctuating over time around their means) [^66] [^70] and even if the number of options varies over orders of magnitude [^66].

### Sequence generation

Attractor dynamics can be important for stabilizing another long-timescale behaviour: the generation of sequences. Robust sequences can be constructed as low-dimensional limit-cycle attractors, in which high-dimensional perturbations are corrected while along the attractor, there is a systematic, periodic or quasiperiodic flow of states [^72] [^73] [^74] [^75] [^76]. The attractor property that affords ongoing de-noising is important for preventing spatial dispersion and temporal dissipation of the activity packet during sequence generation.

Similar to the case for stationary attractor manifolds, the small components of noise along the limit-cycle attractors are not correctable and lead to a gradual accumulation of drift, which for sequence generation is manifest as timing variability: the standard deviation in the time of reaching the *T* th state in the sequence is predicted to grow as $\sqrt{T}$ for unbiased random drift along the attractor [^45].

## Evidence of attractors in the brain

### Criteria for attractor dynamics

The fundamental predictions of attractor models centre on the state-space dynamics of the circuit, as initially explicitly discussed and tested in refs.[^9] [^15] [^77] [^78]. First, a system’s states should be found localized at or around a low-dimensional set of states that correspond to the attractors in the state space. Second, a system’s state should flow quickly back to the low-dimensional state after perturbation. Third, the set of attractor states — quantified either by direct characterization of the full state space or by the relationships between cells — should be invariant, persisting over time and after removal of tuned input, across conditions, across behavioural states and even when there are induced variations in the mapping from internal states to external inputs [^15] [^77] [^78]. Fourth, integrator networks should further exhibit the property of isometry, whereby lengths of coding space along a dimension are allocated to equal displacements along a dimension of the external variable. Additional predictions of attractor dynamics models, that are not as fundamental in the sense that they are not theoretically necessary or sufficient but are nevertheless of high importance because they are highly supportive of the mechanisms of attractor dynamics, are anatomical and structural correlates: the existence of low-dimensional physical structures and directly visible symmetries in connectivity between cells.

As we have seen, attractor networks dynamics need not be used by the brain in an autonomous setting: inputs that drive attractor networks can be an important part of their function, for instance in integration and evidence accumulation. Nevertheless, because attractor systems are characterized by their internally generated or autonomous dynamics, putative attractor networks are best tested in conditions that minimize external cues that are time-varying or tuned to provide localized inputs along the putative attractor — that is, in an effectively autonomous setting.

Innovations in recording methods that have made it possible to record multiple neurons simultaneously in animals performing naturalistic behaviours [^79] [^80] [^81] [^82] have enabled crucial tests of these state-space predictions of attractor models described above. The newest methods provide activity data from thousands of neurons in a circuit [^83] [^84] [^85], enabling characterization of the low-dimensional state-space dynamics of whole circuits [^19] [^20] [^86] [^87] [^88].

When the attractor manifolds have three or fewer dimensions, one can directly visualize them by projecting or embedding the high-dimensional state spaces into dimension ≤3. This can be done using methods such as principle components analysis, multidimensional scaling, tensor factorization or other linear methods for projection; or Isomap, locally linear embedding, *t* -distributed stochastic neighbour embedding, variational autoencoders, latent factor analysis via dynamical systems and nonlinear tensor factorization, among others, for nonlinear embedding [^89] [^90] [^91] [^92]. These methods can also be useful when manifolds have dimension ≥3 but are topologically simple [^88] [^93]. For topologically non-trivial structures (such as rings and tori), especially those of dimension ≥3, topological data analysis methods become important [^19] [^20] [^94] [^95] [^96] [^97] [^98].

Testing the first, second and third predictions of attractor models described above requires examination of the state-space structure of the population, rather than the more conventional characterization of relationships (tuning curves) between cell activity and input or output variables. The most direct way to examine state-space structure is to record enough cells simultaneously that it is possible to characterize the full state-space manifold [^19] [^20] [^97]. However, the existence, stability and invariance of low-dimensional state-space structures (the first three predictions) can be inferred indirectly from smaller samples of simultaneously recorded cells, for example by characterizing invariant structure in pairwise cell–cell relationships, as has been successfully done in several studies [^77] [^78] [^99] [^100] [^101] [^102].

The existence and stability of low-dimensional state-space structures are necessary but not sufficient for identification of recurrent attractor dynamics in a target network. First, if the behaviours, circuit fluctuations and inputs to the network are themselves low-dimensional, then any observed low-dimensionality of the circuit states may be ascribed to those inputs and reveals little about intrinsic constraints imposed by the circuit. Second, even if inputs and behaviours are high-dimensional, a low-dimensional feedforward projection into the target network would generate low-dimensional states, and high-dimensional perturbations to the circuit would not persist. The essential, defining prediction of attractor dynamics is that of invariance: because the states are internally generated and stabilized by strong recurrent connectivity, the population states and cell–cell relationships should be invariant when probed across time and across various input conditions, including when tuned input is removed and across waking and sleep. In simple terms, the stable low-dimensional states should be invariant across a broad range of conditions [^15] [^78].

Next is the question of circuit localization: does a circuit exhibiting the key signatures of attractor dynamics give rise to these dynamics, or are they a readout of some other region? Localization need not be a primary goal of establishing attractor dynamics: an important problem is to simply characterize whether the brain solves certain problems through attractor dynamics, regardless of which local circuits create these dynamics. Nevertheless, the persistence of activity states in attractors can lend a helping hand to localization efforts. If a region gives rise to or is upstream (but not downstream) of the attractor dynamics, perturbations that alter its state along the set of attractors should persist after the perturbing drive is removed [^103].

As we describe next, theoretically motivated analyses of population activity data have firmly established that low-dimensional attractor dynamics are ubiquitous in the brain, across levels in the brain’s hierarchy and across species.

### Discrete attractors

#### Up and down states

The simplest example of non-trivial discrete attractor dynamics (that is, beyond a single point attractor) is bistability. Bistable dynamics are a feature of cortical activity in the form of up and down states [^4] [^104] [^105] [^106] [^107] [^108], in which the subthreshold membrane potential of neurons switches between a hyperpolarized state and a relatively depolarized one, with long persistence (in the order of hundreds of milliseconds to seconds) per state (Fig. [3a](https://www.nature.com/articles/s41583-022-00642-0#Fig3)). The two states are relatively invariant over time, as seen in the relatively sharply peaked histograms (Fig. [3a](https://www.nature.com/articles/s41583-022-00642-0#Fig3)), and despite presumed internal noise in the system the peaks are well separated, suggesting relatively rapid corrective dynamics towards the two states. There is little evidence of a strong contribution from cellular bistability in supporting these states, suggesting that it is a network-driven phenomenon involving self-excitation and global inhibition [^4] [^104] [^105] [^107] [^108] [^109] [^110] [^111]. Transitions are believed to be driven through adaptation (from up to down) and by stochastic as well as external coordinating events (from down to up) [^106]. Although these states and switches can occur in the cortex without input from the thalamus and striatum, they tend to be synchronous across the cortex and striatum [^112] [^113]. Thus, the origin of up and down states may be highly distributed.

![Fig. 3: Evidence of discrete attractor dynamics in the brain.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs41583-022-00642-0/MediaObjects/41583_2022_642_Fig3_HTML.png?as=webp)

Fig. 3: Evidence of discrete attractor dynamics in the brain.

#### Perceptual bistability

Visual and auditory percepts including binocular rivalry, the Necker cube and some auditory illusions [^114] [^115] [^116] [^117] [^118] [^119] [^120] offer clear examples of bistability in neural processing, suggesting the operation of a dynamical system with two attractors. In these illusions, the brain (at the level of perceptual reports) selects one possible interpretation of an ambiguous input, often switching between possibilities. Although the phenomenon has long been known and studied, no localized bistable attractor circuit has been identified as the basis of perceptual bistability. Indeed, some percepts may involve top-down activation and modulation of activity across many brain areas [^118], suggesting once again a widely distributed circuit for bistability.

#### Bistability in a premotor area

Recent studies identify and localize discrete attractor dynamics in a mouse premotor area, the anterior lateral motor cortex (ALM) [^121] [^122] [^123] [^124]. In a cued two-alternative delayed response task, ALM neurons exhibit persistent activity over a 1-s delay period. During the post-cue delay period, activity evolves towards one of two states that guide the response (Fig. [3b](https://www.nature.com/articles/s41583-022-00642-0#Fig3)), fulfilling the first prediction of attractor dynamics. The delay-period terminal states are similar for cues from different sensory modalities [^125], partially meeting the prediction of invariance. ALM perturbations during the delay are either erased (corrected) by the circuit (Fig. [3b](https://www.nature.com/articles/s41583-022-00642-0#Fig3), top) or drive a jump to the opposite state (Fig. [3b](https://www.nature.com/articles/s41583-022-00642-0#Fig3), bottom), which results in the animal making the wrong action, suggesting bistable switching dynamics similar to the mechanism shown in either Fig. [1b](https://www.nature.com/articles/s41583-022-00642-0#Fig1) or Fig. [2e](https://www.nature.com/articles/s41583-022-00642-0#Fig2).

Given the long training time required for the task and the resulting tailoring of the ALM dynamics to the specific task structure — bistability for a two-choice task — it is likely that this system acquires its dynamics through slow plasticity and, thus, that the network’s recurrent structure is malleable in adult animals. New results showing the existence of small (on the scale of about 100 μm) clusters of locally recurrent neurons in the ALM that can maintain persistent responses to microstimulation [^126] may provide experimental evidence of the theoretically posited mixed modular networks (below) that are hypothesized to support robust and high-capacity memory states [^62].

#### Discrete multistability

Hopfield networks and WTA networks [^69] [^127] [^128] [^129] [^130] [^131] [^132] [^133] [^134] (which can be viewed as a special type of Hopfield network, with bistable switch networks as a special type of WTA network) are models of multistability beyond bistability.

At present, the evidence for discrete multistability as a circuit-level brain process is less direct and less exhaustive than that for continuous-attractor networks (described below). However, there are many likely candidate systems and brain regions with dynamics that are suggestive of and consistent with discrete multistability, at least of the special case of WTA attractor dynamics — including in the mammalian hippocampus and auditory cortex, and in the fly and mammalian olfactory system [^132] [^133] [^134] [^135] [^136] [^137]. In particular, many of these circuits exhibit global inhibition that clearly narrows and refines activity in the circuit (Fig. [3c](https://www.nature.com/articles/s41583-022-00642-0#Fig3), left), and also show evidence of selective recurrent excitation that leads to multiple distinct and stably correlated input responses in distinct subpopulations of cells (Fig. [3c](https://www.nature.com/articles/s41583-022-00642-0#Fig3), middle and right) [^132] [^133] [^134] [^135] [^136] [^137]. In our view, it is likely that these circuits exhibit multiple discrete attractor states, but quantitative testing of the first three predictions of attractor dynamics and direct demonstration of these states as stable and invariant remain an important future direction for characterizing these circuits.

### Continuous attractors

#### The oculomotor integrator

The oculomotor integrator, together with the head-direction circuit, was one of the first systems in neuroscience to be studied theoretically [^8] [^9] [^138] and experimentally [^139] as a continuous-attractor network — specifically as a line attractor (Fig. [1e](https://www.nature.com/articles/s41583-022-00642-0#Fig1)). This network, which is presynaptic to the motor neurons that control horizontal eye position, is highly conserved across vertebrates, from fish [^139] [^140] to primates [^141] [^142]. It integrates pulse-like saccadic eye movement-command signals to generate step-like stable muscle tension command signals (Fig. [4a](https://www.nature.com/articles/s41583-022-00642-0#Fig4)) that persist autonomously at graded activity levels after removal of the movement cue and even in the dark in the absence of visual feedback (Fig. [4b](https://www.nature.com/articles/s41583-022-00642-0#Fig4); third prediction), and thus enable stable gaze fixation at various degrees of [eccentricity](https://www.nature.com/articles/s41583-022-00642-0#Glos15). Saccadic inputs knock the system slightly off the linear response states, but the neural responses rapidly decay back towards the persistent firing states (in line with the second prediction). Remarkably, the same system also integrates smooth head-velocity signals to permit gaze stabilization during head movement.

![Fig. 4: Linear attractor dynamics generated by network feedback in the oculomotor integrator.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs41583-022-00642-0/MediaObjects/41583_2022_642_Fig4_HTML.png?as=webp)

Fig. 4: Linear attractor dynamics generated by network feedback in the oculomotor integrator.

Integration functionality is a network-level rather than single-cell process: single neurons do not generate persistent responses to transient current injections (Fig. [4c](https://www.nature.com/articles/s41583-022-00642-0#Fig4), inset), whereas decreasing network feedback through the use of synaptic blockers reduces the time constant of integration and results in a leaky integrator [^143] (Fig. [4c](https://www.nature.com/articles/s41583-022-00642-0#Fig4)). It is possible to reduce or increase network feedback through training with a virtual surround that generates an artificial retinal-slip percept (Fig. [4d](https://www.nature.com/articles/s41583-022-00642-0#Fig4)), implying that the system is capable of error-driven fine-tuning to maintain a high degree of persistence [^144]. Finally, a recent electron microscopy reconstruction [^145] [^146] finds recurrent synaptic interconnectivity between integrator neurons, with excitatory connections between ipsilateral neurons and primarily inhibitory contralateral projections, in excellent agreement with line-attractor models of the oculomotor circuit [^9] (Fig. [1e](https://www.nature.com/articles/s41583-022-00642-0#Fig1)).

#### Head-direction cells

Some of the earliest experiments to suggest the existence of low-dimensional continuous-attractor dynamics were done in the rodent head-direction circuit [^77] [^99] [^147] (Fig. [5a,b](https://www.nature.com/articles/s41583-022-00642-0#Fig5)). The head-direction circuit in mammals maintains an updated internal compass estimate of the heading direction, relative to some arbitrary external reference, as animals move around. It does so by integrating internal rotational velocity estimates during navigation and incorporating information from external cues [^148] [^149] [^150] [^151] [^152]. The head-direction circuit is modelled as a ring-attractor network [^10] [^12] [^13] [^17] [^64] (Fig. [1c,g](https://www.nature.com/articles/s41583-022-00642-0#Fig1), left). Before large population recordings became available, cell–cell correlations established that the network states remained invariant on a very low-dimensional manifold across environments [^77] [^99] [^147] (Fig. [5a](https://www.nature.com/articles/s41583-022-00642-0#Fig5)), in line with the first and third predictions. The complete set of states of the several thousand-neuron mammalian head-direction network was shown to consist solely of a one-dimensional ring [^19] [^97] (Fig. [5b](https://www.nature.com/articles/s41583-022-00642-0#Fig5)) (in line with the first prediction), revealing that the brain has completely factorized its navigational representations to dedicate a circuit only to head direction. Furthermore, intervals in the state-space ring manifold map isometrically to intervals of head direction (in line with the fourth prediction), as evidenced by a close match between the isometrically parameterized internal ring states and the measured head direction (Fig. [5b](https://www.nature.com/articles/s41583-022-00642-0#Fig5), inset and right).

![Fig. 5: The head-direction circuit: a ring attractor in the brain.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs41583-022-00642-0/MediaObjects/41583_2022_642_Fig5_HTML.png?as=webp)

Fig. 5: The head-direction circuit: a ring attractor in the brain.

After natural perturbations away from the ring attractor, the activity of the head-direction circuit flowed back to it [^19] (Fig. [5d](https://www.nature.com/articles/s41583-022-00642-0#Fig5)), meeting the second prediction, and the ring manifold was invariant across waking and rapid eye movement (REM) sleep [^19] [^97] (Fig. [5e](https://www.nature.com/articles/s41583-022-00642-0#Fig5)), meeting the third prediction. These findings explicitly validate the most fundamental predictions of ring attractor models and continuous attractor-based integrators, providing (together with the grid cell system; see below) the most direct and compelling evidence of continuous-attractor dynamics in the brain.

In a striking example of convergent evolution [^151] [^153], *Drosophila* compute head-direction estimates using apparently very similar dynamics to mammals [^148] [^152] [^154] [^155]. The fly neural compass circuit is topographically organized such that the neuropil forms a physical ring-shaped structure in the ellipsoid body, with a local moving activity peak that tracks head direction as the fly turns (Fig. [5f](https://www.nature.com/articles/s41583-022-00642-0#Fig5)). Other notable advantages of the fly circuit in the effort to characterize its mechanisms are that the number of neurons is small and their morphology and connectivity have been fully traced [^156] (Fig. [5g](https://www.nature.com/articles/s41583-022-00642-0#Fig5)). This detailed view of the circuit permits quantitative, not just qualitative, comparisons with ring-attractor models.

The combined activity and connectivity data reveal that the fly head-direction system quite literally implements the copy-and-offset double-ring network architecture that has been proposed for velocity integration [^13] [^157]. However, the dimensionality of the fly head-direction circuit and its full state-space dynamics remain to be characterized. Notably, although the circuit is organized physically as a ring network, recent evidence suggests that the insect head-direction circuit may be involved in performing two-dimensional path integration as well [^158] [^159]. Thus, unlike the anterodorsal thalamic nucleus network in mammals, the insect head-direction circuit may not be confined to a one-dimensional ring of attractor states that fully factorizes out the representation of head direction in its representation of spatial variables.

Finally, the head-direction system of both insects and mammals can be re-anchored and reset based on tuned external cues [^148] [^152] [^160], and this can change the orientation tuning curves of cells and moment by moment firing rates of cells in a way that remains consistent with the third prediction for attractor dynamics.

#### Grid cells

A grid cell encodes spatial location through a periodic triangular-lattice discharge pattern that tiles explored two-dimensional spaces [^161]. Grid cell phases update during movement in the light and in the dark [^161] to reflect the animal’s current position, as a two-dimensional phase. Continuous-attractor models of grid cells are based on collective [Turing pattern formation](https://www.nature.com/articles/s41583-022-00642-0#Glos16) [^15] [^162] [^163], explain their velocity integration function and predict that grid cells should exist in large sets with identical spatial periodicity and orientation, but tile all possible two-dimensional phases. As with the first general prediction of continuous-attractor models, they specifically predict that the population states of such a set of cells should be confined to merely two dimensions along a torus-shaped manifold that remains unchanged across environments and behavioural states [^15] (Fig. [1d](https://www.nature.com/articles/s41583-022-00642-0#Fig1), rightmost column).

Analyses of simultaneously recorded grid cells with similar periods revealed that their periods and orientations are identical down to estimation noise (thus defining a discrete population, subsequently called a ‘module’ [^164]) and that they tile all possible two-dimensional phases [^78] [^165], strongly suggesting a two-dimensional torus in line with the first prediction. Moreover, the relative firing phases and grid parameter ratios of co-modular cells are tightly conserved even as the spatial tuning of cells varies across time and environments [^78] (Fig. [6a](https://www.nature.com/articles/s41583-022-00642-0#Fig6)), with the dimensionality of the spatial environment [^166] (Fig. [6b](https://www.nature.com/articles/s41583-022-00642-0#Fig6)) and with large environmental rescaling-driven deformations of grid tuning [^78], confirming the prediction of invariance. In addition, the detailed cell–cell relationships seen in waking exploration that define the low-dimensional response of a grid module are conserved across overnight sleep in grid cells but not in place cells [^101] [^102] (Fig. [6c](https://www.nature.com/articles/s41583-022-00642-0#Fig6)), establishing that the low-dimensional states are autonomously generated. In line with all of the fundamental predictions of continuous-attractor dynamics [^15], these findings established that each grid module’s response is very low-dimensional; is invariant across environments, time and behavioural states; and is internally stabilized and autonomously generated. Most recently, these findings were confirmed by large-scale recordings of grid cells that made it possible to directly characterize the grid cell population response by applying the topological analyses of state-space structure pioneered earlier [^19] [^97] to grid cells (Fig. [6e](https://www.nature.com/articles/s41583-022-00642-0#Fig6)), directly illustrating the low-dimensional, toroidal and invariant state-space structure of grid cell modules [^20].

![Fig. 6: Two-dimensional toroidal attractors in the grid cell system.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs41583-022-00642-0/MediaObjects/41583_2022_642_Fig6_HTML.png?as=webp)

Fig. 6: Two-dimensional toroidal attractors in the grid cell system.

A corollary is that the grid cell response is not derived from upstream place cells, which remap across environments and during sleep (Fig. [6c](https://www.nature.com/articles/s41583-022-00642-0#Fig6)): as shown in ref.[^101], this finding renders models in which the place cell response is primary to grid cells [^167] [^168] [^169] inconsistent with the data. Another corollary of the population states of grid cells remaining strictly preserved [^20] [^78] [^170], even when their spatial tuning curves in two-dimensional and three-dimensional environments are altered so they do not form equilateral triangular grids [^170] [^171] [^172] [^173] [^174] [^175] [^176], is that these variations must result from changes in how the invariant internal states are mapped to external states. Such changes may arise from, for example, alterations in velocity estimation [^15] [^78] that stretch the grid or from external cues that shift the phase of the grid cell network [^177] [^178] [^179] [^180], rather than because of alterations in the internal grid network dynamics.

Despite having periodic representations, and thus each only representing position as an ambiguous two-dimensional phase, collectively grid cells form a discrete set of modules with distinct but similar periodicities [^164]. This allows grid cells to unambiguously represent position over a scale that grows exponentially in the number of grid modules [^131] [^181].

In sum, the head-direction cell and grid cell systems show that the same pattern formation principle — based on local excitation or disinhibition, with broader inhibition — that is pivotal for morphogenesis in plants and animals [^38] is also fundamental to the genesis of stationary continuous-attractor states for computation and representation in the brain.

#### Graded working memory networks

In monkeys trained to saccade to a remembered cued location (selected from a set arranged in a circle), cells in the prefrontal cortex and posterior parietal cortex exhibit persistent activity across the delay period that is selective for the direction of the cue, consistent with the first and third predictions of attractor dynamics [^182] [^183]. The delay period activity in the prefrontal cortex is a bump that moves apparently randomly along a one-dimensional manifold with the characteristics of a diffusion process [^87]. Thus, the variance in bump location grows linearly with time during the delay, as predicted by continuous-attractor models [^15] [^19] [^55], but the bump profile remains largely invariant (first and second predictions). Bump movement predicts subsequent behavioural errors [^87], suggesting that these states are repositories or read-outs of the memory.

The need for extensive training and the resulting tailoring of the attractor states to this specific but not naturally encountered multi-cue task suggests that this attractor forms through learning in a flexible system. We might therefore also expect a loss of the neural correlation structure if the animal is subsequently trained on other tasks, unlike with the grid and head-direction cell networks.

### Limit-cycle attractors

The CNS and peripheral nervous system contain numerous instances of periodic dynamics, from the spiking of single neurons [^184] [^185] to circadian rhythms and sleep-cycle generation [^186], to rhythmic activity in motor circuits. The amplitude of a linear oscillator is set by the initial condition (for example, the height at which a pendulum is released), whereas limit-cycle oscillators have an invariant intrinsic amplitude. Thus, oscillations that decay or whose long-term amplitude or frequency changes after transient perturbation are not limit cycles.

Many of the oscillations noted above maintain their amplitude over time and, given their robustness, are probably generated through attractor dynamics. Experimentally well-characterized examples of sustained periodic dynamics are central pattern generators in spinal motor circuits that drive swimming, crawling, walking, breathing and digestion; these differ in specifics across species but have common principles of mechanism and operation, including high robustness [^187] [^188]. Central pattern generator circuits typically integrate external feedback, but can operate in isolation without external drive [^189]. However, driven (non-autonomous) systems could exhibit limit cycles that are attributable to their inputs rather than to intrinsic attractor dynamics [^190].

Given the sizeable literature on these topics, we refer the reader to some excellent papers and reviews [^186] [^191] [^192] [^193] [^194] [^195].

## Departures from attractor dynamics

Not all circuits hypothesized to exhibit low-dimensional attractor dynamics seem under further experimentation to do so, or currently lack sufficient evidence to establish such dynamics in the circuit. We discuss three such examples.

### Orientation tuning in visual cortex

The circuit of [simple cells](https://www.nature.com/articles/s41583-022-00642-0#Glos17) in the primary visual cortex (V1) satisfies some key properties of attractor networks [^10]: V1 and V2 cells exhibit orientation-tuned responses to real and illusory edges [^196] [^197] [^198], and in V1 the activity of neurons with similar orientation tuning is correlated during spontaneous activity [^199]. However, changing the state of an attractor requires strong inputs and is slow [^200] [^201], inconsistent with the need for perceptual systems to respond sensitively and rapidly [^202]. Moreover, the responses to illusory edges in V1 tend to occur at longer latency than responses to real edges, suggestive of top-down inputs rather than within-V1 dynamics. These observations lend weight to the possibility that responses might be dominated by feedforward drive [^196] [^203], potentially with non-normal amplification processes [^52] [^204]. Quantitative characterizations of response speed will be important to draw clear conclusions about V1 circuit dynamics.

### Place cells

Place cells form stable representations of space [^205] that can persist in the dark [^206] and shortly after the animal has fallen asleep [^207] [^208]. In any particular environment, the population response lies on a low-dimensional manifold in state space [^88]. Accordingly, the place cell circuit has been modelled as a continuous-attractor network [^209] with one or multiple overlapping maps [^210], whereby each map is a different assignment of cells to spatial locations. However, the storage of multiple high-resolution maps in a homogeneous attractor network severely limits capacity [^181] [^211] [^212] [^213]. Cell–cell correlations are not preserved across environments, as implied by the phenomenon of remapping [^101] [^102] [^207] [^214] [^215]. Similar to V1 neurons, place cells might be better described as deriving their tuning by forming conjunctions between multiple feedforward inputs, including those from grid cells and cells that encode external cues such as borders, landmarks and reward sites [^59] [^131] [^213] [^216] [^217] [^218]. At the same time, place cells exhibit sequential activation of previous trajectories during activity [hippocampal replay](https://www.nature.com/articles/s41583-022-00642-0#Glos18) [^208] [^219] [^220] [^221]. This sequential activation is hypothesized to be generated by recurrent connections in hippocampal area CA3, suggesting that recurrent and feedforward dynamics may collaborate in the generation of place cell states; more recent models are beginning to capture this interplay [^59] [^218] [^222]. Closing the book on the question of autonomous low-dimensional dynamics in what, in our view, is the far more complex response of place cells than grid cells requires more detailed experimentation, analysis and modelling.

### Motor cortical trajectories

Finally, recordings of motor cortical activity during stereotyped arm movements in primates reveal the existence of stable low-dimensional trajectories [^86] [^223] [^224] [^225] [^226], similar to the trajectories in state space that were originally characterized in olfactory circuit responses to different odours [^227]. Limit cycles and other low-dimensional attractors have been hypothesized to have a key role in cortical movement generation [^228] [^229]. The behaviours typically performed during these neural recordings are themselves restricted to be stereotyped and low-dimensional, and thus it remains unclear whether activity would remain equally low-dimensional across richer behaviours (for example, over the set of all possible arm movements). Recent evidence from perturbation experiments [^190] suggests that neural trajectories in the motor cortex during skilled movements are driven by input from the thalamus, and thus that the circuits for motor pattern generation in the CNS might be distributed across multiple brain regions. Characterizing the intrinsic dimensionality of motor cortical activity, and determining whether the command to make more-complex motions involves multiple upstream or distributed primitive attractors, remain important open questions for both clinical brain–machine interfaces and neuroscience.

## Flexibility despite rigidity

The attractor networks we have described in this Review are typically rigid across time and conditions. However, recent experimental and theoretical work has suggested that low-dimensional and rigid attractor states could be reused and recombined to create versatile and efficient systems for representation and computation in new situations.

Building a representation (Fig. [2a](https://www.nature.com/articles/s41583-022-00642-0#Fig2)) could proceed by painstakingly constructing a large set of associative feedforward correspondences, equivalent to a look-up table. By contrast, an attractor that is an integrator requires only two feedforward correspondences: an anchoring process that identifies one external state to one internal one, and then an association of external movement-based velocities with the internal shift mechanism in the integrator [^230] (Fig. [2f](https://www.nature.com/articles/s41583-022-00642-0#Fig2)). Thus, continuous attractors that are also integrators could enable, for example, the rapid construction [^218] [^230] [^231] and even inference of states visited for the first time through a new trajectory [^218] [^230] [^232], and could be reused to represent multiple variables [^230]. Indeed, the brain seems to (re)use grid cells and place cells when navigating in space and in non-spatial domains [^233] [^234] [^235]; recent work shows how the dimensionality of the represented variable could be greater than the individual attractor networks [^230].

A further line of work has posited that networks composed of modular subnetworks, each an attractor network, enable a given number of neurons to represent an exponentially larger number of representational or memory states [^62] [^131] [^181] [^213] [^236] [^237] [^238] [^239] [^240] through combinations of states than fully connected, Hopfield-like networks can [^241] [^242] [^243] [^244] [^245]. Although the combinatorial states expressed by the set of attractor networks are not themselves attractors, it is possible to couple together these subnetworks to generate an exponential number of attractor states such that they each have a reasonably sized basin and are thus robust [^59] [^62] [^222] [^236] [^237] [^242] (Fig. [2](https://www.nature.com/articles/s41583-022-00642-0#Fig2)). The states in these networks cannot have arbitrary form and content; they are defined by the rigid states of each module. Thus, a crucial question is how they could be leveraged for memory. Such high-capacity sets of attractor states have been shown to provide possible models for high-capacity and robust action selection [^62], robust classification [^62] and smoothly decaying associative memory [^59]. Moreover, the principles described in this paragraph can be combined in a ‘mixed modular coding scheme’ to represent and store inputs of any dimensionality relative to the individual attractor networks, so long as it is lower than the summed attractor dimension across networks [^230], without needing to reconfigure the recurrent network (Fig. [2h](https://www.nature.com/articles/s41583-022-00642-0#Fig2)). Much of the potential for alternative uses, configurations or combinations of attractor networks remains unexplored and is ripe for further study.

## Looking ahead

The theory of attractor dynamics in the brain has provided a powerful and unifying conceptual framework for understanding integration, representation, memory, error correction and efficient learning and inference in the brain. The experimental effort to study candidate attractor circuits and test their predictions has been a fertile field of research, and population-wide physiology techniques have led to breath-taking direct visualizations of attractor dynamics at work in the brain.

The theory is also proving to be a powerful tool in interpreting how artificial neural networks (ANNs) solve complex tasks. ANNs trained to robustly solve memory, integration and decision-making tasks in domains as diverse as spatial navigation, vision and language develop attractor dynamics [^46] [^246] [^247] [^248] [^249], suggesting that attractor networks not only are able to solve such problems but also might be necessary when the computing elements are memoryless neurons. Furthermore, equipping ANNs with preconfigured attractor networks can help produce faster, more data-efficient and generalizable learning [^59] [^230] [^231]. Because ANNs can be trained on complex tasks and then fully examined after learning, they will potentially more readily contribute to the next chapter in our understanding of how continuous-attractor networks can interact and combine with other mechanisms to enable the brain to solve rich problems associated with intelligence.

Notable mechanistic questions about attractor networks also remain open. One avenue may involve moving away from the high firing-rate asynchronous spiking regimens [^250] [^251] to better understand whether low firing-rate synchronous spiking networks might support attractor dynamics — and thus permit a combination of fast timescale dynamics such as spike synchronization and oscillatory phase dynamics [^250] [^252] [^253]. For continuous attractors, understanding how the brain deals with the problem of fine-tuning in linear networks or the imposition and maintenance of a continuous symmetry across neurons remains unknown and is ripe for resolution [^34] [^254].

A few models of the development of continuous attractors show how they could emerge simply through [unsupervised](https://www.nature.com/articles/s41583-022-00642-0#Glos19) associative plasticity [^17] [^179] [^210], whereas others are based on combining feedback of known or plausible error signals with neural activity in relatively simple learning rules [^17] [^255] [^256]. The rest of such models train networks on a high-level goal through [error backpropagation](https://www.nature.com/articles/s41583-022-00642-0#Glos20), combined with several other constraints on architecture or the form the solutions should take [^46] [^231] [^247] [^249] [^257] [^258] [^259]. As recent work suggests, however, training ANNs to solve tasks is not a panacea for understanding the brain’s solutions [^260]. All models of attractor network development are incomplete for different reasons: the unsupervised models require uniform exploration of the input variable space and suppression of recurrent weights during their training, whereas backpropagation models do not offer an account of how loss functions, learning and additional constraints might be generated and implemented in biological systems.

There is much left to do in the field and an exciting vista ahead. On the experimental side, tools for high-resolution population-level neural recordings and perturbation across multiple brain areas [^84] [^85] [^261] enable us to peer further and deeper than ever. On the theory side, future developments will help us conceptualize how such circuits could help underwrite intelligent computation through the formation, interaction and reuse of multiple low-dimensional attractors or attractor-like structures.

## References

## Acknowledgements

I.R.F. acknowledges funding from the Simons Foundation, the Office of Naval Research, the Howard Hughes Medical Institute (HHMI) through the Faculty Scholars Program, the Department of Brain and Cognitive Sciences, MIT, and the McGovern Institute, MIT. M.K. is supported by a Friends of the McGovern Institute Fellowship, a MathWorks Fellowship and the Department of Physics, MIT. The authors thank X. J. Wang for helpful discussion on short-term memory and persistent activity, and K. Daie, the anonymous reviewers, S. Chandra and other members of the Fiete laboratory for helpful comments on the manuscript.

## Ethics declarations

### Competing interests

The authors declare no competing interests.

## Peer review

### Peer review information

*Nature Reviews Neuroscience* thanks A. Compte, who co-reviewed with J. Barbosa, and the other, anonymous, referee(s) for their contribution to the peer review of this work.

## Additional information

**Publisher’s note** Springer Nature remains neutral with regard to jurisdictional claims in published maps and institutional affiliations.

## Glossary

Associative memory

The ability to remember and recall the relationship (association) between arbitrary items or concepts.

Autonomous

Characterized by time evolution through internal dynamics, without external driving forces.

Eccentricity

The degree of deflection of the gaze in the horizontal plane relative to a neutral centred position.

Error backpropagation

A procedure for updating the weights of all layers in artificial neural networks (ANNs) based on gradients of an objective function.

Euclidean

A space where it is possible to construct an orthogonal coordinate system and define a particular metric structure.

Hippocampal replay

Ordered sequences of place cell activity during rest or sleep, typically corresponding to sequences that occurred during normal behaviour or their time-reversed counterparts.

Homeostatic plasticity

Plasticity mechanisms that maintain the state of a system by counteracting induced changes.

Hopfield networks

Content-addressable associative memory networks, in which distributed activity states are stabilized as attractor states by synaptic weights using Hebbian learning.

Nearest-neighbour computation

Identifying the closest target out of a set of target states from any starting state, where closest is usually defined by a standard distance metric (for example, Euclidean or Hamming).

Nonlinear neurons

Neurons with input–output response relationships that are nonlinear; that is, the change in the output is not directly proportional to the change of the input.

Non-trivial attractor states

Any attractor states other than the null activity state.

Persistent activity

Maintenance of the firing rate of a neuron about a non-trivial value after removal of the stimulus that induced elevated firing, for durations that exceed the membrane time constant.

Positive feedback

Interactions between elements in which increasing the level of one element increases the level of the other. Positive feedback includes mutual excitation and disinhibition or inhibition of one’s inhibitor.

Presynaptic facilitation

A form of short-term synaptic plasticity where the effect of presynaptic activity on the post-synaptic response is enhanced following recent presynaptic activity.

Simple cells

Neurons in the primary visual cortex (V1) of many vertebrate species that respond strongly to oriented edges and gratings of a particular spatial phase.

State space

The coordinate system in which each dimension corresponds to one of the variables of the dynamical system; often, the space is approximated by the spike counts of single neurons.

Synaptic hypothesis

The hypothesis that synaptic change is the substrate of learning and memory in the brain.

Symmetric weight matrices

Weight matrices *W* that satisfy *W* <sup>T</sup>  =  *W*; that is, that are invariant to reflection of their entries about their diagonal.

Turing pattern formation

A dynamic process dependent on positive feedback in which a spatial pattern of a particular wavelength is amplified whereas others are suppressed.

Unsupervised

Characterization of the structure in data without any prior training data that contains information about the relationship between the data and external variables.

## Rights and permissions

Springer Nature or its licensor (e.g. a society or other partner) holds exclusive rights to this article under a publishing agreement with the author(s) or other rightsholder(s); author self-archiving of the accepted manuscript version of this article is solely governed by the terms of such publishing agreement and applicable law.

[^1]: Amari, S.-I. Neural theory of association and concept-formation. *Biol. Cybern.* **26**, 175–185 (1977).

[Article](https://link.springer.com/doi/10.1007/BF00365229) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaE1c%2FgtVGjtg%3D%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=901864) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Neural%20theory%20of%20association%20and%20concept-formation&journal=Biol.%20Cybern.&doi=10.1007%2FBF00365229&volume=26&pages=175-185&publication_year=1977&author=Amari%2CS-I)

[^2]: Hopfield, J. J. Neural networks and physical systems with emergent collective computational abilities. *Proc. Natl Acad. Sci. USA* **79**, 2554–2558 (1982).

[Article](https://doi.org/10.1073%2Fpnas.79.8.2554) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaL383it1WktQ%3D%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=6953413) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC346238) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Neural%20networks%20and%20physical%20systems%20with%20emergent%20collective%20computational%20abilities&journal=Proc.%20Natl%20Acad.%20Sci.%20USA&doi=10.1073%2Fpnas.79.8.2554&volume=79&pages=2554-2558&publication_year=1982&author=Hopfield%2CJJ)

[^3]: Little, W. A. The existence of persistent states in the brain. *Math. Biosci.* **19**, 101–120 (1974).

[Article](https://doi.org/10.1016%2F0025-5564%2874%2990031-5) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20existence%20of%20persistent%20states%20in%20the%20brain&journal=Math.%20Biosci.&doi=10.1016%2F0025-5564%2874%2990031-5&volume=19&pages=101-120&publication_year=1974&author=Little%2CWA)

[^4]: Wilson, H. R. & Cowan, J. D. A mathematical theory of the functional dynamics of cortical and thalamic nervous tissue. *Kybernetik* **13**, 55–80 (1973).

[Article](https://link.springer.com/doi/10.1007/BF00288786) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaE2c%2Fmsl2ntw%3D%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=4767470) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=A%20mathematical%20theory%20of%20the%20functional%20dynamics%20of%20cortical%20and%20thalamic%20nervous%20tissue&journal=Kybernetik&doi=10.1007%2FBF00288786&volume=13&pages=55-80&publication_year=1973&author=Wilson%2CHR&author=Cowan%2CJD)

[^5]: Hopfield, J. J. Neurons with graded response have collective computational properties like those of two-state neurons. *Proc. Natl Acad. Sci. USA* **81**, 3088–3092 (1984).

[Article](https://doi.org/10.1073%2Fpnas.81.10.3088) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaL2c3itF2jug%3D%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=6587342) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC345226) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Neurons%20with%20graded%20response%20have%20collective%20computational%20properties%20like%20those%20of%20two-state%20neurons&journal=Proc.%20Natl%20Acad.%20Sci.%20USA&doi=10.1073%2Fpnas.81.10.3088&volume=81&pages=3088-3092&publication_year=1984&author=Hopfield%2CJJ)

[^6]: Cohen, M. A. & Grossberg, S. Absolute stability of global pattern formation and parallel memory storage by competitive neural networks. *IEEE Trans. Syst. Man Cybern.* **SMC-13**, 815–826 (1983).

[Article](https://doi.org/10.1109%2FTSMC.1983.6313075) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Absolute%20stability%20of%20global%20pattern%20formation%20and%20parallel%20memory%20storage%20by%20competitive%20neural%20networks&journal=IEEE%20Trans.%20Syst.%20Man%20Cybern.&doi=10.1109%2FTSMC.1983.6313075&volume=SMC-13&pages=815-826&publication_year=1983&author=Cohen%2CMA&author=Grossberg%2CS)

[^7]: Amari, S. Dynamics of pattern formation in lateral-inhibition type neural fields. *Biol. Cybern.* **27**, 77–87 (1977).

[Article](https://link.springer.com/doi/10.1007/BF00337259) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaE1c%2FitFWlsw%3D%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=911931) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Dynamics%20of%20pattern%20formation%20in%20lateral-inhibition%20type%20neural%20fields&journal=Biol.%20Cybern.&doi=10.1007%2FBF00337259&volume=27&pages=77-87&publication_year=1977&author=Amari%2CS)

[^8]: Cannon, S. C., Robinson, D. A. & Shamma, S. A proposed neural network for the integrator of the oculomotor system. *Biol. Cybern.* **49**, 127–136 (1983).

[Article](https://link.springer.com/doi/10.1007/BF00320393) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaL2c7gsV2rsw%3D%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=6661444) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=A%20proposed%20neural%20network%20for%20the%20integrator%20of%20the%20oculomotor%20system&journal=Biol.%20Cybern.&doi=10.1007%2FBF00320393&volume=49&pages=127-136&publication_year=1983&author=Cannon%2CSC&author=Robinson%2CDA&author=Shamma%2CS)

[^9]: Seung, H. S. How the brain keeps the eyes still. *Proc. Natl Acad. Sci. USA* **93**, 13339–13344 (1996). **This work constructs and pedagogically describes a mathematical theory of line attractor dynamics for the oculomotor system**

[Article](https://doi.org/10.1073%2Fpnas.93.23.13339) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DyaK28XmvFSnsLg%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=8917592) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC24094) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=How%20the%20brain%20keeps%20the%20eyes%20still&journal=Proc.%20Natl%20Acad.%20Sci.%20USA&doi=10.1073%2Fpnas.93.23.13339&volume=93&pages=13339-13344&publication_year=1996&author=Seung%2CHS)

[^10]: Ben-Yishai, R., Bar-Or, R. L. & Sompolinsky, H. Theory of orientation tuning in visual cortex. *Proc. Natl Acad. Sci. USA* **92**, 3844–3848 (1995).

[Article](https://doi.org/10.1073%2Fpnas.92.9.3844) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DyaK2MXlsVSlu7g%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=7731993) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC42058) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Theory%20of%20orientation%20tuning%20in%20visual%20cortex&journal=Proc.%20Natl%20Acad.%20Sci.%20USA&doi=10.1073%2Fpnas.92.9.3844&volume=92&pages=3844-3848&publication_year=1995&author=Ben-Yishai%2CR&author=Bar-Or%2CRL&author=Sompolinsky%2CH)

[^11]: Ermentrout, B. Neural networks as spatio-temporal pattern-forming systems. *Rep. Prog. Phys.* **61**, 353 (1998).

[Article](https://doi.org/10.1088%2F0034-4885%2F61%2F4%2F002) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Neural%20networks%20as%20spatio-temporal%20pattern-forming%20systems&journal=Rep.%20Prog.%20Phys.&doi=10.1088%2F0034-4885%2F61%2F4%2F002&volume=61&publication_year=1998&author=Ermentrout%2CB)

[^12]: Stringer, S., Trappenberg, T., Rolls, E. & Araujo, I. Self-organizing continuous attractor networks and path integration: one-dimensional models of head direction cells. *Network* **13**, 217–242 (2002).

[Article](https://doi.org/10.1080%2Fnet.13.2.217.242) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DC%2BD38zhvFWrtw%3D%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=12061421) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Self-organizing%20continuous%20attractor%20networks%20and%20path%20integration%3A%20one-dimensional%20models%20of%20head%20direction%20cells&journal=Network&doi=10.1080%2Fnet.13.2.217.242&volume=13&pages=217-242&publication_year=2002&author=Stringer%2CS&author=Trappenberg%2CT&author=Rolls%2CE&author=Araujo%2CI)

[^13]: Xie, X., Hahnloser, R. H. R. & Seung, H. S. Double-ring network model of the head-direction system. *Phys. Rev. E Stat. Nonlin. Soft Matter Phys.* **66**, 041902 (2002).

[Article](https://doi.org/10.1103%2FPhysRevE.66.041902) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=12443230) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Double-ring%20network%20model%20of%20the%20head-direction%20system&journal=Phys.%20Rev.%20E%20Stat.%20Nonlin.%20Soft%20Matter%20Phys.&doi=10.1103%2FPhysRevE.66.041902&volume=66&publication_year=2002&author=Xie%2CX&author=Hahnloser%2CRHR&author=Seung%2CHS)

[^14]: Fuhs, M. C. & Touretzky, D. S. A spin glass model of path integration in rat medial entorhinal cortex. *J. Neurosci.* **26**, 4266–4276 (2006).

[Article](https://doi.org/10.1523%2FJNEUROSCI.4353-05.2006) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD28XktlCltbY%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=16624947) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC6674007) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=A%20spin%20glass%20model%20of%20path%20integration%20in%20rat%20medial%20entorhinal%20cortex&journal=J.%20Neurosci.&doi=10.1523%2FJNEUROSCI.4353-05.2006&volume=26&pages=4266-4276&publication_year=2006&author=Fuhs%2CMC&author=Touretzky%2CDS)

[^15]: Burak, Y. & Fiete, I. R. Accurate path integration in continuous attractor network models of grid cells. *PLoS Comput. Biol.* **5**, e1000291 (2009). **For a single module of grid cells, this work construct a faithful continuous-attractor network model based on the principles of pattern formation**

[Article](https://doi.org/10.1371%2Fjournal.pcbi.1000291) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=19229307) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC2632741) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Accurate%20path%20integration%20in%20continuous%20attractor%20network%20models%20of%20grid%20cells&journal=PLoS%20Comput.%20Biol.&doi=10.1371%2Fjournal.pcbi.1000291&volume=5&publication_year=2009&author=Burak%2CY&author=Fiete%2CIR)

[^16]: Wang, X.-J. Probabilistic decision making by slow reverberation in cortical circuits. *Neuron* **36**, 955–968 (2002).

[Article](https://doi.org/10.1016%2FS0896-6273%2802%2901092-9) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD38XpslWlsL8%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=12467598) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Probabilistic%20decision%20making%20by%20slow%20reverberation%20in%20cortical%20circuits&journal=Neuron&doi=10.1016%2FS0896-6273%2802%2901092-9&volume=36&pages=955-968&publication_year=2002&author=Wang%2CX-J)

[^17]: Zhang, K. Representation of spatial orientation by the intrinsic dynamics of the head-direction cell ensemble: a theory. *J. Neurosci.* **15**, 2112–2126 (1996). **This work constructs a continuous-attractor network model of the head-direction system, showing how intrinsic dynamics contribute to shaping population firing rates**

[Article](https://doi.org/10.1523%2FJNEUROSCI.16-06-02112.1996) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Representation%20of%20spatial%20orientation%20by%20the%20intrinsic%20dynamics%20of%20the%20head-direction%20cell%20ensemble%3A%20a%20theory&journal=J.%20Neurosci.&doi=10.1523%2FJNEUROSCI.16-06-02112.1996&volume=15&pages=2112-2126&publication_year=1996&author=Zhang%2CK)

[^18]: Milnor, J. W. Attractor. *Scholarpedia* **1**, 1815 (2006).

[Article](https://doi.org/10.4249%2Fscholarpedia.1815) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Attractor&journal=Scholarpedia&doi=10.4249%2Fscholarpedia.1815&volume=1&publication_year=2006&author=Milnor%2CJW)

[^19]: Chaudhuri, R., Gerçek, B., Pandey, B., Peyrache, A. & Fiete, I. The intrinsic attractor manifold and population dynamics of a canonical cognitive circuit across waking and sleep. *Nat. Neurosci.* **22**, 1512–1520 (2019). **This work tests and verifies the predictions of continuous-attractor dynamics for the head-direction cell circuit in the anterodorsal thalamic nucleus in rodents by analysing data across behavioural states**

[Article](https://doi.org/10.1038%2Fs41593-019-0460-x) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC1MXhsFKhtbfE) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=31406365) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20intrinsic%20attractor%20manifold%20and%20population%20dynamics%20of%20a%20canonical%20cognitive%20circuit%20across%20waking%20and%20sleep&journal=Nat.%20Neurosci.&doi=10.1038%2Fs41593-019-0460-x&volume=22&pages=1512-1520&publication_year=2019&author=Chaudhuri%2CR&author=Ger%C3%A7ek%2CB&author=Pandey%2CB&author=Peyrache%2CA&author=Fiete%2CI)

[^20]: Gardner, R. J. et al. Toroidal topology of population activity in grid cells. *Nature* **602**, 123–128 (2022). **This work using large-scale recordings of several hundred cells verifies predictions of continuous-attractor dynamics in single modules of grid cells**

[Article](https://doi.org/10.1038%2Fs41586-021-04268-7) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BB38XhtVOlt7s%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=35022611) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC8810387) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Toroidal%20topology%20of%20population%20activity%20in%20grid%20cells&journal=Nature&doi=10.1038%2Fs41586-021-04268-7&volume=602&pages=123-128&publication_year=2022&author=Gardner%2CRJ)

[^21]: Strogatz, S. H. *Nonlinear Dynamics and Chaos: With Applications to Physics, Biology, Chemistry, and Engineering* (CRC, 2018).

[^22]: Koch, C. *Biophysics of Computation: Information Processing in Single Neurons* (Oxford Univ. Press, 2004).

[^23]: Shadlen, M. N. & Newsome, W. T. The variable discharge of cortical neurons: implications for connectivity, computation, and information coding. *J. Neurosci.* **18**, 3870–3896 (1998).

[Article](https://doi.org/10.1523%2FJNEUROSCI.18-10-03870.1998) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DyaK1cXjtVWqtbg%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=9570816) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC6793166) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20variable%20discharge%20of%20cortical%20neurons%3A%20implications%20for%20connectivity%2C%20computation%2C%20and%20information%20coding&journal=J.%20Neurosci.&doi=10.1523%2FJNEUROSCI.18-10-03870.1998&volume=18&pages=3870-3896&publication_year=1998&author=Shadlen%2CMN&author=Newsome%2CWT)

[^24]: Hanus, C. & Schuman, E. M. Proteostasis in complex dendrites. *Nat. Rev. Neurosci.* **14**, 638 (2013).

[Article](https://doi.org/10.1038%2Fnrn3546) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC3sXhtF2hs7zL) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=23900412) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Proteostasis%20in%20complex%20dendrites&journal=Nat.%20Rev.%20Neurosci.&doi=10.1038%2Fnrn3546&volume=14&publication_year=2013&author=Hanus%2CC&author=Schuman%2CEM)

[^25]: James, W. *The Principles of Psychology* (Henry Holt, 1890).

[^26]: McDougall, W. On the seat of the psycho-physical processes. *Brain* **24**, 579–630 (1901).

[Article](https://doi.org/10.1093%2Fbrain%2F24.4.579) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=On%20the%20seat%20of%20the%20psycho-physical%20processes&journal=Brain&doi=10.1093%2Fbrain%2F24.4.579&volume=24&pages=579-630&publication_year=1901&author=McDougall%2CW)

[^27]: Hebb, D. O. *The Organization of Behavior* (Wiley, 1949).

[^28]: Brown, R. E., Bligh, T. W. B. & Garden, J. F. The Hebb synapse before Hebb: theories of synaptic function in learning and memory before, with a discussion of the long-lost synaptic theory of William McDougall. *Front. Behav. Neurosci.* **15**, 732195 (2021).

[Article](https://doi.org/10.3389%2Ffnbeh.2021.732195) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=34744652) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC8566713) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20Hebb%20synapse%20before%20Hebb%3A%20theories%20of%20synaptic%20function%20in%20learning%20and%20memory%20before%2C%20with%20a%20discussion%20of%20the%20long-lost%20synaptic%20theory%20of%20William%20McDougall&journal=Front.%20Behav.%20Neurosci.&doi=10.3389%2Ffnbeh.2021.732195&volume=15&publication_year=2021&author=Brown%2CRE&author=Bligh%2CTWB&author=Garden%2CJF)

[^29]: Abraham, W. C., Jones, O. D. & Glanzman, D. L. Is plasticity of synapses the mechanism of long-term memory storage? *NPJ Sci. Learn.* **4**, 1–10 (2019).

[Article](https://doi.org/10.1038%2Fs41539-019-0048-y) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Is%20plasticity%20of%20synapses%20the%20mechanism%20of%20long-term%20memory%20storage%3F&journal=NPJ%20Sci.%20Learn.&doi=10.1038%2Fs41539-019-0048-y&volume=4&pages=1-10&publication_year=2019&author=Abraham%2CWC&author=Jones%2COD&author=Glanzman%2CDL)

[^30]: Takeuchi, T., Duszkiewicz, A. J. & Morris, R. G. The synaptic plasticity and memory hypothesis: encoding, storage and persistence. *Philos. Trans. R. Soc. B: Biol. Sci.* **369**, 20130288 (2014).

[Article](https://doi.org/10.1098%2Frstb.2013.0288) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20synaptic%20plasticity%20and%20memory%20hypothesis%3A%20encoding%2C%20storage%20and%20persistence&journal=Philos.%20Trans.%20R.%20Soc.%20B%3A%20Biol.%20Sci.&doi=10.1098%2Frstb.2013.0288&volume=369&publication_year=2014&author=Takeuchi%2CT&author=Duszkiewicz%2CAJ&author=Morris%2CRG)

[^31]: Martin, S., Grimwood, P. & Morris, R. Synaptic plasticity and memory: an evaluation of the hypothesis. *Annu. Rev. Neurosci.* **23**, 649–711 (2000).

[Article](https://doi.org/10.1146%2Fannurev.neuro.23.1.649) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD3cXjs1Gms7g%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=10845078) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Synaptic%20plasticity%20and%20memory%3A%20an%20evaluation%20of%20the%20hypothesis&journal=Annu.%20Rev.%20Neurosci.&doi=10.1146%2Fannurev.neuro.23.1.649&volume=23&pages=649-711&publication_year=2000&author=Martin%2CS&author=Grimwood%2CP&author=Morris%2CR)

[^32]: Anderson, P. W. More is different. *Science* **177**, 393–396 (1972).

[Article](https://doi.org/10.1126%2Fscience.177.4047.393) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DyaE38XltVGlu7s%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=17796623) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=More%20is%20different&journal=Science&doi=10.1126%2Fscience.177.4047.393&volume=177&pages=393-396&publication_year=1972&author=Anderson%2CPW)

[^33]: Zhang, H., Wang, Z. & Liu, D. A comprehensive review of stability analysis of continuous-time recurrent neural networks. *IEEE Trans. Neural Netw. Learn. Syst.* **25**, 1229–1262 (2014).

[Article](https://doi.org/10.1109%2FTNNLS.2014.2317880) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=A%20comprehensive%20review%20of%20stability%20analysis%20of%20continuous-time%20recurrent%20neural%20networks&journal=IEEE%20Trans.%20Neural%20Netw.%20Learn.%20Syst.&doi=10.1109%2FTNNLS.2014.2317880&volume=25&pages=1229-1262&publication_year=2014&author=Zhang%2CH&author=Wang%2CZ&author=Liu%2CD)

[^34]: Renart, A., Song, P. & Wang, X.-J. Robust spatial working memory through homeostatic synaptic scaling in heterogeneous cortical networks. *Neuron* **38**, 473–485 (2003).

[Article](https://doi.org/10.1016%2FS0896-6273%2803%2900255-1) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD3sXjvFOrsLs%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=12741993) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Robust%20spatial%20working%20memory%20through%20homeostatic%20synaptic%20scaling%20in%20heterogeneous%20cortical%20networks&journal=Neuron&doi=10.1016%2FS0896-6273%2803%2900255-1&volume=38&pages=473-485&publication_year=2003&author=Renart%2CA&author=Song%2CP&author=Wang%2CX-J)

[^35]: Itskov, V., Hansel, D. & Tsodyks, M. Short-term facilitation may stabilize parametric working memory trace. *Front. Comput. Neurosci.* **5**, 40 (2011).

[Article](https://doi.org/10.3389%2Ffncom.2011.00040) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=22028690) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3199447) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Short-term%20facilitation%20may%20stabilize%20parametric%20working%20memory%20trace&journal=Front.%20Comput.%20Neurosci.&doi=10.3389%2Ffncom.2011.00040&volume=5&publication_year=2011&author=Itskov%2CV&author=Hansel%2CD&author=Tsodyks%2CM)

[^36]: Turing, A. M. The chemical basis of morphogenesis. *Philos. Trans. R. Soc. Lond. B Biol. Sci.* **237**, 37–72 (1952).

[Article](https://doi.org/10.1098%2Frstb.1952.0012) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20chemical%20basis%20of%20morphogenesis&journal=Philos.%20Trans.%20R.%20Soc.%20Lond.%20B%20Biol.%20Sci.&doi=10.1098%2Frstb.1952.0012&volume=237&pages=37-72&publication_year=1952&author=Turing%2CAM)

[^37]: Cross, M. C. & Hohenberg, P. C. Pattern formation outside of equilibrium. *Rev. Mod. Phys.* **65**, 851 (1993).

[Article](https://doi.org/10.1103%2FRevModPhys.65.851) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DyaK2cXhtFShs7c%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Pattern%20formation%20outside%20of%20equilibrium&journal=Rev.%20Mod.%20Phys.&doi=10.1103%2FRevModPhys.65.851&volume=65&publication_year=1993&author=Cross%2CMC&author=Hohenberg%2CPC)

[^38]: Koch, A. J. & Meinhardt, H. Biological pattern formation: from basic mechanisms to complex structures. *Rev. Mod. Phys.* **66**, 1481–1507 (1994).

[Article](https://doi.org/10.1103%2FRevModPhys.66.1481) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Biological%20pattern%20formation%3A%20from%20basic%20mechanisms%20to%20complex%20structures&journal=Rev.%20Mod.%20Phys.&doi=10.1103%2FRevModPhys.66.1481&volume=66&pages=1481-1507&publication_year=1994&author=Koch%2CAJ&author=Meinhardt%2CH)

[^39]: Schweisguth, F. & Corson, F. Self organization in pattern formation. *Dev. Cell* **49**, 659–677 (2019).

[Article](https://doi.org/10.1016%2Fj.devcel.2019.05.019) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC1MXhtV2hs7bI) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=31163171) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Self%20organization%20in%20pattern%20formation&journal=Dev.%20Cell&doi=10.1016%2Fj.devcel.2019.05.019&volume=49&pages=659-677&publication_year=2019&author=Schweisguth%2CF&author=Corson%2CF)

[^40]: Shraiman, B. Mechanical feedback as a possible regulator of tissue growth. *Proc. Natl Acad. Sci. USA* **102**, 3318–3323 (2005).

[Article](https://doi.org/10.1073%2Fpnas.0404782102) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD2MXitl2ltbo%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=15728365) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC552900) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Mechanical%20feedback%20as%20a%20possible%20regulator%20of%20tissue%20growth&journal=Proc.%20Natl%20Acad.%20Sci.%20USA&doi=10.1073%2Fpnas.0404782102&volume=102&pages=3318-3323&publication_year=2005&author=Shraiman%2CB)

[^41]: Sekimura, T., Noji, S., Ueno, N. & Maini, P., *Morphogenesis and Pattern Formation in Biological Systems: Experiments and Models* (Springer, 2003).

[^42]: Gierer, A. & Meinhardt, H. A theory of biological pattern formation. *Kybernetik* **12**, 30–39 (1972).

[Article](https://link.springer.com/doi/10.1007/BF00289234) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaE3s3gs1agtg%3D%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=4663624) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=A%20theory%20of%20biological%20pattern%20formation&journal=Kybernetik&doi=10.1007%2FBF00289234&volume=12&pages=30-39&publication_year=1972&author=Gierer%2CA&author=Meinhardt%2CH)

[^43]: Boucheny, C., Brunel, N. & Arleo, A. A continuous attractor network model without recurrent excitation: maintenance and integration in the head direction cell system. *J. Comput. Neurosci.* **18**, 205–227 (2005).

[Article](https://link.springer.com/doi/10.1007/s10827-005-6559-y) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=15714270) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=A%20continuous%20attractor%20network%20model%20without%20recurrent%20excitation%3A%20maintenance%20and%20integration%20in%20the%20head%20direction%20cell%20system&journal=J.%20Comput.%20Neurosci.&doi=10.1007%2Fs10827-005-6559-y&volume=18&pages=205-227&publication_year=2005&author=Boucheny%2CC&author=Brunel%2CN&author=Arleo%2CA)

[^44]: Couey, J. J. et al. Recurrent inhibitory circuitry as a mechanism for grid formation. *Nat. Neurosci.* **16**, 318–324 (2013).

[Article](https://doi.org/10.1038%2Fnn.3310) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC3sXhtV2rsbo%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=23334580) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Recurrent%20inhibitory%20circuitry%20as%20a%20mechanism%20for%20grid%20formation&journal=Nat.%20Neurosci.&doi=10.1038%2Fnn.3310&volume=16&pages=318-324&publication_year=2013&author=Couey%2CJJ)

[^45]: Burak, Y. & Fiete, I. R. Fundamental limits on persistent activity in networks of noisy neurons. *Proc. Natl Acad. Sci. USA* **109**, 17645–17650 (2012).

[Article](https://doi.org/10.1073%2Fpnas.1117386109) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC38XhvVSltLbM) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=23047704) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3491496) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Fundamental%20limits%20on%20persistent%20activity%20in%20networks%20of%20noisy%20neurons&journal=Proc.%20Natl%20Acad.%20Sci.%20USA&doi=10.1073%2Fpnas.1117386109&volume=109&pages=17645-17650&publication_year=2012&author=Burak%2CY&author=Fiete%2CIR)

[^46]: Sorscher, B., Mel, G., Ganguli, S. & Ocko, S. A unified theory for the origin of grid cells through the lens of pattern formation. In *Advances in Neural Information Processing Systems* 10003–10013 (NeurIPS, 2019).

[^47]: Khona, M., Chandra, S. & Fiete, I. Spontaneous emergence of topologically robust grid cell modules: a multiscale instability theory. Preprint at *bioRxiv* [https://doi.org/10.1101/2021.10.28.466284](https://doi.org/10.1101/2021.10.28.466284) (2021).

[Article](https://doi.org/10.1101%2F2021.10.28.466284) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Spontaneous%20emergence%20of%20topologically%20robust%20grid%20cell%20modules%3A%20a%20multiscale%20instability%20theory&journal=bioRxiv&doi=10.1101%2F2021.10.28.466284&publication_year=2021&author=Khona%2CM&author=Chandra%2CS&author=Fiete%2CI)

[^48]: Seung, H. S. Amplification, attenuation, and integration. *Handb. Brain Theory Neural Netw.* **2**, 94–97 (2003).

[Google Scholar](http://scholar.google.com/scholar_lookup?&title=Amplification%2C%20attenuation%2C%20and%20integration&journal=Handb.%20Brain%20Theory%20Neural%20Netw.&volume=2&pages=94-97&publication_year=2003&author=Seung%2CHS)

[^49]: Sompolinsky, H., Crisanti, A. & Sommers, H.-J. Chaos in random neural networks. *Phys. Rev. Lett.* **61**, 259 (1988).

[Article](https://doi.org/10.1103%2FPhysRevLett.61.259) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DC%2BC2sfosVOntg%3D%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=10039285) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Chaos%20in%20random%20neural%20networks&journal=Phys.%20Rev.%20Lett.&doi=10.1103%2FPhysRevLett.61.259&volume=61&publication_year=1988&author=Sompolinsky%2CH&author=Crisanti%2CA&author=Sommers%2CH-J)

[^50]: van Vreeswijk, C. & Sompolinsky, H. Chaos in neuronal networks with balanced excitatory and inhibitory activity. *Science* **274** 5293, 1724–1726 (1996).

[Article](https://doi.org/10.1126%2Fscience.274.5293.1724) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=8939866) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Chaos%20in%20neuronal%20networks%20with%20balanced%20excitatory%20and%20inhibitory%20activity&journal=Science&doi=10.1126%2Fscience.274.5293.1724&volume=274&issue=5293&pages=1724-1726&publication_year=1996&author=Vreeswijk%2CC&author=Sompolinsky%2CH)

[^51]: Engelken, R., Wolf, F. & Abbott, L. Lyapunov spectra of chaotic recurrent neural networks. Preprint at *arXiv* [https://doi.org/10.48550/arXiv.2006.02427](https://doi.org/10.48550/arXiv.2006.02427) (2020).

[Article](https://doi.org/10.48550%2FarXiv.2006.02427) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Lyapunov%20spectra%20of%20chaotic%20recurrent%20neural%20networks&journal=arXiv&doi=10.48550%2FarXiv.2006.02427&publication_year=2020&author=Engelken%2CR&author=Wolf%2CF&author=Abbott%2CL)

[^52]: Murphy, B. K. & Miller, K. D. Balanced amplification: a new mechanism of selective amplification of neural activity patterns. *Neuron* **61**, 635–648 (2009).

[Article](https://doi.org/10.1016%2Fj.neuron.2009.02.005) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD1MXlt1Klsbs%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=19249282) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC2667957) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Balanced%20amplification%3A%20a%20new%20mechanism%20of%20selective%20amplification%20of%20neural%20activity%20patterns&journal=Neuron&doi=10.1016%2Fj.neuron.2009.02.005&volume=61&pages=635-648&publication_year=2009&author=Murphy%2CBK&author=Miller%2CKD)

[^53]: Trefethen, L. N., Trefethen, A. E., Reddy, S. C. & Driscoll, T. A. Hydrodynamic stability without eigenvalues. *Science* **261**, 578–584 (1993).

[Article](https://doi.org/10.1126%2Fscience.261.5121.578) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DC%2BC3cvis1Wnsg%3D%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=17758167) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Hydrodynamic%20stability%20without%20eigenvalues&journal=Science&doi=10.1126%2Fscience.261.5121.578&volume=261&pages=578-584&publication_year=1993&author=Trefethen%2CLN&author=Trefethen%2CAE&author=Reddy%2CSC&author=Driscoll%2CTA)

[^54]: Mongillo, G., Barak, O. & Tsodyks, M. Synaptic theory of working memory. *Science* **319**, 1543–1546 (2008).

[Article](https://doi.org/10.1126%2Fscience.1150769) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD1cXjtVGqs78%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=18339943) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Synaptic%20theory%20of%20working%20memory&journal=Science&doi=10.1126%2Fscience.1150769&volume=319&pages=1543-1546&publication_year=2008&author=Mongillo%2CG&author=Barak%2CO&author=Tsodyks%2CM)

[^55]: Compte, A., Brunel, N., Goldman-Rakic, P. S. & Wang, X.-J. Synaptic mechanisms and network dynamics underlying spatial working memory in a cortical network model. *Cereb. Cortex* **10**, 910–923 (2000).

[Article](https://doi.org/10.1093%2Fcercor%2F10.9.910) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DC%2BD3cvotFSgtQ%3D%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=10982751) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Synaptic%20mechanisms%20and%20network%20dynamics%20underlying%20spatial%20working%20memory%20in%20a%20cortical%20network%20model&journal=Cereb.%20Cortex&doi=10.1093%2Fcercor%2F10.9.910&volume=10&pages=910-923&publication_year=2000&author=Compte%2CA&author=Brunel%2CN&author=Goldman-Rakic%2CPS&author=Wang%2CX-J)

[^56]: Bogacz, R., Brown, E., Moehlis, J., Holmes, P. & Cohen, J. D. The physics of optimal decision making: a formal analysis of models of performance in two-alternative forced-choice tasks. *Psychol. Rev.* **113**, 700–765 (2006).

[Article](https://doi.org/10.1037%2F0033-295X.113.4.700) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=17014301) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20physics%20of%20optimal%20decision%20making%3A%20a%20formal%20analysis%20of%20models%20of%20performance%20in%20two-alternative%20forced-choice%20tasks&journal=Psychol.%20Rev.&doi=10.1037%2F0033-295X.113.4.700&volume=113&pages=700-765&publication_year=2006&author=Bogacz%2CR&author=Brown%2CE&author=Moehlis%2CJ&author=Holmes%2CP&author=Cohen%2CJD)

[^57]: Baum, E. B., Moody, J. & Wilczek, F. Internal representations for associative memory. *Biol. Cybern.* **59**, 217–228 (1988).

[Article](https://link.springer.com/doi/10.1007/BF00332910) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Internal%20representations%20for%20associative%20memory&journal=Biol.%20Cybern.&doi=10.1007%2FBF00332910&volume=59&pages=217-228&publication_year=1988&author=Baum%2CEB&author=Moody%2CJ&author=Wilczek%2CF)

[^58]: Saul, L. K. & Jordan, M. I. Attractor dynamics in feedforward neural networks. *Neural Comput.* **12**, 1313–1335 (2000).

[Article](https://doi.org/10.1162%2F089976600300015385) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DC%2BD3cvhvVCqtQ%3D%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=10935715) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Attractor%20dynamics%20in%20feedforward%20neural%20networks&journal=Neural%20Comput.&doi=10.1162%2F089976600300015385&volume=12&pages=1313-1335&publication_year=2000&author=Saul%2CLK&author=Jordan%2CMI)

[^59]: Sharma, S., Chandra, S. & Fiete, I. R. Content addressable memory without catastrophic forgetting by heteroassociation with a fixed scaffold. In *Int. Conf. Machine Learning, ICML 2022* (eds Chaudhuri, K. et al.) Vol. 162, 19658-19682 (PMLR, 2022).

[^60]: Funahashi, S., Bruce, C. J. & Goldman-Rakic, P. S. Mnemonic coding of visual space in the monkey’s dorsolateral prefrontal cortex. *J. Neurophysiol.* **61**, 331–349 (1989).

[Article](https://doi.org/10.1152%2Fjn.1989.61.2.331) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaL1M7ktV2rtQ%3D%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=2918358) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Mnemonic%20coding%20of%20visual%20space%20in%20the%20monkey%E2%80%99s%20dorsolateral%20prefrontal%20cortex&journal=J.%20Neurophysiol.&doi=10.1152%2Fjn.1989.61.2.331&volume=61&pages=331-349&publication_year=1989&author=Funahashi%2CS&author=Bruce%2CCJ&author=Goldman-Rakic%2CPS)

[^61]: Curtis, C. E. & D’Esposito, M. Persistent activity in the prefrontal cortex during working memory. *Trends Cogn. Sci.* **7**, 415–423 (2003).

[Article](https://doi.org/10.1016%2FS1364-6613%2803%2900197-9) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=12963473) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Persistent%20activity%20in%20the%20prefrontal%20cortex%20during%20working%20memory&journal=Trends%20Cogn.%20Sci.&doi=10.1016%2FS1364-6613%2803%2900197-9&volume=7&pages=415-423&publication_year=2003&author=Curtis%2CCE&author=D%E2%80%99Esposito%2CM)

[^62]: Chaudhuri, R. & Fiete, I. Bipartite expander Hopfield networks as self-decoding high-capacity error correcting codes. In *Advances in Neural Information Processing Systems* 7686–7697 (NeurIPS, 2019).

[^63]: Song, P. & Wang, X.-J. Angular path integration by moving “hill of activity”: a spiking neuron model without recurrent excitation of the head-direction system. *J. Neurosci.* **25**, 1002–1014 (2005).

[Article](https://doi.org/10.1523%2FJNEUROSCI.4172-04.2005) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD2MXhtlaltL4%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=15673682) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC6725619) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Angular%20path%20integration%20by%20moving%20%E2%80%9Chill%20of%20activity%E2%80%9D%3A%20a%20spiking%20neuron%20model%20without%20recurrent%20excitation%20of%20the%20head-direction%20system&journal=J.%20Neurosci.&doi=10.1523%2FJNEUROSCI.4172-04.2005&volume=25&pages=1002-1014&publication_year=2005&author=Song%2CP&author=Wang%2CX-J)

[^64]: Redish, D., Elga, A. N. & Touretzky, D. S. A coupled attractor model of the rodent head direction system. *Netwk. Comput. Neural Syst.* **7**, 671–685 (1996).

[Article](https://doi.org/10.1088%2F0954-898X_7_4_004) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=A%20coupled%20attractor%20model%20of%20the%20rodent%20head%20direction%20system&journal=Netwk.%20Comput.%20Neural%20Syst.&doi=10.1088%2F0954-898X_7_4_004&volume=7&pages=671-685&publication_year=1996&author=Redish%2CD&author=Elga%2CAN&author=Touretzky%2CDS)

[^65]: Wang, X.-J. Decision making in recurrent neuronal circuits. *Neuron* **60**, 215–234 (2008).

[Article](https://doi.org/10.1016%2Fj.neuron.2008.09.034) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD1cXhtlCgtrvF) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=18957215) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC2710297) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Decision%20making%20in%20recurrent%20neuronal%20circuits&journal=Neuron&doi=10.1016%2Fj.neuron.2008.09.034&volume=60&pages=215-234&publication_year=2008&author=Wang%2CX-J)

[^66]: Kriener, B., Chaudhuri, R. & Fiete, I. Robust parallel decision-making in neural circuits with nonlinear inhibition. *Proc. Natl Acad. Sci. USA* **117**, 25505–25516 (2020).

[Article](https://doi.org/10.1073%2Fpnas.1917551117) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BB3cXitVKktL3O) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=33008882) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC7568288) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Robust%20parallel%20decision-making%20in%20neural%20circuits%20with%20nonlinear%20inhibition&journal=Proc.%20Natl%20Acad.%20Sci.%20USA&doi=10.1073%2Fpnas.1917551117&volume=117&pages=25505-25516&publication_year=2020&author=Kriener%2CB&author=Chaudhuri%2CR&author=Fiete%2CI)

[^67]: Usher, M. & McClelland, J. L. The time course of perceptual choice: the leaky, competing accumulator model. *Psychol. Rev.* **108**, 550 (2001).

[Article](https://doi.org/10.1037%2F0033-295X.108.3.550) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DC%2BD3Mvkt1Wltw%3D%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=11488378) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20time%20course%20of%20perceptual%20choice%3A%20the%20leaky%2C%20competing%20accumulator%20model&journal=Psychol.%20Rev.&doi=10.1037%2F0033-295X.108.3.550&volume=108&publication_year=2001&author=Usher%2CM&author=McClelland%2CJL)

[^68]: Wong, K.-F. & Wang, X.-J. A recurrent network mechanism of time integration in perceptual decisions. *J. Neurosci.* **26**, 1314–1328 (2006).

[Article](https://doi.org/10.1523%2FJNEUROSCI.3733-05.2006) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD28XhsVSjt78%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=16436619) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC6674568) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=A%20recurrent%20network%20mechanism%20of%20time%20integration%20in%20perceptual%20decisions&journal=J.%20Neurosci.&doi=10.1523%2FJNEUROSCI.3733-05.2006&volume=26&pages=1314-1328&publication_year=2006&author=Wong%2CK-F&author=Wang%2CX-J)

[^69]: Hahnloser, R. H., Sarpeshkar, R., Mahowald, M. A., Douglas, R. J. & Seung, H. S. Digital selection and analogue amplification coexist in a cortex-inspired silicon circuit. *Nature* **405**, 947 (2000).

[Article](https://doi.org/10.1038%2F35016072) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD3cXks1WltrY%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=10879535) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Digital%20selection%20and%20analogue%20amplification%20coexist%20in%20a%20cortex-inspired%20silicon%20circuit&journal=Nature&doi=10.1038%2F35016072&volume=405&publication_year=2000&author=Hahnloser%2CRH&author=Sarpeshkar%2CR&author=Mahowald%2CMA&author=Douglas%2CRJ&author=Seung%2CHS)

[^70]: Bogacz, R. & Gurney, K. The basal ganglia and cortex implement optimal decision making between alternative actions. *Neural Comput.* **19**, 442–477 (2007).

[Article](https://doi.org/10.1162%2Fneco.2007.19.2.442) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=17206871) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20basal%20ganglia%20and%20cortex%20implement%20optimal%20decision%20making%20between%20alternative%20actions&journal=Neural%20Comput.&doi=10.1162%2Fneco.2007.19.2.442&volume=19&pages=442-477&publication_year=2007&author=Bogacz%2CR&author=Gurney%2CK)

[^71]: Prat-Ortega, G., Wimmer, K., Roxin, A. & de la Rocha, J. Flexible categorization in perceptual decision making. *Nat. Commun.* **12**, 1–15 (2021).

[Article](https://doi.org/10.1038%2Fs41467-021-21501-z) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Flexible%20categorization%20in%20perceptual%20decision%20making&journal=Nat.%20Commun.&doi=10.1038%2Fs41467-021-21501-z&volume=12&pages=1-15&publication_year=2021&author=Prat-Ortega%2CG&author=Wimmer%2CK&author=Roxin%2CA&author=Rocha%2CJ)

[^72]: Pfeiffer, B. E. & Foster, D. J. Autoassociative dynamics in the generation of sequences of hippocampal place cells. *Science* **349**, 180–183 (2015).

[Article](https://doi.org/10.1126%2Fscience.aaa9633) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2MXhtFWqtr%2FJ) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=26160946) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Autoassociative%20dynamics%20in%20the%20generation%20of%20sequences%20of%20hippocampal%20place%20cells&journal=Science&doi=10.1126%2Fscience.aaa9633&volume=349&pages=180-183&publication_year=2015&author=Pfeiffer%2CBE&author=Foster%2CDJ)

[^73]: Laje, R. & Buonomano, D. V. Robust timing and motor patterns by taming chaos in recurrent neural networks. *Nat. Neurosci.* **16**, 925–933 (2013).

[Article](https://doi.org/10.1038%2Fnn.3405) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC3sXot1Cjurc%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=23708144) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3753043) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Robust%20timing%20and%20motor%20patterns%20by%20taming%20chaos%20in%20recurrent%20neural%20networks&journal=Nat.%20Neurosci.&doi=10.1038%2Fnn.3405&volume=16&pages=925-933&publication_year=2013&author=Laje%2CR&author=Buonomano%2CDV)

[^74]: Kleinfeld, D. Sequential state generation by model neural networks. *Proc. Natl Acad. Sci. USA* **83**, 9469–9473 (1986).

[Article](https://doi.org/10.1073%2Fpnas.83.24.9469) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaL2s%2Fpt1aksA%3D%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=3467316) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC387161) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Sequential%20state%20generation%20by%20model%20neural%20networks&journal=Proc.%20Natl%20Acad.%20Sci.%20USA&doi=10.1073%2Fpnas.83.24.9469&volume=83&pages=9469-9473&publication_year=1986&author=Kleinfeld%2CD)

[^75]: Sompolinsky, H. & Kanter, I. Temporal association in asymmetric neural networks. *Phys. Rev. Lett.* **57**, 2861 (1986).

[Article](https://doi.org/10.1103%2FPhysRevLett.57.2861) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DC%2BC2sfotFarsw%3D%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=10033885) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Temporal%20association%20in%20asymmetric%20neural%20networks&journal=Phys.%20Rev.%20Lett.&doi=10.1103%2FPhysRevLett.57.2861&volume=57&publication_year=1986&author=Sompolinsky%2CH&author=Kanter%2CI)

[^76]: Fiete, I. R., Senn, W., Wang, C. Z. H. & Hahnloser, R. H. R. Spike-time-dependent plasticity and heterosynaptic competition organize networks to produce long scale-free sequences of neural activity. *Neuron* **65**, 563–576 (2010).

[Article](https://doi.org/10.1016%2Fj.neuron.2010.02.003) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC3cXltlWku7w%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=20188660) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Spike-time-dependent%20plasticity%20and%20heterosynaptic%20competition%20organize%20networks%20to%20produce%20long%20scale-free%20sequences%20of%20neural%20activity&journal=Neuron&doi=10.1016%2Fj.neuron.2010.02.003&volume=65&pages=563-576&publication_year=2010&author=Fiete%2CIR&author=Senn%2CW&author=Wang%2CCZH&author=Hahnloser%2CRHR)

[^77]: Taube, J. S., Muller, R. U. & Ranck, J. B. Jr. Head-direction cells recorded from the postsubiculum in freely moving rats. II. effects of environmental manipulations. *J. Neurosci.* **10**, 436–447 (1990).

[Article](https://doi.org/10.1523%2FJNEUROSCI.10-02-00436.1990) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaK3c7lsFCisQ%3D%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=2303852) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC6570161) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Head-direction%20cells%20recorded%20from%20the%20postsubiculum%20in%20freely%20moving%20rats.%20II.%20effects%20of%20environmental%20manipulations&journal=J.%20Neurosci.&doi=10.1523%2FJNEUROSCI.10-02-00436.1990&volume=10&pages=436-447&publication_year=1990&author=Taube%2CJS&author=Muller%2CRU&author=Ranck%2CJB)

[^78]: Yoon, K., Buice, M., Barry, R. C., Hayman, B. N. & Fiete, I. Specific evidence of low-dimensional continuous attractor dynamics in grid cells. *Nat. Neurosci.* **16**, 1077–1084 (2013). **By analysing grid cell data across environments, this work shows that pairwise correlations are preserved within a grid cell module, in agreement with continuous-attractor models**

[Article](https://doi.org/10.1038%2Fnn.3450) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC3sXhtFShsr%2FI) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=23852111) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3797513) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Specific%20evidence%20of%20low-dimensional%20continuous%20attractor%20dynamics%20in%20grid%20cells&journal=Nat.%20Neurosci.&doi=10.1038%2Fnn.3450&volume=16&pages=1077-1084&publication_year=2013&author=Yoon%2CK&author=Buice%2CM&author=Barry%2CRC&author=Hayman%2CBN&author=Fiete%2CI)

[^79]: Jun, J. J. et al. Fully integrated silicon probes for high-density recording of neural activity. *Nature* **551**, 232–236 (2017).

[Article](https://doi.org/10.1038%2Fnature24636) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2sXhsl2jtbbN) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=29120427) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC5955206) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Fully%20integrated%20silicon%20probes%20for%20high-density%20recording%20of%20neural%20activity&journal=Nature&doi=10.1038%2Fnature24636&volume=551&pages=232-236&publication_year=2017&author=Jun%2CJJ)

[^80]: Ahrens, M. B. et al. Brain-wide neuronal dynamics during motor adaptation in zebrafish. *Nature* **485**, 471–477 (2012).

[Article](https://doi.org/10.1038%2Fnature11057) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC38Xntlyqtrs%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=22622571) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3618960) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Brain-wide%20neuronal%20dynamics%20during%20motor%20adaptation%20in%20zebrafish&journal=Nature&doi=10.1038%2Fnature11057&volume=485&pages=471-477&publication_year=2012&author=Ahrens%2CMB)

[^81]: McNaughton, B. L., O’Keefe, J. & Barnes, C. A. The stereotrode: a new technique for simultaneous isolation of several single units in the central nervous system from multiple unit records. *J. Neurosci. Methods* **8**, 391–397 (1983).

[Article](https://doi.org/10.1016%2F0165-0270%2883%2990097-3) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaL2c%2Fht1Gnuw%3D%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=6621101) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20stereotrode%3A%20a%20new%20technique%20for%20simultaneous%20isolation%20of%20several%20single%20units%20in%20the%20central%20nervous%20system%20from%20multiple%20unit%20records&journal=J.%20Neurosci.%20Methods&doi=10.1016%2F0165-0270%2883%2990097-3&volume=8&pages=391-397&publication_year=1983&author=McNaughton%2CBL&author=O%E2%80%99Keefe%2CJ&author=Barnes%2CCA)

[^82]: Wilt, B. A. et al. Advances in light microscopy for neuroscience. *Annu. Rev. Neurosci.* **32**, 435–506 (2009).

[Article](https://doi.org/10.1146%2Fannurev.neuro.051508.135540) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD1MXpsV2nu7Y%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=19555292) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC2820375) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Advances%20in%20light%20microscopy%20for%20neuroscience&journal=Annu.%20Rev.%20Neurosci.&doi=10.1146%2Fannurev.neuro.051508.135540&volume=32&pages=435-506&publication_year=2009&author=Wilt%2CBA)

[^83]: Obaid, A. M. et al. Massively parallel microwire arrays integrated with CMOS chips for neural recording. *Sci. Adv.* [https://doi.org/10.1126/sciadv.aay2789](https://doi.org/10.1126/sciadv.aay2789) (2020).

[Article](https://doi.org/10.1126%2Fsciadv.aay2789) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=32219158) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC7083623) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Massively%20parallel%20microwire%20arrays%20integrated%20with%20CMOS%20chips%20for%20neural%20recording&journal=Sci.%20Adv.&doi=10.1126%2Fsciadv.aay2789&publication_year=2020&author=Obaid%2CAM)

[^84]: Weisenburger, S. & Vaziri, A. A guide to emerging technologies for large-scale and whole-brain optical imaging of neuronal activity. *Annu. Rev. Neurosci.* **41**, 431–452 (2018).

[Article](https://doi.org/10.1146%2Fannurev-neuro-072116-031458) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC1cXosFyrtbw%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=29709208) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC6037565) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=A%20guide%20to%20emerging%20technologies%20for%20large-scale%20and%20whole-brain%20optical%20imaging%20of%20neuronal%20activity&journal=Annu.%20Rev.%20Neurosci.&doi=10.1146%2Fannurev-neuro-072116-031458&volume=41&pages=431-452&publication_year=2018&author=Weisenburger%2CS&author=Vaziri%2CA)

[^85]: Steinmetz, N. A. et al. Neuropixels 2.0: a miniaturized high-density probe for stable, long-term brain recordings. *Science* **372**, eabf4588 (2020).

[Article](https://doi.org/10.1126%2Fscience.abf4588) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Neuropixels%202.0%3A%20a%20miniaturized%20high-density%20probe%20for%20stable%2C%20long-term%20brain%20recordings&journal=Science&doi=10.1126%2Fscience.abf4588&volume=372&publication_year=2020&author=Steinmetz%2CNA)

[^86]: Churchland, M. M. et al. Neural population dynamics during reaching. *Nature* **487**, 51–56 (2012).

[Article](https://doi.org/10.1038%2Fnature11129) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC38XpvVSru70%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=22722855) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3393826) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Neural%20population%20dynamics%20during%20reaching&journal=Nature&doi=10.1038%2Fnature11129&volume=487&pages=51-56&publication_year=2012&author=Churchland%2CMM)

[^87]: Wimmer, K., Nykamp, D. Q., Constantinidis, C. & Compte, A. Bump attractor dynamics in prefrontal cortex explains behavioral precision in spatial working memory. *Nat. Neurosci.* **17**, 431–439 (2014).

[Article](https://doi.org/10.1038%2Fnn.3645) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2cXhsF2qt70%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=24487232) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Bump%20attractor%20dynamics%20in%20prefrontal%20cortex%20explains%20behavioral%20precision%20in%20spatial%20working%20memory&journal=Nat.%20Neurosci.&doi=10.1038%2Fnn.3645&volume=17&pages=431-439&publication_year=2014&author=Wimmer%2CK&author=Nykamp%2CDQ&author=Constantinidis%2CC&author=Compte%2CA)

[^88]: Low, R. J., Lewallen, S., Aronov, D., Nevers, R. & Tank, D. W. Probing variability in a cognitive map using manifold inference from neural dynamics. Preprint at *bioRxiv* [https://doi.org/10.1101/418939](https://doi.org/10.1101/418939) (2018).

[Article](https://doi.org/10.1101%2F418939) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Probing%20variability%20in%20a%20cognitive%20map%20using%20manifold%20inference%20from%20neural%20dynamics&journal=bioRxiv&doi=10.1101%2F418939&publication_year=2018&author=Low%2CRJ&author=Lewallen%2CS&author=Aronov%2CD&author=Nevers%2CR&author=Tank%2CDW)

[^89]: Pandarinath, C. et al. Inferring single-trial neural population dynamics using sequential auto-encoders. *Nat. Methods* **15**, 805–815 (2018).

[Article](https://doi.org/10.1038%2Fs41592-018-0109-9) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC1cXhslCjt7%2FO) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=30224673) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC6380887) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Inferring%20single-trial%20neural%20population%20dynamics%20using%20sequential%20auto-encoders&journal=Nat.%20Methods&doi=10.1038%2Fs41592-018-0109-9&volume=15&pages=805-815&publication_year=2018&author=Pandarinath%2CC)

[^90]: Roweis, S. T. & Saul, L. K. Nonlinear dimensionality reduction by locally linear embedding. *Science* **290**, 2323–2326 (2000).

[Article](https://doi.org/10.1126%2Fscience.290.5500.2323) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DC%2BD3M%2Fnt1yiug%3D%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=11125150) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Nonlinear%20dimensionality%20reduction%20by%20locally%20linear%20embedding&journal=Science&doi=10.1126%2Fscience.290.5500.2323&volume=290&pages=2323-2326&publication_year=2000&author=Roweis%2CST&author=Saul%2CLK)

[^91]: Van der Maaten, L. & Hinton, G. Visualizing data using t-SNE. *J. Mach. Learn. Res.* **9**, 2579–2605 (2008).

[Google Scholar](http://scholar.google.com/scholar_lookup?&title=Visualizing%20data%20using%20t-SNE&journal=J.%20Mach.%20Learn.%20Res.&volume=9&pages=2579-2605&publication_year=2008&author=Maaten%2CL&author=Hinton%2CG)

[^92]: Tenenbaum, J. B. A global geometric framework for nonlinear dimensionality reduction. *Science* **290**, 2319–2323 (2000).

[Article](https://doi.org/10.1126%2Fscience.290.5500.2319) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DC%2BD3M%2Fnt1yitQ%3D%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=11125149) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=A%20global%20geometric%20framework%20for%20nonlinear%20dimensionality%20reduction&journal=Science&doi=10.1126%2Fscience.290.5500.2319&volume=290&pages=2319-2323&publication_year=2000&author=Tenenbaum%2CJB)

[^93]: Wu, A., Pashkovski, S., Datta, S. R. & Pillow, J. W. Learning a latent manifold of odor representations from neural responses in piriform cortex. In *Advances in Neural Information Processing Systems* 5378–5388 (NeurIPS, 2018).

[^94]: Zomorodian, A. & Carlsson, G. Computing persistent homology. *Discret. Comput. Geom.* **33**, 249–274 (2005).

[Article](https://link.springer.com/doi/10.1007/s00454-004-1146-y) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Computing%20persistent%20homology&journal=Discret.%20Comput.%20Geom.&doi=10.1007%2Fs00454-004-1146-y&volume=33&pages=249-274&publication_year=2005&author=Zomorodian%2CA&author=Carlsson%2CG)

[^95]: Ghrist, R. Barcodes: the persistent topology of data. *Bull. Am. Math. Soc.* **45**, 61–75 (2008).

[Article](https://doi.org/10.1090%2FS0273-0979-07-01191-3) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Barcodes%3A%20the%20persistent%20topology%20of%20data&journal=Bull.%20Am.%20Math.%20Soc.&doi=10.1090%2FS0273-0979-07-01191-3&volume=45&pages=61-75&publication_year=2008&author=Ghrist%2CR)

[^96]: Carlsson, G., Ishkhanov, T., de Silva, V. & Zornorodian, A. On the local behavior of spaces of natural images. *Int. J. Comput. Vis.* **76**, 1–12 (2008).

[Article](https://link.springer.com/doi/10.1007/s11263-007-0056-x) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=On%20the%20local%20behavior%20of%20spaces%20of%20natural%20images&journal=Int.%20J.%20Comput.%20Vis.&doi=10.1007%2Fs11263-007-0056-x&volume=76&pages=1-12&publication_year=2008&author=Carlsson%2CG&author=Ishkhanov%2CT&author=Silva%2CV&author=Zornorodian%2CA)

[^97]: Rybakken, E., Baas, N. & Dunn, B. Decoding of neural data using cohomological feature extraction. *Neural Comput.* **31**, 68–93 (2019).

[Article](https://doi.org/10.1162%2Fneco_a_01150) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=30462582) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Decoding%20of%20neural%20data%20using%20cohomological%20feature%20extraction&journal=Neural%20Comput.&doi=10.1162%2Fneco_a_01150&volume=31&pages=68-93&publication_year=2019&author=Rybakken%2CE&author=Baas%2CN&author=Dunn%2CB)

[^98]: Singh, G. et al. Topological analysis of population activity in visual cortex. *J. Vis.* **8**, 11 (2008).

[Article](https://doi.org/10.1167%2F8.8.11) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=18831634) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Topological%20analysis%20of%20population%20activity%20in%20visual%20cortex&journal=J.%20Vis.&doi=10.1167%2F8.8.11&volume=8&publication_year=2008&author=Singh%2CG)

[^99]: Taube, J. S., Muller, R. U. & Ranck, J. B. Jr. Head-direction cells recorded from the postsubiculum in freely moving rats. I. description and quantitative analysis. *J. Neurosci.* **10**, 420–435 (1990).

[Article](https://doi.org/10.1523%2FJNEUROSCI.10-02-00420.1990) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaK3c7lsFCisA%3D%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=2303851) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC6570151) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Head-direction%20cells%20recorded%20from%20the%20postsubiculum%20in%20freely%20moving%20rats.%20I.%20description%20and%20quantitative%20analysis&journal=J.%20Neurosci.&doi=10.1523%2FJNEUROSCI.10-02-00420.1990&volume=10&pages=420-435&publication_year=1990&author=Taube%2CJS&author=Muller%2CRU&author=Ranck%2CJB)

[^100]: Yoganarasimha, D., Yu, X. & Knierim, J. J. Head direction cell representations maintain internal coherence during conflicting proximal and distal cue rotations: comparison with hippocampal place cells. *J. Neurosci.* **26**, 622–631 (2006).

[Article](https://doi.org/10.1523%2FJNEUROSCI.3885-05.2006) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD28XosFWqtw%3D%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=16407560) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC1388189) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Head%20direction%20cell%20representations%20maintain%20internal%20coherence%20during%20conflicting%20proximal%20and%20distal%20cue%20rotations%3A%20comparison%20with%20hippocampal%20place%20cells&journal=J.%20Neurosci.&doi=10.1523%2FJNEUROSCI.3885-05.2006&volume=26&pages=622-631&publication_year=2006&author=Yoganarasimha%2CD&author=Yu%2CX&author=Knierim%2CJJ)

[^101]: Trettel, S., Trimper, J., Hwaun, E., Fiete, I. & Colgin, L. Grid cell co-activity patterns during sleep reflect spatial overlap of grid fields during active behaviors. *Nat. Neurosci.* **22**, 609–617 (2019).

[Article](https://doi.org/10.1038%2Fs41593-019-0359-6) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC1MXotl2qtbk%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=30911183) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC7412059) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Grid%20cell%20co-activity%20patterns%20during%20sleep%20reflect%20spatial%20overlap%20of%20grid%20fields%20during%20active%20behaviors&journal=Nat.%20Neurosci.&doi=10.1038%2Fs41593-019-0359-6&volume=22&pages=609-617&publication_year=2019&author=Trettel%2CS&author=Trimper%2CJ&author=Hwaun%2CE&author=Fiete%2CI&author=Colgin%2CL)

[^102]: Gardner, R. J., Lu, L., Wernle, T., Moser, M.-B. & Moser, E. I. Correlation structure of grid cells is preserved during sleep. *Nat. Neurosci.* **22**, 598–608 (2019).

[Article](https://doi.org/10.1038%2Fs41593-019-0360-0) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC1MXotl2qtbc%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=30911185) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Correlation%20structure%20of%20grid%20cells%20is%20preserved%20during%20sleep&journal=Nat.%20Neurosci.&doi=10.1038%2Fs41593-019-0360-0&volume=22&pages=598-608&publication_year=2019&author=Gardner%2CRJ&author=Lu%2CL&author=Wernle%2CT&author=Moser%2CM-B&author=Moser%2CEI)

[^103]: Widloski, J., Marder, M. P. & Fiete, I. R. Inferring circuit mechanisms from sparse neural recording and global perturbation in grid cells. *eLife* **7**, e33503 (2018).

[Article](https://doi.org/10.7554%2FeLife.33503) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=29985132) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC6078497) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Inferring%20circuit%20mechanisms%20from%20sparse%20neural%20recording%20and%20global%20perturbation%20in%20grid%20cells&journal=eLife&doi=10.7554%2FeLife.33503&volume=7&publication_year=2018&author=Widloski%2CJ&author=Marder%2CMP&author=Fiete%2CIR)

[^104]: Cossart, R., Aronov, D. & Yuste, R. Attractor dynamics of network up states in the neocortex. *Nature* **423**, 283–288 (2003).

[Article](https://doi.org/10.1038%2Fnature01614) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD3sXjs1ynur0%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=12748641) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Attractor%20dynamics%20of%20network%20up%20states%20in%20the%20neocortex&journal=Nature&doi=10.1038%2Fnature01614&volume=423&pages=283-288&publication_year=2003&author=Cossart%2CR&author=Aronov%2CD&author=Yuste%2CR)

[^105]: Jercog, D. et al. UP–DOWN cortical dynamics reflect state transitions in a bistable network. *eLife* **6**, e22425 (2017).

[Article](https://doi.org/10.7554%2FeLife.22425) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=28826485) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC5582872) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=UP%E2%80%93DOWN%20cortical%20dynamics%20reflect%20state%20transitions%20in%20a%20bistable%20network&journal=eLife&doi=10.7554%2FeLife.22425&volume=6&publication_year=2017&author=Jercog%2CD)

[^106]: Sanchez-Vives, M. V., Massimini, M. & Mattia, M. Shaping the default activity pattern of the cortical network. *Neuron* **94**, 993–1001 (2017).

[Article](https://doi.org/10.1016%2Fj.neuron.2017.05.015) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2sXpvVKgu7g%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=28595056) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Shaping%20the%20default%20activity%20pattern%20of%20the%20cortical%20network&journal=Neuron&doi=10.1016%2Fj.neuron.2017.05.015&volume=94&pages=993-1001&publication_year=2017&author=Sanchez-Vives%2CMV&author=Massimini%2CM&author=Mattia%2CM)

[^107]: Scarpetta, S. & de Candia, A. Alternation of up and down states at a dynamical phase-transition of a neural network with spatiotemporal attractors. *Front. Syst. Neurosci.* **8**, 88 (2014).

[Article](https://doi.org/10.3389%2Ffnsys.2014.00088) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=24904311) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4032888) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Alternation%20of%20up%20and%20down%20states%20at%20a%20dynamical%20phase-transition%20of%20a%20neural%20network%20with%20spatiotemporal%20attractors&journal=Front.%20Syst.%20Neurosci.&doi=10.3389%2Ffnsys.2014.00088&volume=8&publication_year=2014&author=Scarpetta%2CS&author=Candia%2CA)

[^108]: Jercog, D. et al. Up-down cortical dynamics reflect state transitions in a bistable network. *eLife* **6**, e22425 (2017).

[Article](https://doi.org/10.7554%2FeLife.22425) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=28826485) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC5582872) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Up-down%20cortical%20dynamics%20reflect%20state%20transitions%20in%20a%20bistable%20network&journal=eLife&doi=10.7554%2FeLife.22425&volume=6&publication_year=2017&author=Jercog%2CD)

[^109]: Latham, P. E., Richmond, B., Nelson, P. & Nirenberg, S. Intrinsic dynamics in neuronal networks. I. Theory. *J. Neurophysiol.* **83**, 808–827 (2000).

[Article](https://doi.org/10.1152%2Fjn.2000.83.2.808) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DC%2BD3c7jsVKmtg%3D%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=10669496) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Intrinsic%20dynamics%20in%20neuronal%20networks.%20I.%20Theory&journal=J.%20Neurophysiol.&doi=10.1152%2Fjn.2000.83.2.808&volume=83&pages=808-827&publication_year=2000&author=Latham%2CPE&author=Richmond%2CB&author=Nelson%2CP&author=Nirenberg%2CS)

[^110]: Compte, A., Sanchez-Vives, M. V., McCormick, D. A. & Wang, X.-J. Cellular and network mechanisms of slow oscillatory activity (<1 Hz) and wave propagations in a cortical network model. *J. Neurophysiol.* **89**, 2707–2725 (2003).

[Article](https://doi.org/10.1152%2Fjn.00845.2002) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=12612051) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Cellular%20and%20network%20mechanisms%20of%20slow%20oscillatory%20activity%20%28%3C1%E2%80%89Hz%29%20and%20wave%20propagations%20in%20a%20cortical%20network%20model&journal=J.%20Neurophysiol.&doi=10.1152%2Fjn.00845.2002&volume=89&pages=2707-2725&publication_year=2003&author=Compte%2CA&author=Sanchez-Vives%2CMV&author=McCormick%2CDA&author=Wang%2CX-J)

[^111]: Kasanetz, F., Riquelme, L. A., O’Donnell, P. & Murer, M. G. Turning off cortical ensembles stops striatal up states and elicits phase perturbations in cortical and striatal slow oscillations in rat in vivo. *J. Physiol.* **577**, 97–113 (2006).

[Article](https://doi.org/10.1113%2Fjphysiol.2006.113050) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD28Xht1yqsL%2FE) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=16931555) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC2000673) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Turning%20off%20cortical%20ensembles%20stops%20striatal%20up%20states%20and%20elicits%20phase%20perturbations%20in%20cortical%20and%20striatal%20slow%20oscillations%20in%20rat%20in%20vivo&journal=J.%20Physiol.&doi=10.1113%2Fjphysiol.2006.113050&volume=577&pages=97-113&publication_year=2006&author=Kasanetz%2CF&author=Riquelme%2CLA&author=O%E2%80%99Donnell%2CP&author=Murer%2CMG)

[^112]: Rigas, P. & Castro-Alamancos, M. A. Thalamocortical up states: differential effects of intrinsic and extrinsic cortical inputs on persistent activity. *J. Neurosci.* **27**, 4261–4272 (2007).

[Article](https://doi.org/10.1523%2FJNEUROSCI.0003-07.2007) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD2sXkvFCjsbs%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=17442810) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC6672324) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Thalamocortical%20up%20states%3A%20differential%20effects%20of%20intrinsic%20and%20extrinsic%20cortical%20inputs%20on%20persistent%20activity&journal=J.%20Neurosci.&doi=10.1523%2FJNEUROSCI.0003-07.2007&volume=27&pages=4261-4272&publication_year=2007&author=Rigas%2CP&author=Castro-Alamancos%2CMA)

[^113]: McCormick, D. A., McGinley, M. J. & Salkoff, D. B. Brain state dependent activity in the cortex and thalamus. *Curr. Opin. Neurobiol.* **31**, 133–140 (2015).

[Article](https://doi.org/10.1016%2Fj.conb.2014.10.003) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2cXhslKjtrvM) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=25460069) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Brain%20state%20dependent%20activity%20in%20the%20cortex%20and%20thalamus&journal=Curr.%20Opin.%20Neurobiol.&doi=10.1016%2Fj.conb.2014.10.003&volume=31&pages=133-140&publication_year=2015&author=McCormick%2CDA&author=McGinley%2CMJ&author=Salkoff%2CDB)

[^114]: Deutsch, D. An auditory illusion. *Nature* **251**, 307–309 (1974).

[Article](https://doi.org/10.1038%2F251307a0) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaE2M%2FksFaktQ%3D%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=4427654) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=An%20auditory%20illusion&journal=Nature&doi=10.1038%2F251307a0&volume=251&pages=307-309&publication_year=1974&author=Deutsch%2CD)

[^115]: Ward, E. J. & Scholl, B. J. Stochastic or systematic? Seemingly random perceptual switching in bistable events triggered by transient unconscious cues. *J. Exp. Psychol. Hum. Percept. Perform.* **41**, 929 (2015).

[Article](https://doi.org/10.1037%2Fa0038709) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=25915074) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Stochastic%20or%20systematic%3F%20Seemingly%20random%20perceptual%20switching%20in%20bistable%20events%20triggered%20by%20transient%20unconscious%20cues&journal=J.%20Exp.%20Psychol.%20Hum.%20Percept.%20Perform.&doi=10.1037%2Fa0038709&volume=41&publication_year=2015&author=Ward%2CEJ&author=Scholl%2CBJ)

[^116]: Blake, R. & Logothetis, N. K. Visual competition. *Nat. Rev. Neurosci.* **3**, 13–21 (2002).

[Article](https://doi.org/10.1038%2Fnrn701) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD38XhsVyiu74%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=11823801) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Visual%20competition&journal=Nat.%20Rev.%20Neurosci.&doi=10.1038%2Fnrn701&volume=3&pages=13-21&publication_year=2002&author=Blake%2CR&author=Logothetis%2CNK)

[^117]: McWalter, R. & McDermott, J. H. Illusory sound texture reveals multi-second statistical completion in auditory scene analysis. *Nat. Commun.* **10**, 1–18 (2019).

[Article](https://doi.org/10.1038%2Fs41467-019-12893-0) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC1MXitFGisbrE) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Illusory%20sound%20texture%20reveals%20multi-second%20statistical%20completion%20in%20auditory%20scene%20analysis&journal=Nat.%20Commun.&doi=10.1038%2Fs41467-019-12893-0&volume=10&pages=1-18&publication_year=2019&author=McWalter%2CR&author=McDermott%2CJH)

[^118]: Wang, M., Arteaga, D. & He, B. J. Brain mechanisms for simple perception and bistable perception. *Proc. Natl Acad. Sci. USA* **110**, E3350–E3359 (2013).

[CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC3sXhsVCgt73J) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=23942129) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3761598) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Brain%20mechanisms%20for%20simple%20perception%20and%20bistable%20perception&journal=Proc.%20Natl%20Acad.%20Sci.%20USA&volume=110&pages=E3350-E3359&publication_year=2013&author=Wang%2CM&author=Arteaga%2CD&author=He%2CBJ)

[^119]: Vattikuti, S. et al. Canonical cortical circuit model explains rivalry, intermittent rivalry, and rivalry memory. *PLoS Comput. Biol.* **12**, e1004903 (2016).

[Article](https://doi.org/10.1371%2Fjournal.pcbi.1004903) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=27138214) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4854419) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Canonical%20cortical%20circuit%20model%20explains%20rivalry%2C%20intermittent%20rivalry%2C%20and%20rivalry%20memory&journal=PLoS%20Comput.%20Biol.&doi=10.1371%2Fjournal.pcbi.1004903&volume=12&publication_year=2016&author=Vattikuti%2CS)

[^120]: Moreno-Bote, R., Rinzel, J. & Rubin, N. Noise-induced alternations in an attractor network model of perceptual bistability. *J. Neurophysiol.* **98**, 1125–1139 (2007).

[Article](https://doi.org/10.1152%2Fjn.00116.2007) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=17615138) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Noise-induced%20alternations%20in%20an%20attractor%20network%20model%20of%20perceptual%20bistability&journal=J.%20Neurophysiol.&doi=10.1152%2Fjn.00116.2007&volume=98&pages=1125-1139&publication_year=2007&author=Moreno-Bote%2CR&author=Rinzel%2CJ&author=Rubin%2CN)

[^121]: Inagaki, H. K., Fontolan, L., Romani, S. & Svoboda, K. Discrete attractor dynamics underlies persistent activity in the frontal cortex. *Nature* **566**, 212–217 (2019). **This work tests the predictions of discrete attractor dynamics in the rodent ALM using optogenetic perturbations**

[Article](https://doi.org/10.1038%2Fs41586-019-0919-7) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC1MXmt1yns7w%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=30728503) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Discrete%20attractor%20dynamics%20underlies%20persistent%20activity%20in%20the%20frontal%20cortex&journal=Nature&doi=10.1038%2Fs41586-019-0919-7&volume=566&pages=212-217&publication_year=2019&author=Inagaki%2CHK&author=Fontolan%2CL&author=Romani%2CS&author=Svoboda%2CK)

[^122]: Li, N., Daie, K., Svoboda, K. & Druckmann, S. Robust neuronal dynamics in premotor cortex during motor planning. *Nature* **532**, 459–464 (2016).

[Article](https://doi.org/10.1038%2Fnature17643) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC28XmsValt7o%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=27074502) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC5081260) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Robust%20neuronal%20dynamics%20in%20premotor%20cortex%20during%20motor%20planning&journal=Nature&doi=10.1038%2Fnature17643&volume=532&pages=459-464&publication_year=2016&author=Li%2CN&author=Daie%2CK&author=Svoboda%2CK&author=Druckmann%2CS)

[^123]: Piet, A. T., Erlich, J. C., Kopec, C. D. & Brody, C. D. Rat prefrontal cortex inactivations during decision making are explained by bistable attractor dynamics. *Neural Comput.* **29**, 2861–2886 (2017).

[Article](https://doi.org/10.1162%2Fneco_a_01005) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=28777728) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC6535097) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Rat%20prefrontal%20cortex%20inactivations%20during%20decision%20making%20are%20explained%20by%20bistable%20attractor%20dynamics&journal=Neural%20Comput.&doi=10.1162%2Fneco_a_01005&volume=29&pages=2861-2886&publication_year=2017&author=Piet%2CAT&author=Erlich%2CJC&author=Kopec%2CCD&author=Brody%2CCD)

[^124]: Erlich, J. C., Brunton, B. W., Duan, C. A., Hanks, T. D. & Brody, C. D. Distinct effects of prefrontal and parietal cortex inactivations on an accumulation of evidence task in the rat. *eLife* **4**, e05457 (2015).

[Article](https://doi.org/10.7554%2FeLife.05457) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4392479) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Distinct%20effects%20of%20prefrontal%20and%20parietal%20cortex%20inactivations%20on%20an%20accumulation%20of%20evidence%20task%20in%20the%20rat&journal=eLife&doi=10.7554%2FeLife.05457&volume=4&publication_year=2015&author=Erlich%2CJC&author=Brunton%2CBW&author=Duan%2CCA&author=Hanks%2CTD&author=Brody%2CCD)

[^125]: Inagaki, H. K., Inagaki, M., Romani, S. & Svoboda, K. Low-dimensional and monotonic preparatory activity in mouse anterior lateral motor cortex. *J. Neurosci.* **38**, 4163–4185 (2018).

[Article](https://doi.org/10.1523%2FJNEUROSCI.3152-17.2018) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC1cXhvVemtbbE) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=29593054) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC6596025) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Low-dimensional%20and%20monotonic%20preparatory%20activity%20in%20mouse%20anterior%20lateral%20motor%20cortex&journal=J.%20Neurosci.&doi=10.1523%2FJNEUROSCI.3152-17.2018&volume=38&pages=4163-4185&publication_year=2018&author=Inagaki%2CHK&author=Inagaki%2CM&author=Romani%2CS&author=Svoboda%2CK)

[^126]: Daie, K., Svoboda, K. & Druckmann, S. Targeted photostimulation uncovers circuit motifs supporting short-term memory. *Nat. Neurosci.* **24**, 259–265 (2021).

[Article](https://doi.org/10.1038%2Fs41593-020-00776-3) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BB3MXitFaisr8%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=33495637) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Targeted%20photostimulation%20uncovers%20circuit%20motifs%20supporting%20short-term%20memory&journal=Nat.%20Neurosci.&doi=10.1038%2Fs41593-020-00776-3&volume=24&pages=259-265&publication_year=2021&author=Daie%2CK&author=Svoboda%2CK&author=Druckmann%2CS)

[^127]: Lazzaro, J., Ryckebusch, S., Mahowald, M. A. & Mead, C. A. Winner-take-all networks of O(N) complexity. In *Advances in Neural Information Processing Systems* 703–711 (NeurIPS, 1989).

[^128]: Xie, X., Hahnloser, R. H. & Seung, H. S. Selectively grouping neurons in recurrent networks of lateral inhibition. *Neural Comput.* **14**, 2627–2646 (2002).

[Article](https://doi.org/10.1162%2F089976602760408008) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=12433293) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Selectively%20grouping%20neurons%20in%20recurrent%20networks%20of%20lateral%20inhibition&journal=Neural%20Comput.&doi=10.1162%2F089976602760408008&volume=14&pages=2627-2646&publication_year=2002&author=Xie%2CX&author=Hahnloser%2CRH&author=Seung%2CHS)

[^129]: Majani, E., Erlanson, R. & Abu-Mostafa, Y. S. On the K-winners-take-all network. In *Advances in Neural Information Processing Systems* 634–642 (NeurIPS, 1989).

[^130]: Bolding, K. A. & Franks, K. M. Recurrent cortical circuits implement concentration-invariant odor coding. *Science* **361**, eaat6904 (2018).

[Article](https://doi.org/10.1126%2Fscience.aat6904) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=30213885) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC6492549) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Recurrent%20cortical%20circuits%20implement%20concentration-invariant%20odor%20coding&journal=Science&doi=10.1126%2Fscience.aat6904&volume=361&publication_year=2018&author=Bolding%2CKA&author=Franks%2CKM)

[^131]: Sreenivasan, S. & Fiete, I. Grid cells generate an analog error-correcting code for singularly precise neural computation. *Nat. Neurosci.* **14**, 1330–1337 (2011).

[Article](https://doi.org/10.1038%2Fnn.2901) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC3MXhtFGnurnE) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=21909090) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Grid%20cells%20generate%20an%20analog%20error-correcting%20code%20for%20singularly%20precise%20neural%20computation&journal=Nat.%20Neurosci.&doi=10.1038%2Fnn.2901&volume=14&pages=1330-1337&publication_year=2011&author=Sreenivasan%2CS&author=Fiete%2CI)

[^132]: de Almeida, L., Idiart, M. & Lisman, J. E. The input–output transformation of the hippocampal granule cells: from grid cells to place fields. *J. Neurosci.* **29**, 7504–7512 (2009).

[Article](https://doi.org/10.1523%2FJNEUROSCI.6048-08.2009) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=19515918) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC2747669) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20input%E2%80%93output%20transformation%20of%20the%20hippocampal%20granule%20cells%3A%20from%20grid%20cells%20to%20place%20fields&journal=J.%20Neurosci.&doi=10.1523%2FJNEUROSCI.6048-08.2009&volume=29&pages=7504-7512&publication_year=2009&author=Almeida%2CL&author=Idiart%2CM&author=Lisman%2CJE)

[^133]: Espinoza, C., Guzman, S. J., Zhang, X. & Jonas, P. Parvalbumin + interneurons obey unique connectivity rules and establish a powerful lateral-inhibition microcircuit in dentate gyrus. *Nat. Commun.* **9**, 4605 (2018).

[Article](https://doi.org/10.1038%2Fs41467-018-06899-3) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=30389916) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC6214995) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Parvalbumin%E2%80%89%2B%E2%80%89interneurons%20obey%20unique%20connectivity%20rules%20and%20establish%20a%20powerful%20lateral-inhibition%20microcircuit%20in%20dentate%20gyrus&journal=Nat.%20Commun.&doi=10.1038%2Fs41467-018-06899-3&volume=9&publication_year=2018&author=Espinoza%2CC&author=Guzman%2CSJ&author=Zhang%2CX&author=Jonas%2CP)

[^134]: Kurt, S. et al. Auditory cortical contrast enhancing by global winner-take-all inhibitory interactions. *PLoS ONE* **3**, e1735 (2008).

[Article](https://doi.org/10.1371%2Fjournal.pone.0001735) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=18320054) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC2253823) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Auditory%20cortical%20contrast%20enhancing%20by%20global%20winner-take-all%20inhibitory%20interactions&journal=PLoS%20ONE&doi=10.1371%2Fjournal.pone.0001735&volume=3&publication_year=2008&author=Kurt%2CS)

[^135]: Josselyn, S. A. & Tonegawa, S. Memory engrams: recalling the past and imagining the future. *Science* **367 6473**, eaaw4325 (2020).

[Article](https://doi.org/10.1126%2Fscience.aaw4325) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BB3cXmvFeqtQ%3D%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=31896692) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC7577560) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Memory%20engrams%3A%20recalling%20the%20past%20and%20imagining%20the%20future&journal=Science&doi=10.1126%2Fscience.aaw4325&volume=367&issue=6473&publication_year=2020&author=Josselyn%2CSA&author=Tonegawa%2CS)

[^136]: Lin, A. C., Bygrave, A. M., de Calignon, A., Lee, T. & Miesenböck, G. Sparse, decorrelated odor coding in the mushroom body enhances learned odor discrimination. *Nat. Neurosci.* **17**, 559–568 (2014).

[Article](https://doi.org/10.1038%2Fnn.3660) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2cXivFahu7s%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=24561998) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4000970) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Sparse%2C%20decorrelated%20odor%20coding%20in%20the%20mushroom%20body%20enhances%20learned%20odor%20discrimination&journal=Nat.%20Neurosci.&doi=10.1038%2Fnn.3660&volume=17&pages=559-568&publication_year=2014&author=Lin%2CAC&author=Bygrave%2CAM&author=Calignon%2CA&author=Lee%2CT&author=Miesenb%C3%B6ck%2CG)

[^137]: Stevens, C. F. What the fly’s nose tells the fly’s brain. *Proc. Natl Acad. Sci. USA* **112**, 9460–9465 (2015).

[Article](https://doi.org/10.1073%2Fpnas.1510103112) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2MXhtFWqu7bE) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=26150492) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4522789) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=What%20the%20fly%E2%80%99s%20nose%20tells%20the%20fly%E2%80%99s%20brain&journal=Proc.%20Natl%20Acad.%20Sci.%20USA&doi=10.1073%2Fpnas.1510103112&volume=112&pages=9460-9465&publication_year=2015&author=Stevens%2CCF)

[^138]: Arnold, D. & Robinson, D. The oculomotor integrator: testing of a neural network model. *Exp. Brain Res.* **113**, 57–74 (1997).

[Article](https://link.springer.com/doi/10.1007/BF02454142) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaK2s7otVGquw%3D%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=9028775) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20oculomotor%20integrator%3A%20testing%20of%20a%20neural%20network%20model&journal=Exp.%20Brain%20Res.&doi=10.1007%2FBF02454142&volume=113&pages=57-74&publication_year=1997&author=Arnold%2CD&author=Robinson%2CD)

[^139]: Aksay, E., Gamkrelidze, G., Seung, H. S., Baker, R. & Tank, D. W. In vivo intracellular recording and perturbation of persistent activity in a neural integrator. *Nat. Neurosci.* **4**, 184–193 (2001). **This work tests the predictions of line attractor dynamics in the goldfish oculomotor integrator using in vivo intracellular current perturbations**

[Article](https://doi.org/10.1038%2F84023) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD3MXhtVSnu7c%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=11175880) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=In%20vivo%20intracellular%20recording%20and%20perturbation%20of%20persistent%20activity%20in%20a%20neural%20integrator&journal=Nat.%20Neurosci.&doi=10.1038%2F84023&volume=4&pages=184-193&publication_year=2001&author=Aksay%2CE&author=Gamkrelidze%2CG&author=Seung%2CHS&author=Baker%2CR&author=Tank%2CDW)

[^140]: Pastor, A., Cruz, L. D. R. & Baker, R. Eye position and eye velocity integrators reside in separate brainstem nuclei. *Proc. Natl Acad. Sci. USA* **91**, 807–811 (1994).

[Article](https://doi.org/10.1073%2Fpnas.91.2.807) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaK2c7hvF2ktw%3D%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=8290604) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC43038) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Eye%20position%20and%20eye%20velocity%20integrators%20reside%20in%20separate%20brainstem%20nuclei&journal=Proc.%20Natl%20Acad.%20Sci.%20USA&doi=10.1073%2Fpnas.91.2.807&volume=91&pages=807-811&publication_year=1994&author=Pastor%2CA&author=Cruz%2CLDR&author=Baker%2CR)

[^141]: Cannon, C. & Robinson, D. Loss of the neural integrator of the oculomotor system from brain stem lesions in monkey. *J. Neurophys.* **57**, 1383–1409 (1987).

[Article](https://doi.org/10.1152%2Fjn.1987.57.5.1383) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaL2s3isFWmtg%3D%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Loss%20of%20the%20neural%20integrator%20of%20the%20oculomotor%20system%20from%20brain%20stem%20lesions%20in%20monkey&journal=J.%20Neurophys.&doi=10.1152%2Fjn.1987.57.5.1383&volume=57&pages=1383-1409&publication_year=1987&author=Cannon%2CC&author=Robinson%2CD)

[^142]: Mettens, P., Godaux, E., Cheron, G. & Galiana, H. Effect of muscimol microinjections into the prepositus hypoglossi and the medial vestibular nuclei on cat eye movements. *J. Neurophysiol.* **72**, 785–802 (1994).

[Article](https://doi.org/10.1152%2Fjn.1994.72.2.785) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DyaK2MXhslynt78%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=7983536) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Effect%20of%20muscimol%20microinjections%20into%20the%20prepositus%20hypoglossi%20and%20the%20medial%20vestibular%20nuclei%20on%20cat%20eye%20movements&journal=J.%20Neurophysiol.&doi=10.1152%2Fjn.1994.72.2.785&volume=72&pages=785-802&publication_year=1994&author=Mettens%2CP&author=Godaux%2CE&author=Cheron%2CG&author=Galiana%2CH)

[^143]: Kaneko, C. R. Eye movement deficits after ibotenic acid lesions of the nucleus prepositus hypoglossi in monkeys. I. Saccades and fixation. *J. Neurophysiol.* **78**, 1753–1768 (1997).

[Article](https://doi.org/10.1152%2Fjn.1997.78.4.1753) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaK2svmslajsw%3D%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=9325345) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Eye%20movement%20deficits%20after%20ibotenic%20acid%20lesions%20of%20the%20nucleus%20prepositus%20hypoglossi%20in%20monkeys.%20I.%20Saccades%20and%20fixation&journal=J.%20Neurophysiol.&doi=10.1152%2Fjn.1997.78.4.1753&volume=78&pages=1753-1768&publication_year=1997&author=Kaneko%2CCR)

[^144]: Major, G. et al. Plasticity and tuning by visual feedback of the stability of a neural integrator. *Proc. Natl Acad. Sci. USA* **101**, 7739–7744 (2004).

[Article](https://doi.org/10.1073%2Fpnas.0401970101) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD2cXktlOlu78%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=15136746) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC419676) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Plasticity%20and%20tuning%20by%20visual%20feedback%20of%20the%20stability%20of%20a%20neural%20integrator&journal=Proc.%20Natl%20Acad.%20Sci.%20USA&doi=10.1073%2Fpnas.0401970101&volume=101&pages=7739-7744&publication_year=2004&author=Major%2CG)

[^145]: Vishwanathan, A. et al. Electron microscopic reconstruction of functionally identified cells in a neural integrator. *Curr. Biol.* **27**, 2137–2147 (2017).

[Article](https://doi.org/10.1016%2Fj.cub.2017.06.028) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2sXhtFOlsbbO) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=28712570) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC5569574) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Electron%20microscopic%20reconstruction%20of%20functionally%20identified%20cells%20in%20a%20neural%20integrator&journal=Curr.%20Biol.&doi=10.1016%2Fj.cub.2017.06.028&volume=27&pages=2137-2147&publication_year=2017&author=Vishwanathan%2CA)

[^146]: Vishwanathan, A. et al. Predicting modular functions and neural coding of behavior from a synaptic wiring diagram. Preprint at *bioRxiv* [https://doi.org/10.1101/2020.10.28.359620](https://doi.org/10.1101/2020.10.28.359620) (2021).

[Article](https://doi.org/10.1101%2F2020.10.28.359620) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Predicting%20modular%20functions%20and%20neural%20coding%20of%20behavior%20from%20a%20synaptic%20wiring%20diagram&journal=bioRxiv&doi=10.1101%2F2020.10.28.359620&publication_year=2021&author=Vishwanathan%2CA)

[^147]: Taube, J. S. Head direction cells recorded in the anterior thalamic nuclei of freely moving rats. *J. Neurosci.* **15**, 70–86 (1995).

[Article](https://doi.org/10.1523%2FJNEUROSCI.15-01-00070.1995) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DyaK2MXjtFejtLs%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=7823153) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC6578288) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Head%20direction%20cells%20recorded%20in%20the%20anterior%20thalamic%20nuclei%20of%20freely%20moving%20rats&journal=J.%20Neurosci.&doi=10.1523%2FJNEUROSCI.15-01-00070.1995&volume=15&pages=70-86&publication_year=1995&author=Taube%2CJS)

[^148]: Kim, S. S., Hermundstad, A. M., Romani, S., Abbott, L. F. & Jayaraman, V. Generation of stable heading representations in diverse visual scenes. *Nature* **576**, 126–131 (2019).

[Article](https://doi.org/10.1038%2Fs41586-019-1767-1) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC1MXitF2qt7bF) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=31748750) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC8115876) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Generation%20of%20stable%20heading%20representations%20in%20diverse%20visual%20scenes&journal=Nature&doi=10.1038%2Fs41586-019-1767-1&volume=576&pages=126-131&publication_year=2019&author=Kim%2CSS&author=Hermundstad%2CAM&author=Romani%2CS&author=Abbott%2CLF&author=Jayaraman%2CV)

[^149]: Yoder, R. M. & Taube, J. S. The vestibular contribution to the head direction signal and navigation. *Front. Integr. Neurosci.* **8**, 32 (2014).

[Article](https://doi.org/10.3389%2Ffnint.2014.00032) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=24795578) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4001061) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20vestibular%20contribution%20to%20the%20head%20direction%20signal%20and%20navigation&journal=Front.%20Integr.%20Neurosci.&doi=10.3389%2Ffnint.2014.00032&volume=8&publication_year=2014&author=Yoder%2CRM&author=Taube%2CJS)

[^150]: Yoder, R. M., Peck, J. R. & Taube, J. S. Visual landmark information gains control of the head direction signal at the lateral mammillary nuclei. *J. Neurosci.* **35**, 1354–1367 (2015).

[Article](https://doi.org/10.1523%2FJNEUROSCI.1418-14.2015) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2MXpvFKks7g%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=25632114) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4308588) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Visual%20landmark%20information%20gains%20control%20of%20the%20head%20direction%20signal%20at%20the%20lateral%20mammillary%20nuclei&journal=J.%20Neurosci.&doi=10.1523%2FJNEUROSCI.1418-14.2015&volume=35&pages=1354-1367&publication_year=2015&author=Yoder%2CRM&author=Peck%2CJR&author=Taube%2CJS)

[^151]: Hulse, B. K. & Jayaraman, V. Mechanisms underlying the neural computation of head direction. *Annu. Rev. Neurosci.* **43**, 31–54 (2020).

[Article](https://doi.org/10.1146%2Fannurev-neuro-072116-031516) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC1MXisVyhtbrI) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=31874068) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Mechanisms%20underlying%20the%20neural%20computation%20of%20head%20direction&journal=Annu.%20Rev.%20Neurosci.&doi=10.1146%2Fannurev-neuro-072116-031516&volume=43&pages=31-54&publication_year=2020&author=Hulse%2CBK&author=Jayaraman%2CV)

[^152]: Fisher, Y. E., Lu, J., D’Alessandro, I. & Wilson, R. I. Sensorimotor experience remaps visual input to a heading-direction network. *Nature* **576**, 121–125 (2019).

[Article](https://doi.org/10.1038%2Fs41586-019-1772-4) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC1MXitF2qt7nJ) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=31748749) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC7753972) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Sensorimotor%20experience%20remaps%20visual%20input%20to%20a%20heading-direction%20network&journal=Nature&doi=10.1038%2Fs41586-019-1772-4&volume=576&pages=121-125&publication_year=2019&author=Fisher%2CYE&author=Lu%2CJ&author=D%E2%80%99Alessandro%2CI&author=Wilson%2CRI)

[^153]: Angelaki, D. E. & Laurens, J. The head direction cell network: attractor dynamics, integration within the navigation system, and three-dimensional properties. *Curr. Opin. Neurobiol.* **60**, 136–144 (2020).

[Article](https://doi.org/10.1016%2Fj.conb.2019.12.002) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC1MXisVWks7rM) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=31877492) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20head%20direction%20cell%20network%3A%20attractor%20dynamics%2C%20integration%20within%20the%20navigation%20system%2C%20and%20three-dimensional%20properties&journal=Curr.%20Opin.%20Neurobiol.&doi=10.1016%2Fj.conb.2019.12.002&volume=60&pages=136-144&publication_year=2020&author=Angelaki%2CDE&author=Laurens%2CJ)

[^154]: Kim, S. S., Rouault, H., Druckmann, S. & Jayaraman, V. Ring attractor dynamics in the *Drosophila* central brain. *Science* **356**, 849–853 (2017). **This work uses calcium imaging and optogenetics in the ellipsoid body to identify network motifs and dynamics corresponding to ring attractors**

[Article](https://doi.org/10.1126%2Fscience.aal4835) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2sXotlSrsrk%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=28473639) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Ring%20attractor%20dynamics%20in%20the%20Drosophila%20central%20brain&journal=Science&doi=10.1126%2Fscience.aal4835&volume=356&pages=849-853&publication_year=2017&author=Kim%2CSS&author=Rouault%2CH&author=Druckmann%2CS&author=Jayaraman%2CV)

[^155]: Green, J. et al. A neural circuit architecture for angular integration in *Drosophila*. *Nature* **546**, 101–106 (2017).

[Article](https://doi.org/10.1038%2Fnature22343) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2sXosVagtL8%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=28538731) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC6320684) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=A%20neural%20circuit%20architecture%20for%20angular%20integration%20in%20Drosophila&journal=Nature&doi=10.1038%2Fnature22343&volume=546&pages=101-106&publication_year=2017&author=Green%2CJ)

[^156]: Turner-Evans, D. B. et al. The neuroanatomical ultrastructure and function of a biological ring attractor. *Neuron* **108**, 145–163.e10 (2020).

[Article](https://doi.org/10.1016%2Fj.neuron.2020.08.006) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BB3cXhsl2hu7fI) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=32916090) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC8356802) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20neuroanatomical%20ultrastructure%20and%20function%20of%20a%20biological%20ring%20attractor&journal=Neuron&doi=10.1016%2Fj.neuron.2020.08.006&volume=108&pages=145-163.e10&publication_year=2020&author=Turner-Evans%2CDB)

[^157]: Skaggs, W. E., Knierim, J. J., Kudrimoti, H. S. & McNaughton, B. L. A model of the neural basis of the rat’s sense of direction. In *Advances in Neural Information Processing Systems.* 173–180 (NeurIPS, 1995).

[^158]: Stone, T. et al. An anatomically constrained model for path integration in the bee brain. *Curr. Biol.* **27**, 3069–3085 (2017).

[Article](https://doi.org/10.1016%2Fj.cub.2017.08.052) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2sXhs1aitrzP) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=28988858) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC6196076) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=An%20anatomically%20constrained%20model%20for%20path%20integration%20in%20the%20bee%20brain&journal=Curr.%20Biol.&doi=10.1016%2Fj.cub.2017.08.052&volume=27&pages=3069-3085&publication_year=2017&author=Stone%2CT)

[^159]: Lyu, C., Abbott, L. & Maimon, G. Building an allocentric travelling direction signal via vector computation. *Nature* **601**, 92–97 (2022).

[Article](https://doi.org/10.1038%2Fs41586-021-04067-0) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BB3MXislGntbjF) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=34912112) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Building%20an%20allocentric%20travelling%20direction%20signal%20via%20vector%20computation&journal=Nature&doi=10.1038%2Fs41586-021-04067-0&volume=601&pages=92-97&publication_year=2022&author=Lyu%2CC&author=Abbott%2CL&author=Maimon%2CG)

[^160]: Asumbisa, K., Peyrache, A. & Trenholm, S. Flexible cue anchoring strategies enable stable head direction coding in both sighted and blind animals. *Nat. Commun.* **13**, 5483 (2022).

[Article](https://doi.org/10.1038%2Fs41467-022-33204-0) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BB38XisVanur3P) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=36123333) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC9485117) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Flexible%20cue%20anchoring%20strategies%20enable%20stable%20head%20direction%20coding%20in%20both%20sighted%20and%20blind%20animals&journal=Nat.%20Commun.&doi=10.1038%2Fs41467-022-33204-0&volume=13&publication_year=2022&author=Asumbisa%2CK&author=Peyrache%2CA&author=Trenholm%2CS)

[^161]: Hafting, T., Fyhn, M., Molden, S., Moser, M.-B. & Moser, E. Microstructure of a spatial map in the entorhinal cortex. *Nature* **436**, 801–806 (2005).

[Article](https://doi.org/10.1038%2Fnature03721) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD2MXnt1Siurk%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=15965463) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Microstructure%20of%20a%20spatial%20map%20in%20the%20entorhinal%20cortex&journal=Nature&doi=10.1038%2Fnature03721&volume=436&pages=801-806&publication_year=2005&author=Hafting%2CT&author=Fyhn%2CM&author=Molden%2CS&author=Moser%2CM-B&author=Moser%2CE)

[^162]: Guanella, A., Kiper, D. & Verschure, P. A model of grid cells based on a twisted torus topology. *Int. J. Neural Syst.* **17**, 231–240 (2007).

[Article](https://doi.org/10.1142%2FS0129065707001093) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=17696288) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=A%20model%20of%20grid%20cells%20based%20on%20a%20twisted%20torus%20topology&journal=Int.%20J.%20Neural%20Syst.&doi=10.1142%2FS0129065707001093&volume=17&pages=231-240&publication_year=2007&author=Guanella%2CA&author=Kiper%2CD&author=Verschure%2CP)

[^163]: Burak, Y. & Fiete, I. Do we understand the emergent dynamics of grid cell activity? *J. Neurosci.* **26**, 9352–9354 (2006).

[Article](https://doi.org/10.1523%2FJNEUROSCI.2857-06.2006) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD28XhtVSlu77N) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=16977716) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC6674593) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Do%20we%20understand%20the%20emergent%20dynamics%20of%20grid%20cell%20activity%3F&journal=J.%20Neurosci.&doi=10.1523%2FJNEUROSCI.2857-06.2006&volume=26&pages=9352-9354&publication_year=2006&author=Burak%2CY&author=Fiete%2CI)

[^164]: Stensola, H. et al. The entorhinal grid map is discretized. *Nature* **492**, 72–78 (2012).

[Article](https://doi.org/10.1038%2Fnature11649) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC38XhslyntbvF) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=23222610) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20entorhinal%20grid%20map%20is%20discretized&journal=Nature&doi=10.1038%2Fnature11649&volume=492&pages=72-78&publication_year=2012&author=Stensola%2CH)

[^165]: Fyhn, M., Hafting, T., Treves, A., Moser, M.-B. & Moser, E. I. Hippocampal remapping and grid realignment in entorhinal cortex. *Nature* **446**, 190–194 (2007).

[Article](https://doi.org/10.1038%2Fnature05601) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD2sXisFygurw%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=17322902) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Hippocampal%20remapping%20and%20grid%20realignment%20in%20entorhinal%20cortex&journal=Nature&doi=10.1038%2Fnature05601&volume=446&pages=190-194&publication_year=2007&author=Fyhn%2CM&author=Hafting%2CT&author=Treves%2CA&author=Moser%2CM-B&author=Moser%2CEI)

[^166]: Yoon, K., Lewallen, S., Kinkhabwala, A. A., Tank, D. W. & Fiete, I. R. Grid cell responses in 1D environments assessed as slices through a 2D lattice. *Neuron* **89**, 1086–1099 (2016). **This work shows that grid cell firing fields in linear tracks are well predicted by a one-dimensional slice through a two-dimensional hexagonal lattice, consistent with continuous-attractor dynamics**

[Article](https://doi.org/10.1016%2Fj.neuron.2016.01.039) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC28XivVGku7o%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=26898777) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC5507689) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Grid%20cell%20responses%20in%201D%20environments%20assessed%20as%20slices%20through%20a%202D%20lattice&journal=Neuron&doi=10.1016%2Fj.neuron.2016.01.039&volume=89&pages=1086-1099&publication_year=2016&author=Yoon%2CK&author=Lewallen%2CS&author=Kinkhabwala%2CAA&author=Tank%2CDW&author=Fiete%2CIR)

[^167]: Kropff, E. & Treves, A. The emergence of grid cells: intelligent design or just adaptation? *Hippocampus* **18**, 1256–1269 (2008).

[Article](https://doi.org/10.1002%2Fhipo.20520) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=19021261) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20emergence%20of%20grid%20cells%3A%20intelligent%20design%20or%20just%20adaptation%3F&journal=Hippocampus&doi=10.1002%2Fhipo.20520&volume=18&pages=1256-1269&publication_year=2008&author=Kropff%2CE&author=Treves%2CA)

[^168]: Dordek, Y., Soudry, D., Meir, R. & Derdikman, D. Extracting grid cell characteristics from place cell inputs using non-negative principal component analysis. *eLife* **5**, e10094 (2016).

[Article](https://doi.org/10.7554%2FeLife.10094) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=26952211) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4841785) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Extracting%20grid%20cell%20characteristics%20from%20place%20cell%20inputs%20using%20non-negative%20principal%20component%20analysis&journal=eLife&doi=10.7554%2FeLife.10094&volume=5&publication_year=2016&author=Dordek%2CY&author=Soudry%2CD&author=Meir%2CR&author=Derdikman%2CD)

[^169]: Stachenfeld, K. L., Botvinick, M. M. & Gershman, S. J. The hippocampus as a predictive map. *Nat. Neurosci.* **20**, 1643–1653 (2017).

[Article](https://doi.org/10.1038%2Fnn.4650) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2sXhsFylurrF) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=28967910) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20hippocampus%20as%20a%20predictive%20map&journal=Nat.%20Neurosci.&doi=10.1038%2Fnn.4650&volume=20&pages=1643-1653&publication_year=2017&author=Stachenfeld%2CKL&author=Botvinick%2CMM&author=Gershman%2CSJ)

[^170]: Barry, C., Hayman, R., Burgess, N. & Jeffery, K. J. Experience-dependent rescaling of entorhinal grids. *Nat. Neurosci.* **10**, 682–684 (2007).

[Article](https://doi.org/10.1038%2Fnn1905) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD2sXls1Kgtr8%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=17486102) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Experience-dependent%20rescaling%20of%20entorhinal%20grids&journal=Nat.%20Neurosci.&doi=10.1038%2Fnn1905&volume=10&pages=682-684&publication_year=2007&author=Barry%2CC&author=Hayman%2CR&author=Burgess%2CN&author=Jeffery%2CKJ)

[^171]: Boccara, C. N., Nardin, M., Stella, F., O’Neill, J. & Csicsvari, J. The entorhinal cognitive map is attracted to goals. *Science* **363**, 1443–1447 (2019).

[Article](https://doi.org/10.1126%2Fscience.aav4837) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC1MXlvVSmsL8%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=30923221) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20entorhinal%20cognitive%20map%20is%20attracted%20to%20goals&journal=Science&doi=10.1126%2Fscience.aav4837&volume=363&pages=1443-1447&publication_year=2019&author=Boccara%2CCN&author=Nardin%2CM&author=Stella%2CF&author=O%E2%80%99Neill%2CJ&author=Csicsvari%2CJ)

[^172]: Butler, W. N., Hardcastle, K. & Giocomo, L. M. Remembered reward locations restructure entorhinal spatial maps. *Science* **363**, 1447–1452 (2019).

[Article](https://doi.org/10.1126%2Fscience.aav5297) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC1MXlvVSmsLs%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=30923222) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC6516752) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Remembered%20reward%20locations%20restructure%20entorhinal%20spatial%20maps&journal=Science&doi=10.1126%2Fscience.aav5297&volume=363&pages=1447-1452&publication_year=2019&author=Butler%2CWN&author=Hardcastle%2CK&author=Giocomo%2CLM)

[^173]: Krupic, J., Bauza, M., Burton, S., Barry, C. & O’Keefe, J. Grid cell symmetry is shaped by environmental geometry. *Nature* **518**, 232–235 (2015).

[Article](https://doi.org/10.1038%2Fnature14153) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2MXisleht7k%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=25673417) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4576734) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Grid%20cell%20symmetry%20is%20shaped%20by%20environmental%20geometry&journal=Nature&doi=10.1038%2Fnature14153&volume=518&pages=232-235&publication_year=2015&author=Krupic%2CJ&author=Bauza%2CM&author=Burton%2CS&author=Barry%2CC&author=O%E2%80%99Keefe%2CJ)

[^174]: Hayman, R. M. A., Casali, G., Wilson, J. J. & Jeffery, K. J. Grid cells on steeply sloping terrain: evidence for planar rather than tric encoding. *Front. Psychol.* **6**, 925 (2015).

[Article](https://doi.org/10.3389%2Ffpsyg.2015.00925) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=26236245) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4502341) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Grid%20cells%20on%20steeply%20sloping%20terrain%3A%20evidence%20for%20planar%20rather%20than%20tric%20encoding&journal=Front.%20Psychol.&doi=10.3389%2Ffpsyg.2015.00925&volume=6&publication_year=2015&author=Hayman%2CRMA&author=Casali%2CG&author=Wilson%2CJJ&author=Jeffery%2CKJ)

[^175]: Ginosar, G. et al. Locally ordered representation of 3D space in the entorhinal cortex. *Nature* **596**, 404–409 (2021).

[Article](https://doi.org/10.1038%2Fs41586-021-03783-x) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BB3MXhslKqs7jP) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=34381211) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Locally%20ordered%20representation%20of%203D%20space%20in%20the%20entorhinal%20cortex&journal=Nature&doi=10.1038%2Fs41586-021-03783-x&volume=596&pages=404-409&publication_year=2021&author=Ginosar%2CG)

[^176]: Grieves, R. M. et al. Irregular distribution of grid cell firing fields in rats exploring a 3D volumetric space. *Nat. Neurosci.* **24**, 1567–1573 (2021).

[Article](https://doi.org/10.1038%2Fs41593-021-00907-4) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BB3MXhslKqs7%2FL) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=34381241) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC8553607) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Irregular%20distribution%20of%20grid%20cell%20firing%20fields%20in%20rats%20exploring%20a%203D%20volumetric%20space&journal=Nat.%20Neurosci.&doi=10.1038%2Fs41593-021-00907-4&volume=24&pages=1567-1573&publication_year=2021&author=Grieves%2CRM)

[^177]: Keinath, A. T., Epstein, R. A. & Balasubramanian, V. Environmental deformations dynamically shift the grid cell spatial metric. *eLife* **7**, e38169 (2018).

[Article](https://doi.org/10.7554%2FeLife.38169) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=30346272) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC6203432) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Environmental%20deformations%20dynamically%20shift%20the%20grid%20cell%20spatial%20metric&journal=eLife&doi=10.7554%2FeLife.38169&volume=7&publication_year=2018&author=Keinath%2CAT&author=Epstein%2CRA&author=Balasubramanian%2CV)

[^178]: Welinder, P. E., Burak, Y. & Fiete, I. R. Grid cells: the position code, neural network models of activity, and the problem of learning. *Hippocampus* **18**, 1283–1300 (2008).

[Article](https://doi.org/10.1002%2Fhipo.20519) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=19021263) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Grid%20cells%3A%20the%20position%20code%2C%20neural%20network%20models%20of%20activity%2C%20and%20the%20problem%20of%20learning&journal=Hippocampus&doi=10.1002%2Fhipo.20519&volume=18&pages=1283-1300&publication_year=2008&author=Welinder%2CPE&author=Burak%2CY&author=Fiete%2CIR)

[^179]: Widloski, J. & Fiete, I. R. A model of grid cell development through spatial exploration and spike time-dependent plasticity. *Neuron* **83**, 481–495 (2014).

[Article](https://doi.org/10.1016%2Fj.neuron.2014.06.018) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2cXhtFyjsrnK) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=25033187) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=A%20model%20of%20grid%20cell%20development%20through%20spatial%20exploration%20and%20spike%20time-dependent%20plasticity&journal=Neuron&doi=10.1016%2Fj.neuron.2014.06.018&volume=83&pages=481-495&publication_year=2014&author=Widloski%2CJ&author=Fiete%2CIR)

[^180]: Hardcastle, K., Ganguli, S. & Giocomo, L. M. Environmental boundaries as an error correction mechanism for grid cells. *Neuron* **86**, 827–839 (2015).

[Article](https://doi.org/10.1016%2Fj.neuron.2015.03.039) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2MXms1ynsLo%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=25892299) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Environmental%20boundaries%20as%20an%20error%20correction%20mechanism%20for%20grid%20cells&journal=Neuron&doi=10.1016%2Fj.neuron.2015.03.039&volume=86&pages=827-839&publication_year=2015&author=Hardcastle%2CK&author=Ganguli%2CS&author=Giocomo%2CLM)

[^181]: Fiete, I. R., Burak, Y. & Brookings, T. What grid cells convey about rat location. *J. Neurosci.* **28**, 6858–6871 (2008).

[Article](https://doi.org/10.1523%2FJNEUROSCI.5684-07.2008) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD1cXot1Oqt7o%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=18596161) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC6670990) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=What%20grid%20cells%20convey%20about%20rat%20location&journal=J.%20Neurosci.&doi=10.1523%2FJNEUROSCI.5684-07.2008&volume=28&pages=6858-6871&publication_year=2008&author=Fiete%2CIR&author=Burak%2CY&author=Brookings%2CT)

[^182]: Gnadt, J. W. & Andersen, R. A. Memory related motor planning activity in posterior parietal cortex of macaque. *Exp. Brain Res.* **70**, 216–220 (1988).

[Article](https://link.springer.com/doi/10.1007/BF00271862) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaL1c3ps1OmsA%3D%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=3402565) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Memory%20related%20motor%20planning%20activity%20in%20posterior%20parietal%20cortex%20of%20macaque&journal=Exp.%20Brain%20Res.&doi=10.1007%2FBF00271862&volume=70&pages=216-220&publication_year=1988&author=Gnadt%2CJW&author=Andersen%2CRA)

[^183]: Constantinidis, C., Franowicz, M. N. & Goldman-Rakic, P. S. Coding specificity in cortical microcircuits: a multiple-electrode analysis of primate prefrontal cortex. *J. Neurosci.* **21**, 3646–3655 (2001).

[Article](https://doi.org/10.1523%2FJNEUROSCI.21-10-03646.2001) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD3MXjs1antb0%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=11331394) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC6762477) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Coding%20specificity%20in%20cortical%20microcircuits%3A%20a%20multiple-electrode%20analysis%20of%20primate%20prefrontal%20cortex&journal=J.%20Neurosci.&doi=10.1523%2FJNEUROSCI.21-10-03646.2001&volume=21&pages=3646-3655&publication_year=2001&author=Constantinidis%2CC&author=Franowicz%2CMN&author=Goldman-Rakic%2CPS)

[^184]: Izhikevich, E. M. *Dynamical Systems in Neuroscience* (MIT Press, 2007).

[^185]: Ashwin, P., Coombes, S. & Nicks, R. Mathematical frameworks for oscillatory network dynamics in neuroscience. *Math. Neurosci.* **6**, 1–92 (2016).

[Google Scholar](http://scholar.google.com/scholar_lookup?&title=Mathematical%20frameworks%20for%20oscillatory%20network%20dynamics%20in%20neuroscience&journal=Math.%20Neurosci.&volume=6&pages=1-92&publication_year=2016&author=Ashwin%2CP&author=Coombes%2CS&author=Nicks%2CR)

[^186]: Adamantidis, A. R., Herrera, C. G. & Gent, T. C. Oscillating circuitries in the sleeping brain. *Nat. Rev. Neurosci.* **20**, 746–762 (2019).

[Article](https://doi.org/10.1038%2Fs41583-019-0223-4) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC1MXhvFKrt7rL) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=31616106) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Oscillating%20circuitries%20in%20the%20sleeping%20brain&journal=Nat.%20Rev.%20Neurosci.&doi=10.1038%2Fs41583-019-0223-4&volume=20&pages=746-762&publication_year=2019&author=Adamantidis%2CAR&author=Herrera%2CCG&author=Gent%2CTC)

[^187]: Bruno, A. M., Frost, W. N. & Humphries, M. D. A spiral attractor network drives rhythmic locomotion. *eLife* **6**, e27342 (2017).

[Article](https://doi.org/10.7554%2FeLife.27342) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=28780929) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC5546814) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=A%20spiral%20attractor%20network%20drives%20rhythmic%20locomotion&journal=eLife&doi=10.7554%2FeLife.27342&volume=6&publication_year=2017&author=Bruno%2CAM&author=Frost%2CWN&author=Humphries%2CMD)

[^188]: Nichols, A. L., Eichler, T., Latham, R. & Zimmer, M. A global brain state underlies *C. elegans* sleep behavior. *Science* **356**, eaam6851 (2017).

[Article](https://doi.org/10.1126%2Fscience.aam6851) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=28642382) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=A%20global%20brain%20state%20underlies%20C.%20elegans%20sleep%20behavior&journal=Science&doi=10.1126%2Fscience.aam6851&volume=356&publication_year=2017&author=Nichols%2CAL&author=Eichler%2CT&author=Latham%2CR&author=Zimmer%2CM)

[^189]: Bucher, D., Haspel, G., Golowasch, J. & Nadim, F. Central pattern generators. *eLS* [https://doi.org/10.1002/9780470015902.a0000032.pub2](https://doi.org/10.1002/9780470015902.a0000032.pub2) (2015).

[Article](https://doi.org/10.1002%2F9780470015902.a0000032.pub2) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Central%20pattern%20generators&journal=eLS&doi=10.1002%2F9780470015902.a0000032.pub2&publication_year=2015&author=Bucher%2CD&author=Haspel%2CG&author=Golowasch%2CJ&author=Nadim%2CF)

[^190]: Sauerbrei, B. A. et al. Cortical pattern generation during dexterous movement is input-driven. *Nature* **577**, 386–391 (2020).

[Article](https://doi.org/10.1038%2Fs41586-019-1869-9) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BB3cXjvFyrsA%3D%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=31875851) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Cortical%20pattern%20generation%20during%20dexterous%20movement%20is%20input-driven&journal=Nature&doi=10.1038%2Fs41586-019-1869-9&volume=577&pages=386-391&publication_year=2020&author=Sauerbrei%2CBA)

[^191]: Marder, E. & Bucher, D. Central pattern generators and the control of rhythmic movements. *Curr. Biol.* **11**, R986–R996 (2001).

[Article](https://doi.org/10.1016%2FS0960-9822%2801%2900581-4) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD3MXovVCnsrg%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=11728329) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Central%20pattern%20generators%20and%20the%20control%20of%20rhythmic%20movements&journal=Curr.%20Biol.&doi=10.1016%2FS0960-9822%2801%2900581-4&volume=11&pages=R986-R996&publication_year=2001&author=Marder%2CE&author=Bucher%2CD)

[^192]: Marder, E. & Calabrese, R. L. Principles of rhythmic motor pattern generation. *Physiol. Rev.* **76**, 687–717 (1996).

[Article](https://doi.org/10.1152%2Fphysrev.1996.76.3.687) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaK28zhsFKitA%3D%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=8757786) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Principles%20of%20rhythmic%20motor%20pattern%20generation&journal=Physiol.%20Rev.&doi=10.1152%2Fphysrev.1996.76.3.687&volume=76&pages=687-717&publication_year=1996&author=Marder%2CE&author=Calabrese%2CRL)

[^193]: Goulding, M. Circuits controlling vertebrate locomotion: moving in a new direction. *Nat. Rev. Neurosci.* **10**, 507–518 (2009).

[Article](https://doi.org/10.1038%2Fnrn2608) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD1MXnsVyks74%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=19543221) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC2847453) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Circuits%20controlling%20vertebrate%20locomotion%3A%20moving%20in%20a%20new%20direction&journal=Nat.%20Rev.%20Neurosci.&doi=10.1038%2Fnrn2608&volume=10&pages=507-518&publication_year=2009&author=Goulding%2CM)

[^194]: Kiehn, O. Decoding the organization of spinal circuits that control locomotion. *Nat. Rev. Neurosci.* **17**, 224 (2016).

[Article](https://doi.org/10.1038%2Fnrn.2016.9) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC28XjsVKgt78%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=26935168) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4844028) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Decoding%20the%20organization%20of%20spinal%20circuits%20that%20control%20locomotion&journal=Nat.%20Rev.%20Neurosci.&doi=10.1038%2Fnrn.2016.9&volume=17&publication_year=2016&author=Kiehn%2CO)

[^195]: Yuste, R., MacLean, J. N., Smith, J. & Lansner, A. The cortex as a central pattern generator. *Nat. Rev. Neurosci.* **6**, 477–483 (2005).

[Article](https://doi.org/10.1038%2Fnrn1686) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD2MXks1Oitb4%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=15928717) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20cortex%20as%20a%20central%20pattern%20generator&journal=Nat.%20Rev.%20Neurosci.&doi=10.1038%2Fnrn1686&volume=6&pages=477-483&publication_year=2005&author=Yuste%2CR&author=MacLean%2CJN&author=Smith%2CJ&author=Lansner%2CA)

[^196]: Hubel, D. H. & Wiesel, T. N. Receptive fields of single neurones in the cat’s striate cortex. *J. Physiol.* **148**, 574–591 (1959).

[Article](https://doi.org/10.1113%2Fjphysiol.1959.sp006308) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaF3c7ls1aqtg%3D%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=14403679) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC1363130) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Receptive%20fields%20of%20single%20neurones%20in%20the%20cat%E2%80%99s%20striate%20cortex&journal=J.%C2%A0Physiol.&doi=10.1113%2Fjphysiol.1959.sp006308&volume=148&pages=574-591&publication_year=1959&author=Hubel%2CDH&author=Wiesel%2CTN)

[^197]: von der Heydt, R., Peterhans, E. & Baumgartner, G. Illusory contours and cortical neuron responses. *Science* **224**, 1260–1262 (1984).

[Article](https://doi.org/10.1126%2Fscience.6539501) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=6539501) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Illusory%20contours%20and%20cortical%20neuron%20responses&journal=Science&doi=10.1126%2Fscience.6539501&volume=224&pages=1260-1262&publication_year=1984&author=Heydt%2CR&author=Peterhans%2CE&author=Baumgartner%2CG)

[^198]: Grosof, D. H., Shapley, R. M. & Hawken, M. J. Macaque V1 neurons can signal ‘illusory’ contours. *Nature* **365**, 550–552 (1993).

[Article](https://doi.org/10.1038%2F365550a0) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaK2c%2FhvFOqtw%3D%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=8413610) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Macaque%20V1%20neurons%20can%20signal%20%E2%80%98illusory%E2%80%99%20contours&journal=Nature&doi=10.1038%2F365550a0&volume=365&pages=550-552&publication_year=1993&author=Grosof%2CDH&author=Shapley%2CRM&author=Hawken%2CMJ)

[^199]: Grinvald, A., Lieke, E., Frostig, R. D., Gilbert, C. D. & Wiesel, T. N. Functional architecture of cortex revealed by optical imaging of intrinsic signals. *Nature* **324**, 361–364 (1986).

[Article](https://doi.org/10.1038%2F324361a0) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaL2s%2FmsFSrtA%3D%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=3785405) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Functional%20architecture%20of%20cortex%20revealed%20by%20optical%20imaging%20of%20intrinsic%20signals&journal=Nature&doi=10.1038%2F324361a0&volume=324&pages=361-364&publication_year=1986&author=Grinvald%2CA&author=Lieke%2CE&author=Frostig%2CRD&author=Gilbert%2CCD&author=Wiesel%2CTN)

[^200]: Zhong, W., Lu, Z., Schwab, D. J. & Murugan, A. Non-equilibrium statistical mechanics of continuous attractors. *Neural Comput.* **32**, 1033–1068 (2020).

[Article](https://doi.org/10.1162%2Fneco_a_01280) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=32343645) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Non-equilibrium%20statistical%20mechanics%20of%20continuous%20attractors&journal=Neural%20Comput.&doi=10.1162%2Fneco_a_01280&volume=32&pages=1033-1068&publication_year=2020&author=Zhong%2CW&author=Lu%2CZ&author=Schwab%2CDJ&author=Murugan%2CA)

[^201]: Fung, C. C. A. et al. Discrete-attractor-like tracking in continuous attractor neural networks. *Phys. Rev. Lett.* **122**, 018102 (2019).

[Article](https://doi.org/10.1103%2FPhysRevLett.122.018102) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC1MXnvFSgt7k%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=31012700) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Discrete-attractor-like%20tracking%20in%20continuous%20attractor%20neural%20networks&journal=Phys.%20Rev.%20Lett.&doi=10.1103%2FPhysRevLett.122.018102&volume=122&publication_year=2019&author=Fung%2CCCA)

[^202]: Thorpe, S., Fize, D. & Marlot, C. Speed of processing in the human visual system. *Nature* **381**, 520–522 (1996).

[Article](https://doi.org/10.1038%2F381520a0) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DyaK28XjsVWisbw%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=8632824) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Speed%20of%20processing%20in%20the%20human%20visual%20system&journal=Nature&doi=10.1038%2F381520a0&volume=381&pages=520-522&publication_year=1996&author=Thorpe%2CS&author=Fize%2CD&author=Marlot%2CC)

[^203]: Ferster, D., Chung, S. & Wheat, H. Orientation selectivity of thalamic input to simple cells of cat visual cortex. *Nature* **380**, 249–252 (1996).

[Article](https://doi.org/10.1038%2F380249a0) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DyaK28XhvVahsL4%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=8637573) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Orientation%20selectivity%20of%20thalamic%20input%20to%20simple%20cells%20of%20cat%20visual%20cortex&journal=Nature&doi=10.1038%2F380249a0&volume=380&pages=249-252&publication_year=1996&author=Ferster%2CD&author=Chung%2CS&author=Wheat%2CH)

[^204]: Hennequin, G., Ahmadian, Y., Rubin, D. B., Lengyel, M. & Miller, K. D. The dynamical regime of sensory cortex: stable dynamics around a single stimulus-tuned attractor account for patterns of noise variability. *Neuron* **98**, 846–860.e5 (2018).

[Article](https://doi.org/10.1016%2Fj.neuron.2018.04.017) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC1cXpslalsrc%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=29772203) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC5971207) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20dynamical%20regime%20of%20sensory%20cortex%3A%20stable%20dynamics%20around%20a%20single%20stimulus-tuned%20attractor%20account%20for%20patterns%20of%20noise%20variability&journal=Neuron&doi=10.1016%2Fj.neuron.2018.04.017&volume=98&pages=846-860.e5&publication_year=2018&author=Hennequin%2CG&author=Ahmadian%2CY&author=Rubin%2CDB&author=Lengyel%2CM&author=Miller%2CKD)

[^205]: O’Keefe, J. & Dostrovsky, J. The hippocampus as a spatial map. Preliminary evidence from unit activity in the freely-moving rat. *Brain Res.* **34**, 171–175 (1971).

[Article](https://doi.org/10.1016%2F0006-8993%2871%2990358-1) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=5124915) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20hippocampus%20as%20a%20spatial%20map.%20Preliminary%20evidence%20from%20unit%20activity%20in%20the%20freely-moving%20rat&journal=Brain%20Res.&doi=10.1016%2F0006-8993%2871%2990358-1&volume=34&pages=171-175&publication_year=1971&author=O%E2%80%99Keefe%2CJ&author=Dostrovsky%2CJ)

[^206]: Quirk, G. J., Muller, R. U. & Kubie, J. L. The firing of hippocampal place cells in the dark depends on the rat’s recent experience. *J. Neurosci.* **10**, 2008–2017 (1990).

[Article](https://doi.org/10.1523%2FJNEUROSCI.10-06-02008.1990) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaK3c3osFOhug%3D%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=2355262) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC6570323) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20firing%20of%20hippocampal%20place%20cells%20in%20the%20dark%20depends%20on%20the%20rat%E2%80%99s%20recent%20experience&journal=J.%20Neurosci.&doi=10.1523%2FJNEUROSCI.10-06-02008.1990&volume=10&pages=2008-2017&publication_year=1990&author=Quirk%2CGJ&author=Muller%2CRU&author=Kubie%2CJL)

[^207]: Wilson, M. A. & McNaughton, B. L. Reactivation of hippocampal ensemble memories during sleep. *Science* **265**, 676–679 (1994).

[Article](https://doi.org/10.1126%2Fscience.8036517) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaK2czhtVCltw%3D%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=8036517) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Reactivation%20of%20hippocampal%20ensemble%20memories%20during%20sleep&journal=Science&doi=10.1126%2Fscience.8036517&volume=265&pages=676-679&publication_year=1994&author=Wilson%2CMA&author=McNaughton%2CBL)

[^208]: Skaggs, W. E. & McNaughton, B. L. Replay of neuronal firing sequences in rat hippocampus during sleep following spatial experience. *Science* **271**, 1870–1873 (1996).

[Article](https://doi.org/10.1126%2Fscience.271.5257.1870) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DyaK28XhvFGms7Y%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=8596957) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Replay%20of%20neuronal%20firing%20sequences%20in%20rat%20hippocampus%20during%20sleep%20following%20spatial%20experience&journal=Science&doi=10.1126%2Fscience.271.5257.1870&volume=271&pages=1870-1873&publication_year=1996&author=Skaggs%2CWE&author=McNaughton%2CBL)

[^209]: Tsodyks, M. & Sejnowski, T. Associative memory and hippocampal place cells. *Int. Neural Syst.* **6**, 81–86 (1995).

[Google Scholar](http://scholar.google.com/scholar_lookup?&title=Associative%20memory%20and%20hippocampal%20place%20cells&journal=Int.%20Neural%20Syst.&volume=6&pages=81-86&publication_year=1995&author=Tsodyks%2CM&author=Sejnowski%2CT)

[^210]: Samsonovich, A. & McNaughton, B. L. Path integration and cognitive mapping in a continuous attractor neural network model. *J. Neurosci.* **17**, 5900–5920 (1997).

[Article](https://doi.org/10.1523%2FJNEUROSCI.17-15-05900.1997) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DyaK2sXkvFymsr8%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=9221787) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC6573219) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Path%20integration%20and%20cognitive%20mapping%20in%20a%20continuous%20attractor%20neural%20network%20model&journal=J.%20Neurosci.&doi=10.1523%2FJNEUROSCI.17-15-05900.1997&volume=17&pages=5900-5920&publication_year=1997&author=Samsonovich%2CA&author=McNaughton%2CBL)

[^211]: Samsonovich, A. V. *Attractor Map Theory of the Hippocampal Representation of Space*. Ph.D. thesis (Univ. Arizona, 1997).

[^212]: Battista, A. & Monasson, R. Capacity-resolution trade-off in the optimal learning of multiple low-dimensional manifolds by attractor neural networks. *Phys. Rev. Lett.* **124**, 048302 (2020).

[Article](https://doi.org/10.1103%2FPhysRevLett.124.048302) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BB3cXmslymtbg%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=32058781) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Capacity-resolution%20trade-off%20in%20the%20optimal%20learning%20of%20multiple%20low-dimensional%20manifolds%20by%20attractor%20neural%20networks&journal=Phys.%20Rev.%20Lett.&doi=10.1103%2FPhysRevLett.124.048302&volume=124&publication_year=2020&author=Battista%2CA&author=Monasson%2CR)

[^213]: Yim, M. Y., Sadun, L. A., Fiete, I. R. & Taillefumier, T. Place-cell capacity and volatility with grid-like inputs. *eLife* **10**, e62702 (2021).

[Article](https://doi.org/10.7554%2FeLife.62702) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BB3MXislansbrE) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=34028354) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC8294848) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Place-cell%20capacity%20and%20volatility%20with%20grid-like%20inputs&journal=eLife&doi=10.7554%2FeLife.62702&volume=10&publication_year=2021&author=Yim%2CMY&author=Sadun%2CLA&author=Fiete%2CIR&author=Taillefumier%2CT)

[^214]: Colgin, L. L., Moser, E. I. & Moser, M.-B. Understanding memory through hippocampal remapping. *Trends Neurosci.* **31**, 469–477 (2008).

[Article](https://doi.org/10.1016%2Fj.tins.2008.06.008) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD1cXhtVKnurzE) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=18687478) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Understanding%20memory%20through%20hippocampal%20remapping&journal=Trends%20Neurosci.&doi=10.1016%2Fj.tins.2008.06.008&volume=31&pages=469-477&publication_year=2008&author=Colgin%2CLL&author=Moser%2CEI&author=Moser%2CM-B)

[^215]: Alme, C. B. et al. Place cells in the hippocampus: eleven maps for eleven rooms. *Proc. Natl Acad. Sci. USA* **111**, 18428–18435 (2014).

[Article](https://doi.org/10.1073%2Fpnas.1421056111) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2cXitVClu7jK) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=25489089) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4284589) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Place%20cells%20in%20the%20hippocampus%3A%20eleven%20maps%20for%20eleven%20rooms&journal=Proc.%20Natl%20Acad.%20Sci.%20USA&doi=10.1073%2Fpnas.1421056111&volume=111&pages=18428-18435&publication_year=2014&author=Alme%2CCB)

[^216]: Solstad, T., Moser, E. I. & Einevoll, G. T. From grid cells to place cells: a mathematical model. *Hippocampus* **16**, 1026–1031 (2006).

[Article](https://doi.org/10.1002%2Fhipo.20244) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=17094145) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=From%20grid%20cells%20to%20place%20cells%3A%20a%20mathematical%20model&journal=Hippocampus&doi=10.1002%2Fhipo.20244&volume=16&pages=1026-1031&publication_year=2006&author=Solstad%2CT&author=Moser%2CEI&author=Einevoll%2CGT)

[^217]: Barry, C. et al. The boundary vector cell model of place cell firing and spatial memory. *Rev. Neurosci.* **17**, 71–98 (2006).

[Article](https://doi.org/10.1515%2FREVNEURO.2006.17.1-2.71) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=16703944) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC2677716) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20boundary%20vector%20cell%20model%20of%20place%20cell%20firing%20and%20spatial%20memory&journal=Rev.%20Neurosci.&doi=10.1515%2FREVNEURO.2006.17.1-2.71&volume=17&pages=71-98&publication_year=2006&author=Barry%2CC)

[^218]: Whittington, J. C. R. et al. The Tolman–Eichenbaum machine: unifying space and relational memory through generalization in the hippocampal formation. *Cell* **183**, 1249–1263.e23 (2020).

[Article](https://doi.org/10.1016%2Fj.cell.2020.10.024) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BB3cXitlClsLnE) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=33181068) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC7707106) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20Tolman%E2%80%93Eichenbaum%20machine%3A%20unifying%20space%20and%20relational%20memory%20through%20generalization%20in%20the%20hippocampal%20formation&journal=Cell&doi=10.1016%2Fj.cell.2020.10.024&volume=183&pages=1249-1263.e23&publication_year=2020&author=Whittington%2CJCR)

[^219]: Kudrimoti, H., Barnes, C. & McNaughton, B. Reactivation of hippocampal cell assemblies: effects of behavioral state, experience, and EEG dynamics. *J. Neurosci.* **19**, 4090–4101 (1999).

[Article](https://doi.org/10.1523%2FJNEUROSCI.19-10-04090.1999) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DyaK1MXjtFSjur4%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=10234037) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC6782694) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Reactivation%20of%20hippocampal%20cell%20assemblies%3A%20effects%20of%20behavioral%20state%2C%20experience%2C%20and%20EEG%20dynamics&journal=J.%20Neurosci.&doi=10.1523%2FJNEUROSCI.19-10-04090.1999&volume=19&pages=4090-4101&publication_year=1999&author=Kudrimoti%2CH&author=Barnes%2CC&author=McNaughton%2CB)

[^220]: Davidson, T. J., Kloosterman, F. & Wilson, M. A. Hippocampal replay of extended experience. *Neuron* **63**, 497–507 (2009).

[Article](https://doi.org/10.1016%2Fj.neuron.2009.07.027) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD1MXhsVequ7fF) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=19709631) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4364032) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Hippocampal%20replay%20of%20extended%20experience&journal=Neuron&doi=10.1016%2Fj.neuron.2009.07.027&volume=63&pages=497-507&publication_year=2009&author=Davidson%2CTJ&author=Kloosterman%2CF&author=Wilson%2CMA)

[^221]: Pfeiffer, B. E. & Foster, D. J. Hippocampal place-cell sequences depict future paths to remembered goals. *Nature* **497**, 74–79 (2013).

[Article](https://doi.org/10.1038%2Fnature12112) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC3sXlvFyqu7Y%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=23594744) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3990408) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Hippocampal%20place-cell%20sequences%20depict%20future%20paths%20to%20remembered%20goals&journal=Nature&doi=10.1038%2Fnature12112&volume=497&pages=74-79&publication_year=2013&author=Pfeiffer%2CBE&author=Foster%2CDJ)

[^222]: Agmon, H. & Burak, Y. A theory of joint attractor dynamics in the hippocampus and the entorhinal cortex accounts for artificial remapping and grid cell field-to-field variability. *eLife* **9**, e56894 (2020).

[Article](https://doi.org/10.7554%2FeLife.56894) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BB3cXitlOis7%2FO) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=32779570) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC7447444) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=A%20theory%20of%20joint%20attractor%20dynamics%20in%20the%20hippocampus%20and%20the%20entorhinal%20cortex%20accounts%20for%20artificial%20remapping%20and%20grid%20cell%20field-to-field%20variability&journal=eLife&doi=10.7554%2FeLife.56894&volume=9&publication_year=2020&author=Agmon%2CH&author=Burak%2CY)

[^223]: Moran, D. W. & Schwartz, A. B. Motor cortical representation of speed and direction during reaching. *J. Neurophysiol.* **82**, 2676–2692 (1999).

[Article](https://doi.org/10.1152%2Fjn.1999.82.5.2676) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DC%2BD3c%2FivFykug%3D%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=10561437) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Motor%20cortical%20representation%20of%20speed%20and%20direction%20during%20reaching&journal=J.%20Neurophysiol.&doi=10.1152%2Fjn.1999.82.5.2676&volume=82&pages=2676-2692&publication_year=1999&author=Moran%2CDW&author=Schwartz%2CAB)

[^224]: Shenoy, K. V., Sahani, M. & Churchland, M. M. Cortical control of arm movements: a dynamical systems perspective. *Annu. Rev. Neurosci.* **36**, 337–359 (2013).

[Article](https://doi.org/10.1146%2Fannurev-neuro-062111-150509) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC3sXhtlCku73N) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=23725001) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Cortical%20control%20of%20arm%20movements%3A%20a%20dynamical%20systems%20perspective&journal=Annu.%20Rev.%20Neurosci.&doi=10.1146%2Fannurev-neuro-062111-150509&volume=36&pages=337-359&publication_year=2013&author=Shenoy%2CKV&author=Sahani%2CM&author=Churchland%2CMM)

[^225]: Gallego, J. A. et al. Cortical population activity within a preserved neural manifold underlies multiple motor behaviors. *Nat. Commun.* **9**, 4233 (2018).

[Article](https://doi.org/10.1038%2Fs41467-018-06560-z) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=30315158) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC6185944) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Cortical%20population%20activity%20within%20a%20preserved%20neural%20manifold%20underlies%20multiple%20motor%20behaviors&journal=Nat.%20Commun.&doi=10.1038%2Fs41467-018-06560-z&volume=9&publication_year=2018&author=Gallego%2CJA)

[^226]: Gallego, J. A., Perich, M. G., Chowdhury, R. H., Solla, S. A. & Miller, L. E. Long-term stability of cortical population dynamics underlying consistent behavior. *Nat. Neurosci.* **23**, 260–270 (2020).

[Article](https://doi.org/10.1038%2Fs41593-019-0555-4) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BB3cXjvF2nsw%3D%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=31907438) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC7007364) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Long-term%20stability%20of%20cortical%20population%20dynamics%20underlying%20consistent%20behavior&journal=Nat.%20Neurosci.&doi=10.1038%2Fs41593-019-0555-4&volume=23&pages=260-270&publication_year=2020&author=Gallego%2CJA&author=Perich%2CMG&author=Chowdhury%2CRH&author=Solla%2CSA&author=Miller%2CLE)

[^227]: Wehr, M. & Laurent, G. Odour encoding by temporal sequences of firing in oscillating neural assemblies. *Nature* **384**, 162–166 (1996).

[Article](https://doi.org/10.1038%2F384162a0) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DyaK28XmvFGhtrs%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=8906790) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Odour%20encoding%20by%20temporal%20sequences%20of%20firing%20in%20oscillating%20neural%20assemblies&journal=Nature&doi=10.1038%2F384162a0&volume=384&pages=162-166&publication_year=1996&author=Wehr%2CM&author=Laurent%2CG)

[^228]: Rokni, U. & Sompolinsky, H. How the brain generates movement. *Neural Comput.* **24**, 289–331 (2012).

[Article](https://doi.org/10.1162%2FNECO_a_00223) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=22023199) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=How%20the%20brain%20generates%20movement&journal=Neural%20Comput.&doi=10.1162%2FNECO_a_00223&volume=24&pages=289-331&publication_year=2012&author=Rokni%2CU&author=Sompolinsky%2CH)

[^229]: Kobak, D. et al. Demixed principal component analysis of neural population data. *eLife* **5**, e10989 (2016).

[Article](https://doi.org/10.7554%2FeLife.10989) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=27067378) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4887222) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Demixed%20principal%20component%20analysis%20of%20neural%20population%20data&journal=eLife&doi=10.7554%2FeLife.10989&volume=5&publication_year=2016&author=Kobak%2CD)

[^230]: Klukas, M., Lewis, M. & Fiete, I. Efficient and flexible representation of higher-dimensional cognitive variables with grid cells. *PLoS Comput. Biol.* **16**, e1007796 (2020).

[Article](https://doi.org/10.1371%2Fjournal.pcbi.1007796) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=32343687) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC7209352) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Efficient%20and%20flexible%20representation%20of%20higher-dimensional%20cognitive%20variables%20with%20grid%20cells&journal=PLoS%20Comput.%20Biol.&doi=10.1371%2Fjournal.pcbi.1007796&volume=16&publication_year=2020&author=Klukas%2CM&author=Lewis%2CM&author=Fiete%2CI)

[^231]: Banino, A. et al. Vector-based navigation using grid-like representations in artificial agents. *Nature* **557**, 429–433 (2018).

[Article](https://doi.org/10.1038%2Fs41586-018-0102-6) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC1cXptlarsrY%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=29743670) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Vector-based%20navigation%20using%20grid-like%20representations%20in%20artificial%20agents&journal=Nature&doi=10.1038%2Fs41586-018-0102-6&volume=557&pages=429-433&publication_year=2018&author=Banino%2CA)

[^232]: Sanders, H., Wilson, M. A. & Gershman, S. J. Hippocampal remapping as hidden state inference. *eLife* **9**, e51140 (2020).

[Article](https://doi.org/10.7554%2FeLife.51140) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=32515352) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC7282808) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Hippocampal%20remapping%20as%20hidden%20state%20inference&journal=eLife&doi=10.7554%2FeLife.51140&volume=9&publication_year=2020&author=Sanders%2CH&author=Wilson%2CMA&author=Gershman%2CSJ)

[^233]: Killian, N. J., Jutras, M. J. & Buffalo, E. A. A map of visual space in the primate entorhinal cortex. *Nature* **491**, 761–764 (2012).

[Article](https://doi.org/10.1038%2Fnature11587) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC38XhsFOmtLnK) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=23103863) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3565234) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=A%20map%20of%20visual%20space%20in%20the%20primate%20entorhinal%20cortex&journal=Nature&doi=10.1038%2Fnature11587&volume=491&pages=761-764&publication_year=2012&author=Killian%2CNJ&author=Jutras%2CMJ&author=Buffalo%2CEA)

[^234]: Aronov, D., Nevers, R. & Tank, D. W. Mapping of a non-spatial dimension by the hippocampal–entorhinal circuit. *Nature* **543**, 719–722 (2017).

[Article](https://doi.org/10.1038%2Fnature21692) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2sXltl2iu7g%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=28358077) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC5492514) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Mapping%20of%20a%20non-spatial%20dimension%20by%20the%20hippocampal%E2%80%93entorhinal%20circuit&journal=Nature&doi=10.1038%2Fnature21692&volume=543&pages=719-722&publication_year=2017&author=Aronov%2CD&author=Nevers%2CR&author=Tank%2CDW)

[^235]: Constantinescu, A. O., O’Reilly, J. X. & Behrens, T. E. Organizing conceptual knowledge in humans with a gridlike code. *Science* **352**, 1464–1468 (2016).

[Article](https://doi.org/10.1126%2Fscience.aaf0941) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC28XpslOqsLw%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=27313047) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC5248972) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Organizing%20conceptual%20knowledge%20in%20humans%20with%20a%20gridlike%20code&journal=Science&doi=10.1126%2Fscience.aaf0941&volume=352&pages=1464-1468&publication_year=2016&author=Constantinescu%2CAO&author=O%E2%80%99Reilly%2CJX&author=Behrens%2CTE)

[^236]: Hillar, C. J. & Tran, N. M. Robust exponential memory in Hopfield networks. *Math. Neurosci.* **8**, 1 (2018).

[Article](https://link.springer.com/doi/10.1186/s13408-017-0056-2) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Robust%20exponential%20memory%20in%20Hopfield%20networks&journal=Math.%20Neurosci.&doi=10.1186%2Fs13408-017-0056-2&volume=8&publication_year=2018&author=Hillar%2CCJ&author=Tran%2CNM)

[^237]: Fiete, I., Schwab, D. & Tran, N. M. in *Proc. 2nd Workshop on Biological Distributed Algorithms* [https://fietelabmit.files.wordpress.com/2018/12/Ngoc\_BDA\_2014.pdf](https://fietelabmit.files.wordpress.com/2018/12/Ngoc_BDA_2014.pdf) (2014).

[^238]: Mosheiff, N. & Burak, Y. Velocity coupling of grid cell modules enables stable embedding of a low dimensional variable in a high dimensional neural attractor. *eLife* **8**, 48494 (2019).

[Article](https://doi.org/10.7554%2FeLife.48494) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Velocity%20coupling%20of%20grid%20cell%20modules%20enables%20stable%20embedding%20of%20a%20low%20dimensional%20variable%20in%20a%20high%20dimensional%20neural%20attractor&journal=eLife&doi=10.7554%2FeLife.48494&volume=8&publication_year=2019&author=Mosheiff%2CN&author=Burak%2CY)

[^239]: Muscinelli, S. P., Gerstner, W. & Brea, J. Exponentially long orbits in Hopfield neural networks. *Neural Comput.* **29**, 458–484 (2017).

[Article](https://doi.org/10.1162%2FNECO_a_00919) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=27870611) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Exponentially%20long%20orbits%20in%20Hopfield%20neural%20networks&journal=Neural%20Comput.&doi=10.1162%2FNECO_a_00919&volume=29&pages=458-484&publication_year=2017&author=Muscinelli%2CSP&author=Gerstner%2CW&author=Brea%2CJ)

[^240]: Mathis, A., Herz, A. & Stemmler, M. Optimal population codes for space: grid cells outperform place cells. *Neural Comput.* **24**, 2280–2317 (2012).

[Article](https://doi.org/10.1162%2FNECO_a_00319) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=22594833) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Optimal%20population%20codes%20for%20space%3A%20grid%20cells%20outperform%20place%20cells&journal=Neural%20Comput.&doi=10.1162%2FNECO_a_00319&volume=24&pages=2280-2317&publication_year=2012&author=Mathis%2CA&author=Herz%2CA&author=Stemmler%2CM)

[^241]: Gardner, E. The space of interactions in neural network models. *J. Phys. A Math. Gen.* **21**, 257 (1988).

[Article](https://doi.org/10.1088%2F0305-4470%2F21%2F1%2F030) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20space%20of%20interactions%20in%20neural%20network%20models&journal=J.%20Phys.%20A%20Math.%20Gen.&doi=10.1088%2F0305-4470%2F21%2F1%2F030&volume=21&publication_year=1988&author=Gardner%2CE)

[^242]: Gripon, V. & Berrou, C. Sparse neural networks with large learning diversity. *IEEE Trans. Neural Netw.* **22**, 1087–1096 (2011).

[Article](https://doi.org/10.1109%2FTNN.2011.2146789) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=21652285) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Sparse%20neural%20networks%20with%20large%20learning%20diversity&journal=IEEE%20Trans.%20Neural%20Netw.&doi=10.1109%2FTNN.2011.2146789&volume=22&pages=1087-1096&publication_year=2011&author=Gripon%2CV&author=Berrou%2CC)

[^243]: Abu-Mostafa, Y. S. & St Jacques, J. Information capacity of the Hopfield model. *IEEE Trans. Inf. Theory* **31**, 461–464 (1985).

[Article](https://doi.org/10.1109%2FTIT.1985.1057069) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Information%20capacity%20of%20the%20Hopfield%20model&journal=IEEE%20Trans.%20Inf.%20Theory&doi=10.1109%2FTIT.1985.1057069&volume=31&pages=461-464&publication_year=1985&author=Abu-Mostafa%2CYS&author=Jacques%2CJ)

[^244]: McEliece, R. J., Posner, E. C., Rodemich, E. R. & Venkatesh, S. S. The capacity of the Hopfield associative memory. *IEEE Trans. Inf. Theory* **33**, 461–482 (1987).

[Article](https://doi.org/10.1109%2FTIT.1987.1057328) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20capacity%20of%20the%20Hopfield%20associative%20memory&journal=IEEE%20Trans.%20Inf.%20Theory&doi=10.1109%2FTIT.1987.1057328&volume=33&pages=461-482&publication_year=1987&author=McEliece%2CRJ&author=Posner%2CEC&author=Rodemich%2CER&author=Venkatesh%2CSS)

[^245]: Amit, D. J., Gutfreund, H. & Sompolinsky, H. Statistical mechanics of neural networks near saturation. *Ann. Phys.* **173**, 30–67 (1987).

[Article](https://doi.org/10.1016%2F0003-4916%2887%2990092-3) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Statistical%20mechanics%20of%20neural%20networks%20near%20saturation&journal=Ann.%20Phys.&doi=10.1016%2F0003-4916%2887%2990092-3&volume=173&pages=30-67&publication_year=1987&author=Amit%2CDJ&author=Gutfreund%2CH&author=Sompolinsky%2CH)

[^246]: Maheswaranathan, N., Williams, A. H., Golub, M. D., Ganguli, S. & Sussillo, D. Reverse engineering recurrent networks for sentiment classification reveals line attractor dynamics. In *Advances in Neural Information Processing Systems* 15696–15705 (NeurIPS, 2019).

[^247]: Kanitscheider, I. & Fiete, I. Emergence of dynamically reconfigurable hippocampal responses by learning to perform probabilistic spatial reasoning. Preprint at *bioRxiv* [https://doi.org/10.1101/231159](https://doi.org/10.1101/231159) (2017).

[Article](https://doi.org/10.1101%2F231159) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Emergence%20of%20dynamically%20reconfigurable%20hippocampal%20responses%20by%20learning%20to%20perform%20probabilistic%20spatial%20reasoning&journal=bioRxiv&doi=10.1101%2F231159&publication_year=2017&author=Kanitscheider%2CI&author=Fiete%2CI)

[^248]: Schaeffer, R., Khona, M., Meshulam, L., International Brain Laboratory & Fiete, I. Reverse-engineering recurrent neural network solutions to a hierarchical inference task for mice. In *Advances in Neural Information Processing Systems* 4584–4596 (NeurIPS 2020).

[^249]: Kanitscheider, I. & Fiete, I. R. Training recurrent networks to generate hypotheses about how the brain solves hard navigation problems. In *Advances in Neural Information Processing Systems* 4529–4538 (NeurIPS, 2017).

[^250]: Wang, X.-J. Synaptic basis of cortical persistent activity: the importance of NMDA receptors to working memory. *J. Neurosci.* **19**, 9587–9603 (1999).

[Article](https://doi.org/10.1523%2FJNEUROSCI.19-21-09587.1999) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DyaK1MXnslyhs70%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=10531461) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC6782911) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Synaptic%20basis%20of%20cortical%20persistent%20activity%3A%20the%20importance%20of%20NMDA%20receptors%20to%20working%20memory&journal=J.%20Neurosci.&doi=10.1523%2FJNEUROSCI.19-21-09587.1999&volume=19&pages=9587-9603&publication_year=1999&author=Wang%2CX-J)

[^251]: Ermentrout, G. B. & Kopell, N. Multiple pulse interactions and averaging in systems of coupled neural oscillators. *J. Math. Biol.* **29**, 195–217 (1991).

[Article](https://link.springer.com/doi/10.1007/BF00160535) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Multiple%20pulse%20interactions%20and%20averaging%20in%20systems%20of%20coupled%20neural%20oscillators&journal=J.%20Math.%20Biol.&doi=10.1007%2FBF00160535&volume=29&pages=195-217&publication_year=1991&author=Ermentrout%2CGB&author=Kopell%2CN)

[^252]: Boerlin, M., Machens, C. K. & Denève, S. Predictive coding of dynamical variables in balanced spiking networks. *PLoS Comput. Biol.* **9**, e1003258 (2013).

[Article](https://doi.org/10.1371%2Fjournal.pcbi.1003258) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=24244113) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3828152) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Predictive%20coding%20of%20dynamical%20variables%20in%20balanced%20spiking%20networks&journal=PLoS%20Comput.%20Biol.&doi=10.1371%2Fjournal.pcbi.1003258&volume=9&publication_year=2013&author=Boerlin%2CM&author=Machens%2CCK&author=Den%C3%A8ve%2CS)

[^253]: Frady, E. P. & Sommer, F. T. Robust computation with rhythmic spike patterns. *Proc. Natl Acad. Sci. USA* **116**, 18050–18059 (2019).

[Article](https://doi.org/10.1073%2Fpnas.1902653116) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC1MXhslWktLjE) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=31431524) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC6731666) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Robust%20computation%20with%20rhythmic%20spike%20patterns&journal=Proc.%20Natl%20Acad.%20Sci.%20USA&doi=10.1073%2Fpnas.1902653116&volume=116&pages=18050-18059&publication_year=2019&author=Frady%2CEP&author=Sommer%2CFT)

[^254]: Darshan, R. & Rivkind, A. Learning to represent continuous variables in heterogeneous neural networks. *Cell Rep.* **39**, 110612 (2021).

[Article](https://doi.org/10.1016%2Fj.celrep.2022.110612) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Learning%20to%20represent%20continuous%20variables%20in%20heterogeneous%20neural%20networks&journal=Cell%20Rep.&doi=10.1016%2Fj.celrep.2022.110612&volume=39&publication_year=2021&author=Darshan%2CR&author=Rivkind%2CA)

[^255]: Arnold, D. B. & Robinson, D. A. A learning network model of the neural integrator of the oculomotor system. *Biol. Cybern.* **64**, 447–454 (1991).

[Article](https://link.springer.com/doi/10.1007/BF00202608) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaK3Mzit1Wqsg%3D%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=1863658) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=A%20learning%20network%20model%20of%20the%20neural%20integrator%20of%20the%20oculomotor%20system&journal=Biol.%20Cybern.&doi=10.1007%2FBF00202608&volume=64&pages=447-454&publication_year=1991&author=Arnold%2CDB&author=Robinson%2CDA)

[^256]: Hahnloser, R. H. R., Seung, H. S. & Slotine, J.-J. Permitted and forbidden sets in symmetric threshold-linear networks. *Neural Comput.* **15**, 621–638 (2003).

[Article](https://doi.org/10.1162%2F089976603321192103) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=12620160) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Permitted%20and%20forbidden%20sets%20in%20symmetric%20threshold-linear%20networks&journal=Neural%20Comput.&doi=10.1162%2F089976603321192103&volume=15&pages=621-638&publication_year=2003&author=Hahnloser%2CRHR&author=Seung%2CHS&author=Slotine%2CJ-J)

[^257]: Seung, H. S. Learning continuous attractors in recurrent networks. In *Advances in Neural Information Processing Systems* 654–660 (NeurIPS, 1998).

[^258]: Mante, V., Sussillo, D., Shenoy, K. V. & Newsome, W. T. Context-dependent computation by recurrent dynamics in prefrontal cortex. *Nature* **503**, 78–84 (2013).

[Article](https://doi.org/10.1038%2Fnature12742) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC3sXhsleksLrM) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=24201281) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4121670) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Context-dependent%20computation%20by%20recurrent%20dynamics%20in%20prefrontal%20cortex&journal=Nature&doi=10.1038%2Fnature12742&volume=503&pages=78-84&publication_year=2013&author=Mante%2CV&author=Sussillo%2CD&author=Shenoy%2CKV&author=Newsome%2CWT)

[^259]: Cueva, C. J. & Wei, X.-X. Emergence of functional and structural properties of the head direction system by optimization of recurrent neural networks. In *Intl Conf. on Learning Representations* *2020* [https://openreview.net/forum?id=HklSeREtPB](https://openreview.net/forum?id=HklSeREtPB) (2020).

[^260]: Schaeffer, R., Khona, M. & Fiete, I. R. in *ICML 2022 2nd AI for Science Workshop* [https://openreview.net/forum?id=mxi1xKzNFrb](https://openreview.net/forum?id=mxi1xKzNFrb) (2022).

[^261]: Grosenick, L., Marshel, J. H. & Deisseroth, K. Closed-loop and activity-guided optogenetic control. *Neuron* **86**, 106–139 (2015).

[Article](https://doi.org/10.1016%2Fj.neuron.2015.03.034) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2MXmsVCisbc%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=25856490) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4775736) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Closed-loop%20and%20activity-guided%20optogenetic%20control&journal=Neuron&doi=10.1016%2Fj.neuron.2015.03.034&volume=86&pages=106-139&publication_year=2015&author=Grosenick%2CL&author=Marshel%2CJH&author=Deisseroth%2CK)

[^262]: Latham, P. E., Deneve, S. & Pouget, A. Optimal computation with attractor networks. *J. Physiol.* **97**, 683–694 (2003).

[Google Scholar](http://scholar.google.com/scholar_lookup?&title=Optimal%20computation%20with%20attractor%20networks&journal=J.%20Physiol.&volume=97&pages=683-694&publication_year=2003&author=Latham%2CPE&author=Deneve%2CS&author=Pouget%2CA)

[^263]: Bouchacourt, F. & Buschman, T. J. A flexible model of working memory. *Neuron* **103**, 147–160 (2019).

[Article](https://doi.org/10.1016%2Fj.neuron.2019.04.020) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC1MXps1Ghtb0%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=31103359) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC6613943) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=A%20flexible%20model%20of%20working%20memory&journal=Neuron&doi=10.1016%2Fj.neuron.2019.04.020&volume=103&pages=147-160&publication_year=2019&author=Bouchacourt%2CF&author=Buschman%2CTJ)

[^264]: Hasenstaub, A., Sachdev, R. N. S. & McCormick, D. A. State changes rapidly modulate cortical neuronal responsiveness. *J. Neurosci.* **27**, 9607–9622 (2007).

[Article](https://doi.org/10.1523%2FJNEUROSCI.2184-07.2007) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD2sXhtVKlsr7K) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=17804621) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC6672966) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=State%20changes%20rapidly%20modulate%20cortical%20neuronal%20responsiveness&journal=J.%20Neurosci.&doi=10.1523%2FJNEUROSCI.2184-07.2007&volume=27&pages=9607-9622&publication_year=2007&author=Hasenstaub%2CA&author=Sachdev%2CRNS&author=McCormick%2CDA)

[^265]: Aksay, E., Baker, R., Seung, H. S. & Tank, D. W. Anatomy and discharge properties of pre-motor neurons in the goldfish medulla that have eye-position signals during fixations. *J. Neurophysiol.* **84**, 1035–1049 (2000).

[Article](https://doi.org/10.1152%2Fjn.2000.84.2.1035) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DC%2BD3cvivFCruw%3D%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=10938326) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Anatomy%20and%20discharge%20properties%20of%20pre-motor%20neurons%20in%20the%20goldfish%20medulla%20that%20have%20eye-position%20signals%20during%20fixations&journal=J.%20Neurophysiol.&doi=10.1152%2Fjn.2000.84.2.1035&volume=84&pages=1035-1049&publication_year=2000&author=Aksay%2CE&author=Baker%2CR&author=Seung%2CHS&author=Tank%2CDW)

[^266]: Godaux, E., Mettens, P. & Chéron, G. Differential effect of injections of kainic acid into the prepositus and the vestibular nuclei of the cat. *J. Physiol.* **472**, 459–482 (1993).

[Article](https://doi.org/10.1113%2Fjphysiol.1993.sp019956) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaK2c7psVCjsQ%3D%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=8145154) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC1160496) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Differential%20effect%20of%20injections%20of%20kainic%20acid%20into%20the%20prepositus%20and%20the%20vestibular%20nuclei%20of%20the%20cat&journal=J.%20Physiol.&doi=10.1113%2Fjphysiol.1993.sp019956&volume=472&pages=459-482&publication_year=1993&author=Godaux%2CE&author=Mettens%2CP&author=Ch%C3%A9ron%2CG)

[^267]: Hulse, B. K. et al. A connectome of the *Drosophila* central complex reveals network motifs suitable for flexible navigation and context-dependent action selection. *eLife* **10**, e66039 (2021).

[Article](https://doi.org/10.7554%2FeLife.66039) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=34696823) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC9477501) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=A%20connectome%20of%20the%20Drosophila%20central%20complex%20reveals%20network%20motifs%20suitable%20for%20flexible%20navigation%20and%20context-dependent%20action%20selection&journal=eLife&doi=10.7554%2FeLife.66039&volume=10&publication_year=2021&author=Hulse%2CBK)

[^268]: Gu, Y. et al. A map-like micro-organization of grid cells in the medial entorhinal cortex. *Cell* **175**, 736–750.e30 (2018).

[Article](https://doi.org/10.1016%2Fj.cell.2018.08.066) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC1cXhvVahsLfJ) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=30270041) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC6591153) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=A%20map-like%20micro-organization%20of%20grid%20cells%20in%20the%20medial%20entorhinal%20cortex&journal=Cell&doi=10.1016%2Fj.cell.2018.08.066&volume=175&pages=736-750.e30&publication_year=2018&author=Gu%2CY)

[^269]: Koulakov, A. A. & Chklovskii, D. B. Orientation preference patterns in mammalian visual cortex: a wire length minimization approach. *Neuron* **29**, 519–527 (2001).

[Article](https://doi.org/10.1016%2FS0896-6273%2801%2900223-9) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD3MXisleisrk%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=11239440) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Orientation%20preference%20patterns%20in%20mammalian%20visual%20cortex%3A%20a%20wire%20length%20minimization%20approach&journal=Neuron&doi=10.1016%2FS0896-6273%2801%2900223-9&volume=29&pages=519-527&publication_year=2001&author=Koulakov%2CAA&author=Chklovskii%2CDB)

[^270]: Wills, T. J., Cacucci, F., Burgess, N. & O’Keefe, J. Development of the hippocampal cognitive map in preweanling rats. *Science* **328**, 1573–1576 (2010).

[Article](https://doi.org/10.1126%2Fscience.1188224) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC3cXnsVWnt74%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=20558720) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3543985) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Development%20of%20the%20hippocampal%20cognitive%20map%20in%20preweanling%20rats&journal=Science&doi=10.1126%2Fscience.1188224&volume=328&pages=1573-1576&publication_year=2010&author=Wills%2CTJ&author=Cacucci%2CF&author=Burgess%2CN&author=O%E2%80%99Keefe%2CJ)

[^271]: Langston, R. F. et al. Development of the spatial representation system in the rat. *Science* **328**, 1576–1580 (2010).

[Article](https://doi.org/10.1126%2Fscience.1188210) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC3cXnsVWnt78%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=20558721) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Development%20of%20the%20spatial%20representation%20system%20in%20the%20rat&journal=Science&doi=10.1126%2Fscience.1188210&volume=328&pages=1576-1580&publication_year=2010&author=Langston%2CRF)