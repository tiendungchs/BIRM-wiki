# garrido-intuitive-physics-vjepa-2025

> Converted from `garrido-intuitive-physics-vjepa-2025.pdf` on 2026-08-18 via `pymupdf4llm`.
> Layout artefacts (broken equations, interleaved columns) are conversion noise, not the source.

---

An intuitive understanding of physics is fundamental to human cognition: we expect objects to behave
predictably, i.e., not to appear or disappear abruptly, move through obstacles, or change shape or color
arbitrarily. This basic grasp of the physical world has been documented not only in human infants (Piaget,
1954; Baillargeon and DeVos, 1991; Baillargeon et al., 1992; Baillargeon and Hanko-Summers, 1990; Spelke
et al., 1995), but also in primates (Cacchione and Krist, 2004; Mendes et al., 2007), marine mammals
(Singer and Henderson, 2015; Herman, 2010), corvids (Bird and Emery, 2009; Taylor et al., 2012), and chicks
(Vallortigara, 2012; Wood, 2013). This has been taken as evidence for the _core_ _knowledge_ (or core systems)

hypothesis, according to which humans are equipped with a set of innate or early developing evolutionary,
ancient computational systems specialized to represent and reason about basic properties of the world: objects,
space, numbers, geometry, agents, etc. (Baillargeon, 2008; Spelke and Kinzler, 2007; Spelke, 2000; Carey, 2000).
In the pursuit of building machines with advanced human-level intelligence, rapid progress has produced
_artificial_ _intelligence_ (AI) systems that often surpass human performance on high-level cognitive tasks like

language, coding or mathematics (OpenAI, 2024), but paradoxically struggle in common sense physical
understanding (Riochet et al., 2022; Weihs et al., 2022; Jassim et al., 2024; Bisk et al., 2020; Benchekroun
et al., 2023; Bansal et al., 2024; Bear et al., 2021), illustrating Moravec’s paradox (Moravec, 1988), namely,
that tasks trivial for biological organisms can be remarkably difficult for artificial systems, and vice versa.

Previous work developing AI models with the aim of improving intuitive physics understanding can be sorted
into two classes: _structured_ _models_ and _pixel-based_ _generative_ _models_ . Structured models leverage hand-coded
abstract representations of objects and their relationships in an Euclidean 3D space (Battaglia et al., 2013;
Watters et al., 2017), yielding a powerful mental “game engine" able to capture human’s physical intuitions
(Ullman et al., 2017). This class of models can be seen as a possible computational implementation of the
_core_ _knowledge_ hypothesis (Spelke and Kinzler, 2007; Spelke, 2000). <sup>1</sup> Pixel-based generative models take a

radically opposite view and deny the need for any hard-coded abstraction. Instead, they propose a general
purpose learning mechanism consisting of reconstructing future sensory inputs (e.g., images) based on past
ones (Lerer et al., 2016; Goyal et al., 2017a; Finn et al., 2016).

1Weaker versions of structured models use object masks and depth cues instead of a full 3D reconstruction, e.g., (Riochet
et al., 2020).

1

|)|Col2|Col3|Col4|Col5|Col6|
|---|---|---|---|---|---|
|**)**||||||
|**)**||||||
|**)**||||||
|**)**||||||

**B)**

**C)**

|Predict the future Distance|Col2|Col3|Col4|Col5|expectation of the world’s behavior ?|
|---|---|---|---|---|---|
|<br>**Relative surprise over time**|<br>**Relative surprise over time**|<br>**Relative surprise over time**|<br>**Relative surprise over time**|<br>**Relative surprise over time**|<br>behavior ?|
|<br>**Relative surprise over time**||||||
|<br>**Relative surprise over time**||||||
|<br>**Relative surprise over time**||||||
|<br>**Relative surprise over time**||||||
|<br>**Relative surprise over time**||||||

*-6 *-4 *-2 - *+2 *+4

First predicted frame

