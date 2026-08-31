---
title: "Understanding Self-Supervised Learning Dynamics without Contrastive Pairs"
source: "https://ar5iv.labs.arxiv.org/html/2102.06810"
author:
published:
created: 2026-08-31
description: "While contrastive approaches of self-supervised learning (SSL) learn representations by minimizing the distance between two augmented views of the same data point (positive pairs) and maximizing views from different da…"
tags:
  - "clippings"
---
Yuandong Tian Affiliation: Facebook AI Research Correspondence to: [yuandong@fb.com](mailto:yuandong@fb.com)    Xinlei Chen Affiliation: Facebook AI Research    Surya Ganguli Affiliation: Facebook AI Research Affiliation: Stanford University

## Supplementary Materials for “Understanding Self-Supervised Learning Dynamics without Contrastive Pairs”

Yuandong Tian Affiliation: Facebook AI Research Correspondence to: [yuandong@fb.com](mailto:yuandong@fb.com)    Xinlei Chen Affiliation: Facebook AI Research    Surya Ganguli Affiliation: Facebook AI Research Affiliation: Stanford University

###### Abstract

While contrastive approaches of self-supervised learning (SSL) learn representations by minimizing the distance between two augmented views of the same data point (positive pairs) and maximizing views from different data points (negative pairs), recent *non-contrastive* SSL (e.g., BYOL and SimSiam) show remarkable performance without negative pairs, with an extra learnable predictor and a stop-gradient operation. A fundamental question arises: why do these methods not collapse into trivial representations? We answer this question via a simple theoretical study and propose a novel approach, DirectPred, that *directly* sets the linear predictor based on the statistics of its inputs, without gradient training. On ImageNet, it performs comparably with more complex two-layer non-linear predictors that employ BatchNorm and outperforms a linear predictor by $2.5\%$ in 300-epoch training (and $5\%$ in 60-epoch). DirectPred is motivated by our theoretical study of the nonlinear learning dynamics of non-contrastive SSL in simple linear networks. Our study yields conceptual insights into how non-contrastive SSL methods learn, how they avoid representational collapse, and how multiple factors, like predictor networks, stop-gradients, exponential moving averages, and weight decay all come into play. Our simple theory recapitulates the results of real-world ablation studies in both STL-10 and ImageNet. Code is released <sup>1</sup>.

###### Keywords:

Machine Learning, ICML

## 1 Introduction

Self-supervised learning (SSL) has emerged as a powerful method for learning useful representations without requiring expensive target labels [^12]. Many state-of-the-art SSL methods in computer vision employ the principle of contrastive learning [^25] [^32] [^19] [^7] [^3] whereby the hidden representations of two augmented views of the same object (positive pairs) are brought closer together, while those of different objects (negative pairs) are encouraged to be further apart. Minimizing differences between positive pairs encourages modeling invariances, while contrasting negative pairs is thought to be required to prevent representational collapse (i.e., mapping all data to the same representation).

However, some recent SSL work, notably BYOL [^17] and SimSiam [^8], have shown the remarkable capacity to learn powerful representations using only positive pairs, without ever contrasting negative pairs. These methods employ a dual pair of Siamese networks [^5] (Fig. 1): the representation of two views are trained to match, one obtained by the composition of an online and predictor network, and the other by a target network. The target network is not trained via gradient descent; and either employs a direct copy of the online network (e.g., SimSiam [^8]), or a momentum encoder that slowly follows the online network in a delayed fashion through an exponential moving average (EMA) (e.g., MoCo [^19] [^9] and BYOL [^17]). Compared to contrastive learning, these non-contrastive SSL methods do not require large batch size (e.g., 4096 in SimCLR [^7]) or memory queue (e.g., MoCo [^19] [^9]) to provide negative pairs. Therefore, they are generally more efficient and conceptually simple while maintaining state-of-the-art performance.

Since the entire procedure in non-contrastive SSL encourages the online+predictor network and the target network to become similar to each other, this overall scheme raises several fundamental unsolved theoretical questions. Why/how does it avoid collapsed representations? What is the nature of the learned representations? How do multiple design choices and hyperparameters interact nonlinearly in the learning dynamics? While there are interesting theoretical studies of contrastive SSL [^2] [^24] [^33], any theoretical understanding of the nonlinear learning dynamics of non-contrastive SSL remains open.

