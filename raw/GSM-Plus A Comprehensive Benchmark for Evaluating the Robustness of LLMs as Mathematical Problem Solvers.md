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

[^1]: Janice Ahn, Rishu Verma, Renze Lou, Di Liu, Rui Zhang, and Wenpeng Yin. 2024. Large language models for mathematical reasoning: Progresses and challenges. *arXiv preprint arXiv:2402.00157*.

[^2]: Zhangir Azerbayev, Hailey Schoelkopf, Keiran Paster, Marco Dos Santos, Stephen McAleer, Albert Q Jiang, Jia Deng, Stella Biderman, and Sean Welleck. 2023. Llemma: An open language model for mathematics. *arXiv preprint arXiv:2310.10631*.

[^3]: Arthur J Baroody. 1987. *Children’s mathematical thinking: A developmental framework for preschool, primary, and special education teachers.* Teachers College Press.

[^4]: Lukas Berglund, Meg Tong, Max Kaufmann, Mikita Balesni, Asa Cooper Stickland, Tomasz Korbak, and Owain Evans. 2023. The reversal curse: Llms trained on" a is b" fail to learn" b is a". *arXiv preprint arXiv:2309.12288*.

[^5]: Tom Brown, Benjamin Mann, Nick Ryder, Melanie Subbiah, Jared D Kaplan, Prafulla Dhariwal, Arvind Neelakantan, Pranav Shyam, Girish Sastry, Amanda Askell, et al. 2020. Language models are few-shot learners. *Advances in neural information processing systems*, 33:1877–1901.

[^6]: Sébastien Bubeck, Varun Chandrasekaran, Ronen Eldan, Johannes Gehrke, Eric Horvitz, Ece Kamar, Peter Lee, Yin Tat Lee, Yuanzhi Li, Scott Lundberg, et al. 2023. Sparks of artificial general intelligence: Early experiments with gpt-4. *arXiv preprint arXiv:2303.12712*.

[^7]: Thomas P Carpenter, Elizabeth Fennema, Penelope L Peterson, Chi-Pang Chiang, and Megan Loef. 1989. Using knowledge of children’s mathematics thinking in classroom teaching: An experimental study. *American educational research journal*, 26(4):499–531.

[^8]: Wenhu Chen, Xueguang Ma, Xinyi Wang, and William W Cohen. 2022. Program of thoughts prompting: Disentangling computation from reasoning for numerical reasoning tasks. *arXiv preprint arXiv:2211.12588*.

[^9]: Wenhu Chen, Ming Yin, Max Ku, Pan Lu, Yixin Wan, Xueguang Ma, Jianyu Xu, Xinyi Wang, and Tony Xia. 2023. Theoremqa: A theorem-driven question answering dataset. *arXiv preprint arXiv:2305.12524*.

