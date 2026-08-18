---
title: "MATH-Perturb: Benchmarking LLMs’ Math Reasoning Abilities against Hard Perturbations"
source: "https://arxiv.org/html/2502.06453v2"
author:
published:
created: 2026-06-23
description:
tags:
  - "clippings"
---
Kaixuan Huang    Jiacheng Guo    Zihao Li    Xiang Ji    Jiawei Ge    Wenzhe Li    Yingqing Guo    Tianle Cai    Hui Yuan    Runzhe Wang    Yue Wu    Ming Yin    Shange Tang    Yangsibo Huang    Chi Jin    Xinyun Chen    Chiyuan Zhang    Mengdi Wang

###### Abstract

Large language models have demonstrated impressive performance on challenging mathematical reasoning tasks, which has triggered the discussion of whether the performance is achieved by true reasoning capability or memorization. To investigate this question, prior work has constructed mathematical benchmarks when questions undergo simple perturbations – modifications that still preserve the underlying reasoning patterns of the solutions. However, no work has explored hard perturbations, which fundamentally change the nature of the problem so that the original solution steps do not apply. To bridge the gap, we construct MATH-P-Simple and MATH-P-Hard via simple perturbation and hard perturbation, respectively. Each consists of 279 perturbed math problems derived from level-5 (hardest) problems in the MATH dataset [^20]. We observe significant performance drops on MATH-P-Hard across various models, including o1-mini ($-16.49$ %) and gemini-2.0-flash-thinking ($-12.9$ %). We also raise concerns about a novel form of memorization where models blindly apply learned problem-solving skills without assessing their applicability to modified contexts. This issue is amplified when using original problems for in-context learning. We call for research efforts to address this challenge, which is critical for developing more robust and reliable reasoning models.

Machine Learning, LLM

## 1 Introduction