**Figure 1** **Video prediction in representation space (V-JEPA) achieves an understanding of intuitive physics.** **(A)** Video models
are evaluated on three intuitive physics datasets using the Violation of Expectation paradigm (IntPhys, GRASP, and
InfLevel). V-JEPA is significantly more ‘surprised’ by implausible videos. Random initializations of V-JEPA (untrained
networks) show near-chance performance, and state-of-the-art video models based on text or pixel prediction are
much closer to chance. Confidence intervals at 95% are obtained via bootstrapping, except for untrained networks
( _n_ = 20) which use a normal distribution assumption. **(B)** V-JEPA is trained to ’inpaint’ natural videos in a learned

representation space. Starting from a video and a corrupted version, representations are first extracted. The goal is
then to predict the representation of the original video from the representation of the corrupted ones. **(C)** From a
trained V-JEPA, we compute a surprise metric by predicting representations of N future frames based on M past ones
and comparing the predictions to the representations of observed events. The surprise metric is then used to decide
which of the two videos contains a physical violation.

Here, we explore a third class of models that occupies a middle ground between these opposing views,
integrating features from both: _Joint_ _Embedding_ _Predictive_ _Architectures_ (JEPAs) (LeCun, 2022; Bardes
et al., 2024). As structured models, JEPAs posit that prediction of future world states should be done in
the model’s learned abstract, internal representation, and not in terms of low-level, pixel-based prediction or
generation.. However, unlike structured models, JEPAs leave it to the algorithm to learn its own representation
rather than hand-coding it. The mechanism consisting of predicting in representation space is congruent
with the _predictive_ _coding_ hypothesis of cognitive neuroscience (Hohwy, 2013; Rao and Ballard, 1999; Clark,
2013). Here we study a video version of this architecture, V-JEPA (Bardes et al., 2024), which learns to
represent video frames by reconstructing masked portions of the video in representation space. We rely on
the _violation-of-expectation_ framework to probe for intuitive physics understanding without requiring any
task-specific training or adaptation (Smith et al., 2019; Riochet et al., 2022; Piloto et al., 2022; Riochet et al.,
2020). By prompting the model to imagine the (representation of the) future of a video and comparing its
predictions with the actual observed future of the video, we obtain a quantitative measure of surprise that
can be used to detect violations of intuitive physics concepts.

We find that V-JEPA accurately and consistently distinguishes between videos that follow the laws of physics

and those that violate them. Specifically, when tasked with classifying the physical plausibility of video pairs,
where one video is plausible and the other is not, a V-JEPA model trained on natural videos achieves 98%
zero-shot accuracy on the IntPhys benchmark (Riochet et al., 2022) and 62% zero-shot accuracy on the InfLevel
benchmark (Weihs et al., 2022). <sup>2</sup> Surprisingly, we find that multimodal large-language models (Wang et al.,
2024; Reid et al., 2024) and comparable video prediction methods making predictions in pixel-space (Wang

2Here “zero-shot” refers both to the fact that the V-JEPA models were not trained specifically for the task of distinguishing

2

et al., 2023) perform around chance.

To better understand which design choices lead to the emergence of intuitive physics understanding in V-JEPA,
we ablate the effect of the training data, the pretraining prediction objective (what to predict from what), and
the model size. While we observe that varying each of these components influences performance, all V-JEPA
models achieve performance significantly above chance, including a small 115 million parameter model, or
a model trained on only one week of unique video, thereby suggesting that video prediction in a learned
representation space is a robust objective for acquiring intuitive physics understanding.

### **Measuring intutive physics understanding**

**Violation ofExpectation.** The violation-of-expectation paradigm has its roots in developmental psychology (Margoni et al., 2024; Baillargeon et al., 1985). Subjects, typically infants, are presented with two similar visual
scenes, one of which contains a physical impossibility. A ‘surprise’ reaction to each scene is then obtained
through various physiological measures, such as relative gaze time (Spelke, 1985), and is used to determine
whether a concept violation has occurred in the subject (Baillargeon and DeVos, 1991; Spelke, 1985; Margoni
et al., 2024). <sup>3</sup> This paradigm has been extended to evaluate the physical understanding of AI systems (Riochet
et al., 2022; Smith et al., 2019; Riochet et al., 2020), where, similarly to infant trials, pairs of scenes are
presented to a model with all aspects (properties of objects, number of objects, occluders, etc.) kept identical
across the two scenes, apart from a single aspect or event that violates a specific intuitive physics concept. For
example, a ball may roll behind an occluder but never reappear in one of the paired videos, thereby testing
for the concept of object permanence. A higher surprise response attributed by the model to the impossible
scenario reflects a correct understanding of the violated concept.

