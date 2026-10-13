---
title: "Software in the natural world: A computational approach to hierarchical emergence"
source: "https://arxiv.org/html/2402.09090"
author:
published:
created: 2026-10-13
description:
tags:
  - "clippings"
---
Fernando E. Rosas Email: [email: f.rosas@sussex.ac.uk](mailto:email:%20f.rosas@sussex.ac.uk) Affiliation: Department of Informatics, University of Sussex Affiliation: Sussex Centre for Consciousness Science and Sussex AI, University of Sussex Affiliation: Center for Psychedelic Research and Centre for Complexity Science, Department of Brain Science, Imperial College London Affiliation: Center for Eudaimonia and Human Flourishing, University of Oxford    Bernhard C. Geiger Affiliation: Know-Center GmbH, Graz, Austria Affiliation: Signal Processing and Speech Communication Laboratory, Graz University of Technology, Graz, Austria    Andrea I Luppi Affiliation: Montreal Neurological Institute, McGill University    Anil K. Seth Affiliation: Department of Informatics, University of Sussex Affiliation: Sussex Centre for Consciousness Science and Sussex AI, University of Sussex    Daniel Polani Affiliation: Department of Computer Science, University of Hertfordshire, Hatfield, UK    Michael Gastpar Affiliation: School of Computer and Communication Sciences, EPFL, Lausanne, Switzerland    Pedro A.M. Mediano Affiliation: Department of Computing, Imperial College London Affiliation: Division of Psychology and Language Sciences, University College London

###### Abstract

Understanding the functional architecture of complex systems is crucial to illuminate their inner workings and enable effective methods for their prediction and control. Recent advances have introduced tools to characterise emergent macroscopic levels; however, while these approaches are successful in identifying *when* emergence takes place, they are limited in the extent they can determine *how* it does. Here we address this important limitation by developing a computational approach to emergence, which characterises macroscopic processes in terms of their computational capabilities. Concretely, we articulate a view on emergence based on how software works, which is rooted on a mathematical formalisation of how macroscopic processes can express self-contained informational, interventional, and computational properties. This framework reveals a hierarchy of nested self-contained processes that determines what computations take place at what level, which in turn delineates the functional architecture of a complex system. This approach is illustrated on paradigmatic models from the statistical physics and computational neuroscience literature, which are shown to exhibit macroscopic processes that are akin to software in human-engineered systems. Overall, this framework enables a deeper understanding of the multi-level structure of complex systems, revealing specific ways in which they can be efficiently simulated, predicted, and controlled.

## I Introduction

Complex systems — such as the global economy, the global weather, and the human brain — are composed of many elements whose intricate dynamical interactions give rise to distinct phenomena at various spatio-temporal scales [^1] [^2]. For example, the interaction between the synaptic activity of individual neurons can give rise to mesoscopic oscillatory patterns involving entire brain regions [^3], which in turn exhibit distinct coupling patterns at a macroscopic, whole-brain level that are implicated in distinct cognitive functions [^4]. Crucially, phenomena at certain scales may not be relevant for identifying what is relevant for another; for instance, particle physics may not be relevant for neuroscience despite neurons being made of particles.

In order to successfully understand, predict, and control such complex systems, it is crucial to be able to characterise their *functional architecture* — i.e., to identify the relevant macroscopic spatio-temporal levels and delineate the activity that ‘makes a difference’ for each of them. Unfortunately, such characterisation is often done in ad-hoc ways, as finding rigorous, principled, and general methods is highly non-trivial [^2] [^5]. Importantly, this is not just a problem of lack of data or insufficient system specification: as the opacity of deep learning models dramatically illustrates [^6] [^7], even a full description of the microscopic components and their interactions may not facilitate the identification of when and where emergent phenomena may take place.

Providing a rigorous characterisation of the functional architecture of multi-level complex systems remains an important, yet unsolved challenge. A promising line of investigation has developed general methods to identify and characterise macroscopic levels with emergent properties [^8] [^9] [^10] [^11] [^12]. These works provide new information-theoretic tools for researchers to rigorously frame conjectures about emergence on a wide range of dynamical processes, and statistical tools to test these conjectures on data. Despite being only recently developed, the practical efficacy of these approaches has already been demonstrated in a number of empirical investigations [^13] [^14] [^15] [^16] [^17] [^18].

However, as promising as these developments are in providing effective methods to determine *when* emergence takes place, they are limited in the degree they can specify *how* this happens. For example, existing methods might be able to determine whether the dynamics of a recurrent neural network have emergent character via the calculation of specific information-theoretic quantities. However, these approaches could not specify which exactly are the underlying dynamical properties facilitating this, or how these properties are distributed across the various spatio-temporal scales of the system. Answering those questions is critical to deepen our understanding of how those systems work, and under what conditions they may break down.

Here we address these open questions by investigating emergence from a computational perspective, complementing information-theoretic methods with principles of theoretical computer science — more specifically, automata theory [^19] and computational mechanics [^20]. Concretely, we investigate emergence by operationalising three ways in which a macroscopic process can be self-contained: informational, causal, and computational closure — which correspond to optimal prediction of spontaneous dynamics, exhaustive capability to perform interventions, and containment of computational processing (respectively). By developing these notions within a unified mathematical framework, this approach establishes formal foundations to reason about the emergence of self-contained *effective macroscopic theories* within microscopic stochastic dynamical processes, which are akin to software in human-engineered systems in their ability to that carry out computations independently of the substrate they are implemented in.

The results facilitated by our framework specify the conditions under which systems give rise to informational, causal, and computational closed macroscopic levels, and clarify the relationships between these properties. Furthermore, our framework reveals how computationally closed levels are hierarchically organised into a lattice of nested computational structures ordered by coarse-graining relationships. This lattice constitutes a blueprint for the functional architecture of a complex system, which describes what computations take place at what level. Additionally, our results establish links with the theory of lumpable time series [^21], which open the door for efficient algorithms to estimate these properties in real-world applications. The power and scope of this approach is illustrated in various case studies, including diffusion processes, spin models, random walks on networks, agent-based models, and neural systems that model processes of memory consolidation and retrieval. Our framework deepens our understanding of the multi-level dynamics of these systems, revealing specific ways in which they can be efficiently predicted and controlled. Moreover, its generality and broad applicability opens the way for a wide range of future theoretical developments and practical applications.

The rest of the paper is structured as follows. First Section II provides background information, and then Section III gives an intuitive overview of the proposed framework. After this, Section IV presents a number of case studies to showcase the proposed framework. Finally, Section V outlines the main implications of our findings, and discusses related work. A complete exposition of the formal theory supporting our framework is provided in the Appendix.

## II Preliminaries

### II.1 The ‘software-ness’ of software

Here we investigate systems whose macroscopic levels posses a certain degree of causal ‘self-containment’ with respect to their microscopic instantiation, which we describe as *emergent*. Under this view, phenomena taking place at an emergent macroscopic level depend solely on other phenomena at the same level, without being causally affected by more fine-grained distinctions observed at microscopic levels. To illustrate these ideas, consider a simple scenario where a computer is running a script that executes the command c=a+b. Crucially, the value assigned to the variable c depends on the values assigned to a and b, but does not depend on peculiarities of the physical substrate over which the program is running (e.g. the spin of the electrons that make the transistors, etc). This relative autonomy from its substrate is a key feature of what software is: software is always ‘running on top’ of hardware while having some ‘life of its own’ — following its own rules irrespective of many details of the substrate over which it is instantiated.

Following this line of thinking, one can say that a system is running software when it has a macroscopic scale that is causally closed with respect to lower scales. Technically speaking, causal closure takes place when interventions at a set of macroscopic (i.e. aggregated, coarse-grained) variables are sufficient to guarantee specific outcomes on other macroscopic variables. Consequently, ‘programs’ can be understood as specific (sets of) relations between macroscopic variables that do not depend on specific microscale instantiations — in fact, one can imagine many different microscale instantiations with precisely equivalent macroscopic behaviour. In the case of the computer script considered above, the value assigned to the variable c only depends on the value previously assigned to a and b, and not on details of the physical instantiation of those variables in terms of transistors and other hardware aspects. Hence, causal closure implies that events that happen at a macroscale are ‘shielded’ from how they are instantiated at a microscopic level — i.e. from their implementation.

The distinction of software/hardware has been instrumental in the development of our modern technological world [^22]. Distinguishing software from hardware is what allows designers to create programs that can be implemented over an variety of different physical substrates. From a philosophical perspective, the notions of software and causal closure are related to the principle of ‘multiple realisability’ [^23] [^24], which states that there being many different microscopic ways to realise a specific macroscopic function, and the idea of ‘substrate independence’ [^25], which highlights that some functions may be agnostic with respect to the substrate over which they are implemented (e.g. carbon vs silicon). From a scientific perspective, these notions are related to the idea of minimal model explanations, which aims to explain a phenomenon via a minimal set of macroscopic features that remain stable after perturbations to their microscopic details [^26].

While the idea of software was conceived in the context of device design, an interesting question arises as to whether natural, non-engineered systems could be usefully described in terms of hardware-software distinctions. For example, under what conditions is it reasonable to say that different natural systems (e.g. different living organisms of the same species) are running the same software? Also, would it be reasonable to think of the human brain as running software over neural hardware [^27] [^25] <sup>1</sup>?

Arguments can be made, based on evolutionary and thermodynamic considerations, for why and to what degree biological systems may display software-like, macroscopic levels that are causally closed. Living organisms perform actions (i.e. interventions over their environments and themselves) in order to guarantee their survival. However, some interventions are more feasible to implement than others — e.g., while it is almost impossible to intervene on the momentum of a particular molecule in a glass of water, it is much easier to increase its mean temperature together with all other molecules in the glass. Causally closed systems are those for which macroscopic interventions are efficacious in controlling their macroscopic scale. Hence, one can say that systems are *as if* running software to the extent they are controllable at a particular scale at a reasonable thermodynamic cost. Building on similar arguments, causal closure has often been regarded by theoretical biologists as a necessary — albeit not sufficient — condition for the subsistence of living systems [^29] [^30] [^31].

In this paper we argue for a pragmatic approach to these issues, as our motivation is the development of analytical methods to turn these ideas into empirical questions that can be investigated quantitatively. While causal closure is certainly a necessary condition for software-like processes to exist, in this paper we explore the consequences of taking this condition to be also sufficient. Indeed, our framework reveals that causal closure is closely connected with a notion of *computational closure*, which opens — as our theory shows — fertile avenues to analyse multi-level physical processes with the tools of theoretical computer science.

### II.2 From causality to computation

![Refer to caption](https://arxiv.org/html/2402.09090v2/emachine_intro.png)

Figure 1: Illustration of causal states. Causal states are sets of of trajectories which bear equal predictions for the future evolution of the system, as defined by the equivalence relationship in Eq. ( 1 ).

Above we described the nature of software from the perspective of interventions and causal closure, and suggested how it can be used for investigating natural systems. However, while such approach would allow us to determine if a system is running software or not in terms of causal relations, it does not facilitate a direct way to describe this in terms of *computations*. One of the central aims of this paper is to illuminate the computational implications of causal closure.

To attain this, our approach takes inspiration and builds upon the rich literature of computational mechanics — a framework for the study of stochastic dynamical processes from a computational perspective [^32] [^33] [^20] [^34]. Specifically, computational mechanics studies patterns and statistical regularities observed in time series data by asking quantitative questions such as: how much historical information does the system store, where is that information stored, and how is it processed to generate future behaviour [^35] [^36] [^37]? The answers to those questions, according to computational mechanics, can be found in the states and transitions of so-called ‘ $\epsilon$ -machines’ [^37] [^38] [^32].

Figure 2: The two faces of $\epsilon$ -machines. Illustration of the dual interpretation of $\epsilon$ -machines that establish a bridge between causality and computation. a) Causal face: View of $\epsilon$ -machines as the effective mechanism driving the system, acting ‘behind the scenes’ to generate observable data (a1). Technically, this corresponds to interpreting it as a hidden Markov process — i.e., dynamics that take place on variables $E_{t}$ on a latent state-space, while generating the observable data $X_{t}$ (a2). b) Computational face. Alternative view of $\epsilon$ -machines as discrete automata, where the data corresponds to inputs given by a user driving the system between different states (b1). Technically, this corresponds to seeing it as a discrete automata with states $e_{k}$, whose deterministic transitions are governed by the input data $x_{i}$ (b2). Note that (a1) focuses on variables (e.g. $X_{t},E_{t}$), while (b2) portraits the states that those variables can take (e.g. $x_{0},e_{0}$). Fig. (a1) is adapted from Ref. [^39].

Computational mechanics introduces $\epsilon$ -machines as optimal (i.e. complete and minimimal) representations of a computational ‘engine’ that can generate the patterns observed in data. Such representation can be built by grouping past trajectories according to their forecasted futures into so-called causal states (see Figure 1). More precisely, the causal states of a time series $\bm{X}=\{X_{t}\}_{t\in\mathbb{N}}$ are the equivalence classes of past trajectories $\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t}\coloneqq(\dots,x_{t-1},x_{t})$ that are established by the following equivalence relationship:

$$
\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t}\equiv_{\epsilon}\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t}^{\prime}\quad\text{iff}\quad p(\vec{\bm{x}}^{L}_{t+1}|\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t})=p(\vec{\bm{x}}^{L}_{t+1}|\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t}^{\prime})\quad\forall\vec{\bm{x}}^{L}_{t+1},L\in\mathbb{N},
$$

where $\vec{\bm{x}}^{L}_{t+1}=(x_{t+1},\dots,x_{t+1+L})$ and $p(a|b)$ denotes the probability of $a$ given $b$ <sup>2</sup>. Hence, the causal states are given by a mapping $\epsilon$ which coarse-grains past trajectories $\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t}$, thereby generating a new time series of causal states $\bm{E}=\{E_{t}\}_{t\in\mathbb{N}}$ with $E_{t}=\epsilon(\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t})$. Formally, the $\epsilon$ -machine of $\bm{X}$ is defined as the pair $(\epsilon,T_{e,e^{\prime}}^{x})$, where $\epsilon$ is the above mapping to causal states and $T_{e,e^{\prime}}^{x}$ is a collection of transition probabilities of the form

$$
T_{e,e^{\prime}}^{x}=\mathbb{P}\{E_{t}=e^{\prime},X_{t}=x|E_{t-1}=e\}~.
$$

Hence, the causal states correspond to a kind of information bottleneck [^33]: $\epsilon$ is the coarsest coarse-graining of past trajectories $\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t}$ that retains full predictive power over future variables (i.e. $I(\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t};\vec{\bm{X}}^{L}_{t+1})=I(E_{t};\vec{\bm{X}}^{L}_{t+1})$ for all $L\in\mathbb{N}$). Additionally, the causal states have Markov dynamics, and by ‘Markovianising’ the process this forces the effective states of the process to become explicit.

In summary, the $\epsilon$ -machine provides the simplest computational mechanism capable of giving rise to the system’s dynamics. Hence, the $\epsilon$ -machine of a process can be regarded as its effective theory — akin to its equations of motion [^36]. It is important, nonetheless, to note that the causal states provide counterfactual guarantees only if the system at hand is fully observed, or equivalently, if the conditional probabilities that describe $\bm{X}$ are respected by interventions [^41]. In the case of partially observed scenarios, causal states ought to be understood in the Granger sense, i.e. as states of maximal non-mediated predictive ability [^42], and as such, the best possible attempt to identify the causal drivers given the available knowledge.

A key contribution of computational mechanics is establishing a bridge between causality and computation, which is rooted in two alternative perspectives that can be used to interpret what $\epsilon$ -machines are (see Figure 2):

- From a causal perspective, $\epsilon$ -machines can be conceived as Markov processes taking place at a hidden, latent space [^43], corresponding to the underlying mechanism at work ‘under the hood.’ From this view, the system is driven by the dynamics of causal states, and the data that one measures is a consequence of the transitions between them.
- From a computational perspective, $\epsilon$ -machines can be thought of as deterministic automata — i.e. (finite or infinite) state machines whose transitions are fully determined by an input sequence [^44]. Deterministic automata are a paradigmatic example of computational systems (typically used to drive vending machines, elevators, and traffic lights), where a string of inputs is used to drive the system through a sequence of internal states <sup>3</sup>. Under this view, the input driving the automata is the observed data, and the dynamics over causal states is the result of those.

These two quite distinct views are both consistent with what a $\epsilon$ -machine formally is, and their duality opens a principled link between principles of causality and computation <sup>4</sup>.

## III A computational approach to emergence

After setting the background and clarifying foundational ideas, this section presents the ideas at the core of our proposed framework in an intuitive manner. The exposition provides links to formal definitions and theorems in the [Appendix](#A1 "APPENDIX A THE CALCULI OF MULTI-LEVEL COMPUTATIONS ‣ Software in the natural world: A computational approach to hierarchical emergence"), where the theory is presented with full technical detail. The ideas discussed here are then illustrated by a number of case studies in Section IV.

### III.1 What drives the macro? A story of two machines

Our approach starts by combining computational mechanics [^33] [^20] and an interventionist view on causation [^47] to investigate the causality of macroscopic phenomena. Concretely, let us consider a dynamical process $X_{t}$ and a coarse-grained, macroscopic process $Z_{t}=f(X_{t})$ derived from it, and ask: what are the causes of events in $Z_{t}$?

We address this question by building on the principle that a cause of an effect is singled out by the minimal set of distinctions that make a difference for that level. Concretely, by taking inspiration from $\epsilon$ -machines (see Section II.2 and Definition 1), our approach is to identify the minimal set of distinctions between past trajectories of $\bm{X}$ that lead to different potential outcomes in the future of $\bm{Z}$. Mathematically, we build a new computational mechanics ‘machine’ based on the following equivalence relationship (see Definition 2):

$$
\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t}\equiv_{\upsilon}\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t}^{\prime}\quad\text{iff}\quad p(\vec{\bm{z}}^{L}_{t+1}|\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t})=p(\vec{\bm{z}}^{L}_{t+1}|\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t}^{\prime})\quad\forall\vec{\bm{z}}^{L}_{t+1},L\in\mathbb{N}.
$$

In contrast with Eq. (1), the resulting equivalence classes are based on the prediction of the future of $\bm{Z}$, and not the future of $\bm{X}$. This gives rise to another, usually simpler set of distinctions in the past trajectories of $X$ (i.e. a different set of causal states), which we call the $\upsilon$ -machine — with upsilon the greek equivalent to the latin u (although when combined with other letters it sounds like i), referring to ‘underlying’ for reasons explained below. The causal states of the $\upsilon$ -machine are given by a mapping $\upsilon$ which coarse-grains $\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t}$, thereby generating a new time series $\bm{U}=\{U_{t}\}_{t\in\mathbb{N}}$ with $U_{t}=\upsilon(\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t})$. Analogously than for the $\epsilon$ -machine, our results show that the causal states of the $\upsilon$ -machine to be an optimal information bottleneck — concretely, $\upsilon$ is the coarsest coarse-graining of past trajectories $\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t}$ that retains full predictive power over the future of $\bm{Z}$ (see Proposition 1).

Figure 3: The various machines associated with a macroscopic process. Diagram of the relationship between the different machines associated with a macroscopic process $\bm{Z}$ and its corresponding microscopic process $\bm{X}$. The $\epsilon$ -machines with causal states $E_{t}$ and $E^{\prime}_{t}$ correspond to the optimal prediction of the future of $\bm{X}$ and $\bm{Z}$, respectively, using data from the same level. In contrast, the $\upsilon$ -machine with causal states $U_{t}$ provides optimal prediction of the future of $\bm{Z}$ using data from $\bm{X}$, hence using the minimal amount of micro information for optimally predicting the future of the macro.

With this construction, each macroscopic process $Z_{t}=f(X_{t})$ now possesses two associated machines (see Figure 3): its $\upsilon$ -machine (with causal states $U_{t}$) that determines the states of $\bm{X}$ that make a difference for the future of $\bm{Z}$ (Definition 2), and its $\epsilon$ -machine (with causal states $E^{\prime}_{t}$) that corresponds to the set of distinctions within the past of $\bm{Z}$ that make a difference for its own evolution (Definition 1). Note that the $\epsilon$ -machine of $\bm{Z}$ is often different from the $\epsilon$ -machine of the underlying microscopic process $\bm{X}$ (with causal states $E_{t}$). These three machines are related as follows. On the one hand, the $\upsilon$ -machine of $\bm{Z}$ is usually more powerful than its own $\epsilon$ -machine (see Lemma 2), as it is not restricted to what can be observed from the macroscopic level, but also can access what is at the microscopic level — as illustrated in Figure 3. On the other hand, the $\upsilon$ -machine of $\bm{Z}$ is usually weaker than the $\epsilon$ -machine of $\bm{X}$, as the former only accounts for what is relevant for predicting $\bm{Z}$.

Seen under this light, one can conclude that the $\upsilon$ -machine of $\bm{Z}$ capture its ‘genuine cause’ (or at least its best estimation based on the information available from the micro level), while its own $\epsilon$ -machine is the best possible reconstruction of the causal states $U_{t}$ using only what is available at the level of $\bm{Z}$. That being said, please note that while the causal states $E_{t}$ and $U_{t}$ are coarse-grainings of $\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t}$ and $E^{\prime}_{t}$ is a coarse-graining of $\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t}$, their relationship can be highly non-trivial (see Counterexamples 1 and 2).

### III.2 Causal and information closure

