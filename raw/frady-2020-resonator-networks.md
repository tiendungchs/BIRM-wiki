---
title: "Resonator networks for factoring distributed representations of data structures"
source: "https://ar5iv.labs.arxiv.org/html/2007.03748"
author:
published:
created: 2026-08-31
description: "The ability to encode and manipulate data structures with distributed neural representations could qualitatively enhance the capabilities of traditional neural networks by supporting rule-based symbolic reasoning, a ce…"
tags:
  - "clippings"
---
E. Paxon Frady <sup>1,5</sup> Spencer J. Kent <sup>1,2</sup> Bruno A. Olshausen <sup>1,3,4</sup> Friedrich T. Sommer <sup>1,3,5</sup>

<sup>1</sup> Redwood Center for Theoretical Neuroscience  
<sup>2</sup> Electrical Engineering and Computer Science  
<sup>3</sup> Helen Wills Neuroscience Institute  
<sup>4</sup> School of Optometry  
University of California, Berkeley  
Berkeley, CA 94702  
<sup>5</sup> Intel Laboratories, Neuromorphic Computing Lab  
San Francisco, CA 94111

###### Abstract

The ability to encode and manipulate data structures with distributed neural representations could qualitatively enhance the capabilities of traditional neural networks by supporting rule-based symbolic reasoning, a central property of cognition. Here we show how this may be accomplished within the framework of Vector Symbolic Architectures (VSA) [^37] [^16] [^22], whereby data structures are encoded by combining high-dimensional vectors with operations that together form an algebra on the space of distributed representations. In particular, we propose an efficient solution to a hard combinatorial search problem that arises when decoding elements of a VSA data structure: the factorization of products of multiple code vectors. Our proposed algorithm, called a resonator network, is a new type of recurrent neural network that interleaves VSA multiplication operations and pattern completion. We show in two examples – parsing of a tree-like data structure and parsing of a visual scene – how the factorization problem arises and how the resonator network can solve it. More broadly, resonator networks open the possibility to apply VSAs to myriad artificial intelligence problems in real-world domains. A companion paper [^26] presents a rigorous analysis and evaluation of the performance of resonator networks, showing it out-performs alternative approaches.

## 1 Introduction

Cognition requires making use of learned knowledge in contexts never before encountered, a facility that requires information to be represented in terms of components that may be flexibly recombined. A longstanding goal for neuroscience and psychology has been to understand how such capacities are expressed by neural networks in the brain. Early artificial intelligence researchers developed frameworks of symbol-manipulation to emulate cognition, but they were implemented with local data representations (where the meaning of a bit is tied to its location) that are brittle and non-adaptive [^23]. Connectionism, a movement started in psychology [^32], based itself on the premise that internal representations of knowledge must be highly distributed and be able to adapt to the statistics of the data, so as to learn by example. Along the way, however, connectionism also gave up many of the rich capabilities offered by symbolic computation [^20]. In recent years, it has become clear that a unification of the ideas behind each approach – distributed representation, adaptivity, and symbolic manipulation – will be required for reproducing the brain’s ability to learn from few examples, to deal with novel situations, or to change behaviors when driven by internal information processing rather than purely by external events. [^41] [^15] [^25] [^29].

Digital computers owe their power and ubiquity to the abstraction of data structures, which support decomposing information into parts, referencing each part individually, and composing these parts with other data structures. Examples include trees, records with fields, or linked lists. Connectionist theories have long been criticized because it is hard to imagine how compound, hierarchical data structures could be represented and manipulated by neural networks [^17]. Cognitive scientists have argued that, at the very least, cognitive data structures should support three patterns of combination, which are familiar to any computer programmer [^11]. 1) Key-value pairs: A key or variable is a placeholder for information to which a value can be assigned in a particular instance. This association, *variable binding*, generates what is called the systematicity of cognition [^10] [^41]. 2) Sequential structures: A *sequence* is an ordered pattern of organization and computation required by many reasoning tasks. 3) Hierarchy: the notion that some aspects of knowledge can be decomposed recursively into a set of successively more fundamental parts. Variable binding, sequence, and hierarchy are critical structures of cognition, and a comprehensive theory of intelligence must take these into account.

A family of models called Vector Symbolic Architectures (VSAs) encode these structures into distributed representations, providing a framework that can reconcile the symbolic and connectionist perspectives [^41] [^15] [^25]. Building on the concept of reduced representations [^17], VSAs allow one to express data structures holographically in a vector space of high but fixed dimensionality. The atoms of representation are random high-dimensional vectors, and data structures built from these atoms are vectors with the same dimension. Three operations are used to form and manipulate data structures – addition, multiplication, and permutation – which together form an algebra over the space of high-dimensional vectors. These operations enable building representations of sets, ordered lists (sequences), n-tuples, trees, key-value bindings, and records containing role-filler relationships which can be composed into hierarchies, as described in [^38] [^22] [^23] [^21] [^13] and below.

In order to read out or access the components of a VSA-encoded data structure, the high-dimensional vector representing it must be decomposed into the primitives or atomic vectors from which it is built. This is the problem of decoding. For example, if the primitives are combined by addition only, the distributed representation can be decoded by a nearest-neighbor lookup or an autoassociative memory. However, hierarchical or compound data structures, such as a multi-level tree or an object with multiple attributes bound together, are built from combinations of addition, multiplication and permutation operations on the primitives. In this case, decoding via a simple nearest-neighbor lookup would require storing every possible combination of the primitives – e.g., all possible paths in a tree, or all the possible attribute combinations – essentially amounting to a combinatoric search problem. Past applications of VSAs have largely sidestepped this problem by limiting the depth of the data structures or using a brute force approach to consider all possible combinations when necessary [^39] [^6]. As a result, the application of VSAs to real-world problems has been rather limited, since up to now there has not been a solution for efficiently accessing elements of such compound data structures containing a product of multiple components.

The solution to this dilemma is to *factorize* the high-dimensional vector representing a compound data structure into the primitives from which it is composed. That is, given a high-dimensional vector formed from an element-wise product of two or more vectors, we must find its factors. This way, a nearest-neighbor lookup need only search over the alternatives for each factor individually rather than all possible combinations. Obviously though, factorization poses a difficult computational problem in its own right.

Here, we propose an efficient algorithm for factorizing high-dimensional vectors that may be interpreted as a type of recurrent neural network, which we call a *resonator network*. The resonator network relies on the VSA principle of *superposition* to search through the combinatoric solution space without directly enumerating all possible factorizations. Given a high-dimensional vector as input, the network iteratively searches through many potential factorizations in parallel until a set of factors is found that agrees with the input. Solutions emerge as stable fixed-points in the network dynamics.

