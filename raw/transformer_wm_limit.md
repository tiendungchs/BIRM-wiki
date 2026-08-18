# **Self-Attention Limits Working Memory Capacity of Transformer-Based Models** 

**Dongyu Gong** Yale University New Haven, CT 06510 `dongyu.gong@yale.edu` 

**Hantao Zhang** Yale University New Haven, CT 06510 `hantao.zhang@yale.edu` 

## **Abstract** 

Recent work on Transformer-based large language models (LLMs) has revealed striking limits in their working memory capacity, similar to what has been found in human behavioral studies. Specifically, these models’ performance drops significantly on _N_ -back tasks as _N_ increases. However, there is still a lack of mechanistic interpretability as to why this phenomenon would arise. Inspired by the executive attention theory from behavioral sciences, we hypothesize that the self-attention mechanism within Transformer-based models might be responsible for their working memory capacity limits. To test this hypothesis, we train vanilla decoder-only transformers to perform _N_ -back tasks and find that attention scores gradually aggregate to the _N_ -back positions over training, suggesting that the model masters the task by learning a strategy to pay attention to the relationship between the current position and the _N_ -back position. Critically, we find that the total entropy of the attention score matrix increases as _N_ increases, suggesting that the dispersion of attention scores might be the cause of the capacity limit observed in _N_ -back tasks. Our findings thus offer insights into the shared role of attention in both human and artificial intelligence. Moreover, the limitations of the self-attention mechanism revealed in the current study could inform future efforts to design more powerful model architectures with enhanced working memory capacity and cognitive capabilities. 

## **1 Introduction** 

In cognitive science, working memory is defined as the ability of humans to temporarily maintain and manipulate task-relevant information for flexible behaviors [1]. Recent advancements in Transformerbased LLMs have sparked interest in evaluating their cognitive abilities, including working memory capacity [9]. By designing multiple variants of _N_ -back tasks (Figure 1a) [11, 10] and employing different instructional strategies, it has been found that LLMs consistently perform worse as _N_ increases (Figure 1b), which is reminiscent of the capacity limit of human working memory [2, 15, 17]. 

However, due to the black-box nature of LLMs, we still lack mechanistic insights as to why the observed capacity limit would emerge, especially given the fact that the length of _N_ -back task sequences (e.g., 24 letters in [9]) is well within the context length of these models [16]. To answer this question, we were inspired by the executive attention theory [7, 5, 6] in human working memory research. The executive attention theory proposes that working memory requires executive attention to maintain access to information in the face of interference, suggesting that it is the scarcity of attentional resources [12, 14], but not memory storage itself, that is responsible for working memory capacity limits. In Transformer-based LLMs, the self-attention mechanism computes the importance of each element in the input sequence relative to other elements. While this approach allows the model to focus on relevant information, as _N_ increases in the _N_ -back task, it could be increasingly 

NeurIPS 2024 Workshop on Behavioral Machine Learning. 

**==> picture [223 x 10] intentionally omitted <==**

**----- Start of picture text -----**<br>
a b<br>**----- End of picture text -----**<br>


Figure 1: **(a)** : _N_ -back task schematic. Participants (humans or LLMs) are instructed to give a response (humans: press a button; LLMs: output " `m` ") when the current letter is matched with the letter _N_ step(s) ago, and withhold responses (humans: do nothing; LLMs: output " `-` ") if it’s a nonmatch. _N_ is fixed for a given task sequence, and here we put _{_ 1 _,_ 2 _,_ 3 _}_ -back in the same schematic for illustration purposes only. **(b)** : performance of GPT-3.5 and GPT-4 on this task, reproduced from results in [9]. Error bars represent _±_ 1 standard error of the mean. 

hard to maintain focus between distant positions. Therefore, we hypothesize that self-attention might be the cause of working memory capacity limits in Transformer-based models. 

In the current study, we train causal Transformers on _N_ -back tasks and observe that as _N_ increases, the model presents a decline in its prediction accuracy. We further find that the prediction accuracy at position _i_ is positively correlated with the attention score at position _i − N_ . Furthermore, the model’s performance is negatively correlated with the total entropy of the attention score matrix. Our findings suggest that model’s inability to aggregate most of its attention to the target position leads to the decline in its prediction accuracy as _N_ increases. 

## **2 Methods** 