What happens if a macroscopic process $Z_{t}=f(X_{t})$ is such that both its $\epsilon$ -machines and $\upsilon$ -machines are equivalent (i.e. if there exists a bijection between the states of the $\epsilon$ - and $\upsilon$ -machines)? If that is the case, then all the distinctions in the past trajectories of $\bm{X}$ that make a difference (i.e. the causal states of the macroscopic process, given by its $\upsilon$ -machine) can be effectively accessed from the macroscopic level. Pragmatically, this implies that all interventions that make a difference for $\bm{Z}$ can be implemented at the level of $\bm{Z}$ without checking ‘microscopic details’ related to how it is implemented by $\bm{X}$. Put simply, this means that the differences that make a difference for $Z_{t}$ are actually macroscopic differences. In this sense, it is fair to say that $Z_{t}$ is *causing its own future* — or more precisely, that all the causes of $Z_{t}$ are within its own level, and not below in a microscale. Building on these observations, we take this condition (i.e. the equivalence between the $\epsilon$ -machine and $\upsilon$ -machine of a macroscopic process $\bm{Z}$) as a formal definition of *causal closure* (Definition 3), and hence, following the discussion in Section II.1, we say that such are software-like processes running over their corresponding microscopic instantiations.

A somehow related notion is the idea of information closure, which focuses on prediction instead of causation. Information closure was first introduced as a way to quantify the degree of autonomy of an organism with respect to its environment [^48], and was then extended to explore the degree to which a macroscopic level depends on its underlying microscale [^49]. This, in turn, has been used to investigate emergence [^12], understanding it as macroscopic processes which can optimally predict themselves. Concretely, a macroscopic process $\bm{Z}$ can be said to be informationally closed with respect to the microscopic process $\bm{X}$ if the following condition is satisfied (see Definition 4):

$$
I(\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t};\vec{\bm{Z}}^{L}_{t+1})=I(\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t};\vec{\bm{Z}}^{L}_{t+1})\quad\forall L\in\mathbb{N},
$$

where $I$ is Shannon’s mutual information, which quantifies the amount of predictive information linking its arguments <sup>5</sup>. This condition implies that knowledge about the micro-scale does not enhance the predictability of the macro-scale process above the self-predictive power of the process over itself. This makes the macro-scale ‘informationally sufficient’ to predict itself, making it unnecessary to refer to the micro-scale <sup>6</sup>.

What is the precise relationship between causal and informational closure? Information closure only requires that one is able to predict the same amount of information from micro or macro, which may sound weaker than requiring that the actual structure of the underlying machines to be equivalent. Perhaps surprisingly, a first consequence of our framework (Theorem 1) proves that information and causal closure are equivalent for any macroscopic process $Z_{t}=g(\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t})$. That said, it is important to note that causal closure (as defined here) only provides counterfactual guarantees if the system described by $\bm{X}$ is fully observed; otherwise, it ought to be understood in the Granger sense, i.e. as a best guess given the available knowledge (see the related discussion in Section II.2).

### III.3 Computational closure and renormalisation

After establishing a rigorous definition of causal closure, identifying it with our intuitions of software, and clarifying its relationship with information closure, our next step is to investigate its properties in terms of computational principles. For this, we leverage the duality of $\epsilon$ -machines as both state-space models and as deterministic automata (see Figure 2b) as follows.

As discussed in Section II.2, automata use sequences of input symbols to generate transitions between their internal states, and hence it is natural to ask: what would happen if — due to e.g. noise or compression — one only has access to coarse-grained versions of the input symbols? In general, the transitions of an automata under coarse-grained symbols are not anymore deterministic, which breaks its internal structure. However, under some circumstances it is possible to recover deterministic transitions by considering coarse-grained states — a condition that we call *computational closure*. More formally, computational closure applies to coarse-grainings of input symbols of an automaton for which there exists a corresponding coarse-graining of states such that the resulting transitions — between coarse-grained states following the coarse-grained symbols — are again deterministic (Definition 5). Put simply, computational closure takes place when a new deterministic automaton can be obtained by coarse-graining both the states of the original automaton and its input alphabet (see Figure 4).

Figure 4: Example of computational closure. Illustration where micro causal states are shown as small golden nodes and macro causal states are represented as big pale-yellow nodes. Transitions of micro causal states are represented as simple arrows responding to three possible inputs: two inputs denoted by a and b (not shown) trigger transitions within the same macro state, and one input denoted by c (not show) triggers a transition to a new macro state. The coarse-graining $f(\texttt{a})=f(\texttt{b})=\texttt{0}$ and $f(\texttt{c})=\texttt{1}$ generate deterministic dynamics for the macro states represented by double arrows, whereas 0 makes the state to remain and 1 makes a transition to the next state.

Figure 5: Multilevel analysis via $\epsilon$ -machines. a) Optimal automata can be built at different levels of coarse-graining of observed data. Each automaton accounts for the resulting patterns taking place at that scale. b) If the considered levels of description are computationally closed, then the automata of higher levels are coarse-grainings of the ones of levels below. This process of coarse-graining of machines reveals the computations taking place at each of those levels.

To build some intuition about computational closure, let’s consider a simple example: imagine a finite-state machine that actually consists of two independent machines, so its state is the vector of the states of each individual machine, and its input alphabet is the Cartesian product of the individual alphabets. It is clear that in this case different parts of the inputs satisfy the definition of computational closure, as different parts of the input are processed separately. The definition of computational closure generalises this to cases of machines that are nested, where part of the information can be processed autonomously but another part cannot.

Computational closure have a natural characterisation for the case of $\epsilon$ -machines (see Figure 5). Let’s consider a microscopic process $\bm{X}$ and a coarse-graining $\bm{Z}$, and denote by $E_{t}$ and $E^{\prime}_{t}$ the causal states of the $\epsilon$ -machines of them, respectively. Then, the $\epsilon$ -machine of a macroscopic process $\bm{Z}$ is computationally closed if there is a coarse-graining mapping $f^{*}$ such that $E^{\prime}_{t}=f^{*}(E_{t})$. In effect, if that is the case, then $E^{\prime}_{t}$ are coarse-grained states of the automata with states $E_{t}$, and $\bm{Z}$ provides a coarse-graining of the input symbols $\bm{X}$. Interestingly, computational closure implies that the operations of coarse-graining and calculating the $\epsilon$ -machine are interchangeable, or equivalently, that the following diagram commutes:

where $f$ and $f^{*}$ are coarse-graining operations and $\epsilon$ and $\epsilon^{\prime}$ are the coarse-grainings that lead to the causal states of the corresponding $\epsilon$ -machines. Therefore, computationally closed levels can be said to carry out a specific portion of the computations of the whole process — the part that remains after coarse-graining the $\epsilon$ -machine of the base level.

An attractive aspect of computational closure is that it can be understood from a renormalisation theory [^52] perspective as follows. The $\epsilon$ -machines of the micro- and macroscropic processes can be seen as the ‘theory’, or model, that best explains the statistical patterns observed at each level. Hence, the question we are considering can be reframed as asking how can one obtain an effective theory to explain the patterns observed in coarse-grained data. The commuting diagram above says that, if computational closure holds, then effective theories to explain macro levels can be found simply by coarse-graining the theory that explains the level below <sup>7</sup>. Therefore, macroscopic levels that are computationally closed can be thoroughly described without relying on the full microscopic theory, but using solely a simpler, coarse-grained version of it. Conversely, the part of the computations that take place at a computationally closed level can be extracted by an appropriate coarse-graining of the theory/ $\epsilon$ -machine of the microscopic level. Please note that this is certainly not true for arbitrary macroscopic processes, whose $\epsilon$ -machines are often incompatible — and hence incomparable — with the one of the micro (for a minimal example, see Counterexample 1).

### III.4 Causal closure, computational closure, and lumpability

Table 1: Summary of main concepts

| Term | Explanation |
| --- | --- |
| Micro level | Basic time-series |
| Macro level | A coarse-graining of a micro process |
| $\epsilon$ -machine | Model of a process built on the history at the same level |
| $\upsilon$ -machine | Model of a process built on the history at a level below |
| Causal states | Hidden states of $\epsilon$ - or $\upsilon$ -machines |
| Information closure | When best predictions of macro can be done from the same macro |
| Causal closure | When $\epsilon$ - and $\upsilon$ -machines coincide |
| Computational closure | When $\epsilon$ -machine of macro is a coarse-graining of $\epsilon$ -machine of micro |
| Lumpability | The ability of a Markov process to remain Markovian after being coarse-grained |

At this point one may wonder: what is the relation between computational and causal closure? Our second main result (Theorem 2) reveals that, for macroscopic processes of the form $Z_{t}=f(X_{t})$, information closure implies computational closure <sup>8</sup>. This result may be surprising, as computational closure sounds more restrictive than information/causal closure. The reason why computational closure does not imply information/causal closure is that whereas the former is based on sufficiency, the latter also requires necessity. In effect, while for computational closure it is enough if the causal states of the macro are compatible with the causal states at the micro (i.e., induce a coarser equivalence class), causal closure also requires every relevant causal state at the micro to be accessible from the macro. Hence, a computationally closed coarse-graining may nonetheless be coarser than the partition induced by its $\upsilon$ -machine, and hence fail to guarantee causal closure. For a minimal example of this, see Counterexample 4.

Theorem 2 is important, as it provides a computational interpretation for causally closed systems — i.e., to macroscopic processes that can be described as software-like. Indeed, this result shows that systems that exhibit software-like macroscopic processes are characterised by having a portion of the computations that are carried out autonomously from the rest of the system, which can be efficiently controlled. Hence, our framework puts the arguments developed in Section II.1 on a rigorous theoretical footing, while providing quantitative tools to investigate them in concrete, empirical data.

The relationship between causal and computational closure is further clarified by our final theoretical result, which relates these notions with *weak* and *strong lumpability*. Lumpability pertains to the study of how the memory of a stochastic process is affected after it is coarse-grained. More specifically, a memoryless (i.e. Markovian) process is lumpable if it has a coarse-graining that gives rise to equally memoryless dynamics — being strongly lumpable if this only depends on the transition probabilities, and weakly lumpable if this only holds for specific initial conditions (see Definition 7 and Ref. [^21]). This type of inquiry leads to a question: which coarse-grainings of causal states give rise to $\epsilon$ -machines of macroscopic processes of the original process? Our framework shows (Theorem 3) that weakly lumpable coarse-grainings of causal states are enough to guarantee this, but the resulting levels may satisfy computational but not information/causal closure. In contrast, coarse-grainings that are strongly lumpable are guaranteed to give rise to the $\epsilon$ -machine of causal/informationally closed macroscopic processes. These results imply that causal/informational closure is a more ‘robust’ property than computational closure, as the latter can be disrupted by deviations from the stationary distribution while the former cannot.

In summary, lumpability identifies necessary and sufficient conditions for a microscopic process to have emergent macroscopic processes: a microscopic process has causally/informationally closed levels if and only if its causal states are strongly lumpable. By doing this, Theorem 3 also opens the door to the discovery of emergent levels in systems of interest. In effect, this theorem also allows us to leverage the rich literature of numerical methods that has been developed to empirically discovering lumpable partitions of a Markov chain. Thanks to this link, those methods can be readily used to empowering data-driven discovery of emergent coarse-grainings — with the trick of applying them not in ‘real space’ but on the space of causal states. Algorithms for finding lumpable partitions are discussed in Section A.7.

### III.5 The hierarchy of emergent computational levels

The findings discussed above have a number of important consequences. First, the collection of all causally closed coarse-grainings can be shown to be hierarchically organised as a lattice — more precisely, they form a sub-lattice of the lattice of all coarse-grainings. Moreover, the fact that for spatial coarse-grainings information closure implies computational closure (discussed in the previous subsection) means that the collection of $\epsilon$ -machines of all informationally closed spatial coarse-grainings are also hierarchically organised in *another lattice*: a lattice of strongly-lumpable coarse-grainings of $\epsilon$ -machines, whose finest element is the $\epsilon$ -machine of the micro level and its coarsest is an $\epsilon$ -machine with a single state.

Figure 6: The multiple hiearchies describing multi-level computations in a complex system. Left: Lattice of all possible coarse-grainings, here illustrated for the case of a process that can take five possible values. Center: Sub-lattice of only those coarse-grainings that are causally/informationally closed. Right: Lattice of strongly-lumpable coarse-grainings of the $\epsilon$ -machine of the microscopic level. Only the last lattice provides a minimal blueprint that highlights the distinct computational processes, and distinguishes which computations take place at what level.

This sequence of three compatible hierarchies is important, as the mapping from one lattice to the next provide a more refined and simpler view of the multi-level structure of the system of interest (see Figure 6). Indeed, the lattice of all coarse-grainings grows super-exponentially with the number of values a process can take, and focusing only on causally closed processes provides a first important simplification. Furthermore, the mapping from the lattice of all causally-closed processes is found to be sometimes many-to-one, as different coarse-grainings may have an equivalent $\epsilon$ -machine. This ‘degeneration’ of the mapping gives rise to the notion of *computational equivalence* (Definition 6), which correspond to coarse-grainings that map into the same $\epsilon$ -machines and hence are effectively carrying out the same computations, even if they look different.

Let us further explore the benefits of focusing on the hierarchy of strongly lumpable coarse-grainings of the $\epsilon$ -machine instead of the hierarchy of causally closed coarse-grainings. Causal/information closure can take place in processes that are not causally-driven; for example, if $X_{t}=(Y_{t},W_{t})$ with $W_{t}$ being just noise (i.e., an i.i.d. process), then $g(X_{t})=W_{t}$ satisfies causal/informational closure while having no real causal structure. Our approach identifies such coarse-graining as being computationally trivial, being mapped to the top of the lattice of $\epsilon$ -machines and hence being computationally equivalent to the constant coarse-graining (i.e. the mapping $g(\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t})=1$ for all trajectories $\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t}$, whose $\epsilon$ -machine has a single causal state). More generally, the lattice of causally closed coarse-grainings fails to recognise levels that are computationally equivalent. For example, if $X_{t}=(U_{t},V_{t})$ with $U_{t}$ and $V_{t}$ being two copies of the same process (i.e. $U_{t}=\phi(V_{t})$ with $\phi$ a bijection), then both $g_{1}(X_{t})=U_{t}$ and $g_{2}(X_{t})=V_{t}$ may be regarded as two distinct emergent levels — while they should be considered to be copies of the same process.

The above examples illustrate how an analysis based solely on causal/informational closure can potentially overestimate the effective number of different emergent macro-scales that a system of interest may have. Indeed, it is the hierarchy of strongly lumpable coarse-grainings of the $\epsilon$ -machines, and not the other ones, what determines what computations are taking place where by revealing which levels are running which software. For this reason, we propose *to regard the hierarchy of strongly lumpable coarse-grainings of the $\epsilon$ -machine provide as the natural blueprint of the functional architecture of a complex system*.

Let us illustrate the power of the hierarchy of $\epsilon$ -machines as a guiding blueprint in a simple analysis. For this, let’s consider a microscopic process $\bm{X}$, a causally closed macroscopic process $\bm{Z}$, and the trivial constant coarse-graining $\bm{1}$ (which assigns the number 1 to all possible states of the micro process). These three processes form a totally ordered set in ‘real space’ with $\bm{X}$ below, $\bm{1}$ above, and $\bm{Z}$ between (indeed, $\bm{1}$ is always a — rather trivial — coarse-graining of $\bm{Z}$ too). How does the resulting hiearchy of $\epsilon$ -machines of these processes look like? Despite of the specific properties of $\bm{X}$ and $\bm{Z}$, an analysis based on the $\epsilon$ -machines reveals that the computations done by $\bm{Z}$ can be described as falling into one of four possible scenarios (see Figure 7):

- Non-trivial computation different from microscale: the $\epsilon$ -machine of $Z_{t}$ is non-trivial (i.e. different from the $\epsilon$ -machine of $\bm{1}$), and also different from the one of $X_{t}$.
- Non-trivial computation equivalent to microscale: the $\epsilon$ -machine of $Z_{t}$ is non-trivial, but is equal to the one of $X_{t}$.
- Trivial computation different from microscale: $\epsilon$ -machine of $Z_{t}$ is trivial and different from the one of $X_{t}$.
- Trivial computation equivalent to microscale: $X_{t}$ is i.i.d., so there are no actual computations taking place in it or any of its coarse-grainings.

Please note that while the lattice of coarse-grainings in ‘real space’ is always the same, the lattice of the corresponding $\epsilon$ -machines clearly illuminates the character of the computations being done.

Figure 7: Possible computational architectures of an emergent macroscopic level. Our theory shows that the computations carried out by a causally closed process $\bm{Z}$ with respect to a microscopic process $\bm{X}$ and the trivial coarse-graining $\bm{1}$ can be categorised within four groups, illustrated here. The computations are the same as the ones at the microscale if the $\epsilon$ -machine of $\bm{X}$ and $\bm{Z}$ are equivalent (as in b and d), and are trivial if the $\epsilon$ -machines of $\bm{Z}$ and $\bm{1}$ are equivalent (as in c and d). At the left of each subplot is the lattice of coarse-grainings in real space, which is the same for the four cases; at the right is the lattice of corresponding $\epsilon$ -machines in theory space, which better illustrates the effective computational structure of the system.

In summary, our theory reveals that it is the hierarchy of strongly lumpable causal states, and not the one of causally/informationally closed spatial coarse-grainings, what provides the most illuminating blueprint of the software-like processes running over a give microscopic layer at which different computations take place. By grouping together all computationally equivalent processes, the lattice of the resulting $\epsilon$ -machines is generally simpler than the other lattices, and provides a more accurate representation of the computations happening at different levels. These ideas are illustrated in a series of case studies presented in the next section.

Figure 8: Conserved quantities in elementary cellular automata. Illustration of the computations associated to different types of conserved quantities. a) Rule 60 forces configurations to have even parity. Hence, the parity is a conserved quantity which is computationally trivial, akin to case (c) in Figure 7. b) In contrast, rule 150 keeps the parity of the initial condition. Hence, while the parity is also a conserved quantity for these dynamics, the computations associated with it are non-trivial, akin to case (a) in Figure 7.

## IV Case studies

This section presents a number of examples that help to illustrate, exemplify, and develop further intuitions about our theory. The investigated systems include various paradigmatic models of complexity including cellular automata, diffusion processes, Ising models, random walks over networks, and recurrent neural networks.

### IV.1 Invariant quantities

Let us start by considering a system whose microscopic evolution is described by the time series $\bm{X}$, and has a scalar coarse-graining $Z_{t}=f(X_{t})$ such that $Z_{t}=Z_{t_{0}}$ for all $t$ — i.e., $\bm{Z}$ is constant for all values of $t$, being an invariant property of $\bm{X}$. Such invariants may, or may not, depend on initial condition. A direct calculation shows that invariants are informationally closed, as

$$
\displaystyle I(\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t};\vec{\bm{Z}}^{L}_{t+1}|\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t})
$$
 
$$
\displaystyle=H(\vec{\bm{Z}}^{L}_{t+1}|\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t})-H(\vec{\bm{Z}}^{L}_{t+1}|\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t})
$$
 
$$
\displaystyle=H(Z_{t_{0}}|Z_{t_{0}})-H(Z_{t_{0}}|\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t})
$$
 
$$
\displaystyle=0~.
$$

Invariants may be computationally trivial (i.e. computationally equivalent to a constant coarse-graining, as in classes (c) or (d) in Fig. 7) or not (i.e. classes (a) or (b)), depending on their entropy. Specifically, a Markov process has invariants that are computationally non-trivial when the state space of the Markov chain can be divided in regions such that the process can move between states within individual regions but not between states of different regions (i.e., if the Markov chain is reducible). If that is the case, the identity of each isolated group is a non-trivial invariant, and the corresponding coarse-graining looks like a Markov chain that only has self-transitions. In contrast, a computationally trivial invariant is a way of describing the part of the phase space that is not accessible. For example, if $Z_{t}=f(X_{t})=c$ is a constant coarse-graining, that means that all micro-states $X^{\prime}_{t}$ such that $f(X^{\prime}_{t})\neq c$ cannot occur.

Let us illustrate these ideas in an concrete example based on cellular automata (see Figure 8). Consider an elementary cellular automaton whose state of its $n$ binary cells at time $t$ is denoted by $X_{t}=(X_{t}^{(1)},\dots,X_{t}^{(n)})$ [^55]. Let’s focus on the so-called ‘rule 150’, whose temporal evolution is equivalent to a triple xor logic gate:

$$
X^{(k)}_{t+1}\equiv X_{t}^{(k-1)}+X_{t}^{(k)}+X_{t}^{(k+1)}\ (\mathrm{mod}\ 2)
$$

for $2\leq k\leq n-1$. For the sake of symmetry, let’s also impose circular conditions, so that $X^{(1)}_{t+1}\equiv X_{t}^{(n)}+X_{t}^{(1)}+X_{t}^{(2)}\ (\mathrm{mod}\ 2)$ and $X^{(n)}_{t+1}\equiv X_{t}^{(n-1)}+X_{t}^{(n)}+X_{t}^{(1)}\ (\mathrm{mod}\ 2)$. It can be shown (e.g. via direct numerical evaluation) that this system is stationary under the uniform distribution on the $2^{n}$ possible states. This implies that $I(X_{t};X_{t-1})=H(X_{t+1})=n$, where the first equality is a consequence of the fact that the automaton’s evolution is deterministic.

Consider now a coarse-graining that returns the parity of a given state, i.e. $Z_{t}\equiv\sum_{k=1}^{n}X_{t}^{(k)}\ (\mathrm{mod}\ 2)$. A direct calculation shows that this is a conserved quantity of the dynamics of rule 150, as

$$
\displaystyle Z_{t+1}
$$
 
$$
\displaystyle\equiv\sum_{k=1}^{n}X_{t+1}^{(k)}\ (\mathrm{mod}\ 2)
$$
 
$$
\displaystyle\equiv\sum_{k=1}^{n}3X_{t}^{(k)}\ (\mathrm{mod}\ 2)
$$
 
$$
\displaystyle\equiv\sum_{k=1}^{n}X_{t}^{(k)}\ (\mathrm{mod}\ 2)
$$
 
$$
\displaystyle\equiv Z_{t}~.
$$

Moreover, it can be seen that $H(Z_{t})=1$, as the parity of the state can be 0 or 1 with equal probability if $X$ is initialised at the uniform distribution. Therefore, while the microscopic system computes $n$ bits, $Z_{t}$ only computes one — in this case, in the form of information storage [^56]. This shows that this invariant is not trivial and also not equal to the microstate, hence corresponding to class (a) in Fig. 7.

