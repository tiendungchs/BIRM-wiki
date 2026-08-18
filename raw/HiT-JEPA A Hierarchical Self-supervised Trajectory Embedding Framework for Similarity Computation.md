---
title: "HiT-JEPA: A Hierarchical Self-supervised Trajectory Embedding Framework for Similarity Computation"
source: "https://arxiv.org/html/2507.00028v1"
author:
published:
created: 2026-06-23
description:
tags:
  - "clippings"
---
Lihuan Li  Hao Xue  Shuang Ao  Yang Song  Flora Salim  
University of New South Wales, Australia  
{lihuan.li, hao.xue1, shuang.ao, yang.song1, flora.salim}@unsw.edu.au

###### Abstract

The representation of urban trajectory data plays a critical role in effectively analyzing spatial movement patterns. Despite considerable progress, the challenge of designing trajectory representations that can capture diverse and complementary information remains an open research problem. Existing methods struggle in incorporating trajectory fine-grained details and high-level summary in a single model, limiting their ability to attend to both long-term dependencies while preserving local nuances. To address this, we propose HiT-JEPA (Hierarchical Interactions of Trajectory Semantics via a Joint Embedding Predictive Architecture), a unified framework for learning multi-scale urban trajectory representations across semantic abstraction levels. HiT-JEPA adopts a three-layer hierarchy that progressively captures point-level fine-grained details, intermediate patterns, and high-level trajectory abstractions, enabling the model to integrate both local dynamics and global semantics in one coherent structure. Extensive experiments on multiple real-world datasets for trajectory similarity computation show that HiT-JEPA’s hierarchical design yields richer, multi-scale representations. Code is available at: [https://anonymous.4open.science/r/HiT-JEPA](https://anonymous.4open.science/r/HiT-JEPA).

## 1 Introduction

With the widespread use of location-aware devices, trajectory data is now produced at an unprecedented rate [^44] [^28]. Effectively representing trajectory data powers critical applications ranging from urban computing applications, such as travel time estimation [^12] [^11] [^25], trajectory clustering [^15] [^35] [^3], and traffic analysis [^37]. Trajectories exhibit multi-scale attributes, ranging from short-term local transitions (e.g., turns and stops) to long-term strategic pathways or routines, whereas capturing both the fine-grained point-level details of individual trajectories and higher-level semantic patterns of mobility behavior within a unified framework is challenging. This necessitates a representation learning model that accommodates this complexity.

Early trajectory analysis methods (heuristic methods) [^1] [^8] [^9] [^36] relied on handcrafted similarity measures and point-matching heuristics. Recently, deep-learning-based approaches have been applied to learn low-dimensional trajectory embeddings, alleviating the need for manual feature engineering [^31] [^34] [^33]. Self-supervised learning frameworks [^24] [^6], especially contrastive learning (as shown in Fig. 1, left), further advanced trajectory representation learning by leveraging large unlabeled datasets [^7] [^26] [^22]. However, these deep learning models usually generate a single scale embedding of an entire trajectory and cannot integrate different semantic levels, i.e., they often neglect fine-grained point-level information in favor of broader trajectory-level features. On the other hand, most representation frameworks [^7] [^24] are restricted to a single form of trajectory data encoding and lack a mechanism to incorporate global context or higher-level information. Recent work [^23] (as shown in Fig. 1, middle) explores alternative self-supervised paradigms that capture higher-level semantic information without manual augmentation. Nevertheless, a flexible and semantically aware representation architecture that unifies multiple levels of trajectory information remains an open question.

![Refer to caption](https://arxiv.org/html/2507.00028v1/x1.png)

Figure 1: Structural comparisons among Contrastive Learning, JEPA, and Hierarchical JEPA.

Sequence models [^29] [^18], such as recurrent neural networks (RNNs) and Transformers, are a natural choice for trajectory representation due to their ability to process temporally ordered data. However, they exhibit inherent limitations when representing hierarchical semantics of trajectory data. Specifically, these models often operate at a single temporal granularity: they either overemphasize point-level nuances, making them susceptible to noise, or focus too heavily on coarse trajectory-level summaries and thus oversimplify critical details. This single-scale bias in sequential models prevents them from integrating complementary information across abstraction levels and inhibits explicit semantic interactions between local (point-level), intermediate (segment-level), and global (trajectory-level) representations, making it challenging for sequence models to capture long-term dependencies while maintaining the detailed local nuances.

A new framework is thus required to facilitate the model’s understanding of various levels of trajectory representation information, to allow predictions to be grounded on more extensive, multi-dimensional knowledge. In this paper, we propose HiT-JEPA (as shown in Fig. 1, right), a hierarchical framework for urban trajectory representation learning, which is designed to address the gaps mentioned above by integrating trajectory semantics across three levels of granularity. Its three-layer architecture explicitly captures (1) point-level details, modeling fine-grained spatial-temporal features of consecutive points; (2) intermediate-level patterns, learning representations of sub-trajectories or segments that reflect mesoscopic movement structures; and (3) high-level abstractions, distilling the overall semantic context of an entire trajectory. The model unifies multiple information scales within a single representation framework through this hierarchy. Moreover, HiT-JEPA enables interactions between adjacent levels to enrich and align the learned trajectory embeddings across scales. By leveraging a joint embedding predictive architecture, the framework learns to predict and align latent representations between these semantic levels, facilitating semantic integration in a self-supervised manner. For clarity, we summarize our contributions as follows:

- We propose HiT-JEPA, a novel hierarchical trajectory representation learning architecture that encapsulates movement information across different semantic levels inside a cohesive framework. HiT-JEPA is the first architecture to explicitly unify both fine-grained and abstract trajectory patterns within a single model.
- HiT-JEPA introduces a joint embedding predictive architecture that unifies different scales of trajectory information. This results in a flexible representation that can seamlessly incorporate local trajectory nuances and global semantic context, addressing the limitations of single-scale or single-view models.
- We illustrate that HiT-JEPA strikes a balance between coarse-to-fine trajectory representations in a unified and interpretable embedding by our proposed hierarchical interaction module.
- We conduct extensive experiments on real-world urban trajectory datasets spanning diverse cities and movement patterns, demonstrating that HiT-JEPA’s semantically enriched, hierarchical embeddings exhibit comparative trajectory similarity search, and remarkably superior zero-shot performance across heterogeneous urban and maritime datasets.

## 2 Related Work

Urban Trajectory Representation Learning on Similarity Computation. Self-supervised learning methods for trajectory similarity computation are proposed to cope with robust and generalizable trajectory representation learning on large, unlabeled datasets. t2vec [^24] divides spatial regions into rectangular grids and applies Skip-gram [^27] models to convert grid cells into word tokens, then leverages an encoder-decoder framework to learn trajectory representations. TrajCl [^7] applies contrastive learning on multiple augmentation schemes with a dual-feature attention module to learn both structural and spatial information in trajectories. CLEAR [^22] proposes a ranked multi-positive contrastive learning method by ordering the similarities of positive trajectories to the anchor trajectories. Recently, T-JEPA [^23] employs a Joint Embedding Predictive Architecture that shifts learning from trajectory data into representation space, establishing a novel self-supervised paradigm for trajectory representation learning. However, none of the above methods manage to capture hierarchical trajectory information. We propose HiT-JEPA to support coarse-to-fine, multi-scale trajectory abstraction extraction in a hierarchical JEPA structure.

Hierarchical Self-supervised Learning (HSSL). Self-supervised learning methods have significantly advanced the capability to extract knowledge from massive amounts of unlabeled data. Recent approaches emphasize multi-scale feature extraction to achieve a more comprehensive understanding of complex data samples (e.g., lengthy texts or high-resolution images with intricate details). In Computer Vision (CV), Chen et al. [^10] stack three Vision Transformers [^14] variants (varying patch size configurations) to learn cell, patch, and region representations of gigapixel whole-slide images in computational pathology. Kong et al. [^19] design a hierarchical latent variable model incorporating Masked Autoencoders (MAE) [^17] to encode and reconstruct multi-level image semantics. Xiao et al. [^30] split the hierarchical structure by video semantic levels and employ different learning objectives to capture distinct semantic granularities. In Natural Language Processing (NLP), Zhang et al. [^40] develop HIBERT, leveraging BERT [^13] to learn sentence-level and document-level text representations for document summarization. Li et al. [^21] introduce HiCLRE, a hierarchical contrastive learning framework for distantly supervised relation extraction, utilizing Multi-Granularity Recontextualization for cross-level representation interactions to effectively reduce the influence of noisy data. Our proposed HiT-JEPA leverages a hierarchical Joint Embedding Predictive Architecture, using attention interactions between adjacent layers to encode multi-scale urban trajectory representations.

## 3 Methodology

Compared to previous methods that only model trajectories at point-level, our primary goal in designing HiT-JEPA is to bridge the gap between simultaneous modeling of local trajectory details and global movement patterns by embedding explicit, cross-level trajectory abstractions into a JEPA framework. To that end, as Fig. 2 illustrates, given a trajectory $T$, we apply three consecutive convolutional layers followed by max pooling operations to produce point-level representation $T^{(1)}$, intermediate-level semantics $T^{(2)}$ and high-level summary $T^{(3)}$, where higher layer representations consist of coarser but semantically richer trajectory patterns. Trajectory abstraction at layer $l$ is learned by the corresponding JEPA layer $\mathrm{JEPA}^{(l)}$ to capture multi-scale sequential dependencies.

![Refer to caption](https://arxiv.org/html/2507.00028v1/x2.png)

Figure 2: HiT-JEPA builds a three-level JEPA hierarchy to extract multi-scale trajectory semantics: (1) Level 1 encodes fine-grained, local point-level features; (2) Level 2 abstracts mesoscopic segment-level patterns; (3) Level 3 captures coarse, global route structures. Trajectory information is propagated from top to bottom, consecutive levels via attention weights.

Spatial region representation. Considering the continuous and high-precision nature of GPS coordinates, we partition the continuous spatial regions into fixed cells. But different from previous approaches [^7] [^23] [^22] that use grid cells, we employ Uber H3 <sup>1</sup> to map GPS points into hexagonal grids to select the grid cell resolutions adaptively according to the study area size. Each hexagonal cell shares six equidistant neighbors, with all neighboring centers located at the same distance from the cell’s center. Therefore, we structurally represent the spatial regions by a graph $\mathcal{G}=(V,E)$ where each node $v_{i}\in V$ is a hexagon cell connecting to its neighboring cells $v_{j}\in V$ by an undirected edge $e_{ij}\in E$. We pretrain the spatial node embeddings $\mathcal{H}$ of graph $\mathcal{G}$ using node2vec [^16], which produces an embedding set:

$$
\mathcal{H}=\bigl{\{}\,h_{i}\in\mathbb{R}^{d}:v_{i}\in V\bigr{\}},
$$

where each $h_{i}$ encodes the relative position of node $v_{i}$. For a GPS location $P=(lon,lat)$, we first assign it to its grid cell index via:

$$
\delta\colon\mathbb{R}^{2}\to\{1,\dots,|V|\},
$$

and then look up its embedding $h_{\delta(p)}\in\mathcal{H}$.

Hierarchical trajectory abstractions. After obtaining the location embeddings, we construct trajectory representations at multiple semantic levels, which are termed hierarchical trajectory abstractions. Given a trajectory $T$ with length $n$, we obtain its location embeddings and denote the input trajectory as $T=(h_{\delta(t_{1})},h_{\delta(t_{2})},\ldots,h_{\delta(t_{n})})\in(\mathbb{R}%
^{d})^{n}$. Then, we create its multi-level abstractions $T^{(1)}$, $T^{(2)}$, $T^{(3)}$ by a set of convolution and pooling layers:

$$
\displaystyle T^{(1)}
$$
 
$$
\displaystyle=\mathrm{Conv1D}\bigl{(}T\bigr{)}\;\in(\mathbb{R}^{d})^{n_{1}},%
\quad n_{1}=n,
$$
$$
\displaystyle T^{(2)}
$$
 
$$
\displaystyle=\mathrm{MaxPool1D}\bigl{(}\mathrm{Conv1D}(T^{(1)})\bigr{)}\;\in(%
\mathbb{R}^{2d})^{\,n_{2}},\quad n_{2}=\Bigl{\lfloor}\tfrac{n_{1}}{2}\Bigr{%
\rfloor},
$$
$$
\displaystyle T^{(3)}
$$
 
$$
\displaystyle=\mathrm{MaxPool1D}\bigl{(}\mathrm{Conv1D}(T^{(2)})\bigr{)}\;\in(%
\mathbb{R}^{4d})^{\,n_{3}},\quad n_{3}=\Bigl{\lfloor}\tfrac{n_{2}}{2}\Bigr{%
\rfloor}.
$$

where $T^{(1)}$ in layer $1$ preserves the channel dimension $d$ and sequence length $n_{1}=n$, $T^{(2)}$ in layer $2$ doubles the channel dimension to $2d$ and halves the sequence length to $n_{2}=n/2$, and $T^{(3)}$ in layer $3$ doubles the channel dimension again to $4d$ and halves the sequence length to $n_{3}=n/4$. Higher-layer trajectory abstractions contain broader, summary features while sacrificing fine-grained, point-level details.

Target encoder branch. For the target encoder branch, at each level $l\in\{1,2,3\}$ the target trajectory representation is extracted by:

$$
S^{(l)}=E_{\bar{\theta}}^{(l)}(T^{(l)})
$$

where $E_{\theta}^{(l)}$ is the target encoder at layer $l$. Similar to previous JEPA methods [^20] [^2] [^23] [^4], we randomly sample $M$ times from target representation to create the targets, where $S^{(l)}(i)=\{S_{j}^{(l)}\}_{j\in\mathcal{M}_{i}}$. Therefore, $S^{(l)}(i)$ is the $i$ -th sampled target and $\mathcal{M}_{i}$ is the $i$ -th sampling mask starting from a random position. To ensure the diversity of learning targets, we follow T-JEPA [^23] and introduce a set of masking ratios $r=\{r_{1},r_{2},r_{3},r_{4},r_{5}\}$ where each ratio value specifies the fraction of the representation to mask. At each sampling step, we uniformly draw one ratio from r. We also introduce a probability $p$: with probability $p$, we apply successive masking, and with probability $1-p$, we scatter the masks randomly. Successive masking encourages the encoder to learn both local and long-range dependencies.

Context encoder branch. For the context encoder branch, we initially sample a trajectory context $C^{(l)}$ from $T^{(l)}$ at level $l$ by a mask $\mathcal{C}_{T}$ at with sampling ratio $p_{\gamma}$. Next, to prevent any information leakage, we remove from $C^{(l)}$ all positions that overlap with the targets $S^{(l)}$ to obtain the context input $T{{}^{\prime}}^{(l)}$. The context trajectory representation $S{{}^{\prime}}^{(l)}$ at level $l$ is extracted by:

$$
S{{}^{\prime}}^{(l)}=E_{\theta}^{(l)}(T{{}^{\prime}}^{(l)})
$$

where $E_{\theta}^{(l)}$ is the context encoder at level $l$. During inference, we use $S{{}^{\prime}}^{(1)}$ from $E_{\theta}^{(1)}$, enriched by the full hierarchy of multi-scale abstractions, as the final output of trajectory representations for similarity comparison or downstream fine-tuning.

Predictions. Once we have both context representations $S{{}^{\prime}}^{(l)}$ and targets $S^{(l)}$ at level $l$, we apply JEPA predictor $D_{\phi}^{(l)}$ on $S{{}^{\prime}}^{(l)}$ to approximate $S^{(l)}$ with the help of the mask tokens $z^{(l)}$:

$$
\widetilde{S}{{}^{\prime}}^{(l)}(i)=D_{\phi}^{(l)}(\mathrm{CONCAT}(S{{}^{%
\prime}}^{(l)},\mathrm{PE}(i)\oplus(z^{(l)})))
$$

where $\mathrm{CONCATE(\cdot)}$ denotes concatenation and $\text{PE}(i)$ refers to the positional embedding after applying the target sampling mask $\mathcal{M}_{i}$. $\oplus$ is element-wise addition between these masked positional embeddings and the mask tokens. Then we concatenate the mask tokens with positional information with the context representations to guide the predictor in approximating the missing components in the targets at the representation space.

Hierarchical interactions. By applying JEPA independently at each level, we learn trajectory representations at multiple scales of abstractions. However, the encoders at each level remain siloed and retain only their scale-specific information without leveraging insights from other layers. To enable hierarchical and multi-scale feature extraction, we propagate high-level information down to the next lower abstraction layer.

We adopt Transformer encoders [^29] for both context and target encoders as their self-attention module is proven highly effective in sequential modeling. Therefore, for both branches, we inject attention weights to the next lower level as a “top-down spotlight” where the high-level encoder casts its attention maps to the lower layer, lighting up where the lower-level encoder should attend. For clarity, we illustrate the process using the target encoder branch as an example. At level $l$, given the query and key matrices $Q^{(l)}$ and $K^{(l)}$ of an input trajectory abstraction $T^{(l)}$, we first retrieve the attention coefficient by:

$$
d_{k}=\frac{d^{(l)}}{H},Q_{i}^{(l)}=Q^{(l)}\,W_{i}^{Q,(l)},\;K_{i}^{(l)}=K^{(l%
)}\,W_{i}^{K,(l)},\;A_{i}^{(l)}=\mathrm{softmax}\!\Bigl{(}\frac{Q_{i}^{(l)}\,K%
_{i}^{(l)\,\top}}{\sqrt{d_{k}}}\Bigr{)},\;i=1,\dots,H
$$

where $H$ is the number of attention heads, $W_{i}^{Q,(l)}$ and $W_{i}^{K,(l)}$ are head- $i$ projections, $d^{(l)}$ is the channel dimension, and $A_{i}^{(l)}$ is the attention coefficient of the head- $i$. The multi-head attention coefficient $A^{(l)}$ are concatenated and projected by:

$$
A^{(l)}=\mathrm{Concat}\bigl{(}A_{1}^{(l)},\dots,A_{H}^{(l)}\bigr{)}\;W^{O,(l)}
$$

where $W^{O,(l)}$ is the multi-head projection. To construct the output representation $S^{(l)}$ at level $l$, we simply apply the value matrix $V^{(l)}$ by:

$$
S^{(l)}=A^{(l)}\,V^{(l)}
$$

Since the dimension of $A^{(l)}$ is:

$$
A^{(l)}\in[0,1]^{\,n^{(l)}\times n^{(l)}},\quad n^{(l)}=\frac{n^{(l-1)}}{2}
$$

where $n^{(l)}$ is the length of trajectory abstractions at level $l$, which is half of $n^{(l-1)}$ at level $l-1$ due to Eq. 4 and Eq. 5. We need to upsample the attention coefficients:

$$
\widetilde{A}^{(l)}\;=\;\mathrm{ConvTranspose1d}\bigl{(}A^{(l)},\,W_{\mathrm{%
deconv}}^{(l)},\,b_{\mathrm{deconv}}^{(l)}\bigr{)}\;\in\;[0,1]^{\,n^{(l-1)}%
\times n^{(l-1)}},
$$

where $W_{\mathrm{deconv}}^{(l)}$ and $b_{\mathrm{deconv}}^{(l)}$ are the learnable transposed-conv parameters at level $l$. To propagate the upsampled $\widetilde{A}^{(l)}$ to the next lower level, We refer to [^7] to calculate a weighted sum between $\widetilde{A}^{(l)}$ and lower level attention coefficient $A^{(l-1)}$. Therefore, we obtain the updated attention coefficient $A^{(l-1)}$ at level $l-1$ by:

$$
A^{(l-1)}=(A^{(l-1)}+\sigma\widetilde{A}^{(l)})
$$

where $\sigma$ is a learnable scale factor weighting the importance of $A^{(l)}$. Attention coefficient $A{{}^{\prime}}^{(l)}$ from the context encoders follows an identical procedure. This way, the coarse, global insights guide the fine-grained feature extraction in the next layer to focus on the most semantically important trajectory segments. This alignment sharpens local feature extraction so it stays consistent with the overall context.

Loss function. After obtaining the predicted representation $\widetilde{S}{{}^{\prime}}^{(l)}(i)$ and the $i$ -th target representation $S^{(l)}(i)$ at level $l$, we apply $\mathrm{SmoothL1}$ to calculate the loss $\mathcal{L}^{(l)}$ between them:

$$
\displaystyle\mathcal{L}^{(l)}
$$
 
$$
\displaystyle=\underbrace{\frac{1}{M\,B}\sum_{i=1}^{M}\sum_{b=1}^{B}\sum_{n=1}%
^{N^{(l)}}\sum_{k=1}^{d^{(l)}}\mathrm{SmoothL1}\bigl{(}\widetilde{S}^{\prime(l%
)}(i)_{b,n,k},\,S^{(l)}(i)_{b,n,k}\bigr{)}}_{\mathcal{L}_{\mathrm{JEPA}}^{(l)}}
$$
 
$$
\displaystyle\quad{}+\underbrace{\mathrm{VarLoss}\bigl{(}z_{\mathrm{tar}}^{(l)%
}\bigr{)}+\mathrm{VarLoss}\bigl{(}z_{\mathrm{ctx}}^{(l)}\bigr{)}+\mathrm{%
CovLoss}\bigl{(}z_{\mathrm{tar}}^{(l)}\bigr{)}+\mathrm{CovLoss}\bigl{(}z_{%
\mathrm{ctx}}^{(l)}\bigr{)}}_{\mathcal{L}_{\mathrm{VICReg}}^{(l)}}.
$$

where we sum over the channel and sequence length dimension $d^{(l)}$ and $N^{(l)}$, and average over the batch and number of target masks dimension $B$ and $M$ to obtain JEPA loss $\mathcal{L}_{\mathrm{JEPA}}^{(l)}$. We also add VICReg [^5] to prevent representation collapse, yielding more discriminative representations. We obtain the regularization term $\mathcal{L}_{\mathrm{VICReg}}^{(l)}$ by summing up the variance loss $\mathrm{VarLoss}(\cdot)$ and covariance loss $\mathrm{CovLoss}(\cdot)$ of both expanded context representation $z_{\mathrm{ctx}}^{(l)}=\mathrm{MLP}(S{{}^{\prime}}^{(l)})$ and expanded target representation $z_{\mathrm{tar}}^{(l)}=\mathrm{MLP}(S^{(l)})$ via a single-layer MLP. Afterwards, $\mathcal{L}_{\mathrm{VICReg}}^{(l)}$ is added to the loss $\mathcal{L}^{(l)}$ at level $l$.

For level $l\in\{1,2,3\}$, we calculate a weighted sum to obtain the final loss $\mathcal{L}$:

$$
\mathcal{L}=\lambda*\mathcal{L}^{(1)}+\mu*\mathcal{L}^{(2)}+\nu*\mathcal{L}^{(%
3)}
$$

where $\lambda$, $\mu$ and $\nu$ are the scale factors for loss at each level.

## 4 Experiments

We conduct experiments on three real-world urban GPS trajectory datasets: Porto <sup>2</sup>, T-Drive [^38] [^39] and GeoLife [^41] [^43] [^42], two FourSquare datasets: FourSquare-TKY and FourSquare-NYC [^32], and one vessel trajectory dataset: Vessel Tracking Data Australia, which we call “AIS(AU)” <sup>3</sup>. The dataset details can be found in Appendices A.1. We compare HiT-JEPA with the three most recent self-supervised methods on trajectory similarity computation: TrajCL [^7], CLEAR [^22] and T-JEPA [^23]. The details of these methods are listed in Appendices A.2

### 4.1 Quantitative Evaluation

In this section, we evaluate HiT-JEPA and compare it to baselines in three experiments: most similar trajectory search, robustness of learn representations, and generalization with downstream fine-tuning. We combine the first two experiments as “Self-similarity”.

#### 4.1.1 Self-similarity

Following similar experimental settings of previous work [^7] [^23], we construct a Query trajectory set $Q$ and a database trajectory $D$ for the testing set given a trajectory. $Q$ has 1,000 trajectories for Porto, T-Drive, and GeoLife, 600 for TKY, 140 for NYC, and 1400 for AIS(AU). And $D$ has 100,000 trajectories for Porto, 10,000 for T-Drive and Geolife, 3000 for TKY, 700 for NYC, and 7000 for AIS(AU). Detailed experimental settings can be found in Appendices A.4.

Table 1: Mean-rank comparison of methods across meta ratios $R_{1}$ ~ $R_{5}$. For each meta ratio, we report the mean ranks under varying DB size $\mathrm{|}D\mathrm{|}$, downsampling rate $\rho_{s}$, and distortion rate $\rho_{d}$. Bold value are the lowest mean ranks and underlined values are the second lowest.

Dataset Method $R_{1}$ $R_{2}$ $R_{3}$ $R_{4}$ $R_{5}$ $\mathrm{|}D\mathrm{|}$ $\rho_{s}$ $\rho_{d}$ $\mathrm{|}D\mathrm{|}$ $\rho_{s}$ $\rho_{d}$ $\mathrm{|}D\mathrm{|}$ $\rho_{s}$ $\rho_{d}$ $\mathrm{|}D\mathrm{|}$ $\rho_{s}$ $\rho_{d}$ $\mathrm{|}D\mathrm{|}$ $\rho_{s}$ $\rho_{d}$ Porto TrajCL 1.004 1.047 1.017 1.007 1.170 1.029 1.008 1.905 1.036 1.011 6.529 1.060 1.014 68.557 1.022 CLEAR 3.235 7.796 4.250 4.012 13.323 4.442 4.088 22.814 4.284 4.137 44.865 4.438 4.204 123.921 4.399 T-JEPA 1.029 1.455 1.097 1.048 2.304 1.084 1.053 4.413 1.115 1.061 9.599 1.110 1.074 23.900 1.123 HiT-JEPA 1.027 1.339 1.077 1.046 2.318 1.081 1.049 4.440 1.091 1.059 11.961 1.099 1.069 28.770 1.107 T-Drive TrajCL 1.111 1.203 1.267 1.128 1.348 3.320 1.146 1.668 1.355 1.177 1.936 1.513 1.201 3.356 1.179 CLEAR 1.047 1.305 1.111 1.062 1.484 1.110 1.077 1.964 1.171 1.088 3.497 1.152 1.104 3.902 1.172 T-JEPA 1.032 1.088 1.054 1.034 1.225 1.061 1.036 1.617 1.069 1.045 3.226 1.067 1.049 4.115 1.078 HiT-JEPA 1.040 1.056 1.035 1.040 1.079 1.031 1.040 1.131 1.035 1.041 1.302 1.038 1.041 2.182 1.031 GeoLife TrajCL 1.130 1.440 7.973 1.168 1.435 19.266 1.195 1.720 12.397 1.234 1.616 10.560 1.256 2.675 11.035 CLEAR 1.110 1.196 1.212 1.124 1.318 1.211 1.144 1.818 1.189 1.145 2.237 1.239 1.155 3.712 1.333 T-JEPA 1.019 1.052 1.047 1.034 1.030 1.093 1.036 1.103 1.101 1.040 1.150 1.154 1.047 1.218 1.197 HiT-JEPA 1.033 1.058 1.085 1.033 1.089 1.211 1.033 1.171 1.136 1.034 1.210 1.202 1.034 1.403 1.294 TKY (zero-shot) TrajCL 17.590 66.963 75.397 32.377 67.835 79.228 46.958 116.677 59.222 62.145 170.460 69.642 78.722 211.487 65.258 CLEAR 119.561 591.345 583.863 242.493 626.075 591.460 349.132 646.160 587.138 456.525 662.553 588.212 577.238 709.903 591.107 T-JEPA 1.948 3.060 3.245 2.272 4.227 3.165 2.617 7.975 3.313 2.913 18.173 3.202 3.275 19.135 3.127 HiT-JEPA 1.515 2.175 1.947 1.625 2.848 1.983 1.738 5.920 1.950 1.847 12.317 1.973 1.955 16.453 1.997 NYC (zero-shot) TrajCL 4.336 16.886 15.093 6.457 18.857 16.971 9.129 22.007 16.443 12.350 37.579 11.236 15.071 36.650 6.543 CLEAR 19.693 68.843 68.057 32.171 74.964 68.321 43.214 75.121 69.221 55.507 79.514 70.507 67.207 84.421 65.914 T-JEPA 1.450 1.950 1.714 1.514 3.050 1.736 1.571 2.400 1.679 1.636 2.457 1.771 1.714 5.850 1.807 HiT-JEPA 1.393 1.857 1.571 1.414 2.400 1.536 1.450 1.679 1.543 1.514 2.571 1.593 1.564 4.557 1.543 AIS(AU) (zero-shot) TrajCL 9.057 37.721 37.866 18.771 9.878 37.879 26.538 41.068 37.862 33.004 45.352 37.911 37.866 48.651 38.399 CLEAR 38.042 188.171 184.600 73.164 187.914 184.579 112.371 192.571 184.600 150.050 191.629 184.871 184.600 198.843 184.593 T-JEPA 2.156 5.661 4.753 3.176 6.849 4.753 3.889 9.486 4.755 4.364 13.055 4.758 4.754 16.986 4.749 HiT-JEPA 1.336 3.932 2.478 1.739 6.991 2.474 2.051 11.135 2.474 2.313 18.058 2.466 2.475 24.070 2.474

Table 1 shows the mean ranks of all methods. HiT-JEPA achieves the overall lowest mean ranks across five of the six datasets. For urban GPS datasets, Porto, T-Drive, and GeoLife, we have the lowest ranks in the T-Drive dataset. For example, the mean ranks of DB size $\mathrm{|}D\mathrm{|}$ across 20%~100% and distortion rates $\rho_{d}$ across 0.1~0.5 remains very steady (1.040~1.041 and 1.031~1.038). This dataset has taxi trajectories with much longer irregular sampling intervals (3.1 minutes on average). By leveraging a hierarchical structure to capture the global and high-level trajectory abstractions, HiT-JEPA learns features that remain invariant against noise and sparse sampling, resulting in more robust and accurate representations against low and irregularly sampled trajectories with limited training samples. We achieve comparative mean ranks (only 2.8% higher) with T-JEPA on GeoLife, and overall, the second best on Porto. This is because Porto trajectories inhabit an especially dense spatial region, so TrajCL can exploit auxiliary cues such as movement speed and orientations to tease apart nearly identical paths. However, relying on these features undermines the generalization ability in lower-quality trajectories (e.g., in T-Drive) and knowledge transfer into other cities.

Next, we evaluate zero-shot performance on TKY, NYC, and AIS(AU). HiT-JEPA consistently achieves the lowest mean ranks across all database sizes, downsampling, and distortion rates. Both TKY and NYC consist of highly sparse and coarse check-in sequences, lacking trajectory waypoints, which challenge the summarization ability of the models. Benefiting from the hierarchical structure, HiT-JEPA first summarizes the mobility patterns at a coarse level, then refines the check-in details at finer levels. Crucially, the summarization knowledge is transferred from dense urban trajectories in Porto, demonstrating that HiT-JEPA learns more generalizable representations than TrajCL in Porto with more essential spatiotemporal information captured in trajectories. Even on AIS(AU) with trajectories across the ocean-wide scales, HiT-JEPA maintains overall the lowest mean ranks, demonstrating its ability to handle multiple forms of trajectories that spread over various regional scales. We find that even though CLEAR outperforms TrajCL on T-Drive and GeoLife, it exhibits the weakest generalization in zero-shot experiments on TKY, NYC, and AIS(AU).

#### 4.1.2 Downstream Fine-tuning

To evaluate the generalization ability of HiT-JPEA, we conduct downstream fine-tuning on its learned representations. Specifically, we retrieve and freeze the encoder of HiT-JEPA and other baselines, concatenated with a 2-layer MLP decoder, then train the decoder to approximate the computed trajectory similarities by heuristic approaches. This setting is first proposed by TrajCL [^7], then followed by T-JEPA [^23], to quantitatively assess whether the learned representations can generalize to approach the computational processes underlying each heuristic measure. In real applications, fine-tuned models can act as efficient, “fast” approximations of traditional heuristic measures, alleviating their quadratic time-complexity bottleneck. He report hit ratios $\mathrm{HR}@5$ and $\mathrm{HR}@20$ to evaluate the correct matches between top-5 predictions and each of the top-5 and top-20 ground truths. We also report the recall $\mathrm{R}5@20$ to evaluate the correct matches of top-5 ground truths from predicted top-20 predictions. We approximate all model representations to 4 heuristic measures: EDR, LCSS, Hausdorff and Discret Fréchet.

Table 2: Comparisons with fine-tuning 2-layer MLP decoder. Bold value are the lowest mean ranks and underlined values are the second lowest.

<table><tbody><tr><td rowspan="2">Dataset</td><td rowspan="2">Method</td><td colspan="3">EDR</td><td colspan="3">LCSS</td><td colspan="3">Hausdorff</td><td colspan="3">Fréchet</td><td rowspan="2">Average</td></tr><tr><td>HR@5 <math><semantics><mo>↑</mo> <ci>↑</ci> <annotation>\uparrow</annotation> <annotation>↑</annotation></semantics></math></td><td>HR@20 <math><semantics><mo>↑</mo> <ci>↑</ci> <annotation>\uparrow</annotation> <annotation>↑</annotation></semantics></math></td><td>R5@20 <math><semantics><mo>↑</mo> <ci>↑</ci> <annotation>\uparrow</annotation> <annotation>↑</annotation></semantics></math></td><td>HR@5 <math><semantics><mo>↑</mo> <ci>↑</ci> <annotation>\uparrow</annotation> <annotation>↑</annotation></semantics></math></td><td>HR@20 <math><semantics><mo>↑</mo> <ci>↑</ci> <annotation>\uparrow</annotation> <annotation>↑</annotation></semantics></math></td><td>R5@20 <math><semantics><mo>↑</mo> <ci>↑</ci> <annotation>\uparrow</annotation> <annotation>↑</annotation></semantics></math></td><td>HR@5 <math><semantics><mo>↑</mo> <ci>↑</ci> <annotation>\uparrow</annotation> <annotation>↑</annotation></semantics></math></td><td>HR@20 <math><semantics><mo>↑</mo> <ci>↑</ci> <annotation>\uparrow</annotation> <annotation>↑</annotation></semantics></math></td><td>R5@20 <math><semantics><mo>↑</mo> <ci>↑</ci> <annotation>\uparrow</annotation> <annotation>↑</annotation></semantics></math></td><td>HR@5 <math><semantics><mo>↑</mo> <ci>↑</ci> <annotation>\uparrow</annotation> <annotation>↑</annotation></semantics></math></td><td>HR@20 <math><semantics><mo>↑</mo> <ci>↑</ci> <annotation>\uparrow</annotation> <annotation>↑</annotation></semantics></math></td><td>R5@20 <math><semantics><mo>↑</mo> <ci>↑</ci> <annotation>\uparrow</annotation> <annotation>↑</annotation></semantics></math></td></tr><tr><td rowspan="4">Porto</td><td>TrajCL</td><td>0.137</td><td>0.179</td><td>0.301</td><td>0.329</td><td>0.508</td><td>0.663</td><td>0.456</td><td>0.574</td><td>0.803</td><td>0.412</td><td>0.526</td><td>0.734</td><td>0.468</td></tr><tr><td>CLEAR</td><td>0.078</td><td>0.075</td><td>0.142</td><td>0.164</td><td>0.198</td><td>0.293</td><td>0.152</td><td>0.131</td><td>0.232</td><td>0.192</td><td>0.165</td><td>0.316</td><td>0.178</td></tr><tr><td>T-JEPA</td><td>0.154</td><td>0.194</td><td>0.336</td><td>0.365</td><td>0.551</td><td>0.713</td><td>0.525</td><td>0.633</td><td>0.869</td><td>0.433</td><td>0.565</td><td>0.771</td><td>0.509</td></tr><tr><td>HiT-JEPA</td><td>0.157</td><td>0.195</td><td>0.337</td><td>0.367</td><td>0.554</td><td>0.717</td><td>0.457</td><td>0.584</td><td>0.816</td><td>0.403</td><td>0.545</td><td>0.752</td><td>0.490</td></tr><tr><td rowspan="4">T-Drive</td><td>TrajCL</td><td>0.094</td><td>0.131</td><td>0.191</td><td>0.159</td><td>0.289</td><td>0.366</td><td>0.173</td><td>0.256</td><td>0.356</td><td>0.138</td><td>0.187</td><td>0.274</td><td>0.218</td></tr><tr><td>CLEAR</td><td>0.093</td><td>0.084</td><td>0.143</td><td>0.126</td><td>0.166</td><td>0.216</td><td>0.142</td><td>0.158</td><td>0.243</td><td>0.135</td><td>0.170</td><td>0.283</td><td>0.163</td></tr><tr><td>T-JEPA</td><td>0.094</td><td>0.147</td><td>0.215</td><td>0.205</td><td>0.366</td><td>0.469</td><td>0.158</td><td>0.229</td><td>0.329</td><td>0.125</td><td>0.159</td><td>0.249</td><td>0.229</td></tr><tr><td>HiT-JEPA</td><td>0.095</td><td>0.166</td><td>0.246</td><td>0.219</td><td>0.379</td><td>0.487</td><td>0.191</td><td>0.282</td><td>0.401</td><td>0.142</td><td>0.201</td><td>0.298</td><td>0.258</td></tr><tr><td rowspan="4">GeoLife</td><td>TrajCL</td><td>0.193</td><td>0.363</td><td>0.512</td><td>0.232</td><td>0.484</td><td>0.584</td><td>0.479</td><td>0.536</td><td>0.745</td><td>0.398</td><td>0.463</td><td>0.708</td><td>0.475</td></tr><tr><td>CLEAR</td><td>0.175</td><td>0.164</td><td>0.311</td><td>0.224</td><td>0.224</td><td>0.342</td><td>0.347</td><td>0.308</td><td>0.499</td><td>0.397</td><td>0.273</td><td>0.539</td><td>0.320</td></tr><tr><td>T-JEPA</td><td>0.195</td><td>0.383</td><td>0.527</td><td>0.242</td><td>0.515</td><td>0.586</td><td>0.606</td><td>0.656</td><td>0.857</td><td>0.488</td><td>0.406</td><td>0.731</td><td>0.516</td></tr><tr><td>HiT-JEPA</td><td>0.189</td><td>0.415</td><td>0.564</td><td>0.253</td><td>0.522</td><td>0.609</td><td>0.603</td><td>0.697</td><td>0.854</td><td>0.492</td><td>0.552</td><td>0.834</td><td>0.549</td></tr></tbody></table>

From Table 2, we can observe that HiT-JEPA achieves the highest overall performance. In the column “Average”, we calculate the average of all reported results for each model on each dataset. HiT-JEPA outperforms T-JEPA on T-Drive and GeoLife for 12.6% and 6.4%, with only 3.7% lower on Porto. For results on T-Drive, HiT-JEPA consistently outperforms the T-JEPA across all measures, especially in Hausdorff and Discret Fréchet measures, where we achieve relative average improvements of 14.7% and 19.9%, respectively. For GeoLife, even though we have some cases that achieve slightly lower results than T-JEPA in EDR and Hausdorff, we are overall 6.1% and 1.8% higher on average in these two measures. For Porto, although our results are 3.7% lower than T-JEPA on average across all measures, we have successfully made minor improvements in LCSS measure. Visualizations of predictions can be found in Fig. 8 and Fig. 9 in Appendices A.6.

### 4.2 Visualizations and Interpretations of HiT-JEPA.

HiT-JEPA encodes and predicts trajectory information only in the representation space, making it more difficult than generative models such as MAE [^17] to evaluate the learned representation quality at the data level. To assess and gauge the validity of the representations of HiT-JEPA, we project the encoded $S{{}^{\prime}}^{(1)}$ from $E_{\theta}^{(1)}$ (on full trajectories) and predicted $\widetilde{S}{{}^{\prime}}^{(1)}$ from $D_{\phi}^{(1)}$ (on masked trajectories) back onto the hexagonal grid at their GPS coordinates for visual comparisons.

First, we freeze the context encoders and predictors across all levels in a pre-trained HiT-JEPA. Then we encode and predict the masked trajectory representations to simulate the training process, and encode the full trajectory representations to simulate the inference process. Next, we concatenate and tune a 2-layer MLP for each of the representations to decode to the hexagonal grid cell embeddings to which they belong. We denote the decoded predicted masked trajectory representations as $S_{1}$ and the decoded encoded full trajectory representations as $S_{2}$. Finally, for each trajectory position, we search for the $k$ most similar embeddings in the spatial region embedding set $\mathcal{H}$ and retrieve their hexagonal cell IDs. We choose $k=3$ in our visualizations.

![Refer to caption](https://arxiv.org/html/2507.00028v1/x3.png)

(a) Predicted masked points

Fig. 3(a) shows the comparisons between decoded cells (orange hexagons) and masked points (gray points) labeled as “targets”. The decoded locations lie in close proximity to their corresponding masked targets, confirming that the model effectively learns accurate representations for masked points during training. Fig. 3(b) overlays the decoded cells green hexagons) on each blue trajectory point, demonstrating that the model can encode each point with even greater accuracy with access to the full trajectory during inference.

### 4.3 Ablation Study

Table 3: Ablation Study of HiT-JEPA on Porto

<table><tbody><tr><td colspan="6">Varying DB Size <math><semantics><mrow><mo>|</mo> <mi>D</mi> <mo>|</mo></mrow> <apply><ci>𝐷</ci></apply> <annotation>\lvert D\rvert</annotation> <annotation>| italic_D |</annotation></semantics></math></td></tr><tr><td>Model</td><td>20%</td><td>40%</td><td>60%</td><td>80%</td><td>100%</td></tr><tr><td>HiT_emb</td><td>106.568</td><td>209.746</td><td>297.919</td><td>394.111</td><td>497.064</td></tr><tr><td>HiT_single_layer</td><td>1.037</td><td>1.068</td><td>1.075</td><td>1.095</td><td>1.111</td></tr><tr><td>HiT_no_attn</td><td>1.032</td><td>1.052</td><td>1.058</td><td>1.072</td><td>1.085</td></tr><tr><td>HiT-JEPA</td><td>1.027</td><td>1.046</td><td>1.049</td><td>1.059</td><td>1.069</td></tr><tr><td colspan="6">Downsampling Rate <math><semantics><msub><mi>ρ</mi> <mi>s</mi></msub> <apply><csymbol>subscript</csymbol> <ci>𝜌</ci> <ci>𝑠</ci></apply> <annotation>\rho_{s}</annotation> <annotation>italic_ρ start_POSTSUBSCRIPT italic_s end_POSTSUBSCRIPT</annotation></semantics></math></td></tr><tr><td>Model</td><td>0.1</td><td>0.2</td><td>0.3</td><td>0.4</td><td>0.5</td></tr><tr><td>HiT_emb</td><td>569.322</td><td>706.831</td><td>1004.246</td><td>2047.699</td><td>2171.331</td></tr><tr><td>HiT_single_layer</td><td>1.469</td><td>2.646</td><td>5.246</td><td>12.655</td><td>39.660</td></tr><tr><td>HiT_no_attn</td><td>1.436</td><td>2.375</td><td>4.477</td><td>12.006</td><td>31.058</td></tr><tr><td>HiT-JEPA</td><td>1.339</td><td>2.318</td><td>4.440</td><td>11.961</td><td>28.770</td></tr><tr><td colspan="6">Distortion Rate <math><semantics><msub><mi>ρ</mi> <mi>d</mi></msub> <apply><csymbol>subscript</csymbol> <ci>𝜌</ci> <ci>𝑑</ci></apply> <annotation>\rho_{d}</annotation> <annotation>italic_ρ start_POSTSUBSCRIPT italic_d end_POSTSUBSCRIPT</annotation></semantics></math></td></tr><tr><td>Model</td><td>0.1</td><td>0.2</td><td>0.3</td><td>0.4</td><td>0.5</td></tr><tr><td>HiT_emb</td><td>502.259</td><td>503.876</td><td>506.333</td><td>507.738</td><td>507.082</td></tr><tr><td>HiT_single_layer</td><td>1.126</td><td>1.126</td><td>1.137</td><td>1.136</td><td>1.188</td></tr><tr><td>HiT_no_attn</td><td>1.094</td><td>1.088</td><td>1.104</td><td>1.110</td><td>1.122</td></tr><tr><td>HiT-JEPA</td><td>1.077</td><td>1.081</td><td>1.091</td><td>1.099</td><td>1.107</td></tr></tbody></table>

We study the effect of removing the key designs in HiT-JEPA. We compare HiT-JEPA with 3 variants: 1) HiT\_emb which replaces the hierarchical interaction method from attention upsampling to directly concatenate the upsampled encoder embeddings between $S{{}^{\prime}}^{(l)}$ and $S{{}^{\prime}}^{(l-1)}$. 2) HiT\_single\_layer where we only level $l=1$ to train and predict. 3) HiT\_no\_attn with no hierarchical interactions between each pair of successive layers. We train these variants and conduct self-similarity experiments on Porto.