In this paper, part one of a two-part series, we first briefly introduce the VSA framework and the problem of factoring high-dimensional VSA representations. We then show via two examples – searching a binary tree and querying the contents of a visual scene – how VSAs may be used to build distributed representations of compound data structures, and how resonator networks are used to decompose these data structures and solve the problem. Part two of this series [^26] provides rigorous mathematical and simulation analysis of resonator networks, and compares its performance with alternative approaches for solving high-dimensional vector factorization problems.

## 2 VSA preliminaries

All entities in a VSA are represented as high-dimensional vectors in the same space, with vector dimension $N$ typically in the range of $1{,}000-10{,}000$. In this paper, we focus on the VSA framework called *Multiply-Add-Permute* [^16] [^15]. The atomic primitives are ‘bipolar’ vectors whose components are $\pm 1$, chosen randomly. These vectors are used as symbols to represent concepts. The set of atomic vectors representing specific items are stored in a codebook, which is a matrix of dimension $N\times D$, where $D$ is the number of atoms.

The use of high-dimensional vectors is an important aspect of the VSA framework, as it relies on the concentration of measure phenomenon [^31] that independently chosen random vectors are very close to orthogonal, a property we refer to as *quasi-orthogonality*. This property allows vectors to act symbolically, as the similarity (inner product) between two different atomic vectors is small compared to their self-similarity (L2 norm). Furthermore, a much larger set of quasi-orthogonal vectors exist than orthogonal vectors, which may be exploited for combinatoric search.

Data structures are composed and computations are carried out via an algebra consisting of three vector operations: addition, multiplication and permutation. The elements of a data structure are then read out (decoded) using the conventional vector dot product as a similarity measure to compare to items stored in the codebook. The VSA operations of addition, multiplication, and permutation act to manipulate the vector symbols in ways that preserve or destroy their similarity.

Formally, the VSA operations are defined as follows:

Dot product ($\cdot$)

is the conventional vector inner product, $\mathbf{x}\cdot\mathbf{s}=\sum_{i}x_{i}\,s_{i}$, which is used to measure the ‘similarity’ between vectors. This is used to decode the result of a VSA computation by comparing the vector to the set of vectors in the codebook:

$$
\mathbf{a}=\mathbf{X}^{\top}\mathbf{s}
$$

Here, $\mathbf{X}$ is the codebook of atomic vectors, and $\mathbf{s}$ is a high-dimensional vector resulting from a VSA computation. The result of a VSA computation can be a single symbol indicated by the largest component of $\mathbf{a}$. Alternatively, the coefficients $\mathbf{a}$ can be considered as a weighted sum, where each entry indicates a confidence level, probability, or intensity value.

Addition ($+$)

is used to ‘superpose’ items together, like forming a set. It is defined by regular vector addition, the element-wise sum:

$$
\mathbf{s}=\mathbf{x}+\mathbf{y},
$$

or $s_{i}=x_{i}+y_{i}$. Depending on the circumstances, the sum may be kept as is, or subsequently thresholded so that each $s_{i}$ is $\pm 1$. In either case, the addition operation results in a vector that is similar to each of its superposed components – one can determine the members of the sum by similarity to the atomic vectors. Superposition is possible because of the quasi-orthogonal property. However, superposition produces a small amount of *crosstalk noise*, which increases with the number of items in the sum and is diminished with large vector dimensionality (see [^13] for detailed characterization of superposition).

Multiplication ($\odot$)

is used to ‘bind’ items together to form a conjunction, such as in assigning a value to a variable. It is defined by the Hadamard product between vectors, i.e. the element-wise multiplication of vector components:

$$
\mathbf{s}=\mathbf{x}\odot\mathbf{y},
$$

or $s_{i}=x_{i}\,y_{i}$. This multiplication operation is invertible, i.e. $\mathbf{y}=\mathbf{s}\odot\mathbf{x}$, and it distributes over addition, $\mathbf{x}\odot\mathbf{y}+\mathbf{x}\odot\mathbf{z}=\mathbf{x}\odot(\mathbf{y}+\mathbf{z})$. Note that in the MAP VSA, the bipolar primitive vectors are their own self-inverses. In contrast to addition, multiplication generates a vector that is dissimilar to each of its inputs [^25].

Permutation ($\rho(\cdot)$)

is used to ‘protect’ or ‘order’ items. Permutation operates on a single input vector. In principle, it can be any random permutation, but is typically a simple cyclic shift:

$$
\mathbf{s}=\rho(\mathbf{x})
$$

or $s_{i}=x_{(i-1)\%N}$. Permutation distributes over both addition, $\rho(\mathbf{x})+\rho(\mathbf{y})=\rho(\mathbf{x}+\mathbf{y})$, and multiplication, $\rho(\mathbf{x})\odot\rho(\mathbf{y})=\rho(\mathbf{x}\odot\mathbf{y})$, and its function is complementary to addition and multiplication. Permutations are used to protect the components of a data structure built with these other operations, based on the fact that permutation and binding are non-commutative, $\mathbf{x}\odot\rho(\mathbf{y})\neq\mathbf{y}\odot\rho(\mathbf{x})$. In essence, permutation rotates vectors into dimensions of the space that are almost orthogonal to the dimensions used by the original vectors. Information is thus protected when combined with other items, because vector components will not appear similar to or interfere with those other items. Permutations can also be used to index sequences [^13], or levels in a hierarchy, by successive application of the permutation operation. For example to represent the sequence $\mathbf{x}_{0},\mathbf{x}_{1},\mathbf{x}_{2}$ in a vector $\mathbf{s}=\mathbf{x}_{0}+\rho(\mathbf{x}_{1})+\rho^{2}(\mathbf{x}_{2})$, with $\rho^{2}(\mathbf{x})=\rho(\rho(\mathbf{x}))$.

VSAs combine these operations to form data structures and to compute with them. The combination of atomic vectors into composite data structures is rather straightforward. But, as we shall see, querying composite data structures often results in the problem of decoding terms composed of two (or perhaps many more) atomic vectors that are multiplied together. In order to decode such composite vectors, one must search through many combinations of atoms. In general, this is a hard combinatorial search problem, which typically requires directly testing every combination of factors. The resonator network can efficiently solve these problems without needing to directly test every combination of factors.

## 3 Factorization via search in superposition

