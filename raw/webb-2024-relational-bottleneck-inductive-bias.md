---
title: "The Relational Bottleneck as an Inductive Biasfor Efficient Abstraction"
source: "https://arxiv.org/html/2309.06629v5"
author:
published:
created: 2026-09-08
description:
tags:
  - "clippings"
---
standard global,type,entry\[boolean\]subentry\[true\]

## The Relational Bottleneck as an Inductive Bias for Efficient Abstraction

Taylor W. Webb Affiliation: University of California, Los Angeles Affiliation: Correspondence to: taylor.w.webb@gmail.com    Steven M. Frankland Affiliation: Dartmouth College    Awni Altabaa Affiliation: Yale University    Simon Segert Affiliation: Princeton University    Kamesh Krishnamurthy Affiliation: Princeton University    Declan Campbell Affiliation: Princeton University    Jacob Russin Affiliation: Brown University    Tyler Giallanza Affiliation: Princeton University    Zack Dulberg Affiliation: Princeton University    Randall O’Reilly Affiliation: University of California, Davis    John Lafferty Affiliation: Yale University    Jonathan D. Cohen Affiliation: Princeton University

###### Abstract

A central challenge for cognitive science is to explain how abstract concepts are acquired from limited experience. This has often been framed in terms of a dichotomy between connectionist and symbolic cognitive models. Here, we highlight a recently emerging line of work that suggests a novel reconciliation of these approaches, by exploiting an inductive bias that we term the relational bottleneck. In that approach, neural networks are constrained via their architecture to focus on relations between perceptual inputs, rather than the attributes of individual inputs. We review a family of models that employ this approach to induce abstractions in a data-efficient manner, emphasizing their potential as candidate models for the acquisition of abstract concepts in the human mind and brain.

## Highlights

- Human learners acquire abstract concepts from limited experience. The effort to explain this capacity has fueled debate between symbolic and connectionist approaches, and motivated proposals for neuro-symbolic systems.
- The relational bottleneck principle suggests a novel way to bridge the gap. By restricting information processing to focus only on relations, the approach encourages abstract symbol-like mechanisms to emerge in neural networks.
- We present an information theoretic formulation, and review neural network architectures that implement the principle, enabling rapid learning and systematic generalization of relational patterns.
- The approach can explain phenomena ranging from the development of numerical abstractions to capacity limits in cognition; is consistent with findings from cognitive neuroscience; and offers a principle for designing more powerful artificial learning systems.

## Modeling the efficient induction of abstractions

