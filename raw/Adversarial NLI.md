## **Adversarial NLI: A New Benchmark for Natural Language Understanding** 

**Yixin Nie** _[∗]_ **, Adina Williams** _[†]_ **, Emily Dinan** _[†]_ **, Mohit Bansal** _[∗]_ **, Jason Weston** _[†]_ **, Douwe Kiela** _[†] ∗_ UNC Chapel Hill 

> _†_ Facebook AI Research 

## **Abstract** 

We introduce a new large-scale NLI benchmark dataset, collected via an iterative, adversarial human-and-model-in-the-loop procedure. We show that training models on this new dataset leads to state-of-the-art performance on a variety of popular NLI benchmarks, while posing a more difficult challenge with its new test set. Our analysis sheds light on the shortcomings of current state-of-theart models, and shows that non-expert annotators are successful at finding their weaknesses. The data collection method can be applied in a never-ending learning scenario, becoming a moving target for NLU, rather than a static benchmark that will quickly saturate. 

## **1 Introduction** 

Progress in AI has been driven by, among other things, the development of challenging large-scale benchmarks like ImageNet (Russakovsky et al., 2015) in computer vision, and SNLI (Bowman et al., 2015), SQuAD (Rajpurkar et al., 2016), and others in natural language processing (NLP). Recently, for natural language understanding (NLU) in particular, the focus has shifted to combined benchmarks like SentEval (Conneau and Kiela, 2018) and GLUE (Wang et al., 2018), which track model performance on multiple tasks and provide a unified platform for analysis. 

With the rapid pace of advancement in AI, however, NLU benchmarks struggle to keep up with model improvement. Whereas it took around 15 years to achieve “near-human performance” on MNIST (LeCun et al., 1998; Cires¸an et al., 2012; Wan et al., 2013) and approximately 7 years to surpass humans on ImageNet (Deng et al., 2009; Russakovsky et al., 2015; He et al., 2016), the GLUE benchmark did not last as long as we would have hoped after the advent of BERT (Devlin et al., 

2018), and rapidly had to be extended into SuperGLUE (Wang et al., 2019). This raises an important question: Can we collect a large benchmark dataset that can last longer? 

The speed with which benchmarks become obsolete raises another important question: are current NLU models genuinely as good as their high performance on benchmarks suggests? A growing body of evidence shows that state-of-the-art models learn to exploit spurious statistical patterns in datasets (Gururangan et al., 2018; Poliak et al., 2018; Tsuchiya, 2018; Glockner et al., 2018; Geva et al., 2019; McCoy et al., 2019), instead of learning _meaning_ in the flexible and generalizable way that humans do. Given this, human annotators—be they seasoned NLP researchers or non-experts— might easily be able to construct examples that expose model brittleness. 

We propose an iterative, adversarial human-andmodel-in-the-loop solution for NLU dataset collection that addresses both benchmark longevity and robustness issues. In the first stage, human annotators devise examples that our current best models cannot determine the correct label for. These resulting hard examples—which should expose additional model weaknesses—can be added to the training set and used to train a stronger model. We then subject the strengthened model to the same procedure and collect weaknesses over several rounds. After each round, we train a new model and set aside a new test set. The process can be iteratively repeated in a never-ending learning (Mitchell et al., 2018) setting, with the model getting stronger and the test set getting harder in each new round. Thus, not only is the resultant dataset harder than existing benchmarks, but this process also yields a “moving post” dynamic target for NLU systems, rather than a static benchmark that will eventually saturate. 

Our approach draws inspiration from recent ef- 

**==> picture [432 x 171] intentionally omitted <==**

**----- Start of picture text -----**<br>
Collection Phase Training Phase<br>Target Label Context Train<br>Writer<br>Dev<br>Test<br>Hypothesis<br>Prediction<br>Compare<br>Model correct Step 1: Write examples<br>Model wrong Step 2: Get model feedback<br>Verifier Step 3: Verify examples and make splits<br>Disagree Agree Step 4: Retrain model for next round<br>F<br>e<br>e<br>d<br>b<br>a<br>c<br>k<br>**----- End of picture text -----**<br>


Figure 1: Adversarial NLI data collection via human-and-model-in-the-loop enabled training (HAMLET). The four steps make up one round of data collection. In step 3, model-correct examples are included in the training set; development and test sets are constructed solely from model-wrong verified-correct examples. 

forts that gamify collaborative training of machine learning agents over multiple rounds (Yang et al., 2017) and pit “builders” against “breakers” to learn better models (Ettinger et al., 2017). Recently, Dinan et al. (2019) showed that such an approach can be used to make dialogue safety classifiers more robust. Here, we focus on natural language inference (NLI), arguably the most canonical task in NLU. We collected three rounds of data, and call our new dataset Adversarial NLI (ANLI). 