**Video Prediction for intuitive physics understanding.** The V-JEPA architecture (LeCun, 2022) has been primarily
developed to improve the capacity of a model to adapt to high-level downstream tasks, such as activity
recognition (Kay et al., 2017) and action classification (Goyal et al., 2017b), directly from the input without
hard-wiring a cascade of intermediate representations like object contours or pose estimation (Bardes et al.,
2024). Here, we test the hypothesis that the reason this architecture is successful at high-level tasks is that
it has learned a representation that implicitly captures the structure and dynamics of objects in the world
without the need to represent them directly.

As illustrated in Figure 1.B, V-JEPA is instantiated with an encoder (a neural network) that extracts
representations from a video, and a predictor (also a neural network) that predicts the representation of
an artificially masked part of the video, such as a randomly masked spatiotemporal block, random pixels,
or future frames. This joint training of the encoder and predictor enables the encoder to learn abstract
representations that encode predictable information and discard low-level (typically less semantic) features.
Refer to Section A.1 in the supplementary material for more details on architecture and training.

After self-supervised training, we can use the encoder and predictor networks, without any additional
adaptation, to probe the model’s understanding of the world. Specifically, iterating through a stream of video,
the model encodes the observed pixels and subsequently predicts the representation of the following frames
in the video, as illustrated in Figure 1.C. By recording the _prediction_ _error_ - the distance between the
predicted video representations and the actual encoded video representations - at each time-step, we obtain
a temporally aligned quantitative measure of the model’s surprise throughout the video. Varying how many
past video frames (context) a model can use to predict the future allows us to control for memory, while
varying the frame rate of the video allows us to control for the fineness of motions. Refer to Section A.7 in
the supplementary material for more details.

between physically plausible and implausible videos, and that the model was not trained on data from any of the benchmarks.

3Non-conceptual interpretations of gaze-times, e.g., based on low-level processes such as perceptual preferences, are typically
mitigated to some degree in these experiments by conducting a series of habituation trials prior to the violation-of-expectation
trials.

3

### **Representation prediction learns to detect violations of intuitive physics**

We evaluate intuitive physics understanding on three datasets: the dev set of IntPhys (Riochet et al., 2022),

GRASP (Jassim et al., 2024) and InfLevel-lab (Weihs et al., 2022). This mix of benchmarks provides diversity
in the visual quality (synthetic/photorealistic), in the diversity of scenes considered, as well as in the intuitive
physics properties that are probed. Specifically, the combination of these datasets allows us to probe the
understanding of object permanence (Baillargeon and DeVos, 1991), continuity (Spelke et al., 1992), shape and
color constancy (Wilcox, 1999; Wilcox and Chapa, 2004), gravity (Kim and Spelke, 1992), support (Baillargeon
and Hanko-Summers, 1990; Baillargeon et al., 1992), solidity (Spelke et al., 1992), inertia (Spelke et al., 1992),
and collision (Baillargeon, 1995). See Section A.5 in the supplementary material for exact definitions.

We compare V-JEPA to other video models to investigate how important to intuitive physics understanding is

the video prediction objective, as well as the representation space where prediction is performed. We consider
two other classes of models: video prediction models that predict directly in pixel space, and Multimodal Large
Language Models (MLLMs). The former set of pre-training methods have a similar prediction objective as
V-JEPA, but often learn representation spaces with poor semanticity (Wang et al., 2023; Bardes et al., 2024);
they are useful once fine-tuned for a specific task. As a representative method, we evaluate VideoMAEv2 (Wang
et al., 2023). While different prediction objectives and pretraining data are used, this allows a comparison to
V-JEPA in terms of prediction space. Given its predictive nature, VideoMAEv2 can be evaluated in the same
way as V-JEPA, by predicting the future and measuring surprise via prediction error.

