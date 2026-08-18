---
title: "A benchmark of expert-level academic questions to assess AI capabilities"
source: "https://www.nature.com/articles/s41586-025-09962-4"
author:
published: 2026-01-28
created: 2026-06-23
description: "Benchmarks are important tools for tracking the rapid advancements in large language model (LLM) capabilities. However, benchmarks are not keeping pace in difficulty: LLMs now achieve more than 90% accuracy on popular benchmarks such as Measuring Massive Multitask Language Understanding1, limiting informed measurement of state-of-the-art LLM capabilities. Here, in response, we introduce Humanity’s Last Exam (HLE), a multi-modal benchmark at the frontier of human knowledge, designed to be an expert-level closed-ended academic benchmark with broad subject coverage. HLE consists of 2,500 questions across dozens of subjects, including mathematics, humanities and the natural sciences. HLE is developed globally by subject-matter experts and consists of multiple-choice and short-answer questions suitable for automated grading. Each question has a known solution that is unambiguous and easily verifiable but cannot be quickly answered by internet retrieval. State-of-the-art LLMs demonstrate low accuracy and calibration on HLE, highlighting a marked gap between current LLM capabilities and the expert human frontier on closed-ended academic questions. To inform research and policymaking upon a clear understanding of model capabilities, we publicly release HLE at https://lastexam.ai . Humanity’s Last Exam, a multi-modal benchmark at the frontier of human knowledge, is designed to be an expert-level closed-ended academic benchmark with broad subject coverage."
tags:
  - "clippings"
---
## Abstract

