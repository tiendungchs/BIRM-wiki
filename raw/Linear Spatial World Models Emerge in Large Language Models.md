# **Linear Spatial World Models Emerge in Large Language Models** 

**Matthieu Tehenan** _[∗]_ University of Cambridge `mm2833@cam.ac.uk` 

**Christian Bolivar Moya** _[∗]_ **Tenghai Long** _[∗]_ Purdue University Independent `cmoyacal@purdue.edu theohlong@gmail.com` 

**Guang Lin** Purdue University `guanglin@purdue.edu` 

## **Abstract** 

Large language models (LLMs) have demonstrated emergent abilities across diverse tasks, raising the question of whether they acquire internal world models. In this work, we investigate whether LLMs implicitly encode linear spatial world models, which we define as linear representations of physical space and object configurations. We introduce a formal framework for spatial world models and assess whether such structure emerges in contextual embeddings. Using a synthetic dataset of object positions, we train probes to decode object positions and evaluate geometric consistency of the underlying space. We further conduct causal interventions to test whether these spatial representations are functionally used by the model. Our results provide empirical evidence that LLMs encode linear spatial world models. 

linear-spatial-world-models 

## **1 Introduction** 

Large language models (LLMs) have demonstrated strong performance across a wide range of tasks, which suggests their abilities reflect emergent capabilities beyond their original auto-regressive training objective [1, 2]. However, it remains an open question whether these results are simply a product of statistical imitation or whether they signal the emergence of world models. World models refer to internal representations of an environment’s dynamics, enabling an agent to simulate, predict, and regulate its behavior in response to inputs [3–6]. There are theoretical reasons to expect the emergence of internal world models in large language models, most notably that optimal interaction with an environment would induce a system to encode a model of that environment [7, 8]. In this sense, an internal model is not merely a beneficial by-product, but a condition for optimal behavior under certain constraints [9, 6]. 

A common critique states that LLMs capture vast numbers of surface-level correlations without acquiring any coherent model or understanding of the underlying data-generating processes, particularly due to their training on text-only data [10, 11]. In this view, LLMs are likened to _stochastic parrots_ [12], capable of producing plausible language without grasping its meaning. In contrast, an alternative perspective suggests that LLMs do, in fact, acquire internal models of the generative processes embedded in their training data, i.e. world models. These world models may emerge implicitly as a 

> _∗_ Equal contribution 

Preprint. Under review. 

by-product of training on next-token prediction tasks, forming latent causal representations of the environment [6, 13, 4]. 

As AI systems grow more powerful, evaluating their internal world models becomes crucial for understanding how they make decisions and for ensuring their behavior aligns with human expectations [14–17]. A key component of any robust world model is a spatial world model; an internal, structured representation of physical space and the objects it contains. This involves not only recognizing entities and their relationships but also representing them in a spatially coherent and compositional manner, aligned with human intuitions [3, 18]. Such spatial grounding forms the foundation of a model’s conception of its environment and is essential for building representations that are interpretable and aligned with human understanding [19]. 

In this paper, we investigate whether large language models internally encode a spatial world model. Specifically, we ask whether such a model is directly embedded within their contextual representations, and whether it provides coherent abstractions of space. To address this, we make the following contributions: 

1. First, we formally define a spatial world model as a structured representation of discrete object locations in three-dimensional Euclidean space. 

2. Next, we identify a linear subspace within the contextual embeddings of LLMs that corresponds to a spatial state space, providing evidence that this subspace encodes a spatial world model. 

3. Finally, we execute targeted causal interventions in this linear subspace to steer the model’s representation of object positions, and we provide empirical evidence that this model uses this subspace for predictions. 

## **2 Background** 

This section reviews prior work relevant to the emergence and analysis of internal models in large language models, focusing on three domains: interpretability, world models and spatial representations. 

**Superposition and Interpretability.** A central challenge in identifying world models within LLMs lies in the phenomenon of superposition[20, 21]. In such cases, multiple features are entangled within overlapping directions in the activation space, making it difficult to isolate interpretable components [22, 23]. A first step to disentangle these representation is to identify whether relevant information is encoded or not. Researchers have employed probing methods, which train classifiers or regressors on activations to extract information [24, 25]. While probes reveal what information is accessible in a model’s representations, they do not confirm whether this information is functionally used [26]. To address this, causal methods from mechanistic interpretability have been developed to assess the internal use of representations [27–29]. Among these, methods like activation patching and activation steering, which replace or perturb intermediate activations, have proven effective for identifying components with causal influence on model behavior [30–32]. 

