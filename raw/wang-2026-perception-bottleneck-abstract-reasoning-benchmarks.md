---
title: "Your Reasoning Benchmark May Not Test Reasoning: Revealing Perception Bottleneck in Abstract Reasoning Benchmarks"
source: "https://arxiv.org/html/2512.21329"
author:
published:
created: 2026-09-19
description:
tags:
  - "clippings"
---
###### Abstract

Reasoning benchmarks such as the Abstraction and Reasoning Corpus (ARC) and ARC-AGI are widely used to assess progress in artificial intelligence and are often interpreted as probes of core, so-called “fluid” reasoning abilities. Despite their apparent simplicity for humans, these tasks remain challenging for frontier vision-language models (VLMs), a gap commonly attributed to deficiencies in machine reasoning. We challenge this interpretation and hypothesize that the gap arises primarily from limitations in visual perception rather than from shortcomings in inductive reasoning.

To verify this hypothesis, we introduce a two-stage experimental pipeline that explicitly separates perception and reasoning. In the perception stage, each image is independently converted into a natural-language description, while in the reasoning stage a model induces and applies rules using these descriptions. This design prevents leakage of cross-image inductive signals and isolates reasoning from perception bottlenecks. Across three ARC-style datasets, Mini-ARC, ACRE, and Bongard-LOGO, we show that the perception capability is the dominant factor underlying the observed performance gap by comparing the two-stage pipeline with against standard end-to-end one-stage evaluation. Manual inspection of reasoning traces in the VLM outputs further reveals that approximately 80 percent of model failures stem from perception errors. Together, these results demonstrate that ARC-style benchmarks conflate perceptual and reasoning challenges and that observed performance gaps may overstate deficiencies in machine reasoning. Our findings underscore the need for evaluation protocols that disentangle perception from reasoning when assessing progress in machine intelligence.

## 1 Introduction

Reasoning capability has increasingly become a central criterion for evaluating the progress of frontier artificial intelligence (AI) models [^10] [^24]. Correspondingly, a wide range of reasoning benchmarks have emerged to assess different dimensions of reasoning performance [^2] [^30] [^4] [^25]. Among these, the Abstraction and Reasoning Corpus (ARC) [^7] and its successor, ARC-AGI [^2] [^5], have attracted particular attention, as they are widely viewed as tests of core reasoning abilities and, in some views, as indicators of progress toward general intelligence [^6]. Reflecting their influence, frontier AI labs, including OpenAI and Google, routinely highlight their models’ performance on ARC as a key indicator of advances in general reasoning capabilities [^10] [^2] [^24].

(a) An example ARC problem shown in 2-D visually.

⬇

Task Demonstration Examples:

Input: \[\[0, 0, 0, 0, 0\], \[3, 3, 0, 0, 0\], \[0, 0, 3, 0, 0\], \[0, 0, 0, 1, 1\], \[0, 0, 0, 4, 1\]\]

Output: \[\[3, 0, 0, 0, 0\], \[0, 3, 3, 0, 0\], \[0, 0, 0, 0, 0\], \[0, 0, 0, 0, 0\], \[0, 0, 0, 0, 0\]\]

(Omitting two demonstration examples.)

Test Example:

Input: \[\[0, 0, 3, 0, 0\], \[3, 3, 3, 0, 0\], \[0, 0, 0, 0, 0\], \[0, 0, 0, 4, 1\], \[0, 0, 0, 1, 1\]\]

(b) The same ARC problem shown in a serialized format.

Figure 1: An example ARC problem. One is asked to induce a common rule from the input-output pairs in the task demonstration examples, and then apply this rule to the test input to generate the test output. The difficulty of this task to human players critically depends on how the problem is presented.

The core design principle of ARC and ARC-AGI is to evaluate “ *fluid* intelligence (the ability to reason, solve novel problems, and adapt to new situations) rather than *crystallized* intelligence, which relies on accumulated knowledge and skills,” [^2] where the former is considered a core reasoning capability at which current AI models still fall short. Concretely, ARC and ARC-AGI take the form of grid-based puzzles, as shown in Figure 1. Each problem consists of several input-output demonstration pairs and a test input. The solver–human or AI–must induce a common rule from the demonstrations and then apply it to the test input. In the specific example in Figure 1, the correct solution requires recognizing the pattern that the $2\times 2$ block on the bottom-right corner encodes the rotation rule for the 3x3 green object in the upper-left, and the position of the yellow pixel indicates degrees of rotation. The solver must then apply this inferred rule to the test input to generate the correct test output.

Empirically, these problems are found to be easy for humans yet surprisingly hard for even state-of-the-art frontier AI models <sup>1</sup> [^2]. A common belief is that this persistent gap between AI and human reflects a fundamental advantage of humans’ reasoning capabilities [^6]. In this work, we critically examine this belief, and *hypothesize* that the gap arises primarily because ARC problems particularly favor humans’ innate visual perception, rather than reflecting a genuine difference in the reasoning capability (or “fluid intelligence”). This hypothesis is motivated by the observation that the difficulty of the ARC problem to human players depends strongly on how the problem is presented. As shown in Figure 1, presenting the same problem in a serialized format (Figure 1) makes it far more difficult for humans to solve than when shown in its original 2-D visual format (Figure 1).

Our hypothesis involves the explicit separation of perception and reasoning capabilities required to solve ARC-style tasks. Conceptually, perception refers to the ability to *recognize meaningful objects from raw visual inputs*, whereas reasoning refers to the ability to *induce patterns among the recognized objects in demonstrations*. A key challenge in verifying our hypothesis lies in the fact that the success of perception is a prerequisite for the success of reasoning in solving an ARC-style problem, which makes it difficult to have a clean measure and comparison of the perception and reasoning capabilities of a given model.