Our contributions are as follows: 1) We introduce a novel human-and-model-in-the-loop dataset, consisting of three rounds that progressively increase in difficulty and complexity, that includes annotator-provided explanations. 2) We show that training models on this new dataset leads to state-of-the-art performance on a variety of popular NLI benchmarks. 3) We provide a detailed analysis of the collected data that sheds light on the shortcomings of current models, categorizes the data by inference type to examine weaknesses, and demonstrates good performance on NLI stress tests. The ANLI dataset is available at github.com/facebookresearch/anli/. A demo is available at adversarialnli.com. 

## **2 Dataset collection** 

The primary aim of this work is to create a new large-scale NLI benchmark on which current stateof-the-art models fail. This constitutes a new target for the field to work towards, and can elucidate model capabilities and limitations. As noted, however, static benchmarks do not last very long these days. If continuously deployed, the data collection 

procedure we introduce here can pose a dynamic challenge that allows for never-ending learning. 

## **2.1 HAMLET** 

To paraphrase the great bard (Shakespeare, 1603), _there is something rotten in the state of the art_ . We propose _Human-And-Model-in-the-Loop Enabled Training_ (HAMLET), a training procedure to automatically mitigate problems with current dataset collection procedures (see Figure 1). 

In our setup, our starting point is a _base model_ , trained on NLI data. Rather than employing automated adversarial methods, here the model’s “adversary” is a human annotator. Given a _context_ (also often called a “premise” in NLI), and a desired _target label_ , we ask the human _writer_ to provide a _hypothesis_ that fools the model into misclassifying the label. One can think of the writer as a “white hat” hacker, trying to identify vulnerabilities in the system. For each human-generated example that is misclassified, we also ask the writer to provide a _reason_ why they believe it was misclassified. 

For examples that the model misclassified, it is necessary to verify that they are actually correct —i.e., that the given context-hypothesis pairs genuinely have their specified target label. The best way to do this is to have them checked by another human. Hence, we provide the example to human _verifiers_ . If two human verifiers agree with the writer, the example is considered a good example. If they disagree, we ask a third human verifier to break the tie. If there is still disagreement between the writer and the verifiers, the example is discarded. If the verifiers disagree, they can over- 

|**Context**|**Hypothesis**|**Hypothesis**|||**Reason**|**Round**|orig.|**Labels**<br>pred.|valid.|**Annotations**|**Annotations**|
|---|---|---|---|---|---|---|---|---|---|---|---|
|Roberto Javier Mora Garc´ıa (c.<br>1962 – 16|Another||individual||The context states that Roberto|A1|E|N|E E|Lexical (assassina-||
|March 2004) was a Mexican journalist and ed-|laid waste to Roberto||||Javier Mora Garcia was assassi-|(Wiki)||||tion,<br>laid|waste),|
|itorial director of “El Ma˜nana”, a newspaper|Javier Mora||Garcia.||nated, so another person had to|||||Tricky (Presupposi-||
|based in Nuevo Laredo, Tamaulipas, Mexico.|||||have “laid waste to him.” The sys-|||||tion), Standard (Id-||
|He worked for a number of media outlets in|||||tem most likely had a hard time fg-|||||iom)||
|Mexico, including the “El Norte” and “El Di-|||||uring this out due to it not recogniz-|||||||
|ario de Monterrey”, prior to his assassination.|||||ing the phrase “laid waste.”|||||||
|A melee weapon is any weapon used in direct|Melee|weapons||are|Melee weapons are good for hand|A2|C|E|C N C|Standard|(Con-|
|hand-to-hand combat; by contrast with ranged|good for ranged|||and|to hand combat, but NOT ranged.|(Wiki)||||junction),|Tricky|
|weapons which act at a distance.<br>The term|hand-to-hand combat.|||||||||(Exhaustifcation),||
|“melee” originates in the 1640s from the French||||||||||Reasoning|(Facts)|
|word “m˘el´ee”, which refers to hand-to-hand||||||||||||
|combat, a close quarters battle, a brawl, a con-||||||||||||
|fused fght, etc. Melee weapons can be broadly||||||||||||
|divided into three categories||||||||||||
|If you can dream it, you can achieve it—unless|The<br>crowd||believed||Because the crowd was chanting|A3|E|N|E E|Reasoning|(Facts),|
|you’re a goose trying to play a very human game|they knew the name of||||its name, the crowd must have be-|(News)||||Reference|(Coref-|
|of rugby. In the video above, one bold bird took|the goose running|||on|lieved they knew the goose’s name.|||||erence)||
|a chance when it ran onto a rugby feld mid-play.|the feld.||||The word “believe” may have made|||||||
|Things got dicey when it got into a tussle with|||||the system think this was an am-|||||||
|another player, but it shook it off and kept right|||||biguous statement.|||||||
|on running. After the play ended, the players||||||||||||
|escorted the feisty goose off the pitch. It was||||||||||||
|a risky move, but the crowd chanting its name||||||||||||
|was well worth it.||||||||||||



