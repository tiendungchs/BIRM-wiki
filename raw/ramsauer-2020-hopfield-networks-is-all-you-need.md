---
title: "Hopfield Networks is All You Need"
source: "https://ar5iv.labs.arxiv.org/html/2008.02217"
author:
published:
created: 2026-09-19
description: "We introduce a modern Hopfield networkwith continuous states and a corresponding update rule.The new Hopfield network can storeexponentially (with the dimension of theassociative space) many patterns,retrieves the…"
tags:
  - "clippings"
---
Hubert Ramsauer <sup>1</sup> Bernhard Schäfl <sup>1</sup> Johannes Lehner <sup>1</sup> Philipp Seidl <sup>1</sup> Michael Widrich <sup>1</sup> Thomas Adler <sup>1</sup> Lukas Gruber <sup>1</sup> Markus Holzleitner <sup>1</sup>    Milena Pavlović <sup>3</sup>   <sup>4</sup> Geir Kjetil Sandve <sup>4</sup> Victor Greiff <sup>3</sup> David Kreil <sup>2</sup> Michael Kopp <sup>2</sup> Günter Klambauer <sup>1</sup> Johannes Brandstetter <sup>1</sup>    Sepp Hochreiter <sup>1</sup>   <sup>2</sup> <sup>1</sup> ELLIS Unit Linz, LIT AI Lab, Institute for Machine Learning, Johannes Kepler University Linz, Austria <sup>2</sup> Institute of Advanced Research in Artificial Intelligence (IARAI) <sup>3</sup> Department of Immunology, University of Oslo, Norway <sup>4</sup> Department of Informatics, University of Oslo, Norway

###### Abstract

We introduce a modern Hopfield network with continuous states and a corresponding update rule. The new Hopfield network can store exponentially (with the dimension of the associative space) many patterns, retrieves the pattern with one update, and has exponentially small retrieval errors. It has three types of energy minima (fixed points of the update): (1) global fixed point averaging over all patterns, (2) metastable states averaging over a subset of patterns, and (3) fixed points which store a single pattern. The new update rule is equivalent to the attention mechanism used in transformers. This equivalence enables a characterization of the heads of transformer models. These heads perform in the first layers preferably global averaging and in higher layers partial averaging via metastable states. The new modern Hopfield network can be integrated into deep learning architectures as layers to allow the storage of and access to raw input data, intermediate results, or learned prototypes. These Hopfield layers enable new ways of deep learning, beyond fully-connected, convolutional, or recurrent networks, and provide pooling, memory, association, and attention mechanisms. We demonstrate the broad applicability of the Hopfield layers across various domains. Hopfield layers improved state-of-the-art on three out of four considered multiple instance learning problems as well as on immune repertoire classification with several hundreds of thousands of instances. On the UCI benchmark collections of small classification tasks, where deep learning methods typically struggle, Hopfield layers yielded a new state-of-the-art when compared to different machine learning methods. Finally, Hopfield layers achieved state-of-the-art on two drug design datasets. The implementation is available at: [https://github.com/ml-jku/hopfield-layers](https://github.com/ml-jku/hopfield-layers)

## 1 Introduction

The deep learning community has been looking for alternatives to recurrent neural networks (RNNs) for storing information. For example, linear memory networks use a linear autoencoder for sequences as a memory [^20]. Additional memories for RNNs like holographic reduced representations [^28], tensor product representations [^80] [^81] and classical associative memories (extended to fast weight approaches) [^83] [^6] [^7] [^118] [^82] have been suggested. Most approaches to new memories are based on attention. The neural Turing machine (NTM) is equipped with an external memory and an attention process [^41]. Memory networks [^104] use an $\arg\max$ attention by first mapping a query and patterns into a space and then retrieving the pattern with the largest dot product. End to end memory networks (EMN) make this attention scheme differentiable by replacing $\arg\max$ through a $\mathrm{softmax}$ [^88] [^89]. EMN with dot products became very popular and implement a key-value attention [^29] for self-attention. An enhancement of EMN is the transformer [^96] [^97] and its extensions [^30]. The transformer has had a great impact on the natural language processing (NLP) community, in particular via the BERT models [^32] [^33].

Contribution of this work: (i) introducing novel deep learning layers that are equipped with a memory via modern Hopfield networks, (ii) introducing a novel energy function and a novel update rule for continuous modern Hopfield networks that are differentiable and typically retrieve patterns after one update. Differentiability is required for gradient descent parameter updates and retrieval with one update is compatible with activating the layers of deep networks.

We suggest using modern Hopfield networks to store information or learned prototypes in different layers of neural networks. Binary Hopfield networks were introduced as associative memories that can store and retrieve patterns [^47]. A query pattern can retrieve the pattern to which it is most similar or an average over similar patterns. Hopfield networks seem to be an ancient technique, however, new energy functions improved their properties. The stability of spurious states or metastable states was sensibly reduced [^10]. The largest and most impactful successes are reported on increasing the storage capacity of Hopfield networks. In a $d$ -dimensional space, the standard Hopfield model can store $d$ uncorrelated patterns without errors but only $Cd/\log(d)$ random patterns with $C<1/2$ for a fixed stable pattern or $C<1/4$ if all patterns are stable [^70]. The same bound holds for nonlinear learning rules [^69]. Using tricks-of-trade and allowing small retrieval errors, the storage capacity is about $0.138d$ [^27] [^43] [^95]. If the learning rule is not related to the Hebb rule, then up to $d$ patterns can be stored [^1]. For Hopfield networks with non-zero diagonal matrices, the storage can be increased to $Cd\log(d)$ [^37]. In contrast to the storage capacity, the number of energy minima (spurious states, stable states) of Hopfield networks is exponential in $d$ [^91] [^15] [^100].

The standard binary Hopfield network has an energy function that can be expressed as the sum of interaction functions $F$ with $F(x)=x^{2}$. Modern Hopfield networks, also called “dense associative memory” (DAM) models, use an energy function with interaction functions of the form $F(x)=x^{n}$ and, thereby, achieve a storage capacity proportional to $d^{n-1}$ [^59] [^60]. The energy function of modern Hopfield networks makes them robust against adversarial attacks [^60]. Modern binary Hopfield networks with energy functions based on interaction functions of the form $F(x)=\exp(x)$ even lead to storage capacity of $2^{d/2}$, where all stored binary patterns are fixed points but the radius of attraction vanishes [^31]. However, in order to integrate Hopfield networks into deep learning architectures, it is necessary to make them differentiable, that is, we require continuous Hopfield networks [^48] [^57].

Therefore, we generalize the energy function of [^31] that builds on exponential interaction functions to continuous patterns and states and obtain a new modern Hopfield network. We also propose a new update rule which ensures global convergence to stationary points of the energy (local minima or saddle points). We prove that our new modern Hopfield network typically retrieves patterns in one update step ($\epsilon$ -close to the fixed point) with an exponentially low error and has a storage capacity proportional to $c^{\frac{d-1}{4}}$ (reasonable settings for $c=1.37$ and $c=3.15$ are given in Theorem 3). The retrieval of patterns with one update is important to integrate Hopfield networks in deep learning architectures, where layers are activated only once. Surprisingly, our new update rule is also the key-value attention as used in transformer and BERT models (see Fig. 1). Our modern Hopfield networks can be integrated as a new layer in deep learning architectures for pooling, memory, prototype learning, and attention. We test these new layers on different benchmark datasets and tasks like immune repertoire classification.

![Refer to caption](https://ar5iv.labs.arxiv.org/html/2008.02217/assets/HopfieldToTransformerD.png)

Figure 1: We generalize the energy of binary modern Hopfield networks to continuous states while keeping fast convergence and storage capacity properties. We also propose a new update rule that minimizes the energy. The new update rule is the attention mechanism of the transformer. Formulae are modified to express softmax \\mathrm{softmax} as row vector. “ = ”-sign means “keeps the properties”.

## 2 Modern Hopfield Nets with Continuous States

##### New energy function for continuous state Hopfield networks.

In order to integrate modern Hopfield networks into deep learning architectures, we have to make them continuous. To allow for continuous states, we propose a new energy function that is a modification of the energy of modern Hopfield networks [^31]. We also propose a new update rule which can be proven to converge to stationary points of the energy (local minima or saddle points).

We have $N$ stored (key) patterns $\bm{x}_{i}\in\mathbb{R}^{d}$ represented by the matrix $\bm{X}=\left(\bm{x}_{1},\ldots,\bm{x}_{N}\right)$ with the largest pattern $M=\max_{i}{{\left\|\bm{x}_{i}\right\|}}$. The state (query) pattern is $\bm{\xi}\in\mathbb{R}^{d}$. For exponential interaction functions, we need the log-sum-exp function ($\mathrm{lse}$) for $0<\beta$

$$
\displaystyle\mathrm{lse}(\beta,\bm{x})\
$$
 
$$
\displaystyle=\ \beta^{-1}\log\left(\sum_{i=1}^{N}\exp(\beta x_{i})\right)\ ,
$$

which is convex (see appendix Eq. (461), and Lemma A22). The energy function $\mathrm{E}$ of the modern Hopfield networks for binary patterns $\bm{x}_{i}$ and a binary state pattern $\bm{\xi}$ is $\mathrm{E}=-\sum_{i=1}^{N}F\left(\bm{\xi}^{T}\bm{x}_{i}\right)$ [^59]. Here, $F(x)=x^{n}$ is the interaction function, where $n=2$ gives the classical Hopfield network. The storage capacity is proportional to $d^{n-1}$ [^59]. This model was generalized by [^31] to exponential interaction functions $F(x)=\exp(x)$ which gives the energy $\mathrm{E}=-\exp(\mathrm{lse}(1,\bm{X}^{T}\bm{\xi}))$. This energy leads to an exponential storage capacity of $N=2^{d/2}$ for binary patterns. Furthermore, with a single update, the fixed point is recovered with high probability for random patterns. However, still this modern Hopfield network has binary states.

We generalize this energy function to continuous-valued patterns while keeping the properties of the modern Hopfield networks like the exponential storage capacity and the extremely fast convergence (see Fig. 1). For the new energy we take the logarithm of the negative energy of modern Hopfield networks and add a quadratic term of the current state. The quadratic term ensures that the norm of the state vector $\bm{\xi}$ remains finite and the energy is bounded. Classical Hopfield networks do not require to bound the norm of their state vector, since it is binary and has fixed length. We define the novel energy function $\mathrm{E}$ as

$$
\displaystyle\mathrm{E}\
$$
 
$$
\displaystyle=\ -\ \mathrm{lse}(\beta,\bm{X}^{T}\bm{\xi})\ +\ \frac{1}{2}\bm{\xi}^{T}\bm{\xi}\ +\ \beta^{-1}\log N\ +\ \frac{1}{2}M^{2}\ .
$$

We have $0\leqslant\mathrm{E}\leqslant 2M^{2}$ (see appendix Lemma A1). Using $\bm{p}=\mathrm{softmax}(\beta\bm{X}^{T}\bm{\xi})$, we define a novel update rule (see Fig. 1):

$$
\displaystyle\bm{\xi}^{\mathrm{new}}\
$$
 
$$
\displaystyle=\ f(\bm{\xi})\ =\ \bm{X}\bm{p}\ =\ \bm{X}\mathrm{softmax}(\beta\bm{X}^{T}\bm{\xi})\ .
$$

The next theorem states that the update rule Eq. (3) converges globally. The proof uses the Concave-Convex Procedure (CCCP) [^113] [^114], which is equivalent to Legendre minimization [^77] [^78] algorithms [^114].

###### Theorem 1.

The update rule Eq. (3) converges globally: For $\bm{\xi}^{t+1}=f(\bm{\xi}^{t})$, the energy $\mathrm{E}(\bm{\xi}^{t})\to\mathrm{E}(\bm{\xi}^{*})$ for $t\to\infty$ and a fixed point $\bm{\xi}^{*}$.

###### Proof.

The update rule in Eq. (3) is the CCCP for minimizing the energy $\mathrm{E}$, which is the sum of the convex $1/2\bm{\xi}^{T}\bm{\xi}$ and concave $-\mathrm{lse}$ (see details in appendix Theorem 1). Theorem 2 in [^113] yields the global convergence property. Also, in Theorem 2 in [^86] the global convergence of CCCP is proven via a rigorous analysis using Zangwill’s global convergence theory of iterative algorithms. ∎

The global convergence theorem only assures that for the energy $\mathrm{E}(\bm{\xi}^{t})\to\mathrm{E}(\bm{\xi}^{*})$ for $t\to\infty$ but not $\bm{\xi}^{t}\to\bm{\xi}^{*}$. The next theorem strengthens Zangwill’s global convergence theorem [^71] and gives convergence results similar to those known for expectation maximization [^108].

###### Theorem 2.

For the iteration Eq. (3) we have $\mathrm{E}\left(\bm{\xi}^{t}\right)\to\mathrm{E}\left(\bm{\xi}^{*}\right)=\mathrm{E}^{*}$ as $t\to\infty$, for some stationary point $\bm{\xi}^{*}$. Furthermore, ${{\left\|\bm{\xi}^{t+1}-\bm{\xi}^{t}\right\|}}\to 0$ and either $\{\bm{\xi}^{t}\}_{t=0}^{\infty}$ converges or, in the other case, the set of limit points of $\{\bm{\xi}^{t}\}_{t=0}^{\infty}$ is a connected and compact subset of $\mathcal{L}\left(\mathrm{E}^{*}\right)$, where $\mathcal{L}\left(a\right)=\{\bm{\xi}\in\mathcal{L}\mid\mathrm{E}\left(\bm{\xi}\right)=a\}$ and $\mathcal{L}$ is the set of stationary points of the iteration Eq. (3). If $\mathcal{L}\left(\mathrm{E}^{*}\right)$ is finite, then any sequence $\{\bm{\xi}^{t}\}_{t=0}^{\infty}$ generated by the iteration Eq. (3) converges to some $\bm{\xi}^{*}\in\mathcal{L}\left(\mathrm{E}^{*}\right)$.

For a proof, see appendix Theorem 2. Therefore, all the limit points of any sequence generated by the iteration Eq. (3) are stationary points (local minima or saddle points) of the energy function $\mathrm{E}$. Either the iteration converges or, otherwise, the set of limit points is a connected and compact set.

The next theorem gives the results on the storage capacity of our new continuous state modern Hopfield network. We first define what we mean by storing and retrieving patterns using a modern Hopfield network with continuous states.

###### Definition 1 (Pattern Stored and Retrieved).

We assume that around every pattern $\bm{x}_{i}$ a sphere $\mathrm{S}_{i}$ is given. We say $\bm{x}_{i}$ is stored if there is a single fixed point $\bm{x}_{i}^{*}\in\mathrm{S}_{i}$ to which all points $\bm{\xi}\in\mathrm{S}_{i}$ converge, and $\mathrm{S}_{i}\cap\mathrm{S}_{j}=\emptyset$ for $i\not=j$. We say $\bm{x}_{i}$ is retrieved for a given $\epsilon$ if iteration (update rule) Eq. (3) gives a point $\tilde{\bm{x}}_{i}$ that is at least $\epsilon$ -close to the single fixed point $\bm{x}_{i}^{*}\in\mathrm{S}_{i}$. The retrieval error is ${{\left\|\tilde{\bm{x}}_{i}-\bm{x}_{i}\right\|}}$.

As with classical Hopfield networks, we consider patterns on the sphere, i.e. patterns with a fixed norm. For randomly chosen patterns, the number of patterns that can be stored is exponential in the dimension $d$ of the space of the patterns ($\bm{x}_{i}\in\mathbb{R}^{d}$).

###### Theorem 3.

We assume a failure probability $0<p\leqslant 1$ and randomly chosen patterns on the sphere with radius $M:=K\sqrt{d-1}$. We define $a:=\frac{2}{d-1}(1+\ln(2\beta K^{2}p(d-1)))$, $b:=\frac{2K^{2}\beta}{5}$, and $c:=\frac{b}{W_{0}(\exp(a+\ln(b))}$, where $W_{0}$ is the upper branch of the Lambert $W$ function [^72], and ensure $c\geq\left(\frac{2}{\sqrt{p}}\right)^{\frac{4}{d-1}}$. Then with probability $1-p$, the number of random patterns that can be stored is

$$
\displaystyle N\
$$
 
$$
\displaystyle\geq\ \sqrt{p}\ c^{\frac{d-1}{4}}\ .
$$

Therefore it is proven for $c\geq 3.1546$ with $\beta=1$, $K=3$, $d=20$ and $p=0.001$ ($a+\ln(b)>1.27$) and proven for $c\geq 1.3718$ with $\beta=1$, $K=1$, $d=75$, and $p=0.001$ ($a+\ln(b)<-0.94$).

For a proof, see appendix Theorem A5.

The next theorem states that the update rule typically retrieves patterns after one update. Retrieval of a pattern $\bm{x}_{i}$ for fixed point $\bm{x}_{i}^{*}$ and query $\bm{\xi}$ is defined via an $\epsilon$ by ${{\left\|f(\bm{\xi})\ -\ \bm{x}_{i}^{*}\right\|}}<\epsilon$, that is, the update is $\epsilon$ -close to the fixed point. Retrieval with one update is crucial to integrate modern Hopfield networks into deep learning architectures, where layers are activated only once. First we need the concept of separation of a pattern. For pattern $\bm{x}_{i}$ we define its separation $\Delta_{i}$ to other patterns by:

$$
\displaystyle\Delta_{i}\
$$
 
$$
\displaystyle:=\ \min_{j,j\not=i}\left(\bm{x}_{i}^{T}\bm{x}_{i}\ -\ \bm{x}_{i}^{T}\bm{x}_{j}\right)\ =\ \bm{x}_{i}^{T}\bm{x}_{i}\ -\ \max_{j,j\not=i}\bm{x}_{i}^{T}\bm{x}_{j}\ .
$$

The update rule retrieves patterns with one update for well separated patterns, that is, patterns with large $\Delta_{i}$.

###### Theorem 4.

With query $\bm{\xi}$, after one update the distance of the new point $f(\bm{\xi})$ to the fixed point $\bm{x}_{i}^{*}$ is exponentially small in the separation $\Delta_{i}$. The precise bounds using the Jacobian $\mathrm{J}=\frac{\partial f(\bm{\xi})}{\partial\bm{\xi}}$ and its value $\mathrm{J}^{m}$ in the mean value theorem are:

$$
\displaystyle{{\left\|f(\bm{\xi})\ -\ \bm{x}_{i}^{*}\right\|}}\
$$
 
$$
\displaystyle\leqslant\ {{\left\|\mathrm{J}^{m}\right\|}}_{2}\ {{\left\|\bm{\xi}\ -\ \bm{x}_{i}^{*}\right\|}}\ ,
$$
$$
\displaystyle{{\left\|\mathrm{J}^{m}\right\|}}_{2}\
$$
 
$$
\displaystyle\leqslant\ 2\ \beta\ N\ M^{2}\ (N-1)\exp(-\ \beta\ (\Delta_{i}\ -\ 2\ \max\{{{\left\|\bm{\xi}\ -\ \bm{x}_{i}\right\|}},{{\left\|\bm{x}_{i}^{*}\ -\ \bm{x}_{i}\right\|}}\}\ M))\ .
$$

For given $\epsilon$ and sufficient large $\Delta_{i}$, we have ${{\left\|f(\bm{\xi})\ -\ \bm{x}_{i}^{*}\right\|}}<\epsilon$, that is, retrieval with one update.

See proof in appendix Theorem A8.

At the same time, the retrieval error decreases exponentially with the separation $\Delta_{i}$.

###### Theorem 5 (Exponentially Small Retrieval Error).

The retrieval error ${{\left\|f(\bm{\xi})\ -\ \bm{x}_{i}\right\|}}$ of pattern $\bm{x}_{i}$ is bounded by

$$
\displaystyle{{\left\|f(\bm{\xi})\ -\ \bm{x}_{i}\right\|}}\
$$
 
$$
\displaystyle\leqslant\ 2\ (N-1)\ \exp(-\ \beta\ (\Delta_{i}\ -\ 2\ \max\{{{\left\|\bm{\xi}\ -\ \bm{x}_{i}\right\|}},{{\left\|\bm{x}_{i}^{*}\ -\ \bm{x}_{i}\right\|}}\}\ M))\ M
$$

and for ${{\left\|\bm{x}_{i}-\bm{x}_{i}^{*}\right\|}}\leqslant\frac{1}{2\ \beta\ M}$ together with ${{\left\|\bm{x}_{i}-\bm{\xi}\right\|}}\leqslant\frac{1}{2\ \beta\ M}$ by

$$
\displaystyle{{\left\|\bm{x}_{i}\ -\ \bm{x}_{i}^{*}\right\|}}\
$$
 
$$
\displaystyle\leqslant\ 2\ e\ (N-1)\ M\ \exp(-\ \beta\ \Delta_{i})\ .
$$

See proof in appendix Theorem A9.

##### Metastable states and one global fixed point.

So far, we considered patterns $\bm{x}_{i}$ that are well separated and the iteration converges to a fixed point which is near a pattern $\bm{x}_{i}$. If no pattern $\bm{x}_{i}$ is well separated from the others, then the iteration converges to a global fixed point close to the arithmetic mean of the vectors. In this case the $\mathrm{softmax}$ vector $\bm{p}$ is close to uniform, that is, $p_{i}=1/N$. If some vectors are similar to each other and well separated from all other vectors, then a metastable state near the similar vectors exists. Iterations that start near the metastable state converge to this metastable state, also if initialized by one of the similar patterns. For convergence proofs to one global fixed point and to metastable states see appendix Lemma A7 and Lemma A12, respectively.

##### Hopfield update rule is attention of the transformer.

The Hopfield network update rule is the attention mechanism used in transformer and BERT models (see Fig. 1). To see this, we assume $N$ stored (key) patterns $\bm{y}_{i}$ and $S$ state (query) patterns $\bm{r}_{i}$ that are mapped to the Hopfield space of dimension $d_{k}$. We set $\bm{x}_{i}=\bm{W}_{K}^{T}\bm{y}_{i}$, $\bm{\xi}_{i}=\bm{W}_{Q}^{T}\bm{r}_{i}$, and multiply the result of our update rule with $\bm{W}_{V}$. The matrices $\bm{Y}=(\bm{y}_{1},\ldots,\bm{y}_{N})^{T}$ and $\bm{R}=(\bm{r}_{1},\ldots,\bm{r}_{S})^{T}$ combine the $\bm{y}_{i}$ and $\bm{r}_{i}$ as row vectors. We define the matrices $\bm{X}^{T}=\bm{K}=\bm{Y}\bm{W}_{K}$, $\bm{\Xi}^{T}=\bm{Q}=\bm{R}\bm{W}_{Q}$, and $\bm{V}=\bm{Y}\bm{W}_{K}\bm{W}_{V}=\bm{X}^{T}\bm{W}_{V}$, where $\bm{W}_{K}\in\mathbb{R}^{d_{y}\times d_{k}},\bm{W}_{Q}\in\mathbb{R}^{d_{r}\times d_{k}},\bm{W}_{V}\in\mathbb{R}^{d_{k}\times d_{v}}$. If $\beta=1/\sqrt{d_{k}}$ and $\mathrm{softmax}\in\mathbb{R}^{N}$ is changed to a row vector, we obtain for the update rule Eq. (3) multiplied by $\bm{W}_{V}$:

$$
\displaystyle\bm{Z}\ =\ \mathrm{softmax}\left(1/\sqrt{d_{k}}\ \bm{Q}\ \bm{K}^{T}\right)\ \bm{V}\ =\ \mathrm{softmax}\left(\beta\ \bm{R}\ \bm{W}_{\bm{Q}}\ \bm{W}_{\bm{K}}^{T}\bm{Y}^{T}\right)\ \bm{Y}\ \bm{W}_{\bm{K}}\bm{W}_{\bm{V}}\ .
$$

The left part of Eq. (10) is the transformer attention. In the transformer self-attention $\bm{R}=\bm{Y}$, and $\bm{W}_{\bm{K}}\bm{W}_{\bm{V}}$ replaced by just $\bm{W}_{\bm{V}}$. Besides the attention mechanism, Hopfield networks allow for other functionalities in deep network architectures, which we introduce via specific layers in the next section. The right part of Eq. (10) serves to explain these specific layers.

## 3 New Hopfield Layers for Deep Learning

Modern Hopfield networks with continuous states can be integrated into deep learning architectures, because they are continuous and differentiable with respect to their parameters. Furthermore, they typically retrieve patterns with one update, which is conform to deep learning layers that are activated only once. For these two reasons, modern Hopfield networks can serve as specialized layers in deep networks to equip them with memories. Below, we introduce three types of Hopfield layers: Hopfield, HopfieldPooling, and HopfieldLayer. Possible applications of Hopfield layers in deep network architectures comprise:

Hopfield network layers can substitute existing layers like pooling layers, permutation equivariant layers [^42] [^79], GRU [^24] & LSTM [^44] [^45] layers, and attention layers [^96] [^97] [^8].

Figure 2: Left: A standard deep network with layers ( $\blacksquare$) propagates either a vector or a set of vectors from the input to the output. Right: A deep network, where layers ( $\blacksquare$) are equipped with associative memories via Hopfield layers ( $\blacksquare$).

##### Types of neural networks.

We consider two types of feed-forward neural networks: (I) Neural networks that propagate an activation vector from the input layer to the output layer. Examples are fully-connected or convolutional neural networks. (II) Neural networks that propagate a set of vectors from the input layer to the output layer, where each layer applies the same operation to each element of the set and the output layer may summarize the set via a vector. An example is the transformer. Recurrent neural networks are networks of type (I), which are iteratively applied to a set or a sequence, where intermediate results are stored in a memory and can be reused. Modern Hopfield networks can be integrated into both types of neural network architectures and enable to equip each of their layers with associative memories. See Fig. 2.

##### Types of new Hopfield layers.

We introduce three types of Hopfield layers: Hopfield, HopfieldPooling, and HopfieldLayer. The continuous modern Hopfield network results in a plethora of new deep learning architectures, since we can (a) propagate sets or single vectors, (b) propagate queries, stored patterns, or both, (c) learn static queries or stored patterns, (d) fill the memory by training sets, prototypes, or external data. Next, we provide three useful types of Hopfield layers. The implementation is available at: [https://github.com/ml-jku/hopfield-layers](https://github.com/ml-jku/hopfield-layers)

(1) Layer Hopfield for networks that propagate sets of vectors via state (query) patterns $\bm{R}$ and stored (key) patterns $\bm{Y}$. The layer Hopfield is the realization of formula (10). The memory of the Hopfield layer can be filled with sets from the input or previous layers, see Fig. 3. The memory may be filled with a reference set, which is covered by providing the reference set as additional input. Thus, the layer Hopfield allows the association of two sets. A prominent example of a layer that performs such association is the transformer attention mechanism, which associates keys and queries, e.g. two point sets that have to be compared. This layer allows for different kinds of sequence-to-sequence learning, point set operations, and retrieval-based methods. The layer Hopfield with skip connections in a ResNet architecture is identical to the popular transformer and BERT models. In the experiments, we analyzed these Hopfield layers in transformer architectures. In our experiments in which we compare machine learning methods on small datasets of the UCI benchmark collection the layer Hopfield is also used.

Figure 3: The layer Hopfield allows the association of two sets $\bm{R}$ ( $\blacksquare$) and $\bm{Y}$ ( $\blacksquare$). It can be integrated into deep networks that propagate sets of vectors. The Hopfield memory is filled with a set from either the input or previous layers. The output is a set of vectors $\bm{Z}$ ( $\blacksquare$).

(2) Layer HopfieldPooling for networks that propagate patterns via the stored (key) patterns $\bm{Y}$. This layer performs a pooling or summarization of sets $\bm{Y}$ obtained from queries in previous layers or the input. The memory of the HopfieldPooling layer is filled with sets from the input or previous layers. The HopfieldPooling layer uses the queries to search for patterns in the memory, the stored set. If more patterns are similar to a particular search pattern (query), then the result is an average over these patterns. The state (query) patterns of each layer are static and can be learned. Multiple queries supply a set to the next layer, where each query corresponds to one element of the set. Thus, the layer HopfieldPooling enables fixed pattern search, pooling operations, and memories like LSTMs or GRUs. The static pattern functionality is typically needed if particular patterns must be identified in the data.  
A single HopfieldPooling layer allows for multiple instance learning. Static state (query) patterns together with position encoding in the keys allows for performing pooling operations. The position encoding can be two-dimensional, where standard convolutional filters can be constructed as in convolutional neural networks (CNNs). The HopfieldPooling layer can substitute pooling, averaging, LSTM, and permutation equivariant layers. See Fig. 4. The layer HopfieldPooling is used for experiments with multiple instance learning tasks, e.g. for immune repertoire classification in the experiments.

Figure 4: The layer HopfieldPooling enables pooling or summarization of sets, which are obtained from the input or from previous layers. The input $\bm{Y}$ ( $\blacksquare$) can be either a set or a sequence. The query patterns of each layer are static and can be learned. The output is a set of vectors $\bm{Z}$ ( $\blacksquare$), where the number of vectors equals the number of query patterns. The layer HopfieldPooling can realize multiple instance learning.

(3) Layer HopfieldLayer for networks that propagate a vector or a set of vectors via state (query) patterns $\bm{R}$. The queries $\bm{R}$ can be input vectors or queries that are computed from the output of previous layers. The memory of the HopfieldLayer layer is filled with a fixed set, which can be the training set, a reference set, prototype set, or a learned set (a learned matrix). The stored (key) patterns are static and can be learned. If the training set is stored in the memory, then each layer constructs a new set of queries based on the query results of previous layers. The stored patterns can be initialized by the training set or a reference set and then learned, in which case they deviate from the training set. The stored patterns can be interpreted as weights from the state (query) to hidden neurons that have a softmax activation function [^61]. The layer HopfieldLayer can substitute a fully connected layer, see Fig. 5. A single HopfieldLayer layer also allows for approaches similar to support vector machines (SVMs), approaches similar to $k$ -nearest neighbor, approaches similar to learning vector quantization, and pattern search. For classification, the raw data $\bm{y}_{i}=(\bm{z}_{i},\bm{t}_{i})$ can be the concatenation of input $\bm{z}_{i}$ and target $\bm{t}_{i}$. In this case, the matrices $\bm{W}_{K}$ and $\bm{W}_{V}$ can be designed such that inside the softmax the input $\bm{z}_{i}$ is used and outside the softmax the target $\bm{t}_{i}$. Thus, the softmax provides a weighted average of the target vectors based on the similarity between the query and the inputs. Also SVM models, $k$ -nearest neighbor, and learning vector quantization can be considered as weighted averages of the targets. The encoder-decoder attention layer of the transformers are a HopfieldLayer layer, where the memory is filled with the encoder output set. In our experiments with the drug design benchmark datasets, the layer HopfieldLayer has been applied and compared to other machine learning methods.

Figure 5: The layer HopfieldLayer enables multiple queries of the training set, a reference set, prototype set, or a learned set (a learned matrix). The queries for each layer are computed from the results of previous layers. The input is a set of vectors $\bm{R}$ ( $\blacksquare$). The output is also a set of vectors $\bm{Z}$ ( $\blacksquare$), where the number of output vectors equals the number of input vectors. The layer HopfieldLayer can realize SVM models, $k$ -nearest neighbor, and LVQ.

##### Additional functionality of new Hopfield layers.

The insights about energy, convergence, and storage properties provide all new Hopfield layers with additional functionalities: i) multiple updates to control how precise fixed points are found without additional parameters needed. ii) variable $\beta$ to determine the kind of fixed points such as the size of metastable states. The variable $\beta$ controls over how many patterns is averaged. As observed in the experiments, the variable is relevant in combination with the learning rate to steer the learning dynamics. The parameter $\beta$ governs the fixed point dynamics and can be learned, too. iii) controlling the storage capacity via the dimension of the associative space. The storage capacity can be relevant for tasks with a huge number of instances as in the immune repertoire classification experiment. iv) pattern normalization controls, like the layernorm, the fixed point dynamics by the norm and shift of the patterns. For more details see appendix, Section A.6.

## 4 Experiments

We show that our proposed Hopfield layers can be applied successfully to a wide range of tasks. The tasks are from natural language processing, contain multiple instance learning problems, a collection of small classification tasks, and drug design problems.

##### Analysis of transformer and BERT models.

Transformer and BERT models can be implemented by the layer Hopfield. The kind of fixed point of the Hopfield net is determined by how the pattern $\bm{x}_{i}$ is separated from others patterns. (a) a global fixed point: no separation of a pattern from the others, (b) a fixed point close to a single pattern: pattern is separated from other patterns, (c) metastable state: some patterns are similar to each other and well separated from all other vectors. We observed that the attention heads of transformer and BERT models are predominantly in metastable states, which are categorized into four classes: (I) averaging over a very large number of patterns (very large metastable state or fixed point (a)), (II) averaging over a large number of patterns (large metastable state), (III) averaging over a medium number of patterns (medium metastable state), (IV) averaging over a small number of patterns (small metastable state or fixed point (c)). For analyzing the metastable states, we calculated the minimal number $k$ of $\mathrm{softmax}$ values required to sum up to $0.90$. Hence, $k$ indicates the size of a metastable state. To determine in which of the four classes a head is mainly operating, we computed the distribution of $k$ across sequences. Concretely, for $N$ tokens and for $\bar{k}$ as the median of the distribution, a head is classified as operating in class (I) if $1/2N<\bar{k}$, as operating in class (II) if $1/8N<\bar{k}\leqslant 1/2N$, as operating in class (III) if $1/32N<\bar{k}\leqslant 1/8N$, and as operating in class (IV) if $\bar{k}\leqslant 1/32N$. We analyzed pre-trained BERT models from Hugging Face Inc. [^107] according to these operating classes. In Fig. A.3 in the appendix the distribution of the pre-trained bert-base-cased model is depicted (for other models see appendix Section A.5.1.4). Operating classes (II) (large metastable states) and (IV) (small metastable states) are often observed in the middle layers. Operating class (I) (averaging over a very large number of patterns) is abundant in lower layers. Similar observations have been reported in other studies [^93] [^94] [^92]. Operating class (III) (medium metastable states) is predominant in the last layers.

##### Multiple Instance Learning Datasets.

For multiple instance learning (MIL) [^34], we integrate our new Hopfield network via the layer HopfieldPooling into deep learning architectures. Recently, deep learning methods have been applied to MIL problems [^49], but still the performance on many datasets lacks improvement. Thus, MIL datasets still pose an interesting challenge, in which Hopfield layers equipped with memory are a promising approach.

•Immune Repertoire Classification. The first MIL task is immune repertoire classification, where a deep learning architecture with HopfieldPooling (DeepRC) was used [^105] [^106]. Immune repertoire classification [^35] typically requires to extract few patterns from a large set of sequences, the repertoire, that are indicative for the respective immune status. The datasets contain $\approx$ 300,000 instances per immune repertoire, which represents one of the largest multiple instance learning experiments ever conducted [^17]. Most MIL methods fail due the large number of instances. This experiment comprises real-world and simulated datasets. Simulated datasets are generated by implanting sequence motifs [^3] [^103] with low frequency into simulated or experimentally-observed immune receptor sequences. The performance of DeepRC was compared with other machine learning methods: (i) known motif, (ii) SVM using $k$ -mers and MinMax or Jaccard kernel, (iii) $K$ -Nearest Neighbor (KNN) with $k$ -mers, (iv) logistic regression with $k$ -mers, (v) burden test with $k$ -mers, and (vi) logistic multiple instance learning (lMIL). On the real-world dataset DeepRC achieved an AUC of $0.832\pm 0.022$, followed by the SVM with MinMax kernel (AUC $0.825\pm 0.022$) and the burden test with an AUC of $0.699\pm 0.041$. Across datasets, DeepRC outperformed all competing methods with respect to average AUC [^105] [^106].

•MIL benchmark datasets. We apply Hopfield layers to further MIL datasets [^49] [^62] [^23]: Elephant, Fox and Tiger for image annotation [^5]. These datasets consist of color images from the Corel dataset that have been preprocessed and segmented. An image consists of a set of segments (or blobs), each characterized by color, texture and shape descriptors. The datasets have 100 positive and 100 negative example images. The latter have been randomly drawn from a pool of photos of other animals. Elephant comprises 1,391 instances and 230 features, Fox 1,320 instances and 230 features, and Tiger has 1,220 instances and 230 features. Furthermore, we use the UCSB breast cancer classification [^52] dataset, which consists of 2,002 instances across 58 input objects. An instance represents a patch of a histopathological image of cancerous or normal tissue. The layer HopfieldPooling is used, which allows for computing a per-input-object representation by extracting an average of instances that are indicative for one of the two classes. The input to the layer HopfieldPooling is a set of embedded instances $\bm{Y}$. A trainable but fixed state (query) pattern $\bm{Q}$ is used for averaging over class-indicative instances. This averaging enables a compression of variable-sized bags to a fixed-sized representation to discriminate the bags. More details in appendix Sec. A.5.2. Our approach has set a new state-of-the-art and has outperformed other methods [^62] [^18] on the datasets Tiger, Elephant and UCSB Breast Cancer (see Table 1).

| Method | tiger | fox | elephant | UCSB |
| --- | --- | --- | --- | --- |
| Hopfield (ours) | $\mathbf{91.3\pm 0.5}$ | $64.05\pm 0.4$ | $\mathbf{94.9\pm 0.3}$ | $\mathbf{89.5\pm 0.8}$ |
| Path encoding [^62] | $91.0\pm 1.0$ <sup>a</sup> | $71.2\pm 1.4$ <sup>a</sup> | $94.4\pm 0.7$ <sup>a</sup> | $88.0\pm 2.2$ <sup>a</sup> |
| MInD [^23] | $85.3\pm 1.1$ <sup>a</sup> | $70.4\pm 1.6$ <sup>a</sup> | $93.6\pm 0.9$ <sup>a</sup> | $83.1\pm 2.7$ <sup>a</sup> |
| MILES [^22] | $87.2\pm 1.7$ <sup>b</sup> | $\mathbf{73.8\pm 1.6}$ <sup>a</sup> | $92.7\pm 0.7$ <sup>a</sup> | $83.3\pm 2.6$ <sup>a</sup> |
| APR [^34] | $77.8\pm 0.7$ <sup>b</sup> | $54.1\pm 0.9$ <sup>b</sup> | $55.0\pm 1.0$ <sup>b</sup> | — |
| Citation-kNN [^101] | $85.5\pm 0.9$ <sup>b</sup> | $63.5\pm 1.5$ <sup>b</sup> | $89.6\pm 0.9$ <sup>b</sup> | $70.6\pm 3.2$ <sup>a</sup> |
| DD [^67] | $84.1$ <sup>b</sup> | $63.1$ <sup>b</sup> | $90.7$ <sup>b</sup> | — |

Table 1: Results for MIL datasets Tiger, Fox, Elephant, and UCSB Breast Cancer in terms of AUC. Results for all methods except the first are taken from either <sup>a</sup> [^62] or <sup>b</sup> [^18], depending on which reports the higher AUC.

##### UCI Benchmark Collection.

So far deep learning struggled with small datasets. However, Hopfield networks are promising for handling small datasets, since they can store the training data points or their representations to perform similarity-based, nearest neighbor, or learning vector quantization methods. Therefore, we test the Hopfield layer Hopfield on the small datasets of the UC Irvine (UCI) Machine Learning Repository that have been used to benchmark supervised learning methods [^36] [^99] [^53] and also feed-forward neural networks [^55] [^109], where our Hopfield networks could exploit their memory. The whole 121 datasets in the collection vary strongly with respect to their size, number of features, and difficulties [^36], such that they have been divided into 75 “small datasets” with less than 1,000 samples and 45 “large datasets” with more than or equal to 1,000 samples in [^55].

| Method | avg. rank diff. | $p$ -value |
| --- | --- | --- |
| Hopfield (ours) | $\mathbf{-3.92}$ | — |
| SVM | $-3.23$ | $0.15$ |
| SNN | $-2.85$ | $0.10$ |
| RandomForest | $-2.79$ | $0.05$ |
| … | … | … |
| Stacking | $8.73$ | $1.2$ e $-11$ |

Table 2: Results on 75 small datasets of the UCI benchmarks given as difference to average rank.

On the 75 small datasets, Random Forests (RFs) and Support Vector Machines (SVM) are highly accurate, whereas on the large datasets, deep learning methods and neural networks are in the lead [^55] [^56] [^109]. We applied a modern Hopfield network via the layer HopfieldLayer, where a self-normalizing net (SNN) maps the input vector to $\bm{Y}$ and $\bm{R}$. The output $\bm{Z}$ of HopfieldLayer enters a softmax output. We compared our modern Hopfield networks against deep learning methods (e.g. SNNs, resnet), RFs, SVMs, boosting, bagging, and many other machine learning methods of [^36]. Since for each method, multiple variants and implementations had been included, we used method groups and representatives as defined by [^55]. For each dataset, a ranking of the methods was calculated which is presented in Table 2. We found that Hopfield networks outperform all other methods on the small datasets, setting a new state-of-the-art for 10 datasets. The difference is significant except for the first three runner-up methods (Wilcoxon signed rank test). See appendix Section A.5.3 for details.

Drug Design Benchmark Datasets. We test the Hopfield layer HopfieldLayer, on four drug design datasets. These datasets represent four main areas of modeling tasks in drug design, concretely to develop accurate models for predicting a) new anti-virals (HIV) by the Drug Therapeutics Program (DTP) AIDS Antiviral Screen, b) new protein inhibitors, concretely human $\beta$ -secretase (BACE) inhibitors by [^87], c) metabolic effects as blood-brain barrier permeability (BBBP) [^68] and d) side effects of a chemical compound from the Side Effect Resource (SIDER) [^63]. We applied the Hopfield layer HopfieldLayer, where the training data is used as stored patterns $\bm{Y}$, the input vector as state pattern $\bm{R}$, and the corresponding training label to project the output of the Hopfield layer $\bm{Y}\bm{W}_{V}$. Our architecture with HopfieldLayer has reached state-of-the-art for predicting side effects on SIDER $0.672\pm 0.019$ as well as for predicting $\beta$ -secretase BACE $0.902\pm 0.023$. For details, see Table A.5 in the appendix.

Conclusion. We have introduced a modern Hopfield network with continuous states and the corresponding new update rule. This network can store exponentially many patterns, retrieves patterns with one update, and has exponentially small retrieval errors. We analyzed the attention heads of BERT models. The new modern Hopfield networks have been integrated into deep learning architectures as layers to allow the storage of and access to raw input data, intermediate results, or learned prototypes. These Hopfield layers enable new ways of deep learning, beyond fully-connected, convolutional, or recurrent networks, and provide pooling, memory, association, and attention mechanisms. Hopfield layers that equip neural network layers with memories improved state-of-the-art in three out of four considered multiple instance learning problems and on immune repertoire classification, and on two drug design dataset. They yielded the best results among different machine learning methods on the UCI benchmark collections of small classification tasks.

## Acknowledgments

The ELLIS Unit Linz, the LIT AI Lab and the Institute for Machine Learning are supported by the Land Oberösterreich, LIT grants DeepToxGen (LIT-2017-3-YOU-003), and AI-SNN (LIT-2018-6-YOU-214), the Medical Cognitive Computing Center (MC3), Janssen Pharmaceutica, UCB Biopharma, Merck Group, Audi.JKU Deep Learning Center, Audi Electronic Venture GmbH, TGW, Primal, S3AI (FFG-872172), Silicon Austria Labs (SAL), Anyline, FILL, EnliteAI, Google Brain, ZF Friedrichshafen AG, Robert Bosch GmbH, TÜV Austria, DCS, and the NVIDIA Corporation. IARAI is supported by Here Technologies.

## Appendix A Appendix

This appendix consists of six sections (A.1–A.6). Section A.1 introduces the new modern Hopfield network with continuous states and its update rule. Furthermore, Section A.1 provides a thorough and profound theoretical analysis of this new Hopfield network. Section A.2 provides the mathematical background for Section A.1. Section A.3 reviews binary Modern Hopfield Networks of Krotov & Hopfield. Section A.4 shows that the Hopfield update rule is the attention mechanism of the transformer. Section A.5 gives details on the experiments. Section A.6 describes the PyTorch implementation of layers based on the new Hopfield networks and how to use them.

### A.1 Continuous State Modern Hopfield Networks (A New Concept)

#### A.1.1 Introduction

In Section A.1 our new modern Hopfield network is introduced. In Subsection A.1.2 we present the new energy function. Then in Subsection A.1.3, our new update rule is introduced. In Subsection A.1.4, we show that this update rule ensures global convergence. We show that all the limit points of any sequence generated by the update rule are the stationary points (local minima or saddle points) of the energy function. In Section A.1.5, we consider the local convergence of the update rule and see that patterns are retrieved with one update. In Subsection A.1.6, we consider the properties of the fixed points that are associated with the stored patterns. In Subsection A.1.6.1, we show that exponentially many patterns can be stored. The main result is given in Theorem A5: For random patterns on a sphere we can store and retrieve exponentially (in the dimension of the Hopfield space) many patterns. Subsection A.1.6.2 reports that patterns are typically retrieved with one update step and that the retrieval error is exponentially small.

In Subsection A.1.7, we consider how associations for the new Hopfield networks can be learned. In Subsection A.1.7.2, we analyze if the association is learned directly by a bilinear form. In Subsection A.1.7.3, we analyze if stored patterns and query patterns are mapped to the space of the Hopfield network. Therefore, we treat the architecture of the transformer and BERT. In Subsection A.1.8, we introduce a temporal component into the new Hopfield network that leads to a forgetting behavior. The forgetting allows us to treat infinite memory capacity in Subsection A.1.8.1. In Subsection A.1.8.2, we consider the controlled forgetting behavior.

In Section A.2, we provide the mathematical background that is needed for our proofs. In particular we give lemmas on properties of the softmax, the log-sum-exponential, the Legendre transform, and the Lambert $W$ function.

In Section A.3, we review the new Hopfield network as introduced by Krotov and Hopfield in 2016. However in contrast to our new Hopfield network, the Hopfield network of Krotov and Hopfield is binary, that is, a network with binary states. In Subsection A.3.1, we give an introduction to neural networks equipped with associative memories and new Hopfield networks. In Subsection A.3.1.1, we discuss neural networks that are enhanced by an additional external memory and by attention mechanisms. In Subsection A.3.1.2, we give an overview over the modern Hopfield networks. Finally, in Subsection A.3.2, we present the energy function and the update rule for the modern, binary Hopfield networks.

#### A.1.2 New Energy Function

We have patterns $\bm{x}_{1},\ldots,\bm{x}_{N}$ that are represented by the matrix

$$
\displaystyle\bm{X}\
$$
 
$$
\displaystyle=\ \left(\bm{x}_{1},\ldots,\bm{x}_{N}\right)\ .
$$

The largest norm of a pattern is

$$
\displaystyle M\
$$
 
$$
\displaystyle=\ \max_{i}{{\left\|\bm{x}_{i}\right\|}}\ .
$$

The query or state of the Hopfield network is $\bm{\xi}$.

The energy function $\mathrm{E}$ in the new type of Hopfield models of Krotov and Hopfield is $\mathrm{E}=-\sum_{i=1}^{N}F\left(\bm{\xi}^{T}\bm{x}_{i}\right)$ for binary patterns $\bm{x}_{i}$ and binary state $\bm{\xi}$ with interaction function $F(x)=x^{n}$, where $n=2$ gives classical Hopfield model [^59]. The storage capacity is proportional to $d^{n-1}$ [^59]. This model was generalized by Demircigil et al. [^31] to exponential interaction functions $F(x)=\exp(x)$, which gives the energy $\mathrm{E}=-\exp(\mathrm{lse}(1,\bm{X}^{T}\bm{\xi}))$. This energy leads to an exponential storage capacity of $N=2^{d/2}$ for binary patterns. Furthermore, with a single update the fixed point is recovered with high probability. See more details in Section A.3.

In contrast to the these binary modern Hopfield networks, we focus on modern Hopfield networks with continuous states that can store continuous patterns. We generalize the energy of Demircigil et al. [^31] to continuous states while keeping the $\mathrm{lse}$ properties which ensure high storage capacity and fast convergence. Our new energy $\mathrm{E}$ for a continuous query or state $\bm{\xi}$ is defined as

$$
\displaystyle\mathrm{E}\
$$
 
$$
\displaystyle=\ -\ \mathrm{lse}(\beta,\bm{X}^{T}\bm{\xi})\ +\ \frac{1}{2}\bm{\xi}^{T}\bm{\xi}\ +\ \beta^{-1}\ln N\ +\ \frac{1}{2}M^{2}
$$
 
$$
\displaystyle=\ -\ \beta^{-1}\ln\left(\sum_{i=1}^{N}\exp(\beta\bm{x}_{i}^{T}\bm{\xi})\right)\ +\ \beta^{-1}\ln N\ +\ \frac{1}{2}\bm{\xi}^{T}\bm{\xi}\ +\ \frac{1}{2}M^{2}
$$
 
$$
\displaystyle=\ -\ \beta^{-1}\ln\left(\frac{1}{N}\ \sum_{i=1}^{N}\exp\left(-\ \frac{1}{2}\ \beta\ \left(M^{2}\ -\ {{\left\|\bm{x}_{i}\right\|}}^{2}\right)\right)\ \exp\left(-\ \frac{1}{2}\ \beta\ {{\left\|\bm{x}_{i}\ -\ \bm{\xi}\right\|}}^{2}\right)\right)\ .
$$

First let us collect and prove some properties of $\mathrm{E}$. The next lemma gives bounds on the energy $\mathrm{E}$.

###### Lemma A1.

The energy $\mathrm{E}$ is larger than zero:

$$
\displaystyle 0\
$$
 
$$
\displaystyle\leqslant\ \mathrm{E}\ .
$$

For $\bm{\xi}$ in the simplex defined by the patterns, the energy $\mathrm{E}$ is upper bounded by:

$$
\displaystyle\mathrm{E}\
$$
 
$$
\displaystyle\leqslant\ \beta^{-1}\ln N\ +\ \frac{1}{2}\ M^{2}\ ,
$$
$$
\displaystyle\mathrm{E}\
$$
 
$$
\displaystyle\leqslant\ 2\ M^{2}\ .
$$

###### Proof.

We start by deriving the lower bound of zero. The pattern most similar to query or state $\bm{\xi}$ is $\bm{x}_{\bm{\xi}}$:

$$
\displaystyle\bm{x}_{\bm{\xi}}\
$$
 
$$
\displaystyle=\ \bm{x}_{k}\ ,\quad k\ =\ \arg\max_{i}\bm{\xi}^{T}\bm{x}_{i}\ .
$$

We obtain

$$
\displaystyle\mathrm{E}\
$$
 
$$
\displaystyle=\ -\ \beta^{-1}\ln\left(\sum_{i=1}^{N}\exp(\beta\bm{x}_{i}^{T}\bm{\xi})\right)\ +\ \beta^{-1}\ln N\ +\ \frac{1}{2}\bm{\xi}^{T}\bm{\xi}\ +\ \frac{1}{2}\ M^{2}
$$
 
$$
\displaystyle=\ -\ \beta^{-1}\ln\left(\frac{1}{N}\ \sum_{i=1}^{N}\exp(\beta\bm{x}_{i}^{T}\bm{\xi})\right)\ +\ \frac{1}{2}\bm{\xi}^{T}\bm{\xi}\ +\ \frac{1}{2}\ M^{2}
$$
 
$$
\displaystyle\geq\ -\ \beta^{-1}\ln\left(\frac{1}{N}\ \sum_{i=1}^{N}\exp(\beta\bm{x}_{i}^{T}\bm{\xi})\right)\ +\ \frac{1}{2}\ \bm{\xi}^{T}\bm{\xi}\ +\ \frac{1}{2}\ \bm{x}_{\bm{\xi}}^{T}\bm{x}_{\bm{\xi}}
$$
 
$$
\displaystyle\geq\ -\ \beta^{-1}\ln\left(\exp(\beta\bm{x}_{\bm{\xi}}^{T}\bm{\xi})\right)\ +\ \frac{1}{2}\bm{\xi}^{T}\bm{\xi}\ +\ \frac{1}{2}\ \bm{x}_{\bm{\xi}}^{T}\bm{x}_{\bm{\xi}}
$$
 
$$
\displaystyle=\ -\ \bm{x}_{\bm{\xi}}^{T}\bm{\xi}\ +\ \frac{1}{2}\ \bm{\xi}^{T}\bm{\xi}\ +\ \frac{1}{2}\ \bm{x}_{\bm{\xi}}^{T}\bm{x}_{\bm{\xi}}
$$
 
$$
\displaystyle=\frac{1}{2}\ \left(\bm{\xi}\ -\ \bm{x}_{\bm{\xi}}\right)^{T}\left(\bm{\xi}\ -\ \bm{x}_{\bm{\xi}}\right)\ =\ \frac{1}{2}\ {{\left\|\bm{\xi}\ -\ \bm{x}_{\bm{\xi}}\right\|}}^{2}\ \geq\ 0\ .
$$

The energy is zero and, therefore, the bound attained, if all $\bm{x}_{i}$ are equal, that is, $\bm{x}_{i}=\bm{x}$ for all $i$ and $\bm{\xi}=\bm{x}$.

For deriving upper bounds on the energy $\mathrm{E}$, we require the the query $\bm{\xi}$ to be in the simplex defined by the patterns, that is,

$$
\displaystyle\bm{\xi}\ =\ \sum_{i=1}^{N}p_{i}\ \bm{x}_{i}\ ,\quad\sum_{i=1}^{N}p_{i}\ =\ 1\ ,\quad\forall_{i}:\ 0\ \leqslant\ p_{i}\ .
$$

The first upper bound is.

$$
\displaystyle\mathrm{E}\ =\ -\ \beta^{-1}\ln\left(\sum_{i=1}^{N}\exp(\beta\bm{x}_{i}^{T}\bm{\xi})\right)\ +\ \frac{1}{2}\ \bm{\xi}^{T}\bm{\xi}\ +\ \beta^{-1}\ln N\ +\ \frac{1}{2}\ M^{2}
$$
 
$$
\displaystyle\leqslant\ -\sum_{i=1}^{N}p_{i}\ (\bm{x}_{i}^{T}\bm{\xi})\ +\ \frac{1}{2}\ \bm{\xi}^{T}\bm{\xi}\ +\ \beta^{-1}\ln N\ +\ \frac{1}{2}\ M^{2}
$$
 
$$
\displaystyle=\ -\ \frac{1}{2}\ \bm{\xi}^{T}\bm{\xi}\ +\ \beta^{-1}\ln N\ +\ \frac{1}{2}\ M^{2}\ \leqslant\ \beta^{-1}\ln N\ +\ \frac{1}{2}\ M^{2}\ .
$$

For the first inequality we applied Lemma A19 to $-\mathrm{lse}(\beta,\bm{X}^{T}\bm{\xi})$ with $\bm{z}=\bm{p}$ giving

$$
\displaystyle-\ \mathrm{lse}(\beta,\bm{X}^{T}\bm{\xi})\
$$
 
$$
\displaystyle\leqslant\ -\ \sum_{i=1}^{N}p_{i}\ (\bm{x}_{i}^{T}\bm{\xi})\ +\ \beta^{-1}\sum_{i=1}^{N}p_{i}\ln p_{i}\ \leqslant\ -\ \sum_{i=1}^{N}p_{i}\ (\bm{x}_{i}^{T}\bm{\xi})\ ,
$$

as the term involving the logarithm is non-positive.

Next we derive the second upper bound, for which we need the mean $\bm{m}_{\bm{x}}$ of the patterns

$$
\displaystyle\bm{m}_{\bm{x}}\
$$
 
$$
\displaystyle=\ \frac{1}{N}\ \sum_{i=1}^{N}\bm{x}_{i}\ .
$$

We obtain

$$
\displaystyle\mathrm{E}\ =\ -\ \beta^{-1}\ln\left(\sum_{i=1}^{N}\exp(\beta\bm{x}_{i}^{T}\bm{\xi})\right)\ +\ \frac{1}{2}\ \bm{\xi}^{T}\bm{\xi}\ +\ \beta^{-1}\ln N\ +\ \frac{1}{2}\ M^{2}
$$
 
$$
\displaystyle\leqslant\ -\sum_{i=1}^{N}\frac{1}{N}\ \bm{x}_{i}^{T}\bm{\xi}\ +\ \frac{1}{2}\ \bm{\xi}^{T}\bm{\xi}\ +\ \frac{1}{2}\ M^{2}
$$
 
$$
\displaystyle=\ -\ \bm{m}_{\bm{x}}^{T}\bm{\xi}\ +\ \frac{1}{2}\ \bm{\xi}^{T}\bm{\xi}\ +\ \frac{1}{2}\ M^{2}
$$
 
$$
\displaystyle\leqslant\ {{\left\|\bm{m}_{\bm{x}}\right\|}}\ {{\left\|\bm{\xi}\right\|}}\ +\ \frac{1}{2}\ {{\left\|\bm{\xi}\right\|}}^{2}\ +\ \frac{1}{2}\ M^{2}
$$
 
$$
\displaystyle\leqslant\ 2\ M^{2}\ ,
$$

where for the first inequality we again applied Lemma A19 with $\bm{z}=(1/N,\ldots,1/N)$ and $\beta^{-1}\sum_{i}1/N\ln(1/N)=-\beta^{-1}\ln(N)$. This inequality also follows from Jensen’s inequality. The second inequality uses the Cauchy-Schwarz inequality. The last inequality uses

$$
\displaystyle{{\left\|\bm{\xi}\right\|}}\
$$
 
$$
\displaystyle=\ {{\left\|\sum_{i}p_{i}\ \bm{x}_{i}\right\|}}\ \leqslant\ \sum_{i}p_{i}\ {{\left\|\bm{x}_{i}\right\|}}\ \leqslant\ \sum_{i}p_{i}M\ =\ M
$$

and

$$
\displaystyle{{\left\|\bm{m}_{\bm{x}}\right\|}}\
$$
 
$$
\displaystyle=\ {{\left\|\sum_{i}(1/N)\ \bm{x}_{i}\right\|}}\ \leqslant\ \sum_{i}(1/N)\ {{\left\|\bm{x}_{i}\right\|}}\ \leqslant\ \sum_{i}(1/N)\ M\ =\ M\ .
$$

∎

#### A.1.3 New Update Rule

We now introduce an update rule for minimizing the energy function $\mathrm{E}$. The new update rule is

$$
\displaystyle\bm{\xi}^{\mathrm{new}}\
$$
 
$$
\displaystyle=\ \bm{X}\bm{p}\ =\ \bm{X}\mathrm{softmax}(\beta\bm{X}^{T}\bm{\xi})\ ,
$$

where we used

$$
\displaystyle\bm{p}\
$$
 
$$
\displaystyle=\ \mathrm{softmax}(\beta\bm{X}^{T}\bm{\xi})\ .
$$

The new state $\bm{\xi}^{\mathrm{new}}$ is in the simplex defined by the patterns, no matter what the previous state $\bm{\xi}$ was. For comparison, the synchronous update rule for the classical Hopfield network with threshold zero is

$$
\displaystyle\bm{\xi}^{\mathrm{new}}\
$$
 
$$
\displaystyle=\ \mathop{\mathrm{sgn}\,}(\bm{X}\bm{X}^{T}\bm{\xi})\ .
$$

Therefore, instead of using the vector $\bm{X}^{T}\bm{\xi}$ as in the classical Hopfield network, its softmax version $\mathrm{softmax}(\beta\bm{X}^{T}\bm{\xi})$ is used.

In the next section (Section A.1.4) we show that the update rule Eq. (28) ensures global convergence. We show that all the limit points of any sequence generated by the update rule are the stationary points (local minima or saddle points) of the energy function $\mathrm{E}$. In Section A.1.5 we consider the local convergence of the update rule Eq. (28) and see that patterns are retrieved with one update.

#### A.1.4 Global Convergence of the Update Rule

We are interested in the global convergence, that is, convergence from each initial point, of the iteration

$$
\displaystyle\bm{\xi}^{\mathrm{new}}\
$$
 
$$
\displaystyle=\ f(\bm{\xi})\ =\ \bm{X}\bm{p}\ =\ \bm{X}\mathrm{softmax}(\beta\bm{X}^{T}\bm{\xi})\ ,
$$

where we used

$$
\displaystyle\bm{p}\
$$
 
$$
\displaystyle=\ \mathrm{softmax}(\beta\bm{X}^{T}\bm{\xi})\ .
$$

We defined the energy function

$$
\displaystyle\mathrm{E}\
$$
 
$$
\displaystyle=\ -\ \mathrm{lse}(\beta,\bm{X}^{T}\bm{\xi})\ +\ \frac{1}{2}\bm{\xi}^{T}\bm{\xi}\ +\ \beta^{-1}\ln N\ +\ \frac{1}{2}M^{2}
$$
 
$$
\displaystyle=\ -\ \beta^{-1}\ln\left(\sum_{i=1}^{N}\exp(\beta\bm{x}_{i}^{T}\bm{\xi})\right)\ +\ \beta^{-1}\ln N\ +\ \frac{1}{2}\bm{\xi}^{T}\bm{\xi}\ +\ \frac{1}{2}M^{2}\ .
$$

We will show that the update rule in Eq. (31) is the Concave-Convex Procedure (CCCP) for minimizing the energy $\mathrm{E}$. The CCCP is proven to converge globally.

###### Theorem A1 (Global Convergence (Zangwill): Energy).

The update rule Eq. (31) converges globally: For $\bm{\xi}^{t+1}=f(\bm{\xi}^{t})$, the energy $\mathrm{E}(\bm{\xi}^{t})\to\mathrm{E}(\bm{\xi}^{*})$ for $t\to\infty$ and a fixed point $\bm{\xi}^{*}$.

###### Proof.

The Concave-Convex Procedure (CCCP) [^113] [^114] minimizes a function that is the sum of a concave function and a convex function. CCCP is equivalent to Legendre minimization [^77] [^78] algorithms [^114]. The Jacobian of the softmax is positive semi-definite according to Lemma A22. The Jacobian of the softmax is the Hessian of the $\mathrm{lse}$, therefore $\mathrm{lse}$ is a convex and $-\mathrm{lse}$ a concave function. Therefore, the energy function $\mathrm{E}(\bm{\xi})$ is the sum of the convex function $\mathrm{E}_{1}(\bm{\xi})=1/2\bm{\xi}^{T}\bm{\xi}+C_{1}$ and the concave function $\mathrm{E}_{2}(\bm{\xi})=-\mathrm{lse}$:

$$
\displaystyle\mathrm{E}(\bm{\xi})\
$$
 
$$
\displaystyle=\ \mathrm{E}_{1}(\bm{\xi})\ +\ \mathrm{E}_{2}(\bm{\xi})\ ,
$$
$$
\displaystyle\mathrm{E}_{1}(\bm{\xi})\
$$
 
$$
\displaystyle=\ \frac{1}{2}\bm{\xi}^{T}\bm{\xi}\ +\ \beta^{-1}\ln N\ +\ \frac{1}{2}M^{2}\ =\ \frac{1}{2}\bm{\xi}^{T}\bm{\xi}\ +\ C_{1}\ ,
$$
$$
\displaystyle\mathrm{E}_{2}(\bm{\xi})\
$$
 
$$
\displaystyle=\ -\ \mathrm{lse}(\beta,\bm{X}^{T}\bm{\xi})\ ,
$$

where $C_{1}$ does not depend on $\bm{\xi}$.

The Concave-Convex Procedure (CCCP) [^113] [^114] applied to $\mathrm{E}$ is

$$
\displaystyle\nabla_{\xi}\mathrm{E}_{1}\left(\bm{\xi}^{t+1}\right)\
$$
 
$$
\displaystyle=\ -\ \nabla_{\xi}\mathrm{E}_{2}\left(\bm{\xi}^{t}\right)\ ,
$$

which is

$$
\displaystyle\nabla_{\xi}\left(\frac{1}{2}\bm{\xi}^{T}\bm{\xi}\ +\ C_{1}\right)\left(\bm{\xi}^{t+1}\right)\
$$
 
$$
\displaystyle=\ \nabla_{\xi}\mathrm{lse}(\beta,\bm{X}^{T}\bm{\xi}^{t})\ .
$$

The resulting update rule is

$$
\displaystyle\bm{\xi}^{t+1}\
$$
 
$$
\displaystyle=\ \bm{X}\bm{p}^{t}\ =\ \bm{X}\mathrm{softmax}(\beta\bm{X}^{T}\bm{\xi}^{t})
$$

using

$$
\displaystyle\bm{p}^{t}\
$$
 
$$
\displaystyle=\ \mathrm{softmax}(\beta\bm{X}^{T}\bm{\xi}^{t})\ .
$$

This is the update rule in Eq. (31).

Theorem 2 in [^113] and Theorem 2 in [^114] state that the update rule Eq. (31) is guaranteed to monotonically decrease the energy $\mathrm{E}$ as a function of time. See also Theorem 2 in [^86]. ∎

Although the objective converges in all cases, it does not necessarily converge to a local minimum [^65].

However the convergence proof of CCCP in [^113] [^114] was not as rigorous as required. In [^86] a rigorous analysis of the convergence of CCCP is performed using Zangwill’s global convergence theory of iterative algorithms.

In [^86] the minimization problem

$$
\displaystyle\min_{\bm{\xi}}
$$
 
$$
\displaystyle{\mbox{\ ~}}\mathrm{E}_{1}\ +\ \mathrm{E}_{2}
$$
 
$$
\displaystyle{\mbox{\ ~}}\bm{c}(\bm{\xi})\leqslant\bm{0}\ ,\quad\bm{d}(\bm{\xi})\ =\ \bm{0}
$$

is considered with $\mathrm{E}_{1}$ convex, $-\mathrm{E}_{2}$ convex, $\bm{c}$ component-wise convex function, and $\bm{d}$ an affine function. The CCCP algorithm solves this minimization problem by linearization of the concave part and is defined in [^86] as

$$
\displaystyle\bm{\xi}^{t+1}\ \in\ \arg\min_{\bm{\xi}}
$$
 
$$
\displaystyle{\mbox{\ ~}}\mathrm{E}_{1}\left(\bm{\xi}\right)\ +\ \bm{\xi}^{T}\nabla_{\xi}\mathrm{E}_{2}\left(\bm{\xi}^{t}\right)
$$
 
$$
\displaystyle{\mbox{\ ~}}\bm{c}(\bm{\xi})\leqslant\bm{0}\ ,\quad\bm{d}(\bm{\xi})\ =\ \bm{0}\ .
$$

We define the upper bound $\mathrm{E}_{\mathrm{C}}$ on the energy:

$$
\displaystyle\mathrm{E}_{\mathrm{C}}\left(\bm{\xi},\bm{\xi}^{t}\right)\
$$
 
$$
\displaystyle:=\ \mathrm{E}_{1}\left(\bm{\xi}\right)\ +\ \mathrm{E}_{2}\left(\bm{\xi}^{t}\right)\ +\ \left(\bm{\xi}\ -\ \bm{\xi}^{t}\right)^{T}\nabla_{\xi}\mathrm{E}_{2}\left(\bm{\xi}^{t}\right)\ .
$$

$\mathrm{E}_{\mathrm{C}}$ is equal to the energy $\mathrm{E}\left(\bm{\xi}^{t}\right)$ for $\bm{\xi}=\bm{\xi}^{t}$:

$$
\displaystyle\mathrm{E}_{\mathrm{C}}\left(\bm{\xi}^{t},\bm{\xi}^{t}\right)\
$$
 
$$
\displaystyle=\ \mathrm{E}_{1}\left(\bm{\xi}^{t}\right)\ +\ \mathrm{E}_{2}\left(\bm{\xi}^{t}\right)\ =\ \mathrm{E}\left(\bm{\xi}^{t}\right)\ .
$$

Since $-\mathrm{E}_{2}$ is convex, the first order characterization of convexity holds (Eq. 3.2 in [^12]):

$$
\displaystyle-\ \mathrm{E}_{2}\left(\bm{\xi}\right)\
$$
 
$$
\displaystyle\geq\ -\ \mathrm{E}_{2}\left(\bm{\xi}^{t}\right)\ -\ \left(\bm{\xi}\ -\ \bm{\xi}^{t}\right)^{T}\nabla_{\xi}\mathrm{E}_{2}\left(\bm{\xi}^{t}\right)\ ,
$$

that is

$$
\displaystyle\mathrm{E}_{2}\left(\bm{\xi}\right)\
$$
 
$$
\displaystyle\leqslant\ \mathrm{E}_{2}\left(\bm{\xi}^{t}\right)\ +\ \left(\bm{\xi}\ -\ \bm{\xi}^{t}\right)^{T}\nabla_{\xi}\mathrm{E}_{2}\left(\bm{\xi}^{t}\right)\ .
$$

Therefore, for $\bm{\xi}\not=\bm{\xi}^{t}$ the function $\mathrm{E}_{\mathrm{C}}$ is an upper bound on the energy:

$$
\displaystyle\mathrm{E}\left(\bm{\xi}\right)\
$$
 
$$
\displaystyle\leqslant\ \mathrm{E}_{\mathrm{C}}\left(\bm{\xi},\bm{\xi}^{t}\right)\ =\ \mathrm{E}_{1}\left(\bm{\xi}\right)\ +\ \mathrm{E}_{2}\left(\bm{\xi}^{t}\right)\ +\ \left(\bm{\xi}\ -\ \bm{\xi}^{t}\right)^{T}\nabla_{\xi}\mathrm{E}_{2}\left(\bm{\xi}^{t}\right)
$$
 
$$
\displaystyle=\ \mathrm{E}_{1}\left(\bm{\xi}\right)\ +\ \bm{\xi}^{T}\nabla_{\xi}\mathrm{E}_{2}\left(\bm{\xi}^{t}\right)\ +\ C_{2}\ ,
$$

where $C_{2}$ does not depend on $\bm{\xi}$. Since we do not have constraints, $\bm{\xi}^{t+1}$ is defined as

$$
\displaystyle\bm{\xi}^{t+1}\ \in\ \arg\min_{\bm{\xi}}
$$
 
$$
\displaystyle{\mbox{\ ~}}\mathrm{E}_{\mathrm{C}}\left(\bm{\xi},\bm{\xi}^{t}\right)\ ,
$$

hence $\mathrm{E}_{\mathrm{C}}\left(\bm{\xi}^{t+1},\bm{\xi}^{t}\right)\leqslant\ \mathrm{E}_{\mathrm{C}}\left(\bm{\xi}^{t},\bm{\xi}^{t}\right)$. Combining the inequalities gives:

$$
\displaystyle\mathrm{E}\left(\bm{\xi}^{t+1}\right)\
$$
 
$$
\displaystyle\leqslant\ \mathrm{E}_{\mathrm{C}}\left(\bm{\xi}^{t+1},\bm{\xi}^{t}\right)\ \leqslant\ \mathrm{E}_{\mathrm{C}}\left(\bm{\xi}^{t},\bm{\xi}^{t}\right)\ =\ \mathrm{E}\left(\bm{\xi}^{t}\right)\ .
$$

Since we do not have constraints, $\bm{\xi}^{t+1}$ is the minimum of

$$
\displaystyle\mathrm{E}_{\mathrm{C}}\left(\bm{\xi},\bm{\xi}^{t}\right)\
$$
 
$$
\displaystyle=\ \mathrm{E}_{1}\left(\bm{\xi}\right)\ +\ \bm{\xi}^{T}\nabla_{\xi}\mathrm{E}_{2}\left(\bm{\xi}^{t}\right)\ +\ C_{2}
$$

as a function of $\bm{\xi}$.

For a minimum not at the border, the derivative has to be the zero vector

$$
\displaystyle\frac{\partial\mathrm{E}_{\mathrm{C}}\left(\bm{\xi},\bm{\xi}^{t}\right)}{\partial\bm{\xi}}\
$$
 
$$
\displaystyle=\ \bm{\xi}\ +\ \nabla_{\xi}\mathrm{E}_{2}\left(\bm{\xi}^{t}\right)\ =\ \bm{\xi}\ -\ \bm{X}\mathrm{softmax}(\beta\bm{X}^{T}\bm{\xi}^{t})\ =\ \bm{0}
$$

and the Hessian must be positive semi-definite

$$
\displaystyle\frac{\partial^{2}\mathrm{E}_{\mathrm{C}}\left(\bm{\xi},\bm{\xi}^{t}\right)}{\partial\bm{\xi}^{2}}\
$$
 
$$
\displaystyle=\ \bm{I}\ .
$$

The Hessian is strict positive definite everywhere, therefore the optimization problem is strict convex (if the domain is convex) and there exist only one minimum, which is a global minimum. $\mathrm{E}_{\mathrm{C}}$ can even be written as a quadratic form:

$$
\displaystyle\mathrm{E}_{\mathrm{C}}\left(\bm{\xi},\bm{\xi}^{t}\right)\
$$
 
$$
\displaystyle=\ \frac{1}{2}\ \left(\bm{\xi}\ +\ \nabla_{\xi}\mathrm{E}_{2}\left(\bm{\xi}^{t}\right)\right)^{T}\left(\bm{\xi}\ +\ \nabla_{\xi}\mathrm{E}_{2}\left(\bm{\xi}^{t}\right)\right)\ +\ C_{3}\ ,
$$

where $C_{3}$ does not depend on $\bm{\xi}$.

Therefore, the minimum is

$$
\displaystyle\bm{\xi}^{t+1}\
$$
 
$$
\displaystyle=\ -\ \nabla_{\xi}\mathrm{E}_{2}\left(\bm{\xi}^{t}\right)\ =\ \bm{X}\mathrm{softmax}(\beta\bm{X}^{T}\bm{\xi}^{t})
$$

if it is in the domain as we assume.

Using $M=\max_{i}{{\left\|\bm{x}_{i}\right\|}}$, $\bm{\xi}^{t+1}$ is in the sphere $\mathrm{S}=\{\bm{x}\mid{{\left\|\bm{x}\right\|}}\leqslant M\}$ which is a convex and compact set. Hence, if $\bm{\xi}^{0}\in\mathrm{S}$, then the iteration is a mapping from $\mathrm{S}$ to $\mathrm{S}$. Therefore, the point-set-map defined by the iteration Eq. (55) is uniformly compact on $\mathrm{S}$ according to Remark 7 in [^86]. Theorem 2 and Theorem 4 in [^86] states that all the limit points of the iteration Eq. (55) are stationary points. These theorems follow from Zangwill’s global convergence theorem: Convergence Theorem A, page 91 in [^116] and page 3 in [^108].

The global convergence theorem only assures that for the sequence $\bm{\xi}^{t+1}=f(\bm{\xi}^{t})$ and a function $\Phi$ we have $\Phi(\bm{\xi}^{t})\to\Phi(\bm{\xi}^{*})$ for $t\to\infty$ but not $\bm{\xi}^{t}\to\bm{\xi}^{*}$. However, if $f$ is strictly monotone with respect to $\Phi$, then we can strengthen Zangwill’s global convergence theorem [^71]. We set $\Phi=\mathrm{E}$ and show $\mathrm{E}(\bm{\xi}^{t+1})<\mathrm{E}(\bm{\xi}^{t})$ if $\bm{\xi}^{t}$ is not a stationary point of $\mathrm{E}$, that is, $f$ is strictly monotone with respect to $\mathrm{E}$. The following theorem is similar to the convergence results for the expectation maximization (EM) algorithm in [^108] which are given in theorems 1 to 6 in [^108]. The following theorem is also very similar to Theorem 8 in [^86].

###### Theorem A2 (Global Convergence: Stationary Points).

For the iteration Eq. (55) we have $\mathrm{E}\left(\bm{\xi}^{t}\right)\to\mathrm{E}\left(\bm{\xi}^{*}\right)=\mathrm{E}^{*}$ as $t\to\infty$, for some stationary point $\bm{\xi}^{*}$. Furthermore ${{\left\|\bm{\xi}^{t+1}-\bm{\xi}^{t}\right\|}}\to 0$ and either $\{\bm{\xi}^{t}\}_{t=0}^{\infty}$ converges or, in the other case, the set of limit points of $\{\bm{\xi}^{t}\}_{t=0}^{\infty}$ is a connected and compact subset of $\mathcal{L}\left(\mathrm{E}^{*}\right)$, where $\mathcal{L}\left(a\right)=\{\bm{\xi}\in\mathcal{L}\mid\mathrm{E}\left(\bm{\xi}\right)=a\}$ and $\mathcal{L}$ is the set of stationary points of the iteration Eq. (55). If $\mathcal{L}\left(\mathrm{E}^{*}\right)$ is finite, then any sequence $\{\bm{\xi}^{t}\}_{t=0}^{\infty}$ generated by the iteration Eq. (55) converges to some $\bm{\xi}^{*}\in\mathcal{L}\left(\mathrm{E}^{*}\right)$.

###### Proof.

We have $\mathrm{E}\left(\bm{\xi}^{t}\right)=\mathrm{E}_{1}\left(\bm{\xi}^{t}\right)+\mathrm{E}_{2}\left(\bm{\xi}^{t}\right)$. The gradient $\nabla_{\xi}\mathrm{E}_{2}\left(\bm{\xi}^{t}\right)=-\nabla_{\xi}\mathrm{lse}(\beta,\bm{X}^{T}\bm{\xi})$ is continuous. Therefore, Eq. (51) has minimum in the sphere $\mathrm{S}$, which is a convex and compact set. If $\bm{\xi}^{t+1}\not=\bm{\xi}^{t}$, then $\bm{\xi}^{t}$ was not the minimum of Eq. (48) as the derivative at $\bm{\xi}^{t}$ is not equal to zero. Eq. (53) shows that the optimization problem Eq. (48) is strict convex, hence it has only one minimum, which is a global minimum. Eq. (54) shows that the optimization problem Eq. (48) is even a quadratic form. Therefore, we have

$$
\displaystyle\mathrm{E}\left(\bm{\xi}^{t+1}\right)\
$$
 
$$
\displaystyle\leqslant\ \mathrm{E}_{\mathrm{C}}\left(\bm{\xi}^{t+1},\bm{\xi}^{t}\right)\ <\ \mathrm{E}_{\mathrm{C}}\left(\bm{\xi}^{t},\bm{\xi}^{t}\right)\ =\ \mathrm{E}\left(\bm{\xi}^{t}\right)\ .
$$

Therefore, the point-set-map defined by the iteration Eq. (55) (for definitions see [^86]) is strictly monotonic with respect to $\mathrm{E}$. Therefore, we can apply Theorem 3 in [^86] or Theorem 3.1 and Corollary 3.2 in [^71], which give the statements of the theorem.

∎

We showed global convergence of the iteration Eq. (31). We have shown that all the limit points of any sequence generated by the iteration Eq. (31) are the stationary points (critical points; local minima or saddle points) of the energy function $\mathrm{E}$. Local maxima as stationary points are only possible if the iterations exactly hits a local maximum. However, convergence to a local maximum without being there is not possible because Eq. (56) ensures a strict decrease of the energy $\mathrm{E}$. Therefore, almost sure local maxima are not obtained as stationary points. Either the iteration converges or, in the second case, the set of limit points is a connected and compact set. But what happens if $\bm{\xi}^{0}$ is in an $\epsilon$ -neighborhood around a local minimum $\bm{\xi}^{*}$? Will the iteration Eq. (31) converge to $\bm{\xi}^{*}$? What is the rate of convergence? These questions are about local convergence which will be treated in detail in next section.

#### A.1.5 Local Convergence of the Update Rule: Fixed Point Iteration

For the proof of local convergence to a fixed point we will apply Banach fixed point theorem. For the rate of convergence we will rely on properties of a contraction mapping.

##### A.1.5.1 General Bound on the Jacobian of the Iteration.

We consider the iteration

$$
\displaystyle\bm{\xi}^{\mathrm{new}}\
$$
 
$$
\displaystyle=\ f(\bm{\xi})\ =\ \bm{X}\bm{p}\ =\ \bm{X}\mathrm{softmax}(\beta\bm{X}^{T}\bm{\xi})
$$

using

$$
\displaystyle\bm{p}\
$$
 
$$
\displaystyle=\ \mathrm{softmax}(\beta\bm{X}^{T}\bm{\xi})\ .
$$

The Jacobian $\mathrm{J}$ is symmetric and has the following form:

$$
\displaystyle\mathrm{J}\
$$
 
$$
\displaystyle=\ \frac{\partial f(\bm{\xi})}{\partial\bm{\xi}}\ =\ \beta\ \bm{X}\left(\mathrm{diag}(\bm{p})-\bm{p}\bm{p}^{T}\right)\bm{X}^{T}\ =\ \bm{X}\mathrm{J}_{s}\bm{X}^{T}\ ,
$$

where $\mathrm{J}_{s}$ is Jacobian of the softmax.

To analyze the local convergence of the iteration, we distinguish between the following three cases (see also Fig. A.1). Here we only provide an informal discussion to give the reader some intuition. A rigorous formulation of the results can be found in the corresponding subsections.

1. If the patterns $\bm{x}_{i}$ are not well separated, the iteration goes to a fixed point close to the arithmetic mean of the vectors. In this case $\bm{p}$ is close to $p_{i}=1/N$.
2. If the patterns $\bm{x}_{i}$ are well separated, then the iteration goes to the pattern to which the initial $\bm{\xi}$ is similar. If the initial $\bm{\xi}$ is similar to a vector $\bm{x}_{i}$ then it will converge to a vector close to $\bm{x}_{i}$ and $\bm{p}$ will converge to a vector close to $\bm{e}_{i}$.
3. If some vectors are similar to each other but well separated from all other vectors, then a so called metastable state between the similar vectors exists. Iterations that start near the metastable state converge to this metastable state.

![Refer to caption](https://ar5iv.labs.arxiv.org/html/2008.02217/assets/Hopfield_main.png)

Figure A.1: The three cases of fixed points. a) Stored patterns (fixed point is single pattern): patterns are stored if they are well separated. Each pattern 𝒙 i \\bm{x}\_{i} has a single fixed point ∗ \\bm{x}\_{i}^{\*} close to it. In the sphere S \\mathrm{S}\_{i}, pattern is the only pattern and the only fixed point. b) Metastable state (fixed point is average of similar patterns): and j \\bm{x}\_{j} are similar to each other and not well separated. The fixed point 𝒎 \\bm{m}\_{\\bm{x}}^{\*} is a metastable state that is close to the mean \\bm{m}\_{\\bm{x}} of the similar patterns. c) Global fixed point (fixed point is average of all patterns): no pattern is well separated from the others. A single global fixed point exists that is close to the arithmetic mean of all patterns.

We begin with a bound on the Jacobian of the iteration, thereby heavily relying on the Jacobian of the softmax from Lemma A24.

###### Lemma A2.

For $N$ patterns $\bm{X}=(\bm{x}_{1},\ldots,\bm{x}_{N})$, $\bm{p}=\mathrm{softmax}(\beta\bm{X}^{T}\bm{\xi})$, $M=\max_{i}{{\left\|\bm{x}_{i}\right\|}}$, and $m=\max_{i}p_{i}(1-p_{i})$, the spectral norm of the Jacobian $\mathrm{J}$ of the fixed point iteration is bounded:

$$
\displaystyle{{\left\|\mathrm{J}\right\|}}_{2}\
$$
 
$$
\displaystyle\leqslant\ 2\ \beta\ {{\left\|\bm{X}\right\|}}_{2}^{2}\ m\ \leqslant\ 2\ \beta\ N\ M^{2}\ m\ .
$$

If $p_{\max}=\max_{i}p_{i}\geq 1-\epsilon$, then for the spectral norm of the Jacobian holds

$$
\displaystyle{{\left\|\mathrm{J}\right\|}}_{2}\
$$
 
$$
\displaystyle\leqslant\ 2\ \beta\ N\ M^{2}\ \epsilon\ -\ 2\ \epsilon^{2}\ \beta\ N\ M^{2}\ <\ 2\ \beta\ N\ M^{2}\ \epsilon\ .
$$

###### Proof.

With

$$
\displaystyle\bm{p}\
$$
 
$$
\displaystyle=\ \mathrm{softmax}(\beta\bm{X}^{T}\bm{\xi})\ ,
$$

the symmetric Jacobian $\mathrm{J}$ is

$$
\displaystyle\mathrm{J}\
$$
 
$$
\displaystyle=\ \frac{\partial f(\bm{\xi})}{\partial\bm{\xi}}\ =\ \beta\ \bm{X}\left(\mathrm{diag}(\bm{p})-\bm{p}\bm{p}^{T}\right)\bm{X}^{T}\ =\ \bm{X}\mathrm{J}_{s}\bm{X}^{T}\ ,
$$

where $\mathrm{J}_{s}$ is Jacobian of the softmax.

With $m=\max_{i}p_{i}(1-p_{i})$, Eq. (476) from Lemma A24 is

$$
\displaystyle{{\left\|\mathrm{J}_{s}\right\|}}_{2}\
$$
 
$$
\displaystyle=\ \beta\ {{\left\|\mathrm{diag}(\bm{p})-\bm{p}\bm{p}^{T}\right\|}}_{2}\ \leqslant\ 2\ m\ \beta\ .
$$

Using this bound on ${{\left\|\mathrm{J}_{s}\right\|}}_{2}$, we obtain

$$
\displaystyle{{\left\|\mathrm{J}\right\|}}_{2}\
$$
 
$$
\displaystyle\leqslant\ \beta\ {{\left\|\bm{X}^{T}\right\|}}_{2}\ {{\left\|\mathrm{J}_{s}\right\|}}_{2}\ {{\left\|\bm{X}\right\|}}_{2}\ \leqslant\ 2\ m\ \beta\ {{\left\|\bm{X}\right\|}}_{2}^{2}\ .
$$

The spectral norm ${{\left\|.\right\|}}_{2}$ is bounded by the Frobenius norm ${{\left\|.\right\|}}_{F}$ which can be expressed by the norm squared of its column vectors:

$$
\displaystyle{{\left\|\bm{X}\right\|}}_{2}\
$$
 
$$
\displaystyle\leqslant\ {{\left\|\bm{X}\right\|}}_{F}\ =\ \sqrt{\sum_{i}{{\left\|\bm{x}_{i}\right\|}}^{2}}\ .
$$

Therefore, we obtain the first statement of the lemma:

$$
\displaystyle{{\left\|\mathrm{J}\right\|}}_{2}\
$$
 
$$
\displaystyle\leqslant\ 2\ \beta\ {{\left\|\bm{X}\right\|}}_{2}^{2}\ m\ \leqslant\ 2\ \beta\ N\ M^{2}\ m\ .
$$

With $p_{\max}=\max_{i}p_{i}\geq 1-\epsilon$ Eq. (480) in Lemma A24 is

$$
\displaystyle{{\left\|\mathrm{J}_{s}\right\|}}_{2}\
$$
 
$$
\displaystyle\leqslant\ 2\ \beta\ \epsilon\ -\ 2\ \epsilon^{2}\ \beta\ <\ 2\ \beta\ \epsilon\ .
$$

Using this inequality, we obtain the second statement of the lemma:

$$
\displaystyle{{\left\|\mathrm{J}\right\|}}_{2}\
$$
 
$$
\displaystyle\leqslant\ 2\ \beta\ N\ M^{2}\ \epsilon\ -\ 2\ \epsilon^{2}\ \beta\ N\ M^{2}\ <\ 2\ \beta\ N\ M^{2}\ \epsilon\ .
$$

∎

We now define the “separation” $\Delta_{i}$ of a pattern $\bm{x}_{i}$ from data $\bm{X}=(\bm{x}_{1},\ldots,\bm{x}_{N})$ here, since it has an important role for the convergence properties of the iteration.

###### Definition 2 (Separation of Patterns).

We define $\Delta_{i}$, i.e. the separation of pattern $\bm{x}_{i}$ from data $\bm{X}=(\bm{x}_{1},\ldots,\bm{x}_{N})$ as:

$$
\displaystyle\Delta_{i}\
$$
 
$$
\displaystyle=\ \min_{j,j\not=i}\left(\bm{x}_{i}^{T}\bm{x}_{i}\ -\ \bm{x}_{i}^{T}\bm{x}_{j}\right)\ =\ \bm{x}_{i}^{T}\bm{x}_{i}\ -\ \max_{j,j\not=i}\bm{x}_{i}^{T}\bm{x}_{j}\ .
$$

The pattern is separated from the other data if $0<\Delta_{i}$. Using the parallelogram identity, $\Delta_{i}$ can also be expressed as

$$
\displaystyle\Delta_{i}\
$$
 
$$
\displaystyle=\ \min_{j,j\not=i}\frac{1}{2}\ \left({{\left\|\bm{x}_{i}\right\|}}^{2}\ -\ {{\left\|\bm{x}_{j}\right\|}}^{2}\ +\ {{\left\|\bm{x}_{i}\ -\ \bm{x}_{j}\right\|}}^{2}\right)
$$
 
$$
\displaystyle=\ \frac{1}{2}{{\left\|\bm{x}_{i}\right\|}}^{2}\ -\ \frac{1}{2}\ \max_{j,j\not=i}\left({{\left\|\bm{x}_{j}\right\|}}^{2}\ -\ {{\left\|\bm{x}_{i}\ -\ \bm{x}_{j}\right\|}}^{2}\right)\ .
$$

For ${{\left\|\bm{x}_{i}\right\|}}={{\left\|\bm{x}_{j}\right\|}}$ we have $\Delta_{i}=1/2\min_{j,j\not=i}{{\left\|\bm{x}_{i}\ -\ \bm{x}_{j}\right\|}}^{2}$.

Analog we say for a query $\bm{\xi}$ and data $\bm{X}=(\bm{x}_{1},\ldots,\bm{x}_{N})$, that $\bm{x}_{i}$ is least separated from $\bm{\xi}$ while being separated from other $\bm{x}_{j}$ with $j\not=i$ if

$$
\displaystyle i\
$$
 
$$
\displaystyle=\ \arg\max_{k}\min_{j,j\not=k}\left(\bm{\xi}^{T}\bm{x}_{k}\ -\ \bm{\xi}^{T}\bm{x}_{j}\right)\ =\ \arg\max_{k}\left(\bm{\xi}^{T}\bm{x}_{k}\ -\ \max_{j,j\not=k}\bm{\xi}^{T}\bm{x}_{j}\right)
$$
 
$$
\displaystyle 0\
$$
 
$$
\displaystyle\leqslant\ c\ =\ \max_{k}\min_{j,j\not=k}\left(\bm{\xi}^{T}\bm{x}_{k}\ -\ \bm{\xi}^{T}\bm{x}_{j}\right)\ =\ \max_{k}\left(\bm{\xi}^{T}\bm{x}_{k}\ -\ \max_{j,j\not=k}\bm{\xi}^{T}\bm{x}_{j}\right)\ .
$$

Next we consider the case where the iteration has only one stable fixed point.

##### A.1.5.2 One Stable State: Fixed Point Near the Mean of the Patterns.

We start with the case where no pattern is well separated from the others.

•Global fixed point near the global mean: Analysis using the data center.

We revisit the bound on the Jacobian of the iteration by utilizing properties of pattern distributions. We begin with a probabilistic interpretation where we consider $p_{i}$ as the probability of selecting the vector $\bm{x}_{i}$. Consequently, we define expectations as $\mathbf{\mathrm{E}}_{\bm{p}}[f(\bm{x})]=\sum_{i=1}^{N}p_{i}f(\bm{x}_{i})$. In this setting the matrix

$$
\displaystyle\bm{X}\left(\mathrm{diag}(\bm{p})-\bm{p}\bm{p}^{T}\right)\bm{X}^{T}
$$

is the covariance matrix of data $\bm{X}$ when its vectors are selected according to the probability $\bm{p}$:

$$
\displaystyle\bm{X}\left(\mathrm{diag}(\bm{p})\ -\ \bm{p}\bm{p}^{T}\right)\bm{X}^{T}\ =\ \bm{X}\mathrm{diag}(\bm{p})\bm{X}^{T}\ -\ \bm{X}\bm{p}\bm{p}^{T}\bm{X}^{T}
$$
 
$$
\displaystyle=\ \sum_{i=1}^{N}p_{i}\ \bm{x}_{i}\ \bm{x}_{i}^{T}\ -\ \left(\sum_{i=1}^{N}p_{i}\ \bm{x}_{i}\right)\left(\sum_{i=1}^{N}p_{i}\ \bm{x}_{i}\right)^{T}
$$
 
$$
\displaystyle=\ \mathbf{\mathrm{E}}_{\bm{p}}[\bm{x}\ \bm{x}^{T}]\ -\ \mathbf{\mathrm{E}}_{\bm{p}}[\bm{x}]\ \mathbf{\mathrm{E}}_{\bm{p}}[\bm{x}]^{T}\ =\ \mathbf{\mathrm{Var}}_{\bm{p}}[\bm{x}]\ ,
$$

therefore we have

$$
\displaystyle\mathrm{J}\
$$
 
$$
\displaystyle=\ \beta\ \mathbf{\mathrm{Var}}_{\bm{p}}[\bm{x}]\ .
$$

The largest eigenvalue of the covariance matrix (equal to the largest singular value) is the variance in the direction of the eigenvector associated with the largest eigenvalue.

We define:

$$
\displaystyle\bm{m}_{\bm{x}}\
$$
 
$$
\displaystyle=\ \frac{1}{N}\ \sum_{i=1}^{N}\ \bm{x}_{i}\ ,
$$
$$
\displaystyle m_{\max}\
$$
 
$$
\displaystyle=\ \max_{1\leqslant i\leqslant N}{{\left\|\bm{x}_{i}\ -\ \bm{m}_{\bm{x}}\right\|}}_{2}\ .
$$

$\bm{m}_{\bm{x}}$ is the arithmetic mean (the center) of the patterns. $m_{\max}$ is the maximal distance of the patterns to the center $\bm{m}_{\bm{x}}$.

The variance of the patterns is

$$
\displaystyle\mathbf{\mathrm{Var}}_{\bm{p}}[\bm{x}]\
$$
 
$$
\displaystyle=\ \sum_{i=1}^{N}p_{i}\ \bm{x}_{i}\ \bm{x}_{i}^{T}\ -\ \left(\sum_{i=1}^{N}p_{i}\ \bm{x}_{i}\right)\ \left(\sum_{i=1}^{N}p_{i}\ \bm{x}_{i}\right)^{T}
$$
 
$$
\displaystyle=\ \sum_{i=1}^{N}p_{i}\ \left(\bm{x}_{i}\ -\ \sum_{i=1}^{N}p_{i}\bm{x}_{i}\right)\ \left(\bm{x}_{i}\ -\ \sum_{i=1}^{N}p_{i}\bm{x}_{i}\right)^{T}\ .
$$

The maximal distance to the center $m_{\max}$ allows the derivation of a bound on the norm of the Jacobian.

Next lemma gives a condition for a global fixed point.

###### Lemma A3.

The following bound on the norm ${{\left\|\mathrm{J}\right\|}}_{2}$ of the Jacobian of the fixed point iteration $f$ holds independent of $\bm{p}$ or the query $\bm{\xi}$.

$$
\displaystyle{{\left\|\mathrm{J}\right\|}}_{2}\
$$
 
$$
\displaystyle\leqslant\ \beta\ m_{\max}^{2}\ .
$$

For $\beta\ m_{\max}^{2}<1$ there exists a unique fixed point (global fixed point) of iteration $f$ in each compact set.

###### Proof.

In order to bound the variance we compute the vector $\bm{a}$ that minimizes

$$
\displaystyle f(\bm{a})\
$$
 
$$
\displaystyle=\ \sum_{i=1}^{N}p_{i}{{\left\|\bm{x}_{i}\ -\ \bm{a}\right\|}}^{2}\ =\ \sum_{i=1}^{N}p_{i}(\bm{x}_{i}\ -\ \bm{a})^{T}(\bm{x}_{i}\ -\ \bm{a})\ .
$$

The solution to

$$
\displaystyle\frac{\partial f(\bm{a})}{\partial\bm{a}}\
$$
 
$$
\displaystyle=\ 2\ \sum_{i=1}^{N}p_{i}(\bm{a}\ -\ \bm{x}_{i})\ =\ 0
$$

is

$$
\displaystyle\bm{a}\
$$
 
$$
\displaystyle=\ \sum_{i=1}^{N}p_{i}\bm{x}_{i}\ .
$$

The Hessian of $f$ is positive definite since

$$
\displaystyle\frac{\partial^{2}f(\bm{a})}{\partial\bm{a}^{2}}\
$$
 
$$
\displaystyle=\ 2\ \sum_{i=1}^{N}p_{i}\ \bm{I}\ =\ 2\ \bm{I}
$$

and $f$ is a convex function. Hence, the mean

$$
\displaystyle\bar{\bm{x}}\
$$
 
$$
\displaystyle:=\ \sum_{i=1}^{N}p_{i}\ \bm{x}_{i}
$$

minimizes $\sum_{i=1}^{N}p_{i}{{\left\|\bm{x}_{i}-\bm{a}\right\|}}^{2}$. Therefore, we have

$$
\displaystyle\sum_{i=1}^{N}p_{i}{{\left\|\bm{x}_{i}\ -\ \bar{\bm{x}}\right\|}}^{2}\
$$
 
$$
\displaystyle\leqslant\ \sum_{i=1}^{N}p_{i}{{\left\|\bm{x}_{i}\ -\ \bm{m}_{\bm{x}}\right\|}}^{2}\ \leqslant\ m_{\max}^{2}\ .
$$

Let us quickly recall that the spectral norm of an outer product of two vectors is the product of the Euclidean norms of the vectors:

$$
\displaystyle{{\left\|\bm{a}\bm{b}^{T}\right\|}}_{2}\
$$
 
$$
\displaystyle=\ \sqrt{\lambda_{\max}(\bm{b}\bm{a}^{T}\bm{a}\bm{b}^{T})}\ =\ {{\left\|\bm{a}\right\|}}\ \sqrt{\lambda_{\max}(\bm{b}\bm{b}^{T})}\ =\ {{\left\|\bm{a}\right\|}}\ {{\left\|\bm{b}\right\|}}\ ,
$$

since $\bm{b}\bm{b}^{T}$ has eigenvector $\bm{b}/{{\left\|\bm{b}\right\|}}$ with eigenvalue ${{\left\|\bm{b}\right\|}}^{2}$ and otherwise zero eigenvalues.

We now bound the variance of the patterns:

$$
\displaystyle{{\left\|\mathbf{\mathrm{Var}}_{\bm{p}}[\bm{x}]\right\|}}_{2}\
$$
 
$$
\displaystyle\leqslant\ \sum_{i=1}^{N}p_{i}{{\left\|\left(\bm{x}_{i}\ -\ \bar{\bm{x}}\right)\ \left(\bm{x}_{i}\ -\ \bar{\bm{x}}\right)^{T}\right\|}}_{2}
$$
 
$$
\displaystyle=\ \sum_{i=1}^{N}p_{i}{{\left\|\bm{x}_{i}\ -\ \bar{\bm{x}}\right\|}}^{2}\ \leqslant\ \sum_{i=1}^{N}p_{i}{{\left\|\bm{x}_{i}\ -\ \bm{m}_{\bm{x}}\right\|}}^{2}\ \leqslant\ \ m_{\max}^{2}\ .
$$

The bound of the lemma on ${{\left\|\mathrm{J}\right\|}}_{2}$ follows from Eq. (78).

For ${{\left\|\mathrm{J}\right\|}}_{2}\leqslant\beta\ m_{\max}^{2}<1$ we have a contraction mapping on each compact set. Banach fixed point theorem says there is a unique fixed point in the compact set.

∎

Now let us further investigate the tightness of the bound on ${{\left\|\mathbf{\mathrm{Var}}_{\bm{p}}[\bm{x}]\right\|}}_{2}$ via ${{\left\|\bm{x}_{i}-\bar{\bm{x}}\right\|}}^{2}$: we consider the trace, which is the sum $\sum_{k=1}^{d}e_{k}$ of the w.l.o.g. ordered nonnegative eigenvalues $e_{k}$ of $\mathbf{\mathrm{Var}}_{\bm{p}}[\bm{x}]$ The spectral norm is equal to the largest eigenvalue $e_{1}$, which is equal to the largest singular value, as we have positive semidefinite matrices. We obtain:

$$
\displaystyle{{\left\|\mathbf{\mathrm{Var}}_{\bm{p}}[\bm{x}]\right\|}}_{2}\
$$
 
$$
\displaystyle=\ \mathbf{\mathrm{Tr}}\left(\sum_{i=1}^{N}p_{i}\left(\bm{x}_{i}\ -\ \bar{\bm{x}}\right)\ \left(\bm{x}_{i}\ -\ \bar{\bm{x}}\right)^{T}\right)\ -\ \sum_{k=2}^{d}e_{k}
$$
 
$$
\displaystyle=\ \sum_{i=1}^{N}p_{i}\mathbf{\mathrm{Tr}}\left(\left(\bm{x}_{i}\ -\ \bar{\bm{x}}\right)\ \left(\bm{x}_{i}\ -\ \bar{\bm{x}}\right)^{T}\right)\ -\ \sum_{k=2}^{d}e_{k}
$$
 
$$
\displaystyle=\ \sum_{i=1}^{N}p_{i}{{\left\|\bm{x}_{i}\ -\ \bar{\bm{x}}\right\|}}^{2}\ -\ \sum_{k=2}^{d}e_{k}\ .
$$

Therefore, the tightness of the bound depends on eigenvalues which are not the largest. Hence variations which are not along the largest variation weaken the bound.

Next we investigate the location of fixed points which existence is ensured by the global convergence stated in Theorem A2. For $N$ patterns $\bm{X}=(\bm{x}_{1},\ldots,\bm{x}_{N})$, we consider the iteration

$$
\displaystyle\bm{\xi}^{\mathrm{new}}\
$$
 
$$
\displaystyle=\ f(\bm{\xi})\ =\ \bm{X}\bm{p}\ =\ \bm{X}\mathrm{softmax}(\beta\bm{X}^{T}\bm{\xi})
$$

using

$$
\displaystyle\bm{p}\
$$
 
$$
\displaystyle=\ \mathrm{softmax}(\beta\bm{X}^{T}\bm{\xi})\ .
$$

$\bm{\xi}^{\mathrm{new}}$ is in the simplex of the patterns, that is, $\bm{\xi}^{\mathrm{new}}=\sum_{i}p_{i}\bm{x}_{i}$ with $\sum_{i}p_{i}=1$ and $0\leqslant p_{i}$. Hence, after one update $\bm{\xi}$ is in the simplex of the pattern and stays there. If the center $\bm{m}_{\bm{x}}$ is the zero vector $\bm{m}_{\bm{x}}=\bm{0}$, that is, the data is centered, then the mean is a fixed point of the iteration. For $\bm{\xi}=\bm{m}_{\bm{x}}=\bm{0}$ we have

$$
\displaystyle\bm{p}\
$$
 
$$
\displaystyle=\ 1/N\ \bm{1}
$$

and

$$
\displaystyle\bm{\xi}^{\mathrm{new}}\
$$
 
$$
\displaystyle=\ 1/N\ \bm{X}\ \bm{1}\ =\ \bm{m}_{\bm{x}}\ =\ \bm{\xi}\ .
$$

In particular normalization methods like batch normalization would promote the mean as a fixed point.

We consider the differences of dot products for $\bm{x}_{i}$: $\bm{x}_{i}^{T}\bm{x}_{i}-\bm{x}_{i}^{T}\bm{x}_{j}=\bm{x}_{i}^{T}(\bm{x}_{i}-\bm{x}_{j})$, for fixed point $\bm{m}_{\bm{x}}^{*}$: $(\bm{m}_{\bm{x}}^{*})^{T}\bm{x}_{i}-(\bm{m}_{\bm{x}}^{*})^{T}\bm{x}_{j}=(\bm{m}_{\bm{x}}^{*})^{T}(\bm{x}_{i}-\bm{x}_{j})$, and for the center $\bm{m}_{\bm{x}}$: $\bm{m}_{\bm{x}}^{T}\bm{x}_{i}-\bm{m}_{\bm{x}}^{T}\bm{x}_{j}=\bm{m}_{\bm{x}}^{T}(\bm{x}_{i}-\bm{x}_{j})$. Using the Cauchy-Schwarz inequality, we get

$$
\displaystyle\left|\bm{\xi}^{T}(\bm{x}_{i}\ -\ \bm{x}_{j})\right|\
$$
 
$$
\displaystyle\leqslant\ {{\left\|\bm{\xi}\right\|}}\ {{\left\|\bm{x}_{i}\ -\ \bm{x}_{j}\right\|}}\ \leqslant\ {{\left\|\bm{\xi}\right\|}}\ ({{\left\|\bm{x}_{i}\ -\ \bm{m}_{\bm{x}}\right\|}}\ +\ {{\left\|\bm{x}_{j}\ -\ \bm{m}_{\bm{x}}\right\|}})
$$
 
$$
\displaystyle\leqslant\ 2\ m_{\max}\ {{\left\|\bm{\xi}\right\|}}\ .
$$

This inequality gives:

$$
\displaystyle\left|\bm{\xi}^{T}(\bm{x}_{i}\ -\ \bm{x}_{j})\right|\
$$
 
$$
\displaystyle\leqslant\ 2\ m_{\max}\ (m_{\max}\ +\ {{\left\|\bm{m}_{\bm{x}}\right\|}})\ ,
$$
$$
\displaystyle\left|\bm{\xi}^{T}(\bm{x}_{i}\ -\ \bm{x}_{j})\right|\
$$
 
$$
\displaystyle\leqslant\ 2\ m_{\max}\ M\ ,
$$

where we used ${{\left\|\bm{\xi}-\bm{0}\right\|}}\leqslant{{\left\|\bm{\xi}-\bm{m}_{\bm{x}}\right\|}}+{{\left\|\bm{m}_{\bm{x}}-\bm{0}\right\|}}$, ${{\left\|\bm{\xi}-\bm{m}_{\bm{x}}\right\|}}={{\left\|\sum_{i}p_{i}\bm{x}_{i}-\bm{m}_{\bm{x}}\right\|}}\leqslant\sum_{i}p_{i}{{\left\|\bm{x}_{i}-\bm{m}_{\bm{x}}\right\|}}\leqslant m_{\max}$, and $M=\max_{i}{{\left\|\bm{x}_{i}\right\|}}$. In particular

$$
\displaystyle\beta\ \left|\bm{m}_{\bm{x}}^{T}(\bm{x}_{i}\ -\ \bm{x}_{j})\right|\
$$
 
$$
\displaystyle\leqslant\ 2\ \beta\ m_{\max}\ {{\left\|\bm{m}_{\bm{x}}\right\|}}\ ,
$$
$$
\displaystyle\beta\ \left|(\bm{m}_{\bm{x}}^{*})^{T}(\bm{x}_{i}\ -\ \bm{x}_{j})\right|\
$$
 
$$
\displaystyle\leqslant\ 2\ \beta\ m_{\max}\ {{\left\|\bm{m}_{\bm{x}}^{*}\right\|}}\ \leqslant\ 2\ \beta\ m_{\max}\ (m_{\max}\ +\ {{\left\|\bm{m}_{\bm{x}}\right\|}})\ ,
$$
$$
\displaystyle\beta\ \left|\bm{x}_{i}^{T}(\bm{x}_{i}\ -\ \bm{x}_{j})\right|\
$$
 
$$
\displaystyle\leqslant\ 2\ \beta\ m_{\max}\ {{\left\|\bm{x}_{i}\right\|}}\ \leqslant\ 2\ \beta\ m_{\max}\ (m_{\max}\ +\ {{\left\|\bm{m}_{\bm{x}}\right\|}})\ .
$$

Let $i=\arg\max_{j}\bm{\xi}^{T}\bm{x}_{j}$, therefore the maximal softmax component is $i$. For the maximal softmax component $i$ we have:

$$
\displaystyle[\mathrm{softmax}(\beta\ \bm{X}^{T}\bm{\xi})]_{i}\ =\ \frac{1}{1\ +\ \sum_{j\not=i}\exp(-\ \beta\ (\bm{\xi}^{T}\bm{x}_{i}\ -\ \bm{\xi}^{T}\bm{x}_{j}))}
$$
 
$$
\displaystyle\leqslant\ \frac{1}{1\ +\ \sum_{j\not=i}\exp(-\ 2\ \beta\ m_{\max}\ (m_{\max}\ +\ {{\left\|\bm{m}_{\bm{x}}\right\|}}))}
$$
 
$$
\displaystyle=\ \frac{1}{1\ +\ (N-1)\exp(-\ 2\ \beta\ m_{\max}\ (m_{\max}\ +\ {{\left\|\bm{m}_{\bm{x}}\right\|}}))}
$$
 
$$
\displaystyle=\ \frac{\exp(2\ \beta\ m_{\max}\ (m_{\max}\ +\ {{\left\|\bm{m}_{\bm{x}}\right\|}}))}{\exp(2\ \beta\ m_{\max}\ (m_{\max}\ +\ {{\left\|\bm{m}_{\bm{x}}\right\|}}))\ +\ (N-1)}
$$
 
$$
\displaystyle\leqslant\ 1/N\ \exp(2\ \beta\ m_{\max}\ (m_{\max}\ +\ {{\left\|\bm{m}_{\bm{x}}\right\|}}))\ .
$$

Analogously we obtain for $i=\arg\max_{j}\bm{m}_{\bm{x}}^{T}\bm{x}_{j}$, a bound on the maximal softmax component $i$ if the center is put into the iteration:

$$
\displaystyle[\mathrm{softmax}(\beta\ \bm{X}^{T}\bm{m}_{\bm{x}})]_{i}\
$$
 
$$
\displaystyle\leqslant\ 1/N\ \exp(2\ \beta\ m_{\max}\ {{\left\|\bm{m}_{\bm{x}}\right\|}})\ .
$$

Analog we obtain a bound for $i=\arg\max_{j}(\bm{m}_{\bm{x}}^{*})^{T}\bm{x}_{j}$ on the maximal softmax component $i$ of the fixed point:

$$
\displaystyle[\mathrm{softmax}(\beta\ \bm{X}^{T}\bm{m}_{\bm{x}}^{*})]_{i}\
$$
 
$$
\displaystyle\leqslant\ 1/N\ \exp(2\ \beta\ m_{\max}\ {{\left\|\bm{m}_{\bm{x}}^{*}\right\|}})
$$
 
$$
\displaystyle\leqslant\ 1/N\ \exp(2\ \beta\ m_{\max}\ (m_{\max}\ +\ {{\left\|\bm{m}_{\bm{x}}\right\|}}))\ .
$$

The two important terms are $m_{\max}$, the variance or spread of the data and ${{\left\|\bm{m}_{\bm{x}}\right\|}}$, which tells how well the data is centered. For a contraction mapping we already required $\beta m_{\max}^{2}<1$, therefore the first term in the exponent is $2\beta m_{\max}^{2}<2$. The second term $2\beta m_{\max}{{\left\|\bm{m}_{\bm{x}}\right\|}}$ is small if the data is centered.

•Global fixed point near the global mean: Analysis using softmax values.

If $\bm{\xi}^{T}\bm{x}_{i}\approx\bm{\xi}^{T}\bm{x}_{j}$ for all $i$ and $j$, then $p_{i}\approx 1/N$ and we have $m=\max_{i}p_{i}(1-p_{i})<1/N$. For $M\leqslant 1/\sqrt{2\beta}$ we obtain from Lemma A2:

$$
\displaystyle{{\left\|\mathrm{J}\right\|}}_{2}\
$$
 
$$
\displaystyle<\ 1\ .
$$

The local fixed point is $\bm{m}_{\bm{x}}^{*}\approx\bm{m}_{\bm{x}}=(1/N)\sum_{i=1}^{N}\bm{x}_{i}$ with $p_{i}\approx 1/N$.

We now treat this case more formally. First we discuss conditions that ensure that the iteration is a contraction mapping. We consider the iteration Eq. (57) in the variable $\bm{p}$:

$$
\displaystyle\bm{p}^{\mathrm{new}}\
$$
 
$$
\displaystyle=\ g(\bm{p})\ =\ \mathrm{softmax}(\beta\bm{X}^{T}\bm{X}\bm{p})\ .
$$

The Jacobian is

$$
\displaystyle\mathrm{J}(\bm{p})\
$$
 
$$
\displaystyle=\ \frac{\partial g(\bm{p})}{\partial\bm{p}}\ =\ \bm{X}^{T}\bm{X}\ \mathrm{J}_{s}
$$

with

$$
\displaystyle\mathrm{J}_{s}(\bm{p}^{\mathrm{new}})\
$$
 
$$
\displaystyle=\ \beta\left(\mathrm{diag}(\bm{p}^{\mathrm{new}})\ -\ \bm{p}^{\mathrm{new}}(\bm{p}^{\mathrm{new}})^{T}\right)\ .
$$

The version of the mean value theorem in Lemma A32 states for $\mathrm{J}^{m}=\int_{0}^{1}\mathrm{J}(\lambda\bm{p})\ \mathrm{d}\lambda=\bm{X}^{T}\bm{X}\mathrm{J}_{s}^{m}$ with the symmetric matrix $\mathrm{J}_{s}^{m}=\int_{0}^{1}\mathrm{J}_{s}(\lambda\bm{p})\ \mathrm{d}\lambda$:

$$
\displaystyle\bm{p}^{\mathrm{new}}\
$$
 
$$
\displaystyle=\ g(\bm{p})\ =\ g(\bm{0})\ +\ (\mathrm{J}^{m})^{T}\bm{p}\ =\ g(\bm{0})\ +\ \mathrm{J}_{s}^{m}\ \bm{X}^{T}\bm{X}\ \bm{p}\ =\ 1/N\ \bm{1}\ +\ \mathrm{J}_{s}^{m}\ \bm{X}^{T}\bm{X}\ \bm{p}\ .
$$

With $m=\max_{i}p_{i}(1-p_{i})$, Eq. (476) from Lemma A24 is

$$
\displaystyle{{\left\|\mathrm{J}_{s}(\bm{p})\right\|}}_{2}\
$$
 
$$
\displaystyle=\ \beta\ {{\left\|\mathrm{diag}(\bm{p})-\bm{p}\bm{p}^{T}\right\|}}_{2}\ \leqslant\ 2\ m\ \beta\ .
$$

First observe that $\lambda p_{i}(1-\lambda p_{i})\leqslant p_{i}(1-p_{i})$ for $p_{i}\leqslant 0.5$ and $\lambda\in[0,1]$, since $p_{i}(1-p_{i})-\lambda p_{i}(1-\lambda p_{i})=(1-\lambda)p_{i}(1-(1+\lambda)p_{i})\geq 0$. For $\max_{i}p_{i}\leqslant 0.5$ this observation leads to the following bound for $\mathrm{J}_{s}^{m}$:

$$
\displaystyle{{\left\|\mathrm{J}_{s}^{m}\right\|}}_{2}\
$$
 
$$
\displaystyle\leqslant\ 2\ m\ \beta\ .
$$

Eq. (479) in Lemma A24 states that every $\mathrm{J}_{s}$ is bounded by $1/2\beta$, therefore also the mean:

$$
\displaystyle{{\left\|\mathrm{J}_{s}^{m}\right\|}}_{2}\
$$
 
$$
\displaystyle\leqslant\ 0.5\ \beta\ .
$$

Since $m=\max_{i}p_{i}(1-p_{i})<\max_{i}p_{i}=p_{\max}$, the previous bounds can be combined as follows:

$$
\displaystyle{{\left\|\mathrm{J}_{s}^{m}\right\|}}_{2}\
$$
 
$$
\displaystyle\leqslant\ 2\ \min\{0.25,p_{\max}\}\ \beta\ .
$$

Consequently,

$$
\displaystyle{{\left\|\mathrm{J}^{m}\right\|}}_{2}\
$$
 
$$
\displaystyle\leqslant\ N\ M^{2}\ 2\ \min\{0.25,p_{\max}\}\ \beta\ ,
$$

where we used Eq. (170). ${{\left\|\bm{X}^{T}\bm{X}\right\|}}_{2}={{\left\|\bm{X}\bm{X}^{T}\right\|}}_{2}$, therefore ${{\left\|\bm{X}^{T}\bm{X}\right\|}}_{2}$ is $N$ times the maximal second moment of the data squared.

Obviously, $g(\bm{p})$ is a contraction mapping in compact sets, where

$$
\displaystyle N\ M^{2}\ 2\ \min\{0.25,p_{\max}\}\ \beta\ <\ 1\ .
$$

$\mathrm{S}$ is the sphere around the origin $\bm{0}$ with radius one. For

$$
\displaystyle\bm{p}^{\mathrm{new}}\
$$
 
$$
\displaystyle=\ g(\bm{p})\ =\ 1/N\ \bm{1}\ +\ \mathrm{J}^{m}\ \bm{p}\ ,
$$

we have ${{\left\|\bm{p}\right\|}}\leqslant{{\left\|\bm{p}\right\|}}_{1}=1$ and ${{\left\|\bm{p}^{\mathrm{new}}\right\|}}\leqslant{{\left\|\bm{p}^{\mathrm{new}}\right\|}}_{1}=1$. Therefore, $g$ maps points from $\mathrm{S}$ into $\mathrm{S}$. $g$ is a contraction mapping for

$$
\displaystyle{{\left\|\mathrm{J}^{m}\right\|}}_{2}\
$$
 
$$
\displaystyle\leqslant\ N\ M^{2}\ 2\ \min\{0.25,p_{\max}\}\ \beta\ =\ c\ <\ 1\ .
$$

According to Banach fixed point theorem $g$ has a fixed point in the sphere $\mathrm{S}$.

Hölder’s inequality gives:

$$
\displaystyle{{\left\|\bm{p}\right\|}}^{2}\
$$
 
$$
\displaystyle=\ \bm{p}^{T}\bm{p}\ \leqslant\ {{\left\|\bm{p}\right\|}}_{1}{{\left\|\bm{p}\right\|}}_{\infty}\ =\ {{\left\|\bm{p}\right\|}}_{\infty}\ =\ p_{\max}\ .
$$

Alternatively:

$$
\displaystyle{{\left\|\bm{p}\right\|}}^{2}\
$$
 
$$
\displaystyle=\ \sum_{i}p_{i}^{2}\ =\ p_{\max}\sum_{i}\frac{p_{i}}{p_{\max}}\ p_{i}\ \leqslant\ p_{\max}\sum_{i}p_{i}\ =\ p_{\max}\ .
$$

Let now $\mathrm{S}$ be the sphere around the origin $\bm{0}$ with radius $1/\sqrt{N}+\sqrt{p_{\max}}$ and let ${{\left\|\mathrm{J}^{m}(\bm{p})\right\|}}_{2}\leqslant c<1$ for $\bm{p}\in\mathrm{S}$. The old $\bm{p}$ is in the sphere $\mathrm{S}$ ($\bm{p}\in\mathrm{S}$) since $p_{\max}<\sqrt{p_{\max}}$ for $p_{\max}<1$. We have

$$
\displaystyle{{\left\|\bm{p}^{\mathrm{new}}\right\|}}\
$$
 
$$
\displaystyle\leqslant\ 1/\sqrt{N}\ +\ {{\left\|\mathrm{J}^{m}\right\|}}_{2}\ {{\left\|\bm{p}\right\|}}\ \leqslant\ 1/\sqrt{N}\ +\ \sqrt{p_{\max}}\ .
$$

Therefore, $g$ is a mapping from $\mathrm{S}$ into $\mathrm{S}$ and a contraction mapping. According to Banach fixed point theorem, a fixed point exists in $\mathrm{S}$.

For the 1-norm, we use Lemma A24 and ${{\left\|\bm{p}\right\|}}_{1}=1$ to obtain from Eq. (115):

$$
\displaystyle{{\left\|\bm{p}^{\mathrm{new}}\ -\ 1/N\ \bm{1}\right\|}}_{1}\
$$
 
$$
\displaystyle\leqslant\ {{\left\|\mathrm{J}^{m}\right\|}}_{1}\ \leqslant\ 2\ \beta\ m\ {{\left\|\bm{X}\right\|}}_{\infty}\ M_{1}\ ,
$$
$$
\displaystyle{{\left\|\bm{p}^{\mathrm{new}}\ -\ 1/N\ \bm{1}\right\|}}_{1}\
$$
 
$$
\displaystyle\leqslant\ {{\left\|\mathrm{J}^{m}\right\|}}_{1}\ \leqslant\ 2\ \beta\ m\ N\ M_{\infty}\ M_{1}\ ,
$$
$$
\displaystyle{{\left\|\bm{p}^{\mathrm{new}}\ -\ 1/N\ \bm{1}\right\|}}_{1}\
$$
 
$$
\displaystyle\leqslant\ {{\left\|\mathrm{J}^{m}\right\|}}_{1}\ \leqslant\ 2\ \beta\ m\ N\ M^{2}\ ,
$$

where $m=\max_{i}p_{i}(1-p_{i})$, $M_{1}={{\left\|\bm{X}\right\|}}_{1}=\max_{i}{{\left\|\bm{x}_{i}\right\|}}_{1}$, $M=\max_{i}{{\left\|\bm{x}_{i}\right\|}}$, ${{\left\|\bm{X}\right\|}}_{\infty}={{\left\|\bm{X}^{T}\right\|}}_{1}=\max_{i}{{\left\|[X^{T}]_{i}\right\|}}_{1}$ (maximal absolute row sum norm), and $M_{\infty}=\max_{i}{{\left\|\bm{x}_{i}\right\|}}_{\infty}$. Let us quickly mention some auxiliary estimates related to $\bm{X}^{T}\bm{X}$:

$$
\displaystyle{{\left\|\bm{X}^{T}\bm{X}\right\|}}_{1}\
$$
 
$$
\displaystyle=\ \max_{i}\sum_{j=1}^{N}\left|\bm{x}_{i}^{T}\bm{x}_{j}\right|\ \leqslant\ \max_{i}\sum_{j=1}^{N}{{\left\|\bm{x}_{i}\right\|}}_{\infty}\ {{\left\|\bm{x}_{j}\right\|}}_{1}
$$
 
$$
\displaystyle\leqslant\ M_{\infty}\ \sum_{j=1}^{N}M_{1}\ =\ N\ M_{\infty}\ M_{1}\ ,
$$

where the first inequaltiy is from Hölder’s inequality. We used

$$
\displaystyle{{\left\|\bm{X}^{T}\bm{X}\right\|}}_{1}\
$$
 
$$
\displaystyle=\ \max_{i}\sum_{j=1}^{N}\left|\bm{x}_{i}^{T}\bm{x}_{j}\right|\ \leqslant\ \max_{i}\sum_{j=1}^{N}{{\left\|\bm{x}_{i}\right\|}}\ {{\left\|\bm{x}_{j}\right\|}}
$$
 
$$
\displaystyle\leqslant\ M\ \sum_{j=1}^{N}M\ =\ N\ M^{2}\ ,
$$

where the first inequality is from Hölder’s inequality (here the same as the Cauchy-Schwarz inequality). See proof of Lemma A24 for the 1-norm bound on $J_{s}$. Everything else follows from the fact that the 1-norm is sub-multiplicative as induced matrix norm.

We consider the minimal ${{\left\|\bm{p}\right\|}}$.

$$
\displaystyle\min_{\bm{p}}
$$
 
$$
\displaystyle{\mbox{\ ~}}{{\left\|\bm{p}\right\|}}^{2}
$$
 
$$
\displaystyle{\mbox{\ ~}}\sum_{i}p_{i}=1
$$
 
$$
\displaystyle{\mbox{\ ~}}\forall_{i}:\ \ p_{i}\ \geq\ 0\ .
$$

The solution to this minimization problem is $\bm{p}=(1/N)\bm{1}$. Therefore, we have $1/\sqrt{N}\leqslant{{\left\|\bm{p}\right\|}}$ and $1/N\leqslant{{\left\|\bm{p}\right\|}}^{2}$ Using Eq. (119) we obtain

$$
\displaystyle 1/\sqrt{N}\
$$
 
$$
\displaystyle\leqslant\ {{\left\|\bm{p}^{\mathrm{new}}\right\|}}\ \leqslant\ 1/\sqrt{N}\ +\ \sqrt{p_{\max}}\ .
$$

Moreover

$$
\displaystyle{{\left\|\bm{p}^{\mathrm{new}}\right\|}}^{2}\
$$
 
$$
\displaystyle=\ (\bm{p}^{\mathrm{new}})^{T}\bm{p}^{\mathrm{new}}\ =\ 1/N\ +\ (\bm{p}^{\mathrm{new}})^{T}\mathrm{J}^{m}\ \bm{p}\ \leqslant\ 1/N\ +\ {{\left\|\mathrm{J}^{m}\right\|}}_{2}\ {{\left\|\bm{p}\right\|}}
$$
 
$$
\displaystyle\leqslant\ 1/N\ +\ {{\left\|\mathrm{J}^{m}\right\|}}_{2}\ ,
$$

since $\bm{p}^{\mathrm{new}}\in\mathrm{S}$ and $\bm{p}\in\mathrm{S}$.

For the fixed point, we have

$$
\displaystyle{{\left\|\bm{p}^{*}\right\|}}^{2}\
$$
 
$$
\displaystyle=\ (\bm{p}^{*})^{T}\bm{p}^{*}\ =\ 1/N\ +\ (\bm{p}^{*})^{T}\mathrm{J}^{m}\ \bm{p}^{*}\ \leqslant\ 1/N\ +\ {{\left\|\mathrm{J}^{m}\right\|}}_{2}\ {{\left\|\bm{p}^{*}\right\|}}^{2}\ ,
$$

and hence

$$
\displaystyle 1/N\
$$
 
$$
\displaystyle\leqslant\ {{\left\|\bm{p}^{*}\right\|}}^{2}\ \leqslant\ 1/N\frac{1}{1\ -\ {{\left\|\mathrm{J}^{m}\right\|}}_{2}}\ =\ 1/N\ (1\ +\ \frac{{{\left\|\mathrm{J}^{m}\right\|}}_{2}}{1\ -\ {{\left\|\mathrm{J}^{m}\right\|}}_{2}})\ .
$$

Therefore, for small ${{\left\|\mathrm{J}^{m}\right\|}}_{2}$ we have $\bm{p}^{*}\approx(1/N)\bm{1}$.

##### A.1.5.3 Many Stable States: Fixed Points Near Stored Patterns.

We move on to the next case, where the patterns $\bm{x}_{i}$ are well separated. In this case the iteration goes to the pattern to which the initial $\bm{\xi}$ is most similar. If the initial $\bm{\xi}$ is similar to a vector $\bm{x}_{i}$ then it will converge to $\bm{x}_{i}$ and $\bm{p}$ will be $\bm{e}_{i}$. The main ingredients are again Banach’s Theorem and estimates on the Jacobian norm.

•Proof of a fixed point by Banach Fixed Point Theorem.

$\rightarrow$ Mapped Vectors Stay in a Compact Environment. We show that if $\bm{x}_{i}$ is sufficient dissimilar to other $\bm{x}_{j}$ then there is an compact environment of $\bm{x}_{i}$ (a sphere) where the fixed point iteration maps this environment into itself. The idea of the proof is to define a sphere around $\bm{x}_{i}$ for which points from the sphere are mapped by $f$ into the sphere.

We first need following lemma which bounds the distance ${{\left\|\bm{x}_{i}\ -\ f(\bm{\xi})\right\|}}$, where $\bm{x}_{i}$ is the pattern that is least separated from $\bm{\xi}$ but separated from other patterns.

###### Lemma A4.

For a query $\bm{\xi}$ and data $\bm{X}=(\bm{x}_{1},\ldots,\bm{x}_{N})$, there exists a $\bm{x}_{i}$ that is least separated from $\bm{\xi}$ while being separated from other $\bm{x}_{j}$ with $j\not=i$:

$$
\displaystyle i\
$$
 
$$
\displaystyle=\ \arg\max_{k}\min_{j,j\not=k}\left(\bm{\xi}^{T}\bm{x}_{k}\ -\ \bm{\xi}^{T}\bm{x}_{j}\right)\ =\ \arg\max_{k}\left(\bm{\xi}^{T}\bm{x}_{k}\ -\ \max_{j,j\not=k}\bm{\xi}^{T}\bm{x}_{j}\right)
$$
 
$$
\displaystyle 0\
$$
 
$$
\displaystyle\leqslant\ c\ =\ \max_{k}\min_{j,j\not=k}\left(\bm{\xi}^{T}\bm{x}_{k}\ -\ \bm{\xi}^{T}\bm{x}_{j}\right)\ =\ \max_{k}\left(\bm{\xi}^{T}\bm{x}_{k}\ -\ \max_{j,j\not=k}\bm{\xi}^{T}\bm{x}_{j}\right)\ .
$$

For $\bm{x}_{i}$, the following holds:

$$
\displaystyle{{\left\|\bm{x}_{i}\ -\ f(\bm{\xi})\right\|}}\
$$
 
$$
\displaystyle\leqslant\ 2\ \epsilon\ M\ ,
$$

where

$$
\displaystyle M\
$$
 
$$
\displaystyle=\ \max_{i}{{\left\|\bm{x}_{i}\right\|}}\ ,
$$
$$
\displaystyle\epsilon\
$$
 
$$
\displaystyle=\ (N-1)\ \exp(-\ \beta\ c)\ .
$$

###### Proof.

For the softmax component $i$ we have:

$$
\displaystyle[\mathrm{softmax}(\beta\ \bm{X}^{T}\bm{\xi})]_{i}\
$$
 
$$
\displaystyle=\ \frac{1}{1\ +\ \sum_{j\not=i}\exp(\beta\ (\bm{\xi}^{T}\bm{x}_{j}\ -\ \bm{\xi}^{T}\bm{x}_{i}))}\ \geq\ \frac{1}{1\ +\ \sum_{j\not=i}\exp(-\ \beta\ c)}
$$
 
$$
\displaystyle=\ \frac{1}{1\ +\ (N-1)\exp(-\ \beta\ c)}\ =\ 1\ -\ \frac{(N-1)\exp(-\ \beta\ c)}{1\ +\ (N-1)\exp(-\ \beta\ c)}
$$
 
$$
\displaystyle\geq\ 1\ -\ (N-1)\exp(-\ \beta\ c)\ =\ 1\ -\ \epsilon\
$$

For softmax components $k\not=i$ we have

$$
\displaystyle[\mathrm{softmax}(\beta\bm{X}^{T}\bm{\xi})]_{k}\
$$
 
$$
\displaystyle=\ \frac{\exp(\beta\ (\bm{\xi}^{T}\bm{x}_{k}\ -\ \bm{\xi}^{T}\bm{x}_{i}))}{1\ +\ \sum_{j\not=i}\exp(\beta\ (\bm{\xi}^{T}\bm{x}_{j}\ -\ \bm{\xi}^{T}\bm{x}_{i}))}\ \leqslant\ \exp(-\ \beta\ c)\ =\ \frac{\epsilon}{N-1}\ .
$$

The iteration $f$ can be written as

$$
\displaystyle f(\bm{\xi})\
$$
 
$$
\displaystyle=\ \bm{X}\mathrm{softmax}(\beta\bm{X}^{T}\bm{\xi})\ =\ \sum_{j=1}^{N}\bm{x}_{j}\ [\mathrm{softmax}(\beta\bm{X}^{T}\bm{\xi})]_{j}\ .
$$

We now can bound ${{\left\|\bm{x}_{i}\ -\ f(\bm{\xi})\right\|}}$:

$$
\displaystyle{{\left\|\bm{x}_{i}\ -\ f(\bm{\xi})\right\|}}\
$$
 
$$
\displaystyle=\ {{\left\|\bm{x}_{i}\ -\ \sum_{j=1}^{N}[\mathrm{softmax}(\beta\bm{X}^{T}\bm{\xi})]_{j}\ \bm{x}_{j}\right\|}}
$$
 
$$
\displaystyle=\ {{\left\|(1-[\mathrm{softmax}(\beta\bm{X}^{T}\bm{\xi})]_{i})\ \bm{x}_{i}\ -\ \sum_{j=1,j\not=i}^{N}[\mathrm{softmax}(\beta\bm{X}^{T}\bm{\xi})]_{j}\ \bm{x}_{j}\right\|}}
$$
 
$$
\displaystyle\leqslant\ \epsilon\ {{\left\|\bm{x}_{i}\right\|}}\ +\ \frac{\epsilon}{N-1}\ \sum_{j=1,j\not=i}^{N}{{\left\|\bm{x}_{j}\right\|}}
$$
 
$$
\displaystyle\leqslant\ \epsilon\ M\ +\ \frac{\epsilon}{N-1}\ \sum_{j=1,j\not=i}^{N}M\ =\ 2\ \epsilon\ M\ .
$$

∎

We define $\Delta_{i}$, i.e. the separation of pattern $\bm{x}_{i}$ from data $\bm{X}=(\bm{x}_{1},\ldots,\bm{x}_{N})$ as:

$$
\displaystyle\Delta_{i}\
$$
 
$$
\displaystyle=\ \min_{j,j\not=i}\left(\bm{x}_{i}^{T}\bm{x}_{i}\ -\ \bm{x}_{i}^{T}\bm{x}_{j}\right)\ =\ \bm{x}_{i}^{T}\bm{x}_{i}\ -\ \max_{j,j\not=i}\bm{x}_{i}^{T}\bm{x}_{j}\ .
$$

The pattern is separated from the other data if $0<\Delta_{i}$. Using the parallelogram identity, $\Delta_{i}$ can also be expressed as

$$
\displaystyle\Delta_{i}\
$$
 
$$
\displaystyle=\ \min_{j,j\not=i}\frac{1}{2}\ \left({{\left\|\bm{x}_{i}\right\|}}^{2}\ -\ {{\left\|\bm{x}_{j}\right\|}}^{2}\ +\ {{\left\|\bm{x}_{i}\ -\ \bm{x}_{j}\right\|}}^{2}\right)
$$
 
$$
\displaystyle=\ \frac{1}{2}{{\left\|\bm{x}_{i}\right\|}}^{2}\ -\ \frac{1}{2}\ \max_{j,j\not=i}\left({{\left\|\bm{x}_{j}\right\|}}^{2}\ -\ {{\left\|\bm{x}_{i}\ -\ \bm{x}_{j}\right\|}}^{2}\right)\ .
$$

For ${{\left\|\bm{x}_{i}\right\|}}={{\left\|\bm{x}_{j}\right\|}}$ we have $\Delta_{i}=1/2\min_{j,j\not=i}{{\left\|\bm{x}_{i}\ -\ \bm{x}_{j}\right\|}}^{2}$.

Next we define the sphere where we want to apply Banach fixed point theorem.

###### Definition 3 (Sphere Si\\mathrm{S}\_{i}).

The sphere $\mathrm{S}_{i}$ is defined as

$$
\displaystyle\mathrm{S}_{i}\
$$
 
$$
\displaystyle:=\ \left\{\bm{\xi}\mid{{\left\|\bm{\xi}\ -\ \bm{x}_{i}\right\|}}\ \leqslant\ \frac{1}{\beta\ N\ M}\right\}\ .
$$

###### Lemma A5.

With $\bm{\xi}$ given, if the assumptions

1. $\bm{\xi}$ is inside sphere: $\bm{\xi}\in\mathrm{S}_{i}$,
2. data point $\bm{x}_{i}$ is well separated from the other data:
	$$
	\displaystyle\Delta_{i}\
	$$
	 
	$$
	\displaystyle\geq\ \frac{2}{\beta\ N}\ +\ \frac{1}{\beta}\ \ln\left(2\ (N-1)\ N\ \beta\ M^{2}\right)
	$$

hold, then $f(\bm{\xi})$ is inside the sphere: $f(\bm{\xi})\in\mathrm{S}_{i}$. Therefore, with assumption (A2), $f$ is a mapping from $\mathrm{S}_{i}$ into $\mathrm{S}_{i}$.

###### Proof.

We need the separation $\tilde{\Delta}_{i}$ of $\bm{\xi}$ from the data.

$$
\displaystyle\tilde{\Delta}_{i}\
$$
 
$$
\displaystyle=\ \min_{j,j\not=i}\left(\bm{\xi}^{T}\bm{x}_{i}\ -\ \bm{\xi}^{T}\bm{x}_{j}\right)\ .
$$

Using the Cauchy-Schwarz inequality, we obtain for $1\leqslant j\leqslant N$:

$$
\displaystyle\left|\bm{\xi}^{T}\bm{x}_{j}\ -\ \bm{x}_{i}^{T}\bm{x}_{j}\right|
$$
 
$$
\displaystyle\leqslant\ {{\left\|\bm{\xi}\ -\ \bm{x}_{i}\right\|}}\ {{\left\|\bm{x}_{j}\right\|}}\ \leqslant\ {{\left\|\bm{\xi}\ -\ \bm{x}_{i}\right\|}}\ M\ .
$$

We have the lower bound

$$
\displaystyle\tilde{\Delta}_{i}\
$$
 
$$
\displaystyle\geq\ \min_{j,j\not=i}\left(\left(\bm{x}_{i}^{T}\bm{x}_{i}\ -\ {{\left\|\bm{\xi}\ -\ \bm{x}_{i}\right\|}}\ M\right)\ -\ \left(\bm{x}_{i}^{T}\bm{x}_{j}\ +\ {{\left\|\bm{\xi}\ -\ \bm{x}_{i}\right\|}}\ M\right)\right)
$$
 
$$
\displaystyle=\ -\ 2\ {{\left\|\bm{\xi}\ -\ \bm{x}_{i}\right\|}}\ M\ +\ \min_{j,j\not=i}\left(\bm{x}_{i}^{T}\bm{x}_{i}\ -\ \bm{x}_{i}^{T}\bm{x}_{j}\right)\ =\ \Delta_{i}\ -\ 2\ {{\left\|\bm{\xi}\ -\ \bm{x}_{i}\right\|}}\ M
$$
 
$$
\displaystyle\geq\ \Delta_{i}\ -\ \frac{2}{\beta\ N}\ ,
$$

where we used the assumption (A1) of the lemma.

From the proof in Lemma A4 we have

$$
\displaystyle p_{\max}\
$$
 
$$
\displaystyle=\ [\mathrm{softmax}(\beta\bm{X}^{T}\bm{\xi})]_{i}\ \geq\ 1\ -\ (N-1)\ \exp(-\ \beta\ \tilde{\Delta}_{i})\ =\ 1\ -\ \tilde{\epsilon}\ .
$$

Lemma A4 states that

$$
\displaystyle{{\left\|\bm{x}_{i}\ -\ f(\bm{\xi})\right\|}}\
$$
 
$$
\displaystyle\leqslant\ 2\ \tilde{\epsilon}\ M\ =\ 2\ (N-1)\ \exp(-\ \beta\ \tilde{\Delta}_{i})\ M
$$
 
$$
\displaystyle\leqslant\ 2\ (N-1)\ \exp(-\ \beta\ (\Delta_{i}\ -\ \frac{2}{\beta\ N}))\ M\ .
$$

We have

$$
\displaystyle{{\left\|\bm{x}_{i}\ -\ f(\bm{\xi})\right\|}}
$$
 
$$
\displaystyle\leqslant\ 2\ (N-1)\ \exp(-\ \beta\ (\frac{2}{\beta\ N}\ +\ \frac{1}{\beta}\ \ln\left(2\ (N-1)\ N\ \beta\ M^{2}\right)\ -\ \frac{2}{\beta\ N}))\ M
$$
 
$$
\displaystyle=\ 2\ (N-1)\ \exp(-\ \ln\left(2\ (N-1)\ N\ \beta\ M^{2}\right))\ M
$$
 
$$
\displaystyle=\ \frac{1}{N\ \beta\ M}\ ,
$$

where we used assumption (A2) of the lemma. Therefore, $f(\bm{\xi})$ is a mapping from the sphere $\mathrm{S}_{i}$ into the sphere $\mathrm{S}_{i}$: If $\bm{\xi}\in\mathrm{S}_{i}$ then $f(\bm{\xi})\in\mathrm{S}_{i}$. ∎

•Contraction mapping.

For applying Banach fixed point theorem we need to show that $f$ is contraction in the compact environment $\mathrm{S}_{i}$.

###### Lemma A6.

Assume that

1. $$
	\displaystyle\Delta_{i}\
	$$
	 
	$$
	\displaystyle\geq\ \frac{2}{\beta\ N}\ +\ \frac{1}{\beta}\ \ln\left(2\ (N-1)\ N\ \beta\ M^{2}\right)\ ,
	$$

then $f$ is a contraction mapping in $\mathrm{S}_{i}$.

###### Proof.

The version of the mean value theorem Lemma A32 states for $\mathrm{J}^{m}=\int_{0}^{1}\mathrm{J}(\lambda\bm{\xi}+(1-\lambda)\bm{x}_{i})\ \mathrm{d}\lambda$:

$$
\displaystyle f(\bm{\xi})\
$$
 
$$
\displaystyle=\ f(\bm{x}_{i})\ +\ \mathrm{J}^{m}\ (\bm{\xi}\ -\ \bm{x}_{i})\ .
$$

Therefore

$$
\displaystyle{{\left\|f(\bm{\xi})\ -\ f(\bm{x}_{i})\right\|}}\
$$
 
$$
\displaystyle\leqslant\ {{\left\|\mathrm{J}^{m}\right\|}}_{2}\ {{\left\|\bm{\xi}\ -\ \bm{x}_{i}\right\|}}\ .
$$

We define $\tilde{\bm{\xi}}=\lambda\bm{\xi}+(1-\lambda)\bm{x}_{i}$ for some $\lambda\in[0,1]$. From the proof in Lemma A4 we have

$$
\displaystyle p_{\max}(\tilde{\bm{\xi}})\
$$
 
$$
\displaystyle=\ [\mathrm{softmax}(\beta\ \bm{X}^{T}\ \tilde{\bm{\xi}})]_{i}\ \geq\ 1\ -\ (N-1)\ \exp(-\ \beta\ \tilde{\Delta}_{i})\ =\ 1\ -\ \tilde{\epsilon}\ ,
$$
$$
\displaystyle\tilde{\epsilon}\
$$
 
$$
\displaystyle=\ (N-1)\ \exp(-\ \beta\ \tilde{\Delta}_{i})\ ,
$$
$$
\displaystyle\tilde{\Delta}_{i}\
$$
 
$$
\displaystyle=\ \min_{j,j\not=i}\left(\tilde{\bm{\xi}}^{T}\bm{x}_{i}\ -\ \tilde{\bm{\xi}}^{T}\bm{x}_{j}\right)\ .
$$

First we compute an upper bound on $\tilde{\epsilon}$. We need the separation $\tilde{\Delta}_{i}$ of $\bm{\xi}$ from the data. Using the Cauchy-Schwarz inequality, we obtain for $1\leqslant j\leqslant N$:

$$
\displaystyle\left|\tilde{\bm{\xi}}^{T}\bm{x}_{j}\ -\ \bm{x}_{i}^{T}\bm{x}_{j}\right|
$$
 
$$
\displaystyle\leqslant\ {{\left\|\tilde{\bm{\xi}}\ -\ \bm{x}_{i}\right\|}}\ {{\left\|\bm{x}_{j}\right\|}}\ \leqslant\ {{\left\|\tilde{\bm{\xi}}\ -\ \bm{x}_{i}\right\|}}\ M\ .
$$

We have the lower bound on $\tilde{\Delta}_{i}$:

$$
\displaystyle\tilde{\Delta}_{i}\
$$
 
$$
\displaystyle\geq\ \min_{j,j\not=i}\left(\left(\bm{x}_{i}^{T}\bm{x}_{i}\ -\ {{\left\|\tilde{\bm{\xi}}\ -\ \bm{x}_{i}\right\|}}\ M\right)\ -\ \left(\bm{x}_{i}^{T}\bm{x}_{j}\ +\ {{\left\|\tilde{\bm{\xi}}\ -\ \bm{x}_{i}\right\|}}\ M\right)\right)
$$
 
$$
\displaystyle=\ -\ 2\ {{\left\|\tilde{\bm{\xi}}\ -\ \bm{x}_{i}\right\|}}\ M\ +\ \min_{j,j\not=i}\left(\bm{x}_{i}^{T}\bm{x}_{i}\ -\ \bm{x}_{i}^{T}\bm{x}_{j}\right)\ =\ \Delta_{i}\ -\ 2\ {{\left\|\tilde{\bm{\xi}}\ -\ \bm{x}_{i}\right\|}}\ M
$$
 
$$
\displaystyle\geq\ \Delta_{i}\ -\ 2\ {{\left\|\bm{\xi}\ -\ \bm{x}_{i}\right\|}}\ M\ ,
$$

where we used ${{\left\|\tilde{\bm{\xi}}-\bm{x}_{i}\right\|}}=\lambda{{\left\|\bm{\xi}-\bm{x}_{i}\right\|}}\leqslant{{\left\|\bm{\xi}-\bm{x}_{i}\right\|}}$. From the definition of $\tilde{\epsilon}$ in Eq. (152) we have

$$
\displaystyle\tilde{\epsilon}\
$$
 
$$
\displaystyle=\ (N-1)\ \exp(-\ \beta\ \tilde{\Delta}_{i})
$$
 
$$
\displaystyle\leqslant\ (N-1)\ \exp\left(-\ \beta\ \left(\Delta_{i}\ -\ 2\ {{\left\|\bm{\xi}\ -\ \bm{x}_{i}\right\|}}\ M\right)\right)
$$
 
$$
\displaystyle\leqslant\ (N-1)\ \exp\left(-\ \beta\ \left(\Delta_{i}\ -\ \frac{2}{\beta\ N}\right)\right)\ ,
$$

where we used $\bm{\xi}\in\mathrm{S}_{i}$, therefore ${{\left\|\bm{\xi}\ -\ \bm{x}_{i}\right\|}}\ \leqslant\ \frac{1}{\beta\ N\ M}$.

Next we compute an lower bound on $\tilde{\epsilon}$. We start with an upper on $\tilde{\Delta}_{i}$:

$$
\displaystyle\tilde{\Delta}_{i}\
$$
 
$$
\displaystyle\leqslant\ \min_{j,j\not=i}\left(\left(\bm{x}_{i}^{T}\bm{x}_{i}\ +\ {{\left\|\tilde{\bm{\xi}}\ -\ \bm{x}_{i}\right\|}}\ M\right)\ -\ \left(\bm{x}_{i}^{T}\bm{x}_{j}\ -\ {{\left\|\tilde{\bm{\xi}}\ -\ \bm{x}_{i}\right\|}}\ M\right)\right)
$$
 
$$
\displaystyle=\ 2\ {{\left\|\tilde{\bm{\xi}}\ -\ \bm{x}_{i}\right\|}}\ M\ +\ \min_{j,j\not=i}\left(\bm{x}_{i}^{T}\bm{x}_{i}\ -\ \bm{x}_{i}^{T}\bm{x}_{j}\right)\ =\ \Delta_{i}\ +\ 2\ {{\left\|\tilde{\bm{\xi}}\ -\ \bm{x}_{i}\right\|}}\ M
$$
 
$$
\displaystyle\leqslant\ \Delta_{i}\ +\ 2\ {{\left\|\bm{\xi}\ -\ \bm{x}_{i}\right\|}}\ M\ ,
$$

where we used ${{\left\|\tilde{\bm{\xi}}-\bm{x}_{i}\right\|}}=\lambda{{\left\|\bm{\xi}-\bm{x}_{i}\right\|}}\leqslant{{\left\|\bm{\xi}-\bm{x}_{i}\right\|}}$. From the definition of $\tilde{\epsilon}$ in Eq. (152) we have

$$
\displaystyle\tilde{\epsilon}\
$$
 
$$
\displaystyle=\ (N-1)\ \exp(-\ \beta\ \tilde{\Delta}_{i})
$$
 
$$
\displaystyle\geq\ (N-1)\ \exp\left(-\ \beta\ \left(\Delta_{i}\ +\ 2\ {{\left\|\bm{\xi}\ -\ \bm{x}_{i}\right\|}}\ M\right)\right)
$$
 
$$
\displaystyle\geq\ (N-1)\ \exp\left(-\ \beta\ \left(\Delta_{i}\ +\ \frac{2}{\beta\ N}\right)\right)\ ,
$$

where we used $\bm{\xi}\in\mathrm{S}_{i}$, therefore ${{\left\|\bm{\xi}\ -\ \bm{x}_{i}\right\|}}\ \leqslant\ \frac{1}{\beta\ N\ M}$.

Now we bound the Jacobian. We can assume $\tilde{\epsilon}\leqslant 0.5$ otherwise $(1-\tilde{\epsilon})\leqslant 0.5$ in the following. From the proof of Lemma A24 we know for $p_{\max}(\tilde{\bm{\xi}})\geq 1-\tilde{\epsilon}$, then $p_{i}(\tilde{\bm{\xi}})\leqslant\tilde{\epsilon}$ for $p_{i}(\tilde{\bm{\xi}})\not=p_{\max}(\tilde{\bm{\xi}})$. Therefore, $p_{i}(\tilde{\bm{\xi}})(1-p_{i}(\tilde{\bm{\xi}}))\leqslant m\leqslant\tilde{\epsilon}(1-\tilde{\epsilon})$ for all $i$. Next we use the derived upper and lower bound on $\tilde{\epsilon}$ in previous Eq. (61) in Lemma A2:

$$
\displaystyle{{\left\|\mathrm{J}(\tilde{\bm{\xi}})\right\|}}_{2}\
$$
 
$$
\displaystyle\leqslant\ 2\ \beta\ N\ M^{2}\ \tilde{\epsilon}\ -\ 2\ \tilde{\epsilon}^{2}\ \beta\ N\ M^{2}
$$
 
$$
\displaystyle\leqslant\ 2\ \beta\ N\ M^{2}\ (N-1)\ \exp\left(-\ \beta\ \left(\Delta_{i}\ -\frac{2}{\beta\ N}\right)\right)\ -
$$
 
$$
\displaystyle 2\ (N-1)^{2}\ \exp\left(-\ 2\ \beta\ \left(\Delta_{i}\ +\ \frac{2}{\beta\ N}\right)\right)\ \beta\ N\ M^{2}\ .
$$

The bound Eq. (160) holds for the mean $\mathrm{J}^{m}$, too, since it averages over $\mathrm{J}(\tilde{\bm{\xi}})$:

$$
\displaystyle{{\left\|\mathrm{J}^{m}\right\|}}_{2}\
$$
 
$$
\displaystyle\leqslant\ 2\ \beta\ N\ M^{2}\ (N-1)\ \exp\left(-\ \beta\ \left(\Delta_{i}\ -\ \frac{2}{\beta\ N}\right)\right)\ -
$$
 
$$
\displaystyle 2\ (N-1)^{2}\ \exp\left(-\ 2\ \beta\ \left(\Delta_{i}\ +\ \frac{2}{\beta\ N}\right)\right)\ \beta\ N\ M^{2}\ .
$$

The assumption of the lemma is

$$
\displaystyle\Delta_{i}\
$$
 
$$
\displaystyle\geq\ \frac{2}{\beta\ N}\ +\ \frac{1}{\beta}\ \ln\left(2\ (N-1)\ N\ \beta\ M^{2}\right)\ ,
$$

This is

$$
\displaystyle\Delta_{i}\ -\ \frac{2}{\beta\ N}\
$$
 
$$
\displaystyle\geq\ \frac{1}{\beta}\ \ln\left(2\ (N-1)\ N\ \beta\ M^{2}\right)\ ,
$$

Therefore, the spectral norm ${{\left\|\mathrm{J}\right\|}}_{2}$ can be bounded by:

$$
\displaystyle{{\left\|\mathrm{J}^{m}\right\|}}_{2}\ \leqslant\ 2\ \beta\ (N-1)\ \exp\left(-\ \beta\ \frac{1}{\beta}\ \ln\left(2\ (N-1)\ N\ \beta\ M^{2}\right)\right)\ N\ M^{2}\ -
$$
 
$$
\displaystyle 2\ (N-1)^{2}\ \exp\left(-\ 2\ \beta\ \left(\Delta_{i}\ +\ \frac{2}{\beta\ N}\right)\right)\ \beta\ N\ M^{2}
$$
 
$$
\displaystyle=\ \ 2\ \beta\ (N-1)\ \frac{1}{2\ (N-1)\ N\ \beta\ M^{2}}\ N\ M^{2}\ -
$$
 
$$
\displaystyle 2\ (N-1)^{2}\ \exp\left(-\ 2\ \beta\ \left(\Delta_{i}\ +\ \frac{2}{\beta\ N}\right)\right)\ \beta\ N\ M^{2}
$$
 
$$
\displaystyle=\ 1\ -2\ (N-1)^{2}\ \exp\left(-\ 2\ \beta\ \left(\Delta_{i}\ +\ \frac{2}{\beta\ N}\right)\right)\ \beta\ N\ M^{2}\ <1\ .
$$

Therefore, $f$ is a contraction mapping in $\mathrm{S}_{i}$. ∎

•Banach Fixed Point Theorem. Now we have all ingredients to apply Banach fixed point theorem.

###### Lemma A7.

Assume that

1. $$
	\displaystyle\Delta_{i}\
	$$
	 
	$$
	\displaystyle\geq\ \frac{2}{\beta\ N}\ +\ \frac{1}{\beta}\ \ln\left(2\ (N-1)\ N\ \beta\ M^{2}\right)\ ,
	$$

then $f$ has a fixed point in $\mathrm{S}_{i}$.

###### Proof.

We use Banach fixed point theorem: Lemma A5 says that $f$ maps from $\mathrm{S}_{i}$ into $\mathrm{S}_{i}$. Lemma A6 says that $f$ is a contraction mapping in $\mathrm{S}_{i}$. ∎

•Contraction mapping with a fixed point.

We have shown that a fixed point exists. We want to know how fast the iteration converges to the fixed point. Let $\bm{x}_{i}^{*}$ be the fixed point of the iteration $f$ in the sphere $\mathrm{S}_{i}$. Using the mean value theorem Lemma A32, we have with $\mathrm{J}^{m}=\int_{0}^{1}\mathrm{J}(\lambda\bm{\xi}+(1-\lambda)\bm{x}_{i}^{*})\ \mathrm{d}\lambda$:

$$
\displaystyle{{\left\|f(\bm{\xi})\ -\ \bm{x}_{i}^{*}\right\|}}\
$$
 
$$
\displaystyle=\ {{\left\|f(\bm{\xi})\ -\ f(\bm{x}_{i}^{*})\right\|}}\ \leqslant\ {{\left\|\mathrm{J}^{m}\right\|}}_{2}\ {{\left\|\bm{\xi}\ -\ \bm{x}_{i}^{*}\right\|}}
$$

According to Lemma A24, if $p_{\max}=\max_{i}p_{i}\geq 1-\epsilon$ for all $\tilde{\bm{x}}=\lambda\bm{\xi}+(1-\lambda)\bm{x}_{i}^{*}$, then the spectral norm of the Jacobian is bounded by

$$
\displaystyle{{\left\|\mathrm{J}_{s}(\tilde{\bm{x}})\right\|}}_{2}\
$$
 
$$
\displaystyle<\ 2\ \epsilon\ \beta\ .
$$

The norm of Jacobian at $\tilde{\bm{x}}$ is bounded

$$
\displaystyle{{\left\|\mathrm{J}(\tilde{\bm{x}})\right\|}}_{2}\
$$
 
$$
\displaystyle\leqslant\ 2\ \beta\ {{\left\|\bm{X}\right\|}}_{2}^{2}\ \epsilon\ \leqslant\ 2\ \beta\ NM^{2}\ \epsilon\ .
$$

We used that the spectral norm ${{\left\|.\right\|}}_{2}$ is bounded by the Frobenius norm ${{\left\|.\right\|}}_{F}$ which can be expressed by the norm squared of its column vectors:

$$
\displaystyle{{\left\|\bm{X}\right\|}}_{2}\
$$
 
$$
\displaystyle\leqslant\ {{\left\|\bm{X}\right\|}}_{F}\ =\ \sqrt{\sum_{i}{{\left\|\bm{x}_{i}\right\|}}^{2}}\ .
$$

Therefore

$$
\displaystyle{{\left\|\bm{X}\right\|}}_{2}^{2}\
$$
 
$$
\displaystyle\leqslant\ N\ M^{2}\ .
$$

The norm of Jacobian of the fixed point iteration is bounded

$$
\displaystyle{{\left\|\mathrm{J}^{m}\right\|}}_{2}\
$$
 
$$
\displaystyle\leqslant\ 2\ \beta\ {{\left\|\bm{X}\right\|}}_{2}^{2}\ \epsilon\ \leqslant\ 2\ \beta\ NM^{2}\ \epsilon\ .
$$

The separation of pattern $\bm{x}_{i}$ from data $\bm{X}=(\bm{x}_{1},\ldots,\bm{x}_{N})$ is

$$
\displaystyle\Delta_{i}\
$$
 
$$
\displaystyle=\ \min_{j,j\not=i}\left(\bm{x}_{i}^{T}\bm{x}_{i}\ -\ \bm{x}_{i}^{T}\bm{x}_{j}\right)\ =\ \bm{x}_{i}^{T}\bm{x}_{i}\ -\ \max_{j,j\not=i}\bm{x}_{i}^{T}\bm{x}_{j}\ .
$$

We need the separation $\tilde{\Delta}_{i}$ of $\tilde{\bm{x}}=\lambda\bm{\xi}+(1-\lambda)\bm{x}_{i}^{*}$ from the data:

$$
\displaystyle\tilde{\Delta}_{i}\
$$
 
$$
\displaystyle=\ \min_{j,j\not=i}\left(\tilde{\bm{x}}^{T}\bm{x}_{i}\ -\ \tilde{\bm{x}}^{T}\bm{x}_{j}\right)\ .
$$

We compute a lower bound on $\tilde{\Delta}_{i}$. Using the Cauchy-Schwarz inequality, we obtain for $1\leqslant j\leqslant N$:

$$
\displaystyle\left|\tilde{\bm{x}}^{T}\bm{x}_{j}\ -\ \bm{x}_{i}^{T}\bm{x}_{j}\right|
$$
 
$$
\displaystyle\leqslant\ {{\left\|\tilde{\bm{x}}\ -\ \bm{x}_{i}\right\|}}\ {{\left\|\bm{x}_{j}\right\|}}\ \leqslant\ {{\left\|\tilde{\bm{x}}\ -\ \bm{x}_{i}\right\|}}\ M\ .
$$

We have the lower bound

$$
\displaystyle\tilde{\Delta}_{i}\
$$
 
$$
\displaystyle\geq\ \min_{j,j\not=i}\left(\left(\bm{x}_{i}^{T}\bm{x}_{i}\ -\ {{\left\|\tilde{\bm{x}}\ -\ \bm{x}_{i}\right\|}}\ M\right)\ -\ \left(\bm{x}_{i}^{T}\bm{x}_{j}\ +\ {{\left\|\tilde{\bm{x}}\ -\ \bm{x}_{i}\right\|}}\ M\right)\right)
$$
 
$$
\displaystyle=\ -\ 2\ {{\left\|\tilde{\bm{x}}\ -\ \bm{x}_{i}\right\|}}\ M\ +\ \min_{j,j\not=i}\left(\bm{x}_{i}^{T}\bm{x}_{i}\ -\ \bm{x}_{i}^{T}\bm{x}_{j}\right)\ =\ \Delta_{i}\ -\ 2\ {{\left\|\tilde{\bm{x}}\ -\ \bm{x}_{i}\right\|}}\ M\ .
$$

Since

$$
\displaystyle{{\left\|\tilde{\bm{x}}\ -\ \bm{x}_{i}\right\|}}\
$$
 
$$
\displaystyle=\ {{\left\|\lambda\bm{\xi}+(1-\lambda)\bm{x}_{i}^{*}\ -\ \bm{x}_{i}\right\|}}
$$
 
$$
\displaystyle\leqslant\ \lambda\ {{\left\|\bm{\xi}\ -\ \bm{x}_{i}\right\|}}\ +\ (1-\lambda)\ {{\left\|\bm{x}_{i}^{*}\ -\ \bm{x}_{i}\right\|}}
$$
 
$$
\displaystyle\leqslant\ \max\{{{\left\|\bm{\xi}\ -\ \bm{x}_{i}\right\|}},{{\left\|\bm{x}_{i}^{*}\ -\ \bm{x}_{i}\right\|}}\}\ ,
$$

we have

$$
\displaystyle\tilde{\Delta}_{i}\
$$
 
$$
\displaystyle\geq\ \Delta_{i}\ -\ 2\ \max\{{{\left\|\bm{\xi}\ -\ \bm{x}_{i}\right\|}},{{\left\|\bm{x}_{i}^{*}\ -\ \bm{x}_{i}\right\|}}\}\ M\ .
$$

For the softmax component $i$ we have:

$$
\displaystyle[\mathrm{softmax}(\beta\ \bm{X}^{T}\tilde{\bm{\xi}})]_{i}\ =\ \frac{1}{1\ +\ \sum_{j\not=i}\exp(\beta\ (\tilde{\bm{\xi}}^{T}\bm{x}_{j}\ -\ \tilde{\bm{\xi}}^{T}\bm{x}_{i}))}
$$
 
$$
\displaystyle\geq\ \frac{1}{1\ +\ \sum_{j\not=i}\exp(-\ \beta\ (\Delta_{i}\ -\ 2\ \max\{{{\left\|\bm{\xi}\ -\ \bm{x}_{i}\right\|}},{{\left\|\bm{x}_{i}^{*}\ -\ \bm{x}_{i}\right\|}}\}\ M))}
$$
 
$$
\displaystyle=\ \frac{1}{1\ +\ (N-1)\exp(-\ \beta\ (\Delta_{i}\ -\ 2\ \max\{{{\left\|\bm{\xi}\ -\ \bm{x}_{i}\right\|}},{{\left\|\bm{x}_{i}^{*}\ -\ \bm{x}_{i}\right\|}}\}\ M))}
$$
 
$$
\displaystyle=\ 1\ -\ \frac{(N-1)\exp(-\ \beta\ (\Delta_{i}\ -\ 2\ \max\{{{\left\|\bm{\xi}\ -\ \bm{x}_{i}\right\|}},{{\left\|\bm{x}_{i}^{*}\ -\ \bm{x}_{i}\right\|}}\}\ M))}{1\ +\ (N-1)\exp(-\ \beta\ (\Delta_{i}\ -\ 2\ \max\{{{\left\|\bm{\xi}\ -\ \bm{x}_{i}\right\|}},{{\left\|\bm{x}_{i}^{*}\ -\ \bm{x}_{i}\right\|}}\}\ M))}
$$
 
$$
\displaystyle\geq\ 1\ -\ (N-1)\exp(-\ \beta\ (\Delta_{i}\ -\ 2\ \max\{{{\left\|\bm{\xi}\ -\ \bm{x}_{i}\right\|}},{{\left\|\bm{x}_{i}^{*}\ -\ \bm{x}_{i}\right\|}}\}\ M))
$$
 
$$
\displaystyle=\ 1\ -\ \epsilon\ .
$$

Therefore

$$
\displaystyle\epsilon\
$$
 
$$
\displaystyle=\ (N-1)\exp(-\ \beta\ (\Delta_{i}\ -\ 2\ \max\{{{\left\|\bm{\xi}\ -\ \bm{x}_{i}\right\|}},{{\left\|\bm{x}_{i}^{*}\ -\ \bm{x}_{i}\right\|}}\}\ M))\ .
$$

We can bound the spectral norm of the Jacobian, which upper bounds the Lipschitz constant:

$$
\displaystyle{{\left\|\mathrm{J}^{m}\right\|}}_{2}\
$$
 
$$
\displaystyle\leqslant\ 2\ \beta\ N\ M^{2}\ (N-1)\exp(-\ \beta\ (\Delta_{i}\ -\ 2\ \max\{{{\left\|\bm{\xi}\ -\ \bm{x}_{i}\right\|}},{{\left\|\bm{x}_{i}^{*}\ -\ \bm{x}_{i}\right\|}}\}\ M))\ .
$$

For a contraction mapping we require

$$
\displaystyle{{\left\|\mathrm{J}^{m}\right\|}}_{2}\ <\ 1\ ,
$$

which can be ensured by

$$
\displaystyle 2\ \beta\ NM^{2}\ (N-1)\exp(-\ \beta\ (\Delta_{i}\ -\ 2\ \max\{{{\left\|\bm{\xi}\ -\ \bm{x}_{i}\right\|}},{{\left\|\bm{x}_{i}^{*}\ -\ \bm{x}_{i}\right\|}}\}\ M))\ <\ 1\ .
$$

Solving this inequality for $\Delta_{i}$ gives

$$
\displaystyle\Delta_{i}\
$$
 
$$
\displaystyle>\ 2\ \max\{{{\left\|\bm{\xi}\ -\ \bm{x}_{i}\right\|}},{{\left\|\bm{x}_{i}^{*}\ -\ \bm{x}_{i}\right\|}}\}\ M\ +\ \frac{1}{\beta}\ \ln\left(2\ (N-1)\ N\ \beta\ M^{2}\right)\ .
$$

In an environment around $\bm{x}_{i}^{*}$ in which Eq. (183) holds, $f$ is a contraction mapping and every point converges under the iteration $f$ to $\bm{x}_{i}^{*}$ when the iteration stays in the environment. After every iteration the mapped point $f(\bm{\xi})$ is closer to the fixed point $\bm{x}_{i}^{*}$ than the original point $\bm{x}_{i}$:

$$
\displaystyle{{\left\|f(\bm{\xi})\ -\ \bm{x}_{i}^{*}\right\|}}\
$$
 
$$
\displaystyle\leqslant\ {{\left\|\mathrm{J}^{m}\right\|}}_{2}\ {{\left\|\bm{\xi}\ -\ \bm{x}_{i}^{*}\right\|}}\ <\ {{\left\|\bm{\xi}\ -\ \bm{x}_{i}^{*}\right\|}}\ .
$$

Using

$$
\displaystyle{{\left\|f(\bm{\xi})\ -\ \bm{x}_{i}^{*}\right\|}}\ \leqslant\ {{\left\|\mathrm{J}^{m}\right\|}}_{2}\ {{\left\|\bm{\xi}\ -\ \bm{x}_{i}^{*}\right\|}}\ \leqslant\ {{\left\|\mathrm{J}^{m}\right\|}}_{2}\ {{\left\|\bm{\xi}\ -\ f(\bm{\xi})\right\|}}\ +\ {{\left\|\mathrm{J}^{m}\right\|}}_{2}\ {{\left\|f(\bm{\xi})\ -\ \bm{x}_{i}^{*}\right\|}}\ ,
$$

we obtain

$$
\displaystyle{{\left\|f(\bm{\xi})\ -\ \bm{x}_{i}^{*}\right\|}}\ \leqslant\ \frac{{{\left\|\mathrm{J}^{m}\right\|}}_{2}}{1\ -\ {{\left\|\mathrm{J}^{m}\right\|}}_{2}}\ {{\left\|\bm{\xi}\ -\ f(\bm{\xi})\right\|}}\ .
$$

For large $\Delta_{i}$ the iteration is close to the fixed point even after one update. This has been confirmed in several experiments.

##### A.1.5.4 Metastable States: Fixed Points Near Mean of Similar Patterns.

The proof concept is the same as for a single pattern but now for the arithmetic mean of similar patterns.

•Bound on the Jacobian.

The Jacobian of the fixed point iteration is

$$
\displaystyle\mathrm{J}\
$$
 
$$
\displaystyle=\ \beta\ \bm{X}\left(\mathrm{diag}(\bm{p})-\bm{p}\bm{p}^{T}\right)\bm{X}^{T}\ =\ \bm{X}\mathrm{J}_{s}\bm{X}^{T}\ .
$$

If we consider $p_{i}$ as the probability of selecting the vector $\bm{x}_{i}$, then we can define expectations as $\mathbf{\mathrm{E}}_{\bm{p}}[f(\bm{x})]=\sum_{i=1}^{N}p_{i}f(\bm{x}_{i})$. In this setting the matrix

$$
\displaystyle\bm{X}\left(\mathrm{diag}(\bm{p})-\bm{p}\bm{p}^{T}\right)\bm{X}^{T}
$$

is the covariance matrix of data $\bm{X}$ when its vectors are selected according to the probability $\bm{p}$:

$$
\displaystyle\bm{X}\left(\mathrm{diag}(\bm{p})\ -\ \bm{p}\bm{p}^{T}\right)\bm{X}^{T}\ =\ \bm{X}\mathrm{diag}(\bm{p})\bm{X}^{T}\ -\ \bm{X}\bm{p}\bm{p}^{T}\bm{X}^{T}
$$
 
$$
\displaystyle=\ \sum_{i=1}^{N}p_{i}\ \bm{x}_{i}\ \bm{x}_{i}^{T}\ -\ \left(\sum_{i=1}^{N}p_{i}\ \bm{x}_{i}\right)\left(\sum_{i=1}^{N}p_{i}\ \bm{x}_{i}\right)^{T}
$$
 
$$
\displaystyle=\ \mathbf{\mathrm{E}}_{\bm{p}}[\bm{x}\ \bm{x}^{T}]\ -\ \mathbf{\mathrm{E}}_{\bm{p}}[\bm{x}]\ \mathbf{\mathrm{E}}_{\bm{p}}[\bm{x}]^{T}\ =\ \mathbf{\mathrm{Var}}_{\bm{p}}[\bm{x}]\ ,
$$

therefore we have

$$
\displaystyle\mathrm{J}\
$$
 
$$
\displaystyle=\ \beta\ \mathbf{\mathrm{Var}}_{\bm{p}}[\bm{x}]\ .
$$

We now elaborate more on this interpretation as variance. Specifically the singular values of $\mathrm{J}$ (or in other words: the covariance) should be reasonably small. The singular values are the key to ensure convergence of the iteration Eq. (57). Next we present some thoughts.

1. It’s clear that the largest eigenvalue of the covariance matrix (equal to the largest singular value) is the variance in the direction of the eigenvector associated with the largest eigenvalue.
2. Furthermore the variance goes to zero as one $p_{i}$ goes to one, since only one pattern is chosen and there is no variance.
3. The variance is reasonable small if all patterns are chosen with equal probability.
4. The variance is small if few similar patterns are chosen with high probability. If the patterns are sufficient similar, then the spectral norm of the covariance matrix is smaller than one.

The first three issues have already been adressed. Now we focus on the last one in greater detail. We assume that the first $l$ patterns are much more probable (and similar to one another) than the other patterns. Therefore, we define:

$$
\displaystyle M\
$$
 
$$
\displaystyle:=\ \max_{i}{{\left\|\bm{x}_{i}\right\|}}\ ,
$$
$$
\displaystyle\gamma\
$$
 
$$
\displaystyle=\ \sum_{i=l+1}^{N}p_{i}\ \leqslant\ \epsilon\ ,
$$
$$
\displaystyle 1-\gamma\
$$
 
$$
\displaystyle=\ \sum_{i=1}^{l}p_{i}\ \geq\ 1\ -\ \epsilon\ ,
$$
$$
\displaystyle\tilde{p}_{i}\
$$
 
$$
\displaystyle:=\ \frac{p_{i}}{1-\gamma}\ \leqslant\ p_{i}/(1-\epsilon)\ ,
$$
$$
\displaystyle\sum_{i=1}^{l}\tilde{p}_{i}\
$$
 
$$
\displaystyle=\ 1\ ,
$$
$$
\displaystyle\bm{m}_{\bm{x}}\
$$
 
$$
\displaystyle=\ \frac{1}{l}\ \sum_{i=1}^{l}\ \bm{x}_{i}\ ,
$$
$$
\displaystyle m_{\max}\
$$
 
$$
\displaystyle=\ \max_{1\leqslant i\leqslant l}{{\left\|\bm{x}_{i}\ -\ \bm{m}_{\bm{x}}\right\|}}\ .
$$

$M$ is an upper bound on the Euclidean norm of the patterns, which are vectors. $\epsilon$ is an upper bound on the probability $\gamma$ of not choosing one of the first $l$ patterns, while $1-\epsilon$ is a lower bound the probability $(1-\gamma)$ of choosing one of the first $l$ patterns. $\bm{m}_{\bm{x}}$ is the arithmetic mean (the center) of the first $l$ patterns. $m_{\max}$ is the maximal distance of the patterns to the center $\bm{m}_{\bm{x}}$. $\tilde{\bm{p}}$ is the probability $\bm{p}$ normalized for the first $l$ patterns.

The variance of the first $l$ patterns is

$$
\displaystyle\mathbf{\mathrm{Var}}_{\tilde{p}}[\bm{x}_{1:l}]\
$$
 
$$
\displaystyle=\ \sum_{i=1}^{l}\tilde{p}_{i}\ \bm{x}_{i}\ \bm{x}_{i}^{T}\ -\ \left(\sum_{i=1}^{l}\tilde{p}_{i}\ \bm{x}_{i}\right)\ \left(\sum_{i=1}^{l}\tilde{p}_{i}\ \bm{x}_{i}\right)^{T}
$$
 
$$
\displaystyle=\ \sum_{i=1}^{l}\tilde{p}_{i}\ \left(\bm{x}_{i}\ -\ \sum_{i=1}^{l}\tilde{p}_{i}\bm{x}_{i}\right)\ \left(\bm{x}_{i}\ -\ \sum_{i=1}^{l}\tilde{p}_{i}\bm{x}_{i}\right)^{T}\ .
$$

###### Lemma A8.

With the definitions in Eq. (193) to Eq. (200), the following bounds on the norm ${{\left\|\mathrm{J}\right\|}}_{2}$ of the Jacobian of the fixed point iteration hold. The $\gamma$ -bound for ${{\left\|\mathrm{J}\right\|}}_{2}$ is

$$
\displaystyle{{\left\|\mathrm{J}\right\|}}_{2}\
$$
 
$$
\displaystyle\leqslant\ \beta\left((1-\gamma)\ m_{\max}^{2}\ +\ \gamma\ 2\ (2\ -\ \gamma)\ M^{2}\right)
$$

and the $\epsilon$ -bound for ${{\left\|\mathrm{J}\right\|}}_{2}$ is:

$$
\displaystyle{{\left\|\mathrm{J}\right\|}}_{2}\
$$
 
$$
\displaystyle\leqslant\ \beta\left(\ m_{\max}^{2}\ +\ \epsilon\ 2\ (2\ -\ \epsilon)\ M^{2}\right)\ .
$$

###### Proof.

The variance $\mathbf{\mathrm{Var}}_{\tilde{p}}[\bm{x}_{1:l}]$ can be expressed as:

$$
\displaystyle(1-\gamma)\ \mathbf{\mathrm{Var}}_{\tilde{p}}[\bm{x}_{1:l}]\ =\ \sum_{i=1}^{l}p_{i}\ \left(\bm{x}_{i}\ -\ \frac{1}{1-\gamma}\ \sum_{i=1}^{l}p_{i}\ \bm{x}_{i}\right)\ \left(\bm{x}_{i}\ -\ \frac{1}{1-\gamma}\ \sum_{i=1}^{l}p_{i}\ \bm{x}_{i}\right)^{T}
$$
 
$$
\displaystyle=\ \sum_{i=1}^{l}p_{i}\ \bm{x}_{i}\ \bm{x}_{i}^{T}\ -\ \left(\sum_{i=1}^{l}p_{i}\ \bm{x}_{i}\right)\ \frac{1}{1-\gamma}\ \left(\sum_{i=1}^{l}p_{i}\ \bm{x}_{i}\right)^{T}\ -\ \frac{1}{1-\gamma}\ \left(\sum_{i=1}^{l}p_{i}\ \bm{x}_{i}\right)\ \left(\sum_{i=1}^{l}p_{i}\ \bm{x}_{i}\right)^{T}
$$
 
$$
\displaystyle+\ \frac{\sum_{i=1}^{l}p_{i}}{(1-\gamma)^{2}}\ \left(\sum_{i=1}^{l}p_{i}\ \bm{x}_{i}\right)\ \left(\sum_{i=1}^{l}p_{i}\ \bm{x}_{i}\right)^{T}\ =\ \sum_{i=1}^{l}p_{i}\ \bm{x}_{i}\ \bm{x}_{i}^{T}\ -\ \frac{1}{1-\gamma}\ \left(\sum_{i=1}^{l}p_{i}\ \bm{x}_{i}\right)\ \left(\sum_{i=1}^{l}p_{i}\ \bm{x}_{i}\right)^{T}
$$
 
$$
\displaystyle=\ \sum_{i=1}^{l}p_{i}\ \bm{x}_{i}\ \bm{x}_{i}^{T}\ -\ \left(\sum_{i=1}^{l}p_{i}\ \bm{x}_{i}\right)\ \left(\sum_{i=1}^{l}p_{i}\ \bm{x}_{i}\right)^{T}\ +\ \left(1\ -\ \frac{1}{1-\gamma}\right)\ \left(\sum_{i=1}^{l}p_{i}\ \bm{x}_{i}\right)\ \left(\sum_{i=1}^{l}p_{i}\ \bm{x}_{i}\right)^{T}
$$
 
$$
\displaystyle=\ \sum_{i=1}^{l}p_{i}\ \bm{x}_{i}\ \bm{x}_{i}^{T}\ -\ \left(\sum_{i=1}^{l}p_{i}\ \bm{x}_{i}\right)\ \left(\sum_{i=1}^{l}p_{i}\ \bm{x}_{i}\right)^{T}\ -\ \frac{\gamma}{1-\gamma}\ \left(\sum_{i=1}^{l}p_{i}\ \bm{x}_{i}\right)\ \left(\sum_{i=1}^{l}p_{i}\ \bm{x}_{i}\right)^{T}\ .
$$

Therefore, we have

$$
\displaystyle\sum_{i=1}^{l}p_{i}\ \bm{x}_{i}\ \bm{x}_{i}^{T}\ -\ \left(\sum_{i=1}^{l}p_{i}\ \bm{x}_{i}\right)\ \left(\sum_{i=1}^{l}p_{i}\ \bm{x}_{i}\right)^{T}
$$
 
$$
\displaystyle=\ (1-\gamma)\ \mathbf{\mathrm{Var}}_{\tilde{p}}[\bm{x}_{1:l}]\ +\ \frac{\gamma}{1-\gamma}\ \left(\sum_{i=1}^{l}p_{i}\ \bm{x}_{i}\right)\ \left(\sum_{i=1}^{l}p_{i}\ \bm{x}_{i}\right)^{T}\ .
$$

We now can reformulate the Jacobian $\mathrm{J}$:

$$
\displaystyle\mathrm{J}\
$$
 
$$
\displaystyle=\ \beta\ \left(\sum_{i=1}^{l}p_{i}\ \bm{x}_{i}\ \bm{x}_{i}^{T}\ +\ \sum_{i=l+1}^{N}p_{i}\ \bm{x}_{i}\ \bm{x}_{i}^{T}\right.
$$
$$
\displaystyle-\ \left.\left(\sum_{i=1}^{l}p_{i}\ \bm{x}_{i}\ +\ \sum_{i=l+1}^{N}p_{i}\ \bm{x}_{i}\right)\left(\sum_{i=1}^{l}p_{i}\ \bm{x}_{i}\ +\ \sum_{i=l+1}^{N}p_{i}\ \bm{x}_{i}\right)^{T}\right)
$$
 
$$
\displaystyle=\ \beta\ \left(\sum_{i=1}^{l}p_{i}\ \bm{x}_{i}\ \bm{x}_{i}^{T}\ -\ \left(\sum_{i=1}^{l}p_{i}\ \bm{x}_{i}\right)\ \left(\sum_{i=1}^{l}p_{i}\ \bm{x}_{i}\right)^{T}\right.
$$
$$
\displaystyle+\ \left.\sum_{i=l+1}^{N}p_{i}\ \bm{x}_{i}\ \bm{x}_{i}^{T}\ -\ \left(\sum_{i=l+1}^{N}p_{i}\ \bm{x}_{i}\right)\ \left(\sum_{i=l+1}^{N}p_{i}\ \bm{x}_{i}\right)^{T}\right.
$$
$$
\displaystyle-\ \left.\left(\sum_{i=1}^{l}p_{i}\ \bm{x}_{i}\right)\ \left(\sum_{i=l+1}^{N}p_{i}\ \bm{x}_{i}\right)^{T}\ -\ \left(\sum_{i=l+1}^{N}p_{i}\ \bm{x}_{i}\right)\left(\sum_{i=1}^{l}p_{i}\ \bm{x}_{i}\right)^{T}\right)
$$
 
$$
\displaystyle=\ \beta\ \left((1-\gamma)\ \mathbf{\mathrm{Var}}_{\tilde{p}}[\bm{x}_{1:l}]\ +\ \frac{\gamma}{1-\gamma}\ \left(\sum_{i=1}^{l}p_{i}\ \bm{x}_{i}\right)\ \left(\sum_{i=1}^{l}p_{i}\ \bm{x}_{i}\right)^{T}\right.
$$
$$
\displaystyle+\ \left.\sum_{i=l+1}^{N}p_{i}\ \bm{x}_{i}\ \bm{x}_{i}^{T}\ -\ \left(\sum_{i=l+1}^{N}p_{i}\ \bm{x}_{i}\right)\ \left(\sum_{i=l+1}^{N}p_{i}\ \bm{x}_{i}\right)^{T}\right.
$$
$$
\displaystyle-\ \left.\left(\sum_{i=1}^{l}p_{i}\ \bm{x}_{i}\right)\ \left(\sum_{i=l+1}^{N}p_{i}\ \bm{x}_{i}\right)^{T}\ -\ \left(\sum_{i=l+1}^{N}p_{i}\ \bm{x}_{i}\right)\left(\sum_{i=1}^{l}p_{i}\ \bm{x}_{i}\right)^{T}\right)\ .
$$

The spectral norm of an outer product of two vectors is the product of the Euclidean norms of the vectors:

$$
\displaystyle{{\left\|\bm{a}\bm{b}^{T}\right\|}}_{2}\
$$
 
$$
\displaystyle=\ \sqrt{\lambda_{\max}(\bm{b}\bm{a}^{T}\bm{a}\bm{b}^{T})}\ =\ {{\left\|\bm{a}\right\|}}\ \sqrt{\lambda_{\max}(\bm{b}\bm{b}^{T})}\ =\ {{\left\|\bm{a}\right\|}}\ {{\left\|\bm{b}\right\|}}\ ,
$$

since $\bm{b}\bm{b}^{T}$ has eigenvector $\bm{b}/{{\left\|\bm{b}\right\|}}$ with eigenvalue ${{\left\|\bm{b}\right\|}}^{2}$ and otherwise zero eigenvalues.

We now bound the norms of some matrices and vectors:

$$
\displaystyle{{\left\|\sum_{i=1}^{l}p_{i}\ \bm{x}_{i}\right\|}}\
$$
 
$$
\displaystyle\leqslant\ \sum_{i=1}^{l}p_{i}\ {{\left\|\bm{x}_{i}\right\|}}\ \leqslant\ (1-\gamma)\ M\ ,
$$
$$
\displaystyle{{\left\|\sum_{i=l+1}^{N}p_{i}\ \bm{x}_{i}\right\|}}\
$$
 
$$
\displaystyle\leqslant\ \sum_{i=l+1}^{N}p_{i}\ {{\left\|\bm{x}_{i}\right\|}}\ \leqslant\ \gamma\ M\ ,
$$
$$
\displaystyle{{\left\|\sum_{i=l+1}^{N}p_{i}\ \bm{x}_{i}\ \bm{x}_{i}^{T}\right\|}}_{2}\
$$
 
$$
\displaystyle\leqslant\ \sum_{i=l+1}^{N}p_{i}\ {{\left\|\bm{x}_{i}\ \bm{x}_{i}^{T}\right\|}}_{2}\ =\ \sum_{i=l+1}^{N}p_{i}\ {{\left\|\bm{x}_{i}\right\|}}^{2}\ \leqslant\ \sum_{i=l+1}^{N}p_{i}\ M^{2}\ =\ \gamma\ M^{2}\ .
$$

In order to bound the variance of the first $l$ patterns, we compute the vector $\bm{a}$ that minimizes

$$
\displaystyle f(\bm{a})\
$$
 
$$
\displaystyle=\ \sum_{i=1}^{l}p_{i}{{\left\|\bm{x}_{i}\ -\ \bm{a}\right\|}}^{2}\ =\ \sum_{i=1}^{l}p_{i}(\bm{x}_{i}\ -\ \bm{a})^{T}(\bm{x}_{i}\ -\ \bm{a})\ .
$$

The solution to

$$
\displaystyle\frac{\partial f(\bm{a})}{\partial\bm{a}}\
$$
 
$$
\displaystyle=\ 2\ \sum_{i=1}^{N}p_{i}(\bm{a}\ -\ \bm{x}_{i})\ =\ 0
$$

is

$$
\displaystyle\bm{a}\
$$
 
$$
\displaystyle=\ \sum_{i=1}^{N}p_{i}\bm{x}_{i}\ .
$$

The Hessian of $f$ is positive definite since

$$
\displaystyle\frac{\partial^{2}f(\bm{a})}{\partial\bm{a}^{2}}\
$$
 
$$
\displaystyle=\ 2\ \sum_{i=1}^{N}p_{i}\ \bm{I}\ =\ 2\ \bm{I}
$$

and $f$ is a convex function. Hence, the mean

$$
\displaystyle\bar{\bm{x}}\
$$
 
$$
\displaystyle:=\ \sum_{i=1}^{N}p_{i}\ \bm{x}_{i}
$$

minimizes $\sum_{i=1}^{N}p_{i}{{\left\|\bm{x}_{i}-\bm{a}\right\|}}^{2}$. Therefore, we have

$$
\displaystyle\sum_{i=1}^{l}p_{i}{{\left\|\bm{x}_{i}\ -\ \bar{\bm{x}}\right\|}}^{2}\
$$
 
$$
\displaystyle\leqslant\ \sum_{i=1}^{l}p_{i}{{\left\|\bm{x}_{i}\ -\ \bm{m}_{\bm{x}}\right\|}}^{2}\ \leqslant\ (1\ -\ \gamma)\ m_{\max}^{2}\ .
$$

We now bound the variance on the first $l$ patterns:

$$
\displaystyle(1-\gamma)\ {{\left\|\mathbf{\mathrm{Var}}_{\tilde{p}}[\bm{x}_{1:l}]\right\|}}_{2}\
$$
 
$$
\displaystyle\leqslant\ \sum_{i=1}^{l}p_{i}{{\left\|\left(\bm{x}_{i}\ -\ \bar{\bm{x}}\right)\ \left(\bm{x}_{i}\ -\ \bar{\bm{x}}\right)^{T}\right\|}}_{2}
$$
 
$$
\displaystyle=\ \sum_{i=1}^{l}p_{i}{{\left\|\bm{x}_{i}\ -\ \bar{\bm{x}}\right\|}}^{2}\ \leqslant\ \sum_{i=1}^{l}p_{i}{{\left\|\bm{x}_{i}\ -\ \bm{m}_{\bm{x}}\right\|}}^{2}\ \leqslant\ (1\ -\ \gamma)\ m_{\max}^{2}\ .
$$

We obtain for the spectral norm of $\mathrm{J}$:

$$
\displaystyle{{\left\|\mathrm{J}\right\|}}_{2}\
$$
 
$$
\displaystyle\leqslant\ \beta\left((1-\gamma)\ {{\left\|\mathbf{\mathrm{Var}}_{\tilde{p}}[\bm{x}_{1:l}]\right\|}}_{2}\right.
$$
$$
\displaystyle+\ \left.\frac{\gamma}{1-\gamma}\ {{\left\|\left(\sum_{i=1}^{l}p_{i}\ \bm{x}_{i}\right)\ \left(\sum_{i=1}^{l}p_{i}\ \bm{x}_{i}\right)^{T}\right\|}}_{2}\right.
$$
$$
\displaystyle+\ \left.{{\left\|\sum_{i=l+1}^{N}p_{i}\ \bm{x}_{i}\ \bm{x}_{i}^{T}\right\|}}_{2}\ +\ {{\left\|\left(\sum_{i=l+1}^{N}p_{i}\ \bm{x}_{i}\right)\ \left(\sum_{i=l+1}^{N}p_{i}\ \bm{x}_{i}\right)^{T}\right\|}}_{2}\right.
$$
$$
\displaystyle+\ \left.{{\left\|\left(\sum_{i=1}^{l}p_{i}\ \bm{x}_{i}\right)\ \left(\sum_{i=l+1}^{N}p_{i}\ \bm{x}_{i}\right)^{T}\right\|}}_{2}\ +\ {{\left\|\left(\sum_{i=l+1}^{N}p_{i}\ \bm{x}_{i}\right)\left(\sum_{i=1}^{l}p_{i}\ \bm{x}_{i}\right)^{T}\right\|}}_{2}\right)
$$
 
$$
\displaystyle\leqslant\ \beta\left((1-\gamma)\ {{\left\|\mathbf{\mathrm{Var}}_{\tilde{p}}[\bm{x}_{1:l}]\right\|}}_{2}\ +\ \gamma\ (1-\gamma)\ M^{2}\ +\ \gamma\ M^{2}\ +\ \gamma^{2}\ M^{2}\ +\right.
$$
$$
\displaystyle\left.\gamma\ (1-\gamma)\ M^{2}\ +\ \gamma\ (1-\gamma)\ M^{2}\right)
$$
 
$$
\displaystyle=\ \beta\left((1-\gamma)\ \ {{\left\|\mathbf{\mathrm{Var}}_{\tilde{p}}[\bm{x}_{1:l}]\right\|}}_{2}\ +\ \gamma\ 2\ (2\ -\ \gamma)\ M^{2}\right)\ .
$$

Combining the previous two estimates immediately leads to Eq. (201).

The function $h(x)=x2(2-x)$ has the derivative $h^{\prime}(x)=4(1-x)$. Therefore, $h(x)$ is monotone increasing for $x<1$. For $0\leqslant\gamma\leqslant\epsilon<1$, we can immediately deduce that $\gamma 2(2-\gamma)\leqslant\epsilon 2(2-\epsilon)$. Since $\epsilon$ is larger than $\gamma$, we obtain the following $\epsilon$ -bound for ${{\left\|\mathrm{J}\right\|}}_{2}$:

$$
\displaystyle{{\left\|\mathrm{J}\right\|}}_{2}\
$$
 
$$
\displaystyle\leqslant\ \beta\left(\ m_{\max}^{2}\ +\ \epsilon\ 2\ (2\ -\ \epsilon)\ M^{2}\right)\ .
$$

∎

We revisit the bound on $(1-\gamma)\ \mathbf{\mathrm{Var}}_{\tilde{p}}[\bm{x}_{1:l}]$. The trace $\sum_{k=1}^{d}e_{k}$ is the sum of the eigenvalues $e_{k}$. The spectral norm is equal to the largest eigenvalue $e_{1}$, that is, the largest singular value. We obtain:

$$
\displaystyle{{\left\|\mathbf{\mathrm{Var}}_{\tilde{p}}[\bm{x}_{1:l}]\right\|}}_{2}\
$$
 
$$
\displaystyle=\ \mathbf{\mathrm{Tr}}\left(\sum_{i=1}^{l}p_{i}\left(\bm{x}_{i}\ -\ \bar{\bm{x}}\right)\ \left(\bm{x}_{i}\ -\ \bar{\bm{x}}\right)^{T}\right)\ -\ \sum_{k=2}^{d}e_{k}
$$
 
$$
\displaystyle=\ \sum_{i=1}^{l}p_{i}\mathbf{\mathrm{Tr}}\left(\left(\bm{x}_{i}\ -\ \bar{\bm{x}}\right)\ \left(\bm{x}_{i}\ -\ \bar{\bm{x}}\right)^{T}\right)\ -\ \sum_{k=2}^{d}e_{k}
$$
 
$$
\displaystyle=\ \sum_{i=1}^{l}p_{i}{{\left\|\bm{x}_{i}\ -\ \bar{\bm{x}}\right\|}}^{2}\ -\ \sum_{k=2}^{d}e_{k}\ .
$$

Therefore, the tightness of the bound depends on eigenvalues which are not the largest. That is variations which are not along the strongest variation weaken the bound.

•Proof of a fixed point by Banach Fixed Point Theorem.

Without restricting the generality, we assume that the first $l$ patterns are much more probable (and similar to one another) than the other patterns. Therefore, we define:

$$
\displaystyle M\
$$
 
$$
\displaystyle:=\ \max_{i}{{\left\|\bm{x}_{i}\right\|}}\ ,
$$
$$
\displaystyle\gamma\
$$
 
$$
\displaystyle=\ \sum_{i=l+1}^{N}p_{i}\ \leqslant\ \epsilon\ ,
$$
$$
\displaystyle 1-\gamma\
$$
 
$$
\displaystyle=\ \sum_{i=1}^{l}p_{i}\ \geq\ 1\ -\ \epsilon\ ,
$$
$$
\displaystyle\tilde{p}_{i}\
$$
 
$$
\displaystyle:=\ \frac{p_{i}}{1-\gamma}\ \leqslant\ p_{i}/(1-\epsilon)\ ,
$$
$$
\displaystyle\sum_{i=1}^{l}\tilde{p}_{i}\
$$
 
$$
\displaystyle=\ 1\ ,
$$
$$
\displaystyle\bm{m}_{\bm{x}}\
$$
 
$$
\displaystyle=\ \frac{1}{l}\ \sum_{i=1}^{l}\ \bm{x}_{i}\ ,
$$
$$
\displaystyle m_{\max}\
$$
 
$$
\displaystyle=\ \max_{1\leqslant i\leqslant l}{{\left\|\bm{x}_{i}\ -\ \bm{m}_{\bm{x}}\right\|}}\ .
$$

$M$ is an upper bound on the Euclidean norm of the patterns, which are vectors. $\epsilon$ is an upper bound on the probability $\gamma$ of not choosing one of the first $l$ patterns, while $1-\epsilon$ is a lower bound the probability $(1-\gamma)$ of choosing one of the first $l$ patterns. $\bm{m}_{\bm{x}}$ is the arithmetic mean (the center) of the first $l$ patterns. $m_{\max}$ is the maximal distance of the patterns to the center $\bm{m}_{\bm{x}}$. $\tilde{\bm{p}}$ is the probability $\bm{p}$ normalized for the first $l$ patterns.

•Mapped vectors stay in a compact environment. We show that if $\bm{m}_{\bm{x}}$ is sufficient dissimilar to other $\bm{x}_{j}$ with $l<j$ then there is an compact environment of $\bm{m}_{\bm{x}}$ (a sphere) where the fixed point iteration maps this environment into itself. The idea of the proof is to define a sphere around $\bm{m}_{\bm{x}}$ for which the points from the sphere are mapped by $f$ into the sphere.

We first need following lemma which bounds the distance ${{\left\|\bm{m}_{\bm{x}}\ -\ f(\bm{\xi})\right\|}}$ of a $\bm{\xi}$ which is close to $\bm{m}_{\bm{x}}$.

###### Lemma A9.

For a query $\bm{\xi}$ and data $\bm{X}=(\bm{x}_{1},\ldots,\bm{x}_{N})$, we define

$$
\displaystyle 0\
$$
 
$$
\displaystyle\leqslant\ c\ =\ \min_{j,l<j}\left(\bm{\xi}^{T}\bm{m}_{\bm{x}}\ -\ \bm{\xi}^{T}\bm{x}_{j}\right)\ =\ \bm{\xi}^{T}\bm{m}_{\bm{x}}\ -\ \max_{j,l<j}\bm{\xi}^{T}\bm{x}_{j}\ .
$$

The following holds:

$$
\displaystyle{{\left\|\bm{m}_{\bm{x}}\ -\ f(\bm{\xi})\right\|}}\
$$
 
$$
\displaystyle\leqslant\ m_{\max}\ +\ 2\ \gamma\ M\ \leqslant\ m_{\max}\ +\ 2\ \epsilon\ M\ ,
$$

where

$$
\displaystyle M\
$$
 
$$
\displaystyle=\ \max_{i}{{\left\|\bm{x}_{i}\right\|}}\ ,
$$
$$
\displaystyle\epsilon\
$$
 
$$
\displaystyle=\ (N-l)\ \exp(-\ \beta\ c)\ .
$$

###### Proof.

Let $s=\arg\max_{j,j\leqslant l}\bm{\xi}^{T}\bm{x}_{j}$, therefore $\bm{\xi}^{T}\bm{m}_{\bm{x}}=\frac{1}{l}\ \sum_{i=1}^{l}\ \bm{\xi}^{T}\bm{x}_{i}\leqslant\frac{1}{l}\ \sum_{i=1}^{l}\ \bm{\xi}^{T}\bm{x}_{s}=\bm{\xi}^{T}\bm{x}_{s}$. For softmax components $j$ with $l<j$ we have

$$
\displaystyle[\mathrm{softmax}(\beta\bm{X}^{T}\bm{\xi})]_{j}\
$$
 
$$
\displaystyle=\ \frac{\exp(\beta\ (\bm{\xi}^{T}\bm{x}_{j}\ -\ \bm{\xi}^{T}\bm{x}_{s}))}{1\ +\ \sum_{k,k\not=s}\exp(\beta\ (\bm{\xi}^{T}\bm{x}_{k}\ -\ \bm{\xi}^{T}\bm{x}_{s}))}\ \leqslant\ \exp(-\ \beta\ c)\ =\ \frac{\epsilon}{N-l}\ ,
$$

since $\bm{\xi}^{T}\bm{x}_{s}-\bm{\xi}^{T}\bm{x}_{j}\geq\bm{\xi}^{T}\bm{m}_{\bm{x}}-\bm{\xi}^{T}\bm{x}_{j}$ for each $j$ with $l<j$, therefore $\bm{\xi}^{T}\bm{x}_{s}-\bm{\xi}^{T}\bm{x}_{j}\geq c$

The iteration $f$ can be written as

$$
\displaystyle f(\bm{\xi})\
$$
 
$$
\displaystyle=\ \bm{X}\mathrm{softmax}(\beta\bm{X}^{T}\bm{\xi})\ =\ \sum_{j=1}^{N}\bm{x}_{j}\ [\mathrm{softmax}(\beta\bm{X}^{T}\bm{\xi})]_{j}\ .
$$

We set $p_{i}=[\mathrm{softmax}(\beta\bm{X}^{T}\bm{\xi})]_{i}$, therefore $\sum_{i=1}^{l}p_{i}=1-\gamma\geq 1-\epsilon$ and $\sum_{i=l+1}^{N}p_{i}=\gamma\leqslant\epsilon$. Therefore

$$
\displaystyle{{\left\|\bm{m}_{\bm{x}}\ -\ \sum_{j=1}^{l}\frac{p_{j}}{1-\gamma}\ \bm{x}_{j}\right\|}}^{2}\ =\ {{\left\|\sum_{j=1}^{l}\frac{p_{j}}{1-\gamma}\left(\bm{m}_{\bm{x}}\ -\ \bm{x}_{j}\right)\right\|}}^{2}
$$
 
$$
\displaystyle=\ \sum_{j=1,k=1}^{l}\frac{p_{j}}{1-\gamma}\frac{p_{k}}{1-\gamma}\left(\bm{m}_{\bm{x}}\ -\ \bm{x}_{j}\right)^{T}\left(\bm{m}_{\bm{x}}\ -\ \bm{x}_{k}\right)
$$
 
$$
\displaystyle=\ \frac{1}{2}\ \sum_{j=1,k=1}^{l}\frac{p_{j}}{1-\gamma}\frac{p_{k}}{1-\gamma}\left({{\left\|\bm{m}_{\bm{x}}\ -\ \bm{x}_{j}\right\|}}^{2}\ +\ {{\left\|\bm{m}_{\bm{x}}\ -\ \bm{x}_{k}\right\|}}^{2}\ -\ {{\left\|\bm{x}_{j}\ -\ \bm{x}_{k}\right\|}}^{2}\right)
$$
 
$$
\displaystyle=\ \sum_{j=1}^{l}\frac{p_{j}}{1-\gamma}\ {{\left\|\bm{m}_{\bm{x}}\ -\ \bm{x}_{j}\right\|}}^{2}\ -\ \frac{1}{2}\ \sum_{j=1,k=1}^{l}\frac{p_{j}}{1-\gamma}\frac{p_{k}}{1-\gamma}{{\left\|\bm{x}_{j}\ -\ \bm{x}_{k}\right\|}}^{2}
$$
 
$$
\displaystyle\leqslant\ \sum_{j=1}^{l}\frac{p_{j}}{1-\gamma}\ {{\left\|\bm{m}_{\bm{x}}\ -\ \bm{x}_{j}\right\|}}^{2}\ \leqslant\ m_{\max}^{2}\ .
$$

It follows that

$$
\displaystyle{{\left\|\bm{m}_{\bm{x}}\ -\ \sum_{j=1}^{l}\frac{p_{j}}{1-\gamma}\ \bm{x}_{j}\right\|}}\
$$
 
$$
\displaystyle\leqslant\ m_{\max}
$$

We now can bound ${{\left\|\bm{m}_{\bm{x}}\ -\ f(\bm{\xi})\right\|}}$:

$$
\displaystyle{{\left\|\bm{m}_{\bm{x}}\ -\ f(\bm{\xi})\right\|}}\
$$
 
$$
\displaystyle=\ {{\left\|\bm{m}_{\bm{x}}\ -\ \sum_{j=1}^{N}p_{j}\ \bm{x}_{j}\right\|}}
$$
 
$$
\displaystyle=\ {{\left\|\bm{m}_{\bm{x}}\ -\ \sum_{j=1}^{l}p_{j}\ \bm{x}_{j}\ -\ \sum_{j=l+1}^{N}p_{j}\ \bm{x}_{j}\right\|}}
$$
 
$$
\displaystyle=\ {{\left\|\bm{m}_{\bm{x}}\ -\ \sum_{j=1}^{l}\frac{p_{j}}{1-\gamma}\ \bm{x}_{j}\ +\ \frac{\gamma}{1-\gamma}\ \sum_{j=1}^{l}p_{j}\ \bm{x}_{j}\ -\ \sum_{j=l+1}^{N}p_{j}\ \bm{x}_{j}\right\|}}
$$
 
$$
\displaystyle\leqslant\ {{\left\|\bm{m}_{\bm{x}}\ -\ \sum_{j=1}^{l}\frac{p_{j}}{1-\gamma}\ \bm{x}_{j}\right\|}}\ +\ \frac{\gamma}{1-\gamma}\ {{\left\|\sum_{j=1}^{l}p_{j}\ \bm{x}_{j}\right\|}}\ +\ {{\left\|\sum_{j=l+1}^{N}p_{j}\ \bm{x}_{j}\right\|}}
$$
 
$$
\displaystyle\leqslant\ {{\left\|\bm{m}_{\bm{x}}\ -\ \sum_{j=1}^{l}\frac{p_{j}}{1-\gamma}\ \bm{x}_{j}\right\|}}\ +\ \frac{\gamma}{1-\gamma}\ \sum_{j=1}^{l}p_{j}\ M\ +\ \sum_{j=l+1}^{N}p_{j}\ M
$$
 
$$
\displaystyle\leqslant\ {{\left\|\bm{m}_{\bm{x}}\ -\ \sum_{j=1}^{l}\frac{p_{j}}{1-\gamma}\ \bm{x}_{j}\right\|}}\ +\ 2\ \gamma\ M
$$
 
$$
\displaystyle\leqslant\ m_{\max}\ +\ 2\ \gamma\ M\ \leqslant\ m_{\max}\ +\ 2\ \epsilon\ M\ ,
$$

where we applied Eq. (233) in the penultimate inequality. This is the statement of the lemma. ∎

The separation of the center (the arithmetic mean) $\bm{m}_{\bm{x}}$ of the first $l$ from data $\bm{X}=(\bm{x}_{l+1},\ldots,\bm{x}_{N})$ is $\Delta_{m}$, defined as

$$
\displaystyle\Delta_{m}\
$$
 
$$
\displaystyle=\ \min_{j,l<j}\left(\bm{m}_{\bm{x}}^{T}\bm{m}_{\bm{x}}\ -\ \bm{m}_{\bm{x}}^{T}\bm{x}_{j}\right)\ =\ \bm{m}_{\bm{x}}^{T}\bm{m}_{\bm{x}}\ -\ \max_{j,l<j}\bm{m}_{\bm{x}}^{T}\bm{x}_{j}\ .
$$

The center is separated from the other data $\bm{x}_{j}$ with $l<j$ if $0<\Delta_{m}$. By the same arguments as in Eq. (140), $\Delta_{m}$ can also be expressed as

$$
\displaystyle\Delta_{m}\
$$
 
$$
\displaystyle=\ \min_{j,l<j}\frac{1}{2}\ \left({{\left\|\bm{m}_{\bm{x}}\right\|}}^{2}\ -\ {{\left\|\bm{x}_{j}\right\|}}^{2}\ +\ {{\left\|\bm{m}_{\bm{x}}\ -\ \bm{x}_{j}\right\|}}^{2}\right)
$$
 
$$
\displaystyle=\ \frac{1}{2}{{\left\|\bm{m}_{\bm{x}}\right\|}}^{2}\ -\ \frac{1}{2}\ \max_{j,l<j}\left({{\left\|\bm{x}_{j}\right\|}}^{2}\ -\ {{\left\|\bm{m}_{\bm{x}}\ -\ \bm{x}_{j}\right\|}}^{2}\right)\ .
$$

For ${{\left\|\bm{m}_{\bm{x}}\right\|}}={{\left\|\bm{x}_{j}\right\|}}$ we have $\Delta_{m}=1/2\min_{j,l<j}{{\left\|\bm{m}_{\bm{x}}\ -\ \bm{x}_{j}\right\|}}^{2}$.

Next we define the sphere where we want to apply Banach fixed point theorem.

###### Definition 4 (Sphere Sm\\mathrm{S}\_{m}).

The sphere $\mathrm{S}_{m}$ is defined as

$$
\displaystyle\mathrm{S}_{m}\
$$
 
$$
\displaystyle:=\ \left\{\bm{\xi}\mid{{\left\|\bm{\xi}\ -\ \bm{m}_{\bm{x}}\right\|}}\ \leqslant\ \frac{1}{\beta\ m_{\max}}\right\}\ .
$$

###### Lemma A10.

With $\bm{\xi}$ given, if the assumptions

1. $\bm{\xi}$ is inside sphere: $\bm{\xi}\in\mathrm{S}_{m}$,
2. the center $\bm{m}_{\bm{x}}$ is well separated from other data $\bm{x}_{j}$ with $l<j$:
	$$
	\displaystyle\Delta_{m}\
	$$
	 
	$$
	\displaystyle\geq\ \frac{2\ M}{\beta\ m_{\max}}\ -\ \frac{1}{\beta}\ \ln\left(\frac{1\ -\ \beta\ m_{\max}^{2}}{2\ \beta\ (N-l)\ M\ \max\{m_{\max}\ ,\ 2\ M\}}\right)\ ,
	$$
3. the distance $m_{\max}$ of similar patterns to the center is sufficient small:
	$$
	\displaystyle\beta\ m_{\max}^{2}\
	$$
	 
	$$
	\displaystyle\leqslant\ 1
	$$

hold, then $f(\bm{\xi})\in\mathrm{S}_{m}$. Therefore, under conditions (A2) and (A3), $f$ is a mapping from $\mathrm{S}_{m}$ into $\mathrm{S}_{m}$.

###### Proof.

We need the separation $\tilde{\Delta}_{m}$ of $\bm{\xi}$ from the rest of the data, which is the last $N-l$ data points $\bm{X}=(\bm{x}_{l+1},\ldots,\bm{x}_{N})$.

$$
\displaystyle\tilde{\Delta}_{m}\
$$
 
$$
\displaystyle=\ \min_{j,l<j}\left(\bm{\xi}^{T}\bm{m}_{\bm{x}}\ -\ \bm{\xi}^{T}\bm{x}_{j}\right)\ .
$$

Using the Cauchy-Schwarz inequality, we obtain for $l+1\leqslant j\leqslant N$:

$$
\displaystyle\left|\bm{\xi}^{T}\bm{x}_{j}\ -\ \bm{m}_{\bm{x}}^{T}\bm{x}_{j}\right|
$$
 
$$
\displaystyle\leqslant\ {{\left\|\bm{\xi}\ -\ \bm{m}_{\bm{x}}\right\|}}\ {{\left\|\bm{x}_{j}\right\|}}\ \leqslant\ {{\left\|\bm{\xi}\ -\ \bm{m}_{\bm{x}}\right\|}}\ M\ .
$$

We have the lower bound

$$
\displaystyle\tilde{\Delta}_{m}\
$$
 
$$
\displaystyle\geq\ \min_{j,l<j}\left(\left(\bm{m}_{\bm{x}}^{T}\bm{m}_{\bm{x}}\ -\ {{\left\|\bm{\xi}\ -\ \bm{m}_{\bm{x}}\right\|}}\ M\right)\ -\ \left(\bm{m}_{\bm{x}}^{T}\bm{x}_{j}\ +\ {{\left\|\bm{\xi}\ -\ \bm{m}_{\bm{x}}\right\|}}\ M\right)\right)
$$
 
$$
\displaystyle=\ -\ 2\ {{\left\|\bm{\xi}\ -\ \bm{m}_{\bm{x}}\right\|}}\ M\ +\ \min_{j,l<j}\left(\bm{m}_{\bm{x}}^{T}\bm{m}_{\bm{x}}\ -\ \bm{m}_{\bm{x}}^{T}\bm{x}_{j}\right)\ =\ \Delta_{m}\ -\ 2\ {{\left\|\bm{\xi}\ -\ \bm{m}_{\bm{x}}\right\|}}\ M
$$
 
$$
\displaystyle\geq\ \Delta_{m}\ -\ 2\ \frac{M}{\beta\ m_{\max}}\ ,
$$

where we used the assumption (A1) of the lemma.

From the proof in Lemma A9 we have

$$
\displaystyle\sum_{i=1}^{l}p_{i}\
$$
 
$$
\displaystyle\geq\ 1\ -\ (N-l)\ \exp(-\ \beta\ \tilde{\Delta}_{m})\ =\ 1\ -\ \tilde{\epsilon}\ ,
$$
$$
\displaystyle\sum_{i=l+1}^{N}p_{i}\
$$
 
$$
\displaystyle\leqslant\ (N-l)\ \exp(-\ \beta\ \tilde{\Delta}_{m})\ =\ \tilde{\epsilon}\ .
$$

Lemma A9 states that

$$
\displaystyle{{\left\|\bm{m}_{\bm{x}}\ -\ f(\bm{\xi})\right\|}}\
$$
 
$$
\displaystyle\leqslant\ m_{\max}\ +\ 2\ \tilde{\epsilon}\ M
$$
 
$$
\displaystyle\leqslant\ m_{\max}\ +\ 2\ (N-l)\ \exp(-\ \beta\ \tilde{\Delta}_{m})\ M\ .
$$
$$
\displaystyle\leqslant\ m_{\max}\ +\ 2\ (N-l)\ \exp(-\ \beta\ (\Delta_{m}\ -\ 2\ \frac{M}{\beta\ m_{\max}}))\ M\ .
$$

Therefore, we have

$$
\displaystyle{{\left\|\bm{m}_{\bm{x}}\ -\ f(\bm{\xi})\right\|}}\ \leqslant\ m_{\max}\ +\ 2\ (N-l)\ \exp\left(-\ \beta\ (\Delta_{m}\ -\ 2\ \frac{M}{\beta\ m_{\max}})\right)\ M
$$
 
$$
\displaystyle\leqslant\ m_{\max}\ +\ 2\ (N-l)\ \exp\left(-\ \beta\ \left(\frac{2\ M}{\beta\ m_{\max}}\ -\right.\right.
$$
$$
\displaystyle\left.\left.\frac{1}{\beta}\ \ln\left(\frac{1\ -\ \beta\ m_{\max}^{2}}{2\ \beta\ (N-l)\ M\ \max\{m_{\max}\ ,\ 2\ M\}}\right)\ -\ 2\ \frac{M}{\beta\ m_{\max}}\right)\right)\ M
$$
 
$$
\displaystyle=\ m_{\max}\ +\ 2\ (N-l)\ \frac{1\ -\ \beta\ m_{\max}^{2}}{2\ \beta\ (N-l)\ M\ \max\{m_{\max}\ ,\ 2\ M\}}\ M
$$
 
$$
\displaystyle\leqslant\ m_{\max}\ +\ \frac{1\ -\ \beta\ m_{\max}^{2}}{\beta\ m_{\max}}\ =\ \frac{1}{\beta\ m_{\max}}\ ,
$$

where we used assumption (A2) of the lemma. Therefore, $f(\bm{\xi})$ is a mapping from the sphere $\mathrm{S}_{m}$ into the sphere $\mathrm{S}_{m}$.

$$
\displaystyle m_{\max}=\max_{1\leqslant i\leqslant l}{{\left\|\bm{x}_{i}-\bm{m}_{\bm{x}}\right\|}}
$$
 
$$
\displaystyle=\max_{1\leqslant i\leqslant l}{{\left\|\bm{x}_{i}-1/l\sum_{j=1}^{l}\bm{x}_{j}\right\|}}
$$
 
$$
\displaystyle=\max_{1\leqslant i\leqslant l}{{\left\|1/l\sum_{j=1}^{l}(\bm{x}_{i}-\bm{x}_{j})\right\|}}
$$
 
$$
\displaystyle\leqslant\max_{1\leqslant i,j\leqslant l}{{\left\|\bm{x}_{i}-\bm{x}_{j}\right\|}}
$$
 
$$
\displaystyle\leqslant\max_{1\leqslant i\leqslant l}{{\left\|\bm{x}_{i}\right\|}}+\max_{1\leqslant j\leqslant l}{{\left\|\bm{x}_{i}\right\|}}
$$
 
$$
\displaystyle\leqslant 2M
$$

∎

•Contraction mapping.

For applying Banach fixed point theorem we need to show that $f$ is contraction in the compact environment $\mathrm{S}_{m}$.

###### Lemma A11.

Assume that

1. $$
	\displaystyle\Delta_{m}\
	$$
	 
	$$
	\displaystyle\geq\ \frac{2\ M}{\beta\ m_{\max}}\ -\ \frac{1}{\beta}\ \ln\left(\frac{1\ -\ \beta\ m_{\max}^{2}}{2\ \beta\ (N-l)\ M\ \max\{m_{\max}\ ,\ 2\ M\}}\right)\ ,
	$$
	and
2. $$
	\displaystyle\beta\ m_{\max}^{2}\
	$$
	 
	$$
	\displaystyle\leqslant\ 1\ ,
	$$

then $f$ is a contraction mapping in $\mathrm{S}_{m}$.

###### Proof.

The version of the mean value theorem Lemma A32 states for the symmetric $\mathrm{J}^{m}=\int_{0}^{1}\mathrm{J}(\lambda\bm{\xi}+(1-\lambda)\bm{m}_{\bm{x}})\ \mathrm{d}\lambda$:

$$
\displaystyle f(\bm{\xi})\
$$
 
$$
\displaystyle=\ f(\bm{m}_{\bm{x}})\ +\ \mathrm{J}^{m}\ (\bm{\xi}\ -\ \bm{m}_{\bm{x}})\ .
$$

In complete analogy to Lemma A6, we get:

$$
\displaystyle{{\left\|f(\bm{\xi})\ -\ f(\bm{m}_{\bm{x}})\right\|}}\
$$
 
$$
\displaystyle\leqslant\ {{\left\|\mathrm{J}^{m}\right\|}}_{2}\ {{\left\|\bm{\xi}\ -\ \bm{m}_{\bm{x}}\right\|}}\ .
$$

We define $\tilde{\bm{\xi}}=\lambda\bm{\xi}+(1-\lambda)\bm{m}_{\bm{x}}$ for some $\lambda\in[0,1]$. We need the separation $\tilde{\Delta}_{m}$ of $\tilde{\bm{\xi}}$ from the rest of the data, which is the last $N-l$ data points $\bm{X}=(\bm{x}_{l+1},\ldots,\bm{x}_{N})$.

$$
\displaystyle\tilde{\Delta}_{m}\
$$
 
$$
\displaystyle=\ \min_{j,l<j}\left(\tilde{\bm{\xi}}^{T}\bm{m}_{\bm{x}}\ -\ \tilde{\bm{\xi}}^{T}\bm{x}_{j}\right)\ .
$$

From the proof in Lemma A9 we have

$$
\displaystyle\tilde{\epsilon}\
$$
 
$$
\displaystyle=\ (N-l)\ \exp(-\ \beta\ \tilde{\Delta}_{m})\ ,
$$
$$
\displaystyle\sum_{i=1}^{l}p_{i}(\tilde{\bm{\xi}})\
$$
 
$$
\displaystyle\geq\ 1\ -\ (N-l)\ \exp(-\ \beta\ \tilde{\Delta}_{m})\ =\ 1\ -\ \tilde{\epsilon}\ ,
$$
$$
\displaystyle\sum_{i=l+1}^{N}p_{i}(\tilde{\bm{\xi}})\
$$
 
$$
\displaystyle\leqslant\ (N-l)\ \exp(-\ \beta\ \tilde{\Delta}_{m})\ =\ \tilde{\epsilon}\ .
$$

We first compute an upper bound on $\tilde{\epsilon}$. Using the Cauchy-Schwarz inequality, we obtain for $l+1\leqslant j\leqslant N$:

$$
\displaystyle\left|\tilde{\bm{\xi}}^{T}\bm{x}_{j}\ -\ \bm{m}_{\bm{x}}^{T}\bm{x}_{j}\right|
$$
 
$$
\displaystyle\leqslant\ {{\left\|\tilde{\bm{\xi}}\ -\ \bm{m}_{\bm{x}}\right\|}}\ {{\left\|\bm{x}_{j}\right\|}}\ \leqslant\ {{\left\|\tilde{\bm{\xi}}\ -\ \bm{m}_{\bm{x}}\right\|}}\ M\ .
$$

We have the lower bound on $\tilde{\Delta}_{m}$:

$$
\displaystyle\tilde{\Delta}_{m}\
$$
 
$$
\displaystyle\geq\ \min_{j,l<j}\left(\left(\bm{m}_{\bm{x}}^{T}\bm{m}_{\bm{x}}\ -\ {{\left\|\tilde{\bm{\xi}}\ -\ \bm{m}_{\bm{x}}\right\|}}\ M\right)\ -\ \left(\bm{m}_{\bm{x}}^{T}\bm{x}_{j}\ +\ {{\left\|\tilde{\bm{\xi}}\ -\ \bm{m}_{\bm{x}}\right\|}}\ M\right)\right)
$$
 
$$
\displaystyle=\ -\ 2\ {{\left\|\tilde{\bm{\xi}}\ -\ \bm{m}_{\bm{x}}\right\|}}\ M\ +\ \min_{j,l<j}\left(\bm{m}_{\bm{x}}^{T}\bm{m}_{\bm{x}}\ -\ \bm{m}_{\bm{x}}^{T}\bm{x}_{j}\right)\ =\ \Delta_{m}\ -\ 2\ {{\left\|\tilde{\bm{\xi}}\ -\ \bm{m}_{\bm{x}}\right\|}}\ M
$$
 
$$
\displaystyle\geq\ \Delta_{m}\ -\ 2\ {{\left\|\bm{\xi}\ -\ \bm{m}_{\bm{x}}\right\|}}\ M\ .
$$

where we used ${{\left\|\tilde{\bm{\xi}}-\bm{m}_{\bm{x}}\right\|}}=\lambda{{\left\|\bm{\xi}-\bm{m}_{\bm{x}}\right\|}}\leqslant{{\left\|\bm{\xi}-\bm{m}_{\bm{x}}\right\|}}$. We obtain the upper bound on $\tilde{\epsilon}$:

$$
\displaystyle\tilde{\epsilon}\
$$
 
$$
\displaystyle\leqslant\ (N-l)\ \exp\left(-\ \beta\ \left(\Delta_{m}\ -\ 2\ {{\left\|\bm{\xi}\ -\ \bm{m}_{\bm{x}}\right\|}}\ M\right)\right)
$$
 
$$
\displaystyle\leqslant\ (N-l)\ \exp\left(-\ \beta\ \left(\Delta_{m}\ -\ \frac{2\ M}{\beta\ m_{\max}}\right)\right)\ .
$$

where we used that in the sphere $\mathrm{S}_{i}$ holds:

$$
\displaystyle{{\left\|\bm{\xi}\ -\ \bm{m}_{\bm{x}}\right\|}}\ \leqslant\ \frac{1}{\beta\ m_{\max}}\ ,
$$

therefore

$$
\displaystyle 2\ {{\left\|\bm{\xi}\ -\ \bm{m}_{\bm{x}}\right\|}}\ M\ \leqslant\ \frac{2\ M}{\beta\ m_{\max}}\ .
$$

Next we compute a lower bound on $\tilde{\epsilon}$ and to this end start with the upper bound on $\tilde{\Delta}_{m}$ using the same arguments as in Eq. (158) in combination with Eq. (266).

$$
\displaystyle\tilde{\Delta}_{m}\
$$
 
$$
\displaystyle\geq\ \min_{j,l<j}\left(\left(\bm{m}_{\bm{x}}^{T}\bm{m}_{\bm{x}}\ +\ {{\left\|\tilde{\bm{\xi}}\ -\ \bm{m}_{\bm{x}}\right\|}}\ M\right)\ -\ \left(\bm{m}_{\bm{x}}^{T}\bm{x}_{j}\ -\ {{\left\|\tilde{\bm{\xi}}\ -\ \bm{m}_{\bm{x}}\right\|}}\ M\right)\right)
$$
 
$$
\displaystyle=\ 2\ {{\left\|\tilde{\bm{\xi}}\ -\ \bm{m}_{\bm{x}}\right\|}}\ M\ +\ \min_{j,l<j}\left(\bm{m}_{\bm{x}}^{T}\bm{m}_{\bm{x}}\ -\ \bm{m}_{\bm{x}}^{T}\bm{x}_{j}\right)\ =\ \Delta_{m}\ +\ 2\ {{\left\|\tilde{\bm{\xi}}\ -\ \bm{m}_{\bm{x}}\right\|}}\ M
$$
 
$$
\displaystyle\geq\ \Delta_{m}\ +\ 2\ {{\left\|\bm{\xi}\ -\ \bm{m}_{\bm{x}}\right\|}}\ M\ .
$$

where we used ${{\left\|\tilde{\bm{\xi}}-\bm{m}_{\bm{x}}\right\|}}=\lambda{{\left\|\bm{\xi}-\bm{m}_{\bm{x}}\right\|}}\leqslant{{\left\|\bm{\xi}-\bm{m}_{\bm{x}}\right\|}}$. We obtain the lower bound on $\tilde{\epsilon}$:

$$
\displaystyle\tilde{\epsilon}\
$$
 
$$
\displaystyle\geq\ (N-l)\ \exp\left(-\ \beta\ \left(\Delta_{m}\ +\ \frac{2\ M}{\beta\ m_{\max}}\right)\right)\ ,
$$

where we used that in the sphere $\mathrm{S}_{i}$ holds:

$$
\displaystyle{{\left\|\bm{\xi}\ -\ \bm{m}_{\bm{x}}\right\|}}\ \leqslant\ \frac{1}{\beta\ m_{\max}}\ ,
$$

therefore

$$
\displaystyle 2\ {{\left\|\bm{\xi}\ -\ \bm{m}_{\bm{x}}\right\|}}\ M\ \leqslant\ \frac{2\ M}{\beta\ m_{\max}}\ .
$$

From Lemma A8 we have

$$
\displaystyle{{\left\|\mathrm{J}(\tilde{\bm{\xi}})\right\|}}_{2}\
$$
 
$$
\displaystyle\leqslant\ \beta\left(\ m_{\max}^{2}\ +\ \tilde{\epsilon}\ 2\ (2\ -\ \tilde{\epsilon})\ M^{2}\right)
$$
 
$$
\displaystyle=\ \beta\left(m_{\max}^{2}\ +\ \tilde{\epsilon}4\ M^{2}\ -\ 2\ \tilde{\epsilon}^{2}\ M^{2}\right)
$$
 
$$
\displaystyle\leqslant\ \beta\left(m_{\max}^{2}\ +\ (N-l)\ \exp\left(-\ \beta\ \left(\Delta_{m}\ -\ \frac{2\ M}{\beta\ m_{\max}}\right)\right)4\ M^{2}\ -\right.
$$
$$
\displaystyle\left.2\ (N-l)^{2}\ \exp\left(-\ 2\ \beta\ \left(\Delta_{m}\ +\ \frac{2\ M}{\beta\ m_{\max}}\right)\right)\ M^{2}\right)\ .
$$

The bound Eq. (271) holds for the mean $\mathrm{J}^{m}$, too, since it averages over $\mathrm{J}(\tilde{\bm{\xi}})$:

$$
\displaystyle{{\left\|\mathrm{J}^{m}\right\|}}_{2}\
$$
 
$$
\displaystyle\leqslant\ \beta\left(m_{\max}^{2}\ +\ (N-l)\ \exp\left(-\ \beta\ \left(\Delta_{m}\ -\ \frac{2\ M}{\beta\ m_{\max}}\right)\right)4\ M^{2}\ -\right.
$$
$$
\displaystyle\left.2\ (N-l)^{2}\ \exp\left(-\ 2\ \beta\ \left(\Delta_{m}\ +\ \frac{2\ M}{\beta\ m_{\max}}\right)\right)\ M^{2}\right)\ .
$$

The assumption of the lemma is

$$
\displaystyle\Delta_{m}\
$$
 
$$
\displaystyle\geq\ \frac{2\ M}{\beta\ m_{\max}}\ -\ \frac{1}{\beta}\ \ln\left(\frac{1\ -\ \beta\ m_{\max}^{2}}{2\ \beta\ (N-l)\ M\ \max\{m_{\max}\ ,\ 2\ M\}}\right)\ ,
$$

Therefore, we have

$$
\displaystyle\Delta_{m}\ -\ \frac{2\ M}{\beta\ m_{\max}}\
$$
 
$$
\displaystyle\geq\ -\ \frac{1}{\beta}\ \ln\left(\frac{1\ -\ \beta\ m_{\max}^{2}}{2\ \beta\ (N-l)\ M\ \max\{m_{\max}\ ,\ 2\ M\}}\right)\ .
$$

Therefore, the spectral norm ${{\left\|\mathrm{J}^{m}\right\|}}_{2}$ can be bounded by:

$$
\displaystyle{{\left\|\mathrm{J}^{m}\right\|}}_{2}\ \leqslant
$$
 
$$
\displaystyle\beta\left(m_{\max}^{2}\ +\ (N-l)\ \exp\left(-\ \beta\ \left(-\ \frac{1}{\beta}\ \ln\left(\frac{1\ -\ \beta\ m_{\max}^{2}}{2\ \beta\ (N-l)\ M\ \max\{m_{\max}\ ,\ 2\ M\}}\right)\right)\right)\right.
$$
$$
\displaystyle\left.4\ M^{2}\ -\ 2\ (N-l)^{2}\ \exp\left(-\ 2\ \beta\ \left(\Delta_{m}\ +\ \frac{2\ M}{\beta\ m_{\max}}\right)\right)\ M^{2}\right)
$$
 
$$
\displaystyle=\ \beta\left(m_{\max}^{2}\ +\ (N-l)\ \exp\left(\ln\left(\frac{1\ -\ \beta\ m_{\max}^{2}}{2\ \beta\ (N-l)\ M\ \max\{m_{\max}\ ,\ 2\ M\}}\right)\right)\right.
$$
$$
\displaystyle\left.4\ M^{2}\ -\ 2\ (N-l)^{2}\ \exp\left(-\ 2\ \beta\ \left(\Delta_{m}\ +\ \frac{2\ M}{\beta\ m_{\max}}\right)\right)\ M^{2}\right)
$$
 
$$
\displaystyle=\ \beta\left(m_{\max}^{2}\ +\ (N-l)\ \frac{1\ -\ \beta\ m_{\max}^{2}}{2\ \beta\ (N-l)\ M\ \max\{m_{\max}\ ,\ 2\ M\}}\ 4\ M^{2}\ -\right.
$$
$$
\displaystyle\left.2\ (N-l)^{2}\ \exp\left(-\ 2\ \beta\ \left(\Delta_{m}\ +\ \frac{2\ M}{\beta\ m_{\max}}\right)\right)\ M^{2}\right)
$$
 
$$
\displaystyle=\ \beta m_{\max}^{2}\ +\ \frac{1\ -\ \beta\ m_{\max}^{2}}{\ \max\{m_{\max}\ ,\ 2\ M\}}\ 2\ M\ -
$$
 
$$
\displaystyle\beta\ 2\ (N-l)^{2}\ \exp\left(-\ 2\ \beta\ \left(\Delta_{m}\ +\ \frac{2\ M}{\beta\ m_{\max}}\right)\right)\ M^{2}
$$
 
$$
\displaystyle\leqslant\ \beta m_{\max}^{2}\ +\ 1\ -\ \beta\ m_{\max}^{2}\ -\ \beta\ 2\ (N-l)^{2}\ \exp\left(-\ 2\ \beta\ \left(\Delta_{m}\ +\ \frac{2\ M}{\beta\ m_{\max}}\right)\right)\ M^{2}
$$
 
$$
\displaystyle=\ 1\ -\ \beta\ 2\ (N-l)^{2}\ \exp\left(-\ 2\ \beta\ \left(\Delta_{m}\ +\ \frac{2\ M}{\beta\ m_{\max}}\right)\right)\ M^{2}\ <1\ .
$$

For the last but one inequality we used $2M\leqslant\max\{m_{\max},2M\}$.

Therefore, $f$ is a contraction mapping in $\mathrm{S}_{m}$. ∎

•Banach Fixed Point Theorem. Now we have all ingredients to apply Banach fixed point theorem.

###### Lemma A12.

Assume that

1. $$
	\displaystyle\Delta_{m}\
	$$
	 
	$$
	\displaystyle\geq\ \frac{2\ M}{\beta\ m_{\max}}\ -\ \frac{1}{\beta}\ \ln\left(\frac{1\ -\ \beta\ m_{\max}^{2}}{2\ \beta\ (N-l)\ M\ \max\{m_{\max}\ ,\ 2\ M\}}\right)\ ,
	$$
	and
2. $$
	\displaystyle\beta\ m_{\max}^{2}\
	$$
	 
	$$
	\displaystyle\leqslant\ 1\ ,
	$$

then $f$ has a fixed point in $\mathrm{S}_{m}$.

###### Proof.

We use Banach fixed point theorem: Lemma A10 says that $f$ maps from the compact set $\mathrm{S}_{m}$ into the same compact set $\mathrm{S}_{m}$. Lemma A11 says that $f$ is a contraction mapping in $\mathrm{S}_{m}$. ∎

•Contraction mapping with a fixed point.

We assume that the first $l$ patterns are much more probable (and similar to one another) than the other patterns. Therefore, we define:

$$
\displaystyle M\
$$
 
$$
\displaystyle:=\ \max_{i}{{\left\|\bm{x}_{i}\right\|}}\ ,
$$
$$
\displaystyle\gamma\
$$
 
$$
\displaystyle=\ \sum_{i=l+1}^{N}p_{i}\ \leqslant\ \epsilon\ ,
$$
$$
\displaystyle 1-\gamma\
$$
 
$$
\displaystyle=\ \sum_{i=1}^{l}p_{i}\ \geq\ 1\ -\ \epsilon\ ,
$$
$$
\displaystyle\tilde{p}_{i}\
$$
 
$$
\displaystyle:=\ \frac{p_{i}}{1-\gamma}\ \leqslant\ p_{i}/(1-\epsilon)\ ,
$$
$$
\displaystyle\sum_{i=1}^{l}\tilde{p}_{i}\
$$
 
$$
\displaystyle=\ 1\ ,
$$
$$
\displaystyle\bm{m}_{\bm{x}}\
$$
 
$$
\displaystyle=\ \frac{1}{l}\ \sum_{i=1}^{l}\ \bm{x}_{i}\ ,
$$
$$
\displaystyle m_{\max}\
$$
 
$$
\displaystyle=\ \max_{1\leqslant i\leqslant l}{{\left\|\bm{x}_{i}\ -\ \bm{m}_{\bm{x}}\right\|}}\ .
$$

$M$ is an upper bound on the Euclidean norm of the patterns, which are vectors. $\epsilon$ is an upper bound on the probability $\gamma$ of not choosing one of the first $l$ patterns, while $1-\epsilon$ is a lower bound the probability $(1-\gamma)$ of choosing one of the first $l$ patterns. $\bm{m}_{\bm{x}}$ is the arithmetic mean (the center) of the first $l$ patterns. $m_{\max}$ is the maximal distance of the patterns to the center $\bm{m}_{\bm{x}}$. $\tilde{\bm{p}}$ is the probability $\bm{p}$ normalized for the first $l$ patterns.

The variance of the first $l$ patterns is

$$
\displaystyle\mathbf{\mathrm{Var}}_{\tilde{p}}[\bm{x}_{1:l}]\
$$
 
$$
\displaystyle=\ \sum_{i=1}^{l}\tilde{p}_{i}\ \bm{x}_{i}\ \bm{x}_{i}^{T}\ -\ \left(\sum_{i=1}^{l}\tilde{p}_{i}\ \bm{x}_{i}\right)\ \left(\sum_{i=1}^{l}\tilde{p}_{i}\ \bm{x}_{i}\right)^{T}
$$
 
$$
\displaystyle=\ \sum_{i=1}^{l}\tilde{p}_{i}\ \left(\bm{x}_{i}\ -\ \sum_{i=1}^{l}\tilde{p}_{i}\bm{x}_{i}\right)\ \left(\bm{x}_{i}\ -\ \sum_{i=1}^{l}\tilde{p}_{i}\bm{x}_{i}\right)^{T}\ .
$$

We have shown that a fixed point exists. We want to know how fast the iteration converges to the fixed point. Let $\bm{m}_{\bm{x}}^{*}$ be the fixed point of the iteration $f$ in the sphere $\mathrm{S}_{m}$. Using the mean value theorem Lemma A32, we have with $\mathrm{J}^{m}=\int_{0}^{1}\mathrm{J}(\lambda\bm{\xi}+(1-\lambda)\bm{m}_{\bm{x}}^{*})\ \mathrm{d}\lambda$:

$$
\displaystyle{{\left\|f(\bm{\xi})\ -\ \bm{m}_{\bm{x}}^{*}\right\|}}\
$$
 
$$
\displaystyle=\ {{\left\|f(\bm{\xi})\ -\ f(\bm{m}_{\bm{x}}^{*})\right\|}}\ \leqslant\ {{\left\|\mathrm{J}^{m}\right\|}}_{2}\ {{\left\|\bm{\xi}\ -\ \bm{m}_{\bm{x}}^{*}\right\|}}
$$

According to Lemma A8 the following bounds on the norm ${{\left\|\mathrm{J}\right\|}}_{2}$ of the Jacobian of the fixed point iteration hold. The $\gamma$ -bound for ${{\left\|\mathrm{J}\right\|}}_{2}$ is

$$
\displaystyle{{\left\|\mathrm{J}\right\|}}_{2}\
$$
 
$$
\displaystyle\leqslant\ \beta\left((1-\gamma)\ m_{\max}^{2}\ +\ \gamma\ 2\ (2\ -\ \gamma)\ M^{2}\right)\ ,
$$

while the $\epsilon$ -bound for ${{\left\|\mathrm{J}\right\|}}_{2}$ is:

$$
\displaystyle{{\left\|\mathrm{J}\right\|}}_{2}\
$$
 
$$
\displaystyle\leqslant\ \beta\left(\ m_{\max}^{2}\ +\ \epsilon\ 2\ (2\ -\ \epsilon)\ M^{2}\right)\ .
$$

From the last condition we require for a contraction mapping:

$$
\displaystyle\beta\ \ m_{\max}^{2}\
$$
 
$$
\displaystyle<\ 1\ .
$$

We want to see how large $\epsilon$ is. The separation of center $\bm{m}_{\bm{x}}$ from data $\bm{X}=(\bm{x}_{l+1},\ldots,\bm{x}_{N})$ is

$$
\displaystyle\Delta_{m}\
$$
 
$$
\displaystyle=\ \min_{j,l<j}\left(\bm{m}_{\bm{x}}^{T}\bm{m}_{\bm{x}}\ -\ \bm{m}_{\bm{x}}^{T}\bm{x}_{j}\right)\ =\ \bm{m}_{\bm{x}}^{T}\bm{m}_{\bm{x}}\ -\ \max_{j,l<j}\bm{m}_{\bm{x}}^{T}\bm{x}_{j}\ .
$$

We need the separation $\tilde{\Delta}_{m}$ of $\tilde{\bm{x}}=\lambda\bm{\xi}+(1-\lambda)\bm{m}_{\bm{x}}^{*}$ from the data.

$$
\displaystyle\tilde{\Delta}_{m}\
$$
 
$$
\displaystyle=\ \min_{j,l<j}\left(\tilde{\bm{x}}^{T}\bm{m}_{\bm{x}}\ -\ \tilde{\bm{x}}^{T}\bm{x}_{j}\right)\ .
$$

We compute a lower bound on $\tilde{\Delta}_{m}$. Using the Cauchy-Schwarz inequality, we obtain for $1\leqslant j\leqslant N$:

$$
\displaystyle\left|\tilde{\bm{x}}^{T}\bm{x}_{j}\ -\ \bm{m}_{\bm{x}}^{T}\bm{x}_{j}\right|
$$
 
$$
\displaystyle\leqslant\ {{\left\|\tilde{\bm{x}}\ -\ \bm{m}_{\bm{x}}\right\|}}\ {{\left\|\bm{x}_{j}\right\|}}\ \leqslant\ {{\left\|\tilde{\bm{x}}\ -\ \bm{m}_{\bm{x}}\right\|}}\ M\ .
$$

We have the lower bound

$$
\displaystyle\tilde{\Delta}_{m}\
$$
 
$$
\displaystyle\geq\ \min_{j,l<j}\left(\left(\bm{m}_{\bm{x}}^{T}\bm{m}_{\bm{x}}\ -\ {{\left\|\tilde{\bm{x}}\ -\ \bm{m}_{\bm{x}}\right\|}}\ M\right)\ -\ \left(\bm{m}_{\bm{x}}^{T}\bm{x}_{j}\ +\ {{\left\|\tilde{\bm{x}}\ -\ \bm{m}_{\bm{x}}\right\|}}\ M\right)\right)
$$
 
$$
\displaystyle=\ -\ 2\ {{\left\|\tilde{\bm{x}}\ -\ \bm{m}_{\bm{x}}\right\|}}\ M\ +\ \min_{j,l<j}\left(\bm{m}_{\bm{x}}^{T}\bm{m}_{\bm{x}}\ -\ \bm{m}_{\bm{x}}^{T}\bm{x}_{j}\right)\ =\ \Delta_{m}\ -\ 2\ {{\left\|\tilde{\bm{x}}\ -\ \bm{m}_{\bm{x}}\right\|}}\ M\ .
$$

Since

$$
\displaystyle{{\left\|\tilde{\bm{x}}\ -\ \bm{m}_{\bm{x}}\right\|}}\
$$
 
$$
\displaystyle=\ {{\left\|\lambda\bm{\xi}+(1-\lambda)\bm{m}_{\bm{x}}^{*}\ -\ \bm{m}_{\bm{x}}\right\|}}
$$
 
$$
\displaystyle\leqslant\ \lambda\ {{\left\|\bm{\xi}\ -\ \bm{m}_{\bm{x}}\right\|}}\ +\ (1-\lambda)\ {{\left\|\bm{m}_{\bm{x}}^{*}\ -\ \bm{m}_{\bm{x}}\right\|}}
$$
 
$$
\displaystyle\leqslant\ \max\{{{\left\|\bm{\xi}\ -\ \bm{m}_{\bm{x}}\right\|}},{{\left\|\bm{m}_{\bm{x}}^{*}\ -\ \bm{m}_{\bm{x}}\right\|}}\}\ ,
$$

we have

$$
\displaystyle\tilde{\Delta}_{m}\
$$
 
$$
\displaystyle\geq\ \Delta_{m}\ -\ 2\ \max\{{{\left\|\bm{\xi}\ -\ \bm{m}_{\bm{x}}\right\|}},{{\left\|\bm{m}_{\bm{x}}^{*}\ -\ \bm{m}_{\bm{x}}\right\|}}\}\ M\ .
$$
 
$$
\displaystyle\epsilon\
$$
 
$$
\displaystyle=\ (N-l)\exp(-\ \beta\ (\Delta_{m}\ -\ 2\ \max\{{{\left\|\bm{\xi}\ -\ \bm{m}_{\bm{x}}\right\|}},{{\left\|\bm{m}_{\bm{x}}^{*}\ -\ \bm{m}_{\bm{x}}\right\|}}\}\ M))\ .
$$

#### A.1.6 Properties of Fixed Points Near Stored Pattern

In Subsection A.1.5.3 many stable states that are fixed points near the stored patterns are considered. We now consider this case. In the fist subsection we investigate the storage capacity if all patterns are sufficiently separated so that metastable states do not appear. In the next subsection we look into the updates required and error when retrieving the stored patterns. For metastable states we can do the same analyses if each metastable state is treated as one state like one pattern.

We see a trade-off that is known from classical Hopfield networks and for modern Hopfield networks. Small separation $\Delta_{i}$ of the pattern $\bm{x}_{i}$ from the other patterns gives high storage capacity. However the convergence speed is lower and the retrieval error higher. In contrast, large separation $\Delta_{i}$ of the pattern $\bm{x}_{i}$ from the other pattern allows the retrieval of patterns with one update step and exponentially low error.

##### A.1.6.1 Exponentially Many Patterns can be Stored.

From Subsection A.1.5.3 need some definitions. We assume to have $N$ patterns, the separation of pattern $\bm{x}_{i}$ from the other patterns ${{\left\{\bm{x}_{1},\ldots,\bm{x}_{i-1},\bm{x}_{i+1},\ldots,\bm{x}_{N}\right\}}}$ is $\Delta_{i}$, defined as

$$
\displaystyle\Delta_{i}\
$$
 
$$
\displaystyle=\ \min_{j,j\not=i}\left(\bm{x}_{i}^{T}\bm{x}_{i}\ -\ \bm{x}_{i}^{T}\bm{x}_{j}\right)\ =\ \bm{x}_{i}^{T}\bm{x}_{i}\ -\ \max_{j,j\not=i}\bm{x}_{i}^{T}\bm{x}_{j}\ .
$$

The pattern is separated from the other data if $0<\Delta_{i}$. The separation $\Delta_{i}$ can also be expressed as

$$
\displaystyle\Delta_{i}\
$$
 
$$
\displaystyle=\ \min_{j,j\not=i}\frac{1}{2}\ \left({{\left\|\bm{x}_{i}\right\|}}^{2}\ -\ {{\left\|\bm{x}_{j}\right\|}}^{2}\ +\ {{\left\|\bm{x}_{i}\ -\ \bm{x}_{j}\right\|}}^{2}\right)
$$
 
$$
\displaystyle=\ \frac{1}{2}{{\left\|\bm{x}_{i}\right\|}}^{2}\ -\ \frac{1}{2}\ \max_{j,j\not=i}\left({{\left\|\bm{x}_{j}\right\|}}^{2}\ -\ {{\left\|\bm{x}_{i}\ -\ \bm{x}_{j}\right\|}}^{2}\right)\ .
$$

For ${{\left\|\bm{x}_{i}\right\|}}={{\left\|\bm{x}_{j}\right\|}}$ we have $\Delta_{i}=1/2\min_{j,j\not=i}{{\left\|\bm{x}_{i}\ -\ \bm{x}_{j}\right\|}}^{2}$. The sphere $\mathrm{S}_{i}$ with center $\bm{x}_{i}$ is defined as

$$
\displaystyle\mathrm{S}_{i}\
$$
 
$$
\displaystyle=\ \left\{\bm{\xi}\mid{{\left\|\bm{\xi}\ -\ \bm{x}_{i}\right\|}}\ \leqslant\ \frac{1}{\beta\ N\ M}\right\}\ .
$$

The maximal length of a pattern is $M=\max_{i}{{\left\|\bm{x}_{i}\right\|}}$.

We next define what we mean with storing and retrieving a pattern.

###### Definition 5 (Pattern Stored and Retrieved).

We assume that around every pattern $\bm{x}_{i}$ a sphere $\mathrm{S}_{i}$ is given. We say $\bm{x}_{i}$ is stored if there is a single fixed point $\bm{x}_{i}^{*}\in\mathrm{S}_{i}$ to which all points $\bm{\xi}\in\mathrm{S}_{i}$ converge, and $\mathrm{S}_{i}\cap\mathrm{S}_{j}=\emptyset$ for $i\not=j$. We say $\bm{x}_{i}$ is retrieved for a given $\epsilon$ if iteration (update rule) Eq. (92) gives a point $\tilde{\bm{x}}_{i}$ that is at least $\epsilon$ -close to the single fixed point $\bm{x}_{i}^{*}\in\mathrm{S}_{i}$. The retrieval error is ${{\left\|\tilde{\bm{x}}_{i}-\bm{x}_{i}\right\|}}$.

The sphere $\mathrm{S}_{i}$ around pattern $\bm{x}_{i}$ can be any a sphere and do not have the specific sphere defined in Def. 3.

For a query $\bm{\xi}\in\mathrm{S}_{i}$ to converge to a fixed point $\bm{x}_{i}^{*}\in\mathrm{S}_{i}$ we required for the application of Banach fixed point theorem and for ensuring a contraction mapping the following inequality:

$$
\displaystyle\Delta_{i}\
$$
 
$$
\displaystyle\geq\ \frac{2}{\beta\ N}\ +\ \frac{1}{\beta}\ \ln\left(2\ (N-1)\ N\ \beta\ M^{2}\right)\ .
$$

This is the assumption in Lemma A7 to ensure a fixed point in sphere $\mathrm{S}_{i}$. Since replacing $(N-1)N$ by $N^{2}$ gives

$$
\displaystyle\frac{2}{\beta\ N}\ +\ \frac{1}{\beta}\ \ln\left(2\ N^{2}\ \beta\ M^{2}\right)\ >\ \frac{2}{\beta\ N}\ +\ \frac{1}{\beta}\ \ln\left(2\ (N-1)\ N\ \beta\ M^{2}\right)\ ,
$$

the inequality follows from following master inequality

$$
\displaystyle\Delta_{i}\
$$
 
$$
\displaystyle\geq\ \frac{2}{\beta\ N}\ +\ \frac{1}{\beta}\ \ln\left(2\ N^{2}\ \beta\ M^{2}\right)\ ,
$$

If we assume that $\mathrm{S}_{i}\cap\mathrm{S}_{j}\neq\emptyset$ with $i\neq j$, then the triangle inequality with a point from the intersection gives

$$
\displaystyle{{\left\|\bm{x}_{i}\ -\ \bm{x}_{j}\right\|}}\
$$
 
$$
\displaystyle\leqslant\ \frac{2}{\beta\ N\ M}\ .
$$

Therefore, we have using the Cauchy-Schwarz inequality:

$$
\displaystyle\Delta_{i}\
$$
 
$$
\displaystyle\leqslant\ \bm{x}_{i}^{T}\left(\bm{x}_{i}\ -\ \bm{x}_{j}\right)\ \leqslant\ {{\left\|\bm{x}_{i}\right\|}}\ {{\left\|\bm{x}_{i}\ -\ \bm{x}_{j}\right\|}}\ \leqslant M\ \frac{2}{\beta\ N\ M}\ =\ \frac{2}{\beta\ N}\ .
$$

The last inequality is a contraction to Eq. (302) if we assume that

$$
\displaystyle 1\
$$
 
$$
\displaystyle<\ 2\ (N-1)\ N\ \beta\ M^{2}\ .
$$

With this assumption, the spheres $\mathrm{S}_{i}$ and $\mathrm{S}_{j}$ do not intersect. Therefore, each $\bm{x}_{i}$ has its separate fixed point in $\mathrm{S}_{i}$. We define

$$
\displaystyle\Delta_{\min}\
$$
 
$$
\displaystyle=\ \min_{1\leqslant i\leqslant N}\Delta_{i}
$$

to obtain the master inequality

$$
\displaystyle\Delta_{\min}\
$$
 
$$
\displaystyle\geq\ \frac{2}{\beta\ N}\ +\ \frac{1}{\beta}\ \ln\left(2\ N^{2}\ \beta\ M^{2}\right)\ .
$$

•Patterns on a sphere.

For simplicity and in accordance with the results of the classical Hopfield network, we assume all patterns being on a sphere with radius $M$:

$$
\displaystyle\forall_{i}:\ {{\left\|\bm{x}_{i}\right\|}}\
$$
 
$$
\displaystyle=\ M\ .
$$

Under assumption Eq. (305) we have only to show that the master inequality Eq. (307) is fulfilled for each $\bm{x}_{i}$ to have a separate fixed point near each $\bm{x}_{i}$.

We defined $\alpha_{ij}$ as the angle between $\bm{x}_{i}$ and $\bm{x}_{j}$. The minimal angle $\alpha_{\min}$ between two data points is

$$
\displaystyle\alpha_{\min}\
$$
 
$$
\displaystyle=\ \min_{1\leqslant i<j\leqslant N}\alpha_{ij}\ .
$$

On the sphere with radius $M$ we have

$$
\displaystyle\Delta_{\min}\
$$
 
$$
\displaystyle=\ \min_{1\leqslant i<j\leqslant N}M^{2}(1\ -\ \cos(\alpha_{ij}))\ =\ M^{2}(1\ -\ \cos(\alpha_{\min}))\ ,
$$

therefore it is sufficient to show the master inequality on the sphere:

$$
\displaystyle M^{2}(1\ -\ \cos(\alpha_{\min}))\
$$
 
$$
\displaystyle\geq\ \frac{2}{\beta\ N}\ +\ \frac{1}{\beta}\ \ln\left(2\ N^{2}\ \beta\ M^{2}\right)\ .
$$

Under assumption Eq. (305) we have only to show that the master inequality Eq. (307) is fulfilled for $\Delta_{\min}$. We consider patterns on the sphere, therefore the master inequality Eq. (307) becomes Eq. (311). First we show results when pattern positions on the sphere are constructed and $\Delta_{\min}$ is ensured. Then we move on to random patterns on a sphere, where $\Delta_{\min}$ becomes a random variable.

•Storage capacity for patterns placed on the sphere.

Next theorem says how many patterns we can stored (fixed point with attraction basin near pattern) if we are allowed to place them on the sphere.

###### Theorem A3 (Storage Capacity (M=2): Placed Patterns).

We assume $\beta=1$ and patterns on the sphere with radius $M$. If $M=2\sqrt{d-1}$ and the dimension $d$ of the space is $d\geq 4$ or if $M=1.7\sqrt{d-1}$ and the dimension $d$ of the space is $d\geq 50$, then the number of patterns $N$ that can be stored (fixed point with attraction basin near pattern) is at least

$$
\displaystyle N\
$$
 
$$
\displaystyle=\ 2^{2(d-1)}\ .
$$

###### Proof.

For random patterns on the sphere, we have to show that the master inequality Eq. (311) holds:

$$
\displaystyle M^{2}(1\ -\ \cos(\alpha_{\min}))\
$$
 
$$
\displaystyle\geq\ \frac{2}{\beta\ N}\ +\ \frac{1}{\beta}\ \ln\left(2\ N^{2}\ \beta\ M^{2}\right)\ .
$$

We now place the patterns equidistant on the sphere where the pattern are separated by an angle $\alpha_{\min}$:

$$
\displaystyle\forall_{i}:\ \min_{j,j\not=i}\alpha_{ij}\ =\ \alpha_{\min}\ ,
$$

In a $d$ -dimensional space we can place

$$
\displaystyle N\
$$
 
$$
\displaystyle=\ \left(\frac{2\pi}{\alpha_{\min}}\right)^{d-1}
$$

points on the sphere. In a spherical coordinate system a pattern differs from its most closest patterns by an angle $\alpha_{\min}$ and there are $d-1$ angles. Solving for $\alpha_{\min}$ gives

$$
\displaystyle\alpha_{\min}\
$$
 
$$
\displaystyle=\ \frac{2\pi}{N^{1/(d-1)}}\ .
$$

The number of patterns that can be stored is determined by the largest $N$ that fulfils

$$
\displaystyle M^{2}\left(1\ -\ \cos\left(\frac{2\pi}{N^{1/(d-1)}}\right)\right)\ \geq\ \frac{2}{\beta\ N}\ +\ \frac{1}{\beta}\ \ln\left(2\ N^{2}\ \beta\ M^{2}\right)\ .
$$

We set $N=2^{2(d-1)}$ and obtain for Eq. (317):

$$
\displaystyle M^{2}\left(1\ -\ \cos\left(\frac{\pi}{2}\right)\right)\ \geq\ \frac{2}{\beta\ 2^{3(d-1)}}\ +\ \frac{1}{\beta}\ \ln\left(2\ \beta\ M^{2}\right)\ +\ \frac{1}{\beta}\ 4\ (d-1)\ln 2\ .
$$

This inequality is equivalent to

$$
\displaystyle\beta\ M^{2}\ \geq\ \frac{1}{2^{2(d-1)-1}}\ +\ \ln\left(2\ \beta\ M^{2}\right)\ +\ 4\ (d-1)\ln 2\ .
$$

The last inequality can be fulfilled with $M=K\sqrt{d-1}$ and proper $K$. For $\beta=1$, $d=4$ and $K=2$ the inequality is fulfilled. The left hand side minus the right hand side is $4(d-1)-1/2^{2(d-1)-1}-\ln(8(d-1))-4(d-1)\ln 2$. Its derivative with respect to $d$ is strict positive. Therefore, the inequality holds for $d\geq 4$.

For $\beta=1$, $d=50$ and $K=1.7$ the inequality is fulfilled. The left hand side minus the right hand side is $2.89(d-1)-1/2^{2(d-1)-1}-\ln(5.78(d-1))-4(d-1)\ln 2$. Its derivative with respect to $d$ is strict positive. Therefore, the inequality holds for $d\geq 50$.

∎

If we want to store considerably more patterns, then we have to increase the length of the vectors or the dimension of the space where the vectors live. The next theorem shows results for the number of patterns $N$ with $N=2^{3(d-1)}$.

###### Theorem A4 (Storage Capacity (M=5): Placed Patterns).

We assume $\beta=1$ and patterns on the sphere with radius $M$. If $M=5\sqrt{d-1}$ and the dimension $d$ of the space is $d\geq 3$ or if $M=4\sqrt{d-1}$ and the dimension $d$ of the space is $d\geq 13$, then the number of patterns $N$ that can be stored (fixed point with attraction basin near pattern) is at least

$$
\displaystyle N\
$$
 
$$
\displaystyle=\ 2^{3(d-1)}\ .
$$

###### Proof.

We set $N=2^{3(d-1)}$ and obtain for Eq. (317):

$$
\displaystyle M^{2}\left(1\ -\ \cos\left(\frac{\pi}{4}\right)\right)\ \geq\ \frac{2}{\beta\ 2^{3(d-1)}}\ +\ \frac{1}{\beta}\ \ln\left(2\ \beta\ M^{2}\right)\ +\ \frac{1}{\beta}\ 6\ (d-1)\ln 2\ .
$$

This inequality is equivalent to

$$
\displaystyle\beta\ M^{2}\left(1\ -\ \frac{\sqrt{2}}{2}\right)\ \geq\ \frac{1}{2^{3(d-1)-1}}\ +\ \ln\left(2\ \beta\ M^{2}\right)\ +\ 6\ (d-1)\ln 2\ .
$$

The last inequality can be fulfilled with $M=K\sqrt{d-1}$ and proper $K$. For $\beta=1$, $d=13$ and $K=4$ the inequality is fulfilled. The left hand side minus the right hand side is $4.686292(d-1)-1/2^{3(d-1)-1}-\ln(32(d-1))-6(d-1)\ln 2$. Its derivative with respect to $d$ is strict positive. Therefore, the inequality holds for $d\geq 13$.

For $\beta=1$, $d=3$ and $K=5$ the inequality is fulfilled. The left hand side minus the right hand side is $7.32233(d-1)-1/2^{3(d-1)-1}-\ln(50(d-1))-6(d-1)\ln 2$. Its derivative with respect to $d$ is strict positive. Therefore, the inequality holds for $d\geq 3$.

∎

•Storage capacity for random patterns on the sphere.

Next we investigate random points on the sphere. Under assumption Eq. (305) we have to show that the master inequality Eq. (311) is fulfilled for $\alpha_{\min}$, where now $\alpha_{\min}$ is now a random variable. We use results on the distribution of the minimal angles between random patterns on a sphere according to [^16] and [^13]. Theorem 2 in [^16] gives the distribution of the minimal angle for random patterns on the unit sphere. Proposition 3.5 in [^13] gives a lower bound on the probability of the minimal angle being larger than a given constant. We require this proposition to derive the probability of pattern having a minimal angle $\alpha_{\min}$. Proposition 3.6 in [^13] gives the expectation of the minimal angle.

We will prove high probability bounds for the expected storage capacity. We need the following tail-bound on $\alpha_{\min}$ (the minimal angle of random patterns on a sphere):

###### Lemma A13 ().

Let $d$ be the dimension of the pattern space,

$$
\displaystyle\kappa_{d}\
$$
 
$$
\displaystyle:=\ \frac{1}{d\ \sqrt{\pi}}\ \frac{\Gamma((d+1)/2)}{\Gamma(d/2)}\ .
$$

and $\delta>0$ such that $\frac{\kappa_{d-1}}{2}\delta^{(d-1)}\leqslant 1$. Then

$$
\displaystyle\mathbf{\mathrm{Pr}}(N^{\frac{2}{d-1}}\alpha_{\min}\ \geq\ \delta)\
$$
 
$$
\displaystyle\geq\ 1\ -\ \frac{\kappa_{d-1}}{2}\ \delta^{d-1}\ .
$$

###### Proof.

The statement of the lemma is Eq. (3-6) from Proposition 3.5 in [^13]. ∎

Next we derive upper and lower bounds on the constant $\kappa_{d}$ since we require them later for proving storage capacity bounds.

###### Lemma A14.

For $\kappa_{d}$ defined in Eq. (323) we have the following bounds for every $d\geq 1$:

$$
\displaystyle\frac{1}{\exp(1/6)\ \sqrt{e\ \pi\ d}}\
$$
 
$$
\displaystyle\leqslant\ \kappa_{d}\ \leqslant\ \frac{\exp(1/12)}{\sqrt{2\ \pi\ d}}\ <\ 1\ .
$$

###### Proof.

We use for $x>0$ the following bound related to Stirling’s approximation formula for the gamma function, c.f. [^72]:

$$
\displaystyle 1\
$$
 
$$
\displaystyle<\ \Gamma(x)\ (2\ \pi)^{-\ \frac{1}{2}}x^{\frac{1}{2}\ -\ x}\exp(x)\ <\ \exp\left(\frac{1}{12\ x}\right)\ .
$$

Using Stirling’s formula Eq. (326), we upper bound $\kappa_{d}$:

$$
\displaystyle\kappa_{d}\ =\ \frac{1}{d\ \sqrt{\pi}}\ \frac{\Gamma((d+1)/2)}{\Gamma(d/2)}\ <\ \frac{1}{d\ \sqrt{\pi}}\ \frac{\exp\left(\frac{1}{6(d+1)}\right)\ \exp\left(-\ \frac{d+1}{2}\right)\ \left(\frac{d+1}{2}\right)^{\frac{d}{2}}}{\exp\left(-\ \frac{d}{2}\right)\ \left(\frac{d}{2}\right)^{\frac{d}{2}\ -\ \frac{1}{2}}}
$$
 
$$
\displaystyle=\ \frac{1}{d\ \sqrt{\pi\ e}}\ \exp\left(\frac{1}{6(d+1)}\right)\ \left(1\ +\ \frac{1}{d}\right)^{\frac{d}{2}}\sqrt{\frac{d}{2}}\ \leqslant\ \frac{\exp\left(\frac{1}{12}\right)}{\sqrt{2\ \pi}\ \sqrt{d}}\ .
$$

For the first inequality, we applied Eq. (326), while for the second we used $(1+\frac{1}{d})^{d}<e$ for $d\geq 1$.

Next, we lower bound $\kappa_{d}$ by again applying Stirling’s formula Eq. (326):

$$
\displaystyle\kappa_{d}\ =\ \frac{1}{d\ \sqrt{\pi}}\ \frac{\Gamma((d+1)/2)}{\Gamma(d/2)}\ >\ \frac{1}{d\ \sqrt{\pi}}\ \frac{\exp\left(-\ \frac{d+1}{2}\right)\ \left(\frac{d+1}{2}\right)^{\frac{d}{2}}}{\exp\left(\frac{1}{6\ d}\right)\ \exp\left(-\frac{d}{2}\right)\ \left(\frac{d}{2}\right)^{\frac{d}{2}-\frac{1}{2}}}
$$
 
$$
\displaystyle=\ \frac{1}{d\ \sqrt{\pi\ e}\ \exp\left(\frac{1}{6\ d}\right)}\ \left(1+\frac{1}{d}\right)^{\frac{d}{2}}\sqrt{\frac{d}{2}}\ \geq\ \frac{1}{\exp\left(\frac{1}{6}\right)\ \sqrt{e\ \pi\ d}}\ ,
$$

where the last inequality holds because of monotonicity of $(1+\frac{1}{d})^{d}$ and using the fact that for $d=1$ it takes on the value 2. ∎

We require a bound on $\cos$ to bound the master inequality Eq. (311).

###### Lemma A15.

For $0\leqslant x\leqslant\pi$ the function $\cos$ can be upper bounded by:

$$
\displaystyle\cos(x)\
$$
 
$$
\displaystyle\leqslant\ 1\ -\ \frac{x^{2}}{5}\ .
$$

###### Proof.

We use the infinite product representation of $\cos$, c.f. [^72]:

$$
\displaystyle\cos(x)\
$$
 
$$
\displaystyle=\ \prod_{n=1}^{\infty}\left(1-\frac{4\ x^{2}}{(2n-1)^{2}\ \pi^{2}}\right)\ .
$$

Since it holds that

$$
\displaystyle 1\ -\ \frac{4\ x^{2}}{(2n-1)^{2}\ \pi^{2}}\ \leqslant\ 1
$$

for $|x|\leqslant\pi$ and $n\geq 2$, we can get the following upper bound on Eq. (330):

$$
\displaystyle\cos(x)\
$$
 
$$
\displaystyle\leqslant\ \prod_{n=1}^{2}\left(1-\frac{4\ x^{2}}{(2n-1)^{2}\pi^{2}}\right)\ =\ \left(1\ -\ \frac{4\ x^{2}}{\pi^{2}}\right)\ \left(1\ -\ \frac{4\ x^{2}}{9\ \pi^{2}}\right)
$$
 
$$
\displaystyle=\ 1\ -\ \frac{40\ x^{2}}{9\ \pi^{2}}\ +\ \frac{16\ x^{4}}{9\ \pi^{4}}\ \leqslant\ 1\ -\ \frac{40\ x^{2}}{9\ \pi^{2}}\ +\ \frac{16\ x^{2}}{9\ \pi^{2}}
$$
 
$$
\displaystyle=\ 1\ -\ \frac{24\ x^{2}}{9\ \pi^{2}}\ \leqslant\ 1\ -\ \frac{x^{2}}{5}\ .
$$

The last but one inequality uses $x\leqslant\pi$, which implies $x/\pi\leqslant 1$. Thus Eq. (329) is proven.

∎

•Exponential storage capacity: the base $c$ as a function of the parameter $\beta$, the radius of the sphere $M$, the probability $p$, and the dimension $d$ of the space.

We express the number $N$ of stored patterns by an exponential function with base $c>1$ and an exponent linear in $d$. We derive constraints on he base $c$ as a function of $\beta$, the radius of the sphere $M$, the probability $p$ that all patterns can be stored, and the dimension $d$ of the space. With $\beta>0$, $K>0$, and $d\geq 2$ (to ensure a sphere), the following theorem gives our main result.

###### Theorem A5 (Storage Capacity (Main): Random Patterns).

We assume a failure probability $0<p\leqslant 1$ and randomly chosen patterns on the sphere with radius $M:=K\sqrt{d-1}$. We define

$$
\displaystyle a\
$$
 
$$
\displaystyle:=\ \frac{2}{d-1}\ (1\ +\ \ln(2\ \beta\ K^{2}\ p\ (d-1)))\ ,\quad b\ :=\ \frac{2\ K^{2}\ \beta}{5}\ ,
$$
$$
\displaystyle c\
$$
 
$$
\displaystyle:=\ \frac{b}{W_{0}(\exp(a\ +\ \ln(b))}\ ,
$$

where $W_{0}$ is the upper branch of the Lambert $W$ function [^72] and ensure

$$
\displaystyle c\
$$
 
$$
\displaystyle\geq\ \left(\frac{2}{\sqrt{p}}\right)^{\frac{4}{d-1}}\ .
$$

Then with probability $1-p$, the number of random patterns that can be stored is

$$
\displaystyle N\
$$
 
$$
\displaystyle\geq\ \sqrt{p}\ c^{\frac{d-1}{4}}\ .
$$

Therefore it is proven for $c\geq 3.1546$ with $\beta=1$, $K=3$, $d=20$ and $p=0.001$ ($a+\ln(b)>1.27$) and proven for $c\geq 1.3718$ with $\beta=1$, $K=1$, $d=75$, and $p=0.001$ ($a+\ln(b)<-0.94$).

###### Proof.

We consider the probability that the master inequality Eq. (311) is fulfilled:

$$
\displaystyle\mathbf{\mathrm{Pr}}\left(M^{2}(1\ -\cos(\alpha_{\min})))\ \geq\ \frac{2}{\beta\ N}\ +\ \frac{1}{\beta}\ \ln\left(2\ N^{2}\ \beta\ M^{2}\right)\right)\ \geq\ 1\ -\ p\ .
$$

Using Eq. (329), we have:

$$
\displaystyle 1\ -\ \cos(\alpha_{\min})\
$$
 
$$
\displaystyle\geq\ \frac{1}{5}\ \alpha_{\min}^{2}\ .
$$

Therefore, with probability $1-p$ the storage capacity is largest $N$ that fulfills

$$
\displaystyle\mathbf{\mathrm{Pr}}\left(M^{2}\frac{\alpha_{min}^{2}}{5}\ \geq\ \frac{2}{\beta\ N}\ +\ \frac{1}{\beta}\ \ln\left(2\ N^{2}\ \beta\ M^{2}\right)\right)\ \geq\ 1\ -\ p\ .
$$

This inequality is equivalent to

$$
\displaystyle\mathbf{\mathrm{Pr}}\left(N^{\frac{2}{d-1}}\ \alpha_{min}\ \geq\ \frac{\sqrt{5}\ N^{\frac{2}{d-1}}}{M}\ \left(\frac{2}{\beta\ N}\ +\ \frac{1}{\beta}\ \ln\left(2\ N^{2}\ \beta\ M^{2}\right)\right)^{\frac{1}{2}}\right)\ \geq\ 1\ -\ p\ .
$$

We use Eq. (324) to obtain:

$$
\displaystyle\mathbf{\mathrm{Pr}}\left(N^{\frac{2}{d-1}}\ \alpha_{min}\ \geq\ \frac{\sqrt{5}\ N^{\frac{2}{d-1}}}{M}\ \left(\frac{2}{\beta\ N}\ +\ \frac{1}{\beta}\ \ln\left(2\ N^{2}\ \beta\ M^{2}\right)\right)^{\frac{1}{2}}\right)
$$
 
$$
\displaystyle\geq\ 1\ -\ \frac{\kappa_{d-1}}{2}\ 5^{\frac{d-1}{2}}\ N^{2}\ M^{-(d-1)}\left(\frac{2}{\beta\ N}\ +\ \frac{1}{\beta}\ \ln\left(2\ N^{2}\ \beta\ M^{2}\right)\right)^{\frac{d-1}{2}}\ .
$$

For Eq. (339) to be fulfilled, it is sufficient that

$$
\displaystyle\frac{\kappa_{d-1}}{2}\ 5^{\frac{d-1}{2}}\ N^{2}\ M^{-(d-1)}\left(\frac{2}{\beta\ N}\ +\ \frac{1}{\beta}\ \ln\left(2\ N^{2}\ \beta M^{2}\right)\right)^{\frac{d-1}{2}}\ -\ p\ \leqslant\ 0\ .
$$

If we insert the assumption Eq. (334) of the theorem into Eq. (335), then we obtain $N\geq 2$. We now apply the upper bound $\kappa_{d-1}/2<\kappa_{d-1}<1$ from Eq. (325) and the upper bound $\frac{2}{\beta N}\leqslant\frac{1}{\beta}$ from $N\geq 2$ to inequality Eq. (341). In the resulting inequality we insert $N=\sqrt{p}c^{\frac{d-1}{4}}$ to check whether it is fulfilled with this special value of $N$ and obtain:

$$
\displaystyle 5^{\frac{d-1}{2}}\ p\ c^{\frac{d-1}{2}}\ M^{-(d-1)}\left(\frac{1}{\beta}\ +\ \frac{1}{\beta}\ \ln\left(2\ p\ c^{\frac{d-1}{2}}\ \beta M^{2}\right)\right)^{\frac{d-1}{2}}\leqslant\ p\ .
$$

Dividing by $p$, inserting $M=K\sqrt{d-1}$, and exponentiation of the left and right side by $\frac{2}{d-1}$ gives:

$$
\displaystyle\frac{5\ c}{K^{2}\ (d-1)}\left(\frac{1}{\beta}\ +\ \frac{1}{\beta}\ \ln\left(2\ \beta\ c^{\frac{d-1}{2}}\ p\ K^{2}\ (d-1)\right)\right)\ -\ 1\ \leqslant\ 0\ .
$$

After some algebraic manipulation, this inequality can be written as

$$
\displaystyle a\ c\ +\ c\ \ln(c)\ -\ b\ \leqslant\ 0\ ,
$$

where we used

$$
\displaystyle a\
$$
 
$$
\displaystyle:=\ \frac{2}{d-1}\ (1\ +\ \ln(2\ \beta\ K^{2}\ p\ (d-1)))\ ,\quad b\ :=\ \frac{2\ K^{2}\ \beta}{5}\ .
$$

We determine the value $\hat{c}$ of $c$ which makes the inequality Eq. (344) equal to zero. We solve

$$
\displaystyle a\ \hat{c}\ +\ \hat{c}\ \ln(\hat{c})\ -\ b\ =\ 0
$$

for $\hat{c}$:

$$
\displaystyle a\ \hat{c}\ +\ \hat{c}\ \ln(\hat{c})\ -\ b\ =\ 0
$$
 
$$
\displaystyle\Leftrightarrow\ \
$$
 
$$
\displaystyle a\ +\ \ln(\hat{c})\ =\ b/\hat{c}
$$
 
$$
\displaystyle\Leftrightarrow\ \
$$
 
$$
\displaystyle a\ +\ \ln(b)\ +\ \ln(\hat{c}/b)\ =\ b/\hat{c}
$$
 
$$
\displaystyle\Leftrightarrow\ \
$$
 
$$
\displaystyle b/\hat{c}\ +\ \ln(b/\hat{c})\ =\ a\ +\ \ln(b)
$$
 
$$
\displaystyle\Leftrightarrow\ \
$$
 
$$
\displaystyle b/\hat{c}\ \exp(b/\hat{c})\ =\ \exp(a\ +\ \ln(b))
$$
 
$$
\displaystyle\Leftrightarrow\ \
$$
 
$$
\displaystyle b/\hat{c}\ =\ W_{0}(\exp(a\ +\ \ln(b)))
$$
 
$$
\displaystyle\Leftrightarrow\ \
$$
 
$$
\displaystyle\hat{c}\ =\ \frac{b}{W_{0}(\exp(a\ +\ \ln(b))}\ ,
$$

where $W_{0}$ is the upper branch of the Lambert $W$ function (see Def. A6). Hence, the solution is

$$
\displaystyle\hat{c}\
$$
 
$$
\displaystyle=\ \frac{b}{W_{0}(\exp(a\ +\ \ln(b))}\ .
$$

The solution exist, since the Lambert function $W_{0}(x)$ [^72] is defined for $-1/e<x$ and we have $0<\exp(a+\ln(b)$.

Since $\hat{c}$ fulfills inequality Eq. (344) and therefore also Eq. (342), we have a lower bound on the storage capacity $N$:

$$
\displaystyle N\
$$
 
$$
\displaystyle\geq\ \sqrt{p}\ \hat{c}^{\frac{d-1}{4}}\ .
$$

∎

Next we aim at a lower bound on $c$ which does not use the Lambert $W$ function [^72]. Therefore, we upper bound $W_{0}(\exp(a+\ln(b))$ to obtain a lower bound on $c$, therefore, also a lower bound on the storage capacity $N$. The lower bound is given in the next corollary.

###### Corollary A1.

We assume a failure probability $0<p\leqslant 1$ and randomly chosen patterns on the sphere with radius $M=K\sqrt{d-1}$. We define

$$
\displaystyle a\
$$
 
$$
\displaystyle:=\ \frac{2}{d-1}\ (1\ +\ \ln(2\ \beta\ K^{2}\ p\ (d-1)))\ ,\quad b\ :=\ \frac{2\ K^{2}\ \beta}{5}\ .
$$

Using the omega constant $\Omega\approx 0.56714329$ we set

$$
\displaystyle c\
$$
 
$$
\displaystyle=\ \begin{cases}b\ \ln\left(\frac{\Omega\ \exp(a\ +\ \ln(b))\ +\ 1}{\Omega\ (1\ +\ \Omega)}\right)^{-1}&\text{for }\ a\ +\ \ln(b)\ \leqslant\ 0\ ,\\
b\ (a\ +\ \ln(b))^{-\frac{a\ +\ \ln(b)}{a\ +\ \ln(b)\ +\ 1}}&\text{for }\ a\ +\ \ln(b)\ >\ 0\end{cases}
$$

and ensure

$$
\displaystyle c\
$$
 
$$
\displaystyle\geq\ \left(\frac{2}{\sqrt{p}}\right)^{\frac{4}{d-1}}\ .
$$

Then with probability $1-p$, the number of random patterns that can be stored is

$$
\displaystyle N\
$$
 
$$
\displaystyle\geq\ \sqrt{p}\ c^{\frac{d-1}{4}}\ .
$$

Examples are $c\geq 3.1444$ for $\beta=1$, $K=3$, $d=20$ and $p=0.001$ ($a+\ln(b)>1.27$) and $c\geq 1.2585$ for $\beta=1$ $K=1$, $d=75$, and $p=0.001$ ($a+\ln(b)<-0.94$).

###### Proof.

We lower bound the $c$ defined in Theorem A5. According to [^46] we have for any real $u$ and $y>\frac{1}{e}$:

$$
\displaystyle W_{0}(\exp(u))\
$$
 
$$
\displaystyle\leqslant\ \ln\left(\frac{\exp(u)\ +\ y}{1\ +\ \ln(y)}\right)\ .
$$

To upper bound $W_{0}(x)$ for $x\in[0,1]$, we set

$$
\displaystyle y\
$$
 
$$
\displaystyle=\ 1/W_{0}(1)\ =\ 1/\Omega\ =\ \exp{\Omega}\ =\ -\ 1/\ln\Omega\ \approx\ 1.76322\ ,
$$

where the Omega constant $\Omega$ is

$$
\displaystyle\Omega\
$$
 
$$
\displaystyle=\ \left(\int_{-\infty}^{\infty}\frac{\mathrm{d}t}{\left(e^{t}\ -\ t\right)^{2}\ +\ \pi^{2}}\right)^{-1}\ -\ 1\ \approx\ 0.56714329\ .
$$

See for these equations the special values of the Lambert $W$ function in Lemma A31. We have the upper bound on $W_{0}$:

$$
\displaystyle W_{0}(\exp(u))\
$$
 
$$
\displaystyle\leqslant\ \ln\left(\frac{\exp(u)\ +\ 1/\Omega}{1\ +\ \ln(1/\Omega)}\right)\ =\ \ln\left(\frac{\Omega\ \exp(u)\ +\ 1}{\Omega(1\ +\ \Omega)}\right)\ .
$$

At the right hand side of interval $[0,1]$, we have $u=0$ and $\exp(u)=1$ and get:

$$
\displaystyle\ln\left(\frac{\Omega\ 1\ +\ 1}{\Omega(1\ +\ \Omega)}\right)\ =\ \ln\left(\frac{1}{\Omega}\right)\ =\ -\ \ln\left(\Omega\right)\ =\ \Omega\ =\ W_{0}(1)\ .
$$

Therefore, the bound is tight at the right hand side of of interval $[0,1]$, that is for $\exp(u)=1$, i.e. $u=0$. We have derived an bound for $W_{0}(\exp(u))$ with $\exp(u)\in[0,1]$ or, equivalently, $u\in[-\infty,0]$. We obtain from [^46] the following bound on $W_{0}(\exp(u))$ for $1<\exp(u)$, or, equivalently $0<u$:

$$
\displaystyle W_{0}(\exp(u))\
$$
 
$$
\displaystyle\leqslant\ u^{\frac{u}{1\ +\ u}}\ .
$$

A lower bound on $\hat{c}$ is obtained via the upper bounds Eq. (357) and Eq. (355) on $W_{0}$ as $W_{0}>0$. We set $u=a+\ln(b)$ and obtain

$$
\displaystyle W_{0}(\exp(a\ +\ \ln(b)))\
$$
 
$$
\displaystyle\leqslant\ \begin{cases}\ln\left(\frac{\Omega\ \exp(a\ +\ \ln(b))\ +\ 1}{\Omega\ (1\ +\ \Omega)}\right)^{-1}&\text{for }\ a\ +\ \ln(b)\ \leqslant\ 0\ ,\\
(a\ +\ \ln(b))^{-\frac{a\ +\ \ln(b)}{a\ +\ \ln(b)\ +\ 1}}&\text{for }\ a\ +\ \ln(b)\ >\ 0\end{cases}
$$

We insert this bound into Eq. (347), the solution for $\hat{c}$, to obtain the statement of the theorem.

∎

•Exponential storage capacity: the dimension $d$ of the space as a function of the parameter $\beta$, the radius of the sphere $M$, and the probability $p$.

We express the number $N$ of stored patterns by an exponential function with base $c>1$ and an exponent linear in $d$. We derive constraints on the dimension $d$ of the space as a function of $\beta$, the radius of the sphere $M$, the probability $p$ that all patterns can be stored, and the base of the exponential storage capacity. The following theorem gives this result.

###### Theorem A6 (Storage Capacity (d computed): Random Patterns).

We assume a failure probability $0<p\leqslant 1$ and randomly chosen patterns on the sphere with radius $M=K\sqrt{d-1}$. We define

$$
\displaystyle a\
$$
 
$$
\displaystyle:=\ \frac{\ln(c)}{2}\ -\ \frac{K^{2}\ \beta}{5\ c}\ ,\quad b\ :=\ 1\ +\ \ln\left(2\ p\ \beta\ K^{2}\right)\ ,
$$
$$
\displaystyle d\
$$
 
$$
\displaystyle=\ \begin{cases}1\ +\ \frac{1}{a}\ W(a\ \exp(-b))&\text{for }a\not=0\ ,\\
1\ +\ \exp(-b)&\text{for }a=0\ ,\end{cases}
$$

where $W$ is the Lambert $W$ function [^72]. For $0<a$ the function $W$ is the upper branch $W_{0}$ and for $a<0$ we use the lower branch $W_{-1}$. If we ensure that

$$
\displaystyle c\
$$
 
$$
\displaystyle\geq\ \left(\frac{2}{\sqrt{p}}\right)^{\frac{4}{d-1}}\ ,\quad\ -\ \frac{1}{e}\ \leqslant\ a\ \exp(-b)\ ,
$$

then with probability $1-p$, the number of random patterns that can be stored is

$$
\displaystyle N\
$$
 
$$
\displaystyle\geq\ \sqrt{p}\ c^{\frac{d-1}{4}}\ .
$$

###### Proof.

We consider the probability that the master inequality Eq. (311) is fulfilled:

$$
\displaystyle\mathbf{\mathrm{Pr}}\left(M^{2}(1\ -\cos(\alpha_{\min})))\ \geq\ \frac{2}{\beta\ N}\ +\ \frac{1}{\beta}\ \ln\left(2\ N^{2}\ \beta\ M^{2}\right)\right)\ \geq\ 1\ -\ p\ .
$$

Using Eq. (329), we have:

$$
\displaystyle 1\ -\ \cos(\alpha_{\min})\
$$
 
$$
\displaystyle\geq\ \frac{1}{5}\ \alpha_{\min}^{2}\ .
$$

Therefore, with probability $1-p$ the storage capacity is largest $N$ that fulfills

$$
\displaystyle\mathbf{\mathrm{Pr}}\left(M^{2}\frac{\alpha_{min}^{2}}{5}\ \geq\ \frac{2}{\beta\ N}\ +\ \frac{1}{\beta}\ \ln\left(2\ N^{2}\ \beta\ M^{2}\right)\right)\ \geq\ 1\ -\ p\ .
$$

This inequality is equivalent to

$$
\displaystyle\mathbf{\mathrm{Pr}}\left(N^{\frac{2}{d-1}}\ \alpha_{min}\ \geq\ \frac{\sqrt{5}\ N^{\frac{2}{d-1}}}{M}\ \left(\frac{2}{\beta\ N}\ +\ \frac{1}{\beta}\ \ln\left(2\ N^{2}\ \beta\ M^{2}\right)\right)^{\frac{1}{2}}\right)\ \geq\ 1\ -\ p\ .
$$

We use Eq. (324) to obtain:

$$
\displaystyle\mathbf{\mathrm{Pr}}\left(N^{\frac{2}{d-1}}\ \alpha_{min}\ \geq\ \frac{\sqrt{5}\ N^{\frac{2}{d-1}}}{M}\ \left(\frac{2}{\beta\ N}\ +\ \frac{1}{\beta}\ \ln\left(2\ N^{2}\ \beta\ M^{2}\right)\right)^{\frac{1}{2}}\right)
$$
 
$$
\displaystyle\geq\ 1\ -\ \frac{\kappa_{d-1}}{2}\ 5^{\frac{d-1}{2}}\ N^{2}\ M^{-(d-1)}\left(\frac{2}{\beta\ N}\ +\ \frac{1}{\beta}\ \ln\left(2\ N^{2}\ \beta\ M^{2}\right)\right)^{\frac{d-1}{2}}\ .
$$

For Eq. (365) to be fulfilled, it is sufficient that

$$
\displaystyle\frac{\kappa_{d-1}}{2}\ 5^{\frac{d-1}{2}}\ N^{2}\ M^{-(d-1)}\left(\frac{2}{\beta\ N}\ +\ \frac{1}{\beta}\ \ln\left(2\ N^{2}\ \beta M^{2}\right)\right)^{\frac{d-1}{2}}\ -\ p\ \leqslant\ 0\ .
$$

If we insert the assumption Eq. (360) of the theorem into Eq. (361), then we obtain $N\geq 2$. We now apply the upper bound $\kappa_{d-1}/2<\kappa_{d-1}<1$ from Eq. (325) and the upper bound $\frac{2}{\beta N}\leqslant\frac{1}{\beta}$ from $N\geq 2$ to inequality Eq. (367). In the resulting inequality we insert $N=\sqrt{p}c^{\frac{d-1}{4}}$ to check whether it is fulfilled with this special value of $N$ and obtain:

$$
\displaystyle 5^{\frac{d-1}{2}}\ p\ c^{\frac{d-1}{2}}\ M^{-(d-1)}\left(\frac{1}{\beta}\ +\ \frac{1}{\beta}\ \ln\left(2\ p\ c^{\frac{d-1}{2}}\ \beta M^{2}\right)\right)^{\frac{d-1}{2}}\leqslant\ p\ .
$$

Dividing by $p$, inserting $M=K\sqrt{d-1}$, and exponentiation of the left and right side by $\frac{2}{d-1}$ gives:

$$
\displaystyle\frac{5\ c}{K^{2}\ (d-1)}\left(\frac{1}{\beta}\ +\ \frac{1}{\beta}\ \ln\left(2\ \beta\ c^{\frac{d-1}{2}}\ p\ K^{2}\ (d-1)\right)\right)\ -\ 1\ \leqslant\ 0\ .
$$

This inequality Eq. (369) can be reformulated as:

$$
\displaystyle 1\ +\ \ln\left(2\ p\ \beta\ c^{\frac{d-1}{2}}\ K^{2}\ (d-1)\right)\ -\ \frac{(d-1)\ K^{2}\ \beta}{5\ c}\ \leqslant\ 0\ .
$$

Using

$$
\displaystyle a\
$$
 
$$
\displaystyle:=\ \frac{\ln(c)}{2}\ -\ \frac{K^{2}\ \beta}{5\ c}\ ,\quad b\ :=\ 1\ +\ \ln\left(2\ p\ \beta\ K^{2}\right)\ ,
$$

we write inequality Eq. (370) as

$$
\displaystyle\ln(d-1)\ +\ a\ (d-1)\ +\ b\ \leqslant\ 0\ .
$$

We determine the value $\hat{d}$ of $d$ which makes the inequality Eq. (372) equal to zero. We solve

$$
\displaystyle\ln(\hat{d}-1)\ +\ a\ (\hat{d}-1)\ +\ b\ =\ 0\ .
$$

for $\hat{d}$

For $a\not=0$ we have

$$
\displaystyle\ln(\hat{d}-1)\ +\ a\ (\hat{d}-1)\ +\ b\ =\ 0
$$
 
$$
\displaystyle\Leftrightarrow\ \
$$
 
$$
\displaystyle a\ (\hat{d}-1)\ +\ \ln(\hat{d}-1)\ =\ -\ b
$$
 
$$
\displaystyle\Leftrightarrow\ \
$$
 
$$
\displaystyle(\hat{d}-1)\exp(a\ (\hat{d}-1))\ =\ \exp(-b)
$$
 
$$
\displaystyle\Leftrightarrow\ \
$$
 
$$
\displaystyle a\ (\hat{d}-1)\exp(a\ (\hat{d}-1))\ =\ a\ \exp(-b)
$$
 
$$
\displaystyle\Leftrightarrow\ \
$$
 
$$
\displaystyle a\ (\hat{d}-1)\ =\ W(a\ \exp(-b))
$$
 
$$
\displaystyle\Leftrightarrow\ \
$$
 
$$
\displaystyle\hat{d}\ -\ 1\ =\ \frac{1}{a}\ W(a\ \exp(-b))
$$
 
$$
\displaystyle\Leftrightarrow\ \
$$
 
$$
\displaystyle\hat{d}\ =\ 1\ +\ \frac{1}{a}\ W(a\ \exp(-b))\ ,
$$

where $W$ is the Lambert $W$ function (see Def. A6). For $a>0$ we have to use the upper branch $W_{0}$ of the Lambert $W$ function and for $a<0$ we use the lower branch $W_{-1}$ of the Lambert $W$ function [^72]. We have to ensure that $-1/e\leqslant a\exp(-b)$ for a solution to exist. For $a=0$ we have $\hat{d}=1+\exp(-b)$.

Hence, the solution is

$$
\displaystyle\hat{d}\
$$
 
$$
\displaystyle=\ 1\ +\ \frac{1}{a}\ W(a\exp(-b))\ .
$$

Since $\hat{d}$ fulfills inequality Eq. (369) and therefore also Eq. (368), we have a lower bound on the storage capacity $N$:

$$
\displaystyle N\
$$
 
$$
\displaystyle\geq\ \sqrt{p}\ \hat{c}^{\frac{d-1}{4}}\ .
$$

∎

###### Corollary A2.

We assume a failure probability $0<p\leqslant 1$ and randomly chosen patterns on the sphere with radius $M=K\sqrt{d-1}$. We define

$$
\displaystyle a\
$$
 
$$
\displaystyle:=\ \frac{\ln(c)}{2}\ -\ \frac{K^{2}\ \beta}{5\ c}\ ,\quad b\ :=\ 1\ +\ \ln\left(2\ p\ \beta\ K^{2}\right)\ ,
$$
$$
\displaystyle d\
$$
 
$$
\displaystyle=\ 1\ +\ \frac{1}{a}\ \left(-\ \ln(-a)\ +\ b\right)\ ,
$$

and ensure

$$
\displaystyle c\
$$
 
$$
\displaystyle\geq\ \left(\frac{2}{\sqrt{p}}\right)^{\frac{4}{d-1}}\ ,\quad\ -\ \frac{1}{e}\ \leqslant\ a\ \exp(-b)\ ,\quad\ a\ <\ 0\ ,
$$

then with probability $1-p$, the number of random patterns that can be stored is

$$
\displaystyle N\
$$
 
$$
\displaystyle\geq\ \sqrt{p}\ c^{\frac{d-1}{4}}\ .
$$

Setting $\beta=1$, $K=3$, $c=2$ and $p=0.001$ yields $d<24$.

###### Proof.

For $a<0$ the Eq. (359) from Theorem (A6) can be written as

$$
\displaystyle d\ =\ 1\ +\ \frac{W_{-1}(a\exp(-b))}{a}\ =\ 1\ +\ \frac{W_{-1}(-\exp\left(-(-\ln(-a)+b-1)-1\right))}{a}
$$

From [^4] we get the following bound on $W_{-1}$:

$$
\displaystyle-\ \frac{e}{e-1}\ (u+1)\
$$
 
$$
\displaystyle<\ W_{-1}(-\ \exp(-u-1))\ <\ -\ (u+1)\ .
$$

for $u>0$. We apply Eq. (381) to Eq. (380) with $u=-\ln(-a)+b-1$.

Since $a<0$ we get

$$
\displaystyle d\ >\ 1\ +\ \frac{-\ln(-a)+b}{a}\ .
$$

∎

•Storage capacity for the expected minimal separation instead of the probability that all patterns can be stored. In contrast to the previous paragraph, we want to argue about the storage capacity for the expected minimal separation. Therefore, we will use the following bound on the expectation of $\alpha_{\min}$ (minimal angle), which gives also a bound on the expected of $\Delta_{\min}$ (minimal separation):

###### Lemma A16 (Proposition 3.6 in ).

We have the following lower bound on the expectation of $\alpha_{\min}$:

$$
\displaystyle\mathbf{\mathrm{E}}\left[N^{\frac{2}{d-1}}\ \alpha_{\min}\right]\
$$
 
$$
\displaystyle\geq\ \left(\frac{\Gamma(\frac{d}{2})}{2(d-1)\ \sqrt{\pi}\ \Gamma(\frac{d-1}{2})}\right)^{-\frac{1}{d-1}}\Gamma(1+\frac{1}{d-1})\ \frac{d^{-\frac{1}{d-1}}}{\Gamma(2+\frac{1}{d-1})}\ :=\ C_{d-1}.
$$

The bound is valid for all $N\geq 2$ and $d\geq 2$.

Let us start with some preliminary estimates. First of all we need some asymptotics for the constant $C_{d-1}$ in Eq. (383):

###### Lemma A17.

The following estimate holds for $d\geq 2$:

$$
\displaystyle C_{d}\
$$
 
$$
\displaystyle\geq\ 1\ -\ \frac{\ln(d+1)}{d}\ .
$$

###### Proof.

The recursion formula for the Gamma function is [^72]:

$$
\displaystyle\Gamma(x+1)\
$$
 
$$
\displaystyle=\ x\ \Gamma(x)\ .
$$

We use Eq. (325) and the fact that $d^{\frac{1}{d}}\geq 1$ for $d\geq 1$ to obtain:

$$
\displaystyle C_{d}\
$$
 
$$
\displaystyle\geq\ (2\ \sqrt{d})^{\frac{1}{d}}\Gamma(1+\frac{1}{d})\ \frac{(d+1)^{-\ \frac{1}{d}}}{\Gamma(2+\frac{1}{d})}\ =\ (2\ \sqrt{d})^{\frac{1}{d}}\frac{(d+1)^{-\ \frac{1}{d}}}{1-\frac{1}{d}}\ >\ (d+1)^{\frac{1}{d}}
$$
 
$$
\displaystyle=\ \exp(-\frac{1}{d}\ \ln(d+1))\ \geq\ 1\ -\ \frac{1}{d}\ \ln(d+1)\ ,
$$

where in the last step we used the elementary inequality $\exp(x)\geq 1+x$, which follows from the mean value theorem. ∎

The next theorem states the number of stored patterns for the expected minimal separation.

###### Theorem A7 (Storage Capacity (expected separation): Random Patterns).

We assume patterns on the sphere with radius $M=K\sqrt{d-1}$ that are randomly chosen. Then for all values $c\geq 1$ for which

$$
\displaystyle\frac{1}{5}\ (d-1)\ K^{2}\ c^{-1}(1\ -\ \frac{\ln(d-1)}{(d-1)})^{2}\
$$
 
$$
\displaystyle\geq\ \frac{2}{\beta\ c^{\frac{d-1}{4}}}\ +\ \frac{1}{\beta}\ \ln\left(2\ c^{\frac{d-1}{2}}\ \beta\ (d-1)\ K^{2}\right)
$$

holds, the number of stored patterns for the expected minimal separation is at least

$$
\displaystyle N\
$$
 
$$
\displaystyle=\ c^{\frac{d-1}{4}}\ .
$$

The inequality Eq. (387) is e.g. fulfilled with $\beta=1$, $K=3$, $c=2$ and $d\geq 17$.

###### Proof.

Instead of considering the probability that the master inequality Eq. (311) is fulfilled we now consider whether this inequality is fulfilled for the expected minimal distance. We consider the expectation of the minimal distance $\Delta_{\min}$:

$$
\displaystyle\mathbf{\mathrm{E}}[\Delta_{\min}]\
$$
 
$$
\displaystyle=\ \mathbf{\mathrm{E}}[M^{2}(1\ -\ \cos(\alpha_{\min})))]\ =\ M^{2}(1\ -\ \mathbf{\mathrm{E}}[\cos(\alpha_{\min}))])\ .
$$

For this expectation, the master inequality Eq. (311) becomes

$$
\displaystyle M^{2}(1\ -\ \mathbf{\mathrm{E}}[\cos(\alpha_{\min}))])\ \geq\ \frac{2}{\beta\ N}\ +\ \frac{1}{\beta}\ \ln\left(2\ N^{2}\ \beta\ M^{2}\right)\ .
$$

We want to find the largest $N$ that fulfills this inequality.

We apply Eq. (329) and Jensen’s inequality to deduce the following lower bound:

$$
\displaystyle 1\ -\ \mathbf{\mathrm{E}}[\cos(\alpha_{\min})]\
$$
 
$$
\displaystyle\geq\ \frac{1}{5}\ \mathbf{\mathrm{E}}\left[\alpha_{\min}^{2}\right]\ \geq\ \frac{1}{5}\ \mathbf{\mathrm{E}}[\alpha_{\min}]^{2}\ .
$$

Now we use Eq. (383) and Eq. (384) to arrive at

$$
\displaystyle\mathbf{\mathrm{E}}[\alpha_{\min}]^{2}\
$$
 
$$
\displaystyle\geq\ N^{-\frac{4}{d-1}}\ \mathbf{\mathrm{E}}[N^{\frac{2}{d-1}}\ \alpha_{\min}]^{2}\ \geq\ N^{-\frac{4}{d-1}}\ C_{d-1}^{2}\ \geq\ N^{-\frac{4}{d-1}}\ (1-\frac{\ln(d-1)}{(d-1)})^{2}\ ,
$$

for sufficiently large $d$. Thus in order to fulfill Eq. (390), it is enough to find values that satisfy Eq. (387).

∎

##### A.1.6.2 Retrieval of Patterns with One Update and Small Retrieval Error.

Retrieval of a pattern $\bm{x}_{i}$ for fixed point $\bm{x}_{i}^{*}$ and query $\bm{\xi}$ is defined via an $\epsilon$ by ${{\left\|f(\bm{\xi})\ -\ \bm{x}_{i}^{*}\right\|}}<\epsilon$, that is, the update is $\epsilon$ -close to the fixed point. The update rule retrieves a pattern with one update for well separated patterns, that is, $\Delta_{i}$ is large.

###### Theorem A8 (Pattern Retrieval with One Update).

With query $\bm{\xi}$, after one update the distance of the new point $f(\bm{\xi})$ to the fixed point $\bm{x}_{i}^{*}$ is exponentially small in the separation $\Delta_{i}$. The precise bounds using the Jacobian $\mathrm{J}=\frac{\partial f(\bm{\xi})}{\partial\bm{\xi}}$ and its value $\mathrm{J}^{m}$ in the mean value theorem are:

$$
\displaystyle{{\left\|f(\bm{\xi})\ -\ \bm{x}_{i}^{*}\right\|}}\
$$
 
$$
\displaystyle\leqslant\ {{\left\|\mathrm{J}^{m}\right\|}}_{2}\ {{\left\|\bm{\xi}\ -\ \bm{x}_{i}^{*}\right\|}}\ ,
$$
$$
\displaystyle{{\left\|\mathrm{J}^{m}\right\|}}_{2}\
$$
 
$$
\displaystyle\leqslant\ 2\ \beta\ N\ M^{2}\ (N-1)\exp(-\ \beta\ (\Delta_{i}\ -\ 2\ \max\{{{\left\|\bm{\xi}\ -\ \bm{x}_{i}\right\|}},{{\left\|\bm{x}_{i}^{*}\ -\ \bm{x}_{i}\right\|}}\}\ M))\ .
$$

For given $\epsilon$ and sufficient large $\Delta_{i}$, we have ${{\left\|f(\bm{\xi})\ -\ \bm{x}_{i}^{*}\right\|}}<\epsilon$, that is, retrieval with one update.

###### Proof.

From Eq. (180) we have

$$
\displaystyle{{\left\|\mathrm{J}^{m}\right\|}}_{2}\
$$
 
$$
\displaystyle\leqslant\ 2\ \beta\ N\ M^{2}\ (N-1)\exp(-\ \beta\ (\Delta_{i}\ -\ 2\ \max\{{{\left\|\bm{\xi}\ -\ \bm{x}_{i}\right\|}},{{\left\|\bm{x}_{i}^{*}\ -\ \bm{x}_{i}\right\|}}\}\ M))\ .
$$

After every iteration the mapped point $f(\bm{\xi})$ is closer to the fixed point $\bm{x}_{i}^{*}$ than the original point $\bm{x}_{i}$:

$$
\displaystyle{{\left\|f(\bm{\xi})\ -\ \bm{x}_{i}^{*}\right\|}}\
$$
 
$$
\displaystyle\leqslant\ {{\left\|\mathrm{J}^{m}\right\|}}_{2}\ {{\left\|\bm{\xi}\ -\ \bm{x}_{i}^{*}\right\|}}\ .
$$

For given $\epsilon$ and sufficient large $\Delta_{i}$, we have ${{\left\|f(\bm{\xi})\ -\ \bm{x}_{i}^{*}\right\|}}<\epsilon$, since ${{\left\|\mathrm{J}^{m}\right\|}}_{2}$ foes exponentially fast to zero with increasing $\Delta_{i}$. ∎

We want to estimate how large $\Delta_{i}$ is. For $\bm{x}_{i}$ we have:

$$
\displaystyle\Delta_{i}\
$$
 
$$
\displaystyle=\ \min_{j,j\not=i}\left(\bm{x}_{i}^{T}\bm{x}_{i}\ -\ \bm{x}_{i}^{T}\bm{x}_{j}\right)\ =\ \bm{x}_{i}^{T}\bm{x}_{i}\ -\ \max_{j,j\not=i}\bm{x}_{i}^{T}\bm{x}_{j}\ .
$$

To estimate how large $\Delta_{i}$ is, assume vectors $\bm{x}\in\mathbb{R}^{d}$ and $\bm{y}\in\mathbb{R}^{d}$ that have as components standard normally distributed values. The expected value of the separation of two points with normally distributed components is

$$
\displaystyle\mathbf{\mathrm{E}}\left[\bm{x}^{T}\bm{x}\ -\ \bm{x}^{T}\bm{y}\right]\
$$
 
$$
\displaystyle=\ \sum_{j=1}^{d}\mathbf{\mathrm{E}}\left[x_{j}^{2}\right]\ +\ \sum_{j=1}^{d}\mathbf{\mathrm{E}}\left[x_{j}\right]\sum_{j=1}^{d}\mathbf{\mathrm{E}}\left[y_{j}\right]\ =\ d\ .
$$

The variance of the separation of two points with normally distributed components is

$$
\displaystyle\mathbf{\mathrm{Var}}\left[\bm{x}^{T}\bm{x}\ -\ \bm{x}^{T}\bm{y}\right]\ =\ \mathbf{\mathrm{E}}\left[\left(\bm{x}^{T}\bm{x}\ -\ \bm{x}^{T}\bm{y}\right)^{2}\right]\ -\ d^{2}
$$
 
$$
\displaystyle=\ \sum_{j=1}^{d}\mathbf{\mathrm{E}}\left[x_{j}^{4}\right]\ +\ \sum_{j=1,k=1,k\not=j}^{d}\mathbf{\mathrm{E}}\left[x_{j}^{2}\right]\ \mathbf{\mathrm{E}}\left[x_{k}^{2}\right]\ \ -\ 2\ \sum_{j=1}^{d}\mathbf{\mathrm{E}}\left[x_{j}^{3}\right]\mathbf{\mathrm{E}}\left[y_{j}\right]\ -
$$
 
$$
\displaystyle 2\ \sum_{j=1,k=1,k\not=j}^{d}\mathbf{\mathrm{E}}\left[x_{j}^{2}\right]\mathbf{\mathrm{E}}\left[x_{k}\right]\mathbf{\mathrm{E}}\left[y_{k}\right]\ +\ \sum_{j=1}^{d}\mathbf{\mathrm{E}}\left[x_{j}^{2}\right]\ \mathbf{\mathrm{E}}\left[y_{j}^{2}\right]\ +
$$
 
$$
\displaystyle\sum_{j=1,k=1,k\not=j}^{d}\mathbf{\mathrm{E}}\left[x_{j}\right]\mathbf{\mathrm{E}}\left[y_{j}\right]\mathbf{\mathrm{E}}\left[x_{k}\right]\mathbf{\mathrm{E}}\left[y_{k}\right]\ -\ d^{2}
$$
 
$$
\displaystyle=3\ d\ +\ d\ (d-1)\ +\ d\ -\ d^{2}\ =\ 3\ d\ .
$$

The expected value for the separation of two random vectors gives:

$$
\displaystyle{{\left\|\mathrm{J}^{m}\right\|}}_{2}\
$$
 
$$
\displaystyle\leqslant\ 2\ \beta\ N\ M^{2}\ (N-1)\exp(-\ \beta\ (d\ -\ 2\ \max\{{{\left\|\bm{\xi}\ -\ \bm{x}_{i}\right\|}},{{\left\|\bm{x}_{i}^{*}\ -\ \bm{x}_{i}\right\|}}\}\ M))\ .
$$

For the exponential storage we set $M=2\sqrt{d-1}$. We see the Lipschitz constant ${{\left\|\mathrm{J}^{m}\right\|}}_{2}$ decreases exponentially with the dimension. Therefore, ${{\left\|f(\bm{\xi})\ -\ \bm{x}_{i}^{*}\right\|}}$ is exponentially small after just one update. Therefore, the fixed point is well retrieved after one update.

The retrieval error decreases exponentially with the separation $\Delta_{i}$.

###### Theorem A9 (Exponentially Small Retrieval Error).

The retrieval error ${{\left\|f(\bm{\xi})\ -\ \bm{x}_{i}\right\|}}$ of pattern $\bm{x}_{i}$ is bounded by

$$
\displaystyle{{\left\|f(\bm{\xi})\ -\ \bm{x}_{i}\right\|}}\
$$
 
$$
\displaystyle\leqslant\ 2\ (N-1)\ \exp(-\ \beta\ (\Delta_{i}\ -\ 2\ \max\{{{\left\|\bm{\xi}\ -\ \bm{x}_{i}\right\|}},{{\left\|\bm{x}_{i}^{*}\ -\ \bm{x}_{i}\right\|}}\}\ M))\ M
$$

and for ${{\left\|\bm{x}_{i}-\bm{x}_{i}^{*}\right\|}}\leqslant\frac{1}{2\ \beta\ M}$ together with ${{\left\|\bm{x}_{i}-\bm{\xi}\right\|}}\leqslant\frac{1}{2\ \beta\ M}$ by

$$
\displaystyle{{\left\|\bm{x}_{i}\ -\ \bm{x}_{i}^{*}\right\|}}\
$$
 
$$
\displaystyle\leqslant\ 2\ e\ (N-1)\ M\ \exp(-\ \beta\ \Delta_{i})\ .
$$

###### Proof.

We compute the retrieval error which is just ${{\left\|f(\bm{\xi})\ -\ \bm{x}_{i}\right\|}}$. From Lemma A4 we have

$$
\displaystyle{{\left\|\bm{x}_{i}\ -\ f(\bm{\xi})\right\|}}\
$$
 
$$
\displaystyle\leqslant\ 2\ \epsilon\ M\ ,
$$

From Eq. (179) we have

$$
\displaystyle\epsilon\
$$
 
$$
\displaystyle=\ (N-1)\exp(-\ \beta\ (\Delta_{i}\ -\ 2\ \max\{{{\left\|\bm{\xi}\ -\ \bm{x}_{i}\right\|}},{{\left\|\bm{x}_{i}^{*}\ -\ \bm{x}_{i}\right\|}}\}\ M))\ .
$$

For ${{\left\|\bm{x}_{i}-\bm{x}_{i}^{*}\right\|}}\leqslant\frac{1}{2\ \beta\ M}$ and ${{\left\|\bm{x}_{i}-\bm{\xi}\right\|}}\leqslant\frac{1}{2\ \beta\ M}$ Eq. (404) gives

$$
\displaystyle\epsilon\
$$
 
$$
\displaystyle\leqslant\ e\ (N-1)\ M\ \exp(-\ \beta\ \Delta_{i})\ .
$$

∎

#### A.1.7 Learning Associations

We consider three cases of learning associations, i.e. three cases of how sets are associated. (i) Non of the sets is mapped in an associative space. The raw state pattern $\bm{r}_{n}$ is the state (query) pattern $\bm{\xi}_{n}$, i.e. $\bm{\xi}_{n}=\bm{r}_{n}$, and the raw stored pattern $\bm{y}_{s}$ is the stored pattern (key), i.e. $\bm{x}_{s}=\bm{y}_{s}$. (ii) Either one of the sets is mapped to the space of the other set or an association matrix is learned. (iia) The state patterns are equal to the raw patterns, i.e. $\bm{\xi}_{n}=\bm{r}_{n}$, and raw stored patterns are mapped via $\bm{W}$ to the space of the state patterns, i.e. $\bm{x}_{s}=\bm{W}\bm{y}_{s}$. (iib) The stored patterns are equal to the raw patterns, i.e. $\bm{x}_{s}=\bm{y}_{s}$, and raw state patterns are mapped via $\bm{W}$ to the space of the stored patterns, i.e. $\bm{\xi}_{n}=\bm{W}^{T}\bm{r}_{n}$. (iic) The matrix $\bm{W}$ is an association matrix. We will compute the derivative of the new state pattern with respect to $\bm{W}$, which is valid for all sub-cases (iib)–(iic). (iii) Both set of patterns are mapped in a common associative space. A raw state pattern $\bm{r}_{n}$ is mapped by $\bm{W}_{Q}$ to a state pattern (query) $\bm{\xi}_{n}$, that is $\bm{\xi}_{n}=\bm{W}_{Q}\bm{r}_{n}$. A raw stored pattern $\bm{y}_{s}$ is mapped via $\bm{W}_{K}$ to stored pattern (key) $\bm{x}_{s}$, that is $\bm{x}_{s}=\bm{W}_{K}\bm{y}_{s}$. We will compute the derivative of the new state pattern with respect to both $\bm{W}_{Q}$ and $\bm{W}_{K}$.

##### A.1.7.1 Association of Raw Patterns – No Mapping in an Associative Space.

The sets are associated via their raw patterns, i.e. the raw state pattern $\bm{r}_{n}$ is the state (query) pattern $\bm{\xi}_{n}$, i.e. $\bm{\xi}_{n}=\bm{r}_{n}$, and raw stored pattern $\bm{y}_{s}$ is the stored pattern (key), i.e. $\bm{x}_{s}=\bm{y}_{s}$. There is no mapping in an associative space.

The update rule is

$$
\displaystyle\bm{\xi}^{\mathrm{new}}\
$$
 
$$
\displaystyle=\ \bm{X}\ \bm{p}\ ,
$$

where we used

$$
\displaystyle\bm{p}\
$$
 
$$
\displaystyle=\ \mathrm{softmax}(\beta\ \bm{X}^{T}\bm{\xi})\ .
$$

The derivative with respect to $\bm{\xi}$ is

$$
\displaystyle\frac{\partial\bm{\xi}^{\mathrm{new}}}{\partial\bm{\xi}}\
$$
 
$$
\displaystyle=\ \beta\ \bm{X}\ \left(\mathrm{diag}(\bm{p})-\bm{p}\bm{p}^{T}\right)\ \bm{X}^{T}
$$

The derivative with respect to $\bm{X}$ is

$$
\displaystyle\frac{\partial\bm{a}^{T}\bm{\xi}^{\mathrm{new}}}{\partial\bm{X}}\
$$
 
$$
\displaystyle=\ \bm{a}\ \bm{p}^{T}\ +\ \beta\ \bm{X}\ \left(\mathrm{diag}(\bm{p})-\bm{p}\bm{p}^{T}\right)\ (\bm{\xi}^{T}\bm{a})\ .
$$

These derivatives allow to apply the chain rule if a Hopfield layer is integrated into a deep neural network.

##### A.1.7.2 Learning an Association Matrix – Only One Set is Mapped in an Associative Space.

Only one of the sets $\bm{R}$ or $\bm{Y}$ is mapped in the space of the patterns of the other set. Case (a): the state patterns are equal to the raw patterns $\bm{\xi}_{n}=\bm{r}_{n}$ and raw stored patterns are mapped via $\bm{W}$ to the space of the state patterns, i.e. $\bm{x}_{s}=\bm{W}\bm{y}_{s}$. Case (b): the stored patterns are equal to the raw patterns $\bm{x}_{s}=\bm{y}_{s}$ and raw state patterns are mapped via $\bm{W}$ to the space of the stored patterns, i.e. $\bm{\xi}_{n}=\bm{W}^{T}\bm{r}_{n}$. Case (c): the matrix $\bm{W}$ associates the sets $\bm{R}$ and $\bm{Y}$. This case also includes that $\bm{W}^{T}=\bm{W}_{K}^{T}\bm{W}_{Q}$, which is treated in next subsection. The next subsection focuses on a low rank approximation of $\bm{W}$ by defining the dimension $d_{k}$ of associative space and use the matrices $\bm{W}_{K}^{T}$ and $\bm{W}_{Q}$ to define $\bm{W}$, or equivalently to map $\bm{R}$ and $\bm{Y}$ into the associative space.

From a mathematical point of view all these case are equal as they lead to the same update rule. Therefore, we consider in the following Case (a) with $\bm{x}_{s}=\bm{W}\bm{y}_{s}$ and $\bm{\xi}_{n}=\bm{r}_{n}$. Still, the following formula are valid for all three cases (a)–(c).

The update rule is

$$
\displaystyle\bm{\xi}^{\mathrm{new}}\
$$
 
$$
\displaystyle=\ \bm{W}\ \bm{Y}\ \bm{p}\ ,
$$

where we used

$$
\displaystyle\bm{p}\
$$
 
$$
\displaystyle=\ \mathrm{softmax}(\beta\ \bm{Y}^{T}\bm{W}^{T}\bm{\xi})\ .
$$

We consider the state (query) pattern $\bm{\xi}$ with result $\bm{\xi}^{\mathrm{new}}$:

$$
\displaystyle\bm{\xi}^{\mathrm{new}}\
$$
 
$$
\displaystyle=\ \bm{W}\ \bm{Y}\ \bm{p}\ =\ \bm{W}\ \bm{Y}\ \mathrm{softmax}(\beta\ \bm{Y}^{T}\bm{W}^{T}\bm{\xi})
$$

For multiple updates this update rule has to be used. However for a single update, or the last update we consider a simplified update rule.

Since new state vector $\bm{\xi}^{\mathrm{new}}$ is projected by a weight matrix $\bm{W}_{V}$ to another vector, we consider the simplified update rule:

$$
\displaystyle\bm{\xi}^{\mathrm{new}}\
$$
 
$$
\displaystyle=\ \bm{Y}\ \bm{p}\ =\ \bm{Y}\ \mathrm{softmax}(\beta\ \bm{Y}^{T}\bm{W}^{T}\bm{\xi})
$$

The derivative with respect to $\bm{W}$ is

$$
\displaystyle\frac{\partial\bm{a}^{T}\bm{\xi}^{\mathrm{new}}}{\partial\bm{W}}\
$$
 
$$
\displaystyle=\ \frac{\partial\bm{\xi}^{\mathrm{new}}}{\partial\bm{W}}\ \frac{\partial\bm{a}^{T}\bm{\xi}^{\mathrm{new}}}{\partial\bm{\xi}^{\mathrm{new}}}\ =\ \frac{\partial\bm{\xi}^{\mathrm{new}}}{\partial(\bm{W}^{T}\bm{\xi})}\ \frac{\partial(\bm{W}^{T}\bm{\xi})}{\partial\bm{W}}\ \frac{\partial\bm{a}^{T}\bm{\xi}^{\mathrm{new}}}{\partial\bm{\xi}^{\mathrm{new}}}\ .
$$
 
$$
\displaystyle\frac{\partial\bm{\xi}^{\mathrm{new}}}{\partial(\bm{W}^{T}\bm{\xi})}\
$$
 
$$
\displaystyle=\ \beta\ \bm{Y}\ \left(\mathrm{diag}(\bm{p})-\bm{p}\bm{p}^{T}\right)\ \bm{Y}^{T}
$$
 
$$
\displaystyle\frac{\partial\bm{a}^{T}\bm{\xi}^{\mathrm{new}}}{\partial\bm{\xi}^{\mathrm{new}}}\
$$
 
$$
\displaystyle=\ \bm{a}\ .
$$

We have the product of the 3-dimensional tensor $\frac{\partial(\bm{W}^{T}\bm{\xi})}{\partial\bm{W}}$ with the vector $\bm{a}$ which gives a 2-dimensional tensor, i.e. a matrix:

$$
\displaystyle\frac{\partial(\bm{W}^{T}\bm{\xi})}{\partial\bm{W}}\ \frac{\partial\bm{a}^{T}\bm{\xi}^{\mathrm{new}}}{\partial\bm{\xi}^{\mathrm{new}}}\
$$
 
$$
\displaystyle=\ \frac{\partial(\bm{W}^{T}\bm{\xi})}{\partial\bm{W}}\ \bm{a}\ =\ \bm{\xi}^{T}\bm{a}\bm{I}\ .
$$
 
$$
\displaystyle\frac{\partial\bm{a}^{T}\bm{\xi}^{\mathrm{new}}}{\partial\bm{W}}\
$$
 
$$
\displaystyle=\ \beta\ \bm{Y}\ \left(\mathrm{diag}(\bm{p})-\bm{p}\bm{p}^{T}\right)\ \bm{Y}^{T}(\bm{\xi}^{T}\bm{a})\ =\ \mathrm{J}\ (\bm{\xi}^{T}\bm{a})\ ,
$$

where $\mathrm{J}$ is the Jacobian of the update rule defined in Eq. (59).

To obtain the derivative of the full update rule Eq. (412) we have to add the term

$$
\displaystyle\bm{a}\ \bm{p}^{T}\bm{Y}^{T}
$$

and include the factor $\bm{W}$ to get

$$
\displaystyle\frac{\partial\bm{a}^{T}\bm{\xi}^{\mathrm{new}}}{\partial\bm{W}}\
$$
 
$$
\displaystyle=\ \bm{a}\ \bm{p}^{T}\bm{Y}^{T}\ +\ \beta\ \bm{W}\ \bm{Y}\ \left(\mathrm{diag}(\bm{p})-\bm{p}\bm{p}^{T}\right)\ \bm{Y}^{T}(\bm{\xi}^{T}\bm{a})
$$
 
$$
\displaystyle=\ \bm{a}\ \bm{p}^{T}\bm{Y}^{T}\ +\ \bm{W}\ \mathrm{J}\ (\bm{\xi}^{T}\bm{a})\ .
$$

##### A.1.7.3 Learning Two Association Mappings – Both Sets are Mapped in an Associative Space.

Both sets $\bm{R}$ and $\bm{Y}$ are mapped in an associative space. Every raw state pattern $\bm{r}_{n}$ is mapped via $\bm{W}_{Q}$ to a state pattern (query) $\bm{\xi}_{n}=\bm{W}_{Q}\bm{r}_{n}$. Every raw stored pattern $\bm{y}_{s}$ is mapped via $\bm{W}_{K}$ to a stored pattern (key) $\bm{x}_{s}=\bm{W}_{K}\bm{y}_{s}$. In the last subsection we considered a single matrix $\bm{W}$. For $\bm{W}^{T}=\bm{W}_{K}^{T}\bm{W}_{Q}$ we have the case of the last subsection. However in this subsection we are looking for a low rank approximation of $\bm{W}$. Toward this end we define the dimension $d_{k}$ of associative space and use the matrices $\bm{W}_{K}^{T}$ and $\bm{W}_{Q}$ to map to the associative space.

The update rule is

$$
\displaystyle\bm{\xi}^{\mathrm{new}}\
$$
 
$$
\displaystyle=\ \bm{X}\ \bm{p}\ ,
$$

where we used

$$
\displaystyle\bm{p}\
$$
 
$$
\displaystyle=\ \mathrm{softmax}(\beta\ \bm{X}^{T}\bm{\xi})\ .
$$

We consider raw state patterns $\bm{r}_{n}$ that are mapped to state patterns $\bm{\xi}_{n}=\bm{W}_{Q}\bm{r}_{n}$ with $\bm{Q}^{T}=\bm{\Xi}=\bm{W}_{Q}\bm{R}$ and raw stored pattern $\bm{y}_{s}$ that are mapped to stored patterns $\bm{x}_{s}=\bm{W}_{K}\bm{y}_{s}$ with $\bm{K}^{T}=\bm{X}=\bm{W}_{K}\bm{Y}$. The update rule is

$$
\displaystyle\bm{\xi}^{\mathrm{new}}\
$$
 
$$
\displaystyle=\ \bm{W}_{K}\ \bm{Y}\ \bm{p}\ =\ \bm{W}_{K}\ \bm{Y}\ \mathrm{softmax}(\beta\ \bm{Y}^{T}\bm{W}_{K}^{T}\bm{W}_{Q}\ \bm{r})\ .
$$

Since new state vector $\bm{\xi}^{\mathrm{new}}$ is projected by a weight matrix $\bm{W}_{V}$ to another vector, we consider the simplified update rule:

$$
\displaystyle\bm{\xi}^{\mathrm{new}}\
$$
 
$$
\displaystyle=\ \bm{Y}\ \bm{p}\ =\ \bm{Y}\ \mathrm{softmax}(\beta\ \bm{Y}^{T}\bm{W}_{K}^{T}\bm{W}_{Q}\ \bm{r})\ .
$$

For the simplified update rule, the vector $\bm{\xi}^{\mathrm{new}}$ does not live in the associative space but in the space of raw stored pattern $\bm{y}$. However $\bm{W}_{K}$ would map it to the associative space.

•Derivative with respect to $\bm{W}_{Q}$. The derivative with respect to $\bm{W}_{Q}$ is

$$
\displaystyle\frac{\partial\bm{a}^{T}\bm{\xi}^{\mathrm{new}}}{\partial\bm{W}_{Q}}\
$$
 
$$
\displaystyle=\ \frac{\partial\bm{\xi}^{\mathrm{new}}}{\partial\bm{W}_{Q}}\ \frac{\partial\bm{a}^{T}\bm{\xi}^{\mathrm{new}}}{\partial\bm{\xi}^{\mathrm{new}}}\ =\ \frac{\partial\bm{\xi}^{\mathrm{new}}}{\partial(\bm{W}_{Q}\ \bm{r})}\ \frac{\partial(\bm{W}_{Q}\ \bm{r})}{\partial\bm{W}_{Q}}\ \frac{\partial\bm{a}^{T}\bm{\xi}^{\mathrm{new}}}{\partial\bm{\xi}^{\mathrm{new}}}\ .
$$
 
$$
\displaystyle\frac{\partial\bm{\xi}^{\mathrm{new}}}{\partial(\bm{W}_{Q}\ \bm{r})}\
$$
 
$$
\displaystyle=\ \beta\ \bm{Y}\ \left(\mathrm{diag}(\bm{p})-\bm{p}\bm{p}^{T}\right)\ \bm{Y}^{T}\bm{W}_{K}^{T}
$$
 
$$
\displaystyle\frac{\partial\bm{a}^{T}\bm{\xi}^{\mathrm{new}}}{\partial\bm{\xi}^{\mathrm{new}}}\
$$
 
$$
\displaystyle=\ \bm{a}\ .
$$

We have the product of the 3-dimensional tensor $\frac{\partial(\bm{W}_{Q}\bm{r})}{\partial\bm{W}_{Q}}$ with the vector $\bm{a}$ which gives a 2-dimensional tensor, i.e. a matrix:

$$
\displaystyle\frac{\partial(\bm{W}_{Q}\ \bm{r})}{\partial\bm{W}_{Q}}\ \frac{\partial\bm{a}^{T}\bm{\xi}^{\mathrm{new}}}{\partial\bm{\xi}^{\mathrm{new}}}\
$$
 
$$
\displaystyle=\ \frac{\partial(\bm{W}_{Q}\ \bm{r})}{\partial\bm{W}_{Q}}\ \bm{a}\ =\ \bm{r}^{T}\bm{a}\ \bm{I}\ .
$$
 
$$
\displaystyle\frac{\partial\bm{a}^{T}\bm{\xi}^{\mathrm{new}}}{\partial\bm{W}_{Q}}\
$$
 
$$
\displaystyle=\ \beta\ \bm{Y}\ \left(\mathrm{diag}(\bm{p})-\bm{p}\bm{p}^{T}\right)\ \bm{Y}^{T}\ \bm{W}_{K}^{T}(\bm{r}^{T}\bm{a})\ =\ \mathrm{J}\ \bm{W}_{K}^{T}(\bm{r}^{T}\bm{a})\ ,
$$

where $\mathrm{J}$ is the Jacobian of the update rule defined in Eq. (59).

To obtain the derivative of the full update rule Eq. (423) we have to include the factor $\bm{W}_{K}$, then get

$$
\displaystyle\frac{\partial\bm{a}^{T}\bm{\xi}^{\mathrm{new}}}{\partial\bm{W}_{Q}}\
$$
 
$$
\displaystyle=\ \beta\ \bm{W}_{K}\ \bm{Y}\left(\mathrm{diag}(\bm{p})-\bm{p}\bm{p}^{T}\right)\ \bm{Y}^{T}\ \bm{W}_{K}^{T}(\bm{r}^{T}\bm{a})\ =\ \bm{W}_{K}\ \mathrm{J}\ \bm{W}_{K}^{T}(\bm{r}^{T}\bm{a})\ .
$$

•Derivative with respect to $\bm{W}_{K}$. The derivative with respect to $\bm{W}_{K}$ is

$$
\displaystyle\frac{\partial\bm{a}^{T}\bm{\xi}^{\mathrm{new}}}{\partial\bm{W}_{K}}\
$$
 
$$
\displaystyle=\ \frac{\partial\bm{\xi}^{\mathrm{new}}}{\partial\bm{W}_{K}}\ \frac{\partial\bm{a}^{T}\bm{\xi}^{\mathrm{new}}}{\partial\bm{\xi}^{\mathrm{new}}}\ =\ \frac{\partial\bm{\xi}^{\mathrm{new}}}{\partial(\bm{W}_{K}^{T}\bm{W}_{Q}\ \bm{r})}\ \frac{\partial(\bm{W}_{K}^{T}\bm{W}_{Q}\ \bm{r})}{\partial\bm{W}_{K}}\ \frac{\partial\bm{a}^{T}\bm{\xi}^{\mathrm{new}}}{\partial\bm{\xi}^{\mathrm{new}}}\ .
$$
 
$$
\displaystyle\frac{\partial\bm{\xi}^{\mathrm{new}}}{\partial(\bm{W}_{K}^{T}\bm{W}_{Q}\ \bm{r})}\
$$
 
$$
\displaystyle=\ \beta\ \bm{Y}\ \left(\mathrm{diag}(\bm{p})-\bm{p}\bm{p}^{T}\right)\ \bm{Y}^{T}
$$
 
$$
\displaystyle\frac{\partial\bm{a}^{T}\bm{\xi}^{\mathrm{new}}}{\partial\bm{\xi}^{\mathrm{new}}}\
$$
 
$$
\displaystyle=\ \bm{a}\ .
$$

We have the product of the 3-dimensional tensor $\frac{\partial(\bm{W}\bm{r})}{\partial\bm{W}_{K}}$ with the vector $\bm{a}$ which gives a 2-dimensional tensor, i.e. a matrix:

$$
\displaystyle\frac{\partial(\bm{W}_{K}^{T}\bm{W}_{Q}\ \bm{r})}{\partial\bm{W}_{K}}\ \frac{\partial\bm{a}^{T}\bm{\xi}^{\mathrm{new}}}{\partial\bm{\xi}^{\mathrm{new}}}\
$$
 
$$
\displaystyle=\ \frac{\partial(\bm{W}_{K}^{T}\bm{W}_{Q}\ \bm{r})}{\partial\bm{W}_{K}}\ \bm{a}\ =\ \bm{W}_{Q}^{T}\bm{r}^{T}\bm{a}\ \bm{I}\ .
$$
 
$$
\displaystyle\frac{\partial\bm{a}^{T}\bm{\xi}^{\mathrm{new}}}{\partial\bm{W}_{K}}\
$$
 
$$
\displaystyle=\ \beta\ \bm{Y}\ \left(\mathrm{diag}(\bm{p})-\bm{p}\bm{p}^{T}\right)\ \bm{Y}^{T}\ (\bm{W}_{Q}^{T}\bm{r}^{T}\bm{a})\ =\ \mathrm{J}\ (\bm{W}_{Q}^{T}\bm{r}^{T}\bm{a})\ ,
$$

where $\mathrm{J}$ is the Jacobian of the update rule defined in Eq. (59).

To obtain the derivative of the full update rule Eq. (423) we have to add the term

$$
\displaystyle\bm{a}\ \bm{p}^{T}\bm{Y}^{T}
$$

and to include the factor $\bm{W}_{K}$, then get

$$
\displaystyle\frac{\partial\bm{a}^{T}\bm{\xi}^{\mathrm{new}}}{\partial\bm{W}_{K}}\
$$
 
$$
\displaystyle=\ \bm{a}\ \bm{p}^{T}\bm{Y}^{T}\ +\ \beta\ \bm{W}_{K}\ \bm{Y}\ \left(\mathrm{diag}(\bm{p})-\bm{p}\bm{p}^{T}\right)\ \bm{Y}^{T}(\bm{W}_{Q}^{T}\bm{r}^{T}\bm{a})
$$
 
$$
\displaystyle=\ \bm{a}\ \bm{p}^{T}\bm{Y}^{T}\ +\ \bm{W}_{K}\ \mathrm{J}\ (\bm{W}_{Q}^{T}\bm{r}^{T}\bm{a})\ .
$$

#### A.1.8 Infinite Many Patterns and Forgetting Patterns

In the next subsection we show how the new Hopfield networks can be used for auto-regressive tasks by causal masking. In the following subsection, we introduce forgetting to the new Hopfield networks by adding a negative value to the softmax which is larger if the pattern was observed more in the past.

##### A.1.8.1 Infinite Many Patterns.

The new Hopfield networks can be used for auto-regressive tasks, that is time series prediction and similar. Causal masking masks out the future by a large negative value in the softmax.

We assume to have infinite many stored patterns (keys) $\bm{x}_{1},\bm{x}_{2},\ldots$ that are represented by the infinite matrix

$$
\displaystyle\bm{X}\
$$
 
$$
\displaystyle=\ \left(\bm{x}_{1},\bm{x}_{2},\ldots,\right)\ .
$$

The pattern index is now a time index, that is, we observe $\bm{x}_{t}$ at time $t$.

The pattern matrix at time $t$ is

$$
\displaystyle\bm{X}_{t}\
$$
 
$$
\displaystyle=\ \left(\bm{x}_{1},\bm{x}_{2},\ldots,\bm{x}_{t}\right)\ .
$$

The query at time $t$ is $\bm{\xi}_{t}$.

For $M_{t}=\max_{1\leqslant i\leqslant t}{{\left\|\bm{x}_{t}\right\|}}$, the energy function at time $t$ is $\mathrm{E}_{t}$

$$
\displaystyle\mathrm{E}_{t}\
$$
 
$$
\displaystyle=\ -\ \mathrm{lse}(\beta,\bm{X}_{t}^{T}\bm{\xi}_{t})\ +\ \frac{1}{2}\bm{\xi}_{t}^{T}\bm{\xi}_{t}\ +\ \beta^{-1}\ln t\ +\ \frac{1}{2}M_{t}^{2}
$$
 
$$
\displaystyle=\ -\ \beta^{-1}\ln\left(\sum_{i=1}^{t}\exp(\beta\bm{x}_{i}^{T}\bm{\xi}_{t})\right)\ +\ \frac{1}{2}\bm{\xi}_{t}^{T}\bm{\xi}_{t}\ +\ \beta^{-1}\ln t\ +\ \frac{1}{2}M_{t}^{2}\ .
$$

The update rule is

$$
\displaystyle\bm{\xi}_{t}^{\mathrm{new}}\
$$
 
$$
\displaystyle=\ \bm{X}_{t}\ \bm{p}_{t}\ =\ \bm{X}_{t}\ \mathrm{softmax}(\beta\ \bm{X}_{t}^{T}\bm{\xi}_{t})\ ,
$$

where we used

$$
\displaystyle\bm{p}_{t}\
$$
 
$$
\displaystyle=\ \mathrm{softmax}(\beta\ \bm{X}_{t}^{T}\bm{\xi}_{t})\ .
$$

We can use an infinite pattern matrix with an infinite softmax when using causal masking. The pattern matrix at time $t$ is

$$
\displaystyle\bm{X}_{t}\
$$
 
$$
\displaystyle=\ \left(\bm{x}_{1},\bm{x}_{2},\ldots,\bm{x}_{t},-\alpha\bm{\xi}_{t},-\alpha\bm{\xi}_{t},\ldots\right)\ ,
$$

with the query $\bm{\xi}_{t}$ and $\alpha\to\infty$. The energy function at time $t$ is $\mathrm{E}_{t}$

$$
\displaystyle\mathrm{E}_{t}\
$$
 
$$
\displaystyle=\ -\ \mathrm{lse}(\beta,\bm{X}_{t}^{T}\bm{\xi}_{t})\ +\ \frac{1}{2}\bm{\xi}_{t}^{T}\bm{\xi}_{t}\ +\ \beta^{-1}\ln t\ +\ \frac{1}{2}M_{t}^{2}
$$
 
$$
\displaystyle=\ -\ \beta^{-1}\ln\left(\sum_{i=1}^{t}\exp(\beta\bm{x}_{i}^{T}\bm{\xi}_{t})\ +\ \sum_{i=t+1}^{\lfloor\alpha\rfloor}\exp(-\beta\alpha{{\left\|\bm{\xi}_{t}\right\|}}^{2})\right)\ +\ \frac{1}{2}\bm{\xi}_{t}^{T}\bm{\xi}_{t}\ +
$$
 
$$
\displaystyle~~~~~~~\beta^{-1}\ln t\ +\ \frac{1}{2}M_{t}^{2}\ .
$$

For $\alpha\to\infty$ and ${{\left\|\bm{\xi}_{t}\right\|}}>0$ this becomes

$$
\displaystyle\mathrm{E}_{t}\
$$
 
$$
\displaystyle=\ -\ \mathrm{lse}(\beta,\bm{X}_{t}^{T}\bm{\xi}_{t})\ +\ \frac{1}{2}\bm{\xi}_{t}^{T}\bm{\xi}_{t}\ +\ \beta^{-1}\ln t\ +\ \frac{1}{2}M_{t}^{2}
$$
 
$$
\displaystyle=\ -\ \beta^{-1}\ln\left(\sum_{i=1}^{t}\exp(\beta\bm{x}_{i}^{T}\bm{\xi}_{t})\right)\ +\ \frac{1}{2}\bm{\xi}_{t}^{T}\bm{\xi}_{t}\ +\ \beta^{-1}\ln t\ +\ \frac{1}{2}M_{t}^{2}\ .
$$

##### A.1.8.2 Forgetting Patterns.

We introduce forgetting to the new Hopfield networks by adding a negative value in the softmax which increases with patterns that are more in the past.

We assume to have infinite many patterns $\bm{x}_{1},\bm{x}_{2},\ldots$ that are represented by the infinite matrix

$$
\displaystyle\bm{X}\
$$
 
$$
\displaystyle=\ \left(\bm{x}_{1},\bm{x}_{2},\ldots,\right)\ .
$$

The pattern index is now a time index, that is, we observe $\bm{x}_{t}$ at time $t$.

The pattern matrix at time $t$ is

$$
\displaystyle\bm{X}_{t}\
$$
 
$$
\displaystyle=\ \left(\bm{x}_{1},\bm{x}_{2},\ldots,\bm{x}_{t}\right)\ .
$$

The query at time $t$ is $\bm{\xi}_{t}$.

The energy function with forgetting parameter $\gamma$ at time $t$ is $\mathrm{E}_{t}$

$$
\displaystyle\mathrm{E}_{t}\
$$
 
$$
\displaystyle=\ -\ \mathrm{lse}(\beta,\bm{X}_{t}^{T}\bm{\xi}_{t}\ -\ \gamma(t-1,t-2,\ldots,0)^{T})\ +\ \frac{1}{2}\bm{\xi}_{t}^{T}\bm{\xi}_{t}\ +\ \beta^{-1}\ln t\ +\ \frac{1}{2}M_{t}^{2}
$$
 
$$
\displaystyle=\ -\ \beta^{-1}\ln\left(\sum_{i=1}^{T}\exp(\beta\bm{x}_{i}^{T}\bm{\xi}_{t}\ -\ \gamma(t-i))\right)\ +\ \frac{1}{2}\bm{\xi}_{t}^{T}\bm{\xi}_{t}\ +\ \beta^{-1}\ln t\ +\ \frac{1}{2}M_{t}^{2}\ .
$$

The update rule is

$$
\displaystyle\bm{\xi}_{t}^{\mathrm{new}}\
$$
 
$$
\displaystyle=\ \bm{X}_{t}\ \bm{p}_{t}\ =\ \bm{X}_{t}\ \mathrm{softmax}(\beta\bm{X}_{t}^{T}\bm{\xi}_{t})\ ,
$$

where we used

$$
\displaystyle\bm{p}_{t}\
$$
 
$$
\displaystyle=\ \mathrm{softmax}(\beta\bm{X}_{t}^{T}\bm{\xi}_{t})\ .
$$

#### A.1.9 Number of Spurious States

The energy $\mathrm{E}$ is defined as

$$
\displaystyle\mathrm{E}\
$$
 
$$
\displaystyle=\ -\ \mathrm{lse}(\beta,\bm{X}^{T}\bm{\xi})\ +\ \frac{1}{2}\bm{\xi}^{T}\bm{\xi}\ +\ \beta^{-1}\ln N\ +\ \frac{1}{2}M^{2}
$$
 
$$
\displaystyle=\ -\ \beta^{-1}\ln\left(\sum_{i=1}^{N}\exp(\beta\bm{x}_{i}^{T}\bm{\xi})\right)\ +\ \beta^{-1}\ln N\ +\ \frac{1}{2}\bm{\xi}^{T}\bm{\xi}\ +\ \frac{1}{2}M^{2}\ .
$$

Since the negative exponential function is strict monotonic decreasing, $\exp(-\mathrm{E})$ has minima, where $\mathrm{E}$ has maxima, and has maxima, where as has minima $\mathrm{E}$.

$$
\displaystyle\exp(-\mathrm{E})\
$$
 
$$
\displaystyle=\ \exp(\mathrm{lse}(\beta,\bm{X}^{T}\bm{\xi}))\ \exp(-\ \frac{1}{2}\bm{\xi}^{T}\bm{\xi})\ C
$$
 
$$
\displaystyle=\left(\sum_{i=1}^{N}\exp(\beta\bm{x}_{i}^{T}\bm{\xi})\right)^{\beta^{-1}}\ \exp(-\ \frac{1}{2}\bm{\xi}^{T}\bm{\xi})\ C
$$
 
$$
\displaystyle=\left(\sum_{i=1}^{N}\exp(\beta\bm{x}_{i}^{T}\bm{\xi})\right)^{\beta^{-1}}\ \left(\exp(-\ \beta\ \frac{1}{2}\bm{\xi}^{T}\bm{\xi})\right)^{\beta^{-1}}\ C
$$
 
$$
\displaystyle=\left(\sum_{i=1}^{N}\exp(\beta\ (\bm{x}_{i}^{T}\bm{\xi}\ -\ \frac{1}{2}\bm{\xi}^{T}\bm{\xi}))\right)^{\beta^{-1}}\ C
$$
 
$$
\displaystyle=\left(\sum_{i=1}^{N}\exp(\frac{1}{2}\ \beta\ \bm{x}_{i}^{T}\bm{x}_{i}\ -\ \frac{1}{2}\ \beta\ (\bm{\xi}\ -\ \bm{x}_{i})^{T}(\bm{\xi}\ -\ \bm{x}_{i}))\right)^{\beta^{-1}}\ C
$$
 
$$
\displaystyle=\left(\sum_{i=1}^{N}\lambda(\bm{x}_{i},\beta)\ G(\bm{\xi};\bm{x}_{i},\beta^{-1}\ \bm{I})\right)^{\beta^{-1}}\ C\ ,
$$

where $C$ is a positive constant, $\lambda(\bm{x}_{i},\beta)=\exp(\frac{1}{2}\beta\bm{x}_{i}^{T}\bm{x}_{i})$ and $G(\bm{\xi};\bm{x}_{i},\beta^{-1}\bm{I})$ is the Gaussian with mean $\bm{x}_{i}$ and covariance matrix $\beta^{-1}\bm{I}$.

Since $C$ is a positive constant and $x^{\beta^{-1}}=\exp(\beta^{-1}\ln x)$ is strict monotonic for positive $x$, the minima of $\mathrm{E}$ are the maxima of

$$
\displaystyle\sum_{i=1}^{N}\lambda(\bm{x}_{i},\beta)\ G(\bm{\xi};\bm{x}_{i},\beta^{-1}\ \bm{I})\ .
$$

In [^19] it was shown that Eq. (458) can have more than $N$ modes, that is, more than $N$ maxima.

### A.2 Properties of Softmax, Log-Sum-Exponential, Legendre Transform, Lambert W Function

For $\beta>0$, the softmax is defined as

###### Definition A1 (Softmax).

$$
\displaystyle\bm{p}\
$$
 
$$
\displaystyle=\ \mathrm{softmax}(\beta\bm{x})
$$
 
$$
\displaystyle p_{i}\
$$
 
$$
\displaystyle=\ [\mathrm{softmax}(\beta\bm{x})]_{i}\ =\ \frac{\exp(\beta x_{i})}{\sum_{k}\exp(\beta x_{k})}\ .
$$

We also need the log-sum-exp function ($\mathrm{lse}$), defined as

###### Definition A2 (Log-Sum-Exp Function).

$$
\displaystyle\mathrm{lse}(\beta,\bm{x})\
$$
 
$$
\displaystyle=\ \beta^{-1}\ln\left(\sum_{i=1}^{N}\exp(\beta x_{i})\right)\ .
$$

We can formulate the $\mathrm{lse}$ in another base:

$$
\displaystyle\beta_{a}\
$$
 
$$
\displaystyle=\ \frac{\beta}{\ln a}\ ,
$$
$$
\displaystyle\mathrm{lse}(\beta,\bm{x})\
$$
 
$$
\displaystyle=\ \beta^{-1}\ln\left(\sum_{i=1}^{N}\exp(\beta\ x_{i})\right)
$$
 
$$
\displaystyle=\ \left(\beta_{a}\ \ln a\right)^{-1}\ln\left(\sum_{i=1}^{N}\exp(\beta_{a}\ \ln a\ x_{i})\right)
$$
 
$$
\displaystyle=\ \left(\beta_{a}\right)^{-1}\log_{a}\left(\sum_{i=1}^{N}a^{\beta_{a}\ x_{i}}\right)\ .
$$

In particular, the base $a=2$ can be used to speed up computations.

Next, we give the relation between the softmax and the $\mathrm{lse}$ function.

###### Lemma A18.

The softmax is the gradient of the $\mathrm{lse}$:

$$
\displaystyle\mathrm{softmax}(\beta\bm{x})\
$$
 
$$
\displaystyle=\ \nabla_{\bm{x}}\mathrm{lse}(\beta,\bm{x})\ .
$$

In the next lemma we report some important properties of the $\mathrm{lse}$ function.

###### Lemma A19.

We define

$$
\displaystyle\mathrm{L}\
$$
 
$$
\displaystyle:=\ \bm{z}^{T}\bm{x}\ -\ \beta^{-1}\sum_{i=1}^{N}z_{i}\ln z_{i}
$$

with $\mathrm{L}\geq\bm{z}^{T}\bm{x}$. The $\mathrm{lse}$ is the maximum of $\mathrm{L}$ on the $N$ -dimensional simplex $D$ with $D=\{\bm{z}\mid\sum_{i}z_{i}=1,0\leqslant z_{i}\}$:

$$
\displaystyle\mathrm{lse}(\beta,\bm{x})\
$$
 
$$
\displaystyle=\ \max_{\bm{z}\in D}\bm{z}^{T}\bm{x}\ -\ \beta^{-1}\sum_{i=1}^{N}z_{i}\ln z_{i}\ .
$$

The softmax $\bm{p}=\mathrm{softmax}(\beta\bm{x})$ is the argument of the maximum of $\mathrm{L}$ on the $N$ -dimensional simplex $D$ with $D=\{\bm{z}\mid\sum_{i}z_{i}=1,0\leqslant z_{i}\}$:

$$
\displaystyle\bm{p}\
$$
 
$$
\displaystyle=\ \mathrm{softmax}(\beta\bm{x})\ =\ \arg\max_{\bm{z}\in D}\bm{z}^{T}\bm{x}\ -\ \beta^{-1}\sum_{i=1}^{N}z_{i}\ln z_{i}\ .
$$

###### Proof.

Eq. (466) is obtained from Equation (8) in [^38] and Eq. (467) from Equation (11) in [^38]. ∎

From a physical point of view, the $\mathrm{lse}$ function represents the “free energy” in statistical thermodynamics [^38].

Next we consider the Jacobian of the softmax and its properties.

###### Lemma A20.

The Jacobian $\mathrm{J}_{s}$ of the softmax $\bm{p}=\mathrm{softmax}(\beta\bm{x})$ is

$$
\displaystyle\mathrm{J}_{s}\
$$
 
$$
\displaystyle=\ \frac{\partial\mathrm{softmax}(\beta\bm{x})}{\partial\bm{x}}\ =\ \beta\left(\mathrm{diag}(\bm{p})-\bm{p}\bm{p}^{T}\right)\ ,
$$

which gives the elements

$$
\displaystyle[\mathrm{J}_{s}]_{ij}\
$$
 
$$
\displaystyle=\ \begin{cases}\beta p_{i}(1-p_{i})&\text{for}\ i=j\\
-\beta p_{i}p_{j}&\text{for}\ i\not=j\end{cases}\ .
$$

Next we show that $\mathrm{J}_{s}$ has eigenvalue $0$.

###### Lemma A21.

The Jacobian $\mathrm{J}_{s}$ of the softmax function $\bm{p}=\mathrm{softmax}(\beta\bm{x})$ has a zero eigenvalue with eigenvector $\bm{1}$.

###### Proof.

$$
\displaystyle[\mathrm{J}_{s}\bm{1}]_{i}\
$$
 
$$
\displaystyle=\ \beta\left(p_{i}(1-p_{i})\ -\ \sum_{j,j\not=i}p_{i}p_{j}\right)\ =\ \beta\ p_{i}(1\ -\ \sum_{j}p_{j})\ =0\ .
$$

∎

Next we show that $0$ is the smallest eigenvalue of $\mathrm{J}_{s}$, therefore $\mathrm{J}_{s}$ is positive semi-definite but not (strict) positive definite.

###### Lemma A22.

The Jacobian $\mathrm{J}_{s}$ of the softmax $\bm{p}=\mathrm{softmax}(\beta\bm{\xi})$ is symmetric and positive semi-definite.

###### Proof.

For an arbitrary $\bm{z}$, we have

$$
\displaystyle\bm{z}^{T}\left(\mathrm{diag}(\bm{p})-\bm{p}\bm{p}^{T}\right)\bm{z}\
$$
 
$$
\displaystyle=\ \sum_{i}p_{i}z_{i}^{2}-\left(\sum_{i}p_{i}z_{i}\right)^{2}
$$
 
$$
\displaystyle=\ \left(\sum_{i}p_{i}z_{i}^{2}\right)\ \left(\sum_{i}p_{i}\right)-\left(\sum_{i}p_{i}z_{i}\right)^{2}\ \geq\ 0\ .
$$

The last inequality hold true because the Cauchy-Schwarz inequality says $(\bm{a}^{T}\bm{a})(\bm{b}^{T}\bm{b})\geq(\bm{a}^{T}\bm{b})^{2}$, which is the last inequality with $a_{i}=z_{i}\sqrt{p_{i}}$ and $b_{i}=\sqrt{p_{i}}$. Consequently $\left(\mathrm{diag}(\bm{p})-\bm{p}\bm{p}^{T}\right)$ is positive semi-definite.

Alternatively $\sum_{i}p_{i}z_{i}^{2}-\left(\sum_{i}p_{i}z_{i}\right)^{2}$ can be viewed as the expected second moment minus the mean squared which gives the variance that is larger equal to zero.

The Jacobian is $0<\beta$ times a positive semi-definite matrix, which is a positive semi-definite matrix. ∎

Moreover, the softmax is a monotonic map, as described in the next lemma.

###### Lemma A23.

The softmax $\mathrm{softmax}(\beta\bm{x})$ is monotone for $\beta>0$, that is,

$$
\displaystyle\left(\mathrm{softmax}(\beta\bm{x})\ -\ \mathrm{softmax}(\beta\bm{x}^{\prime})\right)^{T}\left(\bm{x}\ -\ \bm{x}^{\prime}\right)\
$$
 
$$
\displaystyle\geq\ 0\ .
$$

###### Proof.

We use the version of mean value theorem Lemma A32 with the symmetric matrix $\mathrm{J}_{s}^{m}=\int_{0}^{1}\mathrm{J}_{s}(\lambda\bm{x}\ +\ (1-\lambda)\bm{x}^{\prime})\ \mathrm{d}\lambda$:

$$
\displaystyle\mathrm{softmax}(\bm{x})\ -\ \mathrm{softmax}(\bm{x}^{\prime})\
$$
 
$$
\displaystyle=\ \mathrm{J}_{s}^{m}\ \left(\bm{x}\ -\ \bm{x}^{\prime}\right)\ .
$$

Therefore

$$
\displaystyle\left(\mathrm{softmax}(\bm{x})\ -\ \mathrm{softmax}(\bm{x}^{\prime})\right)^{T}\left(\bm{x}\ -\ \bm{x}^{\prime}\right)\ =\ \left(\bm{x}\ -\ \bm{x}^{\prime}\right)^{T}\mathrm{J}_{s}^{m}\ \left(\bm{x}\ -\ \bm{x}^{\prime}\right)\ \geq\ 0\ ,
$$

since $\mathrm{J}_{s}^{m}$ is positive semi-definite. For all $\lambda$ the Jacobians $\mathrm{J}_{s}(\lambda\bm{x}\ +\ (1-\lambda)\bm{x}^{\prime})$ are positive semi-definite according to Lemma A22. Since

$$
\displaystyle\bm{x}^{T}\mathrm{J}_{s}^{m}\bm{x}\
$$
 
$$
\displaystyle=\ \int_{0}^{1}\bm{x}^{T}\mathrm{J}_{s}(\lambda\bm{x}\ +\ (1-\lambda)\bm{x}^{\prime})\ \bm{x}\ \mathrm{d}\lambda\ \geq\ 0
$$

is an integral over positive values for every $\bm{x}$, $\mathrm{J}_{s}^{m}$ is positive semi-definite, too. ∎

Next we give upper bounds on the norm of $\mathrm{J}_{s}$.

###### Lemma A24.

For a softmax $\bm{p}=\mathrm{softmax}(\beta\bm{x})$ with $m=\max_{i}p_{i}(1-p_{i})$, the spectral norm of the Jacobian $\mathrm{J}_{s}$ of the softmax is bounded:

$$
\displaystyle{{\left\|\mathrm{J}_{s}\right\|}}_{2}\
$$
 
$$
\displaystyle\leqslant\ 2\ m\ \beta\ ,
$$
$$
\displaystyle{{\left\|\mathrm{J}_{s}\right\|}}_{1}\
$$
 
$$
\displaystyle\leqslant\ 2\ m\ \beta\ ,
$$
$$
\displaystyle{{\left\|\mathrm{J}_{s}\right\|}}_{\infty}\
$$
 
$$
\displaystyle\leqslant\ 2\ m\ \beta\ .
$$

In particular everywhere holds

$$
\displaystyle{{\left\|\mathrm{J}_{s}\right\|}}_{2}\
$$
 
$$
\displaystyle\leqslant\ \frac{1}{2}\ \beta\ .
$$

If $p_{\max}=\max_{i}p_{i}\geq 1-\epsilon\geq 0.5$, then for the spectral norm of the Jacobian holds

$$
\displaystyle{{\left\|\mathrm{J}_{s}\right\|}}_{2}\
$$
 
$$
\displaystyle\leqslant\ 2\ \epsilon\ \beta\ \ -\ 2\ \epsilon^{2}\ \beta\ \ <\ 2\ \epsilon\ \beta\ .
$$

###### Proof.

We consider the maximum absolute column sum norm

$$
\displaystyle{{\left\|\bm{A}\right\|}}_{1}\
$$
 
$$
\displaystyle=\ \max_{j}\sum_{i}{{\left|a_{ij}\right|}}
$$

and the maximum absolute row sum norm

$$
\displaystyle{{\left\|\bm{A}\right\|}}_{\infty}\
$$
 
$$
\displaystyle=\ \max_{i}\sum_{j}{{\left|a_{ij}\right|}}\ .
$$

We have for $\bm{A}=\mathrm{J}_{s}=\beta\left(\mathrm{diag}(\bm{p})-\bm{p}\bm{p}^{T}\right)$

$$
\displaystyle\sum_{j}{{\left|a_{ij}\right|}}\
$$
 
$$
\displaystyle=\ \beta\ \left(p_{i}(1-p_{i})\ +\ \sum_{j,j\not=i}p_{i}p_{j}\right)\ =\ \beta\ p_{i}\ (1\ -\ 2p_{i}\ +\ \sum_{j}p_{j})
$$
 
$$
\displaystyle=\ 2\ \beta\ p_{i}\ (1-p_{i})\ \leqslant\ 2\ m\ \beta\ ,
$$
$$
\displaystyle\sum_{i}{{\left|a_{ij}\right|}}\
$$
 
$$
\displaystyle=\ \beta\ \left(p_{j}\ (1-p_{j})\ +\ \sum_{i,i\not=j}p_{j}p_{i}\right)\ =\ \beta\ p_{j}\ (1\ -\ 2p_{j}\ +\ \sum_{i}p_{i})
$$
 
$$
\displaystyle=\ 2\ \beta\ p_{j}\ (1-p_{j})\ \leqslant\ 2\ m\ \beta\ .
$$

Therefore, we have

$$
\displaystyle{{\left\|\mathrm{J}_{s}\right\|}}_{1}\
$$
 
$$
\displaystyle\leqslant\ 2\ m\ \beta\ ,
$$
$$
\displaystyle{{\left\|\mathrm{J}_{s}\right\|}}_{\infty}\
$$
 
$$
\displaystyle\leqslant\ 2\ m\ \beta\ ,
$$
$$
\displaystyle{{\left\|\mathrm{J}_{s}\right\|}}_{2}\
$$
 
$$
\displaystyle\leqslant\ \sqrt{{{\left\|\mathrm{J}_{s}\right\|}}_{1}{{\left\|\mathrm{J}_{s}\right\|}}_{\infty}}\ \leqslant\ 2\ m\ \beta\ .
$$

The last inequality is a direct consequence of Hölder’s inequality.

For $0\leqslant p_{i}\leqslant 1$, we have $p_{i}(1-p_{i})\leqslant 0.25$. Therefore, $m\leqslant 0.25$ for all values of $p_{i}$.

If $p_{\max}\geq 1-\epsilon\geq 0.5$ ($\epsilon\leqslant 0.5$), then $1-p_{\max}\leqslant\epsilon$ and for $p_{i}\not=p_{\max}$ $p_{i}\leqslant\epsilon$. The derivative $\partial x(1-x)/\partial x=1-2x>0$ for $x<0.5$, therefore $x(1-x)$ increases with $x$ for $x<0.5$. Using $x=1-p_{\max}$ and for $p_{i}\not=p_{\max}$ $x=p_{i}$, we obtain $p_{i}(1-p_{i})\leqslant\epsilon(1-\epsilon)$ for all $i$. Consequently, we have $m\leqslant\epsilon(1-\epsilon)$. ∎

Using the bounds on the norm of the Jacobian, we give some Lipschitz properties of the softmax function.

###### Lemma A25.

The softmax function $\bm{p}=\mathrm{softmax}(\beta\bm{x})$ is $(\beta/2)$ -Lipschitz. The softmax function $\bm{p}=\mathrm{softmax}(\beta\bm{x})$ is $(2\beta m)$ -Lipschitz in a convex environment $U$ for which $m=\max_{\bm{x}\in U}\max_{i}p_{i}(1-p_{i})$. For $p_{\max}=\min_{\bm{x}\in U}\max_{i}p_{i}=1-\epsilon$, the softmax function $\bm{p}=\mathrm{softmax}(\beta\bm{x})$ is $(2\beta\epsilon)$ -Lipschitz. For $\beta<2m$, the softmax $\bm{p}=\mathrm{softmax}(\beta\bm{x})$ is contractive in $U$ on which $m$ is defined.

###### Proof.

The version of mean value theorem Lemma A32 states for the symmetric matrix $\mathrm{J}_{s}^{m}=\int_{0}^{1}\mathrm{J}(\lambda\bm{x}+(1-\lambda)\bm{x}^{\prime})\ \mathrm{d}\lambda$:

$$
\displaystyle\mathrm{softmax}(\bm{x})\ -\ \mathrm{softmax}(\bm{x}^{\prime})\
$$
 
$$
\displaystyle=\ \mathrm{J}_{s}^{m}\ \left(\bm{x}\ -\ \bm{x}^{\prime}\right)\ .
$$

According to Lemma A24 for all $\tilde{\bm{x}}=\lambda\bm{x}+(1-\lambda)\bm{x}^{\prime})$

$$
\displaystyle{{\left\|\mathrm{J}_{s}(\tilde{\bm{x}})\right\|}}_{2}\ \leqslant\ 2\ \tilde{m}\ \beta\ ,
$$

where $\tilde{m}=\max_{i}\tilde{p}_{i}(1-\tilde{p}_{i})$. Since $\bm{x}\in U$ and $\bm{x}^{\prime}\in U$ we have $\tilde{\bm{x}}\in U$, since $U$ is convex. For $m=\max_{\bm{x}\in U}\max_{i}p_{i}(1-p_{i})$ we have $\tilde{m}\leqslant m$ for all $\tilde{m}$. Therefore, we have

$$
\displaystyle{{\left\|\mathrm{J}_{s}(\tilde{\bm{x}})\right\|}}_{2}\ \leqslant\ 2\ m\ \beta
$$

which also holds for the mean:

$$
\displaystyle{{\left\|\mathrm{J}_{s}^{m}\right\|}}_{2}\ \leqslant\ 2\ m\ \beta\ .
$$

Therefore,

$$
\displaystyle{{\left\|\mathrm{softmax}(\bm{x})\ -\ \mathrm{softmax}(\bm{x}^{\prime})\right\|}}\
$$
 
$$
\displaystyle\leqslant\ {{\left\|\mathrm{J}_{s}^{m}\right\|}}_{2}\ {{\left\|\bm{x}\ -\ \bm{x}^{\prime}\right\|}}\ \leqslant\ 2\ m\ \beta\ {{\left\|\bm{x}\ -\ \bm{x}^{\prime}\right\|}}\ .
$$

From Lemma A24 we know $m\leqslant 1/4$ globally. For $p_{\max}=\min_{\bm{x}\in U}\max_{i}p_{i}=1-\epsilon$ we have according to Lemma A24: $m\leqslant\epsilon$. ∎

For completeness we present a result about cocoercivity of the softmax:

###### Lemma A26.

For $m=\max_{\bm{x}\in U}\max_{i}p_{i}(1-p_{i})$, softmax function $\bm{p}=\mathrm{softmax}(\beta\bm{x})$ is $1/(2m\beta)$ -cocoercive in $U$, that is,

$$
\displaystyle\left(\mathrm{softmax}(\bm{x})\ -\ \mathrm{softmax}(\bm{x}^{\prime})\right)^{T}\left(\bm{x}\ -\ \bm{x}^{\prime}\right)\
$$
 
$$
\displaystyle\geq\ \frac{1}{2\ m\ \beta}{{\left\|\mathrm{softmax}(\bm{x})\ -\ \mathrm{softmax}(\bm{x}^{\prime})\right\|}}.
$$

In particular the softmax function $\bm{p}=\mathrm{softmax}(\beta\bm{x})$ is $(2/\beta)$ -cocoercive everywhere. With $p_{\max}=\min_{\bm{x}\in U}\max_{i}p_{i}=1-\epsilon$, the softmax function $\bm{p}=\mathrm{softmax}(\beta\bm{x})$ is $1/(2\beta\epsilon)$ -cocoercive in $U$.

###### Proof.

We apply the Baillon-Haddad theorem (e.g. Theorem 1 in [^38]) together with Lemma A25. ∎

Finally, we introduce the Legendre transform and use it to describe further properties of the $\mathrm{lse}$. We start with the definition of the convex conjugate.

###### Definition A3 (Convex Conjugate).

The Convex Conjugate (Legendre-Fenchel transform) of a function $f$ from a Hilbert Space $X$ to $[-\infty,\infty]$ is $f^{*}$ which is defined as

$$
\displaystyle f^{*}(\bm{x}^{*})\
$$
 
$$
\displaystyle=\ \sup_{\bm{x}\in X}(\bm{x}^{T}\bm{x}^{*}\ -\ f(\bm{x}))\ ,\quad\bm{x}^{*}\in X
$$

See page 219 Def. 13.1 in [^11] and page 134 in [^39]. Next we define the Legendre transform, which is a more restrictive version of the convex conjugate.

###### Definition A4 (Legendre Transform).

The Legendre transform of a convex function $f$ from a convex set $X\subset\mathbb{R}^{n}$ to $\mathbb{R}$ ($f:X\rightarrow\mathbb{R}$) is $f^{*}$, which is defined as

$$
\displaystyle f^{*}(\bm{x}^{*})\
$$
 
$$
\displaystyle=\ \sup_{\bm{x}\in X}(\bm{x}^{T}\bm{x}^{*}\ -\ f(\bm{x}))\ ,\quad\bm{x}^{*}\in X^{*}\ ,
$$
$$
\displaystyle X^{*}\
$$
 
$$
\displaystyle=\ \left\{\bm{x}^{*}\in\mathbb{R}^{n}\mid\sup_{\bm{x}\in X}(\bm{x}^{T}\bm{x}^{*}\ -\ f(\bm{x}))<\infty\right\}\ .
$$

See page 91 in [^12].

###### Definition A5 (Epi-Sum).

Let $f$ and $g$ be two functions from $X$ to $(-\infty,\infty]$, then the infimal convolution (or epi-sum) of $f$ and $g$ is

$$
\displaystyle f\Box g:X\rightarrow[-\infty,\infty]\ ,\ \bm{x}\mapsto\inf_{\bm{y}\in X}\left(f(\bm{y})+g(\bm{x}-\bm{y})\right)
$$

See Def. 12.1 in [^11].

###### Lemma A27.

Let $f$ and $g$ be functions from $X$ to $(-\infty,\infty]$. Then the following hold:

1. Convex Conjugate of norm squared
	$$
	\displaystyle\left(\frac{1}{2}{{\left\|.\right\|}}^{2}\right)^{*}\
	$$
	 
	$$
	\displaystyle=\ \frac{1}{2}{{\left\|.\right\|}}^{2}\ .
	$$
2. Convex Conjugate of a function multiplied by scalar $0<\alpha\in\mathbb{R}$
	$$
	\displaystyle\left(\alpha\ f\right)^{*}\
	$$
	 
	$$
	\displaystyle=\ \alpha\ f^{*}(./\alpha)\ .
	$$
3. Convex Conjugate of the sum of a function and a scalar $\beta\in\mathbb{R}$
	$$
	\displaystyle\left(f\ +\ \beta\right)^{*}\
	$$
	 
	$$
	\displaystyle=\ f^{*}\ -\ \beta\ .
	$$
4. Convex Conjugate of affine transformation of the arguments. Let $\bm{A}$ be a non-singular matrix and $\bm{b}$ a vector
	$$
	\displaystyle\left(f\left(\bm{A}\bm{x}\ +\ \bm{b}\right)\right)^{*}\
	$$
	 
	$$
	\displaystyle=\ f^{*}\left(\bm{A}^{-T}\bm{x}^{*}\right)\ -\ \bm{b}^{T}\bm{A}^{-T}\bm{x}^{*}\ .
	$$
5. Convex Conjugate of epi-sums
	$$
	\displaystyle\left(f\Box g\right)^{*}\
	$$
	 
	$$
	\displaystyle=\ f^{*}+g^{*}\ .
	$$

###### Proof.

1. Since $h(t):=\frac{t^{2}}{2}$ is a non-negative convex function and $h(t)=0\iff t=0$ we have because of Proposition 11.3.3 in [^39] that $h\left({{\left\|x\right\|}}\right)^{*}=h^{*}\left({{\left\|x^{*}\right\|}}\right)$. Additionally, by example (a) on page 137 we get for $1<p<\infty$ and $\frac{1}{p}+\frac{1}{q}=1$ that $\left(\frac{|t|^{p}}{p}\right)^{*}=\frac{|t^{*}|^{q}}{q}$. Putting all together we get the desired result. The same result can also be deduced from page 222 Example 13.6 in [^11].
2. Follows immediately from the definition since
	$$
	\displaystyle\alpha f^{*}\left(\frac{\bm{x}^{*}}{\alpha}\right)=\alpha\sup_{\bm{x}\in X}\left(\bm{x}^{T}\frac{\bm{x}^{*}}{\alpha}\ -\ f(\bm{x})\right)=\sup_{\bm{x}\in X}(\bm{x}^{T}\bm{x}^{*}-\alpha f(\bm{x}))=(\alpha f)^{*}(\bm{x}^{*})
	$$
3. $$
	(f+\beta)^{*}:=\sup_{\bm{x}\in X}\left(\bm{x}^{T}\bm{x}^{*}-f(\bm{x})-\beta\right)=:f^{*}-\beta
	$$
4. $$
	\displaystyle\left(f\left(\bm{A}\bm{x}+\bm{b}\right)\right)^{*}(\bm{x}^{*})
	$$
	 
	$$
	\displaystyle=\sup_{\bm{x}\in X}\left(\bm{x}^{T}\bm{x}^{*}-f\left(\bm{A}\bm{x}+\bm{b}\right)\right)
	$$
	 
	$$
	\displaystyle=\sup_{\bm{x}\in X}\left(\left(\bm{A}\bm{x}+\bm{b}\right)^{T}\bm{A}^{-T}\bm{x}^{*}-f\left(\bm{A}\bm{x}+\bm{b}\right)\right)-\bm{b}^{T}\bm{A}^{-T}\bm{x}^{*}
	$$
	 
	$$
	\displaystyle=\sup_{\bm{y}\in X}\left(\bm{y}^{T}\bm{A}^{-T}\bm{x}^{*}-f\left(\bm{y}\right)\right)-\bm{b}^{T}\bm{A}^{-T}\bm{x}^{*}
	$$
	 
	$$
	\displaystyle=f^{*}\left(\bm{A}^{-T}\bm{x}^{*}\right)-\bm{b}^{T}\bm{A}^{-T}\bm{x}^{*}
	$$
5. From Proposition 13.24 (i) in [^11] and Proposition 11.4.2 in [^39] we get
	$$
	\displaystyle\left(f\Box g\right)^{*}(\bm{x}^{*})
	$$
	 
	$$
	\displaystyle=\sup_{\bm{x}\in X}\left(\bm{x}^{T}\bm{x}^{*}-\inf_{\bm{y}\in X}\left(f(\bm{y})-g(\bm{x}-\bm{y})\right)\right)
	$$
	 
	$$
	\displaystyle=\sup_{\bm{x},\bm{y}\in X}\left(\bm{x}^{T}\bm{x}^{*}-f(\bm{y})-g(\bm{x}-\bm{y})\right)
	$$
	 
	$$
	\displaystyle=\sup_{\bm{x},\bm{y}\in X}\left(\left(\bm{y}^{T}\bm{x}^{*}-f(\bm{y})\right)+\left(\left(\bm{x}-\bm{y}\right)^{T}\bm{x}^{*}-g(\bm{x}-\bm{y})\right)\right)
	$$
	 
	$$
	\displaystyle=f^{*}(\bm{x}^{*})+g^{*}(\bm{x}^{*})
	$$

∎

###### Lemma A28.

The Legendre transform of the $\mathrm{lse}$ is the negative entropy function, restricted to the probability simplex and vice versa. For the log-sum exponential

$$
\displaystyle f(\bm{x})\
$$
 
$$
\displaystyle=\ \ln\left(\sum_{i=1}^{n}\exp(x_{i})\right)\ ,
$$

the Legendre transform is the negative entropy function, restricted to the probability simplex:

$$
\displaystyle f^{*}(\bm{x}^{*})\
$$
 
$$
\displaystyle=\ \begin{cases}\sum_{i=1}^{n}x_{i}^{*}\ln(x^{*}_{i})&\text{ for }\ 0\leqslant x^{*}_{i}\ \text{ and }\ \sum_{i=1}^{n}x^{*}_{i}=1\\
\infty&\text{ otherwise }\end{cases}\ .
$$

For the negative entropy function, restricted to the probability simplex:

$$
\displaystyle f(\bm{x})\
$$
 
$$
\displaystyle=\ \begin{cases}\sum_{i=1}^{n}x_{i}\ln(x_{i})&\text{ for }\ 0\leqslant x_{i}\ \text{ and }\ \sum_{i=1}^{n}x_{i}=1\\
\infty&\text{ otherwise }\end{cases}\ .
$$

the Legendre transform is the log-sum exponential

$$
\displaystyle f^{*}(\bm{x}^{*})\
$$
 
$$
\displaystyle=\ \ln\left(\sum_{i=1}^{n}\exp(x_{i}^{*})\right)\ ,
$$

###### Proof.

See page 93 Example 3.25 in [^12] and [^38]. If $f$ is a regular convex function (lower semi-continuous convex function), then $f^{**}=f$ according to page 135 Exercise 11.2.3 in [^39]. If $f$ is lower semi-continuous and convex, then $f^{**}=f$ according to Theorem 13.37 (Fenchel-Moreau) in [^11]. The log-sum-exponential is continuous and convex. ∎

###### Lemma A29.

Let $\bm{X}\bm{X}^{T}$ be non-singular and $X$ a Hilbert space. We define

$$
\displaystyle X^{*}\ =\ \left\{\bm{a}\mid 0\ \leqslant\ \bm{X}^{T}\left(\bm{X}\bm{X}^{T}\right)^{-1}\bm{a}\ ,\ \ \bm{1}^{T}\bm{X}^{T}\left(\bm{X}\bm{X}^{T}\right)^{-1}\bm{a}\ =\ 1\right\}\ .
$$

and

$$
\displaystyle X^{v}\ =\ \left\{\bm{a}\mid\bm{a}=\bm{X}^{T}\bm{\xi}\ ,\ \ \bm{\xi}\in X\right\}\ .
$$

The Legendre transform of $\mathrm{lse}(\beta,\bm{X}^{T}\bm{\xi})$ with $\bm{\xi}\in X$ is

$$
\displaystyle\left(\mathrm{lse}(\beta,\bm{X}^{T}\bm{\xi})\right)^{*}(\bm{\xi}^{*})\
$$
 
$$
\displaystyle=\ \left(\mathrm{lse}(\beta,\bm{v})\right)^{*}\left(\bm{X}^{T}\left(\bm{X}\bm{X}^{T}\right)^{-1}\bm{\xi}^{*}\right)\ ,
$$

with $\bm{\xi}^{*}\in X^{*}$ and $\bm{v}\in X^{v}$. The domain of $\left(\mathrm{lse}(\beta,\bm{X}^{T}\bm{\xi})\right)^{*}$ is $X^{*}$.

Furthermore we have

$$
\displaystyle\left(\mathrm{lse}(\beta,\bm{X}^{T}\bm{\xi})\right)^{**}\
$$
 
$$
\displaystyle=\ \mathrm{lse}(\beta,\bm{X}^{T}\bm{\xi})\ .
$$

###### Proof.

We use the definition of the Legendre transform:

$$
\displaystyle\left(\mathrm{lse}(\beta,\bm{X}^{T}\bm{\xi})\right)^{*}(\bm{\xi}^{*})\ =\ \sup_{\bm{\xi}\in X}\bm{\xi}^{T}\bm{\xi}^{*}\ -\ \mathrm{lse}(\beta,\bm{X}^{T}\bm{\xi})
$$
 
$$
\displaystyle=\ \sup_{\bm{\xi}\in X}\left(\bm{X}^{T}\bm{\xi}\right)^{T}\bm{X}^{T}\left(\bm{X}\bm{X}^{T}\right)^{-1}\bm{\xi}^{*}\ -\ \mathrm{lse}(\beta,\bm{X}^{T}\bm{\xi})
$$
 
$$
\displaystyle=\ \sup_{\bm{v}\in X^{v}}\bm{v}^{T}\bm{X}^{T}\left(\bm{X}\bm{X}^{T}\right)^{-1}\bm{\xi}^{*}\ -\ \mathrm{lse}(\beta,\bm{v})
$$
 
$$
\displaystyle=\ \sup_{\bm{v}\in X^{v}}\bm{v}^{T}\bm{v}^{*}\ -\ \mathrm{lse}(\beta,\bm{v})
$$
 
$$
\displaystyle=\ \left(\mathrm{lse}(\beta,\bm{v})\right)^{*}(\bm{v}^{*})\ =\ \left(\mathrm{lse}(\beta,\bm{v})\right)^{*}\left(\bm{X}^{T}\left(\bm{X}\bm{X}^{T}\right)^{-1}\bm{\xi}^{*}\right)\ ,
$$

where we used $\bm{v}^{*}=\bm{X}^{T}\left(\bm{X}\bm{X}^{T}\right)^{-1}\bm{\xi}^{*}$.

According to page 93 Example 3.25 in [^12], the equations for the maximum $\max_{\bm{v}\in X^{v}}\bm{v}^{T}\bm{v}^{*}\ -\ \mathrm{lse}(\beta,\bm{v})$ are solvable if and only if $0<\bm{v}^{*}=\bm{X}^{T}\left(\bm{X}\bm{X}^{T}\right)^{-1}\bm{\xi}^{*}$ and $\bm{1}^{T}\bm{v}^{*}=\bm{1}^{T}\bm{X}^{T}\left(\bm{X}\bm{X}^{T}\right)^{-1}\bm{\xi}^{*}=1$. Therefore, we assumed $\bm{\xi}^{*}\in X^{*}$.

The domain of $\left(\mathrm{lse}(\beta,\bm{X}^{T}\bm{\xi})\right)^{*}$ is $X^{*}$, since on page 93 Example 3.25 in [^12] it was shown that outside $X^{*}$ the $\sup_{\bm{v}\in X^{v}}\bm{v}^{T}\bm{v}^{*}\ -\ \mathrm{lse}(\beta,\bm{v})$ is not bounded.

Using

$$
\displaystyle\bm{p}\
$$
 
$$
\displaystyle=\ \mathrm{softmax}(\beta\bm{X}^{T}\bm{\xi})\ ,
$$

the Hessian of $\mathrm{lse}(\beta,\bm{X}^{T}\bm{\xi})$

$$
\displaystyle\frac{\partial^{2}\mathrm{lse}(\beta,\bm{X}^{T}\bm{\xi})}{\partial\bm{\xi}^{2}}\
$$
 
$$
\displaystyle=\ \beta\ \bm{X}\left(\mathrm{diag}(\bm{p})-\bm{p}\bm{p}^{T}\right)\bm{X}^{T}
$$

is positive semi-definite since $\mathrm{diag}(\bm{p})-\bm{p}\bm{p}^{T}$ is positive semi-definite according to Lemma A22. Therefore, $\mathrm{lse}(\beta,\bm{X}^{T}\bm{\xi})$ is convex and continuous.

If $f$ is a regular convex function (lower semi-continuous convex function), then $f^{**}=f$ according to page 135 Exercise 11.2.3 in [^39]. If $f$ is lower semi-continuous and convex, then $f^{**}=f$ according to Theorem 13.37 (Fenchel-Moreau) in [^11]. Consequently we have

$$
\displaystyle\left(\mathrm{lse}(\beta,\bm{X}^{T}\bm{\xi})\right)^{**}\
$$
 
$$
\displaystyle=\ \mathrm{lse}(\beta,\bm{X}^{T}\bm{\xi})\ .
$$

∎

We introduce the Lambert $W$ function and some of its properties, since it is needed to derive bounds on the storage capacity of our new Hopfield networks.

###### Definition A6 (Lambert Function).

The Lambert $W$ function [^72] is the inverse function of

$$
\displaystyle f(y)\
$$
 
$$
\displaystyle=\ ye^{y}\ .
$$

The Lambert $W$ function has an upper branch $W_{0}$ for $-1\leqslant y$ and a lower branch $W_{-1}$ for $y\leqslant-1$. We use $W$ if a formula holds for both branches. We have

$$
\displaystyle W(x)\
$$
 
$$
\displaystyle=\ y\ \Rightarrow ye^{y}\ =\ x\ .
$$

We present some identities for the Lambert $W$ function [^72]:

###### Lemma A30.

Identities for the Lambert $W$ function are

$$
\displaystyle W(x)\ e^{W(x)}\
$$
 
$$
\displaystyle=\ x\ ,
$$
$$
\displaystyle W(xe^{x})\
$$
 
$$
\displaystyle=\ x\ ,
$$
$$
\displaystyle e^{W(x)}\
$$
 
$$
\displaystyle=\ \frac{x}{W(x)}\ ,
$$
$$
\displaystyle e^{-W(x)}\
$$
 
$$
\displaystyle=\ \frac{W(x)}{x}\ ,
$$
$$
\displaystyle e^{nW(x)}\
$$
 
$$
\displaystyle=\ \left(\frac{x}{W(x)}\right)^{n}\ ,
$$
$$
\displaystyle W_{0}\left(x\ \ln x\right)\
$$
 
$$
\displaystyle=\ \ln x\quad\text{for }\ x\ \geq\ \frac{1}{e}\ ,
$$
$$
\displaystyle W_{-1}\left(x\ \ln x\right)\
$$
 
$$
\displaystyle=\ \ln x\quad\text{for }\ x\ \leqslant\ \frac{1}{e}\ ,
$$
$$
\displaystyle W(x)\
$$
 
$$
\displaystyle=\ \ln\frac{x}{W(x)}\quad\text{for }\ x\ \geq\ -\ \frac{1}{e}\ ,
$$
$$
\displaystyle W\left(\frac{n\ x^{n}}{W\left(x\right)^{n-1}}\right)\
$$
 
$$
\displaystyle=\ n\ W(x)\quad\text{for }\ n,x\ >\ 0\ ,
$$
$$
\displaystyle W(x)\ +\ W(y)\
$$
 
$$
\displaystyle=\ W\left(x\ y\ \left(\frac{1}{W(x)}\ +\ \frac{1}{W(y)}\right)\right)\quad\text{for }\ x,y\ >\ 0\ ,
$$
$$
\displaystyle W_{0}\left(-\ \frac{\ln x}{x}\right)\
$$
 
$$
\displaystyle=\ -\ \ln x\quad\text{for }\ 0\ <\ x\ \leqslant\ e\ ,
$$
$$
\displaystyle W_{-1}\left(-\ \frac{\ln x}{x}\right)\
$$
 
$$
\displaystyle=\ -\ \ln x\quad\text{for }\ x\ >\ e\ ,
$$
$$
\displaystyle e^{-\ W(-\ \ln x)}\
$$
 
$$
\displaystyle=\ \frac{W(-\ \ln x)}{-\ \ln x}\quad\text{for }\ x\ \neq\ 1\ .
$$

We also present some special values for the Lambert $W$ function [^72]:

###### Lemma A31.

$$
\displaystyle W(0)\
$$
 
$$
\displaystyle=\ 0\ ,
$$
$$
\displaystyle W(e)\
$$
 
$$
\displaystyle=\ 1\ ,
$$
$$
\displaystyle W\left(-\frac{1}{e}\right)\
$$
 
$$
\displaystyle=\ -1\ ,
$$
$$
\displaystyle W\left(e^{1+e}\right)\
$$
 
$$
\displaystyle=\ e\ ,
$$
$$
\displaystyle W\left(2\ln 2\right)\
$$
 
$$
\displaystyle=\ \ln 2\ ,
$$
$$
\displaystyle W(1)\
$$
 
$$
\displaystyle=\ \Omega\ ,
$$
$$
\displaystyle W(1)\
$$
 
$$
\displaystyle=\ e^{-W(1)}\ =\ \ln\left(\frac{1}{W(1)}\right)\ =\ -\ \ln W(1)\ ,
$$
$$
\displaystyle W\left(-\frac{\pi}{2}\right)\
$$
 
$$
\displaystyle=\ \frac{i\pi}{2}\ ,
$$
$$
\displaystyle W(-1)\
$$
 
$$
\displaystyle\approx\ -0.31813+1.33723i\ ,
$$

where the Omega constant $\Omega$ is

$$
\displaystyle\Omega\
$$
 
$$
\displaystyle=\ \left(\int_{-\infty}^{\infty}\frac{\mathrm{d}t}{\left(e^{t}\ -\ t\right)^{2}\ +\ \pi^{2}}\right)^{-1}\ -\ 1\ \approx\ 0.56714329\ .
$$

We need in some proofs a version of the mean value theorem as given in the next lemma.

###### Lemma A32 (Mean Value Theorem).

Let $U\subset\mathbb{R}^{n}$ be open, $f:U\to\mathbb{R}^{m}$ continuously differentiable, and $\bm{x}\in U$ as well as $\bm{h}\in\mathbb{R}^{n}$ vectors such that the line segment $\bm{x}+t\bm{h}$ for $0\leqslant t\leqslant 1$ is in $U$. Then the following holds:

$$
\displaystyle f(\bm{x}\ +\ \bm{h})\ -\ f(\bm{x})\
$$
 
$$
\displaystyle=\ \left(\int_{0}^{1}J(\bm{x}\ +\ t\ \bm{h})\ \mathrm{d}t\right)\ \bm{h}\ ,
$$

where $J$ is the Jacobian of $f$ and the integral of the matrix is component-wise.

###### Proof.

Let $f_{1},\ldots,f_{m}$ denote the components of $f$ and define $g_{i}:[0,1]\to\mathbb{R}$ by

$$
\displaystyle g_{i}(t)\
$$
 
$$
\displaystyle=\ f_{i}(\bm{x}\ +\ t\ \bm{h})\ ,
$$

then we obtain

$$
\displaystyle f_{i}(\bm{x}\ +\ \bm{h})\ -\ f_{i}(\bm{x})\ =\ g_{i}(1)\ -\ g_{i}(0)\ =\ \int_{0}^{1}g^{\prime}(t)\ \mathrm{d}t
$$
 
$$
\displaystyle\int_{0}^{1}\left(\sum_{j=1}^{n}\frac{\partial f_{i}}{\partial x_{j}}(\bm{x}\ +\ t\ \bm{h})\ h_{j}\right)\ \mathrm{d}t\ =\ \sum_{j=1}^{n}\left(\int_{0}^{1}\frac{\partial f_{i}}{\partial x_{j}}(\bm{x}\ +\ t\ \bm{h})\ \mathrm{d}t\right)\ h_{j}\ .
$$

The statement follows since the Jacobian $J$ has as entries $\frac{\partial f_{i}}{\partial x_{j}}$. ∎

### A.3 Modern Hopfield Networks: Binary States (Krotov and Hopfield)

#### A.3.1 Modern Hopfield Networks: Introduction

##### A.3.1.1 Additional Memory and Attention for Neural Networks.

Modern Hopfield networks may serve as additional memory for neural networks. Different approaches have been suggested to equip neural networks with an additional memory beyond recurrent connections. The neural Turing machine (NTM) is a neural network equipped with an external memory and an attention process [^41]. The NTM can write to the memory and can read from it. A memory network [^104] consists of a memory together with the components: (1) input feature map (converts the incoming input to the internal feature representation) (2) generalization (updates old memories given the new input), (3) output feature map (produces a new output), (4) response (converts the output into the response format). Memory networks are generalized to an end-to-end trained model, where the $\arg\max$ memory call is replaced by a differentiable $\mathrm{softmax}$ [^88] [^89]. Linear Memory Network use a linear autoencoder for sequences as a memory [^20].

To enhance RNNs with additional associative memory like Hopfield networks have been proposed [^6] [^7]. The associative memory stores hidden states of the RNN, retrieves stored states if they are similar to actual ones, and has a forgetting parameter. The forgetting and storing parameters of the RNN associative memory have been generalized to learned matrices [^118]. LSTMs with associative memory via Holographic Reduced Representations have been proposed [^28].

Recently most approaches to new memories are based on attention. The neural Turing machine (NTM) is equipped with an external memory and an attention process [^41]. End to end memory networks (EMN) make the attention scheme of memory networks [^104] differentiable by replacing $\arg\max$ through a $\mathrm{softmax}$ [^88] [^89]. EMN with dot products became very popular and implement a key-value attention [^29] for self-attention. An enhancement of EMN is the transformer [^96] [^97] and its extensions [^30]. The transformer had great impact on the natural language processing (NLP) community as new records in NLP benchmarks have been achieved [^96] [^97]. MEMO uses the transformer attention mechanism for reasoning over longer distances [^9]. Current state-of-the-art for language processing is a transformer architecture called “the Bidirectional Encoder Representations from Transformers” (BERT) [^32] [^33].

##### A.3.1.2 Modern Hopfield networks: Overview.

The storage capacity of classical binary Hopfield networks [^47] has been shown to be very limited. In a $d$ -dimensional space, the standard Hopfield model can store $d$ uncorrelated patterns without errors but only $Cd/\ln(d)$ random patterns with $C<1/2$ for a fixed stable pattern or $C<1/4$ if all patterns are stable [^70]. The same bound holds for nonlinear learning rules [^69]. Using tricks-of-trade and allowing small retrieval errors, the storage capacity is about $0.138d$ [^27] [^43] [^95]. If the learning rule is not related to the Hebb rule then up to $d$ patterns can be stored [^1]. Using Hopfield networks with non-zero diagonal matrices, the storage can be increased to $Cd\ln(d)$ [^37]. In contrast to the storage capacity, the number of energy minima (spurious states, stable states) of Hopfield networks is exponentially in $d$ [^91] [^15] [^100].

Recent advances in the field of binary Hopfield networks [^47] led to new properties of Hopfield networks. The stability of spurious states or metastable states was sensibly reduced by a Hamiltonian treatment for the new relativistic Hopfield model [^10]. Recently the storage capacity of Hopfield networks could be increased by new energy functions. Interaction functions of the form $F(x)=x^{n}$ lead to storage capacity of $\alpha_{n}d^{n-1}$, where $\alpha_{n}$ depends on the allowed error probability [^59] [^60] [^31] (see [^60] for the non-binary case). Interaction functions of the form $F(x)=x^{n}$ lead to storage capacity of $\alpha_{n}\frac{d^{n-1}}{c_{n}\ln d}$ for $c_{n}>2(2n-3)!!$ [^31].

Interaction functions of the form $F(x)=\exp(x)$ lead to exponential storage capacity of $2^{d/2}$ where all stored patterns are fixed points but the radius of attraction vanishes [^31]. It has been shown that the network converges with high probability after one update [^31].

#### A.3.2 Energy and Update Rule for Binary Modern Hopfield Networks

We follow [^31] where the goal is to store a set of input data $\bm{x}_{1},\ldots,\bm{x}_{N}$ that are represented by the matrix

$$
\displaystyle\bm{X}\
$$
 
$$
\displaystyle=\ \left(\bm{x}_{1},\ldots,\bm{x}_{N}\right)\ .
$$

The $\bm{x}_{i}$ is pattern with binary components $x_{ij}\in\{-1,+1\}$ for all $i$ and $j$. $\bm{\xi}$ is the actual state of the units of the Hopfield model. Krotov and Hopfield [^59] defined the energy function $\mathrm{E}$ with the interaction function $F$ that evaluates the dot product between patterns $\bm{x}_{i}$ and the actual state $\bm{\xi}$:

$$
\displaystyle\mathrm{E}\
$$
 
$$
\displaystyle=\ -\ \sum_{i=1}^{N}F\left(\bm{\xi}^{T}\bm{x}_{i}\right)
$$

with $F(a)=a^{n}$, where $n=2$ gives the energy function of the classical Hopfield network. This allows to store $\alpha_{n}d^{n-1}$ patterns [^59]. Krotov and Hopfield [^59] suggested for minimizing this energy an asynchronous updating dynamics $T=(T_{j})$ for component $\xi_{j}$:

$$
\displaystyle T_{j}(\bm{\xi})\
$$
 
$$
\displaystyle:=\ \mathop{\mathrm{sgn}\,}\Bigl[\sum\limits_{i=1}^{N}\bigl(F\bigl(x_{ij}\ +\ \sum\limits_{l\neq j}x_{il}\ \xi_{l}\bigr)\ -\ F\bigl(-\ x_{ij}\ +\ \sum\limits_{l\neq j}x_{il}\ \xi_{l}\bigr)\bigr)\Bigr]
$$

While Krotov and Hopfield used $F(a)=a^{n}$, Demircigil et al. [^31] went a step further and analyzed the model with the energy function $F(a)=\exp(a)$, which leads to an exponential storage capacity of $N=2^{d/2}$. Furthermore with a single update the final pattern is recovered with high probability. These statements are given in next theorem.

###### Theorem A10 (Storage Capacity for Binary Modern Hopfield Nets (Demircigil et al. 2017)).

Consider the generalized Hopfield model with the dynamics described in Eq. (545) and interaction function $F$ given by $F(x)=e^{x}$. For a fixed $0<\alpha<\ln(2)/2$ let $N=\exp\left(\alpha d\right)+1$ and let $\bm{x}_{1},\ldots,\bm{x}_{N}$ be $N$ patterns chosen uniformly at random from $\{-1,+1\}^{d}$. Moreover fix $\varrho\in[0,1/2)$. For any $i$ and any $\widetilde{\bm{x}}_{i}$ taken uniformly at random from the Hamming sphere with radius $\varrho d$ centered in $\bm{x}_{i}$, $\mathcal{S}(\bm{x}_{i},\varrho d)$, where $\varrho d$ is assumed to be an integer, it holds that

$$
\displaystyle\mathbf{\mathrm{Pr}}\left(\exists i\;\exists j:\ T_{j}\left(\widetilde{\bm{x}}_{i}\right)\ \neq\ x_{ij}\right)\ \rightarrow\ 0\ ,
$$

if $\alpha$ is chosen in dependence of $\varrho$ such that

$$
\displaystyle\alpha\ <\ \frac{I(1-2\varrho)}{2}
$$

with

$$
\displaystyle I:\ a\ \mapsto\ \frac{1}{2}\left((1+a)\ln(1+a)\ +\ (1-a)\ln(1-a)\right)\ .
$$

###### Proof.

The proof can be found in [^31]. ∎

The number of patterns $N=\exp\left(\alpha d\right)+1$ is exponential in the number $d$ of components. The result

$$
\displaystyle\mathbf{\mathrm{Pr}}\left(\exists i\;\exists j:\ T_{j}\left(\widetilde{\bm{x}}_{i}\right)\ \neq\ x_{ij}\right)\ \rightarrow\ 0
$$

means that one update for each component is sufficient to recover the pattern with high probability. The constraint $\alpha<\frac{I(1-2\varrho)}{2}$ on $\alpha$ gives the trade-off between the radius of attraction $\varrho d$ and the number $N=\exp\left(\alpha d\right)+1$ of pattern that can be stored.

Theorem A10 in particular implies that

$$
\displaystyle\mathbf{\mathrm{Pr}}\left(\exists i\;\exists j:\ T_{j}\left(\bm{x}_{i}\right)\ \neq\ x_{ij}\right)\ \rightarrow\ 0
$$

as $d\rightarrow\infty$, i.e. with a probability converging to $1$, all the patterns are fixed points of the dynamics. In this case we can have $\alpha\to\frac{I(1)}{2}=\ln(2)/2$.

Krotov and Hopfield define the update dynamics $T_{j}(\bm{\xi})$ in Eq. (545) via energy differences of the energy in Eq. (544). First we express the energy in Eq. (544) with $F(a)=\exp(a)$ [^31] by the $\mathrm{lse}$ function. Then we use the mean value theorem to express the update dynamics $T_{j}(\bm{\xi})$ in Eq. (545) by the softmax function. For simplicity, we set $\beta=1$ in the following. There exists a $v\in[-1,1]$ with

$$
\displaystyle T_{j}(\bm{\xi})\
$$
 
$$
\displaystyle=\ \mathop{\mathrm{sgn}\,}\Bigl[-\ \mathrm{E}(\xi_{j}=1)\ +\ \mathrm{E}(\xi_{j}=-1)\Bigr]\ =\ \mathop{\mathrm{sgn}\,}\Bigl[\exp(\mathrm{lse}(\xi_{j}=1))\ -\ \exp(\mathrm{lse}(\xi_{j}=-1))\Bigr]
$$
 
$$
\displaystyle=\ \mathop{\mathrm{sgn}\,}\Bigl[-\ (2\bm{e}_{j})^{T}\nabla_{\bm{\xi}}\mathrm{E}(\xi_{j}=v)\Bigr]\ =\ \mathop{\mathrm{sgn}\,}\Bigl[\exp(\mathrm{lse}(\xi_{j}=v))\ (2\bm{e}_{j})^{T}\frac{\mathrm{lse}(\xi_{j}=v)}{\partial\bm{\xi}}\Bigr]
$$
 
$$
\displaystyle=\ \mathop{\mathrm{sgn}\,}\Bigl[\exp(\mathrm{lse}(\xi_{j}=1))\ (2\bm{e}_{j})^{T}\bm{X}\mathrm{softmax}(\bm{X}^{T}\bm{\xi}(\xi_{j}=v))\Bigr]
$$
 
$$
\displaystyle=\ \mathop{\mathrm{sgn}\,}\Bigl[[\bm{X}\mathrm{softmax}(\bm{X}^{T}\bm{\xi}(\xi_{j}=v))]_{j}\Bigr]\ =\ \mathop{\mathrm{sgn}\,}\Bigl[[\bm{X}\bm{p}(\xi_{j}=v)]_{j}\Bigr]\ ,
$$

where $\bm{e}_{j}$ is the Cartesian unit vector with a one at position $j$ and zeros elsewhere, $[.]_{j}$ is the projection to the $j$ -th component, and

$$
\displaystyle\bm{p}\
$$
 
$$
\displaystyle=\ \mathrm{softmax}(\bm{X}^{T}\bm{\xi})\ .
$$

### A.4 Hopfield Update Rule is Attention of The Transformer

The Hopfield network update rule is the attention mechanism used in transformer and BERT models (see Fig. A.2). To see this, we assume $N$ stored (key) patterns $\bm{y}_{i}$ and $S$ state (query) patterns $\bm{r}_{i}$ that are mapped to the Hopfield space of dimension $d_{k}$. We set $\bm{x}_{i}=\bm{W}_{K}^{T}\bm{y}_{i}$, $\bm{\xi}_{i}=\bm{W}_{Q}^{T}\bm{r}_{i}$, and multiply the result of our update rule with $\bm{W}_{V}$. The matrices $\bm{Y}=(\bm{y}_{1},\ldots,\bm{y}_{N})^{T}$ and $\bm{R}=(\bm{r}_{1},\ldots,\bm{r}_{S})^{T}$ combine the $\bm{y}_{i}$ and $\bm{r}_{i}$ as row vectors. We define the matrices $\bm{X}^{T}=\bm{K}=\bm{Y}\bm{W}_{K}$, $\bm{\Xi}^{T}=\bm{Q}=\bm{R}\bm{W}_{Q}$, and $\bm{V}=\bm{Y}\bm{W}_{K}\bm{W}_{V}=\bm{X}^{T}\bm{W}_{V}$, where $\bm{W}_{K}\in\mathbb{R}^{d_{y}\times d_{k}},\bm{W}_{Q}\in\mathbb{R}^{d_{r}\times d_{k}},\bm{W}_{V}\in\mathbb{R}^{d_{k}\times d_{v}}$. If $\beta=1/\sqrt{d_{k}}$ and $\mathrm{softmax}\in\mathbb{R}^{N}$ is changed to a row vector, we obtain for the update rule Eq. (3) multiplied by $\bm{W}_{V}$:

$$
\displaystyle\mathrm{softmax}\left(1/\sqrt{d_{k}}\ \bm{Q}\ \bm{K}^{T}\right)\ \bm{V}\ =\mathrm{softmax}\left(\beta\ \bm{R}\bm{W}_{\bm{Q}}\ \bm{W}_{\bm{K}}^{T}\bm{Y}^{T}\right)\ \bm{Y}\bm{W}_{\bm{K}}\bm{W}_{\bm{V}}\ .
$$

The left part of Eq. (548) is the transformer attention. Besides the attention mechanism, Hopfield networks allow for other functionalities in deep network architectures, which we introduce via specific layers in the next section. The right part of Eq. (548) serves as starting point for these specific layers.

![Refer to caption](https://ar5iv.labs.arxiv.org/html/2008.02217/assets/HopfieldToTransformerD.png)

Figure A.2: We generalized the energy of binary modern Hopfield networks for allowing continuous states while keeping fast convergence and storage capacity properties. We defined for the new energy also a new update rule that minimizes the energy. The new update rule is the attention mechanism of the transformer. Formulae are modified to express softmax \\mathrm{softmax} as row vector as for transformers. " = "-sign means "keeps the properties".

### A.5 Experiments

#### A.5.1 Experiment 1: Attention in Transformers described by Hopfield dynamics

##### A.5.1.1 Analysis of operating modes of the heads of a pre-trained BERT model.

We analyzed pre-trained BERT models from Hugging Face Inc. [^107] according to these operating classes. In Fig. A.3 in the appendix the distribution of the pre-trained bert-base-cased model is depicted (for other models see appendix Section A.5.1.4). Operating classes (II) (large metastable states) and (IV) (small metastable states) are often observed in the middle layers. Operating class (I) (averaging over a very large number of patterns) is abundant in lower layers. Similar observations have been reported in other studies [^93] [^94] [^92]. Operating class (III) (medium metastable states) is predominant in the last layers.

Figure A.3: Analysis of operating modes of the heads of a pre-trained BERT model. For each head in each layer, the distribution of the minimal number $k$ of patterns required to sum up the $\mathrm{softmax}$ values to $0.90$ is displayed as a violin plot in a panel. $k$ indicates the size of a metastable state. The bold number in the center of each panel gives the median $\bar{k}$ of the distribution. The heads in each layer are sorted according to $\bar{k}$. Attention heads belong to the class they mainly operate in. Class (IV) in blue: Small metastable state or fixed point close to a single pattern, which is abundant in the middle layers (6, 7, and 8). Class (II) in orange: Large metastable state, which is prominent in middle layers (3, 4, and 5). Class (I) in red: Very large metastable state or global fixed point, which is predominant in the first layer. These heads can potentially be replaced by averaging operations. Class (III) in green: Medium metastable state, which is frequently observed in higher layers. We hypothesize that these heads are used to collect information required to perform the respective task. These heads should be the main target to improve transformer and BERT models.

##### A.5.1.2 Experimental Setup.

Transformer architectures are known for their high computational demands. To investigate the learning dynamics of such a model and at the same time keeping training time manageable, we adopted the BERT-small setting from ELECTRA [^25]. It has $12$ layers, $4$ heads and a reduced hidden size, the sequence length is shortened from $512$ to $128$ tokens and the batch size is reduced from $256$ to $128$. Additionally, the hidden dimension is reduced from $768$ to $256$ and the embedding dimension is reduced from $768$ to $128$ [^25]. The training of such a BERT-small model for $1.45$ million update steps takes roughly four days on a single NVIDIA V100 GPU.

As the code base we use the transformers repository from Hugging Face, Inc [^107]. We aim to reproduce the dataset of [^33] as close as possible, which consists of the English Wikipedia dataset and the Toronto BookCorpus dataset [^119]. Due to recent copyright claims the later is not publicly available anymore. Therefore, the pre-training experiments use an uncased snapshot of the original BookCorpus dataset.

##### A.5.1.3 Hopfield Operating Classes of Transformer and BERT Models.

To better understand how operation modes in attention heads develop, we tracked the distribution of counts $k$ (see main paper) over time in a BERT-small model. At the end of training we visualized the count distribution, grouped into four classes (see Figure A.4). The thresholds for the classes were chosen according to the thresholds of Figure 2 in the main paper. However, they are divided by a factor of $4$ to adapt to the shorter sequence length of $128$ compared to $512$. From this plot it is clear, that the attention in heads of Class IV commit very early to the operating class of small metastable states.

##### A.5.1.4 Learning Dynamics of Transformer and BERT Models.

To observe this behavior in the early phase of training, we created a ridge plot of the distributions of counts $k$ for the first $20,000$ steps (see Figure A.5 (a)). This plot shows that the attention in heads of middle layers often change the operation mode to Class IV around $9,000$ to $10,000$ steps. At the same time the second big drop in the loss occurs. The question arises whether this is functionally important or whether it is an artefact which could be even harmful. To check if the attention mechanism is still able to learn after the change in the operation mode we analyzed the gradient flow through the $\mathrm{softmax}$ function. For every token we calculate the Frobenius norm of the Jacobian of the $\mathrm{softmax}$ over multiple samples. Then, for every head we plot the distribution of the norm (see Figure A.5(b)). The gradients with respect to the weights are determined by the Jacobian $\mathrm{J}$ defined in Eq. (59) as can be seen in Eq. (418), Eq. (429), and Eq. (435). We can see that the attention in heads of Class IV remain almost unchanged during the rest of the training.

![Refer to caption](https://ar5iv.labs.arxiv.org/html/2008.02217/assets/ridgeplots_full_and_violine.png)

Figure A.4: Left: Ridge plots of the distribution of counts k over time for BERT-small Right: Violin plot of counts after 1, 450000 1,450000 steps, divided into the four classes from the main paper. The thresholds were adapted to the shorter sequence length.

![Refer to caption](https://ar5iv.labs.arxiv.org/html/2008.02217/assets/ridgeplots_fine.png)

Figure A.5: (a): change of count density during training is depicted for the first 20,000 steps. (b): the corresponding distribution of the Frobenius norm of the Jacobian of the softmax \\mathrm{softmax} function is depicted. The gradients with respect to the weights are determined by the Jacobian J \\mathrm{J} defined in Eq. ( 59 ) as can be seen in Eq. ( 418 ), Eq. ( 429 ), and Eq. ( 435 ).

##### A.5.1.5 Attention Heads Replaced by Gaussian Averaging Layers.

The self-attention mechanism proposed in [^96] utilizes the $\mathrm{softmax}$ function to compute the coefficients of a convex combination over the embedded tokens, where the $\mathrm{softmax}$ is conditioned on the input. However, our analysis showed that especially in lower layers many heads perform averaging over a very large number of patterns. This suggests that at this level neither the dependency on the input nor a fine grained attention to individual positions is necessary. As an alternative to the original mechanism we propose Gaussian averaging heads which are computationally more efficient. Here, the $\mathrm{softmax}$ function is replaced by a discrete Gaussian kernel, where the location $\mu$ and the scale $\sigma$ are learned. In detail, for a sequence length of $N$ tokens we are given a vector of location parameters $\bm{\mu}=(\mu_{1},\ldots,\mu_{N})^{T}$ and a vector of corresponding scale parameters $\bm{\sigma}=(\sigma_{1},\ldots,\sigma_{N})^{T}$. We subdivide the interval $[-1,1]$ into $N$ equidistant supporting points $\{s_{j}\}_{j=1}^{N}$, where

$$
\displaystyle s_{j}=\frac{(j-1)-0.5~(N-1)}{0.5~(N-1)}.
$$

The attention $[A]_{i,j}$ from the $i$ -th token to the $j$ -th position is calculated as

$$
\displaystyle[A]_{i,j}=\frac{1}{z_{i}}\exp\left\{-\frac{1}{2}\big(\frac{s_{j}-\mu_{i}}{\sigma_{i}}\big)^{2}\right\},
$$

where $z_{i}$ normalizes the $i$ -th row of the attention matrix $A$ to sum up to one:

$$
\displaystyle z_{i}=\sum_{j=1}^{N}\exp\left\{-\frac{1}{2}\big(\frac{s_{j}-\mu_{i}}{\sigma_{i}}\big)^{2}\right\}.
$$

For initialization we uniformly sample a location vector $\bm{\mu}\in[-1,1]^{N}$ and a scale vector $\bm{\sigma}\in[0.75,1.25]^{N}$ per head. A simple way to consider the individual position of each token at initialization is to use the supporting points $\mu_{i}=s_{i}$ (see Figure A.6). In practice no difference to the random initialization was observed.

•Number of parameters. Gaussian averaging heads can reduce the number of parameters significantly. For an input size of $N$ tokens, there are $2\cdot N$ parameters per head. In contrast, a standard self-attention head with word embedding dimension $d_{y}$ and projection dimension $d_{k}$ has two weight matrices $W_{Q},W_{K}\in\mathbb{R}^{d_{k}\times d_{y}}$, which together amount to $2\cdot d_{k}\cdot d_{y}$ parameters. As a concrete example, the BERT-base model from [^33] has an embedding dimension $d_{y}=768$, a projection dimension $d_{k}=64$ and a sequence length of $N=512$. Compared to the Gaussian head, in this case $(2\cdot 768\cdot 64)/(2\cdot 512)~=95.5$ times more parameters are trained for the attention mechanism itself. Only for very long sequences (and given that the word embedding dimension stays the same) the dependence on $N$ may become a disadvantage. But of course, due to the independence from the input the Gaussian averaging head is less expressive in comparison to the original attention mechanism. A recently proposed input independent replacement for self-attention is the so called Random Synthesizer [^92]. Here the $\mathrm{softmax}$ -attention is directly parametrized with an $N\times N$ matrix. This amounts to $0.5\cdot N$ more parameters than Gaussian averaging.

Figure A.6: Attentions of a Gaussian averaging head at initialization for sequence length $N=128$. Every line depicts one Gaussian kernel. Here, the location parameters are initialized with the value of the supporting points $\mu_{i}=s_{i}$.

#### A.5.2 Experiment 2: Multiple Instance Learning Datasets.

##### A.5.2.1 Immune Repertoire Classification.

An architecture called DeepRC, is based on our modern Hopfield networks, for immune repertoire classification and compared to other machine learning approaches. For DeepRC, we consider immune repertoires as input objects, which are represented as bags of instances. In a bag, each instance is an immune receptor sequence and each bag can contain a large number of sequences. At its core, DeepRC consists of a modern Hopfield network that extracts information from each repertoire. The stored patterns (keys) are representations of the immune amino acid sequences (instances) that are obtained by an 1D convolutional network with position encoding. Each state pattern (query) is static and learned via backpropagation. For details see [^105] [^106].

Our new Hopfield network has been integrated into a deep learning architecture for immune repertoire classification, a massive multiple instance learning task [^105] [^106]. Theorem 3 states that modern Hopfield networks possess an exponential storage capacity which enables to tackle massive multiple instance learning (MIL) problems [^34]. Immune repertoire classification [^35] typically requires to extract few patterns from a large set of sequences, the repertoire, that are indicative for the respective immune status. Most MIL methods fail due the large number of instances.

Data is obtained by experimentally observed immune receptors as well as simulated sequences sequence motifs [^3] [^103] with low yet varying degrees of frequency are implanted. Four different categories of datasets are constructed: (a) Simulated immunosequencing data with implanted motifs, (b) immunosequencing data generated by long short-term memory (LSTM) with implanted motifs, (c) real-world immunosequencing data with implanted motifs, and (d) real-world immunosequencing data with known immune status [^35]. Categories (a), (b), and (d) contain approx. 300,000 instances per immune repertoire. With over 30 billion sequences in total, this represents one of the largest multiple instance learning experiments ever conducted [^17]. Despite the massive number of instances as well as the low frequency of sequences indicative of the respective immune status, deep learning architectures with modern Hopfield networks outperform all competing methods with respect to average area under the ROC curve in all four categories, (a), (b), (c) and (d) (for details see [^105]).

We evaluate and compare the performance of DeepRC to a set of machine learning methods that serve as baseline, were suggested, or can readily be adapted to immune repertoire classification. The methods comprise (i) known motif, which counts how often the known implanted motifs occur, (ii) Support Vector Machine (SVM) approach that uses a fixed mapping from a bag of sequences to the corresponding $k$ -mer counts and used the MinMax and Jaccard kernel, (iii) $k$ -Nearest Neighbor (KNN) with $k$ -mer representation, transforming MinMax and Jaccard kernel to distances, (iv) logistic regression on the $k$ -mer representation, (v) burden test that first identifies sequences or $k$ -mers and then computes a burden score per individual, and (vi) logistic multiple instance learning (lMIL). On the real-world dataset DeepRC achieved an AUC of $0.832\pm 0.022$, followed by the SVM with MinMax kernel (AUC $0.825\pm 0.022$) and the burden test with an AUC of $0.699\pm 0.041$. Overall on all datasets, DeepRC outperformed all competing methods with respect to average AUC (see [^105] [^106]).

Table A.1 reports the average performance in the simulated immunosequencing datasets (last column) and the performance on datasets of the remaining three categories. DeepRC outperforms all competing methods with respect to average AUC. Across categories, the runner-up methods are either the SVM for MIL problems with MinMax kernel or the burden test.

<table><tbody><tr><th></th><td>Real-world</td><td colspan="4">Real-world data with implanted signals</td><td colspan="5">LSTM-generated data</td><td>Simulated</td></tr><tr><th></th><td>CMV</td><td>OM 1%</td><td>OM 0.1%</td><td>MM 1%</td><td>MM 0.1%</td><td>10%</td><td>1%</td><td>0.5%</td><td>0.1%</td><td>0.05%</td><td>avg.</td></tr><tr><th>DeepRC</th><td>0.832 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.022</td><td>1.00 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.00</td><td>0.98 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.01</td><td>1.00 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.00</td><td>0.94 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.01</td><td>1.00 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.00</td><td>1.00 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.00</td><td>1.00 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.00</td><td>1.00 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.00</td><td>1.00 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.00</td><td>0.846 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.223</td></tr><tr><th>SVM (MM)</th><td>0.825 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.022</td><td>1.00 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.00</td><td>0.58 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.02</td><td>1.00 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.00</td><td>0.53 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.02</td><td>1.00 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.00</td><td>1.00 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.00</td><td>1.00 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.00</td><td>1.00 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.00</td><td>0.99 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.01</td><td>0.827 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.210</td></tr><tr><th>SVM (J)</th><td>0.546 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.021</td><td>0.99 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.00</td><td>0.53 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.02</td><td>1.00 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.00</td><td>0.57 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.02</td><td>0.98 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.04</td><td>1.00 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.00</td><td>1.00 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.00</td><td>0.90 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.04</td><td>0.77 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.07</td><td>0.550 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.080</td></tr><tr><th>KNN (MM)</th><td>0.679 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.076</td><td>0.74 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.24</td><td>0.49 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.03</td><td>0.67 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.18</td><td>0.50 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.02</td><td>0.70 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.27</td><td>0.72 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.26</td><td>0.73 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.26</td><td>0.54 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.16</td><td>0.52 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.15</td><td>0.634 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.129</td></tr><tr><th>KNN (J)</th><td>0.534 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.039</td><td>0.65 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.16</td><td>0.48 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.03</td><td>0.70 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.20</td><td>0.51 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.03</td><td>0.70 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.29</td><td>0.61 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.24</td><td>0.52 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.16</td><td>0.55 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.19</td><td>0.54 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.19</td><td>0.501 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.007</td></tr><tr><th>Log. regr.</th><td>0.607 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.058</td><td>1.00 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.00</td><td>0.54 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.04</td><td>0.99 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.00</td><td>0.51 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.04</td><td>1.00 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.00</td><td>1.00 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.00</td><td>0.93 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.15</td><td>0.60 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.19</td><td>0.43 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.16</td><td>0.826 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.211</td></tr><tr><th>Burden test</th><td>0.699 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.041</td><td>1.00 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.00</td><td>0.64 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.05</td><td>1.00 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.00</td><td>0.89 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.02</td><td>1.00 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.00</td><td>1.00 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.00</td><td>1.00 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.00</td><td>1.00 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.00</td><td>0.79 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.28</td><td>0.549 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.074</td></tr><tr><th>Log. MIL (KMER)</th><td>0.582 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.065</td><td>0.54 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.07</td><td>0.51 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.03</td><td>0.99 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.00</td><td>0.62 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.15</td><td>1.00 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.00</td><td>0.72 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.11</td><td>0.64 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.14</td><td>0.57 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.15</td><td>0.53 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.13</td><td>0.665 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.224</td></tr><tr><th>Log. MIL (TCRβ)</th><td>0.515 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.073</td><td>0.50 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.03</td><td>0.50 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.02</td><td>0.99 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.00</td><td>0.78 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.03</td><td>0.54 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.09</td><td>0.57 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.16</td><td>0.47 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.09</td><td>0.51 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.07</td><td>0.50 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.12</td><td>0.501 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.016</td></tr><tr><th>Known motif b.</th><td>–</td><td>1.00 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.00</td><td>0.70 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.03</td><td>0.99 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.00</td><td>0.62 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.04</td><td>1.00 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.00</td><td>1.00 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.00</td><td>1.00 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.00</td><td>1.00 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.00</td><td>1.00 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.00</td><td>0.890 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.168</td></tr><tr><th>Known motif c.</th><td>–</td><td>0.92 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.00</td><td>0.56 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.03</td><td>0.65 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.03</td><td>0.52 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.03</td><td>1.00 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.00</td><td>1.00 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.00</td><td>0.99 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.01</td><td>0.72 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.09</td><td>0.63 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.09</td><td>0.738 <math><semantics><mo>±</mo> <annotation>\pm</annotation></semantics></math> 0.202</td></tr></tbody></table>

Table A.1: Results immune repertoire classification across all datasets. Results are given in terms of AUC of the competing methods on all datasets. The reported errors are standard deviations across $5$ cross-validation (CV) folds (except for the column “Simulated”). Real-world CMV: Average performance over $5$ CV folds on the *cytomegalovirus (CMV) dataset* [^35]. Real-world data with implanted signals: Average performance over $5$ CV folds for each of the four datasets. A signal was implanted with a frequency (=wittness rate) of $1\%$ or $0.1\%$. Either a single motif (“OM”) or multiple motifs (“MM”) were implanted. LSTM-generated data: Average performance over $5$ CV folds for each of the $5$ datasets. In each dataset, a signal was implanted with a frequency of $10\%$, $1\%$, $0.5\%$, $0.1\%$, and $0.05\%$, respectively. Simulated: Here we report the mean over 18 simulated datasets with implanted signals and varying difficulties. The error reported is the standard deviation of the AUC values across the 18 datasets.

##### A.5.2.2 Multiple Instance Learning Benchmark Datasets.

Classical benchmarking datasets comprise UCSB breast cancer classification [^52], and the Elephant, Fox, Tiger datasets [^5].

Elephant, Fox and Tiger are MIL datasets for image annotation which comprise color images from the Corel dataset that have been preprocessed and segmented. An image consists of a set of segments (or blobs), each characterized by color, texture and shape descriptors. The datasets have 100 positive and 100 negative example images. The latter have been randomly drawn from a pool of photos of other animals. Elephant has 1391 instances and 230 features. Fox has 1320 instances and 230 features. Tiger has 1220 instances and 230 features. Furthermore, we use the UCSB breast cancer classification [^52] dataset, which consists of 2,002 instances across 58 input objects. An instance represents a patch of a histopathological image of cancerous or normal tissue. The layer HopfieldPooling is used, which allows for computing a per-input-object representation by extracting an average of instances that are indicative for one of the two classes. The input to the HopfieldPooling layer is a set of embedded instances $\bm{Y}$ and a trainable but fixed state (query) pattern $\bm{Q}$ used for averaging of class-indicative instances. This averaging enables a compression of variable-sized bags to a fixed-sized representation to discriminate the bags. We performed a manual hyperparameter search on a validation set. In detail, we used the following architecture to perform the given task on the Elephant, Fox, Tiger and UCSCB breast cancer datasets: (I) we apply fully connected linear embedding layers with ReLU activation. (II) The output of this embedding serves as the input to our HopfieldPooling layer where the above described pooling operation is performed. (III) Thereafter we use ’ReLU - Linear blocks’ as the final linear output layers that perform the classification. Among other hyperparameters, different hidden layer widths (for the fully connected pre- and post-HopfieldPooling layers), learning rates and batch sizes were tried. Additionally our focus resided on the hyperparameters of the HopfieldPooling layer. Among those were the number of heads, the head dimension and the scaling factor β.

| parameter | values |
| --- | --- |
| learning rates | $\{10^{-3}$, $10^{-5}\}$ |
| learning rate decay (γ) | $\{0.98,0.96,0.94\}$ |
| embedding layers | $\{1,2,3\}$ |
| layer widths | $\{32,64,256,1024,2048\}$ |
| number of heads | $\{8,12,16,32\}$ |
| head dimensions | $\{16,32,64\}$ |
| scaling factors | $\{0.1,1.0,10.0\}$ |
| hidden dimensions | $\{32,64,128\}$ |
| bag dropout | $\{0.0,0.75\}$ |

Table A.2: Hyperparameter search-space of a manual hyperparameter selection on the respective validation sets of the Elephant, Fox, Tiger and UCSB breast cancer datasets.

All models were trained for 160 epochs using the AdamW optimizer [^66] with exponential learning rate decay (see Table A.2), and validated by 10-fold nested cross validation repeated five times with different splits on the data sets. The reported ROC AUC scores are the average of these repetitions. As overfitting imposed quite a problem, bag dropout was applied as the regularization technique of choice.

#### A.5.3 Experiment 3: Classification on Small UCI Benchmark Datasets

##### A.5.3.1 Motivation.

Datasets with a small number of samples, like the UCI benchmark datasets, are particularly difficult for neural networks to generalize on. In contrast to their performance on larger datasets, they are consistently outperformed by methods like e.g. gradient boosting, random forests (RF) and support vector machines (SVMs). Finding samples or even learning prototypes that are highly indicative for the class of a sample (query) suggest the use of Hopfield networks. We applied a modern Hopfield network via the layer Hopfield. The input vector is mapped to $\bm{R}$ using a self-normalizing net (SNN) and $\bm{W}_{K}$ is learned, where the dimension of $\bm{W}_{K}$ (the number of stored fixed pattern) is a hyperparameter. The output $\bm{Z}$ of Hopfield enters the output layer.

##### A.5.3.2 Methods compared.

Modern Hopfield networks via the layer Hopfield are compared to 17 groups of methods [^36] [^55]:

1. Support Vector Machines
2. Random Forest
3. Multivariate adaptive regression splines (MARS)
4. Boosting
5. Rule-based Methods
6. Logistic and Multinomial Regression (LMR)
7. Discriminant Analysis (DA)
8. Bagging
9. Nearest Neighbor
10. Decision Trees
11. Other Ensembles
12. Neural Networks (standard NN, BatchNorm, WeighNorm, MSRAinit, LayerNorm, ResNet, Self-Normalizing Nets)
13. Bayesian Methods
14. Other Methods
15. Generalized linear models (GLM)
16. Partial Least Squares and Principal Component Regression (PLSR)
17. Stacking (Wolpert)

##### A.5.3.3 Experimental design and implementation details.

As specified in the main paper, we consider $75$ datasets of the UC Irvine Machine Learning Repository, which contain less than $1,000$ samples per dataset, following the dataset separation into large and small dataset in [^55]. On each dataset, we performed a grid-search to determine the best hyperparameter setting and model per dataset. The hyperparameter search-space of the grid-search is listed in Table A.3. All models were trained for $100$ epochs with a mini-batch size of $4$ samples using the cross entropy loss and the PyTorch SGD module for stochastic gradient descent without momentum and without weight decay or dropout. After each epoch, the model accuracy was computed on a separated validation set. Using early stopping, the model with the best validation set accuracy averaged over $16$ consecutive epochs was selected as final model. This final model was then evaluated against a separated test set to determine the accuracy, as reported in Tables 2 and Table [uci\_detailed\_results.csv](https://ar5iv.labs.arxiv.org/html/uci_detailed_results.csv) in the supplemental materials.

As network architecture, we use $\{0,1,7\}$ fully connected embedding layers with SELU [^55] activation functions and $\{32,128,1024\}$ hidden units per embedding layer. These embedding layers are followed by the layer Hopfield. The number of hidden units is also used as number of dimensions for the Hopfield association space with a number of $\{1,32\}$ heads. The layer Hopfield is followed by a mapping to the output vector, which has as dimension the number of classes. Finally, the softmax function is applied to obtain the predicted probability for a class.

| parameter | values |
| --- | --- |
| learning rates | $\{0.05\}$ |
| embedding layers | $\{0,1,7\}$ |
| hidden units | $\{32,128,1024\}$ |
| heads | $\{1,32\}$ |
| $\beta$ | $\{1.0,0.1,0.001\}$ |
| \# stored patterns | $\{1,8\}\cdot n\_classes$ |

Table A.3: Hyperparameter search-space for grid-search on small UCI benchmark datasets. All models were trained for $100$ epochs using stochastic gradient descent with early stopping based on the validation set accuracy and a minibatch size of $4$ samples. The number of stored patterns is depending on the number of target classes of the individual tasks.

##### A.5.3.4 Results.

We compared the performance of 25 methods based on their method rank. For this we computed the rank per method per dataset based on the accuracy on the test set, which was then averaged over all 75 datasets for each method to obtain the method rank. For the baseline methods we used the scores summarized by [^55].

#### A.5.4 Experiment 4: Drug Design Benchmark Datasets

##### A.5.4.1 Experimental design and implementation details.

We test Hopfield layers on 4 classification datasets from MoleculeNet [^110], which are challenging for deep learning methods. The first dataset is HIV, which was introduced by the Drug Therapeutics Program (DTP) AIDS Antiviral Screen. The second dataset is BACE, which has IC50 measurements for binding affinities of inhibitors (molecules) to the human $\beta$ -secretase 1 (BACE-1). The third dataset is BBBP (blood-brain barrier permeability), which stems from modeling and predicting the blood-brain barrier permeability [^68]. The fourth dataset is SIDER (Side Effect Resource) [^63] and contains 1427 approved drugs. These datasets represent four areas of modeling tasks in drug discovery, concretely to develop accurate models for predicting a) new anti-virals (HIV), b) new protein inhibitors (BACE), c) metabolic effects (BBBP), and d) side effects of a chemical compound (SIDER).

We implemented a Hopfield layer HopfieldLayer, in which we used the training-input as stored-pattern $\bm{Y}$ or key, the training-label as pattern-projection $\bm{Y}\bm{W}_{V}$ or value and the input as state-pattern $\bm{R}$ or query. As described in section A.6 by concatenation of input $\bm{z}_{i}$ and target $\bm{t}_{i}$ the matrices $\bm{W}_{K}$ and $\bm{W}_{V}$ can be designed such that inside the softmax the input $\bm{z}_{i}$ is used and outside the softmax the target $\bm{t}_{i}$.

All hyperparameters were selected on separate validation sets and we selected the model with the highest validation AUC on five different random splits.

| parameter | values |
| --- | --- |
| beta | $\{0.0001,0.001,0.01,0.1,0.2,0.3\}$ |
| learning rates | $\{0.0002\}$ |
| heads | $\{1,32,128,512\}$ |
| dropout | $\{0.0,0.1,0.2\}$ |
| state-pattern bias | $\{0.0,-0.1,-0.125,0.15,-0.2\}$ |
| association-activation | {None, LeakyReLU } |
| state- and stored-pattern static | {False, True} |
| normalize state- and stored-pattern | {False, True} |
| normalize association projection | {False, True} |
| learnable stored-pattern | {False, True} |

Table A.4: Hyperparameter search-space for grid-search on HIV, BACE, BBBP and SIDER. All models were trained if applicable for $4$ epochs using Adam and a batch size of $1$ sample.

##### A.5.4.2 Results.

We compared the Hopfield layer Hopfieldlayer to Support Vector Machines (SVMs) [^26] [^85], Extreme Gradient Boosting (XGBoost) [^21], Random Forest (RF) [^14], Deep Neural Networks (DNNs) [^64] [^84], and to graph neural networks (GNN) like Graph Convolutional Networks (GCNs) [^54], Graph Attention Networks (GATs) [^98], Message Passing Neural Networks (MPNNs) [^40], and Attentive FP [^111]. Our architecture with HopfieldLayer has reached state-of-the-art for predicting side effects on SIDER $0.672\pm 0.019$ as well as for predicting $\beta$ -secretase BACE $0.902\pm 0.023$. See Table A.5 for all results, where the results of other methods are taken from [^51].

Table A.5: Results on drug design benchmark datasets. Predictive performance (ROCAUC) on test set as reported by [^51] for 50 random splits

| Model | HIV | BACE | BBBP | SIDER |
| --- | --- | --- | --- | --- |
| SVM | $0.822\pm 0.020$ | $0.893\pm 0.020$ | $0.919\pm 0.028$ | $0.630\pm 0.021$ |
| XGBoost | $0.816\pm 0.020$ | $0.889\pm 0.021$ | $\mathbf{0.926\pm 0.026}$ | $0.642\pm 0.020$ |
| RF | $0.820\pm 0.016$ | $0.890\pm 0.022$ | $\mathbf{0.927\pm 0.025}$ | $0.646\pm 0.022$ |
| GCN | $\mathbf{0.834\pm 0.025}$ | $0.898\pm 0.019$ | $0.903\pm 0.027$ | $0.634\pm 0.026$ |
| GAT | $0.826\pm 0.030$ | $0.886\pm 0.023$ | $0.898\pm 0.033$ | $0.627\pm 0.024$ |
| DNN | $0.797\pm 0.018$ | $0.890\pm 0.024$ | $0.898\pm 0.033$ | $0.627\pm 0.024$ |
| MPNN | $0.811\pm 0.031$ | $0.838\pm 0.027$ | $0.879\pm 0.037$ | $0.598\pm 0.031$ |
| Attentive FP | $0.822\pm 0.026$ | $0.876\pm 0.023$ | $0.887\pm 0.032$ | $0.623\pm 0.026$ |
| Hopfield (ours) | $0.815\pm 0.023$ | $\mathbf{0.902\pm 0.023}$ | $0.910\pm 0.026$ | $\mathbf{0.672\pm 0.019}$ |

### A.6 PyTorch Implementation of Hopfield Layers

The implementation is available at: [https://github.com/ml-jku/hopfield-layers](https://github.com/ml-jku/hopfield-layers)

#### A.6.1 Introduction

In this section, we describe the implementation of Hopfield layers in PyTorch [^73] [^74] and, additionally, provide a brief usage manual. Possible applications for a Hopfield layer in a deep network architecture comprise:

- multiple instance learning (MIL) [^34],
- processing of and learning with point sets [^75] [^76] [^112],
- attention-based learning [^96],
- associative learning,
- natural language processing,
- sequence analysis and time series prediction, and
- storing and retrieving reference or experienced data, e.g. to store training data and retrieve it by the model or to store experiences for reinforcement learning.

The Hopfield layer in a deep neural network architecture can implement:

- a memory (storage) with associative retrieval [^28] [^6],
- conditional pooling and averaging operations [^102] [^50],
- combining data by associations [^2],
- associative credit assignment (e.g. Rescorla-Wagner model or value estimation) [^90], and
- attention mechanisms [^96] [^8].

In particular, a Hopfield layer can substitute attention layers in architectures of transformer and BERT models. The Hopfield layer is designed to be used as plug-in replacement for existing layers like

- pooling layers (max-pooling or average pooling),
- permutation equivariant layers [^42] [^79],
- GRU & LSTM layers, and
- attention layers.

In contrast to classical Hopfield networks, the Hopfield layer is based on the modern Hopfield networks with continuous states that have increased storage capacity, as discussed in the main paper. Like classical Hopfield networks, the dynamics of the single heads of a Hopfield layer follow a energy minimization dynamics. The energy minimization empowers our Hopfield layer with several advantages over other architectural designs like memory cells, associative memory, or attention mechanisms. For example, the Hopfield layer has more functionality than a transformer self-attention layer [^96] as described in Sec. A.6.2. Possible use cases are given in Sec. A.6.3. Source code will be provided under github.

#### A.6.2 Functionality

Non-standard functionalities that are added by a Hopfield layer are

- Association of two sets,
- Multiple Updates for precise fixed points,
- Variable Beta that determines the kind of fixed points,
- Dimension of the associative space for controlling the storage capacity,
- Static Patterns for fixed pattern search, and
- Pattern Normalization to control the fixed point dynamics by norm of the patterns and shift of the patterns.

A functional sketch of our Hopfield layer is shown in Fig. A.7.

•Association of two sets. The Hopfield layer makes it possible to associate two sets of vectors. This general functionality allows

- for transformer-like self-attention,
- for decoder-encoder attention,
- for time series prediction (maybe with positional encoding),
- for sequence analysis,
- for multiple instance learning,
- for learning with point sets,
- for combining data sources by associations,
- for constructing a memory,
- for averaging and pooling operations, and
- for many more.

The first set of vectors consists of $S$ raw state patterns $\bm{R}=(\bm{r}_{1},\ldots,\bm{r}_{S})^{T}$ with $\bm{r}_{s}\in\mathbb{R}^{d_{r}}$ and the second set of vectors consists of $N$ raw stored patterns $\bm{Y}=(\bm{y}_{1},\ldots,\bm{y}_{N})^{T}$ with $\bm{y}_{i}\in\mathbb{R}^{d_{y}}$. Both the $S$ raw state patterns and $N$ raw stored patterns are mapped to an associative space in $\mathbb{R}^{d_{k}}$ via the matrices $\bm{W}_{Q}\in\mathbb{R}^{d_{r}\times d_{k}}$ and $\bm{W}_{K}\in\mathbb{R}^{d_{y}\times d_{k}}$, respectively. We define a matrix $\bm{Q}$ ($\bm{\Xi}^{T}$) of state patterns $\bm{\xi}_{n}=\bm{W}_{Q}\bm{r}_{n}$ in an associative space $\mathbb{R}^{d_{k}}$ and a matrix $\bm{K}$ ($\bm{X}^{T}$) of stored patterns $\bm{x}_{i}=\bm{W}_{K}\bm{y}_{s}$ in the associative space $\mathbb{R}^{d_{k}}$:

$$
\displaystyle\bm{Q}\
$$
 
$$
\displaystyle=\ \bm{\Xi}^{T}\ =\ \bm{R}\ \bm{W}_{Q}\ ,
$$
$$
\displaystyle\bm{K}\
$$
 
$$
\displaystyle=\ \bm{X}^{T}\ =\ \bm{Y}\ \bm{W}_{K}\ .
$$

In the main paper, Eq. (3) defines the novel update rule:

$$
\displaystyle\bm{\xi}^{\mathrm{new}}\
$$
 
$$
\displaystyle=\ f(\bm{\xi})\ =\ \bm{X}\ \mathrm{softmax}(\beta\ \bm{X}^{T}\bm{\xi})\ ,
$$

For multiple patterns, Eq. (3) becomes:

$$
\displaystyle\bm{\Xi}^{\mathrm{new}}\
$$
 
$$
\displaystyle=\ f(\bm{\Xi})\ =\ \bm{X}\ \mathrm{softmax}(\beta\ \bm{X}^{T}\bm{\Xi})\ ,
$$

where $\bm{\Xi}=(\bm{\xi}_{1},\ldots,\bm{\xi}_{N})$ is the matrix of $N$ state (query) patterns, $\bm{X}$ is the matrix of stored (key) patterns, and $\bm{\Xi}^{\mathrm{new}}$ is the matrix of new state patterns, which are averages over stored patterns. A new state pattern can also be very similar to a single stored pattern, in which case we call the stored pattern to be retrieved.

These matrices allow to rewrite Eq. (552) as:

$$
\displaystyle\left(\bm{Q}^{\mathrm{new}}\right)^{T}\
$$
 
$$
\displaystyle=\ \bm{K}^{T}\mathrm{softmax}(\beta\ \bm{K}\ \bm{Q}^{T})\ .
$$

For $\beta=1/\sqrt{d_{k}}$ and changing in Eq. (553) $\mathrm{softmax}\in\mathbb{R}^{N}$ to a row vector (and evaluating a row vector), we obtain:

$$
\displaystyle\bm{Q}^{\mathrm{new}}\
$$
 
$$
\displaystyle=\ \mathrm{softmax}(1/\sqrt{d_{k}}\ \bm{Q}\ \bm{K}^{T})\ \bm{K}\ ,
$$

where $\bm{Q}^{\mathrm{new}}$ is again the matrix of new state patterns. The new state patterns $\bm{\Xi}^{\mathrm{new}}$ are projected via $\bm{W}_{V}$ to the result patterns $\bm{Z}=\bm{\Xi}^{\mathrm{new}}\bm{W}_{V}$, where $\bm{W}_{V}\in\mathbb{R}^{d_{k}\times d_{v}}$. With the pattern projection $\bm{V}=\bm{K}\bm{W}_{V}$, we obtain the update rule Eq. (10) from the main paper:

$$
\displaystyle\bm{Z}\
$$
 
$$
\displaystyle=\ \mathrm{softmax}(1/\sqrt{d_{k}}\ \bm{Q}\ \bm{K}^{T})\ \bm{V}\ .
$$

•Multiple Updates. The update Eq. (553) can be iteratively applied to the initial state $\bm{\xi}$ of every Hopfield layer head. After the last update, the new states $\bm{\Xi}^{\mathrm{new}}$ are projected via $\bm{W}_{V}$ to the result patterns $\bm{Z}=\bm{\Xi}^{\mathrm{new}}\bm{W}_{V}$. Therefore, the Hopfield layer allows multiple update steps in the forward pass without changing the number of parameters. The number of update steps can be given for every Hopfield head individually. Furthermore, it is possible to set a threshold for the number of updates of every Hopfield head based on ${{\left\|\bm{\xi}-\bm{\xi}^{\mathrm{new}}\right\|}}_{2}$. In the general case of multiple initial states $\bm{\Xi}$, the maximum over the individual norms is taken.

•Variable $\beta$. In the main paper, we have identified $\beta$ as a crucial parameter for the fixed point dynamics of the Hopfield network, which governs the operating mode of the attention heads. In appendix, e.g. in Lemma A7 or in Eq. (102) and Eq. (103), we showed that the characteristics of the fixed points of the new modern Hopfield network are determined by: $\beta$, $M$ (maximal pattern norm), $m_{\max}$ (spread of the similar patterns), and ${{\left\|\bm{m}_{\bm{x}}\right\|}}$ (center of the similar patterns). Low values of $\beta$ induce global averaging and higher values of $\beta$ metastable states. In the transformer attention, the $\beta$ parameter is set to $\beta=1/\sqrt{d_{k}}$ as in Eq. (555). The Hopfield layer, however, allows to freely choose $\beta>0$, since the fixed point dynamics does not only depend on the dimension of the associative space $d_{k}$. Additionally, $\beta$ heavily influences the gradient flow to the matrices $\bm{W}_{Q}$ and $\bm{W}_{K}$. Thus, finding the right $\beta$ for the respective application can be crucial.

•Variable dimension of the associative space. Theorem A5 says that the storage capacity of the modern Hopfield network grows exponentially with the dimension of the associative space. However higher dimension of the associative space also means less averaging and smaller metastable states. The dimension of the associative space trades off storage capacity against the size of metastable states, e.g. over how many pattern is averaged. In Eq. (550) and in Eq. (549), we assumed $N$ raw state patterns $\bm{R}=(\bm{r}_{1},\ldots,\bm{r}_{N})^{T}$ and $S$ raw stored patterns $\bm{Y}=(\bm{y}_{1},\ldots,\bm{y}_{S})^{T}$ that are mapped to a $d_{k}$ -dimensional associative space via the matrices $\bm{W}_{Q}\in\mathbb{R}^{d_{r}\times d_{k}}$ and $\bm{W}_{K}\in\mathbb{R}^{d_{y}\times d_{k}}$, respectively. In the associative space $\mathbb{R}^{d_{k}}$, we obtain the state patterns $\bm{Q}=\bm{\Xi}^{T}=\bm{R}\bm{W}_{Q}$ and the stored patterns $\bm{K}=\bm{X}^{T}=\bm{Y}\ \bm{W}_{K}$. The Hopfield view relates the dimension $d_{k}$ to the number of input patterns $N$ that have to be processed. The storage capacity depends exponentially on the dimension $d_{k}$ (the dimension of the associative space) and the size to metastable states is governed by this dimension, too. Consequently, $d_{k}$ should be chosen with respect to the number $N$ of patterns one wants to store and the desired size of metastable states, which is the number of patterns one wants to average over. For example, if the input consists of many low dimensional input patterns, it makes sense to project the patterns into a higher dimensional space to allow a proper fixed point dynamics. Intuitively, this coincides with the construction of a richer feature space for the patterns.

•Static Patterns. In Eq. (550) and Eq. (549), the $N$ raw state patterns $\bm{R}=(\bm{r}_{1},\ldots,\bm{r}_{N})^{T}$ and $S$ raw stored patterns $\bm{Y}=(\bm{y}_{1},\ldots,\bm{y}_{S})^{T}$ are mapped to an associative space via the matrices $\bm{W}_{Q}\in\mathbb{R}^{d_{r}\times d_{k}}$ and $\bm{W}_{K}\in\mathbb{R}^{d_{y}\times d_{k}}$, which gives the state patterns $\bm{Q}=\bm{\Xi}^{T}=\bm{R}\bm{W}_{Q}$ and the stored patterns $\bm{K}=\bm{X}^{T}=\bm{Y}\ \bm{W}_{K}$. We allow for static state and static stored patterns. Static pattern means that the pattern does not depend on the network input, i.e. it is determined by the bias weights and remains constant across different network inputs. Static state patterns allow to determine whether particular fixed patterns are among the stored patterns and vice versa. The static pattern functionality is typically needed if particular patterns must be identified in the data, e.g. as described for immune repertoire classification in the main paper, where a fixed $d_{k}$ -dimensional state vector $\bm{\xi}$ is used.

•Pattern Normalization. In the appendix, e.g. in Lemma A7 or in Eq. (102) and Eq. (103), we showed that the characteristics of the fixed points of the new modern Hopfield network are determined by: $\beta$, $M$ (maximal pattern norm), $m_{\max}$ (spread of the similar patterns), and ${{\left\|\bm{m}_{\bm{x}}\right\|}}$ (center of the similar patterns). We already discussed the parameter $\beta$ while the spread of the similar patterns $m_{\max}$ is given by the data. The remaining variables $M$ and $\bm{m}_{\bm{x}}$ that both control the fixed point dynamics are adjusted pattern normalization. $M$ is the maximal pattern norm and $\bm{m}_{\bm{x}}$ the center of the similar patterns. Theorem A5 says that larger $M$ allows for more patterns to be stored. However, the size of metastable states will decrease with increasing $M$. The vector $\bm{m}_{\bm{x}}$ says how well the (similar) patterns are centered. If the norm ${{\left\|\bm{m}_{\bm{x}}\right\|}}$ is large, then this leads to smaller metastable states. The two parameters $M$ and $\bm{m}_{\bm{x}}$ are controlled by pattern normalization and determine the size and convergence properties of metastable states. These two parameters are important for creating large gradients if heads start with global averaging which has small gradient. These two parameters can shift a head towards small metastable states which have largest gradient as shown in Fig. A.5(b). We allow for three different pattern normalizations, where the first is the default setting:

- pattern normalization of the input patterns,
- pattern normalization after mapping into the associative space,
- no pattern normalization.

Figure A.7: A flowchart of the Hopfield layer. First, the raw state (query) patterns $\bm{R}$ and the raw stored (key) patterns $\bm{Y}$ are optionally normalized (with layer normalization), projected and optionally normalized (with layer normalization) again. The default setting is a layer normalization of the input patterns, and no layer normalization of the projected patterns. The raw stored patterns $\bm{Y}$ can in principle be also two different input tensors. Optionally, multiple updates take place in the projected space of $\bm{Q}$ and $\bm{K}$. This update rule is obtained e.g. from the full update Eq. (423) or the simplified update Eq. (424) in the appendix.

#### A.6.3 Usage

As outlined in Sec. A.6.1, there are a variety of possible use cases for the Hopfield layer, e.g. to build memory networks or transformer models. The goal of the implementation is therefore to provide an easy to use Hopfield module that can be used in a wide range of applications, be it as part of a larger architecture or as a standalone module. Consequently, the focus of the Hopfield layer interface is set on its core parameters: the association of two sets, the scaling parameter $\beta$, the maximum number of updates, the dimension of the associative space, the possible usage of static patterns, and the pattern normalization. The integration into the PyTorch framework is built such that with all the above functionalities disabled, the “HopfieldEncoderLayer” and the “HopfieldDecoderLayer”, both extensions of the Hopfield module, can be used as a one-to-one plug-in replacement for the TransformerEncoderLayer and the TransformerDecoderLayer, respectively, of the PyTorch transformer module.

The Hopfield layer can be used to implement or to substitute different layers:

- Pooling layers: We consider the Hopfield layer as a pooling layer if only one static state (query) pattern exists. Then, it is de facto a pooling over the sequence, which results from the softmax values applied on the stored patterns. Therefore, our Hopfield layer can act as a pooling layer.
- Permutation equivariant layers: Our Hopfield layer can be used as a plug-in replacement for permutation equivariant layers. Since the Hopfield layer is an associative memory it assumes no dependency between the input patterns.
- GRU & LSTM layers: Our Hopfield layer can be used as a plug-in replacement for GRU & LSTM layers. Optionally, for substituting GRU & LSTM layers, positional encoding might be considered.
- Attention layers: Our Hopfield layer can act as an attention layer, where state (query) and stored (key) patterns are different, and need to be associated.
- Finally, the extensions of the Hopfield layer are able to operate as a self-attention layer (HopfieldEncoderLayer) and as cross-attention layer (HopfieldDecoderLayer), as described in [^96]. As such, it can be used as building block of transformer-based or general architectures.

[^1]: Y. Abu-Mostafa and J.-M. StJacques. Information capacity of the Hopfield model. *IEEE Transactions on Information Theory*, 31, 1985. doi: 10.1109/tit.1985.1057069.

[^2]: R. Agrawal, T. Imieliundefinedski, and A. Swami. Mining association rules between sets of items in large databases. *SIGMOD Rec.*, 22(2):207–216, 1993. doi: 10.1145/170036.170072.

[^3]: R. Akbar, P. A. Robert, M. Pavlović, J. R. Jeliazkov, I. Snapkov, A. Slabodkin, C. R. Weber, L. Scheffer, E. Miho, I. H. Haff, et al. A compact vocabulary of paratope-epitope interactions enables predictability of antibody-antigen binding. *bioRxiv*, 2019.

[^4]: F. Alzahrani and A. Salem. Sharp bounds for the lambert $w$ function. *Integral Transforms and Special Functions*, 29(12):971–978, 2018.

[^5]: S. Andrews, I. Tsochantaridis, and T. Hofmann. Support vector machines for multiple-instance learning. In S. Becker, S. Thrun, and K. Obermayer (eds.), *Advances in Neural Information Processing Systems 15*, pp. 577–584. MIT Press, 2003.

[^6]: J. Ba, G. E. Hinton, V. Mnih, J. Z. Leibo, and C. Ionescu. Using fast weights to attend to the recent past. In D. D. Lee, M. Sugiyama, U. V. Luxburg, I. Guyon, and R. Garnett (eds.), *Advances in Neural Information Processing Systems 29*, pp. 4331–4339. Curran Associates, Inc., 2016a.

[^7]: J. Ba, G. E. Hinton, V. Mnih, J. Z. Leibo, and C. Ionescu. Using fast weights to attend to the recent past. *ArXiv*, 1610.06258, 2016b.

[^8]: D. Bahdanau, K. Cho, and Y. Bengio. Neural machine translation by jointly learning to align and translate. *ArXiv*, 1409.0473, 2014. appeared in ICRL 2015.

[^9]: A. Banino, A. P. Badia, R. Köster, M. J. Chadwick, V. Zambaldi, D. Hassabis, C. Barry, M. Botvinick, D. Kumaran, and C. Blundell. MEMO: a deep network for flexible combination of episodic memories. *ArXiv*, 2001.10913, 2020.

[^10]: A. Barra, M. Beccaria, and A. Fachechi. A new mechanical approach to handle generalized Hopfield neural networks. *Neural Networks*, 106:205–222, 2018. doi: 10.1016/j.neunet.2018.07.010.

[^11]: H. H. Bauschke and P. L. Combettes. *Convex Analysis and Monotone Operator Theory in Hilbert Spaces*. Cham: Springer International Publishing, 2nd edition, 2017. ISBN 978-3-319-48310-8. doi: 10.1007/978-3-319-48311-5.

[^12]: S. Boyd and L. Vandenberghe. *Convex Optimization*. Cambridge University Press, 7th edition, 2009. ISBN 978-0-521-83378-3.

[^13]: J. S. Brauchart, A. B. Reznikov, E. B. Saff, I. H. Sloan, Y. G. Wang, and R. S. Womersley. Random point sets on the sphere - hole radii, covering, and separation. *Experimental Mathematics*, 27(1):62–81, 2018. doi: 10.1080/10586458.2016.1226209.

[^14]: L. Breiman. Random forests. *Machine Learning*, 45(1):5–32, 2001. doi: 10.1023/A:1010933404324.

[^15]: J. Bruck and V. P. Roychowdhury. On the number of spurious memories in the Hopfield model. *IEEE Transactions on Information Theory*, 36(2):393–397, 1990.

[^16]: T. Cai, J. Fan, and T. Jiang. Distributions of angles in random packing on spheres. *Journal of Machine Learning Research*, 14(21):1837–1864, 2013.

[^17]: M.-A. Carbonneau, V. Cheplygina, E. Granger, and G. Gagnon. Multiple instance learning: a survey of problem characteristics and applications. *Pattern Recognition*, 77:329–353, 2018.

[^18]: Marc-André Carbonneau, Eric Granger, Alexandre J. Raymond, and Ghyslain Gagnon. Robust multiple-instance learning ensembles using random subspace instance selection. *Pattern Recognition*, 58:83 – 99, 2016. ISSN 0031-3203. doi: https://doi.org/10.1016/j.patcog.2016.03.035. URL [http://www.sciencedirect.com/science/article/pii/S0031320316300346](http://www.sciencedirect.com/science/article/pii/S0031320316300346).

[^19]: M. Carreira-Perpiñán and C. K. I. Williams. An isotropic Gaussian mixture can have more modes than components. Technical Report EDI-INF-RR-0185, The University of Edinburgh, School of Informatics, 2003.

[^20]: A. Carta, A. Sperduti, and D. Bacciu. Encoding-based memory modules for recurrent neural networks. *ArXiv*, 2001.11771, 2020.

[^21]: T. Chen and C. Guestrin. XGBoost: A scalable tree boosting system. In *Proceedings of the 22nd ACM SIGKDD International Conference on Knowledge Discovery and Data Mining*, pp. 785–794. ACM, 2016. doi: 10.1145/2939672.2939785.

[^22]: Y. Chen, J. Bi, and J. Z. Wang. MILES: Multiple-instance learning via embedded instance selection. *IEEE Transactions on Pattern Analysis and Machine Intelligence*, 28(12):1931–1947, 2006.

[^23]: V Cheplygina, DM Tax, and M Loog. Dissimilarity-based ensembles for multiple instance learning. *IEEE transactions on neural networks and learning systems*, 27(6):1379, 2016.

[^24]: K. Cho, B. vanMerriënboer, C. Gulcehre, D. Bahdanau, F. Bougares, H. Schwenk, and Y. Bengio. Learning phrase representations using RNN encoder–decoder for statistical machine translation. In *Proceedings of the Conference on Empirical Methods in Natural Language Processing (EMNLP)*, pp. 1724–1734. Association for Computational Linguistics, 2014. doi: 10.3115/v1/D14-1179.

[^25]: K. Clark, M.-T. Luong, Q. V. Le, and C. D. Manning. ELECTRA: Pre-training text encoders as discriminators rather than generators. *ArXiv*, 2003.10555, 2020. appeared in ICLR 2020.

[^26]: C. Cortes and V. Vapnik. Support-vector networks. *Machine learning*, 20(3):273–297, 1995.

[^27]: A. Crisanti, D. J. Amit, and H. Gutfreund. Saturation level of the Hopfield model for neural network. *Europhysics Letters (EPL)*, 2(4):337–341, 1986. doi: 10.1209/0295-5075/2/4/012.

[^28]: I. Danihelka, G. Wayne, B. Uria, N. Kalchbrenner, and A. Graves. Associative long short-term memory. In M. F. Balcan and K. Q. Weinberger (eds.), *Proceedings of The 33rd International Conference on Machine Learning*, volume 48 of *Proceedings of Machine Learning Research*, pp. 1986–1994, New York, USA, 2016.

[^29]: M. Daniluk, T. Rocktäschel, J. Welbl, and S. Riedel. Frustratingly short attention spans in neural language modeling. *ArXiv*, 1702.04521, 2017. appeared in ICRL 2017.

[^30]: M. Dehghani, S. Gouws, O. Vinyals, J. Uszkoreit, and L. Kaiser. Universal transformers. *ArXiv*, 1807.03819, 2018. Published at ICLR 2019.

[^31]: M. Demircigil, J. Heusel, M. Löwe, S. Upgang, and F. Vermet. On a model of associative memory with huge storage capacity. *Journal of Statistical Physics*, 168(2):288–299, 2017.

[^32]: J. Devlin, M.-W. Chang, K. Lee, and K. Toutanova. BERT: pre-training of deep bidirectional transformers for language understanding. *ArXiv*, 1810.04805, 2018.

[^33]: J. Devlin, M.-W. Chang, K. Lee, and K. Toutanova. BERT: pre-training of deep bidirectional transformers for language understanding. In *Proceedings of the 2019 Conference of the North American Chapter of the Association for Computational Linguistics: Human Language Technologies, Volume 1 (Long and Short Papers)*, pp. 4171–4186. Association for Computational Linguistics, 2019.

[^34]: T. G. Dietterich, R. H. Lathrop, and T. Lozano-Pérez. Solving the multiple instance problem with axis-parallel rectangles. *Artificial Intelligence*, 89(1-2):31–71, 1997.

[^35]: R. O. Emerson, W. S. DeWitt, M. Vignali, J. Gravley, J. K. Hu, E. J. Osborne, C. Desmarais, M. Klinger, C. S. Carlson, J. A. Hansen, et al. Immunosequencing identifies signatures of cytomegalovirus exposure history and HLA-mediated effects on the T cell repertoire. *Nature Genetics*, 49(5):659, 2017.

[^36]: M. Fernández-Delgado, E. Cernadas, S. Barro, and D. Amorim. Do we need hundreds of classifiers to solve real world classification problems? *The Journal of Machine Learning Research*, 15(1):3133–3181, 2014.

[^37]: V. Folli, M. Leonetti, and G. Ruocco. On the maximum storage capacity of the Hopfield model. *Frontiers in Computational Neuroscience*, 10(144), 2017. doi: 10.3389/fncom.2016.00144.

[^38]: B. Gao and L. Pavel. On the properties of the softmax function with application in game theory and reinforcement learning. *ArXiv*, 1704.00805, 2017.

[^39]: D. J. H. Garling. *Analysis on Polish Spaces and an Introduction to Optimal Transportation*. London Mathematical Society Student Texts. Cambridge University Press, 2017. ISBN 1108421571. doi: 10.1017/9781108377362.

[^40]: J. Gilmer, S. S. Schoenholz, P. F. Riley, O. Vinyals, and G. E. Dahl. Neural message passing for quantum chemistry. In *Proceedings of the 34th International Conference on Machine Learning (ICML)*, volume 70, pp. 1263–1272. JMLR.org, 2017.

[^41]: A. Graves, G. Wayne, and I. Danihelka. Neural turing machines. *ArXiv*, 1410.5401, 2014.

[^42]: N. Guttenberg, N. Virgo, O. Witkowski, H. Aoki, and R. Kanai. Permutation-equivariant neural networks applied to dynamics prediction. *arXiv*, 1612.04530, 2016.

[^43]: J. Hertz, A. Krogh, and R. G. Palmer. *Introduction to the Theory of Neural Computation*. Addison-Wesley Longman Publishing Co., Inc., Redwood City, CA, 1991. ISBN 0201503956.

[^44]: S. Hochreiter. Untersuchungen zu dynamischen neuronalen Netzen. Diploma thesis, Institut für Informatik, Lehrstuhl Prof. Brauer, Technische Universität München, 1991. Advisor: J. Schmidhuber.

[^45]: S. Hochreiter and J. Schmidhuber. Long short-term memory. *Neural Comput.*, 9(8):1735–1780, 1997.

[^46]: A. Hoorfar and M. Hassani. Inequalities on the Lambert $w$ function and hyperpower function. *Journal of Inequalities in Pure and Applied Mathematics*, 9(2):1–5, 2008.

[^47]: J. J. Hopfield. Neural networks and physical systems with emergent collective computational abilities. *Proceedings of the National Academy of Sciences*, 79(8):2554–2558, 1982.

[^48]: J. J. Hopfield. Neurons with graded response have collective computational properties like those of two-state neurons. *Proceedings of the National Academy of Sciences*, 81(10):3088–3092, 1984. doi: 10.1073/pnas.81.10.3088.

[^49]: M. Ilse, J. M. Tomczak, and M. Welling. Attention-based deep multiple instance learning. *International Conference on Machine Learning (ICML)*, pp. 3376–3391, 2018.

[^50]: M. Ilse, J. M. Tomczak, and M. Welling. Deep multiple instance learning for digital histopathology. In *Handbook of Medical Image Computing and Computer Assisted Intervention*, pp. 521–546. Elsevier, 2020.

[^51]: D. Jiang, Z. Wu, C.-Y. Hsieh, G. Chen, B. Liao, Z. Wang, C. Shen, D. Cao, J. Wu, and T. Hou. Could graph neural networks learn better molecular representation for drug discovery? a comparison study of descriptor-based and graph-based models. *Journal of Cheminformatics*, 2020. doi: 10.21203/rs.3.rs-81439/v1.

[^52]: M. Kandemir, C. Zhang, and F. A. Hamprecht. Empowering multiple instance histopathology cancer diagnosis by cell graphs. In *International Conference on Medical Image Computing and Computer-Assisted Intervention*, pp. 228–235. Springer, 2014.

[^53]: M. M. R. Khan, R. B. Arif, M. A. B. Siddique, and M. R. Oishe. Study and observation of the variation of accuracies of KNN, SVM, LMNN, ENN algorithms on eleven different datasets from UCI machine learning repository. In *4th International Conference on Electrical Engineering and Information & Communication Technology (iCEEiCT)*, pp. 124–129. IEEE, 2018.

[^54]: T. N. Kipf and M. Welling. Semi-supervised classification with graph convolutional networks. *ArXiv*, 1609.02907, 2016. in International Conference On Learning Representations (ICLR) 2017.

[^55]: G. Klambauer, T. Unterthiner, A. Mayr, and S. Hochreiter. Self-normalizing neural networks. In *Advances in Neural Information Processing Systems*, pp. 971–980, 2017a.

[^56]: G. Klambauer, T. Unterthiner, A. Mayr, and S. Hochreiter. Self-normalizing neural networks. *ArXiv*, 1706.02515, 2017b.

[^57]: P. Koiran. Dynamics of discrete time, continuous state Hopfield networks. *Neural Computation*, 6(3):459–468, 1994. doi: 10.1162/neco.1994.6.3.459.

[^58]: I. Korshunova, J. Degrave, F. Huszar, Y. Gal, A. Gretton, and J. Dambre. BRUNO: A deep recurrent model for exchangeable data. In S. Bengio, H. Wallach, H. Larochelle, K. Grauman, N. Cesa-Bianchi, and R. Garnett (eds.), *Advances in Neural Information Processing Systems 31*, pp. 7190–7198. Curran Associates, Inc., 2018.

[^59]: D. Krotov and J. J. Hopfield. Dense associative memory for pattern recognition. In D. D. Lee, M. Sugiyama, U. V. Luxburg, I. Guyon, and R. Garnett (eds.), *Advances in Neural Information Processing Systems*, pp. 1172–1180. Curran Associates, Inc., 2016.

[^60]: D. Krotov and J. J. Hopfield. Dense associative memory is robust to adversarial inputs. *Neural Computation*, 30(12):3151–3167, 2018.

[^61]: D. Krotov and J. J. Hopfield. Large associative memory problem in neurobiology and machine learning. *ArXiv*, 2008.06996, 2020.

[^62]: E. Ş. Küçükaşcı and M. G. Baydoğan. Bag encoding strategies in multiple instance learning problems. *Information Sciences*, 467:559–578, 2018.

[^63]: M. Kuhn, I. Letunic, L. J. Jensen, and P. Bork. The SIDER database of drugs and side effects. *Nucleic Acids Research*, 44(D1):D1075–D1079, 2016. doi: 10.1093/nar/gkv1075.

[^64]: Y. LeCun, Y. Bengio, and G. Hinton. Deep learning. *Nature*, 521:436–444, 2015.

[^65]: T. Lipp and S. Boyd. Variations and extension of the convex–concave procedure. *Optimization and Engineering*, 17(2):263–287, 2016. doi: 10.1007/s11081-015-9294-x.

[^66]: Ilya Loshchilov and Frank Hutter. Decoupled weight decay regularization. *arXiv preprint arXiv:1711.05101*, 2017.

[^67]: O. Maron and T. Lozano-Pérez. A framework for multiple-instance learning. In M. I. Jordan, M. J. Kearns, and S. A. Solla (eds.), *Advances in Neural Information Processing Systems*, pp. 570–576. MIT Press, 1998.

[^68]: I. F. Martins, A. L. Teixeira, L. Pinheiro, and A. O. Falcao. A Bayesian approach to in silico blood-brain barrier penetration modeling. *Journal of Chemical Information and Modeling*, 52(6):1686–1697, 2012. doi: 10.1021/ci300124c.

[^69]: C. Mazza. On the storage capacity of nonlinear neural networks. *Neural Networks*, 10(4):593–597, 1997. doi: 10.1016/S0893-6080(97)00017-8.

[^70]: R. J. McEliece, E. C. Posner, E. R. Rodemich, and S. S. Venkatesh. The capacity of the Hopfield associative memory. *IEEE Trans. Inf. Theor.*, 33(4):461–482, 1987. doi: 10.1109/TIT.1987.1057328.

[^71]: R. R. Meyer. Sufficient conditions for the convergence of monotonic mathematical programming algorithms. *Journal of Computer and System Sciences*, 12(1):108–121, 1976. doi: 10.1016/S0022-0000(76)80021-9.

[^72]: F. W. J. Olver, D. W. Lozier, R. F. Boisvert, and C. W. Clark. *NIST handbook of mathematical functions*. Cambridge University Press, 1 pap/cdr edition, 2010. ISBN 9780521192255.

[^73]: A. Paszke, S. Gross, S. Chintala, G. Chanan, E. Yang, Z. DeVito, Z. Lin, A. Desmaison, L. Antiga, and A. Lerer. Automatic differentiation in PyTorch. In *Workshop in Advances in Neural Information Processing Systems (NeurIPS)*, 2017.

[^74]: A. Paszke, S. Gross, F. Massa, A. Lerer, J. Bradbury, G. Chanan, T. Killeen, Z. Lin, N. Gimelshein, L. Antiga, et al. PyTorch: An imperative style, high-performance deep learning library. In *Advances in Neural Information Processing Systems*, pp. 8026–8037, 2019.

[^75]: C. R. Qi, H. Su, M. Kaichun, and L. J. Guibas. PointNet: Deep learning on point sets for 3d classification and segmentation. In *IEEE Conference on Computer Vision and Pattern Recognition (CVPR)*, pp. 77–85, 2017a. doi: 10.1109/CVPR.2017.16.

[^76]: C. R. Qi, L. Yi, H. Su, and L. J. Guibas. PointNet++: Deep hierarchical feature learning on point sets in a metric space. In *31st International Conference on Neural Information Processing Systems*, pp. 5105–5114. Curran Associates Inc., 2017b.

[^77]: A. Rangarajan, S. Gold, and E. Mjolsness. A novel optimizing network architecture with applications. *Neural Computation*, 8(5):1041–1060, 1996. doi: 10.1162/neco.1996.8.5.1041.

[^78]: A. Rangarajan, A. Yuille, and Eric E. Mjolsness. Convergence properties of the softassign quadratic assignment algorithm. *Neural Computation*, 11(6):1455–1474, 1999. doi: 10.1162/089976699300016313.

[^79]: S. Ravanbakhsh, J. Schneider, and B. Poczos. Deep learning with sets and point clouds. *arXiv*, 1611.04500, 2016.

[^80]: I. Schlag and J. Schmidhuber. Learning to reason with third order tensor products. In S. Bengio, H. Wallach, H. Larochelle, K. Grauman, N. Cesa-Bianchi, and R. Garnett (eds.), *Advances in Neural Information Processing Systems 31*, pp. 9981–9993. Curran Associates, Inc., 2018.

[^81]: I. Schlag, P. Smolensky, R. Fernandez, N. Jojic, J. Schmidhuber, and J. Gao. Enhancing the transformer with explicit relational encoding for math problem solving. *arXiv*, 1910.06611, 2019.

[^82]: I. Schlag, K. Irie, and J. Schmidhuber. Linear transformers are secretly fast weight memory systems. *arXiv*, 2102.11174, 2021.

[^83]: J. Schmidhuber. Learning to control fast-weight memories: An alternative to dynamic recurrent networks. In *Neural Computations, Volume: 4, Issue: 1*, pp. 131 – 139. MIT Press, 1992.

[^84]: J. Schmidhuber. Deep learning in neural networks: An overview. *Neural Networks*, 61:85–117, 2015. doi: 10.1016/j.neunet.2014.09.003.

[^85]: B. Schölkopf and A. J. Smola. *Learning with Kernels – Support Vector Machines, Regularization, Optimization, and Beyond*. MIT Press, Cambridge, MA, 2002.

[^86]: B. K. Sriperumbudur and G. R. Lanckriet. On the convergence of the concave-convex procedure. In Y. Bengio, D. Schuurmans, J. D. Lafferty, C. K. I. Williams, and A. Culotta (eds.), *Advances in Neural Information Processing Systems 22*, pp. 1759–1767. Curran Associates, Inc., 2009.

[^87]: G. Subramanian, B. Ramsundar, V. Pande, and R. A. Denny. Computational modeling of $\beta$ -Secretase 1 (BACE-1) inhibitors using ligand based approaches. *Journal of Chemical Information and Modeling*, 56(10):1936–1949, 2016. doi: 10.1021/acs.jcim.6b00290.

[^88]: S. Sukhbaatar, A. Szlam, J. Weston, and R. Fergus. End-to-end memory networks. In C. Cortes, N. D. Lawrence, D. D. Lee, M. Sugiyama, and R. Garnett (eds.), *Advances in Neural Information Processing Systems 28*, pp. 2440–2448. Curran Associates, Inc., 2015a.

[^89]: S. Sukhbaatar, A. Szlam, J. Weston, and R. Fergus. End-to-end memory networks. *ArXiv*, 1503.08895, 2015b.

[^90]: R. S. Sutton and A. G. Barto. *Reinforcement Learning: An Introduction*. MIT Press, Cambridge, MA, 2 edition, 2018.

[^91]: F. Tanaka and S. F. Edwards. Analytic theory of the ground state properties of a spin glass. I. Ising spin glass. *Journal of Physics F: Metal Physics*, 10(12):2769–2778, 1980. doi: 10.1088/0305-4608/10/12/017.

[^92]: Y. Tay, D. Bahri, D. Metzler, D.-C. Juan, Z. Zhao, and C. Zheng. Synthesizer: Rethinking self-attention in transformer models. *ArXiv*, 2005.00743, 2020.

[^93]: M. Toneva and L. Wehbe. Interpreting and improving natural-language processing (in machines) with natural language-processing (in the brain). In H. Wallach, H. Larochelle, A. Beygelzimer, F. d'Alché-Buc, E. Fox, and R. Garnett (eds.), *Advances in Neural Information Processing Systems 32*, pp. 14954–14964. Curran Associates, Inc., 2019a.

[^94]: M. Toneva and L. Wehbe. Interpreting and improving natural-language processing (in machines) with natural language-processing (in the brain). *arXiv*, 1905.11833, 2019b.

[^95]: J. J. Torres, L. Pantic, and Hilbert H. J. Kappen. Storage capacity of attractor neural networks with depressing synapses. *Phys. Rev. E*, 66:061910, 2002. doi: 10.1103/PhysRevE.66.061910.

[^96]: A. Vaswani, N. Shazeer, N. Parmar, J. Uszkoreit, L. Jones, A. N. Gomez, L. Kaiser, and I. Polosukhin. Attention is all you need. In I. Guyon, U. V. Luxburg, S. Bengio, H. Wallach, R. Fergus, S. Vishwanathan, and R. Garnett (eds.), *Advances in Neural Information Processing Systems 30*, pp. 5998–6008. Curran Associates, Inc., 2017a.

[^97]: A. Vaswani, N. Shazeer, N. Parmar, J. Uszkoreit, L. Jones, A. N. Gomez, L. Kaiser, and I. Polosukhin. Attention is all you need. *ArXiv*, 1706.03762, 2017b.

[^98]: P. Velic̆ković, G. Cucurull, A. Casanova, A. Romero, P. Liò, and Y. Bengio. Graph attention networks. *arXiv*, 1710.10903, 2018. in International Conference On Learning Representations (ICLR) 2018.

[^99]: M. Wainberg, B. Alipanahi, and B. J. Frey. Are random forests truly the best classifiers? *The Journal of Machine Learning Research*, 17(1):3837–3841, 2016.

[^100]: G. Wainrib and J. Touboul. Topological and dynamical complexity of random neural networks. *Phys. Rev. Lett.*, 110:118101, 2013. doi: 10.1103/PhysRevLett.110.118101.

[^101]: J. Wang. Solving the multiple-instance problem: A lazy learning approach. In *Proceedings of the 17th International Conference on Machine Learning (ICML)*, 2000.

[^102]: X. Wang, Y. Yan, P. Tang, X. Bai, and W. Liu. Revisiting multiple instance neural networks. *Pattern Recognition*, 74:15–24, 2018.

[^103]: C. R. Weber, R. Akbar, A. Yermanos, M. Pavlović, I. Snapkov, G. K. Sandve, S. T. Reddy, and V. Greiff. immuneSIM: tunable multi-feature simulation of B- and T-cell receptor repertoires for immunoinformatics benchmarking. *Bioinformatics*, 36(11):3594–3596, 2020. doi: 10.1093/bioinformatics/btaa158.

[^104]: J. Weston, S. Chopra, and A. Bordes. Memory networks. *ArXiv*, 1410.3916, 2014.

[^105]: M. Widrich, B. Schäfl, M. Pavlović, H. Ramsauer, L. Gruber, M. Holzleitner, J. Brandstetter, G. K. Sandve, V. Greiff, S. Hochreiter, and G. Klambauer. Modern Hopfield networks and attention for immune repertoire classification. *ArXiv*, 2007.13505, 2020a.

[^106]: M. Widrich, B. Schäfl, M. Pavlović, H. Ramsauer, L. Gruber, M. Holzleitner, J. Brandstetter, G. K. Sandve, V. Greiff, S. Hochreiter, and G. Klambauer. Modern Hopfield networks and attention for immune repertoire classification. In *Advances in Neural Information Processing Systems*. Curran Associates, Inc., 2020b.

[^107]: T. Wolf, L. Debut, V. Sanh, J. Chaumond, C. Delangue, A. Moi, P. Cistac, T. Rault, R. Louf, M. Funtowicz, and J. Brew. HuggingFace’s transformers: State-of-the-art natural language processing. *ArXiv*, 1910.03771, 2019.

[^108]: J. C. F. Wu. On the convergence properties of the em algorithm. *Ann. Statist.*, 11(1):95–103, 1983. doi: 10.1214/aos/1176346060.

[^109]: X. Wu, X. Liu, W. Li, and Q. Wu. Improved expressivity through dendritic neural networks. In S. Bengio, H. Wallach, H. Larochelle, K. Grauman, N. Cesa-Bianchi, and R. Garnett (eds.), *Advances in Neural Information Processing Systems 31*, pp. 8057–8068. Curran Associates, Inc., 2018.

[^110]: Z. Wu, B. Ramsundar, E. N. Feinberg, J. Gomes, C. Geniesse, A. S. Pappu, K. Leswing, and V. Pande. MoleculeNet: A benchmark for molecular machine learning. *arXiv*, 1703.00564, 2017.

[^111]: Z. Xiong, D. Wang, X. Liu, F. Zhong, X. Wan, X. Li, Z. Li, X. Luo, K. Chen, H. Jiang, and M. Zheng. Pushing the boundaries of molecular representation for drug discovery with the graph attention mechanism. *Journal of Medicinal Chemistry*, 63(16):8749–8760, 2020. doi: 10.1021/acs.jmedchem.9b00959.

[^112]: Y. Xu, T. Fan, M. Xu, L. Zeng, and Y. Qiao. SpiderCNN: Deep learning on point sets with parameterized convolutional filters. In V. Ferrari, M. Hebert, C. Sminchisescu, and Y. Weiss (eds.), *European Conference on Computer Vision (ECCV)*, pp. 90–105. Springer International Publishing, 2018.

[^113]: A. L. Yuille and A. Rangarajan. The concave-convex procedure (CCCP). In T. G. Dietterich, S. Becker, and Z. Ghahramani (eds.), *Advances in Neural Information Processing Systems 14*, pp. 1033–1040. MIT Press, 2002.

[^114]: A. L. Yuille and A. Rangarajan. The concave-convex procedure. *Neural Computation*, 15(4):915–936, 2003. doi: 10.1162/08997660360581958.

[^115]: M. Zaheer, S. Kottur, S. Ravanbakhsh, B. Poczos, R. R. Salakhutdinov, and A. J. Smola. Deep sets. In I. Guyon, U. V. Luxburg, S. Bengio, H. Wallach, R. Fergus, S. Vishwanathan, and R. Garnett (eds.), *Advances in Neural Information Processing Systems 30*, pp. 3391–3401. Curran Associates, Inc., 2017.

[^116]: W. I. Zangwill. *Nonlinear programming: a unified approach*. Prentice-Hall international series in management. Englewood Cliffs, N.J., 1969. ISBN 9780136235798.

[^117]: S. Zhai, W. Talbott, M. A. Bautista, C. Guestrin, and J. M. Susskind. Set distribution networks: a generative model for sets of images. *arXiv*, 2006.10705, 2020.

[^118]: W. Zhang and B. Zhou. Learning to update auto-associative memory in recurrent neural networks for improving sequence memorization. *ArXiv*, 1709.06493, 2017.

[^119]: Y. Zhu, R. Kiros, R. S. Zemel, R. Salakhutdinov, R. Urtasun, A. Torralba, and S. Fidler. Aligning books and movies: Towards story-like visual explanations by watching movies and reading books. *Proceedings of the IEEE international conference on computer vision*, pp. 19–27, 2015. arXiv 1506.06724.