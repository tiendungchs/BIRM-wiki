---
title: "Universal Transformers"
source: "https://ar5iv.labs.arxiv.org/html/1807.03819"
author:
published:
created: 2026-08-31
description: "Recurrent neural networks (RNNs) sequentially process data by updating their state with each new data point, and have long been the de facto choice for sequence modeling tasks. However, their inherently sequential comp…"
tags:
  - "clippings"
---
Mostafa Dehghani ${}^{*}\dagger$ Stephan Gouws <sup>∗</sup> Oriol Vinyals University of Amsterdam DeepMind DeepMind dehghani@uva.nl sgouws@google.com vinyals@google.com Jakob Uszkoreit Łukasz Kaiser Google Brain Google Brain usz@google.com lukaszkaiser@google.com

###### Abstract

Recurrent neural networks (RNNs) sequentially process data by updating their state with each new data point, and have long been the de facto choice for sequence modeling tasks. However, their inherently sequential computation makes them slow to train. Feed-forward and convolutional architectures have recently been shown to achieve superior results on some sequence modeling tasks such as machine translation, with the added advantage that they concurrently process all inputs in the sequence, leading to easy parallelization and faster training times. Despite these successes, however, popular feed-forward sequence models like the Transformer fail to generalize in many simple tasks that recurrent models handle with ease, e.g. copying strings or even simple logical inference when the string or formula lengths exceed those observed at training time. We propose the Universal Transformer (UT), a parallel-in-time self-attentive recurrent sequence model which can be cast as a generalization of the Transformer model and which addresses these issues. UTs combine the parallelizability and global receptive field of feed-forward sequence models like the Transformer with the recurrent inductive bias of RNNs. We also add a dynamic per-position halting mechanism and find that it improves accuracy on several tasks. In contrast to the standard Transformer, under certain assumptions UTs can be shown to be Turing-complete. Our experiments show that UTs outperform standard Transformers on a wide range of algorithmic and language understanding tasks, including the challenging LAMBADA language modeling task where UTs achieve a new state of the art, and machine translation where UTs achieve a 0.9 BLEU improvement over Transformers on the WMT14 En-De dataset.

<sup>†</sup> <sup>†</sup>

## 1 Introduction

Convolutional and fully-attentional feed-forward architectures like the Transformer have recently emerged as viable alternatives to recurrent neural networks (RNNs) for a range of sequence modeling tasks, notably machine translation [^9] [^31]. These parallel-in-time architectures address a significant shortcoming of RNNs, namely their inherently sequential computation which prevents parallelization across elements of the input sequence, whilst still addressing the vanishing gradients problem as the sequence length gets longer [^16]. The Transformer model in particular relies entirely on a self-attention mechanism [^24] [^21] to compute a series of context-informed vector-space representations of the symbols in its input and output, which are then used to predict distributions over subsequent symbols as the model predicts the output sequence symbol-by-symbol. Not only is this mechanism straightforward to parallelize, but as each symbol’s representation is also directly informed by all other symbols’ representations, this results in an effectively global receptive field across the whole sequence. This stands in contrast to e.g. convolutional architectures which typically only have a limited receptive field.

Notably, however, the Transformer with its fixed stack of distinct layers foregoes RNNs’ inductive bias towards learning iterative or recursive transformations. Our experiments indicate that this inductive bias may be crucial for several algorithmic and language understanding tasks of varying complexity: in contrast to models such as the Neural Turing Machine [^13], the Neural GPU [^18] or Stack RNNs [^17], the Transformer does not generalize well to input lengths not encountered during training.

Figure 1: The Universal Transformer repeatedly refines a series of vector representations for each position of the sequence in parallel, by combining information from different positions using self-attention (see Eqn 2) and applying a recurrent transition function (see Eqn 4) across all time steps $1\leq t\leq T$. We show this process over two recurrent time-steps. Arrows denote dependencies between operations. Initially, $h^{0}$ is initialized with the embedding for each symbol in the sequence. $h^{t}_{i}$ represents the representation for input symbol $1\leq i\leq m$ at recurrent time-step $t$. With dynamic halting, $T$ is dynamically determined for each position (Section 2.2).

In this paper, we introduce the *Universal Transformer (UT)*, a parallel-in-time recurrent self-attentive sequence model which can be cast as a generalization of the Transformer model, yielding increased theoretical capabilities and improved results on a wide range of challenging sequence-to-sequence tasks. UTs combine the parallelizability and global receptive field of feed-forward sequence models like the Transformer with the recurrent inductive bias of RNNs, which seems to be better suited to a range of algorithmic and natural language understanding sequence-to-sequence problems. As the name implies, and in contrast to the standard Transformer, under certain assumptions UTs can be shown to be Turing-complete (or “computationally universal”, as shown in Section 4).

In each recurrent step, the Universal Transformer iteratively refines its representations for all symbols in the sequence in parallel using a self-attention mechanism [^24] [^21], followed by a transformation (shared across all positions and time-steps) consisting of a depth-wise separable convolution [^5] [^19] or a position-wise fully-connected layer (see Fig 1). We also add a dynamic per-position halting mechanism [^12], allowing the model to choose the required number of refinement steps *for each symbol* dynamically, and show for the first time that such a conditional computation mechanism can in fact improve accuracy on several smaller, structured algorithmic and linguistic inference tasks (although it marginally degraded results on MT).

Our strong experimental results show that UTs outperform Transformers and LSTMs across a wide range of tasks. The added recurrence yields improved results in machine translation where UTs outperform the standard Transformer. In experiments on several algorithmic tasks and the bAbI language understanding task, UTs also consistently and significantly improve over LSTMs and the standard Transformer. Furthermore, on the challenging LAMBADA text understanding data set UTs with dynamic halting achieve a new state of the art.

## 2 Model Description

### 2.1 The Universal Transformer

The Universal Transformer (UT; see Fig. 2) is based on the popular encoder-decoder architecture commonly used in most neural sequence-to-sequence models [^29] [^4] [^31]. Both the encoder and decoder of the UT operate by applying a recurrent neural network to the representations of each of the positions of the input and output sequence, respectively. However, in contrast to most applications of recurrent neural networks to sequential data, the UT does not recur over positions in the sequence, but over consecutive revisions of the vector representations of each position (i.e., over “depth”). In other words, the UT is not computationally bound by the number of symbols in the sequence, but only by the number of revisions made to each symbol’s representation.

In each recurrent time-step, the representation of every position is concurrently (in parallel) revised in two sub-steps: first, using a self-attention mechanism to exchange information across all positions in the sequence, thereby generating a vector representation for each position that is informed by the representations of all other positions at the previous time-step. Then, by applying a transition function (shared across position and time) to the outputs of the self-attention mechanism, independently at each position. As the recurrent transition function can be applied any number of times, this implies that UTs can have variable depth (number of per-symbol processing steps). Crucially, this is in contrast to most popular neural sequence models, including the Transformer [^31] or deep RNNs, which have constant depth as a result of applying a *fixed stack* of layers. We now describe the encoder and decoder in more detail.

Encoder: Given an input sequence of length $m$, we start with a matrix whose rows are initialized as the $d$ -dimensional embeddings of the symbols at each position of the sequence $H^{0}\in\mathbb{R}^{m\times d}$. The UT then iteratively computes representations $H^{t}$ at step $t$ for all $m$ positions in parallel by applying the multi-headed dot-product self-attention mechanism from [^31], followed by a recurrent transition function. We also add residual connections around each of these function blocks and apply dropout and layer normalization [^27] [^2] (see Fig. 2 for a simplified diagram, and Fig. 4 in the Appendix A for the complete model.).

More specifically, we use the scaled dot-product attention which combines queries $Q$, keys $K$ and values $V$ as follows

$$
\textsc{Attention}(Q,K,V)=\textsc{softmax}\left(\frac{QK^{T}}{\sqrt{d}}\right)V,
$$

where $d$ is the number of columns of $Q$, $K$ and $V$. We use the multi-head version with $k$ heads, as introduced in [^31],

$$
\displaystyle\textsc{MultiHeadSelfAttention}(H^{t})
$$
 
$$
\displaystyle=\textsc{Concat}(\mathrm{head_{1}},...,\mathrm{head_{k}})W^{O}
$$
 
$$
\displaystyle\text{where}~\mathrm{head_{i}}
$$
 
$$
\displaystyle=\textsc{Attention}(H^{t}W^{Q}_{i},H^{t}W^{K}_{i},H^{t}W^{V}_{i})
$$

and we map the state $H^{t}$ to queries, keys and values with affine projections using learned parameter matrices $W^{Q}\in\mathbb{R}^{d\times d/k}$, $W^{K}\in\mathbb{R}^{d\times d/k}$, $W^{V}\in\mathbb{R}^{d\times d/k}$ and $W^{O}\in\mathbb{R}^{d\times d}$.

At step $t$, the UT then computes revised representations $H^{t}\in\mathbb{R}^{m\times d}$ for all $m$ input positions as follows

$$
\displaystyle H^{t}
$$
 
$$
\displaystyle=\textsc{LayerNorm}(A^{t}+\textsc{Transition}(A^{t}))
$$
 
$$
\displaystyle\mathrm{where}~A^{t}
$$
 
$$
\displaystyle=\textsc{LayerNorm}((H^{t-1}+P^{t})+\textsc{MultiHeadSelfAttention}(H^{t-1}+P^{t})),
$$

where LayerNorm() is defined in [^2], and Transition() and $P^{t}$ are discussed below.

Depending on the task, we use one of two different transition functions: either a separable convolution [^5] or a fully-connected neural network that consists of a single rectified-linear activation function between two affine transformations, applied position-wise, i.e. individually to each row of $A^{t}$.

$P^{t}\in\mathbb{R}^{m\times d}$ above are fixed, constant, two-dimensional (position, time) *coordinate embeddings*, obtained by computing the sinusoidal position embedding vectors as defined in [^31] for the positions $1\leq i\leq m$ and the time-step $1\leq t\leq T$ separately for each vector-dimension $1\leq j\leq d$, and summing:

$$
\displaystyle P^{t}_{i,2j}
$$
 
$$
\displaystyle=\sin(i/10000^{2j/d})+\sin(t/10000^{2j/d})
$$
 
$$
\displaystyle P^{t}_{i,2j+1}
$$
 
$$
\displaystyle=\cos(i/10000^{2j/d})+\cos(t/10000^{2j/d}).
$$

Figure 2: The recurrent blocks of the Universal Transformer encoder and decoder. This diagram omits position and time-step encodings as well as dropout, residual connections and layer normalization. A complete version can be found in Appendix A. The Universal Transformer with dynamic halting determines the number of steps $T$ for each position individually using ACT [^12].

After $T$ steps (each updating all positions of the input sequence in parallel), the final output of the Universal Transformer encoder is a matrix of $d$ -dimensional vector representations $H^{T}\in\mathbb{R}^{m\times d}$ for the $m$ symbols of the input sequence.

Decoder: The decoder shares the same basic recurrent structure of the encoder. However, after the self-attention function, the decoder additionally also attends to the final encoder representation $H^{T}$ of each position in the input sequence using the same multihead dot-product attention function from Equation 2, but with queries $Q$ obtained from projecting the decoder representations, and keys and values ($K$ and $V$) obtained from projecting the encoder representations (this process is akin to standard attention [^3]).

Like the Transformer model, the UT is autoregressive [^11]. Trained using teacher-forcing, at generation time it produces its output one symbol at a time, with the decoder consuming the previously produced output positions. During training, the decoder input is the target output, shifted to the right by one position. The decoder self-attention distributions are further masked so that the model can only attend to positions to the left of any predicted symbol. Finally, the per-symbol target distributions are obtained by applying an affine transformation $O\in\mathbb{R}^{d\times V}$ from the final decoder state to the output vocabulary size $V$, followed by a softmax which yields an $(m\times V)$ -dimensional output matrix normalized over its rows:

$$
p\left(y_{pos}|y_{[1:pos-1]},H^{T}\right)=\textsc{softmax}(OH^{T})
$$

To generate from the model, the encoder is run once for the conditioning input sequence. Then the decoder is run repeatedly, consuming all already-generated symbols, while generating one additional distribution over the vocabulary for the symbol at the next output position per iteration. We then typically sample or select the highest probability symbol as the next symbol.

### 2.2 Dynamic Halting

In sequence processing systems, certain symbols (e.g. some words or phonemes) are usually more ambiguous than others. It is therefore reasonable to allocate more processing resources to these more ambiguous symbols. Adaptive Computation Time (ACT) [^12] is a mechanism for dynamically modulating the number of computational steps needed to process each input symbol (called the “ponder time”) in standard recurrent neural networks based on a scalar *halting probability* predicted by the model at each step.

Inspired by the interpretation of Universal Transformers as applying self-attentive RNNs in parallel to all positions in the sequence, we also add a dynamic ACT halting mechanism to each position (i.e. to each per-symbol self-attentive RNN; see Appendix C for more details). Once the per-symbol recurrent block halts, its state is simply copied to the next step until all blocks halt, or we reach a maximum number of steps. The final output of the encoder is then the final layer of representations produced in this way.

## 3 Experiments and Analysis

We evaluated the Universal Transformer on a range of algorithmic and language understanding tasks, as well as on machine translation. We describe these tasks and datasets in more detail in Appendix D.

### 3.1 bAbI Question-Answering

The bAbi question answering dataset [^33] consists of 20 different tasks, where the goal is to answer a question given a number of English sentences that encode potentially multiple supporting facts. The goal is to measure various forms of language understanding by requiring a certain type of reasoning over the linguistic facts presented in each story. A standard Transformer does not achieve good results on this task <sup>2</sup>. However, we have designed a model based on the Universal Transformer which achieves state-of-the-art results on this task.

To encode the input, similar to [^15], we first encode each fact in the story by applying a learned multiplicative positional mask to each word’s embedding, and summing up all embeddings. We embed the question in the same way, and then feed the (Universal) Transformer with these embeddings of the facts and questions.

As originally proposed, models can either be trained on each task separately (“train single”) or jointly on all tasks (“train joint”). Table 1 summarizes our results. We conducted 10 runs with different initializations and picked the best model based on performance on the validation set, similar to previous work. Both the UT and UT with dynamic halting achieve state-of-the-art results on all tasks in terms of average error and number of failed tasks <sup>3</sup>, in both the 10K and 1K training regime (see Appendix E for breakdown by task).

<table><tbody><tr><td rowspan="2">Model</td><td colspan="2">10K examples</td><td colspan="2">1K examples</td></tr><tr><td>train single</td><td>train joint</td><td>train single</td><td>train joint</td></tr><tr><td colspan="5">Previous best results:</td></tr><tr><td>QRNet <sup><a href="#fn:26">26</a></sup></td><td>0.3 (0/20)</td><td>-</td><td>-</td><td>-</td></tr><tr><td>Sparse DNC <sup><a href="#fn:25">25</a></sup></td><td>-</td><td>2.9 (1/20)</td><td>-</td><td>-</td></tr><tr><td>GA+MAGE <sup><a href="#fn:7">7</a></sup></td><td>-</td><td>-</td><td>8.7 (5/20)</td><td>-</td></tr><tr><td>MemN2N <sup><a href="#fn:28">28</a></sup></td><td>-</td><td>-</td><td>-</td><td>12.4 (11/20)</td></tr><tr><td colspan="5">Our Results:</td></tr><tr><td>Transformer <sup><a href="#fn:31">31</a></sup></td><td>15.2 (10/20)</td><td>22.1 (12/20)</td><td>21.8 (5/20)</td><td>26.8 (14/20)</td></tr><tr><td>Universal Transformer (this work)</td><td>0.23 (0/20)</td><td>0.47 (0/20)</td><td>5.31 (5/20)</td><td>8.50 (8/20)</td></tr><tr><td>UT w/ dynamic halting (this work)</td><td>0.21 (0/20)</td><td>0.29 (0/20)</td><td>4.55 (3/20)</td><td>7.78 (5/20)</td></tr></tbody></table>