For a contrast, let us consider another elementary cellular automata: number 60, whose rule of evolution is equivalent to a single xor

$$
X_{t+1}^{(k)}\equiv X_{t}^{(k)}+X_{t}^{(k+1)}\ (\mathrm{mod}\ 2).
$$

It can be shown that, for this case, the parity $Z_{t}\equiv\sum_{k=1}^{n}X_{t}^{(k)}\ (\mathrm{mod}\ 2)$ is always even, i.e. that $Z_{t}=0$. This makes $\bm{Z}$ an invariant whose associated computation, however, is trivial, representing class (c) in Fig. 7. This also reveals, as argued above, that certain microscopic states are not reached by the dynamics — namely, the states with odd parity (see Figure 8).

### IV.2 Ehrenfest diffusion model

Let us now study a computationally closed quantity that is not invariant. For this, let us consider the Ehrenfest model [^21], which is a popular diffusion model in statistical mechanics. This model describes the behaviour of a gas in a container made of two interconnected chambers (see Fig. 9a). The state of the $n$ molecules of the gas at time $t$ is described by a $n$ -dimensional binary vector $X_{t}=(X_{t}^{(1)},\dots,X_{t}^{(n)})$, where $X_{t}^{(k)}\in\{0,1\}$ determines in which of the two chambers the $k$ -th molecule is located. The dynamics of the gas are then established as follows:

- At each timepoint, one of the $n$ molecules is chosen randomly with equal probability.
- With probability $q$, move the chosen particle to the other chamber. Otherwise, leave the molecule in its current chamber.

The system has two parameters: the total number of particles $n$, and $q\in[0,1]$ that regulates how easy is for molecules to move between the two chambers. Hence, if there are $z\in\{0,\dots,n\}$ particles in the first chamber, there is a probability of $z/n$ of choosing one of them. Therefore, one can find that there are three possible actions: (i) move a molecule from the first to the second chamber with probability $qz/n$, (ii) move a particle from the second to the first chamber with probability $q(n-z)/n$, or (iii) leave the particles the way they are with probability $1-q$. These dynamics on $\bm{X}$ are equivalent to a random walk (i.e., a Markov chain) on the edges of an $n$ -dimensional cube, as each step involves at modifying the state along not more than one dimension.

Figure 9: Ehrenfest diffusion model. a) The model considers particles contained in two connected chambers. The microscopic description of the system ($X_{t}$) is a binary vector that specifies in which container is each particle, while the macroscopic description ($Z_{t}$) is the number of particles in the left chamber. b) Illustration of the finite state machine description of the $\epsilon$ -machine corresponding to the macroscopic variable. c) One realisation of the dynamics of the macroscopic process of a system of $n=40$ particles, which naturally oscillates around $n/2$.

Let us now consider the following coarse-graining:

$$
Z_{t}=\sum_{k=1}^{n}X_{t}^{(k)}~,
$$

which tracks the number of molecules in each partition. At each timepoint, $Z_{t}$ can either increase by 1, decrease by 1, or stay the same; however, for $n\gg 1$ there is a trend for $Z_{t}$ to move towards $n/2$, which makes the model a useful testbed to study thermalisation processes [^57].

It can be shown that $\bm{Z}$ is a (time-homogeneous) Markov chain [^21], which implies that only the number of particles — and not their identities — in each chamber matters for the evolution of $Z_{t}$. The finite state machine equivalent of $\bm{Z}$ is given in Figure 9b. Moreover, it can be shown [^21] that $\bm{Z}$ is a Markov chain irrespective of the initial distribution of $\bm{X}$ — i.e. that it is strongly lumpable (see Definition 7). Thanks to Proposition 4, this implies that $\bm{Z}$ is causally closed in the sense of Definition 3, and furthermore is also computationally closed thanks to Theorem 2.

The implications of these results can be contemplated from various angles. From a interventional perspective, this implies that if one wants to control the evolution of the number of particles in each chamber, one does not need to worry about the exact placement of individual particles $X_{t}$ beyond what is specified by $Z_{t}$ — that is, setting $Z_{t}$ gives all the control that is possible about future values. From the point of view of simulations, this implies that one can investigate the dynamics of $\bm{Z}$ (as shown in Fig. 9b) by direct simulation of their Markov dynamics while disregarding $\bm{X}$. This is guaranteed by the fact that, thanks to causal closure, including the full state $\bm{X}$ into the simulation adds nothing relevant to the evolution of $\bm{Z}$. Finally, from an theoretical perspective, these results imply that this system has a non-trivial macroscopic level that runs and processes information irrespective of the microscopic details in a software-like manner. Following Proposition 3, the total information processed by the system at each time-step (given by $I(\bm{X}_{t};\bm{X}_{t+1})$) can be decomposed into the portion that is processed at the macro level (given by $I(\bm{Z}_{t};\bm{Z}_{t+1})$) and the one that is not (given by $I(\bm{X}_{t};\bm{X}_{t+1})-I(\bm{Z}_{t};\bm{Z}_{t+1})$). Overall, these findings enable a deeper view on the dynamics of the Ehrenfest model, revealing specific ways in which it can be efficiently predicted and controlled.

### IV.3 Ising model with Glauber dynamics

Let us now study another open system, this time including interactions between its microscopic components. Consider a collection of $n$ magnetic spins, whose state at time $t$ is described by the vector $X_{t}=(X_{t}^{(1)},\dots,X_{t}^{(n)})$, where $X_{t}^{(k)}=1$ if the $k$ -th spin is pointing up and $X_{t}^{(k)}=-1$ if it is pointing down. The energy of the system on state $X_{t}$ is determined by a Hamiltonian $\mathcal{E}(X_{t})$. Furthermore, let’s consider standard Glauber dynamics [^58] [^59] (which is closely related with the so-called kinetic Ising model [^60]) observing the following transition probability:

$$
p_{X_{t+1}|X_{t}}(x^{\prime}|x)=\begin{cases}\frac{1+\tanh{\beta\Delta\mathcal{E}}}{2n}&\text{if }x^{\prime}\in\mathcal{B}(x),\\
1-\sum_{x^{\prime}\in\mathcal{B}(x)}\frac{1+\tanh{\beta\Delta{E}}}{2n}&\text{if }x^{\prime}=x,\\
0&\text{otherwise,}\end{cases}
$$

where $\mathcal{B}(x)$ are the set of configurations that differ from $x$ in exactly one spin, and $\Delta\mathcal{E}=\mathcal{E}(x)-\mathcal{E}(x^{\prime})$ <sup>9</sup>. These statistics can be conceived as arising from the following procedure:

- While being at state $x$ at timepoint $t$, choose one of the $n$ spins randomly with equal probability. Denote by $x^{\prime}\in\mathcal{B}(x)$ the state that is equal to $x$ except with one selected spin being flipped.
- Calculate the energy difference between $x$ and $x^{\prime}$ as $\Delta\mathcal{E}=\mathcal{E}(x)-\mathcal{E}(x^{\prime})$.
- Adopt $x^{\prime}$ as state in timepoint $t+1$ with probability $p=(1+\tanh{\beta\Delta\mathcal{E}})/2$, otherwise stay in $x$.

It can be shown [^58] that those dynamics satisfies detailed balance, and gives rise to a unique stationary distribution that corresponds to the standard Boltzmann-Gibbs distribution given by

$$
\tilde{p}(x)=\frac{e^{-\beta\mathcal{E}(x)}}{\mathcal{Z}}~,
$$

with $\mathcal{Z}=\sum_{x}e^{-\beta\mathcal{E}(x)}$ being the partition function.

Let us now consider the coarse-graining $Z_{t}=\mathcal{E}(X_{t})$, which establishes the dynamics of the energy of the system. For simplicity of the analysis, let’s assume that the system is such that its Hamiltonian is invariant under spin permutations <sup>10</sup>. Using this symmetry, it is possible to show that

$$
p_{Z_{t+1}|X_{t}}(z|x)=\psi\big(z,\mathcal{E}(x)\big)~,
$$

where $\psi(z,e)$ is a function of the binary vector $z$ and the scalar $e$. This implies that the $\upsilon$ -machine of $\bm{Z}$ is equal to its $\epsilon$ -machine — i.e. that $\bm{Z}$ is causally closed. Thanks to Theorem 2, this in turn implies that $\bm{Z}$ is also computationally closed. It can be shown $\bm{Z}$ is generally not computationally equivalent to $\bm{X}$ as the $\epsilon$ -machine of $\bm{X}$ is generally richer than the one of $\bm{Z}$ (as the specific configuration $x$ often makes a difference for $p_{X_{t+1}|X_{t}}(x^{\prime}|x)$), hence belonging to class (a) in Figure 7.

Figure 10: Energy dynamics of an Ising model are causally closed. When considering the Ising model under Glauber dynamics, it can be shown that its energy is a macroscopic variable whose dynamics are causally — and hence also computationally — closed.

The fact that the Hamiltonian of an Ising model is computationally closed under Glauber dynamics implies that the dynamics of the energy does not depend on microscopic details, but only on the current energy level. This has similar implications for simulations and interventions as in the case of the Ehrenfest model: a simulation of energy dynamics in absence of its microscopic instantiation can be exact, and macroscopic interventions to drive its future evolution can exhert as much control as it is possible.

### IV.4 Random walks over modular networks

Let us now study a system that has several nested levels of causally closed dynamics. For this, consider a random walk over a weighted network with a modular structure, made by $M$ strongly connected communities of nodes that are weakly connected between each other. For simplicity, let’s assume that the links of this network are characterised by two parameters: the weight of the connections within individual modules, $r_{\text{w}}$, and the weight of the connection between different modules, $r_{\text{b}}$, with $r_{\text{w}}\gg r_{\text{b}}$. Additionally, let’s consider a random walker which moves from node to node on this network over discrete time-steps; it decides to move to another node with probability $q$, and chooses its destination with probability proportional to the strength of the link connecting them.

Let us calculate the statistics of such random walk. For this, let’s denote as $c_{x}$ the label of the community to which node $x$ belongs and $\mathcal{N}$ the set of nodes of the network. Consider $X_{t}\in\mathcal{N}$ to be the state of the random walker at time $t$, whose transition probabilities are

$$
p_{X_{t+1}|X_{t}}(x^{\prime}|x)=\begin{cases}1-q\quad&\text{if }x=x^{\prime},\\
qr_{\text{w}}/\phi(c_{x})\quad&\text{if $c_{x}=c_{x^{\prime}}$,}\\
qr_{\text{b}}/\phi(c_{x})\quad&\text{if $c_{x}\neq c_{x^{\prime}}$.}\end{cases}
$$

Above, $\phi(c_{x})=r_{\text{w}}|c_{x}|+r_{\text{b}}(n-|c_{x}|-1)$ is a normalisation term to guanrantee that the probabilities sum up to one, which depends only on the size of the current community, denoted by $|c_{x}|$. With this conditional probability, the resulting random walk will tend to roam around a given module, and will jump between modules only occasionally due to the significantly greater connectivity within than between modules.

Let us now consider the following coarse-graining: $Z_{t}=c_{X_{t}}=f(X_{t})$, where $f:\mathcal{N}\to\{1,\dots M\}$ is a function that returns the index of the module to which the given node — its argument — belongs. One can show that

$$
p_{Z_{t+1}|X_{t}}(z|x)=\begin{cases}|z|\cdot r_{\text{w}}/K\quad&\text{if $z=f(x)$,}\\
|z|\cdot r_{\text{b}}/K\quad&\text{if $z\neq f(x)$.}\\
\end{cases}
$$

where $z\in\{1,\dots,M\}$ is a community index, $|z|$ its size, and $K$ is a normalising constant. The fact that $p_{Z_{t+1}|X_{t}}(z|x)$ only depends on $f(x)$ but not on $x$ itself shows that $\bm{Z}$ is causally closed. Furthermore, thanks to Theorem 2, $\bm{Z}$ is also computationally closed. Additionally, if the probability of staying in the same node ($1-q$) is different from the one moving to another node in the same community, then $X$ and $Z$ are not computationally equivalent. Indeed, in that case $p_{X_{t+1}|X_{t}}(x^{\prime}|x)$ changes for different nodes $x$ within the same community, making the $\epsilon$ -machine of $\bm{X}$ have more states than the $\epsilon$ -machine of $\bm{Z}$ — and hence belonging in class (a) in Figure 7.

Under some circumstances, this system exhibits multiple nested levels that are causally closed. To see this, let’s consider the coarse-graining $W_{t}=h(Z_{t})$ which identifies communities of different cardinalities but does not disambiguate between communities of the same size. For example, if the network considers two communities of 10 elements and three of 20 elements, $W_{t}$ only discriminates if the random walker is located in a community with 10 elements or in one with 20. Following an argument analogous to the one made with respect to $\bm{Z}$, it can be shown that $\bm{W}$ is also causally closed: by considering the conditional probability $p_{W_{t+1}|X_{t}}(w|x)$, one can show that it depends only in $h\big(f(x)\big)$, which shows that the $\upsilon$ -machine of $\bm{W}$ is equal to its $\epsilon$ -machine and hence it is causally close. Hence, thanks to Theorem 2, $\bm{W}$ is also computationally closed.

Figure 11: Causally closed coarse-grainings of a random walk over a network. A random walk on a modular network can be coarse-grained such that the dynamics over the module’s labels is causally closed. Furthermore, by considering equivalence classes of modules given by their size provides a further causally closed macroscopic process.

This analysis shows that the computations involved in this random walk can be construed as taking place in (at least) three nested levels: first the cardinality of the future community is determined, then the specific identity of the community is chosen, and finally the specific node within that community is decided. Crucially, Proposition 3 states that the information processed by the computations taking place at high levels is done in isolation of what happens in the lower ones. This has similar consequences as for previous examples: macroscopic dynamics can be predicted and simulated in isolation of microscopic details, and macroscopic interventions guarantee optimal macroscopic controllability.

### IV.5 Agent-based simulation

Further examples for systems with computational closure can be found in the literature of agent-based models, which provides useful tools to investigate collective human and animal behaviour [^63]. Agent-based models are usually Markov chains defined over large state-spaces, which establish the possible configurations for a collection of interacting agents. In most cases the aim of a simulation is not to identify the exact behaviour of individual agents, but rather to characterise their aggregate statistics — e.g., the number of agents in a given state. These aggregate statistics can be seen as coarse-grainings $\bm{Z}$ of the underlying agent-based model $\bm{X}$.

The literature has studied settings under which agent-based models are lumpable — i.e., conditions under which the sequence of aggregate statistics is itself a Markov chain. Examples for this line of work are studies on opinion dynamics such as the voter models [^64] [^65] or agent movement on graphs [^66]. Lumpability is a useful feature in agent-based modelling, as it implies that one can avoid running the whole model $\bm{X}$ and instead run a reduced Markov chain that gives the evolution on the coarse-graining $\bm{Z}$. Indeed, as shown in Proposition 4, in this case the coarse-graining $\bm{Z}$ is computationally closed.

To illustrate this principle, let us follow Ref. [^66] and consider an agent-based model that can be used to investigate agent mobility, e.g. to simulate the movement of refugees in conflict locations. In this model, $n$ agents randomly move on a graph with $L$ nodes, and $X_{t}=(X_{t}^{1},\dots,X_{t}^{n})$ denotes the microscopic state of the system where $X^{i}_{t}\in\{1,\dots,L\}$ denotes the location of the $i$ -th agent at timepoint $t$. At each iteration, an agent decides to leave their current vertex with some probability depending on the attributes of the current vertex. If the agent decides to leave, then it moves to a neighbouring vertex with a probability depending on the attributes of the respective location and the weight of the connecting edge. This procedure is repeated for all agents and for a predefined number of iterations. Simulating the full model has a computational cost that scales linearly with the number of agents. However, the main aim of refugee movement simulation is to identify not individual but collective behaviours — for example to determine the dynamics of the number of agents at particular locations (e.g., humanitarian camps). Hence, the goal is not to study the dynamics of so-called ‘world configuration’ $X_{t}$, but rather to infer properties of a coarse-graining $Z_{t}$ defined as the vector of the number of agents at specific locations. Mathematically, $Z_{t}=(Z^{1}_{t},\dots,Z^{L}_{t})$, where $Z^{\ell}_{t}=\sum_{i=1}^{n}|\{i:X^{i}_{t}=\ell\}|$ with $|A|$ denoting the cardinality of the set $A$.

Importantly, it has been shown that — under certain conditions — the original agent-based model $\bm{X}$ is lumpable w.r.t. this coarse-graining, i.e., that the conditional probability of the agent population vector state $Z_{t}$ depends only on the agent population $Z_{t-1}$ of the previous iteration, and not on the world state $X_{t-1}$ [^66]. Thanks for Theorem 3, it follows that the coarse-graining $\bm{Z}$ is informationally closed, and due to Theorem 2 it is also computationally closed.

As a consequence, rather than simulating the full agent-based model, it is sufficient to simulate the re-distribution of populations over vertices, i.e., to simulate $\bm{Z}$. Importantly, the computational complexity of simulating $\bm{Z}$ does not depend strongly on the number of agents $n$, but rather on the number of locations $L$, which is typically much smaller than the number of agents. This example illustrates an important aspect of computational closure: computationally closed coarse-grainings may allow exact simulations — and hence forecasting and predictions — that may be unfeasible to run otherwise.

### IV.6 Memory retrieval and attractor dynamics

To conclude, let us study a recurrent neural network architecture that models how associative memory works in the human brain <sup>11</sup>. For this, we will focus on the well-known Hopfield network model [^68] [^69] [^70], which provides a simple but foundational instantiation to the long-standing principle that memories are not stored inside individual neurons, but rather in their synapses [^71] [^72].

Following Ref. [^73], let us consider a Hopfield network of $n$ neurons, which is a system with Markovian dynamics where neurons are modeled as binary units that can be in states *on* ($X_{t}^{j}=1$) or *off* ($X_{t}^{j}=-1$). Neurons interact with each other via synapses, whereas the weight of the synapsis from the $i$ -th towards the $j$ -th neuron is denoted by $w_{i,j}$. The input potential of the $j$ -th neuron at time $t$ is then given by

$$
h_{t}^{j}=\sum_{i}w_{i,j}X_{t}^{j}~.
$$

This potential determines the update of the $j$ -th neuron as follows:

$$
\mathbb{P}\big\{X_{t+1}^{j}=1|X_{t}\big\}=g\big(h_{t}^{j}\big)~,
$$

where $X_{t}=(X_{t}^{1},\dots,X_{t}^{n})$ and $g$ is a monotonous non-linear function of $h_{t}^{j}$. A common choice is

$$
g(h)=(1+\tanh{\beta h})/2,
$$

with the inverse temperature parameter $\beta$ controlling the stochasticity of the system. In particular, $\beta\to\infty$ leads to deterministic dynamics given by $g(h)=\big(1+\text{sign}(h)\big)/2$. Furthermore, for simplicity it is assumed that the dynamics of the whole system are simply a combination of the individual dynamics, i.e.

$$
\mathbb{P}\big\{X_{t+1}=x_{t+1}|X_{t}\big\}=\prod_{j}\mathbb{P}\big\{X_{t+1}^{j}=x_{t+1}^{j}|X_{t}\big\}.
$$

How can a Hopfield network store and retrieve memory patterns? Let us denote the patterns to be stored as $p^{1},\dots,p^{m}$, with $p^{\mu}=(p_{1}^{\mu},\dots,p_{n}^{\mu})$. Then, one defines the synaptic weights as follows:

$$
w_{i,j}=\frac{1}{n}\sum_{\mu=1}^{m}p_{i}^{\mu}p_{j}^{\mu}~.
$$

Using those weights, the resulting dynamics of the Hopfield network can be shown to have the mentioned patterns as attractors. This can be seen by noting that the energy function

$$
\mathcal{E}(X_{t})=-\sum_{i}\sum_{j}w_{i,j}X_{t}^{i}X_{t}^{j}
$$

is a Lyapunov function of the deterministic dynamics ($\beta\to\infty$), and the $m$ patterns $p^{j}$ constitute its local minima (see Ref. [^73]). Please note that the number of patterns a network can retain depends on the stochasticity of the system and the desired level of reliability, and is usually much smaller than the number of neurons [^74] [^75].

Let us now consider a macroscopic description of the system that is based on the memory patterns instead of neurons. Following Ref. [^73], we consider the projection of the current neural activity on the $j$ -th memory pattern as given by the dot product between them:

$$
Z_{t}^{\mu}=\frac{1}{n}\sum_{i}p_{i}^{\mu}X_{t}^{i}~.
$$

Note that $-1\leq Z_{t}^{\mu}\leq 1$, with

- $Z_{t}^{\mu}=1$ if $X_{t}$ and $p^{\mu}$ are equal,
- $Z_{t}^{\mu}=-1$ if $X_{t}$ and $p^{\mu}$ are opposite, and
- $Z_{t}^{\mu}\approx 0$ if $X_{t}$ and $p^{\mu}$ are uncorrelated (for large $n$, which we assume here).

Finally, we define $Z_{t}=(Z_{t}^{1},\dots,Z_{t}^{m})$ as the vector of all $m$ projections at time $t$ (see Figure 12).

Figure 12: Hopfield network compute memory retrieval on a causally closed macroscopic level. The state of a Hopfield network is determined by the activity of each of the involved neurons, here represented as a square grid. Nonetheless, the similarity between the present pattern and the patterns that the network stores (denoted by $Z_{t}^{\mu}$, with $\mu\in\{1,2,3,4,5\}$ in the figure), which determines to which of the stored patterns is more similar to the current configuration. Our results show that $Z_{t}=(Z_{t}^{1},\dots,Z_{t}^{5})$ is a causally closed coarse-graining of the neural system, which critically determines the memory retrieval process.

Let us show that $\bm{Z}$ is computationally closed. For this, first we show that the neuron potential can be re-written in terms of these projections as follows:

