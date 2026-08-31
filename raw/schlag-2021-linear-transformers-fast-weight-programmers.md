---
title: "Linear Transformers Are Secretly Fast Weight Programmers"
source: "https://ar5iv.labs.arxiv.org/html/2102.11174"
author:
published:
created: 2026-08-31
description: "We show the formal equivalence of linearised self-attention mechanisms and fast weight controllers from the early ’90s, where a “slow” neural net learns by gradient descent to program the “fast weights” of another net …"
tags:
  - "clippings"
---
Imanol Schlag <sup>∗</sup> Affiliation: The Swiss AI Lab IDSIA, USI & SUPSI    Kazuki Irie <sup>∗</sup> Affiliation: The Swiss AI Lab IDSIA, USI & SUPSI    Jürgen Schmidhuber Affiliation: The Swiss AI Lab IDSIA, USI & SUPSI Correspondence to: [juergen@idsia.ch](mailto:juergen@idsia.ch)

###### Abstract

We show the formal equivalence of linearised self-attention mechanisms and fast weight controllers from the early ’90s, where a “slow” neural net learns by gradient descent to program the “fast weights” of another net through sequences of elementary programming instructions which are additive outer products of self-invented activation patterns (today called keys and values). Such Fast Weight Programmers (FWPs) learn to manipulate the contents of a finite memory and dynamically interact with it. We infer a memory capacity limitation of recent linearised softmax attention variants, and replace the purely additive outer products by a delta rule-like programming instruction, such that the FWP can more easily learn to correct the current mapping from keys to values. The FWP also learns to compute dynamically changing learning rates. We also propose a new kernel function to linearise attention which balances simplicity and effectiveness. We conduct experiments on synthetic retrieval problems as well as standard machine translation and language modelling tasks which demonstrate the benefits of our methods.

###### Keywords:

Machine Learning, ICML <sup>†</sup>

## 1 Introduction

Transformers [^69] have achieved impressive results in a myriad of sequence processing tasks, including machine translation, language modelling [^1] [^9] [^3] [^51], and question answering [^11], domains previously dominated by recurrent neural networks [^14] [^4].

The core component of a Transformer is the self-attention mechanism [^6] [^46] [^33] which was recently connected to the modern Hopfield network [^53] [^32] [^10]. It extends a form of attention [^4] originally introduced to complement recurrent neural networks, e.g., [^20]. While relinquishing the recurrence property, all computations across the time axis can be parallelised. However, this comes with drawbacks: self-attention computations scale quadratically with sequence length while the memory of the model grows linearly. Therefore, practitioners are forced to limit the context window to a reasonable size, which in turn makes it impossible to capture longer-term dependencies.

Recent work proposed “linear Transformers” with constant size memory and time complexity linear in sequence length [^26] [^7] [^48] [^62]. This complexity reduction is mainly due to a linearisation of the softmax (reviewed in Sec. 3.2).

Here we emphasize the formal equivalence of this family of linear Transformers and the Fast Weight Controllers or Fast Weight Programmers (FWPs) from the ’90s [^57] [^58] [^59] [^60] (apart from normalisation). The memories of such FWPs contain key-value associations, and an FWP can learn to reprogram them through sequences of differentiable elementary instructions (also called update rules), which are additive outer products between keys and values invented by the FWP.

This view allows us to derive a limitation of the memory capacity of linear Transformers and similar models. When the sequence length exceeds storage capacity, the model may end up in an overcapacity regime (discussed in depth in Sec. 4.1). To properly operate under such a regime, the model should learn to dynamically interact with the memory contents and selectively decide which key-value associations to keep and which ones to delete. The purely additive instruction may be inappropriate for this purpose. Therefore, inspired by recent work on FWPs [^56], we introduce an improved programming instruction akin to the famous error-correcting delta-rule [^71].

Furthermore, softmax linearisation techniques for Transformers are still underexplored. The existing techniques are either very simplistic [^26] or mathematically well explained but complex [^7] [^48]. We provide a comprehensive comparison and propose a new method which is both simple and effective.

We demonstrate the benefits of the proposed methods on our own synthetic retrieval dataset (Sec. 6.1), the standard WMT14 English to German machine translation task (Sec. 6.2), and the Wikitext-103 [^35] language modelling task (Sec. 6.3) <sup>2</sup>.

## 2 Background on Fast Weight Programmers

Here we review the concepts of Fast Weight Programmers (FWPs) before relating them to linear Transformer variants in Sec. 3.

In standard neural networks, the weights remain fixed after training, unlike the activations, which change depending on the inputs at test time. The general idea of fast weights is to make the weights also variable and input-dependent. This concept was called synaptic modulation [^70], a method for variable binding in neural networks (see e.g. the recent survey by [^15]), or dynamic connections [^12]. Von der Malsburg defines the effective weights as a (multiplicative) superposition of conventional, context-independent slow weights, and fast changing, context-dependent fast weights. [^19] studied a net with (additive) superposition of two sets of weights with two different learning rates in a scenario of model retraining. Before 1991, however, no network learned by gradient descent to quickly compute the changes of the fast weight storage of another network or of itself.

Context-dependent FWPs were introduced in two-network systems of the early ’90s [^57] [^58] [^59] [^60]. A traditional slow net with slow weights continually changes or reprograms the fast weights of a fast net, making the fast weights effectively dependent on the spatio-temporal context of a given input stream. Simply put, the slow net learns to program its fast net. Among the proposed elementary differentiable instructions that the slow net can use to program the fast weights, a particularly attractive one makes use of outer products [^57] [^58]: for a sequential input $\{{\bm{x}}^{(i)}\}_{i=1}^{L},{\bm{x}}^{(i)}\in\mathbb{R}^{d_{\text{in}}}$, the model outputs the sequence $\{{\bm{y}}^{(i)}\}_{i=1}^{L},{\bm{y}}^{(i)}\in\mathbb{R}^{d_{\text{out}}}$ as

$$
\displaystyle{\bm{a}}^{(i)},{\bm{b}}^{(i)}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle{\bm{W}}_{a}{\bm{x}}^{(i)},{\bm{W}}_{b}{\bm{x}}^{(i)}
$$
 
$$
\displaystyle{\bm{W}}^{(i)}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\sigma\big({\bm{W}}^{(i-1)}+{\bm{a}}^{(i)}\otimes{\bm{b}}^{(i)}\big)
$$
 
$$
\displaystyle{\bm{y}}^{(i)}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle{\bm{W}}^{(i)}{\bm{x}}^{(i)}
$$

where $\otimes$ denotes the outer product, $\sigma$ is an activation function, ${\bm{W}}_{a}$ and ${\bm{W}}_{b}$ are trainable slow weights, while the fast weights ${\bm{W}}^{(i)}$ are generated at each time step $i$ and serve as a short-term memory. This is a key-value associative memory model in which the write operation is based on a summation (Eq. 2) and the retrieval is a matrix-vector multiplication (Eq. 3). [^59] describes a recurrent version and discusses “internal spotlights of attention” (such attention terminology is now widely used in the context of transformers). The use of outer products results in a model of associations similar to tensor product presentations [^63]. In fact, outer-product based associative memory can be found in numerous works since Hebb’s informal rule [^18] and its more concrete formal variants [^65] [^66] [^30] [^44] including Hopfield networks [^21] [^34] and bi-directional associative nets [^31]. However, these authors described pre-wired rules to associate given patterns with each other. Their systems did not learn to use such rules for associating self-invented patterns like the FWPs since 1991.

The concept of FWPs has been revisited recently [^2] [^54], also under different names, e.g., hypernetworks [^16] [^49] [^13], dynamic plasticity [^36] [^37], dynamic convolution [^29] [^41] [^25], or lambda networks [^5] used for applications including meta-learning [^39] [^38] [^40] [^28]. FWPs recently also improved memory models through explicit mechanisms for facilitating the replacement of deprecated information and updating associations [^55] [^56].

## 3 Relation to Transformers

[^2] have already pointed out a relation between a variant of outer product-based FWPs [^59] and attention [^4]. [^26] have analysed linearised transformers. We review these derivations, emphasising the relation between Transformers and the FWPs of the previous section.

### 3.1 Self-Attention Without Softmax Is a Fast Weight Programmer

A self-attention layer in auto-regressive Transformers [^69] maps an input sequence $\{{\bm{x}}^{(i)}\}_{i=1}^{L},{\bm{x}}^{(i)}\in\mathbb{R}^{d\times 1}$ to an output sequence $\{{\bm{y}}^{(i)}\}_{i=1}^{L},{\bm{y}}^{(i)}\in\mathbb{R}^{d_{\text{value}}\times 1}$ as