Table 1: Examples from development set. ‘A _n_ ’ refers to round number, ‘orig.’ is the original annotator’s gold label, ‘pred.’ is the model prediction, ‘valid.’ are the validator labels, ‘reason’ was provided by the original annotator, ‘Annotations’ are the tags determined by an linguist expert annotator. 

rule the original target label of the writer. 

Once data collection for the current round is finished, we construct a new training set from the collected data, with accompanying development and test sets, which are constructed solely from verified correct examples. The test set was further restricted so as to: 1) include pairs from “exclusive” annotators who are never included in the training data; and 2) be balanced by label classes (and genres, where applicable). We subsequently train a _new model_ on this and other existing data, and repeat the procedure. 

## **2.2 Annotation details** 

We employed Mechanical Turk workers with qualifications and collected hypotheses via the ParlAI[1] framework. Annotators are presented with a context and a target label—either ‘entailment’, ‘contradiction’, or ‘neutral’—and asked to write a hypothesis that corresponds to the label. We phrase the label classes as “definitely correct”, “definitely incorrect”, or “neither definitely correct nor definitely incorrect” given the context, to make the task easier to grasp. Model predictions are obtained for the context and submitted hypothesis pair. The probability of each label is shown to the worker as feedback. If the model prediction was incorrect, the job is complete. If not, the worker continues to write hypotheses for the given (context, targetlabel) pair until the model predicts the label incor- 

1https://parl.ai/ 

rectly or the number of tries exceeds a threshold (5 tries in the first round, 10 tries thereafter). 

To encourage workers, payments increased as rounds became harder. For hypotheses that the model predicted incorrectly, and that were verified by other humans, we paid an additional bonus on top of the standard rate. 

## **2.3 Round 1** 

For the first round, we used a BERT-Large model (Devlin et al., 2018) trained on a concatenation of SNLI (Bowman et al., 2015) and MNLI (Williams et al., 2017), and selected the best-performing model we could train as the starting point for our dataset collection procedure. For Round 1 contexts, we randomly sampled short multi-sentence passages from Wikipedia (of 250-600 characters) from the manually curated HotpotQA training set (Yang et al., 2018). Contexts are either ground-truth contexts from that dataset, or they are Wikipedia passages retrieved using TF-IDF (Chen et al., 2017) based on a HotpotQA question. 

## **2.4 Round 2** 

For the second round, we used a more powerful RoBERTa model (Liu et al., 2019b) trained on SNLI, MNLI, an NLI-version[2] of FEVER (Thorne et al., 2018), and the training data from the previous round (A1). After a hyperparameter search, we 

2The NLI version of FEVER pairs claims with evidence retrieved by Nie et al. (2019) as (context, hypothesis) inputs. 

|**Dataset**|**Genre**|**Context**|**Train / Dev / Test**|**Model error rate**|**Model error rate**|**Tries**|**Time (sec.)**|
|---|---|---|---|---|---|---|---|
|||||Unverifed|Verifed|mean/median|per verifed ex.|
|A1|Wiki|2,080|16,946 / 1,000 / 1,000|29.68%|18.33%|3.4 / 2.0|199.2 / 125.2|
|A2|Wiki|2,694|45,460 / 1,000 / 1,000|16.59%|8.07%|6.4 / 4.0|355.3 / 189.1|
|A3|Various<br>(Wiki subset)|6,002<br>1,000|100,459 / 1,200 / 1,200<br>19,920 / 200 / 200|17.47%<br>14.79%|8.60%<br>6.92%|6.4 / 4.0<br>7.4 / 5.0|284.0 / 157.0<br>337.3 / 189.6|
|ANLI|Various|10,776|162,865 / 3,200 / 3,200|18.54%|9.52%|5.7 / 3.0|282.9 / 156.3|



Table 2: Dataset statistics: ‘Model error rate’ is the percentage of examples that the model got wrong; ‘unverified’ is the overall percentage, while ‘verified’ is the percentage that was verified by at least 2 human annotators. 

selected the model with the best performance on the A1 development set. Then, using the hyperparameters selected from this search, we created a final set of models by training several models with different random seeds. During annotation, we constructed an ensemble by randomly picking a model from the model set as the adversary each turn. This helps us avoid annotators exploiting vulnerabilities in one single model. A new non-overlapping set of contexts was again constructed from Wikipedia via HotpotQA using the same method as Round 1. 

## **2.5 Round 3** 

For the third round, we selected a more diverse set of contexts, in order to explore robustness under domain transfer. In addition to contexts from Wikipedia for Round 3, we also included contexts from the following domains: News (extracted from Common Crawl), fiction (extracted from StoryCloze (Mostafazadeh et al., 2016) and CBT (Hill et al., 2015)), formal spoken text (excerpted from court and presidential debate transcripts in the Manually Annotated Sub-Corpus (MASC) of the Open American National Corpus[3] ), and causal or procedural text, which describes sequences of events or actions, extracted from WikiHow. Finally, we also collected annotations using the longer contexts present in the GLUE RTE training data, which came from the RTE5 dataset (Bentivogli et al., 2009). We trained an even stronger RoBERTa ensemble by adding the training set from the second round (A2) to the training data. 

