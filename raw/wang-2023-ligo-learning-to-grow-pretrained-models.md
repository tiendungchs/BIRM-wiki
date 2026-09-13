---
title: "Learning to Grow Pretrained Models for Efficient Transformer Training"
source: "https://arxiv.org/html/2303.00980"
author:
published:
created: 2026-09-13
description:
tags:
  - "clippings"
---
Peihao Wang  Rameswar Panda   Lucas Torroba Hennigen   Philip Greengard    Leonid Karlinsky    Rogerio Feris    David D. Cox    Zhangyang Wang    Yoon Kim Affiliation: University of Texas at Austin Affiliation: MIT-IBM Watson AI Lab Affiliation: Columbia University Affiliation: MIT{peihaowang,atlaswang}@utexas.edu,{rpanda, leonidka, david.d.cox}@ibm.com,rsferis@us.ibm.com,pg2118@columbia.edu,{lucastor, yoonkim}@mit.edu

###### Abstract

Scaling transformers has led to significant breakthroughs in many domains, leading to a paradigm in which larger versions of existing models are trained and released on a periodic basis. New instances of such models are typically trained completely from scratch, despite the fact that they are often just scaled-up versions of their smaller counterparts. How can we use the implicit knowledge in the parameters of smaller, extant models to enable faster training of newer, larger models? This paper describes an approach for accelerating transformer training by learning to grow pretrained transformers, where we learn to linearly map the parameters of the smaller model to initialize the larger model. For tractable learning, we factorize the linear transformation as a composition of (linear) width- and depth-growth operators, and further employ a Kronecker factorization of these growth operators to encode architectural knowledge. Extensive experiments across both language and vision transformers demonstrate that our learned Linear Growth Operator (LiGO) can save up to $50\%$ computational cost of training from scratch, while also consistently outperforming strong baselines that also reuse smaller pretrained models to initialize larger models.<sup>1</sup>

## 1 Introduction

The transformer architecture [^57] has emerged as a general purpose architecture for modeling many structured domains [^15] [^2] [^47] [^17] [^55]. Perhaps more so than other architectures, the transformer empirically seems to have inductive biases that make it especially amenable to scaling [^48] [^31], which has led to a paradigm in which larger versions of smaller, existing models are trained and released on a periodic basis (e.g., the GPT lineage of models [^42] [^43] [^2]). New instances of such models are typically trained completely from scratch, despite the fact that they are often scaled-up versions of their smaller counterparts. Given the compute required to train even the smaller models, we argue that training each model from scratch is wasteful, and that prior knowledge implicit in the parameters of smaller pretrained models should be leveraged to enable faster training of larger models.

One approach to this problem is through the lens of *model growth*, wherein a smaller model’s pretrained parameters are used to initialize a subset of the larger model’s parameters. While earlier works generally froze the parameters initialized from the pretrained model and only trained the new (randomly initialized) parameters [^20] [^19] [^24], subsequent work has shown that copying a subset of the pretrained parameters to initialize the new parameters and then finetuning the entire network significantly accelerates training and sometimes even leads to better performance [^7]. When applied to modern transformers, these mechanisms roughly translate to a depth-expansion operator in which pretrained models are stacked (or combined with identity layers) to initialize deeper transformers [^22] [^63], and a width-expansion operator in which the smaller model’s matrices are copied to initialize the larger model’s matrices (e.g., in block-diagonal fashion) [^5] [^23].

Noting the empirical effectiveness of such recipes, we observe that existing mechanisms generally do not have a learning component (e.g., randomly copying over neurons for width-expansion or stacking consecutive layers for depth-expansion). This paper instead proposes an efficient, data-driven approach for *learning to grow* transformers. In particular, our approach frames the problem of initializing the larger model’s parameters as learning a linear mapping from the smaller model’s parameters, i.e., $\boldsymbol{\Theta}^{(large)}=\boldsymbol{M}\boldsymbol{\Theta}^{(small)}$ where $\boldsymbol{\Theta}^{(small)}$ and $\boldsymbol{\Theta}^{(large)}$ are the vectorized parameters of the small/large models. Due to the high dimensionality of the parameters, this mapping is completely intractable to learn without any restrictions on $\boldsymbol{M}$. We thus factorize the linear mapping to be a composition of sparse width- and depth-expansion operators, $\boldsymbol{M}=\boldsymbol{L}_{depth}\boldsymbol{R}_{width}$, where both width and depth matrices are further factorized to be a Kronecker product of smaller matrices that express architectural knowledge (e.g., through grouping parameters by layers and neurons). We show that our growth operators can represent existing approaches such as layer-stacking and neuron-copying as special cases. We find that with a small amount of learning on $\boldsymbol{M}$ (e.g., 100 gradient steps) to initialize the larger model, we can significantly accelerate training of both vision and language transformers. Figure 1 illustrates our approach.