Human cognition displays a remarkable ability to transcend the specifics of limited experience to entertain highly general, abstract ideas. Understanding how the mind and brain accomplish this has been a central challenge of cognitive science, and a major preoccupation of philosophy before that \[[1](#bib.bibx1), [2](#bib.bibx2), [3](#bib.bibx3), [4](#bib.bibx4)\]. Of particular importance is the central role played by relations, which enable human reasoners to abstract away from individual entities and identify higher-order patterns across distinct domains \[[5](#bib.bibx5), [6](#bib.bibx6)\]. For instance, when presented with the images in Figure 1, one can easily determine that a common relational pattern (ABA) is displayed on both the left and right, despite the involvement of completely different objects. This capacity is a major component underlying the human capacity for fluid reasoning \[[7](#bib.bibx7), [8](#bib.bibx8)\], and has been proposed as a key factor distinguishing human intelligence from that of other species \[[9](#bib.bibx9)\].

A long tradition in cognitive science and AI \[[10](#bib.bibx10), [11](#bib.bibx11), [12](#bib.bibx12)\] holds that this capacity for abstraction depends on processes akin to symbolic programs. A major appeal of this approach is that symbols are, by design, abstracted away from the content to which they refer, thus naturally accounting for the flexibility and systematicity of human concepts \[[13](#bib.bibx13)\]. More recently, program induction (see Glossary) has provided an account of how symbolic concepts might be learned directly from data \[[14](#bib.bibx14), [15](#bib.bibx15), [16](#bib.bibx16), [17](#bib.bibx17), [18](#bib.bibx18), [19](#bib.bibx19), [20](#bib.bibx20)\], formalizing learning as a search for the program that maximizes the likelihood of observed data. However, while this approach is capable in principle of representing any possible set of concepts \[[21](#bib.bibx21)\], the discovery of these concepts using traditional search methods often proves intractable, making it difficult in practice to identify programs with the richness and complexity of human natural concepts (though see Box 1 for discussion).

An alternative approach, connectionism, has for decades explored how cognitive abstractions might emerge through experience in general-purpose neural architectures \[[22](#bib.bibx22), [23](#bib.bibx23), [24](#bib.bibx24), [25](#bib.bibx25)\]. This endeavor has taken on new relevance with the advent of large language models, demonstrating that it is possible, in some cases, for a human-like capacity for abstraction to emerge given sufficient scaling of architecture and training data \[[26](#bib.bibx26), [27](#bib.bibx27), [28](#bib.bibx28), [29](#bib.bibx29)\]. For instance, it has recently been shown that large language models can solve various analogy problems at a level equal to that of college students \[[30](#bib.bibx30)\]. However, the ability of these models to perform abstract tasks depends on exposure to a much larger training corpus than individual humans receive in an entire lifetime \[[31](#bib.bibx31), [32](#bib.bibx32)\], thus failing to account for the data efficiency of human concept learning.

In this review, we highlight an emerging approach that suggests a novel reconciliation of these two traditions. The central feature of this approach is an inductive bias that we refer to as the relational bottleneck: a constraint that biases neural network models to focus on relations between objects rather than the attributes of individual objects. This approach enables the data efficiency associated with symbolic cognitive models, while retaining the scalable training procedures associated with neural network models (see Box 1 for further discussion of neuro-symbolic approaches). In the following sections, we first provide a general characterization of this approach, drawing on information theory, and discuss recently proposed neural network architectures that implement the approach. We then discuss the potential of the approach for modeling human cognition, relating it to existing theories and considering mechanisms through which it might be implemented in the brain.

#### Box 1: Neuro-symbolic modeling approaches

Many approaches have been proposed for hybrid systems that combine aspects of both neural and symbolic computing. Early work in this area focused on incorporating a capacity for variable-binding – a key property of symbolic systems – into connectionist systems. Notable examples of this approach include binding-by-synchrony \[[33](#bib.bibx33)\], tensor product variable-binding \[[34](#bib.bibx34)\], and BoltzCONS \[[35](#bib.bibx35)\]. A number of vector symbolic architectures have since been proposed that build on the tensor product operation, but enable more elaborate symbolic structures to be embedded in a vector space of fixed dimensionality \[[36](#bib.bibx36), [37](#bib.bibx37), [38](#bib.bibx38), [39](#bib.bibx39)\]. These approaches have all generally relied on the use of pre-specified symbolic primitives.

More recently, hybrid systems have been developed that combine deep learning with symbolic programs. In this approach, deep learning components are typically employed to translate raw perceptual inputs, such as images or natural language, into symbolic representations, which can then be processed by traditional symbolic algorithms \[[40](#bib.bibx40), [41](#bib.bibx41), [42](#bib.bibx42)\]. This approach is complemented by recent neuro-symbolic approaches to probabilistic program induction, in which symbolic primitives are pre-specified (following earlier symbolic-connectionist modeling efforts), and then deep learning is used to assemble these primitives into programs \[[17](#bib.bibx17)\].

An alternative approach (which might also be viewed as neuro-symbolic in some sense) involves the integration of key features of symbolic computing within the framework of end-to-end trainable neural systems. Examples of this approach include neural production systems \[[43](#bib.bibx43)\], graph neural networks \[[44](#bib.bibx44)\], discrete-valued neural networks \[[45](#bib.bibx45)\] (see \[[46](#bib.bibx46)\] for further discussion of normative considerations regarding discrete-valued representations), sparse causal graphs \[[47](#bib.bibx47)\], and efforts to incorporate tensor product representations into end-to-end systems \[[48](#bib.bibx48), [49](#bib.bibx49)\]. The relational bottleneck falls into this broad category, as it incorporates key elements of symbolic computing – variable-binding and relational representations – into fully differentiable neural systems that can be trained end-to-end without the need for pre-specified symbolic primitives. Relative to these other approaches, the primary innovation of the relational bottleneck framework is the emphasis on architectural components that promote the development of genuinely relational representations.

## The relational bottleneck

![Refer to caption](https://arxiv.org/html/2309.06629v5/Figure1.png)

Figure 1: The relational bottleneck. An inductive bias that prioritizes the representation of relations (e.g., ‘same’ vs. ‘different’), and discourages the representation of the features of individual objects (e.g., the shape or color of the objects in the images above). The result is that downstream processing is driven primarily, or even exclusively by patterns of relations, and can therefore systematically generalize those patterns across distinct instances (e.g., the common ABA pattern displayed on both left and right), even for completely novel objects. The approach is illustrated here with same/different relations, but other relations can also be accommodated. Note that this example is intended only to illustrate the overall goal of the relational bottleneck framework. Figure 2 depicts neural architectures that implement the approach.

We define the relational bottleneck as any mechanism that restricts the flow of information from perceptual to downstream reasoning systems to consist only of relations (see Box 2 for a formal definition). For example, consider the relational patterns depicted in Figure 1. In this example, the images on the left and right are governed by the same abstract pattern (ABA), but these patterns contain different sets of objects (dogs and cats vs. planes and cars). Given inputs representing individual objects (e.g., representations of the dog and cat images on the left), a relational bottleneck would constrain the representations passed to downstream reasoning processes to capture only the relations between these objects (e.g., whether the objects have the same shape), and discard information about the individual objects (e.g., information about dogs and cats). The result is that the images on the left will have the same representation as those on the right, despite the different objects depicted in these images. This encourages downstream processes to identify relational patterns in a manner that is abstracted away from specific instances of those patterns, and can therefore be systematically generalized to novel inputs (see Concluding Remarks for discussion of non-relational factors in human cognition). In the following section, we highlight three recently proposed neural architectures that instantiate this approach in different guises, illustrating how they utilize a relational bottleneck to induce abstract concepts in a data-efficient manner. It is also worth emphasizing that, although we focus here on artificial neural networks, the approach may also be applicable to other modeling approaches (see Outstanding Questions).

#### Box 2: The relational bottleneck principle

Information bottleneck theory \[[50](#bib.bibx50)\] provides a normative framework for formalizing the notion of a relational bottleneck. Consider an information processing system that receives an input signal $X$ and aims to predict a target signal $Y$. $X$ is processed to generate a compressed representation $Z=f(X)$ (the ‘bottleneck’), which is then used to predict $Y$. At the heart of information bottleneck theory is the idea of ‘minimal-sufficiency’. $Z$ is sufficient for predicting $Y$ if it contains all the information $X$ encodes about $Y$. That is, $I(Z;Y)=I(X;Y)$, where $I(\cdot\,;\,\cdot)$ is the mutual information. If $Z$ is sufficient, then we write $X\to Z\to Y$, meaning that $Y$ is conditionally independent of $X$ given the compressed representation $Z$. $Z$ is minimal-sufficient if it is sufficient for $Y$ and does not contain any extraneous information about $X$ which is not relevant to predicting $Y$. That is, $I(X;Z)\leq I(X;\tilde{Z})$ for any other sufficient compressed representation $\tilde{Z}$.

Achieving maximum compression while retaining as much relevant information as possible is a trade-off. It is captured by the information bottleneck objective,

$$
\mathrm{minimize}\ \mathcal{L}(Z)=I(X;Z)-\beta I(Z;Y).
$$

This objective reflects the tension between compression – which favors discarding information as captured by the first term – and the preservation of relevant information in $Z$, captured by the second term. The parameter $\beta$ controls this trade-off.

While this objective is well-defined when the joint distribution $(X,Y)$ is known, obtaining a minimal-sufficient compressed representation from data is, in general, very challenging for the high-dimensional signals that are often of interest. However, it may be possible to implicitly enforce a desirable information bottleneck for a large class of tasks through architectural inductive biases.

In particular, we hypothesize that human cognition has been fundamentally optimized for tasks that are relational in nature. We define a ‘relational task’ as any task for which there exists a minimal-sufficient representation $R$ that is purely relational. Suppose the input signal represents a set of objects,

$$
X=\left(x_{1},\,\ldots,\,x_{N}\right).
$$

A relational signal is a signal of the form,

$$
R=\left\{r(x_{i},x_{j})\right\}_{i\neq j}=\left\{r(x_{1},x_{2}),\,r(x_{1},x_{3}),\,\ldots,\,r(x_{N-1},x_{N})\right\},
$$

where $r(x_{i},x_{j})$ is a relation function. A “relation function” is a function that takes a pair of objects as input and returns a relation between them (see ‘Modeling more complex relations’ for discussion of higher-order relations). We say that a task is relational if there exists some relational signal $R$ which is sufficient for predicting the target $Y$ (i.e., $X\to R\to Y$). A relational bottleneck is any mechanism that restricts or biases the learned compressed representation of the input to be a relational representation, separated from object-level features. This gives the model a smaller space of possible compressed representations over which it must search. Moreover, this restricted space is guaranteed to contain a sufficient representation for the task and excludes many representations that encode extraneous information about $X$, promoting efficient learning of relational abstractions.

In practice, a relational bottleneck can be implemented in a learning model through the use of architectural inductive biases. One particularly useful operation is inner products of the form $\langle\phi(x_{i}),\phi(x_{j})\rangle$, which naturally capture a notion of relations in terms of similarity between learned attributes. Inner products can also capture asymmetric relations through the use of separate encoders for $x_{i}$ and $x_{j}$ (i.e., $\langle\phi(x_{i}),\psi(x_{j})\rangle$), and indeed can be shown to be universal approximators \[[51](#bib.bibx51)\]. The class of functions that can be represented in this way is thus fully general, but the approach provides a useful inductive bias for disentangling feature extraction (implemented by the encoders $\phi$ and $\psi$) from comparison (implemented by the inner product operator $\langle\rangle$).

## The relational bottleneck in neural architectures

(a)

(b)

(c)

Figure 2: Implementing the relational bottleneck. Three neural architectures that implement the relational bottleneck. (a) Emergent Symbol Binding Network (ESBN) \[[52](#bib.bibx52)\]. (b) Compositional Relation Network (CoRelNet) \[[53](#bib.bibx53)\]. (c) Abstractor \[[54](#bib.bibx54)\]. In all cases, high-dimensional inputs (e.g., images) are processed by a neural encoder (e.g., a convolutional network), yielding a set of object embeddings $\mathbf{O}$. These are projected to a set of keys $\mathbf{K}$ and queries $\mathbf{Q}$, which are then compared yielding a relation matrix $\mathbf{R}$, in which each entry is an inner product between a query and key. Abstract values $\mathbf{V}$ are isolated from perceptual inputs (the core feature of the relational bottleneck), and depend only on the relations between them.

Figure 2 (Key Figure) depicts three architectures that implement the relational bottleneck through architectural inductive biases. Here, we discuss how the distinct mechanisms in these models implement the same underlying principle. In particular, a common element is the use of inner products to represent relations, which ensures that the resulting representations are genuinely relational. In each case, we also contrast these architectures with related approaches that do not incorporate a relational bottleneck, emphasizing how this key architectural feature enables the data-efficient induction of abstractions.

### Emergent symbol binding

We first consider the Emergent Symbol Binding Network (ESBN) (Figure 2(a)) \[[52](#bib.bibx52)\], a deep neural network architecture inspired by the notion of role-filler variable binding in cognitive models of relational reasoning \[[34](#bib.bibx34), [33](#bib.bibx33), [55](#bib.bibx55)\]. In those models, relational reasoning is supported by the existence of separate ‘roles’, representing information about abstract variables, and ‘fillers’, representing information about concrete entities bound to those variables. This coding scheme enables roles and fillers to be flexibly combined in new ways, capturing a key property of symbol-processing systems: the ability of symbolic variables to be associated with any potential values. Previous work focused on how binding might be performed in neural circuits (e.g., units coding for a particular role may be temporarily ‘bound’ to units coding for a particular filler by firing synchronously \[[33](#bib.bibx33)\]). However, role and filler representations were typically pre-specified by the modeler, leaving open the question of how such symbolic representations might be learned.

The ESBN adopts this key idea of separate roles and fillers, but integrates them into a system that can be trained end-to-end (via backpropagation), averting the need to pre-specify these representations. The ESBN contains three major components: 1) a feedforward encoding pathway (‘Encoder’ in Figure 2(a)), which generates object embeddings (i.e., fillers) from perceptual inputs (e.g., images); 2) a recurrent controller (‘Controller’ in Figure 2(a)), which operates over learned representations of abstract variables (i.e., roles; though the system is not explicitly trained to represent any particular variables, but instead learns these representations through backpropagation); and 3) an external memory system responsible for binding representations of roles and fillers (i.e., abstract variables and perceptual embeddings). The ESBN processes inputs sequentially. For each observation, a pair of representations is appended to memory, one from the perceptual pathway (referred to as a key), and one from the control pathway (referred to as a value; note that the use of the terms ‘key’ and ‘value’ here is reversed relative to the original paper \[[52](#bib.bibx52)\] in order to be consistent with their usage in describing the CoRelNet and Abstractor architectures). To read from this memory, the embedding for the current observation (referred to as a query) is compared to all keys in memory via an inner product, yielding a set of scores (one for each key) that indicate the similarity of the current object embedding (i.e., filler) to each entry in memory. These scores are then used to compute a weighted average of the value embeddings (i.e., roles) in the abstract pathway, which is then retrieved and passed to the controller.

(a)

(b)

(c)

Figure 3: The relational bottleneck encourages data-efficient and generalizable relation learning. (a) Results for the ESBN and baseline architectures (Transformer, Neural Turing Machine (NTM), Metalearned Neural Memory (MNM), Long Short-Term Memory (LSTM), PrediNet, and the Relation Network (RN)) on the identity rules task, reproduced from \[[52](#bib.bibx52)\]. X axis represents the number of potential objects (out of 100 possible objects) withheld during training. When all objects are observed during training (0 withheld), most baselines perform well on the task. When most objects are withheld (95 withheld; test set includes only objects withheld during training), only the ESBN generalizes well to new objects. (b) Results for an object sorting task involving an asymmetric relation (greater-than/less-than), reproduced from \[[54](#bib.bibx54)\]. The abstractor learns this task significantly faster than both the transformer and an ablation model in which relational cross-attention is replaced by standard cross-attention. (c) Results from the give-N task, reproduced from \[[56](#bib.bibx56)\]. X axis represents the target number N (desired number of objects). Y axis represents the episode at which the model reaches a particular criterion for the ability to count to each value of N. ESBN learns the task significantly faster than the LSTM or Transformer baselines. ESBN also displays inductive transition (rapid learning for $N>5$) similar to that observed in human development.

Importantly, in this retrieval operation, the control pathway cannot access the content of the representations in the perceptual pathway (i.e., the fillers). Instead, the interaction is mediated only by the comparison of perceptual representations with each other. In other words, to the extent that a particular perceptual memory embedding (key) is similar to the current perceptual embedding (filler, used as a query), the corresponding control memory (value) will be retrieved and passed to the controller to be used as the role; critically, the perceptual embedding itself is not passed to the controller. The ESBN thus implements the relational bottleneck as an architectural prior, separating the learning and use of abstract representations (roles) by the controller from the embeddings of perceptual information (fillers). It is precisely this separation that guarantees the representations in the control pathway are abstract. This feature enables the ESBN to rapidly learn relational patterns (such as the identity rules displayed in Figure 1), and generalize them to out-of-distribution inputs (e.g., previously unseen shapes; Figure 3(a)) \[[52](#bib.bibx52)\]. Indeed, the ESBN can learn relational patterns from only a handful of examples (as few as 4 examples), mirroring the data efficiency of relational learning in young children (who can typically learn to perform relational tasks with fewer than $\sim 20$ examples \[[57](#bib.bibx57)\], as opposed to the thousands of examples that are necessary for standard neural network architectures). Critically, the ESBN can be shown to use precisely the same representation for a given role, irrespective of filler, thus exhibiting a critical feature of abstract, symbolic processing \[[13](#bib.bibx13)\]. In this sense, the representations in the model’s control pathway can be viewed as a form of learned ‘symbols’.

It is instructive to compare this model to similar approaches without a relational bottleneck. The ESBN is part of a broader family of architectures that use content-addressable external memory – a separate store of information with which a neural network can interact via learnable read and write operations \[[58](#bib.bibx58), [59](#bib.bibx59)\]. Notably, these read and write operations rely on a similarity computation (based on inner products). These have often been cast as simplified implementations of the brain’s episodic memory system \[[60](#bib.bibx60), [61](#bib.bibx61)\]. Standard external memory architectures do not typically isolate the control and perceptual pathways. Instead, perceptual inputs are passed directly to a central controller, which is responsible for writing to and reading from a single, monolithic memory. Though it is possible for a role-filler structure to emerge in these systems given a sufficiently large amount of training data \[[62](#bib.bibx62)\], they take much longer to learn relational tasks (requiring approximately an order of magnitude more training data), and do not generalize as well as the ESBN \[[52](#bib.bibx52)\]. Thus, although external memory plays an important role in the ESBN, the presence of external memory alone is insufficient to enforce a relational bottleneck. Rather, it is the isolation of the perceptual and abstract processing components from one another that does so. Furthermore, as we illustrate in the following sections, it is possible to achieve this isolation without the use of external memory.

### Relation matrices

An alternative approach to implementing the relational bottleneck is illustrated by the Compositional Relation Network (CoRelNet) (Figure 2(b)) \[[53](#bib.bibx53)\]. In that approach, a set of perceptual observations are first processed by an encoder, yielding a sequence of object embeddings. A relation matrix is then computed over all pairs of objects (within a given problem instance, e.g., all pairs of objects found within the ABA pattern in Figure 1), in which each entry consists of the inner product between a pair of object embeddings (thus capturing the similarity between each pair of objects). Finally, this relation matrix is passed to a downstream decoder network (the architecture of this network can vary, e.g., using a multilayer perceptron or transformer). The relation matrix thus forms a relational bottleneck: all perceptual information flows into this matrix, converting it into a form that only preserves relational information (about the similarity between objects), and only this relational information is then passed on to the decoder. As with the ESBN, this relational bottleneck enables CoRelNet to rapidly learn and systematically generalize relational patterns.

CoRelNet can be viewed as a feedforward, parallelized implementation of the sequential process (of encoding and similarity-based retrieval from external memory) carried out by the ESBN. This results in performance benefits, as CoRelNet does not suffer from the vanishing gradient problem that is a challenge for recurrent neural networks used to implement sequential processing \[[63](#bib.bibx63)\]. That is, the gradients associated with all relations in a given scene are processed in parallel via a single step of backpropagation, rather than being diluted over several iterations, as is the case for the sequential processing carried out by the ESBN. This approach also makes the key relational inductive bias underlying the ESBN more explicit. The ESBN’s memory retrieval procedure, in which the current observation is compared to the entries in memory, can be interpreted as computing a single row of the relation matrix. In both architectures, downstream processing is constrained so as to depend only on this relation matrix (which forms the relational bottleneck), though the details of this dependency differ.

Here too, a useful contrast can be made with related architectures that do not incorporate a relational bottleneck. In particular, architectures such as the Relation Net \[[64](#bib.bibx64)\] (see \[[44](#bib.bibx44)\] for related approaches) explicitly perform a comparison between each pair of inputs, leading to improved performance in relational tasks. However, whereas CoRelNet represents pairwise relations using inner products, the Relation Net utilizes generic neural network components (e.g., multilayer perceptrons) that are learned in a task-dependent manner. While this is in principle more flexible, it does not constrain the network to learn representations that only capture relational information. As a consequence, this architecture is susceptible to learning shortcuts consistent with the training data (i.e., overfitting to perceptual details), compromising its ability to efficiently learn and reliably generalize relations to out-of-distribution inputs \[[65](#bib.bibx65), [52](#bib.bibx52), [66](#bib.bibx66)\]. This is in contrast to the inner product operation employed by the ESBN and CoRelNet, which is inherently relational, and therefore guarantees that downstream processing is based only on relations.

### Relational attention

The recently proposed Abstractor architecture (Figure 2(c)) \[[54](#bib.bibx54)\] illustrates how the relational bottleneck can be implemented within the broader framework of attention-based architectures (including the Transformer \[[67](#bib.bibx67)\]). The Abstractor is built on a novel attention operation termed relational cross-attention. In this operation, a set of object embeddings (which may be produced by an encoder given perceptual observations) is converted to form keys and queries, using separate linear projections. A relation matrix is then computed, in which each entry corresponds to the inner product between a query and key. The relation matrix is used to attend over a set of learned values. The attention operation itself is identical to standard self-attention, in which each value embedding is replaced with a weighted average of the set of all value embeddings, where the weights are determined by the match between queries and keys (i.e., the relation matrix). However, the value embeddings used for relational cross-attention are formed from a separate set of representations that are learned through backpropagation (based on the downstream task for which the network is trained) which reference objects but are independent of their attributes (in the simplest scheme, these values reference objects via their position, though more sophisticated referencing schemes are also possible \[[54](#bib.bibx54)\]). This is in contrast to standard self-attention, in which the values are computed via a linear projection of the perceptual inputs (just as the queries and keys are computed). As with the CoRelNet architecture, the relation matrix thus forms a relational bottleneck, in the sense that it converts all perceptual information to relational information, and downstream processing (in this case, the relational cross-attention operation) then depends only on this relational information.

Relational cross-attention can be contrasted with the standard forms of attention employed in Transformers: self-attention and cross-attention. In self-attention, the same set of object embeddings are used to generate keys, queries, and values. In cross-attention, object embeddings are used to generate keys and values, and queries are generated by a separate decoder network. In both cases, the values over which attention is performed are based directly on the object embeddings, and the information contained in these embeddings is therefore passed on for downstream processing (thus contravening the relational bottleneck). By contrast, in relational cross-attention, keys and queries are generated from object embeddings, but a separate set of learned vectors are used as values (note that more complex architectures can be created by combining multiple forms of attention, e.g., object embeddings can first be processed by standard self-attention before applying relational cross-attention). As in the ESBN, these values can be viewed as learned ‘symbols’, in the sense that they are isolated from the perceptual content of the objects with which they are associated.

This implementation of the relational bottleneck yields the same benefits observed in others: the Abstractor learns relational patterns faster than the Transformer, and displays better out-of-distribution generalization of those patterns. The Abstractor also has a few advantages relative to existing implementations of the ESBN and CoRelNet. Because the relation matrix is computed using separate key and query projections, the Abstractor is capable of representing asymmetric relations (e.g., can capture the difference in meanings between ‘A is greater than B’ and ‘B is greater than A’; Figure 3(b)). In addition, multi-head relational cross-attention enables the Abstractor to model multi-dimensional relations. As proposed, ESBN and CoRelNet are limited to relations along a single feature dimension only. Finally, similar to Transformers, the Abstractor is a generative architecture, whereas the ESBN and CoRelNet are purely discriminative (although an alternative implementation of the ESBN has been proposed that can perform generative tasks \[[68](#bib.bibx68)\]). This enables the Abstractor to perform a broader range of tasks, including the sequence-to-sequence tasks that are common in natural language processing.

### Modeling more complex relations

The neural network modeling work discussed in the previous sections was focused primarily, though not exclusively, on relational patterns involving same/different relations. Although similarity is fundamental to human reasoning, and has indeed been a central focus of theories of relational and analogical reasoning \[[69](#bib.bibx69), [70](#bib.bibx70), [71](#bib.bibx71)\], human cognition is also characterized by more complex relation types, including asymmetric relations \[[72](#bib.bibx72)\] and higher-order relations \[[5](#bib.bibx5)\] (relations between relations). It is worth emphasizing that the relational bottleneck can also account for many of these more complex relation types. First, although the inner product between two vectors is inherently symmetric ($\mathbf{a}\cdot\mathbf{b}$ is identical to $\mathbf{b}\cdot\mathbf{a}$), the relational bottleneck can also account for asymmetric relations by computing the inner product between separate key and query embeddings ($\mathbf{q_{a}}\cdot\mathbf{k_{b}}$ is not the same as $\mathbf{q_{b}}\cdot\mathbf{k_{a}}$). This use of separate key and query embeddings enables the Abstractor to model asymmetric relations such as greater-than/less-than, as well as other asymmetric relations found in mathematical reasoning problems \[[54](#bib.bibx54)\] (and a similar architectural modification is also possible for the ESBN and CoRelNet). Second, although the architectures discussed here focused on pairwise relations, higher-order relations can be straightforwardly accommodated through the recursive application of the relational bottleneck (i.e., by treating the outputs of one relational bottleneck as the inputs to another relational bottleneck, thus computing relations between other relations). Along these lines, recent work proposed relational convolutional networks \[[73](#bib.bibx73)\] and demonstrated that a hierarchical relational architecture can learn representations of higher-order relations, outperforming both non-hierarchical relational architectures (e.g., CoRelNet) and deep non-relational architectures (e.g., transformers). These results illustrate how the relational bottleneck can account for more complex relation types, but it remains an important avenue for future work to investigate whether and how such architectures can account for the full space of relations that characterize human cognition.

As the examples we have considered illustrate, the relational bottleneck can be implemented in a diverse range of architectures, each with their own strengths and weaknesses. In each case, the inclusion of a relational bottleneck enables rapid learning of relations without the need for pre-specified relational primitives. In the remainder of the review, we discuss the implications of this approach for models of cognition, and consider how the relational bottleneck may relate to the architecture of the human brain.

## The relational bottleneck in the mind and brain

### Modeling the development of counting: a case study in learning abstractions

A core requirement for cognitive models of abstract concept acquisition is to account for the timecourse of acquisition during human development. A useful case study can be found in the early childhood process of learning to count \[[74](#bib.bibx74), [75](#bib.bibx75), [76](#bib.bibx76)\]. Children typically learn to recite the count sequence (i.e. ‘one, two, three,…’ etc.) relatively early, but their ability to use this knowledge to count objects then proceeds in distinct stages (as measured by the ‘give N’ task \[[76](#bib.bibx76)\], in which the child is asked to give the experimenter N objects). Each stage is characterized by the ability to reliably count sets up to a certain size (i.e., first acquiring the ability to reliably count only single objects, then to count two objects, and so on). Around the time that children learn to count sets of five, an inductive transition occurs, in which children rapidly learn to count sets of increasing size. It has been proposed that this transition corresponds to the acquisition of the ‘cardinality principle’ – the understanding that the last word used when counting corresponds to the number of items in a set \[[76](#bib.bibx76)\] – though the exact nature and scope of this inductive transition has been the subject of debate \[[77](#bib.bibx77), [78](#bib.bibx78)\]. Previous work found that data accumulation played an essential role in supporting this inductive transition \[[79](#bib.bibx79)\], but that work employed a symbolic modeling approach, leaving open the question of how such symbol-like processes might be implemented in a neural system.

To address this, a recent study investigated the development of counting in deep neural network architectures \[[56](#bib.bibx56)\]. These included the ESBN, the Transformer, and long short-term memory (LSTM) \[[80](#bib.bibx80)\] (a type of recurrent neural network). Each architecture displayed a distinct developmental timecourse (Figure 3(c)). The Transformer displayed a roughly linear timecourse, taking approximately the same amount of time to master each number. The LSTM displayed an exponentially increasing timecourse, taking more time to learn each new number. Only the ESBN displayed a human-like inductive transition, gradually learning to count each number from one to four, and then rapidly acquiring the ability to count higher after learning to count to five. This was due to the ability of the ESBN to learn a procedure over the representations in its control pathway that was abstracted away from the specific numbers in the count sequence (represented in the model’s perceptual pathway), allowing it to rapidly and systematically generalize between numbers. Specifically, the ESBN learned a procedure in which it stopped counting once the count sequence matched the desired number of objects (once the target value of N had been reached in the give-N task). The ESBN’s use of symbol-like representations (in its control pathway, representing ‘item at which to stop’) allowed this procedure to be abstracted away from the particular target value (represented in the perceptual pathway, and bound to the symbol-like representation in external memory), facilitating rapid generalization to higher values. This case study illustrates how the relational bottleneck can facilitate a human-like developmental trajectory for learning abstract concepts.

### Capacity limits and the curse of compositionality

The relational bottleneck principle may also help to explain the limited capacity of some cognitive processes (e.g., working memory) \[[81](#bib.bibx81)\]. Recent work has proposed a normative explanation of capacity-limited processes, according to which these capacity limits arise from the use of compositional representations, implemented in an architecture that employs a relational bottleneck \[[82](#bib.bibx82)\]. In that architecture, two separate representational pools (each representing distinct feature spaces, e.g., color and location) interact via a dynamic variable-binding mechanism (in that case, implemented using rapid Hebbian learning \[[83](#bib.bibx83)\]) in a manner that is conceptually similar to the ESBN. This mechanism enables the model to flexibly construct compositional representations (e.g., representing a visual scene by binding together spatial locations and visual features). However, this flexibility comes at the cost of relying on compositional representations that, by definition, are shared across many different, potentially competing processes. For instance, the representation of a blue object in the upper left corner (formed by binding together representations of ‘blue’ and ‘upper left’) will overlap with the representation of a blue object in the lower right corner (formed by binding together representations of ‘blue’ and ‘lower right’), leading to interference between these two representations (note that this interference is also further exacerbated by the use of maximally low-dimensional codes to represent features). This can be viewed as an instance of the more general tradeoff between processing capacity and the use of shared representations \[[84](#bib.bibx84)\], and also relates to classic considerations regarding the ‘binding problem’ in psychology \[[85](#bib.bibx85)\], though it has not been previously appreciated that this tradeoff can explain the severely capacity-limited nature of processes such as working memory (and others, including subitizing \[[86](#bib.bibx86)\], and absolute judgment \[[87](#bib.bibx87)\]). This work illustrates how one of the most notable strengths of human cognition – compositionality – may explain one of its most notable weaknesses – capacity-limited processing – and how both can be implemented in neural networks via the relational bottleneck.

#### Box 3: Brain mechanisms supporting the relational bottleneck

How might the relational bottleneck principle be implemented in the human brain? A central element of this framework is the presence of segregated systems for representing abstract vs. perceptual information (i.e., abstract values vs. perceptual keys/queries in the ESBN or Abstractor). A large body of findings from cognitive neuroscience suggests the presence of distinct neocortical systems for representing abstract structure (e.g., of space or events) vs. concrete entities (e.g., people or places), located in the parietal and temporal cortices respectively \[[88](#bib.bibx88), [89](#bib.bibx89), [90](#bib.bibx90), [91](#bib.bibx91), [92](#bib.bibx92)\]. This factorization has also been explored in a number of recent computational models \[[93](#bib.bibx93), [94](#bib.bibx94), [95](#bib.bibx95)\].

However, this segregation raises the question of how representations in these distinct neocortical systems are flexibly bound together. Though many proposals have been made for how the brain might solve this variable-binding problem (see Box 1), one intriguing possibility involves use of the episodic memory (EM) system \[[60](#bib.bibx60)\]. A common view holds that EM is supported by rapid synaptic plasticity in the hippocampus, which complements slower statistical learning in the neocortex \[[61](#bib.bibx61), [96](#bib.bibx96)\]. According to this view, episodes are encoded in the hippocampus by the rapid binding of features that co-occur within an episode, while the features themselves are represented in neocortical systems. This same mechanism could in principle support an architecture similar to the ESBN, by enabling rapid binding of abstract and perceptual neocortical representations. This is in fact very similar to models of cognitive map learning, in which conjunctive representations are rapidly formed in the hippocampus \[[97](#bib.bibx97)\]. These hippocampal conjunctive codes bind structural and sensory information, which are thought to be encoded in the medial and lateral entorhinal cortices, respectively, and are commonly understood as extensions of the parietal and temporal neocortical systems referenced above. More generally, the involvement of EM in relational reasoning would be consistent with a growing body of recent findings suggesting the potential involvement of EM in tasks traditionally associated with working memory \[[98](#bib.bibx98), [99](#bib.bibx99), [100](#bib.bibx100)\].

That said, the extent to which variable-binding relies on the hippocampus remains an open question. Some lesion evidence suggests that hippocampal damage does not lead to impairments of abstract reasoning \[[101](#bib.bibx101)\]. Other alternatives are that variable-binding may be supported by other structures capable of rapid synaptic plasticity (e.g., the cerebellum, which has been increasingly implicated in higher cognitive functions \[[102](#bib.bibx102), [103](#bib.bibx103), [104](#bib.bibx104)\]), or by other structures (such as the prefrontal cortex) that use other mechanisms for binding (such as selective attention \[[105](#bib.bibx105)\] or working memory gating \[[106](#bib.bibx106)\]). The latter possibilities are consistent with findings that prefrontal damage often leads to severe deficits in abstract reasoning tasks \[[107](#bib.bibx107), [108](#bib.bibx108)\], and prefrontal activity is frequently implicated in neuroimaging studies of abstract reasoning \[[109](#bib.bibx109), [110](#bib.bibx110)\]. However, this may also reflect the role of prefrontal cortex in representing abstract structure (along with the parietal system described above), rather than the binding of that structural information to concrete content. Of course, it is also possible that variable-binding is supported by a collection of distinct mechanisms, rather than a single mechanism alone. These are all important questions for future work that we hope will be usefully guided by the formalisms and computational models reviewed here.

## Concluding remarks and future directions

The human mind has a remarkable ability to acquire abstract relational concepts from relatively limited and concrete experience. Here, we have proposed the relational bottleneck as a functional principle that may explain how the human brain accomplishes such data-efficient abstraction, and highlighted recently proposed computational models that implement this principle. We have also considered how the principle relates to a range of cognitive phenomena, and how it might be implemented by the mechanisms of the human brain.

It should be noted that the framework reviewed here is not necessarily at odds with the existence of certain forms of domain-specific innate knowledge. In particular, a range of evidence from developmental psychology has suggested that humans possess certain ‘core knowledge’ systems, such as an innate capacity to represent objects \[[111](#bib.bibx111), [112](#bib.bibx112), [113](#bib.bibx113)\]. These findings have motivated the development of neuro-symbolic models endowed with these innate capacities \[[114](#bib.bibx114)\], although it is also possible that these findings may ultimately be accounted for by the inclusion of additional inductive biases into connectionist systems, such as mechanisms for object-centric visual processing \[[115](#bib.bibx115), [116](#bib.bibx116), [117](#bib.bibx117), [118](#bib.bibx118)\] (which have also been combined with the relational bottleneck \[[119](#bib.bibx119)\]). Critically, however, it is important to emphasize that the relational bottleneck is, in principle, orthogonal to questions about these domain-specific capacities, and is focused instead on explaining the induction of abstract, domain-general concepts and relations.

There are a number of important avenues for further developing the relational bottleneck framework. One major question concerns how the framework relates to cognitive models of analogical reasoning, which have traditionally afforded a central role to the process of analogical mapping, driven by patterns of similarity over entities and relations \[[5](#bib.bibx5), [69](#bib.bibx69), [70](#bib.bibx70), [71](#bib.bibx71)\]. An intriguing possibility is that the relational bottleneck encourages neural networks to learn to implement such algorithms, by re-representing their inputs in terms of patterns of similarity (represented as inner products), though future work should aim to more precisely establish this link. Future work should also consider how the proposed framework relates to other theoretical perspectives on out-of-distribution generalization in neural networks, including group theoretic approaches \[[120](#bib.bibx120), [121](#bib.bibx121)\], as well as other cognitive processes relevant to abstraction, including attentional processes \[[122](#bib.bibx122)\] and semantic cognition \[[123](#bib.bibx123)\]. Additionally, much work has suggested that human reasoning is not purely relational, but instead depends on a mixture of concrete and abstract influences \[[124](#bib.bibx124), [125](#bib.bibx125), [126](#bib.bibx126), [127](#bib.bibx127)\]. This suggests the potential value of a more graded formulation that controls the amount of non-relational information allowed to pass through the bottleneck. Finally, the human capacity for abstraction surely depends not only on architectural biases such as those that we have discussed here, but also on the rich educational and cultural fabric that allows us to build on the abstractions developed by others \[[128](#bib.bibx128)\]. In future work, it will be important to explore the interaction between education, culture and relational inductive biases.

## Outstanding Questions

- Can a more graded version of the relational bottleneck capture ‘content effects’ – in which abstract reasoning processes are influenced by the specific content under consideration, and therefore are not purely abstract or relational – while preserving a capacity for relational abstraction?
- Can the relational bottleneck principle be usefully applied to symbolic (or neuro-symbolic) models, in a manner similar to its application to neural network models? For instance, could program induction models benefit from a constraint that forces perceptual inputs to be recoded in terms of relations?
- What is the relationship between the relational bottleneck and traditional cognitive models of analogical reasoning? Does the relational bottleneck provide a useful inductive bias toward learning to implement processes such as analogical mapping?
- How can other cognitive processes (attention, memory, etc.) be integrated with the relational bottleneck?
- How is the relational bottleneck implemented in the brain? To what extent does this rely on mechanisms responsible for episodic memory, attentional mechanisms, and/or other mechanisms that remain to be identified? What role do the hippocampus, prefrontal cortex, and/or other structures play in these computations?
- How do architectural biases toward relational processing interact with the influence of training curricula and other cultural sources of abstraction (e.g., formal education)?

## Glossary

#### Attention

In the context of deep learning, an operation that allows information to be flexibly shared between a set of embeddings \[[129](#bib.bibx129)\] (popularized by the Transformer architecture \[[67](#bib.bibx67)\]), also closely related to content-addressable memory (see External memory). This operation shares some, but not all, properties of formal treatments of attention in cognitive psychology (see \[[130](#bib.bibx130)\] for an example of how the psychological notion of attention may be implemented in neural networks; see \[[131](#bib.bibx131)\] for discussion of the relationship between these different senses of ‘attention’).

#### Backpropagation

A technique used to train multi-layer neural networks, in which the connection strengths between processing units in intermediate layers are updated based on an error signal in downstream layers, allowing intermediate representations to be automatically learned in a manner that is most useful for downstream tasks (without having to specify those intermediate representations).

#### Connectionism

A modeling framework in cognitive science that emphasizes the emergence of complex cognitive phenomena from the interaction of simple, neuron-like elements organized into networks, in which connections are formed through learning.

#### Embedding

A real-valued vector that represents a particular input (e.g., a word or image), often instantiated as the state (set of activation values) of a particular layer in a neural network.

#### Episodic memory

A form of memory in which arbitrary, but durable, associations can be rapidly formed. Often thought to be implemented by hippocampal mechanisms for rapid synaptic plasticity and similarity-based retrieval.

#### External memory

In the context of deep learning, an approach that combines neural networks with separate external stores of information, typically with learnable mechanisms for writing to and reading from these stores, and in which retrieval is usually similarity-based (i.e., ‘content-addressable’). Often used to implement a form of episodic memory \[[132](#bib.bibx132)\].

#### Inductive bias

An assumption made by a machine learning model about the distribution of the data. In deep learning models, this often takes the form of architectural features that bias learning toward certain (typically desirable) outcomes. Genetically pre-configured aspects of brain structure can be viewed as a form of inductive bias.

#### Inner product

An operation in which two vectors are converted to a scalar, often interpreted as representing the similarity of those two vectors.

#### Out-of-distribution generalization

In machine learning, generalization to a distribution that differs from the distribution observed during training.

#### Program induction

A modeling approach in which concepts are represented as symbolic programs and learned via a search process that seeks to maximize the likelihood of observed data (typically subject to some constraints, e.g., parsimony).

## Declaration of interests

The authors declare no competing interests.

## Acknowledgements

AA is supported by funds provided by the National Science Foundation and by DoD OUSD (R&E) under Cooperative Agreement PHY-2229929 (The NSF AI Institute for Artificial and Natural Intelligence). JDC is supported by Vannevar Bush Faculty Fellowship N00014-22-1-2002 from the Office of the Under Secretary of Defense for Research & Engineering, supported by ONR.

[^1]: Rene Descartes “Rules for the Direction of our Native Intelligence” In *Descartes: Selected Philosophical Writings* Cambridge University Press, 1988

[^2]: John Locke “An essay concerning human understanding.” Oxford: Clarendon Press, 1894

[^3]: Gottfried Leibniz “New Essays on Human Understanding.” New York: Cambridge University Press, 1996

[^4]: Noam Chomsky “A review of BF Skinner’s Verbal Behavior” In *The Language and Thought Series* Harvard University Press, 1980, pp. 48–64

[^5]: Dedre Gentner “Structure-mapping: A theoretical framework for analogy” In *Cognitive Science* 7.2 Elsevier, 1983, pp. 155–170

[^6]: Keith Holyoak “Analogy and Relational Reasoning” In *The Oxford Handbook of Thinking and Reasoning* Oxford University Press, 2012, pp. 234–259

[^7]: Raymond Cattell “Abilities: Their structure, growth, and action” Houghton Mifflin, 1971

[^8]: Richard Snow, Patrick Kyllonen and Brachia Marshalek “The topography of ability and learning correlations” In *Advances in the Psychology of Human Intelligence* 2.S 47, 1984, pp. 103

[^9]: Derek Penn, Keith Holyoak and Daniel Povinelli “Darwin’s mistake: Explaining the discontinuity between human and nonhuman minds” In *Behavioral and Brain Sciences* 31.2 Cambridge University Press, 2008, pp. 109–130

[^10]: Allen Newell and Herbert Simon “Human problem solving” Prentice-hall Englewood Cliffs, NJ, 1972

[^11]: Jerry Fodor “The language of thought” Harvard University Press, 1975

[^12]: John Anderson “ACT: A simple theory of complex cognition.” In *American Psychologist* 51.4 American Psychological Association, 1996, pp. 355

[^13]: Jerry Fodor and Zenon Pylyshyn “Connectionism and cognitive architecture: A critical analysis” In *Cognition* 28.1-2 Elsevier, 1988, pp. 3–71

[^14]: Brenden Lake, Ruslan Salakhutdinov and Joshua Tenenbaum “Human-level concept learning through probabilistic program induction” In *Science* 350.6266 American Association for the Advancement of Science, 2015, pp. 1332–1338

[^15]: Brenden Lake, Tomer Ullman, Joshua Tenenbaum and Samuel Gershman “Building machines that learn and think like people” In *Behavioral and Brain Sciences* 40 Cambridge University Press, 2017, pp. e253

[^16]: Joshua Rule, Joshua Tenenbaum and Steven Piantadosi “The child as hacker” In *Trends in Cognitive Sciences* 24.11 Elsevier, 2020, pp. 900–915

[^17]: Kevin Ellis et al. “Dreamcoder: Bootstrapping inductive program synthesis with wake-sleep library learning” In *Proceedings of the 42nd ACM Sigplan International Conference on Programming Language Design and Implementation*, 2021 DOI: [https://doi.org/10.1145/3410302](https://dx.doi.org/https://doi.org/10.1145/3410302)

[^18]: Stanislas Dehaene et al. “Symbols and mental programs: a hypothesis about human singularity” In *Trends in Cognitive Sciences* Elsevier, 2022 DOI: [https://doi.org/10.1016/j.tics.2022.06.010](https://dx.doi.org/https://doi.org/10.1016/j.tics.2022.06.010)

[^19]: Yuan Yang and Steven Piantadosi “One model for the learning of language” In *Proceedings of the National Academy of Sciences* 119.5 National Acad Sciences, 2022, pp. e2021865119

[^20]: Jake Quilty-Dunn, Nicolas Porot and Eric Mandelbaum “The best game in town: The re-emergence of the language of thought hypothesis across the cognitive sciences” In *Behavioral and Brain Sciences* Cambridge University Press, 2022 DOI: [https://doi.org/10.1017/S0140525X22002849](https://dx.doi.org/https://doi.org/10.1017/S0140525X22002849)

[^21]: Steven Piantadosi “The computational origin of representation” In *Minds and machines* 31 Springer, 2021, pp. 1–58

[^22]: James McClelland and David Rumelhart “Explorations in parallel distributed processing: A handbook of models, programs, and exercises” MIT Press, 1989

[^23]: Jeffrey Elman “Finding structure in time” In *Cognitive Science* 14.2 Wiley Online Library, 1990, pp. 179–211

[^24]: James McClelland and Timothy Rogers “The parallel distributed processing approach to semantic cognition” In *Nature Reviews Neuroscience* 4.4 Nature Publishing Group UK London, 2003, pp. 310–322

[^25]: James McClelland et al. “Letting structure emerge: connectionist and dynamical systems approaches to cognition” In *Trends in Cognitive Sciences* 14.8 Elsevier, 2010, pp. 348–356

[^26]: Tom Brown et al. “Language models are few-shot learners” In *Advances in Neural Information Processing Systems* 33, 2020, pp. 1877–1901

[^27]: Jason Wei et al. “Emergent Abilities of Large Language Models” Survey Certification In *Transactions on Machine Learning Research*, 2022

[^28]: Steven Piantadosi “Modern language models refute Chomsky’s approach to language” In *Lingbuzz Preprint, lingbuzz* 7180, 2023

[^29]: Sébastien Bubeck et al. “Sparks of artificial general intelligence: Early experiments with gpt-4” In *arXiv preprint arXiv:2303.12712*, 2023 DOI: [https://doi.org/10.48550/arXiv.2303.12712](https://dx.doi.org/https://doi.org/10.48550/arXiv.2303.12712)

[^30]: Taylor Webb, Keith Holyoak and Hongjing Lu “Emergent analogical reasoning in large language models” In *Nature Human Behaviour* 7.9 Nature Publishing Group UK London, 2023, pp. 1526–1541

[^31]: Thomas Griffiths “Understanding human intelligence through human limitations” In *Trends in Cognitive Sciences* 24.11 Elsevier, 2020, pp. 873–883

[^32]: Michael Frank “Bridging the data gap between children and large language models” In *Trends in Cognitive Sciences* Elsevier, 2023 DOI: [https://doi.org/10.1016/j.tics.2023.08.007](https://dx.doi.org/https://doi.org/10.1016/j.tics.2023.08.007)

[^33]: John Hummel and Keith Holyoak “Distributed representations of structure: A theory of analogical access and mapping.” In *Psychological Review* 104.3 American Psychological Association, 1997, pp. 427

[^34]: Paul Smolensky “Tensor product variable binding and the representation of symbolic structures in connectionist systems” In *Artificial Intelligence* 46.1-2 Elsevier, 1990, pp. 159–216

[^35]: David Touretzky “BoltzCONS: Dynamic symbol structures in a connectionist network” In *Artificial Intelligence* 46.1-2 Elsevier, 1990, pp. 5–46

[^36]: Tony Plate “Holographic reduced representations” In *IEEE Transactions on Neural networks* 6.3 IEEE, 1995, pp. 623–641

[^37]: Pentti Kanerva “Hyperdimensional computing: An introduction to computing in distributed representation with high-dimensional random vectors” In *Cognitive Computation* 1 Springer, 2009, pp. 139–159

[^38]: Chris Eliasmith et al. “A large-scale model of the functioning brain” In *Science* 338.6111 American Association for the Advancement of Science, 2012, pp. 1202–1205

[^39]: Kenny Schlegel, Peer Neubert and Peter Protzel “A comparison of vector symbolic architectures” In *Artificial Intelligence Review* 55.6 Springer, 2022, pp. 4523–4555

[^40]: Justin Johnson et al. “Inferring and executing programs for visual reasoning” In *Proceedings of the IEEE International Conference on Computer Vision*, 2017, pp. 2989–2998

[^41]: Kexin Yi et al. “Neural-symbolic VQA: Disentangling reasoning from vision and language understanding” In *Advances in Neural Information Processing Systems* 31, 2018, pp. 1039–1050

[^42]: Maxwell Nye, Armando Solar-Lezama, Josh Tenenbaum and Brenden Lake “Learning compositional rules via neural program synthesis” In *Advances in Neural Information Processing Systems* 33, 2020, pp. 10832–10842

[^43]: Anirudh Goyal et al. “Neural production systems” In *Advances in Neural Information Processing Systems* 34, 2021, pp. 25673–25687

[^44]: Peter Battaglia et al. “Relational inductive biases, deep learning, and graph networks” In *arXiv preprint arXiv:1806.01261*, 2018 DOI: [https://doi.org/10.48550/arXiv.1806.01261](https://dx.doi.org/https://doi.org/10.48550/arXiv.1806.01261)

[^45]: Dianbo Liu et al. “Discrete-valued neural communication” In *Advances in Neural Information Processing Systems* 34, 2021, pp. 2109–2121

[^46]: Jacob Feldman “Symbolic representation of probabilistic worlds” In *Cognition* 123.1 Elsevier, 2012, pp. 61–83

[^47]: Nan Ke et al. “Learning neural causal models from unknown interventions” In *arXiv preprint arXiv:1910.01075*, 2019 DOI: [https://doi.org/10.48550/arXiv.1910.01075](https://dx.doi.org/https://doi.org/10.48550/arXiv.1910.01075)

[^48]: Hamid Palangi, Paul Smolensky, Xiaodong He and Li Deng “Question-answering with grammatically-interpretable representations” In *Proceedings of the AAAI Conference on Artificial Intelligence* 32.1, 2018, pp. 5350–5357

[^49]: Yichen Jiang et al. “Enriching transformers with structured tensor-product representations for abstractive summarization” In *arXiv preprint arXiv:2106.01317*, 2021 DOI: [https://doi.org/10.48550/arXiv.2106.01317](https://dx.doi.org/https://doi.org/10.48550/arXiv.2106.01317)

[^50]: Naftali Tishby, Fernando Pereira and William Bialek “The information bottleneck method” In *arXiv preprint physics/0004057*, 2000 DOI: [https://doi.org/10.48550/arXiv.physics/0004057](https://dx.doi.org/https://doi.org/10.48550/arXiv.physics/0004057)

[^51]: Awni Altabaa and John Lafferty “Approximation of relation functions and attention mechanisms” In *arXiv preprint arXiv:2402.08856*, 2024

[^52]: Taylor Webb, Ishan Sinha and Jonathan. Cohen “Emergent Symbols through Binding in External Memory” In *9th International Conference on Learning Representations (ICLR)*, 2021

[^53]: Giancarlo Kerg et al. “On neural architecture inductive biases for relational tasks” In *arXiv preprint arXiv:2206.05056*, 2022 DOI: [https://doi.org/10.48550/arXiv.2206.05056](https://dx.doi.org/https://doi.org/10.48550/arXiv.2206.05056)

[^54]: Awni Altabaa, Taylor Webb, Jonathan Cohen and John Lafferty “Abstractors and relational cross-attention: An inductive bias for explicit relational reasoning in Transformers” In *12th International Conference on Learning Representations (ICLR)*, 2024

[^55]: Gary Marcus “The algebraic mind: Integrating connectionism and cognitive science” MIT Press, 2001

[^56]: Zack Dulberg, Taylor Webb and Jonathan Cohen “Modelling the development of counting with memory-augmented neural networks” In *Proceedings of the 43rd Annual Meeting of the Cognitive Science Society*, 2021 DOI: [https://doi.org/10.48550/arXiv.2105.10577](https://dx.doi.org/https://doi.org/10.48550/arXiv.2105.10577)

[^57]: Laura Kotovsky and Dedre Gentner “Comparison and categorization in the development of relational similarity” In *Child Development* 67.6 Wiley Online Library, 1996, pp. 2797–2822

[^58]: Alex Graves, Greg Wayne and Ivo Danihelka “Neural turing machines” In *arXiv preprint arXiv:1410.5401*, 2014 DOI: [https://doi.org/10.48550/arXiv.1410.5401](https://dx.doi.org/https://doi.org/10.48550/arXiv.1410.5401)

[^59]: Alex Graves et al. “Hybrid computing using a neural network with dynamic external memory” In *Nature* 538.7626 Nature Publishing Group UK London, 2016, pp. 471–476

[^60]: Endel Tulving “Episodic memory: From mind to brain” In *Annual Review of Psychology* 53.1 Annual Reviews, 2002, pp. 1–25

[^61]: James McClelland, Bruce McNaughton and Randall O’Reilly “Why there are complementary learning systems in the hippocampus and neocortex: insights from the successes and failures of connectionist models of learning and memory.” In *Psychological Review* 102.3 American Psychological Association, 1995, pp. 419

[^62]: Catherine Chen et al. “Learning to perform role-filler binding with schematic knowledge” In *PeerJ* 9 PeerJ Inc., 2021, pp. e11046

[^63]: Sepp Hochreiter “The vanishing gradient problem during learning recurrent neural nets and problem solutions” In *International Journal of Uncertainty, Fuzziness and Knowledge-Based Systems* 6.02 World Scientific, 1998, pp. 107–116

[^64]: Adam Santoro et al. “A simple neural network module for relational reasoning” In *Advances in Neural Information Processing Systems* 30, 2017, pp. 4974–4983

[^65]: Junkyung Kim, Matthew Ricci and Thomas Serre “Not-So-CLEVR: learning same–different relations strains feedforward neural networks” In *Interface Focus* 8.4 The Royal Society, 2018, pp. 20180011

[^66]: N Ichien et al. “Visual analogy: Deep learning versus compositional models” In *Proceedings of the 43rd Annual Meeting of the Cognitive Science Society*, 2021 DOI: [https://doi.org/10.48550/arXiv.2105.07065](https://dx.doi.org/https://doi.org/10.48550/arXiv.2105.07065)

[^67]: Ashish Vaswani et al. “Attention is all you need” In *Advances in Neural Information Processing Systems* 30, 2017, pp. 6000–6010

[^68]: Ishan Sinha, Taylor Webb and Jonathan Cohen “A memory-augmented neural network model of abstract rule learning” In *arXiv preprint arXiv:2012.07172*, 2020 DOI: [https://doi.org/10.48550/arXiv.2012.07172](https://dx.doi.org/https://doi.org/10.48550/arXiv.2012.07172)

[^69]: Brian Falkenhainer, Kenneth Forbus and Dedre Gentner “The structure-mapping engine: Algorithm and examples” In *Artificial Intelligence* 41.1 Elsevier, 1989, pp. 1–63

[^70]: Hongjing Lu, Nicholas Ichien and Keith Holyoak “Probabilistic analogical mapping with semantic relation networks.” In *Psychological Review* American Psychological Association, 2022

[^71]: Taylor Webb et al. “Zero-shot visual reasoning through probabilistic analogical mapping” In *Nature Communications* 14, 2023, pp. 5144

[^72]: Hongjing Lu, Ying Wu and Keith Holyoak “Emergence of analogy from relation learning” In *Proceedings of the National Academy of Sciences* 116.10 National Acad Sciences, 2019, pp. 4176–4181

[^73]: Awni Altabaa and John Lafferty “Relational Convolutional Networks: A framework for learning representations of hierarchical relations” In *arXiv preprint arXiv:2310.03240*, 2023 DOI: [https://doi.org/10.48550/arXiv.2310.03240](https://dx.doi.org/https://doi.org/10.48550/arXiv.2310.03240)

[^74]: Karen Wynn “Children’s acquisition of the number words and the counting system” In *Cognitive Psychology* 24.2 Elsevier, 1992, pp. 220–251

[^75]: Susan Carey “Cognitive foundations of arithmetic: Evolution and ontogenisis” In *Mind & Language* 16.1 Wiley Online Library, 2001, pp. 37–55

[^76]: Barbara Sarnecka and Susan Carey “How counting represents number: What children must learn and when they learn it” In *Cognition* 108.3 Elsevier, 2008, pp. 662–674

[^77]: Kathryn Davidson, Kortney Eng and David Barner “Does learning to count involve a semantic induction?” In *Cognition* 123.1 Elsevier, 2012, pp. 162–173

[^78]: Susan Carey and David Barner “Ontogenetic origins of human integer representations” In *Trends in cognitive sciences* 23.10 Elsevier, 2019, pp. 823–835

[^79]: Steven Piantadosi, Joshua Tenenbaum and Noah Goodman “Bootstrapping in a language of thought: A formal model of numerical concept learning” In *Cognition* 123.2 Elsevier, 2012, pp. 199–217

[^80]: Sepp Hochreiter and Jürgen Schmidhuber “Long short-term memory” In *Neural Computation* 9.8 MIT press, 1997, pp. 1735–1780

[^81]: George Miller “The magical number seven, plus or minus two: Some limits on our capacity for processing information.” In *Psychological Review* 63.2 American Psychological Association, 1956, pp. 81

[^82]: Steven Frankland, Taylor Webb and Jonathan Cohen “No coincidence, George: Capacity-limits as the Curse of Compositionality” In *PsyArXiv preprint*, 2021 DOI: [https://doi.org/10.31234/osf.io/cjuxb](https://dx.doi.org/https://doi.org/10.31234/osf.io/cjuxb)

[^83]: John Hopfield “Neural networks and physical systems with emergent collective computational abilities.” In *Proceedings of the National Academy of Sciences* 79.8 National Acad Sciences, 1982, pp. 2554–2558

[^84]: Sebastian Musslick and Jonathan Cohen “Rationalizing constraints on the capacity for cognitive control” In *Trends in Cognitive Sciences* 25.9 Elsevier, 2021, pp. 757–775

[^85]: Anne Treisman and Garry Gelade “A feature-integration theory of attention” In *Cognitive psychology* 12.1 Elsevier, 1980, pp. 97–136

[^86]: George Mandler and Billie Shebo “Subitizing: an analysis of its component processes.” In *Journal of Experimental Psychology: General* 111.1 American Psychological Association, 1982, pp. 1

[^87]: Irwin Pollack “The information of elementary auditory displays” In *The Journal of the Acoustical Society of America* 24.6 Acoustical Society of America, 1952, pp. 745–749

[^88]: Mortimer Mishkin, Leslie Ungerleider and Kathleen Macko “Object vision and spatial vision: two cortical pathways” In *Trends in Neurosciences* 6 Elsevier Current Trends, 1983, pp. 414–417

[^89]: Melvyn Goodale and A Milner “Separate visual pathways for perception and action” In *Trends in Neurosciences* 15.1 Elsevier, 1992, pp. 20–25

[^90]: Steven Frankland and Joshua Greene “Concepts and compositionality: in search of the brain’s language of thought” In *Annual Review of Psychology* 71 Annual Reviews, 2020, pp. 273–303

[^91]: Christopher Summerfield, Fabrice Luyckx and Hannah Sheahan “Structure learning and the posterior parietal cortex” In *Progress in Neurobiology* 184 Elsevier, 2020, pp. 101717

[^92]: Randall O’Reilly, Charan Ranganath and Jacob Russin “The structure of systematicity in the brain” In *Current Directions in Psychological Science* 31.2 SAGE Publications Sage CA: Los Angeles, CA, 2022, pp. 124–130

[^93]: Jake Russin, Jason Jo, Randall O’Reilly and Yoshua Bengio “Compositional generalization in a deep seq2seq model by separating syntax and semantics” In *arXiv preprint arXiv:1904.09708*, 2019 DOI: [https://doi.org/10.48550/arXiv.1904.09708](https://dx.doi.org/https://doi.org/10.48550/arXiv.1904.09708)

[^94]: Randall O’Reilly, Jacob Russin, Maryam Zolfaghar and John Rohrlich “Deep predictive learning in neocortex and pulvinar” In *Journal of Cognitive Neuroscience* 33.6 MIT Press, 2021, pp. 1158–1196

[^95]: Shahab Bakhtiari et al. “The functional specialization of visual cortex emerges from training parallel pathways with self-supervised predictive learning” In *Advances in Neural Information Processing Systems* 34, 2021, pp. 25164–25178

[^96]: Weinan Sun et al. “Organizing memories for generalization in complementary learning systems” In *Nature Neuroscience* 26 Nature Publishing Group US New York, 2023, pp. 1438–1448

[^97]: James Whittington et al. “The Tolman-Eichenbaum machine: unifying space and relational memory through generalization in the hippocampal formation” In *Cell* 183.5 Elsevier, 2020, pp. 1249–1263

[^98]: Abigail Hoskin, Aaron Bornstein, Kenneth Norman and Jonathan Cohen “Refresh my memory: Episodic memory reinstatements intrude on working memory maintenance” In *Cognitive, Affective, & Behavioral Neuroscience* 19 Springer, 2019, pp. 338–354

[^99]: Andre Beukers, Timothy Buschman, Jonathan Cohen and Kenneth Norman “Is activity silent working memory simply episodic memory?” In *Trends in Cognitive Sciences* 25.4 Elsevier, 2021, pp. 284–293

[^100]: Andre Beukers, Maia Hamin, Kenneth Norman and Jonathan Cohen “When working memory may be just working, not memory.” In *Psychological Review* American Psychological Association, 2023

[^101]: Anna Dzieciol et al. “Hippocampal and diencephalic pathology in developmental amnesia” In *Cortex* 86 Elsevier, 2017, pp. 33–44

[^102]: Susan Ravizza et al. “Cerebellar damage produces selective deficits in verbal working memory” In *Brain* 129.2 Oxford University Press, 2006, pp. 306–320

[^103]: Anila D’Mello, John Gabrieli and Derek Nee “Evidence for hierarchical cognitive control in the human cerebellum” In *Current Biology* 30.10 Elsevier, 2020, pp. 1881–1892

[^104]: Samuel McDougle et al. “Continuous manipulation of mental representations is compromised in cerebellar degeneration” In *Brain* 145.12 Oxford University Press US, 2022, pp. 4246–4263

[^105]: Earl Miller and Jonathan Cohen “An integrative theory of prefrontal cortex function” In *Annual Review of Neuroscience* 24.1 Annual Reviews, 2001, pp. 167–202

[^106]: Trenton Kriete, David Noelle, Jonathan Cohen and Randall O’Reilly “Indirection and symbol-like processing in the prefrontal cortex and basal ganglia” In *Proceedings of the National Academy of Sciences* 110.41 National Acad Sciences, 2013, pp. 16390–16395

[^107]: James Waltz et al. “A system for relational reasoning in human prefrontal cortex” In *Psychological Science* 10.2 SAGE Publications Sage CA: Los Angeles, CA, 1999, pp. 119–125

[^108]: Lisa Cipolotti et al. “Graph lesion-deficit mapping of fluid intelligence” In *Brain* 146.1 Oxford University Press US, 2023, pp. 167–181

[^109]: Kalina Christoff et al. “Rostrolateral prefrontal cortex involvement in relational integration during reasoning” In *Neuroimage* 14.5 Elsevier, 2001, pp. 1136–1149

[^110]: Barbara Knowlton, Robert Morrison, John Hummel and Keith Holyoak “A neurocomputational system for relational reasoning” In *Trends in Cognitive Sciences* 16.7 Elsevier, 2012, pp. 373–381

[^111]: Elizabeth Spelke, Karen Breinlinger, Janet Macomber and Kristen Jacobson “Origins of knowledge.” In *Psychological Review* 99.4 American Psychological Association, 1992, pp. 605

[^112]: Elizabeth Spelke and Katherine Kinzler “Core knowledge” In *Developmental Science* 10.1 Wiley Online Library, 2007, pp. 89–96

[^113]: Renée Baillargeon and Susan Carey “Core cognition and beyond: The acquisition of physical and numerical knowledge” In *Early childhood development and later outcome* Cambridge University Press, 2012, pp. 35–65

[^114]: Kevin Smith et al. “Modeling expectation violation in intuitive physics with coarse probabilistic object representations” In *Advances in Neural Information Processing Systems* 32, 2019, pp. 8985–8995

[^115]: Christopher Burgess et al. “Monet: Unsupervised scene decomposition and representation” In *arXiv preprint arXiv:1901.11390*, 2019

[^116]: Francesco Locatello et al. “Object-centric learning with slot attention” In *Advances in Neural Information Processing Systems* 33, 2020, pp. 11525–11538

[^117]: Luis Piloto, Ari Weinstein, Peter Battaglia and Matthew Botvinick “Intuitive physics learning in a deep-learning model inspired by developmental psychology” In *Nature Human Behaviour* 6.9 Nature Publishing Group UK London, 2022, pp. 1257–1267

[^118]: Shanka Mondal, Taylor Webb and Jonathan Cohen “Learning to reason over visual objects” In *11th International Conference on Learning Representations (ICLR)*, 2023

[^119]: Taylor Webb, Shanka Mondal and Jonathan Cohen “Systematic Visual Reasoning through Object-Centric Relational Abstraction” In *Advances in Neural Information Processing Systems* 37, 2023

[^120]: Michael Bronstein, Joan Bruna, Taco Cohen and Petar Veličković “Geometric deep learning: Grids, groups, graphs, geodesics, and gauges” In *arXiv preprint arXiv:2104.13478*, 2021

[^121]: Simon Segert “Maximum Entropy, Symmetry, and Relational Bottleneck: Unraveling the Impact of Inductive Biases on Systematic Reasoning.”, 2024

[^122]: Mohit Vaishnav and Thomas Serre “GAMR: A guided attention model for (visual) reasoning” In *11th International Conference on Learning Representations (ICLR)*, 2022

[^123]: Tyler Giallanza, Declan Campbell, Jonathan Cohen and Timothy Rogers “An Integrated Model of Semantics and Control” In *PsyArXiv preprint*, 2023 DOI: [https://doi.org/10.31234/osf.io/jq7ta](https://dx.doi.org/https://doi.org/10.31234/osf.io/jq7ta)

[^124]: Peter Wason “Reasoning about a rule” In *Quarterly Journal of Experimental Psychology* 20.3 SAGE Publications Sage UK: London, England, 1968, pp. 273–281

[^125]: Philip Johnson-Laird, Paolo Legrenzi and Maria Legrenzi “Reasoning and a sense of reality” In *British Journal of Psychology* 63.3 Wiley Online Library, 1972, pp. 395–400

[^126]: Miriam Bassok, Valerie Chase and Shirley Martin “Adding apples and oranges: Alignment of semantic and formal knowledge” In *Cognitive Psychology* 35.2 Elsevier, 1998, pp. 99–134

[^127]: Adele Goldberg “Constructions: A new theoretical approach to language” In *Trends in Cognitive Sciences* 7.5 Elsevier, 2003, pp. 219–224

[^128]: James McClelland “Capturing advanced human cognitive abilities with deep neural networks” In *Trends in Cognitive Sciences* 26.12 Elsevier, 2022, pp. 1047–1050

[^129]: Dzmitry Bahdanau, Kyunghyun Cho and Yoshua Bengio “Neural machine translation by jointly learning to align and translate” In *3rd International Conference on Learning Representations (ICLR)*, 2015

[^130]: Jonathan Cohen, Kevin Dunbar and James McClelland “On the control of automatic processes: a parallel distributed processing account of the Stroop effect.” In *Psychological review* 97.3 American Psychological Association, 1990, pp. 332

[^131]: Grace Lindsay “Attention in psychology, neuroscience, and machine learning” In *Frontiers in computational neuroscience* 14 Frontiers Media SA, 2020, pp. 29

[^132]: Douglas Medin and Marguerite Schaffer “Context theory of classification learning.” In *Psychological review* 85.3 American Psychological Association, 1978, pp. 207