$$
h_{t}^{j}=\sum_{i}w_{i,j}X_{t}^{j}=\frac{1}{n}\sum_{i}\sum_{\mu}p_{j}^{\mu}p_{i}^{\mu}X_{t}^{i}=\sum_{\mu}p_{j}^{\mu}Z_{t}^{\mu}.
$$

This, combined with Eqs. (16) and (18), imply that the transition probabilities $\mathbb{P}\big\{X_{t+1}=x_{t+1}|X_{t}\big\}$ depend only on $Z_{t}$, which in turns implies that $H(Z_{t+1}|X_{t})=H(Z_{t+1}|Z_{t})$ guaranteeing that $\bm{Z}$ is informationally closed. This, in turn, implies — due to Theorem 2 — that $\bm{Z}$ is computationally closed with respect to $\bm{X}$.

These results imply that Hopfield networks implement processes of memory retrieval — more specifically, the calculation of the similarity between the present and the stored patterns — at a macroscopic level, such that its processing of information takes place independently of the microscopic level of individual neurons.

## V Discussion

Understanding the nature of emergent macroscopic phenomena is a fundamental theoretical challenge, and also central for advancing in important open questions in various branches of science. In this paper we introduce a theory that investigates emergent phenomena from a computational perspective, illuminating their inner workings via core principles of theoretical computer science. Specifically, the theory introduced in this paper explains what it means for a natural system to display software-like macroscopic processes in a way that is theoretically sound and practically useful. In the sequel, we highlight various implications of the theory, while also discussing related work and outlining future research directions.

### V.1 A computational blueprint of the functional architecture of complex systems

By taking inspiration on how software works, our approach articulates a view on emergence in terms of macroscopic processes that are self-contained in causal, informational, and computational terms. Our mathematical formalism revealed a single condition (namely, the equivalence between $\epsilon$ -machines and $\upsilon$ -machines) under which macroscopic processes resulting from spatial coarse-grainings guaratee all three properties. Processes satisfying these properties possess a number of interesting features. First, due to causal closure, all interventions that drive such processes are accounted by events of the processes themselves — and, in that sense, it can be said that such a process ‘causes itself.’ Second, due to information closure, microscopic events don’t have any additional predictive power over such process that couldn’t be found in the process itself. This implies that optimal prediction of such macroscopic processes can be attained while disregarding all details about their microscopic instantiation. Finally, due to computational closure, such processes run a particular subset of the computations carried out by the whole system in an autonomous manner. As a consequence of this, such processes can be thoroughly described without relying on the full microscopic theory, but using solely a simpler, coarse-grained, self-contained version of it.

In addition of characterising the properties of emergent macroscopic processes individually, our theory also accounts for the properties of them as a group. Indeed, our formalism revealed that the collection of all emergent processes are hierarchically organised into a lattice. Furthermore, our results show that this lattice can become substantially simpler when considered not in ‘real space’ (i.e. in terms of coarse-grainings of states) but in ‘theory space’ (i.e. as nested computational machines), which only accounts for processes that are computationally distinct. Our results show how this hierarchy of nested computational machines delineates a blueprint for the functional architecture of the system, while also characterising the computations running at each level.

Overall, the theoretical framework introduced in this paper establishes a rigorous foundation to study emergent processes akin of human-designed software on natural systems. Specifically, our theory provides concrete criteria to answer under what conditions natural systems can be said to be ‘running software’, and what are the consequences of this.

### V.2 The benefits of emergent macroscopic processes

The examples investigated in Section IV provide some hints of why complex natural systems may exhibit macroscopic levels that are software-like.

First and foremost, causally closed levels can be efficiently controlled from just macroscopic interventions, without needing to intervene on microscopic conditions. For example, if one needs to control the dynamics of the number of particles in each chamber in the Ehrenfest model (see Section IV.2), or the total energy in an Ising model (see Section IV.3), one can do this to the highest possible precision by setting an initial condition that only constrains the macroscopic property in question but otherwise leaves the remaining details unspecified/random. These results have an important practical implication: these macroscopic thermodynamic quantities can be optimally controlled by the actions of macroscopic organisms, whose scope of actions is restricted to set values on macroscopic variables. This property may explain the fact that macroscopic organisms can be highly causally-effective on their environments without the need of having to intervene on microscopic variables.

Additionally, the analysis done over Hopfield networks (Section IV.6) opens the door to interesting analyses of biological process in general, and neural systems in particular. Our results show how the neural dynamics associated to a process of memory retrieval can take place at a macro level, being driven by macroscopic neural patterns while being independent of the implementation of these on the firing of individual neurons. As such, this analysis establishes an objective procedure to evaluate when a neural process is implementing a computation at a higher level, having interesting parallels with the classic distinction of levels of analysis introduced by Marr [^76]. Also, these results provide a concrete operationalisation to the notion of multiple realisability [^23] [^24], articulating how equivalent software-like process may take place over different microscopic systems (see Section II.1). However, this approach does not satisfies — at least in principle — the idea of substrate independence [^25], as the causal relationships of the microscopic process determine which macroscopic processes can take place over it, and hence some processes may only be compatible with specific types of substrates. Building on these insights, future work may investigate the applicability of such approaches to identify algorithms implemented on different biological processes — neural and beyond.

Finally, causally closed processes have interesting properties not only for the system itself, but also for the scientist that study them. As remarked in the study of agent-based modelling (Section IV.5), computationally closed levels allow the simulation of aspects of these processes in an efficient yet precise manner. Indeed, the evolution of causally closed levels can be thoroughly simulated without accounting for the microscopic details that underlie it, which can enable efficacious exact simulation procedures of processes that may be unfeasible to run otherwise.

### V.3 Related literature and future work

The theory introduced here extends the framework of *dynamical independence* proposed in Ref. [^12], from which it takes direct inspiration. Dynamical independence proposes to identify emergent macroscopic process via information closure, inheriting its strengths and weaknesses (for example, as discussed in Section III.5, noise processes may satisfy dynamical independence while having no underlying causal structure). One way to circumvent these limitations is by requiring information closure to be ‘non-trivial’, i.e. for emergent levels to actually carry some information processing [^48]. In this work we take a different approach by interpreting this limitations as symptoms of a deeper issue: that information-theoretic metrics alone are limited in the degree they can assess the mechanisms driving the data-generating process. This greatly limits the capability of these frameworks not only to determine if a macro-variable is emergent or not, but to provide a more detailed assessment of how this may be taking place. Importantly, it has been shown that statistical patterns can be qualitatively different from their data-generating mechanisms [^77]. By embracing principles of computational mechanics and the related notion of *intrinsic computation* [^78] [^79], our proposed theory takes a first step in the direction of characterising the mechanisms driving emergent processes from a computational perspective.

The framework presented here have similar motivations to recent work reported in Ref. [^34]. This approach characterises the degree of dependency between microscopic and macroscopic levels combining principles of computational mechanics with insights and formal tools from fluid dynamics and dynamical systems theory, being highly complementary with the approach and tools developed here and well-suited for analysing systems with continuous variables. Our framework also has similar motivations and aims (although relying on a radically different approach) with work reported in Ref. [^80], which introduces scalable methods to model hidden dynamics driving time series data and hence being promising in terms of its practical applicability. Future work may try to combine the complementary strengths of these approaches.

More broadly, there is an extensive literature considering efficient representations of microscopic processes, which selects macroscopic processes via a variety of criteria. Classic approaches include ‘lumpability’ techniques (see Section A.7 and Refs. [^81] [^82] [^83]) and other aggregation approaches (e.g. Ref. [^84] [^85]). An interesting angle on this problem is taken by Ref. [^86], which considers coarse-graining processes that balance predictability at the macro level with the degree of computational complexity involved in the coarse-graining mapping relating microscopic and macroscopic levels. This idea is related to a definition of emergence in terms of computational mechanics properties presented in Ref. [^20], based on the ratio between the information processed by coarse-grainings and the informational cost of their $\epsilon$ -machine (i.e. the entropy of the causal states). Including the computational complexity of the coarse-graining, and potentially linking it with thermodynamic considerations, are important avenues for future work.

The framework presented here provides a natural complement to the work presented in Ref. [^87], which describes natural computation as the dual of prediction — i.e., while prediction is a logical procedure that tell us the result of the evolution of a system without running it, computation corresponds to the act of letting a system run so that its evolution provides an answer a query. While our theory can also be interpreted in terms of relationships between ‘physical’ and ‘abstract’ processes and their predictability, our framework is oriented to highlight the role of micro-to-macro relationships, being closer in spirit to the recent literature on information-theoretic methods to quantify emergence [^8] [^9] [^13] [^10] [^11] [^12] and other theoretical work focused on the relevance of coarse-grainings [^88]. Thus, further developing the notion of ‘computation’ implied in the present framework is a relevant avenue of future work, either by working along the lines of Ref. [^87], or by further developing the framework with richer constructs from the theoretical computer science literature — for instance, by considering other machines from Choamsky’s computational hierarchy [^44] instead of focusing solely in deterministic automata.

It is important to highlight that while the present work follows a characterisation of emergence similar to the one investigated by Ref. [^12], other characterisations of emergence exist (see e.g. Refs. [^8] [^9] [^10]). An interesting direction for future work is to investigate the feasibility of operationalising other views on emergence in terms of computational mechanics. Also, in this work we conceive causality following the computational mechanics literature, following the principle of ‘differences that make a difference.’ However, the quantitative characterisation of causation is a challenging subject, with a wide literature and no agreed-upon approach for its quantification (see e.g. [^89] [^90] [^91] [^92]). Note that while some of the proposed metrics establish causation at the level of individual events, the framework introduced here identified causation of variables in terms of other variables. Extensions from variables to individual events could be attempted via point-wise information-theoretic metrics (see e.g. [^93] [^94]), being an interesting avenue for future work.

Some of our results related to causal and informational closure are related with work reported in Ref. [^95], where the authors investigated how informational closure relates to other properties, including causal closure (which they call ‘commutativity’) and Markovianity. Their results imply that informational closure is equivalent to causal closure for spatial coarse-grainings, a result we generalise to non-Markovian processes and spatio-temporal coarse graining functions in Theorem 1 <sup>12</sup>.

Finally, it is important to remark that it is not straightforward to apply the present theory to empirical data of large systems. The main limitation is the practical estimation of potentially large $\epsilon$ -machines. There is promising work in this direction [^97] [^98] [^99]), particularly exploiting the relationship between $\epsilon$ - machines and the information bottleneck [^100], and recent extensions of state-space modelling [^101]. We leave it to future work to develop suitably efficient and robust estimations procedures.

### V.4 Final remarks

Given the central position that the notion of ‘computation’ has in our modern scientific worldview, it is natural to wonder what a computational perspective can offer to our fundamental understanding of natural processes studied by physics, chemistry, and biology. While computer science provides a rigorous and fundamental theory based on the construct of Turing machines [^102], the application of these ideas to concrete scientific scenarios (e.g. in physics or neuroscience) is not always straightforward <sup>13</sup>. We hope that the theory introduced in this paper may serve as a first step towards a thorough characterisation of emergent processes in a way that advances theoretical discussions and also facilitate breakthroughs in empirical scientific questions.

## Acknowledgements

We thank Patricio Orio for helpful discussions about cellular automata, and Lionel Barnett, Sebastian Dohnany, and Clemens von Stengel for useful comments about the manuscript. F.R. was supported by the Fellowship Programme of the Institute of Cultural and Creative Industries of the University of Kent, and the DIEP visitors programme at the University of Amsterdam. The work of B.G. was funded by the European Union’s Horizon Europe research and innovation programme within the KNOWSKITE-X project, under grant agreement No. 101091534. M.G. was supported in part by the Swiss National Science Foundation under Grant 200364.

\*

## APPENDIX A THE CALCULI OF MULTI-LEVEL COMPUTATIONS

Here we present the fundamental mathematical results that are at the basis of our framework, which was informally described in Section III.

### A.1 Scenario and basic assumptions

Let us consider a dynamical process of interest whose evolution can be described by a time series — i.e., a stochastic process $X_{t}$ sampled at discrete times $t\in\mathbb{Z}$. To simplify the results presented in this paper, we adopt two assumptions. First, it is assumed that $X_{t}$ takes values on a discrete alphabet $\mathcal{X}$. Secondly, the statistics of the system of interest (which may be Markovian or non-Markovian) are assumed to be stationary — i.e. to have the same statistics for different timepoints. Extensions for non-stationary processes and/or general alphabets are possible, but will be left for future work.

As for notation, random variables are in general denoted by capital letters (e.g. $X$, $Y$) and their realisations by lower case letters (e.g. $x$, $y$). Time series are denoted by bold letters without subscript $\bm{X}=\{X_{t}\}_{t\in\mathbb{Z}}$, finite trajectories by $\vec{\bm{X}}^{L}_{t}:=(X_{t},\dots,X_{t+L})$, the infinite future as $\vec{\bm{X}}_{t}=(X_{t},X_{t+1},\dots)$, and the infinite past as $\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t}=(\dots,X_{t-1},X_{t})$. For distributions of random variables, we use the random variables as subscripts, i.e., $p_{X}(x)=\mathbb{P}(X=x)$. We drop the subscript if it is clear from the context. The Shannon entropy of a random variable $X$ is denoted by $H(X)$, and the mutual information between $X$ and $Y$ by $I(X;Y)$. Finally, we call random variables $X$ and $Y$ equivalent if and only if there is a bijection $f$ such that $X=f(Y)$ almost surely, i.e. with probability 1.

### A.2 Coarse-grainings and ϵ\\epsilon-machines

A coarse-grained description of a variable $X$ is another variable $Z$ such that a (deterministic) coarse-graining mapping $g$ exists such that $Z=g(X)$. For example, $X$ could be a Gaussian random variable and $Z$ could be 1 if $X\geq 0$ and 0 otherwise. The range of values that a coarse-grained representation can adopt is equal to or smaller than the range of the original system. Crucially, if $Z=g(X)$ then observing a change in $Z$ always implies that there was a change in $X$, but if $X$ is changed this does not imply that $Z$ will — an asymmetry known as ‘supervenience’ [^104].

Let us extend the idea of coarse-graining from variables to time series. A coarse-graining of a time series $\bm{X}$ is another time series $\bm{Z}$ such that there exists a coarse-graining mapping $g$ such that $Z_{t}=g(\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t})$ for all $t$, so that $\bm{Z}$ summarises spatio-temporal trajectories of $\bm{X}$. A coarse-grained time series $\bm{Z}$ will be described informally as being a *macroscopic process* related to a microscopic process $\bm{X}$. We denote by $\mathcal{G}_{\mathcal{X}}:=[\mathcal{X}^{*}\to\mathbb{R}]$ the set of all possible coarse-graining functions taking the past $\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t}$ as input (with $\mathcal{X}^{*}$ denoting the set of infinite strings corresponding to all possible past trajectories), and by $\mathcal{F}_{\mathcal{X}}:=[\mathcal{X}\to\mathbb{R}]$ the subset of all purely spatial (i.e. non-temporal) coarse-grainings of the form $Z_{t}=f(X_{t})$.

When considering two coarse-grainings $\bm{Z}^{(1)}$ and $\bm{Z}^{(2)}$, we use the notation $\bm{Z}^{(1)}\succeq\bm{Z}^{(2)}$ to denote when $\bm{Z}^{(1)}$ is by itself also a coarse-graining of $\bm{Z}^{(2)}$. Two coarse-grainings are equivalent if they satisfy both $\bm{Z}^{(1)}\succeq\bm{Z}^{(2)}$ and $\bm{Z}^{(2)}\succeq\bm{Z}^{(1)}$, which corresponds to cases where there exists a bijection between them. Two coarse-graining functions $g_{1},g_{2}\in\mathcal{G}_{\mathcal{X}}$ are said to be equivalent if they lead to equivalent coarse-grainings.

###### Lemma 1.

For a given process $\bm{X}$, the collection $\mathcal{G}_{\mathcal{X}}$ with $\succeq$ forms a lattice, with the infimum given by the identity mapping and supremum given by a constant mapping. The set $\mathcal{F}_{\mathcal{X}}$ constitutes a sublattice of $\mathcal{G}_{\mathcal{X}}$.

###### Proof.

Let us consider two coarse-grainings of $\bm{X}$ denoted by $\bm{Z}$ and $\bm{Z}^{\prime}$. To show that $\succeq$ induces a partial ordering, one needs to prove that if $\bm{X}\succeq\bm{Y}$ and $\bm{Y}\succeq\bm{Z}$, then $\bm{X}\succeq\bm{Z}$, which is a natural consequence of the composition of coarse-graining functions. The proof of the infimum and supremum follows from the fact that $\bm{X}\succeq\bm{Z}\succeq 0$ for all coarse-grainings $\bm{Z}$, where the supremmum $\bm{X}$ is obtained via the identity function and $0$ is a trivial coarse-graining obtained from a constant function mapped to $0$. Finally, the fact that both $\bm{X}$ and $0$ also belong to $\mathcal{F}_{\mathcal{X}}$ shows that it is a sublattice. ∎

We now introduce the idea of $\epsilon$ -machines of a macroscopic processes. For this, we build on the classic definition of $\epsilon$ -machine [^20].

###### Definition 1 (ϵ\\epsilon-machine).

The causal states of a process $\bm{X}$ are the equivalence classes corresponding to the following equivalence relationship (see Figure 1):

$$
\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t}\equiv_{\epsilon}\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t}^{\prime}\quad\text{iff}\quad p(\vec{\bm{x}}^{L}_{t+1}|\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t})=p(\vec{\bm{x}}^{L}_{t+1}|\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t}^{\prime})~\;\forall\vec{\bm{x}}^{L}_{t+1},L\in\mathbb{N}.
$$

The $\epsilon$ -machine of a process $\bm{X}$ is given by the pair $(\epsilon,T_{e,e^{\prime}}^{x})$, where $\epsilon(\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t})=E_{t}$ is the mapping that assigns their causal state to individual trajectories, and $T_{e,e^{\prime}}^{x}$ is the resulting transition probabilities of the form

$$
T_{e,e^{\prime}}^{x}=\mathbb{P}\{E_{t}=e^{\prime},X_{t}=x|E_{t-1}=e\}~.
$$

It can be shown that the causal states are the coarsest coarse-graining of past trajectories of the process that retains full predictive power over its future evolution — i.e. if the time series of causal states is denoted by $\bm{E}$, then $I(\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t};\vec{\bm{X}}^{L}_{t+1})=I(E_{t};\vec{\bm{X}}^{L}_{t+1})$ for all future horizons $L\in\mathbb{N}$ [^38] [^37]. Moreover, it can be shown that $\bm{E}$ always exhibits Markovian dynamics, irrespective of the complexity of the memory structure of $\bm{X}$. The $\epsilon$ -machine is thought to describe the computations that give rise to the observed data representing them via an automaton [^44], as it is the most parsimonious state machine whose transitions generate the actual data that is observed (see Section II.2).

By noting that the dynamics in $\bm{X}$ naturally induce dynamics on a coarse-graining $\bm{Z}$, one can directly apply Definition 1 to $\bm{Z}$. Intuitively, the $\epsilon$ -machine of a coarse-graining $\bm{Z}$ is an optimal representation of past trajectories at that level of resolution (i.e. trajectories of $\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{z}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{z}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t}$ instead of $\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t}$), which are grouped according to their forecasting abilities into causal states $\bm{E}^{\prime}$. Note that the causal states of $\bm{Z}$ are also Markovian and informationally optimal at a macroscopic level, i.e. they satisfy $I(\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t};\vec{\bm{Z}}^{L}_{t+1})=I(E^{\prime}_{t};\vec{\bm{Z}}^{L}_{t+1})$ for all $L\in\mathbb{N}$.

Let us think how the different machines relate to each other. If $\bm{X}$ represents a fully observed (physical) process governed by a given (physical) law, then the $\epsilon$ -machine of $\bm{X}$ represents the computations taking place at this most resolved level — representing ‘the laws’ governing the system. Similarly, the $\epsilon$ -machine of $\bm{Z}$ is the best possible reconstruction of the computations that take place at scale of resolution. Critically, such reconstruction may be losing relevant information about the underlying laws, i.e. about the $\epsilon$ -machine of $\bm{X}$. It is natural to wonder how the collection of $\epsilon$ -machines of all coarse-grainings of a given process $\bm{X}$ are related. Unfortunately, in general the members of such collection do not — to the best of our knowledge — relate to each other in a simple manner. For example, the $\epsilon$ -machine of a coarse-graining of $\bm{X}$ may not be a coarse-graining of the $\epsilon$ -machine of $\bm{X}$, as shown in the next example.

###### Counterexample 1 (Incompatibility between ϵ\\epsilon-machines at different levels).

Consider a Markov chain $\bm{X}$ with three states $a$, $b$, and $c$. Let us assume that the vectors of outgoing transition probabilities of $a$ and $b$ are positive and identical. Then, the $\epsilon$ -machine $\bm{E}$ has only two causal states, namely, $\{a,b\}$ and $c$.

Now assume that there is no transition from $c$ to $b$, and that the transitions from $b$ to $a$ and from $c$ to $a$ have different probabilities. Suppose the coarse-graining $Z_{t}=f(X_{t})$ is such that $Z_{t}=A$ if $X_{t}=a$ and $Z_{t}=B$ otherwise. It can be shown that $\bm{Z}$ is not Markov. Indeed, the longer $\bm{Z}$ remains in state $B$, the higher the probability that $X_{t}=c$ (as there are no transitions from $c$ to $b$). Thus, since the transition probabilities into $a$ are different for $b$ and $c$, the $\epsilon$ -machine $\bm{E}^{\prime}$ of $\bm{Z}$ has causal states $\{A,(BA),(BBA),(BBBA),\dots\}$. Since evidently $\bm{E}^{\prime}$ has more than two causal states, it cannot be a coarse-graining of the $\epsilon$ -machine $\bm{E}$ of $\bm{X}$.

### A.3 υ\\upsilon-machines

We now introduce a new class of machines associated with coarse-grainings, which we call $\upsilon$ -machines — which are illustrated in Figure 3.