![Refer to caption](https://arxiv.org/html/2303.00980v1/ICLR2023/CameraReady/figures/pdfs/lego.png)

Figure 1: Our linear growth operator (LiGO) accelerates training by using the weights of a smaller model 𝚯 \\boldsymbol{\\Theta} to initialize the weights of the larger model ( n e w ) \\boldsymbol{\\Theta}^{(new)}. LiGO is parameterized as a sparse linear map 𝑴 \\boldsymbol{M} that can be decomposed into width- and depth-expansion operators. The width-operator 𝑹 i d t h \\boldsymbol{R}\_{width} and depth-operator 𝑳 p \\boldsymbol{L}\_{depth} are structured matrices obtained from Kronecker products of smaller matrices which encode architectural knowledge by grouping parameters into layers and neurons. While we show the expansion operators for simple multi-layer perceptrons for illustrative purposes, in practice we apply LiGO to enable faster training of transformer networks. In our approach, we learn the growth matrix with a 100 steps of SGD, use this to initialize the larger model, and then continue training as usual. Best viewed in color.

We apply our learned linear growth operator (LiGO) to popular families of models—BERT [^15], RoBERTa [^37], GPT2 [^43], and ViT [^17] [^55] [^56] —and find that LiGO can consistently improve transformer training efficiency over the traditional way of training from scratch across domains and model sizes. For instance, LiGO saves $44.7\%$ and $22.5\%$ FLOPs for training BERT-Base and GPT2-Medium from scratch by reusing pretrained smaller models that are half as big. Similarly, for vision transformers, when using DeiT-S [^55] for initialization, LiGO yields $55\%$ savings in FLOPs with no performance drop on ImageNet [^14]. These FLOPs savings directly translate to similar wall clock savings. We further find that models trained using LiGO achieve similar performance to the trained-from-scratch baselines when transferred to downstream tasks.

## 2 Related Work

Efficient training. Efficient training of transformers has been studied from multiple perspectives. Some methods that are orthogonal to our work include mixed precision training [^51], large batch optimization [^64], distributed training [^29], and dropping layers [^66] or tokens [^26]. Knowledge inheritance [^41] explores knowledge distillation during pretraining to efficiently learn larger transformers. Progressive training, which first trains a small transformer with few layers and then gradually expands by stacking layers, has also been applied to accelerate transformer training [^22] [^63] [^36] [^50]. Net2Net [^7] uses function-preserving transformations to grow width by copying neurons and depth by using identity layers. Recently, bert2BERT [^5] extends Net2Net to transformers. In contrast to these approaches, our approach learns to (linearly) transform the parameters of a smaller model to initialize a larger model. While there is a line of work on learning to grow neural networks in a data-driven way, these methods are in general difficult to apply to modern-scale transformers since they (for example) involve growing a single neuron at a time or employ expensive optimization/search procedures [^60] [^3] [^61] [^62] [^18].

Network initialization. Our work is also related to work on neural network initialization. Existing works include controlling the norm of the parameters [^38] [^32] [^9] [^61] [^21] or replacing the normalization layers [^1] [^65] [^28]. MetaInit [^13] proposes an automatic method that optimizes the norms of weight tensors to minimize the gradient quotient on minibatches of random Gaussian samples. GradInit [^68] learns to initialize larger networks by adjusting norm of each layer. Our work focuses on using smaller pretrained transformers to better initialize larger transformers, which remains an understudied problem.

Structured matrices. Finally, our work is also related to structured matrices which are typically used to replace dense weight matrices for reducing training and inference computation cost. Examples include sparse and low rank matrices [^8] [^25], Chebyshev matrices [^54], Toeplitz matrices [^52], Kronecker-product matrices [^67], and butterfly matrices [^10]. A unified framework to learn a broad family of structured matrices is presented in [^52]. [^12] propose Monarch matrices, which inherit the expressiveness of butterfly matrices and achieve reasonable accuracy-efficiency tradeoffs in many applications. While our approach is inspired by these works, we propose to grow pretrained models by learning structured sparse linear operators with Kronecker factorization, which to our knowledge has not been explored in the literature.

## 3 Proposed Approach

##### Notation.

We denote the parameters of a neural network with $L$ layers and $D$ dimensions as $\boldsymbol{\Theta}_{L,D}=\begin{bmatrix}\boldsymbol{W}_{1}&\cdots&\boldsymbol{W}_{L}\end{bmatrix}^{\top}\in\real^{LD\times D}$, where $\boldsymbol{W}_{l}\in\real^{D\times D}$ denotes the weights for the $l$ -th layer.<sup>2</sup> With slight abuse of notation, we denote the vectorization of $\boldsymbol{\Theta}_{L,D}$ as $\V(\boldsymbol{\Theta}_{L,D})^{\top}=\begin{bmatrix}\V(\boldsymbol{W}_{1})^{\top}&\cdots&\V(\boldsymbol{W}_{L})^{\top}\end{bmatrix}$.<sup>3</sup> Our goal is to re-use the parameters $\boldsymbol{\Theta}=\boldsymbol{\Theta}_{L_{1},D_{1}}$ from a pretrained smaller model to initialize a large model $\boldsymbol{\Theta}^{(new)}=\boldsymbol{\Theta}_{L_{2},D_{2}}$ through a model growth operator $M:\real^{L_{1}D_{1}\times D_{1}}\rightarrow\real^{L_{2}D_{2}\times D_{2}}$ that maps the weights of the smaller network to the weights of the larger one, i.e., $\boldsymbol{\Theta}^{(new)}=M(\boldsymbol{\Theta})$ where $L_{1}<L_{2}$ and $D_{1}<D_{2}$. After model growth, we adopt $\boldsymbol{\Theta}^{(new)}$ as the initialization of the large model and train it using standard recipes.

### 3.1 Existing Growth Operators

Existing works have separately established model growth operators for depth ($L_{1}<L_{2},D_{1}=D_{2}$) and width ($L_{1}=L_{2},D_{1}<D_{2}$). We summarize these methods below.

Depth expansion. StackBERT [^22] proposes to duplicate the smaller model to double the depth, based on the observation that upper layers share similar functionality with the lower layers. In contrast, interpolation-based depth expansion methods [^4] [^16] interleave every layer to form a deeper model, which can be roughly interpreted as simulating a finer-grained solution to the original dynamical system from a neural ODE perspective [^6]. Letting $L_{2}=kL_{1}$, the two methods’ growth operators can be formulated as:

$$
\displaystyle\text{(StackBERT)}\ \boldsymbol{W}^{(new)}_{l}=\boldsymbol{W}_{l\ \mathrm{mod}\ L_{1}},\quad\text{(Interpolation)}\ \boldsymbol{W}^{(new)}_{i}=\boldsymbol{W}_{\lfloor l/k\rfloor},\quad\forall l\in[L_{2}].
$$

Width expansion. Net2Net [^7] expands the width of neural networks by randomly copying neurons while preserving output values via normalization. This can be seen as growing a matrix associated with a particular layer by duplicating the columns and rows of its weight matrix. Suppose a layer has weight matrix $\boldsymbol{W}_{l}\in\real^{D_{1}\times D_{1}}$.<sup>4</sup> To expand it to a matrix $\boldsymbol{W}^{(new)}_{l}\in\real^{D_{2}\times D_{2}}$ ($D_{2}>D_{1}$), Net2Net copies $\boldsymbol{W}_{l}$ to its upper-left corner of $\boldsymbol{W}^{(new)}_{l}$, fills the new columns via a random selection matrix $\boldsymbol{S}_{l}$, and finally duplicates and normalizes rows according to the selection matrix from the previous layer. Formally, the growth operator of Net2Net can be written as:

$$
\displaystyle\text{(Net2Net)}\ \boldsymbol{W}^{(new)}_{l}=\begin{bmatrix}\boldsymbol{I}\\
\boldsymbol{S}_{l-1}^{\top}\end{bmatrix}\boldsymbol{D}_{l}^{-1}\boldsymbol{W}_{l}\begin{bmatrix}\boldsymbol{I}&\boldsymbol{S}_{l}\end{bmatrix},\quad\boldsymbol{D}_{l}=\diag(\boldsymbol{S}_{l-1}\boldsymbol{1})+\boldsymbol{I},\quad\forall l\in[L_{2}]
$$

where $\boldsymbol{S}_{l}\in\{0,1\}^{D_{1}\times(D_{2}-D_{1})}$ is a random selection matrix. The diagonal of $\boldsymbol{D}_{l}$ is a $D_{1}$ -dimensional histogram, whose $i$ -th entry indicates number of times $i$ -th column of $\boldsymbol{W}_{l}$ was copied.

### 3.2 Learning to Grow with a Structured Linear Growth Operator

While existing operators have been empirically successful in accelerating transformer-based models such as BERT [^22] [^5], we observe that generally do not have a learning component and perform the depth- and width-expansions separately. In this section we introduce a general framework for learning to grow with a linear growth operator (LiGO), which generalizes existing operators by combining the width- and depth-growth operators in a data-driven way.

We can formulate the problem of initializing the weights of the larger model $\boldsymbol{\Theta}^{(new)}$ from the smaller model $\boldsymbol{\Theta}$ through the following optimization problem,

$$
\displaystyle\argmin_{M}\,\mathbb{E}_{\boldsymbol{x}\sim\mathcal{D}}\,\,\mathcal{L}(\boldsymbol{x};\boldsymbol{\Theta}^{(new)}),\quad\text{ subject to }\boldsymbol{\Theta}^{(new)}=M(\boldsymbol{\Theta}),
$$

where $\mathcal{D}$ is the data distribution and $\mathcal{L}$ is the loss function. It is of course intractable to optimize over the entire operator space, and thus we further simplify the function $M$ to be a linear transformation, which results in the following formulation,

$$
\displaystyle\V(\boldsymbol{\Theta}^{(new)})=\V(M(\boldsymbol{\Theta}))=\boldsymbol{M}\V(\boldsymbol{\Theta}),\quad\boldsymbol{M}\in\real^{L_{2}D_{2}^{2}\times L_{1}D_{1}^{2}}.
$$

This simplified objective is still completely infeasible to apply to contemporary neural networks where $L_{1}D_{1}$ can easily be in the hundreds of millions. We therefore propose an efficient parameterization of $\boldsymbol{M}$ for tractable learning.

#### 3.2.1 Decomposition along Depth and Width

Our first step is to decompose the LiGO operator as $\boldsymbol{M}=\boldsymbol{L}_{depth}\boldsymbol{R}_{width}$, where $\boldsymbol{L}_{depth}$ and $\boldsymbol{R}_{width}$ expand the depth and width of model separately. Concretely, we decompose $\boldsymbol{M}$ as

$$
\displaystyle\boldsymbol{M}=\underbrace{\begin{bmatrix}\diag(\boldsymbol{\ell}_{1,1})&\cdots&\diag(\boldsymbol{\ell}_{1,L_{1}})\\
\vdots&\ddots&\vdots\\
\diag(\boldsymbol{\ell}_{L_{2},1})&\cdots&\diag(\boldsymbol{\ell}_{L_{2},L_{1}})\\
\end{bmatrix}}_{\boldsymbol{L}_{depth}}\underbrace{\begin{bmatrix}\boldsymbol{R}_{1}&&\\
&\ddots&\\
&&\boldsymbol{R}_{L_{1}}\\
\end{bmatrix}}_{\boldsymbol{R}_{width}}.
$$

where $\boldsymbol{R}_{l}\in\real^{D_{2}^{2}\times D_{1}^{2}}$ and $\boldsymbol{\ell}_{i,j}\in\real^{D_{2}^{2}}$. In the above, $\boldsymbol{L}_{depth}$ is an array of diagonal matrices and $\boldsymbol{R}_{width}$ is a block-diagonal matrix, i.e., both matrices are highly structured and sparse. When applying $\boldsymbol{R}_{width}$ to weights $\V(\boldsymbol{\Theta})$, the parameters of each layer will be transformed independently via $\V(\boldsymbol{W}^{(new)}_{l})=\boldsymbol{R}_{l}\V(\boldsymbol{W}_{l})$ and lifted to a higher dimension. The $l$ -th row block of $\boldsymbol{L}_{depth}$ corresponds to the growth operator of $l$ -th layer, which amounts to linearly combining all layers of the smaller model via $\V(\boldsymbol{W}^{(new)}_{l})_{k}=\sum_{l^{\prime}=1}^{L_{1}}(\boldsymbol{\ell}_{l,l^{\prime}})_{k}\V(\boldsymbol{W}_{l})_{k}$. By this factorization, we can effectively reduce the complexity of the LiGO operator from $\mathcal{O}(D_{1}^{2}L_{1}D_{2}^{2}L_{2})$ to $\mathcal{O}(D_{1}^{2}D_{2}^{2}L_{1})$ and encode architectural knowledge by grouping parameters by layers. Later in Section 3.4, this representation is also shown to preserve high representation power owing to its connection with Monarch matrices [^12] [^10].

#### 3.2.2 Parameter Sharing via Kronecker Factorization

The above LiGO operator requires $\mathcal{O}(D_{1}^{2}D_{2}^{2}L_{1})$ parameters for $\boldsymbol{R}_{width}$ and $\mathcal{O}(L_{1}L_{2}D_{2}^{2})$ for $\boldsymbol{L}_{depth}$. The width operator $\boldsymbol{R}_{width}$ is thus still prohibitively expensive given that $D_{1}$ (and $D_{2}$) can easily be in the hundreds or thousands. In this section, we propose a Kronecker factorization to further reduce the number of learnable parameters for each growth operator.

Depth. For depth, we treat an entire layer as a single group and construct a new layer by combining existing layers, effectively tying parameters for all neurons in same layer. Formally, each block in $\boldsymbol{L}_{depth}$ is simplified to be $\diag(\boldsymbol{\ell}_{i,j})=w_{i,j}\boldsymbol{I}$. Then the entire matrix can be written as a Kronecker factorization, $\boldsymbol{L}_{depth}=\boldsymbol{w}\otimes\boldsymbol{I}$, where $\boldsymbol{w}\in\real^{L_{2}\times L_{1}}$ is a matrix whose entry $w_{i,j}$ indicates blending weights of $j$ -th layer of the small model to form $i$ -th layer of the large model. This strategy reduces the number of parameters in $\boldsymbol{L}_{depth}$ to $\mathcal{O}(L_{1}L_{2})$, and is shown on left-hand side of Figure 1.

Width. For width, we decompose each diagonal block of width expansion operator $\boldsymbol{R}_{width}$ using the Kronecker factorization $\boldsymbol{R}_{l}=\boldsymbol{A}_{l}\otimes\boldsymbol{B}_{l}$, where $\boldsymbol{A}_{l},\boldsymbol{B}_{l}\in\real^{D_{2}\times D_{1}}$. Since $\V(\boldsymbol{C}\boldsymbol{A}\boldsymbol{B})=(\boldsymbol{B}^{\top}\otimes\boldsymbol{C})\V(\boldsymbol{A})$ [^49], we then have,

$$
\displaystyle\boldsymbol{R}_{width}\V(\boldsymbol{\Theta})
$$
 
$$
\displaystyle=\begin{bmatrix}\boldsymbol{A}_{1}\otimes\boldsymbol{B}_{1}&&\\
&\ddots\\
&&\boldsymbol{\boldsymbol{A}}_{L_{1}}\otimes\boldsymbol{B}_{L_{1}}\end{bmatrix}\V(\boldsymbol{\Theta})
$$
 
$$
\displaystyle=\V\left(\begin{bmatrix}\boldsymbol{B}_{1}\boldsymbol{W}_{1}\boldsymbol{A}_{1}^{\top}&\cdots&\boldsymbol{B}_{L_{1}}\boldsymbol{W}_{L_{1}}\boldsymbol{A}_{L_{1}}^{\top}\end{bmatrix}^{\top}\right).
$$

Here we observe that $\boldsymbol{B}_{l}\boldsymbol{W}_{l}\boldsymbol{A}_{l}^{\top}$ performs in- and out-dimension expansion by $\boldsymbol{A}_{l}$ and $\boldsymbol{B}_{l}$, respectively. Each new column/row is a linear combination of columns/rows of small model’s weight matrix. This factorization, which can be seen as grouping parameters by *neurons*, reduces the number of parameters to $\mathcal{O}(L_{1}D_{1}D_{2})$. Figure 1 (right) illustrates LiGO’s width-expansion operator.

Altogether, we obtain the final parameterization of LiGO operator $\boldsymbol{M}$:

$$
\displaystyle\boldsymbol{M}=\underbrace{\left(\begin{bmatrix}w_{1,1}&w_{1,2}&\cdots&w_{1,L_{1}}\\
\vdots&\vdots&\ddots&\vdots\\
w_{L_{2},1}&w_{L_{2},2}&\cdots&w_{L_{2},L_{1}}\\
\end{bmatrix}\otimes\boldsymbol{I}\right)}_{\text{Depth expansion}}\underbrace{\left(\begin{bmatrix}\boldsymbol{A}_{1}\otimes\boldsymbol{B}_{1}&&\\
&\ddots\\
&&\boldsymbol{\boldsymbol{A}}_{L_{1}}\otimes\boldsymbol{B}_{L_{1}}\end{bmatrix}\right)}_{\text{Width expansion}}
$$

We can exploit the factorization to implement the LiGO operator (Eq. 8) efficiently.

Training. LiGO expands a model in three steps: (1) for each layer, inserting new rows by linearly combining existing rows through $\boldsymbol{B}_{l}$, (2) for each layer, inserting new columns by linearly combining existing columns through $\boldsymbol{A}_{l}$, and then finally (3) reconstructing each layer by linearly combining the weight matrices with $\boldsymbol{w}$ along the depth. We then run a few steps (e.g., 100 iterations) of SGD to optimize $\boldsymbol{M}$, which has negligible compute cost relative to regular training. After obtaining $\boldsymbol{M}$, we initialize large model with $\boldsymbol{M}\V(\boldsymbol{\Theta})$, and train parameters $\boldsymbol{\Theta}^{(new)}$ through SGD as usual. Algorithm 1 summarizes a forward pass of LiGO with transformer. Finally, as shown in Appendix A we note that StackBERT (Eq. 1), Interpolation (Eq. 1), and Net2Net (Eq. 2) are all special cases of LiGO (Eq. 8) with a particular setting of $\boldsymbol{L}_{depth}$ and $\boldsymbol{R}_{width}$.

### 3.3 LiGO for Transformers

While LiGO can be applied to any multi-layer neural network architecture, in this paper we focus on using LiGO to grow transformers which have been shown to be particularly amenable to scaling. Below we briefly describe how LiGO is applied to the main transformer embedding/attention layers and defer further details (e.g., growing bias vectors, layer norm parameters) to Appendix B.1.

Embedding layer. The embedding layer can be regarded as a linear layer whose inputs are one-hot vectors. We learn a matrix $\boldsymbol{B}^{(emb)}$ to extend its output dimension. This embedding layer is also used as the final output layer for our transformer language modeling experiments.

Attention and feedforward Layers. An attention layer consists of multi-head attention weights ($\boldsymbol{W}^{Q},\boldsymbol{W}^{K},\boldsymbol{W}^{V}$) and a linear projection ($\boldsymbol{W}^{O}$). Let $\boldsymbol{A}^{k}_{l}$ and $\boldsymbol{B}^{k}_{l}$ where $k\in\{Q,K,V,O\}$ be the $l$ -th layer’s in- and out-dimension expansion matrices (Eq. 6) for the query, key, value, and projection matrices. To make sure new input and output channels are aligned across modules, we tie the LiGO operator as follows: for all $l\in[L_{1}]$, (1) $\boldsymbol{A}^{k}_{l}=(\boldsymbol{B}^{(emb)})^{\top}$ for $\forall k\in\{Q,K,V\}$, (2) $\boldsymbol{A}^{O}_{l}=(\boldsymbol{B}_{l}^{V})^{\top}$, (3) $\boldsymbol{B}^{O}_{l}=\boldsymbol{B}^{(emb)}$. The last constraint is added to take into account the residual connections [^5]. We similarly tie parameters for the feed-forward networks, $\boldsymbol{A}^{(fc1)}_{l}=(\boldsymbol{B}^{(emb)})^{\top}$, $\boldsymbol{A}^{(fc2)}_{l}=(\boldsymbol{B}^{(fc1)})^{\top}_{l}$ and $\boldsymbol{B}^{(fc2)}_{l}=\boldsymbol{B}^{(emb)}$. Since transformers make heavy use of residual layers with skip connections, we found that simply using the same $\boldsymbol{B}^{(emb)}$ to parameterize $\boldsymbol{A}_{l}^{k}$ and $\boldsymbol{B}_{l}^{k}$ for many layers/modules worked well in practice. This reduces the number of learnable parameters even further and enables fast learning of $\boldsymbol{M}$ on a small amount of data (100 gradient steps).

### 3.4 Connection to Monarch Matrices

As shown in Section 3.2.1, our depth-width decomposition factorizes $\boldsymbol{M}$ into a multiplication of two structured sparse matrices. We examine the expressiveness of this factorized representation by relating it to Monarch matrices [^12], defined below.

###### Definition 1.

Let the space of Monarch matrices be $\mathcal{M}\subseteq\real^{mn_{1}\times mn_{2}}$. Then matrix $\boldsymbol{M}\in\mathcal{M}$ if $\boldsymbol{M}=\boldsymbol{P}_{1}\boldsymbol{L}\boldsymbol{P}_{2}^{\top}\boldsymbol{R}=\boldsymbol{P}_{1}\diag(\boldsymbol{L}_{1},\cdots,\boldsymbol{L}_{n_{1}})\boldsymbol{P}_{2}^{\top}\diag(\boldsymbol{R}_{1},\cdots,\boldsymbol{R}_{n_{2}})$ where $\boldsymbol{L}_{i}\in\real^{b_{1}\times b_{2}}$, $\boldsymbol{R}_{i}\in\real^{b_{3}\times b_{4}}$ are dense rectangular matrices, and $n_{1}b_{2}=n_{2}b_{3}$. $\boldsymbol{P}_{1}$ is the permutation $\pi(i)=(i-b_{1}\lfloor\frac{i}{b_{1}}\rfloor-1)n_{1}+\lfloor\frac{i}{b_{1}}\rfloor+1$ and $\boldsymbol{P}_{2}$ is the permutation $\pi(j)=(j-b_{2}\lfloor\frac{j}{b_{2}}\rfloor-1)n_{1}+\lfloor\frac{j}{b_{2}}\rfloor+1$.

It is clear that the block-diagonal matrix $\boldsymbol{R}$ has the identical form to our width growing operator $\boldsymbol{R}_{width}$. By applying the permutation matrices $\boldsymbol{P}_{1}$ and $\boldsymbol{P}_{2}$ to $\boldsymbol{L}$, $\boldsymbol{L}$ is transformed into exactly the same form with our depth-growth operator $\boldsymbol{L}_{depth}$ in Eq. 5. This implies that our depth-width decomposition coincides with Monarch sparsification of dense matrices, which generalize butterfly matrices [^10] and enjoy rich expressivity properties [^11] [^12].

## 4 Experiments

We conduct experiments to answer three key research questions. Q1: To what extent can LiGO improve the training efficiency (FLOPs and wall time) of transformers compared to training from scratch and other growth operators? Q2: Can LiGO be universally effective across transformers from different domains (e.g., language and vision) and sizes? Q3: Can models trained using LiGO achieve similar performance compared to the baselines when transferred to downstream tasks?

### 4.1 Experimental Setup

Datasets. We follow [^53] and use the English Wikipedia corpus <sup>5</sup> for training BERT [^15] and RoBERTa [^37]. We use the public C4 [^44] dataset for training GPT2 [^43]. We use ImageNet [^14] for training vision transformers. We use GLUE [^58], SQuADv1.1 [^45], and SQuADv2.0 [^46] for evaluating pretrained BERT models. We test downstream performance of vision transformers (DeiT [^55]) by performing transfer learning on $5$ downstream image classification tasks, including CIFAR10 [^34], CIFAR100 [^34], Flowers102 [^39], StanfordCars [^33], and ChestXRay8 [^59].

Models. We experiment with growing the following language andd vision transformers: (1) BERT-Small $\rightarrow$ BERT-Base, BERT-Base $\rightarrow$ BERT-Large, BERT-Small $\rightarrow$ BERT-Large; (2) RoBERTa-Small $\rightarrow$ RoBERTa-Base for RoBERTa; (3) GPT2-Base $\rightarrow$ GPT2-Medium, (4) DeiT-S $\rightarrow$ DeiT-B, and (5) CaiT-XS $\rightarrow$ CaiT-S. BERT-Small has $6$ layers with $512$ hidden dimensions, while other named models are their usual sizes. See Appendix B.2 for full details.

Baselines. We compare our approach with the following baselines: (1) training from scratch baseline where we train the larger transformer without using any smaller pretrained models; (2) progressive training methods designed for growing depth in transformers (StackBERT [^22] and MSLT [^63]); (3) bert2BERT [^5] that extends Net2Net [^7] for width expansion and stacking for depth expansion; (4) KI [^41] which uses distillation for transferring knowledge from the smaller model to the larger model.

Implementation details. We always use 100 gradient steps to learn the LiGO for all models, which is negligible in terms of FLOPs/wall time compared to full training after initialization. We train both BERT and RoBERTa models for $400$ K steps with a warmup of $10$ K steps. We remove the next-sentence prediction task [^37] and use a fixed sequence length of $128$ for pretraining both models. For BERT, we use a batch size of $256$ and a learning rate of $2e^{-4}$, while we use a batch size of $1024$ and a learning rate of $8e^{-4}$ for training RoBERTa models.

Following [^50], we train GPT2 models with a batch size of $384$ and sequence length of $1024$. For vision transformers, we build our models based on DeiT [^55] and CaiT [^56], and apply their default hyper-parameters for training on ImageNet dataset. We train all our vision transformers for $300$ epochs with a batch size of $1024$. For transfer learning with BERT/RoBERTa, we follow [^53] and train for $3$ epochs with a learning rate of $1e^{-4}$ and a batch-size of $32$ for all tasks in GLUE. On SQuAD v1.1 and SQuAD 2.0, we fine-tune for $2$ epochs with a learning rate of $5e^{-5}$ and a batch size of $12$. We run both GLUE and SQuAD evaluations three times with different random seeds and report the mean numbers. For transfer learning experiments on DeiT, we finetune the pretrained models with $1000$ epochs, batch size 768, learning rate $0.01$, and use the same data augmentation in training on ImageNet. We use the same pretraining data and experimental settings for all the baselines (including our approach) for a fair comparison. Note that we include the additional compute required for training LiGO in all our tables and figures. However, since our LiGO is only trained for 100 steps, the influence on visualization and quantitative saving percentages is negligible.

### 4.2 Results and Analysis

(a) BERT-Small $\rightarrow$ BERT-Base

(b) BERT-Small $\rightarrow$ BERT-Base

(c) BERT-{Small, Base} $\rightarrow$ BERT-Large

Figure 2: Results on BERT. (a-b) shows validation log perplexity vs. FLOPs and wall time respectively for training BERT-Base by reusing BERT-Small. (c) shows log perplexity vs. FLOPs in growing BERT-Small and BERT-Base to BERT-Large. The solid line indicates the final perplexity of the larger model trained from scratch, while the dotted line represents performance of the smaller model trained from scratch. LiGO offers about 45% savings in FLOPs and 40% savings in wall time over BERT-Base training from scratch. Our approach is also flexible in reusing either BERT-Small or BERT-Base for accelerating BERT-Large training.

Table 1: Downstream transfer learning performance on GLUE and SQuAD. All of the results are based on BERT-Base models trained using the different baselines. LiGO achieves similar or even better performance than the original training from scratch baseline on several downstream tasks, despite improving training efficiency.

<table><tbody><tr><td rowspan="2">Method</td><td>Savings</td><td>Savings</td><td>SST-2</td><td>MNLI</td><td>MRPC</td><td>CoLA</td><td>QNLI</td><td>QQP</td><td>STS-B</td><td>SQuADv1.1</td><td>SQuADv2.0</td><td>Avg.</td><td>Avg.</td></tr><tr><td>(FLOPs)</td><td>(Walltime)</td><td>(Acc.)</td><td>(Acc.)</td><td>(Acc.)</td><td>(Acc.)</td><td>(Acc.)</td><td>(Acc.)</td><td>(Acc.)</td><td>(F1/EM)</td><td>(F1/EM)</td><td>GLUE</td><td>SQuAD</td></tr><tr><td>Scratch</td><td>–</td><td>–</td><td>88.19</td><td>78.43</td><td>85.78</td><td>62.09</td><td>87.06</td><td>87.18</td><td>86.99</td><td>86.55 / 77.31</td><td>71.31 / 67.07</td><td>82.25</td><td>78.79 / 72.19</td></tr><tr><td>StackBERT</td><td>34.1%</td><td>33.3%</td><td>88.99</td><td>79.72</td><td>85.29</td><td>59.09</td><td>87.28</td><td>89.17</td><td>86.97</td><td>86.50 / 77.42</td><td>71.32 / 67.41</td><td>82.36</td><td>78.91 / 72.41</td></tr><tr><td>MSLT</td><td>34.9%</td><td>30.0%</td><td>88.53</td><td>78.10</td><td>82.60</td><td>64.76</td><td>83.58</td><td>88.54</td><td>85.89</td><td>86.07 / 76.73</td><td>70.68 / 67.17</td><td>81.72</td><td>78.47 / 71.95</td></tr><tr><td>KI</td><td>-5.7%</td><td>-13.9%</td><td>88.65</td><td>78.83</td><td>83.50</td><td>64.86</td><td>86.25</td><td>88.96</td><td>87.09</td><td>84.93 / 76.29</td><td>71.09 / 67.41</td><td>82.59</td><td>78.01 / 71.85</td></tr><tr><td>bert2BERT</td><td>29.0%</td><td>25.1%</td><td>88.30</td><td>80.05</td><td>85.54</td><td>61.73</td><td>88.16</td><td>86.18</td><td>87.00</td><td>86.24 / 77.09</td><td>71.52 / 66.85</td><td>82.42</td><td>78.88 / 71.97</td></tr><tr><td>LiGO</td><td>44.7%</td><td>40.7%</td><td>88.42</td><td>79.29</td><td>84.31</td><td>62.09</td><td>88.07</td><td>88.81</td><td>87.00</td><td>86.28 / 77.45</td><td>71.24 / 67.17</td><td>82.57</td><td>78.76 / 72.31</td></tr></tbody></table>

BERT. Figure 2 shows the comparison between the different baselines for training BERT models. As seen from Figure 2(a), LiGO saves $44.7\%$ computational cost (FLOPs) of training BERT-Base (12 layers, 768 dimensions) from scratch by reusing BERT-Small (6 layers, 512 dimensions). LiGO offers $40.7\%$ savings in wall time compared to training from scratch (Figure 2(b)). Among the compared methods, StackBERT is the most competitive in terms of both FLOPs and wall time, although LiGO obtains $+10.6\%$ and $+7.2\%$ improvements in FLOPs and wall time on top of StackBERT. Similarly, LiGO significantly outperforms the recent bert2BERT method which saves about $30\%$ computational costs. We observe that KI does not provide any real savings in training as it requires additional computation for knowledge distillation. Figure 2(c) shows that our LiGO approach is flexible in growing either BERT-Small or BERT-Base for accelerating BERT-Large training. As expected, reusing BERT-Base instead of BERT-Small leads more savings in FLOPs ($45.2\%$ vs $30.3\%$) as BERT-Base contains more implicit knowledge in its parameters. Table 1 shows the per-task performance of different BERT-Base models on both GLUE and SQuAD benchmarks, where we find that BERT trained with LiGO achieves very similar performance compared to the baselines on both benchmarks. Finally, in Table 5 of the Appendix C.3, we show that growing BERT-Small to BERT-Base with 100 steps of LiGO and then finetuning on GLUE tasks *without* additional pretraining outperforms just directly finetuning BERT-Small.

(a) RoBERTa-Small $\rightarrow$ RoBERTa-Base

(b) RoBERTa-Small $\rightarrow$ RoBERTa-Base

(c) GPT2-Base $\rightarrow$ GPT2-Medium

Figure 3: Results on RoBERTa and GPT2. LiGO reduces FLOPs by $47.2\%$ and $22.5\%$ for RoBERTa-Base and GPT2-Medium,, demonstrating its effectiveness across different training strategies and architectures.

RoBERTa and GPT2. Figure 3(a-b) shows the results on RoBERTa, whose training recipe uses larger batch size and learning rate than BERT. LiGO similarly accelerates RoBERTa training, which indicates that our method is robust to optimization hyperparameters. On GPT2, LiGO saves $22.5\%$ computation cost of training GPT2-Medium (345M parameters) by reusing GPT2-Base (117M parameters) (Figure 3(c)). These consistent improvements show that LiGO is effective for accelerating transformer training across different model architectures and sizes.

(a) DeiT-S $\rightarrow$ DeiT-B

(b) DeiT-S $\rightarrow$ DeiT-B

Figure 4: Results on DeiT. (a) Accuracy vs. flops and (b) accuracy vs. wall time for training DeiT-B. LiGO saves flops and wall time by more than 50% over training from scratch on ImageNet.

Vision Transformers. Figure 4 shows that by growing from DeiT-S, LiGO can save $55.4$ % FLOPs and $52$ % GPU wall time to reach the same performance of 81% on ImageNet. Interestingly, the model initialized by our data-driven growth operator (w/ only 100 gradient steps of tuning) can already achieve $72$ % accuracy at the beginning of training and leads to the final accuracy of $81.7\%$ at the end of the training. Compared to the next best method, bert2BERT, LiGO obtains more than $15\%$ savings, which once again demonstrates the effectiveness of our approach in growing vision transformers as well. Table 2 shows that finetuning results on downstream tasks perform on-par with the model trained from scratch, showing that LiGO does not harm the model’s generalization capabilities when transferred to downstream datasets. We also find similar savings in CaiT-XS $\rightarrow$ CaiT-S where LiGO saves FLOPs by $52.6\%$ and wall time by $46.1\%$ over training CaiT-S from scratch on ImageNet (see Appendix C.2 for more details).

Table 2: Transfer learning performance of DeiT-B. DeiT-B model trained using LiGO performs similarly to the original train-from-scratch baseline on all downstream tasks.

| Method | FLOPs | Walltime | ImageNet | CIFAR10 | CIFAR100 | Flowers | Cars | ChestXRay8 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Scratch | – | – | $81.10$ | $99.09$ | $90.76$ | $97.79$ | $92.06$ | 55.81 |
| StackBERT | $23.8\%$ | $15.1\%$ | $81.21$ | $99.11$ | $90.80$ | $97.56$ | $92.09$ | 55.77 |
| MSLT | $36.7\%$ | $28.9\%$ | $81.27$ | $99.07$ | $90.21$ | $97.71$ | $92.11$ | 55.79 |
| KI | $-11.2\%$ | $-36.8\%$ | $81.01$ | $98.94$ | $90.32$ | $97.81$ | $92.08$ | 55.80 |
| bert2BERT | $40.8\%$ | $37.0\%$ | $81.59$ | $99.14$ | $90.69$ | $97.67$ | $92.15$ | 55.82 |
| LiGO | $55.4\%$ | $52.0\%$ | $81.71$ | $99.12$ | $90.74$ | $97.77$ | $92.09$ | 55.82 |

Combining with other training strategies. We also find that LiGO can be effectively combined with orthogonal strategies such as layer dropping [^66], token dropping [^26], and staged training [^5]. More details are included in Appendix B.3. Figure 5 shows that LiGO can be combined with other training techniques to improve the computational savings by $4.7\%$, $7.4\%$, and $8.2\%$ with layer dropping, token dropping and staged training, respectively. Following [^5], we also apply staged training strategy to bert2BERT and observe that LiGO still outperforms bert2BERT with staged training by $16.7\%$ (see Figure 5(c)).

(a) LiGO w/ Layer Dropping

(b) LiGO w/ Token Dropping

(c) LiGO w/ Staged Training

Figure 5: LiGO with other efficient training strategies. Our approach can be combined with (a) layer dropping, (b) token dropping, and (c) staged training (ST), for further accelerate BERT training.

### 4.3 Ablation Studies

(a) BERT(6, 768) $\rightarrow$ BERT(12, 768)

(b) BERT(12, 512) $\rightarrow$ BERT(12, 768)

Figure 6: Results on Depth-only and Width-only growth. LiGO saves $51.7\%$ FLOPS when expanding depth-only, and $41.6\%$ FLOPS when expanding width-only.

Depth-only expansion. We examine the effectiveness of our proposed depth expansion operator ($\boldsymbol{L}_{depth})$ by only growing the depth of BERT from $6$ layers to $12$ layers, i.e, (BERT(6, 768) $\rightarrow$ BERT(12, 768). We compare with stacking [^22], Interpolation [^4] [^16] (see Eq. 1), and MSLT [^63]. For LiGO, we only apply its $\boldsymbol{L}_{depth}$ component to the pre-trained model weights. Results in Figure 6(a) show that a data-driven approach works well even when just growing across the depth dimension.

Table 3: Effect of number of gradient steps. “+FLOPs” stands for additional flops (in $10^{15}$).

| \# of Steps | +FLOPs | Savings |
| --- | --- | --- |
| 100 | 3.61 | 44.7% |
| 500 | 18.06 | 44.5% |
| 1000 | 36.13 | 44.2% |
| 10000 | 361.30 | 38.9% |

Width-only expansion. We also verify the effectiveness of $\boldsymbol{R}_{width}$ by only extending BERT width from $512$ to $768$, i.e., BERT(12, 512) $\rightarrow$ BERT(12, 768). We compare LiGO based initialization with direct copy [^60], function preserving initialization [^7], and advanced knowledge initialization [^5]. LiGO’s width expansion component outperforms all other methods, as shown in Figure 6(b).

Number of growing steps. Our main experiments just use $100$ gradient steps to grow. We tune our LiGO on the pretraining set for $100$, $500$, $1000$, and $10000$ steps and compute the additional FLOPs for BERT-Small $\rightarrow$ BERT-Base training. Table 3 shows that training LiGO within $1000$ steps results in the identical model convergence (reaching $1.8$ PPL at $215$ K steps). This suggests tuning model weights under the linear constraints of LiGO can achieve faster convergence. Training LiGO for more than $10000$ steps can provide a model with slightly faster convergence ($214$ K steps), but results in less saving overall.

## 5 Conclusion

This paper describes an approach for accelerating transformer training by learning to grow pretrained transformers, where the larger transformer’s parameters are initialized as a linear mapping from the smaller pretrained model’s parameters, The linear map is factorized to be a composition of sparse width- and depth-expansion operators with a Kronecker factorization that groups parameters into layers and neurons. We demonstrate the effectiveness of our proposed approach on both language and vision transformers of different sizes, outperforming several competing methods. While our compute resources prevented us from applying LiGO to even larger transformers, it would be interesting to see if this can be applied on top of even larger models.

#### Acknowledgments

PW sincerely thanks Zhen Wang for insightful discussion and providing reference repositories for language model pre-training. PW also appreciates Hao Tan’s assistance for reproducing fine-tuning results on GLUE datasets. YK and LTH were partially supported an MIT-IBM Watson AI grant and an Amazon award. We also acknowledge support from the IBM Research AI Hardware Center, and the Center for Computational Innovation at Rensselaer Polytechnic Institute for the computational resources on the AiMOS Supercomputer.

## References

## Appendix A Universality of LiGO Operator

###### Proposition 1.

StackBERT (Eq. 1), Interpolation (Eq. 1), and Net2Net (Eq. 2) are all the special cases of the LiGO operator (Eq. 8).

###### Proof.

We prove Proposition 1 by constructing parameters in $\boldsymbol{L}_{depth}$ and $\boldsymbol{R}_{width}$.

##### Stacking.

Stacking-based methods [^22] [^63] duplicate the entire lower blocks on top of the small model to the form new layers (Eq. 1). Formally, we show this operation can be done by the following operator:

$$
\displaystyle\boldsymbol{M}=\underbrace{\begin{bmatrix}\boldsymbol{I}&&\\
&\boldsymbol{I}&\\
&&\ddots\\
\boldsymbol{I}&&\\
&\boldsymbol{I}&\\
&&\ddots\\
\end{bmatrix}}_{\boldsymbol{L}_{depth}}\underbrace{\begin{bmatrix}\boldsymbol{I}&&\\
&\ddots&\\
&&\boldsymbol{I}\end{bmatrix}}_{\boldsymbol{R}_{width}}
$$

##### Interpolation.

Interpolation based methods [^4] [^16] interleave each layer for twice. We can construct the following matrix to achieve layer interpolation (Eq. 1).

$$
\displaystyle\boldsymbol{M}=\underbrace{\begin{bmatrix}\boldsymbol{I}&&\\
\boldsymbol{I}&&\\
&\boldsymbol{I}&\\
&\boldsymbol{I}&\\
&&\ddots\\
&&\ddots\\
\end{bmatrix}}_{\boldsymbol{L}_{depth}}\underbrace{\begin{bmatrix}\boldsymbol{I}&&\\
&\ddots&\\
&&\boldsymbol{I}\end{bmatrix}}_{\boldsymbol{R}_{width}}
$$

We remark that any rearrangement of layers to construct new layers (mathematically a permutation of existing layers with replacement) can be constructed in a similar way.

##### Net2Net.

Since we show in Eq. 6, the Kronecker factorization on $\boldsymbol{R}_{l}$ amounts to decomposing the general growth operator into in-dimension and out-dimension expansion. We can construct Net2Net [^7] based growth by simply letting:

$$
\displaystyle\boldsymbol{L}_{depth}=\boldsymbol{I}\in\real^{L_{1}D_{2}\times L_{2}D_{2}},\quad\boldsymbol{R}_{width}=\begin{bmatrix}\boldsymbol{A}_{1}\otimes\boldsymbol{B}_{1}&&\\
&\ddots&\\
&&\boldsymbol{A}_{L_{1}}\otimes\boldsymbol{B}_{L_{1}}\end{bmatrix}
$$
 
$$
\displaystyle\boldsymbol{A}_{l}=\begin{bmatrix}\boldsymbol{I}\\
\widetilde{\boldsymbol{S}}_{l-1}\end{bmatrix},\quad\boldsymbol{B}_{l}=\begin{bmatrix}\boldsymbol{I}\\
\boldsymbol{S}_{l},\end{bmatrix}
$$

where $\boldsymbol{S}_{l}\in\{0,1\}^{(D_{2}-D1)\times D_{1}}$ is a selection matrix to enlarge the out dimension, and $\widetilde{\boldsymbol{S}}_{l-1}=\boldsymbol{S}_{l-1}\diag(\boldsymbol{1}^{\top}\boldsymbol{S}_{l-1})^{-1}$ copies the selection from $\boldsymbol{S}_{l-1}$ with normalization to guarantee functionality preserving in expansion. ∎

## Appendix B Implementation Details

### B.1 Growing Transformers with LiGO

The transformer architecture consists of an embedding layer, multi-block attention layer, and an output layer. The core ingredient attention block consists of a Multi-Head Attention (MHA) module followed by a FeedForward Network (FFN), with a skip connection across the both blocks. Applying LiGO requires the following considerations:

##### Embedding layer.

For both language and vision transformers, the embedding layer can be regarded as a linear layer, whose inputs are one-hot embeddings in language models. We draw a learnable matrix $\boldsymbol{B}^{(emb)}$ to extend its output dimension.

##### Multi-head attention blocks.

An attention layer in transformer consists of multi-head attention weights ($\boldsymbol{W}^{Q},\boldsymbol{W}^{K},\boldsymbol{W}^{V}$) and a linear projection ($\boldsymbol{W}^{O}$). Let $\boldsymbol{A}^{k}_{l}$ and $\boldsymbol{B}^{k}_{l}$ with $k\in\{Q,K,V,O\}$ be the in- and out-dimension expansion matrices (Eq. 6) for query, key, value, and projection in the $l$ -th layer, respectively. Applying $\boldsymbol{B}^{k}_{l}$ to $\boldsymbol{W}^{k}$ ($k\in{Q,K,V}$) constructs new heads by a weighted summation of rows of all existing heads. To make sure the new input and output channels are aligned across modules, we tie our LiGO operator with the following scheme: (1) $\boldsymbol{A}^{k}_{l}=(\boldsymbol{B}^{(emb)})^{\top}$ for $\forall k\in\{Q,K,V\}$, (2) $\boldsymbol{A}^{O}_{l}=(\boldsymbol{B}^{(V)}_{l})^{\top}$, (3) $\boldsymbol{B}^{O}_{l}=\boldsymbol{B}^{(emb)}$ for $\forall l\in[L_{1}]$. Both the bias and layer normalization inherit the associated linear transformations’ out-dimension expansion matrices to grow the width. For depth expansion, each module independently combines the same module from other layers (Eq. 8) with learnable coefficients $\boldsymbol{w}$.

##### Feed-forward networks.

Each attention block is followed by a two-layer FFN. Let $\boldsymbol{A}^{k}_{l}$ and $\boldsymbol{B}^{k}_{l}$ with $k\in\{fc1,fc2\}$ be the in- and out-dimension expansion matrices (Eq. 6) for the first and second FFN layer in the $l$ -th layer, respectively. We tie the parameters for feed-forward networks: $\boldsymbol{A}^{(fc1)}_{l}=\boldsymbol{B}^{(emb)\top}$, $\boldsymbol{A}^{(fc2)}_{l}=\boldsymbol{B}^{(fc1)\top}_{l}$ and $\boldsymbol{B}^{(fc2)}_{l}=\boldsymbol{B}^{(emb)}$.

##### Output layer.

For output head, we have $\boldsymbol{A}^{(out)}=\boldsymbol{B}^{(emb)\top}$, since the output dimension of attention layers are always aligned with $\boldsymbol{B}^{(emb)}$ by our construction. The output layer does not need out-dimension expansion. Algorithm 1 summarizes LiGO for growing transformers.

Algorithm 1 A forward pass of LiGO with transformer.

Input: A small transformer with hidden $D_{1}$ and number of layer $L_{1}$. Denote the embedding layer as $\boldsymbol{W}^{(emb)}\in\real^{D_{1}\times E}$, attention layers as $\boldsymbol{W}^{Q}_{l},\boldsymbol{W}^{K},\boldsymbol{W}^{V}_{l},\boldsymbol{W}^{O}_{l}\in\real^{D_{1},\times D_{1}}$, FFN layers as $\boldsymbol{W}^{(fc1)}_{l}\in\real^{4D_{1}\times D_{1}}$, $\boldsymbol{W}^{(fc2)}_{l}\in\real^{D_{1}\times 4D_{1}}$, LayerNorm layers as $\boldsymbol{W}^{(ln1)}_{l}\in\real^{D_{1}\times 4D_{1}}$, $\boldsymbol{W}^{(ln1)}_{l},\boldsymbol{W}^{(ln2)}_{l}\in\real^{D_{1}}$, $\forall l\in[L_{1}]$, the output head $\boldsymbol{W}^{(out)}\in\real^{C\times D_{1}}$

Output: A large transformer with hidden $D_{2}$ and number of layer $L_{2}$. Denote the weight matrices as $\boldsymbol{\Omega}$ with the corresponding superscripts as the small model.

 $\boldsymbol{\Omega}^{(emb)}\leftarrow\boldsymbol{B}^{(emb)}\boldsymbol{W}^{(emb)}$

for $l=1,\cdots,L_{1}$ do $\triangleright$ Width Expansion

   $\boldsymbol{\Omega}^{Q}_{l}\leftarrow\boldsymbol{B}^{(Q)}\boldsymbol{W}^{Q}_{l}\boldsymbol{B}^{(emb)\top}$    $\boldsymbol{\Omega}^{K}_{l}\leftarrow\boldsymbol{B}^{(K)}\boldsymbol{W}^{K}_{l}\boldsymbol{B}^{(emb)\top}$    $\boldsymbol{\Omega}^{V}_{l}\leftarrow\boldsymbol{B}^{(V)}\boldsymbol{W}^{V}_{l}\boldsymbol{B}^{(emb)\top}$    $\boldsymbol{\Omega}^{O}_{l}\leftarrow\boldsymbol{B}^{(emb)}\boldsymbol{W}^{V}_{l}\boldsymbol{B}^{(V)\top}$    $\boldsymbol{\Omega}^{(ln1)}_{l}\leftarrow\boldsymbol{B}^{(emb)}\boldsymbol{W}^{(ln1)}_{l}$    $\boldsymbol{\Omega}^{(fc1)}_{l}\leftarrow\boldsymbol{B}^{(fc1)}\boldsymbol{W}^{V}_{l}\boldsymbol{B}^{(emb)\top}$    $\boldsymbol{\Omega}^{(fc2)}_{l}\leftarrow\boldsymbol{B}^{(emb)}\boldsymbol{W}^{V}_{l}\boldsymbol{B}^{(fc1)\top}$    $\boldsymbol{\Omega}^{(ln2)}_{l}\leftarrow\boldsymbol{B}^{(emb)}\boldsymbol{W}^{(ln2)}_{l}$

end for

for $l=1,\cdots,L_{2}$ do $\triangleright$ Depth Expansion

   $\boldsymbol{\Omega}^{Q}_{l}\leftarrow\sum_{j=1}^{L_{1}}w_{l,j}^{Q}\boldsymbol{\Omega}^{Q}_{j}$    $\boldsymbol{\Omega}^{K}_{l}\leftarrow\sum_{j=1}^{L_{1}}w_{l,j}^{K}\boldsymbol{\Omega}^{K}_{j}$    $\boldsymbol{\Omega}^{V}_{l}\leftarrow\sum_{j=1}^{L_{1}}w_{l,j}^{V}\boldsymbol{\Omega}^{V}_{j}$    $\boldsymbol{\Omega}^{O}_{l}\leftarrow\sum_{j=1}^{L_{1}}w_{l,j}^{O}\boldsymbol{\Omega}^{O}_{j}$    $\boldsymbol{\Omega}^{(ln1)}_{l}\leftarrow\sum_{j=1}^{L_{1}}w_{l,j}^{(ln1)}\boldsymbol{\Omega}^{(ln1)}_{j}$    $\boldsymbol{\Omega}^{(fc1)}_{l}\leftarrow\sum_{j=1}^{L_{1}}w_{l,j}^{(fc1)}\boldsymbol{\Omega}^{(fc1)}_{j}$    $\boldsymbol{\Omega}^{(fc2)}_{l}\leftarrow\sum_{j=1}^{L_{1}}w_{l,j}^{(fc2)}\boldsymbol{\Omega}^{(fc2)}_{j}$    $\boldsymbol{\Omega}^{(ln2)}_{l}\leftarrow\sum_{j=1}^{L_{1}}w_{l,j}^{(ln2)}\boldsymbol{\Omega}^{(ln2)}_{j}$

end for

 $\boldsymbol{\Omega}^{(out)}\leftarrow\boldsymbol{W}^{(out)}\boldsymbol{B}^{(emb)\top}$

Train transformer with parameters $\boldsymbol{\Omega}$.

### B.2 Model Configurations

We summarize the settings of different transformer models used for our experiments in Table 4. For BERT and RoBERTa, we re-use the code base provided by [^53]. For GTP2, we follow the model configuration of OpenAI and use the pre-training code provided by [^50]. For DeiT, we use their official codebase [^55].

Table 4: Configuration of different transformers.

|  | BERT-Small | BERT-Base | RoBERTa-Small | RoBERTa-Base | GPT2-Base | GPT2-Medium |  | DeiT-S | DeiT-B |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| \# layers | 6 | 12 | 6 | 12 | 12 | 24 | \# layers | 12 | 12 |
| \# hidden | 512 | 768 | 512 | 768 | 768 | 1024 | \# hidden | 384 | 768 |
| \# heads | 8 | 12 | 8 | 12 | 12 | 16 | \# heads | 6 | 12 |
| \# vocab | 30522 | 30522 | 50265 | 50265 | 50257 | 50257 | input res. | 224 | 224 |
| seq. length | 128 | 128 | 128 | 128 | 1024 | 1024 | patch size | 16 | 16 |

### B.3 Orthogonal Efficient Training Strategies

For layer dropping, we follow the same progressive dropping rate schedule with [^66], and set the maximum dropping rate to 0.1 to recover the performance. For token dropping, we randomly set 15% tokens aside in the middle layers. In the first $50$ k steps of staged training, only a sub-network is activated and trained, and afterwards, we perform full-model training for 350k steps.

(a) BERT-Small $\rightarrow$ BERT-Base

(b) BERT-Small $\rightarrow$ BERT-Base

Figure 7: Results on BERT-Base by reusing BERT-Small trained for 50k steps. Instead of training BERT-Base from fully trained BERT-Small, we run LiGO on BERT-Small trained with 50k steps. LiGO offers about 35.2% savings in FLOPs and 30.2% savings in wall time over the BERT-Base training from scratch.

## Appendix C Additional Experiments

### C.1 Reusing smaller models trained for only few steps

LiGO focuses on utilizing the knowledge of smaller models that have already been pretrained and available. In this section, we investigate how LiGO can leverage smaller existing models that are only trained for few steps to accelerate training of a larger model. We perform an experiment on BERT-Base by reusing a BERT-Small trained for only 50k steps instead full training for 220k steps as used in our experiments. Figure 7 shows that LiGO can still save 35.2% savings in FLOPs and 30.2% savings in wall time over the BERT-Base training from scratch.

### C.2 Results on CaiT

(a) CaiT-XS $\rightarrow$ CaiT-S

(b) CaiT-XS $\rightarrow$ CaiT-S

Figure 8: Results on CaiT. (a) Accuracy vs. flops and (b) accuracy vs. wall time for training CaiT-S. LiGO saves flops by $52.6\%$ and wall time by $46.1\%$ over training from scratch on ImageNet.

In addition to DeiT [^55], we perform additional experiments with CaiT [^56] on ImageNet and find that while reusing CaiT-XS, LiGO offers about 52.6% savings in FLOPs and 46.1% savings in wall time over the CaiT-S training from scratch (see Figure 8).

### C.3 Task-specific finetuning with LiGO initialization without further pretraining

We perform additional experiments by directly finetuning BERT-Base initialized by LiGO (from BERT-Small) without any further pretraining. We observe in Table 5 that the LiGO-initialized model can benefit downstream tasks compared to BERT-Small trained from scratch (1st row vs 2nd row).

Table 5: GLUE performance of different LiGO models. All of the results are based on BERT-Base models with BERT-Small as the base model for LiGO optimization.

<table><tbody><tr><td rowspan="2">Method</td><td>SST-2</td><td>MNLI</td><td>MRPC</td><td>CoLA</td><td>QNLI</td><td>QQP</td><td>STS-B</td><td>Average</td></tr><tr><td>(Acc.)</td><td>(Acc.)</td><td>(Acc.)</td><td>(Acc.)</td><td>(Acc.)</td><td>(Acc.)</td><td>(Acc.)</td><td>(Acc.)</td></tr><tr><td>BERT-Small (Scratch)</td><td>87.21</td><td>77.56</td><td>82.11</td><td>59.93</td><td>85.06</td><td>85.82</td><td>84.99</td><td>80.38</td></tr><tr><td>BERT-Base (LiGO Init)</td><td>88.15</td><td>77.62</td><td>82.53</td><td>60.70</td><td>85.79</td><td>86.65</td><td>85.83</td><td>81.04</td></tr><tr><td>BERT-Base (LiGO Init + Pretrain)</td><td>88.42</td><td>79.29</td><td>84.31</td><td>62.09</td><td>88.07</td><td>88.81</td><td>87.00</td><td>82.57</td></tr><tr><td>BERT-Base (Scratch)</td><td>88.19</td><td>78.43</td><td>85.78</td><td>62.09</td><td>87.06</td><td>87.18</td><td>86.99</td><td>82.25</td></tr></tbody></table>

### C.4 GLUE Performance using AdapterFusion

Table 6: Downstream performance using AdapterFusion [^40] on GLUE Benchmark. All of the results are based on BERT-Base models trained using different baselines.

<table><tbody><tr><td rowspan="2">Method</td><td>Savings</td><td>Savings</td><td>SST-2</td><td>MNLI</td><td>MRPC</td><td>CoLA</td><td>QNLI</td><td>QQP</td><td>STS-B</td><td>Average</td></tr><tr><td>(FLOPs)</td><td>(Walltime)</td><td>(Acc.)</td><td>(Acc.)</td><td>(Acc.)</td><td>(Acc.)</td><td>(Acc.)</td><td>(Acc.)</td><td>(Acc.)</td><td>(Acc.)</td></tr><tr><td>Scratch</td><td>–</td><td>–</td><td>88.41</td><td>78.60</td><td>86.02</td><td>62.39</td><td>87.62</td><td>88.02</td><td>86.52</td><td>82.51</td></tr><tr><td>StackBERT</td><td>34.1%</td><td>33.3%</td><td>88.78</td><td>79.80</td><td>85.43</td><td>59.56</td><td>87.71</td><td>89.19</td><td>86.27</td><td>82.39</td></tr><tr><td>MSLT</td><td>34.9%</td><td>30.0%</td><td>88.41</td><td>78.35</td><td>83.15</td><td>63.97</td><td>86.19</td><td>88.20</td><td>86.42</td><td>82.10</td></tr><tr><td>KI</td><td>-5.7%</td><td>-13.9%</td><td>88.94</td><td>78.84</td><td>84.00</td><td>64.61</td><td>86.75</td><td>88.19</td><td>87.93</td><td>82.75</td></tr><tr><td>bert2BERT</td><td>29.0%</td><td>25.1%</td><td>88.47</td><td>80.53</td><td>85.50</td><td>62.33</td><td>88.57</td><td>86.72</td><td>87.10</td><td>82.75</td></tr><tr><td>LiGO</td><td>44.7%</td><td>40.5%</td><td>88.45</td><td>80.01</td><td>84.67</td><td>63.05</td><td>88.06</td><td>88.92</td><td>87.00</td><td>82.88</td></tr></tbody></table>

LiGO is mainly proposed for improving efficiency of the pre-training stage and hence is compatible with various finetuning schemes like full model finetuning, adapters [^27] [^40] or prompt tuning [^35] [^30] for adaptation to downstream tasks. We test BERT-Base models trained using different baselines by using adapterfusion [^40] instead of full finetuning on GLUE benchmark. Table 6 shows that LiGO also achieves on-par performance with model trained from scratch under adapter-based tuning with 44.7% savings in FLOPs abd 40.5% savings in wall time. This shows that LiGO does not harm the model generalization capability when adapters are used as a parameter-efficient finetuning strategy for transferring a trained model to downstream datasets.

### C.5 Initial results on billion+ parameter models

Our extensive experiments on BERT [^15], RoBERTa [^37], GPT2 [^43], DeiT [^55] and CaiT [^56] show that LiGO can consistently improve transformer training efficiency over the traditional way of training from scratch across domains and model sizes. One interesting future direction of our work is scaling LiGO to very large models with parameters more than 100B, such as GPT3 [^2]. While we currently do not possess the compute resources for this extreme large-scale study, we perform a preliminary experiment on GPT2-1.5B [^43] by using GPT2-Medium as the initialization. We train for 15k steps on C4 dataset [^44] and find that our proposed LiGO saves about 39% computation cost (FLOPs) of training GPT2-1.5B from scratch to reach the same log perplexity (which is 3.3). We believe that it is imperative to study the extent to which the benefits of LiGO remain at the scale on which the modern large language models are trained. We hope to cover this in our future work.

[^1]: Andy Brock, Soham De, Samuel L Smith, and Karen Simonyan. High-performance large-scale image recognition without normalization. In *International Conference on Machine Learning*, pp. 1059–1071, 2021.

[^2]: Tom B Brown, Benjamin Mann, Nick Ryder, Melanie Subbiah, Jared Kaplan, Prafulla Dhariwal, Arvind Neelakantan, Pranav Shyam, Girish Sastry, Amanda Askell, et al. Language models are few-shot learners. In *Proceedings of NeurIPS*, 2020.

[^3]: Han Cai, Tianyao Chen, Weinan Zhang, Yong Yu, and Jun Wang. Efficient architecture search by network transformation. In *Proceedings of AAAI*, 2018.

[^4]: Bo Chang, Lili Meng, Eldad Haber, Frederick Tung, and David Begert. Multi-level residual networks from dynamical systems view. *arXiv preprint arXiv:1710.10348*, 2017.

[^5]: Cheng Chen, Yichun Yin, Lifeng Shang, Xin Jiang, Yujia Qin, Fengyu Wang, Zhi Wang, Xiao Chen, Zhiyuan Liu, and Qun Liu. bert2bert: Towards reusable pretrained language models. *arXiv preprint arXiv:2110.07143*, 2021.

[^6]: Ricky TQ Chen, Yulia Rubanova, Jesse Bettencourt, and David K Duvenaud. Neural ordinary differential equations. *Advances in neural information processing systems*, 31, 2018.

[^7]: Tianqi Chen, Ian Goodfellow, and Jonathon Shlens. Net2net: Accelerating learning via knowledge transfer. *arXiv preprint arXiv:1511.05641*, 2015.

[^8]: Justin Chiu, Yuntian Deng, and Alexander Rush. Low-rank constraints for fast inference in structured models. *Advances in Neural Information Processing Systems*, 34:2887–2898, 2021.

[^9]: Xiaoliang Dai, Hongxu Yin, and Niraj K Jha. Nest: A neural network synthesis tool based on a grow-and-prune paradigm. *IEEE Transactions on Computers*, 68(10):1487–1497, 2019.

[^10]: Tri Dao, Albert Gu, Matthew Eichhorn, Atri Rudra, and Christopher Ré. Learning fast algorithms for linear transforms using butterfly factorizations. In *International conference on machine learning*, pp. 1517–1527, 2019.

[^11]: Tri Dao, Nimit S Sohoni, Albert Gu, Matthew Eichhorn, Amit Blonder, Megan Leszczynski, Atri Rudra, and Christopher Ré. Kaleidoscope: An efficient, learnable representation for all structured linear maps. *arXiv preprint arXiv:2012.14966*, 2020.

[^12]: Tri Dao, Beidi Chen, Nimit S Sohoni, Arjun Desai, Michael Poli, Jessica Grogan, Alexander Liu, Aniruddh Rao, Atri Rudra, and Christopher Ré. Monarch: Expressive structured matrices for efficient and accurate training. In *International Conference on Machine Learning*, pp. 4690–4721, 2022.

[^13]: Yann N Dauphin and Samuel Schoenholz. Metainit: Initializing learning by learning to initialize. *Advances in Neural Information Processing Systems*, 32, 2019.

[^14]: Jia Deng, Wei Dong, Richard Socher, Li-Jia Li, Kai Li, and Li Fei-Fei. Imagenet: A large-scale hierarchical image database. In *2009 IEEE conference on computer vision and pattern recognition*, pp. 248–255, 2009.

[^15]: Jacob Devlin, Ming-Wei Chang, Kenton Lee, and Kristina Toutanova. Bert: Pre-training of deep bidirectional transformers for language understanding. In *Proceedings of NAACL*, 2019.

[^16]: Chengyu Dong, Liyuan Liu, Zichao Li, and Jingbo Shang. Towards adaptive residual network training: A neural-ode perspective. In *International conference on machine learning*, pp. 2616–2626. PMLR, 2020.

[^17]: Alexey Dosovitskiy, Lucas Beyer, Alexander Kolesnikov, Dirk Weissenborn, Xiaohua Zhai, Thomas Unterthiner, Mostafa Dehghani, Matthias Minderer, Georg Heigold, Sylvain Gelly, Jakob Uszkoreit, and Neil Houlsby. An Image is Worth 16x16 Words: Transformers for Image Recognition at Scale. In *Proceedings of ICLR*, 2021.

[^18]: Utku Evci, Max Vladymyrov, Thomas Unterthiner, Bart van Merriënboer, and Fabian Pedregosa. Gradmax: Growing neural networks using gradient information. *arXiv preprint arXiv:2201.05125*, 2022.

[^19]: Scott Fahlman. The recurrent cascade-correlation architecture. In *Advances in Neural Information Processing Systems*, 1990.

[^20]: Scott Fahlman and Christian Lebiere. The cascade-correlation learning architecture. In *Advances in Neural Information Processing Systems*, 1989.

[^21]: Xavier Glorot and Yoshua Bengio. Understanding the difficulty of training deep feedforward neural networks. In *Proceedings of the thirteenth international conference on artificial intelligence and statistics*, pp. 249–256, 2010.

[^22]: Linyuan Gong, Di He, Zhuohan Li, Tao Qin, Liwei Wang, and Tieyan Liu. Efficient training of bert by progressively stacking. In *International conference on machine learning*, pp. 2337–2346, 2019.

[^23]: Xiaotao Gu, Liyuan Liu, Hongkun Yu, Jing Li, Chen Chen, and Jiawei Han. On the transformer growth for progressive bert training. *arXiv preprint arXiv:2010.12562*, 2020.

[^24]: Steven Gutstein, Olac Fuentes,, and Eric Freudenthal. Knowledge transfer in deep convolutional neural nets. In *Proceedings of International Journal on Artificial Intelligence Tools*, 2008.

[^25]: Song Han, Huizi Mao, and William J Dally. Deep compression: Compressing deep neural networks with pruning, trained quantization and huffman coding. *arXiv preprint arXiv:1510.00149*, 2015.

[^26]: Le Hou, Richard Yuanzhe Pang, Tianyi Zhou, Yuexin Wu, Xinying Song, Xiaodan Song, and Denny Zhou. Token dropping for efficient bert pretraining. *arXiv preprint arXiv:2203.13240*, 2022.

[^27]: Neil Houlsby, Andrei Giurgiu, Stanislaw Jastrzebski, Bruna Morrone, Quentin De Laroussilhe, Andrea Gesmundo, Mona Attariyan, and Sylvain Gelly. Parameter-efficient transfer learning for nlp. In *International Conference on Machine Learning*, 2019.

[^28]: Xiao Shi Huang, Felipe Perez, Jimmy Ba, and Maksims Volkovs. Improving transformer optimization through better initialization. In *International Conference on Machine Learning*, pp. 4475–4483, 2020.

[^29]: Yanping Huang, Youlong Cheng, Ankur Bapna, Orhan Firat, Dehao Chen, Mia Chen, HyoukJoong Lee, Jiquan Ngiam, Quoc V Le, Yonghui Wu, et al. Gpipe: Efficient training of giant neural networks using pipeline parallelism. *Advances in neural information processing systems*, 32, 2019.

[^30]: Menglin Jia, Luming Tang, Bor-Chun Chen, Claire Cardie, Serge Belongie, Bharath Hariharan, and Ser-Nam Lim. Visual prompt tuning. *arXiv preprint arXiv:2203.12119*, 2022.

[^31]: Jared Kaplan, Sam McCandlish, Tom Henighan, Tom B. Brown, Benjamin Chess, Rewon Child, Scott Gray, Alec Radford, Jeffrey Wu, and Dario Amodei. Scaling laws for neural language models. *arXiv preprint arXiv:2001.08361*, 2020.

[^32]: Yannic Kilcher, Gary Bécigneul, and Thomas Hofmann. Escaping flat areas via function-preserving structural network modifications. 2018.

[^33]: Jonathan Krause, Michael Stark, Jia Deng, and Li Fei-Fei. 3d object representations for fine-grained categorization. In *Proceedings of the IEEE international conference on computer vision workshops*, pp. 554–561, 2013.

[^34]: Alex Krizhevsky, Geoffrey Hinton, et al. Learning multiple layers of features from tiny images. 2009.

[^35]: Brian Lester, Rami Al-Rfou, and Noah Constant. The power of scale for parameter-efficient prompt tuning. *arXiv preprint arXiv:2104.08691*, 2021.

[^36]: Changlin Li, Bohan Zhuang, Guangrun Wang, Xiaodan Liang, Xiaojun Chang, and Yi Yang. Automated progressive learning for efficient training of vision transformers. In *Proceedings of the IEEE/CVF Conference on Computer Vision and Pattern Recognition*, pp. 12486–12496, 2022.

[^37]: Yinhan Liu, Myle Ott, Naman Goyal, Jingfei Du, Mandar Joshi, Danqi Chen, Omer Levy, Mike Lewis, Luke Zettlemoyer, and Veselin Stoyanov. Roberta: A robustly optimized bert pretraining approach. *arXiv preprint arXiv:1907.11692*, 2019.

[^38]: Dmytro Mishkin and Jiri Matas. All you need is a good init. *arXiv preprint arXiv:1511.06422*, 2015.

[^39]: Maria-Elena Nilsback and Andrew Zisserman. Automated flower classification over a large number of classes. In *2008 Sixth Indian Conference on Computer Vision, Graphics & Image Processing*, pp. 722–729. IEEE, 2008.

[^40]: Jonas Pfeiffer, Aishwarya Kamath, Andreas Rücklé, Kyunghyun Cho, and Iryna Gurevych. Adapterfusion: Non-destructive task composition for transfer learning. *arXiv preprint arXiv:2005.00247*, 2020.

[^41]: Yujia Qin, Yankai Lin, Jing Yi, Jiajie Zhang, Xu Han, Zhengyan Zhang, Yusheng Su, Zhiyuan Liu, Peng Li, Maosong Sun, et al. Knowledge inheritance for pre-trained language models. *arXiv preprint arXiv:2105.13880*, 2021.

[^42]: Alec Radford, Karthik Narasimhan, Tim Salimans, and Ilya Sutskever. Improving language understanding by generative pre-training. 2018.

[^43]: Alec Radford, Jeff Wu, Rewon Child, David Luan, Dario Amodei, and Ilya Sutskever. Language models are unsupervised multitask learners. 2019.

[^44]: Colin Raffel, Noam Shazeer, Adam Roberts, Katherine Lee, Sharan Narang, Michael Matena, Yanqi Zhou, Wei Li, Peter J Liu, et al. Exploring the limits of transfer learning with a unified text-to-text transformer. *J. Mach. Learn. Res.*, 21(140):1–67, 2020.

[^45]: Pranav Rajpurkar, Jian Zhang, Konstantin Lopyrev, and Percy Liang. Squad: 100,000+ questions for machine comprehension of text. *arXiv preprint arXiv:1606.05250*, 2016.

[^46]: Pranav Rajpurkar, Robin Jia, and Percy Liang. Know what you don’t know: Unanswerable questions for squad. *arXiv preprint arXiv:1806.03822*, 2018.

[^47]: Alexander Rives, Joshua Meier, Tom Sercu, Siddharth Goyal, Zeming Lin, Jason Liu, Demi Guo, Myle Ott, C. Lawrence Zitnick, Jerry Ma, and Rob Fergus. Biological structure and function emerge from scaling unsupervised learning to 250 million protein sequences. *Proceedings of the National Academy of Sciences*, 118(15), 2021. ISSN 0027-8424. doi: 10.1073/pnas.2016239118.

[^48]: Jonathan S Rosenfeld, Amir Rosenfeld, Yonatan Belinkov, and Nir Shavit. A constructive prediction of the generalization error across scales. *arXiv preprint arXiv:1909.12673*, 2019.

[^49]: Kathrin Schacke. On the kronecker product. *Master’s thesis, University of Waterloo*, 2004.

[^50]: Sheng Shen, Pete Walsh, Kurt Keutzer, Jesse Dodge, Matthew Peters, and Iz Beltagy. Staged training for transformer language models. *arXiv preprint arXiv:2203.06211*, 2022.

[^51]: Mohammad Shoeybi, Mostofa Patwary, Raul Puri, Patrick LeGresley, Jared Casper, and Bryan Catanzaro. Megatron-lm: Training multi-billion parameter language models using model parallelism. *arXiv preprint arXiv:1909.08053*, 2019.

[^52]: Vikas Sindhwani, Tara Sainath, and Sanjiv Kumar. Structured transforms for small-footprint deep learning. *Advances in Neural Information Processing Systems*, 28, 2015.

[^53]: Hao Tan and Mohit Bansal. Vokenization: Improving language understanding with contextualized, visual-grounded supervision. *arXiv preprint arXiv:2010.06775*, 2020.

[^54]: Shanshan Tang, Bo Li, and Haijun Yu. Chebnet: Efficient and stable constructions of deep neural networks with rectified power units using chebyshev approximations. *arXiv preprint arXiv:1911.05467*, 2019.

[^55]: Hugo Touvron, Matthieu Cord, Matthijs Douze, Francisco Massa, Alexandre Sablayrolles, and Hervé Jégou. Training data-efficient image transformers & distillation through attention. In *International Conference on Machine Learning*, pp. 10347–10357, 2021a.

[^56]: Hugo Touvron, Matthieu Cord, Alexandre Sablayrolles, Gabriel Synnaeve, and Hervé Jégou. Going deeper with image transformers. In *Proceedings of the IEEE/CVF International Conference on Computer Vision*, 2021b.

[^57]: Ashish Vaswani, Noam Shazeer, Niki Parmar, Jakob Uszkoreit, Llion Jones, Aidan N Gomez, Łukasz Kaiser, and Illia Polosukhin. Attention is All You Need. In *Proceedings of NeurIPS*, 2017.

[^58]: Alex Wang, Amanpreet Singh, Julian Michael, Felix Hill, Omer Levy, and Samuel Bowman. Glue: A multi-task benchmark and analysis platform for natural language understanding. In *Proceedings of the 2018 EMNLP Workshop BlackboxNLP: Analyzing and Interpreting Neural Networks for NLP*, pp. 353–355, 2018.

[^59]: Xiaosong Wang, Yifan Peng, Le Lu, Zhiyong Lu, Mohammadhadi Bagheri, and Ronald M Summers. Chestx-ray8: Hospital-scale chest x-ray database and benchmarks on weakly-supervised classification and localization of common thorax diseases. In *Proceedings of the IEEE conference on computer vision and pattern recognition*, pp. 2097–2106, 2017.

[^60]: Tao Wei, Changhu Wang, Yong Rui, and Chang Wen Chen. Network morphism. In Maria Florina Balcan and Kilian Q. Weinberger (eds.), *Proceedings of The 33rd International Conference on Machine Learning*, pp. 564–572, 2016.

[^61]: Lemeng Wu, Dilin Wang, and Qiang Liu. Splitting steepest descent for growing neural architectures. *Advances in neural information processing systems*, 32, 2019.

[^62]: Lemeng Wu, Dilin Wang, Peter Stone, and Qiang Liu. Firefly neural architecture descent: a general approach for growing neural networks. *Advances in neural information processing systems*, 2021.

[^63]: Cheng Yang, Shengnan Wang, Chao Yang, Yuechuan Li, Ru He, and Jingqiao Zhang. Progressively stacking 2.0: A multi-stage layerwise training method for bert training speedup. *arXiv preprint arXiv:2011.13635*, 2020.

[^64]: Yang You, Jing Li, Sashank Reddi, Jonathan Hseu, Sanjiv Kumar, Srinadh Bhojanapalli, Xiaodan Song, James Demmel, Kurt Keutzer, and Cho-Jui Hsieh. Large batch optimization for deep learning: Training bert in 76 minutes. *arXiv preprint arXiv:1904.00962*, 2019.

[^65]: Hongyi Zhang, Yann N Dauphin, and Tengyu Ma. Fixup initialization: Residual learning without normalization. *arXiv preprint arXiv:1901.09321*, 2019.

[^66]: Minjia Zhang and Yuxiong He. Accelerating training of transformer-based language models with progressive layer dropping. *Advances in Neural Information Processing Systems*, 33:14011–14023, 2020.

[^67]: Xu Zhang, Felix X Yu, Ruiqi Guo, Sanjiv Kumar, Shengjin Wang, and Shi-Fu Chang. Fast orthogonal projection based on kronecker product. In *Proceedings of the IEEE International Conference on Computer Vision*, pp. 2929–2937, 2015.

[^68]: Chen Zhu, Renkun Ni, Zheng Xu, Kezhi Kong, W Ronny Huang, and Tom Goldstein. Gradinit: Learning to initialize neural networks for stable and efficient training. *Advances in Neural Information Processing Systems*, 34:16410–16422, 2021.

[^69]: Yukun Zhu, Ryan Kiros, Rich Zemel, Ruslan Salakhutdinov, Raquel Urtasun, Antonio Torralba, and Sanja Fidler. Aligning books and movies: Towards story-like visual explanations by watching movies and reading books. In *Proceedings of the IEEE international conference on computer vision*, pp. 19–27, 2015.