$$
\displaystyle{\bm{k}}^{(i)},{\bm{v}}^{(i)},{\bm{q}}^{(i)}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle{\bm{W}}_{k}{\bm{x}}^{(i)},{\bm{W}}_{v}{\bm{x}}^{(i)},{\bm{W}}_{q}{\bm{x}}^{(i)}
$$
 
$$
\displaystyle{\bm{K}}^{(i)}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\big[{\bm{K}}^{(i-1)},{\bm{k}}^{(i)}]\in\mathbb{R}^{d_{\text{key}}\times i}
$$
 
$$
\displaystyle{\bm{V}}^{(i)}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\big[{\bm{V}}^{(i-1)},{\bm{v}}^{(i)}]\in\mathbb{R}^{d_{\text{value}}\times i}
$$
 
$$
\displaystyle{\bm{y}}^{(i)}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle{\bm{V}}^{(i)}\mathrm{softmax}(({\bm{K}}^{(i)})^{\top}{\bm{q}}^{(i)})
$$

where $[{\bm{A}},{\bm{a}}]$ denotes the concatenation of vector ${\bm{a}}$ to matrix ${\bm{A}}$ along the time dimension, $\mathrm{softmax}$ is applied along the time dimension, and ${\bm{W}}_{k}$, ${\bm{W}}_{v}$, ${\bm{W}}_{q}$ are trainable weight matrices. We omit the scaling by $1/\sqrt{d_{\text{key}}}$ inside the softmax without loss of generality.

Now if we remove the softmax in Eq. 7 we obtain:

$$
\displaystyle{\bm{y}}^{(i)}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle{\bm{V}}^{(i)}\big(({\bm{K}}^{(i)})^{\top}{\bm{q}}^{(i)}\big)=\big({\bm{V}}^{(i)}({\bm{K}}^{(i)})^{\top}\big){\bm{q}}^{(i)}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\big(\sum_{j=1}^{i}{\bm{v}}^{(j)}\otimes{\bm{k}}^{(j)}\big){\bm{q}}^{(i)}
$$

Denoting by ${\bm{W}}^{(i)}$ the corresponding weight matrix generated from key and value vectors:

$$
\displaystyle{\bm{W}}^{(i)}=\big(\sum_{j=1}^{i}{\bm{v}}^{(j)}\otimes{\bm{k}}^{(j)})
$$

we can rewrite Eqs. 4-7 such that they directly relate to Eqs. 1-3 where the activation function $\sigma$ is the identity function and without query projection ${\bm{W}}_{q}$:

$$
\displaystyle{\bm{k}}^{(i)},{\bm{v}}^{(i)},{\bm{q}}^{(i)}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle{\bm{W}}_{k}{\bm{x}}^{(i)},{\bm{W}}_{v}{\bm{x}}^{(i)},{\bm{W}}_{q}{\bm{x}}^{(i)}
$$
 
$$
\displaystyle{\bm{W}}^{(i)}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle{\bm{W}}^{(i-1)}+{\bm{v}}^{(i)}\otimes{\bm{k}}^{(i)}
$$
 
$$
\displaystyle{\bm{y}}^{(i)}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle{\bm{W}}^{(i)}{\bm{q}}^{(i)}
$$

### 3.2 Linearising Self-Attention

Instead of removing the softmax as in Sec. 3.1, prior works have introduced techniques for linearising the softmax [^68], which has been shown to improve computational efficiency of self-attention for long sequences [^26] [^7] [^48].

By writing the softmax explicitly, Eq. 7 can be written as:

$$
\displaystyle{\bm{y}}^{(i)}=\sum_{j=1}^{i}\frac{{\bm{v}}^{(j)}\kappa({\bm{k}}^{(j)},{\bm{q}}^{(i)})}{\sum_{j^{\prime}=1}^{i}\kappa({\bm{k}}^{(j^{\prime})},{\bm{q}}^{(i)})}
$$

where $\kappa({\bm{k}},{\bm{q}})=\exp({\bm{k}}\cdot{\bm{q}})\in\mathbb{R}_{>0}$ is the softmax kernel and ${\bm{k}}\cdot{\bm{q}}={\bm{k}}^{\top}{\bm{q}}$ is the vector dot product.

The general idea is to replace the softmax kernel $\kappa$ by another kernel: $\kappa^{\prime}({\bm{k}},{\bm{q}})=\phi({\bm{k}})^{\top}\phi({\bm{q}})$ where $\phi$ is a function $\mathbb{R}^{d_{\text{key}}}\rightarrow\mathbb{R}^{d_{\text{dot}}}$. We discuss the necessary properties of $\phi$ in Sec. 5.1. By replacing $\kappa$ in Eq. 12 by $\kappa^{\prime}$, we obtain

$$
\displaystyle{\bm{y}}^{(i)}
$$
 
$$
\displaystyle=\sum_{j=1}^{i}\frac{{\bm{v}}^{(j)}\phi({\bm{k}}^{(j)})^{\top}\phi({\bm{q}}^{(i)})}{\sum_{j^{\prime}=1}^{i}\phi({\bm{k}}^{(j^{\prime})})\cdot\phi({\bm{q}}^{(i)})}
$$
 
$$
\displaystyle=\displaystyle\frac{\sum_{j=1}^{i}\big({\bm{v}}^{(j)}\phi({\bm{k}}^{(j)})^{\top}\big)\phi({\bm{q}}^{(i)})}{\big(\sum_{j^{\prime}=1}^{i}\phi({\bm{k}}^{(j^{\prime})})\big)\cdot\phi({\bm{q}}^{(i)})}
$$

Using the outer-product notation, the numerator is analogous to the case without softmax (Sec. 3.1):

$$
\displaystyle\displaystyle\sum_{j=1}^{i}\big({\bm{v}}^{(j)}\phi({\bm{k}}^{(j)})^{\top}\big)\phi({\bm{q}}^{(i)})=\displaystyle\big(\sum_{j=1}^{i}{\bm{v}}^{(j)}\otimes\phi({\bm{k}}^{(j)})\big)\phi({\bm{q}}^{(i)})
$$

By introducing the fast weight matrix ${\bm{W}}^{(i)}$ and an additional vector ${\bm{z}}^{(i)}$ for the denominator,

$$
\displaystyle{\bm{W}}^{(i)}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\sum_{j=1}^{i}{\bm{v}}^{(j)}\otimes\phi({\bm{k}}^{(j)})
$$
 
$$
\displaystyle{\bm{z}}^{(i)}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\displaystyle\sum_{j=1}^{i}\phi({\bm{k}}^{(j)})
$$

forward computations of linear Transformers can be written as [^26]:

$$
\displaystyle{\bm{k}}^{(i)},{\bm{v}}^{(i)},{\bm{q}}^{(i)}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle{\bm{W}}_{k}{\bm{x}}^{(i)},{\bm{W}}_{v}{\bm{x}}^{(i)},{\bm{W}}_{q}{\bm{x}}^{(i)}
$$
 
$$
\displaystyle{\bm{W}}^{(i)}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle{\bm{W}}^{(i-1)}+{\bm{v}}^{(i)}\otimes\phi({\bm{k}}^{(i)})
$$
 
$$
\displaystyle{\bm{z}}^{(i)}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle{\bm{z}}^{(i-1)}+\phi({\bm{k}}^{(i)})
$$
 
$$
\displaystyle{\bm{y}}^{(i)}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\displaystyle\dfrac{1}{{\bm{z}}^{(i)}\cdot\phi({\bm{q}}^{(i)})}{\bm{W}}^{(i)}\phi({\bm{q}}^{(i)})
$$

which is a Fast Weight Programmer (Sec. 2) with normalisation. Hence, the core of linear Transformer variants are outer product-based Fast Weight Programmers.

## 4 Analysing and Improving Linear Transformers as Fast Weight Programmers

Viewing linear Transformer variants as Fast Weight Programmers provides us with two insights which we investigate in this work: their capacity limits as associative memories (Sec. 4.1), and their ineptness to edit previously stored associations (Sec. 4.2).

### 4.1 Capacity Limitation

##### Intuition.

Endlessly adding new associations to a memory of finite size, as in Eq. 17, inevitably will reach a limit. In linear attention, information is stored in a matrix and is retrieved using matrix multiplication (see Eq. 19). As a consequence, to prevent associations from interfering with each other upon retrieval, the respective keys need to be orthogonal. Otherwise, the dot product will attend to more than one key and return a linear combination of values. With keys embedded in a $d_{\text{dot}}$ space, there cannot be more than $d_{\text{dot}}$ orthogonal vectors. That is, storing more than $d_{\text{dot}}$ associations will result in a retrieval error. In linear Transformers, when the length of the sequence is longer than $d_{\text{dot}}$, the model might be in such an overcapacity regime. While we experimentally demonstrate this effect on toy tasks (Sec. 6.1), prior work on tensor product representations allows for a more formal discussion.

##### Tensor Product Representation Theory.

