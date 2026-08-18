---
title: "Do AI Models Perform Human-like Abstract Reasoning Across Modalities?"
source: "https://arxiv.org/html/2510.02125v4"
author:
published:
created: 2026-06-23
description:
tags:
  - "clippings"
---
Claas Beger    Ryan Yi    Shuhao Fu    Kaleda Denton    Arseny Moskvichev    Sarah Tsai    Sivasankaran Rajamanickam    Melanie Mitchell

###### Abstract

OpenAI’s o3-preview reasoning model exceeded human accuracy on the ARC-AGI-1 benchmark, but does that mean state-of-the-art models recognize and reason with the abstractions the benchmark was designed to test? Here we investigate abstraction abilities of AI models using the closely related but simpler ConceptARC benchmark. Our evaluations vary input modality (textual vs. visual), use of external Python tools, and reasoning effort. Beyond output accuracy, we evaluate the natural-language rules that models generate to explain their solutions, enabling us to assess whether models recognize the abstractions that ConceptARC was designed to elicit. We show that the best models’ rules are frequently based on surface-level “shortcuts,” capturing intended abstractions considerably less often than humans. In the visual modality, AI models’ output accuracy drops sharply; however, our rule-level analysis reveals that a substantial share of their rules capture the intended abstractions, even as the models struggle to apply these concepts to generate correct solutions. In short, we show that using accuracy alone to evaluate abstract reasoning can substantially overestimate AI capabilities in textual modalities and underestimate it in visual modalities. Our results offer a more faithful picture of AI models’ abstract reasoning abilities and a more principled way to track progress toward human-like, abstraction-centered intelligence.

ARC, Multimodal Reasoning, Abstraction, Vision Language Models

## 1 Introduction

The ability to quickly form abstractions and use them to reason by analogy is central to humans’ remarkable capacity to generalize knowledge to novel situations [^6] [^20] [^24]. Many benchmarks have been designed to evaluate abstract reasoning abilities in machines [^13] [^19] [^37]. Among the most prominent is the Abstraction and Reasoning Corpus (ARC) [^9],<sup>1</sup> ARC consists of a set of idealized problems that require few-shot rule-induction and analogical reasoning. As Figure 1 shows, each puzzle (“task”) consists of a small set of demonstrations (initial and transformed grids) and a test grid, each ranging in size from $1\times 1$ to $30\times 30$, with each cell having one of 10 possible colors. To solve a task, an agent must infer a rule governing the demonstrations and apply that rule to the test input to produce a correct output grid. According to ARC’s creator, François Chollet [^9], ARC is “built upon an explicit set of priors designed to be as close as possible to innate human priors. We argue that ARC can be used to measure a human-like form of general fluid intelligence and that it enables fair general intelligence comparisons between AI systems and humans.”

Chollet [^11] created 1,000 such tasks, releasing 400 easier puzzles as a “training set” and 400 harder puzzles as an “evaluation set.” The remaining, more difficult puzzles were held out as private test sets. Participants in the 2024 ARC-AGI Prize competition entered programs that vied to achieve high accuracy (i.e., a high percentage of correct output grids) on a private test set of 100 tasks, with a $600,000 grand prize for any program that exceeded 85% accuracy.<sup>2</sup> The highest scoring program, with about 54% accuracy, employed a fine-tuned LLM, extensive data augmentation, and test-time training [^8].

Following the competition, Chollet and colleagues tested a pre-release version of OpenAI’s o3 model on a different “semi-private” test set of 100 tasks. This model achieved an accuracy of 76% on its low-effort setting and 88% on its high-effort setting, with computing cost per task estimated at $200 and $20,000 respectively [^7]. While o3-preview was not qualified to participate in the official competition, its performance was described as “a genuine breakthrough, marking a qualitative shift in AI capabilities compared to the prior limitations of LLMs” [^10].

However, despite the high accuracy of o3 on ARC tasks, it is not clear whether AI systems have achieved the human-like abstract reasoning abilities that ARC was designed to test. Consider, for example, the task illustrated in the top row of Figure 1 (from the ConceptARC benchmark, described below). A human solving this task could likely generalize across different instantiations of the underlying abstract concepts, that is, identifying and removing the top and bottom objects, regardless of the size, shape, color, position, or number of objects. Yet to our knowledge, no prior studies have assessed whether AI systems such as o3 are solving these tasks by using the intended, generalizable abstractions, or whether they exploit less generalizable rules (“shortcuts”) based on unintended correlations in the demonstrations.

Here we assess the abstractions used by several commercial and open-weight models in solving tasks from ConceptARC [^28], a benchmark in the ARC domain containing tasks organized around the same “core knowledge priors” that the ARC benchmark was designed to test. ConceptARC’s tasks are focused on concepts such as “inside and outside,” “above and below,” or “same vs. different.” For example, the tasks shown in Figure 1 are from ConceptARC’s “top vs. bottom” and “center” concept groups, respectively. As described in [^28], ConceptARC was designed to test robust understanding of these concepts by providing tasks (designed to be simple for humans) that use each concept in various contexts and require varying degrees of generalization to solve. As ConceptARC isolates simple abstract concepts, we believe this benchmark is better suited than ARC for investigating the concepts used by humans and machines in solving tasks. ARC is substantially harder for humans than ConceptARC [^28], and frequently employs compositional reasoning, which would make it necessary to disentangle different types of intended abstractions, complicating the evaluation process.

