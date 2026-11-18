---
title: "The discovery of structural form"
source: "https://www.pnas.org/doi/10.1073/pnas.0802631105"
author:
  - "[[Charles Kemp]]"
  - "[[Joshua B. Tenenbaum]]"
published: 2008-05-30
created: 2026-11-18
description: "Algorithms for finding structure in data have become increasingly important both as tools for scientific data analysis and as models of human learning, yet they suffer from a critical limitation. S..."
tags:
  - "clippings"
---
## Abstract

Algorithms for finding structure in data have become increasingly important both as tools for scientific data analysis and as models of human learning, yet they suffer from a critical limitation. Scientists discover qualitatively new forms of structure in observed data: For instance, Linnaeus recognized the hierarchical organization of biological species, and Mendeleev recognized the periodic structure of the chemical elements. Analogous insights play a pivotal role in cognitive development: Children discover that object category labels can be organized into hierarchies, friendship networks are organized into cliques, and comparative relations (e.g., “bigger than” or “better than”) respect a transitive order. Standard algorithms, however, can only learn structures of a single form that must be specified in advance: For instance, algorithms for hierarchical clustering create tree structures, whereas algorithms for dimensionality-reduction create low-dimensional spaces. Here, we present a computational model that learns structures of many different forms and that discovers which form is best for a given dataset. The model makes probabilistic inferences over a space of graph grammars representing trees, linear orders, multidimensional spaces, rings, dominance hierarchies, cliques, and other forms and successfully discovers the underlying structure of a variety of physical, biological, and social domains. Our approach brings structure learning methods closer to human abilities and may lead to a deeper computational understanding of cognitive development.

Discovering the underlying structure of a set of entities is a fundamental challenge for scientists and children alike ([^1] – [^4]). Scientists may attempt to understand relationships between biological species or chemical elements, and children may attempt to understand relationships between category labels or the individuals in their social landscape, but both must solve problems at two distinct levels. The higher-level problem is to discover the form of the underlying structure. The entities may be organized into a tree, a ring, a dimensional order, a set of clusters, or some other kind of configuration, and a learner must infer which of these forms is best. Given a commitment to one of these structural forms, the lower-level problem is to identify the instance of this form that best explains the available data.

