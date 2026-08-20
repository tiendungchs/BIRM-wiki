---
title: "1 LeJEPA overview. Top-left: Training loss exhibits strong correlation with downstream linear probe performance on ImageNet-1k (ViT-base), providing the first practical loss for model selection without supervised probing. Top-right: Training stability without heuristics even on 1.8B ViT-g models, stable training loss. Bottom-left: PCA features from ImageNet-1k pretrained LeJEPA ViT-Large demonstrate clear semantic relationships. Bottom-right: Galaxy10 in-domain results showcasing LeJEPA’s in-domain pretraining consistently outperforms state-of-the-art frontier foundation models transfer learning (DINOv2/v3 trained on natural images) across data regimes from 1-shot to full supervision. This demonstrates that domain-specific SSL beats generic transfer learning, even against massive-scale frontier models, when the framework scales effortlessly to any domain, model, and data scale."
source: "https://arxiv.org/html/2511.08544v3"
author:
published:
created: 2026-06-23
description:
tags:
  - "clippings"
---
LeJEPA: Provable and Scalable  
Self-Supervised Learning Without the Heuristics

Randall Balestriero <sup>1,2</sup>,\*   Yann LeCun <sup>3,2</sup>,\*

<sup>1</sup> Brown University   <sup>3</sup> New York University (NYU)   <sup>2</sup> Meta-FAIR

<sup>*</sup> Equal contribution