###### Definition 2 (υ\\upsilon-machine).

The causal states of the process $\bm{X}$ with respect to its coarse-graining $\bm{Z}$ are the collection of equivalence classes given by

$$
\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t}\equiv_{\upsilon}\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t}^{\prime}\quad\text{iff}\quad p(\vec{\bm{z}}_{t+1}^{L}|\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t})=p(\vec{\bm{z}}_{t+1}^{L}|\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t}^{\prime})~\;\forall\vec{\bm{z}}_{t+1},L\in\mathbb{N}.
$$

The $\upsilon$ -machine of the coarse-graining $\bm{Z}$ is then given by the pair $(\upsilon,T_{e,e^{\prime}}^{x})$, where $\upsilon(\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t})=U_{t}$ is the mapping that assigns the causal state with respect to $\bm{Z}$ to individual trajectories $\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t}$, and $T_{u,u^{\prime}}^{z}$ is the resulting transition probabilities of the form

$$
T_{u,u^{\prime}}^{z}=\mathbb{P}\{U_{t}=u^{\prime},Z_{t}=z|U_{t-1}=u\}~.
$$

Unlike the $\epsilon$ -machine of $\bm{X}$ that predicts the whole (detailed) future $\vec{\bm{X}}_{t+1}$, the $\upsilon$ -machine of a coarse-graining $\bm{Z}$ is made of the collection of causal states of the microscopic process $\bm{X}$ that are needed to optimally predict only its coarse-graining $\vec{\bm{Z}}_{t+1}$. Building on this intuition, we now show that the causal states of the $\upsilon$ -machine correspond to the coarsest coarse-graining of $\bm{X}$ that is maximally predictive of $\bm{Z}$ (which provides an alternative characterisation of them).

###### Proposition 1.

Consider $\bm{Z}$ a coarse-graining of $\bm{X}$, and $\bm{U}$ the time series of causal states of the $\upsilon$ -machine. Then $I(U_{t};\vec{\bm{Z}}_{t+1}^{L})=I(\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t};\vec{\bm{Z}}_{t+1}^{L})$ for all $L\in\mathbb{N}$. Moreover, if $\bm{D}$ is another coarse-graining of $\bm{X}$ such that $I(D_{t};\vec{\bm{Z}}_{t+1}^{L})=I(\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t};\vec{\bm{Z}}_{t+1}^{L})$ for all $L\in\mathbb{N}$, then the $\upsilon$ -machine of $\bm{Z}$ is a coarse-graining of $\bm{D}$.

###### Proof.

The first assertion follows directly from the definition of the $\upsilon$ -machine. Namely, observe that

$$
I(\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t};\vec{\bm{Z}}_{t+1}^{L})=\sum_{\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t}}p(\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t})D\Big(p(\vec{\bm{z}}^{L}_{t+1}|\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t})\big|\big|p(\vec{\bm{z}}^{L}_{t+1})\Big).
$$

Noting that $p(\vec{\bm{z}}^{L}_{t+1}|\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t})$ only depends on which equivalence class $u_{t}$ the sequence $\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t}$ belongs to, and by the construction of $u_{t},$ we can equivalently write

$$
I(\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t};\vec{\bm{Z}}_{t+1}^{L})=\sum_{u_{t}}p(u_{t})D\Big(p(\vec{\bm{z}}^{L}_{t+1}|u_{t})\big|\big|p(\vec{\bm{z}}^{L}_{t+1})\Big),
$$

and the latter is precisely equal to $I(U_{t};\vec{\bm{Z}}_{t+1}^{L}).$

For the second assertion, let us consider $\bm{D}$ a coarse-graining of $\bm{X}$, and express the mutual information between $\bm{D}$ and $\bm{Z}$ in terms of Kullback-Leibler divergences as follows:

$$
I(D_{t};\vec{\bm{Z}}^{L}_{t+1})=\sum_{d_{t}}p(d_{t})D\Big(p(\vec{\bm{z}}^{L}_{t+1}|d_{t})\big|\big|p(\vec{\bm{z}}^{L}_{t+1})\Big).
$$

Our strategy will be to investigate under which conditions this expression is smaller than $I(\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t};\vec{\bm{Z}}^{L}_{t+1})$.

Let’s first consider what happens if $D_{t}$ only lumps together trajectories of $\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t}$ that have the same conditional probabilities $p(\vec{\bm{z}}^{L}_{t+1}|\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t})$. Then, $I(D_{t};\vec{\bm{Z}}^{L}_{t+1})=I(\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t};\vec{\bm{Z}}^{L}_{t+1})$, as each Kullback-Leibler term in the summation stays the same, and the probabilities $p(d_{t})$ just group together probabilities of the corresponding trajectories. Said differently, lumping together terms with similar conditionals results on a rearranging of the summation terms and their weights, but nothing more.

Let’s now consider what happens if $D_{t}$ lumps at least two trajectories with different conditional probabilities $p(\vec{\bm{z}}^{L}_{t+1}|\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t})$, and show that in this scenario the mutual information will necessarily drop. For this, let’s assume that $D_{t}=d_{0}$ is lumping together trajectories $\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t}$ and $\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t}^{\prime}$ that have different conditional probabilities. Then, first notice that

$$
\displaystyle p(d_{t})p(\vec{\bm{z}}^{L}_{t+1}|d_{t})
$$
 
$$
\displaystyle=p(d_{t},\vec{\bm{z}}^{L}_{t+1})
$$
 
$$
\displaystyle=p(\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t},\vec{\bm{z}}^{L}_{t+1})+p(\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t}^{\prime},\vec{\bm{z}}^{L}_{t+1})
$$
 
$$
\displaystyle=p(\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t})p(\vec{\bm{z}}^{L}_{t+1}|\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t})+p(\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t}^{\prime})p(\vec{\bm{z}}^{L}_{t+1}|\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t}^{\prime})
$$

and then

$$
p(\vec{\bm{z}}^{L}_{t+1}|d_{t})=r\cdot p(\vec{\bm{z}}^{L}_{t+1}|\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t})+s\cdot p(\vec{\bm{z}}^{L}_{t+1}|\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t}^{\prime}),
$$

where $r+s=1$ is an affine combination. Using then the fact that the KL is strictly convex, i.e. that if $q_{1}$ and $q_{2}$ are different then

$$
D(r\cdot q_{1}+s\cdot q_{2}||p)<r\cdot D(q_{1}||p)+s\cdot D(q_{2}||p),
$$

one can show that the mutual information with such coarse-graining cannot be maximal, i.e. that some information must be lost.

This shows that any maximally informative coarse-graining can only lump trajectories that have the same conditionals. And the coarsest one is the one that lumps them all, which is by definition the $\upsilon$ -machine. Therefore, any coarse-graining that is maximally informative will be compatible with the $\upsilon$ -machine, but may be less coarse. ∎

It is natural to wonder how the $\upsilon$ -machine and $\epsilon$ -machine of a coarse-graining are related to each other. Our next result shows that the $\upsilon$ -machine of $\bm{Z}$ is always more information-powerful than the $\epsilon$ -machine of $\bm{Z}$. Intuitively, this is a consequence of the fact that the former can rely on information that is in $\bm{X}$ but may not be accessible in $\bm{Z}$.

###### Lemma 2.

Consider $\bm{Z}$ to be a coarse-graining of $\bm{X}$, and denote by $\bm{U}$ and $\bm{E}^{\prime}$ the time series of the causal states of its $\upsilon$ -machine and $\epsilon$ -machine, respectively. Then, the following relationship is satisfied for all future horizons $L\in\mathbb{N}$:

$$
\displaystyle I(U_{t};\vec{\bm{Z}}^{L}_{t+1})\geq I(E^{\prime}_{t};\vec{\bm{Z}}^{L}_{t+1}).
$$

###### Proof.

By the definition of $\epsilon$ -machines, we must have $I(E^{\prime}_{t};\vec{\bm{Z}}^{L}_{t+1})=I(\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t};\vec{\bm{Z}}^{L}_{t+1})$, while by the definition of $\upsilon$ -machines, we have $I(U_{t};\vec{\bm{Z}}^{L}_{t+1})=I(\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t};\vec{\bm{Z}}^{L}_{t+1})$. The lemma is then proven by a simple application of the data processing inequality, which states that since $\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t}$ is a function (a coarse-graining) of $\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t},$ we must have $I(\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t};\vec{\bm{Z}}^{L}_{t+1})\leq I(\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t};\vec{\bm{Z}}^{L}_{t+1}).$ ∎

This lemma could perhaps give the impression that the causal states of the $\epsilon$ -machine of $\bm{Z}$ may simply be a coarse-graining of the causal states of its $\upsilon$ -machine. Unfortunately, this is not the case — rather, these machines can be related in highly non-trivial ways, as illustrated by our next example.

###### Counterexample 2 (Incompatibility between υ\\upsilon-machine and ϵ\\epsilon-machine of a macroscopic process).

We reconsider the Markov chain $\bm{X}$ and its coarse-graining from Counterexample 1. Recall that the time series of causal states of $\bm{X}$, $\bm{E}$, alternate between two causal states states, $\{a,b\}$ and $\{c\}$. As we will show later in Proposition 2, since the coarse-graining mapping $f$ that defines $\bm{Z}$ is spatial, the causal states of the $\upsilon$ -machine $\bm{U}$ of $\bm{Z}$ is a coarse-graining of $\bm{E}$; hence, it can have at most two causal states. Recall further that the time series of causal states of the $\epsilon$ -machine of $\bm{Z}$, $\bm{E}^{\prime}$, has causal states states $\{A,(BA),(BBA),(BBBA),\dots\}$. Since evidently $\bm{E}^{\prime}$ has more than two causal states (i.e., more states than $\bm{U}$ has), there cannot be a mapping $f\in\mathcal{F}_{\mathcal{E}}$ such that $E^{\prime}_{t}=f(U_{t})$.

### A.4 Information and causal closure

The $\upsilon$ -machine of a coarse-graining $\bm{Z}$ captures the hidden states whose computations drive its evolution as seen from $\bm{X}$, while the $\epsilon$ -machine of $\bm{Z}$ is the best effort to capture such states using only information from that scale of resolution (see Figure 3). Hence, if the $\epsilon$ -machine of a macroscopic process is as powerful as its $\upsilon$ -machine (concretely, if there exists a bijection between the causal states of both, $E^{\prime}_{t}$ and $U_{t}$), then one can say that all the relevant causal relationships take place at that macroscopic scale. This principle sets the basis for defining macroscopic processes that are *causally closed*.

###### Definition 3 (Causal closure).

A coarse-graining $\bm{Z}$ is said to be *causally closed* if the coarse-grainings induced by its $\epsilon$ -machine and $\upsilon$ -machine are equivalent.

Let us illustrate how coarse-grainings can be causally closed in a minimal example.

###### Example 1.

Consider a stationary Markov chain $\bm{X}$ that can take one of three values $\mathcal{X}=\{a,b,c\}$. This system is fully described by a $3\times 3$ transition probability matrix that gives the probabilities $p(x^{\prime}|x):=\mathbb{P}\{X_{t+1}=x^{\prime}|X_{t}=x\}$ for $x,x^{\prime}\in\mathcal{X}$, which has 6 degrees of freedom (as there are three conditional probabilities that sum up to 1). Let us consider a generic coarse-graining of such system given by $Z_{t}=g(X_{t})$, with the mapping $g$ defined by

$$
g(x)=\begin{cases}0&\text{if }x\in\{a,b\},\\
1&\text{if }x=c.\end{cases}
$$

To investigate under what conditions is $Z_{t}$ causally closed, let’s build the $\upsilon$ -machine for predicting $Z_{t+1}$ in terms of $X_{t}$. For this, first note that

$$
\displaystyle\mathbb{P}\{Z_{t+1}=0|X_{t}=x\}=
$$
 
$$
\displaystyle\,p(a|x)+p(b|x),
$$
$$
\displaystyle\mathbb{P}\{Z_{t+1}=1|X_{t}=x\}=
$$
 
$$
\displaystyle\,p(c|x).
$$

From here one can realise that the $\epsilon$ -machine and $\upsilon$ -machine of $\bm{Z}$ are equivalent if the $\upsilon$ -machine is unable to distinguish the states that are merged by the coarse-graining, i.e. we need $\mathbb{P}\{Z_{t+1}=r|X_{t}=a\}=\mathbb{P}\{Z_{t+1}=r|X_{t}=b\}$ for $r\in\{0,1\}$. Furthermore, by noticing that $\mathbb{P}\{Z_{t+1}=1|X_{t}=v\}=1-\mathbb{P}\{Z_{t+1}=0|X_{t}=v\}$, this leads to a single condition: $p(c|a)=p(c|b)$.

Let us add one further definition of a similar but seemingly weaker condition.

###### Definition 4 (Information closure).

A coarse-graining $\bm{Z}$ of $\bm{X}$ is said to be informationally closed if it satisfies $I(\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t};\vec{\bm{Z}}^{L}_{t+1}|\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t})=0$ for all $L\in\mathbb{N}$.

An informationally closed coarse-graining is such that knowing the corresponding micro-state does not provide additional information about its future evolution over what can be obtained from the past of the coarse-graining itself. More technically, this condition corresponds to the following Markov chain: $\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t}-\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t}-\vec{\bm{Z}}_{t+1}$, where knowing $\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t}$ makes $\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t}$ and $\vec{\bm{Z}}_{t+1}$ conditionally independent. This condition makes $\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t}$ to be a sufficient statistic of $\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t}$ for predicting $\vec{\bm{Z}}_{t+1}$. Information closure of coarse-grainings have been studied by Refs. [^49] [^12].

While one could intuitively think that informational closure would be a weaker notion than computational closure, our next result shows that both are, in fact, equivalent.

###### Theorem 1.

Let $\bm{Z}$ be a coarse-graining of $\bm{X}$. Then, the following conditions are equivalent:

- $\bm{Z}$ is causally closed.
- $\bm{Z}$ is informationally closed.
- The causal states of its $\upsilon$ -machine and $\epsilon$ -machine of $\bm{Z}$, denoted by $\bm{U}$ and $\bm{E}^{\prime}$, satisfy $I(U_{t};\vec{\bm{Z}}^{L}_{t+1})=I(E^{\prime}_{t};\vec{\bm{Z}}^{L}_{t+1})$ for all $L\in\mathbb{N}$.

###### Proof.

Let us first prove the equivalence between (ii) and (iii). This follows directly from the following calculation:

$$
\displaystyle I(\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t};\vec{\bm{Z}}^{L}_{t+1}|\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t})
$$
 
$$
\displaystyle=I(\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t},\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t};\vec{\bm{Z}}^{L}_{t+1})-I(\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t};\vec{\bm{Z}}^{L}_{t+1})
$$
 
$$
\displaystyle=I(\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t};\vec{\bm{Z}}^{L}_{t+1})-I(\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t};\vec{\bm{Z}}^{L}_{t+1})
$$
 
$$
\displaystyle=I(U_{t};\vec{\bm{Z}}^{L}_{t+1})-I(E^{\prime}_{t};\vec{\bm{Z}}^{L}_{t+1})~.
$$

Above, the first equality uses the chain rule for mutual information (see e.g. [^105]) which states that $I(W,V;U)=I(V;U)+I(W;U|V)$ for any random variables $(U,V,W)$, the second the fact that $\bm{Z}$ is a coarse-graining (i.e. a deterministic function) of $\bm{X}$, and the third the properties of $\epsilon$ - and $\upsilon$ -machines.

Now, let’s prove the equivalence between (i) and (iii). If $\bm{Z}$ is causally closed then there exists a bijection between $E^{\prime}_{t}$ and $U_{t}$, and hence $I(U_{t};\vec{\bm{Z}}^{L}_{t+1})=I(E^{\prime}_{t};\vec{\bm{Z}}^{L}_{t+1})$ follows directly. To prove the converse, note that $\bm{E}^{\prime}$ is a coarse-graining of $\bm{X}$, since the causal states of a coarse-graining is a coarse-graining of the original process. Now note that $I(U_{t};\vec{\bm{Z}}^{L}_{t+1})=I(E^{\prime}_{t};\vec{\bm{Z}}^{L}_{t+1})$ implies that $E^{\prime}_{t}$ is maximally predictive of $\bm{Z}$. Due to Proposition 1, this implies that $U_{t}=f(E^{\prime}_{t})$. This, however, implies that $\bm{U}$ is also a coarse-graining of $\bm{Z}$. This, combined with the minimality of $E^{\prime}_{t}$ with respect to $\bm{Z}$ (i.e. that it is the coarses coarse-graining of $\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t}$ that still attains optimal prediction), implies that the mapping $f$ is a bijection. ∎

Note that Lemma 2 shows that $\upsilon$ -machines are generally more powerful than the corresponding $\epsilon$ -machines; the present result states that informational and causal closure are characterised by the fact of them being equally powerful.

### A.5 The lattice of spatial υ\\upsilon-machines

While the results presented in previous sections introduce useful relationships between $\upsilon$ -machines and $\epsilon$ -machines of coarse-grainings, the relationship between them and the $\epsilon$ -machine of the process itself remains unclear. Unfortunately, no general simple relationship exists between the $\epsilon$ -machine of $\bm{X}$ and $\upsilon$ -machines of coarse-grainings for general (spatio-temporal) coarse-grainings, as shown in the following example — which illustrates how spatio-temporal coarse-grainings can induce substantial changes into the causal organisation of the process.

###### Counterexample 3 (Incompatibility between υ\\upsilon-machine and ϵ\\epsilon-machine of the micro).

Let $\bm{X}$ be i.i.d., from which follows that the $\epsilon$ -machine $\bm{E}$ is trivial. Let’s focus on the following coarse-graining $Z_{t}=g(\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t})=X_{t-1}$. The $\upsilon$ -machine can, by definition, access the entire past $\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t}$ to construct a causal state for $Z_{t+1}$. But since $Z_{t+1}=X_{t}$, we can set $U_{t}=X_{t}$ and obtain $H(Z_{t+1}|U_{t})=0$. Note that such $U_{t}$ is minimal, since any non-trivial coarse-graing of $X_{t}$ will loose entropy and hence ability to predict itself. However, since $\bm{E}$ is trivial, there is no function $f\in\mathcal{F}_{\mathcal{E}}$ such that $U_{t}=f(E_{t})$.

While the collection of all $\epsilon$ -machines of coarse-grainings $\bm{Z}$ often don’t have a clear structure linking them, our next result shows that the $\upsilon$ -machines arising from spatial coarse-grainings arrange naturally into a lattice.

###### Proposition 2.

Let $f\in\mathcal{F}_{\mathcal{X}}$ be a spatial coarse-graining function and let $Z_{t}=f(X_{t})$. Then, the causal states $U_{t}$ of the $\upsilon$ -machine of $\bm{Z}$, are a coarse-graining of the causal states $E_{t}$ of the $\epsilon$ -machine of $\bm{X}$. Moreover, the collection of $\upsilon$ -machines of all coarse-grainings of $\bm{X}$ form a lattice, which is homomorphic to the lattice of coarse-grainings of $\bm{X}$.

###### Proof.

Let us first show that there exists a spatial coarse-graining $f^{\prime}\in\mathcal{F}_{\mathcal{X}}$ such that $U_{t}=f^{\prime}(E_{t})$. Recall that $E_{t}$ corresponds to the equivalence class of trajectories $\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t}$ that have the same conditional distribution $p(\vec{\bm{x}}^{L}_{t+1}|e_{t})$, and that $U_{t}$ corresponds to the equivalence class of trajectories $\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t}$ that have the same conditional distribution $p(\vec{\bm{z}}^{L}_{t+1}|u_{t})$. Now, by considering a given future trajectory $\vec{\bm{z}}^{L}_{t+1}$, one sees directly that

$$
p(\vec{\bm{z}}^{L}_{t+1}|\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t})=\sum_{\vec{\bm{x}}^{L}_{t+1}\in f^{-1}(\vec{\bm{z}}_{t+1})}p\big(\vec{\bm{x}}^{L}_{t+1}|\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t}\big).
$$

Therefore, if $\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t}$ and $\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t}^{\prime}$ are two trajectories such that $p(\vec{\bm{x}}^{L}_{t+1}|\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t})=p(\vec{\bm{x}}^{L}_{t+1}|\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t}^{\prime})$ for all $\vec{\bm{x}}^{L}_{t+1}$ and $L\in\mathbb{N}$, then also $p(\vec{\bm{z}}^{L}_{t+1}|\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t})=p(\vec{\bm{z}}^{L}_{t+1}|\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{x}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{x}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t}^{\prime})$. This implies that the coarse-graining that leads to $E_{t}$ contains all distinctions made by the coarse-graining that leads to $U_{t}$, and perhaps some more — the ones needed to predict $\vec{\bm{X}}^{L}_{t+1}$ rather than just $\vec{\bm{Z}}^{L}_{t+1}$. This shows that $U_{t}$ necessarily is a coarse-graining of $E_{t}$.

From the previous argument, it is clear that the collection of all $\upsilon$ -machines of spatial coarse-grainings inherit the partial-ordering relationship of their corresponding coarse-grainings. Furthermore, it is direct to see that the $\upsilon$ -machine of the coarse-graining function $f(x)=x$ is the finest of all, and the one of $f(x)=0$ is the coarsest. This proves that the partial ordering over $\upsilon$ -machines generates a lattice, and the fact that the mapping from coarse-grainings $\bm{Z}$ to $\upsilon$ -machines may not be one-to-one makes it an homomorphism. ∎

This result formally shows that, at least for spatial coarse-grainings, the $\upsilon$ -machine corresponds to the part of the underlying $\epsilon$ -machine that plays a role in running the macroscopic process $\bm{Z}$.

### A.6 Computational closure and the structure of emerging scales