Table 1: Average error and number of failed tasks ($>5\%$ error) out of 20 (in parentheses; lower is better in both cases) on the bAbI dataset under the different training/evaluation setups. We indicate state-of-the-art where available for each, or ‘-’ otherwise.

![Refer to caption](https://ar5iv.labs.arxiv.org/html/1807.03819/assets/figs/task3_example_ponder.png)

Figure 3: Ponder time of UT with dynamic halting for encoding facts in a story and question in a bAbI task requiring three supporting facts.

To understand the working of the model better, we analyzed both the attention distributions and the average ACT ponder times for this task (see Appendix F for details). First, we observe that the attention distributions start out very uniform, but get progressively sharper in later steps around the correct supporting facts that are required to answer each question, which is indeed very similar to how humans would solve the task. Second, with dynamic halting we observe that the average ponder time (i.e. depth of the per-symbol recurrent processing chain) over all positions in all samples in the test data for tasks requiring three supporting facts is higher ($3.8\raisebox{0.86108pt}{$\scriptstyle\pm$}2.2$) than for tasks requiring only two ($3.1\raisebox{0.86108pt}{$\scriptstyle\pm$}1.1$), which is in turn higher than for tasks requiring only one supporting fact ($2.3\raisebox{0.86108pt}{$\scriptstyle\pm$}0.8$). This indicates that the model adjusts the number of processing steps with the number of supporting facts required to answer the questions. Finally, we observe that the histogram of ponder times at different positions is more uniform in tasks requiring only one supporting fact compared to two and three, and likewise for tasks requiring two compared to three. Especially for tasks requiring three supporting facts, many positions halt at step 1 or 2 already and only a few get transformed for more steps (see for example Fig 3). This is particularly interesting as the length of stories is indeed much higher in this setting, with more irrelevant facts which the model seems to successfully learn to ignore in this way.

Similar to dynamic memory networks [^20], there is an iterative attention process in UTs that allows the model to condition its attention over memory on the result of previous iterations. Appendix F presents some examples illustrating that there is a notion of temporal states in UT, where the model updates its states (memory) in each step based on the output of previous steps, and this chain of updates can also be viewed as steps in a multi-hop reasoning process.

### 3.2 Subject-Verb Agreement

Next, we consider the task of predicting number-agreement between subjects and verbs in English sentences [^22]. This task acts as a proxy for measuring the ability of a model to capture hierarchical (dependency) structure in natural language sentences. We use the dataset provided by [^22] and follow their experimental protocol of solving the task using a language modeling training setup, i.e. a next word prediction objective, followed by calculating the ranking accuracy of the target verb at test time. We evaluated our model on subsets of the test data with different task difficulty, measured in terms of *agreement attractors* – the number of intervening nouns with the opposite number from the subject (meant to confuse the model). For example, given the sentence *The keys to the cabinet* <sup>4</sup>, the objective during training is to predict the verb *are* (plural). At test time, we then evaluate the ranking accuracy of the agreement attractors: i.e. the goal is to rank *are* higher than *is* in this case.

<table><tbody><tr><td rowspan="2">Model</td><td colspan="6">Number of attractors</td><td></td></tr><tr><td>0</td><td>1</td><td>2</td><td>3</td><td>4</td><td>5</td><td>Total</td></tr><tr><td colspan="8">Previous best results <sup><a href="#fn:34">34</a></sup>:</td></tr><tr><td>Best Stack-RNN</td><td><em>0.994</em></td><td>0.979</td><td>0.965</td><td>0.935</td><td>0.916</td><td>0.880</td><td>0.992</td></tr><tr><td>Best LSTM</td><td>0.993</td><td>0.972</td><td>0.950</td><td>0.922</td><td>0.900</td><td>0.842</td><td>0.991</td></tr><tr><td>Best Attention</td><td>0.994</td><td>0.977</td><td>0.959</td><td>0.929</td><td>0.907</td><td>0.842</td><td>0.992</td></tr><tr><td colspan="8">Our results:</td></tr><tr><td>Transformer</td><td>0.973</td><td>0.941</td><td>0.932</td><td>0.917</td><td>0.901</td><td>0.883</td><td>0.962</td></tr><tr><td>Universal Transformer</td><td>0.993</td><td>0.971</td><td>0.969</td><td>0.940</td><td>0.921</td><td>0.892</td><td>0.992</td></tr><tr><td>UT w/ ACT</td><td>0.994</td><td>0.969</td><td>0.967</td><td>0.944</td><td>0.932</td><td>0.907</td><td>0.992</td></tr><tr><td><math><semantics><mi>Δ</mi> <annotation>\Delta</annotation></semantics></math> (UT w/ ACT - Best)</td><td>0</td><td>-0.008</td><td>0.002</td><td>0.009</td><td>0.016</td><td>0.027</td><td>-</td></tr></tbody></table>

Table 2: Accuracy on the subject-verb agreement number prediction task (higher is better).

Our results are summarized in Table 2. The best LSTM with attention from the literature achieves 99.18% on this task [^34], outperforming a vanilla Transformer [^30]. UTs significantly outperform standard Transformers, and achieve an *average* result comparable to the current state of the art (99.2%). However, we see that UTs (and particularly with dynamic halting) perform progressively better than all other models as the number of attractors increases (see the last row, $\Delta$).

### 3.3 LAMBADA Language Modeling

The LAMBADA task [^23] is a language modeling task consisting of predicting a missing target word given a broader context of 4-5 preceding sentences. The dataset was specifically designed so that humans are able to accurately predict the target word when shown the full context, but not when only shown the target sentence in which it appears. It therefore goes beyond language modeling, and tests the ability of a model to incorporate broader discourse and longer term context when predicting the target word.

The task is evaluated in two settings: as *language modeling* (the standard setup) and as *reading comprehension*. In the former (more challenging) case, a model is simply trained for next-word prediction on the training data, and evaluated on the target words at test time (i.e. the model is trained to predict all words, not specifically challenging target words). In the latter setting, introduced by Chu et al. [^6], the target sentence (minus the last word) is used as query for selecting the target word from the context sentences. Note that the target word appears in the context 81% of the time, making this setup much simpler. However the task is impossible in the remaining 19% of the cases.

Model LM Perplexity & (Accuracy) RC Accuracy control dev test control dev test Neural Cache [^10] 129 139 - - - - Dhingra et al. [^8] - - - - - 0.5569 Transformer 142 (0.19) 5122 (0.0) 7321 (0.0) 0.4102 0.4401 0.3988 LSTM 138 (0.23) 4966 (0.0) 5174 (0.0) 0.1103 0.2316 0.2007 UT *base*, 6 steps (fixed) 131 (0.32) 279 (0.18) 319 (0.17) 0.4801 0.5422 0.5216 UT w/ dynamic halting 130 (0.32) 134 (0.22) 142 (0.19) 0.4603 0.5831 0.5625 UT *base*, 8 steps (fixed) 129(0.32) 192 (0.21) 202 (0.18) - - - UT *base*, 9 steps (fixed) 129(0.33) 214 (0.21) 239 (0.17) - - -

Table 3: LAMBADA language modeling (LM) perplexity (lower better) with accuracy in parentheses (higher better), and Reading Comprehension (RC) accuracy results (higher better). ‘-’ indicates no reported results in that setting.

The results are shown in Table 3. Universal Transformer achieves state-of-the-art results in both the language modeling and reading comprehension setup, outperforming both LSTMs and vanilla Transformers. Note that the control set was constructed similar to the LAMBADA development and test sets, but without filtering them in any way, so achieving good results on this set shows a model’s strength in standard language modeling.

Our best fixed UT results used 6 steps. However, the average number of steps that the best UT with dynamic halting took on the test data over all positions and examples was $8.2\raisebox{0.86108pt}{$\scriptstyle\pm$}2.1$. In order to see if the dynamic model did better simply because it took more steps, we trained two fixed UT models with 8 and 9 steps respectively (see last two rows). Interestingly, these two models achieve better results compared to the model with 6 steps, but *do not outperform the UT with dynamic halting*. This leads us to believe that dynamic halting may act as a useful regularizer for the model via incentivizing a smaller numbers of steps for some of the input symbols, while allowing more computation for others.

### 3.4 Algorithmic Tasks

We trained UTs on three algorithmic tasks, namely Copy, Reverse, and (integer) Addition, all on strings composed of decimal symbols (‘0’-‘9’). In all the experiments, we train the models on sequences of length 40 and evaluated on sequences of length 400 [^18]. We train UTs using positions starting with randomized offsets to further encourage the model to learn position-relative transformations. Results are shown in Table 4. The UT outperforms both LSTM and vanilla Transformer by a wide margin on all three tasks. The Neural GPU reports perfect results on this task [^18], however we note that this result required a special curriculum-based training protocol which was not used for other models.

<table><thead><tr><th rowspan="2">Model</th><th colspan="2">Copy</th><th colspan="2">Reverse</th><th colspan="2">Addition</th></tr><tr><th>char-acc</th><th>seq-acc</th><th>char-acc</th><th>seq-acc</th><th>char-acc</th><th>seq-acc</th></tr></thead><tbody><tr><th>LSTM</th><td>0.45</td><td>0.09</td><td>0.66</td><td>0.11</td><td>0.08</td><td>0.0</td></tr><tr><th>Transformer</th><td>0.53</td><td>0.03</td><td>0.13</td><td>0.06</td><td>0.07</td><td>0.0</td></tr><tr><th>Universal Transformer</th><td>0.91</td><td>0.35</td><td>0.96</td><td>0.46</td><td>0.34</td><td>0.02</td></tr><tr><th>Neural GPU <sup>∗</sup></th><td>1.0</td><td>1.0</td><td>1.0</td><td>1.0</td><td>1.0</td><td>1.0</td></tr></tbody></table>

Table 4: Accuracy (higher better) on the algorithmic tasks. <sup>∗</sup> Note that the Neural GPU was trained with a special curriculum to obtain the perfect result, while other models are trained without any curriculum.

### 3.5 Learning to Execute (LTE)

As another class of sequence-to-sequence learning problems, we also evaluate UTs on tasks indicating the ability of a model to learn to execute computer programs, as proposed in [^35]. These tasks include program evaluation tasks (program, control, and addition), and memorization tasks (copy, double, and reverse).

<table><tbody><tr><td></td><th colspan="2">Copy</th><th colspan="2">Double</th><th colspan="2">Reverse</th></tr><tr><th>Model</th><th>char-acc</th><th>seq-acc</th><th>char-acc</th><th>seq-acc</th><th>char-acc</th><th>seq-acc</th></tr><tr><td>LSTM</td><td>0.78</td><td>0.11</td><td>0.51</td><td>0.047</td><td>0.91</td><td>0.32</td></tr><tr><td>Transformer</td><td>0.98</td><td>0.63</td><td>0.94</td><td>0.55</td><td>0.81</td><td>0.26</td></tr><tr><td>Universal Transformer</td><td>1.0</td><td>1.0</td><td>1.0</td><td>1.0</td><td>1.0</td><td>1.0</td></tr></tbody></table>

Table 5: Character-level (*char-acc*) and sequence-level accuracy (*seq-acc*) results on the Memorization LTE tasks, with maximum length of 55.

<table><tbody><tr><td></td><th colspan="2">Program</th><th colspan="2">Control</th><th colspan="2">Addition</th></tr><tr><th>Model</th><th>char-acc</th><th>seq-acc</th><th>char-acc</th><th>seq-acc</th><th>char-acc</th><th>seq-acc</th></tr><tr><td>LSTM</td><td>0.53</td><td>0.12</td><td>0.68</td><td>0.21</td><td>0.83</td><td>0.11</td></tr><tr><td>Transformer</td><td>0.71</td><td>0.29</td><td>0.93</td><td>0.66</td><td>1.0</td><td>1.0</td></tr><tr><td>Universal Transformer</td><td>0.89</td><td>0.63</td><td>1.0</td><td>1.0</td><td>1.0</td><td>1.0</td></tr></tbody></table>

Table 6: Character-level (*char-acc*) and sequence-level accuracy (*seq-acc*) results on the Program Evaluation LTE tasks with maximum nesting of 2 and length of 5.

We use the mix-strategy discussed in [^35] to generate the datasets. Unlike [^35], we do not use any curriculum learning strategy during training and we make no use of target sequences at test time. Tables 5 and 6 present the performance of an LSTM model, Transformer, and Universal Transformer on the program evaluation and memorization tasks, respectively. UT achieves perfect scores in all the memorization tasks and also outperforms both LSTMs and Transformers in all program evaluation tasks by a wide margin.

### 3.6 Machine Translation

We trained a UT on the WMT 2014 English-German translation task using the same setup as reported in [^31] in order to evaluate its performance on a large-scale sequence-to-sequence task. Results are summarized in Table 7. The UT with a fully-connected recurrent transition function (instead of separable convolution) and without ACT improves by 0.9 BLEU over a Transformer and 0.5 BLEU over a Weighted Transformer with approximately the same number of parameters [^1].

| Model | BLEU |
| --- | --- |
| Universal Transformer *small* | 26.8 |
| Transformer *base* [^31] | 28.0 |
| Weighted Transformer *base* [^1] | 28.4 |
| Universal Transformer *base* | 28.9 |

Table 7: Machine translation results on the WMT14 En-De translation task trained on 8xP100 GPUs in comparable training setups. All *base* results have the same number of parameters.

## 4 Discussion

When running for a fixed number of steps, the Universal Transformer is equivalent to a multi-layer Transformer with tied parameters across all its layers. This is partly similar to the Recursive Transformer, which ties the weights of its self-attention layers across depth [^14] <sup>5</sup>. However, as the per-symbol recurrent transition functions can be applied any number of times, another and possibly more informative way of characterizing the UT is as a block of parallel RNNs (one for each symbol, with shared parameters) evolving per-symbol hidden states concurrently, generated at each step by attending to the sequence of hidden states at the previous step. In this way, it is related to architectures such as the Neural GPU [^18] and the Neural Turing Machine [^13]. UTs thereby retain the attractive computational efficiency of the original feed-forward Transformer model, but with the added recurrent inductive bias of RNNs. Furthermore, using a dynamic halting mechanism, UTs can choose the number of processing steps based on the input data.

The connection between the Universal Transformer and other sequence models is apparent from the architecture: if we limited the recurrent steps to one, it would be a Transformer. But it is more interesting to consider the relationship between the Universal Transformer and RNNs and other networks where recurrence happens over the time dimension. Superficially these models may seem closely related since they are recurrent as well. But there is a crucial difference: time-recurrent models like RNNs cannot access memory in the recurrent steps. This makes them computationally more similar to automata, since the only memory available in the recurrent part is a fixed-size state vector. UTs on the other hand can attend to the whole previous layer, allowing it to access memory in the recurrent step.

Given sufficient memory the Universal Transformer is computationally universal -- i.e. it belongs to the class of models that can be used to simulate any Turing machine, thereby addressing a shortcoming of the standard Transformer model <sup>6</sup>. In addition to being theoretically appealing, our results show that this added expressivity also leads to improved accuracy on several challenging sequence modeling tasks. This closes the gap between practical sequence models competitive on large-scale tasks such as machine translation, and computationally universal models such as the Neural Turing Machine or the Neural GPU [^13] [^18], which can be trained using gradient descent to perform algorithmic tasks.

To show this, we can reduce a Neural GPU to a Universal Transformer. Ignoring the decoder and parameterizing the self-attention module, i.e. self-attention with the residual connection, to be the identity function, we assume the transition function to be a convolution. If we now set the total number of recurrent steps $T$ to be equal to the input length, we obtain exactly a Neural GPU. Note that the last step is where the Universal Transformer crucially differs from the vanilla Transformer whose depth cannot scale dynamically with the size of the input. A similar relationship exists between the Universal Transformer and the Neural Turing Machine, whose single read/write operations per step can be expressed by the global, parallel representation revisions of the Universal Transformer. In contrast to these models, however, which only perform well on algorithmic tasks, the Universal Transformer also achieves competitive results on realistic natural language tasks such as LAMBADA and machine translation.

Another related model architecture is that of end-to-end Memory Networks [^28]. In contrast to end-to-end memory networks, however, the Universal Transformer uses memory corresponding to states aligned to individual positions of its inputs or outputs. Furthermore, the Universal Transformer follows the encoder-decoder configuration and achieves competitive performance in large-scale sequence-to-sequence tasks.

## 5 Conclusion

This paper introduces the Universal Transformer, a generalization of the Transformer model that extends its theoretical capabilities and produces state-of-the-art results on a wide range of challenging sequence modeling tasks, such as language understanding but also a variety of algorithmic tasks, thereby addressing a key shortcoming of the standard Transformer. The Universal Transformer combines the following key properties into one model:

Weight sharing: Following intuitions behind weight sharing found in CNNs and RNNs, we extend the Transformer with a simple form of weight sharing that strikes an effective balance between inductive bias and model expressivity, which we show extensively on both small and large-scale experiments.

Conditional computation: In our goal to build a computationally universal machine, we equipped the Universal Transformer with the ability to halt or continue computation through a recently introduced mechanism, which shows stronger results compared to the fixed-depth Universal Transformer.

We are enthusiastic about the recent developments on parallel-in-time sequence models. By adding computational capacity and recurrence in processing depth, we hope that further improvements beyond the basic Universal Transformer presented here will help us build learning algorithms that are both more powerful, data efficient, and generalize beyond the current state-of-the-art.

The code used to train and evaluate Universal Transformers is available at [https://github.com/tensorflow/tensor2tensor](https://github.com/tensorflow/tensor2tensor) [^32].

#### Acknowledgements

We are grateful to Ashish Vaswani, Douglas Eck, and David Dohan for their fruitful comments and inspiration.

## References

## Appendix A Detailed Schema of the Universal Transformer

Figure 4: The Universal Transformer with position and step embeddings as well as dropout and layer normalization.

## Appendix B On the Computational Power of UT vs Transformer

With respect to their computational power, the key difference between the Transformer and the Universal Transformer lies in the number of sequential steps of computation (i.e. in depth). While a standard Transformer executes a total number of operations that scales with the input size, the number of sequential operations is constant, independent of the input size and determined solely by the number of layers. Assuming finite precision, this property implies that the standard Transformer cannot be computationally universal. When choosing a number of steps as a function of the input length, however, the Universal Transformer does not suffer from this limitation. Note that this holds independently of whether or not adaptive computation time is employed but does assume a non-constant, even if possibly deterministic, number of steps. Varying the number of steps dynamically after training is enabled by sharing weights across sequential computation steps in the Universal Transformer.

An intuitive example are functions whose execution requires the sequential processing of each input element. In this case, for any given choice of depth $T$, one can construct an input sequence of length $N>T$ that cannot be processed correctly by a standard Transformer. With an appropriate, input-length dependent choice of sequential steps, however, a Universal Transformer, RNNs or Neural GPUs can execute such a function.

![[Uncaptioned image]](https://ar5iv.labs.arxiv.org/html/1807.03819/assets/figs/universality_example.png)

## Appendix C UT with Dynamic Halting

We implement the dynamic halting based on ACT [^12] as follows in TensorFlow. In each step of the UT with dynamic halting, we are given the halting probabilities, remainders, number of updates up to that point, and the previous state (all initialized as zeros), as well as a scalar threshold between 0 and 1 (a hyper-parameter). We then compute the new state for each position and calculate the new per-position halting probabilities based on the state for each position. The UT then decides to halt for some positions that crossed the threshold, and updates the state of other positions until the model halts for all positions or reaches a predefined maximum number of steps:

⬇

\# While-loop stops when this predicate is FALSE

\# i.e. all ((probability < threshold) & (counter < max\_steps)) are false

def should\_continue(u0, u1, halting\_probability, u2, n\_updates, u3):

return tf.reduce\_any(

tf.logical\_and(

tf.less(halting\_probability, threshold),

tf.less(n\_updates, max\_steps)))

\# Do while loop iterations until predicate above is false

(\_, \_, \_, remainder, n\_updates, new\_state) = tf.while\_loop(

should\_continue, ut\_with\_dynamic\_halting, (state,

step, halting\_probability, remainders, n\_updates, previous\_state))

Listing 1: UT with dynamic halting.

The following shows the computations in each step:

⬇

def ut\_with\_dynamic\_halting(state, step, halting\_probability,

remainders, n\_updates, previous\_state):

\# Calculate the probabilities based on the state

p = common\_layers.dense(state, 1, activation=tf.nn.sigmoid,

use\_bias=True)

\# Mask for inputs which have not halted yet

still\_running = tf.cast(

tf.less(halting\_probability,1.0), tf.float32)

\# Mask of inputs which halted at this step

new\_halted = tf.cast(

tf.greater(halting\_probability + p \* still\_running, threshold),

tf.float32) \* still\_running

\# Mask of inputs which haven’t halted, and didn’t halt this step

still\_running = tf.cast(

tf.less\_equal(halting\_probability + p \* still\_running,

threshold), tf.float32) \* still\_running

\# Add the halting probability for this step to the halting

\# probabilities for those inputs which haven’t halted yet

halting\_probability += p \* still\_running

\# Compute remainders for the inputs which halted at this step

remainders += new\_halted \* (1 - halting\_probability)

\# Add the remainders to those inputs which halted at this step

halting\_probability += new\_halted \* remainders

\# Increment n\_updates for all inputs which are still running

n\_updates += still\_running + new\_halted

\# Compute the weight to be applied to the new state and output:

\# 0 when the input has already halted,

\# p when the input hasn’t halted yet,

\# the remainders when it halted this step.

update\_weights = tf.expand\_dims(p \* still\_running +

new\_halted \* remainders, -1)

\# Apply transformation to the state

transformed\_state = transition\_function(self\_attention(state))

\# Interpolate transformed and previous states for non-halted inputs

new\_state = ((transformed\_state \* update\_weights) +

(previous\_state \* (1 - update\_weights)))

step += 1

return (transformed\_state, step, halting\_probability,

remainders, n\_updates, new\_state)

Listing 2: Computations in each step of the UT with dynamic halting.

## Appendix D Description of some of the Tasks/Datasets

Here, we provide some additional details on the bAbI, subject-verb agreement, LAMBADA language modeling, and learning to execute (LTE) tasks.

### D.1 bAbI Question-Answering

The bAbi question answering dataset [^33] consists of 20 different synthetic tasks <sup>7</sup>. The aim is that each task tests a unique aspect of language understanding and reasoning, including the ability of: reasoning from supporting facts in a story, answering true/false type questions, counting, understanding negation and indefinite knowledge, understanding coreferences, time reasoning, positional and size reasoning, path-finding, and understanding motivations (to see examples for each of these tasks, please refer to Table 1 in [^33]).

There are two versions of the dataset, one with 1k training examples and the other with 10k examples. It is important for a model to be data-efficient to achieve good results using only the 1k training examples. Moreover, the original idea is that a single model should be evaluated across all the tasks (not tuning per task), which is the *train joint* setup in Table 1, and the tables presented in Appendix E.

### D.2 Subject-Verb Agreement

Subject-verb agreement is the task of predicting number agreement between subject and verb in English sentences. Succeeding in this task is a strong indicator that a model can learn to approximate syntactic structure and therefore it was proposed by [^22] as proxy for assessing the ability of different models to capture hierarchical structure in natural language.

Two experimental setups were proposed by [^22] for training a model on this task: 1) training with a language modeling objective, i.e., next word prediction, and 2) as binary classification, i.e. predicting the number of the verb given the sentence. In this paper, we use the language modeling objective, meaning that we provide the model with an implicit supervision and evaluate based on the ranking accuracy of the correct form of the verb compared to the incorrect form of the verb.

In this task, in order to have different levels of difficulty, “agreement attractors” are used, i.e. one or more intervening nouns with the opposite number from the subject with the goal of confusing the model. In this case, the model needs to correctly identify the head of the syntactic subject that corresponds to a given verb and ignore the intervening attractors in order to predict the correct form of that verb. Here are some examples for this task in which subjects and the corresponding verbs are in boldface and agreement attractors are underlined:

| No attractor: | The boy smiles. |
| --- | --- |
| One attractor: | The number of men is not clear. |
| Two attractors: | The ratio of men to women is not clear. |
| Three attractors: | The ratio of men to women and children is not clear. |

### D.3 LAMBADA Language Modeling

The LAMBADA task [^23] is a broad context language modeling task. In this task, given a narrative passage, the goal is to predict the last word (target word) of the last sentence (target sentence) in the passage. These passages are specifically selected in a way that human subjects are easily able to guess their last word if they are exposed to a long passage, but not if they only see the target sentence preceding the target word <sup>8</sup>. Here is a sample from the dataset:

| Context: |  |
| --- | --- |
|  | ‘‘Yes, I thought I was going to lose the baby.’’ |
|  | ‘‘I was scared too,’’ he stated, sincerity flooding his eyes. |
|  | ‘‘You were?’’ ‘‘Yes, of course. Why do you even ask?’’ |
|  | ‘‘This baby wasn’t exactly planned for.’’ |
| Target sentence: |  |
|  | ‘‘Do you honestly think that I would want you to have a \_\_\_\_\_\_\_\_?’’ |
| Target word: |  |
|  | miscarriage |

The LAMBADA task consists in predicting the target word given the whole passage (i.e., the context plus the target sentence). A “control set” is also provided which was constructed by randomly sampling passages of the same shape and size as the ones used to build LAMBADA, but without filtering them in any way. The control set is used to evaluate the models at standard language modeling before testing on the LAMBADA task, and therefore to ensure that low performance on the latter cannot be attributed simply to poor language modeling.

The task is evaluated in two settings: as *language modeling* (the standard setup) and as *reading comprehension*. In the former (more challenging) case, a model is simply trained for the next word prediction on the training data, and evaluated on the target words at test time (i.e. the model is trained to predict all words, not specifically challenging target words). In this paper, we report the results of the Universal Transformer in both setups.

### D.4 Learning to Execute (LTE)

LTE is a set of tasks indicating the ability of a model to learn to execute computer programs and was proposed by [^35]. These tasks include two subsets: 1) program evaluation tasks (program, control, and addition) that are designed to assess the ability of models for understanding numerical operations, if-statements, variable assignments, the compositionality of operations, and more, as well as 2) memorization tasks (copy, double, and reverse).