**Dataset.** We use the same procedure described by Gong et al. [9] to generate a dataset of _N_ -back tasks consisting of task sequences and correct answers. Each task sequence contains 24 letters sampled from an alphabet commonly used in the behavioral literature (“ `bcdfghjklnpqrstvwxyz` "), and the correct answers always consist of 8 matches and 16 nonmatches, mimicking the setup in some human studies. For _N ∈{_ 1 _,_ 2 _,_ 3 _,_ 4 _,_ 5 _,_ 6 _}_ , we generate 800 sequences for training and 200 sequences for testing, while our analyses mostly focus on _N ∈{_ 1 _,_ 2 _,_ 3 _}_ to compare with previous studies. 

**Model.** We use vanilla Transformers in order to facilitate interpretability, as done in prior work aiming to better understand computations in Transformers in more controlled task settings [4, 13]. We mainly focus our analysis on a causal Transformer containing one decoder layer with only one attention head (Figure 6 in Appendix), although we also test a few architectural variants in the number of decoder layers (L) and number of attention heads per layer (H) for comparisons (see Section 3 for details). The decoder layer contains masked self-attention so that for each position in the sequence the model can only attend to the current and previous positions. We choose to omit multi-layer feedforward networks (FFNs) and layer normalization in the original Transformer model to examine the role of self-attention directly without interference from complex internal transformations introduced by FFNs and layer norms. The decoder layer is followed by an unembedding layer to project the decoder outputs to two logits (representing match and nonmatch) for each position. 

**Training and Evaluation.** We train 50 independent models for each _N_ . We choose to train each model for 10 epochs because empirically the model converges after around 10 epochs of training (see Figure 7 in Appendix for details). Cross-entropy loss is computed between the output logits and the correct answers at each position. 

2 

**3 Results** 

**==> picture [182 x 11] intentionally omitted <==**

**----- Start of picture text -----**<br>
a b<br>**----- End of picture text -----**<br>


Figure 2: **(a)** : _N_ -back task performance of Transformers with different number of decoder layers and attention heads per layer. **(b)** : for the 1-layer 1-head Transformer model, task performance drops logarithmically as _N_ increases. Error bars represent _±_ 1 standard error of the mean. 

**Model accuracy decreases as** _**N**_ **increases.** For L _∈{_ 1 _,_ 2 _}_ and H _∈{_ 1 _,_ 2 _,_ 4 _}_ , we train models on the _N_ -back task (Figures 2a) and find a significant decline in model performance as _N_ increases for the 1-layer 1-head model (Kruskal-Wallis test: H-statistic = 38.517, _p_ < .001, _ϵ_[2] = 0.248; see Table 1 in Appendix for post-hoc comparisons using Mann-Whitney U tests[1] ). To further confirm this pattern, we extend the task to _N_ = 6, and find a significant logarithmic decline in the test accuracy as _N_ increases (Figure 2b). For models with a larger L or H, most of them achieved over 95% accuracy on all _N_ -back tasks. However, they still present slight declines in test accuracy as _N_ increases, suggesting that the working memory capacity limit does exist in the nature of transformer models. 

**==> picture [385 x 129] intentionally omitted <==**

**----- Start of picture text -----**<br>
0 Epoch 1 1.0 0 Epoch 2 1.0 0 Epoch 3 1.0 0 Epoch 4 1.0 0 Epoch 5 1.0<br>2 2 2 2 2<br>4 0.8 4 0.8 4 0.8 4 0.8 4 0.8<br>6 6 6 6 6<br>108 0.6 108 0.6 108 0.6 108 0.6 108 0.6<br>12 12 12 12 12<br>14 0.4 14 0.4 14 0.4 14 0.4 14 0.4<br>16 16 16 16 16<br>1820 0.2 1820 0.2 1820 0.2 1820 0.2 1820 0.2<br>22 22 22 22 22<br>0.0 0.0 0.0 0.0 0.0<br>Position Index Position Index Position Index Position Index Position Index<br>0 Epoch 6 1.0 0 Epoch 7 1.0 0 Epoch 8 1.0 0 Epoch 9 1.0 0 Epoch 10 1.0<br>2 2 2 2 2<br>4 0.8 4 0.8 4 0.8 4 0.8 4 0.8<br>6 6 6 6 6<br>108 0.6 108 0.6 108 0.6 108 0.6 108 0.6<br>12 12 12 12 12<br>14 0.4 14 0.4 14 0.4 14 0.4 14 0.4<br>16 16 16 16 16<br>1820 0.2 1820 0.2 1820 0.2 1820 0.2 1820 0.2<br>22 22 22 22 22<br>0.0 0.0 0.0 0.0 0.0<br>Position Index Position Index Position Index Position Index Position Index<br>Position Index Position Index Position Index Position Index Position Index<br>0 2 4 6 8 10 12 14 16 18 20 22 0 2 4 6 8 10 12 14 16 18 20 22 0 2 4 6 8 10 12 14 16 18 20 22 0 2 4 6 8 10 12 14 16 18 20 22 0 2 4 6 8 10 12 14 16 18 20 22<br>Position Index Position Index Position Index Position Index Position Index<br>0 2 4 6 8 10 12 14 16 18 20 22 0 2 4 6 8 10 12 14 16 18 20 22 0 2 4 6 8 10 12 14 16 18 20 22 0 2 4 6 8 10 12 14 16 18 20 22 0 2 4 6 8 10 12 14 16 18 20 22<br>**----- End of picture text -----**<br>


Figure 3: the model learns to attend target locations over training epochs. Here we show attention maps of a 1-layer 1-head Transformer model trained on the 3-back task as an example. See Appendix for attention maps in the 1-back and 2-back tasks. 

**Attention scores during training reflect the trajectory of learning.** To investigate how the self-attention mechanism influences model performance, we visualize attention maps after each training epoch (Figures 3, 8 and 10). For each position, we also plot the trajectory of attention scores over training epochs (Figures 9, 11, and 12) to see with more granularity how the model learns to perform the task. Starting with almost uniformly distributed attention scores in each row, attention scores gradually aggregate to a line corresponding to the _N_ -back positions. For each position in the sequence, attention scores gradually aggregate to the _N_ -back position over training epochs and attention scores converge faster for positions earlier in sequence (Figures 9, 11, and 12). This shows that the Transformer model learns to master the N-back task by increasing the attention score between the current position and the _N_ -back position. 

> 1We use nonparametric Kruskal-Wallis and Mann-Whitney tests instead of _F_ and _t_ tests because the data do not conform to the assumptions of parametric tests (normality and homogeneity of the variance). 

3 

**==> picture [393 x 248] intentionally omitted <==**

**----- Start of picture text -----**<br>
a b c<br>d e f<br>Epoch Epoch Epoch<br>Position Position Position<br>**----- End of picture text -----**<br>


Figure 4: **(a)** - **(c)** : the relationship between test accuracy at position _i_ and the attention score at position _i − N_ for the 1-layer 1-head Transformer model. Different colors represent different training epochs each dot belongs to. **(d)** - **(f)** : the relationship between test accuracy at position _i_ and the attention score at position _i − N_ for the 1-layer 1-head Transformer model, but here different colors indicate different positions in the task sequence. 

**Attention score at position** _i−N_ **increases with test accuracy at position** _i_ **.** To further investigate the relationship between attention scores and test accuracy, we plot accuracy at position _i_ against the attention score at the position _i − N_ over training epochs ( _i ∈_ �1 _,_ 24�, _N ∈{_ 1 _,_ 2 _,_ 3 _}_ ). The accuracy at position _i_ is defined as the percentage of the model making a correct prediction at position _i_ . Over training epochs, we find that the attention score at position _i − N_ increases along with the accuracy at position _i_ (Figure 4a-c), and this is particularly observable for a large _N_ ( _N ≥_ 2). We reason that in order to produce an accurate prediction at position _i_ , the Transformer model needs to learn to put most attention on the _i − N_ position and reduce dispersion of attention to other positions. To better visualize dispersion of attention scores across positions, we use the same data in Figure 4a-c but assign colors to the dots according to which position each dot belongs to (Figure 4d-f). This reveals a clear pattern that attention scores get dispersed at later locations, suggesting that more interference is caused when there are more preceding positions. 

**Total entropy of attention scores increases as** _**N**_ **increases.** Building up from the results above, we take a step further to investigate the overall characteristic of attention scores as _N_ increases. To measure the dispersion of attention scores for each _N_ , we define the total entropy _HN_ of each attention score matrix _A ∈_ R[24] _[×]_[24] as: 

**==> picture [271 x 31] intentionally omitted <==**

where 

**==> picture [253 x 25] intentionally omitted <==**

The entropy _HN_ is well-defined as _{Ai,_ 1 _, Ai,_ 2 _, ..., Ai,i}_ gives a probability distribution with � _ij_ =1 _[A][i,j]_[= 1][ thanks to the Softmax function and causal masking.] 

4 

For the 1-layer 1-head model, we find that _HN_ increases as _N_ increases, leading to the decrease in test accuracy (Figure 5). We infer that as _N_ increases, it gets harder for the model to learn to attend to the _N_ -back letter and the model is less confident about which letter is important, leading to higher entropy and lower accuracy. The fact that large values of _N_ require more structured attention weights (small entropy) to generalize in the _N_ -back task is consistent with previous studies on representational learning theory [ **?** ]. 

## **4 Discussion** 

The current study provides important insights for the mechanistic interpretability of working memory capacity limits observed in Transformer-based LLMs [9]. The self-attention mechanism is critical for the model to achieve good performance in the _N_ -back task, but also limits its capacity on the other hand. This is analogous to the mechanism of selective attention in the human brain, which prioritizes relevant information and filter out the rest to ensure effective task performance, but also restricts our information processing by imposing neural and cognitive bottlenecks [3]. Future work should explore a more formal mathematical proof as to why capacity limits might naturally emerge in complex intelligent systems [8, 18]. 

Although it is still unclear how selective attention in the human brain works at the algorithmic level, we can possibly draw inspirations from how the brain trades off between the amount vs. precision of the information being processed and design better model architectures with enhanced working memory capacity, which could in-turn lead to more powerful model capabilities in reasoning and problem solving [ **? ?** ]. 

**==> picture [120 x 120] intentionally omitted <==**

**----- Start of picture text -----**<br>
N<br>28<br>1<br>2<br>26 3<br>24<br>0.84 0.86 0.88<br>Test Accuracy<br>Total Entropy<br>**----- End of picture text -----**<br>


Figure 5: _HN_ increases as the test accuracy decreases with larger _N_ . Error bars represent _±_ 1 standard error of the mean. 

Note that the current study focuses on a very simplified version of 

the Transformer model, so it is not straightforward to draw direct comparisons with pre-trained LLMs such as those evaluated by Gong et al. [9]. It is thus important for future research to investigate how the complexity of the model architecture and the number of learnable parameters in the model would influence task performance. In addition, varying the amount of training data and the specific hyperparameters used during training would also be crucial for understanding model behaviors in finer detail. 

5 

## **References** 

- [1] Alan Baddeley. Working memory. _Science_ , 255(5044):556–559, 1992. 

- [2] Nelson Cowan. The magical number 4 in short-term memory: A reconsideration of mental storage capacity. _Behavioral and brain sciences_ , 24(1):87–114, 2001. 

- [3] Robert Desimone, John Duncan, et al. Neural mechanisms of selective visual attention. _Annual review of neuroscience_ , 18(1):193–222, 1995. 

- [4] Nelson Elhage, Tristan Hume, Catherine Olsson, Nicholas Schiefer, Tom Henighan, Shauna Kravec, Zac Hatfield-Dodds, Robert Lasenby, Dawn Drain, Carol Chen, Roger Grosse, Sam McCandlish, Jared Kaplan, Dario Amodei, Martin Wattenberg, and Christopher Olah. Toy models of superposition, 2022. 

- [5] Randall W. Engle. Working memory capacity as executive attention. _Current Directions in Psychological Science_ , 11(1):19–23, 2002. 

- [6] Randall W. Engle and Michael J. Kane. Executive attention, working memory capacity, and a two-factor theory of cognitive control. _Psychology of Learning and Motivation_ , 44:145–199, 2003. 

- [7] Randall W. Engle, Michael J. Kane, and Stephen W. Tuholski. _Individual Differences in Working Memory Capacity and What They Tell Us About Controlled Attention, General Fluid Intelligence, and Functions of the Prefrontal Cortex_ , page 102–134. Cambridge University Press, 1999. 

- [8] Steven M Frankland, Taylor Webb, and Jonathan D Cohen. No coincidence, george: Capacitylimits as the curse of compositionality, 2021. 

- [9] Dongyu Gong, Xingchen Wan, and Dingmin Wang. Working memory capacity of chatgpt: An empirical study. In _Proceedings of the AAAI Conference on Artificial Intelligence_ , volume 38, pages 10048–10056, 2024. 

- [10] Michael J. Kane and Randall W. Engle. The role of prefrontal cortex in working-memory capacity, executive attention, and general fluid intelligence: An individual-differences perspective. _Psychonomic Bulletin & Review_ , 9(4):637–671, December 2002. 

- [11] Wayne K Kirchner. Age differences in short-term retention of rapidly changing information. _Journal of experimental psychology_ , 55(4):352, 1958. 

- [12] Peter Lennie. The cost of cortical computation. _Current Biology_ , 13(6):493–497, 2003. 

- [13] Yuxuan Li and James McClelland. Representations and computations in transformers that support generalization on structured tasks. _Transactions on Machine Learning Research_ , 2023. 

- [14] Grace W Lindsay. Attention in psychology, neuroscience, and machine learning. _Frontiers in computational neuroscience_ , 14:516985, 2020. 

- [15] Klaus Oberauer, Simon Farrell, Christopher Jarrold, and Stephan Lewandowsky. What limits working memory capacity? _Psychological Bulletin_ , 142(7):758–799, July 2016. 

- [16] Saurav Pawar, SM Tonmoy, SM Zaman, Vinija Jain, Aman Chadha, and Amitava Das. The what, why, and how of context length extension techniques in large language models–a detailed survey. _arXiv preprint arXiv:2401.07872_ , 2024. 

- [17] Oliver Wilhelm, Andrea Hildebrandt, and Klaus Oberauer. What is working memory capacity, and how can we measure it? _Frontiers in Psychology_ , 4, 2013. 

- [18] Yudi Xie, Yu Duan, Aohua Cheng, Pengcen Jiang, Christopher J Cueva, and Guangyu Robert Yang. Natural constraints explain working memory capacity limitations in sensory-cognitive models. _bioRxiv_ , pages 2023–03, 2023. 

6 

## **Appendix** 

**==> picture [170 x 303] intentionally omitted <==**

**----- Start of picture text -----**<br>
Input<br>'ggxlxxtppclpgjccvvtgdddd'<br>Tokenization<br>Positions<br>char: idx for idx, char in<br>torch.arange(0, seq_len)<br>enumerate(alphabet)<br>Positional Embedding Input Embedding<br>max_seq_len=24,  input_dim=24,<br>embed_dim=512 embed_dim=512<br>Decoder block<br>add<br>Masked Self-Attention<br>num_heads=1<br>Unembed Layer<br>Output<br>argmax<br>'-m---m--m------m-m---<br>mmm'<br>**----- End of picture text -----**<br>


Figure 6: The architecture of the 1-layer 1-head Transformer. 

**==> picture [318 x 127] intentionally omitted <==**

**----- Start of picture text -----**<br>
0.65<br>1-back<br>0.60 2-back<br>3-back<br>0.55<br>0.50<br>0.45<br>0.40<br>0.35<br>0.30<br>0.25<br>0 1 2 3 4 5 6 7 8 9<br>Epoch<br>Training Loss<br>**----- End of picture text -----**<br>


Figure 7: Training loss of the 1-layer 1-head Transformer converges after 10 epochs. 

Table 1: Post-hoc Mann-Whitney _U_ test results for the 1-layer 1-head model. 

|_N_-back|_U_|_p_|r|
|---|---|---|---|
|1 vs 2|1825.0000|0.0002|-0.4600|
|1 vs 3|2096.0000|0.0000|-0.6768|
|2 vs 3|1665.0000|0.0128|-0.3320|



7 

**==> picture [385 x 128] intentionally omitted <==**

**----- Start of picture text -----**<br>
0 Epoch 1 1.0 0 Epoch 2 1.0 0 Epoch 3 1.0 0 Epoch 4 1.0 0 Epoch 5 1.0<br>2 2 2 2 2<br>4 0.8 4 0.8 4 0.8 4 0.8 4 0.8<br>6 6 6 6 6<br>108 0.6 108 0.6 108 0.6 108 0.6 108 0.6<br>12 12 12 12 12<br>14 0.4 14 0.4 14 0.4 14 0.4 14 0.4<br>16 16 16 16 16<br>1820 0.2 1820 0.2 1820 0.2 1820 0.2 1820 0.2<br>22 22 22 22 22<br>0.0 0.0 0.0 0.0 0.0<br>Position Index Position Index Position Index Position Index Position Index<br>0 Epoch 6 1.0 0 Epoch 7 1.0 0 Epoch 8 1.0 0 Epoch 9 1.0 0 Epoch 10 1.0<br>2 2 2 2 2<br>4 0.8 4 0.8 4 0.8 4 0.8 4 0.8<br>6 6 6 6 6<br>108 0.6 108 0.6 108 0.6 108 0.6 108 0.6<br>12 12 12 12 12<br>14 0.4 14 0.4 14 0.4 14 0.4 14 0.4<br>16 16 16 16 16<br>1820 0.2 1820 0.2 1820 0.2 1820 0.2 1820 0.2<br>22 22 22 22 22<br>0.0 0.0 0.0 0.0 0.0<br>Position Index Position Index Position Index Position Index Position Index<br>Position Index Position Index Position Index Position Index Position Index<br>0 2 4 6 8 10 12 14 16 18 20 22 0 2 4 6 8 10 12 14 16 18 20 22 0 2 4 6 8 10 12 14 16 18 20 22 0 2 4 6 8 10 12 14 16 18 20 22 0 2 4 6 8 10 12 14 16 18 20 22<br>Position Index Position Index Position Index Position Index Position Index<br>0 2 4 6 8 10 12 14 16 18 20 22 0 2 4 6 8 10 12 14 16 18 20 22 0 2 4 6 8 10 12 14 16 18 20 22 0 2 4 6 8 10 12 14 16 18 20 22 0 2 4 6 8 10 12 14 16 18 20 22<br>**----- End of picture text -----**<br>


Figure 8: Attention maps over training epochs for a 1-layer 1-head Transformer trained on the 1-back task. 

**==> picture [385 x 151] intentionally omitted <==**

**----- Start of picture text -----**<br>
10123456789 0 5 Position 010 15 20 1.00.80.60.40.20.0 10123456789 0 5 Position 110 15 20 1.00.80.60.40.20.0 10123456789 0 5 Position 210 15 20 1.00.80.60.40.20.0 10123456789 0 5 Position 310 15 20 1.00.80.60.40.20.0 10123456789 0 5 Position 410 15 20 1.00.80.60.40.20.0 10123456789 0 5 Position 510 15 20 1.00.80.60.40.20.0<br>Position Index Position Index Position Index Position Index Position Index Position Index<br>| JtLIbt bt iol a<br>10123456789 fot 0 5 Position 610 15 20 1.00.80.60.40.20.0 10123456789 fo 0 5 Position 710 15 20 1.00.80.60.40.20.0 10123456789 Go 0 5 Position 810 15 20 1.00.80.60.40.20.0 10123456789 Go 0 5 Position 910 15 20 1.00.80.60.40.20.0 10123456789 Go 0 5 Position 1010 15 20 1.00.80.60.40.20.0 10123456789 Gd 0 5 Position 1110 15 20 1.00.80.60.40.20.0<br>Position Index Position Index Position Index Position Index Position Index Position Index<br>10123456789 MO 0 5 Position 1210 15 20 1.00.80.60.40.20.0 10123456789 M 0 5 Position 13 o) 10 15 20 1.00.80.60.40.20.0 10123456789 EP 0 5 Position 1410 15 20 1.00.80.60.40.20.0 10123456789 ie 0 5 Position 1510 15 20 1.00.80.60.40.20.0 10123456789 oh 0 5 Position 1610 15 20 1.00.80.60.40.20.0 10123456789 Ce 0 5 Position 1710 15 20 1.00.80.60.40.20.0<br>Position Index Position Index Position Index Position Index Position Index Position Index<br>10123456789 ee 0 5 Position 1810 15 20 1.00.80.60.40.20.0 10123456789 0 5 Position 1910 15 20 1.00.80.60.40.20.0 10123456789 0 5 Position 2010 15 20 1.00.80.60.40.20.0 10123456789 ee 0 5 Position 2110 15 20 1.00.80.60.40.20.0 10123456789 0 5 Position 2210 15 20 1.00.80.60.40.20.0 10123456789 0 5 Position 2310 15 20 1.00.80.60.40.20.0<br>Position Index Position Index Position Index Position Index Position Index Position Index<br>Epoch Epoch Epoch Epoch Epoch Epoch<br>Epoch Epoch Epoch Epoch Epoch Epoch<br>Epoch Epoch Epoch Epoch Epoch Epoch<br>Epoch Epoch Epoch Epoch Epoch Epoch<br>**----- End of picture text -----**<br>


Figure 9: Training trajectory of attention scores over 10 epochs for the 1-back task. 

**==> picture [385 x 128] intentionally omitted <==**

**----- Start of picture text -----**<br>
0 Epoch 1 1.0 0 Epoch 2 1.0 0 Epoch 3 1.0 0 Epoch 4 1.0 0 Epoch 5 1.0<br>2 2 2 2 2<br>4 0.8 4 0.8 4 0.8 4 0.8 4 0.8<br>6 6 6 6 6<br>108 0.6 108 0.6 108 0.6 108 0.6 108 0.6<br>12 12 12 12 12<br>14 0.4 14 0.4 14 0.4 14 0.4 14 0.4<br>16 16 16 16 16<br>1820 0.2 1820 0.2 1820 0.2 1820 0.2 1820 0.2<br>22 22 22 22 22<br>0.0 0.0 0.0 0.0 0.0<br>Position Index Position Index Position Index Position Index Position Index<br>0 Epoch 6 1.0 0 Epoch 7 1.0 0 Epoch 8 1.0 0 Epoch 9 1.0 0 Epoch 10 1.0<br>2 2 2 2 2<br>4 0.8 4 0.8 4 0.8 4 0.8 4 0.8<br>6 6 6 6 6<br>108 0.6 108 0.6 108 0.6 108 0.6 108 0.6<br>12 12 12 12 12<br>14 0.4 14 0.4 14 0.4 14 0.4 14 0.4<br>16 16 16 16 16<br>1820 0.2 1820 0.2 1820 0.2 1820 0.2 1820 0.2<br>22 22 22 22 22<br>0.0 0.0 0.0 0.0 0.0<br>Position Index Position Index Position Index Position Index Position Index<br>Position Index Position Index Position Index Position Index Position Index<br>0 2 4 6 8 10 12 14 16 18 20 22 0 2 4 6 8 10 12 14 16 18 20 22 0 2 4 6 8 10 12 14 16 18 20 22 0 2 4 6 8 10 12 14 16 18 20 22 0 2 4 6 8 10 12 14 16 18 20 22<br>Position Index Position Index Position Index Position Index Position Index<br>0 2 4 6 8 10 12 14 16 18 20 22 0 2 4 6 8 10 12 14 16 18 20 22 0 2 4 6 8 10 12 14 16 18 20 22 0 2 4 6 8 10 12 14 16 18 20 22 0 2 4 6 8 10 12 14 16 18 20 22<br>**----- End of picture text -----**<br>


Figure 10: Attention maps over training epochs for a 1-layer 1-head Transformer trained on the 2-back task. 

8 

**==> picture [385 x 151] intentionally omitted <==**

**----- Start of picture text -----**<br>
10123456789 [Itt 0 5 Position 010 15 20 1.00.80.60.40.20.0 10123456789 0 5 Position 110 15 20 1.00.80.60.40.20.0 10123456789 0 5 Position 210 15 20 1.00.80.60.40.20.0 10123456789 co 0 5 Position 310 15 20 1.00.80.60.40.20.0 10123456789 bo 0 5 Position 410 15 20 1.00.80.60.40.20.0 10123456789 fo 0 5 Position 510 15 20 1.00.80.60.40.20.0<br>Position Index Position Index Position Index Position Index Position Index Position Index<br>10123456789 t 0 5 Position 6 ot 10 15 20 1.00.80.60.40.20.0 10123456789 Wt 0 5 Position 710 15 20 1.00.80.60.40.20.0 10123456789 oe 0 5 Position 810 15 20 1.00.80.60.40.20.0 10123456789 LE 0 5 Position 910 15 20 1.00.80.60.40.20.0 10123456789 a 0 5 Position 1010 15 20 1.00.80.60.40.20.0 10123456789 ed 0 5 Position 1110 15 20 1.00.80.60.40.20.0<br>Position Index Position Index Position Index Position Index Position Index Position Index<br>10123456789 T 0 5 Position 12 O) 10 15 20 1.00.80.60.40.20.0 10123456789 Oo 0 5 Position 1310 15 20 1.00.80.60.40.20.0 10123456789 Co 0 5 Position 1410 15 20 1.00.80.60.40.20.0 10123456789 Co 0 5 Position 1510 15 20 1.00.80.60.40.20.0 10123456789 Oo 0 5 Position 1610 15 20 1.00.80.60.40.20.0 10123456789 Co 0 5 Position 1710 15 20 1.00.80.60.40.20.0<br>Position Index Position Index Position Index Position Index Position Index Position Index<br>10123456789 CO 0 5 Position 1810 15 20 1.00.80.60.40.20.0 10123456789 Co 0 5 Position 1910 15 20 1.00.80.60.40.20.0 10123456789 C 0 5 Position 20 oa 10 15 20 1.00.80.60.40.20.0 10123456789 Co 0 5 Position 2110 15 20 1.00.80.60.40.20.0 10123456789 Co 0 5 Position 2210 15 20 1.00.80.60.40.20.0 10123456789 a 0 5 Position 2310 15 20 1.00.80.60.40.20.0<br>Position Index Position Index Position Index Position Index Position Index Position Index<br>Epoch Epoch Epoch Epoch Epoch Epoch<br>Epoch Epoch Epoch Epoch Epoch Epoch<br>Epoch Epoch Epoch Epoch Epoch Epoch<br>Epoch Epoch Epoch Epoch Epoch Epoch<br>**----- End of picture text -----**<br>