Early work in connectionist research investigated the usage of distributed representations as a means for storing symbolic structures. One highly-influential work is the tensor-product-based variable binding mechanism [^63]. A tensor product representation (TPR) of a structured symbolic system consisting of a set of variables and values constructed from outer products of the so called role and filler vectors. These terms directly translate into keys and values in our context. The fast weight memories of Eq. 17 are the most basic form of such representations (second order tensors). Therefore, many results discussed in Smolensky’s work transfer to our model. In particular, Theorem 3.3 and 3.1 of [^63] discuss more formally the crosstalk and retrieval error intuitively described in the previous paragraph.

However, we also note an important difference: the classic TPRs of [^63] are constructed with a priori knowledge of the symbolic structure. In contrast, our FWPs since 1991, including recent FWPs [^55], learn all the vectors involved in constructing such a representation.

### 4.2 Improving the FWP’s Programming Instruction

Sec. 4.1 argues that the linear Transformers can end up in an overcapacity regime, if the sequence length $L$ exceeds the dimension $d_{\text{dot}}$ of the keys. Once in overcapacity, an ideal memory model should dynamically interact with the memory contents and selectively determine which associations to remember or to forget. This is in stark contrast to the standard Transformer which stores immutable pairs of key and value vectors by concatenation, thus increasing the storage size. While such models work well in practice, we consider a model’s capability to update previously acquired knowledge to be critical for many problems. Hence, from the perspective of dynamic interaction with the memory, the purely additive update rule of Eqs. 17 may be sub-optimal. This motivates us to improve the elementary differentiable programming instruction (i.e. the update rule) of FWPs.

Inspired by the recent work by [^56], we propose a basic instruction that essentially implements the famous error-correcting delta rule [^71] in an end-to-end differentiable way, such that the FWP can learn to use it wisely, through self-invented, dynamically changing learning rates. Given a new input key-value pair $({\bm{k}}^{(i)},{\bm{v}}^{(i)})$, the FWP first accesses the current state of the memory ${\bm{W}}^{(i-1)}$ and retrieves the value $\bar{{\bm{v}}}^{(i)}$ currently paired with the key ${\bm{k}}^{(i)}$. Then the model stores a convex combination ${\bm{v}}^{(i)}_{\text{new}}$ of the retrieved value $\bar{{\bm{v}}}^{(i)}$ and the input ${\bm{v}}^{(i)}$ using an interpolation weight $0\leq\beta^{(i)}\leq 1$ also generated by the model. The model thus sequentially transforms an input sequence $\{{\bm{x}}^{(i)}\}_{i=1}^{L},{\bm{x}}^{(i)}\in\mathbb{R}^{d\times 1}$ into an output sequence $\{{\bm{y}}^{(i)}\}_{i=1}^{L},{\bm{y}}^{(i)}\in\mathbb{R}^{d_{\text{value}}\times 1}$ as:

$$
\displaystyle{\bm{k}}^{(i)},{\bm{v}}^{(i)},{\bm{q}}^{(i)}
$$
 
$$
\displaystyle={\bm{W}}_{k}{\bm{x}}^{(i)},{\bm{W}}_{v}{\bm{x}}^{(i)},{\bm{W}}_{q}{\bm{x}}^{(i)}
$$
 
$$
\displaystyle\bar{{\bm{v}}}^{(i)}
$$
 
$$
\displaystyle={\bm{W}}^{(i-1)}\phi({\bm{k}}^{(i)})
$$
 
$$
\displaystyle\beta^{(i)}
$$
 
$$
\displaystyle=\sigma({\bm{W}}_{\beta}{\bm{x}}^{(i)})
$$
 
$$
\displaystyle{\bm{v}}^{(i)}_{\text{new}}
$$
 
$$
\displaystyle=\beta^{(i)}{\bm{v}}^{(i)}+(1-\beta^{(i)})\bar{{\bm{v}}}^{(i)}
$$

where ${\bm{W}}_{\beta}\in\mathbb{R}^{1\times d}$, and $\sigma$ is the sigmoid function. The interpolation weight $\beta^{(i)}$ is the “write-strength” as it defines to which extent the new value will replace the previous value. We note that while $\beta^{(i)}$ only depends on ${\bm{x}}^{(i)}$, in a multi-layer model, ${\bm{x}}^{(i)}$ has the full context information except in the first layer. We set ${\bm{W}}^{(0)}=0$ and ${\bm{z}}^{(0)}=0$. Then the fast weight update rule and the final output ${\bm{y}}^{(i)}$ are defined as follows (see Appendix A.1 for detailed derivations):

$$
\displaystyle{\bm{W}}^{(i)}
$$
 
$$
\displaystyle={\bm{W}}^{(i-1)}\underbrace{+{\bm{v}}^{(i)}_{\text{new}}\otimes\phi({\bm{k}}^{(i)})}_{\text{write}}\underbrace{-\bar{{\bm{v}}}^{(i)}\otimes\phi({\bm{k}}^{(i)})}_{\text{remove}}
$$
 
$$
\displaystyle={\bm{W}}^{(i-1)}+\beta^{(i)}({\bm{v}}^{(i)}-\bar{{\bm{v}}}^{(i)})\otimes\phi({\bm{k}}^{(i)})
$$
 
$$
\displaystyle{\bm{y}}^{(i)}
$$
 
$$
\displaystyle={\bm{W}}^{(i)}\phi({\bm{q}}^{(i)})
$$

As shown in Eq. 24, our programming instruction or update rule is effectively a delta rule with a dynamic learning rate $\beta^{(i)}$. The model thus learns to correct the current key to value association. In Appendix B, we formally show the advantage of this approach over the gated update rule concurrently proposed by [^48].

##### Normalisation.

In the equations above, no normalisation is applied to the value we retrieve. A straightforward normalisation can be obtained by following the derivation in Sec. 3.2, i.e. by introducing an accumulator:

$$
\displaystyle{\bm{z}}^{(i)}
$$
 
$$
\displaystyle={\bm{z}}^{(i-1)}+\phi({\bm{k}}^{(i)})
$$

and replacing Eqs. 20 and 25 respectively by:

$$
\displaystyle\bar{{\bm{v}}}^{(i)}
$$
 
$$
\displaystyle=\frac{{\bm{W}}^{(i-1)}\phi({\bm{k}}^{(i)})}{{\bm{z}}^{(i-1)}\cdot\phi({\bm{k}}^{(i)})}
$$
 
$$
\displaystyle{\bm{y}}^{(i)}
$$
 
$$
\displaystyle=\displaystyle\dfrac{{\bm{W}}^{(i)}\phi({\bm{q}}^{(i)})}{{\bm{z}}^{(i)}\cdot\phi({\bm{q}}^{(i)})}
$$

where we define $\bar{{\bm{v}}}^{(1)}=0$. In this approach, the output ${\bm{y}}^{(i)}$ is a weighted average of $\beta^{(j)}({\bm{v}}^{(j)}-\bar{{\bm{v}}}^{(j)})$ for $1\leq j\leq i$. We refer to this approach as attention normalisation.

This approach, however, has drawbacks. First, the accumulation of positive values in Eq. 26 always grows with the number of steps, and may result in instability. Second, specifically for our update rule, this normalisation is not sufficient to balance the weights between write and remove operations in Eq. 23 (see derivations in Appendix A.2). Here we propose a better approach based on simple normalisation. We divide the effective key and query vectors $\phi({\bm{k}}^{(i)})$ and $\phi({\bm{q}}^{(i)})$ by the sum of its components, e.g., for the query:

$$
\displaystyle\phi^{\prime}({\bm{q}}^{(i)})
$$
 
$$
\displaystyle=\displaystyle\dfrac{\phi({\bm{q}}^{(i)})}{\displaystyle\sum_{j=1}^{d_{\text{dot}}}\phi({\bm{q}}^{(i)})_{j}}
$$

before applying Eqs. 20-25. A general consequence of this normalisation is intuitively understood by noticing that the output of any matrix-vector operations (like Eq. 25) is a weighted sum of columns of the matrix where weights are the components of the vector; thus, if the vector components sum up to one, the operation can be viewed as an attention over the columns of the matrix. We provide further explanations and precise implications for our FWP in Appendix A.2. We refer to this approach as sum normalisation.

Since this is a simple substitution of $\phi({\bm{k}}^{(i)})$ and $\phi({\bm{q}}^{(i)})$ in Eqs. 20-25, one might still ask whether additional attention normalisation is needed. In language modelling experiments (Sec. 6.3), we show that this is not the case.

## 5 Linear Attention Functions

The central component of softmax linearisation (Sec. 3.2) is the $\phi$ function which maps key and query vectors to the space where the dot product is executed: $\mathbb{R}^{d_{\text{key}}}\rightarrow\mathbb{R}^{d_{\text{dot}}}$. We first list desirable properties of such a function, and review the existing $\phi$ functions from the perspective of fast weight memories. Finally, we also propose our own $\phi$ function.

