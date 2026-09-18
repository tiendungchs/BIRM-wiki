---
title: "Rethinking Visual Intelligence: Insights from Video Pretraining"
source: "https://arxiv.org/html/2510.24448"
author:
published:
created: 2026-09-19
description:
tags:
  - "clippings"
---
Pablo Acuaviva Affiliation: Computer Vision Group, University of Bern, Switzerland    Aram Davtyan Affiliation: Computer Vision Group, University of Bern, Switzerland    Mariam Hassan Affiliation: VITA Lab, EPFL, Lausanne, Switzerland    Sebastian Stapf Affiliation: Computer Vision Group, University of Bern, Switzerland    Ahmad Rahimi Affiliation: VITA Lab, EPFL, Lausanne, Switzerland    Alexandre Alahi Affiliation: VITA Lab, EPFL, Lausanne, Switzerland    Paolo Favaro Affiliation: Computer Vision Group, University of Bern, Switzerland

###### Abstract

Large language models (LLMs) have demonstrated that large-scale pretraining enables systems to adapt rapidly to new problems with little supervision in the language domain. This success, however, has not translated as effectively to the visual domain, where models, including LLMs, continue to struggle with compositional understanding, sample efficiency, and general-purpose problem-solving. We investigate Video Diffusion Models (VDMs) as a promising direction for bridging this gap. Pretraining on spatiotemporal data endows these models with strong inductive biases for structure and dynamics, which we hypothesize can support broad task adaptability. To test this, we design a controlled evaluation in which both a pretrained LLM and a pretrained VDM are equipped with lightweight adapters and presented with tasks in their natural modalities. Across benchmarks including ARC-AGI, ConceptARC, visual games, route planning, and cellular automata, VDMs demonstrate higher data efficiency than their language counterparts. Taken together, our results indicate that video pretraining offers inductive biases that support progress toward visual foundation models.

<sup>†</sup>

## 1 Introduction

Figure 1: Radar plot showing ConceptARC competencies between VDMs and LLMs, GPT-4 \[IC\] is added for additional reference.

Foundation models have reshaped natural language processing by showing that large-scale pretraining can equip models with broad knowledge and strong inductive priors. This foundation allows models to adapt quickly and effectively to new tasks through techniques like in-context learning [^4] and parameter-efficient fine-tuning [^28], achieving strong performance with minimal supervision. The success of Large Language Models (LLMs) illustrates how scale and pretraining can create systems that generalize across diverse problems. Achieving a similar level of versatility in vision, however, remains largely unexplored and a major challenge. Despite recent breakthroughs in image and video generation [^22] [^33] [^35], vision models are not yet on par with LLMs when it comes to compositional skills, sample efficiency, and versatility in problem solving.

Video Diffusion Models (VDMs) represent an exciting direction for narrowing this gap. Pretraining on rich spatiotemporal data endows them with strong inductive biases for spatial structure and temporal dynamics [^3] [^13] [^46], which we hypothesize can be harnessed for structured visual understanding. We move beyond treating videos as mere generative artifacts and instead regard them as a natural representation for problem solving, where tasks are expressed as transformations unfolding over time. Building on this perspective, we introduce a simple and general framework for adapting VDMs to a broad class of visual tasks and evaluate them head-to-head with equally adapted LLMs (see Figure 1). This setup allows us to test whether large-scale video pretraining offers a complementary foundation for structured visual problem-solving, contrasting the strengths of visually grounded models with those of symbolically trained language models.

Each task is represented consistently but adapted to each model family’s modality: LLMs operate in a text-to-text setting, where inputs and outputs are serialized into structured text, while VDMs receive an image-to-image formulation, where input–output pairs are rendered as short videos to model the task as a temporal transformation. Both model families use identical LoRA-based [^17] adaptation: adapters are inserted at corresponding layers, pretrained backbones remain frozen, and only lightweight parameters are updated. This symmetry provides a controlled basis for comparison and isolates the impact of video pretraining on structured visual understanding.

Our contributions are as follows:

<svg id="S1.p5.pic1" height="190.37" overflow="visible" version="1.1" viewBox="0 0 550 190.37" width="550"><g style="--ltx-stroke-color:#000000;--ltx-fill-color:#000000;" fill="#000000" stroke="#000000" stroke-width="0.4pt" transform="translate(0,190.37) matrix(1 0 0 -1 0 0)"><g style="--ltx-fill-color:#B4C3DC;" fill="#B4C3DC" fill-opacity="1.0"><path style="stroke:none" d="M 0 6.23 L 0 184.14 C 0 187.58 2.79 190.37 6.23 190.37 L 543.77 190.37 C 547.21 190.37 550 187.58 550 184.14 L 550 6.23 C 550 2.79 547.21 0 543.77 0 L 6.23 0 C 2.79 0 0 2.79 0 6.23 Z"></path></g><g style="--ltx-fill-color:#DAE3F0;" fill="#DAE3F0" fill-opacity="1.0"><path style="stroke:none" d="M 0.69 6.23 L 0.69 184.14 C 0.69 187.2 3.17 189.68 6.23 189.68 L 543.77 189.68 C 546.83 189.68 549.31 187.2 549.31 184.14 L 549.31 6.23 C 549.31 3.17 546.83 0.69 543.77 0.69 L 6.23 0.69 C 3.17 0.69 0.69 3.17 0.69 6.23 Z"></path></g><g fill-opacity="1.0" transform="matrix(1.0 0.0 0.0 1.0 15.7 149.84)"><foreignObject style="--ltx-fo-width:37.48em;--ltx-fo-height:1.79em;--ltx-fo-depth:9.69em;font-size:10pt;" height="158.97" overflow="visible" transform="matrix(1 0 0 -1 0 24.83)" width="518.62"><span id="S1.p5.pic1.1" style="width:37.48em;"><span id="S1.I1"><span id="S1.I1.i1" style="list-style-type:none;"><span id="S1.I1.i1.1">1.</span> <span id="S1.I1.i1.p1"><span id="S1.I1.i1.p1.1"><span id="S1.I1.i1.p1.1.1" style="--ltx-fg-color:#000000;">A unified framework for adapting VDMs to image-to-image visual tasks by reframing examples as temporal sequences.</span></span></span></span> <span id="S1.I1.i2" style="list-style-type:none;"><span id="S1.I1.i2.1">2.</span> <span id="S1.I1.i2.p1"><span id="S1.I1.i2.p1.1"><span id="S1.I1.i2.p1.1.1" style="--ltx-fg-color:#000000;">A controlled evaluation setting where both VDMs and LLMs are fine-tuned with LoRA-based adaptation, enabling direct comparison.</span></span></span></span> <span id="S1.I1.i3" style="list-style-type:none;"><span id="S1.I1.i3.1">3.</span> <span id="S1.I1.i3.p1"><span id="S1.I1.i3.p1.1"><span id="S1.I1.i3.p1.1.1" style="--ltx-fg-color:#000000;">Empirical evidence that VDMs benefit from video pretraining for visual intelligence, hinting at a path toward flexible visual foundation models with both generative and problem-solving strengths.</span></span></span></span></span></span></foreignObject></g></g></svg>

## 2 Related Work

Language Foundation Models. LLMs have demonstrated remarkable generalization and adaptability to new tasks with minimal supervision, mainly due to their large-scale pretraining on diverse text corpora [^4] [^7]. Their extensive pretraining equips LLMs with rich knowledge and strong inductive biases, enabling them to perform few-shot learning [^4] and in-context learning [^8], where models learn new tasks only by observing a handful of examples. Parameter-efficient finetuning methods like LoRA [^17] extend this adaptability allowing LLMs to specialize to new domains while the backbone is completely frozen [^25]. Together, these capabilities make LLMs highly flexible and scalable problem solvers. In this paper, we leverage this adaptability to compare the data efficiency of LLMs and VDMs across diverse visual tasks.

Video Diffusion Models. Diffusion-based generative models have recently achieved remarkable progress in video synthesis. Pioneering approaches such as CogVideo [^16] and [^41] introduced scalable architectures for text-to-video generation. More recent models like Sora [^35], MovieGen [^33], Veo 3 [^13], and CogVideoX [^48] set new standards for quality and realism. Recent work has investigated controllable video generation [^32] [^15] [^20], with the goal of producing realistic, high-quality videos while allowing precise control over motion and dynamics. These methods emphasize modeling dynamic environments and predicting plausible future states conditioned on past observations and control inputs.

Visual Foundation Models Recent work has investigated the use of generative models as generalist vision models. Methods such as image inpainting for visual prompting [^2] and image-based in-context learning [^43] demonstrate that structured inputs can enable these models to solve diverse tasks. Diffusion models have further been extended to in-context learning [^44], instruction following across heterogeneous tasks [^12], and broader computer vision problem solving [^49]. Sequential modeling has been proposed as a unified interface for scaling vision models [^1]. Building on this line of work, [^27] train CogVideoX1.5 with temporal in-context prompts for multi-task learning, but their focus remains on broad computer vision benchmarks rather than visual intelligence, and their method requires extensive training <sup>1</sup>.

Our approach does not attempt to build a foundation model from scratch. Instead, we investigate whether a pretrained VDM, pretrained extensively on next-frame prediction, can begin to exhibit the properties expected of visual foundation models by leveraging inductive biases gained through spatiotemporal pretraining.

## 3 Methodology

### 3.1 Setup and Comparison Protocol

We adopt the definition of intelligence proposed by [^5]:

> The intelligence of a system is a measure of its skill acquisition efficiency over a scope of tasks with respect to priors, experience, and generalization difficulty.

This perspective motivates our evaluation design. We focus not only on absolute accuracy but also on how quickly models acquire new capabilities when exposed to limited supervision.

To evaluate our hypothesis we curate a diverse benchmark of visually grounded tasks that can be specified textually as grid-based problems, including ARC-AGI, Sudoku solving, and route planning. We now describe the evaluation setup in detail.

Let $\mathcal{T}$ denote a task with dataset $\mathcal{D}_{\mathcal{T}}=\{(x_{i},y_{i})\}_{i=1}^{n}$, where each $x_{i}$ and $y_{i}$ is an input-output pair. Each sample is expressed in two complementary modalities:

Image

An image pair $(I(x_{i}),I(y_{i}))$, where $I(\cdot)$ deterministically renders RGB images of size $(3\times H\times W)$.

Text

A JSON pair $(J(x_{i}),J(y_{i}))$, where $J(\cdot)$ maps a grid to a compact JSON string.

We serialize samples in a neutral format that avoids domain-specific priors, requiring both models to infer task rules directly from raw representations. Training and evaluation splits are identical across all models to ensure a fair and controlled comparison. VDMs are trained directly on the image modality using our approach, which we detail in the next section, while LLMs are trained on the text modality.

We define accuracy as the proportion of test instances where the predicted output exactly matches the ground truth grid. For tasks where multiple valid solutions may exist (e.g., Sudoku, Sudoku Mini, Hitori), we filter datasets to ensure each instance has an unique solution. When unique solutions cannot easily be guaranteed, as in Shortest Path, we introduce complementary metrics to better capture solution quality (see Section 4.2.2).

To evaluate efficiency of skill acquisition, we consider two complementary settings.

ARC Family. We evaluate models on ARC-AGI and ConceptARC, where the challenge is to solve diverse tasks from only 2–5 demonstrations. Following prior work [^30] [^5] [^24], we measure how many tasks each model can solve under this minimal supervision regime.