## **2.6 Comparing with other datasets** 

The ANLI dataset, comprising three rounds, improves upon previous work in several ways. First, and most obviously, the dataset is collected to be more difficult than previous datasets, by design. Second, it remedies a problem with SNLI, 

3anc.org/data/masc/corpus/ 

namely that its contexts (or premises) are very short, because they were selected from the image captioning domain. We believe longer contexts should naturally lead to harder examples, and so we constructed ANLI contexts from longer, multisentence source material. 

Following previous observations that models might exploit spurious biases in NLI hypotheses, (Gururangan et al., 2018; Poliak et al., 2018), we conduct a study of the performance of hypothesisonly models on our dataset. We show that such models perform poorly on our test sets. 

With respect to data generation with na¨ıve annotators, Geva et al. (2019) noted that models can pick up on annotator bias, modelling annotator artefacts rather than the intended reasoning phenomenon. To counter this, we selected a subset of annotators (i.e., the “exclusive” workers) whose data would only be included in the test set. This enables us to avoid overfitting to the writing style biases of particular annotators, and also to determine how much individual annotator bias is present for the main portion of the data. Examples from each round of dataset collection are provided in Table 1. 

Furthermore, our dataset poses new challenges to the community that were less relevant for previous work, such as: can we improve performance online without having to train a new model from scratch every round, how can we overcome catastrophic forgetting, how do we deal with mixed model biases, etc. Because the training set includes examples that the model got right but were not verified, learning from noisy and potentially unverified data becomes an additional interesting challenge. 

## **3 Dataset statistics** 

The dataset statistics can be found in Table 2. The number of examples we collected increases per round, starting with approximately 19k examples for Round 1, to around 47k examples for Round 2, 

|**Model**<br>**Training Data**<br>A1<br>A2<br>A3<br>ANLI<br>ANLI-E|SNLI<br>MNLI-m/-mm|
|---|---|
|||
|BERT<br>S,M_⋆_1<br>00.0<br>28.9<br>28.8<br>19.8<br>19.9<br>+A1<br>44.2<br>32.6<br>29.3<br>35.0<br>34.2<br>+A1+A2<br>57.3<br>45.2<br>33.4<br>44.6<br>43.2<br>+A1+A2+A3<br>57.2<br>49.0<br>46.1<br>50.5<br>46.3<br>S,M,F,ANLI<br>57.4<br>48.3<br>43.5<br>49.3<br>44.2|91.3<br>86.7 / 86.4<br>91.3<br>86.3 / 86.5<br>90.9<br>86.3 / 86.3<br>90.9<br>85.6 / 85.4<br>90.4<br>86.0 / 85.8|
|||
|XLNet<br>S,M,F,ANLI<br>67.6<br>50.7<br>48.3<br>55.1<br>52.0|91.8<br>89.6 / 89.4|
|||
|RoBERTa<br>S,M<br>47.6<br>25.4<br>22.1<br>31.1<br>31.4<br>+F<br>54.0<br>24.2<br>22.4<br>32.8<br>33.7<br>+F+A1_⋆_2<br>68.7<br>19.3<br>22.0<br>35.8<br>36.8<br>+F+A1+A2_⋆_3<br>71.2<br>44.3<br>20.4<br>43.7<br>41.4<br>S,M,F,ANLI<br>73.8<br>48.9<br>44.4<br>53.7<br>49.7|92.6<br>90.8 / 90.6<br>92.7<br>90.6 / 90.5<br>92.8<br>90.9 / 90.7<br>92.9<br>91.0 / 90.7<br>92.6<br>91.0 / 90.6|



Table 3: Model Performance. ‘S’ refers to SNLI, ‘M’ to MNLI dev (-m=matched, -mm=mismatched), and ‘F’ to FEVER; ‘A1–A3’ refer to the rounds respectively and ‘ANLI’ refers to A1+A2+A3, ‘-E’ refers to test set examples written by annotators exclusive to the test set. Datasets marked ‘ _[⋆n]_ ’ were used to train the base model for round _n_ , and their performance on that round is underlined (A2 and A3 used ensembles, and hence have non-zero scores). 

to over 103k examples for Round 3. We collected more data for later rounds not only because that data is likely to be more interesting, but also simply because the base model is better and so annotation took longer to collect good, verified correct examples of model vulnerabilities. 

For each round, we report the model error rate, both on verified and unverified examples. The unverified model error rate captures the percentage of examples where the model disagreed with the writer’s target label, but where we are not (yet) sure if the example is correct. The verified model error rate is the percentage of model errors from example pairs that other annotators confirmed the correct label for. Note that error rate is a useful way to evaluate model quality: the lower the model error rate—assuming constant annotator quality and context-difficulty—the better the model. 