### 5.1 Properties

For Eq. 13 to define proper attention weights between 0 and 1, the codomain of $\phi$ should be positive. Another property of $\phi$ derives from the discussion of memory capacity in Sec. 4.1. The dimensionality of its codomain $d_{\text{dot}}$ defines the model’s capacity. Therefore, by including a transformation which projects the input dimension $d_{\text{key}}$ to a larger dimension $d_{\text{dot}}$, the $\phi$ function can potentially increase the upper bound of the capacity.

### 5.2 Katharopoulos’ Linear Attention

[^26] propose to use the simple element-wise $\mathrm{ELU}+1$ function [^8]:

$$
\displaystyle\phi(x)=\mathrm{ELU}(x)+1=\begin{cases}x+1,&\text{if }x>0\\
\exp(x),&\text{if }x\leq 0\end{cases}
$$

The choice of $\mathrm{ELU}$ over $\mathrm{ReLU}$ is motivated by non-zero gradients on the negative part. Importantly, as a simple element-wise function, this $\phi$ function preserves the dimension of the input key vector ($d_{\text{key}}=d_{\text{dot}}$), without modifying the memory capacity as discussed in Sec. 4.1.

### 5.3 FAVOR+

In contrast to [^26] ’s $\phi$ function which merely satisfies positivity (and a good gradient) property, [^7] propose a mathematically rigorous method to approximate the softmax with random features. They propose the following $\phi$ function:

$$
\displaystyle h({\bm{x}})
$$
 
$$
\displaystyle=\frac{1}{\sqrt{2}}\exp(-\frac{||{\bm{x}}||^{2}}{2})
$$
 
$$
\displaystyle\phi({\bm{x}})
$$
 
$$
\displaystyle=\frac{h({\bm{x}})}{\sqrt{m}}\begin{bmatrix}\exp({\bm{R}}{\bm{x}})\\
\exp(-{\bm{R}}{\bm{x}})\end{bmatrix}
$$

where the concatenation $\begin{bmatrix}{\bm{a}}\\
{\bm{b}}\end{bmatrix}$ of two vectors ${\bm{a}}$ and ${\bm{b}}$ is along the feature dimension, and ${\bm{R}}\in\mathbb{R}^{m\times d_{\textit{key}}}$ is a matrix with $m$ random features where each row vector ${\bm{r}}\in\mathbb{R}^{1\times d_{\textit{key}}}$ is drawn from $\mathcal{N}(0,\mathbf{I}_{d_{\text{key}}})$. A similar approach is also proposed by [^48].

With FAVOR+, the dimension of the codomain $d_{\text{dot}}$ is $2m$ which increases the theoretical capacity of the memory if $2m>d_{\text{key}}$. At the same time, the model’s capacity is still limited, and equals the infinite capacity of the softmax memory only when $m$ goes to infinity, which is never achieved in practice. During training, we redraw these $m$ random vectors for each mini-batch. During evaluation, we draw a set of $m$ random vectors once, and keep them fixed. $m$ is the only hyperparameter of FAVOR+ and influences the quality of the softmax approximation. [^7] suggest to choose $m$ in the order of $d_{\textit{key}}\log(d_{\textit{key}})$. This sampling process is the main drawback of FAVOR+ as it introduces variance into the model’s output.

### 5.4 Deterministic Parameter-Free Projection (DPFP)

The two previous sub-sections highlight the sub-optimality of the existing $\phi$ functions. Sampling introduces extra complexity to FAVOR+ (Sec. 5.3), while the Linear Transformer (Sec. 5.2) lacks the ability to project up the dot product dimension. Here we propose an alternative approach called deterministic parameter-free projection (DPFP). It is deterministic and easy to compute like Linear Transformers while increasing the dot product dimension without requiring FAVOR+’s random features.

We begin with a low-dimensional example to foster an intuitive understanding before moving on to the general formulation. Consider 4 keys ${\bm{k}}^{(i)},i\in\{1,2,3,4\}$ in $\mathbb{R}^{2}$ and $\phi:\mathbb{R}^{2}\rightarrow\mathbb{R}^{4}_{\geq 0}$ where the $l$ -th element of $\phi({\bm{x}})$ is generated by the partial function $\phi_{l}:\mathbb{R}^{2}\rightarrow\mathbb{R}_{\geq 0}$. We design $\phi$ such that it facilitates orthogonality in the projected space, i.e. $\phi({\bm{k}}^{(i)})\cdot\phi({\bm{k}}^{(j)})=0$ for $i\neq j$. Towards this end, we construct $\phi$ such that if $\phi_{l}({\bm{x}})>0$ then $\phi_{n}({\bm{x}})=0$ for all $n\neq l$. Such a constraint can be enforced by limiting the domains of the partial functions to be non-overlapping. With the element-wise rectifier function $r(a)=\max(0,a)$ the partial functions are defined as:

$$
\displaystyle\phi_{1}({\bm{k}})
$$
 
$$
\displaystyle=r({\bm{k}}_{1})r({\bm{k}}_{2})
$$
 
$$
\displaystyle\phi_{2}({\bm{k}})
$$
 
$$
\displaystyle=r(-{\bm{k}}_{1})r({\bm{k}}_{2})
$$
 
$$
\displaystyle\phi_{3}({\bm{k}})
$$
 
$$
\displaystyle=r({\bm{k}}_{1})r(-{\bm{k}}_{2})
$$
 
$$
\displaystyle\phi_{4}({\bm{k}})
$$
 
$$
\displaystyle=r(-{\bm{k}}_{1})r(-{\bm{k}}_{2})
$$

Figure 1 illustrates this function. The elements of the 4-dimensional space are displayed as the $z$ component of the four coloured surfaces. The figure shows how each vector in the 2d plane will have a single non-zero component in the 4d space and equally splits the input space into four areas which will be orthogonal in the projected space.