Let us now consider the notion of closure from a computational perspective. For this, let us focus on a deterministic automaton (not necessarily related to an $\epsilon$ -machine) with states in the set $\mathcal{E}$ and inputs in the alphabet $\mathcal{X}$, so that a tuple $(e_{t},x_{t+1})$ with $e_{t}\in\mathcal{E}$ and $x_{t+1}\in\mathcal{X}$ uniquely determine the next state $e_{t+1}\in\mathcal{E}$ [^44]. Then, for a given initial state $e_{0}$, an input sequence of symbols $x_{1},\dots,x_{T}$ generate a corresponding sequence of states $e_{0},e_{1},\dots,e_{T}$. Let us consider what happens if one has sequences not of symbols in $\mathcal{X}$, but from a coarse-grained alphabet $\mathcal{Z}=\{f(x):x\in\mathcal{X}\}$ established by a spatial coarse-graining mapping $z=f(x)$, $f\in\mathcal{F}_{\mathcal{X}}$. In general, the symbols in $\mathcal{Z}$ may not be sufficient to uniquely specify the transitions between states in $\mathcal{E}$, so that the states $\mathcal{E}$ do not constitute a deterministic automaton under inputs in $\mathcal{Z}$. If it does, we say that the coarse-graining is *computationally closed*. We formalise these ideas in the next definition.

###### Definition 5 (Computational closure).

For a given deterministic automaton with states in $\mathcal{E}$ and inputs in $\mathcal{X}$, the coarse-grainings of inputs $f$ and of states $f^{*}$ are said to be *computationally closed* if the resulting transitions between coarse-grained states $\mathcal{E}^{\prime}=\{E^{\prime}=f^{*}(E):E\in\mathcal{E}\}$ is also a deterministic automaton under inputs in $\mathcal{Z}=\{z=f(x):x\in\mathcal{X}\}$.

Put simply, computational closure refers to a pair of coarse-grainings $(f,f^{*})$ such that the coarse-graining of the state is ‘compatible’ with the coarse-graining of the input — in the sense that they give rise to a new discrete automaton.

The notion of computational closure can be naturally applied to macroscopic coarse-grainings, by considering how their $\epsilon$ -machines — which can be seen as a deterministic automata (see Section II.2) — relates to the $\epsilon$ -machine of the underlying microscopic process. Following Definition 5, one can say that a macroscopic process $Z_{t}=g(\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t})$ is computationally closed if the time series $\bm{E}^{\prime}$ of causal states of its $\epsilon$ -machine is computationally closed with respect to the time series of causal states $\bm{E}$ of the $\epsilon$ -machine of the microscopic process $\bm{X}$. In other words, $Z_{t}=g(\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t})$ is computationally closed if and only if there is a spatial coarse-graining $f^{*}$ such that $E^{\prime}_{t}=f^{*}(E_{t})$.

While computational closure seems to be a stronger condition than causal closure, our next example (adapted from [^95]) shows this is not the case.

###### Counterexample 4 (Computational closure does not imply information closure, adapted from ).

Consider the following time-homogeneous Markov chain $\bm{X}$ with transition probability matrix

$$
P=\left[\begin{array}[]{cc|cc}0.5&0.5&0&0\\
0&0&0.5&0.5\\
\hline\cr 0.5&0.5&0&0\\
0&0&0.5&0.5\\
\end{array}\right],
$$

where, following standard convention, the entry in row $i$ and column $j$ denotes $\mathbb{P}\{X_{t+1}=j|X_{t}=i\}$, i.e., transition probability matrices are row stochastic. The lines indicate that the coarse-graining function $f$ merges states 1 and 2 to $A$ and states 3 and 4 to $B$. If the starting distribution $p_{X_{0}}$ coincides with the uniform distribution on $\{1,2,3,4\}$, then the resulting coarse-graining $\bm{Z}$ is i.i.d. Hence, its $\epsilon$ -machine is a trivial one, and hence is a coarse-graining of the $\epsilon$ -machine of $\bm{X}$. However, this coarse-graining is not causally closed. In effect, by knowing $X_{t}$ one can perfectly predict $Z_{t+1}.$ Namely, writing out explicitly, one can find for this particular Markov chain that

$$
\displaystyle p(Z_{t+1}=A|X_{t}=x_{t})
$$
 
$$
\displaystyle=\left\{\begin{array}[]{ll}1&\mbox{if }x_{t}=1\mbox{ or }x_{t}=4,\\
0&\mbox{otherwise,}\end{array}\right.
$$

and likewise for coarse state B. Hence the $\upsilon$ -machine of $\bm{Z}$ is non-trivial. Similarly, $\bm{Z}$ is not informationally closed since

$$
\displaystyle I(\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t};Z_{t+1}|\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t})
$$
 
$$
\displaystyle=H(Z_{t+1}|\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t})-H(Z_{t+1}|\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t},\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t})
$$
 
$$
\displaystyle=H(Z_{t+1})=1.
$$

To establish this, we observe that since $\bm{Z}$ is i.i.d., we have $H(Z_{t+1}|\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t})=H(Z_{t+1})$; due to Example 4, we have $H(Z_{t+1}|\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t},\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t})=0;$ and the last equality follows since the marginal distribution of $Z_{t}$ is uniform in our example.

With all in place, we have all the pieces to put forward our next result (illustrated by Figure 6).

###### Theorem 2.

Spatial coarse-grainings that are causally closed are also computationally closed. Moreover, the set of all computationally closed coarse-grainings form a sub-lattice, which maps (possibly not one-to-one) into a lattice of coarse-grainings of $\epsilon$ -machines via an homomorphism. Furthermore, when restricted to this collection, the following diagram commutes:

where $f,f^{*}$ are coarse-graining mappings, and $\epsilon,\epsilon^{\prime}$ are operators that goes from stochastic processes to their $\epsilon$ -machine.

###### Proof.

To prove the first part of the theorem, let’s consider a causally closed macroscopic process $\bm{Z}$ which is generated by a spatial coarse-graining — i.e. $Z_{t}=f(X_{t})$. Proposition 2 guarantees that, because of coming from a spatial coarse-graining, the causal states of the $\upsilon$ -machine of $\bm{Z}$ are a coarse-graining of the causal states of $\bm{X}$. Additionally, due to the definition of causal closure, the $\epsilon$ -machine of $\bm{Z}$ is equal to its $\upsilon$ -machine. Combining these two facts one can conclude that the causal states of the $\epsilon$ -machine of $\bm{Z}$ must be a coarse-graining of the causal states of the $\epsilon$ -machine of $\bm{X}$, proving that $\bm{Z}$ is computaionally closed.

Let us prove now that all computationally closed coarse-grainings for a lattice, and that their $\epsilon$ -machines also do. All causally closed spatial coarse-grainings are a sub-lattice of $\mathcal{F}_{\mathcal{X}}$. Furthermore, as causal closure in this case implies computational closure, then the collection of all $\epsilon$ -machines of those are also sub-lattice of the set of all possible spatial coarse-grainings of the $\epsilon$ -machine of $\bm{X}$. In virtue of this, the operation of calculating the $\epsilon$ -machine of a causally closed coarse-graining, denoted by $\epsilon^{\prime}(\cdot)$, establishes a natural map between coarse-grainings of $\bm{X}$ and coarse-grainings of its $\epsilon$ -machines.

To conclude, let’s prove the conmutation between coarse-graining $f$ and calculation of causal states $\epsilon(\cdot)$. For this, let’s note that $\epsilon(\cdot)$ preserves the partial ordering relationship of coarse-grainings of $\bm{X}$ — indeed, if the coarse-graining of $\bm{X}$ $f$ is finer than $f^{\prime}$, then the $\upsilon$ -machine of $Z_{t}=f(X_{t})$ is finer than the one of $Z^{\prime}_{t}=f^{\prime}(X_{t})$. This fact, combined with the identity between $\upsilon$ -machines and $\epsilon$ -machines that holds due to causal closure, concludes the proof. ∎

We note that the requirement of focusing on spatial coarse-grainings is essential, as the implication from information closure to computational closure can be broken in the case of general spatio-temporal coarse-grainings — as illustrated by our next example.

###### Counterexample 5 (Causal closure doesn’t always imply computational closure).

Let $X_{t}$ be a Markov chain such that its causal states $E_{t}$ satisfy $E_{t}=X_{t}$. In this scenario, let’s consider the coarse-graining $Z_{t}=g(\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t})=X_{t-1}$. A direct calculation shows that

$$
\displaystyle I(\vec{\bm{Z}}^{L}_{t+1};\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t}|\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t})
$$
 
$$
\displaystyle=H(\vec{\bm{Z}}^{L}_{t+1}|\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t})-H(\vec{\bm{Z}}^{L}_{t+1}|\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t})
$$
 
$$
\displaystyle=H(\vec{\bm{X}}^{L}_{t}|\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t})-H(\vec{\bm{X}}^{L}_{t}|\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t-1})
$$
 
$$
\displaystyle=0,
$$

which implies that $Z_{t}$ is informationally closed, and hence — due to Theorem 2 — also causally closed. Note that $\bm{Z}$ is a Markov chain, and $E’_{t}=X_{t-1}$. But then $E’_{t}=E_{t-1}$, so that in general there no spatial coarse-graining mapping $E_{t}$ to $E^{\prime}_{t}$.

Let us now turn towards characterising the collections of coarse-grainings that lead to the same $\epsilon$ -machine, corresponding to the pre-images of the mapping $\phi^{\prime}$.

###### Definition 6.

Two coarse-grainings $\bm{Z}$ and $\bm{Z}^{\prime}$ are said to be computationally equivalent if their $\epsilon$ -machines are equivalent.

Let us illustrate how coarse-grainings can be computationally equivalent in a minimal example.

###### Example 2.

Let us revisit the setting of Example 1. To investigate under what conditions is $Z_{t}$ causally closed, let’s build the $\upsilon$ -machine for predicting $Z_{t+1}$ in terms of $X_{t}$. For this, first note that

$$
\displaystyle\mathbb{P}\{Z_{t+1}=0|X_{t}=x\}=
$$
 
$$
\displaystyle\,p(a|x)+p(b|x),
$$
$$
\displaystyle\mathbb{P}\{Z_{t+1}=1|X_{t}=x\}=
$$
 
$$
\displaystyle\,p(c|x).
$$

From here one can realise that the $\epsilon$ -machine and $\upsilon$ -machine of $\bm{Z}$ are equivalent if the $\upsilon$ -machine is unable to distinguish the states that are merged by the coarse-graining, i.e. we need $\mathbb{P}\{Z_{t+1}=r|X_{t}=a\}=\mathbb{P}\{Z_{t+1}=r|X_{t}=b\}$ for $r\in\{0,1\}$. Furthermore, by noticing that $\mathbb{P}\{Z_{t+1}=1|X_{t}=v\}=1-\mathbb{P}\{Z_{t+1}=0|X_{t}=v\}$, this leads to a single condition:

$$
\displaystyle p(c|a)
$$
 
$$
\displaystyle=p(c|b).
$$

Furthermore, a direct calculation shows that

$$
\displaystyle\mathbb{P}\{Z_{t+1}=r|Z_{t}=s\}
$$
 
$$
\displaystyle=\frac{\mathbb{P}\{Z_{t+1}=r,Z_{t}=s\}}{\mathbb{P}\{Z_{t}=s\}}
$$
 
$$
\displaystyle=\sum_{u\in g^{-1}(r)}\sum_{v\in g^{-1}(s)}\xi(v)p(u|v),
$$

where $\xi(v)$ are non-negative weights with $\sum_{v\in g^{-1}(s)}g(v)=1$ given by

$$
\xi(v)=\frac{\mathbb{P}\{X_{t}=v\}}{\sum_{v^{\prime}\in g^{-1}(v)}\mathbb{P}\{X_{t}=v^{\prime}\}}.
$$

This implies that

$$
\displaystyle\mathbb{P}\{Z_{t+1}=1|Z_{t}=0\}
$$
 
$$
\displaystyle=p(c|a),
$$
$$
\displaystyle\mathbb{P}\{Z_{t+1}=1|Z_{t}=1\}
$$
 
$$
\displaystyle=p(c|c).
$$

Clearly, if $p(c|a)\neq 1/2$ or $p(c|c)\neq 1/2$, then the $Z_{t}$ is not independently distributed and hence its $\epsilon$ -machine is isomorphic to itself.

From this analysis, one can see that there are two types of scenarios in where $Z_{t}$ is causally closed. One is whether $Z_{t}$ carries non-trivial computations or not (i.e. if $Z_{t}$ is i.i.d.); the other is if $Z_{t}$ carries different computations than $X_{t}$ or not (equivalence happens when $p(x|a)=p(x|b)$ for $x\in\{a,b,c\}$, which leads to the causal states of $X_{t}$ to be equal than $Z_{t}$). It is direct to confirm that the four possible combinations of these two binary possibilities give rise to the four scenarios illustrated in Figure 7.

Let us define $\Delta_{L}(\bm{X},\bm{Z})=I(\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t};\vec{\bm{X}}^{L}_{t+1})-I(\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t};\vec{\bm{Z}}^{L}_{t+1})$, which is the information that is being processed in $\bm{X}$ but not in $\bm{Z}$ within a time horizon $L$. If $\bm{Z}$ a coarse-graining of $\bm{X}$, then $\Delta_{L}(\bm{X},\bm{Z})\geq 0$ for all $L$ due to the data-processing inequality. Note, for example, that if $\bm{Z}$ is a spatial coarse-graining of $\bm{X}$ and the statistics of both are i.i.d., then they are computationally equivalent and also satisfy $\Delta_{L}(\bm{X},\bm{Z})=0$. Our next result generalises this relationship.

###### Lemma 3.

If a computationally closed spatial coarse-graining $Z_{t}=f(X_{t})$ satisfies $\Delta(\bm{X},\bm{Z})=0$, then $\bm{Z}$ and $\bm{X}$ are computationally equivalent.

###### Proof.

Note that $\Delta(\bm{X},\bm{Z})=0$ if and only if $I(E_{t};\vec{\bm{X}}_{t+1})=I(E^{\prime}_{t};\vec{\bm{Z}}_{t+1})$, where $E_{t}$ and $E^{\prime}_{t}$ are the causal states of $\bm{X}$ and $\bm{Z}$. Also, because of computational closure, there is a function $f^{*}$ such that $E^{\prime}_{t}=f^{*}(E_{t})$.

If $\bm{X}$ and $\bm{Z}$ are not computationally equivalent, then $f^{*}$ is not invertible. If that is the case, then the definition of causal states implies that there exists a trajectory $\vec{\bm{X}}^{L}_{t+1}$ such that $I(\vec{\bm{X}}^{L}_{t+1};E^{\prime}_{t})<I(\vec{\bm{X}}^{L}_{t+1};E_{t})$, as $E_{t}$ is by definition the coarsest coarse-graining that attains $I(\vec{\bm{X}}^{L}_{t+1};E_{t})=I(\vec{\bm{X}}^{L}_{t+1};\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t})$ and thus $E^{\prime}_{t}$ needs to be coarser than $E_{t}$. The data processing inequality then shows that

$$
I(\vec{\bm{Z}}^{L}_{t+1};E^{\prime}_{t})\leq I(\vec{\bm{X}}^{L}_{t+1};E^{\prime}_{t})<I(\vec{\bm{X}}^{L}_{t+1};E_{t}),
$$

proving the desired result. ∎

We conclude this section studying how sequences of coarse-grainings decompose the total information processed by the system.

###### Proposition 3.

Consider $\mathcal{Z}=\{\bm{Z}^{i}\}_{i=1}^{m}$ a sequence of computationally closed coarse grainings with $\bm{Z}^{1}=\bm{X}$ and $\bm{Z}^{m}=\bm{1}$ the constant coarse-graining. Then

$$
I(\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t};\vec{\bm{X}}_{t+1})=\sum_{i=1}^{m-1}\Delta(\bm{Z}^{k},\bm{Z}^{k+1}).
$$

###### Proof.

A direct calculation shows that

$$
\displaystyle I(\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t};\vec{\bm{X}}_{t+1})
$$
 
$$
\displaystyle=I(\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t};\vec{\bm{Z}}_{t+1}^{1},\vec{\bm{Z}}_{t+1}^{2},,\dots,\vec{\bm{Z}}_{t+1}^{m})
$$
 
$$
\displaystyle=\sum_{k=1}^{m-1}I(\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t};\vec{\bm{Z}}_{t+1}^{k}|\vec{\bm{Z}}_{t+1}^{k+2},\dots,\vec{\bm{Z}}_{t+1}^{m})
$$
 
$$
\displaystyle=\sum_{i=1}^{m-1}I(\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t};\vec{\bm{Z}}_{t+1}^{k}|\vec{\bm{Z}}_{t+1}^{k+1})~.
$$

Then, the results follows from noting that

$$
\displaystyle I(\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t};\vec{\bm{Z}}_{t+1}^{k}|\vec{\bm{Z}}_{t+1}^{k+1})
$$
 
$$
\displaystyle=I(\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t};\vec{\bm{Z}}_{t+1}^{k+1})-I(\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t};\vec{\bm{Z}}_{t+1}^{k})
$$
 
$$
\displaystyle=I(\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t}^{k+1};\vec{\bm{Z}}_{t+1}^{k+1})-I(\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t}^{k};\vec{\bm{Z}}_{t+1}^{k}),
$$

where the last equality uses the fact that each coarse-gaining is informationally closed. ∎

This result shows that a computationally closed coarse-graining $\bm{Z}$ that is not computationally equivalent to $\bm{X}$ decomposes the information processed by $\bm{X}$ into what is processed in the macro-scale (i.e. by $\bm{Z}$, quantified by $I(\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t};\vec{\bm{Z}}_{t+1}$) and what goes below (in $\bm{X}$ but not $\bm{Z}$, quantified by $\Delta(\bm{X},\bm{Z})$).

### A.7 Closure and lumpability

Figure 13: Diagram illustrating the relationships between closure and lumpability of Markov chains. Informational/causal closure imply computational closure (Theorem 2). Within the space of Markov $\bm{X}$, strong lumpability of $\bm{X}$ implies information closure (Proposition 4). The same does not hold for weak lumpability and computational closure: If $\bm{X}$ is weakly lumpable, then the same does not need to hold for $\bm{E}$ due to the minimality property of $\varepsilon$ -machines. The diagram refers to (counter)examples in the text. Indeed, Example 1 is strongly lumpable, while Counterexample 4 is weakly lumpable.

Here we explore the relationship between informational, causal, and computational closure and ‘lumpability’ — see Figure 13 for an overview of the results we will develop in this subsection. Loosely speaking, lumpability refers to Markov chains that have coarse-grainings that also exhibit Markov dynamics. Markedly, one should note that lumpability is the exception and not the rule [^106], as most coarse-graininings break the Markov property of the base system.

###### Example 3.

Let’s consider $\bm{X}$ where $X_{t}$ can take one of four possible values, denoted as $a,b,c$, and $d$. Consider the random initial condition where $X_{0}$ can take any value with equal probability, and the following Markov dynamics: if $X_{t}\in\{a,b\}$ then $X_{t+1}$ is equal to $c$ or $d$ with equal probability, and if $X_{t}\in\{c,d\}$ then $X_{t+1}$ is equal to $a$ or $b$ with equal probability. Now, consider a coarse-graining $\bm{Z}$ determined by the following coarse-graining function: $g(a)=g(b)=A$ and $g(c)=g(d)=B$. It can be seen than $\bm{Z}$ has deterministic dynamics, as $p(B|A)=p(A|B)=1$. Furthermore, one can see that there are two causal states: one of all sequences that finish with $A$, and another with all sequences that finish in $B$. Interestingly, one can check that this $\epsilon$ -machine is isomorphic to the one of $\bm{X}$, and capture the same amount of future information (1 bit). So, $\bm{Z}$ is essentially a more compact representation than $X$ of the same computational process.

Building on these ideas, let us start by introducing the formal definition of lumpability [^21] --- while acknowledging that other flavours of lumpability exist <sup>14</sup>.

###### Definition 7 (Strong and weak lumpability).

A time-homogeneous Markov chain $(W_{0},W_{1},\dots)$ is *strongly lumpable* w.r.t. a spatial coarse-graining function $f$ if for every initial distribution $p_{W_{0}}$ the resulting coarse-graining $Z_{t}=f(W_{t})$ is a Markov chain, and its transition probabilities do not depend on the choice of $p_{W_{0}}$. A time-homogeneous Markov chain is *weakly lumpable* if $\bm{Z}$ is Markov for at least one initial distribution $p_{W_{0}}$.

Evidently, if a Markov chain is strongly lumpable, then it is also weakly lumpable. A useful information-theoretic characterisation of lumpability is given as follows. Thanks to the data-processing inequality, the following relationships always hold if $\bm{X}$ is Markovian:

$$
\displaystyle H(Z_{t}|Z_{t-1})\geq H(Z_{t}|\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t-1})\geq H(Z_{t}|\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t-1})=H(Z_{t}|X_{t-1})~.
$$

As shown by the next lemma, strong lumpability is equivalent to the collapse of the two inequalities into an equality, while weak lumpability is just the collapse of the first one.

###### Lemma 4.

If $\bm{X}$ is a stationary, irreducible and aperiodic Markov chain and if $f$ is a coarse-graining function defined on the state space $\mathcal{X}$ of $\bm{X}$, then strong lumpability is equivalent to

$$
H(Z_{t+1}|Z_{t})=H(Z_{t+1}|X_{t})\quad\text{for all $t$}
$$

where $Z_{t}=f(X_{t})$. In contrast, weak lumpability is equivalent to

$$
H(Z_{t+1}|Z_{t})=H(Z_{t+1}|\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t})\quad\text{for all $t$.}
$$

###### Proof.

See Ref. [^108]. ∎

Note that this results applies to the stationary setting, i.e., in the context of Definition 7, the initial distribution $p_{X_{0}}$ must coincide with an invariant distribution (which is unique in the irreducible and aperiodic case).

