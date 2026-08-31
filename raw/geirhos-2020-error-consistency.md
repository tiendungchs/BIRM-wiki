---
title: "Beyond accuracy: quantifying trial-by-trial behaviour of CNNs and humans by measuring error consistency"
source: "https://ar5iv.labs.arxiv.org/html/2006.16736"
author:
published:
created: 2026-08-31
description: "A central problem in cognitive science and behavioural neuroscience as well as in machine learning and artificial intelligence research is to ascertain whether two or more decision makers—be they brains or algorithms—u…"
tags:
  - "clippings"
---
Robert GeirhosUniversity of Tübingen & IMPRS-ISrobert.geirhos@uni-tuebingen.de    Kristof MedingUniversity of Tübingenkristof.meding@uni-tuebingen.deFelix A. WichmannUniversity of Tübingenfelix.wichmann@uni-tuebingen.de

###### Abstract

A central problem in cognitive science and behavioural neuroscience as well as in machine learning and artificial intelligence research is to ascertain whether two or more decision makers—be they brains or algorithms—use the same strategy. Accuracy alone cannot distinguish between strategies: two systems may achieve similar accuracy with very different strategies. The need to differentiate beyond accuracy is particularly pressing if two systems are at or near ceiling performance, like Convolutional Neural Networks (CNNs) and humans on visual object recognition. Here we introduce trial-by-trial *error consistency*, a quantitative analysis for measuring whether two decision making systems systematically make errors on the same inputs. Making consistent errors on a trial-by-trial basis is a necessary condition if we want to ascertain similar processing strategies between decision makers. Our analysis is applicable to compare algorithms with algorithms, humans with humans, and algorithms with humans.  
When applying error consistency to visual object recognition we obtain three main findings: (1.) Irrespective of architecture, CNNs are remarkably consistent with one another. (2.) The consistency between CNNs and human observers, however, is little above what can be expected by chance alone—indicating that humans and CNNs are likely implementing very different strategies. (3.) CORnet-S, a recurrent model termed the “current best model of the primate ventral visual stream”, fails to capture essential characteristics of human behavioural data and behaves essentially like a standard purely feedforward ResNet-50 in our analysis; highlighting that certain behavioural failure cases are not limited to feedforward models. Taken together, error consistency analysis suggests that the strategies used by human and machine vision are still very different—but we envision our general-purpose error consistency analysis to serve as a fruitful tool for quantifying future progress.

## 1 Introduction11 1 Blog post summary: https://medium.com/@robertgeirhos/are-all-cnns-created-equal-d13a33b0caf7

Complex systems are notoriously difficult to understand—be they Convolutional Neural Networks (CNNs) or the human mind or brain. Paradoxically, for CNNs, we have access to every single model parameter, know exactly how the architecture is formed of stacked convolution layers, and we can inspect every single pixel of the training data—yet understanding the behaviour emerging from these primitives has proven surprisingly challenging [^1], leaving us continually struggling to reconcile the success story of CNNs with their brittleness [^2] [^3] [^4].<sup>2</sup> In response to the need to better understand the internal mechanisms, a number of visualisation methods have been developed [^6] [^7] [^8]. And while many of them have proven helpful in fuelling intuitions, some have later been found to be misleading [^9] [^10]; moreover, most visualisation analyses are qualitative at nature. On the other hand, quantitative comparisons of different algorithms like benchmarking model accuracies have led to a lot of progress across deep learning, but reveal little about the internal mechanism: two models may reach similar levels of accuracy with very different internal processing strategies, an aspect that is gaining importance as CNNs are rapidly approaching ceiling performance across tasks and datasets. In order to understand whether two algorithms are implementing a similar or a different strategy, we need analyses that are quantitative *and* allow for drawing conclusions about the internal mechanism.

(a)

(b)

(c)

Figure 1: Do humans and CNNs make consistent errors? From left to right three steps for analysing this question are visualised. For a detailed description of these steps please see the intuition (1.1). (a) Observed vs. expected error overlap (errors on the same trials) for a classification experiment where humans and CNNs classified the same images [^11]. Values above the diagonal indicate more overlap than expected by chance. (b) Same data as on the left but measured by error consistency ($\kappa$). Higher values indicate greater consistency; shaded areas correspond to a simulated 95% percentile for chance-level consistency. (c) Error consistency vs. ImageNet accuracy.

We here introduce *error consistency* <sup>3</sup>, a quantitative analysis for measuring whether two black-box perceptual systems systematically make errors on the same inputs. Irrespective of any potential differences at Marr’s implementational level [^12] (which may be quite large, e.g. between two different neural network architectures or even larger between a CNN and a human observer), one can only conclude that two systems use a similar strategy if these systems make similar errors: not just a similar number of errors (as measured by accuracy), but also errors on the same inputs, i.e. if two systems find the same individual stimuli difficult or easy (as measured by error consistency). An agreement can be considered inverse to the Reichenbach-principle [^13] of correlation: correlation between variables does not imply a direct causal relationship. However, correlation does imply *at least* an indirect causal link through other variables. For error consistency, zero error consistency implies that two decision makers are not using the same strategy. While error consistency can be applied across fields, tasks and domains (including vision, auditory processing, etc.), we believe it to be of particular relevance at the intersection of deep learning, neuroscience and cognitive science. Both brains and CNNs have, at various points, been described as black-box mechanisms [^14] [^15] [^16]. But do the spectacular advances in deep learning shed light on the perceptual and cognitive processes of biological vision? Does similar performance imply similar mechanism or algorithm? Do different CNNs indeed make different errors?<sup>4</sup> We believe that fine-grained analysis techniques like error consistency may serve an important purpose in this debate.

Molecular psychophysics. Analysing errors for every single input is inspired by the idea of “molecular psychophysics” by David Green [^18]. He argued that the goal of psychophysics should be to predict human responses to individual stimuli (trials) and not only aggregated responses (accuracy), let alone only averages across many individuals, as is common in much of the behavioural sciences. Green also predicted that once models of perceptual processes became more advanced, accuracy would cease to be a good criterion to assess and compare them rigorously (see p. 394 in [^18]).

Related work. Using error consistency we can analyse human and CNN error patterns in a way that has, we believe, not been done before. We obtain *novel findings* but we do not consider error consistency to be an entirely *novel method* by itself. Instead, it builds on, extends and adapts existing methods and ideas developed in three different fields: molecular psychophysics (as described above) as well as causal inference and the social sciences (as described below). Our goal is the systematic analysis of human and CNN error patterns at the trial-by-trial level. Many previous analyses have focused on the aggregated level instead: In machine learning, performance is predominantly measured by accuracy and existing metrics to analyse errors such as comparisons between confusion matrices [^19] [^20] [^21] [^22] [^23] or scores based on KL divergence [^24] pool over single trials, thereby losing crucial information—they are not “molecular” but only “molar” in Green’s terminology [^18]. [^25] [^26] went an important step further by comparing errors at an image-by-image level, but consistency was only computed *after* aggregating across participants, and [^25] use a metric that automatically leads to higher consistency when comparing two systems with higher accuracy (without discounting for consistency due to chance). Closely related to our analysis is [^27], who investigated similarity between models in the context of overfitting. In the context of causal inference, [^28] performed a trial-by-trial analysis, plotting expected vs. observed behaviour (a starting point for our analysis). In social sciences, psychology and medicine, comparisons between participants are common, e.g. for problems like “How do people differ when answering a questionnaire?”. In that context, so-called inter-rater agreement is measured by Cohen’s kappa [^29]. Here we repurpose and extend Cohen’s kappa ($\kappa$) for the analysis of classification errors by humans and machines, and provide confidence intervals and analytical bounds (limiting possible consistency).

