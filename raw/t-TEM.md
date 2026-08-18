Published as a conference paper at ICLR 2022 

# RELATING TRANSFORMERS TO MODELS AND NEURAL REPRESENTATIONS OF THE HIPPOCAMPAL FORMATION 

**James C.R. Whittington** _[∗]_ **Joseph Warren, Timothy E.J. Behrens** University of Oxford & Stanford University University of Oxford & University College London 

## ABSTRACT 

Many deep neural network architectures loosely based on brain networks have recently been shown to replicate neural firing patterns observed in the brain. One of the most exciting and promising novel architectures, the Transformer neural network, was developed without the brain in mind. In this work, we show that transformers, when equipped with recurrent position encodings, replicate the precisely tuned spatial representations of the hippocampal formation; most notably place and grid cells. Furthermore, we show that this result is no surprise since it is closely related to current hippocampal models from neuroscience. We additionally show the transformer version offers dramatic performance gains over the neuroscience version. This work continues to bind computations of artificial and brain networks, offers a novel understanding of the hippocampal-cortical interaction, and suggests how wider cortical areas may perform complex tasks beyond current neuroscience models such as language comprehension. 

## 1 INTRODUCTION 

The last ten years have seen dramatic developments using deep neural networks, from computer vision (Krizhevsky et al., 2012) to natural language processing and beyond (Vaswani et al., 2017). During the same time, neuroscientists have used these tools to build models of the brain that explain neural recordings at a precision not seen before (Yamins et al., 2014; Banino et al., 2018; Whittington et al., 2020). For example, representations from convolutional neural networks (Lecun et al., 1998) predict neurons in visual and inferior temporal cortex (Yamins et al., 2014; Khaligh-Razavi & Kriegeskorte, 2014), representations from transformer neural networks (Vaswani et al., 2017) predict brain representations in language areas (Schrimpf et al., 2020), and lastly recurrent neural networks (Cueva & Wei, 2018; Banino et al., 2018; Sorscher et al., 2019) have been shown to recapitulate grid cells (Hafting et al., 2005) from medial entorhinal cortex. Being able to use models from machine learning to predict brain representations provides a deeper understanding into the mechanistic computations of the respective brain areas, and offers deeper insight into the nature of the models. 

As well as using off-the-shelf machine learning models, neuroscience has developed bespoke deep learning models (mixing together recurrent networks with memory networks) that learn neural representations that mimic the exquisite _spatial_ representations found in hippocampus and entorhinal cortex (Whittington et al., 2020; Uria et al., 2020), including grid cells (Hafting et al., 2005), band cells (Krupic et al., 2012), and place cells (O’Keefe & Dostrovsky, 1971). However, since these models are bespoke, it is not clear whether they, and by implication the hippocampal architecture, are capable of the general purpose computations of the kind studied in machine learning. 

In this work we 1) show that transformers (with a little twist) recapitulate spatial representations found in the brain; 2) show a close mathematical relationship of this transformer to current hippocampal models from neuroscience (with a focus on Whittington et al. (2020) though the same is true for Uria et al. (2020)); 3) offer a novel take on the computational role of the hippocampus, and an instantiation of hippocampal indexing theory (Teyler & Rudy, 2007); 4) offer novel insights on the role of positional encodings in transformers. 5) discuss whether similar computational principles might apply to broader cognitive domains, such as language, either in the hippocampal formation or in neocortical circuits. 

> _∗_ Correspondence to: jcrwhittington@gmail.com 

1 

Published as a conference paper at ICLR 2022 

Note, we are not saying the brain is closely related to transformers because it learns the same neural representations, instead we are saying the relationship is close because we have shown a mathematical relationship between transformers and carefully formulated neuroscience models of the hippocampal formation. This relationship helps us get a better understanding of hippocampal models, it also suggests a new mechanism for place cells that would not be possible without this mathematical relationship, and finally it tells us something formal about position encodings in transformers. 

## 2 TRANSFORMERS 

Transformer Neural Networks (Vaswani et al., 2017) are highly successful machine learning algorithms. Originally developed for language, transformers perform well on other tasks that can be posed sequentially, such as mathematical understanding, logic problems (Brown et al., 2020), and image processing (Dosovitskiy et al., 2020). 

Transformers accept a set of observations; X = _{_ _**x**_ 1 _,_ _**x**_ 2 _,_ _**x**_ 3 _, · · · ,_ _**x** T }_ ( _**x** t_ could be a word embedding or image patch etc), and aim to predict missing elements of that set. The missing elements could be in the future, i.e. _**x** t>T_ , or could be a missing part of a sentence or image, i.e. _{_ _**x**_ 1 = the _,_ _**x**_ 2 = cat _,_ _**x**_ 3 = sat _,_ _**x**_ 4 = ? _,_ _**x**_ 5 = the _,_ _**x**_ 6 = mat _}_ . 

**Self-attention.** The core mechanism of transformers is self-attention. Self-attention allows each element to ‘attend’ to all other elements, and update itself accordingly. In the example data-set above, the 4[th] element (?) could attend to the 2[nd] (cat), 3[rd] (sat), and 6[th] (mat) to understand it should be on. Formally, to attend to another element each element ( _**x** t_ is a row vector) emits a query ( _**q** t_ = _**x** t_ _**W** q_ ) and compares it to other elements keys ( _**k** τ_ = _**x** t_ _**W** k_ ). Each element is then updated using _**y** t_ =[�] _τ[κ]_[(] _**[q]**[t][,]_ _**[ k]**[τ]_[)] _**[v]**[τ]_[,][where] _[κ]_[(] _**[q]**[t][,]_ _**[ k]**[τ]_[)][is][kernel][describing][the][similarity][of] _**[q]**[t]_[to] _**k** τ_ and _**v** τ_ is the value computed by each element _**v** τ_ = _**x** t_ _**W** v_ . Intuitively, the similarity measure _κ_ ( _**q** t,_ _**k** τ_ ) places more emphasis on the elements that are relevant for prediction; in this example, the keys may contain information about whether the word is a noun, verb or adjective, while the query may ‘ask’ for any elements that are nouns or verbs - elements that match this criteria (large _κ_ ( _**q** t,_ _**k** τ_ ), i.e. cat, sat, mat) are ‘attended’ to and therefore contribute more to the output _yt_ . Typically, the similarity measure is a softmax i.e. _κ_ ( _**q** t,_ _**k** τ_ ) = � _τe[′][β][e]_ _**[q]**[β][t][·]_ _**[q][k]**[t][τ][·]_ _**[k]**[τ][′]_[.] 

These equations can be succinctly expressed in matrix form, with all elements updated simultaneously: 

**==> picture [333 x 25] intentionally omitted <==**

Here _**Q**_ , _**K**_ , _**V**_ are matrices with rows filled by _**q** t_ , _**k** t_ , _**v** t_ respectively, and the softmax is taken independently for each row. After this update, each _**y** t_ is then sent through a deep network ( _fθ_ ( _· · ·_ )) typically consisting of residual (He et al., 2016) and layer-normalisation (Ba et al., 2016b) layers to produce _**z** t_ = _fθ_ ( _**y** t_ ). _**Z**_ is the output of the transformer which can then be used for prediction, or sent through subsequent transformer blocks. 

**Position encodings.** Self-attention is permutation invariant and so tells you nothing about order of the inputs. Should the data be sequential (i.e. meaning depends on the order of elements, such as in language, or navigation as we will see later!), it is necessary to additionally encode the position/ where _**x**_ is in the sequence. This is typically done by adding a ‘position encoding’ that uniquely identifies each time-step ( _**e** t_ - typically sines and cosines) to each input: _**x** t ←_ _**x** t_ + _**e** t_ . Alternatively the position embedding can be appended i.e. _**h** t_ = [ _**x** t,_ _**e** t_ ], with self attention then performed using _**h** t_ as input. 

## 3 TRANSFORMERS LEARN ENTORHINAL REPRESENTATIONS 

Here we show that transformers (with a small modification) recapitulate spatial representations - grid and band cells - when trained on tasks that require abstract spatial knowledge. 

**Spatial understanding task.** The task (more detail in Appendix) is to predict upcoming sensory observations _**x** t_ +1 conditioned on taking an action _**a** t_ while moving around spatial environments (Figure 1a). For example, after seeing _{_ ( _**x**_ 1 = cat _,_ _**a**_ 1 = North) _,_ ( _**x**_ 2 = dog _,_ _**a**_ 2 = East) _,_ ( _**x**_ 3 = frog _,_ _**a**_ 3 = South) _,_ ( _**x**_ 4 = pig _,_ _**a**_ 4 = West) _,_ ( _**x**_ 5 = ? _,_ _**a**_ 5 = _· · ·_ ) _}_ , the aim is to predict 