We observe that model error rates decrease as we progress through rounds. In Round 3, where we included a more diverse range of contexts from various domains, the overall error rate went slightly up compared to the preceding round, but for Wikipedia contexts the error rate decreased substantially. While for the first round roughly 1 in every 5 examples were verified model errors, this quickly dropped over consecutive rounds, and the overall model error rate is less than 1 in 10. On the one hand, this is impressive, and shows how far we have come with just three rounds. On the other hand, it shows that we still have a long way to go if even untrained annotators can fool ensembles of state-of-the-art models with relative ease. 

Table 2 also reports the average number of “tries”, i.e., attempts made for each context until a model error was found (or the number of possible 

tries is exceeded), and the average time this took (in seconds). Again, these metrics are useful for evaluating model quality: observe that the average number of tries and average time per verified error both go up with later rounds. This demonstrates that the rounds are getting increasingly more difficult. Further dataset statistics and inter-annotator agreement are reported in Appendix C. 

## **4 Results** 

Table 3 reports the main results. In addition to BERT (Devlin et al., 2018) and RoBERTa (Liu et al., 2019b), we also include XLNet (Yang et al., 2019) as an example of a strong, but different, model architecture. We show test set performance on the ANLI test sets per round, the total ANLI test set, and the exclusive test subset (examples from test-set-exclusive workers). We also show accuracy on the SNLI test set and the MNLI development set (for the purpose of comparing between different model configurations across table rows). In what follows, we discuss our observations. 

**Base model performance is low.** Notice that the base model for each round performs very poorly on that round’s test set. This is the expected outcome: For round 1, the base model gets the entire test set wrong, by design. For rounds 2 and 3, we used an ensemble, so performance is not necessarily zero. However, as it turns out, performance still falls well below chance[4] , indicating that workers did not find vulnerabilities specific to a single model, but generally applicable ones for that model class. 

4Chance is at 33%, since the test set labels are balanced. 

**==> picture [205 x 154] intentionally omitted <==**

**----- Start of picture text -----**<br>
80 Training Data<br>A1<br>70 A1 [D] [1] +A2 [D] [1]<br>A1 [D] [2] +A2 [D] [2] +A3 [D] [2]<br>60<br>50<br>40<br>30<br>20<br>10<br>0<br>S M MM A1 A2 A3<br>Evaluation Set<br>Accuracy<br>**----- End of picture text -----**<br>


Figure 2: RoBERTa performance on dev, with A1– 3 downsampled s.t. _|_ A1 _[D]_[1] _|_ = _|_ A2 _[D]_[1] _|_ =[1] 2 _[|]_[A1] _[|]_[and] _|_ A1 _[D]_[2] _|_ = _|_ A2 _[D]_[2] _|_ = _|_ A3 _[D]_[2] _|_ = 3[1] _[|]_[A1] _[|]_[.] 

**Rounds become increasingly more difficult.** As already foreshadowed by the dataset statistics, round 3 is more difficult (yields lower performance) than round 2, and round 2 is more difficult than round 1. This is true for all model architectures. 

**==> picture [206 x 154] intentionally omitted <==**

**----- Start of picture text -----**<br>
60<br>50<br>40<br>30<br>20<br>Training Data<br>10 Verified<br>Verified+Unverified<br>Unverified<br>0<br>A1 A2 A3<br>Evaluation Set<br>Accuracy<br>**----- End of picture text -----**<br>


Figure 3: Comparison of verified, unverified and combined data, where data sets are downsampled to ensure equal training sizes. 

**Continuously augmenting training data does not downgrade performance.** Even though ANLI training data is different from SNLI and MNLI, adding it to the training set does not harm performance on those tasks. Our results (see also rows 2-3 of Table 6) suggest the method could successfully be applied for multiple additional rounds. 

**Training on more rounds improves robustness.** 

Generally, our results indicate that training on more rounds improves model performance. This is true for all model architectures. Simply training on more “normal NLI” data would not help a model be robust to adversarial attacks, but our data actively helps mitigate these. 

**RoBERTa achieves state-of-the-art performance...** We obtain state of the art performance on both SNLI and MNLI with the RoBERTa model finetuned on our new data. The RoBERTa paper (Liu et al., 2019b) reports a score of 90 _._ 2 for both MNLI-matched and -mismatched dev, while we obtain 91 _._ 0 and 90 _._ 7. The state of the art on SNLI is currently held by MT-DNN (Liu et al., 2019a), which reports 91 _._ 6 compared to our 92 _._ 9. 

**...but is outperformed when it is base model.** However, the base (RoBERTa) models for rounds 2 and 3 are outperformed by both BERT and XLNet (rows 5, 6 and 10). This shows that annotators found examples that RoBERTa generally struggles with, which cannot be mitigated by more examples alone. It also implies that BERT, XLNet, and RoBERTa all have different weaknesses, possibly as a function of their training data (BERT, XLNet and RoBERTa were trained on different data sets, which might or might not have contained information relevant to the weaknesses). 