Terminology. A *decision maker* is any (living or artificial) entity that implements a decision rule. A *decision rule* is a function that defines a mapping from input to output (see [^4] for a taxonomy of decision rules). Note that the same decision rule can result from different strategies. We use the term *strategy* synonymously with the term *algorithm*. For instance, Quicksort(X) and Mergesort(X) use a different algorithm (strategy), but they implement the same decision rule: the output will always be the same. Permute(X), on the other hand, will (usually) lead to a different output. Hence, similar output (or similar errors, i.e., high error consistency) is a necessary, but not a sufficient condition for similar strategies.

### 1.1 Intuition

Before going through the mathematical details in Section 2, let us consider a simple example of a psychophysical experiment where human observers and CNNs classified objects from 160 images (line drawing / edge-like stimuli in this case). There are three steps in order to analyse error consistency (visualised in Figure 1). We can start by analysing how many of the decisions (either correct or incorrect) to individual trials are identical (*observed error overlap*). This number only becomes meaningful when plotted against the *error overlap expected by chance* (Figure 1(a)): for instance, two observers with high accuracies will necessarily agree on many trials by chance alone. However, this visualisation may be hard to interpret since higher values do not simply correspond to higher consistency (instead, above-chance consistency is measured by distance from the diagonal). In a second step, we can therefore normalise the data (Figure 1(b)) by dividing each datapoint’s distance to the diagonal by the total distance between the diagonal and ceiling (1.0). Now, we can directly compare the error consistency between decision makers: if error consistency is measured by $\kappa$, then $\kappa=0$ means chance-level consistency (independent processing strategies), $\kappa>0$ indicates consistency beyond chance (similar strategies) and $\kappa<0$ inconsistency beyond chance (inverse strategies). Lastly, we can analyse the relationship between error consistency ($\kappa$) and an arbitrary other variable, for instance in order to determine whether better ImageNet accuracy leads to higher consistency between a CNN and human observers (Figure 1(c)), which is not the case here.

## 2 Methods

When comparing two decision makers the most obvious comparison is accuracy. Our goal is to go beyond accuracy per se by assessing the consistency of the responses with respect to individual stimuli. As a prerequisite, all decision makers need to evaluate the exact same stimuli. The order of presentation is irrelevant as long as the responses can be sorted w.r.t. stimuli afterwards.<sup>5</sup> In the following, we show how error consistency can be computed and which bounds and confidence intervals apply for the observed error overlap (2.1) and for $\kappa$ (2.2). Experimental methods are described in 2.3 and code is available from [https://github.com/wichmann-lab/error-consistency](https://github.com/wichmann-lab/error-consistency).

### 2.1 Observed vs. expected error overlap

If two observers $i$ and $j$ (be they algorithms, humans or animals) respond to the same $n$ trials, we can investigate by how much their decisions overlap. For this purpose, we only analyse whether the decisions were correct/incorrect (irrespective of the number of choices). The observed error overlap $c_{obs}$ is defined as $c_{obs_{i,j}}=\frac{e_{i,j}}{n}$ where $e_{i,j}$ is the number of equal responses (either both correct or both incorrect). In order to find out whether this observed overlap is beyond what can be expected by chance, we can compare observers $i$ and $j$ to a theoretical model: independent binomial observers (binomial: making either a correct or an incorrect decision; independent: only random consistency). In this case, we can expect only overlap due to chance $c_{exp_{i,j}}$:

$$
\displaystyle c_{exp_{i,j}}={\color[rgb]{0.0195,0.4414,0.6914}p_{i}p_{j}}+{\color[rgb]{0.793,0,0.125}(1-p_{i})(1-p_{j})}.
$$

This is the sum of the probabilities that two observers $i$ and $j$ with accuracies $p_{i}$ and $p_{j}$ give the same correct and incorrect response by chance.<sup>6</sup>

Confidence intervals. Unfortunately, the confidence interval of $c_{obs_{i,j}}$ in the scatter-plot of Figure 1(a) is not trivial to obtain. [^28] used a standard binomial confidence interval. This is, however, only a very rough estimate of the true confidence interval since the position on the x-axis ($c_{exp}$) itself is also estimated from the data and thus influenced by variation. We sample data for the null hypothesis of independent observers and calculate the corresponding 95% percentiles (cf. Figure 2). This process is described in Section S.3 in the appendix.

Bounds. Confidence intervals allow to investigate hypotheses. In addition, theoretical bounds might help to assess the degree of the observed consistency not being due to chance: a data point close or at the bound has maximum distance to the diagonal for a given value of $c_{exp}$. For this end we have calculated bounds of $c_{obs}$ as an additional diagnostic tool. The influence of these bounds on the confidence intervals is visualised in Figure 2.

Ideally, we also want to express the bounds of $c_{obs}$ directly as a function of $c_{exp}$. The analytical derivation of the bounds below can be found in the Appendix (S.2) and are visualised in Figure 2.

$$
\displaystyle 0
$$
 
$$
\displaystyle\leq c_{obs_{i,j}}\leq 1-\sqrt{1-2c_{exp_{i,j}}}~~~~
$$
 
$$
\displaystyle\text{if}~~c_{exp_{i,j}}\leq 0.5,
$$
$$
\displaystyle\sqrt{2c_{exp_{i,j}}-1}
$$
 
$$
\displaystyle\leq c_{obs_{i,j}}\leq 1~~~~
$$
 
$$
\displaystyle\text{if}~~c_{exp_{i,j}}\geq 0.5.
$$
![Refer to caption](https://ar5iv.labs.arxiv.org/html/2006.16736/assets/figures/DiagnosticPlotsKappa/DiagnosticPlotSimulateCobsKappa_160.png)

Figure 2: Simulated data of c e x p, o b s c\_{exp},c\_{obs} and κ \\kappa for 160 trials under the assumption of independent decision makers. Analytical bounds and 95% percentile derived from the simulation of 100,000 experiments do not align with the often reported erroneous confidence interval.

### 2.2 Error consistency measured by Cohen’s kappa

$c_{obs_{i,j}}$ described above quantifies the observed error overlap between observers $i$ and $j$. In order to obtain a single behavioural score for error consistency, that is, one disentangled from accuracy <sup>7</sup>, we need to discount for error overlap by chance $c_{exp_{i,j}}$. This is solved by Cohen’s $\kappa$ [^29] with which we measure error consistency:

$$
\displaystyle\kappa_{i,j}=\frac{c_{obs_{i,j}}-c_{exp_{i,j}}}{1-c_{exp_{i,j}}}.
$$

We do not include a comparison of $\kappa$ to the (Pearson) correlation coefficient since it has been shown that correlation is not a suitable measure of agreement [^32] [^33].

Confidence intervals. Confidence intervals of the average $\kappa$ of groups, such as the average error consistency of humans vs. humans in Figure 1(c), are based on the empirical standard error of the mean and a normal distribution assumption of the average error consistency (a numerical simulation of binomial observers confirmed that this assumption is valid here). Analogous to the observed consistency we use a sampling approach to obtain confidence intervals of $\kappa$ given $c_{exp}$, see S.3 for details. This is necessary since the original confidence approximation interval derived by Cohen [^29] (yellow dashes for error consistency in Figure 2) were later shown to be erroneous [^34] [^35].<sup>8</sup> While a corrected approximate version for individual kappas does exist [^34] [^38], there is to our knowledge no analytical or approximate confidence interval for $\kappa$ given $c_{exp}$, and hence our sampling approach.

Bounds. The following bounds show the limits of $\kappa$ given a specific value of $c_{exp}$, please see Section S.2 for the derivation and Figure 2 for visualisation <sup>9</sup>:

$$
\displaystyle\frac{-c_{exp_{i,j}}}{1-c_{exp_{i,j}}}
$$
 
$$
\displaystyle\leq\kappa_{i,j}\leq\frac{1-\sqrt{1-2c_{exp_{i,j}}}-c_{exp_{i,j}}}{1-c_{exp_{i,j}}}~~~~
$$
 
$$
\displaystyle\text{if }c_{exp_{i,j}}\leq 0.5,
$$
$$
\displaystyle\frac{\sqrt{2c_{exp_{i,j}}-1}-c_{exp_{i,j}}}{1-c_{exp_{i,j}}}
$$
 
$$
\displaystyle\leq\kappa_{i,j}\leq 1~~~~
$$
 
$$
\displaystyle\text{if }c_{exp_{i,j}}\geq 0.5.
$$

### 2.3 Experimental methods

Stimuli: motivation. Exemplary stimuli are visualised in Figure 3. We tested both “vanilla” images (plain unmodified colour images from ImageNet [^40]) and three different types of out-of-distribution (o.o.d.) images. The motivation for using o.o.d. images is the following: Significant progress in neuroscience—e.g., discovering receptive fields of simple and complex cells—was made using “unnatural” bar-like stimuli. In deep learning, adversarial examples and texture bias were discovered by testing models on (unnatural) images different than the training data. Hence, we can learn a lot about the inner workings of a system by probing it with appropriate “artificial” stimuli [^41] [^42]; [^4] even argues that o.o.d. testing is a necessity for drawing reliable inferences about a model’s strategy. Standard ImageNet images (where human and pre-trained CNN accuracies are both very high and similar, $.960\pm.036\%$) are included as a baseline condition.

Stimuli: method details. [^11] tested N=10 human observers in their cue conflict, edge and silhouette experiments. Starting from normal images with a white background, different image manipulations were applied. For *cue conflict* images, the texture of a different image was transferred to this image using neural style transfer [^43], creating a texture-shape cue conflict with a total of 1280 trials per observer and network. For *edge* stimuli, a standard edge detector was applied to the original images to obtain line-drawing-like stimuli (160 trials per observer). *Silhouette* stimuli were created by filling the outline of an object with black colour, leaving just the silhouette (160 trials per observer).<sup>10</sup> Lastly, *ImageNet* stimuli were standard coloured ImageNet images; we used the behavioural data (N=2 observers) and stimuli from [^44] for this experiment.

Paradigm. In order to compare the error consistency of two perceptual systems (e.g. CNNs and humans), those two systems a) need to be evaluated on the exact same stimuli and b) need to be in a regime with neither perfect accuracy nor chance-level performance. We found the publicly available stimuli and data from [^11] to be an ideal test case. [^11] compared object recognition abilities of humans and algorithms in a carefully designed psychophysical experiment. After a 200 ms presentation of a $224\times 224$ pixels image, observers had 16 categories to choose from (e.g. car, dog, chair). For ImageNet-trained networks, categorisation responses for 1,000 fine-grained classes were mapped to those 16 classes using the WordNet hierarchy [^45]. In order to obtain the probability of a broad category (e.g. dog), response probabilities of all corresponding fine-grained categories (e.g. all ImageNet dog breeds) were averaged using the arithmetic mean.<sup>11</sup>

Convolutional Neural Networks. Human responses were compared against classification decisions of all available CNN models from the PyTorch model zoo (for torchvision version 0.2.2) and against a recurrent model, CORnet-S [^46]. All CNNs were trained on ImageNet. Details here: S.5. Additionally, we analysed the relationship between model shape bias (induced by training on Stylized-ImageNet) and error consistency with human observers: S.6.

## 3 Results

If two perceptual systems or decision makers implement the same strategy they can be expected to systematically make errors on the same stimuli. In the following, we show how *error consistency* can be used within visual object recognition to compare algorithms with humans (Section 3.1) and algorithms with algorithms (Section 3.2).

### 3.1 Comparing algorithms with humans: investigating whether better ImageNet models show higher error consistency with human behavioural data

In deep learning, there is a strong linear relationship between ImageNet accuracy and transfer learning performance [^47]; in computational neuroscience, better categorisation accuracy improves the prediction of neural firing patterns [^48]. But do better performing ImageNet models also make more human-like errors?

Error consistency vs. model performance. In Figure 3, we analyse the error consistency between human observers and sixteen standard ImageNet-trained CNNs. We find that humans to humans show a fair degree of consistency w.r.t. individual stimuli. That is, their agreement on which cats or chairs or cars are easy/hard to categorise is well beyond chance. Interestingly, CNN-to-CNN consistency is even higher than human-to-human consistency in all three experiments. This occurs despite the fact that human accuracies are higher than CNN accuracies across experiments: for instance in the silhouette experiment, the average human accuracy is 0.75 whereas the average CNN accuracy is 0.54 (see Table 1, supplementary information). However, the consistency between CNNs and humans is close to zero for two experiments (cue conflict stimuli and line drawings); a linear model fit indicates no improvement with better ImageNet validation accuracy: $F(1,158)=0.086,p=.769,R^{2}=0.001$ for cue conflict and $F(1,158)=0.478,p=.491,R^{2}=0.003$ for line drawing stimuli. For silhouettes, there is a significant *positive* relationship between ImageNet accuracy and error consistency with $F(1,158)=53.530,p=1.21\cdot 10^{-11},R^{2}=0.253$; for ImageNet images, on the other hand, there is a significant *negative* relationship between top-5 accuracy and error consistency with $F(1,30)=8.162,p=.008,R^{2}=0.214$.

