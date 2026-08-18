---
title: "MS-SSM: A Multi-Scale State Space Model for Efficient Sequence Modeling"
source: "https://arxiv.org/html/2512.23824v1"
author:
published:
created: 2026-06-25
description:
tags:
  - "clippings"
---
Mahdi Karami <sup>1</sup>, Ali Behrouz <sup>1</sup>, Peilin Zhong <sup>1</sup>, Razvan Pascanu <sup>2</sup>, Vahab Mirrokni <sup>1</sup>  
<sup>1</sup> Google Research, <sup>2</sup> Google DeepMind  
{mahdika,alibehrouz,peilinz,razp,mirrokni}@google.com

###### Abstract

State-space models (SSMs) have recently attention as an efficient alternative to computationally expensive attention-based models for sequence modeling. They rely on linear recurrences to integrate information over time, enabling fast inference, parallelizable training, and control over recurrence stability. However, traditional SSMs often suffer from limited effective memory, requiring larger state sizes for improved recall. Moreover, existing SSMs struggle to capture multi-scale dependencies, which are essential for modeling complex structures in time series, images, and natural language. This paper introduces a multi-scale SSM framework that addresses these limitations by representing sequence dynamics across multiple resolution and processing each resolution with specialized state-space dynamics. By capturing both fine-grained, high-frequency patterns and coarse, global trends, MS-SSM enhances memory efficiency and long-range modeling. We further introduce an input-dependent scale-mixer, enabling dynamic information fusion across resolutions. The proposed approach significantly improves sequence modeling, particularly in long-range and hierarchical tasks, while maintaining computational efficiency. Extensive experiments on benchmarks, including Long Range Arena, hierarchical reasoning, time series classification, and image recognition, demonstrate that MS-SSM consistently outperforms prior SSM-based models, highlighting the benefits of multi-resolution processing in state-space architectures.

## 1 Introduction

Over the past few decades, numerous deep neural network architectures have been developed for sequence modeling. Early approaches like recurrent neural networks (RNNs) (elman1990rnn) and their variants, such as Long Short-Term Memory (LSTM) networks (hochreiter1997lstm) and Gated Recurrent Units (GRUs) (cho2014gru), were proposed to handle sequential dependencies by maintaining hidden states over time. However, these models struggled with long-range dependencies and computational inefficiencies. With the advent of attention mechanisms (bahdanau2015neural; vaswani2017attention), the Transformer architecture emerged as the de facto standard for many sequence modeling tasks. The Transformer’s self-attention mechanism enabled the modeling of complex relationships across sequences without relying on recurrence, allowing for parallel computation and better handling of long-range dependencies which enabled breakthrough advances across a wide range of applications. However, inference in transformer can be expensive due to the quadratic complexity of the attention mechanism, hindering its ability to handle even longer context tasks efficiently or run in low resource settings. These limitations has motivated the exploration of alternative scalable sequence modeling approaches with comparable expressiveness.

Recently, state-space models have generated renewed interest as efficient attention-free sequence models. Deep state-space models (SSMs), a class of RNNs that use linear recurrences, provide scalable training and inference capabilities, proving particularly effective for long-range dependency modeling (gu2020hippo). These methods typically rely on a block structure similar to transformers, where the linear recurrences do sequence mixing, while MLPs are used for feature mixing (orvieto2023LRU). To gain expressivity, similar to transformer, many such blocks are typically stacked on top of each other (orvieto2024universality). The linearity allows to reformulate the recurrence as a convolution (gu2020hippo; gu2022S4D; gu2021combining; mehta2022long) or the use of associative scan (smith2023simplified; de2024griffin), making SSM on par to transformer in terms of training cost. Recent architectures also typically use gating mechanisms, similar to LSTMs and GRUs, which can also be viewed as relying on input-dependent model parameters, increasing their expressivity (gu2023mamba; orvieto2023LRU; mamba2; de2024griffin; beck2024xlstm), along with long convolution models (karami2024orchid). They demonstrate considerable potential in various applications, including natural language processing (gu2023mamba; karami2024orchid), computer vision (liu2024vmamba; karami2024orchid; behrouz2024mambamixer), DNA modeling (nguyen2024hyenadna; gu2023mamba), and graph data (behrouz2024graph).

However, traditional SSMs lack the inherent ability to capture multi-scale patterns prevalent in many real-world signals, such as image, audio, and time series data. Moreover, the effective memory of these linear RNNs, which is inversely proportional to the distance of the eigenvalues from the unit circle (agarwal2023spectralSSM), is limited, requiring larger state sizes for improved recall. To address these limitations, we propose incorporating Multi-Resolution Analysis (MRA) into SSMs. By decomposing the input sequence into multiple scales, our approach allows the SSM to capture both fine-grained details and broader trends simultaneously. This multi-scale representation enables SSM to effectively capturing historical patterns at multiple levels of granularity.

Multi-resolution analysis plays a crucial role in understanding and modeling complex patterns across diverse datasets, including audio (van2016wavenet), images (long2015fully), time series (deznabi2023multiwave), graph generation (karami2024higen), and text (tamkin2020language; tai2015improved; bowman2016fast). The importance of this approach stems from the multi-scale properties inherent in these data types, where patterns and structures manifest at various levels and timescales. For instance, natural language data exhibit multi-scale patterns ranging from subword to word, phrase, sentence, paragraph, and document levels. Similarly, the multi-scale structure of images and videos can reveal details from pixel-level to higher-level scene interpretation. Recently evidence from neuroscience further underscores the significance of multi-resolution analysis, particularly in language processing. Specifically, caucheteux2023evidence provide evidence supporting hierarchical predictive coding in language, showing that the human brain predicts speech in a hierarchical manner, with different brain regions responsible for different levels of prediction. This aligns with earlier observation that the brain continuously predicts a hierarchy of representations across multiple timescales in the cortical hierarchy (wacongne2011evidence). Consequently, modern language models augmented with hierarchical predictions across multiple timescales can improve their alignment with human brain responses. Furthermore, even in data without explicit multi-scale characteristics, this modeling approach can efficiently capture long-range dependencies (shi2023MULTIRESCONV).

Several approaches have been proposed to incorporate multi-resolution analysis into sequence modeling. For instance, nawrot2021hierarchicalTransformers introduce a hierarchical Transformer architecture that processes information across multiple levels of abstraction in language modeling tasks. This approach explores various strategies for downsampling and upsampling activations in Transformers, achieving efficient computation and improved performance on various benchmarks. The Clockwork RNN (koutnik2014clockworkRNN) enhances traditional RNNs by partitioning the hidden layer into modules that operate at different temporal frequencies. This structure allows for a more efficient processing of sequences with varying temporal dynamics, thereby improving performance on complex tasks. In the context of Fourier-based multiresolution models, techniques such as FNet (lee2021fnet), Prism (tamkin2020language), and Orchid (karami2024orchid) operate in both the spatial and frequency domains. However, these methods are inherently non-causal, as the Fourier transform is applied across the entire sequence, also Fourier transform is poor in time localization of the representation in the frequency domain. shi2023MULTIRESCONV proposed a multi-resolution convolution as an efficient pattern memorization, utilizing learned convolution kernels with dilations shared across multiple timescales. However, similar to other short convolution-based architectures, this model’s effective receptive field is limited. Additionally, fan2024mg has utilized the intrinsic granularity present in data to design more stable and accurate forecasting methods using diffusion.

In this work, we introduce *MS-SSM*, which integrates an efficient multi-resolution analysis into the state space architecture, decomposing the dynamical system into multiple time scales. This enables the overall SSM to operate at different resolutions. We show the effectiveness of our methods on Long Range Arena (tay2020long) as well as other sequential tasks. In section 2 we describe in detail the proposed method, providing our empirical evaluation in section 3.

## 2 Method

The proposed sequence model is composed of two core components: 1) a multi-scale decomposition and 2) an array of state space models (SSMs). These components work together to capture patterns and temporal dynamics at different resolutions. Each will be explained in detail in the following sections.

### 2.1 State Space Models