This result can be understood as follows. When trying to estimate $Z_{t+1}$ from its past, one can consider this a two-step process: first one estimates $X_{t}$ from $\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t}$, and then one estimates $Z_{t+1}$ from $X_{t}$. Strong and weak lumpability are connected to these two steps. Indeed, Counterexample 4 shows that, by carefully choosing the initial distribution $p_{X_{0}}$, one can ensure that no matter the value of $Z_{t},Z_{t-1},Z_{t-2},\dots$, one always ends up with the same conditional distribution $p(X_{t}|\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t})$. Thus, knowing more of the past $\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t}$ than $Z_{t}$ does not help to obtain a better estimate of $X_{t}$. Hence, even if the conditional distribution of $Z_{t+1}$ given $X_{t}$ differs for all $X_{t}$, knowing more than just $Z_{t}$ does not allows us to make a better estimate of $Z_{t+1}$. In contrast, in strong lumpability the distribution of $Z_{t+1}$ is the same for all values of $X_{t}$ that are compatible with $Z_{t}$. Therefore, while knowing more of the past $\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t}$ than $Z_{t}$ may give us a better estimate of the current $X_{t}$, this additional knowledge cannot improve our estimate of $Z_{t+1}$.

Our first result shows that, if a microscopic process $\bm{X}$ has Markov dynamics and is strongly lumpable w.r.t. the coarse graining function $f$, then the resulting macroscopic process $Z_{t}=f(X_{t})$ is informationally closed.

###### Proposition 4.

Let $\bm{X}$ be a stationary, irreducible, and aperiodic Markov chain, and suppose that it is strongly lumpable w.r.t. the coarse graining function $f\in\mathcal{F}_{\mathcal{X}}$. Then, the process $Z_{t}=f(X_{t})$ is informationally closed. Further, if a coarse-graining $\bm{Z}$ is informationally closed and Markov, then $\bm{X}$ is strongly lumpable w.r.t. the coarse-graining function $f$.

###### Proof.

Using Lemma 4, a direct derivation shows that

$$
\displaystyle I(\vec{\bm{Z}}^{L}_{t+1};\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t}|\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t})
$$
 
$$
\displaystyle=H(\vec{\bm{Z}}^{L}_{t+1}|\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t})-H(\vec{\bm{Z}}^{L}_{t+1}|\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t},\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t})
$$
 
$$
\displaystyle\stackrel{{\scriptstyle(a)}}{{=}}H(\vec{\bm{Z}}^{L}_{t+1}|Z_{t})-H(\vec{\bm{Z}}^{L}_{t+1}|X_{t})
$$
 
$$
\displaystyle\stackrel{{\scriptstyle(b)}}{{=}}\sum_{\ell=t+1}^{t+L}\Big(H(Z_{\ell}|Z_{\ell-1})-H(Z_{\ell}|\vec{\bm{Z}}^{\ell-1}_{t+1},X_{t})\Big)
$$
 
$$
\displaystyle\stackrel{{\scriptstyle(c)}}{{\leq}}\sum_{\ell=t+1}^{t+L}\Big(H(Z_{\ell}|Z_{\ell-1})-H(Z_{\ell}|X_{\ell-1})\Big)
$$
 
$$
\displaystyle\stackrel{{\scriptstyle(d)}}{{=}}0\,.
$$

Above, $(a)$ follows because $Z_{t}=f(X_{t})$ and because both $\bm{X}$ and $\bm{Z}$ are Markov; $(b)$ from the chain rule of entropy and Markovianity of $\bm{Z}$; $(c)$ from the data processing inequality, stating that $X_{\ell-1}$ contains at least as much information about $Z_{\ell}$ as $(Z_{t+1}^{\ell-1},X_{t})$ does; and $(d)$ from stationarity and Eq. (43).

For the second part of the proof, note that information closure and Markovianity of $\bm{Z}$ imply that (46) holds for all $L$. Instantiating this for $L=1$ yields Eq. (43), which completes the proof with [^108]. ∎

Please note that the above lemma is only valid for stationary, irreducible, and aperiodic Markov chains. The reason for this is that the equivalence between strong lumpability and Eq. (43) is only guaranteed for this class of Markov chains <sup>15</sup>. Also note that if the coarse-graining function $f$ does not produce a first-order, but a higher-order Markov chain, the connection between (higher-order) lumpability and informational closure can break down — as illustrated by our next two examples.

###### Counterexample 6 (Lumpability is not implied by information closure and high-order Markovianity).

Let’s consider $\bm{X}$ where $X_{t}$ can take one of four possible values, denoted as $a,b,c$, and $d$, and a coarse-graining $\bm{Z}$ determined by the following coarse-graining function: $g(a)=g(b)=A$ and $g(c)=g(d)=B$. Suppose that $X_{0}$ is uniformly distributed and that we have fully deterministic dynamics where $a\rightarrow b\rightarrow c\rightarrow d\rightarrow a$. Then, one can check that $\bm{Z}$ becomes a deterministic Markov process with memory 2 (indeed, it can be shown that $\bm{X}$ is strongly 2-lumpable), and its $\epsilon$ -machine is given by four causal states: one for all sequences that finish with $AA$, another for $AB$, other for $BA$, and the last for $BB$. It can be shown that $\bm{Z}$ is informationally closed, although $\bm{X}$ with $f$ is not strongly (first-order) lumpable.

###### Counterexample 7 (High-order strong lumpability does not imply information closure).

Let $\bm{X}$ be the Markov process from [^108]. Specifically, let the transition probability matrix of $\bm{X}$ be given as

$$
P=\left[\begin{array}[]{cc|cc}0.6&0.4&0&0\\
0.3&0.2&0.1&0.4\\
\hline\cr 0.2&0.05&0.375&0.375\\
0.2&0.05&0.375&0.375\\
\end{array}\right].
$$

The lines indicate that the coarse graining-function $g$ merges states 1 and 2 to $A$ and states 3 and 4 to $B$. It can be shown that the resulting coarse-graining $\bm{Z}$, $Z_{t}=g(X_{t})$ is a second-order Markov chain, and that the coarse-graining is strongly 2-lumpable. A coarse graining is strongly 2-lumpable if and only if we have [^108]

$$
H(Z_{t+1}|Z_{t},X_{t-1})=H(Z_{t+1}|Z_{t},Z_{t-1})\approx 0.733.
$$

Informational closure, for a Markov chain $\bm{X}$ and a second-order Markov chain $\bm{Z}$, requires that $I(\vec{\bm{Z}}^{L}_{t+1};\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t}|\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t})=0$ for every $L$. However,

$$
\begin{aligned}
I(\vec{\bm{Z}}^{L}_{t+1};\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t}|\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t})\geq I({Z}_{t+1};\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t}|\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t})\\
=H(Z_{t+1}|Z_{t},Z_{t-1})-H(Z_{t+1}|X_{t}).
\end{aligned}
$$

A computation of the latter quantity yields $H(Z_{t+1}|X_{t})\approx 0.552$, which with (51) leads to $I(\vec{\bm{Z}}^{L}_{t+1};\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t}|\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t})\geq 0.18$, indicating that informational closure is ruled out.

Additionally, it can be shown that Markovianity of the coarse-graining $\bm{Z}$ is in general not sufficient for information closure to hold [^95]. Indeed, if the Markov chain $\bm{X}$ is only weakly (but not strongly) lumpable w.r.t. the coarse graining function $f$, then $\bm{Z}$ may be a Markov chain but may fail to be informationally closed, as illustrated in Counterexample 4 above.

We now establish a general relationship between strong lumpability and information closure on the one hand, and weak lumpabiliy and computational closure in the other. We knew from Theorem 2 that information closure is stronger than computational closure, and weak and strong lumpability provide a complementary angle to contemplate this relationship. The following result builds on Proposition 4 and the fact that while many processes $\bm{X}$ may not be Markovian, the dynamics of their $\epsilon$ -machines always are.

###### Theorem 3.

Let $\bm{E}$ be the $\epsilon$ -machine of a stationary process $\bm{X}$. Then, the following statements hold true:

1. If $\bm{Z}$ is a computationally closed coarse-graining of $\bm{X}$, then $\bm{E}$ is weakly lumpable.
2. If $\bm{E}$ is weakly lumpable w.r.t. a coarse-graining function $f\in\mathcal{F}_{\mathcal{E}}$, then $\bm{Z}=f(\bm{E})$ is a computationally closed coarse-graining of $\bm{X}$.

Now let $\bm{E}$ additionally be irreducible and aperiodic. Then:

1. If $\bm{Z}$ is an informationally closed spatial coarse-graining of $\bm{X}$, then $\bm{E}$ is strongly lumpable.
2. If $\bm{E}$ is strongly lumpable w.r.t. a coarse-graining function $f\in\mathcal{F}_{\mathcal{E}}$, then, $\bm{Z}=f(\bm{E})$ is an informationally closed coarse-graining of $\bm{X}$.

###### Proof.

We first show that $\bm{Z}=f(\bm{E})$, for an arbitrary spatial coarse-graining $f\in\mathcal{F}_{\mathcal{E}}$, is a (potentially spatio-temporal) coarse-graining of $\bm{X}$. By definition, the $\epsilon$ -machine $\bm{E}$ is a coarse-graining of $\bm{X}$, i.e., there exists an $\epsilon\in\mathcal{G}_{\mathcal{X}}$ such that $E_{t}=\epsilon(\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t})$. Further, since $Z_{t}=f(E_{t})$ for some $f\in\mathcal{F}_{\mathcal{E}}$, $\bm{Z}$ is a coarse-graining of $\bm{X}$ in the sense that $Z_{t}=f\big(\epsilon(\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t})\big)$.

To prove the first statement, note that computational closure implies that there exists a function $f\in\mathcal{F}_{\mathcal{E}}$ such that $\bm{E}^{\prime}$ (the causal states of the $\epsilon$ -machine of $\bm{Z}$) is given by $E^{\prime}_{t}=f(E_{t})$. Since, by definition, the causal states of $\epsilon$ -machines have Markovian dynamics, weak lumpability follows from this.

For the second statement, assume that $\bm{E}$ is weakly lumpable w.r.t. some coarse-graining function $f\in\mathcal{F}_{\mathcal{E}}$. As a consequence $\bm{Z}$, defined by $Z_{t}=f(E_{t})$, is Markov. The $\epsilon$ -machine of $\bm{Z}$ is therefore a spatial coarse-graining of $\bm{Z}$, i.e., $E^{\prime}_{t}=\epsilon^{\prime}(Z_{t})$ for some $\epsilon^{\prime}\in\mathcal{F}_{\mathcal{Z}}$. We hence have that $E^{\prime}_{t}=\epsilon^{\prime}(f(E_{t}))$, with $\epsilon^{\prime}\circ f\in\mathcal{F}_{\mathcal{E}}$. Hence, the causal states of the $\epsilon$ -machine of $\bm{Z}$ are a (spatial) coarse-graining of the causal states of the $\epsilon$ -machine of $\bm{X}$, which is the definition of computational closure.

For the third statement, we make use of a fact of $\epsilon$ -machines, namely that the current causal state and the future state of the process determine the future causal state, i.e.,

$$
H(E^{\prime}_{t+1}|E^{\prime}_{t},Z_{t+1})=0.
$$
$$
E^{\prime}_{t}
$$
 
$$
E_{t}
$$
 
$$
\begin{aligned}
H(E^{\prime}_{t+1}|E_{t},Z_{t+1})=H(E^{\prime}_{t+1}|E^{\prime}_{t},E_{t},Z_{t+1})\\
\leq H(E^{\prime}_{t+1}|E^{\prime}_{t},Z_{t+1})=0.
\end{aligned}
$$
$$
\begin{aligned}
H(Z_{t+1}|E^{\prime}_{t+1},E^{\prime}_{t})-H(Z_{t+1}|E^{\prime}_{t+1},E_{t})=\\
H(Z_{t+1}|E^{\prime}_{t+1},E^{\prime}_{t})-H(Z_{t+1}|E^{\prime}_{t+1},E^{\prime}_{t},E_{t})=\\
I(Z_{t+1};E_{t}|E^{\prime}_{t},E^{\prime}_{t+1})
\end{aligned}
$$

Now note that information closure implies that $I(Z_{t+1};\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t}|\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t})=0$. Hence, with the definitions of $\epsilon$ - and $\upsilon$ -machines, we get:

$$
\displaystyle 0
$$
 
$$
\displaystyle=H(Z_{t+1}|\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t})-H(Z_{t+1}|\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t})
$$
 
$$
\displaystyle=H(Z_{t+1}|E^{\prime}_{t})-H(Z_{t+1}|U_{t})
$$
 
$$
\displaystyle\stackrel{{\scriptstyle(a)}}{{=}}H(Z_{t+1}|E^{\prime}_{t})-H(Z_{t+1}|E_{t})
$$
 
$$
\displaystyle\stackrel{{\scriptstyle(b)}}{{=}}H(Z_{t+1},E^{\prime}_{t+1}|E^{\prime}_{t})-H(Z_{t+1},E^{\prime}_{t+1}|E_{t})
$$
 
$$
\displaystyle\stackrel{{\scriptstyle(c)}}{{=}}H(E^{\prime}_{t+1}|E^{\prime}_{t})-H(E^{\prime}_{t+1}|E_{t})+I(Z_{t+1};E_{t}|E^{\prime}_{t},E^{\prime}_{t+1})
$$
 
$$
\displaystyle\stackrel{{\scriptstyle(d)}}{{\geq}}H(E^{\prime}_{t+1}|E^{\prime}_{t})-H(E^{\prime}_{t+1}|E_{t})
$$
 
$$
\displaystyle\stackrel{{\scriptstyle(e)}}{{\geq}}0~,
$$

where $(a)$ follows because for spatial coarse-grainings $U_{t}$ is a function of $E_{t}$, since thus $E_{t}$ must contain all information about $Z_{t+1}$ that is necessary, and since $U_{t}$ is minimal, and where $(b)$ follows from adding (53a) and subtracting (53b), $(c)$ follows from applying the chain rule to the conditional entropies and (53c), $(d)$ from the non-negativity of the mutual information, and $(e)$ from the fact that informational closure of spatial coarse-grainings implies computational closure, and hence $H(E^{\prime}_{t+1}|E_{t})=H(E^{\prime}_{t+1}|E_{t},E^{\prime}_{t})$. This derivation proves that $H(E^{\prime}_{t+1}|E^{\prime}_{t})=H(E^{\prime}_{t+1}|E_{t})$, which is the equivalent condition for strong lumpability [^108].

We finally show that $\bm{Z}$ is informationally closed in the sense of Definition 4 if $\bm{E}$ is irreducible, aperiodic, and strongly lumpable w.r.t. some $f\in\mathcal{F}_{\mathcal{E}}$. In this setting, we have $H(Z_{t}|E_{t-1})=H(Z_{t}|Z_{t-1})$ for any $t$. Hence, for every finite $L$,

$$
\displaystyle I(\vec{\bm{Z}}^{L}_{t+1};\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t}|\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t})
$$
 
$$
\displaystyle=H(\vec{\bm{Z}}^{L}_{t+1}|\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t})-H(\vec{\bm{Z}}^{L}_{t+1}|\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t},\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t})
$$
 
$$
\displaystyle=\sum_{\ell=t+1}^{t+L}\Big(H(Z_{\ell}|\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}_{\ell-1})-H(Z_{\ell}|\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{Z}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{Z}\mkern 2.0mu$}}$}\mkern-2.0mu}_{\ell-1},\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t})\Big)
$$
 
$$
\displaystyle\stackrel{{\scriptstyle(a)}}{{\leq}}\sum_{\ell=t+1}^{t+L}\Big(H(Z_{\ell}|Z_{\ell-1})-H(Z_{\ell}|\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{\ell-1})\Big)
$$
 
$$
\displaystyle\stackrel{{\scriptstyle(b)}}{{=}}\sum_{\ell=t+1}^{t+L}\Big(H(Z_{\ell}|Z_{\ell-1})-H(Z_{\ell}|E_{\ell-1})\Big)
$$
 
$$
\displaystyle=0,
$$