The difficulty of the program evaluation tasks is parameterized by their length and nesting. The length parameter is the number of digits in the integers that appear in the programs (so the integers are chosen uniformly from \[1, *length*\]), and the nesting parameter is the number of times we are allowed to combine the operations with each other. Higher values of nesting yield programs with deeper parse trees. For instance, here is a program that is generated with length = 4 and nesting = 3.

| Input: |  |
| --- | --- |
|  | j=8584 |
|  | for x in range(8): |
|  | j+=920 |
|  | b=(1500+j) |
|  | print((b+7567)) |
| Target: |  |
|  | 25011 |

## Appendix E bAbI Detailed Results

<table><thead><tr><th colspan="5">Best seed run for each task (out of 10 runs)</th></tr></thead><tbody><tr><th rowspan="2">Task id</th><td colspan="2">10K</td><td colspan="2">1K</td></tr><tr><td>train single</td><td>train joint</td><td>train single</td><td>train joint</td></tr><tr><th>1</th><td>0.0</td><td>0.0</td><td>0.0</td><td>0.0</td></tr><tr><th>2</th><td>0.0</td><td>0.0</td><td>0.0</td><td>0.5</td></tr><tr><th>3</th><td>0.4</td><td>1.2</td><td>3.7</td><td>5.4</td></tr><tr><th>4</th><td>0.0</td><td>0.0</td><td>0.0</td><td>0.0</td></tr><tr><th>5</th><td>0.0</td><td>0.0</td><td>0.0</td><td>0.5</td></tr><tr><th>6</th><td>0.0</td><td>0.0</td><td>0.0</td><td>0.5</td></tr><tr><th>7</th><td>0.0</td><td>0.0</td><td>0.0</td><td>3.2</td></tr><tr><th>8</th><td>0.0</td><td>0.0</td><td>0.0</td><td>1.6</td></tr><tr><th>9</th><td>0.0</td><td>0.0</td><td>0.0</td><td>0.2</td></tr><tr><th>10</th><td>0.0</td><td>0.0</td><td>0.0</td><td>0.4</td></tr><tr><th>11</th><td>0.0</td><td>0.0</td><td>0.0</td><td>0.1</td></tr><tr><th>12</th><td>0.0</td><td>0.0</td><td>0.0</td><td>0.0</td></tr><tr><th>13</th><td>0.0</td><td>0.0</td><td>0.0</td><td>0.6</td></tr><tr><th>14</th><td>0.0</td><td>0.0</td><td>0.0</td><td>3.8</td></tr><tr><th>15</th><td>0.0</td><td>0.0</td><td>0.0</td><td>5.9</td></tr><tr><th>16</th><td>0.4</td><td>1.2</td><td>5.8</td><td>15.4</td></tr><tr><th>17</th><td>0.6</td><td>0.2</td><td>32.0</td><td>42.9</td></tr><tr><th>18</th><td>0.0</td><td>0.0</td><td>0.0</td><td>4.1</td></tr><tr><th>19</th><td>2.8</td><td>3.1</td><td>47.1</td><td>68.2</td></tr><tr><th>20</th><td>0.0</td><td>0.0</td><td>2.4</td><td>2.4</td></tr><tr><th>avg err</th><td>0.21</td><td>0.29</td><td>4.55</td><td>7.78</td></tr><tr><th>failed</th><td>0</td><td>0</td><td>3</td><td>5</td></tr></tbody></table>

