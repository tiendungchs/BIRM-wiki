---
title: "Understanding Contrastive Representation Learning throughAlignment and Uniformity on the Hypersphere"
source: "https://ar5iv.labs.arxiv.org/html/2005.10242"
author:
published:
created: 2026-08-31
description: "Contrastive representation learning has been outstandingly successful in practice.In this work, we identify two key properties related to the contrastive loss: (1) alignment (closeness) of features from positive pairs…"
tags:
  - "clippings"
---
## Understanding Contrastive Representation Learning through Alignment and Uniformity on the Hypersphere

Tongzhou Wang Affiliation: MIT Computer Science & Artificial Intelligence Lab (CSAIL) Correspondence to: [tongzhou@mit.edu](mailto:tongzhou@mit.edu)    Phillip Isola Affiliation: MIT Computer Science & Artificial Intelligence Lab (CSAIL)

###### Abstract

Contrastive representation learning has been outstandingly successful in practice. In this work, we identify two key properties related to the contrastive loss: (1) *alignment* (closeness) of features from positive pairs, and (2) *uniformity* of the induced distribution of the (normalized) features on the hypersphere. We prove that, asymptotically, the contrastive loss optimizes these properties, and analyze their positive effects on downstream tasks. Empirically, we introduce an optimizable metric to quantify each property. Extensive experiments on standard vision and language datasets confirm the strong agreement between *both* metrics and downstream task performance. Directly optimizing for these two metrics leads to representations with comparable or better performance at downstream tasks than contrastive learning.