**World Models.** The above methods have been applied to study specific world models. Empirically, there is growing evidence that LLMs can learn structured internal representations of state spaces, even in the absence of explicit supervision. Transformer models trained on structured games such as chess or Othello develop linear representations of board states and transition functions that function as emergent world models [33–36]. These findings indicate that next-token prediction objectives can implicitly induce internal models of the environment, often organized along linear subspaces [37, 38, 13]. 

**Spatial representations.** While full spatial world models have not been explicitly uncovered, growing evidence suggests that LLMs develop structured internal representations of space and time as a by-product of next-token prediction [39]. Early research showed that linguistic co-occurrence patterns encode geographic structure [40, 41], while more recent work reveals that LLMs can infer complex spatial layouts—such as maze topologies—purely from textual descriptions [42, 43]. Beyond navigation, LLM representations have been found to reflect both perceptual structure in the spatial domains, suggesting an emerging alignment with human representations [44]. 

2 

## **3 Spatial World Models** 

To assess whether a large language model implicitly encodes a spatial world model in its activations, we begin by providing a formal description. 

## **3.1 Definitions** 

We define a spatial world model as a structure that describes the location of discrete objects in three-dimensional space. This analysis focuses solely on static spatial configurations, such as relative position, not on rotation, distances or directions. 

**Definition 1.** (Spatial World Model). A spatial world model _W_ is defined as a tuple: 

**==> picture [68 x 12] intentionally omitted <==**

where R[3] represents three-dimensional Euclidean space, _O_ = _{o_ 1 _, o_ 2 _, . . . , on}_ is a set of objects located in this space, and each object _oi_ has a position in regards to an origin _pi ∈_ R[3] . The world state is given by _S_ = _{p_ 1 _, p_ 2 _, . . . , pn}_ , the set of all object positions. For example, consider a world with three objects in different locations: a bag at position (1 _._ 0 _,_ 2 _._ 0 _,_ 0 _._ 5), a car at (3 _._ 2 _,_ 1 _._ 0 _,_ 0 _._ 0), and a cat at the origin (0 _._ 0 _,_ 0 _._ 0 _,_ 0 _._ 0). Then the world state is _S_ = (1.0, 2.0, 0.5), (3.2, 1.0, 0.0),(0.0, 0.0, 0.0). 

## **3.2 Properties** 

It follows that there exists a basis within the underlying vector space, such that all spatial relations can be reconstructed as combinations of a small set of elementary directions. These atomic spatial relations must correspond to basis directions _that can be mapped to terms in natural language_ . Formally, the vector space R[3] in our model _W_ = _⟨_ R[3] _, O, S⟩_ must satisfy two essential conditions: (1) it must admit a consistent spatial basis aligned with linguistic primitives, and (2) it must allow complex spatial relations to be expressed as linear combinations of these basis vectors. 

**Property 1.** (Basis). There exists a basis of vectors _B_ = _{⃗r_ left _,⃗r_ above _,⃗r_ in front _} ⊂_ R[3] , each corresponding to an atomic spatial relation in language. For instance, the words “left”, “above”, and “in front” are mapped respectively to orthogonal directions in R[3] , defining the primary axes of spatial reasoning. Inverse relations in language are encoded as vector negations: the vector associated with “right” is given by _⃗r_ right = _−⃗r_ left, and similarly, _⃗r_ below = _−⃗r_ above. This mapping preserves orthogonality among independent relations: 

**==> picture [232 x 10] intentionally omitted <==**

The internal geometry of the model thus mirrors the structure of natural language descriptions of location (e.g. locative adpositions), where opposites correspond to inverses and independent relations are encoded as orthogonal directions. 

**Property 2.** (Composition). Our model _W_ represents spatial expressions as linear combinations of basis directions. For example, a spatial direction such as “above and left” corresponds to the vector sum of its atomic parts: 

**==> picture [98 x 9] intentionally omitted <==**

More generally, any composed relation is associated with a vector _⃗r ∈_ R[3] expressible as a linear combination of the form: 