<table><thead><tr><th colspan="5">Average (<math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> var) over all seeds (for 10 runs)</th></tr></thead><tbody><tr><th rowspan="2">Task id</th><td colspan="2">10K</td><td colspan="2">1K</td></tr><tr><td>train single</td><td>train joint</td><td>train single</td><td>train joint</td></tr><tr><th>1</th><td>0.0 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 0.0</td><td>0.0 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 0.0</td><td>0.2 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 0.3</td><td>0.1 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 0.2</td></tr><tr><th>2</th><td>0.2 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 0.4</td><td>1.7 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 2.6</td><td>3.2 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 4.1</td><td>4.3 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 11.6</td></tr><tr><th>3</th><td>1.8 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 1.8</td><td>4.6 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 7.3</td><td>9.1 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 12.7</td><td>14.3 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 18.1</td></tr><tr><th>4</th><td>0.1 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 0.1</td><td>0.2 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 0.1</td><td>0.3 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 0.3</td><td>0.4 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 0.6</td></tr><tr><th>5</th><td>0.2 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 0.3</td><td>0.8 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 0.5</td><td>1.1 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 1.3</td><td>4.3 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 5.6</td></tr><tr><th>6</th><td>0.1 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 0.2</td><td>0.1 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 0.2</td><td>1.2 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 2.1</td><td>0.8 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 0.4</td></tr><tr><th>7</th><td>0.3 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 0.5</td><td>1.1 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 1.5</td><td>0.0 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 0.0</td><td>4.1 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 2.9</td></tr><tr><th>8</th><td>0.3 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 0.2</td><td>0.5 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 1.1</td><td>0.1 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 0.2</td><td>3.9 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 4.2</td></tr><tr><th>9</th><td>0.0 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 0.0</td><td>0.0 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 0.0</td><td>0.1 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 0.1</td><td>0.3 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 0.3</td></tr><tr><th>10</th><td>0.1 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 0.2</td><td>0.5 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 0.4</td><td>0.7 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 0.8</td><td>1.3 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 1.6</td></tr><tr><th>11</th><td>0.0 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 0.0</td><td>0.1 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 0.1</td><td>0.4 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 0.8</td><td>0.3 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 0.9</td></tr><tr><th>12</th><td>0.2 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 0.1</td><td>0.4 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 0.4</td><td>0.6 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 0.9</td><td>0.3 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 0.4</td></tr><tr><th>13</th><td>0.2 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 0.5</td><td>0.3 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 0.4</td><td>0.8 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 0.9</td><td>1.1 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 0.9</td></tr><tr><th>14</th><td>1.8 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 2.6</td><td>1.3 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 1.6</td><td>0.1 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 0.2</td><td>4.7 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 5.2</td></tr><tr><th>15</th><td>2.1 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 3.4</td><td>1.6 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 2.8</td><td>0.3 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 0.5</td><td>10.3 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 8.6</td></tr><tr><th>16</th><td>1.9 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 2.2</td><td>0.9 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 1.3</td><td>9.1 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 8.1</td><td>34.1 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 22.8</td></tr><tr><th>17</th><td>1.6 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 0.8</td><td>1.4 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 3.4</td><td>43.7 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 18.6</td><td>51.1 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 12.9</td></tr><tr><th>18</th><td>0.3 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 0.4</td><td>0.7 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 1.4</td><td>2.3 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 3.6</td><td>12.8 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 9.0</td></tr><tr><th>19</th><td>3.4 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 4.0</td><td>6.1 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 7.3</td><td>50.2 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 8.4</td><td>73.1 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 23.9</td></tr><tr><th>20</th><td>0.0 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 0.0</td><td>0.0 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 0.0</td><td>3.2 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 2.5</td><td>2.6 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 2.8</td></tr><tr><th>avg</th><td>0.73 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 0.89</td><td>1.12 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 1.62</td><td>6.34 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 3.32</td><td>11.21 <math><semantics><mo>±</mo> <annotation>\scriptstyle\pm</annotation></semantics></math> 6.65</td></tr></tbody></table>