Figure 11: Training trajectory of attention scores over 10 epochs for the 2-back task. 

**==> picture [385 x 183] intentionally omitted <==**

**----- Start of picture text -----**<br>
Position 0 Position 1 Position 2 Position 3 Position 4 Position 5<br>10123456789 LILI 1.00.80.60.40.20.0 10123456789 1.00.80.60.40.20.0 10123456789 EI 1.00.80.60.40.20.0 10123456789 1.00.80.60.40.20.0 10123456789 td 1.00.80.60.40.20.0 10123456789 1.00.80.60.40.20.0<br>0 10 20 0 10 20 0 10 20 0 10 20 0 10 20 0 10 20<br>Position Index Position Index Position Index Position Index Position Index Position Index<br>Position 6 Position 7 Position 8 Position 9 Position 10 Position 11<br>10123456789 Eo 1.00.80.60.40.20.0 10123456789 wo 1.00.80.60.40.20.0 10123456789 wo 1.00.80.60.40.20.0 10123456789 a 1.00.80.60.40.20.0 10123456789 Go 1.00.80.60.40.20.0 10123456789 at 1.00.80.60.40.20.0<br>0 10 20 0 10 20 0 10 20 0 10 20 0 10 20 0 10 20<br>Position Index Position Index Position Index Position Index Position Index Position Index<br>Position 12 Position 13 Position 14 Position 15 Position 16 Position 17<br>10123456789 Mo 1.00.80.60.40.20.0 10123456789 Go 1.00.80.60.40.20.0 10123456789 Go 1.00.80.60.40.20.0 10123456789 1.00.80.60.40.20.0 10123456789 od 1.00.80.60.40.20.0 10123456789 1.00.80.60.40.20.0<br>0 10 20 0 10 20 0 10 20 0 10 20 0 10 20 0 10 20<br>Position Index Position Index Position Index Position Index Position Index Position Index<br>Position 18 Position 19 Position 20 Position 21 Position 22 Position 23<br>10123456789 Pit 1.00.80.60.40.20.0 10123456789 Lo 1.00.80.60.40.20.0 10123456789 Lo 1.00.80.60.40.20.0 10123456789 ol 1.00.80.60.40.20.0 10123456789 boul 1.00.80.60.40.20.0 10123456789 al 1.00.80.60.40.20.0<br>0 10 20 0 10 20 0 10 20 0 10 20 0 10 20 0 10 20<br>Position Index Position Index Position Index Position Index Position Index Position Index<br>Epoch Epoch Epoch Epoch Epoch Epoch<br>Epoch Epoch Epoch Epoch Epoch Epoch<br>Epoch Epoch Epoch Epoch Epoch Epoch<br>Epoch Epoch Epoch Epoch Epoch Epoch<br>**----- End of picture text -----**<br>


Figure 12: Training trajectory of attention scores over 10 epochs for the 3-back task. 

9 

