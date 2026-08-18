---
title: "Emergent Linear Representations in World Models of Self-Supervised Sequence Models"
source: "https://ar5iv.labs.arxiv.org/html/2309.00941"
author:
published:
created: 2026-07-09
description: "How do sequence models represent their decision-making process?Prior work suggests that Othello-playing neural network learned nonlinear models of the board state (Li et al., 2023a).In this work, we provide evidence …"
tags:
  - "clippings"
---
Neel Nanda <sup>∗</sup>  
Independent &Andrew Lee <sup>∗</sup>  
University of Michigan &Martin Wattenberg  
Harvard University

###### Abstract

How do sequence models represent their decision-making process? Prior work suggests that Othello-playing neural network learned nonlinear models of the board state [^22]. In this work, we provide evidence of a closely related linear representation of the board. In particular, we show that probing for “my colour” vs. “opponent’s colour” may be a simple yet powerful way to interpret the model’s internal state. This precise understanding of the internal representations allows us to control the model’s behaviour with simple vector arithmetic. Linear representations enable significant interpretability progress, which we demonstrate with further exploration of how the world model is computed.<sup>1</sup>

<sup>*</sup>

## 1 Introduction

How do sequence models represent their decision-making process? Large language models are capable of unprecedented feats, yet largely remain inscrutable black boxes. Yet evidence has accumulated that models act as feature extractors: identifying increasingly complex properties of the input and representing these in the internal activations [^13] [^3] [^16] [^4] [^7] [^15] [^10]. A key first step for interpreting them is understanding how these features are represented. [^32] introduce the linear representation hypothesis: that features are represented linearly as directions in activation space. This would be highly consequential if true, yet this remains controversial and without conclusive empirical justification. In this work, we present novel evidence of linear representations, and show that this hypothesis has real predictive power.

We build on the work of [^22], who demonstrate the emergence of a *world model* in sequence models. Namely, the authors train OthelloGPT, an autoregressive transformer model, to predict legal moves in a game of Othello given a sequence of prior moves (Section 2.2). They show that the model spontaneously learns to track the correct board state, recovered using *non-linear* probes, despite never being told that the board exists. They further show a causal relationship between the model’s inner board state and its move predictions using model edits. Namely, they show that the edited network plays moves that are legal in the edited board state even if illegal in the original board, and even if the edited board state is unreachable by legal play (i.e., out of distribution).

![Refer to caption](https://ar5iv.labs.arxiv.org/html/2309.00941/assets/x1.png)

Figure 1: The emergent world models of OthelloGPT are linearly represented. We find that the board states are encoded relative to the current player’s colour ( Mine vs. Yours ) as opposed to absolute colours ( Black White ).

Critically, the original authors claim that OthelloGPT uses *non-linear* representations to encode the board state, by achieving high accuracy with non-linear probes, but failing to do so using linear probes. In our work, we demonstrate that a closely related world model is actually *linearly* encoded. Our key insight is that rather than encoding the *colours* of the board (Black, White, Empty), the sequence model encodes the board *relative* to the current player of each timestep (Mine, Yours, Empty). In other words, for odd timesteps, the model considers Black tiles as Mine and White tiles as Yours, and vice versa for even timesteps (Section 3). Using this insight, we demonstrate that a *linear* projection can be learned with near perfect accuracy to derive the board state.

We further demonstrate that we can steer the sequence model’s predictions by simply conducting vectoral arithmetics using our linear vectors (Section 4). Put differently, by pushing the model’s activations in the directions of Mine, Yours, or Empty, we can alter the model’s belief state of the board, and change its predictions accordingly. Our intervention method is much simpler and interpretable than that of [^22], which rely on gradients to update the model’s activations (Section 4.1). Our results confirm that our interpretation of each probe direction is correct, but also demonstrates that a mechanistic understanding of model representations can lead to better control. Our results do not contradict that of [^22], but add to our understanding of emergent world models.

We provide additional interpretations of the sequence model using linear operations. For example, we provide empirical evidence of how the model derives empty tiles of the board, and find additional linear representations, such as tiles being Flipped at each timestep.

Finally, we provide a short discussion of our thoughts. How should we think of linear versus non-linear representations? Perhaps most interestingly, why do linear representations emerge?

## 2 Preliminaries

In this section we briefly describe Othello, OthelloGPT, and our notations.

### 2.1 Othello

Othello is a two player game played on a 8x8 grid. Players take turns playing black or white discs on the board, and the objective is to have the majority of one’s coloured discs by the end of the game.

At each turn, when a tile is played, all of the opponent’s discs that are enclosed in a horizontal, vertical, or diagonal row between two discs of the current player are flipped. The game ends when there are no more valid moves for both players.

### 2.2 OthelloGPT

OthelloGPT is a 8-layer GPT model [^40], each layer consisting of 8 attention heads and a 512-dimensional hidden space. We use the model weights provided by [^22], denoted there as the synthetic model. The vocabulary space consists of 60 tokens, each one corresponding to a playable move on the board (e.g., A4).<sup>2</sup>

The model is trained in an autoregressive manner, meaning for a given sequence of moves $m_{<t}$, the model must predict the next valid move $m_{t}$.

Note that no a priori knowledge of the game nor its rules are provided to the model. Rather, the model is only given move sequences with a training objective to predict next valid moves. Further note that these valid moves are uniformly chosen, and this training objective differs from that of models like AlphaZero [^43], which are trained to play strategic moves to win games.

<table><tbody><tr><td></td><th><math><semantics><msup><mi>x</mi> <mn>0</mn></msup> <apply><csymbol>superscript</csymbol> <ci>𝑥</ci> <cn>0</cn></apply> <annotation>x^{0}</annotation></semantics></math></th><th><math><semantics><msup><mi>x</mi> <mn>1</mn></msup> <apply><csymbol>superscript</csymbol> <ci>𝑥</ci> <cn>1</cn></apply> <annotation>x^{1}</annotation></semantics></math></th><th><math><semantics><msup><mi>x</mi> <mn>2</mn></msup> <apply><csymbol>superscript</csymbol> <ci>𝑥</ci> <cn>2</cn></apply> <annotation>x^{2}</annotation></semantics></math></th><th><math><semantics><msup><mi>x</mi> <mn>3</mn></msup> <apply><csymbol>superscript</csymbol> <ci>𝑥</ci> <cn>3</cn></apply> <annotation>x^{3}</annotation></semantics></math></th><th><math><semantics><msup><mi>x</mi> <mn>4</mn></msup> <apply><csymbol>superscript</csymbol> <ci>𝑥</ci> <cn>4</cn></apply> <annotation>x^{4}</annotation></semantics></math></th><th><math><semantics><msup><mi>x</mi> <mn>5</mn></msup> <apply><csymbol>superscript</csymbol> <ci>𝑥</ci> <cn>5</cn></apply> <annotation>x^{5}</annotation></semantics></math></th><th><math><semantics><msup><mi>x</mi> <mn>6</mn></msup> <apply><csymbol>superscript</csymbol> <ci>𝑥</ci> <cn>6</cn></apply> <annotation>x^{6}</annotation></semantics></math></th><th><math><semantics><msup><mi>x</mi> <mn>7</mn></msup> <apply><csymbol>superscript</csymbol> <ci>𝑥</ci> <cn>7</cn></apply> <annotation>x^{7}</annotation></semantics></math></th></tr><tr><td>Randomized</td><td>37</td><td>35.1</td><td>33.9</td><td>35.5</td><td>34.8</td><td>34.7</td><td>34.4</td><td>34.5</td></tr><tr><td>Probabilistic</td><td colspan="8">61.8</td></tr><tr><td>Linear {Black, White, Empty}</td><td>62.2</td><td>74.8</td><td>74.9</td><td>75.0</td><td>75.0</td><td>74.9</td><td>74.8</td><td>74.4</td></tr><tr><td>Non-Linear {Black, White, Empty}</td><td>63.4</td><td>88.6</td><td>93.3</td><td>96.3</td><td>97.5</td><td>98.3</td><td>98.7</td><td>98.3</td></tr><tr><td>Linear {Mine, Yours, Empty}</td><td>90.9</td><td>94.8</td><td>97.2</td><td>98.3</td><td>99</td><td>99.4</td><td>99.6</td><td>99.5</td></tr></tbody></table>

Table 1: Probing accuracy for board states. OthelloGPT linearly encodes the board state relative to the current player at each timestep (Mine vs. Yours, as opposed to colours Black or White.

### 2.3 Notations

#### Transformers.

Our transformer architecture [^48] consists of embedding and unembedding layers $Emb$ and $Unemb$ with a series of $L$ transformer layers in-between. Each transformer layer $l$ consists of $H$ multi-head attentions and a multilayer perception (MLP) layer.

A forward pass in the model first embeds the input token at timestep $t$ using embedding layer $Emb$ into a high dimensional space $x_{t}^{0}\in\mathbb{R}^{D}$. We refer to $x_{t\in T}^{0}$ as the start of the *residual stream*. Then each attention head $Att_{l}^{h},\forall h\in H$ and MLP block at layer $l$ add to the residual stream:

$$
\displaystyle x_{t}^{l\_mid}=x_{t}^{l}+\sum_{h\in H}Att_{l}^{h}(x_{t}^{l})
$$
 
$$
\displaystyle x_{t}^{l+1}=x_{t}^{l\_mid}+MLP_{l}(x_{t}^{l\_mid})
$$

Each attention head $Att^{h}_{l}$ computes value vectors by projecting the residual stream to a lower dimension using $Att^{h}_{l}.V$, linearly combines value vectors using $Att^{h}_{l}.A$, and projects back to the residual stream using $Att^{h}_{l}.O$:

$$
\displaystyle h(x)=(Attn^{h}_{l}.A\otimes Attn^{h}_{l}.O*Attn^{h}_{l}.V)*x
$$

A final prediction is made by applying $Unemb$ on $x^{L-1}$, followed by a softmax.

#### Probe Models.

We notate linear and non-linear probes as $p^{\lambda}$ and $p^{\nu}$. Our linear probes are simple linear projections from the residual stream: $p^{\lambda}(x_{t}^{l})=\text{softmax}(Wx_{t}^{l}),W\in\mathbb{R}^{D\times 3}$. The dimension $D\times 3$ comes from doing a 3-way classification.<sup>3</sup> Non-linear probes are 2-layer MLP models: $p^{\nu}(x_{t}^{l})=\text{softmax}(W_{1}\text{ReLU}(W_{2}x_{t}^{l}))$, $W_{1}\in\mathbb{R}^{H\times 3},W_{2}\in\mathbb{R}^{D\times H}$. [^22] classify the colour at each tile (Black, White, Empty). Our insight is to classify the colours *relative* to the current turn’s player (Mine, Yours, Empty).

## 3 Linearly Encoded Board States

In this section we describe our experiments to find linear board state representations.

### 3.1 Experiment Setup

Rather than encoding the colour of each tile (Black, White, Empty), OthelloGPT encodes each tile *relative* to the player of each timestep (Mine, Yours, Empty) — for *odd* timesteps, we consider Black to be Mine and White to be Yours, and vice versa for *even* timesteps.

In order to learn the weights of our linear probe, we train on 3,500,000 game sequences. We use a validation set of 512 games, and train until our validation loss converges according to a patience value of 10. In practice, our linear probes converge after around 100,000 training samples. We test our probes on a held out set of 1,000 games.

We train a different probe for each layer $l$. Hyperparameters are provided in the Appendix.

### 3.2 Results

Table 1 shows the accuracy for various probes.

We include four baselines. The first is a linear probe trained on a randomly initialized GPT model. We also include a probabilistic baseline, in which we always choose the most likely colour per tile at each timestep, according to a set of 60,000 games from training data. The next two baselines are probe models used in [^22]: a linear and non-linear probe trained to classify amongst {Black, White, Empty}.

Our linear probes achieve high accuracy by layer 4. Unbeknownst previously, we show that the emerged board state is linearly encoded.

![Refer to caption](https://ar5iv.labs.arxiv.org/html/2309.00941/assets/x2.png)

Figure 2: Intervening methodology: we intervene by adding either Empty, Mine, or Yours directions into each layer of the residual stream. Red squares in each board indicate the tiles that have been intervened, teal tiles indicate new legal moves post-intervention that the model predicts.

## 4 Intervening with Linear Directions

In this section we demonstrate how we intervene on OthelloGPT’s board state using linear probes.

### 4.1 Method

An inherent issue with probing is that it is correlational, not causal [^5]. To validate that our probes have found a true world model, we confirm that the model uses the encoded board state for its predictions.

To verify this, we conduct the same intervention experiment as [^22]. Namely, given an input game sequence (and its corresponding board state $B$), we intervene to make the model believe in an altered board state $B^{\prime}$. We then observe whether the model’s prediction reflects the made-believe board state $B^{\prime}$ or the original board state $B$.

Our intervention approach is simple: we add our linear vectors to the residual stream of each layer:

$$
\displaystyle x^{\prime}\leftarrow x+\alpha p^{\lambda}_{d}(x)
$$

where $d$ indicates a direction amongst {Mine, Yours, Empty} and $\alpha$ is a scaling factor. In other words, to flip a tile from Yours to Mine, we simply push the residual stream at every layer in the Mine direction, or to “erase” a previously played tile, we push in the Empty direction. <sup>4</sup> <sup>5</sup>

Note that this intervention is much simpler than that of [^22]. Namely, [^22] edits the activation space ($x$) of OthelloGPT using several iterations of gradient descent from their non-linear probe. Instead, we perform a single vector addition.

### 4.2 Experiment Setup

For our intervention experiment, we adopt the same setup and metrics as [^22]. We use an evaluation benchmark consisting of 1,000 test cases. Each test case consists of a partial game sequence ($B$) and a targeted board state $B^{\prime}$.

We measure the efficacy of our intervention by treating the task as a multi-label classification problem. Namely, we compare the top- $N$ predictions post-intervention against the groundtruth set of legal moves at state $B^{\prime}$, where $N$ is the number of legal moves at $B^{\prime}$. We then compute error rate, or the number of false positives and false negatives.

[^22] only considers the scenario of flipping the colour of a tile. To also validate our Empty direction, we also experiment with “erasing” a previously played tile by making it empty.

| Flipping colours | Avg. # Errors |
| --- | --- |
| Null Intervention Baseline | 2.723 |
| Non-Linear Intervention | 0.12 |
| Linear Probe Addition | 0.10 |
| Erasing | Avg. # Errors |
| Null Intervention | 2.73 |
| Non-Linear Intervention | 0.11 |
| Linear Probe Addition | 0.02 |

Table 2: Error rates from interventions.

### 4.3 Results

Table 2 shows the average error rates after our interventions. Our interventions are equally effective as that of gradient-based editing, and confirms that our interpretation of each linear direction matches how the model uses such directions.

## 5 Additional Linear Interpretations

The linear representation hypothesis is of interest to the mechanistic interpretability community because it provides a foothold into understanding a system. The internal state of the transformer, the residual stream, is the sum of the outputs of all previous components (heads, layers, embeddings and neurons) [^12], so any linear function of the residual stream can be linearly decomposed into contributions from each component, allowing us to trace back where a computation is coming from.

In this section we leverage our newfound linear representation of board state to provide additional interpretations of OthelloGPT, as proof of concept of how discovering linear representations unlocks downstream interpretability applications.

### 5.1 Interpreting Empty Tiles

Here we interpret how OthelloGPT derives the status of empty tiles.

#### The Empty Circuit.

A key insight for Empty is that input tokens each correspond to a tile on the board (i.e., A4), and once played, the tile can only change colour but remains non-empty.

We view OthelloGPT as using attention heads to “broadcast” which moves have been played: given a move at timestep $t$, attention heads write this information into other residual streams. This information (Played) can be represented as following. First, each move $m$ (A4) is embedded: $Emb[m]$. Then the model writes this information to other residual streams using linear projections $Att.V$ and $Att.O$ (Section 2.3):

$$
\displaystyle\textsc{Played}_{h}(m)=Emb[m]@Att_{h}.V@Att_{h}.O
$$

For each attention head in the first layer,<sup>6</sup> we compute the cosine similarity between Played and the $p^{\lambda}_{\textsc{empty}}$ direction:

$$
\displaystyle\max_{h\in H}\text{CosSim}(\textsc{Played}_{h}(m),p^{\lambda}_{\textsc{empty}}(m))
$$

Since the two terms encode *opposite* information, we expect a high negative cosine similarity.

We observe an average similarity score of -0.862 across all 60 squares,<sup>7</sup>, confirming that $p_{\textsc{Empty}}$ is encoding Not Played. This tells us that $p_{\textsc{Empty}}$ is a linear function of the token embeddings.

This also implies that OthelloGPT knows which tiles are empty by $x^{0\_mid}$: after the first attention heads but before the MLP layer. On a binary classification task of Empty vs. Not-Empty from 1,000 games in our test split, our probe achieves an accuracy of 76.8% and 98.9%, when projecting from $X^{0\_pre}$ and $x^{0\_mid}$ respectively.

![Refer to caption](https://ar5iv.labs.arxiv.org/html/2309.00941/assets/figures/empty_logit_attribute.png)

Figure 3: Difference in probability of A4 being empty, between our clean and corrupt sequences, measured in each attention head.

![Refer to caption](https://ar5iv.labs.arxiv.org/html/2309.00941/assets/figures/attention_pattern_main.png)

Figure 4: Examples of attention heads attending to Your (left) or My (right) moves.

|  | $x^{0}$ | $x^{1}$ | $x^{2}$ | $x^{3}$ | $x^{4}$ | $x^{5}$ | $x^{6}$ | $x^{7}$ |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Linear {Flipped, Not-Flipped} | 74.76 | 85.75 | 91.62 | 94.82 | 96.44 | 97.13 | 96.82 | 96.3 |

Table 3: $F1$ score for probing on Flipped tiles. In addition to the board state, the model also linearly encodes concepts such as flipped tiles per timestep.

#### Logit Attribute for Empty.

The previous analysis is based on the *weights* of the model. Here we provide an alternative analysis by studying the *activations* during inference.

First, we select a move $m$ (A4) that we wish to explain. We then construct a “clean” and “corrupt” set of partial game sequences (N=4,569). Our clean set always includes $m$, while our corrupt set replaces all timesteps with $m$ in the clean set with an alternative move. We ensure that all games in our corrupt set remain legal sequences. Finally, we study the *difference in probability* that $m$ is empty, according to our probes, in our two sets. Namely, we project the outputs from each attention head onto the Empty direction and apply a softmax:

$$
\displaystyle P_{\textsc{Empty}[m]}(\sigma)=Softmax(\sigma*p^{\lambda}_{\textsc{Empty}[m]})
$$

where $\sigma$ is the output from each attention head.

Figure 3 shows the difference in probability that A4 is empty, between our clean and corrupt inputs, measured in each attention head of the first layer. The figure decomposes two scenarios: when A4 was originally played by Me or You. This is because some attention heads only attend to My moves (4, 7), while some only attend to Yours (1, 3, 8), which we show below.

![Refer to caption](https://ar5iv.labs.arxiv.org/html/2309.00941/assets/x3.png)

Figure 5: Proportion of times the board state is computed before/after move predictions are made (First y-axis). Light Grey: Boards are computed in an earlier layer than moves. Dark Grey, Black: Boards are computed in the same or later layer than moves. Red: Model never computes the correct board state. Aqua, Lime (Curves): Average earliest layer in which the board or moves are correctly computed (Second y-axis). Starting from the mid-game, we start observing the model compute moves before boards (black bar), and this occurs more frequently as the game progresses.

### 5.2 Attending to My & Your Timesteps

We find that some attention heads only attend to either My or Your moves. Figure 4 shows two examples: at each timestep, each head *alternates* between attending to even or odd timesteps. Such behavior further indicates how the model computes its world model based on Mine and Yours as opposed to Black and White.

### 5.3 Additional Linear Concepts: Flipped

In addition to linearly representing the board state, we find that OthelloGPT also encodes which tiles are being flipped, or captured, at each timestep. To test this, we modify our probing task to classify between Flipped vs. Not-Flipped, with the same training setup described above. Given the class imbalance, for this experiment we report $F1$ scores. Table 3 demonstrates high $F1$ scores by layer 3.

We also conduct a modified version of our intervention experiment, in which we always randomly select a flipped tile at the current timestep to intervene on. Then, instead of adding either $p^{\lambda}_{\textsc{Mine}}$, $p^{\lambda}_{\textsc{Yours}}$, or $p^{\lambda}_{\textsc{Empty}}$, we *subtract* $p^{\lambda}_{\textsc{Flipped}}$. This tests whether the Flipped feature is causally relevant for computing the next move, by exploring whether this is sufficient to cause the model to play valid moves in the new board state. We get an average error rate of 0.486, compared to a null intervention baseline rate of 1.686.

One can consider Flipped tiles as the difference between the previous and current board state. One might naturally think that a recurrent computation could derive the current board state by iteratively applying such differences. However, transformer models do not make recursive computations!<sup>8</sup> We view Flipped to be both an unexpected encoding and a hint for the rest of the board circuit.

### 5.4 Multiple Circuits Hypothesis

Although we find a board state circuit and its causality on move predictions, we find that it does not explain the entire model. If our understanding is correct, we expect the model to compute the board state before computing valid moves. However, we find that in end games, this is not the case.

To check for the correct board state, we apply our linear probes on each layer, and check the earliest layer in which all 64 tiles are correctly predicted.<sup>9</sup> To check for correct move predictions, we project from each layer using the unembedding layer, and check the earliest layer in which the top-N move predictions are all correct, where N is the number of groundtruth legal moves.

Figure 5 plots the proportion of times the board state is computed before (or after) valid moves (first y-axis). We also overlay the average earliest layer in which board or moves are correctly computed (second y-axis, aqua and lime curves). To our surprise, we find that in end games, the model often computes legal moves *before* the board state (black bars). We henceforth refer to this behavior as MoveFirst, and share some thoughts.

#### End Game Circuits.

First, MoveFirst starts to occur around move 30, which is the mid-point of the game. Second, MoveFirst occurs more frequently as we near the end of the game (increasing black bars). Interestingly, in Othello, starting from the mid-point, there are progressively fewer empty tiles than there are filled tiles as the board fills up. Also note that as the game progresses, it becomes more likely for every empty tile to be a legal move.

One possible explanation for this phenomenon is that in the end game, it may be possible to predict legal moves with simpler circuits that do not require the entire board state. For instance, perhaps it combines Empty with other features such as Is-Surrounded-By-Mine or Is-Border and so on.

#### Multiple Circuits.

Interestingly, the model still uses the board circuit at end games. To demonstrate this, we run our intervention experiment on 1,000 *end games*,<sup>10</sup> and still achieve a low error rate of 0.112.<sup>11</sup> We thus hypothesize that OthelloGPT (and more broadly, sequence models) consist of multiple circuits. Another hypothesis is that residual networks make “iterative inferences” (Section 5.5), and for end games, OthelloGPT uses simpler circuits in the early layers and refines its predictions at late layers using board state.

#### End Game Board Accuracy.

We observe that board state accuracy drops near end games. This can be seen by the growing red bars, but also by measuring per-timestep accuracy of our probes (see Appendix). It is unclear whether 1) the model does not bother to compute the perfect board state, as alternative circuits allow the model to still correctly predict legal moves, or 2) the model learns an alternative circuit because it struggles to compute the correct board state at end games.

#### Memorization.

Note that in the first few timesteps, the board and legal moves are sometimes both computed in the same layer (dark grey bars). This may be due to memorization: 1) these predictions both occur at the first layer, and 2) there are only so many openings in an Othello game.

![Refer to caption](https://ar5iv.labs.arxiv.org/html/2309.00941/assets/x4.png)

Figure 6: Iterative refinements: the top row shows each layer projected using our linear probes. The bottom row shows the model’s predictions for legal moves at each layer, by applying the unembedding layer on each layer.

### 5.5 Iterative Feature Refinements

Figure 6 visualizes OthelloGPT’s “iterative inference” [^20] [^6] [^49] [^35], or iterative refinement of features. For each layer, we plot the projected board states using our probes, and projected next-move predictions using the unembedding layer. Multiple evidence of iterative refinements are provided in the Appendix.

## 6 Discussions

### 6.1 On Linear vs. Non-Linear Interpretations

One challenge with probing is knowing which features to look for.<sup>12</sup> For instance, classifying {Black, White} versus {Mine, Yours} leads to different takeaways, which illustrates the danger of *projecting our preconceptions*. What might seem “sensible” to a human interpreter (Black, White) may not be for a model.<sup>13</sup>

More broadly, what is “sensible”, or alternatively, how we choose to interpret linear or non-linear encodings, can be relative to how we see the world. Suppose we had a perfect world model of our physical world. Further suppose that if and when it computes a gravitational force between two objects (Newton’s law), we discover a neuron whose square root was the distance between two objects. Is this a non-linear representation of distance? Or, given the form of Netwon’s law, is the square of the distance a more natural way for the model to represent the feature, and thus considered a linear representation? As this example shows, what constitutes a natural feature may be in the eye of the beholder.

### 6.2 On the Emergence of Linear Representations

Linear representations in sequence models have been observed before: iGPT [^8], which was autoregressively trained to predict next pixels of images, lead to robust linear image representations. The question remains, why do linear feature representations emerge? What linear representations are currently encoded in large language models? One reason might be simply that matrix multiplication can easily extract a different subset of linear features for each neuron. However, we leave a complete explanation to future work.

## 7 Related Work

We discuss three broad related areas: understanding internal representations, interventions, and mechanistic interpretability.

### 7.1 Understanding Internal Representations

Multiple researchers have studied world representations in sequence models. [^21] train sequence models on a synthetic task, and uncover world models in their activations. [^37] demonstrate that language models can learn to ground concepts (e.g., direction, colour) to real world representations. [^7] find linear vectors that encode “truthfulness”.

Many studies also build or study linear representations for language. Word embeddings [^31] [^30] build vectoral word representations. Linear probes have also been used to extract linguistic characteristics in sentence embeddings [^9] [^45].

Linear representations are found outside of language models as well. [^29] demonstrate that image representations from vision models can be linearly projected into the input space of language models. [^25] and [^24] find interpretable representations of chess or Hex concepts in AlphaZero.

### 7.2 Intervening On Language Models

A growing body of work has intervened on language models, by which we mean controlling their behavior by altering their activations.

We consider two broad categories. Parametric approaches often use optimizations (i.e. gradient descent) to locate and alter activations [^22] [^27] [^28] [^18] [^17]. Meanwhile, inference-time interventions typically apply linear arithmetics, for instance by using “truthful” vectors [^23], “task vectors” [^19], or other “steering vectors” [^44] [^47].

### 7.3 Mechanistic Interpretability

Mechanistic interpretability (MI) studies neural networks by reverse-engineering their behavior [^36] [^12]. The goal of MI is to understand the underlying computations and representations of a model, with a broader goal of validating that their behavior aligns with what researchers have intended. Such framework has allowed researchers to understand grokking [^34], superposition [^11] [^42] [^2], or to study individual neurons [^33] [^1] [^16].

## 8 Conclusion

In this work we demonstrated that the emergent world model in Othello-playing sequence models is full of linear representations. Previously unbeknownst, we demonstrated that the board state in OthelloGPT is linearly represented by encoding the colour of each tile *relative* to the player at each timestep (Mine, Yours, Empty) as opposed to absolute colour (Black, White, Empty). We showed that we can accurately control the model’s behaviour with simple vector arithmetic on the internal world model. Lastly, we mechanistically interpreted multiple facets of the sequence model, analysing how empty tiles are detected, and linear representations of which pieces are flipped. We find hints that multiple circuits might exist for predicting legal moves in the end game, as well as further evidence that residual networks iteratively refine their features across layers.
