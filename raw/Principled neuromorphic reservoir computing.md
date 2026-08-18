---
title: "Principled neuromorphic reservoir computing"
source: "https://www.nature.com/articles/s41467-025-55832-y"
author:
  - "[[Denis Kleyko]]"
  - "[[Christopher J. Kymn]]"
  - "[[Anthony Thomas]]"
  - "[[Bruno A. Olshausen]]"
  - "[[Friedrich T. Sommer]]"
  - "[[E. Paxon Frady]]"
published: 2025-01-14
created: 2026-06-26
description: "Reservoir computing advances the intriguing idea that a nonlinear recurrent neural circuit—the reservoir—can encode spatio-temporal input signals to enable efficient ways to perform tasks like classification or regression. However, recently the idea of a monolithic reservoir network that simultaneously buffers input signals and expands them into nonlinear features has been challenged. A representation scheme in which memory buffer and expansion into higher-order polynomial features can be configured separately has been shown to significantly outperform traditional reservoir computing in prediction of multivariate time-series. Here we propose a configurable neuromorphic representation scheme that provides competitive performance on prediction, but with significantly better scaling properties than directly materializing higher-order features as in prior work. Our approach combines the use of randomized representations from traditional reservoir computing with mathematical principles for approximating polynomial kernels via such representations. While the memory buffer can be realized with standard reservoir networks, computing higher-order features requires networks of ‘Sigma-Pi’ neurons, i.e., neurons that enable both summation as well as multiplication of inputs. Finally, we provide an implementation of the memory buffer and Sigma-Pi networks on Loihi 2, an existing neuromorphic hardware platform. Reservoir computing designs recurrent networks that simultaneously buffer inputs and form nonlinear features. Here, authors propose a configurable scheme with better scaling where memory buffer and nonlinear features are in separate circuits. It can be efficiently implemented in neuromorphic hardware."
tags:
  - "clippings"
---
## Abstract

Reservoir computing advances the intriguing idea that a nonlinear recurrent neural circuit—the reservoir—can encode spatio-temporal input signals to enable efficient ways to perform tasks like classification or regression. However, recently the idea of a monolithic reservoir network that simultaneously buffers input signals and expands them into nonlinear features has been challenged. A representation scheme in which memory buffer and expansion into higher-order polynomial features can be configured separately has been shown to significantly outperform traditional reservoir computing in prediction of multivariate time-series. Here we propose a configurable neuromorphic representation scheme that provides competitive performance on prediction, but with significantly better scaling properties than directly materializing higher-order features as in prior work. Our approach combines the use of randomized representations from traditional reservoir computing with mathematical principles for approximating polynomial kernels via such representations. While the memory buffer can be realized with standard reservoir networks, computing higher-order features requires networks of ‘Sigma-Pi’ neurons, i.e., neurons that enable both summation as well as multiplication of inputs. Finally, we provide an implementation of the memory buffer and Sigma-Pi networks on Loihi 2, an existing neuromorphic hardware platform.

## Introduction

Reservoir computing is a paradigm for computing with recurrent neural circuits that are inspired by observations in neuroscience [^1] [^2] and has yielded efficient realizations of recurrent neural networks, an architecture ubiquitous in technical applications for processing multivariate time-series. Reservoir computing uses a neural dynamical system, the so-called “reservoir,” to map a time-series into a pattern in a high-dimensional state space, which is then fed into a one-layer neural network [^3] [^4]. The one-layer network can be trained in a supervised fashion to perform tasks, such as classification or regression of time-series. The reservoir is thought to serve two purposes (Fig. [1](https://www.nature.com/articles/s41467-025-55832-y#Fig1) a): First, it is a memory buffer for the input signals, often a fading memory buffer if emphasis on the recent input history is desired. For buffering it is crucial that the dynamics of the reservoir are fixed. For example, the standard strategy is to use a recurrent network with fixed random connections [^4] [^5]. Second, nonlinearities in the reservoir dynamics can enable rich feature spaces [^6], including nonlinear functions of the input signals, potentially leading to separability and generalization unachievable on the original signals.

![Fig. 1: Overview of three different representation schemes.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs41467-025-55832-y/MediaObjects/41467_2025_55832_Fig1_HTML.png?as=webp)

Fig. 1: Overview of three different representation schemes.

In practice, however, the ability of reservoir networks to form rich feature spaces could be limited. For example, reservoir networks with common saturating neural activation functions mainly cause memory fading, and the resulting feature space still closely resembles those of linear recurrent networks [^7] [^8] [^9]. Reservoir networks containing more neurobiological details, such as spiking neurons [^1], or synaptic connections with short-term plasticity as additional dynamic variables [^10], can create richer representations. However, the richness is difficult to adjust for serving a particular computational task in the best possible way. Illustrating these limitations of traditional reservoir computing, it has been recently shown [^11] [^12] that a representation scheme that computes tensor products between time-delayed states of the input signals (Fig. [1](https://www.nature.com/articles/s41467-025-55832-y#Fig1) b) can empirically outperform traditional reservoir networks on an important task of predicting dynamical systems.

In light of these limitations, here we investigate principled, configurable, and efficient ways to implement reservoir computing with nonlinear features on neuromorphic hardware. We propose a bipartite approach combining two generic neural circuits (Fig. [1](https://www.nature.com/articles/s41467-025-55832-y#Fig1) c): traditional reservoir networks for forming a memory buffer, and novel Sigma-Pi networks [^13] [^14] for computing nonlinear features. We theoretically characterize the two essential operations for jointly representing feature spaces – concatenation and tensor product – and show that each operation results in a different similarity structure between the constructed representations. We formulate a concrete scheme based on randomized distributed representations for multivariate time-series prediction and demonstrate these networks implemented on the neuromorphic chip Loihi 2 [^15]. The proposed approach, which builds on ideas from vector symbolic architectures [^16] [^17] [^18] and randomized kernel approximation [^19] [^20], can form representations with approximately the same similarity structure as concatenation or tensor product, but the dimensionality of the representation remains fixed. We evaluate the novel randomized distributed representations on the prediction of chaotic dynamical systems and show that often the same quality of predictions can be achieved with representations that need fewer dimensions than in the original, explicit approach [^12].

## Results

### Joint representations formed by concatenation or tensor product

In order to make predictions from time-series, one must create a representation that includes some history of the input signals as well as relevant, nonlinear features. A classic approach to represent the history of a trajectory is to form a memory buffer by concatenating *d* -dimensional state vectors observed at different time points [^21], e.g.: ${{{{\bf{V}}}}}_{{{{\rm{C}}}}}^{(i)}={{{\bf{X}}}}(i-1)\oplus {{{\bf{X}}}}(i)=[{X}_{1}(i-1),\ldots,{X}_{d}(i-1),{X}_{1}(i),\ldots,{X}_{d}(i)]$. In this resulting feature space, the inner product between the representations of two trajectories formed by concatenation equals the *sum* of inner products between the state vectors at the single time points:

 $\langle \mathbf{V}_{C}^{\left(i\right)} , \mathbf{V}_{C}^{\left(j\right)} \rangle = \sum_{d} X_{d} \left(i - 1\right) X_{d} \left(j - 1\right) + \sum_{d} X_{d} \left(i\right) X_{d} \left(j\right) = \langle \mathbf{X} \left(i - 1\right) , \mathbf{X} \left(j - 1\right) \rangle + \langle \mathbf{X} \left(i\right) , \mathbf{X} \left(j\right) \rangle .$ 
$$
\begin{aligned}
\left\langle {{{{\bf{V}}}}}_{{{{\rm{C}}}}}^{(i)},{{{{\bf{V}}}}}_{{{{\rm{C}}}}}^{(j)}\right\rangle=	{\sum}_{d}{X}_{d}(i-1){X}_{d}(j-1)+{\sum}_{d}{X}_{d}(i){X}_{d}(j)=\langle {{{\bf{X}}}}(i-1),{{{\bf{X}}}}(j-1)\rangle \\ 	+\langle {{{\bf{X}}}}(i),{{{\bf{X}}}}(j)\rangle .
\end{aligned}
$$

An alternative is to combine state vectors at different time points in a trajectory by the tensor product. The resulting representation contains products of the components of the original state vectors, i.e., nonlinear higher-order features, e.g.: ${{{{\bf{V}}}}}_{{{{\rm{T}}}}}^{(i)}={{{\bf{X}}}}(i-1)\otimes {{{\bf{X}}}}(i)=[{X}_{1}(i-1){X}_{1}(i),{X}_{1}(i-1){X}_{2}(i),\ldots,{X}_{d}(i-1){X}_{d}(i)]$. The inner product between a pair of tensor products of trajectories, the Frobenius inner product, corresponds to the *product* of inner products between the observable states at each point in time:

 $\langle \mathbf{V}_{T}^{\left(i\right)} , \mathbf{V}_{T}^{\left(j\right)} \rangle = \sum_{d , d^{′}} X_{d} \left(i - 1\right) X_{d^{′}} \left(i\right) X_{d} \left(j - 1\right) X_{d^{′}} \left(j\right) = \langle \mathbf{X} \left(i - 1\right) , \mathbf{X} \left(j - 1\right) \rangle \cdot \langle \mathbf{X} \left(i\right) , \mathbf{X} \left(j\right) \rangle .$ 
$$
\begin{aligned}
\left\langle {{{{\bf{V}}}}}_{{{{\rm{T}}}}}^{(i)},{{{{\bf{V}}}}}_{{{{\rm{T}}}}}^{(j)}\right\rangle	={\sum}_{d,{d}^{{\prime} }}{X}_{d}(i-1){X}_{{d}^{{\prime} }}(i){X}_{d}(j-1){X}_{{d}^{{\prime} }}(j) \\ 	=\langle {{{\bf{X}}}}(i-1),{{{\bf{X}}}}(j-1)\rangle \cdot \langle {{{\bf{X}}}}(i),{{{\bf{X}}}}(j)\rangle .
\end{aligned}
$$

The similarity measured by the inner product is qualitatively different for the two types of representations. With concatenation of the input signals, a pair of trajectories has non-negligible similarity even if the signals coincide in just a single time point. Conversely, the tensor product forms polynomial products of the input signals [^22], and as a result, the similarity between trajectories is high only if they coincide in all time points. Thus, for solving concrete computational tasks it is important to flexibly combine the two operations on the input signals into the final feature space.

### Representing trajectories with concatenation and tensor product

Any concrete representation scheme to encode multivariate time-series by combining concatenation and the tensor product is a task-specific design choice. Here we formalize such a representation scheme recently proposed for the efficient prediction of chaotic dynamical systems [^12]. A state at a single time point *i* is described by a *d* -dimensional vector **X** (*i*). A trajectory includes *k* time points. The entire trajectory is represented by a *d* *k* -dimensional vector, a concatenation of the *k*   *d* -dimensional state vectors. To generate higher-order features, the tensor product is applied to each trajectory representation with itself. To form *t* th-order features the tensor product must be applied *t*  − 1 times. Finally, concatenation is applied again to combine the features of different orders into a single vector. The representation **G** for trajectories resulting from this representation scheme can be written as:

 $\mathbf{G} = \oplus_{t \in \mathcal{T}} \left(\mathtt{vec} \left(\otimes^{t} \left(\oplus_{l = 1}^{k} \mathbf{X} \left(\mathcal{M}_{l}\right)\right)\right)\right) \in \mathbb{R}^{\sum_{t \in \mathcal{T}} \begin{pmatrix} d k + t \\ t + 1 \end{pmatrix}}$ 
$$
{{{{\mathbf{G}}}}}={\bigoplus}_{t \in {{{\mathcal{T}}}}} \left( {{\texttt{vec}}} \left( {\bigotimes}^{t} \left( {\bigoplus}_{l=1}^{k} {{{{\mathbf{X}}}}}({{{{\mathcal{M}}}}}_l) \right) \right) \right) \in {{\mathbb{R}}}^{{\sum}_{t \in {{{{\mathcal{T}}}}}} \left(\begin{array}{c}{dk+t}\\ {t+1}\end{array}\right)}
$$

(1)

where ${{{\mathcal{M}}}}$ is a *k* -tuple containing relative indices of time points in the trajectory to be concatenated (⨁), ${{{\bf{X}}}}({{{{\mathcal{M}}}}}_{l})$ is the *d* -dimensional state at the time point ${{{{\mathcal{M}}}}}_{l}$. The order of tensor product (⨂ <sup><i>t</i></sup>) features is controlled by set ${{{\mathcal{T}}}}\subset \{0,\ldots,t,\ldots,n-1\}$ where each integer $t+1\in {{{\mathcal{T}}}}$ describes a desired order of polynomial features.

We will refer to Eq. ([1](https://www.nature.com/articles/s41467-025-55832-y#Equ1)) as a *product representation* of polynomial higher-order features, the corresponding diagram is outlined in Fig. [1](https://www.nature.com/articles/s41467-025-55832-y#Fig1) b. Akin to local representations [^23], vector components in **G** represent either individual components of the state vectors or a product of a subset of such components. A severe problem with the product representation is that the scaling is poor. The dimensionality of the feature space **G** grows exponentially with *n* – the highest order of the features that are used, i.e., for *n* th-order features, the resulting dimensionality is still $\left(\begin{array}{c}dk+n-1\\ n\end{array}\right)$ even when only the unique features are considered, “Product representation of higher-order features” section.

### Randomized distributed representations of trajectories

As shown in refs. [^11] [^12] [^24], the product representation scheme Eq. ([1](https://www.nature.com/articles/s41467-025-55832-y#Equ1)) can outperform traditional reservoir networks in the prediction from multivariate time-series. However, a significant limitation of this approach is that the dimensionality of the representation grows exponentially with the order of the polynomial, “Product representation of higher-order features” section.

Inspired by traditional reservoir computing, which often involves randomized distributed representations of the input signals [^5], we propose an approach that combines the transparency and richness of the product representation with the advantages of randomized representations [^19] [^25] [^26]. To realize this idea in reservoir computing, we leverage an algebraic framework, known as hyperdimensional computing or vector symbolic architectures (VSA) [^16] [^17] [^18]. The initial step of the approach is to embed a single time point ${{{\bf{X}}}}(i)\in {{\mathbb{R}}}^{d}$ into a *D* -dimensional randomized representation under a map $\psi :{{\mathbb{R}}}^{d}\to {{\mathbb{R}}}^{D}$. Here, we focus on embeddings based on linear random projection [^27], which are commonly used in VSA [^28] [^29], that transforms a *d* -dimensional state vector **X** (*i*) into a *D* -dimensional embedding vector via:

 $\psi \left(\mathbf{X} \left(i\right)\right) = \mathbf{W}_{i n} \mathbf{X} \left(i\right) \in \mathbb{R}^{D} ,$ 
$$
\psi ({{{\bf{X}}}}(i))={{{{\bf{W}}}}}_{{{{\rm{in}}}}}{{{\bf{X}}}}(i)\,\in {{\mathbb{R}}}^{D},
$$

(2)

Here, ${{{{\bf{W}}}}}_{{{{\rm{in}}}}}\in {{\mathbb{R}}}^{D\times d}$ is a random projection matrix, where each column is chosen i.i.d. from a certain distribution, depending on the choice of a VSA model as discussed below. Such a randomized linear embedding is also the standard first step in traditional reservoir computing.

The VSA framework offers three standard algebraic operations for manipulating randomized distributed representations: vector superposition (denoted as +/∑), vector binding (denoted as ∘/○), and permutation (denoted as *ρ*). The exact instantiation of these operations depends on the particular VSA model [^30] [^31] and affects the corresponding implementation as discussed in “Networks of Sigma-Pi neurons for tensor product and binding” section. The advantage of VSA is that superposition, binding, and permutation are dimensionality-preserving – independent from how these operations are combined and iterated, the dimensionality of the resulting representation is always equal to *D*, the dimensionality chosen in the random projection step, Eq. ([2](https://www.nature.com/articles/s41467-025-55832-y#Equ2)).

Regardless of the type of VSA model, there is a correspondence between the similarity structures of features formed in the VSA space to the similarity structure of concatenation and tensor product. As described in ref. [^32], superposition protected by permutation, akin to the recurrent computation in reservoir computing, has approximately the same similarity structure as concatenation. Thus, a reservoir network as well as a VSA-protected superposition are, generally, like concatenation of inputs, and, in essence, form a feature space that acts like a short-term memory of the input history (cf. Fig. [1](https://www.nature.com/articles/s41467-025-55832-y#Fig1) a, c). Such a short-term memory can be extended to the concept of a *fading memory buffer*, where inputs from older time points gradually fade away. The time constant of this fading memory can be controlled by either point-wise saturating nonlinearities or by the recurrent weight matrix [^8]. The memory buffer retains the similarity structure like concatenation, but one needs to account for the fading memory property.

Similarly, vector binding has a matching similar structure as the tensor product [^32]. Thus, in the VSA framework, the randomized and distributed version of the product representation Eq. ([1](https://www.nature.com/articles/s41467-025-55832-y#Equ1)) is given by:

 $\mathbf{F} = \sum_{t \in \mathcal{T}} \left(◯^{t} \left(\sum_{l = 1}^{k} \mathbf{W}_{\rho}^{l - 1} \left(\mathbf{W}_{\mathtt{i} \mathtt{n}} \mathbf{X} \left(\mathcal{M}_{l}\right)\right)\right)\right) \in \mathbb{R}^{D} ,$ 
$$
{{{\bf{F}}}}={\sum}_{t\in {{{\mathcal{T}}}}}\left(\bigcirc^{t}\left({\sum}_{l=1}^{k}{{{{\bf{W}}}}}_{\rho }^{l-1}\left({{{{\bf{W}}}}}_{{\mathtt{in}}}{{{\bf{X}}}}({{{{\mathcal{M}}}}}_{l})\right)\right)\right)\,\in {{\mathbb{R}}}^{D},
$$

(3)

where **W** <sub><i>ρ</i></sub> is a mixing matrix with the “echo-state property” [^3] applied *l*  − 1 times. Practically, **W** <sub><i>ρ</i></sub> can be a simple permutation [^33] [^34], which we denote as *ρ* ( ⋅ ). The diagram of the proposed approach is depicted in Fig. [1](https://www.nature.com/articles/s41467-025-55832-y#Fig1) c while further step-by-step details of this representation scheme are provided in “Randomized representations of higher-order features with binding” section. The crucial idea is that distributed representations are able to approximate the same similarity structure as the product representation above, but in a much more parsimonious way, “Kernel approximation guarantees for randomized representations” section. This holds because vector binding and permutation of vector components distribute over vector superposition (the basis for the “computing in superposition” principle [^18]) and produce joint distributed representations where the inner product between such representations approximates the inner product between representations formed using the explicit feature map in Eq. ([1](https://www.nature.com/articles/s41467-025-55832-y#Equ1)). In general, as the dimensionality, *D*, grows larger, the fidelity of this approximation will improve. The precise rate at which this happens depends on the maximum polynomial degree and the particulars of the data in question [^19]. We quantify this more precisely in “Kernel approximation guarantees for randomized representations” section, but the crucial feature is that to achieve any desired constant fidelity of approximation, the dimensionality *D* depends only quadratically on the maximum polynomial degree, as opposed to the *exponential* dependence encountered when representing polynomial features explicitly by the product representation.

### Networks of Sigma-Pi neurons for tensor product and binding

In order to make use of the product representation or its equivalent distributed representation on neuromorphic hardware, there must be a network motif for computing concatenation and tensor product features. As already mentioned, the memory buffer for storing the trajectory of time-delayed states can be implemented with traditional linear reservoir networks, Fig. [1](https://www.nature.com/articles/s41467-025-55832-y#Fig1) a. These networks are composed of conventional *Sigma* neurons, which sum up the synaptic inputs and potentially apply a point-wise nonlinear activation function.

To implement any variant of features formed by the tensor product, Eq. ([1](https://www.nature.com/articles/s41467-025-55832-y#Equ1)) or Eq. ([3](https://www.nature.com/articles/s41467-025-55832-y#Equ3)), a network motif is required for computing tensor product or vector binding. Such a network motif requires an additional type of neuron, *Pi* neurons [^13] [^14], which compute the product of synaptic inputs. Thus, to compute the higher-order features of two input vectors, ${{{\bf{X}}}},{{{\bf{Y}}}}\in {{\mathbb{R}}}^{d}$, one would have a population of *d*  ×  *d* Pi neurons. Each Pi neuron would have two inputs, one from **X** and one from **Y**, in accordance with the tensor product, Fig. [2](https://www.nature.com/articles/s41467-025-55832-y#Fig2) a. Similarly, features obtained via vector binding also require Pi neurons or a network of Sigma and Pi neurons. We highlight two network motifs for computing randomized distributed representations using the multiply-add-permute model (MAP) [^35] as well as the sparse block code model (SBC) [^32] [^36], see Fig. [2](https://www.nature.com/articles/s41467-025-55832-y#Fig2) b, c. These different variations of motifs to compute higher-order features have different trade-offs in terms of the number of Sigma or Pi neurons needed, as well as the total number of synaptic connections. Based on the traits of the neuromorphic hardware, one variation might be more favorable than another.

![Fig. 2: Network motifs for computing representations of higher-order features.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs41467-025-55832-y/MediaObjects/41467_2025_55832_Fig2_HTML.png?as=webp)

Fig. 2: Network motifs for computing representations of higher-order features.

Another advantage of the distributed representation approach in Fig. [2](https://www.nature.com/articles/s41467-025-55832-y#Fig2) b, c is that higher-order features can be computed by using the network motifs for binding recurrently (recurrent connections are not shown in the figure). Since the dimensionality of the result of binding is the same as the dimensionality of the inputs, the result can be sent backward as one of the inputs and recombined in the next iteration. This can greatly reduce the resource requirements for computing high-order features on neuromorphic hardware since the synaptic connections and neurons for the binding network can be reused.

Table [1](https://www.nature.com/articles/s41467-025-55832-y#Tab1) summarizes the resources – as defined by the number of neurons and synaptic connections – needed for Sigma-Pi networks. It also includes another VSA model – holographic reduced representations (HRR) [^37] that is used in “Experiments on CPU” section (see Supplementary Material [S-VI](https://www.nature.com/articles/s41467-025-55832-y#MOESM1) for the experiment comparing the performance of these models). For all networks, the initial memory buffer of time-delayed states is formed with a permutation matrix, which is the simplest matrix structure for creating an effective reservoir, requiring only a single synapse for each neuron [^33] [^34]. The holographic reduced representations model realizes the binding through the circular convolution. This circuit requires *D* <sup>2</sup> Pi neurons, which first compute the tensor product between the input populations, and *D* Sigma neurons aggregate the activity of Pi neurons. In the multiply-add-permute model, the binding operation is the component-wise Hadamard product, so *D* Pi neurons are sufficient to implement it. For the sparse block code model, the binding operation is block-wise circular convolution, which requires *D* *L* Pi neurons and *D* Sigma neurons, where *L* is the size of the block. Each of these randomized systems requires an embedding step (“Randomized representations of higher-order features with binding” section, Eq. ([17](https://www.nature.com/articles/s41467-025-55832-y#Equ17))) to transform the input signals into distributed representations. Since both holographic reduced representations and multiply-add-permute use dense representations, the random projection matrix must be of size *d* *D*. However, for the sparse block code model, a neuromorphic system can take advantage of the matrix’s sparsity, requiring only *d* *D* / *L* synaptic connections for the embedding. To compute higher-order features in all networks, the recurrent connections are added from the output of the binding stage back to one of the input populations, which can be done with one-to-one synaptic connections, requiring only *D* extra synapses. With this recurrent motif, features of arbitrary order can be computed without requiring additional network resources, but using more iterations.

**Table 1 Resources required for computing higher-order features**

Importantly, the concrete VSA model should be chosen not only based on the corresponding network complexity but also based on its suitability to the targeted computing hardware. To demonstrate this point, “Experiments on neuromorphic hardware” section presents an implementation of the existing neuromorphic chip Loihi 2.

### Experiments on CPU

Following the example of traditional reservoir computing [^1] [^3], Gauthier et al.[^12] used the product representation scheme Eq. ([1](https://www.nature.com/articles/s41467-025-55832-y#Equ1)) combined with a ridge regression to construct predictive models for multivariate time-series and evaluated them on predicting chaotic dynamical systems. During training, a readout matrix (“Product representation of higher-order features” section, Eq. ([9](https://www.nature.com/articles/s41467-025-55832-y#Equ9))), is obtained from the ridge regression solution (with regularization parameter *α*). The training data include points in the feature space and the corresponding ground truth of the target function, e.g., the next state vector of the dynamical system as determined by conventional numerical integration.

Here we evaluate the described approaches to data representation in experiments on autoregressive prediction of chaotic dynamical systems; for details of the considered dynamical systems, see “Tasks and experimental configurations” section. For the Lorenz63 system, Eq. ([23](https://www.nature.com/articles/s41467-025-55832-y#Equ23)), Fig. [3](https://www.nature.com/articles/s41467-025-55832-y#Fig3) a depicts a ground truth trajectory and training time points (blue dotted lines) for all three observable states that are overlaid with the training phase predictions for the product (red dashed lines) and distributed representations (green dash-dotted lines), respectively. Similar to the product representation, Fig. [3](https://www.nature.com/articles/s41467-025-55832-y#Fig3) b, the strange attractor predicted by the distributed representation, Fig. [3](https://www.nature.com/articles/s41467-025-55832-y#Fig3) c, highly resembles the true attractor in Fig. [3](https://www.nature.com/articles/s41467-025-55832-y#Fig3) a, indicating the successful reconstruction of the dynamical system (see quantitative results in Supplementary Material [S-VIII](https://www.nature.com/articles/s41467-025-55832-y#MOESM1)). Supplementary Material [S-X](https://www.nature.com/articles/s41467-025-55832-y#MOESM1) shows that this dynamical system can be reconstructed successfully even in the presence of noise. Further, both approaches can closely follow the true Lorenz63 system in the short term for several Lyapunov times, Fig. [3](https://www.nature.com/articles/s41467-025-55832-y#Fig3) b, c. For the double-scroll system, Eq. ([24](https://www.nature.com/articles/s41467-025-55832-y#Equ24)), the ground truth data from the training phase is presented in Fig. [3](https://www.nature.com/articles/s41467-025-55832-y#Fig3) d. The predicted attractors in Fig. [3](https://www.nature.com/articles/s41467-025-55832-y#Fig3) e, f also resemble the true attractor where both product and distributed representations closely follow the true dynamics for several Lyapunov times. For the third Mackey–Glass system, Eq. ([25](https://www.nature.com/articles/s41467-025-55832-y#Equ25)), in Fig. [3](https://www.nature.com/articles/s41467-025-55832-y#Fig3) g, the feature space **G** for the product representation includes features up to third-order following [^38], Eq. ([31](https://www.nature.com/articles/s41467-025-55832-y#Equ31)) where *D*  = 84. However, a comparison of the predicted attractor, Fig. [3](https://www.nature.com/articles/s41467-025-55832-y#Fig3) h, to the true one, Fig. [3](https://www.nature.com/articles/s41467-025-55832-y#Fig3) g, reveals that predicting the system with this feature space is challenging, which is consistent with previous observations [^38]. This exemplifies the poor scaling of product representations as extending **G** with fourth-order features requires $\left(\begin{array}{c}dk+3\\ 4\end{array}\right)=126$ additional features increasing the model size by 150%. This is not the case for the distributed representation, Fig. [3](https://www.nature.com/articles/s41467-025-55832-y#Fig3) i, since already for *D*  = 100 (19% increase to **G**) it accommodates even fourth-order features, Eq. ([32](https://www.nature.com/articles/s41467-025-55832-y#Equ32)), and, consequently, achieves a substantial decrease in normalized root-mean-square error (NRMSE, Eq. ([35](https://www.nature.com/articles/s41467-025-55832-y#Equ35)) in “Performance metrics” section) − 3.59 × 10 <sup>−1</sup> versus 1.80 × 10 <sup>−1</sup>. Further, this dimensionality is already sufficient to start creating models that much better reconstruct the true attractor, Fig. [3](https://www.nature.com/articles/s41467-025-55832-y#Fig3) i. The individual distributed representation-based models in Fig. [3](https://www.nature.com/articles/s41467-025-55832-y#Fig3) indicate that the dimensionality is an important hyperparameter affecting both model’s complexity and its predictive performance measured by NRMSE. This effect is presented in Fig. [4](https://www.nature.com/articles/s41467-025-55832-y#Fig4).

![Fig. 3: Examples of predicting chaotic dynamical systems.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs41467-025-55832-y/MediaObjects/41467_2025_55832_Fig3_HTML.png?as=webp)

Fig. 3: Examples of predicting chaotic dynamical systems.

![Fig. 4: Median predictive performance against the dimensionality of D.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs41467-025-55832-y/MediaObjects/41467_2025_55832_Fig4_HTML.png?as=webp)

Fig. 4: Median predictive performance against the dimensionality of D.

For the Lorenz63 system, Fig. [4](https://www.nature.com/articles/s41467-025-55832-y#Fig4) a, the product representation space includes 28 features, Eq. ([27](https://www.nature.com/articles/s41467-025-55832-y#Equ27)), while the number of dimensions *D* for the distributed representation is a hyperparameter that can be set freely. In fact, for the same dimensionality (*D*  = 28) the distributed representation provides performance matching the product representation baseline. This is an important result showing that randomized distributed representations attain strong performance even with low dimensions, which contradicts the existing narrative. Similar to the distributed representation, the traditional reservoir computing (echo state network, “Experiments with traditional reservoir computing networks” section) also improves with increased *D*. But in agreement with the results reported in refs. [^11] [^12], for the Lorenz63 system it needs more dimensions to match the performance of the higher-order features (though, it is not guaranteed to be the case for every system, see Supplementary Material [S-I](https://www.nature.com/articles/s41467-025-55832-y#MOESM1)). Furthermore, the performance of the multilayer perceptron is nowhere near the models with higher-order features neither for the Lorenz63 system nor for the other systems. For the double-scroll system, the higher-order feature spaces are constructed from first- & third-order features, Eq. ([29](https://www.nature.com/articles/s41467-025-55832-y#Equ29)), such that the product representation includes *D*  = 62 features. The distributed representation, however, demonstrates matching performance, Fig. [4](https://www.nature.com/articles/s41467-025-55832-y#Fig4) b, with just 34 dimensions resulting in 45% resource savings (see also Supplementary Material [S-I](https://www.nature.com/articles/s41467-025-55832-y#MOESM1) for a similar result on another task). Thus, even for a moderately high number of features in **G**, the distributed representation could provide non-trivial computational savings. This advantage of the proposed approach is emphasized further for the Mackey–Glass system, Fig. [4](https://www.nature.com/articles/s41467-025-55832-y#Fig4) c, where the distributed representation with 100 dimensions already accommodates fourth-order features (green circle). The predictive performance can be improved further at the cost of increased dimensionality, which emphasizes the value of including additional features (fourth-order). In contrast to the rigid design space of the product representation (red squares), the absence of fixed dependency between the dimensionality of distributed representations and the number of features in the corresponding product representation results in a flexible design space controlling the trade-off that is demonstrated by additional models with an even higher order of features (up to seventh). As expected, the configurations of the distributed representation including more features require more dimensions to demonstrate reasonable performance. At the same time, given representations that are large enough such models demonstrate better predictive performance. Though as with the product representation, there are diminishing returns since much larger representations are required to slightly improve the performance.

### Experiments on neuromorphic hardware

Here, we demonstrate the implementation of a memory buffer and Sigma-Pi networks on the neuromorphic chip Loihi 2 [^15] [^39]. Loihi 2 (Fig. [5](https://www.nature.com/articles/s41467-025-55832-y#Fig5) a) is an asynchronous neuromorphic computing architecture and communicates information with event-based packets. In Loihi 2, these packets can contain 24 bits of information – a “graded spike”, which we use to transmit the magnitude of vector components. Furthermore, Loihi 2 has a programmable engine that allows users to define custom neuron models, which we use to implement both Sigma and Pi neurons.

![Fig. 5: Implementation and experiments on the neuromorphic chip Loihi 2.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs41467-025-55832-y/MediaObjects/41467_2025_55832_Fig5_HTML.png?as=webp)

Fig. 5: Implementation and experiments on the neuromorphic chip Loihi 2.

Following “Networks of Sigma-Pi neurons for tensor product and binding” section, we utilize two basic types of neurons for the implementation: Sigma and Pi. The Sigma neuron computes the inner product between the input population and synaptic weights and transmits the result as a graded spike. The Sigma neuron can also be configured with a threshold, where the results of the inner product below the threshold will lead to no spiking output, which can reduce spike traffic. The Pi neuron is a special type of neuron that has two input channels. Synaptic inputs are accumulated on the two channels, and then the neuron computes the product of these inputs and outputs the result as a graded spike. Typically here there is only a single synaptic input on each channel.

The representations of activity in the Loihi 2 neurons are, thus, event packets containing 24 bits representing fixed-point integers. The 8-bit synaptic weights and the Pi neurons compute fixed-point multiplication by multiplying the integer values and shifting right, where the fixed point is typically 2 <sup>7</sup> for synaptic weights and 2 <sup>12</sup> for graded spikes. The chip is programmed using the base software package *Lava* ([https://github.com/lava-nc](https://github.com/lava-nc)), as well as *Lava-VSA*, which provides tools for constructing VSA circuits. Since sparsity is an important desiderata for Loihi 2 circuits, we leverage the sparse block code model, Fig. [2](https://www.nature.com/articles/s41467-025-55832-y#Fig2) c. The representations are structured into *K*  = 10, *L*  = 20-dimensional blocks, with *D*  =  *L* *K*. The *Lava-VSA* software package contains modules for creating the network motifs for computing the desired distributed representation of higher-order features that can be executed on Loihi 2.

To validate that our implementation produces meaningful representations, we perform a feasibility study by using the states of the Lorenz63 system, Eq. ([23](https://www.nature.com/articles/s41467-025-55832-y#Equ23)), as an input to three different network architectures running on Loihi 2. The goal is to predict a randomly chosen quadratic function that depends on two most recent Lorenz63 state vectors (Fig. [5](https://www.nature.com/articles/s41467-025-55832-y#Fig5) b gray line depicts and example target function). To illustrate the proof-of-principle, we implement and compare three networks: a linear reservoir network that computes the memory buffer of recent input history (Fig. [5](https://www.nature.com/articles/s41467-025-55832-y#Fig5) b, left); a network that computes the joint distributed representation of the most recent state vector and its second-order features (Fig. [5](https://www.nature.com/articles/s41467-025-55832-y#Fig5) b, center); and a network that combines the memory buffer with first and second-order features (Fig. [5](https://www.nature.com/articles/s41467-025-55832-y#Fig5) b, right). Figure [5](https://www.nature.com/articles/s41467-025-55832-y#Fig5) b illustrates qualitatively that the first network provides the worst predictions while the predictions from the third network are nearly perfect. The same point is demonstrated quantitatively in Fig. [5](https://www.nature.com/articles/s41467-025-55832-y#Fig5) c that reports the prediction error for eight random instantiations of the networks (solid lines). The performance is shown against the number of sparse blocks of fixed size (*L*  = 20). As expected, neither the first nor the second network’s representations are sufficient to closely predict the target function, since these feature spaces do not contain the features matching the target function. In contrast, using the representations including the memory buffer and its second-order features results in small errors that decrease with the number of blocks, as all relevant target features are present. Furthermore, the results of all three networks on Loihi 2 closely follow the results obtained on their CPU counterparts (dashed lines).

## Discussion

Reservoir computing is a powerful and general paradigm for computing with randomized distributed representations in a recurrent neural network. It draws on principles of neural computation, and it has proven useful for a wide range of tasks [^40]. Yet despite general guarantees on function approximation [^6], traditional reservoir computing is often difficult to interpret and optimize in practice. This motivates exploring modifications of the original architecture to achieve the same performance with less resources. For example, ref. [^41] used reservoirs combined with time delays and ref. [^42] used structured matrices to speed up updates of the reservoir. Another promising approach is to model higher-order polynomial features in the data explicitly. This idea is explored in refs. [^11] [^12] [^24] who show that extracting higher-order features from time-series can dramatically improve the performance of reservoir computing models. While powerful, the dimensionality of this explicit formation of higher-order features grows exponentially with the order of the polynomial, making scaling to high-dimensional inputs difficult. In addition, large explicit feature spaces conflict with the classical motivation of parsimony in reservoir computing, and are less amenable for deployment on neuromorphic hardware. Here, we propose an approach that computes higher-order features implicitly and preserves the performance benefits of the explicit construction with reduced resource requirements. Furthermore, we show that this approach provides a principled way of approximating polynomial kernels with compact neural circuits and provides a proof-of-principle demonstration by implementing it on the neuromorphic chip Loihi 2.

Polynomial kernel machines and polynomial regression are widely known and useful tools in machine learning. The earlier results in refs. [^11] [^12] and our results enrich the repertoire of reservoir computing networks, by explicitly linking reservoir networks to the polynomial kernels. The theoretical connection between Volterra series and polynomial kernel regression [^43] further supports the idea of using these representations for learning dynamical systems. Our approach is principled by building on classic work from the machine learning literature on approximating kernel machines with randomized representations [^19] [^20]. Standard kernel machines avoid the exponential cost of computing all higher-order features but still have costs quadratic in the number of data points [^25] (“Implicit realization via polynomial kernel machine” section). By contrast, we use *randomized distributed* representations of polynomial kernels, which capture the same similarity structure as explicitly forming the feature map, but in a “compressed” representation that is much more parsimonious. A crucial advantage of this approach over explicitly forming the polynomial features is that in the former, the polynomial features are stored “in superposition” [^18] using fewer dimensions than would be required to explicitly represent them as in the latter. The price of this compression is that the distributed representation is approximate (“Kernel approximation guarantees for randomized representations” section): the similarity kernel recovered by the distributed representations is only a noisy version of the true kernel. The magnitude of this noise as a function of dimensionality can be quantified precisely [^19] [^20] using the theory of concentration of measure, and the dimensionality required to achieve a small error of approximation is modest compared to explicitly representing the features. This theoretical analysis underlies our empirical findings that the proposed approach performs more accurate prediction with smaller dimensions (Fig. [4](https://www.nature.com/articles/s41467-025-55832-y#Fig4)).

Prior theoretical work on randomized kernel approximation left open the question of how to best implement concatenation and tensor products on computing hardware. Our approach addresses this gap for neuromorphic hardware, leveraging vector symbolic architectures [^16] [^17] [^18] [^30], an algebraic, dimensionality-preserving framework for forming compositional distributed representations. The binding and superposition operations of vector symbolic architectures correspond to approximate representations of concatenation and tensor product, respectively [^32]. Our approach points out that two motifs, memory buffers and higher-order polynomial features, can be composed to form feature spaces and consolidated into two neural networks (see ref. [^44] for an alternative proposal within a single network). For the second motif (“Randomized distributed representations of trajectories” section), we demonstrate that the recursive vector bindings correspond to computations of higher-order features of the time points in the memory buffer of the reservoir. In addition, we propose that a recurrently connected network of Sigma-Pi neurons [^13] [^45] can implement the recursive binding (“Networks of Sigma-Pi neurons for tensor product and binding” section). While Sigma-Pi neurons are an idealized model there is experimental evidence for multiplication-like nonlinearity by individual nerve cells [^46].

For predicting dynamical systems (“Experiments on CPU” section), the performance of our approach is either better than or equal to that of the product representation, echo state network, and multilayer perceptron baselines. Further, it improves the product representation using fewer dimensions with matching performance (e.g., Fig. [4](https://www.nature.com/articles/s41467-025-55832-y#Fig4) b). Alternatively, higher performance can be attained with moderately increased dimensions to accommodate the features of increased order (Fig. [4](https://www.nature.com/articles/s41467-025-55832-y#Fig4) c). These results emphasize the role of dimensionality as a tuneable hyperparameter of the proposed approach. Note that this is the only additional hyperparameter introduced beyond the hyperparameters in the product representation scheme (i.e., the choice of delayed states, order of polynomial features, and the regularization parameter) [^12]. As follows from the results in Fig. [4](https://www.nature.com/articles/s41467-025-55832-y#Fig4), the dimensionality of randomized representations does not require extensive tuning. A simple heuristic is to initially use the number of features in the product representation, a conservative estimate that can often be reduced in practice. Thus, the proposed approach introduces minimal overhead to the hyperparameter search space compared to that of the product representation scheme. In practice, the expected performance increases with increased dimensionality of distributed representations. Dimensionality is a way of controlling the trade-off between the performance and resource-efficiency of the model.

To generate an efficient neuromorphic realization of binding, we utilize how distributed representations can be computed in terms of networks of Sigma-Pi neurons. We further explore randomly connected Sigma-Pi networks, Supplementary Material [S-III](https://www.nature.com/articles/s41467-025-55832-y#MOESM1), and discuss the trade-offs for different VSA models in “Networks of Sigma-Pi neurons for tensor product and binding” section. Importantly, such compositional distributed representations can be computed by networks of recurrently connected neurons, which further benefit from neuromorphic hardware acceleration. We implement the sparse block code [^32] [^36] on the Loihi 2 neuromorphic chip [^15] [^39] (“Experiments on neuromorphic hardware” section), which is advantageous because of the limited number of synaptic connections required. Notably, the representations computed by the neuromorphic realization performed very close to their CPU counterparts (Fig. [5](https://www.nature.com/articles/s41467-025-55832-y#Fig5)). It is anticipated that these findings will further impact advances in developing neuro-inspired algorithms, circuits, and applications within the neuromorphic computing community.

## Methods

### Product representation of higher-order features

The product representation of the feature space in Eq. ([1](https://www.nature.com/articles/s41467-025-55832-y#Equ1)) was investigated recently in ref. [^12]. It is assumed that at each time point *i* there are *d* states of the system of interest – ${{{\bf{X}}}}(i)\in {{\mathbb{R}}}^{d}$. For the current *i* -th time point, the construction of the feature space begins by forming a vector representing a trajectory of the past observations, which reflects first-order features ("linear” part of the feature space) denoted as **G** <sup>(1)</sup> (*i*). The current trajectory is specified as a tuple ${{{\mathcal{M}}}}$ that contains indices of *k* single time points to be included in the trajectory where the indices are spaced *s* time points apart:

 $\mathcal{M} = \left(i , i - s , i - 2 s , \ldots , i - \left(k - 1\right) s\right) .$ 
$$
{{{\mathcal{M}}}}=(i,i-s,i-2s,\ldots,i-(k-1)s).
$$

(4)

Given ${{{\mathcal{M}}}}$, the trajectory is then formed by concatenating the corresponding state vectors:

 $\mathbf{G}^{\left(1\right)} \left(i\right) = \oplus_{l = 1}^{k} \mathbf{X} \left(\mathcal{M}_{l}\right) \in \mathbb{R}^{d k} .$ 
$$
{{{{\bf{G}}}}}^{(1)}(i)={\bigoplus}_{l=1}^{k}{{{\bf{X}}}}({{{{\mathcal{M}}}}}_{l})\in {{\mathbb{R}}}^{dk}.
$$

(5)

The resulting feature space could be extended further by considering higher-order features ("nonlinear” part of the feature space) formed from **G** <sup>(1)</sup> (*i*) using the tensor product in Eq. ([7](https://www.nature.com/articles/s41467-025-55832-y#Equ7)). For example, second-order features **G** <sup>(2)</sup> (*i*) are constructed as:

 $\mathbf{G}^{\left(2\right)} \left(i\right) = \mathbf{G}^{\left(1\right)} \left(i\right) \bigotimes \mathbf{G}^{\left(1\right)} \left(i\right) .$ 
$$
{{{{\bf{G}}}}}^{(2)}(i)={{{{\bf{G}}}}}^{(1)}(i)\otimes {{{{\bf{G}}}}}^{(1)}(i).
$$

(6)

The resulting representation contains $\left(\begin{array}{c}dk+1\\ 2\end{array}\right)=\frac{dk(dk+1)}{2}$ unique entries in its upper triangular matrix. The explicit feature space can be formed using only these unique entries instead of total *d* <sup>2</sup> *k* <sup>2</sup> entries. In fact, this step has been used in ref. [^12] (denoted as ⌈⊗⌉), here this optimization step is also used for the experiments in “Experiments on CPU” section and elsewhere but we skip the extra notation for the sake of clarity.

The same principle can be used to obtain features of any other higher-order degree. For each problem, one needs to specify the set of desired orders ${{{\mathcal{T}}}}\subset \{0,\ldots,t,\ldots,n-1\}$, where each integer $t+1\in {{{\mathcal{T}}}}$ describes a desired order of polynomial features to be considered within the feature space. Once ${{{\mathcal{T}}}}$ is specified, by concatenating features of $| {{{\mathcal{T}}}}|$ desired orders, the complete representation is obtained in a single feature vector **G** (*i*):

 $\mathbf{G} \left(i\right) = \oplus_{t \in \mathcal{T}} \left(\otimes^{t} \mathbf{G}^{\left(1\right)} \left(i\right)\right) = \oplus_{t \in \mathcal{T}} \left(\otimes^{t} \left(\oplus_{l = 1}^{k} \mathbf{X} \left(\mathcal{M}_{l}\right)\right)\right) ,$ 
$$
{{{\mathbf{G}}}}(i)={\bigoplus}_{t\in {{{\mathcal{T}}}}} \left({\bigotimes}^{t} {{{\mathbf{G}}}}^{(1)}(i) \right)={\bigoplus}_{t\in {{{\mathcal{T}}}}} \left( {\bigotimes}^{t} \left( {\bigoplus}_{l=1}^{k} {{{\mathbf{X}}}}({{{\mathcal{M}}}}_l) \right) \right),
$$

(7)

where ⨂ <sup><i>t</i></sup> denotes the number of times the tensor product is applied to **G** <sup>(1)</sup> (*i*): *t*  = 0 implies first-order features, *t*  = 1 results in second-order features, etc. **G** (*i*) may also include an additional optional feature with the constant bias to account for the intercept term. The dimensionality of the product representation grows exponentially with the highest order of the features and is computed as:

 $\sum_{t \in \mathcal{T}} \begin{pmatrix} d k + t \\ t + 1 \end{pmatrix} ,$ 
$$
{\sum}_{t\in {{{\mathcal{T}}}}}\left(\begin{array}{c}dk+t\\ t+1\end{array}\right),
$$

(8)

As in other machine learning algorithms (e.g., within reservoir computing or kernel machines), the product representation in Eq. ([7](https://www.nature.com/articles/s41467-025-55832-y#Equ7)) is used to produce the prediction for the current time point through the linear transformation specified by a readout matrix (denoted as ${{{{\bf{W}}}}}_{{\mathtt{out}}}$) following: $\hat{{{{\bf{Y}}}}}(i)={{{{\bf{W}}}}}_{{{{\rm{out}}}}}{{{\bf{G}}}}(i)$ where the prediction $\hat{{{{\bf{Y}}}}}(i)$ is a scalar or vector approximating some desired output such as predicting system’s state vector for the next time point – $\hat{{{{\bf{Y}}}}}(i)=\hat{{{{\bf{X}}}}}(i+1)$. To obtain the readout matrix, the training data in the form of representations for *r* training time points in matrix **G** and the corresponding output values in **Y** are used. Given these training data, ${{{{\bf{W}}}}}_{{\mathtt{out}}}$ can be easily estimated using the ridge regression:

 $\mathbf{W}_{o u t} = \mathbf{Y} \mathbf{G}^{\top} \left(\mathbf{G} \mathbf{G}^{\top} + \alpha \mathbf{I}\right)^{- 1} ,$ 
$$
{{{{\bf{W}}}}}_{{{{\rm{out}}}}}={{{\bf{Y}}}}{{{{\bf{G}}}}}^{\top }{\left({{{\bf{G}}}}{{{{\bf{G}}}}}^{\top }+\alpha {{{\bf{I}}}}\right)}^{-1},
$$

(9)

where **I** is the identity matrix while *α* is the regularization hyperparameter that controls overfitting to the training data.

### Implicit realization via polynomial kernel machines

We have seen in “Joint representations formed by concatenation or tensor product” section that the similarity (inner product) structure of the space formed by concatenation is of an additive nature while that of the tensor product is of a multiplicative nature. It is, therefore, instructive to mathematically express the effect of concatenation and tensor product on the similarity structure in the resulting feature space. For example, when forming second-order features as in Eq. ([6](https://www.nature.com/articles/s41467-025-55832-y#Equ6)), it can be shown that the inner product between representations defined by two buffers ${{{{\mathcal{M}}}}}^{(i)}$ and ${{{{\mathcal{M}}}}}^{(j)}$ is equivalent to:

 $\langle \left(\oplus_{l = 1}^{k} \mathbf{X} \left(\mathcal{M}_{l}^{\left(i\right)}\right)\right) \bigotimes \left(\oplus_{l = 1}^{k} \mathbf{X} \left(\mathcal{M}_{l}^{\left(i\right)}\right)\right) , \left(\oplus_{l = 1}^{k} \mathbf{X} \left(\mathcal{M}_{l}^{\left(j\right)}\right)\right) \bigotimes \left(\oplus_{l = 1}^{k} \mathbf{X} \left(\mathcal{M}_{l}^{\left(j\right)}\right)\right) \rangle = \langle \oplus_{l = 1}^{k} \mathbf{X} \left(\mathcal{M}_{l}^{\left(i\right)}\right) , \oplus_{l = 1}^{k} \mathbf{X} \left(\mathcal{M}_{l}^{\left(j\right)}\right) \rangle^{2} .$ 
$$
\begin{aligned}
\left\langle \left({\bigoplus}_{l=1}^{k}{{{\bf{X}}}}({{{{\mathcal{M}}}}}_{l}^{(i)})\right) \otimes \left({\bigoplus}_{l=1}^{k}{{{\bf{X}}}}({{{{\mathcal{M}}}}}_{l}^{(i)})\right),\left({\bigoplus}_{l=1}^{k}{{{\bf{X}}}}({{{{\mathcal{M}}}}}_{l}^{(j)})\right)\otimes \left({\bigoplus}_{l=1}^{k}{{{\bf{X}}}}({{{{\mathcal{M}}}}}_{l}^{(j)})\right)\right\rangle \\ 	={\left\langle {\bigoplus}_{l=1}^{k}{{{\bf{X}}}}({{{{\mathcal{M}}}}}_{l}^{(i)}),{\bigoplus}_{l=1}^{k}{{{\bf{X}}}}({{{{\mathcal{M}}}}}_{l}^{(j)})\right\rangle }^{2}.
\end{aligned}
$$

(10)

First, Eq. ([10](https://www.nature.com/articles/s41467-025-55832-y#Equ10)) makes it evident that the use of the tensor product results in polynomial features [^22]. Second, the similarity structure formed by the tensor product is of a self-conjunctive nature and can be expressed as the product of inner products in space formed by concatenation. In general, for *n* th-order features, the inner product is expressed as:

 $\langle \otimes_{n - 1} \left(\oplus_{l = 1}^{k} \mathbf{X} \left(\mathcal{M}_{l}^{\left(i\right)}\right)\right) , \otimes_{n - 1} \left(\oplus_{l = 1}^{k} \mathbf{X} \left(\mathcal{M}_{l}^{\left(j\right)}\right)\right) \rangle = \left(\langle \oplus_{l = 1}^{k} \mathbf{X} \left(\mathcal{M}_{l}^{\left(i\right)}\right) , \oplus_{l = 1}^{k} \mathbf{X} \left(\mathcal{M}_{l}^{\left(j\right)}\right) \rangle\right)^{n} = \left(\sum_{l = 1}^{k} \langle \mathbf{X} \left(\mathcal{M}_{l}^{\left(i\right)}\right) , \mathbf{X} \left(\mathcal{M}_{l}^{\left(j\right)}\right) \rangle\right)^{n} ,$ 
$$
\begin{aligned}
\left\langle{\bigotimes}_{n-1} \left( {\bigoplus}_{l=1}^{k} {{{\mathbf{X}}}}\left({{{\mathcal{M}}}}_l^{(i)}\right) \right),{\bigotimes}_{n-1} \left( {\bigoplus}_{l=1}^{k} {{{\mathbf{X}}}}\left({{{\mathcal{M}}}}_l^{(j)}\right) \right) \right\rangle \\ 	=\left\langle {\bigoplus}_{l=1}^{k} {{{\mathbf{X}}}}\left({{{\mathcal{M}}}}_l^{(i)}\right),{\bigoplus}_{l=1}^{k} {{{\mathbf{X}}}}\left({{{\mathcal{M}}}}_l^{(j)}\right) \right\rangle^{\!\!n}=\left( \sum\limits_{l=1}^{k} \left\langle {{{\mathbf{X}}}}\left({{{\mathcal{M}}}}_l^{(i)}\right),{{{\mathbf{X}}}}\left({{{\mathcal{M}}}}_l^{(j)}\right) \right\rangle \right) ^{\!\!n},
\end{aligned}
$$

(11)

where Eq. ([11](https://www.nature.com/articles/s41467-025-55832-y#Equ11)) also takes into account the fact that the inner product of concatenation is the sum of the inner products in the spaces being concatenated. Eq. ([11](https://www.nature.com/articles/s41467-025-55832-y#Equ11)) suggests that the same functionality can be expressed through the lens of kernel methods because the feature space in Eq. ([7](https://www.nature.com/articles/s41467-025-55832-y#Equ7)) is identical to the explicit feature map corresponding to the polynomial kernels of various degrees [^22]. The kernel functions can be evaluated by simply exponentiating the inner products of the first-order features as in Eq. ([11](https://www.nature.com/articles/s41467-025-55832-y#Equ11)), where the kernel function *κ* (**G** <sup>(1)</sup> (*i*), **G** <sup>(1)</sup> (*j*)) for Eq. ([7](https://www.nature.com/articles/s41467-025-55832-y#Equ7)) is computed as:

 $\kappa \left(\mathbf{G}^{\left(1\right)} \left(i\right) , \mathbf{G}^{\left(1\right)} \left(j\right)\right) = \sum_{t \in \mathcal{T}} \langle \oplus_{l = 1}^{k} \mathbf{X} \left(\mathcal{M}_{l}^{\left(i\right)}\right) , \oplus_{l = 1}^{k} \mathbf{X} \left(\mathcal{M}_{l}^{\left(j\right)}\right) \rangle^{t + 1} = \sum_{t \in \mathcal{T}} \left(\sum_{l = 1}^{k} \langle \mathbf{X} \left(\mathcal{M}_{l}^{\left(i\right)}\right) , \mathbf{X} \left(\mathcal{M}_{l}^{\left(j\right)}\right) \rangle\right)^{t + 1} .$ 
$$
\begin{aligned}
\kappa ({{{{\bf{G}}}}}^{(1)}(i),{{{{\bf{G}}}}}^{(1)}(j))=	{\sum}_{t\in {{{\mathcal{T}}}}}{\left\langle {\bigoplus}_{l=1}^{k}{{{\bf{X}}}}({{{{\mathcal{M}}}}}_{l}^{(i)}),{\bigoplus}_{l=1}^{k}{{{\bf{X}}}}({{{{\mathcal{M}}}}}_{l}^{(j)})\right\rangle }^{\!\!\!t+1}\\=	{\sum}_{t\in {{{\mathcal{T}}}}}{\left({\sum}_{l=1}^{k}\left\langle {{{\bf{X}}}}({{{{\mathcal{M}}}}}_{l}^{(i)}),{{{\bf{X}}}}({{{{\mathcal{M}}}}}_{l}^{(j)})\right\rangle \right)}^{\!\!t+1}.
\end{aligned}
$$

(12)

Given a particular kernel function, entries of the kernel matrix ${{{\bf{K}}}}\in {{\mathbb{R}}}^{r\times r}$ are obtained from the inner products between the states included in the trajectories of *r* training time points as:

 $\mathbf{K}_{i j} = \kappa \left(\mathbf{G}^{\left(1\right)} \left(i\right) , \mathbf{G}^{\left(1\right)} \left(j\right)\right) .$ 
$$
{{{{\bf{K}}}}}_{ij}=\kappa ({{{{\bf{G}}}}}^{(1)}(i),{{{{\bf{G}}}}}^{(1)}(j)).
$$

(13)

In turn, the kernel matrix **K** can be used for obtaining the kernel regression machine that is another form of the readout matrix where the prediction for the *m* -th output state (${\hat{{{{\bf{Y}}}}}}_{m}(i)$) is obtained as the weighted sum of the kernel function values between *r* training time points and the point *i* to be evaluated. Similar to the readout matrix in Eq. ([9](https://www.nature.com/articles/s41467-025-55832-y#Equ9)), the vector of weights of the training time points (denoted as ***α*** <sup>(<i>m</i>)</sup>) could be computed with the ridge regression as:

 $\mathbf{\mathit{\alpha}}^{\left(m\right)} = \left(\mathbf{K} + \alpha \mathbf{I}\right)^{- 1} \mathbf{Y}_{m :}^{\top} .$ 
$$
{{{{\boldsymbol{\alpha }}}}}^{(m)}={\left({{{\bf{K}}}}+\alpha {{{\bf{I}}}}\right)}^{-1}{{{{\bf{Y}}}}}_{m:}^{\top }.
$$

(14)

The prediction can then be computed as:

 $\hat{\mathbf{Y}}_{m} \left(i\right) = \sum_{j = 1}^{r} \mathbf{\mathit{\alpha}}_{j}^{\left(m\right)} \kappa \left(\mathbf{G}^{\left(1\right)} \left(j\right) , \mathbf{G}^{\left(1\right)} \left(i\right)\right) .$ 
$$
{\hat{{{{\bf{Y}}}}}}_{m}(i)={\sum}_{j=1}^{r}{{{{\boldsymbol{\alpha }}}}}_{j}^{(m)}\kappa ({{{{\bf{G}}}}}^{(1)}(j),{{{{\bf{G}}}}}^{(1)}(i)).
$$

(15)

An empirical experiment on predicting the Lorenz63 system (“Tasks and experimental configurations” section) comparing the product representation and the corresponding kernel machine is reported in Supplementary Material [S-IV](https://www.nature.com/articles/s41467-025-55832-y#MOESM1). As can be seen from Eq. ([15](https://www.nature.com/articles/s41467-025-55832-y#Equ15)), the kernel machine’s size depends on the number of training time points *r* rather than on the dimensionality of the explicitly constructed product representation. On the one hand, this could be beneficial in the situations when kernel’s feature map has large dimensionality while, on the other hand, it could be an issue for large-scale datasets. The latter issue motivated the seminal result in ref. [^25] suggesting to use randomized representations for approximating certain kernel functions.

### Randomized representations of higher-order features with binding

We have already considered two ways of realizing the feature space formed by concatenation and tensor product operations: product representation in “Product representation of higher-order features” section and implicit realization with the kernel machine in “Implicit realization via polynomial kernel machine” section. Here, we use the principles of hyperdimensional computing/vector symbolic architectures (VSA) [^16] [^17] [^18] [^30] to introduce the third way of embedding polynomial kernel functions into *randomized distributed representations* that approximate the similarity in the corresponding feature space **G**, Eq. ([7](https://www.nature.com/articles/s41467-025-55832-y#Equ7)). To manipulate randomized distributed representations of data, VSA defines operations on them such as binding (denoted as ∘), permutation (denoted as *ρ*), and superposition (denoted as +) that are essential for approximating polynomial kernels. The exact realization of these operations depends on a particular model being used [^30] [^31]. For example, for real-valued representations, there is a holographic reduced representation model [^37] that defines the superposition as a component-wise addition while the binding operation is realized via a circular convolution so both operations preserve the dimensionality of representations, *D* (see more examples in “Networks of Sigma-Pi neurons for tensor product and binding” and “Experiments on neuromorphic hardware” sections). In the context of this study, the intuition behind the operations is that the permutation randomizes distributed representations, the superposition approximates concatenation in the product representation, and the binding approximates the tensor product as it has been shown in ref. [^32].

The initial step in VSA is a transformation of data from their original representation into randomized vector representations (denoted as *ψ* (**X** (*i*))). For concreteness, let us consider a hypothetical system with two observable states *x* and *y* (**X** (*i*) =  *x* (*i*) ⊕ *y* (*i*), *d*  = 2). There are several ways of making a transformation for numeric vectors. A well-known way that is used commonly for randomized neural networks [^5] is based on a random projection [^47] [^48] [^49] where a *d* -dimensional state vector **X** (*i*) is transformed into a *D* -dimensional vector:

 $\psi \left(\mathbf{X} \left(i\right)\right) = \mathbf{W}_{\mathtt{i} \mathtt{n}} \mathbf{X} \left(i\right) = x \left(i\right) \mathbf{x} + y \left(i\right) \mathbf{y} ,$ 
$$
\psi ({{{\bf{X}}}}(i))={{{{\bf{W}}}}}_{{\mathtt{in}}}{{{\bf{X}}}}(i)=x(i){{{\bf{x}}}}+y(i){{{\bf{y}}}},
$$

(16)

where ${{{{\bf{W}}}}}_{{\mathtt{in}}}=[{{{\bf{x}}}};{{{\bf{y}}}}]\in {{\mathbb{R}}}^{D\times d}$ is a random projection matrix consisting of *d*  = 2 columns containing *D* -dimensional i.i.d. random vectors (e.g., **x** for *x* (*i*)). These vectors can be thought to play the role of “keys” in key-value pairs while “value” is the measurement for the state vector to be represented. The representation of state’s value is done by scaling the magnitudes of its random vector by the corresponding value, for example: *ψ* (*x* (*i*)) = *x* (*i*) **x**. Due to the usage of random vectors for each state in the trajectory, the transformation can be thought of as making an association between state’s value and the position of the corresponding state in the trajectory. Since the superposition operation is used commonly to represent sets or tuples, it allows constructing both the randomized representation of a single time point of the system (e.g., *ψ* (**X** (*i*)) =  *x* (*i*) **x**  +  *y* (*i*) **y**) as well as forming the compositional distributed representation of the whole trajectory ${\bigoplus}_{i=1}^{k}{{{\bf{X}}}}({{{{\mathcal{M}}}}}_{i})$ that is defined by ${{{\mathcal{M}}}}$ (denoted as **F** <sup>(1)</sup> (*i*)). For example, for *k*  = 2, and *s*  = 1 (${{{\mathcal{M}}}}=(i,i-1)$):

 $\mathbf{F}^{\left(1\right)} \left(i\right) = \psi \left(\mathbf{X} \left(\mathcal{M}_{i}\right) \oplus \mathbf{X} \left(\mathcal{M}_{i - 1}\right)\right) = \mathbf{W} \left(\oplus_{l = 1}^{k} \mathbf{X} \left(\mathcal{M}_{l}\right)\right) = \sum_{l = 1}^{k} \mathbf{W}_{\rho}^{l - 1} \left(\mathbf{W}_{\mathtt{i} \mathtt{n}} \mathbf{X} \left(\mathcal{M}_{l}\right)\right) = \sum_{l = 1}^{k} \rho^{l - 1} \left(\mathbf{W}_{\mathtt{i} \mathtt{n}} \mathbf{X} \left(\mathcal{M}_{l}\right)\right) = x \left(i\right) \mathbf{x} + y \left(i\right) \mathbf{y} + x \left(i - 1\right) \rho \left(\mathbf{x}\right) + y \left(i - 1\right) \rho \left(\mathbf{y}\right) ,$ 
$$
\begin{aligned}
{{{{\bf{F}}}}}^{(1)}(i) 	=\psi ({{{\bf{X}}}}({{{{\mathcal{M}}}}}_{i})\oplus {{{\bf{X}}}}({{{{\mathcal{M}}}}}_{i-1}))={{{\bf{W}}}}\left({\bigoplus}_{l=1}^{k}{{{\bf{X}}}}({{{{\mathcal{M}}}}}_{l})\right)={\sum}_{l=1}^{k}{{{{\bf{W}}}}}_{\rho }^{l-1}\left({{{{\bf{W}}}}}_{{\mathtt{in}}}{{{\bf{X}}}}({{{{\mathcal{M}}}}}_{l})\right) \\ 	={\sum}_{l=1}^{k}{\rho }^{l-1}\left({{{{\bf{W}}}}}_{{\mathtt{in}}}{{{\bf{X}}}}({{{{\mathcal{M}}}}}_{l})\right)=x(i){{{\bf{x}}}}+y(i){{{\bf{y}}}}+x(i-1)\rho ({{{\bf{x}}}})+y(i-1)\rho ({{{\bf{y}}}}),
\end{aligned}
$$

(17)

where for the considered case: ${{{\bf{W}}}}=[{{{{\bf{W}}}}}_{{\mathtt{in}}};{{{{\bf{W}}}}}_{\rho }{{{{\bf{W}}}}}_{{\mathtt{in}}}]=[{{{{\bf{W}}}}}_{{\mathtt{in}}};\rho ({{{{\bf{W}}}}}_{{\mathtt{in}}})]=[{{{\bf{x}}}};{{{\bf{y}}}};\rho({{{\bf{x}}}});\rho({{{\bf{y}}}})]$, the role of a mixing matrix **W** <sub><i>ρ</i></sub> that is realized via the permutation *ρ* ( ⋅ ) is to protect the representation of different time steps in the joint representation of the trajectory [^32]. Thus, Eq. ([17](https://www.nature.com/articles/s41467-025-55832-y#Equ17)) is the randomized distributed representation corresponding to the concatenation of several time points in the product representation, cf. Eq. ([5](https://www.nature.com/articles/s41467-025-55832-y#Equ5)). A theoretical argument supporting this claim is presented in the next section. The corresponding empirical evaluation is reported in Supplementary Material [S-VII](https://www.nature.com/articles/s41467-025-55832-y#MOESM1).

The distributed representations of higher-order features are obtained from the distributed representation of the trajectory, Eq. ([17](https://www.nature.com/articles/s41467-025-55832-y#Equ17)). Due to the “computing in superposition” property of VSA [^18], this step is trivial and uses only the binding and permutation operations that are different from *ρ* ( ⋅ ). For example, the distributed representation of second-order features that is analogous to applying the tensor product in the explicit feature space (“Joint representations formed by concatenation or tensor product” section) is obtained by binding **F** <sup>(1)</sup> (*i*) to its own permuted representation:

 $\mathbf{F}^{\left(2\right)} \left(i\right) = \mathbf{F}^{\left(1\right)} \left(i\right) \circ \pi \left(\mathbf{F}^{\left(1\right)} \left(i\right)\right) .$ 
$$
{{{{\bf{F}}}}}^{(2)}(i)={{{{\bf{F}}}}}^{(1)}(i)\circ \pi \left({{{{\bf{F}}}}}^{(1)}(i)\right).
$$

(18)

This is possible since the binding and permutation operations distribute over the superposition so Eq. ([18](https://www.nature.com/articles/s41467-025-55832-y#Equ18)) can be expanded as follows:

 $\mathbf{F}^{\left(2\right)} \left(i\right) = \mathbf{F}^{\left(1\right)} \left(i\right) \circ \pi \left(\mathbf{F}^{\left(1\right)} \left(i\right)\right) = \left(x \left(i\right) \mathbf{x} + y \left(i\right) \mathbf{y} + x \left(i - 1\right) \rho \left(\mathbf{x}\right) + y \left(i - 1\right) \rho \left(\mathbf{y}\right)\right) \circ \pi \left(x \left(i\right) \mathbf{x} + y \left(i\right) \mathbf{y} + x \left(i - 1\right) \rho \left(\mathbf{x}\right) + y \left(i - 1\right) \rho \left(\mathbf{y}\right)\right) = x \left(i\right)^{2} \mathbf{x} \circ \pi \left(\mathbf{x}\right) + x \left(i\right) y \left(i\right) \mathbf{x} \circ \pi \left(\mathbf{y}\right) + x \left(i - 1\right) x \left(i\right) \pi \left(\rho \left(\mathbf{x}\right)\right) \circ \mathbf{x} + y \left(i - 1\right) x \left(i\right) \pi \left(\rho \left(\mathbf{y}\right)\right) \circ \mathbf{x} + x \left(i\right) y \left(i\right) \pi \left(\mathbf{x}\right) \circ \mathbf{y} + y \left(i\right)^{2} \mathbf{y} \circ \pi \left(\mathbf{y}\right) + x \left(i - 1\right) y \left(i\right) \pi \left(\rho \left(\mathbf{x}\right)\right) \circ \mathbf{y} + y \left(i - 1\right) y \left(i\right) \pi \left(\rho \left(\mathbf{y}\right)\right) \circ \mathbf{y} + x \left(i - 1\right) x \left(i\right) \rho \left(\mathbf{x}\right) \circ \pi \left(\mathbf{x}\right) + x \left(i - 1\right) y \left(i\right) \rho \left(\mathbf{x}\right) \circ \pi \left(\mathbf{y}\right) + x \left(i - 1\right)^{2} \rho \left(\mathbf{x}\right) \circ \pi \left(\rho \left(\mathbf{x}\right)\right) + x \left(i - 1\right) y \left(i - 1\right) \rho \left(\mathbf{x}\right) \circ \pi \left(\rho \left(\mathbf{y}\right)\right) + y \left(i - 1\right) x \left(i\right) \rho \left(\mathbf{y}\right) \circ \pi \left(\mathbf{x}\right) + y \left(i - 1\right) y \left(i\right) \rho \left(\mathbf{y}\right) \circ \pi \left(\mathbf{y}\right) + x \left(i - 1\right) y \left(i - 1\right) \pi \left(\rho \left(\mathbf{x}\right)\right) \circ \rho \left(\mathbf{y}\right) + y \left(i - 1\right)^{2} \rho \left(\mathbf{y}\right) \circ \pi \left(\rho \left(\mathbf{y}\right)\right)$ 
$$
\begin{aligned}
{{{{\bf{F}}}}}^{(2)}(i)=	{{{{\bf{F}}}}}^{(1)}(i) \circ \pi \left({{{{\bf{F}}}}}^{(1)}(i)\right)\\=	\left(x(i){{{\bf{x}}}}+y(i){{{\bf{y}}}}+x(i-1)\rho ({{{\bf{x}}}})+y(i-1)\rho ({{{\bf{y}}}})\right)\circ \pi \left(x(i){{{\bf{x}}}}+y(i){{{\bf{y}}}}+x(i-1)\rho ({{{\bf{x}}}})+y(i-1)\rho ({{{\bf{y}}}})\right)\\=	x{(i)}^{2}{{{\bf{x}}}}\circ \pi ({{{\bf{x}}}})+x(i)y(i){{{\bf{x}}}}\circ \pi ({{{\bf{y}}}})+x(i-1)x(i)\pi (\rho ({{{\bf{x}}}}))\circ {{{\bf{x}}}}+y(i-1)x(i)\pi (\rho ({{{\bf{y}}}}))\circ {{{\bf{x}}}}\\ 	+x(i)y(i)\pi ({{{\bf{x}}}})\circ {{{\bf{y}}}}+y{(i)}^{2}{{{\bf{y}}}}\circ \pi ({{{\bf{y}}}})+x(i-1)y(i)\pi (\rho ({{{\bf{x}}}}))\circ {{{\bf{y}}}}+y(i-1)y(i)\pi (\rho ({{{\bf{y}}}}))\circ {{{\bf{y}}}}\\ 	+x(i-1)x(i)\rho ({{{\bf{x}}}})\circ \pi ({{{\bf{x}}}})+x(i-1)y(i)\rho ({{{\bf{x}}}})\circ \pi ({{{\bf{y}}}})+x{(i-1)}^{2}\rho ({{{\bf{x}}}})\circ \pi (\rho ({{{\bf{x}}}}))\\ 	+x(i-1)y(i-1)\rho ({{{\bf{x}}}})\circ \pi (\rho ({{{\bf{y}}}}))+y(i-1)x(i)\rho ({{{\bf{y}}}})\circ \pi ({{{\bf{x}}}})+y(i-1)y(i)\rho ({{{\bf{y}}}})\circ \pi ({{{\bf{y}}}})\\ 	+x(i-1)y(i-1)\pi (\rho ({{{\bf{x}}}}))\circ \rho ({{{\bf{y}}}})+y{(i-1)}^{2}\rho ({{{\bf{y}}}})\circ \pi (\rho ({{{\bf{y}}}}))
\end{aligned}
$$

(19)

As follows from the expansion in Eq. ([19](https://www.nature.com/articles/s41467-025-55832-y#Equ19)), the result of binding **F** <sup>(1)</sup> (*i*) to the permuted version of itself is equivalent to the superposition of *d* *k* <sup>2</sup>  = 16 unique randomized representations of second-order monomials of states present in the trajectory ${{{{\bf{G}}}}}^{(1)}(i)={{{\bf{X}}}}({{{{\mathcal{M}}}}}_{1})\oplus {{{\bf{X}}}}({{{{\mathcal{M}}}}}_{2})={{{\bf{X}}}}(i)\oplus {{{\bf{X}}}}(i-1)$. The terms corresponding to the binding of representations of keys (e.g., **x** ∘ *π* (**x**), **x** ∘ *π* (**y**), etc.) play the role of randomizing the corresponding representations, which allows them co-existing in a compositional randomized distributed representation **F** <sup>(2)</sup> (*i*), therefore, the inner product between such representations corresponds to the feature map of the second-order polynomial kernel $[{x}_{i}^{2},\sqrt{2}{x}_{i}{y}_{i},\sqrt{2}{x}_{i-1}{x}_{i},\sqrt{2}{y}_{i-1}{x}_{i},{y}_{i}^{2},\sqrt{2}{x}_{i-1}{y}_{i},\sqrt{2}{y}_{i-1}{y}_{i},{x}_{i-1}^{2},\sqrt{2}{x}_{i-1}{y}_{i-1},{y}_{i-1}^{2}]$. Distributed representations of desired higher-order features **F** <sup>(<i>t</i>)</sup> (*i*) are obtained in the same manner by binding permuted versions of **F** <sup>(1)</sup> (*i*)  *t*  − 1 times. This operator is denoted as $\bigcirc^{t}:{{{\mathcal{H}}}}\times {{{\mathcal{H}}}}\to {{{\mathcal{H}}}}$ and is defined recursively as $\bigcirc^{t}({{{{\bf{F}}}}}^{(1)}(i))=\pi (\bigcirc^{t-1}({{{{\bf{F}}}}}^{(1)}(i)))\circ {{{{\bf{F}}}}}^{(1)}(i)$ and $\bigcirc^{0}\left({{{{\bf{F}}}}}^{(1)}(i)\right)={{{{\bf{F}}}}}^{(1)}(i)$.

Finally, if the feature space is constructed using features of various orders (specified by ${{{\mathcal{T}}}}$), concatenation would be needed again in the product representation, cf. Eq. ([7](https://www.nature.com/articles/s41467-025-55832-y#Equ7)) but with VSA the joint distributed representation is constructed via the superposition on the corresponding randomized representations:

 $\mathbf{F} \left(i\right) = \sum_{t \in \mathcal{T}} \left(◯^{t} \left(\sum_{l = 1}^{k} \mathbf{W}_{\rho}^{l - 1} \left(\mathbf{W}_{\mathtt{i} \mathtt{n}} \mathbf{X} \left(\mathcal{M}_{l}\right)\right)\right)\right) \in \mathbb{R}^{D} .$ 
$$
{{{\bf{F}}}}(i)={\sum}_{t\in {{{\mathcal{T}}}}}\left(\bigcirc^{t}\left({\sum}_{l=1}^{k}{{{{\bf{W}}}}}_{\rho }^{l-1}\left({{{{\bf{W}}}}}_{{\mathtt{in}}}{{{\bf{X}}}}({{{{\mathcal{M}}}}}_{l})\right)\right)\right)\,\in {{\mathbb{R}}}^{D}.
$$

(20)

Since all operations in Eqs. ([17](https://www.nature.com/articles/s41467-025-55832-y#Equ17))–([20](https://www.nature.com/articles/s41467-025-55832-y#Equ20)) are dimensionality-preserving, the distributed representation of the feature space is also *D* -dimensional (*D*  − 1 if the constant bias is included) and can be used in the same way as the product representation in Eq. ([7](https://www.nature.com/articles/s41467-025-55832-y#Equ7)) where the readout matrix for a predictive model is estimated in the same manner as in Eq. ([9](https://www.nature.com/articles/s41467-025-55832-y#Equ9)) but using the distributed representations **F** (*i*) instead of the product ones **G** (*i*):

 $\mathbf{W}_{\mathtt{o} \mathtt{u} \mathtt{t}} = \mathbf{Y} \mathbf{F}^{\top} \left(\mathbf{F} \mathbf{F}^{\top} + \alpha \mathbf{I}\right)^{- 1} .$ 
$$
{{{{\bf{W}}}}}_{{\mathtt{out}}}={{{\bf{Y}}}}{{{{\bf{F}}}}}^{\top }{\left({{{\bf{F}}}}{{{{\bf{F}}}}}^{\top }+\alpha {{{\bf{I}}}}\right)}^{-1}.
$$

(21)

### Kernel approximation guarantees for randomized representations

As we have alluded to above, the embedding method we have introduced in “Randomized distributed representations of trajectories” section (see also “Randomized representations of higher-order features with binding” section) can be interpreted as generating an approximate feature map for the polynomial kernel. In fact, when the binding operator is the component-wise product, this method coincides with a well-known procedure for approximating polynomial kernels due to ref. [^19]. In this section, we derive these kernel approximation properties more formally for other realizations of the binding operation.

Let ${\kappa }_{p}:{{\mathbb{R}}}^{d}\times {{\mathbb{R}}}^{d}\to {\mathbb{R}}$ be the homogeneous polynomial kernel of degree *p* defined on ${{{\mathcal{X}}}}\subset {{\mathbb{R}}}^{d}$ as:

 $\kappa_{p} \left(\mathbf{x} , \mathbf{y}\right) = \left(\langle \mathbf{x} , \mathbf{y} \rangle\right)^{p} ,$ 
$$
{\kappa }_{p}({{{\bf{x}}}},{{{\bf{y}}}})={\langle {{{\bf{x}}}},{{{\bf{y}}}}\rangle }^{p},
$$

where $\langle {{{\bf{x}}}},{{{\bf{y}}}}\rangle={{{{\bf{x}}}}}^{\top }{{{\bf{y}}}}={\sum}_{j=1}^{d}{x}_{j}{y}_{j}$ is the standard Euclidean inner product on ${{\mathbb{R}}}^{d}$. Our goal is to design an embedding ${\phi }_{p}:{{{\mathcal{X}}}}\to {{{\mathcal{H}}}}\subset {{\mathbb{R}}}^{D}$, such that 〈 *ϕ* <sub><i>p</i></sub> (**x**), *ϕ* <sub><i>p</i></sub> (**y**)〉 ≈ *κ* <sub><i>p</i></sub> (**x**, **y**), in what follows we show that a scheme based on randomized distributed representations can achieve this in expectation, whereupon one may appeal to concentration to argue that the fidelity of approximation is satisfactory for a particular choice of *D* [^19].

The generic procedure is as follows. Given an input ${{{\bf{x}}}}\in {{\mathbb{R}}}^{d}$, we compute embeddings *ψ* <sub>1</sub>, …, *ψ* <sub><i>p</i></sub>, where ${\psi }_{t}:{{{\mathcal{X}}}}\to {{{\mathcal{H}}}}$, via random linear maps:

 $\psi_{t} \left(\mathbf{x}\right) = \frac{1}{\sqrt{D}} \mathbf{W}^{\left(t\right)} \mathbf{x} ,$ 
$$
{\psi }_{t}({{{\bf{x}}}})=\frac{1}{\sqrt{D}}{{{{\bf{W}}}}}^{(t)}{{{\bf{x}}}},
$$

where ${{{{\bf{W}}}}}^{(t)}\in {{\mathbb{R}}}^{D\times d}$ are random projection matrices whose components are drawn i.i.d. from some distribution with zero mean and unit variance. Consequentially, it is the case that:

 $\mathbb{E} \left[\mathbf{w}_{j}^{\left(t\right)} \mathbf{w}_{k}^{\left(t\right) \top}\right] = \begin{cases} \frac{1}{D} \mathbf{I}_{d} & \text{if} j = k \\ 0_{d} & \text{otherwise} , \end{cases}$ 
$$
{\mathbb{E}}\left[{{{{\bf{w}}}}}_{j}^{(t)}{{{{\bf{w}}}}}_{k}^{(t)\top }\right]=\left\{\begin{array}{ll}\frac{1}{D}{{{{\bf{I}}}}}_{d}\quad &\,{\mbox{if}}\,\,j=k\hfill \\ {{{{\bf{0}}}}}_{d}\quad &\,{\mbox{otherwise}}\,,\end{array}\right.
$$

where ${{{{\bf{w}}}}}_{j}^{(t)}$ denotes the jth row of **W** <sup>(<i>t</i>)</sup> (which we treat as a *d* -dimensional vector for simplicity), **I** <sub><i>d</i></sub> is the *d*  ×  *d* identity matrix, and **0** <sub><i>d</i></sub> is the *d*  ×  *d* dimensional matrix of zeros. We then construct *ϕ* <sub><i>p</i></sub> by binding together the embeddings *ψ* <sub><i>t</i></sub> (**x**):

 $\phi_{p} \left(\mathbf{x}\right) = \psi_{1} \left(\mathbf{x}\right) \circ \psi_{2} \left(\mathbf{x}\right) \circ \hdots \circ \psi_{p} \left(\mathbf{x}\right) .$ 
$$
{\phi }_{p}({{{\bf{x}}}})={\psi }_{1}({{{\bf{x}}}})\circ {\psi }_{2}({{{\bf{x}}}})\circ \cdots \circ {\psi }_{p}({{{\bf{x}}}}).
$$

Our basic claim is that, for several different instantiations of $\circ :{{{\mathcal{H}}}}\times {{{\mathcal{H}}}}\to {{{\mathcal{H}}}}$, it is the case that, for any ${{{\bf{x}}}},{{{\bf{y}}}}\in {{{\mathcal{X}}}}$:

 $\mathbb{E} \left[\langle \phi_{p} \left(\mathbf{x}\right) , \phi_{p} \left(\mathbf{y}\right) \rangle\right] = \left(\langle \mathbf{x} , \mathbf{y} \rangle\right)^{p} = \kappa_{p} \left(\mathbf{x} , \mathbf{y}\right) ,$ 
$$
{\mathbb{E}}[\langle {\phi }_{p}({{{\bf{x}}}}),{\phi }_{p}({{{\bf{y}}}})\rangle ]={\langle {{{\bf{x}}}},{{{\bf{y}}}}\rangle }^{p}={\kappa }_{p}({{{\bf{x}}}},{{{\bf{y}}}}),
$$

where the expectation is taken with respect to randomness in **W** <sup>(1)</sup>, …, **W** <sup>(<i>p</i>)</sup>. The claim is true for *p*  = 1 since, for any *j* ∈ {1, …, *D* }:

 $\mathbb{E} \left[\phi_{1} \left(\mathbf{x}\right)_{j} \phi_{1} \left(\mathbf{y}\right)_{j}\right] = \mathbb{E} \left[\psi_{1} \left(\mathbf{x}\right)_{j} \psi_{1} \left(\mathbf{y}\right)_{j}\right] = \mathbb{E} \left[\left(\mathbf{w}_{j}^{\left(1\right) \top} \mathbf{x}\right) \left(\mathbf{w}_{j}^{\left(1\right) \top} \mathbf{y}\right)\right] = \mathbf{x}^{\top} \mathbb{E} \left[\mathbf{w}_{j}^{\left(1\right)} \mathbf{w}_{j}^{\left(1\right) \top}\right] \mathbf{y} = \frac{\langle \mathbf{x} , \mathbf{y} \rangle}{D} = \frac{\kappa_{1} \left(\mathbf{x} , \mathbf{y}\right)}{D} ,$ 
$$
\begin{aligned}
{\mathbb{E}}[{\phi }_{1}{({{{\bf{x}}}})}_{j}{\phi }_{1}{({{{\bf{y}}}})}_{j}]={\mathbb{E}}[{\psi }_{1}{({{{\bf{x}}}})}_{j}{\psi }_{1}{({{{\bf{y}}}})}_{j}]={\mathbb{E}}\left[({{{{\bf{w}}}}}_{j}^{(1)\top }{{{\bf{x}}}})({{{{\bf{w}}}}}_{j}^{(1)\top }{{{\bf{y}}}})\right]\\={{{{\bf{x}}}}}^{\top }{\mathbb{E}}\left[{{{{\bf{w}}}}}_{j}^{(1)}{{{{\bf{w}}}}}_{j}^{(1)\top }\right]{{{\bf{y}}}}=\frac{\langle {{{\bf{x}}}},{{{\bf{y}}}}\rangle }{D}=\frac{{\kappa }_{1}({{{\bf{x}}}},{{{\bf{y}}}})}{D},
\end{aligned}
$$

whereupon:

 $\mathbb{E} \left[\langle \phi \left(\mathbf{x}\right) , \phi \left(\mathbf{y}\right) \rangle\right] = \sum_{j = 1}^{D} \mathbb{E} \left[\phi \left(\mathbf{x}\right)_{j} \phi \left(\mathbf{y}\right)_{j}\right] = \frac{D \kappa_{1} \left(\mathbf{x} , \mathbf{y}\right)}{D} = \kappa_{1} \left(\mathbf{x} , \mathbf{y}\right) .$ 
$$
{\mathbb{E}}[\langle \phi ({{{\bf{x}}}}),\phi ({{{\bf{y}}}})\rangle ]=\mathop{\sum}_{j=1}^{D}{\mathbb{E}}[\phi {({{{\bf{x}}}})}_{j}\phi {({{{\bf{y}}}})}_{j}]=\frac{D{\kappa }_{1}({{{\bf{x}}}},{{{\bf{y}}}})}{D}={\kappa }_{1}({{{\bf{x}}}},{{{\bf{y}}}}).
$$

We now show this property is satisfied for an arbitrary integer *p* ≥ 1 using the following binding operators:

#### Component-wise product

As noted above, the case of component-wise product coincides with the earlier work of  [^19], but we re-derive their result here for completeness. Let us define,$\circ :{{{\mathcal{H}}}}\times {{{\mathcal{H}}}}\to {{{\mathcal{H}}}}$ to be $\theta \odot {\theta }^{{\prime} }$, where ⊙ denotes the component-wise product a.k.a. Hadamard product. Now fix some *j* ∈ {1, …, *D* }, and observe that:

 $\phi_{p} \left(\mathbf{x}\right)_{j} = \prod_{t = 1}^{p} \left(\mathbf{w}_{j}^{\left(t\right) \top} \mathbf{x}\right) ,$ 
$$
{\phi }_{p}{({{{\bf{x}}}})}_{j}={\prod}_{t=1}^{p}\left({{{{\bf{w}}}}}_{j}^{(t)\top }{{{\bf{x}}}}\right),
$$

whereupon:

 $\mathbb{E} \left[\phi_{p} \left(\mathbf{x}\right)_{j} \phi_{p} \left(\mathbf{y}\right)_{j}\right] = \mathbb{E} \left[\prod_{t = 1}^{p} \left(\mathbf{w}_{j}^{\left(t\right) \top} \mathbf{x}\right) \left(\mathbf{w}_{j}^{\left(t\right) \top} \mathbf{y}\right)\right] = \prod_{t = 1}^{p} \mathbf{x}^{\top} \mathbb{E} \left[\mathbf{w}_{j}^{\left(t\right)} \mathbf{w}_{j}^{\left(t\right) \top}\right] \mathbf{y} = \prod_{t = 1}^{p} \mathbf{x}^{\top} \mathbf{y} = \frac{\left(\langle \mathbf{x} , \mathbf{y} \rangle\right)^{p}}{D} = \frac{\kappa_{p} \left(\mathbf{x} , \mathbf{y}\right)}{D} ,$ 
$$
\begin{aligned}
{\mathbb{E}}[{\phi }_{p}{({{{\bf{x}}}})}_{j}{\phi }_{p}{({{{\bf{y}}}})}_{j}]	={\mathbb{E}}\left[{\prod}_{t=1}^{p}({{{{\bf{w}}}}}_{j}^{(t)\top }{{{\bf{x}}}})({{{{\bf{w}}}}}_{j}^{(t)\top }{{{\bf{y}}}})\right]\\ 	={\prod}_{t=1}^{p}{{{{\bf{x}}}}}^{\top }{\mathbb{E}}\left[{{{{\bf{w}}}}}_{j}^{(t)}{{{{\bf{w}}}}}_{j}^{(t)\top }\right]{{{\bf{y}}}}\\ 	={\prod}_{t=1}^{p}{{{{\bf{x}}}}}^{\top }{{{\bf{y}}}}=\frac{{\langle {{{\bf{x}}}},{{{\bf{y}}}}\rangle }^{p}}{D}=\frac{{\kappa }_{p}({{{\bf{x}}}},{{{\bf{y}}}})}{D},
\end{aligned}
$$

where we have used the fact that ${{{{\bf{w}}}}}_{j}^{(1)},\ldots,{{{{\bf{w}}}}}_{j}^{(p)}$ are independent to decompose the expectation over the product. Therefore:

 $\mathbb{E} \left[\langle \phi_{p} \left(\mathbf{x}\right) , \phi_{p} \left(\right. \mathbf{y} \rangle\right] = \kappa_{p} \left(\mathbf{x} , \mathbf{y}\right) ,$ 
$$
{\mathbb{E}}[\langle {\phi }_{p}({{{\bf{x}}}}),{\phi }_{p}\left.\right({{{\bf{y}}}}\rangle ]={\kappa }_{p}({{{\bf{x}}}},{{{\bf{y}}}}),
$$

as claimed. We make the following remark concerning a potentially more efficient implementation of the scheme above using the permutation operation.

### Remark 1

The derivation above only requires *p* -wise independence among any set of **w** <sub><i>j</i></sub> ’s. This could also be achieved by generating *ψ* <sub>1</sub> (**x**) =  **W** **x**, and then generating subsequent *ψ* <sub><i>i</i></sub> (**x**)s via permutation. That is to say, let *ρ* ( ⋅ ) be a permutation on \[*D*\] with cycle time at least *p*. We then set *ψ* <sub>2</sub> (**x**) =  *ρ* (*ψ* <sub>1</sub> (**x**)), *ψ* <sub>3</sub> (**x**) =  *ρ* (*ψ* <sub>2</sub> (**x**)) =  *ρ* <sup>2</sup> (*ψ* <sub>1</sub> (**x**)), and so on…. This strategy allows us to store and compute **W** **x** only once, which is advantageous computationally and in terms of memory.

### Remark 2

The calculations above describe what happens in expectation over randomness in the draw of the **w** <sub><i>j</i></sub>. However, it is also possible to provide high-probability bounds on the approximation error from a specific instantiation. This question is analyzed at length in [^19], who show that (via their Lemma 8 and Hoeffding’s inequality) for any fixed but arbitrary pair of points **x**, **y**, and any *ϵ*  > 0, to guarantee that:

 $\left|\right. \phi_{p} \left(\mathbf{x}\right) \cdot \phi_{p} \left(\mathbf{y}\right) - \kappa_{p} \left(\mathbf{x} , \mathbf{y}\right) \left|\right. \leq \epsilon ,$ 
$$
| {\phi }_{p}({{{\bf{x}}}})\cdot {\phi }_{p}({{{\bf{y}}}})-{\kappa }_{p}({{{\bf{x}}}},{{{\bf{y}}}})| \le \epsilon,
$$

holds with high-probability over randomness in the draw of **w** <sub>1</sub>, …, **w** <sub><i>p</i></sub>, it suffices to choose:

 $D = O \left(\left(p R / \epsilon\right)^{2}\right) ,$ 
$$
D=O({(pR/\epsilon )}^{2}),
$$

where $R=\max \{\parallel {{{\bf{x}}}}{\parallel }_{1},\parallel {{{\bf{y}}}}{\parallel }_{1}\}$. The crucial insight is that *D* depends just quadratically on the maximum polynomial degree *p*, as opposed to exponentially in the explicit case (albeit at the expense of only achieving an approximation to the true kernel).

#### Circular convolution

Let us take $\circ :{{{\mathcal{H}}}}\times {{{\mathcal{H}}}}\to {{{\mathcal{H}}}}$ to be the discrete, circular convolution operator ⊛, defined as [^37]:

 $\left(\theta \odot \theta^{′}\right)_{j} = \sum_{i = 0}^{D - 1} \theta_{i} \theta_{j - i}^{′} ,$ 
$$
{\left(\theta \circledast {\theta }^{{\prime} }\right)}_{j}={\sum}_{i=0}^{D-1}{\theta }_{i}{\theta }_{j-i}^{{\prime} },
$$

where we think of the first component in *θ* as having an index of 0, and all subscripts are modulo *D*. As noted above, the claim is trivially true for *p*  = 1, and we proceed by induction on *p*. Let us suppose that, for any *p*  > 1:

 $\mathbb{E} \left[\langle \phi_{p - 1} \left(\mathbf{x}\right) , \phi_{p - 1} \left(\mathbf{y}\right) \rangle\right] = \kappa_{p - 1} \left(\mathbf{x} , \mathbf{y}\right) .$ 
$$
{\mathbb{E}}[\langle {\phi }_{p-1}({{{\bf{x}}}}),{\phi }_{p-1}({{{\bf{y}}}})\rangle ]={\kappa }_{p-1}({{{\bf{x}}}},{{{\bf{y}}}}).
$$

Let us fix some *j* ∈ {1, …, *D* }. By definition of ⊛, we have that:

 $\phi_{p} \left(\mathbf{x}\right)_{j} = \left(\phi_{p - 1} \left(\mathbf{x}\right) \odot \psi_{p} \left(\mathbf{x}\right)\right)_{j} = \sum_{i = 0}^{D - 1} \phi_{p - 1} \left(\mathbf{x}\right)_{i} \psi_{p} \left(\mathbf{x}\right)_{j - i} .$ 
$$
{\phi }_{p}{({{{\bf{x}}}})}_{j}={\left({\phi }_{p-1}({{{\bf{x}}}}) \circledast {\psi }_{p}({{{\bf{x}}}})\right)}_{j}={\sum}_{i=0}^{D-1}{\phi }_{p-1}{({{{\bf{x}}}})}_{i}{\psi }_{p}{({{{\bf{x}}}})}_{j-i}.
$$

Thus:

 $\phi_{p} \left(\mathbf{x}\right)_{j} \phi_{p} \left(\mathbf{y}\right)_{j} = \left(\sum_{i = 0}^{D - 1} \phi_{p - 1} \left(\mathbf{x}\right)_{i} \psi_{p} \left(\mathbf{x}\right)_{j - i}\right) \left(\sum_{k = 0}^{D - 1} \phi_{p - 1} \left(\mathbf{y}\right)_{k} \psi_{p} \left(\mathbf{y}\right)_{j - k}\right) = \sum_{i = 0}^{D - 1} \sum_{k = 0}^{D - 1} \phi_{p - 1} \left(\mathbf{x}\right)_{i} \phi_{p - 1} \left(\mathbf{y}\right)_{i} \left(\mathbf{w}_{j - i}^{\left(p\right) \top} \mathbf{x}\right) \left(\mathbf{w}_{j - k}^{\left(p\right) \top} \mathbf{y}\right) = \sum_{i = k = 0}^{D - 1} \phi_{p - 1} \left(\mathbf{x}\right)_{i} \phi_{p - 1} \left(\mathbf{y}\right)_{k} \left(\mathbf{x}^{\top} \mathbf{w}_{j - i}^{\left(p\right)} \mathbf{w}_{j - k}^{\left(p\right) \top} \mathbf{y}\right) + \sum_{i \neq k = 0}^{D - 1} \phi_{p - 1} \left(\mathbf{x}\right)_{i} \phi_{p - 1} \left(\mathbf{y}\right)_{k} \left(\mathbf{x}^{\top} \mathbf{w}_{j - i}^{\left(p\right)} \mathbf{w}_{j - k}^{\left(p\right) \top} \mathbf{y}\right) .$ 
$$
\begin{aligned}
{\phi }_{p}{({{{\bf{x}}}})}_{j}{\phi }_{p}{({{{\bf{y}}}})}_{j}=	\left({\sum}_{i=0}^{D-1}{\phi }_{p-1}{({{{\bf{x}}}})}_{i}{\psi }_{p}{({{{\bf{x}}}})}_{j-i}\right)\left({\sum}_{k=0}^{D-1}{\phi }_{p-1}{({{{\bf{y}}}})}_{k}{\psi }_{p}{({{{\bf{y}}}})}_{j-k}\right)\\=	{\sum}_{i=0}^{D-1}{\sum}_{k=0}^{D-1}{\phi }_{p-1}{({{{\bf{x}}}})}_{i}{\phi }_{p-1}{({{{\bf{y}}}})}_{i}\left({{{{\bf{w}}}}}_{j-i}^{(p)\top }{{{\bf{x}}}}\right)\left({{{{\bf{w}}}}}_{j-k}^{(p)\top }{{{\bf{y}}}}\right)\\=	{\sum}_{i=k=0}^{D-1}{\phi }_{p-1}{({{{\bf{x}}}})}_{i}{\phi }_{p-1}{({{{\bf{y}}}})}_{k}\left({{{{\bf{x}}}}}^{\top }{{{{\bf{w}}}}}_{j-i}^{(p)}{{{{\bf{w}}}}}_{j-k}^{(p)\top }{{{\bf{y}}}}\right)\\ 	+{\sum}_{i\ne k=0}^{D-1}{\phi }_{p-1}{({{{\bf{x}}}})}_{i}{\phi }_{p-1}{({{{\bf{y}}}})}_{k}\left({{{{\bf{x}}}}}^{\top }{{{{\bf{w}}}}}_{j-i}^{(p)}{{{{\bf{w}}}}}_{j-k}^{(p)\top }{{{\bf{y}}}}\right).
\end{aligned}
$$

Let us focus first on the second summation. By independence in the draws of **W** <sup>(1)</sup>, …, **W** <sup>(<i>p</i>)</sup>:

 $\mathbb{E} \left[\sum_{i \neq k = 0}^{D - 1} \phi_{p - 1} \left(\mathbf{x}\right)_{i} \phi_{p - 1} \left(\mathbf{y}\right)_{k} \left(\mathbf{x}^{\top} \mathbf{w}_{j - i}^{\left(p\right)} \mathbf{w}_{j - k}^{\left(p\right) \top} \mathbf{y}\right)\right] = \hdots = \sum_{i \neq k = 0}^{D - 1} \mathbb{E} \left[\phi_{p - 1} \left(\mathbf{x}\right)_{i} \phi_{p - 1} \left(\mathbf{y}\right)_{k}\right] \mathbb{E} \left[\mathbf{x}^{\top} \mathbf{w}_{j - i}^{\left(p\right)} \mathbf{w}_{j - k}^{\left(p\right) \top} \mathbf{y}\right] = 0 ,$ 
$$
\begin{aligned}
{\mathbb{E}}\left[{\sum}_{i\ne k=0}^{D-1}{\phi }_{p-1}{({{{\bf{x}}}})}_{i}{\phi }_{p-1}{({{{\bf{y}}}})}_{k}\left({{{{\bf{x}}}}}^{\top }{{{{\bf{w}}}}}_{j-i}^{(p)}{{{{\bf{w}}}}}_{j-k}^{(p)\top }{{{\bf{y}}}}\right)\right]=\cdots \\ ={\sum}_{i\ne k=0}^{D-1}{\mathbb{E}}\left[{\phi }_{p-1}{({{{\bf{x}}}})}_{i}{\phi }_{p-1}{({{{\bf{y}}}})}_{k}\right]{\mathbb{E}}\left[{{{{\bf{x}}}}}^{\top }{{{{\bf{w}}}}}_{j-i}^{(p)}{{{{\bf{w}}}}}_{j-k}^{(p)\top }{{{\bf{y}}}}\right]=0,
\end{aligned}
$$

since ${\mathbb{E}}[{{{{\bf{w}}}}}_{j-i}^{(p)}{{{{\bf{w}}}}}_{j-k}^{(p)\top }]={{{{\bf{0}}}}}_{d}$ for *i* ≠ *k*, and, thus, the second summation vanishes in expectation. Turning our attention to the first summation, by independence and the inductive assumption, we have:

 $\mathbb{E} \left[\sum_{i = k = 0}^{D - 1} \phi_{p - 1} \left(\mathbf{x}\right)_{i} \phi_{p - 1} \left(\mathbf{y}\right)_{k} \left(\mathbf{x}^{\top} \mathbf{w}_{j - i}^{\left(p\right)} \mathbf{w}_{j - k}^{\left(p\right) \top} \mathbf{y}\right)\right] = \sum_{i = k = 0}^{D - 1} \mathbb{E} \left[\phi_{p - 1} \left(\mathbf{x}\right)_{i} \phi_{p - 1} \left(\mathbf{x}\right)_{k}\right] \mathbb{E} \left[\mathbf{x}^{\top} \mathbf{w}_{j - i}^{\left(p\right)} \mathbf{w}_{j - k}^{\left(p\right) \top} \mathbf{y}\right] = \frac{\mathbb{E} \left[\langle \phi_{p - 1} \left(\mathbf{x}\right) , \phi_{p - 1} \left(\mathbf{y}\right) \rangle\right] \langle \mathbf{x} , \mathbf{y} \rangle}{D} = \frac{\left(\langle \mathbf{x} , \mathbf{y} \rangle\right)^{p - 1} \langle \mathbf{x} , \mathbf{y} \rangle}{D} = \frac{\left(\langle \mathbf{x} , \mathbf{y} \rangle\right)^{p}}{D}$ 
$$
\begin{aligned}
{\mathbb{E}}\left[{\sum}_{i=k=0}^{D-1}{\phi }_{p-1}{({{{\bf{x}}}})}_{i}{\phi }_{p-1}{({{{\bf{y}}}})}_{k}\left({{{{\bf{x}}}}}^{\top }{{{{\bf{w}}}}}_{j-i}^{(p)}{{{{\bf{w}}}}}_{j-k}^{(p)\top }{{{\bf{y}}}}\right)\right]	={\sum}_{i=k=0}^{D-1}{\mathbb{E}}\left[{\phi }_{p-1}{({{{\bf{x}}}})}_{i}{\phi }_{p-1}{({{{\bf{x}}}})}_{k}\right]{\mathbb{E}}\left[{{{{\bf{x}}}}}^{\top }{{{{\bf{w}}}}}_{j-i}^{(p)}{{{{\bf{w}}}}}_{j-k}^{(p)\top }{{{\bf{y}}}}\right]\\ 	=\frac{{\mathbb{E}}[\langle {\phi }_{p-1}({{{\bf{x}}}}),{\phi }_{p-1}({{{\bf{y}}}})\rangle ]\langle {{{\bf{x}}}},{{{\bf{y}}}}\rangle }{D}\\ 	=\frac{{\langle {{{\bf{x}}}},{{{\bf{y}}}}\rangle }^{p-1}\langle {{{\bf{x}}}},{{{\bf{y}}}}\rangle }{D}=\frac{{\langle {{{\bf{x}}}},{{{\bf{y}}}}\rangle }^{p}}{D}
\end{aligned}
$$

Whereupon, we conclude that once again:

 $\mathbb{E} \left[\langle \phi_{p} \left(\mathbf{x}\right) , \phi_{p} \left(\right. \mathbf{y} \rangle\right] = \kappa_{p} \left(\mathbf{x} , \mathbf{y}\right) .$ 
$$
{\mathbb{E}}[\langle {\phi }_{p}({{{\bf{x}}}}),{\phi }_{p}\left.\right({{{\bf{y}}}}\rangle ]={\kappa }_{p}({{{\bf{x}}}},{{{\bf{y}}}}).
$$

### Experiments with traditional reservoir computing networks

Since the literature on reservoir computing is vast, we do not introduce it in detail here (refer, e.g., to refs. [^4] [^40]) but for the sake of completeness we provide the equation for the evolution of the reservoir dynamics of echo state networks that are used as a baseline in the experimental evaluation:

 $\mathbf{F} \left(i\right) = tanh \left(\beta \mathbf{W}_{\mathtt{i} \mathtt{n}} \left[1 \oplus \mathbf{X} \left(i\right)\right] + \gamma \mathbf{W} \mathbf{F} \left(i - 1\right)\right) ,$ 
$$
{{{\bf{F}}}}(i)=\tanh (\beta {{{{\bf{W}}}}}_{{\mathtt{in}}}[1\oplus {{{\bf{X}}}}(i)]+\gamma {{{\bf{W}}}}{{{\bf{F}}}}(i-1)),
$$

(22)

where **F** (*i*) is the *D* -dimensional state of the reservoir at time point *i*. ${{{{\bf{W}}}}}_{{\mathtt{in}}}\in {{\mathbb{R}}}^{D\times d+1}$ is an input projection matrix whose components are drawn uniformly from $[-1,1],{{{\bf{W}}}}\in {{\mathbb{R}}}^{D\times D}$ is a mixing random reservoir connectivity matrix whose components are drawn i.i.d. from the standard normal distribution and then **W** is normalized so that its spectral radius is one (to achieve “echo-state property” [^3]). The contribution of the present state of the system **X** (*i*) is controlled by the projection gain hyperparameter *β* while the contribution of the previous states of the reservoir is controlled by *γ* – the spectral radius of **W**.

### Tasks and experimental configurations

#### Tasks and configurations of feature spaces

To evaluate the distributed representation of the feature space and compare it to the product representation, in the first place, we followed the experimental protocol of study [^12] that involved three tasks as well as included an additional task that was demonstrated to be challenging for the product representation in ref. [^38] and a task involving a dynamical system with many input channels. For all tasks, the readout matrix ${{{{\bf{W}}}}}_{{\mathtt{out}}}$ is obtained using the ridge regression following Eqs. ([9](https://www.nature.com/articles/s41467-025-55832-y#Equ9)) or ([14](https://www.nature.com/articles/s41467-025-55832-y#Equ14)).

The first and fifth tasks are designed using time-series generated by numerically integrating a system developed by Lorenz in 1963 [^50]. The system includes three coupled nonlinear differential equations (referred to as Lorenz63):

 $\overset{\cdot}{x} = 10 \left(y - x\right) , \overset{\cdot}{y} = x \left(28 - z\right) - y , \overset{\cdot}{z} = x y - 8 z / 3 ,$ 
$$
\dot{x}=10(y-x),\,\dot{y}=x(28-z)-y,\,\dot{z}=xy-8z/3,
$$

(23)

thus, system’s state at time point *i* is characterized by vector **X** (*i*) ≡ \[*x* (*i*), *y* (*i*), *z* (*i*)\] <sup>⊤</sup>. The system in Eq. ([23](https://www.nature.com/articles/s41467-025-55832-y#Equ23)) forms a strange chaotic attractor so it displays deterministic chaos that is sensitive to initial conditions (Lyapunov time is 1.1-time units). The system is sampled at *d* *t*  = 0.025 and models are trained on *r*  = 400 time points that is about ten Lyapunov times. Supplementary Material [S-IX](https://www.nature.com/articles/s41467-025-55832-y#MOESM1) reports the results of experiments with varying amounts of training data in the range *r* ∈ \[160, 960\].

The second system forming a strange chaotic attractor that is used for the second task is a double-scroll electronic circuit [^51]. It is described by (system’s state is ${{{\bf{X}}}}(i)\equiv {[{V}_{1}(i),{V}_{2}(i),I(i)]}^{\top }$):

 $\overset{\cdot}{V}_{1} = V_{1} / R_{1} - \Delta V / R_{2} - 2 I_{r} sinh \left(\beta \Delta V\right) , \overset{\cdot}{V}_{2} = \Delta V / R_{2} + 2 I_{r} sinh \left(\beta \Delta V\right) - I , \overset{\cdot}{I} = V_{2} - R_{4} I$ 
$$
\begin{aligned}
{\dot{V}}_{1}=	{V}_{1}/{R}_{1}-\Delta V/{R}_{2}-2{I}_{r}\sinh (\beta \Delta V),\,{\dot{V}}_{2}=\Delta V/{R}_{2}+2{I}_{r}\sinh (\beta \Delta V)\\ 	-I,\,\dot{I}={V}_{2}-{R}_{4}I
\end{aligned}
$$

(24)

where *Δ* *V*  =  *V* <sub>1</sub>  −  *V* <sub>2</sub>; while the parameters are set to *R* <sub>1</sub>  = 1.2, *R* <sub>2</sub>  = 3.44, *R* <sub>4</sub>  = 0.193, *β*  = 11.6, and *I* <sub><i>r</i></sub>  = 2.25 × 10 <sup>−5</sup> resulting in a Lyapunov time of 7.8-time units. To account for slower Lyapunov time, the system is sampled at *d* *t* = 0.25 but models are still trained on *r* = 400 time points.

The third system is the Mackey–Glass [^52] that is used frequently within, e.g., the reservoir computing literature as a showcase [^3] [^53]. It is formulated using the following time-delay differential equation:

 $\overset{\cdot}{u} \left(t\right) = \beta \frac{u \left(t - \tau\right)}{1 + u \left(t - \tau\right)^{n}} - \gamma u \left(t\right) ,$ 
$$
\dot{u}(t)=\beta \frac{u(t-\tau )}{1+u{(t-\tau )}^{n}}-\gamma u(t),
$$

(25)

where the parameters are set to *β*  = 0.2, *γ*  = 0.1  *τ*  = 17, and *n*  = 10 (Lyapunov time is about 185-time units). Similar to the above systems, the training data spans about ten Lyapunov times but the system is sampled at *d* *t*  = 3.0 resulting in *r*  = 600 training time points. The number of training points is higher than for the two systems above because increasing *d* *t* further substantially worsens the predictive performance.

The fourth system is the Kuramoto–Sivashinsky system [^54] that was used to introduce the parallel reservoir computing scheme [^55]. It describes the slow variation of the vibration function of a system extended in the space with the fourth-order partial differential equation:

 $\overset{\cdot}{u} \left(t\right) = - u \overset{\cdot}{u} \left(x\right) - \overset{\cdot\cdot}{u} \left(x^{2}\right) - u^{. . . .} \left(x^{4}\right) ,$ 
$$
\dot{u}(t)=-u\dot{u}(x)-\ddot{u}({x}^{2})-{u}^{{{\mathrm{....}}}\,}({x}^{4}),
$$

(26)

where the scalar field *y* (*x*, *t*) is periodic in the interval $[0,{{{\mathcal{L}}}}]$; ${{{\mathcal{L}}}}=22$ in this study (Lyapunov time is about 20-time units). In contrast to the above systems, the training data had to be increased substantially so it spans one hundred Lyapunov times. The system is integrated on a grid of sixteen equally spaced points (*d*  = 16) and is sampled at *d* *t*  = 0.5 resulting in *r*  = 4000 training time points.

The first three tasks that were reported in “Experiments on CPU” section of the main text while the fourth task is reported in Supplementary Material [S-I](https://www.nature.com/articles/s41467-025-55832-y#MOESM1) using the time-series produced by the above systems in Eqs. ([23](https://www.nature.com/articles/s41467-025-55832-y#Equ23))–([26](https://www.nature.com/articles/s41467-025-55832-y#Equ26)) to predict their dynamics using one-step-ahead prediction. In particular, the readout matrices ${{{{\bf{W}}}}}_{{\mathtt{out}}}$ for the models are trained to predict the difference between the current and the next states of the system (**Y** (*i*) =  **X** (*i*  + 1) −  **X** (*i*)) using either baseline models, product representation (“Product representation of higher-order features” section) or distributed representation (“Randomized representations of higher-order features with binding” section) of the feature space that are formed from *k* single time points of the system (i.e., the trajectory) that are parameterized by *k* -tuple ${{{\mathcal{M}}}}$ where indices within the tuple are specified relative to the current time point *i*. For the sake of fair comparison with the product representation, the experiments with the distributed representation are performed with the idealized memory buffer that stores exactly *k* single time points.

During the training phase, states of the system and the corresponding target values are provided as the ground truth (i.e., teacher forcing [^56]). For the first four tasks, during the prediction phase, the model’s prediction at the *i* -th time point is used as an input for the *i*  + 1-th time point so the model operates in the autoregressive mode, i.e., autonomously unfolding in time without any external signal such that $\hat{{{{\bf{X}}}}}(i+1)=\hat{{{{\bf{X}}}}}(i)+{{{{\bf{W}}}}}_{{\mathtt{out}}}{{{\bf{G}}}}(i)$ or $\hat{{{{\bf{X}}}}}(i+1)=\hat{{{{\bf{X}}}}}(i)+{{{{\bf{W}}}}}_{{\mathtt{out}}}{{{\bf{F}}}}(i)$.

For predicting the Lorenz63 system, the feature space includes constant bias (set to 1), first- as well second-order features, ${{{\mathcal{T}}}}=(0,1)$, that for the product representation is obtained as:

 $\mathbf{G} \left(i\right) = 1 \oplus \mathbf{G}^{\left(1\right)} \left(i\right) \oplus \mathbf{G}^{\left(2\right)} \left(i\right) ,$ 
$$
{{{\bf{G}}}}(i)=1\oplus {{{{\bf{G}}}}}^{(1)}(i)\oplus {{{{\bf{G}}}}}^{(2)}(i),
$$

(27)

where the representation includes $1+dk+\frac{dk(dk+1)}{2}$ features, which given the concrete values of hyperparameters: $d=3,k=2,{{{\mathcal{M}}}}=(i,i-1)$, results in 28 dimensions in **G** (*i*).

The corresponding randomized distributed representation is obtained as:

 $\mathbf{F} \left(i\right) = 1 \oplus \left[\mathbf{F}^{\left(1\right)} \left(i\right) + \mathbf{F}^{\left(2\right)} \left(i\right)\right] = 1 \oplus \left[\mathbf{F}^{\left(1\right)} \left(i\right) + \mathbf{F}^{\left(1\right)} \left(i\right) \circ \rho \left(\mathbf{F}^{\left(1\right)} \left(i\right)\right)\right] ,$ 
$$
{{{\bf{F}}}}(i)=1\oplus [{{{{\bf{F}}}}}^{(1)}(i)+{{{{\bf{F}}}}}^{(2)}(i)]=1\oplus [{{{{\bf{F}}}}}^{(1)}(i)+{{{{\bf{F}}}}}^{(1)}(i)\circ \rho ({{{{\bf{F}}}}}^{(1)}(i))],
$$

(28)

where the representation is *D* -dimensional. Supplementary Material [S-V](https://www.nature.com/articles/s41467-025-55832-y#MOESM1) shows the results of experiments with other configurations of ${{{\mathcal{T}}}}$.

For predicting the double-scroll system, third-order features are used, ${{{\mathcal{T}}}}=(0,2)$, due to attractor’s odd symmetry so that the product representation is formed as:

 $\mathbf{G} \left(i\right) = \mathbf{G}^{\left(1\right)} \left(i\right) \oplus \mathbf{G}^{\left(3\right)} \left(i\right) ,$ 
$$
{{{\bf{G}}}}(i)={{{{\bf{G}}}}}^{(1)}(i)\oplus {{{{\bf{G}}}}}^{(3)}(i),
$$

(29)

which has $dk+\frac{dk(dk+1)(dk+2)}{6}$ dimensions, which given the concrete values of hyperparameters: $d=3,k=2,{{{\mathcal{M}}}}=(i,i-1)$ results in 62 dimensions in **G** (*i*).

The corresponding *D* -dimensional randomized distributed representation is formed as:

 $\mathbf{F} \left(i\right) = 1 \oplus \left[\mathbf{F}^{\left(1\right)} \left(i\right) + \mathbf{F}^{\left(3\right)} \left(i\right)\right] = 1 \oplus \left[\mathbf{F}^{\left(1\right)} \left(i\right) + \mathbf{F}^{\left(1\right)} \left(i\right) \circ \rho \left(\mathbf{F}^{\left(1\right)} \left(i\right)\right) \circ \rho^{2} \left(\mathbf{F}^{\left(1\right)} \left(i\right)\right)\right] ,$ 
$$
{{{\bf{F}}}}(i)=1\oplus [{{{{\bf{F}}}}}^{(1)}(i)+{{{{\bf{F}}}}}^{(3)}(i)]=1\oplus [{{{{\bf{F}}}}}^{(1)}(i)+{{{{\bf{F}}}}}^{(1)}(i)\circ \rho ({{{{\bf{F}}}}}^{(1)}(i))\circ {\rho }^{2}({{{{\bf{F}}}}}^{(1)}(i))],
$$

(30)

where the constant bias is also not necessary as for the Lorenz63 system but is used for the sake of consistency with the models for other tasks.

For the Mackey–Glass system, features up to third-order are used in the simplest product representation, ${{{\mathcal{T}}}}=(0,1,2)$:

 $\mathbf{G} \left(i\right) = 1 \oplus \mathbf{G}^{\left(1\right)} \left(i\right) \oplus \mathbf{G}^{\left(2\right)} \left(i\right) \oplus \mathbf{G}^{\left(3\right)} \left(i\right) ,$ 
$$
{{{\bf{G}}}}(i)=1\oplus {{{{\bf{G}}}}}^{(1)}(i)\oplus {{{{\bf{G}}}}}^{(2)}(i)\oplus {{{{\bf{G}}}}}^{(3)}(i),
$$

(31)

with $1+dk+\frac{dk(dk+1)}{2}+\frac{dk(dk+1)(dk+2)}{6}$ features. In the Mackey–Glass system, there is only one observable state so *d*  = 1 but *k* is set to 6 (see Chapter 5.4 in ref. [^38] for details of choosing the delay taps) producing 84 features for **G** (*i*).

For the distributed representation, this task is used to demonstrate that it dissects the strict dependency between *D* and the number of polynomial features; this approach, therefore, investigates several configurations starting from the representation that includes features up to fourth-order, ${{{\mathcal{T}}}}=(0,1,2,3)$:

 $\mathbf{F} \left(i\right) = 1 \oplus \left[\mathbf{F}^{\left(1\right)} \left(i\right) + \mathbf{F}^{\left(2\right)} \left(i\right) + \mathbf{F}^{\left(3\right)} \left(i\right) + \mathbf{F}^{\left(4\right)} \left(i\right)\right] .$ 
$$
{{{\bf{F}}}}(i)=1\oplus [{{{{\bf{F}}}}}^{(1)}(i)+{{{{\bf{F}}}}}^{(2)}(i)+{{{{\bf{F}}}}}^{(3)}(i)+{{{{\bf{F}}}}}^{(4)}(i)].
$$

(32)

and all the way up to representations with features of up to order seven.

For the Kuramoto–Sivashinsky system, features up to third-order are used in the product representation, ${{{\mathcal{T}}}}=(0,1,2)$:

 $\mathbf{G} \left(i\right) = 1 \oplus \mathbf{G}^{\left(1\right)} \left(i\right) \oplus \mathbf{G}^{\left(2\right)} \left(i\right) \oplus \mathbf{G}^{\left(3\right)} \left(i\right) ,$ 
$$
{{{\bf{G}}}}(i)=1\oplus {{{{\bf{G}}}}}^{(1)}(i)\oplus {{{{\bf{G}}}}}^{(2)}(i)\oplus {{{{\bf{G}}}}}^{(3)}(i),
$$

(33)

with $1+dk+\frac{dk(dk+1)}{2}+\frac{dk(dk+1)(dk+2)}{6}$ features. Given sixteen observable states *d*  = 16 and *k*  = 2, **G** (*i*) includes 6, 545 features.

The corresponding *D* -dimensional randomized distributed representation is formed as:

 $\mathbf{F} \left(i\right) = 1 \oplus \left[\mathbf{F}^{\left(1\right)} \left(i\right) + \mathbf{F}^{\left(2\right)} \left(i\right) + \mathbf{F}^{\left(3\right)} \left(i\right)\right] .$ 
$$
{{{\bf{F}}}}(i)=1\oplus [{{{{\bf{F}}}}}^{(1)}(i)+{{{{\bf{F}}}}}^{(2)}(i)+{{{{\bf{F}}}}}^{(3)}(i)].
$$

(34)

Finally, the fifth task also uses the Lorenz63 system to imitate the scenario where not all observable states are available upon the deployment of the model so some missing data needs to be predicted. During the training phase, all three states are observed where values of state *z* at *i* -th time point are used as the ground truth (**Y** (*i*) =  *z* (*i*)) for one-step-ahead prediction from the previously observed values of *x* and *y* states. Thus, during the prediction phase, the model is only observing *x* and *y* states and tries to infer the value of *z* at the current time point. As in the first task, here, first- and second-order features, ${{{\mathcal{T}}}}=(0,1)$, are sufficient to obtain predictions of high quality. For the sake of brevity of the main text, the results for this task are reported in Supplementary Material [S-II](https://www.nature.com/articles/s41467-025-55832-y#MOESM1).

#### Choice of hyperparameters

The first half of this section introduced the considered tasks and the corresponding configurations for constructing the feature spaces for the product and distributed representations. Upon defining the construction of the feature space, there are at most two hyperparameters remaining: (1) the regularization parameter *α* for obtaining the readout matrix, and (2) the dimensionality, *D*, of the randomized representations. Note that (2) is only necessary for the distributed representation. For both approaches, the choice of the regularization parameter was performed separately for each task. The grid search was in the range *α* ∈ {1 × 10 <sup>−12</sup>, 1 × 10 <sup>−11</sup>, …, 1} where for each value in the range 1000 randomly initialized realizations of the considered systems were evaluated (100 for the Kuramoto–Sivashinsky system due to the computing costs). For each realization, the normalized root-mean-square error (“Performance metrics” section) was computed over three Lyapunov times. The value resulting in the smallest median error was chosen as the optimal one. The optimal values of *α* are indicated next to each specific experiment. For the distributed representation, while searching for optimal *α*, the value of *D* was fixed to the dimensionality of the corresponding product representation, Eq. ([8](https://www.nature.com/articles/s41467-025-55832-y#Equ8)). The same *α* was used when conducting experiments involving varying *D*.

Since the feature space in echo-state networks is defined implicitly, a larger hyperparameter search is needed for proper comparison. In addition to the dimensionality of the reservoir, *D*, and regularization parameter, *α*, we also considered the projection gain of the input *β* and the spectral radius of the reservoir connectivity matrix *γ*, cf. Eq. ([22](https://www.nature.com/articles/s41467-025-55832-y#Equ22)). As for the distributed representation, while performing the grid search over *α*, *β*, and *γ*, *D* was set to match the configuration of the product representation for the considered task. For the grid search, the range of *α* was the same as above while for *β* and *γ*, we followed the configuration from ref. [^57] with seven points for each parameter that were distributed evenly in the range \[0.1, 1\]. Thus, for each task, 637 different configurations of hyperparameters were considered for the echo-state network. As with the other approaches, the best configuration was chosen based on the median normalized root-mean-square error across 1000 different realizations of the considered systems (100 for the Kuramoto–Sivashinsky system).

### Performance metrics

As a way to measure the quality of predictions for the experiments in the main text and [Supplementary Material](https://www.nature.com/articles/s41467-025-55832-y#MOESM1), a standard metric is used – normalized root-mean-square error (NRMSE). Given the ground truth ${{{\bf{Y}}}}\in {{\mathbb{R}}}^{m\times r}$ with *m* output states & *r* evaluation samples as well as the corresponding predictions in $\hat{{{{\bf{Y}}}}}$, NRMSE is computed as:

 $\mathtt{N} \mathtt{R} \mathtt{M} \mathtt{S} \mathtt{E} = \sqrt{\frac{\sum_{i = 1}^{r} \sum_{j = 1}^{m} \left(\mathbf{Y}_{j} \left(i\right) - \hat{\mathbf{Y}}_{j} \left(i\right)\right)^{2}}{m r \sum_{j = 1}^{m} \sigma_{\mathbf{Y}_{j :}}^{2}}} ,$ 
$$
{\mathtt{NRMSE}}=\sqrt{\frac{\mathop{\sum}_{i=1}^{r}\mathop{\sum }_{j=1}^{m}{\left({{{{\bf{Y}}}}}_{j}(i)-{\hat{{{{\bf{Y}}}}}}_{j}(i)\right)}^{2}}{mr\mathop{\sum }_{j=1}^{m}{\sigma }_{{{{{\bf{Y}}}}}_{j:}}^{2}}},
$$

(35)

where ${\sigma }_{{{{{\bf{Y}}}}}_{j:}}^{2}$ denotes the empirical variance (i.e., the variance calculated numerically from the data) of the *j* th output state.

## Data availability

The data that support the plots within this study and other findings can be generated using the available code and data available online in the Code Ocean at [https://doi.org/10.24433/CO.7208482.v2](https://doi.org/10.24433/CO.7208482.v2).

## Code availability

The computer code and/or data used to produce the results reported in the study accompany this article and are deposited in the Code Ocean; available online at [https://doi.org/10.24433/CO.7208482.v2](https://doi.org/10.24433/CO.7208482.v2).