To address this challenge and verify our hypothesis, we design a two-stage experimental pipeline. The first stage (*perception stage*) transforms the raw image inputs into natural language descriptions. Crucially, this transformation is *applied to each images in isolation*, ensuring that no cross-image inductive signals are leaked during this stage. This atomistic approach guarantees that inductive reasoning occurs exclusively in the second stage (*reasoning stage*), where an AI model is tasked with solving the problem using the natural language descriptions obtained from the perception stage. The natural-language-based representation is supposed to alleviate the perception challenge for the model while preserving the inductive structure of the problem. This pipeline allows us to isolate the model’s inductive reasoning performance from its perceptual bottlenecks, providing a clearer picture of where the “reasoning gap” truly resides.

We conduct experiments on three ARC-style visual reasoning datasets, Mini-ARC [^14], ACRE [^31], and Bongard-LOGO [^23]. We compare the performance of vision-language models (VLMs) under both the standard end-to-end one-stage setting and the proposed two-stage pipeline. Our empirical results provide three key findings that support our hypothesis. First, we demonstrate that the two-stage pipeline, in which a dedicated perception stage transforms the raw image inputs into natural language descriptions, significantly outperforms the end-to-end one-stage application of the same VLM. Second, we find that a hybrid two-stage pipeline combining a strong VLM for the perception stage with a weaker VLM for the reasoning stage yields performance close to that of an end-to-end strong VLM, while substantially outperforming an end-to-end weak VLM. This result suggests that perceptual capability, rather than reasoning strength, is the primary bottleneck in these tasks. Finally, through manual inspection of model reasoning traces, we observe that approximately 80% of failure cases stem from perception errors, i.e., failing to properly identify visual objects. Furthermore, the majority of the performance gains achieved by the two-stage pipeline can be attributed to a reduction in such perception errors.

In summary, our study reveals an important perception bottleneck in an influential class of reasoning benchmarks, abstract reasoning benchmarks, through carefully controlled experiments. Our results suggest that performance gaps on ARC-style tasks may conflate limitations in visual perception with deficiencies in inductive reasoning. This finding calls for caution in interpreting these benchmarks as direct measures of reasoning or fluid intelligence in frontier AI models, and highlights the importance of disentangling perceptual and reasoning components when evaluating progress in machine reasoning.

## 2 Related Work

#### Reasoning Benchmarks.

Reasoning benchmarks can be categorized by (i) the input modality and (ii) how much they rely on external knowledge versus in-context rule induction. Text-only benchmarks probe reasoning entirely in language, spanning broad knowledge and multi-disciplinary question answering (e.g., MMLU [^11]), multi-step mathematical problem solving (e.g., GSM8K [^8]), functional code generation (e.g., HumanEval [^4]), and harder challenge suites designed to reduce superficial heuristics (e.g., GPQA [^25], Big-Bench Hard [^27]). Vision-language benchmarks explicitly couple perception (e.g., reading, grounding, extracting structure from images) with knowledge-based reasoning, including scientific and mathematical reasoning over diagrams (e.g., ScienceQA [^20], MathVista [^19]), text-rich visual understanding (e.g., DocVQA [^21], TextVQA [^26]), and comprehensive multi-domain suites (e.g., MMMU [^29], MMBench [^18]). Finally, knowledge-light visual abstraction benchmarks aim to minimize human priors by emphasizing pattern recognition, abstraction, and generalization from minimal visual examples (e.g., ARC [^2], ACRE [^31] and Bongard-LOGO [^23]). These knowledge-light abstraction benchmarks are the primary focus of our work: although they are widely viewed as reasoning-centric tests that require minimal perceptual effort, we demonstrate that their performance can be strongly limited by perceptual bottlenecks, and that substantial gains can arise from improving perception rather than advancing reasoning.

#### State-of-the-Art Performance on the ARC Benchmarks.

Recent progress on ARC/ARC-AGI can be broadly grouped into (i) general-purpose foundation models, including LLMs that serialize grids into text VLMs that operate directly on the visual grid representation; and (ii) tailored ARC solvers that introduce task-specific search, program synthesis, or specialized architectures. For general-purpose foundation models, GPT-5.2 Pro (High) and Gemini 3 Pro (Deep Think) have established a new ceiling, achieving scores of 54.2% and 45.1% respectively in ARC-AGI-2 primarily due to their extended thinking ability [^3]. This shift towards scaling test-time computation has crystallized into a new paradigm named “refinement loops,” where systems iteratively optimize solutions against feedback rather than relying on single-shot inference.

Among tailored approaches, test-time training (TTT) has emerged as a strong general mechanism for few-shot adaptation on ARC, substantially improving over fine-tuned baselines and often combining well with other solver components [^15] [^1]. Alternative neural approaches include the Hierarchical Reasoning Model (HRM) and its recursive variants, which utilize small recurrent architectures [^28] [^13], and masked diffusion models, which refine the grid globally to capture structural constraints [^9]. Additionally, CompressARC explores test-time learning by minimizing description length on the target puzzle [^16]. Finally, a very recent concurrent work argues that “ARC is a vision problem” [^12], reframing ARC as image-to-image translation with a ViT-style backbone and test-time adaptation, which gives an example of a vision-centric route to ARC performance. While this recent trend suggests that enhancing perception boosts performance, our primary goal is to challenge the interpretation of ARC performance as a proxy for general intelligence. Therefore, in this paper, we focus specifically on general-purpose VLMs, aiming to understand how much of their ARC performance is limited by perception rather than reasoning.