where $(a)$ follows because $\bm{Z}$ is Markov, because $Z_{t}=f(\epsilon(\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t}))$ since $E_{t}=\epsilon(\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t})$ is lumpable w.r.t. $f\in\mathcal{F}_{\mathcal{E}}$, and from the fact that conditioning reduces entropy, and $(b)$ because all information of $\mathchoice{\mkern 3.0mu\reflectbox{$\displaystyle\vec{\reflectbox{$\mkern-3.0mu\displaystyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 3.0mu\reflectbox{$\textstyle\vec{\reflectbox{$\mkern-3.0mu\textstyle\bm{X}\mkern 3.0mu$}}$}\mkern-3.0mu}{\mkern 2.0mu\reflectbox{$\scriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}{\mkern 2.0mu\reflectbox{$\scriptscriptstyle\vec{\reflectbox{$\mkern-2.0mu\scriptscriptstyle\bm{X}\mkern 2.0mu$}}$}\mkern-2.0mu}_{t}$ relevant for the future of $\bm{E}$ ’s coarse-graining must be contained in $E_{t}$. The rest of the proof follows along the lines of Proposition 4. ∎

This result provides another view on the relationship between information/causal closure and computational closure, which can be seen now via the relationship between strong and weak lumpability. In particular, this result highlights information closure as a more ‘robust’ property. In effect, due to its relationship with strong lumpability, this shows that information closure is (mostly) a property of the transition probabilities between causal states and not their marginal distribution. In contrast, computational closure — as weak lumpability — depends on the marginal as much as on the transitions. This property is, hence, less robust than information closure, as small deviations from the stationary distribution may break the former but not the latter.

Additionally, this result is also important because it allows us to use numerical methods that has been developed to empirically discover lumpable partitions of a Markov chain. Indeed, Theorem 3 shows that those methods can be readily used to empower data-driven discovery of emergent coarse-grainings, requiring only mild conditions on the transitions of the corresponding $\epsilon$ -machines.

The literature of practical methods for discovering lumpable coarse grainings is extensive. For example, an algorithm that constructs the coarsest lumpable coarse-graining of a Markov chain using binary search trees has been presented in Ref. [^110], while an eigenvector-based approach is suggested by [^111] [^112]. Also, an algorithm for the certain class of successively lumpable Markov chains was developed in [^113]. Since in many practically relevant cases the measurements of $\bm{X}$ are noisy, a number of algorithms for detecting quasi-lumpable coarse-grainings (i.e., for which the lumpability condition holds approximately) have also been developed. An algorithm based on spectral theory was developed by Jacobi in [^114], while algorithms based on the information-theoretic characterization of lumpability have been proposed by [^115]. To prevent these algorithmic approaches to terminate at trivial, e.g., i.i.d. coarse-grainings, annealing procedures have been proposed [^116] <sup>16</sup>.

[^1]: M. M. Waldrop, *Complexity: The emerging science at the edge of order and chaos*. Simon and Schuster, 1993.

[^2]: H. J. Jensen, *Complexity science: the study of emergence*. Cambridge University Press, 2022.

[^3]: G. Deco, V. K. Jirsa, P. A. Robinson, M. Breakspear, and K. Friston, “The dynamic brain: from spiking neurons to neural masses and cortical fields,” *PLoS computational biology*, vol. 4, no. 8, p. e1000092, 2008.

[^4]: M. D. Fox, A. Z. Snyder, J. L. Vincent, M. Corbetta, D. C. Van Essen, and M. E. Raichle, “The human brain is intrinsically organized into dynamic, anticorrelated functional networks,” *Proceedings of the National Academy of Sciences*, vol. 102, no. 27, pp. 9673–9678, 2005.

[^5]: L. Pessoa, “The entangled brain,” *Journal of Cognitive Neuroscience*, vol. 35, no. 3, pp. 349–360, 2023.

[^6]: Z. C. Lipton, “The mythos of model interpretability: In machine learning, the concept of interpretability is both important and slippery.” *Queue*, vol. 16, no. 3, pp. 31–57, 2018.

[^7]: Y. Zhang, P. Tiňo, A. Leonardis, and K. Tang, “A survey on neural network interpretability,” *IEEE Transactions on Emerging Topics in Computational Intelligence*, vol. 5, no. 5, pp. 726–742, 2021.

[^8]: A. K. Seth, “Measuring autonomy and emergence via granger causality,” *Artificial Life*, vol. 16, no. 2, pp. 179–196, 2010.

[^9]: E. P. Hoel, L. Albantakis, and G. Tononi, “Quantifying causal emergence shows that macro can beat micro,” *Proceedings of the National Academy of Sciences*, vol. 110, no. 49, pp. 19 790–19 795, 2013.

[^10]: F. E. Rosas, P. A. Mediano, H. J. Jensen, A. K. Seth, A. B. Barrett, R. L. Carhart-Harris, and D. Bor, “Reconciling emergences: An information-theoretic approach to identify causal emergence in multivariate data,” *arXiv:2004.08220*, 2020.

[^11]: T. F. Varley and E. Hoel, “Emergence as the conversion of information: a unifying theory,” *Philosophical Transactions of the Royal Society A*, vol. 380, no. 2227, p. 20210150, 2022.

[^12]: L. Barnett and A. K. Seth, “Dynamical independence: discovering emergent macroscopic processes in complex dynamical systems,” *Physical Review E*, vol. 108, no. 1, p. 014304, 2023.

[^13]: B. Klein and E. Hoel, “The emergence of informative higher scales in complex networks,” *Complexity*, vol. 2020, 2020.

[^14]: B. Klein, E. Hoel, A. Swain, R. Griebenow, and M. Levin, “Evolution and emergence: higher order information structure in protein interactomes across the tree of life,” *Integrative Biology*, vol. 13, no. 12, pp. 283–294, 2021.

[^15]: A. I. Luppi, P. A. Mediano, F. E. Rosas, N. Holland, T. D. Fryer, J. T. O’Brien, J. B. Rowe, D. K. Menon, D. Bor, and E. A. Stamatakis, “A synergistic core for human brain evolution and cognition,” *Nature Neuroscience*, vol. 25, no. 6, pp. 771–782, 2022.

[^16]: A. I. Luppi, P. A. Mediano, F. E. Rosas, J. Allanson, J. D. Pickard, G. B. Williams, M. M. Craig, P. Finoia, A. R. Peattie, P. Coppola *et al.*, “Reduced emergent character of neural dynamics in patients with a disrupted connectome,” *Neuroimage*, vol. 269, p. 119926, 2023.

[^17]: A. M. Proca, F. E. Rosas, A. I. Luppi, D. Bor, M. Crosby, and P. A. Mediano, “Synergistic information supports modality integration and flexible learning in neural networks solving multiple tasks,” *arXiv preprint arXiv:2210.02996*, 2022.

[^18]: M. I. Sas, P. A. Mediano, F. E. Rosas, H. Leone, A. Sas, C. Lockwood, H. J. Jensen, and D. Bor, “Synch. live: Collective problem-solving through flocking motion induces higher connectedness to others,” 2024.

[^19]: M. L. Minsky, *Computation*. Prentice-Hall Englewood Cliffs, 1967.

[^20]: C. Shalizi, “Causal architecture,” *Complexity, and Self-Organization in Time Series and Cellular Automata PhD thesis (Univ Wisconsin–Madison, Madison, WI)*, 2001.

[^21]: J. G. Kemeny and J. L. Snell, *Finite Markov Chains*, 2nd ed. Springer, 1976.

[^22]: D. A. Patterson and J. L. Hennessy, “Computer organization and design: the hardware/software interface (the morgan kaufmann series in computer architecture and design),” *Paperback, Morgan Kaufmann Publishers*, 2013.

[^23]: W. Bechtel and J. Mundale, “Multiple realizability revisited: Linking cognitive and neural states,” *Philosophy of science*, vol. 66, no. 2, pp. 175–207, 1999.

[^24]: T. W. Polger and L. A. Shapiro, *The multiple realization book*. Oxford University Press, 2016.

[^25]: N. Bostrom, “Are we living in a computer simulation?” *The philosophical quarterly*, vol. 53, no. 211, pp. 243–255, 2003.

[^26]: R. W. Batterman and C. C. Rice, “Minimal model explanations,” *Philosophy of Science*, vol. 81, no. 3, pp. 349–376, 2014.

[^27]: N. Block, “The mind as the software of the brain,” *New york*, vol. 3, pp. 377–425, 1995.

[^28]: We remark that a simplistic interpretation of the brain/mind dichotomy in terms of a hardware/software distinction has most likely long outlived its usefulness [^118]. Nonetheless, a computational perspective might still usefully be applied to brains to identify emergent functional architectures.

[^29]: F. J. Varela, *Principles of biological autonomy*. North Holland, 1979.

[^30]: J. L. Chandler and G. Van de Vijver, “Emergent organizations and their dynamics,” *New York: New York Academy of Sciences*, 2000.

[^31]: H. H. Pattee, J. Raczaszek-Leonardi, and H. H. Pattee, “Cell psychology: an evolutionary approach to the symbol-matter problem,” *LAWS, LANGUAGE and LIFE: Howard Pattee’s classic papers on the physics of symbols with contemporary commentary*, pp. 165–179, 2012.

[^32]: J. P. Crutchfield, “The calculi of emergence: computation, dynamics and induction,” *Physica D: Nonlinear Phenomena*, vol. 75, no. 1-3, pp. 11–54, 1994.

[^33]: C. R. Shalizi and J. P. Crutchfield, “Computational mechanics: Pattern and prediction, structure and simplicity,” *Journal of Statistical Physics*, vol. 104, no. 3-4, pp. 817–879, 2001.

[^34]: A. T. Rupe and J. P. Crutchfield, “On principles of emergent organization,” *arXiv preprint arXiv:2311.13749*, 2023.

[^35]: M. Barbaresi, “Computational mechanics: from theory to practice,” Ph.D. dissertation, Universita di Bologna, 2017.

[^36]: J. P. Crutchfield, “The origins of computational mechanics: A brief intellectual history and several clarifications,” *arXiv preprint arXiv:1710.06832*, 2017.

[^37]: P. Grassberger, “Toward a quantitative theory of self-generated complexity,” *International Journal of Theoretical Physics*, vol. 25, no. 9, pp. 907–938, 1986.

[^38]: J. P. Crutchfield and K. Young, “Inferring statistical complexity,” *Physical Review Letters*, vol. 63, no. 2, p. 105, 1989.

[^39]: J. P. Crutchfield and D. P. Feldman, “Regularities unseen, randomness observed: Levels of entropy convergence,” *arXiv e-prints*, pp. cond–mat, 2001.

[^40]: Through the article we use uppercase letters ($X,Y$) to denote random variables and lowercase letters ($x,y$) to denote their realisations.

[^41]: J. Pearl, *Causality*. Cambridge University Press, 2009.

[^42]: S. L. Bressler and A. K. Seth, “Wiener–Granger causality: A well established methodology,” *Neuroimage*, vol. 58, no. 2, pp. 323–329, 2011.

[^43]: Y. Ephraim and N. Merhav, “Hidden markov processes,” *IEEE Transactions on information theory*, vol. 48, no. 6, pp. 1518–1569, 2002.

[^44]: J. E. Hopcroft, R. Motwani, and J. D. Ullman, “Introduction to automata theory, languages, and computation,” *Acm Sigact News*, vol. 32, no. 1, pp. 60–65, 2001.

[^45]: For an introduction to automata and their interpretation as computational systems, please see Refs. [^19] [^44].

[^46]: This equivalence between hidden Markov models and discrete automatas is not general, but only holds because the Markov dynamics of $\epsilon$ -machines have the so-called *unifilar* property: transitions between causal states (e.g. from $E_{t}$ to $E_{t+1}$) are deterministic after the next symbol (in this case $X_{t+1}$ has been emitted.

[^47]: J. Pearl and D. Mackenzie, *The Book of Why: The New Science of Cause and Effect*. Basic Books, 2018.

[^48]: N. Bertschinger, E. Olbrich, N. Ay, and J. Jost, “Information and closure in systems theory,” in *Explorations in the Complexity of Possible Life. Proceedings of the 7th German Workshop of Artificial Life*. IOS Press: Amsterdam, The Netherlands, 2006, pp. 9–21.

[^49]: A. Y. Chang, M. Biehl, Y. Yu, and R. Kanai, “Information closure theory of consciousness,” *Frontiers in Psychology*, vol. 11, p. 1504, 2020.

[^50]: To make this point precise, prediction quality is assessed in terms of expected logarithmic loss, rather than directly via prediction error probability. See for example [^119] for an in-depth discussion.

[^51]: More technically, a informationally-close macro-scale is a sufficient statistic [^120] with respect to the micro-scale to predict its own future.

[^52]: K. G. Wilson, “Problems in physics with many scales of length,” *Scientific American*, vol. 241, no. 2, pp. 158–179, 1979.

[^53]: In such interpretation, the macroscopic level is the coarse-graining $\bm{Z}$, and its $\epsilon$ -machine $E^{\prime}_{t}$ is its corresponding theory.

[^54]: Note that this implication holds only for macroscopic processes based on a spatial, but not temporal, coarse-grainings.

[^55]: A. Wuensche and M. Lesser, *Global dynamics of cellular automata: an atlas of basin of attraction fields of one-dimensional cellular automata*. Andrew Wuensche, 1992, vol. 1.

[^56]: J. T. Lizier, M. Prokopenko, and A. Y. Zomaya, “Local measures of information storage in complex distributed computation,” *Information Sciences*, vol. 208, pp. 39–54, 2012.

[^57]: N. H. Bingham, “Fluctuation theory for the ehrenfest urn,” *Advances in Applied Probability*, vol. 23, no. 3, pp. 598–611, 1991.

[^58]: R. J. Glauber, “Time-dependent statistics of the ising model,” *Journal of mathematical physics*, vol. 4, no. 2, pp. 294–307, 1963.

[^59]: D. A. Levin and Y. Peres, *Markov chains and mixing times*. American Mathematical Soc., 2017, vol. 107.

[^60]: M. Aguilera, S. A. Moosavi, and H. Shimazaki, “A unifying framework for mean-field theories of asymmetric kinetic ising systems,” *Nature communications*, vol. 12, no. 1, p. 1197, 2021.

[^61]: Please note that one could sub-sample the temporal evolution of this process (so to account for updates of $k$ spins instead of only one), and the arguments that follow still hold.

[^62]: This is the case, for example, when the systems observes a uniform and fully-connected graph of interactions $J_{i,k}$.

[^63]: A. T. Crooks and A. J. Heppenstall, “Introduction to agent-based modelling,” in *Agent-based models of geographical systems*. Springer, 2011, pp. 85–105.

[^64]: S. Banisch, *Markov Chain Aggregation for Agent-Based Models*. Cham et al.: Springer, 2016.

[^65]: R. Lamarche-Perrin, S. Banisch, and E. Olbrich, “The information bottleneck method for optimal prediction of multilevel agent-based systems,” *Adv. Complex Syst.*, vol. 19, no. 01n02, p. 1650002, 2016.

[^66]: B. C. Geiger, A. Jahani, H. Hussain, and D. Groen, “Markov aggregation for speeding up agent-based movement simulations,” in *Proc. Int. Conf. on Autonomous Agents and Multiagent Systems (AAMAS)*, London, United Kingdom, 2023, p. 1877–1885, open-access.

[^67]: For a comprehensive review on the state of the art of the neuroscience of memory, see Ref. [^121].

[^68]: S.-I. Amari, “Learning patterns and pattern sequences by self-organizing nets of threshold elements,” *IEEE Transactions on computers*, vol. 100, no. 11, pp. 1197–1206, 1972.

[^69]: W. A. Little, “The existence of persistent states in the brain,” *Mathematical biosciences*, vol. 19, no. 1-2, pp. 101–120, 1974.

[^70]: J. J. Hopfield, “Neural networks and physical systems with emergent collective computational abilities.” *Proceedings of the national academy of sciences*, vol. 79, no. 8, pp. 2554–2558, 1982.

[^71]: S. Ramón y Cajal, “La fine structure des centres nerveux. the croonian lecture,” *Proc. Roy. Soc. Lond*, vol. 55, pp. 443–468, 1894.

[^72]: D. O. Hebb, *The organisation of behaviour: a neuropsychological theory*. Science Editions New York, 1949.

[^73]: W. Gerstner, W. M. Kistler, R. Naud, and L. Paninski, *Neuronal dynamics: From single neurons to networks and models of cognition*. Cambridge University Press, 2014.

[^74]: D. J. Amit, H. Gutfreund, and H. Sompolinsky, “Storing infinite numbers of patterns in a spin-glass model of neural networks,” *Physical Review Letters*, vol. 55, no. 14, p. 1530, 1985.

[^75]: ——, “Statistical mechanics of neural networks near saturation,” *Annals of physics*, vol. 173, no. 1, pp. 30–67, 1987.

[^76]: D. Marr, *Vision: A computational investigation into the human representation and processing of visual information*. MIT press, 2010.

[^77]: F. E. Rosas, P. A. Mediano, A. I. Luppi, T. F. Varley, J. T. Lizier, S. Stramaglia, H. J. Jensen, and D. Marinazzo, “Disentangling high-order mechanisms and high-order behaviours in complex systems,” *Nature Physics*, vol. 18, no. 5, pp. 476–477, 2022.

[^78]: D. P. Feldman, C. S. McTague, and J. P. Crutchfield, “The organization of intrinsic computation: Complexity-entropy diagrams and the diversity of natural information processing,” *Chaos: An Interdisciplinary Journal of Nonlinear Science*, vol. 18, no. 4, 2008.

[^79]: J. P. Crutchfield, W. L. Ditto, and S. Sinha, “Introduction to focus issue: intrinsic and designed computation: information processing in dynamical systems—beyond the digital hegemony,” *Chaos: An Interdisciplinary Journal of Nonlinear Science*, vol. 20, no. 3, 2010.

[^80]: A. C. Costa, T. Ahamed, D. Jordan, and G. J. Stephens, “Maximally predictive states: From partial observations to long timescales,” *Chaos: An Interdisciplinary Journal of Nonlinear Science*, vol. 33, no. 2, 2023.

[^81]: P. Auger, R. B. de La Parra, J.-C. Poggiale, E. Sánchez, and L. Sanz, “Aggregation methods in dynamical systems and applications in population and community dynamics,” *Physics of Life Reviews*, vol. 5, no. 2, pp. 79–105, 2008.

[^82]: H. A. Simon and A. Ando, “Aggregation of variables in dynamic systems,” *Econometrica: journal of the Econometric Society*, pp. 111–138, 1961.

[^83]: L. B. White, R. Mahony, and G. D. Brushe, “Lumpable hidden markov models-model reduction and reduced complexity filtering,” *IEEE Transactions on Automatic Control*, vol. 45, no. 12, pp. 2297–2306, 2000.

[^84]: B. Munsky and M. Khammash, “The finite state projection algorithm for the solution of the chemical master equation,” *The Journal of chemical physics*, vol. 124, no. 4, 2006.

[^85]: J. Garcıa and V. A. González-López, “Minimal markov models,” *arXiv preprint arXiv:1002.0729*, 2010.

[^86]: D. H. Wolpert, J. A. Grochow, E. Libby, and S. DeDeo, “Optimal high-level descriptions of dynamical systems,” *arXiv preprint arXiv:1409.7403*, 2014.

[^87]: D. Horsman, S. Stepney, R. C. Wagner, and V. Kendon, “When does a physical system compute?” *Proceedings of the Royal Society A: Mathematical, Physical and Engineering Sciences*, vol. 470, no. 2169, p. 20140182, 2014.

[^88]: J. C. Flack, “Coarse-graining as a downward causation mechanism,” *Philosophical Transactions of the Royal Society A: Mathematical, Physical and Engineering Sciences*, vol. 375, no. 2109, p. 20160338, 2017.

[^89]: D. Janzing, D. Balduzzi, M. Grosse-Wentrup, and B. Schölkopf, “Quantifying causal influences,” *The Annals of Statistics*, vol. 41, no. 5, pp. 2324–2358, 2013.

[^90]: M. Kocaoglu, A. Dimakis, S. Vishwanath, and B. Hassibi, “Entropic causal inference,” in *Proceedings of the AAAI Conference on Artificial Intelligence*, vol. 31, no. 1, 2017.

[^91]: L. Albantakis, W. Marshall, E. Hoel, and G. Tononi, “What caused what? a quantitative account of actual causation using dynamical causal networks,” *Entropy*, vol. 21, no. 5, p. 459, 2019.

[^92]: R. Comolatti and E. Hoel, “Causal emergence is widespread across measures of causation,” *arXiv preprint arXiv:2202.01854*, 2022.

[^93]: C. Finn and J. T. Lizier, “Pointwise partial information decompositionusing the specificity and ambiguity lattices,” *Entropy*, vol. 20, no. 4, p. 297, 2018.

[^94]: M. Prokopenko and J. T. Lizier, “Transfer entropy and transient limits of computation,” *Scientific reports*, vol. 4, no. 1, p. 5394, 2014.

[^95]: O. Pfante, N. Bertschinger, E. Olbrich, N. Ay, and J. Jost, “Comparison between different methods of level identification,” *Adv. Complex Syst.*, vol. 17, no. 02, p. 1450007, 2014.

[^96]: Please note that the definition of informational closure used in Ref. [^95] only requires $I(Z_{t+1};X_{t}|Z_{t})=0$ due to Markovianity of $\bm{X}$, and is hence identical to the characterisation of strong lumpability in [^108].

[^97]: P. Tino and G. Dorffner, “Predicting the future of discrete sequences from fractal representations of the past,” *Machine Learning*, vol. 45, pp. 187–217, 2001.

[^98]: C. Shalizi and K. L. Klinkner, “Blind construction of optimal nonlinear recursive predictors for discrete sequences,” *arXiv preprint arXiv:1408.2025*, 2014.

[^99]: S. Marzen and J. P. Crutchfield, “Circumventing the curse of dimensionality in prediction: causal rate-distortion for infinite-order markov processes,” *arXiv preprint arXiv:1412.2859*, 2014.

[^100]: N. Tishby, F. C. Pereira, and W. Bialek, “The information bottleneck method,” *arXiv preprint physics/0004057*, 2000.

[^101]: A. Gu and T. Dao, “Mamba: Linear-time sequence modeling with selective state spaces,” *arXiv preprint arXiv:2312.00752*, 2023.

[^102]: A. M. Turing *et al.*, “On computable numbers, with an application to the entscheidungsproblem,” *J. of Math*, vol. 58, no. 345-363, p. 5, 1936.

[^103]: An illustrative example is the old but still ongoing debate in neuroscience of whether the brain ought to be conceived as a computer [^122] [^123] [^124] [^125] [^126] or not [^127] [^128] [^129]: while under some definitions the brain is clearly a computer and under others it is not, it is not entirely evident how any of these outcomes advances our actual understanding of how the brain works.

[^104]: B. McLaughlin and K. Bennett, “Supervenience,” in *The Stanford Encyclopedia of Philosophy*, E. N. Zalta, Ed. Metaphysics Research Lab, Stanford University, 2021.

[^105]: T. M. Cover and J. A. Thomas, *Elements of Information Theory*. John Wiley & Sons, 2012.

[^106]: L. Gurvits and J. Ledoux, “Markov property for a function of a Markov chain: a linear algebra approach,” *Linear Algebra Appl.*, vol. 404, pp. 85–117, 2005.

[^107]: There are also other notions of lumpability, such as exact lumpability [^130], and higher-order lumpability [^106] (where the coarse-graining $\bm{Z}$ is a Markov chain of higher order).

[^108]: B. C. Geiger and C. Temmel, “Lumpings of Markov chains, entropy rate preservation, and higher-order lumpability,” *J. Appl. Probab.*, vol. 51, no. 4, pp. 1114–1132, Dec. 2014, extended version: arXiv:1212.4375 \[cs.IT\].

[^109]: In essence, strong lumpability requires an equality of certain probability distributions (cf. [^21]); this equality of distributions is implied by the equality $H(Z_{t}|Z_{t-1})=H(Z_{t}|X_{t-1})$ only if the conditioning event $X_{t-1}$ covers the whole state space $\mathcal{X}$ with positive probability. This is ensured for irreducible Markov chains with finite $\mathcal{X}$ [^21]. Whether the requirement of aperiodicity can be removed, or whether the requirement of stationarity can be relaxed, is currently unclear.

[^110]: S. Derisavi, H. Hermanns, and W. H. Sanders, “Optimal state-space lumping in markov chains,” *Information Processing Letters*, vol. 87, no. 6, pp. 309–315, 2003.

[^111]: D. R. Barr and M. U. Thomas, “Technical note—an eigenvector condition for markov chain lumpability,” *Operations Research*, vol. 25, no. 6, pp. 1028–1031, 1977.

[^112]: M. N. Jacobi and O. Görnerup, “A dual eigenvector condition for strong lumpabilit of Markov chains,” 2008, arXiv:0710.1986.

[^113]: M. N. Katehakis and L. C. Smit, “A successive lumping procedure for a class of Markov chains,” *Probability in the Engineering and Information Sciences*, vol. 26, pp. 483–508, 2012.

[^114]: M. N. Jacobi, “A robust spectral method for finding lumpings and meta stable states of non-reversible Markov chains,” 2010, arXiv:0810.1127.

[^115]: B. C. Geiger, T. Petrov, G. Kubin, and H. Koeppl, “Optimal Kullback-Leibler aggregation via information bottleneck,” *IEEE Trans. Automatic Control*, vol. 60, no. 4, pp. 1010–1022, Apr. 2015, open-access: arXiv:1304.6603 \[cs.SY\].

[^116]: R. A. Amjad, C. Blöchl, and B. C. Geiger, “A generalized framework for Kullback-Leibler Markov aggregation,” *IEEE Trans. Automatic Control*, vol. 65, no. 7, pp. 3068–3075, Jul. 2020, open-access: arXiv:1709.05907 \[cs.SY\].

[^117]: Code for this type of approaches can be found at [https://github.com/stegsoph/Constrained-Markov-Clustering](https://github.com/stegsoph/Constrained-Markov-Clustering).

[^118]: M. Cobb, *The Idea of the Brain: The Past and Future of Neuroscience*. Basic Books, 2020.

[^119]: M. Bondaschi and M. Gastpar, “Alpha-NML universal predictors,” in *2022 IEEE International Symposium on Information Theory (ISIT)*. IEEE, 2022, pp. 468–473.

[^120]: G. Casella and R. L. Berger, *Statistical inference*. Cengage Learning, 2021.

[^121]: E. R. Kandel, Y. Dudai, and M. R. Mayford, “The molecular and systems biology of memory,” *Cell*, vol. 157, no. 1, pp. 163–186, 2014.

[^122]: J. A. Fodor, *The Language of Thought*. Harvard University Press, 1975, vol. 5.

[^123]: Z. Pylyshyn and W. Turnbiull, “Computation and cognition: Toward a foundation for cognitive science,” *Canadian Psychology*, vol. 27, no. 1, pp. 85–87, 1986.

[^124]: M. Rescorla, “From Ockham to Turing – and back again,” in *Philosophical Explorations of the Legacy of Alan Turing*. Springer, 2017, pp. 279–304.

[^125]: M. Milkowski, *Explaining the Computational Mind*. MIT Press, 2013.

[^126]: B. A. Richards and T. P. Lillicrap, “The brain-computer metaphor debate is useless: A matter of semantics,” *Frontiers in Computer Science*, vol. 4, p. 810358, 2022.

[^127]: T. Van Gelder, “What might cognition be, if not computation?” *The Journal of Philosophy*, vol. 92, no. 7, pp. 345–381, 1995.

[^128]: ——, “The dynamical hypothesis in cognitive science,” *Behavioral and Brain Sciences*, vol. 21, no. 5, pp. 615–628, 1998.

[^129]: L. B. Smith, “Cognition as a dynamic system: Principles from embodiment,” *Developmental Review*, vol. 25, no. 3-4, pp. 278–298, 2005.

[^130]: P. Buchholz, “Exact and ordinary lumpability in finite markov chains,” *Journal of Applied Probability*, vol. 31, no. 1, p. 59–75, 1994.