##### SSM.

State Space Models (SSMs) are linear time-invariant systems that map input sequence $x(t)\in\mathbb{R}^{L}$ to response sequence $y(t)\in\mathbb{R}^{L}$ (aoki2013state) using a latent state $h(t)\in\mathbb{R}^{N\times L}$, parameter $\mathbf{A}\in\mathbb{R}^{N\times N}$ (a.k.a. *state transition matrix*), and projection parameters $\mathbf{B}\in\mathbb{R}^{N\times 1},\mathbf{C}\in\mathbb{R}^{1\times N}$. That is: $h^{\prime}(t)=\mathbf{A}\>h(t)+\mathbf{B}\>x(t),\quad y(t)=\mathbf{C}\>h(t).$ Discrete space state models (gu2020hippo; zhang2023effectively) is obtained by discretizing at step size $\bm{\Delta}$ through a high accuracy Zero-Order-Hold (ZOH) method:

$$
\displaystyle h_{t}
$$
 
$$
\displaystyle=\bar{\mathbf{A}}\>h_{t-1}+\bar{\mathbf{B}}\>x_{t}
$$
 
$$
\displaystyle y_{t}
$$
 
$$
\displaystyle=\mathbf{C}\>h_{t},
$$

where ${\bar{\mathbf{B}}=\left(\bm{\Delta}\mathbf{A}\right)^{-1}\left(\operatorname{exp}\left(\bm{\Delta}\mathbf{A}-I\right)\right)\>.\>\bm{\Delta}\mathbf{B}}$ and $\bar{\mathbf{A}}=\operatorname{exp}\left(\bm{\Delta}\mathbf{A}\right)$.

These models can be interpreted as both CNNs and RNNs and are equivalent to the convolution ${\bar{\mathbf{K}}=\left({\mathbf{C}}\bar{\mathbf{B}},{\mathbf{C}}\bar{\mathbf{A}}\bar{\mathbf{B}},\dots,{\mathbf{C}}\bar{\mathbf{A}}^{L-1}\bar{\mathbf{B}}\right)}$, and so $y=x\ast\bar{\mathbf{K}}$ (gu2020hippo). Leveraging the convolution theorem and Fast Fourier Transform (FFT) algorithm for this long convolution formulation, its training complexity scales quasi-linearly with sequence length and can be parallelized, while it enjoys linear complexity at inference time using its recurrence form.

Structured SSM (gu2022S4D) relies on a diagonal parametrization of $\mathbf{A}$, enabling efficient computation of the discretization in (1) and its convolution formulation. Combined with the use of associative scan techniques smith2023simplified, this allows for efficient parallelization of computation even when using the recurrent form. Newer architectures such as Mamba (gu2023mamba) or Griffin (de2024griffin), typically have moved away from the convolutional formulation.

Input-Dependent SSM. Recently, gu2023mamba introduced the S6 block, a structured State Space Model (SSM) with a selective scan mechanism. This input-dependent gating mechanism enables S6 to selectively propagate or forget information along the sequence dimension by allowing specifying the parameters as:

$$
\bar{\mathbf{B}}_{t}~\text{=}~s_{B}(x_{t})~\text{=}~\operatorname{Linear}_{\textbf{B}}(x_{t}),~{\mathbf{C}}_{t}~\text{=}~s_{C}(x_{t})~\text{=}~\operatorname{Linear}_{\textbf{C}}(x_{t}),~\bm{\Delta}_{t}~\text{=}~s_{\Delta}(x_{t})~\text{=}~\operatorname{Softplus}\left(\operatorname{Linear}_{\bm{\Delta}}(x_{t})\right),
$$

where $\operatorname{Linear}(\cdot)$ is a linear projection and $\operatorname{Softplus}(\cdot)=\operatorname{log}(1+\operatorname{exp}(\cdot))$. This approach adds context-awareness to SSMs and a similar form is used in other works, e.g. (de2024griffin). Despite its more expressive power, in contrast to S4, this time- and input-variant model prevents the use of the convolutional formulation. But as mentioned above, computation can still be parallelized by using the *associative scan* (martin2018parallelizing; smith2023simplified; orvieto2023LRU). Also, it allows for more hardware-aware implementations.

Limitations: While the linear formulations of SSM allows to greatly improve scalability of the system and to control its stability (orvieto2023LRU), it also limits the architecture. From an expressivity point of view, a single linear recurrent layer is limited in what it can represent. Deep SSM architectures recapture expressivity by stacking multiple blocks orvieto2024universality. Additionally, the system can only exhibit fading memory, where the time to live for information is inversely proportional to the distance of the eigenvalues from the unit circle (agarwal2023spectralSSM), requiring an increase in the state size in order to improve the ability of the system to recall.