2 

Published as a conference paper at ICLR 2022 

**==> picture [376 x 120] intentionally omitted <==**

**----- Start of picture text -----**<br>
a Environment 1 Environment 2 b (with causal attention mask)Transformer  y3<br>A B A B D C<br>Key, Value k0 v0 k1 v1 k2 v2<br>[ cr e (<br>B C D C A D iW k iW v<br>Query q0 q1 q2 q3<br>ee D A B o A T Coo D C )6|§6(@marESyr iW q<br>ll position encodingInput with  goo e0 x0 e1 x1 e2 x2 e3 ?<br>A B A D ? Observations (x) D A C A ?<br>Actions (a) W(a0) W(a1) W(a2)<br>+s | | all | YV Recurrent connections Soleolec<br>c Real grid cell rate maps d With linear activations e With ReLu activations f Band cells<br>Cell rate maps Autocorrelations Cell rate maps Autocorrelations<br>**----- End of picture text -----**<br>


Figure 1: **(a)** Sequence prediction in spatial navigation tasks test abstract spatial understanding since some sensory predictions can only be done by knowing (generalising) certain rules e.g. North + East + South + West = 0 or Parent + Sibling + Niece = 0. Note, we use sequences drawn from much larger graphs. **(b)** Transformer with recurrent position encodings. **(c)** Real grid cell rate-maps (Hafting et al., 2005). **(d-f)** Learned position embedding rate-maps (i.e. average activity at each spatial location; plots are spatially smoothed). **(d-e)** Resembling grid cells with **(e)** linear activation or **(e)** ReLu activation post transition. **(f)** Resembling band cells (Krupic et al., 2012). 

_**x**_ 5 = cat. For simplicity, we treat sensory observations as one-hot vectors, thus the prediction problem is a classification problem. 

When faced with an unseen stimulus-action pair (e.g. _**x**_ 4 = pig _,_ _**a**_ 4 = West above; an action you have never taken at that stimulus before), successful prediction requires more than just remembering specific sequences of stimulus-action pairs; knowledge of the rules of space must be known; i.e. North + East + South + West = 0 allows prediction of _**x**_ 5 = cat. Crucially, such rules _generalise_ to any 2D spaces and may therefore be _transferred_ to aid prediction in entirely novel 2D environments. This is powerful, since unobserved relations between observed stimuli can be inferred in a zero-shot manner. 

However, these relational rules are not ‘known’ _a priori_ and therefore must be learnt. We therefore train across multiple different spatial environments which share the same underlying 4-connected Euclidean structure (Figure 1a) - this means the model must learn and generalise the abstract structure of space to use for prediction in new environments. 

To perform on these tasks, the three modifications to the transformer are: 

1. Recall equation 1; _**y** t_ = _softmax_ ( _**[q]**_ ~~_√_~~ _[t]_ _**[K]** dk[T]_[)] _**[V]**_[ ,][where] _**[Q]**_[=] _**[HW]**[q]_[,] _**[K]**_[=] _**[HW]**[k]_[,] _**[V]**_[=] _**HW** v_ , and _**H**_ is a matrix of inputs and position encodings (i.e. its rows are _**h** t_ = [ _**x** t,_ _**e** t_ ]). We restrict these weight matrices such that queries ( _**Q**_ ) and keys ( _**K**_ ) are the same; _**Q** ,_ _**K**_ = _**EW** e_ . We refer to this matrix as _**E**_ **[˜]** . Thus the keys and queries only focus on _position_ encodings. Meanwhile, values are exclusively dependent on the _stimulus_ component of _**H**_ i.e. _**V**_ = _**XW** x_ . We refer to this matrix as _**X**_ **[˜]** . 

**==> picture [315 x 27] intentionally omitted <==**

This is an extreme version of the realisation that, in transformers, best performance is when position encodings are used to compute keys and queries, but not values. 

2. We use causal transformers; the key and value matrices contain the projected position encodings and sensory stimuli respectively at all _previous_ time-steps (i.e. _**e** <t_ and _**x** <t_ ). This is equivalent to causal ‘unmasking’ as the agent wanders the environment accumu- 

3 

Published as a conference paper at ICLR 2022 

Figure 2: **(a)** The TEM model, with a path integration component (equation 3) and a memory network component (equation 5 and 6). TEM path integrates _**g**_ and makes sensory predictions _**x**_ via its memory network (dashed lines are additional connections for inference). **(b)** TEM recapitulates a host of empirically described cell representations (Whittington et al., 2020). Top/bottom row: example TEM MEC/Hippocampal representations (plots are spatially smoothed). Figures adapted from Whittington et al. (2020). **(c)** Schematic of TEM (adapted from Sanders et al. (2020)), showing that the _same_ cortical representations (LEC and MEC) are reused in different environments allowing for generalisation, facilitated by _different_ hippocampal combinations. **(d)** The TEM hippocampal conjunction is an outer product - cells receive input from particular MEC and LEC cells. 

lating new experiences (not-yet-experienced stimulus-position pairs are inaccessible to the agent). Meanwhile the query at each time-point is the _present_ positional encoding _**e** t_ . 

3. The position encodings are recurrently generated (as in Wang et al. (2019); Liu et al. (2020)); _**e** t_ +1 = _σ_ ( _**e** t_ _**W** a_ ), where _**W** a_ is a _learnable_ action-dependent weight matrix, and _σ_ ( _· · ·_ ) is a non-linear activation function. This means that unlike traditional transformers, position encodings can be optimised and not the same for every sequence. It now becomes interesting to see what representations are learned. 

These modifications are sufficient to learn spatial representations, in the position encodings, that mimic representations observed in the brain (Figure 1C; see Appendix for model and training details). The rest of this paper now explains why this is not a surprising result; namely we show that a transformer with recurrent positional encodings is closely related to current neuroscience models of the hippocampus and surrounding cortex (Whittington et al., 2020; Uria et al., 2020). Here we focus on the Tolman-Eichenbaum Machine (TEM) (Whittington et al., 2020), though the same principles apply for Uria et al. (2020). 

The critical points are: 1) the memory component of TEM can be viewed as a transformer selfattention, since the TEM memory network is analogous to a Hopfield network (Hopfield, 1982) which have recently been shown to be closely related to transformers (Ramsauer et al., 2020); 2) TEM path integration (see below) can be viewed as a way to learn a position encoding. 

## 4 TEM 

The Tolman-Eichenbaum Machine (TEM; Figure 2, further details in Appendix) is a neuroscience model that captures many known neural phenomena in hippocampus (HPC) and entorhinal cortex 

4 

Published as a conference paper at ICLR 2022 

(medial/lateral; MEC/LEC). TEM is a sequence learner trained on tasks exactly like the one described in the previous section. TEM consists of two parts; 

**1)** A module that aims to understand where it is in space, using a representation _**g**_ to represent location. To update its location, TEM uses _path-integration_ - the accumulation of self movement vectors _**a**_ - enacted in a recurrent neural network: 

**==> picture [235 x 11] intentionally omitted <==**

Where _**W** a_ is a learnable action dependent weight matrix and _σ_ ( _· · ·_ ) is a non-linear activation function. It is in this path-integrating representation _**g**_ that TEM learns grid and other entorhinal cells for self-localisation (Figure 2b). 

**2)** To make sensory predictions, location representations _**g**_ alone are not enough; they must each link to a sensory observation _**x**_ , corresponding to the stimulus at that position. Note that these links are specific to an environment, since each environment consists of a different arrangement of stimuli in space (i.e. different stimulus-position pairings). 

The linking is done by binding every element of _**g**_ with every element of _**x**_ , in other words an outer product that is flattened back into a vector; 

**==> picture [238 x 13] intentionally omitted <==**

These conjunctive _**p**_ representations are stored in ‘fast weights’[1] via Hebbian learning; 

**==> picture [233 x 30] intentionally omitted <==**

And they can later be retrieved using an attractor network (a continuous version of the Hopfield network). Here a query vector _**q**_ (details next paragraph) is inputted into the network and updated via; 

**==> picture [227 x 11] intentionally omitted <==**