**==> picture [56 x 22] intentionally omitted <==**

where _⃗ri ∈B_ and _αi ∈_ R. 

We thus formulate the following hypothesis: if a model encodes spatial relations as linear combinations of a small set of atomic directions, then it possesses a compositional spatial world model. This structure enables the model to generate and interpret unseen spatial expressions through algebraic composition, establishing a direct mapping between spatial language (e.g. locative adpositions) and internal geometric representations. 

3 

## **4 Methods** 

To evaluate whether LLMs implicitly encode spatial world models as described above, we adopt a two-part methodology. First, we extract internal representations corresponding to world states from given LLM activations. Second, we assess whether these representations reflect the structure of the defined world model—namely: (1) the basis vectors of R[3] and (2) coherence of object states _O_ as a composition of a these basis vectors. Our approach aims to determine whether a structured representation of space is embedded within broader contextual embeddings, and whether this representation plays a causally functional role in model behavior. 

## **4.1 Models and Data Selection** 

**Datasets.** We construct a synthetic dataset designed to represent spatial positions, composed of a set of 61 distinct objects and 6 spatial relations. Each sample in the dataset describes one or more objects placed in specific relative positions within a 2D or 3D environment. Pairs of objects are concatenated to form short natural language prompts such as: “The cup is above the table. The book is to the left of the cup.” Each prompt is annotated with a tuple of object positions in Euclidean space, which serves as ground-truth for probing and intervention tasks. Further dataset generation details and examples are provided in Appendix B. 

**Models and Activations.** We perform all experiments using the `LLaMA-3.2` model family, specifically the 3B instruction-tuned variant [45]. For each prompt, we extract activations from the final token prior to the period (".") using forward hooks. Unless otherwise stated, we collect the residual stream output before the final layer normalization step at layers 8, 12, and 24. In the case of multitoken object names, we average the activations across the corresponding tokens to obtain a single entity-level vector. All activations are projected to the model’s hidden size, yielding an _n × d_ model matrix of activations per prompt, where _n_ is the number of datapoints. These activations are used as the input to our probing pipeline. 

## **4.2 Probing** 

**Probes.** We probe the activation vectors to detect whether spatial information is encoded, and if so, whether linearly or not. Probes are lightweight models trained to predict properties (e.g., object positions) from hidden states [24, 46]. We train both linear and non-linear probes to assess whether spatial structure is directly encoded in the geometry of the model’s representations. Formally, given activations **A** _∈_ R _[n][×][d]_[model] and targets **Y** _∈_ R _[n][×][d]_[target] , we learn a linear mapping: 

**==> picture [246 x 17] intentionally omitted <==**

In parallel, we train non-linear probes _fθ_ : R _[d][m][odel] →_ R _[n] ._ using shallow MLP trained to minimize _∥_ **Y** _− fθ_ ( **A** ) _∥_ 2[2] _[.]_[.][High linear probe performance would suggest that spatial abstraction is linearly] encoded, while a significant gap between linear and non-linear probes would indicate nonlinear representations. 

**Probes and Representation Structure.** Linear probes not only detect the presence of information, but also recover representational structure. A trained probe learns a weight vector **w** _i_ for each class _i_ , with scores computed as: score _i_ ( **h** ) = **w** _i[⊤]_ **[h]** _[.]_[ Successful probing implies that class representations] **h** are linearly separable and form clusters, with hyperplanes corresponding to decision boundaries. Probe directions approximate the difference between class means: **w** _i ∝_ _**µ** i −_ _**µ**_ rest _,_ where _**µ** i_ is the average activation for class _i_ , and _**µ**_ rest the mean of all others. Thus, each probe vector points toward the region occupied by its associated class in representation space. In this case, if relations such as “above” and “below” emerge as antipodal directions, they would reflect alignment between semantic concepts and the model’s internal geometry [47, 48]. 

## **4.3 Causal Experiments** 

While probing can reveal the presence of information, it does not confirm that the representation is used by the model in a causally functional way [26]. We use the activation steering method [31, 49], where we inject direction vectors into intermediate activations and observe output shifts. Given 

4 

Table 1: Inverse relation alignment across layers. We report the cosine similarity and angle between each inverse pair, using both original and PCA-projected representations. Higher cosine similarity and lower angle indicate better alignment. 