Table 3 shows the comparisons between HiT-JEPA and its variants. The performance drops without any key designs, especially for HiT\_emb, as directly concatenating the embedding from the previous layers causes representation collapse. Results from the other two variants demonstrate that in our model design, even though each layer of $\mathrm{JEPA}^{l}$ can learn individually, the hierarchical interactions bind different levels into a cohesive multi-scale structure.

## 5 Conclusion

In summary, HiT-JEPA introduces a unified three-layer hierarchy that captures point-level fine-grained details, intermediate trajectory patterns, and high-level trajectory semantics within a single self-supervised framework. By leveraging a Hierarchical JEPA, it enables a more powerful trajectory feature extraction in the representation space and produces cohesive multi-granular embeddings. Extensive evaluations on diverse urban and maritime trajectory datasets show that HiT-JEPA outperforms single-scale self-supervised methods in trajectory similarity computation, especially zero-shot generalization and downstream fine-tuning. These results validate its effectiveness and robustness for real-world, large-scale trajectory modeling.

## References

## Appendix A Technical Appendices and Supplementary Material

### A.1 Datasets

Here we list the details of the datasets:

- Porto includes 1.7 million trajectories from 442 taxis in Porto, Portugal. The dataset was collected from July 2013 to June 2014.
- T-Drive contains trajectories of 10,357 taxis in Beijing, China from Feb. 2 to Feb. 8, 2008. The average sampling interval is 3.1 minutes.
- GeoLife contains trajectories of 182 users in Beijing, China from April 2007 to August 2012. There are 17,6212 trajectories in total with most of them sampled in 1–5 seconds.
- Foursquare-TKY is collected for 11 months from April 2012 to February 2013 in Tokyo, Japan, with 573,703 check-ins in total.
- Foursquare-NYC is collected for 11 months from April 2012 to February 2013 in New York City, USA, with 227,428 check-ins in total.
- AIS(AU) comprises vessel traffic records collected by the Craft Tracking System (CTS) of Australia. In this paper, we use vessel trajectories in February 2025.