![Refer to caption](https://arxiv.org/html/2512.23824v1/FigureTable/MR-SSM-new.jpg)

(a)

### 2.2 Multi-Scale Decomposition

Multi-resolution analysis (MRA) is a mathematical framework that enables the analysis of signals at multiple scales or resolutions. A powerful tool for performing MRA is the Discrete Wavelet Transform (DWT), which decomposes a signal into different levels of approximation and detail by recursively applying a pair of filters—a low-pass filter and a high-pass filter, denoted by $\varphi$ and $\psi$, respectively—followed by downsampling.<sup>1</sup>

A major limitation of the standard Discrete Wavelet Transform (DWT) is its lack of translation-invariance, meaning that even small shifts in the input signal can result in significant changes to the resulting wavelet coefficients. To address this issue, several DWT variants have been developed that use redundant signal representations. One such approach is the Dual-Tree Complex Wavelet Transform (DTCWT) (selesnick2005dual-tree), which provides approximate translation-invariance by using two parallel DWT trees with slightly different filters. In contrast, the Stationary Wavelet Transform (SWT) (nason1995SWT) achieves true translation-invariance by skipping the downsampling step at each decomposition level. Given an input signal $a^{0}\triangleq x$, the SWT decomposes it recursively into approximation and detail coefficients at each scale $s\in\{1,2,...,S\}$, as follows:

$$
\displaystyle a^{s}[t]
$$
 
$$
\displaystyle\triangleq(a^{s-1}*(\varphi\uparrow 2^{s-1}))[t]=\sum_{\ell=0}^{K-1}a^{s-1}[t-2^{s-1}\ell]\varphi[\ell]
$$
 
$$
\displaystyle d^{s}[t]
$$
 
$$
\displaystyle\triangleq(a^{s-1}*(\psi\uparrow 2^{s-1}))[t]=\sum_{\ell=0}^{K-1}a^{s-1}[t-2^{s-1}\ell]\psi[\ell].
$$

In essence, the coefficients at level $s$ are obtained by convolving the upsampled filters, $(\varphi\uparrow 2^{s-1})$ and $(\psi\uparrow 2^{s-1})$, with the approximation coefficients from the previous level, $a^{s-1}$. The complete multi-scale decomposition of the signal after $S$ levels consists of the set of detail coefficients at all scales, $(d^{1}[t],...,d^{S}[t])$, along with the final approximation coefficients, $a^{S}[t]$, which together can perfectly reconstruct the original signal. This transformation of the signal provides information about both the frequency content and the time localization of the signal and also captures both the smooth, global trends and the fine-grained details, enabling a wide range of applications in signal processing. One key advantage of the SWT is that it maintains the same sequence length at each decomposition level, producing a redundant representation of the signal. This redundancy is key to achieving translation-invariance, which leads to significant performance improvements in applications such as signal denoising (kumar2021SWTdenoising), image resolution enhancement (demirel2010image), and feature extraction (zhang2010featureSWT). However, the trade-off for this improved performance is the increased computational cost and memory usage compared to the standard DWT.

The specific form of the filters $\varphi$ and $\psi$ depends on the choice of wavelet basis. Different wavelet families, such as Haar, Daubechies, and Symlets, have distinct filter coefficients, resulting in different properties for the wavelet transform (daubechies1992ten). While choosing an orthogonal wavelet basis ensures perfect reconstruction of the signal, this property is not always desirable in deep sequence modeling. As observed in recent research (shi2023MULTIRESCONV), employing trainable filter weights instead of fixed wavelet bases offers greater flexibility and model expressiveness. This approach enables the model to learn optimal filter coefficients for specific tasks, potentially leading to enhanced performance in a range of applications. The filtering operation at level $s$, as defined in equation 2.2, can be efficiently implemented using a causal depthwise 1D convolution (Conv1d) with two output channels, a kernel length of $K$, and a dilation factor of $2^{s-1}$. As a result, the input-output relationship in (2.2) can be specified by <sup>2</sup>

$$
\displaystyle[a^{s};~d^{s}]=\texttt{Conv1d}{(1,~2,~L,~2^{s-1})}[a^{s-1}].
$$

In this model, the multi-scale block utilizes convolution kernels with dedicated weights for each scale.

This recursive process leads to a nested multi-scale decomposition block that transforms a 1-dimensional sequence into a set of sequences across different scales, which can be collected into a multi-dimensional representation vector, *i.e.* $x_{t}\in\mathbb{R}\mapsto\hat{{\bm{x}}}_{t}\in\mathbb{R}^{S+1}$. Each dimension in this representation corresponds to a different resolution, capturing signal features from fine-grained details to coarse global trends, enabling analysis of the signal across varying levels of granularity. The higher the scale value, $s$ —which corresponds to deeper levels in the recursion tree of (3)—the more coarse-grained the information represented at that scale. This follows the *recursive principle* (pauwels1995extended), whereby larger values of $s$ result in increasingly blurred (less sharp) representations of an image (worrall2019deep).

At each time scale $s$, the dilated convolution filter captures patterns of length up to $2^{s}\times K$, meaning that $\hat{{\bm{x}}}^{s}_{t}$ represents local patterns within a limited window preceding the time index $t$. In other words, akin to the localized spectro-temporal representation in the Discrete Wavelet Transform, the scale components of $\hat{{\bm{x}}}_{t}$, with limited number of scales, capture only recent local structures. However, for non-local patterns that span larger intervals, such as those found in auditory signals (romero2020wavelet), it is essential to model long-range temporal correlations within each scale representation. To address this, we apply independent SSMs—which maintain a global receptive field—to each scale representation, as well as to the original signal, in order to capture the temporal dynamics within the scales. The proposed models, named *MS-SSM*, specializes distinct SSMs for different time scales. This setup results in an array of $(S+2)$ SSMs operating in parallel, with each SSM having a latent state size of $N$. Consequently, the effective latent state size per input channel becomes $(S+2)N$. To obtain comparable state dimension in the proposed model, we set this effective state size to match the recurrent state size of other models, thereby maintaining consistent latent dimensions across different architectures. Additionally, this SSM array can be implemented in parallel, making their overall computational complexity comparable to architectures operating at a single resolution. The MS-SSM block is illustrated in Figure 1.

Initialization. The eigenvalues of the state transition matrix ($|\lambda_{i}(\bar{\mathbf{A}})|$) play a critical role in determining the stability and memory capacity of State Space Models. To ensure stability in discrete SSMs, these eigenvalues must lie within the unit circle, while for continuous-time SSMs, the eigenvalues of ${\mathbf{A}}$ must be in the left half-plane. Eigenvalues of $\bar{\mathbf{A}}$ that are closer to 1 enhance the model’s ability to capture long-range dependencies (gupta2022diagonal; orvieto2023LRU). In essence, the effective memory of an SSM, which quantifies how long past information influences the present state, is inversely proportional to the distance of the eigenvalues from the unit circle. Formally, when eigenvalues satisfy $|\lambda_{i}(\bar{\mathbf{A}})|<1-\delta$ the effective memory is on the order of $\frac{1}{\delta}$ (agarwal2023spectralSSM).

To balance between capturing long-range dependencies and maintaining different effective memory at each resolution, we employ a *scale-dependent initialization scheme*. Previous works observed that real-valued SSMs can perform on par with or even outperform complex-valued counterparts (ma2022mega; gu2023mamba), hence, we adopt a diagonal-structured recurrence matrix with real values.

<svg height="67.55" id="S2.F2.pic1" overflow="visible" version="1.1" viewBox="0 0 272.05 67.55" width="272.05"><g fill="#000000" stroke="#000000" style="--ltx-stroke-color:#000000;--ltx-fill-color:#000000;" transform="translate(0,67.55) matrix(1 0 0 -1 0 0) translate(8.07,0) translate(0,31.21)"><g stroke-width="0.8pt"><path d="M 0 0 L 255.91 0" style="fill:none"></path></g><g color="#808080" fill="#808080" stroke="#808080" stroke-width="1.0pt" style="--ltx-stroke-color:#808080;--ltx-fill-color:#808080;--ltx-fg-color:#808080;"><path d="M 0 0 L 35.83 0" style="fill:none"></path></g><g color="#FF9999" fill="#FF9999" stroke="#FF9999" stroke-width="3.0pt" style="--ltx-stroke-color:#FF9999;--ltx-fill-color:#FF9999;--ltx-fg-color:#FF9999;"><path d="M 35.83 0 L 63.98 0" style="fill:none"></path></g><g color="#99FF99" fill="#99FF99" stroke="#99FF99" stroke-width="3.0pt" style="--ltx-stroke-color:#99FF99;--ltx-fill-color:#99FF99;--ltx-fg-color:#99FF99;"><path d="M 63.98 0 L 115.16 0" style="fill:none"></path></g><g color="#9999FF" fill="#9999FF" stroke="#9999FF" stroke-width="3.0pt" style="--ltx-stroke-color:#9999FF;--ltx-fill-color:#9999FF;--ltx-fg-color:#9999FF;"><path d="M 115.16 0 L 209.84 0" style="fill:none"></path></g><g color="#808080" fill="#808080" stroke="#808080" stroke-width="1.0pt" style="--ltx-stroke-color:#808080;--ltx-fill-color:#808080;--ltx-fg-color:#808080;"><path d="M 209.84 0 L 255.91 0" style="fill:none"></path></g><g stroke-width="0.4pt"><path d="M 0 12.8 L 0 -12.8" style="fill:none"></path><g fill="#000000" stroke="#000000" style="--ltx-stroke-color:#000000;--ltx-fill-color:#000000;" transform="matrix(1.0 0.0 0.0 1.0 -3.46 -26.6)"><foreignObject height="8.92" overflow="visible" style="--ltx-fo-width:0.5em;--ltx-fo-height:0.64em;--ltx-fo-depth:0em;" transform="matrix(1 0 0 -1 0 8.92)" width="6.92"><span id="S2.F2.pic1.1.1.1.1.1.1">0</span></foreignObject></g> <path d="M 35.83 12.8 L 35.83 -12.8" style="fill:none"></path><path d="M 63.98 12.8 L 63.98 -12.8" style="fill:none"></path><path d="M 115.16 12.8 L 115.16 -12.8" style="fill:none"></path><path d="M 209.84 12.8 L 209.84 -12.8" style="fill:none"></path><path d="M 255.91 12.8 L 255.91 -12.8" style="fill:none"></path><g fill="#000000" stroke="#000000" style="--ltx-stroke-color:#000000;--ltx-fill-color:#000000;" transform="matrix(1.0 0.0 0.0 1.0 252.45 -26.6)"><foreignObject height="8.92" overflow="visible" style="--ltx-fo-width:0.5em;--ltx-fo-height:0.64em;--ltx-fo-depth:0em;" transform="matrix(1 0 0 -1 0 8.92)" width="6.92"><span id="S2.F2.pic1.2.2.2.2.1.1">1</span></foreignObject></g> <path d="M 209.52 0 M 213.35 0 C 213.35 2.12 211.64 3.84 209.52 3.84 C 207.4 3.84 205.68 2.12 205.68 0 C 205.68 -2.12 207.4 -3.84 209.52 -3.84 C 211.64 -3.84 213.35 -2.12 213.35 0 Z M 209.52 0" style="stroke:none"></path><path d="M 171.54 0 M 175.38 0 C 175.38 2.12 173.66 3.84 171.54 3.84 C 169.42 3.84 167.7 2.12 167.7 0 C 167.7 -2.12 169.42 -3.84 171.54 -3.84 C 173.66 -3.84 175.38 -2.12 175.38 0 Z M 171.54 0" style="stroke:none"></path><path d="M 140.44 0 M 144.28 0 C 144.28 2.12 142.56 3.84 140.44 3.84 C 138.32 3.84 136.61 2.12 136.61 0 C 136.61 -2.12 138.32 -3.84 140.44 -3.84 C 142.56 -3.84 144.28 -2.12 144.28 0 Z M 140.44 0" style="stroke:none"></path><path d="M 114.98 0 M 118.82 0 C 118.82 2.12 117.1 3.84 114.98 3.84 C 112.86 3.84 111.15 2.12 111.15 0 C 111.15 -2.12 112.86 -3.84 114.98 -3.84 C 117.1 -3.84 118.82 -2.12 118.82 0 Z M 114.98 0" style="stroke:none"></path><path d="M 94.14 0 M 97.98 0 C 97.98 2.12 96.26 3.84 94.14 3.84 C 92.02 3.84 90.3 2.12 90.3 0 C 90.3 -2.12 92.02 -3.84 94.14 -3.84 C 96.26 -3.84 97.98 -2.12 97.98 0 Z M 94.14 0" style="stroke:none"></path><path d="M 77.08 0 M 80.92 0 C 80.92 2.12 79.2 3.84 77.08 3.84 C 74.96 3.84 73.24 2.12 73.24 0 C 73.24 -2.12 74.96 -3.84 77.08 -3.84 C 79.2 -3.84 80.92 -2.12 80.92 0 Z M 77.08 0" style="stroke:none"></path><path d="M 63.11 0 M 66.94 0 C 66.94 2.12 65.23 3.84 63.11 3.84 C 60.99 3.84 59.27 2.12 59.27 0 C 59.27 -2.12 60.99 -3.84 63.11 -3.84 C 65.23 -3.84 66.94 -2.12 66.94 0 Z M 63.11 0" style="stroke:none"></path><path d="M 51.66 0 M 55.5 0 C 55.5 2.12 53.78 3.84 51.66 3.84 C 49.54 3.84 47.83 2.12 47.83 0 C 47.83 -2.12 49.54 -3.84 51.66 -3.84 C 53.78 -3.84 55.5 -2.12 55.5 0 Z M 51.66 0" style="stroke:none"></path><path d="M 42.3 0 M 46.14 0 C 46.14 2.12 44.42 3.84 42.3 3.84 C 40.18 3.84 38.46 2.12 38.46 0 C 38.46 -2.12 40.18 -3.84 42.3 -3.84 C 44.42 -3.84 46.14 -2.12 46.14 0 Z M 42.3 0" style="stroke:none"></path><g fill="#FF9999" stroke="#FF9999" style="--ltx-stroke-color:#FF9999;--ltx-fill-color:#FF9999;" transform="matrix(1.0 0.0 0.0 1.0 37.05 22.8)"><foreignObject color="#FF9999" height="8.92" overflow="visible" style="--ltx-fg-color:#FF9999;--ltx-fo-width:1.67em;--ltx-fo-height:0.64em;--ltx-fo-depth:0em;" transform="matrix(1 0 0 -1 0 8.92)" width="23.14"><span id="S2.F2.pic1.3.3.3.3.1.1">s=1</span></foreignObject></g> <g fill="#99FF99" stroke="#99FF99" style="--ltx-stroke-color:#99FF99;--ltx-fill-color:#99FF99;" transform="matrix(1.0 0.0 0.0 1.0 78 22.8)"><foreignObject color="#99FF99" height="8.92" overflow="visible" style="--ltx-fg-color:#99FF99;--ltx-fo-width:1.67em;--ltx-fo-height:0.64em;--ltx-fo-depth:0em;" transform="matrix(1 0 0 -1 0 8.92)" width="23.14"><span id="S2.F2.pic1.4.4.4.4.1.1">s=2</span></foreignObject></g> <g fill="#9999FF" stroke="#9999FF" style="--ltx-stroke-color:#9999FF;--ltx-fill-color:#9999FF;" transform="matrix(1.0 0.0 0.0 1.0 152.21 22.8)"><foreignObject color="#9999FF" height="8.92" overflow="visible" style="--ltx-fg-color:#9999FF;--ltx-fo-width:1.67em;--ltx-fo-height:0.64em;--ltx-fo-depth:0em;" transform="matrix(1 0 0 -1 0 8.92)" width="23.14"><span id="S2.F2.pic1.5.5.5.5.1.1">s=3</span></foreignObject></g></g></g></svg>

Figure 2: Initialization scheme for 3 different scales with $N=3$ and $\Delta_{0}=0.2$.

For lower resolutions (higher value of $s$ in hierarchy), which contain coarse-grained information, we initialize the diagonal elements of $\bar{\mathbf{A}}$ with values closer to 1 to enhance the model’s ability to capture long-range dependencies within these scales. In contrast, for higher resolutions containing fine-grained details, we initialize $\operatorname{diag}(\bar{\mathbf{A}})$ with smaller values to prioritize shorter effective memory and focus on local dynamics at initialization. Specifically, the diagonal elements of the state transition matrix at scale ${s~\in~\{0,\dots,S+1\}}$, $\operatorname{diag}({\mathbf{A}^{s}})$, are initialized uniformly within the interval ${\big(-N(S+1-s),~-N(S-s)\big]}$ (or equivalently $\operatorname{diag}(\bar{\mathbf{A}}^{s})~\in~\big(e^{{(-\Delta_{0}N(S+1-s))}},~e^{{(-N\Delta_{0}(S-s))}}\big]$ ), where $N$ is the state size per scale. By concatenating all latent states into a large state $[{\bm{h}}^{0}~;~\dots~;~{\bm{h}}^{S+1}]$, the overall state transition matrix becomes ${\mathbf{A}}=\operatorname{diag}([\operatorname{diag}({\mathbf{A}^{0}})~;~\dots~;~\operatorname{diag}({\mathbf{A}^{S+1}})])$. Then, this real-valued initialization aligns with that in the S4D-real (gu2022S4D) which is grounded in the HiPPO theory (gu2020hippo), where the $n$ -th element of $\operatorname{diag}({\mathbf{A}})$ is initialized as $-(n+1)$. An example of this initialization scheme is illustrated in Figure 2.

Scale Mixer. After independently modeling the temporal dynamics at each specific scale, the array of ($S+2$) SSMs produces outputs that are collected into the vector ${{\bm{y}}}_{t}\in\mathbb{R}^{S+2}$. To effectively merge these multi-scale representations, the model requires a mechanism that encodes cross-scale interactions, enabling information to flow between scales and ultimately combines them into a single-dimensional output. To achieve this, we combines the scales through a weighted summation applying an input-dependent projection matrix $\mathbf{E}_{t}\in\mathbb{R}^{1\times{(S+2)}}$:

$$
\displaystyle z_{t}=\texttt{scale-mixer}({\bm{y}}_{t};x_{t})=\mathbf{E}_{t}\>{\bm{y}}_{t},\quad\text{where }\mathbf{E}_{t}=s_{E}(x_{t})=\operatorname{Linear}_{\textbf{E}}(x_{t})
$$

This approach allows the model to dynamically adjust the contribution of each scale based on its input.

Input-dependent Parameterization. In S6 (gu2023mamba), an input-dependent parameterization is employed for the SSM, allowing the model to selectively propagate or forget information along the sequence based on the input token of the SSM, functioning similarly to gating mechanism in RNNs. In this work, for the $s$ -th SSM operating on scale $s$, we make the parameters functions of the original input $x_{t}$. Specifically, the parameters of the $s$ -th SSM, are modeled as $\bar{\mathbf{B}}_{t}^{s}=s_{B}^{s}(x_{t})$, $\bar{\mathbf{C}}_{t}^{s}=s_{C}^{s}(x_{t})$, and $\bm{\Delta}^{s}_{t}=s_{\Delta}^{s}(x_{t})$. Through empirical studies, presented in Appendix C, we observe that gating based on the raw input, $x_{t}$, is more effective than gating based on the scale-specific representations ($\bar{\mathbf{B}}_{t}^{s}=s_{B}^{s}(\hat{x}_{t}^{s})$, $\bar{\mathbf{C}}_{t}^{s}=s_{C}^{s}(\hat{x}_{t}^{s})$, and $\bm{\Delta}^{s}_{t}=s_{\Delta}^{s}(\hat{x}_{t}^{s})$). Using the raw input for controlling the parameters results in a more effective mixing of each scale’s representation with the raw input information.

Complexity. The multi-scale convolution operation introduces a linear time computation overhead of $\mathcal{O}(LKS)$ and require an additional $\mathcal{O}(KS)$ parameters per layer. However, this overhead is minimal compared to the overall model size, given the small convolution kernel size, $K$, and the limited number of scales, $S$.

## 3 Experiments

Table 1: Results on sCIFAR (shi2023MULTIRESCONV) and ImageNet (deng2009imagenet). Missing results mean that the performance of the model is not reported on ImageNet-1K in the original reference.

<table><tbody><tr><th>Method</th><td>sCIFAR</td><td>ImageNet-1K</td></tr><tr><th colspan="3">Transformers</th></tr><tr><th>Transformer <cite>(vaswani2017attention)</cite></th><td>62.2</td><td>78.9</td></tr><tr><th colspan="3">Recurrent Neural Networks (RNNs)</th></tr><tr><th>HiPPO-RNN <cite>(gu2020hippo)</cite></th><td>61.1</td><td>-</td></tr><tr><th>LSTM <cite>(hochreiter1997lstm)</cite></th><td>63.0</td><td>-</td></tr><tr><th>r-LSTM <cite>(trinh2018learning)</cite></th><td>72.2</td><td>-</td></tr><tr><th>UR-GRU <cite>(gu2020improving)</cite></th><td>74.4</td><td>-</td></tr><tr><th>LipschitzRNN <cite>(erichson2020lipschitz)</cite></th><td>64.2</td><td>-</td></tr><tr><th colspan="3">State Space Models (SSMs)</th></tr><tr><th>S4 <cite>(gu2022efficiently)</cite></th><td>91.1</td><td>79.1</td></tr><tr><th>S4D <cite>(gu2022S4D)</cite></th><td>89.9</td><td>80.4</td></tr><tr><th>S5 <cite>(smith2023simplified)</cite></th><td>89.7</td><td>77.9</td></tr><tr><th>Liquid-S4 <cite>(hasani2022liquid)</cite></th><td>92.0</td><td>-</td></tr><tr><th>Mamba <cite>(gu2023mamba)</cite></th><td>90.1</td><td>80.5</td></tr><tr><th colspan="3">Convolutions</th></tr><tr><th>CKConv <cite>(romero2021ckconv)</cite></th><td>63.7</td><td>-</td></tr><tr><th>MultiResNet <cite>(shi2023MULTIRESCONV)</cite></th><td>93.1</td><td>-</td></tr><tr><th>Orchid <cite>(karami2024orchid)</cite></th><td>93.0</td><td>80.2</td></tr><tr><th colspan="3">Convolution + SSMs</th></tr><tr><th>MS-SSM (S4)</th><td>90.3</td><td>79.7</td></tr><tr><th>MS-SSM (S6)</th><td>93.3</td><td>81.3</td></tr></tbody></table>

Table 2: Performance of predicting outcomes of list operations in ListOps dataset of tay2020long. Mamba 2X Param and Mamba 2X State denote Mamba model with double model size and double state size, respectively.

<table><thead><tr><th>Model</th><th>Accuracy (%)</th></tr><tr><th colspan="2">Transformers</th></tr></thead><tbody><tr><th>Transformer <cite>(vaswani2017attention)</cite></th><td>36.37</td></tr><tr><th>Local Attention <cite>(tay2020long)</cite></th><td>15.82</td></tr><tr><th>Linear Trans. <cite>(katharopoulos2020transformers)</cite></th><td>16.13</td></tr><tr><th>Linformer <cite>(wang2020linformer)</cite></th><td>16.13</td></tr><tr><th>Sparse Transformer <cite>(child2019generating)</cite></th><td>17.07</td></tr><tr><th>Performer <cite>(choromanski2020rethinking)</cite></th><td>18.01</td></tr><tr><th>Sinkhorn Transformer <cite>(tay2020sparse)</cite></th><td>33.67</td></tr><tr><th>Longformer <cite>(beltagy2020longformer)</cite></th><td>35.63</td></tr><tr><th>BigBird <cite>(zaheer2020big)</cite></th><td>36.05</td></tr><tr><th>Luna-256 <cite>(ma2021luna)</cite></th><td>37.25</td></tr><tr><th>Reformer <cite>(kitaev2020reformer)</cite></th><td>37.27</td></tr><tr><th>H-Transformer-1D <cite>(zhu2021h)</cite></th><td>49.53</td></tr><tr><th colspan="2">Convolutions</th></tr><tr><th>CDIL <cite>(cheng2023classification)</cite></th><td>44.05</td></tr><tr><th>SGConv <cite>(li2023makes)</cite></th><td>61.45</td></tr><tr><th>MultiResNet <cite>(shi2023MULTIRESCONV)</cite></th><td>62.75</td></tr><tr><th colspan="2">SSMs</th></tr><tr><th>S4 <cite>(gu2022efficiently)</cite></th><td>59.60</td></tr><tr><th>DSS <cite>(gupta2022diagonal)</cite></th><td>57.60</td></tr><tr><th>S4D <cite>(gu2022S4D)</cite></th><td>60.52</td></tr><tr><th>S5 <cite>(smith2023simplified)</cite></th><td>62.15</td></tr><tr><th>Liquid-S4 <cite>(hasani2022liquid)</cite></th><td>62.75</td></tr><tr><th>Griffin <cite>(de2024griffin)</cite></th><td>32.34</td></tr><tr><th>Mamba <cite>(gu2023mamba)</cite></th><td>38.02</td></tr><tr><th>Mamba 2x Param</th><td>49.63</td></tr><tr><th>Mamba 2x State</th><td>42.14</td></tr><tr><th colspan="2">Convolutions + SSMs</th></tr><tr><th>MS-SSM (S4)</th><td>62.83</td></tr><tr><th>MS-SSM (S6)</th><td>63.04</td></tr></tbody></table>

We evaluate our proposed architecture across image classification tasks, where images are converted into a sequence of patches (ImageNet-1k) or pixels (sCIFAR), as well as hierarhical reasoning and time series classifications. In all experiments, we report the results of two variants of our approach, i.e., MS-SSM (S4) and MS-SSM (S6), in which we use S4 (gu2021efficiently) and S6 (gu2023mamba) blocks as the recurrent module, respectively. Comparison of these two, as two instances of data-dependent and data-indpendent recurrent models, shows that MS-SSM’performance does not rely on the S6 block and supports the significance of our design.

Image Classification. We evaluate the performance of MS-SSM in two image classification tasks: ImageNet-1K (krizhevsky2012imagenet) and sCIFAR (shi2023MULTIRESCONV). We use ImageNet to compare the performance of MS-SSM with baselines in modeling the sequence of image patches. In sCIFAR task, however, each image is treated as a 1D sequence of pixel and so the models are not using any 2D inductive bias from the images. Therefore, the model must be able to capture long-range dependencies and patterns at different resolutions. Results are reported in Table 2. MS-SSM shows outstanding performance compared to all other sequence models in both tasks and more specifically in capturing long range and multi-resolution modeling of pixels in sCIFAR. The superior performance compared to Mamba (gu2023mamba) and similar SSM-based models (smith2023simplified; gu2022efficiently; gu2022S4D) comes from the multi-resolution convolutions that helps MS-SSM to capture the dependencies at different levels of granularity. Compared to multi-resolution methods, e.g., MultiResNet (shi2023MULTIRESCONV), the superior performance of MS-SSM highlights the significance of SSMs and our scale-mixer module.

Time Series Classification. Time series classification is one of the important tasks in sequence modeling that requires capturing dependencies at different resolutions. We use PTB-XL (wagner2020ptb), a commonly used dataset of electrocardiogram (ECG) in the time series literature. This dataset has 21,837 ECG recordings, each of which with 12 channels, from 18,885 patients. Each recording has at least one label from 71 total ECG labels obtained from SCP-ECG standard. In this experiment, the dataset is partitioned into six subsets of “all”, “diagnostic”, “diagnostic subclass”, “diagnostic superclass”, “form”, and “rhythm”. Following previous studies (behrouz\_chimera\_2024; shi2023MULTIRESCONV), we use the 100Hz version of the dataset, in which each time series has 1000 timesteps. Table 3 reports the results on ECG classification tasks. MS-SSM outperforms all the baselines, even specialized models for time series (e.g., SpaceTime (zhang2023effectively)).

Hierarchical Reasoning. To evaluate the MS-SSM’s ability in reasoning about hierarchical structures, we perform experiments on the long ListOps dataset from the Long Range Arena benchmark (tay2020long). This dataset consists of sequences with hierarchical structures and operators such as MAX, MIN, MEDIAN, and SUM\_MOD, which are enclosed by brackets to indicate nested operations. A short example of a sequence from this dataset is as follows:

INPUT: \[MAX 2 4 \[MIN 1 6 \] 1 0 \[MEDIAN 1 9 7\]\] OUTPUT: 7

Table 2 reports the performance of MS-SSM and baselines on ListOps dataset. MS-SSM achieves the best results compared to all baselines. Notably, MS-SSM achieves $\times 2$ accuracy compared to Mamba (gu2023mamba), which shows the significance of multi-resolution modeling of the sequence.

Additionally, the performance improvement is achieved without increasing computational complexity or parameter count. When compared to Mamba models with double parameter count and double state size, MS-SSM consistently exhibits superior performance, highlighting its effectiveness and efficient utilization of its multi-timescale memory in capturing long hierarchical structures.

Table 3: AUROC for ECG multi-label/multi-class classification on the PTB-XL dataset.

| Model (AUROC) | All | Diag | Sub-diag | Super-diag | Form | Rhythm |
| --- | --- | --- | --- | --- | --- | --- |
| Transformer (vaswani2017attention) | 0.857 | 0.876 | 0.882 | 0.887 | 0.771 | 0.831 |
| MultiResNet (shi2023MULTIRESCONV) | 0.938 | 0.939 | 0.934 | 0.934 | 0.897 | 0.975 |
| Spacetime (zhang2023effectively) | 0.936 | 0.941 | 0.933 | 0.929 | 0.883 | 0.967 |
| S4 (gu2022efficiently) | 0.938 | 0.939 | 0.929 | 0.931 | 0.895 | 0.977 |
| InceptionTime (ismail2020inceptiontime) | 0.925 | 0.931 | 0.930 | 0.921 | 0.899 | 0.953 |
| LSTM (hochreiter1997lstm) | 0.907 | 0.927 | 0.928 | 0.927 | 0.851 | 0.953 |
| Wavelet features (strodthoff2020deep) | 0.849 | 0.855 | 0.859 | 0.874 | 0.757 | 0.890 |
| Mamba (gu2023mamba) | 0.915 | 0.929 | 0.905 | 0.912 | 0.876 | 0.952 |
| MS-SSM (S4) | 0.939 | 0.939 | 0.935 | 0.930 | 0.899 | 0.980 |
| MS-SSM (S6) | 0.939 | 0.941 | 0.936 | 0.935 | 0.901 | 0.979 |

Table 4: Performances Comparison on the Long Range Arena benchmark (tay2020long). The baselines results are reported by qin2024hgrn2.

| Model | Text | Retrieval | Image | Pathfinder | Path-X | AVG. |
| --- | --- | --- | --- | --- | --- | --- |
| Transformer (vaswani2017attention) | 61.95 | 80.69 | 40.57 | 65.26 | \- | 62.12 |
| cosFormer (qin2022cosformer) | 67.70 | 83.15 | 51.23 | 71.96 | \- | 68.51 |
| FLASH (hua2022transformer) | 64.10 | 86.10 | 47.40 | 70.25 | \- | 66.96 |
| S4 (gu2022efficiently) | 86.82 | 90.90 | 88.65 | 94.20 | 96.35 | 91.38 |
| DSS\_softmax (gupta2022diagonal) | 84.80 | 87.80 | 85.70 | 84.60 | 87.80 | 86.13 |
| DSSEXP (gupta2022diagonal) | 84.60 | 87.60 | 84.90 | 84.70 | 85.60 | 85.47 |
| DSSEXP-NO-SCALE (gupta2022diagonal) | 82.40 | 86.00 | 81.20 | 81.30 | \- | 66.46 |
| TNN (qin2023toeplitz) | 87.90 | 90.97 | 88.24 | 93.00 | 96.10 | 91.24 |
| S5 (smith2023simplified) | 89.31 | 91.4 | 88.00 | 95.33 | 98.56 | 92.52 |
| Mega (ma2022mega) | 90.43 | 91.25 | 90.44 | 96.01 | 97.98 | 93.22 |
| SGConv (li2023makes) | 89.2 | 91.11 | 87.97 | 95.46 | 97.83 | 92.31 |
| LRU (orvieto2023LRU) | 89.40 | 89.90 | 89.00 | 95.10 | 94.20 | 91.52 |
| Mamba (gu2023mamba) | 82.98 | 72.14 | 69.82 | 69.26 | 67.32 | 72.30 |
| Griffin (de2024griffin) | 71.75 | 66.58 | 61.15 | 73.38 | 69.53 | 68.47 |
| MS-SSM (S4) | 87.22 | 91.06 | 89.15 | 94.90 | 97.12 | 91.89 |
| MS-SSM (S6) | 85.70 | 83.21 | 89.83 | 87.24 | 87.70 | 86.73 |

Long Range Arena. We further evaluate the performance of MS-SSM on additional tasks from the Long Range Arena benchmark (tay2020long). The results, summarized in Table 4, highlight the advantages of MS-SSM over similar data-dependent SSM-based architectures such as Mamba and Griffin. While these models exhibit poor performance on long-range tasks, MS-SSM achieves a significant $14.42\%$ performance improvement over its closest counterpart, Mamba, which shares a similar SSM architecture.<sup>3</sup> This performance boost is attributed to the integration of multi-scale convolutions, which enhances MS-SSM’s capacity to capture dependencies across various scales and over long sequences.

Ablation Studies. In this section, we evaluate the significance of our model design and the made choices by performing an ablation study on ListOps and PTB-XL datasets. To this end, we change the main components of the MS-SSM, one at a time, to evaluate its contribution in the performance of MR-SSM. We use the following variants: (1) is the main variant of MS-SSM, when using S6 block as the recurrent module, (2) replaces the S6 block with S4, (3) removes the recurrent module, (4) removes the multiresolution convolution and instead uses Conv1D, (5) is the original gating for scales,

Table 5: Ablation on the architecture of MS-SSM.

<table><tbody><tr><th></th><th>Method</th><td>PTB-XL</td><td>ListOps</td></tr><tr><th colspan="4">Base</th></tr><tr><th>1</th><th>MS-SSM (S6)</th><td>0.939</td><td>63.04</td></tr><tr><th>2</th><th>MS-SSM (S4)</th><td>0.939</td><td>62.83</td></tr><tr><th>3</th><th>Remove S6/S4</th><td>0.936</td><td>62.59</td></tr><tr><th>4</th><th>Remove Multi. Conv.</th><td>0.916</td><td>37.98</td></tr><tr><th colspan="4">Gating (Input, Based on)</th></tr><tr><th>5</th><th>(self scale, original input)</th><td>0.939</td><td>63.04</td></tr><tr><th>6</th><th>(self scale, self scale)</th><td>0.938</td><td>62.91</td></tr><tr><th>7</th><th>(original input, self scale)</th><td>0.939</td><td>62.95</td></tr><tr><th colspan="4">Scale Mixing</th></tr><tr><th>8</th><th>Input-dependent</th><td>0.939</td><td>63.04</td></tr><tr><th>9</th><th>Input-independent</th><td>0.932</td><td>61.28</td></tr><tr><th>10</th><th>None-linear SoftMax gate</th><td>0.921</td><td>61.42</td></tr></tbody></table>

(6) for each scale, we use its own input for the gating, (7) is the gating where each scale is gated with the original input, (8) is the original scale mixing module used in MS-SSM, (9) uses simple linear layer for mixing different scales, and (10) uses non-linearity in the gating (data-dependency) of scale mixing. The results are reported in Table 5, indicating that all components contributes to the performance gain, where main contribution comes from the multiresolution convolution. Additional experimental results and ablation studies (on the types of initialization) are discussed in Appendix C.

### 3.1 Effective Receptive Field

We introduce the concept of the *mean mixing distance* as a metric to quantify the effective receptive field (ERF) in our model, drawing inspiration from the receptive field in convolutional networks. This definition is inspired by the average attention distance defined in self-attention models (dosovitskiy2020image).

The normalized attention scores between each pair of tokens defines the mapping between each output token and all tokens in the input sequence.<sup>4</sup> Using this, the average attention distance (dosovitskiy2020image) is defined as: $d(m,n)=\sum_{n=1}^{m}\mathbf{A}(x)_{m,n}\times(m-n)$ where each row of the attention matrix forms a probability distribution over distances (ben2024decimamba), as they lie in the $(L-1)$ -simplex (*i.e.* the rows sum to 1). In contrast, expressing a closed-form mapping between input and output tokens for ${\bm{y}}=\operatorname{MS-SSM}({\bm{x}})=f({\bm{x}})$ is not straightforward. Therefore, we rely on the Jacobian of the output with respect to the input to describe how the sequence is transformed by a MS-SSM layer. We define the *mean mixing distance* for MS-SSM as:

$$
\displaystyle d(m,n)=\sum_{n=1}^{m}\frac{|{\bm{J}}(x)_{m,n}|}{|\sum_{k=1}^{m}{\bm{J}}(x)_{m,k}|}\times(m-n)
$$

As the results in Table 6 highlights, MS-SSM achieves a significantly higher mean mixing distance than Mamba, indicating its superior ability to attend to distant contexts, thereby capturing long-range dependencies in the sequence more effectively.

## 4 Conclusion and Discussion

In this paper, we introduced MS-SSM, a multi-resolution state-space model for sequence modeling that integrates multi-scale analysis into state space models (SSMs). By decomposing the system into multiple time scales and incorporating independent SSMs at each resolution, MS-SSM is able to capture dependencies at varying levels of granularity, addressing a key challenge in long-range sequence modeling. The use of specialized convolutions and scale-specific parameter initialization enhances the model’s ability to efficiently handle both local and global temporal dynamics.

Our extensive experiments across multiple benchmarks, including image classification, hierarchical reasoning, long-context tasks, and time series tasks, demonstrate the effectiveness of the proposed approach. MS-SSM consistently outperforms state-of-the-art SSM architectures, such as Mamba and Griffin. The results in the Long Range Arena benchmark further validate that MS-SSM can handle effectively long-range dependencies, showing significant improvements over similar data-dependent SSM models. One of the key strengths of MS-SSM lies in its parallelized implementation and minimal computation and model parameters increase, which ensures computational efficiency despite the increased capacity in capturing multi-scale structures.

While MS-SSM is highly effective in capturing multi-resolution and long range dependencies, there remain several avenues for future research. First, extending the MS-SSM framework to other sequence domains, such as natural language processing, where hierarchical structures are prevalent, could further validate its generality. Another potential direction is the exploration of multi-resolution in the most recent form of linear RNNs (orvieto2023LRU; beck2024xlstm; yang2024parallelizing) and nonlinear test-time training models (sun2024ttt; behrouz2024titans; karami2025lattice; karami2025trellis) and analyze how it improves the system’s memory in such RNN/SSM models.

## Appendix A Details

### A.1 Notation definition

Notations Brief definition and interpretation $x_{t}$, $y_{t}$, ${\bm{W}}$ the sequence $x\in\mathbb{R}^{L}$ and ${\bm{y}}\in\mathbb{R}^{L}$ are input and output of a layer, while matrices are denoted by bold uppercase letters, such as layer weight matrix ${\bm{W}}$. $\bm{\Delta},~\bar{\mathbf{A}},~\bar{\mathbf{B}}$ discretization step size and parameters of the discrete SSM: $\bar{\mathbf{A}}=\operatorname{exp}\left(\bm{\Delta}\mathbf{A}\right)$ (state transition matrix), ${\bar{\mathbf{B}}=\left(\bm{\Delta}\mathbf{A}\right)^{-1}\left(\operatorname{exp}\left(\bm{\Delta}\mathbf{A}-I\right)\right)\>.\>\bm{\Delta}\mathbf{B}}$. $\hat{x}^{s}_{t}$, $\mathbf{A}^{s}$ the superscripts denotes the index of a scale: $\mathrm{s~\in~\{0,\dots,S+1\}}$. $\hat{x}^{s}_{t}$ is the $s$ -th scale representation of ${x}_{t}$, and $\mathbf{A}^{s}$ is the SSM parameter applied to that scale. $[{\bm{h}}^{0}~;~\dots~;~{\bm{h}}^{S+1}]$ Concatenation vectors $\{{\bm{h}}^{0},~\dots,~{\bm{h}}^{S+1}\}$ ${\mathbf{C}}_{t}=\texttt{Linear}_{\textbf{C}}(x_{t})$ input-dependent parameter modeled by $\texttt{Linear}_{\textbf{C}}(x_{t})={\bm{W}}_{\textbf{C}}\>x_{t}$. $\texttt{Conv1d}{(1,~2,~L,~2^{s-1})}$ a causal depthwise 1D convolution (Conv1d) with two output channels, a kernel length of $K$, and a dilation factor of $2^{s-1}$ applied to each feature dimension. ${\bm{h}}\ast{\bm{x}}$ linear convolution: ${\bm{y}}[t]=({\bm{h}}*{\bm{x}})[t]\triangleq\sum_{\ell=0}^{L-1}h[t-\ell]x[\ell]$ ${\bm{h}}\odot{\bm{x}}$ element-wise multiplication (Hadamard product): ${\bm{y}}[t]=({\bm{h}}\odot{\bm{x}})[t]\triangleq h[t]\cdot x[t]$ $\texttt{diag}({\mathbf{A}})$, $\texttt{diag}({\bm{a}})$ $\texttt{diag}({\mathbf{A}})$: a vector containing the diagonal elements of square matrix $\mathbf{A}$, and $\texttt{diag}({\bm{a}})$: a square matrix formed by the entries of ${\bm{a}}$ on its diagonal. $\texttt{Softplus}(.)$ the nonlinearity defined as: $\texttt{log}(1+\texttt{exp}(.))$ softmax($\mathbf{u}$) Softmax activation function defined as: $\texttt{softmax}(\mathbf{u})_{i}:=\frac{\texttt{exp}({u_{i}})}{\sum_{j=1}^{L}\texttt{exp}({u_{j}})}$

### A.2 Model Architecture

#### A.2.1 Scale Mixing

We explored differnt approaches for scale mixing within the proposed architecture: (i) a data-dependent scale mixing module, as defined in equation 4, (ii) a simple trainable linear layer for scale mixing that is data-independent, and (iii) a data-dependent scale mixing module, similar to the one in equation 4, but uses non-linearity in its gating, expressed as $\mathbf{E}_{t}=s_{E}(x_{t})=\texttt{SoftMax}(\texttt{Linear}_{\textbf{E}}(x_{t}))$.

The ablation study results, reported in Table 5, indicate that the data-dependent scale mixing with the linear parameterization from equation 4 achieves the best performance among these methods.

### A.3 Effective Receptive Field

We introduce the concept of the *mean mixing distance* as a metric to quantify the effective receptive field (ERF) in our model, drawing inspiration from the receptive field in convolutional networks. This definition is inspired by the average attention distance defined in self-attention models (dosovitskiy2020image).

For a length- $L$ sequence of tokens $\mathbf{x}=(x_{1},x_{2},\ldots,x_{L})$, the self-attention layer transforms the sequence by computing a weighted sum of token embeddings, as follows:

$$
\displaystyle\mathbf{y}=\texttt{SA}(\mathbf{x})=\texttt{SoftMax}\left(\frac{\mathbf{Q}\>\mathbf{K}^{T}}{\sqrt{d_{k}}}\right)\mathbf{x}=\mathbf{A}(x)\>\mathbf{x},
$$
$$
\displaystyle\text{where }\quad\mathbf{Q}=\mathbf{x}\>\mathbf{W}_{Q},\quad\mathbf{K}=\mathbf{x}\>\mathbf{W}_{K},
$$

In this equation, the matrix $\mathbf{A}(x)$ contains the normalized attention scores between each pair of tokens. Which defines the mapping between each output token and all tokens in the input sequence.<sup>5</sup> Using this, the average attention distance (dosovitskiy2020image) is defined as:

$$
\displaystyle d(m,n)=\sum_{n=1}^{m}\mathbf{A}(x)_{m,n}\times(m-n)
$$

where each row of the attention matrix forms a probability distribution over distances (ben2024decimamba), as they lie in the $(L-1)$ -simplex (*i.e.* the rows sum to 1).

In contrast, expressing a closed-form mapping between input and output tokens for $\mathbf{y}=\texttt{MS-SSM}(\mathbf{x})=f(\mathbf{x})$ is not straightforward. Therefore, we rely on the Jacobian of the output with respect to the input to describe how the sequence is transformed by a MS-SSM layer. The Jacobian matrix defined as the collection of the gradient of each output token with respect to the input sequence: ${\bm{J}}_{f}=\begin{bmatrix}\nabla^{\mathrm{T}}f_{1}\\
\vdots\\
\nabla^{\mathrm{T}}f_{L}\end{bmatrix}$. We define the *mean mixing distance* for MS-SSM as:

$$
\displaystyle d(m,n)=\sum_{n=1}^{m}\frac{|{\bm{J}}(x)_{m,n}|}{|\sum_{k=1}^{m}{\bm{J}}(x)_{m,k}|}\times(m-n)
$$

where the Jacobian is normalized row-wise to form a probability distribution over the distance analogous to attention-based models. In classification tasks, we compute $d(m,L)$, the mean mixing distance for the last token, as a measure of the ERF, capturing how far dependencies extend across the sequence in MS-SSM.

As the results in Table 6 highlights, MS-SSM achieves a significantly higher mean mixing distance than Mamba, indicating its superior ability to attend to distant contexts, thereby capturing long-range dependencies in the sequence more effectively.

![[Uncaptioned image]](https://arxiv.org/html/2512.23824v1/FigureTable/mean_mixing_distance_ListOps.jpg)

Table 6: Comparison of Mean Mixing Distance between Mamba and MS-SSM on the ListOps dataset. The metric d ( m, L ) d(m,L), as defined in ( 6 ), is averaged across all channels and layers in the model.

### A.4 Efficient Implementation of Multi-scale Decomposition Layer.

While computation of multi-scale decomposition (2.2) requires sequential application of a convolution layer, this filtering scheme is actually linear time-invariant (LTI) and can be implemented using linear convolution layers. Composing two linear convolution layers $\varphi_{1}$ and $\varphi_{2}$ with kernel sizes $K_{1}$ and $K_{2}$, respectively, yields a single linear convolution layer $\varphi_{1:2}=\varphi_{1}*\varphi_{2}$ with an effective kernel size of $K_{1}+K_{2}-1$. This property enables us to transform this sequential linear convolutions into a parallel application of array of filter banks during inference. When the filter length and number of levels are limited, this approach can potentially accelerate multi-resolution decomposition by leveraging specialized implementations of convolution units available on modern hardware accelerators, resulting in a more hardware-efficient solution.

## Appendix B Experimental Details

For all the experiments, we use the same experimental setup as smith2023simplified and shi2023MULTIRESCONV. The results of baselines are either from the original papers, or are reported by shi2023MULTIRESCONV and/or qin2024hgrn2.

### B.1 Image Classification

We employ the Vision Transformer (ViT) architecture (dosovitskiy2020image), integrating MS-SSM as the core block. The models are evaluated on two image classification tasks: sCIFAR (shi2023MULTIRESCONV) and ImageNet-1K (krizhevsky2012imagenet).

##### sCIFAR-10:

For the sCIFAR-10 dataset, each image is transformed into a sequence of pixels with size 1024 and 3 channels, and the model is built using a ViT architecture (dosovitskiy2020image) consisting of 10 layers with a hidden size of 256 and filter size of 2. The Adam optimizer with standard settings ($\beta_{1}=0.9,\beta_{2}=0.999$) and a learning rate of 0.0045 was used, along with a linear warmup over the first 1 epoch. A weight decay of 0.01 was applied as regularization. We use $S=3$ and $N=128$. The model was trained on A6000 GPUs for 250 epochs with a batch size of 50.

##### ImageNet-1K:

In the case of ImageNet-1K, images were divided into patches of $16\times 16$ pixels, and we trained a ViT-base architecture (dosovitskiy2020image) with 24 layers and a hidden size of 256. Training was conducted using the Adam optimizer with a base learning rate of 1e-3 and its standard settings ($\beta_{1}=0.9,\beta_{2}=0.999$). The learning rate scheduler included a linear warmup for the first 10 epochs, followed by a cosine decay. MS-SSM was trained for 300 epochs using 4xA6000 GPUs with a batch size of 1024. Each MS-SSM layer consists of a multi-scale convolution with $S=3$ scales, each convolution having a length of $K=4$, and SSMs with a latent state size of $N=128$.

##### ListOps:

We use the setting of Long-range Arena (tay2020long) benchmark and pad all sequences to the length of 2048 and then use an embedding layer to encode them into 128 channels. We use 20 layers of MS-SSM to mach the number of parameters of other models in the benchmark study. In MS-SSM we choose filter size as 4 and dimension of 128. The model is trained for 100 epochs with batch size of 50. Following shi2023MULTIRESCONV, we use AdamW optimizer with a weight decay rate 0.03, learning rate of 0.003 after 1 epoch of linear warmup, and a dropout rate 0.1. The batch normalization is used instead of layer normalization. We use $S=3$ and $N=128$.

##### Long Range Arena:

We use the settings from Long Range Arena benchmark (tay2020long) but to match the number of parameters, we use $\times 2$ of the number of layers for Transformers.

##### PTB-XL

In this dataset, we have 12 channels, each of which has 1000 timestamps. All the architectural setting for this experiment is the same as the CIFAR10 but instead of batch normalization, we use layer normalization. We use dropout rate of 0.2 and the AdamW optimizer with weight decay rate 0.06. The network is train for 5 warmup epochs and then 95 epochs of cosine learning rates.

## Appendix C Additional Experiments and Ablations

### C.1 Ablations

In this section, we compare our initialization with the Mamba’s initialization. The results are reported in Table 7. As expected, the scale-dependent initialization scheme proposed in this work is more effective and MS-SSM achieve better performance when using such initialization.

Table 7: Ablation studies on the initialization of MS-SSM.

<table><thead><tr><th></th><th>Method</th><th>PTB-XL</th><th>ListOps</th></tr><tr><th colspan="4">Base</th></tr></thead><tbody><tr><th>1</th><th>MS-SSM</th><td>0.939</td><td>63.04</td></tr><tr><th>2</th><th>Mamba’s Initialization</th><td>0.928</td><td>57.49</td></tr></tbody></table>