|**Layer**<br>**Relation**|_Original Space_<br>Cosine Sim.<br>Angle (°)|_PCA-Projected Space_<br>Cosine Sim.<br>Angle (°)|
|---|---|---|
|8<br>above_↔_below<br>left_↔_right<br>in front_↔_behind|0.5370<br>57.52<br>0.8235<br>34.56<br>0.1228<br>82.95|0.7291<br>43.19<br>0.9990<br>2.54<br>0.8773<br>28.69|
|16<br>above_↔_below<br>left_↔_right<br>in front_↔_behind|0.3862<br>67.28<br>0.9656<br>15.07<br>0.0736<br>85.78|0.7889<br>37.92<br>0.9993<br>2.12<br>0.9554<br>17.18|
|24<br>above_↔_below<br>left_↔_right<br>in front_↔_behind|0.4465<br>63.48<br>0.9640<br>15.41<br>0.1130<br>83.51|0.9779<br>12.06<br>0.9969<br>4.55<br>0.9950<br>5.75|



a hidden state _h ∈_ R _[d]_ , we apply a steering vector _vr_ for relation _r_ with scale _α_ , modifying it as: _h[′]_ = _h_ + _αvr_ . We perform this intervention at selected transformer layers and evaluate whether the model’s output shifts toward the target spatial relation _r_ . Success for each relation is defined as the average correctness: _N_ 1 _r_ � _Ni_ =1 _r_[1][[][steer][(] _[x][i]_[)] _[ |]_[=] _[ r]_[]][, where][ 1][[] _[·]_[]][ denotes lexical match.][We report] aggregate scores and confidence intervals. 

## **5 Experiments** 

We now turn to empirically validating the presence of a spatial world model. We study each component of the spatial world model outlined in Section 3, starting from its most fundamental components up to its properties. We then validate these findings with causal experiments. 

## **5.1 Presence of a state space** 

**Motivation** This section test the encoding of an Euclidean space R[3] , a key part of our world model tuple (Definition 1). If the model learned such a world model, each spatial relation would correspond to a specific direction or position within this space. Semantically opposed relations (e.g., “above” vs. “below”) would be encoded as approximately antipodal vectors within a shared subspace. Conversely, unrelated relations (e.g., “above” vs. “inside”) would be represented by orthogonal or nearly orthogonal vectors, indicating that there is little or no shared informational structure between them. 

**Experiments.** We begin by encoding our datasets using the target model and extracting the activation vectors **A** corresponding to the final token of each input. To assess whether relational labels are recoverable from the model’s internal representations, we train both linear and non-linear probes on the activation vectors **A** . These probes are trained to predict the original relational labels associated with each input. Next, we examine whether the relational representations form a structured subspace within the activation geometry. In order to extract this subspace, we implement dimensionality reduction methods, such as PCA in order to disentangle the representations. Specifically, we test whether directional oppositions in the relation space, e.g., “above” versus “below”—are encoded as approximately antipodal vectors in R[3] . 

**Results.** Linear probes achieve near-perfect reconstruction of spatial relations, matching the performance of nonlinear probes. This indicates that the relevant relational information is linearly encoded in the model’s activation space, which provides empirical support for the linear representation hypothesis [37]. Results are summarized in Appendix 4. 

More importantly for our hypothesis, dimensionality reduction identify a lower-dimensional subspace that captures the structure of these spatial relations. Within this subspace, we observe a geometric organization: relational pairs such as _above_ and _below_ are encoded as antipodal directions, i.e., 

5 

**==> picture [376 x 127] intentionally omitted <==**

**----- Start of picture text -----**<br>
y z z<br>15 15<br>in front<br>below in front 5<br>right left − 15 15 above<br>x x y<br>− 15 above 15 left right − 5 5below<br>behind − 5<br>behind<br>− 15 − 15<br>(a) (b) (c)<br>**----- End of picture text -----**<br>


Figure 1: Projection on the plane of 3-D PCA vectors representing atomic spatial relations for layer 24 of `Llama-3.2-8B-Instruct` model. (a) `{above, below, right, left}` . (b) `{left, right, in front, behind}` . (c) `{above, below, in front, behind}` . 