Table 4: Statistics of Datasets after preprocessing.

<table><tbody><tr><td>Data type</td><td>Dataset</td><td>#points</td><td>#trajectories</td></tr><tr><td rowspan="3">Urban trajectories</td><td>Porto</td><td>65,913,828</td><td>1,372,725</td></tr><tr><td>T-Drive</td><td>5,579,067</td><td>101,842</td></tr><tr><td>GeoLife</td><td>8,987,488</td><td>50,693</td></tr><tr><td rowspan="2">Check-in sequences</td><td>TKY</td><td>106,480</td><td>3,048</td></tr><tr><td>NYC</td><td>28,858</td><td>734</td></tr><tr><td>Vessel trajectories</td><td>AIS(AU)</td><td>485,424</td><td>7,095</td></tr></tbody></table>

We first keep trajectories in urban areas with the number of points ranging from 20 to 200, where the statistics of the datasets after preprocessing are shown in Table 4. We use 200,000 trajectories for Porto, 70,000 for T-Drive, and 35000 for GeoLife as training sets. Each dataset has 10% of data used for validation. As there are many fewer trajectories in TKY, NYC, and AIS(AU), we use all trajectories in these datasets for testing. For the testing set, we select 100,000 trajectories for Porto, 10,000 for T-Drive and GeoLife, 3000 for TKY, 700 for NYC, and 7000 for AIS(AU). For the downstream fine-tuning task, we select 10,000 trajectories for Porto and T-Drive, and 5000 for GeoLife, where the selected trajectories are split by 7:1:2 for training, validation, and testing. We train Hit-JEPA and all baselines from scratch for Porto, T-Drive, and GeoLife datasets. Then, we load the pre-trained weights from Porto and conduct zero-shot self-similarity experiments on each of the TKY, NYC, and AIS(AU) to evaluate the generalization ability of all models.