| Project Page: | [ssnl.github.io/hypersphere](https://ssnl.github.io/hypersphere). |
| --- | --- |
| Code: | [github.com/SsnL/align\_uniform](https://github.com/SsnL/align_uniform). |
|  | [github.com/SsnL/moco\_align\_uniform](https://github.com/SsnL/moco_align_uniform). |

###### Keywords:

Machine Learning, ICML

## 1 Introduction

A vast number of recent empirical works learn representations with a unit $\ell_{2}$ norm constraint, effectively restricting the output space to the unit hypersphere [^45] [^48] [^38] [^23] [^58] [^5] [^41] [^29] [^15] [^62], including many unsupervised contrastive representation learning methods [^61] [^2] [^54] [^25] [^8].

Intuitively, having the features live on the unit hypersphere leads to several desirable traits. Fixed-norm vectors are known to improve training stability in modern machine learning where dot products are ubiquitous [^62] [^58]. Moreover, if features of a class are sufficiently well clustered, they are linearly separable with the rest of feature space (see Figure 2), a common criterion used to evaluate representation quality.

![Refer to caption](https://ar5iv.labs.arxiv.org/html/2005.10242/assets/intuition_alignment_from_pptx.png)

Alignment: Similar samples have similar features. (Figure inspired by 54.)

![Refer to caption](https://ar5iv.labs.arxiv.org/html/2005.10242/assets/x2.png)

Figure 2: Hypersphere: When classes are well-clustered (forming spherical caps), they are linearly separable. The same does not hold for Euclidean spaces.

While the unit hypersphere is a popular choice of feature space, not all encoders that map onto it are created equal. Recent works argue that representations should additionally be invariant to unnecessary details, and preserve as much information as possible [^43] [^54] [^28] [^2]. Let us call these two properties *alignment* and *uniformity* (see Figure 1). *Alignment* favors encoders that assign similar features to similar samples. *Uniformity* prefers a feature distribution that preserves maximal information, i.e., the uniform distribution on the unit hypersphere.

In this work, we analyze the *alignment* and *uniformity* properties. We show that a currently popular form of contrastive representation learning in fact directly optimizes for these two properties in the limit of infinite negative samples. We propose theoretically-motivated metrics for alignment and uniformity, and observe strong agreement between them and downstream task performance. Remarkably, directly optimizing for these two metrics leads to comparable or better performance than contrastive learning.

Our main contributions are:

- We propose quantifiable metrics for *alignment* and *uniformity* as two measures of representation quality, with theoretical motivations.
- We prove that the contrastive loss optimizes for alignment and uniformity asymptotically.
- Empirically, we find strong agreement between *both* metrics and downstream task performance.
- Despite being simple in form, our proposed metrics, when directly optimized with no other loss, empirically lead to comparable or better performance at downstream tasks than contrastive learning.

## 2 Related Work

##### Unsupervised Contrastive Representation Learning

has seen remarkable success in learning representations for image and sequential data [^40] [^61] [^43] [^26] [^54] [^28] [^2] [^54] [^25] [^8]. The common motivation behind these work is the InfoMax principle [^37], which we here instantiate as maximizing the mutual information (MI) between two views [^54] [^2] [^60]. However, this interpretation is known to be inconsistent with the actual behavior in practice, e.g., optimizing a tighter bound on MI can lead to worse representations [^56]. What the contrastive loss exactly does remains largely a mystery. Analysis based on the assumption of latent classes provides nice theoretical insights [^47], but unfortunately has a rather large gap with empirical practices: the result that representation quality suffers with a large number of negatives is inconsistent with empirical observations [^61] [^54] [^25] [^8]. In this paper, we analyze and characterize the behavior of contrastive learning from the perspective of alignment and uniformity properties, and empirically verify our claims with standard representation learning tasks.

##### Representation learning on the unit hypersphere.

Outside contrastive learning, many other representation learning approaches also normalize their features to be on the unit hypersphere. In variational autoencoders, the hyperspherical latent space has been shown to perform better than the Euclidean space [^62] [^15]. Directly matching uniformly sampled points on the unit hypersphere is known to provide good representations [^5], agreeing with our intuition that uniformity is a desirable property. [^41] optimizes prototype representations on the unit hypersphere for classification. Hyperspherical face embeddings greatly outperform the unnormalized counterparts [^45] [^38] [^58] [^48]. Its empirical success suggests that the unit hypersphere is indeed a nice feature space. In this work, we formally investigate the interplay between the hypersphere geometry and the popular contrastive representation learning.

##### Distributing points on the unit hypersphere.

The problem of uniformly distributing points on the unit hypersphere is a well-studied one. It is often defined as minimizing the total pairwise potential w.r.t. a certain kernel function [^6] [^36], e.g., the Thomson problem of finding the minimal electrostatic potential energy configuration of electrons [^52], and minimization of the Riesz $s$ -potential [^17] [^22] [^39]. The uniformity metric we propose is based on the Gaussian potential, which can be used to represent a very general class of kernels and is closely related to the universally optimal point configurations [^6] [^14]. Additionally, the best-packing problem on hyperspheres (often called the Tammes problem) is also well studied [^51].

## 3 Preliminaries on Unsupervised Contrastive Representation Learning

The popular unsupervised contrastive representation learning method (often referred to as *contrastive learning* in this paper) learns representations from unlabeled data. It assumes a way to sample *positive pairs*, representing similar samples that should have similar representations. Empirically, the positive pairs are often obtained by taking two independently randomly augmented versions of the same sample, e.g. two crops of the same image [^61] [^28] [^2] [^25] [^8].

Let $p_{\mathsf{data}}(\cdot)$ be the data distribution over $\mathbb{R}^{n}$ and $p_{\mathsf{pos}}(\cdot,\cdot)$ the distribution of positive pairs over $\mathbb{R}^{n}\times\mathbb{R}^{n}$. Based on empirical practices, we assume the following property.

###### Assumption.

Distributions $p_{\mathsf{data}}$ and $p_{\mathsf{pos}}$ should satisfy

- Symmetry: $\forall x,y,~p_{\mathsf{pos}}(x,y)=p_{\mathsf{pos}}(y,x)$.
- Matching marginal: $\forall x,~\int p_{\mathsf{pos}}(x,y)\mathop{}\!\mathrm{d}y=p_{\mathsf{data}}(x)$.

We consider the following specific and widely popular form of contrastive loss for training an encoder $f\colon\mathbb{R}^{n}\rightarrow\mathcal{S}^{m-1}$, mapping data to $\ell_{2}$ normalized feature vectors of dimension $m$. This loss has been shown effective by many recent representation learning methods [^40] [^61] [^54] [^25] [^28] [^2] [^8].

$$
\begin{split}&\mathcal{L}_{\mathsf{contrastive}}(f;\tau,M)\triangleq\\
&\quad\underset{{\begin{subarray}{c}(x,y)\sim p_{\mathsf{pos}}\\
\{x^{-}_{i}\}_{i=1}^{M}\overset{\text{i.i.d.}}{\sim}p_{\mathsf{data}}\end{subarray}}}{\mathbb{E}}\hskip-3.0pt\left[{-\log\frac{e^{f(x)^{\mathsf{T}}f(y)/\tau}}{e^{f(x)^{\mathsf{T}}f(y)/\tau}+\sum_{i}e^{f(x^{-}_{i})^{\mathsf{T}}f(y)/\tau}}}\right],\end{split}
$$

where $\tau>0$ is a scalar temperature hyperparameter, and $M\in\mathbb{Z}_{+}$ is a fixed number of negative samples.

The term *contrastive loss* has also been generally used to refer to various objectives based on positive and negative samples, e.g., in Siamese networks [^12] [^21]. In this work, we focus on the specific form in Equation (1) that is widely used in modern unsupervised contrastive representation learning literature.

##### Necessity of normalization.

Without the norm constraint, the $\mathtt{softmax}$ distribution can be made arbitrarily sharp by simply scaling all the features. [^58] provided an analysis on this effect and argued for the necessity of normalization when using feature vector dot products in a cross entropy loss, as is in Eqn. (1). Experimentally, [^8] also showed that normalizing outputs leads to superior representations.

##### The InfoMax principle.

Many empirical works are motivated by the InfoMax principle of maximizing $I(f(x);f(y))$ for $(x,y)\sim p_{\mathsf{pos}}$ [^54] [^2] [^60]. Usually they interpret $\mathcal{L}_{\mathsf{contrastive}}$ in Eqn. (1) as a lower bound of $I(f(x);f(y))$ [^43] [^28] [^2] [^54]. However, this interpretation is known to have issues in practice, e.g., maximizing a tighter bound often leads to worse downstream task performance [^56]. Therefore, instead of viewing it as a bound, we investigate the exact behavior of directly optimizing $\mathcal{L}_{\mathsf{contrastive}}$ in the following sections.

## 4 Feature Distribution on the Hypersphere

![Refer to caption](https://ar5iv.labs.arxiv.org/html/2005.10242/assets/cifar10_init.png)

(a) Random Initialization. Linear classification validation accuracy: 12.71 % 12.71\\%.

The contrastive loss encourages learned feature representation for positive pairs to be similar, while pushing features from the randomly sampled negative pairs apart. Conventional wisdom says that representations should extract the most shared information between positive pairs and remain invariant to other noise factors [^37] [^54] [^60] [^2]. Therefore, the loss should prefer two following properties:

- *Alignment*: two samples forming a positive pair should be mapped to nearby features, and thus be (mostly) invariant to unneeded noise factors.
- *Uniformity*: feature vectors should be roughly uniformly distributed on the unit hypersphere $\mathcal{S}^{m-1}$, preserving as much information of the data as possible.

To empirically verify this, we visualize CIFAR-10 [^55] [^34] representations on $\mathcal{S}^{1}$ ($m=2$) obtained via three different methods:

- Random initialization.
- Supervised predictive learning: An encoder and a linear classifier are jointly trained from scratch with cross entropy loss on supervised labels.
- Unsupervised contrastive learning: An encoder is trained w.r.t. $\mathcal{L}_{\mathsf{contrastive}}$ with $\tau=0.5$ and $M=256$.

All three encoders share the same AlexNet based architecture [^35], modified to map input images to $2$ -dimensional vectors in $\mathcal{S}^{1}$. Both predictive and contrastive learning use standard data augmentations to augment the dataset and sample positive pairs.

Figure 3 summarizes the resulting distributions of validation set features. Indeed, features from unsupervised contrastive learning (bottom in Figure 3) exhibit the most uniform distribution, and are closely clustered for positive pairs.

The form of the contrastive loss in Eqn. (1) also suggests this. We present informal arguments below, followed by more formal treatment in Section 4.2. From the symmetry of $p$, we can derive

$$
\begin{split}&\mathcal{L}_{\mathsf{contrastive}}(f;\tau,M)=\underset{{(x,y)\sim p_{\mathsf{pos}}}}{\mathbb{E}}\hskip-3.0pt\left[{-f(x)^{\mathsf{T}}f(y)/\tau}\right]\\
&\quad+\hskip-5.0pt\underset{{\begin{subarray}{c}(x,y)\sim p_{\mathsf{pos}}\\
\{x^{-}_{i}\}_{i=1}^{M}\overset{\text{i.i.d.}}{\sim}p_{\mathsf{data}}\end{subarray}}}{\mathbb{E}}\hskip-5.0pt\left[{\log\hskip-2.0pt\left(e^{f(x)^{\mathsf{T}}f(y)/\tau}+\sum_{i}e^{f(x^{-}_{i})^{\mathsf{T}}f(x)/\tau}\right)}\right].\end{split}
$$

Because the $\sum_{i}e^{f(x^{-}_{i})^{\mathsf{T}}f(x)/\tau}$ term is always positive and bounded below, the loss favors smaller $\mathbb{E}\left[{-f(x)^{\mathsf{T}}f(y)/\tau}\right]$, i.e., having more aligned positive pair features. Suppose the encoder is perfectly aligned, i.e., ${\mathbb{P}}\left[{f(x)=f(y)}\right]=1$, then minimizing the loss is equivalent to optimizing

$$
\underset{{\begin{subarray}{c}x\sim p_{\mathsf{data}}\\
\{x^{-}_{i}\}_{i=1}^{M}\overset{\text{i.i.d.}}{\sim}p_{\mathsf{data}}\end{subarray}}}{\mathbb{E}}\hskip-3.0pt\left[{\log\left(e^{1/\tau}+\sum_{i}e^{f(x^{-}_{i})^{\mathsf{T}}f(x)/\tau}\right)}\right],
$$

which is akin to maximizing pairwise distances with a $\mathtt{LogSumExp}$ transformation. Intuitively, pushing all features away from each other should indeed cause them to be roughly uniformly distributed.

### 4.1 Quantifying Alignment and Uniformity

For further analysis, we need a way to measure alignment and uniformity. We propose the following two metrics (losses).

![Refer to caption](https://ar5iv.labs.arxiv.org/html/2005.10242/assets/gaussian_vis.png)

Figure 4: Average pairwise G 2 G\_{2} potential as a measure of uniformity. Each plot shows 10000 points distributed on 𝒮 1 \\mathcal{S}^{1}, obtained via either applying an encoder on CIFAR-10 validation set (same as those in Figure 3 ) or sampling from a distribution on, as described in plot titles. We show the points with Gaussian KDE and the angles with vMF KDE.

#### 4.1.1 Alignment

The alignment loss is straightforwardly defined with the expected distance between positive pairs:

$$
\mathcal{L}_{\mathsf{align}}(f;\alpha)\triangleq\underset{{(x,y)\sim p_{\mathsf{pos}}}}{\mathbb{E}}\hskip-3.0pt\left[{\left\lVert f(x)-f(y)\right\rVert_{2}^{\alpha}}\right],\quad\alpha>0.
$$

#### 4.1.2 Uniformity

We want the uniformity metric to be both asymptotically correct (i.e., the distribution optimizing this metric should converge to uniform distribution) and empirically reasonable with finite number of points. To this end, we consider the Gaussian potential kernel (also known as the Radial Basis Function (RBF) kernel) $G_{t}\colon\mathcal{S}^{d}\times\mathcal{S}^{d}\rightarrow\mathbb{R}_{+}$ [^14] [^6]:

$$
G_{t}(u,v)\triangleq e^{-t\left\lVert u-v\right\rVert_{2}^{2}}=e^{2t\cdot u^{\mathsf{T}}v-2t},\quad t>0,
$$

and define the uniformity loss as the logarithm of the average pairwise Gaussian potential:

$$
\displaystyle\mathcal{L}_{\mathsf{uniform}}(f;t)
$$
 
$$
\displaystyle\triangleq\log\underset{{\hskip 2.0ptx,y\overset{\text{i.i.d.}}{\sim}p_{\mathsf{data}}}}{\mathbb{E}}\hskip-3.0pt\left[{G_{t}(u,v)}\right]
$$
 
$$
\displaystyle=\log\underset{{\hskip 2.0ptx,y\overset{\text{i.i.d.}}{\sim}p_{\mathsf{data}}}}{\mathbb{E}}\hskip-3.0pt\left[{e^{-t\left\lVert f(x)-f(y)\right\rVert_{2}^{2}}}\right],\quad t>0.
$$

The average pairwise Gaussian potential is nicely tied with the uniform distribution on the unit hypersphere.

###### Definition (Uniform distribution on 𝒮d\\mathcal{S}^{d}).

$\sigma_{d}$ denotes the normalized surface area measure on $\mathcal{S}^{d}$.

First, we show that the uniform distribution is the unique distribution that minimize the expected pairwise potential.

###### Proposition 1.

For $\mathcal{M}(\mathcal{S}^{d})$ the set of Borel probability measures on $\mathcal{S}^{d}$, $\sigma_{d}$ is the unique solution of

$$
\min_{\mu\in\mathcal{M}(\mathcal{S}^{d})}\int_{u}\int_{v}G_{t}(u,v)\mathop{}\!\mathrm{d}\mu\mathop{}\!\mathrm{d}\mu.
$$

###### Proof.

See appendix. ∎

In addition, as number of points goes to infinity, distributions of points minimizing the average pairwise potential converge weak <sup>∗</sup> to the uniform distribution. Recall the definition of the weak <sup>∗</sup> convergence of measures.

###### Definition (Weak∗ convergence of measures).

A sequence of Borel measures $\{\mu_{n}\}_{n=1}^{\infty}$ in $\mathbb{R}^{p}$ converges weak <sup>∗</sup> to a Borel measure $\mu$ if for all continuous function $f\colon\mathbb{R}^{p}\rightarrow\mathbb{R}$, we have

$$
\lim_{n\rightarrow\infty}\int f(x)\mathop{}\!\mathrm{d}\mu_{n}(x)=\int f(x)\mathop{}\!\mathrm{d}\mu(x).
$$

###### Proposition 2.

For each $N>0$, the $N$ point minimizer of the average pairwise potential is

$$
\mathbf{u}^{*}_{N}=\argmin_{u_{1},u_{2},\dots,u_{N}\in\mathcal{S}^{d}}\sum_{1\leq i<j\leq N}G_{t}(u_{i},u_{j}).
$$

The normalized counting measures associated with the $\{\mathbf{u}^{*}_{N}\}_{N=1}^{\infty}$ sequence converge weak <sup>∗</sup> to $\sigma_{d}$.

###### Proof.

See appendix. ∎

Designing an objective minimized by the uniform distribution is in fact nontrivial. For instance, average pairwise dot products or Euclidean distances is simply optimized by any distribution that has zero mean. Among kernels that achieve uniformity at optima, the Gaussian kernel is special in that it is closely related to the universally optimal point configurations and can also be used to represent a general class of other kernels, including the Riesz $s$ -potentials. We refer readers to [^6] and [^14] for in-depth discussions on these topics. Moreover, as we show below, $\mathcal{L}_{\mathsf{uniform}}$, defined with the Gaussian kernel, has close connections with $\mathcal{L}_{\mathsf{contrastive}}$.

Empirically, we evaluate the average pairwise potential of various finite point collections on $\mathcal{S}^{1}$ in Figure 4. The values nicely align with our intuitive understanding of uniformity.

We further discuss properties of $\mathcal{L}_{\mathsf{uniform}}$ and characterize its optimal value and range in the appendix.

### 4.2 Limiting Behavior of Contrastive Learning

In this section, we formalize the intuition that contrastive learning optimizes alignment and uniformity, and characterize its asymptotic behavior. We consider optimization problems over all measurable encoder functions from the $p_{\mathsf{data}}$ measure in $\mathbb{R}^{n}$ to the Borel space $\mathcal{S}^{m-1}$.

We first define the notion of optimal encoders for each of these two metrics.

###### Definition (Perfect Alignment).

We say an encoder $f$ is *perfectly aligned* if $f(x)=f(y)$ a.s. over $(x,y)\sim p_{\mathsf{pos}}$.

###### Definition (Perfect Uniformity).

We say an encoder $f$ is *perfectly uniform* if the distribution of $f(x)$ for $x\sim p_{\mathsf{data}}$ is the uniform distribution $\sigma_{m-1}$ on $\mathcal{S}^{m-1}$.

##### Realizability of perfect uniformity.

We note that it is not always possible to achieve perfect uniformity, e.g., when the data manifold in $\mathbb{R}^{n}$ is lower dimensional than the feature space $\mathcal{S}^{m-1}$. Moreover, in the case that $p_{\mathsf{data}}$ and $p_{\mathsf{pos}}$ are formed from sampling augmented samples from a finite dataset, there cannot be an encoder that is *both* perfectly aligned and perfectly uniform, because perfect alignment implies that all augmentations from a single element have the same feature vector. Nonetheless, perfectly uniform encoder functions do exist under the conditions that $n\geq m-1$ and $p_{\mathsf{data}}$ has bounded density.

We analyze the asymptotics with infinite negative samples. Existing empirical work has established that larger number of negative samples consistently leads to better downstream task performances [^61] [^54] [^25] [^8], and often uses very large values (e.g., $M=65536$ in [^25]). The following theorem nicely confirms that optimizing w.r.t. the limiting loss indeed requires both alignment and uniformity.

###### Theorem 1 (Asymptotics of ℒ𝖼𝗈𝗇𝗍𝗋𝖺𝗌𝗍𝗂𝗏𝖾\\mathcal{L}\_{\\mathsf{contrastive}}).

For fixed $\tau>0$, as the number of negative samples $M\rightarrow\infty$, the (normalized) contrastive loss converges to

$$
\begin{split}&\lim_{M\rightarrow\infty}\mathcal{L}_{\mathsf{contrastive}}(f;\tau,M)-\log M=\\
&\qquad-\frac{1}{\tau}\underset{{(x,y)\sim p_{\mathsf{pos}}}}{\mathbb{E}}\hskip-3.0pt\left[{f(x)^{\mathsf{T}}f(y)}\right]\\
&\qquad+\underset{{x\sim p_{\mathsf{data}}}}{\mathbb{E}}\hskip-3.0pt\left[{\log\underset{{x^{-}\sim p_{\mathsf{data}}}}{\mathbb{E}}\hskip-3.0pt\left[{e^{f(x^{-})^{\mathsf{T}}f(x)/\tau}}\right]}\right].\end{split}
$$

We have the following results:

1. The first term is minimized iff $f$ is perfectly aligned.
2. If perfectly uniform encoders exist, they form the exact minimizers of the second term.
3. For the convergence in Equation (2), the absolute deviation from the limit decays in $\mathcal{O}(M^{-1/2})$.

###### Proof.

See appendix. ∎

##### Relation with ℒ𝗎𝗇𝗂𝖿𝗈𝗋𝗆\\mathcal{L}\_{\\mathsf{uniform}}.

The proof of Theorem 1 in the appendix connects the asymptotic $\mathcal{L}_{\mathsf{contrastive}}$ form with minimizing average pairwise Gaussian potential, i.e., minimizing $\mathcal{L}_{\mathsf{uniform}}$. Compared with the second term of Equation (2), $\mathcal{L}_{\mathsf{uniform}}$ essentially pushes the $\log$ outside the outer expectation, without changing the minimizer (perfectly uniform encoders). However, due to its pairwise nature, $\mathcal{L}_{\mathsf{uniform}}$ is much simpler in form and avoids the computationally expensive $\mathtt{softmax}$ operation in $\mathcal{L}_{\mathsf{contrastive}}$ [^16] [^3] [^20] [^19] [^7].

##### Relation with feature distribution entropy estimation.

When $p_{\mathsf{data}}$ is uniform over finite samples $\{x_{1},x_{2},\dots,x_{N}\}$ (e.g., a collected dataset), the second term in Equation (2) can be alternatively viewed as a resubstitution entropy estimator of $f(x)$ [^1], where $x$ follows the underlying distribution $p_{\mathsf{nature}}$ that generates $\{x_{i}\}_{i=1}^{N}$, via a von Mises-Fisher (vMF) kernel density estimation (KDE):

$$
\displaystyle\underset{{x\sim p_{\mathsf{data}}}}{\mathbb{E}}\hskip-3.0pt\left[{\log\underset{{x^{-}\sim p_{\mathsf{data}}}}{\mathbb{E}}\hskip-3.0pt\left[{e^{f(x^{-})^{\mathsf{T}}f(x)/\tau}}\right]}\right]
$$
 
$$
\displaystyle\qquad=\frac{1}{N}\sum_{i=1}^{N}\log\left(\frac{1}{N}\sum_{j=1}^{N}e^{f(x_{i})^{\mathsf{T}}f(x_{j})/\tau}\right)
$$
 
$$
\displaystyle\qquad=\frac{1}{N}\sum_{i=1}^{N}\log\hat{p}_{\mathsf{vMF\text{-}KDE}}(f(x_{i}))+\log Z_{\mathsf{vMF}}
$$
 
$$
\displaystyle\qquad\triangleq-\hat{H}(f(x))+\log Z_{\mathsf{vMF}},\qquad\qquad\quad x\sim p_{\mathsf{nature}}
$$
 
$$
\displaystyle\qquad\triangleq-\hat{I}(x;f(x))+\log Z_{\mathsf{vMF}},\qquad\quad\hskip 14.0ptx\sim p_{\mathsf{nature}},
$$

where

- $\hat{p}_{\mathsf{vMF\text{-}KDE}}$ is the KDE based on samples $\{f(x_{j})\}_{j=1}^{N}$ using a vMF kernel with $\kappa=\tau^{-1}$,
- $Z_{\mathsf{vMF}}$ is the normalization constant for vMF distribution with $\kappa=\tau^{-1}$,
- $\hat{H}$ denotes the resubstitution entropy estimator,
- $\hat{I}$ denotes the mutual information estimator based on $\hat{H}$, since $f$ is a deterministic function.

##### Relation with the InfoMax principle.

Many empirical works are motivated by the InfoMax principle, i.e., maximizing $I(f(x);f(y))$ for $(x,y)\sim p_{\mathsf{pos}}$. However, the interpretation of $\mathcal{L}_{\mathsf{contrastive}}$ as a lower bound of $I(f(x);f(y))$ is known to be inconsistent with its actual behavior in practice [^56]. Our results instead analyze the properties of $\mathcal{L}_{\mathsf{contrastive}}$ itself. Considering the identity $I(f(x);f(y))=H(f(x))-H(f(x)\mathrel{|}f(y))$, we can see that while uniformity indeed favors large $H(f(x))$, alignment is stronger than merely desiring small $H(f(x)\mathrel{|}f(y))$. In particular, both Theorem 1 and the above connection with maximizing an entropy estimator provide alternative interpretations and motivations that $\mathcal{L}_{\mathsf{contrastive}}$ optimizes for *aligned* and *information-preserving* encoders.

Finally, even for the case where only a single negative sample is used (i.e., $M=1$), we can still prove a weaker result, which we describe in details in the appendix.

![Refer to caption](https://ar5iv.labs.arxiv.org/html/2005.10242/assets/stl10_scatter_linear_output.png)

(a) 304 STL-10 encoders are evaluated with linear classification on output features and 5 -nearest neighbor ( -NN) on fc7 activations. Higher accuracy (blue color) is better.

⬇

\# bsz: batch size (number of positive pairs)

\# d: latent dim

\# x: Tensor, shape=\[bsz, d\]

\# latents for one side of positive pairs

\# y: Tensor, shape=\[bsz, d\]

\# latents for the other side of positive pairs

\# lam: hyperparameter balancing the two losses

def lalign(x, y, alpha=2):

return (x - y).norm(dim=1).pow(alpha).mean()

def lunif(x, t=2):

sq\_pdist = torch.pdist(x, p=2).pow(2)

return sq\_pdist.mul(-t).exp().mean().log()

loss = lalign(x, y) + lam \* (lunif(x) + lunif(y)) / 2

Figure 6: PyTorch implementation of $\mathcal{L}_{\mathsf{align}}$ and $\mathcal{L}_{\mathsf{uniform}}$.

## 5 Experiments

In this section, we empirically verify the hypothesis that alignment and uniformity are desired properties for representations. Recall that our two metrics are

$$
\displaystyle\mathcal{L}_{\mathsf{align}}(f;\alpha)
$$
 
$$
\displaystyle\triangleq\mathbb{E}_{(x,y)\sim p_{\mathsf{pos}}}\left[{\left\lVert f(x)-f(y)\right\rVert_{2}^{\alpha}}\right]
$$
 
$$
\displaystyle\mathcal{L}_{\mathsf{uniform}}(f;t)
$$
 
$$
\displaystyle\triangleq\log~\mathbb{E}_{x,y\overset{\text{i.i.d.}}{\sim}p_{\mathsf{data}}}\left[{e^{-t\left\lVert f(x)-f(y)\right\rVert_{2}^{2}}}\right].
$$

We conduct extensive experiments with convolutional neural network (CNN) and recurrent neural network (RNN) based encoders on four popular representation learning benchmarks with distinct types of downstream tasks:

- STL-10 [^13] classification on AlexNet-based encoder outputs or intermediate activations with a linear or $k$ -nearest neighbor ($k$ -NN) classifier.
- NYU-Depth-V2 [^42] depth prediction on CNN encoder intermediate activations after convolution layers.
- ImageNet and ImageNet-100 (random $100$ -class subset of ImageNet) classification on CNN encoder penultimate layer activations with a linear classifier.
- BookCorpus [^63] RNN sentence encoder outputs used for Moview Review Sentence Polarity (MR) [^44] and Customer Product Review Sentiment (CR) [^59] binary classification tasks with logisitc classifiers.

For image datasets, we follow the standard practice and choose positive pairs as two independent augmentations of the same image. For BookCorpus, positive pairs are chosen as neighboring sentences, following Quick-Thought Vectors [^40].

We perform majority of our analysis on STL-10 and NYU-Depth-V2 encoders, where we calculate $\mathcal{L}_{\mathsf{contrastive}}$ with negatives being other samples within the minibatch following the standard practice [^28] [^2] [^54] [^8], and $\mathcal{L}_{\mathsf{uniform}}$ as the logarithm of average pairwise feature potentials also within the minibatch. Due to their simple forms, these two losses can be implemented in PyTorch [^46] with less than $10$ lines of code, as shown in Figure 6.

To investigate *alignment* and *uniformity* properties on recent contrastive learning methods and larger datasets, we also analyze ImageNet and ImageNet-100 encoders trained with Momentum Contrast (MoCo) [^25] [^9], and BookCorpus encoders trained with Quick-Thought Vectors [^40], with these methods modified to also allow $\mathcal{L}_{\mathsf{align}}$ and $\mathcal{L}_{\mathsf{uniform}}$.

<table><thead><tr><th></th><th rowspan="2">Loss Formula</th><th colspan="4">Validation Set Accuracy <math><semantics><mo>↑</mo> <annotation>\uparrow</annotation></semantics></math></th></tr><tr><th></th><th>Output + Linear</th><th>Output + <math><semantics><mn>5</mn> <annotation>5</annotation></semantics></math> -NN</th><th>fc7 + Linear</th><th>fc7 + <math><semantics><mn>5</mn> <annotation>5</annotation></semantics></math> -NN</th></tr></thead><tbody><tr><th>Best <math><semantics><msub><mi>ℒ</mi> <mi>𝖼𝗈𝗇𝗍𝗋𝖺𝗌𝗍𝗂𝗏𝖾</mi></msub> <annotation>\mathcal{L}_{\mathsf{contrastive}}</annotation></semantics></math> only</th><th><math><semantics><mrow><msub><mi>ℒ</mi> <mi>𝖼𝗈𝗇𝗍𝗋𝖺𝗌𝗍𝗂𝗏𝖾</mi></msub> <mo></mo><mrow><mo>(</mo><mrow><mi>τ</mi> <mo>=</mo> <mn>0.19</mn></mrow><mo>)</mo></mrow></mrow> <annotation>\mathcal{L}_{\mathsf{contrastive}}(\tau\mkern 1.5mu{=}\mkern 1.5mu0.19)</annotation></semantics></math></th><td>80.46%</td><td>78.75%</td><td>83.89%</td><td>76.33%</td></tr><tr><th>Best <math><semantics><msub><mi>ℒ</mi> <mi>𝖺𝗅𝗂𝗀𝗇</mi></msub> <annotation>\mathcal{L}_{\mathsf{align}}</annotation></semantics></math> and <math><semantics><msub><mi>ℒ</mi> <mi>𝗎𝗇𝗂𝖿𝗈𝗋𝗆</mi></msub> <annotation>\mathcal{L}_{\mathsf{uniform}}</annotation></semantics></math> only</th><th><math><semantics><mrow><mrow><mrow><mn>0.98</mn> <mo>⋅</mo> <msub><mi>ℒ</mi> <mi>𝖺𝗅𝗂𝗀𝗇</mi></msub></mrow> <mo></mo><mrow><mo>(</mo><mrow><mi>α</mi> <mo>=</mo> <mn>2</mn></mrow><mo>)</mo></mrow></mrow> <mo>+</mo> <mrow><mrow><mn>0.96</mn> <mo>⋅</mo> <msub><mi>ℒ</mi> <mi>𝗎𝗇𝗂𝖿𝗈𝗋𝗆</mi></msub></mrow> <mo></mo><mrow><mo>(</mo><mrow><mi>t</mi> <mo>=</mo> <mn>2</mn></mrow><mo>)</mo></mrow></mrow></mrow> <annotation>0.98\cdot\mathcal{L}_{\mathsf{align}}(\alpha\mkern 1.5mu{=}\mkern 1.5mu2)+0.96\cdot\mathcal{L}_{\mathsf{uniform}}(t\mkern 1.5mu{=}\mkern 1.5mu2)</annotation></semantics></math></th><td>81.15%</td><td>78.89%</td><td>84.43%</td><td>76.78%</td></tr><tr><th>Best among all encoders</th><th><math><semantics><mrow><mrow><msub><mi>ℒ</mi> <mi>𝖼𝗈𝗇𝗍𝗋𝖺𝗌𝗍𝗂𝗏𝖾</mi></msub> <mo></mo><mrow><mo>(</mo><mrow><mi>τ</mi> <mo>=</mo> <mn>0.5</mn></mrow><mo>)</mo></mrow></mrow> <mo>+</mo> <mrow><msub><mi>ℒ</mi> <mi>𝗎𝗇𝗂𝖿𝗈𝗋𝗆</mi></msub> <mo></mo><mrow><mo>(</mo><mrow><mi>t</mi> <mo>=</mo> <mn>2</mn></mrow><mo>)</mo></mrow></mrow></mrow> <annotation>\mathcal{L}_{\mathsf{contrastive}}(\tau\mkern 1.5mu{=}\mkern 1.5mu0.5)+\mathcal{L}_{\mathsf{uniform}}(t\mkern 1.5mu{=}\mkern 1.5mu2)</annotation></semantics></math></th><td>81.06%</td><td>79.05%</td><td>84.14%</td><td>76.48%</td></tr></tbody></table>

Table 1: STL-10 encoder evaluations. Numbers show linear and $5$ -nearest neighbor ($5$ -NN) classification accuracies on the validation set. The best result is picked by encoder outputs linear classifier accuracy from a $5$ -fold training set cross validation, among all $150$ encoders trained from scratch with $128$ -dimensional output and $768$ batch size.

<table><thead><tr><th></th><th rowspan="2">Loss Formula</th><th colspan="2">Validation Set MSE <math><semantics><mo>↓</mo> <annotation>\downarrow</annotation></semantics></math></th></tr><tr><th></th><th>  conv5</th><th>  conv4</th></tr></thead><tbody><tr><th>Best <math><semantics><msub><mi>ℒ</mi> <mi>𝖼𝗈𝗇𝗍𝗋𝖺𝗌𝗍𝗂𝗏𝖾</mi></msub> <annotation>\mathcal{L}_{\mathsf{contrastive}}</annotation></semantics></math> only</th><th><math><semantics><mrow><mrow><mn>0.5</mn> <mo>⋅</mo> <msub><mi>ℒ</mi> <mi>𝖼𝗈𝗇𝗍𝗋𝖺𝗌𝗍𝗂𝗏𝖾</mi></msub></mrow> <mo></mo><mrow><mo>(</mo><mrow><mi>τ</mi> <mo>=</mo> <mn>0.1</mn></mrow><mo>)</mo></mrow></mrow> <annotation>0.5\cdot\mathcal{L}_{\mathsf{contrastive}}(\tau\mkern 1.5mu{=}\mkern 1.5mu0.1)</annotation></semantics></math></th><td>0.7024</td><td>0.7575</td></tr><tr><th>Best <math><semantics><msub><mi>ℒ</mi> <mi>𝖺𝗅𝗂𝗀𝗇</mi></msub> <annotation>\mathcal{L}_{\mathsf{align}}</annotation></semantics></math> and <math><semantics><msub><mi>ℒ</mi> <mi>𝗎𝗇𝗂𝖿𝗈𝗋𝗆</mi></msub> <annotation>\mathcal{L}_{\mathsf{uniform}}</annotation></semantics></math> only</th><th><math><semantics><mrow><mrow><mrow><mn>0.75</mn> <mo>⋅</mo> <msub><mi>ℒ</mi> <mi>𝖺𝗅𝗂𝗀𝗇</mi></msub></mrow> <mo></mo><mrow><mo>(</mo><mrow><mi>α</mi> <mo>=</mo> <mn>2</mn></mrow><mo>)</mo></mrow></mrow> <mo>+</mo> <mrow><mrow><mn>0.5</mn> <mo>⋅</mo> <msub><mi>ℒ</mi> <mi>𝗎𝗇𝗂𝖿𝗈𝗋𝗆</mi></msub></mrow> <mo></mo><mrow><mo>(</mo><mrow><mi>t</mi> <mo>=</mo> <mn>2</mn></mrow><mo>)</mo></mrow></mrow></mrow> <annotation>0.75\cdot\mathcal{L}_{\mathsf{align}}(\alpha\mkern 1.5mu{=}\mkern 1.5mu2)+0.5\cdot\mathcal{L}_{\mathsf{uniform}}(t\mkern 1.5mu{=}\mkern 1.5mu2)</annotation></semantics></math></th><td>0.7014</td><td>0.7592</td></tr><tr><th>Best among all encoders</th><th><math><semantics><mrow><mrow><mrow><mn>0.75</mn> <mo>⋅</mo> <msub><mi>ℒ</mi> <mi>𝖺𝗅𝗂𝗀𝗇</mi></msub></mrow> <mo></mo><mrow><mo>(</mo><mrow><mi>α</mi> <mo>=</mo> <mn>2</mn></mrow><mo>)</mo></mrow></mrow> <mo>+</mo> <mrow><mrow><mn>0.5</mn> <mo>⋅</mo> <msub><mi>ℒ</mi> <mi>𝗎𝗇𝗂𝖿𝗈𝗋𝗆</mi></msub></mrow> <mo></mo><mrow><mo>(</mo><mrow><mi>t</mi> <mo>=</mo> <mn>2</mn></mrow><mo>)</mo></mrow></mrow></mrow> <annotation>0.75\cdot\mathcal{L}_{\mathsf{align}}(\alpha\mkern 1.5mu{=}\mkern 1.5mu2)+0.5\cdot\mathcal{L}_{\mathsf{uniform}}(t\mkern 1.5mu{=}\mkern 1.5mu2)</annotation></semantics></math></th><td>0.7014</td><td>0.7592</td></tr></tbody></table>

Table 2: NYU-Depth-V2 encoder evaluations. Numbers show depth prediction mean squared error (MSE) on the validation set. The best result is picked based on conv5 layer MSE from a $5$ -fold training set cross validation, among all $64$ encoders trained from scratch with $128$ -dimensional output and $128$ batch size.

Figure 7: Effect of optimizing different weighted combinations of $\mathcal{L}_{\mathsf{align}}(\alpha\mkern 1.5mu{=}\mkern 1.5mu2)$ and $\mathcal{L}_{\mathsf{uniform}}(t\mkern 1.5mu{=}\mkern 1.5mu2)$ for STL-10. For each encoder, we show the $\mathcal{L}_{\mathsf{align}}$ and $\mathcal{L}_{\mathsf{uniform}}$ metrics, and validation accuracy of a linear classifier trained on encoder outputs. $\mathcal{L}_{\mathsf{uniform}}$ is exponentiated for plotting purposes.

We optimize a total of $304$ STL-10 encoders, $64$ NYU-Depth-V2 encoders, $45$ ImageNet-100 encoders, and $108$ BookCorpus encoders without supervision. The encoders are optimized w.r.t. weighted combinations of $\mathcal{L}_{\mathsf{contrastive}}$, $\mathcal{L}_{\mathsf{align}}$, and/or $\mathcal{L}_{\mathsf{uniform}}$, with varying

- (possibly zero) weights on the three losses,
- temperature $\tau$ for $\mathcal{L}_{\mathsf{contrastive}}$,
- $\alpha\in\{1,2\}$ for $\mathcal{L}_{\mathsf{align}}$,
- $t\in\{1,2,\dots,8\}$ for $\mathcal{L}_{\mathsf{uniform}}$,
- batch size (affecting the number of (negative) pairs for $\mathcal{L}_{\mathsf{contrastive}}$ and $\mathcal{L}_{\mathsf{uniform}}$),
- embedding dimension,
- number of training epochs and learning rate,
- initialization (from scratch vs. a pretrained encoder).

See the appendix for more experiment details and the exact configurations used.

##### ℒ𝖺𝗅𝗂𝗀𝗇\\mathcal{L}\_{\\mathsf{align}} and ℒ𝗎𝗇𝗂𝖿𝗈𝗋𝗆\\mathcal{L}\_{\\mathsf{uniform}} strongly agree with downstream task performance.

For each encoder, we measure the downstream task performance, and the $\mathcal{L}_{\mathsf{align}}$, $\mathcal{L}_{\mathsf{uniform}}$ metrics on the validation set. Figure 5 visualizes the trends between both metrics and representation quality. We observe that the two metrics strongly agrees the representation quality overall. In particular, the best performing encoders are exactly the ones with low $\mathcal{L}_{\mathsf{align}}$ and $\mathcal{L}_{\mathsf{uniform}}$, i.e., the lower left corners in Figure 5.

##### Directly optimizing only ℒ𝖺𝗅𝗂𝗀𝗇\\mathcal{L}\_{\\mathsf{align}} and ℒ𝗎𝗇𝗂𝖿𝗈𝗋𝗆\\mathcal{L}\_{\\mathsf{uniform}} can lead to better representations.

As shown in Tables 1 and 2, encoders trained with only $\mathcal{L}_{\mathsf{align}}$ and $\mathcal{L}_{\mathsf{uniform}}$ consistently outperform their $\mathcal{L}_{\mathsf{contrastive}}$ -trained counterparts, for both tasks. Theoretically, Theorem 1 showed that $\mathcal{L}_{\mathsf{contrastive}}$ optimizes alignment and uniformity asymptotically with infinite negative samples. This empirical performance gap suggests that directly optimizing these properties can be superior in practice, when we can only have finite negatives.

Figure 8: Finetuning trajectories from a STL-10 encoder trained with $\mathcal{L}_{\mathsf{contrastive}}$ using a suboptimal temperature $\tau=2.5$. Finetuning objectives are weighted combinations of $\mathcal{L}_{\mathsf{align}}(\alpha\mkern 1.5mu{=}\mkern 1.5mu2)$ and $\mathcal{L}_{\mathsf{uniform}}(t\mkern 1.5mu{=}\mkern 1.5mu2)$. For each intermediate checkpoint, we measure $\mathcal{L}_{\mathsf{align}}$ and $\mathcal{L}_{\mathsf{uniform}}$ metrics, as well as validation accuracy of a linear classifier trained from scratch on the encoder outputs. $\mathcal{L}_{\mathsf{uniform}}$ is exponentiated for plotting purpose. Left and middle: Performance degrades if only one of alignment and uniformity is optimized. Right: Performance improves when both are optimized.

![Refer to caption](https://ar5iv.labs.arxiv.org/html/2005.10242/assets/imagenet100_moco_scatter_linear_fc7.png)

(a) 45 ImageNet-100 encoders are trained with MoCo-based methods, and evaluated with linear classification.

##### Both alignment and uniformity are necessary for a good representation.

Figure 7 shows how the final encoder changes in response to optimizing differently weighted combinations of $\mathcal{L}_{\mathsf{align}}$ and $\mathcal{L}_{\mathsf{uniform}}$ on STL-10. The trade-off between the $\mathcal{L}_{\mathsf{align}}$ and $\mathcal{L}_{\mathsf{uniform}}$ indicates that perfect alignment and perfect uniformity are likely hard to simultaneously achieve in practice. However, the inverted-U-shaped accuracy curve confirms that both properties are indeed necessary for a good encoder. When $\mathcal{L}_{\mathsf{align}}$ is weighted much higher than $\mathcal{L}_{\mathsf{uniform}}$, degenerate solution occurs and all inputs are mapped to the same feature vector ($\exp\mathcal{L}_{\mathsf{uniform}}=1)$. However, as long as the ratio between two weights is not too large (e.g., $<4$), we observe that the representation quality remains relatively good and insensitive to the exact weight choices.

##### ℒ𝖺𝗅𝗂𝗀𝗇\\mathcal{L}\_{\\mathsf{align}} and ℒ𝗎𝗇𝗂𝖿𝗈𝗋𝗆\\mathcal{L}\_{\\mathsf{uniform}} causally affect downstream task performance.

We take an encoder trained with $\mathcal{L}_{\mathsf{contrastive}}$ using a suboptimal temperature $\tau=2.5$, and finetune it according to $\mathcal{L}_{\mathsf{align}}$ and/or $\mathcal{L}_{\mathsf{uniform}}$. Figure 8 visualizes the finetuning trajectories. When only one of alignment and uniformity is optimized, the corresponding metric improves, but both the other metric and performance degrade. However, when both properties are optimized, the representation quality steadily increases. These trends confirm the causal effect of alignment and uniformity on the representation quality, and suggest that directly optimizing them can be a reasonable choice.

##### Alignment and uniformity also matter in other contrastive representation learning variants.

MoCo [^25] and Quick-Thought Vectors [^40] are contrastive representation learning variants that have nontrivial differences with directly optimizing $\mathcal{L}_{\mathsf{contrastive}}$ in Equation (1). MoCo introduces a memory queue and a momentum encoder. Quick-Thought Vectors uses two different encoders to encode each sentence in a positive pair, only normalizes encoder outputs during evaluation, and does not use random sampling to obtain minibatches. After modifying them to also allow $\mathcal{L}_{\mathsf{align}}$ and $\mathcal{L}_{\mathsf{uniform}}$, we train these methods on ImageNet-100 and BookCorpus, respectively. Figure 9 shows that $\mathcal{L}_{\mathsf{align}}$ and $\mathcal{L}_{\mathsf{uniform}}$ metrics are still correlated with the downstream task performances. Tables 3 and 4 show that directly optimizing them also leads to comparable or better representation quality. Table 5 also shows improvements on full ImageNet when we use $\mathcal{L}_{\mathsf{align}}$ and $\mathcal{L}_{\mathsf{uniform}}$ to train MoCo v2 [^9] (an improved version of MoCo). These results suggest that alignment and uniformity are indeed desirable properties for representations, for *both* image and text modalities, and are likely connected with general contrastive representation learning methods.

<table><thead><tr><th></th><th rowspan="2">Loss Formula</th><th colspan="2">Validation Set Accuracy <math><semantics><mo>↑</mo> <annotation>\uparrow</annotation></semantics></math></th></tr><tr><th></th><th>  top1</th><th>  top5</th></tr></thead><tbody><tr><th>Best <math><semantics><msub><mi>ℒ</mi> <mi>𝖼𝗈𝗇𝗍𝗋𝖺𝗌𝗍𝗂𝗏𝖾</mi></msub> <annotation>\mathcal{L}_{\mathsf{contrastive}}</annotation></semantics></math> only</th><th><math><semantics><mrow><msub><mi>ℒ</mi> <mi>𝖼𝗈𝗇𝗍𝗋𝖺𝗌𝗍𝗂𝗏𝖾</mi></msub> <mo></mo><mrow><mo>(</mo><mrow><mi>τ</mi> <mo>=</mo> <mn>0.07</mn></mrow><mo>)</mo></mrow></mrow> <annotation>\mathcal{L}_{\mathsf{contrastive}}(\tau\mkern 1.5mu{=}\mkern 1.5mu0.07)</annotation></semantics></math></th><td>72.80%</td><td>91.64%</td></tr><tr><th>Best <math><semantics><msub><mi>ℒ</mi> <mi>𝖺𝗅𝗂𝗀𝗇</mi></msub> <annotation>\mathcal{L}_{\mathsf{align}}</annotation></semantics></math> and <math><semantics><msub><mi>ℒ</mi> <mi>𝗎𝗇𝗂𝖿𝗈𝗋𝗆</mi></msub> <annotation>\mathcal{L}_{\mathsf{uniform}}</annotation></semantics></math> only</th><th><math><semantics><mrow><mrow><mrow><mn>3</mn> <mo>⋅</mo> <msub><mi>ℒ</mi> <mi>𝖺𝗅𝗂𝗀𝗇</mi></msub></mrow> <mo></mo><mrow><mo>(</mo><mrow><mi>α</mi> <mo>=</mo> <mn>2</mn></mrow><mo>)</mo></mrow></mrow> <mo>+</mo> <mrow><msub><mi>ℒ</mi> <mi>𝗎𝗇𝗂𝖿𝗈𝗋𝗆</mi></msub> <mo></mo><mrow><mo>(</mo><mrow><mi>t</mi> <mo>=</mo> <mn>3</mn></mrow><mo>)</mo></mrow></mrow></mrow> <annotation>3\cdot\mathcal{L}_{\mathsf{align}}(\alpha\mkern 1.5mu{=}\mkern 1.5mu2)+\mathcal{L}_{\mathsf{uniform}}(t\mkern 1.5mu{=}\mkern 1.5mu3)</annotation></semantics></math></th><td>74.60%</td><td>92.74%</td></tr><tr><th>Best among all encoders</th><th><math><semantics><mrow><mrow><mrow><mn>3</mn> <mo>⋅</mo> <msub><mi>ℒ</mi> <mi>𝖺𝗅𝗂𝗀𝗇</mi></msub></mrow> <mo></mo><mrow><mo>(</mo><mrow><mi>α</mi> <mo>=</mo> <mn>2</mn></mrow><mo>)</mo></mrow></mrow> <mo>+</mo> <mrow><msub><mi>ℒ</mi> <mi>𝗎𝗇𝗂𝖿𝗈𝗋𝗆</mi></msub> <mo></mo><mrow><mo>(</mo><mrow><mi>t</mi> <mo>=</mo> <mn>3</mn></mrow><mo>)</mo></mrow></mrow></mrow> <annotation>3\cdot\mathcal{L}_{\mathsf{align}}(\alpha\mkern 1.5mu{=}\mkern 1.5mu2)+\mathcal{L}_{\mathsf{uniform}}(t\mkern 1.5mu{=}\mkern 1.5mu3)</annotation></semantics></math></th><td>74.60%</td><td>92.74%</td></tr></tbody></table>

Table 3: ImageNet-100 encoder evaluations. Numbers show validation set accuracies of linear classifiers trained on encoder penultimate layer activations. The encoders are trained using MoCo-based methods. The best result is picked based on top1 accuracy from a $3$ -fold training set cross validation, among all $45$ encoders trained from scratch with $128$ -dimensional output and $128$ batch size.

<table><thead><tr><th></th><th colspan="2">MR Classification</th><th colspan="2">CR Classification</th></tr><tr><th></th><th>Loss Formula</th><th>Val. Set Accuracy <math><semantics><mo>↑</mo> <annotation>\uparrow</annotation></semantics></math></th><th>Loss Formula</th><th>Val. Set Accuracy <math><semantics><mo>↑</mo> <annotation>\uparrow</annotation></semantics></math></th></tr></thead><tbody><tr><td>Best <math><semantics><msub><mi>ℒ</mi> <mi>𝖼𝗈𝗇𝗍𝗋𝖺𝗌𝗍𝗂𝗏𝖾</mi></msub> <annotation>\mathcal{L}_{\mathsf{contrastive}}</annotation></semantics></math> only</td><td><math><semantics><mrow><msub><mi>ℒ</mi> <mi>𝖼𝗈𝗇𝗍𝗋𝖺𝗌𝗍𝗂𝗏𝖾</mi></msub> <mo></mo><mrow><mo>(</mo><mrow><mi>τ</mi> <mo>=</mo> <mn>0.075</mn></mrow><mo>)</mo></mrow></mrow> <annotation>\mathcal{L}_{\mathsf{contrastive}}(\tau\mkern 1.5mu{=}\mkern 1.5mu0.075)</annotation></semantics></math></td><td>77.51%</td><td><math><semantics><mrow><msub><mi>ℒ</mi> <mi>𝖼𝗈𝗇𝗍𝗋𝖺𝗌𝗍𝗂𝗏𝖾</mi></msub> <mo></mo><mrow><mo>(</mo><mrow><mi>τ</mi> <mo>=</mo> <mn>0.05</mn></mrow><mo>)</mo></mrow></mrow> <annotation>\mathcal{L}_{\mathsf{contrastive}}(\tau\mkern 1.5mu{=}\mkern 1.5mu0.05)</annotation></semantics></math></td><td>83.86%</td></tr><tr><td>Best <math><semantics><msub><mi>ℒ</mi> <mi>𝖺𝗅𝗂𝗀𝗇</mi></msub> <annotation>\mathcal{L}_{\mathsf{align}}</annotation></semantics></math> and <math><semantics><msub><mi>ℒ</mi> <mi>𝗎𝗇𝗂𝖿𝗈𝗋𝗆</mi></msub> <annotation>\mathcal{L}_{\mathsf{uniform}}</annotation></semantics></math> only</td><td><math><semantics><mrow><mrow><mrow><mn>0.9</mn> <mo>⋅</mo> <msub><mi>ℒ</mi> <mi>𝖺𝗅𝗂𝗀𝗇</mi></msub></mrow> <mo></mo><mrow><mo>(</mo><mrow><mi>α</mi> <mo>=</mo> <mn>2</mn></mrow><mo>)</mo></mrow></mrow> <mo>+</mo> <mrow><mrow><mn>0.1</mn> <mo>⋅</mo> <msub><mi>ℒ</mi> <mi>𝗎𝗇𝗂𝖿𝗈𝗋𝗆</mi></msub></mrow> <mo></mo><mrow><mo>(</mo><mrow><mi>t</mi> <mo>=</mo> <mn>5</mn></mrow><mo>)</mo></mrow></mrow></mrow> <annotation>0.9\cdot\mathcal{L}_{\mathsf{align}}(\alpha\mkern 1.5mu{=}\mkern 1.5mu2)+0.1\cdot\mathcal{L}_{\mathsf{uniform}}(t\mkern 1.5mu{=}\mkern 1.5mu5)</annotation></semantics></math></td><td>73.76%</td><td><math><semantics><mrow><mrow><mrow><mn>0.9</mn> <mo>⋅</mo> <msub><mi>ℒ</mi> <mi>𝖺𝗅𝗂𝗀𝗇</mi></msub></mrow> <mo></mo><mrow><mo>(</mo><mrow><mi>α</mi> <mo>=</mo> <mn>2</mn></mrow><mo>)</mo></mrow></mrow> <mo>+</mo> <mrow><mrow><mn>0.1</mn> <mo>⋅</mo> <msub><mi>ℒ</mi> <mi>𝗎𝗇𝗂𝖿𝗈𝗋𝗆</mi></msub></mrow> <mo></mo><mrow><mo>(</mo><mrow><mi>t</mi> <mo>=</mo> <mn>5</mn></mrow><mo>)</mo></mrow></mrow></mrow> <annotation>0.9\cdot\mathcal{L}_{\mathsf{align}}(\alpha\mkern 1.5mu{=}\mkern 1.5mu2)+0.1\cdot\mathcal{L}_{\mathsf{uniform}}(t\mkern 1.5mu{=}\mkern 1.5mu5)</annotation></semantics></math></td><td>80.95%</td></tr><tr><td>Best among all encoders</td><td><math><semantics><mrow><msub><mi>ℒ</mi> <mi>𝖼𝗈𝗇𝗍𝗋𝖺𝗌𝗍𝗂𝗏𝖾</mi></msub> <mo></mo><mrow><mo>(</mo><mrow><mi>τ</mi> <mo>=</mo> <mn>0.075</mn></mrow><mo>)</mo></mrow></mrow> <annotation>\mathcal{L}_{\mathsf{contrastive}}(\tau\mkern 1.5mu{=}\mkern 1.5mu0.075)</annotation></semantics></math></td><td>77.51%</td><td><math><semantics><mrow><msub><mi>ℒ</mi> <mi>𝖼𝗈𝗇𝗍𝗋𝖺𝗌𝗍𝗂𝗏𝖾</mi></msub> <mo></mo><mrow><mo>(</mo><mrow><mi>τ</mi> <mo>=</mo> <mn>0.05</mn></mrow><mo>)</mo></mrow></mrow> <annotation>\mathcal{L}_{\mathsf{contrastive}}(\tau\mkern 1.5mu{=}\mkern 1.5mu0.05)</annotation></semantics></math></td><td>83.86%</td></tr></tbody></table>

Table 4: BookCorpus encoder evaluations. Numbers show Movie Review Sentence Polarity (MR) and Customer Product Sentiment (CR) validation set classification accuracies of logistic classifiers fit on encoder outputs. The encoders are trained using Quick-Thought-Vectors-based methods. The best result is picked based on accuracy from a $5$ -fold training set cross validation, individually for MR and CR, among all $108$ encoders trained from scratch with $1200$ -dimensional output and $400$ batch size.

| Loss Formula | Validation Set top1 Accuracy $\uparrow$ |
| --- | --- |
| $\mathcal{L}_{\mathsf{contrastive}}(\tau\mkern 1.5mu{=}\mkern 1.5mu0.2)$ (MoCo v2 [^9]) | $67.5\%\pm 0.1\%$ |
| $3\cdot\mathcal{L}_{\mathsf{align}}(\alpha\mkern 1.5mu{=}\mkern 1.5mu2)+\mathcal{L}_{\mathsf{uniform}}(t\mkern 1.5mu{=}\mkern 1.5mu3)$ | 67.69% |

Table 5: ImageNet encoder evaluations with MoCo v2, and its variant with $\mathcal{L}_{\mathsf{align}}$ and $\mathcal{L}_{\mathsf{uniform}}$. MoCo v2 results are from the MoCo v2 official implementation [^10], with mean and standard deviation across $5$ runs. Both settings use $200$ epochs of unsupervised training.

## 6 Discussion

*Alignment* and *uniformity* are often alluded to as motivations for representation learning methods (see Figure 1). However, a thorough understanding of these properties is lacking in the literature.

Are they in fact related to the representation learning methods? Do they actually agree with the representation quality (measured by downstream task performance)?

In this work, we have presented a detailed investigation on the relation between these properties and the popular paradigm of contrastive representation learning. Through theoretical analysis and extensive experiments, we are able to relate the contrastive loss with the alignment and uniformity properties, and confirm their strong connection with downstream task performances. Remarkably, we have revealed that directly optimizing our proposed metrics often leads to representations of better quality.

Below we summarize several suggestions for future work.

##### Niceness of the unit hypersphere.

Our analysis was based on the empirical observation that representations are often $\ell_{2}$ normalized. Existing works have motivated this choice from a manifold mapping perspective [^38] [^15] and computation stability [^62] [^58]. However, to our best knowledge, the question of why the unit hypersphere is a nice feature space is not yet rigorously answered. One possible direction is to formalize the intuition that connected sets with smooth boundaries are nearly linearly separable in the hyperspherical geometry (see Figure 2), since linear separability is one of the most widely used criteria for representation quality and is related to the notion of disentanglement [^27].

##### Beyond contrastive learning.

Our analysis focused on the relationship between contrastive learning and the alignment and uniformity properties on the unit hypersphere. However, the ubiquitous presence of $\ell_{2}$ normalization in the representation learning literature suggests that the connection may be more general. In fact, several existing empirical methods are directly related to uniformity on the hypersphere [^5] [^15] [^62]. We believe that relating a broader class of representations to uniformity and/or alignment on the hypersphere will provide novel insights and lead to better empirical algorithms.

## Acknowledgements

We thank Philip Bachman, Ching-Yao Chuang, Justin Solomon, Yonglong Tian, and Zhenyang Zhang for many helpful comments and suggestions. Tongzhou Wang was supported by the MIT EECS Merrill Lynch Graduate Fellowship. We thank Yangjun Ruan for helping us realize a minor issue with STL-10 scatter plot (Figure 5, now fixed).

## Major Changelog

##### 8/24/2020:

- Added results on full ImageNet and MoCo v2.

##### 11/6/2020:

- Added discussions on the range of $\mathcal{L}_{\mathsf{uniform}}$.
- Corrected Theorem 1’s convergence rate to $\mathcal{O}(M^{-1/2})$.

##### 8/15/2022:

- Removed from Figures 5 and two STL-10 encoders that should not be included due to their usage of other regularizers (not shown). This does not affect the observed relation among $\mathcal{L}_{\mathsf{align}}$, $\mathcal{L}_{\mathsf{uniform}}$, and downstream performance. All other text and discussions stay unchanged.

## References

## Appendix A Proofs and Additional Theoretical Analysis

In this section, we present proofs for propositions and theorems in main paper Sections 4.1.2 and 4.2.

The propositions in Section 4.1.2 illustrate the deep relations between the Gaussian kernel $G_{t}\colon\mathcal{S}^{d}\times\mathcal{S}^{d}\rightarrow\mathbb{R}$ and the uniform distribution on the unit hypersphere $\mathcal{S}^{d}$. As we will show below in Section A.1, these properties directly follow well-known results on strictly positive definite kernels.

In Section A.2, we present a proof for Theorem 1. Theorem 1 describes the asymptotic behavior of $\mathcal{L}_{\mathsf{contrastive}}$ as the number of negative samples $M$ approaches infinity. The theorem is strongly related to empirical contrastive learning, given an error term (deviation from the limit) decaying in $\mathcal{O}(M^{-1/2})$ and that empirical practices often use a large number of negatives (e.g., $M=65536$ in [^25]) based on the observation that using more negatives consistently leads to better representation quality [^61] [^54] [^25]. Our proof further reveals connections between $\mathcal{L}_{\mathsf{contrastive}}$ and $\mathcal{L}_{\mathsf{uniform}}$ which is defined via the Gaussian kernel.

Finally, also in Section A.2, we present a weaker result on the setting where only a single negative is used in $\mathcal{L}_{\mathsf{contrastive}}$ (i.e., $M=1$).

### A.1 Proofs for and Properties of ℒ𝗎𝗇𝗂𝖿𝗈𝗋𝗆\\mathcal{L}\_{\\mathsf{uniform}}

To prove Proposition 1 and 2, we utilize the *strict positive definiteness* [^4] [^50] of the Gaussian kernel $G_{t}$:

$$
G_{t}(u,v)\triangleq e^{-t\left\lVert u-v\right\rVert_{2}^{2}}=e^{2t\cdot u^{\mathsf{T}}v-2t},\quad t>0.
$$

From there, we apply a known result about such kernels, from which the two propositions directly follow.

###### Definition (Strict positive definiteness ).

A symmetric and lower semi-continuous kernel $K$ on $A\times A$ (where $A$ is infinite and compact) is called strictly positive definite if for every finite signed Borel measure $\mu$ supported on $A$ whose energy

$$
I_{K}[\mu]\triangleq\int_{\mathcal{S}^{d}}\int_{\mathcal{S}^{d}}K(u,v)\mathop{}\!\mathrm{d}\mu(v)\mathop{}\!\mathrm{d}\mu(u)
$$

is well defined, we have $I_{K}[\mu]\geq 0$, where equality holds only if $\mu\equiv 0$ on the $\sigma$ -algebra of Borel subsets of $A$.

###### Definition.

Let $\mathcal{M}(\mathcal{S}^{d})$ be the set of Borel probability measures on $\mathcal{S}^{d}$.

We are now in the place to apply the following two well-known results, which we present by restating Proposition 4.4.1, Theorem 6.2.1 and Corollary 6.2.2 of [^6] in weaker forms. We refer readers to [^6] for their proofs.

###### Lemma 1 (Strict positive definiteness of GtG\_{t}).

For $t>0$, the Gaussian kernel $G_{t}(u,v)\triangleq e^{-t\left\lVert u-v\right\rVert_{2}^{2}}=e^{2t\cdot u^{\mathsf{T}}v-2t}$ is strictly positive definite on $\mathcal{S}^{d}\times\mathcal{S}^{d}$.

###### Lemma 2 (Strictly positive definite kernels on 𝒮d\\mathcal{S}^{d}).

Consider kernel $K_{f}\colon\mathcal{S}^{d}\times\mathcal{S}^{d}\rightarrow(-\infty,+\infty]$ of the form,

$$
K_{f}(u,v)\triangleq f(\left\lVert u-v\right\rVert_{2}^{2}).
$$

If $K_{f}$ is strictly positive definite on $\mathcal{S}^{d}\times\mathcal{S}^{d}$ and $I_{K_{f}}[\sigma_{d}]$ is finite, then $\sigma_{d}$ is the unique measure (on Borel subsets of $\mathcal{S}^{d}$) in the solution of $\min_{\mu\in\mathcal{M}(\mathcal{S}^{d})}I_{K_{f}}[\mu]$, and the normalized counting measures associated with any $K_{f}$ -energy minimizing sequence of $N$ -point configurations on $\mathcal{S}^{d}$ converges weak <sup>∗</sup> to $\sigma_{d}$.

In particular, this conclusion holds whenever $f$ has the property that $-f^{\prime}(t)$ is strictly completely monotone on $(0,4]$ and $I_{K_{f}}[\sigma_{d}]$ is finite.

We now recall Propositions 1 and 2.

###### .

$\sigma_{d}$ is the unique solution (on Borel subsets of $\mathcal{S}^{d}$) of

$$
\min_{\mu\in\mathcal{M}(\mathcal{S}^{d})}I_{G_{t}}[\mu]=\min_{\mu\in\mathcal{M}(\mathcal{S}^{d})}\int_{\mathcal{S}^{d}}\int_{\mathcal{S}^{d}}G_{t}(u,v)\mathop{}\!\mathrm{d}\mu(v)\mathop{}\!\mathrm{d}\mu(u).
$$

###### Proof of.

This is a direct consequence of Lemmas 1 and 2. ∎

###### .

For each $N>0$, the $N$ point minimizer of the average pairwise potential is

$$
\mathbf{u}^{*}_{N}=\argmin_{u_{1},u_{2},\dots,u_{N}\in\mathcal{S}^{d}}\sum_{1\leq i<j\leq N}G_{t}(u_{i},u_{j}).
$$

The normalized counting measures associated with the $\{\mathbf{u}^{*}_{N}\}_{N=1}^{\infty}$ sequence converge weak <sup>∗</sup> to $\sigma_{d}$.

###### Proof of.

This is a direct consequence of Lemmas 1 and 2. ∎

#### A.1.1 More Properties of ℒ𝗎𝗇𝗂𝖿𝗈𝗋𝗆\\mathcal{L}\_{\\mathsf{uniform}}

##### Range of ℒ𝗎𝗇𝗂𝖿𝗈𝗋𝗆\\mathcal{L}\_{\\mathsf{uniform}}.

It’s not obvious what the optimal value of $\mathcal{L}_{\mathsf{uniform}}$ is. In the following proposition, we characterize the exact range of the expected Gaussian potential and how it evolves as dimensionality increases. The situation for $\mathcal{L}_{\mathsf{uniform}}$ directly follows as a corollary.

###### Proposition 3 (Range of the expected pairwise Gaussian potential GtG\_{t}).

For $t>0$, the expected pairwise Gaussian potential w.r.t. Borel probability measure $\mu\in\mathcal{M}(\mathcal{S}^{d})$

$$
I_{G_{t}}[\mu]=\int_{\mathcal{S}^{d}}\int_{\mathcal{S}^{d}}G_{t}(u,v)\mathop{}\!\mathrm{d}\mu(v)\mathop{}\!\mathrm{d}\mu(u)
$$

has range $[e^{-2t}\prescript{}{0}{F}_{1}(;\frac{d+1}{2};t^{2}),1]$, where $\prescript{}{0}{F}_{1}$ is the confluent hypergeometric limit function defined as

$$
\prescript{}{0}{F}_{1}(;\alpha;z)\triangleq\sum_{n=0}^{\infty}\frac{z^{n}}{(\alpha)_{n}n!},
$$

where we have used the Pochhammer symbol $(a)_{n}=\begin{cases}1&\mbox{if }n=0\\
a(a+1)(n+2)\dots(a+n-1)&\mbox{if }n\geq 1.\end{cases}$

We have

- The minimum $e^{-2t}\prescript{}{0}{F}_{1}(;\frac{d+1}{2};t^{2})$ is achieved iff $\mu=\sigma_{d}$ (on Borel subsets of $\mathcal{S}^{d}$). Furthermore, this value strictly decreases as $d$ increases, converging to $e^{-2t}$ in the limit of $d\rightarrow\infty$.
- The maximum is achieved iff $\mu$ is a Dirac delta distribution, i.e., $\mu=\delta_{u}$ (on Borel subsets of $\mathcal{S}^{d}$), for some $u\in\mathcal{S}^{d}$.

###### Proof of.

- Minimum.
	We know from Proposition 1 that $\sigma_{d}$ uniquely achieves the minimum, given by the following integral ratio
	$$
	\displaystyle I_{G_{t}}[\sigma_{d}]
	$$
	 
	$$
	\displaystyle=\frac{\int_{0}^{\pi}e^{-t(2\sin\frac{\theta}{2})^{2}}\sin^{d-1}\theta\mathop{}\!\mathrm{d}\theta}{\int_{0}^{\pi}\sin^{d-1}\theta\mathop{}\!\mathrm{d}\theta}
	$$
	 
	$$
	\displaystyle=\frac{\int_{0}^{\pi}e^{-2t(1-\cos\theta)}\sin^{d-1}\theta\mathop{}\!\mathrm{d}\theta}{\int_{0}^{\pi}\sin^{d-1}\theta\mathop{}\!\mathrm{d}\theta}
	$$
	 
	$$
	\displaystyle=e^{-2t}\frac{\int_{0}^{\pi}e^{2t\cos\theta}\sin^{d-1}\theta\mathop{}\!\mathrm{d}\theta}{\int_{0}^{\pi}\sin^{d-1}\theta\mathop{}\!\mathrm{d}\theta}.
	$$
	The denominator, with some trigonometric identities, can be more straightforwardly evaluated as
	$$
	\int_{0}^{\pi}\sin^{d-1}\theta\mathop{}\!\mathrm{d}\theta=\sqrt{\pi}\frac{\Gamma(\frac{d}{2})}{\Gamma(\frac{d+1}{2})}.
	$$
	The numerator is
	$$
	\displaystyle\int_{0}^{\pi}e^{2t\cos\theta}\sin^{d-1}\theta\mathop{}\!\mathrm{d}\theta
	$$
	 
	$$
	\displaystyle=-\int_{0}^{\pi}e^{2t\cos\theta}\sin^{d-2}\theta\cos^{\prime}\theta\mathop{}\!\mathrm{d}\theta
	$$
	 
	$$
	\displaystyle=\int_{-1}^{1}e^{2ts}(1-s^{2})^{d/2-1}\mathop{}\!\mathrm{d}s
	$$
	 
	$$
	\displaystyle=\frac{\Gamma(\frac{d-1}{2}+\frac{1}{2})\sqrt{\pi}}{\Gamma(\frac{d-1}{2}+1)}\prescript{}{0}{F}_{1}(;\frac{d-1}{2}+1;-\frac{1}{4}(-2it)^{2})
	$$
	 
	$$
	\displaystyle=\frac{\Gamma(\frac{d}{2})\sqrt{\pi}}{\Gamma(\frac{d+1}{2})}\prescript{}{0}{F}_{1}(;\frac{d+1}{2};t^{2}),
	$$
	where we have used the following identity based on the Poisson formula for Bessel functions and the relationship between $\prescript{}{0}{F}_{1}$ and Bessel functions:
	$$
	\int_{-1}^{1}e^{izs}(1-s^{2})^{\nu-\frac{1}{2}}\mathop{}\!\mathrm{d}s=\frac{\Gamma(\nu+\frac{1}{2})\sqrt{\pi}}{(\frac{z}{2})^{\nu}}J_{\nu}(z)=\frac{\Gamma(\nu+\frac{1}{2})\sqrt{\pi}}{\Gamma(\nu+1)}\prescript{}{0}{F}_{1}(;\nu+1;-\frac{1}{4}z^{2}).
	$$
	Putting both together, we have
	$$
	\displaystyle I_{G_{t}}[\sigma_{d}]
	$$
	 
	$$
	\displaystyle=e^{-2t}\frac{\int_{0}^{\pi}e^{2t\cos\theta}\sin^{d-1}\theta\mathop{}\!\mathrm{d}\theta}{\int_{0}^{\pi}\sin^{d-1}\theta\mathop{}\!\mathrm{d}\theta}
	$$
	 
	$$
	\displaystyle=e^{-2t}\dfrac{\frac{\Gamma(\frac{d}{2})\sqrt{\pi}}{\Gamma(\frac{d+1}{2})}\prescript{}{0}{F}_{1}(;\frac{d+1}{2};t^{2})}{\sqrt{\pi}\frac{\Gamma(\frac{d}{2})}{\Gamma(\frac{d+1}{2})}}
	$$
	 
	$$
	\displaystyle=e^{-2t}\prescript{}{0}{F}_{1}(;\frac{d+1}{2};t^{2})
	$$
	 
	$$
	\displaystyle=e^{-2t}\sum_{n=0}^{\infty}\frac{t^{2n}}{(\frac{d+1}{2})_{n}n!},
	$$
	where we have used the definition of $\prescript{}{0}{F}_{1}$ in Equation 5 to expand the formula.
	Notice that each summand strictly decreases as $d\rightarrow\infty$. So must the total sum.
	For the asymptotic behavior at $d\rightarrow\infty$, it only remains to show that
	$$
	\lim_{d\rightarrow\infty}\sum_{n=0}^{\infty}\frac{t^{2n}}{(\frac{d+1}{2})_{n}n!}=1.
	$$
	For the purpose of applying the Dominated Convergence Theorem (DCT) (on the counting measure). We consider the following summable series
	$$
	\sum_{n=0}^{\infty}\frac{t^{2n}}{n!}=e^{t^{2}},
	$$
	with each term bounding the corresponding one in Equation 6:
	$$
	\frac{t^{2n}}{n!}\geq\frac{t^{2n}}{(\frac{d+1}{2})_{n}n!},\qquad\qquad\forall n\geq 0,d>0.
	$$
	Thus,
	$$
	\lim_{d\rightarrow\infty}\sum_{n=0}^{\infty}\frac{t^{2n}}{(\frac{d+1}{2})_{n}n!}=\sum_{n=0}^{\infty}\lim_{d\rightarrow\infty}\frac{t^{2n}}{(\frac{d+1}{2})_{n}n!}=1+0+0+\dots=1.
	$$
	Hence, the asymptotic lower range is $e^{-2t}$.
- Maximum.
	Obviously, Dirac delta distributions $\delta_{u}$, $u\in\mathcal{S}^{d}$ would achieve a maximum of $1$. We will now show that all Borel probability measures $\mu$ s.t. $I_{G_{t}}[\mu]=1$ are delta distributions.
	Suppose that such a $\mu$ is not a Dirac delta distribution. Then, we can take distinct $x,y\in\supp(\mu)\subseteq\mathcal{S}^{d}$, and open neighborhoods around $x$ and $v$, $N_{x},N_{y}\in\mathcal{S}^{d}$ such that they are small enough and disjoint:
	$$
	\displaystyle N_{x}
	$$
	 
	$$
	\displaystyle\triangleq\{u\in\mathcal{S}^{d}\colon\left\lVert u-x\right\rVert_{2}<\frac{1}{3}\left\lVert x-y\right\rVert_{2}\}
	$$
	 
	$$
	\displaystyle N_{y}
	$$
	 
	$$
	\displaystyle\triangleq\{u\in\mathcal{S}^{d}\colon\left\lVert u-y\right\rVert_{2}<\frac{1}{3}\left\lVert x-y\right\rVert_{2}\}.
	$$
	Then,
	$$
	\displaystyle I_{G_{t}}[\mu]
	$$
	 
	$$
	\displaystyle=\int_{\mathcal{S}^{d}}\int_{\mathcal{S}^{d}}G_{t}(u,v)\mathop{}\!\mathrm{d}\mu(v)\mathop{}\!\mathrm{d}\mu(u)
	$$
	 
	$$
	\displaystyle=\int_{\mathcal{S}^{d}}\int_{\mathcal{S}^{d}}e^{-t\left\lVert u-v\right\rVert_{2}^{2}}\mathop{}\!\mathrm{d}\mu(v)\mathop{}\!\mathrm{d}\mu(u)
	$$
	 
	$$
	\displaystyle\leq(1-2\mu({N_{x}})\mu({N_{y}}))e^{-t\cdot 0}+2\int_{N_{x}}\int_{N_{y}}e^{-t\left\lVert u-v\right\rVert_{2}^{2}}\mathop{}\!\mathrm{d}\mu(v)\mathop{}\!\mathrm{d}\mu(u)
	$$
	 
	$$
	\displaystyle<1-2\mu({N_{x}})\mu({N_{y}})+2\mu({N_{x}})\mu({N_{y}})e^{-t(\left\lVert x-y\right\rVert_{2}/3)^{2}}
	$$
	 
	$$
	\displaystyle=1-2\mu({N_{x}})\mu({N_{y}})(1-e^{-\frac{t}{9}\left\lVert x-y\right\rVert_{2}^{2}})
	$$
	 
	$$
	\displaystyle<1.
	$$
	Hence, only Dirac delta distributions attain the maximum.

∎

###### Corollary 1 (Range of ℒ𝗎𝗇𝗂𝖿𝗈𝗋𝗆\\mathcal{L}\_{\\mathsf{uniform}}).

For encoder $f\colon\mathbb{R}^{n}\rightarrow\mathcal{S}^{m-1}$, $\mathcal{L}_{\mathsf{uniform}}(f;t)\in[-2t+\log\prescript{}{0}{F}_{1}(;\frac{m}{2};t^{2}),0]$, where the lower bound $-2t+\log\prescript{}{0}{F}_{1}(;\frac{m}{2};t^{2})$ is achieved only by perfectly uniform encoders $f$, and the upper bound $0$ is achieved only by degenerate encoders that output a fixed feature vector almost surely.

Furthermore, the lower bound strictly decreases as the output dimension $m$ increases, attaining the following asymptotic value

$$
\lim_{m\rightarrow\infty}-2t+\log\prescript{}{0}{F}_{1}(;\frac{m}{2};t^{2})=-2t.
$$

Figure 10: Asymptotic behavior of $\prescript{}{0}{F}_{1}(;\alpha;z)$. For $z>0$, as $\alpha$ grows larger, the function converges to $1$.

Figure 11: Asymptotic behavior of optimal $\mathcal{L}_{\mathsf{uniform}}(f,t)$, attained by a perfectly uniform encoder $f^{*}$. As the feature dimension $m$ grows larger, the value converges to $-2t$.

##### Intuition for the optimal ℒ𝗎𝗇𝗂𝖿𝗈𝗋𝗆\\mathcal{L}\_{\\mathsf{uniform}} value in high dimensions.

If we ignore the $\log\prescript{}{0}{F}_{1}(;\frac{m}{2};t^{2})$ term, informally, the optimal value of $-2t$ roughly says that any pair of feature vectors on $\mathcal{S}^{d}$ has distance about $\sqrt{2}$, i.e., are nearly orthogonal to each other. Indeed, vectors of high dimensions are usually nearly orthogonal, which is also consistent with the asymptotic result in Equation 7.

Figures 11 and 11 visualize how $\prescript{}{0}{F}_{1}$ and the optimal $\mathcal{L}_{\mathsf{uniform}}$ (given by perfectly uniform encoders) evolve.

##### Lower bound of ℒ𝗎𝗇𝗂𝖿𝗈𝗋𝗆\\mathcal{L}\_{\\mathsf{uniform}} estimates.

In practice, when $\mathcal{L}_{\mathsf{uniform}}$ calculated using expectation over (a batch of) empirical samples $\{x_{i}\}_{i=1}^{B}$, $B>1$, the range in Corollary 1 is indeed valid, since it bounds over all distributions:

$$
\hat{\mathcal{L}}^{(1)}_{\mathsf{uniform}}\triangleq\log\frac{1}{B^{2}}\sum_{i=1}^{B}\sum_{j=1}^{B}e^{-t\left\lVert f(x_{i})-f(x_{j})\right\rVert^{2}}>-2t+\log\prescript{}{0}{F}_{1}(;\frac{m}{2};t^{2}).
$$

However, often $\mathcal{L}_{\mathsf{uniform}}$ is empirically estimated without considering distances between a vector and itself (e.g., in Figure 6 and in our experiment settings as described in Appendix B):

$$
\hat{\mathcal{L}}^{(2)}_{\mathsf{uniform}}\triangleq\log\frac{1}{B(B-1)}\sum_{i=1}^{B}\sum_{j\in\{1,\dots,B\}\setminus\{i\}}e^{-t\left\lVert f(x_{i})-f(x_{j})\right\rVert^{2}}.
$$

While both quantities converge to the correct value in the limit, the lower bound is not always true for this one, because it is not the expected pairwise Gaussian kernel based on some distribution. Note the following relation:

$$
\hat{\mathcal{L}}^{(2)}_{\mathsf{uniform}}=\log\left(\frac{B\cdot\exp(\hat{\mathcal{L}}^{(1)}_{\mathsf{uniform}})-1}{B-1}\right).
$$

We can derive a valid lower bound using Equation 8: for $\prescript{}{0}{F}_{1}(;\frac{m}{2};t^{2})>\frac{e^{2t}}{B}$,

$$
\hat{\mathcal{L}}^{(2)}_{\mathsf{uniform}}>\log\left(\frac{B\cdot\exp(-2t+\log\prescript{}{0}{F}_{1}(;\frac{m}{2};t^{2}))-1}{B-1}\right)=\log\left(\frac{Be^{-2t}\prescript{}{0}{F}_{1}(;\frac{m}{2};t^{2})-1}{B-1}\right).
$$

Since this approaches fails for cases that $\prescript{}{0}{F}_{1}(;\frac{m}{2};t^{2})\leq\frac{e^{2t}}{B}$, we can combine it with the naive lower bound $-4t$, and have

$$
\hat{\mathcal{L}}^{(2)}_{\mathsf{uniform}}>\begin{cases}\max(-4t,\log\left(\frac{Be^{-2t}\prescript{}{0}{F}_{1}(;\frac{m}{2};t^{2})-1}{B-1}\right))&\mbox{if }\prescript{}{0}{F}_{1}(;\frac{m}{2};t^{2})>\frac{e^{2t}}{B}\\
-4t&\mbox{otherwise.}\end{cases}
$$

##### Non-negative versions of ℒ𝗎𝗇𝗂𝖿𝗈𝗋𝗆\\mathcal{L}\_{\\mathsf{uniform}} for practical uses.

By definition, $\mathcal{L}_{\mathsf{uniform}}$ always non-positive. As shown above, different $\mathcal{L}_{\mathsf{uniform}}$ empirical estimates may admit different lower bounds. However, in our experience, for reasonably large batch sizes, adding an offset of $2t$ often ensures a non-negative loss that is near zero at optimum. When output dimensionality $m$ is low, it might be useful to add an additional offset of $-\log\prescript{}{0}{F}_{1}(;\frac{m}{2};t^{2})$, which can be computed with the help of the SciPy package function scipy.special.hyp0f1(m/2, t\*\*2) [^57].

### A.2 Proofs and Additional Results for Section 4.2

The following lemma directly follows Theorem 3.3 and Remarks 3.4 (b)(i) of [^49]. We refer readers to [^49] for its proof.

###### Lemma 3.

Let $A$ be a compact second countable Hausdorff space. Suppose

1. $\{\mu_{n}\}_{n=1}^{\infty}$ is a sequence of finite and positive Borel measures supported on $A$ that converges weak <sup>∗</sup> to some finite and positive Borel measure $\mu$ (which is same as vague convergence since $A$ is compact);
2. $\{f_{n}\}_{n=1}^{\infty}$ is a sequence of Borel measurable functions that converges continuously to a Borel measurable $f$;
3. $\{f_{n}\}_{n}$ are uniformly bounded over $A$.

Then, we have the following convergence:

$$
\lim_{n\rightarrow\infty}\int_{x\in A}f_{n}(x)\mathop{}\!\mathrm{d}\mu_{n}(x)=\int_{x\in A}f(x)\mathop{}\!\mathrm{d}\mu(x).
$$

We now recall Theorem 1.

###### (Asymptotics of ℒ𝖼𝗈𝗇𝗍𝗋𝖺𝗌𝗍𝗂𝗏𝖾\\mathcal{L}\_{\\mathsf{contrastive}}).

For fixed $\tau>0$, as the number of negative samples $M\rightarrow\infty$, the (normalized) contrastive loss converges to

$$
\displaystyle\lim_{M\rightarrow\infty}\mathcal{L}_{\mathsf{contrastive}}(f;\tau,M)-\log M
$$
 
$$
\displaystyle\qquad\qquad=\lim_{M\rightarrow\infty}\underset{{\begin{subarray}{c}(x,y)\sim p_{\mathsf{pos}}\\
\{x^{-}_{i}\}_{i=1}^{M}\overset{\text{i.i.d.}}{\sim}p_{\mathsf{data}}\end{subarray}}}{\mathbb{E}}\hskip-3.0pt\left[{-\log\frac{e^{f(x)^{\mathsf{T}}f(y)/\tau}}{e^{f(x)^{\mathsf{T}}f(y)/\tau}+\sum_{i}e^{f(x^{-}_{i})^{\mathsf{T}}f(y)/\tau}}}\right]-\log M
$$
 
$$
\displaystyle\qquad\qquad=-\frac{1}{\tau}\underset{{(x,y)\sim p_{\mathsf{pos}}}}{\mathbb{E}}\hskip-3.0pt\left[{f(x)^{\mathsf{T}}f(y)}\right]+\underset{{x\sim p_{\mathsf{data}}}}{\mathbb{E}}\hskip-3.0pt\left[{\log\underset{{x^{-}\sim p_{\mathsf{data}}}}{\mathbb{E}}\hskip-3.0pt\left[{e^{f(x^{-})^{\mathsf{T}}f(x)/\tau}}\right]}\right].
$$

We have the following results:

1. The first term is minimized iff $f$ is perfectly aligned.
2. If perfectly uniform encoders exist, they form the exact minimizers of the second term.
3. For the convergence in Equation 2, the absolute deviation from the limit (i.e., the error term) decays in $\mathcal{O}(M^{-1/2})$.

###### Proof of.

- Proof of the convergence in Equation 2 and the $\mathcal{O}(M^{-1/2})$ decay rate of its error term (result 3).
	Note that for any $x,y\in\mathbb{R}^{n}$ and $\{x^{-}_{i}\}_{i=1}^{M}\overset{\text{i.i.d.}}{\sim}p_{\mathsf{data}}$, we have
	$$
	\lim_{M\rightarrow\infty}\log\left(\frac{1}{M}e^{f(x)^{\mathsf{T}}f(y)/\tau}+\frac{1}{M}\sum_{i=1}^{M}e^{f(x^{-}_{i})^{\mathsf{T}}f(x)/\tau}\right)=\log\underset{{x^{-}\sim p_{\mathsf{data}}}}{\mathbb{E}}\hskip-3.0pt\left[{e^{f(x^{-})^{\mathsf{T}}f(x)/\tau}}\right]\qquad\text{almost surely},
	$$
	by the strong law of large numbers (SLLN) and the Continuous Mapping Theorem.
	Then, we can derive
	$$
	\begin{split}&\lim_{M\rightarrow\infty}\mathcal{L}_{\mathsf{contrastive}}(f;\tau,M)-\log M\\
	&\qquad\qquad=\underset{{(x,y)\sim p_{\mathsf{pos}}}}{\mathbb{E}}\hskip-3.0pt\left[{-f(x)^{\mathsf{T}}f(y)/\tau}\right]+\lim_{M\rightarrow\infty}\underset{{\begin{subarray}{c}(x,y)\sim p_{\mathsf{pos}}\\
	\{x^{-}_{i}\}_{i=1}^{M}\overset{\text{i.i.d.}}{\sim}p_{\mathsf{data}}\end{subarray}}}{\mathbb{E}}\hskip-3.0pt\left[{\log\left(\frac{1}{M}e^{f(x)^{\mathsf{T}}f(y)/\tau}+\frac{1}{M}\sum_{i=1}^{M}e^{f(x^{-}_{i})^{\mathsf{T}}f(x)/\tau}\right)}\right]\\
	&\qquad\qquad=\underset{{(x,y)\sim p_{\mathsf{pos}}}}{\mathbb{E}}\hskip-3.0pt\left[{-f(x)^{\mathsf{T}}f(y)/\tau}\right]+\mathbb{E}\left[{\lim_{M\rightarrow\infty}\log\left(\frac{1}{M}e^{f(x)^{\mathsf{T}}f(y)/\tau}+\frac{1}{M}\sum_{i=1}^{M}e^{f(x^{-}_{i})^{\mathsf{T}}f(x)/\tau}\right)}\right]\\
	&\qquad\qquad=-\frac{1}{\tau}\underset{{(x,y)\sim p_{\mathsf{pos}}}}{\mathbb{E}}\hskip-3.0pt\left[{f(x)^{\mathsf{T}}f(y)}\right]+\underset{{x\sim p_{\mathsf{data}}}}{\mathbb{E}}\hskip-3.0pt\left[{\log\underset{{x^{-}\sim p_{\mathsf{data}}}}{\mathbb{E}}\hskip-3.0pt\left[{e^{f(x^{-})^{\mathsf{T}}f(x)/\tau}}\right]}\right],\end{split}
	$$
	where we justify the switching of expectation and limit by the convergence stated in Equation 10, the boundedness of $e^{u^{\mathsf{T}}v/\tau}$ (where $u,v\in\mathcal{S}^{d},\tau>0$), and the Dominated Convergence Theorem (DCT).
	For convergence speed, we have
	$$
	\displaystyle\left\lvert\left(\lim_{M\rightarrow\infty}\mathcal{L}_{\mathsf{contrastive}}(f;\tau,M)-\log M\right)-\left(\mathcal{L}_{\mathsf{contrastive}}(f;\tau,M)-\log M\right)\right\rvert
	$$
	 
	$$
	\displaystyle\qquad\qquad=\left\lvert\underset{{\begin{subarray}{c}(x,y)\sim p_{\mathsf{pos}}\\
	\{x^{-}_{i}\}_{i=1}^{M}\overset{\text{i.i.d.}}{\sim}p_{\mathsf{data}}\end{subarray}}}{\mathbb{E}}\hskip-3.0pt\left[{\log\underset{{x^{-}\sim p_{\mathsf{data}}}}{\mathbb{E}}\hskip-3.0pt\left[{e^{f(x^{-})^{\mathsf{T}}f(x)/\tau}}\right]-\log\left(\frac{1}{M}e^{f(x)^{\mathsf{T}}f(y)/\tau}+\frac{1}{M}\sum_{i=1}^{M}e^{f(x^{-}_{i})^{\mathsf{T}}f(x)/\tau}\right)}\right]\right\rvert
	$$
	 
	$$
	\displaystyle\qquad\qquad\leq\underset{{\begin{subarray}{c}(x,y)\sim p_{\mathsf{pos}}\\
	\{x^{-}_{i}\}_{i=1}^{M}\overset{\text{i.i.d.}}{\sim}p_{\mathsf{data}}\end{subarray}}}{\mathbb{E}}\hskip-3.0pt\left[{\left\lvert\log\underset{{x^{-}\sim p_{\mathsf{data}}}}{\mathbb{E}}\hskip-3.0pt\left[{e^{f(x^{-})^{\mathsf{T}}f(x)/\tau}}\right]-\log\left(\frac{1}{M}e^{f(x)^{\mathsf{T}}f(y)/\tau}+\frac{1}{M}\sum_{i=1}^{M}e^{f(x^{-}_{i})^{\mathsf{T}}f(x)/\tau}\right)\right\rvert}\right]
	$$
	 
	$$
	\displaystyle\qquad\qquad\leq e^{1/\tau}\underset{{\begin{subarray}{c}(x,y)\sim p_{\mathsf{pos}}\\
	\{x^{-}_{i}\}_{i=1}^{M}\overset{\text{i.i.d.}}{\sim}p_{\mathsf{data}}\end{subarray}}}{\mathbb{E}}\hskip-3.0pt\left[{\left\lvert\underset{{x^{-}\sim p_{\mathsf{data}}}}{\mathbb{E}}\hskip-3.0pt\left[{e^{f(x^{-})^{\mathsf{T}}f(x)/\tau}}\right]-\left(\frac{1}{M}e^{f(x)^{\mathsf{T}}f(y)/\tau}+\frac{1}{M}\sum_{i=1}^{M}e^{f(x^{-}_{i})^{\mathsf{T}}f(x)/\tau}\right)\right\rvert}\right]
	$$
	 
	$$
	\displaystyle\qquad\qquad\leq\frac{1}{M}e^{2/\tau}+e^{1/\tau}\underset{{x,\{x^{-}_{i}\}_{i=1}^{M}\overset{\text{i.i.d.}}{\sim}p_{\mathsf{data}}}}{\mathbb{E}}\hskip-3.0pt\left[{\left\lvert\underset{{x^{-}\sim p_{\mathsf{data}}}}{\mathbb{E}}\hskip-3.0pt\left[{e^{f(x^{-})^{\mathsf{T}}f(x)/\tau}}\right]-\frac{1}{M}\sum_{i=1}^{M}e^{f(x^{-}_{i})^{\mathsf{T}}f(x)/\tau}\right\rvert}\right]
	$$
	 
	$$
	\displaystyle\qquad\qquad=\frac{1}{M}e^{2/\tau}+\mathcal{O}(M^{-1/2}),
	$$
	where the first inequality follows the Intermediate Value Theorem and the $e^{1/\tau}$ upper bound on the absolute derivative of $\log$ between the two points, and the last equality follows the Berry-Esseen Theorem given the bounded support of $e^{f(x^{-}_{i})^{\mathsf{T}}f(x)/\tau}$ as following: for i.i.d. random variables $Y_{i}$ with bounded support $\subset[-a,a]$, zero mean and $\sigma^{2}_{Y}\leq a^{2}$ variance, we have
	$$
	\displaystyle\mathbb{E}\left[{\left\lvert\frac{1}{M}\sum_{i=1}^{M}Y_{i}\right\rvert}\right]
	$$
	 
	$$
	\displaystyle=\frac{\sigma_{Y}}{\sqrt{M}}\mathbb{E}\left[{\left\lvert\frac{1}{\sqrt{M}\sigma_{Y}}\sum_{i=1}^{M}Y_{i}\right\rvert}\right]
	$$
	 
	$$
	\displaystyle=\frac{\sigma_{Y}}{\sqrt{M}}\int_{0}^{\frac{a\sqrt{M}}{\sigma_{Y}}}{\mathbb{P}}\left[{\left\lvert\frac{1}{\sqrt{M}\sigma_{Y}}\sum_{i=1}^{M}Y_{i}\right\rvert>x}\right]\mathop{}\!\mathrm{d}x
	$$
	 
	$$
	\displaystyle\leq\frac{\sigma_{Y}}{\sqrt{M}}\int_{0}^{\frac{a\sqrt{M}}{\sigma_{Y}}}{\mathbb{P}}\left[{\left\lvert\mathcal{N}(0,1)\right\rvert>x}\right]+\frac{C_{a}}{\sqrt{M}}\mathop{}\!\mathrm{d}x
	$$
	 
	$$
	\displaystyle\leq\frac{\sigma_{Y}}{\sqrt{M}}\left(\frac{aC_{a}}{\sigma_{Y}}+\int_{0}^{\infty}{\mathbb{P}}\left[{\left\lvert\mathcal{N}(0,1)\right\rvert>x}\right]\mathop{}\!\mathrm{d}x\right)
	$$
	 
	$$
	\displaystyle=\frac{\sigma_{Y}}{\sqrt{M}}\left(\frac{aC_{a}}{\sigma_{Y}}+\mathbb{E}\left[{\left\lvert\mathcal{N}(0,1)\right\rvert}\right]\right)
	$$
	 
	$$
	\displaystyle\leq\frac{C_{a}}{\sqrt{M}}+\frac{a}{\sqrt{M}}\mathbb{E}\left[{\left\lvert\mathcal{N}(0,1)\right\rvert}\right]
	$$
	 
	$$
	\displaystyle=\mathcal{O}(M^{-1/2}),
	$$
	where the constant $C_{a}$ only depends on $a$ (which controls both the second and the third moment).
- Proof of result 1: The first term is minimized iff $f$ is perfectly aligned.
	Note that for $u,v\in\mathcal{S}^{d}$,
	$$
	\left\lVert u-v\right\rVert_{2}^{2}=2-2\cdot u^{T}v.
	$$
	Then the result follows directly the definition of perfect alignment, and the existence of perfectly aligned encoders (e.g., an encoder that maps every input to the same output vector).
- Proof of result 2: If perfectly uniform encoders exist, they form the exact minimizers of the second term.
	For simplicity, we define the following notation:
	###### Definition.
	$\forall\mu\in\mathcal{M}(\mathcal{S}^{d})$, $u\in\mathcal{S}^{d}$, we define the continuous and Borel measurable function
	$$
	U_{\mu}(u)\triangleq\int_{\mathcal{S}^{d}}e^{u^{\mathsf{T}}v/\tau}\mathop{}\!\mathrm{d}\mu(v).
	$$
	with its range bounded in $[e^{-1/\tau},e^{1/\tau}]$.
	Then the second term can be equivalently written as
	$$
	\underset{{x\sim p_{\mathsf{data}}}}{\mathbb{E}}\hskip-3.0pt\left[{\log\underset{{x^{-}\sim p_{\mathsf{data}}}}{\mathbb{E}}\hskip-3.0pt\left[{e^{f(x^{-})^{\mathsf{T}}f(x)/\tau}}\right]}\right]=\underset{{x\sim p_{\mathsf{data}}}}{\mathbb{E}}\hskip-3.0pt\left[{\log U_{p_{\mathsf{data}}\circ f^{-1}}(f(x))}\right],
	$$
	where $p_{\mathsf{data}}\circ f^{-1}\in\mathcal{M}(\mathcal{S}^{d})$ is the probability measure of features, i.e., the pushforward measure of $p_{\mathsf{data}}$ via $f$.
	We now consider the following relaxed problem, where the minimization is taken over $\mathcal{M}(\mathcal{S}^{d})$, all possible Borel probability measures on the hypersphere $\mathcal{S}^{d}$:
	$$
	\min_{\mu\in\mathcal{M}(\mathcal{S}^{d})}\int_{\mathcal{S}^{d}}\log U_{\mu}(u)\mathop{}\!\mathrm{d}\mu(u).
	$$
	Our strategy is to show that the unique minimizer of Equation 13 is $\sigma_{d}$, from which the result 2 directly follows. The rest of the proof is structured in three parts.
	1. We show that minimizers of Equation 13 exist, i.e., the above infimum is attained for some $\mu\in\mathcal{M}(\mathcal{S}^{d})$.
		Let $\{\mu_{m}\}_{m=1}^{\infty}$ be a sequence in $\mathcal{M}(\mathcal{S}^{d})$ such that the infimum of Equation 13 is reached in the limit:
		$$
		\lim_{m\rightarrow\infty}\int_{\mathcal{S}^{d}}\log U_{\mu_{m}}(u)\mathop{}\!\mathrm{d}{\mu_{m}}(u)=\inf_{\mu\in\mathcal{M}(\mathcal{S}^{d})}\int_{\mathcal{S}^{d}}\log U_{\mu}(u)\mathop{}\!\mathrm{d}\mu(u).
		$$
		From the Helly’s Selection Theorem, let $\mu^{*}$ denote some weak <sup>∗</sup> cluster point of this sequence. Then $\mu_{m}$ converges weak <sup>∗</sup> to $\mu^{*}$ along a subsequence $m\in\mathcal{N}\in\mathbb{N}$. For simplicity and with a slight abuse of notation, we denote this convergent (sub)sequence of measures by $\{\mu_{n}\}_{n=1}^{\infty}$.
		We want to show that $\mu^{*}$ attains the limit (and thus the infimum), i.e.,
		$$
		\int_{\mathcal{S}^{d}}\log U_{\mu^{*}}(u)\mathop{}\!\mathrm{d}\mu^{*}(u)=\lim_{n\rightarrow\infty}\int_{\mathcal{S}^{d}}\log U_{\mu_{n}}(u)\mathop{}\!\mathrm{d}{\mu_{n}}(u).
		$$
		In view of Lemma 3, since $\mathcal{S}^{d}$ is a compact second countable Hausdorff space and $\{\log U_{\mu_{n}}\}_{n}$ is uniformly bounded over $\mathcal{S}^{d}$, it remains to prove that $\{\log U_{\mu_{n}}\}_{n}$ is continuously convergent to $\log U_{\mu^{*}}$.
		Consider any convergent sequence of points $\{x_{n}\}_{n=1}^{\infty}\in\mathbb{R}^{d+1}$ s.t. $x_{n}\rightarrow x$ where $x\in\mathcal{S}^{d}$.
		Let $\delta_{n}=x_{n}-x$. By simply expanding $U_{\mu_{n}}$ and $\mu_{\mu^{*}}$, we have
		$$
		e^{-\left\lVert\delta_{n}\right\rVert/\tau}U_{\mu_{n}}(x)\leq U_{\mu_{n}}(x_{n})\leq e^{\left\lVert\delta_{n}\right\rVert/\tau}U_{\mu_{n}}(x).
		$$
		Since both the upper and the lower bound converge to $U_{\mu^{*}}(x)$ (by the weak <sup>∗</sup> convergence of $\{\mu_{n}\}_{n}$ to $\mu^{*}$), $U_{\mu_{n}}(x_{n})$ must as well. We have proved the continuous convergence of $\{\log U_{\mu_{n}}\}_{n}$ to $\log U_{\mu^{*}}$.
		Therefore, the limit in Equation 14 holds. The infimum is thus attained at $\mu^{*}$:
		$$
		\lim_{n\rightarrow\infty}\int_{u}\log U_{\mu_{n}}(u)\mathop{}\!\mathrm{d}{\mu_{n}}=\int_{u}\log U_{\mu^{*}}(u)\mathop{}\!\mathrm{d}\mu^{*}.
		$$
	2. We show that $U_{\mu^{*}}$ is constant $\mu^{*}$ -almost surely for any minimizer $\mu^{*}$ of Equation 13.
		Let $\mu^{*}$ be any solution of Equation 13:
		$$
		\mu^{*}\in\argmin_{\mu\in\mathcal{M}(\mathcal{S}^{d})}\int_{u}\log U_{\mu}(u)\mathop{}\!\mathrm{d}\mu.
		$$
		Consider the Borel sets where $\mu^{*}$ has positive measure: $\mathcal{T}\triangleq\{T\in\mathcal{B}(\mathcal{S}^{d})\colon\mu^{*}(T)>0\}$. For any $T\in\mathcal{T}$, let $\mu^{*}_{T}$ denote the conditional distribution of $\mu^{*}$ on $T$, i.e., $\forall A\in\mathcal{B}(\mathcal{S}^{d})$,
		$$
		\mu^{*}_{T}(A)=\frac{\mu^{*}(A\cap T)}{\mu^{*}(T)}.
		$$
		Note that for any such $T\in\mathcal{T}$, the mixture $(1-\alpha)\mu^{*}+\alpha\mu^{*}_{T}$ is a valid probability distribution (i.e., in $\mathcal{M}(\mathcal{S}^{d})$) for $\alpha\in(-\mu^{*}(T),1)$, an open interval containing $0$.
		By the first variation, we must have
		$$
		\displaystyle 0
		$$
		 
		$$
		\displaystyle=\frac{\partial}{\partial\alpha}\int_{\mathcal{S}^{d}}\log U_{(1-\alpha)\mu^{*}+\alpha\mu^{*}_{T}}(u)\mathop{}\!\mathrm{d}((1-\alpha)\mu^{*}+\alpha\mu^{*}_{T})(u)\bigg\rvert_{\alpha=0}
		$$
		 
		$$
		\displaystyle=\frac{\partial}{\partial\alpha}(1-\alpha)\int_{\mathcal{S}^{d}}\log U_{(1-\alpha)\mu^{*}+\alpha\mu^{*}_{T}}(u)\mathop{}\!\mathrm{d}\mu^{*}(u)\bigg\rvert_{\alpha=0}+\frac{\partial}{\partial\alpha}\alpha\int_{\mathcal{S}^{d}}\log U_{(1-\alpha)\mu^{*}+\alpha\mu^{*}_{T}}(u)\mathop{}\!\mathrm{d}\mu^{*}_{T}(u)\bigg\rvert_{\alpha=0}
		$$
		 
		$$
		\displaystyle=-\int_{\mathcal{S}^{d}}\log U_{(1-\alpha)\mu^{*}+\alpha\mu^{*}_{T}}(u)\mathop{}\!\mathrm{d}\mu^{*}(u)\bigg\rvert_{\alpha=0}+\frac{\partial}{\partial\alpha}\int_{\mathcal{S}^{d}}\log U_{(1-\alpha)\mu^{*}+\alpha\mu^{*}_{T}}(u)\mathop{}\!\mathrm{d}\mu^{*}(u)\bigg\rvert_{\alpha=0}
		$$
		 
		$$
		\displaystyle\qquad\qquad+\int_{\mathcal{S}^{d}}\log U_{(1-\alpha)\mu^{*}+\alpha\mu^{*}_{T}}(u)\mathop{}\!\mathrm{d}\mu^{*}_{T}(u)\bigg\rvert_{\alpha=0}+0\cdot\frac{\partial}{\partial\alpha}\int_{\mathcal{S}^{d}}\log U_{(1-\alpha)\mu^{*}+\alpha\mu^{*}_{T}}(u)\mathop{}\!\mathrm{d}\mu^{*}_{T}(u)\bigg\rvert_{\alpha=0}
		$$
		 
		$$
		\displaystyle=-\int_{\mathcal{S}^{d}}\log U_{\mu^{*}}(u)\mathop{}\!\mathrm{d}\mu^{*}(u)+\int_{\mathcal{S}^{d}}\frac{U_{\mu^{*}_{T}}(u)-U_{\mu^{*}}(u)}{U_{\mu^{*}}(u)}\mathop{}\!\mathrm{d}\mu^{*}(u)
		$$
		 
		$$
		\displaystyle\qquad\qquad+\int_{\mathcal{S}^{d}}\log U_{\mu^{*}}(u)\mathop{}\!\mathrm{d}\mu^{*}_{T}(u)+0\cdot\int_{\mathcal{S}^{d}}\frac{U_{\mu^{*}_{T}}(u)-U_{\mu^{*}}(u)}{U_{\mu^{*}}(u)}\mathop{}\!\mathrm{d}\mu^{*}_{T}(u)
		$$
		 
		$$
		\displaystyle=\int_{\mathcal{S}^{d}}\frac{U_{\mu^{*}_{T}}(u)}{U_{\mu^{*}}(u)}\mathop{}\!\mathrm{d}\mu^{*}(u)+\int_{\mathcal{S}^{d}}\log U_{\mu^{*}}(u)\mathop{}\!\mathrm{d}(\mu^{*}_{T}-\mu^{*})(u)-1,
		$$
		where the Leibniz rule along with the boundedness of $U_{\mu^{*}}$ and $U_{\mu^{*}_{T_{n}}}$ together justify the exchanges of integration and differentiation.
		Let $\{T_{n}\}_{n=1}^{\infty}$ be a sequence of sets in $\mathcal{T}$ such that
		$$
		\lim_{n\rightarrow\infty}\int_{\mathcal{S}^{d}}U_{\mu^{*}}(u)\mathop{}\!\mathrm{d}\mu_{T_{n}}^{*}(u)=\sup_{T\in\mathcal{T}}\int_{\mathcal{S}^{d}}U_{\mu^{*}}(u)\mathop{}\!\mathrm{d}\mu_{T}^{*}(u)\triangleq U^{*},
		$$
		where the supremum must exist since $U_{\mu^{*}}$ is bounded above.
		Because $U_{\mu^{*}}$ is a continuous and Borel measurable function, we have $\{u\colon U_{\mu^{*}}(u)>U^{*}\}\in\mathcal{B}(\mathcal{S}^{d})$ and thus
		$$
		\displaystyle\mu^{*}(\{u\colon U_{\mu^{*}}(u)>U^{*}\})
		$$
		 
		$$
		\displaystyle=0,
		$$
		$$
		\displaystyle\mu^{*}_{T_{n}}(\{u\colon U_{\mu^{*}}(u)>U^{*}\})
		$$
		 
		$$
		\displaystyle=0,
		$$
		$$
		\displaystyle\forall n=1,2,\dots,
		$$
		otherwise $\{u\colon U_{\mu^{*}}(u)>U^{*}\}\in\mathcal{T}$, contradicting the definition of $U^{*}$ as the supremum.
		Asymptotically, $U_{\mu^{*}}$ is constant $\mu^{*}_{T_{n}}$ -almost surely:
		$$
		\displaystyle\int_{\mathcal{S}^{d}}\left\lvert U_{\mu^{*}}(u)-\int_{\mathcal{S}^{d}}U_{\mu^{*}}(u^{\prime})\mathop{}\!\mathrm{d}\mu_{T_{n}}^{*}(u^{\prime})\right\rvert\mathop{}\!\mathrm{d}\mu_{T_{n}}^{*}(u)
		$$
		 
		$$
		\displaystyle\qquad\qquad=2\int_{\mathcal{S}^{d}}\max\left(0,~U_{\mu^{*}}(u)-\int_{\mathcal{S}^{d}}U_{\mu^{*}}(u^{\prime})\mathop{}\!\mathrm{d}\mu_{T_{n}}^{*}(u^{\prime})\right)\mathop{}\!\mathrm{d}\mu_{T_{n}}^{*}(u)
		$$
		 
		$$
		\displaystyle\qquad\qquad\leq 2(U^{*}-\int_{\mathcal{S}^{d}}U_{\mu^{*}}(u)\mathop{}\!\mathrm{d}\mu_{T_{n}}^{*}(u))
		$$
		 
		$$
		\displaystyle\qquad\qquad\rightarrow 0,
		$$
		$$
		n\rightarrow\infty
		$$
		where the inequality follows the boundedness of $U_{\mu^{*}}$ and that $\mu^{*}_{T_{n}}(\{u\colon U_{\mu^{*}}(u)>U^{*}\})=0$.
		Therefore, given the continuity of $\log$ and the boundedness of $U_{\mu^{*}}$, we have
		$$
		\lim_{n\rightarrow\infty}\int_{\mathcal{S}^{d}}\log U_{\mu^{*}}(u)\mathop{}\!\mathrm{d}\mu_{T_{n}}^{*}=\log U^{*}.
		$$
		Equation 15 gives that $\forall n=1,2,\dots$,
		$$
		\displaystyle 1
		$$
		 
		$$
		\displaystyle=\int_{\mathcal{S}^{d}}\frac{U_{\mu_{T_{n}}^{*}}(u)}{U_{\mu^{*}}(u)}\mathop{}\!\mathrm{d}\mu^{*}+\int_{\mathcal{S}^{d}}\log U_{\mu^{*}}(u)\mathop{}\!\mathrm{d}(\mu_{T_{n}}^{*}-\mu^{*})
		$$
		 
		$$
		\displaystyle\geq\frac{1}{U^{*}}\int_{\mathcal{S}^{d}}U_{\mu_{T_{n}}^{*}}(u)\mathop{}\!\mathrm{d}\mu^{*}(u)+\int_{\mathcal{S}^{d}}\log U_{\mu^{*}}(u)\mathop{}\!\mathrm{d}\mu_{T_{n}}^{*}-\int_{\mathcal{S}^{d}}\log U_{\mu^{*}}(u)\mathop{}\!\mathrm{d}\mu^{*}
		$$
		 
		$$
		\displaystyle=\frac{1}{U^{*}}\int_{\mathcal{S}^{d}}U_{\mu^{*}}(u)\mathop{}\!\mathrm{d}\mu_{T_{n}}^{*}(u)+\int_{\mathcal{S}^{d}}\log U_{\mu^{*}}(u)\mathop{}\!\mathrm{d}\mu_{T_{n}}^{*}-\int_{\mathcal{S}^{d}}\log U_{\mu^{*}}(u)\mathop{}\!\mathrm{d}\mu^{*},
		$$
		where the inequality follows the boundedness of $\frac{U_{\mu_{T_{n}}^{*}}}{U_{\mu^{*}}}$ and that $\mu^{*}(\{u\colon U_{\mu^{*}}(u)>U^{*}\})=0$.
		Taking the limit of $n\rightarrow\infty$ on both sides, we have
		$$
		\displaystyle 1=\lim_{n\rightarrow\infty}1
		$$
		 
		$$
		\displaystyle\geq\frac{1}{U^{*}}\lim_{n\rightarrow\infty}\int_{\mathcal{S}^{d}}U_{\mu^{*}}(u)\mathop{}\!\mathrm{d}\mu_{T_{n}}^{*}(u)+\lim_{n\rightarrow\infty}\int_{\mathcal{S}^{d}}\log U_{\mu^{*}}(u)\mathop{}\!\mathrm{d}\mu_{T_{n}}^{*}(u)-\int_{\mathcal{S}^{d}}\log U_{\mu^{*}}(u)\mathop{}\!\mathrm{d}\mu^{*}(u)
		$$
		 
		$$
		\displaystyle=1+\log U^{*}-\int_{\mathcal{S}^{d}}\log U_{\mu^{*}}(u)\mathop{}\!\mathrm{d}\mu^{*}(u)
		$$
		 
		$$
		\displaystyle\geq 1+\log U^{*}-\log\int_{\mathcal{S}^{d}}U_{\mu^{*}}(u)\mathop{}\!\mathrm{d}\mu^{*}(u)
		$$
		 
		$$
		\displaystyle\geq 1,
		$$
		where the last inequality holds because the supremum taken over $\mathcal{T}\supset\{\mathcal{S}^{d}\}$.
		Since $1=1$, all inequalities must be equalities. In particular,
		$$
		\int_{\mathcal{S}^{d}}\log U_{\mu^{*}}(u)\mathop{}\!\mathrm{d}\mu^{*}(u)=\log\int_{\mathcal{S}^{d}}U_{\mu^{*}}(u)\mathop{}\!\mathrm{d}\mu^{*}(u).
		$$
		That is, for any solution $\mu^{*}$ of Equation 13, $U_{\mu^{*}}$ must be constant $\mu^{*}$ -almost surely.
	3. We show that $\sigma_{d}$ is the unique minimizer of the relaxed problem in Equation 13.
		Let $S\subset\mathcal{M}(\mathcal{S}^{d})$ be the set of measures where the above property holds:
		$$
		S\triangleq\left\{\mu\in\mathcal{M}(\mathcal{S}^{d})\colon U_{\mu}\text{ is constant $\mu$-almost surely}\right\}.
		$$
		The problem in Equation 13 is thus equivalent to minimizing over $S$:
		$$
		\displaystyle\argmin_{\mu\in\mathcal{M}(\mathcal{S}^{d})}\int_{\mathcal{S}^{d}}\log U_{\mu}(u)\mathop{}\!\mathrm{d}\mu(u)
		$$
		 
		$$
		\displaystyle=\argmin_{\mu\in S}\int_{\mathcal{S}^{d}}\log U_{\mu}(u)\mathop{}\!\mathrm{d}\mu(u)
		$$
		 
		$$
		\displaystyle=\argmin_{\mu\in S}\log\int_{\mathcal{S}^{d}}U_{\mu}(u)\mathop{}\!\mathrm{d}\mu(u)
		$$
		 
		$$
		\displaystyle=\argmin_{\mu\in S}\log\int_{\mathcal{S}^{d}}\int_{\mathcal{S}^{d}}e^{u^{\mathsf{T}}v/\tau}\mathop{}\!\mathrm{d}\mu(v)\mathop{}\!\mathrm{d}\mu(u)
		$$
		 
		$$
		\displaystyle=\argmin_{\mu\in S}\left(\frac{1}{\tau}+\log\int_{\mathcal{S}^{d}}\int_{\mathcal{S}^{d}}e^{-\frac{1}{2\tau}\left\lVert u-v\right\rVert^{2}}\mathop{}\!\mathrm{d}\mu(v)\mathop{}\!\mathrm{d}\mu(u)\right)
		$$
		 
		$$
		\displaystyle=\argmin_{\mu\in S}\int_{\mathcal{S}^{d}}\int_{\mathcal{S}^{d}}G_{\frac{1}{2\tau}}(u,v)\mathop{}\!\mathrm{d}\mu(v)\mathop{}\!\mathrm{d}\mu(u).
		$$
		By Proposition 1 and $\tau>0$, we know that the uniform distribution $\sigma_{d}$ is the unique solution to
		$$
		\argmin_{\mu\in\mathcal{M}(\mathcal{S}^{d})}\int_{\mathcal{S}^{d}}\int_{\mathcal{S}^{d}}G_{\frac{1}{2\tau}}(u,v)\mathop{}\!\mathrm{d}\mu(v)\mathop{}\!\mathrm{d}\mu(u).
		$$
		Since $\sigma_{d}\in S$, it must also be the unique solution to Equation 13.
	Finally, if perfectly uniform encoders exist, $\sigma_{d}$ is realizable, and they are the exact encoders that realize it. Hence, in such cases, they are the exact minimizers of
	$$
	\min_{f}\underset{{x\sim p_{\mathsf{data}}}}{\mathbb{E}}\hskip-3.0pt\left[{\log\underset{{x^{-}\sim p_{\mathsf{data}}}}{\mathbb{E}}\hskip-3.0pt\left[{e^{f(x^{-})^{\mathsf{T}}f(x)/\tau}}\right]}\right].
	$$

∎

##### Relation between, ℒ𝖺𝗅𝗂𝗀𝗇\\mathcal{L}\_{\\mathsf{align}} and ℒ𝗎𝗇𝗂𝖿𝗈𝗋𝗆\\mathcal{L}\_{\\mathsf{uniform}}.

The first term of Equation 2 is equivalent with $\mathcal{L}_{\mathsf{align}}$ when $\alpha=2$, up to a constant and a scaling. In the above proof, we showed that the second term favors uniformity, via the feature distribution that minimizes the pairwise Gaussian kernel (see Equation 16):

$$
\argmin_{\mu\in\mathcal{M}(\mathcal{S}^{d})}\int_{\mathcal{S}^{d}}\int_{\mathcal{S}^{d}}G_{\frac{1}{2\tau}}(u,v)\mathop{}\!\mathrm{d}\mu(v)\mathop{}\!\mathrm{d}\mu(u),
$$

which can be alternatively viewed as the relaxed problem of optimizing for the uniformity loss $\mathcal{L}_{\mathsf{uniform}}$:

$$
\argmin_{f}\mathcal{L}_{\mathsf{uniform}}(f;\frac{1}{2\tau})=\argmin_{f}\mathbb{E}_{x,y\overset{\text{i.i.d.}}{\sim}p_{\mathsf{data}}}\left[{G_{\frac{1}{2\tau}}(f(x),f(y))}\right].
$$

The relaxation comes from the observation that Equation 17 minimizes over all feature distributions on $\mathcal{S}^{d}$, while Equation 18 only considers the realizable ones.

##### Relation between and minimizing average pairwise Gaussian potential (i.e., minimizing ℒ𝗎𝗇𝗂𝖿𝗈𝗋𝗆\\mathcal{L}\_{\\mathsf{uniform}}).

In view of the Proposition 1 and the proof of Theorem 1, we know that the uniform distribution $\sigma_{d}$ is the unique minimizer of both of the following problems:

$$
\displaystyle\{\sigma_{d}\}
$$
 
$$
\displaystyle=\min_{\mu\in\mathcal{M}(\mathcal{S}^{d})}\log\int_{\mathcal{S}^{d}}\int_{\mathcal{S}^{d}}e^{u^{\mathsf{T}}v/\tau}\mathop{}\!\mathrm{d}\mu(v)\mathop{}\!\mathrm{d}\mu(u),
$$
$$
\displaystyle\{\sigma_{d}\}
$$
 
$$
\displaystyle=\min_{\mu\in\mathcal{M}(\mathcal{S}^{d})}\int_{\mathcal{S}^{d}}\log\int_{\mathcal{S}^{d}}e^{u^{\mathsf{T}}v/\tau}\mathop{}\!\mathrm{d}\mu(v)\mathop{}\!\mathrm{d}\mu(u).
$$

So pushing the $\log$ inside the outer integral doesn’t change the solution. However, if we push the $\log$ all the way inside the inner integral, the problem becomes equivalent with minimizing the norm of the mean, i.e.,

$$
\min_{\mu\in\mathcal{M}(\mathcal{S}^{d})}\mathbb{E}_{U\sim\mu}\left[{U}\right]^{\mathsf{T}}\mathbb{E}_{U\sim\mu}\left[{U}\right],
$$

which is minimized for any distribution with mean being the all-zeros vector $0$, e.g., $\frac{1}{2}\delta_{u}+\frac{1}{2}\delta_{-u}$ for any $u\in\mathcal{S}^{d}$ (where $\delta_{u}$ is the Dirac delta distribution at $u$ s.t. $\delta_{u}(S)=\mathbbm{1}_{S}(u)$, $\forall S\in\mathcal{B}(\mathcal{S}^{d})$). Therefore, the location of the $\log$ is important.

###### Theorem 2 (Single negative sample).

If perfectly aligned and uniform encoders exist, they form the exact minimizers of the contrastive loss $\mathcal{L}_{\mathsf{contrastive}}(f;\tau,M)$ for fixed $\tau>0$ and $M=1$.

###### Proof of.

Since $M=1$, we have

$$
\displaystyle\mathcal{L}_{\mathsf{contrastive}}(f;\tau,1)
$$
 
$$
\displaystyle=\underset{{\begin{subarray}{c}(x,y)\sim p_{\mathsf{pos}}\\
x^{-}\sim p_{\mathsf{data}}\end{subarray}}}{\mathbb{E}}\hskip-3.0pt\left[{-\frac{1}{\tau}f(x)^{\mathsf{T}}f(y)+\log\left(e^{f(x)^{\mathsf{T}}f(y)/\tau}+e^{f(x^{-})^{\mathsf{T}}f(x)/\tau}\right)}\right]
$$
 
$$
\displaystyle\geq\underset{{\begin{subarray}{c}x\sim p_{\mathsf{data}}\\
x^{-}\sim p_{\mathsf{data}}\end{subarray}}}{\mathbb{E}}\hskip-3.0pt\left[{-\frac{1}{\tau}+\log\left(e^{1/\tau}+e^{f(x^{-})^{\mathsf{T}}f(x)/\tau}\right)}\right]
$$
 
$$
\displaystyle\geq-\frac{1}{\tau}+\min_{\mu\in\mathcal{M}(\mathcal{S}^{d})}\int_{\mathcal{S}^{d}}\int_{\mathcal{S}^{d}}\log\left(e^{1/\tau}+e^{u^{\mathsf{T}}v/\tau}\right)\mathop{}\!\mathrm{d}\mu(u)\mathop{}\!\mathrm{d}\mu(v)
$$
 
$$
\displaystyle=-\frac{1}{\tau}+\min_{\mu\in\mathcal{M}(\mathcal{S}^{d})}\int_{\mathcal{S}^{d}}\int_{\mathcal{S}^{d}}\log\left(e^{1/\tau}+e^{(2-\left\lVert u-v\right\rVert_{2}^{2})/(2\tau)}\right)\mathop{}\!\mathrm{d}\mu(u)\mathop{}\!\mathrm{d}\mu(v).
$$

By the definition of perfect alignment, the equality in Equation 19 is satisfied iff $f$ is perfectly aligned.

Consider the function $f\colon(0,4]\rightarrow\mathbb{R}_{+}$ defined as

$$
f(t)=\log(e^{\frac{1}{\tau}}+e^{\frac{2-t}{2\tau}}).
$$

It has the following properties:

- $-f^{\prime}(t)=\frac{1}{2\tau}\frac{e^{-\frac{t}{2\tau}}}{1+e^{-\frac{t}{2\tau}}}=\frac{1}{2\tau}(1-(1+e^{-\frac{t}{2\tau}})^{-1})$ is strictly completely monotone on $(0,+\infty)$:
	$\forall t\in(0,+\infty)$,
	$$
	\displaystyle\frac{1}{2\tau}(1-(1+e^{-\frac{t}{2\tau}})^{-1})
	$$
	 
	$$
	\displaystyle>0
	$$
	 
	$$
	\displaystyle(-1)^{n}\frac{\mathop{}\!\mathrm{d}^{n}}{\mathop{}\!\mathrm{d}t^{n}}\frac{1}{2\tau}(1-(1+e^{-\frac{t}{2\tau}})^{-1})
	$$
	 
	$$
	\displaystyle=\frac{n!}{(2\tau)^{n+1}}(1+e^{-\frac{t}{2\tau}})^{-(n+1)}>0,\qquad\qquad n=1,2,\dots.
	$$
- $f$ is bounded on $(0,4]$.

In view of Lemma 2, we have that the equality in Equation 20 is satisfied iff the feature distribution induced by $f$ (i.e., the pushforward measure $p_{\mathsf{data}}\circ f^{-1}$) is $\sigma_{d}$, that is, in other words, $f$ is perfectly uniform.

Therefore,

$$
\mathcal{L}_{\mathsf{contrastive}}(f;\tau,1)\geq-\frac{1}{\tau}+\int_{\mathcal{S}^{d}}\int_{\mathcal{S}^{d}}\log\left(e^{1/\tau}+e^{u^{\mathsf{T}}v/\tau}\right)\mathop{}\!\mathrm{d}\sigma_{d}(u)\mathop{}\!\mathrm{d}\sigma_{d}(v)=\text{constant independent of $f$},
$$

where equality is satisfied iff $f$ is perfectly aligned and uniform. This concludes the proof. ∎

##### Difference between conditions of Theorems and.

We remark that the statement in Theorem 2 is weaker than the previous Theorem 1. Theorem 2 is conditioned on the existence perfectly aligned and uniform encoders. It only shows that $\mathcal{L}_{\mathsf{contrastive}}(f;\tau,M=1)$ favors alignment under the condition that perfect uniformity is realizable, and vice versa. In Theorem 1, $\mathcal{L}_{\mathsf{contrastive}}$ decomposes into two terms, each favoring alignment and uniformity. Therefore, the decomposition in Theorem 1 is exempof t from this constraint.

## Appendix B Experiment Details

All experiments are performed on 1-4 NVIDIA Titan Xp, Titan X PASCAL, Titan RTX, or 2080 Ti GPUs.

### B.1 CIFAR-10, STL-10 and NYU-Depth-V2 Experiments

For CIFAR-10, STL-10 and NYU-Depth-V2 experiments, we use the following settings, unless otherwise stated in Tables and 9 below:

- Standard data augmentation procedures are used for generating positive pairs, including resizing, cropping, horizontal flipping, color jittering, and random grayscale conversion. This follows prior empirical work in contrastive representation learning [^61] [^54] [^28] [^2].
- Neural network architectures follow the corresponding experiments on these datasets in [^54]. For NYU-Depth-V2 evaluation, the architecture of the depth prediction CNN is described in Table 6.
- We use minibatch stochastic gradient descent (SGD) with $0.9$ momentum and $0.0001$ weight decay.
- We use linearly scaled learning rate ($0.12$ per $256$ batch size) [^18].
	- CIFAR-10 and STL-10: Optimization is done over $200$ epochs, with learning rate decayed by a factor of $0.1$ at epochs $155$, $170$, and $185$.
	- NYU-Depth-V2: Optimization is done over $400$ epochs, with learning rate decayed by a factor of $0.1$ at epochs $310$, $340$, and $370$.
- Encoders are optimized over the training split. For evaluation, we freeze the encoder, and train classifiers / depth predictors on the training set samples, and test on the validation split.
	- CIFAR-10 and STL-10: We use standard train-val split. Linear classifiers are trained with Adam [^31] over $100$ epochs, with $\beta_{1}=0.5,\beta_{2}=0.999,\epsilon=10^{-8}$, $128$ batch size, and an initial learning rate of $0.001$, decayed by a factor of $0.2$ at epochs $60$ and $80$.
	- NYU-Depth-V2: We use the train-val split on the $1449$ labeled images from [^42]. Depth predictors are trained with Adam [^31] over $120$ epochs, with $\beta_{1}=0.5,\beta_{2}=0.999,\epsilon=10^{-8}$, $128$ batch size, and an initial learning rate of $0.003$, decayed by a factor of $0.2$ at epochs $70$, $90$, $100$, and $110$.

| Operator | Input Spatial Shape | Input #Channel | Kernel Size | Stride | Padding | Output Spatial Shape | Output #Channel |
| --- | --- | --- | --- | --- | --- | --- | --- |
| Input | $[h_{\mathsf{in}},w_{\mathsf{in}}]$ | $c_{\mathsf{in}}$ | — | — | — | $[h_{\mathsf{in}},w_{\mathsf{in}}]$ | $c_{\mathsf{in}}$ |
| Conv. Transpose + BN + ReLU | $[h_{\mathsf{in}},w_{\mathsf{in}}]$ | $c_{\mathsf{in}}$ | 3 | 2 | 1 | $[2h_{\mathsf{in}},2w_{\mathsf{in}}]$ | $\left\lfloor c_{\mathsf{in}}/2\right\rfloor$ |
| Conv. Transpose + BN + ReLU | $[2h_{\mathsf{in}},2w_{\mathsf{in}}]$ | $\left\lfloor c_{\mathsf{in}}/2\right\rfloor$ | 3 | 2 | 1 | $[4h_{\mathsf{in}},4w_{\mathsf{in}}]$ | $\left\lfloor c_{\mathsf{in}}/4\right\rfloor$ |
| $\vdots$ | $\vdots$ | $\vdots$ | $\vdots$ | $\vdots$ | $\vdots$ | $\vdots$ | $\vdots$ |
| Conv. Transpose + BN + ReLU | $[h_{\mathsf{out}}/2,w_{\mathsf{out}}/2]$ | $\left\lfloor c_{\mathsf{in}}/2^{n-1}\right\rfloor$ | 3 | 2 | 1 | $[h_{\mathsf{out}},w_{\mathsf{out}}]$ | $\left\lfloor c_{\mathsf{in}}/2^{n}\right\rfloor$ |
| Conv. | $[h_{\mathsf{out}},w_{\mathsf{out}}]$ | $\left\lfloor c_{\mathsf{in}}/2^{n}\right\rfloor$ | 3 | 1 | 1 | $[h_{\mathsf{out}},w_{\mathsf{out}}]$ | $1$ |

Table 6: NYU-Depth-V2 CNN depth predictor architecture. Each Conv. Transpose+BN+ReLU block increases the spatial shape by a factor of $2$, where BN denotes Batch Normalization [^30]. A sequence of such blocks computes a tensor of the correct spatial shape, from an input containing intermediate activations of a CNN encoder (which downsamples the input RGB image by a power of $2$). A final convolution at the end computes the single-channel depth prediction.

At each SGD iteration, a minibatch of $K$ positive pairs is sampled $\{(x_{i},y_{i})\}_{i=1}^{K}$, and the three losses for this minibatch are calculated as following:

- $\mathcal{L}_{\mathsf{contrastive}}$: For each $x_{i}$, the sample contrastive loss is taken with the positive being $y_{i}$, and the negatives being $\{y_{j}\}_{j\neq i}$. For each $y_{i}$, the sample loss is computed similarly. The minibatch loss is calculated by aggregating these $2K$ terms:
	$$
	\frac{1}{2K}\sum_{i=1}^{K}\log\frac{e^{f(x_{i})^{\mathsf{T}}f(y_{i})/\tau}}{\sum_{j=1}^{K}e^{f(x_{i})^{\mathsf{T}}f(y_{j})/\tau}}+\frac{1}{2K}\sum_{i=1}^{K}\log\frac{e^{f(x_{i})^{\mathsf{T}}f(y_{i})/\tau}}{\sum_{j=1}^{K}e^{f(x_{j})^{\mathsf{T}}f(y_{i})/\tau}}.
	$$
	This calculation follows empirical practices and is similar to [^43] [^26], and end-to-end in [^25].
- $\mathcal{L}_{\mathsf{align}}$: The minibatch alignment loss is straightforwardly computed as
	$$
	\frac{1}{K}\sum_{i=1}^{K}\left\lVert f(x_{i})-f(y_{i})\right\rVert_{2}^{\alpha}.
	$$
- $\mathcal{L}_{\mathsf{uniform}}$: The minibatch uniform loss is calculated by considering each pair of $\{x_{i}\}_{i}$ and $\{y_{i}\}_{i}$:
	$$
	\frac{1}{2}\log\bigg(\frac{2}{K(K-1)}\sum_{i\neq j}e^{-t\left\lVert f(x_{i})-f(x_{j})\right\rVert_{2}^{2}}\bigg)+\frac{1}{2}\log\bigg(\frac{2}{K(K-1)}\sum_{i\neq j}e^{-t\left\lVert f(y_{i})-f(y_{j})\right\rVert_{2}^{2}}\bigg).
	$$

Tables and 9 below describe the full specifications of all $304$ STL-10 and $64$ NYU-Depth-V2 encoders. These experiment results are visualized in main paper Figure 5, showing a clear connection between representation quality and $\mathcal{L}_{\mathsf{align}}$ & $\mathcal{L}_{\mathsf{uniform}}$ metrics.

<table><thead><tr><th colspan="10">ImageNet-100 Classes</th></tr></thead><tbody><tr><td>n02869837</td><td>n01749939</td><td>n02488291</td><td>n02107142</td><td>n13037406</td><td>n02091831</td><td>n04517823</td><td>n04589890</td><td>n03062245</td><td>n01773797</td></tr><tr><td>n01735189</td><td>n07831146</td><td>n07753275</td><td>n03085013</td><td>n04485082</td><td>n02105505</td><td>n01983481</td><td>n02788148</td><td>n03530642</td><td>n04435653</td></tr><tr><td>n02086910</td><td>n02859443</td><td>n13040303</td><td>n03594734</td><td>n02085620</td><td>n02099849</td><td>n01558993</td><td>n04493381</td><td>n02109047</td><td>n04111531</td></tr><tr><td>n02877765</td><td>n04429376</td><td>n02009229</td><td>n01978455</td><td>n02106550</td><td>n01820546</td><td>n01692333</td><td>n07714571</td><td>n02974003</td><td>n02114855</td></tr><tr><td>n03785016</td><td>n03764736</td><td>n03775546</td><td>n02087046</td><td>n07836838</td><td>n04099969</td><td>n04592741</td><td>n03891251</td><td>n02701002</td><td>n03379051</td></tr><tr><td>n02259212</td><td>n07715103</td><td>n03947888</td><td>n04026417</td><td>n02326432</td><td>n03637318</td><td>n01980166</td><td>n02113799</td><td>n02086240</td><td>n03903868</td></tr><tr><td>n02483362</td><td>n04127249</td><td>n02089973</td><td>n03017168</td><td>n02093428</td><td>n02804414</td><td>n02396427</td><td>n04418357</td><td>n02172182</td><td>n01729322</td></tr><tr><td>n02113978</td><td>n03787032</td><td>n02089867</td><td>n02119022</td><td>n03777754</td><td>n04238763</td><td>n02231487</td><td>n03032252</td><td>n02138441</td><td>n02104029</td></tr><tr><td>n03837869</td><td>n03494278</td><td>n04136333</td><td>n03794056</td><td>n03492542</td><td>n02018207</td><td>n04067472</td><td>n03930630</td><td>n03584829</td><td>n02123045</td></tr><tr><td>n04229816</td><td>n02100583</td><td>n03642806</td><td>n04336792</td><td>n03259280</td><td>n02116738</td><td>n02108089</td><td>n03424325</td><td>n01855672</td><td>n02090622</td></tr></tbody></table>

Table 7: $100$ randomly selected ImageNet classes forming the ImageNet-100 subset. These classes are the same as the ones used by [^54].

### B.2 ImageNet and ImageNet-100 with Momentum Contrast (MoCo) Variants

##### MoCo and MoCo v2 with ℒ𝖺𝗅𝗂𝗀𝗇\\mathcal{L}\_{\\mathsf{align}} and ℒ𝗎𝗇𝗂𝖿𝗈𝗋𝗆\\mathcal{L}\_{\\mathsf{uniform}}.

At each SGD iteration, let

- $K$ be the minibatch size,
- $\{f(x_{i})_{i}\}_{i=1}^{K}$ be the batched query features encoded by the current up-to-date encoder $f$ (i.e., $\mathtt{q}$ in Algorithm 1 of [^25]),
- $\{f_{\textsf{EMA}}(y_{i})\}_{i=1}^{K}$ be the batched key features encoded by the exponential moving average encoder $f_{\textsf{EMA}}$ (i.e., $\mathtt{k}$ in Algorithm 1 of [^25]),
- $\{\mathtt{queue}_{j}\}_{j=1}^{N}$ be the feature queue, where $N$ is the queue size.

$\mathcal{L}_{\mathsf{align}}$ and $\mathcal{L}_{\mathsf{uniform}}$ for this minibatch are calculated as following:

- $\mathcal{L}_{\mathsf{align}}$: The minibatch alignment loss is computed as disparity between features from the two encoders:
	$$
	\frac{1}{K}\sum_{i=1}^{K}\left\lVert f(x_{i})-f_{\textsf{EMA}}(y_{i})\right\rVert_{2}^{\alpha}.
	$$
- $\mathcal{L}_{\mathsf{uniform}}$: We experiment with two forms of $\mathcal{L}_{\mathsf{uniform}}$:
	1. Only computing pairwise distance between $\{f(x_{i})\}_{i}$ and $\{\mathtt{queue}_{j}\}_{j}$:
		$$
		\log\bigg(\frac{1}{NK}\sum_{i=1}^{K}\sum_{j=1}^{N}e^{-t\left\lVert f(x_{i})-\mathtt{queue}_{j}\right\rVert_{2}^{2}}\bigg).
		$$
	2. Also computing pairwise distance inside $\{f(x_{i})\}_{i}$:
		$$
		\log\bigg(\frac{2}{2NK+K(K-1)}\sum_{i=1}^{K}\sum_{j=1}^{N}e^{-t\left\lVert f(x_{i})-\mathtt{queue}_{j}\right\rVert_{2}^{2}}+\frac{2}{2NK+K(K-1)}\sum_{i\neq j}e^{-t\left\lVert f(x_{i})-f(x_{j})\right\rVert_{2}^{2}}\bigg).
		$$

#### B.2.1 ImageNet-100 with MoCo

##### ImageNet-100 details.

We use the same ImageNet-100 sampled by [^54], containing the $100$ randomly selected classes listed in Table 7.

##### MoCo settings.

Our MoCo experiment settings below mostly follow [^25] and the unofficial implementation by [^53], because the official implementation was not released at the time of performing these analyses:

- Standard data augmentation procedures are used for generating positive pairs, including resizing, cropping, horizontal flipping, color jittering, and random grayscale conversion, following [^53].
- Encoder architecture is ResNet50 [^24].
- We use minibatch stochastic gradient descent (SGD) with $128$ batch size, $0.03$ initial learning rate, $0.9$ momentum and $0.0001$ weight decay.
- Optimization is done over $240$ epochs, with learning rate decayed by a factor of $0.1$ at epochs $120$, $160$, and $200$.
- We use $0.999$ exponential moving average factor, following [^25].
- For evaluation, we freeze the encoder, and train a linear classifier on the training set samples, and test on the validation split. Linear classifiers are trained with minibatch SGD over $60$ epochs, with $256$ batch size, and an initial learning rate of $10$, decayed by a factor of $0.2$ at epochs $30$, $40$, and $50$.

Table 10 below describes the full specifications of all $45$ ImageNet-100 encoders. These experiment results are visualized in main paper Figure 9(a), showing a clear connection between representation quality and $\mathcal{L}_{\mathsf{align}}$ & $\mathcal{L}_{\mathsf{uniform}}$ metrics.

#### B.2.2 ImageNet with MoCo v2

##### MoCo v2 settings.

Our MoCo v2 experiment settings directly follow [^9] and the official implementation [^10]:

- Standard data augmentation procedures are used for generating positive pairs, including resizing, cropping, horizontal flipping, color jittering, random grayscale conversion, and random Gaussian blurring, following [^10].
- Encoder architecture is ResNet50 [^24].
- We use minibatch stochastic gradient descent (SGD) with $256$ batch size, $0.03$ initial learning rate, $0.9$ momentum and $0.0001$ weight decay.
- Optimization is done over $200$ epochs, with learning rate decayed by a factor of $0.1$ at epochs $120$ and $160$.
- We use $0.999$ exponential moving average factor, $65536$ queue size, $128$ feature dimensions.
- For evaluation, we freeze the encoder, and train a linear classifier on the training set samples, and test on the validation split. Linear classifiers are trained with minibatch SGD over $100$ epochs, with $256$ batch size, and an initial learning rate of $30$, decayed by a factor of $0.1$ at epochs $60$ and $80$.

Unlike the MoCo experiments on ImageNet-100, which were based on unofficial implementations for reasons stated in Sec. B.2.1, the MoCo v2 experiments on full ImageNet were based on the official implementation by [^10]. We provide a reference implementation that can fully reproduce the results in Table 5 at [https://github.com/SsnL/moco\_align\_uniform](https://github.com/SsnL/moco_align_uniform), where we also provide a model checkpoint (trained using $\mathcal{L}_{\mathsf{align}}$ and $\mathcal{L}_{\mathsf{uniform}}$) of $67.694\%$ validation top1 accuracy.

### B.3 BookCorpus with Quick-Thought Vectors Variants

##### BookCorpus details.

Since the original BookCorpus dataset [^63] is not distributed anymore, we use the unofficial code by [^33] to recreate our copy. Our copy ended up containing $52{,}799{,}513$ training sentences and $50{,}000$ validation sentences, compared to the original copy used by Quick-Thought Vectors [^40], which contains $45{,}786{,}400$ training sentences and $50{,}000$ validation sentences.

##### Quick-Thought Vectors with ℒ𝖺𝗅𝗂𝗀𝗇\\mathcal{L}\_{\\mathsf{align}} and ℒ𝗎𝗇𝗂𝖿𝗈𝗋𝗆\\mathcal{L}\_{\\mathsf{uniform}}.

With Quick-Thought Vectors, the positive pairs are the neighboring sentences. At each optimization iteration, let

- $\{x_{i}\}_{i=1}^{K}$ be the $K$ *consecutive* sentences forming this minibatch, where $K$ be the minibatch size,
- $f$ and $g$ be the two RNN sentence encoders.

The original Quick-Thought Vectors [^40] does not $l2$ -normalize on encoder outputs during training the encoder. Here we describe the calculation of $\mathcal{L}_{\mathsf{contrastive}}$, $\mathcal{L}_{\mathsf{align}}$, and $\mathcal{L}_{\mathsf{uniform}}$ for $l2$ -normalized encoders, in our modified Quick-Thought Vectors method. Note that this does not affect evaluation since features are $l2$ -normalized before using in downstream tasks, following the original Quick-Thought Vectors [^40]. For a minibatch, these losses are calculated as following:

- $\mathcal{L}_{\mathsf{contrastive}}$ with temperature:
	$$
	\displaystyle\frac{1}{K}~\mathtt{cross\_entropy}(\mathtt{softmax}(\{f(x_{1})^{\mathsf{T}}g(x_{j})\}_{j}),\{0,1,0,\dots,0\})
	$$
	 
	$$
	\displaystyle\qquad+\frac{1}{K}\sum_{i=2}^{K-1}\mathtt{cross\_entropy}(\mathtt{softmax}(\{f(x_{i})^{\mathsf{T}}g(x_{j})\}_{j}),\{\underbrace{0,\dots,0}_{\text{$(i-2)$ $0$'s}},\frac{1}{2},0,\frac{1}{2},\underbrace{0,\dots,0}_{\text{$(K-i-1)$ $0$'s}}\})+
	$$
	 
	$$
	\displaystyle\qquad+\frac{1}{K}~\mathtt{cross\_entropy}(\mathtt{softmax}(\{f(x_{K})^{\mathsf{T}}g(x_{j})\}_{j}),\{0,\dots,1,0\}).
	$$
	This is almost identical with the original contrastive loss used by Quick-Thought Vectors, except that this does not additionally manually masks out the entries $f(x_{i})^{\mathsf{T}}g(x_{i})$ with zeros, which is unnecessary with $l2$ -normalization.
- $\mathcal{L}_{\mathsf{align}}$: The minibatch alignment loss is computed as disparity between features from the two encoders encoding neighboring sentences (assuming $K>=2$):
	$$
	\frac{1}{K}\left\lVert f(x_{1})-g(x_{2})\right\rVert_{2}^{\alpha}+\frac{1}{2K}\sum_{i=2}^{K-2}\left(\left\lVert f(x_{i-1})-g(x_{i})\right\rVert_{2}^{\alpha}+\left\lVert f(x_{i})-g(x_{i+1})\right\rVert_{2}^{\alpha}\right)+\frac{1}{K}\left\lVert f(x_{K-1})-g(x_{K})\right\rVert_{2}^{\alpha}.
	$$
- $\mathcal{L}_{\mathsf{uniform}}$: We combine the uniformity losses for each of $f$ and $g$ by summing them (instead of averaging since $f$ and $g$ are two different encoders):
	$$
	\frac{2}{K(K-1)}\sum_{i\neq j}e^{-t\left\lVert f(x_{i})-f(x_{j})\right\rVert_{2}^{2}}+\frac{2}{K(K-1)}\sum_{i\neq j}e^{-t\left\lVert g(x_{i})-g(x_{j})\right\rVert_{2}^{2}}.
	$$

Our experiment settings below mostly follow the official implementation by [^40]:

- Sentence encoder architecture is bi-directional Gated Recurrent Unit (GRU) [^11] with inputs from a $620$ -dimensional word embedding trained jointly from scratch.
- We use Adam [^31] with $\beta_{1}=0.9,\beta_{2}=0.999,\epsilon=10^{-8}$, $400$ batch size, $0.0005$ constant learning rate, and $0.5$ gradient norm clipping.
- Optimization is done during $1$ epoch over the training data.
- For evaluation on a binary classification task, we freeze the encoder, and fit a logistic classifier with $l2$ regularization on the encoder outputs. A $10$ -fold cross validation is performed to determine the regularization strength among $\{1,2^{-1},\dots,2^{-8}\}$, following [^32] and [^40]. The classifier is finally tested on the validation split.

Table 11 below describes the full specifications of all $108$ BookCorpus encoders along with $6$ settings that lead to training instability (i.e., $\mathtt{NaN}$ occurring). These experiment results are visualized in main paper Figure 9(b), showing a clear connection between representation quality and $\mathcal{L}_{\mathsf{align}}$ & $\mathcal{L}_{\mathsf{uniform}}$ metrics. For the unnormalized encoders, the features are normalized before calculated $\mathcal{L}_{\mathsf{align}}$ and $\mathcal{L}_{\mathsf{uniform}}$ metrics, since they are nonetheless still normalized before being used in downstream tasks [^40].

Table 8: Experiment specifications for all $304$ STL-10 encoders. We report the encoder representation quality measured by accuracy of linear and $k$ -nearest neighbor ($k$ -NN) with $k=5$ classifiers on either encoder outputs or fc7 activations, via both a $5$ -fold cross validation of the training set and the held out validation set. For encoder initialization, “rand” refers to standard network initialization, and symbols denote finetuning from a pretrained encoder, obtained via the experiment row marked with the same symbol. Initial learning rates (LRs) are usually either fixed as $0.12$ or computed via a linear scaling ($0.12$ per $256$ batch size). Dimensionality (abbreviated as “Dim.”) shows the ambient dimension of the output features, i.e., they live on the unit hypersphere of one less dimension. The last three rows show encoders that are used to initialize finetuning, but are not part of the $285$ encoders plotted in main paper Figure 3, due to their unusual batch size of $786$. Their accuracy and $\mathcal{L}_{\mathsf{align}}$ & $\mathcal{L}_{\mathsf{uniform}}$ metrics follow the same trend shown in Figure 5(a).