The lower-level problem is routinely confronted in science and cognitive development. Biologists have long agreed that tree structures are useful for organizing living kinds but continue to debate which tree is best—for instance, are crocodiles better grouped with lizards and snakes or with birds ([^5])? Similar issues arise when children attempt to fit a new acquaintance into a set of social cliques or to place a novel word in an intuitive hierarchy of category labels. Inferences like these can be captured by standard structure-learning algorithms, which search for structures of a single form that is assumed to be known in advance ([Fig. 1](#F1) *A*). Clustering or competitive-learning algorithms ([^6], [^7]) search for a partition of the data into disjoint groups, algorithms for hierarchical clustering ([^8]) or phylogenetic reconstruction ([^9]) search for a tree structure, and algorithms for dimensionality reduction ([^10], [^11]) or multidimensional scaling ([^12]) search for a spatial representation of the data.

![](https://www.pnas.org/cms/10.1073/pnas.0802631105/asset/58247779-01e9-4544-a3b7-000b5a28e5ea/assets/graphic/zpq9990841630001.jpeg)

Finding structure in data. ( A ) Standard structure learning algorithms search for representations of a single form that is fixed in advance. Shown here are methods that discover six different kinds of structures given a matrix of binary features. ( B ) A hierarchical model that discovers the form F and the structure S that best account for the data D. The model searches for the form and structure that jointly maximize P (, | ) ∝ ) ).

Higher-level discoveries about structural form are rarer but more fundamental, and often occur at pivotal moments in the development of a scientific field or a child's understanding ([^1], [^2], [^3]). For centuries, the natural representation for biological species was held to be the “great chain of being,” a linear structure in which every living thing found a place according to its degree of perfection ([^13]). In 1735, Linnaeus famously proposed that relationships between plant and animal species are best captured by a tree structure, setting the agenda for all biological classification since. Modern chemistry also began with a discovery about structural form, the discovery that the elements have a periodic structure. Analogous discoveries are made by children, who learn, for example, that social networks are often organized into cliques, that temporal categories such as the seasons and the days of the week can be arranged into cycles, that comparative relations such as “longer than” or “better than” are transitive ([^14], [^15]) and that category labels can be organized into hierarchies ([^16]). Structural forms for some cognitive domains may be known innately, but many appear to be genuine discoveries. When learning the meanings of words, children initially seem to organize objects into nonoverlapping clusters, with one category label allowed per cluster ([^17]); hierarchies of category labels are recognized only later ([^16]). When reasoning about comparative relations, children's inferences respect a transitive ordering by the age of 7 but not before ([^18]). In both of these cases, structural forms appear to be learned, but children are not explicitly taught to organize these domains into hierarchies or dimensional orders.

Here, we show that discoveries about structural form can be understood computationally as probabilistic inferences about the organizing principles of a dataset. Unlike most structure-learning algorithms ([Fig. 1](#F1) *A*), the model we present can simultaneously discover the structural form and the instance of that form that best explain the data ([Fig. 1](#F1) *B*). Our approach can handle many kinds of data, including attributes, relations, and measures of similarity, and we show that it successfully discovers the structural forms of a diverse set of real-world domains.

Any model of form discovery must specify the space of structural forms it is able to discover. We represent structures using graphs and use graph grammars ([^19]) as a unifying language for expressing a wide range of structural forms ([Fig. 2](#F2)). Of the many possible forms, we assume that the most natural are those that can be derived from simple generative processes ([^20]). Each of the first six forms in [Fig. 2](#F2) *A* can be generated by using a single context-free production that replaces a parent node with two child nodes and specifies how to connect the children to each other and to the neighbors of the parent node. [Fig. 2](#F2) *B–D* shows how three of these productions generate chains, orders, and trees. More complex forms, including multidimensional spaces and cylinders, can be generated by combining these basic forms or by using more complex productions.

![](https://www.pnas.org/cms/10.1073/pnas.0802631105/asset/ba329d56-2720-4cc5-ac63-2b9e308ed5a6/assets/graphic/zpq9990841630002.jpeg)

A hypothesis space of structural forms. ( A ) Eight structural forms and the generative processes that produce them. Open nodes represent clusters of objects: A hierarchy has objects located internally, but a tree may only have objects at its leaves. The first six processes are node-replacement graph grammars. Each grammar uses a single production, and each production specifies how to replace a parent node with two child nodes. The seed for each grammar is a graph with a single node (in the case of the ring, this node has a self-link). ( B–D ) Growing chains, orders, and trees. At each step in each derivation, the parent and child nodes are shown in gray. The graph generated at each step is often rearranged before the next step. In B, for instance, the right side of the first step and the left side of the second step are identical graphs. The red arrows in each production represent all edges that enter or leave a parent node. When applying the order production, all nodes that previously sent a link to the parent node now send links to both children.

It is striking that the simple grammars in [Fig. 2](#F2) *A* generate many of the structural forms discussed by psychologists ([^21]) and assumed by algorithms for unsupervised learning or exploratory data analysis. Partitions ([^6], [^22]), chains ([^23]), orders ([^1], [^22], [^24]), rings ([^25], [^26]), trees ([^1], [^9], [^27]), hierarchies ([^28], [^29]) and grids ([^30]) recur again and again in formal models across many different literatures. To highlight just one example, Inhelder and Piaget ([^1]) suggest that the elementary logical operations in children's thinking are founded on two forms: a classification structure that can be modeled as a tree and a seriation structure that can be modeled as an order. The popularity of the forms in [Fig. 2](#F2) suggests that they are useful for describing the world, and that they spring to mind naturally when scientists seek formal descriptions of a domain.

The problem of form discovery can now be posed. Given data *D* about a finite set of entities, we want to find the form *F* and the structure *S* of that form that best capture the relationships between these entities. We take a probabilistic approach, and define a hierarchical generative model ([^31]) that specifies how the data are generated from an underlying structure, and how this structure is generated from an underlying form ([Fig. 1](#F1) *B*). We then search for the structure *S* and form *F* that maximize the posterior probability ![](https://www.pnas.org/cms/10.1073/pnas.0802631105/asset/26472b74-db9c-4171-9b9f-f1d6e30ee391/assets/graphic/zpq03108-4163-m01.jpeg) *P* (*F*) is a uniform distribution over the forms under consideration ([Fig. 2](#F2)). Structure *S* is a cluster graph, an instance of one of the forms in [Fig. 2](#F2), where the nodes represent clusters of entities ([Fig. 4](#F4) *A* shows a cluster graph with the form of an order). The prior *P* (*S* | *F*) favors graphs where *k*, the number of clusters, is small: *P* (*S* | *F*) ∝ θ *<sup>k</sup>* if *S* is compatible with *F*, and *P* (*S* | *F*) = 0 otherwise \[see [supporting information (SI) *Appendix*](https://www.pnas.org/cgi/data/0802631105/DCSupplemental/Appendix_PDF) for the definition of compatibility\]. The parameter θ determines the extent to which graphs with many clusters are penalized, and is fixed for all of our experiments. The normalizing constant for *P* (*S* | *F*) depends on the number of structures compatible with a given form, and ensures that simpler forms are preferred whenever possible. For example, any chain *S* <sub>c</sub> is a special case of a grid, but *P* (*S* <sub>c</sub> | *F* = chain) > *P* (*S* <sub>c</sub> | *F* = grid) because there are more possible grids than chains given a fixed number of entities. It follows that *P* (*S* <sub>c</sub>, *F* = chain| *D*) > *P* (*S* <sub>c</sub>, *F* = grid| *D*) for any dataset *D*, and that the grid form will only be chosen if the best grid is substantially better than the best chain.

The remaining term in [Eq. **1**](#FD1), *P* (*D* | *S*), measures how well the structure *S* accounts for the data *D*. Suppose that *D* is a feature matrix like the matrix in [Fig. 1](#F1). *P* (*D* | *S*) will be high if the features in *D* vary smoothly over the graph *S*, that is, if entities nearby in *S* tend to have similar feature values. For instance, feature **f** <sup>1</sup> is smooth over the tree in [Fig. 1](#F1) *B*, but **f** <sup>100</sup> is not. Even though [Fig. 1](#F1) shows binary features, we treat all features as continuous features and capture the expectation of smoothness by assuming that these features are independently generated from a multivariate Gaussian distribution with a dimension for each node in graph *S*. As described in [*SI Appendix*](https://www.pnas.org/cgi/data/0802631105/DCSupplemental/Appendix_PDF), the covariance of this distribution is defined in a way that encourages nearby nodes in graph *S* to have similar feature values, and the term *P* (*D* | *S*) favors graphs that meet this condition.

In principle, our approach can be used to identify the form *F* that maximizes *P* (*F* | *D*), but we are also interested in discovering the structure *S* that best accounts for the data. We therefore search for the structure *S* and form *F* that jointly maximize the scoring function *P* (*S*, *F* | *D*) ([Eq. **1**](#FD1)). To identify these elements, we run a separate greedy search for each candidate form. Each search begins with all entities assigned to a single cluster, and the algorithm splits a cluster at each iteration, using the production for the current form ([Fig. 2](#F2)). After each split, the algorithm attempts to improve the score, using several proposals, including proposals that move an entity from one cluster to another and proposals that swap two clusters. The search concludes once the score can no longer be improved. A more detailed description of the search algorithm is provided in *SI Appendix*.

We generated synthetic data to test this algorithm on cases where the true structure was known. The [*SI Appendix*](https://www.pnas.org/cgi/data/0802631105/DCSupplemental/Appendix_PDF) shows graphs used to generate five datasets, and the structures found by fitting five different forms to the data. In each case, the model recovers the true underlying form of the data.

Next, we applied the model to several real-world datasets, in each case considering all forms in [Fig. 2](#F2). The first dataset is a matrix of animal species and their biological and ecological properties. It consists of human judgments about 33 species and 106 features and amounts to a larger and noisier version of the dataset shown schematically in [Fig. 1](#F1). The best scoring form for this dataset is the tree, and the best tree ([Fig. 3](#F3) *A*) includes subtrees that correspond to categories at several levels of resolution (e.g., mammals, primates, rodents, birds, insects, and flying insects). The second dataset is a matrix of votes from the United States Supreme Court, including 13 judges and their votes on 1,596 cases. Some political scientists ([^32]) have argued that a unidimensional structure best accounts for variation in Supreme Court data and in political beliefs more generally, although other structural forms \[including higher-dimensional spaces ([^33]) and sets of clusters ([^34])\] have also been proposed. Consistent with the unidimensional hypothesis, our model identifies the chain as the best-scoring form for the Supreme Court data. The best chain ([Fig. 3](#F3) *B*) organizes the 13 judges from liberal (Marshall and Brennan) to conservative (Thomas and Scalia).

![](https://www.pnas.org/cms/10.1073/pnas.0802631105/asset/b3f8399b-01ee-46ce-8979-c8f9afe13f89/assets/graphic/zpq9990841630003.jpeg)

Structures learned from biological features ( A ), Supreme Court votes ( B ), judgments of the similarity between pure color wavelengths ( C ), Euclidean distances between faces represented as pixel vectors ( D ), and distances between world cities ( E ). For A–C, the edge lengths represent maximum a posteriori edge lengths under our generative model.

If similarity is assumed to be a measure of covariance, our model can also discover structure in similarity data. Under our generative model for features, the expression for *P* (*D* | *S*) includes only two components that depend on *D*: the number of features observed and the covariance of the data. As long as both components are provided, [Eq. **1**](#FD1) can be used even if none of the features is directly observed. We applied the model to a matrix containing human judgments of the similarity between all pairs of 14 pure-wavelength hues ([^35]). The ring in [Fig. 3](#F3) *C* is the best structure for these data and corresponds to the color circle described by Newton. Next, we analyzed a similarity dataset where the entities are faces that vary along two dimensions: masculinity and race. The model chooses a grid structure that recovers these dimensions ([Fig. 3](#F3) *D*). Finally, we applied the model to a dataset of distances between 35 world cities. Our model chooses a cylinder where the chain component corresponds approximately to latitude, and the ring component corresponds approximately to longitude.

The same algorithm can be used to discover structure in relational data, but we must modify the distribution *P* (*D* | *S*). Suppose that *D* is a square frequency matrix, where *D* (*i*,*j*) indicates the number of times a certain relation has been observed between entities *i* and *j* ([Fig. 4](#F4)). We define a model where *P* (*D* | *S*) is high if the large entries in *D* correspond to edges in the graph *S*. A similar model can be defined if *D* is a binary relation rather than a frequency matrix. Given a relation *D*, it is important to discover whether the relation tends to hold between elements in the same cluster or only between different clusters, and whether the relation is directed or not. The forms in [Fig. 2](#F2) *A* all have directed edges and nodes without self-links, and we expanded this collection to include forms with self-links, forms with undirected edges, and forms with both of these properties.

![](https://www.pnas.org/cms/10.1073/pnas.0802631105/asset/da33469c-cd62-42c3-9f25-d1ab39a560ac/assets/graphic/zpq9990841630004.jpeg)

Structures learned from relational data ( Upper ) and the raw data organized according to these structures ( Lower ). ( A ) Dominance relationships among a troop of sooty mangabeys. The sorted data matrix has most of its entries above the diagonal, indicating that animals tend to dominate only the animals below them in the order. ( B ) A hierarchy representing interactions between members of the Bush administration. ( C ) Social cliques representing friendship relations between prisoners. The sorted matrix has most of its entries along the diagonal, indicating that prisoners tend only to be friends with prisoners in the same cluster. ( D ) The Kula ring representing armshell trade between New Guinea communities. The relative positions of the communities correspond approximately to their geographic locations.

First, we applied the model to a matrix of interactions among a troop of sooty mangabeys. The model discovers that the order is the most appropriate form, and the best order found ([Fig. 4](#F4) *A*) is consistent with the dominance hierarchy inferred by primatologists studying this troop ([^36]). Hierarchical structure is also characteristic of human organizations, although tree-structured hierarchies are perhaps more common than full linear orders. We applied the model to a matrix of interactions between 13 members of George W. Bush's first-term administration ([^37]). The best form is an undirected hierarchy, and the best hierarchy found ([Fig. 4](#F4) *B*) closely matches an organizational chart built by connecting individuals to their immediate superiors. Next, we analyzed social preference data ([^38]) that represent friendships between prison inmates. Clique structures are often claimed to be characteristic of social networks ([^39]), and the model discovers that a partition (a set of cliques) gives the best account of the data. Finally, we analyzed trade relations between 20 communities in New Guinea ([^40]). The model discovers the Kula ring, an exchange structure first described by Malinowski ([^41]).

We have presented an approach to structure discovery that provides a unifying description of many structural forms, discovers qualitatively different representations for a diverse range of datasets, and can handle multiple kinds of data, including feature data, relational data, and measures of similarity. Our hypothesis space of forms ([Fig. 2](#F2)) includes some of the most common forms, but does not exhaust the set of cognitively natural or scientifically important forms. Ultimately, psychologists should aim to develop a “Universal Structure Grammar” (compare with ref. [^42]) that characterizes more fully the representational resources available to human learners. This universal grammar might consist of a set of simple principles that generate all and only the cognitively natural forms. We can only speculate about how these principles might look, but one starting place is a metagrammar ([^43]) for generating graph grammars. For instance, all of the forms shown in [Fig. 2](#F2) *A* can be generated by a metagrammar shown in [*SI Appendix*](https://www.pnas.org/cgi/data/0802631105/DCSupplemental/Appendix_PDF).

Our framework may be most readily useful as a tool for data analysis and scientific discovery, but should also be explored as a model of human learning. Our model helps to explain how adults discover structural forms in controlled behavioral experiments ([^37]), and is consistent with previous demonstrations that adults can choose the most appropriate representation for a given problem ([^44]). Our model may also help to explain how children learn about the structure of their world. The model shows developmental shifts as more data are encountered, and often moves from a simple form to a more complex form that more faithfully represents the structure of the domain ([Fig. 5](#F5) and [*SI Appendix*](https://www.pnas.org/cgi/data/0802631105/DCSupplemental/Appendix_PDF)). Identifying the best form for a domain provides powerful constraints on inductive inference, constraints that may help to explain how children learn new word meanings, concepts, and relations so quickly and from such sparse data ([^45] – [^46]). Discovering the clique structure of social networks can allow a child to predict the outcome of interactions between individuals who may never have interacted previously. Discovering the hierarchical structure of category labels allows a child to predict that a creature called a “chihuahua” might also be a dog and an animal, but cannot be both a dog and a cat.

![](https://www.pnas.org/cms/10.1073/pnas.0802631105/asset/788d521c-40c5-41b0-84c6-91a6b17f3a11/assets/graphic/zpq9990841630005.jpeg)

Developmental changes as more data are observed for a fixed set of objects. After observing only five features of each animal species, the model chooses a partition, or a set of clusters. As the number of observed features grows from 5 to 20, the model makes a qualitative shift between a partition and a tree. As the number of features grows even further, the tree becomes increasingly complex, with subtrees that correspond more closely to adult taxonomic intuitions: For instance, the canines (dog, wolf) split off from the other carnivorous land mammals; the songbirds (robin, finch), flying birds (robin, finch, eagle), and walking birds (chicken, ostrich) form distinct subcategories; and the flying insects (butterfly, bee) and walking insects (ant, cockroach) form distinct subcategories. More information about these simulations can be found in SI Appendix.

As examples like these suggest, form discovery provides a way of acquiring domain-specific constraints on the structure of mental representations, a possibility that departs from two prominent views of cognition. A typical nativist view recognizes that inductive inference relies on domain-specific constraints but assumes that these constraints are innately provided ([^47] – [^48]). Chomsky ([^47]), for instance, has suggested that “the belief that various systems of mind are organized along quite different principles leads to the natural conclusion that these systems are intrinsically determined, not simply the result of common mechanisms of learning or growth.” A typical empiricist view emphasizes learning but assumes no domain-specific representational structure. Standard methods for learning associative networks ([^49]) and neural networks ([^50]) use the same generic class of representations for every task, instead of attempting to identify the distinctive kinds of structures that characterize individual domains. Without these constraints, empiricist methods can require unrealistically large quantities of training data to learn even very simple concepts ([^51]). Our framework offers a third view that combines insights from both these approaches and shows how domain-specific structural constraints can be acquired by using domain-general probabilistic inference. As children learn about the structure of different domains, they make discoveries as impressive as those of Linnaeus and Mendeleev, and approaches like ours may help to explain how these discoveries are possible.

## Acknowledgments.

We thank P. Gunkel, E. Newport, A. Perfors, and W. Richards for valuable discussions and D. Casasanto, M. Frank, N. Goodman, V. Mansinghka, R. Saxe, J. M. Tenenbaum, D. Tymoczko, the editor, and two anonymous reviewers for helpful suggestions. This work was supported in part by the William Asbjornsen Albert memorial fellowship (to C.K.), the Paul E. Newton career development chair (J.B.T.), the James S. McDonnell Foundation Causal Learning Research Collaborative, Air Force Office of Scientific Research Grant FA9550-07-1-0075, and the NTT Communication Sciences Laboratory.

## Supporting Information

Appendix (PDF)

Supporting Information (PDF)

[Download, PDF (343.65 KB)](https://www.pnas.org/doi/suppl/10.1073/pnas.0802631105/suppl_file/appendix_pdf.pdf)

[^1]: 

[^2]: 

[^3]: 

[^4]: 

[^5]: 

[^6]: 

[^7]: 

[^8]: 

[^9]: 

[^10]: 

[^11]: 

[^12]: 

[^13]: 

[^14]: 

[^15]: 

[^16]: 

[^17]: 

[^18]: 

[^19]: 

[^20]: 

[^21]: 

[^22]: 

[^23]: 

[^24]: 

[^25]: 

[^26]: 

[^27]: 

[^28]: 

[^29]: 

[^30]: 

[^31]: 

[^32]: 

[^33]: 

[^34]: 

[^35]: 

[^36]: 

[^37]: 

[^38]: 

[^39]: 

[^40]: 

[^41]: 

[^42]: 

[^43]: 

[^44]: 

[^45]: 

[^46]: 

[^47]: 

[^48]: 

[^49]: 

[^50]: 

[^51]: