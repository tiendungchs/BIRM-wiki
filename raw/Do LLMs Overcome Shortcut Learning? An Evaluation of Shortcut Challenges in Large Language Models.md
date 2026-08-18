---
title: "Do LLMs Overcome Shortcut Learning? An Evaluation of Shortcut Challenges in Large Language Models"
source: "https://arxiv.org/html/2410.13343v1"
author:
published:
created: 2026-06-23
description:
tags:
  - "clippings"
---
Yu Yuan <sup>1</sup>, Lili Zhao <sup>1</sup>, Kai Zhang <sup>1,2</sup>, Guangting Zheng <sup>2</sup>, Qi Liu <sup>1</sup>  
<sup>1</sup> State Key Lab of Cognitive Intelligence, University of Science and Technology of China  
<sup>2</sup> School of Computer Science and Technology, University of Science and Technology of China  
{yyhappier,liliz,zgt}@mail.ustc.edu.cn  
{kkzhang08,qiliuql}@ustc.edu.cn Corresponding author.

###### Abstract

Large Language Models (LLMs) have shown remarkable capabilities in various natural language processing tasks. However, LLMs may rely on dataset biases as shortcuts for prediction, which can significantly impair their robustness and generalization capabilities. This paper presents Shortcut Suite, a comprehensive test suite designed to evaluate the impact of shortcuts on LLMs’ performance, incorporating six shortcut types, five evaluation metrics, and four prompting strategies. Our extensive experiments yield several key findings: 1) LLMs demonstrate varying reliance on shortcuts for downstream tasks, significantly impairing their performance. 2) Larger LLMs are more likely to utilize shortcuts under zero-shot and few-shot in-context learning prompts. 3) Chain-of-thought prompting notably reduces shortcut reliance and outperforms other prompting strategies, while few-shot prompts generally underperform compared to zero-shot prompts. 4) LLMs often exhibit overconfidence in their predictions, especially when dealing with datasets that contain shortcuts. 5) LLMs generally have a lower explanation quality in shortcut-laden datasets, with errors falling into three types: distraction, disguised comprehension, and logical fallacy. Our findings offer new insights for evaluating robustness and generalization in LLMs and suggest potential directions for mitigating the reliance on shortcuts. The code is available at [https://github.com/yyhappier/ShortcutSuite.git](https://github.com/yyhappier/ShortcutSuite.git).

## 1 Introduction

The field of Natural Language Processing (NLP) is experiencing rapid advancements, driven by the emergence of Large Language Models (LLMs) such as GPT [^18] [^1], Gemini [^24], and LLaMA [^25] series. These models have been pivotal in revolutionizing a wide array of tasks by leveraging techniques like In-Context Learning (ICL) [^2] and Chain-of-Thought (CoT) promptings [^26] [^11], demonstrating exceptional capabilities without parameter updates. Despite these advances, the research on the robustness and generalization ability of LLMs across different contexts remains limited.

Models with poor robustness and generalization may rely on “shortcut learning,” where they develop decision rules that perform well on standard benchmarks but fail to transfer to more challenging testing conditions, such as real-world scenarios [^5]. Therefore, evaluating LLMs’ performance in the face of shortcut information is crucial for understanding their robustness and generalization capabilities.

![Refer to caption](https://arxiv.org/html/2410.13343v1/x1.png)

Figure 1: Shortcut Learning Behavior: The LLM mistakenly infers the premise entails the hypothesis if all subsequences match, skipping deep semantic analysis.

A recent study investigates the reliance of LLMs on shortcuts or spurious correlations within prompts [^23]. However, this research falls short of providing an exhaustive evaluation across a broad spectrum of LLMs and varied prompting contexts, focusing solely on ICL experiments. Furthermore, it only considers relatively simple shortcuts such as letters or signs. Consequently, its evaluation lacks comprehensiveness and granularity.

To address this, we introduce Shortcut Suite, an in-depth test suite designed to evaluate the performance of different LLMs across six shortcuts, five metrics, and four prompt settings. Extensive experiments on Shortcut Suite reveal that LLMs tend to capture spurious correlations between source text and particular labels, indicating a prevalence of shortcut learning. For example, as shown in Figure 1, Gemini-Pro resorts to matching subsequences (the professor recommended the bankers) in a Natural Language Inference (NLI) task rather than comprehending the clause structure or delving into the sentence’s semantic content. This tendency of LLMs to capture spurious correlations can significantly impair their performance. In this paper, we conduct a comprehensive evaluation of LLMs’ behavior concerning shortcut learning from the following perspectives.

First, to identify the reliance of LLMs on shortcuts in downstream tasks, we collect six datasets containing different shortcuts and analyze the accuracy of LLMs on these datasets. We find a notable performance drop across various shortcuts, especially Constituent and Negation shortcuts, in some cases by more than 40%. Moreover, in the Position dataset, LLMs demonstrate a propensity for shortcut learning behavior by prioritizing the beginning of sentences while neglecting the end, revealing a vulnerability to additional information within sentences. Furthermore, an analysis of the distribution of LLMs’ predictions revealed inherent biases, with the LLMs favoring certain labels over others even in a balanced standard dataset.

Second, we perform comprehensive evaluation metrics to assess the impact of shortcuts on LLMs. In addition to accuracy, we introduce three novel metrics to assess the explanatory power of LLMs: Semantic Fidelity Score (SFS), Internal Consistency Score (ICS), and Explanation Quality Score (EQS). Our analyses using these metrics reveal that LLMs’ explanations often contain contradictions. Furthermore, we prompt LLMs to report their confidence levels and consistently find that they are overconfident in their predictions.

Third, we compare the performance of different LLMs and different prompting strategies in shortcut learning. Both closed-source and some open-source LLMs excel on standard datasets but falter on those with shortcuts. Surprisingly, larger LLMs are more prone to utilize shortcuts under zero-shot and few-shot ICL prompts. We find that LLMs are less affected by shortcuts under CoT settings than others. Notably, LLMs often demonstrate inferior performance in few-shot scenarios compared to zero-shot scenarios.

Finally, We summarize three error types of LLMs in shortcut learning by checking their CoT responses: distraction, disguised comprehension, and logical fallacy. These errors predispose LLMs to adopt shortcuts, undermining their robustness.

## 2 Related Work

##### Shortcut Learning in PLMs.

Shortcuts are decision rules that perform well on Independent and Identically Distributed (IID) test data but fail on Out-Of-Distribution (OOD) tests, revealing a mismatch between intended and learned solutions [^5]. Recent studies have shown that Pre-trained Language Models (PLMs) tend to exploit dataset biases as shortcuts to make predictions [^5] [^20], leading to low generalization for OOD samples in various NLP tasks, such as NLI [^15], question-answering [^7] [^21], reading comprehension [^13] and coreference inference [^32]. For example, NLI models tend to predict the contradiction label if the test samples contain negation words. Several approaches have been proposed to address this problem. [^6] presented a debiasing algorithm called DRiFt based on residual fitting. [^4] proposed a shortcut mitigation framework LTGR to suppress the model from making overconfident predictions for shortcut samples. [^33] introduced COMI to reduce the model’s reliance on shortcuts and enhance its ability to extract underlying information integrated with standard Empirical Risk Minimization. [^29] proposed SSR to boost rationalization by discovering and exploiting potential shortcuts.

| Shortcut | Definition | Premise | Hypothesis |
| --- | --- | --- | --- |
| Lexical Overlap | Assume that a premise entails all hypotheses constructed from words in the premise. | The actor was encouraged by the lawyer. | The actor encouraged the lawyer. |
| Subsequence | Assume that a premise entails all of its contiguous subsequences. | The authors in front of the senators contacted the artists. | The senators contacted the artists. |
| Constituent | Assume that a premise entails all complete subtrees in its parse tree. | Unless the president saw the professor, the student waited. | The student waited. |
| Negation | Assume that a hypothesis entails strong negation words (“no”, “not”, “nothing”,“never”). | They are all quotations from the Old Testament Book of Aunt Ruth. | Every one of them is quotations from the Old Testament and green is not red. |
| Position | Assume that the label is related to spurious position cues. | Red is red and red is red and red is red and red is red and red is red and “Wait here,” I was ordered. & “Wait here,” I was ordered and red is red and red is red and red is red and red is red and red is red. | He told me to come with him. |
| Style | Assume that the label is related to spurious text style cues. | And Severn said unto him, Thou and thy friends are not welcome here, said he. (Bible English) | Severn said the people were not welcome there. |

Table 1: Definitions and examples of the shortcuts explored in this paper.

##### Shortcut Learning in LLMs.

[^3] provided a review of recent developments that address the robustness challenge of LLMs. The most related work was the study investigating the reliance of LLMs on shortcuts within in-context learning [^23]. Our work differs from it in the following ways: First, their experiments were conducted on a limited model scope (GPT2 and OPT), whereas we use richer and more representative LLMs. Second, we focus on identifying shortcuts within the source text across different prompt settings rather than assessing solely against prompts. Third, while they rely on simple triggers such as letters or signs, resembling adversarial attacks, we propose more subtle and realistic shortcuts and test whether LLMs can identify and avoid these shortcuts.

## 3 Problem Definition

##### LLM for NLI.

In the NLI task, also known as textual entailment recognition, models evaluate a premise-hypothesis pair and determine their semantic relationship – typically labeled as entailment, neutral, or contradiction. Given a prompt $P$ with a source text $x$, the LLM will generate a probability of target $y$ conditioning on the prompt $P$. This could be written as

$$
p_{LLM}(y\mid P,x)=\prod_{t=1}^{T}p\left(y_{t}\mid P,x,y_{<t}\right),
$$

where $T$ is the generated token length and $y_{t}$ denotes the $t$ - $th$ token. For basic prompts such as zero-shot, $y$ takes the range of the corresponding label. For prompting strategies such as CoT, $y$ contains the reasoning process and the final label.

##### Framework to Generate Shortcuts.

Given a premise $q$, a hypothesis $h$, and a universally true statement $s$ ($s\equiv\top$) that may contain a certain shortcut, the logical relations are preserved upon their conjunction. Specifically, if $q$ and $h$ have the target label $l$, denoted as $\{(q,h,y)|y=l\}$, then $q$ combined with $s$ ($q\wedge s$) maintains the label $\{(q\wedge s,h,y)|y=l\}$ since $q\wedge s\equiv q\wedge\top\equiv q$. Thus, the source text has two mappings for the target label $l$. The model can either use the semantic relationship between the text and label ($x\rightarrow l$) or the injected shortcut ($s\rightarrow l$) for inference.

## 4 Shortcut Suite

As NLI is well positioned to serve as a benchmark task for research on NLP and can encapsulate the entire spectrum of the six identified shortcuts, we mainly anchor our framework on it. We also explore other tasks in Appendic C. Building on previous research, we create six datasets with different shortcuts and develop five metrics to investigate LLMs’ shortcut learning behavior and understand their robustness generalization capabilities.

### 4.1 Dataset Creation

We present six types of shortcuts in Table 1, each with an illustrative definition and an example.

##### Standard.

The Multi-Genre Natural Language Inference (MultiNLI) [^27] dataset serves as a benchmark for assessing models on NLI, encompassing ten genres of English. For a focused assessment, we have curated a balanced selection comprising 3000 samples from the development subset of MultiNLI.

##### Lexical Overlap & Subsequence & Constituent

For these three sets, we utilize the Heuristic Analysis for NLI Systems (HANS) [^15] dataset for evaluation. HANS is specifically designed to diagnose the use of fallible structural heuristics and is annotated with two labels only (entailment and non-entailment). Specifically, we collect 3000 examples for each set from HANS, where the heuristic is lexical overlap, subsequence, and constituent accordingly, with labels and templates equally divided.

##### Negation.

We explore the impact of strong negation words like “no”, “not”, “nothing” and “never” on model predictions. Inspired by [^17], we append the tautology – “and false is not true”, “and green is not red”, “and up is not down”, “and no square is a circle”, “and nothing comes from nothing”, and “and history never change”, chosen randomly with equal probability to the end of the hypothesis sentence in the Standard dataset.

##### Position.

To test the influence of the position of label-associated information, we divide the Standard dataset into four equally distributed label and genre groups. In each group, we append phrases like “and true is true”, “and red is red” or “ and up is up” five times at different positions. This allows us to evaluate whether LLMs rely on irrelevant positional cues when making predictions.

##### Style.

We consider the style of the text as a possible shortcut [^19] and focus on one prominent style: Bible style. Specifically, we employ a simple but powerful text style transfer model called STRAP [^12] and apply it to transfer the premises in the Standard dataset into Bible-style texts.

### 4.2 Metrics

We adopt accuracy to quantify performance on NLI tasks and introduce new metrics to assess the explanatory power of LLMs.

Semantic Fidelity Score (SFS) evaluates the extent to which the generated content preserves the essential meaning of the source text. We employ a pre-trained BERT ($f_{bert}$) [^9] model to create embedding for the input and the output collectively, then compute their cosine similarity. For a prompt $P$ and model output $c$, $SFS$ is given by

$$
\begin{aligned} SFS=\text{Cosine Similarity}(f_{\text{bert}}(P),f_{\text{bert}%
}(c)).\end{aligned}
$$

Internal Consistency Score (ICS) assesses whether there are logical contradictions within the reasoning steps of LLMs or between the reasoning and the answer. To estimate the probability of contradiction $p_{\text{contra}}$, we use an NLI model [^14] that categorizes hypothesis-context pairs into classes of entailment, neutral, and contradiction. For a reasoning chain of $N$ steps, $c=(c_{1},c_{2},\ldots,c_{N})$, where the last step is the answer, and $p_{\text{contra}}(c_{i},c_{j})$ indicates the probability that step $c_{i}$ contradicts step $c_{j}$, we define the function $f(c)$ as

$$
f(c)=\begin{cases}0,&\text{if }\exists\,(c_{i},c_{j}),1\leq i<j\leq N,\\
&s.t.\ p_{\text{contra}}(c_{i},c_{j})>\frac{1}{3},\\
1,&\text{otherwise}.\end{cases}
$$

The overall $ICS$ is the mean of all calculated $f(c)$ values for the given explanations.

Explanation Quality Score (EQS) integrates the SFS and ICS to reflect the overall quality of LLMs’ output and is defined as

$$
EQS=w_{1}\cdot SFS+w_{2}\cdot ICS,
$$

where weights $w_{1}$ and $w_{2}$ represent the significance of each score in the overall evaluation. In this work, $w_{1}$ and $w_{2}$ are equally set as 0.5.

<table><tbody><tr><th rowspan="2">Model</th><th>Standard</th><th colspan="2">Lexical Overlap</th><th colspan="2">Subsequence</th><th colspan="2">Constituent</th><th>Negation</th><th>Position</th><th>Style</th></tr><tr><th></th><th><math><semantics><mi>E</mi> <ci>𝐸</ci> <annotation>E</annotation> <annotation>italic_E</annotation></semantics></math></th><th><math><semantics><mrow><mo>¬</mo> <mi>E</mi></mrow> <apply><ci>𝐸</ci></apply> <annotation>\neg E</annotation> <annotation>¬ italic_E</annotation></semantics></math></th><th><math><semantics><mi>E</mi> <ci>𝐸</ci> <annotation>E</annotation> <annotation>italic_E</annotation></semantics></math></th><th><math><semantics><mrow><mo>¬</mo> <mi>E</mi></mrow> <apply><ci>𝐸</ci></apply> <annotation>\neg E</annotation> <annotation>¬ italic_E</annotation></semantics></math></th><th><math><semantics><mi>E</mi> <ci>𝐸</ci> <annotation>E</annotation> <annotation>italic_E</annotation></semantics></math></th><th><math><semantics><mrow><mo>¬</mo> <mi>E</mi></mrow> <apply><ci>𝐸</ci></apply> <annotation>\neg E</annotation> <annotation>¬ italic_E</annotation></semantics></math></th><th></th><th></th><td></td></tr><tr><th colspan="11">zero-shot</th></tr><tr><th>GPT-3.5-Turbo</th><td>56.7</td><td>69.5</td><td>83.8</td><td>58.6</td><td>58.3</td><td>67.5</td><td>40.2</td><td>39.8</td><td>43.3</td><td>51.5</td></tr><tr><th>GPT-4</th><td>85.6</td><td>96.7</td><td>100.0</td><td>95.8</td><td>73.5</td><td>96.7</td><td>80.0</td><td>54.3</td><td>67.4</td><td>70.0</td></tr><tr><th>Gemini-Pro</th><td>76.2</td><td>81.3</td><td>97.7</td><td>88.6</td><td>48.6</td><td>77.9</td><td>47.2</td><td>53.1</td><td>56.2</td><td>62.5</td></tr><tr><th>LLaMA2-Chat-7B</th><td>42.1</td><td>76.9</td><td>40.0</td><td>72.8</td><td>46.4</td><td>60.6</td><td>25.4</td><td>37.7</td><td>39.3</td><td>39.6</td></tr><tr><th>LLaMA2-Chat-13B</th><td>54.3</td><td>99.0</td><td>42.2</td><td>99.7</td><td>6.0</td><td>95.9</td><td>0.8</td><td>54.6</td><td>55.4</td><td>53.8</td></tr><tr><th>LLaMA2-Chat-70B</th><td>57.7</td><td>66.9</td><td>40.7</td><td>61.6</td><td>53.8</td><td>77.8</td><td>34.9</td><td>52.4</td><td>53.9</td><td>52.7</td></tr><tr><th>ChatGLM3-6B</th><td>40.0</td><td>75.4</td><td>41.7</td><td>82.4</td><td>25.5</td><td>79.4</td><td>14.6</td><td>32.8</td><td>34.7</td><td>33.5</td></tr><tr><th>Mistral-7B</th><td>49.4</td><td>53.9</td><td>96.2</td><td>57.9</td><td>73.9</td><td>48.8</td><td>75.9</td><td>38.1</td><td>40.5</td><td>43.0</td></tr><tr><th colspan="11">few-shot ICL</th></tr><tr><th>GPT-3.5-Turbo</th><td>61.7</td><td>93.3</td><td>38.7</td><td>91.3</td><td>23.3</td><td>96.7</td><td>9.3</td><td>50.0</td><td>47.8</td><td>49.5</td></tr><tr><th>GPT-4</th><td>83.9</td><td>96.7</td><td>99.3</td><td>91.3</td><td>71.3</td><td>94.0</td><td>92.0</td><td>49.7</td><td>69.7</td><td>72.0</td></tr><tr><th>Gemini-Pro</th><td>77.9</td><td>95.3</td><td>92.9</td><td>94.0</td><td>37.0</td><td>95.8</td><td>30.4</td><td>45.6</td><td>55.3</td><td>60.5</td></tr><tr><th>LLaMA2-Chat-7B</th><td>40.2</td><td>66.5</td><td>75.3</td><td>53.3</td><td>59.5</td><td>55.9</td><td>33.1</td><td>37.0</td><td>39.4</td><td>38.6</td></tr><tr><th>LLaMA2-Chat-13B</th><td>59.1</td><td>97.5</td><td>48.5</td><td>87.3</td><td>12.4</td><td>92.4</td><td>12.1</td><td>50.3</td><td>54.0</td><td>53.3</td></tr><tr><th>LLaMA2-Chat-70B</th><td>57.8</td><td>100.0</td><td>3.6</td><td>99.8</td><td>3.1</td><td>99.6</td><td>1.6</td><td>45.2</td><td>53.7</td><td>50.8</td></tr><tr><th>ChatGLM3-6B</th><td>35.6</td><td>100.0</td><td>0.0</td><td>100.0</td><td>0.0</td><td>100.0</td><td>0.0</td><td>32.5</td><td>32.6</td><td>34.7</td></tr><tr><th>Mistral-7B</th><td>63.9</td><td>84.4</td><td>84.7</td><td>73.3</td><td>57.7</td><td>72.1</td><td>48.0</td><td>40.9</td><td>47.6</td><td>56.4</td></tr><tr><th colspan="11">zero-shot CoT</th></tr><tr><th>GPT-3.5-Turbo</th><td>64.7</td><td>75.3</td><td>77.3</td><td>65.3</td><td>59.3</td><td>78.7</td><td>35.3</td><td>51.5</td><td>54.0</td><td>60.7</td></tr><tr><th>GPT-4</th><td>81.3</td><td>94.0</td><td>100.0</td><td>98.0</td><td>61.3</td><td>96.0</td><td>94.0</td><td>58.3</td><td>75.2</td><td>69.3</td></tr><tr><th>Gemini-Pro</th><td>72.7</td><td>68.0</td><td>94.6</td><td>65.9</td><td>56.3</td><td>74.9</td><td>58.9</td><td>65.2</td><td>58.2</td><td>60.0</td></tr><tr><th>LLaMA2-Chat-7B</th><td>48.0</td><td>71.2</td><td>46.0</td><td>62.7</td><td>42.1</td><td>63.4</td><td>34.1</td><td>43.8</td><td>45.5</td><td>47.5</td></tr><tr><th>LLaMA2-Chat-13B</th><td>56.3</td><td>59.7</td><td>74.6</td><td>52.5</td><td>56.8</td><td>53.9</td><td>41.7</td><td>49.2</td><td>52.0</td><td>48.8</td></tr><tr><th>LLaMA2-Chat-70B</th><td>60.3</td><td>74.4</td><td>69.7</td><td>69.6</td><td>44.7</td><td>72.0</td><td>25.3</td><td>56.6</td><td>53.7</td><td>52.3</td></tr><tr><th>ChatGLM3-6B</th><td>48.9</td><td>82.9</td><td>32.0</td><td>81.4</td><td>24.8</td><td>76.0</td><td>28.0</td><td>39.1</td><td>44.2</td><td>43.5</td></tr><tr><th>Mistral-7B</th><td>69.6</td><td>76.5</td><td>94.7</td><td>83.7</td><td>63.5</td><td>71.2</td><td>58.4</td><td>46.3</td><td>49.9</td><td>58.8</td></tr><tr><th colspan="11">few-shot CoT</th></tr><tr><th>GPT-3.5-Turbo</th><td>71.7</td><td>85.3</td><td>75.3</td><td>83.3</td><td>55.3</td><td>90.0</td><td>22.0</td><td>53.7</td><td>60.7</td><td>63.0</td></tr><tr><th>GPT-4</th><td>83.0</td><td>95.3</td><td>100.0</td><td>94.7</td><td>66.0</td><td>95.3</td><td>88.0</td><td>67.3</td><td>74.7</td><td>70.3</td></tr><tr><th>Gemini-Pro</th><td>72.4</td><td>86.1</td><td>64.5</td><td>81.4</td><td>40.5</td><td>87.5</td><td>37.0</td><td>63.2</td><td>59.4</td><td>62.4</td></tr><tr><th>LLaMA2-Chat-7B</th><td>43.8</td><td>78.1</td><td>34.9</td><td>70.3</td><td>37.7</td><td>64.3</td><td>42.1</td><td>39.3</td><td>41.4</td><td>40.8</td></tr><tr><th>LLaMA2-Chat-13B</th><td>60.6</td><td>72.1</td><td>51.1</td><td>54.5</td><td>37.2</td><td>70.6</td><td>32.6</td><td>47.5</td><td>50.6</td><td>53.1</td></tr><tr><th>LLaMA2-Chat-70B</th><td>70.9</td><td>78.2</td><td>66.2</td><td>68.0</td><td>54.0</td><td>78.9</td><td>38.4</td><td>58.5</td><td>57.9</td><td>57.9</td></tr><tr><th>ChatGLM3-6B</th><td>40.0</td><td>94.6</td><td>9.7</td><td>92.9</td><td>11.4</td><td>86.8</td><td>20.0</td><td>34.8</td><td>34.7</td><td>38.7</td></tr><tr><th>Mistral-7B</th><td>67.6</td><td>88.3</td><td>58.6</td><td>84.0</td><td>38.2</td><td>81.9</td><td>32.3</td><td>50.4</td><td>48.5</td><td>59.4</td></tr></tbody></table>

Table 2: Accuracy ($\%$) across all datasets under four prompt settings. $E$ and $\neg E$ are respectively referring to entailment (IID) and non-entailment (OOD) sets. The intensity of blue highlights corresponds to the *absolute* decrease in accuracy compared to the Standard dataset for each LLM.

Confidence Score (CFS) is designed to evaluate LLMs’ self-assessment capabilities. We follow [^28] to prompt LLMs to provide their confidence level, which indicates the degree of certainty they have about their answer and is represented as a percentage.

### 4.3 Evaluated LLMs

To obtain a comprehensive understanding of how LLMs are affected by shortcuts, we conduct experiments on three widely used closed-source LLMs: GPT-3.5-Turbo [^18], GPT-4 [^1] and Gemini-Pro [^24]. Regarding open-source LLMs, we select LLaMA2-Chat-series (7B, 13B, 70B) [^25], ChatGLM3-6B [^30] and Mistral-7B [^8] for assessment.

### 4.4 Prompting Strategies

Our experiments aim to assess the performance of LLMs in different settings, including zero-shot, few-shot ICL, zero-shot CoT, and few-shot CoT promptings. For zero-shot CoT, we utilize the prompt depicted in Figure 1. To construct few-shot ICL prompts, we enhance the best-performing zero-shot prompt by incorporating three random samples from the remaining examples in MultiNLI. Likewise, we employ a similar sampling approach for few-shot CoT and use GPT-4 to generate analyses for these examples.

![Refer to caption](https://arxiv.org/html/2410.13343v1/x2.png)

Figure 2: Box plots of confidence scores across all datasets under zero-shot CoT prompting (each LLM is denoted by an abbreviation). LLMs generally report confidence scores that significantly exceed their actual accuracy.

## 5 Experimental Results

We conduct our experiments based on the Shortcut Suite and observe that LLMs tend to exploit various shortcuts in downstream tasks, resulting in a notable decrease in performance. In this section, we present a comprehensive analysis.

### 5.1 Overall Performance

#### 5.1.1 Effect of Different LLMs

As shown in Table 2, closed-source and some open-source LLMs excel on standard datasets, with GPT-4 leading at an accuracy of 85.6%, followed by Gemini-Pro at 77.9%, GPT-3.5-Turbo at 71.7%, LLaMA2-Chat-70B at 70.9% and Mistral-7B at 69.6%. However, this high level of performance does not extend to datasets containing shortcuts. For example, the accuracy of GPT-3.5-Turbo on the Constituent ($\neg E$) dataset drops by 52.4% in the few-shot ICL setting. This significant drop suggests that LLMs are easily prone to adopting shortcuts for prediction.

Among the open-source LLMs, Mistral-7B performs the best with CoT prompts. It excels on both standard and shortcut datasets, nearly surpassing LLaMA2-Chat-13B in all settings and even exceeding GPT-3.5-Turbo in some scenarios, demonstrating remarkable capabilities in NLI and robustness generalization. On the other hand, ChatGLM3-6B is the most affected by shortcuts, resulting in the poorest performance.

Furthermore, we observe an inverse scaling pattern of LLaMA2-Chat in zero-shot and few-shot ICL scenarios. As the model size increases, it tends to rely more on spurious mapping for NLI tasks, resulting in lower accuracy. However, in the CoT scenario, LLaMA2-Chat-70B outperforms smaller models on most datasets. This indicates that larger models retain improved semantic comprehension and reasoning abilities but require appropriate prompting to fully leverage their potential. This phenomenon is also observed in the LLaMA3 series, as illustrated in Appendix C.

#### 5.1.2 Effect of Shortcut Types

Regarding Lexical Overlap, Subsequence, and Constituent shortcuts, LLMs consistently favor predicting entailment ($E$) and thus struggle with the non-entailment ($\neg E$) class. This indicates that LLMs can easily exploit these spurious correlations with the label $E$, leading to poor performance on $\neg E$ instances. Lexical Overlap appears to be the easiest task for most LLMs across different prompt settings, resulting in consistently high accuracy, while the Constituent shortcut poses the greatest challenge. For instance, in the zero-shot setting, Gemini-Pro experiences a significant 29.0% drop on Constituent, from 76.2% to 47.2%, worse than random guessing at 50%.

Negation, Position, and Style shortcuts also prove challenging for most LLMs, as indicated by the notable decrease in accuracy. In the Negation dataset, the accuracy of GPT-4 decreases by 15-35% across the four different prompt settings. In the Style dataset, the accuracy of GPT-4 decreases up to 15.6%. Moreover, the detailed results of the Position shortcut are presented in Table 3. The lowest accuracy rates are predominantly observed when extra phrases are added at the beginning of the sentence, suggesting that the LLMs may rely more heavily on the beginning parts of sentences for cues than the end parts, which could be a potential shortcut for improvement.

<table><thead><tr><th>Model</th><th colspan="2">premise</th><th colspan="2">hypothesis</th></tr><tr><th></th><th>start</th><th>end</th><th>start</th><th>end</th></tr></thead><tbody><tr><th>GPT-3.5-Turbo</th><td>61.3</td><td>56.0</td><td>48.0</td><td>50.7</td></tr><tr><th>GPT-4</th><td>77.6</td><td>79.7</td><td>76.4</td><td>71.2</td></tr><tr><th>Gemini-Pro</th><td>50.7</td><td>62.8</td><td>55.1</td><td>62.4</td></tr><tr><th>LLaMA2-Chat-7B</th><td>46.6</td><td>46.2</td><td>42.1</td><td>46.3</td></tr><tr><th>LLaMA2-Chat-13B</th><td>50.0</td><td>57.9</td><td>47.9</td><td>50.8</td></tr><tr><th>LLaMA2-Chat-70B</th><td>51.8</td><td>62.0</td><td>53.8</td><td>55.1</td></tr><tr><th>ChatGLM3-6B</th><td>43.5</td><td>45.5</td><td>42.1</td><td>44.1</td></tr><tr><th>Mistral-7B</th><td>49.7</td><td>50.6</td><td>47.1</td><td>47.3</td></tr></tbody></table>

Table 3: Accuracy Details for Position Shortcut: We place tautologies at the start or end of the premise or hypothesis in the Standard dataset. The lowest accuracy for each LLM is underlined, which frequently occurs when the tautologies are placed at the beginning of the source text.

![Refer to caption](https://arxiv.org/html/2410.13343v1/x3.png)

Figure 3: Label distribution percentages (%) for each LLM’s predictions under zero-shot prompting (each LLM is abbreviated). Distributions for the other three datasets are in Appendix A.

#### 5.1.3 Effect of Prompting Types

Most LLMs demonstrate significant performance gains in all datasets when utilizing the CoT prompt. For example, GPT-4 with a zero-shot CoT prompt on the Constituent ($\neg E$) dataset achieves an accuracy improvement of 14.0% compared to zero-shot, while LLaMA2-Chat-13B shows an improvement of 40.9% under the same conditions. However, the accuracy of GPT-4 and Gemini-Pro decreases after applying the CoT prompt on the Standard dataset and Lexical Overlap dataset. This phenomenon reveals that LLMs are prone to utilize shortcuts to predict, and the CoT prompt can promote in-depth inference and reduce the reliance on spurious correlations, thus improving performance. However, for relatively simple datasets, advanced LLMs may already possess sufficient semantic understanding and reasoning capabilities, reducing their dependence on CoT for performance enhancement.

Additionally, it is worth noting that the effectiveness of few-shot prompts is not superior to zero-shot prompting. In several scenarios, the few-shot ICL is less effective than the zero-shot, and the few-shot CoT performs worse than the zero-shot CoT. This discrepancy could be attributed to the LLMs acquiring biases from the in-context examples. Similar phenomena have been reported in [^10] [^23]. We show more experimental results and analysis in Appendix D.

### 5.2 In-depth Analysis

#### 5.2.1 Explanation Quality

We evaluate the explanation quality of LLMs in shortcut challenges using Equations 2, 3, and 4, with results presented in Table 4.

For SFS, most LLMs score above 85%, indicating that current models have achieved a relatively high level of semantic fidelity. GPT-3.5-Turbo scores the highest on the Standard dataset with 92.1%, while Mistral-7B scores the lowest at 88.5%. Generally, models demonstrate a slight decline in SFS on shortcut datasets compared to the Standard dataset, indicating a reduced ability to restate inputs effectively in these contexts.

Regarding ICS, most LLMs score below 50%, suggesting that more than half of their responses are contradictory. Notably, LLMs exhibit lower ICS scores on shortcut datasets compared to the Standard dataset. For example, LLaMA2-Chat-70B achieves a score of 41.5% on the Standard dataset but only 13.5% on the Negation dataset. These observations suggest that a lack of internal consistency in reasoning is a significant factor contributing to LLMs’ reduced performance when dealing with shortcuts.

The overall EQS, which combines SFS and ICS, provides a comprehensive reflection of the overall quality of explanations from LLMs. Typically, models that exhibit higher accuracy also demonstrate greater explanatory capabilities.

<table><tbody><tr><th rowspan="2">Model</th><th>Standard</th><th colspan="2">Lexical Overlap</th><th colspan="2">Subsequence</th><th colspan="2">Constituent</th><th>Negation</th><th>Position</th><th>Style</th></tr><tr><th></th><th><math><semantics><mi>E</mi> <ci>𝐸</ci> <annotation>E</annotation> <annotation>italic_E</annotation></semantics></math></th><th><math><semantics><mrow><mo>¬</mo> <mi>E</mi></mrow> <apply><ci>𝐸</ci></apply> <annotation>\neg E</annotation> <annotation>¬ italic_E</annotation></semantics></math></th><th><math><semantics><mi>E</mi> <ci>𝐸</ci> <annotation>E</annotation> <annotation>italic_E</annotation></semantics></math></th><th><math><semantics><mrow><mo>¬</mo> <mi>E</mi></mrow> <apply><ci>𝐸</ci></apply> <annotation>\neg E</annotation> <annotation>¬ italic_E</annotation></semantics></math></th><th><math><semantics><mi>E</mi> <ci>𝐸</ci> <annotation>E</annotation> <annotation>italic_E</annotation></semantics></math></th><th><math><semantics><mrow><mo>¬</mo> <mi>E</mi></mrow> <apply><ci>𝐸</ci></apply> <annotation>\neg E</annotation> <annotation>¬ italic_E</annotation></semantics></math></th><th></th><th></th><td></td></tr><tr><th colspan="11">SFS | ICS</th></tr><tr><th>GPT-3.5-Turbo</th><td>92.1 | 29.0</td><td>91.0 | 35.3</td><td>92.0 | 5.3</td><td>91.0 | 30.5</td><td>91.5 | 25.7</td><td>89.5 | 36.6</td><td>90.8 | 26.1</td><td>93.3 | 21.7</td><td>92.5 | 25.7</td><td>92.3 | 22.7</td></tr><tr><th>GPT-4</th><td>91.1 | 34.7</td><td>91.1 | 35.3</td><td>91.3 | 11.3</td><td>90.8 | 23.3</td><td>90.0 | 23.3</td><td>91.8 | 42.7</td><td>89.2 | 18.0</td><td>88.7 | 57.0</td><td>91.8 | 43.7</td><td>90.2 | 28.3</td></tr><tr><th>Gemini-Pro</th><td>89.2 | 43.0</td><td>88.6 | 39.0</td><td>88.4 | 29.9</td><td>87.9 | 30.5</td><td>88.8 | 25.7</td><td>87.3 | 36.6</td><td>90.0 | 26.1</td><td>90.8 | 46.4</td><td>89.2 | 40.0</td><td>89.1 | 47.7</td></tr><tr><th>LLaMA2-Chat-7B</th><td>88.7 | 20.3</td><td>90.6 | 29.5</td><td>90.1 | 4.1</td><td>90.2 | 24.2</td><td>90.4 | 15.8</td><td>90.8 | 23.0</td><td>90.4 | 16.7</td><td>89.8 | 11.1</td><td>90.1 | 15.2</td><td>88.6 | 19.8</td></tr><tr><th>LLaMA2-Chat-13B</th><td>90.2 | 41.5</td><td>91.4 | 31.2</td><td>91.1 | 11.0</td><td>91.3 | 26.5</td><td>90.0 | 23.5</td><td>92.3 | 36.4</td><td>90.8 | 25.5</td><td>88.4 | 13.5</td><td>92.3 | 18.0</td><td>89.9 | 25.0</td></tr><tr><th>LLaMA2-Chat-70B</th><td>90.4 | 33.9</td><td>90.6 | 42.1</td><td>91.1 | 6.9</td><td>90.1 | 36.7</td><td>90.5 | 24.0</td><td>90.3 | 41.9</td><td>90.4 | 34.0</td><td>90.3 | 25.4</td><td>91.3| 30.9</td><td>90.0 | 30.4</td></tr><tr><th>ChatGLM3-6B</th><td>90.3 | 22.9</td><td>87.7 | 24.5</td><td>88.1 | 9.5</td><td>88.0 | 22.4</td><td>88.0 | 21.2</td><td>87.8 | 20.1</td><td>87.7 | 24.0</td><td>91.2 | 24.2</td><td>90.5 | 23.3</td><td>90.4 | 23.5</td></tr><tr><th>Mistral-7B</th><td>88.5 | 45.5</td><td>85.1 | 63.9</td><td>89.0 | 29.4</td><td>84.2 | 67.7</td><td>88.3 | 54.9</td><td>83.2 | 69.2</td><td>87.9 | 53.0</td><td>91.2 | 44.4</td><td>87.2 | 49.6</td><td>89.5 | 44.2</td></tr><tr><th colspan="11">EQS</th></tr><tr><th>GPT-3.5-Turbo</th><td>60.6</td><td>63.2</td><td>48.7</td><td>60.8</td><td>58.6</td><td>63.1</td><td>58.5</td><td>57.5</td><td>59.1</td><td>57.5</td></tr><tr><th>GPT-4</th><td>62.9</td><td>63.2</td><td>51.3</td><td>57.1</td><td>56.7</td><td>67.3</td><td>53.6</td><td>72.9</td><td>67.8</td><td>59.3</td></tr><tr><th>Gemini-Pro</th><td>66.1</td><td>63.8</td><td>59.2</td><td>59.2</td><td>57.3</td><td>62.0</td><td>58.1</td><td>68.6</td><td>64.6</td><td>68.4</td></tr><tr><th>LLaMA2-Chat-7B</th><td>54.5</td><td>60.1</td><td>47.1</td><td>57.2</td><td>53.1</td><td>56.9</td><td>53.6</td><td>50.5</td><td>52.7</td><td>54.2</td></tr><tr><th>LLaMA2-Chat-13B</th><td>65.9</td><td>61.3</td><td>51.1</td><td>58.9</td><td>56.8</td><td>64.4</td><td>58.2</td><td>51.0</td><td>55.2</td><td>57.5</td></tr><tr><th>LLaMA2-Chat-70B</th><td>62.2</td><td>66.4</td><td>49.0</td><td>126.8</td><td>57.3</td><td>66.1</td><td>62.2</td><td>57.9</td><td>61.1</td><td>60.2</td></tr><tr><th>ChatGLM3-6B</th><td>56.6</td><td>56.1</td><td>48.8</td><td>55.2</td><td>54.6</td><td>54.0</td><td>55.9</td><td>57.7</td><td>56.9</td><td>57.0</td></tr><tr><th>Mistral-7B</th><td>67.0</td><td>74.5</td><td>59.2</td><td>76.0</td><td>71.6</td><td>76.2</td><td>70.5</td><td>67.8</td><td>68.4</td><td>66.9</td></tr></tbody></table>

Table 4: SFS (%), ICS (%), and EQS (%) across all datasets under zero-shot CoT prompting. The worst score for each LLM is underlined. LLMs typically show the lowest explanation quality in datasets comprising shortcuts.

#### 5.2.2 Confidence Score

Figure 2 displays the confidence levels of LLMs, revealing two key findings. First, LLMs tend to be overconfident, with their confidence scores rarely falling below 60% and often significantly exceeding their actual accuracy. Second, the discrepancy between confidence and accuracy is notably greater in datasets containing shortcuts compared to the Standard dataset. This suggests that LLMs not only adopt shortcuts but also exhibit heightened confidence in these spurious mappings without fully understanding the true relationship between the source text and the corresponding label.

#### 5.2.3 Prediction Distribution

Figure 3 shows the label distribution in each LLM’s prediction. Despite a balanced distribution in the ground truth, we can easily observe that in the Standard dataset, GPT-3.5-Turbo, LLaMA2-Chat-7B, and Mistral-7B tend to disproportionately predict neutral over the other two categories. Conversely, LLaMA2-Chat-13B and ChatGLM3-6B show a bias towards entailment. This pattern may stem from multiple factors, including potential overfitting to the NLI task or tasks with a similar categorical structure.

For datasets featuring Lexical Overlap, Subsequence, and Constituent shortcuts, LLMs predominantly predict entailment, indicating a susceptibility to these shortcuts. For the Negation shortcut, a rise in contradiction predictions by GPT-4 and LLaMA2-Chat-13B suggests a reliance on a spurious correlation between negation words and the contradiction label.

#### 5.2.4 Error Analysis

We identify three types of errors in shortcut learning by analyzing the CoT responses of LLMs. The first issue is distraction, where LLMs are easily distracted by irrelevant information. As shown in Figure 4, they may focus on repetitive tautologies, leading to the neglect of useful information in the original text. Additionally, they often prioritize words at the start of a sentence while neglecting those at the end, as shown in Table 3. This reflects a tendency in LLMs to concentrate on local information while ignoring the comprehensive context.

Second, LLMs suffer from disguised comprehension. Specifically, they struggle to grasp the subtleties of individual words, sentence structures, and complex biblical language styles, shifting one’s concept to another. This leads to disguised comprehension where LLMs might inadvertently “borrow” concepts, causing them to rely on shortcuts to make incorrect inferences. The detailed case can be found in Figure 6.

The third issue is logical fallacy. LLMs tend to reduce intricate reasoning to overly simplistic terms, generalizing from specific instances to broader conclusions via the use of shortcuts. This oversimplification in their reasoning process can lead to erroneous results, as illustrated in Figure 7.

![Refer to caption](https://arxiv.org/html/2410.13343v1/x4.png)

Figure 4: An illustrative example of distraction in LLMs: in the Position dataset, the LLM is observed to be distracted by tautologies, thus ignoring useful information.

### 5.3 Extended Evaluation

To gain further insight into the shortcut challenges in LLMs, we conduct experiments on other NLP tasks. The first is the Sentiment Analysis (SA) task. Specifically, we use the validation set of the Stanford Sentiment Treebank (SST-2) [^22] as our Standard dataset. We then introduce the Negation shortcut using the method described in Section 4.1 to the Standard dataset. The second is the Paraphrase Identification (PI) task. We experiment with the Quora Question Pairs (QQP) <sup>1</sup> dataset as Standard dataset and the Paraphrase Adversaries from Word Scrambling (PAWS) [^31] dataset to represent Lexical Overlap shortcut. The results, presented in Table 5, demonstrate a consistent decline in performance across both the SA and PI tasks on datasets comprising shortcuts compared to Standard datasets. Furthermore, as shown in Figure 8, there is a noticeable increase in negative predictions on the Negation dataset and an increase in duplicate predictions on the Lexical Overlap dataset. This pattern suggests that LLMs tend to capture spurious correlations between negation words and the negative label, as well as between word overlap and the duplicate label. In conclusion, we find that LLMs are prone to relying on the Negation shortcut in the SA task and the Lexical Overlap shortcut in the PI task, suggesting that shortcut learning is a prevalent phenomenon in LLMs across a wide spectrum of tasks.

Besides the LLMs mentioned above, we also conduct experiments on the latest LLMs, such as LLaMA3-series, and analyze the results as detailed in Appendix C.

<table><thead><tr><th>Model</th><th colspan="2">SA</th><th colspan="2">PI</th></tr><tr><th></th><th>Standard</th><th>Negation</th><th>Standard</th><th>Overlap</th></tr></thead><tbody><tr><th>GPT-3.5-Turbo</th><td>91.7</td><td>87.0</td><td>81.2</td><td>74.3</td></tr><tr><th>GPT-4</th><td>93.0</td><td>90.2</td><td>73.7</td><td>64.2</td></tr><tr><th>Gemini-Pro</th><td>92.7</td><td>87.8</td><td>75.9</td><td>47.4</td></tr><tr><th>LLaMA2-Chat-7B</th><td>84.1</td><td>76.1</td><td>61.6</td><td>49.5</td></tr><tr><th>LLaMA2-Chat-13B</th><td>87.4</td><td>83.3</td><td>73.8</td><td>50.0</td></tr><tr><th>LLaMA2-Chat-70B</th><td>87.8</td><td>87.1</td><td>71.7</td><td>52.0</td></tr><tr><th>ChatGLM3-6B</th><td>90.4</td><td>85.4</td><td>64.9</td><td>49.6</td></tr><tr><th>Mistral-7B</th><td>80.5</td><td>79.1</td><td>52.6</td><td>49.6</td></tr></tbody></table>

Table 5: Accuracy (%) of the SA and PI tasks under zero-shot prompting. LLMs consistently demonstrate reduced performance on shortcut datasets compared to the Standard, as indicated by the blue highlights.

## 6 Conclusion

In this study, we proposed Shortcut Suite, a test suite designed to evaluate the performance of LLMs in shortcut learning across several NLP tasks. Shortcut Suite encompasses six types of shortcuts: Lexical Overlap, Subsequence, Constituent, Negation, Position, and Style, and evaluates performance using five metrics: ACC, SFS, ICS, EQS, and CFS, across four prompt settings: zero-shot, few-shot ICL, zero-shot CoT, and few-shot CoT. Our extensive experiments on diverse LLMs demonstrated that LLMs frequently rely on shortcuts in downstream tasks. We explored the impact of different models, types of shortcuts, and prompting strategies. Our analysis then extended to explanation quality, label distribution, confidence score and error analysis.

Our findings offer new perspectives on LLMs’ robustness and present new challenges for reducing their shortcut reliance, paving the way for future advancements in this field.

## 7 Limitations

In this paper, we primarily focus on evaluating the effect of shortcut learning in LLMs on the NLI task, with additional exploration into tasks like SA and PI. However, we acknowledge that other NLP tasks, such as question-answering and coreference inference, could offer further insights and should be investigated in future research.

While this study provides a comprehensive understanding of shortcut learning in LLMs, it does not propose specific methods to mitigate this phenomenon effectively. Nonetheless, we identify shortcut learning behavior in LLMs and categorize potential error types associated with shortcut learning, offering a foundation for future research. Based on our findings, we suggest several potential approaches for addressing shortcut learning in LLMs. One approach is fine-tuning on unbiased datasets, as training models on diverse and representative datasets may help alleviate shortcut learning. Moreover, employing advanced prompting techniques is essential. Our experiments indicate that few-shot prompting is insufficient for mitigating shortcut learning behaviors in LLMs, thus enhancing reasoning capabilities through methods such as CoT prompting may prove effective. Additionally, implementing retrieval augmentation by incorporating relevant external documents can ground LLMs, thereby reducing knowledge gaps and instances of hallucination. We advocate for further research to develop effective strategies aimed at addressing shortcut learning in LLMs.

## Acknowledgments

This research was partially supported by grants from the Joint Research Project of the Science and Technology Innovation Community in Yangtze River Delta (No. 2023CSJZN0200), the National Natural Science Foundation of China (No. 62337001), Anhui Provincial Natural Science Foundation (No. 2308085QF229) and the Fundamental Research Funds for the Central Universities (No. WK2150110034).

## References

## Appendix A Appendix: Label Distribution

![Refer to caption](https://arxiv.org/html/2410.13343v1/x5.png)

Figure 5: Label distribution as percentages (%) for LLMs’ prediction under zero-shot prompting (each LLM is denoted by an abbreviation).

## Appendix B Appendix: Error Analysis

Figure 6 and 7 show the disguised comprehension error example and the logical fallacy error example respectively.

![Refer to caption](https://arxiv.org/html/2410.13343v1/x6.png)

Figure 6: An illustrative example of disguised comprehension in LLMs: the positions of “that” and “believed” are mistakenly swapped, leading to the incorrect assumption that they convey the same meaning.

![Refer to caption](https://arxiv.org/html/2410.13343v1/x7.png)

Figure 7: An illustrative example of logical fallacy in LLMs: an oversimplification in the Subsequence dataset is found in the analysis process. In the source text, knowing of an action (the lawyer thanking the actor) doesn’t necessarily equate to knowing the person (the lawyer) in a broader sense.

## Appendix C Appendix: Extended Evaluation of Shortcut Learning

##### Model.

In addition to the LLMs we discussed above, we’d like to extend our investigation to the LLaMA3-series. Notably, LLaMA3 demonstrates superior performance over LLaMA2. Specifically, LLaMA3-8B-Instruct outperforms both LLaMA2-Chat-7B and LLaMA2-Chat-13B on most datasets. Furthermore, LLaMA3-70B-Instruct surpasses GPT-3.5-Turbo and approaches the performance of Gemini-Pro. Despite these advances, we observe a consistent decline in performance on shortcut datasets compared to standard datasets. This trend suggests that LLaMA3-8B, similar to its predecessor, may rely on shortcuts for predictions. Additionally, the reverse scaling pattern persists in shortcut datasets such as Subsequence ($\neg E$) and Constituent ($\neg E$). These supplementary experiments highlight the propensity of most LLMs to rely on shortcuts across a wide spectrum of tasks, underscoring the need for more robust and generalizable mechanisms.

![Refer to caption](https://arxiv.org/html/2410.13343v1/x8.png)

Figure 8: Label distribution as percentages (%) for LLMs’ prediction under zero-shot prompting on SA and PI task ( each LLM is denoted by an abbreviation).

<table><tbody><tr><th rowspan="2">Model</th><th>Standard</th><th colspan="2">Lexical Overlap</th><th colspan="2">Subsequence</th><th colspan="2">Constituent</th><th>Negation</th><th>Position</th><th>Style</th></tr><tr><th></th><th><math><semantics><mi>E</mi> <ci>𝐸</ci> <annotation>E</annotation> <annotation>italic_E</annotation></semantics></math></th><th><math><semantics><mrow><mo>¬</mo> <mi>E</mi></mrow> <apply><ci>𝐸</ci></apply> <annotation>\neg E</annotation> <annotation>¬ italic_E</annotation></semantics></math></th><th><math><semantics><mi>E</mi> <ci>𝐸</ci> <annotation>E</annotation> <annotation>italic_E</annotation></semantics></math></th><th><math><semantics><mrow><mo>¬</mo> <mi>E</mi></mrow> <apply><ci>𝐸</ci></apply> <annotation>\neg E</annotation> <annotation>¬ italic_E</annotation></semantics></math></th><th><math><semantics><mi>E</mi> <ci>𝐸</ci> <annotation>E</annotation> <annotation>italic_E</annotation></semantics></math></th><th><math><semantics><mrow><mo>¬</mo> <mi>E</mi></mrow> <apply><ci>𝐸</ci></apply> <annotation>\neg E</annotation> <annotation>¬ italic_E</annotation></semantics></math></th><th></th><th></th><td></td></tr><tr><th colspan="11">zero-shot</th></tr><tr><th>LLaMA3-8B-Instruct</th><td>62.2</td><td>84.3</td><td>89.2</td><td>88.3</td><td>48.3</td><td>79.0</td><td>40.1</td><td>51.6</td><td>53.2</td><td>55.0</td></tr><tr><th>LLaMA3-70B-Instruct</th><td>74.5</td><td>94.3</td><td>96.8</td><td>99.7</td><td>39.9</td><td>83.9</td><td>11.1</td><td>59.7</td><td>63.7</td><td>64.0</td></tr><tr><th colspan="11">zero-shot CoT</th></tr><tr><th>LLaMA3-8B-Instruct</th><td>65.3</td><td>63.5</td><td>96.1</td><td>46.9</td><td>75.7</td><td>65.3</td><td>68.6</td><td>52.4</td><td>57.0</td><td>55.9</td></tr><tr><th>LLaMA3-70B-Instruct</th><td>79.0</td><td>79.2</td><td>99.1</td><td>93.9</td><td>58.2</td><td>48.5</td><td>71.6</td><td>62.1</td><td>65.4</td><td>51.7</td></tr></tbody></table>

Table 6: Accuracy ($\%$) across all datasets of LLaMA3-series.

<table><tbody><tr><th rowspan="2">Prompting</th><th>Standard</th><th colspan="2">Lexical Overlap</th><th colspan="2">Subsequence</th><th colspan="2">Constituent</th><th>Negation</th><th>Position</th><th>Style</th></tr><tr><th></th><th><math><semantics><mi>E</mi> <ci>𝐸</ci> <annotation>E</annotation> <annotation>italic_E</annotation></semantics></math></th><th><math><semantics><mrow><mo>¬</mo> <mi>E</mi></mrow> <apply><ci>𝐸</ci></apply> <annotation>\neg E</annotation> <annotation>¬ italic_E</annotation></semantics></math></th><th><math><semantics><mi>E</mi> <ci>𝐸</ci> <annotation>E</annotation> <annotation>italic_E</annotation></semantics></math></th><th><math><semantics><mrow><mo>¬</mo> <mi>E</mi></mrow> <apply><ci>𝐸</ci></apply> <annotation>\neg E</annotation> <annotation>¬ italic_E</annotation></semantics></math></th><th><math><semantics><mi>E</mi> <ci>𝐸</ci> <annotation>E</annotation> <annotation>italic_E</annotation></semantics></math></th><th><math><semantics><mrow><mo>¬</mo> <mi>E</mi></mrow> <apply><ci>𝐸</ci></apply> <annotation>\neg E</annotation> <annotation>¬ italic_E</annotation></semantics></math></th><th></th><th></th><td></td></tr><tr><th>zero-shot</th><td>56.7</td><td>69.5</td><td>83.8</td><td>58.6</td><td>58.3</td><td>67.5</td><td>40.2</td><td>39.8</td><td>43.3</td><td>51.5</td></tr><tr><th>few-shot (MNLI)</th><td>61.7</td><td>93.3</td><td>38.7</td><td>91.3</td><td>23.3</td><td>96.7</td><td>9.3</td><td>50.0</td><td>47.8</td><td>49.5</td></tr><tr><th>few-shot (shortcut)</th><td>61.7</td><td>86.3</td><td>90.3</td><td>81.7</td><td>56.3</td><td>82.3</td><td>35.0</td><td>46.0</td><td>54.6</td><td>55.7</td></tr></tbody></table>

Table 7: Accuracy ($\%$) across all datasets of GPT-3.5-Turbo.

## Appendix D Appendix: More Discussion on Few-shot Prompting

As discussed above, few-shot ICL is less effective than zero-shot prompting, and few-shot CoT performs worse than zero-shot CoT in several scenarios. This phenomenon may be due to biases introduced by the in-context examples used in few-shot prompting. Similar issues have been reported in other studies. For instance, [^10] observed that demonstrations can introduce biases, leading to reduced performance in language models. [^23] also noted that LLMs might exploit shortcuts in in-context learning, resulting in sub-optimal performance. Moreover, some papers focus specifically on this issue. For instance, [^16] found that factors like the label space, the distribution of the input text, and the overall format of the sequence are critical determinants of task performance. To further explore this issue, we conducted additional experiments using random samples from the remaining examples in each shortcut-laden dataset, beyond those from the MultiNLI dataset initially used in above experiments. The detailed results are shown in Table 7. We observe that LLMs’ performance on shortcut-laden datasets using more similar examples is better than using standard examples, but still worse than zero-shot, indicating that the influence of shortcuts from pre-trained data is more significant than the benefits of in-context examples. LLMs struggle to summarize the important aspects from in-context examples to overcome their inherent biases and are even influenced by the biases from the in-context examples.

[^1]: Josh Achiam, Steven Adler, Sandhini Agarwal, Lama Ahmad, Ilge Akkaya, Florencia Leoni Aleman, Diogo Almeida, Janko Altenschmidt, Sam Altman, Shyamal Anadkat, et al. 2023. Gpt-4 technical report. *arXiv preprint arXiv:2303.08774*.

[^2]: Tom Brown, Benjamin Mann, Nick Ryder, Melanie Subbiah, Jared D Kaplan, Prafulla Dhariwal, Arvind Neelakantan, Pranav Shyam, Girish Sastry, Amanda Askell, et al. 2020. Language models are few-shot learners. *Advances in neural information processing systems*, 33:1877–1901.

[^3]: Mengnan Du, Fengxiang He, Na Zou, Dacheng Tao, and Xia Hu. 2023. Shortcut learning of large language models in natural language understanding. *Communications of the ACM*, 67(1):110–120.

[^4]: Mengnan Du, Varun Manjunatha, Rajiv Jain, Ruchi Deshpande, Franck Dernoncourt, Jiuxiang Gu, Tong Sun, and Xia Hu. 2021. Towards interpreting and mitigating shortcut learning behavior of nlu models. In *Proceedings of the 2021 Conference of the North American Chapter of the Association for Computational Linguistics: Human Language Technologies*, pages 915–929.

[^5]: Robert Geirhos, Jörn-Henrik Jacobsen, Claudio Michaelis, Richard Zemel, Wieland Brendel, Matthias Bethge, and Felix A Wichmann. 2020. Shortcut learning in deep neural networks. *Nature Machine Intelligence*, 2(11):665–673.

[^6]: He He, Sheng Zha, and Haohan Wang. 2019. Unlearn dataset bias in natural language inference by fitting the residual. In *Proceedings of the 2nd Workshop on Deep Learning Approaches for Low-Resource NLP (DeepLo 2019)*, pages 132–142.

[^7]: Robin Jia and Percy Liang. 2017. Adversarial examples for evaluating reading comprehension systems. In *Proceedings of the 2017 Conference on Empirical Methods in Natural Language Processing*, pages 2021–2031.

[^8]: Albert Q Jiang, Alexandre Sablayrolles, Arthur Mensch, Chris Bamford, Devendra Singh Chaplot, Diego de las Casas, Florian Bressand, Gianna Lengyel, Guillaume Lample, Lucile Saulnier, et al. 2023. Mistral 7b. *arXiv preprint arXiv:2310.06825*.

[^9]: Jacob Devlin Ming-Wei Chang Kenton and Lee Kristina Toutanova. 2019. Bert: Pre-training of deep bidirectional transformers for language understanding. In *Proceedings of NAACL-HLT*, pages 4171–4186.

[^10]: JoongHoon Kim, Sangmin Lee, Seung Hun Han, Saeran Park, Jiyoon Lee, Kiyoon Jeong, and Pilsung Kang. 2023. Which is better? exploring prompting strategy for llm-based metrics. In *Proceedings of the 4th Workshop on Evaluation and Comparison of NLP Systems*, pages 164–183.

[^11]: Takeshi Kojima, Shixiang Shane Gu, Machel Reid, Yutaka Matsuo, and Yusuke Iwasawa. 2022. Large language models are zero-shot reasoners. *Advances in neural information processing systems*, 35:22199–22213.

[^12]: Kalpesh Krishna, John Wieting, and Mohit Iyyer. 2020. Reformulating unsupervised style transfer as paraphrase generation. In *Proceedings of the 2020 Conference on Empirical Methods in Natural Language Processing (EMNLP)*, pages 737–762.

[^13]: Yuxuan Lai, Chen Zhang, Yansong Feng, Quzhe Huang, and Dongyan Zhao. 2021. Why machine reading comprehension models learn shortcuts? In *Findings of the Association for Computational Linguistics: ACL-IJCNLP 2021*, pages 989–1002.

[^14]: Moritz Laurer, Wouter Van Atteveldt, Andreu Casas, and Kasper Welbers. 2024. Less annotating, more classifying: Addressing the data scarcity issue of supervised machine learning with deep transfer learning and bert-nli. *Political Analysis*, 32(1):84–100.

[^15]: R Thomas McCoy, Ellie Pavlick, and Tal Linzen. 2020. Right for the wrong reasons: Diagnosing syntactic heuristics in natural language inference. In *57th Annual Meeting of the Association for Computational Linguistics, ACL 2019*, pages 3428–3448.

[^16]: Sewon Min, Xinxi Lyu, Ari Holtzman, Mikel Artetxe, Mike Lewis, Hannaneh Hajishirzi, and Luke Zettlemoyer. 2022. Rethinking the role of demonstrations: What makes in-context learning work? In *Proceedings of the 2022 Conference on Empirical Methods in Natural Language Processing*, pages 11048–11064.

[^17]: Aakanksha Naik, Abhilasha Ravichander, Norman Sadeh, Carolyn Rose, and Graham Neubig. 2018. Stress test evaluation for natural language inference. In *Proceedings of the 27th International Conference on Computational Linguistics*, pages 2340–2353.

[^18]: OpenAI. 2023. Introducing chatgpt. OpenAI Blog. Available: [https://openai.com/blog/chatgpt](https://openai.com/blog/chatgpt).

[^19]: Fanchao Qi, Yangyi Chen, Xurui Zhang, Mukai Li, Zhiyuan Liu, and Maosong Sun. 2021. Mind the style of text! adversarial and backdoor attacks based on text style transfer. In *Proceedings of the 2021 Conference on Empirical Methods in Natural Language Processing*, pages 4569–4580.

[^20]: Marco Tulio Ribeiro, Tongshuang Wu, Carlos Guestrin, and Sameer Singh. 2020. Beyond accuracy: Behavioral testing of nlp models with checklist. In *Proceedings of the 58th Annual Meeting of the Association for Computational Linguistics*, pages 4902–4912.

[^21]: Priyanka Sen and Amir Saffari. 2020. What do models learn from question answering datasets? In *Proceedings of the 2020 Conference on Empirical Methods in Natural Language Processing (EMNLP)*, pages 2429–2438.

[^22]: Richard Socher, Alex Perelygin, Jean Wu, Jason Chuang, Christopher D Manning, Andrew Y Ng, and Christopher Potts. 2013. Recursive deep models for semantic compositionality over a sentiment treebank. In *Proceedings of the 2013 conference on empirical methods in natural language processing*, pages 1631–1642.

[^23]: Ruixiang Tang, Dehan Kong, Longtao Huang, and Hui Xue. 2023. Large language models can be lazy learners: Analyze shortcuts in in-context learning. In *Findings of the Association for Computational Linguistics: ACL 2023*, pages 4645–4657.

[^24]: Gemini Team, Rohan Anil, Sebastian Borgeaud, Yonghui Wu, Jean-Baptiste Alayrac, Jiahui Yu, Radu Soricut, Johan Schalkwyk, Andrew M Dai, Anja Hauth, et al. 2023. Gemini: a family of highly capable multimodal models. *arXiv preprint arXiv:2312.11805*.

[^25]: Hugo Touvron, Louis Martin, Kevin Stone, Peter Albert, Amjad Almahairi, Yasmine Babaei, Nikolay Bashlykov, Soumya Batra, Prajjwal Bhargava, Shruti Bhosale, et al. 2023. Llama 2: Open foundation and fine-tuned chat models. *arXiv preprint arXiv:2307.09288*.

[^26]: Jason Wei, Xuezhi Wang, Dale Schuurmans, Maarten Bosma, Fei Xia, Ed Chi, Quoc V Le, Denny Zhou, et al. 2022. Chain-of-thought prompting elicits reasoning in large language models. *Advances in Neural Information Processing Systems*, 35:24824–24837.

[^27]: Adina Williams, Nikita Nangia, and Samuel Bowman. 2018. A broad-coverage challenge corpus for sentence understanding through inference. In *Proceedings of the 2018 Conference of the North American Chapter of the Association for Computational Linguistics: Human Language Technologies, Volume 1 (Long Papers)*, pages 1112–1122.

[^28]: Miao Xiong, Zhiyuan Hu, Xinyang Lu, YIFEI LI, Jie Fu, Junxian He, and Bryan Hooi. 2023. Can llms express their uncertainty? an empirical evaluation of confidence elicitation in llms. In *The Twelfth International Conference on Learning Representations*.

[^29]: Linan Yue, Qi Liu, Yichao Du, Li Wang, Weibo Gao, and Yanqing An. 2024. Towards faithful explanations: Boosting rationalization with shortcuts discovery. In *The Twelfth International Conference on Learning Representations*.

[^30]: Aohan Zeng, Xiao Liu, Zhengxiao Du, Zihan Wang, Hanyu Lai, Ming Ding, Zhuoyi Yang, Yifan Xu, Wendi Zheng, Xiao Xia, et al. 2022. Glm-130b: An open bilingual pre-trained model. In *The Eleventh International Conference on Learning Representations*.

[^31]: Yuan Zhang, Jason Baldridge, and Luheng He. 2019. Paws: Paraphrase adversaries from word scrambling. In *Proceedings of the 2019 Conference of the North American Chapter of the Association for Computational Linguistics: Human Language Technologies, Volume 1 (Long and Short Papers)*, pages 1298–1308.

[^32]: Jieyu Zhao, Tianlu Wang, Mark Yatskar, Vicente Ordonez, and Kai-Wei Chang. 2018. Gender bias in coreference resolution: Evaluation and debiasing methods. In *Proceedings of the 2018 Conference of the North American Chapter of the Association for Computational Linguistics: Human Language Technologies, Volume 2 (Short Papers)*, pages 15–20.

[^33]: Lili Zhao, Qi Liu, Linan Yue, Wei Chen, Liyi Chen, Ruijun Sun, and Chao Song. 2024. Comi: Correct and mitigate shortcut learning behavior in deep neural networks. In *Proceedings of the 47th International ACM SIGIR Conference on Research and Development in Information Retrieval*, pages 218–228.