![Refer to caption](https://ar5iv.labs.arxiv.org/html/2102.11174/assets/images/3dplot.png)

Refer to caption

We generalise this method to higher dimensional inputs by constructing additional two-factor features. Given an input vector ${\bm{k}}\in\mathbb{R}^{d_{\text{key}}}$ and $i\in[1,2d_{\text{key}}]$, the partial function

$$
\displaystyle\phi_{i\nu}({\bm{k}})=r(\begin{bmatrix}{\bm{k}}\\
-{\bm{k}}\end{bmatrix})_{i}r(\begin{bmatrix}{\bm{k}}\\
-{\bm{k}}\end{bmatrix})_{i+\nu}
$$

where $\nu\in\{1,2,..,d_{\text{key}}2-1\}$ is a capacity controlling hyperparameter. The codomain dimensionality of $\phi({\bm{k}})$ is thus $d_{\text{dot}}=2d_{\text{key}}\nu$. Eq. 37 is highly parallelisable because each partial function can be computed independently. This can be implemented in few lines of code as we show in Appendix C.

Finally we note that [^7] empirically show that replacing $\exp$ in Eq. 32 by $\mathrm{ReLU}$ typically improves model performance. While this result has not been theoretically justified, it supports the design of our DPFP which aims for sparsity and orthogonality.

## 6 Experimental Results

Now we present our experimental results on synthetic retrieval problems (Sec. 6.1.1 and 6.1.2), machine translation (Sec. 6.2), and language modelling (Sec. 6.3).

### 6.1 Synthetic Settings

We illustrate the capacity issue (Sec. 4.1) of linear attention and the effectiveness of our new update rule (Sec. 4.2) on two synthetic problems.

In both settings, our toy problem consists of retrieving the correct value from a sequence of randomly sampled key-value associations when queried with one of the used keys. Crucially, the query is given at the end of the sequence, such that the model is not aware of it while processing the inputs. To succeed, the model has to learn to store the observed associations in its memory without interference.

Let $\mathcal{K}$ and $\mathcal{V}$ be the finite and fixed sets of keys and values and $S=|\mathcal{K}|=|\mathcal{V}|$. Then, the input to the model is the sequence $[(\mathsf{k},\mathsf{v})_{1},...,(\mathsf{k},\mathsf{v})_{L}]$ followed by $\mathsf{q}$ where every pair $(\mathsf{k},\mathsf{v})\in\mathcal{K}\times\mathcal{V}$ is sampled randomly, and $\mathsf{q}$ is randomly chosen to be one of the $L$ keys.

Each value $\mathsf{v}^{(i)},i\in[1,..,S]$ is assigned a fixed one-hot vector ${\bm{v}}^{(i)}\in\mathbb{R}^{S}$. Hence, the set of value vectors is an orthonormal basis. In contrast, the vector embedding of the key symbols is the learned function $e:\mathcal{K}\rightarrow\mathbb{R}^{d_{\text{emb}}}$ and ${\bm{k}}={\bm{W}}_{K}[e(\mathsf{k});{\bm{v}}]$ where ${\bm{W}}_{K}\in\mathbb{R}^{d_{\text{key}}\times(d_{\text{emb}}+S)}$.

Following the $L$ write operations, the read function and the query vector ${\bm{q}}={\bm{W}}_{Q}e(\mathsf{q}),{\bm{W}}_{Q}\in\mathbb{R}^{d_{\text{key}}\times d_{\text{emb}}}$ are used to retrieve $\hat{{\bm{v}}}\in\mathbb{R}^{S}$ from memory. Finally, the loss is defined as $l(\hat{{\bm{v}}},{\bm{v}}^{*})=\sum_{j}^{S}\frac{1}{2}({\bm{v}}^{*}_{j}-\hat{{\bm{v}}}_{j})^{2}$ where ${\bm{v}}^{*}$ is the value vector assigned to $\mathsf{q}$ in the input sequence. Each model is trained in mini-batches using this loss and Adam with default hyperparameters unless stated otherwise. For evaluation, we sample 20 sequences and test all possible queries, e.g., with $S=100$ unique keys, the evaluation batch is of size $100*20=2000$.

#### 6.1.1 Setting 1: Testing Capacity

In this setting, we experimentally demonstrate the capacity limit of linear attention (Sec. 4.1). We conduct experiments for the various $\phi$ functions described in Sec. 5. We fix $d_{\text{key}}$ to be $64$, while different $\phi$ functions produce different $d_{\text{dot}}$. We set the sequence length to be equal to the number of unique keys ($L=S$), and sample the keys and values without replacement to generate the sequences. By varying the sequence length $S$, our goal is to show that all linear attention models (using the simple sum update rule of Sec. 3.2) fail at retrieving when $S$ exceeds $d_{\text{dot}}$.

All models are trained with a mini-batch size of $32$ until the evaluation loss falls below $0.001$ or until lack of progress for $1000$ steps. In Figure 2, the best validation set performance for each model and each $S$ is displayed (for the learning curves see Appendix D.1). The number of unique keys is initially $S=20$ and is incremented by $20$ until $S=600$. The following models are compared: Softmax, Linear-Attention, FAVOR+ with 64, 128, and 512 random features, DPFP- $\nu$ with $\nu\in\{1,2,3\}$.

![Refer to caption](https://ar5iv.labs.arxiv.org/html/2102.11174/assets/images/setting1.png)

Refer to caption

The results support our theoretical analysis. Linear-Attention has a capacity of $64$ due to the choice of $d_{\text{key}}=d_{\text{dot}}=64$. Experimentally, Linear-Attention begins to accumulate errors with $60$ or more associations. Similarly, DPFP projections 1, 2 and 3 start to accumulate errors as they approach their respective limits at $128$, $256$, and $384$. FAVOR+, on the other hand, fails to achieve a loss of 0 in any experiment. Finally, as expected, softmax attention is outperforming all $\phi$ functions, although it struggles to fully converge with more than 500 keys.

#### 6.1.2 Setting 2: Comparing Update Rules

In the second setting, we compare variations of the update rule. Unlike in setting 1, keys and values will be sampled with replacement and sequence length $L=2S$. As a result, in the same sequence, multiple keys can be re-assigned to a new value more than once. The expected value to retrieve is the most recent one associated with the query. With every new key, the previous value associated with this key deprecates and the model is required to update its finite size memory. The ability to update values associated with keys is essential to bind context-specific values to a key.

We use DPFP-1 as the $\phi$ function. The sequence length is fixed at 40 with 20 unique keys and values. While this setting does not exceed the capacity of DPFP-1, our result is independent of the capacity regime (see results for different $S$ and $\phi$ in Appendix D.2).

We compare the proposed fast weight memory programming instruction with normalisation of Sec. 4.2 (denoted here by ours) to three baselines: the sum update rule of Sec. 3 (sum rule), and two variants of previous update rules [^56]: Schlag (2021) and Schlag (2021) with DPFP. Schlag (2021) is simply the model from [^56] ported to this setting (i.e. without the LSTM layer). Schlag (2021) has neither a $\phi$ function, nor the sum normalisation term of Sec. 4.2. Instead it uses a $\tanh$ nonlinearity for its key representations. As an ablation we replace it with our DPFP-1 but we don’t use the normalisation term of Sec. 4.2, which we refer to as Schlag (2021) with DPFP.

Figure 3 presents the learning curves. They demonstrate that our new update rule outperforms all other variants. As expected, the baseline sum update rule fails.

![Refer to caption](https://ar5iv.labs.arxiv.org/html/2102.11174/assets/images/setting2.png)

Refer to caption

### 6.2 Machine Translation Experiments

Here we compare $\phi$ functions on the standard machine translation task. We compare Linear Transformer [^26], Performer [^7] and our $\phi$ function DPFP (Sec. 5.4) to the regular Transformer, complementing prior comparisons, e.g., [^67].

We use the standard WMT14 English to German Translation dataset and standard data setups [^42] [^69]. We adapt the recipe of [^43] (see Appendix E) and train [^69] ’s “big” models for about 4 days on three V100 GPUs. We use the exact same training configurations for all models without model-specific hyper-parameter tuning. We only vary the model hyper-parameters $m$ in Performers and $\nu$ in DPFP models.

Table 1 shows the Bleu score [^45] [^50] results. The Performer is as good as the basic Transformer when the number of samples $m$ is large enough (for $d_{\text{dot}}=512$, we have $m=256$). In fact, with $d_{\text{key}}=64$, the recommended value for $m$ is $d_{\text{dot}}\log(d_{\text{dot}})=266$. Our DPFP model outperforms the Linear Transformer as well as the Performer when $d_{\text{dot}}$ is relatively small; providing a good trade-off between simplicity and performance.

Table 1: WMT14 En-De Translation Bleu scores for various Transformer models. Neither model averaging, nor model specific tuning is done. Standard denotes the basic Transformer.

<table><thead><tr><th></th><th colspan="3">Valid</th><th colspan="3">Test</th></tr><tr><th><math><semantics><msub><mi>d</mi> <mtext>dot</mtext></msub> <annotation>d_{\text{dot}}</annotation></semantics></math></th><th>64</th><th>256</th><th>512</th><th>64</th><th>256</th><th>512</th></tr></thead><tbody><tr><th>Standard</th><td>26.6</td><td>-</td><td>-</td><td>27.7</td><td>-</td><td>-</td></tr><tr><th>Linear</th><td>25.5</td><td>-</td><td>-</td><td>26.8</td><td>-</td><td>-</td></tr><tr><th>Performer</th><td>24.2</td><td>24.9</td><td>26.7</td><td>24.4</td><td>25.3</td><td>27.7</td></tr><tr><th>DPFP (ours)</th><td>-</td><td>26.2</td><td>26.2</td><td>-</td><td>26.9</td><td>27.1</td></tr></tbody></table>

### 6.3 Language Modelling Experiments

Toy experimental Setting 2 (Sec. 6.1.2) illustrated the effect of our update rule. Now our goal is to confirm its effectiveness on a large-vocabulary word-level language modelling task, and investigate its further potential.

##### Experimental setups.

Our update rule should be evaluated on a dataset with sufficiently long contextual dependencies. We use the standard WikiText-103 [^35] dataset. WikiText-103 consists of long articles from Wikipedia; the training set contains about 28 K articles with a total of 103 M running words. This results in contextual text blocks of about 3600 words. The validation and test sets also contain similarly long dependencies, respectively with 218 K and 246 K running words for 60 articles each. The vocabulary size is about 268 K words.

We split the training data into $L$ -word long segments (which is the backpropagation span). Unless stated otherwise, we treat these segments independently during training. For evaluation, we use a batch size of one, and go through the text with a sliding window of size $L$, taking into account only the last position for computing perplexity (except in the first segment where all positions are evaluated). This is usually done for Transformers with a limited context [^1]. Appendix F provides further experimental details.

Table 2: WikiText-103 language model perplexity results showing effects of our update rule. The number of trainable parameters are almost the same for all models, up to the small difference introduced by gating in our update rule (16 K and 33 K parameters respectively for the small and medium configurations). We have $D=128$, $L=256$ (40 M parameters) in the small, and $D=256$, $L=384$ (90 M parameters) in the medium configuration. For Performers, $m$ is $8$ and $16$, respectively.

<table><tbody><tr><th></th><th>Update</th><td colspan="2">small</td><td colspan="2">medium</td></tr><tr><th></th><th>Rule</th><td>Valid</td><td>Test</td><td>Valid</td><td>Test</td></tr><tr><th>Transformer</th><th>-</th><td>33.0</td><td>34.1</td><td>27.9</td><td>29.6</td></tr><tr><th>Linear Transformer</th><th>sum</th><td>37.1</td><td>38.3</td><td>31.1</td><td>33.0</td></tr><tr><th>Delta Network</th><th>delta</th><td>34.1</td><td>35.5</td><td>29.7</td><td>31.5</td></tr><tr><th>Performer</th><th>sum</th><td>39.0</td><td>39.6</td><td>32.2</td><td>33.8</td></tr><tr><th></th><th>delta</th><td>36.1</td><td>37.2</td><td>30.0</td><td>31.8</td></tr></tbody></table>

##### Effectiveness of our new update rule.

We first evaluate our update rule in two configurations. In the small configuration, we set the model dimension (same for key, value, and query) $D$ to 128, and the training and evaluation context length $L$ to 256. We note that $D=H*d_{\text{dot}}$ where $H$ is the number of heads. $H$ is set to 8. The feed-forward layer dimension is 2048. The number of layers is 16 in all configurations. In the medium configuration, we set $D=256$ and $L=384$. Both configurations represent an overcapacity regime. We evaluate both Linear Transformers [^26] and Performers [^7]. However, to keep the comparison simple, we set the capacity of Performers (Sec. 5.3) equal to the one of linear Transformers, by the right choice of projection dimension ($m=8$ and $m=16$, respectively, in small and medium configurations), even though this limits performance. We do not include DPFP here, since in both configurations even the smallest value for $\nu$ provides enough capacity. Here we investigate the effect of the update rule in an overcapacity scenario (see Appendix D.3 for experimental results in a non-overcapacity regime including DPFP). All models can be trained using two V100 GPUs in less than four days. We refer to the Linear Transformer with our delta update rule as a Delta Network. Table 2 shows the perplexity results. In both configurations, our update rule provides convincing improvements over the models with the sum update rule.

We also conduct an ablation study to test the effect of the absolute positional encoding and an extra attention normalisation (Sec. 4.2). Table 3 shows the results. The sum normalisation (Sec. 4.2) is used in all cases: the models diverged otherwise. In contrast, better perplexities are obtained when no additional attention normalisation is applied. We also observe that the absolute positional encoding is not needed, confirming results of prior work [^22].

Table 3: WikiText-103 language model perplexities for Linear Transformers (medium configuration) with our update rule.

| Position Encoding | Attn. Normalisation | Valid | Test |
| --- | --- | --- | --- |
| Yes | Yes | 30.4 | 32.1 |
| No | Yes | 29.2 | 31.2 |
| Yes | No | 29.7 | 31.5 |
| No | No | 28.1 | 31.1 |

Table 4: WikiText-103 language model perplexities when the model is trained and evaluated without truncating context, as opposed to Table 2 where the context window is limited. The medium config is used. Neither positional encoding nor attention normalisation is used for the Delta Net. The numbers of trainable parameters (Prms.) are given in millions. We compare with the Transformer-XL at different memory segment lengths. This results in different state sizes which are proportional to the memory requirements during evaluation, and highlights the memory efficiency of the Delta Network. The state sizes are given in millions.

<table><tbody><tr><th>Model</th><td>Prms.</td><td>State size</td><td colspan="2">Perplexity</td></tr><tr><th></th><td>in M.</td><td>in M.</td><td>Valid</td><td>Test</td></tr><tr><th>Linear Transformer</th><td>89.8</td><td>0.13</td><td><math><semantics><mo>></mo> <annotation>></annotation></semantics></math> 260  </td><td><math><semantics><mo>></mo> <annotation>></annotation></semantics></math> 260  </td></tr><tr><th>Delta Network</th><td>89.9</td><td>0.13</td><td>27.8</td><td>29.4</td></tr><tr><th>Transformer-XL</th><td>90.9</td><td>0.13</td><td>65.7</td><td>65.5</td></tr><tr><th></th><td></td><td>1.05</td><td>29.3</td><td>30.1</td></tr><tr><th></th><td></td><td>2.10</td><td>26.4</td><td>27.4</td></tr><tr><th></th><td></td><td>6.29</td><td>24.6</td><td>25.5</td></tr></tbody></table>

##### Complexity, wall clock time, memory.

All methods we propose are within the framework of “linear Transformers”. Thus, there is no change to be discussed in terms of complexity which is constant in space and linear in time w.r.t. sequence length. However, our modified update rule introduces a few extra computations. The wall clock time and memory requirement (for the small LM setting) for the Linear Transformer with and without our delta update rule are: 63 K and 66 K words/sec, and 14 and 13 GB respectively in our implementation. The extra resource requirement is thus marginal. As we use custom CUDA kernels for these linear Transformers, they are faster than the regular Transformers implemented in PyTorch which process 33K words/sec and require 17 GB memory. The speed of the DPFP and Performer models (for Table 5 in Appendix with a larger $d_{\text{dot}}$) are 63 K and 57 K words/sec. Performers are slower because of the sampling logic, which also motivates our DPFP.

##### Without truncating context.

Given the constant space requirements, we can feed inputs to linear Transformers for an arbitrary number of steps. To properly assess the model’s ability to process arbitrary long sequences, it is crucial to make the training consistent with the evaluation mode [^23]. During training, we carry over the fast weight memory from one training segment to the following one, while still limiting the backpropagation span to be within the segment. We train a Delta Net, using neither positional encoding nor attention normalisation (the best setting from Table 3). It was crucial to remove the attention normalisation for the Delta Net since the accumulator blows up as indicated in Sec. 4.2, while for the Linear Transformer, removing it resulted in an even worse perplexity of over 1600. Table 4 shows the corresponding results. The Delta Net yields a slight improvement over the best model with a limited context window (Table 3), unlike the baseline Linear Transformer model with the naive sum update rule which breaks. We also train a Transformer-XL in our medium configuration as a baseline model specifically designed for this use case [^9] [^52]. We evaluate it using different state sizes by changing the Transformer XL’s memory and target segment lengths (see Appendix F for further details). Performance of the Delta Net does not yet match the performance of the Transformer XL when the latter is evaluated with a large state size (large attention window). However, when we take the state size into account (Table 4), we observe that the Delta Net performs very well with a small state size, which is a crucial property in some practical applications [^24]. These results are promising for future work on alternative Transformer models which can run for an unlimited number of steps.

## 7 Conclusion

We emphasise the connection between linearised self-attention and Fast Weight Programmers (FWPs, 1991) that program their fast weight memories through sequences of outer products between self-invented key and value patterns. The FWP perspective allows for discussing associative memory capacity limitations of linear attention, and for introducing an alternative differentiable elementary programming instruction that the FWP can use to dynamically edit the memory, akin to the famous delta rule, but such that the FWP can learn to use the rule wisely through gradient descent. We also propose and discuss a new method for linearising attention. Experiments on synthetic and real language tasks demonstrate the effectiveness of our proposals. The FWP perspective opens up new avenues for investigating even better programming instructions and designs for Transformers with finite memory.

## Acknowledgements

We thank Sjoerd van Steenkiste, Hubert Ramsauer and Sepp Hochreiter for valuable comments and suggestions on the first version of the manuscript. This research was partially funded by ERC Advanced grant no: 742870, project AlgoRNN, and by Swiss National Science Foundation grant no: 200021\_192356, project NEUSYM. We thank NVIDIA Corporation for donating several DGX machines, and IBM for donating a Minsky machine. We also thank [^26] for releasing their CUDA implementation of Linear Transformers, which was helpful to implement our models.

## References

## Appendix A Update Rule Derivation

### A.1 The Update Rule

Here we provide the intermediate steps from Eq. 23 to Eq. 24.

$$
\displaystyle{\bm{W}}^{(i)}
$$
 
$$
\displaystyle={\bm{W}}^{(i-1)}\underbrace{+{\bm{v}}^{(i)}_{\text{new}}\otimes\phi({\bm{k}}^{(i)})}_{\text{write}}\underbrace{-\bar{{\bm{v}}}^{(i)}\otimes\phi({\bm{k}}^{(i)})}_{\text{remove}}
$$
 
$$
\displaystyle={\bm{W}}^{(i-1)}+\beta^{(i)}({\bm{v}}^{(i)}-\bar{{\bm{v}}}^{(i)})\otimes\phi({\bm{k}}^{(i)})
$$

By grouping the last two terms, Eq. 23 becomes:

$$
\displaystyle{\bm{W}}^{(i)}
$$
 
$$
\displaystyle={\bm{W}}^{(i-1)}+({\bm{v}}^{(i)}_{\text{new}}-\bar{{\bm{v}}}^{(i)})\otimes\phi({\bm{k}}^{(i)})
$$

By using the definition of ${\bm{v}}^{(i)}_{\text{new}}$ from Eq. 22:

$$
\displaystyle{\bm{v}}^{(i)}_{\text{new}}
$$
 
$$
\displaystyle=\beta^{(i)}{\bm{v}}^{(i)}+(1-\beta^{(i)})\bar{{\bm{v}}}^{(i)}
$$

we obtain:

$$
\displaystyle{\bm{v}}^{(i)}_{\text{new}}-\bar{{\bm{v}}}^{(i)}
$$
 
$$
\displaystyle=\beta^{(i)}{\bm{v}}^{(i)}+(1-\beta^{(i)})\bar{{\bm{v}}}^{(i)}-\bar{{\bm{v}}}^{(i)}
$$
 
$$
\displaystyle=\beta^{(i)}({\bm{v}}^{(i)}-\bar{{\bm{v}}}^{(i)})
$$

By substituting this expression to Eq. 38, we obtain Eq. 24 ∎.

### A.2 Key Sum Normalisation

By considering one-hot vectors $\{{\bm{e}}^{(1)},...,{\bm{e}}^{(i)},...,{\bm{e}}^{(d_{\text{key}})}\}$ which form the Cartesian basis of $\mathbb{R}^{d_{\text{key}}}$, any matrix ${\bm{W}}\in\mathbb{R}^{d_{\text{value}}\times d_{\text{key}}}$ can be written as

$$
\displaystyle{\bm{W}}=\displaystyle\sum_{i=1}^{d_{\text{key}}}{\bm{w}}^{(i)}\otimes{\bm{e}}^{(i)}
$$

where $\{{\bm{w}}^{(1)},...,{\bm{w}}^{(i)},...,{\bm{w}}^{(d_{\text{key}})}\}$ are the column vectors of ${\bm{W}}$. In the context of associative memory, we can interpret this expression as a set of associations with fixed keys ${\bm{e}}^{(i)}$ and the associated values ${\bm{w}}^{(i)}$.

In this view, any update of ${\bm{W}}$ can be written as updates of each ${\bm{w}}^{(i)}$. This perspective allows us to derive the sum normalisation of Sec. 4.2. For that, we start by deriving the update of ${\bm{w}}^{(i)}$.

Given an arbitrary weight ${\bm{W}}$, we consider updating it to ${\bm{W}}^{\prime}$ by adding a new association $({\bm{k}},{\bm{v}})$ using our update rule of Sec. 4.2 (where we omit $\beta$):

$$
\displaystyle\bar{{\bm{v}}}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle{\bm{W}}{\bm{k}}
$$
 
$$
\displaystyle{\bm{W}}^{\prime}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle{\bm{W}}+({\bm{v}}-\bar{{\bm{v}}})\otimes{\bm{k}}
$$

By substituting ${\bm{k}}$ in Eq. 43 by its expression in the Cartesian basis $\displaystyle{\bm{k}}=\sum_{i=1}^{d_{\text{key}}}k_{i}{\bm{e}}^{(i)}$ with $k_{i}\in\mathbb{R}$, we obtain:

$$
\displaystyle{\bm{W}}^{\prime}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle{\bm{W}}+({\bm{v}}-\bar{{\bm{v}}})\otimes\sum_{i=1}^{d_{\text{key}}}k_{i}{\bm{e}}^{(i)}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle{\bm{W}}+\sum_{i=1}^{d_{\text{key}}}k_{i}({\bm{v}}-\bar{{\bm{v}}})\otimes{\bm{e}}^{(i)}
$$

Now by substituting ${\bm{W}}$ by its expression of Eq. 41:

$$
\displaystyle{\bm{W}}^{\prime}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\sum_{i=1}^{d_{\text{key}}}{\bm{w}}^{(i)}\otimes{\bm{e}}^{(i)}+\sum_{i=1}^{d_{\text{key}}}k_{i}({\bm{v}}-\bar{{\bm{v}}})\otimes{\bm{e}}^{(i)}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\sum_{i=1}^{d_{\text{key}}}\big({\bm{w}}^{(i)}+k_{i}({\bm{v}}-\bar{{\bm{v}}})\big)\otimes{\bm{e}}^{(i)}
$$

The column-wise update is thus:

$$
\displaystyle{\bm{w}}^{\prime(i)}={\bm{w}}^{(i)}+k_{i}({\bm{v}}-\bar{{\bm{v}}})
$$

We can explicitly write down $\bar{{\bm{v}}}$ as:

$$
\displaystyle\bar{{\bm{v}}}={\bm{W}}{\bm{k}}={\bm{W}}\sum_{j=1}^{d_{\text{key}}}k_{j}{\bm{e}}^{(j)}=\sum_{j=1}^{d_{\text{key}}}k_{j}{\bm{w}}^{(j)}
$$

which we can substitute in Eq. 48 to obtain:

$$
\displaystyle{\bm{w}}^{\prime(i)}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle{\bm{w}}^{(i)}+k_{i}({\bm{v}}-\sum_{j=1}^{d_{\text{key}}}k_{j}{\bm{w}}^{(j)})
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle{\bm{w}}^{(i)}+k_{i}{\bm{v}}-\sum_{j=1}^{d_{\text{key}}}k_{i}k_{j}{\bm{w}}^{(j)}
$$

In Eq. 51, the weight $k_{i}$ on the positive term ${\bm{v}}$ is in general not equal to the total weights on the negative terms $\sum_{j=1}^{d_{\text{key}}}k_{i}k_{j}$. We can force these weights to be balanced by introducing the normalisation: $\displaystyle\sum_{j=1}^{d_{\text{key}}}k_{i}k_{j}=k_{i}$.

If $k_{i}$ is non zero, we obtain:

$$
\displaystyle\sum_{j=1}^{d_{\text{key}}}k_{j}=1
$$

This corresponds to the sum normalisation we introduced in Sec. 4.2 ∎.

## Appendix B Formal comparison to

Concurrently to our work, [^48] proposed the following gated update rule:

$$
\displaystyle{\bm{W}}^{(i)}=(1-\beta^{(i)}){\bm{W}}^{(i-1)}+\beta^{(i)}{\bm{v}}^{(i)}\otimes\phi({\bm{k}}^{(i)})
$$

which is motivated by the gating mechanism in recurrent neural networks [^20]. In contrast, our update rule of Eq. 24

$$
\displaystyle{\bm{W}}^{(i)}={\bm{W}}^{(i-1)}+\beta^{(i)}({\bm{v}}^{(i)}-\bar{{\bm{v}}}^{(i)})\otimes\phi({\bm{k}}^{(i)})
$$

is driven by an associative memory perspective, relates to the famous error-correcting delta rule, and offers a crucial property.

To illustrate a similarity and a crucial difference between the two update rules, we consider a fast weight matrix ${\bm{W}}$ which is constructed by two associations $({\bm{k}}_{1},{\bm{v}}_{1})$ and $({\bm{k}}_{2},{\bm{v}}_{2})$, i.e.

$$
\displaystyle{\bm{W}}={\bm{v}}_{1}\otimes{\bm{k}}_{1}+{\bm{v}}_{2}\otimes{\bm{k}}_{2}
$$

where we assume ${\bm{k}}_{1}$ and ${\bm{k}}_{2}$ to be orthonormal, and we omit $\phi$. Now we consider updating ${\bm{W}}$ to ${\bm{W}}^{\prime}$ by adding a new association $({\bm{k}}_{3},{\bm{v}}_{3})$ where ${\bm{k}}_{3}={\bm{k}}_{2}$. Using [^48] ’s update rule, we have:

$$
\displaystyle{\bm{W}}^{\prime}=(1-\beta){\bm{W}}+\beta{\bm{v}}_{3}\otimes{\bm{k}}_{3}
$$

This rule thus updates the value associated with the key ${\bm{k}}_{2}={\bm{k}}_{3}$ to be a convex combination of the old and the new values $(1-\beta){\bm{v}}_{2}+\beta{\bm{v}}_{3}$:

$$
\displaystyle{\bm{W}}^{\prime}{\bm{k}}_{3}
$$
 
$$
\displaystyle=(1-\beta){\bm{W}}{\bm{k}}_{3}+\beta{\bm{v}}_{3}
$$
 
$$
\displaystyle=(1-\beta){\bm{v}}_{2}+\beta{\bm{v}}_{3}
$$

However, it also modifies or in the worst case erases the value associated with the key ${\bm{k}}_{1}$:

$$
\displaystyle{\bm{W}}^{\prime}{\bm{k}}_{1}
$$
 
$$
\displaystyle=(1-\beta){\bm{W}}{\bm{k}}_{1}=(1-\beta){\bm{v}}_{1}
$$

In contrast, using our update rule, we have:

$$
\displaystyle{\bm{W}}^{\prime}={\bm{W}}+\beta({\bm{v}}_{3}-{\bm{v}}_{2})\otimes{\bm{k}}_{3}
$$

since $\bar{{\bm{v}}}={\bm{W}}{\bm{k}}_{3}={\bm{W}}{\bm{k}}_{2}={\bm{v}}_{2}$.  
Our rule thus also updates the value associated with the key ${\bm{k}}_{2}={\bm{k}}_{3}$ to be a convex combination of the old and the new values $(1-\beta){\bm{v}}_{2}+\beta{\bm{v}}_{3}$:

$$
\displaystyle{\bm{W}}^{\prime}{\bm{k}}_{3}
$$
 
$$
\displaystyle={\bm{W}}{\bm{k}}_{3}+\beta({\bm{v}}_{3}-{\bm{v}}_{2})
$$
 
$$
\displaystyle={\bm{v}}_{2}+\beta({\bm{v}}_{3}-{\bm{v}}_{2})
$$
 
$$
\displaystyle=(1-\beta){\bm{v}}_{2}+\beta{\bm{v}}_{3}
$$

while crucially, it keeps the value associated with ${\bm{k}}_{1}$ unmodified:

$$
\displaystyle{\bm{W}}^{\prime}{\bm{k}}_{1}
$$
 
$$
\displaystyle={\bm{W}}{\bm{k}}_{1}={\bm{v}}_{1}
$$

Our update rule thus differs from [^48] ’s one on this property of updating associations while keeping other “unrelated” ones intact in an associative memory.

## Appendix C DPFP-ν\\nu Implementation

Listing 1 is a simple PyTorch implementation of DPFP- $\nu$ (Eq. 37) which consist of two concatenations followed by one element-wise multiplication.

⬇

import torch

from torch import cat

from torch.nn.functional import relu as r

def dpfp(x, nu=1):

x = cat(\[r(x), r(-x)\], dim=-1)

x\_rolled = cat(\[x.roll(shifts=j, dims=-1)

for j in range(1,nu+1)\], dim=-1)

x\_repeat = cat(\[x\] \* nu, dim=-1)

return x\_repeat \* x\_rolled

Listing 1: Simple PyTorch implementation of DPFP- $\nu$ (Eq. 37).

## Appendix D Additional Experimental Results

In this section, we provide additional experimental results which we could not include in the main paper because of space limitations.

### D.1 Synthetic Task Setting 1

Figure 4 shows learning curves for the synthetic setting 1 (without replacement) with 600 unique keys and values. The scripts used to generate such figures can be found in our GitHub repository.

![Refer to caption](https://ar5iv.labs.arxiv.org/html/2102.11174/assets/images/setting1_600.png)

Refer to caption

### D.2 Synthetic Task Setting 2

Figure 5 is a capacity plot for setting 2 with an increasing number of unique keys and queries (analogous to Figure 2 of setting 1 apart from the log-scale of the y-axis). We did not include FAVOR+ in this plot, because its combination with our update rule resulted in not-a-number in this setting.

![Refer to caption](https://ar5iv.labs.arxiv.org/html/2102.11174/assets/images/setting2_all.png)

Refer to caption

### D.3 Language Modelling

In Sec. 6.3, we evaluated our update rule when the model is under overcapacity regime. Here we present an extra language modelling experiment which evaluate the benefits of our update rule in non-overcapacity scenarios. This also allows us to include DPFP in the evaluation. We train both, Performer and DPFP, in the small setting ($D=128$, $L=256$) with $m=16$ and $\nu=1$, resulting in $d_{\text{dot}}=256$ for both cases. Table 5 shows the perplexity results. First we observe that the Performer and DPFP baseline models with the sum update rule do not outperform the Linear Transformer baseline from Table 2. In fact, language modelling might be less affected by the capacity issue than the synthetic retrieval task, as it might not require the exact retrieval. Second we observe that our update rule improves both variants of linear attention over the sum update-rule baselines even in this condition. This indicates the general benefits of our update rule in Fast Weight Programmers. We note that the improvement is larger for the DPFP model than for the Performer. This is similar to Table 2 where our update rule improves the deterministic Linear Transformers more than the Performers. Finally, we note that we also tried the DPFP and Performer models with an increased $d_{\text{dot}}$ by setting $\nu=2$ and $m=32$ respectively. While this increases $d_{\text{dot}}$ by a factor of two, it was not beneficial for this language modelling setting.

Table 5: WikiText-103 language model perplexity results showing effects of our update rule in non-overcapacity regime. The number of trainable parameters are almost the same for all models, up to the small difference introduced by gating in our update rule (16 K parameters). The small config is used, i.e. $D=128$, $L=256$ (40 M parameters). We set $m=16$ for the Performers and $\nu=1$ for the DPFP models, which result in $d_{\text{dot}}=256$ for both cases. The model is thus not necessary in an overcapacity regime.

<table><tbody><tr><th></th><th>Update</th><td colspan="2">small</td></tr><tr><th></th><th>Rule</th><td>Valid</td><td>Test</td></tr><tr><th>Transformer</th><th>-</th><td>33.0</td><td>34.1</td></tr><tr><th>Performer</th><th>sum</th><td>38.0</td><td>38.8</td></tr><tr><th></th><th>delta</th><td>36.0</td><td>37.0</td></tr><tr><th>DPFP</th><th>sum</th><td>37.7</td><td>38.8</td></tr><tr><th></th><th>delta</th><td>33.9</td><td>35.0</td></tr></tbody></table>

## Appendix E Details on Machine Translation Experiments

We implemented different $\phi$ functions in the fairseq tookit [^43]. The Transformer architecture used in the experiment is the one referred to as big in the original Transformer paper [^69]: the model has 6 layers each in the encoder and the decoder, with a hidden layer size of 1024 with 16 attention heads, 4096-dimensional feed-forward layers, using 32 K byte-pair encoding sub-word units [^61]. fairseq provides a training configuration for the corresponding model [^42], which we adapted for our infrastructure. We trained our models on three GPUs using a batch size of up to 3584 tokens per GPU and accumulating gradients over 16 batches for 45 epochs, and selected the best model based on the validation Bleu score. In Table 1, we directly report Bleu for different values of $d_{\text{dot}}$; Table 6 provides the conversion from hyper-parameters $m$ of Performers or $\nu$ in the DPFP to $d_{\text{dot}}$.

Table 6: Relation between dot product space dimension and the hyper-parameters in the Performer and our DPFP models. $d_{\text{key}}=64$ in all our translation models.

| $d_{\text{dot}}$ | 256 | 384 | 512 |
| --- | --- | --- | --- |
| Performer $m$ | 128 | 192 | 256 |
| DPFP $\nu$ | 2 | 3 | 4 |

## Appendix F Details on Language Modelling Experiments

##### Implementation notes.

All our implementations are based on PyTorch [^47]. Our base language modelling code has been developed by using the public code by [^9] for Transformer-XL as a starting point. For $\phi$ functions, we ported the same implementation we used for our translation experiments. For the implementation of our update rule, we modified the CUDA kernel for the Linear Transformer made publicly available by [^26]. We note that a custom implementation of the backward pass for fast weights is crucial for language modelling. A naive backward computation generated by automatic differentiation would store the fast weights for each time step, which can quickly hit the GPU memory limit. The custom implementation ensures that we need to store only one set of weights by recomputing the fast weights needed for computing the gradients for each time step in the backward pass (which still remains time-efficient as the operations involved in the computation of our fast weights are rather inexpensive).

##### Experimental details.

Here we provide extra experimental details to complement the descriptions of Sec. 6.3. For the small and medium configurations, we use batch sizes of 96 and 56 sequences, respectively, and train for about 120 and 70 epochs. In both settings, we apply 10% dropout [^17] [^64], and train using the Adam optimiser [^27] with an initial learning rate of 0.00025 and 2000 learning rate warm-up steps. For further details, we refer the readers to our code. For experiments with Transformer-XL (Table 4), we train it with the same backpropagation span as our models (i.e. $384$ words in the medium configuration). The model is trained with memory and target segment lengths of 384. The models with different state sizes in Table 4 are obtained by using different Transformer-XL memory segment lengths at evaluation time. The models with state sizes of 1.05 M, 2.10 M, and 6.29 M are obtained by using memory and target lengths of 64, 128, and 384, respectively. The model with a state size of 0.13 M uses a memory length of 15 and a target length of 1. Like for other models, a batch size of 1 is used for evaluating the Transformer XL. The state sizes in Table 4 are computed as follows. The per-layer state size of the Linear Transformer and the Delta Net are: number of heads (here 8) $\times$ fast weight matrix size which is per-head key dimension (here 32) $\times$ per-head value dimension (here 32). This yields a total size of 8,192. The per-layer state size of the Transformer XL is: memory segment length $\times$ target segment length $\times$ (total key dimension, here 256 $+$ total value dimension, here 256). We obtain the total state size we report in Table 4 by multiplying the per-layer state size by the number of layers which is 16 for all our models.