The latter class of models, MLLMs, are trained to predict text and are only interleaved with video a posteriori,
making them devoid of a video prediction objective. As exemplar methods, we study Qwen2-VL-7B (Wang
et al., 2024), a state-of-the-art, open-weights, video-language model, and Gemini 1.5 pro (Reid et al., 2024), a
closed commercial model. These models are both significantly larger than V-JEPA in terms of parameter
count and the amount of data they were trained on, and they learn primarily from text data. Multimodal
LLMs take videos and potentially a text prompt as input and learn to generate a corresponding textual
output. Due to their text-only output, those models cannot use the same evaluation protocol based on a
quantitative measure of surprise. Instead, we give the model a pair of videos, asking which one of the two is
impossible. Section A.7 in the supplementary material describes the detailed protocol.

For every method considered, we evaluate the flagship models proposed in the original works. We further
compare all models with untrained neural networks, testing the learnability of intuitive physics understanding.
For each property and model, the context size is chosen as the one maximizing performance, allowing the
models to adapt to the different evaluation setups. This process is done for all methods, and leads to results
illustrating the best performance achievable by the model. We expand on this choice in section B in the
supplementary material.

We summarize the performance of methods across datasets on pairwise classification (i.e., detecting the

impossible video in a pair) in Figure 1.A. Refer to Section F in the supplementary material for detailed results,
and Section A.8 for detailed parameters used.

We find that V-JEPA is the only method that achieves significantly higher performance than untrained

networks across all datasets, achieving average accuracies of 98% (95% CI [95%,99%]), 66% (95% CI [64%,68%])
, 62% (95% CI [60%,63%]) respectively on IntPhys, GRASP, and InfLevel-lab. These results show that
prediction in a learned representation space is sufficient to develop an understanding of intuitive physics. This
is done without any predefined abstractions, and without knowledge of the benchmarks during pretraining or
development of the method.

By comparison, we find that VideoMAEv2, Qwen2-VL-7B, and Gemini 1.5 pro achieve performance that is only
marginally above that of randomly-initialized models. The low performance of pixel prediction and multimodal
LLMs corroborates previous findings (Riochet et al., 2022; Jassim et al., 2024). These comparisons further
highlight the benefit of V-JEPA over the existing VideoMAEv2, Gemini 1.5 pro, and Qwen2-VL-72B models.
These results, however, do not mean that LLMs or pixel prediction models cannot achieve intuitive physics
understanding, but merely that this seemingly simple task remains difficult even for frontier models (Jassim
et al., 2024; Kang et al., 2024; Bansal et al., 2024).

4

**Figure 2** **V-JEPA accuracy increase relative to randomly-initialized models and humans across different physical properties**
**and benchmarks.** **(A)** Because some benchmarks contain low-level biases, we test the model performance against a set
of randomly initialized networks ( _n_ = 20). V-JEPA models ( _n_ = 5) have higher relative classification accuracy on
intuitive physics benchmarks for most, but not all concepts. **(B)** V-JEPA relative (left) and absolute (right) accuracy
on the IntPhys test set across different conditions compared to naive human performance, showing a high correlation
between human and machine errors. The V-JEPA score uses the maximum surprise from each video, which generalizes
better for single-video classification. Human data are taken from (Riochet et al., 2022).

### **Per property analysis of V-JEPA**

We now take a closer look at the per-property performance of V-JEPA on the previously used datasets

in order to obtain a more precise understanding of its intuitive physics understanding. Here, the V-JEPA
encoder and predictor are based on the Vision Transformer-Large (ViT-L, instead of ViT-H for the flagship
model) (Dosovitskiy et al., 2021; Bardes et al., 2024) architecture and are trained on the HowTo100M
dataset (Miech et al., 2019). We perform a two-sample one-tailed Welch’s t-test to assess whether V-JEPA
(n=5) provides increased performance over randomly-initialized, untrained models (n=20). The results are

summarized in Figure 2.