**Exclusive test subset difference is small.** We included an exclusive test subset (ANLI-E) with examples from annotators never seen in training, and find negligible differences, indicating that our models do not over-rely on annotator’s writing styles. 

## **4.1 The effectiveness of adversarial training** 

We examine the effectiveness of the adversarial training data in two ways. First, we sample from respective datasets to ensure exactly equal amounts of training data. Table 5 shows that the adversarial data improves performance, including on SNLI and MNLI when we replace part of those datasets with the adversarial data. This suggests that the adversarial data is more data efficient than “normally collected” data. Figure 2 shows that adversarial data collected in later rounds is of higher quality 

Second, we compared verified correct examples of model vulnerabilities (examples that the model got wrong and were verified to be correct) to unverified ones. Figure 3 shows that the verified correct examples are much more valuable than the unverified examples, especially in the later rounds (where the latter drops to random). 

## **4.2 Stress Test Results** 

We also test models on two recent hard NLI test sets: SNLI-Hard (Gururangan et al., 2018) and 

|**Model**<br>**SNLI-Hard**|**NLI Stress Tests**<br>AT (m/mm)<br>NR<br>LN (m/mm)<br>NG (m/mm)<br>WO (m/mm)<br>SE (m/mm)|
|---|---|
|Previous models<br>72.7|14.4 / 10.2<br>28.8<br>58.7 / 59.4<br>48.8 / 46.6<br>50.0 / 50.2<br>58.3 / 59.4|
|BERT (All)<br>82.3<br>XLNet (All)<br>83.5<br>RoBERTa (S+M+F)<br>84.5<br>RoBERTa (All)<br>84.7|75.0 / 72.9<br>65.8<br>84.2 / 84.6<br>64.9 / 64.4<br>61.6 / 60.6<br>78.3 / 78.3<br>88.2 / 87.1<br>85.4<br>87.5 / 87.5<br>59.9 / 60.0<br>68.7 / 66.1<br>84.3 / 84.4<br>81.6 / 77.2<br>62.1<br>88.0 / 88.5<br>61.9 / 61.9<br>67.9 / 66.2<br>86.2 / 86.5<br>85.9 / 82.1<br>80.6<br>88.4 / 88.5<br>62.2 / 61.9<br>67.4 / 65.6<br>86.3 / 86.7|



Table 4: Model Performance on NLI stress tests (tuned on their respective dev. sets). All=S+M+F+ANLI. AT=‘Antonym’; ‘NR’=Numerical Reasoning; ‘LN’=Length; ‘NG’=Negation; ‘WO’=Word Overlap; ‘SE’=Spell Error. Previous models refers to the Naik et al. (2018) implementation of Conneau et al. (2017, InferSent) for the Stress Tests, and to the Gururangan et al. (2018) implementation of Gong et al. (2018, DIIN) for SNLI-Hard. 