### A.2 Baselines

We compare Hit-JEPA with three most recent self-supervised free space trajectory similarity computation methods: TrajCL [^7], CLEAR [^22], and T-JEPA [^23]. TrajCL is a contrastive learning method that adopts a dual-feature attention module to capture the trajectory details, which has achieved impactful performance on trajectory similarity computation in multiple datasets and experimental settings. CLEAR improves the contrastive learning process by ranking the positive trajectory samples based on their similarities to anchor samples, capturing detailed differences from similar trajectories. T-JEPA is the most recent method utilizing Joint Embedding Predictive Architecture to encode and predict trajectory information in the representation space, which effectively captures necessary trajectory information. We run these two models from their open-source code repositories with default parameters.

### A.3 Implementation Details

We use Adam Optimizer for training and optimizing the model parameters across all levels, except for the target encoders. The target encoder at each level $l$ updates its parameters via the exponential moving average of the parameters of the context encoder at the same level. The maximum number of training epochs is 20, and the learning rate is 0.0001, decaying by half every 5 epochs. The embedding dimension $d$ is 256, and the batch size is 64. We apply 1-layer Transformer Encoders for both context and target encoders at each level, with the number of attention heads set to 8 and hidden layer dimension to 1024. We use a 1-layer Transformer Decoder as the predictor at each level $l$ with the number of attention heads set to 8. We use learnable positional encoding for all the encoders and decoders. We set the resampling masking ratio to be selected from $r=\{10\%,15\%,20\%,25\%,30\%\}$ and the number of sampled targets $M$ to 4 for each trajectory at each model level $l$. The successive sampling probability $p$ is set to 50%, and the initial context sampling ratio $p_{\gamma}$ is set to range from 85% to 100%. The scale factors for the final loss are $\lambda=0.05$, $\mu=0.15$, and $\nu=0.8$. We use a hexagonal cell resolution of 11 for Porto, resolution 10 for T-Drive, GeoLife, TKY, and NYC, and resolution 4 for AIS(AU). All experiments are conducted on servers with Nvidia A5000 GPUs, 24GB of memory, and 250GB of RAM.