![Refer to caption](https://arxiv.org/html/2510.02125v4/figures/ConceptARCExamples.png)

Figure 1: Each row shows a task from the ConceptARC benchmark. A task consists of three demonstrations of a transformation and one test grid. In this study, the solver is tasked with generating a rule that describes the transformations and applying that rule to the test grid.

Previous evaluations using the o3 model, as well as all entries in the 2024 ARC-AGI Prize competition, relied on the same text-based representation of the demonstration and test grids to solve each ARC task. Each grid is represented as an integer matrix, with entries encoding colors indexed from 0 to 9. However, because o3 and related models are reported to possess sophisticated reasoning abilities in both textual and visual modalities [^29], we investigate the models’ abstract reasoning abilities in both modalities. We also examine how reasoning effort (the token budget allocated for the reasoning stage) and access to external “tools” (here, the ability to generate and execute Python code) affect a model’s ability to discover abstract rules and solve tasks.

In the following sections, we describe our experimental methodology and results, and discuss how our findings relate to three central questions: (1) How does the accuracy achieved by AI models on ConceptARC tasks compare to that of humans? (2) To what extent do the rules generated by AI models and by humans capture the abstractions intended by the test designers, and to what extent do they rely on unintended, superficial patterns? (3) How do modality (textual vs. visual), reasoning effort (token budget), and Python tool access affect how well models can solve these tasks via the intended abstractions?

## 2 Methodology

#### Dataset and Experiments

To create ConceptARC, Moskvichev et al. [^28] chose 16 basic spatial and semantic concepts, and for each concept created 30 tasks that focused on that concept in different instantiations, with different degrees of abstraction, for a total of 480 tasks. In contrast to ARC tasks, all ConceptARC tasks were designed to be relatively easy for humans to solve: each focuses on a simple abstract concept and its application to a test grid. Moskvichev et al. [^28] reported human accuracy on ConceptARC to be 91% (based on three guesses per task), which can be roughly compared to 64% human accuracy on the ARC evaluation set reported in [^25] (based on two guesses per task).

We evaluated four proprietary multimodal “reasoning” models on the ConceptARC tasks: OpenAI’s o3 and o4-mini, Google’s Gemini 2.5 Pro, and Anthropic’s Claude Sonnet 4. For comparison, we also evaluated three non-reasoning multimodal models: OpenAI’s GPT-4o, Meta’s Llama 4 Scout, and Alibaba’s Qwen 2.5 VL 72B. To maximize reproducibility, non-reasoning models were run with temperature 0. Because the APIs for o3, o4-mini, and Claude Sonnet 4 restrict temperature to 1.0, we used temperature 1.0 for all four reasoning models to maintain comparability. For experiments using the textual modality, we used the same prompt as in Chollet et al.’s [^10] evaluation of o3-preview. For experiments using the visual modality, we used a slightly modified version of this prompt. Full prompts are given in Appendices A, B, and Appendix C.

For both modalities, models were asked to generate a JSON object containing the transformation rule and the corresponding output grid, represented as a matrix of integers (the same representation used in previous ARC evaluations). This setup enables two-fold evaluation: (i) grid output accuracy and (ii) the degree to which model-generated rules capture the tasks’ intended abstractions. We evaluated human-generated solutions using the same criteria, analyzing unpublished data obtained from the study reported by Moskvichev et al. [^28] in which humans (participants on the Prolific Academic platform) were presented with ConceptARC tasks as images and asked to produce both the correct output grids and the rules they used to generate them.<sup>3</sup> For each model setting, each task was given in an independent prompt, without prior context. Due to resource constraints, we report pass@1 results for both AI models and humans.<sup>4</sup>

We evaluated o3 under its low- and medium-effort reasoning settings.<sup>5</sup> We evaluated Gemini 2.5 Pro and Claude Sonnet 4 with a reasoning budget of 16,000 tokens, which roughly approximates OpenAI’s medium-effort setting. Additionally, for reasoning models we evaluated two tool-access conditions: one in which Python tools were enabled and one in which they were not.

#### Evaluating Responses of Humans and AI Models

For each task, humans were given the demonstrations and test grid images and were asked to generate the output grid using a custom editing tool, whereas models were asked to generate the output grid as a matrix with colors encoded as integers. Following the ARC evaluation criteria, to be considered correct, a generated output-grid must exactly match the ground-truth solution in the ConceptARC corpus, and be in the requested format. For a more detailed analysis of format deviations see Appendix K.

While output-grid accuracy has been widely used to assess performance on ARC tasks, to our knowledge, no prior studies have investigated the extent to which accuracy actually reflects a grasp of the intended abstract concepts underlying the tasks versus the identification of unintended, superficial patterns (“shortcuts”) in the data. It is well known that large neural-network models are capable of discovering spurious patterns in data and using these patterns to arrive at correct answers [^12] [^15]. To investigate the extent to which AI models are using human-like abstractions to solve tasks, we asked the models to output not only the transformed test grid but also a natural-language rule describing the transformation. Moskvichev et al. [^28] similarly collected such rules from their human participants, though only for correctly solved tasks.

Evaluating the correctness of natural-language rules requires human judgment. Accordingly, we manually classified both model- and human-generated rules using three possible classes: “correct-intended” (rules that align with the intended abstractions), “correct-unintended” (rules that work on the demonstrations but do not capture the intended abstractions), and “incorrect” (rules that do not work on the demonstrations).<sup>6</sup> For example, in the first task shown in Figure 1, a sample human-generated rule is “Use the same grid size as in the input. There will be multiple objects. Simply remove the top object and the bottom object only.” We rated this rule as correct-intended. Claude Sonnet 4’s generated rule, from our experiment with textual inputs and medium reasoning effort, was “Remove the topmost and bottommost colored regions, keep all colored regions in between,” which we also rated as correct-intended. Gemini 2.5 Pro’s rule in this same setting was “Identify all connected shapes of non-zero numbers. Sort these shapes first by their size (number of cells) in ascending order, then by their color value in ascending order as a tie-breaker. Remove the two shapes that come first in this sorted list, and keep all other shapes.” Here, Gemini is using the ordering of integer codes for colors, which is meant to be an arbitrary textual encoding, as a relevant feature. It turns out that Gemini found an unintended but correct pattern in the demonstrations, so this rule was classified as correct-unintended, even though Gemini’s generated output grid, which followed its rule, was incorrect. Finally, o3’s generated rule in this same setting was “Remove all smallest objects: find each connected non-zero color component, count its cells, identify the minimum area, and delete every component having that minimum size (replace its cells with 0); leave every other cell unchanged.” As this rule did not correctly describe the demonstrations, we classified it as incorrect.

In the second task in Figure 1, a sample human-generated rule is “Select the colour that is in the middle of the input. Only output that colour as a $1\times 1$ grid.” As before, we rated this as correct-intended. o3 with textual input, medium effort, and tool use enabled, generated the rule “Return the middle element of the 1-D input list (index $\lfloor n/2\rfloor$ for odd length) as a single-value output grid.” Also correct-intended. Claude’s rule in the same setting was “Find all values that appear with the minimum frequency in the input grid, sort them in ascending order, then return the second smallest value if multiple values exist, or the only value if just one exists.” This rule again uses the specific integer values encoding colors, and is a correct, though unintended, description of the demonstrations, and thus was classified as correct-unintended; it also happens to generate a correct output grid. In the same setting, Gemini generated a very similar correct-unintended rule that also generated a correct output grid.

Further examples of correct-unintended rules are given in Appendix D. It is important to clarify that we do not consider “correct-unintended” rules to be incorrect; rather, they reflect a mismatch between the generated rule and the one intended by the task designer, which is based on humanlike “core knowledge” concepts [^9] that both ARC and ConceptARC were designed to evaluate.

While it is not guaranteed that a model’s natural-language rule for a given task is a faithful reflection of how the task was solved, we manually analyzed the alignment between generated rules and their corresponding output grids. We found that, across all experimental settings, the output grid, whether correct or not, was faithful to the model’s rule in over 90% of the cases we examined, providing evidence that these rules serve as reasonable proxies for the model’s reasoning process. Further details are provided in the next section.

## 3 Results

Table 1: Reasoning models: Output-grid accuracy (pass@1) for ConceptARC across models and experimental settings. Accuracy is shown in %. Textual (t) and Visual (v) results are reported on separate rows. For o3 and o4-mini, we use the “low” and “medium” effort settings in the OpenAI API. For Claude we use the model Sonnet-4 and for Gemini, we use 2.5 Pro. For both models, we use a 16K reasoning token budget to approximate o3’s medium effort setting. We denote enabled tool usage with +T. Temperature is set to 1 for all models. Bold numbers correspond to the highest visual and textual scores in each column.

| Model |  | low | medium | low +T | medium +T |
| --- | --- | --- | --- | --- | --- |
| o3 | t | 68.3 | 77.1 | 67.9 | 75.6 |
|  | v | 6.7 | 5.6 | 18.1 | 29.2 |
| o4-mini | t | 52.1 | 70.8 | 57.3 | 77.7 |
|  | v | 3.8 | 8.1 | 6.7 | 25.0 |
| Claude | t | N/A | 60.2 | N/A | 55.0 |
|  | v | N/A | 5.2 | N/A | 6.9 |
| Gemini | t | N/A | 66.0 | N/A | 60.4 |
|  | v | N/A | 4.2 | N/A | 5.8 |

#### Output Grid Accuracy

Table 1 and Table 3 (Appendix E) give the pass@1 output-grid accuracies of the reasoning models and non-reasoning models we evaluated in both textual and visual modalities. In all cases, non-reasoning models attain much lower accuracy than reasoning models, so here we focus our analysis on the reasoning models. For all models, we see a dramatic performance gap between the textual and visual settings. Further, especially for o3 and o4-mini, and to a lesser extent for Claude and Gemini, we observe an increase in visual accuracy when Python tools are enabled. In contrast, allowing Python tools does not have a similar effect in the textual setting for three of the models, with o4-mini being the only exception. For o3 and o4-mini, increased reasoning effort is associated with increased accuracy in the textual modality, with or without tools; in the visual modality, we observe that the models primarily use the increased reasoning budget to execute more Python code, which may explain the substantial improvement in medium effort + tools.

Inspecting the failure cases of the visual setting more closely, we find that models struggle to recognize the correct grid size from the image inputs. When Python tools are enabled, the models use computer vision libraries to partially compensate for this difficulty. In both textual and visual modalities, the majority of incorrect output grids are due to a mismatch between the generated and ground-truth grids; however, in the visual setting in particular, there is also a small share of invalid outputs, either due to uneven row lengths or non-integer tokens in the grid. Figure 4 in Appendix G gives an error-type distribution for o3.

Using unpublished data from Moskvichev et al.’s [^28] study, we found that human-generated output grids achieved an overall pass@1 accuracy of 73% on the 480 ConceptARC tasks, lower than that of o3 in the textual modality. (We provide per-concept accuracies in Appendix H.)

#### Rule Evaluation

Our team manually evaluated the rules generated by o3 in all settings and by Claude Sonnet 4 and Gemini 2.5 Pro in the medium-effort + tools setting, for both textual and visual modalities. We also evaluated the pass@1 rules generated by humans, using data from the study by Moskvichev et al. [^28]. For each rule (human or machine-generated), an initial classification was assigned by one member of our team, and reviewed by a second member. In cases where there was disagreement or uncertainty about a rule’s classification, our team discussed the rule together until we came to a consensus. Due to low accuracy in other settings and resource limitations of our team, we did not evaluate rules from other models or experimental settings. Nevertheless, the selected evaluations provide substantive insight into the extent to which different models and human participants utilize the intended abstractions of ConceptARC tasks.

Figure 2 shows the results of our rule evaluations on o3, Claude, and Gemini, all using medium-effort + tools, in both textual and visual modalities, as well as evaluations for human-generated rules. In each setting there are two bars for each model: Correct Grid and Incorrect Grid. The height of each bar corresponds to the percentage of the 480 tasks on which the model’s output grid was correct or incorrect. Within each bar, the green, yellow, and red sections correspond respectively to tasks for which the model’s generated rule was correct-intended, correct-unintended rules, and incorrect; gray sections correspond to unclear or nonresponsive rules. Results for the textual and visual modalities are given on the left and the middle parts respectively. The rightmost part gives the output accuracy and rule evaluation results for human-generated rules. The gray areas in the bars correspond to solutions for which we were unable to classify the rule, either because no rule was given by the participant or model, no rule was collected by the experimenters (this was the case for all of the human tasks with incorrect outputs), or the rule given was too unclear to confidently evaluate.

Notably, while o3 in the textual setting rivals humans in output grid accuracy, around 27% of its correct outputs are based on correct-unintended or incorrect rules, indicating reasoning based on superficial patterns rather than intended abstract concepts. We found several types of unintended rules used by models, including rules that described complicated (and spurious) patterns in the demonstrations, rules that focused on irrelevant features such as numerical relationships among the specific numbers encoding grid colors, and rules that came close to capturing intended abstractions but included irrelevant spurious associations. In comparison, we found that only about 8% of humans’ correct outputs were based on correct-unintended or incorrect rules. Although our analysis for human-generated rules is limited due to missing rule data (roughly 19% of the rules associated with correct outputs were not classifiable, and no rules were collected for incorrect outputs), this difference is suggestive and should be clarified in future human studies. Comparing AI models with one another, in cases where Claude and Gemini generated accurate output grids, both have a smaller fraction of correct-unintended rules than o3, but both are lower than o3 in output accuracy.

Also notable is the percentage of incorrect output grids that are based on correct-intended rules. In these cases, the models recognized the intended abstract rule describing the grid transformation, but were unable to apply it correctly to the test grid. In the textual setting, this seems to be most common in Claude, and less so in Gemini and o3. In the visual setting, however, o3 produced correct-intended rules in around 28% of cases in which its output grid was incorrect; Claude and Gemini did so less frequently, but both still at substantial rates. In summary, looking only at a model’s output accuracy in the textual setting (as was done by Chollet et al. [^10]) might overestimate the model’s ability for abstract reasoning, but in the visual domain, accuracy alone might underestimate its abstract reasoning abilities. This hints at a direction for improvement in the visual modality across models: models with the capacity to apply the determined rule correctly would be able to substantially improve their output accuracy. These insights illustrate the importance of going beyond simple accuracy in assessing the capabilities of AI models.

Whereas Figure 2 showed our rule evaluations for different models using medium reasoning effort + tools, Figure 3 shows the effects of varying reasoning effort and tool use for the o3 model, in both textual and visual modalities. There are a few important observations to make. First, in the visual setting, increasing reasoning effort from low to medium alone does not have any substantial effect on output accuracy or rule correctness, which aligns with prior work suggesting that test-time scaling does not have the dramatic effects in visual modalities that have been seen in text-only models [^16]. However, enabling Python tool use does result in substantial improvement in output accuracy and rule correctness, especially at medium reasoning effort, likely because the model is able to use computer vision libraries. In contrast, in the textual setting, increasing reasoning effort has a larger positive effect on both output accuracy and rule correctness than enabling Python tool use.

Table 2: Percentage of tasks in which models exhibited either “rule–grid alignment” (RGA)—the generated rule accurately described the generated output grid—or, in visual settings, a “visual error” (VE). The medium-effort + tools setting was used for all models. Tasks with missing or invalidly formatted output grids and/or non-responsive or unclear rules are excluded from these percentages.

<table><tbody><tr><td>Model</td><td>Textual</td><td colspan="2">Visual</td></tr><tr><td>(Medium + Tools)</td><td></td><td></td><td></td></tr><tr><td></td><td>RGA</td><td>RGA</td><td>VE</td></tr><tr><td>o3</td><td>98.1</td><td>97.4</td><td>49.1</td></tr><tr><td>Claude</td><td>92.4</td><td>96.6</td><td>59.7</td></tr><tr><td>Gemini</td><td>94.5</td><td>93.6</td><td>77.3</td></tr></tbody></table>

![Refer to caption](https://arxiv.org/html/2510.02125v4/x1.png)

Figure 2: Results of rule evaluations. For each model, as well as for humans, two bars are shown, representing the percentages of correct and incorrect grid outputs across the 480 ConceptARC tasks. Model evaluations are reported for both textual and visual settings. Each bar shows the fraction of tasks for which the rule is correct-intended, correct-unintended, and incorrect. The gray regions represent rules that could not be classified, further described in the section on Rule Evaluation. The exact percentages are given in Appendix I.

![Refer to caption](https://arxiv.org/html/2510.02125v4/x2.png)

Figure 3: Results of rule evaluations for o3 across all settings. As in Figure 2, two bars showing the percentage of correct and incorrect output grids are included for each setting, with each bar showing the fraction of tasks for which the generated rule is correct-intended, correct-unintended, and incorrect. Gray regions represent rules that could not be classified; see the section on Rule Evaluation for details. The exact percentages are given in Appendix I.

#### Rule-Grid Alignment

To investigate how accurately the natural-language rules reflect the models’ underlying reasoning, our team manually evaluated the solutions generated by o3, Claude Sonnet 4, and Gemini 2.5 Pro in the medium-effort + tools setting for two additional features: rule-grid alignment and visual errors. Rule-grid alignment describes cases where the model’s stated rule accurately captures the transformation demonstrated in its output grid. Visual errors refer to cases in visual settings where a grid’s incorrectness or inconsistency with its corresponding rule appears to stem, at least in part, from failures in the model’s perceptual apparatus rather than from a mismatch between its generated rule and underlying reasoning. Such errors commonly involved failures to recognize the exact grid dimensions, slight inaccuracies in object placement, or incorrect mappings between colors and their numerical encodings.

For these evaluations, one team member provided an initial judgment for each task, after which any ambiguous cases were discussed as a group until consensus was reached. The results of these evaluations are presented in Table 2. We find that the natural-language rules align with their corresponding grids in the vast majority of cases; across all evaluated models and settings, agreement exceeded 90% of tasks. This supports the view that the proposed rules generally reflect the reasoning used to produce the grid solutions. In addition, the relatively high rate of visual errors corroborates our earlier observations of failure modes in visual settings. Even the best-performing model and setting exhibited a visual error rate approaching 50%, despite maintaining a high degree of rule-grid alignment. This suggests that the low grid accuracies observed in visual settings may be driven in large part by perceptual limitations, rather than solely by differences in reasoning capacity between visual and textual modalities.

## 4 Discussion

We can now provide preliminary answers to the questions we listed at the beginning of this paper. (1) How does the accuracy obtained by AI models compare with that of humans? Table 1 shows that for textual inputs, o3 with medium reasoning effort surpasses human accuracy on ConceptARC tasks, with Claude and Gemini obtaining lower accuracy, and o4-mini surpassing humans only when Python tools are enabled. This aligns with results reported in [^7] and [^2]. However, using the visual modality, the models’ performance still lags significantly behind human accuracy, even when models are given access to Python tools.

(2) To what extent do the rules generated by AI models capture the abstractions that were intended by ConceptARC’s creators, versus more superficial shortcuts? Figure 2 shows that for textual inputs and medium reasoning effort with Python tools, about 57% of o3’s generated rules (regardless of output accuracy) were correct and intended; that is, they captured the intended abstractions of the tasks. However, about 29% of o3’s generated rules were correct but unintended, meaning they were correct with respect to the given demonstrations, and frequently generated correct output grids, but did not capture the intended abstractions. ConceptARC, like ARC, is built on “core knowledge” priors, including “objectness” [^9]; however, we found that for the AI models we studied, rules often focused on colors, individual pixels, and other low-level features rather than objects. Moreover, using integers to encode colors enabled unintended shortcuts, such as relying on relationships between numerical values. Both Claude and Gemini’s shares of correct-unintended rules (approximately 15% and 22%, respectively) were lower than o3’s, but more than five times that of correct-unintended rules produced by humans (2.7%). Thus, AI models appear much more likely than humans to miss intended abstractions and instead solve tasks using more superficial features.

(3) Regarding the effects of textual versus visual modalities, Table 1 and Figure 2 show that both output-grid and rule correctness drop dramatically in the visual mode. In addition, we observe that in the visual mode, all three models are considerably better at forming correct-intended rules than at generating correct output grids. Regarding the effects of reasoning effort and Python tools, Table 1 and Figure 3 show that increased reasoning effort is more helpful for textual inputs, whereas Python tools are more helpful for visual inputs, especially at higher reasoning effort. These results point to possible directions for strengthening visual reasoning models, especially in more abstract domains.

In short, our results show that models still lag behind humans in the kinds of abstract reasoning capabilities that ARC and ConceptARC were designed to evaluate. Using accuracy alone to evaluate abstract reasoning on ARC-like tasks may overestimate abstract reasoning capabilities in textual modalities and underestimate them in visual modalities. Our results highlight the importance of going beyond simple accuracy, namely, assessing both robustness and the extent to which a system relies on generalizable mechanisms rather than superficial shortcuts [^14] [^22] [^31]. To target these abilities in a meaningful way, we encourage designers of benchmarks and evaluation methods to incorporate underlying abstractions and derived rules, alongside traditional output correctness, when developing new performance metrics. More generally, while in some cases it is desirable for AI systems to reason in non-human-like ways (e.g., in discovering novel patterns in scientific data, such as protein sequences [^23]), developing AI models that grasp the abstractions understood by humans will be essential for these systems to generalize and explain their reasoning in ways understandable to humans, which are key abilities for successful human-AI interaction. In future work, we will investigate whether human-like reasoning can be induced via process-based reward models or a more direct inclusion of human-generated reasoning traces. An interesting direction for future research will be to extend our studies to tasks that require more compositional reasoning, such as those in ARC-AGI-2 [^7].

## 5 Related Work

Many studies have proposed computational methods for solving ARC tasks, including program synthesis with and without pretrained LLMs [^3] [^4] [^34], fine-tuning LLMs with augmented data and test-time training [^8], and using fine-tuned large reasoning models [^10]. Almost all of these studies rely on textual task representations (Hu et al., [^21], is an exception), and all focus exclusively on output-grid accuracy; to our knowledge, none analyze the rules generated by models, as was done in our study. LeGris et al. [^25] collected rules generated by humans and trained a Naive Bayes classifier to predict which task in their study was described by a particular rule, finding that humans indeed used expected core knowledge priors (i.e., concepts related to objectness, basic geometry and topology, and numerosity) in their rules.

Besides ARC and ConceptARC, several benchmark datasets have been used to evaluate abstract and visual reasoning abilities in LLMs and large reasoning models. Those closest to ARC and ConceptARC include Bongard problems [^5], letter-string analogies [^18], Raven’s progressive matrices (RPMs) [^32], and compositional visual reasoning (CVR) [^36]. Bongard problems are similar to ConceptARC tasks in that each problem tests understanding of a single core spatial or semantic concept, such as “large vs. small” or “inside vs. outside.” Bongard problems are inherently visual, and several studies have evaluated multimodal models on subsets or variations of the original problems, finding that, consistent with our results on ConceptARC, the poor performance of VLMs on these problems appears to arise primarily from difficulties with vision rather than with reasoning [^27] [^30] [^35]. Letter-string analogies were first proposed by Hofstadter [^18] as an idealized domain for analogy-making. Webb et al. [^33] found that GPT-3 reached human level accuracy on letter-string analogies, but other studies (testing both GPT-3 and GPT-4) found that LLMs were not robust to problem variations that did not affect humans’ performance [^17] [^26]. Raven’s progressive matrices (RPMs) have long been used as tests of human fluid intelligence. RAVEN, a dataset consisting of programmatically generated, simplified RPMs [^37], has been used to evaluate visual reasoning in VLMs (e.g., [^38] [^39]), which seem to struggle more with perceptual understanding than with reasoning. Zerroug et al. [^36] proposed the CVR visual reasoning benchmark, which tests compositional reasoning abilities based on concepts similar to those used in ConceptARC. CVR tasks have been used to evaluate convolutional neural networks as well as vision transformers, none of which approach human-level performance.

## 6 Conclusions

The contributions of this work are threefold. (1) We demonstrated the effects of task representation (textual or visual), reasoning effort, and Python tool use on the ConceptARC benchmark for abstract reasoning, finding that in textual modalities with medium reasoning effort, the best AI models match or surpass humans in output accuracy. (2) We evaluated not only accuracy, but also the rules that AI models generated to describe their solutions, finding that while models captured the intended abstractions in about half of the cases in textual settings, in other instances their rules relied on more superficial features or patterns that are less generalizable. These results suggest that relying on accuracy alone to evaluate abstract reasoning capabilities, as was done in the ARC-Prize challenge, can substantially overestimate the generality of these capabilities. (3) We showed that state-of-the-art multimodal reasoning models still lack human-like visual reasoning abilities, performing dramatically worse in the visual modality than in the textual modality. However, in visual settings, these models were substantially better at generating correct rules than they were at applying them, pointing to potential directions for improving visual reasoning in such systems. Improving the abstraction capabilities of AI models is an essential direction for future research. Recognizing and using human-like abstract concepts is a crucial step toward making AI systems more generalizable and trustworthy in their reasoning, as well as enabling them to effectively communicate their reasoning processes to humans.

## 7 Limitations

The work we report here has a number of limitations. Our study involves only the ConceptARC dataset. It is possible that tasks in the original ARC test sets are more resistant to the kinds of rule “shortcuts” seen in our results; however, to our knowledge, there has been no prior research on this topic. Due to resource limitations, we did not experiment with the “high-effort” reasoning setting for o3 or larger reasoning-token budgets for Claude and Gemini. These settings could very well produce significantly more correct-intended rules and higher accuracies. In addition, our manual classification of human- and machine-generated rules involved some subjectivity; we do not know of any objective or algorithmic means to usefully classify these natural-language rules into our various categories. However, to mitigate individual subjectivity, our team discussed and came to consensus on all potentially ambiguous classifications. Also due to resource limitations, we used pass@1 accuracies for both humans and machines, which differs from the pass@2 and pass@3 accuracies reported in other ARC evaluations. Additionally, we used the same prompt as in the ARC-Prize evaluation of o3 [^10] for the textual setting, and a slightly modified version for the visual setting. Other prompts may elicit better performance for these systems. The data we obtained for human-generated rules were incomplete. No rules were collected for incorrect outputs, and even among correct outputs, some human-generated rules were not classifiable for reasons described earlier in the paper.

## Impact Statement

Assessing the general abilities of state-of-the-art AI models to perform abstract reasoning is crucial for systems that will be deployed in many real-world settings. To date, while state-of-the-art AI models may outperform humans on abstract reasoning benchmarks, they may remain brittle on more open-ended real-world tasks.

The ARC domain has been particularly prominent as a test of human-like abstraction, and the high accuracy of models such as o3, Claude Sonnet 4, and Gemini 2.5 Pro on ARC has resulted in claims that AI models have made huge breakthroughs in human-like abstraction abilities. Our work demonstrates in detail how AI models can, in many cases, reason in ways that differ substantially from human reasoning on a version of this widely-used benchmark. We show that evaluations based only on accuracy can substantially overstate progress on these systems’ general abilities (or, in the case of visual inputs, understate such progress). Our work shows that when human-like reasoning is a desired outcome, it is essential to go beyond accuracy and examine the actual strategies used to solve tasks. In addition, our work indicates that for models to incorporate human-like priors, additional training or novel architectures specifically incorporating those priors might be required.

Given the potential value of our detailed data and results for follow-up research, we will publish a web page for this paper containing all data and code upon publication.

## 8 Acknowledgements

Sandia National Laboratories is a multimission laboratory managed and operated by National Technology and Engineering Solutions of Sandia, LLC, a wholly owned subsidiary of Honeywell International, Inc., for the U.S. Department of Energy’s National Nuclear Security Administration under contract DE-NA-0003525. This work was conducted as part of the BANYAN Institute, funded by Sandia National Laboratories’ lab-directed research and development program. This work was also supported by the Templeton World Charity Foundation, Inc. (funder DOI 501100011730) under the grant [https://doi.org/10.54224/20650](https://doi.org/10.54224/20650).

## References

## Appendix A Textual Prompt

<svg height="2610.87" id="A1.p1.pic1" overflow="visible" version="1.1" viewBox="0 0 600 2610.87" width="600"><g fill="#000000" stroke="#000000" stroke-width="0.4pt" style="--ltx-stroke-color:#000000;--ltx-fill-color:#000000;" transform="translate(0,2610.87) matrix(1 0 0 -1 0 0)"><g fill="#000000" fill-opacity="1.0" style="--ltx-fill-color:#000000;"><path d="M 0 3.32 L 0 2607.55 C 0 2609.38 1.49 2610.87 3.32 2610.87 L 596.68 2610.87 C 598.51 2610.87 600 2609.38 600 2607.55 L 600 3.32 C 600 1.49 598.51 0 596.68 0 L 3.32 0 C 1.49 0 0 1.49 0 3.32 Z" style="stroke:none"></path></g><g fill="#FFFFFF" fill-opacity="1.0" style="--ltx-fill-color:#FFFFFF;"><path d="M 0.55 3.32 L 0.55 2607.55 C 0.55 2609.07 1.79 2610.31 3.32 2610.31 L 596.68 2610.31 C 598.21 2610.31 599.45 2609.07 599.45 2607.55 L 599.45 3.32 C 599.45 1.79 598.21 0.55 596.68 0.55 L 3.32 0.55 C 1.79 0.55 0.55 1.79 0.55 3.32 Z" style="stroke:none"></path></g><g fill-opacity="1.0" transform="matrix(1.0 0.0 0.0 1.0 14.39 4.13)"><foreignObject color="#000000" height="2602.61" overflow="visible" style="--ltx-fg-color:#000000;--ltx-fo-width:41.28em;--ltx-fo-height:188.09em;--ltx-fo-depth:0em;" transform="matrix(1 0 0 -1 0 2602.61)" width="571.22"><span id="A1.p1.pic1.7.7.7.7.7.7.7.7.7.7.7.7.7.7.7.7.7.7.1" style="width:41.28em;"><span id="A1.p1.pic1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.p1"><span id="A1.p1.pic1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.p1.1">Find the common rule that maps an input grid to an output grid, given the examples below.</span></span> <span id="A1.p1.pic1.7.7.7.7.7.7.7.7.7.7.7.7.7.7.7.7.7.7.1.p2"><span id="A1.p1.pic1.7.7.7.7.7.7.7.7.7.7.7.7.7.7.7.7.7.7.1.p2.1"><span id="A1.p1.pic1.7.7.7.7.7.7.7.7.7.7.7.7.7.7.7.7.7.7.1.p2.1.1">Example 1</span></span> <span id="A1.p1.pic1.7.7.7.7.7.7.7.7.7.7.7.7.7.7.7.7.7.7.1.p2.2"><em id="A1.p1.pic1.7.7.7.7.7.7.7.7.7.7.7.7.7.7.7.7.7.7.1.p2.2.1">Input:</em></span><code id="A1.p1.pic1.6.6.6.6.6.6.6.6.6.6.6.6.6.6.6.6.6.6.5"> <svg height="214.07" id="A1.p1.pic1.2.2.2.2.2.2.2.2.2.2.2.2.2.2.2.2.2.2.1.pic1" overflow="visible" version="1.1" viewBox="0 0 600 214.07" width="600"><g fill="#000000" stroke="#000000" stroke-width="0.4pt" style="--ltx-stroke-color:#000000;--ltx-fill-color:#000000;" transform="translate(0,214.07) matrix(1 0 0 -1 0 0)"><g fill="#666666" fill-opacity="1.0" style="--ltx-fill-color:#666666;"><path d="M 0 1.8 L 0 212.27 C 0 213.27 0.81 214.07 1.8 214.07 L 598.2 214.07 C 599.19 214.07 600 213.27 600 212.27 L 600 1.8 C 600 0.81 599.19 0 598.2 0 L 1.8 0 C 0.81 0 0 0.81 0 1.8 Z" style="stroke:none"></path></g><g fill="#F7F7F7" fill-opacity="1.0" style="--ltx-fill-color:#F7F7F7;"><path d="M 0.42 1.8 L 0.42 212.27 C 0.42 213.04 1.03 213.66 1.8 213.66 L 598.2 213.66 C 598.97 213.66 599.58 213.04 599.58 212.27 L 599.58 1.8 C 599.58 1.03 598.97 0.42 598.2 0.42 L 1.8 0.42 C 1.03 0.42 0.42 1.03 0.42 1.8 Z" style="stroke:none"></path></g><g fill-opacity="1.0" transform="matrix(1.0 0.0 0.0 1.0 5.95 203.55)"></g></g></svg><em id="A1.p1.pic1.6.6.6.6.6.6.6.6.6.6.6.6.6.6.6.6.6.6.5.5">Output:</em>
<code id="A1.p1.pic1.6.6.6.6.6.6.6.6.6.6.6.6.6.6.6.6.6.6.5.4"> <svg height="214.07" id="A1.p1.pic1.3.3.3.3.3.3.3.3.3.3.3.3.3.3.3.3.3.3.2.1.pic1" overflow="visible" version="1.1" viewBox="0 0 600 214.07" width="600"><g fill="#000000" stroke="#000000" stroke-width="0.4pt" style="--ltx-stroke-color:#000000;--ltx-fill-color:#000000;" transform="translate(0,214.07) matrix(1 0 0 -1 0 0)"><g fill="#666666" fill-opacity="1.0" style="--ltx-fill-color:#666666;"><path d="M 0 1.8 L 0 212.27 C 0 213.27 0.81 214.07 1.8 214.07 L 598.2 214.07 C 599.19 214.07 600 213.27 600 212.27 L 600 1.8 C 600 0.81 599.19 0 598.2 0 L 1.8 0 C 0.81 0 0 0.81 0 1.8 Z" style="stroke:none"></path></g><g fill="#F7F7F7" fill-opacity="1.0" style="--ltx-fill-color:#F7F7F7;"><path d="M 0.42 1.8 L 0.42 212.27 C 0.42 213.04 1.03 213.66 1.8 213.66 L 598.2 213.66 C 598.97 213.66 599.58 213.04 599.58 212.27 L 599.58 1.8 C 599.58 1.03 598.97 0.42 598.2 0.42 L 1.8 0.42 C 1.03 0.42 0.42 1.03 0.42 1.8 Z" style="stroke:none"></path></g><g fill-opacity="1.0" transform="matrix(1.0 0.0 0.0 1.0 5.95 203.55)"></g></g></svg><span id="A1.p1.pic1.6.6.6.6.6.6.6.6.6.6.6.6.6.6.6.6.6.6.5.4.3">Example 2<em id="A1.p1.pic1.6.6.6.6.6.6.6.6.6.6.6.6.6.6.6.6.6.6.5.4.3.1">Abbreviated</em></span>
<span id="A1.p1.pic1.6.6.6.6.6.6.6.6.6.6.6.6.6.6.6.6.6.6.5.4.4">Example 3<em id="A1.p1.pic1.6.6.6.6.6.6.6.6.6.6.6.6.6.6.6.6.6.6.5.4.4.1">Abbreviated</em></span>
<svg height="126.69" id="A1.p1.pic1.4.4.4.4.4.4.4.4.4.4.4.4.4.4.4.4.4.4.3.2.pic2" overflow="visible" version="1.1" viewBox="0 0 600 126.69" width="600"><g fill="#000000" stroke="#000000" stroke-width="0.4pt" style="--ltx-stroke-color:#000000;--ltx-fill-color:#000000;" transform="translate(0,126.69) matrix(1 0 0 -1 0 0)"><g fill="#FFFFFF" fill-opacity="1.0" style="--ltx-fill-color:#FFFFFF;"><path d="M 0 3.94 L 0 122.76 C 0 124.93 1.76 126.69 3.94 126.69 L 596.06 126.69 C 598.24 126.69 600 124.93 600 122.76 L 600 3.94 C 600 1.76 598.24 0 596.06 0 L 3.94 0 C 1.76 0 0 1.76 0 3.94 Z" style="stroke:none"></path></g><g fill="#FFFFFF" fill-opacity="1.0" style="--ltx-fill-color:#FFFFFF;"><path d="M 0 3.94 L 0 122.76 C 0 124.93 1.76 126.69 3.94 126.69 L 596.06 126.69 C 598.24 126.69 600 124.93 600 122.76 L 600 3.94 C 600 1.76 598.24 0 596.06 0 L 3.94 0 C 1.76 0 0 1.76 0 3.94 Z" style="stroke:none"></path></g><g fill-opacity="1.0" transform="matrix(1.0 0.0 0.0 1.0 0 0)"><foreignObject height="126.69" overflow="visible" style="--ltx-fo-width:43.36em;--ltx-fo-height:9.16em;--ltx-fo-depth:0em;" transform="matrix(1 0 0 -1 0 126.69)" width="600"><span id="A1.p1.pic1.4.4.4.4.4.4.4.4.4.4.4.4.4.4.4.4.4.4.3.2.pic2.2.2.2.2.2.2.2.2.2.2.2.2.2.2.2.2.2" style="width:43.36em;">
<span id="A1.p1.pic1.4.4.4.4.4.4.4.4.4.4.4.4.4.4.4.4.4.4.3.2.pic2.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.p1"><svg height="62.66" id="A1.p1.pic1.4.4.4.4.4.4.4.4.4.4.4.4.4.4.4.4.4.4.3.2.pic2.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.p1.pic1" overflow="visible" version="1.1" viewBox="0 0 600 62.66" width="600"><g fill="#000000" stroke="#000000" stroke-width="0.4pt" style="--ltx-stroke-color:#000000;--ltx-fill-color:#000000;" transform="translate(0,62.66) matrix(1 0 0 -1 0 0)"><g fill="#999999" fill-opacity="1.0" style="--ltx-fill-color:#999999;"><path d="M 0 2.49 L 0 60.16 C 0 61.54 1.12 62.66 2.49 62.66 L 597.51 62.66 C 598.88 62.66 600 61.54 600 60.16 L 600 2.49 C 600 1.12 598.88 0 597.51 0 L 2.49 0 C 1.12 0 0 1.12 0 2.49 Z" style="stroke:none"></path></g><g fill="#FCFCFC" fill-opacity="1.0" style="--ltx-fill-color:#FCFCFC;"><path d="M 0.42 2.49 L 0.42 44.34 L 599.58 44.34 L 599.58 2.49 C 599.58 1.34 598.66 0.42 597.51 0.42 L 2.49 0.42 C 1.34 0.42 0.42 1.34 0.42 2.49 Z" style="stroke:none"></path></g><g fill-opacity="1.0" transform="matrix(1.0 0.0 0.0 1.0 15.42 48.69)"><foreignObject color="#FFFFFF" height="9.61" overflow="visible" style="--ltx-fg-color:#FFFFFF;--ltx-fo-width:41.13em;--ltx-fo-height:0.69em;--ltx-fo-depth:0em;" transform="matrix(1 0 0 -1 0 9.61)" width="569.16">
<span id="A1.p1.pic1.4.4.4.4.4.4.4.4.4.4.4.4.4.4.4.4.4.4.3.2.pic2.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.p1.pic1.1.1.1.1.1" style="width:35.77em;">
<span id="A1.p1.pic1.4.4.4.4.4.4.4.4.4.4.4.4.4.4.4.4.4.4.3.2.pic2.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.p1.pic1.1.1.1.1.1.1"><span id="A1.p1.pic1.4.4.4.4.4.4.4.4.4.4.4.4.4.4.4.4.4.4.3.2.pic2.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.p1.pic1.1.1.1.1.1.1.1">No Tools Variant</span></span>
</span></foreignObject></g><g fill-opacity="1.0" transform="matrix(1.0 0.0 0.0 1.0 15.42 10.62)"><foreignObject height="28.9" overflow="visible" style="--ltx-fo-width:41.13em;--ltx-fo-height:1.89em;--ltx-fo-depth:0.19em;" transform="matrix(1 0 0 -1 0 26.21)" width="569.16">
<span id="A1.p1.pic1.4.4.4.4.4.4.4.4.4.4.4.4.4.4.4.4.4.4.3.2.pic2.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.p1.pic1.2.2.2.1.1" style="width:41.13em;">
<span id="A1.p1.pic1.4.4.4.4.4.4.4.4.4.4.4.4.4.4.4.4.4.4.3.2.pic2.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.p1.pic1.2.2.2.1.1.1">Below is a test input grid. Predict the corresponding output grid by applying the rule you found. Do not generate any Python code or use any external tools to solve this task.</span>
</span></foreignObject></g></g></svg>
</span>
<span id="A1.p1.pic1.4.4.4.4.4.4.4.4.4.4.4.4.4.4.4.4.4.4.3.2.pic2.2.2.2.2.2.2.2.2.2.2.2.2.2.2.2.2.2.p2"><svg height="62.66" id="A1.p1.pic1.4.4.4.4.4.4.4.4.4.4.4.4.4.4.4.4.4.4.3.2.pic2.2.2.2.2.2.2.2.2.2.2.2.2.2.2.2.2.2.p2.pic1" overflow="visible" version="1.1" viewBox="0 0 600 62.66" width="600"><g fill="#000000" stroke="#000000" stroke-width="0.4pt" style="--ltx-stroke-color:#000000;--ltx-fill-color:#000000;" transform="translate(0,62.66) matrix(1 0 0 -1 0 0)"><g fill="#999999" fill-opacity="1.0" style="--ltx-fill-color:#999999;"><path d="M 0 2.49 L 0 60.16 C 0 61.54 1.12 62.66 2.49 62.66 L 597.51 62.66 C 598.88 62.66 600 61.54 600 60.16 L 600 2.49 C 600 1.12 598.88 0 597.51 0 L 2.49 0 C 1.12 0 0 1.12 0 2.49 Z" style="stroke:none"></path></g><g fill="#FCFCFC" fill-opacity="1.0" style="--ltx-fill-color:#FCFCFC;"><path d="M 0.42 2.49 L 0.42 44.34 L 599.58 44.34 L 599.58 2.49 C 599.58 1.34 598.66 0.42 597.51 0.42 L 2.49 0.42 C 1.34 0.42 0.42 1.34 0.42 2.49 Z" style="stroke:none"></path></g><g fill-opacity="1.0" transform="matrix(1.0 0.0 0.0 1.0 15.42 48.69)"><foreignObject color="#FFFFFF" height="9.61" overflow="visible" style="--ltx-fg-color:#FFFFFF;--ltx-fo-width:41.13em;--ltx-fo-height:0.69em;--ltx-fo-depth:0em;" transform="matrix(1 0 0 -1 0 9.61)" width="569.16">
<span id="A1.p1.pic1.4.4.4.4.4.4.4.4.4.4.4.4.4.4.4.4.4.4.3.2.pic2.2.2.2.2.2.2.2.2.2.2.2.2.2.2.2.2.2.p2.pic1.1.1.1.1.1" style="width:35.77em;">
<span id="A1.p1.pic1.4.4.4.4.4.4.4.4.4.4.4.4.4.4.4.4.4.4.3.2.pic2.2.2.2.2.2.2.2.2.2.2.2.2.2.2.2.2.2.p2.pic1.1.1.1.1.1.1"><span id="A1.p1.pic1.4.4.4.4.4.4.4.4.4.4.4.4.4.4.4.4.4.4.3.2.pic2.2.2.2.2.2.2.2.2.2.2.2.2.2.2.2.2.2.p2.pic1.1.1.1.1.1.1.1">Tools Variant</span></span>
</span></foreignObject></g><g fill-opacity="1.0" transform="matrix(1.0 0.0 0.0 1.0 15.42 10.62)"><foreignObject height="28.9" overflow="visible" style="--ltx-fo-width:41.13em;--ltx-fo-height:1.89em;--ltx-fo-depth:0.19em;" transform="matrix(1 0 0 -1 0 26.21)" width="569.16">
<span id="A1.p1.pic1.4.4.4.4.4.4.4.4.4.4.4.4.4.4.4.4.4.4.3.2.pic2.2.2.2.2.2.2.2.2.2.2.2.2.2.2.2.2.2.p2.pic1.2.2.2.1.1" style="width:41.13em;">
<span id="A1.p1.pic1.4.4.4.4.4.4.4.4.4.4.4.4.4.4.4.4.4.4.3.2.pic2.2.2.2.2.2.2.2.2.2.2.2.2.2.2.2.2.2.p2.pic1.2.2.2.1.1.1">Below is a test input grid. Predict the corresponding output grid by applying the rule you found. Use python if needed.</span>
</span></foreignObject></g></g></svg>
</span></span></foreignObject></g></g></svg><em id="A1.p1.pic1.6.6.6.6.6.6.6.6.6.6.6.6.6.6.6.6.6.6.5.4.5">Test Input:</em>
<code id="A1.p1.pic1.6.6.6.6.6.6.6.6.6.6.6.6.6.6.6.6.6.6.5.4.2"> <svg height="214.07" id="A1.p1.pic1.5.5.5.5.5.5.5.5.5.5.5.5.5.5.5.5.5.5.4.3.1.pic1" overflow="visible" version="1.1" viewBox="0 0 600 214.07" width="600"><g fill="#000000" stroke="#000000" stroke-width="0.4pt" style="--ltx-stroke-color:#000000;--ltx-fill-color:#000000;" transform="translate(0,214.07) matrix(1 0 0 -1 0 0)"><g fill="#666666" fill-opacity="1.0" style="--ltx-fill-color:#666666;"><path d="M 0 1.8 L 0 212.27 C 0 213.27 0.81 214.07 1.8 214.07 L 598.2 214.07 C 599.19 214.07 600 213.27 600 212.27 L 600 1.8 C 600 0.81 599.19 0 598.2 0 L 1.8 0 C 0.81 0 0 0.81 0 1.8 Z" style="stroke:none"></path></g><g fill="#F7F7F7" fill-opacity="1.0" style="--ltx-fill-color:#F7F7F7;"><path d="M 0.42 1.8 L 0.42 212.27 C 0.42 213.04 1.03 213.66 1.8 213.66 L 598.2 213.66 C 598.97 213.66 599.58 213.04 599.58 212.27 L 599.58 1.8 C 599.58 1.03 598.97 0.42 598.2 0.42 L 1.8 0.42 C 1.03 0.42 0.42 1.03 0.42 1.8 Z" style="stroke:none"></path></g><g fill-opacity="1.0" transform="matrix(1.0 0.0 0.0 1.0 5.95 203.55)"></g></g></svg><span id="A1.p1.pic1.6.6.6.6.6.6.6.6.6.6.6.6.6.6.6.6.6.6.5.4.2.2">Return only this minified JSON (no markdown, no extra keys):</span>
<code id="A1.p1.pic1.6.6.6.6.6.6.6.6.6.6.6.6.6.6.6.6.6.6.5.4.2.1"> <svg height="214.07" id="A1.p1.pic1.6.6.6.6.6.6.6.6.6.6.6.6.6.6.6.6.6.6.5.4.2.1.pic1" overflow="visible" version="1.1" viewBox="0 0 600 214.07" width="600"><g fill="#000000" stroke="#000000" stroke-width="0.4pt" style="--ltx-stroke-color:#000000;--ltx-fill-color:#000000;" transform="translate(0,214.07) matrix(1 0 0 -1 0 0)"><g fill="#666666" fill-opacity="1.0" style="--ltx-fill-color:#666666;"><path d="M 0 1.8 L 0 212.27 C 0 213.27 0.81 214.07 1.8 214.07 L 598.2 214.07 C 599.19 214.07 600 213.27 600 212.27 L 600 1.8 C 600 0.81 599.19 0 598.2 0 L 1.8 0 C 0.81 0 0 0.81 0 1.8 Z" style="stroke:none"></path></g><g fill="#F7F7F7" fill-opacity="1.0" style="--ltx-fill-color:#F7F7F7;"><path d="M 0.42 1.8 L 0.42 212.27 C 0.42 213.04 1.03 213.66 1.8 213.66 L 598.2 213.66 C 598.97 213.66 599.58 213.04 599.58 212.27 L 599.58 1.8 C 599.58 1.03 598.97 0.42 598.2 0.42 L 1.8 0.42 C 1.03 0.42 0.42 1.03 0.42 1.8 Z" style="stroke:none"></path></g><g fill-opacity="1.0" transform="matrix(1.0 0.0 0.0 1.0 5.95 203.55)"></g></g></svg></code></code></code></code></span></span></foreignObject></g></g></svg>
 

## Appendix B Visual Prompt

![[Uncaptioned image]](https://arxiv.org/html/2510.02125v4/figures/train.png)

No Tools Variant

## Appendix C Prompts for Non-Reasoning Models

The prompts we used for non-reasoning models were minimally modified to require an additional field containing a reasoning trace in the final JSON object. Otherwise, the prompts were consistent with those used for reasoning models, including variations for visual settings and settings with tools enabled.

## Appendix D Examples of Correct-Unintended Rules

In the following example, o3, using medium effort and tools, performs shallow inference for a task from the Horizontal vs. Vertical concept group. The model does not recognize the relation between the orientation of the colored shape components and the blue row, but rather focuses on whether a blue (“8”) pixel appears in the grid. In this case, the correct-intended rule works for the given test case, but does not work for other test variants.

![[Uncaptioned image]](https://arxiv.org/html/2510.02125v4/figures/RuleExample1.png)

The next example features o3, using medium effort and tools, on a task from the Complete Shape concept group. The model does not recognize the relationship between the colored output shape and the gray prototype and instead overfits to the demonstrations, producing a correct-unintended rule based on shallow features.

In the next example, Claude Sonnet 4 uses a density heuristic to approximate the most overlapped figure on a task from the Top vs. Bottom 3D group. While this approach works for some of the test examples, it fails to capture the notion of the bottommost shape in a 3D stack and does not generalize to closely related variations.

## Appendix E Output Accuracy for Non-Reasoning Models

As shown in Table 3 the accuracies of the non-reasoning models were dramatically lower than those of the reasoning models (Table 1). For GPT-4o, in almost all cases in both modalities, the model generated an output grid that was incorrect. For Llama 4 Scout and Qwen 2.5 VL 72B, the same was true in the textual modality; however, for Qwen, in almost all cases in the visual modality, the model was not able to generate an answer at all and did not return the requested JSON format. This was true to a lesser extent for Llama 4 Scout. Determining why these models had difficulty generating answers in a valid format is a topic for future research.

Table 3: Non-reasoning models: Output-grid accuracy (pass@1) on Concept-ARC across models and experimental settings. Accuracy is shown in %. Each cell shows accuracy in the visual / textual modality. Temperature is set to 0.0 for all models. Bold numbers correspond to the highest score in each column. The Llama and Qwen interfaces did not provide options for Python tool use.

| Non-Reasoning model | No Python Tools | With Python Tools |
| --- | --- | --- |
|  | Textual / Visual | Textual / Visual |
| GPT-4o | 14.6 / 0.0 | 8.3 / 0.2 |
| Llama 4 Scout | 6.7 / 0.0 | \- |
| Qwen 2.5 VL 72B | 9.2 / 0.0 | \- |

## Appendix F Table 1 Output Accuracy Without Order5

We discovered that in the ConceptARC corpus [^28], one of the 160 tasks (task 5 of the“Order” concept group) includes a training demonstration containing a misplaced grid cell. We reanalyzed the data in Table 1 with Order5 removed and obtained the results shown in Table 4. The resulting changes are negligible and do not meaningfully affect our conclusions.

Table 4: This table reports the same data as Table 1, with Order5 removed from the analysis.

| Model |  | low | medium | low +T | medium +T |
| --- | --- | --- | --- | --- | --- |
| o3 | t | 68.6 | 77.6 | 68.3 | 75.9 |
|  | v | 6.7 | 5.7 | 18.2 | 29.4 |
| o4-mini | t | 52.4 | 70.9 | 57.7 | 77.8 |
|  | v | 3.8 | 8.2 | 6.7 | 25.2 |
| Claude | t | N/A | 60.6 | N/A | 55.3 |
|  | v | N/A | 5.2 | N/A | 6.9 |
| Gemini | t | N/A | 66.5 | N/A | 60.4 |
|  | v | N/A | 4.2 | N/A | 5.9 |

## Appendix G Error-Type Overview

![Refer to caption](https://arxiv.org/html/2510.02125v4/x3.png)

Figure 4: Overview of different error types for o3 in different experimental settings. For each setting, the left bar shows textual modality results and the right bar shows visual modality results. The most common error type is a simple mismatch error, in which the output grid and the ground truth grid are not identical, including cases of incorrect grid dimensions and single-cell mismatches. We also encountered parsing errors, most often originating from incorrect formatting (see Appendix K )as well as from grids with rows of differing lengths.

## Appendix H Concept Performance Overview

ConceptARC [^28] is organized around 16 basic spatial and semantic concepts. Each concept group consists of 10 tasks that focus on the concept in different ways, with each task containing three distinct test grids. Table 5 and Table 6 give the per-concept-group accuracies (each out of 30 grids) of the reasoning models we evaluated (using medium reasoning effort and Python tools), as well as human accuracies on these concept groups from [^28]. Human trials were administered solely using visual images of the demonstration and test grids, but human accuracy is reported in both tables for ease of comparison.

### H.1 Concept Performance Comparison for Textual Modality

Table 5: Concept performance (Textual): Per-concept accuracy (%) on Concept-ARC using medium effort + tools. Highest accuracy per concept is shown in bold.

| Concept | Gemini 2.5 Pro | o3 | o4-mini | Claude Sonnet 4 | Human |
| --- | --- | --- | --- | --- | --- |
| AboveBelow | 60 | 90 | 83.3 | 63.3 | 69 |
| Center | 70 | 93.3 | 96.7 | 83.3 | 84 |
| CleanUp | 23.3 | 46.7 | 60 | 46.7 | 89 |
| CompleteShape | 56.7 | 70 | 66.7 | 50 | 71 |
| Copy | 66.7 | 70 | 90 | 56.7 | 78 |
| Count | 86.7 | 80 | 80 | 76.7 | 61 |
| ExtendToBoundary | 60 | 90 | 83.3 | 50 | 81 |
| ExtractObjects | 56.7 | 76.7 | 86.7 | 43.3 | 67 |
| FilledNotFilled | 73.3 | 76.7 | 83.3 | 63.3 | 82 |
| HorizontalVertical | 53.3 | 70 | 70 | 63.3 | 68 |
| InsideOutside | 66.7 | 80 | 73.3 | 43.3 | 68 |
| MoveToBoundary | 63.3 | 80 | 70 | 40 | 78 |
| Order | 50 | 70 | 70 | 40 | 76 |
| SameDifferent | 56.7 | 83.3 | 86.7 | 53.3 | 68 |
| TopBottom2D | 76.7 | 86.7 | 93.3 | 56.7 | 79 |
| TopBottom3D | 46.7 | 53.3 | 56.7 | 50 | 70 |

### H.2 Concept Performance Comparison for Visual Modality

Table 6: Concept performance (Visual): Per-concept accuracy (%) on Concept-ARC using medium effort + tools. Highest accuracy per concept is shown in bold.

| Concept | Gemini 2.5 Pro | o3 | o4-mini | Claude Sonnet 4 | Human |
| --- | --- | --- | --- | --- | --- |
| AboveBelow | 0 | 20 | 10 | 0 | 69 |
| Center | 6.7 | 43.3 | 26.7 | 6.7 | 84 |
| CleanUp | 10 | 23.3 | 26.7 | 13.3 | 89 |
| CompleteShape | 3.3 | 30 | 23.3 | 16.7 | 71 |
| Copy | 3.3 | 20 | 23.3 | 3.3 | 78 |
| Count | 16.7 | 53.3 | 50 | 0 | 61 |
| ExtendToBoundary | 0 | 20 | 13.3 | 3.3 | 81 |
| ExtractObjects | 3.3 | 30 | 36.7 | 0 | 67 |
| FilledNotFilled | 6.7 | 30 | 20 | 0 | 82 |
| HorizontalVertical | 3.3 | 33.3 | 20 | 6.7 | 68 |
| InsideOutside | 6.7 | 16.7 | 13.3 | 10 | 68 |
| MoveToBoundary | 3.3 | 30 | 10 | 16.7 | 76 |
| Order | 10 | 33.3 | 36.7 | 13.3 | 60 |
| SameDifferent | 6.7 | 26.7 | 26.7 | 6.7 | 68 |
| TopBottom2D | 13.3 | 33.3 | 50 | 3.3 | 79 |
| TopBottom3D | 0 | 23.3 | 13.3 | 10 | 70 |

### H.3 Concept Difficulty Evaluation

Although we find no significant correlation in concept difficulty across modalities (visual vs. textual) or with human participants, we do identify several overarching trends. Full per-concept performance comparisons are shown in Table 5 and Table 6; in particular, note the performance differences for the concepts “Count” and “CleanUp.”Tasks in the group “Count” frequently involve the production of simple, singular output rows or columns, denoting the count of specific characteristics (e.g shapes, colors, corners). Correspondingly, output grids are often small and easy to generate. In the visual modality, this is the performance closest to humans for both o3 (-7.7%) <sup>7</sup> and Gemini (-44%), and in the textual modality, this concept also results in the biggest positive difference (o3: +32.3%; Gemini: +25.7%; Claude: +15.7%). In contrast, tasks in the CleanUp concept group require the removal of several colors, shapes, or isolated pixels, as well as full reproduction of the remaining input grid. In this concept group, even o3 using medium effort + tools is significantly outperformed by human participants in the visual setting (-65.7%). Similarly, answers to CleanUp tasks constitute the largest negative performance gap in the textual modality (-46.3%). The gap between the other models is even larger. This is a strong indicator that, regardless of modality, models struggle significantly with producing complex output grids.

![Refer to caption](https://arxiv.org/html/2510.02125v4/x4.png)

Figure 5: Top row: Two example demonstrations from the concepts with the highest and lowest gaps between human and model performance, Count and CleanUp. Bottom row: Concept-wise output grid accuracy across three reasoning models in a medium with tools setting (note that we compare against the strongest settings in subsection H.3 ).

## Appendix I Data for Rule Evaluation Plots

Table 7: Data used to create Figure 2. For o3, Claude, Gemini, and human-generated rules, each cell reports the percentage of tests in a rule classification (Correct-Intended, Correct-Unintended, Incorrect, or Not-Classified), partitioned by the correctness of the output grid (Correct Grid vs. Incorrect Grid), for both modalities. Model percentages are computed over a total of 480 tasks. Human percentages are computed over approximately 4,175 total tests. A rule may be labeled Not-Classified because the rule could not be clearly classified by our team, or because no rule could be collected for that particular test. Rules were not collected for incorrect grids in the original human experiment, and so all human responses with incorrect grids are reported here as Not-Classified; these statistics are estimates based on the 73% grid accuracy reported by the original experimenters. The final row of statistics for humans show the rule classification breakdown when excluding Not-Classified rules.

<table><tbody><tr><td>Model (Modality)</td><td colspan="4">Correct Grid</td><td colspan="4">Incorrect Grid</td></tr><tr><td></td><th>Correct- Intended</th><th>Correct- Unint.</th><th>Incorrect</th><th>Not- Classif.</th><th>Correct- Intended</th><th>Correct- Unint.</th><th>Incorrect</th><th>Not- Classif.</th></tr><tr><td>o3 (Textual)</td><td>55.0</td><td>15.8</td><td>4.8</td><td>0.0</td><td>2.3</td><td>12.7</td><td>8.8</td><td>0.6</td></tr><tr><td>o3 (Visual)</td><td>20.4</td><td>5.6</td><td>3.1</td><td>0.0</td><td>19.6</td><td>12.9</td><td>32.5</td><td>5.8</td></tr><tr><td>Claude Sonnet 4 (Textual)</td><td>44.2</td><td>5.2</td><td>5.0</td><td>0.6</td><td>13.3</td><td>9.4</td><td>16.3</td><td>6.1</td></tr><tr><td>Claude Sonnet 4 (Visual)</td><td>4.0</td><td>0.4</td><td>2.1</td><td>0.4</td><td>10.4</td><td>2.5</td><td>66.5</td><td>13.8</td></tr><tr><td>Gemini 2.5 Pro (Textual)</td><td>43.8</td><td>11.9</td><td>4.8</td><td>0.0</td><td>2.3</td><td>10.0</td><td>25.6</td><td>1.6</td></tr><tr><td>Gemini 2.5 Pro (Visual)</td><td>4.6</td><td>0.2</td><td>1.0</td><td>0.0</td><td>19.0</td><td>5.4</td><td>67.1</td><td>2.7</td></tr><tr><td>Human (All Data)</td><td>53.7</td><td>2.7</td><td>3.0</td><td>13.6</td><td>–</td><td>–</td><td>–</td><td>27.0</td></tr><tr><td>Human (Excl. Not-Classified)</td><td>90.3</td><td>4.6</td><td>5.1</td><td>–</td><td>–</td><td>–</td><td>–</td><td>–</td></tr></tbody></table>

Table 8: Data used to create Figure 3. For all o3 settings, each cell reports the percentage of tasks in a rule classification (Correct-Intended, Correct-Unintended, Incorrect, Not-Classified), partitioned by the correctness of the output grid (Correct Grid vs. Incorrect Grid), for both modalities. A model rule may be labeled Not-Classified because the rule could not be confidently evaluated by our team, or because the model did not output a rule. All percentages are computed over 480 total tasks.

<table><tbody><tr><td>o3 Setting (Modality)</td><td colspan="4">Correct Grid</td><td colspan="4">Incorrect Grid</td></tr><tr><td></td><th>Correct- Intended</th><th>Correct- Unint.</th><th>Incorrect</th><th>Not- Classif.</th><th>Correct- Intended</th><th>Correct- Unint.</th><th>Incorrect</th><th>Not- Classif.</th></tr><tr><td>Low effort (Textual)</td><td>49.4</td><td>13.1</td><td>5.8</td><td>0.0</td><td>4.2</td><td>7.5</td><td>18.8</td><td>1.3</td></tr><tr><td>Low effort (Visual)</td><td>5.4</td><td>0.2</td><td>1.0</td><td>0.0</td><td>26.3</td><td>4.4</td><td>56.7</td><td>6.0</td></tr><tr><td>Medium effort (Textual)</td><td>52.7</td><td>17.3</td><td>7.1</td><td>0.0</td><td>1.9</td><td>11.0</td><td>9.8</td><td>0.2</td></tr><tr><td>Medium effort (Visual)</td><td>3.1</td><td>0.6</td><td>1.9</td><td>0.0</td><td>27.3</td><td>5.2</td><td>54.2</td><td>7.7</td></tr><tr><td>Low effort + tools (Textual)</td><td>45.8</td><td>16.5</td><td>5.6</td><td>0.0</td><td>2.1</td><td>11.3</td><td>15.2</td><td>3.5</td></tr><tr><td>Low effort + tools (Visual)</td><td>14.4</td><td>2.1</td><td>1.7</td><td>0.0</td><td>23.3</td><td>7.9</td><td>35.8</td><td>14.8</td></tr><tr><td>Medium effort + tools (Textual)</td><td>55.0</td><td>15.8</td><td>4.8</td><td>0.0</td><td>2.3</td><td>12.7</td><td>8.8</td><td>0.6</td></tr><tr><td>Medium effort + tools (Visual)</td><td>20.4</td><td>5.6</td><td>3.1</td><td>0.0</td><td>19.6</td><td>12.9</td><td>32.5</td><td>5.8</td></tr></tbody></table>

## Appendix J Correct-Intended Coverage

Table 9: Correct-intended task coverage: Number of tasks covered correctly by category and modality, with coverage rates listed as a percentage of the 480 total ConceptARC tasks. Here, a task is considered “covered” if the model in question produced a correct-intended rule in any of its solutions for that task in the given modality. The “AnyModel” rows show task coverage aggregated across all three reasoning models, and the entry for humans shows the coverage of tasks for which at least one human subject produced a correct-intended rule.

| Category | Modality | Covered | Percentage |
| --- | --- | --- | --- |
| Humans | Overall | 476 | 99.17 |
| o3 | Textual | 412 | 85.83 |
| o3 | Visual | 281 | 58.54 |
| Claude | Textual | 346 | 72.08 |
| Claude | Visual | 83 | 17.29 |
| Gemini | Textual | 326 | 67.92 |
| Gemini | Visual | 140 | 29.27 |
| AnyModel | Textual | 454 | 94.58 |
| AnyModel | Visual | 320 | 66.67 |

### J.1 Correct-Intended Coverage Implications

Table 9 shows that, while models (in textual modality) all have a decent coverage, pooling their answers only leads to a moderate increase as compared to the best performing single model (+9%). While the overall coverage is notably lower in visual modality, the increase when pooling the three models again is comparable to textual (+8%). As we do not have individual human performance data, we unfortunately cannot compute similar statistics for pooling single human performances. However, these results again point out stronger abstractive reasoning abilities in a human panel, which only failed to derive the correct abstract transformation in 4 test examples (AboveBelow2 Test 3, CompleteShape4 Test 1, HorizontalVertical5 Test 1, Order9 Test 3). It is worth noting that our human rule dataset did not contain rules for grids with incorrect outputs, meaning that the score of 476/480 is a lower bound, as some humans who produced incorrect grids may nevertheless have inferred the correct-intended rules.

## Appendix K Output Grid Accuracies Reassessed For Incorrect Grid Formats

To compute the accuracies reported in Table 3 and Table 1, we followed the ARC-Prize evaluation method [^1]: we counted an output grid as correct only if it perfectly matched the ground-truth output grid and was in the format requested in the prompt (see Appendix A and Appendix B). However, upon exhaustive examination of the output grids generated by different models, we found that, in some cases, models generated these answer grids in different formats than that requested in the prompt; these answers were assessed as incorrect. The incorrect output grid formats included surrounding grid rows with brackets, using commas or slashes as row separators, and several other variations.

We re-assessed each case of such formatting to see if the intended grid was actually correct. Table 10 gives, for each model and experimental setting, the original output-grid accuracy from Table 1 or Table 3 and the revised output-grid accuracy when incorrect formats are allowed. Table 10 shows that accepting alternate grid formats leads to minor increases in accuracy in most cases, with a few exceptions in which the accuracy rose by more than 5%: o4-mini low-effort, o4-mini low-effort + tools, and Claude Sonnet 4 medium-effort, which had the largest increase: 60.2% to 72.5%.

In summary, while models sometimes generate their answer grid in a different format than what we requested, whether we accept these formats as valid answers and assess their correctness does not have a large effect on our overall results.

In a smaller number of cases, all in the visual setting, models would generate a natural-language description of the output grid rather than the grid itself. We did not consider these to be in a valid answer format and counted such outputs as incorrect.

Table 10: Output grid accuracies with alternative grid formats included. For each model and setting, we give original accuracy / re-assessed accuracy. Original accuracies are from Table 3 and Table 1.

| Model | Setting | Textual | Visual |
| --- | --- | --- | --- |
|  |  | Original / Re-assessed | Original / Re-assessed |
| o3 | low effort | 68.3 / 69.4 | 6.5 / 6.5 |
| o3 | medium effort | 77.1 / 77.1 | 5.6 / 5.6 |
| o3 | low effort + tools | 67.9 / 68.1 | 18.2 / 18.2 |
| o3 | medium effort + tools | 75.6 / 75.6 | 29.2 / 29.2 |
| o4-mini | low effort | 52.1 / 59.6 | 3.8 / 3.8 |
| o4-mini | medium effort | 70.8 / 73.8 | 8.1 / 8.1 |
| o4-mini | low effort + tools | 57.3 / 62.5 | 6.7 / 6.7 |
| o4-mini | medium effort + tools | 77.7 / 78.8 | 25.0 / 25.0 |
| Claude Sonnet 4 | medium | 60.2 / 72.5 | 5.2 / 5.2 |
| Claude Sonnet 4 | medium + tools | 55.0 / 59.2 | 6.9 / 6.9 |
| Gemini 2.5 Pro | medium effort | 66.0 / 66.0 | 4.2 / 4.2 |
| Gemini 2.5 Pro | medium effort + tools | 60.4 / 60.4 | 5.8 / 5.8 |
| GPT-4o | no tools | 14.6 / 14.6 | 0.0 / 0.0 |
| GPT-4o | with tools | 8.3 / 13.1 | 0.2 / 0.2 |
| Llama 4 Scout | no tools | 6.7 / 8.5 | 0.0 / 0.0 |
| Qwen 2.5 VL 72B | no tools | 9.2 / 10.0 | 0.0 / 0.0 |

## Appendix L Distribution of Correct-Unintended Rules Across Concepts

Upon discovering the usage of correct but unintended rules, we were interested in analyzing the distribution of these among different concepts. In particular, models might be systematically employing unintended rules on tasks they lack meaningful priors for. Under textual modalities, when models arrived at a “correct” rule, they produced correct-unintended results in about 29.82% those cases with a standard deviation of 16.44%. The concepts with the highest share of correct-unintended rules were TopBottom3D (70.59%), CleanUp (52.27%) and HorizontalVertical (45.12%). For the visual modality, the average usage of correct-unintended rules was 27.0%, with a standard deviation of 13.92%. Again, the concepts with the highest share are TopBottom3D (62.50%) and CleanUp (40%), but also SameDifferent (47.83%). HorizontalVertical had a reduced share of unintended rules, with only 35.42%, ranking at fourth-most.

We generally refer to the share of unintended abstractions of correct rules here (intended and unintended), rather than of all rules, in order to account for the difference in rule correctness between modalities. As Table 5 and Table 6 show, TopBottom3D is one of the most difficult concepts for models when measured by accuracy (second-lowest in textual, third-lowest in visual), so it is not surprising that models largely rely on unintended rules when solving corresponding tasks. Analyzing the rules generated for tasks in this concept group more closely, few of them actually addressed 3-dimensional arrangement, but instead relied on shallower features, such as density or bounding-box interceptions.

While CleanUp produced the lowest overall accuracy in textual modality, it achieved the fourth-highest in visual modality, so it is intuitive to find increased shortcut-usage using text representations. The high share of unintended rules in vision-based inputs is somewhat surprising, but is likely due to difficulties with recognizing global patterns. This is an issue with both modalities, as models tend to employ local patterns, or case-by-case logic, which were overfit to the training demonstrations. In particular, models frequently recognize simple line-based patterns, such as alternating horizontal or vertical lines, but struggle with recognizing individual objects,since they seem to lack a strong prior for “objectness.”

In the other concept groups, and on various tasks in general, we found that the models’ generated rules involve recurring heuristics, including the employment of bounding boxes, four/eight-neighbor connectivity, as well as finding paths to the grid edge or object boundary by stepping through adjacent (4- or 8-connected) cells. These unintended abstractions seemed to be part of a general-purpose tool-box, which models employed for various purposes and not specific to single concepts.

[^1]: ARC-AGI benchmarking. Note: [https://github.com/arcprize/arc-agi-benchmarking](https://github.com/arcprize/arc-agi-benchmarking) Cited by: Appendix K.

[^2]: ARC-AGI leaderboard. Note: [https://arcprize.org/leaderboard](https://arcprize.org/leaderboard) Cited by: §4.

[^3]: Dreaming with arc. In Learning Meets Combinatorial Algorithms Workshop at NeurIPS2020, Cited by: §5.

[^4]: Neural networks for abstraction and reasoning. Scientific Reports 14 (1), pp. 27823. Cited by: §5.

[^5]: Pattern Recognition. Spartan Books. Cited by: §5.

[^6]: The origin of concepts. MIT Press, Cambridge, MA. Cited by: §1.

[^7]: ARC-AGI-2: a new challenge for frontier AI reasoning systems. arXiv preprint arXiv:2505.11831. Cited by: §1, §4, §4.

[^8]: ARC Prize 2024: Technical Report. arXiv preprint arXiv:2412.04604. Cited by: §1, §5.

[^9]: On the measure of intelligence. arXiv preprint arXiv:1911.01547. Cited by: §1, §2, §4.

[^10]: OpenAI o3 Breakthrough High Score on ARC-AGI-Pub. Note: [https://arcprize.org/blog/oai-o3-pub-breakthrough](https://arcprize.org/blog/oai-o3-pub-breakthrough) Cited by: §1, §2, §3, §5, §7.

[^11]: The Abstraction and Reasoning Corpus (ARC). Note: [https://github.com/fchollet/ARC](https://github.com/fchollet/ARC) Cited by: §1.

[^12]: Shortcut learning of large language models in natural language understanding. Communications of the ACM 67 (1), pp. 110–120. Cited by: §2.

[^13]: Index of Bongard Problems. Note: [http://www.foundalis.com/res/bps/bpidx.htm](http://www.foundalis.com/res/bps/bpidx.htm) Cited by: §1.

[^14]: Baby steps in evaluating the capacities of large language models. Nature Reviews Psychology 2 (8), pp. 451–452. Cited by: §4.

[^15]: Shortcut learning in deep neural networks. Nature Machine Intelligence 2 (11), pp. 665–673. Cited by: §2.

[^16]: Can mllms reason in multimodality? emma: an enhanced multimodal reasoning benchmark. Proceedings of the International Conference on Machine Learning, ICML 2025. Cited by: §3.

[^17]: Response: emergent analogical reasoning in large language models. arXiv preprint arXiv:2308.16118. Cited by: §5.

[^18]: Metamagical Themas: Questing for the Essence of Mind and Pattern. Cited by: §5.

[^19]: Fluid Concepts and Creative Analogies: Computer Models of the Fundamental Mechanisms of Thought. Basic Books, New York. Cited by: §1.

[^20]: Epilogue: analogy as the core of cognition. In The Analogical Mind: Perspectives from Cognitive Science, D. Gentner, K. J. Holyoak, and B. N. Kokinov (Eds.), Cited by: §1.

[^21]: ARC is a vision problem!. arXiv preprint arXiv:2511.14761. Cited by: §5.

[^22]: How to evaluate the cognitive abilities of LLMs. Nature Human Behaviour 9 (2), pp. 230–233. Cited by: §4.

[^23]: Highly accurate protein structure prediction with alphafold. nature 596 (7873), pp. 583–589. Cited by: §4.

[^24]: Building machines that learn and think like people. Behavioral and brain sciences 40, pp. e253. Cited by: §1.

[^25]: A comprehensive behavioral dataset for the abstraction and reasoning corpus. Scientific Data 12 (1), pp. 1380. Cited by: §2, §5, footnote 2.

[^26]: Evaluating the robustness of analogical reasoning in GPT models. Transactions on Machine Learning Research. Cited by: §5.

[^27]: Reasoning limitations of multimodal large language models. a case study of bongard problems. arXiv preprint arXiv:2411.01173. Cited by: §5.

[^28]: The ConceptARC benchmark: evaluating understanding and generalization in the ARC domain. Transactions on Machine Learning Research. Cited by: Appendix F, Appendix H, §1, §2, §2, §2, §3, §3.

[^29]: Thinking With Images. Note: [https://openai.com/index/thinking-with-images/](https://openai.com/index/thinking-with-images/) Cited by: §1.

[^30]: Bongard-rwr+: real-world representations of fine-grained concepts in bongard problems. arXiv preprint arXiv:2508.12026. Cited by: §5.

[^31]: Principles of animal cognition for LLM evaluations: a case study on transitive inference. In Proceedings of the International Conference on Machine Learning, ICML-2025, Cited by: §4.

[^32]: Progressive matrices test: a perceptual test of intelligence: individual form. H.K. Lewis & Company. Cited by: §5.

[^33]: Emergent analogical reasoning in large language models. Nature Human Behaviour 7 (9), pp. 1526–1541. Cited by: §5.

[^34]: DSL Solution to the ARC Challenge. External Links: [Link](https://github.com/top-quarks/ARC-solution/blob/master/ARC-solution_documentation.pdf) Cited by: §5.

[^35]: Bongard in wonderland: visual puzzles that still make ai go mad?. arXiv preprint arXiv:2410.19546. Cited by: §5.

[^36]: A benchmark for compositional visual reasoning. Advances in Neural Information Processing Systems 35, pp. 29776–29788. Cited by: §5.

[^37]: RAVEN: a dataset for relational and analogical visual reasoning. In Proceedings of the IEEE/CVF Conference on Computer Vision and Pattern Recognition, pp. 5317–5327. Cited by: §1, §5.

[^38]: How far are we from intelligent visual deductive reasoning?. arXiv preprint arXiv:2403.04732. Cited by: §5.

[^39]: On data synthesis and post-training for visual abstract reasoning. arXiv preprint arXiv:2504.01324. Cited by: §5.