where _σ_ ( _· · ·_ ) is a non-linear activation function; a ReLu in TEM. Crucially, because the memories are formed using both _**g**_ and _**x**_ , they can be retrieved (pattern-completed) using just one of those representations alone i.e. ‘what did I see the last time I was here’ or ‘where was I the last time I saw this’. To retrieve a memorised conjunction _**p**_ , TEM imagines (path-integrates) the next location _**g**_ and provides this as input to the attractor network in the form _**q**_ = _flatten_ ( 1 _[T]_ _**g**_ ). Equation 6 is then iterated until a memory is retrieved. 

Finally, to make sensory predictions, the retrieved conjunctive memory ( _**p**[retrieved] t_ ) is ‘deconjunctified’ into sensory and location components. The sensory component is obtained by unflattening _**p**[retrieved] t_ and summing over the _**g**_ dimension (Figure 8); 

**==> picture [290 x 12] intentionally omitted <==**

Finally, to make the sensory prediction _**x**[retrieved] t_ is fed through a MLP _**z** t_ = _fθ_ ( _**x**[retrieved] t_ )) to classify (predict) the upcoming sensory observation. 

**˜** It is also possible, and often helpful, to project _**g**_ and _**x**_ via _**W** g_ and _**W** x_ ; **˜** _**g**_ = _**gW** g_ and _**x**_ = _**xW** x_ before they are combined conjunctively[2] . 

## 5 TEM AS A TRANSFORMER 

Here we show that the above equations of TEM can be written so that: 1) the memory retrieval components looks like a transformer self-attention; 2) the path integration representation, _**g**_ look like position encodings. 

> 1We note such ‘fast weights’ have previously been thought of as an alternative to the LSTM (Ba et al., 2016a). 

> 2In fact, in the TEM code online, _**W** g_ and _**W** x_ are set as fixed weight matrices, where _**W** g_ sub-samples _**g**_ and _**W** x_ transforms (compresses) _**x**_ from a one-hot to a two-hot representation. 

5 

Published as a conference paper at ICLR 2022 

**==> picture [382 x 84] intentionally omitted <==**

**----- Start of picture text -----**<br>
Transformer  TEM<br>(with causal attention mask) y3 x3<br>k0 v0 k1 v1 k2 v2 Key, Value k0 v0 k1 v1 k2 v2<br>iW k iW v<br>q0 q1 q2 q3 Query q0 q1 q2 q3<br>iW q<br>e0 x0 e1 x1 e2 x2 e3 ? position encodingInput with  g0 x0 g1 x1 g2 x2 g3 ?<br>**----- End of picture text -----**<br>


Figure 3: Self-attention in **(a)** Transformers and **(b)** TEM. 

1) When considering the TEM memory retrieval process more closely (in this analysis, for direct comparison, we are only considering 1 attractor step in TEM with no non-linearity), we see that the _t_ attractor update _**q** t_ _**M** t_ = _**q** t_ � _τ_ _**[p]** τ[T]_ _**[p]**[τ]_[is simply equal to] 

**==> picture [252 x 29] intentionally omitted <==**

Since [ _**q** t_ _**p**[T] τ_[]][is][just][a][dot-product][(][[] _**[q]**[t][·]_ _**[ p]**[τ]_[]][),][a][single][step][of][the][attractor][just][retrieves][memories] weighted by their similarity (dot product) to the query. As noted by Ramsauer et al. (2020), this is exactly like a transformer but without the softmax scaling the dot-products. Thus the TEM memory retrieval process behaves like transformer self-attention. 

2) We can however go further since TEM’s input to the transformer (i.e. **˜** the TEM memories) **˜** are special; they are learnable and built from an outer product between **˜** _**g**_ and _**x**_ ( _**p** τ_ = _flatten_ ( _**x**[T] τ_ **˜** _**[g]**_ **[˜]** _[τ]_[)] ), and these memories can be retrieved by a query based on **˜** _**g**_ or **˜** _**x**_ alone (e.g. _**q** t_ = _flatten_ ( 1 _[T]_ _**g** t_ )). Together, these properties mean we can reduce the above dot product even further; 

**==> picture [318 x 12] intentionally omitted <==**

Where _x_ ˜[¯] =[�] _i_[(] _**[x]**_ **[˜]** _[τ]_[)] _[i]_[ and] **[ Λ]** _[x]_[ is a diagonal matrix with elements][ ¯˜] _[x][τ]_[(see Appendix for an alternative] derivation using vector elements). Thus to retrieve a conjunctive _**p**_ memory, all that was necessary is weighting past _**p**_ representations via ‘self-attention’ of **˜** _**g** t_ to past representations _**G**_ **[˜]** . To simplify this even further, we consider what happens when we ‘deconjunctify’ _**p**[retrieved] t_ to obtain the **sensory component of the memory** . Following the TEM procedure described above (Figure 8); 

**==> picture [381 x 29] intentionally omitted <==**

the sensory component of the memory is weighting pastWhere **Λ** _g_ is a diagonal matrix with elements _g_ ˜[¯] _τ_ =[�] _i_[(] _**[g]**_ **[˜]** _**x**_ **˜** _[τ]_ representations with via ‘self-attention’[)] _[i]_[.][Now all that is necessary to retrieve] of _**g**_ **˜** _t_ to past representations _**G**_ **[˜]** . This equation is now very similar to equation 1 except without the softmax and with additional weightings **Λ** _x_ and **Λ** _g_ . These weighting however are likely learned to be constant ( _α_ ) because otherwise some memories will be preferentially retrieved. In this case TEM is retrieving memories using 

**==> picture [317 x 26] intentionally omitted <==**

Which can be seen to be very closely related to the transformer equation (shown on the right), and diagrammatically shown in Figure 3. The model presented in this paper utilises the full transformer softmax rule. 

**The TEM-transformer** . Thus the TEM-transformer (TEM-t; from Section 3) is this transformer that is directly analogous to TEM. Additional modelling details (analogous to modelling details in TEM) can be found in the Appendix. TEM-t offers dramatic performance improvements over the original TEM model (Figure 4; code will be released on publication). In particular, 1) Sample 

6 

Published as a conference paper at ICLR 2022 

**==> picture [211 x 11] intentionally omitted <==**

**----- Start of picture text -----**<br>
a b<br>**----- End of picture text -----**<br>


Figure 4: TEM-t is a more efficient learner than TEM, both in **(a)** sample efficiency and **(b)** time per gradient step. Zero-shot accuracy is prediction accuracy when taking links it has never taken before, but to a state it has visited before. Successful accuracy here is only possible with learned and generalised spatial knowledge. We have used the code from TEM from the TEM authors original code https://github.com/djcrw/generalising-structural-knowledge, and so have not optimised it for speed of learning etc, so we cannot claim this to be a fair comparison, nevertheless the difference is stark. We note that in the TEM paper, the authors say it takes up to 50,000 gradient updates for full training, whereas we stopped at 20,000. 

efficiency is increased; TEM-t requires many fewer data samples than TEM, and thus training time is reduced 2) TEM-t can tackle much larger problems, with the ability to store and retrieve many more memories (not shown here). Additionally to improved performance, TEM-t learns grid cells (Figure 1) and has potential implications for what place cells are (see next section). 

**Path integrating position encodings.** This leads us to an interesting observation; we see that TEM’s representations for path integration _**g**_ plays the role of position encodings in transformers. However the structure of these positional encodings are not hard-coded, but instead _learned_ via path integration (the structure of space!), with the particular position encoding depending on the particular sequence of actions taken. Other (non-spatial) structural representations could also be **learned** depending on the task at hand, i.e. grammar for language. This is a very different (and we think fruitful) re-understanding of position encodings; representing ‘location’ in a (learned) structure that can be inferred on the fly. 

## 6 PLACE CELLS IN TRANSFORMERS 

Here we discuss, and demonstrate, how TEM-t offers a new interpretation of place representations. To do so we utilise a recent suggestion of how the transformer update can be performed in biological hardware (Krotov & Hopfield, 2020). In particular, self-attention (equation 1) can be split into two steps which correspond to two pools of neurons (Figure 5A); 1) calculate _softmax_ ( _**[q]**_ ~~_√_~~ _[t]_ _**[K]** dk[T]_[)][.][2)] multiply by _**V**_ . In this light, _**K**_ and _**V**_ can simply be seen as weight matrices between feature neuron (representing the query) and memory neurons (computing the softmax). 