Structured Visual Tasks. We then turn to structured benchmarks. Here we systematically vary $n$, the number of training examples per task, to trace curves and quantify the rate of skill acquisition rather than focusing solely on endpoint accuracy.

### 3.2 Adapting Video Diffusion Models for Image-to -Image

We adapt pretrained VDMs to image-to-image (I2I) prediction tasks by re-framing each input–output pair $(I_{x_{i}},I_{y_{i}})$ as a short *transition video*. This leverages the generative prior of VDMs, while requiring minimal supervision.

##### Transition video construction

Each pair $(x_{i},y_{i})$ is converted into a temporal sequence $v_{i}=[v_{i,1},\dots,v_{i,F}]$, where

$$
v_{i,1}=I(x_{i}),\quad v_{i,F}=I(y_{i}).
$$

Intermediate frames are generated with an interpolation function $\phi$. For example, a convex interpolation produces a smooth transition

$$
v_{i,f}=\left(1-\alpha\right)I(x_{i})+\alpha I(y_{i}),\text{ where }\alpha=\tfrac{f-1}{F-1},\text{ and }f=1,\dots,F,
$$

while a discrete interpolation simply holds the input frame for the first half of the sequence and afterwards switches to the output frame:

$$
v_{i,f}=\begin{cases}I(x_{i}),&f\leq F/2,\\
I(y_{i}),&f>F/2.\end{cases}
$$

This yields a dataset $\mathcal{V}_{\mathcal{T}}$ of input-conditioned video trajectories. For our comparisons, we adopt the discrete interpolation to avoid introducing any biases.

##### Fine-tuning

We adapt a pretrained VDM by conditioning on the first frame $v^{0}_{1}$ and a neutral fixed text embedding $e_{\text{text}}$. Given a noisy video $v^{t}$ at step $t$, the model predicts noise $\epsilon_{\theta}$ via

$$
\mathcal{L}_{\text{VDM}}=\mathbb{E}_{v^{0}\sim\mathcal{V}_{\mathcal{T}},\epsilon\sim\mathcal{N}(0,\mathbf{I}),t}\left[\|\epsilon-\epsilon_{\theta}(v^{t},t,c)\|_{2}^{2}\right],\quad c=\{v^{0}_{1},e_{\text{text}}\}.
$$

We use LoRA modules for fine-tuning, updating only these additional weights while keeping the pretrained model frozen.

##### Inference

At test time, the model generates predictions through reverse diffusion. The procedure is detailed in Algorithm 1.

This procedure reframes image-to-image prediction as a conditional video generation problem, enabling efficient adaptation of pretrained VDMs to new tasks.

### 3.3 Adapting Large Language Models

We adapt pretrained LLMs to structured prediction tasks by framing each example as a JSON-to-JSON translation problem.

##### Fine-tuning

We adapt pretrained LLMs using a standard sequence-to-sequence objective. Given tokenized input–output pairs, the model is trained to maximize the likelihood of the target sequence under teacher forcing:

$$
\mathcal{L}_{\text{LLM}}=\frac{1}{n}\sum_{i=1}^{n}\sum_{t=1}^{|\mathbf{v}_{i}|}-\log p_{\theta}(v_{i,t}\mid\mathbf{u}_{i},\mathbf{v}_{i}^{<t}).
$$

We insert LoRA modules into the pretrained backbone, fine-tuning only these lightweight adapters while keeping the majority of parameters frozen.

##### Inference

At test time, predictions are generated autoregressively. The procedure is summarized in Algorithm 2.

Algorithm 1 Inference for VDM

Encode input: $c_{\text{test}}\leftarrow\{I(x_{\text{test}}),e_{\text{text}}\}$

Initialize noise: sample $v^{T}\sim\mathcal{N}(0,\mathbf{I})$

Reverse diffusion: recover $v^{0}$ conditioned on $c_{\text{test}}$

Output prediction: $\hat{y}\leftarrow v^{0}_{F}$ (final frame)

Algorithm 2 Inference for LLM

Encode input: $J(x_{\text{test}})$ as JSON string

Tokenize and feed sequence into model

Autoregressively decode output until termination

Return prediction: $\hat{y}$ as JSON string

## 4 Experiments

### 4.1 ARC Family

The ARC-AGI benchmark [^5] evaluates an agent’s ability to infer and apply abstract patterns through compositional understanding, few-shot learning, and inductive generalization. Each ARC task provides only a handful of input–output examples (typically 2–5), requiring the model to discover the underlying transformation rule and apply it to novel test inputs. This benchmark is widely regarded as a challenging measure of progress in abstraction and generalization.

We follow the evaluation protocol of [^6], which allows up to two attempts per test input and counts a question as solved only if all predictions match the ground truth. Quantitative results appear in Table 2, with qualitative examples in Figure 3. For comparison, we also report single-attempt results of commercial LLMs from [^6]. Figure 2 illustrates the overlap between tasks solved by the VDM and the LLM, underscoring their complementary strengths.

<table><tbody><tr><td>Model</td><td>Accuracy (%)</td></tr><tr><td colspan="2">Two-attempts setting</td></tr><tr><td>CogVideoX1.5-5B</td><td>16.75</td></tr><tr><td>Qwen3-4B-Instruct-2507</td><td>8.00</td></tr><tr><td colspan="2">Single-attempt setting</td></tr><tr><td>CogVideoX1.5-5B</td><td>12.50</td></tr><tr><td>Qwen3-4B-Instruct-2507</td><td>6.75</td></tr><tr><td>OpenAI o1-preview</td><td>21.00</td></tr><tr><td>Anthropic Claude 3.5 Sonnet</td><td>21.00</td></tr><tr><td>OpenAI GPT-4o</td><td>9.00</td></tr><tr><td>Google Gemini 1.5</td><td>8.00</td></tr></tbody></table>

Table 1: ARC-AGI test performance. Following the official evaluation protocol [^6], models are evaluated with two attempts per test input. We also report single-attempt results for comparability with commercial LLMs, which are only available under this setting.

Figure 2: Venn diagram of ARC-AGI tasks showing those solved exclusively by each model and those solved by both.

