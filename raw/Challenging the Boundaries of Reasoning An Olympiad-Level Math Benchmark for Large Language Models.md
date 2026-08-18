---
title: "Challenging the Boundaries of Reasoning: An Olympiad-Level Math Benchmark for Large Language Models"
source: "https://arxiv.org/html/2503.21380v3"
author:
published:
created: 2026-06-23
description:
tags:
  - "clippings"
---
Haoxiang Sun <sup>1</sup>, Yingqian Min <sup>2</sup>, Zhipeng Chen <sup>2</sup>,  
Wayne Xin Zhao <sup>2 🖂</sup>, Ji-Rong Wen <sup>2</sup>  
<sup>1</sup> School of Information, Renmin University of China  
<sup>2</sup> Gaoling School of Artificial Intelligence, Renmin University of China  
{hxiang.sun, batmanfly}@gmail.com

###### Abstract

The rapid advancement of large reasoning models has saturated existing math benchmarks, underscoring the urgent need for more challenging evaluation frameworks. To address this, we introduce OlymMATH, a rigorously curated, Olympiad-level math benchmark comprising 350 problems, each with parallel English and Chinese versions. OlymMATH is the first benchmark to unify dual evaluation paradigms within a single suite: (1) *natural language evaluation* through OlymMATH-EASY and OlymMATH-HARD, comprising 200 computational problems with numerical answers for objective rule-based assessment, and (2) *formal verification* through OlymMATH-LEAN, offering 150 problems formalized in Lean 4 for rigorous process-level evaluation. All problems are manually sourced from printed publications to minimize data contamination, verified by experts, and span four core domains. Extensive experiments reveal the benchmark’s significant challenge, and our analysis also uncovers consistent performance gaps between languages and identifies cases where models employ heuristic “guessing” rather than rigorous reasoning. To further support community research, we release 582k+ reasoning trajectories, a visualization tool, and expert solutions at [https://github.com/RUCAIBox/OlymMATH](https://github.com/RUCAIBox/OlymMATH).

Challenging the Boundaries of Reasoning:  
An Olympiad-Level Math Benchmark for Large Language Models

Haoxiang Sun <sup>1</sup>, Yingqian Min <sup>2</sup>, Zhipeng Chen <sup>2</sup>, Wayne Xin Zhao <sup>2 🖂</sup>, Ji-Rong Wen <sup>2</sup> <sup>1</sup> School of Information, Renmin University of China <sup>2</sup> Gaoling School of Artificial Intelligence, Renmin University of China {hxiang.sun, batmanfly}@gmail.com

<sup>🖂</sup>

## 1 Introduction

The advent of large language models (LLMs) [^53] has marked a significant leap forward in the capabilities of artificial intelligence, with mathematical reasoning emerging as a pivotal and demanding area of research [^8] [^30] [^6]. Recently, the evaluation and enhancement of mathematical reasoning abilities have become a central focus in the development of LLMs [^49].

Effective assessment of LLM reasoning necessitates *reliable* and *verifiable* evaluation benchmarks. Reliability requires accurately designed problems with unambiguous solutions and minimized data contamination risk, ensuring trustworthy evaluation. For verifiability, two paradigms have emerged: (1) *numerical-answer benchmarks* using rule-based verification (*e.g.,* sympy), which offer scalability but cannot assess reasoning quality; and (2) *formal proof benchmarks* using theorem provers (*e.g.,* Lean, Isabelle), which provide rigorous process-level verification but require specialized formalization. An ideal benchmark suite should leverage both paradigms for comprehensive evaluation.

Existing benchmarks in both paradigms leave certain dimensions only partially addressed, and these gaps are not straightforwardly closed by recombining available resources. Among numerical-answer benchmarks, Olympiad-difficulty collections may not yet provide sufficient scale for robust statistical conclusions or enough headroom for the strongest current models (see Table 1); LLM-as-judge evaluation can be susceptible to evaluator hallucination, and reference solutions are occasionally incomplete. Among formal proof benchmarks, available datasets are English-only and drawn from well-known competitions with substantial online presence, warranting attention to potential contamination. More broadly, most existing benchmarks center on English, leaving multilingual reasoning comparatively less explored. Jointly ensuring consistent quality and low contamination across all these dimensions remains an open problem, as assembling web-crawled sources from different origins risks reintroducing the issues that motivate this work.

To bridge the gap, we present OlymMATH, a rigorously curated, bilingual (English and Chinese) benchmark for Olympiad-level reasoning, comprising 350 unique problems organized into three non-overlapping subsets: OlymMATH-EASY and OlymMATH-HARD contain 100 computational problems each, split into *easy* and *hard* levels with parallel bilingual versions, requiring precise numerical answers for reliable and rule-based sympy verification. Additionally, OlymMATH-LEAN provides a separate set of 150 problems formalized in Lean 4, accompanied by bilingual natural language statements and solutions, enabling rigorous evaluation of automated theorem proving capabilities. Unlike proof-based benchmarks that rely on unreliable LLM-as-a-judge evaluation, OlymMATH-LEAN leverages the Lean language for fully automated and mathematically rigorous formal verification. Meanwhile, to prevent data leakage, problems were manually sourced from printed publications and verified by experts. The benchmark covers four major mathematical fields and adheres to the MATH or miniF2F dataset format for compatibility (see Figure 1).

OlymMATH-EASY / HARD

Problem-EN: Find the remainder of $\sum_{k=0}^{1234}\binom{2016\times 1234}{2016k}$ modulo $2017^{2}$ (provide the value in the range $[0,2017^{2})$).

Answer: $1581330$. Subject: Number Theory.

OlymMATH-LEAN

Subject: Number Theory. Formal Statement:

```
theorem to_prove
  (n : Nat) (p : Nat) (hp : p.Prime)
  (hdiv : p | 2ˆn + 1) : p % 8 != 7 := by sorry
```

Figure 1: Examples from our OlymMATH dataset.

By leveraging OlymMATH, we conduct extensive experiments to evaluate the performance of state-of-the-art models. The results underscore our benchmark’s difficulty, with advanced models like DeepSeek-R1, o3-mini, and Gemini 2.5 Pro Exp achieving only 19.5%, 31.2%, and 58.4% accuracy, respectively, on OlymMATH-HARD (EN), indicating Olympiad-level math remains a significant challenge necessitating further research. Our bilingual comparison showed a consistent performance gap, with higher accuracy on English problems versus Chinese, highlighting the need for multilingual evaluation. Furthermore, case studies revealed models sometimes use heuristic “guessing” to reach answers without rigorous proofs. This underscores the importance of process-level inspection for accurate LLM capability assessment.

In summary, our contributions are as follows.

$\bullet$ We introduce OlymMATH, the first Olympiad-level mathematical benchmark that unifies natural language problems and formal theorem proving within a single bilingual suite. OlymMATH comprises 350 unique problems, each available in both English and Chinese: OlymMATH-EASY and OlymMATH-HARD provide 200 computational problems with sympy-verifiable numerical answers, while OlymMATH-LEAN offers 150 problems formalized in Lean 4 for process-level verification—bridging the gap between outcome-based and reasoning-based evaluation.

$\bullet$ Extensive experiments validate OlymMATH’s reliability and strong discriminative power, while revealing critical model limitations including EN-ZH performance gaps and heuristic “guessing” that bypasses rigorous reasoning.

$\bullet$ We open-source 582,400 reasoning trajectories from 28 models, a visualization tool, and expert solutions to facilitate community research.

## 2 Related Work

##### Natural Language Math Benchmarks.

The first paradigm of math reasoning evaluation relies on numerical-answer benchmarks with rule-based verification due to their simplicity and scalability. Early benchmarks such as GSM8K [^7] and MATH [^19] have been pivotal in advancing LLM reasoning capabilities [^10] [^4], but are now largely saturated by slow-thinking models enhanced by long chain-of-thought fine-tuning [^26] or reinforcement learning scaling [^8].

More challenging benchmarks face different limitations. The AIME dataset offers increased difficulty but suffers from small scale (*e.g.,* 30 problems from AIME 2025), compromising statistical reliability—a single problem shift can change accuracy by 3.33% [^20], with binomial standard errors approximately 2.6 $\times$ larger than those from a 200-problem benchmark. Moreover, rapidly improving models are approaching its measurement ceiling (*e.g.,* Gemini 2.5 Pro achieving 92% Pass@1 on AIME 2024), and its English-only focus neglects multilingual evaluation. OlympiadBench [^17] provides a larger collection of problems, but its overall difficulty remains limited—even a 1.5B model (DeepScaleR-Preview [^25]) achieves 50.0% accuracy, indicating insufficient challenge for evaluating state-of-the-art reasoning models. Omni-MATH [^11] increases problem count via web crawling from AoPS, elevating data leakage risks, while its prevalent proof-based problems require LLM-as-judge evaluation rather than rule-based verification, reducing dependability. PolyMath [^46] directly sources from widely publicized competitions (*e.g.,* AIME, CNMO, IMO) and existing datasets (*e.g.,* MGSM [^38], P-MMEval [^52], HLE [^32]), risking high data leakage. AMO Bench [^1] targets advanced Olympiad problems but has limited scale.

In contrast, OlymMATH provides 200 challenging Olympiad-level problems with lower contamination risk through manual curation from printed publications, larger scale for statistical reliability, and bilingual versions for thorough evaluation.

##### Formal Language Math Benchmarks.

Beyond assessing final answers, understanding *how* models arrive at solutions—distinguishing rigorous derivation from heuristic shortcuts—is equally important. Formal theorem proving benchmarks address this by requiring machine-checkable proofs. miniF2F [^54] provides Olympiad-level problems formalized in multiple proof assistants, while ProofNet [^5] focuses on undergraduate mathematics. FIMO [^23] and PutnamBench [^44] target competition mathematics at different levels. However, existing formal benchmarks typically source from well-known competitions (*e.g.,* IMO shortlist for FIMO, Putnam for PutnamBench) with high online exposure, facing similar contamination risks. Moreover, all existing formal benchmarks are English-only. OlymMATH-LEAN addresses these gaps with bilingual Lean 4 formalizations sourced from printed publications.

## 3 Benchmark Construction

(a) Natural Language Benchmarks

| Name | \# Prob. |  |  |
| --- | --- | --- | --- |
| (# Lang.) | Eval. | Difficulty |  |
| AIME 24,25 | 30 (1) | Rule | Olympiad |
| HMMT | 30 (1) | Rule | Olympiad |
| USAMO 2025 | 6 (1) | LLM | Olympiad |
| OlympiadBench | 2133 (2) | Rule | Olympiad |
| Omni-MATH | 4428 (1) | LLM | Olympiad |
| PolyMath | 500 (18) | Rule | Olympiad |
| AMO Bench | 50 (1) | Rule & LLM | Olympiad |
| EASY (Ours) | 100 (2) | Rule | Olympiad |
| HARD (Ours) | 100 (2) | Rule | Olympiad |

(b) Formal Language Benchmarks

| Name | \# Prob. | Lang. | Difficulty |
| --- | --- | --- | --- |
| miniF2F | 488 | EN | Olympiad |
| ProofNet | 371 | EN | Undergrad |
| FIMO | 149 | EN | Olympiad |
| PutnamBench | 640 | EN | Undergrad Comp. |
| LEAN (Ours) | 150 | EN & ZH | Olympiad |

Table 1: Comparison of existing benchmarks. EN and ZH denote English and Chinese, respectively.

In this section, we describe OlymMATH in detail, including its construction methodology, problem composition, categorical distribution, and evaluation approach. Table 1 presents a comparison with existing mathematical reasoning benchmarks. Existing benchmarks typically focus on either *natural language problems* with numerical answers or *formal theorem proving*, but not both. OlymMATH bridges this gap by being the first Olympiad-level benchmark to integrate both paradigms within a unified bilingual framework: OlymMATH-EASY and OlymMATH-HARD provide 200 natural language problems requiring precise numerical answers for scalable rule-based verification, while OlymMATH-LEAN offers 150 problems with Lean 4 formalizations enabling rigorous process-level verification. This dual-paradigm design allows comprehensive assessment of both outcome correctness and reasoning rigor, addressing the limitations of relying on either paradigm alone.

### 3.1 Contamination Analysis & Verification

##### Contamination Analysis

Constructing a reliable benchmark requires mitigating data contamination. OlymMATH comprises 350 problems curated from printed resources (specialized magazines and textbooks), intentionally excluding online repositories to minimize prior digital exposure, unlike existing benchmarks drawing from well-known competitions (*e.g.,* FIMO using IMO shortlist, PutnamBench using Putnam, Omni-MATH using AoPS).

For quantitative leakage analysis, we followed Omni-MATH, using $n$ -gram accuracy metric [^48]: for each sample, the problem and answer are concatenated; 5 starting points are uniformly sampled; and the model’s ability to predict the subsequent 5-gram is evaluated. Leakage risk is quantified by comparing $n$ -gram accuracy on the original dataset against 3 LLM-rewritten versions (Gemini 2.5 Flash Preview Thinking [^15]), with the normalized difference $\delta$ indicating model familiarity with original versus rewritten data. Since $\delta$ ’s absolute value depends on the rewriting LLM, assessing leakage risk requires *relative comparison* of $\delta$ between benchmarks. Results in Table 2 show lower contamination risk for OlymMATH than PolyMath, establishing OlymMATH as a more reliable benchmark for evaluating LLMs’ true mathematical capabilities.

| Model (Base) | Lang. | PolyMath | OlymMATH |
| --- | --- | --- | --- |
| InternLM2-Math-7B |  |  |  |
| [^50] | EN | 34.84% | 0.90% |
|  | ZH | 12.29% | 0.88% |
| Qwen2.5-7B |  |  |  |
| [^34] | EN | 38.81% | 17.59% |
|  | ZH | 10.27% | 3.42% |

Table 2: Results of leakage analysis. The lower value is bolded. OlymMATH exhibits lower $\delta$ values than PolyMath per language, indicating a lower leakage risk.

##### Verification

To enhance dataset reliability, we invited a China Mathematical Olympiad silver medalist and two provincial first-prize winners to verify and revise the problems and solutions in OlymMATH-EASY and HARD. Since the answers to the problems were already provided, the verification difficulty was reduced, making the expertise of reviewers sufficient for this task. Each problem was reviewed by at least two reviewers. Additionally, we have published official solutions for challenging problems for community oversight.

For OlymMATH-LEAN, we leverage the Lean server for automatic verification. Raw problems and solutions are first cleaned by Claude Opus 4.5 [^3] for format correction, then undergo three independent verification rounds using DeepSeek V3.2 Speciale [^9] to check translation accuracy, statement precision, and solution rigor. A Claude Opus 4.5-based agent (see Appendix A.2 for details) then iteratively interacts with a Kimina Lean REPL server [^36] in an isolated sandbox, refining code based on compiler feedback until successful compilation. Compiled formalizations are validated by three independent Gemini 3.0 Flash [^14] calls for semantic alignment, and formalizations containing axiom declarations receive additional human expert reviews.

### 3.2 Problem Categories and Distribution

OlymMATH problems span four key high-school Olympiad mathematical fields—algebra, geometry, number theory, and combinatorics—classified by human experts for reliability. Problems are selected for their challenge, suitability for simple-answer verification, and topic diversity (*e.g.,* inequalities, sequences, and more in algebra). Figure-based problems within this set are text-reformulated for LLM compatibility, with non-convertible ones excluded (*e.g.,* Figure [5](#A1.SS3 "A.3 Demonstrations, Case Study Examples and Full Evaluation Results ‣ Appendix A Appendix ‣ Challenging the Boundaries of Reasoning: An Olympiad-Level Math Benchmark for Large Language Models") in Appendix).

For refined evaluation, computational problems are categorized by difficulty: *easy*, designed to challenge standard prompting in mainstream models, and *hard*, tailored to test advanced reasoning (*e.g.,* slow-thinking modes) in state-of-the-art models. Additionally, OlymMATH-LEAN provides 150 problems with Lean 4 (Mathlib v4.24.0) formalizations for process-level verification. The distribution details are described in Table 3.

rowsep=2pt Category # Problems Easy Hard Lean Algebra (Alg.) Inequality, Trigonometry, etc. 25 25 79 Geometry (Geo.) Solid & Analytic Geometry, etc. 33 25 15 Number Theory (Num.) Diophantine Equation, etc. 13 25 42 Combinatorics (Com.) Graph Theory, Permutation, etc. 29 25 14 Total 100 100 150

Table 3: The distribution of OlymMATH by category.

### 3.3 Format and Verification Methodology

OlymMATH adopts MATH and miniF2F dataset format (see Figure 1) for seamless integration with existing pipelines and enhancing clarity and processing efficiency. All problems are text-based, including geometry problems reformulated from diagrams to align with LLM evaluation, as mentioned previously. For consistent, objective assessment, answers to computational problems are restricted to real numbers and intervals, *e.g.,* “ $[\sqrt{33},+\infty)$ ”, while excluding ambiguous formats such as set operations, variables, complex numbers, and texts (see Table 11 in Appendix for details). This design enables reliable sympy-based and formal Lean server verification.

To make the evaluation more challenging, OlymMATH includes problems with multiple numerical answers. These problems are modified to require a summary of all potential outcomes (*e.g.,* sums, sums of squares; see Figure [6](#A1.SS3 "A.3 Demonstrations, Case Study Examples and Full Evaluation Results ‣ Appendix A Appendix ‣ Challenging the Boundaries of Reasoning: An Olympiad-Level Math Benchmark for Large Language Models") in Appendix). This method effectively assesses whether models can consider all possible answers, thereby providing a robust evaluation of their reasoning capabilities.

### 3.4 Bilingual Extension

Originating from Chinese-language problems, OlymMATH provides both original Chinese and translated English versions for bilingual evaluation. Our translation pipeline employs Claude Sonnet 3.7 [^2] for initial translation, iterative refinement with GPT-4o [^29], and human verification by two expert annotators to ensure mathematical accuracy and linguistic fluency. OlymMATH-LEAN similarly provides bilingual natural language statements alongside Lean formalizations, supporting research in multilingual reasoning and informal-formal translation.

## 4 Experiments

In this section, we assess the performance of leading reasoning models using OlymMATH and provide a detailed analysis of their capabilities.

### 4.1 Natural Language: Easy & Hard Subset

We first evaluate models on the natural language subsets, where problems require numerical answers verified via rule-based matching.

#### 4.1.1 Experimental Setup

##### Models.

We assess representative LLMs for a thorough evaluation. For open-source models, we investigated recent work on reasoning models, and evaluated DeepSeek-R1 [^8], STILL-3-Preview [^43], DeepScaleR-Preview [^25], QwQ [^42], Light-R1 [^47], OpenThinker2 [^40], Skywork-OR1 [^18], GLM-Z1-Air [^12], AceMath-RL [^24], OpenMath-Nemotron [^27], and Qwen3 [^41]. For closed-source models, we evaluate o3-mini (high) [^31] and Gemini 2.5 Pro Exp 0325 [^13].
**Table omitted after export**
Table 4: Model performance on OlymMATH sorted by model size. The abbreviations “Alg.”, “Geo.”, etc. represent the four categories in OlymMATH. Models sampled only 8 times are marked in gray to indicate potential instability. For brevity, only representative models are shown; see Table 9 and Table 10 in Appendix for complete results.

##### Evaluation Details.

Our evaluation pipeline generates 64 responses per problem for each model, except for resource-intensive models (*i.e.,* OpenMath-Nemotron-32B, Qwen3-235B-A22B, GLM-Z1-Air, DeepSeek-R1, o3-mini (high), and Gemini 2.5 Pro Exp), which are limited to 8 samples due to resource limitations and the relatively large scale of our dataset. For Pass@1, we compute mean accuracy across all sampled responses; for Cons@64 and Cons@8, we apply majority voting to determine a consensus answer per problem. Following established practices [^8] [^42], locally-evaluated models use temperature = 0.6, top\_p = 0.95, min\_p = 0, and max\_tokens = 32768, while API-evaluated models (*i.e.,* GLM-Z1-Air, DeepSeek-R1, o3-mini (high), and Gemini 2.5 Pro Exp) use maximum available max\_tokens to fully leverage their reasoning capabilities. We open-source all 582,400 samples, an online visualization tool, and standard solutions for challenging problems to support community analysis of LLM reasoning patterns and characteristics (see Appendix A.1 for further information).

#### 4.1.2 Evaluation Results

In this part, we present the evaluation results of OlymMATH (EN) and OlymMATH (ZH) in Table 4. Due to space constraints, we include only representative models in the main text, and full results are provided in Tables 9 and 10 in Appendix.

![Refer to caption](https://arxiv.org/html/2503.21380v3/x1.png)

Figure 2: Pass@1 on OlymMATH EN (y) vs. ZH (x), the dashed line shows parity. Points above favor EN, below favor ZH. Solid circles (local dense models, colored by size) indicate larger models trend towards higher accuracy. Diamonds are MoE or closed-source models.

First, we observe that all tested models exhibit relatively poor performance, with even OpenAI o3-mini (high) and Gemini 2.5 Pro Exp achieving only 31.2% and 58.4% on OlymMATH-HARD (EN). This underscores the high overall difficulty of our benchmark, which demands stronger reasoning abilities and a deeper understanding of mathematical knowledge. In contrast, the performance of these advanced reasoning models on OlymMATH-EASY (EN) is more modest and comparable to that on AIME 2024, suggesting that OlymMATH-EASY is well-suited for evaluating the capabilities of less advanced reasoning models.

Second, by comparing the performance of LLMs on bilingual versions of OlymMATH, we find that language can influence the reasoning performance of LLMs to some extent (see Figure [2](#S4.SS1.SSS2 "4.1.2 Evaluation Results ‣ 4.1 Natural Language: Easy & Hard Subset ‣ 4 Experiments ‣ Challenging the Boundaries of Reasoning: An Olympiad-Level Math Benchmark for Large Language Models")). Overall, all models tend to achieve higher performance on the English benchmarks. A potential reason for this is that English corpora still dominate existing pre-training datasets, making the English-based task-solving capabilities of LLMs generally superior compared to other languages. Prior work has documented cross-lingual reasoning gaps in word grouping [^16], multilingual reasoning paths [^39], and thinking trace languages [^33]. OlymMATH extends these findings to Olympiad-level mathematics: Wilcoxon signed-rank tests on our released 582k trajectories from 14 models (1.5B, 7B, 14B) confirm that the EN-ZH gap is statistically significant across all subjects and difficulty levels. Trajectory analysis further shows that extraction failures are disproportionately frequent among incorrect ZH responses, pointing to a language-specific presentation issue distinct from reasoning errors.

Third, to provide insights into model robustness beyond Pass@1, we report Pass@k for DeepSeek-R1-Distill-Qwen series in Table 5. The results reveal substantial gains from increased sampling: 7B model improves from 11.1% (Pass@1) to 74.0% (Pass@64) on EN-HARD, indicating that correct solutions exist within the model’s capability but require multiple attempts to surface. However, the gap between Pass@64 and Cons@64 (74.0% vs. 22.0%) suggests significant inconsistency—models can solve problems but often fail to do so reliably. These results support the use of Pass@k as a more comprehensive metric for probing the reasoning capability boundaries of LLMs [^51].

| Model | Subset | P@1 | P@4 | P@16 | P@64 | C@64 |
| --- | --- | --- | --- | --- | --- | --- |
| 1.5B | Easy | 16.0 | 37.5 | 62.2 | 78.0 | 32.0 |
|  | Hard | 1.5 | 5.1 | 14.2 | 30.0 | 0.0 |
| 7B | Easy | 47.5 | 78.4 | 91.8 | 97.0 | 77.0 |
|  | Hard | 11.1 | 29.6 | 53.4 | 74.0 | 22.0 |
| 32B | Easy | 67.3 | 90.8 | 97.4 | 100.0 | 89.0 |
|  | Hard | 16.9 | 38.7 | 59.0 | 75.0 | 25.0 |

Table 5: Pass@k and Cons@64 for DS-R1-Distill series on OlymMATH-EASY and HARD (in English).

#### 4.1.3 Benchmark Comparison

| Model | AIME | OBench | Omni | Easy | Hard |
| --- | --- | --- | --- | --- | --- |
| STILL-3-Pre. (1.5B) | 32.5 | 45.4 | \- | 18.4 | 3.8 |
| DScaleR-Pre. (1.5B) | 43.1 | 50.0 | \- | 22.3 | 4.1 |
| GPT-4o | 13.1 | 41.5 | 30.5 | \- | \- |
| o1-mini | 63.6 | \- | 60.5 | \- | \- |
| QwQ (32B) | 79.5 | \- | 65.2 | 84.0 | 23.1 |
| DeepSeek R1 | 79.8 | \- | 67.3 | 79.6 | 19.5 |
| GLM-Z1-Air (32B) | 80.8 | \- | 68.4 | 76.8 | 20.1 |
| o3-mini (high) | 87.3 | \- | \- | 91.4 | 31.2 |
| Gemini 2.5 Pro Exp | 92.0 | \- | \- | 92.2 | 58.4 |

Table 6: Cross-benchmark Pass@1 comparison. “-” indicates no publicly available data. AIME denotes AIME 2024. OBench denotes OlympiadBench. Omni denotes Omni-MATH. Easy and Hard denotes our OlymMATH subsets. DScaleR denotes DeepScaleR.

To comprehensively evaluate OlymMATH against existing benchmarks, we compare model performances across widely used mathematical benchmarks. We collected results from official repositories, as shown in Table 6. These results reveal the difficulty hierarchy: Hard $\gg$ Easy $\approx$ AIME24 $>$ OlympiadBench, while Omni-MATH spans from OlympiadBench level to slightly above AIME but remains considerably easier than OlymMATH-HARD. OlymMATH-EASY validates our design as an extended bilingual version of AIME—models like DeepSeek-R1 achieve nearly identical scores on both (79.8% vs. 79.6%), confirming comparable difficulty levels. In contrast, OlymMATH-HARD presents substantially greater challenges: even Gemini 2.5 Pro Exp and o3-mini (high), which exceed 87% on AIME24, only attain 58.4% and 31.2% respectively on our HARD subset. This divergence is particularly striking given their similar AIME24 performance (92.0% vs. 87.3%), demonstrating OlymMATH-HARD’s superior discriminative power for differentiating state-of-the-art capabilities. Furthermore, with 100 problems per difficulty level compared to AIME’s 30 problems, OlymMATH provides more stable performance measurements—addressing the statistical reliability concerns inherent in smaller-scale benchmarks.

![Refer to caption](https://arxiv.org/html/2503.21380v3/x2.png)

Figure 3: Correlation of Pass@1 metric: OlymMATH (EN) vs. AIME24. Dashed lines indicate linear trends per dataset. Solid circles (local dense models, colored by size) indicate larger models trend towards higher accuracy. Diamonds are MoE or closed-source models.

Figure [3](#S4.SS1.SSS3 "4.1.3 Benchmark Comparison ‣ 4.1 Natural Language: Easy & Hard Subset ‣ 4 Experiments ‣ Challenging the Boundaries of Reasoning: An Olympiad-Level Math Benchmark for Large Language Models") further validates OlymMATH’s reliability by comparing against AIME24. The close clustering around linear trend lines indicates consistent relative model rankings across both benchmarks, suggesting OlymMATH measures similar reasoning abilities. Despite this correlation, OlymMATH, particularly the HARD subset, remains significantly more challenging, reinforcing its superior discriminative power for state-of-the-art models.

#### 4.1.4 Analysis of Reasoning Patterns

During our data collection and preliminary experiments, we empirically observed that LLMs sometimes resort to *empirical guesses* —such as heuristics, symmetry assumptions, or even fabrication—rather than rigorous reasoning. While prior studies have identified heuristic behaviors in basic arithmetic [^28], disjunctive reasoning [^21], and synthetic deductive logic [^37], OlymMATH uniquely documents such shortcuts in state-of-the-art reasoning models on genuine competition mathematics, and provides formal verification via OlymMATH-LEAN as a principled detection mechanism. For instance, in an optimization problem, o3-mini (high) merely assumed two sides are equal ($b=c$) based on symmetry, without proving this yields the optimum (see Figure [7](#A1.SS3 "A.3 Demonstrations, Case Study Examples and Full Evaluation Results ‣ Appendix A Appendix ‣ Challenging the Boundaries of Reasoning: An Olympiad-Level Math Benchmark for Large Language Models") in Appendix). While such intuitive approaches might yield correct answers, they lack logical rigor and this becomes problematic when employing rule-based or LLM-as-judge methods, as neither can effectively assess the quality of rigorous reasoning, thus potentially leading to an illusory improvement via “shortcuts”.

Similar issues were observed in AIME and Omni-MATH (see Figures [8](#A1.SS3 "A.3 Demonstrations, Case Study Examples and Full Evaluation Results ‣ Appendix A Appendix ‣ Challenging the Boundaries of Reasoning: An Olympiad-Level Math Benchmark for Large Language Models") and [9](#A1.SS3 "A.3 Demonstrations, Case Study Examples and Full Evaluation Results ‣ Appendix A Appendix ‣ Challenging the Boundaries of Reasoning: An Olympiad-Level Math Benchmark for Large Language Models") in Appendix), indicating that despite performance gains, LLMs exhibit deficiencies in deliberative thinking. This underscores the importance of process-level supervision, though its scalability remains a challenge.

Notably, these guessing strategies often fail on our OlymMATH dataset. For example, a model incorrectly assumed symmetry for a complex optimization problem in OlymMATH-HARD, yielding $3081$ instead of the correct $2625$ (see Figure [10](#A1.SS3 "A.3 Demonstrations, Case Study Examples and Full Evaluation Results ‣ Appendix A Appendix ‣ Challenging the Boundaries of Reasoning: An Olympiad-Level Math Benchmark for Large Language Models") in Appendix). OlymMATH problems, particularly in the HARD subset, are selected and designed so that their reasoning steps are difficult to “hack” through empirical guessing, thus providing a more robust evaluation of genuine reasoning capabilities.

### 4.2 Formal Language: Lean Subset

As discussed in Section 4.1.4, the “guessing” phenomenon in natural language evaluation highlights the need for process-level verification. To address this limitation, OlymMATH-LEAN provides a complementary evaluation paradigm that requires machine-verifiable Lean 4 proofs rather than numerical answers. Unlike rule-based verification that only checks final outputs, formal theorem proving enforces rigorous step-by-step reasoning—heuristic shortcuts or symmetry assumptions that lack logical justification will fail to compile. While we do not accurately measure the proportion of “guesses” in natural language benchmarks, OlymMATH-LEAN offers a principled approach to detecting such reasoning gaps.

#### 4.2.1 Experimental Setup

##### Models.

We evaluate three state-of-the-art theorem proving models, including Kimina Prover (Kimina, [^45]), DeepSeek Prover V2 (DS V2, [^35]), and Goedel Prover V2 (Goedel V2, [^22]). For each model, we employ the default prompt templates provided in their respective official repositories. Generation hyperparameters are set following the recommended configurations: temperature = $0.6$, top\_p = $0.95$, and max\_tokens = $32768$.

##### Evaluation Details.

For each problem, we sample 32 proof attempts and report Pass@k. A proof is considered successful only if it compiles without errors in Lean 4 and correctly proves the theorem.

#### 4.2.2 Evaluation Results

In this part, we present the evaluation results of OlymMATH-LEAN in Table 7 and a detailed error analysis in Table 8, respectively.

rowsep=2pt

| Metrics | Kimina (8B) | DS V2 (7B) | Goedel V2 (8B) |
| --- | --- | --- | --- |
| P@1 | 4.33 |  |  |
| 2.8 / 21.5 / 2.5 / 0.2 | 6.40 |  |  |
| 3.9 / 36.9 / 2.4 / 0.0 | 5.29 |  |  |
| 2.2 / 34.6 / 2.5 / 0.0 |  |  |  |
| P@2 | 5.90 |  |  |
| 3.9 / 30.3 / 2.7 / 0.4 | 7.36 |  |  |
| 4.6 / 42.7 / 2.4 / 0.0 | 6.65 |  |  |
| 3.4 / 41.3 / 2.5 / 0.0 |  |  |  |
| P@4 | 7.50 |  |  |
| 5.1 / 38.9 / 3.0 / 0.9 | 8.08 |  |  |
| 5.0 / 48.0 / 2.4 / 0.0 | 7.81 |  |  |
| 4.7 / 46.0 / 2.7 / 0.0 |  |  |  |
| P@8 | 9.12 |  |  |
| 6.5 / 45.2 / 3.6 / 1.8 | 8.49 |  |  |
| 5.1 / 51.6 / 2.4 / 0.0 | 8.58 |  |  |
| 5.5 / 48.3 / 3.0 / 0.0 |  |  |  |
| P@16 | 11.10 |  |  |
| 8.5 / 49.6 / 4.8 / 3.6 | 8.65 |  |  |
| 5.1 / 53.2 / 2.4 / 0.0 | 9.24 |  |  |
| 6.2 / 50.0 / 3.6 / 0.0 |  |  |  |
| P@32 | 14.00 |  |  |
| 11.4 / 53.3 / 7.1 / 7.1 | 8.67 |  |  |
| 5.1 / 53.3 / 2.4 / 0.0 | 10.00 |  |  |
| 6.3 / 53.3 / 4.8 / 0.0 |  |  |  |
| ref. | 78.3 | 75.6 | 84.6 |

Table 7: OlymMATH-LEAN evaluation results. We report Pass@k on OlymMATH-LEAN and Pass@32 on miniF2F for comparison. Numbers below each main score represent the metric in Algebra, Geometry, Number Theory, and Combinatorics, respectively. Bold indicates highest per metric. ref. denotes miniF2F Pass@32.

| Error Type | Kimina (8B) | DS V2 (7B) | Goedel V2 (8B) |
| --- | --- | --- | --- |
| Valid | 4.3% | 6.4% | 5.3% |
| Sorry | 8.0% | 0.1% | 4.4% |
| Compile | 8.4% | 43.9% | 24.5% |
| Logic | 17.2% | 44.9% | 22.5% |
| Server | 0.1% | 4.5% | 0.1% |
| Extract | 62.0% | 0.3% | 43.3% |

Table 8: Error distribution on OlymMATH-LEAN. We report the percentage of each error type across 4800 responses (150 $\times$ 32 samples) per model. Valid indicates successful proofs; Sorry indicates incomplete proofs using sorry; Compile indicates syntax or type errors, such as missing imports, type mismatches, or unknown identifiers; Logic indicates tactic failures or unsolved goals; Server indicates server errors; Extract indicates failure to extract code blocks from response.

First, all three models achieve relatively low scores on OlymMATH-LEAN (around 10%) compared to their performance on miniF2F (around 80%), highlighting the challenging nature of our benchmark. DeepSeek Prover V2 7B achieves the highest Pass@1 of 6.40%, while Kimina Prover 8B demonstrates stronger performance at higher sampling budgets, reaching the best Pass@32 of 14.00%. Across all models, geometry problems exhibit significantly higher success rates compared to other subjects, likely because many geometry problems can be solved through algebraic manipulation. In contrast, combinatorics proves to be the most challenging category, with DeepSeek Prover V2 7B and Goedel Prover V2 8B achieving 0% success rate across all Pass@k metrics.

Second, Table 8 reveals distinct error patterns across models. A significant portion of errors stem from extraction failures, where models fail to produce properly formatted \`\`\`lean4\`\`\` code blocks. Kimina Prover 8B exhibits the highest extraction error rate (62.0%), mainly caused by reaching the max\_tokens in generation. Among successfully extracted code, the success rate of compilation ranges from 51.5% to 77.7%, indicating that models still struggle with Lean grammar. Additionally, Kimina Prover 8B exhibits the highest sorry rate (8.0%), suggesting a tendency to generate incomplete proofs with placeholder tactics.

Third, DeepSeek Prover V2 has a 4.5% server error rate, with 80.4% involving the computationally expensive “exact?” tactic. Overall, these results demonstrate that OlymMATH presents substantial challenges across both evaluation paradigms.

## 5 Conclusion

We introduced OlymMATH, the first Olympiad-level math benchmark that unifies natural language evaluation and formal theorem proving within a single bilingual suite. The benchmark comprises 350 problems (each available in both English and Chinese): Easy and Hard subsets with sympy-verifiable numerical answers for scalable outcome evaluation, and Lean subset with Lean formalizations for rigorous process-level verification. Extensive experiments reveal substantial challenges for state-of-the-art models, consistent cross-lingual performance gaps, and heuristic “guessing” behaviors that bypass rigorous reasoning—underscoring the value of our dual-paradigm approach.

Our analyses also suggest several actionable research directions: (1) OlymMATH-LEAN enables future development of process-level reward models that leverage formal proofs as ground-truth labels for reasoning rigor, potentially penalizing unjustified heuristic shortcuts during reinforcement learning training; and (2) our 582k released trajectories and OlymMATH-demo tool (Appendix A.1) support community-driven analysis of reasoning patterns without requiring new model evaluations. By releasing these resources alongside visualization tools and expert solutions, we aim to advance mathematical reasoning research and push the boundaries of language intelligence.

## Limitations

Our work has several limitations that suggest directions for future research. First, while we provide bilingual evaluation covering both English and Chinese, the reasoning capabilities of LLMs in other languages remain unexplored. Extending OlymMATH to additional languages would enable more comprehensive assessment of multilingual mathematical reasoning. Second, our current benchmark focuses exclusively on text-based problems, with geometry problems reformulated into natural language descriptions. Incorporating problems that retain original diagrams and figures would enable evaluation of multimodal vision-language models, offering a more complete picture of mathematical reasoning capabilities across different input modalities. Third, although we identify “guessing” behaviors through qualitative case studies, precisely quantifying the proportion of such heuristic shortcuts in natural language evaluation remains an open challenge. While OlymMATH-LEAN provides rigorous process-level verification through formal theorem proving, developing scalable metrics to detect reasoning shortcuts in natural language settings is an important direction we leave for future work. Fourth, while our methodology significantly delays contamination compared to web-sourced benchmarks (Table 2), no static benchmark can permanently avoid data leakage once publicly released. To address this, our open-source infrastructure, including the Lean formalization agent (Appendix A.2) and the visualization tool, establishes a reusable framework that supports periodic refresh with new problems from similar printed sources, extending the benchmark’s utility beyond any single release.