### A.4 Experimental Settings

#### A.4.1 Self-similarity

For each query trajectory $q\in Q$, we create two sub-trajectories $q_{a}=\{p_{1},p_{3},p_{5},\ldots\}$ containing the odd-indexed points and $q_{b}=\{p_{2},p_{4},p_{6},\ldots\}$ even-indexed points of $q$. We separate them by putting $q_{a}$ into the query set $Q$ and putting $q_{b}$ into the database $D$, with the rest of the trajectories in $D$ randomly filled from the testing set. Each $q_{a}$ and $q_{b}$ pair exhibits similar overall patterns in terms of shape, length, and sampling rate. We apply HiT-JEPA context-encoders to both query and database trajectories, compute pairwise similarities, and sort the results in descending order. Next, we report the mean rank of each $q_{b}$ when retrieved by its corresponding query $q_{a}$; ideally, the true match appears at rank one. We choose $\{20\%,40\%.60\%,80\%,100\%\}$ of the total database size | $D$ | for evaluation. To further evaluate the robustness of learned trajectory representations, we also apply down-sampling and distortion on $Q$ and $D$. Specifically, we randomly mask points (with start and end points kept) with down-sampling probability $\rho_{s}$ and shift the point coordinates with distortion probability $\rho_{d}$. Both $\rho_{s}$ and $\rho_{d}$ represent the number of points to be down-sampled or distorted, ranging from $\{0.1,0.2,0.3,0.4,0.5\}$.