Learning manipulable representations of the world and its dynamics is central to AI. Joint-Embedding Predictive Architectures (JEPAs) offer a promising blueprint, but lack of practical guidance and theory has led to ad‑hoc R&D. We present a comprehensive theory of JEPAs and instantiate it in LeJEPA, a lean, scalable, and theoretically grounded training objective. First, we identify the isotropic Gaussian as the optimal distribution that JEPAs’ embeddings should follow to minimize downstream prediction risk. Second, we introduce a novel objective–Sketched Isotropic Gaussian Regularization (SIGReg)–to constrain embeddings to reach that ideal distribution. Combining the JEPA predictive loss with SIGReg yields LeJEPA with numerous theoretical and practical benefits: (i) single trade‑off hyperparameter, (ii) linear time and memory complexity, (iii) stability across hyper-parameters, architectures (ResNets, ViTs, ConvNets) and domains, (iv) heuristics-free, e.g., no stop‑gradient, no teacher–student, no hyper-parameter schedulers, and (v) distributed training-friendly implementation requiring only $\approx$ 50 lines of code. Our empirical validation covers 10+ datasets, 60+ architectures, all with varying scales and domains. As an example, using imagenet-1k for pretraining and linear evaluation with frozen backbone, LeJEPA reaches 79% with a ViT-H/14. We hope that the simplicity and theory-friendly ecosystem offered by LeJEPA will reestablish self-supervised pre-training as a core pillar of AI research ([GitHub repo](https://github.com/rbalestr-lab/lejepa)). Full FT Frozen Method 1-sh Full 1-sh Full LeJEPA (in-domain) ConvNeXt-V2 Nano 29.42 82.72 28.74 76.52 ResNet-34 24.27 83.28 31.08 78.17 Frontier (transfer) DINOv2 ViT-S/16 21.05 78.34 27.68 67.62 DINOv3 ViT-S/16 24.71 81.60 30.17 71.38 Figure 1: LeJEPA overview. Top-left: Training loss exhibits strong correlation with downstream linear probe performance on ImageNet-1k (ViT-base), providing the first practical loss for model selection without supervised probing. Top-right: Training stability without heuristics even on 1.8B ViT-g models, stable training loss. Bottom-left: PCA features from ImageNet-1k pretrained LeJEPA ViT-Large demonstrate clear semantic relationships. Bottom-right: Galaxy10 in-domain results showcasing LeJEPA’s in-domain pretraining consistently outperforms state-of-the-art frontier foundation models transfer learning (DINOv2/v3 trained on natural images) across data regimes from 1-shot to full supervision. This demonstrates that domain-specific SSL beats generic transfer learning, even against massive-scale frontier models, when the framework scales effortlessly to any domain, model, and data scale.

![Refer to caption](https://arxiv.org/html/2511.08544v3/toy_figures/teaser/teaser_manifold_0.png)

Figure 2: Sketched Isotropic Gaussian Regularization (SIGReg): Given some arbitrary input data with density p x p\_{x} with support that may or may not lie on a manifold ( left ), a Deep network (DN) encoder ( f 𝜽 f\_{{\\bm{\\theta}}} ) produces embeddings 𝒛 = ( 𝒙 ) {\\bm{z}}=f\_{{\\bm{\\theta}}}({\\bm{x}}) with some distribution ∼ z {\\bm{z}}\\sim p\_{z} middle ). Our proposed Backward Cramér-Wold Statistics ( Section ˜ 4 ) objective pushes p\_{z} to match a target distribution t p\_{t} by projecting the embeddings along 1 d 1d directions ( middle, arrows ) and enforcing that the univariate densities ( right, colored lines ) match the distribution of, projected along the same directions. Any popular statistical test (provided in 4.2 ) can assess the goodness-of-fit–in practice we argue for characteristic function tests ( ). By using SIGReg with isotropic Gaussian ( right, black lines ), we introduce a lean and provably optimal ( 3 ) JEPA, coined LeJEPA, free of numerous heuristics and able to produce competitive performances ( Sections 5 and 6 ).

## 1  Introduction

Learning manipulable representations of the world and its dynamics is a long‑standing question in AI, with roots dating back centuries ago (von1867handbuch; tolman1948cognitive; gregory1980perceptions; sutton1991dyna; friston2010free). Across domains, e.g., image recognition, robotics, physics, space exploration, the unifying question is how to learn an organized and actionable high‑dimensional embedding space from observations? Using Deep Networks–parameterized nonlinear operators $f_{{\bm{\theta}}}$ –to map observations to embeddings is a standard first piece of that puzzle (lecun2015deep; goodfellow2016deep). The second, less standardized, piece of that puzzle is how to train $f_{{\bm{\theta}}}$. Joint-Embedding Predictive Architectures (JEPAs) suggest training $f_{{\bm{\theta}}}$ by maximizing predictive agreement between the embeddings of semantically related views (bromley1993signature; lecun2022path; balestriero2023cookbook). Views can come in two forms: transformations or corruptions. They can involve masking, cropping, blurring, temporal or spatial translations, geometric or photometric transformations, viewpoint changes, views from different sensor modalities, etc. The supervised forms involve human-produced components such as image-caption pairs, text-code pairs, etc (tian2020makes). In any case, views are expected to share some degree of semantic relationship to allow the prediction task to align $f_{{\bm{\theta}}}$ ’s embeddings towards the underlying knowledge present in the data.

Alas, JEPA’s prediction task admits failure modes, such as representation collapse, where $f_{{\bm{\theta}}}$ maps all inputs to nearly identical embeddings (complete collapse) or to a low-dimensional subspace (dimensional collapse) (jing2021understanding) (jing2021understanding; cosentino2022toward; balestriero2022contrastive). To mitigate such shortcut solutions, state‑of‑the‑art recipes rely on heuristics–stop‑gradient (chen2020simple), asymmetric view generation (wang2022importance), teacher–student networks with carefully tuned EMA schedules (caron2021emerging; tian2021understanding), explicit normalization and whitening layers (ermolov2021whitening; chen2021empirical) –and a delicate balance of hyperparameters. As a result, today’s JEPA training is brittle and most research has shifted toward scaling data (vo2024automatic), models (fan2025scaling) and even post-training rodas2025diet while leaving the theoretical foundations of JEPAs largely unexplored.

Our study proposes to break that cycle by questioning some of the fundamental design principles underpinning JEPAs. That introspection will start by asking what are the necessary conditions that JEPAs should abide by? Those minimal conditions will then act as axioms for us to design a novel and lean JEPA. We identify two axioms: (i) solving the prediction task while (ii) enforcing an isotropic Gaussian distribution of the embeddings (Section˜3). While (i) follows standard practice (balestriero2022contrastive), we introduce in Section˜4 a novel distribution matching objective–Sketched Isotropic Gaussian Regularization (SIGReg)–to enforce (ii). The use of SIGReg not only removes the need for the numerous heuristics previously employed to prevent representation collapse, but SIGReg also exhibits favorable scaling properties as its memory and computational complexity is linear in dimension and sample size. Crucially, SIGReg’s isotropic Gaussian enforcement solves the collapsed shortcut solution and provably minimizes the model’s expected risk over the space of downstream tasks to be encountered post-training. The resulting JEPA solution–coined Latent-Euclidean JEPA (LeJEPA)–is introduced in Section˜5. Beyond theoretical optimality, LeJEPA offers numerous benefits such as (i) provable statistical guarantees, (ii) removal of heuristics such as teacher-student networks, (iii) linear memory and computational complexity, and most importantly (iv) a unified design with a single trade-off parameter that works out of the box across datasets, architectures and scales (see Section˜6). We summarize our contributions below.

Contribution 1: We prove the optimal embedding distribution for foundation models. We establish that the isotropic Gaussian uniquely minimizes downstream prediction risk across broad task families. In Section˜3, we derive this result rigorously for both linear (Section˜3.1) and nonlinear probes (Section˜3.2), providing the first principled answer to what distribution $f_{{\bm{\theta}}}$ ’s embeddings should follow. This theoretical result transforms JEPA design from heuristic exploration to targeted optimization. Contribution 2: We introduce SIGReg, a distribution matching objective that uniquely combines provable correctness with computational efficiency at scale. We present Sketched Isotropic Gaussian Regularization (SIGReg), a novel objective that enforces distributional alignment via random projections and characteristic-function matching (Sections˜4 and 2). SIGReg provides statistical guarantees (Sections˜4.1 and 4.2) while achieving linear complexity and bounded gradients—a combination that existing distribution matching methods do not offer. Critically, its projection-based construction defeats the curse of dimensionality (Section˜4.3), making it both theoretically sound and practically efficient for high-dimensional embeddings.

Contribution 3: We design LeJEPA, a statistically optimal JEPA that eliminates collapse by construction. By combining JEPA’s predictive objective with SIGReg targeting the isotropic Gaussian, we introduce LeJEPA—Latent-Euclidean JEPA (Section˜5). LeJEPA requires only a single hyperparameter, eliminates representational collapse without stop-gradients or teacher-student architectures, and transfers across architectures and datasets without hyperparameter tuning. This demonstrates that principled theory directly yields practical simplicity.

Contribution 4: We validate LeJEPA at scale across diverse architectures and establish in-domain pretraining as viable. Our experiments (Section˜6) span ViTs, ConvNeXts, ResNets, MaxViTs, and Swin Transformers at scales approaching 1 billion parameters, where LeJEPA matches or exceeds state-of-the-art methods while maintaining training simplicity and robustness. Critically, on domain-specific datasets (Galaxy10, Food101), LeJEPA outperforms DINOv2-based transfer learning when pretrained directly on target data. This challenges the transfer learning paradigm and demonstrates that principled SSL can unlock effective in-domain pretraining—previously considered impractical for small datasets.

## 2  Background and Notations

We start by introducing some of the notations we will be using throughout our manuscript (Section˜2.1), followed by a review of JEPAs (Section˜2.2), and existing literature studying their design (Section˜2.3).

### 2.1  Notations and Definitions

![[Uncaptioned image]](https://arxiv.org/html/2511.08544v3/toy_figures/teaser/teaser_JEPA_0.png)

Definition 1:

Data. We are in possession of a dataset of shape $(N,V,D)\in{\mathbb{N}^{*}}^{3}$ where $N$ is the number of samples, $V$ is the number of views, and $D$ is the dimension. One entry of this dataset is accessed via ${\bm{x}}_{n,v,d}$. Those dimensions are often interpreted as follows: (N) is the number of independent samples, e.g., different images or different videos, (V) is the number of views, e.g., data-augmentations for images, frames for videos, and (D) is the dimension of each ${\bm{x}}_{n,v}$, e.g., number of RGB pixels for images. In many cases the ordering over $V$ is given by time–but in some cases, e.g., data-augmentation of an image, ordering becomes irrelevant. Our study does not require any particular choice to organize one’s dataset into a $(N,V,D)$ tensor–and none of our theory and implementation assumes a particular design decision for that tensor. However, we will rely on the following two properties, (independence) the samples ${\bm{x}}_{n},{\bm{x}}_{n^{\prime}}$ have been obtained independently from each other $\forall n\neq n^{\prime}$, and (identically distributed) the sampling process was identical among ${\bm{x}}_{n},\forall n$.

Deep Networks. Today’s AI solutions rely on Deep (Neural) Networks (DNs), which are compositions of a large number of parameterized linear and nonlinear operators. We denote the DN’s mapping as $f_{\bm{\theta}}:\mathbb{R}^{D}\rightarrow\mathbb{R}^{K}$ with $K$ the dimension of the embedding space. The internals of $f_{\bm{\theta}}$ are designed by the researcher to incorporate as much prior knowledge about the data as possible. The details of $f_{\bm{\theta}}$ are irrelevant to our study–as we will see the proposed LeJEPA works out-of-the-box on any $f_{\bm{\theta}}$. In any case, all the learnable parameters are gathered in the vector ${\bm{\theta}}\in\mathbb{R}^{P}$, with $P$ counting the total number of parameters. A central challenge in AI research is to design the right architecture and training objective so that ${\bm{\theta}}$ can be learned from gradient descent to ultimately produce a useful system, or foundation model, $f_{{\bm{\theta}}}$.

JEPAs. A foundation model is any system, e.g., a DN, able to solve numerous downstream tasks without requiring any change in its internal parameters ${\bm{\theta}}$. This is in sharp contrast with a supervised model that only considers its training task. JEPAs have formally been introduced by lecun2022path as a vehicle to produce foundation models. The core building blocks of JEPAs rely on numerous well-established techniques such as siamese networks (bromley1993signature) and predictive coding (helmholtz1867handbook; bruner1949perception). While the exact blueprint of JEPAs varies greatly between use-cases, they all rely on two core principles: (i) being able to predict the embedding of a view ${\bm{x}}_{n,v}$ from the embedding of another view ${\bm{x}}_{n,v^{\prime}},v^{\prime}\neq v$, all while (ii) ensuring that the embeddings do not become degenerate. Concretely, once a JEPA is designed and trained, it should be able to solve numerous downstream tasks in zero or few shots. The JEPA objective function, along with some examples for ${\bm{x}}$, is provided in Equation˜1. The predictability criterion can be done by directly comparing the embeddings of the partial views $Enc({\bm{x}}_{n,v,.})$ and $Enc({\bm{x}}_{n,v^{\prime},.})$ with a metric, e.g., $\ell_{p}$. In some cases, an additional DN coined Pred, is employed to compare $Pred(Enc({\bm{x}}_{n,v,.}))$ against $Enc({\bm{x}}_{n,v^{\prime},.})$ –which is only justified when there exists an asymmetry between the information content of the different views, e.g., by conditioning the predictions on observed actions from robotics data (khazatsky2024droid).

### 2.2  The Need for Reliable Pretraining

The JEPA’s prediction task is designed based on a priori knowledge of the data. Its design is often quite natural since it is relatively intuitive to form ${\bm{x}}$ so that its views share the relevant information content one hope to capture. On the other hand, the design of the “anti-collapse” criterion is much closer to a game of Whac-A-Mole. Today’s designs rely on many different under-specified safeguards which are carefully combined in the hope that degenerate shortcut solutions are avoided during training. Such mechanisms include (i) feature whitening (ermolov2021whitening; bardes2021vicreg), (ii) negative samples (chen2020simple; he2020momentum), and (iii) asymmetric views and teacher-student networks with stop-gradient (caron2021emerging; assran2023self). Those mechanisms all suffer from at least two of the following limitations: (i) under-specification, i.e., the criteria can be minimized while embeddings are in a degenerate configuration, (ii) quadratic time and memory complexity with mini-batch size and/or embedding dimension, (iii) sensitivity to data distribution, hyperparameters, architecture, and (iv) lack of theoretical understanding and guarantees.

### 2.3  The Need for Actionable Theory

For decades, the two major solutions for AI were supervised learning (lecun2015deep) and learning by reconstruction (rumelhart1986learning) –sometimes combined together, e.g., for semi-supervised learning (kingma2014semi). In supervised learning, the labels both ensure that semantically similar samples are close to each other in embedding space while preventing complete representation collapse. In particular, it is possible to measure the amount of collapse in supervised learning as a function of the number of classes (papyan2020prevalence). The reconstruction objective is similarly well suited to prevent representation collapse as the original input must be recovered from the embeddings, i.e., the embeddings must be as informative about the input as possible–up to some optional denoising tasks that users can setup as part of the training (vincent2010stacked).

Because supervised and reconstruction-based learning have been widely studied for decades, there exists a large body of work to explain and inform practical designs–as well as studying their limitations in producing foundation models (balestriero2024learning; van2025joint). This is not the case for the more recent JEPAs where empirical advances quickly outpace anyone hoping to delve into their inner workings. This dynamic led the community to focus on post-hoc theoretical justification of already found solutions (liu2021self; shwartz2024compress; shwartz2022we; zhang2023matrix). In most cases, those studies involve the Mutual Information (MI) (shannon1948mathematical; cover1999elements) whose different bounds recover established methods (gutmann2010noise; ma2018noise; oord2018representation; poole2019variational; hjelm2018learning; mcallester2020formal). Because existing studies focus on explaining and interpreting already developed JEPAs, too little principled guidance and innovation has been brought forward. Instead, most of the recent empirical advances take the form of collecting larger dataset, scaling up pre-existing training recipes (goyal2019scaling; chen2020big; oquab2023dinov2; fan2025scaling), and deriving novel data curation processes (vo2024automatic; kerdreux2025efficient).

In contrast, our goal in the following Sections˜3, 4 and 5 will be to derive a novel JEPA solution from first principles, i.e., whose design relies on proved necessary conditions for optimality, and with a pretraining recipe that can finally reconcile exploratory research, scalability, and state-of-the-art performances.

## 3  Latent Euclidean: Embeddings Should be Isotropic Gaussian

We address a fundamental question: which distribution should ${\rm Enc}({\bm{x}})$ follow to minimize empirical risk on any downstream task? We prove that the isotropic Gaussian is the unique optimal distribution for both linear (Section˜3.1) and nonlinear probing (Section˜3.2), with geometric intuition provided in Section˜3.3. This theoretical result establishes the necessary design principle for our JEPA; Section˜4 then provides the practical implementation to achieve it.

### 3.1  Linear Probing

We begin by identifying the optimal distribution for $f_{\bm{\theta}}$ ’s embeddings by analyzing linear probes–one of the most popular methods for frozen encoder evaluation. Specifically, we ask: *which distribution for $f_{\bm{\theta}}({\bm{x}})$ would be most favorable for solving arbitrary downstream tasks, i.e., for any realization of targets ${\bm{y}}$?*

Denote as ${\bm{Z}}\in\mathbb{R}^{N\times K}$ the matrix of $N$ embeddings, each $K$ -dimensional, from $f_{{\bm{\theta}}}({\bm{x}}_{n})$. The unknown corresponding labels are denoted as ${\bm{y}}\in\mathbb{R}^{N}$. Without loss of generality, we consider univariate targets; the following analysis extends to multivariate targets. The linear probe minimizes the following least square problem (bishop2006pattern)

$$
\hat{\beta}=\underset{\beta\in\mathbb{R}^{K}}{\arg\min}\|{\bm{y}}-{\bm{Z}}\beta\|_{2}^{2}+\lambda\|\beta\|_{2}^{2},
$$

where $\hat{\beta}$ is the optimal probe parameters, and $\lambda\geq 0$ is an hyperparameter controlling the Tikhonov regularizer strength (bishop1995training; golub1999tikhonov). Despite not knowing ${\bm{y}}$, it is possible to describe the bias and variance of the estimator $\hat{\beta}$ as a function of the distribution of ${\bm{Z}}$. Consider two embeddings with identical column spans ${\bm{Z}}_{\rm aniso},{\bm{Z}}_{\rm iso}$. ${\bm{Z}}_{\rm aniso}$ ’s covariance matrix eigenvalues are given by $\{\lambda_{k}\}_{k=1}^{K}$ with at least two distinct values, while ${\bm{Z}}_{\rm iso}$ ’s covariance matrix eigenvalues are all equal to $\frac{1}{K}\sumop\slimits@_{k=1}^{K}\lambda_{k}$. Hence, the two candidate embeddings ${\bm{Z}}_{\rm aniso},{\bm{Z}}_{\rm iso}$ capture the same intrinsic features and have same energy, but different geometries.

<svg height="81.21" id="S3.SS1.p3.pic1" overflow="visible" version="1.1" viewBox="0 0 600 81.21" width="600"><g fill="#000000" stroke="#000000" stroke-width="0.4pt" style="--ltx-stroke-color:#000000;--ltx-fill-color:#000000;" transform="translate(0,81.21) matrix(1 0 0 -1 0 0)"><g fill="#000059" fill-opacity="1.0" style="--ltx-fill-color:#000059;"><path d="M 0 5.91 L 0 75.31 C 0 78.57 2.64 81.21 5.91 81.21 L 594.09 81.21 C 597.36 81.21 600 78.57 600 75.31 L 600 5.91 C 600 2.64 597.36 0 594.09 0 L 5.91 0 C 2.64 0 0 2.64 0 5.91 Z" style="stroke:none"></path></g><g fill="#F7F7FF" fill-opacity="1.0" style="--ltx-fill-color:#F7F7FF;"><path d="M 1.97 5.91 L 1.97 62.21 L 598.03 62.21 L 598.03 5.91 C 598.03 3.73 596.27 1.97 594.09 1.97 L 5.91 1.97 C 3.73 1.97 1.97 3.73 1.97 5.91 Z" style="stroke:none"></path></g><g fill-opacity="1.0" transform="matrix(1.0 0.0 0.0 1.0 9.26 68.25)"><foreignObject color="#FFFFFF" height="12.3" overflow="visible" style="--ltx-fg-color:#FFFFFF;--fo_width :42.02em;--fo_height:0.69em;--fo_depth :0.19em;" transform="matrix(1 0 0 -1 0 9.61)" width="581.48"><span style="width:36.54em;"><span id="S3.SS1.p3.pic1.p1">Lemma&nbsp;1:&nbsp;Anisotropy amplifies bias</span> </span></foreignObject></g><g fill-opacity="1.0" transform="matrix(1.0 0.0 0.0 1.0 9.26 10.4)"><foreignObject color="#000000" height="45.66" overflow="visible" style="--ltx-fg-color:#000000;--fo_width :42.02em;--fo_height:3.07em;--fo_depth :0.22em;" transform="matrix(1 0 0 -1 0 42.55)" width="581.48"><span style="width:45.43em;"><span style="font-size:90%;">Whenever <math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="\lambda_{K}&gt;\lambda_{1}"><semantics><mrow><msub><mi>λ</mi> <mi>K</mi></msub> <mo>&gt;</mo> <msub><mi>λ</mi> <mn>1</mn></msub></mrow> <annotation encoding="application/x-tex">\lambda_{K}&gt;\lambda_{1}</annotation></semantics></math>, there always exists a downstream task (<math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="{\bm{y}}"><semantics><mi>𝒚</mi> <annotation encoding="application/x-tex">{\bm{y}}</annotation></semantics></math>) for which <math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="{\bm{Z}}_{\rm aniso}"><semantics><msub><mi>𝒁</mi> <mi>aniso</mi></msub> <annotation encoding="application/x-tex">{\bm{Z}}_{\rm aniso}</annotation></semantics></math> produces a higher bias estimator than <math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="{\bm{Z}}_{\rm iso}"><semantics><msub><mi>𝒁</mi> <mi>iso</mi></msub> <annotation encoding="application/x-tex">{\bm{Z}}_{\rm iso}</annotation></semantics></math> for <math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="\lambda&gt;0"><semantics><mrow><mi>λ</mi> <mo>&gt;</mo> <mn>0</mn></mrow> <annotation encoding="application/x-tex">\lambda&gt;0</annotation></semantics></math>. (Proof in Section˜B.1.)</span></span></foreignObject></g></g></svg>

<svg height="81.21" id="S3.SS1.p4.pic1" overflow="visible" version="1.1" viewBox="0 0 600 81.21" width="600"><g fill="#000000" stroke="#000000" stroke-width="0.4pt" style="--ltx-stroke-color:#000000;--ltx-fill-color:#000000;" transform="translate(0,81.21) matrix(1 0 0 -1 0 0)"><g fill="#000059" fill-opacity="1.0" style="--ltx-fill-color:#000059;"><path d="M 0 5.91 L 0 75.31 C 0 78.57 2.64 81.21 5.91 81.21 L 594.09 81.21 C 597.36 81.21 600 78.57 600 75.31 L 600 5.91 C 600 2.64 597.36 0 594.09 0 L 5.91 0 C 2.64 0 0 2.64 0 5.91 Z" style="stroke:none"></path></g><g fill="#F7F7FF" fill-opacity="1.0" style="--ltx-fill-color:#F7F7FF;"><path d="M 1.97 5.91 L 1.97 62.21 L 598.03 62.21 L 598.03 5.91 C 598.03 3.73 596.27 1.97 594.09 1.97 L 5.91 1.97 C 3.73 1.97 1.97 3.73 1.97 5.91 Z" style="stroke:none"></path></g><g fill-opacity="1.0" transform="matrix(1.0 0.0 0.0 1.0 9.26 68.25)"><foreignObject color="#FFFFFF" height="12.3" overflow="visible" style="--ltx-fg-color:#FFFFFF;--fo_width :42.02em;--fo_height:0.69em;--fo_depth :0.19em;" transform="matrix(1 0 0 -1 0 9.61)" width="581.48"><span style="width:36.54em;"><span id="S3.SS1.p4.pic1.p1">Lemma&nbsp;2:&nbsp;Anisotropy amplifies variance</span> </span></foreignObject></g><g fill-opacity="1.0" transform="matrix(1.0 0.0 0.0 1.0 9.26 10.4)"><foreignObject color="#000000" height="45.66" overflow="visible" style="--ltx-fg-color:#000000;--fo_width :42.02em;--fo_height:3.07em;--fo_depth :0.22em;" transform="matrix(1 0 0 -1 0 42.55)" width="581.48"><span style="width:45.43em;"><span style="font-size:90%;">With <math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="\lambda=0"><semantics><mrow><mi>λ</mi> <mo>=</mo> <mn>0</mn></mrow> <annotation encoding="application/x-tex">\lambda=0</annotation></semantics></math>, the total variance of <math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="\hat{\beta}"><semantics><mover accent="true"><mi>β</mi> <mo mathcolor="red" style="--ltx-fg-color:red;">hat</mo></mover> <annotation encoding="application/x-tex">\hat{\beta}</annotation></semantics></math> (OLS) is minimized for <math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="{\bm{Z}}_{\rm iso}"><semantics><msub><mi>𝒁</mi> <mi>iso</mi></msub> <annotation encoding="application/x-tex">{\bm{Z}}_{\rm iso}</annotation></semantics></math> with <math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="\text{tr}(\text{Var}(\hat{\bm{\beta}}_{\text{aniso}}))&gt;\text{tr}(\text{Var}(\hat{\bm{\beta}}_{\text{iso}}))"><semantics><mrow><mrow><mtext>tr</mtext> <mo lspace="0em" rspace="0em"></mo><mrow><mo stretchy="false">(</mo><mrow><mtext>Var</mtext> <mo lspace="0em" rspace="0em"></mo><mrow><mo stretchy="false">(</mo><msub><mover accent="true"><mi>𝜷</mi> <mo mathcolor="red" style="--ltx-fg-color:red;">hat</mo></mover> <mtext>aniso</mtext></msub><mo stretchy="false">)</mo></mrow></mrow><mo stretchy="false">)</mo></mrow></mrow> <mo>&gt;</mo> <mrow><mtext>tr</mtext> <mo lspace="0em" rspace="0em"></mo><mrow><mo stretchy="false">(</mo><mrow><mtext>Var</mtext> <mo lspace="0em" rspace="0em"></mo><mrow><mo stretchy="false">(</mo><msub><mover accent="true"><mi>𝜷</mi> <mo mathcolor="red" style="--ltx-fg-color:red;">hat</mo></mover> <mtext>iso</mtext></msub><mo stretchy="false">)</mo></mrow></mrow><mo stretchy="false">)</mo></mrow></mrow></mrow> <annotation encoding="application/x-tex">\text{tr}(\text{Var}(\hat{\bm{\beta}}_{\text{aniso}}))&gt;\text{tr}(\text{Var}(\hat{\bm{\beta}}_{\text{iso}}))</annotation></semantics></math>. (Proof in Section˜B.2.)</span></span></foreignObject></g></g></svg>

From the above Sections˜3.1 and 3.1 we obtain that the distribution of features must be isotropic. We now move to nonlinear probing where the standard Gaussian will emerge as the unique optimum.

### 3.2  Nonlinear Probing

To allow for more flexible evaluation of the pretrained encoder $f_{{\bm{\theta}}}$, it has become increasingly common to work with a nonlinear probe. We analyze two widely-used nonlinear methods: radius-based k-NN (taunk2019brief; sun2010adaptive; zhang2017efficient; abu2019effects) for its simplicity and kernel methods (nadaraya1964estimating; watson1964smooth) for their theoretical tractability.

As in Section˜3.1, we ask ourselves which distribution of embeddings would be preferable for a foundation model. We first define our prediction function. The training data consists of the $N$ embeddings along with their training labels $\{({\bm{z}}_{n},{\bm{y}}_{n})\}_{n=1}^{N}$. The prediction, using radius-based k-NN for a query vector ${\bm{q}}$ is formed as

$$
\displaystyle\mathaccent 866{{\bm{y}}}({\bm{q}}):=\frac{1}{|\mathcal{N}_{r_{0}}({\bm{q}})|}\sumop\slimits@_{n\in\mathcal{N}_{r_{0}}({\bm{q}})}{\bm{y}}_{n},
$$

where $\mathcal{N}_{r_{0}}({\bm{q}})=\{n:\|{\bm{z}}_{n}-{\bm{q}}\|\leq r_{0}\}$. The specific choice of radius $r_{0}$ controls how many neighbors predictions are averaged to form the query’s prediction. The kernel’s prediction at a query ${\bm{q}}\in\mathbb{R}^{K}$ is given by

$$
\displaystyle\mathaccent 866{{\bm{y}}}({\bm{q}})\triangleq\frac{\sumop\slimits@_{n=1}^{N}K_{h}({\bm{q}}-{\bm{z}}_{n}){\bm{y}}_{n}}{\sumop\slimits@_{n=1}^{N}K_{h}({\bm{q}}-{\bm{z}}_{n})}.
$$

We search over all distributions of Z subject to a fixed total variance constraint, e.g., $\operatorname{Tr}(\mathrm{Cov}({\bm{Z}}))=\kappa_{1}$ or $\|\mathrm{Cov}({\bm{Z}})\|_{F}=\kappa_{2}$. The specific value of $\kappa$ does not affect the optimal distribution shape. Following the same type of derivations as done in the linear regime–with the exception of some additional regularity conditions–we are able to precisely identify the isotropic Gaussian as the unique optimum to minimize bias as formalized below.

<svg height="178.83" id="S3.SS2.p4.pic1" overflow="visible" version="1.1" viewBox="0 0 600 178.83" width="600"><g fill="#000000" stroke="#000000" stroke-width="0.4pt" style="--ltx-stroke-color:#000000;--ltx-fill-color:#000000;" transform="translate(0,178.83) matrix(1 0 0 -1 0 0)"><g fill="#590000" fill-opacity="1.0" style="--ltx-fill-color:#590000;"><path d="M 0 5.91 L 0 172.93 C 0 176.19 2.64 178.83 5.91 178.83 L 594.09 178.83 C 597.36 178.83 600 176.19 600 172.93 L 600 5.91 C 600 2.64 597.36 0 594.09 0 L 5.91 0 C 2.64 0 0 2.64 0 5.91 Z" style="stroke:none"></path></g><g fill="#FFF2F2" fill-opacity="1.0" style="--ltx-fill-color:#FFF2F2;"><path d="M 1.97 5.91 L 1.97 159.83 L 598.03 159.83 L 598.03 5.91 C 598.03 3.73 596.27 1.97 594.09 1.97 L 5.91 1.97 C 3.73 1.97 1.97 3.73 1.97 5.91 Z" style="stroke:none"></path></g><g fill-opacity="1.0" transform="matrix(1.0 0.0 0.0 1.0 9.26 165.87)"><foreignObject color="#FFFFFF" height="12.3" overflow="visible" style="--ltx-fg-color:#FFFFFF;--fo_width :42.02em;--fo_height:0.69em;--fo_depth :0.19em;" transform="matrix(1 0 0 -1 0 9.61)" width="581.48"><span style="width:36.54em;"><span id="S3.SS2.p4.pic1.p1">Theorem&nbsp;1:&nbsp;isotropic Gaussian Optimality</span> </span></foreignObject></g><g fill-opacity="1.0" transform="matrix(1.0 0.0 0.0 1.0 9.26 10.4)"><foreignObject color="#000000" height="143.28" overflow="visible" style="--ltx-fg-color:#000000;--fo_width :42.02em;--fo_height:10.13em;--fo_depth :0.22em;" transform="matrix(1 0 0 -1 0 140.17)" width="581.48"><span style="width:45.43em;"><span style="font-size:90%;">The integrated square bias (ISB) over query points is given by</span> <span id="A6.EGx4"><span id="S3.Ex4"><math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="\displaystyle\text{ISB}_{k\text{-NN}}=\frac{r_{0}^{4}}{(K+2)^{2}}\tau_{g}^{2}J(p)+O(r_{0}^{4}),"><semantics><mrow><mrow><msub><mtext mathsize="0.900em">ISB</mtext> <mrow><mi mathsize="0.900em">k</mi> <mo lspace="0em" rspace="0em"></mo><mtext mathsize="0.900em">-NN</mtext></mrow></msub> <mo mathsize="0.900em">=</mo> <mrow><mrow><mstyle displaystyle="true"><mfrac><msubsup><mi mathsize="0.900em">r</mi> <mn mathsize="0.900em">0</mn> <mn mathsize="0.900em">4</mn></msubsup> <msup><mrow><mo maxsize="0.900em" minsize="0.900em">(</mo><mrow><mi mathsize="0.900em">K</mi> <mo mathsize="0.900em">+</mo> <mn mathsize="0.900em">2</mn></mrow><mo maxsize="0.900em" minsize="0.900em">)</mo></mrow> <mn mathsize="0.900em">2</mn></msup></mfrac></mstyle> <mo lspace="0em" rspace="0em"></mo><msubsup><mi mathsize="0.900em">τ</mi> <mi mathsize="0.900em">g</mi> <mn mathsize="0.900em">2</mn></msubsup> <mo lspace="0em" rspace="0em"></mo><mi mathsize="0.900em">J</mi> <mo lspace="0em" rspace="0em"></mo><mrow><mo maxsize="0.900em" minsize="0.900em">(</mo><mi mathsize="0.900em">p</mi><mo maxsize="0.900em" minsize="0.900em">)</mo></mrow></mrow> <mo mathsize="0.900em">+</mo> <mrow><mi mathsize="0.900em">O</mi> <mo lspace="0em" rspace="0em"></mo><mrow><mo maxsize="0.900em" minsize="0.900em">(</mo><msubsup><mi mathsize="0.900em">r</mi> <mn mathsize="0.900em">0</mn> <mn mathsize="0.900em">4</mn></msubsup><mo maxsize="0.900em" minsize="0.900em">)</mo></mrow></mrow></mrow></mrow><mo mathsize="0.900em">,</mo></mrow><annotation encoding="application/x-tex">\displaystyle\text{ISB}_{k\text{-NN}}=\frac{r_{0}^{4}}{(K+2)^{2}}\tau_{g}^{2}J(p)+O(r_{0}^{4}),</annotation></semantics></math> <span style="font-size:90%;">(k-NN)</span> </span><span id="S3.Ex5"><math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="\displaystyle\text{ISB}_{\text{kernel}}\leq\Big(\frac{h^{2}\mu_{2}(K)}{2}\Big)^{2}\Big(2B^{2}+8L^{2}J(p)\Big)+o(h^{4}),"><semantics><mrow><mrow><msub><mtext mathsize="0.900em">ISB</mtext> <mtext mathsize="0.900em">kernel</mtext></msub> <mo mathsize="0.900em">≤</mo> <mrow><mrow><msup><mrow><mo maxsize="1.600em" minsize="1.600em">(</mo><mstyle displaystyle="true"><mfrac><mrow><msup><mi mathsize="0.900em">h</mi> <mn mathsize="0.900em">2</mn></msup> <mo lspace="0em" rspace="0em"></mo><msub><mi mathsize="0.900em">μ</mi> <mn mathsize="0.900em">2</mn></msub> <mo lspace="0em" rspace="0em"></mo><mrow><mo maxsize="0.900em" minsize="0.900em">(</mo><mi mathsize="0.900em">K</mi><mo maxsize="0.900em" minsize="0.900em">)</mo></mrow></mrow> <mn mathsize="0.900em">2</mn></mfrac></mstyle><mo maxsize="1.600em" minsize="1.600em">)</mo></mrow> <mn mathsize="0.900em">2</mn></msup> <mo lspace="0em" rspace="0em"></mo><mrow><mo maxsize="1.600em" minsize="1.600em">(</mo><mrow><mrow><mn mathsize="0.900em">2</mn> <mo lspace="0em" rspace="0em"></mo><msup><mi mathsize="0.900em">B</mi> <mn mathsize="0.900em">2</mn></msup></mrow> <mo mathsize="0.900em">+</mo> <mrow><mn mathsize="0.900em">8</mn> <mo lspace="0em" rspace="0em"></mo><msup><mi mathsize="0.900em">L</mi> <mn mathsize="0.900em">2</mn></msup> <mo lspace="0em" rspace="0em"></mo><mi mathsize="0.900em">J</mi> <mo lspace="0em" rspace="0em"></mo><mrow><mo maxsize="0.900em" minsize="0.900em">(</mo><mi mathsize="0.900em">p</mi><mo maxsize="0.900em" minsize="0.900em">)</mo></mrow></mrow></mrow><mo maxsize="1.600em" minsize="1.600em">)</mo></mrow></mrow> <mo mathsize="0.900em">+</mo> <mrow><mi mathsize="0.900em">o</mi> <mo lspace="0em" rspace="0em"></mo><mrow><mo maxsize="0.900em" minsize="0.900em">(</mo><msup><mi mathsize="0.900em">h</mi> <mn mathsize="0.900em">4</mn></msup><mo maxsize="0.900em" minsize="0.900em">)</mo></mrow></mrow></mrow></mrow><mo mathsize="0.900em">,</mo></mrow><annotation encoding="application/x-tex">\displaystyle\text{ISB}_{\text{kernel}}\leq\Big(\frac{h^{2}\mu_{2}(K)}{2}\Big)^{2}\Big(2B^{2}+8L^{2}J(p)\Big)+o(h^{4}),</annotation></semantics></math> <span style="font-size:90%;">(kernel)</span> </span></span><span style="font-size:90%;">and among distributions with a scalar-based covariance constraint, the isotropic Gaussian is the unique minimizer of the integrated square bias. (Proof in Sections˜B.4 and&nbsp;B.7.)</span></span></foreignObject></g></g></svg>

Numerous additional details and discussions on the regularity assumptions we employed are provided in Appendix˜A. Together, these results establish the isotropic Gaussian distribution as the optimal design to minimize the worst-case risk of a foundation model across downstream tasks.

![Refer to caption](https://arxiv.org/html/2511.08544v3/x3.png)

Figure 3: Illustration of Section ˜ 3.1 showcasing how anisotropic ( right ) embeddings lead to higher variance estimator compared to isotropic embeddings ( left ). We sample 100 training points for the 2 -class classification task and fit a logistic regression–repeating the process over numerous training set sample. Each sampling results in a decision boundary ( purple ).

### 3.3  Geometric and Practical Insights

We now empirically validate that the isotropic Gaussian is optimal when no information about downstream tasks is available. We focus on linear probing (Section˜3.1), where all considered distributions have the same total variance.

When employing a linear probe, an anisotropic distribution increases both bias (with Tikhonov regularization) and variance. Examining bias first (Section˜3.1), we present in Figure˜18 visualizations for both continuous regression and discrete classification tasks. We observe that the cosine similarity between estimated and ground-truth parameters equals 1 only for isotropic distributions, degrading for anisotropic cases regardless of sample size or regularization strength. Regarding variance (Section˜3.1), we show in Figure˜3 that learned parameters vary significantly more across training sets when the covariance is anisotropic (right) compared to isotropic (left)—even when using logistic regression instead of OLS. Figure˜17 further illustrates this effect, showing the distribution of learned $\beta$ parameters across different training samples for both cases. The anisotropic distribution clearly produces higher-variance estimators.

These theoretical and empirical results establish our design principle for LeJEPA: *embeddings $f_{{\bm{\theta}}}({\bm{x}})$ should follow an isotropic Gaussian distribution to minimize worst-case risk across downstream tasks encountered post-training*. Section˜4 introduces a novel regularizer to achieve this distribution.

## 4  SIGReg: Reliable Isotropic Gaussian Regularization in High-Dimension

Having established the isotropic Gaussian as the optimal embedding distribution (Section˜3), we now introduce Sketched Isotropic Gaussian Regularization (SIGReg)–a distribution matching objective that is simultaneously (i) differentiable, (ii) scalable, (iii) provable, and (iv) interpretable. SIGReg builds on three key innovations. First, we formulate distribution matching as a statistical test under the null hypothesis $P_{{\bm{\theta}}}=Q$ (Section˜4.1). Second, we identify a test that guarantees bounded gradients and curvature while maintaining linear complexity and efficient multi-GPU scaling (Section˜4.2). Third, SIGReg bypasses the curse of dimensionality, eliminating collapsed shortcut solutions entirely (Section˜4.3).

### 4.1  Hypothesis Testing as a Judge

Asking for $f_{{\bm{\theta}}}({\bm{x}})$ ’s distribution $P_{{\bm{\theta}}}$ to match a target distribution $Q$ is typically done by creating various measures of distance or divergence, and estimating them in high-dimension. We propose a different starting point grounded in statistics. Consider the hypothesis testing framework (fisher1928statistical; neyman1933ix) given by

$$
\displaystyle H_{0}:P_{{\bm{\theta}}}=Q\quad\text{vs.}\quad H_{1}:P_{{\bm{\theta}}}\neq Q,
$$

with $H_{0}$ being referred to as the null hypothesis. That is, we are asking in Equation˜2 if there is enough empirical evidence to reject the null. To answer that question, one (i) employs a test-statistic, i.e., a single scalar value summarizing the evidence from the empirical samples, (ii) determines a critical value $\tau_{\alpha}$ for the test-statistic based on the probability $\alpha$ of Type I error, i.e., of mistakenly rejecting a true null hypothesis, (iii) compares the test-statistic to the critical value $\tau_{\alpha}$; if the test-statistic exceeds $\tau_{\alpha}$, reject the null hypothesis. If the null is not rejected, we can only claim that there is not sufficient empirical evidence against $P_{{\bm{\theta}}}=Q$.

As it stands, Equation˜2 remains impractical in large dimension as existing tests have at least quadratic complexity with the number of samples considered (more details in Appendix˜F). We thus propose to derive a sketching strategy by decomposing Equation˜2 into simpler univariate tests. Denoting the push-forward distributions $P_{\bm{\theta}}^{({\bm{a}})}\triangleq({\bm{a}}^{\top})_{\#}P_{\bm{\theta}}$ and $Q^{({\bm{a}})}\triangleq({\bm{a}}^{\top})_{\#}Q$, we can define the following directional univariate test

$$
\displaystyle H_{0}({\bm{a}}):P_{\bm{\theta}}^{({\bm{a}})}=Q^{({\bm{a}})}\;\;\text{vs.}\;\;H_{1}({\bm{a}}):P_{\bm{\theta}}^{({\bm{a}})}\neq Q^{({\bm{a}})},
$$

for a given directional unit-norm vector ${\bm{a}}\in\mathcal{S}^{K-1}$. The corresponding *directional test-statistic* of Equation˜3 is computed as $T(\{{\bm{a}}^{\top}f_{{\bm{\theta}}}({\bm{x}}_{n})\}_{n=1}^{N})$. Examples of tests $T$ will be provided in the later Section˜4.2. Repeating that process over a set of $M$ directions ${\mathbb{A}}\triangleq\{{\bm{a}}_{1},\dots,{\bm{a}}_{M}\}$ and aggregating the individual values lead to the following *global test-statistic*

$$
\displaystyle T_{{\mathbb{A}}}(\{f_{{\bm{\theta}}}({\bm{x}}_{n})\}_{n=1}^{N})\triangleq\max_{{\bm{a}}\in{\mathbb{A}}}T(\{{\bm{a}}^{\top}f_{{\bm{\theta}}}({\bm{x}}_{n})\}_{n=1}^{N}).
$$

We now provide a formal statement asserting the consistency of Equation˜4 to test the original multivariate null hypothesis from Equation˜2. Our result leverages the well-known union-intersection principle (roy1953heuristic), and a slightly modified Cramér-Wold theorem. We denote by $\stackrel{{\scriptstyle d}}{{=}}$ equality in distribution.

<svg height="728.11" id="S4.SS1.p3.pic1" overflow="visible" version="1.1" viewBox="0 0 600 728.11" width="600"><g fill="#000000" stroke="#000000" stroke-width="0.4pt" style="--ltx-stroke-color:#000000;--ltx-fill-color:#000000;" transform="translate(0,728.11) matrix(1 0 0 -1 0 0)"><g fill="#000059" fill-opacity="1.0" style="--ltx-fill-color:#000059;"><path d="M 0 5.91 L 0 722.2 C 0 725.46 2.64 728.11 5.91 728.11 L 594.09 728.11 C 597.36 728.11 600 725.46 600 722.2 L 600 5.91 C 600 2.64 597.36 0 594.09 0 L 5.91 0 C 2.64 0 0 2.64 0 5.91 Z" style="stroke:none"></path></g><g fill="#F7F7FF" fill-opacity="1.0" style="--ltx-fill-color:#F7F7FF;"><path d="M 1.97 5.91 L 1.97 708.95 L 598.03 708.95 L 598.03 5.91 C 598.03 3.73 596.27 1.97 594.09 1.97 L 5.91 1.97 C 3.73 1.97 1.97 3.73 1.97 5.91 Z" style="stroke:none"></path></g><g fill-opacity="1.0" transform="matrix(1.0 0.0 0.0 1.0 9.26 715.07)"><foreignObject color="#FFFFFF" height="12.45" overflow="visible" style="--ltx-fg-color:#FFFFFF;--fo_width :42.02em;--fo_height:0.7em;--fo_depth :0.2em;" transform="matrix(1 0 0 -1 0 9.69)" width="581.48"><span style="width:36.54em;"><span id="S4.SS1.p3.pic1.p1">Lemma&nbsp;3:&nbsp;Hyperspherical Cramér-Wold</span> </span></foreignObject></g><g fill-opacity="1.0" transform="matrix(1.0 0.0 0.0 1.0 9.26 10.4)"><foreignObject color="#000000" height="692.4" overflow="visible" style="--ltx-fg-color:#000000;--fo_width :42.02em;--fo_height:49.81em;--fo_depth :0.22em;" transform="matrix(1 0 0 -1 0 689.29)" width="581.48"><span style="width:45.43em;"><span style="font-size:90%;">Let <math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="X,Y"><semantics><mrow><mi>X</mi><mo>,</mo><mi>Y</mi></mrow> <annotation encoding="application/x-tex">X,Y</annotation></semantics></math> be <math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="\mathbb{R}^{d}"><semantics><msup><mi>R</mi> <mi>d</mi></msup> <annotation encoding="application/x-tex">\mathbb{R}^{d}</annotation></semantics></math> -valued random vectors, then</span> <span id="S4.Ex6"><math xmlns="http://www.w3.org/1998/Math/MathML" display="block" data-latex="\langle{\bm{u}},X\rangle\stackrel{{\scriptstyle d}}{{=}}\langle{\bm{u}},Y\rangle,\forall{\bm{u}}\in\mathbb{S}^{d-1}\iff X\stackrel{{\scriptstyle d}}{{=}}Y."><semantics><mrow><mrow><mrow><mrow><mrow><mo maxsize="0.900em" minsize="0.900em" stretchy="true">⟨</mo> <mi mathsize="0.900em">𝒖</mi><mo mathsize="0.900em">,</mo><mi mathsize="0.900em">X</mi> <mo maxsize="0.900em" minsize="0.900em" stretchy="true">⟩</mo></mrow> <mover><mo mathsize="0.900em">=</mo> <mi mathsize="0.900em">d</mi></mover> <mrow><mo maxsize="0.900em" minsize="0.900em" stretchy="true">⟨</mo> <mi mathsize="0.900em">𝒖</mi><mo mathsize="0.900em">,</mo><mi mathsize="0.900em">Y</mi> <mo maxsize="0.900em" minsize="0.900em" stretchy="true">⟩</mo></mrow></mrow><mo mathsize="0.900em">,</mo><mrow><mi mathsize="0.900em">𝒖</mi> <mo mathsize="0.900em">∈</mo> <msup><mi mathsize="0.900em">S</mi> <mrow><mi mathsize="0.900em">d</mi> <mo mathsize="0.900em">−</mo> <mn mathsize="0.900em">1</mn></mrow></msup></mrow></mrow> <mo mathsize="0.900em" stretchy="false">⇔</mo> <mrow><mi mathsize="0.900em">X</mi> <mover><mo mathsize="0.900em">=</mo> <mi mathsize="0.900em">d</mi></mover> <mi mathsize="0.900em">Y</mi></mrow></mrow><mo lspace="0em" mathsize="0.900em">.</mo></mrow><annotation encoding="application/x-tex">\langle{\bm{u}},X\rangle\stackrel{{\scriptstyle d}}{{=}}\langle{\bm{u}},Y\rangle,\forall{\bm{u}}\in\mathbb{S}^{d-1}\iff X\stackrel{{\scriptstyle d}}{{=}}Y.</annotation></semantics></math></span> <span style="font-size:90%;">Convergence in distribution also holds. (Proof in Section˜B.8.)</span></span></foreignObject></g></g></svg>

<svg height="156.01" id="S4.SS1.p4.pic1" overflow="visible" version="1.1" viewBox="0 0 600 156.01" width="600"><g fill="#000000" stroke="#000000" stroke-width="0.4pt" style="--ltx-stroke-color:#000000;--ltx-fill-color:#000000;" transform="translate(0,156.01) matrix(1 0 0 -1 0 0)"><g fill="#590000" fill-opacity="1.0" style="--ltx-fill-color:#590000;"><path d="M 0 5.91 L 0 150.11 C 0 153.37 2.64 156.01 5.91 156.01 L 594.09 156.01 C 597.36 156.01 600 153.37 600 150.11 L 600 5.91 C 600 2.64 597.36 0 594.09 0 L 5.91 0 C 2.64 0 0 2.64 0 5.91 Z" style="stroke:none"></path></g><g fill="#FFF2F2" fill-opacity="1.0" style="--ltx-fill-color:#FFF2F2;"><path d="M 1.97 5.91 L 1.97 137.01 L 598.03 137.01 L 598.03 5.91 C 598.03 3.73 596.27 1.97 594.09 1.97 L 5.91 1.97 C 3.73 1.97 1.97 3.73 1.97 5.91 Z" style="stroke:none"></path></g><g fill-opacity="1.0" transform="matrix(1.0 0.0 0.0 1.0 9.26 143.05)"><foreignObject color="#FFFFFF" height="12.3" overflow="visible" style="--ltx-fg-color:#FFFFFF;--fo_width :42.02em;--fo_height:0.69em;--fo_depth :0.19em;" transform="matrix(1 0 0 -1 0 9.61)" width="581.48"><span style="width:36.54em;"><span id="S4.SS1.p4.pic1.p1">Theorem&nbsp;2:&nbsp;Sufficiency of directional tests</span> </span></foreignObject></g><g fill-opacity="1.0" transform="matrix(1.0 0.0 0.0 1.0 9.26 10.4)"><foreignObject color="#000000" height="120.46" overflow="visible" style="--ltx-fg-color:#000000;--fo_width :42.02em;--fo_height:8.48em;--fo_depth :0.22em;" transform="matrix(1 0 0 -1 0 117.35)" width="581.48"><span style="width:45.43em;">Equation˜4 <span style="font-size:90%;">is a valid statistical test for Equation˜3 as</span> <span id="A6.EGx8"><span id="S4.Ex7"><math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="\displaystyle P=Q"><semantics><mrow><mi mathsize="0.900em">P</mi> <mo mathsize="0.900em">=</mo> <mi mathsize="0.900em">Q</mi></mrow> <annotation encoding="application/x-tex">\displaystyle P=Q</annotation></semantics></math> <math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="\displaystyle\implies\limsup_{n\to\infty}\Pr\left(T_{{\mathbb{A}}}(\{f_{{\bm{\theta}}}({\bm{x}}_{n})\}_{n=1}^{N})\geq\tau_{\alpha}\right)\leq\alpha,\text{\bf(level)}"><semantics><mrow><mrow><mo mathsize="0.900em" rspace="0.1389em" stretchy="false">⟹</mo> <mrow><munder><mo lspace="0.1389em" mathsize="0.900em" movablelimits="false" rspace="0.167em">lim sup</mo> <mrow><mi mathsize="0.900em">n</mi> <mo mathsize="0.900em" stretchy="false">→</mo> <mi mathsize="0.900em" mathvariant="normal">∞</mi></mrow></munder> <mrow><mi mathsize="0.900em">Pr</mi> <mo>⁡</mo> <mrow><mo>(</mo><mrow><mrow><msub><mi mathsize="0.900em">T</mi> <mi mathsize="0.900em">A</mi></msub> <mo lspace="0em" rspace="0em"></mo><mrow><mo maxsize="0.900em" minsize="0.900em">(</mo><msubsup><mrow><mo maxsize="0.900em" minsize="0.900em">{</mo> <mrow><msub><mi mathsize="0.900em">f</mi> <mi mathsize="0.900em">𝜽</mi></msub> <mo lspace="0em" rspace="0em"></mo><mrow><mo maxsize="0.900em" minsize="0.900em">(</mo><msub><mi mathsize="0.900em">𝒙</mi> <mi mathsize="0.900em">n</mi></msub><mo maxsize="0.900em" minsize="0.900em">)</mo></mrow></mrow> <mo maxsize="0.900em" minsize="0.900em">}</mo></mrow> <mrow><mi mathsize="0.900em">n</mi> <mo mathsize="0.900em">=</mo> <mn mathsize="0.900em">1</mn></mrow> <mi mathsize="0.900em">N</mi></msubsup><mo maxsize="0.900em" minsize="0.900em">)</mo></mrow></mrow> <mo mathsize="0.900em">≥</mo> <msub><mi mathsize="0.900em">τ</mi> <mi mathsize="0.900em">α</mi></msub></mrow><mo>)</mo></mrow></mrow></mrow> <mo mathsize="0.900em">≤</mo> <mi mathsize="0.900em">α</mi></mrow><mo mathsize="0.900em">,</mo><mtext mathsize="0.900em">(level)</mtext></mrow> <annotation encoding="application/x-tex">\displaystyle\implies\limsup_{n\to\infty}\Pr\left(T_{{\mathbb{A}}}(\{f_{{\bm{\theta}}}({\bm{x}}_{n})\}_{n=1}^{N})\geq\tau_{\alpha}\right)\leq\alpha,\text{\bf(level)}</annotation></semantics></math> </span><span id="S4.Ex8"><math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="\displaystyle P\neq Q"><semantics><mrow><mi mathsize="0.900em">P</mi> <mo lspace="0em" rspace="0em"></mo><mi mathsize="0.900em">Q</mi></mrow> <annotation encoding="application/x-tex">\displaystyle P\neq Q</annotation></semantics></math> <math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="\displaystyle\implies\limsup_{n\to\infty}\Pr\left(T_{{\mathbb{A}}}(\{f_{{\bm{\theta}}}({\bm{x}}_{n})\}_{n=1}^{N})\geq\tau_{\alpha}\right)=1,\text{\bf(power)}"><semantics><mrow><mrow><mo mathsize="0.900em" rspace="0.1389em" stretchy="false">⟹</mo> <mrow><munder><mo lspace="0.1389em" mathsize="0.900em" movablelimits="false" rspace="0.167em">lim sup</mo> <mrow><mi mathsize="0.900em">n</mi> <mo mathsize="0.900em" stretchy="false">→</mo> <mi mathsize="0.900em" mathvariant="normal">∞</mi></mrow></munder> <mrow><mi mathsize="0.900em">Pr</mi> <mo>⁡</mo> <mrow><mo>(</mo><mrow><mrow><msub><mi mathsize="0.900em">T</mi> <mi mathsize="0.900em">A</mi></msub> <mo lspace="0em" rspace="0em"></mo><mrow><mo maxsize="0.900em" minsize="0.900em">(</mo><msubsup><mrow><mo maxsize="0.900em" minsize="0.900em">{</mo> <mrow><msub><mi mathsize="0.900em">f</mi> <mi mathsize="0.900em">𝜽</mi></msub> <mo lspace="0em" rspace="0em"></mo><mrow><mo maxsize="0.900em" minsize="0.900em">(</mo><msub><mi mathsize="0.900em">𝒙</mi> <mi mathsize="0.900em">n</mi></msub><mo maxsize="0.900em" minsize="0.900em">)</mo></mrow></mrow> <mo maxsize="0.900em" minsize="0.900em">}</mo></mrow> <mrow><mi mathsize="0.900em">n</mi> <mo mathsize="0.900em">=</mo> <mn mathsize="0.900em">1</mn></mrow> <mi mathsize="0.900em">N</mi></msubsup><mo maxsize="0.900em" minsize="0.900em">)</mo></mrow></mrow> <mo mathsize="0.900em">≥</mo> <msub><mi mathsize="0.900em">τ</mi> <mi mathsize="0.900em">α</mi></msub></mrow><mo>)</mo></mrow></mrow></mrow> <mo mathsize="0.900em">=</mo> <mn mathsize="0.900em">1</mn></mrow><mo mathsize="0.900em">,</mo><mtext mathsize="0.900em">(power)</mtext></mrow> <annotation encoding="application/x-tex">\displaystyle\implies\limsup_{n\to\infty}\Pr\left(T_{{\mathbb{A}}}(\{f_{{\bm{\theta}}}({\bm{x}}_{n})\}_{n=1}^{N})\geq\tau_{\alpha}\right)=1,\text{\bf(power)}</annotation></semantics></math> </span></span><span style="font-size:90%;">(Proof in Section˜B.9.)</span></span></foreignObject></g></g></svg>

The assumptions required in the proof of Section˜4.1 hold for classical consistent univariate tests $T$ such as the ones presented in the following Section˜4.2.

![Refer to caption](https://arxiv.org/html/2511.08544v3/toy_figures/3d_sphere_0.png)

Figure 4: Examples of distributions living on the surface of the sphere with varying Sobolev smoothness coefficients α \\alpha. As per Section ˜ 4.3, the greater is, the more global will be the impact of SIGReg for a given number of directions M. Practically, this represents the distribution of the encoder’s output. Because the target density (isotropic Gaussian) is smooth, the coeffcients of the embedding will quickly grow hereby making SIGReg ( 4.2 ) immune to the curse of dimensionality.

![Refer to caption](https://arxiv.org/html/2511.08544v3/x4.png)

Figure 5: Constructed data density with “X” distribution whose marginals are standard Gaussian and whose covariance is identity ( left densities ). Applying M = 10 M=10 projections on the half circle directions produces univariate distributions that can be compared against a standard Gaussian ( left ) using any preferred statistic from Section ˜ 4.2. The appropriate direction is able to capture the degenerate distribution of the data hereby creating a spike in the statistic value.

### 4.2  SIGReg: Sketching the Epps-Pulley Test is Stable and Scalable

Our proposed regularizer–coined Sketched Isotropic Gaussian Regularization (SIGReg)–follows directly from Section˜4.1 using any statistical test $T$ targeted towards the isotropic Gaussian, illustrated in Figures˜2 and 5, and formalized below.

<svg height="128.76" id="S4.SS2.p2.pic1" overflow="visible" version="1.1" viewBox="0 0 600 128.76" width="600"><g fill="#000000" stroke="#000000" stroke-width="0.4pt" style="--ltx-stroke-color:#000000;--ltx-fill-color:#000000;" transform="translate(0,128.76) matrix(1 0 0 -1 0 0)"><g fill="#005900" fill-opacity="1.0" style="--ltx-fill-color:#005900;"><path d="M 0 5.91 L 0 122.85 C 0 126.11 2.64 128.76 5.91 128.76 L 594.09 128.76 C 597.36 128.76 600 126.11 600 122.85 L 600 5.91 C 600 2.64 597.36 0 594.09 0 L 5.91 0 C 2.64 0 0 2.64 0 5.91 Z" style="stroke:none"></path></g><g fill="#F2FFF2" fill-opacity="1.0" style="--ltx-fill-color:#F2FFF2;"><path d="M 1.97 5.91 L 1.97 91.61 L 598.03 91.61 L 598.03 5.91 C 598.03 3.73 596.27 1.97 594.09 1.97 L 5.91 1.97 C 3.73 1.97 1.97 3.73 1.97 5.91 Z" style="stroke:none"></path></g><g fill-opacity="1.0" transform="matrix(1.0 0.0 0.0 1.0 9.26 98.42)"><foreignObject color="#FFFFFF" height="30.44" overflow="visible" style="--ltx-fg-color:#FFFFFF;--fo_width :42.02em;--fo_height:1.95em;--fo_depth :0.25em;" transform="matrix(1 0 0 -1 0 26.98)" width="581.48"><span style="width:36.54em;"><span id="S4.SS2.p2.pic1.p1">Definition&nbsp;2:&nbsp;SIGReg (PyTorch code in LABEL:lst:epps-pulley-pytorch)</span> </span></foreignObject></g><g fill-opacity="1.0" transform="matrix(1.0 0.0 0.0 1.0 9.26 7.29)"><foreignObject color="#000000" height="75.07" overflow="visible" style="--ltx-fg-color:#000000;--fo_width :42.02em;--fo_height:5.42em;--fo_depth :0em;" transform="matrix(1 0 0 -1 0 75.07)" width="581.48"><span style="width:45.43em;"><span style="font-size:90%;">SIGReg sketches a statistical test <math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="T"><semantics><mi>T</mi> <annotation encoding="application/x-tex">T</annotation></semantics></math> towards isotropic Gaussian</span> <span id="S4.E5"><math xmlns="http://www.w3.org/1998/Math/MathML" display="block" data-latex="{\rm SIGReg}_{T}({\mathbb{A}},\{f_{{\bm{\theta}}}({\bm{x}}_{n})\}_{n=1}^{N})\triangleq\frac{1}{|{\mathbb{A}}|}\sumop\slimits@_{{\bm{a}}\in{\mathbb{A}}}T(\{{\bm{a}}^{\top}f_{{\bm{\theta}}}({\bm{x}}_{n})\}_{n=1}^{N}),"><semantics><mtable displaystyle="true"><mtr><mtd columnalign="left"><mrow><mrow><msub><mi mathsize="0.900em">SIGReg</mi> <mi mathsize="0.900em">T</mi></msub> <mo lspace="0em" rspace="0em"></mo><mrow><mo maxsize="0.900em" minsize="0.900em">(</mo><mi mathsize="0.900em">A</mi><mo mathsize="0.900em">,</mo><msubsup><mrow><mo maxsize="0.900em" minsize="0.900em">{</mo> <mrow><msub><mi mathsize="0.900em">f</mi> <mi mathsize="0.900em">𝜽</mi></msub> <mo lspace="0em" rspace="0em"></mo><mrow><mo maxsize="0.900em" minsize="0.900em">(</mo><msub><mi mathsize="0.900em">𝒙</mi> <mi mathsize="0.900em">n</mi></msub><mo maxsize="0.900em" minsize="0.900em">)</mo></mrow></mrow> <mo maxsize="0.900em" minsize="0.900em">}</mo></mrow> <mrow><mi mathsize="0.900em">n</mi> <mo mathsize="0.900em">=</mo> <mn mathsize="0.900em">1</mn></mrow> <mi mathsize="0.900em">N</mi></msubsup><mo maxsize="0.900em" minsize="0.900em">)</mo></mrow> <mo lspace="0em" rspace="0em"></mo><mfrac><mn mathsize="0.900em">1</mn> <mrow><mo maxsize="0.900em" minsize="0.900em" stretchy="true">|</mo> <mi mathsize="0.900em">A</mi> <mo maxsize="0.900em" minsize="0.900em" stretchy="true">|</mo></mrow></mfrac> <mo lspace="0em" rspace="0em"></mo><msub><mrow><mi mathsize="0.900em">𝒂</mi> <mo mathsize="0.900em">∈</mo> <mi mathsize="0.900em">A</mi></mrow></msub> <mo lspace="0em" rspace="0em"></mo><mi mathsize="0.900em">T</mi> <mo lspace="0em" rspace="0em"></mo><mrow><mo maxsize="0.900em" minsize="0.900em">(</mo><msubsup><mrow><mo maxsize="0.900em" minsize="0.900em">{</mo> <mrow><msup><mi mathsize="0.900em">𝒂</mi> <mo mathsize="0.900em">⊤</mo></msup> <mo lspace="0em" rspace="0em"></mo><msub><mi mathsize="0.900em">f</mi> <mi mathsize="0.900em">𝜽</mi></msub> <mo lspace="0em" rspace="0em"></mo><mrow><mo maxsize="0.900em" minsize="0.900em">(</mo><msub><mi mathsize="0.900em">𝒙</mi> <mi mathsize="0.900em">n</mi></msub><mo maxsize="0.900em" minsize="0.900em">)</mo></mrow></mrow> <mo maxsize="0.900em" minsize="0.900em">}</mo></mrow> <mrow><mi mathsize="0.900em">n</mi> <mo mathsize="0.900em">=</mo> <mn mathsize="0.900em">1</mn></mrow> <mi mathsize="0.900em">N</mi></msubsup><mo maxsize="0.900em" minsize="0.900em">)</mo></mrow></mrow><mo mathsize="0.900em">,</mo></mrow></mtd></mtr></mtable><annotation encoding="application/x-tex">{\rm SIGReg}_{T}({\mathbb{A}},\{f_{{\bm{\theta}}}({\bm{x}}_{n})\}_{n=1}^{N})\triangleq\frac{1}{|{\mathbb{A}}|}\sumop\slimits@_{{\bm{a}}\in{\mathbb{A}}}T(\{{\bm{a}}^{\top}f_{{\bm{\theta}}}({\bm{x}}_{n})\}_{n=1}^{N}),</annotation></semantics></math> <span rowspan="1">(5)</span> </span><span style="font-size:90%;">where we recommend the Epps-Pulley test (Section˜4.2.3) for <math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="T"><semantics><mi>T</mi> <annotation encoding="application/x-tex">T</annotation></semantics></math>.</span></span></foreignObject></g></g></svg>

We replace the maximum over ${\bm{a}}\in{\mathbb{A}}$ in Section˜4.1 by an average in (5) to avoid sparse gradient over the directions in ${\mathbb{A}}$. We now delve on the choice of $T$ for which we compare well-known candidate tests in the field of statistics that are categorized into (i) moment based (Section˜4.2.1), (ii) CDF based (Section˜4.2.2), and (iii) CF based (Section˜4.2.3) statistics–ultimately justifying our choice of the Epps-Pulley statistic.

#### 4.2.1  Moments are Unstable and Insufficient

The first family of statistics we consider are moment-based. Taking the standard Gaussian as an instanciation for the moments, we can define the Jarque-Bera (jarque1980efficient) test that compares the third and fourth moments, i.e., skewness and kurtosis, as

$$
\displaystyle{\rm JB}({\bm{u}})\triangleq
$$
 
$$
\displaystyle\frac{N}{6}\left(\mathaccent 866{\rm skew}({\bm{u}})^{2}+\left(\frac{\mathaccent 866{\rm kurt}({\bm{u}})-3}{2}\right)^{2}\right),
$$

where $\mathaccent 866{\rm skew}$ is the skewness computed from the data as $\frac{\frac{1}{n}\sumop\slimits@_{i=1}^{n}\left(x_{i}-\hat{\mu}\right)^{3}}{\hat{\sigma}^{3}}$ and $\mathaccent 866{\rm kurt}$ is the kurtosis $\frac{\frac{1}{n}\sumop\slimits@_{i=1}^{n}\left(x_{i}-\hat{\mu}\right)^{4}}{\hat{\sigma}^{4}}$. Typically, the (Jarque-Bera) test is used to see if a density follows a Gaussian distribution of any mean and variance–hence it only looks at moments 3 and 4. In our case we aim for a standard Gaussian test and thus add the usual statistics on the first two moments, leading to the extended test

$$
\displaystyle{\rm EJB}({\bm{u}})\triangleq
$$
 
$$
\displaystyle\frac{N\hat{\mu}({\bm{u}})^{2}}{\hat{\sigma}({\bm{u}})^{2}}+\frac{(N-1)\left(\hat{\sigma}({\bm{u}})^{2}-1\right)^{2}}{2}+{\rm JB}({\bm{u}}).
$$

The (Extended Jarque-Bera) acts as a moment matching problem over the first four moments. Such moment matching methods have proven powerful not only for statistical tests but also as mean to learn parametric and nonparametric models of data.

The Stability and Identifiability Conundrum. We now explain why moment-based tests–albeit powerful–will not be suited for LeJEPA. The $k^{th}$ of a distribution $P$ is denoted as $m_{k}(P)$. The first observation is that well-behaved distributions abiding the Carleman’s condition $\sumop\slimits@_{k=1}^{\infty}m_{2k}(Q)^{-1/(2k)}=\infty$ (carleman1926fonctions), such as the Gaussian, or for distributions with finite interval (hausdorff1923momentprobleme) are uniquely determined by their moments. However, using a finite number of moments creates the following non-identifiability issue which well-known in statistics and often used as a motivation to use all moments (lehmann2005testing).

<svg height="777.77" id="S4.SS2.SSS1.p3.pic1" overflow="visible" version="1.1" viewBox="0 0 600 777.77" width="600"><g fill="#000000" stroke="#000000" stroke-width="0.4pt" style="--ltx-stroke-color:#000000;--ltx-fill-color:#000000;" transform="translate(0,777.77) matrix(1 0 0 -1 0 0)"><g fill="#590000" fill-opacity="1.0" style="--ltx-fill-color:#590000;"><path d="M 0 5.91 L 0 771.86 C 0 775.12 2.64 777.77 5.91 777.77 L 594.09 777.77 C 597.36 777.77 600 775.12 600 771.86 L 600 5.91 C 600 2.64 597.36 0 594.09 0 L 5.91 0 C 2.64 0 0 2.64 0 5.91 Z" style="stroke:none"></path></g><g fill="#FFF2F2" fill-opacity="1.0" style="--ltx-fill-color:#FFF2F2;"><path d="M 1.97 5.91 L 1.97 758.76 L 598.03 758.76 L 598.03 5.91 C 598.03 3.73 596.27 1.97 594.09 1.97 L 5.91 1.97 C 3.73 1.97 1.97 3.73 1.97 5.91 Z" style="stroke:none"></path></g><g fill-opacity="1.0" transform="matrix(1.0 0.0 0.0 1.0 9.26 764.81)"><foreignObject color="#FFFFFF" height="12.3" overflow="visible" style="--ltx-fg-color:#FFFFFF;--fo_width :42.02em;--fo_height:0.69em;--fo_depth :0.19em;" transform="matrix(1 0 0 -1 0 9.61)" width="581.48"><span style="width:36.54em;"><span id="S4.SS2.SSS1.p3.pic1.p1">Theorem&nbsp;3:&nbsp;Insufficiency of K Moments</span> </span></foreignObject></g><g fill-opacity="1.0" transform="matrix(1.0 0.0 0.0 1.0 9.26 10.4)"><foreignObject color="#000000" height="742.22" overflow="visible" style="--ltx-fg-color:#000000;--fo_width :42.02em;--fo_height:53.41em;--fo_depth :0.22em;" transform="matrix(1 0 0 -1 0 739.1)" width="581.48"><span style="width:45.43em;"><span style="font-size:90%;">Minimizing the following objective with <math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="c_{k}&gt;0,\forall k"><semantics><mrow><msub><mi>c</mi> <mi>k</mi></msub> <mo>&gt;</mo> <mrow><mn>0</mn><mo>,</mo><mi>k</mi></mrow></mrow> <annotation encoding="application/x-tex">c_{k}&gt;0,\forall k</annotation></semantics></math></span> <span id="S4.Ex12"><math xmlns="http://www.w3.org/1998/Math/MathML" display="block" data-latex="\sumop\slimits@_{k=1}^{K}c_{k}\left(m_{k}\left(P_{{\bm{\theta}}}^{({\bm{a}})}\right)-m_{k}\left(Q^{({\bm{a}})}\right)\right)^{2},"><semantics><mrow><mrow><msubsup><mrow><mi mathsize="0.900em">k</mi> <mo mathsize="0.900em">=</mo> <mn mathsize="0.900em">1</mn></mrow> <mi mathsize="0.900em">K</mi></msubsup> <mo lspace="0em" rspace="0em"></mo><msub><mi mathsize="0.900em">c</mi> <mi mathsize="0.900em">k</mi></msub> <mo lspace="0em" rspace="0em"></mo><msup><mrow><mo>(</mo><mrow><mrow><msub><mi mathsize="0.900em">m</mi> <mi mathsize="0.900em">k</mi></msub> <mo lspace="0em" rspace="0em"></mo><mrow><mo>(</mo><msubsup><mi mathsize="0.900em">P</mi> <mi mathsize="0.900em">𝜽</mi> <mrow><mo maxsize="0.900em" minsize="0.900em">(</mo><mi mathsize="0.900em">𝒂</mi><mo maxsize="0.900em" minsize="0.900em">)</mo></mrow></msubsup><mo>)</mo></mrow></mrow> <mo mathsize="0.900em">−</mo> <mrow><msub><mi mathsize="0.900em">m</mi> <mi mathsize="0.900em">k</mi></msub> <mo lspace="0em" rspace="0em"></mo><mrow><mo>(</mo><msup><mi mathsize="0.900em">Q</mi> <mrow><mo maxsize="0.900em" minsize="0.900em">(</mo><mi mathsize="0.900em">𝒂</mi><mo maxsize="0.900em" minsize="0.900em">)</mo></mrow></msup><mo>)</mo></mrow></mrow></mrow><mo>)</mo></mrow> <mn mathsize="0.900em">2</mn></msup></mrow><mo mathsize="0.900em">,</mo></mrow><annotation encoding="application/x-tex">\sumop\slimits@_{k=1}^{K}c_{k}\left(m_{k}\left(P_{{\bm{\theta}}}^{({\bm{a}})}\right)-m_{k}\left(Q^{({\bm{a}})}\right)\right)^{2},</annotation></semantics></math></span> <span style="font-size:90%;">for finite <math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="K"><semantics><mi>K</mi> <annotation encoding="application/x-tex">K</annotation></semantics></math> does not imply <math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="P_{{\bm{\theta}}}^{({\bm{a}})}=Q^{({\bm{a}})}"><semantics><mrow><msubsup><mi>P</mi> <mi>𝜽</mi> <mrow><mo stretchy="false">(</mo><mi>𝒂</mi><mo stretchy="false">)</mo></mrow></msubsup> <mo>=</mo> <msup><mi>Q</mi> <mrow><mo stretchy="false">(</mo><mi>𝒂</mi><mo stretchy="false">)</mo></mrow></msup></mrow> <annotation encoding="application/x-tex">P_{{\bm{\theta}}}^{({\bm{a}})}=Q^{({\bm{a}})}</annotation></semantics></math>. (Proof in Section˜B.11.)</span></span></foreignObject></g></g></svg>

Hence Section˜4.2.1 prescribes us with the guideline to employ as large $K$ as possible to remove collapsed shortcut solution by making sure our distribution matching is accurate. Yet, doing so leads to unstable gradient-based training due to the gradient norm scaling as $O(k)$, and the variance of Monte Carlo gradient estimates growing as $O(k^{2}m_{2(k-1)})$ for the $k$ -th moment since $\big\|\nabla_{\theta}m_{k}(P_{{\bm{\theta}}}^{({\bm{a}})})\big\|=\|\mathbb{E}\big[k({\bm{a}}^{\top}f_{{\bm{\theta}}}({\bm{x}}))^{k-1}{\bm{a}}^{\top}J_{f_{\bm{\theta}}}({\bm{x}})\big]\|$, with $J_{f_{\bm{\theta}}}({\bm{x}})\in\mathbb{R}^{K\times P}$ the Jacobian matrix–hereby creating an impractical situation where training stability and identifiability can not be achieved simultaneously.

![Refer to caption](https://arxiv.org/html/2511.08544v3/x5.png)

Figure 6: N = 100 N=100 samples are drawn from a 1024 -dimensional standard Gaussian, and the first 2 coordinates are altered to produce the “X” distribution from Figure ˜ 5 ( left-most column ). For each statistic ( all other columns ), we perform gradient descent on the samples to minimize their value, at each iteration step with sample M 10 M=10 random directions to evaluate SIGReg (recall Section 4.2 ). We obtain that albeit this is a high-dimensional distribution with limited number of samples, SIGReg is able to capture the degenerate subspace and adapt the data accordingly to match an isotropic Gaussian distribution. Additional figures with varying dimensions and number of 1d projections are provided in 16.

#### 4.2.2  Cumulative Density Functions are Impractical

The second family of tests acts upon the CDF. Because those tests require sorting, let’s denote the $k^{\rm th}$ order-statistics of $N$ samples by $x_{k:N}$. Two highly standard tests are quadratic Empirical Density Function statistics with different weighting known as Cramér-von Mises (cramer1928composition; von1981probability) and Anderson Darling (anderson1952asymptotic), and given by

$$
\displaystyle T_{w}
$$
 
$$
\displaystyle=N\intslop\ilimits@_{-\infty}^{\infty}\left(F_{N}(x)-F(x)\right)^{2}w(x)dF(x)
$$
 
$$
\displaystyle w(x)
$$
 
$$
\displaystyle=1,
$$
$$
\displaystyle w(x)
$$
 
$$
\displaystyle=[F(x)(1-F(x))]^{-1},
$$

where $w(x)$ is a weighting function. Adding the $U^{2}$ statistics on top of Equation˜Cramér-von Mises recovers the Watson test (watson1961goodness)

$$
U^{2}=T_{w}-N\left(\bar{F}-\frac{1}{2}\right)^{2}.
$$

We do not consider the Kolmogorov-Smirnov test (kolmogorov1933) as it employs the $\ell_{\infty}$ -norm instead of the $\ell_{2}$ -norm hereby producing sparse gradients. Another common test is the Shapiro-Wilk test (shapiro1965analysis) which we found to be unstable in practice–details are provided in Appendix˜E.

Lack of Scalability and Differentiability. CDF-based tests require sorting that have been highly optimized, e.g., with the $\mathcal{O}(N\log(N))$ Quicksort algorithm (quicksort) but that nonetheless breaks the embarrassingly parallel nature of SGD–especially on multi-GPU (tanasic2013comparison; maltenberger2022evaluating) due to synchronization requirements. Moreover, these tests involve non-differentiable operations (sorting and order statistics), making them unsuitable for gradient-based optimization without relaxations (cuturi2019differentiable; grover2019stochastic; petersen2022monotonic). While there exists intricate sketching solutions (dunning2019computing; masson2019ddsketch; dunning2021t), each of those solutions introduce numerous additional hyper-parameters–going against our first motivation for LeJEPA.

#### 4.2.3  Characteristic Functions are Stable, Scalable and Identifiable

The third family of tests is concerned with Empirical Characteristic Functions (ECF) which are the Fourier transform of the density function. The Epps–Pulley test (epps1983test) is one of the most popular test and simply compares in weighted $\ell_{2}$ -norm the ECF of the data against a target CF

$$
EP=N\intslop\ilimits@_{-\infty}^{\infty}\left|\hat{\phi}_{X}(t)-\phi(t)\right|^{2}w(t)dt.
$$

The first crucial observation is that the ECF being defined as $\hat{\phi}_{X}(t)=\frac{1}{n}\sumop\slimits@_{j=1}^{n}e^{itX_{j}}$ is naturally differentiable and easily computed in distributed settings via efficient all\_reduce operations, as the ECF is a simple average of complex exponentials. The weight function is typically Gaussian, such as $w(t)=e^{-t^{2}/\sigma^{2}}$ with $\sigma$ commonly set to $1$.

Other tests, e.g., based on the Entropy (szekely2005new) are not considered here as they require numerous additional design choices for the univariate Entropy estimation (silverman2018density; beirlant1997nonparametric), e.g., using kernels (joe1989estimation), or M-estimators (miller2003new).

Epps-Pulley has bounded loss, gradient and curvature. We now consider the remaining two families of tests: moment-based and CF-based. First, recall that moments are polynomial in the data and with extreme growth rate for higher moment–assuming they even exist. Even for well-behaved distributions, raising values to a power of $k$ can quickly lead to exploding gradients. This comes in sharp contrast with the ECF which is always bounded and with bounded gradients for any input distribution for the projected samples $z_{i}={\bm{a}}^{\top}f_{\theta}({\bm{x}}_{n})$, $n=1,\ldots,N$.

<svg height="517.3" id="S4.SS2.SSS3.p4.pic1" overflow="visible" version="1.1" viewBox="0 0 600 517.3" width="600"><g fill="#000000" stroke="#000000" stroke-width="0.4pt" style="--ltx-stroke-color:#000000;--ltx-fill-color:#000000;" transform="translate(0,517.3) matrix(1 0 0 -1 0 0)"><g fill="#590000" fill-opacity="1.0" style="--ltx-fill-color:#590000;"><path d="M 0 5.91 L 0 511.4 C 0 514.66 2.64 517.3 5.91 517.3 L 594.09 517.3 C 597.36 517.3 600 514.66 600 511.4 L 600 5.91 C 600 2.64 597.36 0 594.09 0 L 5.91 0 C 2.64 0 0 2.64 0 5.91 Z" style="stroke:none"></path></g><g fill="#FFF2F2" fill-opacity="1.0" style="--ltx-fill-color:#FFF2F2;"><path d="M 1.97 5.91 L 1.97 498.3 L 598.03 498.3 L 598.03 5.91 C 598.03 3.73 596.27 1.97 594.09 1.97 L 5.91 1.97 C 3.73 1.97 1.97 3.73 1.97 5.91 Z" style="stroke:none"></path></g><g fill-opacity="1.0" transform="matrix(1.0 0.0 0.0 1.0 9.26 504.34)"><foreignObject color="#FFFFFF" height="12.3" overflow="visible" style="--ltx-fg-color:#FFFFFF;--fo_width :42.02em;--fo_height:0.69em;--fo_depth :0.19em;" transform="matrix(1 0 0 -1 0 9.61)" width="581.48"><span style="width:36.54em;"><span id="S4.SS2.SSS3.p4.pic1.p1">Theorem&nbsp;4:&nbsp;Stability of Epps-Pulley Test</span> </span></foreignObject></g><g fill-opacity="1.0" transform="matrix(1.0 0.0 0.0 1.0 9.26 10.4)"><foreignObject color="#000000" height="481.75" overflow="visible" style="--ltx-fg-color:#000000;--fo_width :42.02em;--fo_height:34.59em;--fo_depth :0.22em;" transform="matrix(1 0 0 -1 0 478.64)" width="581.48"><span style="width:45.43em;"><span style="font-size:90%;">(Epps–Pulley) satisfies for samples <math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="z_{1},\dots,z_{N}"><semantics><mrow><msub><mi>z</mi> <mn>1</mn></msub><mo>,</mo><mi mathvariant="normal">…</mi><mo>,</mo><msub><mi>z</mi> <mi>N</mi></msub></mrow> <annotation encoding="application/x-tex">z_{1},\dots,z_{N}</annotation></semantics></math></span> <span id="S4.Ex18"><math xmlns="http://www.w3.org/1998/Math/MathML" display="block" data-latex="\left|\frac{\partial EP(\mathbf{a})}{\partial z_{i}}\right|\leq\frac{4\sigma^{2}}{N},\quad\left|\frac{\partial^{2}EP(\mathbf{a})}{\partial z_{i}^{2}}\right|\leq\frac{C\sqrt{\pi}\sigma^{3}}{2N},"><semantics><mrow><mrow><mrow><mrow><mo>|</mo> <mfrac><mrow><mo mathsize="0.900em" rspace="0em">∂</mo> <mrow><mi mathsize="0.900em">E</mi> <mo lspace="0em" rspace="0em"></mo><mi mathsize="0.900em">P</mi> <mo lspace="0em" rspace="0em"></mo><mrow><mo maxsize="0.900em" minsize="0.900em">(</mo><mi mathsize="0.900em">𝐚</mi><mo maxsize="0.900em" minsize="0.900em">)</mo></mrow></mrow></mrow> <mrow><mo mathsize="0.900em" rspace="0em">∂</mo> <msub><mi mathsize="0.900em">z</mi> <mi mathsize="0.900em">i</mi></msub></mrow></mfrac> <mo>|</mo></mrow> <mo mathsize="0.900em">≤</mo> <mfrac><mrow><mn mathsize="0.900em">4</mn> <mo lspace="0em" rspace="0em"></mo><msup><mi mathsize="0.900em">σ</mi> <mn mathsize="0.900em">2</mn></msup></mrow> <mi mathsize="0.900em">N</mi></mfrac></mrow><mo mathsize="0.900em" rspace="1.087em">,</mo><mrow><mrow><mo>|</mo> <mfrac><mrow><msup><mo mathsize="0.900em">∂</mo> <mn mathsize="0.900em">2</mn></msup> <mrow><mi mathsize="0.900em">E</mi> <mo lspace="0em" rspace="0em"></mo><mi mathsize="0.900em">P</mi> <mo lspace="0em" rspace="0em"></mo><mrow><mo maxsize="0.900em" minsize="0.900em">(</mo><mi mathsize="0.900em">𝐚</mi><mo maxsize="0.900em" minsize="0.900em">)</mo></mrow></mrow></mrow> <mrow><mo mathsize="0.900em" rspace="0em">∂</mo> <msubsup><mi mathsize="0.900em">z</mi> <mi mathsize="0.900em">i</mi> <mn mathsize="0.900em">2</mn></msubsup></mrow></mfrac> <mo>|</mo></mrow> <mo mathsize="0.900em">≤</mo> <mfrac><mrow><mi mathsize="0.900em">C</mi> <mo lspace="0em" rspace="0em"></mo><msqrt><mi mathsize="0.900em">π</mi></msqrt> <mo lspace="0em" rspace="0em"></mo><msup><mi mathsize="0.900em">σ</mi> <mn mathsize="0.900em">3</mn></msup></mrow> <mrow><mn mathsize="0.900em">2</mn> <mo lspace="0em" rspace="0em"></mo><mi mathsize="0.900em">N</mi></mrow></mfrac></mrow></mrow><mo mathsize="0.900em">,</mo></mrow><annotation encoding="application/x-tex">\left|\frac{\partial EP(\mathbf{a})}{\partial z_{i}}\right|\leq\frac{4\sigma^{2}}{N},\quad\left|\frac{\partial^{2}EP(\mathbf{a})}{\partial z_{i}^{2}}\right|\leq\frac{C\sqrt{\pi}\sigma^{3}}{2N},</annotation></semantics></math></span> <span style="font-size:90%;">with constant <math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="C"><semantics><mi>C</mi> <annotation encoding="application/x-tex">C</annotation></semantics></math>, and bandwidth <math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="\sigma"><semantics><mi>σ</mi> <annotation encoding="application/x-tex">\sigma</annotation></semantics></math>. (Proof in Section˜B.12.)</span></span></foreignObject></g></g></svg>

Algorithm 1: SIGReg with Epps-Pulley statistic with DDP support and $\mathcal{O}(N)$ time and memory complexity. x is a (N, K) tensor, num\_slices is $|{\mathbb{A}}|$ in Section˜4.2, ‘global\_step‘ is used for sync. sampling across GPUs and can be omited for single-GPU training. An optimized implementation with caching is also provided in our official codebase, computation times provided in Table˜6.

[⬇](data:text/plain;base64,ZGVmIFNJR1JlZyh4LCBnbG9iYWxfc3RlcCwgbnVtX3NsaWNlcz0yNTYpOgogICAgIyBzbGljZSBzYW1wbGluZyAtLSBzeW5jZWQgYWNyb3NzIGRldmljZXMgLS0KICAgIGRldiA9IGRpY3QoZGV2aWNlPXguZGV2aWNlKQogICAgZyA9IHRvcmNoLkdlbmVyYXRvcigqKmRldikKICAgIGcubWFudWFsX3NlZWQoZ2xvYmFsX3N0ZXApCiAgICBwcm9qX3NoYXBlID0gKHguc2l6ZSgxKSwgbnVtX3NsaWNlcykKICAgIEEgPSB0b3JjaC5yYW5kbihwcm9qX3NoYXBlLCAgZ2VuZXJhdG9yPWcsICoqZGV2KQogICAgQSAvPSBBLm5vcm0ocD0yLCBkaW09MCkKICAgICMgLS0gRXBwcy1QdWxsZXkgc3RhdC4gc2VlIFNlYy4gNC4zIGZvciBhbHQuIC0tCiAgICAjIGludGVncmF0aW9uIHBvaW50cwogICAgdCA9IHRvcmNoLmxpbnNwYWNlKC01LCA1LCAxNywgKipkZXYpCiAgICAjIHRoZW9yZXRpY2FsIENGIGZvciBOKDAsIDEpIGFuZCBHYXVzcy4gd2luZG93CiAgICBleHBfZiA9IHRvcmNoLmV4cCgtMC41ICogdCoqMikKICAgICMgZW1waXJpY2FsIENGIC0tIGdhdGhlcmVkIGFjcm9zcyBkZXZpY2VzIC0tCiAgICB4X3QgPSAoeCBAIEEpLnVuc3F1ZWV6ZSgyKSAqIHQgICMgKE4sIE0sIFQpCiAgICBlY2YgPSAoMWogKiB4X3QpLmV4cCgpLm1lYW4oMCkKICAgIGVjZiA9IGFsbF9yZWR1Y2UoZWNmLCBvcD0iQVZHIikKICAgICMgd2VpZ2h0ZWQgTDIgZGlzdGFuY2UKICAgIGVyciA9IChlY2YgLSBleHBfZikuYWJzKCkuc3F1YXJlKCkubXVsKGV4cF9mKQogICAgTiA9IHguc2l6ZSgwKSAqIHdvcmxkX3NpemUKICAgIFQgPSB0b3JjaC50cmFweihlcnIsIHQsIGRpbT0xKSAqIE4KICAgIHJldHVybiBU)

def SIGReg(x, global\_step, num\_slices=256):

\# slice sampling – synced across devices –

dev = dict(device=x.device)

g = torch.Generator(\*\*dev)

g.manual\_seed(global\_step)

proj\_shape = (x.size(1), num\_slices)

A = torch.randn(proj\_shape, generator=g, \*\*dev)

A /= A.norm(p=2, dim=0)

\# – Epps-Pulley stat. see Sec. 4.3 for alt. –

\# integration points

t = torch.linspace(-5, 5, 17, \*\*dev)

\# theoretical CF for N(0, 1) and Gauss. window

exp\_f = torch.exp(-0.5 \* t\*\*2)

\# empirical CF – gathered across devices –

x\_t = (x @ A).unsqueeze(2) \* t # (N, M, T)

ecf = (1j \* x\_t).exp().mean(0)

ecf = all\_reduce(ecf, op="AVG")

\# weighted L2 distance

err = (ecf - exp\_f).abs().square().mul(exp\_f)

N = x.size(0) \* world\_size

T = torch.trapz(err, t, dim=1) \* N

return T

By the chain rule, Section˜4.2.3 directly gives $\left\|\nabla_{\theta}EP(\mathbf{a})\right\|\leq\frac{4\sigma^{2}}{N}\sumop\slimits@_{i=1}^{N}\|\mathbf{a}^{\top}\nabla_{\theta}f_{\theta}(\mathbf{x}_{i})\|$, providing stable gradients. The limitations of moment-based and CDF-based tests coupled with Section˜4.2.3 justifies our choice of the (Epps–Pulley): (i) DDP-friendly and scalable, (ii) uniformly bounded gradients and curvature regardless of input distribution, and (iii) hyper-parameter free implementation. Lastly, we highlight that our implementation has a linear memory and computational complexity of $\mathcal{O}(N)$, with $N$ the minibatch size. The implementation of SIGReg using that statistical test is provided in LABEL:lst:epps-pulley-pytorch, along with computation times of the forward-backward pass in Table˜6.

As a last step before introducing LeJEPA, we ought to study the requirements on the number of directions ($|{\mathbb{A}}|$) for (4.2) to be effective in high-dimension.

### 4.3  How SIGReg Beats the Curse of Dimensionality

This last section seeks to characterize how many slices in ${\mathbb{A}}$ one must sample for (5) to be an effective statistical test. That design is crucial if we hope for LeJEPA to successfully converge towards isotropic Gaussian embeddings.

#### Smoothness Beats the Curse of Dimensionality

Our first argument arguing for a favorable scaling of $|{\mathbb{A}}|$ with the embedding dimension $K$ relies on the smoothness of $P_{{\bm{\theta}}}$ as measured by its Sobolev regularity $\alpha$ (adams2003sobolev). We formalize below a bound on the directional test from Equation˜3 over all possible directions ${\bm{a}}$ when the test statistic is minimized over $|{\mathbb{A}}|=M$ directions. While we provide bounds on the expected discrepancy over random directions ${\bm{a}}$ when the EP test is satisfied (equals zero) on a finite set of directions, the provided proof includes the case of moment-based and CDF-based tests as well.

![Refer to caption](https://arxiv.org/html/2511.08544v3/x6.png)

Figure 7: Expected directional statistic at the end of training ( y-axis ) for varying M (number of directions used at each training step, x-axis ). The directions are either resampled ( green ) or kept fixed ( blue ) at each training step. While for fixed directions we benefit from Section ˜ 4.3 bound where increasing reduces the overall expected loss, being able to resample at every step provides significant coverage boost for free.

<svg height="96.57" id="S4.SS3.SSSx1.p2.pic1" overflow="visible" version="1.1" viewBox="0 0 600 96.57" width="600"><g fill="#000000" stroke="#000000" stroke-width="0.4pt" style="--ltx-stroke-color:#000000;--ltx-fill-color:#000000;" transform="translate(0,96.57) matrix(1 0 0 -1 0 0)"><g fill="#590000" fill-opacity="1.0" style="--ltx-fill-color:#590000;"><path d="M 0 5.91 L 0 90.67 C 0 93.93 2.64 96.57 5.91 96.57 L 594.09 96.57 C 597.36 96.57 600 93.93 600 90.67 L 600 5.91 C 600 2.64 597.36 0 594.09 0 L 5.91 0 C 2.64 0 0 2.64 0 5.91 Z" style="stroke:none"></path></g><g fill="#FFF2F2" fill-opacity="1.0" style="--ltx-fill-color:#FFF2F2;"><path d="M 1.97 5.91 L 1.97 80.26 L 598.03 80.26 L 598.03 5.91 C 598.03 3.73 596.27 1.97 594.09 1.97 L 5.91 1.97 C 3.73 1.97 1.97 3.73 1.97 5.91 Z" style="stroke:none"></path></g><g fill-opacity="1.0" transform="matrix(1.0 0.0 0.0 1.0 9.26 83.61)"><foreignObject color="#FFFFFF" height="9.61" overflow="visible" style="--ltx-fg-color:#FFFFFF;--fo_width :42.02em;--fo_height:0.69em;--fo_depth :0em;" transform="matrix(1 0 0 -1 0 9.61)" width="581.48"><span style="width:36.54em;"><span id="S4.SS3.SSSx1.p2.pic1.p1">Theorem&nbsp;5:&nbsp;Unified Error Bounds</span> </span></foreignObject></g><g fill-opacity="1.0" transform="matrix(1.0 0.0 0.0 1.0 9.26 10.4)"><foreignObject color="#000000" height="63.71" overflow="visible" style="--ltx-fg-color:#000000;--fo_width :42.02em;--fo_height:4.38em;--fo_depth :0.22em;" transform="matrix(1 0 0 -1 0 60.6)" width="581.48"><span style="width:45.43em;"><span style="font-size:90%;">Let <math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="p_{{\bm{\theta}}}\in H^{\alpha}(\mathbb{R}^{K})"><semantics><mrow><msub><mi>p</mi> <mi>𝜽</mi></msub> <mo>∈</mo> <mrow><msup><mi>H</mi> <mi>α</mi></msup> <mo lspace="0em" rspace="0em"></mo><mrow><mo stretchy="false">(</mo><msup><mi>R</mi> <mi>K</mi></msup><mo stretchy="false">)</mo></mrow></mrow></mrow> <annotation encoding="application/x-tex">p_{{\bm{\theta}}}\in H^{\alpha}(\mathbb{R}^{K})</annotation></semantics></math>, <math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="{\bm{a}}\sim\mathcal{U}(\mathcal{S}^{K-1})"><semantics><mrow><mi>𝒂</mi> <mo>∼</mo> <mrow><mi>𝒰</mi> <mo lspace="0em" rspace="0em"></mo><mrow><mo stretchy="false">(</mo><msup><mi>𝒮</mi> <mrow><mi>K</mi> <mo>−</mo> <mn>1</mn></mrow></msup><mo stretchy="false">)</mo></mrow></mrow></mrow> <annotation encoding="application/x-tex">{\bm{a}}\sim\mathcal{U}(\mathcal{S}^{K-1})</annotation></semantics></math>, and (Epps–Pulley) <math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="=0"><semantics><mrow><mo>=</mo> <mn>0</mn></mrow> <annotation encoding="application/x-tex">=0</annotation></semantics></math>, i.e., <math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="P_{\theta}^{(\mathbf{a})}=Q^{(\mathbf{a})},\forall{\bm{a}}\in{\mathbb{A}}"><semantics><mrow><mrow><msubsup><mi>P</mi> <mi>θ</mi> <mrow><mo stretchy="false">(</mo><mi>𝐚</mi><mo stretchy="false">)</mo></mrow></msubsup> <mo>=</mo> <msup><mi>Q</mi> <mrow><mo stretchy="false">(</mo><mi>𝐚</mi><mo stretchy="false">)</mo></mrow></msup></mrow><mo>,</mo><mrow><mi>𝒂</mi> <mo>∈</mo> <mi>A</mi></mrow></mrow> <annotation encoding="application/x-tex">P_{\theta}^{(\mathbf{a})}=Q^{(\mathbf{a})},\forall{\bm{a}}\in{\mathbb{A}}</annotation></semantics></math>, then</span> <math xmlns="http://www.w3.org/1998/Math/MathML" display="block" data-latex="\mathbb{E}_{{\bm{a}}}\left[\intslop\ilimits@_{\mathbb{R}}\left|\varphi_{a}(t)-\varphi_{\mathcal{N}}(t)\right|^{2}dt\right]\leq C(K,\alpha)|{\mathbb{A}}|^{-2\alpha/(K-1)}\\
\times\intslop\ilimits@_{0}^{\infty}\left\|\varphi_{\cdot}(r)-\varphi_{\mathcal{N}}(r)\right\|_{H^{\alpha}(\mathcal{S}^{K-1})}^{2}dr,"><semantics><mtable displaystyle="true" rowspacing="0pt"><mtr><mtd columnalign="left"><mrow><mrow><msub><mi mathsize="0.900em">E</mi> <mi mathsize="0.900em">𝒂</mi></msub> <mo lspace="0em" rspace="0em"></mo><mrow><mo>[</mo><mrow><msub><mi mathsize="0.900em">R</mi></msub> <mo lspace="0em" rspace="0em"></mo><msup><mrow><mo>|</mo> <mrow><mrow><msub><mi mathsize="0.900em">φ</mi> <mi mathsize="0.900em">a</mi></msub> <mo lspace="0em" rspace="0em"></mo><mrow><mo maxsize="0.900em" minsize="0.900em">(</mo><mi mathsize="0.900em">t</mi><mo maxsize="0.900em" minsize="0.900em">)</mo></mrow></mrow> <mo mathsize="0.900em">−</mo> <mrow><msub><mi mathsize="0.900em">φ</mi> <mi mathsize="0.900em">𝒩</mi></msub> <mo lspace="0em" rspace="0em"></mo><mrow><mo maxsize="0.900em" minsize="0.900em">(</mo><mi mathsize="0.900em">t</mi><mo maxsize="0.900em" minsize="0.900em">)</mo></mrow></mrow></mrow> <mo>|</mo></mrow> <mn mathsize="0.900em">2</mn></msup> <mo lspace="0em" rspace="0em"></mo><mi mathsize="0.900em">d</mi> <mo lspace="0em" rspace="0em"></mo><mi mathsize="0.900em">t</mi></mrow><mo>]</mo></mrow></mrow> <mo mathsize="0.900em">≤</mo> <mrow><mi mathsize="0.900em">C</mi> <mo lspace="0em" rspace="0em"></mo><mrow><mo maxsize="0.900em" minsize="0.900em">(</mo><mi mathsize="0.900em">K</mi><mo mathsize="0.900em">,</mo><mi mathsize="0.900em">α</mi><mo maxsize="0.900em" minsize="0.900em">)</mo></mrow> <mo lspace="0em" rspace="0em"></mo><msup><mrow><mo maxsize="0.900em" minsize="0.900em" stretchy="true">|</mo> <mi mathsize="0.900em">A</mi> <mo maxsize="0.900em" minsize="0.900em" stretchy="true">|</mo></mrow> <mrow><mo mathsize="0.900em">−</mo> <mrow><mrow><mn mathsize="0.900em">2</mn> <mo lspace="0em" rspace="0em"></mo><mi mathsize="0.900em">α</mi></mrow> <mo maxsize="0.900em" minsize="0.900em" stretchy="true" symmetric="true">/</mo> <mrow><mo maxsize="0.900em" minsize="0.900em">(</mo><mrow><mi mathsize="0.900em">K</mi> <mo mathsize="0.900em">−</mo> <mn mathsize="0.900em">1</mn></mrow><mo maxsize="0.900em" minsize="0.900em">)</mo></mrow></mrow></mrow></msup></mrow></mrow></mtd></mtr> <mtr><mtd columnalign="right"><mrow><mrow><mo lspace="0.222em" mathsize="0.900em" rspace="0.222em">×</mo> <mrow><mrow><msubsup><mn mathsize="0.900em">0</mn> <mi mathsize="0.900em" mathvariant="normal">∞</mi></msubsup> <mo lspace="0em" rspace="0em"></mo><mo lspace="0em" rspace="0em"></mo><msub><mi mathsize="0.900em">φ</mi> <mo mathsize="0.900em">⋅</mo></msub> <mo lspace="0em" rspace="0em"></mo><mrow><mo maxsize="0.900em" minsize="0.900em">(</mo><mi mathsize="0.900em">r</mi><mo maxsize="0.900em" minsize="0.900em">)</mo></mrow></mrow> <mo mathsize="0.900em">−</mo> <mrow><msub><mi mathsize="0.900em">φ</mi> <mi mathsize="0.900em">𝒩</mi></msub> <mo lspace="0em" rspace="0em"></mo><mrow><mo maxsize="0.900em" minsize="0.900em">(</mo><mi mathsize="0.900em">r</mi><mo maxsize="0.900em" minsize="0.900em">)</mo></mrow> <mo lspace="0em" rspace="0em"></mo><msubsup><mrow><msup><mi mathsize="0.900em">H</mi> <mi mathsize="0.900em">α</mi></msup> <mo lspace="0em" rspace="0em"></mo><mrow><mo maxsize="0.900em" minsize="0.900em">(</mo><msup><mi mathsize="0.900em">𝒮</mi> <mrow><mi mathsize="0.900em">K</mi> <mo mathsize="0.900em">−</mo> <mn mathsize="0.900em">1</mn></mrow></msup><mo maxsize="0.900em" minsize="0.900em">)</mo></mrow></mrow> <mn mathsize="0.900em">2</mn></msubsup> <mo lspace="0em" rspace="0em"></mo><mi mathsize="0.900em">d</mi> <mo lspace="0em" rspace="0em"></mo><mi mathsize="0.900em">r</mi></mrow></mrow></mrow><mo mathsize="0.900em">,</mo></mrow></mtd></mtr></mtable><annotation encoding="application/x-tex">\mathbb{E}_{{\bm{a}}}\left[\intslop\ilimits@_{\mathbb{R}}\left|\varphi_{a}(t)-\varphi_{\mathcal{N}}(t)\right|^{2}dt\right]\leq C(K,\alpha)|{\mathbb{A}}|^{-2\alpha/(K-1)}\\ \times\intslop\ilimits@_{0}^{\infty}\left\|\varphi_{\cdot}(r)-\varphi_{\mathcal{N}}(r)\right\|_{H^{\alpha}(\mathcal{S}^{K-1})}^{2}dr,</annotation></semantics></math> <span style="font-size:90%;">(Proof in Section˜B.10.)</span></span></foreignObject></g></g></svg>

As $|{\mathbb{A}}|\to\infty$, the bound decays as $|{\mathbb{A}}|^{-2\alpha/(K-1)}$, showing that $|{\mathbb{A}}|=O(K)$ directions suffice for $\epsilon$ -approximation when $\alpha$ is large. Some examples of embedding densities with varying $\alpha$ are provided in Figure˜4. The following statement characterizes how the $M$ directions actually constrain the entire space as a function of $\alpha$. The constant $C(K,\alpha)=\frac{2^{2\alpha}\pi^{(K-1)/2}\Gamma\left(\alpha+\frac{K-1}{2}\right)}{(K-1)\Gamma(\alpha)\Gamma\left(\frac{K-1}{2}\right)}$ is visualized in Figure˜15 (left) depicting how $\alpha$ and $|{\mathbb{A}}|$ interact. In words, we obtain that thanks to the natural smoothness of DN–either stemming from the architecture or the implicit and explicit regularizers used during training–applying SIGReg on $|{\mathbb{A}}|$ directions can be sufficient to tightly constrain the entire space. We note that considering the worst case over ${\bm{a}}$ or using low-discrepancy sequences for ${\bm{a}}$ does not impact the asymptotic bounds, details provided in Appendix˜D.

#### SGD Beats the Curse of Dimensionality

Our second argument leverages the iterative nature of DN training. Although we may use only $|{\mathbb{A}}|$ to be a few hundreds, the cumulative number of sampled directions grows linearly with training time. This resampling effect (illustrated in Figure˜7, bottom) enables rapid convergence. Even small $|{\mathbb{A}}|$ achieves tight distributional matching compared to keeping the set ${\mathbb{A}}$ fixed throughout minibatches (recall Section˜4.3). Our experiments show that even with $|{\mathbb{A}}|$ as low as $16$ can easily outperform a fixed set with $|{\mathbb{A}}|$ of order of thousands thanks to the compounding effect of resampling at each minibatch.

#### Empirical Validation on Synthetic Data

We conclude this section with a controlled experiment applying (5) with gradient-based training to produce isotropic embeddings. In this setup, we directly consider embeddings ${\bm{Z}}$ which we will differentiate and optimized to minimize (5). By directly optimizing the embeddings we are able to observe the impact of the loss without any possible constraint and regularization that would come from the architecture. We sample $N$ i.i.d. samples ${\bm{x}}_{n}$ in a $D$ -dimensional space. This sampling is based on an isotropic Gaussian distribution–but the first two dimensions are again set to the adversarial “X” shape. That is, among the $D$ dimensions, only two must be transformed as all the other ones already obey the isotropic Gaussian target distribution. We then make the samples ${\bm{x}}_{n}$ differentiable and optimize then to minimize the value of the different statistical tests compute on $M$ random $M$ random directions. Those directions are resampled after each gradient step–which follows the procedure we will employ in LeJEPA. We present the results in Figure˜6 demonstrating that even in challenging case, i.e., $D=512$ and $M=16$, SIGReg is able to detect the two degenerate dimensions and unfold them back to how they should look like under the target distribution.

## 5  LeJEPA: Stable and Scalable Implementation

Having established that isotropic Gaussians are the optimal embedding distribution for foundation models (Section˜3) and introduced SIGReg to achieve this distribution (Section˜4.2), we now present the complete LeJEPA framework. We first evaluate candidate statistical tests (Sections˜4.2.1 and 4.2.2) and identify characteristic function-based tests as optimal for gradient-based training (Section˜4.2.3). The full LeJEPA implementation follows in Section˜5.1.

### 5.1  LeJEPA: SIGReg + Prediction Loss

Algorithm 2: LeJEPA implementation–works out-of-the-box on any dataset, with DDP, with any backbone, e.g., torchvision or timm. For non-ViT architectures (e.g., ResNet), set global\_views = all\_views. We use bs for the minibatch size, SIGReg is from LABEL:lst:epps-pulley-pytorch.

[⬇](data:text/plain;base64,ZGVmIExlSkVQQShnbG9iYWxfdmlld3MsIGFsbF92aWV3cywgbGFtYmQpOgogICAgIiIiZ2xvYmFsX3ZpZXdzIGFuZCBhbGxfdmlld3MgYXJlIGxpc3RzIG9mIHRlbnNvcnMsIGxhbWJkIGlzIGEgc2NhbGFyIiIiCgogICAgIyBlbWJlZGRpbmcgb2YgZ2xvYmFsIHZpZXdzCiAgICBnX2VtYiA9IGZvcndhcmQodG9yY2guY2F0KGdsb2Jfdmlld3MpKQogICAgIyBlbWJlZGRpbmcgb2YgbG9jYWwgdmlld3MKICAgICMgaWYgcmVzbmV0OiBza2lwIHdpdGggYV9lbWI9Z19lbWIKICAgIGFfZW1iID0gZm9yd2FyZCh0b3JjaC5jYXQoYWxsX3ZpZXdzKSkKCiAgICAjIExlSkVQQSBsb3NzCiAgICBjZW50ZXJzID0gZ19lbWIudmlldygtMSwgYnMsIEspLm1lYW4oMCkKICAgIGFfZW1iID0gYV9lbWIudmlldygtMSwgYnMsIEspCiAgICBzaW0gPSAoY2VudGVycyAtIGFfZW1iKS5zcXVhcmUoKS5tZWFuKCkKICAgIHNpZ3JlZyA9IG1lYW4oU0lHUmVnKGVtYiwgZ2xvYmFsX3N0ZXApIGZvciBlbWIgaW4gYV9lbWIpCiAgICByZXR1cm4gKDEtbGFtYmQpKnNpbSArIGxhbWJkKnNpZ3JlZw==)

def LeJEPA(global\_views, all\_views, lambd):

"""global\_views and all\_views are lists of tensors, lambd is a scalar"""

\# embedding of global views

g\_emb = forward(torch.cat(glob\_views))

\# embedding of local views

\# if resnet: skip with a\_emb=g\_emb

a\_emb = forward(torch.cat(all\_views))

\# LeJEPA loss

centers = g\_emb.view(-1, bs, K).mean(0)

a\_emb = a\_emb.view(-1, bs, K)

sim = (centers - a\_emb).square().mean()

sigreg = mean(SIGReg(emb, global\_step) for emb in a\_emb)

return (1-lambd)\*sim + lambd\*sigreg

We now discuss the implementation of LeJEPA starting with SIGReg and followed by the prediction and total losses.

The SIGReg Loss. We chose (Epps–Pulley) for its provable boundedness (Section˜4.2.3) and its scalability. Its implementation follows exactly the equation except for the integrate which is estimated using a quadrature approximation. We find that the simple trapezoidal quadrature rule is sufficient even with as few knots as $17$, as ablated in Figure˜20. In particular, we leverage the symmetry of the integrand to double the number of knots for free, see the official code. On the other hand, the use of minibatches introduces a bias vanishing at rate $\mathcal{O}(1/N)$, as formalized below.

<svg height="595.12" id="S5.SS1.p3.pic1" overflow="visible" version="1.1" viewBox="0 0 600 595.12" width="600"><g fill="#000000" stroke="#000000" stroke-width="0.4pt" style="--ltx-stroke-color:#000000;--ltx-fill-color:#000000;" transform="translate(0,595.12) matrix(1 0 0 -1 0 0)"><g fill="#590000" fill-opacity="1.0" style="--ltx-fill-color:#590000;"><path d="M 0 5.91 L 0 589.21 C 0 592.48 2.64 595.12 5.91 595.12 L 594.09 595.12 C 597.36 595.12 600 592.48 600 589.21 L 600 5.91 C 600 2.64 597.36 0 594.09 0 L 5.91 0 C 2.64 0 0 2.64 0 5.91 Z" style="stroke:none"></path></g><g fill="#FFF2F2" fill-opacity="1.0" style="--ltx-fill-color:#FFF2F2;"><path d="M 1.97 5.91 L 1.97 576.12 L 598.03 576.12 L 598.03 5.91 C 598.03 3.73 596.27 1.97 594.09 1.97 L 5.91 1.97 C 3.73 1.97 1.97 3.73 1.97 5.91 Z" style="stroke:none"></path></g><g fill-opacity="1.0" transform="matrix(1.0 0.0 0.0 1.0 9.26 582.16)"><foreignObject color="#FFFFFF" height="12.3" overflow="visible" style="--ltx-fg-color:#FFFFFF;--fo_width :42.02em;--fo_height:0.69em;--fo_depth :0.19em;" transform="matrix(1 0 0 -1 0 9.61)" width="581.48"><span style="width:36.54em;"><span id="S5.SS1.p3.pic1.p1">Theorem&nbsp;6:&nbsp;Vanishing gradient bias</span> </span></foreignObject></g><g fill-opacity="1.0" transform="matrix(1.0 0.0 0.0 1.0 9.26 10.4)"><foreignObject color="#000000" height="559.57" overflow="visible" style="--ltx-fg-color:#000000;--fo_width :42.02em;--fo_height:40.21em;--fo_depth :0.22em;" transform="matrix(1 0 0 -1 0 556.45)" width="581.48"><span style="width:45.43em;"><span style="font-size:90%;">The expectation of (Epps–Pulley) satisfies</span> <span id="S5.Ex19"><math xmlns="http://www.w3.org/1998/Math/MathML" display="block" data-latex="\mathbb{E}\left[\mathaccent 866{L}_{n}(\theta)\right]=L(\theta)+\frac{1}{N}\intslop\ilimits@_{\mathbb{R}}w_{s}(t)\big(1-|\varphi_{P}(t)|^{2}\big)dt,"><semantics><mrow><mrow><mrow><mi mathsize="0.900em">E</mi> <mo lspace="0em" rspace="0em"></mo><mrow><mo>[</mo><mrow><msub><mover accent="true"><mi mathsize="0.900em">L</mi> <mo mathsize="0.900em">^</mo></mover> <mi mathsize="0.900em">n</mi></msub> <mo lspace="0em" rspace="0em"></mo><mrow><mo maxsize="0.900em" minsize="0.900em">(</mo><mi mathsize="0.900em">θ</mi><mo maxsize="0.900em" minsize="0.900em">)</mo></mrow></mrow><mo>]</mo></mrow></mrow> <mo mathsize="0.900em">=</mo> <mrow><mrow><mi mathsize="0.900em">L</mi> <mo lspace="0em" rspace="0em"></mo><mrow><mo maxsize="0.900em" minsize="0.900em">(</mo><mi mathsize="0.900em">θ</mi><mo maxsize="0.900em" minsize="0.900em">)</mo></mrow></mrow> <mo mathsize="0.900em">+</mo> <mrow><mfrac><mn mathsize="0.900em">1</mn> <mi mathsize="0.900em">N</mi></mfrac> <mo lspace="0em" rspace="0em"></mo><msub><mi mathsize="0.900em">R</mi></msub> <mo lspace="0em" rspace="0em"></mo><msub><mi mathsize="0.900em">w</mi> <mi mathsize="0.900em">s</mi></msub> <mo lspace="0em" rspace="0em"></mo><mrow><mo maxsize="0.900em" minsize="0.900em">(</mo><mi mathsize="0.900em">t</mi><mo maxsize="0.900em" minsize="0.900em">)</mo></mrow> <mo lspace="0em" rspace="0em"></mo><mrow><mo maxsize="1.200em" minsize="1.200em">(</mo><mrow><mn mathsize="0.900em">1</mn> <mo mathsize="0.900em">−</mo> <msup><mrow><mo maxsize="0.900em" minsize="0.900em" stretchy="true">|</mo> <mrow><msub><mi mathsize="0.900em">φ</mi> <mi mathsize="0.900em">P</mi></msub> <mo lspace="0em" rspace="0em"></mo><mrow><mo maxsize="0.900em" minsize="0.900em">(</mo><mi mathsize="0.900em">t</mi><mo maxsize="0.900em" minsize="0.900em">)</mo></mrow></mrow> <mo maxsize="0.900em" minsize="0.900em" stretchy="true">|</mo></mrow> <mn mathsize="0.900em">2</mn></msup></mrow><mo maxsize="1.200em" minsize="1.200em">)</mo></mrow> <mo lspace="0em" rspace="0em"></mo><mi mathsize="0.900em">d</mi> <mo lspace="0em" rspace="0em"></mo><mi mathsize="0.900em">t</mi></mrow></mrow></mrow><mo mathsize="0.900em">,</mo></mrow><annotation encoding="application/x-tex">\mathbb{E}\left[\mathaccent 866{L}_{n}(\theta)\right]=L(\theta)+\frac{1}{N}\intslop\ilimits@_{\mathbb{R}}w_{s}(t)\big(1-|\varphi_{P}(t)|^{2}\big)dt,</annotation></semantics></math></span> <span style="font-size:90%;">therefore both the loss and its derivative have a bias of order <math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="O(1/n)"><semantics><mrow><mi>O</mi> <mo lspace="0em" rspace="0em"></mo><mrow><mo stretchy="false">(</mo><mrow><mn>1</mn> <mo>/</mo> <mi>n</mi></mrow><mo stretchy="false">)</mo></mrow></mrow> <annotation encoding="application/x-tex">O(1/n)</annotation></semantics></math>. (Proof in Section˜B.13.)</span></span></foreignObject></g></g></svg>

Hence, the gradients we obtain from using (Epps–Pulley) are biased by an explicit $\mathcal{O}(1/N)$ term. We found this bias to be minimal and not a concern even for minibatches as small as 16. Unbiased alternatives include using U-statistic debiasing of $|\phi_{\theta}|^{2}$ or sample splitting, which we do not explore in this study. Our final implementation of the SIGReg term with Epps-Pulley statistic is provided in LABEL:lst:epps-pulley-pytorch.

The Prediction Loss. To standardize notations, we adopt the DINO (caron2021emerging) setup of generating $V_{g}$ global views and $V_{l}$ local views, leading to a total of $V=V_{g}+V_{l}$ views. We set the first $1,\dots,V_{g}$ indices of each ${\bm{z}}_{n,v}$ as the global views. For the cases without local views, simply set $V_{l}=0$. The prediction loss is then given by having all views predict the global views as

$$
\displaystyle\mathcal{L}_{\rm pred}(\{{\bm{z}}_{n,v}\}_{v=1}^{V})=
$$
 
$$
\displaystyle\frac{1}{V_{g}}\sumop\slimits@_{v=1}^{V_{g}}\frac{1}{V}\sumop\slimits@_{v^{\prime}=1}^{V}\left\|{\bm{z}}_{n,v}-{\bm{z}}_{n,v^{\prime}}\right\|_{2}^{2}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\frac{1}{V}\sumop\slimits@_{v^{\prime}=1}^{V}\left\|\frac{1}{V_{\rm g}}\sumop\slimits@_{v=1}^{V_{\rm g}}{\bm{z}}_{n,v}-{\bm{z}}_{n,v^{\prime}}\right\|_{2}^{2}
$$
 
$$
\displaystyle\frac{1}{V}\sumop\slimits@_{v^{\prime}=1}^{V}\left\|\bm{\mu}_{n}-{\bm{z}}_{n,v^{\prime}}\right\|_{2}^{2},
$$

where we denote $\bm{\mu}_{n}\triangleq\frac{1}{V_{g}}\sumop\slimits@_{v=1}^{V_{g}}{\bm{z}}_{n,v}$, the Equation˜6 to Equation˜7 derivations are detailed in Section˜B.6.

LeJEPA Loss. The final total loss simply combines the above prediction loss along with SIGReg on each views as per

$$
\mathcal{L}_{\rm LeJEPA}(\{{\bm{x}}_{n,v}\}_{n,v=1}^{B,V})=\frac{\lambda}{V}\sumop\slimits@_{v=1}^{V}{\rm SIGReg}(\{\{{\bm{z}}_{n,v}\}_{n=1}^{B}\})\\
+\frac{1-\lambda}{B}\sumop\slimits@_{n=1}^{B}\mathcal{L}^{(V_{\rm g})}_{\rm pred}(\{{\bm{z}}_{n,v}\}_{v=1}^{V}).
$$

We present (9)’s implementation in LABEL:code:lejepa. Altogether, the entire implementation–besides the usual model definitions, optimizers, and data loaders–only takes a few dozens lines in PyTorch (LABEL:lst:epps-pulley-pytorch and LABEL:code:lejepa). The absence of prototypes, stop-gradients, and teacher-student networks makes (9) appealing as it only contains one hyperparameter, $\lambda$, balancing the trade-off between the prediction and isotropic Gaussian terms.

### 5.2  Relation to Prior Work

Prior to presenting our experiments (Section˜6), we conclude by discussing how our proposed LeJEPA and SIGReg objective relate to existing frameworks in the literature.

While there is no existing solution employing such slicing and distribution matching for JEPAs, there exists similar pipelines for generative models and optimal transport. Notably, the Sliced Score Matching (song2020sliced) proposes to leverage univariate slicing of the space to ease the estimation of a density for generative models. In a similar vein, the sliced Wasserstein distance (bonneel2015sliced; nguyen2023energy) uses such strategy to speed up and improve optimal transport. Furthermore, when the integral of the (Epps–Pulley) test is computed exactly, as opposed to our quadrature, each slice loss value recovers the kernel MMD (sriperumbudur2010hilbert; gretton2012kernel; chwialkowski2016kernel) measuring the distance between two distributions–albeit with a quadratic complexity. Lastly, it is possible to recover some existing SSL frameworks in the limit by employing LeJEPA with a particular test–instead of the preferred (Epps–Pulley). For example, Setting $T(\{x_{n}\}_{n=1}^{B})={\rm mean}(\{x_{n}\}_{n=1}^{B})^{2}+({\rm std}(\{x_{n}\}_{n=1}^{B})-1)^{2}$ and using that $T$ with SIGReg in LeJEPA recovers the VICReg SSL method in the limit of large number of slices. In fact, SIGReg will enforce in expectation that $\mathbb{E}[\mathbf{Z}]=\mathbf{0}$ and $\mathrm{Cov}(\mathbf{Z})=\mathbf{I}_{d}$, where $\mathbf{I}_{d}$ denotes the $d\times d$ identity matrix–derivations provided in Section˜B.14. And since our invariance term is simply the $\ell_{2}$ distance between the views’ embeddings, LeJEPA recovers VICReg for this degenerate statistical test. Based on Section˜4.2.1, we however strongly advocate against such a setting as it would lead to shortcut solutions–a phenomenon already observed in VICReg.

## 6  LeJEPA: Empirical Validation

We now use the LeJEPA implementation described in Section˜5.1 to demonstrate its effectiveness through comprehensive experiments. We show that LeJEPA: (i) trains reliably across diverse architectures and datasets (Section˜6.1), (ii) provides an informative training loss for model selection (Section˜6.2), (iii) outperforms frontier vision models on small-scale in-domain pretraining (Section˜6.3), (iv) scales successfully to nearly 1 billion parameters on ImageNet-1k (Section˜6.4), and (v) learns rich semantic segmentation features without explicit supervision.

### 6.1  LeJEPA’s Stability Across Hyper-Parameters and Architectures

We now demonstrate LeJEPA’s stability across hyperparameters, architectures, and experimental setups. Additional cross-domain stability results are presented in Section˜6.3.

![Refer to caption](https://arxiv.org/html/2511.08544v3/x7.png)

Figure 8: Inet100 with 400 pretraining epochs and resnet50 backbone. We depict linear probe performances as a function of λ \\lambda and the number of views V (recall ( 9 )). We observe that performances are stable over –with peak performance obtain by slightly adjust proportionally to the number of views. The corresponding performance values are provided in Table ˜ 7.

Table 1: ViT/Large-14, on inet1k pretraining for 100 epochs and evaluated with frozen backbone linear probing (top1 accuracy, %).LeJEPA’s performance is stable across all its hyperparameters and while some may slightly improve performance, e.g., the number of slices $|{\mathbb{A}}|$ and the projector sizes, none of the choices lead to a catastrophic collapse.

(a) (Epps–Pulley) parameters

<table><tbody><tr><td>integration</td><td>num_slices</td><td colspan="3">config/bstat_n_points</td></tr><tr><td></td><td></td><td>5</td><td>17</td><td>41</td></tr><tr><td><math><semantics><mrow><mo>[</mo><mrow><mo>−</mo> <mn>1</mn></mrow><mo>,</mo><mn>1</mn><mo>]</mo></mrow> <annotation>[-1,1]</annotation></semantics></math></td><td>512</td><td>71.82</td><td>72.13</td><td>72.04</td></tr><tr><td></td><td>2048</td><td>72.88</td><td>72.30</td><td>72.69</td></tr><tr><td><math><semantics><mrow><mo>[</mo><mrow><mo>−</mo> <mn>3</mn></mrow><mo>,</mo><mn>3</mn><mo>]</mo></mrow> <annotation>[-3,3]</annotation></semantics></math></td><td>512</td><td>73.95</td><td>74.16</td><td>74.04</td></tr><tr><td></td><td>2048</td><td>75.02</td><td>74.68</td><td>74.77</td></tr><tr><td><math><semantics><mrow><mo>[</mo><mrow><mo>−</mo> <mn>5</mn></mrow><mo>,</mo><mn>5</mn><mo>]</mo></mrow> <annotation>[-5,5]</annotation></semantics></math></td><td>512</td><td>73.71</td><td>74.21</td><td>74.15</td></tr><tr><td></td><td>2048</td><td>74.50</td><td>74.80</td><td>74.77</td></tr></tbody></table>

(b) Number of local/global views

| \# global\_views ($V_{\rm g}$) | 1 | 2 | 4 |
| --- | --- | --- | --- |
| \# views ($V=V_{\rm g}+V_{\rm l}$) |  |  |  |
| 4 | 53.06 | 72.26 | – |
| 6 | 58.65 | 73.07 | 73.68 |
| 8 | 64.46 | 74.24 | 73.94 |
| 10 | 68.97 | 74.06 | 75.08 |

(c) Mini-batch size

| batch\_size | 128 | 256 | 512 | 1024 |
| --- | --- | --- | --- | --- |
|  | 72.20 | 74.15 | 74.72 | 74.07 |

(d) Embedding/Projector dim.

<table><tbody><tr><td>num_slices</td><td colspan="2">1024</td><td colspan="2">4096</td></tr><tr><td>emb. dim.</td><td>512</td><td>2048</td><td>512</td><td>2048</td></tr><tr><td>proj. dim.</td><td></td><td></td><td></td><td></td></tr><tr><td>64</td><td>75.29</td><td>75.32</td><td>75.50</td><td>75.65</td></tr><tr><td>128</td><td>74.77</td><td>75.09</td><td>75.26</td><td>75.47</td></tr><tr><td>256</td><td>74.56</td><td>74.66</td><td>75.08</td><td>75.02</td></tr><tr><td>512</td><td>73.94</td><td>74.11</td><td>74.81</td><td>74.65</td></tr><tr><td>1024</td><td>73.65</td><td>73.94</td><td>74.71</td><td>74.79</td></tr></tbody></table>

| reg\_tokens | 0 | 1 | 2 | 4 | 8 |
| --- | --- | --- | --- | --- | --- |
| num\_slices |  |  |  |  |  |
| 1024 | 75.14 | 75.18 | 75.08 | 75.34 | 75.23 |
| 4096 | 75.61 | 75.58 | 75.67 | 75.63 | 75.84 |

![Refer to caption](https://arxiv.org/html/2511.08544v3/x8.png)

Figure 9: INet10 pretraining and frozen backbone linear evaluation across 50 timm models using LeJEPA out of the box. We cross-validate the learning rate and weight-decay. While there is a small variation between the best and worst performing model, we clearly see that across models spanning 8 families, LeJEPA is able to produce non-trivial representations able to solve the downstream task at SOTA levels.

Stability across standard hyperparameters. We begin by evaluating LeJEPA on ImageNet-100 and ImageNet-1K. On ImageNet-100, we train a ResNet-50 and vary the number of views and the loss weighting $\lambda$ (Figure˜8). Performance remains stable across both dimensions, leading us to recommend $\lambda=0.05$ as a robust default. On ImageNet-1K, we train a ViT-Large/14 and explore batch size, as well as the number of global ($V_{\rm g}$) and local ($V_{\rm l}$) views (Table˜1b). We find that the configuration commonly used in prior work ($V_{\rm g}=2,V_{\rm l}=8$) transfers well to LeJEPA. Notably, LeJEPA achieves competitive performance with batch sizes as small as 128 on ImageNet-1K (Table˜1c), suggesting reduced memory requirements compared to existing methods. We thus recommend to use $\lambda=0.05$, $V_{\rm g}=2$, $V_{\rm l}=8$, and batch size $\geq 128$ as starting points.

Stability across Epps-Pulley hyperparameters. We next examine hyperparameters specific to LeJEPA: the number of slices $|\mathcal{A}|$ in SIGReg, the integration domain for the Epps-Pulley test (Epps–Pulley), and the number of quadrature points for numerical integration. Table˜1a shows ablations on ImageNet-1K with ViT-Large/14. Both the integration domain and number of quadrature points have negligible impact on performance. This is expected: since the characteristic function is accurate at zero, the moments of the distribution are well-characterized even with a modest integration range. The number of slices $|\mathcal{A}|$ has a modest effect—while more slices slightly improve performance, even 512 slices yield competitive results. We thus recommend to use 17 integration points, an integration domain of $[-5,5]$, and 1024 slices as starting points.

Stability across architectures. A key advantage of LeJEPA over recent methods (e.g., IJEPA, DINOv2) is its architecture-agnostic design. While most modern self-supervised methods are tailored to Vision Transformers, LeJEPA works across diverse architecture families without modification. To validate this claim, we pretrain approximately 50 architectures from 8 different families on ImageNet-10, selecting all models in the timm library with fewer than 20M parameters. All models are able to learn high-quality representations reaching between 91.5% to 95% top 1 accuracy with frozen backbone linear probing. It seems that models performing well in supervised learning setups are also the ones to favor for LeJEPA, such as resnets and ViTs. We thus recommend to use standard architectures such as ResNets and ViTs over specialized models like EfficientNet as stating point.

Removal of popular heuristics. In addition to providing reliable performance across models and datasets, LeJEPA’s provable construction enables us to remove many heuristics traditionally used to prevent collapse. First, prior work has shown both empirically and theoretically that predictors in image JEPA (without asymmetric information) and teacher-student architectures serve primarily to prevent collapse (grill2020bootstrap; jing2021understanding; tian2021understanding; caron2021emerging; chen2021empirical). Removing these components produces collapsed encoders, i.e., with performances at chance-level. Thanks to LeJEPA’s SIGReg loss, we can remove both the predictor and teacher-student architecture without suffering from collapse, as shown in Table˜4. While a teacher-student configuration does provide a small performance boost for ViT models—consistent with observations in supervised learning via Stochastic Weight Averaging (izmailov2019averagingweightsleadswider) —it is not necessary to prevent collapse. In our setup, we apply SWA on the encoder producing $\mu$ in Equation˜7. Second, recent work demonstrated that register tokens are needed to prevent training instabilities in vision models (oquab2023dinov2; simeoni2025dinov3; darcet2023vision). We show in Table˜1 that such instabilities likely stem from poorly conditioned training objectives. In contrast, LeJEPA does not require register tokens and achieves stable performance with or without them. We thus recommend training without a predictor or register tokens, and optionally applying SWA with ViTs for a possible performance gain.

<svg height="8313.05" id="S6.SS1.p6.pic1" overflow="visible" version="1.1" viewBox="0 0 600 8313.05" width="600"><g fill="#000000" stroke="#000000" stroke-width="0.4pt" style="--ltx-stroke-color:#000000;--ltx-fill-color:#000000;" transform="translate(0,8313.05) matrix(1 0 0 -1 0 0)"><g fill="#592D00" fill-opacity="1.0" style="--ltx-fill-color:#592D00;"><path d="M 0 5.91 L 0 8307.15 C 0 8310.41 2.64 8313.05 5.91 8313.05 L 594.09 8313.05 C 597.36 8313.05 600 8310.41 600 8307.15 L 600 5.91 C 600 2.64 597.36 0 594.09 0 L 5.91 0 C 2.64 0 0 2.64 0 5.91 Z" style="stroke:none"></path></g><g fill="#FFF9F2" fill-opacity="1.0" style="--ltx-fill-color:#FFF9F2;"><path d="M 1.97 5.91 L 1.97 8294.05 L 598.03 8294.05 L 598.03 5.91 C 598.03 3.73 596.27 1.97 594.09 1.97 L 5.91 1.97 C 3.73 1.97 1.97 3.73 1.97 5.91 Z" style="stroke:none"></path></g><g fill-opacity="1.0" transform="matrix(1.0 0.0 0.0 1.0 9.26 8300.09)"><foreignObject color="#FFFFFF" height="12.3" overflow="visible" style="--ltx-fg-color:#FFFFFF;--fo_width :42.02em;--fo_height:0.69em;--fo_depth :0.19em;" transform="matrix(1 0 0 -1 0 9.61)" width="581.48"><span style="width:36.54em;">Experiment Details&nbsp;1</span> </foreignObject></g><g fill-opacity="1.0" transform="matrix(1.0 0.0 0.0 1.0 9.26 5071.63)"><foreignObject color="#000000" height="8277.5" overflow="visible" style="--ltx-fg-color:#000000;--fo_width :42.02em;--fo_height:232.21em;--fo_depth :366em;" transform="matrix(1 0 0 -1 0 3213.16)" width="581.48"><span style="width:45.43em;"><span style="font-size:90%;">We strive for simplicity and thus adopt a unified pretraining pipeline. The following parameters apply to all experiments and figures unless stated otherwise in the corresponding caption and come from Section˜6.1:</span> <span id="S6.I1"><span id="S6.I1.i1" style="list-style-type:none;">• <span id="S6.I1.i1.p1"><span style="font-size:90%;">LeJEPA’s implementation is given in</span> <span style="font-size:90%;">LABEL:code:lejepa</span> <span style="font-size:90%;">with hyperparameter</span> <math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="\lambda"><semantics><mi mathsize="0.900em">λ</mi> <annotation encoding="application/x-tex">\lambda</annotation></semantics></math> </span></span><span id="S6.I1.i2" style="list-style-type:none;">• <span id="S6.I1.i2.p1"><span style="font-size:90%;">All backbones are from</span> <math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="{\rm timm}"><semantics><mi mathsize="0.900em">timm</mi> <annotation encoding="application/x-tex">{\rm timm}</annotation></semantics></math> <span style="font-size:90%;">and all optimizers/schedulers are from</span> <math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="{\rm PyTorch}"><semantics><mi mathsize="0.900em">PyTorch</mi> <annotation encoding="application/x-tex">{\rm PyTorch}</annotation></semantics></math> <span style="font-size:90%;">without modifications</span> </span></span><span id="S6.I1.i3" style="list-style-type:none;">• <span id="S6.I1.i3.p1"><span style="font-size:90%;">We employ eight views (</span><math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="V=8"><semantics><mrow><mi mathsize="0.900em">V</mi> <mo mathsize="0.900em">=</mo> <mn mathsize="0.900em">8</mn></mrow> <annotation encoding="application/x-tex">V=8</annotation></semantics></math><span style="font-size:90%;">) containing two global views (</span><math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="V_{\rm g}=2"><semantics><mrow><msub><mi mathsize="0.900em">V</mi> <mi mathsize="0.900em" mathvariant="normal">g</mi></msub> <mo mathsize="0.900em">=</mo> <mn mathsize="0.900em">2</mn></mrow> <annotation encoding="application/x-tex">V_{\rm g}=2</annotation></semantics></math><span style="font-size:90%;">) with resolution 224x224 and 96x96 for the local views</span> </span></span><span id="S6.I1.i4" style="list-style-type:none;">• <span id="S6.I1.i4.p1"><span style="font-size:90%;">AdamW optimizer with</span> <math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="{\rm lr}\in\{5e-3,5e-4\}"><semantics><mrow><mi mathsize="0.900em">lr</mi> <mo mathsize="0.900em">∈</mo> <mrow><mo maxsize="0.900em" minsize="0.900em">{</mo> <mrow><mrow><mn mathsize="0.900em">5</mn> <mo lspace="0em" rspace="0em"></mo><mi mathsize="0.900em">e</mi></mrow> <mo mathsize="0.900em">−</mo> <mn mathsize="0.900em">3</mn></mrow><mo mathsize="0.900em">,</mo><mrow><mrow><mn mathsize="0.900em">5</mn> <mo lspace="0em" rspace="0em"></mo><mi mathsize="0.900em">e</mi></mrow> <mo mathsize="0.900em">−</mo> <mn mathsize="0.900em">4</mn></mrow> <mo maxsize="0.900em" minsize="0.900em">}</mo></mrow></mrow> <annotation encoding="application/x-tex">{\rm lr}\in\{5e-3,5e-4\}</annotation></semantics></math> <span style="font-size:90%;">and</span> <math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="{\rm wd}\in\{1e-1,1e-2,1e-5\}"><semantics><mrow><mi mathsize="0.900em">wd</mi> <mo mathsize="0.900em">∈</mo> <mrow><mo maxsize="0.900em" minsize="0.900em">{</mo> <mrow><mrow><mn mathsize="0.900em">1</mn> <mo lspace="0em" rspace="0em"></mo><mi mathsize="0.900em">e</mi></mrow> <mo mathsize="0.900em">−</mo> <mn mathsize="0.900em">1</mn></mrow><mo mathsize="0.900em">,</mo><mrow><mrow><mn mathsize="0.900em">1</mn> <mo lspace="0em" rspace="0em"></mo><mi mathsize="0.900em">e</mi></mrow> <mo mathsize="0.900em">−</mo> <mn mathsize="0.900em">2</mn></mrow><mo mathsize="0.900em">,</mo><mrow><mrow><mn mathsize="0.900em">1</mn> <mo lspace="0em" rspace="0em"></mo><mi mathsize="0.900em">e</mi></mrow> <mo mathsize="0.900em">−</mo> <mn mathsize="0.900em">5</mn></mrow> <mo maxsize="0.900em" minsize="0.900em">}</mo></mrow></mrow> <annotation encoding="application/x-tex">{\rm wd}\in\{1e-1,1e-2,1e-5\}</annotation></semantics></math> <span style="font-size:90%;">–no scheduler on weight-decay, standard linear warm-up cosine-annealing for</span> <math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="{\rm lr}"><semantics><mi mathsize="0.900em">lr</mi> <annotation encoding="application/x-tex">{\rm lr}</annotation></semantics></math></span></span></span></span></foreignObject></g></g></svg>

### 6.2  LeJEPA’s Training Loss is Informative of Downstream Performance

![Refer to caption](https://arxiv.org/html/2511.08544v3/x9.png)

Figure 10: (SIGReg, prediction loss) 2 d 2d -plane with downstream task accuracy shown with colors from blue (low) to red (high). We clearly observe that within this plane, there exists trade-off fronts between the two terms of LeJEPA producing similar downstream performance corresponding to different values of λ \\lambda. Yet, those fronts are linear and pointed towards the lower left corner, i.e., LeJEPA’s training loss informs of downstream test performance across models and datasets ( columns ). Additional models and datasets provided in Figure ˜ 21.

![Refer to caption](https://arxiv.org/html/2511.08544v3/x12.png)

Figure 11: Spearman correlation ( y-axis) between LeJEPA’s training loss and downstream accuracy on the dataset’s classification task with a frozen backbone and linear evaluation. The x-axis varies α \\alpha in Equation ˜ 10 following our scaling law of the loss w.r.t. λ \\lambda. Using = 0 \\alpha=0 recovers the plain training loss. We clearly observe a very high correlation already for, which further increases up to 99 % 99\\% for 0.4 \\alpha=0.4. The entire set of points is obtained across numerous hyper-parameters such as learning rate, weight decay, number of epochs, –demonstrating how LeJEPA’s training loss is strongly predictive of downstream performance which can be used for label-free cross-validation.

A major challenge in SSL pretraining is the lack of reliable signals conveying the quality of the learned representation. As a result, it is common to monitor a supervised downstream task performance, sometimes supplemented with unsupervised embedding statistics (agrawal2022alpha; garrido2023rankme; thilak2023lidar). This process is highly limiting since it requires labeled data that is costly and overly specialized. This is further exacerbated in the latest JEPA models where training losses exhibit low correlation with downstream performance–and may not even decrease monotonically during training.

In contrast, we find that LeJEPA’s training loss behaves much more favorably–providing us with a meaningful signal on model quality. First, we provide in Figure˜10, the 2D plane spanned by the SIGReg and prediction losses where a clear trend with downstream task accuracy can be observed. More strikingly, the combined training loss (9) with mixing coefficient $\lambda$ exhibits very high Spearman correlation (spearman1961proof), denoted as $\rho_{s}$, of about $85\%$ with downstream accuracy–which is considered a strong signal. This strong relationship holds across datasets and architectures. As a result, a lower LeJEPA training loss reliably indicates a better downstream performance.

We can further improve this correlation through a simple scaling law based upon the trade-off weighting hyperparameter $\lambda$

$$
\displaystyle C^{(\alpha)}=\rho_{s}\left(\frac{\text{train\_loss}}{\lambda^{\alpha}},\text{test\_accuracy}\right).
$$

By setting $\alpha\approx 0.4$, LeJEPA’s training loss is able to achieve nearly 99% correlation with downstream performance across multiple datasets and models. We depict the changes in $C^{(\alpha)}$ as a function of $\alpha$ on multiple datasets and models in Figure˜11, as well as the training LeJEPA loss against downstream performance in Figure˜19. The strong alignment between LeJEPA’s training loss and model quality enables label-free SSL model selection and cross-validation.

### 6.3  In-Domain LeJEPA Outperforms Frontier Model Transfer Learning

![Refer to caption](https://arxiv.org/html/2511.08544v3/x13.png)

Figure 12: Small architecture in-domain (Galaxy10) LeJEPA pretraining with linear probe evaluation using frozen backbone or full finetuning ( columns ) and with varying number of samples per class ( x-axis). We compare against state-of-the-art foundation models (DINOv2/v3, IJEPA) over 3 different random seeds. We observe that LeJEPA enables in-domain pretraining out of the box across architectures and able to outperform frontier foundation models. Corresponding numbers are provided in Table ˜.

Table 2: Few-shot classification accuracy (percentages) on 8 datasets spanning textures, objects, and fine-grained categories. Our LeJEPA achieves superior performance on fine-grained tasks (DTD, flowers102, food101) while requiring only 100 pretraining epochs compared to I-JEPA’s 300 epochs—a 3× reduction in training time and computational resources without sacrificing downstream task performance. This efficiency gain is particularly valuable for practical applications where training budget is limited. Bold indicates best performance within the IN-1K comparison group, all numbers are percentages.

<table><tbody><tr><td></td><td></td><td></td><td></td><td></td><td colspan="9">Dataset</td></tr><tr><td>shots</td><td>model</td><td>params</td><td>pretrain</td><td>epochs</td><td>DTD</td><td>aircr.</td><td>cars</td><td>cifar10</td><td>cifar100</td><td>flowers102</td><td>food</td><td>pets</td><td>avg.</td></tr><tr><td rowspan="5">1</td><td>LeJEPA ViT-L</td><td>304M</td><td>IN-1K</td><td>100</td><td>33.21</td><td>9.37</td><td>3.40</td><td>51.65</td><td>27.01</td><td>48.53</td><td>17.14</td><td>46.11</td><td>29.55</td></tr><tr><td>LeJEPA ConvNeXtV2-H</td><td>660M</td><td>IN-1K</td><td>100</td><td>32.15</td><td>8.07</td><td>4.28</td><td>50.95</td><td>31.48</td><td>48.74</td><td>17.95</td><td>58.98</td><td>31.58</td></tr><tr><td>I-JEPA ViT-H</td><td>632M</td><td>IN-1K</td><td>300</td><td>27.71</td><td>9.86</td><td>4.33</td><td>56.52</td><td>30.58</td><td>44.69</td><td>14.53</td><td>53.38</td><td>30.20</td></tr><tr><td>I-JEPA ViT-H + STOP</td><td>632M</td><td>IN-1K</td><td>300</td><td>26.60</td><td>11.18</td><td>4.75</td><td>56.27</td><td>35.20</td><td>47.17</td><td>15.75</td><td>59.47</td><td>32.05</td></tr><tr><td>I-JEPA ViT-H (22K)</td><td>632M</td><td>IN-22K</td><td>900</td><td>27.98</td><td>13.00</td><td>3.45</td><td>61.84</td><td>34.70</td><td>89.72</td><td>19.62</td><td>30.86</td><td>35.15</td></tr><tr><td rowspan="5">10</td><td>LeJEPA ViT-L</td><td>304M</td><td>IN-1K</td><td>100</td><td>64.72</td><td>35.25</td><td>22.25</td><td>85.15</td><td>59.77</td><td>92.53</td><td>50.90</td><td>77.00</td><td>60.95</td></tr><tr><td>LeJEPA ConvNeXtV2-H</td><td>660M</td><td>IN-1K</td><td>100</td><td>61.84</td><td>30.67</td><td>24.46</td><td>85.74</td><td>63.29</td><td>91.78</td><td>49.32</td><td>78.53</td><td>60.70</td></tr><tr><td>I-JEPA ViT-H</td><td>632M</td><td>IN-1K</td><td>300</td><td>57.68</td><td>33.82</td><td>21.96</td><td>88.77</td><td>66.42</td><td>88.24</td><td>43.97</td><td>83.23</td><td>60.51</td></tr><tr><td>I-JEPA ViT-H + STOP</td><td>632M</td><td>IN-1K</td><td>300</td><td>57.00</td><td>39.77</td><td>25.21</td><td>90.09</td><td>70.32</td><td>90.16</td><td>45.68</td><td>85.13</td><td>62.92</td></tr><tr><td>I-JEPA ViT-H (22K)</td><td>632M</td><td>IN-22K</td><td>900</td><td>58.74</td><td>43.52</td><td>18.27</td><td>94.83</td><td>75.23</td><td>98.94</td><td>49.06</td><td>67.66</td><td>63.28</td></tr><tr><td rowspan="5">all</td><td>LeJEPA ViT-L</td><td>304M</td><td>IN-1K</td><td>100</td><td>78.30</td><td>57.01</td><td>57.28</td><td>96.50</td><td>83.71</td><td>91.21</td><td>82.05</td><td>89.74</td><td>79.48</td></tr><tr><td>LeJEPA ConvNeXtV2-H</td><td>660M</td><td>IN-1K</td><td>100</td><td>76.60</td><td>52.99</td><td>54.88</td><td>96.15</td><td>81.34</td><td>91.11</td><td>77.64</td><td>89.76</td><td>77.56</td></tr><tr><td>I-JEPA ViT-H</td><td>632M</td><td>IN-1K</td><td>300</td><td>73.32</td><td>56.61</td><td>54.47</td><td>97.54</td><td>86.42</td><td>86.47</td><td>81.02</td><td>92.11</td><td>78.50</td></tr><tr><td>I-JEPA ViT-H + STOP</td><td>632M</td><td>IN-1K</td><td>300</td><td>73.87</td><td>61.95</td><td>61.27</td><td>98.02</td><td>87.78</td><td>88.08</td><td>81.72</td><td>92.88</td><td>80.70</td></tr><tr><td>I-JEPA ViT-H (22K)</td><td>632M</td><td>IN-22K</td><td>900</td><td>75.67</td><td>65.39</td><td>49.79</td><td>98.46</td><td>89.95</td><td>98.54</td><td>81.58</td><td>87.19</td><td>80.82</td></tr></tbody></table>

![Refer to caption](https://arxiv.org/html/2511.08544v3/toy_figures/videos/dog_video.png)

Figure 13: Emergent Object Segmentation via Last Layer Thresholding. LeJEPA naturally learns to segment and track salient objects (shown in attention maps on the right of each video) without explicit supervision. The results display impressive visual quality and strong temporal consistency across video frames ( videos provided on our project page ). This emergent capability demonstrates the rich semantic representations learned through our self-supervised approach.

![Refer to caption](https://arxiv.org/html/2511.08544v3/toy_figures/pca/n01818515_5551_original.png)

Figure 14: LeJEPA learns rich semantic representations through self-supervised learning. PCA visualization of last-layer features from LeJEPA (ViT-Large, 100 epochs on ImageNet-1K). For each image, features are independently projected to RGB using the first 3 principal components. Without any supervision, LeJEPA spontaneously develops semantically meaningful representations: notice how warm colors (red/magenta/pink) consistently capture foreground objects (parrot bodies, dog face), while cool colors (cyan/green/yellow) represent backgrounds and foliage. This emergent object-background separation and perceptual grouping discovered the visual structure of the world purely from unlabeled data.

A key promise of self-supervised learning is to learn universal representations that generalize across tasks and domains. However, current frontier foundation models (e.g., DINOv2/v3, IJEPA) are pretrained on natural images forcing practitioners in specialized domains to collect large amount of labels for supervised finetuning. In fact, most frontier models can not be trained directly on those domains as the number of samples may be small and searching again for the hyper-parameters would be cumbersome yet necessary (assran2022hidden).

To demonstrate LeJEPA’s versatility and ability to resolve that current pain-point, we propose to pretrain directly on a new domain without any change in the loss or the pretraining pipeline. We select the Galaxy10 dataset, a galaxy morphology classification task that differs significantly from natural images in both visual structure and statistical properties (balestriero2025gaussian). The dataset contains 11,000 training samples across 10 galaxy types. For LeJEPA, we use the default hyper-parameters and pretrain for 400 epochs a variety of backbones. We compare against the latest DINOv2, DINOv3 and IJEPA. We report in Figure˜12 the top1 accuracy for linear probing both with frozen backbone and full-finetuning. We observe that in-domain pretraining with LeJEPA substantially outperforms state-of-the-art frontier models (DINOv2, DINOv3) on both linear probing and full finetuning. Additional datasets and backbones are provided in Table˜5 depicting LeJEPA’s ability to train in-domain, even with a dataset with $1000$ samples (flowers102). Coupling this result with the stability of LeJEPA across architectures and hyper-parameters should offer a promising alternatives in domains not yet accounted for by the latest frontier models.

### 6.4  LeJEPA Scales Across Data and Models

We now propose to apply LeJEPA over a larger pretraining dataset, i.e., Imagenet-1k, and over larger backbones such as ViT/Large (0.3B), ConvNextV2-Huge (0.6B). For those two models, we reach an online linear probe accuracy on inet1k of 77.1% and 78.5% respectively. Beyond in-distribution performances, we also explore transfer learning. For those experiments, our baselines are IJEPA with a ViT-Huge (0.6B) which is the closest to our setup, and we also include a recent improved version of IJEPA including additional stochastic prediction tasks (bar2023stochastic) that is coined IJEPA + STOP. For LeJEPA, we employ the same recipe as described in Section˜6.1 and report transfer learning performances with frozen backbone in Table˜2. We observe that we consistently outperform IJEPA while employed a smaller model and shorted training schedule. Beyond top1 accuracy, we also echo our findings from Section˜6.2 about LeJEPA’s training loss quality. In our setup, we observe a very stable and smooth training curve indicating a stable optimization landscape removing the need for careful hyperparameter selection (recall Section˜4.2.3). We provide an example on a ViT-gigantic (1.8B parameters) in Figure˜2.

### 6.5  Emergent Semantic Structure in LeJEPA Representations

A hallmark of successful self-supervised learning is the emergence of semantically meaningful attention patterns without explicit supervision (caron2021emerging). To assess whether LeJEPA learns such structure, we visualize the attention maps of the learned representations. Following DINO (caron2021emerging), we apply PCA to the embeddings and visualize the first principal components, which reveal clear correspondence to object boundaries and salient regions (Figure˜14). Furthermore, we explore whether these attention patterns can enable unsupervised video segmentation—a challenging task requiring temporal consistency and object understanding. By thresholding the self-attention maps of the \[CLS\] token, we obtain binary masks that track objects across frames without any segmentation labels during training. As shown in Figure˜13, LeJEPA’s attention naturally segments foreground objects from background with remarkable temporal coherence, suggesting that the learned representations capture both spatial semantics and temporal structure. This emergent capability demonstrates that LeJEPA’s stability-focused objective does not sacrifice the semantic richness of learned features.

## 7  Conclusion

We have established a principled theoretical framework for JEPA-based self-supervised learning that fundamentally resolves its core pathologies. Our contributions span theory and practice: we proved that isotropic Gaussian embeddings uniquely minimize worst-case downstream risk, introduced SIGReg as a tractable and provably correct method to enforce this distribution, and demonstrated that this approach eliminates representational collapse by design–and not through ad-hoc combinations of teacher-student networks, stop-gradients, or asymmetric architectures.

We validate LeJEPA across domains and over $60$ architectures including gigantic versions with 1.8B parameters. In spite of its simplicify, LeJEPA matches state-of-the-art performance while requiring fewer than 50 lines of core implementation. Critically, our approach provides what SSL has long needed: a mathematically rigorous foundation that directly informs practical algorithm design.

## Acknowledgments

We would like to thank Mike Rabbat and Lucas Maes for providing valuable feedbacks on the manuscript.

LeJEPA  
Appendix  

## Appendix A Additional Details on Nonlinear Probing

### A.1  kNN Probing

To allow for more flexible evaluation of the pretrained encoder $f_{{\bm{\theta}}}$, it is standard to work with a $k$ -NN prober \[taunk2019brief\], both for regression and classification. We rely on the radial $k$ -NN variation that leverages a sample-dependent $k$ –improving performance for non uniform distributions of samples \[sun2010adaptive, zhang2017efficient, abu2019effects\].

We denote the underlying embedding density as $p_{z}\in C^{3}$ with derivatives of order up to $3$ bounded, and finite Fisher information and covariance. This regularity condition is fulfilled by current encoders. The unknown labels come from the target function $\eta:\mathbb{R}^{K}\to\mathbb{R}$, assumed $C^{2}$. We handle classification tasks by setting $\eta({\bm{z}})=\mathbb{P}(Y=1\mid{\bm{z}})$. The training consists of the $N$ embeddings along with their training labels $\{({\bm{z}}_{n},\eta({\bm{z}}_{n}))\}_{n=1}^{N}$, where we will denote ${\bm{y}}_{n}\triangleq\eta({\bm{z}}_{n})$. The prediction for a query vector ${\bm{q}}$ is formed as

$$
\displaystyle\mathaccent 866{{\bm{y}}}({\bm{q}}):=\frac{1}{{\bm{y}}({\bm{q}})}\sumop\slimits@_{n:\left\lVert{\bm{z}}_{n}-{\bm{q}}\right\rVert\leq r_{0}}{\bm{y}}_{n},
$$

with ${\bm{y}}({\bm{q}})\triangleq\#\{n:\left\lVert{\bm{z}}_{n}-{\bm{q}}\right\rVert\leq r_{0}\}$ counting the number of samples within a $r$ -radius ball around ${\bm{q}}$. The radius $r$ controls how many neighbors predictions are averaged to form the query’s prediction. As per the linear probing’s Section˜3.1, we can characterize the bias of the estimator Equation˜kNN at a particular query point, as formalized below.

<svg height="102.33" id="A1.SS1.p3.pic1" overflow="visible" version="1.1" viewBox="0 0 600 102.33" width="600"><g fill="#000000" stroke="#000000" stroke-width="0.4pt" style="--ltx-stroke-color:#000000;--ltx-fill-color:#000000;" transform="translate(0,102.33) matrix(1 0 0 -1 0 0)"><g fill="#000059" fill-opacity="1.0" style="--ltx-fill-color:#000059;"><path d="M 0 5.91 L 0 96.43 C 0 99.69 2.64 102.33 5.91 102.33 L 594.09 102.33 C 597.36 102.33 600 99.69 600 96.43 L 600 5.91 C 600 2.64 597.36 0 594.09 0 L 5.91 0 C 2.64 0 0 2.64 0 5.91 Z" style="stroke:none"></path></g><g fill="#F7F7FF" fill-opacity="1.0" style="--ltx-fill-color:#F7F7FF;"><path d="M 1.97 5.91 L 1.97 86.02 L 598.03 86.02 L 598.03 5.91 C 598.03 3.73 596.27 1.97 594.09 1.97 L 5.91 1.97 C 3.73 1.97 1.97 3.73 1.97 5.91 Z" style="stroke:none"></path></g><g fill-opacity="1.0" transform="matrix(1.0 0.0 0.0 1.0 9.26 89.37)"><foreignObject color="#FFFFFF" height="9.61" overflow="visible" style="--ltx-fg-color:#FFFFFF;--fo_width :42.02em;--fo_height:0.69em;--fo_depth :0em;" transform="matrix(1 0 0 -1 0 9.61)" width="581.48"><span style="width:36.54em;"><span id="A1.SS1.p3.pic1.p1">Lemma&nbsp;4:&nbsp;k-NN Pointwise Bias</span> </span></foreignObject></g><g fill-opacity="1.0" transform="matrix(1.0 0.0 0.0 1.0 9.26 10.4)"><foreignObject color="#000000" height="69.47" overflow="visible" style="--ltx-fg-color:#000000;--fo_width :42.02em;--fo_height:4.8em;--fo_depth :0.22em;" transform="matrix(1 0 0 -1 0 66.36)" width="581.48"><span style="width:45.43em;"><span style="font-size:90%;">The (kNN) estimator has bias at query <math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="{\bm{q}}"><semantics><mi>𝒒</mi> <annotation encoding="application/x-tex">{\bm{q}}</annotation></semantics></math> given by</span> <math xmlns="http://www.w3.org/1998/Math/MathML" display="block" data-latex="\mathrm{Bias}({\bm{q}})=\frac{r_{0}^{2}}{d+2}\Big(\nabla\eta({\bm{q}})^{\top}\nabla\log p_{z}({\bm{q}})+\tfrac{1}{2}\Delta\eta({\bm{z}})\Big)\\
+o(r_{0}^{2}),"><semantics><mtable displaystyle="true" rowspacing="0pt"><mtr><mtd columnalign="left"><mrow><mrow><mi mathsize="0.900em">Bias</mi> <mo lspace="0em" rspace="0em"></mo><mrow><mo maxsize="0.900em" minsize="0.900em">(</mo><mi mathsize="0.900em">𝒒</mi><mo maxsize="0.900em" minsize="0.900em">)</mo></mrow></mrow> <mo mathsize="0.900em">=</mo> <mrow><mfrac><msubsup><mi mathsize="0.900em">r</mi> <mn mathsize="0.900em">0</mn> <mn mathsize="0.900em">2</mn></msubsup> <mrow><mi mathsize="0.900em">d</mi> <mo mathsize="0.900em">+</mo> <mn mathsize="0.900em">2</mn></mrow></mfrac> <mo lspace="0em" rspace="0em"></mo><mrow><mo maxsize="1.600em" minsize="1.600em">(</mo><mrow><mrow><mrow><mo mathsize="0.900em" rspace="0.167em">∇</mo> <mi mathsize="0.900em">η</mi></mrow> <mo lspace="0em" rspace="0em"></mo><msup><mrow><mo maxsize="0.900em" minsize="0.900em">(</mo><mi mathsize="0.900em">𝒒</mi><mo maxsize="0.900em" minsize="0.900em">)</mo></mrow> <mo mathsize="0.900em">⊤</mo></msup> <mo lspace="0.167em" rspace="0em"></mo><mrow><mrow><mo mathsize="0.900em" rspace="0.167em">∇</mo> <mi mathsize="0.900em">log</mi></mrow> <mo lspace="0.167em">⁡</mo> <msub><mi mathsize="0.900em">p</mi> <mi mathsize="0.900em">z</mi></msub></mrow> <mo lspace="0em" rspace="0em"></mo><mrow><mo maxsize="0.900em" minsize="0.900em">(</mo><mi mathsize="0.900em">𝒒</mi><mo maxsize="0.900em" minsize="0.900em">)</mo></mrow></mrow> <mo mathsize="0.900em">+</mo> <mrow><mstyle displaystyle="false"><mfrac><mn mathsize="0.900em">1</mn> <mn mathsize="0.900em">2</mn></mfrac></mstyle> <mo lspace="0em" rspace="0em"></mo><mi mathsize="0.900em">η</mi> <mo lspace="0em" rspace="0em"></mo><mrow><mo maxsize="0.900em" minsize="0.900em">(</mo><mi mathsize="0.900em">𝒛</mi><mo maxsize="0.900em" minsize="0.900em">)</mo></mrow></mrow></mrow><mo maxsize="1.600em" minsize="1.600em">)</mo></mrow></mrow></mrow></mtd></mtr> <mtr><mtd columnalign="right"><mrow><mrow><mo mathsize="0.900em">+</mo> <mrow><mi mathsize="0.900em">o</mi> <mo lspace="0em" rspace="0em"></mo><mrow><mo maxsize="0.900em" minsize="0.900em">(</mo><msubsup><mi mathsize="0.900em">r</mi> <mn mathsize="0.900em">0</mn> <mn mathsize="0.900em">2</mn></msubsup><mo maxsize="0.900em" minsize="0.900em">)</mo></mrow></mrow></mrow><mo mathsize="0.900em">,</mo></mrow></mtd></mtr></mtable><annotation encoding="application/x-tex">\mathrm{Bias}({\bm{q}})=\frac{r_{0}^{2}}{d+2}\Big(\nabla\eta({\bm{q}})^{\top}\nabla\log p_{z}({\bm{q}})+\tfrac{1}{2}\Delta\eta({\bm{z}})\Big)\\ +o(r_{0}^{2}),</annotation></semantics></math> <span style="font-size:90%;">where the remainder <math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="o(r_{0}^{2})"><semantics><mrow><mi>o</mi> <mo lspace="0em" rspace="0em"></mo><mrow><mo stretchy="false">(</mo><msubsup><mi>r</mi> <mn>0</mn> <mn>2</mn></msubsup><mo stretchy="false">)</mo></mrow></mrow> <annotation encoding="application/x-tex">o(r_{0}^{2})</annotation></semantics></math> is uniform in <math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="{\bm{q}}"><semantics><mi>𝒒</mi> <annotation encoding="application/x-tex">{\bm{q}}</annotation></semantics></math>. (Proof in Section˜B.3.)</span></span></foreignObject></g></g></svg>

To obtain the integrated bias, i.e., over the distribution of query points, we consider the following two properties. First, the distribution of query points follow the training distribution, i.e., ${\bm{q}}\sim p_{z}$, second, target function $\eta$ has gradient which is mean-zero and isotropic with $\mathbb{E}\big[\nabla\eta({\bm{z}})\nabla\eta({\bm{z}})^{\top}\big]=\tau_{g}^{2}I_{d}$ with $\tau_{g}^{2}\in(0,\infty)$ uniformly in ${\bm{z}}$. We also have any finite scalar-constraint on the covariance of the embeddings such as $\operatorname{Tr}(\Sigma)=c$ or $\|\Sigma\|_{F}=c$ for a finite constant $c$.

<svg height="815.68" id="A1.SS1.p5.pic1" overflow="visible" version="1.1" viewBox="0 0 600 815.68" width="600"><g fill="#000000" stroke="#000000" stroke-width="0.4pt" style="--ltx-stroke-color:#000000;--ltx-fill-color:#000000;" transform="translate(0,815.68) matrix(1 0 0 -1 0 0)"><g fill="#590000" fill-opacity="1.0" style="--ltx-fill-color:#590000;"><path d="M 0 5.91 L 0 809.78 C 0 813.04 2.64 815.68 5.91 815.68 L 594.09 815.68 C 597.36 815.68 600 813.04 600 809.78 L 600 5.91 C 600 2.64 597.36 0 594.09 0 L 5.91 0 C 2.64 0 0 2.64 0 5.91 Z" style="stroke:none"></path></g><g fill="#FFF2F2" fill-opacity="1.0" style="--ltx-fill-color:#FFF2F2;"><path d="M 1.97 5.91 L 1.97 796.68 L 598.03 796.68 L 598.03 5.91 C 598.03 3.73 596.27 1.97 594.09 1.97 L 5.91 1.97 C 3.73 1.97 1.97 3.73 1.97 5.91 Z" style="stroke:none"></path></g><g fill-opacity="1.0" transform="matrix(1.0 0.0 0.0 1.0 9.26 802.72)"><foreignObject color="#FFFFFF" height="12.3" overflow="visible" style="--ltx-fg-color:#FFFFFF;--fo_width :42.02em;--fo_height:0.69em;--fo_depth :0.19em;" transform="matrix(1 0 0 -1 0 9.61)" width="581.48"><span style="width:36.54em;"><span id="A1.SS1.p5.pic1.p1">Theorem&nbsp;7:&nbsp;k-NN isotropic Gaussian Optimality</span> </span></foreignObject></g><g fill-opacity="1.0" transform="matrix(1.0 0.0 0.0 1.0 9.26 10.4)"><foreignObject color="#000000" height="780.13" overflow="visible" style="--ltx-fg-color:#000000;--fo_width :42.02em;--fo_height:56.15em;--fo_depth :0.22em;" transform="matrix(1 0 0 -1 0 777.02)" width="581.48"><span style="width:45.43em;"><span style="font-size:90%;">The integrated squared bias of (kNN) satisfies</span> <span id="A1.Ex22"><math xmlns="http://www.w3.org/1998/Math/MathML" display="block" data-latex="\mathbb{E}_{{\bm{z}}}\big[\mathrm{Bias}({\bm{z}})^{2}\big]=\frac{r_{0}^{4}}{(K+2)^{2}}\tau_{g}^{2}J(p)\\
+O(r_{0}^{4}),"><semantics><mrow><mrow><mrow><msub><mi mathsize="0.900em">E</mi> <mi mathsize="0.900em">𝒛</mi></msub> <mo lspace="0em" rspace="0em"></mo><mrow><mo maxsize="1.200em" minsize="1.200em">[</mo><mrow><mi mathsize="0.900em">Bias</mi> <mo lspace="0em" rspace="0em"></mo><msup><mrow><mo maxsize="0.900em" minsize="0.900em">(</mo><mi mathsize="0.900em">𝒛</mi><mo maxsize="0.900em" minsize="0.900em">)</mo></mrow> <mn mathsize="0.900em">2</mn></msup></mrow><mo maxsize="1.200em" minsize="1.200em">]</mo></mrow></mrow> <mo mathsize="0.900em">=</mo> <mrow><mrow><mfrac><msubsup><mi mathsize="0.900em">r</mi> <mn mathsize="0.900em">0</mn> <mn mathsize="0.900em">4</mn></msubsup> <msup><mrow><mo maxsize="0.900em" minsize="0.900em">(</mo><mrow><mi mathsize="0.900em">K</mi> <mo mathsize="0.900em">+</mo> <mn mathsize="0.900em">2</mn></mrow><mo maxsize="0.900em" minsize="0.900em">)</mo></mrow> <mn mathsize="0.900em">2</mn></msup></mfrac> <mo lspace="0em" rspace="0em"></mo><msubsup><mi mathsize="0.900em">τ</mi> <mi mathsize="0.900em">g</mi> <mn mathsize="0.900em">2</mn></msubsup> <mo lspace="0em" rspace="0em"></mo><mi mathsize="0.900em">J</mi> <mo lspace="0em" rspace="0em"></mo><mrow><mo maxsize="0.900em" minsize="0.900em">(</mo><mi mathsize="0.900em">p</mi><mo maxsize="0.900em" minsize="0.900em">)</mo></mrow></mrow> <mo mathsize="0.900em">+</mo> <mrow><mi mathsize="0.900em">O</mi> <mo lspace="0em" rspace="0em"></mo><mrow><mo maxsize="0.900em" minsize="0.900em">(</mo><msubsup><mi mathsize="0.900em">r</mi> <mn mathsize="0.900em">0</mn> <mn mathsize="0.900em">4</mn></msubsup><mo maxsize="0.900em" minsize="0.900em">)</mo></mrow></mrow></mrow></mrow><mo mathsize="0.900em">,</mo></mrow><annotation encoding="application/x-tex">\mathbb{E}_{{\bm{z}}}\big[\mathrm{Bias}({\bm{z}})^{2}\big]=\frac{r_{0}^{4}}{(K+2)^{2}}\tau_{g}^{2}J(p)\\ +O(r_{0}^{4}),</annotation></semantics></math></span> <span style="font-size:90%;">and the isotropic Gaussian is the unique minimizer of the integrated square bias. (Proof in Section˜B.4.)</span></span></foreignObject></g></g></svg>

As a result, we now have a unique minimizer for the optimal embedding density for both the linear and k-NN probes.

### A.2  Kernel Probing

As an alternative to (kNN), it is also common to leverage kernel methods, which we consider in this section.

Consider a kernel $K:\mathbb{R}^{K}\to\mathbb{R}$ with the following standard properties

$$
\displaystyle\intslop\ilimits@_{\mathbb{R}^{d}}K(u)du=1,
$$
$$
\displaystyle\intslop\ilimits@_{\mathbb{R}^{d}}uK(u)du=0,
$$
$$
\displaystyle\intslop\ilimits@_{\mathbb{R}^{d}}uu^{\top}K(u)du=\mu_{2}(K)I_{d},
$$
$$
\displaystyle R(K)\triangleq\intslop\ilimits@_{\mathbb{R}^{d}}K(u)^{2}du<\infty,
$$

for some $\mu_{2}(K)\in(0,\infty)$, some bandwidth $h>0$ and denoting $K_{h}(t)\triangleq h^{-d}K(t/h)$, we remind the reader that the Nadaraya-Watson estimator, introduced in nadaraya1964estimating, watson1964smooth, at a query ${\bm{q}}\in\mathbb{R}^{d}$ is

$$
\displaystyle\mathaccent 866{{\bm{y}}}({\bm{q}})\triangleq\frac{\sumop\slimits@_{n=1}^{N}K_{h}({\bm{q}}-{\bm{x}}_{n}){\bm{y}}_{n}}{\sumop\slimits@_{n=1}^{N}K_{h}({\bm{q}}-{\bm{x}}_{n})}.
$$

Similarly to (kNN), we will see that the performance of (NW) depends crucially on the distribution of the training points. We have access to our dataset of inputs from $p_{z}$ and for each sample ${\bm{z}}_{n}$ the corresponding target is given from $\eta({\bm{z}}_{n})=\mathbb{E}[Y_{n}\mid{\bm{z}}_{n}]$. We also denote the corresponding conditional variance of the target function at that point as $v(x)=\mathrm{Var}(Y_{i}\mid X_{i}=x)$. We follow the regularity conditions of the k-NN probing derivations and additionally assume that $p$ has sufficiently light tails so that for each coordinate $j$, $\lim_{\|x\|\to\infty}p(x)=0$ and $\lim_{\|x\|\to\infty}x_{j}p(x)=0$. We first derive the pointwise bias and variance for $\mathaccent 866{{\bm{y}}}({\bm{q}})$.

<svg height="127.62" id="A1.SS2.p3.pic1" overflow="visible" version="1.1" viewBox="0 0 600 127.62" width="600"><g fill="#000000" stroke="#000000" stroke-width="0.4pt" style="--ltx-stroke-color:#000000;--ltx-fill-color:#000000;" transform="translate(0,127.62) matrix(1 0 0 -1 0 0)"><g fill="#000059" fill-opacity="1.0" style="--ltx-fill-color:#000059;"><path d="M 0 5.91 L 0 121.71 C 0 124.97 2.64 127.62 5.91 127.62 L 594.09 127.62 C 597.36 127.62 600 124.97 600 121.71 L 600 5.91 C 600 2.64 597.36 0 594.09 0 L 5.91 0 C 2.64 0 0 2.64 0 5.91 Z" style="stroke:none"></path></g><g fill="#F7F7FF" fill-opacity="1.0" style="--ltx-fill-color:#F7F7FF;"><path d="M 1.97 5.91 L 1.97 111.3 L 598.03 111.3 L 598.03 5.91 C 598.03 3.73 596.27 1.97 594.09 1.97 L 5.91 1.97 C 3.73 1.97 1.97 3.73 1.97 5.91 Z" style="stroke:none"></path></g><g fill-opacity="1.0" transform="matrix(1.0 0.0 0.0 1.0 9.26 114.66)"><foreignObject color="#FFFFFF" height="9.61" overflow="visible" style="--ltx-fg-color:#FFFFFF;--fo_width :42.02em;--fo_height:0.69em;--fo_depth :0em;" transform="matrix(1 0 0 -1 0 9.61)" width="581.48"><span style="width:36.54em;"><span id="A1.SS2.p3.pic1.p1">Lemma&nbsp;5:&nbsp;Kernel Bias and Variance</span> </span></foreignObject></g><g fill-opacity="1.0" transform="matrix(1.0 0.0 0.0 1.0 9.26 10.4)"><foreignObject color="#000000" height="94.76" overflow="visible" style="--ltx-fg-color:#000000;--fo_width :42.02em;--fo_height:6.62em;--fo_depth :0.22em;" transform="matrix(1 0 0 -1 0 91.64)" width="581.48"><span style="width:45.43em;"><span style="font-size:90%;">For any fixed <math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="{\bm{q}}\in\mathbb{R}^{d}"><semantics><mrow><mi>𝒒</mi> <mo>∈</mo> <msup><mi>R</mi> <mi>d</mi></msup></mrow> <annotation encoding="application/x-tex">{\bm{q}}\in\mathbb{R}^{d}</annotation></semantics></math> with <math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="p({\bm{q}})&gt;0"><semantics><mrow><mrow><mi>p</mi> <mo lspace="0em" rspace="0em"></mo><mrow><mo stretchy="false">(</mo><mi>𝒒</mi><mo stretchy="false">)</mo></mrow></mrow> <mo>&gt;</mo> <mn>0</mn></mrow> <annotation encoding="application/x-tex">p({\bm{q}})&gt;0</annotation></semantics></math>, as <math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="h\to 0"><semantics><mrow><mi>h</mi> <mo stretchy="false">→</mo> <mn>0</mn></mrow> <annotation encoding="application/x-tex">h\to 0</annotation></semantics></math> and <math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="nh^{d}\to\infty"><semantics><mrow><mrow><mi>n</mi> <mo lspace="0em" rspace="0em"></mo><msup><mi>h</mi> <mi>d</mi></msup></mrow> <mo stretchy="false">→</mo> <mi mathvariant="normal">∞</mi></mrow> <annotation encoding="application/x-tex">nh^{d}\to\infty</annotation></semantics></math>,</span> <span id="A6.EGx17"><span id="A1.Ex28"><math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="\displaystyle\mathrm{Bias}\big[\mathaccent 866{{\bm{y}}}({\bm{q}})\big]"><semantics><mrow><mi mathsize="0.900em">Bias</mi> <mo lspace="0em" rspace="0em"></mo><mrow><mo maxsize="1.200em" minsize="1.200em">[</mo><mrow><mover accent="true"><mi mathsize="0.900em">𝒚</mi> <mo mathsize="0.900em">^</mo></mover> <mo lspace="0em" rspace="0em"></mo><mrow><mo maxsize="0.900em" minsize="0.900em">(</mo><mi mathsize="0.900em">𝒒</mi><mo maxsize="0.900em" minsize="0.900em">)</mo></mrow></mrow><mo maxsize="1.200em" minsize="1.200em">]</mo></mrow></mrow> <annotation encoding="application/x-tex">\displaystyle\mathrm{Bias}\big[\mathaccent 866{{\bm{y}}}({\bm{q}})\big]</annotation></semantics></math> <math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="\displaystyle=\frac{h^{2}\mu_{2}(K)}{2}\Big(\Delta{\bm{y}}({\bm{q}})+2\nabla{\bm{y}}({\bm{q}})^{\top}\nabla\log p({\bm{q}})\Big)+o(h^{2}),"><semantics><mrow><mrow><mo mathsize="0.900em">=</mo> <mrow><mrow><mstyle displaystyle="true"><mfrac><mrow><msup><mi mathsize="0.900em">h</mi> <mn mathsize="0.900em">2</mn></msup> <mo lspace="0em" rspace="0em"></mo><msub><mi mathsize="0.900em">μ</mi> <mn mathsize="0.900em">2</mn></msub> <mo lspace="0em" rspace="0em"></mo><mrow><mo maxsize="0.900em" minsize="0.900em">(</mo><mi mathsize="0.900em">K</mi><mo maxsize="0.900em" minsize="0.900em">)</mo></mrow></mrow> <mn mathsize="0.900em">2</mn></mfrac></mstyle> <mo lspace="0em" rspace="0em"></mo><mrow><mo maxsize="1.600em" minsize="1.600em">(</mo><mrow><mrow><mi mathsize="0.900em">𝒚</mi> <mo lspace="0em" rspace="0em"></mo><mrow><mo maxsize="0.900em" minsize="0.900em">(</mo><mi mathsize="0.900em">𝒒</mi><mo maxsize="0.900em" minsize="0.900em">)</mo></mrow></mrow> <mo mathsize="0.900em">+</mo> <mrow><mn mathsize="0.900em">2</mn> <mo lspace="0.167em" rspace="0em"></mo><mrow><mo mathsize="0.900em" rspace="0.167em">∇</mo> <mi mathsize="0.900em">𝒚</mi></mrow> <mo lspace="0em" rspace="0em"></mo><msup><mrow><mo maxsize="0.900em" minsize="0.900em">(</mo><mi mathsize="0.900em">𝒒</mi><mo maxsize="0.900em" minsize="0.900em">)</mo></mrow> <mo mathsize="0.900em">⊤</mo></msup> <mo lspace="0.167em" rspace="0em"></mo><mrow><mrow><mo mathsize="0.900em" rspace="0.167em">∇</mo> <mi mathsize="0.900em">log</mi></mrow> <mo lspace="0.167em">⁡</mo> <mi mathsize="0.900em">p</mi></mrow> <mo lspace="0em" rspace="0em"></mo><mrow><mo maxsize="0.900em" minsize="0.900em">(</mo><mi mathsize="0.900em">𝒒</mi><mo maxsize="0.900em" minsize="0.900em">)</mo></mrow></mrow></mrow><mo maxsize="1.600em" minsize="1.600em">)</mo></mrow></mrow> <mo mathsize="0.900em">+</mo> <mrow><mi mathsize="0.900em">o</mi> <mo lspace="0em" rspace="0em"></mo><mrow><mo maxsize="0.900em" minsize="0.900em">(</mo><msup><mi mathsize="0.900em">h</mi> <mn mathsize="0.900em">2</mn></msup><mo maxsize="0.900em" minsize="0.900em">)</mo></mrow></mrow></mrow></mrow><mo mathsize="0.900em">,</mo></mrow><annotation encoding="application/x-tex">\displaystyle=\frac{h^{2}\mu_{2}(K)}{2}\Big(\Delta{\bm{y}}({\bm{q}})+2\nabla{\bm{y}}({\bm{q}})^{\top}\nabla\log p({\bm{q}})\Big)+o(h^{2}),</annotation></semantics></math></span> <span id="A1.Ex29"><math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="\displaystyle\mathrm{Var}\big[\mathaccent 866{{\bm{y}}}({\bm{q}})\big]"><semantics><mrow><mi mathsize="0.900em">Var</mi> <mo lspace="0em" rspace="0em"></mo><mrow><mo maxsize="1.200em" minsize="1.200em">[</mo><mrow><mover accent="true"><mi mathsize="0.900em">𝒚</mi> <mo mathsize="0.900em">^</mo></mover> <mo lspace="0em" rspace="0em"></mo><mrow><mo maxsize="0.900em" minsize="0.900em">(</mo><mi mathsize="0.900em">𝒒</mi><mo maxsize="0.900em" minsize="0.900em">)</mo></mrow></mrow><mo maxsize="1.200em" minsize="1.200em">]</mo></mrow></mrow> <annotation encoding="application/x-tex">\displaystyle\mathrm{Var}\big[\mathaccent 866{{\bm{y}}}({\bm{q}})\big]</annotation></semantics></math> <math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="\displaystyle=\frac{R(K)}{nh^{d}}\frac{v({\bm{q}})}{p({\bm{q}})}+o\big((nh^{d})^{-1}\big)."><semantics><mrow><mrow><mo mathsize="0.900em">=</mo> <mrow><mrow><mstyle displaystyle="true"><mfrac><mrow><mi mathsize="0.900em">R</mi> <mo lspace="0em" rspace="0em"></mo><mrow><mo maxsize="0.900em" minsize="0.900em">(</mo><mi mathsize="0.900em">K</mi><mo maxsize="0.900em" minsize="0.900em">)</mo></mrow></mrow> <mrow><mi mathsize="0.900em">n</mi> <mo lspace="0em" rspace="0em"></mo><msup><mi mathsize="0.900em">h</mi> <mi mathsize="0.900em">d</mi></msup></mrow></mfrac></mstyle> <mo lspace="0em" rspace="0em"></mo><mstyle displaystyle="true"><mfrac><mrow><mi mathsize="0.900em">v</mi> <mo lspace="0em" rspace="0em"></mo><mrow><mo maxsize="0.900em" minsize="0.900em">(</mo><mi mathsize="0.900em">𝒒</mi><mo maxsize="0.900em" minsize="0.900em">)</mo></mrow></mrow> <mrow><mi mathsize="0.900em">p</mi> <mo lspace="0em" rspace="0em"></mo><mrow><mo maxsize="0.900em" minsize="0.900em">(</mo><mi mathsize="0.900em">𝒒</mi><mo maxsize="0.900em" minsize="0.900em">)</mo></mrow></mrow></mfrac></mstyle></mrow> <mo mathsize="0.900em">+</mo> <mrow><mi mathsize="0.900em">o</mi> <mo lspace="0em" rspace="0em"></mo><mrow><mo maxsize="1.200em" minsize="1.200em">(</mo><msup><mrow><mo maxsize="0.900em" minsize="0.900em">(</mo><mrow><mi mathsize="0.900em">n</mi> <mo lspace="0em" rspace="0em"></mo><msup><mi mathsize="0.900em">h</mi> <mi mathsize="0.900em">d</mi></msup></mrow><mo maxsize="0.900em" minsize="0.900em">)</mo></mrow> <mrow><mo mathsize="0.900em">−</mo> <mn mathsize="0.900em">1</mn></mrow></msup><mo maxsize="1.200em" minsize="1.200em">)</mo></mrow></mrow></mrow></mrow><mo lspace="0em" mathsize="0.900em">.</mo></mrow><annotation encoding="application/x-tex">\displaystyle=\frac{R(K)}{nh^{d}}\frac{v({\bm{q}})}{p({\bm{q}})}+o\big((nh^{d})^{-1}\big).</annotation></semantics></math></span></span> <span style="font-size:90%;">The <math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="o(\cdot)"><semantics><mrow><mi>o</mi> <mo lspace="0em" rspace="0em"></mo><mrow><mo stretchy="false">(</mo><mo lspace="0em" rspace="0em">⋅</mo><mo stretchy="false">)</mo></mrow></mrow> <annotation encoding="application/x-tex">o(\cdot)</annotation></semantics></math> terms are uniform over compact sets where <math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="p"><semantics><mi>p</mi> <annotation encoding="application/x-tex">p</annotation></semantics></math> is bounded away from zero. (Proof in Section˜B.5.)</span></span></foreignObject></g></g></svg>

We now show that, under a fixed mean and total-covariance constraint on $p_{z}$, the isotropic Gaussian distribution uniquely minimizes the bias and variance of the kernel regression estimator at any test point. We restrict the smoothness class of the target function using

$$
\mathcal{M}(L,B)\triangleq\Big\{m\in C^{2}(\mathbb{R}^{d}):\|\nabla{\bm{y}}({\bm{q}})\|\leq L,\\
|\Delta{\bm{y}}({\bm{q}})|\leq B,\forall{\bm{q}}\in\mathbb{R}^{d}\Big\},
$$

allowing us to formalize below the worst case integrated bias and the optimal density for $z$.

<svg height="120.62" id="A1.SS2.p5.pic1" overflow="visible" version="1.1" viewBox="0 0 600 120.62" width="600"><g fill="#000000" stroke="#000000" stroke-width="0.4pt" style="--ltx-stroke-color:#000000;--ltx-fill-color:#000000;" transform="translate(0,120.62) matrix(1 0 0 -1 0 0)"><g fill="#590000" fill-opacity="1.0" style="--ltx-fill-color:#590000;"><path d="M 0 5.91 L 0 114.72 C 0 117.98 2.64 120.62 5.91 120.62 L 594.09 120.62 C 597.36 120.62 600 117.98 600 114.72 L 600 5.91 C 600 2.64 597.36 0 594.09 0 L 5.91 0 C 2.64 0 0 2.64 0 5.91 Z" style="stroke:none"></path></g><g fill="#FFF2F2" fill-opacity="1.0" style="--ltx-fill-color:#FFF2F2;"><path d="M 1.97 5.91 L 1.97 101.62 L 598.03 101.62 L 598.03 5.91 C 598.03 3.73 596.27 1.97 594.09 1.97 L 5.91 1.97 C 3.73 1.97 1.97 3.73 1.97 5.91 Z" style="stroke:none"></path></g><g fill-opacity="1.0" transform="matrix(1.0 0.0 0.0 1.0 9.26 107.66)"><foreignObject color="#FFFFFF" height="12.3" overflow="visible" style="--ltx-fg-color:#FFFFFF;--fo_width :42.02em;--fo_height:0.69em;--fo_depth :0.19em;" transform="matrix(1 0 0 -1 0 9.61)" width="581.48"><span style="width:36.54em;"><span id="A1.SS2.p5.pic1.p1">Theorem&nbsp;8:&nbsp;Kernel isotropic Gaussian Optimality</span> </span></foreignObject></g><g fill-opacity="1.0" transform="matrix(1.0 0.0 0.0 1.0 9.26 10.4)"><foreignObject color="#000000" height="85.07" overflow="visible" style="--ltx-fg-color:#000000;--fo_width :42.02em;--fo_height:5.92em;--fo_depth :0.22em;" transform="matrix(1 0 0 -1 0 81.96)" width="581.48"><span style="width:45.43em;"><span style="font-size:90%;">The integrated squared bias of (NW) satisfies</span> <math xmlns="http://www.w3.org/1998/Math/MathML" display="block" data-latex="\sup_{m\in\mathcal{M}(L,B)}\mathbb{E}_{z}\left[\mathrm{Bias}\big[\mathaccent 866{{\bm{y}}}({\bm{z}})\big]\right]\leq\Big(\frac{h^{2}\mu_{2}(K)}{2}\Big)^{2}\Big(2B^{2}+8L^{2}J(p)\Big)+o(h^{4}),"><semantics><mtable displaystyle="true"><mtr><mtd columnalign="left"><mrow><mrow><mrow><munder><mo mathsize="0.900em" movablelimits="false">sup</mo> <mrow><mi mathsize="0.900em">m</mi> <mo mathsize="0.900em">∈</mo> <mrow><mi mathsize="0.900em">ℳ</mi> <mo lspace="0em" rspace="0em"></mo><mrow><mo maxsize="0.900em" minsize="0.900em">(</mo><mi mathsize="0.900em">L</mi><mo mathsize="0.900em">,</mo><mi mathsize="0.900em">B</mi><mo maxsize="0.900em" minsize="0.900em">)</mo></mrow></mrow></mrow></munder> <mrow><msub><mi mathsize="0.900em">E</mi> <mi mathsize="0.900em">z</mi></msub> <mo lspace="0em" rspace="0em"></mo><mrow><mo>[</mo><mrow><mi mathsize="0.900em">Bias</mi> <mo lspace="0em" rspace="0em"></mo><mrow><mo maxsize="1.200em" minsize="1.200em">[</mo><mrow><mover accent="true"><mi mathsize="0.900em">𝒚</mi> <mo mathsize="0.900em">^</mo></mover> <mo lspace="0em" rspace="0em"></mo><mrow><mo maxsize="0.900em" minsize="0.900em">(</mo><mi mathsize="0.900em">𝒛</mi><mo maxsize="0.900em" minsize="0.900em">)</mo></mrow></mrow><mo maxsize="1.200em" minsize="1.200em">]</mo></mrow></mrow><mo>]</mo></mrow></mrow></mrow> <mo mathsize="0.900em">≤</mo> <mrow><mrow><msup><mrow><mo maxsize="1.600em" minsize="1.600em">(</mo><mfrac><mrow><msup><mi mathsize="0.900em">h</mi> <mn mathsize="0.900em">2</mn></msup> <mo lspace="0em" rspace="0em"></mo><msub><mi mathsize="0.900em">μ</mi> <mn mathsize="0.900em">2</mn></msub> <mo lspace="0em" rspace="0em"></mo><mrow><mo maxsize="0.900em" minsize="0.900em">(</mo><mi mathsize="0.900em">K</mi><mo maxsize="0.900em" minsize="0.900em">)</mo></mrow></mrow> <mn mathsize="0.900em">2</mn></mfrac><mo maxsize="1.600em" minsize="1.600em">)</mo></mrow> <mn mathsize="0.900em">2</mn></msup> <mo lspace="0em" rspace="0em"></mo><mrow><mo maxsize="1.600em" minsize="1.600em">(</mo><mrow><mrow><mn mathsize="0.900em">2</mn> <mo lspace="0em" rspace="0em"></mo><msup><mi mathsize="0.900em">B</mi> <mn mathsize="0.900em">2</mn></msup></mrow> <mo mathsize="0.900em">+</mo> <mrow><mn mathsize="0.900em">8</mn> <mo lspace="0em" rspace="0em"></mo><msup><mi mathsize="0.900em">L</mi> <mn mathsize="0.900em">2</mn></msup> <mo lspace="0em" rspace="0em"></mo><mi mathsize="0.900em">J</mi> <mo lspace="0em" rspace="0em"></mo><mrow><mo maxsize="0.900em" minsize="0.900em">(</mo><mi mathsize="0.900em">p</mi><mo maxsize="0.900em" minsize="0.900em">)</mo></mrow></mrow></mrow><mo maxsize="1.600em" minsize="1.600em">)</mo></mrow></mrow> <mo mathsize="0.900em">+</mo> <mrow><mi mathsize="0.900em">o</mi> <mo lspace="0em" rspace="0em"></mo><mrow><mo maxsize="0.900em" minsize="0.900em">(</mo><msup><mi mathsize="0.900em">h</mi> <mn mathsize="0.900em">4</mn></msup><mo maxsize="0.900em" minsize="0.900em">)</mo></mrow></mrow></mrow></mrow><mo mathsize="0.900em">,</mo></mrow></mtd></mtr></mtable><annotation encoding="application/x-tex">\sup_{m\in\mathcal{M}(L,B)}\mathbb{E}_{z}\left[\mathrm{Bias}\big[\mathaccent 866{{\bm{y}}}({\bm{z}})\big]\right]\leq\Big(\frac{h^{2}\mu_{2}(K)}{2}\Big)^{2}\Big(2B^{2}+8L^{2}J(p)\Big)+o(h^{4}),</annotation></semantics></math> <span style="font-size:90%;">and the integrated variance is independent of <math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="p"><semantics><mi>p</mi> <annotation encoding="application/x-tex">p</annotation></semantics></math>. Among all densities <math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="p"><semantics><mi>p</mi> <annotation encoding="application/x-tex">p</annotation></semantics></math> on <math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="\mathbb{R}^{d}"><semantics><msup><mi>R</mi> <mi>d</mi></msup> <annotation encoding="application/x-tex">\mathbb{R}^{d}</annotation></semantics></math> with total-variance constrained, e.g., <math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="\operatorname{Tr}(\Sigma)=c"><semantics><mrow><mrow><mi>Tr</mi> <mo lspace="0em" rspace="0em"></mo><mrow><mo stretchy="false">(</mo><mo stretchy="false">)</mo></mrow></mrow> <mo>=</mo> <mi>c</mi></mrow> <annotation encoding="application/x-tex">\operatorname{Tr}(\Sigma)=c</annotation></semantics></math>, the isotropic Gaussian is the unique minimizer. (Proof in Section˜B.7.)</span></span></foreignObject></g></g></svg>

## Appendix B Proofs

### B.1  Proof of Section˜3.1

###### Proof.

Our proof follows standard derivations when it comes to studying the bias of an estimator. Let’s consider the ridge regression problem (Tikhonov regularized least squares estimator) with close form estimator

$$
\hat{\bm{\beta}}=(\mathbf{X}^{T}\mathbf{X}+\lambda_{\rm wd}\mathbf{I})^{-1}\mathbf{X}^{T}\mathbf{Y}.
$$

The labels are formed from the ground truth parameter $\beta_{\rm true}$ with centered error, as per $\mathbf{Y}=\mathbf{X}\bm{\beta}_{\text{true}}+\bm{\varepsilon}$ where $\mathbb{E}[\bm{\varepsilon}]=\mathbf{0}$. We can now look at the bias of our estimator given by

$$
\displaystyle\text{Bias}(\hat{\bm{\beta}})
$$
 
$$
\displaystyle=\mathbb{E}[\hat{\bm{\beta}}]-\bm{\beta}_{\text{true}}
$$
 
$$
\displaystyle=(\mathbf{X}^{T}\mathbf{X}+\lambda_{\rm wd}\mathbf{I})^{-1}\mathbf{X}^{T}\mathbf{X}\bm{\beta}_{\text{true}}-\bm{\beta}_{\text{true}}
$$
 
$$
\displaystyle=-\lambda_{\rm wd}(\mathbf{X}^{T}\mathbf{X}+\lambda_{\rm wd}\mathbf{I})^{-1}\bm{\beta}_{\text{true}}
$$
 
$$
\displaystyle=-\lambda_{\rm wd}\mathbf{Q}(\bm{\Lambda}+\lambda\mathbf{I})^{-1}\mathbf{Q}^{T}\bm{\beta}_{\text{true}}
$$

We will now compare that bias when ${\bm{X}}$ has isotropic and anisotropic covariance with same total variance:

$$
\frac{\lambda_{1}+\lambda_{2}+\cdots+\lambda_{p}}{p}=\bar{\lambda}.
$$

For any anisotropic covariance matrix of ${\bm{X}}$, denote by ${\bm{q}}_{1}$ the eigenvector with smallest eigenvalue, and let’s denote by $\kappa>0$ a positive constant. We now define

$$
\bm{\beta}_{\text{true}}=\kappa\cdot\mathbf{q}_{p},
$$

leading to

$$
\displaystyle\|\text{Bias}(\hat{\bm{\beta}})\|_{\text{isotropic}}=\frac{\lambda_{\rm wd}}{\bar{\lambda}+\lambda_{\rm wd}}\|\bm{\beta}_{\text{true}}\|,
$$
$$
\displaystyle\|\text{Bias}(\hat{\bm{\beta}})\|_{\text{non-isotropic}}=\frac{\lambda_{\rm wd}}{\lambda_{p}+\lambda_{\rm wd}}\|\bm{\beta}_{\text{true}}\|
$$

Since $\lambda_{p}<\bar{\lambda}$ (strict inequality when not isotropic):

$$
\frac{\lambda_{\rm wd}}{\lambda_{p}+\lambda_{\rm wd}}>\frac{\lambda_{\rm wd}}{\bar{\lambda}+\lambda_{\rm wd}}
$$

we obtain that

$$
\|\text{Bias}(\hat{\bm{\beta}})\|_{\text{non-isotropic}}>\|\text{Bias}(\hat{\bm{\beta}})\|_{\text{isotropic}}
$$

As a result, whenever the covariance matrix of ${\bm{X}}$ is anisotropic, there will be downstream tasks for which the estimator bias is increased compared to having isotropic covariance matrix. Anisotropic covariance structure thus amplifies regularization bias when the true parameter vector aligns unfavorably with the data’s covariance structure. ∎

### B.2  Proof of Section˜3.1

###### Proof.

We use the same formula as in Section˜B.1 with $\lambda_{\rm wd}=0$. We first see that the estimator is unbiased. We will now leverage that result to compute the covariance matrix of the estimator

$$
\displaystyle\text{Var}(\hat{\bm{\beta}}|\mathbf{X})
$$
 
$$
\displaystyle=\mathbb{E}[(\hat{\bm{\beta}}-\bm{\beta})(\hat{\bm{\beta}}-\bm{\beta})^{T}|\mathbf{X}]
$$
 
$$
\displaystyle=\mathbb{E}[(\mathbf{X}^{T}\mathbf{X})^{-1}\mathbf{X}^{T}\bm{\varepsilon}\bm{\varepsilon}^{T}\mathbf{X}(\mathbf{X}^{T}\mathbf{X})^{-1}|\mathbf{X}]
$$
 
$$
\displaystyle=(\mathbf{X}^{T}\mathbf{X})^{-1}\mathbf{X}^{T}\mathbb{E}[\bm{\varepsilon}\bm{\varepsilon}^{T}|\mathbf{X}]\mathbf{X}(\mathbf{X}^{T}\mathbf{X})^{-1}
$$
 
$$
\displaystyle=(\mathbf{X}^{T}\mathbf{X})^{-1}\mathbf{X}^{T}(\sigma^{2}\mathbf{I}_{n})\mathbf{X}(\mathbf{X}^{T}\mathbf{X})^{-1}
$$
 
$$
\displaystyle=\sigma^{2}(\mathbf{X}^{T}\mathbf{X})^{-1}
$$

leading to the total variance

$$
\text{tr}(\text{Var}(\hat{\bm{\beta}}))=\sigma^{2}\text{tr}(\mathbf{G}^{-1})=\sigma^{2}\sumop\slimits@_{j=1}^{p}\frac{1}{\lambda_{j}}
$$

where we used the eigendecomposition:

$$
\mathbf{G}=\mathbf{Q}\bm{\Lambda}\mathbf{Q}^{T}
$$

The function $f(x)=\frac{1}{x}$ is strictly convex on $(0,\infty)$ allowing us to leverage Jensen’s Inequality:

$$
\displaystyle\frac{1}{K}\sumop\slimits@_{k=1}^{K}\frac{1}{\lambda_{k}}>\frac{1}{\frac{1}{K}\sumop\slimits@_{j=1}^{K}\lambda_{k}}
$$
 
$$
\displaystyle\iff\frac{1}{K}\sumop\slimits@_{k=1}^{K}\frac{1}{\lambda_{k}}>\frac{1}{K}\sumop\slimits@_{k=1}^{K}\frac{1}{\frac{1}{K}\sumop\slimits@_{j=1}^{K}\lambda_{k}}
$$
 
$$
\displaystyle\iff\sumop\slimits@_{k=1}^{K}\frac{1}{\lambda_{k}}>\sumop\slimits@_{k=1}^{K}\frac{1}{\frac{1}{K}\sumop\slimits@_{j=1}^{K}\lambda_{k}}
$$
 
$$
\displaystyle\iff\text{tr}(\text{Var}(\hat{\bm{\beta}}))_{\text{aniso}}>\text{tr}(\text{Var}(\hat{\bm{\beta}}))_{\text{iso}}
$$

The inequality is strict whenever the eigenvalues $\{\lambda_{j}\}_{j=1}^{p}$ are not all equal. ∎

### B.3  Proof of Section˜A.1

###### Proof.

Under PPP, conditional expectations of $\mathaccent 866{\eta}(x)$ coincide with the normalized ball average

$$
\mathbb{E}\big[\mathaccent 866{\eta}(x)\big]\;=\;\frac{\intslop\ilimits@_{\mathrm{B}(0,r_{0})}\eta(x+z)p(x+z)dz}{\intslop\ilimits@_{\mathrm{B}(0,r_{0})}p(x+z)dz}\quad\text{to second order in }r_{0},
$$

which is the key surrogate used below.

Ball integrals. For computations we use (by symmetry) for any $r>0$:

$$
\intslop\ilimits@_{\mathrm{B}(0,r)}zdz=0,\qquad\intslop\ilimits@_{\mathrm{B}(0,r)}zz^{\top}dz=\frac{{\rm Vol}^{d+2}}{d+2}I_{d},\qquad\intslop\ilimits@_{\mathrm{B}(0,r)}\left\lVert z\right\rVert^{2}dz=\frac{d{\rm Vol}^{d+2}}{d+2}.
$$

Fix $x\in\mathbb{R}^{d}$ and write $z\in\mathrm{B}(0,r_{0})$ for local displacements. Assume $p\in C^{3}$, $\eta\in C^{2}$ with bounded derivatives on the region of interest, and expand a second-order Taylor expansion:

$$
\displaystyle p(x+z)
$$
 
$$
\displaystyle=p(x)+\nabla p(x)^{\top}z+\tfrac{1}{2}z^{\top}Hp(x)z+O(\|z\|^{3}),
$$
$$
\displaystyle\eta(x+z)
$$
 
$$
\displaystyle=\eta(x)+\nabla\eta(x)^{\top}z+\tfrac{1}{2}z^{\top}H\eta(x)z+O(\|z\|^{3}),
$$

with remainders satisfying $|R_{\eta}(x;z)|\leq C_{\eta}\left\lVert z\right\rVert^{3}$ and $|R_{p}(x;z)|\leq C_{p}\left\lVert z\right\rVert^{3}$ uniformly for $\left\lVert z\right\rVert\leq r_{0}$. Using the ball identities $\intslop\ilimits@_{B(0,r)}zdz=0$ and $\intslop\ilimits@_{B(0,r)}zz^{\top}dz=\frac{v_{d}r^{d+2}}{d+2}I_{d}$ and collecting terms up to order $r_{0}^{d+2}$, we simplify the denominator as

$$
\displaystyle\mathcal{D}(x)
$$
 
$$
\displaystyle\triangleq\intslop\ilimits@_{\mathrm{B}(0,r_{0})}p(x+z)dz
$$
 
$$
\displaystyle=\intslop\ilimits@_{\mathrm{B}(0,r_{0})}\Big[p(x)+\nabla p(x)^{\top}z+\tfrac{1}{2}z^{\top}Hp(x)z+R_{p}(x;z)\Big]dz
$$
 
$$
\displaystyle={\rm Vol}_{0}^{d}p(x)\;+\;\frac{{\rm Vol}_{0}^{d+2}}{2(d+2)}\mathrm{tr}\big(Hp(x)\big)\;+\;O(r_{0}^{d+3}),
$$

since $\intslop\ilimits@zdz=0$ and $\intslop\ilimits@z^{\top}Hpzdz=\mathrm{tr}(Hp)\frac{v_{d}r_{0}^{d+2}}{d+2}$ and the denominator as

$$
\displaystyle\mathcal{N}(x)
$$
 
$$
\displaystyle\triangleq\intslop\ilimits@_{\mathrm{B}(0,r_{0})}\eta(x+z)p(x+z)dz
$$
 
$$
\displaystyle=\intslop\ilimits@\Big[\eta(x)+\nabla\eta(x)^{\top}z+\tfrac{1}{2}z^{\top}H\eta(x)z\Big]\Big[p(x)+\nabla p(x)^{\top}z+\tfrac{1}{2}z^{\top}Hp(x)z\Big]dz+O(r_{0}^{d+3})
$$
 
$$
\displaystyle=\eta(x)p(x)v_{d}r_{0}^{d}+\eta(x)\frac{v_{d}r_{0}^{d+2}}{2(d+2)}\mathrm{tr}\big(Hp(x)\big)+\frac{v_{d}r_{0}^{d+2}}{d+2}\nabla\eta(x)\cdot\nabla p(x)+\frac{v_{d}r_{0}^{d+2}}{2(d+2)}p(x)\mathrm{tr}\big(H\eta(x)\big)+O(r_{0}^{d+3}).
$$

Cubic terms vanish by symmetry, and quartic terms are $O(r_{0}^{d+4})$. Subtract $\eta(x)\mathcal{D}(x)$ to obtain the bias numerator:

$$
\mathcal{N}(x)-\eta(x)\mathcal{D}(x)=\frac{v_{d}r_{0}^{d+2}}{d+2}\Big(\nabla\eta(x)\cdot\nabla p(x)+\tfrac{1}{2}p(x)\Delta\eta(x)\Big)+O(r_{0}^{d+3}).
$$

Write $\mathcal{D}(x)=v_{d}r_{0}^{d}p(x)\big(1+\alpha(x)r_{0}^{2}+O(r_{0}^{3})\big)$ where $\alpha(x):=\frac{1}{2(d+2)p(x)}\mathrm{tr}(Hp(x))$. Then

$$
\displaystyle\frac{\mathcal{N}(x)}{\mathcal{D}(x)}-\eta(x)
$$
 
$$
\displaystyle=\frac{\frac{v_{d}r_{0}^{d+2}}{d+2}\left(\nabla\eta\cdot\nabla p+\frac{1}{2}p\Delta\eta\right)+O(r_{0}^{d+3})}{v_{d}r_{0}^{d}p\left(1+\alpha r_{0}^{2}+O(r_{0}^{3})\right)}
$$
 
$$
\displaystyle=\frac{r_{0}^{2}}{d+2}\left(\frac{\nabla\eta\cdot\nabla p}{p}+\frac{1}{2}\Delta\eta\right)\Big(1-\alpha r_{0}^{2}+O(r_{0}^{3})\Big)\ +\ O(r_{0}^{3})
$$
 
$$
\displaystyle=\frac{r_{0}^{2}}{d+2}\Big(\nabla\eta(x)\cdot\nabla\log p(x)+\tfrac{1}{2}\Delta\eta(x)\Big)\ +\ o(r_{0}^{2}),
$$

uniformly on $\mathcal{K}$. This gives the bias formula

$$
\mathbb{E}\big[\mathaccent 866{\eta}(x)\big]-\eta(x)=\frac{r_{0}^{2}}{d+2}\Big(\nabla\eta(x)\cdot\nabla\log p(x)+\tfrac{1}{2}\Delta\eta(x)\Big)\ +\ o(r_{0}^{2}),
$$

completing the proof. ∎

### B.4  Proof of Section˜A.1

###### Proof.

Recall from Section˜B.3 that the bias term as sample ${\bm{x}}$ is given by

$$
\displaystyle\mathrm{Bias}({\bm{x}})=
$$
 
$$
\displaystyle\frac{r_{0}^{2}}{d+2}\Big(\nabla\eta(x)\cdot\nabla\log p(x)\Big)\;+\;\frac{r_{0}^{2}}{2(d+2)}\Delta\eta(x)\;+\;o(r_{0}^{2})
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\frac{r_{0}^{2}}{d+2}\big(A(x)+C(x)\big)+o(r_{0}^{2}),
$$

where we defined $A(x)\triangleq\nabla\eta(x)\cdot\nabla\log p(x)$ and $C(x)\triangleq\frac{1}{2}\Delta\eta(x)$. We now square and take expectation of $X\sim p$ and the isotropic gradient prior

$$
\displaystyle\mathbb{E}\big[\mathrm{Bias}(X)^{2}\big]
$$
 
$$
\displaystyle=\mathbb{E}\big[\left(\frac{r_{0}^{2}}{d+2}\right)^{2}\big(A(x)^{2}+2A(x)C(x)+C(x)^{2}\big)+o(r_{0}^{4})\big]
$$
 
$$
\displaystyle=\left(\frac{r_{0}^{2}}{d+2}\right)^{2}\Big\{\underbrace{\mathbb{E}\big[A(X)^{2}\big]}_{\text{score-gradient term}}+\underbrace{2\mathbb{E}\big[A(X)C(X)\big]}_{\text{cross term}}+\underbrace{\mathbb{E}\big[C(X)^{2}\big]}_{\text{curvature term}}\Big\}+o(r_{0}^{4}).
$$

We will derive each term separately, recalling that we assume an isotropic gradient prior for $\eta$, i.e., $\mathbb{E}\big[\nabla\eta(x)\big]=0$ and $\mathbb{E}\big[\nabla\eta(x)\nabla\eta(x)^{\top}\big]=\tau_{g}^{2}I_{d}$, for some $\tau_{g}^{2}\in(0,\infty)$.

##### 1) The score-gradient term E\[A(X)2\]\\mathbb{E}\[A(X)^{2}\].

Using $v(x):=\nabla\log p(x)$ for brevity:

$$
\displaystyle\mathbb{E}\big[A(X)^{2}\big]=
$$
 
$$
\displaystyle\mathbb{E}_{X}\big[\mathbb{E}_{\eta}[A(X)^{2}]\big]
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\mathbb{E}_{X}\big[\mathbb{E}_{\eta}[\big(\nabla\eta(x)^{\top}v(x)\big)^{2}]\big]
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\mathbb{E}_{X}\big[\mathbb{E}_{\eta}[\nabla\eta(x)^{\top}\Big(v(x)v(x)^{\top}\Big)\nabla\eta(x)]\big]
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\mathbb{E}_{X}\big[\mathbb{E}_{\eta}[\mathrm{tr}\Big(v(x)v(x)^{\top}\nabla\eta(x)\nabla\eta(x)^{\top}\Big)]\big]
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\mathbb{E}_{X}\big[\mathrm{tr}\Big(v(x)v(x)^{\top}\mathbb{E}_{\eta}[\nabla\eta(x)\nabla\eta(x)^{\top}]\Big)\big]
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\mathbb{E}_{X}\big[\tau_{g}^{2}\|v(x)\|^{2}\big]
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\tau_{g}^{2}\mathbb{E}_{X}\big[\|v(X)\|^{2}\big]
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\tau_{g}^{2}\intslop\ilimits@_{\mathbb{R}^{d}}\|\nabla\log p(x)\|^{2}p(x)dx
$$

recovering the Fisher-information functional $J(p)$, scaled by $\tau_{g}^{2}$

##### 2) The cross term 2E\[A(X)C(X)\]2\\mathbb{E}\[A(X)C(X)\].

We have

$$
A(x)C(x)=\frac{1}{2}\big(\nabla\eta(x)^{\top}v(x)\big)\Delta\eta(x).
$$

Under the prior, $\nabla\eta$ is mean-zero and isotropic; if, additionally, $\Delta\eta$ is uncorrelated with $\nabla\eta$ and has zero mean (or is bounded and mean-zero after centering), then $\mathbb{E}_{\eta}[A(x)C(x)]=0$. If one does *not* assume the orthogonality/vanishing covariance above, then $\mathbb{E}[A(X)C(X)]$ is a finite constant (depending on the joint law of derivatives of $\eta$), and the cross term contributes

$$
\left(\frac{r_{0}^{2}}{d+2}\right)^{2}\cdot 2\mathbb{E}[A(X)C(X)]=\ O(r_{0}^{4}),
$$

not $o(r_{0}^{4})$. In that general case, the leading $p$ -dependent term of $\mathbb{E}[\mathrm{Bias}(X)^{2}]$ is still the *score-gradient* $\tau_{g}^{2}J(p)$.

##### 3) The curvature term E\[C(X)2\]\\mathbb{E}\[C(X)^{2}\].

$$
\displaystyle\mathbb{E}\big[C(X)^{2}\big]=
$$
 
$$
\displaystyle\mathbb{E}_{X}\big[\mathbb{E}_{\eta}[C(X)^{2}]\big]
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\frac{1}{4}\mathbb{E}_{X}\big[\mathbb{E}_{\eta}[(\Delta\eta(X))^{2}\big]
$$

which is independent of $p$, hence $\mathbb{E}\big[C(X)^{2}\big]=O(1)$

##### Putting it together.

Substituting into (15):

$$
\displaystyle\mathbb{E}\big[\mathrm{Bias}(X)^{2}\big]
$$
 
$$
\displaystyle=\left(\frac{r_{0}^{2}}{d+2}\right)^{2}\Big\{\tau_{g}^{2}J(p)+O(1)\Big\}+o(r_{0}^{4})
$$
 
$$
\displaystyle=\frac{r_{0}^{4}}{(d+2)^{2}}\tau_{g}^{2}J(p)\;+\;O(r_{0}^{4}),
$$

We show that, among all mean-zero distributions $p$ on $\mathbb{R}^{d}$ with a given *scalar* constraint on the covariance (trace, determinant, Frobenius norm, or spectral radius), the density that minimizes the Fisher-information functional

$$
J(p)\;:=\;\intslop\ilimits@_{\mathbb{R}^{d}}\|\nabla\log p(x)\|^{2}p(x)dx
$$

is the Gaussian with *isotropic* covariance satisfying the same scalar constraint.

We proceed in two steps: (i) for fixed covariance matrix $\Sigma\succ 0$, $J(p)$ is minimized by the Gaussian $\mathcal{N}(0,\Sigma)$ and attains the value $\mathrm{tr}({}^{-1})$; (ii) for each scalar constraint, $\mathrm{tr}({}^{-1})$ is minimized by $\Sigma=sI_{d}$ for the appropriate scalar $s>0$.

<svg height="1226.09" id="A2.SS4.SSS0.Px4.p4.pic1" overflow="visible" version="1.1" viewBox="0 0 600 1226.09" width="600"><g fill="#000000" stroke="#000000" stroke-width="0.4pt" style="--ltx-stroke-color:#000000;--ltx-fill-color:#000000;" transform="translate(0,1226.09) matrix(1 0 0 -1 0 0)"><g fill="#000059" fill-opacity="1.0" style="--ltx-fill-color:#000059;"><path d="M 0 5.91 L 0 1220.18 C 0 1223.44 2.64 1226.09 5.91 1226.09 L 594.09 1226.09 C 597.36 1226.09 600 1223.44 600 1220.18 L 600 5.91 C 600 2.64 597.36 0 594.09 0 L 5.91 0 C 2.64 0 0 2.64 0 5.91 Z" style="stroke:none"></path></g><g fill="#F7F7FF" fill-opacity="1.0" style="--ltx-fill-color:#F7F7FF;"><path d="M 1.97 5.91 L 1.97 1207.08 L 598.03 1207.08 L 598.03 5.91 C 598.03 3.73 596.27 1.97 594.09 1.97 L 5.91 1.97 C 3.73 1.97 1.97 3.73 1.97 5.91 Z" style="stroke:none"></path></g><g fill-opacity="1.0" transform="matrix(1.0 0.0 0.0 1.0 9.26 1213.13)"><foreignObject color="#FFFFFF" height="12.3" overflow="visible" style="--ltx-fg-color:#FFFFFF;--fo_width :42.02em;--fo_height:0.69em;--fo_depth :0.19em;" transform="matrix(1 0 0 -1 0 9.61)" width="581.48"><span style="width:36.54em;"><span id="A2.SS4.SSS0.Px4.p4.pic1.p1">Lemma&nbsp;6:&nbsp;Special case: Recovery of VCReg</span> </span></foreignObject></g><g fill-opacity="1.0" transform="matrix(1.0 0.0 0.0 1.0 9.26 10.4)"><foreignObject color="#000000" height="1190.54" overflow="visible" style="--ltx-fg-color:#000000;--fo_width :42.02em;--fo_height:85.81em;--fo_depth :0.22em;" transform="matrix(1 0 0 -1 0 1187.42)" width="581.48"><span style="width:45.43em;"><span style="font-size:90%;">Let <math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="p"><semantics><mi>p</mi> <annotation encoding="application/x-tex">p</annotation></semantics></math> be a mean-zero probability density on <math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="\mathbb{R}^{d}"><semantics><msup><mi>R</mi> <mi>d</mi></msup> <annotation encoding="application/x-tex">\mathbb{R}^{d}</annotation></semantics></math> with covariance <math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="\Sigma=\mathbb{E}[XX^{\top}]\succ 0"><semantics><mrow><mo>=</mo> <mrow><mi>E</mi> <mo lspace="0em" rspace="0em"></mo><mrow><mo stretchy="false">[</mo><mrow><mi>X</mi> <mo lspace="0em" rspace="0em"></mo><msup><mi>X</mi> <mo>⊤</mo></msup></mrow><mo stretchy="false">]</mo></mrow></mrow> <mo>≻</mo> <mn>0</mn></mrow> <annotation encoding="application/x-tex">\Sigma=\mathbb{E}[XX^{\top}]\succ 0</annotation></semantics></math>. Then</span> <span id="A2.Ex81"><math xmlns="http://www.w3.org/1998/Math/MathML" display="block" data-latex="J(p)\;\geq\;\mathrm{tr}({}^{-1}),"><semantics><mrow><mi mathsize="0.900em">J</mi> <mrow><mo maxsize="0.900em" minsize="0.900em">(</mo><mi mathsize="0.900em">p</mi><mo maxsize="0.900em" minsize="0.900em" rspace="0.280em">)</mo></mrow> <mo mathsize="0.900em" rspace="0.558em">≥</mo> <mi mathsize="0.900em">tr</mi> <mrow><mo maxsize="0.900em" minsize="0.900em">(</mo><mmultiscripts><mo maxsize="0.900em" minsize="0.900em">)</mo> <mrow><mo mathsize="0.900em">−</mo> <mn mathsize="0.900em">1</mn></mrow></mmultiscripts></mrow><mo mathsize="0.900em">,</mo></mrow><annotation encoding="application/x-tex">J(p)\;\geq\;\mathrm{tr}({}^{-1}),</annotation></semantics></math></span> <span style="font-size:90%;">with equality if and only if <math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="p=\mathcal{N}(0,\Sigma)"><semantics><mrow><mi>p</mi> <mo>=</mo> <mi>𝒩</mi> <mrow><mo stretchy="false">(</mo><mn>0</mn><mo>,</mo><mo stretchy="false">)</mo></mrow></mrow> <annotation encoding="application/x-tex">p=\mathcal{N}(0,\Sigma)</annotation></semantics></math>.</span></span></foreignObject></g></g></svg>

###### Proof.

Consider the location family $p_{\theta}(x):=p(x-\theta)$, $\theta\in\mathbb{R}^{d}$. Its Fisher-information matrix at $\theta$ is

$$
\mathcal{I}(\theta)\;=\;\mathbb{E}\big[\nabla_{\theta}\log p_{\theta}(X)\nabla_{\theta}\log p_{\theta}(X)^{\top}\big]\;=\;\mathbb{E}\big[\nabla\log p(X)\nabla\log p(X)^{\top}\big],
$$

so that $J(p)=\mathrm{tr}\mathcal{I}(\theta)$. The estimator $T(X)\equiv X$ is unbiased for $\theta$ under $p_{\theta}$, with $\mathrm{Cov}(T)=\Sigma$. The matrix Cramér–Rao bound gives $\mathrm{Cov}(T)\succeq\mathcal{I}(\theta)^{-1}$, i.e., $\mathcal{I}(\theta)\succeq{}^{-1}$. Taking traces yields $J(p)\geq\mathrm{tr}({}^{-1})$. Equality in the matrix Cramér–Rao bound holds if and only if the score is an *affine* function of $X-\theta$, i.e., $\nabla\log p_{\theta}(X)=A(X-\theta)$ a.s. for some matrix $A$; integrating this identity shows $p_{\theta}$ is Gaussian with precision matrix $-A$, hence $p=\mathcal{N}(0,\Sigma)$. ∎

### Step 2: Optimizing over covariance shapes under scalar constraints

Write the eigenvalues of as $\lambda_{1},\ldots,\lambda_{d}>0$. Then

$$
\mathrm{tr}({}^{-1})=\sumop\slimits@_{i=1}^{d}\frac{1}{\lambda_{i}}.
$$

We now solve $\min\sumop\slimits@_{i}1/\lambda_{i}$ under each scalar constraint; in every case the minimum is attained when all $\lambda_{i}$ are equal, i.e., $\Sigma=sI_{d}$.

##### (a) Trace constraint.

Given $\mathrm{tr}(\Sigma)=\sumop\slimits@_{i}\lambda_{i}=t>0$, by Cauchy–Schwarz,

$$
\left(\sumop\slimits@_{i=1}^{d}\frac{1}{\lambda_{i}}\right)\left(\sumop\slimits@_{i=1}^{d}\lambda_{i}\right)\;\geq\;\left(\sumop\slimits@_{i=1}^{d}1\right)^{2}=d^{2},
$$

with equality if and only if $\lambda_{1}=\cdots=\lambda_{d}$. Hence

$$
\min_{\Sigma\succ 0:\ \mathrm{tr}(\Sigma)=t}\ \mathrm{tr}({}^{-1})\;=\;\frac{d^{2}}{t},\quad\text{attained at}\quad\Sigma=\frac{t}{d}I_{d}.
$$

##### (b) Determinant constraint.

Given $\det(\Sigma)=\prodop\slimits@_{i}\lambda_{i}=\delta>0$, set $\mu_{i}:=1/\lambda_{i}$ so that $\prodop\slimits@_{i}\mu_{i}=\delta^{-1}$. By the AM–GM inequality,

$$
\frac{1}{d}\sumop\slimits@_{i=1}^{d}\mu_{i}\;\geq\;\left(\prodop\slimits@_{i=1}^{d}\mu_{i}\right)^{1/d}=\delta^{-1/d},
$$

with equality iff $\mu_{1}=\cdots=\mu_{d}$, i.e., $\lambda_{1}=\cdots=\lambda_{d}$. Thus

$$
\min_{\Sigma\succ 0:\ \det(\Sigma)=\delta}\ \mathrm{tr}({}^{-1})\;=\;d\delta^{-1/d},\quad\text{attained at}\quad\Sigma=\delta^{1/d}I_{d}.
$$

##### (c) Frobenius-norm constraint.

Given $\|\Sigma\|_{F}^{2}=\sumop\slimits@_{i}\lambda_{i}^{2}=c^{2}>0$, minimize $f(\lambda):=\sumop\slimits@_{i}1/\lambda_{i}$ over $\lambda_{i}>0$ subject to $g(\lambda):=\sumop\slimits@_{i}\lambda_{i}^{2}=c^{2}$. The Lagrangian

$$
\mathcal{L}(\lambda,\nu)=\sumop\slimits@_{i=1}^{d}\frac{1}{\lambda_{i}}+\nu\left(\sumop\slimits@_{i=1}^{d}\lambda_{i}^{2}-c^{2}\right)
$$

has first-order conditions $-\lambda_{i}^{-2}+2\nu\lambda_{i}=0$ for all $i$, i.e., $\lambda_{i}^{3}=\frac{1}{2\nu}$, so all $\lambda_{i}$ are equal. Imposing $\sumop\slimits@\lambda_{i}^{2}=c^{2}$ yields $\lambda_{i}=c/\sqrt{d}$, hence

$$
\min_{\Sigma\succ 0:\ \|\Sigma\|_{F}=c}\ \mathrm{tr}({}^{-1})\;=\;\sumop\slimits@_{i=1}^{d}\frac{1}{\lambda_{i}}\;=\;\frac{d^{3/2}}{c},\quad\text{attained at}\quad\Sigma=\frac{c}{\sqrt{d}}I_{d}.
$$

##### (d) Spectral-radius constraint.

Let the spectral radius be constrained by $\rho(\Sigma)=\max_{i}\lambda_{i}\leq r$ for some $r>0$. Since $x\mapsto 1/x$ is strictly decreasing on $(0,\infty)$,

$$
\sumop\slimits@_{i=1}^{d}\frac{1}{\lambda_{i}}\;\geq\;\sumop\slimits@_{i=1}^{d}\frac{1}{r}\;=\;\frac{d}{r},
$$

with equality if and only if $\lambda_{i}=r$ for all $i$. Therefore

$$
\min_{\Sigma\succ 0:\ \rho(\Sigma)\leq r}\ \mathrm{tr}({}^{-1})\;=\;\frac{d}{r},\quad\text{attained at}\quad\Sigma=rI_{d}.
$$

(The same conclusion holds if the constraint is $\rho(\Sigma)=r$, since one may take all eigenvalues equal to $r$.)

### Conclusion: Isotropic Gaussian is optimal

Combining Lemma B.4 with the solutions (a)–(d), we obtain:

<svg height="5416.72" id="A2.SSx2.p2.pic1" overflow="visible" version="1.1" viewBox="0 0 600 5416.72" width="600"><g fill="#000000" stroke="#000000" stroke-width="0.4pt" style="--ltx-stroke-color:#000000;--ltx-fill-color:#000000;" transform="translate(0,5416.72) matrix(1 0 0 -1 0 0)"><g fill="#590000" fill-opacity="1.0" style="--ltx-fill-color:#590000;"><path d="M 0 5.91 L 0 5410.82 C 0 5414.08 2.64 5416.72 5.91 5416.72 L 594.09 5416.72 C 597.36 5416.72 600 5414.08 600 5410.82 L 600 5.91 C 600 2.64 597.36 0 594.09 0 L 5.91 0 C 2.64 0 0 2.64 0 5.91 Z" style="stroke:none"></path></g><g fill="#FFF2F2" fill-opacity="1.0" style="--ltx-fill-color:#FFF2F2;"><path d="M 1.97 5.91 L 1.97 5397.72 L 598.03 5397.72 L 598.03 5.91 C 598.03 3.73 596.27 1.97 594.09 1.97 L 5.91 1.97 C 3.73 1.97 1.97 3.73 1.97 5.91 Z" style="stroke:none"></path></g><g fill-opacity="1.0" transform="matrix(1.0 0.0 0.0 1.0 9.26 5403.76)"><foreignObject color="#FFFFFF" height="12.3" overflow="visible" style="--ltx-fg-color:#FFFFFF;--fo_width :42.02em;--fo_height:0.69em;--fo_depth :0.19em;" transform="matrix(1 0 0 -1 0 9.61)" width="581.48"><span style="width:36.54em;"><span id="A2.SSx2.p2.pic1.p1">Theorem&nbsp;9:&nbsp;Special case: Recovery of VCReg</span> </span></foreignObject></g><g fill-opacity="1.0" transform="matrix(1.0 0.0 0.0 1.0 9.26 10.4)"><foreignObject color="#000000" height="5381.17" overflow="visible" style="--ltx-fg-color:#000000;--fo_width :42.02em;--fo_height:388.67em;--fo_depth :0.22em;" transform="matrix(1 0 0 -1 0 5378.06)" width="581.48"><span style="width:45.43em;"><span style="font-size:90%;">Fix one of the following scalar covariance constraints for a mean-zero distribution <math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="p"><semantics><mi>p</mi> <annotation encoding="application/x-tex">p</annotation></semantics></math> on <math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="\mathbb{R}^{d}"><semantics><msup><mi>R</mi> <mi>d</mi></msup> <annotation encoding="application/x-tex">\mathbb{R}^{d}</annotation></semantics></math>:</span> <span id="A2.I1"><span id="A2.I1.i1" style="list-style-type:none;">• <span id="A2.I1.i1.p1"><span style="font-size:90%;">trace:</span> <math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="\mathrm{tr}(\mathrm{Cov}(X))=t"><semantics><mrow><mrow><mi mathsize="0.900em">tr</mi> <mo lspace="0em" rspace="0em"></mo><mrow><mo maxsize="0.900em" minsize="0.900em">(</mo><mrow><mi mathsize="0.900em">Cov</mi> <mo lspace="0em" rspace="0em"></mo><mrow><mo maxsize="0.900em" minsize="0.900em">(</mo><mi mathsize="0.900em">X</mi><mo maxsize="0.900em" minsize="0.900em">)</mo></mrow></mrow><mo maxsize="0.900em" minsize="0.900em">)</mo></mrow></mrow> <mo mathsize="0.900em">=</mo> <mi mathsize="0.900em">t</mi></mrow> <annotation encoding="application/x-tex">\mathrm{tr}(\mathrm{Cov}(X))=t</annotation></semantics></math><span style="font-size:90%;">,</span></span></span> <span id="A2.I1.i2" style="list-style-type:none;">• <span id="A2.I1.i2.p1"><span style="font-size:90%;">determinant:</span> <math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="\det(\mathrm{Cov}(X))=\delta"><semantics><mrow><mrow><mo mathsize="0.900em" rspace="0em">det</mo> <mrow><mo maxsize="0.900em" minsize="0.900em">(</mo><mrow><mi mathsize="0.900em">Cov</mi> <mo lspace="0em" rspace="0em"></mo><mrow><mo maxsize="0.900em" minsize="0.900em">(</mo><mi mathsize="0.900em">X</mi><mo maxsize="0.900em" minsize="0.900em">)</mo></mrow></mrow><mo maxsize="0.900em" minsize="0.900em">)</mo></mrow></mrow> <mo mathsize="0.900em">=</mo> <mi mathsize="0.900em">δ</mi></mrow> <annotation encoding="application/x-tex">\det(\mathrm{Cov}(X))=\delta</annotation></semantics></math><span style="font-size:90%;">,</span></span></span> <span id="A2.I1.i3" style="list-style-type:none;">• <span id="A2.I1.i3.p1"><span style="font-size:90%;">Frobenius norm:</span> <math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="\|\mathrm{Cov}(X)\|_{F}=c"><semantics><mrow><mrow><mo lspace="0em" rspace="0em"></mo><mi mathsize="0.900em">Cov</mi> <mo lspace="0em" rspace="0em"></mo><mrow><mo maxsize="0.900em" minsize="0.900em">(</mo><mi mathsize="0.900em">X</mi><mo maxsize="0.900em" minsize="0.900em">)</mo></mrow> <mo lspace="0em" rspace="0em"></mo><msub><mi mathsize="0.900em">F</mi></msub></mrow> <mo mathsize="0.900em">=</mo> <mi mathsize="0.900em">c</mi></mrow> <annotation encoding="application/x-tex">\|\mathrm{Cov}(X)\|_{F}=c</annotation></semantics></math><span style="font-size:90%;">,</span></span></span> <span id="A2.I1.i4" style="list-style-type:none;">• <span id="A2.I1.i4.p1"><span style="font-size:90%;">spectral radius upper bound:</span> <math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="\rho(\mathrm{Cov}(X))\leq r"><semantics><mrow><mrow><mi mathsize="0.900em">ρ</mi> <mo lspace="0em" rspace="0em"></mo><mrow><mo maxsize="0.900em" minsize="0.900em">(</mo><mrow><mi mathsize="0.900em">Cov</mi> <mo lspace="0em" rspace="0em"></mo><mrow><mo maxsize="0.900em" minsize="0.900em">(</mo><mi mathsize="0.900em">X</mi><mo maxsize="0.900em" minsize="0.900em">)</mo></mrow></mrow><mo maxsize="0.900em" minsize="0.900em">)</mo></mrow></mrow> <mo mathsize="0.900em">≤</mo> <mi mathsize="0.900em">r</mi></mrow> <annotation encoding="application/x-tex">\rho(\mathrm{Cov}(X))\leq r</annotation></semantics></math><span style="font-size:90%;">.</span></span></span></span> <span style="font-size:90%;">Then the Fisher-information functional <math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="J(p)"><semantics><mrow><mi>J</mi> <mo lspace="0em" rspace="0em"></mo><mrow><mo stretchy="false">(</mo><mi>p</mi><mo stretchy="false">)</mo></mrow></mrow> <annotation encoding="application/x-tex">J(p)</annotation></semantics></math> is minimized over all such <math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="p"><semantics><mi>p</mi> <annotation encoding="application/x-tex">p</annotation></semantics></math> by the isotropic Gaussian <math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="p_{G}=\mathcal{N}(0,sI_{d})"><semantics><mrow><msub><mi>p</mi> <mi>G</mi></msub> <mo>=</mo> <mrow><mi>𝒩</mi> <mo lspace="0em" rspace="0em"></mo><mrow><mo stretchy="false">(</mo><mn>0</mn><mo>,</mo><mrow><mi>s</mi> <mo lspace="0em" rspace="0em"></mo><msub><mi>I</mi> <mi>d</mi></msub></mrow><mo stretchy="false">)</mo></mrow></mrow></mrow> <annotation encoding="application/x-tex">p_{G}=\mathcal{N}(0,sI_{d})</annotation></semantics></math> with <math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="s"><semantics><mi>s</mi> <annotation encoding="application/x-tex">s</annotation></semantics></math> chosen to satisfy the constraint. The minimal values are:</span> <span id="A2.Ex92"><math xmlns="http://www.w3.org/1998/Math/MathML" display="block" data-latex="\begin{array}[]{ll}\text{trace }t:&amp;J_{\min}=\dfrac{d^{2}}{t},\qquad s=\dfrac{t}{d},\\[4.64996pt]
\text{determinant }\delta:&amp;J_{\min}=d\delta^{-1/d},\qquad s=\delta^{1/d},\\[4.64996pt]
\text{Frobenius }c:&amp;J_{\min}=\dfrac{d^{3/2}}{c},\qquad s=\dfrac{c}{\sqrt{d}},\\[4.64996pt]
\text{spectral radius }r:&amp;J_{\min}=\dfrac{d}{r},\qquad s=r.\end{array}"><semantics><mtable columnspacing="5pt" displaystyle="true" rowspacing="0pt"><mtr><mtd columnalign="left"><mrow><mrow><mtext mathsize="0.900em">trace&nbsp;</mtext> <mo lspace="0em" rspace="0em"></mo><mi mathsize="0.900em">t</mi></mrow><mo lspace="0.278em" mathsize="0.900em" rspace="0.278em">:</mo></mrow></mtd><mtd columnalign="left"><mrow><mrow><mrow><msub><mi mathsize="0.900em">J</mi> <mi mathsize="0.900em">min</mi></msub> <mo mathsize="0.900em">=</mo> <mfrac><msup><mi mathsize="0.900em">d</mi> <mn mathsize="0.900em">2</mn></msup> <mi mathsize="0.900em">t</mi></mfrac></mrow><mo mathsize="0.900em" rspace="1.087em">,</mo><mrow><mi mathsize="0.900em">s</mi> <mo mathsize="0.900em">=</mo> <mfrac><mi mathsize="0.900em">t</mi> <mi mathsize="0.900em">d</mi></mfrac></mrow></mrow><mo mathsize="0.900em">,</mo></mrow></mtd></mtr><mtr><mtd columnalign="left"><mrow><mrow><mtext mathsize="0.900em">determinant&nbsp;</mtext> <mo lspace="0em" rspace="0em"></mo><mi mathsize="0.900em">δ</mi></mrow><mo lspace="0.278em" mathsize="0.900em" rspace="0.278em">:</mo></mrow></mtd><mtd columnalign="left"><mrow><mrow><mrow><msub><mi mathsize="0.900em">J</mi> <mi mathsize="0.900em">min</mi></msub> <mo mathsize="0.900em">=</mo> <mrow><mi mathsize="0.900em">d</mi> <mo lspace="0em" rspace="0em"></mo><msup><mi mathsize="0.900em">δ</mi> <mrow><mo mathsize="0.900em">−</mo> <mrow><mn mathsize="0.900em">1</mn> <mo maxsize="0.900em" minsize="0.900em" stretchy="true" symmetric="true">/</mo> <mi mathsize="0.900em">d</mi></mrow></mrow></msup></mrow></mrow><mo mathsize="0.900em" rspace="1.087em">,</mo><mrow><mi mathsize="0.900em">s</mi> <mo mathsize="0.900em">=</mo> <msup><mi mathsize="0.900em">δ</mi> <mrow><mn mathsize="0.900em">1</mn> <mo maxsize="0.900em" minsize="0.900em" stretchy="true" symmetric="true">/</mo> <mi mathsize="0.900em">d</mi></mrow></msup></mrow></mrow><mo mathsize="0.900em">,</mo></mrow></mtd></mtr><mtr><mtd columnalign="left"><mrow><mrow><mtext mathsize="0.900em">Frobenius&nbsp;</mtext> <mo lspace="0em" rspace="0em"></mo><mi mathsize="0.900em">c</mi></mrow><mo lspace="0.278em" mathsize="0.900em" rspace="0.278em">:</mo></mrow></mtd><mtd columnalign="left"><mrow><mrow><mrow><msub><mi mathsize="0.900em">J</mi> <mi mathsize="0.900em">min</mi></msub> <mo mathsize="0.900em">=</mo> <mfrac><msup><mi mathsize="0.900em">d</mi> <mrow><mn mathsize="0.900em">3</mn> <mo maxsize="0.900em" minsize="0.900em" stretchy="true" symmetric="true">/</mo> <mn mathsize="0.900em">2</mn></mrow></msup> <mi mathsize="0.900em">c</mi></mfrac></mrow><mo mathsize="0.900em" rspace="1.087em">,</mo><mrow><mi mathsize="0.900em">s</mi> <mo mathsize="0.900em">=</mo> <mfrac><mi mathsize="0.900em">c</mi> <msqrt><mi mathsize="0.900em">d</mi></msqrt></mfrac></mrow></mrow><mo mathsize="0.900em">,</mo></mrow></mtd></mtr><mtr><mtd columnalign="left"><mrow><mrow><mtext mathsize="0.900em">spectral radius&nbsp;</mtext> <mo lspace="0em" rspace="0em"></mo><mi mathsize="0.900em">r</mi></mrow><mo lspace="0.278em" mathsize="0.900em" rspace="0.278em">:</mo></mrow></mtd><mtd columnalign="left"><mrow><mrow><mrow><msub><mi mathsize="0.900em">J</mi> <mi mathsize="0.900em">min</mi></msub> <mo mathsize="0.900em">=</mo> <mfrac><mi mathsize="0.900em">d</mi> <mi mathsize="0.900em">r</mi></mfrac></mrow><mo mathsize="0.900em" rspace="1.087em">,</mo><mrow><mi mathsize="0.900em">s</mi> <mo mathsize="0.900em">=</mo> <mi mathsize="0.900em">r</mi></mrow></mrow><mo lspace="0em" mathsize="0.900em">.</mo></mrow></mtd></mtr></mtable><annotation encoding="application/x-tex">\begin{array}[]{ll}\text{trace }t:&amp;J_{\min}=\dfrac{d^{2}}{t},\qquad s=\dfrac{t}{d},\\[4.64996pt] \text{determinant }\delta:&amp;J_{\min}=d\delta^{-1/d},\qquad s=\delta^{1/d},\\[4.64996pt] \text{Frobenius }c:&amp;J_{\min}=\dfrac{d^{3/2}}{c},\qquad s=\dfrac{c}{\sqrt{d}},\\[4.64996pt] \text{spectral radius }r:&amp;J_{\min}=\dfrac{d}{r},\qquad s=r.\end{array}</annotation></semantics></math> </span><span style="font-size:90%;">In each case, <math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="p_{G}"><semantics><msub><mi>p</mi> <mi>G</mi></msub> <annotation encoding="application/x-tex">p_{G}</annotation></semantics></math> is the unique minimizer (up to null sets).</span></span></foreignObject></g></g></svg>

###### Proof.

For any admissible $p$ with covariance, Lemma B.4 gives $J(p)\geq\mathrm{tr}({}^{-1})$. Minimizing the right-hand side under the stated scalar constraint yields $\Sigma=sI_{d}$ by the calculations in (a)–(d). Equality in Lemma B.4 holds if and only if $p$ is Gaussian with that covariance, hence $p_{G}$ uniquely attains the bound. ∎

∎

### B.5  Proof of Section˜A.2

###### Proof.

Write the numerator and denominator of $\mathaccent 866{m}(x)$ as

$$
B_{n}(x):=\sumop\slimits@_{i=1}^{n}K_{h}(x-X_{i})Y_{i},\qquad A_{n}(x):=\sumop\slimits@_{i=1}^{n}K_{h}(x-X_{i}),
$$

so that $\mathaccent 866{m}(x)=\frac{B_{n}(x)}{A_{n}(x)}$. *Bias.* Compute expectations using independence and change of variables. For the denominator,

$$
\displaystyle\mathbb{E}[A_{n}(x)]
$$
 
$$
\displaystyle=n\mathbb{E}\big[K_{h}(x-X)\big]
$$
 
$$
\displaystyle=n\intslop\ilimits@_{\mathbb{R}^{d}}h^{-d}K\Big(\frac{x-u}{h}\Big)p(u)du
$$
 
$$
\displaystyle=n\intslop\ilimits@_{\mathbb{R}^{d}}K(t)p(x-ht)dt\qquad(t:=(x-u)/h)
$$
 
$$
\displaystyle=n\intslop\ilimits@_{\mathbb{R}^{d}}K(t)\Big(p(x)-ht^{\top}\nabla p(x)+\frac{h^{2}}{2}t^{\top}\nabla^{2}p(x)t+o(h^{2})\Big)dt
$$
 
$$
\displaystyle=n\Big(p(x)+\frac{h^{2}}{2}\underbrace{\intslop\ilimits@t^{\top}\nabla^{2}p(x)tK(t)dt}_{=\mu_{2}(K)\Delta p(x)}+o(h^{2})\Big),
$$

where we used symmetry $\intslop\ilimits@tK(t)dt=0$ and isotropy $\intslop\ilimits@tt^{\top}K(t)dt=\mu_{2}(K)I_{d}$, which implies $\intslop\ilimits@t^{\top}\nabla^{2}p(x)tK(t)dt=\mu_{2}(K)\mathrm{tr}(\nabla^{2}p(x))=\mu_{2}(K)\Delta p(x)$. Similarly, for the numerator,

$$
\displaystyle\mathbb{E}[B_{n}(x)]
$$
 
$$
\displaystyle=n\mathbb{E}\big[K_{h}(x-X)Y\big]=n\intslop\ilimits@K(t)(mp)(x-ht)dt
$$
 
$$
\displaystyle=n\intslop\ilimits@K(t)\Big((mp)(x)-ht^{\top}\nabla(mp)(x)+\frac{h^{2}}{2}t^{\top}\nabla^{2}(mp)(x)t+o(h^{2})\Big)dt
$$
 
$$
\displaystyle=n\Big(m(x)p(x)+\frac{h^{2}}{2}\mu_{2}(K)\mathrm{tr}\big(\nabla^{2}(mp)(x)\big)+o(h^{2})\Big)
$$
 
$$
\displaystyle=n\Big(m(x)p(x)+\frac{h^{2}\mu_{2}(K)}{2}\big(p\Delta m+m\Delta p+2\nabla m^{\top}\nabla p\big)(x)+o(h^{2})\Big),
$$

where the last step uses the fact that $\mathrm{tr}\big(\nabla^{2}(mp)\big)=p\Delta m+m\Delta p+2\nabla m^{\top}\nabla p$ by the product rule and symmetry of mixed derivatives.

Now expand the ratio $\frac{\mathbb{E}[B_{n}(x)]}{\mathbb{E}[A_{n}(x)]}$ using the identity

$$
\frac{a_{0}+h^{2}a_{2}+o(h^{2})}{b_{0}+h^{2}b_{2}+o(h^{2})}=\frac{a_{0}}{b_{0}}+h^{2}\frac{a_{2}b_{0}-a_{0}b_{2}}{b_{0}^{2}}+o(h^{2}),
$$

with $a_{0}=m(x)p(x)$, $a_{2}=\frac{\mu_{2}(K)}{2}\big(p\Delta m+m\Delta p+2\nabla m^{\top}\nabla p\big)(x)$, $b_{0}=p(x)$, and $b_{2}=\frac{\mu_{2}(K)}{2}\Delta p(x)$. This yields

$$
\displaystyle\frac{\mathbb{E}[B_{n}(x)]}{\mathbb{E}[A_{n}(x)]}
$$
 
$$
\displaystyle=m(x)+\frac{h^{2}\mu_{2}(K)}{2}\frac{\big(p\Delta m+m\Delta p+2\nabla m^{\top}\nabla p\big)p-mp\Delta p}{p^{2}}\Big|_{x}+o(h^{2})
$$
 
$$
\displaystyle=m(x)+\frac{h^{2}\mu_{2}(K)}{2}\Big(\Delta m(x)+2\nabla m(x)^{\top}\frac{\nabla p(x)}{p(x)}\Big)+o(h^{2}),
$$

which recovers our statement. *Variance.* Linearize $\mathaccent 866{m}(x)=B_{n}(x)/A_{n}(x)$ around $(\mathbb{E}[B_{n}(x)],\mathbb{E}[A_{n}(x)])$ and use independence. To leading order,

$$
\mathrm{Var}[\mathaccent 866{m}(x)]\approx\frac{\mathrm{Var}[B_{n}(x)]}{(\mathbb{E}[A_{n}(x)])^{2}}.
$$

Compute

$$
\displaystyle\mathrm{Var}[B_{n}(x)]
$$
 
$$
\displaystyle=\sumop\slimits@_{i=1}^{n}\mathrm{Var}\big(K_{h}(x-X_{i})Y_{i}\big)\quad\text{(independence)}
$$
 
$$
\displaystyle=n\mathbb{E}\big[K_{h}(x-X)^{2}\mathrm{Var}(Y\mid X)\big]=n\mathbb{E}\big[K_{h}(x-X)^{2}v(X)\big]
$$
 
$$
\displaystyle=n\intslop\ilimits@h^{-2d}K\Big(\frac{x-u}{h}\Big)^{2}v(u)p(u)du
$$
 
$$
\displaystyle=nh^{-d}\intslop\ilimits@K(t)^{2}v(x-ht)p(x-ht)dt=nh^{-d}\Big(R(K)v(x)p(x)+o(1)\Big),
$$

while

$$
\mathbb{E}[A_{n}(x)]=n\big(p(x)+o(1)\big).
$$

Therefore,

$$
\mathrm{Var}[\mathaccent 866{m}(x)]\approx\frac{nh^{-d}R(K)v(x)p(x)}{n^{2}p(x)^{2}}=\frac{R(K)}{nh^{d}}\frac{v(x)}{p(x)}+o\big((nh^{d})^{-1}\big),
$$

completing the proof. ∎

### B.6  Proof of Equation˜6 to Equation˜7

###### Proof.

Let $\bar{\mathbf{z}}=\frac{1}{V_{g}}\sumop\slimits@_{v=1}^{V_{g}}\mathbf{z}_{n,v}$ denote the mean of the first $V_{g}$ vectors.

We prove that:

$$
\frac{1}{V_{g}}\sumop\slimits@_{v=1}^{V_{g}}\frac{1}{V}\sumop\slimits@_{v^{\prime}=1}^{V}\|\mathbf{z}_{n,v}-\mathbf{z}_{n,v^{\prime}}\|_{2}^{2}=\frac{1}{V}\sumop\slimits@_{v^{\prime}=1}^{V}\left\|\bar{\mathbf{z}}-\mathbf{z}_{n,v^{\prime}}\right\|_{2}^{2}
$$

Expanding the left-hand side:

$$
\displaystyle=\frac{1}{V_{g}V}\sumop\slimits@_{v=1}^{V_{g}}\sumop\slimits@_{v^{\prime}=1}^{V}\|\mathbf{z}_{n,v}-\mathbf{z}_{n,v^{\prime}}\|_{2}^{2}
$$
 
$$
\displaystyle=\frac{1}{V_{g}V}\sumop\slimits@_{v=1}^{V_{g}}\sumop\slimits@_{v^{\prime}=1}^{V}\left(\|\mathbf{z}_{n,v}\|_{2}^{2}-2\mathbf{z}_{n,v}^{T}\mathbf{z}_{n,v^{\prime}}+\|\mathbf{z}_{n,v^{\prime}}\|_{2}^{2}\right)
$$
 
$$
\displaystyle=\frac{1}{V_{g}}\sumop\slimits@_{v=1}^{V_{g}}\|\mathbf{z}_{n,v}\|_{2}^{2}-\frac{2}{V_{g}V}\sumop\slimits@_{v=1}^{V_{g}}\sumop\slimits@_{v^{\prime}=1}^{V}\mathbf{z}_{n,v}^{T}\mathbf{z}_{n,v^{\prime}}+\frac{1}{V}\sumop\slimits@_{v^{\prime}=1}^{V}\|\mathbf{z}_{n,v^{\prime}}\|_{2}^{2}
$$
 
$$
\displaystyle=\frac{1}{V_{g}}\sumop\slimits@_{v=1}^{V_{g}}\|\mathbf{z}_{n,v}\|_{2}^{2}-\frac{2}{V}\bar{\mathbf{z}}^{T}\sumop\slimits@_{v^{\prime}=1}^{V}\mathbf{z}_{n,v^{\prime}}+\frac{1}{V}\sumop\slimits@_{v^{\prime}=1}^{V}\|\mathbf{z}_{n,v^{\prime}}\|_{2}^{2}
$$

Expanding the right-hand side:

$$
\displaystyle=\frac{1}{V}\sumop\slimits@_{v^{\prime}=1}^{V}\left(\|\bar{\mathbf{z}}\|_{2}^{2}-2\bar{\mathbf{z}}^{T}\mathbf{z}_{n,v^{\prime}}+\|\mathbf{z}_{n,v^{\prime}}\|_{2}^{2}\right)
$$
 
$$
\displaystyle=\|\bar{\mathbf{z}}\|_{2}^{2}-\frac{2}{V}\bar{\mathbf{z}}^{T}\sumop\slimits@_{v^{\prime}=1}^{V}\mathbf{z}_{n,v^{\prime}}+\frac{1}{V}\sumop\slimits@_{v^{\prime}=1}^{V}\|\mathbf{z}_{n,v^{\prime}}\|_{2}^{2}
$$

To complete the proof, we verify that:

$$
\frac{1}{V_{g}}\sumop\slimits@_{v=1}^{V_{g}}\|\mathbf{z}_{n,v}\|_{2}^{2}=\|\bar{\mathbf{z}}\|_{2}^{2}
$$

Expanding the right-hand side:

$$
\displaystyle\|\bar{\mathbf{z}}\|_{2}^{2}
$$
 
$$
\displaystyle=\left\|\frac{1}{V_{g}}\sumop\slimits@_{v=1}^{V_{g}}\mathbf{z}_{n,v}\right\|_{2}^{2}
$$
 
$$
\displaystyle=\frac{1}{V_{g}^{2}}\sumop\slimits@_{v=1}^{V_{g}}\sumop\slimits@_{v^{\prime\prime}=1}^{V_{g}}\mathbf{z}_{n,v}^{T}\mathbf{z}_{n,v^{\prime\prime}}
$$
 
$$
\displaystyle=\frac{1}{V_{g}}\sumop\slimits@_{v=1}^{V_{g}}\|\mathbf{z}_{n,v}\|_{2}^{2}
$$

Therefore, LHS = RHS, completing the proof. ∎

### B.7  Proof of Section˜A.2

###### Proof.

For each $x$,

$$
\mathrm{Bias}[\mathaccent 866{m}(x)]=\frac{h^{2}\mu_{2}(K)}{2}\Big(\Delta m(x)+2\nabla m(x)^{\top}\nabla\log p(x)\Big)+o(h^{2}).
$$

Square and integrate against $p(x)$:

$$
\displaystyle\mathcal{B}^{2}(h;p,m)
$$
 
$$
\displaystyle=\Big(\frac{h^{2}\mu_{2}(K)}{2}\Big)^{2}\intslop\ilimits@\Big(\Delta m(x)+2\nabla m(x)^{\top}\nabla\log p(x)\Big)^{2}p(x)dx+o(h^{4})
$$
 
$$
\displaystyle\leq\Big(\frac{h^{2}\mu_{2}(K)}{2}\Big)^{2}\intslop\ilimits@\Big(2(\Delta m(x))^{2}+2(2\nabla m(x)^{\top}\nabla\log p(x))^{2}\Big)p(x)dx+o(h^{4})
$$
 
$$
\displaystyle=\Big(\frac{h^{2}\mu_{2}(K)}{2}\Big)^{2}\Big(2\intslop\ilimits@(\Delta m(x))^{2}p(x)dx+8\intslop\ilimits@(\nabla m(x)^{\top}\nabla\log p(x))^{2}p(x)dx\Big)+o(h^{4}),
$$

where we used $(a+b)^{2}\leq 2a^{2}+2b^{2}$ pointwise. Since $|\Delta m(x)|\leq B$ for all $x$, we have

$$
\intslop\ilimits@(\Delta m)^{2}p\leq\intslop\ilimits@B^{2}p=B^{2}.
$$

For the second term, first use Cauchy–Schwarz and then integrate against $p(x)$ to obtain

$$
\displaystyle(\nabla m(x)^{\top}\nabla\log p(x))^{2}\leq\|\nabla m(x)\|^{2}\|\nabla\log p(x)\|^{2}\leq L^{2}\|\nabla\log p(x)\|^{2}
$$
 
$$
\displaystyle\implies\intslop\ilimits@(\nabla m(x)^{\top}\nabla\log p(x))^{2}p(x)dx\leq L^{2}\intslop\ilimits@\|\nabla\log p(x)\|^{2}p(x)dx=L^{2}J(p).
$$

which can be combined with the bounds above to obtain the desired result. We similarly have for the integrated variance

$$
\displaystyle\mathcal{V}(h;p)
$$
 
$$
\displaystyle=\intslop\ilimits@\Big(\frac{R(K)}{nh^{d}}\frac{v(x)}{p(x)}+o\big((nh^{d})^{-1}\big)\Big)p(x)dx=\frac{R(K)}{nh^{d}}\intslop\ilimits@v(x)dx+o\big((nh^{d})^{-1}\big),
$$

which is independent of $p$. ∎

### B.8  Proof of Section˜4.1

###### Proof.

We first start by reminding the reader about the original Cramér-Wold theorem that is a function of all possible directions (not unit-norm ones).

<svg height="69.01" id="A2.SS8.p2.pic1" overflow="visible" version="1.1" viewBox="0 0 600 69.01" width="600"><g fill="#000000" stroke="#000000" stroke-width="0.4pt" style="--ltx-stroke-color:#000000;--ltx-fill-color:#000000;" transform="translate(0,69.01) matrix(1 0 0 -1 0 0)"><g fill="#590000" fill-opacity="1.0" style="--ltx-fill-color:#590000;"><path d="M 0 5.91 L 0 63.1 C 0 66.36 2.64 69.01 5.91 69.01 L 594.09 69.01 C 597.36 69.01 600 66.36 600 63.1 L 600 5.91 C 600 2.64 597.36 0 594.09 0 L 5.91 0 C 2.64 0 0 2.64 0 5.91 Z" style="stroke:none"></path></g><g fill="#FFF2F2" fill-opacity="1.0" style="--ltx-fill-color:#FFF2F2;"><path d="M 1.97 5.91 L 1.97 48.47 L 598.03 48.47 L 598.03 5.91 C 598.03 3.73 596.27 1.97 594.09 1.97 L 5.91 1.97 C 3.73 1.97 1.97 3.73 1.97 5.91 Z" style="stroke:none"></path></g><g fill-opacity="1.0" transform="matrix(1.0 0.0 0.0 1.0 9.26 55.28)"><foreignObject color="#FFFFFF" height="13.84" overflow="visible" style="--ltx-fg-color:#FFFFFF;--fo_width :42.02em;--fo_height:0.75em;--fo_depth :0.25em;" transform="matrix(1 0 0 -1 0 10.38)" width="581.48"><span style="width:36.54em;"><span id="A2.SS8.p2.pic1.p1">Theorem&nbsp;10:&nbsp;Cramér-Wold <cite>cramer1936some</cite> </span></span></foreignObject></g><g fill-opacity="1.0" transform="matrix(1.0 0.0 0.0 1.0 9.26 11.36)"><foreignObject color="#000000" height="31.92" overflow="visible" style="--ltx-fg-color:#000000;--fo_width :42.02em;--fo_height:2.01em;--fo_depth :0.29em;" transform="matrix(1 0 0 -1 0 27.85)" width="581.48"><span style="width:45.43em;"><span style="font-size:90%;">Let <math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="X"><semantics><mi>X</mi> <annotation encoding="application/x-tex">X</annotation></semantics></math> and <math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="Y"><semantics><mi>Y</mi> <annotation encoding="application/x-tex">Y</annotation></semantics></math> be random vectors in <math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="\mathbb{R}^{D}"><semantics><msup><mi>R</mi> <mi>D</mi></msup> <annotation encoding="application/x-tex">\mathbb{R}^{D}</annotation></semantics></math>:</span> <span id="A6.EGx41"><span id="A2.E27"><math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="\displaystyle X\overset{d}{=}Y\iff\langle X,a\rangle\overset{d}{=}\langle Y,a\rangle,\forall{\bm{a}}\in\mathbb{R}^{D}."><semantics><mrow><mrow><mrow><mi mathsize="0.900em">X</mi> <mo lspace="0em" rspace="0em"></mo><mover accent="true"><mo mathsize="0.900em">=</mo> <mo mathsize="0.900em">𝑑</mo></mover> <mo lspace="0em" rspace="0em"></mo><mi mathsize="0.900em">Y</mi></mrow> <mo mathsize="0.900em" stretchy="false">⇔</mo> <mrow><mrow><mrow><mrow><mo maxsize="0.900em" minsize="0.900em" stretchy="true">⟨</mo> <mi mathsize="0.900em">X</mi><mo mathsize="0.900em">,</mo><mi mathsize="0.900em">a</mi> <mo maxsize="0.900em" minsize="0.900em" stretchy="true">⟩</mo></mrow> <mo lspace="0em" rspace="0em"></mo><mover accent="true"><mo mathsize="0.900em">=</mo> <mo mathsize="0.900em">𝑑</mo></mover> <mo lspace="0em" rspace="0em"></mo><mrow><mo maxsize="0.900em" minsize="0.900em" stretchy="true">⟨</mo> <mi mathsize="0.900em">Y</mi><mo mathsize="0.900em">,</mo><mi mathsize="0.900em">a</mi> <mo maxsize="0.900em" minsize="0.900em" stretchy="true">⟩</mo></mrow></mrow><mo mathsize="0.900em">,</mo><mi mathsize="0.900em">𝒂</mi></mrow> <mo mathsize="0.900em">∈</mo> <msup><mi mathsize="0.900em">R</mi> <mi mathsize="0.900em">D</mi></msup></mrow></mrow><mo lspace="0em" mathsize="0.900em">.</mo></mrow><annotation encoding="application/x-tex">\displaystyle X\overset{d}{=}Y\iff\langle X,a\rangle\overset{d}{=}\langle Y,a\rangle,\forall{\bm{a}}\in\mathbb{R}^{D}.</annotation></semantics></math> <span rowspan="1"><span style="--ltx-fg-color:#000000;">(27)</span></span></span></span></span></foreignObject></g></g></svg>

Our proof will follow the same proof as for Section˜B.8. Necessity is immediate: if $X\stackrel{{\scriptstyle d}}{{=}}Y$, then every measurable function of $X$ has the same distribution as the corresponding function of $Y$, from which the linear mapping $x\mapsto\langle u,x\rangle$ for $u\in\mathbb{S}^{d-1}$ is a special case. For sufficiency, assume $\langle u,X\rangle\stackrel{{\scriptstyle d}}{{=}}\langle u,Y\rangle$ for all $u\in\mathbb{S}^{d-1}$. Let $\varphi_{X}(t):=\mathbb{E}\big[e^{i\langle t,X\rangle}\big]$ and $\varphi_{Y}(t):=\mathbb{E}\big[e^{i\langle t,Y\rangle}\big]$ denote the characteristic functions of $X$ and $Y$. Fix an arbitrary $t\in\mathbb{R}^{d}$; if $t=0$, then $\varphi_{X}(0)=\varphi_{Y}(0)=1$. If $t\neq 0$, write $t=su$ with $s:=\|t\|>0$ and $u:=t/\|t\|\in\mathbb{S}^{d-1}$. By the assumption, $\langle u,X\rangle\stackrel{{\scriptstyle d}}{{=}}\langle u,Y\rangle$, hence for this $u$ and $s$ we have

$$
\varphi_{X}(t)\;=\;\mathbb{E}\big[e^{i\langle t,X\rangle}\big]\;=\;\mathbb{E}\big[e^{is\langle u,X\rangle}\big]\;=\;\mathbb{E}\big[e^{is\langle u,Y\rangle}\big]\;=\;\mathbb{E}\big[e^{i\langle t,Y\rangle}\big]\;=\;\varphi_{Y}(t).
$$

Thus $\varphi_{X}(t)=\varphi_{Y}(t)$ for all $t\in\mathbb{R}^{d}$, i.e., $\varphi_{X}\equiv\varphi_{Y}$ on $\mathbb{R}^{d}$. By the uniqueness theorem for characteristic functions, this implies $X\stackrel{{\scriptstyle d}}{{=}}Y$. (ii) Define $\psi_{n,t}:=\mathbb{E}\big[e^{i\langle t,X_{n}\rangle}\big]$ and $\psi_{t}:=\mathbb{E}\big[e^{i\langle t,X\rangle}\big]$. Fix $t\in\mathbb{R}^{d}$ and decompose $t=su$ with $s:=\|t\|\geq 0$ and $u\in\mathbb{S}^{d-1}$ (take, e.g., $u=t/\|t\|$ if $t\neq 0$, and any $u$ if $t=0$). The map $g_{s}:\mathbb{R}\to\mathbb{R}$, $g_{s}(x)=sx$, is continuous. By the continuous mapping theorem applied to the real-valued random variables $\langle u,X_{n}\rangle\xrightarrow{d}\langle u,X\rangle$, we obtain

$$
\langle t,X_{n}\rangle\;=\;s\langle u,X_{n}\rangle\xrightarrow{d}s\langle u,X\rangle\;=\;\langle t,X\rangle.
$$

Hence, for every fixed $t\in\mathbb{R}^{d}$, the one-dimensional projections satisfy $\langle t,X_{n}\rangle\xrightarrow{d}\langle t,X\rangle$, which in turn yields pointwise convergence of characteristic functions:

$$
\psi_{n,t}\;=\;\mathbb{E}\big[e^{i\langle t,X_{n}\rangle}\big]\;\longrightarrow\;\mathbb{E}\big[e^{i\langle t,X\rangle}\big]\;=\;\psi_{t},\qquad\text{for all }t\in\mathbb{R}^{d}.
$$

Therefore, by Lévy’s continuity theorem, $X_{n}\xrightarrow{d}X$. This completes the proof. ∎

### B.9  Proof of Section˜4.1

###### Proof.

We first formulate the following assumptions required for the proof–all of this are satisfied by typical univariate statistical tests.

$P=Q$ if and only if $P_{a}=Q_{a}$ for all $a\in S^{d-1}$ (population-level equivalence of laws).

$A_{n}$ are finite sets with mesh $\Delta(A_{n}):=\sup_{u\in S^{d-1}}\min_{a\in A_{n}}\|u-a\|\to 0$ as $n\to\infty$.

If $P\neq Q$, there exists a separating direction $a^{\star}\in S^{d-1}$ and a neighborhood $U$ of $a^{\star}$ such that

$$
\inf_{a\in U}\lim_{n\to\infty}\Pr\big(T_{a,n}\geq u_{n}(\alpha)\big)=1.
$$

(Intuitively: near a truly separating direction, the 1D statistic eventually exceeds the global null threshold with probability $\to 1$.)

(i) Under $H_{0}:P=Q$, our assumption implies no separating direction exists at the population level, and the calibration of $u_{n}(\alpha)$ ensures $\Pr(M_{n}\geq u_{n}(\alpha))\leq\alpha$ for all $n$, hence $\limsup_{n\to\infty}\Pr({}_{n}=1)\leq\alpha$. (ii) Suppose $P\neq Q$. Our assumption guarantees that there exists at least one separating direction $a^{\star}$ with $P_{a^{\star}}\neq Q_{a^{\star}}$. Our assumption guarantees a neighborhood $U$ of $a^{\star}$ in which the projection statistics exceed the global null threshold with probability tending to 1:

$$
\inf_{a\in U}\lim_{n\to\infty}\Pr\big(T_{a,n}\geq u_{n}(\alpha)\big)\;=\;1.
$$

By assumption, for all large $n$ the set $A_{n}$ contains at least one direction $a_{n}\in U$ (dense coverage). Therefore,

$$
\Pr({}_{n}=1)\;=\;\Pr\big(M_{n}\geq u_{n}(\alpha)\big)\;\geq\;\Pr\big(T_{a_{n},n}\geq u_{n}(\alpha)\big)\;\longrightarrow\;1,
$$

which proves consistency. ∎

### B.10  Proof of Section˜4.3

###### Proof.

For each case, consider the function $g(a)$ on $\mathbb{S}^{D-1}$ defined by the quantity of interest (CF, CDF, or moment) at a fixed $t$ or $k$. Since $f\in H^{\alpha}(\mathbb{R}^{D})$, the mapping $a\mapsto g(a)$ is in $H^{\alpha}(\mathbb{S}^{D-1})$ for each fixed $t$ or $k$.

Given $M$ samples $\{a_{i}\}_{i=1}^{M}$ on the sphere, the best possible reconstruction of $g$ from its values at these points is given by spherical interpolation. By classical results on Sobolev spaces and spherical harmonics (see, e.g., narcowich2006localized), the $L^{2}$ interpolation error for functions in $H^{\alpha}(\mathbb{S}^{D-1})$ using $M$ points is bounded by

$$
\mathbb{E}_{b}\left[|g(b)-g^{*}(b)|^{2}\right]\leq C(D,\alpha)M^{-2\alpha/(D-1)}\|g\|_{H^{\alpha}(\mathbb{S}^{D-1})}^{2},
$$

where $g^{*}$ is the interpolant matching $g$ at the $M$ sampled points. The interpolation error bound on the sphere follows from the theory of spherical harmonics and Marcinkiewicz–Zygmund (MZ) inequalities. Any $f\in H^{\alpha}(\mathbb{S}^{d})$ admits a spherical harmonics expansion, and the best $L^{2}$ approximation by harmonics of degree at most $L$ satisfies

$$
\|f-P_{L}f\|_{L^{2}(\mathbb{S}^{d})}\leq(1+L^{2})^{-\alpha/2}\|f\|_{H^{\alpha}(\mathbb{S}^{d})},
$$

where $P_{L}f$ is the projection onto harmonics of degree $\leq L$ \[narcowich2006localized, Lemma 2.1\]. If $M$ points are distributed quasi-uniformly on $\mathbb{S}^{d}$, then for $L\sim cM^{1/d}$, the set forms a Marcinkiewicz–Zygmund (MZ) set for degree $L$ \[mhaskar2001spherical, Theorem 1.1\]. This allows reconstruction of any function in the space of harmonics of degree at most $L$ from its values at these points, and the $L^{2}$ interpolation error for $f$ is bounded by

$$
\|f-I_{M}f\|_{L^{2}(\mathbb{S}^{d})}\leq C(1+L^{2})^{-\alpha/2}\|f\|_{H^{\alpha}(\mathbb{S}^{d})},
$$

where $I_{M}f$ is any interpolant matching $f$ at the $M$ points \[narcowich2006localized, Theorem 3.1\]. Substituting $L\sim cM^{1/d}$ yields the rate $M^{-\alpha/d}$, and thus

$$
\mathbb{E}_{\omega}|f(\omega)-I_{M}f(\omega)|^{2}\leq C(d,\alpha)M^{-2\alpha/d}\|f\|_{H^{\alpha}(\mathbb{S}^{d})}^{2},
$$

with explicit $C(d,\alpha)$ as in the main theorem. Integrating (or summing) over $t$ (for CF and CDF) or $k$ (for moments, with weights $w_{k}$) yields the stated bounds. The explicit constant $C(D,\alpha)$ arises from the theory of spherical Sobolev spaces and is given above.

For the moment case, the sum over $k$ is weighted to ensure convergence, as higher moments may grow rapidly. The weights $w_{k}$ can be chosen, for example, as $w_{k}=1/k!$.

This completes the proof. ∎

### B.11  Proof of Section˜4.2.1

Pick distinct $x_{0},\dots,x_{K+1}\in\mathbb{R}$ and consider the linear map $A:\mathbb{R}^{K+2}\to\mathbb{R}^{K+1}$, $(Ap)_{r}=\sumop\slimits@_{j=0}^{K+1}p_{j}x_{j}^{r}$ for $r=0,\dots,K$. Then $\mathrm{rank}(A)\leq K+1$, so $\ker(A)\neq\{0\}$. Let $v\in\ker(A)\setminus\{0\}$; from $(Ap)_{0}=\sumop\slimits@_{j}p_{j}$, we get $\sumop\slimits@_{j}v_{j}=0$, hence $v$ has positive and negative entries. Choose a strictly positive probability vector $p$ and $\varepsilon>0$ small such that $p^{\pm}:=p\pm\varepsilon v$ remain probability vectors. Then $Ap^{+}=Ap^{-}$, so the distributions supported on $\{x_{j}\}$ with masses $p^{\pm}$ are distinct yet match moments up to order $K$.

### B.12  Proof of Section˜4.2.3

###### Proof.

Fix the Gaussian weight

$$
w_{s}(t)=e^{-s^{2}t^{2}},\qquad s>0,
$$

and define the population CF distance

$$
D(P,G)=\intslop\ilimits@_{\mathbb{R}}w_{s}(t)\big|\varphi_{P}(t)-\varphi_{G}(t)\big|^{2}dt.
$$

Let the empirical CF be

$$
\mathaccent 866{\varphi}_{N}(t)=\frac{1}{N}\sumop\slimits@_{i=1}^{N}e^{itX_{i}},
$$

and consider the V-statistic estimator

$$
\mathaccent 866{D}_{V}=\intslop\ilimits@_{\mathbb{R}}w_{s}(t)\big|\mathaccent 866{\varphi}_{N}(t)-\varphi_{G}(t)\big|^{2}dt.
$$

We use only that $|e^{itX}|=1$, $|\varphi_{P}(t)|\leq 1$, $|\varphi_{G}(t)|\leq 1$, and integrability of $w_{s}$. For each $i$ differentiate under the integral (dominated convergence applies because the integrand and its derivative are bounded)

$$
\displaystyle\frac{\partial\mathaccent 866{D}_{V}}{\partial X_{i}}=
$$
 
$$
\displaystyle\intslop\ilimits@_{\mathbb{R}}w_{s}(t)2\Re\!\Big(\big(\mathaccent 866{\varphi}_{N}(t)-\varphi_{G}(t)\big)\overline{\frac{\partial\mathaccent 866{\varphi}_{N}(t)}{\partial X_{i}}}\Big)dt,
$$
$$
\displaystyle\frac{\partial\mathaccent 866{\varphi}_{N}(t)}{\partial X_{i}}=
$$
 
$$
\displaystyle\frac{1}{N}ite^{itX_{i}},
$$

since $|\mathaccent 866{\varphi}_{N}(t)|\leq 1$ and $|\varphi_{G}(t)|\leq 1$,

$$
\displaystyle\left|\frac{\partial\mathaccent 866{D}_{V}}{\partial X_{i}}\right|
$$
 
$$
\displaystyle\leq\frac{2}{N}\intslop\ilimits@w_{s}(t)|t|\big(|\mathaccent 866{\varphi}_{N}(t)|+|\varphi_{G}(t)|\big)dt
$$
 
$$
\displaystyle\leq\frac{4}{N}\intslop\ilimits@w_{s}(t)|t|dt
$$
 
$$
\displaystyle=\frac{4}{Ns^{2}},
$$

using $\intslop\ilimits@_{\mathbb{R}}e^{-s^{2}t^{2}}|t|dt=1/s^{2}$.

$$
\Bigg|\frac{\partial\mathaccent 866{D}_{V}}{\partial X_{i}}\Bigg|\;\leq\;\frac{4}{N}\intslop\ilimits@_{\mathbb{R}}w_{s}(t)|t|dt\;=\;\frac{4}{Ns^{2}}.
$$

Moreover, differentiating once more in $X_{i}$ and using $|\mathaccent 866{\varphi}_{N}(t)|\leq 1$, $|\varphi_{G}(t)|\leq 1$ gives a global Lipschitz bound

$$
\Bigg|\frac{\partial^{2}\mathaccent 866{D}_{V}}{\partial X_{i}^{2}}\Bigg|\;\leq\;\frac{C}{N}\intslop\ilimits@_{\mathbb{R}}w_{s}(t)t^{2}dt\;=\;\frac{C}{N}\cdot\frac{\sqrt{\pi}}{2s^{3}},
$$

for some absolute constant $C$ arising from bounded factors and product rule. Hence ECF gradients are uniformly bounded and Lipschitz, with scale controlled only by $(N,s)$.

(Moment sample-gradients are polynomial in $X_{i}$ and unbounded for $k\geq 2$.) Let $\mathaccent 866{D}_{V}$ be as above. Define the moment objective

$$
\mathaccent 866{D}_{k}\;=\;(\bar{\phi}-\mu)^{\top}W(\bar{\phi}-\mu),\qquad\bar{\phi}:=\frac{1}{N}\sumop\slimits@_{i=1}^{N}\phi(X_{i}),\quad\phi(x)=(x,x^{2},\dots,x^{k})^{\top},
$$

for a symmetric positive semidefinite $W\in\mathbb{R}^{k\times k}$ and Gaussian target moments $\mu=\mathbb{E}_{G}[\phi(Y)]$. For each $i$,

$$
\displaystyle\frac{\partial\mathaccent 866{D}_{k}}{\partial X_{i}}=
$$
 
$$
\displaystyle\frac{2}{N}(\bar{\phi}-\mu)^{\top}W\frac{\partial\phi(X_{i})}{\partial X_{i}},
$$
$$
\displaystyle\frac{\partial\phi(X)}{\partial X}=
$$
 
$$
\displaystyle\big(1,2X,3X^{2},\dots,kX^{k-1}\big)^{\top}.
$$

The gradient formula follows by the chain rule and linearity of $\bar{\phi}$. Let $c:=W(\bar{\phi}-\mu)$ and write $c_{r}$ for its $r$ -th coordinate. Then

$$
\frac{\partial\mathaccent 866{D}_{k}}{\partial X_{i}}=\frac{2}{N}\sumop\slimits@_{r=1}^{k}c_{r}rX_{i}^{r-1},
$$

which is a polynomial in $X_{i}$ of degree $\deg=\max\{r-1:c_{r}\neq 0\}\leq k-1$. In particular, if $c_{k}\neq 0$ (the generic case when the top-weighted deviation is nonzero), then

$$
\left|\frac{\partial\mathaccent 866{D}_{k}}{\partial X_{i}}\right|\;\xrightarrow[|X_{i}|\to\infty]{}\;\infty\quad\text{as}\quad|X_{i}|^{k-1}.
$$

The expression is a nonconstant polynomial in $X_{i}$ of degree $\deg\leq k-1$ whenever some $c_{r}\neq 0$ with $r\geq 2$. Thus the gradient cannot be uniformly bounded on $\mathbb{R}$. If $c_{k}\neq 0$, the leading term dominates and the magnitude grows like $|X_{i}|^{k-1}$, proving unboundedness for $k\geq 2$. ∎

### B.13  Proof of Section˜5.1

###### Proof.

A direct calculation shows Fix $t\in\mathbb{R}^{d}$ and abbreviate $Z_{j}\coloneqq e^{\mathrm{i}t^{\top}X_{j}}$, so that $\phi_{n}(t)=\frac{1}{n}\sumop\slimits@_{j=1}^{n}Z_{j}$. Note that $|Z_{j}|=1$ almost surely (since $t^{\top}X_{j}\in\mathbb{R}$), and $\mathbb{E}[Z_{j}]=\phi_{\theta}(t)$ for all $j$. We start from the algebraic identity

$$
\big|\phi_{n}(t)-\psi(t)\big|^{2}=\phi_{n}(t)\overline{\phi_{n}(t)}-\psi(t)\overline{\phi_{n}(t)}-\overline{\psi(t)}\phi_{n}(t)+\big|\psi(t)\big|^{2}.
$$

Taking expectations term by term gives

$$
\displaystyle\mathbb{E}\left[\big|\phi_{n}-\psi\big|^{2}\right]=
$$
 
$$
\displaystyle\mathbb{E}\left[|\phi_{n}|^{2}\right]-\psi\mathbb{E}\left[\overline{\phi_{n}}\right]-\overline{\psi}\mathbb{E}\left[\phi_{n}\right]+|\psi|^{2},
$$
$$
\displaystyle=
$$
 
$$
\displaystyle\mathbb{E}\left[|\phi_{n}|^{2}\right]-\psi\overline{\mathbb{E}[\phi_{n}]}-\overline{\psi}\frac{1}{n}\sumop\slimits@_{j=1}^{n}\mathbb{E}[Z_{j}]+|\psi|^{2},
$$
$$
\displaystyle=
$$
 
$$
\displaystyle\mathbb{E}\left[|\phi_{n}|^{2}\right]-\psi\overline{\phi_{\theta}}-\overline{\psi}\phi_{\theta}+|\psi|^{2},
$$
$$
\displaystyle=
$$
 
$$
\displaystyle\mathbb{E}\left[|\phi_{n}|^{2}\right]-2\mathrm{Re}\big(\overline{\psi}\phi_{\theta}\big)+|\psi|^{2},
$$
$$
\displaystyle=
$$
 
$$
\displaystyle\mathbb{E}\left[\left|\frac{1}{n}\sumop\slimits@_{j=1}^{n}Z_{j}\right|^{2}\right]-2\mathrm{Re}\big(\overline{\psi}\phi_{\theta}\big)+|\psi|^{2},
$$
$$
\displaystyle=
$$
 
$$
\displaystyle\frac{1}{n^{2}}\sumop\slimits@_{j=1}^{n}\sumop\slimits@_{l=1}^{n}\mathbb{E}\left[Z_{j}\overline{Z_{l}}\right]-2\mathrm{Re}\big(\overline{\psi}\phi_{\theta}\big)+|\psi|^{2},
$$

Since the $Z_{j}$ are i.i.d.,

$$
\mathbb{E}\left[Z_{j}\overline{Z_{l}}\right]=\begin{cases}\mathbb{E}\left[|Z_{1}|^{2}\right]=1,&\text{if }j=l,\\[4.0pt]
\mathbb{E}[Z_{j}]\overline{\mathbb{E}[Z_{l}]}=\phi_{\theta}\overline{\phi_{\theta}}=|\phi_{\theta}|^{2},&\text{if }j\neq l,\end{cases}
$$

hence

$$
\displaystyle\mathbb{E}\left[|\phi_{n}|^{2}\right]=
$$
 
$$
\displaystyle\frac{1}{n^{2}}\Big(n+n(n-1)|\phi_{\theta}|^{2}\Big)
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\frac{1}{n}+\left(1-\frac{1}{n}\right)|\phi_{\theta}|^{2}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle|\phi_{\theta}|^{2}+\frac{1-|\phi_{\theta}|^{2}}{n}
$$

Plugging these, we obtain

$$
\displaystyle\mathbb{E}\left[\big|\phi_{n}-\psi\big|^{2}\right]
$$
 
$$
\displaystyle=\left(|\phi_{\theta}|^{2}+\frac{1-|\phi_{\theta}|^{2}}{n}\right)-2\mathrm{Re}\big(\overline{\psi}\phi_{\theta}\big)+|\psi|^{2}
$$
 
$$
\displaystyle=\big(|\phi_{\theta}|^{2}-2\mathrm{Re}\big(\overline{\psi}\phi_{\theta}\big)+|\psi|^{2}\big)+\frac{1-|\phi_{\theta}|^{2}}{n}
$$
 
$$
\displaystyle=\big|\phi_{\theta}-\psi\big|^{2}+\frac{1-|\phi_{\theta}|^{2}}{n}.
$$

Under Dominated convergence, $\mathbb{E}[\nabla_{\theta}D_{n}(t)]=\nabla_{\theta}\mathbb{E}[D_{n}(t)]$, hence

$$
\mathbb{E}\left[\nabla_{\theta}D_{n}(t)\right]=\nabla_{\theta}\big|\phi_{\theta}(t)-\psi(t)\big|^{2}+\nabla_{\theta}\frac{1-|\phi_{\theta}(t)|^{2}}{n},
$$

concluding the proof.

In practice one replaces $\intslop\ilimits@_{\mathbb{R}}w(t)(\cdot)dt$ by a deterministic quadrature on a uniform grid $t_{k}\in[-T,T]$ with weights $\omega_{k}$ (e.g. trapezoidal rule) and a Gaussian window $w(t)=e^{-\alpha t^{2}}$. All statements above remain valid with the integral replaced by $\sumop\slimits@_{k}\omega_{k}(\cdot)$:

$$
L(\theta)\approx\sumop\slimits@_{k}\omega_{k}\big|\phi_{\theta}(t_{k})-\psi(t_{k})\big|^{2},\quad\mathaccent 866{L}_{n}(\theta)\approx\sumop\slimits@_{k}\omega_{k}\big|\phi_{n}(t_{k})-\psi(t_{k})\big|^{2},
$$

and the bias term becomes

$$
\text{Bias}(\theta)=-\frac{1}{n}\sumop\slimits@_{k}\omega_{k}\nabla_{\theta}\big|\phi_{\theta}(t_{k})\big|^{2}.
$$

Since the grid and weights are deterministic, they do not affect unbiasedness with respect to sampling; they only introduce a deterministic approximation error to the target functional $L(\theta)$.

∎

### B.14  Proof of VICReg’s Recovery

###### Proof.

We prove this result in two parts.

##### Part I: E\[𝐗\]=𝟎\\mathbb{E}\[\\mathbf{X}\]=\\mathbf{0}

Given that $\mathbb{E}[\langle\mathbf{X},\mathbf{a}\rangle]=0$ for all unit vectors $\mathbf{a}$, and noting that $\langle\mathbf{X},\mathbf{a}\rangle=\mathbf{a}^{T}\mathbf{X}$, we have:

$$
\mathbb{E}[\mathbf{a}^{T}\mathbf{X}]=0\quad\text{for all }\mathbf{a}\in\mathbb{R}^{d}\text{ with }\|\mathbf{a}\|=1
$$

By linearity of expectation:

$$
\mathbf{a}^{T}\mathbb{E}[\mathbf{X}]=0\quad\text{for all unit vectors }\mathbf{a}
$$

Let $\bm{\mu}=\mathbb{E}[\mathbf{X}]$. We claim that $\bm{\mu}=\mathbf{0}$. Suppose, for the sake of contradiction, that $\bm{\mu}\neq\mathbf{0}$. Then $\|\bm{\mu}\|_{2}>0$. Define the unit vector:

$$
\mathbf{a}^{*}=\frac{\bm{\mu}}{\|\bm{\mu}\|_{2}}
$$

Since $\mathbf{a}^{*}$ is a unit vector, equation (35) implies:

$$
(\mathbf{a}^{*})^{T}\bm{\mu}=0
$$

However, substituting the definition of $\mathbf{a}^{*}$:

$$
(\mathbf{a}^{*})^{T}\bm{\mu}=\left(\frac{\bm{\mu}}{\|\bm{\mu}\|_{2}}\right)^{T}\bm{\mu}=\frac{\bm{\mu}^{T}\bm{\mu}}{\|\bm{\mu}\|_{2}}=\frac{\|\bm{\mu}\|_{2}^{2}}{\|\bm{\mu}\|_{2}}=\|\bm{\mu}\|_{2}>0
$$

This contradiction establishes that $\bm{\mu}=\mathbf{0}$.

##### Part II: Cov(𝐗)=𝐈d\\mathrm{Cov}(\\mathbf{X})=\\mathbf{I}\_{d}

Since $\mathbb{E}[\mathbf{X}]=\mathbf{0}$, we have:

$$
\mathrm{Var}(\langle\mathbf{X},\mathbf{a}\rangle)=\mathbb{E}[(\langle\mathbf{X},\mathbf{a}\rangle)^{2}]=\mathbb{E}[(\mathbf{a}^{T}\mathbf{X})^{2}]
$$

Expanding the quadratic form:

$$
\mathbb{E}[(\mathbf{a}^{T}\mathbf{X})^{2}]=\mathbb{E}[\mathbf{a}^{T}\mathbf{X}\mathbf{X}^{T}\mathbf{a}]=\mathbf{a}^{T}\mathbb{E}[\mathbf{X}\mathbf{X}^{T}]\mathbf{a}
$$

Since $\mathbb{E}[\mathbf{X}]=\mathbf{0}$, the covariance matrix is $\mathrm{Cov}(\mathbf{X})=\mathbb{E}[\mathbf{X}\mathbf{X}^{T}]$. Let $\bm{\Sigma}=\mathrm{Cov}(\mathbf{X})$. The variance condition gives us:

$$
\mathbf{a}^{T}\bm{\Sigma}\mathbf{a}=1\quad\text{for all unit vectors }\mathbf{a}
$$

We now show that $\bm{\Sigma}=\mathbf{I}_{d}$. *Step 1: Diagonal entries.* For $i\in\{1,2,\ldots,d\}$, let $\mathbf{e}_{i}$ denote the $i$ -th standard basis vector. Setting $\mathbf{a}=\mathbf{e}_{i}$ in equation (42):

$$
\mathbf{e}_{i}^{T}\bm{\Sigma}\mathbf{e}_{i}={}_{ii}=1
$$

Therefore, all diagonal entries of equal 1. *Step 2: Off-diagonal entries.* For distinct indices $i,j\in\{1,2,\ldots,d\}$, consider the unit vector:

$$
\mathbf{a}=\frac{\mathbf{e}_{i}+\mathbf{e}_{j}}{\|\mathbf{e}_{i}+\mathbf{e}_{j}\|_{2}}=\frac{\mathbf{e}_{i}+\mathbf{e}_{j}}{\sqrt{2}}
$$

Applying equation (42):

$$
\mathbf{a}^{T}\bm{\Sigma}\mathbf{a}=\frac{1}{2}(\mathbf{e}_{i}+\mathbf{e}_{j})^{T}\bm{\Sigma}(\mathbf{e}_{i}+\mathbf{e}_{j})=1
$$

Expanding the quadratic form and using the symmetry of:

$$
\displaystyle\frac{1}{2}(\mathbf{e}_{i}^{T}\bm{\Sigma}\mathbf{e}_{i}+2\mathbf{e}_{i}^{T}\bm{\Sigma}\mathbf{e}_{j}+\mathbf{e}_{j}^{T}\bm{\Sigma}\mathbf{e}_{j})
$$
 
$$
\displaystyle=1
$$
 
$$
\displaystyle\frac{1}{2}({}_{ii}+2{}_{ij}+{}_{jj})
$$
 
$$
\displaystyle=1
$$
 
$$
\displaystyle\frac{1}{2}(1+2{}_{ij}+1)
$$
 
$$
\displaystyle=1
$$
 
$$
\displaystyle 1+{}_{ij}
$$
 
$$
\displaystyle=1
$$
 
$$
\displaystyle=0
$$

Therefore, all off-diagonal entries of equal zero, establishing that $\bm{\Sigma}=\mathbf{I}_{d}$. ∎

## Appendix C Background

Foundation: The Linear Regression Model We start with the standard linear regression model:

$$
\mathbf{y}=\mathbf{X}\bm{\beta}+\bm{\varepsilon}
$$

where:

- $\mathbf{y}=[y_{1},y_{2},\ldots,y_{n}]^{T}\in\mathbb{R}^{n}$ is the response vector
- $\mathbf{X}\in\mathbb{R}^{n\times p}$ is the design matrix with $\mathbf{X}_{ij}=x_{ij}$
- $\bm{\beta}=[\beta_{1},\beta_{2},\ldots,\beta_{p}]^{T}\in\mathbb{R}^{p}$ is the parameter vector
- $\bm{\varepsilon}=[\varepsilon_{1},\varepsilon_{2},\ldots,\varepsilon_{n}]^{T}\sim\mathcal{N}(\mathbf{0},\sigma^{2}\mathbf{I}_{n})$ is the error vector

The error assumption means:

$$
\mathbb{E}[\varepsilon_{i}]=0,\quad\text{Var}(\varepsilon_{i})=\sigma^{2},\quad\text{Cov}(\varepsilon_{i},\varepsilon_{j})=0\text{ for }i\neq j
$$

Step 1: Deriving the OLS Estimator To find the OLS estimator, we minimize the sum of squared residuals:

$$
\text{SSR}(\bm{\beta})=\sumop\slimits@_{i=1}^{n}(y_{i}-\mathbf{x}_{i}^{T}\bm{\beta})^{2}=(\mathbf{y}-\mathbf{X}\bm{\beta})^{T}(\mathbf{y}-\mathbf{X}\bm{\beta})
$$

Expanding this quadratic form:

$$
\displaystyle\text{SSR}(\bm{\beta})
$$
 
$$
\displaystyle=\mathbf{y}^{T}\mathbf{y}-2\bm{\beta}^{T}\mathbf{X}^{T}\mathbf{y}+\bm{\beta}^{T}\mathbf{X}^{T}\mathbf{X}\bm{\beta}
$$

Taking the derivative with respect to $\bm{\beta}$:

$$
\frac{\partial\text{SSR}}{\partial\bm{\beta}}=-2\mathbf{X}^{T}\mathbf{y}+2\mathbf{X}^{T}\mathbf{X}\bm{\beta}
$$

Setting equal to zero and solving:

$$
-2\mathbf{X}^{T}\mathbf{y}+2\mathbf{X}^{T}\mathbf{X}\bm{\beta}=\mathbf{0}
$$
 
$$
\mathbf{X}^{T}\mathbf{X}\bm{\beta}=\mathbf{X}^{T}\mathbf{y}
$$

Assuming $\mathbf{X}^{T}\mathbf{X}$ is invertible:

$$
\boxed{\hat{\bm{\beta}}=(\mathbf{X}^{T}\mathbf{X})^{-1}\mathbf{X}^{T}\mathbf{y}}
$$

![Refer to caption](https://arxiv.org/html/2511.08544v3/x14.png)

Figure 15: Depiction of the expected BCS loss upper bound ( Section ˜ 4.3 ) for various smoothness values α \\alpha. We clearly see that as the smoothness increases ( blue to red ), as the upper bound decreases more and more rapidly with M.

![Refer to caption](https://arxiv.org/html/2511.08544v3/x15.png)

Figure 16: Reprise of Figure ˜ 6 for additional dimensions and number of 1d projections.

![Refer to caption](https://arxiv.org/html/2511.08544v3/x18.png)

Figure 17: Depiction of the distribution of optimized β \\beta values from OLS when comparing 𝒁 iso {\\bm{Z}}\_{\\rm iso} and aniso {\\bm{Z}}\_{\\rm aniso} from Sections ˜ 3.1. We clearly observe that the anisotropic version ( blue ) provides much lower variance compared to the isotropic case ( red ). We consider a binary classification (linear separable class) ( top row ), a linear regression task ( middle row ), and a nonlinear regression task with smooth targets ( bottom row ). For each case, we resample the training samples numerous times and produce an estimate for each time. Because the data is 2 -dimensional, we can visualize the distribution directly.

![Refer to caption](https://arxiv.org/html/2511.08544v3/x21.png)

Figure 18: Depiction of accuracy ( top ) and cosine similarity between estimated and true estimator ( bottom ) for the OLS setting with varying strength of Tikhonov regularization ( x-axis) comparing isotropic and anisotropic embeddings. As per Section ˜ 5.1, the anisotropic distribution creates a bias in the OLS estimation for nonzero regularization.

![Refer to caption](https://arxiv.org/html/2511.08544v3/x27.png)

Figure 19: Additional figures provides in Figure ˜ 19

Table 3: Performance metrics across different sample sizes from Figure˜12

<table><tbody><tr><td>Freeze Backbone</td><td>Model Name</td><td colspan="7">Samples per Class</td></tr><tr><td></td><td></td><td>All</td><td>1</td><td>2</td><td>5</td><td>10</td><td>100</td><td>1000</td></tr><tr><td rowspan="6">No</td><td colspan="8">LeJEPA (Ours)</td></tr><tr><td>ConvNeXt-V2 Nano</td><td>82.72</td><td>29.42</td><td>36.65</td><td>50.94</td><td>59.85</td><td>75.34</td><td>81.97</td></tr><tr><td>LeViT-128</td><td>79.41</td><td>18.45</td><td>24.08</td><td>33.11</td><td>41.76</td><td>64.59</td><td>77.59</td></tr><tr><td>ResNet-18</td><td>82.15</td><td>23.34</td><td>31.56</td><td>43.82</td><td>54.64</td><td>73.53</td><td>81.41</td></tr><tr><td>ResNet-34</td><td>83.28</td><td>24.27</td><td>31.51</td><td>44.23</td><td>53.95</td><td>74.93</td><td>82.32</td></tr><tr><td colspan="8">Baselines</td></tr><tr><td></td><td>DINOv2 Small</td><td>78.34</td><td>21.05</td><td>21.71</td><td>30.33</td><td>36.23</td><td>60.81</td><td>75.55</td></tr><tr><td></td><td>DINOv3 ViT-S/16</td><td>81.60</td><td>24.71</td><td>29.43</td><td>37.71</td><td>44.71</td><td>69.87</td><td>80.54</td></tr><tr><td rowspan="6">Yes</td><td colspan="8">LeJEPA (Ours)</td></tr><tr><td>ConvNeXt-V2 Nano</td><td>76.52</td><td>28.74</td><td>36.65</td><td>50.60</td><td>59.50</td><td>72.62</td><td>77.24</td></tr><tr><td>LeViT-128</td><td>69.00</td><td>25.85</td><td>33.30</td><td>45.52</td><td>52.43</td><td>64.37</td><td>69.39</td></tr><tr><td>ResNet-18</td><td>75.95</td><td>30.48</td><td>38.22</td><td>50.85</td><td>58.86</td><td>72.70</td><td>76.39</td></tr><tr><td>ResNet-34</td><td>78.17</td><td>31.08</td><td>38.33</td><td>52.26</td><td>60.63</td><td>74.77</td><td>78.62</td></tr><tr><td colspan="8">Baselines</td></tr><tr><td></td><td>DINOv2 Small</td><td>67.62</td><td>27.68</td><td>32.22</td><td>40.72</td><td>47.72</td><td>62.49</td><td>67.89</td></tr><tr><td></td><td>DINOv3 ViT-S/16</td><td>71.38</td><td>30.17</td><td>36.65</td><td>45.74</td><td>51.51</td><td>65.90</td><td>71.35</td></tr></tbody></table>

![Refer to caption](https://arxiv.org/html/2511.08544v3/x33.png)

Figure 20: Proposed trapezoid quadrature for the Epps-Pulley statistic as implemented in LABEL:lst:epps-pulley-pytorch. We depict the approximation error of the integral for various distributions, demonstrate rapid convergence (faster than quadratic show in grey line ) across possible embedding distributions.

![Refer to caption](https://arxiv.org/html/2511.08544v3/x34.png)

Figure 21: Additional figures for Figure ˜ 10.

Table 4: Top 1 accuracy (in %) with LeJEPA pretraining on Imagenet-100 for 400 epochs (All values are percentages)

<table><tbody><tr><td></td><td>backbone</td><td colspan="3">resnet50</td><td colspan="3">vit_small_patch8_224</td><td colspan="3">vit_tiny_patch8_224</td></tr><tr><td></td><td>Projector</td><td>1-layer</td><td>2-layer</td><td>3-layer</td><td>1-layer</td><td>2-layer</td><td>3-layer</td><td>1-layer</td><td>2-layer</td><td>3-layer</td></tr><tr><td>w/ predictor</td><td>w/ SWA</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr><tr><td rowspan="2">False</td><td>False</td><td>79.71</td><td>82.44</td><td>83.93</td><td>76.59</td><td>80.77</td><td>81.07</td><td>71.79</td><td>76.87</td><td>80.37</td></tr><tr><td>True</td><td>79.79</td><td>82.69</td><td>83.50</td><td>79.96</td><td>83.63</td><td>84.12</td><td>75.86</td><td>82.36</td><td>80.50</td></tr><tr><td rowspan="2">True</td><td>False</td><td>79.41</td><td>82.44</td><td>83.57</td><td>77.58</td><td>79.41</td><td>81.91</td><td>67.74</td><td>77.64</td><td>80.73</td></tr><tr><td>True</td><td>78.87</td><td>82.04</td><td>82.82</td><td>77.11</td><td>81.77</td><td>82.58</td><td>69.53</td><td>78.27</td><td>79.77</td></tr></tbody></table>

Table 5: Small architecture in-domain LeJEPA pretraining from random initialization across datasets and architectures, with frozen backbone linear evaluation. First, LeJEPA is able to produce near state-of-the-art performances on tiny dataset with only a thousand samples, e.g., flowers102. Second, on non-natural image data, LeJEPA clearly outperforms the latest frontier vision models, e.g., Galaxy10. See Figure˜12 for additional experiments with varying number of training samples and with full finetuning.

|  | Pretraining | flowers102 | cifar100 | food101 | inet10 | cifar10 | galaxy10 |
| --- | --- | --- | --- | --- | --- | --- | --- |
|  | \# train. samples | 1020 | 50000 | 75750 | 13000 | 50000 | 11008 |
| LeJEPA (convnextv2\_nano) 14M | in-domain | 64.34 | 69.26 | 69.59 | 90.81 | 92.22 | 76.05 |
| LeJEPA (resnet18) 11M | in-domain | 74.57 | 69.94 | 73.57 | 92.36 | 92.51 | 75.32 |
| LeJEPA (resnet34) 21M | in-domain | 71.85 | 70.44 | 74.95 | 92.80 | 93.16 | 77.29 |
| LeJEPA (resnext26ts) 8M | in-domain | 82.19 | 69.10 | 76.77 | 92.82 | 91.59 | 73.78 |
| LeJEPA (swin\_tiny) 27M | in-domain | 63.94 | 65.08 | 78.40 | 92.87 | 92.67 | 74.89 |
| IJEPA-inet22k (ViT-H/14) 630M | inet1k | 85.76 | 86.93 | 81.06 | 98.65 | 97.77 | 62.93 |

Table 6: Time (in millisecond) to compute the proposed SIGReg loss from LABEL:lst:epps-pulley-pytorch on a Tesla V100-SXM2-16GB for varying mini-batch size ($N$), number of slices ($M$), integration points. Results are computed over $10$ runs.

| N | M | \# integrationpoints | mean (ms) | std (ms) |
| --- | --- | --- | --- | --- |
| 512 | 512 | 16 | 0.465236 | 0.011642 |
| 512 | 512 | 64 | 0.461317 | 0.003894 |
| 512 | 512 | 256 | 0.627644 | 0.003337 |
| 2048 | 512 | 16 | 1.406441 | 0.002415 |
| 8192 | 512 | 16 | 6.188304 | 0.007226 |
| 8192 | 8192 | 16 | 8.685009 | 0.038829 |
| 32768 | 512 | 16 | 26.373118 | 0.012732 |
| 512 | 2048 | 16 | 0.465614 | 0.005274 |
| 512 | 8192 | 16 | 0.670379 | 0.006854 |

Table 7: Number of Figure˜8.

<table><tbody><tr><td></td><td colspan="12">resnet50</td></tr><tr><td><math><semantics><mi>λ</mi> <annotation>\lambda</annotation></semantics></math></td><td>0.001</td><td>0.005</td><td>0.010</td><td>0.020</td><td>0.025</td><td>0.050</td><td>0.100</td><td>0.150</td><td>0.200</td><td>0.300</td><td>0.400</td><td>0.500</td></tr><tr><td>#views</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr><tr><td>2</td><td>81.41</td><td>82.73</td><td>83.49</td><td>82.99</td><td>82.23</td><td>-</td><td>-</td><td>-</td><td>-</td><td>-</td><td>-</td><td>-</td></tr><tr><td>4</td><td>79.88</td><td>83.04</td><td>84.36</td><td>84.68</td><td>84.33</td><td>83.00</td><td>82.91</td><td>81.05</td><td>78.58</td><td>-</td><td>-</td><td>-</td></tr><tr><td>8</td><td>76.67</td><td>81.58</td><td>83.59</td><td>83.49</td><td>83.76</td><td>84.32</td><td>83.66</td><td>83.07</td><td>82.16</td><td>81.00</td><td>79.25</td><td>77.72</td></tr></tbody></table>

## Appendix D Details on Low-Discrepancy Sequences

Quasi-Monte Carlo (QMC) methods, such as the Sobol sequence, are widely used to generate low-discrepancy samples in the unit hypercube, providing improved uniformity over purely random sampling. To obtain samples uniformly distributed on the hypersphere, each QMC point is mapped to a standard normal vector via the inverse cumulative distribution function (CDF), and then projected onto the sphere by normalization. This approach leverages the rotational invariance of the multivariate normal distribution, ensuring that the resulting directions are uniformly distributed on the sphere’s surface. While the low-discrepancy property is not strictly preserved under this nonlinear mapping, the resulting samples are empirically more uniform than random samples and are standard in high-dimensional applications marsaglia1972choosing, dick2010digital, caflisch1998monte.

Number of points $N$, dimension $d$ Points $\{\mathbf{y}_{i}\}_{i=1}^{N}$ quasi-uniformly distributed on $\mathbb{S}^{d-1}$ for $i=1$ to $N$ do   Generate $\mathbf{x}_{i}\in[0,1]^{d}$ as the $i$ -th point of a Sobol sequence

  Transform each component: $z_{i,j}={}^{-1}(x_{i,j})$ for $j=1,\ldots,d$ $\triangleright$ <sup>-1</sup> is the inverse CDF of the standard normal

  Normalize: $\mathbf{y}_{i}=\mathbf{z}_{i}/\|\mathbf{z}_{i}\|_{2}$

end for

## Appendix E Shapiro-Wilk Test

Let X1 < X2 <... < Xn denote an ordered random sample of size n from a standard normal distribution. Also, let mÂ 5 (m1,m2,…,mn) be the vector of expected values of standard normal order statistics, and let V 5 (vij ) be the corresponding n 3 n covariance matrix, so that

$$
E\left(X_{i}\right)=m_{i}\quad\text{ and }\quad\operatorname{cov}\left(X_{i},X_{j}\right)=v_{ij},\quad i,j=1,2,\ldots,n
$$

The W test statistic shapiro1965analysis for normality is then denoted by

$$
\begin{array}[]{l}W=\frac{\left(\sumop\slimits@_{i=1}^{n}a_{i}Y_{i}\right)}{\sumop\slimits@_{i=1}^{n}\left(Y_{i}-\bar{Y}\right)^{2}}=\frac{(\mathbf{a}\mathbf{Y})}{S^{2}}\\
\mathbf{a}^{\prime}=\left(a_{1},a_{2},\ldots,a_{n}\right)=\mathbf{m}\mathbf{V}^{-1}\left(\mathbf{m}\mathbf{V}^{-1}\mathbf{V}^{-1}\mathbf{m}\right)^{-1/2}\\
\mathrm{S}^{2}=\sumop\slimits@_{i=1}^{n}\left(Y_{i}-\bar{Y}\right)^{2}\end{array}
$$

shapiro1972approximate suggested replacing the covariance matrix V by the identity matrix I, because for large samples, the observations Yi may be treated as if they are independent (see gupta1952estimation). Another asymptotic extension was suggested by weisburg1975approximate

$$
E\left(X_{i}\right)=m_{i}\approx{}^{-1}\left(\frac{i-\frac{3}{8}}{n+\frac{1}{4}}\right)\quad i=1,2,\ldots,n
$$

building atop elfving1947asymptotical ’s approximation but using $3/8$ instead of $\pi/8$.

rahman1997modification proposed another variation using the approximation for the expected values of order statistics given by blom1958statistical and the approximations for the elements of the variance± covariance matrix given by blom1958statistical, mosteller2006some. These approximations are

$$
E\left(X_{i}\right)=m_{i}\approx{}^{-1}\left(\frac{i}{N+1}\right),\quad i=1,2,\ldots,n
$$
 
$$
\operatorname{cov}\left(X_{i},X_{j}\right)=v_{ij}\approx\frac{p_{i}p_{j}}{(n+2)f\left(m_{i}\right)f\left(m_{j}\right)},\quad i,j=1,2,\ldots,n
$$
 
$$
p_{i}=\frac{i}{n+1}
$$

We know (see hammersley1954estimation, plackett1958linear)

$$
\begin{array}[]{l}\mathbf{V}^{-1}=(n+1)(n+2)\\
\times\left(\begin{array}[]{cccccc}2\phi^{2}\left(m_{1}\right)&-\phi\left(m_{1}\right)\phi\left(m_{2}\right)&0&0&\ldots&0\\
-\phi\left(m_{1}\right)\phi\left(m_{2}\right)&2\phi^{2}\left(m_{2}\right)&-\phi\left(m_{2}\right)\phi\left(m_{3}\right)&0&\ldots&0\\
0&-\phi\left(m_{2}\right)\phi\left(m_{3}\right)&2\phi^{2}\left(m_{3}\right)&-\phi\left(m_{3}\right)\phi\left(m_{4}\right)&\ldots&0\\
\vbox{\kern 6.0pt\hbox{$.$}\hbox{$.$}\hbox{$.$}}&&&&&\\
0&0&0&0&\ldots&2\phi^{2}\left(m_{n}\right)\end{array}\right)\end{array}
$$

## Appendix F Multivariate Statistics

We ideally would like to compare the distributions. One slight variation is to compare the Characteristic function of the distributions. Given samples ${\bm{x}}_{1},\dots,{\bm{x}}_{N}$, the Empirical Characteristic Function (ECF) is defined as

$$
\displaystyle\hat{\psi}_{N}({\bm{t}})=\frac{1}{N}\sumop\slimits@_{n=1}^{N}e^{-i{\bm{t}}^{\top}{\bm{y}}_{n}}.
$$

We can now compare our ECF to the one of the target distribution and build the statistic

$$
\displaystyle N\intslop\ilimits@|\hat{\psi}_{N}({\bm{t}})-\psi_{0}({\bm{t}})|^{2}\omega({\bm{t}})dt=N\intslop\ilimits@|\hat{\psi}_{N}({\bm{t}})-e^{-\|{\bm{t}}\|_{2}/2}|^{2}\omega({\bm{t}})dt,
$$

if the weighting function is given by $\omega({\bm{t}})=(2\pi\beta^{2})^{-d/2}e^{-\frac{\|{\bm{t}}\|_{2}^{2}}{2}}$ then the following simplification can be made

$$
\displaystyle\mathrm{BHEP}_{n,\beta}=
$$
 
$$
\displaystyle\frac{1}{n}\sumop\slimits@_{j,k=1}^{n}\exp\left(-\frac{\beta^{2}\left\|Y_{n,j}-Y_{n,k}\right\|^{2}}{2}\right)
$$
 
$$
\displaystyle-\frac{2}{\left(1+\beta^{2}\right)^{d/2}}\sumop\slimits@_{j=1}^{n}\exp\left(-\frac{\beta^{2}\left\|Y_{n,j}\right\|^{2}}{2\left(1+\beta^{2}\right)}\right)+\frac{n}{\left(1+2\beta^{2}\right)^{d/2}}.
$$

with $\beta>0$, Baringhaus-Henze-Epps-Pulley. From <sup>1</sup> leading to the HZ test <sup>2</sup> uses

$$
\beta_{n}=2^{-1/2}((2d+1)n/4)^{1/(d+4)}
$$

the same can be done with the moment generating function <sup>3</sup>

$$
\displaystyle T_{n,\beta}=\pi^{d/2}\left(\frac{1}{n}\sumop\slimits@_{i,j=1}^{n}\frac{1}{\beta^{d/2}}\exp\left(\frac{\left\|Y_{n,i}+Y_{n,j}\right\|^{2}}{4\beta}\right)+\frac{n}{(\beta-1)^{d/2}}\right.
$$
$$
\displaystyle\left.-2\sumop\slimits@_{j=1}^{n}\frac{1}{(\beta-1/2)^{d/2}}\exp\left(\frac{\left\|Y_{n,j}\right\|^{2}}{4\beta-2}\right)\right),
$$

here with $\beta>2$

There is also one combining both <sup>4</sup>!

$$
\begin{array}[]{l}T_{n,\gamma}:=\intslop\ilimits@_{\mathbb{R}^{d}}U_{n}^{2}(t)w_{\gamma}(t)\mathrm{d}t\\
U_{n}(t):=\sqrt{n}\left(R_{n}(t)M_{n}(t)-1\right)\end{array}
$$
 
$$
\displaystyle T_{n,\gamma}=
$$
 
$$
\displaystyle\left(\frac{\pi}{\gamma}\right)^{d/2}\left\{\frac{1}{2n^{3}}\sumop\slimits@_{j,k,l,m=1}^{n}\left[\exp\left(\frac{\left\|Y_{jk}^{+}\right\|^{2}-\left\|Y_{\ell m}^{-}\right\|^{2}}{4\gamma}\right)\cos\left(\frac{Y_{jk}^{+\top}Y_{\ell m}^{-}}{2\gamma}\right)\right.\right.
$$
$$
\displaystyle+
$$
 
$$
\displaystyle\left.\exp\left(\frac{\left\|Y_{jk}^{+}\right\|^{2}-\left\|Y_{\ell m}^{+}\right\|^{2}}{4\gamma}\right)\cos\left(\frac{Y_{jk}^{+\top}Y_{\ell m}^{+}}{2\gamma}\right)\right]
$$
 
$$
\displaystyle\left.-\frac{2}{n}\sumop\slimits@_{j,k=1}^{n}\exp\left(\frac{\left\|Y_{n,j}\right\|^{2}-\left\|Y_{n,k}\right\|^{2}}{4\gamma}\right)\cos\left(\frac{Y_{n,j}^{\top}Y_{n,k}}{2\gamma}\right)+n\right\},
$$

and its simplified version

$$
\mathaccent 869{T}_{n,\gamma}:=\intslop\ilimits@_{\mathbb{R}^{d}}U_{n}(t)w_{\gamma}(t)\mathrm{d}t.
$$
 
$$
\mathaccent 869{T}_{n,\gamma}=\left(\frac{\pi}{\gamma}\right)^{d/2}\sqrt{n}\left(\frac{1}{n^{2}}\sumop\slimits@_{j,k=1}^{n}\exp\left(\frac{\left\|Y_{n,j}\right\|^{2}-\left\|Y_{n,k}\right\|^{2}}{4\gamma}\right)\cos\left(\frac{Y_{n,j}^{\top}Y_{n,k}}{2\gamma}\right)-1\right)
$$

Also one testing the derivative <sup>5</sup>

$$
\mathrm{HV}_{n,\gamma}:=n\intslop\ilimits@\left\|\nabla M_{n}(t)-tM_{n}(t)\right\|^{2}\mathaccent 869{w}_{\gamma}(t)\mathrm{d}t
$$
 
$$
\mathrm{HV}_{n,\gamma}=\frac{1}{n}\left(\frac{\pi}{\gamma}\right)^{d/2}\sumop\slimits@_{j,k=1}^{n}\exp\left(\frac{\left\|Y_{n,j,k}^{+}\right\|^{2}}{4\gamma}\right)\left(Y_{n,j}^{\top}Y_{n,k}-\frac{\left\|Y_{n,j,k}^{+}\right\|^{2}}{2\gamma}+\frac{d}{2\gamma}+\frac{\left\|Y_{n,j,k}^{+}\right\|^{2}}{4\gamma^{2}}\right).
$$

skewness <sup>6</sup>:

$$
b_{1,d}=\frac{1}{n^{2}}\sumop\slimits@_{j,k=1}^{n}\left(Y_{n,j}^{\top}Y_{n,k}\right)^{3}
$$

skewness <sup>7</sup>:

$$
\mathaccent 869{b}_{1,d}=\frac{1}{n^{2}}\sumop\slimits@_{j,k=1}^{n}Y_{n,j}^{\top}Y_{n,k}\left\|Y_{n,j}\right\|^{2}\left\|Y_{n,k}\right\|^{2}
$$

which should be 0 for Gaussian and Kurtosis which should be d(d+2)

$$
b_{2,d}=\frac{1}{n}\sumop\slimits@_{j=1}^{n}\left\|Y_{n,j}\right\|^{4}
$$