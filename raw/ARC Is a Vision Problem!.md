---
title: "ARC Is a Vision Problem!"
source: "https://arxiv.org/html/2511.14761"
author:
published:
created: 2026-09-19
description:
tags:
  - "clippings"
---
Keya Hu    Ali Cy    Linlu Qiu    Xiaoman Delores Ding Affiliation: Runqian Wang    Yeyin Eva Zhu    Jacob Andreas    Kaiming He Affiliation: MIT

###### Abstract

The Abstraction and Reasoning Corpus (ARC) is designed to promote research on abstract reasoning, a fundamental aspect of human intelligence. Common approaches to ARC treat it as a language-oriented problem, addressed by large language models (LLMs) or recurrent reasoning models. However, although the puzzle-like tasks in ARC are inherently visual, existing research has rarely approached the problem from a vision-centric perspective. In this work, we formulate ARC within a vision paradigm, framing it as an image-to-image translation problem. To incorporate visual priors, we represent the inputs on a “canvas” that can be processed like natural images. It is then natural for us to apply standard vision architectures, such as a vanilla Vision Transformer (ViT), to perform image-to-image mapping. Our model is trained from scratch solely on ARC data and generalizes to unseen tasks through test-time training. Our framework, termed Vision ARC (VARC), achieves 60.4% accuracy on the ARC-1 benchmark, substantially outperforming existing methods that are also trained from scratch. Our results are competitive with those of leading LLMs and close the gap to average human performance.<sup>1</sup>

## 1 Introduction

![Refer to caption](https://arxiv.org/html/2511.14761v1/Teaser.png)

Figure 1: The ARC benchmark (top) consists of a collection of many different tasks, where each task has a few ( e.g., 2-4) examples. We propose the Vision ARC ( VARC ) framework, which addresses the ARC problem as an image-to-image translation problem, from a computer vision perspective (bottom). In this illustration, the underlying concepts of the three tasks can be roughly described by humans as: “ reflection ” (left), “ symmetry ” (middle), and “ gravity ” (right). These concepts are closely related to the visual and physical world.

Learning and abstracting concepts from a small number of demonstrations is a key feature of intelligence. The Abstraction and Reasoning Corpus (ARC) benchmark [^14] was designed to incentivize machine learning research aimed at improving these capabilities. ARC consists of a collection of puzzle-like tasks (Fig. 1, top), each containing only a few examples governed by a unique underlying transformation rule. The model is expected to make predictions on each unseen task given a few examples. While humans are capable of solving various ARC tasks [^25] [^31] [^32], the benchmark remains highly challenging for today’s leading machine learning systems [^44] [^42].

The ARC problem has attracted significant attention, and substantial progress has been made in recent years [^13]. Among a wide variety of methods, those based on large language models (LLMs) have proven highly competitive. These methods generally convert ARC inputs into sequences of text tokens for language modeling. Representative methods may involve inductive reasoning [^54] [^7] [^50] [^6], transductive reasoning [^1] [^19] [^45], or a combination of both [^34] [^8] [^40]. The LLMs are pre-trained on internet-scale data, from which they learn transferable common sense.

Most recently, research on recurrent models [^53] [^27] has achieved impressive results on ARC without relying on internet-scale data. These models are trained from scratch on ARC data only and perform inference through recurrent, iterative reasoning. Although they do not rely on large-scale language pre-training, these recurrent models draw strong inspiration from the success of language modeling.

![Refer to caption](https://arxiv.org/html/2511.14761v1/solved_unsolved_3.png)

Figure 2: Examples of unseen tasks solved by VARC. Each panel shows an unseen test task, with demonstrations on the top and the model’s prediction on the bottom. VARC correctly solves these challenging tasks.

Interestingly, although the ARC puzzles are typically presented visually, existing research has rarely framed ARC as a vision-centric problem. In fact, many concepts in ARC are inherently visual and physical: *e.g*., reflection, symmetry, and gravity, as shown in Fig. 1. Humans can solve these tasks not merely from the demonstrations, but by reasoning through analogy to their common sense obtained from external experience. Such common sense can be acquired through observing the world, particularly, the visual world.

Motivated by its visual nature, we approach ARC from a vision-centric perspective. We frame each puzzle as an image-to-image translation problem. Abstraction and inference can arise directly from visual learning, without explicit linguistic intermediates. This perspective connects ARC to classical image-to-image problems, ranging from low-level image processing (*e.g*., [^16] [^43]) to high-level image understanding (*e.g*., [^38] [^46]). With this connection, we can apply standard vision models (*e.g*., Vision Transformers [^17] or convolutional networks [^30]) to tackle the ARC problem.

We demonstrate that incorporating visual priors is crucial. These priors include 2D spatial locality, translation invariance, and scale invariance. To facilitate learning these priors, we represent the inputs on a “canvas” with flexible geometric transformations, allowing the inputs to be processed as if they were natural images. A patch on the canvas can consist of exponentially many color combinations, which helps reduce overfitting and encourages the model to learn spatial priors rather than merely memorize.

With the vision-centric formulation, we train our model from scratch using ARC-only data. At inference time, when presented with a new, unseen task, we perform test-time training [^9] [^24] [^49] [^1] [^53] [^27] to adapt the model to the task, enabling it to generalize from only a few examples.

Our framework, termed Vision ARC (VARC), shows strong performance on the ARC benchmarks (*e.g*., Fig. 2). VARC achieves 54.5% accuracy on the ARC-1 benchmark, using a small model with only 18 million parameters. This result substantially surpasses the best recurrent methods [^53] [^27] that are also trained from scratch on ARC. It is also competitive with many popular LLM-based methods. Combining VARC models through ensembling [^29] further improves accuracy to 60.4%, matching the reported average human performance [^31] on the ARC-1 dataset.

We hope our research will shed light on the ARC problem, and more broadly, on the field of abstract reasoning. On the one hand, the design of the ARC benchmark is based on human observations and induced rules abstracted from the visual and physical world. It is natural to explore vision-driven approaches for ARC. On the other hand, human reasoning is not confined to language or vision in isolation, but instead should integrate information across modalities. With our complementary vision-based perspective, we hope the scope of abstract reasoning will be further broadened. We invite the vision community to study the ARC problem and to advance research on abstract reasoning.

## 2 Related Work

#### Visual reasoning.

Visual reasoning is a long-standing research problem. It involves not only perceiving scenes and objects, but also inferring and abstracting the relations and transformations among them. The advancement of machine learning methods has led to the development of a variety of challenging protocols, such as VQA [^5] [^56] [^20], CLEVR [^26], and Winoground [^51].

The visual reasoning methods developed under these protocols typically consist of a visual perception module and a language-like recurrent module, *e.g*., within the neuro-symbolic framework [^4] [^23] [^3] [^41]. These methods have evolved into modern vision-language models (VLMs, *e.g*., [^2] [^33] [^37]), in which images are converted into tokens and processed jointly with text.

Unlike ARC, classical visual reasoning protocols generally involve a training set and a test set, both of which can be viewed as instances of the same task. In contrast, ARC consists of a large collection of distinct tasks, each defined by only a few examples.

#### Approaches to ARC.

Owing to the “few-shot, many-task” nature of ARC, LLMs have been regarded as a natural solution. A new task can be converted into a sequence of tokens, treated as a prompt, and processed by LLMs via in-context few-shot learning [^55] [^10]. We refer the reader to [^13] for a comprehensive survey.

Recently, recurrent models [^53] [^27] have been proven effective for ARC, without the requirement of internet-scale pre-training. These models aim to mimic the hierarchical and multi-timescale processing of the human brain [^53] for reasoning. At inference time, these methods adopt test-time training [^9] [^24] [^49] on the few demonstration examples.

Related to our work, the ViT-ARC method [^35] attempts to address the ARC problem using vision models. However, this method has only shown the ability to fit individual tasks in the training set; it is unable to generalize or solve any unseen test task. As such, this method has not been able to satisfy the ARC protocol, whose essence lies precisely in few-shot, cross-task generalization. Unlike [^35], our framework is designed to address the “few-shot, many-task” nature of ARC.

## 3 ARC as a Vision Problem

![Refer to caption](https://arxiv.org/html/2511.14761v1/problem_formulation.png)

Figure 3: The ARC problem definition. ARC is a collection of many different tasks. For each task, a few ( e.g., 2-4) demonstration pairs ( x, y ) (x,y) are given, and the model is required to infer the output from infer x\_{\\textrm{infer}}. The training set 𝒯 train \\mathcal{T}\_{\\textrm{train}} is a collection of 400 tasks, which can be used for model training. The test set test \\mathcal{T}\_{\\textrm{test}} contains 400 new tasks: the demo pairs of a new task are given only at inference time, based on which the model performs inference on

### 3.1 ARC Problem Definition

The ARC benchmark consists of several hundred very few-shot (*e.g*., 2 to 4-shot) reasoning tasks. Each task, denoted by $T$, involves a unique underlying transformation rule, mapping from an input $x$ to an output $y$. Here, $x$ and $y$ are both 2D grids with maximum size $30{\times}30$, in which each location has one of $C$ different color indexes (*e.g*., $C{=}10$). The ARC problem definition is illustrated in Fig. 3, which we discuss next.

#### A task.

A “task” is the basic unit in ARC. Each task includes a few demonstration examples. For a demonstration pair $(x,y)$, both $x$ and $y$ are known to the model. We denote the demonstration set of task $T$ as: $\mathcal{D}_{\textrm{demo}}^{T}{=}\big\{(x_{i},y_{i})\big\}_{i=1}^{m}$, where $m$ is the number of pairs (*e.g*., $m$ is 2 to 4). Each task $T$ also contains a few inference examples, denoted as: $\mathcal{D}_{\textrm{infer}}^{T}{=}\big\{(x_{i},y_{i})\big\}_{i=1}^{n}$ ($n$ is 1 or 2). At inference time, only the demo pairs $\mathcal{D}_{\textrm{demo}}^{T}$ and one input $x_{\textrm{infer}}\in\mathcal{D}_{\textrm{infer}}^{T}$ are given, and the model is required to infer the desired output $y_{\textrm{infer}}$.

#### Training set.

The training set consists of multiple tasks used to train the model offline (*i.e*., before a new task is given). We denote the training set as: $\mathcal{T}_{\textrm{train}}{=}\{T_{i}\}_{i=1}^{k}$, where $k$ is the number of tasks (400 in ARC-1). Following standard machine learning protocols, samples in $\mathcal{D}_{\textrm{demo}}^{T}$ for any $T\in\mathcal{T}_{\textrm{train}}$ can be used for training. The “inference” samples in the training set, that is, $\mathcal{D}_{\textrm{infer}}^{T}$ for any task $T\in\mathcal{T}_{\textrm{train}}$, are used for validating the training process only.

#### Test set.

The test set is a collection of new tasks, which are not seen during offline training. We denote the test set as: $\mathcal{T}_{\textrm{test}}{=}\{T_{i}\}_{i=1}^{l}$, with $l$ different test tasks. Note that any test task is a “complete” and new task: that is, for any $T\in\mathcal{T}_{\textrm{test}}$, there also exists a demo set $\mathcal{D}_{\textrm{demo}}^{T}$, and the pairs $(x,y)$ in $\mathcal{D}_{\textrm{demo}}^{T}$ are given to the model at inference time. The model should make use of $\mathcal{D}_{\textrm{demo}}^{T}$ to infer the output of the given $x_{\textrm{infer}}$ for this new task.

The presence of new $(x,y)$ pairs in $\mathcal{D}_{\textrm{demo}}^{T}$ at inference time allows to perform test-time training [^49] [^1] [^9] [^24], which we adopt and will discuss.

### 3.2 Image-to-Image Translation

With these definitions, we formulate reasoning on each task as an image-to-image translation problem. We frame the problem as per-pixel classification, analogous to the semantic segmentation problem [^38].

Formally, we learn a neural network $f_{\theta}$ parameterized by $\theta$. The network $f_{\theta}$ takes an image $x_{i}$ as input, conditioned on a task token associated with the task $T$. The task token is represented as a learnable embedding dependent on $T$. The output of $f_{\theta}$ is a grid where each position represents a categorical distribution. The overall objective function is simply the per-pixel cross-entropy loss [^38]:

$$
\mathcal{L}(\theta)=\mathbb{E}_{T,i}\big[\mathcal{D}(y_{i},\,f_{\theta}(x_{i}\mid T))\big].
$$

Here, $\mathcal{D}$ denotes the per-pixel cross-entropy loss between the ground-truth $y_{i}$ and the network output.

### 3.3 Visual Modeling

Previous methods on ARC generally operate in the space of discrete-valued tokens, motivated by the design of language models. In our formulation of image-to-image translation, we explore native designs developed for vision.

#### Canvas.

While it is straightforward to view the raw $H{\times}W$ grid as an $H{\times}W$ image, we propose more flexible transformations to represent it in a manner similar to natural images.

We define the concept of a “canvas”. A canvas has a predefined and sufficiently large size, *e.g*., $64{\times}64$. The raw input is transformed and placed onto this canvas. This formulation naturally accommodates translation and scale augmentations, which are common strategies for introducing translation and scale invariance in vision, discussed next. We set the background of the canvas to an additional background color, *i.e*., the $(C{+}1)$ -th color.

When applying a ViT model (discussed next), if we naïvely treat each raw pixel as a token, there would be only $C$ distinct tokens. In contrast, our canvas formulation supports a much larger set of local, patch-level configurations. For example, with a patch size of $2{\times}2$ (see Fig. 5), a single patch can contain multiple colors and, in principle, has an exponentially large cardinality, $O(C^{2{\times}2})$. This formulation is important for improving generalization performance.

Figure 4: The raw input undergoes random scale and translation transformations and is placed on the “canvas” (denoted in gray).

#### Translation and scale invariance.

The “canvas” concept enables us to flexibly apply translation and scale augmentations, which are critical in standard vision models. Theses data augmentations encourage the model to learn underlying mappings invariant to geometric transformations grounded in the visual world. Formally, we perform:

- Scale augmentation: Given a raw input, we randomly resize it by an integer scaling ratio $s$, duplicating each raw pixel into $s{\times}s$ (see Fig. 4, left). This is analogous to nearest-neighbor interpolation in natural images. However, note that “colors” in ARC do not correspond to real-world colors, so it is not meaningful to perform other interpolations (such as bilinear).
- Translation augmentation: given the scaled grid, we randomly place it on the fixed-size canvas. We ensure all pixels are visibile. See Fig. 4 (right).

We empirically show that these visual priors are important for generalization to unseen tasks.

#### Vision Transformer.

Given a canvas with an input randomly placed, we perform image-to-image translation by a standard vision model. By default, we use a ViT [^17].

The principle of ViT is Transformer on patches. Formally, the input canvas is divided into non-overlapping patches (*e.g*., 2 $\times$ 2), projected by a linear embedding, added with positional embedding [^52], and processed by a stack of Transformer blocks [^52]. The model has a linear projection layer as the output, which performs per-pixel classification for each patch. Note that unlike natural images where each raw pixel has continuous values, in our case, the raw pixels have discrete values. Therefore, before patchification, we first map each pixel’s discrete index into a learnable continuous-valued embedding.

![Refer to caption](https://arxiv.org/html/2511.14761v1/architecture2.png)

Figure 5: The ViT architecture in VARC. The input is randomly placed on a canvas, which is then treated as a natural image and processed by a standard ViT, conditioned on the task token.

Conceptually, patchification can be viewed as a special form of convolution. Like convolution, it incorporates several critical inductive biases in vision: most notably, locality (*i.e*., grouping nearby pixels) and translation invariance (*i.e*., weight sharing across locations).

#### 2D positional embedding.

Unlike language data, which is generally modeled as 1D sequences, images are inherently 2D. This 2D structure can be lost if we naïvely treat the embedded patches as a 1D sequence. We empirically show that explicitly modeling positions in 2D is essential.

Formally, we adopt separable 2D positional embeddings, following [^11]: with $D$ channels for positional embeddings, we use the first half of the channels to embed the horizontal coordinate and the second half to embed the vertical coordinate. This can be applied both to additive positional embeddings for encoding absolute positions and to the encoding of relative positions (*e.g*., RoPE [^48]).

#### Alternative: convolutional networks.

Beyond ViT, we also study the more classical vision-based architecture, *i.e*., convolutional neural networks [^30]. Specifically, we adopt the U-Net model [^46], a hierarchical convolutional network. The original U-Net was proposed precisely for the image-to-image translation problem of segmentation [^46], making it a natural candidate for the problem we consider.

### 3.4 Two-stage Training

We adopt a two-stage training paradigm to learn the parameters of the neural network.

#### Offline training.

This stage is applied on the entire training set $\mathcal{T}_{\textrm{train}}$. It is on all demos $\mathcal{D}_{\textrm{demo}}^{T}$ for any $T\in\mathcal{T}_{\textrm{train}}$. We train one model $f_{\theta}$ jointly for all $k$ training tasks (*e.g*., $k{=}400$), based on the loss in Eq. 1. All tasks share the same parameters, only except that each task has its own task-conditional token. We do not use the inference set $\mathcal{D}_{\textrm{infer}}^{T}$ from the training tasks (*i.e*., $T\in\mathcal{T}_{\textrm{train}}$) to train the model. These sets are used only for validation purposes.

![Refer to caption](https://arxiv.org/html/2511.14761v1/test-time_training_learning_process_2.png)

Figure 6: Effect of test-time training. (Top): Demonstration examples for the current task. (Bottom left): An inference example x infer x\_{\\textrm{infer}}. (Bottom right): During test-time training, the prediction from becomes progressively more accurate, with the model finally generating the correct prediction.

#### Test-time training (TTT).

Given a single new, unseen task $T\,\in\,\mathcal{T}_{\textrm{test}}$ from the test set, we perform inference by test-time training. At inference time, we are given $\mathcal{D}_{\textrm{demo}}^{T}{=}\big\{(x_{i},y_{i})\big\}_{i=1}^{m}$ with both input and output accessible; the model is required to make prediction for a given $x_{\textrm{infer}}$ in this new task $T$. The test-time training followed by inference can be viewed abstractly as a function $\mathcal{F}(x_{\textrm{infer}}\mid\mathcal{D}_{\textrm{demo}}^{T})\mapsto y_{\textrm{infer}}$.

We perform test-time training for each new task $T$ independently. It has a new task token whose parameters are randomly initialized. As there are very few demo pairs in $\mathcal{D}_{\textrm{demo}}^{T}$ (*e.g*., 2 to 4), we also perform data augmentation. We elaborate on the details in the next section and in appendix.

In summary, at inference time, the model is initialized from offline training, fine-tuned with test-time training only for the single new task $T$, and then performs inference on $x_{\textrm{infer}}$. As the new demo pairs in $\mathcal{D}_{\textrm{demo}}^{T}$ are very few, even with data augmentation, this test-time training process remains reasonably fast (*e.g*., 70 seconds per task on a single GPU). Fig. 6 visualizes the effect of test-time training.

### 3.5 Inference

After test-time training, we apply $f_{\theta}$ to $x_{\textrm{infer}}$ to obtain the final prediction. This process is analogous to the classical recognition problems [^29] [^38]. Accordingly, we adopt post-processing strategies inspired by recognition methods.

#### Single-view inference.

Given $x_{\textrm{infer}}$ and a single “view” (*i.e*., with a given scale and translation), we place $x_{\textrm{infer}}$ on the canvas and apply $f_{\theta}$ to predict the output. Since one output location in the raw grid may be predicted by multiple pixels on the canvas (*e.g*., due to rescaling; see Fig. 5), we aggregate all predictions (from softmax outputs) at this location by average pooling.

#### Multi-view inference.

It was a common practice to consolidate the predictions from multiple views (*e.g*., see AlexNet [^29]). Analogously, we adopt multi-view inference to improve accuracy, where the views are sampled with different augmentations. As the multi-view inference cost is negligible compared with test-time training cost, it is virtually nearly free to use many views. We use 510 random views (details are in appendix). Predictions from different views are consolidated by majority voting [^1].<sup>2</sup>

#### Pass@2 accuracy.

The ARC benchmark by default adopts the pass@2 accuracy metric: *i.e*., two different solutions can be produced for evaluation, and a task is considered correct if one is correct. To support this metric, we adopt majority voting in multi-view inference and retain the top-2 most populated output solutions.

## 4 Implementation Details

We describe the major implementation choices in this section. The configuration details can be found in appendix.

#### Canvas.

In our best-performing model, the canvas size is $64{\times}64$. In the case of ViT, the patch size is $2{\times}2$, resulting in a sequence length of $32^{2}$. For scale augmentation, an integer scaling ratio is randomly sampled, such that the scaled grid is no larger than the canvas size. For translation augmentation, the upper-left corner is randomly sampled under the constraint that the placed image is fully visible.

#### Offline training.

We use the standard ARC-1 training set $\mathcal{T}_{\textrm{train}}$ for training: it has 400 tasks with 2-4 demo pairs each. Following common practice on ARC, we also expand our training set with the RE-ARC set [^22], from which we sample 1,000 additional demo pairs per task. Put together, our full training set has about 400k sample pairs. We apply translation and scale augmentation in offline training.

#### Test-time training.

Given an unseen task $T\in\mathcal{T}_{\textrm{test}}$, we have 2-4 sample pairs in $\mathcal{D}_{\textrm{demo}}^{T}$. To make test-time training more feasible, we also augment the single task $T$ into multiple auxiliary tasks. We do this by using standard augmentation from existing ARC methods: flip, rotation (by 90 <sup>∘</sup>, 180 <sup>∘</sup>, or 270 <sup>∘</sup>), and color permutation. We treat each of these test-time training augmentations as an auxiliary task, each assigned a task embedding. We also apply translation and scale augmentation in test-time training, but we do not view them as a new auxiliary task (under the assumption that all auxiliary tasks are translation and scale invariant).

## 5 Experimental Results

Our experiments are primarily conducted on the benchmark of ARC-1 [^14]. We report the pass@2 accuracy (referred to simply as “accuracy” hereafter) in percentage (%). To support pass@2 evaluation, we adopt multi-view inference. We also report final results on ARC-2 [^12].

We evaluate our model on the ARC-1 evaluation set (*i.e*., $\mathcal{T}_{\textrm{eval}}$). This set is conceptually a test set (see Fig. 3), but with ground truth available only for computing accuracy.

Figure 7: Effects of visual priors in VARC. Accuracy is reported on the ARC-1 evaluation set. The model used is ViT-18M. Entries (a-c) use a patch size of $1{\times}1$ on a $32{\times}32$ canvas, whereas entries (d-f) use a patch size of $2{\times}2$ on a $64{\times}64$ canvas. Each entry modifies the one above it. We start from a naïve baseline with components (b-f) removed. These vision priors cumulatively yield 27.7 improvement (a $\to$ f), in which the canvas-based designs (c $\to$ f) contribute an 11.5 gain.

### 5.1 Visual Priors

Fig. 7 summarizes the effects of visual priors, starting from a baseline (a) without the other components in this figure. These priors jointly have a gain of 27.7 points, where the canvas-based designs (c $\to$ f) has a gain of 11.5 points. We discuss these components as follows.

#### 2D positional embedding.

Extending from 1D positional embedding to its 2D counterpart is beneficial: see Fig. 7(b)(c). This is observed in both (b) absolute and (c) relative positional embeddings.

To demonstrate this effect on a stronger baseline, we replace the 2D RoPE in Fig. 7(f) with a 1D RoPE and observe a degradation of 3.5 points, from 54.5 to 51.0.

#### Patchification.

A key design principle of our method is to prepare the input as a natural image. This enables the expansion of the token set from a very limited size (*e.g*., 10) to an exponentially large number. The entries Fig. 7(d-f) all benefit from this design.

In Fig. 7(d), we advance from 1 $\times$ 1 patches on a 32 $\times$ 32 canvas to 2 $\times$ 2 patches on a 64 $\times$ 64 canvas. Doing so does not increase the computational cost of the Transformer. In this ablation (d), the scaling ratio is fixed as 2 $\times$. As such, if we constrain each 2 ${\times}$ 2 patch to cover only one raw pixel, it becomes equivalent to the 1 ${\times}$ 1 patch counterpart on the 32 ${\times}$ 32 canvas. Therefore, to ensure a meaningful comparison, we do not impose this constraint, allowing each $2{\times}2$ patch to cover multiple colors. This can be interpreted as one-pixel translation augmentation on the canvas.

Even so, the 2 ${\times}$ 2 patchification leads to a noticeable gain of 2.4 points, improving from 43.0 to 45.4; see Fig. 7(c,d). In spite of the small one-pixel augmentation, each patch can cover multiple colors (as in natural images), which substantially enriches the data space for learning.

<table><tbody><tr><td>model</td><td>width</td><td>depth</td><td>#params</td><td>Gflops</td><td>acc.</td></tr><tr><td rowspan="3">ViT</td><td>384</td><td>5</td><td>6M</td><td>10</td><td>44.4</td></tr><tr><td>512</td><td>10</td><td>18M</td><td>28</td><td>54.5</td></tr><tr><td>768</td><td>20</td><td>66M</td><td>99</td><td>53.0</td></tr><tr><td rowspan="3">U-Net</td><td colspan="2">setting (a)</td><td>7M</td><td>18</td><td>42.8</td></tr><tr><td colspan="2">setting (b)</td><td>17M</td><td>33</td><td>47.5</td></tr><tr><td colspan="2">setting (c)</td><td>55M</td><td>87</td><td>48.3</td></tr></tbody></table>

Table 1: Vision backbones. We compare variants of ViTs and U-Nets of similar sizes. U-Net settings are in appendix.

![Refer to caption](https://arxiv.org/html/2511.14761v1/model_size_scaling.png)

Figure 8: Scalability: ViTs with different width (x-axis) and depth. The circle areas denote model sizes.

#### Translation and scale augmentation.

In image recognition, even highly capable network architectures still benefit greatly from translation and scale augmentations. We draw similar observations in ARC. See Fig. 7(e,f).

In Fig. 7(e), we apply fully flexible translation augmentation on the canvas. Compared with the “one-pixel” augmentation in Fig. 7(d), this setting yields an additional gain of 2.9 points (from 45.4 to 48.3). In Fig. 7(f), we further apply the scale augmentation enabled by the concept of canvas. Scale augmentation yields a substantial gain of 6.2 points. Unlike translation invariance, which can be partially addressed by patchification (*i.e*., a special form of convolution), the ViT architecture has little to no inductive bias about scale invariance. This can explain why scale augmentation yields a substantial gain.

### 5.2 Other Ablation Experiments

#### ViT vs. U-Net.

In Tab. 1, we compare ViT with U-Nets, a type of convolutional network. We evaluate three model sizes for each architecture. Although ViTs consistently perform better, all U-Net variants achieve decent accuracy, suggesting that this problem can also be effectively addressed by classical vision backbones.

#### Scalability.

In Fig. 8, we show ViTs with varying depths and widths. In this regime, our method demonstrates good scalability: increasing depth and/or width leads to higher accuracy as a result of better fitting. Going beyond this regime can lead to overfitting in our current setting, as shown in Tab. 1 for the 66M ViT model. We observe that this larger model achieves higher training accuracy, suggesting that future research should focus on generalization.

#### Test-time training (TTT) strategies.

In Fig. 9(b), we study TTT with and without offline training, and TTT performed jointly on all test tasks *vs*. independently for each test task.

As expected, offline training greatly improves the performance of TTT, suggesting that common sense about the visual world can be learned from the training set. We also note that even without offline training, our TTT strategy can achieve nontrivial accuracy (26.4), suggesting that some tasks in this benchmark can be solved tabula rasa. This result outperforms that in [^36] under a similar setting.

Surprisingly, performing TTT independently for each test task yields substantially better performance (by $\scriptstyle\sim$ 10 points) than doing so jointly across all test tasks, even though the latter relies on a stronger assumption about the availability of multiple test tasks at once.<sup>3</sup> We hypothesize that overtraining on the test tasks may cause the model to forget the knowledge acquired during offline training.

#### Single-view vs. multi-view inference.

As discussed in Sec. 3.5, we adopt multi-view inference by default. For completeness, we also examine the single-view inference accuracy. Since single-view inference cannot produce multiple predictions, we compare pass@1 accuracy. See Tab. 2.

| single-view, pass@1 | multi-view, pass@1 | multi-view, pass@2 |
| --- | --- | --- |
| 35.9 | 49.8 | 54.5 |

Table 2: Single-view *vs*. multi-view inference.

Single-view inference has a decent pass@1 accuracy of 35.9; multi-view inference further boosts to 49.8, thanks to majority voting. Unlike typical computer vision applications such as semantic segmentation, in ARC, a mistake on even a single pixel renders the entire prediction incorrect. This may explain the large gain seen here.

<table><tbody><tr><th>system</th><th>#params</th><td>ARC-1</td><td>ARC-2</td></tr><tr><th colspan="4">large language models (LLMs)</th></tr><tr><th>Deepseek R1 <sup><a href="#fn:21">21</a></sup></th><th>671B</th><td>15.8</td><td>1.3</td></tr><tr><th>Claude 3.7 8k <sup><a href="#fn:18">18</a></sup></th><th>N/A</th><td>21.2</td><td>0.9</td></tr><tr><th>o3-mini-high <sup><a href="#fn:18">18</a></sup></th><th>N/A</th><td>34.5</td><td>3.0</td></tr><tr><th>GPT-5 <sup><a href="#fn:18">18</a></sup></th><th>N/A</th><td>44.0</td><td>1.9</td></tr><tr><th>Grok-4-thinking <sup><a href="#fn:18">18</a></sup></th><th>1.7T</th><td>66.7</td><td>16.0</td></tr><tr><th>Bespoke (Grok-4) <sup><a href="#fn:8">8</a></sup></th><th>1.7T</th><td>79.6</td><td>29.4</td></tr><tr><th colspan="4">recurrent models</th></tr><tr><th>HRM <sup><a href="#fn:53">53</a></sup></th><th>27M</th><td>40.3</td><td>5.0</td></tr><tr><th>TRM <sup><a href="#fn:27">27</a></sup></th><th>7M</th><td>44.6</td><td>7.8</td></tr><tr><th colspan="4">vision models</th></tr><tr><th>VARC</th><th>18M</th><td>54.5</td><td>8.3</td></tr><tr><th>VARC (ensemble)</th><th>73M</th><td>60.4</td><td>11.1</td></tr><tr><th colspan="4">human results</th></tr><tr><th>avg. human <sup><a href="#fn:31">31</a></sup></th><th>-</th><td>60.2</td><td>-</td></tr><tr><th>best human <sup><a href="#fn:18">18</a></sup></th><th>-</th><td>98.0</td><td>100.0</td></tr></tbody></table>

Table 3: System-level comparisons on the ARC-1 and ARC-2 benchmarks. LLM-based results are from the ARC-AGI leaderboard [^18]. HRM, TRM, and our VARC are trained from scratch only on ARC data. Our single-model result is based on ViT, with mean $\pm$ std of 54.5 $\pm$ 0.7 (ARC-1) and 8.3 $\pm$ 0.4 (ARC-2) over four runs. Our ensemble result aggregates an 18M ViT and a 55M U-Net, each with test-time training performed four times.

### 5.3 System-level Comparisons

In Tab. 3 we compare with leading results using LLMs or recurrent models, on ARC-1 and ARC-2.<sup>4</sup>

Our model compares favorably with some of the most powerful LLMs at the time their results were reported: including Deepseek, Claude, o3, and GPT-5 (we note that given the rapid progress of LLMs, these models may have stronger results by the time our paper is public). LLMs are pre-trained on internet-scale data, and some may also incorporate multimodal data that include images. Our method does not rely on such data and uses a model that is several orders of magnitude smaller.

In the controlled setting of training from scratch on ARC data, our method substantially outperforms the recurrent models: HRM [^53] and TRM [^27]. Our VARC with 18M parameters is $\scriptstyle\sim$ 10 points better than TRM on ARC-1, a $>$ 20% relative improvement. Note that, once test-time training is completed, our model performs fully feedforward inference, with no recurrence involved in reasoning.

Following the classical ensembling practice in vision (*e.g*., AlexNet [^29]), we ensemble one ViT and one U-Net, each with test-time training run four times. Doing so boosts our result to 60.4. This result closes the gap with the reported average human performance (60.2 [^31]).

## 6 Visualization and Analysis

![Refer to caption](https://arxiv.org/html/2511.14761v1/attention_each_pixel_v2.png)

Figure 10: Visualization of pixel-to-pixel attention. (Top): a test task from ARC-1 eval: showing demo pairs, inference input, and model prediction. (Middle): attention maps for a single pixel across different layers. With the highlighted pixel as query, we show pre-softmax logits. Different layers exhibit different behavior. (Bottom): attention maps in layer 8 with other query pixels. All of them correctly attend to their corresponding palette pixel.

Beyond numerical metrics, we provide additional qualitative results that help reveal the model’s behavior. We refer readers to the appendix for more visualizations.

#### Attention patterns.

Fig. 10 shows the attention patterns of our ViT model in a test task. These attention maps show that our model can correctly reason about the relationship between a source pixel and its target pixel to copy from.

Figure 11 visualizes the layer-wise attention maps for another test task. A layer-wise map is the softmax attention map averaged across all pixels in the layer: it reveals which pixels receive the most attention in that layer. In this task, different layers exhibit different specialties: some layers attend to the pixels that are to be copied, and some layers attend to the target lines alone the eight directions.

#### t-SNE of task embeddings.

Our model is conditioned on a task token, with an embedding learned to represent each task. With 400 training tasks in ARC-1, our model learns 400 distinct task embeddings in offline training. We visualize these 400 embeddings in the 2D space by t-SNE [^39] (see Fig. 12). Each point corresponds to a task..

Interestingly, we observe that nearby points in the task embedding space exhibit similar semantics. For example, the top-left corner in Fig. 12 shows two tasks related to coloring; the bottom-left corner shows two tasks related to generalized logic operations (*i.e*., AND/OR/XOR). This visualization suggests that our method attempts to learn the relations between different tasks, which is an essential ability for abstraction and reasoning.

![Refer to caption](https://arxiv.org/html/2511.14761v1/heatmap_avg.png)

Figure 11: Visualization of layer-wise attention maps. For each layer, we compute pixel-to-pixel attention and then average the softmax maps across all pixels to obtain a single map per layer. This map reveals which pixels are most attended in this layer. We show a test task from ARC-1 eval. In this task, some layers exhibit strong attention to the 3 × 3\\times 3 neighborhood, reflecting the influence of the pattern’s core. In comparison, some other layers (e.g., layers 7–9) focus on the outward-radiating rays, corresponding to the rule that extends colored pixels along the eight directions.

![Refer to caption](https://arxiv.org/html/2511.14761v1/tsne.png)

Figure 12: t-SNE of task embeddings, on the 400 task tokens learned from the ARC-1 training set. Each point represents a single task. To aid the reader, we provide human-written descriptions for the tasks (which are not used in any form by our method).

## 7 Conclusion

Our work explores a previously overlooked perspective in the ARC task by framing it as an image-to-image translation problem. It naturally enables the adaptation of visual frameworks and yields strong few-shot generalization competitive with recent approaches, while remaining orders of magnitude smaller than most LLM-based models. This opens up a new possibility of treating ARC as a vision-centric problem, emphasizing abstraction and reasoning emerging directly from image pixels.

We hope this work will encourage the community to leverage ARC not only as a symbolic reasoning problem, but also as a testbed for promoting the generalization capacity of visual methods. Future research may extend this direction through more expressive architectures, richer visual priors, or larger-scale image pre-training. We envision that vision-centric reasoning will play a key role in building AI systems capable of learning and applying abstract concepts in a human-like manner.

## References

## Appendix A Additional Implementation Details

### A.1 Configurations

We report the training configurations in Tab. 4. The running time under this configuration is profiled in Tab. 5.

The hyperparameters for our ViT models are listed in Tab. 6, and those for our U-net models are shown in Tab. 7.

<table><thead><tr><th colspan="2">offline training</th></tr></thead><tbody><tr><th>epochs</th><td>100</td></tr><tr><th>warmup epochs</th><td>10</td></tr><tr><th>optimizer</th><td>Adam <sup><a href="#fn:28">28</a></sup>, betas=(0.9, 0.999)</td></tr><tr><th>batch size</th><td>32</td></tr><tr><th>learning rate</th><td>3e-4</td></tr><tr><th>learning rate scheduler</th><td>cosine</td></tr><tr><th>weight decay</th><td>0</td></tr><tr><th>dropout</th><td>0.1</td></tr><tr><th colspan="2">test-time training</th></tr><tr><th>epochs</th><td>100</td></tr><tr><th>warmup epochs</th><td>10</td></tr><tr><th>optimizer</th><td>Adam <sup><a href="#fn:28">28</a></sup>, betas=(0.9, 0.999)</td></tr><tr><th>batch size</th><td>8</td></tr><tr><th>learning rate</th><td>3e-4</td></tr><tr><th>learning rate scheduler</th><td>cosine</td></tr><tr><th>weight decay</th><td>0</td></tr><tr><th>dropout</th><td>0.1</td></tr></tbody></table>

Table 4: Configurations.

<table><thead><tr><th colspan="2">offline training</th></tr></thead><tbody><tr><th>GPU type</th><td>H100</td></tr><tr><th>GPU number</th><td>8</td></tr><tr><th>GPU time</th><td>4.8 hours</td></tr></tbody></table>

<table><thead><tr><th colspan="2">test-time training</th></tr></thead><tbody><tr><th>GPU type</th><td>H100</td></tr><tr><th>GPU number</th><td>1</td></tr><tr><th>GPU time</th><td>0.7s per epoch</td></tr></tbody></table>

Table 5: Running time of the ViT-18M model. The reported time is obtained with torch.compile optimization.

<table><tbody><tr><th>ViT</th><td>6M</td><td>18M</td><td>66M</td></tr><tr><th>hidden dim</th><td>384</td><td>512</td><td>768</td></tr><tr><th>Transformer blocks</th><td>5</td><td>10</td><td>20</td></tr><tr><th># heads</th><td>8</td><td>8</td><td>12</td></tr><tr><th>MLP block hidden dim</th><td colspan="3">512</td></tr><tr><th>dropout</th><td colspan="3">0.1</td></tr><tr><th>patch size</th><td colspan="3">2 <math><semantics><mo>×</mo> <annotation>\times</annotation></semantics></math> 2</td></tr><tr><th>canvas size</th><td colspan="3">64 <math><semantics><mo>×</mo> <annotation>\times</annotation></semantics></math> 64</td></tr></tbody></table>

Table 6: Configuration of the ViT architecture. The 18M model is our default setting.

| U-net | 7M | 17M | 55M |
| --- | --- | --- | --- |
| \# stages | 3 | 3 | 3 |
| layers per stage | 1 | 1 | 2 |
| \# channels at resolution 1 | 80 | 120 | 160 |
| attention at resolution 1 | No | No | No |
| \# channels at resolution 2 | 160 | 240 | 320 |
| attention at resolution 2 | Yes | Yes | Yes |
| \# channels at resolution 3 | 160 | 240 | 320 |
| attention at resolution 3 | Yes | Yes | Yes |
| mid block | No | No | Yes |

Table 7: Configuration of the U-Net architecture. The definition follows standard U-Nets used in generative models [^47] [^15].

### A.2 Test-time Training Augmentation

During test-time training, we augment the single test task $T$ into multiple auxiliary tasks. We use a distinct task embedding for each auxiliary task, as not all of these augmentations correspond to the same underlying rule (*e.g*., consider “gravity” under a 90 <sup>∘</sup> rotation). We apply 2 flippings (horizontal and vertical) or 3 rotations (in multiples of 90 <sup>∘</sup>), and 10 predefined color index permutations, resulting in $(2{+}3){\times}10{=}50$ auxiliary tasks with the original task. We train for 100 epochs on these 51 tasks, covering $100\times 51\times 3=15.3$ k samples in total for test-time training for one test task $T$ (assuming 3 raw samples in this task).

### A.3 Shape Handling

Figure 13: Shape Handling. The gray pixels denote the background tokens \[BG\], which keep the canvas size fixed (64 $\times$ 64 by default). The white pixels denote the border tokens \[BD\], which indicate the output shape. (Left): a pair $(x,y)$ with a scaling ratio of $1{\times}$. (Right): a pair $(x,y)$ with a scaling ratio of $2{\times}$.

Unlike standard semantic segmentation, in ARC, the raw input and output sizes are not always identical (*e.g*., see Fig. 3, Test Set, Task 1). This issue can be addressed on the canvas in a unified framework. In our method, the input/output canvas always has a fixed size and is filled with a background token \[BG\]. In addition, when the raw output is placed on the canvas (serving as the ground truth during training), we always use an extra border token, \[BD\], to indicate the right and bottom edges. Specifically, the token \[BD\] is filled along the one-pixel-wide edge on the right and bottom sides. During inference, we locate the rightmost and bottommost \[BD\] tokens and crop the output accordingly to recover the final predicted shape. This is illustrated in Fig. 13.

Since the number of background pixels \[BG\] can dominate in some examples, we apply attention masks in the self-attention blocks to encourage the model to focus on the foreground pixels. The attention masks are applied after the query-key dot-product computation, adding a large negative value to the keys corresponding to background inputs. The resulting softmax attention scores are therefore zero at those key positions. Moreover, during training, the loss is computed only on locations where the inputs are not background pixels \[BG\]. These designs encourage the model to pay more attention to foregrounds and therefore improve accuracy, although we note that even without them, our method still performs competitively, as observed in our preliminary experiments.

## Appendix B Additional Experiments

### B.1 Offline Training Data Scaling

Figure 14: Offline training data scaling: effect of varying the number of RE-ARC samples per task, evaluated on the ARC-1 eval set. Increasing the amount of offline training data is beneficial, although even without it, our model can achieve decent accuracy.

Figure 15: Offline training task diversity scaling: effect of varying the number of training tasks, evaluated on the ARC-1 eval set. Increasing task diversity is beneficial.

Since we use the RE-ARC dataset [^22] in our offline training, we can examine the effect of data scale provided by RE-ARC. See Fig. 14. Using only the original ARC training data, without any RE-ARC data, our method achieves a decent accuracy of 31.5. By adding 10, 100, and 1,000 pairs per task from RE-ARC, the accuracy increases to 38.6, 52.3, and 54.0, respectively. This comparison suggests that increasing the amount of offline training data is beneficial, although the returns diminish beyond a certain point.

Beyond scaling the data per task using RE-ARC, we also examine the scalability of the offline training task diversity. See Fig. 15. When trained on 0, 16, 80, and 400 tasks, the accuracy increases from 26.4 to 43.1, 49.6, and 54.5, respectively, suggesting that the diversity of training tasks is helpful for generalization.

Figure 16: Pass@k results in the ARC-1 (left) and ARC-2 (right) evaluation sets. Results are obtained with majority voting from multi-view inference, using 510 views. (Top): using a single model of ViT-18M. (Bottom): using an ensemble of one ViT-18M and one U-Net-55M, each with test-time training run four times.

### B.2 Pass@k Results

By default, the ARC protocol evaluates the pass@2 accuracy. We further examine the pass@ $k$ accuracy, thanks to our multi-view inference with many views (510). This metric reflects whether at least one of the $k$ predicted solutions is correct. It can be viewed as a recall-like measure.

Figure 16 provides the pass@k results on ARC-1 and ARC-2 eval sets. As expected, as the number of proposals ($k$) increases, the pass@ $k$ accuracy increases. On ARC-1, the pass@k accuracy is 49.8, 54.5, and 66.3, when $k$ is 1, 2, and 300, respectively (Fig. 16, top-left). This result indicates that our model produces correct predictions in some of the many views, although such correct cases are not sufficiently populated to be retained after voting. On the other hand, this result reveals the upper-bound performance (66.3) of our method, even if oracle voting were applied. Beyond voting, future efforts should focus on improving the fundamental ability of the model on each individual view.

## Appendix C Additional Visualizations

### C.1 Successful and Failed Examples

We show successful and failed examples on ARC-1 (Fig. 17) and ARC-2 (Fig. 18). See captions for detailed descriptions. Our method can solve some highly challenging tasks, but still makes mistakes on some tasks that are simple for humans.

### C.2 Ambiguous Examples.

Although most ARC tasks are unambiguous, some may admit multiple plausible explanations or rules. We show an example in Fig. 19, in which our method uncovers different solutions that are plausible. Here, the rule can be interpreted as either “turn the red box blue only if the extended blue lines go through the box” (our method’s first guess) or “turn the red box blue if the extended blue lines touch the box in any form” (our method’s second guess).

### C.3 Attention Maps

#### Pixel-wise Attention Maps.

In Fig. 20, we visualize the attention maps of a single pixel specified as the query. See captions for detailed descriptions.

#### Layer-wise Attention Maps.

In Fig. 21, we visualize the layer-wise attention maps averaged across all pixels. See captions for detailed descriptions.

### C.4 Test-time Training Visualization

Figure 22 illustrates the evolution of model predictions during the test-time training process. Each row corresponds to a distinct test task from the ARC benchmark. It shows how our method progressively refines its prediction through test-time training.

![Refer to caption](https://arxiv.org/html/2511.14761v1/ARC-1-solved-ViT.png)

Figure 17: Successful and failed examples on ARC-1. (Top): Examples of test tasks successfully solved by VARC. (Bottom): Examples of test tasks unsolved by VARC. (Left): Two demonstration example pairs shown for each task (some have more demonstrations not shown here). (Right): Inference input and the first and second solutions proposed by VARC. The green box indicates the correct output.

![Refer to caption](https://arxiv.org/html/2511.14761v1/ARC-2-solved-ViT.png)

Figure 18: Successful and failed examples on ARC-2. (Top): Examples of test tasks successfully solved by VARC. (Bottom): Examples of test tasks unsolved by VARC. (Left): Two demonstration example pairs shown for each task (some have more demonstrations not shown here). (Right): Inference input and the first and second solutions proposed by VARC. The green box indicates the correct output.

![Refer to caption](https://arxiv.org/html/2511.14761v1/ambiguous2.png)

Figure 19: Ambiguous examples. Although most ARC tasks are unambiguous, some may admit multiple plausible explanations or rules. Here, in the given three demonstration examples of a test task (top panel), it is unclear whether a blue line “ touching ” (but not “ going through ”) a red rectangle should render that rectangle blue. The inference example (bottom panel) involves this situation (“touching”), and our model attempts to interpret the rule as either “going-through-only” (attempt 1) or “touching” (attempt 2).

![Refer to caption](https://arxiv.org/html/2511.14761v1/pixel_attn.png)

Figure 20: Additional visualization: pixel-level attention maps. The maps are shown for different Transformer blocks, with a query pixel highlighted by a red-yellow border. Here we show 4 test tasks in ARC eval. Layers at different depths tend to focus on different structures. Early layers tend to focus on local transformations and context. Middle layers tend to perform a more non-local connection, e.g., horizontally or vertically. The deep layers are more task-specialized. The red asterisk indicates the task that was not correctly solved. ( Here, the text descriptions are written by humans solely to help readers interpret the tasks. )

![Refer to caption](https://arxiv.org/html/2511.14761v1/Heatmap2.png)

Figure 21: Additional visualization: layer-wise attention maps. Each map is the per-pixel softmax attention maps averaged across all pixels in that layer. The corresponding demonstration examples (on the left) are provided for reference.

![Refer to caption](https://arxiv.org/html/2511.14761v1/test-time_training.png)

Figure 22: Visualization of the test-time training process. Here, we visualize the grid augmented with a given scale ratio of 2 × \\times (the full canvas is not shown for brevity). As the test-time training progresses, the model’s predictions gradually converge toward the correct output. In early epochs, the model produces coarse and imprecise structures; in later epochs, the model can improve the solutions, e.g., by refining color and spatial arrangement. This visualization illustrates the model’s behavior of adapting to task-specific transformations through few-shot test-time training.

[^1]: E. Akyürek, M. Damani, A. Zweiger, L. Qiu, H. Guo, J. Pari, Y. Kim, and J. Andreas (2025) The surprising effectiveness of test-time training for few-shot learning. In ICML, External Links: [Link](https://openreview.net/forum?id=asgBo3FNdg) Cited by: §1, §1, §3.1, §3.5.

[^2]: J. Alayrac, J. Donahue, P. Luc, A. Miech, I. Barr, Y. Hasson, K. Lenc, A. Mensch, K. Millican, M. Reynolds, R. Ring, E. Rutherford, S. Cabi, T. Han, Z. Gong, S. Samangooei, M. Monteiro, J. L. Menick, S. Borgeaud, A. Brock, A. Nematzadeh, S. Sharifzadeh, M. Binkowski, R. Barreira, O. Vinyals, A. Zisserman, and K. Simonyan (2022) Flamingo: a visual language model for few-shot learning. In NeurIPS, S. Koyejo, S. Mohamed, A. Agarwal, D. Belgrave, K. Cho, and A. Oh (Eds.), External Links: [Link](http://papers.nips.cc/paper%5C_files/paper/2022/hash/960a172bc7fbf0177ccccbb411a7d800-Abstract-Conference.html) Cited by: §2.

[^3]: J. Andreas, M. Rohrbach, T. Darrell, and D. Klein (2016) Learning to compose neural networks for question answering. In ACL, K. Knight, A. Nenkova, and O. Rambow (Eds.), External Links: [Document](https://dx.doi.org/10.18653/v1/N16-1181), [Link](https://aclanthology.org/N16-1181) Cited by: §2.

[^4]: J. Andreas, M. Rohrbach, T. Darrell, and D. Klein (2016) Neural module networks. In CVPR, External Links: [Document](https://dx.doi.org/10.1109/CVPR.2016.12), [Link](https://doi.org/10.1109/CVPR.2016.12) Cited by: §2.

[^5]: S. Antol, A. Agrawal, J. Lu, M. Mitchell, D. Batra, C. L. Zitnick, and D. Parikh (2015) VQA: visual question answering. In ICCV, External Links: [Document](https://dx.doi.org/10.1109/ICCV.2015.279), [Link](https://doi.org/10.1109/ICCV.2015.279) Cited by: §2.

[^6]: J. Berman (2024) How I came in first on ARC-AGI-Pub using Sonnet 3.5 with evolutionary test-time compute. Substack. Note: Accessed: 2025-10-13 External Links: [Link](https://jeremyberman.substack.com/p/how-i-got-a-record-536-on-arc-agi) Cited by: §1.

[^7]: J. Berman (2024) How I got a record 53.6% on ARC-AGI. Substack. Note: Accessed: 2025-10-13 External Links: [Link](https://jeremyberman.substack.com/p/how-i-got-a-record-536-on-arc-agi) Cited by: §1.

[^8]: J. Berman (2025) How I got the highest score on ARC-AGI again swapping Python for English. Substack. External Links: [Link](https://jeremyberman.substack.com/p/how-i-got-the-highest-score-on-arc-agi-again) Cited by: §1, Table 3.

[^9]: L. Bottou and V. Vapnik (1992) Local learning algorithms. Neural Computation. External Links: [Document](https://dx.doi.org/10.1162/neco.1992.4.6.888), https://direct.mit.edu/neco/article-pdf/4/6/888/812417/neco.1992.4.6.888.pdf, ISSN 0899-7667, [Link](https://doi.org/10.1162/neco.1992.4.6.888) Cited by: §1, §2, §3.1.

[^10]: T. B. Brown, B. Mann, N. Ryder, M. Subbiah, J. Kaplan, P. Dhariwal, A. Neelakantan, P. Shyam, G. Sastry, A. Askell, S. Agarwal, A. Herbert-Voss, G. Krueger, T. Henighan, R. Child, A. Ramesh, D. M. Ziegler, J. Wu, C. Winter, C. Hesse, M. Chen, E. Sigler, M. Litwin, S. Gray, B. Chess, J. Clark, C. Berner, S. McCandlish, A. Radford, I. Sutskever, and D. Amodei (2020) Language models are few-shot learners. In NeurIPS, H. Larochelle, M. Ranzato, R. Hadsell, M. Balcan, and H. Lin (Eds.), External Links: [Link](https://proceedings.neurips.cc/paper/2020/hash/1457c0d6bfcb4967418bfb8ac142f64a-Abstract.html) Cited by: §2.

[^11]: X. Chen, S. Xie, and K. He (2021) An empirical study of training self-supervised vision transformers. In ICCV, External Links: [Document](https://dx.doi.org/10.1109/ICCV48922.2021.00950), [Link](https://doi.org/10.1109/ICCV48922.2021.00950) Cited by: §3.3.

[^12]: F. Chollet, M. Knoop, G. Kamradt, B. Landers, and H. Pinkard (2025) ARC-AGI-2: a new challenge for frontier AI reasoning systems. arXiv:2505.11831. External Links: [Link](https://arxiv.org/abs/2505.11831) Cited by: §5.

[^13]: F. Chollet, M. Knoop, G. Kamradt, and B. Landers (2024) ARC Prize 2024: technical report. arXiv:2412.04604. External Links: [Link](https://arxiv.org/abs/2412.04604) Cited by: §1, §2.

[^14]: F. Chollet (2019) On the measure of intelligence. arXiv:1911.01547. Cited by: §1, §5.

[^15]: P. Dhariwal and A. Q. Nichol (2021) Diffusion models beat GANs on image synthesis. In NeurIPS, M. Ranzato, A. Beygelzimer, Y. N. Dauphin, P. Liang, and J. W. Vaughan (Eds.), External Links: [Link](https://proceedings.neurips.cc/paper/2021/hash/49ad23d1ec9fa4bd8d77d02681df5cfa-Abstract.html) Cited by: Table 7, Table 7.

[^16]: C. Dong, C. C. Loy, K. He, and X. Tang (2015) Image super-resolution using deep convolutional networks. IEEE Transactions on Pattern Analysis and Machine Intelligence. Cited by: §1.

[^17]: A. Dosovitskiy, L. Beyer, A. Kolesnikov, D. Weissenborn, X. Zhai, T. Unterthiner, M. Dehghani, M. Minderer, G. Heigold, S. Gelly, J. Uszkoreit, and N. Houlsby (2021) An image is worth 16x16 words: transformers for image recognition at scale. In ICLR, External Links: [Link](https://openreview.net/forum?id=YicbFdNTTy) Cited by: §1, §3.3.

[^18]: A. P. Foundation (2025) ARC-AGI benchmarking: leaderboard and dataset for the ARC-AGI benchmark. Note: Accessed: 2025-11-01 [https://arcprize.org/leaderboard](https://arcprize.org/leaderboard) Cited by: Table 3, Table 3, Table 3, Table 3, Table 3, Table 3, Table 3.

[^19]: D. Franzen, J. Disselhoff, and D. Hartmann (2025) Product of experts with LLMs: boosting performance on ARC is a matter of perspective. arXiv:2505.07859. External Links: [Link](https://arxiv.org/abs/2505.07859) Cited by: §1.

[^20]: Y. Goyal, T. Khot, D. Summers-Stay, D. Batra, and D. Parikh (2017) Making the V in VQA matter: elevating the role of image understanding in visual question answering. In CVPR, External Links: [Document](https://dx.doi.org/10.1109/CVPR.2017.670), [Link](https://doi.org/10.1109/CVPR.2017.670) Cited by: §2.

[^21]: D. Guo, D. Yang, H. Zhang, J. Song, R. Zhang, R. Xu, Q. Zhu, S. Ma, P. Wang, X. Bi, et al. (2025) Deepseek-R1: incentivizing reasoning capability in LLMs via reinforcement learning. arXiv:2501.12948. External Links: [Link](https://arxiv.org/abs/2501.12948) Cited by: Table 3.

[^22]: M. Hodel (2024) Addressing the abstraction and reasoning corpus via procedural example generation. arXiv:2404.07353. External Links: [Link](https://arxiv.org/abs/2404.07353) Cited by: §B.1, §4.

[^23]: R. Hu, J. Andreas, M. Rohrbach, T. Darrell, and K. Saenko (2017) Learning to reason: end-to-end module networks for visual question answering. In ICCV, External Links: [Document](https://dx.doi.org/10.1109/ICCV.2017.93), [Link](https://doi.org/10.1109/ICCV.2017.93) Cited by: §2.

[^24]: T. Joachims (1999) Transductive inference for text classification using support vector machines. In ICML, External Links: ISBN 1558606122 Cited by: §1, §2, §3.1.

[^25]: A. Johnson, W. K. Vong, B. M. Lake, and T. M. Gureckis (2021) Fast and flexible: human program induction in abstract reasoning tasks. arXiv:2103.05823. External Links: [Link](https://arxiv.org/abs/2103.05823) Cited by: §1.

[^26]: J. Johnson, B. Hariharan, L. van der Maaten, L. Fei-Fei, C. L. Zitnick, and R. B. Girshick (2017) CLEVR: A diagnostic dataset for compositional language and elementary visual reasoning. In CVPR, External Links: [Document](https://dx.doi.org/10.1109/CVPR.2017.215), [Link](https://doi.org/10.1109/CVPR.2017.215) Cited by: §2.

[^27]: A. Jolicoeur-Martineau (2025) Less is more: recursive reasoning with tiny networks. arXiv:2510.04871. External Links: [Link](https://arxiv.org/abs/2510.04871) Cited by: §1, §1, §1, §2, §5.3, Table 3.

[^28]: D. P. Kingma and J. Ba (2015) Adam: a method for stochastic optimization. In ICLR, Cited by: Table 4, Table 4.

[^29]: A. Krizhevsky, I. Sutskever, and G. E. Hinton (2012) ImageNet classification with deep convolutional neural networks. In NeurIPS, External Links: [Link](https://proceedings.neurips.cc/paper/2012/hash/c399862d3b9d6b76c8436e924a68c45b-Abstract.html) Cited by: §1, §3.5, §3.5, §5.3.

[^30]: Y. LeCun, B. Boser, J. S. Denker, D. Henderson, R. E. Howard, W. Hubbard, and L. D. Jackel (1989) Backpropagation applied to handwritten zip code recognition. Neural Computation. External Links: [Document](https://dx.doi.org/10.1162/neco.1989.1.4.541) Cited by: §1, §3.3.

[^31]: S. LeGris, W. K. Vong, B. M. Lake, and T. M. Gureckis (2024) H-ARC: a robust estimate of human performance on the abstraction and reasoning corpus benchmark. arXiv:2409.01374. External Links: [Link](https://arxiv.org/abs/2409.01374) Cited by: §1, §1, §5.3, Table 3.

[^32]: S. LeGris, W. K. Vong, B. M. Lake, and T. M. Gureckis (2025) A comprehensive behavioral dataset for the abstraction and reasoning corpus. Scientific Data. External Links: [Document](https://dx.doi.org/10.1038/s41597-025-05687-1), [Link](https://www.nature.com/articles/s41597-025-05687-1) Cited by: §1.

[^33]: J. Li, D. Li, C. Xiong, and S. C. H. Hoi (2022) BLIP: bootstrapping language-image pre-training for unified vision-language understanding and generation. In ICML, K. Chaudhuri, S. Jegelka, L. Song, C. Szepesvári, G. Niu, and S. Sabato (Eds.), Proceedings of Machine Learning Research, Vol. 162. External Links: [Link](https://proceedings.mlr.press/v162/li22n.html) Cited by: §2.

[^34]: W. Li, K. Hu, C. Larsen, Y. Wu, S. Alford, C. Woo, S. M. Dunn, H. Tang, W. Zheng, Y. Pu, and K. Ellis (2025) Combining induction and transduction for abstract reasoning. In ICLR, External Links: [Link](https://openreview.net/forum?id=UmdotAAVDe) Cited by: §1.

[^35]: W. Li, Y. Xu, S. Sanner, and E. B. Khalil (2024) Tackling the abstraction and reasoning corpus with vision transformers: the importance of 2D representation, positions, and objects. arXiv:2410.06405. External Links: [Link](https://arxiv.org/abs/2410.06405) Cited by: §2.

[^36]: I. Liao and A. Gu (2025) ARC-AGI without pretraining. Note: [https://iliao2345.github.io/blog\_posts/arc\_agi\_without\_pretraining/arc\_agi\_without\_pretraining.html](https://iliao2345.github.io/blog_posts/arc_agi_without_pretraining/arc_agi_without_pretraining.html) Cited by: §5.2.

[^37]: H. Liu, C. Li, Q. Wu, and Y. J. Lee (2023) Visual instruction tuning. NeurIPS. Cited by: §2.

[^38]: J. Long, E. Shelhamer, and T. Darrell (2015) Fully convolutional networks for semantic segmentation. In CVPR, External Links: [Document](https://dx.doi.org/10.1109/CVPR.2015.7298965), [Link](https://doi.org/10.1109/CVPR.2015.7298965) Cited by: §1, §3.2, §3.2, §3.5.

[^39]: L. v. d. Maaten and G. Hinton (2008) Visualizing data using t-SNE. Journal of machine learning research. Cited by: §6.

[^40]: M. V. Macfarlane and C. Bonnet (2024) Searching latent program spaces. arXiv:2411.08706. External Links: [Link](https://arxiv.org/abs/2411.08706) Cited by: §1.

[^41]: J. Mao, C. Gan, P. Kohli, J. B. Tenenbaum, and J. Wu (2019) The neuro-symbolic concept learner: interpreting scenes, words, and sentences from natural supervision. In ICLR, External Links: [Link](https://openreview.net/forum?id=rJgMlhRctm) Cited by: §2.

[^42]: A. Moskvichev, V. V. Odouard, and M. Mitchell (2023) The ConceptARC benchmark: evaluating understanding and generalization in the ARC domain. arXiv:2305.07141. External Links: [Link](https://arxiv.org/abs/2305.07141) Cited by: §1.

[^43]: D. Pathak, P. Krähenbühl, J. Donahue, T. Darrell, and A. A. Efros (2016) Context encoders: feature learning by inpainting. In CVPR, External Links: [Document](https://dx.doi.org/10.1109/CVPR.2016.278), [Link](https://doi.org/10.1109/CVPR.2016.278) Cited by: §1.

[^44]: R. Pfister and H. Jud (2025) Understanding and benchmarking artificial intelligence: OpenAI’s o3 is not AGI. arXiv:2501.07458. External Links: [Link](https://arxiv.org/abs/2501.07458) Cited by: §1.

[^45]: J. Puget (2024) A 2D nGPT model for ARC Prize. Note: GitHub repository Cited by: §1.

[^46]: O. Ronneberger, P. Fischer, and T. Brox (2015) U-net: convolutional networks for biomedical image segmentation. In International Conference on Medical image computing and computer-assisted intervention, Cited by: §1, §3.3.

[^47]: Y. Song and S. Ermon (2019) Generative modeling by estimating gradients of the data distribution. In NeurIPS, H. M. Wallach, H. Larochelle, A. Beygelzimer, F. d’Alché-Buc, E. B. Fox, and R. Garnett (Eds.), External Links: [Link](https://proceedings.neurips.cc/paper/2019/hash/3001ef257407d5a371a96dcd947c7d93-Abstract.html) Cited by: Table 7, Table 7.

[^48]: J. Su, M. Ahmed, Y. Lu, S. Pan, W. Bo, and Y. Liu (2024) Roformer: enhanced transformer with rotary position embedding. Neurocomputing. Cited by: §3.3.

[^49]: Y. Sun, X. Wang, Z. Liu, J. Miller, A. A. Efros, and M. Hardt (2020) Test-time training with self-supervision for generalization under distribution shifts. In ICML, External Links: [Link](https://proceedings.mlr.press/v119/sun20b.html) Cited by: §1, §2, §3.1.

[^50]: H. Tang, K. Hu, J. Zhou, S. Zhong, W. Zheng, X. Si, and K. Ellis (2024) Code repair with LLMs gives an exploration-exploitation tradeoff. In NeurIPS, A. Globersons, L. Mackey, D. Belgrave, A. Fan, U. Paquet, J. M. Tomczak, and C. Zhang (Eds.), External Links: [Link](http://papers.nips.cc/paper%5C_files/paper/2024/hash/d5c56ec4f69c9a473089b16000d3f8cd-Abstract-Conference.html) Cited by: §1.

[^51]: T. Thrush, R. Jiang, M. Bartolo, A. Singh, A. Williams, D. Kiela, and C. Ross (2022) Winoground: probing vision and language models for visio-linguistic compositionality. In CVPR, Cited by: §2.

[^52]: A. Vaswani, N. Shazeer, N. Parmar, J. Uszkoreit, L. Jones, A. N. Gomez, L. Kaiser, and I. Polosukhin (2017) Attention is all you need. In NeurIPS, I. Guyon, U. von Luxburg, S. Bengio, H. M. Wallach, R. Fergus, S. V. N. Vishwanathan, and R. Garnett (Eds.), External Links: [Link](https://proceedings.neurips.cc/paper/2017/hash/3f5ee243547dee91fbd053c1c4a845aa-Abstract.html) Cited by: §3.3.

[^53]: G. Wang, J. Li, Y. Sun, X. Chen, C. Liu, Y. Wu, M. Lu, S. Song, and Y. A. Yadkori (2025) Hierarchical reasoning model. arXiv:2506.21734. External Links: [Link](https://arxiv.org/abs/2506.21734) Cited by: §1, §1, §1, §2, §5.3, Table 3.

[^54]: R. Wang, E. Zelikman, G. Poesia, Y. Pu, N. Haber, and N. D. Goodman (2024) Hypothesis search: inductive reasoning with language models. In ICLR, External Links: [Link](https://openreview.net/forum?id=G7UtIGQmjm) Cited by: §1.

[^55]: J. Wei, X. Wang, D. Schuurmans, M. Bosma, B. Ichter, F. Xia, E. H. Chi, Q. V. Le, and D. Zhou (2022) Chain-of-thought prompting elicits reasoning in large language models. In NeurIPS, S. Koyejo, S. Mohamed, A. Agarwal, D. Belgrave, K. Cho, and A. Oh (Eds.), External Links: [Link](http://papers.nips.cc/paper%5C_files/paper/2022/hash/9d5609613524ecf4f15af0f7b31abca4-Abstract-Conference.html) Cited by: §2.

[^56]: P. Zhang, Y. Goyal, D. Summers-Stay, D. Batra, and D. Parikh (2016) Yin and yang: balancing and answering binary visual questions. In CVPR, External Links: [Document](https://dx.doi.org/10.1109/CVPR.2016.542), [Link](https://doi.org/10.1109/CVPR.2016.542) Cited by: §2.