Since memory neurons are sparsely activated due to the softmax, they appear to have a spatial tuning for each environment resembling hippocampal place cells (Figure 5D-E; note Krotov & Hopfield (2020) stated memory neurons may correspond to place cells but without simulation). Similarly to experimentally recorded place cells, these neurons remap randomly between environments i.e. place cells being neighbours in one environment is not predictive of them being neighbours in another (unlike grid cells which maintain their phase neighbours across environments). 

We can curate this architecture for the specifics of TEM-t. TEM-t explicitly considers factorised _**g**_ and _**x**_ representations (e.g. MEC and LEC), which project to feature neurons in hippocampus **˜** (or still **˜** in cortex). Thus the feature neurons consist of two separate sub-populations, _**g**_ = _**gW** g_ and _**x**_ = _**xW** x_ , but which can connect to the same memory neurons in hippocampus (Figure 5B-C). These feature sub-populations are updated alternately rather than simultaneously, depending on the direction of retrieval; for example, when retrieving **˜** _**x**_ the **˜** _**g**_ feature neurons stay constant while the **˜** _**x**_ 

7 

Published as a conference paper at ICLR 2022 

**==> picture [356 x 123] intentionally omitted <==**

**----- Start of picture text -----**<br>
A Memory neurons B C F G<br>K V G ˜ X ˜ g ˜ 1 g ˜ 2 g ˜ 3 x ˜ x 1 ˜ 2 x ˜ 3 HPC G ˜ X ˜ c ˜<br>c ˜ 1 c ˜ 2 c ˜ 3<br>g ˜ x ˜ g ˜ x ˜ g ˜ x ˜<br>D Feature neurons e000 Environment 1 Cx Vii E Environment 2 000 1CC?! Wg Wx g ˜ 600 1 g ˜ 2 g ˜ 3 x ˜ x 1 ˜ 2 x ˜ 3<br>Remapping<br>ERG ESE MEC g LEC x 6000 g ˜ x ˜<br>**----- End of picture text -----**<br>