#### Limitations of the ARC Benchmarks.

The research community has suggested several limitations that complicate treating ARC scores as a clean measure of general reasoning. First, strong performance can result from increased compute, either through larger training budgets or extensive test-time training or searching [^22]. Therefore, gains in accuracy may reflect better fitting to the ARC task distribution rather than improved reasoning. Second, the small hidden evaluation set increases the risk of implicit overfitting to benchmark-specific patterns [^6]. Third, ARC tasks are inherently *visual*, yet many recent solutions are language-centric [^15] [^1]. A concurrent work shows that reframing ARC as an image-to-image translation problem and applying standard vision architectures can achieve near-human performance on ARC-1 [^12]. This result suggests that high ARC scores can be obtained by improving visual representations, without necessarily requiring more general reasoning mechanisms. Our work builds on these studies and examines how perception and reasoning interact when using VLMs to solving ARC tasks.

## 3 Verifying the Hypothesis with a Two-Stage Pipeline

In this section, we formally introduce the design of a two-stage pipeline to verify the hypothesis that the performance of existing VLMs is constrained more by perception than by reasoning.

### 3.1 Abstract Reasoning Tasks

We start by formalizing the (visual) abstract reasoning tasks considered in this study. Let $\mathcal{T}$ denote a set of tasks, where each task $T\in\mathcal{T}$ consists of a small number $n$ (typically $n\leq 10$) of input-output pairs $(x_{i}\mathchar 59\relax y_{i})\in\mathcal{X}\times\mathcal{Y}$ serving as demonstration examples, together with a test example for which only the input ($x_{n+1}$) is observed. Formally,

$$
T=\left\{(x_{1}\mathchar 59\relax y_{1})\mathchar 59\relax\ldots\mathchar 59\relax(x_{n}\mathchar 59\relax y_{n})\mathchar 59\relax\;x_{n+1}\right\}.
$$

The goal of the task is to predict the corresponding output $y_{n+1}$ by inductively inferring the underlying relationship between inputs and outputs from the demonstration examples. Figure 2 illustrates example tasks from two ARC-style benchmarks, where each task involves images as inputs and, in some cases, as both inputs and outputs. A shared characteristic of these benchmarks is that the images contain objects that are are immediately and unambiguously recognizable to humans, which serve as the critical basis for the latent mapping rules.

Figure 2: Example tasks of two ARC-style benchmarks, Mini-ARC [^14] and Bongard-LOGO [^23]. The task in Mini-ARC maps image inputs to image outputs. The task in Bongard-LOGO maps image inputs to binary outputs (positive or negative). In both cases, visual objects that are immediately recognizable by humans serve as the critical basis for the latent mapping rules.

When evaluated on these benchmarks, a frontier VLM model is typically used as a mapping $f\mathrel{\mathop{\ordinarycolon}}\mathcal{T}\rightarrow\mathcal{Y}$ that directly predicts $y_{n+1}$ with $f(T)$, given the task $T$ with raw image inputs. However, the model can significantly underperform humans in recognizing the objects visually salient to humans. In this end-to-end evaluation paradigm, it is difficult to quantify the extent to which the model performance is limited by the model’s perception capabilities compared to its reasoning capabilities.

### 3.2 Quantifying the Perception Bottleneck with a Two-Stage Pipeline

To verify our hypothesis and quantify the perception bottleneck of VLMs, we evaluate the models with a two-stage pipeline that explicitly separates perception and reasoning. In the first stage (the perception stage), images are transformed into natural language descriptions. In the second stage (the reasoning stage), the model takes these descriptions to enrich the task representation $T$, and predicts the output $y_{n+1}$ on the test example.

#### Design Principles of the Perception Stage.

The perception stage is designed according to two key principles:

1. No cross-image inductive signal leakage. The transformation is applied independently to each image in isolation, ensuring that it reduces perceptual difficulty without introducing inductive cues that could alter the intrinsic reasoning difficulty of the task.
2. Generic human perceptual priors. The transformation incorporates generic human perceptual priors, such as the identification of objects and recognition of their colors or shapes. This choice directly reflects our hypothesis that the human–AI performance gap is largely driven by the fact that these benchmarks favor human’s innate visual perception.

#### Formal Description of the Two-Stage Pipeline.

Formally, for each benchmark, we construct two *uniform* transformations, $g_{\mathcal{X}}\mathrel{\mathop{\ordinarycolon}}\mathcal{X}\rightarrow\widetilde{\mathcal{X}}$ and $g_{\mathcal{Y}}\mathrel{\mathop{\ordinarycolon}}\mathcal{Y}\rightarrow\widetilde{\mathcal{Y}}$, which are respectively applied to the input and output spaces, consistently across all tasks within the benchmark. In practice, these transformations are implemented by prompting a VLM model to convert each image into a corresponding natural language description, with prompts that explicitly instruct the model to attend to features aligned with generic human visual priors. When the output is not an image, the transformation $g_{\mathcal{Y}}$ is defined as the identity mapping. With these transformations, a task $T=\left\{(x_{1}\mathchar 59\relax y_{1})\mathchar 59\relax\ldots\mathchar 59\relax(x_{n}\mathchar 59\relax y_{n})\mathchar 59\relax\;x_{n+1}\right\}$ will be enriched as

