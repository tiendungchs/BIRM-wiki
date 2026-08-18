---
title: "Vector Symbolic Algebras for the Abstraction and Reasoning Corpus"
source: "https://arxiv.org/html/2511.08747v1"
author:
published:
created: 2026-06-23
description:
tags:
  - "clippings"
---
Isaac Joffe  
Centre for Theoretical Neuroscience  
David R. Cheriton School of Computer Science  
University of Waterloo  
Waterloo, ON  
ijoffe@uwaterloo.ca  
&Chris Eliasmith  
Centre for Theoretical Neuroscience  
Department of Philosophy  
Department of Systems Design Engineering  
University of Waterloo  
Waterloo, ON  
celiasmith@uwaterloo.ca

###### Abstract

The Abstraction and Reasoning Corpus for Artificial General Intelligence (ARC-AGI) is a generative, few-shot fluid intelligence benchmark. Although humans effortlessly solve ARC-AGI, it remains extremely difficult for even the most advanced artificial intelligence systems. Inspired by methods for modelling human intelligence spanning neuroscience to psychology, we propose a cognitively plausible ARC-AGI solver. Our solver integrates System 1 intuitions with System 2 reasoning in an efficient and interpretable process using neurosymbolic methods based on Vector Symbolic Algebras (VSAs). Our solver works by object-centric program synthesis, leveraging VSAs to represent abstract objects, guide solution search, and enable sample-efficient neural learning. Preliminary results indicate success, with our solver scoring $10.8\%$ on ARC-AGI-1-Train and $3.0\%$ on ARC-AGI-1-Eval. Additionally, our solver performs well on simpler benchmarks, scoring $94.5\%$ on Sort-of-ARC and $83.1\%$ on 1D-ARC—the latter outperforming GPT-4 at a tiny fraction of the computational cost. Importantly, our approach is unique; we believe we are the first to apply VSAs to ARC-AGI and have developed the most cognitively plausible ARC-AGI solver yet. Our code is available at: [https://github.com/ijoffe/ARC-VSA-2025](https://github.com/ijoffe/ARC-VSA-2025).

## 1 Introduction

The Abstraction and Reasoning Corpus for Artificial General Intelligence [^10] [^12] challenges the tremendous progress deep learning has made in artificial intelligence (AI). ARC-AGI is a fluid intelligence benchmark comprising a collection of grid prediction tasks (see Figs. 2 and 2). The goal of the test-taker, human or AI, is simple: given a few pairs of input and output grids containing abstract symbols, determine the rules underlying the symbol transformations and use this understanding to predict the output grids corresponding to lone test input grids. ARC-AGI is easy for humans. Human performance is estimated to be $85.0\%$ and all tasks were solved by at least one of two experts [^11], indicating human intelligence can completely solve the benchmark. Conversely, ARC-AGI is hard for AI. Despite ample focus and investment over multiple $\mathdollar 1{,}000{,}000$ competitions [^14] [^13], the benchmark remains unbeaten. ARC-AGI has proved resistant to old and new deep learning techniques, including the large language model (LLM)—OpenAI’s original GPT-3 [^9] scored $0.0\%$ [^11] notwithstanding claims of emergent reasoning [^103]. The chasm between human and AI performance on ARC-AGI suggests fundamental problems with leading approaches to AI.

Two such problems often identified in the literature are sample-efficient learning and explicit reasoning [^6] [^41] [^56]. Deep learning’s success requires vast amounts of often-labelled high-quality training data, making it ineffective in the sample-few regime. Additionally, deep learning systems struggle with representing explicit rules, sometimes manifesting in poor out-of-distribution generalization. Vector Symbolic Algebras (VSAs), a neurosymbolic AI method introducing syntactic structure into high-dimensional distributed representations, hold promise to overcome these two limitations that ARC-AGI targets. VSAs specify high-dimensional vectors to represent structured low-dimensional data, discrete or continuous. Thus, instead of learning useful embeddings from huge datasets, a VSA can be used to encode data with desired inductive biases. VSAs also define operators for the composition and systematic processing of data. Thus, instead of learning shortcut transformations that may generalize poorly to unseen inputs, a VSA, despite relying on distributed representations, can be used to express certain operations analytically. Additionally, VSAs support discrete search and neural learning, both of which are helpful for ARC-AGI. These strengths of VSAs, along with their ability to effectively model cognitive processes in a biologically plausible manner [^27] [^26], make them an excellent candidate for helping solve ARC-AGI.

We propose a novel, neurosymbolic, cognitively plausible ARC-AGI solver. Our solver uses VSAs, a general cognitive modelling framework, to bridge intuition and reason and capture the efficiency and interpretability of human intelligence. We believe we are the first to apply VSAs to ARC-AGI and, in doing so, have developed the most cognitively plausible ARC-AGI solver yet. The rest of this paper is organized as follows:

## 2 Preliminaries

### 2.1 Vector Symbolic Algebras

Before explaining how our solver—which uses VSAs extensively—works, we describe VSAs further. VSAs, also known as hyperdimensional computing, are a family of algebras defining operations over a high-dimensional vector space. In this work, we use Holographic Reduced Representations [^79] [^81] [^82], one particular VSA.

#### 2.1.1 Holographic Reduced Representations

HRRs define four operations: similarity, binding, bundling, and inversion. Following [^36], we describe each.

Similarity, denoted by the $\cdot:\mathbb{R}^{N}\times\mathbb{R}^{N}\rightarrow\mathbb{R}$ operator, operates on two vectors, $\boldsymbol{a}$ and $\boldsymbol{b}$, to produce a scalar, $s=\boldsymbol{a}\cdot\boldsymbol{b}$. The resultant value represents the semantic similarity between the vectors. Similarity is implemented as the vector dot product: $s=\boldsymbol{a}\cdot\boldsymbol{b}=\langle\boldsymbol{a},\boldsymbol{b}\rangle=\left\lVert\boldsymbol{a}\right\rVert\left\lVert\boldsymbol{b}\right\rVert\cos{\theta_{\boldsymbol{ab}}}$. Because we usually work with unit-length vectors (i.e., $\left\lVert\boldsymbol{a}\right\rVert=\left\lVert\boldsymbol{b}\right\rVert=1$), the dot product is equivalent to cosine similarity and, thus, $s$ falls between $-1$ and $1$. Similarity is commutative. In high-dimensional vector spaces, the similarity between any two randomly-generated vectors is likely to be extremely small. Similarity can be used to clean-up noisy vectors by replacing the noisy vector with the one from a library of known vectors to which the noisy vector is most similar.

Bundling, denoted by the $+:\mathbb{R}^{N}\times\mathbb{R}^{N}\rightarrow\mathbb{R}^{N}$ operator, combines two vectors, $\boldsymbol{a}$ and $\boldsymbol{b}$, into one, $\boldsymbol{c}=\boldsymbol{a}+\boldsymbol{b}$. The resultant vector is similar to both input vectors (i.e., $\boldsymbol{c}\cdot\boldsymbol{a}\gg 0$ and $\boldsymbol{c}\cdot\boldsymbol{b}\gg 0$); bundling gathers multiple vectors into a single representation, producing a superposition of those vectors. Bundling is implemented as element-wise vector addition. Bundling is commutative and associative.

Binding, denoted by the $\circledast:\mathbb{R}^{N}\times\mathbb{R}^{N}\rightarrow\mathbb{R}^{N}$ operator, combines two vectors, $\boldsymbol{a}$ and $\boldsymbol{b}$, into one, $\boldsymbol{c}=\boldsymbol{a}\circledast\boldsymbol{b}$. The resultant vector is dissimilar to both input vectors (i.e., $\boldsymbol{c}\cdot\boldsymbol{a}\simeq 0$ and $\boldsymbol{c}\cdot\boldsymbol{b}\simeq 0$); binding associates two vectors, producing a new vector unlike any existing vectors. Binding is implemented as circular convolution: $\boldsymbol{c}=\boldsymbol{a}\circledast\boldsymbol{b}=\mathcal{F}^{-1}\left\{\mathcal{F}\left\{\boldsymbol{a}\right\}\odot\mathcal{F}\left\{\boldsymbol{b}\right\}\right\}$, where $\mathcal{F}$ is the discrete Fourier transform (DFT) and $\odot$ denotes Hadamard, or element-wise, multiplication. Binding is commutative and associative.

Inversion, denoted by the ${}^{-1}:\mathbb{R}^{N}\rightarrow\mathbb{R}^{N}$ operator, converts one vector, $\boldsymbol{a}$, into another, $\boldsymbol{a}^{-1}$. The resultant vector bound with the input vector approximately produces the binding identity vector (i.e., $\boldsymbol{a}\circledast\boldsymbol{a}^{-1}\simeq\mathbf{I}$ where $\boldsymbol{a}\circledast\mathbf{I}=\boldsymbol{a}$). Inversion can be used to unbind bound vectors: given a bound vector, $\boldsymbol{c}=\boldsymbol{a}\circledast\boldsymbol{b}$, and one of its constituent vectors, $\boldsymbol{a}$, the other can be extracted by binding with the inverse of the known constituent (i.e., $\boldsymbol{c}\circledast\boldsymbol{a}^{-1}=(\boldsymbol{a}\circledast\boldsymbol{b})\circledast\boldsymbol{a}^{-1}\simeq\boldsymbol{b}$).

![Refer to caption](https://arxiv.org/html/2511.08747v1/task_0962bcdd.png)

Figure 1: ARC-AGI task 0962bcdd. Here, the implicit pattern is to transform each multi-coloured object into a larger object.

These four operations can be combined to encode and compute useful functions on complex data structures, such as lists [^15] and graphs [^55]. For example, we can use a slot-filler representation to store multiple features of an item in a compressed but interpretable format. Given known slot vectors $\mathtt{SIZE},\mathtt{SPECIES}\in\mathbb{R}^{N}$, we can encode a small dog as $\boldsymbol{a}=\mathtt{SIZE}\circledast\mathtt{SMALL}+\mathtt{SPECIES}\circledast\mathtt{DOG}$ and a large cat as $\boldsymbol{b}=\mathtt{SIZE}\circledast\mathtt{LARGE}+\mathtt{SPECIES}\circledast\mathtt{CAT}$, for instance. We can then query information about each object by unbinding: $\boldsymbol{a}\circledast\mathtt{SIZE}^{-1}\simeq\mathtt{SMALL}$ and $\boldsymbol{b}\circledast\mathtt{SPECIES}^{-1}\simeq\mathtt{CAT}$. The former query becomes

$$
\displaystyle\boldsymbol{a}\circledast\mathtt{SIZE}^{-1}
$$
 
$$
\displaystyle=(\mathtt{SIZE}\circledast\mathtt{SMALL}+\mathtt{SPECIES}\circledast\mathtt{DOG})\circledast\mathtt{SIZE}^{-1}
$$
 
$$
\displaystyle=\mathtt{SIZE}\circledast\mathtt{SMALL}\circledast\mathtt{SIZE}^{-1}+\mathtt{SPECIES}\circledast\mathtt{DOG}\circledast\mathtt{SIZE}^{-1}
$$
 
$$
\displaystyle\simeq\mathtt{SMALL}+\mathtt{SPECIES}\circledast\mathtt{DOG}\circledast\mathtt{SIZE}^{-1}
$$
 
$$
\displaystyle\simeq\mathtt{SMALL}
$$

which works because $\mathtt{SPECIES}\circledast\mathtt{DOG}\circledast\mathtt{SIZE}^{-1}$ behaves as noise that can be eliminated by clean-up.

Furthermore, we can encode a list of $k$ items as $\boldsymbol{m}=\sum_{i}^{k}{\mathtt{ITEM}_{i}\circledast\mathtt{ONE}^{i}}$, where $\mathtt{ONE}^{i}$ is the $i$ -th index of the sequence [^15]. The slots, $\mathtt{ONE}^{i}$, are defined according to a recursively-bound index vector, $\mathtt{ONE}$, as

$$
\displaystyle\mathtt{TWO}
$$
 
$$
\displaystyle=\mathtt{ONE}\circledast\mathtt{ONE}=\mathtt{ONE}^{2}
$$
 
$$
\displaystyle\mathtt{THREE}
$$
 
$$
\displaystyle=\mathtt{TWO}\circledast\mathtt{ONE}=\mathtt{ONE}\circledast\mathtt{ONE}\circledast\mathtt{ONE}=\mathtt{ONE}^{3}
$$
 
$$
\displaystyle\mathtt{FOUR}
$$
 
$$
\displaystyle=\ldots
$$

where use of the exponentiation symbol is purely for notational convenience; the underlying operation is not repeated multiplication, but repeated binding. With this representation, the index of a known element in the list or the element at a known index in the list can be queried.

The Semantic Pointer Architecture [^26] is an architecture for modelling biological cognition using HRRs. The SPA has been used [^85] [^86] to solve the Raven’s Progressive Matrices [^87] by which ARC-AGI was inspired. This RPM solver worked by generating VSA representations of each cell in the grid based on perceptual outputs, unbinding each cell’s representation from its subsequent cell’s representation to obtain transformation vectors, averaging these transformation vectors to obtain a single rule vector, and applying this rule vector to the second-last cell to predict the final cell. ARC-AGI is a significantly harder problem because of its less constrained format (e.g., the requirement to generate solutions from scratch) and content (e.g., each task is distinct), but this past success suggests VSAs hold potential.

#### 2.1.2 Spatial Semantic Pointers

Typical HRRs can represent and express a multitude of discrete, but not continuous, information structures and operations. Expanding on early suggestions [^80], Spatial Semantic Pointers [^52] [^51] extend HRRs to continuous spaces. These representations can model [^23] grid cell neurons observed in the brain [^21] [^42] and can be used to solve challenging spatial reasoning tasks [^25] [^24] [^22].

An SSP encoding defines a mapping $\phi:\mathbb{R}^{D}\rightarrow\mathbb{R}^{N}$ from a low, $D$ -dimensional vector space, feature space, to a high, $N$ -dimensional vector space, SSP space, based on a generalization of recursive binding into fractional binding. To understand this, consider a one-dimensional feature space. Before, the vector representing the $n$ -th index of the sequence, $\mathtt{ONE}^{n}$, was computed by binding $\mathtt{ONE}$ with itself $n$ times. However, we can also compute $\mathtt{ONE}^{n}$ as

$$
\displaystyle\mathtt{ONE}^{n}
$$
 
$$
\displaystyle=\underbrace{\mathtt{ONE}\circledast\ldots\circledast\mathtt{ONE}}_{n\text{ times}}
$$
 
$$
\displaystyle=\mathcal{F}^{-1}\left\{\underbrace{\mathcal{F}\left\{\mathtt{ONE}\right\}\odot\ldots\odot\mathcal{F}\left\{\mathtt{ONE}\right\}}_{n\text{ times}}\right\}
$$
 
$$
\displaystyle=\mathcal{F}^{-1}\left\{\mathcal{F}\left\{\mathtt{ONE}\right\}^{n}\right\}
$$

where <sup>n</sup> represents element-wise exponentiation. This formulation allows natural generalization from $n\in\mathbb{Z}^{+}$ to $x\in\mathbb{R}$; instead of encoding discrete values by repeatedly binding the vector with itself, we can encode discrete or continuous values by directly exponentiating the DFT of the vector and taking the inverse DFT of this result. This formulation can be further generalized to represent multi-dimensional features, $\boldsymbol{x}\in\mathbb{R}^{D}$, by binding together the vectors representing each feature dimension. For example, consider the two-dimensional feature space $\mathbb{R}^{2}$. Given basis or axis vectors $\mathtt{X},\mathtt{Y}\in\mathbb{R}^{N}$, an arbitrary point in the feature space $\boldsymbol{x}=(x,y)$ can be expressed in the SSP space as $\phi(\boldsymbol{x})=\mathtt{X}^{x}\circledast\mathtt{Y}^{y}=\mathcal{F}^{-1}\left\{\mathcal{F}\left\{\mathtt{X}\right\}^{x}\odot\mathcal{F}\left\{\mathtt{Y}\right\}^{y}\right\}$.

In the most general form, an SSP encoding is defined as

$$
\phi(\boldsymbol{x})=\mathcal{F}^{-1}\left\{e^{i\Theta\frac{\boldsymbol{x}}{l}}\right\}
$$

where $\Theta\in\mathbb{R}^{D\times N}$ is the phase matrix of the SSP encoding and $l\in\mathbb{R}$ is a length-scale parameter. The phase matrix defines the mapping and ensures all SSPs generated are real-valued. Particular choices of $\Theta$ produce grid-cell-like representations [^23].

SSPs can also be interpreted as probability representations over the feature space [^36] [^37]. This is because similarity induces a kernel function [^33] [^99]: $\phi(\boldsymbol{x}_{1})\cdot\phi(\boldsymbol{x}_{2})=k(\phi(\boldsymbol{x}_{1}),\phi(\boldsymbol{x}_{2}))$. The behaviour of this kernel function, $k(\cdot,\cdot)$, can be modified by changing the distribution from which the phase matrix of the encoding is sampled. Other HRR operations also behave specially on SSPs. Binding is addition in the feature space: $\phi(\boldsymbol{x}_{1})\circledast\phi(\boldsymbol{x}_{2})=\phi(\boldsymbol{x}_{1}+\boldsymbol{x}_{2})$. Note that this makes shifting items easy and means the zero vector in the feature space (i.e., the origin) is represented as the identity vector in the SSP space (i.e., $\phi(\boldsymbol{0})=\boldsymbol{I}$). This is because $\phi(\boldsymbol{x})=\phi(\boldsymbol{x}+\boldsymbol{0})=\phi(\boldsymbol{x})\circledast\phi(\boldsymbol{0})$ and $\phi(\boldsymbol{x})=\phi(\boldsymbol{x})\circledast\boldsymbol{I}$. Inversion is negation in the feature space: $\phi(\boldsymbol{x})^{-1}=\phi(-\boldsymbol{x})$. This is because $\mathbf{I}=\phi(\boldsymbol{0})=\phi(\boldsymbol{x}+(-\boldsymbol{x}))=\phi(\boldsymbol{x})\circledast\phi(-\boldsymbol{x})$ and $\boldsymbol{I}=\phi(\boldsymbol{x})\circledast\phi(\boldsymbol{x})^{-1}$.

SSPs can be combined with other vectors to represent complex scenes. For example, we can encode $k$ items at certain positions in a scene as $\boldsymbol{a}=\sum_{i}^{k}{\mathtt{ITEM}_{i}\circledast\phi({\boldsymbol{x}_{i}})}$. As in the discrete list example, the position of a known item in the scene or the item at a known position in the scene can be queried.

### 2.2 Dual Process Cognition

We often explain the operation of our solver with metaphors to dual process theory [^102], supporting cognitive plausibility. To elucidate these comparisons, we introduce dual process theory and its applications to both psychology and AI.

#### 2.2.1 System 1 and System 2

In psychology, the mind is often understood as being composed of two complementary systems, System 1 and System 2 [^48]. System 1 performs fast, automatic tasks, and can be thought of as a fictitious agent modelled as a large associative memory tuned by evolution and experience. System 1 operates constantly and involuntarily, appraising the environment to invoke emotions and produce impressions that generate a coherent world model. The operation of System 1 is characterized by heuristics, accurate but imperfect intuitions that intelligently guide behaviour. System 2 performs slow, intentional tasks, and can be thought of as another fictitious agent aligning with our conscious experience. System 2 operates sparingly and intentionally, solving complex problems only when needed because mobilizing the required cognitive resources is expensive. The operation of System 2 is characterized by calculated reasoning for attention-intensive tasks. System 1 and System 2 each play a role in intelligence because they solve different problems, so it is often argued that a complete account of intelligence must model both [^6].

#### 2.2.2 Symbolic and Connectionist Intelligence

Early approaches to AI [^62] [^104], inspired by formal reasoning, sought to emulate symbolic cognition [^74] [^73]. In this paradigm, intelligence arises from strictly following explicit, hand-crafted rules. The resulting so-called expert systems excel at conveying narrow domain knowledge and performing logical reasoning, but suffer from important limitations. First, explicit symbolic rules are brittle, robust to neither changes in the environment nor noisy data in raw, perceptual form [^19] [^43] [^49]. Second, discrete search is not scalable, quickly becoming intractable due to inevitable combinatorial explosion [^49]. Third, learning is difficult, limiting generalizability and constraining systems to narrow scopes of expertise [^39] [^71]. Fourth, biological implementation of the symbolic paradigm remains unclear.

Recent successes in AI [^53] [^84] [^94], inspired by the observation of countless neurons activating in concert in the brain [^66] [^89], have been dominated by the connectionist view [^91]. In this paradigm, intelligence arises from operations computed as functions of high-dimensional feature representations in large-scale neural networks [^56] [^92]. The resulting neural and statistical machines are extremely powerful at extracting patterns from data, but suffer from important limitations of their own [^32]. First, connectionist models scale to a fault, performing better with increased model and dataset size but requiring large models and datasets to succeed [^19] [^39]. Second, connectionist models learn to a fault, sometimes memorizing their training data and often generalizing poorly outside of their training distribution [^19] [^39] [^40] [^64] [^96]. Third, learned high-dimensional representations and operations are opaque, rendering many connectionist models unexplainable black boxes [^19] [^39] [^71] [^112]. Fourth, biological implementation of the connectionist paradigm also remains unclear [^18] [^90].

Connectionist models excel at System 1 tasks, such as recognizing images, transcribing speech, and generating text. Conversely, symbolic models excel at System 2 tasks, such as logical inference and trial-and-error search. We believe neurosymbolic models integrating elements of each paradigm are necessary to completely model intelligence.

VSAs provide one type of neurosymbolic approach. VSAs bridge symbolic and connectionist AI, combining the strengths of each to mitigate the weaknesses of each. Symbol-like representations afford the benefits of explicit, hand-crafted rules while overcoming the limitations of pure symbolic models. Using distributed representations provides robustness to noise, facilitates similarity metrics to guide search, and enables continuous learning. Neural-like representations afford the benefits of neural learning in NNs while overcoming the limitations of pure connectionist models. Using structured representations with useful inductive biases and features pre-encoded improves sample-efficiency in learning, enables generalizable algebraic models, and permits direct interpretation of intermediate representations. Additionally, VSAs are biologically and cognitively plausible and can be implemented in spiking NNs [^27] [^26].

### 2.3 Abstraction and Reasoning Corpus

Before explaining how our solver works, we provide a more detailed description of ARC-AGI. Here, we discuss its theoretical foundations, its exact format, how others have approached it, and how we approach it.

#### 2.3.1 Background and Definition

AI was originally defined as “the science of making machines do things that would require intelligence if done by \[people\]” [^67]. This skill-based view of intelligence underpins many modern AI systems adept at one particular task, but only that one task. The skills AI systems can perform—synthetic art generation and natural language translation, for instance—have become increasingly advanced, but the underlying paradigm remains the same: models fit their many parameters to copious amounts of data during a training phase, and statically apply their learned skill to unseen data during an inference phase. In contrast, humans are simultaneously adept at many tasks. A skilled human may be able to both create art and translate between languages, and unskilled humans can learn these new skills. In this sense, human intelligence is better characterized by its adaptability, fluidity, and generality. Not only can we humans excel at particular well-known tasks, we can rapidly learn to perform new tasks in response to new situations. Human intelligence is dynamic, without disjoint training and inference phases. In ARC-AGI’s initial introduction, Chollet defined intelligence as skill-acquisition efficiency: the ability of a system to quickly develop novel skills to solve novel problems [^10]. In this view, crystalline skill at any number of tasks is not intelligence; instead, intelligence is the process by which those skills are learned. ARC-AGI aligns with this paradigm by testing the ability of a system to learn arbitrary transforms on-the-fly from few examples.

ARC-AGI is a collection of abstract reasoning tasks (see Figs. 2 and 2). The original dataset, ARC-AGI-1, consists of 400 public training tasks, 400 public evaluation tasks, and 200 private evaluation tasks. The newer version, ARC-AGI-2, consists of 1000 public training tasks, 120 public evaluation tasks, and 120 private evaluation tasks. The performance of a solver is usually assessed on each group separately because the evaluation splits are more difficult. The private splits are known only to the ARC-AGI team and are used to test the true generalizability of solvers. Each task has a training component and a testing component. The training component is a set, $\mathcal{D}$, of a few demonstrations, or demonstration pairs. The number of demonstrations is a feature of the task, but is usually about three (in ARC-AGI-1-Train, $2\leq|\mathcal{D}|\leq 10$ with median $3$, mean $3.26$, and standard deviation $0.96$). Each demonstration is composed of two grids, one input grid and one output grid. Each grid, $\mathbf{G}\in\mathbb{G}$, contains $r$ rows and $c$ columns of pixels. Grids must be rectangular; they are often square, but $r$ need not equal $c$. Grids range in size (in ARC-AGI-1-Train, $r\text{, }c\in\{1,\ldots,30\}$ with medians $10$ and $10$, means $9.64$ and $10.03$, and standard deviations $6.01$ and $6.16$); the sizes of the input and output grids in a demonstration often match, but a grid size change may be part of the task. Each pixel, $P_{ij}\in\mathbb{P}$, is one of ten discrete symbols provided as an integer but usually displayed as a colour for human convenience. The exact colours used for display are arbitrary; no task relies on facts about colours, such as that orange is a mix of red and yellow. To summarize, $\mathcal{D}=\{(\mathbf{G}_{I_{d}},\mathbf{G}_{O_{d}})~|~\mathbf{G}_{*_{*}}\in\mathbb{G},~d=1\ldots|\mathcal{D}|\}$, where $\mathbb{G}=\mathbb{P}^{r_{*_{*}}\times c_{*_{*}}}$ and $\mathbb{P}=\{0,\ldots,9\}$. The input grid of each demonstration can be mapped onto its corresponding output grid via some transformation. This transformation, $\mathcal{T}_{d}$, describes how to produce this specific output grid, $\mathbf{G}_{O_{d}}$, from the corresponding input grid, $\mathbf{G}_{I_{d}}$. The transformations underlying each demonstration in a task share structure and can be generalized into a simple common program. This program, $\mathcal{P}$, describes how to produce the corresponding output grid for any valid input grid. To summarize, $\mathbf{G}_{I_{d}}\xrightarrow{\mathcal{T}_{d}}\mathbf{G}_{O_{d}}$ for each $d\in\{1,\ldots,|\mathcal{D}|\}$ and $\mathbf{G}_{I_{d}}\xrightarrow{\mathcal{P}}\mathbf{G}_{O_{d}}~~\forall d\in\{1,\ldots,|\mathcal{D}|\}$. The testing component is also a set, $\mathcal{Q}$, of a few queries. The number of queries is also a feature of the task, but is usually just one (in ARC-AGI-1-Train, $1\leq|\mathcal{Q}|\leq 3$ with median $1$, mean $1.04$, and standard deviation $0.22$). A query is a lone test input grid without a provided output grid. The goal of the solver is to correctly answer the queries; to solve a task correctly, the solver must predict exactly the correct output grid, both its size and contents, for all queries. The performance of a solver is defined as the proportion of some subset of tasks solved correctly.

What makes ARC-AGI so difficult is also what makes it compelling. There are several important differences between ARC-AGI and other benchmarks. First, the problem is generative. Instead of choosing the correct output grid from a set of candidates as in classification tasks, such as the RPMs, solvers must generate the output grid from scratch. Second, the reasoning involved is, as the name suggests, abstract. Implied objects are not grounded (i.e., they may have no real-world correlates), implied actions invoke high-level ideas (e.g., motion until contact), and implied rules invoke relative and fuzzy concepts (e.g., the largest among a set or the horizontalness of a shape). As such, solvers must represent each grid in terms of its abstract qualities and construct a program insensitive to inconsequential details of the particular demonstrations. Third, no two tasks are alike. No solution program will work for any pair of tasks, and the possible concepts, transforms, and their compositions are wildly unconstrained.

Despite these complexities, ARC-AGI is based only on four core knowledge priors: objectness, goal-directedness, numbers, and geometry. Objectness requires perceiving grids as collections of cohesive, persistent, interacting objects. Goal-directedness requires anthropomorphizing objects into agents acting to achieve goals. Numbers requires understanding basic arithmetic, such as counting, addition, and subtraction, and abstract mathematical notions, such as sorting, smallest, and largest. Geometry requires understanding position, symmetry, translation, rotation, scaling, and the like. A solver with a thorough understanding of only these four concepts can solve ARC-AGI; specialized knowledge, such as language or external world facts, are unnecessary. Humans innately have some of these priors from evolution, and acquire the others through experience interacting with the modern world.

#### 2.3.2 Related Work

Many ARC-AGI solvers can be divided into two broad classes: transductive solvers and inductive solvers [^60] [^11]. Transductive solvers [^2] [^8] [^17] [^31] [^34] [^83] [^100] directly answer the queries without explicit intermediate reasoning. These approaches use an NN, usually an LLM, to implicitly understand the demonstration transformations and apply the query transformations all at once, without generating any representation of the patterns underlying the transformations. Inductive solvers [^30] [^44] [^61] [^72] [^88] [^105] [^106] [^108] generate explicit rules mapping input grids to output grids and apply these rules to the queries. These approaches use various search techniques, but invariably cast ARC-AGI as a program synthesis problem. Both approaches in isolation are problematic; neurosymbolic approaches [^4] [^5] [^63] [^77] [^97] [^101] integrating transduction and induction, such as deep-learning-guided program synthesis, have been suggested as the ideal solution [^11].

Transductive solvers are dominated by LLMs and other transformer-based [^98] models. But, despite their impressive abilities, LLMs suffer from several critical weaknesses that prove problematic for solving ARC-AGI. First, LLMs struggle with numeracy. Stemming from fundamental limitations of the transformer architecture [^78] [^110], LLMs struggle to perform out-of-distribution arithmetic [^111] or, infamously, to even count the number of occurrences of a letter in a sequence [^35]. Second, LLMs struggle with following rules. As such, LLMs cannot play many games effectively [^20], and even their ‘reasoning’ variants cannot follow steps well enough to consistently solve complex problems [^93]. Third, LLMs struggle with out-of-distribution generalization. LLMs lack robustness and fail to exhibit even simple forms of generalization: they cannot generalize facts into their reversed form [^7], are biased by content effects [^54], and brittly collapse on slight variations of known tasks [^107] [^65]. Fourth, LLMs struggle with important capabilities of human intelligence. LLMs cannot learn fast, generalize broadly, or explicitly understand their actions [^70]. Language is useful to express reasoning, but is not required to perform reasoning [^29]. These failures of LLMs, along with their restriction to the text domain, suggest deficiencies in ARC-AGI’s required core knowledge priors and intrinsic issues with performing the systematic reasoning required to solve ARC-AGI. LLMs, when prompted directly or with chain-of-thought, and vision language models in isolation have weak performance [^38] [^57] [^68] [^95].

Inductive solvers perform search on either a general-purpose language (GPL) or a domain-specific language (DSL). GPLs, such as Python, are expressive and can be used to solve all ARC-AGI tasks, providing scalability. But, GPLs lack the inductive biases necessary to express solutions to ARC-AGI simply, making search difficult. Conversely, DSLs, requiring hand-crafted primitives, allow humans to introduce problem-relevant inductive biases, making search easier. But, DSLs are not expressive enough to solve all possible ARC-AGI-like tasks, limiting scalability. DSLs capable of solving all existing ARC-AGI tasks [^45] [^46] are massive and still may be incapable of solving new tasks. Additionally, without proper guidance through the search space, search processes are unintelligent.

Unfortunately, little is known about how exactly humans solve ARC-AGI so effectively. But, some facts are clear from studies on humans. First, humans reason in terms of objects. This is true in general, and action traces of humans solving ARC-AGI tasks indeed show pixel groups are operated on together [^47]. Second, humans dedicate time to explicit hypothesis generation. A non-negligible period of initial inaction is consistently observed [^47]. Third, humans can express their task solutions programmatically. Transformations can be communicated in terms of natural language rules [^1]; whether the solution discovery process itself is program synthesis remains unknown. Fourth, humans conceptualize features and operations using high-level abstractions. For example, humans describe their solutions in terms of objects with “tails” [^47], objects as “flowers” [^59], and objects “bumping into” each other [^1]; whether such abstractions are necessary for the solving process remains unknown. Fifth, humans make mistakes different from those made by artificial solvers. Human failures usually show partial correctness indicating some understanding [^58] [^59], but the failures of artificial solvers indicate little understanding [^76]. We take these facts to suggest humans solve ARC-AGI by means of object-centric program synthesis.

Importantly, transductive and inductive solvers are each doing something entirely unlike what humans are doing; humans are not solving ARC-AGI purely by means of transduction or induction. Transductive solvers, based on connectionist networks, model System 1; inductive solvers, based on symbolic engines, model System 2. But, neither is enough alone: humans are able to solve ARC-AGI so effectively because of contributions from both System 1 and System 2. Humans are guided by System 1 intuitions, immediate instincts arising from common sense and world knowledge, but also generate and test explicit hypotheses with System 2 reasoning, careful consideration of a limited number of ideas. We believe a neurosymbolic approach combining the strengths of symbolic and connectionist AI is thus needed.

## 3 Methods

Fundamentally, we aim to develop a cognitively plausible ARC-AGI solver. The goal of ARC-AGI is to spur progress towards artificial general intelligence (AGI), so taking inspiration from human intelligence, the only known general intelligence, is reasonable. Additionally, human intelligence remains the best ARC-AGI solver by a wide margin, suggesting important insights are missing from artificial solvers.

### 3.1 Solution Structure

We believe humans solve ARC-AGI via object-centric program synthesis. As such, our solver generates solutions to ARC-AGI tasks based on objects and programs.

#### 3.1.1 Objects

Humans reason about ARC-AGI with objects rather than with individual pixels or whole grids. Fundamentally, an object is a group of pixels transformed cohesively. Because the transformations are different in every task, what makes a group of pixels constitute an object is task-dependent; the same group of pixels may form an object in one task, but not in another. Thus, for each task, an object definition must be discovered alongside the transformations as part of the solution generation process. Following this view, our solver represents each grid, input and output, as the set of its constituent objects and each transformation, training and testing, as a series of one-to-one operations on those objects.

Object representation determines both what tasks can be solved and how those tasks can be solved. Certain object properties may be required to solve some tasks, but not others. For example, an object’s colour is relevant in ARC-AGI tasks 54d9e175 and a61f2674 (see Figs. 2 and 4), but irrelevant in ARC-AGI tasks 0962bcdd and a61ba2ce (see Figs. 2 and 4). Additionally, the way information is represented makes some transformations easier to implement, but others harder. For example, representing position in Cartesian coordinates makes performing translations simple but rotations complicated, and vice versa for polar coordinates.

![Refer to caption](https://arxiv.org/html/2511.08747v1/task_a61ba2ce.png)

Figure 3: ARC-AGI task a61ba2ce. Here, the implicit pattern is to rearrange the four blocks into a hollow square on a small grid.

We adopt an object representation scheme with three features: colour, centre, and shape. An object’s colour is its discrete symbol in the grid. Colour is represented as one of ten vectors; as such, objects may only be one colour. An object’s centre is the midpoint of the furthest extent of all its pixels in all directions. Centre is represented as the SSP encoding the two-dimensional coordinates of this midpoint relative to the grid’s centre, with a blurring effect facilitating partial similarity. An object’s shape is its pixel pattern. Shape is represented as the normalized bundle of the SSPs encoding each pixel’s location relative to the object’s centre. Object representations can be visualized using standard SPA and SSP methods (see Fig. 5). We hypothesize that higher-level object properties, such as symmetry and exact pixel count, initially go unnoticed by humans and are only encoded after their relevance becomes apparent. Although necessary to rigourously solve some tasks, these properties are not explicitly considered by our solver.

![Refer to caption](https://arxiv.org/html/2511.08747v1/object_example_1.png)

Figure 5: Visualization of the object representations for the input grid in the first demonstration of ARC-AGI task a61ba2ce (see Fig. 4 ). The colour subfigure (left) shows the similarity of the object’s colour representation to each of the ten possible colour vectors. The centre subfigure (middle) shows the similarity of the object’s centre representation to the SSP encoding each location in the grid. The shape subfigure (right) shows the similarity of the object’s shape representation to the SSP encoding each possible location in two-dimensional space. These representations use N = 1024 N\\!=\\!1024 -dimensional vectors.

#### 3.1.2 Programs

Humans solve ARC-AGI with programs. In this view, solving an ARC-AGI task means synthesizing a general program to generate the correct output grid for any valid input grid. Crucially, the search process underlying program discovery is both constrained and intentional. To solve an ARC-AGI task, humans iteratively explore multiple solution hypotheses—re-interpreting the contents of the grids and conceptualizing new transformations based on different abstractions—until they find a satisfactory algorithm to solve all demonstrations. However, the extent of this exploration is narrow; because System 2 cognitive resources are limited, humans consciously examine only a few solution hypotheses. System 1 intuitions guide which paths are explored; humans quickly dismiss nonsensical ideas and only seriously investigate ideas that conceptually fit the task’s content. Following this view, our solver iteratively constructs and tests hypotheses represented as solution programs.

Program representation also determines both what tasks can be solved and how those tasks can be solved. Our solver synthesizes programs within a DSL. The primitives in this DSL were carefully designed to capture human inductive biases commonly appearing in ARC-AGI while remaining as general-purpose as possible. For example, our DSL contains a basic Identity operation to exactly reproduce an input object as an output object, elementary Recolour, Recentre, and Reshape operations to change each object property, an open-ended Generate operation to create an arbitrary output object, and more (see Table 1).

Table 1: Our solver’s DSL.

| Operation | Parameter(s) | Explanation |
| --- | --- | --- |
| Identity | — | Keeps the object as is. |
| Extract | — | Shrinks the grid around the object. |
| Recolour | $\mathtt{COLOUR}$ | Changes the object’s colour to $\mathtt{COLOUR}$. |
| Recentre | $\mathtt{CENTRE}$ | Changes the object’s centre to $\mathtt{CENTRE}$. |
| Reshape | $\mathtt{SHAPE}$ | Changes the object’s shape to $\mathtt{SHAPE}$. |
| Move | $\mathtt{AMOUNT}$ | Shifts the object’s centre by $\mathtt{AMOUNT}$. |
| Gravity | $\mathtt{DIRECTION}$ | Shifts the object’s centre in $\mathtt{DIRECTION}$ until contact with another object or grid boundaries. |
| Grow | $\mathtt{DIRECTION}$ | Changes the object’s centre and shape by stretching the object in $\mathtt{DIRECTION}$ until contact with another object or grid boundaries. |
| Fill | — | Fills in the object’s shape. |
| Hollow | — | Hollows out the object’s shape. |
| Generate | $\mathtt{COLOUR}$, $\mathtt{CENTRE}$, $\mathtt{SHAPE}$ | Creates an object with colour $\mathtt{COLOUR}$ and shape $\mathtt{SHAPE}$ at centre $\mathtt{CENTRE}$. |

More formally, our solver produces a solution to each task as a program (see Fig. 6 for an example). This program can be instantiated to generate the correct transformation for each demonstration and, ideally, unseen valid input grids. We define a solution program as a set of rules. Each rule describes a different type of object-to-object mapping as an if-then statement expressing an action to be taken based on some condition. Conditions are logical compositions of criteria. Criteria reflect some state or feature of a particular object property. For example, the condition for a rule may be “ $\mathtt{COLOUR}~is~not~\text{grey}~\land~\mathtt{SHAPE}~is~\text{one pixel}$ ”, a conjunction of the criteria “ $\mathtt{COLOUR}~is~not~\text{grey}$ ” and “ $\mathtt{SHAPE}~is~\text{one pixel}$ ” based on the $\mathtt{COLOUR}$ and $\mathtt{SHAPE}$ properties of an object. Conditions may be vacuous, causing the associated action to apply to all objects. Actions are particular operations, taken from our DSL, to apply to each object satisfying the rule’s condition. Operations convert one input object into one output object in some structured way. Open-ended operations require parameters. Parameters determine how each instantiation of the operation should behave. For example, the action for a particular rule may be “Generate $(\mathtt{COLOUR}:\text{orange};~\mathtt{CENTRE}:\text{origin};~\mathtt{SHAPE}:3\times 3~\text{square})$ ”, representing the application of the Generate operation with the $\mathtt{COLOUR}$ parameter as orange, $\mathtt{CENTRE}$ parameter as the origin, and $\mathtt{SHAPE}$ parameter as a $3\times 3$ square.

$$
\boxed{\begin{aligned} &~1.~~~~\textbf{IF}~\underbrace{(\underbrace{\mathtt{COLOUR}}_{property}~is~not~\text{grey}~\land~\underbrace{\mathtt{SHAPE}~is~\text{one pixel}}_{criteria})}_{condition}~\ldots\\
&~~~~~~~~~~~~~\textbf{THEN}~\underbrace{(\underbrace{\textsc{Generate}}_{operation}(\mathtt{COLOUR}:\begin{cases}\text{blue}\rightarrow\text{pink},\\
\text{red}\rightarrow\text{orange},\\
\text{green}\rightarrow\text{cyan},\\
\text{yellow}\rightarrow\text{purple}\\
\end{cases};~\mathtt{CENTRE}:\text{same};~\underbrace{\mathtt{SHAPE}:3\times 3~\text{square}}_{parameter})}_{action})~\\
&~2.~~~~\underbrace{\textbf{IF}~(\mathtt{COLOUR}~is~\text{grey}~\land~\mathtt{SHAPE}~is~not~\text{one pixel})~\textbf{THEN}~(\textsc{Identity}())}_{rule}\\
\end{aligned}}
$$

Figure 6: One possible solution program for ARC-AGI task 54d9e175 (see Fig. 2).

### 3.2 Solution Synthesis

Our solver models human cognition throughout all stages of the solving process. For example, humans often start solving ARC-AGI tasks by sizing the output grids to be generated [^47] [^58]. As such, our solver begins by generating a hypothesis about how the grid size changes in the task (see Table 2). If the sizes of the input and output grid are the same in each demonstration, then the size of each test output grid is predicted to the be the same as the corresponding query; otherwise, if the sizes of all output grids across all demonstrations are the same, then the size of each test output grid is predicted to be the same as this constant size; otherwise, the output grid sizes are determined by the actions in the solution program.

Table 2: Our solver’s grid size change hypotheses.

| Hypothesis | Description |
| --- | --- |
| Identity | Each output grid is the same size as its corresponding input grid. |
| Constant | All output grids are of the same constant size. |
| Function | The size of the output grid is some function of the size of the input grid or its contents. |

We believe humans solve ARC-AGI using multiple types of logical reasoning. As such, we divide the rest of our solver’s solution generation process into three stages, each completed by one mode of reasoning: demonstration abduction, rule induction, and answer deduction. First, demonstration abduction generates an object definition and a set of simple steps to explain each demonstration (i.e., the objects and actions to produce each training output grid from its corresponding input grid). Simply understanding what is happening in each demonstration is necessary for further reasoning; abductive reasoning can find the most probable, usually the simplest, causal explanation for these observations. Second, rule induction generates broadly-applicable rules expressing when and how actions are applied, accounting for all observations. Finding the commonalities and distinctions underlying all observed action applications is necessary for true understanding; inductive reasoning can generalize these specific observations into rules. Third, answer deduction applies the rules generated to each query to produce a corresponding output grid. Whatever understanding of the demonstrations has been developed must be applied to the novel test input grids; deductive reasoning can draw logically sound inferences from these well-defined premises. Together, these three steps bridge multiple reasoning modes to model the entire ARC-AGI solving process.

#### 3.2.1 Demonstration Abduction

First, our solver abduces the objects and actions in the demonstrations. Any solver must conceptualize what it observes in the demonstrations before it can generalize these observations into rules. This requires determining, in parallel, what exactly constitutes an object in this particular task and what specific actions on the input objects can produce the correct set of output objects. Both the object hypothesis and action hypotheses should be as simple as possible.

Determining both an object hypothesis and action hypotheses creates a causality paradox: an object is defined as a group of pixels transformed cohesively, but actions are ill-defined without objects to transform. We solve this paradox by searching for action hypotheses based on evolving object proposals. Our solver applies an initial object hypothesis and abduces actions for these objects; only when this object hypothesis fails or yields overly complex actions are other object hypotheses considered.

We believe humans do the same. When first seeing a new ARC-AGI grid, System 1 produces initial ideas of what the objects are. This is part of the objectness core knowledge prior; humans have strong inductive biases, innate and learned, about what objects look like. These initial object proposals are often correct, but, when they fail, humans mobilize System 2 to carefully consider other object hypotheses. This top-down approach works because the space of possible object definitions is smaller than the space of possible actions. A bottom-up approach constructing objects out of individual pixels transformed cohesively, in addition to being cognitively implausible, fails because cohesive object-level actions are often not cohesive pixel-level actions. For example, a rotation transformation is simple at the object level but ill-defined at the pixel level.

Developing a sufficient set of action hypotheses requires explaining the presence of each output object in each demonstration by the application of some action to one of the corresponding input objects. Difficulty arises because usually each output object can be explained by multiple actions applied to multiple input objects. This is because our DSL has operations with inherently overlapping functionality as well as a Generate operation that can represent arbitrary transformations from any input object.

There are multiple valid ways to solve each ARC-AGI task. Consider ARC-AGI task a61ba2ce (see Fig. 4); solving this task can be conceptualized as moving each object into its corresponding corner on a smaller grid, colouring each corner of a smaller grid according to the colour of the corresponding object, and so on. For this task, our solver’s approach resembles the first description. In this view, the actions needed to complete each transformation, once the output grid is resized to $4\times 4$, are to move the upper-left-corner-shaped object to the upper left corner of the grid, move the upper-right-corner-shaped object to the upper right corner of the grid, and so on. However, even this conceptualization can be implemented as a program in multiple ways. Our DSL has both a Recentre operation for absolute motion and a Move operation for relative motion; each operation proves useful for certain tasks, but this task calls for absolute motion.

Consider the action that transforms the red object in the first demonstration; we can represent this as a $\textsc{Recentre}(\mathtt{CENTRE}\!:\!(1,1))$ or a $\textsc{Move}(\mathtt{AMOUNT}\!:\!(5.5,-1.5))$. Both are correct and equally valid, but abduction demands we choose the simpler explanation of this mapping. Here, we propose simplicity is determined by the relative frequency of the actions; in other words, recurring operations and parameters have greater explanatory power. The $\textsc{Move}(\mathtt{AMOUNT}\!:\!(5.5,-1.5))$ action explains only one of eight total output objects, but the $\textsc{Recentre}(\mathtt{CENTRE}\!:\!(1,1))$ action explains two—the upper right corner object in both demonstrations. In this sense, an action set containing $\textsc{Recentre}(\mathtt{CENTRE}\!:\!(-1,1))$, $\textsc{Recentre}(\mathtt{CENTRE}\!:\!(1,1))$, $\textsc{Recentre}(\mathtt{CENTRE}\!:\!(-1,-1))$, and $\textsc{Recentre}(\mathtt{CENTRE}\!:\!(1,-1))$ offers a simpler explanation of the observations than any action set based on Move could. The Recentre operation with possible parameters $(-1,1)$, $(1,1)$, $(-1,-1)$, and $(1,-1)$ accounts for all observations most cohesively.

Constructing the simplest action set explaining all demonstrations can be cast as solving the minimum hitting set problem: given a set $\mathcal{S}$ of $K$ partial action sets $\mathcal{A}_{k}$ taken from all possible actions $\mathcal{U}$, $\mathcal{S}=\{\mathcal{A}_{k}~|~\mathcal{A}_{k}\subseteq\mathcal{U},~k=1\ldots K\}$, find the action set $\mathcal{A}$ hitting each partial action set in $\mathcal{S}$, $\mathcal{A}\subseteq\mathcal{U}$ and $\mathcal{A}\cap\mathcal{A}_{k}\neq\emptyset~~\forall k=1\ldots K$, with minimal cost according to some function $f$. Here, the cost function penalizes each additional operation and parameter introduced; in other words, simple action sets use the least number of operations and distinct operation-parameter compositions. The hitting set problem is NP-Complete, but can be exactly solved quickly in practice.

The demonstration abduction process involves iteratively attempting object hypotheses and finding the simplest action set to explain all demonstrations. This requires intelligently traversing the object hypothesis space, inferring which input object explains each output object, and inferring what actions can perform each input-output object transform. In humans, these search processes are guided by System 1 heuristics. Here, leveraging VSAs, we model such heuristics as rapid computations on the object representations. These heuristics are fast and simple, with strong but imperfect accuracy. We propose VSA-based heuristics for each of these three tasks.

The first heuristic proposes an intelligent order to traverse the object hypothesis space. Instead of randomly trying object hypotheses, our solver first tries the most promising hypotheses. Fundamentally, a useful object hypothesis produces a simple grid representation while enabling simple input-output object transforms. Simple grid representations have as few objects as possible, and simple input-output object transforms are easiest when each output object is uniquely similar to one input object. This heuristic initially encodes objects according to all six hypotheses (see Table 3) and, for each output object, examines the distribution of the similarities to its possible corresponding input objects. We take the softmax of each similarity vector, padded with $0$ and $1$ values to ensure there are multiple elements, and consider the resultant vector’s maximum value. The higher this value, the fewer competing input objects; each additional input object will have some finite similarity to the output object, reducing the value of the maximum softmax score and penalizing object hypotheses that create too many objects. Additionally, the higher this value, the more similar one input object is compared to all others; input objects with close similarities have close softmax values, preventing one singular high softmax score and penalizing object hypotheses that produce ambiguous object mappings. Thus, higher values indicate better object hypotheses that enable clear transforms of few objects. Object hypotheses are ranked by their average maximum softmax value and considered by our solver in descending order.

Table 3: Our solver’s object hypotheses.

| Hypothesis | Description |
| --- | --- |
| 8-Connected | Each group of 8-connected pixels (i.e., pixels sharing an edge or corner) of the same colour is an object. |
| 4-Connected | Each group of 4-connected pixels (i.e., pixels sharing an edge) of the same colour is an object. |
| Vertical | Each group of vertically contiguous pixels of the same colour is an object. |
| Horizontal | Each group of horizontally contiguous pixels of the same colour is an object. |
| Colour | All pixels of the same colour, regardless of spatial contiguity, are an object. |
| Pixel | Each non-zero (coloured) pixel is its own object. |

The second heuristic narrows the search space of object-object correspondences. Instead of considering how each input object can transform into each output object, our solver only considers actions applied to the input object most similar to the output object. Dissimilar objects usually cannot be connected by simple transforms, so this heuristic eliminates nonsensical action hypotheses.

The third heuristic narrows the search space of actions. Instead of considering how each operation can transform the input object into the output object, our solver considers only those operations affecting the least similar property of the objects. Actions need only alter dissimilar object properties, so this heuristic removes useless operations from search.

After this stage (see Algorithm 1), our solver has specific hypotheses about what constitutes a task-relevant object and what actions permit simple transformations in all demonstrations.

Algorithm 1 Demonstration Abduction

Demonstrations $\mathcal{D}$

$hypotheses\leftarrow$ ObjectHypothesisHeuristic($\mathcal{D}$) $\triangleright$ Object hypotheses ranked by likelihood

for each hypothesis $\mathcal{H}$ in $hypotheses$ do

   $\mathcal{S}\leftarrow\emptyset$ $\triangleright$ Set of action sets explaining each output object

  for $(\mathbf{G}_{I_{d}},\mathbf{G}_{O_{d}})\in\mathcal{D}$ do

    $\mathcal{O}_{I_{d}}\leftarrow$ PerceiveObjects($\mathcal{H}$, $\mathbf{G}_{I_{d}}$) $\triangleright$ Input objects

    $\mathcal{O}_{O_{d}}\leftarrow$ PerceiveObjects($\mathcal{H}$, $\mathbf{G}_{O_{d}}$) $\triangleright$ Output objects

   for $O_{j}\in\mathcal{O}_{O_{d}}$ do

      $O_{i}\leftarrow$ ObjectCorrespondenceHeuristic($\mathcal{O}_{I_{d}}$, $O_{j}$) $\triangleright$ Corresponding input object

      $operations\leftarrow$ ObjectActionHeuristic($O_{i}$, $O_{j}$) $\triangleright$ Plausible operations for mapping

      $\mathcal{A}_{k}\leftarrow$ GetPartialActionSet($O_{i}$, $O_{j}$, $operations$) $\triangleright$ Action set for output object

      $\mathcal{S}\leftarrow\mathcal{S}~\cup~\{\mathcal{A}_{k}\}$      

   $\mathcal{A},cost\leftarrow$ MinimumHittingSet($\mathcal{S}$) $\triangleright$ Minimal action set and associated cost

  if $\mathcal{A}$ successful and $cost$ acceptable then

   return $\mathcal{H}$, $\mathcal{A}$   

#### 3.2.2 Rule Induction

Second, our solver induces general object-centric rules explaining the abduced actions. Finding isolated actions explaining each demonstration individually is important, but misses the task’s underlying phenomena. Solvers must develop some transferable understanding of the task because ARC-AGI requires generating the correct output grid for arbitrary valid input grids, demonstration or not. In our solver’s object-centric view, this means inferring, by both search and learning, what features of the input objects cause them to be transformed in each particular way. In other words, our solver must determine when and, possibly, how each operation should be applied.

Our solver’s solution program requires a rule for the conditional application of each operation in the action set. As such, our solver must develop a predictor modelling the condition for whether each operation applies and a predictor for each parameter of each operation. Both types of predictors are implemented as NNs because the high-dimensional distributed object representations produced by the VSA are amenable to neural learning. Although we do not use deep learning, these VSA representations act as deep-learned embeddings; the VSA’s inductive biases enable these NNs to better discover the abstractions underlying the conditions and learn the mappings determining the parameters.

Neural learning methods, especially over-parametrized NNs in the sample-few regime, are susceptible to overfitting and shortcut learning. Such NNs tend to get distracted by spurious correlations in the data and often fail to learn the simplest decision criteria. Thus, selecting the input features to our solver’s predictor NNs is important. In ARC-AGI tasks, both when and how an operation is applied usually depends on only one or two properties of the input object; the NNs modelling these rules should therefore be exposed only to the subset of relevant properties. Consider ARC-AGI task a61f2674 (see Fig. 4); when and how the Recolour operation applies depends only on an object’s shape property and not its colour or centre properties. Here, supplying the predictor NNs with objects’ colour and centre properties serves only to impede learning. Although each predictor NN models System 1, discovering which properties are important for each predictor NN is a search task performed by System 2. Fundamentally, useful properties generalize across demonstrations and useless ones do not.

We believe humans determine which properties are useful by carefully verifying their hypotheses on the demonstrations. Our solver models this process using cross-validation. For each demonstration, our solver, using a particular property hypothesis, trains a predictor NN on data from all other demonstrations and tests the predictor NN on data from the held out demonstration. The aggregate performance across all demonstrations measures the generalizability of the property hypothesis; the highest-scoring hypothesis is selected to learn the final condition. This approach works for many tasks, but not all; some tasks require all demonstrations together to fully understand the rules.

Our solver develops an operation predictor, $\mathcal{R}_{O}$, for each rule modelling the condition for whether the corresponding operation applies to an object. Each operation predictor is an NN mapping the representations of certain properties of an input object onto a probability value signifying whether this operation should be applied to this object. Training input data are the representations of the relevant properties of each input object, and the training labels are binary values indicating whether each input object was subject to this operation. When all labels are positive, our solver assumes the operation applies to all input objects and makes the condition vacuous; an NN is only used when the labels are not uniform.

The operation predictor is a single-layer NN with a learned nonlinearity trained by stochastic gradient descent (SGD). This means the NN learns a single weight vector to transform the representation of the relevant properties of an input object with via a dot product. Thus, the weight vector, if normalized, is itself a valid VSA vector. As such, we restrict the weight vector to unit length during training and learn parameters controlling the steepness and threshold of the decision nonlinearity. The learned nonlinearity enables the NN to match exact patterns for conditions based on discrete features and to model fuzzy abstractions for conditions based on high-level features. With this construction, the learned weight vector represents a prototype of objects subject to the operation. The NN works by computing the similarity between its learned prototype and the input object’s representation and applying a sigmoid nonlinearity mapping this similarity onto a probability, thereby predicting an input object as more likely to be subject to the relevant operation the more similar it is to the prototype (see Fig. 8). To accelerate training, we initialize the NN weight vector with the superposition of the input object representations weighted by outcome. We have experimented with more complex, deeper learning architectures, but this simple approach is the most interpretable and theoretically-founded.

#### 3.2.3 Answer Deduction

Third, our solver deduces the output grid for each query. Any solver must apply whatever understanding it has obtained about the demonstrations to the queries. This requires generating an output grid from scratch.

By our solution structure, this means sizing the output grid and predicting and executing the actions for each input object. Each input object is considered separately by each rule; if the object satisfies the rule’s learned condition, then the rule’s action, with parameters predicted as needed, is executed and the new object is added to the output grid. Objects may be subject to multiple rules, producing multiple output objects, and rules may be applied to multiple objects.

After this stage (see Algorithm 3), our solver has solved the task.

Algorithm 3 Answer Deduction

Object hypothesis $\mathcal{H}$, Program $\mathcal{P}$, Queries $\mathcal{Q}$

$results\leftarrow[~]$ $\triangleright$ Test output grids

for $\mathbf{G}_{I_{q}}\in\mathcal{Q}$ do

   $\mathcal{O}_{I_{q}}\leftarrow$ PerceiveObjects($\mathcal{H}$, $\mathbf{G}_{I_{q}}$) $\triangleright$ Input objects

   $\mathcal{O}_{O_{q}}\leftarrow\emptyset$ $\triangleright$ Output objects

  for $O_{i}\in\mathcal{O}_{I_{q}}$ do

   for $(operation,\mathcal{R}_{O},\mathcal{R}_{P})\in\mathcal{P}$ do

     if $\mathcal{R}_{O}(O_{i})\geq 50\%$ then $\triangleright$ Threshold is arbitrarily 50%

       $\mathcal{O}_{O_{q}}\leftarrow\mathcal{O}_{O_{q}}~\cup~$ ExecuteAction($O_{i}$, $operation$, $\mathcal{R}_{P}(O_{i})$)           

   $results\leftarrow results~\cup~\mathcal{O}_{O_{q}}$

return $results$

## 4 Results

We evaluate the performance of our solver on ARC-AGI and related benchmarks. Because our solver generates task solutions as neurosymbolic programs, we can probe performance by executing the solution program on both the training input grids and the testing input grids. When our solver can correctly solve the demonstrations, it has some understanding of the task; when our solver can correctly solve the queries, it has a true, generalizable understanding of the task. Therefore, demonstration performance indicates whether our solver can conceptualize the objects and actions underlying task transformations, but query performance reveals whether our solver can extract and apply the underlying patterns. We report both accuracy, the proportion of all demonstrations or queries in the dataset solved correctly, and task accuracy, the proportion of tasks for which all associated demonstrations or queries were solved correctly. The main performance metric, except where noted, is query task accuracy. All experiments use representations with $N\!=\!4096$ -dimensional vectors.

### 4.1 Main Benchmarks

Our solver scores $10.8\%$ on ARC-AGI-1-Train and $3.0\%$ on ARC-AGI-1-Eval (see Table 4). We report performance on the training splits in addition to the evaluation splits because they are more approachable (note that the training splits are not used for training; our solver does not require any pre-training). As expected, our solver performs better on ARC-AGI-1 than on ARC-AGI-2 and performs better on training splits than evaluation splits.

Table 4: Our solver’s performance on ARC-AGI. We report performance on each benchmark split separately.

<table><thead><tr><th rowspan="2">Benchmark Split</th><th colspan="2">Demonstrations</th><th colspan="2">Queries</th></tr><tr><th>Acc. (<math><semantics><mo>%</mo> <annotation>\%</annotation></semantics></math>)</th><th>Task Acc. (<math><semantics><mo>%</mo> <annotation>\%</annotation></semantics></math>)</th><th>Acc. (<math><semantics><mo>%</mo> <annotation>\%</annotation></semantics></math>)</th><th>Task Acc. (<math><semantics><mo>%</mo> <annotation>\%</annotation></semantics></math>)</th></tr></thead><tbody><tr><th>ARC-AGI-1-Train (<math><semantics><mrow><mi>n</mi> <mo>=</mo> <mn>400</mn></mrow> <annotation>n=400</annotation></semantics></math>)</th><td><math><semantics><mn>57.5</mn> <annotation>57.5</annotation></semantics></math></td><td><math><semantics><mn>48.8</mn> <annotation>48.8</annotation></semantics></math></td><td><math><semantics><mn>12.7</mn> <annotation>12.7</annotation></semantics></math></td><td><math><semantics><mn>10.8</mn> <annotation>10.8</annotation></semantics></math></td></tr><tr><th>ARC-AGI-1-Eval (<math><semantics><mrow><mi>n</mi> <mo>=</mo> <mn>400</mn></mrow> <annotation>n=400</annotation></semantics></math>)</th><td><math><semantics><mn>43.6</mn> <annotation>43.6</annotation></semantics></math></td><td><math><semantics><mn>33.5</mn> <annotation>33.5</annotation></semantics></math></td><td><math><semantics><mn>3.3</mn> <annotation>3.3</annotation></semantics></math></td><td><math><semantics><mn>3.0</mn> <annotation>3.0</annotation></semantics></math></td></tr><tr><th>ARC-AGI-2-Train (<math><semantics><mrow><mi>n</mi> <mo>=</mo> <mn>1000</mn></mrow> <annotation>n=1000</annotation></semantics></math>)</th><td><math><semantics><mn>46.7</mn> <annotation>46.7</annotation></semantics></math></td><td><math><semantics><mn>35.9</mn> <annotation>35.9</annotation></semantics></math></td><td><math><semantics><mn>6.5</mn> <annotation>6.5</annotation></semantics></math></td><td><math><semantics><mn>5.8</mn> <annotation>5.8</annotation></semantics></math></td></tr><tr><th>ARC-AGI-2-Eval (<math><semantics><mrow><mi>n</mi> <mo>=</mo> <mn>120</mn></mrow> <annotation>n=120</annotation></semantics></math>)</th><td><math><semantics><mn>19.5</mn> <annotation>19.5</annotation></semantics></math></td><td><math><semantics><mn>11.7</mn> <annotation>11.7</annotation></semantics></math></td><td><math><semantics><mn>0.0</mn> <annotation>0.0</annotation></semantics></math></td><td><math><semantics><mn>0.0</mn> <annotation>0.0</annotation></semantics></math></td></tr></tbody></table>

### 4.2 Related Benchmarks

Because of ARC-AGI’s extreme difficulty, many simpler versions capturing certain important features of the benchmark have been made. We also evaluate the performance of our solver on some of these benchmarks.

#### 4.2.1 Sort-of-ARC

Sort-of-ARC [^3] is a collection of 1000 restricted ARC-AGI-like tasks. Each task comprises $|\mathcal{D}|=5$ demonstrations and $|\mathcal{Q}|=1$ query; all grids are $20\times 20$ and contain three non-overlapping objects of random colour, location, and $3\times 3$ shape. The solution is always to move all objects matching a randomly-chosen colour or shape by one pixel in one of the four cardinal directions and leave all other objects unchanged. Although simple, Sort-of-ARC directly tests condition-action learning.

Our solver scores $94.5\%$ on Sort-of-ARC (see Table 5). Notably, our solver performs better on tasks with a colour-based condition than those with a shape-based condition. This is because different colour representations have near-zero similarity but different shape representations may have very high similarity. As a result, without diverse negative examples in the demonstrations, the operation predictors tend to over-generalize shape abstractions (e.g., our solver may move U-shaped objects when the solution is to move all O-shaped objects and the demonstrations lack U-shaped or similarly-shaped objects). This generalization capacity enables our solver to solve more complex tasks, but sometimes poses challenges for simple tasks requiring strict rules.

Table 5: Our solver’s performance on Sort-of-ARC [^3]. We report performance on tasks with a colour-based condition and tasks with a shape-based condition separately. Our version of the dataset was randomly generated according to [^3] ’s [^3] description.

<table><thead><tr><th rowspan="2">Benchmark Split</th><th colspan="2">Demonstrations</th><th colspan="2">Queries</th></tr><tr><th>Acc. (<math><semantics><mo>%</mo> <annotation>\%</annotation></semantics></math>)</th><th>Task Acc. (<math><semantics><mo>%</mo> <annotation>\%</annotation></semantics></math>)</th><th>Acc. (<math><semantics><mo>%</mo> <annotation>\%</annotation></semantics></math>)</th><th>Task Acc. (<math><semantics><mo>%</mo> <annotation>\%</annotation></semantics></math>)</th></tr></thead><tbody><tr><td>All (<math><semantics><mrow><mi>n</mi> <mo>=</mo> <mn>1000</mn></mrow> <annotation>n=1000</annotation></semantics></math>)</td><td><math><semantics><mn>99.7</mn> <annotation>99.7</annotation></semantics></math></td><td><math><semantics><mn>99.4</mn> <annotation>99.4</annotation></semantics></math></td><td>—</td><td><math><semantics><mn>94.5</mn> <annotation>94.5</annotation></semantics></math></td></tr><tr><td>   Colour (<math><semantics><mrow><mi>n</mi> <mo>=</mo> <mn>500</mn></mrow> <annotation>n=500</annotation></semantics></math>)</td><td><math><semantics><mn>100.0</mn> <annotation>100.0</annotation></semantics></math></td><td><math><semantics><mn>100.0</mn> <annotation>100.0</annotation></semantics></math></td><td>—</td><td><math><semantics><mn>100.0</mn> <annotation>100.0</annotation></semantics></math></td></tr><tr><td>   Shape (<math><semantics><mrow><mi>n</mi> <mo>=</mo> <mn>500</mn></mrow> <annotation>n=500</annotation></semantics></math>)</td><td><math><semantics><mn>99.4</mn> <annotation>99.4</annotation></semantics></math></td><td><math><semantics><mn>98.8</mn> <annotation>98.8</annotation></semantics></math></td><td>—</td><td><math><semantics><mn>89.0</mn> <annotation>89.0</annotation></semantics></math></td></tr></tbody></table>

#### 4.2.2 1D-ARC

1D-ARC [^109] is a collection of 900 one-dimensional ARC-AGI-like tasks. Each task comprises $|\mathcal{D}|=3$ demonstrations and $|\mathcal{Q}|=1$ query; all grids are a single row of pixels. Tasks are divided into 18 types, such as “Move Dynamic” and “Recolour By Size”, each capturing some important operation in ARC-AGI. Each type contains 50 random instantiations of the operation. Designed to probe how LLMs solve ARC-AGI, 1D-ARC thoroughly tests the application of particular operations.

Our solver scores $83.1\%$ on 1D-ARC (see Table 6). Our solver can consistently solve tasks involving operations within its DSL, such as those requiring recolouring (e.g., Recolour by Odd Even and Recolour by Size), recentring (e.g., Move 1, Move Dynamic, and Scaling), and reshaping (e.g., Fill, Hollow, and Pattern Copy). But, our solver falters on tasks requiring operations outside of its DSL, such as reflecting (e.g., Flip and Mirror). Still, our solver vastly outperforms GPT-4 [^75] on this benchmark at a tiny fraction of the computational cost.

Table 6: Our solver’s performance on 1D-ARC [^109]. We report performance on each task type separately. We compare our results to results obtained by directly prompting GPT-4 [^75], as reported in the original work [^109].
**Table intentionally ommited after export**

#### 4.2.3 KidsARC

KidsARC [^76] is a collection of 17 single-demonstration ARC-AGI-like tasks. Each task comprises $|\mathcal{D}|=1$ demonstration and $|\mathcal{Q}|=1$ query; all grids in the 9 simple tasks are $3\times 3$, and all grids in the 8 concept tasks are $5\times 5$. The 9 simple tasks invoke elementary concepts and can be presented as $A:B::C:D$ or as $A:C::B:D$; the 8 concept tasks invoke higher-level abstractions. Designed to understand how children approach ARC-AGI, KidsARC uniquely tests extreme generalization.

Our solver scores $57.7\%$ on KidsARC (see Table 7). Our solver can abduce the correct operations (e.g., recolouring, recentring, and reshaping) and even learn useful abstractions from a single demonstration (e.g., objects near the top of the grid and dominant versus noise objects). But, our solver falters when extreme generalization of a high-level concept is needed from a single example (e.g., objects between other objects and objects with the majority colour). Again, our solver outperforms many LLMs on this benchmark, still at a tiny fraction of the computational cost.

Table 7: Our solver’s performance on KidsARC [^76]. We report performance on simple and concept tasks separately. We compare our results to aggregate results obtained by directly prompting various LLMs, including GPT-4 [^75], as reported in the original work [^76].

<table><thead><tr><th rowspan="2">Benchmark Split</th><th colspan="2">Demonstrations</th><th colspan="2">Queries</th><th rowspan="2">LLMs</th></tr><tr><th>Acc. (<math><semantics><mo>%</mo> <annotation>\%</annotation></semantics></math>)</th><th>Task Acc. (<math><semantics><mo>%</mo> <annotation>\%</annotation></semantics></math>)</th><th>Acc. (<math><semantics><mo>%</mo> <annotation>\%</annotation></semantics></math>)</th><th>Task Acc. (<math><semantics><mo>%</mo> <annotation>\%</annotation></semantics></math>)</th></tr></thead><tbody><tr><th>All (<math><semantics><mrow><mi>n</mi> <mo>=</mo> <mn>26</mn></mrow> <annotation>n=26</annotation></semantics></math>)</th><td>—</td><td><math><semantics><mn>92.3</mn> <annotation>92.3</annotation></semantics></math></td><td>—</td><td><math><semantics><mn>57.7</mn> <annotation>57.7</annotation></semantics></math></td><td>—</td></tr><tr><th>   Simple (<math><semantics><mrow><mi>n</mi> <mo>=</mo> <mn>18</mn></mrow> <annotation>n=18</annotation></semantics></math>)</th><td>—</td><td><math><semantics><mn>94.4</mn> <annotation>94.4</annotation></semantics></math></td><td>—</td><td><math><semantics><mn>66.7</mn> <annotation>\mathbf{66.7}</annotation></semantics></math></td><td><math><semantics><mn>33.2</mn> <annotation>33.2</annotation></semantics></math></td></tr><tr><th>   Concept (<math><semantics><mrow><mi>n</mi> <mo>=</mo> <mn>8</mn></mrow> <annotation>n=8</annotation></semantics></math>)</th><td>—</td><td><math><semantics><mn>87.5</mn> <annotation>87.5</annotation></semantics></math></td><td>—</td><td><math><semantics><mn>37.5</mn> <annotation>\mathbf{37.5}</annotation></semantics></math></td><td><math><semantics><mn>11.9</mn> <annotation>11.9</annotation></semantics></math></td></tr></tbody></table>

#### 4.2.4 ConceptARC

ConceptARC [^69] is a collection of 176 complex ARC-AGI-like tasks. Each task comprises a variable number of demonstrations and $|\mathcal{Q}|=3$ queries; like ARC-AGI, grid sizes are variable. Tasks are divided into 16 concept groups, such as “Above and Below” and “Same and Different”, each capturing some important abstraction in ARC-AGI. Each group contains a minimal example alongside 10 carefully-designed instantiations of the concept. Designed to probe how completely ARC-AGI solvers understand the concepts they use, ConceptARC thoroughly tests the comprehension of particular concepts.

Our solver scores $20.5\%$ on ConceptARC (see Table 8). Our solver performs well on spatial concepts (e.g., Above and Below, Filled and Not Filled, Horizontal and Vertical, and Top and Bottom 2D) because of the inductive biases provided by SSP representations. But, our solver falters on tasks requiring interpolative object perception (e.g., Clean Up, Complete Shape, Copy, and Top and Bottom 3D) and advanced explicit reasoning (e.g., Count, Order, and Same and Different). Still, our solver performs comparably to GPT-4 [^75] on this benchmark, again at a tiny fraction of the computational cost.

Table 8: Our solver’s performance on ConceptARC [^69]. We report performance on the minimal tasks as well as each task type separately. We compare our results to results obtained by directly prompting GPT-4 [^75], as reported in the original work [^69]. Note that ConceptARC measures performance as the proportion of queries solved correctly, not the proportion of tasks with all queries solved correctly.
**Table intentionally ommited after export**


#### 4.2.5 MiniARC

MiniARC [^50] is a collection of 149 miniature ARC-AGI-like tasks. Each task comprises a variable number of demonstrations and $|\mathcal{Q}|=1$ query; all grids are $5\times 5$. Like ARC-AGI, task content is unconstrained. Designed to simplify ARC-AGI without compromising its core tenets, MiniARC tests reasoning without grid size effects.

Our solver scores $13.4\%$ on MiniARC (see Table 9). Notably, our solver can solve multiple tasks requiring conceptualizing and implementing arbitrary object mappings (e.g., tasks l6aftgp22mlspnm1zxb, l6acypud56b4m1z5409, and l6afcchh0wfew0rhswzq).

Table 9: Our solver’s performance on MiniARC [^50].

<table><tbody><tr><td rowspan="2">Benchmark Split</td><td colspan="2">Demonstrations</td><td colspan="2">Queries</td></tr><tr><td>Acc. (<math><semantics><mo>%</mo> <annotation>\%</annotation></semantics></math>)</td><td>Task Acc. (<math><semantics><mo>%</mo> <annotation>\%</annotation></semantics></math>)</td><td>Acc. (<math><semantics><mo>%</mo> <annotation>\%</annotation></semantics></math>)</td><td>Task Acc. (<math><semantics><mo>%</mo> <annotation>\%</annotation></semantics></math>)</td></tr><tr><td>All (<math><semantics><mrow><mi>n</mi> <mo>=</mo> <mn>149</mn></mrow> <annotation>n=149</annotation></semantics></math>)</td><td><math><semantics><mn>69.9</mn> <annotation>69.9</annotation></semantics></math></td><td><math><semantics><mn>55.0</mn> <annotation>55.0</annotation></semantics></math></td><td>—</td><td><math><semantics><mn>13.4</mn> <annotation>13.4</annotation></semantics></math></td></tr></tbody></table>

## 5 Discussion

Our solver structures solutions as a specific definition of task-relevant objects and a specific program comprising a set of rules describing how objects behave. Objects are represented by high-dimensional vectors encoding their colour, centre, and shape. Program rules are if-then statements that conditionally execute standard actions on certain objects based on object features. This paradigm is flexible enough to express natural solutions to many ARC-AGI tasks, but simple enough for synthesis to remain tractable.

Our solver generates solutions with a heuristic-guided search process and a neurosymbolic learning architecture. First, our solver abduces the simplest objects and actions explaining the demonstrations. Second, our solver generalizes its observations into rules applicable to any valid input grid. Third, our solver applies these rules to answer all queries. This process combines the strengths of symbolic and connectionist AI, leveraging VSA representations for robustness and interpretability in search and learning.

### 5.1 Strengths

Any model of human intelligence must be efficient and interpretable. For ARC-AGI, this is true of both the solution synthesis process and the synthesized solution itself.

Human intelligence is efficient. The brain’s power consumption is much lower than that of modern computers, and humans effortlessly solve ARC-AGI. Because our solver uses neither brute force search nor large NNs, its computational demands are relatively small. Our solver considers few solution candidates in depth because simple and cheap heuristics are used to prune the search space, minimizing wasted energy on unnecessary reasoning. Overall, our solver is efficient.

Human intelligence is interpretable. When prompted, humans can detail both the problem solving steps they took and the solution they arrived at. Because intermediate hypotheses are few, all steps taken by our solver are traceable and intentional. The solution programs generated are compact and integrate directly interpretable symbolic expressions with interpretable NNs implementing simple operations on structured data. Overall, our solver is interpretable.

Our methods are applicable to other problems beyond ARC-AGI. We use general VSA representations capable of implementing many features of cognition. For example, Spaun [^16] [^28], the world’s largest functional brain model, uses similar representations to closely model several different parts of the brain and perform a wide array of cognitive tasks. Additionally, we apply general principles learned from human psychology to motivate and structure our solver. For example, we explicitly model the interplay of System 1 intuitions and System 2 reasoning [^48] in a unified substrate. Our particular implementation and architecture is ARC-AGI-specific, but the underlying principles and tools are general; similar VSA-based approaches may be taken to solve other problems requiring System 1, System 2, or both. Fundamentally, VSA-powered neurosymbolic models represent a universal approach to cognitive modelling and AI.

Our approach furthers progress on ARC-AGI. Chollet, the creator of ARC-AGI, has argued the proper solution to ARC-AGI may be neurosymbolic [^11], involving both symbolic program synthesis and connectionist deep learning. VSAs offer a new means of bridging symbolic and connectionist AI for ARC-AGI. To the best of our knowledge, our solver is the first to apply VSAs to ARC-AGI, making our approach unique and novel. Additionally, because we use cognitively and biologically plausible representations in a psychologically-motivated framework free from brute force search and opaque deep NNs, we believe our solver is the most cognitively plausible one yet.

Our solver owes its success to the same strengths of VSAs that make them so effective for other cognitive tasks. First, VSAs bridge symbolicism and connectionism, combining the benefits of both. In a single unified framework, VSAs enable both heuristic-guided search with explicit reasoning and sample-efficient neural learning. Second, VSAs capture many inductive biases humans have. In this sense, VSAs effectively model human intelligence, which remains the best ARC-AGI solver. The required numbers and geometry core knowledge priors are implicitly provided by SSP representations, and objectness is explicitly modelled by our solver in other ways (we leave goal-directedness for future work).

### 5.2 Limitations

Our solver is primarily limited by its inability to generate new grid size change, object, and action hypotheses on-the-fly. The demonstration abduction stage is only capable of applying existing notions of what grid sizes, objects, and actions may be taken from finite sets. This is permissible with a sufficiently-sized hypothesis set because all ARC-AGI tasks must be derived from the core knowledge priors, but our solver’s sets are currently not large enough. Furthermore, we do not address the fundamental problem of how these conceptualizations came to be; instead, we assume they have already been acquired. Maintaining cognitive plausibility, we model the process by which humans recombine existing knowledge, represented as inductive biases built into the VSAs and symbolic programs, to solve new tasks. In this sense, our solver is not artificial general intelligence because it uses a domain-specific language; a true AGI solution must be DSL-open, discovering and applying novel transformations on-the-fly.

Other limitations are more pragmatic. First, our solver cannot apply chained operations to a single persistent input object. This simplifies solution synthesis by narrowing the search space of object-to-object transforms at the cost of preventing arbitrary compositionality of operations, but the Generate operation can compose Recolour, Recentre, and Shape operations. Second, our solver cannot apply multiple instantiations of one operation to the same input object. This simplifies program representation by restricting the program to one rule for each operation at the cost of solving certain tasks. Third, our solver can conceptualize neither many-to-one nor many-to-many object mappings. This simplifies solution synthesis also by narrowing the search space of object-to-object transforms at the cost of solving tasks requiring comparison between objects, but creative object hypotheses can often circumvent this. Fourth, our solver cannot conceptualize multi-coloured objects. This simplifies object representation by allowing separate colour, centre, and shape properties at the cost of solving certain tasks, but creative actions can often circumvent this. Fifth, our solver cannot conceptualize conditions of high-level object properties. This simplifies object representation and maintains cognitive plausibility at the cost of solving certain tasks, but these properties, such as exact size and symmetry, can often be well-approximated by other object properties, such as shape. All of these limitations are the subject of ongoing work.

## 6 Conclusion

We presented a novel, neurosymbolic, cognitively plausible ARC-AGI solver. Our solver works by VSA-enabled object-centric program synthesis. Grids are represented as collections of objects encoded with a VSA, and solutions are represented as programs comprising a set of rules implemented with a VSA. Solution synthesis uses VSAs to bridge symbolic and connectionist AI; modelling human intelligence, VSA-powered System-1-style heuristics guide a System-2-style intentional search process incorporating abductive, inductive, and deductive reasoning. VSA representations enable sample-efficient neural learning of rules, integrating automated abstraction discovery into the reasoning process. The solution generation process is both efficient and interpretable, maintaining cognitive plausibility. Our solver shows some initial success, scoring $10.8\%$ on ARC-AGI-1-Train and $3.0\%$ on ARC-AGI-1-Eval. Although these results are not state-of-the-art, they indicate VSAs hold promise for ARC-AGI and warrant further investigation. Importantly, our approach is unique; we believe we are the first to apply VSAs to ARC-AGI and, in doing so, have developed the most cognitively plausible ARC-AGI solver yet.