|**Training Data**|A1|A2|A3|S|M-m/mm|
|---|---|---|---|---|---|
|SM_D_1+SM_D_2|45.1|26.1|27.1|**92.5**|89.8/**89.7**|
|SM_D_1+A|**72.6**|**42.9**|**42.0**|92.3|**90.3**/89.6|
|SM|48.0|24.8|31.1|93.2|90.8/90.6|
|SM_D_3+A|**73.3**|**42.4**|**40.5**|**93.3**|**90.8**/**90.7**|



Table 5: RoBERTa performance on dev set with different training data. S=SNLI, M=MNLI, A=A1+A2+A3. ‘SM’ refers to combined S and M training set. D1, D2, D3 means down-sampling SM s.t. _|_ SM _[D]_[2] _|_ = _|_ A _|_ and _|_ SM _[D]_[3] _|_ + _|_ A _|_ = _|_ SM _|_ . Therefore, training sizes are identical in every pair of rows. 

|**Training Data**|A1|A2|A3|S|M-m/mm|
|---|---|---|---|---|---|
|ALL|73.8|48.9|44.4|92.6|91.0/90.6|
|S+M|47.6|25.4|22.1|92.6|90.8/90.6|
|ANLI-Only|71.3|43.3|43.0|83.5|86.3/86.5|
|ALL_H_|49.7|46.3|42.8|71.4|60.2/59.8|
|S+M_H_|33.1|29.4|32.2|71.8|62.0/62.0|
|ANLI-Only_H_|51.0|42.6|41.5|47.0|51.9/54.5|



Table 6: Performance of RoBERTa with different data combinations. ALL=S,M,F,ANLI. Hypothesisonly models are marked _H_ where they are trained and tested with only hypothesis texts. 

the NLI stress tests (Naik et al., 2018) (see Appendix A for details). The results are in Table 4. We observe that all our models outperform the models presented in original papers for these common stress tests. The RoBERTa models perform best on SNLI-Hard and achieve accuracy levels in the high 80s on the ‘antonym’ (AT), ‘numerical reasoning’ (NR), ‘length’ (LN), ‘spelling error’(SE) sub-datasets, and show marked improvement on both ‘negation’ (NG), and ‘word overlap’ (WO). Training on ANLI appears to be particularly useful for the AT, NR, NG and WO stress tests. 

## **4.3 Hypothesis-only results** 

For SNLI and MNLI, concerns have been raised about the propensity of models to pick up on spurious artifacts that are present just in the hypotheses (Gururangan et al., 2018; Poliak et al., 2018). Here, we compare full models to models trained only on the hypothesis (marked _H_ ). Table 6 reports results on ANLI, as well as on SNLI and MNLI. The table shows that hypothesis-only models perform poorly on ANLI[5] , and obtain good performance on SNLI and MNLI. Hypothesis-only performance 

> 5Obviously, without manual intervention, some bias remains in how people phrase hypotheses—e.g., contradiction might have more negation—which explains why hypothesisonly performs slightly above chance when trained on ANLI. 

decreases over rounds for ANLI. 

We observe that in rounds 2 and 3, RoBERTa is not much better than hypothesis-only. This could mean two things: either the test data is very difficult, or the training data is not good. To rule out the latter, we trained only on ANLI ( _∼_ 163k training examples): RoBERTa matches BERT when trained on the much larger, fully in-domain SNLI+MNLI combined dataset (943k training examples) on MNLI, with both getting _∼_ 86 (the third row in Table 6). Hence, this shows that the test sets are so difficult that state-of-the-art models cannot outperform a hypothesis-only prior. 

## **5 Linguistic analysis** 

We explore the types of inferences that fooled models by manually annotating 500 examples from each round’s development set. A dynamically evolving dataset offers the unique opportunity to track how model error rates change over time. Since each round’s development set contains only verified examples, we can investigate two interesting questions: which types of inference do writers employ to fool the models, and are base models differentially sensitive to different types of reasoning? 

The results are summarized in Table 7. We devised an inference ontology containing six types of inference: Numerical & Quantitative (i.e., reason- 

|**Round**|Numerical & Quant.|Reference & Names|Standard|Lexical|Tricky|Reasoning & Facts|Quality|
|---|---|---|---|---|---|---|---|
|A1|38%|13%|18%|13%|22%|53%|4%|
|A2|32%|20%|21%|21%|20%|59%|3%|
|A3|10%|18%|27%|27%|27%|63%|3%|
|Average|27%|17%|22%|22%|23%|58%|3%|



Table 7: Analysis of 500 development set examples per round and on average. 

ing about cardinal and ordinal numbers, inferring dates and ages from numbers, etc.), Reference & Names (coreferences between pronouns and forms of proper names, knowing facts about name gender, etc.), Standard Inferences (conjunctions, negations, cause-and-effect, comparatives and superlatives etc.), Lexical Inference (inferences made possible by lexical information about synonyms, antonyms, etc.), Tricky Inferences (wordplay, linguistic strategies such as syntactic transformations/reorderings, or inferring writer intentions from contexts), and reasoning from outside knowledge or additional facts (e.g., “You can’t reach the sea directly from Rwanda”). The quality of annotations was also tracked; if a pair was ambiguous or a label debatable (from the expert annotator’s perspective), it was flagged. Quality issues were rare at 3-4% per round. Any one example can have multiple types, and every example had at least one tag. 

We observe that both round 1 and 2 writers rely heavily on numerical and quantitative reasoning in over 30% of the development set—the percentage in A2 (32%) dropped roughly 6% from A1 (38%)—while round 3 writers use numerical or quantitative reasoning for only 17%. The majority of numerical reasoning types were references to cardinal numbers that referred to dates and ages. Inferences predicated on references and names were present in about 10% of rounds 1 & 3 development sets, and reached a high of 20% in round 2, with coreference featuring prominently. Standard inference types increased in prevalence as the rounds increased, ranging from 18%–27%, as did ‘Lexical’ inferences (increasing from 13%–31%). The percentage of sentences relying on reasoning and outside facts remains roughly the same, in the mid50s, perhaps slightly increasing over the rounds. For round 3, we observe that the model used to collect it appears to be more susceptible to Standard, Lexical, and Tricky inference types. This finding is compatible with the idea that models trained on adversarial data perform better, since annotators seem to have been encouraged to devise more creative examples containing harder types of inference in 

order to stump them. Further analysis is provided in Appendix B. 

## **6 Related work** 

**Bias in datasets** Machine learning methods are well-known to pick up on spurious statistical patterns. For instance, in the first visual question answering dataset (Antol et al., 2015), biases like “2” being the correct answer to 39% of the questions starting with “how many” allowed learning algorithms to perform well while ignoring the visual modality altogether (Jabri et al., 2016; Goyal et al., 2017). In NLI, Gururangan et al. (2018), Poliak et al. (2018) and Tsuchiya (2018) showed that hypothesis-only baselines often perform far better than chance. NLI systems can often be broken merely by performing simple lexical substitutions (Glockner et al., 2018), and struggle with quantifiers (Geiger et al., 2018) and certain superficial syntactic properties (McCoy et al., 2019). 

In question answering, Kaushik and Lipton (2018) showed that question- and passage-only models can perform surprisingly well, while Jia and Liang (2017) added adversarially constructed sentences to passages to cause a drastic drop in performance. Many tasks do not actually require sophisticated linguistic reasoning, as shown by the surprisingly good performance of random encoders (Wieting and Kiela, 2019). Similar observations were made in machine translation (Belinkov and Bisk, 2017) and dialogue (Sankar et al., 2019). Machine learning also has a tendency to overfit on static targets, even if that does not happen deliberately (Recht et al., 2018). In short, the field is rife with dataset bias and papers trying to address this important problem. This work presents a potential solution: if such biases exist, they will allow humans to fool the models, resulting in valuable training examples until the bias is mitigated. 

**Dynamic datasets.** Bras et al. (2020) proposed AFLite, an approach for avoiding spurious biases through adversarial filtering, which is a modelin-the-loop approach that iteratively probes and improves models. Kaushik et al. (2019) offer a 

causal account of spurious patterns, and counterfactually augment NLI datasets by editing examples to break the model. That approach is human-inthe-loop, using humans to find problems with one single model. In this work, we employ both human and model-based strategies iteratively, in a form of human-and-model-in-the-loop training, to create completely _new_ examples, in a potentially never-ending loop (Mitchell et al., 2018). 

Human-and-model-in-the-loop training is not a new idea. Mechanical Turker Descent proposes a gamified environment for the collaborative training of grounded language learning agents over multiple rounds (Yang et al., 2017). The “Build it Break it Fix it” strategy in the security domain (Ruef et al., 2016) has been adapted to NLP (Ettinger et al., 2017) as well as dialogue safety (Dinan et al., 2019). The QApedia framework (Kratzwald and Feuerriegel, 2019) continuously refines and updates its content repository using humans in the loop, while human feedback loops have been used to improve image captioning systems (Ling and Fidler, 2017). Wallace et al. (2019) leverage trivia experts to create a model-driven adversarial question writing procedure and generate a small set of challenge questions that QA-models fail on. Relatedly, Lan et al. (2017) propose a method for continuously growing a dataset of paraphrases. 

There has been a flurry of work in constructing datasets with an adversarial component, such as Swag (Zellers et al., 2018) and HellaSwag (Zellers et al., 2019), CODAH (Chen et al., 2019), Adversarial SQuAD (Jia and Liang, 2017), Lambada (Paperno et al., 2016) and others. Our dataset is not to be confused with abductive NLI (Bhagavatula et al., 2019), which calls itself _α_ NLI, or ART. 

## **7 Discussion & Conclusion** 

In this work, we used a human-and-model-in-theloop training method to collect a new benchmark for natural language understanding. The benchmark is designed to be challenging to current stateof-the-art models. Annotators were employed to act as adversaries, and encouraged to find vulnerabilities that fool the model into misclassifying, but that another person would correctly classify. We found that non-expert annotators, in this gamified setting and with appropriate incentives, are remarkably creative at finding and exploiting weaknesses. We collected three rounds, and as the rounds progressed, the models became more robust and the test sets for each round became more 

difficult. Training on this new data yielded the state of the art on existing NLI benchmarks. 

The ANLI benchmark presents a new challenge to the community. It was carefully constructed to mitigate issues with previous datasets, and was designed from first principles to last longer. The dataset also presents many opportunities for further study. For instance, we collected annotatorprovided explanations for each example that the model got wrong. We provided inference labels for the development set, opening up possibilities for interesting more fine-grained studies of NLI model performance. While we verified the development and test examples, we did not verify the correctness of each training example, which means there is probably some room for improvement there. 

A concern might be that the static approach is probably cheaper, since dynamic adversarial data collection requires a verification step to ensure examples are correct. However, verifying examples is probably also a good idea in the static case, and adversarially collected examples can still prove useful even if they didn’t fool the model and weren’t verified. Moreover, annotators were better incentivized to do a good job in the adversarial setting. Our finding that adversarial data is more data-efficient corroborates this theory. Future work could explore a detailed cost and time trade-off between adversarial and static collection. 

It is important to note that our approach is modelagnostic. HAMLET was applied against an ensemble of models in rounds 2 and 3, and it would be straightforward to put more diverse ensembles in the loop to examine what happens when annotators are confronted with a wider variety of architectures. 

The proposed procedure can be extended to other classification tasks, as well as to ranking with hard negatives either generated (by adversarial models) or retrieved and verified by humans. It is less clear how the method can be applied in generative cases. 

Adversarial NLI is meant to be a challenge for measuring NLU progress, even for as yet undiscovered models and architectures. Luckily, if the benchmark does turn out to saturate quickly, we will always be able to collect a new round. 