On IntPhys, we find V-JEPA to significantly outperform untrained networks on multiple intuitive physics
properties: Object Permanence: M=85.7, SD=7.6 vs. M=51.4, SD=1.0 (t(4.0) = -8.9, _p_ = 4 _._ 19 _×_ 10 <sup>_−_</sup> <sup>4</sup> ),
with an effect size _g_ = 9.0 (95% CI [6.3,11.7]); Continuity: M=86.3, SD=6.2 vs. M=51.2, SD=1.2 (t(4.1)
= -11.3, _p_ = 1 _._ 61 _×_ 10 <sup>_−_</sup> <sup>4</sup> ), with an effect size _g_ = 11.0 (95% CI [7.8,14.2]); Shape Constancy: M=83.7,
SD=7.8 vs. M=51.7, SD=1.2 (t(4.0) = -8.1, _p_ = 5 _._ 96 _×_ 10 <sup>_−_</sup> <sup>4</sup> ), with an effect size _g_ = 8.1 (95% CI [5.7,10.6]).
On GRASP, we find significantly higher accuracies for V-JEPA on: Object Permanence: M=70.7, SD=7.8
vs. M=54.1, SD=5.9 (t(5.0) = -4.0, _p_ = 5 _._ 10 _×_ 10 <sup>_−_</sup> <sup>3</sup> ), with an effect size _g_ = 2.4 (95% CI [1.2,3.6]); Continuity:
M=65.0, SD=6.1 vs. M=55.0, SD=5.0 (t(5.2) = -3.0, _p_ = 1 _._ 36 _×_ 10 <sup>_−_</sup> <sup>2</sup> ), with an effect size _g_ = 1.8 (95%
CI [0.7,2.9]); Support: M=98.1, SD=3.0 vs. M=58.4, SD=10.5 (t(21.4) = -14.0, _p_ = 1 _._ 48 _×_ 10 <sup>_−_</sup> <sup>12</sup> ), with an
effect size _g_ = 3.9 (95% CI [2.4,5.3]); Gravity: M=74.9, SD=2.4 vs. M=55.3, SD=4.3 (t(10.3) = -12.6, _p_ =
6 _._ 83 _×_ 10 <sup>_−_</sup> <sup>8</sup> ), with an effect size _g_ = 4.5 (95% CI [2.9,6.1]); Inertia: M=62.0, SD=2.4 vs. M=54.3, SD=4.2
(t(10.1) = -5.1, _p_ = 2 _._ 36 _×_ 10 <sup>_−_</sup> <sup>4</sup> ), with an effect size _g_ = 1.8 (95% CI [0.7,2.9]). However, we do not find

a significant gain on: Color Constancy, Solidity, or Collision ( _p >_ 0 _._ 05). On InfLevel, we find significantly
higher accuracies for V-JEPA on: Object Permanence: M=72.1, SD=2.9 vs. M=52.5, SD=3.5 (t(6.8) = -11.9,
_p_ = 4 _._ 46 _×_ 10 <sup>_−_</sup> <sup>6</sup> ), with an effect size _g_ = 5.4 (95% CI [3.6,7.1]). However, we do not find a significant gain on:

5

|)<br>)|B lo c k B lo c k + C a u s a l R a n d o<br>t t<br>C)|Col3|Col4|Col5|
|---|---|---|---|---|
|**)**|t<br>t<br>**Block**<br>**Block + Causal**<br>**Rando**<br>**C)**||||
|**)**|t<br>t<br>**Block**<br>**Block + Causal**<br>**Rando**<br>**C)**||||
|**)**|t<br>t<br>**Block**<br>**Block + Causal**<br>**Rando**<br>**C)**||||

**Figure 3** **Influence of type of mask, type and amount of training data, and model size on V-JEPA IntPhys scores.** **(A)** When
pretrained on VM2M, V-JEPA exhibits an understanding of intuitive physics with every masking strategy. **(B)** Of the
three training datasets, two give high accuracies when trained separately (K710 and Howto100M). High scores are
found with only 1289 hours of Howto100M (the largest dataset), and even 128h gives better than chance performance.
**(C)** While larger encoders improve performance, we find that the performance remains non-trivial across sizes when
pretraining on HowTo100M. Confidence intervals obtained via bootstrapping.

Gravity or Solidity ( _p >_ 0 _._ 05).

V-JEPA excels at properties related to the scene’s content (e.g., object permanence), but struggles with
categories that require knowledge of a contextualizing event (gravity and solidity in InfLevel-lab) or the
modeling of precise object interactions such as collisions. We hypothesize that these limitations come mainly
from the model’s framerate constraints. Nevertheless, V-JEPA demonstrates an understanding of intuitive
physics while learning the required abstractions from the raw perceptual signal and without relying on strong
prior information. In contrast to previous work (Smith et al., 2019; Riochet et al., 2022), this suggests that
core knowledge is not necessary for deep learning systems to understand intuitive physics concepts.