$$
\displaystyle\widetilde{T}=\Big\{
$$
 
$$
\displaystyle(x_{1}\mathchar 59\relax g_{\mathcal{X}}(x_{1})\mathchar 59\relax y_{1}\mathchar 59\relax g_{\mathcal{Y}}(y_{1}))\mathchar 59\relax\ldots\mathchar 59\relax
$$
 
$$
\displaystyle(x_{n}\mathchar 59\relax g_{\mathcal{X}}(x_{n})\mathchar 59\relax y_{n}\mathchar 59\relax g_{\mathcal{Y}}(y_{n}))\mathchar 59\relax\;
$$
$$
\displaystyle(x_{n+1}\mathchar 59\relax g_{\mathcal{X}}(x_{n+1}))\Big\}\in\widetilde{\mathcal{T}}\mathchar 59\relax
$$

which will be further fed into a VLM, $h\mathrel{\mathop{\ordinarycolon}}\widetilde{\mathcal{T}}\rightarrow\mathcal{Y}$, during the reasoning stage to complete the prediction $h(\widetilde{T})$.

### 3.3 Two Evaluation Settings

We consider two evaluation settings that differ in how VLMs are instantiated within the two-stage pipeline.

#### Setting 1: Same-Model Perception.

In the first setting, we use the same VLM for the transformations $g_{\bullet}$, the reasoning stage $h$, as well as the baseline end-to-end one-stage predictor $f$. In this case, we expect the two-stage prediction $h(\widetilde{T})$ to outperform the one-stage prediction $f(T)$, as the perception stage explicitly incorporates additional human perceptual priors. Importantly, any performance improvement in this comparison can be attributed solely to the mitigation of the perception bottleneck, since the two-stage pipeline does not reduce the inductive reasoning difficulty by design <sup>2</sup>.

#### Setting 2: Stronger-Model Perception.

In the second setting, we use a stronger VLM for the transformations $g_{\bullet}$, and a weaker VLM for the reasoning stage $h$. In this case, we compare this hybrid two-stage pipeline against end-to-end one-stage predictions using the strong and weak models, denoted by $f_{S}(T)$ and $f_{W}(T)$, respectively. First, we expect $h(\widetilde{T})$ to substantially outperform $f_{W}(T)$, since the perception stage is further enhanced. Second, if the performance of $h(\widetilde{T})$ approaches that of $f_{S}(T)$, this suggests that the performance gap between the weak and strong models is driven primarily by differences in perception capability rather than reasoning capability.

### 3.4 Fine-Grained Error Attribution with Four Categories

#### Conceptual Decomposition of the Task-Solving Process.

Given the similar task structure of the abstract reasoning benchmarks, we conceptually decompose the task-solving process into four steps:

1. Perception (Demonstration). The system must correctly perceive each input pair $(x_{i}\mathchar 59\relax y_{i})$.
2. Reasoning (Inductive). From the correctly perceived demonstrations, the system must infer the underlying latent mapping rule that governs the task.
3. Perception (Testing). The system must also accurately perceive the test input.
4. Reasoning (Deductive). Given the inferred rule, the system applies it to the test input to make the correct prediction.

This decomposition distinguishes steps (1) and (3), which primarily depend on perception capabilities, from steps (2) and (4), which primarily depend on reasoning capabilities. It is worth noting that the four steps are not independent. For example, an error in the step 1 will propagate to and cause failures in steps (2) and (4). An illustration of the dependency of these steps is shown in 3.