![Refer to caption](https://arxiv.org/html/2502.06453v2/x1.png)

Figure 1: Left: The overview of MATH-Perturb Benchmark. Right: An example of the original problem, its simple perturbation, its hard perturbation, and the corresponding model responses that overfit the short-cut solution. The simple perturbation to the problem is non-essential, so the modified problem can be solved using the same method as the original problem. The hard perturbation changes the problem fundamentally and it requires more difficult problem-solving skills. The shortcut solution can solve the original problem and its simple perturbation but fails on the hard perturbation.

Large language models (LLMs) have achieved remarkable progress in solving many previously challenging tasks and demonstrating signs of general intelligence [^7]. As LLMs become more intelligent, the research community responds by developing and adopting new benchmarks to guide the development of better models [^47] [^61] [^30] [^36] [^53].

In mathematical reasoning, the field has progressed from simpler datasets like SVAMP [^35] and GSM8K [^12] to more challenging benchmarks such as MATH [^20], OlympiadBench [^19], and AIME problems. Models continue to strike higher performance on these advanced benchmarks through stronger architectures, novel training approaches, and better training data [^34] [^54] [^38] [^14].

Nevertheless, concerns about data contamination and out-of-distribution generalization remain. Model performance can be artificially high if variants of the evaluation set leak into the training datasets or if its distribution is over-represented. In these cases, the model could be merely doing pattern recognition and memorizing the solution steps without understanding the underlying rationale, making it vulnerable to perturbations of the problem formulation [^59] [^41].

Several works have been proposed to quantify the robustness of reasoning models against such perturbations [^39] [^31] [^59] [^41] [^18] [^62]. Notably, [^41] created Functional-MATH by manually rewriting the original problems in the MATH benchmark [^20] into problem templates, where the numerical values in the problem statements and the corresponding answers can be varied automatically to generate infinitely-many versions that use the same math problem-solving skills. They observed performance drops between the modified benchmark and the original benchmark for several state-of-the-art language models, indicating that those models are indeed biased towards the original configurations of numerical values due to some form of data contamination. However, most existing work focuses on perturbing non-critical parameters (e.g., numerical values) that do not alter the fundamental reasoning patterns required to solve the problem. We refer to such changes as simple perturbations. While prior studies have shown that LLMs can generalize across a range of problem variants by relying on bag-of-heuristics reasoning [^33] [^23], this form of generalization does not necessarily reflect a true understanding of the underlying principles. As a result, models may still fail when faced with a substantial shift in reasoning patterns.

In this work, we take one step forward beyond simple perturbations. We consider hard perturbations: while at lexical level (e.g. edit distance) the modification is similar to simple perturbations, we ensure to change the problem formulations fundamentally so that the original solution paths are no longer applicable to the perturbed settings; see Figure 1 for a comparison between the two types of perturbations. A genuinely robust reasoning model that understands the underlying rationales should not only solve the modified problems under simple perturbations but also be able to judge whether the problem formulations change in a way that fundamentally alters the problems and respond accordingly, instead of applying the learned skills indiscriminately.

As the capabilities of large language models continue to advance and the average-case performance continue to improve, the generalization abilities against hard perturbations may soon become the primary bottleneck in their real-world usages. Addressing this challenge will be critical for advancing the robustness and reliability of future LLMs.

We summarize our contributions and key findings below:

![Refer to caption](https://arxiv.org/html/2502.06453v2/x3.png)

Figure 2: Performance on MATH-P-Simple, MATH-P-Hard, and the corresponding Original problems. We observe performance degradations across all models on.

## 2 Dataset Curation

![Refer to caption](https://arxiv.org/html/2502.06453v2/x4.png)

Figure 3: Illustration of the annotation process for MATH-P-Simple and MATH-P-Hard.

Origin of the Dataset. We choose the popular MATH benchmark [^20], which contains challenging mathematical reasoning problems sourced from American high school mathematics competitions such as the AMC 10, AMC 12, and AIME. Each problem belongs to one of the 7 subjects: Prealgebra, Algebra, Number Theory, Counting and Probability, Geometry, Intermediate Algebra, and Precalculus. Besides, each problem is labeled with a difficulty level of 1 (easiest) to 5 (hardest). The problems may contain LaTeX and Asymptote graphics language for describing mathematical concepts and geometric figures.

As the state-of-the-art reasoning models can already solve MATH problems with overall accuracies higher than 90% [^34] [^42] [^14], we opt to focus only on the hardest level-5 problems in our work, and create new benchmarks from these level-5 problems. We use level-5 problems from both the train split and the test split as the seed problems, so we are able to investigate whether language models behave differently on the two splits.

Annotation Criterion. For each problem, we modify the problem to create two variations:

(1) for MATH-P-Simple, we make simple perturbations, i.e., non-essential modifications to the problem, ensuring that the modified problem can be solved using the same method as the original problem.

(2) for MATH-P-Hard, we make hard perturbations, i.e., small but fundamental modifications to the problem so that the modified problem *cannot* be solved using the same method as the original problem. Instead, it requires deeper math understanding and harder problem-solving skills.

Besides, we ensure the following two additional requirements:

- Minimal Edits: To test the generalization of the reasoning models and elicit potential memorization behaviors, we ask the annotators to make as minimal modifications as possible. Therefore, the modified problems stay close to the original problems in the text form.
- Changed Answers: For both of the modifications, we guarantee that the answers to the modified problems are different from the original answer. Therefore, models cannot cheat by pattern recognition and outputting memorized solutions.

Quality Control. We recruited 12 annotators (PhD students) with strong mathematical backgrounds for the annotation task. All the annotators hold a bachelor’s degree in mathematics, have done researches in theoretical machine learning, and/or competed in mathematical competitions during high school.

To ensure the quality of the benchmark, all the annotators are required to double-check their annotations. Each modified problem is also cross-validated by an independent annotator to make sure the answer is correct.

Additionally, we manually went through all the problems where the o1-mini’s answer and the annotated answer differ and confirmed that the annotated answers are correct.

Benchmark Overview and Statistics.

After removing several annotations that failed the quality checks, we obtained 279 pairs of modifications, where 164 examples are from train split and 115 examples are from test split. The numbers of problems in each of the 7 subjects are listed in Table 3. Figure 1 shows one example of our benchmark.

To quantify how similar the original problem and the modified problem are, first, we calculate the edit distance between the modified problem and the original problem, normalized by the length of the original problem. Besides, we compute the cosine similarities between the embeddings of the two problems, where we use OpenAI’s text-embedding-3-large embedding model. The distributions of the normalized edit distance and the cosine similarities are shown in Figure 4.

![Refer to caption](https://arxiv.org/html/2502.06453v2/x5.png)

Figure 4: The distributions of edit distances and cosine similarities of embeddings between the perturbed problems and the original problems. The edit distances are normalized by the lengths of the original problems. The embedding model is OpenAI’s text-embedding-3-large.

We also calculate the Mean Reciprocal Ranks (MRRs) when using the perturbed problem as the query to retrieve the corresponding original problem from the set of all 279 original problems, with the cosine similarities of embeddings being the ranking method. The MRRs of the MATH-P-Simple problems and MATH-P-Hard problems are 0.995 and 0.986, respectively, indicating that the corresponding original problem and solution are likely to be retrieved using typical semantic-based retrieval methods.

Common Strategies for Perturbations.

For MATH-P-Simple, most of the problems are modified numerically without making the problems fundamentally different. Our annotators have checked these numerical modifications are non-essential to the problems, so the modified problems can be solved with the same reasoning patterns. Besides, our annotators also adopt other types of changes. For example, asking for a different but related quantity, adding/removing non-essential constraints, and changing a mathematical concept to its contrasting counterpart.

For MATH-P-Hard, the modification strategies are more diverse and problem-specific. A general strategy is to increase the complexity of the mathematical objects involved. For example, raising the degrees of polynomials will make them harder to solve or factorize. Altering key numbers to large values can make brute-force solutions infeasible. Instead, solving the problem requires deriving general formulas or applying deeper theorems rather than relying on computational shortcuts. Other common strategies include relaxing constraints to cover more general cases, changing essential conditions so the original simplifying properties (e.g. symmetry, reducibility, linearity) no longer hold.

## 3 Experimental Results

Table 1: Zero-shot CoT performance of the LLMs (accuracy, %). Original refers to the set of 279 unmodified problems. For the train and test columns, we report the accuracies for problems that originate from the train split and test split, respectively.

<table><tbody><tr><th rowspan="2">Model</th><td colspan="3">Original</td><td colspan="3">MATH-P-Simple</td><td colspan="3">MATH-P-Hard</td></tr><tr><td>All</td><td>train</td><td>test</td><td>All</td><td>train</td><td>test</td><td>All</td><td>train</td><td>test</td></tr><tr><th>Gemini-2.0-flash-thinking-exp</th><td>92.47</td><td>92.68</td><td>92.17</td><td>91.04</td><td>87.80</td><td>95.65</td><td>78.14</td><td>77.44</td><td>79.13</td></tr><tr><th>o1-preview</th><td>87.81</td><td>88.41</td><td>86.96</td><td>87.81</td><td>87.80</td><td>87.83</td><td>72.40</td><td>73.78</td><td>70.43</td></tr><tr><th>o1-mini</th><td>94.27</td><td>93.90</td><td>94.78</td><td>94.98</td><td>93.29</td><td>97.39</td><td>78.49</td><td>79.27</td><td>77.39</td></tr><tr><th>Gemini-2.0-flash-exp</th><td>88.17</td><td>87.20</td><td>89.57</td><td>82.80</td><td>81.71</td><td>84.35</td><td>67.03</td><td>68.29</td><td>65.22</td></tr><tr><th>Gemini-1.5-pro</th><td>77.78</td><td>77.44</td><td>78.26</td><td>77.42</td><td>76.83</td><td>78.26</td><td>56.63</td><td>56.10</td><td>57.39</td></tr><tr><th>GPT-4o</th><td>67.03</td><td>68.90</td><td>64.35</td><td>62.01</td><td>60.98</td><td>63.48</td><td>39.43</td><td>37.80</td><td>41.74</td></tr><tr><th>GPT-4-turbo</th><td>56.99</td><td>55.49</td><td>59.13</td><td>55.20</td><td>56.71</td><td>53.04</td><td>34.41</td><td>36.59</td><td>31.30</td></tr><tr><th>Claude-3.5-Sonnet</th><td>64.52</td><td>62.80</td><td>66.96</td><td>58.42</td><td>57.32</td><td>60.00</td><td>38.71</td><td>38.41</td><td>39.13</td></tr><tr><th>Claude-3-Opus</th><td>41.94</td><td>39.02</td><td>46.09</td><td>41.94</td><td>39.63</td><td>45.22</td><td>26.52</td><td>25.00</td><td>28.70</td></tr><tr><th>Llama-3.1-8B-Instruct</th><td>36.56</td><td>45.12</td><td>24.35</td><td>31.54</td><td>35.37</td><td>26.09</td><td>10.04</td><td>10.98</td><td>8.70</td></tr><tr><th>Gemma-2-9b-it</th><td>27.60</td><td>28.05</td><td>26.96</td><td>27.60</td><td>30.49</td><td>23.48</td><td>11.83</td><td>12.80</td><td>10.43</td></tr><tr><th>Phi-3.5-mini-instruct</th><td>26.16</td><td>27.44</td><td>24.35</td><td>28.67</td><td>26.83</td><td>31.30</td><td>14.34</td><td>15.24</td><td>13.04</td></tr><tr><th>Deepseek-math-7b-rl</th><td>37.28</td><td>42.68</td><td>29.57</td><td>33.33</td><td>35.37</td><td>30.43</td><td>13.62</td><td>15.85</td><td>10.43</td></tr><tr><th>Qwen2.5-Math-7B-Instruct</th><td>58.78</td><td>59.15</td><td>58.26</td><td>51.61</td><td>50.00</td><td>53.91</td><td>27.24</td><td>29.88</td><td>23.48</td></tr><tr><th>Mathstral-7b-v0.1</th><td>36.56</td><td>43.29</td><td>26.96</td><td>36.20</td><td>42.07</td><td>27.83</td><td>14.70</td><td>16.46</td><td>12.17</td></tr><tr><th>NuminaMath-7B-CoT</th><td>43.73</td><td>51.22</td><td>33.04</td><td>40.14</td><td>44.51</td><td>33.91</td><td>17.20</td><td>18.90</td><td>14.78</td></tr><tr><th>MetaMath-13B-V1.0</th><td>21.15</td><td>32.32</td><td>5.22</td><td>7.53</td><td>7.32</td><td>7.83</td><td>5.73</td><td>4.88</td><td>6.96</td></tr><tr><th>MAmmoTH2-8B</th><td>12.90</td><td>11.59</td><td>14.78</td><td>17.92</td><td>17.07</td><td>19.13</td><td>7.53</td><td>10.37</td><td>3.48</td></tr></tbody></table>

Evaluation Setting. We adopt zero-shot chain-of-thought (CoT) [^49] [^25] as the standard evaluation method on our benchmarks. For comparison, we also evaluate the models on the set of the original 279 problems, referred to as Original in the following subsections. We do not allow any tool usage including access to a code interpreter, as we find that many problems can be trivially solved by writing a brute-force search program.

To check whether the generated answer matches the ground-truth answer, we adopt an equivalence checker following [^20] [^38], which first performs string normalization and then uses sympy package to check the equivalence of two mathematical objects.

### 3.1 Benchmarking the performance of LLMs

We consider a wide range of language models including long-CoT models, closed-sourced large models, open-sourced small models, and math-specific models. The version information of the models is deferred to Appendix A.

In Table 1, we report the overall accuracies of the LLMs on Original, MATH-P-Simple, and MATH-P-Hard, and also separately calculate the accuracies for problems that originate from the train split and test split. As expected, for all the models we evaluate, we find that the performance on MATH-P-Hard is significantly lower than the original problems, which indicates MATH-P-Hard is more difficult.

In the meantime, most models also suffer a slight performance drop on MATH-P-Simple compared to the original problems. We note that the performance drops mainly come from the train split. Generalization errors still exist for the state-of-the-art models even when the test examples follow the exact same reasoning patterns as the training problems.

For problems that originate from the test split, ideally, both the original problem and its MATH-P-Simple modification should be equally “unseen” to the model. We observe mixed results empirically from Table 1: for gemini-2.0-flash-exp, GPT-4-turbo, claude-3.5-sonnet, the performance drops are larger than 5%, while surprisingly the performance of Phi-3.5-mini-instruct increases. For most of the models we evaluated, the accuracies on MATH-P-Simple test split are close to the accuracies on the original test split. We commend that while [^41] found a relatively 58% to 80% performance drop between their modified benchmark and the original MATH benchmark among a different set of the models (the best model they tested was GPT-4), we did not observe such huge gaps for the models we evaluate, which is a sign of the progress in the robustness of the newly developed models against simple perturbations.

Inference-time Scaling. Scaling inference-time computes has been shown to be able to boost the performance of LLMs [^46] [^5] [^50] [^13] [^29]. We defer the study of inference-time scaling on our benchmarks to Section C.5.

### 3.2 Failure Mode Analysis
**Figure omitted after export**

Figure 5: An example of memorization coupled with incorrect reasoning: The model incorrectly reduces the modified condition to the original condition, and then follows the original reasoning pattern. The correct answer is $\boxed{\nicefrac{{1}}{{36}}}$. We manually performed 20 repeated trials and found that Claude-3.5-Sonnet has a pass rate of 50%. Among the mistakes, 30% are due to the memorization issue above.
**Figure omitted after export**


Figure 6: An example of memorizing the desired outcome. The model outputs all integer values instead of the smallest integer value. The correct answer is $\boxed{10}$. We manually performed 20 repeated trials and found that o1-mini has a pass rate of 75%. All the 25% errors are due to this specific memorization issue above.

To study the generalization abilities of models against hard perturbations, we focus on the set of problems where the models fail on the MATH-P-Hard modification but correctly solve either the original problem or the MATH-P-Simple modification, which accounts for 20%-47% of the total problems. For these problems, one can use the correct solutions to the easier problems as a reference to better determine the failure modes on the hard problems. We defer the discussion on the other cases to Appendix C.1.

First, we observe general failure modes when models are exposed to harder problems, including making mistakes in basic numerical computations and algebraic operations, making unjustified claims, missing several cases, and lacking certain math knowledge. These types of errors are more prominent in weaker models.

Besides general failure modes, when we compare the wrong solution to the MATH-P-Hard modification with the solutions to the easier versions, we are able to recognize an adequate number of memorization issues. Specifically, we found that models may ignore the modified assumptions and presume that the original assumptions still hold; see Figure 5 for an example. In other cases, the models may blindly apply the techniques for the original problems without first determining whether these techniques are still suitable in the modified setting (the responses in Figure 1 are such an example generated by GPT-4o). Interestingly, the models may even output the desired outcome of the original problem (not provided in the context) instead of the modified problem, e.g. Figure 6. This kind of memorization behavior is difficult to capture with most existing type of perturbations in the literature (similar to our MATH-P-Simple) that does not require different solving strategies.

These issues are often coupled with other types of errors and pervasive among the models we evaluated. For large models, we estimate the percentages of errors caused by memorization to be 40% for o1-mini and 25%

![[Uncaptioned image]](https://arxiv.org/html/2502.06453v2/x9.png)

\[Uncaptioned image\]

for Claude-3.5-Sonnet, via manual inspections of 20 error cases. The general failure modes due to insufficient capabilities are largely reduced for stronger models, making the memorization issues more prominent. As the capabilities of language models continue to advance, we expect the memorization issues will be the next bottleneck of reasoning models, and we urge more studies on investigating the generalization abilities of reasoning models against hard perturbations.

### 3.3 Is Mode Collapse a Problem?

We investigate whether the model makes errors due to mode collapse, which means the model fails to identify the difference between the perturbed problem and the original problem (seen during its training time) and the model’s response collapses to the response to the original problem with the identical answer.

For each model, we report $n_{\text{same}}$, the number of problems where the model’s final answer coincides with the ground-truth answer of the corresponding original problem. For those responses, we also compute the edit distance between the full response to the modified problem and the full response to the original problem. The full result is deferred to Table 5 in the appendix.

We see that this type of failure mode accounts for less than 10% of the total errors except for three models (gemini-2.0-flash-thinking-exp, o1-mini, and gemini-2.0-flash-exp) on MATH-P-Hard. After manual inspection, we find that except for only 1 problem pair where gemma-2-9b-it generates the identical answer for the original problem and the modified problem, we do not see collapses of the outputs in the superficial text form. Therefore, we conclude that naive recitation of the training material is not the major reason for producing the same answers. Instead, the model’s responses to the modified problems often collapse to the responses to the original problems in more subtle manners, e.g. ignoring or failing to understand the modified assumptions; see Figure 5 for an example.

### 3.4 Does In-context Learning Help or Hurt?

![Refer to caption](https://arxiv.org/html/2502.06453v2/x11.png)

Figure 7: The error rates (%) of the models without and with the original problem and solution as the in-context learning (ICL) example. For MATH-P-Hard, we decompose the influences of in-context learning into ICL effect (the down arrow ↓ bold-↓ {\\color\[rgb\]{.75,.5,.25}\\definecolor\[named\]{pgfstrokecolor}{rgb}{.75,.5,.25}% \\boldsymbol{\\downarrow}} bold\_↓ ), which reduces the error rates, and misleading effect (the up arrow ↑ bold-↑ {\\color\[rgb\]{.75,.5,.25}\\definecolor\[named\]{pgfstrokecolor}{rgb}{.75,.5,.25}% \\boldsymbol{\\uparrow}} bold\_↑ ), which increases the error rates.

In this subsection, we investigate whether using the corresponding original unmodified problem and solution as the one-shot in-context learning (ICL) example will help with the modified problems in MATH-P-Simple and MATH-P-Hard. We visualize the influences of ICL for three models in Figure 7 and defer the full result to Table 6.

As expected, using the original (problem, solution) pair as a one-shot in-context demonstration boosts the performance of nearly all the models on MATH-P-Simple, which should be solvable by simply applying the original solution steps to the modified setting.

As for the MATH-P-Hard modifications, there are two factors that need to be considered: (1) ICL effect: the original solutions may supply the model with desired mathematical knowledge that is also helpful for solving the modified problems; (2) misleading effect: on the other hand, as there are subtle differences between the original problems and the MATH-P-Hard modifications, the models may fail to recognize such differences and be misled by the demonstrated solutions. Accordingly, in Table 7 and Figure 7, and we calculate and visualize (1) $n_{\text{wrong}\to\text{correct}}$, the number of problems that initially the model fails on without the in-context demonstrations but answers correctly with the in-context demonstrations, and (2) $n_{\text{correct}\to\text{wrong}}$, the number of problems that initially the model answers correctly without demonstrations but fails on with demonstrations.

We observe that many MATH-P-Hard problems become solvable with the original problems and solutions as demonstrations. The percentages to the number of total errors without demonstrations are larger for closed-sourced large models (24%-40%) and smaller for open-sourced small models (2%-15%), due to their differences in mathematical capabilities and in-context learning capabilities. However, we also observe many MATH-P-Hard problems become incorrect with demonstrations, and the percentages are higher for large models (18%-40%) than small models (4%-15%). The misleading effect counteracts the effect of in-context learning, leaving only marginal improvements (less than 5%) on the MATH-P-Hard for most models.

As in-context learning can be viewed as a form of (test-time) training, we hypothesize that any naive fine-tuning technique with a limited distribution of problem settings will hurt the generalization of the language models against hard perturbations.

## 4 Related Work

Perturbations to Existing Mathematical Benchmarks. There is a considerable amount of work focusing on performing perturbations to existing mathematical benchmarks. [^39] built GSM-IC from GSM8K [^13] by adding irrelevant context to the problem. GSM-Plus [^28] creates 8 types of variations to each of the GSM8K problem and ensure that the perturbed problem is of the same difficulty. [^31] built GSM-Symbolic that alters the numerical values and entity names via symbolic templates of both the problems and the solution steps. Similarly, Functional MATH [^41] is created from the MATH dataset [^20], and Putnam-AXIOM [^18] from the Putnam Mathematical Competition.

This line of work performed simple perturbations to existing mathematical benchmarks and the perturbed problems can be solved with the same solution steps and the same reasoning pattern as the original ones. In contrast, we performed hard perturbations to curate MATH-P-Hard, where the original reasoning pattern does not apply.

Memorization. Memorization is a well-studied phenomenon in machine learning [^17] [^57] [^16] and has become increasingly prevalent in large language models, due to the growing of the pretraining corpora and the scaling of the model sizes. Verbatim memorization, i.e., recitation of the training material, has significant potential consequences ranging from privacy violations [^9] [^6] [^22] and copyright infringement [^40] [^24] [^48] [^11] to training data security risks [^8] [^32]. Prior work has investigated various factors influencing verbatim memorization, including sequence duplicates [^26] [^21], model size [^45], and sequence position [^4].

In contrast, we investigate the effect of memorization within the mathematical reasoning context. Our methodology falls into the category of counterfactual tests [^58] [^51] [^60] [^52], where we construct perturbed problems different from the existing ones to test the generalization of LLMs and examine memorization effects. Through extensive case studies, we find that LLMs can exhibit subtle forms of memorization beyond naive verbatim memorization.

Comparison with MATH <sup>2</sup> [^37]. [^37] created MATH <sup>2</sup> by combining random pairs of skills extracted from MATH [^20] to generate harder problems that require both skills to solve. Their benchmark is mathematically harder, but there are no natural “original problems” as references. Therefore, MATH <sup>2</sup> is not directly suitable for investigating the memorization effects of language models. In comparison, our MATH-P-Hard are modified directly from the problems in MATH so that the modified problems require harder skills to solve. MATH-P-Hard can serve as both a harder math benchmark and a testbed to investigate memorizations of LLMs.

## 5 Conclusion

In this work, we study the generalization of large language models’ math reasoning abilities against hard perturbations of the problems. We modified 279 problems from the level-5 problems of the MATH dataset [^20] into MATH-P-Simple (used for control experiments) and MATH-P-Hard, via simple perturbations and hard perturbations, respectively. We found performance degradations of all models on MATH-P-Hard, and many of the errors can be traced to a new form of memorization, where the model memorizes the problem-solving techniques from the training set and blindly applies them without judging whether the modified settings are still suitable. Using the original unmodified problem and solution for in-context learning can deteriorate this issue. We expect the generalization against hard perturbations to be the next major bottleneck of LLMs’ reasoning abilities and urge future work in this direction.