![Refer to caption](https://ar5iv.labs.arxiv.org/html/2006.16736/assets/figures/stimuli/cue_conflict_stimuli.png)

Refer to caption

We conclude that there is a substantial algorithmic difference between human observers and the investigated sixteen CNNs: humans and CNNs are very likely implementing different strategies. This difference is narrowing down for silhouette stimuli, whereas it is as big as ever for cue conflict, line drawing and ImageNet stimuli: AlexNet from 2012 is just as error-consistent as recent models. Our results are in stark contrast to the observation that better ImageNet models appear to be better models of the primate visual cortex, even if they better predict neural activity [^48].

Error consistency vs. model architecture. We were surprised to see that the consistency between different CNNs is even higher than the consistency between different human observers. In Figure 4(a), we investigate the degree to which this CNN-CNN consistency is influenced by similarities in model architecture. When distinguishing between models from the same architecture family (e.g., all ResNet models) and models from a different model family (e.g., ResNet vs. VGG) we observe that even though models from the same family score higher on average, model-to-model consistency is generally very high.<sup>12</sup> In line with these results, [^27] also reported extremely high similarity between different models on the ImageNet test set. This might shed some light on the finding that many trained and fitted CNNs predict neural data similarly well, largely irrespective of architecture [^49]. Interestingly, the highest observed error consistency ($\kappa=0.793$) occurs for DenseNet-121 vs. ResNet-18: two models from a different model family with different depth (121 vs. 18 layers) and different connectivity. High error consistency between different CNNs suggests that using CNNs as an ensemble may currently be less effective than desirable, since ensembles benefit from independent (rather than consistent) models. It remains an open question why even multiple instances of a single model (trained with a different random seed) *internally* often differ substantially [^50] [^51], yet in spite of large architectural differences across models and model families, all CNNs that we investigated seem to be implementing fairly similar strategies.

### 3.2 Comparing algorithms with algorithms: the “current best model of the primate ventral visual stream” behaves like a vanilla ResNet-50 according to error consistency analysis

(a) PyTorch models

(b) CORnet-S vs. ResNet-50

Figure 4: (a) How is error consistency influenced by model architecture? PyTorch models tested on edge stimuli (160 trials per observer). (b) Recurrent CORnet-S behaves just like a standard feedforward ResNet-50 on cue conflict stimuli (1280 trials). Shaded areas indicate a simulated 95% percentile for consistency by chance.

In order to understand how object recognition is achieved in brains, a necessary—but not sufficient—pre-requisite are quantitative metrics to track improvements and models that improve on those metrics. [^46] went an important step in both directions by proposing Brain-Score, a benchmark where models can be ranked according to a number of metrics, for instance how well their activations predict how biological neurons fire when primates see the same images as an ImageNet-trained CNN. Using this benchmark, the authors tested hundreds of architectures to develop CORnet-S, a brain-inspired recurrent neural network. CORnet-S is able to capture recurrent dynamics (so-called object solution times) of monkey behaviour and achieves previously unmatched performance on Brain-Score while retaining good ImageNet performance (73.1% top-1). These results, in the author’s words, “establish CORnet-S, a compact, recurrent ANN, as the current best model of the primate ventral visual stream” performing “brain-like object recognition” [^46]. Building such a model is an exciting undertaking and, as perhaps indicated by the highly competitive selection as an “Oral” contribution to NeurIPS 2019, an endeavour that sparked considerable excitement at the intersection of the neuroscience and machine learning communities. But how much is behavioural consistency improved in comparison to a baseline model (ResNet-50)? This is exactly the type of question that can be answered with the help of our error consistency analysis.

Figure 4 shows that CORnet-S shares only slightly above-chance error consistency with most human observers—even the highest CORnet-S-to-human error consistency is lower than the lowest human-to-human error consistency. However, there is no improvement whatsoever over a ResNet-50 baseline: Cohen’s $\kappa$ for CNN-human consistency is very low for both models (.068: ResNet-50;.066: CORnet-S) compared to.331 for human-human consistency. Perhaps worse still, AlexNet from 2012 has higher error consistency than CORnet-S (.080). CNN-CNN consistency between CORnet-S and ResNet-50 is exceptionally high (.711), many datapoints even overlap exactly—a pattern confirmed by additional experiments in the appendix (Figures SF.5, SF.6 and SF.7), where we also perform a more detailed comparison to all six Brain-Score metrics (Figures SF.9, SF.10, SF.11 and SF.12 showing, if at all, only a weak relationship between error consistency and Brain-Score metrics). This indicates that CORnet-S is likely implementing a very different strategy than the human brain: in our analysis, CORnet-S has more behavioural similarities with a standard feedforward ResNet-50 than with human object recognition.<sup>13</sup> This provides evidence that recurrent computations—often argued to be one of the key missing ingredients in standard CNNs towards a better account of biological vision [^52] [^53] [^46] [^54] [^55] [^56] —do not necessarily lead to different behaviour compared to a purely feedforward CNN. It is still an open question to determine the conditions under which recurrence provides advantages over feedforward networks. Recent evidence seems to indicate that recurrence may be especially useful for difficult images [^57] [^58] [^59].

Overall, the observed discrepancy between the leading score of CORnet-S on Brain-Score and its similarity to a standard ResNet-50 according to error consistency analysis points to the decisive importance of metrics: CORnet-S was mainly built for neural predictivity and while it scores very well on a number of other benchmarks, such as capturing object solution times and even a previously reported behavioural error analysis [^26], it performs poorly on the behavioural metric reported here, *trial-by-trial error consistency*. New metrics to scrutinise models will hopefully lead to an improved generation of models, which in turn might inspire ever-more challenging analyses. An ideal model of biological object recognition would score well on multiple metrics (both neural and behavioural data, an important idea behind Brain-Score), including on metrics that the model was not directly optimised for.

## 4 Conclusion

Error consistency is a quantitative analysis for comparing strategies/methods of black-box decision makers—be they brains or algorithms. Accuracy alone is insufficient for distinguishing between strategies: two decision makers may achieve similar accuracy with very different strategies. In contrast to aggregated metrics (averaging across trials/stimuli and observers/networks), error consistency measures behavioural errors on a fine-grained level following the idea of “molecular psychophysics” [^18]. Using error consistency we find:

- Irrespective of architecture, CNNs are remarkably consistent with one another
- The consistency between humans and CNNs, however, is little beyond what can be expected by chance alone, indicating that CNNs still employ very different perceptual mechanisms and “brain-like machine learning” may be still but a distant dream (cf. [^60])
- Recurrent CORnet-S, termed the “current best model of the primate ventral visual stream”, fails to capture essential characteristics of human behavioural data and instead behaves effectively like a standard feedforward ResNet-50 in our analysis.

Taken together, error consistency analysis suggests that the strategies used by human and machine vision are still very different—but we envision that error consistency will be a useful analysis in the quest to understand complex systems, be they CNNs or the human mind and brain.

## Broader Impact

*Error consistency* is a statistical analysis for measuring whether two or more decision makers make similar errors. Like any statistical analysis, it can be used for better or worse. For instance, as a very simple example, calculating the *mean* of a number of observations can be used to quantify a world-wide temperature increase caused by human carbon emissions [^61] [^62] (positive impact). However, calculating the mean could just as well be utilised by authoritarian governments to obtain an aggregated credit score of “social”—i.e., conformist—behaviour (negative impact) [^63]. Concerning error consistency, we could envisage the following broader impact.

##### Potential positive impact.

Quantifying differences between decision making strategies can contribute to a better understanding of algorithmic decisions. This improves model interpretability, which is a scientific goal by itself but also closely linked to societal requirements like accountability of algorithmic decision making and the “right to explanation” in the European Union [^64]. Furthermore, calculating the error consistency between humans and CNNs can be used for fact-checking overly hyped “human-like AI” statements, e.g. by startups. We argue that human-level accuracy does not imply human-like decision making, which might contribute to increased rigour in model evaluation.

##### Potential negative impact.

While not intended to cause any harm, quantifying differences between individuals can be used to identify group-conform and outlier behaviour. Furthermore, measuring error consistency between machines and humans might be used to quantify progress towards building machines that mimic human decision making on certain tasks. While this might sound exciting to a scientist, it very likely sounds a lot more frightening from the perspective of someone losing their job because a machine would then be capable of doing the same work more cheaply. Depending on the complexity of the task, this may not be a problem in the near future but, given current trends in the use of machine learning for automation, perhaps in the distant future.

#### Acknowledgments & funding disclosure

Funding was provided, in part, by the Deutsche Forschungsgemeinschaft (DFG, German Research Foundation) – project number 276693517 – SFB 1233, TP 4 Causal inference strategies in human vision (K.M. and F.A.W.). The authors thank the International Max Planck Research School for Intelligent Systems (IMPRS-IS) for supporting R.G; and the German Research Foundation through the Cluster of Excellence “Machine Learning—New Perspectives for Science”, EXC 2064/1, project number 390727645, for supporting F.A.W. The authors declare no competing interests.

We would like to thank Silke Gramer and Leila Masri for administrative and Uli Wannek for technical support; and David-Elias Künstle, Bernhard Lang, Maximus Mutschler as well as Uli Wannek for helpful comments. We thank [^46] for making their implementation of CORnet-S publicly available. Furthermore, we would like to thank Jonas Kubilius and Martin Schrimpf for feedback and many valuable suggestions.

#### Author contributions

Based on ideas from [^65] and [^28], R.G. first applied trial-by-trial analysis ideas to CNNs. Thereafter, all three authors jointly initiated the project. R.G. and K.M. jointly led the project. K.M. derived the bounds, performed and visualised the simulations and acquired the Brain-Score data (with input from R.G.). The CNN experiments were performed, analysed and visualised by R.G. (with input from K.M.). F.A.W. provided guidance, feedback, and pointed out the link to molecular psychophysics. All three authors planned and structured the manuscript. R.G. and K.M. wrote the paper with active input from F.A.W.

## References

## Appendix Supplementary Material

Code and data to reproduce results and figures are available from [https://github.com/wichmann-lab/error-consistency](https://github.com/wichmann-lab/error-consistency).

The supplementary material is structured as follows. We start with terminology in Section S.1, afterwards we derive bounds of $c_{obs}$ and kappa in Section S.2 (limiting possible consistency), followed by a description of how we simulated the confidence intervals for $c_{exp}$ and kappa under the null hypothesis of independent observers in Section S.3. Finally, we provide method details for Brain-Score and the evaluated CNNs in Section S.5 and report accuracies across experiments in Table 1.

In addition to method details, we provide extended experimental results in Figure SF.3 (error consistency of all PyTorch models for cue conflict and edge stimuli) as well as Figures SF.5, SF.6, SF.7, SF.8 (detailed analyses of CORnet-S vs. ResNet-50). Figures SF.9, SF.10 and SF.11 and SF.12 (investigating the relationship between Brain-Score metrics and error consistency).

Furthermore, Figure SF.4 visualises qualitative error differences by plotting which stimuli were particularly easy for humans and CNNs, respectively.

### S.1 Terminology: “error consistency”

We would like to briefly clarify the name error consistency. Our analysis helps to compare the consistency of two decision makers. Two decision makers necessarily show some degree of consistency due to chance agreement. Error consistency helps to examine whether the two decision makers show significantly more consistency than expected by chance by analysing behavioural error patterns. However, this analysis takes into account not only the consistency of errors but also the consistency of correctly answered trials, hence ‘error consistency’ may sound imprecise at first. Nonetheless, we believe that the term captures the most crucial aspect of this analysis: Humans and CNNs —which are particularly well suited for our analysis—are often close to ceiling performance or at least have high accuracies. Thus trials where the decision makers agree do not provide much evidence for distinguishing between processing strategies. In contrast, the (few) errors of the decision makers are the most informative trials in this respect: Hence the name error consistency.

### S.2 Derivation of bounds for cobsc\_{obs} and kappa given cexpc\_{exp}

How much observed consistency can we expect at most for a given expected consistency? We assume two independent observers $i$ and $j$ with accuracies $p_{i}$ and $p_{j}$. For given $p_{i},p_{j}$ only a certain range of $c_{obs}$ is possible:

$$
\displaystyle c_{obs_{max}}=1-|p_{i}-p_{j}|\text{~and~~}c_{obs_{min}}=|p_{j}+p_{i}-1|.
$$

Ideally, we also want to express the bounds of $c_{obs}$ directly as a function of $c_{exp}$. We obtain the following bounds:

$$
\displaystyle 0
$$
 
$$
\displaystyle\leq c_{obs_{i,j}}\leq 1-\sqrt{1-2c_{exp_{i,j}}}~~~~
$$
 
$$
\displaystyle if~~c_{exp_{i,j}}<0.5,
$$
$$
\displaystyle\sqrt{2c_{exp_{i,j}}-1}
$$
 
$$
\displaystyle\leq c_{obs_{i,j}}\leq 1~~~~
$$
 
$$
\displaystyle if~~c_{exp_{i,j}}\geq 0.5.
$$

These bounds are visualised in Figure 2.

The derivation is as follows. We distinguish between two cases.

##### Case 1:

$p_{i}\leq 0.5~\&~p_{j}\leq 0.5$ or $p_{i}\geq 0.5~\&~p_{j}\geq 0.5\Longleftrightarrow c_{exp_{i,j}}\geq 0.5$

The expected consistency then lies in the interval of $[0.5,1]$, see Figure SF.2. First we calculate the upper bound $b_{obs_{max}}$ given $c_{exp_{i,j}}$. Please note that a specific $c_{exp_{i,j}}$ can be obtained by multiple combinations of values for $p_{i}$ and $p_{j}$. For a given $c_{exp_{i,j}}$ we choose $p_{j}=p_{i}$. We can calculate the exact value of $p_{i}$ in this case with eq. (1). However since $p_{j}=p_{i}$ we get with eq. (7) that $b_{obs_{max}}=1$. Thus we directly obtain from eq. (7) that the upper bound of $c_{obs_{i,j}}$ is always 1 for all $c_{exp_{i,j}}$ in the interval \[0.5, 1\].

It is a bit more challenging to derive the lower bound $b_{obs_{min}}$ given $c_{exp_{i,j}}$. Using equation (7) and (1) we obtain

$$
\displaystyle b_{obs_{min}}
$$
 
$$
\displaystyle=p_{i}+\frac{c_{exp_{i,j}}+p_{i}-1}{2p_{i}-1}-1.
$$

Setting $\frac{\partial b_{obs_{min}}}{\partial p_{i}}=0$ to find the minimum results in

$$
\displaystyle p_{i_{min}}
$$
 
$$
\displaystyle=\frac{1}{2}\pm\sqrt{\frac{1}{4}-\frac{-2c_{exp_{i,j}}+2}{4}}.
$$

We only take the positive term in eq. (11) since $p_{i}>0.5$ by definition. Checking the second order derivative confirms a minimum. Finally using equation eq. (11) with eq. (10) we calculate

$$
\displaystyle b_{obs_{min}}
$$
 
$$
\displaystyle=\sqrt{2c_{exp_{i,j}}-1},\text{~thus}
$$
 
$$
\displaystyle\sqrt{2c_{exp_{i,j}}-1}
$$
 
$$
\displaystyle\leq c_{obs_{i,j}}\leq 1.
$$

##### Case 2:

$p_{i}>0.5~\&~p_{j}<0.5$ or $p_{i}<0.5~\&~p_{j}>0.5\Longleftrightarrow c_{exp_{i,j}}<0.5$

The expected consistency then lies in the interval of $[0,0.5[$, see Figure SF.2. This case is point symmetric to the right part. Thus we obtain for the bounds of the left part

$$
\displaystyle b_{{obs_{max}}_{2}}
$$
 
$$
\displaystyle=1-b_{obs_{min}}(1-c_{exp_{i,j}}),
$$
$$
\displaystyle b_{{obs_{min}}_{2}}
$$
 
$$
\displaystyle=0\text{~ and finally}
$$
 
$$
\displaystyle 0\leq c_{obs_{i,j}}
$$
 
$$
\displaystyle\leq 1-\sqrt{1-2c_{exp_{i,j}}}.
$$

##### Bounds for kappa

If we plug in the bounds of $c_{obs_{i,j}}$ into the equation of kappa, we obtain the following bounds for kappa:

$$
\displaystyle\frac{-c_{exp_{i,j}}}{1-c_{exp_{i,j}}}
$$
 
$$
\displaystyle\leq\kappa_{i,j}\leq\frac{1-\sqrt{1-2c_{exp_{i,j}}}-c_{exp_{i,j}}}{1-c_{exp_{i,j}}}~~~~
$$
 
$$
\displaystyle\text{if }c_{exp_{i,j}}<0.5,
$$
$$
\displaystyle\frac{\sqrt{2c_{exp_{i,j}}-1}-c_{exp_{i,j}}}{1-c_{exp_{i,j}}}
$$
 
$$
\displaystyle\leq\kappa_{i,j}\leq 1~~~~
$$
 
$$
\displaystyle\text{if }c_{exp_{i,j}}\geq 0.5.
$$

### S.3 Calculating 95% percentiles of observed overlap and kappa for the null hypothesis of independent observers given an expected consistency

Here we describe the procedure to calculate 95% percentiles of $\kappa$ and $c_{obs}$.

Our null hypothesis is that two decision makers are independent. Assuming independence, we can easily simulate these two observers. Based on $p_{i},p_{j}$ (the accuracies of decision makers $i$ and $j$) we sample $n$ trials and calculate $c_{exp_{i,j}},c_{obs_{i,j}},\text{and}\kappa_{i,j}$ accordingly based on these simulated values. This process is repeated systematically for different $p_{i}$ and $p_{j}$. For this purpose we sample a grid of 4200 x 4200 points in the range $[[0,1],[0,1]]$. For each individual combination of $p_{i}$ and $p_{j}$, the sampling is repeated five times, thus in total we simulate $4200\times 4200\times 5=88,200,000$ values.<sup>14</sup>

The grid is not divided equally. 66% of $p_{i}$ and $p_{j}$ are located in the upper and lower 15% of the domain. This is important because kappa diverges for large values of $c_{exp}$ (small and large values of $p_{i}$ and $p_{j}$); thus a dense sampling is necessary there.

Based on these simulated data we obtain 95% percentiles for $c_{obs}$ and $\kappa$. We binned the data in 1% steps and used the standard quantile-function of R (type 7, see [^66]). It is important to note that we have only a small number of trials (160 or 1280).<sup>15</sup> Therefore $c_{obs}$ can take a maximum number of 161 or 1281 values respectively. The range of uniquely observed values is very small for a given $c_{exp}$. This implies that the accuracy of our percentiles is limited for data points that are very close to the quantiles. However, this does not influence our findings.

Please note that the denominator of kappa gets very small for high values of $c_{exp}$. Thus we see some instability of kappa towards high expected consistencies. Figure SF.1 shows diagnostic plots for both cases.

![Refer to caption](https://ar5iv.labs.arxiv.org/html/2006.16736/assets/figures/DiagnosticPlotsKappa/DiagnosticPlotSimulateCobsKappa_160.png)

Figure SF.1: Simulated data of c e x p, o b s c\_{exp},c\_{obs} and κ \\kappa for 160 (top) and 1280 (bottom) trials per block. Black dots show 100.000 randomly drawn blocks from our simulation. Blue lines show analytical bounds. Red lines show the 95% percentiles. Orange dashed lines show the wrong binomial confidence interval (left) and the erroneous confidence interval for (right) reported in many papers.

### S.4 Disentangling of Error consistency and Accuracy

Our argument for the disentanglement between kappa and accuracy is as follows. For independent observer no correlation between accuracy and kappa is observed, e.g. In Figure 2b, $\kappa$ and $c_{exp}$ <sup>16</sup> are not correlated (r=-0.00015, p > 0.05). As expressed by the bounds in Figure 2, $\kappa$ is limited by accuracy. If two observers have an accuracy for 90%, only certain levels of (dis-)agreement are possible. Error consistency (measured by $\kappa$) aims to correct for accuracy and thus in our experiments different kinds of correlations between error consistency and overall accuracy occur. We observe zero correlation in (Figures 3a, 3b) and positive correlation in Figure 3c. In Figure 3d we observe a negative correlation between accuracy and error consistency. We conclude that there is no correlation between consistency ($\kappa$) and accuracy for independent observers whilst for dependent (consistent) observers correlations are possible. Kappa corrects for accuracy but is not independent from it.

### S.5 Method details for Brain-Score and CNNs

Human responses were compared against classification decisions of all available CNN models from the PyTorch model zoo (for torchvision version 0.2.2) [^67], namely alexnet, vgg11-bn, vgg13-bn, vgg16-bn, vgg19-bn, squeezenet1-0, squeezenet1-1, densenet121, densenet169, densenet201, inception-v3, resnet18, resnet34, resnet50, resnet101, resnet152. For the VGG model family [^68], we used the implementation with batch norm. CORnet-S, an additional recurrent model [^46] analysed in Section 3.2, was obtained from the author’s github implementation.<sup>17</sup> The comparison to Brain-Score in Figures SF.9, SF.10, SF.11 and SF.12 uses Brain-Score values obtained from the [Brain-Score website](http://www.brain-score.org/) (date of download: April 17, 2020) and error consistency values obtained by us. Note that the model implementations differ slightly: we consistently used PyTorch models whereas Brain-Score tested models from a few different frameworks (the full list can be seen [here](https://github.com/brain-score/candidate_models/blob/745f9d1bc747e936cbdef1e7fc599b16cf9dc677/candidate_models/base_models/__init__.py#L350)). Namely, squeezenet1-0, squeezenet1-1, resnet18, resnet-34 are identical (PyTorch); the VGG models use Keras instead (without batch norm) and so do the Brain-Score DenseNet models; inception\_v3, resnet50\_v1, resnet101\_v1, resnet152\_v1 are TFSlim models. Since model implementations usually differ slightly across frameworks, a small variation in the results can be expected depending on the chosen model and framework.

### S.6 Error consistency of shape-biased models

We analyzed three CNNs with different degrees of stylized training data from [^11]. Model shape bias predicts human-CNN error consistency for cue conflict stimuli, indicating that networks basing their decisions on object shape (rather than texture) make more human-like errors:

| model shape bias (%) | 20.5 | 21.4 | 34.7 | 81.4 |
| --- | --- | --- | --- | --- |
| human-CNN consistency ($\kappa$) | .066 | .068 | .098 | .195 |

|  | observer / model | cue conflict | edge | silhouette |
| --- | --- | --- | --- | --- |
| 1 | subject-01 | 0.69 | 0.89 | 0.80 |
| 2 | subject-02 | 0.76 | 0.94 | 0.66 |
| 3 | subject-03 | 0.84 | 0.93 | 0.80 |
| 4 | subject-04 | 0.62 | 0.84 | 0.78 |
| 5 | subject-05 | 0.85 | 0.89 | 0.77 |
| 6 | subject-06 | 0.82 | 0.93 | 0.72 |
| 7 | subject-07 | 0.76 | 0.81 | 0.76 |
| 8 | subject-08 | 0.78 | 0.96 | 0.64 |
| 9 | subject-09 | 0.86 | 0.61 | 0.76 |
| 10 | subject-10 | 0.77 | 0.92 | 0.85 |
| 11 | alexnet | 0.19 | 0.29 | 0.43 |
| 12 | vgg11-bn | 0.12 | 0.14 | 0.46 |
| 13 | vgg13-bn | 0.12 | 0.25 | 0.36 |
| 14 | vgg16-bn | 0.14 | 0.22 | 0.47 |
| 15 | vgg19-bn | 0.15 | 0.28 | 0.46 |
| 16 | squeezenet1-0 | 0.14 | 0.15 | 0.24 |
| 17 | squeezenet1-1 | 0.17 | 0.14 | 0.29 |
| 18 | densenet121 | 0.19 | 0.24 | 0.42 |
| 19 | densenet169 | 0.21 | 0.33 | 0.53 |
| 20 | densenet201 | 0.21 | 0.38 | 0.51 |
| 21 | inception-v3 | 0.27 | 0.28 | 0.54 |
| 22 | resnet18 | 0.19 | 0.20 | 0.47 |
| 23 | resnet34 | 0.19 | 0.16 | 0.45 |
| 24 | resnet50 | 0.18 | 0.14 | 0.54 |
| 25 | resnet101 | 0.20 | 0.24 | 0.49 |
| 26 | resnet152 | 0.21 | 0.21 | 0.56 |
| 27 | cornet-s | 0.18 | 0.25 | 0.46 |

Table 1: Accuracies for human observers and CNNs for all three experiments. In the cue conflict experiment case, an answer is counted as correct in this table if this answer corresponds to the correct shape category (other choices are possible).

![Refer to caption](https://ar5iv.labs.arxiv.org/html/2006.16736/assets/figures/DiagnosticPlotsKappa/CexpDensity.png)

Figure SF.2: Values that c e x p c\_{exp} can take depending on i p\_{i} and j p\_{j} for two independent observers.

(a) Cue conflict stimuli

(b) Edge stimuli

Figure SF.3: Error consistencs vs. expected error overlap for all PyTorch models.

![Refer to caption](https://ar5iv.labs.arxiv.org/html/2006.16736/assets/figures/cue_conflict/combined-cue-conflict.png)

(a) Cue conflict stimuli

![Refer to caption](https://ar5iv.labs.arxiv.org/html/2006.16736/assets/texture-shape_cue-conflict_shape-bias_cornet_S-crop.png)

Figure SF.5: Shape bias of CORnet-S and ResNet-50 in comparison to human observers. Human observers categorise objects by shape rather than texture 11, which differentiates them from standard ImageNet-trained CNNs like ResNet-50 (categorising predominantly by texture). In this experiment, CORnet-S again behaves similarly to ResNet-50 but does not show a human-like shape bias as would be expected for an accurate model of human object recognition. Small bar plots on the right indicate accuracy (answer corresponds to either correct texture category or correct shape category). This pattern was also observed by 69, who performed a detailed investigation of the factors that influence model shape bias.

(a) Edge stimuli

(b) Silhouette stimuli

Figure SF.6: Error consistency of CORnet-S vs. ResNet-50 for edge and silhouette stimuli.

(a) Uniform noise

(b) Contrast

(c) High-pass

(d) Low-pass

(e) Eidolon I

(f) Eidolon II

(g) Eidolon III

(h) Phase noise

Figure SF.7: Classification accuracy on parametrically distorted images for ResNet-50, CORnet-S and human observers. Again, CORnet-S behaves like a ResNet-50 rather than like human observers.

![Refer to caption](https://ar5iv.labs.arxiv.org/html/2006.16736/assets/texture-shape_cue-conflict_confusion_human-average-crop.png)

Human average

Figure SF.9: Error consistency vs. Brain-Score metrics for PyTorch models, “cue conflict” stimuli.

Figure SF.10: Error consistency vs. Brain-Score metrics for PyTorch models, “edge” stimuli.

Figure SF.11: Error consistency vs. Brain-Score metrics for PyTorch models, “silhouette” stimuli.

Figure SF.12: Error consistency vs. Brain-Score metrics for PyTorch models, “ImageNet” stimuli.

[^1]: T. P. Lillicrap and K. P. Kording. What does it mean to understand a neural network? *arXiv preprint arXiv:1907.06374*, 2019.

[^2]: C. Szegedy, W. Zaremba, I. Sutskever, J. Bruna, D. Erhan, I. Goodfellow, and R. Fergus. Intriguing properties of neural networks. *arXiv preprint arXiv:1312.6199*, 2013.

[^3]: A. Ilyas, S. Santurkar, D. Tsipras, L. Engstrom, B. Tran, and A. Madry. Adversarial examples are not bugs, they are features. In *Advances in Neural Information Processing Systems*, pages 125–136, 2019.

[^4]: R. Geirhos, J.-H. Jacobsen, C. Michaelis, R. Zemel, W. Brendel, M. Bethge, and F. A. Wichmann. Shortcut learning in deep neural networks. *Nature Machine Intelligence*, in press, 2020a.

[^5]: R. Mausfeld. No Psychology In - No Psychology Out. *Psychologische Rundschau*, 54(3):185–191, 2003.

[^6]: M. D. Zeiler and R. Fergus. Visualizing and understanding convolutional networks. In *European conference on computer vision*, pages 818–833. Springer, 2014.

[^7]: L. M. Zintgraf, T. S. Cohen, T. Adel, and M. Welling. Visualizing deep neural network decisions: Prediction difference analysis. *arXiv preprint arXiv:1702.04595*, 2017.

[^8]: C. Olah, N. Cammarata, L. Schubert, G. Goh, M. Petrov, and S. Carter. Zoom in: An introduction to circuits. *Distill*, 5(3):e00024–001, 2020.

[^9]: W. Nie, Y. Zhang, and A. Patel. A theoretical explanation for perplexing behaviors of backpropagation-based visualizations. *arXiv preprint arXiv:1805.07039*, 2018.

[^10]: J. Adebayo, J. Gilmer, M. Muelly, I. Goodfellow, M. Hardt, and B. Kim. Sanity checks for saliency maps. In *Advances in Neural Information Processing Systems*, pages 9505–9515, 2018.

[^11]: R. Geirhos, P. Rubisch, C. Michaelis, M. Bethge, Felix A. Wichmann, and W. Brendel. ImageNet-trained CNNs are biased towards texture; increasing shape bias improves accuracy and robustness. In *International Conference on Learning Representations*, 2019.

[^12]: D. Marr. *Vision: A computational investigation into the human representation and processing of visual information*. W.H.Freeman & Co Ltd, San Francisco, 1982.

[^13]: Hans Reichenbach. *The direction of time*. Univ of California Press, 1956.

[^14]: D. Castelvecchi. Can we open the black box of AI? *Nature News*, 538:20–23, 2016.

[^15]: R. Shwartz-Ziv and N. Tishby. Opening the black box of deep neural networks via information. *arXiv preprint arXiv:1703.00810*, 2017.

[^16]: T. C. Kietzmann, P. McClure, and N. Kriegeskorte. Deep neural networks in computational neuroscience. *BioRxiv*, 2018.

[^17]: Robert Geirhos, Kantharaju Narayanappa, Benjamin Mitzkus, Matthias Bethge, Felix A. Wichmann, and Wieland Brendel. On the surprising similarities between supervised and self-supervised models. *arXiv preprint arXiv:2010.08377*, 2020b.

[^18]: D. M. Green. Consistency of auditory detection judgments. *Psychological Review*, 71(5):392–407, 1964.

[^19]: M. Ghodrati, A. Farzmahdi, K. Rajaei, R. Ebrahimpour, and S.-M. Khaligh-Razavi. Feedforward object-vision models only tolerate small image variations compared to human. *Frontiers in Computational Neuroscience*, 8:74, 2014.

[^20]: R. Rajalingham, K. Schmidt, and J. J. DiCarlo. Comparison of object recognition behavior in human and monkey. *Journal of Neuroscience*, 35(35):12127–12136, 2015.

[^21]: S. R. Kheradpisheh, M. Ghodrati, M. Ganjtabesh, and T. Masquelier. Deep networks can resemble human feed-forward vision in invariant object recognition. *Scientific Reports*, 6:32672, 2016a.

[^22]: S. R. Kheradpisheh, M. Ghodrati, M. Ganjtabesh, and T. Masquelier. Humans and deep networks largely agree on which kinds of variation make object recognition harder. *Frontiers in Computational Neuroscience*, 10:92, 2016b.

[^23]: R. Geirhos, D. H.J. Janssen, H. H. Schütt, J. Rauber, M. Bethge, and F. A Wichmann. Comparing deep neural networks against humans: object recognition when the signal gets weaker. *arXiv preprint arXiv:1706.06969*, 2017.

[^24]: W. J. Ma and B. Peters. A neural network walks into a lab: towards using deep nets as models for human behavior. *arXiv preprint arXiv:2005.02181*, 2020.

[^25]: J. Kubilius, S. Bracci, and H. P. Op de Beeck. Deep neural networks as a computational model for human shape sensitivity. *PLoS Computational Biology*, 12(4):e1004896, 2016.

[^26]: R. Rajalingham, E. B. Issa, P. Bashivan, K. Kar, K. Schmidt, and J. J. DiCarlo. Large-scale, high-resolution comparison of the core visual object recognition behavior of humans, monkeys, and state-of-the-art deep artificial neural networks. *Journal of Neuroscience*, 38(33):7255–7269, 2018.

[^27]: Horia Mania, John Miller, Ludwig Schmidt, Moritz Hardt, and Benjamin Recht. Model similarity mitigates test set overuse. In *Advances in Neural Information Processing Systems*, pages 9993–10002, 2019.

[^28]: K. Meding, D. Janzing, B. Schölkopf, and F. A. Wichmann. Perceiving the arrow of time in autoregressive motion. In *Advances in Neural Information Processing Systems*, pages 2303–2314, 2019.

[^29]: J. Cohen. A coefficient of agreement for nominal scales. *Educational and psychological measurement*, 20(1):37–46, 1960.

[^30]: I. Fründ, F. A. Wichmann, and J. H. Macke. Quantifying the effect of intertrial dependence on perceptual decisions. *Journal of Vision*, 14(7), 2014.

[^31]: F. A. Wichmann and N. J. Hill. The psychometric function: I. Fitting, sampling, and goodness of fit. *Perception & Psychophysics*, 63(8):1293–1313, 2001.

[^32]: R.J. Hunt. Percent agreement, pearson’s correlation, and kappa as measures of inter-examiner reliability. *Journal of Dental Research*, 65(2):128–130, 1986.

[^33]: PF Watson and A Petrie. Method agreement analysis: a review of correct methodology. *Theriogenology*, 73(9):1167–1179, 2010.

[^34]: J. L. Fleiss, J. Cohen, and B. S. Everitt. Large sample standard errors of kappa and weighted kappa. *Psychological Bulletin*, 72(5):323–327, 1969.

[^35]: W. D. Hudson and C. W. Ramm. Correct formulation of the kappa coefficient of agreement. *Photogrammetric engineering and remote sensing*, 53(4):421–422, 1987.

[^36]: M. L. McHugh. Interrater reliability: the kappa statistic. *Biochemia medica: Biochemia medica*, 22(3):276–282, 2012.

[^37]: M. Bland. *An introduction to medical statistics*. Oxford University Press (UK), 2015.

[^38]: J. L. Fleiss, B. Levin, and M. C. Paik. *Statistical methods for rates and proportions*. J. Wiley, Hoboken, N.J, 3rd ed edition, 2003. ISBN 978-0-471-52629-2.

[^39]: U. N. Umesh, R. A. Peterson, and M. H. Sauber. Interjudge agreement and the maximum value of kappa. *Educational and Psychological Measurement*, 49(4):835–850, 1989.

[^40]: Olga Russakovsky, Jia Deng, Hao Su, Jonathan Krause, Sanjeev Satheesh, Sean Ma, Zhiheng Huang, Andrej Karpathy, Aditya Khosla, Michael Bernstein, et al. ImageNet large scale visual recognition challenge. *International Journal of Computer Vision*, 115(3):211–252, 2015.

[^41]: Nicole C Rust and J Anthony Movshon. In praise of artifice. *Nature Neuroscience*, 8(12):1647–1650, 2005.

[^42]: Marina Martinez-Garcia, Marcelo Bertalmío, and Jesús Malo. In praise of artifice reloaded: caution with natural image databases in modeling vision. *Frontiers in Neuroscience*, 13:8, 2019.

[^43]: L. A. Gatys, A. S. Ecker, and M. Bethge. Image style transfer using convolutional neural networks. In *Proceedings of the IEEE Conference on Computer Vision and Pattern Recognition*, pages 2414–2423, 2016.

[^44]: R. Geirhos, C. R. M. Temme, J. Rauber, H. H. Schütt, M. Bethge, and F. A. Wichmann. Generalisation in humans and deep neural networks. In *Advances in Neural Information Processing Systems*, pages 7538–7550, 2018.

[^45]: G. A. Miller. WordNet: a lexical database for English. *Communications of the ACM*, 38(11):39–41, 1995.

[^46]: J. Kubilius, M. Schrimpf, K. Kar, R. Rajalingham, H. Hong, N. Majaj, E. Issa, P. Bashivan, J. Prescott-Roy, K. Schmidt, et al. Brain-like object recognition with high-performing shallow recurrent ANNs. In *Advances in Neural Information Processing Systems*, pages 12785–12796, 2019.

[^47]: S. Kornblith, J. Shlens, and Q. V. Le. Do better imagenet models transfer better? In *Proceedings of the IEEE conference on computer vision and pattern recognition*, pages 2661–2671, 2019.

[^48]: D. L. K. Yamins, H. Hong, C. F. Cadieu, E. A. Solomon, D. Seibert, and J. J. DiCarlo. Performance-optimized hierarchical models predict neural responses in higher visual cortex. *Proceedings of the National Academy of Sciences*, 111(23):8619–8624, 2014.

[^49]: Katherine R Storrs, Tim C Kietzmann, Alexander Walther, Johannes Mehrer, and Nikolaus Kriegeskorte. Diverse deep neural networks all predict human it well, after training and fitting. *bioRxiv*, 2020.

[^50]: Arash Akbarinia and Karl R Gegenfurtner. Paradox in deep neural networks: Similar yet different while different yet similar. *arXiv preprint arXiv:1903.04772*, 2019.

[^51]: Johannes Mehrer, Courtney J Spoerer, Nikolaus Kriegeskorte, and Tim C Kietzmann. Individual differences among deep neural network models. *bioRxiv*, 2020.

[^52]: N. Kriegeskorte. Deep neural networks: a new framework for modeling biological vision and brain information processing. *Annual review of vision science*, 1:417–446, 2015.

[^53]: C. J. Spoerer, P. McClure, and N. Kriegeskorte. Recurrent convolutional neural networks: a better model of biological object recognition. *Frontiers in psychology*, 8:1551, 2017.

[^54]: T. C. Kietzmann, C. J. Spoerer, L. K. A. Sörensen, R. M. Cichy, O. Hauk, and N. Kriegeskorte. Recurrence is required to capture the representational dynamics of the human visual system. *Proceedings of the National Academy of Sciences*, 116(43):21854–21863, 2019.

[^55]: T. Serre. Deep learning: the good, the bad, and the ugly. *Annual Review of Vision Science*, 5:399–426, 2019.

[^56]: R. S. van Bergen and N. Kriegeskorte. Going in circles is the way forward: the role of recurrence in visual inference. *arXiv preprint arXiv:2003.12128*, 2020.

[^57]: D. Linsley, J. Kim, V. Veerabadran, C. Windolf, and T. Serre. Learning long-range spatial dependencies with horizontal gated recurrent units. In *Advances in Neural Information Processing Systems*, pages 152–164, 2018.

[^58]: H. Tang, M. Schrimpf, W. Lotter, C. Moerman, A. Paredes, J. O. Caro, W. Hardesty, D. Cox, and G. Kreiman. Recurrent computations for visual pattern completion. *Proceedings of the National Academy of Sciences*, 115(35):8835–8840, 2018.

[^59]: K. Kar, J. Kubilius, K. Schmidt, E. B. Issa, and J. J. DiCarlo. Evidence that recurrent circuits are critical to the ventral stream’s execution of core object recognition behavior. *Nature Neuroscience*, 22(6):974–983, 2019.

[^60]: B. M. Lake, T. D. Ullman, J. B. Tenenbaum, and S. J. Gershman. Building machines that learn and think like people. *Behavioral and Brain Sciences*, 40, 2017.

[^61]: G. Hagedorn, P. Kalmus, M. Mann, S. Vicca, J. Van den Berge, J.-P. van Ypersele, D. Bourg, J. Rotmans, R. Kaaronen, S. Rahmstorf, et al. Concerns of young protesters are justified. *Science*, 364:139–140, 2019a.

[^62]: G. Hagedorn, T. Loew, S. I. Seneviratne, W. Lucht, M.-L. Beck, J. Hesse, R. Knutti, V. Quaschning, J.-H. Schleimer, L. Mattauch, et al. The concerns of the young protesters are justified: A statement by scientists for future concerning the protests for more climate protection. *GAIA-Ecological Perspectives for Science and Society*, 28(2):79–87, 2019b.

[^63]: R. Creemers. China’s social credit system: an evolving practice of control. *Available at SSRN 3175792*, 2018.

[^64]: A. D. Selbst and J. Powles. Meaningful information and the right to explanation. *International Data Privacy Law*, 7(4):233–242, 2017.

[^65]: Vinzenz H. Schönfelder and Felix A. Wichmann. Identification of stimulus cues in narrow-band tone-in-noise detection using sparse observer models. *The Journal of the Acoustical Society of America*, 134(1):447–463, 2013.

[^66]: R. J. Hyndman and Y. Fan. Sample quantiles in statistical packages. *The American Statistician*, 50(4):361–365, 1996.

[^67]: A. Paszke, S. Gross, F. Massa, A. Lerer, J. Bradbury, G. Chanan, T. Killeen, Z. Lin, N. Gimelshein, L. Antiga, A. Desmaison, A. Kopf, E. Yang, Z. DeVito, M. Raison, A. Tejani, S. Chilamkurthy, B. Steiner, L. Fang, J. Bai, and S. Chintala. Pytorch: An imperative style, high-performance deep learning library. In *Advances in Neural Information Processing Systems 32*, pages 8024–8035. Curran Associates, Inc., 2019.

[^68]: K. Simonyan and A. Zisserman. Very deep convolutional networks for large-scale image recognition. arXiv preprint arXiv:1409.1556, 2015.

[^69]: Katherine L Hermann and Simon Kornblith. Exploring the origins and prevalence of texture bias in convolutional neural networks. *arXiv preprint arXiv:1911.09071*, 2019.