For the convenience of comparing results under these settings together, we denote meta ratio $R_{i}=\{\mathrm{|}D\mathrm{|}_{i},{\rho_{s}}_{i},{\rho_{d}}_{i}\}$ and compare the mean rank of all models at each $R_{i}$ on each dataset, smaller values are better.

### A.5 Hyperparameter Analysis

We analyze the impact of two sets of hyperparameters with the implementation and experimental settings in the Appendices section A.3 and A.4.

Number of attention layers at each abstraction level. We change the number of Transformer encoder layers for each level to 2 and 3, then compare them with the default setting (1 layer) for self-similarity search with varying $\mathrm{|}D\mathrm{|}$, $\rho_{s}$ and $\rho_{d}$ on Porto. From Fig. 4, we can find that with only 1 attention layer, we can achieve the lowest mean ranks for all settings. This is due to higher chances of overfitting with more attention layers.

![Refer to caption](https://arxiv.org/html/2507.00028v1/x5.png)

(a) DB size (20%~100%)

![Refer to caption](https://arxiv.org/html/2507.00028v1/x8.png)

(a) DB size (20%~100%)

Batch size. We vary the batch size to 16, 32, and 128 and compare with the default value of 64 for all $\mathrm{|}D\mathrm{|}$, $\rho_{s}$, and $\rho_{d}$ on Porto. As shown in Fig. 5, the model performance remains steady when the batch size is from 32 to 128, while getting much worse at 16. This is possibly because a too low batch size would cause less stable regularization and gradient updates, resulting in an underfitted model.

### A.6 Visualizations

![Refer to caption](https://arxiv.org/html/2507.00028v1/x11.png)

Figure 6: Visualization of predicted masked trajectories.

![Refer to caption](https://arxiv.org/html/2507.00028v1/x20.png)

Figure 7: Visualization of encoded full trajectories.

We visualize two sets of comparisons of 5-NN queries after fine-tuning by Hausdorff measure in Fig. 8(b) and Fig. 9(b), where each row shows the rank 1 to 5 matched trajectories from left to right, given red query trajectories. The rightmost figures are the indices of the query and matched trajectories. We can find that the improvements of HiT-JEPA can find more similar trajectories on ranks 4 and 5, resulting in a higher average $\mathrm{HR}@5$ than T-JEPA.

![Refer to caption](https://arxiv.org/html/2507.00028v1/x29.png)

(a) T-JEPA Visualizations

![Refer to caption](https://arxiv.org/html/2507.00028v1/x41.png)

(a) T-JEPA Visualizations

### A.7 Limitations and Future Work

By upsampling and fusing attention weights across adjacent layers, HiT-JEPA demonstrates one form of hierarchical interaction common to Transformer-based JEPA models. Therefore, one extension could be developing a unified hierarchical interaction framework for all kinds of learning architectures (e.g., CNNs, Mambas, LSTMs, etc.). This will enable each architecture to plug in its customized hierarchy module while preserving a consistent multi-level learning paradigm.

[^1]: H. Alt and M. Godau. Computing the fréchet distance between two polygonal curves. International Journal of Computational Geometry & Applications, 5(01n02):75–91, 1995.

[^2]: M. Assran, Q. Duval, I. Misra, P. Bojanowski, P. Vincent, M. Rabbat, Y. LeCun, and N. Ballas. Self-supervised learning from images with a joint-embedding predictive architecture. In Proceedings of the IEEE/CVF Conference on Computer Vision and Pattern Recognition, pages 15619–15629, 2023.

[^3]: L. Bai, L. Yao, C. Li, X. Wang, and C. Wang. Adaptive graph convolutional recurrent network for traffic forecasting. Advances in neural information processing systems, 33:17804–17815, 2020.

[^4]: A. Bardes, Q. Garrido, J. Ponce, X. Chen, M. Rabbat, Y. LeCun, M. Assran, and N. Ballas. V-jepa: Latent video prediction for visual representation learning. 2023.

[^5]: A. Bardes, J. Ponce, and Y. LeCun. Vicreg: Variance-invariance-covariance regularization for self-supervised learning. arXiv preprint arXiv:2105.04906, 2021.

[^6]: H. Cao, H. Tang, Y. Wu, F. Wang, and Y. Xu. On accurate computation of trajectory similarity via single image super-resolution. In 2021 International Joint Conference on Neural Networks (IJCNN), pages 1–9. IEEE, 2021.

[^7]: Y. Chang, J. Qi, Y. Liang, and E. Tanin. Contrastive trajectory similarity learning with dual-feature attention. In 2023 IEEE 39th International conference on data engineering (ICDE), pages 2933–2945. IEEE, 2023.

[^8]: L. Chen and R. Ng. On the marriage of lp-norms and edit distance. In Proceedings of the Thirtieth international conference on Very large data bases-Volume 30, pages 792–803, 2004.

[^9]: L. Chen, M. T. Özsu, and V. Oria. Robust and fast similarity search for moving object trajectories. In Proceedings of the 2005 ACM SIGMOD international conference on Management of data, pages 491–502, 2005.

[^10]: R. J. Chen, C. Chen, Y. Li, T. Y. Chen, A. D. Trister, R. G. Krishnan, and F. Mahmood. Scaling vision transformers to gigapixel images via hierarchical self-supervised learning. In Proceedings of the IEEE/CVF conference on computer vision and pattern recognition, pages 16144–16155, 2022.

[^11]: Y. Chen, X. Li, G. Cong, Z. Bao, C. Long, Y. Liu, A. K. Chandran, and R. Ellison. Robust road network representation learning: When traffic patterns meet traveling semantics. In Proceedings of the 30th ACM International Conference on Information & Knowledge Management, pages 211–220, 2021.

[^12]: Z. Chen, X. Xiao, Y.-J. Gong, J. Fang, N. Ma, H. Chai, and Z. Cao. Interpreting trajectories from multiple views: A hierarchical self-attention network for estimating the time of arrival. In Proceedings of the 28th ACM SIGKDD Conference on Knowledge Discovery and Data Mining, pages 2771–2779, 2022.

[^13]: J. Devlin, M.-W. Chang, K. Lee, and K. Toutanova. Bert: Pre-training of deep bidirectional transformers for language understanding. In Proceedings of the 2019 conference of the North American chapter of the association for computational linguistics: human language technologies, volume 1 (long and short papers), pages 4171–4186, 2019.

[^14]: A. Dosovitskiy, L. Beyer, A. Kolesnikov, D. Weissenborn, X. Zhai, T. Unterthiner, M. Dehghani, M. Minderer, G. Heigold, S. Gelly, et al. An image is worth 16x16 words: Transformers for image recognition at scale. arXiv preprint arXiv:2010.11929, 2020.

[^15]: Z. Fang, Y. Du, L. Chen, Y. Hu, Y. Gao, and G. Chen. E 2 dtc: An end to end deep trajectory clustering framework via self-training. In 2021 IEEE 37th International Conference on Data Engineering (ICDE), pages 696–707. IEEE, 2021.

[^16]: A. Grover and J. Leskovec. node2vec: Scalable feature learning for networks. In Proceedings of the 22nd ACM SIGKDD international conference on Knowledge discovery and data mining, pages 855–864, 2016.

[^17]: K. He, X. Chen, S. Xie, Y. Li, P. Dollár, and R. Girshick. Masked autoencoders are scalable vision learners. In Proceedings of the IEEE/CVF conference on computer vision and pattern recognition, pages 16000–16009, 2022.

[^18]: S. Hochreiter and J. Schmidhuber. Long short-term memory. Neural computation, 9(8):1735–1780, 1997.

[^19]: L. Kong, M. Q. Ma, G. Chen, E. P. Xing, Y. Chi, L.-P. Morency, and K. Zhang. Understanding masked autoencoders via hierarchical latent variable models. In Proceedings of the IEEE/CVF Conference on Computer Vision and Pattern Recognition, pages 7918–7928, 2023.

[^20]: Y. LeCun. A path towards autonomous machine intelligence version 0.9. 2, 2022-06-27. Open Review, 62(1):1–62, 2022.

[^21]: D. Li, T. Zhang, N. Hu, C. Wang, and X. He. Hiclre: A hierarchical contrastive learning framework for distantly supervised relation extraction. arXiv preprint arXiv:2202.13352, 2022.

[^22]: J. Li, T. Liu, and H. Lu. Clear: Ranked multi-positive contrastive representation learning for robust trajectory similarity computation. In 2024 25th IEEE International Conference on Mobile Data Management (MDM), pages 21–30. IEEE, 2024.

[^23]: L. Li, H. Xue, Y. Song, and F. Salim. T-jepa: A joint-embedding predictive architecture for trajectory similarity computation. In Proceedings of the 32nd ACM International Conference on Advances in Geographic Information Systems, pages 569–572, 2024.

[^24]: X. Li, K. Zhao, G. Cong, C. S. Jensen, and W. Wei. Deep representation learning for trajectory similarity computation. In 2018 IEEE 34th international conference on data engineering (ICDE), pages 617–628. IEEE, 2018.

[^25]: Y. Lin, H. Wan, S. Guo, J. Hu, C. S. Jensen, and Y. Lin. Pre-training general trajectory embeddings with maximum multi-view entropy coding. IEEE Transactions on Knowledge and Data Engineering, 36(12):9037–9050, 2023.

[^26]: X. Liu, X. Tan, Y. Guo, Y. Chen, and Z. Zhang. Cstrm: Contrastive self-supervised trajectory representation model for trajectory similarity computation. Computer Communications, 185:159–167, 2022.

[^27]: T. Mikolov, K. Chen, G. Corrado, and J. Dean. Efficient estimation of word representations in vector space. arXiv preprint arXiv:1301.3781, 2013.

[^28]: T. Qian, J. Li, Y. Chen, G. Cong, T. Sun, F. Wang, and Y. Xu. Context-enhanced multi-view trajectory representation learning: Bridging the gap through self-supervised models. arXiv preprint arXiv:2410.13196, 2024.

[^29]: A. Vaswani, N. Shazeer, N. Parmar, J. Uszkoreit, L. Jones, A. N. Gomez, Ł. Kaiser, and I. Polosukhin. Attention is all you need. Advances in neural information processing systems, 30, 2017.

[^30]: F. Xiao, K. Kundu, J. Tighe, and D. Modolo. Hierarchical self-supervised representation learning for movie understanding. In Proceedings of the IEEE/CVF conference on computer vision and pattern recognition, pages 9727–9736, 2022.

[^31]: C. Yang, R. Jiang, X. Xu, C. Xiao, and K. Sezaki. Simformer: Single-layer vanilla transformer can learn free-space trajectory similarity. arXiv preprint arXiv:2410.14629, 2024.

[^32]: D. Yang, D. Zhang, V. W. Zheng, and Z. Yu. Modeling user activity preference by leveraging user spatial temporal characteristics in lbsns. IEEE Transactions on Systems, Man, and Cybernetics: Systems, 45(1):129–142, 2014.

[^33]: P. Yang, H. Wang, Y. Zhang, L. Qin, W. Zhang, and X. Lin. T3s: Effective representation learning for trajectory similarity computation. In 2021 IEEE 37th international conference on data engineering (ICDE), pages 2183–2188. IEEE, 2021.

[^34]: D. Yao, G. Cong, C. Zhang, and J. Bi. Computing trajectory similarity in linear time: A generic seed-guided neural metric learning approach. In 2019 IEEE 35th international conference on data engineering (ICDE), pages 1358–1369. IEEE, 2019.

[^35]: D. Yao, J. Wang, W. Chen, F. Guo, P. Han, and J. Bi. Deep dirichlet process mixture model for non-parametric trajectory clustering. In 2024 IEEE 40th International Conference on Data Engineering (ICDE), pages 4449–4462. IEEE, 2024.

[^36]: B.-K. Yi, H. V. Jagadish, and C. Faloutsos. Efficient retrieval of similar time sequences under time warping. In Proceedings 14th International Conference on Data Engineering, pages 201–208. IEEE, 1998.

[^37]: B. Yu, H. Yin, and Z. Zhu. Spatio-temporal graph convolutional networks: A deep learning framework for traffic forecasting. arXiv preprint arXiv:1709.04875, 2017.

[^38]: J. Yuan, Y. Zheng, X. Xie, and G. Sun. Driving with knowledge from the physical world. In Proceedings of the 17th ACM SIGKDD international conference on Knowledge discovery and data mining, pages 316–324, 2011.

[^39]: J. Yuan, Y. Zheng, C. Zhang, W. Xie, X. Xie, G. Sun, and Y. Huang. T-drive: driving directions based on taxi trajectories. In Proceedings of the 18th SIGSPATIAL International conference on advances in geographic information systems, pages 99–108, 2010.

[^40]: X. Zhang, F. Wei, and M. Zhou. Hibert: Document level pre-training of hierarchical bidirectional transformers for document summarization. arXiv preprint arXiv:1905.06566, 2019.

[^41]: Y. Zheng, Q. Li, Y. Chen, X. Xie, and W.-Y. Ma. Understanding mobility based on gps data. In Proceedings of the 10th international conference on Ubiquitous computing, pages 312–321, 2008.

[^42]: Y. Zheng, X. Xie, W.-Y. Ma, et al. Geolife: A collaborative social networking service among user, location and trajectory. IEEE Data Eng. Bull., 33(2):32–39, 2010.

[^43]: Y. Zheng, L. Zhang, X. Xie, and W.-Y. Ma. Mining interesting locations and travel sequences from gps trajectories. In Proceedings of the 18th international conference on World wide web, pages 791–800, 2009.

[^44]: Y. Zhu, J. J. Yu, X. Zhao, X. Wei, and Y. Liang. Unitraj: Learning a universal trajectory foundation model from billion-scale worldwide traces. CoRR, 2024.