![Refer to caption](https://arxiv.org/html/2510.24448v2/figures/main/examples/arc_agi_005/train/train_in_000.png)

Figure 3: Qualitative results on ARC-AGI for problems 0607ce86, 7ee1c6ea, and f45f5ca7.

We evaluate models on ConceptARC [^30], a curated variant of ARC designed to systematically measure visual concept understanding and generalization. ConceptARC groups tasks into 16 concept categories (for example, Above and Below, Center, Count), with each category containing 10 tasks. Each task includes 3 distinct test inputs, creating controlled variation in visual patterns and object relationships while maintaining internal consistency within each concept group. Following the protocol of [^30], we allow three attempts per test input and mark an input as solved if any attempt is correct. Performance is reported in Figure 1, where we further include as VDMs: Wan2.1-14B [^42], LTX-13B, LTX-2B [^14], CogVideoX1.5-5B [^48] and as LLMs: Qwen3-4B-Instruct-2507, Qwen3-8B [^37], Llama3.1-8B [^29], and GPT-4 in an IC setting [^30]. Full table with results is included in the Appendix.

These results highlight the importance of strong visual priors: by leveraging representations that capture spatial structure, compositionality, and low-level visual cues, the VDM is able to approach these abstract tasks in a way that improves upon traditional text-centric approaches.

### 4.2 Structured Visual Tasks

From this point onward, we focus on one representative model from each family: CogVideoX1.5-5B [^48] for video diffusion models and Qwen3-4B-Instruct-2507 [^37] for language models. This pairing aligns model scale while contrasting pretraining modalities, allowing us to examine how different priors influence adaptability to visually grounded tasks.

#### 4.2.1 Visual Games

As part of our broader evaluation, we examine performance on a diverse set of five visual games that span both puzzle-solving and board play. These tasks provide an additional perspective on how the models handle structured visual inputs and varying interaction styles. The puzzle-based tasks, Hitori 5x5 and two versions of Sudoku (standard one and Mini), focus on solving constraint-based problems in structured grids, where success depends on extracting spatial patterns and enforcing global consistency from local information. The board games, Connect 4 and Chess Mate-in-1, shift attention to game scenarios where the goal is to identify the winning move in a given configuration. Together, these games cover a range of visual layouts and structured objectives, complementing the other tasks explored in this study.

Figure 4 presents model performance as a function of the number of training samples. CogVideoX1.5-5B demonstrates strong scaling behavior across most tasks, surpassing Qwen3-4B-Instruct-2507 in four of the five games. Its advantage is particularly clear in Sudoku and Hitori, which rely on interpreting complex grid layouts and visual compositions. This supports the view that VDMs capture compositional features in visual data more effectively than LLMs, which are primarily optimized for language. The only exception is chess, where Qwen3-4B-Instruct-2507 performs better, likely reflecting the abundance of chess material in textual corpora that LLMs can partially internalize during pretraining [^21].

Figure 4: Accuracy as a function of training set size for CogVideoX1.5-5B and Qwen3-4B-Instruct-2507 on five visual games.

#### 4.2.2 Route Planning

We evaluate route planning in $2$ D grid environments through two tasks: Maze and Shortest Path. In Maze, the model must navigate from the top-left to the bottom-right corner of a grid. In Shortest Path, the objective is to connect two arbitrary points with the shortest possible route. For Shortest Path, we report two complementary metrics to assess model performance:

##### Path Success Rate (PSR)

The percentage of evaluation examples where the predicted path forms a continuous connection between the source and target locations.

##### Relative Path Length (RPL)

For cases where a valid path is produced, we compute

$$
\text{RPL}=\frac{\text{Predicted Path Length}}{\text{Ground-Truth Shortest Path Length}}.
$$

This value may increase even as overall performance improves, since better models tend to predict good paths for more challenging cases, potentially constructing longer yet valid paths.

Figure 5: Accuracy as a function of training set size for CogVideoX1.5-5B and Qwen3-4B-Instruct-2507 on Base Maze, Maze Generalization, and Shortest Path.

For Maze, we evaluate in two settings: a matched-scale (Base Maze) scenario, where both training and evaluation are conducted on $21\times 21$ mazes to study performance as a function of training sample size; and a generalization scenario, where models are trained on smaller $13\times 13$ grids and tested on larger $21\times 21$ grids to assess cross-scale generalization (Maze Generalization).

Accuracy results are shown in Figure 5. For Shortest Path, additional metrics are reported in Table 6. The VDM consistently constructs valid paths with far fewer supervised examples, achieving up to a tenfold reduction in data requirements in low-sample regimes, which underscores its stronger inductive biases relative to the LLM. Moreover, it demonstrates the ability to generalize much quicker from limited training on smaller mazes to larger, more complex ones.

![Refer to caption](https://arxiv.org/html/2510.24448v2/figures/main/examples/vdm_maze_steps300_158.png)

Figure 6: Qualitative examples for Base Maze and Shortest Path tasks, after fine-tuning with n = 300 n=300 samples.

#### 4.2.3 Cellular Automata

We evaluate the capacity of both models to capture complex spatial patterns in cellular automata (CA). Our study spans one-dimensional Elementary Cellular Automata (ECA) [^45], a foundational class of binary-state systems, as well as two-dimensional Life-like Cellular Automata, including Conway’s Game of Life [^10], defined by various birth and survival (B/S) rules. Additionally, we consider Langton’s ant [^23], a deterministic agent-based system, where the task is to predict the complete grid state after $n$ steps of evolution.

For the 1D ECA experiments, we evaluate four representative rules from each of Wolfram’s four complexity classes. We measure task completion as achieving an accuracy above a fixed threshold $\delta=0.9$. Figure 7 reports the number of training examples required to reach this performance for each rule. Across these rules, both models show broadly similar behavior, with the VDM being better in some cases and worse in others, though overall it remains competitive with the LLM.

Figure 7: Number of training examples required to achieve $\delta\geq 0.9$ accuracy for selected 1D ECA rules (lower is better).

In two-dimensional settings, clearer differences emerge (see Figures 10, 10). For Life-like cellular automata, the VDM reaches threshold accuracy with far fewer examples, and a similar advantage is observed in Langton’s ant. In the case of Langton’s ant, the gap grows larger as the number of steps to be predicted increases, indicating that the VDM scales more effectively on tasks that demand long-range spatial planning.

![Refer to caption](https://arxiv.org/html/2510.24448v2/figures/main/examples/gol_gt_image_0_028.png)

Figure 8: Qualitative examples for Life-like cellular automata with rules B3/S23 and B2/S tasks, after fine-tuning with n = 30 n=30 samples.

Figure 9: Number of training examples required to achieve $\delta\geq 0.9$ accuracy for selected Life-like cellular automata rules (lower is better).

Figure 10: Accuracy as a function of training set size for CogVideoX1.5-5B and Qwen3-4B-Instruct-2507 on Langton’s Ant with a prediction horizon of 2,3,5 and 10.

## 5 Conclusions

Our study shows that VDMs pretrained on spatiotemporal data adapt effectively to structured visual tasks with fewer training examples than comparable LLMs. This demonstrates how modality-aligned pretraining and inductive biases support transfer: VDMs excel in tasks requiring spatial structure and temporal transformation, while LLMs retain strengths in symbol rich domains. Large-scale pretraining on spatiotemporal data with representations aligned to visual structure thus emerges as a promising venue for advancing visual intelligence.

The implications are twofold. For researchers, our benchmarks provide evidence that pretraining pipelines designed around modality-specific structure can unlock new capabilities, offering a path toward more data-efficient models. For practitioners, the inclusion of navigation-style tasks such as mazes and route planning suggests that pretrained VDMs may hold potential for downstream domains like planning, simulation, or robotics. However, validating these capabilities in more realistic, embodied environments remains an important direction for future work.

Overall, these results underline that modality-aligned pretraining plays a central role in advancing visual intelligence.

## Acknowledgements

This work was supported as part of the Swiss AI Initiative by a grant from the Swiss National Supercomputing Centre (CSCS) under project ID a03 on Alps. Pablo Acuaviva, Aram Davtyan and Sebastian Stapf were supported by SNSF Grant 10001278.

Some of the calculations were performed on UBELIX (https://www.id.unibe.ch/hpc), the HPC cluster at the University of Bern.

## References

## Appendix

## Limitations and future work

Our study focuses on grid-based benchmarks such as ARC-AGI, ConceptARC, and synthetic puzzles. This controlled setup provides a systematic framework for comparing models under equivalent conditions, offering a clear interface through which LLMs can demonstrate visual understanding. While these benchmarks do not capture the full diversity of real-world challenges, they remain valuable for isolating and analyzing the role of modality-aligned pretraining in visual intelligence.

The iterative nature of diffusion sampling also adds significant computational overhead. While some tasks can perform well with only a few sampling steps [^47], complex domains such as ARC-AGI often require longer sampling schedules to maintain structural consistency and coherence.

Fine-tuning VDMs remains computationally demanding even when using parameter-efficient methods such as LoRAs. Future work could explore modular and composable LoRA strategies [^18] [^34], potentially reducing retraining costs while enhancing cross-task generalization. Another promising direction is to extend these models toward in-context task adaptation. Just as LLMs have evolved from next-token prediction in their pretraining phase to in-context question answering, VDMs could benefit from fine-tuning approaches that enable flexible, context-dependent adaptation.

Beyond improving adaptability, understanding the mechanisms that give rise to visual intelligence in these models is an equally important research direction. Inspired by ongoing advances in mechanistic interpretability for LLMs, future work could aim to uncover how VDMs internally represent and manipulate concepts.

## Appendix A Experimental Details

We report here the detailed computational costs and hyperparameter settings used in our experiments. Tables 3 and 4 summarize the GPU hours required across different tasks, while Tables 5 and 6 provide the LoRA fine-tuning configurations for both VDMs and LLMs.

Table 3: GPU hours required for ConceptARC across VDMs and LLMs. Reported hours are wall-clock time and depend on hardware.

| VDM Model (GPU) | Hours | LLM Model (GPU) | Hours |
| --- | --- | --- | --- |
| Wan2.1-14B (H100) | 100 | Llama3.1-8B (H100) | 80 |
| LTX-13B (H100) | 95 | Qwen3-8B (2 $\times$ RTX4090) | 100 |
| CogVideoX1.5-5B (RTX4090) | 130 | Qwen3-4B-Instruct-2507 (RTX4090) | 135 |
| LTX-2B (H100) | 40 |  |  |

Table 4: GPU hours required for ARC-AGI and Structured Visual Tasks. Reported hours are wall-clock time and depend on hardware.

| ARCAGI Model (GPU) | Hours | Structured Task Model (GPU) | Hours |
| --- | --- | --- | --- |
| CogVideoX1.5-5B (RTX4090) | 450 | CogVideoX1.5-5B (RTX4090) | 1650 |
| Qwen3-4B-Instruct-2507 (RTX4090) | 475 | Qwen3-4B-Instruct-2507 (RTX4090) | 2000 |

To ensure reproducibility, we also include the fine-tuning hyperparameters for each model. The following two tables detail the LoRA, training, and optimizer configurations used for VDMs (Table 5) and LLMs (Table 6).

Table 5: LoRA finetuning configuration for VDM experiments.

<table><tbody><tr><td>Parameter</td><td>LTX-13B</td><td>LTX-2B</td><td>CogVideoX1.5-5B</td><td>Wan2.1-14B</td></tr><tr><td colspan="5">LoRA Configuration</td></tr><tr><td>Rank</td><td>64</td><td>64</td><td>64</td><td>64</td></tr><tr><td>Alpha</td><td>64</td><td>64</td><td>32</td><td>32</td></tr><tr><td>Target modules</td><td>to_q, to_k, to_v, to_out.0, ff.net.0.proj, ff.net.2</td><td>to_q, to_k, to_v, to_out.0, ff.net.0.proj, ff.net.2</td><td>QKVO</td><td>–</td></tr><tr><td colspan="5">Training Configuration</td></tr><tr><td>Seed</td><td>42</td><td>42</td><td>42</td><td>42</td></tr><tr><td>Batch size</td><td>2</td><td>4</td><td>2</td><td>1</td></tr><tr><td>Gradient accumulation steps</td><td>2</td><td>1</td><td>1</td><td>1</td></tr><tr><td colspan="5">Optimizer Configuration</td></tr><tr><td>Optimizer</td><td>AdamW</td><td>AdamW</td><td>AdamW</td><td>AdamW</td></tr><tr><td>Learning rate</td><td>2e-4</td><td>2e-4</td><td>1e-4</td><td>1e-4</td></tr><tr><td>Scheduler</td><td>Linear</td><td>Linear</td><td>Constant</td><td>Constant</td></tr><tr><td>Max grad norm</td><td>1.0</td><td>1.0</td><td>1.0</td><td>0.05</td></tr></tbody></table>

Table 6: LoRA finetuning configuration for LLMs used.

<table><tbody><tr><td>Parameter</td><td>Qwen3-4B-Instruct-2507</td><td>Qwen3-8B</td><td>LLaMA-3.1-8B</td></tr><tr><td colspan="4">LoRA Configuration</td></tr><tr><td>Rank</td><td>32</td><td>32</td><td>32</td></tr><tr><td>Alpha</td><td>32</td><td>32</td><td>64</td></tr><tr><td>Dropout</td><td>0</td><td>0</td><td>0.05</td></tr><tr><td>Target modules</td><td>q_proj, k_proj, v_proj, o_proj, gate_proj, up_proj, down_proj</td><td>q_proj, k_proj, v_proj, o_proj, gate_proj, up_proj, down_proj</td><td>q_proj, k_proj, v_proj, o_proj, gate_proj, up_proj, down_proj, lm_head</td></tr><tr><td colspan="4">Model Setup</td></tr><tr><td>Max sequence length</td><td>8192</td><td>8192</td><td>4096</td></tr><tr><td>Random seed</td><td>3407</td><td>3407</td><td>3407</td></tr><tr><td colspan="4">Training Configuration</td></tr><tr><td>Batch size per device</td><td>2</td><td>1</td><td>1</td></tr><tr><td>Effective batch size</td><td>8</td><td>8</td><td>8</td></tr><tr><td>Gradient accumulation steps</td><td>4</td><td>8</td><td>8</td></tr><tr><td>Learning rate</td><td>2e-4</td><td>2e-4</td><td>2e-4</td></tr><tr><td>Scheduler</td><td>Linear</td><td>Linear</td><td>Linear</td></tr><tr><td>Warmup steps</td><td>5</td><td>5</td><td>5</td></tr><tr><td>Weight decay</td><td>0.01</td><td>0.01</td><td>0.01</td></tr><tr><td colspan="4">Generation Configuration</td></tr><tr><td>Max new tokens</td><td>4096</td><td>4096</td><td>4096</td></tr><tr><td>Temperature</td><td>0.7</td><td>0.7</td><td>0.7</td></tr><tr><td>Top- <math><semantics><mi>p</mi> <annotation>p</annotation></semantics></math></td><td>0.8</td><td>0.8</td><td>0.8</td></tr><tr><td>Top- <math><semantics><mi>k</mi> <annotation>k</annotation></semantics></math></td><td>20</td><td>20</td><td>20</td></tr></tbody></table>

Note. LoRA ranks differ slightly across model families (VDMs use rank 64, whereas LLMs use rank 32). We verified that performance is largely insensitive to this setting: Qwen3 models with rank 64 perform comparably to rank 32, and CogVideoX1.5-5B models with rank 32 match the reported rank 64 results. In both cases, we report the configuration that yielded stronger results in our initial trials. All reported results in the paper correspond to the configurations shown in the tables.

## Appendix B Task Details

For completeness, we provide additional explanations of the tasks considered in our evaluation. Each subsection introduces a task family and highlights the key rules and objectives, we further provide examples on how the task is encoded into image and text.

### B.1 Visual Games

#### B.1.1 Hitori 5x5

Objective: Eliminate cells so that each number appears at most once per row and column.

Rules:

1. A number must not be repeated in any row or column.
2. Shaded cells cannot be orthogonally adjacent.
3. All unshaded cells must form a single connected component.

We add an example of the task in Figure 11.

![[Uncaptioned image]](https://arxiv.org/html/2510.24448v2/figures/appendix/examples_tasks/hitori_5_easy_0.png)

\[Uncaptioned image\]

#### B.1.2 Sudoku

Objective: Fill the grid so that all constraints are satisfied.

Rules:

1. Each row must contain all required digits without repetition.
2. Each column must contain all required digits without repetition.
3. Each subgrid must contain all required digits without repetition.

We evaluate two variants: Mini Sudoku (4x4 with 2x2 subgrids, see Figure 12) and Sudoku (9x9 with 3x3 subgrids, see Figure 13).

![[Uncaptioned image]](https://arxiv.org/html/2510.24448v2/figures/appendix/examples_tasks/sudoku_small_0.png)

\[Uncaptioned image\]

![[Uncaptioned image]](https://arxiv.org/html/2510.24448v2/figures/appendix/examples_tasks/sudoku_standard_easy_0.png)

\[Uncaptioned image\]

#### B.1.3 Connect 4

Objective: Place tokens to align four in a row.

Rules:

1. Players alternate dropping tokens into one of the seven columns.
2. A token occupies the lowest available cell in the chosen column.
3. A player wins by forming a horizontal, vertical, or diagonal line of four tokens.

We restrict evaluation to single-move winning scenarios, see Figure 14.

![[Uncaptioned image]](https://arxiv.org/html/2510.24448v2/figures/appendix/examples_tasks/connect4_0.png)

\[Uncaptioned image\]

#### B.1.4 Chess Mate-in-1

Objective: Deliver checkmate in a single move. Rules:

1. All standard chess movement rules apply.
2. A move is correct only if it results in an immediate checkmate of the opposing king.

To ensure the task is well defined, we filter scenarios so that they always correspond to white moves. The original dataset is extracted from [^36], and an illustrative example is shown in Figure 15.

![[Uncaptioned image]](https://arxiv.org/html/2510.24448v2/figures/appendix/examples_tasks/chess_mate_in_1_w_0.png)

\[Uncaptioned image\]

### B.2 Route Planning

We evaluate route planning in two-dimensional grid environments. The objective across tasks is to construct valid paths that connect designated start and goal locations under different structural constraints. We consider two tasks: Maze and Shortest Path.

#### B.2.1 Maze

Objective: Navigate from the start cell to the goal cell through a grid containing blocked and open positions.

Rules:

1. The agent starts at the top-left cell and must reach the bottom-right cell.
2. Movement is allowed only through open cells.
3. Allowed moves are up, down, left, and right (no diagonal moves).
4. A valid solution is a continuous sequence of moves from start to goal.

![[Uncaptioned image]](https://arxiv.org/html/2510.24448v2/figures/appendix/examples_tasks/maze_small_0.png)

\[Uncaptioned image\]

![[Uncaptioned image]](https://arxiv.org/html/2510.24448v2/figures/appendix/examples_tasks/maze_0.png)

\[Uncaptioned image\]

We evaluate two scenarios:

- Base Maze: Training and evaluation on $21\times 21$ grids.
- Maze Generalization: Training on smaller $13\times 13$ grids and testing on larger $21\times 21$ grids.

We illustrate a sample $21\times 21$ maze in Figure 17, which serves as training and evaluation data in the Base Maze setting and as evaluation data in the Maze Generalization setting. Figure 16 shows a sample $13\times 13$ maze, which is used as training data in the Maze Generalization setting.

#### B.2.2 Shortest Path

Objective: Connect two arbitrary points with the shortest possible route.

Rules:

1. Start and goal cells are specified anywhere on the grid.
2. Movement is allowed only through open cells.
3. Allowed moves are up, down, left, and right (no diagonal moves).
4. A valid solution is a continuous path from start to goal with minimal length among all possible paths.

We provide an example in Figure 18.

![[Uncaptioned image]](https://arxiv.org/html/2510.24448v2/figures/appendix/examples_tasks/navigation2d_any_to_any_0.png)

\[Uncaptioned image\]

### B.3 Cellular Automata

#### B.3.1 Elementary Cellular Automata (ECA)

Elementary Cellular Automata (ECA) are one-dimensional binary-state automata defined on a line of cells. Each cell $c_{i}^{t}\in\{0,1\}$ at time $t$ updates based on itself and its two neighbors:

$$
c_{i}^{t+1}=f(c_{i-1}^{t},c_{i}^{t},c_{i+1}^{t}),
$$

where $f$ is specified by a rule number between 0 and 255.

For example, Rule 110 is encoded by the binary string 01101110, which maps the eight possible neighborhoods $(c_{i-1}^{t},c_{i}^{t},c_{i+1}^{t})$ to the next state:

$$
\begin{array}[]{c|cccccccc}\text{Neighborhood}&111&110&101&100&011&010&001&000\\
\hline\cr\text{Next state}&0&1&1&0&1&1&1&0\end{array}
$$

We evaluate four representative rules from each of Wolfram’s classes [^45], summarized in Table 7.

Table 7: Representative Elementary Cellular Automata rules by Wolfram class.

| Class | Rules |
| --- | --- |
| Class 1 | 8, 32, 128, 160 |
| Class 2 | 4, 108, 170, 250 |
| Class 3 | 30, 45, 90, 150 |
| Class 4 | 110, 54, 62, 106 |

Rule 110 is well known for its complex localized structures and universality [^9]. We show an example in Figure 19.

![[Uncaptioned image]](https://arxiv.org/html/2510.24448v2/figures/appendix/examples_tasks/cellular_automata_1d_rule110_w16_s7_0.png)

\[Uncaptioned image\]

#### B.3.2 Life-like Cellular Automata

Life-like CA generalize Conway’s Game of Life [^10], using binary cells on a two-dimensional grid. Each cell updates according to the number of live neighbors in the Moore neighborhood (eight adjacent cells). In standard Game of Life ($B3/S23$):

$$
c_{i,j}^{t+1}=\begin{cases}1&\text{if cell is dead and has exactly 3 live neighbors (birth)},\\
1&\text{if cell is alive and has 2 or 3 live neighbors (survival)},\\
0&\text{otherwise (death).}\end{cases}
$$

We consider several well-known Life-like variants. These rules, summarized in Table 8, capture diverse behaviors ranging from explosive growth to symmetry under inversion. We shown an example in Figure 20 of the basic Game of Life.

![[Uncaptioned image]](https://arxiv.org/html/2510.24448v2/figures/appendix/examples_tasks/gol_step1_0.png)

\[Uncaptioned image\]

Table 8: Life-like cellular automata variants evaluated.

| Name | Rule (B/S) | Description |
| --- | --- | --- |
| Day & Night | B3678/S34678 | Symmetric under inversion; complex dynamics |
| Maze | B3/S12345 | Generates labyrinth-like, maze-like growth |
| Seeds | B2/S $\varnothing$ | All live cells die each step; explosive expansion |
| Life | B3/S2 | Sparse survival; promotes small, mobile clusters |

#### B.3.3 Langton’s Ant

Langton’s ant [^23] is an agent-based CA where a single agent moves on a binary grid. At each step:

$$
(x,y),d,g(x,y)\rightarrow(x^{\prime},y^{\prime}),d^{\prime},g^{\prime}(x,y),
$$

where $(x,y)$ is the current cell, $d$ is direction, and $g(x,y)\in\{0,1\}$ is the cell state.

1. If $g(x,y)=0$, turn right; if $g(x,y)=1$, turn left.
2. Flip the cell color: $g^{\prime}(x,y)=1-g(x,y)$.
3. Move forward one step.

After many steps, chaotic behavior gives way to a repeating “highway” structure. To make the task predictable, we always start with the ant facing on the same initial direction and being on top of a 0 cell. For an example see Figure 21

![[Uncaptioned image]](https://arxiv.org/html/2510.24448v2/figures/appendix/examples_tasks/langton_ant_step2_0.png)

\[Uncaptioned image\]

## Appendix C Additional Qualitative Results

### C.1 ARC-AGI

To further illustrate the complementary strengths of VDMs and LLMs, we include qualitative examples of ARC-AGI tasks. In some cases, the LLM enables it to find the correct solution, while the VDM fails. Examples of this behavior is shown in Figure 24.

In contrast, there are tasks where both models succeed, suggesting that the underlying structure can be captured through either symbolic reasoning or visual pattern learning. One such case is given in Figure 25.

Finally, we highlight situations where only the VDM solves the task correctly (Figures 22 and 23). These examples emphasize how visual inductive biases allow the VDM to generalize in settings where symbolic reasoning alone appears insufficient.

![Refer to caption](https://arxiv.org/html/2510.24448v2/figures/appendix/arc-agi/vdm-but-not-llm/60a26a3e/train_000_gt_in.png)

Figure 22: Qualitative results on ARC-AGI for problems 60a26a3e, 62b74c02 8a371977.

![Refer to caption](https://arxiv.org/html/2510.24448v2/figures/appendix/arc-agi/vdm-but-not-llm/2072aba6/train_000_gt_in.png)

Figure 23: Qualitative results on ARC-AGI for problems 2072aba6, 4aab4007 5207a7b5.

![Refer to caption](https://arxiv.org/html/2510.24448v2/figures/appendix/arc-agi/llm-but-not-vdm/ca8de6ea/train_000_gt_in.png)

Figure 24: Qualitative results on ARC-AGI for problems ca8de6ea, d37a1ef5 e95e3d8e.

![Refer to caption](https://arxiv.org/html/2510.24448v2/figures/appendix/arc-agi/both/575b1a71/train_000_gt_in.png)

Figure 25: Qualitative results on ARC-AGI for problems 575b1a71, 68b67ca3 8ee62060.

### C.2 Structured Visual Tasks

We include additional qualitative examples from structured visual tasks such as mazes, route planning, and cellular automata, complementing the quantitative results in the main text.

![Refer to caption](https://arxiv.org/html/2510.24448v2/figures/appendix/additional-qualitative-examples/shortest_path/image_0/val_000.png)

Figure 26: Representative examples for the Shortest Path task, showing ground truth inputs (left) and model predictions (center and right) after finetuning with n = 300 n=300 samples.

![Refer to caption](https://arxiv.org/html/2510.24448v2/figures/appendix/additional-qualitative-examples/maze/image_0/val_000.png)

Figure 27: Additional qualitative examples for the Maze task, showing inputs, ground truth outputs, and model predictions after finetuning with n = 300 n=300 samples.

![Refer to caption](https://arxiv.org/html/2510.24448v2/figures/appendix/additional-qualitative-examples/sudoku/image_0/val_000.png)

Figure 28: Additional qualitative examples for the Sudoku task, showing inputs, ground truth outputs, and model predictions after finetuning with n = 1000 n=1000 samples.

![Refer to caption](https://arxiv.org/html/2510.24448v2/figures/appendix/additional-qualitative-examples/hitori_5/image_0/val_000.png)

Figure 29: Additional qualitative examples for the Hitori task, showing inputs, ground truth outputs, and model predictions after finetuning with n = 100 n=100 samples.

![Refer to caption](https://arxiv.org/html/2510.24448v2/figures/appendix/additional-qualitative-examples/langton_ant_step10/image_0/val_000.png)

Figure 30: Additional qualitative examples for the Langton Ant (horizon 10) task, showing inputs, ground truth outputs, and model predictions after finetuning with n = 1000 n=1000 samples.

## Appendix D Additional Results

## Appendix E ARC Family

Here, we include the comparison table for ConceptARC, by including finetuned LLMs (Qwen3-4B-Instruct, Qwen3-8B, LLama3.1-8B-Instruct) and GPT-4 \[IC\] <sup>2</sup> [^30], as well as VDMs (CogVideoX1.5-5B, Wan2.1-14B, LTX-2B/13B). These additional results provide broader context and help reinforce the trends observed in the main text. See Table 9.

The relatively lower performance of LTX compared to other VDMs may stem from its aggressive VAE compression, which can discard structural information important for ConceptARC. This reflects a design tradeoff of the LTX models, aimed at enabling much faster video generation [^14].

Table 9: Concept-wise overall accuracy across models. Best values are highlighted for VDMs or LLMs.

| Concept | LTX-13B | LTX-2B | Wan2.1-14B | CogVideoX1.5-5B | Qwen3-4B Instruct-2507 | Qwen3-8B | Llama3.1-8B | GPT-4 \[IC\] |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| AboveBelow | 0.30 | 0.17 | 0.37 | 0.40 | 0.40 | 0.40 | 0.17 | 0.23 |
| TopBottom2D | 0.23 | 0.17 | 0.63 | 0.37 | 0.50 | 0.50 | 0.37 | 0.23 |
| TopBottom3D | 0.27 | 0.17 | 0.47 | 0.33 | 0.13 | 0.20 | 0.17 | 0.20 |
| HorizontalVertical | 0.13 | 0.20 | 0.53 | 0.47 | 0.43 | 0.47 | 0.33 | 0.27 |
| Center | 0.33 | 0.30 | 0.57 | 0.37 | 0.20 | 0.20 | 0.13 | 0.33 |
| FilledNotFilled | 0.30 | 0.27 | 0.50 | 0.37 | 0.27 | 0.23 | 0.20 | 0.17 |
| CompleteShape | 0.20 | 0.10 | 0.40 | 0.37 | 0.23 | 0.30 | 0.13 | 0.23 |
| InsideOutside | 0.27 | 0.27 | 0.37 | 0.33 | 0.13 | 0.20 | 0.13 | 0.10 |
| ExtractObjects | 0.07 | 0.07 | 0.23 | 0.07 | 0.10 | 0.10 | 0.03 | 0.03 |
| Count | 0.40 | 0.43 | 0.83 | 0.57 | 0.13 | 0.13 | 0.17 | 0.13 |
| SameDifferent | 0.23 | 0.23 | 0.33 | 0.37 | 0.27 | 0.23 | 0.27 | 0.17 |
| Order | 0.03 | 0.03 | 0.00 | 0.07 | 0.27 | 0.27 | 0.10 | 0.27 |
| MoveToBoundary | 0.17 | 0.00 | 0.13 | 0.17 | 0.23 | 0.10 | 0.17 | 0.20 |
| ExtendToBoundary | 0.20 | 0.23 | 0.50 | 0.40 | 0.13 | 0.17 | 0.10 | 0.07 |
| Copy | 0.20 | 0.03 | 0.17 | 0.13 | 0.17 | 0.10 | 0.10 | 0.23 |
| CleanUp | 0.43 | 0.40 | 0.60 | 0.53 | 0.27 | 0.30 | 0.27 | 0.20 |
| Average Accuracy | 0.24 | 0.19 | 0.41 | 0.33 | 0.24 | 0.24 | 0.18 | 0.19 |

### E.1 Pitfalls of Vision Language Models

Vision–Language Models (VLMs) promise to bridge the gap between visual perception and language by training on vast datasets of paired images and text. In principle, this multimodal pretraining should enable these models to solve visually grounded tasks more effectively than language-only models. To test whether this promise holds in practice, we evaluate a representative VLM, Gemma-4B [^11], on a structured visual task: Sudoku.

We fine-tune the same model with $n=1000$ samples under three configurations: text-only, image-only, and combined image–text; keeping all other settings fixed. The results in Table 10 reveal a striking limitation: adding image input offers no measurable improvement, and the image-only variant performs worse than a trivial baseline. This suggests that the model is unable to extract meaningful information from visual inputs, even when explicitly trained to do so.

Table 10: Relative Accuracy and Accuracy on Sudoku.

| Model | Relative Accuracy | Accuracy |
| --- | --- | --- |
| Text-only | 0.79 | 0.06 |
| Combined image–text | 0.78 | 0.06 |
| Image-only | 0.12 | 0.00 |

To investigate why, we train the image-only model on a simplified task: reconstructing the textual grid representation of its own image input rather than predicting a Sudoku solution. With small training sets ($n=3,5,10$), the model fails to interpret the images and instead memorizes training samples, reproducing them verbatim regardless of input (Table 11). The model learns little about the underlying structure of the visual input.

Table 11: Distribution of outputs on the test set exactly matching training samples for different training set sizes.

<table><tbody><tr><td>Training Set Size</td><td>Sample</td><td>Proportion</td><td>Total Proportion</td></tr><tr><td rowspan="3">3</td><td>Sample 1</td><td>0.385</td><td rowspan="3">1.00</td></tr><tr><td>Sample 2</td><td>0.010</td></tr><tr><td>Sample 3</td><td>0.605</td></tr><tr><td rowspan="4">5</td><td>Sample 1</td><td>0.490</td><td rowspan="4">0.99</td></tr><tr><td>Sample 2</td><td>0.030</td></tr><tr><td>Sample 3</td><td>0.335</td></tr><tr><td>Sample 4</td><td>0.135</td></tr><tr><td rowspan="8">10</td><td>Sample 1</td><td>0.100</td><td rowspan="8">0.96</td></tr><tr><td>Sample 2</td><td>0.010</td></tr><tr><td>Sample 3</td><td>0.030</td></tr><tr><td>Sample 4</td><td>0.005</td></tr><tr><td>Sample 5</td><td>0.015</td></tr><tr><td>Sample 6</td><td>0.170</td></tr><tr><td>Sample 7</td><td>0.615</td></tr><tr><td>Sample 8</td><td>0.010</td></tr></tbody></table>

This experiment exposes a deeper issue: despite their multimodal pretraining, current VLMs struggle to extract structured information from images [^19] [^40]. They appear to rely primarily on semantics and basic pattern recognition rather than true visual understanding. Furthermore, VLMs inherit many of the limitations of LLMs, such as reliance on text-based outputs, without gaining meaningful visual understanding ability.

Because VLMs provide no measurable advantage over language-only models for these structured visual tasks, we focus on LLMs as the primary baseline. LLMs already demonstrate strong capabilities in structured prediction and symbolic manipulation, making them a fair and informative comparison point for VDMs. This framing keeps the evaluation focused on model families that offer complementary strengths.

## Appendix F Results - Full Tables

We provide the complete set of experimental results, which constitute the underlying data for the figures reported in the main paper.

Table 12: Comparison of CogVideoX1.5-5B and Qwen3-4B-Instruct-2507 accuracy on structured games. Missing values are shown as -.

<table><tbody><tr><td>n</td><td colspan="5">CogVideoX1.5-5B</td><td colspan="5">Qwen3-4B-Instruct-2507</td></tr><tr><td></td><td>Chess-Mate-in-1</td><td>Connect 4</td><td>Hitori 5x5</td><td>Sudoku Mini</td><td>Sudoku</td><td>Chess-Mate-in-1</td><td>Connect 4</td><td>Hitori 5x5</td><td>Sudoku Mini</td><td>Sudoku</td></tr><tr><td>3</td><td>0.00</td><td>0.44</td><td>0.01</td><td>0.22</td><td>0.00</td><td>0.00</td><td>0.03</td><td>0.00</td><td>0.18</td><td>–</td></tr><tr><td>5</td><td>0.00</td><td>0.62</td><td>0.02</td><td>0.36</td><td>0.00</td><td>0.02</td><td>0.05</td><td>0.00</td><td>0.22</td><td>–</td></tr><tr><td>10</td><td>0.00</td><td>0.74</td><td>0.62</td><td>0.65</td><td>0.00</td><td>0.04</td><td>0.08</td><td>0.02</td><td>0.48</td><td>–</td></tr><tr><td>30</td><td>0.02</td><td>0.78</td><td>0.72</td><td>0.78</td><td>0.20</td><td>0.13</td><td>0.38</td><td>0.02</td><td>0.64</td><td>0.00</td></tr><tr><td>50</td><td>0.04</td><td>0.80</td><td>0.84</td><td>0.90</td><td>0.34</td><td>0.15</td><td>0.38</td><td>0.10</td><td>0.68</td><td>0.00</td></tr><tr><td>100</td><td>0.08</td><td>0.85</td><td>0.92</td><td>0.91</td><td>0.60</td><td>0.24</td><td>0.69</td><td>0.28</td><td>0.78</td><td>0.01</td></tr><tr><td>300</td><td>0.14</td><td>0.84</td><td>0.94</td><td>0.90</td><td>0.55</td><td>0.38</td><td>0.71</td><td>0.57</td><td>0.80</td><td>0.01</td></tr><tr><td>500</td><td>0.20</td><td>0.89</td><td>0.94</td><td>0.94</td><td>0.60</td><td>0.44</td><td>0.69</td><td>0.64</td><td>0.86</td><td>0.06</td></tr><tr><td>1000</td><td>0.22</td><td>0.90</td><td>0.96</td><td>0.91</td><td>0.79</td><td>0.56</td><td>0.76</td><td>0.86</td><td>0.90</td><td>0.14</td></tr><tr><td>3000</td><td>–</td><td>0.92</td><td>0.98</td><td>0.95</td><td>0.86</td><td>–</td><td>0.78</td><td>0.94</td><td>0.92</td><td>0.32</td></tr><tr><td>5000</td><td>–</td><td>0.90</td><td>0.99</td><td>0.96</td><td>0.86</td><td>–</td><td>0.82</td><td>0.96</td><td>0.96</td><td>0.55</td></tr></tbody></table>

Table 13: Comparison of CogVideoX1.5-5B and Qwen3-4B-Instruct-2507 accuracy on Life-Like Cellular Automata variants. Missing values are shown as -.

<table><tbody><tr><td>n</td><td colspan="5">CogVideoX1.5-5B</td><td colspan="5">Qwen3-4B-Instruct-2507</td></tr><tr><td></td><td>Life_B3S2</td><td>DayAndNight</td><td>Maze</td><td>Seeds</td><td>Game of Life</td><td>Life_B3S2</td><td>DayAndNight</td><td>Maze</td><td>Seeds</td><td>Game Of Life</td></tr><tr><td>10</td><td>0.00</td><td>0.00</td><td>0.00</td><td>0.00</td><td>0.00</td><td>–</td><td>–</td><td>–</td><td>–</td><td>–</td></tr><tr><td>30</td><td>1.00</td><td>0.81</td><td>0.87</td><td>1.00</td><td>0.96</td><td>–</td><td>0.63</td><td>0.81</td><td>0.75</td><td>0.63</td></tr><tr><td>50</td><td>1.00</td><td>0.95</td><td>0.91</td><td>1.00</td><td>0.97</td><td>–</td><td>0.64</td><td>0.80</td><td>0.78</td><td>0.64</td></tr><tr><td>100</td><td>1.00</td><td>1.00</td><td>0.96</td><td>1.00</td><td>1.00</td><td>0.61</td><td>0.70</td><td>0.87</td><td>0.63</td><td>0.73</td></tr><tr><td>300</td><td>–</td><td>–</td><td>–</td><td>–</td><td>–</td><td>1.00</td><td>1.00</td><td>1.00</td><td>1.00</td><td>1.00</td></tr><tr><td>500</td><td>–</td><td>–</td><td>–</td><td>–</td><td>–</td><td>–</td><td>1.00</td><td>1.00</td><td>1.00</td><td>1.00</td></tr></tbody></table>

Table 14: Comparison of CogVideoX1.5-5B and Qwen3-4B-Instruct-2507 accuracy on Langton’s Ant with respect to number of steps into the future. Missing values are shown as -.

<table><tbody><tr><td>n</td><td colspan="4">CogVideoX1.5-5B</td><td colspan="4">Qwen3-4B-Instruct-2507</td></tr><tr><td></td><td>Step 2</td><td>Step 3</td><td>Step 5</td><td>Step 10</td><td>Step 2</td><td>Step 3</td><td>Step 5</td><td>Step 10</td></tr><tr><td>3</td><td>0.18</td><td>0.03</td><td>0.03</td><td>–</td><td>0.32</td><td>0.03</td><td>–</td><td>–</td></tr><tr><td>5</td><td>0.23</td><td>0.07</td><td>0.04</td><td>0.00</td><td>0.21</td><td>0.04</td><td>–</td><td>–</td></tr><tr><td>10</td><td>0.67</td><td>0.29</td><td>0.06</td><td>0.01</td><td>0.51</td><td>0.19</td><td>–</td><td>–</td></tr><tr><td>30</td><td>1.00</td><td>0.76</td><td>0.25</td><td>0.01</td><td>0.79</td><td>0.46</td><td>0.06</td><td>0.00</td></tr><tr><td>50</td><td>1.00</td><td>0.99</td><td>0.41</td><td>0.01</td><td>0.950</td><td>0.58</td><td>0.14</td><td>0.010</td></tr><tr><td>100</td><td>1.00</td><td>1.000</td><td>0.88</td><td>0.08</td><td>0.99</td><td>0.910</td><td>0.39</td><td>0.01</td></tr><tr><td>300</td><td>–</td><td>–</td><td>1.00</td><td>0.42</td><td>1.00</td><td>1.00</td><td>0.98</td><td>0.12</td></tr><tr><td>500</td><td>–</td><td>–</td><td>1.00</td><td>0.83</td><td>1.00</td><td>1.00</td><td>1.00</td><td>0.21</td></tr><tr><td>1000</td><td>–</td><td>–</td><td>1.00</td><td>0.98</td><td>1.00</td><td>1.00</td><td>1.00</td><td>0.47</td></tr><tr><td>3000</td><td>–</td><td>–</td><td>–</td><td>0.99</td><td>–</td><td>–</td><td>–</td><td>0.71</td></tr><tr><td>5000</td><td>–</td><td>–</td><td>–</td><td>–</td><td>–</td><td>–</td><td>–</td><td>0.93</td></tr></tbody></table>

Table 15: Comparison of CogVideoX1.5 and Qwen3-4B-Instruct-2507 accuracy on Maze and Shortest Path tasks. Missing values are shown as -.

<table><tbody><tr><td>n</td><td colspan="3">CogVideoX1.5</td><td colspan="3">Qwen3-4B-Instruct-2507</td></tr><tr><td></td><td>Base Maze</td><td>Maze Generalization</td><td>Shortest Path</td><td>Base Maze</td><td>Maze Generalization</td><td>Shortest Path</td></tr><tr><td>3</td><td>0.015</td><td>–</td><td>0.010</td><td>–</td><td>–</td><td>–</td></tr><tr><td>5</td><td>0.010</td><td>–</td><td>0.025</td><td>–</td><td>–</td><td>–</td></tr><tr><td>10</td><td>0.070</td><td>0.050</td><td>0.040</td><td>–</td><td>–</td><td>–</td></tr><tr><td>30</td><td>0.550</td><td>0.175</td><td>0.330</td><td>0.000</td><td>–</td><td>0.010</td></tr><tr><td>50</td><td>0.760</td><td>0.355</td><td>0.420</td><td>0.005</td><td>0.000</td><td>0.010</td></tr><tr><td>100</td><td>0.940</td><td>0.590</td><td>0.700</td><td>0.005</td><td>0.000</td><td>0.050</td></tr><tr><td>300</td><td>1.000</td><td>0.755</td><td>0.860</td><td>0.115</td><td>0.020</td><td>0.155</td></tr><tr><td>500</td><td>1.000</td><td>0.885</td><td>0.910</td><td>0.195</td><td>0.060</td><td>0.320</td></tr><tr><td>1000</td><td>–</td><td>0.865</td><td>0.945</td><td>0.500</td><td>0.335</td><td>0.500</td></tr><tr><td>3000</td><td>–</td><td>0.815</td><td>0.960</td><td>0.710</td><td>0.375</td><td>0.640</td></tr><tr><td>5000</td><td>–</td><td>0.940</td><td>0.975</td><td>0.925</td><td>0.525</td><td>0.770</td></tr></tbody></table>

Table 16: Comparison of CogVideoX1.5-5B and Qwen3-4B-Instruct-2507 accuracy on cellular automata rules grouped by Wolfram classes. Missing values are shown as -.

<table><tbody><tr><td>n</td><td colspan="4">CogVideoX1.5-5B</td><td colspan="4">Qwen3-4B-Instruct-2507</td></tr><tr><td colspan="9">Class 1</td></tr><tr><td></td><td>R8</td><td>R32</td><td>R128</td><td>R160</td><td>R8</td><td>R32</td><td>R128</td><td>R160</td></tr><tr><td>3</td><td>0.75</td><td>0.49</td><td>0.29</td><td>0.13</td><td>0.06</td><td>0.02</td><td>0.04</td><td>0.04</td></tr><tr><td>5</td><td>0.71</td><td>0.51</td><td>0.28</td><td>0.20</td><td>0.10</td><td>0.06</td><td>0.06</td><td>0.04</td></tr><tr><td>10</td><td>0.74</td><td>0.67</td><td>0.32</td><td>0.48</td><td>0.19</td><td>0.21</td><td>0.08</td><td>0.12</td></tr><tr><td>30</td><td>0.77</td><td>0.82</td><td>0.85</td><td>0.87</td><td>0.72</td><td>0.67</td><td>0.65</td><td>0.81</td></tr><tr><td>50</td><td>0.72</td><td>0.98</td><td>0.99</td><td>0.93</td><td>0.81</td><td>0.96</td><td>0.77</td><td>0.84</td></tr><tr><td>100</td><td>1.00</td><td>–</td><td>–</td><td>–</td><td>0.97</td><td>0.93</td><td>0.90</td><td>0.99</td></tr><tr><td>300</td><td>–</td><td>–</td><td>–</td><td>–</td><td>0.98</td><td>–</td><td>–</td><td>–</td></tr><tr><td colspan="9">Class 2</td></tr><tr><td></td><td>R4</td><td>R108</td><td>R170</td><td>R250</td><td>R4</td><td>R108</td><td>R170</td><td>R250</td></tr><tr><td>3</td><td>0.71</td><td>0.155</td><td>0.07</td><td>0.17</td><td>–</td><td>–</td><td>–</td><td>–</td></tr><tr><td>5</td><td>0.76</td><td>0.310</td><td>0.27</td><td>0.19</td><td>–</td><td>–</td><td>–</td><td>–</td></tr><tr><td>10</td><td>0.74</td><td>0.415</td><td>0.87</td><td>0.27</td><td>–</td><td>–</td><td>0.85</td><td>–</td></tr><tr><td>30</td><td>0.85</td><td>0.640</td><td>1.00</td><td>0.59</td><td>0.72</td><td>0.47</td><td>0.99</td><td>0.52</td></tr><tr><td>50</td><td>0.93</td><td>0.785</td><td>1.00</td><td>0.90</td><td>0.82</td><td>0.82</td><td>0.98</td><td>0.86</td></tr><tr><td>100</td><td>–</td><td>–</td><td>–</td><td>–</td><td>0.90</td><td>0.90</td><td>1.00</td><td>1.00</td></tr><tr><td>300</td><td>–</td><td>–</td><td>–</td><td>–</td><td>1.00</td><td>1.00</td><td>1.00</td><td>0.99</td></tr><tr><td colspan="9">Class 3</td></tr><tr><td></td><td>R30</td><td>R45</td><td>R90</td><td>R150</td><td>R30</td><td>R45</td><td>R90</td><td>R150</td></tr><tr><td>3</td><td>0.00</td><td>0.00</td><td>0.00</td><td>0.00</td><td>–</td><td>–</td><td>–</td><td>–</td></tr><tr><td>5</td><td>0.00</td><td>0.00</td><td>0.00</td><td>0.00</td><td>–</td><td>–</td><td>–</td><td>–</td></tr><tr><td>10</td><td>0.00</td><td>0.00</td><td>0.00</td><td>0.00</td><td>–</td><td>–</td><td>–</td><td>–</td></tr><tr><td>30</td><td>0.07</td><td>0.07</td><td>0.10</td><td>0.00</td><td>0.18</td><td>0.03</td><td>0.03</td><td>0.01</td></tr><tr><td>50</td><td>0.55</td><td>0.53</td><td>0.25</td><td>0.01</td><td>0.83</td><td>0.71</td><td>0.08</td><td>0.97</td></tr><tr><td>100</td><td>0.97</td><td>1.00</td><td>0.99</td><td>0.65</td><td>0.97</td><td>0.98</td><td>0.27</td><td>0.99</td></tr><tr><td>300</td><td>–</td><td>–</td><td>–</td><td>0.86</td><td>1.00</td><td>1.00</td><td>0.90</td><td>1.00</td></tr><tr><td>500</td><td>–</td><td>–</td><td>–</td><td>0.98</td><td>–</td><td>–</td><td>–</td><td>–</td></tr><tr><td colspan="9">Class 4</td></tr><tr><td></td><td>R110</td><td>R54</td><td>R62</td><td>R106</td><td>R110</td><td>R54</td><td>R62</td><td>R106</td></tr><tr><td>3</td><td>0.00</td><td>0.00</td><td>0.02</td><td>0.00</td><td>–</td><td>–</td><td>–</td><td>–</td></tr><tr><td>5</td><td>0.00</td><td>0.00</td><td>0.02</td><td>0.00</td><td>–</td><td>–</td><td>–</td><td>–</td></tr><tr><td>10</td><td>0.00</td><td>0.01</td><td>0.03</td><td>0.00</td><td>–</td><td>–</td><td>–</td><td>–</td></tr><tr><td>30</td><td>0.42</td><td>0.54</td><td>0.31</td><td>0.09</td><td>0.87</td><td>0.31</td><td>0.13</td><td>0.18</td></tr><tr><td>50</td><td>0.90</td><td>0.99</td><td>0.53</td><td>0.57</td><td>0.95</td><td>0.78</td><td>0.79</td><td>0.63</td></tr><tr><td>100</td><td>1.00</td><td>1.00</td><td>0.97</td><td>0.97</td><td>1.00</td><td>0.94</td><td>0.93</td><td>1.00</td></tr><tr><td>300</td><td>1.00</td><td>1.00</td><td>–</td><td>1.00</td><td>1.00</td><td>1.00</td><td>1.00</td><td>1.00</td></tr></tbody></table>

## Appendix G Exploring Generalization of I2I-Tuned VDMs

While the main text emphasizes grid-structured visual prediction tasks, our framework extends naturally to a broad range of image-to-image problems. In this section, we briefly explore its applicability to classical computer vision tasks. Few-shot adaptation functions both as an efficient tuning strategy and as a probe of model competence: if the model succeeds with very few paired examples, it indicates that the underlying ability was already internalized during pretraining.

We fine-tune CogVideoX1.5-5B, across tasks using between one and thirty paired examples, maintaining the same architecture, optimization schedule, and hyperparameters as in the main experiments. No auxiliary losses or task-specific modifications are introduced, isolating the contribution of pretrained knowledge.

We explore this setup on several established datasets spanning diverse visual domains, including NYUv2 [^31], ADE20K [^50] [^51], ML-Hypersim [^38], COCO 2017 [^26], and DreamBooth [^39]. These benchmarks cover a wide range of classical computer vision problems, from structured scene understanding to generative image transformation.

Figure 31 illustrates that the model can capture geometric transformations under extreme few-shot conditions. We further show one-shot style transfer in Figure 32.

We also qualitative show this framework can be used to solve some classical computer vision tasks. In Figure 34 we show examples after training with only $n=30$ samples for Binary Segmentation for dogs and Pose estimation for humans.

![Refer to caption](https://arxiv.org/html/2510.24448v2/figures/appendix/cv_exploration/geometric_transforms/glasses/input.png)

((a)) Input

![Refer to caption](https://arxiv.org/html/2510.24448v2/figures/appendix/cv_exploration/style-transfer/input/0.png)

Figure 32: 1-shot style transfer results. The model adapts the input images to distinct artistic styles ( Starry Night, Pixel Art Cubism, and Ukiyo-e ) using only a single reference example.

![Refer to caption](https://arxiv.org/html/2510.24448v2/figures/appendix/cv_exploration/misc/inpainting/input.png)

Figure 33: Qualitative results for different tasks ( Inpainting, Colorization Jigsaw ) with different numbers of training examples.

![Refer to caption](https://arxiv.org/html/2510.24448v2/figures/appendix/cv_exploration/binary-seg/ff/0.jpg)

Figure 34: Predictions after finetuning with n = 30 n=30 samples for Binary Segmentation and Pose.

![Refer to caption](https://arxiv.org/html/2510.24448v2/figures/appendix/cv_exploration/depth/ff/0.jpg)

Figure 35: Predictions after finetuning with n = 30 n=30 samples for Depth.

![Refer to caption](https://arxiv.org/html/2510.24448v2/figures/appendix/cv_exploration/1-shot-img-mask/img2seg_chamber_0_first.png)

Figure 36: Examples from the Image → \\rightarrow Segmentation in 1-shot setting for Chamber.

![Refer to caption](https://arxiv.org/html/2510.24448v2/figures/appendix/cv_exploration/1-shot-img-mask/seg2img_chamber_0_first.png)

Figure 37: Examples from the Segmentation → \\rightarrow Image task in the 1-shot setting. Each environment corresponds to a separate 1-shot training: for Chamber we train on one chamber and test on others, while for Coast and Badlands the same protocol applies within their category.

[^1]: Yutong Bai, Xinyang Geng, Karttikeya Mangalam, Amir Bar, Alan L Yuille, Trevor Darrell, Jitendra Malik, and Alexei A Efros. Sequential modeling enables scalable learning for large vision models. In *Proceedings of the IEEE/CVF Conference on Computer Vision and Pattern Recognition*, pp. 22861–22872, 2024.

[^2]: Amir Bar, Yossi Gandelsman, Trevor Darrell, Amir Globerson, and Alexei A. Efros. Visual prompting via image inpainting. *CoRR*, abs/2209.00647, 2022. URL [https://doi.org/10.48550/arXiv.2209.00647](https://doi.org/10.48550/arXiv.2209.00647).

[^3]: Andreas Blattmann, Tim Dockhorn, Sumith Kulal, Daniel Mendelevitch, Maciej Kilian, Dominik Lorenz, Yam Levi, Zion English, Vikram Voleti, Adam Letts, Varun Jampani, and Robin Rombach. Stable video diffusion: Scaling latent video diffusion models to large datasets. *CoRR*, abs/2311.15127, 2023. URL [https://doi.org/10.48550/arXiv.2311.15127](https://doi.org/10.48550/arXiv.2311.15127).

[^4]: Tom Brown, Benjamin Mann, Nick Ryder, Melanie Subbiah, Jared D Kaplan, Prafulla Dhariwal, Arvind Neelakantan, Pranav Shyam, Girish Sastry, Amanda Askell, et al. Language models are few-shot learners. *Advances in neural information processing systems*, 33:1877–1901, 2020.

[^5]: François Chollet. On the measure of intelligence. *arXiv preprint arXiv:1911.01547*, 2019.

[^6]: Francois Chollet, Mike Knoop, Gregory Kamradt, and Bryan Landers. Arc prize 2024: Technical report. *arXiv preprint arXiv:2412.04604*, 2024.

[^7]: Aakanksha Chowdhery, Sharan Narang, Jacob Devlin, Maarten Bosma, Gaurav Mishra, Adam Roberts, Paul Barham, Hyung Won Chung, Charles Sutton, Sebastian Gehrmann, et al. Palm: Scaling language modeling with pathways. *Journal of Machine Learning Research*, 24(240):1–113, 2023.

[^8]: Julian Coda-Forno, Marcel Binz, Zeynep Akata, Matt Botvinick, Jane Wang, and Eric Schulz. Meta-in-context learning in large language models. *Advances in Neural Information Processing Systems*, 36:65189–65201, 2023.

[^9]: Matthew Cook. Universality in elementary cellular automata. *Complex Systems*, 15(1):1–40, 2004.

[^10]: Martin Gardner. Mathematical games: The fantastic combinations of john conway’s new solitaire game ”life”. *Scientific American*, 223(4):120–123, 1970.

[^11]: Gemma Team. Gemma 3: Technical report. *arXiv preprint arXiv:2503.19786*, 2025. URL [https://arxiv.org/abs/2503.19786](https://arxiv.org/abs/2503.19786).

[^12]: Zigang Geng, Binxin Yang, Tiankai Hang, Chen Li, Shuyang Gu, Ting Zhang, Jianmin Bao, Zheng Zhang, Houqiang Li, Han Hu, et al. Instructdiffusion: A generalist modeling interface for vision tasks. In *Proceedings of the IEEE/CVF Conference on computer vision and pattern recognition*, pp. 12709–12720, 2024.

[^13]: Google DeepMind. Veo 3. [https://deepmind.google/models/veo/](https://deepmind.google/models/veo/), September 2025. URL [https://deepmind.google/models/veo/](https://deepmind.google/models/veo/). Accessed: 2025-09-23.

[^14]: Yoav HaCohen, Nisan Chiprut, Benny Brazowski, Daniel Shalem, Dudu Moshe, Eitan Richardson, Eran Levin, Guy Shiran, Nir Zabari, Ori Gordon, Poriya Panet, Sapir Weissbuch, Victor Kulikov, Yaki Bitterman, Zeev Melumian, and Ofir Bibi. Ltx-video: Realtime video latent diffusion. *CoRR*, abs/2501.00103, January 2025. URL [https://doi.org/10.48550/arXiv.2501.00103](https://doi.org/10.48550/arXiv.2501.00103).

[^15]: Mariam Hassan, Sebastian Stapf, Ahmad Rahimi, Pedro M B Rezende, Yasaman Haghighi, David Brüggemann, Isinsu Katircioglu, Lin Zhang, Xiaoran Chen, Suman Saha, Marco Cannici, Elie Aljalbout, Botao Ye, Xi Wang, Aram Davtyan, Mathieu Salzmann, Davide Scaramuzza, Marc Pollefeys, Paolo Favaro, and Alexandre Alahi. Gem: A generalizable ego-vision multimodal world model for fine-grained ego-motion, object dynamics, and scene composition control. *CVPR*, 2025.

[^16]: Wenyi Hong, Ming Ding, Wendi Zheng, Xinghan Liu, and Jie Tang. Cogvideo: Large-scale pretraining for text-to-video generation via transformers. *CoRR*, abs/2205.15868, 2022. URL [https://doi.org/10.48550/arXiv.2205.15868](https://doi.org/10.48550/arXiv.2205.15868).

[^17]: Edward J Hu, Yelong Shen, Phillip Wallis, Zeyuan Allen-Zhu, Yuanzhi Li, Shean Wang, Lu Wang, Weizhu Chen, et al. Lora: Low-rank adaptation of large language models. *ICLR*, 1(2):3, 2022.

[^18]: Chengsong Huang, Qian Liu, Bill Yuchen Lin, Tianyu Pang, Chao Du, and Min Lin. Lorahub: Efficient cross-task generalization via dynamic lora composition. *arXiv preprint arXiv:2307.13269*, 2024. URL [https://arxiv.org/abs/2307.13269](https://arxiv.org/abs/2307.13269).

[^19]: Liqiang Jing, Hardy Chen, Ehsan Aghazadeh, Xin Eric Wang, and Xinya Du. A comprehensive analysis for visual object hallucination in large vision-language models. In *Knowledgeable Foundation Models at ACL 2025*, 2025. URL [https://openreview.net/forum?id=Ya4mqbhDP4](https://openreview.net/forum?id=Ya4mqbhDP4).

[^20]: Anssi Kanervisto, Dave Bignell, Linda Yilin Wen, Martin Grayson, Raluca Georgescu, Sergio Valcarcel Macua, Shan Zheng Tan, Tabish Rashid, Tim Pearce, Yuhan Cao, et al. World and human action models towards gameplay ideation. *Nature*, 638(8051):656–663, 2025.

[^21]: Mu-Tien Kuo, Chih-Chung Hsueh, and Richard Tzong-Han Tsai. Large language models on the chessboard: A study on chatgpt’s formal language comprehension and complex reasoning skills. 2023. Preprint, arXiv.

[^22]: Black Forest Labs. Flux.1-dev. [https://huggingface.co/black-forest-labs/FLUX.1-dev](https://huggingface.co/black-forest-labs/FLUX.1-dev), 2025.

[^23]: Christopher G. Langton. Studying artificial life with cellular automata. *Physica D: Nonlinear Phenomena*, 22(1-3):120–149, 1986.

[^24]: Wen-Ding Li, Keya Hu, Carter Larsen, Yuqing Wu, Simon Alford, Caleb Woo, Spencer M. Dunn, Hao Tang, Wei-Long Zheng, Yewen Pu, and Kevin Ellis. Combining induction and transduction for abstract reasoning. In *The Thirteenth International Conference on Learning Representations*, 2025. URL [https://openreview.net/forum?id=UmdotAAVDe](https://openreview.net/forum?id=UmdotAAVDe).

[^25]: Xiaoxuan Liao, Chihang Wang, Shicheng Zhou, Jiacheng Hu, Hongye Zheng, and Jia Gao. Dynamic adaptation of lora fine-tuning for efficient and task-specific optimization of large language models. In *Proceedings of the 2025 International Conference on Artificial Intelligence and Computational Intelligence*, pp. 120–125, 2025.

[^26]: Tsung-Yi Lin, Michael Maire, Serge J. Belongie, Lubomir D. Bourdev, Ross B. Girshick, James Hays, Pietro Perona, Deva Ramanan, Piotr Dollár, and C. Lawrence Zitnick. Microsoft coco: Common objects in context. *CoRR*, abs/1405.0312, 2014. URL [http://arxiv.org/abs/1405.0312](http://arxiv.org/abs/1405.0312).

[^27]: Yijing Lin, Mengqi Huang, Shuhan Zhuang, and Zhendong Mao. Realgeneral: Unifying visual generation via temporal in-context learning with video models. *arXiv preprint arXiv:2503.10406*, 2025.

[^28]: Haokun Liu, Derek Tam, Mohammed Muqeeth, Jay Mohta, Tenghao Huang, Mohit Bansal, and Colin Raffel. Few-shot parameter-efficient fine-tuning is better and cheaper than in-context learning. *CoRR*, abs/2205.05638, 2022. URL [https://doi.org/10.48550/arXiv.2205.05638](https://doi.org/10.48550/arXiv.2205.05638).

[^29]: Meta-AI. Llama 3.1 models. [https://ai.meta.com/blog/meta-llama-3-1](https://ai.meta.com/blog/meta-llama-3-1) and [https://huggingface.co/meta-llama/Llama-3.1-8B](https://huggingface.co/meta-llama/Llama-3.1-8B), 2024.

[^30]: Arsenii Moskvichev, Victor Vikram Odouard, and Melanie Mitchell. The conceptarc benchmark: Evaluating understanding and generalization in the arc domain. *Trans. Mach. Learn. Res.*, 2023, 2023. URL [https://openreview.net/forum?id=8ykyGbtt2q](https://openreview.net/forum?id=8ykyGbtt2q).

[^31]: Pushmeet Kohli Nathan Silberman, Derek Hoiem and Rob Fergus. Indoor segmentation and support inference from rgbd images. In *ECCV*, 2012.

[^32]: NVIDIA,:, Niket Agarwal, Arslan Ali, Maciej Bala, Yogesh Balaji, Erik Barker, Tiffany Cai, Prithvijit Chattopadhyay, Yongxin Chen, Yin Cui, Yifan Ding, Daniel Dworakowski, Jiaojiao Fan, Michele Fenzi, Francesco Ferroni, Sanja Fidler, Dieter Fox, Songwei Ge, Yunhao Ge, Jinwei Gu, Siddharth Gururani, Ethan He, Jiahui Huang, Jacob Huffman, Pooya Jannaty, Jingyi Jin, Seung Wook Kim, Gergely Klár, Grace Lam, Shiyi Lan, Laura Leal-Taixe, Anqi Li, Zhaoshuo Li, Chen-Hsuan Lin, Tsung-Yi Lin, Huan Ling, Ming-Yu Liu, Xian Liu, Alice Luo, Qianli Ma, Hanzi Mao, Kaichun Mo, Arsalan Mousavian, Seungjun Nah, Sriharsha Niverty, David Page, Despoina Paschalidou, Zeeshan Patel, Lindsey Pavao, Morteza Ramezanali, Fitsum Reda, Xiaowei Ren, Vasanth Rao Naik Sabavat, Ed Schmerling, Stella Shi, Bartosz Stefaniak, Shitao Tang, Lyne Tchapmi, Przemek Tredak, Wei-Cheng Tseng, Jibin Varghese, Hao Wang, Haoxiang Wang, Heng Wang, Ting-Chun Wang, Fangyin Wei, Xinyue Wei, Jay Zhangjie Wu, Jiashu Xu, Wei Yang, Lin Yen-Chen, Xiaohui Zeng, Yu Zeng, Jing Zhang, Qinsheng Zhang, Yuxuan Zhang, Qingqing Zhao, and Artur Zolkowski. Cosmos world foundation model platform for physical ai, 2025. URL [https://arxiv.org/abs/2501.03575](https://arxiv.org/abs/2501.03575).

[^33]: Adam Polyak et al. Movie gen: A cast of media foundation models. *CoRR*, abs/2410.13720, 2024. URL [https://doi.org/10.48550/arXiv.2410.13720](https://doi.org/10.48550/arXiv.2410.13720).

[^34]: Akshara Prabhakar, Yuanzhi Li, Karthik Narasimhan, Sham M. Kakade, Eran Malach, and Samy Jelassi. Lora soups: Merging loras for practical skill composition tasks. *CoRR*, abs/2410.13025, 2024. URL [https://doi.org/10.48550/arXiv.2410.13025](https://doi.org/10.48550/arXiv.2410.13025).

[^35]: Yiran Qin, Zhelun Shi, Jiwen Yu, Xijun Wang, Enshen Zhou, Lijun Li, Zhenfei Yin, Xihui Liu, Lu Sheng, Jing Shao, Lei Bai, Wanli Ouyang, and Ruimao Zhang. Worldsimbench: Towards video generation models as world simulators. *CoRR*, abs/2410.18072, 2024. URL [https://doi.org/10.48550/arXiv.2410.18072](https://doi.org/10.48550/arXiv.2410.18072).

[^36]: quantum24. Chess puzzles 10k in pgn san. [https://huggingface.co/datasets/quantum24/chess\_puzzles\_10k\_in\_pgn\_san](https://huggingface.co/datasets/quantum24/chess_puzzles_10k_in_pgn_san), 2023. Curated collection of checkmate-in-1, -2, and -3 puzzles derived from the Lichess community puzzle database. Licensed under CC0 1.0.

[^37]: Qwen3-4B-Instruct-2507 Team. Qwen3 technical report. *arXiv preprint arXiv:2505.09388*, 2025.

[^38]: Mike Roberts, Jason Ramapuram, Anurag Ranjan, Atulit Kumar, Miguel Angel Bautista, Nathan Paczan, Russ Webb, and Joshua M. Susskind. Hypersim: A photorealistic synthetic dataset for holistic indoor scene understanding. In *International Conference on Computer Vision (ICCV) 2021*, 2021.

[^39]: Nataniel Ruiz, Yuanzhen Li, Varun Jampani, Yael Pritch, Michael Rubinstein, and Kfir Aberman. Dreambooth: Fine tuning text-to-image diffusion models for subject-driven generation. *CoRR*, abs/2208.12242, 2022. URL [https://doi.org/10.48550/arXiv.2208.12242](https://doi.org/10.48550/arXiv.2208.12242).

[^40]: Mong Yuan Sim, Wei Emma Zhang, Xiang Dai, and Biaoyan Fang. Can vlms actually see and read? a survey on modality collapse in vision-language models. In *Findings of the Association for Computational Linguistics: ACL 2025*, pp. 24452–24470, 2025.

[^41]: Ruben Villegas et al. Phenaki: Variable length video generation from open domain textual description. *CoRR*, abs/2210.02399, 2022. URL [https://doi.org/10.48550/arXiv.2210.02399](https://doi.org/10.48550/arXiv.2210.02399).

[^42]: Ang Wang, Baole Ai, Bin Wen, Chaojie Mao, Chen-Wei Xie, Di Chen, Feiwu Yu, Haiming Zhao, Jianxiao Yang, Jianyuan Zeng, Jiayu Wang, Jingfeng Zhang, Jingren Zhou, Jinkai Wang, Jixuan Chen, Kai Zhu, Kang Zhao, Keyu Yan, Lianghua Huang, Xiaofeng Meng, Ningyi Zhang, Pandeng Li, Pingyu Wu, Ruihang Chu, Ruili Feng, Shiwei Zhang, Siyang Sun, Tao Fang, Tianxing Wang, Tianyi Gui, Tingyu Weng, Tong Shen, Wei Lin, Wei Wang, Wei Wang, Wenmeng Zhou, Wente Wang, Wenting Shen, Wenyuan Yu, Xianzhong Shi, Xiaoming Huang, Xin Xu, Yan Kou, Yangyu Lv, Yifei Li, Yijing Liu, Yiming Wang, Yingya Zhang, Yitong Huang, Yong Li, You Wu, Yu Liu, Yulin Pan, Yun Zheng, Yuntao Hong, Yupeng Shi, Yutong Feng, Zeyinzi Jiang, Zhen Han, Zhi-Fan Wu, and Ziyu Liu. Wan: Open and advanced large-scale video generative models. *CoRR*, abs/2503.20314, March 2025. URL [https://doi.org/10.48550/arXiv.2503.20314](https://doi.org/10.48550/arXiv.2503.20314).

[^43]: Xinlong Wang, Wen Wang, Yue Cao, Chunhua Shen, and Tiejun Huang. Images speak in images: A generalist painter for in-context visual learning. In *Proceedings of the IEEE/CVF Conference on Computer Vision and Pattern Recognition*, pp. 6830–6839, 2023a.

[^44]: Zhendong Wang, Yifan Jiang, Yadong Lu, Pengcheng He, Weizhu Chen, Zhangyang Wang, Mingyuan Zhou, et al. In-context learning unlocked for diffusion models. *Advances in Neural Information Processing Systems*, 36:8542–8562, 2023b.

[^45]: Stephen Wolfram. Universality and complexity in cellular automata. *Physica D: Nonlinear Phenomena*, 10(1):1–35, 1984. ISSN 0167-2789. doi: https://doi.org/10.1016/0167-2789(84)90245-8. URL [https://www.sciencedirect.com/science/article/pii/0167278984902458](https://www.sciencedirect.com/science/article/pii/0167278984902458).

[^46]: Chenfei Wu, Jiahao Li, Jingren Zhou, Junyang Lin, Kaiyuan Gao, Kun Yan, Sheng-ming Yin, Shuai Bai, Xiao Xu, Yilei Chen, Yuxiang Chen, Zecheng Tang, Zekai Zhang, Zhengyi Wang, An Yang, Bowen Yu, Chen Cheng, Dayiheng Liu, Deqing Li, Hang Zhang, Hao Meng, Hu Wei, Jingyuan Ni, Kai Chen, Kuan Cao, Liang Peng, Lin Qu, Minggang Wu, Peng Wang, Shuting Yu, Tingkun Wen, Wensen Feng, Xiaoxiao Xu, Yi Wang, Yichang Zhang, Yongqiang Zhu, Yujia Wu, Yuxuan Cai, and Zenan Liu. Qwen-image technical report. Technical report, Qwen Team, August 2025. URL [https://arxiv.org/abs/2508.02324](https://arxiv.org/abs/2508.02324). Accessed: 2025-09-23.

[^47]: Guangkai Xu, Yongtao Ge, Mingyu Liu, Chengxiang Fan, Kangyang Xie, Zhiyue Zhao, Hao Chen, and Chunhua Shen. What matters when repurposing diffusion models for general dense perception tasks? *The Thirteenth International Conference on Learning Representations (ICLR)*, 2025. URL [https://openreview.net/forum?id=BgYbk6ZmeX](https://openreview.net/forum?id=BgYbk6ZmeX).

[^48]: Zhuoyi Yang, Shuhong Wang, Jing Li, Haoran Zhang, Junpeng Chen, Zeyu Wang, Qian Liu, Jinzhe Li, Yifan Du, Kun Zhou, et al. Cogvideox: Text-to-video diffusion models with an expert transformer. *arXiv preprint arXiv:2408.06072*, 2024.

[^49]: Canyu Zhao, Mingyu Liu, Huanyi Zheng, Muzhi Zhu, Zhiyue Zhao, Hao Chen, Tong He, and Chunhua Shen. Diception: A generalist diffusion model for visual perceptual tasks. *arXiv preprint arXiv:2502.17157*, 2025. URL [https://arxiv.org/abs/2502.17157](https://arxiv.org/abs/2502.17157).

[^50]: Bolei Zhou, Hang Zhao, Xavier Puig, Sanja Fidler, Adela Barriuso, and Antonio Torralba. Scene parsing through ade20k dataset. In *Proceedings of the IEEE Conference on Computer Vision and Pattern Recognition*, 2017.

[^51]: Bolei Zhou, Hang Zhao, Xavier Puig, Tete Xiao, Sanja Fidler, Adela Barriuso, and Antonio Torralba. Semantic understanding of scenes through the ade20k dataset. *International Journal of Computer Vision*, 127(3):302–321, 2019.