Table 2: 2D Compositional Relation Metrics (Original & PCA Spaces) — Layer 24 

|**Compositional Relation**|**Atomic Pair**|**Cosine**<br>**Similarity**<br>**Euclidean**<br>**Distance**<br>**Angle**<br>(°)|
|---|---|---|
|diag. above and right|above + right|Orig: 0.3920<br>PCA: 0.9917<br>Orig: 15.11<br>PCA: 9.08<br>Orig: 66.92<br>PCA: 7.39|
|diag. above and left|above + left|Orig: 0.4083<br>PCA: 0.9999<br>Orig: 14.48<br>PCA: 7.52<br>Orig: 65.90<br>PCA: 0.90|
|diag. below and right|below + right|Orig: 0.3757<br>PCA: 0.9917<br>Orig: 14.90<br>PCA: 7.90<br>Orig: 67.93<br>PCA: 7.40|
|diag. below and left|below + left|Orig: 0.4050<br>PCA: 0.9893<br>Orig: 14.85<br>PCA: 8.13<br>Orig: 66.11<br>PCA: 8.38|
|**Mean**||**Orig: 0.3952**<br>**PCA: 0.9931**<br>**Orig: 14.84**<br>**PCA: 8.16**<br>**Orig: 66.72**<br>**PCA: 6.02**|



**w** below _≈−_ **w** above, while orthogonal relations such as _left_ and _above_ lie approximately at right angles. This structure is visualized in Figure 1 and in 3D in Figure 3b. This linear organization holds across the directions of a R[3] basis. Notably, linear decodability is consistently observed across all tested layers (8, 16, and 24), indicating stable relational representations throughout the residual stream. Moreover, the quality of the spatial encoding improves in deeper layers, and our results suggests that this subspace becomes increasingly strucutred in downstream layers (see Table 1). This suggest that the model represents spatial semantics within a subspace that is approximately isomorphic to R[3] . 

## **5.2 Composition** 

**Motivation.** The above experiments indentified a subspace in which spatial relations are geometrically encoded. We now turn to evaluating its internal consistency, specifically whether the space satisfies Property 2. Our guiding question is: Do directional relations compose linearly in this space? That is, if the model encodes relations such as _above_ and _left_ as vectors, does the relation _above-left_ correspond to the approximate sum of those two basis vectors? If our hypothesis holds, we should observe that: (1) The vector direction of a composed relation (e.g., _above and right_ ) approximates the sum of its constituent vector directions (e.g., _above_ + _right_ ) and (2) that the angles between composed vectors and their predicted sums are minimized in a structured subspace. 

**Experiments.** We use our dataset of labeled spatial relations, including both atomic (e.g., _above_ , _right_ ) and composed relations (e.g., _above_ and _left_ , _below_ and _right_ ). For each composed relation, we (1) compute the mean activation vector for each relation (e.g., _µ_ above, _µ_ left, _µ_ above-left). We then (2) calculate the compositional sum: _µ_ above + _µ_ left. Finally we (3) measure the angle between this sum and the actual mean vector of the composed relation _µ_ above-left. We perform this procedure in both the original activation space and in the PCA-reduced subspace identified earlier (which we saw above captured structured spatial semantics). We run these experiments both for 2D and 3D space. 

6 

Table 3: 3D Compositional Relation Metrics (Original & PCA Spaces) — Layer 24 