## Appendix F bAbI Attention Visualization

We present a visualization of the attention distributions on bAbI tasks for a couple of examples. The visualization of attention weights is over different time steps based on different heads over all the facts in the story and a question. Different color bars on the left side indicate attention weights based on different heads (4 heads in total).

![Refer to caption](https://ar5iv.labs.arxiv.org/html/1807.03819/assets/figs/babi_ex/e1-step1.png)

Figure 5: Visualization of the attention distributions, when encoding the question: “Where is Mary?”.

![Refer to caption](https://ar5iv.labs.arxiv.org/html/1807.03819/assets/figs/babi_ex/e2-step1.png)

Figure 6: Visualization of the attention distributions, when encoding the question: “Where is the apple?”.

![Refer to caption](https://ar5iv.labs.arxiv.org/html/1807.03819/assets/figs/babi_ex/e3-step1.png)

Figure 7: Visualization of the attention distributions, when encoding the question: “Where is the milk?”.

| An example from tasks 3: | (requiring three supportive facts to solve) |
| --- | --- |
| Story: |  |
| Mary got the milk. |  |
|  | John moved to the bedroom. |
|  | Daniel journeyed to the office. |
|  | John grabbed the apple there. |
|  | John got the football. |
|  | John journeyed to the garden. |
|  | Mary left the milk. |
|  | John left the football. |
|  | Daniel moved to the garden. |
|  | Daniel grabbed the football. |
|  | Mary moved to the hallway. |
|  | Mary went to the kitchen. |
|  | John put down the apple there. |
|  | John picked up the apple. |
|  | Sandra moved to the hallway. |
|  | Daniel left the football there. |
|  | Daniel took the football. |
|  | John travelled to the kitchen. |
|  | Daniel dropped the football. |
|  | John dropped the apple. |
|  | John grabbed the apple. |
|  | John went to the office. |
|  | Sandra went back to the bedroom. |
|  | Sandra took the milk. |
|  | John journeyed to the bathroom. |
|  | John travelled to the office. |
|  | Sandra left the milk. |
|  | Mary went to the bedroom. |
|  | Mary moved to the office. |
|  | John travelled to the hallway. |
|  | Sandra moved to the garden. |
|  | Mary moved to the kitchen. |
|  | Daniel took the football. |
|  | Mary journeyed to the bedroom. |
|  | Mary grabbed the milk there. |
|  | Mary discarded the milk. |
|  | John went to the garden. |
|  | John discarded the apple there. |
| Question: |  |
|  | Where was the apple before the bathroom? |
| Model’s output: |  |
|  | office |

![Refer to caption](https://ar5iv.labs.arxiv.org/html/1807.03819/assets/figs/babi_ex/e4-step1.png)

(a) Step 1

![Refer to caption](https://ar5iv.labs.arxiv.org/html/1807.03819/assets/figs/babi_ex/e4-step3.png)

(a) Step 3

[^1]: Karim Ahmed, Nitish Shirish Keskar, and Richard Socher. Weighted transformer network for machine translation. *arXiv preprint arXiv:1711.02132*, 2017.

[^2]: Jimmy Lei Ba, Jamie Ryan Kiros, and Geoffrey E Hinton. Layer normalization. *arXiv preprint arXiv:1607.06450*, 2016. URL [http://arxiv.org/abs/1607.06450](http://arxiv.org/abs/1607.06450).

[^3]: Dzmitry Bahdanau, Kyunghyun Cho, and Yoshua Bengio. Neural machine translation by jointly learning to align and translate. *CoRR*, abs/1409.0473, 2014. URL [http://arxiv.org/abs/1409.0473](http://arxiv.org/abs/1409.0473).

[^4]: Kyunghyun Cho, Bart van Merrienboer, Caglar Gulcehre, Fethi Bougares, Holger Schwenk, and Yoshua Bengio. Learning phrase representations using RNN encoder-decoder for statistical machine translation. *CoRR*, abs/1406.1078, 2014. URL [http://arxiv.org/abs/1406.1078](http://arxiv.org/abs/1406.1078).

[^5]: Francois Chollet. Xception: Deep learning with depthwise separable convolutions. *arXiv preprint arXiv:1610.02357*, 2016.

[^6]: Zewei Chu, Hai Wang, Kevin Gimpel, and David McAllester. Broad context language modeling as reading comprehension. In *Proceedings of the 15th Conference of the European Chapter of the Association for Computational Linguistics: Volume 2, Short Papers*, volume 2, pp. 52–57, 2017.

[^7]: Bhuwan Dhingra, Zhilin Yang, William W Cohen, and Ruslan Salakhutdinov. Linguistic knowledge as memory for recurrent neural networks. *arXiv preprint arXiv:1703.02620*, 2017.

[^8]: Bhuwan Dhingra, Qiao Jin, Zhilin Yang, William W Cohen, and Ruslan Salakhutdinov. Neural models for reasoning over multiple mentions using coreference. *arXiv preprint arXiv:1804.05922*, 2018.

[^9]: Jonas Gehring, Michael Auli, David Grangier, Denis Yarats, and Yann N. Dauphin. Convolutional sequence to sequence learning. *CoRR*, abs/1705.03122, 2017. URL [http://arxiv.org/abs/1705.03122](http://arxiv.org/abs/1705.03122).

[^10]: Edouard Grave, Armand Joulin, and Nicolas Usunier. Improving neural language models with a continuous cache. *arXiv preprint arXiv:1612.04426*, 2016.

[^11]: Alex Graves. Generating sequences with recurrent neural networks. *CoRR*, abs/1308.0850, 2013. URL [http://arxiv.org/abs/1308.0850](http://arxiv.org/abs/1308.0850).

[^12]: Alex Graves. Adaptive computation time for recurrent neural networks. *arXiv preprint arXiv:1603.08983*, 2016.

[^13]: Alex Graves, Greg Wayne, and Ivo Danihelka. Neural turing machines. *CoRR*, abs/1410.5401, 2014. URL [http://arxiv.org/abs/1410.5401](http://arxiv.org/abs/1410.5401).

[^14]: Caglar Gulcehre, Misha Denil, Mateusz Malinowski, Ali Razavi, Razvan Pascanu, Karl Moritz Hermann, Peter Battaglia, Victor Bapst, David Raposo, Adam Santoro, et al. Hyperbolic attention networks. *arXiv preprint arXiv:1805.09786*, 2018.

[^15]: Mikael Henaff, Jason Weston, Arthur Szlam, Antoine Bordes, and Yann LeCun. Tracking the world state with recurrent entity networks. *arXiv preprint arXiv:1612.03969*, 2016.

[^16]: Sepp Hochreiter, Yoshua Bengio, Paolo Frasconi, and Jürgen Schmidhuber. Gradient flow in recurrent nets: the difficulty of learning long-term dependencies. *A Field Guide to Dynamical Recurrent Neural Networks*, 2003.

[^17]: A. Joulin and T. Mikolov. Inferring algorithmic patterns with stack-augmented recurrent nets. In *Advances in Neural Information Processing Systems, (NIPS)*, 2015.

[^18]: Łukasz Kaiser and Ilya Sutskever. Neural GPUs learn algorithms. In *International Conference on Learning Representations (ICLR)*, 2016. URL [https://arxiv.org/abs/1511.08228](https://arxiv.org/abs/1511.08228).

[^19]: Łukasz Kaiser, Aidan N. Gomez, and Francois Chollet. Depthwise separable convolutions for neural machine translation. *CoRR*, abs/1706.03059, 2017. URL [http://arxiv.org/abs/1706.03059](http://arxiv.org/abs/1706.03059).

[^20]: Ankit Kumar, Ozan Irsoy, Peter Ondruska, Mohit Iyyer, James Bradbury, Ishaan Gulrajani, Victor Zhong, Romain Paulus, and Richard Socher. Ask me anything: Dynamic memory networks for natural language processing. In *International Conference on Machine Learning*, pp. 1378–1387, 2016.

[^21]: Zhouhan Lin, Minwei Feng, Cicero Nogueira dos Santos, Mo Yu, Bing Xiang, Bowen Zhou, and Yoshua Bengio. A structured self-attentive sentence embedding. *arXiv preprint arXiv:1703.03130*, 2017.

[^22]: Tal Linzen, Emmanuel Dupoux, and Yoav Goldberg. Assessing the ability of lstms to learn syntax-sensitive dependencies. *Transactions of the Association of Computational Linguistics*, 4(1):521–535, 2016.

[^23]: Denis Paperno, Germán Kruszewski, Angeliki Lazaridou, Ngoc Quan Pham, Raffaella Bernardi, Sandro Pezzelle, Marco Baroni, Gemma Boleda, and Raquel Fernandez. The lambada dataset: Word prediction requiring a broad discourse context. In *Proceedings of the 54th Annual Meeting of the Association for Computational Linguistics (Volume 1: Long Papers)*, volume 1, pp. 1525–1534, 2016.

[^24]: Ankur Parikh, Oscar Täckström, Dipanjan Das, and Jakob Uszkoreit. A decomposable attention model. In *Empirical Methods in Natural Language Processing*, 2016. URL [https://arxiv.org/pdf/1606.01933.pdf](https://arxiv.org/pdf/1606.01933.pdf).

[^25]: Jack Rae, Jonathan J Hunt, Ivo Danihelka, Timothy Harley, Andrew W Senior, Gregory Wayne, Alex Graves, and Tim Lillicrap. Scaling memory-augmented neural networks with sparse reads and writes. In *Advances in Neural Information Processing Systems*, pp. 3621–3629, 2016.

[^26]: Minjoon Seo, Sewon Min, Ali Farhadi, and Hannaneh Hajishirzi. Query-reduction networks for question answering. *arXiv preprint arXiv:1606.04582*, 2016.

[^27]: Nitish Srivastava, Geoffrey E Hinton, Alex Krizhevsky, Ilya Sutskever, and Ruslan Salakhutdinov. Dropout: a simple way to prevent neural networks from overfitting. *Journal of Machine Learning Research*, 15(1):1929–1958, 2014.

[^28]: Sainbayar Sukhbaatar, arthur szlam, Jason Weston, and Rob Fergus. End-to-end memory networks. In C. Cortes, N. D. Lawrence, D. D. Lee, M. Sugiyama, and R. Garnett (eds.), *Advances in Neural Information Processing Systems 28*, pp. 2440–2448. Curran Associates, Inc., 2015. URL [http://papers.nips.cc/paper/5846-end-to-end-memory-networks.pdf](http://papers.nips.cc/paper/5846-end-to-end-memory-networks.pdf).

[^29]: Ilya Sutskever, Oriol Vinyals, and Quoc V. Le. Sequence to sequence learning with neural networks. In *Advances in Neural Information Processing Systems*, pp. 3104–3112, 2014. URL [http://arxiv.org/abs/1409.3215](http://arxiv.org/abs/1409.3215).

[^30]: Ke Tran, Arianna Bisazza, and Christof Monz. The importance of being recurrent for modeling hierarchical structure. In *Proceedings of NAACL’18*, 2018.

[^31]: Ashish Vaswani, Noam Shazeer, Niki Parmar, Jakob Uszkoreit, Llion Jones, Aidan N. Gomez, Lukasz Kaiser, and Illia Polosukhin. Attention is all you need. *CoRR*, 2017. URL [http://arxiv.org/abs/1706.03762](http://arxiv.org/abs/1706.03762).

[^32]: Ashish Vaswani, Samy Bengio, Eugene Brevdo, Francois Chollet, Aidan N. Gomez, Stephan Gouws, Llion Jones, Łukasz Kaiser, Nal Kalchbrenner, Niki Parmar, Ryan Sepassi, Noam Shazeer, and Jakob Uszkoreit. Tensor2tensor for neural machine translation. *CoRR*, abs/1803.07416, 2018.

[^33]: Jason Weston, Antoine Bordes, Sumit Chopra, Alexander M Rush, Bart van Merriënboer, Armand Joulin, and Tomas Mikolov. Towards ai-complete question answering: A set of prerequisite toy tasks. *arXiv preprint arXiv:1502.05698*, 2015.

[^34]: Dani Yogatama, Yishu Miao, Gabor Melis, Wang Ling, Adhiguna Kuncoro, Chris Dyer, and Phil Blunsom. Memory architectures in recurrent neural network language models. In *International Conference on Learning Representations*, 2018. URL [https://openreview.net/forum?id=SkFqf0lAZ](https://openreview.net/forum?id=SkFqf0lAZ).

[^35]: Wojciech Zaremba and Ilya Sutskever. Learning to execute. *CoRR*, abs/1410.4615, 2015. URL [http://arxiv.org/abs/1410.4615](http://arxiv.org/abs/1410.4615).