We further compare V-JEPA to human performance using the private test set from IntPhys (Riochet

et al., 2022). The human data is taken from (Riochet et al., 2022, 2020), where it was obtained through
Amazon Mechanical Turk. For this experiment, we focus on the flagship V-JEPA architecture, using a
ViT-Huge (Dosovitskiy et al., 2021; Bardes et al., 2024) with pretraining on VideoMix2M (Bardes et al., 2024).
We find that V-JEPA achieves equal or higher performance for all intuitive physics properties, as illustrated

in Figure 2.B. We find that using the maximum surprise in a video, rather than the average, leads to better
performance on single videos. We discuss further this distinction in Section A.7 in the supplementary material.
In general, we observe lower performance in both V-JEPA and humans for videos where the physics-breaking
event happens behind an occluder. Additionally, performance is well-correlated between humans and V-JEPA
for the occluded settings.

### **Keys to intuitive physics understanding**

We now ablate V-JEPA design choices to better understand the conditions for intuitive physics understanding

to emerge. We focus on three components that play a crucial role in the model’s capabilities. First, we examine
the impact of the training data. The choice of data defines the learning environment of the model, with
different video sources providing variations in semantic diversity, movement patterns, and quantity. Second,
we consider the effect of the model size. While conventional wisdom states that larger models perform better,
we also ponder the minimum size required to achieve non-trivial performance. Third, we study the influence

6

of the pretraining prediction task. Does selecting what to predict from what observed context (pretraining
masking strategy) affect the model’s understanding of intuitive physics?

**Importance** **of** **the** **pretraining** **task.** Recall that V-JEPA models are trained to predict representations of
randomly masked portions of a video, but always perform causal prediction at inference time, where the
context includes frames up to some time _t_ and the model should predict representations of frames at times
greater than _t_ . Although we compute V-JEPA’s surprise using causal prediction and have observed above that
this is effective for intuitive physics understanding, V-JEPA is never trained using a causal prediction task.
Rather, the pre-training task is referred to as _Block_ _Masking_ (Bardes et al., 2024), where a large spatial block
is masked for the full duration of the video. V-JEPA’s performance on action and activity recognition tasks
has previously been observed to vary drastically depending on the exact strategy used (Bardes et al., 2024).

To understand the extent to which V-JEPA intuitive physics understanding emerges specifically from the
_Block_ _Masking_ training task, we study the effect of changing this training task, and consider two possible

alternatives. _Causal_ _Block_ _Masking_ is similar to _Block_ _Masking_, but also fully masks the last 25% of the
video, thereby incorporating future prediction into the training procedure, and _Random_ _Masking_ which masks
random pixels in the video. Contrary to classical video tasks (Bardes et al., 2024), we find that the prediction
task is not as important for intuitive physics understanding (see figure 3.B). Whereas _Random_ _Masking_ leads
to a drop of 20 points on average on video classification tasks (Bardes et al., 2024), the drop on IntPhys
is only around 5 points on average. Interestingly, _Causal_ _Block_ _Masking_ seems to perform worse than its
non-causal counterpart, despite being more closely aligned to the model’s prediction setup at test time. The
effective performance of _Random_ _Masking_, perhaps the simplest strategy, suggests that the understanding of
intuitive physics does not require a tailored objective, but that predicting in an abstract representation space
is the key aspect.

**Importance of pre-training data.** Data is a key ingredient of deep learning models and video models are no
exception (Bardes et al., 2024). Video datasets can be described along several axes, such as the number of
distinct videos, the (average) duration of videos, whether videos are captured from egocentric or exocentric
views, whether that camera is static or moving, and so on. We thus investigate in more detail the influence of
pretraining data on intuitive physics performance. V-JEPA has previously been trained on a mixture of three
popular video datasets, referred to as VideoMix2M (Bardes et al., 2024): Kinetics 710 (K710 (Kay et al.,
2017)), Something-Something-v2 (SSv2 (Goyal et al., 2017b)) and HowTo100M (HowTo (Miech et al., 2019)).
Each of these datasets focuses on a different slice of the distribution of natural videos, namely, activities
in K710 (e.g., playing basketball), fine-grained motion in SSv2 (e.g., throwing something), and tutorials in
HowTo100M (e.g., cooking). To study the influence of training data on learning intuitive physics, we re-train
V-JEPA-L models separately using only one of the three component datasets.