Benchmarks are important tools for tracking the rapid advancements in large language model (LLM) capabilities. However, benchmarks are not keeping pace in difficulty: LLMs now achieve more than 90% accuracy on popular benchmarks such as Measuring Massive Multitask Language Understanding [^1], limiting informed measurement of state-of-the-art LLM capabilities. Here, in response, we introduce Humanity’s Last Exam (HLE), a multi-modal benchmark at the frontier of human knowledge, designed to be an expert-level closed-ended academic benchmark with broad subject coverage. HLE consists of 2,500 questions across dozens of subjects, including mathematics, humanities and the natural sciences. HLE is developed globally by subject-matter experts and consists of multiple-choice and short-answer questions suitable for automated grading. Each question has a known solution that is unambiguous and easily verifiable but cannot be quickly answered by internet retrieval. State-of-the-art LLMs demonstrate low accuracy and calibration on HLE, highlighting a marked gap between current LLM capabilities and the expert human frontier on closed-ended academic questions. To inform research and policymaking upon a clear understanding of model capabilities, we publicly release HLE at [https://lastexam.ai](https://lastexam.ai/).

## Main

The capabilities of large language models (LLMs) have advanced markedly, exceeding human performance across a diverse array of tasks. To systematically measure these capabilities, LLMs are evaluated on benchmarks: collections of questions that assess model performance on tasks such as math, programming or biology. However, state-of-the-art LLMs [^2] [^3] [^4] [^5] [^6] now achieve more than 90% accuracy on popular benchmarks such as Measuring Massive Multitask Language Understanding (MMLU) [^1], which were once challenging frontiers for LLMs. The saturation of existing benchmarks, as shown in Fig. [1](https://www.nature.com/articles/s41586-025-09962-4#Fig1), limits our ability to precisely measure artificial intelligence (AI) capabilities and calls for more challenging evaluations that can meaningfully assess the rapid improvements in LLM capabilities at the frontiers of human knowledge.

![Fig. 1: Performance of frontier LLMs on popular benchmarks and HLE.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs41586-025-09962-4/MediaObjects/41586_2025_9962_Fig1_HTML.png?as=webp)

Fig. 1: Performance of frontier LLMs on popular benchmarks and HLE.

To address this gap, we introduce HLE (originally defined as Humanity’s Last Exam, although we will use the term HLE for this paper), a benchmark of 2,500 challenging questions from dozens of subject areas, designed to assess LLM capabilities at an expert level in broad academic subjects. HLE is developed by academics and domain experts, providing a precise measure of capabilities as LLMs continue to improve (see section ‘ [Collection](https://www.nature.com/articles/s41586-025-09962-4#Sec3) ’). HLE is multi-modal, featuring questions that are either text-only or accompanied by an image reference and includes both multiple-choice and exact-match questions for automated answer verification. Questions are original, precise, unambiguous and resistant to simple internet lookup or database retrieval. Among the diversity of questions in the benchmark, HLE emphasizes world-class mathematics problems aimed at testing deep reasoning skills broadly applicable across multiple academic areas.

We use a multi-stage review process to thoroughly ensure question difficulty and quality (see section ‘ [Review](https://www.nature.com/articles/s41586-025-09962-4#Sec7) ’). Before submission, each question is tested against state-of-the-art LLMs to verify its difficulty—questions are rejected if LLMs can answer them correctly. Questions submitted are then processed through a two-stage reviewing process: (1) an initial feedback round with multiple graduate-level reviewers and (2) an approval of organizer and expert reviewer, ensuring quality and adherence to our submission criteria. Following the release, we conducted a public review period, welcoming community feedback to correct any points of concern in the dataset.

Frontier LLMs consistently demonstrate low accuracy across all models, highlighting a marked gap between current capabilities and expert-level academic performance (see section ‘ [Evaluation](https://www.nature.com/articles/s41586-025-09962-4#Sec10) ’). Models also provide incorrect answers with high confidence rather than acknowledging uncertainty on these challenging questions, with most models exhibiting root mean square (RMS) calibration errors above 70%.

As AI systems approach human expert performance in many domains, precise measurement of their capabilities and limitations is essential for informing research, governance and the broader public. High performance on HLE would suggest expert-level capabilities on closed-ended academic questions. To establish a common reference point for assessing these capabilities, we publicly release a large number of 2,500 questions from HLE to enable this precise measurement, while maintaining a private test set to assess potential model overfitting.

## Dataset

### Collection

HLE consists of 2,500 challenging questions across over a hundred subjects. A high-level summary is provided in Fig. [2](https://www.nature.com/articles/s41586-025-09962-4#Fig2). HLE is a global collaborative effort, with questions from nearly 1,000 subject expert contributors affiliated with more than 500 institutions across 50 countries—comprised mostly of professors, researchers and graduate degree holders. Examples of the diverse and challenging questions submitted to HLE are shown in Fig. [3](https://www.nature.com/articles/s41586-025-09962-4#Fig3).

![Fig. 2: Distribution of HLE questions across categories.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs41586-025-09962-4/MediaObjects/41586_2025_9962_Fig2_HTML.png?as=webp)

Fig. 2: Distribution of HLE questions across categories.

![Fig. 3: Example questions from HLE.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs41586-025-09962-4/MediaObjects/41586_2025_9962_Fig3_HTML.png?as=webp)

Fig. 3: Example questions from HLE.

#### Question style

HLE contains two question formats: exact-match questions (models provide an exact string as output) and multiple-choice questions (the model selects one of five or more answer choices). HLE is a multi-modal benchmark, with around 14% of questions requiring comprehending both text and an image; 24% of questions are multiple-choice, with the remainder being exact match.

Each question submission includes several required components: the question text itself, answer specifications (either an exact-match answer or multiple-choice options with the correct answer marked), detailed rationale explaining the solution, academic subject and name of the contributor and institutional affiliation to maintain accountability and accuracy.

#### Submission format

To ensure question quality and integrity, we enforce strict submission criteria. Questions should be precise, unambiguous, solvable and non-searchable, ensuring models cannot rely on memorization or simple retrieval methods. All submissions must be original work or non-trivial syntheses of published information, although contributions from unpublished research are acceptable. Questions typically require graduate-level expertise or test knowledge of highly specific topics (for example, precise historical details, trivia and local customs) and have specific, unambiguous answers accepted by domain experts. When LLMs provide correct answers with faulty reasoning, authors are encouraged to modify question parameters, such as the number of answer choices, to discourage false positives. We require clear English with precise technical terminology, supporting LaTeX notation wherever necessary. Answers are kept short and easily verifiable for exact-match questions to support automatic grading. We prohibit open-ended questions, subjective interpretations, and content related to weapons of mass destruction. Finally, every question is accompanied by a detailed solution to verify accuracy. More details about guidelines for contributors can be found in Supplementary Information section [1](https://www.nature.com/articles/s41586-025-09962-4#MOESM1).

#### Prize pool

To attract high-quality submissions, we establish a USD$500,000 prize pool, with prizes of USD$5,000 for each of the top 50 questions and USD$500 for each of the next 500 questions, as determined by organizers. This incentive structure, combined with the opportunity for paper co-authorship for anyone with an accepted question in HLE, draws participation from qualified experts, particularly those with advanced degrees or notable technical experience in their fields.

### Review

#### LLM difficulty check

To ensure question difficulty, each question is first validated against several frontier LLMs before submission ([Methods](https://www.nature.com/articles/s41586-025-09962-4#Sec19)). If the LLMs cannot solve the question (or, in the case of multiple choices, if the models on average do worse than random guessing), the question proceeds to the next stage: human expert review. In total, we logged more than 70,000 attempts, resulting in approximately 13,000 questions, which stumped LLMs that were forwarded to expert human review.

#### Expert review

Our human reviewers possess a graduate degree (for example, master’s, PhD and JD) in their fields. Reviewers select submissions in their domain, grading them against standardized rubrics and offering feedback when applicable. There are two rounds of reviews. The first round focuses on iteratively refining submissions, with each question receiving between one and three reviews. The primary goal is to help the question contributors (who are primarily academics and researchers from a wide range of disciplines) better design questions that are closed-ended, robust and of high quality for AI evaluation. In the second round, good and outstanding questions from the first round are identified and approved by organizers and reviewers to be included in the final HLE dataset. Details, instructions and rubrics for both rounds can be found in Supplementary Information section [2](https://www.nature.com/articles/s41586-025-09962-4#MOESM1). Figure [4](https://www.nature.com/articles/s41586-025-09962-4#Fig4) shows our full process.

![Fig. 4: HLE dataset creation pipeline.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs41586-025-09962-4/MediaObjects/41586_2025_9962_Fig4_HTML.png?as=webp)

Fig. 4: HLE dataset creation pipeline.

## Evaluation

We evaluate the performance of state-of-the-art LLMs on HLE and analyse their capabilities across different question types and domains. We describe our evaluation setup (see section ‘ [Setup](https://www.nature.com/articles/s41586-025-09962-4#Sec11) ’) and present several quantitative results on metrics that track model performance (see section ‘ [Quantitative results](https://www.nature.com/articles/s41586-025-09962-4#Sec12) ’).

### Setup

After data collection and review, we evaluated our final HLE dataset on additional frontier multi-modal LLMs. We use a standardized system prompt that structures model responses into explicit reasoning followed by a final answer. As the question–answers are precise and close-ended, we use o3-mini as a judge to verify answer correctness against model predictions while accounting for equivalent formats (for example, decimals compared with fractions or estimations). Evaluation prompts are detailed in the [Methods](https://www.nature.com/articles/s41586-025-09962-4#Sec19).

### Quantitative results

#### Accuracy

All frontier models achieve low accuracy on HLE (Table [1](https://www.nature.com/articles/s41586-025-09962-4#Tab1)), highlighting substantial room for improvement in narrowing the gap between current LLMs and expert-level academic capabilities on closed-ended questions. These low scores are partially by design the dataset collection process attempts to filter out questions that existing models can answer correctly. Nevertheless, we notice on evaluation that models exhibit non-zero accuracy. This is due to inherent noise in model inference—models can inconsistently guess the right answer or guess worse than random chance for multiple-choice questions. We notice an elevated accuracy on multiple-choice questions compared with exact-answer questions in Extended Data Table. [3](https://www.nature.com/articles/s41586-025-09962-4#Tab4). We choose to leave these questions in the dataset as a natural component instead of strongly adversarially filtering. However, we stress that the true capability floor of frontier models on the dataset will remain an open question, and small inflections close to zero accuracy are not strongly indicative of progress.

**Table 1 Accuracy and RMS calibration error of different models on HLE, demonstrating low accuracy and high calibration error across all models**

#### Calibration error

Given low performance on HLE, models should be calibrated, recognizing their uncertainty rather than confidently provide incorrect answers. To measure calibration, we prompt models to provide both an answer and their confidence from 0% to 100% ([Methods](https://www.nature.com/articles/s41586-025-09962-4#Sec19)), using the setup from [^7]. The implementation of our RMS calibration error is from ref. [^8]. The stated confidence of a well-calibrated model should match its actual accuracy, for example, achieving 50% accuracy on questions, in which it claims 50% confidence. Table [1](https://www.nature.com/articles/s41586-025-09962-4#Tab1) shows poor calibration across all models, reflected in high RMS calibration error scores. Models frequently provide incorrect answers with high confidence on HLE, failing to recognize when questions exceed their capabilities.

#### Inference time computation

Reasoning models are designed to spend extra compute thinking before answering: they generate intermediate reasoning tokens and then produce the final response, which means substantially more tokens must be decoded at inference time [^5] [^6]. To shed light on this in our evaluation, we analyse the compute-intensive scaling of output tokens (including reasoning tokens) across several state-of-the-art reasoning models in Fig. [5](https://www.nature.com/articles/s41586-025-09962-4#Fig5). Through binning output lengths with a log <sub>2</sub> scale, we observe a log-linear scaling of accuracy with more reasoning tokens; however, this trend reverses after 2 <sup>14</sup> tokens, highlighting that a larger reasoning budget is not always optimal. The observation that accuracy benefits diminish beyond a certain threshold suggests that future models should improve not only their raw accuracy on HLE but also their computational efficiency.

![Fig. 5: Accuracy compared with reasoning token budget.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs41586-025-09962-4/MediaObjects/41586_2025_9962_Fig5_HTML.png?as=webp)

Fig. 5: Accuracy compared with reasoning token budget.

## Discussion

### Limitations

Although present-day LLMs achieve very low accuracy on HLE, recent history shows benchmarks are quickly saturated—with models markedly progressing from near-zero to near-perfect performance in a short timeframe [^9] [^10]. High accuracy on HLE would demonstrate expert-level performance on closed-ended, verifiable questions and cutting-edge scientific knowledge, but it would not alone suggest autonomous research capabilities or artificial general intelligence [^11]. HLE tests structured academic problems rather than open-ended research or creative problem-solving abilities, making it a focused measure of technical knowledge and reasoning across a diverse range of subjects, albeit with a stronger representation in math and STEM (science, technology, engineering and mathematics) disciplines, as shown in Fig. [2](https://www.nature.com/articles/s41586-025-09962-4#Fig2). By pushing the limits of established closed-ended benchmarks, HLE is intended to hasten the transition towards a new class of benchmarks focused on more dynamic and open-ended AI capabilities.

### Impact

By providing a clear measure of AI progress, HLE creates a common reference point for scientists and policymakers to assess AI capabilities. This enables more informed discussions about development trajectories, potential risks and necessary governance measures.

## Methods

### Related works

#### LLM benchmarks

Benchmarks are important tools for tracking the rapid advancement of LLM capabilities, including general and scientific knowledge [^1] [^10] [^12] [^13] [^14] [^15] and mathematical reasoning [^16] [^17] [^18] [^19] [^20] [^21], code generation [^22] [^23] [^24] [^25] [^26] [^27] [^28] and general-purpose human assistance [^7] [^29] [^30] [^31] [^32] [^33] [^34] [^35]. Owing to their objectivity and ease of automated scoring at scale, evaluations commonly include multiple-choice and short-answer questions [^31] [^36] [^37] [^38] [^39], with benchmarks such as MMLU [^1] also spanning a broad range of academic disciplines and levels of complexity.

#### Saturation and frontier benchmark design

However, state-of-the-art models now achieve nearly perfect scores on many existing evaluations, obscuring the full extent of current and future frontier AI capabilities [^40] [^41] [^42] [^43]. This has motivated the development of more challenging benchmarks that test for multi-modal capabilities [^17] [^22] [^24] [^44] [^45] [^46] [^47] [^48] [^49] [^50], strengthen existing benchmarks [^32] [^44] [^45] [^51] [^52], filter questions over multiple stages of review [^9] [^12] [^19] [^42] [^53] [^54] and use experts to write tests for advanced academic knowledge [^9] [^12] [^19] [^54] [^55] [^56]. HLE combines these approaches: the questions are developed by subject-matter experts and undergo multiple rounds of review, while preserving the broad subject-matter coverage of MMLU. As a result, HLE provides a clear measurement of the gap between current AI capabilities and human expertise on closed-ended academic tasks, complementing other assessments of advanced capabilities in open-ended domains [^57] [^58].

### Dataset

#### Submission process

To ensure question difficulty, we automatically check the accuracy of frontier LLMs on each question before submission. Our testing process uses multi-modal LLMs for text-and-image questions (GPT-4o, Gemini 1.5 Pro, Claude 3.5 Sonnet and o1) and adds two non-multi-modal models (o1-mini and o1-preview) for text-only questions. We use different submission criteria by question type: exact-match questions must stump all models, whereas multiple-choice questions must stump all but one model to account for potential lucky guesses. Users are instructed to submit only questions that meet these criteria. We note that due to non-determinism in models and a non-zero floor in multiple-choice questions, further evaluation on the dataset exhibits some low but non-zero accuracy.

#### Post-release

### Late contributions

In response to research community interest, we opened the platform for late contributors after the initial release, resulting in thousands of submissions. Each submission was manually reviewed by organizers. The new questions are of similar difficulty and quality to our initial dataset, resulting in a second held-out private set, which will be used in future evaluations.

### Refinement

Community feedback: owing to the advanced, specialized nature of many submissions, reviewers were not expected to verify the full accuracy of each provided solution rationale, instead focusing on whether the question aligns with guidelines. Given this limitation in the review process, we launched a community feedback bug bounty program following the initial release of the dataset to identify and eliminate the main errors in the dataset, namely, label errors and other errors in the statement of the question. Each error report was manually verified by the organizers with feedback from the original author of the question when appropriate.

Searchable questions: a question is potentially searchable if a model with search tools answered correctly, but answered incorrectly without search. Each of these potentially searchable questions was then manually audited, removing any that were easily found using web search. We used GPT-4o mini/GPT-4o search and Perplexity Sonar models in this procedure. We observe that current frontier model performance on HLE after applying this procedure is similar to the performance on HLE before applying this procedure.

#### Expert disagreement rate

Before release, we conducted two main rounds of auditing, each on a sample of 200 questions. We recruited students from top universities in the United States to fully solve a sample of questions from HLE. Errors flagged were routed between organizers, original question authors and auditors until consensus was reached. We used data from these audits to further refine our dataset. The first round aimed to identify common categories of imprecise questions, such as open-ended formats, reliance on rounded numerical values or submissions from authors with low acceptance rates. Based on these signals, we manually removed or revised potential questions with similar issues before conducting a second audit on a new sample of 200 questions. This iterative process yielded a final estimated expert disagreement rate of 15.4% for the public set. This level of expert disagreement is in line with what is observed in other well-known machine learning benchmarks [^59] [^60] [^61] [^62].

Disagreement rates are often higher in domains such as health and medicine. A targeted peer review on a biology, chemistry and health subset, proposed in ref. [^63], found an expert disagreement rate of approximately 18%. This is also observed in other similarly expert-grade work; for example [^64], notes that disagreement among expert physicians is frequent on complex health topics. To aid future community efforts in identifying other potential dataset errors, we outline several key factors that contribute to the complexity of these audits below:

- The need for multiple experts: our multi-reviewer process highlighted the complexity of these questions. In several cases, a reviewer identified an important piece of information, such as a decades-old paper or a foundational concept not immediately apparent to others, that was essential to confirming the validity of an answer. To illustrate, if we were to adopt a single-reviewer methodology in which a question is flagged based on just one dissenting expert, the disagreement rate on the aforementioned health-focused subset jumps from 18% to 25%, which is close to the approximate numbers and method from ref. [^63]. This discrepancy highlights the importance of a standard peer-review process, complete with multiple reviewers and author rebuttal, for HLE questions.
- Questions from research experience: HLE is intentionally designed to include questions based on insights from the direct, hands-on experiments of its contributors. This design captures knowledge gained from direct research experiences, which is often difficult to verify through standard literature searches or by external reviewers. This was done to test model knowledge beyond what is readily indexed on the internet.
- Understanding question design: designing challenging closed-ended research questions is difficult. Consequently, the objective for some HLE multiple-choice questions is to identify the most plausible answer among the provided options. Some external reviewers, unfamiliar with these design principles, sought to find external sources to support an open-ended answer rather than evaluating the best choice among the given options.

#### HLE-Rolling

Inspired by these valuable community discussions and researcher interest across disciplines in contributing to the dataset, and as part of our commitment to continual improvement, we will introduce a dynamic fork of the dataset post-release: HLE-Rolling. This version will be regularly updated to address community feedback and integrate new questions. Information about the updates will be made publicly available at [https://lastexam.ai](https://lastexam.ai/). Our goal is to provide a seamless migration path for researchers once frontier models begin to hit the noise ceiling performance on the original HLE dataset.

#### Prompts

We use the following system prompt for evaluating LLMs on HLE questions. For models that do not support a system prompt, we add it as a separate user prompt.

Your response should be in the following format:

Explanation: {your explanation for your answer choice}

Answer: {your chosen answer}

Confidence: {your confidence score between 00% and 100% for your answer}

We use the following system prompt to judge the model answers against the correct answers for our evaluations in Table [1](https://www.nature.com/articles/s41586-025-09962-4#Tab1). We used o3-mini-2025-01-31 with structured decoding enabled to get an extracted\_final\_answer, reasoning, correct, confidence extraction for each output. An example of a structured response using an LLM judge is shown in Extended Data Fig. [1](https://www.nature.com/articles/s41586-025-09962-4#Fig6).

Judge whether the following \[response\] to \[question\] is correct or not based on the precise and unambiguous \[correct\_answer\] below.

\[question\]: {question}

\[response\]: {response}

Your judgement must be in the format and criteria specified below:

extracted\_final\_answer: The final exact answer extracted from the \[response\]. Put the extracted answer as 'None' if there is no exact, final answer to extract from the response.

\[correct\_answer\]: {correct\_answer}

reasoning: Explain why the extracted\_final\_answer is correct or incorrect based on \[correct\_answer\], focusing only on if there are meaningful differences between \[correct\_answer\] and the extracted\_final\_answer. Do not comment on any background to the problem, do not attempt to solve the problem, do not argue for any answer different than \[correct\_answer\], focus only on whether the answers match.

correct: Answer 'yes' if extracted\_final\_answer matches the \[correct\_answer\] given above, or is within a small margin of error for numerical problems. Answer 'no' otherwise, i.e. if there if there is any inconsistency, ambiguity, non-equivalency, or if the extracted answer is incorrect.

confidence: The extracted confidence score between 0|%| and 100|%| from \[response\]. Put 100 if there is no confidence score available.

## Data availability

The HLE dataset is open-source and available at [https://huggingface.co/datasets/cais/hle](https://huggingface.co/datasets/cais/hle). Important updates to the project and dataset will be announced at [https://lastexam.ai](https://lastexam.ai/).

## Code availability

The inference script for benchmarking AI systems on HLE is available at GitHub ([https://github.com/centerforaisafety/hle](https://github.com/centerforaisafety/hle)).