Figure 5: TEM-Transformer neural architecture. **(a)** Krotov & Hopfield (2020) describe a neurally plausible architectural instantiation the ‘Hopfield networks is all you need’ with a separation between ‘feature’ neurons (i.e. _**h**_ ) and memory neurons (i.e. softmax( _**q** t_ _**K**[T]_ ). **(b-c)** This can be extended for TEM-t, but now the feature neurons are not all updated simultaneously, but only those across brain regions. **(d)** Memory neurons resemble hippocampal place cells and **(e)** remap randomly across environments. **(f)** A possible architecture where cortical neurons project to feature neurons in hippocampus which in turn project to memory neurons in hippocampus. **(g)** Additional brain regions can be included easily in this architecture with minimal increase in hippocampal neuron number. 

neurons are updated (in turn updating _**x**_ in LEC). In this vein, hippocampal memories link together cortical representations in potentially disparate brain areas. Thus TEM-t instantiates hippocampal indexing theory (Teyler & Rudy, 2007), which states that hippocampus provides an index that binds together cortical patterns across different brain regions. 

The randomly remapping place cells described one paragraph ago cannot be the full picture since we know that place cell remapping is not random; instead individual place cells preferentially remap to locations consistent particular grid cell firing (as predicted by conjunctive memory cells _**p**_ in TEM and verified experimentally in Whittington et al. (2020)). However another mechanism for this phenomena born from TEM-t could be as follows.(Figure 5F) then there will be hippocampal spatialShould the feature neurons exist in hippocampuscells _**g**_ **˜** that maintain their relationship **˜** to grid cells across different environment (as they are inherited from _**g**_ via a projection _**g**_ = _**gW** g_ ). Thus acrossgrid cells (e.g.the population _**g**_ **˜** and those that don’t (e.g.of hippocampal cells,memory neurons andthere will be those that _**x**_ **˜** ), maintainbut the population effect willtheir relationship to exist, just like what is experimentally observed. 

As a note, the particular relationship of our model to the model of Krotov & Hopfield (2020), is what they refer to as a ‘type B’ model. These are models with contrastive normalisation on the memory neurons (via a softmax in our case), as opposed to ‘type B’ models which have a power activation function on the memory neurons. TEM (left hand side of Equation 11) corresponds to a linear activation function on the memory neurons, and is directly analogous to the original Hopfield energy. Secondly, the notion that there are two types of feature neurons that can be bound together in the same memory, was explored in Krotov & Hopfield (2016) where pixel intensities were associated with labels of those images. In TEM-t, one of the feature vectors, _**g**_ , is learned via a RNN and structures itself according to the underlying task structure. 

As an additional aside, we note that Krotov & Hopfield (2020) architectures does not solve the scaling problem of conventional Hopfield networks; the number of memories that original Hopfield networks could store scaled linearly with the dimensionality of the recurrent attractor network (Amit et al., 1985). While recent analytical work has shown with exponential power activation functions, _N_ the number of memories that can be stored to scale as 2 2 , where _N_ is the dimensionality of the feature neurons (Demircigil et al., 2017). This is a considerably more favourable scaling. However, unfortunately the architecture from Krotov & Hopfield (2020) instead requires a growing number of memory neurons (one for each memory), so the number of memories is still linear with the number of neurons! We note that mathematically derived scaling law was for an exponential activation function, not with a softmax as we use here. 

8 

Published as a conference paper at ICLR 2022 

## 7 DISCUSSION 

We have shown that TEM, a current model of the hippocampal formation, is closely related to a transformer with recurrent position encodings. We now consider some wider implications for neuroscience. 

**Multiple cortical inputs to hippocampus.** TEM considers hippocampal conjunctions between two cortical regions ( _**g**_ and _**x**_ ). It is, however, possible to consider conjunctions of more than two brain regions. Indeed hippocampal neurons often respond to more than two task variables (McKenzie et al., 2014). In TEM, the naive approach of a ‘triple’ (or higher) conjunction would increase the number of hippocampal neurons would increase by a factor ofregion _**c**_ **˜** . TEM-t does not scale so badly. Instead it just requires an additional _nc_ ; the number of neurons from brain _nc_ feature neurons, and the number of memory neurons can stay the same since the each hippocampal memory neuron can simply index a memory across three (or more), rather than two, brain regions (Figure 5G). 

Withmemory in the other brain regions i.e.multiple inputs to hippocampus _**x**_ **˜** [ _**x**_ **˜** and _,_ **˜** _**g** ,_ **˜ ˜** _**gc**_ can reinstate a _, . . ._ ], any subset **˜** _**c**_ memory orof those brain **˜** _**g**_ alone could reinstateareas can reinstate **˜** _**x**_ a and **˜** _**c**_ memories. As an analogy to the TEM triple conjunction, TEM-t proposes that **˜** _**c** t_ is updated via _**c**_ **˜** _t ← softmax_ (( _**g**_ **˜** _t_ _**G**_ **[˜]** _[T]_ ) _⊙_ ( _**x**_ **˜** _t_ _**X**_ **[˜]** _[T]_ )) _**C**_ **[˜]** , where _⊙_ is an element wise product. We note an alternate, **˜** and perhaps more intuitive, option could also be **˜** _**c** t_ = _softmax_ ( _**g** t_ _**G**_ **[˜]** _[T]_ + **˜** _**x** t_ _**X**_ **[˜]** _[T]_ ) _**C**_ **[˜]** . 

**Beyond hippocampus: Cortex as a Transformer.** We have considered transformers as a model of hippocampus and its connections. We know, however, that transformer representations predict language areas (Schrimpf et al., 2020), and that patients can talk and comprehend just fine with major hippocampal deficits (Elward & Vargha-Khadem, 2018). This indicates that the transformer, and TEM-like models, may also model other brain regions, such as language areas, that are seemingly independent from hippocampus (related ideas discussed in Hawkins et al. (2019); Lewis (2021) but specifically for grid cells in neocortex). This raises two questions. Firstly what is the analogue of spatial positional encodings for higher order tasks such as language, and secondly what takes the role of the memory neurons if not hippocampus. We offer some thoughts in the following two paragraphs. 

In spatial tasks, TEM and TEM-t learn positional encodings that mirror the structure of space. The implication is that positional encoding should reflect the abstract underlying properties of the task at hand. In language for example, this structure is grammar. This contrasts to the typical positional encodings in Transformers - sines and cosines - which represent a linear structure. It is our contention that positional encodings that are inferred on the fly and consist of previously learned structures (like the spatial case we have considered) would offer an interesting and potentially fruitful research direction in problems of language, maths, and logic. 

If the transformer were solely instantiated in cortex, then what about the memory neurons? It is possible that the memory neuron equivalent exists in cortex too, but for these tasks, since it is not necessary to store long term memories or bind knowledge across multiple brain areas hippocampus is not required; so short term cortical memory neurons suffice. 

## 8 CONCLUSION 

We have shown that transformers with recurrent positional encodings reproduce neural representations found in rodent entorhinal cortex and hippocampus. We then showed these transformers are close mathematical cousins to models of hippocampus that neuroscientists have developed over the last few years. We hope this work brings neuroscience and machine learning closer together, and offers understanding for both sides; for neuroscientists a road map to understanding cortical areas beyond the hippocampal formation; for machine learners a greater understanding of positional encodings in transformers. 

## REFERENCES 

Daniel J. Amit, Hanoch Gutfreund, and H. Sompolinsky. Storing infinite numbers of patterns in a spin-glass model of neural networks. _Physical Review Letters_ , 55(14):1530–1533, 1985. ISSN 00319007. doi: 10.1103/PhysRevLett.55.1530. 

9 

Published as a conference paper at ICLR 2022 

- Jimmy Ba, Geoffrey Hinton, Volodymyr Mnih, Joel Z. Leibo, and Catalin Ionescu. Using Fast Weights to Attend to the Recent Past. _Advances in Neural Information Processing Systems 29_ , 29:4331–4339, 10 2016a. ISSN 10495258. URL http://arxiv.org/abs/1610.06258http://papers.nips.cc/paper/ 6057-using-fast-weights-to-attend-to-the-recent-past.pdf. 

- Jimmy Lei Ba, Jamie Ryan Kiros, and Geoffrey E. Hinton. Layer Normalization. _arXiv preprint_ , 2016b. ISSN 1607.06450. doi: 10.1038/nature14236. URL http://arxiv.org/abs/ 1607.06450. 

- Andrea Banino, Caswell Barry, Benigno Uria, Charles Blundell, Timothy Lillicrap, Piotr Mirowski, Alexander Pritzel, Martin J Chadwick, Thomas Degris, Joseph Modayil, Greg Wayne, Hubert Soyer, Fabio Viola, Brian Zhang, Ross Goroshin, Neil Rabinowitz, Razvan Pascanu, Charlie Beattie, Stig Petersen, Amir Sadik, Stephen Gaffney, Helen King, Koray Kavukcuoglu, Demis Hassabis, Raia Hadsell, and Dharshan Kumaran. Vector-based navigation using grid-like representations in artificial agents. _Nature_ , 557 (7705):429–433, 5 2018. ISSN 0028-0836. doi: 10.1038/s41586-018-0102-6. URL http://dx.doi.org/10.1038/s41586-018-0102-6http://www.nature. com/articles/s41586-018-0102-6. 

- Tom B. Brown, Benjamin Mann, Nick Ryder, Melanie Subbiah, Jared Kaplan, Prafulla Dhariwal, Arvind Neelakantan, Pranav Shyam, Girish Sastry, Amanda Askell, Sandhini Agarwal, Ariel Herbert-Voss, Gretchen Krueger, Tom Henighan, Rewon Child, Aditya Ramesh, Daniel M. Ziegler, Jeffrey Wu, Clemens Winter, Christopher Hesse, Mark Chen, Eric Sigler, Mateusz Litwin, Scott Gray, Benjamin Chess, Jack Clark, Christopher Berner, Sam McCandlish, Alec Radford, Ilya Sutskever, and Dario Amodei. Language models are few-shot learners. _arXiv preprint_ , 2020. ISSN 23318422. 

- Yoram Burak and Ila R. Fiete. Accurate path integration in continuous attractor network models of grid cells. _PLoS Computational Biology_ , 5(2):e1000291, 2 2009. ISSN 1553734X. doi: 10. 1371/journal.pcbi.1000291. URL https://dx.plos.org/10.1371/journal.pcbi. 1000291. 

- Christopher J. Cueva and Xue-Xin Wei. Emergence of grid-like representations by training recurrent neural networks to perform spatial localization. _International Conference on Learning Representations_ , 0:1–19, 3 2018. URL http://arxiv.org/abs/1803.07770. 

- Mete Demircigil, Judith Heusel, Matthias L¨owe, Sven Upgang, and Franck Vermet. On a Model of Associative Memory with Huge Storage Capacity. _Journal of Statistical Physics_ , 168(2):288–299, 2017. ISSN 00224715. doi: 10.1007/s10955-017-1806-y. 

- Yedidyah Dordek, Daniel Soudry, Ron Meir, and Dori Derdikman. Extracting grid cell characteristics from place cell inputs using non-negative principal component analysis. _eLife_ , 5 (MARCH2016):1–36, 2016. ISSN 2050084X. doi: 10.7554/eLife.10094. 

- Alexey Dosovitskiy, Lucas Beyer, Alexander Kolesnikov, Dirk Weissenborn, Xiaohua Zhai, Thomas Unterthiner, Mostafa Dehghani, Matthias Minderer, Georg Heigold, Sylvain Gelly, Jakob Uszkoreit, and Neil Houlsby. An Image is Worth 16x16 Words: Transformers for Image Recognition at Scale. _arXiv preprint_ , pp. 1–21, 2020. URL http://arxiv.org/abs/2010.11929. 

- Rachael L. Elward and Faraneh Vargha-Khadem. Semantic memory in developmental amnesia. _Neuroscience Letters_ , 680(April):23–30, 2018. ISSN 18727972. doi: 10.1016/j.neulet.2018.04. 040. URL https://doi.org/10.1016/j.neulet.2018.04.040. 

- Dileep George, Rajeev V. Rikhye, Nishad Gothoskar, J. Swaroop Guntupalli, Antoine Dedieu, and Miguel L´azaro-Gredilla. Clone-structured graph representations enable flexible learning and vicarious evaluation of cognitive maps. _Nature Communications_ , 12(1):2392, 12 2021. ISSN 2041-1723. doi: 10.1038/s41467-021-22559-5. URL http://dx.doi.org/10.1038/s41467-021-22559-5https://linkinghub. elsevier.com/retrieve/pii/B0123693985003418http://www.nature. com/articles/s41467-021-22559-5. 

10 

Published as a conference paper at ICLR 2022 

- Nicholas J. Gustafson and Nathaniel D. Daw. Grid Cells, Place Cells, and Geodesic Generalization for Spatial Reinforcement Learning. _PLoS Computational Biology_ , 7(10):e1002235, 10 2011. ISSN 1553-7358. doi: 10.1371/journal.pcbi.1002235. URL https://dx.plos.org/10. 1371/journal.pcbi.1002235. 

- Torkel Hafting, Marianne Fyhn, Sturla Molden, May-britt Britt Moser, and Edvard I. Moser. Microstructure of a spatial map in the entorhinal cortex. _Nature_ , 436(7052):801–806, 2005. ISSN 00280836. doi: 10.1038/nature03721. 

- Jeff Hawkins, Marcus Lewis, Mirko Klukas, Scott Purdy, and Subutai Ahmad. A Framework for Intelligence and Cortical Function Based on Grid Cells in the Neocortex. _Frontiers in Neural Circuits_ , 12(January):1–15, 1 2019. ISSN 1662-5110. doi: 10.3389/fncir.2018.00121. URL https://www.numenta.com/assets/pdf/research-publications/papers/ pdfhttps://www.frontiersin.org/article/10.3389/fncir.2018.00121/ full. 

- Kaiming He, Xiangyu Zhang, Shaoqing Ren, and Jian Sun. Deep Residual Learning for Image Recognition. _Proc. Computer Vision and Pattern Recognition (CVPR)_ , pp. 770–778, 12 2016. URL http://arxiv.org/abs/1512.03385. 

- J J Hopfield. Neural networks and physical systems with emergent collective computational abilities (associative memory/parallel processing/categorization/content-addressable memory/fail-soft devices). _Biophysics_ , 79(April):2554–2558, 1982. 

- Seyed Mahdi Khaligh-Razavi and Nikolaus Kriegeskorte. Deep Supervised, but Not Unsupervised, Models May Explain IT Cortical Representation. _PLoS Computational Biology_ , 10(11), 2014. ISSN 15537358. doi: 10.1371/journal.pcbi.1003915. 

- Alex Krizhevsky, Ilya Sutskever, and Geoffrey E Hinton. ImageNet Classification with Deep Convolutional Neural Networks. _Advances In Neural Information Processing Systems_ , pp. 1–9, 2012. ISSN 10495258. doi: http://dx.doi.org/10.1016/j.protcy.2014.09.007. 

- Dmitry Krotov and John Hopfield. Large Associative Memory Problem in Neurobiology and Machine Learning. _arXiv preprint_ , pp. 1–12, 2020. URL http://arxiv.org/abs/2008. 06996. 

- Dmitry Krotov and John J. Hopfield. Dense Associative Memory for Pattern Recognition. _Advances in Neural Information Processing Systems_ , 0(Nips):1180–1188, 6 2016. ISSN 10495258. URL http://arxiv.org/abs/1606.01164. 

- Julia Krupic, Neil Burgess, and John O’Keefe. Neural Representations of Location Composed of Spatially Periodic Bands. _Science_ , 337(6096):853–857, 8 2012. ISSN 0036-8075. doi: 10.1126/science.1222403. URL http://www.sciencemag.org/content/337/ 6096/853.full.pdfhttps://www.sciencemag.org/lookup/doi/10.1126/ science.1222403. 

- Yann Lecun, Le’on Bottou, Yoshua Bengio, and Parick Haffner. Gradient-based learning applied to document recognition. _proc. OF THE IEEE_ , 1998. 

- Marcus Lewis. Hippocampal Spatial Mapping As Fast Graph Learning. _arXiv preprint_ , 0, 7 2021. URL http://arxiv.org/abs/2107.00567. 

- Xuanqing Liu, Hsiang Fu Yu, Inderjit S. Dhillon, and Cho Jui Hsieh. Learning to encode position for transformer with continuous dynamical model. _37th International Conference on Machine Learning, ICML 2020_ , PartF16814:6283–6291, 2020. 

- Sam McKenzie, Andrea J. Frank, Nathaniel R. Kinsky, Blake Porter, Pamela D Rivie, Pamela D. Rivi`ere, Howard Eichenbaum, Pamela D Rivie, Pamela D. Rivi`ere, Howard Eichenbaum, Pamela D Rivie, Pamela D. Rivi`ere, and Howard Eichenbaum. Hippocampal representation of related and opposing memories develop within distinct, hierarchically organized neural schemas. _Neuron_ , 83(1):202–215, 7 2014. ISSN 10974199. doi: 10.1016/j.neuron.2014.05.019. URL https://linkinghub.elsevier.com/retrieve/pii/S089662731400405X. 

11 

Published as a conference paper at ICLR 2022 

- John O’Keefe and J. Dostrovsky. The hippocampus as a spatial map. Preliminary evidence from unit activity in the freely-moving rat. _Brain Research_ , 34(1):171–175, 11 1971. ISSN 00068993. doi: 10.1016/0006-8993(71)90358-1. URL http://linkinghub.elsevier. com/retrieve/pii/0006899371903581. 

- Hubert Ramsauer, Bernhard Sch¨afl, Johannes Lehner, Philipp Seidl, Michael Widrich, Lukas Gruber, Markus Holzleitner, Milena Pavlovi´c, Geir Kjetil Sandve, Victor Greiff, David Kreil, Michael Kopp, G¨unter Klambauer, Johannes Brandstetter, and Sepp Hochreiter. Hopfield networks is all you need. _arXiv preprint_ , 2020. ISSN 23318422. 

- Honi Sanders, Matthew Wilson, Mirko Klukas, Sugandha Sharma, and Ila Fiete. Efficient Inference in Structured Spaces. _Cell_ , 183(5):1147–1148, 11 2020. ISSN 00928674. doi: 10.1016/j. cell.2020.11.008. URL https://doi.org/10.1016/j.cell.2020.11.008https: //linkinghub.elsevier.com/retrieve/pii/S0092867420315191. 

- Martin Schrimpf, Idan Blank, Greta Tuckute, Carina Kauf, Eghbal Hosseini, Nancy Kanwisher, Joshua Tenenbaum, and Evelina Fedorenko. The neural architecture of language: Integrative reverse-engineering converges on a model for predictive processing. _bioRxiv preprint_ , 2020. doi: 10.1101/2020.06.26.174482. 

- Ben Sorscher, Gabriel C Mel, Surya Ganguli, and Samuel A Ocko. A unified theory for the origin of grid cells through the lens of pattern formation. _Advances in Neural Information Processing Systems 32_ , 32(NeurIPS):10003–10013, 2019. 

- Kimberley L. Kimberly L. Kimberley L. Kimberly L. Stachenfeld, Matthew M. Botvinick, and Samuel J. Gershman. The hippocampus as a predictive map. _Nature Neuroscience_ , 20(11):1643– 1653, 2017. ISSN 15461726. doi: 10.1038/nn.4650. 

- Timothy J Teyler and Jerry W Rudy. The hippocampal indexing theory and episodic memory: Updating the index. _Hippocampus_ , 17(12):1158–1169, 12 2007. ISSN 10509631. doi: 10.1002/hipo.20350. URL https://onlinelibrary.wiley.com/doi/10.1002/ hipo.20350http://doi.wiley.com/10.1002/hipo.20350. 

- Benigno Uria, Borja Ibarz, Andrea Banino, Vinicius Zambaldi, Dharshan Kumaran, Demis Hassabis, Caswell Barry, and Charles Blundell. The spatial memory pipeline: A model of egocentric to allocentric understanding in mammalian brains. _bioRxiv preprint_ , pp. 1–52, 2020. ISSN 26928205. doi: 10.1101/2020.11.11.378141. 

- Ashish Vaswani, Noam Shazeer, Niki Parmar, Jakob Uszkoreit, Llion Jones, Aidan N. Gomez, Łukasz Kaiser, and Illia Polosukhin. Attention is all you need. _Advances in Neural Information Processing Systems_ , 2017-Decem(Nips):5999–6009, 2017. ISSN 10495258. 

- Zhiwei Wang, Yao Ma, Zitao Liu, and Jiliang Tang. R-Transformer: Recurrent Neural Network Enhanced Transformer. _arXiv preprint_ , 0:1–11, 2019. URL http://arxiv.org/abs/1907. 05572. 

- James CR R. Whittington, Timothy H. Muller, Shirley Mark, Caswell Barry, Neil Burgess, Timothy E.J. EJ Behrens, Guifen Chen, Caswell Barry, Neil Burgess, and Timothy E.J. EJ Behrens. The Tolman-Eichenbaum Machine: Unifying Space and Relational Memory through Generalization in the Hippocampal Formation. _Cell_ , 183(5):1249–1263, 11 2020. ISSN 00928674. doi: 10.1016/ j.cell.2020.10.024. URL https://doi.org/10.1016/j.cell.2020.10.024https: //linkinghub.elsevier.com/retrieve/pii/S009286742031388X. 

- Daniel L K Yamins, Ha Hong, Charles F. Cadieu, Ethan A. Solomon, Darren Seibert, and James J. DiCarlo. Performance-optimized hierarchical models predict neural responses in higher visual cortex. _Proceedings of the National Academy of Sciences of the United States of America_ , 111 (23):8619–8624, 2014. ISSN 10916490. doi: 10.1073/pnas.1403112111. 

12 

Published as a conference paper at ICLR 2022 

## A APPENDIX 

## A.1 THE MATHS USING ELEMENTS 

Heremultiplicative combination of every pair of elements inwe derive the main results using vector and matrix _**x**_ **˜** andelements. **˜** _**g**_ , then Since each element in _**p**_ is 

**==> picture [220 x 11] intentionally omitted <==**

Where we label the elements of vector _**p**_ with two indices even though it is a vector. Similarly, the memory matrix uses 4 indices; 

**==> picture [246 x 22] intentionally omitted <==**

**Retrieving a memory via path integration.** Querying the network becomes _qij_ = _g_ ˜ _i[P I]_ , which reduces to 

**==> picture [303 x 69] intentionally omitted <==**

**Retrieving a memory using a sensory observation alone.** Similarly when the query is the sensory observation alone _qij_ = _xj_ 

**==> picture [300 x 70] intentionally omitted <==**

**Retrieving a memory using a sensory observation and path integration.** When the query is _qij_ = _gi[P I] xj_ , and we want to retrieve a position encoding memory 

**==> picture [308 x 70] intentionally omitted <==**

## A.2 DETAILS OF IMPLEMENTATION 

We will release code on publication. 

**Scaling beta.** Since the number of memories is not constant, we use an adaptive _β_ parameter in the softmax. This is because normalisation term in the softmax sums the number of memories, and so more memories down-weights probabilities. We want a self-attention value to not be affected by the number of elements in the set. In particular, we weight the softmax by _log_ ( _nmemories_ ). 

**Losses.** We use same set of losses as in TEM; 

- a one-step sensory prediction cross entropy loss, i.e. using _**g** t[P I]_ as input to the memory retrieval process 

13 

Published as a conference paper at ICLR 2022 

- a sensory prediction cross entropy loss using _**g** t_ as input to the memory retrieval process 

- a squared error loss between _**g** t_ and _**g** t[P I]_ 

- l2 weight regularisation 

- l2 regularisation on _**g** t_ 

**Normalisation.** We find that using layernorm (Ba et al., 2016b) on the positional encodings (not in the RNN, but on the input to transformer) to be beneficial, since the memory retrieval process can then be standardised - no one memory is up-weighted relative to others. Using layernorm before self-attention in transformers is common practice (Vaswani et al., 2017). For simplicity, we use fixed weights on the layer norm, i.e. is is just a z score of _**g**_ , Since we use a one-hot encodings of our sensory representations, they are already normalised. 

**Stabilising position representations.** Recurrently generated positional encodings accumulate noise and drift. While bespoke path integration networks from neuroscience mitigate noise by enforcing their neural representations to stay close to a neural manifold (Burak & Fiete, 2009), this can not be guaranteed in learned recurrent networks. One method of stabilisation is via sensory landmarks - i.e. ‘what positional encoding did I have the last time I saw **˜** this landmark’. In this vein TEM uses the following query to the memory network; _**q** t_ = _flatten_ ( _**x**[T] t_[1][)][, and] **[ memories of positional] encodings** are retrieved as; 

**==> picture [374 x 29] intentionally omitted <==**

The final position encoding, _**g**_ is computed on a basis of path integration ( _**g** t[P I]_ ; equation 3) and stored landmark information ( _**g** t[retrieved]_ **˜** ; equation 17), i.e. _**g** t_ = _**g** t[P I]_ + _fθ_ ( _**g** t[retrieved] ,_ _**g** t[P I]_ )( _**g** t[retrieved] −_ _**g** t[P I]_ ), where _**g**[retrieved]_ = _fθ_ ( _**g**[retrieved]_ ) and _fθ_ ( _· · ·_ ) are different MLPs. 

**˜** We note that a better query to the memory network would be _**q** t_ = _flatten_ ( _**x**[T] t_ _**[g]** t[P I]_ ) since sensory observationsretrieved memory ismay be ( _**x**_ aliased, **˜** _t_ _**X**[T] ⊙_ including _**g** t[P I]_ _**G**_ ) **Λ** _x_ _**gG** t[P I]_ . This is perhaps, different to what would be anticipated;can help disambiguate such aliasing. In this case, the using an element wise product rather than an addition. Translating this other TEM memory retrieval **˜** process into transformers we get _**g** t[retrieved]_ = _fθ_ ( _softmax_ ( _**x** t_ _**X**[T] ⊙_ _**g** t[P I]_ _**G**_ ) _**G**_ ), this can be thought of as another attention head i.e. from input [ _**g** ,_ _**x**_ ], the key and query ‘attends’ to _**x**_ while the value ‘attends’ to _**g**_ . 

**When to add memories.** Memories should not be added at every step, otherwise the self-attention mechanism would be biased towards memories (locations) that have been visited more frequently. This is not a problem typically addressed in transformer, but here to mitigate this issue memories are only added when existing memories for that particular conjunction do not already exist i.e. if there is a memory already with the present combination of _**g**_ and _**x**_ (similarity determined by dot product) then no new memory is added[3] . 

**Multiple iterations:** Though in our simulations we only used a single iteration of the transformer block,(2020)).it isHerepossiblethe retrievedto use multiplesensoryiterationsmemory - _**x**_ **˜** just _[retrieved] t_ like acanHopfieldbe fednetworkinto the(asnextin Ramsaueriteration, alonget al. with positional encoding i.e. the path integrated _**g**_ . In this case (see Appendix for derivation), TEM suggests that _**x**_ **˜** _t_ is iteratively updated via _**x**_ **˜** _t ← softmax_ ( _**x**_ **˜** _t_ _**X**_ **[˜]** _[T] ⊙_ _**g**_ **˜** _t_ _**G**_ **[˜]** ) _**X**_ **[˜]** , but with the first iteration via **˜** _**x** t ← softmax_ ( _**g**_ **˜** _t_ _**G**_ **[˜]** ) _**X**_ **[˜]** . The multiplicative term in the softmax is perhaps unexpected - it may be thought that it should be additive instead. 

**Place-like representations without a softmax:** Here we chose a softmax activation function on the memory neurons to make the relationship between TEM and transformers exact. However was this choice necessary to observe place cells in the memory neurons? While we have not examined this experimentally, we suspect place-like representations would emerge for a variety of activations, since memories must still be sparsely activated for correct prediction. We leave this for future work to verify, but note again that power and exponential activations have been shown to have a 

> 3The TEM model actually does something very much like this - memories are only added if they did not already exist - _**M**_ =[�] _τ_[(] _**[p]**[τ][−]_ _**[p]**_[ˆ] _[τ]_[)] _[T]_[ (] _**[p]**[τ]_[+] _**[p]**_[ˆ] _[τ]_[)][, where] _**[p]**_[ˆ] _[τ]_[is the memory that was retrieved at] _[ τ]_[, i.e.][only the] un-predicted components of the memory _**p** τ_ are added. 

14 

Published as a conference paper at ICLR 2022 

**==> picture [342 x 110] intentionally omitted <==**

**----- Start of picture text -----**<br>
Hidden structure<br>Passive actions<br>J++] t t-<- 4 ++ |<}<br>Sensory observations<br>?<br>Trials<br>— Environments<br>**----- End of picture text -----**<br>


Figure 6: Learning to predict the next sensory observation in environments that share the same structure but differ in their sensory observations. TEM only sees the sensory observations and associated action taken, it is not told about the underlying structure - this must be learned. 

much greater memory capacity (Krotov & Hopfield, 2016; Demircigil et al., 2017) than traditional Hopfield nets with linear activation. 

## A.3 ADDITIONAL DETAILS OF THE SPATIAL TASK 

We formalise a task type that not only relates to known hippocampal function, but also tests the learning and generalising of abstract structural knowledge. We formalise this via relational understanding on graph structures (a graph is a set of nodes that relate to each other). 

Should one passively move on a graph (e.g. Figure 6), where each node is associated with a nonunique sensory observation (e.g. an image of a banana), then predicting the subsequent sensory observation tests whether you understand the graph structure you are in. For example, if you return to a previously visited node (Figure 6 pink) by a new direction - it is only possible to predict correctly if you know that a _right → down → left → up_ means you’re back in the same place. Knowledge of such loop closures is equivalent to understanding the structure of the graph. 

We thus train our models on these graphs with it trying to predict the next sensory observation. Our models are trained on many environments sharing the same structure, e.g. 2D graphs (Figure 6), however the stimulus distribution is different (each vertex is randomly assigned a stimulus). Should it be able to learn and generalise this structural knowledge, then it should be able to enter new environments (structurally similar but with different stimulus distributions) and perform feats of loop closure on first presentation. 

Formally, given data of the form _D_ = _{_ ( _**x**[k] ≤T[,]_ _**[ a]**[k] ≤T_[)] _[}]_[ with] _[ k][∈{]_[1] _[,][ · · ·][, N][}]_[ (which environment it] is in), where _**x** ≤T_ and _**a** ≤T_ are a sequence of sensory observations and associated actions/relations (Figure 6), _N_ is the number of environments in the dataset, and _T_ is the duration of time-steps in each environment, our model should maximise its probability of observing the sensory observations for each environment. 

The sensory stimuli are chosen randomly, with replacement, at each node. We understand that this is not like the real world, where adjacent locations have sensory correlations - most notable in space (though names in a family tree will be less correlated). Sensory correlations help with sensory predictions, thus if we use environments with sensory correlations, we would not know what was causing the learned representations, sensory correlations, or transition structure. To answer this question cleanly, and to know that transition structure is the sole cause, we do not use environments with sensory correlations. 

15 

Published as a conference paper at ICLR 2022 

## A.4 ADDITIONAL DETAILS OF TEM 

We present a more detailed model schematic of TEM in Figure 7. We see there are two components to TEM - a RNN for understanding position ( _**g**_ , in green top of Figure 7) that also indexes memories via ‘queries’ _**q**_ = _**W** g_ _**g**_ . A memory network that binds together _**x**_ and _**g**_ , via an outer product (middle green in 7, with more detail in Figure 8A). When the memory network is queried (red in Figure 7), it undergoes attractor dynamics to retrieve the full memory. To make a sensory prediction, the retrieved memory is ‘deconjunctified’ into a sensory representation (Figure 8C). 

**Model flow.** TEM transitions through time and infers _**g** t_ and _**p** t_ at each time-step. _**g** t_ is inferred before forming each new memory _**p** t_ . In other words variables _**g**_ and _**p**_ are inferred in the following order _**g** t_ , _**p** t_ , _**g** t_ +1, _**p** t_ +1, _**g** t_ +2 _· · ·_ . This flow of information is shown in a schematic in Figure 7. 

Independently, at each time-step, the model model asks ‘are the inferred variables what I would have predicted given my current understanding of the world (weights)’. I.e. 1) Is the inferred _**g** t_ the one I would have predicted from _**g** t−_ 1. 2) Is the inferred _**p** t_ the one I would have predicted from _**g** t_ . 3) Is _**x** t_ what I would have predicted from _**p** t_ . This leads to errors (at each timestep) between inferred and predicted variables _**g** t_ and _**p** t_ , and between sensory data _**x** t_ and its prediction. 

At then end of a sequence, these errors are accumulated, with model parameters updated along the gradient (from back-propagation through time) that matches each others variables and also matches the data. 

Since the model runs along uninterrupted, it’s activity at one time-step influence those at later timesteps. Thus when learning (using back-propagation through time - BPTT), gradient information flows backwards in time. This is important as, should a bad memory be formed at one-time step, it will have consequences for later predictions - thus BPTT allows us to learn how to form memories and latent representations such that they will be useful many steps into the future. 

## A.5 RELATED WORK 

Here we discuss and compare other models that recapitulate spatial representations found in the brain. These models fall into several categories. 1) Auto-encoder like models trained on spatial representations (Dordek et al., 2016). 2) Graph representation models (Gustafson & Daw, 2011; Stachenfeld et al., 2017). 3) Latent state inference models (George et al., 2021). 4) Path integrating models with RNNs trained on spatial representations (Cueva & Wei, 2018; Banino et al., 2018). 5) Models mixing RNNs and memory networks that are trained on sequences of sensory observations. 

We note that models (1-4) are learned using curated spatial representation, i.e. the modeller has already worked how how space works, and the model is finding an alternate representation of that space. This is not how you or I learn. Instead, we learn by extracting regularities from the sensory world, and transfer/generalise this knowledge from domain to domain. Model category (5) does unsupervised learning by predicting sequences of sensory observations alone. From just sensory observations, it can slowly build up a picture of how space is structured, and then transfer this knowledge to situations that share the same underlying spatial structure. Our model TEM-t fall in the model (5) category, along with TEM (Whittington et al., 2020) and other similar models Uria et al. (2020). 

For model to make sensory predictions as fast as possible, it is necessary to have two components. a) A RNN that understand position, and b) a memory network that can remember what you see and where you see them. Now the model can be asked what ’what will you see when heading East’ and correctly respond Cat even it it has never gone East at that location before. This is because it can simulate going East via its RNN and then retrieve the memory it had stored at that location (it must have visited the Cat location before thought!). The other models, e.g. an autoencoder, could not solve this task since it learns slow statistical structures between sensory observations over many many training examples. Thus it would be clueless to the entirely new configuration of sensory observations in the new environment. In sum, **it is necessary to have an understanding of position, and the ability to make and retrieve memories to successfully make sensory predictions as fast as possible** . 

We describe the relationship between TEM (and thus the hippocampal-entorhinal system) as close **not** because it produces the same representations, instead we are saying the relationship is close 

16 

Published as a conference paper at ICLR 2022 

**==> picture [389 x 273] intentionally omitted <==**

**----- Start of picture text -----**<br>
Transition with<br>+ action at+1 weight matrix<br>gt<br>Path integrate new g<br>Wa<br>£ oeoe _— - _<br>Wg qt<br>Wg<br>Query<br>memory<br>Mt pt Form memory  network, and<br>p from g and  retrieve<br>x, via outer  memory p via<br>product, then  attractor<br>change  dynamics<br>weights M<br>Wx<br>xt Sensory data Predict sensory<br>from p<br> @0 Step = t - @O Ft Step = t+1 »<br>**----- End of picture text -----**<br>


Figure 7: Schematic to show the model flow. Depiction of TEM at two time-points, with each time-point described at a different level of detail. Timepoint _t_ shows network implementation, _t_ + 1 describes each computation in words. Red is for model predictions, green is for updating model variables. We do not show the stabilising position encodings module here. Circles depict neurons (blue is _**g**_ , red is _**x**_ , blue/red is _**p**_ ); shaded boxes depict computation steps; arrows show learnable weights; looped arrows describe recurrent attractor. Black lines between neurons in attractor describe Hebbian weights _**M**_ . _**W** a_ are learnable, action dependent, transition weights. _**W** g_ and _**W** x_ are learnable projection matrices. Yellow arrows show training errors. 

because **we have shown a mathematical relationship between the two models** . This could not happen for most ML models as most ML systems do not have both RNN structured representations and a memory system and so is not mathematically relatable to current models of the hippocampal formation. However, equipped with the mathematical relationship, we can say that the memory part of the transformer is related to the hippocampal memory system in TEM. And the positional encodings are related to the entorhinal grid RNN system in TEM. 

A.6 FURTHER LEARNED CELL REPRESENTATIONS 

17 

Published as a conference paper at ICLR 2022 

Figure 8:sensory codeMemory formation and retrieval in TEM. **˜** _**x**_ and projected grid code **˜** _**g**_ are combined via an outer-product **(a-b)** Memory formation. **˜** _**x**[T]_ **(a)** _**g**_ **˜** , which is flattened Projected sensory to obtain a vector of place cellsa conjunction of an element from _**p**_ . eachEach place cell (denoted by a single diagonally divided cell) isof _**x**_ **˜** and _**g**_ **˜** (denoted by the two colours composing each cell). The activity of the place cell is the product of the values of these elements. **(b)** A new Hebbian memory _**p**[T]_ _**p**_ is added to the existing memory matrix _**M**_ . **(c-d)** Memory retrieval. **(c)** Multiplication of the query _**q**_ with the memory matrix _**M**_ retrieves a place code _**p**_ . This retrieved code is the sum of previously experienced codes, weighted by their similarity to the present query. This may be repeated iteratively to converge to the stored _**p**_ is reshaped and summed along the rows to average-out the _**p**_ that is most similar to _**g**_ components. _**q**_ . **(d)** The retrieved place codeThe result is _g_ ˜[¯] _**x**_ **˜** . 

18 

Published as a conference paper at ICLR 2022 

**==> picture [8 x 185] intentionally omitted <==**

**----- Start of picture text -----**<br>
A<br>B<br>**----- End of picture text -----**<br>


Figure 9: Learned grid cells ordered by grid score. We only show cells that are both active and have a grid score above 0. A gird score of 0.3-0.5 is generally considered to be a grid cell. The panels on the right hand side are the show the grid scores for the **whole population** of cells (though in some cases the grid score was not calculable e.g. if the cell has no activity; these cells are ignored in the analysis). **(a)** Grid cells learned with a linear activation function. **(a)** Grid cells learned with a ReLu activation function. 

Figure 10: Learned grid cells in hexagonal 6-connected world. 

19 

Published as a conference paper at ICLR 2022 

**==> picture [7 x 7] intentionally omitted <==**

**----- Start of picture text -----**<br>
A<br>**----- End of picture text -----**<br>


**==> picture [7 x 7] intentionally omitted <==**

**----- Start of picture text -----**<br>
B<br>**----- End of picture text -----**<br>


Figure 11: Place cells ordered by novel place cell metric. This metric assess how place-like the firing of each cell is. In particular, we look at the connected components of the firing rate map, and our metric is the ratio of ‘firing mass’ in the largest connected component versus all connected components. This metric is 1 if all the firing is in a single component, and it is lower if the firing is spread between components. **(a)** TEM-t learned memory place cells. **(b)** Our novel metric distinguishes between TEM-t RNN neurons (grid cells), and TEM-t memory neurons (place cells). 

20 