Unsurprisingly, we find a strong impact of data sources on performance. Training only with videos based
on motion understanding (SSv2) leads to almost chance-level performance. While more action-focused data
(K710) leads to an above-chance understanding of intuitive physics, we find that tutorial videos (HowTo) yield

the best performance among individual component datasets. However, HowTo is also larger than SSv2 and
K710 (15 years vs. 3 months combined). We thus further examine the evolution of performance with smaller
datasets coming from the same distribution by subsampling HowTo100M. We hold the compute budget fixed
across these experiments such that model training always processes the equivalent of 30 years of video (by
revisiting videos from the training dataset multiple times) even when only using 0.1% of HowTo100M, which
represents only 128 hours of unique video in total. We find in Figure 3.C that the size of the dataset does not
meaningfully impact performance, and that the model can adequately distinguish violations of intuitive physics
concepts even with 128h of unique videos, maintaining a pairwise accuracy of over 70% on all considered
properties.

**Importance of the encoder size.** Common wisdom in the deep learning literature is that larger models perform
better (Kaplan et al., 2020). Here, we are also interested in the minimal size at which we observe evidence
of non-trivial intuitive physics understanding. We thus investigate what happens in both directions of the
scaling, using smaller and larger encoders. In Figure 3.C, we find that larger models tend to perform better.
However, a 115 million parameters model still achieves an accuracy of over 85%, demonstrating a robust
understanding of intuitive physics.

7

### **Discussion**

In this work, we studied the emergence of intuitive physics understanding in state-of-the-art deep learning
models. By pretraining on natural videos with a simple prediction task in a learned representation space,
V-JEPA exhibits an understanding of intuitive physics on both synthetic and real videos without any taskspecific adaptation. Our results show that intuitive physics understanding can be acquired using a general
learning principle, and thus does not require hardwired _core_ _knowledge_ . Although we find that the size of
the model, the choice of pretraining data, and the exact pretraining task influence this understanding, its
emergence can be attributed to the general framework of representation space prediction rather than a precise
design choice of V-JEPA. When studying other methods such as multimodal LLMs and pixel prediction
methods, we find that current models perform around chance level. Higher-capacity generative video models
could potentially benefit from a certain understanding of intuitive physics (Brooks et al., 2024) in order to
produce realistic videos. Yet, current evidence points to an incomplete understanding of physics in existing
video generative models (Motamed et al., 2025; Bansal et al., 2024) <sup>4</sup> .
Nonetheless, the demonstrated understanding of V-JEPA is not without limitations. Indeed, V-JEPA is not
uniformly accurate under all conditions. Figure 2 shows that although the accuracies are high for physical
violations that imply properties intrinsic to objects (except for the color property), violations implicating
interactions between objects, like solidity or collision, are close to chance. This may be due to the fact that
object interactions are not very frequent in the model training data, and are not learned as well as more
frequent ones. Furthermore, current JEPA models have limited memory, and consequently process very short
video clips at a time (typically 3–4 seconds). V-JEPA also lacks the ability to condition its predictions on
additional context, such as an action taking place, and thus predicts the future only as an observer. Although
this lends itself well to the tested properties, more complex interactions are out of reach at the moment.
Indeed, it could be that interactions between objects require higher-order representations, and that a more
powerful hierarchical version of JEPA is needed to capture these interactions. Finally, it is also possible that
an agent has to be able to interact with objects themselves in order to learn about interactions, suggesting
the need to add action channels to the learning system.
From a data standpoint, it would also be interesting to study models trained on videos that mimic what
infants see (Sullivan et al., 2021; Long et al., 2024), and whether an understanding of intuitive physics also
emerges in models trained on such data.
Nonetheless, through the results reported here, we believe that the latent prediction framework is a path
forward toward building neural networks that understand the physical world.

4Most state-of-the-art models (Brooks et al., 2024) being proprietary complicates a rigorous assessment of their physics
understanding due to their lack of openness.