In general, the factorization problems that arise in VSAs may involve two or more factors, but let us assume we are given a composite vector $\mathbf{s}$, formed as a product of three vectors:

$$
\mathbf{s}=\mathbf{x}_{i^{*}}\odot\mathbf{y}_{j^{*}}\odot\mathbf{z}_{k^{*}}
$$

where the vectors $\mathbf{x}_{i^{*}}$, $\mathbf{y}_{j^{*}}$, and $\mathbf{z}_{k^{*}}$ are drawn from codebooks $\mathbf{X}=\{\mathbf{x}_{1},...,\mathbf{x}_{D}\}$, $\mathbf{Y}=\{\mathbf{y}_{1},...,\mathbf{y}_{D}\}$ and $\mathbf{Z}=\{\mathbf{z}_{1},...,\mathbf{z}_{D}\}$. Given $\mathbf{s}$ and the codebooks $\mathbf{X}$, $\mathbf{Y}$, and $\mathbf{Z}$, the task is to find $\mathbf{x}_{i^{*}}$, $\mathbf{y}_{j^{*}}$, and $\mathbf{z}_{k^{*}}$.

The resonator network is an iterative approach to solve this problem without exhaustively searching through each possible combination of the factors. A key motivating idea behind resonator networks is the VSA principle of superposition. In VSAs, multiple symbols can be expressed simultaneously in a single high-dimensional vector via vector addition. Randomized atomic vectors are highly likely to be close to orthogonal in high-dimensional space, meaning that they can be superposed without much interference. However, there is some crosstalk noise between the superposed symbols, and “clean-up memory” (such as a Hopfield Network) is thus utilized to reduce the crosstalk noise.

A resonator network combines the strategy of superposition and clean-up memory to efficiently search over the combinatorially large space of possible factorizations. The vectors $\mathbf{\hat{x}}$, $\mathbf{\hat{y}}$, and $\mathbf{\hat{z}}$ represent the current estimate for each factor. These vectors can be initialized to the superposition of all possible factors, e.g. $\mathbf{\hat{x}}(0)=\sum_{i}^{D}\mathbf{x}_{i}$, $\mathbf{\hat{y}}(0)=\sum_{j}^{D}\mathbf{y}_{j}$, etc. A particular factor can then be inferred from $\mathbf{s}$ based on the estimates for the other two, e.g. $\mathbf{\hat{z}}(1)=\mathbf{s}\odot\mathbf{\hat{x}}(0)\odot\mathbf{\hat{y}}(0)$. Since binding distributes over addition, the product $\mathbf{\hat{x}}(0)\odot\mathbf{\hat{y}}(0)$ expresses every combination of factors in superposition, because $\mathbf{\hat{x}}(0)\odot\mathbf{\hat{y}}(0)=\sum_{i}^{D}\sum_{j}^{D}\mathbf{x}_{i}\odot\mathbf{y}_{j}$. For instance, if $D=100$, then this initial guess represents $D^{2}=10{,}000$ combinations in superposition. Thus, many potential combinations of the pair of factors may be considered at once when inferring the third factor.

The inference process, however, is noisy if many guesses are tested simultaneously. This noise results from crosstalk of many quasi-orthogonal vectors, and can be reduced through a clean-up memory. This is built from the codebooks, which contain all the vectors that are possible factors of the input $\mathbf{s}$. Each clean-up memory projects the initial noisy estimate onto the span of the codebook. This computes a measure of confidence for whether each element in the codebook is a factor.

The result of the inference and clean-up leads to a new estimate for each factor. The new estimate is formed by a sum of dictionary items weighted by the confidence levels. This produces a better guess for each one of the factors. The inference can then be repeated with better guesses, which reduces crosstalk noise even further. By iteratively applying this procedure, the inference and clean-up stages cooperate to successively reduce crosstalk noise until the solution is found.