![Refer to caption](https://ar5iv.labs.arxiv.org/html/2102.06810/assets/predictor_setting-crop.png)

Figure 1: Two-layer setting with a linear, bias-free predictor.

In this paper, we make a first attempt to analyze the behavior of non-contrastive SSL training and the empirical effects of multiple hyperparameters, including (1) Exponential Moving Average (EMA) or momentum encoder, (2) Higher relative learning rate ($\alpha_{p}$) of the predictor, and (3) Weight decay $\eta$. We explain all these empirical findings with an exceedingly simple theory based on analyzing the nonlinear learning dynamics of simple linear networks. Note that deep linear networks have provided a useful tractable theoretical model of nonconvex loss landscapes [^20] [^13] [^23] and nonlinear learning dynamics [^29] [^30] [^22] [^1] in these landscapes, yielding insights like dynamical isometry [^29] [^26] [^27] that lead to improved training of nonlinear deep networks. Despite the simplicity of our theory, it can still predict how various hyperparameter choices affect performance in an extensive set of real-world ablation studies. Moreover, the simplicity also enables us to provide conceptual and analytic insights into why performance patterns vary the way they do. Specifically, our theory accounts for the following diverse empirical findings:

Essential part of non-contrastive SSL. The existence of the predictor and stop-gradient is absolutely essential. Removing either of them leads to representational collapse in BYOL and SimSiam.

EMA. While the original BYOL needs EMA to work, they later confirmed that EMA is not necessary (i.e., the online and target networks can be identical) if a higher $\alpha_{p}$ is used. This is also confirmed with SimSiam, as long as the predictor is updated more often or has larger learning rate (or larger $\alpha_{p}$). However, the performance is slightly lower.

Predictor Optimality and Relative learning rate $\alpha_{p}$. Both BYOL and SimSiam suggest that the predictor should always be optimal, in the sense of always achieving minimal $\ell_{2}$ error in predicting the target network’s outputs from the online network’s outputs. This optimality conjecture was motivated by observed superior performance when the predictor had large learning rates and/or was allowed more frequent updates than the rest of the network. However [^8] also showed that if the predictor is updated too often, then performance drops, which questions the importance of an always optimal predictor as a key requirement for learning good representations.

Weight Decay. Table 15 in BYOL [^17] indicates that no weight decay may lead to unstable results. A recent blogpost [^16] also mentions using weight decay leads to stable learning in BYOL.

Finally, motivated by our theoretical analysis, we propose a new method DirectPred that directly sets the predictor weights based on principal components analysis of the predictor’s input, thereby avoiding complicated predictor dynamics and initialization issues. We show that this simple DirectPred method nevertheless yields comparable performance in CIFAR-10 and outperforms gradient training of the linear predictor by $+5\%$ Top-1 accuracy in linear evaluation protocol on both STL-10 and ImageNet (60 epochs). On the standard ImageNet benchmark (300 epochs), DirectPred achieves $72.4\%/91.0\%$ Top-1/Top-5, $2.5\%$ higher than BYOL with linear predictor ($69.9\%/89.6\%$) and comparable with default BYOL setting with 2-layer predictor ($72.5\%/90.8\%$).

<table><thead><tr><th></th><th colspan="4">Plug-in frequency (every <math><semantics><mi>N</mi> <annotation>N</annotation></semantics></math> minibatches)</th></tr><tr><th></th><th>1</th><th>2</th><th>3</th><th>5</th></tr></thead><tbody><tr><th>EMA</th><td><math><semantics><mrow><mn>40.67</mn> <mo>±</mo> <mn>0.50</mn></mrow> <annotation>40.67{\pm}0.50</annotation></semantics></math></td><td><math><semantics><mrow><mn>35.29</mn> <mo>±</mo> <mn>2.49</mn></mrow> <annotation>35.29{\pm}2.49</annotation></semantics></math></td><td><math><semantics><mrow><mn>34.60</mn> <mo>±</mo> <mn>0.98</mn></mrow> <annotation>34.60{\pm}0.98</annotation></semantics></math></td><td><math><semantics><mrow><mn>35.63</mn> <mo>±</mo> <mn>2.66</mn></mrow> <annotation>35.63{\pm}2.66</annotation></semantics></math></td></tr><tr><th>no EMA</th><td><math><semantics><mrow><mn>39.45</mn> <mo>±</mo> <mn>1.26</mn></mrow> <annotation>39.45{\pm}1.26</annotation></semantics></math></td><td><math><semantics><mrow><mn>34.01</mn> <mo>±</mo> <mn>1.54</mn></mrow> <annotation>34.01{\pm}1.54</annotation></semantics></math></td><td><math><semantics><mrow><mn>34.58</mn> <mo>±</mo> <mn>2.93</mn></mrow> <annotation>34.58{\pm}2.93</annotation></semantics></math></td><td><math><semantics><mrow><mn>32.22</mn> <mo>±</mo> <mn>2.94</mn></mrow> <annotation>32.22{\pm}2.94</annotation></semantics></math></td></tr></tbody></table>

Table 1: Simply plugging in the “optimal solution” to the linear predictor shows poor performance after 100 BYOL epochs (Top-1 accuracy in STL-10 [^10] downstream classification task). The optimal solution is obtained by solving (with regularization) $W_{p}\mathbb{E}\left[{\bm{f}}{\bm{f}}^{\intercal}\right]=\frac{1}{2}(\mathbb{E}\left[{\bm{f}}_{\mathrm{a}}{\bm{f}}^{\intercal}\right]+\mathbb{E}\left[{\bm{f}}{\bm{f}}_{\mathrm{a}}^{\intercal}\right])$, in which the two expectations is estimated with exponential moving average. In comparison, with gradient descent, BYOL with a single linear layer predictor can reach 74%-75% Top-1 in STL-10 after 100 epochs. Unless explicitly stated, in all our experiments, we use ResNet-18 [^18] as the backbone network for CIFAR-10/STL-10 experiments and SGD as the optimizer with learning rate $\alpha=0.03$, momentum $0.9$, weight decay $\bar{\eta}=0.0004$ and EMA parameter $\gamma_{\mathrm{a}}=0.996$. Each setting is repeated 5 times.

## 2 Two-layer linear model

To obtain analytic and conceptual insights into non-contrastive SSL we analyze a simple, *bias-free* linear BYOL model where the online, target and predictor networks are specified by the weight matrices $W\in\mathbb{R}^{n_{2}\times n_{1}}$, $W_{p}\in\mathbb{R}^{n_{2}\times n_{2}}$ and $W_{\mathrm{a}}\in\mathbb{R}^{n_{2}\times n_{1}}$ respectively (Fig. 1). Let ${\bm{x}}\in\mathbb{R}^{n_{1}}$ be a data point drawn from the data distribution $p({\bm{x}})$ and let ${\bm{x}}_{1}$ and ${\bm{x}}_{2}$ be two augmented views of ${\bm{x}}$: ${\bm{x}}_{1},{\bm{x}}_{2}\sim p_{\mathrm{aug}}(\cdot|{\bm{x}})$ where $p_{\mathrm{aug}}(\cdot|{\bm{x}})$ is the augmentation distribution. In practice such data augmentations correspond to random crops, blurs or color distortions of images [^7]. Let ${\bm{f}}_{1}=W{\bm{x}}_{1}\in\mathbb{R}^{n_{2}}$ be the online representation of view $1$, and ${\bm{f}}_{2\mathrm{a}}=W_{\mathrm{a}}{\bm{x}}_{2}\in\mathbb{R}^{n_{2}}$ be the target representation of view $2$. In BYOL, the learning dynamics of $W$ and $W_{p}$ are obtained by minimizing

$$
J(W,W_{p}):=\frac{1}{2}\mathbb{E}_{{\bm{x}}_{1},{\bm{x}}_{2}}\left[\|W_{p}{\bm{f}}_{1}-\mathrm{StopGrad}({\bm{f}}_{2\mathrm{a}})\|^{2}_{2}\right],
$$

while the dynamics of $W_{a}$ is obtained differently, via an exponential moving average (EMA) of $W$. We will analyze this combined dynamics for $W$, $W_{p}$ and $W_{a}$, in the presence of additional weight decay, in the limit of large batch sizes and small discrete time learning rates. This limit can be well approximated by the gradient flow (see Supplementary Material (SM) for all derivations):

###### Lemma 1.

BYOL learning dynamics following Eqn. 1:

$$
\displaystyle\dot{W}_{p}\!\!
$$
$$
\displaystyle\!\!=\!\!
$$
$$
\displaystyle\!\!\alpha_{p}\left(-W_{p}W(X+X^{\prime})+W_{\mathrm{a}}X\right)W^{\intercal}-\eta W_{p}
$$
 
$$
\displaystyle\dot{W}\!\!
$$
$$
\displaystyle\!\!=\!\!
$$
$$
\displaystyle\!\!W^{\intercal}_{p}\left(-W_{p}W(X+X^{\prime})+W_{\mathrm{a}}X\right)-\eta W
$$
 
$$
\displaystyle\dot{W}_{\mathrm{a}}\!\!
$$
$$
\displaystyle\!\!=\!\!
$$
$$
\displaystyle\!\!\beta(-W_{\mathrm{a}}+W)
$$

Here, $X:=\mathbb{E}\left[\bar{\bm{x}}\bar{\bm{x}}^{\intercal}\right]$ where $\bar{\bm{x}}({\bm{x}}):=\mathbb{E}_{{\bm{x}}^{\prime}\sim p_{\mathrm{aug}}(\cdot|{\bm{x}})}\left[{\bm{x}}^{\prime}\right]$ is the average augmented view of a data point ${\bm{x}}$ and $X^{\prime}:=\mathbb{E}_{{\bm{x}}}\left[\mathbb{V}_{{\bm{x}}^{\prime}|{\bm{x}}}[{\bm{x}}^{\prime}]\right]$ is the covariance matrix $\mathbb{V}_{{\bm{x}}^{\prime}|{\bm{x}}}[{\bm{x}}^{\prime}]$ of augmented views ${\bm{x}}^{\prime}$ conditioned on ${\bm{x}}$, subsequently averaged over the data ${\bm{x}}$. Note that $\alpha_{p}$ and $\beta$ reflect *multiplicative learning rate ratios* between the predictor and target networks relative to the online network. Finally, the terms involving $\eta$ reflect weight decay.

As a gradient flow formulation, the learning rate $\alpha$ does not appear in Lemma 1. In the actual finite time update, the learning rate for $W_{p}$ is $\alpha\alpha_{p}$, the EMA rate is $\alpha\beta=1-\gamma_{\mathrm{a}}$, where $\gamma_{\mathrm{a}}$ is the usual EMA parameter (e.g,. BYOL uses $0.996$), and the weight decay for actual training is $\bar{\eta}:=\alpha\eta$.

We note that since SimSiam is an ablation of BYOL that removes the EMA computation, the underlying dynamics of SimSiam can also be obtained from Lemma 1 simply by setting $W_{a}=W$, inserting this relation into Eqn. 2 and Eqn. 3, and ignoring Eqn. 4. Importantly, the stop-gradient on the target branch is still there.

Overall Eqns. 2-4 constitute our starting point for analyzing the combined roles of relative learning rates $\alpha_{p}$ and $\beta$, weight decay rate $\eta$ and various ablations in determining the performance of both BYOL and SimSiam.

We first derive two very general results (see SM).

###### Theorem 1 (Weight decay promotes balancing of the predictor and online networks.).

Completely independent of the particular dynamics of $W_{a}$ in Eqn. 4, the update rules (Eqn. 2 and Eqn. 3) possess the invariance

$$
W(t)W^{\intercal}(t)=\alpha^{-1}_{p}W_{p}^{\intercal}(t)W_{p}(t)+e^{-2\eta t}C,
$$

where $C$ is a symmetric matrix that depends only on the initialization of $W$ and $W_{p}$.

This theorem implies that for both BYOL and SimSiam, there exists a “balancing” that ensures that any matching between the online and target representations will not be attributable solely to the predictor weights, rendering the online weights useless. Instead what the predictor learns, the online network will also learn, which is important as the online network’s representations are what is used for downstream tasks. We note that similar weight balancing dynamics has been discovered in multi-layer linear networks and matrix factorization [^1] [^14]. Our results generalize this to SSL dynamics. Second, a nonzero weight decay could help remove the extra constant $C$ due to initialization, further balancing the predictor and online network weights and possibly leading to better performance on downstream tasks (Tbl. 2).

| EMA + no-bias | EMA + bias | no EMA + no-bias | no EMA + bias |
| --- | --- | --- | --- |
| $70.62{\pm}1.05$ | $70.99{\pm}1.01$ | $71.36{\pm}0.44$ | $71.37{\pm}0.77$ |

Table 2: Top-1 accuracy of BYOL on STL-10 under linear evaluation protocol, trained for 100 epochs with no weight decay ($\eta=0$) and $\alpha_{p}=1$. It is worse than the baseline ($74.51{\pm}0.47$ without predictor bias) when the weight decay is set to be $\eta=0.0004$. “No-bias” means the linear predictor does not have a bias term.

###### Theorem 2 (The stop-gradient signal is essential for success.).

With $W_{\mathrm{a}}=W$ (SimSiam case), removing the stop-gradient signal yields a gradient update for $W$ given by positive semi-definite (PSD) matrix $H(t):=X^{\prime}\otimes(W_{p}^{\intercal}W_{p}+I_{n_{2}})+X\otimes\tilde{W}_{p}^{\intercal}\tilde{W}_{p}+\eta I_{n_{1}n_{2}}$ (here $\tilde{W}_{p}:=W_{p}-I_{n_{2}}$ and $\otimes$ is the Kronecker product):

$$
\frac{\mathrm{d}}{\mathrm{d}t}\mathrm{vec}(W)=-H(t)\mathrm{vec}(W).
$$

If the minimal eigenvalue $\lambda_{\min}(H(t))$ over time is bounded below, $\inf_{t\geq 0}\lambda_{\min}(H(t))\geq\lambda_{0}>0$, then $W(t)\rightarrow 0$.

Thus we have proven analytically in this simple setting that removing the stop-gradient leads to representational collapse, as observed in more complex settings in SimSiam [^8]. Similarly, with $W_{a}=W$ and no predictor ($W_{p}=I_{n_{2}}$), then the dynamics Eqn. 3 also reduces to a similar form and $W(t)\rightarrow 0$ (see SM).

![Refer to caption](https://ar5iv.labs.arxiv.org/html/2102.06810/assets/eigenspace-alignment-ema-no-symmetric-crop.png)

Figure 2: Training BYOL in STL-10 for 100 epochs with EMA. Top row: No symmetric regularization imposed on W p W\_{p}, Bottom row: symmetric regularization on. From left to right: (1) Evolvement of eigenvalues for F. Since is PSD and its eigenvalue s j s\_{j} varies across scales, we plot log ⁡ ( i ) \\log(s\_{i}). We could see some eigenvalues are growing while others are shrinking to zero over training. (2) Similar “step-function” behaviors for the predictor. Its negative eigenvalues shrinks towards zero and leading eigenvalues becomes larger. (3) The eigenspace of and gradually align with each other (Theorem 3 ). For each eigenvector 𝒖 {\\bm{u}}\_{j} of, we compute cosine angle (normalized correlation) between W\_{p}{\\bm{u}}\_{j} to measure alignment. (4) gradually becomes symmetric and PSD during training.

## 3 How multiple factors affect learning dynamics

The learning dynamics in Eqns. 2-4 constitute a set of high dimensional coupled nonlinear differential equations that can be difficult to solve analytically in general. Therefore, to obtain analytic insights into the functional roles of the relative learning rates $\alpha_{p}$ and $\beta$ and weight decay $\eta$, we make a series of simplifying assumptions. Intriguingly, under these simplifying assumptions we obtain a rich set of analytic predictions, which we then test experimentally in more realistic scenarios. We find, nicely, that these predictions still qualitatively hold even when our simplifying assumptions required for obtaining analytic results do not.

###### Assumption 1 (Proportional EMA).

We first reduce the dimensionality of the dynamics in Eqns. 2-4 by enforcing that the target network $W_{a}$ undergoes EMA but is forced to always be proportional to the online network via the relation $W_{\mathrm{a}}(t)=\tau(t)W(t)$. Inserting this relation into the EMA dynamics in Eqn. 4 yields $\dot{\tau}W+\tau\dot{W}=\beta(1-\tau)W$.

Thus we obtain a reduced dynamics for $W$, $W_{p}$ and $\tau$. By not enforcing the stronger SimSiam constraint that $W_{a}=W$, we can still model EMA dynamics. Intuitively, $\tau=\tau(t)$ is a dynamic parameter that depends on how quickly $W=W(t)$ grows over time. If $W$ is constant, then $\dot{W}=0$ and $\tau$ stabilizes to $1$. On the other hand, if $W$ grows rapidly, then $\tau$ becomes small. While Assumption 1 is a simplification, as we shall see, it still reveals interesting verifiable predictions about the functional role of EMA.

###### Assumption 2 (Isotropic data and augmentation).

We assume the data distribution $p({\bm{x}})$ has zero mean and identity covariance, while the augmentation distribution $p_{\mathrm{aug}}(\cdot|{\bm{x}})$ has mean ${\bm{x}}$ and covariance $\sigma^{2}I$. This simplifies the dynamics in Eqns. 2-4 by reducing the augmentation averaged data covariance to $X=I$ and the data averaged augmentation covariance to $X^{\prime}=\sigma^{2}I$.

Many previous studies of deep learning dynamics made simplifying isotropic assumptions about data [^31] [^6] [^15] [^4] [^28]. Since our fundamental goal is to obtain the first analytic understanding of the dynamics of non-contrastive SSL methods, it is useful to first achieve this in the simplest possible isotropic setting. Interestingly, we will find that our final conclusions generalize to non-isotropic real world settings.

###### Assumption 3 (Symmetric predictor).

We enforce symmetry in $W_{p}$ by initializing it to be a symmetric matrix, and then symmetrizing the flow for $W_{p}$ in Eqn. 2 (see SM).

This symmetry assumption was motivated by both fixed point analysis and empirical findings. First, the fixed point of Eqn. 2 under Assumption 1 and 2 and $\eta>0$ is always a symmetric matrix and in numerical simulation the asymmetric part $W_{p}-W_{p}^{\intercal}$ eventually vanishes (See Appendix for the proof and numerical simulations). Moreover, during BYOL training without a symmetry constraint on the predictor, $W_{p}$ gradually moves towards symmetry (Fig. 2).

Second, a set of experiments reveal that whether the predictor is symmetric or not has a dramatic effect in terms of both performance and interaction with EMA. In our STL-10 experiment, enforcing symmetric $W_{p}$ in the presence of EMA *improves* performance on downstream tasks (Tbl. 3). In contrast, in the absence of EMA, a symmetric $W_{p}$ fails while an asymmetric $W_{p}$ works reasonably well. Similar behavior holds on ImageNet: a symmetric one layer linear predictor $W_{p}$ in SimSiam (i.e. without EMA) achieves performance no better than random guessing (Top-1/5: $0.1\%/0.5\%$), while an asymmetric $W_{p}$ achieves a Top-1/5 accuracy of $68.1\%/88.2\%$. Our theory will explain this as well as show how to obtain good performance with a symmetric predictor without EMA by increasing its relative learning rate $\alpha_{p}$.

<table><tbody><tr><td></td><td colspan="2">No predictor bias</td><td colspan="2">With predictor bias</td></tr><tr><td></td><td>sym <math><semantics><msub><mi>W</mi> <mi>p</mi></msub> <annotation>W_{p}</annotation></semantics></math></td><td>regular <math><semantics><msub><mi>W</mi> <mi>p</mi></msub> <annotation>W_{p}</annotation></semantics></math></td><td>sym <math><semantics><msub><mi>W</mi> <mi>p</mi></msub> <annotation>W_{p}</annotation></semantics></math></td><td>regular <math><semantics><msub><mi>W</mi> <mi>p</mi></msub> <annotation>W_{p}</annotation></semantics></math></td></tr><tr><td colspan="5"><em>One-layer linear predictor</em></td></tr><tr><td>EMA</td><td><math><semantics><mrow><mn>75.09</mn> <mo>±</mo> <mn>0.48</mn></mrow> <annotation>75.09{\pm}0.48</annotation></semantics></math></td><td><math><semantics><mrow><mn>74.51</mn> <mo>±</mo> <mn>0.47</mn></mrow> <annotation>74.51{\pm}0.47</annotation></semantics></math></td><td><math><semantics><mrow><mn>74.52</mn> <mo>±</mo> <mn>0.29</mn></mrow> <annotation>74.52{\pm}0.29</annotation></semantics></math></td><td><math><semantics><mrow><mn>74.16</mn> <mo>±</mo> <mn>0.33</mn></mrow> <annotation>74.16{\pm}0.33</annotation></semantics></math></td></tr><tr><td>no EMA</td><td><math><semantics><mrow><mn>36.62</mn> <mo>±</mo> <mn>1.85</mn></mrow> <annotation>\mathbf{36.62{\pm}1.85}</annotation></semantics></math></td><td><math><semantics><mrow><mn>72.85</mn> <mo>±</mo> <mn>0.16</mn></mrow> <annotation>72.85{\pm}0.16</annotation></semantics></math></td><td><math><semantics><mrow><mn>36.04</mn> <mo>±</mo> <mn>2.74</mn></mrow> <annotation>\mathbf{36.04{\pm}2.74}</annotation></semantics></math></td><td><math><semantics><mrow><mn>72.13</mn> <mo>±</mo> <mn>0.53</mn></mrow> <annotation>72.13{\pm}0.53</annotation></semantics></math></td></tr><tr><td colspan="5"><em>Two-layer predictor with BatchNorm and ReLU</em></td></tr><tr><td>EMA</td><td><math><semantics><mrow><mn>71.58</mn> <mo>±</mo> <mn>6.46</mn></mrow> <annotation>71.58{\pm}6.46</annotation></semantics></math></td><td><math><semantics><mrow><mn>78.85</mn> <mo>±</mo> <mn>0.25</mn></mrow> <annotation>78.85{\pm}0.25</annotation></semantics></math></td><td><math><semantics><mrow><mn>77.64</mn> <mo>±</mo> <mn>0.41</mn></mrow> <annotation>77.64{\pm}0.41</annotation></semantics></math></td><td><math><semantics><mrow><mn>78.53</mn> <mo>±</mo> <mn>0.34</mn></mrow> <annotation>78.53{\pm}0.34</annotation></semantics></math></td></tr><tr><td>no EMA</td><td><math><semantics><mrow><mn>35.59</mn> <mo>±</mo> <mn>2.10</mn></mrow> <annotation>\mathbf{35.59{\pm}2.10}</annotation></semantics></math></td><td><math><semantics><mrow><mn>65.98</mn> <mo>±</mo> <mn>0.71</mn></mrow> <annotation>65.98{\pm}0.71</annotation></semantics></math></td><td><math><semantics><mrow><mn>41.92</mn> <mo>±</mo> <mn>4.25</mn></mrow> <annotation>\mathbf{41.92{\pm}4.25}</annotation></semantics></math></td><td><math><semantics><mrow><mn>65.59</mn> <mo>±</mo> <mn>0.66</mn></mrow> <annotation>65.59{\pm}0.66</annotation></semantics></math></td></tr></tbody></table>

Table 3: The effect of symmetrization of $W_{p}$ on downstream classification task (BYOL Top-1 on STL-10). Symmetric $W_{p}$ leads to slightly better performance compared to regular $W_{p}$ in the presence of EMA. On the other hand, without EMA, symmetric $W_{p}$ crashes. Same effects happen in two-layer predictor with BatchNorm and ReLU as well. Weight decay $\bar{\eta}=0.0004$ and $\alpha_{p}=1$.

### 3.1 Dynamical alignment of eigenspaces between the predictor and its input correlation matrix

Under the three assumptions stated above, we analyze the coupled dynamics of $F:=WXW^{\intercal}$ and $W_{p}$. Note that $F$ is the *correlation matrix* of the outputs of the online network which also serve as inputs to the predictor. By Assumption 2, $\mathbb{E}\left[{\bm{x}}\right]={\bm{0}}$ and $F$ is also the covariance matrix. We find $F$ and $W_{p}$ obey the following dynamics (see SM):

$$
\displaystyle\dot{W}_{p}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle-\frac{\alpha_{p}}{2}(1+\sigma^{2})\{W_{p},F\}+\alpha_{p}\tau F-\eta W_{p}
$$
 
$$
\displaystyle\dot{F}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle-(1+\sigma^{2})\{W_{p}^{2},F\}+\tau\{W_{p},F\}-2\eta F
$$

This dynamics reveals that the eigenspace of $W_{p}$ will gradually align with that of $F$ under certain conditions (see SM for derivation):

###### Theorem 3 (Eigenspace alignment).

Under Eqn. 7, the *commutator* $[F,W_{p}]:=FW_{p}-W_{p}F$ satisfies:

$$
\frac{\mathrm{d}}{\mathrm{d}t}[F,W_{p}]=-[F,W_{p}]K-K[F,W_{p}]
$$

where

$$
K(t)=(1+\sigma^{2})\left[\frac{\alpha_{p}}{2}F(t)+W_{p}^{2}(t)-\frac{\tau}{1+\sigma^{2}}W_{p}(t)\right]+\frac{3}{2}\eta I
$$

If $\inf_{t\geq 0}\lambda_{\min}[K(t)]=\lambda_{0}>0$, then the commutator

$$
\|[F(t),W_{p}(t)]\|_{F}\leq e^{-2\lambda_{0}t}\|[F(0),W_{p}(0)]\|_{F}\rightarrow 0
$$

For symmetric $W_{p}$, when $W_{p}$ and $F$ commute they can be simultaneously diagonalized. Thus this shows that the eigenspace of $W_{p}$ gradually aligns with that of $F$.

To test this prediction, we performed extensive experiments showing that training BYOL using ResNet-18 on STL-10 yields eigenspace alignment, as demonstrated in Fig. 2.

Now if the eigenspaces of $W_{p}$ and $F$ do align, we can obtain fully decoupled dynamics. Let the columns of the matrix $U$ be the common eigenvectors, so that $W_{p}=U\Lambda_{W_{p}}U^{\intercal}$ where $\Lambda_{W_{p}}=\mathrm{diag}[p_{1},p_{2},\ldots,p_{d}]$, $F=U\Lambda_{F}U^{\intercal}$ where $\Lambda_{F}=\mathrm{diag}[s_{1},s_{2},\ldots,s_{d}]$. For each mode $j$, we have (see SM for derivation):

$$
\displaystyle\dot{p}_{j}
$$
 
$$
\displaystyle\!=\!
$$
$$
\displaystyle\alpha_{p}s_{j}\left[\tau-(1+\sigma^{2})p_{j}\right]-\eta p_{j}
$$
 
$$
\displaystyle\dot{s}_{j}
$$
 
$$
\displaystyle\!=\!
$$
$$
\displaystyle 2p_{j}s_{j}\left[\tau-(1+\sigma^{2})p_{j}\right]-2\eta s_{j}
$$
 
$$
\displaystyle s_{j}\dot{\tau}
$$
 
$$
\displaystyle\!=\!
$$
$$
\displaystyle\beta(1-\tau)s_{j}-\tau\dot{s}_{j}/2.
$$

This decoupled dynamics constitutes a dramatically simplified set of $3$ dimensional nonlinear dynamical systems for BYOL learning, and two dimensional nonlinear systems (obtained by constraining $\tau=1$) for SimSiam. As expected, each mode’s dynamics is equivalent to the $3$ dimensional dynamics obtained by setting $n_{1}=n_{2}=1$ in Eqns. 2-4 and making the replacements $W^{2}=s_{j}$, $W_{p}=p_{j}$, and $W_{a}/W=\tau$ (see SM). Thus the decoupled dynamics in Eqns 11- 13 reduce to the scalar case of BYOL dynamics in Eqns. 2-4 after a change of variables and the condition in Thm. 3 reveals when this decoupled regime is reachable.

Non-symmetric $W_{p}$. When Assumption 3 is absent, the analysis is much more convoluted. One possible way is to decompose $W_{p}=A+B$ where $A=A^{\intercal}$ is symmetric and $B=-B^{\intercal}$ is skew-symmetric. We leave it for future work.

### 3.2 Analysis of decoupled dynamics

The simplified three (two) dimensional dynamics of BYOL (SimSiam) yields significant insights. First, there is clearly a collapsed fixed point at $p_{j}(t)=s_{j}(t)=0$ and $\tau$ taking any value. We wish to understand conditions under which $p_{j}$ and $s_{j}$ can avoid this collapsed fixed point and grow from small random initial conditions. Since $s_{j}$ is an eigenvalue of $WW^{\intercal}$, we are particularly interested in conditions under which $s_{j}$ achieves large final values, corresponding to a non-collapsed online network, that are moreover sensitive to the statistics of the data, governed by $\sigma^{2}$.

Exact integral. First, an important observation, similar to Theorem 1, is that the dynamics possesses an exact integral of motion, obtained by multiplying Eqn. 11 by $2\alpha_{p}^{-1}p_{j}$, subtracting, Eqn. 12 and integrating over time yielding

$$
s_{j}(t)=\alpha_{p}^{-1}p_{j}^{2}(t)+e^{-2\eta t}c_{j}
$$

where $c_{j}=\alpha_{p}^{-1}p_{j}^{2}(0)-s_{j}(0)$ is fixed by initial conditions. In absence of weight decay ($\eta=0$), this integral reveals that the initial condition encoded in $c_{j}$ is never forgotten and the dynamics of $p_{j}$ and $s_{j}$ are confined to parabolas of the form $s_{j}(t)=p_{j}^{2}(t)+c_{j}$, as can be seen by the blue flow lines in Fig. 3(left). With weight decay ($\eta>0$) over time the initial condition is forgotten and the dynamics approaches the invariant parabola $s_{j}=\alpha_{p}^{-1}p_{j}^{2}$ as can been seen by the approach of the blue flow lines to the black dashed parabola in Fig. 3 right and middle. We discuss these two cases in turn. First we note that in both cases, since the EMA computation is often very slow [^17], corresponding to small $\beta$, the dynamics of $\tau$ in Eqn. 13 is slow relative to that of $p_{j}$ and $s_{j}$. Therefore to understand the combined dynamics, we can search for the fixed points that $p_{j}$ and $s_{j}$ will rapidly approach at fixed $\tau$. Over time $\tau$ will then either slowly approach $1$ (BYOL) or be always equal to $1$ (SimSiam), and $s_{j}$ and $p_{j}$ will follow their $\tau$ -dependent fixed points.

![Refer to caption](https://ar5iv.labs.arxiv.org/html/2102.06810/assets/figs/3Ddynam_crop.png)

Figure 3: State space dynamics in Eqns. 11 and 12 for no ( η = 0 \\eta=0 ) weak ( 0.01 \\eta=0.01 ) and strong ( 1 \\eta=1 ) weight decay at fixed τ \\tau=1 α p \\alpha\_{p}=1. Red (green) points indicate stable (unstable) fixed points, blue curves indicate flow lines, and the dashed black curve indicates the parabola s j 2 / s\_{j}=p\_{j}^{2}/\\alpha\_{p}.

No weight decay. When $\eta=0$, Eqns. 11 and 12 at a fixed value of $\tau$ yield a branch of collapsed fixed points given by $s_{j}=0$ and $p_{j}$ taking any value, and a branch of non-collapsed fixed points, with $p_{j}=\tau/(1+\sigma^{2})$ and $s_{j}$ taking any value (horizontal and vertical red/green lines in Fig. 3,left). A sufficient criterion on initial conditions to avoid the collapsed branch is $s_{j}(0)>p^{2}_{j}(0)/\alpha_{p}$ corresponding to lying above the dashed black parabola in Fig. 3,left. This restricted initial condition reveals why a fast predictor (large $\alpha_{p}$) is advantageous (Obs#1): larger $\alpha_{p}$ leads to a smaller basin of attraction of the collapsed branch by flattening the dashed parabola. Indeed both BYOL and SimSiam have noted that a fast predictor can help avoid collapse. On the other hand, $\alpha_{p}$ cannot be infinitely large (Obs#2): since $s_{j}(+\infty)=s_{j}(0)+\alpha^{-1}_{p}(p^{2}_{j}(+\infty)-p_{j}^{2}(0))$, very large $\alpha_{p}$ implies that $s_{j}$, the final value of the online network characterizing the learned representation, does not grow even if $p_{j}$ does. This is consistent with results which show that optimizing the predictor too often doesn’t work in SimSiam [^8], and directly setting an “optimal” predictor fails as well (Tbl. 1). The online network needs to grow along with the predictor and that cannot happen if the predictor is too fast.

Advantage of weight decay. In the non-collapsed branch of fixed points without weight decay (vertical red line in Fig. 3,left), the predictor $p_{j}$ takes the exact value $\tau/(1+\sigma^{2})$, which models the invariance to augmentation correctly: a large data augmentation variance $\sigma^{2}$ should lead to a small magnitude of the learned representation. Ideally, we want $s_{j}$ to have the same property. With weight decay $\eta>0$ in Eqn. 14, memory of the initial condition $c_{j}$ fades away, yielding convergence to some point on the invariant parabola $s_{j}=\alpha_{p}^{-1}p_{j}^{2}$. (Obs#3): Therefore, by tying the online network to the predictor, weight decay allows $s_{j}$ to also model invariance to augmentations correctly if the predictor does, regardless of the random initial condition $c_{j}$.

|  | Positive effects | Negative effects |
| --- | --- | --- |
| Relative predictor lr $\alpha_{p}$ | #1,#6 | #2 |
| Weight decay $\eta$ | #3,#7 | #4,#5 |
| EMA $\beta$ | #8 | #9,#10 |

Table 4: Summarization of positive/negative effects of various hyperparameter choices (EMA $\beta$, relative predictor learning rate $\alpha_{p}$ and weight decay $\eta$). “#1” means (Obs#1) in the text.

#### Dynamics on the invariant parabola.

Because weight decay forces convergence to the invariant parabola $s_{j}=\alpha^{-1}_{p}p_{j}^{2}$, we next focus on dynamics along this parabola (i.e. $c_{j}=0$ in Eqn. 14). In this case, Eqn. 13 has a solution:

$$
\tau(t)=p^{-1}_{j}(t)\beta e^{-\beta t}\int_{0}^{t}p_{j}(t^{\prime})e^{\beta t^{\prime}}\mathrm{d}t,
$$

with initial condition $\tau(0)=0$. Inserting the invariant $s_{j}=\alpha_{p}^{-1}p^{2}_{j}$ into Eqn. 11, the dynamics of $p_{j}$ is given by:

$$
\dot{p}_{j}=p_{j}^{2}\left[\tau(t)-(1+\sigma^{2})p_{j}\right]-\eta p_{j}.
$$

We first analyze the fixed points where $\dot{p}_{j}=0$ at fixed $\tau$.

Figure 4: Fixed point of $\dot{p}_{j}=-p_{j}(p_{j}-p^{*}_{j-})(p_{j}-p^{*}_{j+})$ (see Eqn. 16). Stable fixed points are in red, unstable in green and saddle in black. When the weight decay $\eta=0$, the trivial solution $p_{j}=0$ is a saddle. When $\eta>0$, the trivial solution becomes stable near to the origin and initial $p_{j}$ needs to be large enough to converge to the stable non-collapsed solution $p^{*}_{j+}$.

When the weight decay $0<\eta\leq\frac{\tau^{2}}{4(1+\sigma^{2})}$, $p_{j}$ has has three fixed points (Fig. 4(b)):

$$
p_{j\pm}^{*}=\frac{\tau{\pm}\sqrt{\tau^{2}-4\eta(1+\sigma^{2})}}{2(1+\sigma^{2})}>0,\quad p^{*}_{j0}=0
$$

where both $p^{*}_{j0}$ and $p^{*}_{j+}$ are stable and $p^{*}_{j-}$ is unstable, as shown in Fig. 4(b). The basin of attraction of the collapsed fixed point $p^{*}_{j0}=0$ is $p_{j}<p^{*}_{j-}$ while the basin of attraction of the useful non-collapsed fixed point $p^{*}_{j+}$ is $p_{j}>p^{*}_{j-}$, yielding an important constraint on initial conditions to avoid collapse. Note that $p^{*}_{j-}$ is a decreasing function of $\tau$ and increasing function of $\eta$ (see SM). This means that with larger $\eta$, $p^{*}_{j-}$ moves right and the basin of collapse expands (Obs#4). When $\eta>\frac{\tau^{2}}{4(1+\sigma^{2})}$ there is only one stable fixed point $p^{*}_{j0}=0$ (Fig. 4(c)). Under such strong weight decay collapse is unavoidable (Obs#5).

![Refer to caption](https://ar5iv.labs.arxiv.org/html/2102.06810/assets/eta-effect-crop.png)

Figure 5: The role played by weight decay η \\eta and EMA β \\beta when applying symmetric regularization on W p W\_{p} on synthetic experiments simulating decoupled dynamics (Eqn. 11 - 13 ). The learning rate α = 0.01 \\alpha=0.01. Both terms boost the eigenvalue of K ⁡ ( t ) K(t) to above 0 so that eigen space alignment could happen (Theorem 3 ), but also come with different trade-offs. Here 0.4 \\beta=0.4 so that 0.004 1 − γ a \\alpha\\beta=0.004=1-\\gamma\_{\\mathrm{a}} where 0.996 \\gamma\_{\\mathrm{a}}=0.996 as in BYOL. Top row (Weight Decay: A large boost the eigenvalue of up, but substantially decreases the final converging eigenvalues j p\_{j} and s s\_{j} (i.e., the final features are not salient), or even drags them to zero (no training happens). Bottom row (EMA. A small EMA also boost the eigenvalue of, but the training converges much slower. Here 0.04 \\eta=0.04 \\eta\\alpha equals to the weight decay ( ¯ 0.0004 \\bar{\\eta}=0.0004 ) in our STL-10 experiments.

We now discuss the dynamics. First we define the quantity $\Delta_{j}:=p_{j}[\tau-(1+\sigma^{2})p_{j}]-\eta$, which must satisfy *two criteria*. Note that Eqn. 16 can be written as $\dot{p}_{j}=p_{j}\Delta_{j}$, so $\Delta_{j}$ must at some point be positive to drive $p_{j}(t)$ to any positive non-collapsed fixed point $p^{*}_{j+}$. Second, for eigenspace alignment in Theorem 3 to *remain* stable (even if the alignment has already happened), $K(t)$ must be positive definite (PD) in Eqn. 9. Using the eigen-space alignment conditions and the invariance $s_{j}=\alpha^{-1}_{p}p_{j}^{2}$, the positive definite condition on $K(t)$ can be written as

$$
\Delta_{j}<\frac{1}{2}\left[\alpha_{p}(1+\sigma^{2})s_{j}+\eta\right].
$$

This criterion and the criterion $\Delta_{j}>0$ yield interesting insights into the roles of various hyperparameters choices.

First (Obs#6), larger predictor learning rate $\alpha_{p}$ can play an advantageous role by loosening the upper bound in Eqn. 17, making it easier to satisfy. Second (Obs#7), increasing $\eta$ also has the same effect.

Role of EMA. Without EMA, $\tau\equiv 1$ and (Eqn. 17) may not hold initially when $p_{j}$ is small. The reason is $\Delta_{j}$ is to leading order linear in $p_{j}$ when $\tau=1$ while the right hand side is to leading order $s_{j}\sim p_{j}^{2}$, so the left hand side has a larger contribution from $p_{j}$ than the right.

EMA resolves this as follows. When the training begins, $s_{j}$ is often quite small, and $\tau$ remains small since $W$ changes rapidly. When $p_{j}$ grows to the fixed point $p^{*}_{j+}\sim\tau/(1+\sigma^{2})$, the growth of $s_{j}$ stops, making $\tau$ *larger*. This in turns sets a higher fixed point goal for $p_{j}$. This process continues until the feature is stabilized and $\tau=1$ (Fig. 5 for details).

Therefore, EMA can serve as an *automatic curriculum* (Obs#8): it sets an initial small goal of $\frac{\tau}{1+\sigma^{2}}$ for $p_{j}$ so $\Delta_{j}$ need only be small and positive to both drive $p_{j}$ larger and satisfy Eqn. 17. Then EMA gradually sets a higher goal for $p_{j}$ by increasing $\tau$, so that $p_{j}$ and $s_{j}$ can grow, while keeping the eigenspaces of $W_{p}$ and $F$ aligned.

As a trade-off, a very slow EMA schedule ($\beta$ small) yields a slow training procedure (Obs#9) (See Fig. 5). Also small $\tau$ leads to larger $p^{*}_{j-}$ and more eigen modes can be trapped in the collapsed basin (Obs#10).

### 3.3 Summarizing the effects of hyperparameters

We summarize the positive and negative effects of multiple hyperparameters in Tbl. 4. We next provide additional ablations and experiments to further justify our reasoning.

Different weight decay $\eta_{p}$ and $\eta_{s}$. If we set a higher weight decay for the predictor ($\eta_{p}$) than the online net ($\eta_{s}$), then $p_{j}$ grows slower than $s_{j}$ and it is possible that the condition of Theorem 3 can still be satisfied without using EMA. Indeed Tbl. 5 shows this is the case.

<table><tbody><tr><td></td><td colspan="2">No predictor bias</td><td colspan="2">With predictor bias</td></tr><tr><td></td><td>sym <math><semantics><msub><mi>W</mi> <mi>p</mi></msub> <annotation>W_{p}</annotation></semantics></math></td><td>regular <math><semantics><msub><mi>W</mi> <mi>p</mi></msub> <annotation>W_{p}</annotation></semantics></math></td><td>sym <math><semantics><msub><mi>W</mi> <mi>p</mi></msub> <annotation>W_{p}</annotation></semantics></math></td><td>regular <math><semantics><msub><mi>W</mi> <mi>p</mi></msub> <annotation>W_{p}</annotation></semantics></math></td></tr><tr><td colspan="5"><em>Weight decay only for predictor (<math><semantics><mrow><msub><mover><mi>η</mi> <mo>¯</mo></mover> <mi>p</mi></msub> <mo>=</mo> <mn>0.0004</mn></mrow> <annotation>\bar{\eta}_{p}=0.0004</annotation></semantics></math> and <math><semantics><mrow><msub><mover><mi>η</mi> <mo>¯</mo></mover> <mi>s</mi></msub> <mo>=</mo> <mn>0</mn></mrow> <annotation>\bar{\eta}_{s}=0</annotation></semantics></math>)</em></td></tr><tr><td>EMA</td><td><math><semantics><mrow><mn>71.91</mn> <mo>±</mo> <mn>0.70</mn></mrow> <annotation>71.91{\pm}0.70</annotation></semantics></math></td><td><math><semantics><mrow><mn>70.54</mn> <mo>±</mo> <mn>0.93</mn></mrow> <annotation>70.54{\pm}0.93</annotation></semantics></math></td><td><math><semantics><mrow><mn>73.67</mn> <mo>±</mo> <mn>0.47</mn></mrow> <annotation>73.67{\pm}0.47</annotation></semantics></math></td><td><math><semantics><mrow><mn>70.89</mn> <mo>±</mo> <mn>0.98</mn></mrow> <annotation>70.89{\pm}0.98</annotation></semantics></math></td></tr><tr><td>no EMA</td><td><math><semantics><mrow><mn>71.12</mn> <mo>±</mo> <mn>0.71</mn></mrow> <annotation>71.12{\pm}0.71</annotation></semantics></math></td><td><math><semantics><mrow><mn>71.34</mn> <mo>±</mo> <mn>0.63</mn></mrow> <annotation>71.34{\pm}0.63</annotation></semantics></math></td><td><math><semantics><mrow><mn>73.01</mn> <mo>±</mo> <mn>0.37</mn></mrow> <annotation>73.01{\pm}0.37</annotation></semantics></math></td><td><math><semantics><mrow><mn>71.70</mn> <mo>±</mo> <mn>0.83</mn></mrow> <annotation>71.70{\pm}0.83</annotation></semantics></math></td></tr><tr><td colspan="5"><em>No weight decay for all (<math><semantics><mrow><msub><mover><mi>η</mi> <mo>¯</mo></mover> <mi>p</mi></msub> <mo>=</mo> <msub><mover><mi>η</mi> <mo>¯</mo></mover> <mi>s</mi></msub> <mo>=</mo> <mn>0</mn></mrow> <annotation>\bar{\eta}_{p}=\bar{\eta}_{s}=0</annotation></semantics></math>)</em></td></tr><tr><td>EMA</td><td><math><semantics><mrow><mn>71.76</mn> <mo>±</mo> <mn>0.28</mn></mrow> <annotation>71.76{\pm}0.28</annotation></semantics></math></td><td><math><semantics><mrow><mn>70.62</mn> <mo>±</mo> <mn>1.05</mn></mrow> <annotation>70.62{\pm}1.05</annotation></semantics></math></td><td><math><semantics><mrow><mn>71.86</mn> <mo>±</mo> <mn>0.39</mn></mrow> <annotation>71.86{\pm}0.39</annotation></semantics></math></td><td><math><semantics><mrow><mn>70.99</mn> <mo>±</mo> <mn>1.01</mn></mrow> <annotation>70.99{\pm}1.01</annotation></semantics></math></td></tr><tr><td>no EMA</td><td><math><semantics><mrow><mn>43.04</mn> <mo>±</mo> <mn>2.32</mn></mrow> <annotation>43.04{\pm}2.32</annotation></semantics></math></td><td><math><semantics><mrow><mn>71.36</mn> <mo>±</mo> <mn>0.44</mn></mrow> <annotation>71.36{\pm}0.44</annotation></semantics></math></td><td><math><semantics><mrow><mn>41.36</mn> <mo>±</mo> <mn>3.33</mn></mrow> <annotation>41.36{\pm}3.33</annotation></semantics></math></td><td><math><semantics><mrow><mn>71.37</mn> <mo>±</mo> <mn>0.77</mn></mrow> <annotation>71.37{\pm}0.77</annotation></semantics></math></td></tr></tbody></table>

Table 5: Symmetric weight works without EMA, if we set weight decay for the predictor ($\bar{\eta}_{p}=0.0004$) but not the trunk ($\bar{\eta}_{s}=0$) in BYOL experiment on STL-10. Report Top-1 accuracy after 100 epochs. If there is no weight decay for *all layers*, then again symmetric weight doesn’t work without EMA.

![Refer to caption](https://ar5iv.labs.arxiv.org/html/2102.06810/assets/relative-predictor-lr-crop.png)

Figure 6: The effects of relative learning rate α p \\alpha\_{p} without EMA. If > 1 \\alpha\_{p}>1, symmetric W W\_{p} with no EMA can also work. Experiments on STL-10 and CIFAR-10 21 (100 epochs with 5 random seeds).

Larger learning rate of the predictor $\alpha_{p}>1$. Our analysis predicts that one way to make symmetric $W_{p}$ work with no EMA is to use $\alpha_{p}>1$ (i.e. Theorem 3 is more easily satisfied). Fig. 6 verifies this prediction. Moreover Table 22 in Appendix of BYOL [^17] also shows that $\alpha_{p}>1$ is required to get BYOL working without EMA.

As a reference, Table 22 in Appendix I.2 of BYOL [^17] also shows a similar trend: the learning rate of the (2-layer) predictor needs to be higher than that of the projector for strong performance in ImageNet, when EMA is absent.

## 4 Optimization-free Predictor WpW\_{p}

A direct consequence of our theory is a new method for choosing the predictor that avoids gradient descent altogether. Instead, we estimate the correlation matrix $F$ of predictor inputs and directly set $W_{p}$ to be a function of this, thereby avoiding both the need to align the eigenspaces of $F$ and $W_{p}$ through optimization, and the need to initialize $W_{p}$ outside the basin of collapse. As we shall see, this exceedingly simple, theory motivated method also yields better performance in practice compared to gradient-based optimization of a linear predictor.

We call our method DirectPred which simply estimates $F$, computes its eigen-decomposition $\hat{F}=\hat{U}\hat{\Lambda}_{F}\hat{U}^{\intercal}$, where $\hat{\Lambda}_{F}=\mathrm{diag}[s_{1},s_{2},\ldots,s_{d}]$, and sets $W_{p}$ via

$$
p_{j}=\sqrt{s_{j}}+\epsilon\max_{j}s_{j},\ \ W_{p}=\hat{U}\mathrm{diag}[p_{j}]\hat{U}^{\intercal}.
$$

This choice is theoretically motivated by eigenspace-alignment between $W_{p}$ and $F$ (Theorem. 3) and convergence to the invariant parabola $s_{j}\propto p_{j}^{2}$ in Eqn. 14 with weight decay ($\eta>0$). Here the estimate correlation matrix $\hat{F}$ can be obtained by a moving average:

$$
\hat{F}=\rho\hat{F}+(1-\rho)\mathbb{E}_{B}\left[{\bm{f}}{\bm{f}}^{\intercal}\right]
$$

where $\mathbb{E}_{B}\left[\cdot\right]$ is the expectation over a batch. Note that where ${\bm{f}}$ is not zero-mean, we keep $\hat{F}$ a correlation matrix (rather than a covariance) *without* zero-centering ${\bm{f}}$, otherwise the performance deteriorates. We also added a regularization factor proportional to a small $\epsilon$ to boost the small eigenvalues $s_{j}$ so they can learn faster. In all our experiments on real-world datasets, we use $\ell_{2}$ -normalization so the absolute magnitude of $s_{j}$ doesn’t matter.

Hyper-parameter freq. Besides, we also evaluate a hybrid approach by introducing freq, which is how frequently eigen-decomposition is conducted for matrix $\hat{F}$ to set $W_{p}$. For example, freq = 5 means that eigen decomposition is run every 5 minibatches. When $W_{p}$ is not set by eigen decomposition, it is updated by regular gradient updates. freq = 1 means the eigen-decomposition is performed at every minibatch.

<table><thead><tr><th></th><th colspan="4">Regularization factor <math><semantics><mi>ϵ</mi> <annotation>\epsilon</annotation></semantics></math></th></tr><tr><th></th><th>0</th><th>0.01</th><th>0.1</th><th>0.5</th></tr></thead><tbody><tr><th><math><semantics><mrow><mi>ρ</mi> <mo>=</mo> <mn>0.3</mn></mrow> <annotation>\rho=0.3</annotation></semantics></math></th><td><math><semantics><mrow><mn>76.77</mn> <mo>±</mo> <mn>0.24</mn></mrow> <annotation>76.77{\pm}0.24</annotation></semantics></math></td><td><math><semantics><mrow><mn>77.11</mn> <mo>±</mo> <mn>0.35</mn></mrow> <annotation>77.11{\pm}0.35</annotation></semantics></math></td><td><math><semantics><mrow><mn>77.86</mn> <mo>±</mo> <mn>0.16</mn></mrow> <annotation>\mathbf{77.86{\pm}0.16}</annotation></semantics></math></td><td><math><semantics><mrow><mn>75.06</mn> <mo>±</mo> <mn>1.10</mn></mrow> <annotation>75.06{\pm}1.10</annotation></semantics></math></td></tr><tr><th><math><semantics><mrow><mi>ρ</mi> <mo>=</mo> <mn>0.5</mn></mrow> <annotation>\rho=0.5</annotation></semantics></math></th><td><math><semantics><mrow><mn>76.65</mn> <mo>±</mo> <mn>0.20</mn></mrow> <annotation>76.65{\pm}0.20</annotation></semantics></math></td><td><math><semantics><mrow><mn>76.76</mn> <mo>±</mo> <mn>0.33</mn></mrow> <annotation>76.76{\pm}0.33</annotation></semantics></math></td><td><math><semantics><mrow><mn>77.56</mn> <mo>±</mo> <mn>0.25</mn></mrow> <annotation>\mathbf{77.56{\pm}0.25}</annotation></semantics></math></td><td><math><semantics><mrow><mn>75.22</mn> <mo>±</mo> <mn>0.81</mn></mrow> <annotation>75.22{\pm}0.81</annotation></semantics></math></td></tr></tbody></table>

Table 6: STL-10 Top-1 after BYOL training for 100 epochs, if we use DirectPred (Eqn. 18). It outperforms training $W_{p}$ using gradient descent ($74.51\%$ in Tbl. 3, regular $W_{p}$ with EMA). EMA is used in all experiments. No predictor bias. $\rho$ defined in Eqn. 19.

<table><thead><tr><th></th><th colspan="4">Initial constant <math><semantics><msub><mi>c</mi> <mi>j</mi></msub> <annotation>c_{j}</annotation></semantics></math></th></tr><tr><th></th><th><math><semantics><mn>0.1</mn> <annotation>0.1</annotation></semantics></math></th><th><math><semantics><mn>0.05</mn> <annotation>0.05</annotation></semantics></math></th><th><math><semantics><mrow><mo>−</mo> <mn>0.05</mn></mrow> <annotation>-0.05</annotation></semantics></math></th><th><math><semantics><mrow><mo>−</mo> <mn>0.1</mn></mrow> <annotation>-0.1</annotation></semantics></math></th></tr></thead><tbody><tr><th>freq=1</th><td><math><semantics><mrow><mn>46.57</mn> <mo>±</mo> <mn>18.43</mn></mrow> <annotation>46.57{\pm}18.43</annotation></semantics></math></td><td><math><semantics><mrow><mn>65.31</mn> <mo>±</mo> <mn>18.22</mn></mrow> <annotation>65.31{\pm}18.22</annotation></semantics></math></td><td><math><semantics><mrow><mn>77.11</mn> <mo>±</mo> <mn>0.66</mn></mrow> <annotation>77.11{\pm}0.66</annotation></semantics></math></td><td><math><semantics><mrow><mn>76.46</mn> <mo>±</mo> <mn>0.55</mn></mrow> <annotation>76.46{\pm}0.55</annotation></semantics></math></td></tr><tr><th>freq=2</th><td><math><semantics><mrow><mn>75.01</mn> <mo>±</mo> <mn>0.48</mn></mrow> <annotation>75.01{\pm}0.48</annotation></semantics></math></td><td><math><semantics><mrow><mn>75.10</mn> <mo>±</mo> <mn>0.35</mn></mrow> <annotation>75.10{\pm}0.35</annotation></semantics></math></td><td><math><semantics><mrow><mn>76.83</mn> <mo>±</mo> <mn>0.52</mn></mrow> <annotation>76.83{\pm}0.52</annotation></semantics></math></td><td><math><semantics><mrow><mn>76.31</mn> <mo>±</mo> <mn>0.27</mn></mrow> <annotation>76.31{\pm}0.27</annotation></semantics></math></td></tr></tbody></table>

Table 7: STL-10 Top-1 Accuracy after BYOL training for 100 epochs. With different $c_{j}$. $\rho=0.3$ and $\epsilon=0$. EMA is used in all experiments. No predictor bias.

Tbl. 6 shows that directly computing $W_{p}$ through DirectPred works *better* ($76.77\%$) than training via gradient descent ($74.51\%$ in Tbl. 3, regular $W_{p}$ with EMA). Additional regularization through $\epsilon$ yields even better performance ($77.38\%$). Different ways to estimate $F$ (moving average or simple average) yield only small differences.

The performance of DirectPred also remains good over many more training epochs (Tbl. 8). Moreover, if we allow some gradient steps in between directly setting $W_{p}$ (i.e., freq > 1), performance becomes even better ($80.28\%$). This might occur because the estimated $\hat{F}$ may not be accurate enough and SGD can help correct it. This also mitigates the computational cost of eigen-decomposition.

The constant $c_{j}$. What happens if $p_{j}=\sqrt{\max(s_{j}-c_{j},0)}$ with $c_{j}\neq 0$? If $c_{j}$ is small negative, performance is still fine but a positive $c_{j}$ leads to very poor performance (Tbl. 7), likely due to many small eigen-values $s_{j}$ becoming zero and therefore trapped in the collapsed basin.

Feature-dependent $W_{p}$. Note one of the advantages of using two layer predictors is that $W_{p}$ can depend on the input features. We explored this idea by using a few random partitions of the input space, and within each random partition we estimated a different correlation matrix $\hat{F}$. The final $\hat{F}$ is the sum of all the correlation matrices. With $6$ random partitions, DirectPred achieves $78.20{\pm}0.16$ Top-1 accuracy after 100 epochs, closing performance gap to two-layer predictors ($78.85\%$ in Tbl. 3). We leave a thorough analysis of the two layer setting to future work.

<table><tbody><tr><th></th><td colspan="3">Number of epochs</td></tr><tr><th></th><td>100</td><td>300</td><td>500</td></tr><tr><th colspan="4"><em>STL-10</em></th></tr><tr><th>DirectPred</th><td><math><semantics><mrow><mn>77.86</mn> <mo>±</mo> <mn>0.16</mn></mrow> <annotation>\mathbf{77.86{\pm}0.16}</annotation></semantics></math></td><td><math><semantics><mrow><mn>78.77</mn> <mo>±</mo> <mn>0.97</mn></mrow> <annotation>78.77{\pm}0.97</annotation></semantics></math></td><td><math><semantics><mrow><mn>78.86</mn> <mo>±</mo> <mn>1.15</mn></mrow> <annotation>78.86{\pm}1.15</annotation></semantics></math></td></tr><tr><th>DirectPred (freq=5)</th><td><math><semantics><mrow><mn>77.54</mn> <mo>±</mo> <mn>0.11</mn></mrow> <annotation>77.54{\pm}0.11</annotation></semantics></math></td><td><math><semantics><mrow><mn>79.90</mn> <mo>±</mo> <mn>0.66</mn></mrow> <annotation>\mathbf{79.90{\pm}0.66}</annotation></semantics></math></td><td><math><semantics><mrow><mn>80.28</mn> <mo>±</mo> <mn>0.62</mn></mrow> <annotation>\mathbf{80.28{\pm}0.62}</annotation></semantics></math></td></tr><tr><th>SGD baseline</th><td><math><semantics><mrow><mn>75.06</mn> <mo>±</mo> <mn>0.52</mn></mrow> <annotation>75.06{\pm}0.52</annotation></semantics></math></td><td><math><semantics><mrow><mn>75.25</mn> <mo>±</mo> <mn>0.74</mn></mrow> <annotation>75.25{\pm}0.74</annotation></semantics></math></td><td><math><semantics><mrow><mn>75.25</mn> <mo>±</mo> <mn>0.74</mn></mrow> <annotation>75.25{\pm}0.74</annotation></semantics></math></td></tr><tr><th colspan="4"><em>CIFAR-10</em></th></tr><tr><th>DirectPred</th><td><math><semantics><mrow><mn>85.21</mn> <mo>±</mo> <mn>0.23</mn></mrow> <annotation>\mathbf{85.21{\pm}0.23}</annotation></semantics></math></td><td><math><semantics><mrow><mn>88.88</mn> <mo>±</mo> <mn>0.15</mn></mrow> <annotation>\mathbf{88.88{\pm}0.15}</annotation></semantics></math></td><td><math><semantics><mrow><mn>89.52</mn> <mo>±</mo> <mn>0.04</mn></mrow> <annotation>89.52{\pm}0.04</annotation></semantics></math></td></tr><tr><th>DirectPred (freq=5)</th><td><math><semantics><mrow><mn>84.93</mn> <mo>±</mo> <mn>0.29</mn></mrow> <annotation>84.93{\pm}0.29</annotation></semantics></math></td><td><math><semantics><mrow><mn>88.83</mn> <mo>±</mo> <mn>0.10</mn></mrow> <annotation>88.83{\pm}0.10</annotation></semantics></math></td><td><math><semantics><mrow><mn>89.56</mn> <mo>±</mo> <mn>0.13</mn></mrow> <annotation>\mathbf{89.56{\pm}0.13}</annotation></semantics></math></td></tr><tr><th>SGD baseline</th><td><math><semantics><mrow><mn>84.49</mn> <mo>±</mo> <mn>0.20</mn></mrow> <annotation>84.49{\pm}0.20</annotation></semantics></math></td><td><math><semantics><mrow><mn>88.57</mn> <mo>±</mo> <mn>0.15</mn></mrow> <annotation>88.57{\pm}0.15</annotation></semantics></math></td><td><math><semantics><mrow><mn>89.33</mn> <mo>±</mo> <mn>0.27</mn></mrow> <annotation>89.33{\pm}0.27</annotation></semantics></math></td></tr></tbody></table>

Table 8: STL-10/CIFAR-10 Top-1 accuracy of DirectPred, after training for longer epochs. $\rho=0.3$, $\epsilon=0.1$ with EMA.

ImageNet experiments. We conducted additional experiments on ImageNet [^11], with our own BYOL [^17] implementation. We used ResNet-50 [^18] as the backbone to produce features for a linear probe, followed by a projector and a predictor. The architecture design (e.g., feature dimensions), augmentation strategies (e.g., color jittering, blur [^7], solarization, etc.) and linear classification protocol strictly follow BYOL [^17].

We experimented with two different training settings to study the generalization ability of DirectPred. In the first setting, we employ an asymmetric loss (given two views, only one view is used as the prediction target). The loss is optimized using standard SGD for 60 epochs with a batch size of 256. The second setting follows BYOL more closely, where we use a symmetrized loss, 4096 batch size and LARS optimizer [^34], and train for 300 epochs.

The results are summarized in Tbl. 9. Both settings exhibit similar behaviors in comparison, and we take the 300-epoch results as our highlights in the following. As a baseline, the default 2-layer predictor from BYOL (with BatchNorm and ReLU, 4096 hidden dimension, 256 input/output dimension) achieves 72.5% top-1 accuracy, and 90.8% top-5 accuracy with 300-epoch pre-training. This reproduces the accuracy reported in BYOL [^17]. We find DirectPred can match this performance (72.4% top-1, and 91.0% top-5) *without* any gradient-based training by instead directly setting the (256 $\times$ 256) linear predictor weights every mini-batch. In particular for top-5 DirectPred is even 0.2% better. For a fair comparison, we also run BYOL with a learned linear predictor. We find the performance drops to 69.9%, and 89.6% respectively (2.5% gap to our method). The gap is even bigger in 60-epoch settings, up to 5.0% in top-1 (59.4% vs. 64.4%). These experiments demonstrate the success of DirectPred on STL-10 and CIFAR can also generalize and scale to ImageNet.

## 5 Discussion

#### Summary.

Therefore, remarkably, our theoretical analysis of non-contrastive SSL, primarily centered around a $3$ dimensional nonlinear dynamical system, not only yields conceptual insights into the functional roles of complex ingredients like EMA, stop-gradients, predictors, predictor symmetry, diverse learning rates, weight decay and all their interactions, but also predicts the performance patterns of many ablation studies as well as suggests an exceedingly simple DirectPred method that rivals the performance of more complex predictor dynamics in real-world settings.

Two-layer non-linear predictor. With only a linear predictor, our results on ImageNet (Tbl. 9) have already shown strong performance, on par with a default BYOL setting with a 2-layer predictor on ImageNet. One interesting question is how the dynamics changes if the predictor has 2 layers. While we don’t provide a formal analysis and the math can be quite complicated, the intuition here is that the “fat” 2-layer predictor used in practice (e.g., more (4096) hidden dimension than input/output dimensions (256), and a ReLU in between) essentially provides a large pool of initial weight directions to start with, and some of them could be “lucky draws”, that make eigen-space alignment faster. On the other hand, a 1-layer predictor with gradient updates may get stuck in local minima. Therefore, with the same number of epochs, a 2-layer predictor outperforms 1-layer, and is comparable with DirectPred which does not suffer from local minima issues.

## Acknowledgements

We thank Lantao Yu for helpful discussions.

<table><thead><tr><th rowspan="2">BYOL variants</th><th colspan="2"><em>Accuracy (60 ep)</em></th><th colspan="2"><em>Accuracy (300 ep)</em></th></tr><tr><th>Top-1</th><th>Top-5</th><th>Top-1</th><th>Top-5</th></tr></thead><tbody><tr><th>2-layer predictor <sup>*</sup></th><td><math><semantics><mn>64.7</mn> <annotation>\mathbf{64.7}</annotation></semantics></math></td><td><math><semantics><mn>85.8</mn> <annotation>\mathbf{85.8}</annotation></semantics></math></td><td><math><semantics><mn>72.5</mn> <annotation>\mathbf{72.5}</annotation></semantics></math></td><td><math><semantics><mn>90.8</mn> <annotation>90.8</annotation></semantics></math></td></tr><tr><th>linear predictor</th><td><math><semantics><mn>59.4</mn> <annotation>59.4</annotation></semantics></math></td><td><math><semantics><mn>82.3</mn> <annotation>82.3</annotation></semantics></math></td><td><math><semantics><mn>69.9</mn> <annotation>69.9</annotation></semantics></math></td><td><math><semantics><mn>89.6</mn> <annotation>89.6</annotation></semantics></math></td></tr><tr><th>DirectPred</th><td><math><semantics><mn>64.4</mn> <annotation>64.4</annotation></semantics></math></td><td><math><semantics><mn>85.8</mn> <annotation>\mathbf{85.8}</annotation></semantics></math></td><td><math><semantics><mn>72.4</mn> <annotation>72.4</annotation></semantics></math></td><td><math><semantics><mn>91.0</mn> <annotation>\mathbf{91.0}</annotation></semantics></math></td></tr></tbody></table>

- 2-layer predictor is BYOL default setting.

Table 9: ImageNet experiments comparing DirectPred with BYOL [^17]. *Without* gradient-based training, DirectPred is able to match the performance of the default 2-layer predictor introduced by BYOL, and significantly outperform the linear predictor by $5\%$ (60 epoch) and $2.5\%$ (300 epoch).

## References

## Appendix A Section

###### Lemma 1 (Dynamics of BYOL/SimSiam).

For objective (${\bm{f}}_{1}=W{\bm{x}}_{1}$ and ${\bm{f}}_{2\mathrm{a}}=W_{\mathrm{a}}{\bm{x}}_{2}$ where $W_{\mathrm{a}}$ is EMA weight):

$$
J(W,W_{p}):=\frac{1}{2}\mathbb{E}_{{\bm{x}}\sim p(\cdot),\ \ {\bm{x}}_{1},{\bm{x}}_{2}\sim p_{\mathrm{aug}}(\cdot|{\bm{x}})}\left[\|W_{p}{\bm{f}}_{1}-\mathrm{StopGrad}({\bm{f}}_{2\mathrm{a}})\|^{2}_{2}\right]
$$

Let $X=\mathbb{E}\left[\bar{\bm{x}}\bar{\bm{x}}^{\intercal}\right]$ where $\bar{\bm{x}}({\bm{x}}):=\mathbb{E}_{{\bm{x}}^{\prime}\sim p_{\mathrm{aug}}(\cdot|{\bm{x}})}\left[{\bm{x}}^{\prime}\right]$ is the average augmented view of a data point ${\bm{x}}$ and $X^{\prime}=\mathbb{E}_{{\bm{x}}}\left[\mathbb{V}_{{\bm{x}}^{\prime}|{\bm{x}}}[{\bm{x}}^{\prime}]\right]$ is the covariance matrix $\mathbb{V}_{{\bm{x}}^{\prime}|{\bm{x}}}[{\bm{x}}^{\prime}]$ of augmented views ${\bm{x}}^{\prime}$ conditioned on ${\bm{x}}$, subsequently averaged over the data ${\bm{x}}$. The dynamics is the following:

$$
\displaystyle\dot{W}_{p}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle-\frac{\partial J}{\partial W_{p}}=-W_{p}W(X+X^{\prime})W^{\intercal}+W_{\mathrm{a}}XW^{\intercal}
$$
 
$$
\displaystyle\dot{W}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle-\frac{\partial J}{\partial W}=-W_{p}^{\intercal}W_{p}W(X+X^{\prime})+W_{p}^{\intercal}W_{\mathrm{a}}X
$$

###### Proof.

Note that

$$
\displaystyle(W_{p}{\bm{f}}_{1}-{\bm{f}}_{2\mathrm{a}})^{\intercal}(W_{p}{\bm{f}}_{1}-{\bm{f}}_{2\mathrm{a}})
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle{\bm{f}}^{\intercal}_{1}W_{p}^{\intercal}W_{p}{\bm{f}}_{1}-{\bm{f}}^{\intercal}_{2\mathrm{a}}W_{p}{\bm{f}}_{1}-{\bm{f}}_{1}^{\intercal}W_{p}^{\intercal}{\bm{f}}_{2\mathrm{a}}+{\bm{f}}_{2\mathrm{a}}^{\intercal}{\bm{f}}_{2\mathrm{a}}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle tr(W_{p}^{\intercal}W_{p}{\bm{f}}_{1}{\bm{f}}_{1}^{\intercal})-tr(W_{p}{\bm{f}}_{1}{\bm{f}}_{2\mathrm{a}}^{\intercal})-tr(W_{p}^{\intercal}{\bm{f}}_{2\mathrm{a}}{\bm{f}}_{1}^{\intercal})+tr({\bm{f}}_{2\mathrm{a}}{\bm{f}}_{2\mathrm{a}}^{\intercal})
$$

Let $F_{1}=\mathbb{E}\left[{\bm{f}}_{1}{\bm{f}}_{1}^{\intercal}\right]=W(X+X^{\prime})W^{\intercal}$ where $X=\mathbb{E}_{{\bm{x}}}\left[\bar{\bm{x}}\bar{\bm{x}}^{\intercal}\right]$ and $X^{\prime}=\mathbb{E}_{{\bm{x}}}\left[\mathbb{V}_{{\bm{x}}^{\prime}|{\bm{x}}}[{\bm{x}}^{\prime}]\right]$, $F_{1,2\mathrm{a}}=\mathbb{E}\left[{\bm{f}}_{1}{\bm{f}}_{2\mathrm{a}}^{\intercal}\right]$, $F_{2\mathrm{a},1}=\mathbb{E}\left[{\bm{f}}_{2\mathrm{a}}{\bm{f}}_{1}^{\intercal}\right]=F_{1,2\mathrm{a}}^{\intercal}$ and $F_{2\mathrm{a}}=\mathbb{E}\left[{\bm{f}}_{2\mathrm{a}}{\bm{f}}^{\intercal}_{2\mathrm{a}}\right]$. This leads to:

$$
\displaystyle J(W,W_{p})
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\frac{1}{2}\left[tr(W_{p}^{\intercal}W_{p}F_{1})-tr(W_{p}F_{1,2\mathrm{a}})-tr(F_{1,2\mathrm{a}}W_{p})+tr(F_{2\mathrm{a}})\right]
$$

Taking partial derivative with respect to $W_{p}$ and we get the gradient update rule:

$$
\dot{W}_{p}=-\frac{\partial J}{\partial W_{p}}=-W_{p}F_{1}+F_{1,2\mathrm{a}}^{\intercal}
$$

Now we take the derivative with respect to $W$. Note that we have stop-gradient in ${\bm{f}}_{2\mathrm{a}}$, so we would like to be careful when taking derivatives. We first compute $\partial J/\partial F_{1}$ and $\partial J/\partial F_{1,2\mathrm{a}}$. Note that both $F_{1}$ and $F_{1,2\mathrm{a}}$ contains $W$, due to the fact that we have stop gradient, $F_{1}$ is a quadratic form of $W$ but $F_{1,2\mathrm{a}}$ is a *linear* form of $W$. This is critical.

$$
\displaystyle\frac{\partial J}{\partial F_{1}}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\frac{1}{2}W_{p}^{\intercal}W_{p}
$$
 
$$
\displaystyle\frac{\partial J}{\partial F_{1,2\mathrm{a}}}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle-W^{\intercal}_{p}
$$

Let $W=[w_{ij}]$ and $X=\mathbb{E}\left[\bar{\bm{x}}\bar{\bm{x}}^{\intercal}\right]$ ($X_{\mathrm{tot}}$ and $X^{\prime}$ are defined similarly). We have $F_{1}=W(X+X^{\prime})W^{\intercal}$ and $F_{1,2\mathrm{a}}=WXW^{\intercal}_{\mathrm{a}}$. So we have:

$$
\frac{\partial J}{\partial w_{ij}}=\sum_{kl}\left[\frac{\partial J}{\partial F_{1}}\right]_{kl}\frac{\partial[F_{1}]_{kl}}{\partial w_{ij}}+\sum_{kl}\left[\frac{\partial J}{\partial F_{1,2\mathrm{a}}}\right]_{kl}\frac{\partial[F_{1,2\mathrm{a}}]_{kl}}{\partial w_{ij}}
$$

Let $C=X+X^{\prime}$, here we have:

$$
\displaystyle\sum_{kl}\left[\frac{\partial J}{\partial F_{1}}\right]_{kl}\frac{\partial[F_{1}]_{kl}}{\partial w_{ij}}=\sum_{kl}\left[\frac{\partial J}{\partial F_{1}}\right]_{kl}\sum_{mn}\frac{\partial w_{km}c_{mn}w_{ln}}{\partial w_{ij}}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\sum_{kl}\left[\frac{\partial J}{\partial F_{1}}\right]_{kl}\left(\delta(i=k)\sum_{n}c_{jn}w_{ln}+\delta(i=l)\sum_{m}w_{km}c_{mj}\right)
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\sum_{l}\left[\frac{\partial J}{\partial F_{1}}\right]_{il}\sum_{n}c_{jn}w_{ln}+\sum_{k}\left[\frac{\partial J}{\partial F_{1}}\right]_{ki}\sum_{m}w_{km}c_{mj}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\left[\frac{\partial J}{\partial F_{1}}WC^{\intercal}+\frac{\partial J}{\partial F^{\intercal}_{1}}WC\right]_{ij}
$$

Similarly (note that we don’t take derivative with respect to $W_{\mathrm{a}}$):

$$
\displaystyle\sum_{kl}\left[\frac{\partial J}{\partial F_{1,2\mathrm{a}}}\right]_{kl}\frac{\partial[F_{1,2\mathrm{a}}]_{kl}}{\partial w_{ij}}=\left[\frac{\partial J}{\partial F_{1,2\mathrm{a}}}W_{\mathrm{a}}X^{\intercal}\right]_{ij}
$$

So we have:

$$
\dot{W}=-\frac{\partial J}{\partial W}=-W_{p}^{\intercal}W_{p}W(X+X^{\prime})+W_{p}^{\intercal}W_{\mathrm{a}}X
$$

After some manipulation, we finally arrive at the following gradient update rule:

$$
\displaystyle\dot{W}_{p}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle[-W_{p}W(X+X^{\prime})+W_{\mathrm{a}}X]W^{\intercal}
$$
 
$$
\displaystyle\dot{W}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle W^{\intercal}_{p}[-W_{p}W(X+X^{\prime})+W_{\mathrm{a}}X]
$$

∎

Remarks. For symmetric loss:

$$
J(W,W_{p}):=\frac{1}{4}\mathbb{E}_{{\bm{x}}\sim p(\cdot),\ \ {\bm{x}}_{1},{\bm{x}}_{2}\sim p_{\mathrm{aug}}(\cdot|{\bm{x}})}\left[\|W_{p}{\bm{f}}_{1}-\mathrm{StopGrad}({\bm{f}}_{2\mathrm{a}})\|^{2}_{2}+\|W_{p}{\bm{f}}_{2}-\mathrm{StopGrad}({\bm{f}}_{1\mathrm{a}})\|^{2}_{2}\right]
$$

The update rule is done by swapping subscript $1$ and $2$ in the update rule of $W_{p}$ (here $F_{2}=\mathbb{E}\left[{\bm{f}}_{2}{\bm{f}}_{2}^{\intercal}\right]$):

$$
\dot{W}_{p}=-\frac{\partial J}{\partial W_{p}}=-\frac{1}{2}W_{p}(F_{1}+F_{2})+\frac{1}{2}(F_{2\mathrm{a},1}+F_{1\mathrm{a},2})
$$

Under the large batch limit, it is the same as Eqn. 41.

Note that the Lemma doesn’t include weight decay. With weight decay $\eta$, it is not hard to see that we will arrive at the following slightly altered gradient flow:

$$
\displaystyle\dot{W}_{p}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle[-W_{p}W(X+X^{\prime})+W_{\mathrm{a}}X]W^{\intercal}-\eta W_{p}
$$
 
$$
\displaystyle\dot{W}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle W^{\intercal}_{p}[-W_{p}W(X+X^{\prime})+W_{\mathrm{a}}X]-\eta W
$$

###### Theorem 1 (Invariance of the Gradient Update).

The gradient update rules (Eqn. 2 and Eqn. 3) has the following invariance (where the symmetric matrix $C$ depends on initialization):

$$
W(t)W^{\intercal}(t)=W_{p}^{\intercal}(t)W_{p}(t)+e^{-2\eta t}C
$$

###### Proof.

From Eqn. 42 and Eqn. 41, we know that

$$
\alpha_{p}^{-1}W_{p}^{\intercal}\dot{W}_{p}+\alpha_{p}^{-1}\eta W_{p}^{\intercal}W_{p}=\dot{W}W^{\intercal}+\eta WW^{\intercal}
$$

Taking transpose and we have:

$$
\alpha_{p}^{-1}\dot{W}^{\intercal}_{p}W_{p}+\alpha_{p}^{-1}\eta W_{p}^{\intercal}W_{p}=W\dot{W}^{\intercal}+\eta WW^{\intercal}
$$

Adding them together and multiply both side with $e^{2\eta t}$:

$$
\alpha_{p}^{-1}\frac{\mathrm{d}}{\mathrm{d}t}(e^{2\eta t}W_{p}^{\intercal}W_{p})=\frac{\mathrm{d}}{\mathrm{d}t}(e^{2\eta t}WW^{\intercal})
$$

This leads to $e^{2\eta t}WW^{\intercal}=\alpha_{p}^{-1}e^{2\eta t}W_{p}^{\intercal}W_{p}+C$, or $WW^{\intercal}=\alpha_{p}^{-1}W_{p}^{\intercal}W_{p}+e^{-2\eta t}C$. ∎

###### Lemma 2 (Dynamics of a negative definite system).

Let $H(t)$ be $d$ -by- $d$ time-varying positive definite (PD) matrices whose minimal eigenvalues are bounded away from 0: $\inf_{t\geq 0}\lambda_{\min}(H(t))\geq\lambda_{0}>0$, then the following dynamics:

$$
\frac{\mathrm{d}{\bm{w}}(t)}{\mathrm{d}t}=-H(t){\bm{w}}(t)
$$

satisfies $\|{\bm{w}}(t)\|_{2}\leq e^{-\lambda_{0}t}\|{\bm{w}}(0)\|_{2}$, which means that ${\bm{w}}(t)\rightarrow 0$.

###### Proof.

Construct the following Lyapunov function $V({\bm{w}}):=\frac{1}{2}\|{\bm{w}}\|^{2}_{2}$. For $V({\bm{w}}(t))$ we have:

$$
\frac{\mathrm{d}V}{\mathrm{d}t}=\frac{\mathrm{d}V}{\mathrm{d}{\bm{w}}}\frac{\mathrm{d}{\bm{w}}}{\mathrm{d}t}=-{\bm{w}}^{\intercal}(t)H(t){\bm{w}}(t)
$$

Note that $H(t)$ has eigen-decomposition: $H(t)=\sum_{j}\lambda_{j}(t){\bm{u}}_{j}(t){\bm{u}}^{\intercal}_{j}(t)$ with all $\lambda_{j}(t)\geq\lambda_{0}$ and $[{\bm{u}}_{1}(t),{\bm{u}}_{2}(t),\ldots,{\bm{u}}_{d}(t)]$ forming an orthonormal bases. Therefore:

$$
{\bm{w}}^{\intercal}H{\bm{w}}=\sum_{j}\lambda_{j}{\bm{w}}^{\intercal}{\bm{u}}_{j}{\bm{u}}^{\intercal}_{j}{\bm{w}}\geq\lambda_{0}{\bm{w}}^{\intercal}\left[\sum_{j}{\bm{u}}_{j}{\bm{u}}^{\intercal}_{j}\right]{\bm{w}}=\lambda_{0}\|{\bm{w}}\|^{2}_{2}
$$

Therefore, we have:

$$
\frac{\mathrm{d}V}{\mathrm{d}t}\leq-\lambda_{0}\|{\bm{w}}(t)\|_{2}^{2}=-2\lambda_{0}V
$$

which leads to $V(t)\leq e^{-2\lambda_{0}t}V(0)$. That is $\|{\bm{w}}(t)\|_{2}\leq e^{-\lambda_{0}t}\|{\bm{w}}(0)\|_{2}$. ∎

###### Theorem 2 (No-stop gradient will not work).

With $W_{\mathrm{a}}=W$ (SimSiam case), removing the stop-gradient signal yields a gradient update for $W$ given by positive semi-definite (PSD) matrix $H(t):=X^{\prime}\otimes(W_{p}^{\intercal}W_{p}+I)+X\otimes\tilde{W}_{p}^{\intercal}\tilde{W}_{p}$ (here $\tilde{W}_{p}:=W_{p}-I$ and $\otimes$ is the Kronecker product):

$$
\frac{\mathrm{d}}{\mathrm{d}t}\mathrm{vec}(W)=-H(t)\mathrm{vec}(W).
$$

If $\inf_{t\geq 0}\lambda_{\min}(H(t))\geq\lambda_{0}>0$, then $W(t)\rightarrow 0$.

###### Proof.

Note that if we don’t have stop gradient and $W_{\mathrm{a}}=W$, then we have additional terms (and we also need to compute $\partial J/\partial F_{2}$). Let $\tilde{W}_{p}=W_{p}-I_{n_{2}}$ and we have:

$$
\displaystyle\dot{W}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle-\frac{\partial J}{\partial W}=-W_{p}^{\intercal}W_{p}W(X+X^{\prime})+(W_{p}^{\intercal}+W_{p})WX-W(X+X^{\prime})-\eta W
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle-(W_{p}^{\intercal}W_{p}+I)WX^{\prime}-(W_{p}^{\intercal}W_{p}-W_{p}^{\intercal}-W_{p}+I)WX-\eta W
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle-(W_{p}^{\intercal}W_{p}+I)WX^{\prime}-(W_{p}-I)^{\intercal}(W_{p}-I)WX-\eta W
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle-(W_{p}^{\intercal}W_{p}+I)WX^{\prime}-\tilde{W}_{p}^{\intercal}\tilde{W}_{p}WX-\eta W
$$

With $\mathrm{vec}(AXB)=(B^{\intercal}\otimes A)\mathrm{vec}(X)$ and we see:

$$
\frac{\mathrm{d}}{\mathrm{d}t}\mathrm{vec}(W)=-\left[X^{\prime}\otimes(W_{p}^{\intercal}W_{p}+I)+X\otimes\tilde{W}_{p}^{\intercal}\tilde{W}_{p}+\eta I_{n_{1}n_{2}}\right]\mathrm{vec}(W)
$$

If $\inf_{t\geq 0}\lambda_{\min}(H(t))\geq\lambda_{0}>0$, then applying Lemma 2 and we have $\|\mathrm{vec}(W(t))\|_{2}\leq e^{-\lambda_{0}t}\|\mathrm{vec}(W(0))\|_{2}\rightarrow 0$, and there is no chance for $W$ to learn any meaningful features. ∎

Remark. Note that if $W_{a}=W$ and we choose not to use the predictor ($W_{p}=I$), then no matter whether we choose to use stop-gradient or not, $W(t)$ always goes to $0$. The theorem above already proved that without stop gradient, it is the case. When there is stop gradient, from Eqn. 3, we have:

$$
\dot{W}=-(X^{\prime}+\eta I)W
$$

Note that $X^{\prime}+\eta I$ is a PD matrix and with similar arguments, $W(t)\rightarrow 0$.

## Appendix B Section

Isometric assumptions. Now we use the assumption that $X=I$ and $X^{\prime}=\sigma^{2}I$, which leads to

$$
\dot{F}=\dot{W}XW^{\intercal}+WX\dot{W}^{\intercal}=-(1+\sigma^{2})(W_{p}^{\intercal}W_{p}F+FW_{p}^{\intercal}W_{p})+W_{p}^{\intercal}W_{\mathrm{a}}W^{\intercal}+WW_{\mathrm{a}}^{\intercal}W_{p}
$$

here $F=WXW^{\intercal}=WW^{\intercal}$. If we also have weight decay $-\eta W$ for $W$, then we have:

$$
\dot{F}=-(1+\sigma^{2})(W_{p}^{\intercal}W_{p}F+FW_{p}^{\intercal}W_{p})+W_{p}^{\intercal}W_{\mathrm{a}}W^{\intercal}+WW_{\mathrm{a}}^{\intercal}W_{p}-2\eta F
$$

or using anticommutator $\{A,B\}:=AB+BA$:

$$
\dot{F}=-(1+\sigma^{2})\{F,W_{p}^{\intercal}W_{p}\}+W_{p}^{\intercal}W_{\mathrm{a}}W^{\intercal}+WW^{\intercal}_{\mathrm{a}}W_{p}-2\eta F
$$

Similarly, for $W_{p}$ we have:

$$
\dot{W}_{p}=-\alpha_{p}(1+\sigma^{2})W_{p}F+\alpha_{p}\tau F-\eta W_{p}
$$

EMA assumption (Assumption 1). Now we further study the effect of EMA. To model it, we just let $W_{\mathrm{a}}=\tau W$ where $\tau<1$ is a coefficient that measure how much EMA attenuates $W$. If $\tau=1$ then $W_{\mathrm{a}}=W$ and there is no EMA. Note that $\tau$ is not the same as the EMA parameter $1-\gamma_{\mathrm{a}}$, which is often set to be a fixed $0.004$ (or $1-0.996$). Instead, $\tau=\tau(t)$ is a changing parameter depends on how quickly $W=W(t)$ grows over time. If $W$ remains stable, then $\tau\approx 1$; if $W$ grows rapidly, then $\tau$ becomes small.

Figure 7: Check the validity of EMA assumption (Assumption 1) with different EMA coefficients $\gamma_{\mathrm{a}}$ for BYOL dynamics with $X=I$ and $X^{\prime}=\sigma^{2}I$ (Assumption 2). $\sigma=0.03$. All experiments are run $10$ times to get mean and standard derivation (shaded area). We could see the EMA assumption is largely correct. Even at the region with $\gamma_{\mathrm{a}}$ close to $1$ (e.g., $0.996$) and large $\eta$, the normalized correlation between $W_{\mathrm{a}}$ and $W$ are still high ($\sim 0.9$). Note that throughout our analysis, the initial value of $W_{\mathrm{a}}(0)=0$. Left: weight decay $\eta=0$, Middle: $\eta=0.01$, Right: $\eta=0.1$.

Fig. 7 shows that this assumption is largely correct.

Under this condition, using $F=WXW^{\intercal}=WW^{\intercal}$, the dynamics becomes (Now we also put weight decay for $W_{p}$):

$$
\displaystyle\dot{W}_{p}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle-\alpha_{p}(1+\sigma^{2})W_{p}F+\alpha_{p}\tau F-\eta W_{p}
$$
 
$$
\displaystyle\dot{F}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle-(1+\sigma^{2})(W_{p}^{\intercal}W_{p}F+FW_{p}^{\intercal}W_{p})+\tau(W_{p}^{\intercal}F+FW_{p})-2\eta F
$$

Derivation of Fixed point of Eqn. 2. Given the dynamics Eqn. 62 we now want to check its fixed point:

$$
-\alpha_{p}(1+\sigma^{2})W_{p}F+\alpha_{p}\tau F-\eta W_{p}=0
$$

for some PSD matrix $F$. For convenience, let $\eta^{\prime}=\eta/\alpha_{p}$. Since $F$ is always PSD, we have eigendecomposition $F=U\Lambda U^{\intercal}$. Left-multiplying $U$ and right-multiplying $U^{\intercal}$, we have:

$$
(1+\sigma^{2})\bar{W}_{p}\Lambda+\eta^{\prime}\bar{W}_{p}=\tau\Lambda
$$

where $\bar{W}_{p}:=U^{\intercal}W_{p}U$. Let $\Lambda^{\prime}=(1+\sigma^{2})\Lambda+\eta^{\prime}I$ is a diagonal matrix with all positive diagonal element since $\eta^{\prime}>0$. Therefore, we have:

$$
\bar{W}_{p}\Lambda^{\prime}=\tau\Lambda
$$

and thus $\bar{W}_{p}=\tau\Lambda(\Lambda^{\prime})^{-1}$ is a symmetric matrix and so does $W_{p}=U\bar{W}_{p}U^{\intercal}$. When $\eta=0$ and $F$ has zero eigenvalues, $W_{p}$ can have infinite solutions (or fixed points), and some of them might not be symmetric.

Symmetrization of $W_{p}$. Now we need to assume $W_{p}$ is symmetric and also symmetrize its dynamics, which yields (here $\{A,B\}:=AB+BA$):

$$
\displaystyle\dot{W}_{p}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle-\frac{\alpha_{p}}{2}(1+\sigma^{2})\{W_{p},F\}+\alpha_{p}\tau F-\eta W_{p}
$$
 
$$
\displaystyle\dot{F}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle-(1+\sigma^{2})\{W_{p}^{2},F\}+\tau\{W_{p},F\}-2\eta F
$$

Note that the asymmetric dynamic might be interesting and we will leave it later.

### B.1 Section

###### Theorem 3 (Alignment of Eigenspace).

Under the dynamics of Eqn. 67, the commutator $[F,W_{p}]:=FW_{p}-W_{p}F$ satisfies:

$$
\frac{\mathrm{d}}{\mathrm{d}t}[F,W_{p}]=-[F,W_{p}]K-K[F,W_{p}]
$$

where

$$
K=K(t)=(1+\sigma^{2})\left[\frac{\alpha_{p}}{2}F(t)+W_{p}^{2}(t)-\frac{\tau}{1+\sigma^{2}}W_{p}(t)\right]+\frac{3}{2}\eta I
$$

If $\max_{t\geq 0}\lambda_{\min}[K(t)]=\lambda_{0}>0$, then the commutator $\|[F(t),W_{p}(t)]\|_{F}\leq e^{-2\lambda_{0}t}\|[F(0),W_{p}(0)]\|_{F}\rightarrow 0$, i.e., the eigenspace of $W_{p}$ gradually aligns with $F$.

###### Proof.

Let’s compute the commutator $L:=[F,W_{p}]:=FW_{p}-W_{p}F$ and its time derivative. First we have:

$$
F\dot{W}_{p}-\dot{W}_{p}F=-\frac{\alpha_{p}}{2}(1+\sigma^{2})(FL+LF)-\eta L
$$

Then we have

$$
\dot{F}W_{p}-W_{p}\dot{F}=-(1+\sigma^{2})(W_{p}^{2}L+LW_{p}^{2})+\tau(W_{p}L+LW_{p})-2\eta L
$$

So we have

$$
\dot{L}=F\dot{W}_{p}+\dot{F}W_{p}-(W_{p}\dot{F}+\dot{W}_{p}F)=-KL-LK
$$

where

$$
K=K(t)=(1+\sigma^{2})\left[\frac{\alpha_{p}}{2}F+W_{p}^{2}-\frac{\tau}{1+\sigma^{2}}W_{p}\right]+\frac{3}{2}\eta I
$$

is a symmetric matrix. We can write the dynamics of $L(t)$:

$$
\frac{\mathrm{d}\mathrm{vec}(L(t))}{\mathrm{d}t}=-\left[K(t)\oplus K(t)\right]\mathrm{vec}(L(t))
$$

where $K(t)\oplus K(t):=I\otimes K(t)+K(t)\otimes I$ is the Kronecker sum and is a PSD matrix if $K$ is PSD.

If $\inf_{t\geq 0}\lambda_{\min}(K(t))\geq\lambda_{0}>0$ for all $t$, then $\inf_{t\geq 0}\lambda_{\min}[K(t)\oplus K(t)]\geq 2\lambda_{0}$. Applying Lemma 2 and we have:

$$
\|\mathrm{vec}(L)\|_{2}\leq e^{-2\lambda_{0}t}\|\mathrm{vec}(L(0))\|_{2}\rightarrow 0
$$

This means that $W_{p}$ and $F$ can commute, and the eigen space of $W_{p}$ and $F$ will gradually align. ∎

Remark. Fig. 9 shows numerical simulation of the symmetrized dynamics (Eqn. 67). If $K(t)$ has negative eigenvalues, then even if $W_{p}$ and $F$ have already approximately aligned, the dynamics is also unstable and might diverge due to noise and/or numerical instability.

Fig. 8 shows a numerical simulation of Eqn. 62 (dynamics with Assumption 1 and Assumption 2 but without the symmetric dynamics). We can clearly see that the asymmetric component converges to zero.

Figure 8: Dynamics of the symmetric $A:=(W_{p}+W_{p}^{\intercal})/2$ and asymmetric part $B:=(W_{p}-W_{p}^{\intercal})/2$ of $W_{p}$ under different *time-independent* $\tau$ of Eqn. 62. Each row is a different weight decay $\eta$ (i.e., $\eta=0.001$, $0.01$ and $0.05$). When $\eta$ is large and/or $\tau$ is small, $\|A\|_{F}$ can also be dragged to zero, which is consistent with analysis in Sec. 3.2 (Obs#4 and Obs#5). On the other hand, $\|B\|_{F}$ always seems to vanish over time. In this numerical simulation, we set $F=W_{p}^{\intercal}W_{p}$ following invariant in Theorem 1 with $C=0$.

Figure 9: The norm of the communicator $[F,W_{p}]$ over time under different hyper-parameters (different *time-independent* $\tau$ and different weight decay $\eta$) in symmetrized dynamics Eqn. 67. When weight decay is small or zero, and/or $\tau$ is large, the norm of the communicator $\|[F,W_{p}]\|_{F}$ can shoot up (no eigenspace alignment).

When eigenspace aligns exactly. Let $U$ be the common eigenvectors. $W_{p}=U\Lambda_{W_{p}}U^{\intercal}$ where $\Lambda_{W_{p}}=\mathrm{diag}[p_{1},p_{2},\ldots,p_{d}]$, $F=U\Lambda_{F}U^{\intercal}$ where $\Lambda_{F}=\mathrm{diag}[s_{1},s_{2},\ldots,s_{d}]$.

In this case, the time derivatives $\dot{W}_{p}$ and $\dot{F}$ can all be written as decoupled form: $\dot{W}_{p}=UG_{1}U^{\intercal}$ and $\dot{F}=UG_{2}U^{\intercal}$ where $G_{1}$ and $G_{2}$ are diagonal matrices. In other words, they are both *decoupled* into each eigen mode, and so does the future value of $W_{p}$ and $F$. Then $U$ won’t change over time.

To see why, we consider the general case where we have a symmetric matrix $M(t)$ with eigen decomposition $M(t)=U(t)D(t)U^{\intercal}(t)$. $M$ follows $\dot{M}=U(t)G(t)U^{\intercal}(t)$ where $G(t)$ is an arbitrary diagonal matrix.

To see why $\dot{U}=0$, at each time step we have:

$$
\dot{M}=\dot{U}DU^{\intercal}+U\dot{D}U^{\intercal}+UD\dot{U}^{\intercal}=UGU^{\intercal}
$$

since $U$ is unitary, we have:

$$
U^{\intercal}\dot{U}D+D\dot{U}^{\intercal}U=G-\dot{D}
$$

Since $U^{\intercal}(t)U(t)=I$, we have $\dot{U}^{\intercal}U+U^{\intercal}\dot{U}=0$ so $Q:=U^{\intercal}\dot{U}$ is a skew-symmetric matrix and we have

$$
QD-DQ=G-\dot{D}
$$

Since the right hand side is a diagonal matrix, checking each entry and we have $q_{ij}d_{j}-q_{ij}d_{i}=0$ for $i\neq j$. If $M$ has distinctive eigenvalues, then we know $q_{ij}=0$ for $i\neq j$. $Q$ is skew-symmetric so $q_{ii}=0$. So $Q=U^{\intercal}\dot{U}=0$ and thus $\dot{U}=0$. If $M$ has duplicated eigenvalues, then we can show $q_{ij}=0$ for any $d_{i}\neq d_{j}$. Within high-dimensional eigenspace for duplicated eigenvalues, its eigen-decomposition is not unique and we can always pick the eigenspace within each duplicated eigenspace so that $\dot{U}=0$.

Therefore, we just multiply $U^{\intercal}$ and $U$ to Eqn. 67 and the system becomes decoupled. Then after some algebraic manipulation, we arrive at the following:

$$
\displaystyle\dot{p}_{j}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\alpha_{p}(1+\sigma^{2})s_{j}\left[\frac{\tau}{1+\sigma^{2}}-p_{j}\right]-\eta p_{j}
$$
 
$$
\displaystyle\dot{s}_{j}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle 2(1+\sigma^{2})p_{j}s_{j}\left[\frac{\tau}{1+\sigma^{2}}-p_{j}\right]-2\eta s_{j}
$$

Multiply Eqn. 79 with $2\alpha^{-1}_{p}p_{j}$ and subtract with Eqn. 80, we get:

$$
2\alpha^{-1}_{p}p_{j}\dot{p}_{j}-\dot{s}_{j}=-2\eta\alpha^{-1}_{p}p_{j}^{2}+2\eta s_{j}
$$

which gives

$$
\displaystyle\alpha_{p}^{-1}\left(\frac{\mathrm{d}p_{j}^{2}}{\mathrm{d}t}+2\eta p_{j}^{2}\right)
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\dot{s}_{j}+2\eta s_{j}
$$
 
$$
\displaystyle\alpha_{p}^{-1}\frac{\mathrm{d}}{\mathrm{d}t}(e^{2\eta t}p_{j}^{2})
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\frac{\mathrm{d}}{\mathrm{d}t}(e^{2\eta t}s_{j})
$$
 
$$
\displaystyle\alpha_{p}^{-1}e^{2\eta t}p_{j}^{2}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle e^{2\eta t}s_{j}-c_{j}
$$
 
$$
\displaystyle\alpha_{p}^{-1}p_{j}^{2}(t)
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle s_{j}(t)-e^{-2\eta t}c_{j}
$$

Therefore, we have integral $s_{j}(t)=\alpha_{p}^{-1}p_{j}^{2}(t)+c_{j}e^{-2\eta t}$. For finite weight decay ($\eta>0$), we could simply expect $s_{j}(t)\approx\alpha_{p}^{-1}p_{j}^{2}(t)$.

On the other hand, the dynamics of $\tau$ is:

$$
\dot{W}_{\mathrm{a}}=\beta(W-W_{\mathrm{a}})
$$

Applying our assumption about EMA (Assumption 1) $W_{\mathrm{a}}(t)=\tau(t)W(t)$, then we have:

$$
\displaystyle\dot{\tau}W+\tau\dot{W}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\beta(1-\tau)W
$$
 
$$
\displaystyle\dot{\tau}WW^{\intercal}+\tau\dot{W}W^{\intercal}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\beta(1-\tau)WW^{\intercal}
$$
 
$$
\displaystyle 2\dot{\tau}F+\tau\dot{F}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle 2\beta(1-\tau)F
$$

When $F$ and $W_{p}$ aligns, we have $\dot{F}$ all in the same eigen space.

$$
\dot{F}=-(1+\sigma^{2})\{W_{p}^{2},F\}+\tau\{W_{p},F\}-2\eta F
$$

So the eigenvectors $U$ won’t change and thus we have:

$$
2\dot{\tau}s_{j}+\tau\dot{s}_{j}=2\beta(1-\tau)s_{j}
$$

or

$$
\dot{\tau}=\beta(1-\tau)-\tau\frac{\dot{s}_{j}}{2s_{j}}
$$

which has a close form solution when $c_{j}=0$. Note that in the case, we have $s_{j}=\alpha_{p}^{-1}p_{j}^{2}$ and thus $\dot{s}_{j}=2\alpha^{-1}_{p}p_{j}\dot{p}_{j}$ and we have:

$$
\dot{\tau}=\beta(1-\tau)-\tau\frac{\dot{p}_{j}}{p_{j}}
$$

or

$$
\dot{\tau}+\tau\left(\frac{\dot{p}_{j}}{p_{j}}+\beta\right)=\beta
$$

or

$$
\frac{\mathrm{d}}{\mathrm{d}t}(e^{f(t)}\tau)=\beta e^{f(t)}
$$

where $f(t)=\int(\dot{p}_{j}/p_{j}+\beta)\mathrm{d}t=\ln p_{j}+\beta t$ and thus $e^{f(t)}=e^{\beta t}p_{j}$. Take integral on both side and we have (here $\tau(0)=0$ is the initial condition):

$$
e^{\beta t}p_{j}\tau=\beta\int_{0}^{t}e^{\beta t^{\prime}}p_{j}(t^{\prime})\mathrm{d}t
$$

which is:

$$
\tau_{j}(t)=p^{-1}_{j}(t)\beta e^{-\beta t}\int_{0}^{t}p_{j}(t^{\prime})e^{\beta t^{\prime}}\mathrm{d}t
$$

### B.2 Section

Monotonicity of $p_{j-}^{*}$ with respect to $\eta$ and $\tau$. Note that

$$
p_{j-}^{*}=\frac{\tau-\sqrt{\tau^{2}-4\eta(1+\sigma^{2})}}{2(1+\sigma^{2})}
$$

is the (right) boundary of trivial basin $p<p_{j-}^{*}$ and determines the size of trivial attractive region towards $p_{j0}^{*}=0$. It is dependent on $\eta$ and $\tau$. It is clear that $p_{j-}^{*}$ is a increasing function of $\eta$. This means that if the weight decay $\eta$ is large, so does trivial region (and more eigenvalues will be trapped to trivial solution).

On the other hand, we can compute the derivative of $g(x)=x-\sqrt{x^{2}-c}$ for $c>0$ and $x^{2}>c$:

$$
\frac{\mathrm{d}g}{\mathrm{d}x}=1-\frac{1}{\sqrt{1-c/x^{2}}}<0
$$

So $g(x)$ is a decreasing function with respect to $x$. Or $p^{*}_{j-}$ is a decreasing function with respect to $\tau$.

## Appendix C Section

Experiment setup. Unless explicitly stated, in all our experiments, we use ResNet-18 as the backbone network, two-layer MLP (with BN and ReLU) as the projector, and a linear predictor. For STL-10 and CIFAR-10, we use SGD as the optimizer with learning rate $\alpha=0.03$, momentum $0.9$, weight decay $\bar{\eta}=0.0004$ and EMA parameter $\gamma_{\mathrm{a}}=0.996$. The batchsize is 128. Each setting is repeated 5 times to compute mean and standard derivation. We report final number as “ $\mathrm{mean}{\pm}\mathrm{std}$ ”.

## Appendix D Analysis of BYOL and SimSiam learning dynamics without isotropic assumptions on data

In the main paper we focused on isotropic data assumptions to obtain analytic insights into when and why BYOL and SimSiam learning dynamics avoid representational collapse. Here we provide an alternate perspective using a different assumption, involving decoupled initial conditions, that enables us to address the case of learning with non-isotropic data. First, we recall the data generation and augmentation process. Let ${\bm{x}}$ be a data point drawn from the data distribution $p({\bm{x}})$ and let ${\bm{x}}_{1}$ and ${\bm{x}}_{2}$ be two augmented views of ${\bm{x}}$: ${\bm{x}}_{1},{\bm{x}}_{2}\sim p_{\mathrm{aug}}(\cdot|{\bm{x}})$ where $p_{\mathrm{aug}}(\cdot|{\bm{x}})$ is the augmentation distribution. Let $\Sigma^{s}=\mathbb{E}\left[{\bm{x}}_{1}{\bm{x}}_{1}^{\intercal}\right]$ be the correlation matrix of a single augmented view ${\bm{x}}_{1}$ of the data ${\bm{x}}$, and let $\Sigma^{d}=\mathbb{E}\left[{\bm{x}}_{1}{\bm{x}}_{2}^{\intercal}\right]$ be the correlation matrix between two augmented views ${\bm{x}}_{1}$ and ${\bm{x}}_{2}$ of the same data point ${\bm{x}}$. In the notation of the main paper, $\Sigma^{s}$ and $\Sigma^{d}$ can be decomposed as $\Sigma^{s}=X+X^{\prime}$ and $\Sigma^{d}=X$, where $X=\mathbb{E}\left[\bar{\bm{x}}\bar{\bm{x}}^{\intercal}\right]$ and $\bar{\bm{x}}({\bm{x}}):=\mathbb{E}_{{\bm{x}}^{\prime}\sim p_{\mathrm{aug}}(\cdot|{\bm{x}})}\left[{\bm{x}}^{\prime}\right]$ is the average augmented view of a data point ${\bm{x}}$. In turn $X^{\prime}=\mathbb{E}_{{\bm{x}}}\left[\mathbb{V}_{{\bm{x}}^{\prime}|{\bm{x}}}[{\bm{x}}^{\prime}]\right]$ is the covariance matrix $\mathbb{V}_{{\bm{x}}^{\prime}|{\bm{x}}}[{\bm{x}}^{\prime}]$ of augmented views ${\bm{x}}^{\prime}$ conditioned on ${\bm{x}}$, subsequently averaged over the data ${\bm{x}}$. Intuitively, $X$ is the correlation matrix of augmentation averaged data, while $X^{\prime}$ is the augmentation covariance matrix averaged over data.

Also recall that the BYOL learning dynamics, without weight decay, is given by

$$
\displaystyle\dot{W}\!\!
$$
$$
\displaystyle\!\!=\!\!
$$
$$
\displaystyle\!\!W^{\intercal}_{p}\left(-W_{p}W\Sigma^{s}+W_{\mathrm{a}}\Sigma^{d}\right)
$$
 
$$
\displaystyle\dot{W}_{p}\!\!
$$
$$
\displaystyle\!\!=\!\!
$$
$$
\displaystyle\!\!\alpha_{p}\left(-W_{p}W\Sigma^{s}+W_{\mathrm{a}}\Sigma^{d}\right)W^{\intercal}
$$
 
$$
\displaystyle\dot{W}_{\mathrm{a}}\!\!
$$
$$
\displaystyle\!\!=\!\!
$$
$$
\displaystyle\!\!\beta(-W_{\mathrm{a}}+W)
$$

SimSiam learning dynamics is a special case in which $W_{\mathrm{a}}=W$ and the final equation is ignored.

We first derive exact fixed point solutions to both BYOL and SimSiam learning dynamics in this setting. We then discuss specific models for data distributions and augmentation procedures, and show how the fixed point solutions depend on both data and augmentation distributions. We then discuss how our theory reveals a fundamental role for the predictor in avoiding collapse in BYOL solutions. Finally, we derive a highly reduced three dimensional description of BYOL and SimSiam learning dynamics, assuming decopuled initial conditions, that provides considerable insights into dynamical mechanisms enabling both to avoid collapsed solutions without negative pairs to force apart representations of different objects.

### D.1 The fixed point structure of BYOL and Simsiam learning dynamics.

Examining equation 100-equation 102, we find sufficient conditions for a fixed point given by $W_{p}W\Sigma^{s}=W_{\mathrm{a}}\Sigma^{d}$ and $W=W_{\mathrm{a}}$. Note these are sufficient conditions for fixed points of both BYOL and SimSiam. Inserting the second equation into the first and right multiplying both sides by $[\Sigma^{s}]^{-1}$ (assuming $\Sigma^{s}$ is invertible), yields a manifold of fixed point solutions in $W_{1}$ and $W_{2}$ satisfying the nonlinear equation

$$
W_{p}W=W\Sigma^{d}[\Sigma^{s}]^{-1}.
$$

This constitutes a set of $n_{1}\times n_{2}$ nonlinear equations in ($n_{1}\times n_{2})+(n_{2}\times n_{2}$) unknowns, yielding generically a nonlinear manifold of solutions in $W_{1}$ and $W_{2}$ of dimensionality $n_{2}\times n_{2}$ corresponding to the number of predictor parameters. For concreteness, we will assume that $n_{2}\leq n_{1}$, so that the online and target networks perform dimensionality reduction. Then a special class of solutions to equation 103 can be obtained by assuming the $n_{2}$ rows of $W$ correspond to $n_{2}$ left-eigenvectors of $\Sigma^{d}[\Sigma^{s}]^{-1}$ and $W_{p}$ is a diagonal matrix with the corresponding eigenvalues. This special class of solutions can then be generalized by a transformation $W_{p}\rightarrow SW_{p}S^{-1}$ and $W\rightarrow SW$ where $S$ is any invertible $n_{2}$ by $n_{2}$ matrix. Indeed this transformation is a symmetry of equation 103, which defines the solution manifold. In addition to these families of solutions, the collapsed solution $W=W_{p}=W_{\mathrm{a}}=0$ also exists.

### D.2 Illustrative models for data and data augmentation

The above section suggests that the top eigenmodes of $\Sigma^{d}[\Sigma^{s}]^{-1}$ control the non-collapsed solutions. Here we make this result more concrete by giving illustrative examples of data distributions and data augmentation procedures, and the resulting properties of $\Sigma^{d}[\Sigma^{s}]^{-1}$.

#### Multiplicative scrambling.

Consider for example a multiplicative subspace scrambling model. In this model, data augmentation scrambles a subspace by multiplying by a random Gaussian matrix, while identically preserving the orthogonal complement of the subspace. In applications, the scrambled subspace could correspond to a space of nuisance features, while the preserved subspace could correspond to semantically important features. Indeed many augmentation procedures, including random color distortions and blurs, largely preserve important semantic information, like object identity in images.

More precisely, we consider a random scrambling operator ${A}$ which only scrambles data vectors ${\bm{x}}$ within a fixed $k$ dimensional subspace spanned by the orthonormal columns of the $n_{0}\times k$ matrix ${U}$. Within this subspace, data vectors are scrambled by a random Gaussian $k\times k$ matrix ${B}$. Thus ${A}$ takes the form ${A}={P}^{c}+UBU^{T}$ where ${P}^{c}={I}-{UU}^{T}$ is a projection operator onto the $n_{0}-k$ dimensional conserved, semantically important, subspace orthogonal to the span of the columns of ${U}$, and the elements of ${B}$ are i.i.d. zero mean unit variance Gaussian random variables so that $\mathbb{E}\left[B_{ij}B_{kl}\right]=\delta_{ik}\delta_{jl}$. Under this simple model, the augmentation average $\bar{\bm{x}}({\bm{x}}):=\mathbb{E}_{{\bm{x}}^{\prime}\sim p_{\mathrm{aug}}(\cdot|{\bm{x}})}\left[{\bm{x}}^{\prime}\right]$ becomes $\bar{\bm{x}}({\bm{x}})=P^{c}{\bm{x}}$. Thus, intuitively, under multiplicative subspace scrambling, the only aspect of a data vector that survives averaging over augmentations is the projection of this data vector onto the preserved subspace. Then the correlation matrix of two different augmented views is $\Sigma^{d}=P^{c}\Sigma^{x}P^{c}$ while the correlation matrix of two identical views is $\Sigma^{s}=\Sigma^{x}$ where $\Sigma^{x}\equiv\mathbb{E}_{{\bm{x}}\sim p(\cdot)}\left[{\bm{x}}{\bm{x}}^{T}\right]$ is the correlation matrix of the data distribution. Thus non-collapsed solutions of both BYOL and SimSiam can correspond to principal eigenmodes of $\Sigma^{d}[\Sigma^{s}]^{-1}=P^{c}\Sigma^{x}P_{c}[\Sigma^{x}]^{-1}$. In the special case in which $P^{c}$ commutes with $\Sigma^{x}$, we have the simple result that $\Sigma^{d}[\Sigma^{s}]^{-1}=P^{c}$, which is completely independent of the data correlation matrix $\Sigma^{x}$. Thus in this simple setting BYOL and SimSiam can learn the subspace of features that are identically conserved under data augmentation, independent of how much data variance there is in the different dimensions of this conserved subspace.

#### Additive scrambling.

We also consider, as an illustrative example, data augmentation procedures which simply add Gaussian noise with a prescribed noise covariance matrix $\Sigma^{n}$. Under this model, we have $\Sigma^{s}=\Sigma^{x}+\Sigma^{n}$ while $\Sigma^{d}=\Sigma^{x}$. Thus in this setting, BYOL learns principal eigenmodes of $\Sigma^{d}[\Sigma^{s}]^{-1}=\Sigma^{x}[\Sigma^{x}+\Sigma^{n}]^{-1}$. Thus intuitively, dimensions with larger noise variance are attenuated in learned BYOL representations. On the otherhand, correlations in the data that are not attenuated by noise are preferentially learned, but the degree to which they are learned is not strongly influenced by the magnitude of the data correlation (i.e. consider dimensions that lie along small eigenvalues of $\Sigma^{n}$). Note that in the main paper we focused on the case where $\Sigma^{x}=I$ and $\Sigma^{n}=\sigma^{2}I$.

### D.3 The importance of the predictor in BYOL and SimSiam.

Here we note that our theory explains why the predictor plays a crucial role in BYOL and SimSiam learning in this simple setting, as is observed empirically in more complex settings. To see this, we can model the removal of the predictor by simply setting $W_{p}=I$ in all the above equations. The fixed point solutions then obey $W=W\Sigma^{d}[\Sigma^{s}]^{-1}$. This will only have nontrivial, non-collapsed solutions if $\Sigma^{d}[\Sigma^{s}]^{-1}$ has eigenvectors with eigenvalue $1$. Rows of $W$ consisting of linear combinations of these eigenvectors will then constitute non-collapsed solutions.

This constraint of eigenvalue $1$ yields a much more restrictive condition on data distributions and augmentation procedures for BYOL and Simsiam to have non-collapsed solutions. It can however be satisfied in multiplicative scrambling if an eigenvector of the data matrix $\Sigma^{x}$ lies in the column space of the projection operator $P^{c}$ (in which case it is an eigenvector of eigenvalue $1$ of $\Sigma^{d}[\Sigma^{s}]^{-1}=P^{c}\Sigma^{x}P_{c}[\Sigma^{x}]^{-1}$. This condition cannot however be generically satisfied for additive scrambling case, in which generically all the eigenvalues of $\Sigma^{d}[\Sigma^{s}]^{-1}=\Sigma^{x}[\Sigma^{x}+\Sigma^{n}]^{-1}$ are less than $1$. In this case, without a predictor, it can be checked that the collapsed solution $W=W_{\mathrm{a}}=0$ is stable.

Thus overall, in this simple setting, our theory provides conceptual insight into how the introduction of a predictor is crucial for creating new non-collapsed solutions for both BYOL and SimSiam, even though the predictor confers no new expressive capacity in allowing the online network to match the target network.

### D.4 Reduction of BYOL learning dynamics to low dimensions

The full learning dynamics in equation 100 to equation 102 constitutes a set of high dimensional nonlinear ODEs which are difficult to solve from arbitrary initial conditions. However, there is a special class of decoupled initial conditions which permits additional insight. Consider the special case in which $\Sigma^{s}$ and $\Sigma^{d}$ commute, and so are simultaneously diagonalizable and share a common set of eigenvectors, which we denote by ${\bm{u}}^{\alpha}\in\mathbb{R}^{n_{0}}$. Consider also a special set of initial conditions where each row of $W$ and the corresponding row of $W_{\mathrm{a}}$ are both proportional to one of the eigenmodes ${\bm{u}}^{\alpha}$, with scalar proportionality constants $w^{\alpha}$ and $w_{\mathrm{a}}^{\alpha}$ respectively, and $W_{p}$ is diagonal, with the corresponding diagonal element given by $w_{p}^{\alpha}$. Then it is straightforward to see that under the dynamics in equation 100 to equation 102, that the structure of this initial condition will remain the same, with only the scalars $w^{\alpha}$, $w_{\mathrm{a}}^{\alpha}$ and $w_{p}^{\alpha}$ changing over time. Moreover, the scalars decouple across the different indices $\alpha$, and the dynamics are driven by the eigenvalues $\lambda_{s}^{\alpha}$ and $\lambda_{d}^{\alpha}$ of $\Sigma_{s}$ and $\Sigma_{d}$ respectively. Inserting this special class of initial conditions into the dynamics in equation 100 to equation 102, and dropping the $\alpha$ index, we find the dynamics of the triplet of scalars is given by

$$
\displaystyle\frac{dw_{p}}{dt}
$$
 
$$
\displaystyle=\alpha_{p}\left[w_{\mathrm{a}}\lambda_{d}-w_{p}w\lambda_{s}\right]w
$$
 
$$
\displaystyle\frac{dw}{dt}
$$
 
$$
\displaystyle=w_{p}\left[w_{\mathrm{a}}\lambda_{d}-w_{p}w\lambda_{s}\right]
$$
 
$$
\displaystyle\frac{dw_{\mathrm{a}}}{dt}
$$
 
$$
\displaystyle=\beta(-w_{\mathrm{a}}+w).
$$

Alternatively, this low dimensional dynamics can be obtained from equation 100 to equation 102 not only by considering a special class of decoupled initial conditions, but also by considering the special case where every matrix is simply a $1$ by $1$ matrix, making the scalar replacements $W\rightarrow w$, $W_{p}\rightarrow w_{p}$, $W_{\mathrm{a}}\rightarrow w_{\mathrm{a}}$, $\Sigma^{s}\rightarrow\lambda_{s}$, and $\Sigma^{d}\rightarrow\lambda_{d}$. Note furthermore that this $3$ dimensional dynamical system is equivalent to that studied in the main paper under the change of variables $s=w^{2}$ and $\tau=w_{\mathrm{a}}/w$ and the special case of $\lambda_{s}=1+\sigma^{2}$ and $\lambda_{d}=1$.

![Refer to caption](https://ar5iv.labs.arxiv.org/html/2102.06810/assets/figs/byol.crop.png)

Figure 10: A visualization of BYOL dynamics in low dimensions. Left: Black arrows denote the vector field of the flow in the w and p w\_{p} plane of online and predictor weights in Eqns. 104 105 when the target network weight a w\_{\\mathrm{a}} is fixed to 1. For all 3 panels, λ s = \\lambda\_{s}=1, d / 2 \\lambda\_{d}=1/2, and α β \\alpha\_{p}=\\beta=1. All flow field vectors are normalized to unit length to indicate direction of flow alone. The red curve shows the hyperoblic manifold of stable fixed points − w\_{p}w=w\_{\\mathrm{a}}\\lambda\_{d}\\lambda\_{s}^{-1}, while the red point at the origin is an unstable fixed point. For a fixed target network, the online and predictor weights will cooperatively amplify each other to escape the collapsed solution at the origin. Middle: A visualization of the full low dimensional BYOL dynamics in Eqns - 106 when the online and predictor weights are tied so that w=w\_{p}. The green curve shows the nullcline w\_{\\mathrm{a}}=w corresponding to t 0 \\frac{dw\_{\\mathrm{a}}}{dt}=0 and the blue curve shows part of the nullcline \\frac{dw}{dt}=0 w^{2}=w\_{\\mathrm{a}}\\lambda\_{d}\\lambda\_{s}^{-1}. The intersection of these two nullclines yields two fixed points (red dots): an unstable collapsed solution at the origin w=w\_{\\mathrm{a}}=0, and a stable non-collapsed solution with w=\\lambda\_{d}\\lambda\_{s}^{-1}. Right: A visualization of dynamics in Eqns when the the predictor is removed, so that w\_{2}. The resulting two dimensional flow field on is shown (black arrows). The green curve shows the nullcline w=w\_{\\mathrm{a}}, while the blue curve shows the nullcline w=w\_{\\mathrm{a}}\\lambda\_{d}\\lambda\_{s}^{-1}. The slope of this nullcline is > \\lambda\_{s}\\lambda\_{d}^{-1}>1. The resulting nullcline structure yields a single fixed point at the origin which is stable. Thus there only exists a collapsed solution. In the special case where \\lambda\_{s}\\lambda\_{d}^{-1}=1, the two nullclines coincide, yielding a one dimensional manifold of solutions.

The fixed point conditions of this dynamics are given by $w_{\mathrm{a}}=w$ and $w_{p}w=w_{\mathrm{a}}\lambda_{d}\lambda_{s}^{-1}$. Thus the collapsed point $w=w_{p}=w_{\mathrm{a}}=0$ is a solution. Additionally $w_{p}=\lambda_{d}\lambda_{s}^{-1}$ and $w=w_{\mathrm{a}}$ taking any value is also a family of non-collapsed solutions. We can understand the three dimensional dynamics intuitively as follows when $\beta$ is much less than both $1$ and $\alpha_{p}$, so that the dynamics of $w$ and $w_{p}$ are very fast relative to the dynamics of $w_{\mathrm{a}}$. In this case, the target network evolves very slowly compared to the online network, as is done in practice. For simplicity we use the same learning rate for the predictor as we do for the online network (i.e. $\alpha_{p}=1$). In this situation, we can treat $w_{\mathrm{a}}$ as approximately constant on the fast time scale over which the online and predictor weights $w$ and $w_{p}$ evolve. Then the joint dynamics in equation 104 and equation 105 obeys gradient descent on the error function

$$
E=\frac{\lambda_{s}}{2}(w_{\mathrm{a}}\lambda_{d}\lambda_{s}^{-1}-w_{p}w)^{2}.
$$

Iso-contours of constant error are hyperbolas in the $w$ by $w_{p}$ plane, and for fixed $w_{\mathrm{a}}$, the origin $w=w_{p}=0$ is a saddle point, yielding an unstable fixed point (see Fig. 10 (left)). From generic initial conditions, $w$ and $w_{p}$ will then cooperatively amplify each other to rapidly escape the collapsed solution at the origin, and approach the zero error hyperbolic contour $w_{p}w=w_{\mathrm{a}}\lambda_{d}\lambda_{s}^{-1}$ where $w_{\mathrm{a}}$ is close to its initial value. Then the slower target network $w_{\mathrm{a}}$ will adjust, slowly moving this contour until $w_{\mathrm{a}}=w$. The more rapid dynamics of $w$ and $w_{p}$ will hug the moving contour $w_{p}w=w_{\mathrm{a}}\lambda_{d}\lambda_{s}^{-1}$ as $w_{\mathrm{a}}$ slowly adjusts. In this fashion, the joint fast dynamics of $w$ and $w_{p}$, combined with the slow dynamics of $w_{\mathrm{a}}$, leads to a nonzero fixed point for all $3$ values, despite the existence of a collapsed fixed point at the origin. Moreover, the larger the ratio $\lambda_{d}\lambda_{s}^{-1}$, which is determined by the data and augmentation, the larger the final values of both $w$ and $w_{p}$ will tend to be.

We can obtain further insight by noting that the submanifold $w=w_{p}$, in which the online and predictor weights are tied, constitutes an invariant submanifold of the dynamics in Eqns. 104 to 106; if $w=w_{p}$ at any instant of time, then this condition holds for all future time. Therefore we can both analyze and visualize the dynamics on this two dimensional invariant submanifold, with coordinates $w=w_{p}$ and $w_{\mathrm{a}}$ (Fig. 10 (middle)). This analysis clearly shows an unstable collapsed solution at the origin, with $w=w_{\mathrm{a}}=0$, and a stable non-collapsed solution at $w=w_{\mathrm{a}}=\lambda_{d}\lambda_{s}^{-1}$.

We note again, that the generic existence of these non-collapsed solutions in Fig. 10 depends critically on the presence of a predictor with adjustable weights $w_{p}$. Removing the predictor corresponds to forcing $w_{p}=1$, and non-collapsed solutions cannot exist unless $\lambda_{d}=\lambda_{s}$, as demonstrated in Fig. 10 (right). Thus, remarkably, in BYOL in this simple setting, the introduction of a predictor network plays a crucial role, even though it neither adds to the expressive capacity of the online network, nor improves its ability to match the target network. Instead, it plays a crucial role by dramatically modifying the learning dynamics (compare e.g. Fig 10 middle and right panels), thereby enabling convergence to noncollapsed solutions through a dynamical mechanism whereby the online and predictor network cooperatively amplify each others’ weights to escape collapsed solutions ( Fig. 10 (left)).

Overall, this analysis of BYOL learning dynamics provides considerable insight into the dynamical mechanisms enabling BYOL to avoid collapsed solutions, without negative pairs to force apart representations, in what is likely to be the simplest nontrivial setting. Further analysis on this model, in direct analogy to the analysis performed on the equivalent $3$ dynamical system (derived under different assumptions) studied in the main paper, can yield similar insights into the dynamics of BYOL and SimSiam under various conditions on learning rates.

[^1]: Arora, S., Cohen, N., and Hazan, E. On the optimization of deep networks: Implicit acceleration by overparameterization. In *ICML*. PMLR, 2018.

[^2]: Arora, S., Khandeparkar, H., Khodak, M., Plevrakis, O., and Saunshi, N. A theoretical analysis of contrastive unsupervised representation learning. 2019.

[^3]: Bachman, P., Hjelm, R. D., and Buchwalter, W. Learning representations by maximizing mutual information across views. *arXiv preprint arXiv:1906.00910*, 2019.

[^4]: Bartlett, P., Helmbold, D., and Long, P. Gradient descent with identity initialization efficiently learns positive definite linear transformations by deep residual networks. In *ICML*, 2018.

[^5]: Bromley, J., Guyon, I., LeCun, Y., Säckinger, E., and Shah, R. Signature verification using a“ siamese” time delay neural network. *NeurIPS*, 1994.

[^6]: Brutzkus, A. and Globerson, A. Globally optimal gradient descent for a convnet with gaussian inputs. In *ICML*, 2017.

[^7]: Chen, T., Kornblith, S., Norouzi, M., and Hinton, G. A simple framework for contrastive learning of visual representations. *arXiv preprint arXiv:2002.05709*, 2020a.

[^8]: Chen, X. and He, K. Exploring simple siamese representation learning. *arXiv preprint arXiv:2011.10566*, 2020.

[^9]: Chen, X., Fan, H., Girshick, R., and He, K. Improved baselines with momentum contrastive learning. *arXiv preprint arXiv:2003.04297*, 2020b.

[^10]: Coates, A., Ng, A., and Lee, H. An analysis of single-layer networks in unsupervised feature learning. In *International conference on artificial intelligence and statistics*, 2011.

[^11]: Deng, J., Dong, W., Socher, R., Li, L.-J., Li, K., and Fei-Fei, L. ImageNet: A Large-Scale Hierarchical Image Database. In *CVPR*, 2009.

[^12]: Devlin, J., Chang, M.-W., Lee, K., and Toutanova, K. Bert: Pre-training of deep bidirectional transformers for language understanding. *arXiv preprint arXiv:1810.04805*, 2018.

[^13]: Du, S. and Hu, W. Width provably matters in optimization for deep linear neural networks. In *ICML*, 2019.

[^14]: Du, S. S., Hu, W., and Lee, J. D. Algorithmic regularization in learning deep homogeneous models: Layers are automatically balanced. *arXiv preprint arXiv:1806.00900*, 2018.

[^15]: Du, S. S., Lee, J. D., Li, H., Wang, L., and Zhai, X. Gradient descent finds global minima of deep neural networks. *ICML*, 2019.

[^16]: Fetterman, A. and Albrecht, J. Understanding self-supervised and contrastive learning with ”bootstrap your own latent” (byol), 2020.  
[https://untitled-ai.github.io/](https://untitled-ai.github.io/understanding-self-supervised-contrastive-learning.html)  
[understanding-self-supervised-](https://untitled-ai.github.io/understanding-self-supervised-contrastive-learning.html)  
[contrastive-learning.html](https://untitled-ai.github.io/understanding-self-supervised-contrastive-learning.html).

[^17]: Grill, J.-B., Strub, F., Altché, F., Tallec, C., Richemond, P. H., Buchatskaya, E., Doersch, C., Pires, B. A., Guo, Z. D., Azar, M. G., et al. Bootstrap your own latent: A new approach to self-supervised learning. *arXiv preprint arXiv:2006.07733*, 2020.

[^18]: He, K., Zhang, X., Ren, S., and Sun, J. Deep residual learning for image recognition. In *CVPR*, 2016.

[^19]: He, K., Fan, H., Wu, Y., Xie, S., and Girshick, R. Momentum contrast for unsupervised visual representation learning. In *CVPR*, 2020.

[^20]: Kawaguchi, K. Deep learning without poor local minima. *NeurIPS*, 2016.

[^21]: Krizhevsky, A., Hinton, G., et al. Learning multiple layers of features from tiny images. 2009.

[^22]: Lampinen, A. K. and Ganguli, S. An analytic theory of generalization dynamics and transfer learning in deep linear networks. In *ICLR*, 2018.

[^23]: Laurent, T. and Brecht, J. Deep linear networks with arbitrary loss: All local minima are global. In *ICML*, pp. 2902–2907. PMLR, 2018.

[^24]: Lee, J. D., Lei, Q., Saunshi, N., and Zhuo, J. Predicting what you already know helps: Provable self-supervised learning. *arXiv preprint arXiv:2008.01064*, 2020.

[^25]: Oord, A. v. d., Li, Y., and Vinyals, O. Representation learning with contrastive predictive coding. *arXiv preprint arXiv:1807.03748*, 2018.

[^26]: Pennington, J., Schoenholz, S., and Ganguli, S. Resurrecting the sigmoid in deep learning through dynamical isometry: theory and practice. In *NeurIPS*. 2017.

[^27]: Pennington, J., Schoenholz, S. S., and Ganguli, S. The emergence of spectral universality in deep networks. In *AISTATS*, 2018.

[^28]: Safran, I. and Shamir, O. Spurious local minima are common in two-layer relu neural networks. In *ICML*. PMLR, 2018.

[^29]: Saxe, A. M., McClelland, J. L., and Ganguli, S. Exact solutions to the nonlinear dynamics of learning in deep linear neural networks. *arXiv preprint arXiv:1312.6120*, 2013.

[^30]: Saxe, A. M., McClelland, J. L., and Ganguli, S. A mathematical theory of semantic development in deep neural networks. *Proc. Natl. Acad. Sci. U. S. A.*, 2019.

[^31]: Tian, Y. An analytical formula of population gradient for two-layered relu network and its applications in convergence and critical point analysis. In *ICML*, 2017.

[^32]: Tian, Y., Krishnan, D., and Isola, P. Contrastive multiview coding. *arXiv preprint arXiv:1906.05849*, 2019.

[^33]: Tosh, C., Krishnamurthy, A., and Hsu, D. Contrastive learning, multi-view redundancy, and linear models. *arXiv preprint arXiv:2008.10150*, 2020.

[^34]: You, Y., Gitman, I., and Ginsburg, B. Large batch training of convolutional networks. *arXiv preprint arXiv:1708.03888*, 2017.