|**Compositional Relation**|**Atomic Pair**|**Cosine**<br>**Similarity**<br>**Angle**<br>(°)|
|---|---|---|
|diag. above and right|above + right|Orig: 0.3947<br>PCA: 0.8799<br>Orig: 66.76<br>PCA: 28.36|
|diag. above and left|above + left|Orig: 0.3864<br>PCA: 0.9183<br>Orig: 67.27<br>PCA: 23.32|
|diag. below and right|below + right|Orig: 0.3700<br>PCA: 0.9187<br>Orig: 68.28<br>PCA: 23.26|
|diag. below and left|below + left|Orig: 0.3508<br>PCA: 0.9139<br>Orig: 69.46<br>PCA: 23.94|
|diag. above and behind|above + behind|Orig: 0.2501<br>PCA: 0.9586<br>Orig: 75.52<br>PCA: 16.55|
|diag. above and in front of|above + in front of|Orig: 0.3037<br>PCA: 0.9716<br>Orig: 72.32<br>PCA: 13.69|
|diag. below and behind|below + behind|Orig: 0.3173<br>PCA: 0.9977<br>Orig: 71.50<br>PCA: 3.87|
|diag. below and in front of|below + in front of|Orig: 0.2542<br>PCA: 0.9785<br>Orig: 75.27<br>PCA: 11.92|
|diag. left and behind|left + behind|Orig: 0.2938<br>PCA: 0.8249<br>Orig: 72.92<br>PCA: 34.42|
|diag. left and in front of|left + in front of|Orig: 0.3540<br>PCA: 0.9631<br>Orig: 69.27<br>PCA: 15.61|
|diag. right and behind|right + behind|Orig: 0.4097<br>PCA: 0.9824<br>Orig: 65.81<br>PCA: 10.76|
|diag. right and in front of|right + in front of|Orig: 0.3837<br>PCA: 0.8453<br>Orig: 67.44<br>PCA: 32.30|



**==> picture [341 x 141] intentionally omitted <==**

**----- Start of picture text -----**<br>
above z<br>10<br>right 10<br>above + right in front<br>y<br>above and right left below<br>− 10 10<br>above<br>5 10 15 20<br>− 10 10 x<br>behind right<br>− 10<br>− 10<br>**----- End of picture text -----**<br>


(a) 2D PCA comparison of the composition of `above` (b) 3D PCA projection of the spatial basis vectors with `right` with the diagonal spatial relation: `above above, below, in front, behind, left` and `and right` . `right` , which can be composed to yield new relations. 

Figure 2: Visualization of spatial relation basis vectors and their compositional structure in PCA space. 

**Results** Our results identify a low-dimensional subspace in which spatial relation representations exhibit clear compositional structure. Table 2 presents the metrics comparing composed representations in 2D, obtained by vector addition of atomic relations, with directly learned compositional relations. Across all four diagonal relations, we observe high cosine similarity in the PCA space (mean = 0.9931), indicating that the composed vectors closely align with the target representations. The angular deviation in PCA space is low (mean = 6.02°), supporting the geometric consistency of these compositions. Experiments in 3D support this hypothesis, albeit with stronger angle deviations (Table 3). Figure 3a visualizes the compositional direction of the atomic vectors _above_ and _right_ , illustrating the strong alignment between composed and directly learned vectors. 

7 

**==> picture [398 x 19] intentionally omitted <==**

**----- Start of picture text -----**<br>
(a) Representations of object 1. The clusters corre- (b) Representations of object 2 given the position of<br>spond to the four base relations. object 1.<br>**----- End of picture text -----**<br>


Figure 3: The relative position of two objects can be retrieved from their embeddings. (a) Object 1 shows clear embedding clusters for each base spatial relation; (b) Object 2 approximates flipped configuration of object 1, yielding a mirrored embedding structure. This confirms that the learned spatial embeddings preserve relative positioning. 

## **5.3 Location of Objects** 

**Motivation.** We have identified a structured subspace isomorphic to R[3] within the model’s activation space, corresponding to spatial relations. We now examine whether objects _O_ occupy positions _S ⊆_ R[3] within this same subspace. In other words, are objects represented at consistent locations in the spatial basis we extracted? If so, the model’s internal geometry would support world states _S_ = _{p_ 1 _, p_ 2 _, . . . , pn}_ , satisfying the conditions required for a spatial world model _W_ = _⟨_ R[3] _, O, S, T ⟩_ . 

**Experiments.** To assess whether objects occupy structured positions in the learned spatial subspace, we extract the coordinates of our objects on our basis in _R_[3] . For simplicity and interpretability, we restrict our analysis to a two-dimensional plane R[2] _⊂_ R[3] . We project test-set activation vectors for _obj1_ and _obj3_ —taken from the residual stream before layer normalization—into this subspace, using spatial annotations (e.g., _obj1 above obj2_ ) to select examples. This gives projected vectors _p_ ˆ _i ∈_ R[2] representing internal object positions. We evaluate the resulting structure via: (1) cosine similarity between the mean embedding of each object-position group and its probe direction, (2) k-means clustering purity with respect to spatial labels, and (3) variance explained by the top three PCA components to confirm compactness of the spatial subspace. 