![Refer to caption](https://arxiv.org/html/2512.21329v2/figures/dependency-graph-new.png)

Figure 3: Dependency graph illustrating the four-step task-solving process. Errors in earlier stages propagate to subsequent stages, affecting final predictions.

#### Error Attribution with Four Categories.

We observe that the failure cases in our experiments can almost always be attributed to one of four error categories corresponding to the four steps above. In practice, this error attribution can be done by manually inspecting the reasoning traces in the VLM outputs. This procedure is applicable to both one-stage and two-stage predictions. To enable a fair comparison between one-stage and two-stage predictions on the same benchmark, we assign the prediction on each task to one of five categories: the four error categories and a *Correct* category, ensuring that total counts match across the two prediction settings. Given the largely sequential dependency among the four steps, errors are attributed to the earliest step at which a failure occurs. In Section 4.4, we conduct large-scale error attribution across multiple benchmarks for both one-stage and two-stage predictions, and demonstrate that the performance gains of the two-stage pipeline over the one-stage baseline arise almost exclusively from a reduction in perception errors, i.e., errors in steps (1) and (3).

## 4 Experiments

### 4.1 Datasets

We conduct experiments on three ARC-style visual abstract reasoning benchmarks. These datasets are designed to assess compositional and inductive reasoning from visual inputs, making them well suited for studying the interplay between perception and reasoning in VLMs.

#### Mini-ARC.

Mini-ARC [^14] is a reduced-scale variant of ARC with fewer colors, smaller grids, and simplified transformations. It maintains the same format as ARC but with lower perceptual complexity, making it useful for isolating reasoning performance under easier perception.

#### ACRE (Abstract Causal REasoning Beyond Covariation).

ACRE [^31] is a symbolic visual reasoning benchmark designed for causal induction. Each task is formulated as a classification problem conditioned on demonstrations. Specifically, a task consists of six demonstrations followed by four prediction queries. The demonstrations illustrate the presence or absence of certain objects and the corresponding state of a pink board, which may blink (activated), remains unlit (deactivated), or be underdetermined. Each query presents a new configuration of objects, and the objective is to predict the status of the pink board.

#### Bongard-LOGO.

Bongard-LOGO [^23] is a visual reasoning benchmark inspired by the classic Bongard problems, adapted to the domain of programmatic graphics. Each task presents two sets of images: positive examples and negative examples. The images are generated from programs in the LOGO language, with the positive set sharing an underlying semantic concept that is absent from the negative set. Given these examples, the model must infer the underlying concept and correctly classify novel test instances as belonging to the positive or negative set.

### 4.2 Setting 1: Same-Model Perception

We first report the experiments corresponding to the first evaluation setting (Same-Model Perception) described in Section 3.3, where we compare the two-stage pipeline and the one-stage baseline using the same VLM. We use GPT-4o for Mini-ARC and Bongard-LOGO, while using LLaVA-1.5 [^17] for ACRE. Table 1 summarizes concrete settings for each dataset.

Table 1: Experimental setups for each dataset in Setting 1 (Same-Model Perception). We have two configurations (a) and (b) for each dataset. Stage: “S” refers to standard one-stage pipeline; “P+R” refers to two-stage pipeline with separate perception (“P”) and reasoning (“R”).

<table><thead><tr><th>ID</th><th>Dataset</th><th>Config</th><th>Stage</th><th>Model</th></tr></thead><tbody><tr><td rowspan="2">1</td><td rowspan="2">Mini-ARC</td><td>(a)</td><td>S</td><td>GPT-4o</td></tr><tr><td>(b)</td><td>P+R</td><td>GPT-4o (P) + GPT-4o (R)</td></tr><tr><td rowspan="2">2</td><td rowspan="2">Bongard-LOGO</td><td>(a)</td><td>S</td><td>GPT-4o</td></tr><tr><td>(b)</td><td>P+R</td><td>GPT-4o (P) + GPT-4o (R)</td></tr><tr><td rowspan="2">3</td><td rowspan="2">ACRE</td><td>(a)</td><td>S</td><td>LLaVA-1.5</td></tr><tr><td>(b)</td><td>P+R</td><td>LLaVA-1.5 (P) + LLaVA-1.5 (R)</td></tr></tbody></table>

#### Results.

We report the experiment results in Table 2. Across three datasets, enhancing perception through natural language descriptions consistently improves success rates by 11–13 percentage points. Notably, on Mini-ARC this corresponds to a $2.5\times$ relative improvement, increasing performance from 8.05% to 20.13%. These results are consistent with our expectation for Setting 1 described in Section 3.3, which supports our hypothesis that perception plays a more important role for the success in these tasks.

Table 2: Success rates (%) in Setting 1 (Same-Model Perception). The columns (a) and (b) correspond to the configurations defined in Table 1. $\Delta$ refers to the absolute improvement from (a) to (b) in percentage points.

| ID | Dataset | (a) | (b) | $\bm{\Delta}$ |
| --- | --- | --- | --- | --- |
| 1 | Mini-ARC | 8.05 | 20.13 | +12.08 |
| 2 | Bongard-LOGO | 62.00 | 73.00 | +11.00 |
| 3 | ACRE | 22.00 | 34.50 | +12.50 |

### 4.3 Setting 2: Stronger-Model Perception

We further conduct experiments corresponding to the second evaluation setting (Stronger-Model Perception) described in Section 3.3, where we use a stronger VLM for the perception stage in the two-stage pipeline. We conduct these experiments on the three datasets mentioned above, where we replace the weaker model used in the perception stage with a stronger model. We also compare against standard one-stage pipelines that use a weak model or a strong model. For Mini-ARC, we consider two different strong models: o1 and Claude-Sonnet-4.5. The concrete configurations are summarized in Table 3.

Table 3: Experimental setups in Setting 2 (Stronger-Model Perception). Configurations (a) and (b) are identical to those in Table 1. Configurations (c) and (d) introduce stronger models either in the perception stage or in a unified one-stage pipeline.

<table><tbody><tr><td>ID</td><td>Dataset</td><td>Config</td><td>Model(s)</td></tr><tr><td rowspan="6">1</td><td rowspan="6">Mini-ARC</td><td>(a)</td><td>GPT-4o (S)</td></tr><tr><td>(b)</td><td>GPT-4o (P) + GPT-4o (R)</td></tr><tr><td>(c1)</td><td>o1 (P) + GPT-4o (R)</td></tr><tr><td>(c2)</td><td>Claude-Sonnet-4.5 (P) + GPT-4o (R)</td></tr><tr><td>(d1)</td><td>o1 (S)</td></tr><tr><td>(d2)</td><td>Claude-Sonnet-4.5 (S)</td></tr><tr><td rowspan="4">2</td><td rowspan="4">Bongard-LOGO</td><td>(a)</td><td>GPT-4o (S)</td></tr><tr><td>(b)</td><td>GPT-4o (P) + GPT-4o (R)</td></tr><tr><td>(c)</td><td>o1 (P) + GPT-4o (R)</td></tr><tr><td>(d)</td><td>o1 (S)</td></tr><tr><td rowspan="4">3</td><td rowspan="4">ACRE</td><td>(a)</td><td>LLaVA-1.5 (S)</td></tr><tr><td>(b)</td><td>LLaVA-1.5 (P) + LLaVA-1.5 (R)</td></tr><tr><td>(c)</td><td>GPT-4o (P) + LLaVA-1.5 (R)</td></tr><tr><td>(d)</td><td>GPT-4o (S)</td></tr></tbody></table>

Table 4: Success rates (%) under Setting 2 (Stronger-Model Perception). Configurations (a)–(d) correspond to those defined in Table 3.

<table><thead><tr><th>Dataset</th><th>(a)</th><th>(b)</th><th>(c*)</th><th>(d*)</th></tr></thead><tbody><tr><th rowspan="2">Mini-ARC</th><td rowspan="2">8.05</td><td rowspan="2">20.13</td><td>(c1) 31.54</td><td>(d1) 52.03</td></tr><tr><td>(c2) 32.89</td><td>(d2) 34.22</td></tr><tr><th>Bongard-LOGO</th><td>62.00</td><td>73.00</td><td>80.00</td><td>78.00</td></tr><tr><th>ACRE</th><td>22.00</td><td>34.50</td><td>82.50</td><td>93.00</td></tr></tbody></table>

Table 5: Error attribution across datasets and experiment configurations. Regarding the settings, for example, “1(a)” refers to the configuration (a) on Mini-ARC, while “3(c)” refers to the configuration (c) on ACRE.

((a)) Mini-ARC

| Setting | 1(a) | 1(b) |
| --- | --- | --- |
| Total Errors | 44 | 37 |
| Perception (Demo) | 38 (86.4%) | 22 (59.5%) |
| Reasoning (Inductive) | 4 (9.1%) | 9 (24.3%) |
| Perception (Test) | 1 (2.3%) | 2 (5.4%) |
| Reasoning (Deductive) | 1 (2.3%) | 4 (10.8%) |

((b)) Bongard-LOGO

| Setting | 2(a) | a(b) |
| --- | --- | --- |
| Total Errors | 38 | 27 |
| Perception (Demo) | 25 (65.8%) | 10 (37.0%) |
| Reasoning (Inductive) | 5 (13.2%) | 12 (44.4%) |
| Perception (Test) | 7 (18.4%) | 3 (11.1%) |
| Reasoning (Deductive) | 1 (2.6%) | 2 (7.4%) |

((c)) ACRE

| Setting | 3(a) | 3(b) |
| --- | --- | --- |
| Total Errors | 38 | 32 |
| Perception (Demo) | 29 (76.3%) | 22 (68.8%) |
| Reasoning (Inductive) | 6 (15.8%) | 7 (21.9%) |
| Perception (Test) | 3 (7.9%) | 3 (9.4%) |
| Reasoning (Deductive) | 0 (0%) | 0 (0%) |

((d)) ACRE (varying P)

| Setting | 3(b) | 3(c) |
| --- | --- | --- |
| Total Errors | 32 | 9 |
| Perception (Demo) | 22 (68.8%) | 0 (0%) |
| Reasoning (Inductive) | 7 (21.9%) | 9 (100%) |
| Perception (Test) | 3 (9.4%) | 0 (0%) |
| Reasoning (Deductive) | 0 (0%) | 0 (0%) |

![Refer to caption](https://arxiv.org/html/2512.21329v2/figures/1_arc_new.png)

(a) 1(a) → \\rightarrow 1(b)

#### Results.

As can be seen in Table 4, strengthening the perception module ((b) $\rightarrow$ (c\*) <sup>3</sup>) yields consistent and substantial improvement, indicating that perception is indeed the dominant bottleneck in this setting. Furthermore, the performance in (c\*) and that in (d\*), the standard one-stage pipeline with the strong model, are mostly close <sup>4</sup>, suggesting that perception constitutes the main bottleneck explaining the performance difference between the strong model (d\*) and the weak model (a).

### 4.4 Error Attribution

In order to further validate the hypothesis and gain insights into the causes of errors, we conduct error attribution on the failure cases for different configurations <sup>5</sup> across datasets, following the protocol introduced in Section 3.4. Specifically, for configurations on Mini-ARC and ACRE, we randomly select 50 tasks, and for those on Bongard-LOGO, we randomly select 100 tasks. Among these, some tasks may have been correctly solved by the model, while for the remaining ones we perform detailed error attribution.

#### Results.

As shown in Table 5, perception errors consistently dominate across all setups, indicating that the visual understanding stage is the primary bottleneck. On Mini-ARC, perception errors account for 86.4% of all errors in setting 1(a) (standard one-stage) and 59.5% in setting 1(b) (two-stage). A similar trend is observed on Bongard-LOGO, where perception errors represent 65.8% (2(a)) and 37.0% (2(b)) of total errors, and on ACRE, where perception errors reach 76.3% (3(a)) and 68.8% (3(b)). On ACRE with varying P, where different perception modules are compared, the model with LLaVA1.5 still shows 68.8% perception errors, while GPT-4o eliminates perception errors, with all remaining errors in reasoning stages.

These results clearly demonstrate that the perception stage remains the dominant source of model failure, overshadowing reasoning-related errors (both inductive and deductive). Moreover, this fine-grained error attribution provides more direct evidence that the performance improvement in both Setting 1 and Setting 2 are achieved through the mitigation of perception errors. This result highlights the importance of perception in tasks that are often regarded as reasoning tasks.

To gain deeper insight into this attribution, we further analyze how error types evolve across experimental configurations, specifically, how perception-related errors transition into reasoning errors (and vice versa) under different configurations, shown in Figure 4. From the analysis, we observe that a substantial portion of perception errors are either eliminated or transformed into downstream reasoning errors, and that the majority of performance gains arise from resolving perception-related errors rather than improving reasoning.

## 5 Conclusion

In this work, we critically re-examine the interpretation of ARC-style benchmarks as direct measures of machine reasoning ability and show that a substantial portion of the observed human–AI performance gap is driven instead by limitations in visual perception. By introducing a carefully controlled two-stage pipeline that explicitly separates perception from reasoning, and by conducting fine-grained error attribution across multiple benchmarks, we demonstrate that mitigating perceptual bottlenecks alone leads to large performance gains, while improvements in reasoning play a secondary role. These findings suggest that ARC-style benchmarks conflate perceptual and inductive challenges, potentially overstating deficiencies in model reasoning. More broadly, our results underscore the importance of evaluation protocols that disentangle perception from reasoning when assessing progress toward general intelligence, and point to the need for future benchmarks that more cleanly isolate the cognitive capabilities they aim to measure.

## Limitations

Our study has several limitations. First, the natural-language descriptions used in the perception stage should not be interpreted as an optimal or canonical intermediate representation for abstract reasoning. We adopt language as a convenient and interpretable way to inject generic human perceptual priors and to demonstrate the existence and impact of perceptual bottlenecks in ARC-style benchmarks. We do not claim that natural language is the best representation for isolating reasoning, nor that it preserves all aspects of the original task structure without distortion.

Second, our fine-grained error attribution relies on manual inspection of model outputs and reasoning traces. While this attribution follows a clearly defined, stage-wise protocol and yields consistent patterns across datasets and experimental settings, it involves some subjectivity. We leave the development of scalable and fully automated attribution methods to future work.

Finally, our conclusions are limited to ARC-style, knowledge-light visual abstraction benchmarks and to the vision-language models evaluated in this study. We do not claim that perception is the dominant bottleneck for all multimodal or textual reasoning tasks. Nevertheless, we hope that the diagnostic perspective and methodology introduced in this work can inspire future research on disentangling perception and reasoning in a broader range of reasoning benchmarks and evaluation settings.

[^1]: E. Akyürek, M. Damani, A. Zweiger, L. Qiu, H. Guo, J. Pari, Y. Kim, and J. Andreas The surprising effectiveness of test-time training for few-shot learning. In Proceedings of the 42nd International Conference on Machine Learning, A. Singh, M. Fazel, D. Hsu, S. Lacoste-Julien, F. Berkenkamp, T. Maharaj, K. Wagstaff, and J. Zhu (Eds.), Proceedings of Machine Learning Research, Vol. 267, pp. 942–963. External Links: [Link](https://proceedings.mlr.press/v267/akyurek25a.html) Cited by: §2, §2.

[^2]: ARC Prize Foundation ARC-agi-1 benchmark. Note: Web pageaccessed 2025-11-22 External Links: [Link](https://arcprize.org/arc-agi/1/) Cited by: §1, §1, §1, §2.

[^3]: ARC Prize, Inc. ARC-agi-1 leaderboard. External Links: [Link](https://arcprize.org/leaderboard) Cited by: §2.

[^4]: M. Chen, J. Tworek, H. Jun, Q. Yuan, H. de Oliveira Pinto, J. Kaplan, H. Edwards, Y. Burda, N. Joseph, G. Brockman, A. Ray, G. Puri, G. Krueger, M. Petrov, H. Khlaaf, G. Sastry, P. Mishkin, B. Chan, S. Gray, N. Ryder, M. Pavlov, A. Power, L. Kaiser, M. Bavarian, C. Winter, P. Tillet, F. Such, D. Cummings, M. Plappert, F. Chantzis, E. Barnes, A. Herbert-Voss, W. Guss, A. Nichol, C. Paino, N. Tezak, J. Tang, I. Babuschkin, S. Balaji, S. Jain, W. Saunders, C. Hesse, P. Dhariwal, P. Shyam, T. Bilal, X. Chu, S. Li, T. Lin, J. Kaplan, S. McCandlish, D. Amodei, I. Sutskever, and W. Zaremba Evaluating large language models trained on code. arXiv preprint arXiv:2107.03374. Cited by: §1, §2.

[^5]: F. Chollet, M. Knoop, G. Kamradt, B. Landers, and H. Pinkard Arc-agi-2: a new challenge for frontier ai reasoning systems. arXiv preprint arXiv:2505.11831. Cited by: §1.

[^6]: F. Chollet, M. Knoop, G. Kamradt, and B. Landers ARC prize 2024: technical report. arXiv preprint arXiv:2412.04604. External Links: [Link](https://arxiv.org/abs/2412.04604) Cited by: §1, §1, §2.

[^7]: F. Chollet On the measure of intelligence. arXiv preprint arXiv:1911.01547. Cited by: §1.

[^8]: K. Cobbe, V. Kosaraju, M. Bavarian, M. Chen, H. Jun, L. Kaiser, M. Plappert, J. Tworek, J. Hilton, R. Nakano, et al. Training verifiers to solve math word problems. arXiv preprint arXiv:2110.14168. Cited by: §2.

[^9]: D. Franzen, J. Disselhoff, and D. Hartmann The architects - technical report: arc prize 2025 solution. Note: Accessed: 2026-01-04 External Links: [Link](https://lambdalabsml.github.io/ARC2025_Solution_by_the_ARChitects/) Cited by: §2.

[^10]: D. /. Google Gemini — our most intelligent ai models. Note: Web pageaccessed 2025-11-22 External Links: [Link](https://deepmind.google/models/gemini/) Cited by: §1.

[^11]: D. Hendrycks, C. Burns, S. Basart, A. Zou, M. Mazeika, D. Song, and J. Steinhardt Measuring massive multitask language understanding. arXiv preprint arXiv:2009.03300. Cited by: §2.

[^12]: K. Hu, A. Cy, L. Qiu, X. D. Ding, R. Wang, Y. E. Zhu, J. Andreas, and K. He ARC is a vision problem!. arXiv preprint arXiv:2511.14761. Cited by: §2, §2.

[^13]: A. Jolicoeur-Martineau Less is more: recursive reasoning with tiny networks. arXiv preprint arXiv:2510.04871. Cited by: §2.

[^14]: S. Kim, P. Phunyaphibarn, D. Ahn, and S. Kim Playgrounds for abstraction and reasoning. In NeurIPS 2022 Workshop on Neuro Causal and Symbolic AI (nCSI), Cited by: §1, Figure 2, §4.1.

[^15]: W. Li, K. Hu, C. Larsen, Y. Wu, S. Alford, C. Woo, S. M. Dunn, H. Tang, M. Naim, D. Nguyen, et al. Combining induction and transduction for abstract reasoning. arXiv preprint arXiv:2411.02272. Cited by: §2, §2.

[^16]: I. Liao and A. Gu ARC-agi without pretraining. arXiv preprint arXiv:2512.06104. Cited by: §2.

[^17]: H. Liu, C. Li, Y. Li, and Y. J. Lee Improved baselines with visual instruction tuning. In Proceedings of the IEEE/CVF conference on computer vision and pattern recognition, pp. 26296–26306. Cited by: §4.2.

[^18]: Y. Liu, H. Duan, Y. Zhang, B. Li, S. Zhang, W. Zhao, Y. Yuan, J. Wang, C. He, Z. Liu, et al. Mmbench: is your multi-modal model an all-around player?. In European conference on computer vision, pp. 216–233. Cited by: §2.

[^19]: P. Lu, H. Bansal, T. Xia, J. Liu, C. Li, H. Hajishirzi, H. Cheng, K. Chang, M. Galley, and J. Gao Mathvista: evaluating mathematical reasoning of foundation models in visual contexts. arXiv preprint arXiv:2310.02255. Cited by: §2.

[^20]: P. Lu, S. Mishra, T. Xia, L. Qiu, K. Chang, S. Zhu, O. Tafjord, P. Clark, and A. Kalyan Learn to explain: multimodal reasoning via thought chains for science question answering. Advances in Neural Information Processing Systems 35, pp. 2507–2521. Cited by: §2.

[^21]: M. Mathew, D. Karatzas, and C. Jawahar Docvqa: a dataset for vqa on document images. In Proceedings of the IEEE/CVF winter conference on applications of computer vision, pp. 2200–2209. Cited by: §2.

[^22]: M. Mitchell Did openai just solve abstract reasoning?. Note: AI: A Guide for Thinking Humans (Substack)accessed 2025-01-04 External Links: [Link](https://aiguide.substack.com/p/did-openai-just-solve-abstract-reasoning) Cited by: §2.

[^23]: W. Nie, Z. Yu, L. Mao, A. B. Patel, Y. Zhu, and A. Anandkumar Bongard-logo: a new benchmark for human-level concept learning and reasoning. Advances in Neural Information Processing Systems 33, pp. 16468–16480. Cited by: §1, §2, Figure 2, §4.1.

[^24]: OpenAI Introducing o3 and o3-mini (announcement video). Note: YouTube videoaccessed 2025-11-22 External Links: [Link](https://www.youtube.com/watch?v=SKBG1sqdyIU&t=305s) Cited by: §1.

[^25]: D. Rein, B. L. Hou, A. C. Stickland, J. Petty, R. Y. Pang, J. Dirani, J. Michael, and S. R. Bowman Gpqa: a graduate-level google-proof q&a benchmark. In First Conference on Language Modeling, Cited by: §1, §2.

[^26]: A. Singh, V. Natarajan, M. Shah, Y. Jiang, X. Chen, D. Batra, D. Parikh, and M. Rohrbach Towards vqa models that can read. In Proceedings of the IEEE/CVF conference on computer vision and pattern recognition, pp. 8317–8326. Cited by: §2.

[^27]: M. Suzgun, N. Scales, N. Schärli, S. Gehrmann, Y. Tay, H. W. Chung, A. Chowdhery, Q. Le, E. Chi, D. Zhou, et al. Challenging big-bench tasks and whether chain-of-thought can solve them. In Findings of the Association for Computational Linguistics: ACL 2023, pp. 13003–13051. Cited by: §2.

[^28]: G. Wang, J. Li, Y. Sun, X. Chen, C. Liu, Y. Wu, M. Lu, S. Song, and Y. A. Yadkori Hierarchical reasoning model. arXiv preprint arXiv:2506.21734. Cited by: §2.

[^29]: X. Yue, Y. Ni, K. Zhang, T. Zheng, R. Liu, G. Zhang, S. Stevens, D. Jiang, W. Ren, Y. Sun, et al. Mmmu: a massive multi-discipline multimodal understanding and reasoning benchmark for expert agi. In Proceedings of the IEEE/CVF Conference on Computer Vision and Pattern Recognition, pp. 9556–9567. Cited by: §2.

[^30]: X. Yue, T. Zheng, Y. Ni, Y. Wang, K. Zhang, S. Tong, Y. Sun, B. Yu, G. Zhang, H. Sun, et al. Mmmu-pro: a more robust multi-discipline multimodal understanding benchmark. In Proceedings of the 63rd Annual Meeting of the Association for Computational Linguistics (Volume 1: Long Papers), pp. 15134–15186. Cited by: §1.

[^31]: C. Zhang, B. Jia, M. Edmonds, S. Zhu, and Y. Zhu Acre: abstract causal reasoning beyond covariation. In Proceedings of the ieee/cvf conference on computer vision and pattern recognition, pp. 10643–10653. Cited by: §1, §2, §4.1.