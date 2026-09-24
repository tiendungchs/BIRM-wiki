---
title: "Hypergraph Neural Networks"
source: "https://ar5iv.labs.arxiv.org/html/1809.09401"
author:
published:
created: 2026-09-24
description: "In this paper, we present a hypergraph neural networks (HGNN) framework for data representation learning, which can encode high-order data correlation in a hypergraph structure. Confronting the challenges of learning r…"
tags:
  - "clippings"
---
Yifan Feng    Haoxuan You Affiliation: Fujian Key Laboratory of Sensing and Computing for Smart City, Department of Cognitive ScienceSchool of Information Science and Engineering, Xiamen University, 361005, China    Zizhao Zhang Affiliation: BNRist, KLISS, School of Software, Tsinghua University, 100084, China.{evanfeng97, haoxuanyou}@gmail.com, rrji@xmu.edu.cn, {zz-z14,gaoyue}@tsinghua.edu.cn    Rongrong Ji Affiliation: BNRist, KLISS, School of Software, Tsinghua University, 100084, China.{evanfeng97, haoxuanyou}@gmail.com, rrji@xmu.edu.cn, {zz-z14,gaoyue}@tsinghua.edu.cn    Yue Gao Thanks: Corresponding author. This work was finished when Yifan Feng visited Tsinghua University. Affiliation: Fujian Key Laboratory of Sensing and Computing for Smart City, Department of Cognitive ScienceSchool of Information Science and Engineering, Xiamen University, 361005, China Affiliation: Peng Cheng Laboratory, China Affiliation: BNRist, KLISS, School of Software, Tsinghua University, 100084, China.{evanfeng97, haoxuanyou}@gmail.com, rrji@xmu.edu.cn, {zz-z14,gaoyue}@tsinghua.edu.cn

###### Abstract

In this paper, we present a hypergraph neural networks (HGNN) framework for data representation learning, which can encode high-order data correlation in a hypergraph structure. Confronting the challenges of learning representation for complex data in real practice, we propose to incorporate such data structure in a hypergraph, which is more flexible on data modeling, especially when dealing with complex data. In this method, a hyperedge convolution operation is designed to handle the data correlation during representation learning. In this way, traditional hypergraph learning procedure can be conducted using hyperedge convolution operations efficiently. HGNN is able to learn the hidden layer representation considering the high-order data structure, which is a general framework considering the complex data correlations. We have conducted experiments on citation network classification and visual object recognition tasks and compared HGNN with graph convolutional networks and other traditional methods. Experimental results demonstrate that the proposed HGNN method outperforms recent state-of-the-art methods. We can also reveal from the results that the proposed HGNN is superior when dealing with multi-modal data compared with existing methods.

## Introduction

Graph-based convolutional neural networks \[[\\citeauthoryearKipf and Welling2017](#bib.bibx14)\], \[[\\citeauthoryearDefferrard, Bresson, and Vandergheynst2016](#bib.bibx4)\] have attracted much attention in recent years. Different from traditional convolutional neural networks, graph convolution is able to encode the graph structure of different input data using a neural network model and it can be used in the semi-supervised learning procedure. Graph convolutional neural networks have shown superiority on representation learning compared with traditional neural networks due to its ability of using data graph structure.

In traditional graph convolutional neural network methods, the pairwise connections among data are employed. It is noted that the data structure in real practice could be beyond pairwise connections and even far more complicated. Confronting the scenarios with multi-modal data, the situation for data correlation modelling could be more complex. Figure 1 provides examples of complex connections on social media data. On one hand, the data correlation can be more complex than pairwise relationship, which is difficult to be modeled by a graph structure. On the other hand, the data representation tends to be multi-modal, such as the visual connections, text connections and social connections in this example. Under such circumstances, traditional graph structure has the limitation to formulate the data correlation, which limits the application of graph convolutional neural networks. Under such circumstance, it is important and urgent to further investigate better and more general data structure model to learn representation.

![Refer to caption](https://ar5iv.labs.arxiv.org/html/1809.09401/assets/complex_correlation.png)

Figure 1: Examples of complex connections on social media data. Each color point represents a tweet or microblog, and there could be visual connections, text connections and social connections among them.

![Refer to caption](https://ar5iv.labs.arxiv.org/html/1809.09401/assets/comparison.png)

Figure 2: The comparison between graph and hypergraph.

To tackle this challenging issue, in this paper, we propose a hypergraph neural networks (HGNN) framework, which uses the hypergraph structure for data modeling. Compared with simple graph, on which the degree for all edges is mandatory 2, a hypergraph can encode high-order data correlation (beyond pairwise connections) using its degree-free hyperedges, as shown in Figure 2. In Figure 2, the graph is represented using the adjacency matrix, in which each edge connects just two vertices. On the contrary, a hypergraph is easy to be expanded for multi-modal and heterogeneous data representation using its flexible hyperedges. For example, a hypergraph can jointly employ multi-modal data for hypergraph generation by combining the adjacency matrix, as illustrated in Figure 2. Therefore, hypergraph has been employed in many computer vision tasks such as classification and retrieval tasks \[[\\citeauthoryearGao et al.2012](#bib.bibx6)\]. However, traditional hypergraph learning methods \[[\\citeauthoryearZhou, Huang, and Schölkopf2007](#bib.bibx29)\] suffer from their high computation complexity and storage cost, which limits the wide application of hypergraph learning methods.

In this paper, we propose a hypergraph neural networks framework (HGNN) for data representation learning. In this method, the complex data correlation is formulated in a hypergraph structure, and we design a hyperedge convolution operation to better exploit the high-order data correlation for representation learning. More specifically, HGNN is a general framework which can incorporate with multi-modal data and complicated data correlations. Traditional graph convolutional neural networks can be regarded as a special case of HGNN. To evaluate the performance of the proposed HGNN framework, we have conducted experiments on citation network classification and visual object recognition tasks. The experimental results on four datasets and comparisons with graph convolutional network (GCN) and other traditional methods have shown better performance of HGNN. These results indicate that the proposed HGNN method is more effective on learning data representation using high-order and complex correlations.

The main contributions of this paper are two-fold:

1. We propose a hypergraph neural networks framework, i.e., HGNN, for representation learning using hypergraph structure. HGNN is able to formulate complex and high-order data correlation through its hypergraph structure and can be also efficient using hyperedge convolution operations. It is effective on dealing with multi-modal data/features. Moreover, GCN \[[\\citeauthoryearKipf and Welling2017](#bib.bibx14)\] can be regarded as a special case of HGNN, for which the edges in simple graph can be regarded as 2-order hyperedges which connect just two vertices.
2. We have conducted extensive experiments on citation network classification and visual object classification tasks. Comparisons with state-of-the-art methods demonstrate the effectiveness of the proposed HGNN framework. Experiments also indicate the better performance of the proposed method when dealing with multi-modal data.

![Refer to caption](https://ar5iv.labs.arxiv.org/html/1809.09401/assets/pipeline.png)

Figure 3: The proposed HGNN framework.

## Related Work

In this section, we briefly review existing works of hypergraph learning and neural networks on graph.

### Hypergraph learning

In many computer vision tasks, the hypergraph structure has been employed to model high-order correlation among data. Hypergraph learning is first introduced in \[[\\citeauthoryearZhou, Huang, and Schölkopf2007](#bib.bibx29)\], as a propagation process on hypergraph structure. The transductive inference on hypergraph aims to minimize the label difference among vertices with stronger connections on hypergraph. In \[[\\citeauthoryearHuang, Liu, and Metaxas2009](#bib.bibx11)\], hypergraph learning is further employed in video object segmentation. \[[\\citeauthoryearHuang et al.2010](#bib.bibx10)\] used the hypergraph structure to model image relationship and conducted transductive inference process for image ranking. To further improve the hypergraph structure, research attention has been attracted for leaning the weights of hyperedges, which have great influence on modeling the correlation of data. In \[[\\citeauthoryearGao et al.2013](#bib.bibx7)\], a $\mathit{l}_{2}$ regularize on the weights is introduced to learn optimal hyperedge weights. In \[[\\citeauthoryearHwang et al.2008](#bib.bibx12)\], the correlation among hyperedges is further explored by a assumption that highly correlated hyperedges should have similar weights. Regarding the multi-modal data, in \[[\\citeauthoryearGao et al.2012](#bib.bibx6)\], multi-hypergraph structure is introduced to assign weights for different sub-hypergraphs, which corresponds to different modalities.

### Neural networks on graph

Since many irregular data that do not own a grid-like structure can only be represented in the form of graph, extending neural networks to graph structure has attracted great attention from researchers. In \[[\\citeauthoryearGori, Monfardini, and Scarselli2005](#bib.bibx8)\] and \[[\\citeauthoryearScarselli et al.2009](#bib.bibx22)\], the neural network on graph is first introduced to apply recurrent neural networks to deal with graphs. For generalizing convolution network to graph, the methods are divided into spectral and non-spectral approaches.

For spectral approaches, the convolution operation is formulated in spectral domain of graph. \[[\\citeauthoryearBruna et al.2014](#bib.bibx2)\] introduces the first graph CNN, which uses the graph Laplacian eigenbasis as an analogy of the Fourier transform. In \[[\\citeauthoryearHenaff, Bruna, and LeCun2015](#bib.bibx9)\], the spectral filters can be parameterized with smooth coefficients to make them spatial-localized. In \[[\\citeauthoryearDefferrard, Bresson, and Vandergheynst2016](#bib.bibx4)\], a Chebyshev expansion of the graph Laplacian is further used to approximate the spectral filters. Then, in \[[\\citeauthoryearKipf and Welling2017](#bib.bibx14)\], the chebyshev polynomials are simplified into 1-order polynomials to form an efficient layer-wise propagation model.

For spatial approaches, the convolution operation is defined in groups of spatial close nodes. In \[[\\citeauthoryearAtwood and Towsley2016](#bib.bibx1)\], the powers of a transition matrix is employed to define the neighborhood of nodes. \[[\\citeauthoryearMonti et al.2017](#bib.bibx18)\] uses the local path operators in the form of Gaussian mixture models to generalize convolution in spatial domain. In \[[\\citeauthoryearVelickovic et al.2018](#bib.bibx26)\], the attention mechanisms is introduced into the graph to build attention-based architecture to perform the node classification task on graph.

## Hypergraph Neural Networks

In this section, we introduce our proposed hypergraph neural networks (HGNN). We first briefly introduce hypergraph learning, and then the spectral convolution on hypergraph is provided. Following, we analyze the relations between HGNN and existing methods. In the last part of the section, some implementation details will be given.

### Hypergraph learning statement

We first review the hypergraph analysis theory. Different from simple graph, a hyperedge in a hypergraph connects two or more vertices. A hypergraph is defined as $\mathcal{G}=(\mathcal{V,E},\bf W)$, which includes a vertex set $\mathcal{V}$, a hyperedge set $\mathcal{E}$. Each hyperedge is assigned with a weight by $\bf W$, a diagonal matrix of edge weights. The hypergraph $\mathcal{G}$ can be denoted by a $|\mathcal{V}|\times|\mathcal{E}|$ incidence matrix $\bf H$, with entries defined as

$$
h(v,e)=\left\{\begin{array}[]{lr}1,&\mbox{if}\;v\in e\\
0,&\mbox{if}\;v\not\in e,\end{array}\right.
$$

For a vertex $v\in\mathcal{V}$, its degree is defined as $d(v)=\sum_{e\in\mathcal{E}}\omega(e)h(v,e)$. For an edge $e\in\mathcal{E}$, its degree is defined as $\delta(e)=\sum_{v\in\mathcal{V}}h(v,e)$. Further, ${\bf D}_{e}$ and ${\bf D}_{v}$ denote the diagonal matrices of the edge degrees and the vertex degrees, respectively.

Here let us consider the node(vertex) classification problem on hypergraph, where the node labels should be smooth on the hypergraph structure. The task can be formulated as a regularization framework as introduced by \[[\\citeauthoryearZhou, Huang, and Schölkopf2007](#bib.bibx29)\]:

$$
\mbox{arg}\,\min_{f}\,\{\mathcal{R}_{emp}(f)+\Omega(f)\},
$$

where $\Omega(f)$ is a regularize on hypergraph, $\mathcal{R}_{emp}(f)$ denotes the supervised empirical loss, $f(\cdot)$ is a classification function. The regularize $\Omega(f)$ is defined as:

$$
\displaystyle\Omega(f)=
$$
 
$$
\displaystyle\frac{1}{2}\sum_{e\in\mathcal{E}}\sum_{\left\{u,v\right\}\in\mathcal{V}}\frac{w(e)h(u,e)h(v,e)}{\delta(e)}
$$
 
$$
\displaystyle\Big(\frac{f(u)}{\sqrt{d(u)}}-\frac{f(v)}{\sqrt{d(v)}}\Big)^{2},
$$

We let ${\bf\theta}={\bf D}^{-1/2}_{v}{\bf H}{\bf W}{\bf D}_{e}^{-1}{\bf H}^{\top}{\bf D}^{-1/2}_{v}$ and ${\bf\Delta}={\bf I}-{\bf\Theta}$. Then, the normalized $\Omega(f)$ can be written as

$$
\Omega(f)=f^{\top}{\bf\Delta},
$$

where $\bf\Delta$ is positive semi-definite, and usually called the hypergraph Laplacian.

![Refer to caption](https://ar5iv.labs.arxiv.org/html/1809.09401/assets/Hypergraph_Conv.png)

Figure 4: The illustration of the hyperedge convolution layer.

### Spectral convolution on hypergraph

Given a hypergraph $\mathcal{G}=(\mathcal{V,E},\bf\Delta)$ with $n$ vertices, since the hypergraph Laplacian ${\bf\Delta}$ is a $n\times n$ positive semi-definite matrix, the eigen decomposition ${\bf\Delta=\Phi\Lambda\Phi}^{\top}$ can be employed to get the orthonormal eigen vectors ${\bf\Phi}=\mbox{diag}(\phi_{1},\dots,\phi_{n})$ and a diagonal matrix $\bf\Lambda=\mbox{diag}(\lambda_{1},\dots,\lambda_{n})$ containing corresponding non-negative eigenvalues. Then, the Fourier transform for a signal $\bf x=(x_{1},\dots,x_{n})$ in hypergraph is defined as $\hat{\bf x}={\bf\Phi}^{\top}{\bf x}$, where the eigen vectors are regarded as the Fourier bases and the eigenvalues are interpreted as frequencies. The spectral convolution of signal ${\bf x}$ and filter $\bf g$ can be denoted as

$$
{\bf g\star x}={\bf\Phi((\Phi^{\top}}{\bf g)\odot(\Phi^{\top}}{\bf x}))={\bf\Phi}g({\bf\Lambda}){\bf\Phi}^{\top}{\bf x},
$$

where $\odot$ denotes the element-wise Hadamard product and $g(\bf\Lambda)=\mbox{diag}(g(\lambda_{1}),\dots,g(\lambda_{n}))$ is a function of the Fourier coefficients. However, the computation cost in forward and inverse Fourier transform is $\mathcal{O}(n^{2})$. To solve the problem, we can follow \[[\\citeauthoryearDefferrard, Bresson, and Vandergheynst2016](#bib.bibx4)\] to parametrize $g(\bf\Lambda)$ with $K$ order polynomials. Furthermore, we use the truncated Chebyshev expansion as one such polynomial. Chebyshv polynomials $T_{k}(x)$ is recursively computed by $T_{k}(x)=2xT_{k-1}(x)-T_{k-2}(x)$, with $T_{0}(x)=1$ and $T_{1}(x)=x$. Thus, the $g({\bf\Lambda})$ can be parametried as

$$
{\bf g\star x}\approx\sum_{k=0}^{K}\theta_{k}T_{k}(\tilde{\bf\Delta}){\bf x},
$$

where $T_{k}(\tilde{\bf\Delta})$ is the Chebyshev polynomial of order $k$ with scaled Laplacian $\tilde{\bf\Delta}=\frac{2}{\lambda_{max}}{\bf\Delta}-\bf I$. In Equation 6, the expansive computation of Laplacian Eigen vectors is excluded and only matrix powers, additions and multiplications are included, which brings further improvement in computation complexity. We can further let $K=1$ to limit the order of convolution operation due to that the Laplacian in hypergraph can already well represent the high-order correlation between nodes. It is also suggested in \[[\\citeauthoryearKipf and Welling2017](#bib.bibx14)\] that $\lambda_{max}\approx 2$ because of the scale adaptability of neural networks. Then, the convolution operation can be further simplified to

$$
{\bf g\star x}\approx\theta_{0}\bf x-\theta_{1}{\bf D}^{-1/2}{\bf HWD}_{e}^{-1}{\bf H}^{\top}{\bf D}^{-1/2}_{v}x,
$$

where $\theta_{0}$ and $\theta_{1}$ is parameters of filters over all nodes. We further use a single parameter $\theta$ to avoid the overfitting problem, which is defined as

$$
\left\{\begin{array}[]{lr}\theta_{1}=-\frac{1}{2}\theta\\
\theta_{0}=\frac{1}{2}\theta{\bf D}^{-1/2}_{v}{\bf H}{\bf D}_{e}^{-1}{\bf H}^{\top}{\bf D}^{-1/2}_{v},\end{array}\right.
$$

Then, the convolution operation can be simplified to the following expression

$$
\displaystyle{\bf g\star x}
$$
 
$$
\displaystyle\approx\frac{1}{2}\theta{\bf D}^{-1/2}_{v}{\bf H}({\bf W}+{\bf I}){\bf D}_{e}^{-1}{\bf H}^{\top}{\bf D}^{-1/2}_{v}{\bf x}
$$
 
$$
\displaystyle\approx\theta{\bf D}^{-1/2}_{v}{\bf H}{\bf W}{\bf D}_{e}^{-1}{\bf H}^{\top}{\bf D}^{-1/2}_{v}{\bf x},
$$

where $(\bf W+\bf I)$ can be regarded as the weight of the hyperedges. $\bf W$ is initialized as an identity matrix, which means equal weights for all hyperedges.

When we have a hypergraph signal $\bf X\in\mathbb{R}^{n\times C_{1}}$ with $n$ nodes and $C_{1}$ dimensional features, our hyperedge convolution can be formulated by

$$
\bf Y={\bf D}^{-1/2}_{v}{\bf HWD}_{e}^{-1}{\bf H}^{\top}{\bf D}^{-1/2}_{v}{\bf X}\bf\Theta,
$$

where $\bf W=\mbox{diag}(w_{1},\dots,w_{n})$. $\Theta\in\mathbb{R}^{C_{1}\times C_{2}}$ is the parameter to be learned during the training process. The filter $\bf\Theta$ is applied over the nodes in hypergraph to extract features. After convolution, we can obtain ${\bf Y}\in\mathbb{R}^{n\times C_{2}}$, which can be used for classification.

### Hypergraph neural networks analysis

Figure 3 illustrates the details of the hypergraph neural networks. Multi-modality datasets are divided into training data and testing data, and each data contains several nodes with features. Then multiple hyperedge structure groups are constructed from the complex correlation of the multi-modality datasets. We concatenate the hyperedge groups to generate the hypergraph adjacent matrix $\bf H$. The hypergraph adjacent matrix $\bf H$ and the node feature are fed into the HGNN to get the node output labels. As introduced in the above section, we can build a hyperedge convolutional layer $f(\bf X,W,\Theta)$ in the following formulation

$$
{\bf X}^{(l+1)}=\sigma({\bf D}^{-1/2}_{v}{\bf H}{\bf W}{\bf D}_{e}^{-1}{\bf H}^{\top}{\bf D}^{-1/2}_{v}{\bf X}^{(l)}{\bf\Theta}^{(l)}),
$$

where ${\bf X}^{(1)}\in\mathbb{R}^{N\times C}$ is the signal of hypergraph at $l$ layer, ${\bf X}^{(0)}=\bf X$ and $\sigma$ denotes the nonlinear activation function.

The HGNN model is based on the spectral convolution on the hypergraph. Here, we further investigate HGNN in the property of exploiting high-order correlation among data. As is shown in Figure 4, the HGNN layer can perform node-edge-node transform, which can better refine the features using the hypergraph structure. More specifically, at first, the initial node feature ${\bf X}^{(1)}$ is processed by learnable filter matrix ${\bf\Theta}^{(1)}$ to extract $C_{2}$ -dimensional feature. Then, the node feature is gathered according to the hyperedge to form the hyperedge feature $\mathbb{R}^{E\times C_{2}}$, which is implemented by the multiplication of $\bf H^{\top}\in\mathbb{R}^{E\times N}$. Finally the output node feature is obtained by aggregating their related hyperedge feature, which is achieved by multiplying matrix $\bf H$. Denote that $\bf D_{v}$ and $\bf D_{e}$ play a role of normalization in Equation 11. Thus, the HGNN layer can efficiently extract the high-order correlation on hypergraph by the node-edge-node transform.

##### Relations to existing methods

When the hyperedges only connect two vertices, the hypergraph is simplified into a simple graph and the Laplacian $\bf\Delta$ is also coincident with the Laplacian of simple graph up to a factor of $\frac{1}{2}$. Compared with the existing graph convolution methods, our HGNN can naturally model high-order relationship among data, which is effectively exploited and encoded in forming feature extraction. Compared with the traditional hypergraph method, our model is highly efficient in computation without the inverse operation of Laplacian $\bf\Delta$. It should also be noted that our HGNN has great expansibility toward multi-modal feature with the flexibility of hyperedge generation.

### Implementation

##### Hypergraph construction

In our visual object classification task, the features of $N$ visual object data can be represented as ${\bf X=[x_{1},\dots,x_{n}]}^{\top}$. We build the hypergraph according to the distance between two features. More specifically, Euclidean distance is used to calculate $d({\bf x}_{i},{\bf x}_{j})$. In the construction, each vertex represents one visual object, and each hyperedge is formed by connecting one vertex and its $K$ nearest neighbors, which brings $N$ hyperedges that links $K+1$ vertices. And thus, we get the incidence matrix ${\bf H}\in\mathbb{R}^{N\times N}$ with $N\times(K+1)$ entries equaling to 1 while others equaling to 0. In the citation network classification, where the data are organized in graph structure, each hyperedge is built by linking one vertex and their neighbors according to the adjacency relation on graph. So we also get $N$ hyperedges and $\bf H\in\mathbb{R}^{N\times N}$.

##### Model for node classification

In the problem of node classification, we build the HGNN model as in Figure 3. The dataset is divided into training data and test data. Then hypergraph is constructed as the section above, which generates the incidence matrix $\bf H$ and corresponding $\bf D_{e}$. We build a two-layer HGNN model to employ the powerful capacity of HGNN layer. And the softmax function is used to generate predicted labels. During training, the cross-entropy loss for the training data is back-propagated to update the parameters $\bf\Theta$ and in testing, the labels of test data is predicted for evaluating the performance. When there are multi-modal information incorporate them by the construction of hyperedge groups and then various hyperedges are fused together to model the complex relationship on data.

## Experiments

In this section, we evaluate our proposed hypergraph neural networks on two task: citation network classification and visual object recognition. We also compare the proposed method with graph convolutional networks and other state-of-the-art methods.

| Dataset | Cora | Pumbed |
| --- | --- | --- |
| Nodes | 2708 | 19717 |
| Edges | 5429 | 44338 |
| Feature | 1433 | 500 |
| Training node | 140 | 60 |
| Validation node | 500 | 500 |
| Testing node | 1000 | 1000 |
| Classes | 7 | 3 |

Table 1: Summary of the citation classification datasets.

### Citation network classification

##### Datasets

In this experiment, the task is to classify citation data. Here, two widely used citation network datasets, i.e., Cora and Pubmed \[[\\citeauthoryearSen et al.2008](#bib.bibx23)\] are employed. The experimental setup follows the settings in \[[\\citeauthoryearYang, Cohen, and Salakhutdinov2016](#bib.bibx28)\]. In both of those two datasets, the feature for each data is the bag-of-words representation of documents. The data connection, i.e., the graph structure, indicates the citations among those data. To generate the hypergraph structure for HGNN, each time one vertex in the graph is selected as the centroid and its connected vertices are used to generate one hyperedge including the centroid itself. Through this we can obtain the same size incidence matrix compared with the original graph. It is noted that as there are no more information for data relationship, the generated hypergraph constructure is quite similar to the graph. The Cora dataset contains 2708 data and 5% are used as labeled data for training. The Pubmed dataset contains 19717 data, and only 0.3% are used for training. The detailed description for the two datasets listed in Table 1.

##### Experimental settings

In this experiment, a two-layer HGNN is applied. The feature dimension of the hidden layer is set as 16 and the dropout \[[\\citeauthoryearSrivastava et al.2014](#bib.bibx24)\] is employed to avoid overfitting with drop rate $p=0.5$. We choose the ReLU as the nonlinear activation function. During the training process, we use Adam optimizer \[[\\citeauthoryearKingma and Ba2014](#bib.bibx13)\] to minimize our cross-entropy loss function with a learning rate of 0.001. We have also compared the proposed HGNN with recent methods in these experiments.

##### Results and discussion

The results of the experimental results and comparisons on the citation network dataset are shown in Table 2. For our HGNN model, we report the average classification accuracy of 100 runs on Core and Pumbed, which is 81.6% and 80.1%. As shown in the results, the proposed HGNN model can achieve the best or comparable performance compared with the state-of-the-art methods. Compared with GCN, the proposed HGNN method can achieve a slight improvement on the Cora dataset and 1.1% improvement on the Pubmed dataset. We note that the generated hypergraph structure is quite similar to the graph structure as there is neither extra nor more complex information in these data. Therefore, the gain obtained by HGNN is not very significant.

| Method | Cora | Pubmed |
| --- | --- | --- |
| DeepWalk \[[\\citeauthoryearPerozzi, Al-Rfou, and Skiena2014](#bib.bibx19)\] | 67.2% | 65.3% |
| ICA \[[\\citeauthoryearLu and Getoor2003](#bib.bibx17)\] | 75.1% | 73.9% |
| Planetoid \[[\\citeauthoryearYang, Cohen, and Salakhutdinov2016](#bib.bibx28)\] | 75.7% | 77.2% |
| Chebyshev \[[\\citeauthoryearDefferrard, Bresson, and Vandergheynst2016](#bib.bibx4)\] | 81.2% | 74.4% |
| GCN \[[\\citeauthoryearKipf and Welling2017](#bib.bibx14)\] | 81.5% | 79.0% |
| HGNN | 81.6% | 80.1% |

Table 2: Classification results on the Cora and Pubmed datasets.

### Visual object classification

##### Datasets and experimental settings

In this experiment, the task is to classify visual objects. Two public benchmarks are employed here, including the Princeton ModelNet40 dataset \[[\\citeauthoryearWu et al.2015](#bib.bibx27)\] and the National Taiwan University (NTU) 3D model dataset \[[\\citeauthoryearChen et al.2003](#bib.bibx3)\], as shown in Table 3. The ModelNet40 dataset consists of 12,311 objects from 40 popular categories, and the same training/testing split is applied as introduced in \[[\\citeauthoryearWu et al.2015](#bib.bibx27)\], where 9,843 objects are used for training and 2,468 objects are used for testing. The NTU dataset is composed of 2,012 3D shapes from 67 categories, including car, chair, chess, chip, clock, cup, door, frame, pen, plant leaf and so on. In the NTU dataset, 80% data are used for training and the other 20% data are used for testing. In this experiment, each 3D object is represented by the extracted features. Here, two recent state-of-the-art shape representation methods are employed, including Multi-view Convolutional Neural Network (MVCNN) \[[\\citeauthoryearSu et al.2015](#bib.bibx25)\] and Group-View Convolutional Neural Network (GVCNN) \[[\\citeauthoryearFeng et al.2018](#bib.bibx5)\]. These two methods are selected due to that they have shown satisfactory performance on 3D object representation. We follow the experimental settings of MVCNN and GVCNN to generate multiple views of each 3D object. Here, 12 virtual cameras are employed to capture views with a interval angle of 30 degree, and then both the MVCNN and the GVCNN features are extracted accordingly.

To compare with GCN method, it is noted that there is no available graph structure in the ModelNet40 dataset and the NTU dataset. Therefore, we construct a probability graph based on the distance of nodes. Given the features of data, the affinity matrix $A$ is generated to represent the relationship among different vertices, and $A_{ij}$ can be calculated by:

$$
A_{ij}=\exp(-\frac{2D{ij}^{2}}{\Delta})
$$

where $D_{ij}$ indicates the Euclidean distance between node $i$ and node $j$. $\Delta$ is the average pairwise distance between nodes. For the GCN experiment with two features constructed simple graphs, we simply average the two modality adjacency matrices to get the fused graph structure for comparison.

| Dataset | ModelNet40 | NTU |
| --- | --- | --- |
| Objects | 12311 | 2012 |
| MVCNN Feature | 4096 | 4096 |
| GVCNN Feature | 2048 | 2048 |
| Training node | 9843 | 1639 |
| Testing node | 2468 | 373 |
| Classes | 40 | 67 |

Table 3: The detailed information of the ModelNet40 and the NTU datasets.

<table><tbody><tr><td rowspan="3">Feature</td><td colspan="6">Features for Structure</td></tr><tr><td colspan="2">GVCNN</td><td colspan="2">MVCNN</td><td colspan="2">GVCNN+MVCNN</td></tr><tr><td>GCN</td><td>HGNN</td><td>GCN</td><td>HGNN</td><td>GCN</td><td>HGNN</td></tr><tr><td>GVCNN <cite>[<a href="#bib.bibx5">\citeauthoryearFeng et al.2018</a>]</cite></td><td><math><semantics><mrow><mn>91.8</mn> <mo>%</mo></mrow> <annotation>91.8\%</annotation></semantics></math></td><td><math><semantics><mrow><mtext>92.6</mtext> <mo>%</mo></mrow> <annotation>\textbf{92.6}\%</annotation></semantics></math></td><td><math><semantics><mrow><mn>91.5</mn> <mo>%</mo></mrow> <annotation>91.5\%</annotation></semantics></math></td><td><math><semantics><mrow><mtext>91.8</mtext> <mo>%</mo></mrow> <annotation>\textbf{91.8}\%</annotation></semantics></math></td><td><math><semantics><mrow><mn>92.8</mn> <mo>%</mo></mrow> <annotation>92.8\%</annotation></semantics></math></td><td><math><semantics><mrow><mtext>96.6</mtext> <mo>%</mo></mrow> <annotation>\textbf{96.6}\%</annotation></semantics></math></td></tr><tr><td>MVCNN <cite>[<a href="#bib.bibx25">\citeauthoryearSu et al.2015</a>]</cite></td><td><math><semantics><mrow><mn>92.5</mn> <mo>%</mo></mrow> <annotation>92.5\%</annotation></semantics></math></td><td><math><semantics><mrow><mtext>92.9</mtext> <mo>%</mo></mrow> <annotation>\textbf{92.9}\%</annotation></semantics></math></td><td><math><semantics><mrow><mn>86.7</mn> <mo>%</mo></mrow> <annotation>86.7\%</annotation></semantics></math></td><td><math><semantics><mrow><mtext>91.0</mtext> <mo>%</mo></mrow> <annotation>\textbf{91.0}\%</annotation></semantics></math></td><td><math><semantics><mrow><mn>92.3</mn> <mo>%</mo></mrow> <annotation>92.3\%</annotation></semantics></math></td><td><math><semantics><mrow><mtext>96.6</mtext> <mo>%</mo></mrow> <annotation>\textbf{96.6}\%</annotation></semantics></math></td></tr><tr><td>GVCNN+MVCNN</td><td>-</td><td>-</td><td>-</td><td>-</td><td><math><semantics><mrow><mn>94.4</mn> <mo>%</mo></mrow> <annotation>94.4\%</annotation></semantics></math></td><td>96.7 <math><semantics><mo>%</mo> <annotation>\%</annotation></semantics></math></td></tr></tbody></table>

Table 4: Comparison between GCN and HGNN on the ModelNet40 dataset.

<table><thead><tr><th rowspan="3">Feature</th><th colspan="6">Features for Structure</th></tr><tr><th colspan="2">GVCNN</th><th colspan="2">MVCNN</th><th colspan="2">GVCNN+MVCNN</th></tr><tr><th>GCN</th><th>HGNN</th><th>GCN</th><th>HGNN</th><th>GCN</th><th>HGNN</th></tr></thead><tbody><tr><th>GVCNN (<cite>[<a href="#bib.bibx5">\citeauthoryearFeng et al.2018</a>]</cite>)</th><td><math><semantics><mrow><mn>78.8</mn> <mo>%</mo></mrow> <annotation>78.8\%</annotation></semantics></math></td><td><math><semantics><mrow><mtext>82.5</mtext> <mo>%</mo></mrow> <annotation>\textbf{82.5}\%</annotation></semantics></math></td><td><math><semantics><mrow><mn>78.8</mn> <mo>%</mo></mrow> <annotation>78.8\%</annotation></semantics></math></td><td><math><semantics><mrow><mtext>79.1</mtext> <mo>%</mo></mrow> <annotation>\textbf{79.1}\%</annotation></semantics></math></td><td><math><semantics><mrow><mn>75.9</mn> <mo>%</mo></mrow> <annotation>75.9\%</annotation></semantics></math></td><td><math><semantics><mrow><mtext>84.2</mtext> <mo>%</mo></mrow> <annotation>\textbf{84.2}\%</annotation></semantics></math></td></tr><tr><th>MVCNN (<cite>[<a href="#bib.bibx25">\citeauthoryearSu et al.2015</a>]</cite>)</th><td><math><semantics><mrow><mn>74.0</mn> <mo>%</mo></mrow> <annotation>74.0\%</annotation></semantics></math></td><td><math><semantics><mrow><mtext>77.2</mtext> <mo>%</mo></mrow> <annotation>\textbf{77.2}\%</annotation></semantics></math></td><td><math><semantics><mrow><mn>71.3</mn> <mo>%</mo></mrow> <annotation>71.3\%</annotation></semantics></math></td><td><math><semantics><mrow><mtext>75.6</mtext> <mo>%</mo></mrow> <annotation>\textbf{75.6}\%</annotation></semantics></math></td><td><math><semantics><mrow><mn>73.2</mn> <mo>%</mo></mrow> <annotation>73.2\%</annotation></semantics></math></td><td><math><semantics><mrow><mtext>83.6</mtext> <mo>%</mo></mrow> <annotation>\textbf{83.6}\%</annotation></semantics></math></td></tr><tr><th>GVCNN+MVCNN</th><td><math><semantics><mo>−</mo> <annotation>-</annotation></semantics></math></td><td><math><semantics><mo>−</mo> <annotation>-</annotation></semantics></math></td><td><math><semantics><mo>−</mo> <annotation>-</annotation></semantics></math></td><td><math><semantics><mo>−</mo> <annotation>-</annotation></semantics></math></td><td><math><semantics><mrow><mn>76.1</mn> <mo>%</mo></mrow> <annotation>76.1\%</annotation></semantics></math></td><td>84.2 <math><semantics><mo>%</mo> <annotation>\%</annotation></semantics></math></td></tr></tbody></table>

Table 5: Comparison between GCN and HGNN on the NTU dataset.

<table><tbody><tr><td rowspan="2">Method</td><td>Classification</td></tr><tr><td>Accuracy</td></tr><tr><td>PointNet <cite>[<a href="#bib.bibx20">\citeauthoryearQi et al.2017a</a>]</cite></td><td>89.2%</td></tr><tr><td>PointNet++ <cite>[<a href="#bib.bibx21">\citeauthoryearQi et al.2017b</a>]</cite></td><td>90.7%</td></tr><tr><td>PointCNN <cite>[<a href="#bib.bibx15">\citeauthoryearLi et al.2018</a>]</cite></td><td>91.8%</td></tr><tr><td>SO-Net <cite>[<a href="#bib.bibx16">\citeauthoryearLi, Chen, and Lee2018</a>]</cite></td><td>93.4%</td></tr><tr><td>HGNN</td><td>96.7%</td></tr></tbody></table>

Table 6: Experimental comparison among recent classification methods on ModelNet40 dataset.

![Refer to caption](https://ar5iv.labs.arxiv.org/html/1809.09401/assets/hyperedge_generation.png)

Figure 5: An example of hyperedge generation in the visual object classification task. Left: For each node we aggregate its N neighbor nodes by Euclidean distance to generate a hyperedge. Right: To generate the multi-modality hypergraph adjacent matrix we concatenate adjacent matrix of two modality.

#### Hypergraph structure construction on visual datasets

In experiments on ModelNet40 and NTU datasets, two hypergraph construction methods are employed. The first one is based on single modality feature and the other one is based on multi-modality feature. In the first case, only one feature is used. Each time one object in the dataset is selected as the centroid, and its 10 nearest neighbors in the selected feature space are used to generate one hyperedge including the centroid itself, as shown in Figure 5. Then, a hypergraph $\mathcal{G}$ with $N$ hyperedges can be constructed. In the second case, multiple features are used to generate a hypergraph $\mathcal{G}$ modeling complex multi-modality correlation. Here, for the $i^{th}$ modality data, a hypergraph adjacent matrix $\bf{H}_{i}$ is constructed accordingly. After all the hypergraphs from different features have been generated, these adjacent matrices $\bf H_{i}$ can be concatenated to build the multi-modality hypergraph adjacent matrix $\bf H$. In this way, the hypergraphs using single modal feature and multi-modal features can be constructed.

##### Results and discussions

Experiments and comparisons on the visual object recognition task are shown in Table 4 and Table 5, respectively. For the ModelNet40 dataset, we have compared the proposed method using two features with recent state-of-the-are methods in Table 6. As shown in the results, we can have the following observations:

1. The proposed HGNN method outperforms the state-of-the-art object recognition methods in the ModelNet40 dataset. More specifically, compared with PointCNN and SO-Net, the proposed HGNN method can achieve gains of 4.8% and 3.2%, respectively. These results demonstrate the superior performance of the proposed HGNN method on visual object recognition.
2. Compared with GCN, the proposed method achieves better performance in all experiments. As shown in Table 4 and Table 5, when only one feature is used for graph/hypergraph structure generation, HGNN can obtain slightly improvement. For example, when GVCNN is used as the object feature and MVCNN is used for graph/hypergraph structure generation, HGNN achieves gains of 0.3% and 2.0% compared with GCN on the ModelNet40 and the NTU datasets, respectively. When more features, i.e., both GVCNN and MVCNN, are used for graph/hypergraph structure generation, HGNN achieves much better performance compared with GCN. For example, HGNN achieves gains of 8.3%, 10.4% and 8.1% compared with GCN when GVCNN, MVCNN and GVCNN+MVCNN are used as the object features on the NTU dataset, respectively.

The better performance can be dedicated to the employed hypergraph structure. The hypergraph structure is able to convey complex and high-order correlations among data, which can better represent the underneath data relationship compared with graph structure or the methods without graph structure. Moreover, when multi-modal data/features are available, HGNN has the advantage of combining such multi-modal information in the same structure by its flexible hyperedges. Compared with traditional hypergraph learning methods, which may suffer from the high computational complexity and storage cost, the proposed HGNN framework is much more efficient through the hyperedge convolution operation.

## Conclusion

In this paper, we propose a framework of hypergraph neural networks (HGNN). In this method, HGNN generalizes the convolution operation to the hypergraph learning process. The convolution on spectral domain is conducted with hypergraph Laplacian and further approximated by truncated chebyshev polynomials. HGNN is a more general framework which is able to handle the complex and high-order correlations through the hypergraph structure for representation learning compared with traditional graph. We have conducted experiments on citation network classification and visual object recognition tasks to evaluate the performance of the proposed HGNN method. Experimental results and comparisons with the state-of-the-art methods demonstrate better performance of the proposed HGNN model. HGNN is able to take complex data correlation into representation learning and thus lead to potential wide applications in many tasks, such as visual recognition, retrieval and data classification.

## Acknowledgements

This work was supported by National Key R&D Program of China (Grant No. 2017YFC0113000, and No.2016YFB1001503), and National Natural Science Funds of China (No.U1705262, No.61772443, No.61572410, No.61671267), National Science and Technology Major Project (No. 2016ZX01038101), MIIT IT funds (Research and application of TCN key technologies) of China, and The National Key Technology R and D Program (No. 2015BAG14B01-02), Post Doctoral Innovative Talent Support Program under Grant BX201600094, China Post-Doctoral Science Foundation under Grant 2017M612134, Scientific Research Project of National Language Committee of China (Grant No. YB135-49), and Nature Science Foundation of Fujian Province, China (No. 2017J01125 and No. 2018J01106).

[^1]: Atwood, J., and Towsley, D. 2016. Diffusion-Convolutional Neural Networks. In NIPS, 1993–2001.

[^2]: Bruna, J.; Zaremba, W.; Szlam, A.; and LeCun, Y. 2014. Spectral Networks and Locally Connected Networks on Graphs. In Proc. ICLR.

[^3]: Chen, D.-Y.; Tian, X.-P.; Shen, Y.-T.; and Ouhyoung, M. 2003. On Visual Similarity Based 3D Model Retrieval. In Computer Graphics Forum, volume 22, 223–232. Wiley Online Library.

[^4]: Defferrard, M.; Bresson, X.; and Vandergheynst, P. 2016. Convolutional Neural Networks on Graphs with Gast Localized Spectral Filtering. In NIPS, 3844–3852.

[^5]: Feng, Y.; Zhang, Z.; Zhao, X.; Ji, R.; and Gao, Y. 2018. Gvcnn: Group-View Convolutional Neural Networks for 3D Shape Recognition. In Proc. CVPR, 264–272.

[^6]: Gao, Y.; Wang, M.; Tao, D.; Ji, R.; and Dai, Q. 2012. 3-D Object Retrieval and Recognition with Hypergraph Analysis. IEEE Transactions on Image Processing 21(9):4290–4303.

[^7]: Gao, Y.; Wang, M.; Zha, Z.-J.; Shen, J.; Li, X.; and Wu, X. 2013. Visual-Textual Joint Relevance Learning for Tag-based Social Image Search. IEEE Transactions on Image Processing 22(1):363–376.

[^8]: Gori, M.; Monfardini, G.; and Scarselli, F. 2005. A New Model for Learning in Graph Domains. In Proc. IJCNN, volume 2, 729–734. IEEE.

[^9]: Henaff, M.; Bruna, J.; and LeCun, Y. 2015. Deep Convolutional Networks on Graph-Structured Data. arXiv preprint arXiv:1506.05163.

[^10]: Huang, Y.; Liu, Q.; Zhang, S.; and Metaxas, D. N. 2010. Image Retrieval via Probabilistic Hypergraph Ranking. In Proc. CVPR, 3376–3383. IEEE.

[^11]: Huang, Y.; Liu, Q.; and Metaxas, D. 2009. \] Video Object Segmentation by Hypergraph Cut. In Proc. CVPR, 1738–1745. IEEE.

[^12]: Hwang, T.; Tian, Z.; Kuangy, R.; and Kocher, J.-P. 2008. Learning on Weighted Hypergraphs to Integrate Protein Interactions and Gene Expressions for Cancer Outcome Prediction. In Proc. ICDM, 293–302. IEEE.

[^13]: Kingma, D. P., and Ba, J. 2014. Adam: A Method for Stochastic Optimization. In Proc. ICLR.

[^14]: Kipf, T. N., and Welling, M. 2017. Semi-Supervised Classification with Graph Convolutional Networks. In Proc. ICLR.

[^15]: Li, Y.; Bu, R.; Sun, M.; and Chen, B. 2018. PointCNN. In NIPS.

[^16]: Li, J.; Chen, B. M.; and Lee, G. H. 2018. SO-Net: Self-Organizing Network for Point Cloud Analysis. In Proc. CVPR, 9397–9406.

[^17]: Lu, Q., and Getoor, L. 2003. Link-based Classification. In Proc. ICML, 496–503.

[^18]: Monti, F.; Boscaini, D.; Masci, J.; Rodola, E.; Svoboda, J.; and Bronstein, M. M. 2017. Geometric Deep Learning on Graphs and Manifolds Using Mixture Model CNNs. In Proc. CVPR, volume 1, 3.

[^19]: Perozzi, B.; Al-Rfou, R.; and Skiena, S. 2014. Deepwalk: Online Learning of Social Representations. In Proc. SIGKDD, 701–710. ACM.

[^20]: Qi, C. R.; Su, H.; Mo, K.; and Guibas, L. J. 2017a. PointNet: Deep Learning on Point Sets for 3D Classification and Segmentation. Proc. CVPR 1(2):4.

[^21]: Qi, C. R.; Yi, L.; Su, H.; and Guibas, L. J. 2017b. PointNet++: Deep Hierarchical Feature Learning on Point Sets in a Metric Space. In NIPS, 5105–5114.

[^22]: Scarselli, F.; Gori, M.; Tsoi, A. C.; Hagenbuchner, M.; and Monfardini, G. 2009. The Graph Neural Network Model. IEEE Transactions on Neural Networks 20(1):61–80.

[^23]: Sen, P.; Namata, G.; Bilgic, M.; Getoor, L.; Galligher, B.; and Eliassi-Rad, T. 2008. Collective Classification in Network Data. AI magazine 29(3):93.

[^24]: Srivastava, N.; Hinton, G.; Krizhevsky, A.; Sutskever, I.; and Salakhutdinov, R. 2014. Dropout: A Simple Way to Prevent Neural Networks from Overfitting. The Journal of Machine Learning Research 15(1):1929–1958.

[^25]: Su, H.; Maji, S.; Kalogerakis, E.; and Learned-Miller, E. 2015. Multi-View Convolutional Neural Networks for 3D Shape Recognition. In Proc. ICCV, 945–953.

[^26]: Velickovic, P.; Cucurull, G.; Casanova, A.; Romero, A.; Lio, P.; and Bengio, Y. 2018. Graph Attention networks. In Proc. ICLR, volume 1.

[^27]: Wu, Z.; Song, S.; Khosla, A.; Yu, F.; Zhang, L.; Tang, X.; and Xiao, J. 2015. 3D ShapeNets: A Deep Representation for Volumetric Shapes. In Proc. CVPR, 1912–1920.

[^28]: Yang, Z.; Cohen, W. W.; and Salakhutdinov, R. 2016. Revisiting Semi-Supervised Learning with Graph Embeddings. Proc. ICML.

[^29]: Zhou, D.; Huang, J.; and Schölkopf, B. 2007. Learning with Hypergraphs: Clustering, Classification, and Embedding. In NIPS, 1601–1608.