![Refer to caption](https://ar5iv.labs.arxiv.org/html/2007.03748/assets/Figures_misc/Resonator_Network_Diagram_LettersAboveLines_V3.png)

Figure 1: A resonator network with three factors

The procedure described above, for all three factors, is specified by the following set of equations (Fig. 1):

$$
\displaystyle\begin{split}\mathbf{\hat{x}}(t+1)&=g(\mathbf{X}\mathbf{X}^{\top}(\mathbf{s}\odot\mathbf{\hat{y}}(t)\odot\mathbf{\hat{z}}(t)))\\
\mathbf{\hat{y}}(t+1)&=g(\mathbf{Y}\mathbf{Y}^{\top}(\mathbf{s}\odot\mathbf{\hat{x}}(t)\odot\mathbf{\hat{z}}(t)))\\
\mathbf{\hat{z}}(t+1)&=g(\mathbf{Z}\mathbf{Z}^{\top}(\mathbf{s}\odot\mathbf{\hat{x}}(t)\odot\mathbf{\hat{y}}(t)))\\
\end{split}
$$

where the function $g$ prevents runaway positive feedback by thresholding the elements of each vector to $\pm 1$.

If we examine the clean-up memory for $\mathbf{\hat{x}}$, which contains a matrix multiplication with $\mathbf{X}\mathbf{X}^{\top}$ and thresholding function $g$, then we see this operation is nearly identical to a Hopfield network with outer-product Hebbian learning [^18]. Except here, rather than directly feeding back into itself, the result of the clean-up is sent to other parts of the network.

The set of equations in (2) defines a nonlinear dynamical system that has interesting empirical and theoretical properties, which we thoroughly examine through simulation experiments in part two of this series [^26]. Empirically, the system bounces around in state space until the correct solution appears to “resonate” with the network dynamics, popping out as if in a moment of insight. We find that while there is no Lyapunov function governing these dynamics and no guarantee for convergence, the resonator network empirically converges to the correct solution with high probability, as long as the number of product combinations to be searched is within the network’s *operational capacity*. We show that the operational capacity is given by a quadratic function of $N$. Compared to numerous alternative optimization methods that we considered, this capacity for resonator networks is higher by almost two orders of magnitude.

## 4 Decoding data structures with resonator networks

We now turn to two examples that illustrate how VSA operations can be combined to build distributed representations of data structures, how the factorization problem arises when parsing these representations, and how resonator networks can be designed to solve this problem.

### 4.1 Searching a tree data structure

Consider the tree data structure depicted in Figure 2. We can form a distributed representation of this tree in a single high-dimensional vector by using all three VSA operations, namely superposition $+$, binding $\odot$, and permutation $\rho(\cdot)$. First, each leaf in the tree is assigned a random vector $\mathbf{a},\mathbf{b},\ldots,\mathbf{g}\in\{-1,+1\}^{N}$. We also assign random vectors $\mathbf{left}$ and $\mathbf{right}$ that are used to describe position in the tree. Moving from the root of the tree to a particular leaf involves a sequence of left and right turns. The order of these turns is represented by permutation $\rho(\cdot)$. The number of times permutation is applied indicates depth within the tree: $\mathbf{left}$ is a left turn at depth $0$, $\rho(\mathbf{left})$ is a left turn at depth $1$, $\rho^{2}(\mathbf{left})$ is a left turn at depth $2$, and so on. A sequence of turns is represented by the *binding* of these vectors, e.g., $\mathbf{left}\odot\rho(\mathbf{left})\odot\rho^{2}(\mathbf{left})$ corresponds to three left turns. We can then attach to each leaf its position in the tree, again with binding, e.g., $\mathbf{a}\odot\mathbf{left}\odot\rho(\mathbf{left})\odot\rho^{2}(\mathbf{left})$. Finally, the representation for the whole tree is collapsed into a single vector, $\mathbf{tree}$, via superposition:

$$
\displaystyle\begin{split}\mathbf{tree}\,\,\,=\,\,\,\,&\,\mathbf{a}\odot\mathbf{left}\odot\rho(\mathbf{left})\odot\rho^{2}(\mathbf{left})\\
+\,&\,\mathbf{b}\odot\mathbf{left}\odot\rho(\mathbf{right})\odot\rho^{2}(\mathbf{left})\\
+\,&\,\mathbf{c}\odot\mathbf{right}\odot\rho(\mathbf{right})\odot\rho^{2}(\mathbf{left})\\
+\,&\,\mathbf{d}\odot\mathbf{right}\odot\rho(\mathbf{right})\odot\rho^{2}(\mathbf{right})\odot\rho^{3}(\mathbf{left})\\
+\,&\,\mathbf{e}\odot\mathbf{right}\odot\rho(\mathbf{right})\odot\rho^{2}(\mathbf{right})\odot\rho^{3}(\mathbf{right})\\
+\,&\,\mathbf{f}\odot\mathbf{left}\odot\rho(\mathbf{right})\odot\rho^{2}(\mathbf{right})\odot\rho^{3}(\mathbf{left})\odot\rho^{4}(\mathbf{left})\\
+\,&\,\mathbf{g}\odot\mathbf{left}\odot\rho(\mathbf{right})\odot\rho^{2}(\mathbf{right})\odot\rho^{3}(\mathbf{left})\odot\rho^{4}(\mathbf{right})\\
\end{split}
$$
![Refer to caption](https://ar5iv.labs.arxiv.org/html/2007.03748/assets/res-tree_search-200301.png)

Figure 2: Tree search with a resonator network. The query of the vector 𝐭𝐫𝐞𝐞 \\mathbf{tree} produces an encoding of position which the resonator network can factor. The colored plots indicate the time evolution of 𝐱 ^ ( 0 ) … 4 \\hat{\\mathbf{x}}^{(0)}\\ldots\\,\\hat{\\mathbf{x}}^{(4)} (from left to right), showing the cosine similarity of each estimate to each of the three possible vectors ρ d 𝐥𝐞𝐟𝐭, 𝐫𝐢𝐠𝐡𝐭 𝟏 \\rho^{d}(\\mathbf{left}),\\rho^{d}(\\mathbf{right}),\\mathbf{1}. Purple indicates low similarity, and yellow indicates high similarity. Initially the similarity changes significantly, until the three estimators find a coherent factorization and quickly converge. Red letters indicate the converged result for each.

The vector $\mathbf{tree}$ encodes the information so that we can flexibly query the data structure using VSA operations. For instance, we can find the identity of the leaf located at position left, right, left by “unbinding” the representation of this location from the vector representing the tree. Binding and unbinding are performed with the same operation since bipolar vectors are self-inverses. When we unbind the query location by Hadamard product, it will distribute through the superposition and cancel out with itself, leaving the atomic vector attached to that location “exposed”:

$$
\mathbf{tree}\odot{\big(\mathbf{left}\odot\rho(\mathbf{right})\odot\rho^{2}(\mathbf{left})\big)}=\mathbf{b}+noise
$$

The noise term arises since the query distributes through the sum. The other terms combine with the query, but remain quasi-orthogonal to the vectors stored in the codebook, which keeps the other items in the tree “hidden”. That is, the terms contained in $noise$ are dissimilar from each of the atoms stored in the codebook, and this appears as Gaussian noise when decoding [^13]. The vector $\mathbf{b}+noise$ will have high similarity with atom $\mathbf{b}$ in the codebook, and will be successfully decoded by nearest neighbor or associative memory lookup among the atoms with high probability.

With this flexible encoding of the data structure, instead of asking for the label at a specific position, we can ask for the position of a specific label (essentially the problem of tree search). For instance, the query that exposes the position of label c is simply:

$$
\mathbf{tree}\odot\mathbf{c}=\mathbf{right}\odot\rho(\mathbf{right})\odot\rho^{2}(\mathbf{left})+noise
$$

This presents a new challenge, however, because we still need to decode the composite vector $\mathbf{right}\odot\rho(\mathbf{right})\odot\rho^{2}(\mathbf{left})+noise$ into the parts that describe a position in the tree. In previous applications of VSAs one would exhaustively enumerate all traversals of the tree and compute similarity to find the path. Instead, we can use a resonator network.

To set up the network for this problem, we first establish a maximum depth to search through – the maximum depth determines the number of factors that need to be estimated. For the tree shown in Figure 2, we need five estimators, because this is the depth of the deepest leaves, f and g.

Each factor estimate will determine whether to go left, right or to stop, for each level down the tree. To indicate stop a special vector is used, the identity vector $\mathbf{1}$ (a vector of all ones). By using the appropriate number of these identity vectors, each location in the tree can be thought of as a composition with the same depth (the maximum depth), even if the location is only partially down the tree. For instance, if we consider leaf c in the Figure 2, then its position $\mathbf{right}\odot\rho(\mathbf{right})\odot\rho^{2}(\mathbf{left})$ is also $\mathbf{right}\odot\rho(\mathbf{right})\odot\rho^{2}(\mathbf{left})\odot\mathbf{1}\odot\mathbf{1}$. This way, we can set up a resonator network for five factors and have it decode locations anywhere in the tree.

We denote each factor estimate as $\hat{\mathbf{x}}^{(0)},\hat{\mathbf{x}}^{(1)},\hat{\mathbf{x}}^{(2)},\hat{\mathbf{x}}^{(3)},\hat{\mathbf{x}}^{(4)}$ and the codebook matrices as $\mathbf{X}_{0},\mathbf{X}_{1},\mathbf{X}_{2},\mathbf{X}_{3},\mathbf{X}_{4}$. Each codebook matrix contains permuted versions of $\mathbf{left}$ and $\mathbf{right}$, and $\mathbf{1}$: $\mathbf{X}_{d}=\big[\rho^{d}(\mathbf{left}),\rho^{d}(\mathbf{right}),\mathbf{1}\big]$ where $d$ indicates the depth in the tree. The network is constructed analogous to (2), but with five factor estimates running in parallel instead of three. For instance, the update equation for the first estimate is:

$$
\mathbf{\hat{x}}^{(0)}(t+1)=g\big(\mathbf{X}_{0}\mathbf{X}_{0}^{\top}(\mathbf{s}\odot\mathbf{\hat{x}}^{(1)}(t)\odot\mathbf{\hat{x}}^{(2)}(t)\odot\mathbf{\hat{x}}^{(3)}(t)\odot\mathbf{\hat{x}}^{(4)}(t))\big)
$$

The process is demonstrated in Figure 2. The input vector to be factorized, $\mathbf{s}$, is first formed from the tree data structure and the query. For instance to find the location of label c, $\mathbf{s}=\mathbf{tree}\odot\mathbf{c}$ is the input to the resonator network. Different leaves in the tree can be found by unbinding the leaf representation from the tree vector and using this result as the input.

We visualize the network dynamics by displaying the similarity of each factor estimate $\hat{\mathbf{x}}^{(d)}(t)$ to the atoms stored in its corresponding codebook $\mathbf{X}_{d}$. The evolution of these similarity weights over time is shown as a heat map (Fig. 2, right). The heat maps show that the system initially jumps around chaotically, with the weighting of each estimate changing drastically each iteration. But then there is a quite sudden transition to a stable equilibrium, where each estimate converges nearly simultaneously, and at this point the output for each factor is essentially the codebook element with highest weight.

### 4.2 Visual scene analysis as a factorization problem

Next, we show how VSAs can encode the compositional structure of a visual scene, and how the resonator network can be used to decode the contents of the scene. Consider the scene in Figure 3 containing colored MNIST digits [^30] in different positions. Position in the scene is indexed by vertical and horizontal coordinates, each quantized into three possible values, (top, middle, bottom) and (left, center, right), respectively. Each digit can take on one of seven possible colors (blue, green, cyan, red, pink, yellow, white). The digits are labelled by their semantic class (0, 1, …, 9), but the exact shape will differ, as the stimuli are sampled from the $50{,}000$ exemplars in the MNIST training set.

Any given scene can have between one and three of these objects, which are allowed to partially occlude one another. We generate symbolic vectors $\mathbf{c}_{\texttt{blue}},\mathbf{c}_{\texttt{green}},\ldots,\mathbf{c}_{\texttt{white}}$ to encode color, $\mathbf{d}_{\texttt{0}},\mathbf{d}_{\texttt{1}},\ldots,\mathbf{d}_{\texttt{9}}$ to encode shape, $\mathbf{v}_{\texttt{top}},\mathbf{v}_{\texttt{middle}},\mathbf{v}_{\texttt{bottom}}$ to encode vertical position, and $\mathbf{h}_{\texttt{left}},\mathbf{h}_{\texttt{center}},\mathbf{h}_{\texttt{right}}$ to encode horizontal position, which are stored in respective codebooks, $\mathbf{C},\mathbf{D},\mathbf{V},\mathbf{H}$.

The example scene (Fig. 3) contains a cyan 7 at position top, left, a pink 3 at position top, right, and a red 8 at position middle, left. While this is a highly simplified type of visual scene, it illustrates the combinatorial challenge of representing and interpreting visual scenes. There are only $23$ distinct atomic parameters ($10$ for digit identity, $7$ for color, $3$ each for vertical and horizontal position) and yet these combine to describe $10\times 7\times 3\times 3=630$ individual objects, and $630+630^{2}+630^{3}=250{,}444{,}530$ possible scenes with $1$, $2$, or $3$ objects. This number of combinations still does not include the variability among exemplars for each shape, of which there are $50,000$ in the MNIST dataset.

![Refer to caption](https://ar5iv.labs.arxiv.org/html/2007.03748/assets/Figures_VisualScene/visual_scene_deep_net_diagram.png)

Figure 3: Generating a vector symbolic encoding of a visual scene

The VSA approach to represent a scene like this is to form the conjunction of each of the four factors with the binding operation, and superposing multiple objects together to form a single high-dimensional vector that constitutes a distributed representation of the entire scene. This encoding is depicted in Figure 3, and like in the previous examples, the encoding provides a flexible data structure such that aspects of the scene can be individually queried. One attractive property of this representation is that its dimensionality does not grow with the number of objects in the scene, nor does it impose any particular ordering on the objects.

To convert a new input image into a structured VSA representation, one challenge is to deal with the variability and correlations between the shapes of different hand-written digits. VSAs are designed for symbolic processing in neural networks. However, when dealing with sensor data streams one must solve the encoding problem, which is how to map the input data into the symbolic space [^43] [^27]. We train a simple feed-forward neural network with two fully-connected hidden layers to produce the desired VSA encoding of the scene. The feed-forward network was trained on a (uniformly) random sample of these scenes, with the MNIST digits chosen from an exclusive training set. A generative model creates the image of the scene from a random sample of factors for each object. From the chosen factors, the VSA representation of the scene is also generated through binding of VSA vectors for each factor and superposition for each object (Fig. 3). Supervised learning via back-propagation is used to train the network to output the VSA representation of the entire scene from the image pixels as input.

The resonator network can then be used to parse the output of the feed-forward network to identify each object and its properties. The vectors $\mathbf{\hat{c}}(t)$, $\mathbf{\hat{d}}(t)$, $\mathbf{\hat{h}}(t)$ and $\mathbf{\hat{v}}(t)$ denote the *guesses* for each factor: color, digit, horizontal- and vertical-location, respectively. The scene can then be decoded by iterating through the resonator network:

$$
\displaystyle\begin{split}\mathbf{\hat{c}}(t+1)&=g\Big(\mathbf{C}\mathbf{C}^{\top}\Big(\mathbf{s}\odot\mathbf{\hat{d}}(t)\odot\mathbf{\hat{v}}(t)\odot\mathbf{\hat{h}}(t)\Big)\Big)\\
\mathbf{\hat{d}}(t+1)&=g\Big(\mathbf{D}\mathbf{D}^{\top}\Big(\mathbf{s}\odot\mathbf{\hat{c}}(t)\odot\mathbf{\hat{v}}(t)\odot\mathbf{\hat{h}}(t)\Big)\Big)\\
\mathbf{\hat{v}}(t+1)&=g\Big(\mathbf{V}\mathbf{V}^{\top}\Big(\mathbf{s}\odot\mathbf{\hat{d}}(t)\odot\mathbf{\hat{c}}(t)\odot\mathbf{\hat{h}}(t)\Big)\Big)\\
\mathbf{\hat{h}}(t+1)&=g\Big(\mathbf{H}\mathbf{H}^{\top}\Big(\mathbf{s}\odot\mathbf{\hat{d}}(t)\odot\mathbf{\hat{c}}(t)\odot\mathbf{\hat{v}}(t)\Big)\Big)\\
\end{split}
$$
![Refer to caption](https://ar5iv.labs.arxiv.org/html/2007.03748/assets/Figures_VisualScene/res_viz_scene_decomposition.png)

Figure 4: Scene vector 𝐬 \\mathbf{s} is fed into a resonator network which decodes each object in the scene. The model hones in on one object at a time, which is then explained away by subtracting the resonator network’s converged state from the scene vector. The network is reset and provided with this new input vector. It then converges to another solution, which describes a different object in the scene.

The encoding of visual scenes described superposes a composite vector for each object, each of which individually is a valid solution to the factorization of the scene. When we present the scene vector $\mathbf{s}$ to a resonator network, it automatically hones in on a particular one of these composites, finding its factors. For instance, in Figure 4 the resonator network first identifies the pink three in the top right. Once the factorization has been found, this object is then “explained away” by subtracting it from $\mathbf{s}$. What remains are the other composites, still in superposition. The resonator network is then reset (each resonator is reinitialized to the superposition of all possible codevectors) and presented with the new explained-away scene vector. It will then hone in on one of the remaining objects, in this case the red 8. This sequence may be repeated until all the objects have been decoded. This technique is similar to what is known as “deflation” in the context of tensor decomposition methods [^7].

After training on $100{,}000$ images, we used the network to produce symbolic vectors for a held-out test set of $10{,}000$ images. The vector dimensionality $N$ is a free parameter, which we chose to be $500$. If the exact ground truth vector is provided to a resonator network, it will infer the factors with $100\%$ accuracy provided $N$ is large enough, a fact we establish in part two of this series [^26]. For this small visual scene example it turns out $N=500$ more than suffices for the number of possible factorizations to be searched. Note that $N=500$ is less than the total number of combinations of all the factors, which is $630$.

The encoder network generates VSA scene vectors that are close to the ground-truth encoding, but there is some error. The error gets larger with more digits in the scene, perhaps partially due to occlusion of the digits. Figure 5 shows that the resonator network can tolerate significant error in the scene vector produced by the feed-forward encoding network, correcting for ambiguity not resolved in the encoding step.

![Refer to caption](https://ar5iv.labs.arxiv.org/html/2007.03748/assets/Figures_VisualScene/mnist_performance_plot_without_BR.png)

Figure 5: Resonator networks correct encoding errors. Visual scenes with one, two, and three objects are separated into separate columns. Top row gives encoding quality, in terms of cosine similarity between the feed-forward network output and the ground-truth scene vector, across the test-set. We define correct factorization as the case where the resonator network correctly infers all the factors of all objects. The bottom row shows the empirical probability of a correct factorization as a function of similarity to the ground truth scene vector. Lines are logistic function fits to the data.

## 5 Discussion

A major quest for modern artificial intelligence is to build computational models that combine the abilities of neural networks with the abilities of rule-based reasoning. Vector Symbolic Architectures, a family of connectionist models, enable the formation of distributed representations of data structures, structured computation on these representations, and has provided valuable conceptual insights for cognition and computation. However, so far, VSA models have not been able to solve challenging artificial intelligence problems in real-world domains due to the combinatorial factorization problem that arises when processing complex, hierarchical data structures. Our contribution here has been to provide an efficient solution to the factorization problem, the resonator network, which we show in a companion paper [^26] vastly outperforms standard optimization methods.

The two applications we showed here – parsing a tree-like data structure and decomposing a visual scene – are intended as illustrative examples to show how factorization of multi-term products arises in querying a VSA data structure, and they show how to design resonator networks to solve such problems. Having a solution to the factorization problem now makes it possible to apply VSAs to myriad problems in computational neuroscience, cognitive science and artificial intelligence – from visual scene analysis to natural language understanding and analogical reasoning.

### 5.1 Implications for neuroscience

The ability to solve factorization problems is fundamental to both perception and cognition. In vision for example, the signal measured by a photoreceptor contains a combination of illumination, surface reflectance, surface orientation, and atmospheric properties that essentially need to be “demultiplied” by the visual system in order to recover a representation of the underlying causes in a scene [^4] [^1] [^3]. The problem of separating form and motion may also be posed as a factorization problem [^5] [^34] [^2]. In the domain of language, it has been argued that a factorization of sentence structure into “roles” and “fillers” is required for robust and flexible processing [^44] [^20]. Many cognitive tasks, such as analogical reasoning, also require a form of factorization [^19] [^24] [^39]. However, to date it has been unclear how these factorization problems could be represented and solved efficiently by neural circuits in the brain. VSAs and resonator networks are a potential neural solution to these problems, and indeed developing more neurobiologically plausible models along these lines is a goal of ongoing work.

In the context of neuroscience and psychology, binding is widely theorized to be an important process by which the brain properly associates features belonging to the same physical object. However, how the brain may accomplish this is a hotly debated subject. Various solutions to this problem, also known as the *Neural Binding Problem*, have been proposed based on attentional mechanisms or neural synchrony [^46] [^48] [^49]. Note that in these proposals the binding information required to properly describe sets of compound objects has to be added to the individual feature representations, thus increasing the dimension for representing a compound object (or expanding the representation in time).

VSAs provide a general solution to the binding problem that early visual stages could employ. By using the VSA operations to represent and form data structures, the binding of features is easily expressed. Further, the dimension of the compound representation is not increased. The main computational challenge then becomes the factorization of VSA data structures formed in early sensory pathways, for which the resonator network provides a neurally plausible solution. Interestingly, an earlier discussion of the binding problem by [^9] has already pointed out that the more fundamental problem of sensory processing is actually one of unbinding. Feldman has argued that the raw sensory signals themselves can be thought of as being composites, containing multiple attributes that require factorization, such as in the examples described here.

In terms of modeling computation in biological neural circuits, resonator networks are clearly an abstraction. In particular, the implementation of VSAs presented here assumes that information is encoded by *dense* bipolar vectors (each element is nonzero), and the binding operation is performed by element-wise multiplication of vectors. At first glance these types of representations and operations may not seem very biologically plausible. However, other variants of VSAs that utilize sparse, rather than dense, representations may help to reconcile this disconnect [^42] [^28]. Recently, we have shown that compound objects can be efficiently represented by sparse vectors with the same dimension as the atomic representations [^12]. The binding operation in this context relies upon *sigma-pi* type operations [^33] [^40] that are potentially compatible with active non-linearities found in dendritic trees. Complex-valued variations of VSAs [^41] can also be linked to spike-timing codes [^14], which could further increase links to biology.

### 5.2 Implications for machine learning

In conventional deep learning approaches, given enough labeled data, a multi-layer network can be trained end-to-end without worrying about understanding or parsing the representations formed by the intermediate layers. Users typically consider the interior of a deep network as a black box. However, this conceptual convenience becomes a disadvantage when it comes to improving the deficiencies of deep learning methods, namely susceptibility to adversarial attacks, the need for large amounts of labeled data, and a lack of generalization to novel situations. Moreover, while most machine-learning algorithms are focused on problems of pattern matching, or learning a mapping from inputs to outputs, most problems in perception and cognitive reasoning require more than just pattern matching – they also the ability to form and manipulate data structures.

VSAs offer a transparent approach to forming distributed representations of potentially complex data structures that may be flexibly recombined to deal with novel situations. For any desired computation, the relevant elements in the data structure can be exposed, or decoded, and combined with other information to calculate a result. Here we have shown how these data structures can be formed and manipulated to solve challenging computational problems such as tree search or visual scene analysis. The key to solving these problems relies upon the ability to factorize high-dimensional vectors, which can now be done by resonator networks. Given that the problem of factorization arises in many other machine-learning settings, such as simultaneous inference of multiple variables, inverse graphics, and language, it seems likely that resonator networks could provide an efficient solution in these domains as well.

One can potentially combine VSA’s with deep learning to get the best of both worlds. An example of this may be seen in our solution to parsing a visual scene (Section 4.2). Rather than training a network to simply map images to class-labels, our approach trains the network to map the image to a symbolic description that captures the compositional structure of a scene – i.e., multiple objects combined with their properties – which can be used by downstream processes to reason about the scene. Importantly, because multiple object-property bindings can be superposed in the same space, the VSA encoding can handle the very large combinatoric space of possible scenes (in this case, 250 million) with a single vector of fixed dimensionality (500). The VSA representation does have a limited capacity and will begin to break down for more than a few objects. However it is worth noting that human working memory has similar limitations [^35].

While there are undoubtedly alternative deep learning approaches for performing analysis of simple scenes, our goal here was to show how analysis of visual scenes could be approached by expressing the problem as a problem of factorization. Incorporating factorization into problems like scene analysis may enable reasoning in much more complex spaces, as such a system can utilize factorization to handle a very large combinatoric space. However, the simple hybrid approach presented here still has some shortcomings, such as requiring a large amount of training data to learn the encoding.

We believe that multi-layer neural networks could be improved profoundly by enabling all layers to explicitly represent, learn, and factorize data structures. Some recent model innovations follow this direction, particularly the “Transformer” neural network architecture which encodes key-value pairs for modeling language and other types of data [^47] [^8]. Other model proposals enable the encoding of multiplicative relationships between features using the tensor product [^36] [^45]. VSAs could enable these models to represent and manipulate increasingly complex data structures, but this requires solving factorization problems. Resonator networks could thus serve as a critical component for building trainable neural networks that form, query, and manipulate large hierarchical data structures.

### Acknowledgements

We would like to thank members of the Redwood Center for Theoretical Neuroscience for helpful discussions, in particular Pentti Kanerva, whose work on Vector Symbolic Architectures originally motivated this project. This work was generously supported by NIH grant 1R01EB026955-01, the NSF grants IIS1718991 and DGE1752814, the Intel Neuromorphic Research Community, Berkeley DeepDrive, the Seminconductor Research Corporation and NSF under E2CDA-NRI, and DARPA’s Virtual Intelligence Processing (VIP) program.

[^1]: Adelson, E. H. and Pentland, A. P. (1996). The perception of shading and reflectance. Perception as Bayesian inference, pages 409–423.

[^2]: Anderson, A. G., Ratnam, K., Roorda, A., and Olshausen, B. (2020). High acuity vision from retinal image motion. Journal of Vision, to appear.

[^3]: Barron, J. T. and Malik, J. (2014). Shape, illumination, and reflectance from shading. IEEE transactions on pattern analysis and machine intelligence, 37(8):1670–1687.

[^4]: Barrow, H. and Tenenbaum, J. (1978). Recovering intrinsic scene characteristics from images. Computer Vision Systems, 2:3–26.

[^5]: Cadieu, C. F. and Olshausen, B. A. (2012). Learning intermediate-level representations of form and motion from natural movies. Neural computation, 24(4):827–866.

[^6]: Cox, G. E., Kachergis, G., Recchia, G., and Jones, M. N. (2011). Toward a scalable holographic word-form representation. Behavior research methods, 43(3):602–615.

[^7]: da Silva, A. P., Comon, P., and de Almeida, A. L. (2015). An iterative deflation algorithm for exact cp tensor decomposition. In 2015 IEEE International Conference on Acoustics, Speech and Signal Processing (ICASSP), pages 3961–3965. IEEE.

[^8]: Devlin, J., Chang, M.-W., Lee, K., and Toutanova, K. (2018). Bert: Pre-training of deep bidirectional transformers for language understanding. arXiv preprint arXiv:1810.04805.

[^9]: Feldman, J. (2013). The neural binding problem ( s ). Cognitive neurodynamics, 7:1–11.

[^10]: Fodor, J. A. (1975). The Language of Thought. Thomas Y. Crowell, New York, NY.

[^11]: Fodor, J. A. and Pylyshyn, Z. W. (1988). Connectionism and cognitive architecture: A critical analysis. Cognition.

[^12]: Frady, E., Kleyko, D., and Sommer, F. (2020). Variable binding for sparse distributed representations: Theory and applications. in prep.

[^13]: Frady, E. P., Kleyko, D., and Sommer, F. T. (2018). A theory of sequence indexing and working memory in recurrent neural networks. Neural Computation.

[^14]: Frady, E. P. and Sommer, F. T. (2019). Robust computation with rhythmic spike patterns. Proceedings of the National Academy of Sciences, 116(36):18050–18059.

[^15]: Gayler, R. (2003). Vector symbolic architectures answer jackendoff’s challenges for cognitive neuroscience. ICCS/ASCS International Conference on Cognitive Science.

[^16]: Gayler, R. W. (1998). Multiplicative binding, representation operators & analogy (workshop poster). In Holyoak, K., Gentner, D., and Kokinov, B., editors, Advances in analogy research: Integration of theory and data from the cognitive, computational, and neural sciences.

[^17]: Hinton, G. E. (1990). Mapping part-whole hierarchies into connectionist networks. Artificial Intelligence, 46(1-2):47–75.

[^18]: Hopfield, J. J. (1982). Neural networks and physical systems with emergent collective computational abilities. Proceedings of the National Academy of Sciences, 79(8):2554–2558.

[^19]: Hummel, J. E. and Holyoak, K. J. (1997). Distributed representations of structure: A theory of analogical access and mapping. Psychological review, 104(3):427.

[^20]: Jackendoff, R. (2002). Foundations of language: brain, meaning, grammar, evolution. Oxford University Press, Oxford, UK.

[^21]: Joshi, A., Halseth, J. T., and Kanerva, P. (2016). Language geometry using random indexing. In International Symposium on Quantum Interaction, page 265–274. Springer.

[^22]: Kanerva, P. (1996). Binary spatter-coding of ordered k-tuples. In International Conference on Artificial Neural Networks, pages 869–873.

[^23]: Kanerva, P. (1997). Fully distributed representation. In Proceedings of the 1997 Real World Computing Symposium (RWC ’97, Tokyo, Jan. 1997), pages 358–365. Real World Computing Partnership.

[^24]: Kanerva, P. (1998). Large patterns make great symbols: An example of learning from example. In International Workshop on Hybrid Neural Systems, pages 194–203. Springer.

[^25]: Kanerva, P. (2009). Hyperdimensional computing: An introduction to computing in distributed representation with high-dimensional random vectors. Cognitive Computation, 1(2):139–159.

[^26]: Kent, S. J., Frady, E. P., Sommer, F. T., and Olshausen, B. A. (2020). Resonator networks outperform optimization methods at solving high-dimensional vector factorization. arXiv:1906.11684 \[cs.NE\].

[^27]: Kleyko, D., Rahimi, A., Rachkovskij, D. A., Osipov, E., and Rabaey, J. M. (2018). Classification and recall with binary hyperdimensional computing: Tradeoffs in choice of density and mapping characteristics. IEEE Transactions on Neural Networks and Learning Systems, 29(12):5880–5898.

[^28]: Laiho, M., Poikonen, J. H., Kanerva, P., and Lehtonen, E. (2015). High-dimensional computing with sparse vectors. In 2015 IEEE Biomedical Circuits and Systems Conference (BioCAS), pages 1–4. IEEE.

[^29]: Lake, B. M., Ullman, T. D., Tenenbaum, J. B., and Gershman, S. J. (2017). Building machines that learn and think like people. Behavioral and brain sciences, 40.

[^30]: LeCun, Y. (1998). The mnist database of handwritten digits.

[^31]: Ledoux, M. (2001). The concentration of measure phenomenon. Number 89. American Mathematical Soc.

[^32]: McClelland, J. L., Rumelhart, D. E., Group, P. R., et al. (1986). Parallel distributed processing. Explorations in the Microstructure of Cognition, 1.

[^33]: Mel, B. W. and Koch, C. (1990). Sigma-pi learning: On radial basis functions and cortical associative learning. In Advances in neural information processing systems, pages 474–481.

[^34]: Memisevic, R. and Hinton, G. E. (2010). Learning to represent spatial transformations with factored higher-order boltzmann machines. Neural computation, 22(6):1473–1492.

[^35]: Miller, G. A. (1956). The magic number seven plus or minus two: Some limits on our capacity for processing information. Psychological review, 63:91–97.

[^36]: Nickel, M., Tresp, V., and Kriegel, H.-P. (2011). A three-way model for collective learning on multi-relational data. In Proceedings of the 28th International Conference on Machine Learning (ICML).

[^37]: Plate, T. A. (1991). Holographic reduced representations: Convolution algebra for compositional distributed representations. In International Joint Conference on Artificial Intelligence, pages 30–35.

[^38]: Plate, T. A. (1995). Holographic reduced representations. IEEE Transactions on Neural Networks, 6(3):623–641.

[^39]: Plate, T. A. (2000a). Analogy retrieval and processing with distributed vector representations. Expert systems, 17(1):29–40.

[^40]: Plate, T. A. (2000b). Randomly connected sigma–pi neurons can form associator networks. Network: Computation in neural systems, 11(4):321–332.

[^41]: Plate, T. A. (2003). Holographic reduced representation: Distributed representation of cognitive structure. CSLI Publications, Stanford, CA.

[^42]: Rachkovskij, D. A. and Kussul, E. M. (2001). Binding and normalization of binary sparse distributed representations by context-dependent thinning. Neural Computation, 13(2):411–452.

[^43]: Räsänen, O. J. (2015). Generating hyperdimensional distributed representations from continuous-valued multivariate sensory input. In CogSci.

[^44]: Smolensky, P. (1990). Tensor product variable binding and the representation of symbolic structures in connectionist systems. Artificial Intelligence, 46(1-2):159–216.

[^45]: Socher, R., Chen, D., Manning, C. D., and Ng, A. (2013). Reasoning with neural tensor networks for knowledge base completion. In Advances in neural information processing systems, pages 926–934.

[^46]: Treisman, A. M. and Gelade, G. (1980). A feature-integration theory of attention. Cognitive psychology, 12(1):97–136.

[^47]: Vaswani, A., Shazeer, N., Parmar, N., Uszkoreit, J., Jones, L., Gomez, A. N., Kaiser, Ł., and Polosukhin, I. (2017). Attention is all you need. In Advances in neural information processing systems, pages 5998–6008.

[^48]: von der Malsburg, C. (1999). The what and why of binding: the modeler’s perspective. Neuron, 24(1):95–104.

[^49]: Wolfe, J. M. and Cave, K. R. (1999). The psychophysical evidence for a binding problem in human vision. Neuron, 24(1):11–17.