[^10]: Ethan Chern, Haoyang Zou, Xuefeng Li, Jiewen Hu, Kehua Feng, Junlong Li, and Pengfei Liu. 2023. Generative ai for math: Abel. [https://github.com/GAIR-NLP/abel](https://github.com/GAIR-NLP/abel).

[^11]: Karl Cobbe, Vineet Kosaraju, Mohammad Bavarian, Mark Chen, Heewoo Jun, Lukasz Kaiser, Matthias Plappert, Jerry Tworek, Jacob Hilton, Reiichiro Nakano, et al. 2021. Training verifiers to solve math word problems. *arXiv preprint arXiv:2110.14168*.

[^12]: Aniruddha Deb, Neeva Oza, Sarthak Singla, Dinesh Khandelwal, Dinesh Garg, and Parag Singla. 2023. Fill in the blank: Exploring and enhancing llm capabilities for backward reasoning in math word problems. *arXiv preprint arXiv:2310.01991*.

[^13]: Yao Fu, Hao Peng, Ashish Sabharwal, Peter Clark, and Tushar Khot. 2022. Complexity-based prompting for multi-step reasoning. *arXiv preprint arXiv:2210.00720*.

[^14]: Luyu Gao, Aman Madaan, Shuyan Zhou, Uri Alon, Pengfei Liu, Yiming Yang, Jamie Callan, and Graham Neubig. 2023. Pal: Program-aided language models. In *International Conference on Machine Learning*, pages 10764–10799.

[^15]: Shahriar Golchin and Mihai Surdeanu. 2023. Time travel in llms: Tracing data contamination in large language models. *arXiv preprint arXiv:2308.08493*.

[^16]: Zhibin Gou, Zhihong Shao, Yeyun Gong, Yujiu Yang, Minlie Huang, Nan Duan, Weizhu Chen, et al. 2023. Tora: A tool-integrated reasoning agent for mathematical problem solving. *arXiv preprint arXiv:2309.17452*.

[^17]: Dan Hendrycks, Collin Burns, Saurav Kadavath, Akul Arora, Steven Basart, Eric Tang, Dawn Song, and Jacob Steinhardt. 2021. Measuring mathematical problem solving with the math dataset. In *Thirty-fifth Conference on Neural Information Processing Systems Datasets and Benchmarks Track (Round 2)*.

[^18]: Albert Q Jiang, Alexandre Sablayrolles, Arthur Mensch, Chris Bamford, Devendra Singh Chaplot, Diego de las Casas, Florian Bressand, Gianna Lengyel, Guillaume Lample, Lucile Saulnier, et al. 2023. Mistral 7b. *arXiv preprint arXiv:2310.06825*.

[^19]: Di Jin, Zhijing Jin, Joey Tianyi Zhou, and Peter Szolovits. 2020. Is bert really robust? a strong baseline for natural language attack on text classification and entailment. In *Proceedings of the AAAI conference on artificial intelligence*, volume 34, pages 8018–8025.

[^20]: Tushar Khot, Harsh Trivedi, Matthew Finlayson, Yao Fu, Kyle Richardson, Peter Clark, and Ashish Sabharwal. 2022. Decomposed prompting: A modular approach for solving complex tasks. In *The Eleventh International Conference on Learning Representations*.

[^21]: Takeshi Kojima, Shixiang Shane Gu, Machel Reid, Yutaka Matsuo, and Yusuke Iwasawa. 2022. Large language models are zero-shot reasoners. *Advances in neural information processing systems*, 35:22199–22213.

[^22]: Nate Kushman, Yoav Artzi, Luke Zettlemoyer, and Regina Barzilay. 2014. Learning to automatically solve algebra word problems. In *Proceedings of the 52nd Annual Meeting of the Association for Computational Linguistics (Volume 1: Long Papers)*, pages 271–281.

[^23]: Brenden M Lake, Tomer D Ullman, Joshua B Tenenbaum, and Samuel J Gershman. 2017. Building machines that learn and think like people. *Behavioral and brain sciences*, 40:e253.

[^24]: Linyang Li, Ruotian Ma, Qipeng Guo, Xiangyang Xue, and Xipeng Qiu. 2020. Bert-attack: Adversarial attack against bert using bert. In *Proceedings of the 2020 Conference on Empirical Methods in Natural Language Processing (EMNLP)*, pages 6193–6202.

[^25]: Zekun Li, Baolin Peng, Pengcheng He, and Xifeng Yan. 2023. Do you really follow me? adversarial instructions for evaluating the robustness of large language models. *arXiv preprint arXiv:2308.10819*.

[^26]: Zhenwen Liang, Dian Yu, Xiaoman Pan, Wenlin Yao, Qingkai Zeng, Xiangliang Zhang, and Dong Yu. 2023. Mint: Boosting generalization in mathematical reasoning via multi-view fine-tuning. *arXiv preprint arXiv:2307.07951*.

[^27]: Wang Ling, Dani Yogatama, Chris Dyer, and Phil Blunsom. 2017. Program induction by rationale generation: Learning to solve and explain algebraic word problems. In *Proceedings of the 55th Annual Meeting of the Association for Computational Linguistics, ACL*, pages 158–167.

[^28]: Haipeng Luo, Qingfeng Sun, Can Xu, Pu Zhao, Jianguang Lou, Chongyang Tao, Xiubo Geng, Qingwei Lin, Shifeng Chen, and Dongmei Zhang. 2023. Wizardmath: Empowering mathematical reasoning for large language models via reinforced evol-instruct. *arXiv preprint arXiv:2308.09583*.

[^29]: Aman Madaan, Niket Tandon, Prakhar Gupta, Skyler Hallinan, Luyu Gao, Sarah Wiegreffe, Uri Alon, Nouha Dziri, Shrimai Prabhumoye, Yiming Yang, et al. 2023. Self-refine: Iterative refinement with self-feedback. *arXiv preprint arXiv:2303.17651*.

[^30]: Shen-Yun Miao, Chao-Chun Liang, and Keh-Yih Su. 2020. A diverse corpus for evaluating and developing english math word problem solvers. In *Proceedings of the 58th Annual Meeting of the Association for Computational Linguistics*, pages 975–984.

[^31]: Swaroop Mishra, Arindam Mitra, Neeraj Varshney, Bhavdeep Sachdeva, Peter Clark, Chitta Baral, and Ashwin Kalyan. 2022. Numglue: A suite of fundamental yet challenging mathematical reasoning tasks. In *Proceedings of the 60th Annual Meeting of the Association for Computational Linguistics (Volume 1: Long Papers)*, pages 3505–3523.

[^32]: Kole Norberg, Husni Almoubayyed, Stephen E Fancsali, Logan De Ley, Kyle Weldon, April Murphy, and Steven Ritter. 2023. Rewriting math word problems with large language models. In *Proceedings of the Workshop on Empowering Education with LLMs-the Next-Gen Interface and Content Generation 2023 co-located with 24th International Conference on Artificial Intelligence in Education (AIED 2023), Tokyo, Japan*, volume 3487, pages 163–172.

[^33]: OpenAI. 2022. Gpt-3.5-turbo.

[^34]: OpenAI. 2023. GPT-4 technical report. *CoRR*, abs/2303.08774.

[^35]: Arkil Patel, Satwik Bhattamishra, and Navin Goyal. 2021. Are nlp models really able to solve simple math word problems? In *Proceedings of the 2021 Conference of the North American Chapter of the Association for Computational Linguistics: Human Language Technologies*, pages 2080–2094.

[^36]: George Polya. 2004. *How to solve it: A new aspect of mathematical method*, volume 85. Princeton university press.

[^37]: Baptiste Roziere, Jonas Gehring, Fabian Gloeckle, Sten Sootla, Itai Gat, Xiaoqing Ellen Tan, Yossi Adi, Jingyu Liu, Tal Remez, Jérémy Rapin, et al. 2023. Code llama: Open foundation models for code. *arXiv preprint arXiv:2308.12950*.

[^38]: Tomohiro Sawada, Daniel Paleka, Alexander Havrilla, Pranav Tadepalli, Paula Vidas, Alexander Kranias, John J Nay, Kshitij Gupta, and Aran Komatsuzaki. 2023. Arb: Advanced reasoning benchmark for large language models. *arXiv preprint arXiv:2307.13692*.

[^39]: Freda Shi, Xinyun Chen, Kanishka Misra, Nathan Scales, David Dohan, Ed H Chi, Nathanael Schärli, and Denny Zhou. 2023. Large language models can be easily distracted by irrelevant context. In *International Conference on Machine Learning*, pages 31210–31227. PMLR.

[^40]: Hugo Touvron, Thibaut Lavril, Gautier Izacard, Xavier Martinet, Marie-Anne Lachaux, Timothée Lacroix, Baptiste Rozière, Naman Goyal, Eric Hambro, Faisal Azhar, et al. 2023a. Llama: Open and efficient foundation language models. *arXiv preprint arXiv:2302.13971*.

[^41]: Hugo Touvron, Louis Martin, Kevin Stone, Peter Albert, Amjad Almahairi, Yasmine Babaei, Nikolay Bashlykov, Soumya Batra, Prajjwal Bhargava, Shruti Bhosale, et al. 2023b. Llama 2: Open foundation and fine-tuned chat models. *arXiv preprint arXiv:2307.09288*.

[^42]: Lieven Verschaffel, Erik De Corte, Sabien Lasure, Griet Van Vaerenbergh, Hedwig Bogaerts, and Elie Ratinckx. 1999. Learning to solve mathematical application problems: A design experiment with fifth graders. *Mathematical thinking and learning*, 1(3):195–229.

[^43]: Haoyu Wang, Guozheng Ma, Cong Yu, Ning Gui, Linrui Zhang, Zhiqi Huang, Suwei Ma, Yongzhe Chang, Sen Zhang, Li Shen, et al. 2023. Are large language models really robust to word-level perturbations? *arXiv preprint arXiv:2309.11166*.

[^44]: Xuezhi Wang, Jason Wei, Dale Schuurmans, Quoc V Le, Ed H Chi, Sharan Narang, Aakanksha Chowdhery, and Denny Zhou. 2022. Self-consistency improves chain of thought reasoning in language models. In *The Eleventh International Conference on Learning Representations*.

[^45]: Jason Wei, Xuezhi Wang, Dale Schuurmans, Maarten Bosma, Fei Xia, Ed Chi, Quoc V Le, Denny Zhou, et al. 2022. Chain-of-thought prompting elicits reasoning in large language models. *Advances in Neural Information Processing Systems*, 35:24824–24837.

[^46]: Jerry Wei, Da Huang, Yifeng Lu, Denny Zhou, and Quoc V Le. 2023a. Simple synthetic data reduces sycophancy in large language models. *arXiv preprint arXiv:2308.03958*.

[^47]: Tianwen Wei, Jian Luan, Wei Liu, Shuang Dong, and Bin Wang. 2023b. Cmath: can your language model pass chinese elementary school math test? *arXiv preprint arXiv:2306.16636*.

[^48]: Sen Yang, Xin Li, Leyang Cui, Lidong Bing, and Wai Lam. 2023. [Neuro-symbolic integration brings causal and reliable reasoning proofs](http://arxiv.org/abs/2311.09802).

[^49]: Shunyu Yao, Dian Yu, Jeffrey Zhao, Izhak Shafran, Thomas L Griffiths, Yuan Cao, and Karthik Narasimhan. 2023. Tree of thoughts: Deliberate problem solving with large language models. *arXiv preprint arXiv:2305.10601*.

[^50]: Longhui Yu, Weisen Jiang, Han Shi, Jincheng Yu, Zhengying Liu, Yu Zhang, James T Kwok, Zhenguo Li, Adrian Weller, and Weiyang Liu. 2023a. Metamath: Bootstrap your own mathematical questions for large language models. *arXiv preprint arXiv:2309.12284*.

[^51]: Wenhao Yu, Nimrod Gileadi, Chuyuan Fu, Sean Kirmani, Kuang-Huei Lee, Montse Gonzalez Arenas, Hao-Tien Lewis Chiang, Tom Erez, Leonard Hasenclever, Jan Humplik, et al. 2023b. Language to rewards for robotic skill synthesis. *arXiv preprint arXiv:2306.08647*.

[^52]: Xiang Yue, Xingwei Qu, Ge Zhang, Yao Fu, Wenhao Huang, Huan Sun, Yu Su, and Wenhu Chen. 2023. Mammoth: Building math generalist models through hybrid instruction tuning. *arXiv preprint arXiv:2309.05653*.

[^53]: Xueliang Zhao, Xinting Huang, Wei Bi, and Lingpeng Kong. 2023. Sego: Sequential subgoal optimization for mathematical problem-solving. *arXiv preprint arXiv:2310.12960*.

[^54]: Kunhao Zheng, Jesse Michael Han, and Stanislas Polu. 2021. minif2f: a cross-system benchmark for formal olympiad-level mathematics. In *International Conference on Learning Representations*.

[^55]: Aojun Zhou, Ke Wang, Zimu Lu, Weikang Shi, Sichun Luo, Zipeng Qin, Shaoqing Lu, Anya Jia, Linqi Song, Mingjie Zhan, et al. 2023a. Solving challenging math word problems using gpt-4 code interpreter with code-based self-verification. *arXiv preprint arXiv:2308.07921*.

[^56]: Denny Zhou, Nathanael Schärli, Le Hou, Jason Wei, Nathan Scales, Xuezhi Wang, Dale Schuurmans, Claire Cui, Olivier Bousquet, Quoc Le, et al. 2022. Least-to-most prompting enables complex reasoning in large language models. *arXiv preprint arXiv:2205.10625*.

[^57]: Zihao Zhou, Qiufeng Wang, Mingyu Jin, Jie Yao, Jianan Ye, Wei Liu, Wei Wang, Xiaowei Huang, and Kaizhu Huang. 2023b. Mathattack: Attacking large language models towards math solving ability. *arXiv preprint arXiv:2309.01686*.