**Results.** We find evidence that object representations occupy consistent and distinct locations in the spatial subspace. In our last layer (layer 24), the cosine similarity between the mean embedding for _obj1 above_ and the projected probe direction _w_ ˆabove reaches 0.97, indicating near-perfect alignment with the learned spatial axis. Projected object embeddings form separable clusters which achieve a purity of 77.5%, as shown in Figure 3. If obj1 is located to the left, its representation almost always partake in the left of this subspace. The spatial basis itself is highly compact, with the top three PCA directions explaining near 100% of the variance in the probe directions. These results confirm that the model encodes object positions within the same internal frame used for spatial relations, validating the structure _O ⊂S ⊂_ R[2] _⊂W_ . 

## **5.4 Causal Experiments** 

**Motivation.** We have identified a geometric structure _S ⊂_ R[3] that appears to encode a world model, and a corresponding set of object representations _O_ embedded within this space. Our goal is to test whether this structure is not only present but functionally used by the model for prediction (e.g., next-token prediction). We map _S_ onto _O_ and intervene on the positions of objects via steering operations. If the model relies on this structure, then such edits should systematically alter its behavior, e.g., modifying answers in accordance with the new object configuration. 

8 

|Relation|Succ.|Cases|Rate (%)|95 % CI (%)|
|---|---|---|---|---|
|Above|100|100|100.0|[96.3, 100]|
|Below|100|100|100.0|[96.3, 100]|
|Left|100|100|100.0|[96.3, 100]|
|Right|79|100|79.0|[70.0, 85.8]|
|In ront|62|100|62.0|[52.2, 70.9]|
|Behind|5|100|5.0|[2.2, 11.2]|
|**Overall**|**446**|**600**|**74.3**|[70.8, 77.8]|



Figure 4: Steering success by spatial relation with 95 % confidence intervals. We use the 3D subspace we have isolated above to steer the models. 

**Experiments.** As detailed in Section 4.3, we evaluate whether the spatial subspace basis of R[3] , identified via probing, is causally used by the model. To do so, we construct steering vectors by projecting PCA-derived spatial directions (e.g., `right` ) back into the residual stream at the final token position. These vectors are injected into the model just before generation. We then ask the model to name the direction in which the object is located, and assess whether the response corresponds to our steered direction. We test across 100 samples for each of the six canonical spatial relations and their inverses (e.g., `left of` / `right of` , `above` / `below` ). 

**Results.** As summarized in 4, steering achieves a 74.3 % success rate across all relations, suggesting that we can steer via our identified subspace. Relations such as `above` , `below` , and `left of` consistently achieve near-perfect success. More challenging relations like `behind` and `in front of` yield notably lower success rates. We hypothesize that the phrase `in front of` , being distributed across multiple tokens, makes the underlying direction harder to isolate and steer. In contrast, simpler prepositions (e.g., `left of` ) map more cleanly onto a single steerable direction. Overall, these results indicate that the spatial representation we have identified is used by the model in generation. 

## **6 Discussion** 

**Existence of a World Model.** We have demonstrated the existence of a basic spatial world model embedded linearly within the representations of a large language model. The compositionality of spatial relations—captured by consistent geometric operations in a low-dimensional subspace suggests that the model internally encodes an interpretable spatial structure. This provides concrete evidence for the presence of an implicit world model, at least in the spatial domain. 

**Limitations.** While our findings point to a coherent spatial structure, this work does not investigate other essential components of a full world model, such as temporal dynamics or object permanence. In particular, movement, understood as a transition function over spatial configurations, is not addressed here. Moreover, our analysis focuses on a limited set of spatial relations. Extending the framework to cover a broader and more diverse set of spatial directions would further test the generality of the observed compositionality. Finally, although recent work suggests the shared presence of such representations across different architectures [50], the extent to which these findings generalize beyond the model type studied here remains an open empirical question. 

**Broader Impact.** By identifying internal representations that correspond to human-interpretable spatial reasoning, our findings may help improve alignment between LLM behavior and human expectations [19]. This could support safer deployment of AI in applications involving grounded reasoning, such as robotics and human-computer interaction. From a societal standpoint, understanding the internal representations of language models may help mitigate risks associated with their black-box nature, such as unintended behaviors or spurious generalizations. [51, 52] 
