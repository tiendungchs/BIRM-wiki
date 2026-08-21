---
title: "GSM-Plus: A Comprehensive Benchmark for Evaluating the Robustness of LLMs as Mathematical Problem Solvers"
source: "https://arxiv.org/html/2402.19255v2"
author:
published:
created: 2026-06-23
description:
tags:
  - "clippings"
---
Qintong Li <sup>1</sup>  Leyang Cui <sup>2</sup>  Xueliang Zhao <sup>1 <math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="*"><semantics><mo>∗</mo> <annotation>*</annotation> <annotation>∗</annotation></semantics></math></sup>  Lingpeng Kong <sup>1</sup>  Wei Bi <sup>2</sup> <sup>†</sup>  
<sup>1</sup> The University of Hong Kong   <sup>2</sup> Tencent AI Lab  
{qtli,xlzhao,lpk}@cs.hku.hk  
nealcly.nlp@gmail.com  
victoriabi@tencent.com  
[qtli.github.io/GSM-Plus/](https://qtli.github.io/GSM-Plus/) Work done during an internship at Tencent AI Lab. Corresponding authors.

###### Abstract

Large language models (LLMs) have achieved impressive performance across various mathematical reasoning benchmarks. However, there are increasing debates regarding whether these models truly understand and apply mathematical knowledge or merely rely on shortcuts for mathematical reasoning. One essential and frequently occurring evidence is that when the math questions are slightly changed, LLMs can behave incorrectly. This motivates us to evaluate the robustness of LLMs’ math reasoning capability by testing a wide range of question variations. We introduce the adversarial grade school math (GSM-Plus) dataset, an extension of GSM8K augmented with various mathematical perturbations. Our experiments on 25 LLMs and 4 prompting techniques show that while LLMs exhibit different levels of math reasoning abilities, their performances are far from robust. In particular, even for problems that have been solved in GSM8K, LLMs can make mistakes when new statements are added or the question targets are altered. We also explore whether more robust performance can be achieved by composing existing prompting methods, in which we try an iterative method that generates and verifies each intermediate thought based on its reasoning goal and calculation result.

GSM-Plus: A Comprehensive Benchmark for Evaluating the Robustness of LLMs as Mathematical Problem Solvers

Qintong Li <sup>1</sup> <sup>†</sup>  Leyang Cui <sup>2</sup>  Xueliang Zhao <sup>1 <math xmlns="http://www.w3.org/1998/Math/MathML" display="inline" data-latex="*"><semantics><mo>∗</mo> <annotation>*</annotation> <annotation>∗</annotation></semantics></math></sup>  Lingpeng Kong <sup>1</sup> <sup>†</sup>  Wei Bi <sup>2</sup> <sup>†</sup> <sup>1</sup> The University of Hong Kong   <sup>2</sup> Tencent AI Lab {qtli,xlzhao,lpk}@cs.hku.hk nealcly.nlp@gmail.com victoriabi@tencent.com [qtli.github.io/GSM-Plus/](https://qtli.github.io/GSM-Plus/)

## 1 Introduction

Mathematical reasoning stands as a crucial testament to the development of artificial intelligence [^23]. It requires rigorous problem understanding, strategy formulating, and calculation performing abilities [^3] [^42]. Large language models (LLMs) [^5] [^40] have demonstrated strong performance on various mathematical benchmarks including grade school math GSM8K [^11], high school math MATH [^17], and college math Theoremqa [^9]. Regarding the widely-used GSM8K benchmark, proprietary models like GPT-4 and cutting-edge open-source models have reported accuracy rates exceeding 90% and 80%, respectively. However, the debate within the research community regarding whether these models truly understand and apply mathematical knowledge or merely solve math word problems based on superficial patterns [^35] or even due to training data leakage [^15] has never ceased. Apparent evidence supports such concerns. Figure 1 shows an example case of GPT-3.5-turbo performing multiple-step reasoning on the GSM8K dataset, where LLMs sometimes make simple errors that humans would not [^57] [^39]. Simply due to the fact that GPT-3.5-turbo struggles with distinguishing the directions of “leave” and “return”, resulting in the misuse of an operator.

![Refer to caption](https://arxiv.org/html/2402.19255v2/x1.png)

Figure 1: Comparing the answers of GPT-3.5-Turbo to a math word question and its variation with additional constraints, the former answer is correct, while the latter answer is incorrect ( red ) due to the misuse of operators.

| Grade School Math Dataset | Parent Set | Size | Answer Format | Annotation | Perturbation |
| --- | --- | --- | --- | --- | --- |
| ASDiv-A [^30] | N/A | 2,305 | Equation-formed | Human (A.) | N/A |
| GSM8K [^11] | N/A | 1,319 | Open-formed | Human (Q.,A.) | N/A |
| SVAMP [^35] ✯ | ASDiv-A | 1,000 | Equation-formed | Human (Q.,A.) |  |
| MetaMathQA [^50] | GSM8K, MATH | 240K | Open-formed | GPT-3.5-Turbo |  |
| GSM-HARD [^14] | GSM8K | 1,319 | Program-formed | Codex (Q.A.), Human (A.) |  |
| GSM-IC [^39] ✯ | GSM8K | 58,052 | Open-formed | Human (Q.) |  |
| GSM8k\_robust [^10] ✯ | GSM8K | 1,319 | Open-formed | GPT-4 |  |
| GSM-Plus (Our) ✯ | GSM8K | 10,552 | Open-formed | GPT4, Human (Q.,A.) |  |

Table 1: Overview of the grade school math datasets. ✯refers to datasets specifically designed to evaluate the robustness of model performance. Different colors represent different perturbation types: umerical Substitution; igit Expansion; integer-decimal-fraction Conversion; dding Operation; eversing Operation; roblem Understanding; istractor Insertion; ritical Thinking.

In response to these issues, we advocate for a more rigorous and adversarial evaluation benchmark that can systematically study the math reasoning capability of LLMs. Our benchmark revealed a gap of up to 20% between the accuracy reported by the current model and the accuracy observed in our setting, while human performance remains unaffected due to the unchanged inherent difficulty level of the questions. In this work, we perturb the most popularly used GSM8K dataset, yielding an adversarial dataset for grade school math GSM-Plus. Motivated by the capability taxonomy for solving math problems mentioned in Polya’s principles [^36], we identify 5 perspectives to guide the development of GSM-Plus: (1) numerical variation refers to altering the numerical data or its types (e.g., from integer to decimal). (2) arithmetic variation refers to reversing or introducing additional operations, such as addition, subtraction, multiplication, and division, to math problems. (3) problem understanding refers to rephrasing the text description of the math problems. (4) distractor insertion refers to inserting topic-related but useless sentences to the problems. (5) critical thinking focuses on question or doubt ability when the question lacks necessary statements. Based on the 1,319 test questions from GSM8K, we create eight variations for each question, the yielding GSM-Plus comprises 10,552 question variations. By testing LLMs using each question and its eight variations, GSM-Plus can facilitate the holistic evaluation of LLMs’ robustness in solving math word problems.

We use GSM-Plus to evaluate the robustness of 25 LLMs with different model scales and task-specific fine-tuning, along with 4 popular prompting techniques to obtain LLMs’ math reasoning results. Overall, we find that LLMs can accurately solve the GSM8K questions while struggling with answering the variations in GSM-Plus. Our detailed findings are in three folds:

Based on the endeavors and results of this work, we urge further research on LLMs in math domains to enhance not only their performance for math reasoning but also their performance robustness.

## 2 Related Work

<table><tbody><tr><td colspan="3">Seed Question: Janet’s ducks lay 16 eggs per day. She eats three for breakfast every morning and bakes muffins for her friends every day with four. She sells the remainder at the farmers’ market daily for $2 per fresh duck egg. How much in dollars does she make every day at the farmers’ market?</td></tr><tr><td colspan="3">Solution: Janet sells 16 - 3 - 4 = 9 duck eggs a day. She makes 9 * 2 = 18 every day at the farmer’s market. Answer: 18</td></tr><tr><td colspan="2">Perturbation Category</td><td>Question Variation</td></tr><tr><td rowspan="3">Numerical Variation</td><td>Num. Sub.</td><td>16 → 20  three → five  four → six  2 → 3</td></tr><tr><td>Digit Exp.</td><td>16 → 1600  four → 400</td></tr><tr><td>IDF Conv.</td><td>three → 1/4  2 → 2.5</td></tr><tr><td rowspan="2">Arithmetic Variation</td><td>Add. Op.</td><td>Janet’s ducks lay <math><semantics><mi>…</mi> <ci>…</ci> <annotation>\ldots</annotation> <annotation>…</annotation></semantics></math> every day with four. She also uses two eggs to make a homemade hair mask every day. She sells <math><semantics><mi>…</mi> <ci>…</ci> <annotation>\ldots</annotation> <annotation>…</annotation></semantics></math> make every day at the farmers’ market?</td></tr><tr><td rowspan="3">Rev. Op.</td><td>Janet’s ducks lay 16 eggs per day. She eats three <math><semantics><mi>…</mi> <ci>…</ci> <annotation>\ldots</annotation> <annotation>…</annotation></semantics></math> with four. She sells the remainder at the farmers’ market daily for a certain amount per fresh duck egg. She makes $18 every day at the farmers’ market. How much does each duck egg cost?</td></tr><tr><td colspan="2">Problem Understanding</td><td>Janet’s ducks lay 16 eggs daily. She eats three for breakfast and uses four to bake muffins for her friends. She sells the remaining eggs at the local farmers’ market for $2 per fresh duck egg. How much money does she make each day by selling eggs at the farmers’ market?</td></tr><tr><td colspan="2">Distractor Insertion</td><td>Janet’s ducks <math><semantics><mi>…</mi> <ci>…</ci> <annotation>\ldots</annotation> <annotation>…</annotation></semantics></math> with four. She also uses two eggs to feed her pet parrot, but her neighbor gives her two eggs from his own ducks to replace them. She sells <math><semantics><mi>…</mi> <ci>…</ci> <annotation>\ldots</annotation> <annotation>…</annotation></semantics></math> at the farmers’ market?</td></tr><tr><td colspan="2">Critical Thinking</td><td>Janet’s ducks lay eggs per day. She eats three for breakfast every morning and <math><semantics><mi>…</mi> <ci>…</ci> <annotation>\ldots</annotation> <annotation>…</annotation></semantics></math> How much in dollars does she make every day at the farmers’ market?</td></tr></tbody></table>

Table 2: An example of question variations generated using 8 perturbations from 5 perspectives based on a seed math question. Modifications are marked in green.

Numerous datasets have been curated to assess the mathematical reasoning abilities of AI systems. Early math datasets [^22] [^27] focused on basic math problems with equation-based solutions. Subsequently, more difficult datasets have been introduced, spanning grade-school level [^11] [^31], high-school level [^17], and college-level datasets [^38] [^54]. Amid this progress, there has been a surge in the development of LLMs towards solving those math benchmarks [^1]. Despite the substantial difficulties posed by advanced-level math for LLMs, recent LLMs has shown huge potential for solving grade school math [^40].

Supervised fine-tuning (SFT) is a line of work to effectively adapt language models to mathematics domains [^28] [^2] [^26] [^16]. MetaMath [^50] highlights the efficacy of question bootstrapping, while MAmmoTH [^52] proved the benefits of training LLMs on various data sources and hybrid rationales.

Another trend improves LLMs’ math capabilities by prompting with carefully designed inputs [^49] [^48] [^55]. Chain-of-thought prompting guides models to generate natural language reasoning steps before reaching the final answer [^45] [^21]. Program-of-thought prompting generates programs as the intermediate steps and integrates external tools like a Python interpreter for precise calculation [^14] [^8]. The promising outcomes made by LLMs, especially in grade school math, motivate researchers to study whether they can maintain high performance in realistic settings [^6].

In this work, we aim to develop a consolidated benchmark that systematically examines the robustness of LLMs in solving math word problems. Recent work concerns the robustness of math reasoning using different perturbations, such as semantic substitution [^19] [^24] [^43] [^57], reversal prediction [^4] [^50], and irrelevant context distraction [^39] [^25]. However, as shown in Table 1, most existing evaluation settings only cover limited types of automatically constructed perturbations. In contrast, we create eight variations of a single question by perturbing it with eight different math reasoning skills. Using GSM-Plus, we conduct a systematic evaluation of the LLM’s robustness across various reasoning types. For most LLMs, GSM-Plus is a challenging benchmark, with GPT-3.5-Turbo reaching only 61.19% accuracy.

## 3 The GSM-Plus Dataset

To comprehensively evaluate the robustness of LLMs in utilizing math-related skills, we build an adversarial dataset GSM-Plus using the GSM8K dataset as a foundation. Inspired by Polya’s principles, we design eight types of perturbations from five different perspectives to test the robustness of LLMs in math reasoning, as depicted in Table 2.

### 3.1 Perturbation Categories

Numerical variation tests whether LLMs have been overfitted by altering the numerical data and seeing the prediction behaviors. We define three subcategories of numerical variation below:

- Numerical Substitution: replaces numerical data with another number that has the same number of digits, such as replacing “16” with “20”.
- Digit Expansion: increases the number of digits in a number, such as replacing “16” with “1600”.
- Integer-decimal-fraction Conversion: uses different representation types of numbers instead of only integers, e.g., converting “2” into “2.5”.

Arithmetic variation focuses on the models’ flexibility in applying arithmetic operations according to the question requirements. We define two subcategories of arithmetic variation as below:

- Adding Operation: increases seed question’s statements but restricts the operations in addition, subtraction, multiplication, and division.
- Reversing Operation: transforms a statement of the seed question into the queried answer in the generated variation. For example, the statement “$2 per fresh duck egg” in the seed question is transformed into the question sentence “How much does each duck egg cost?”.

Problem understanding rephrases the question to investigate the potential impact of question-wording on the model’s understanding.

Distractor insertion introduces topic-related but useless sentences with numbers to test models’ ability of statement evaluation.

Critical thinking requires that models can question or doubt during the process of mathematical reasoning, rather than mindless sycophancy [^46]. This means that a model should explicitly specify this issue if an essential statement is removed from the seed question.

Previous findings indicate that LLMs are typically robust to numerical variation [^6] and problem understanding [^57], but sensitive to distractor insertion [^47]. Other perturbations such as arithmetic variation and critical thinking remain underexplored in math domains due to annotation difficulties, but all of them are important for humans to solve problems. Our pilot experiments found that models struggle to perform well on these perturbations. Our work offers a comprehensive dataset and evaluation of the math reasoning robustness in fine-grained eight perturbations.

### 3.2 Dataset Construction

In previous work [^32] [^50], GPT-4 has been exclusively used to construct variations. We initially utilize GPT-4’s question-rewriting capabilities to generate question variations and then prompt it to generate answer candidates for these variations. However, we discover that GPT-4 is not always reliable: it may (i) fail to incorporate perturbations into the variations, e.g., for “distractor insertion”, the newly-added sentences affect the final answer, (ii) include additional changes beyond the specified perturbations, (iii) generate invalid questions, (iv) significantly increase questions’ difficulty, surpassing the grade school level, or (v) generate incorrect answers.

To ensure data quality, all question variations and answers produced by GPT-4 are further refined by human annotators through a rigorous process. Annotators are first required to annotate 24 variations as a qualifying exam to ensure the accuracy of their annotation. To further control annotation quality, the annotators are assigned workloads in batches, with each batch consisting of 50 seed questions. Prompt feedback is provided throughout the annotation process. Specifically, 10% of the variations were cross-annotated by at least 3 annotators with a high inter-annotation consistency rate of 90.02%, demonstrating the reliability of human revisions. Overall, human annotators revised 18.85% of the variations produced by GPT-4, highlighting the importance of human revision. Detailed statistics across perturbation types are presented in Table B.2 of the Appendix. Details of human annotation can be found in Appendix B.2.

![Refer to caption](https://arxiv.org/html/2402.19255v2/x2.png)

Table 3: Accuracy of GPT-4 on GSM8K seed questions, self-generated question variations, and human-corrected variants (i.e., GSM-Plus ).
