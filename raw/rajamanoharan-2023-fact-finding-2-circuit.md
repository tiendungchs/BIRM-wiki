---
title: "Fact Finding: Simplifying the Circuit (Post 2) — AI Alignment Forum"
source: "https://www.alignmentforum.org/s/hpWHhjvjn67LJ4xXX/p/3tqJ65kuTkBh8wrRH"
author:
  - "[[Senthooran Rajamanoharan]]"
  - "[[Neel Nanda]]"
  - "[[János Kramár]]"
  - "[[Rohin Shah]]"
published: 2023-12-23
created: 2026-07-01
description: "This is the second post in the Google DeepMind mechanistic interpretability team’s investigation into how language models recall facts. This post foc…"
tags:
  - "clippings"
---
*This is the second post in the Google DeepMind mechanistic interpretability team’s. This post focuses on distilling down the fact recall circuit and models a more standard mechanistic interpretability investigation. This post gets in the weeds, **we recommend starting with [post one](https://www.alignmentforum.org/posts/iGuwZTHWb6DFY3sKB/fact-finding-attempting-to-reverse-engineer-factual-recall)** and then skimming and skipping around the rest of the sequence according to what’s most relevant to you. We assume readers of this post are familiar with the mechanistic interpretability techniques listed [in this glossary](https://www.neelnanda.io/mechanistic-interpretability/glossary#mechanistic-interpretability-techniques).*

## Introduction

Our goal was to understand how facts are stored and recalled in superposition. A necessary step is to find a narrow task involving factual recall and understand the high level circuit that enables a model to do this task.

We focussed on the narrow task of recalling the sports played by different athletes. As discussed in [post 1](https://www.alignmentforum.org/posts/iGuwZTHWb6DFY3sKB/fact-finding-attempting-to-reverse-engineer-factual-recall#Why_Facts), we particularly expected facts about people to involve superposition, because the embeddings of individual name tokens is normally insufficient to determine the sport, so the model must be doing a boolean AND on the different tokens of the name to identify an athlete and look up their sport. [Prior](https://transformer-circuits.pub/2022/solu/index.html) [work](https://arxiv.org/abs/2305.01610) calls this phenomenon ‘detokenisation’ and suggests it involves early MLP layers, and uses significant superposition.

Why focus on athletes’ sports rather than factual recall in general? We believe that in mechanistic interpretability, it’s often useful to first understand a narrow instance of a phenomenon deeply, rather than insisting on being fully general. Athletes’ sports was a nice task that gave us lots of examples per attribute value, and our goal was to understand at least one example where superposition was used for factual recall, rather than explaining factual recall in general. We conjecture that similar mechanisms are used for recalling other classes of fact, but this wasn’t a focus of our work.

## Set-up

To understand fact localisation, we studied [Pythia](https://arxiv.org/abs/2304.01373) 2.8B’s next token predictions and activations for one-shot prompts of the form:

For 1,500 athletes playing the sports of baseball, basketball and (American) football. To choose these athletes, we gave the model a larger dataset of athletes from Wikidata and filtered for those where the model placed more than 50% probability on the correct sport <sup><sup id="fnref:1"><a href="#fn:1">1</a></sup></sup>.

We chose Pythia 2.8B as it’s the smallest model that could competently complete this task for a large number of athletes.

We made the prompts one-shot because this significantly improved the model’s performance on the task <sup><sup id="fnref:2"><a href="#fn:2">2</a></sup></sup>. We chose golf for the one shot prefix so that the model didn’t have a bias towards one of the three sports it needed to predict. For simplicity, we didn’t vary the one shot prefix across the prompts.

## The simplified circuit that we ended up with

Before going in detail through the ablation studies we performed to derive the circuit, let’s take a look at the simplified circuit we ended up with:

![](https://res.cloudinary.com/lesswrong-2-0/image/upload/f_auto,q_auto/v1/mirroredImages/3tqJ65kuTkBh8wrRH/zwrgezridkrafez2lmmv)

Where:

- `concatenate_tokens` performs something roughly like a weighted sum of the individual token embeddings, placing each token’s embedding in a different subspace, implemented by the first two layers of the model;<sup><sup id="fnref:3"><a href="#fn:3">3</a></sup></sup>
- `lookup` is a five layer MLP (whose layers match MLP layers 2 to 6 in the original model) <sup><sup id="fnref:4"><a href="#fn:4">4</a></sup></sup> that processes the combined tokens to produce a new representation of the entity described by those tokens, where this representation can be linearly projected to reveal various attributes about the entity (including the sport they play);
	- We note that in the path from layer 6 to layer 15 there seem to be multiple MLP layers that matter, but we believe them to mostly be signal boosting an existing linear representation of the sport, and ablating them does not significantly affect accuracy.
- `extract_sport` is a linear classifier that performs an affine transformation on the representation generated by `lookup` to extract the sport logits that are returned by the model. This is implemented in the model by several attention heads (notably including L16H20) which attend from the final token to the final name token and directly compose with the unembedding layer <sup><sup id="fnref:5"><a href="#fn:5">5</a></sup></sup>. In the special case of athletes whose names only consist of two tokens (one for the first name, one for the last name), we were able to further simplify the `concatenate_tokens` function to be of the form:

![](https://res.cloudinary.com/lesswrong-2-0/image/upload/f_auto,q_auto/v1/mirroredImages/3tqJ65kuTkBh8wrRH/jaxnaennpshoncgl2x6a)

Where `embed_first` and `embed_last` are literally lookup tables (with one entry per token in the model’s vocabulary) with disjoint ranges (so that the encoder can distinguish “Duncan” the first name from “Duncan” the surname) – reinforcing the idea that the result of `concatenate_tokens` is only as linearly informative as the individual tokens (plus positional information) themselves – i.e. it is a dense / compressed representation of a related sequence of tokens that the model needs to decompress / extract linear features from in order to be usable by downstream circuits (such as `extract_sport`).<sup><sup id="fnref:6"><a href="#fn:6">6</a></sup></sup>

This is fairly consistent with prior work in the literature, notably [Geva et al](https://arxiv.org/pdf/2304.14767.pdf). We see our narrow, bottom-up approach as complementing their broader and more top down approach to understanding the circuit. We further show that `extract_sport` is a linear map, mirroring [Hernandez et al](https://arxiv.org/abs/2308.09124), and that it can be understood in terms of the OV circuit of individual attention heads. We see our contribution as refining existing knowledge with a more bottom up and circuits focused approach in a narrow domain, and better understanding the model’s representations at each stage, rather than as being a substantially new advance.

In the remainder of this post, we describe in further detail the experiments we performed to derive this simplified circuit.

## Investigation 1: Understanding fact extraction

When the model outputs the correct sport token to complete the prompt, where is the earliest token at which the sport was determined? Prior work suggests that the correct sport should be identified early on in the sequence (at the athlete’s final name token) and placed in a linearly recoverable representation. A separate fact extraction circuit (`extract_sport` in the circuit diagram above) would then read the sport from the final name position and output the correct logits to complete the prompt.

In this section, we describe the experiments we performed to verify that this picture holds in reality and to identify the circuit that implements this fact extraction step.

### Which nodes contribute most to the output logits?

We started off by identifying which nodes in the model have the greatest direct influence on the logits produced at the final token. We did this by individually ablating the activations for each MLP layer and attention head output at the final token position and measuring the direct effect on the output logits.

Specifically, for each clean prompt and each node we wished to ablate, we would take activations for that node from a “corrupted” prompt and patch these into the activations for the clean prompt just along the patch connecting that node to the model’s unembedding layer, in order to measure the effect of this path patch on the model’s outputs. For the corrupted prompt, we would randomly pick a prompt for an athlete who plays a different sport.<sup><sup id="fnref:7"><a href="#fn:7">7</a></sup></sup> To measure the direct effect, we would compare the logit difference between the clean prompt’s sport and corrupt prompt’s sport, before and after path patching.<sup><sup id="fnref:8"><a href="#fn:8">8</a></sup></sup> The results are as follows:

![](https://res.cloudinary.com/lesswrong-2-0/image/upload/f_auto,q_auto/v1/mirroredImages/3tqJ65kuTkBh8wrRH/m0prshu8u9zcnimo4fr6)

These results show that a relatively sparse set of nodes have any meaningful effect on the logits:

- A handful of attention heads in the mid-layers;
- The MLP layers that follow these attention heads.

Of these, the attention heads are particularly interesting: since we have measured direct (not total) effect, we know that the outputs of these attention heads are directly nudging the final tokens logits towards the correct sport (or away from incorrect sports), without the need for further post-processing.<sup><sup id="fnref:9"><a href="#fn:9">9</a></sup></sup> This strongly suggests that, wherever these heads are attending to, the residual stream at those locations already encodes each athlete’s sport.

### To where do these high-effect heads attend?

![](https://res.cloudinary.com/lesswrong-2-0/image/upload/f_auto,q_auto/v1/mirroredImages/3tqJ65kuTkBh8wrRH/bgqe8cyizbqkxuoxjx4e)

Here, we’ve visualised the attention patterns from the final token over a sample of prompts for the 6 heads with the highest direct effect on the final token logits. We see that the heads mostly attend either to the final name token position or, failing that, look back to either the “\<bos>” or “\\n” resting positions earlier in the prompt.<sup><sup id="fnref:10"><a href="#fn:10">10</a></sup></sup> <sup><sup id="fnref:11"><a href="#fn:11">11</a></sup></sup> From this we can conclude two things:

1. An athlete’s sport is largely represented in the residual stream by layer 16 of their final name token.
2. The representation of their sport should be linearly recoverable (because each head’s value input is related to the model’s final token logits by an approximately linear transformation).

### What are these high-effect attention heads reading from the final name token position?

To answer this question, we computed the path-specific effects of nodes in the final name token position via the OV circuits for each of the high-effect heads listed above. To be precise, for each high-effect head, we path patched, one by one, each feeder node’s activation on the corrupted (other-sport) prompt along just the path from that node to the output logits via the relevant head’s OV circuit <sup><sup id="fnref:12"><a href="#fn:12">12</a></sup></sup>. In effect, this creates an attribution of each high-effect node’s value input in terms of the nodes that feed into it.

Interestingly, we found that a large part of the second to sixth most important heads’ performance comes in turn from their value inputs reading the output of L16H20 *at* the final name token stream. For example, here is the attribution for final name token nodes’ impact on the logits via the OV circuit for L21H9 (the second most important head) – note the outsized contribution of L16H20’s output (at the final name token position) on the effect of this head:

![](https://res.cloudinary.com/lesswrong-2-0/image/upload/f_auto,q_auto/v1/mirroredImages/3tqJ65kuTkBh8wrRH/kmyken8pjgofdndy2mre)

The heatmaps for the third to sixth most important heads looked similar, with a lot of their effect coming from the output of L16H20 at the final name token.

Furthermore, looking at the attention patterns for L16H20 when attending from the final name token position, we see that it typically attends to the same position. Putting these observations together, we see that L16H20 has a high overall importance in this circuit through two *separate* mechanisms:

1. It transfers the athlete sport feature directly to the final token position via its OV circuit (attending from the final token back to the final name token);
2. It attends from the final *name* token position to the same position, producing an output that significantly contributes (via V-composition) to the outputs of other heads that transfer the athlete sport feature from the final name token to the final token.

What about L16H20 itself – which nodes most strongly contribute to *its* value input? As the chart below shows, the value input for L16H20 itself is largely dependent on MLP outputs preceding it in the final name position (with some V-composition with a handful of earlier heads that in turn attend from the final name position to itself):

![](https://res.cloudinary.com/lesswrong-2-0/image/upload/f_auto,q_auto/v1/mirroredImages/3tqJ65kuTkBh8wrRH/kdaykbcwns7qhchfi4ya)

### A simplified subcircuit for fact extraction

Putting the above results together, we conclude that:

- A large part of the sport fact extraction circuit (`extract_sport` in the diagram above) is performed by head L16H20;
	- Because the head’s attention pattern does not change (much) between athletes, its function is just a linear map, multiplying the residual stream by its OV circuit.
- This head’s OV circuit reads the final name token residual stream and outputs the contents (both back into the same residual stream and directly into the final token residual stream) such that unembedding the result boosts the logits for the correct sport’s token over those for incorrect sports’ tokens.
- Therefore **the correct sport was linearly represented on the final name token, and extracted by L16H20’s OV circuit**.

This suggests we can approximate `extract_sport` by replacing all of the model’s computation graph from layer 16 at the final name token position onwards with a three-class linear probe constructed by composing the OV map for L16H20 with the model’s unembedding weights for the tokens “ baseball”, “ basketball” and “ football”.<sup><sup id="fnref:13"><a href="#fn:13">13</a></sup></sup>

Making this simplification, we find that the overall circuit’s accuracy at classifying athlete’s sport drops from 100% for the original model, to 98% after simplifying the `extract_sport` part of the circuit to this (weights-derived) linear probe – i.e. we can vastly simplify this part of the circuit with negligible drop in performance at the task.<sup><sup id="fnref:14"><a href="#fn:14">14</a></sup></sup> <sup><sup id="fnref:15"><a href="#fn:15">15</a></sup></sup>

### An Alternate Path: Just Train A Linear Probe

An alternate route that short-cuts around a lot of the above analysis is to just train a logistic regression probe on the residual stream of the final name token <sup><sup id="fnref:16"><a href="#fn:16">16</a></sup></sup> and show that by layer 6 the probe gets good test accuracy. We could further show that patching in the subspace spanned by the probe <sup><sup id="fnref:17"><a href="#fn:17">17</a></sup></sup> causally affects the model’s output, suggesting that the representation is used downstream <sup><sup id="fnref:18"><a href="#fn:18">18</a></sup></sup>. This was the approach we used for a significant part of the project, before going back and making the analysis earlier in this section more rigorous.

We think there are significant advantages of mechanistic probes (e.g. using the weights of L16H20 and the unembedding to derive a probe rather than training a logistic regression classifier), it’s more principled (in the sense that we can clearly see what it means in terms of the model’s circuits), harder to overfit, and doesn’t require a training set that can then no longer be used for further analysis. But “just train a probe” makes it easier to move fast.

In particular, for this investigation, our goal was to zoom in on `lookup` in the first few layers, and knowing that the correct sport became linearly represented after a couple of MLP layers sufficed to tell us there was something interesting to try reverse-engineering, even if we didn’t know the details of the fact extraction circuit.

We think that probes are an underrated tool for circuit analysis, and that finding interpretable directions/subspaces in the model, which can be shown to be causally meaningful in a non-trivial way, enables simpler circuit analysis that needs only consider a subset of layers, rather than the full end-to-end behaviour of the model.

Another simpler approach would be to search for a mechanistic probe by just iterating over every head, taking its OV times the unembedding of the sports as your probe, and evaluating accuracy. If there’s a head with particularly high accuracy (including on a held-out validation set) that attends to the right place, then you may have found a crucial head. We note this approach has more danger of overfitting, depending on the number of heads, than doing a direct logit attribution first to narrow down to a small set of heads <sup><sup id="fnref:19"><a href="#fn:19">19</a></sup></sup>.

## Investigation 2: Simplifying de-tokenization and lookup

In this section we describe the experiments we performed to simplify the part of the circuit covered by the `concatenate_tokens` and `lookup` modules as defined in the simplified circuit diagram [above](https://docs.google.com/document/d/1EsIlX7L_xr0YX918NiDWv4Cn3FVS6tJqjrIGR6mnJyQ/edit?resourcekey=0-QoVN8x6k4h6wZCZaWV9qug#heading=h.h6dofjljntk0). To summarise, the experiments described below establish the following facts about this part of the circuit:

- An athlete’s sport is represented much earlier in the residual stream than layer 16 (where it is read by head L16H20). By layer 6, we still get pretty good (90%) accuracy when trying to read athlete’s sports using `extract_sport`.
- Context prior to the athlete’s name doesn’t matter for producing the sport representation (though it does matter for `extract_sport`). We can use the model’s final token activations on prompts of the form “\<bos> \<athletes-full-name>” and extract the athlete’s sport with little drop in accuracy.
- Attention heads don’t matter beyond layers 0 and 1. We can mean-ablate attention layers 2 onwards without hurting the `lookup` module’s performance much. Looking at attention patterns, we see that most heads do not particularly attend to previous name tokens, strengthening the case for ablating them. The advantage of removing these attention heads is that the `lookup` module thus becomes a simple stack of MLP layers (with residual skip connections) that is able to take the athlete’s embeddings at the start of layer 2 in the residual stream and output the athlete’s sport by the end of layer 6 in the residual stream.

As a result, we can decompose this part of the circuit into two sub-modules:

- `concatenate_tokens`, representing the role of layers 0 and 1 of the model, whose role (for this task) is to collect the athlete’s name tokens and place them in the final name token residual stream (we show in Investigation 3 that this is pure concatenation without lookup, at least for two token athlete names);
- `lookup`, a pure 5-layer MLP (comprising layers 2–6 of the original model) that converts this multi-token representation of the athlete’s name into a feature representation of the athlete that specifically represents the athlete’s sport in a linearly recoverable fashion.

We now describe the evidence supporting each of the three claims listed above in turn.

### Lookup is mostly complete by layer 6

If we apply the `extract_sport` probe to different layers in the final name token position, we see that it’s possible to read an athlete’s sport from the residual stream much earlier than layer 16:<sup><sup id="fnref:20"><a href="#fn:20">20</a></sup></sup>

![](https://res.cloudinary.com/lesswrong-2-0/image/upload/f_auto,q_auto/v1/mirroredImages/3tqJ65kuTkBh8wrRH/pwsurjq0ifiw4ch7xtj2)

By around layer 8, accuracy has largely plateaued, and even by layer 6 we have about 90% accuracy.<sup><sup id="fnref:21"><a href="#fn:21">21</a></sup></sup>

### Context doesn’t matter when looking up an athlete’s sport

We have already established that the residual stream at the final name token for an athlete encodes their sport. But to what extent did the model place sport in the residual stream because it would have done this anyway when seeing the athlete’s name (the multi-token embedding hypothesis) and to what extent did the model place sport in the residual stream because the one-shot prompt preceding the name <sup><sup id="fnref:22"><a href="#fn:22">22</a></sup></sup> hinted to the model that sport might be a useful attribute to extract?

Our hypothesis was that the context wouldn’t matter that much – specifically that the model would look up an athlete’s sport when it sees their name, even without any prior context. We tested this by collecting activations for pure name prompts, where the model was fed token sequences of the form “\<bos> <sup><sup id="fnref:23"><a href="#fn:23">23</a></sup></sup> \<first-name> \<last-name>” <sup><sup id="fnref:24"><a href="#fn:24">24</a></sup></sup> and the residual stream was harvested from the final name token.

Can the `extract_sport` module read athletes’ sports from these activations? As the plot below shows, we found that there is a little drop in performance without the one-shot context, but it’s still possible to fairly accurately read an athlete’s sport purely from an early layer encoding of just their name prepended by “\<bos>”, without any additional context. Hence, we can simplify the overall circuit by deleting all edges from tokens preceding the athlete’s name tokens in the full prompt for the task.

![](https://res.cloudinary.com/lesswrong-2-0/image/upload/f_auto,q_auto/v1/mirroredImages/3tqJ65kuTkBh8wrRH/x4wdqduttl0ovdowk9yi)

### Attention heads don’t matter beyond layer 2

In order to recall sport accurately, the `lookup` part of the circuit must in general be a function of most (if not all) of the tokens in an athlete’s name: for most athletes, it’s not possible to determine sport by just knowing the last token in their surname. Hence, attention heads must play some role in bringing together information distributed over the individual tokens of an athlete’s name in order that facts like sport can be accurately looked up.

However, how do these two processes – combining tokens and looking up facts – relate to each other?

1. They could happen concurrently – with attention bringing in relevant information from earlier tokens as and when it is required for the lookup process;
2. Or the processes could happen sequentially, with the tokens making up an athlete’s name being brought together first, and much of the lookup process only happening afterwards.<sup><sup id="fnref:25"><a href="#fn:25">25</a></sup></sup> Looking at the total effects of patching attention head outputs at the final name token position, we did find that there are many more heads that play a significant role in the overall circuit in layers 0 and 1 of the model than in later layers:

![](https://res.cloudinary.com/lesswrong-2-0/image/upload/f_auto,q_auto/v1/mirroredImages/3tqJ65kuTkBh8wrRH/s8xbfgfrakemknheueil)

This suggested that we might be able to remove the attention head outputs for layer 2 onwards without too much impact on the overall circuit’s performance. Trying this, we found that mean ablating attention outputs from layer 2 onwards had only a slightly detrimental impact on accuracy:<sup><sup id="fnref:26"><a href="#fn:26">26</a></sup></sup>

![](https://res.cloudinary.com/lesswrong-2-0/image/upload/f_auto,q_auto/v1/mirroredImages/3tqJ65kuTkBh8wrRH/xc9un39ztbdfeaxxh1h4)

This supports the two-stage hypothesis described above: information sharing between tokens (via attention) is largely complete by layer 2, with attention heads in later layers unimportant for lookup.

### A simplified subcircuit for fact lookup

The results above suggest that we can indeed split the process of looking up an athlete’s sport into two stages:

- `concatenate_tokens`, which is the result of the embedding and layers 0 and 1 of the model processing the tokens comprising the athlete’s name <sup><sup id="fnref:27"><a href="#fn:27">27</a></sup></sup> and producing a “concatenated token” representation at the end of layer 1 in the final name token residual stream;
- `lookup`, which is a pure MLP with skip connections (made up from MLP layers 2 onwards in the model), which processes the “concatenated token representation” after layer 1 of the residual stream, which in itself poorly represents the athlete’s sport (in a linear manner), and produces a “feature representation” later on in the residual stream, where sport can be easily linearly extracted (by `sport_extract`).

Note that there are two simplifications we have combined here:

- Processing the athlete name tokens on their own without a one-shot prompt (because we found context to be unimportant)
- Removing attention heads from layer 2 onwards (because we found information transmission between tokens to largely be complete by layer 2).

Since, each of these approximations has some detrimental effect on the circuit’s accuracy, it’s worth assessing their combined impact. Here’s a plot showing how combining these approximations impacts accuracy:

![](https://res.cloudinary.com/lesswrong-2-0/image/upload/f_auto,q_auto/v1/mirroredImages/3tqJ65kuTkBh8wrRH/xkhlsj0ktdmm3kipcbll)

The upshot is that, even applying both simplifications together, it’s possible to get up to 94% accuracy by including enough layers in the `lookup` MLP; even stopping at layer 6 gets you 85% accuracy.

## Investigation 3: Further simplifying the token concatenation circuit

So far, we have:

- Simplified `extract_sport` to a 3-class linear probe, whose weights are derived by composing the OV map for L16H20 with the model’s unembedding weights;
- Simplified `lookup` to be a pure 5 layer MLP with skip connections, whose layer weights correspond to those of MLP layers 2–6 in the original model;
- Established that prior context can be removed when calculating the residual stream’s value at the beginning of layer 2 at the final name token position (which is the input for `lookup`).

This leaves us with `concatenate_tokens`, comprising the embedding and layers 0 and 1 of the model, which converts the raw athlete name tokens (plus a prepending \<bos> token) into the value of the residual stream at the beginning of layer 2. Can we simplify this part of the circuit further?

There are two levels of simplification we identified for this components of the circuit:

- In general, we can think of `concatenate_tokens` as effectively generating *two* separate token-level embeddings of the athlete’s name, and then combining these embeddings approximately linearly via pure attention operations;
- In the case of athletes whose names are just two tokens long, we can further approximate `concatenate_tokens` so that it is literally a sum of effective token embeddings for first and last name tokens, taking only a modest hit to circuit accuracy.

In the following subsections, we explain these simplifications in more detail and provide experimental justifications for them.

### Token concatenation is achieved by attention heads moving token embeddings

The first simplification comes from the following two observations:

- MLP layer 1 at the final name token position has little importance for circuit performance: resample ablating it has low total effect on logit difference for the original model, and mean ablating it has little impact on the accuracy of the simplified circuit.<sup><sup id="fnref:28"><a href="#fn:28">28</a></sup></sup>
- Due to Pythia using parallel attention, MLP layer 0 is effectively a secondary token embedding layer.<sup><sup id="fnref:29"><a href="#fn:29">29</a></sup></sup> This implies that (after mean ablating MLP 1), `concatenate_tokens` effectively performs the following operations:
1. Calculate primary token embeddings for the athlete name tokens (and \<bos>) using the model’s embedding layer weights.
2. Calculate secondary token embeddings for the athlete name tokens using the embedding weights induced by the action of MLP 0 on the input token vocabulary.
3. Operate the attention layer 0 heads on the primary token embeddings.
4. Operate the attention layer 1 heads on the sum of the primary token embeddings, secondary token embeddings and outputs of attention layer 0.
5. Use the result of step 4 at the final name token position as the input to `lookup`.

In other words, `concatenate_tokens` effectively embeds the input tokens (twice) and moves them (directly and indirectly) to the final name token position via attention.

### For two-token athletes, concatenate\_tokens literally adds first and last name tokens together

For two-token athletes, we found that we could furthermore freeze attention patterns and still retain reasonable accuracy on the task. Specifically:

- We prevented attention heads in layer 1 at the last name token position attending to the same position;
- We froze all other attention patterns at their average levels across all two token athletes in the dataset, making the attention layers just act as a linear map mapping source token residuals to the final token.

These simplifications, along with mean ablating MLP 1, turn `concatenate_tokens` into a sum of effective token embeddings and a bias term (originating from the embeddings for the \<bos> token). The effective token embedding of the last name is just the sum of the primary and second (MLP0) token embedding. The effective token embedding of the first name is more complex, it’s the primary token embedding times the linear map from frozen attention 0 heads (their OV matrices weighted by the average attention from the last name to the first name), plus the primary and secondary token embeddings times the linear map from frozen attention 1 heads.

The impact of these simplifications on accuracy are shown in the graph below.<sup><sup id="fnref:30"><a href="#fn:30">30</a></sup></sup> We see that, for two-token athletes, freezing attention patterns has little additional impact on accuracy over ablating MLP 1.

![](https://res.cloudinary.com/lesswrong-2-0/image/upload/f_auto,q_auto/v1/mirroredImages/3tqJ65kuTkBh8wrRH/kinnfxarccubfccdl2g3)

---

*If you've come here via [3Blue1Brown](https://www.youtube.com/watch?v=9-Jl0dxWQs8), hi! If want to learn more about interpreting neural networks in general, here are some resources you might find useful:*

- *[My getting started guide](https://neelnanda.io/getting-started)*
- *[My paper reading list](https://neelnanda.io/mechanistic-interpretability/favourite-papers)*
- *[My Machine Learning Street Talk interview about the field](https://www.youtube.com/watch?v=_Ygf0GnlwmY)*
- *[Coding tutorials from ARENA](https://arena3-chapter1-transformer-interp.streamlit.app/)*
- *[An interactive demo of interpreting Gemma 2 2B via Neuronpedia](https://neuronpedia.org/gemma-scope)*

---

*This is a write up of the Google DeepMind mechanistic interpretability team’s investigation of how language models represent facts. This is, we recommend prioritising reading post 1, and thinking of it as the “main body” of our paper, and posts 2 to 5 as a series of appendices to be skimmed or dipped into in any order.*

## Executive Summary

Reverse-engineering circuits with superposition is a major unsolved problem in mechanistic interpretability: models use clever compression schemes to represent more features than they have dimensions/neurons, in a highly distributed and polysemantic way. Most existing mech interp work exploits the fact that certain circuits involve sparse sets of model components (e.g. a sparse set of heads), and we don’t know how to deal with distributed circuits, which especially holds back understanding of MLP layers. Our goal was to interpret a concrete case study of a distributed circuit, so we investigated how MLP layers implement a lookup table for factual recall: namely how early MLPs in Pythia 2.8B look up which of 3 different sports various athletes play. **We consider ourselves to have fallen short of the main goal of a mechanistic understanding of computation in superposition**, but did make some meaningful progress, including conceptual progress on why this was hard.

Our overall best guess is that **an important role of early MLPs is to act as a “multi-token embedding”, that selects** <sup><sup id="fnref:31"><a href="#fn:31">31</a></sup></sup> **the right unit of analysis from the most recent few tokens (e.g. a name) and converts this to a representation** (i.e. some useful meaning encoded in an activation). We can recover different attributes of that unit (e.g. sport played) by taking linear projections, i.e. **there are linear representations of attributes**. Though we can’t rule it out, our guess is that there isn’t much more interpretable structure (e.g. sparsity or meaningful intermediate representations) to find in the internal mechanisms/parameters of these layers. For future mech interp work we think it likely suffices to focus on understanding how these attributes are represented in these multi-token embeddings (i.e. early-mid residual streams on a multi-token entity), using tools like probing and [sparse autoencoders](https://transformer-circuits.pub/2023/monosemantic-features/index.html), and thinking of early MLPs similar to how we think of the token embeddings, where the embeddings produced may have structure (e.g. a “has space” or “positive sentiment” feature), but the internal mechanism is just a look-up table with no structure to interpret. Nonetheless, we consider this a downwards update on more ambitious forms of mech interp that hinge on fully reverse-engineering a model.

![](https://res.cloudinary.com/lesswrong-2-0/image/upload/f_auto,q_auto/v1/mirroredImages/iGuwZTHWb6DFY3sKB/xzrmkg7d1dbmxs2sn3f5)

**Our main contributions:**

[**Post 2:** Simplifying the circuit](https://www.alignmentforum.org/posts/3tqJ65kuTkBh8wrRH/fact-finding-simplifying-the-circuit-post-2)

- We do a deep dive into the specific circuit of how Pythia 2.8B recalls the sports of different athletes. Mirroring [prior work](https://arxiv.org/abs/2304.14767), we show that the circuit breaks down into 3 stages:
	- **Token concatenation**: Attention layers 0 and 1 assemble the tokens of the athlete’s name on the final name token, as a sum of multiple different representations, one for each token.
		- **Fact lookup**: MLPs 2 to 6 on the final name token map the concatenated tokens to a linear representation of the athlete’s sport - the multi-token embedding.
		- Notably, this just depends on the name, not on the prior context.
		- **Attribute extraction**: A sparse set of mid to late attention heads extract the sport subspace and move it to the final token, and directly connect with the output.

![](https://res.cloudinary.com/lesswrong-2-0/image/upload/f_auto,q_auto/v1/mirroredImages/iGuwZTHWb6DFY3sKB/qv8qfrczagg388exbycd)

[**Post 3:** Mechanistically understanding early MLP layers](https://www.alignmentforum.org/s/hpWHhjvjn67LJ4xXX/p/CW5onXm6uZxpbpsRk)

- We zoom in on mechanistically understanding how MLPs 2 to 6 actually map the concatenated tokens to a linear representation of the sport.
- We explore evidence for and against different hypotheses of what’s going on mechanistically in these MLP layers.
- We falsify the naive hypothesis that there’s just a single step of detokenization, where the GELUs in specific neurons implement a Boolean AND on the raw tokens and directly output all known facts about the athlete.
- Our best guess for part of what’s going on is what we term the [“hash and lookup” hypothesis](https://www.alignmentforum.org/s/hpWHhjvjn67LJ4xXX/p/CW5onXm6uZxpbpsRk#Hash_and_Lookup), but it’s messy, false in its strongest form and this is only part of the story. We give some evidence for and against the hypothesis.

[**Post 4:** How to think about interpreting memorisation](https://www.alignmentforum.org/s/hpWHhjvjn67LJ4xXX/p/JRcNNGJQ3xNfsxPj4)

- We take a step back to compare differences between MLPs that perform generalisation tasks and those that perform memorisation tasks (like fact recall) on toy datasets.
- We consider what representations are available at the inputs and within intermediate states of a network looking up memorised data and argue that (to the extent a task is accomplished by memorisation rather than generalisation) there is little reason to expect meaningful intermediate representations during pure lookup.

[**Post 5**: Do Early Layers Specialise in Local Processing?](https://www.alignmentforum.org/s/hpWHhjvjn67LJ4xXX/p/xE3Y9hhriMmL4cpsR)

- We explore a stronger and somewhat tangential hypothesis that, *in general*, early layers specialise in processing recent tokens and only mid layers integrate the prior context.
- We find that this is somewhat but not perfectly true: early layers specialise in processing the local context, but that truncating the context still loses something, and that this effect gradually drops off between layers 0 and 10 (of 32).

We also exhibit a range of miscellaneous observations that we hope are useful to people building on this work.

## Motivation

### Why Superposition

Superposition is really annoying, really important, and terribly understood. Superposition is the phenomenon, studied most notably in [Toy Models of Superposition](https://transformer-circuits.pub/2022/toy_model/index.html), where models represent more features than they have neurons/dimensions <sup><sup id="fnref:32"><a href="#fn:32">32</a></sup></sup>. We consider understanding how to reverse-engineer circuits in superposition to be one of the major open problems in mechanistic interpretability.

Why is it so annoying? Sometimes a circuit in a model is **sparse**, it only involves a small handful of components (heads, neurons, layers, etc) in the standard basis, and sometimes it’s **distributed**, involving many components. Approximately all existing mech interp works exploit sparsity, e.g. a standard workflow is identifying an important component (starting with the output logits), identifying the most important things composing with that, and recursing. And we don’t really know how to deal with distributed circuits, but these often happen (especially in non-cherry picked settings!)

Why is it so important? Because this seems to happen a bunch, and mech interp probably can’t get away with never understanding things involving superposition. We personally speculate that superposition is a key part of *why* scaling LLMs works so well <sup><sup id="fnref:33"><a href="#fn:33">33</a></sup></sup>, intuitively, the number of facts known by GPT-4 vs GPT-3.5 scales superlinearly in the number of neurons, let alone the residual stream dimension.<sup><sup id="fnref:34"><a href="#fn:34">34</a></sup></sup>

Why is it poorly understood? There’s been fairly limited work on superposition so far. Toy Models of Superposition is a fantastic paper, but is purely looking at toy models, which can be highly misleading - your insights are only as good as your toy model is faithful to the underlying reality <sup><sup id="fnref:35"><a href="#fn:35">35</a></sup></sup>. Neurons In A Haystack is the main paper studying superposition in real LLMs, and found evidence they matter significantly for detokenization (converting raw tokens into concepts), but fell short of a real mechanistic analysis on the neuron level.

This makes it hard to even define exactly what we mean when we say “our goal in this work was to study superposition in a real language model”. Our best operationalisation is that we tried to study a circuit that we expected to be highly distributed yet purposeful, and where we expected compression to happen. And a decent part of our goal was to better deconfuse what we’re even talking about when we say superposition in real models. See [Toy Models of Superposition](https://transformer-circuits.pub/2022/toy_model/index.html#motivation) and [Appendix A of Neurons In A Haystack](https://arxiv.org/pdf/2305.01610.pdf#page=17) for valuable previous discussion and articulation of some of these underlying concepts.

### Circuit Focused vs Representation Focused Interpretability

To a first approximation, interpretability work often focuses either on **representations** (how properties of the input are represented internally) or **circuits** (understanding the algorithms encoded in the weights by which representations are computed and used). A full circuit-based understanding typically requires decent understanding of representations, and is often more rigorous and reliable and can fill in weak points of just studying representations.

For superposition, there has recently been a burst of exciting work focusing on representations, in the form of sparse autoencoders (e.g. [Bricken et al](https://transformer-circuits.pub/2023/monosemantic-features/index.html), [Cunningham et al](https://arxiv.org/abs/2309.08600)). We think the success of sparse autoencoders at learning many interpretable features (which are often distributed and not aligned with the neuron basis) gives strong further evidence that superposition is the norm.

In this work, we wanted to learn general insights about the circuits underlying superposition, via the specific case study of factual recall, though it mostly didn’t pan out. In the specific case of factual recall, our recommendation is to focus on understanding fact representations without worrying about exactly how they’re computed.

### Why Facts

We focused on understanding the role of early MLP layers to look up facts in factual recall. Namely, we studied one-shot prompts of the form “Fact: Michael Jordan plays the sport of” -> “basketball” for 1,500 athletes playing baseball, basketball or (American) football in Pythia 2.8B <sup><sup id="fnref:36"><a href="#fn:36">36</a></sup></sup>. Factual recall circuitry has been widely studied before, we were influenced by [Meng et al](https://rome.baulab.info/), Chughtai et al (forthcoming), [Geva et al](https://arxiv.org/abs/2304.14767), [Hernandez et al](https://arxiv.org/abs/2308.09124) and [Akyurek et al](https://arxiv.org/abs/2205.11482), though none of these focused on understanding early MLPs at the neuron level.

We think facts are intrinsically pretty interesting - it seems that a *lot* of what makes LLMs work so well are that they’ve memorised a ton of things about the world, but we also expected facts to exhibit significant superposition. The model wants to know as many facts as possible, so there’s an incentive to compress them, in contrast to more algorithmic tasks like indirect object identification where you can just learn them and be done - there’s always more facts to learn! Further, facts are easy to compress because they don’t interfere with each other (for a fixed type of attribute), the model never needs to inject the fact that “Michael Jordan plays basketball” and “Babe Ruth plays baseball” on the same token, it can just handle the tokens ‘ Jordan’ and ‘ Ruth’ differently <sup><sup id="fnref:37"><a href="#fn:37">37</a></sup></sup> (see [FAQ questions A.6 and A.7](https://arxiv.org/pdf/2305.01610.pdf#page=18) here for more detailed discussion). We’d guess that a model like GPT-3 or GPT-4 knows more facts than it has neurons <sup><sup id="fnref:38"><a href="#fn:38">38</a></sup></sup>.

Further, [prior work](https://arxiv.org/pdf/2305.01610.pdf) has shown that superposition seems to be involved in early MLP layers for **detokenization**, where raw tokens are combined into concepts, e.g. “social security” is a very different concept than “social” or “security” individually. Facts about people seemed particularly in need of detokenization, as often the same name tokens (e.g. a first name or surname) are shared between many unrelated people, and so the model couldn’t always store the fact in the token embeddings. E.g. “Adam Smith” means something very different to “Adam Driver” or “Will Smith”.<sup><sup id="fnref:39"><a href="#fn:39">39</a></sup></sup>

## Our High-Level Takeaways

### How to think about facts?

![](https://res.cloudinary.com/lesswrong-2-0/image/upload/f_auto,q_auto/v1/mirroredImages/iGuwZTHWb6DFY3sKB/xzrmkg7d1dbmxs2sn3f5)

*(Figure from above repeated for convenience)*

At a high-level, we recommend thinking about the recall of factual knowledge in the model as **multi-token embeddings**, which are largely formed by early layers (the first 10-20% of layers) from the raw tokens <sup><sup id="fnref:40"><a href="#fn:40">40</a></sup></sup>. The model learns to recognise entities spread across several recent raw tokens, e.g. “| Michael| Jordan”, and produces a representation in the residual stream, with linear subspaces that store information about specific attributes of that entity <sup><sup id="fnref:41"><a href="#fn:41">41</a></sup></sup> <sup><sup id="fnref:42"><a href="#fn:42">42</a></sup></sup>.

We think that early attention layers perform **token concatenation** by assembling the raw tokens of these entities on the final token (the “ Jordan” position). And early MLP layers perform **fact lookup**, a Boolean AND (aka [detokenization](https://dynalist.io/d/n2ZWtnoYHrU1s4vnFSAQ519J#z=7G70mqwvXn7LoiOBc6-IRuLo)) on the raw tokens to output this multi-token embedding with information about the described entity.<sup><sup id="fnref:43"><a href="#fn:43">43</a></sup></sup> Notably, we believe this lookup is implemented by *several* MLP layers, and was not localisable to specific neurons or even a single layer.

A significant caveat is that this is extrapolated from a detailed study of looking up athlete facts, rather than a broader range of factual recall tasks, though is broadly supported by the prior literature. Our speculative prediction is that factual recall of the form “recognise that some entity is mentioned in the context and recall attributes about them” looks like this, but more complex or sophisticated forms of factual recall may not (e.g. multi-hop reasoning, or recall with a richer or more hierarchical structure).

We didn’t make much progress on understanding the internal mechanisms of these early MLP layers. Our take is that it’s fine to just black box these early layers as “the thing that produces the multi-token embeddings” and to focus on understanding the meaningful subspaces in these embeddings and how they’re used by circuits in later layers, and not on exactly how they’re computed, i.e. focusing on the representations. This is similar to how we conventionally think of the token embeddings as a big look-up table. One major difference is that the input space to the token embeddings is a single token, d\_vocab (normally about 50,000), while the input to the full model or other sub circuits are strings of tokens, which has a far larger input space. While you can technically think of language models as a massive lookup table, this isn’t very productive! This isn’t an issue here, because we focus on inputs that are the (tokenized) names of known entities, a far smaller set.

We think the goal of mech interp is to be useful for downstream tasks (i.e. understanding meaningful questions about model behaviour and cognition, especially alignment-relevant ones!) and we expect most of the interesting computation for downstream tasks to come in mid to late layers. Understanding these may require taking a dictionary of simpler representations as a given, but hopefully does not require understanding how the simpler representations were computed.

We take this lack of progress on understanding internal mechanisms as meaningful evidence against the goal of fully reverse-engineering everything in the model, but we think mech interp can be useful without achieving something that ambitious. Our vision for usefully doing mech interp looks more like reverse-engineering as much of the model as we can, zooming in on crucial areas, and leaving many circuits as smaller blackboxed submodules, so this doesn’t make us significantly more pessimistic on mech interp being relevant to alignment. Thus we think it is fine to leave this type of factual recall as one of these blackboxed submodules, but note that failing at any given task should make you more pessimistic about success at any future mech interp task.

### Is it surprising that we didn’t get much traction?

In hindsight, we don’t find it very surprising that we failed to interpret the early MLP layers (though we’re glad we checked!). Conceptually, on an algorithmic level, factual recall is likely implemented as a giant lookup table. As many students can attest, there simply isn't much structure to capitalise on when memorising facts: knowing that "Tim Duncan" should be mapped to "basketball" doesn't have much to do with knowing that "George Brett" should be mapped to "baseball"; these have to be implemented separately.<sup><sup id="fnref:44"><a href="#fn:44">44</a></sup></sup> (We deliberately focus on forms of factual recall without richer underlying structure.)

A giant lookup table has a high minimum description length, which suggests the implementation is going to involve a lot of parameters. This doesn’t necessarily imply it’s going to be hard to interpret: we can conceive of nice interpretable implementations like a neuron per entity, but these seem highly inefficient. In theory there could be interpretable schemes that are more efficient (we discuss, test and falsify some later on like [single-step detokenization](https://www.alignmentforum.org/s/hpWHhjvjn67LJ4xXX/p/CW5onXm6uZxpbpsRk#Single_Step_Detokenization)), but crucially there’s not a strong *reason* the model should use a nice and interpretable implementation, unlike with more algorithmic tasks like induction heads.

Mechanistically, training a neural network is a giant curve fitting problem, and there are likely many dense and uninterpretable ways to succeed at this. We should only expect interpretability when there is some structure to the problem that the training process can exploit. In the case of fact recall, the initial representation of each athlete is just a specific point in activation space <sup><sup id="fnref:45"><a href="#fn:45">45</a></sup></sup>, and there is (almost) no structure to exploit, so unsurprisingly we get a dense and uninterpretable result. In post 4, we also studied a toy model mapping pairs of integers to arbitrary labels where we knew all the data and could generate as much as we liked, and didn’t find the toy model any easier to interpret, in terms of finding internal sparsity or meaningful intermediate states.

### Look for circuits building on factual representations, not computing them

In mechanistic interpretability, we can both study **features** and **circuits**. Features are properties of the input, which are represented in internal activations (eg, “projecting the residual stream onto direction v after layer 16 recovers the sentiment of the current sentence”). Circuits are algorithms inside the model, often taking simpler features and using them to compute more complex ones. Some works prioritise [understanding features](https://arxiv.org/abs/2310.01405), others prioritise understanding circuits <sup><sup id="fnref:46"><a href="#fn:46">46</a></sup></sup>, we consider both to be valid approaches to mechanistic interpretability.

In the specific case of factual recall, we tried to understand the circuits by which attributes about an entity were looked up, and broadly failed. We think a reasonably halfway point is for future work to focus on understanding how these looked up attributes are represented, and how they are used by downstream circuits in later layers, treating the factual recall circuits of early layers as a small black-boxed submodule. Further, since the early residual stream is [largely insensitive to context before the athlete’s name](https://www.alignmentforum.org/s/hpWHhjvjn67LJ4xXX/p/3tqJ65kuTkBh8wrRH#Context_doesn_t_matter_when_looking_up_an_athlete_s_sport), fact injection seems the *only* thing the early MLPs can be doing, suggesting that little is lost from not trying to interpret the early MLP layers (in this context).<sup><sup id="fnref:47"><a href="#fn:47">47</a></sup></sup>

## What We Learned

We split our investigation into four subsequent posts:

1. A detailed analysis of the factual recall circuit with causal techniques, which localises the facts to MLPs 2 to 6 and understands a range of high-level facts about the circuit
2. A deep dive into the internal mechanisms of these MLP layers that considers several hypotheses and collects evidence for and against, which attempts to (and largely fails to) achieve a mechanistic understanding from the weights.
3. A shorter post exploring toy models of factual recall/memorisation, and how they seem similarly uninterpretable to Pythia, and how this supports conceptual arguments for how factual recall may not be interpretable in general
4. A shorter post exploring a stronger and more general version of the multi-token embedding hypothesis: that *in general* residual streams in early layers are a function of recent tokens, and the further-back context only comes in at mid layers. There is a general tendency for this to happen, but some broader context is still used in early layers

### What we learned about the circuit (Post 2 Summary)

- The high-level picture from Geva et al mostly holds up: Given a prompt like “Fact: Michael Jordan plays the sport of”, the model detokenizes “Michael AND Jordan” on the Jordan token to represent *every* fact the model knows about Michael Jordan. After layer 6 the sport is clearly linearly represented on the Jordan token. There are mid to late layer fact extracting attention heads which attend from “of” to “Jordan” and map the sport to the output logits (see Chughtai et al (forthcoming) for a detailed investigation of these, notably finding that these heads still attend and extract the athlete’s sport even if the relationship asks for a non-sport attribute).
- We simplified the fact extracting circuit down to what we call the **effective model** <sup><sup id="fnref:48"><a href="#fn:48">48</a></sup></sup>. For two token athlete names, this consists of attention layers 0 and 1 retrieving the previous token embedding and adding it to the current token embedding. These summed token embeddings then go through MLP layers 2 to 6 and at the end the sport is linearly recoverable. Attention layers 2 onwards can be ablated, as can MLP layer 1.
	- The linear classifier can be trained with logistic regression. We also found high performance (86% accuracy) by taking the directions that a certain attention head (Layer 16, Head 20) mapped to the output logits of the three sports: baseball, basketball, football <sup><sup id="fnref:49"><a href="#fn:49">49</a></sup></sup>.
- We simplified our analysis to interpreting the effective model, where the “end” of the model is a linear classifier and softmax between the three sports.
	- We think the insight of “once the feature is linearly recoverable, it suffices to interpret *how* the linear feature extraction happens, and the rest of the circuit can be ignored” may be useful in other circuit analyses, especially given how easy it is to train linear probes (given labelled data).

### What we learned about the MLPs (Post 3 Summary)

- Once we’d zoomed in on the facts being stored in MLPs 2 to 6, we formed, tested **and falsified** a few hypotheses about what was going on:
	- Note; These were fairly specific and detailed hypotheses, which were fairly idiosyncratic to my (Neel’s) gut feel about what might be going on. The space of all *possible* hypotheses is large.
		- In fact, investigating these hypotheses made us think they were likely false, in ways that taught us about both how LLMs are working and the nature of the problem’s messiness.
- **Single step detokenization hypothesis**: There’s a bunch of “detokenization” neurons that directly compose with the raw token embeddings, use their GELU to simulate a Boolean AND for e.g. prev==Michael && curr==Jordan, and output a linear representation of all facts the model knows about Michael Jordan
	- Importantly, this hypothesis claims that the same neurons matter for all facts about a given subject, and there’s no intermediate state between the raw tokens and the attributes.
		- [Prior work](https://arxiv.org/pdf/2305.01610.pdf) suggests that detokenization is done in superposition, suggesting a more complex mechanism than just one neuron per athlete. I hypothesised this was implemented by some combinatorial setup where each neuron detokenizing many strings, and each string is detokenized by many neurons, but each string corresponds to a unique *subset* of neurons firing above some threshold.
- **We’re pretty confident the single step detokenization hypothesis is false** (at least, in the strong version, though there may still be kernels of truth). Evidence:
- Path patching (noising) shows there’s meaningful composition between MLP layers, suggesting the existence of intermediate representations.

![](https://res.cloudinary.com/lesswrong-2-0/image/upload/f_auto,q_auto/v1/mirroredImages/iGuwZTHWb6DFY3sKB/aububbyo97pul54yhl22)

- We collect multiple facts the model knows about Michael Jordan. We then resample ablate <sup><sup id="fnref:50"><a href="#fn:50">50</a></sup></sup> (patch) each neuron (one at a time), and measure its effect on outputting the correct answer. The single step detokenization hypothesis predicts that the same neurons will matter for each fact. We measure the correlation between the effect on each pair of facts, and observe little correlation, suggesting different mechanisms for each fact.

![](https://res.cloudinary.com/lesswrong-2-0/image/upload/f_auto,q_auto/v1/mirroredImages/CW5onXm6uZxpbpsRk/zsa7a3aqscgpfiol8ogh)

- By measuring the non-linear effect of each neuron (how much it activates more for Michael Jordan than e.g. Keith Jordan or Michael Smith), we see that the neurons directly connecting with the probe already had a significant non-linear effect pre-GELU. This suggests that they compose with early neurons that compute the AND rather than the neurons with direct effect just computing the AND itself, i.e. that there are important intermediate states
- **Hash and lookup hypothesis**: where the first few MLPs “hash” the raw tokens of the athlete into a gestalt representation of the name that’s almost orthogonal to other names, and then neurons in rest of the MLPs “look up” these hashed representations by acting as a lookup table mapping them to their specific sports.
	- One role the hashing could serve is breaking linear structure between the raw tokens
		- E.g. “Michael Jordan” and “Tim Duncan” play basketball, but we don’t want to think that “Michael Duncan” does
				- In other words, this lets the model form a representation of “Michael Jordan” that is not necessarily similar to the representations of “Michael” or “Jordan”
		- Importantly, hashing should work for *any* combination of tokens, not just ones the model has memorised in training, though looking up may not work for unknown names.
- **We’re pretty confident that the *strong* version of the hash and lookup hypothesis is false**, though have found it a useful framework and think there may be some truth to it <sup><sup id="fnref:51"><a href="#fn:51">51</a></sup></sup>. Unfortunately “there’s some truth to it, but it’s not the whole story” turned out to be very hard to prove or falsify. Evidence:
- (Negative) If you linearly probe for sport on the residual stream, validation accuracy improves throughout the “hashing” layers (MLPs 2 to 4), showing there can’t be a clean layerwise separation between hashing and lookup. Pure hashing has no structure, so validation accuracy should be at random during the intermediate hashing layers.

![](https://res.cloudinary.com/lesswrong-2-0/image/upload/f_auto,q_auto/v1/mirroredImages/CW5onXm6uZxpbpsRk/b5xo66fwzwxmue0b1ytb)

- (Negative) Known names have higher MLP output norm than unknown names even at MLP1 and MLP2 - it doesn’t treat known and unknown names the same. MLP1 and MLP2 are hashing layers, so the model shouldn’t distinguish between known and unknown names this early. (This is weak evidence since there may e.g. be an amortised hash that has a more efficient subroutine for commonly-hashed terms, but still falsifies the strong version of the hypothesis, that hashing occurs with no regard for underlying meaning.)
- (Positive) The model does significantly break the linear structure between tokens. E.g. there’s a significant component on the residual for “Michael Jordan” that’s not captured by the average of names like “Michael Smith” or “John Jordan”. This is exactly what we expect hashing to do. \* However, this is not strong evidence that the *main* role of MLP layers is to break linear structure, they may be doing a bunch of other stuff too. Though they do break linear structure significantly more than randomly initialised layers
- We found a **baseball neuron** (L5N6045) which activated significantly more on the names of baseball playing athletes, and composed directly with the fact extracting head
	- The input and output weights of the neuron have significant cosine sim with the head-mediated baseball direction (but it’s significantly less than 1): it’s partially just boosting an existing direction, but partially doing something more
		- If you take the component of every athlete orthogonal to the other 1500 athletes, and project those onto the baseball neuron, it still fires more for baseball players than other players, maybe suggesting it is acting as a lookup table too.
		- Looking on a broader data distribution than just athlete names, it often activates on sport-related things, but is not monosemantic.

![](https://res.cloudinary.com/lesswrong-2-0/image/upload/f_auto,q_auto/v1/mirroredImages/CW5onXm6uZxpbpsRk/z4lgnpzcuyzlngtepv16)

### How to Think About Interpreting Memorisation (Post 4 Summary)

*This is a more philosophical and less rigorous post, thinking about memorisation and the modelling assumptions behind it, that was inspired by work with toy models, but has less in the way of rigorous empirical work.*

- Motivation:
	- When we tried to understand mechanistically how the network does the “fact lookup” operation, we made very little progress.
		- What should we take away from this failure about our ability to interpret MLPs in general when they compute distributed representations? In particular, what meaningful representations *could* we have expected to find in the intermediate activations of the subnetwork?
- In post 4, we study toy models of memorisation (1-2 MLP layers mapping pairs of integers to fixed and random binary labels) to study memorisation in a more pure setting. The following is an attempt to distil our intuitions following this investigation, we do not believe this is fully rigorous, but hope it may be instructive.
- We believe one important aspect of fact lookup, as opposed to most computations MLPs are trained to do, is that it mainly involves memorisation: there are no general rules that help you guess what sport an athlete plays from their name alone (at least, with any great accuracy <sup><sup id="fnref:52"><a href="#fn:52">52</a></sup></sup>).
- If a network solves a task by generalisation, we may expect to find representations in its intermediate state corresponding to inputs and intermediate values in the generalising algorithm that it has implemented to solve the task.<sup><sup id="fnref:53"><a href="#fn:53">53</a></sup></sup>
- On the other hand, if a network is unable to solve a task by generalisation (and hence has to memorise instead), this indicates that either no generalising algorithm exists, or at least that none of the features useful for implementing a possible generalising algorithm are accessible to the network.
- Therefore, under the memorisation scenario, the only meaningful representations (relevant to the task under investigation) that we should find in the subnetwork’s inputs and intermediate representations are:
	- Representations of the original inputs themselves (e.g. we can find features like “first name is George”).
		- Noisy representations of the target concept being looked up: for example, the residual stream after the first couple of MLP layers contains a noisier, but still somewhat accurate, representation of the sport played, because it is a partial sum of the overall network’s output.<sup><sup id="fnref:54"><a href="#fn:54">54</a></sup></sup> <sup><sup id="fnref:55"><a href="#fn:55">55</a></sup></sup>
- On the other hand, on any finite input domain – such as the Cartesian product of all first name / last name tokens – the output of *any* model component (neuron, layer of neurons, or multiple layers of neurons) can be interpreted as an embedding matrix: i.e. a lookup table individually mapping every first name / last name pair to a specific output vector. In this way, we could consider the sport lookup subnetwork (or any component in that network) as implementing a lookup table that maps name token pairs to sport representations.
- In some sense, this perspective provides a trivial interpretation of the computation performed by the MLP subnetwork: the weights of the subnetwork are such that – within the domain of the athlete sport lookup task – the subnetwork implements exactly the lookup table required to correctly represent the sport of known athletes. And memorisation is, in a sense by definition, a task where there should not be interesting intermediate representations to interpret.

### Do Early Layers Specialise in Local Processing? (Post 5 Summary)

- Motivation
	- The multi-token embedding hypothesis suggests that an important function of early layers is to gather together tokens that comprise a semantic unit (e.g. `[ George] [ Brett]`) and “look up” an embedding for that unit, such that important features of that unit (e.g. “plays baseball”) are linearly recoverable.
		- This got us thinking: to what extent is this *all* that early layers do?<sup><sup id="fnref:56"><a href="#fn:56">56</a></sup></sup>
		- Certainly, it seems that many linguistic tasks require words / other multi-token entities to be looked up before language-level processing can begin. In particular, many words are split into multiple tokens but seem likely better thought of as a single unit. Such tasks can only be accomplished after lookup has happened, i.e. in later layers.
		- On the other hand, there is no reason to wait until multi-token lookup is finished for single-token level processing (e.g. simple induction behaviour) to proceed. So it’s conceivable that early layers aren’t *all* about multi-token embedding lookup either: they could be getting on with other token-level tasks in parallel to performing multi-token lookup.
		- If early layers only perform multi-token lookup, an observable consequence would be that early layers’ activations should primarily be a function of nearby context. For multi-token lookup to work, only the few most recent tokens matter.
- So, to measure the extent to which early layers perform multi-token lookup, we performed the following experiment:
	- Collect residual stream activations across the layers of Pythia 2.8B for a sample of strings from the Pile.
		- Collect activations for tokens from the same strings with differing lengths of truncated context: i.e. for each sampled token, we would collect activations for that token plus zero preceding tokens, one preceding token, etc, up to nine preceding tokens.
		- Measure the similarity between the residual stream activations for tokens in their full context versus in the truncated contexts by computing the (mean centred) cosine similarities.
		- If early layers only perform local processing, then the cosine similarities between truncated context activations and full context activations should be close to one (at least for a long-enough truncation window).
- Collecting the results, we made the following observations:
	- Early layers do perform more local processing than later layers: cosine similarities between truncated and full contexts are clearly high in early layers and get lower in mid to late layers.
		- There is a sharp difference though between cosine sims with zero prior context and with some prior context, showing that local layers are meaningfully dependent on nearby context (i.e. they aren’t simply processing the current token).
		- However, even at layer 0, local layers do have some dependence on distant context: while cosine sims are high (above 0.9) they aren’t close to 1 (often <0.95) <sup><sup id="fnref:57"><a href="#fn:57">57</a></sup></sup>.

![](https://res.cloudinary.com/lesswrong-2-0/image/upload/f_auto,q_auto/v1/mirroredImages/xE3Y9hhriMmL4cpsR/yyrikd6m6xpbzqte3pnh)

- Interestingly, we found that truncated vs full context cosine sims for early layers are particularly low on punctuation tokens (periods, commas, newlines, etc) and “stop words” (and, or, with, of, etc) – indicating that early layers perform highly non-local processing on these tokens.
	- In retrospect, this isn’t so surprising, as the context immediately preceding such tokens often doesn’t add that much to their meaning, at least when compared to word fragment tokens like \[ality\], so processing them can start early (without waiting for a detokenisation step first).
		- There are several other purposes that representations at these tokens might serve – e.g. summarisation, resting positions, counting delimiters – that could explain their dependence on longer range context.

![](https://res.cloudinary.com/lesswrong-2-0/image/upload/f_auto,q_auto/v1/mirroredImages/xE3Y9hhriMmL4cpsR/b8aqjddkgqwgooduk5b2)

## Further Discussion

### Do sparse autoencoders make understanding factual recall easier?

A promising recent direction has been to [train Sparse Autoencoders](https://transformer-circuits.pub/2023/monosemantic-features/index.html) (SAEs) to extract monosemantic features from superposition.<sup><sup id="fnref:58"><a href="#fn:58">58</a></sup></sup> We haven’t explored SAEs ourselves <sup><sup id="fnref:59"><a href="#fn:59">59</a></sup></sup> and so can’t be confident in this, but our guess is that SAEs don’t solve our problem of understanding the circuitry behind fact localisation, though may have helped to narrow down hypotheses.

The core issue is that SAEs are a tool to better understand *representations* by decomposing them into monosemantic features, while we wanted to understand the factual recall *circuit*: how do the parameters of the MLP layers implement the algorithm mapping tokens of the names to the sport played? The key missing piece in SAEs is that if meaningful features in MLP layers (pre and post GELU) are not basis aligned then we need (in theory) to understand the function of *every* neuron in the layer to understand the mapping. In contrast, basis aligned features (i.e. corresponding to a single neuron pre and post GELU) can be understood in terms of a single GELU, and the value of all other neurons is irrelevant.

Understanding representations better can be an extremely useful intermediate step that helps illuminates a circuit, but we expect this to be less useful here. The obvious features an SAE might learn are first name (e.g. “first name is Michael”), last name (e.g. “last name is Jordan”) and sport (e.g. “plays basketball”). It seems fairly likely that there’s an intermediate feature corresponding to each entity e.g. (“is Michael Jordan”) which may be learned by an extremely wide SAE (though it would need to be very wide! There are a lot of entities out there), though we don’t expect many meaningful features corresponding to groups of entities <sup><sup id="fnref:60"><a href="#fn:60">60</a></sup></sup>. But having these intermediate representations isn’t obviously enough to understand how a given MLP layer works on the parameter level.

We can also learn useful things from what an SAE trained on the residual stream or MLP activations at different layers can learn. If we saw sharp transitions, where the sport only became a feature after layer 4 or something, this would be a major hint! But unfortunately, we don’t expect to see sharp transitions here, you can probe non-trivially for sport on even the token embeddings, and it smoothly gets better across the key MLP layers (MLPs 2 to 6).

### Future work

In terms of overall implications for mech interp, we see our most important claims as that the early MLPs in factual recall implement “multi-token embeddings”, i.e. for known entities whose name consists of multiple tokens, the early MLPs produce a linear representation of known attributes, and more speculatively that we do *not* need to mechanistically understand how these multi-token embeddings are computed in order for mech interp to be useful (so long as we can understand what they represent, [as argued above](https://www.alignmentforum.org/s/hpWHhjvjn67LJ4xXX/p/iGuwZTHWb6DFY3sKB#Look_for_circuits_building_on_factual_representations__not_computing_them)). In terms of future work, we would be excited for people to red-team and build on our claim that the mechanism of factual lookup *is* to form these multi-token embeddings. We would also be excited for work looking for concrete cases where we do need to understand tightly coupled computation in superposition (for factual recall or otherwise) in order for mech interp to be useful on a downstream task with real-world/alignment consequences, or just on tasks qualitatively different from factual recall.

In terms of whether there should be further work trying to reverse-engineer the mechanism behind factual recall, we’re not sure. We found this difficult, and have essentially given up after about 6-7 FTE months on this overall project, and through this project we have built intuitions that this may be fundamentally uninterpretable. But we’re nowhere near the point where we can confidently rule it out, and expect there’s many potentially fruitful perspectives and techniques we haven’t considered. If our above claims are true, we’re not sure if this problem needs to be solved for mech interp to be useful, but we would still be very excited to see progress here. If nothing else we expect it would teach us general lessons about computation in superposition which we expect to be widely applicable in models. And, aesthetically, we find it fairly unsatisfying that, though we have greater insight into how models recall facts, we didn’t form a full, parameter-level understanding.

## Acknowledgements

We are grateful to Joseph Bloom, Callum McDougall, Stepan Shabalin, Pavan Katta and Stefan Heimersheim for valuable feedback. We are particularly grateful to Tom Lieberum and Sebastian Farquhar for the effort they invested in giving us detailed and insightful feedback that significantly improved the final write-up.

We are also extremely grateful to Tom Lieberum for being part of the initial research sprint that laid the seeds for this project and gave us the momentum we needed to get started.

This work benefited significantly from early discussions with Wes Gurnee, in particular for the suggestion to focus on detokenization of names, and athletes as a good category.

## Author Contributions

Neel was research lead for the project, Sen was a core contributor throughout. Both contributed significantly to all aspects of the project, both technical contributions and writing. Sen led on the toy models focused work.

Janos participated in the two week sprint that helped start the project, and helped to write and maintain the underlying infrastructure we used to instrument Pythia. Rohin advised the project.

## Citation

Please cite this work as follows

```
@misc{ 
nanda2023factfinding,  
title={Fact Finding: Attempting to Reverse-Engineer Factual Recall on the Neuron Level},  
url={https://www.alignmentforum.org/posts/iGuwZTHWb6DFY3sKB/fact-finding-attempting-to-reverse-engineer-factual-recall},  
journal={Alignment Forum},  
author={Nanda, Neel and Rajamanoharan, Senthooran and Kram\’ar, J\’anos and Shah, Rohin},  
year={2023},  
month={Dec}}
```

---

x

[^1]: Note that we started with several thousand athletes, so this filtering likely introduced some bias. E.g. if there were a thousand athletes the model did not know but guessed a random sport for, we would select the 333 where the model got lucky. We set the 50% confidence (on the full vocab) threshold to reduce this effect.

[^2]: Our guess is that few shot vs zero shot does not materially affect the lookup circuit, but rather the one shot prompt tells the model that the output is a sport and boosts all sport logits (suggested by the results of Chughtai et al (forthcoming)). Anecdotally, zero shot, the model puts significant weight on “his/her” as an output, though Pythia 1.4B does not!

[^3]: Note that the linearly recoverable features in the output of `concatenate_tokens` will end up being something like the union of the features in these individual token embeddings – i.e. sport is not particularly linearly recoverable from this output. It’s best to think of the output of `concatenate_tokens` as a “concatenation of individual token embeddings that saves position information” so that the concatenation can be processed together by a series of MLP layers.

[^4]: We could have chosen pretty much any layer between 4 and 15 here as our endpoint, as faithfulness of our simplified circuit increased fairly continuously as we included additional layers. However, there is an inflection point around layer 5, after which you start seeing diminishing returns. We believe that the MLP layers after MLP 6 are just boosting the attributes in the residual stream rather than looking it up from the raw tokens.

[^5]: When we refer to the “linear classifier” we are referring to the composition of the OV circuit of these heads and the unembedding matrix. The heads always attend from the final token to the final name position, so purely act as a linear map.

[^6]: We suspect it may be possible to express `concatenate_tokens` as a similar sum of position-dependent token embeddings even for athletes with three or more tokens in their name, but we didn’t pursue this line of investigation further.

[^7]: E.g. where the clean prompt is for Tim Duncan (who plays basketball), we might patch in activations from the prompt for George Brett (who plays baseball) or Andy Dalton (who plays football).

[^8]: This metric has the nice property of being linear in logits, while also being invariant to constant shifts across all logits.

[^9]: To clarify, the not insignificant total effects of later MLP layers suggests that some post-processing is going on - the point we’re making is that even without this post processing, the outputs of these attention heads can directly be interpreted in terms of sport token logits, hence these attention heads are already writing the correct sport into the residual stream.

[^10]: Interestingly, because the prompts are sorted in terms of sport, we see that some heads only seem to be used for a subset of the sports in the task. Breaking down these head’s direct effects by sport confirms this picture: L19H24 is only consistently important for baseball players, whereas L22H17 is only consistently important for basketball, and some fraction of baseball players. (We didn’t try to understand what differentiates those athletes that this head is important for versus those that it isn’t important for.) This selectivity among attention heads is [not entirely surprising](https://arxiv.org/abs/2307.09458), and we did not investigate this further as it’s not directly relevant to our current investigation.

[^11]: As usual in mechanistic interpretability, this is just an approximate picture - looking at the plots, it’s clear that some heads do non-trivially attend to tokens between the athlete’s name and the final token, particularly to “ plays” and “ sport” and sometimes “ golf”. However, this doesn’t change the overall conclusion that the residual stream at an athlete’s name token already contains their sport.

[^12]: We note that this approach requires a separate forward pass for each residual stream component on the final name token, *and* for each high-effect mediating head. This was not a bottleneck on our work, so we did proper path patching, but we note that this can be easily approximated with direct logit attribution. If we freeze the LayerNorm scale, then the OV circuit of each head performs a linear map on the final name token residual stream, and the unembedding is a further linear map, and so we can efficiently see the change in the final logits caused by each final name token residual component. We found this technique useful for rapid iteration during this work.

[^13]: We also need to set the bias for the probe. We do this by subtracting the mean activations at the probe’s input (i.e. by effectively centering the probe’s input before applying the weight matrix).

[^14]: This difference in performance is at least in part because we always probe the final name token position whereas L16H20 does for some athletes attend to other positions (e.g. the penultimate token) in their name. We conjecture this is because some athletes are fully identified before the final token in their name has appeared (e.g. from four tokens of a five token name), and so fact lookup occurs before this final token.

[^15]: We deliberately measure accuracy rather than loss recovered because we expect the later high-effect heads are mostly signal boosting the output of L16H20, even though [loss recovered would normally be our preferred metric](https://arxiv.org/abs/2309.16042). Signal boosting improves loss but does not change accuracy, and to understand factual recall it suffices to understand how high accuracy is achieved.

[^16]: In this case we already guessed the final name token would be the right token to probe for sport based on e.g. residual stream patching + prior work, but it’s easy enough to sweep over tokens and layers and train a probe on all of them, probes are pretty cheap to train

[^17]: [Makelov et al](https://arxiv.org/abs/2311.17030) recently showed that subspace activation patching can misleadingly activate dormant parallel pathways, but this is mostly a concern when using gradient descent to learn a subspace with causal effect, probes are correlational so this is not an issue here.

[^18]: Because the probe is linear, it’s a bit unclear if you should care whether the probe is causally used. The model’s ability to map individual tokens of an athlete’s name to a linear representation of sport is an interesting algorithm to reverse-engineer and likely involves superposition, even if for some weird coincidence a parallel algorithm is the main thing affecting the model outputs. But this is a pretty contrived situation and it’s easy to check.

[^19]: In particular, in some settings, the probe may be very natural. E.g. many attention heads just copy whatever token they attend to to the output. So being a good mechanistic probe when probing for the input token is weak evidence that a head is involved, but likely still finds you a pretty good probe.

[^20]: When applying this probe to other layers, we’d always mean centre relative to the residual stream activations for that layer. This is equivalent to mean ablating the MLP and attention outputs between the layer being probed and layer 16.

[^21]: A question naturally arises here: why did the L16H20 value input attribution (presented earlier) show that MLPs 8, 11 and 13 in particular have a high path-specific effect on determining the correct sport token, when the probe shows that you can pretty much read the athlete’s sport much earlier on? Our hypothesis is that these later MLPs are boosting the signal generated by early MLPs, rather than looking up facts by themselves.

[^22]: I.e. “Fact: Tiger Woods plays the sport of golf”

[^23]: In the weeds: The Pythia models were not trained with a BOS (beginning of sequence) token, but we anecdotally find that the model is better behaved when doing inference with one. Models often have extremely high norm on the first token of the context, and treat it unusually, which makes it hard to study short prompts like “George Brett”. Pythia’s BOS and EOS token are the same, and it was trained with EOS tokens separating documents in pre-training (and the model was able to attend between separate documents), so it will have seen a BOS token in this kind of role during training

[^24]: E.g. “\<bos> George Brett”

[^25]: N.B. we know it can’t be possible to completely separate lookup from token concatenation, because even the final token embedding (prior to any processing by the model) often has some notion of an athlete’s sport. Instead, we’re making the weaker hypothesis here that much of the additional accuracy of the `lookup` circuit (beyond guessing sport from the final token) happens after the athlete’s name tokens have first been assembled together.

[^26]: We also checked (and confirmed) that ablating attention layers 0 or 1 had a catastrophic impact on sport lookup.

[^27]: With a preceding \<bos> token, to be precise.

[^28]: Probe accuracy, with the simplified `lookup` and `extract_sport` circuits described in previous sections, drops from 85% to 81% after layer 6 and drops from 94% to 90% after layer 15, when we mean ablate MLP 1.

[^29]: Due to parallel attention, the input to MLP0 at any position is just the token embedding at that position. Hence, we could literally replace MLP0 by a second table of token embeddings (mapping original token IDs to their corresponding MLP0 output values) without affecting model outputs at all.

[^30]: Note that this plot is not directly comparable with preceding plots, as it measures accuracy only over two-token athletes.

[^31]: We use “select” because the number of tokens in the right “unit” can vary in a given context. E.g. in “On Friday, the athlete Michael Jordan”, the two tokens of ‘Michael Jordan’ is the right unit of analysis, while “On her coronation, Queen Elizabeth II”, the three tokens of “Queen Elizabeth II” are the right unit.

[^32]: It is closely related to the observed phenomenon of polysemanticity (where a neuron fires on multiple unrelated things) and distributed representations (where many neurons fire for the same thing), but crucially superposition is a mechanistic hypothesis that tries to explain why these observations emerge, not just an empirical observation itself.

[^33]: In particular, distributed representation seems particularly prevalent in language MLP layers: in image models, often individual neurons were monosemantic. This happens sometimes but seems qualitatively rarer in language models.

[^34]: Notably, almost all transformer circuit progress has been focused on attention heads rather than MLP layers (with some exceptions e.g. [Hanna et al](https://arxiv.org/abs/2305.00586)), despite MLPs being the majority of the parameters. We expect that part of this is that MLPs are more vulnerable to superposition than attention heads. Anecdotally, on a given narrow task, often a sparse set of attention heads matter, while a far larger and more diffuse set of MLP neurons matter, and [Bricken et al](https://transformer-circuits.pub/2023/monosemantic-features/index.html) suggests that there are many monosemantic directions in MLP activations that are sparse

[^35]: Though real models can also be difficult to study, as they may be full of messy confounders. Newtonian physics is particularly easy to reason about with billiard balls, but trying to learn about Newtonian physics by studying motion in a hurricane wouldn't be a good idea either. (Thanks to Joseph Bloom for this point!)

[^36]: A weakness in our analysis specifically is that we only studied 1,500 facts (the sports of 1,500 athletes) while the 5 MLP layers we studied each had 10,000 neurons, which was fairly under-determined! Note that we expect even Pythia 2.8B knows more than 50,000 facts total, athlete sports just happened to be a convenient subset to study.

[^37]: There are edge cases where e.g. famous people share the same name (e.g. [Michael Jordan](https://en.wikipedia.org/wiki/Michael_Jordan) and [Michael Jordan](https://en.wikipedia.org/wiki/Michael_I._Jordan)!), our guess is that the model either ignores the less famous duplicate, or it looks up a “combined” factual embedding that it later disambiguates from context. Either way, this is only relevant in a small fraction of factual recall cases.

[^38]: Note that models have many fewer neurons than parameters, e.g. GPT-3 has 4.7M neurons and 175B parameters, because each neuron has a separate vector of d\_model input and output weights (and in GPT-3 d\_model is 12288)

[^39]: Of course this is an imperfect abstraction, e.g. non-Western names are more likely to play internationally popular sports, and certain tokens may occur in exactly one athlete’s name.

[^40]: These are not the same as contextual word embeddings (as have been [studied](https://aclanthology.org/D18-1179/) [extensively](https://arxiv.org/abs/1905.05950) with BERT-style models in the past). It has long been known that models enrich their representation of tokens as you go from layer to layer, using attention to add context to the (context-free) representations provided by the embedding layer. Here, however, we’re talking about how models represent linguistic units (e.g. names) that span multiple tokens *independently* of any *additional* context. Multi-token entities need to be represented somehow to aid downstream computation, but in a way that can’t easily be attributed back to individual tokens, similar to what’s been termed [detokenization](https://transformer-circuits.pub/2022/solu/index.html#section-6-3-2) in the literature. In reality, models probably create *contextual multi-token embeddings*, where multi-token entities’ representations are further enriched by additional context, complicating the picture, but we still think multi-token embeddings are a useful concept for understanding models’ behaviour.

[^41]: For example, the model has a "plays basketball" direction in the residual stream. If we projected the multi-token representation for "| MIchael| Jordan" onto this direction, it would be unusually high

[^42]: This mirrors the findings in [Hernandez et al](https://arxiv.org/abs/2308.09124), that looking up a relationship (e.g. “plays the sport of”) on an entity is a linear map.

[^43]: E.g. mapping “first name is Michael” and “last name is Jordan” to “is the entity Michael Jordan” with attributes like “plays basketball”, “is an athlete”, “plays for the Chicago Bulls” etc.

[^44]: Though there’s room for some heuristics, based on e.g. inferring the ethnicity of the name, or e.g. athletes with famous and unique single-token surnames where the sport may be stored in the token embedding.

[^45]: As argued in [post 5](https://www.alignmentforum.org/s/hpWHhjvjn67LJ4xXX/p/xE3Y9hhriMmL4cpsR), since early layers don’t integrate much prior context before the name.

[^46]: Which often implicitly involves understanding features.

[^47]: A caveat to this point is that without mechanistic understanding of the circuit it might be hard to verify that we have found all the facts that the MLPs inject -- though a countercounterpoint is that you can look at loss recovered from the facts you do know on a representative dataset

[^48]: i.e. showed that we can ablate everything else in the model without substantially affecting performance

[^49]: Each sport is a single token.

[^50]: I.e. we take another athlete (non-basketball playing), we take the neuron’s activation on that athlete, and we intervene on the “Michael Jordan” input to replace that neuron’s activation on the Jordan token with its activation on the final name token of the other athlete. We repeat this for 64 randomly selected other athletes.

[^51]: Note that it’s unsurprising to us that the strong form of hashing didn’t happen - even if at one point in training the early layers do pure hashing with no structure, future gradient updates will encourage early layers to bake in *some* known structure about the entities it’s hashing, lest the parameters be wasted.

[^52]: We suspect that generalisation probably does help a bit: the model is likely using correlations between features of names – e.g. cultural origin – and sports played to get some signal, and some first names or last names have sport (of famous athlete(s) with that name) encoded right in their token embeddings. But the key point is that these patterns alone would not allow you to get anywhere near decent accuracy when looking up sport; memorisation is key to being successful at this task.

[^53]: Note that we’re not saying that we would always succeed in finding these representations; the network may solve the task using a generalising algorithm we do not understand, or we may not be able to decode the relevant representations. The point we’re making is that, for generalising algorithms, we at least know that there must be meaningful intermediate states (useful to the algorithm) that we at least have a chance of finding represented within the network.

[^54]: Of course, there are many other representations in these subnetwork’s intermediate activations, because the subnetwork’s weights come from a language model trained to accomplish many tasks. But these representations cannot be decoded using just the task dataset (athlete names and corresponding sports). And, to the extent that these representations are truly task-irrelevant (because we assume the task can only be solved by memorisation – see the caveat in an earlier footnote), our blindness to these other representations shouldn’t impede our ability to understand how sport lookup is accomplished.

[^55]: Other representations we might find in a model in general include “clean” representations of the target concept (sport played), and functions of this concept (e.g. “plays basketball AND is over 6’8’’ tall”), but these should only appear following the lookup subnetwork, because we defined the subnetwork to end precisely where the target concept is first cleanly represented.

[^56]: Note that the answer to this question does not directly tell us anything (positive or negative) about the multi-token embedding hypothesis: it could be that early layers perform many local tasks, of which multi-token embeddings is just one; alternatively it could be the case that early layers do lots of non-local processing in addition to looking up multi-token embeddings.

[^57]: We note that it’s kind of ambiguous how best to quantify “how much damage did truncation do”. Arguably cosine sim squared might be a better metric, as it gives the fraction of the norm explained, and 0.9^2=0.81 looks less good.

[^58]: We note that by default SAEs get you representation sparsity but not circuit sparsity - if a SAE feature is distributed in the neuron basis then thanks to the per-neuron non-linearity any neuron can affect the output feature and can’t naively be analysed in isolation.

[^59]: We did the main work on this project before the [recent](https://transformer-circuits.pub/2023/monosemantic-features/index.html) [flurry](https://arxiv.org/abs/2309.08600) of work on SAEs. If we were doing this project again, we’d probably try using them! Though as noted, we don’t expect them to be a silver bullet solution.

[^60]: Beyond heuristics about e.g. certain ethnicities being inferrable from the name and more likely to play different sports, which we consider out of scope for this investigation. In some sense, we deliberately picked a problem where we did not expect intermediate representations to be important.

[^61]: This reminds me about an [old MIRI post distinguishing between interpretable top-level reasoning and uninterpretable subsystem reasoning](https://www.alignmentforum.org/posts/5bd75cc58225bf0670375321/on-motivations-for-miri-s-highly-reliable-agent-design-research), and while they imagined MCTS and SGD as examples of top-level reasoning (as opposed to the interpretable algorithms inside a neural network), this hope is similar to one of their paths to aligned AI:

> **Hope that top-level reasoning stays dominant on the default AI development path**
> 
> Currently, it seems like most AI systems' consequentialist reasoning is explainable in terms of top-level algorithms. For example, AlphaGo's performance is mostly explained by MCTS and the way it's trained through self-play. The subsystem reasoning is subsumed by the top-level reasoning and does not overwhelm it.