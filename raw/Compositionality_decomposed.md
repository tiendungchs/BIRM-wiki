Journal of Artificial Intelligence Research 67 (2020) 

Submitted 08/2019; published 02/2020 

# **Compositionality decomposed: how do neural networks generalise?** 

## **Dieuwke Hupkes** 

dieuwkehupkes@gmail.com 

_Institute for Logic, Language and Computation University of Amsterdam_ 

**Verna Dankers Mathijs Mul** _University of Amsterdam_ 

vernadankers@gmail.com mathijsmul@gmail.com 

## **Elia Bruni** 

elia.bruni@gmail.com 

_University of Pompeu Fabra_ 

## **Abstract** 

Despite a multitude of empirical studies, little consensus exists on whether neural networks are able to generalise _compositionally_ , a controversy that, in part, stems from a lack of agreement about what it means for a neural model to be compositional. As a response to this controversy, we present a set of tests that provide a bridge between, on the one hand, the vast amount of linguistic and philosophical theory about compositionality of language and, on the other, the successful neural models of language. We collect different interpretations of compositionality and translate them into five theoretically grounded tests for models that are formulated on a task-independent level. In particular, we provide tests to investigate (i) if models systematically recombine known parts and rules (ii) if models can extend their predictions beyond the length they have seen in the training data (iii) if models’ composition operations are local or global (iv) if models’ predictions are robust to synonym substitutions and (v) if models favour rules or exceptions during training. To demonstrate the usefulness of this evaluation paradigm, we instantiate these five tests on a highly compositional data set which we dub PCFG SET and apply the resulting tests to three popular sequence-to-sequence models: a recurrent, a convolution-based and a transformer model. We provide an in-depth analysis of the results, which uncover the strengths and weaknesses of these three architectures and point to potential areas of improvement. 

## **1. Introduction** 

The advancements of distributional semantics of the word level allowed the field of natural language processing to move from discrete mathematical methods to models that use continuous numerical vectors (see, e.g. Clark, 2015; Erk, 2012; Turney and Pantel, 2010). Such continuous vector representations operationalise the distributional semantics hypothesis – stating that semantically similar words have similar contextual distributions (e.g. Miller and Charles, 1991) – by keeping track of contextual information from large textual corpora. They can then act as surrogates for word meaning and be used, for example, to quantify the degree of semantic similarity between words, by means of simple geometric operations (Clark, 2015). Words represented in this way can be an integral part of the computational pipeline and have proven to be useful for almost all natural language processing tasks (see, e.g. Hirschberg and Manning, 2015). 

After the introduction of continuous word representations, a logical next step involved understanding how to _compose_ these representations to obtain representations for phrases, sentences and even larger pieces of discourse. Some early approaches to do so stayed close to formal symbolic theories of language and sought to explicitly model semantic composition by finding a composition function that could be used to combine word representations. The adjective-noun compound _blue_ 

_⃝_ c 2020 AI Access Foundation. All rights reserved. 

Hupkes, Dankers, Mul & Bruni 

_sky_ , for instance, would be represented as a new vector resulting from the composition of the representations for _blue_ and _sky_ . Examples of such composition functions are as simple as vector addition and (point-wise) multiplication (e.g. Mitchell and Lapata, 2008) up to more powerful tensor-based operations (Smolensky, 1990; Plate, 1991) where, for instance, the adjective _blue_ would be represented as a matrix, which would be multiplied with the noun vector _sky_ to return the representation for _blue sky_ (e.g. Baroni and Zamparelli, 2010; Coecke et al., 2010).[1] 

A more recent trend in word composition exploits _deep learning_ , a class of machine learning techniques that model language in a completely data-driven fashion, by defining a loss on a downstream task (such as sentiment analysis, language modelling or machine translation) and learning the representations for larger chunks from a signal back-propagated from this loss. In terms of how they compose representations, models using deep learning can be divided into roughly two categories. 

In the first category, deep learning is exploited to learn only the actual composition functions, while the order of composition is defined by the modeller. An example is the _recursive neural network_ of Socher et al. (2010), in which representations for larger chunks are computed recursively following a predefined syntactic parse tree of the sentence. While the composition function in this approach is fully learned from data using _back-propagation through structure_ (Goller and Kuchler, 1996), the tree structure that defines the order of application has to be provided to the model, allowing models to be ‘compositional by design’. More recent variants lift this dependency on external parse trees by jointly learning the composition function and the parse tree (Le and Zuidema, 2015; Kim et al., 2019, i.a.), often at the cost of computational feasibility. 

In the second type of deep learning models, no explicit notion of (linguistic) trees or arbitrary depth hierarchy is entertained. Earlier models of this type deal with language processing sequentially and use recurrent processing units such as LSTMs (Hochreiter and Schmidhuber, 1997) and GRUs (Chung et al., 2014) at their core (Sutskever et al., 2014) or are based on convolutional networks (Kalchbrenner et al., 2014). An important contribution to their effectiveness comes from attention mechanisms, which allow recurrent models to keep track of long-distance dependencies more effectively (Bahdanau et al., 2015). More recently, these models went all-in on attention, abandoning sequential processing in favour of massively distributed sequence processing all based on attention (Vaswani et al., 2017). While the architectural design of this class of models is not motivated by knowledge about linguistics or human processing, they are – through their ability to easily process very large amounts of data – more successful than the previously mentioned (sub)symbolic models on a variety of natural language processing tasks. 

Different types of models that compose smaller representations into larger ones can be compared along many dimensions. Commonly, they are evaluated by the usefulness of their representations for different types of tasks, but also scalability, how much data they need to develop their representations (sample efficiency), and their computational feasibility play a role in their evaluation. It remains, however, difficult to explicitly assess if the composition functions they implement are appropriate for natural language and, importantly, to what extent they are in line with the vast amount of knowledge and theories about semantic composition from formal semantics and (psycho)linguistics. While the composition functions of symbolic models are easy to understand (because they are defined on a mathematical level), it is not empirically established that their rigidity is appropriate for dealing with the noisiness and complexity of natural language (e.g. Potts, 2019). Neural models, on the other hand, seem very well up to handling noisy scenarios but are often argued to be fundamentally incapable of conducting the types of compositions required to process natural language (for more information on this debate, see Pinker, 1984; Fodor and Pylyshyn, 1988; Smolensky, 1990; Marcus, 2003) or at least to not use those types of compositions to solve their tasks (e.g. Lake and Baroni, 2018). 

In this work, we consider the latter type of models and focus in particular on whether these models are capable of learning _compositional_ solutions, a question that recently, with the rise of the 

> 1. For a more complete overview and an analysis of such approaches in the light of formal semantics, we refer to Kartsaklis (2014) and Boleda and Herbelot (2016), respectively. 

2 

Compositionality decomposed: how do neural networks generalise? 

success of such models, has attracted the attention of several researchers. While many empirical studies can be found that explore the compositional abilities of neural models, they have not managed to convince the community of either side of the debate: whether neural networks are able to learn and behave compositionally is still an open question. One issue standing in the way of more clarity on this matter is that different researchers have different interpretations of what exactly it means to say that a model is or is not compositional, a point exemplified by the vast number of different tests that exist for compositionality. Some studies focused on testing if models are able to productively use symbolic _rules_ (e.g. Lake and Baroni, 2018); Some instead consider models’ ability to process _hierarchical_ structures (Hupkes et al., 2018; Linzen et al., 2016); Yet others consider if models can segment the input into reusable parts (Johnson et al., 2017). 

This variety of tests for compositionality of neural networks existing in the literature is better understandable considering the open nature of the principle of compositionality, by Partee (1995) phrased as “ _The meaning of a whole is a function of the meanings of the parts and of the way they are syntactically combined_ ”. While there is ample support for this principle, there is less consensus about its exact interpretation and practical implications. One important reason for this is that the principle is not theory-neutral: it requires a theory of both syntax and meaning, as well as functions to determine the meaning of composed parts. Without these components, the principle of compositionality is formally vacuous (Janssen, 1983; Zadrozny, 1994), because also trivial and intuitively non-compositional solutions that cast every expression as one part and assign it a meaning as a whole do not formally violate the principle of compositionality. Furthermore, the principle of compositionality concerns the compositionality of _language_ but does not specify what it means for a language _user_ or _model_ to be compositional. Can a model be called compositional when it can represent a compositional language? Are there any restrictions on how it has to do so? To empirically test models for compositionality it is necessary to first establish _what_ is to be considered compositional behaviour. With this work, we aim to contribute to clarity on this point, by presenting a study in which we collect different aspects of and intuitions about compositionality of language from linguistics and philosophy and translate them into concrete tests that can be used to better understand the composition functions learned by neural models trained end-to-end on a downstream task. 

The contribution of our work, we believe, is three-fold. First, we provide a bridge between, on the one hand, the vast amount of theory about compositionality that underpins symbolic models of language and semantic composition and, on the other hand, the neural models of language that have proven to be very effective in many natural language tasks that seem to require compositional capacities. Importantly, we do not aim to provide a new definition of compositionality, but rather we identify different components of compositionality within the literature and design behavioural tests that allow testing for these components independently. We believe that the field will profit from such a principled analysis of compositionality and that this analysis will provide clarity concerning the different interpretations that may be entertained by different researchers. A division into clearly understood components can help to identify and categorise the strengths and weaknesses of different models. We provide concrete and usable tests, bundled in a versatile test suite that can be applied to any kind of model. 

Secondly, to demonstrate the usefulness of this test suite, we apply our tests to three popular sequence-to-sequence models: a recurrent, a convolution-based and a transformer model. We provide an in-depth analysis of the results, uncovering interesting strengths and weaknesses of these three architectures. 

Lastly, we touch upon the complex question that concerns the extent to which a model needs to be explicitly compositional to adequately model data of which the underlying structure is, or seems, compositional. We believe that, in a time where the most successful natural language processing methods require large amounts of data and are not directly motivated by linguistic knowledge or structure, this question bears more relevance than ever. 

3 

Hupkes, Dankers, Mul & Bruni 

**Outline** In what follows, we first briefly revise other literature with similar aims and sketch how our work stands apart from previous attempts to assess the extent to which networks implement compositionality (Section 2). We describe previously proposed data sets to evaluate compositionality as well as studies that evaluate the representations of pre-trained models. In Section 3, we give a theoretical explanation of the five notions for which we devise tests, and we propose how to behaviourally test for them. In Section 4, we describe the data set that we use for our study, followed by a brief description of the three types of architectures that we compare in our experiments in Section 5. We then detail our experiments and report and analyse their results in Section 6 and further reflect upon their implications in Section 7. 

## **2. Related work** 

Whether artificial neural networks are fundamentally capable of representing compositionality, trees and hierarchical structure has been a prevalent topic ever since the first connectionism models for natural language were introduced. Recently, this topic has regained attention, and a substantial number of empirical studies can be found that explore the compositional abilities of neural models, with a specific focus on their ability to represent _hierarchy_ . These studies can be roughly divided into two categories: studies that devise specific data sets that models can be trained and tested on to assess if they behave compositionally, and studies that focus on assessing the representations that are learned by models trained on some independent (often natural) data set. 

## **2.1 Evaluating compositionality with artificial data** 

Specifically crafted, artificial data sets to evaluate compositionality are typically generated from an underlying grammar. It is then assumed that models can only find the right solution to the test set if they learned to interpret the training data in a compositional fashion. Below, we discuss a selection of such data sets and briefly review their results.[2] 

## 2.1.1 Arithmetic language and mathematical reasoning 

One of the first (recent) data sets proposed as a testbed to reveal how neural networks process hierarchical structure is the _arithmetic language_ , introduced by Veldhoen et al. (2016). Veldhoen et al. (2016) test networks for algebraic compositionality by looking at their ability to process spelled out, nested arithmetic expressions. In a follow-up paper, to gain insight into the types of solution that networks encode, the same authors introduce _diagnostic classifiers_ , trained to fire for specific strategies used to solve the problem. They show that simple recurrent networks do not perform well on the task, but gated recurrent networks can generalise well to lengths and depths of arithmetic expressions that were not in the training set, although their performance quickly deteriorates when the length of expressions grows (Hupkes et al., 2018).[3] From this, they conclude that these models are – to some extent – able to capture the underlying compositional structure of the data. 

More recently, Saxton et al. (2019) released another data set in which maths was used to probe the compositional generalisation skills of neural networks. Saxton et al. (2019) compare transformers and LSTM-based architectures trained on a data set with mathematical questions and find that the 

> 2. Discussing in detail all different data sets that have been proposed to evaluate compositionality in neural networks falls outside the scope of this paper. We aimed to make a representative selection of studies, using as a criterion that they should involve sequential inputs and explicitly mention compositionality. We excluded _grounded_ data sets such as CLEVR (Johnson et al., 2017) and SQOOP (Bahdanau et al., 2018), which contain more than one modality. Furthermore, we did not include studies whose primary focus is on _how_ neural networks implement compositional structures (Lakretz et al., 2019; Giulianelli et al., 2018; McCoy et al., 2019; Soulos et al., 2019; Weiss et al., 2018a) or studies that evaluate compositionality only based on models’ representations (Andreas, 2019). 

> 3. Zaremba and Sutskever (2014) also used a task based on arithmetics, which requires learning to execute _computer programs_ , which they use to compare different learning curricula. 

4 

Compositionality decomposed: how do neural networks generalise? 

transformer models generalise better than the LSTM models. Specifically, transformers outperform LSTMs on a set of extrapolation tests that require compositional skills such as generalising to questions involving larger numbers, more numbers or more compositions. However, performance deteriorates for questions that require the computation of intermediate values, which Saxton et al. (2019) reason indicates that the model has not truly learned to treat the task in a compositional manner but instead applies shallow tricks. 

## 2.1.2 SCAN 

In 2018, Lake and Baroni proposed the SCAN data set, describing a simple navigation task that requires an agent to execute commands expressed in a compositional language. The authors test various sequence-to-sequence models on three different splits of the data: a random split, a split testing for longer action sequences and a split that requires compositional application of words learned in isolation. The models obtain almost perfect accuracy on the first split while performing very poorly on the last two, which the authors argue require a compositional understanding of the task. They conclude that – after all these years – sequence-to-sequence recurrent networks are still not _systematic_ . In a follow-up paper by Loula et al. (2018), the same authors criticise these findings and propose a new set of splits which focuses on rearranging familiar words (i.e. “jump”, “right” and “around”) to form novel meanings (“jump around right”) . Although they collect considerably more evidence for systematic generalisation within their amended setup, the authors confirm their previous findings that the models do not learn compositionally. Very recently, SCAN was also used to diagnose convolutional networks. Comparing to recurrent networks, Dess`ı and Baroni (2019) find that convolutional networks exhibit improved compositional generalisation skills but their errors are unsystematic, indicating that the model did not fully master any of the systematic rules. 

## 2.1.3 Lookup tables 

Liˇska et al. (2018) introduce a minimal compositional test where neural networks need to apply function compositions to correctly compute the meaning of sequences of lookup tables. The meanings of these lookup tables are exhaustively defined and presented to the model, so that applying them does not require more than rote memorisation. The authors show that out of many models trained with different initialisations only a very small fraction exhibits compositional behaviour, while the vast majority does not.[4] 

## 2.1.4 Logical inference 

Bowman et al. (2015) propose a data set which uses a slightly different setup: they assess models’ compositional skills by testing their ability to infer logical entailment relations between pairs of sentences in an artificial language. The grammar they use licenses short, simple sentences; the relations between these sentences are inferred using a natural logic calculus that acts directly on the generated expressions. Bowman et al. (2015) show that recursive neural networks, which recursively apply the same composition function and are thus compositional by design, obtain high accuracies on this task. Mul and Zuidema (2019) show that also gated recurrent models can perform well on an adapted version of the same task, which uses a more complex grammar. With a series of additional tests, Mul and Zuidema (2019) provide further proof for basic compositional generalisation skills of the best-performing recurrent models. Tran et al. (2018) report similar findings, and furthermore show that while a transformer performs similar to an LSTM model when the entire data set is used, an LSTM model generalises better when smaller training data is used. 

> 4. Hupkes et al. (2019) show how adding an extra supervision signal to the network’s attention consistently results in a complete solution of the task, but it is not clear how their results extend to other, more complicated scenarios. Korrel et al. (2019) propose a novel architecture with analogous, complete solutions without the need for extra supervision. 

5 

Hupkes, Dankers, Mul & Bruni 

## **2.2 Evaluating compositionality with natural data** 

While very few studies present methods to explicitly evaluate how compositional the representations of models that are trained on independent data sets are, there are several studies that focus on evaluating aspects of such models that are related to compositionality. In particular, starting from the seminal work of Linzen et al. (2016), the evaluation of the syntactic capabilities of neural _language models_ has attracted a considerable amount of attention. While the explicit focus of such studies is on the syntactic capabilities of different models and not on providing tests for compositionality, many of the results in fact concern the way that neural networks process the types of hierarchical structures often assumed to underpin compositionality.[5] 

## 2.2.1 Number agreement 

Linzen et al. (2016) propose to test the syntactic abilities of LSTMs by testing to what extent they are capable of correctly processing long-distance subject-verb agreement, a phenomenon they argue to be commonly regarded as evidence for hierarchical structure in natural language. They devise a _number-agreement_ task and find that a pre-trained state-of-the-art LSTM model (Jozefowicz et al., 2016) does not capture the structure-sensitive dependencies. 

Later, these results were contested by a different research group, who repeated and extended the study with a different language model and tested a number of different long-distance dependencies for English, Italian, Hebrew and Russian (Gulordava et al., 2018). Their results do not match the findings of the earlier study: Gulordava et al. (2018) find that an LSTM language model can solve the subject-verb agreement problem well, even when the words in the sentence are replaced by syntactically nonsensical words, which they take as evidence that the model is indeed relying on syntactic and not semantic clues.[6] Whether the very recent all-attention language models do also capture syntax-sensitive dependencies is still an open question. Some (still unpublished) studies find evidence that such models score high on the previously described number-agreement task (Goldberg, 2019; Lin et al., 2019). More mixed results are reported by others (Tran et al., 2018; Wolf, 2019). 

## 2.2.2 Syntax in machine translation 

The subfield of natural language processing that is most related to ours in terms of setup is the field of machine translation (MT). There are little detailed studies concerning the compositional behaviour of neural MT models but many that consider the representations of trained models. Analyses in this line of work typically consider which properties are encoded by MT models, with a specific focus on the difference between the representations within layers that are situated at different levels of the hierarchy of a model. A robust finding from such analyses is that features such as syntactic constituency, part-of-speech tags and dependency edges can be reliably predicted from the hidden representations of both recurrent neural networks (Shi et al., 2016; Belinkov et al., 2017; Blevins et al., 2018) and transformer models (Raganato and Tiedemann, 2018; Tenney et al., 2019b). Generally, lower-level features are encoded in lower layers, while higher-level syntactic and semantic features are better represented in deeper layers (e.g. Blevins et al., 2018; Tenney et al., 2019a). For transformer models, a recent wave of papers demonstrates that such features can also 

> 5. In fact, there are quite a few earlier studies relating to the ability of neural networks to implement grammatical structure that consider a similar paradigm, albeit using artificial languages. Such studies consider how well neural networks can represent formal languages generated by grammars from different classes of the Chomsky Hierarchy (e.g. Elman, 1991; Christiansen and Chater, 1999; Rodriguez, 2001; Wiles and Elman, 1995; Rodriguez et al., 1999; Batali, 1994; Weiss et al., 2018b). Like the studies with natural language described in this chapter, these studies focus on rules and hierarchical structure but do not specifically target compositionality, which requires not only syntax but also meaning. 

> 6. The task proposed by Linzen et al. (2016) served as inspiration for many studies investigating the linguistic or syntactic capabilities for neural language models, and also the task itself was used in many follow-up studies. Such studies, which we will not further discuss, are generally positive about the extent to which recurrent language models represent syntax. 

6 

Compositionality decomposed: how do neural networks generalise? 

be extracted from attention patterns (Vig and Belinkov, 2019; Mareˇcek and Rosa, 2018; Lin et al., 2019). While these results do not straightforwardly extend to the questions about compositionality that we are considering in this work, they do demonstrate that both recurrent and attention-based models trained in a setup similar to the one considered for this work are able to capture the types of higher-level syntactic features that are often considered to be key for compositional behaviour. 

## **2.3 Intermediate conclusions** 

We reviewed various attempts to assess the extent to which neural models are able to implement compositionality and hierarchy. This overview illustrated the difficulty and importance of evaluating the behaviour of neural models but also showed that whether neural networks can or do learn compositionally is still an open question. Both strands of approaches we considered – approaches that use special compositional data sets to train and test models, and approaches that instead focus on the evaluation of pre-trained models – report positive as well as negative results. 

In the first approach, researchers try to encode a certain notion of compositionality in the task itself. While it is important, when testing for compositionality, to make sure the specific task that networks are trained on has a clear demand for compositional solutions, we believe these studies fall short in explicitly linking the task they propose to clearly-defined notions of compositionality. Further, we believe that the multifaceted notion of compositionality cannot be exhausted in one single task. In the following section, we disconnect testing compositionality from the task at hand and disentangle five different theoretically motivated ways in which a network can exhibit compositional behaviours that are not a priori linked to a specific downstream task. 

The second type of studies roots its tests into clear linguistic hypotheses. However, by testing neural networks that are trained on uncontrolled data, they lose the direct connection between compositionality and the downstream task. Although compositionality is widely considered to play an important role for natural language, it is unknown what type of compositional skills – if any – a model needs to have to successfully model tasks involving natural language, such as for instance language modelling. If it cannot be excluded that successful heuristics or syntax-insensitive approximations exist, a negative result can not be taken as evidence that a particular type of model cannot capture compositionality, it merely indicates that this exact model instance did not capture it in this exact case. While, in the long run, we also wish to reconnect the notion of compositionality to natural data, we believe that before being able to do so, it is of primary importance to reach an agreement about what defines compositional behaviour and how it should be tested for in neural networks. 

## **3. Testing compositionality** 

In the previous section, we discussed various attempts to evaluate the compositional skills of neural network models. We argued that progressing further on this question requires more clarity on what defines compositionality for neural networks, which we address in this work by providing tests that are more strongly grounded in the literature about compositionality. We now arrive at the theoretical part of the core of our research, in which we set the theoretical ground for the five tests we propose and conduct in this paper. We describe five aspects of compositionality that are explicitly motivated by theoretical literature on this topic and propose, on a high level, how to translate them into behavioural tests for (neural) models. 

We propose to test (i) if models systematically recombine known parts and rules ( _systematicity_ ) (ii) if models can extend their predictions beyond the length they have seen in the training data ( _productivity_ ) (iii) if models’ predictions are robust to synonym substitutions ( _substitutivity_ ) (iv) if models’ composition operations are local or global ( _localism_ ) and (v) if models favour rules or exceptions during training ( _overgeneralisation_ ). Below, we describe the theory that motivated us to 

7 

Hupkes, Dankers, Mul & Bruni 

select these aspects, and we describe on an abstract level how we translate them into concrete tests. A systematic depiction is shown in Figure 1. 

**==> picture [402 x 189] intentionally omitted <==**

**----- Start of picture text -----**<br>
+<br>(a) Systematicity (b) Productivity<br>(c) Substitutivity<br>(d) Localism (e) Overgeneralisation<br>**----- End of picture text -----**<br>


Figure 1: Schematic depictions of the five tests we propose to test the compositionality of neural network models. (a) To test for systematicity, we evaluate models’ ability to recombine known parts to form new sequences. (b) While the productivity test also requires recombining known parts, the focus there lies on unboundedness: we test if models can understand sequences _longer_ than the ones they were trained on. (c) In the substitutivity test, we evaluate how robust models are towards the introduction of synonyms, and, more specifically, in which cases words are considered synonymous. (d) The localism test targets how local the composition operations of models are: are smaller constituents evaluated before larger constituents? (e) The overgeneralisation test evaluates how likely models are to infer rules: is a model instantly able to accommodate exceptions, or does it need more evidence to deviate from applying the general rule instantiated by the rest of the data? 

## **3.1 Systematicity** 

The first property we propose to test for – following many of the works presented in the related work section of this article – is _systematicity_ , a notion frequently used in the context of compositionality. The term was introduced by Fodor and Pylyshyn (1988) – notably, in a paper that argued against connectionist architectures – who used it to denote that 

“[t]he ability to produce/understand some sentences is intrinsically connected to the ability to produce/understand certain others” (Fodor and Pylyshyn, 1988, p. 25) 

This ability concerns the recombination of known parts and rules: anyone who understands a number of complex expressions also understands other complex expressions that can be built up from the constituents and syntactical rules employed in the familiar expressions. To use a classic example from Szab´o (2012): someone who understands ‘brown dog’ and ‘black cat’ also understands ‘brown cat’. 

Fodor and Pylyshyn (1988) contrast systematicity with storing all sentences in an atomic way, in a dictionary-like mapping from sentences to meanings. Someone who entertains such a dictionary would not be able to understand new sentences, even if these sentences were similar to the ones occurring in their dictionary. Since humans are able to infer meanings for sentences they have never heard before, they must use some systematic process to construct these meanings from the ones they internalised before. By the same argument, however, any model that is able to generalise to 

8 

Compositionality decomposed: how do neural networks generalise? 

a sequence outside its training space (its test set), should have learned to construct outputs from parts it perceived during training and some rule of recombination. Thus, rather than asking if a model is systematic, a more interesting question is whether the rules and constituents the model uses are in line with what we believe to be the actual rules and constituents underlying a particular data set or language. 

## 3.1.1 Testing systematicity 

With our _systematicity_ test, we aim to pull out that specific aspect, by testing if a model can recombine constituents that have not been seen together during training. In particular, we focus on combinations of words _a_ and _b_ that meet the requirements that (i) the model has only been familiarised with _a_ in contexts excluding _b_ and vice versa but (ii) the combination _a b_ is plausible given the rest of the corpus. 

## **3.2 Productivity** 

A notion closely related to systematicity is _productivity_ , which concerns the open-ended nature of natural language: language appears to be infinite, but has to be stored with finite capacity. Hence, there must be some productive way to generate new sentences from this finite storage.[7] While this ‘generative’ view of language became popular with Chomsky in the early sixties (Chomsky, 1956), Chomsky himself traces it back to Von Humboldt, who stated that ‘language makes infinite use of means’. 

Both systematicity and productivity rely on the recombination of known constituents into larger compounds. However, whereas systematicity can be – to some extent – empirically established, productivity cannot, as it is not possible to prove that natural languages in fact contain an infinite number of complex expressions (Pullum and Scholz, 2010). Even if humans’ memory allowed them to produce infinitely long sentences, their finite life prevents them from doing so. Productivity of language is therefore more controversial than systematicity. 

## 3.2.1 Testing productivity 

To separate systematicity from productivity, in our productivity test we specifically focus on the aspect of unboundedness. We test whether a model can understand sentences that are _longer_ than the ones encountered during training. To test this, we separate sequences in the data based on length and evaluate models on their ability to cope with longer sequences after having been familiarised with the shorter ones. 

## **3.3 Substitutivity** 

A principle closely related to the principle of compositionality is the principle of _substitutivity_ . This principle, which finds its origin in philosophical logic, states that if an expression is altered by replacing one of its constituents with another constituent with the same meaning (a synonym), this does not affect the meaning of the expression (Pagin, 2003). In other words, if a substitution preserves the meaning of the parts of a complex expression, it also preserves the meaning of the whole. In the latter formulation, the correspondence with the principle of compositionality itself can be easily seen: as substituting part of an expression with a synonym changes neither the structure of the expression nor the meaning of its parts, it should not change the meaning of the expression itself either. 

Like the principle of compositionality, the substitutivity principle in the context of natural language is subject to interpretation and discussion. Husserl (1913) pointed out that the substitution of expressions with the same meaning can result in nonsensical sentences if the expressions belong 

> 7. The term productivity also has a technical meaning in morphology, which we do not imply here. 

9 

Hupkes, Dankers, Mul & Bruni 

to different semantic categories (the philosopher Geach (1965) illustrated this considering the two expressions _Plato was bald_ and _baldness was an attribute of Plato_ . While these expressions are synonymous, it is not possible to substitute the first with the second in the sentence _The philosopher whose most eminent pupil was Plato was bald_ ). 

A second context which poses a challenge for the substitutivity principle concerns embedded statements about beliefs. As already sketched out in the previous section, if _X_ and _Y_ are synonymous, this does not necessarily imply that the expressions _Peter thinks that X_ and _Peter thinks that Y_ are both true. In this work, we do not consider these cases, but instead focus on the more general question: is substitutivity a salient notion for neural networks and under what conditions can and do they infer synonymity? 

## 3.3.1 Testing substitutivity 

We test substitutivity by probing under which conditions a model considers two atomic units to be synonymous. To this end, we artificially introduce synonyms and consider how the prediction of a model changes when an atomic unit in an expression is replaced by its synonym. We consider two different cases. Firstly, we analyse the case in which synonymous words occur equally often and in comparable contexts. In this case, synonymity can be inferred from the corresponding meanings on the output side but is aided by distributional similarities on the input side. Secondly, we consider pairs of words in which one of the words occurs only in very short sentences, which we call _primitive contexts_ . In this case, synonymity can only be inferred from the (implicit) semantic mapping, which is identical for both words, but not from the context that those words appear in. 

## **3.4 Localism** 

In its basic form, the principle of compositionality states that the meaning of a complex expression derives from the meanings of its constituents and how they are combined. It does not impose any restrictions on what counts as an admissible way of combining different elements, which is why the principle taken in isolation is formally vacuous.[8] As a consequence, the interpretation of the principle of compositionality depends on the type of constraints that are put on the semantic and syntactic theories involved. One important consideration concerns – on an abstract level – how _local_ the composition operations should be. When operations are very local (a case also referred to as _strong_ or _first-level_ compositionality), the meaning of a complex expression depends only on its local structure and the meanings of its immediate parts (Pagin and Westerst˚ahl, 2010; Jacobson, 2002). In other words, the meaning of a compound is only dependent on the meaning of its immediate ‘children’, regardless of the way that their meaning was built up. In _global_ or _weak_ compositionality, the meaning of an expression follows from its total (global) structure and the meanings of its atomic parts. In this interpretation, compounds can have different meanings, depending on the larger expression that they are a part of. 

Carnap (1947) presents an example that nicely illustrates the difference between these two interpretations, in which he considers sentences with tautologies. Under the view that the meaning of declarative sentences is determined by the set of all worlds in which this sentence is true, any two tautologies _X_ and _Y_ are synonymous. Under the local interpretation of compositionality, this entails that also the phrases _Peter thinks that X_ and _Peter thinks that Y_ should be synonymous, which is not necessarily the case, as Peter may be aware of some tautologies but unaware of others. The global interpretation of compositionality does not give rise to such a conflict, as _X_ and _Y_ , despite being identical from a truth-conditional perspective, are not structurally identical. Under this representation, the meanings of _X_ and _Y_ are locally identical, but not globally, if also the phrase they are a part of is considered. For natural language, contextual effects, such as the disambiguation 

> 8. We previously cited Janssen (1983), who proved this claim by showing that arbitrary sets of expressions can be mapped to arbitrary sets of meanings without violating the principle of compositionality, as long as one is not bound to a fixed syntax. 

10 

Compositionality decomposed: how do neural networks generalise? 

of a phrase or word by a full utterance or even larger piece of discourse, make the localist account highly controversial. As a contrast, consider an arithmetic task, where the outcome of `14 - (2 + 3)` does not change when the subsequence `(2 + 3)` is replaced by `5` , a sequence with the same (local) meaning, but a different structure. 

## 3.4.1 Testing localism 

We test if a model’s composition operations are local or global by comparing the meanings the model assigns to stand-alone sequences to those it assigns to the same sequences when they are part of a larger compound. More specifically, we compare a model’s output when it is given a composed sequence _X_ , built up from two parts _A_ and _B_ with the output the same model gives when it is forced to first separately process _A_ and _B_ in a local fashion. If the model employs a local composition operation that is true to the underlying compositional system that generated the language, there should be no difference between these two outputs. A difference between these two outputs, instead, indicates that the model does not compute meanings by first computing the meanings of all subparts, but pursues a different, more global, strategy. 

## **3.5 Overgeneralisation** 

The previously discussed compositionality arguments are of mixed nature. Some – such as productivity and systematicity – are linked to the way that humans acquire and process language. Others – such as substitutivity and localism – are properties of the mapping from signals to meanings in a particular language. While it can be tested if a language user abides by these principles, these principles themselves do not relate directly to language users. To complete our set of tests to assess whether a model learns compositionally, we include also a notion that exclusively concerns the acquisition of the language by a model: we consider if models exhibit _overgeneralisation_ when faced with _non_ -compositional phenomena. 

Overgeneralisation (or overregularisation) is a language acquisition term, which refers to the scenario in which a language learner applies a general rule in a case that forms an exception to this rule. One of the most well-known examples, which served also as the subject of the famous _past-tense debate_ between symbolism and connectionism (Rumelhart and McClelland, 1986; Marcus et al., 1992), concerns the rule that English past-tense verbs can be formed by appending _-ed_ to the stem of the verb. During the acquisition of past-tense forms, learners infrequently use this rule also for irregular verbs, resulting in forms like _goed_ (instead of _went_ ) or _breaked_ (instead of _broke_ ). 

The relation of overgeneralisation with compositionality comes from the supposed evidence that overgeneralisation errors provide for the presence of symbolic rules in the human language system (see, e.g. Penke, 2012). In this work, we follow this line of reasoning and take the application of a rule in a case where this is contradicted by the data as evidence that the model in fact internalised this rule. As such, we regard a model’s inclination to apply rules as the expression of a compositional bias. This inclination is most easily observed in the case of exceptions, where the correct strategy is to ignore the rules and learn on a case-by-case basis. If a model overgeneralises by applying the rules also in such cases, we hypothesise that this in particular demonstrates compositional awareness. 

## 3.5.1 Testing overgeneralisation 

We propose an experimental setup where a model’s tendency to overgeneralise is evaluated by monitoring its behaviour on exceptions. We identify samples that do not adhere to the rules underlying the data distribution – _exceptions_ – in the training data sets and assess a model’s tendency to overgeneralise by observing how they respond to these exceptions during training: (when) do they consistently follow a global rule set, and (when) do they (over)fit the training samples individually? 

11 

Hupkes, Dankers, Mul & Bruni 

## **4. Data** 

As observed by many others before us, insight in the compositional skills of neural networks is not easily acquired by studying models trained on natural language directly. While it is generally agreed upon that compositional skills are required to appropriately model natural language, successfully modelling natural data requires far more than understanding compositional structures. As a consequence, a negative result may stem not from a model’s incapability to model compositionality, but rather from the lack of signal in the data that should induce compositional behaviour. A positive result, on the other hand, cannot necessarily be explained as successful compositional learning, since it is difficult to establish that a good performance cannot be reached through heuristics and memorisation. In this article, we therefore consider an artificial translation task, in which sequences that are generated by a probabilistic context free grammar (PCFG) should be translated into output sequences that represent their meanings. These output sequences are constructed by recursively applying the _string edit operations_ that are specified in the input sequence. The task, which we dub _PCFG SET_ , does not contain any non-compositional phenomena, and we can thus be certain that compositionality is in fact a salient feature. At the same time, we construct the input data such that in other dimensions – such as the lengths of the sentences and depths of the parse trees – it matches the statistical properties of a corpus with sentences from natural language (English). 

## **4.1 Input sequences: syntax** 

The input alphabet of PCFG SET contains three types of words: words for unary and binary functions that represent _string edit operations_ (e.g. `append` , `copy` , `reverse` ), elements to form the string sequences that these functions can be applied to (e.g. `A` , `B` , `A1` , `B1` ), and a separator to separate the arguments of a binary function ( `,` ). The input sequences that are formed with this alphabet are sequences describing how a series of such operations are to be applied to a string argument. For instance: 

```
repeatABC
echoremovefirstDK,EF
appendswapFGH,repeatIJ
```

We generate input sequences with a PCFG, shown in Figure 2 (production probabilities are omitted). As the grammar that we use is recursive, we can generate an infinite number of admissible input sequences. Because the operations can be nested, the parse trees of valid sequences can be arbitrarily deep and long. Additionally, the distributional properties of a particular PCFG SET data set can be controlled by adjusting the probabilities of the grammar and varying the number of input characters. We will use this to _naturalise_ the data set such that its distribution of lengths and depths correspond to the distribution observed in a data set containing English sentences. 

## **4.2 Output sequences: semantics** 

The meaning of a PCFG SET input sequence is constructed by recursively applying the string edit operations specified in the sequence. This mapping is governed by the interpretation functions listed in Figure 3. Following these interpretation functions, the three sequences listed above would be mapped to output sequences as follows: 

`repeat A B C` _→_ `A B C A B C echo remove` ~~`f`~~ `irst D K , E F` _→_ `E F F append swap F G H , repeat I J` _→_ `H G F I J I J` 

The definitions of the interpretation functions specify the systematic procedure by which an output sequence should be formed from an input sequence, without having to enumerate particular 

12 

Compositionality decomposed: how do neural networks generalise? 

|**Non-terminal rules**<br>_S_<br>_→FU S_<br>_|_<br>_FB S , S_<br>_S_<br>_→X_<br>_X_<br>_→XX_<br>**Lexical rules**<br>_FU_<br>_→_`copy` _|_ `reverse` _|_ `shift` _|_ `echo` _|_ `swap` _|_ `repeat`<br>_FB_<br>_→_`append` _|_ `prepend` _|_ `remove`<br>~~`f`~~`irst` _|_ `remove`<br>~~`s`~~`econd`<br>_X_<br>_→_`A` _|_ `B` _|_ . . . _|_ `Z` _|_ `A2` _|_ . . . _|_ `B2` _|_ . . .||
|---|---|



Figure 2: The context free grammar that describes the entire space of grammatical input sequences in PCFG SET. The rule probabilities (not depicted) can be used to control the distributional properties of a PCFG SET. We use this property to make sure that our data matches a corpus with natural English sentences in terms of length and depth distributions. 

|**Unary functions** _FU_:<br>**Binary functions** _FB_:<br>`copy` _x_1 _· · · xn_<br>_→x_1 _· · · xn_<br>`append` **x**_,_ **y**<br>_→_**x y**<br>`reverse` _x_1 _· · · xn_<br>_→xn · · · x_1<br>`prepend` **x**_,_ **y**<br>_→_**y x**<br>`shift` _x_1 _· · · xn_<br>_→x_2 _· · · xn x_1<br>`remove`<br>`first` **x**_,_ **y**<br>_→_**y**<br>`swap` _x_1 _· · · xn_<br>_→xn x_2 _· · · xn−_1 _x_1<br>`remove`<br>`second` **x**_,_ **y**<br>_→_**x**<br>`repeat` _x_1_· · · xn_<br>_→x_1 _· · · xn x_1 _· · · xn_<br>`echo` _x_1_· · · xn_<br>_→x_1 _· · · xn xn_||
|---|---|



Figure 3: The interpretation functions describing how the meaning of PCFG SET input sequences is formed. 

input-output pairs. In this sense, PCFG SET is similar to SCAN (Lake and Baroni, 2018) but differs from a task such as the lookup table task introduced by Liˇska et al. (2018), where functions must be exhaustively defined because there is no systematic connection between arguments and the values to which functions map them. 

## **4.3 Data construction** 

PCFG SET describes a general framework for producing many different data sets. We used several criteria to select the PCFG SET input-output pairs for our experiments. 

## 4.3.1 Naturalisation of structural properties 

The probabilistic nature of the PCFG SET input grammar offers a high level of control over the generated input sequences. We use this control to enforce an input distribution that resembles the statistics of a more natural data set in two relevant respects: the length of the expressions, and the depth of their parse trees. To obtain these statistics, we use the English side of a large machine translation corpus: WMT 2017 (Bojar et al., 2017). We parse this corpus with a statistical parser (Manning et al., 2014) and extract the distribution of length and depths from the annotated corpus. We then use expectation maximisation to tune the PCFG parameters in such a way that the resulting bivariate distribution of the generated data mimics the one extracted from the WMT data. For a more detailed description of the naturalisation procedure we refer to Appendix A. In Figure 4a and Figure 4b, we plot the distributions of the WMT data and a sample of around ten thousand sentences of the resulting PCFG SET data. 

13 

Hupkes, Dankers, Mul & Bruni 

**==> picture [435 x 233] intentionally omitted <==**

**----- Start of picture text -----**<br>
40 40<br>30 30<br>20 20<br>10 10<br>0 0<br>0 5 10 15 0 5 10 15<br>depth depth<br>(a) WMT17 (b) PCFG SET data<br>length length<br>**----- End of picture text -----**<br>


Figure 4: Distribution of lengths and depths in the PCFG SET (left) and English WMT 2017 test data (right). 

## 4.3.2 Sentence selection 

We set the size of the string alphabet to 520 and create a base corpus of around 100 thousand distinct input-output pairs. We limit the length of the string arguments given to the functions to 5. We use 85% of this corpus for training, 5% for validation and 10% for testing. During data generation, further care is taken to make memorisation as unattractive as possible by controlling the string sequences that feature as primitive arguments in the input expressions: we make sure that the same string arguments are never repeated. While we do not control re-occurrence of specific subsequence in general, the relatively large string alphabet makes it improbable that particular subsequences occur often enough to make memorisation a profitable learning strategy. 

## **5. Architectures** 

To showcase our compositionality test suite, we compare three currently popular neural architectures for sequence-to-sequence language processing tasks such as machine translation, speech processing and language understanding: recurrent neural networks (Sutskever et al., 2014), convolutional neural networks (Gehring et al., 2017b) and transformer networks (Vaswani et al., 2017). In this section we explain their most important features, we give a brief overview of their potential strengths and weaknesses in relation to compositionality, and we describe how we implemented them in our experiments. 

## **5.1 LSTMS2S** 

The first architecture we consider is a recurrent encoder-decoder model with attention. This setup is considered to be the most basic of the three setups we consider, but is still the basis of many MT applications (e.g. OpenNMT, Klein et al., 2017) and has also been successful in the fields of speech recognition (e.g. Chorowski et al., 2015) and question answering (e.g. He and Golub, 2016). 

14 

Compositionality decomposed: how do neural networks generalise? 

**==> picture [415 x 130] intentionally omitted <==**

**----- Start of picture text -----**<br>
Attention<br>Attention Attention<br>Conv Conv<br>Attention Attention Attention<br>RNN RNN RNN RNN<br>w 1 w 2 w 3 w 4 w 1 w 2 w 3 w 4 w 1 w 2 w 3 w 4<br>(a) LSTMS2S (b) ConvS2S (c) Transformer<br>**----- End of picture text -----**<br>


Figure 5: High-level graphical depictions of the most important features of the encoding mechanisms in LSTMS2S, ConvS2S and Transformer, as well as how these encoded representations can be attended to by the decoder. (a) LSTMS2S processes the input in a fully sequential way, iterating over the embedded elements one by one in both directions before applying an attention layer. (b) ConvS2S divides the input sequence into local fragments of consecutive items that are processed by the same convolutions, before applying attention. (c) Transformer immediately applies several global attention layers to the input, without incrementally constructing a representation of the input. 

We consider the version of this model in which both the decoder and encoder are LSTMs and refer to this setup with the abbreviation _LSTMS2S_ . 

## 5.1.1 Model basics 

LSTMS2S is a fully recurrent, bidirectional model. The encoder processes an input by iterating over all of its elements in both directions and incrementally constructing a representation for the entire sequence. Upon receiving the encoder output, the decoder performs a similar, sequential computation to unroll the predicted sequence. Here, LSTMS2S uses an attention mechanism, which allows it to focus on the parts of the encoded input that are estimated to be most important at each moment in the decoding process. 

The sequential fashion with which the LSTMS2S architecture processes each input potentially limits the model’s abilities to recombine components hierarchically. While depth – and, as shown by Blevins et al. (2018), thus hierarchy – can be created by stacking neural layers, the number of layers in popular recurrent sequence-to-sequence setups tends to be limited. The attention mechanism of the encoder-decoder setup positively influences the skills of LSTMS2S to hierarchically process inputs, as it allows the decoder to focus on input tokens out of the sequential order. 

## 5.1.2 Implementation 

We use the LSTMS2S implementation of the OpenNMT-py framework (Klein et al., 2017). We set the hidden layer size to 512, number of layers to 2 and the word embedding dimensionality to 512, matching their best setup for translation from English to German with the WMT 2017 corpus, which we used to shape the distribution of the PCFG SET data. We use mini-batches of 64 sequences and stochastic gradient descent with an initial learning rate of 0.1. 

## **5.2 ConvS2S** 

The second architecture we consider is a convolutional-based architecture. Convolutional sequenceto-sequence models have obtained competitive results in machine translation (Gehring et al., 2017a) 

15 

Hupkes, Dankers, Mul & Bruni 

and abstractive summarisation (Denil et al., 2014). In this paper, we follow the setup described by Gehring et al. (2017b) and use also their nomenclature: we refer to this model with the abbreviation _ConvS2S_ . 

## 5.2.1 Model basics 

ConvS2S uses a convolutional model to encode input sequences, instead of a recurrent one. The decoder uses a multi-step attention mechanism – every layer has a separate attention mechanism – to generate outputs from the encoded input representations. Although the convolutions already contextualise information in a sequential order, the source and target embeddings are also combined with position embeddings that explicitly encode order. As at the core of the ConvS2S model lies the local mechanism of one-dimensional convolutions, which are repeatedly and hierarchically applied, ConvS2S has a built-in bias for creating compositional representations. Its topology is also biased towards the integration of local information, which may hinder modelling long-distance relations. However, convolutional networks have been found to maintain a much longer effective history than their recurrent counterparts (Bai et al., 2018). Within ConvS2S, distant portions in the input sequence may be combined primarily through the multi-step attention, which has been shown to improve the generalisation abilities of the model compared to single-step attention (Dess`ı and Baroni, 2019). 

## 5.2.2 Model implementation 

In the ConvS2S setup that was presented by Gehring et al. (2017b) that we use in this work, word vectors are 512-dimensional. Both the encoder and decoder have 15 layers, with 512 hidden units in the first 10 layers, followed by 768 units in two layers, all using kernel width 3. The final three layers are 2048-dimensional. We train the network with the Fairseq Python toolkit[9] , using the predefined `fconv` ~~`w`~~ `mt` ~~`e`~~ `n` ~~`d`~~ `e` architecture. Unless mentioned otherwise, we use the default hyperparameters of this library. We replicate the training procedure of Gehring et al. (2017b), using Nesterov’s accelerated gradient method and an initial learning rate of 0.25. We use mini-batches of 64 sentences, with a maximum number of tokens of 3000. The gradients are normalised by the number of non-padded tokens in a batch. 

## **5.3 Transformer** 

The last architecture we consider is the recently introduced transformer model (Vaswani et al., 2017). Transformers constitute the current state of the art in machine translation and are becoming increasingly popular also in other domains, such as language modelling (e.g. Radford et al., 2019). We refer to this setup with simply the name _Transformer_ . 

## 5.3.1 Model basics 

Transformers use neither recurrent cells nor convolutions to convert an input sequence to an output sequence. Instead, they are fully based on a multitude of attention mechanisms. Both the encoder and decoder of a transformer are composed of a number of feed-forward layers, each containing two sub-layers: a multi-head attention module and a traditional feed-forward layer. In the multi-head attention layers, several attention tensors (the ‘heads’) are computed in parallel, concatenated and projected. In addition to a self-attention layer, the decoder has a layer that computes multi-head attention over the outputs of the encoder. 

Since transformers do not have any inherent notion of sequentiality, the input embeddings are combined with position embeddings, from which the model can infer _order_ . For transformers, the cost of relating symbols that are far apart is thus not higher than relating words that are close together, 

> 9. Fairseq toolkit: `https://github.com/pytorch/fairseq` 

16 

Compositionality decomposed: how do neural networks generalise? 

which – in principle – should make it easier to model long-distance dependencies. Furthermore, the relatively many stacked layers in a transformer model should facilitate modelling hierarchical structure. On the other hand, the non-sequential nature of the transformer could be a handicap as well, particularly for relating consecutive portions in the input sequence. A transformer’s receptive field is inherently global, which can be challenging in such cases. 

## 5.3.2 Implementation 

We use a transformer model with an encoder and decoder that both contain six stacked layers. The multi-head self-attention module of the model has eight heads, and the feed-forward network has a hidden size of 2048. All embedding layers and sub-layers in the network produce outputs of dimensionality 512. In addition to word embeddings, positional embeddings are used to indicate word order. We use OpenNMT-py[10] (Klein et al., 2017) to train the model according to the guidelines provided by the framework[11] : with the Adam optimiser ( _β_ 1 = 0 _._ 9 and _β_ 2 = 0 _._ 98) and a learning rate increasing for the first 8000 ‘warm-up steps’ and decreasing afterwards. 

## **6. Experiments and results** 

We now proceed to test our tests on the three previously described architectures. Below, we describe the precise experiments we conducted and report their results, going test by test. We train all models of all architectures for 25 epochs, or until convergence, and select the best-performing model based on the performance on the validation set. For every experiment, we conduct three runs per architecture and report both the average and standard deviation of their scores.[12] A summary of the results is shown in Table 1. The data and scripts to run these experiments as well as the trained models are all available online.[13] 

As described before, we did not run a grid-search to optimise the hyper-parameters of the three architectures we investigate, but instead selected reasonable hyper-parameters from papers that previously used these architectures for comparable data. It is possible that changing the hyperparameters would also change the results of the experiments. It is thus important to keep in mind that the described experiments and result serve as an illustration of the usefulness of our tests. With fixed data and a varying training seed, our tests show consistent and interesting differences and similarities between the three setups we used, but these results should not be taken as general claims about LSTMs, convolutional networks or transformers. 

## **6.1 Task accuracy** 

We first consider the correctness of the output sequences of the three different architectures on the data as described in Section 4.3. In particular, we consider their _sequence accuracy_ , where only instances for which the entire output sequence equals the target are considered correct. We use this accuracy measure to evaluate the overall task performance, and we use it later also for the systematicity, productivity, and overgeneralisation tests. In the rest of this paper, we denote accuracy scores with _[∗]_ . 

The average task performance on the PCFG SET data for the three different architectures is shown in the first row of Table 1. The Transformer outperforms both LSTMS2S and ConvS2S ( _p ≈_ 10 _[−]_[4] and _p ≈_ 10 _[−]_[3] , respectively), with a surprisingly high accuracy of 0.92. ConvS2S, in turn, is with its 0.85 accuracy significantly better than LSTMS2S ( _p ≈_ 10 _[−]_[3] ), which has an accuracy 0.79. The scores of the three architectures are robust with respect to initialisation and order of presentation 

> 10. Pytorch port of OpenNMT: `https://github.com/OpenNMT/OpenNMT-py` . 

> 11. Visit `http://opennmt.net/OpenNMT-py/FAQ.html` for the guidelines. 

> 12. Some experiments, such as the localism experiment, can be conducted directly on models trained for other tests and thus do not require training new models. 

> 13. `https://github.com/i-machine-think/am-i-compositional` 

17 

Hupkes, Dankers, Mul & Bruni 

|**Experiment**|**LSTMS2S**|**ConvS2S**|**Transformer**|
|---|---|---|---|
|Task accuracy_∗_|0.79 _±_ 0.01|0.85 _±_ 0.01|0.92 _±_ 0.01|
|Systematicity_∗_|0.53 _±_ 0.03|0.56 _±_ 0.01|0.72 _±_ 0.00|
|Productivity_∗_|0.30 _±_ 0.01|0.31 _±_ 0.02|0.50 _±_ 0.02|
|Substitutivity, _equally distributed†_|0.80 _±_ 0.00|0.95 _±_ 0.00|0.98 _±_ 0.00|
|Substitutivity, _primitive†_|0.60 _±_ 0.01|0.58 _±_ 0.01|0.90 _±_ 0.00|
|Localism_†_|0.46 _±_ 0.00|0.59 _±_ 0.01|0.54 _±_ 0.02|
|Overgeneralisation_∗_|0.68 _±_ 0.04|0.79 _±_ 0.06|0.88 _±_ 0.07|



Table 1: General task performance and performance per test for PCFG SET. The results are averaged over three runs and the standard deviation is indicated. Two performance measures are used: _sequence accuracy_ , indicated by _[∗]_ , and _consistency score_ , indicated by _†_ . 

**==> picture [426 x 124] intentionally omitted <==**

**----- Start of picture text -----**<br>
LSTMS2S ConvS2S Transformer<br>1.0<br>0.8<br>0.6<br>0.4<br>0.2<br>0.0<br>1 3 5 7 9 11 13 5 10 15 20 25 30 35 40 45 50 1 3 5 7 9 11 13 15<br>depth length functions<br>accuracy<br>**----- End of picture text -----**<br>


Figure 6: Average sequence accuracy of the three architectures as a function of several properties of the input sequences for the general PCFG SET test set: the _depth_ of the input’s parse tree, the input sequence’s _length_ and the _number of functions_ in the input sequence. The results are averaged over three runs and computed over ten thousand test samples. 

of the data, as evidenced by the low variation across runs. We now present a breakdown of this task accuracy on different types of subsets of the data. 

## 6.1.1 Impact of length, depth and number of functions 

We explore how the accuracy of the three different architectures develops with increasing difficulty of the input sequences, as measured in the input sequence’s depth (the maximum level of nestedness observed in a sequence), the input sequence’s length (number of tokens) and the number of functions in the input sequence. In Figure 6, we plot the average sequence accuracy for all three architectures as a function of those difficulty measures. Unsurprisingly, the accuracy of all architecture types decreases with the length, depth and number of functions in the input. All architectures have learned to successfully model sequences with low depths and lengths and a small number of functions (reflected by accuracies close to 1). Their performance drops for longer sequences with more functions. Overall the Transformer _>_ ConvS2S _>_ LSTMS2S trend is preserved across the data subsets. 

18 

Compositionality decomposed: how do neural networks generalise? 

**==> picture [430 x 116] intentionally omitted <==**

**----- Start of picture text -----**<br>
remove_second<br>remove_first<br>copy<br>echo<br>append<br>prepend<br>swap<br>shift<br>reverse<br>repeat<br>0.6 0.7 0.8 0.9 1.0 0.6 0.7 0.8 0.9 1.0 0.6 0.7 0.8 0.9 1.0<br>accuracy accuracy accuracy<br>(a) LSTMS2S (b) ConvS2S (c) Transformer<br>**----- End of picture text -----**<br>


Figure 7: Accuracy of the three models per PCFG SET function, as computed by applying the different functions to the same complex input sequences. 

## 6.1.2 Function difficulty 

Since the input sequences typically contain multiple functions, it is not possible to directly evaluate whether some functions are more difficult for models than others. On sequences that contain only one function, all models achieve a maximum accuracy. To compare the difficulty of the functions, we create one corpus with composed input sequences and derive for each function a separate corpus in which this function is applied to those composed input sequences. We then express the comparative difficulty of a function for a model as this model’s accuracy on the corpus corresponding to this function. For example, to compare the functions `echo` and `reverse` , we create two minimally different corpora that only differ with respect to the first input function in the sequence (e.g. `echo append swap F G H , repeat I J` and `reverse append swap F G H , repeat I J` ), and compute the model’s accuracy on both corpora.[14] We plot the results in Figure 7. 

The ranking of functions in terms of difficulty is similar for all models, suggesting that the difficulties are to a large extent stemming from the objective complexity of the functions themselves, rather than from specific biases in the models. In some cases, it is very clear why. The function `echo` requires copying the input sequence and repeating its last element – regardless of the bias of the model, this should be at least as difficult as `copy` which requires just to copy the input. Similarly, `prepend` and `append` require repeating two string arguments, whereas for `remove` ~~`f`~~ `irst` and `remove` ~~`s`~~ `econd` only one argument needs to be repeated. The latter functions should thus be easier, irrespective of the architecture. The relative difficulty of `repeat` reflects that generating longer output sequences proves challenging for all architectures. As this function requires to output the input sequence twice, its output is on average twice as long as the output of another unary function applied to an input string of the same length. 

An interesting difference between architectures occurs for the function `reverse` . For both LSTMS2S and ConvS2S this is a difficult function (although `repeat` is even harder than `reverse` for LSTMS2S). For Transformer, the accuracy for `reverse` is on par with the accuracies of `echo` , `swap` and `shift` , functions that are substantially easier than `reverse` for the other two architectures. This difference follows directly from architectural differences: while LSTMS2S and ConvS2S are forced to encode ordered local context – as they are recurrent or apply local convolutions – Transformer is not bound to such an ordering and can thus more easily deal with inverted sequences. 

## **6.2 Systematicity** 

The task success results for PCFG SET already reflect whether models can recombine functions and input strings that were not seen together during training. In the systematicity test, we focus 

> 14. Note that since inputs to unary and binary functions are different, we have to use two different corpora to compare binary and unary function difficulty. The unary and binary function scores in Figure 7 are thus not directly comparable. 

19 

Hupkes, Dankers, Mul & Bruni 

explicitly on models’ ability to interpret pairs of functions that were never seen together while training. 

## 6.2.1 Test details 

We evaluate four pairs of functions: `swap repeat` , `append remove` ~~`s`~~ `econd` , `repeat remove` ~~`s`~~ `econd` and `append swap` .[15] We redistribute the training and test data such that the training data does not contain any input sequences including these specific four pairs and all sequences in the test data contain at least one. After this redistribution, the training set contains 82 thousand input-output pairs, while the test set contains 10 thousand examples. Note that while the training data does not contain any of the function pairs listed above, it still may contain sequences that contain both functions. E.g. `reverse repeat remove` ~~`s`~~ `econd A B , C D` cannot appear in the training set, but `repeat reverse remove` ~~`s`~~ `econd A B , C D` might. 

## 6.2.2 Results 

The results of the systematicity test are reported in row 2 of Table 1. In Table 2, we show the average accuracies of the three architectures on all four held out function pairs. Following the task accuracy, also for the systematicity test, Transformer obtains higher scores than both LSTMS2S and ConvS2S ( _p ≈_ 10 _[−]_[2] and _p ≈_ 10 _[−]_[3] , respectively). The difference between the latter two, however, is for this test statistically insignificant ( _p ≈_ 10 _[−]_[1] ). The relative differences between Transformer and the other two architectures gets larger. Intriguingly, the systematicity scores of all models are substantially lower than their overall task accuracies. This large difference is surprising, since PCFG SET is constructed such that a high task accuracy requires systematic recombination. As such, these results serve as a reminder that models may find unexpected solutions, even when the data is very carefully constructed. 

One potential explanation for this score discrepancy is that, due to the slightly different distribution of examples in the systematicity data set, the models learn a different solution than before. Since the functions occurring in the held out pairs are slightly under-sampled, it could be that the models’ representations of these functions are not as good as the ones they develop when trained on the regular data set. A second explanation, to which our localism test will lend more support, is that models do treat the inputs and functions systematically, but analyse the sequences in terms of different units. Obtaining a high accuracy for PCFG SET undoubtedly requires being able to systematically recombine functions and input strings, but it does not necessarily require developing separate representations that capture the semantics of the different functions individually. 

For instance, if there is enough evidence for `repeat copy` , a model may learn to directly apply the combination of these two functions to an input string, rather than consecutively appealing to separate representations for the two functions. Thus, to compute the output of a sequence like `repeat copy swap echo X` , the model may apply two times a pair of functions, instead of four separate functions. Such a strategy would not necessarily harm performance in the overall data set, since plenty of evidence for all function pairs is present, but it would affect performance on the systematicity test, where this is not the case. While larger chunking to ease processing is not necessarily a bad strategy, we argue that it is desirable if models can also maintain a separate representation of the units that make up such chunks, which may be needed in other contexts. 

## **6.3 Productivity** 

In Figure 6, we saw that longer sequences are more difficult for all models, even if their length and depth fall within the range of lengths and depths observed in the training examples. There 

> 15. To decrease the number of dimensions of variation, we keep the specific pairs of functions fixed during evaluation: rather than varying the function pairs evaluated across runs, we vary the initialisation and order of presentation of the training examples. 

20 

Compositionality decomposed: how do neural networks generalise? 

|||**LSTMS2S**|**ConvS2S**|**Transformer**|
|---|---|---|---|---|
|`swap repeat`||0.40 _±_ 0.04|0.49 _±_ 0.02|0.53 _±_ 0.03|
|`append remove`|~~`s`~~`econd`|0.54 _±_ 0.04|0.46 _±_ 0.03|0.80 _±_ 0.02|
|`repeat remove`|~~`s`~~`econd`|0.66 _±_ 0.02|0.67 _±_ 0.01|0.80 _±_ 0.01|
|`append swap`||0.48 _±_ 0.03|0.56 _±_ 0.01|0.73 _±_ 0.01|
|_All_||0.53 _±_ 0.03|0.56 _±_ 0.01|0.72 _±_ 0.00|



Table 2: The average sequence accuracy per pair of held out compositions for the systematicity test. 

|||**Depth**|||**Length**||**#Functions**|**#Functions**|**#Functions**|
|---|---|---|---|---|---|---|---|---|---|
||_min_|_max_|_avg_|_min_|_max_|_avg_|_min_|_max_|_avg_|
|_Productivity_||||||||||
|Train|1|8|3.9|3|53|16.3|1|8|4.3|
|Test|4|17|8.2|14|71|32.9|9|35|11.5|
|_PCFG SET_||||||||||
|Train|1|17|4.4|3|71|18.4|1|35|5.2|
|Test|1|17|4.4|3|71|18.2|1|28|5.1|



Table 3: The average, minimum and maximum length, depth and number of functions for the train and test set of the productivity test. We provide the same measures for the PCFG SET test data set for comparison. 

. 

are several potential causes for this drop in accuracy. It could be that longer sequences are simply more difficult than shorter ones: they contain more functions, and there is thus more opportunity to make an error. Additionally, simply because they contain more functions, longer sequences are more likely to contain at least one of the more difficult functions (see Figure 7). Lastly, due to the naturalisation of the distribution of lengths, longer sequences are underrepresented in the training data. There is thus fewer evidence for long sequences than there is for shorter ones. As such, models may have to perform a different kind of generalisation to infer the meaning of longer sequences than they do for shorter ones. Their decrease in performance when sequences grow longer could thus also be explained by a general poor ability to generalise to lengths outside their training space, a type of generalisation sometimes referred to with the term _extrapolation_ . With our productivity test, we focus purely on this extrapolation aspect, by studying models’ ability to successfully generalise to longer sequences, which we will call the model’s _productive power_ . 

## 6.3.1 Test details 

To test for productivity, we redistribute the training and testing data such that there is no evidence at all for longer sequences in the training set. Sequences containing up to eight functions are collected in the training set, consisting of 81 thousand sequences, while input sequences containing at least nine functions are used for evaluation and collected in a test set containing 11 thousand sequences. The average, minimum and maximum length, depth and number of functions for the train and test set of the productivity test are shown in Table 3. 

## 6.3.2 Results 

The overall accuracy scores on the productivity test in Table 1 demonstrate that all models have great difficulty with extrapolating to sequences with a higher length than those seen during training. 

21 

Hupkes, Dankers, Mul & Bruni 

**==> picture [426 x 132] intentionally omitted <==**

**----- Start of picture text -----**<br>
LSTMS2S productivity ConvS2S productivity Transformer productivity<br>LSTMS2S task success ConvS2S task success Transformer task success<br>1.0<br>0.8<br>0.6<br>0.4<br>0.2<br>0.0<br>4 6 8 10 12 14 15 20 25 30 35 40 45 50 9 11 13 15<br>depth length functions<br>accuracy<br>**----- End of picture text -----**<br>


Figure 8: General task accuracy (in red) and accuracy of the three architectures on the productivity test set (in blue) as a function of several properties of the input sequences: the _depth_ of the input’s parse tree, the input sequence’s _length_ and the _number of functions_ in the input sequence. All results are averaged over three runs and computed over 11 thousand test samples. 

Transformer drops to a mean accuracy of 0.50; LSTMS2S and ConvS2S have a test accuracy of 0.30 and 0.31, respectively. Relatively speaking, removing evidence for longer sequences thus resulted in a 62% drop for LSTMS2S, a 64% drop in ConvS2S, and a 46% drop for Transformer. Both in terms of absolute and relative performance, Transformer thus has a much greater productive potential than the other models, although its absolute performance is still poor. 

Comparing just the task accuracy and productivity accuracy of models shows that models have difficulty with longer sequences but does still not give a definitive answer about the source of the performance decrease. Since the productivity test set contains on average longer sequences, we cannot see if the drop in performance is caused by poor productive power or by the inherent difficulty of longer sequences. In Figure 8, we show the performance of the three models in relation to depth, length and number of functions of the input sequences (blue lines) compared with the task accuracy of the standard PCFG SET test data for the same lengths as plotted in Figure 6. For all models, the productivity scores are lower for almost every depth, length and number of functions. This decrease in performance is solely caused by the decrease in evidence for such sequences: the total number of examples that models were trained on is roughly the same across the two conditions, and the absolute difficulty of the longer sequences is as well. With these two components factored out, we conclude that models in fact struggle to productively generalise to longer sequences.[16] 

The depth plot in Figure 6 also provides some evidence for the inherent difficulty of deeper functions: it shows that all models suffer from decreasing test accuracies for higher depths, even if these depths are well-represented in the training data. When looking at the number of functions, the productivity score of Transformer is worse than its overall task success for any considered number of functions. The scores for LSTMS2S and ConvS2S are instead very similar to the ones they reached after training on the regular data. This shows that functions with high depths are difficult for LSTMS2S and ConvS2S, even when some of them are included in the training data. 

Interestingly, considering only the development of the productivity scores (in blue), it appears that both the LSTMS2S and ConvS2S are relatively insensitive to the increasing length as measured by the number of tokens. Their performance is just as bad for input sequences with 20 or 50 

> 16. To stop their generation of the answer, models have to explicitly generate an _end of sequence_ symbol ( `<eos>` ). A reasonable hypothesis concerning the low scores on longer sequences is that they are due to models’ inability to postpone the emission of this `<eos>` symbol. Following Dubois et al. (2019), we call this problem the `<eos>` - `problem` . To test whether the low scores are due to early `<eos>` emissions, we compute how many of the wrongly emitted answers were contained in the right answer. For LSTMS2S, ConvS2S and Transformer this was the case in 22%, 6% and 8% of the wrong predictions. These numbers illustrate that the `<eos>` -problem indeed exists, but is not the main source of the poor productive capacity of the different models. 

22 

Compositionality decomposed: how do neural networks generalise? 

characters, which is on a par with the scores they obtain on the longest sequences after training on the regular data. Apparently, shorter sequences of unseen lengths are as challenging for these models as sequences of extremely long lengths. Later, in the localism experiment, we will find more evidence that this sharp difference between seen and unseen lengths is not accidental for LSTMS2S but characteristic for the representations learned by this architecture. 

## **6.4 Substitutivity** 

While the previous two experiments were centred around models’ ability to recombine known phrases and rules to create new phrases, we now focus on the extent to which models are able to draw analogies between words. In particular, we study under what conditions models treat words as _synonyms_ : we consider what happens when synonyms are _equally distributed_ in the input sequences and when one of the synonyms only occurs in _primitive contexts_ . 

## 6.4.1 Test details 

We select two binary and two unary functions ( `swap` , `repeat` , `append` and `remove` ~~`s`~~ `econd` ), for which we artificially introduce synonyms during training: `swap` ~~`s`~~ `yn` , `repeat` ~~`s`~~ `yn` , `append` ~~`s`~~ `yn` and `remove` ~~`s`~~ `econd` ~~`s`~~ `yn` . Like in the systematicity test, we keep those four functions fixed across all experiments, varying only the model initialisation and order of presentation of the training data. The introduced synonyms have the same interpretation functions as the terms they substitute, so they are semantically equivalent to their counterparts. We consider two different conditions that differ in the syntactic distribution of the synonyms in the training data. 

**Equally distributed synonyms** For the first substitutivity test we randomly replace half of the occurrences of the chosen functions _F_ with _Fsyn_ , keeping the target constant. On average, the individual functions appeared in 39% of the training samples. After synonym substitution, they appear in approximately 19% of the training samples, on average. In this test, _F_ and _Fsyn_ are distributionally similar, which should facilitate inferring that they are synonyms. 

**Primitive synonyms** In the second and more difficult substitutivity test, we introduce _Fsyn_ only in _primitive_ contexts, where _F_ is the only function call in the input sequence. _Fsyn_ is introduced in 0.1% of the training set samples. In this _primitive_ condition, the function _F_ and its synonymous counterpart _Fsyn_ are distributionally not equivalent 

**Evaluation** For the substitutivity test, we do not evaluate models’ accuracy but assess their robustness to meaning-invariant synonym substitutions in the input sequence. The most important point is not whether a model correctly predicts the target for an adapted input sequence, but whether its prediction matches the prediction it made before the transformation. We evaluate models based on this interchangeability of _F_ with _Fsyn_ . We quantify this with a _consistency score_ , which expresses a pairwise equality, where a model’s outputs on two different inputs are compared to each other, instead of to the target output. As with accuracy, also here only instances for which there is a complete match between the compared outputs are considered correct. 

The consistency metric allows us to evaluate compositionality aspects isolated from task performance. Even for models that may not have a near-perfect task performance and therefore have not mastered the rules underlying the data, we want to evaluate whether they consistently apply and generalise the knowledge they did acquire. We use the consistency score for the current substitutivity test and later for the localism tests. In the next sections, consistency scores are marked with _†_ . 

## 6.4.2 Equally distributed substitutions 

For the substitutivity experiment where words and synonyms are equally distributed, Transformer and ConvS2S perform nearly on par. They both obtain a very high consistency score (0.98 and 

23 

Hupkes, Dankers, Mul & Bruni 

|||**LSTMS2S**|**LSTMS2S**|**LSTMS2S**||**ConvS2S**|**ConvS2S**|**Transformer**|**Transformer**|**Transformer**|
|---|---|---|---|---|---|---|---|---|---|---|
|**Token**||ED|P|Other|ED|P|Other|ED|P|Other|
|`repeat`||0.46|0.41|0.96|0.10|0.41|0.84|0.08|0.39|0.79|
|`remove`|~~`s`~~`econd`|0.27|0.28|0.94|0.16|0.60|0.86|0.08|0.34|0.79|
|`swap`||0.35|0.33|0.93|0.17|0.38|0.88|0.08|0.39|0.79|
|`append`||0.34|0.29|1.00|0.12|0.54|0.82|0.07|0.37|0.75|
|_Average_||0.36|0.33|0.96|0.14|0.48|0.85|0.08|0.37|0.78|
|**Consistency**||**0.80**|**0.60**||**0.95**|**0.58**||**0.98**|**0.90**||



Table 4: The average cosine distance between the embeddings of the indicated functions and their synonymous counterparts in the equally distributed (ED) and primitive (P) setups of the substitutivity experiments. For comparison, the average distance from the indicated functions to all other regular function embeddings is given under ‘Other’. As those distances were very similar across conditions, we averaged them in one column instead of showing them separately. 

0.95, respectively). In Table 4, we see that both architectures put words and their synonyms closely together in the embedding space, truly respecting the distributional hypothesis. Surprisingly, LSTMS2S does not identify that two words are synonyms, even in this relatively simple condition where the words are distributionally identical. Words and synonyms are at very distinct positions in the embedding space, although the distance between them is smaller than the average between all words in the embedding space. We hypothesise that this low score of the LSTMS2S reflects the architecture’s inability to draw the type of analogies required to model PCFG SET data, which is also mirrored in its relatively low overall task accuracy. 

## 6.4.3 Primitive substitutions 

The primitive substitutivity test is substantially more challenging than the equally distributed one, since models are only shown examples of synonymous expressions in a small number of primitive contexts. This implies that words and their synonyms are no longer distributionally similar and that models are provided much fewer evidence for the meaning of synonyms, as there are simply fewer primitive than composed contexts. 

While the consistency scores for all models decrease substantially compared to the equally distributed setup, all models do pick up that there is a similarity between a word and its synonym. This is reflected not only in the consistency scores (0.60, 0.58 and 0.90 on average for LSTMS2S, ConvS2S and Transformer, respectively), but is also evident from the distances between words and their synonyms, which are substantially lower than the average distances to other function embeddings (Table 4). For LSTMS2S, the average distance is very comparable to the average distance observed in the equally distributed setup. Its consistency score, however, goes down substantially, indicating that word distances (computed between embeddings) give an incomplete picture of how well models can account for synonymity when there is a distributional imbalance. 

**Synonymity vs few-shot learning** The consistency score of the primitive substitutivity test reflects two skills that are partly intertwined: the ability to few-shot learn the meanings of words from very few samples and the ability to bootstrap information about a word from its synonym. As already observed in the equally distributed experiment for LSTMS2S, it is difficult to draw hard conclusions about a model’s ability to infer synonymity when it is not able to infer consistent meanings of words in general. When a model has a high score, on the other hand, it is difficult to disentangle if it achieved this high score because it has learned the correct meaning of both words separately, or because it has in fact understood that the meaning of those words is similar. That 

24 

Compositionality decomposed: how do neural networks generalise? 

||**LSTMS2S**|**ConvS2S**|**Transformer**|
|---|---|---|---|
|Consistency across all|0.60 _±_ 0.01|0.58 _±_ 0.01|0.90 _±_ 0.00|
|Consistent correct|0.53 _±_ 0.01|0.53 _±_ 0.01|0.84 _±_ 0.00|
|Consistent incorrect|0.07 _±_ 0.01|0.04 _±_ 0.00|0.05 _±_ 0.00|
|Consistency across incorrect samples|0.14 _±_ 0.01|0.09 _±_ 0.01|0.34 _±_ 0.02|



Table 5: Consistency scores for the primitive substitutivity experiment, expressing pairwise equality for the outputs of synonymous sequences. We show the overall consistency ( _consistency across all_ ), the consistency of sequences for which the model’s output was correct ( _consistent correct_ ), sequences for which the model’s output was incorrect ( _consistent incorrect_ ), and the percentage of all incorrect predictions that were consistent. A pair is considered incorrect if at least one of its parts is incorrect. NB: _consistent correct_ and _consistent incorrect_ together sum up to _consistent across all_ ; due to rounding, this is not the case in all columns of the table. 

is: the consistency score does not tell us whether output sequences are identical because the model knows they should be the _same_ , or simply because they are both _correct_ . In the equally distributed setup, the low word embedding distances for the ConvS2S and the Transformer strongly pointed to the first explanation. For the primitive setup, the two aspects are more difficult to take apart. 

**Error consistency** To separate a model’s ability to few-shot learn the meaning of a word from very few primitive examples and its ability to bootstrap information about synonyms , we compute the consistency score for model outputs that do not match the target output ( _incorrect outputs_ ). When a model makes identical but incorrect predictions for two input sequences with a synonym substitution, this cannot be because the model merely correctly learned the meanings of the two words. It can thus be taken as evidence that it treats the word and its synonyms indeed as synonyms. 

In Table 5, we show the consistency scores for all output pairs (identical to the scores in Table 1), the breakdown of this score into correct ( _consistent correct_ ) and incorrect ( _consistent incorrect_ ) output pairs, and the ratio of incorrect output pairs that is consistent. The scores in row two and three show that the larger part of the consistency scores for all models is due to correct outputs. In row 4, we see that models are seldom consistent on _incorrect_ outputs. The Transformer maintains its first place , but none of the architectures can be said to treat a word and its synonymous counterpart as true synonyms. An interesting difference occurs between LSTMS2S and ConvS2S, whose consistency scores on all outputs are similar, but differ in consistency of erroneous outputs. These scores suggest that ConvS2S is better at few-shot learning than LSTMS2S, but LSTMS2S is better at inferring synonymity. These results are in line with the embedding distances shown for the primitive substitutivity experiment in Table 4, which are on average also lower for LSTMS2S than for ConvS2S. 

## **6.5 Localism** 

In the localism test, we investigate whether models compute the meanings of input sequences using local composition operations, following the hierarchical trees that specify their compositional structure. 

## 6.5.1 Test details 

We test for localism by considering models’ behaviour when a subsequence in an input sequence is replaced with its meaning (see Figure 9 for an example). Thanks to the recursive nature of the PCFG SET expressions and interpretation functions, this is a relatively straightforward substitution in our data. If a model uses local composition operations to build up the meanings of input sequences, 

25 

Hupkes, Dankers, Mul & Bruni 

**==> picture [362 x 114] intentionally omitted <==**

**----- Start of picture text -----**<br>
C A B B<br>Model<br>echo C A B<br>Model<br>echo append C A B<br>echo append C prepend B A Model<br>**----- End of picture text -----**<br>


Figure 9: An example of the unrolled computation of the meaning of the sequence `echo append C , prepend B , A` for the localism test. We unroll the computation of the meaning of the sequence by first asking the model to compute the meaning _o_ 1 of the smallest constituent `prepend B , A` and then replace the constituent by this predicted meaning _o_ 1. In the next step, we use the model to compute the meaning of the then smallest constituent `echo` _o_ 1, and replace the constituent in the sequence with the model’s prediction for this constituent. This process is repeated until the meaning of the entire sequence is computed, in steps, by the model. This final prediction ( `C A B B` in the picture) is then compared with the model’s prediction on the entire sequence (not shown in the picture). If a model follows a local compositional protocol to predict the meaning of an output sequence, these two outputs should be the same. 

following the hierarchy that it is dictated by the underlying system, its output meaning should not change as a consequence of such a substitution. 

**Unrolling computations** We compare the output sequence that is generated by a model for a particular input sequence with the output sequence that the same model generates when we explicitly unroll the processing of the input sequence. That is, instead of presenting the entire input sequence to the model at once, we force the model to evaluate the outcome of smaller constituents before computing the outcome of bigger ones, in the following way: we iterate through the syntactic tree of the input sequence and use the model to compute the meanings of the smallest constituents. We then replace these constituents by the model’s output and use the model to again compute the meanings of the smallest constituents in this new tree. This process is continued until the meaning for the entire sequence is found. A concrete example is visualised in Figure 9. 

We conduct the localism test on sentences from the PCFG SET test set. On average, unrolling the computation of these sequences involves five steps. 

**Evaluation** We evaluate a model by comparing the final output of the enforced recursive method to the output emitted when the sequence is presented in its original form. Again, during evaluation we focus on checking whether the two outputs are identical, rather than if they are correct. If a model wrongfully emits `B A` for input sequence `prepend B , A` , this is not penalised in this experiment, provided that the regular input sequence yields the same prediction as its hierarchical variant. This method of evaluation matches the previously mentioned _consistency score_ that was also used in the previous section for the substitutivity test. 

## 6.5.2 Results 

None of the evaluated architectures obtains a high consistency score for this experiment (0.46, 0.59 and 0.54 for LSTMS2S, ConvS2S and Transformer, respectively). Also in this test, Transformer ranks high, but the best-performing architecture is ConvS2S (significant in comparison with both LSTMS2S and Transformer with _p ≈_ 10 _[−]_[4] and _p ≈_ 10 _[−]_[2] , respectively). Since the ConvS2S models are explicitly using local operations, this is in line with our expectations. 

26 

Compositionality decomposed: how do neural networks generalise? 

**Input string length** To understand the main cause of the relatively low scores on this experiment, we manually analyse 300 samples (100 per model type), in which at least one mistake was made during the unrolled processing of the sample. We observe that the most common mistakes involve unrolled samples that contain function applications to string inputs with more than five characters. An example of such a mistake would be a model that is able to compute the meaning of `reverse echo A B C D E` but not the meaning of `reverse A B C D E E` . As the outputs for these two phrases are identical, it is clear that this inadequacy does not stem from models’ inability to generate the correct output string. Instead, it indicates that the model does not compute the meaning of `reverse echo A B C D E` by consecutively applying the functions `echo` and `reverse` . We hypothesise that, rather, models generate representations for _combinations_ of functions that are then applied to the input string at once. 

**Function representations** While developing ‘shortcuts’ to apply combinations of functions all at once instead of explicitly unfolding the computation does not necessarily contradict compositional understanding – imagine, for instance, computing the outcome of the sum `5 + 3 - 3` – the results of the localism experiment do point to an interesting aspect of the learned representations. Since unrolling computations mostly leads to mistakes when the character length of unrolled inputs is longer than the maximum character string length of five seen during training, it casts some doubt on whether the models have developed consistent function representations. 

If a model truly understands the meaning of a particular function in PCFG SET, it should in principle be able to apply this function to an input string of arbitrary length. Note that, in our case, this ability does not require productivity in generating output strings, since the correct output sequences are not distributionally different from those in the training data (in some cases, they may even be exactly the same). Contrary to in other setups, a failure to apply functions to longer sequence lengths can thus not be explained by distributional or memory arguments. Therefore, the consistent failure of all models to apply functions to character strings that are longer than the ones seen in training suggests that, while models may have learned to adequately copy strings of length two to five, they do not necessarily consider those operations the same. 

To check this hypothesis, we test all functions in a primitive setup where we vary the length of the string arguments they are applied to.[17] For a model that develops several length-specific representations for the same function, we expect the performance to go down abruptly when the input string length exceeds the maximum length seen during training. If a model instead develops a more general representation, it should be able to apply learned functions also to longer input strings. Its performance on longer strings may drop for other, practical, reasons, but this drop should be more smooth than for a model that has not learned a general-purpose representation at all. 

**==> picture [426 x 111] intentionally omitted <==**

**----- Start of picture text -----**<br>
1.0<br>0.8<br>0.6<br>0.4<br>0.2 reverse<br>0.0<br>2 3 4 5 6 7 8 9 10 11 12 13 14 15 2 3 4 5 6 7 8 9 10 11 12 13 14 15 2 3 4 5 6 7 8 9 10 11 12 13 14 15<br>number of characters number of characters number of characters<br>(a) LSTMS2S (b) ConvS2S (c) Transformer<br>accuracy<br>**----- End of picture text -----**<br>


Figure 10: Accuracy of the three architectures on different functions with increasingly long character string inputs. The maximum character string length observed during training is 5. While Transformer and ConvS2S can, for most functions, generalise a little beyond this string length, LSTMS2S models cannot. 

> 17. For binary functions, only one of the two string arguments exceeds the regular argument lengths. 

27 

Hupkes, Dankers, Mul & Bruni 

The results of this experiment, plotted in Figure 10, demonstrate that all models have learned to apply all functions to input strings up until length five, as evidenced by their near-perfect accuracy on the samples of these lengths. On longer lengths, however, none of the models performs well. For all runs, the performance of LSTMS2S immediately drops to zero when string arguments exceed length five, the maximum string length seen during training. The model does not seem to be able to leverage a general concept of any of the functions. ConvS2S and Transformer do exhibit some generalisation beyond the maximum string input length seen during training, indicating that their representations are more general. The accuracy of Transformer reaches zero only for input arguments of more than nine characters, ConvS2S outputs some correct responses even for input arguments of 12 or 13 characters. This suggests that the descending scores may be due to factors of ‘performance’ rather than ‘competence’. The accuracies for Transformer and ConvS2S are comparable for almost all functions, except `reverse` , for which the ConvS2S accuracy drops to almost zero for length six in all three runs. Interestingly, none of the three architectures suffers from increasing the character length of the first and second argument to `remove first` and `remove second` , respectively (not plotted). 

## **6.6 Overgeneralisation** 

In our last test, we focus on the learning process, rather than on the final solution that is implemented by converged models. In particular, we study if – during training – a model _overgeneralises_ when it is presented with an exception to a rule and – in case it does – how much evidence it needs to see to memorise the exception. Whether a model overgeneralises indicates its willingness to prefer rules over memorisation, but while strong overgeneralisation characterises compositionality, more overgeneralisation is not necessarily better. An optimal model, after all, should be able to deal with exceptions as well as with the compositional part of the data. 

## 6.6.1 Test details 

As the language defined through the PCFG is designed to be strictly compositional, it does not contain exceptions. We therefore manually add them to the data set, which allows us to have a large control over their occurrence and frequency. 

**Exceptions** We select four pairs of functions that are assigned a new meaning when they appear together in an input sequence: `reverse echo` , `prepend remove first` , `echo remove` ~~`f`~~ `irst` and `prepend reverse` . Whenever these functions occur together in the training data, we remap the meaning of those functions, as if an alternative set of interpretation functions is used in these few cases. As a consequence, the model has no evidence for the _compositional_ interpretation of these function pairs, unless it overgeneralises by applying the rule observed in the rest of the training data. For example, the meaning of `echo remove first A , B C` would normally be `B C C` , but has now become `A B C` . The remapped definitions, which we call _exceptions_ , can be found in Table 6. 

**Exception frequency** In our main experiment, the number of exceptions in the data set is 0.1% of the number of occurrences of the least occurring function of the function pair _F_ 1 _F_ 2. We present also the results of a grid-search in which we consider exception percentages of 0.01%, 0.05%, 0.1% and 0.5%. 

## 6.6.2 Results 

We monitor the accuracy of both the original and the exception targets during training and compare how often a model correctly memorises the exception target and how often it overgeneralises to the compositional meaning, despite the evidence in the data. To summarise a model’s tendency to overgeneralise, we take the highest overgeneralisation accuracy that is encountered during training. For more qualitative analysis, we visualise the development of both memorisation and overgeneralisation 

28 

Compositionality decomposed: how do neural networks generalise? 

|**Input**||**Remapped to**||**Target**|**Target**|
|---|---|---|---|---|---|
||||_Original_||_Exception_|
|`reverse echo A `|`B C`|`echo copy A B C`|`C C B `|`A`|`A B C C`|
|`prepend remove`|~~`f`~~`irst A , B , C`|`remove`<br>~~`s`~~`econd append A , B , C`|`C B`||`A B`|
|`echo remove`<br>~~`f`~~`irst A , B C`||`copy append A , B C`|`B C C`||`A B C`|
|`prepend reverse A B , C`||`remove`<br>~~`s`~~`econd echo A B , C`|`C B A`||`A B B`|



Table 6: Examples for the overgeneralisation test. The input sequences in the data set (first column, _Input_ ) are usually presented with their ordinary targets ( _Original_ ). In the overgeneralisation test, these input sequences are interpreted according to an alternative rule set ( _Remapped to_ ), effectively changing the corresponding targets ( _Exception_ ). 

during training, resulting in _overgeneralisation profiles_ . During training, we monitor the number of exception samples for which a model does not generate the correct meaning, but instead outputs the meaning that is in line with the rule instantiated in the rest of the data. At every point in training, we define the strength of the overgeneralisation as the percentage of exceptions for which a model exhibits this behaviour. 

**Overgeneralisation peak** We call the point in training where the overgeneralisation is highest the _overgeneralisation peak_ . In Table 1, we show the average height of this overgeneralisation peak for all three architectures, using an exception percentage of 0.1%. This quantity equals the accuracy of the model predictions on the input sequences whose outputs have been replaced by exceptions, but measured on the original targets that follow from the interpretation functions of PCFG SET. The numbers in Table 1 illustrate that all models show a rather high degree of overgeneralisation. At some point during the learning process, Transformer applies the rule to 88% of the exceptions and LSTMS2S and ConvS2S to 68% and 79% respectively. 

**Overgeneralisation profile** More interesting than the height of the peak is the _profile_ that different architectures show during learning. In Figure 11, we plot this profile for four different exception percentages. The lower areas (in red), indicate the overgeneralisation strength, whereas the memorisation strength – the accuracy of a model on the adapted outputs, which can only be learned by memorisation – is indicated in the upper part of the plots, in blue. The grey area in between indicates the percentage of exception examples for which a model outputs neither the correct answer nor the rule-based answer. 

**Exception percentage** The profiles show that, for all architectures, the degree of overgeneralisation strongly depends on the number of exceptions present in the data. All architectures show overgeneralisation behaviour for exception percentages lower than 0.5% (first three rows), but hardly any overgeneralisation is observed when 0.5% of a function’s occurrence is an exception (bottom row). When the percentage of exceptions becomes too low, on the other hand, all models have difficulties memorising them at all: when the exception percentage is 0.01% of the overall function occurrence, only ConvS2S can memorise the correct answers to some extent (middle column, top row). LSTMS2S and Transformer keep predicting the rule-based output for the sequences containing exceptions, even after the training converged. 

**Learning an exception** LSTMS2S, in general, appears to find it difficult to accommodate both rules and exceptions at the same time. Transformer and ConvS2S overgeneralise at the beginning of training, but then, once enough evidence for the exception is accumulated, gradually change to predicting the correct output for the exception sequences. This behaviour is most strongly present for ConvS2S, as evidenced by the thinness of the grey stripe separating the red and the blue area during training. For LSTMS2S, on the other hand, the decreasing overgeneralisation strength is not 

29 

Hupkes, Dankers, Mul & Bruni 

**==> picture [426 x 280] intentionally omitted <==**

**----- Start of picture text -----**<br>
% LSTMS2S ConvS2S Transformer<br>1.00<br>memorisation<br>0.75<br>0.01 0.50<br>0.25<br>overgeneralisation overgeneralisation overgeneralisation<br>0.00<br>1.00<br>memorisation memorisation<br>0.75<br>0.05 0.50<br>0.25<br>overgeneralisation overgeneralisation overgeneralisation<br>0.00<br>1.00<br>memorisation memorisation<br>0.75<br>0.1 0.50<br>0.25<br>overgeneralisation overgeneralisation overgeneralisation<br>0.00<br>1.00<br>memorisation memorisation memorisation<br>0.75<br>0.50<br>0.5<br>0.25<br>0.00<br>0 5 10 15 20 25 0 5 10 15 20 25 0 5 10 15 20 25<br>epoch epoch epoch<br>accuracy<br>accuracy<br>accuracy<br>accuracy<br>**----- End of picture text -----**<br>


Figure 11: Overgeneralisation profiles over time for LSTMS2S, ConvS2S and Transformer for exception percentages of 0.01%, 0.05%, 0.1% and 0.5% (in increasing order, from top to bottom). The lower area of the plots, in red, indicates the mean fraction of exceptions (with standard deviation) for which an overgeneralised output sequence is predicted (i.e. not the ‘correct’ exception output for the sequence, but the output that one would construct following the meaning of the functions as observed in the rest of the data). We denote this area with ‘overgeneralisation’. The upper areas, in blue, indicate the mean fraction of the exception sequences (with standard deviation) for which the model generates the true output sequence, which – as it falls outside of the underlying compositional system – has to be memorised. We call this the ‘memorisation’ area. The grey area in between corresponds to the cases in which a model does not predict the correct output, nor the output that would be expected if the rule were applied. 

matched by an increasing memorisation strength. After identifying that a certain sequence is not following the same rule as the rest of the corpus, LSTMS2S does not predict the correct meaning but instead starts generating outputs that match neither the correct exception output nor the original target for the sequence. After convergence, its accuracy on the exception sequences is substantially lower than the overall corpus accuracy. As the bottom plot (with an exception percentage of 0.5%) indicates that LSTMS2S models do not have problems with learning exceptions per se, they appear to struggle with hosting exceptions for words if little evidence for such anomalous behaviour is present in the training data. 

## **7. Discussion** 

With the rising successes of models based on deep learning, evaluating the compositional skills of neural network models has attracted the attention of many researchers. Many empirical studies have been presented that evaluate the compositionality of neural models in different ways, but they have 

30 

Compositionality decomposed: how do neural networks generalise? 

not led to a consensus about whether neural models can in fact adequately model compositional data. We argue that this lack of consensus stems from a deeper issue than the results of the proposed tests: while many researchers have a strong intuition about what it means for a model to be compositional, there is no explicit agreement on what defines compositionality of a model or how it should be tested for in a neural model. 

## **7.1 An evaluation framework to evaluate compositionality** 

In this paper, we proposed an evaluation framework that addresses this problem, with a series of tests that translate theoretical concepts related to compositionality of language into behavioural tests for models of language. Our evaluation framework contains five independent tests that consider complementary aspects of compositionality that are frequently mentioned in the literature about compositionality. These five tests allow us to investigate (i) if models systematically recombine known parts and rules ( _systematicity_ ) (ii) if models can extend their predictions beyond the length they have seen in the training data ( _productivity_ ) (iii) if models’ predictions are robust to synonym substitutions ( _substitutivity_ ) (iv) if models’ composition operations are local or global ( _localism_ ) and (v) if models favour rules or exceptions during training ( _overgeneralisation_ ). We formulated these tests on a task-independent level, disentangled from a specific downstream task. With this, we offer a versatile evaluation paradigm which can be used to evaluate the compositional abilities of a model on five different levels, that can be instantiated for any chosen sequence-to-sequence task. Importantly, our collection of tests should not be taken as a normative specification of what models should and should not do. Rather, they are meant to discover which aspects of compositionality a model does or does not implement and learn more about a model’s strengths and weaknesses. 

To showcase our evaluation paradigm, we instantiated the five tests on a highly compositional artificial data set we dub PCFG SET: a sequence-to-sequence translation task which requires to compute meanings of sequences that are generated by a probabilistic context-free grammar by recursively applying string edit operations. This data set is designed such that modelling it adequately should require a compositional solution, and it is generated such that its length and depth distributions match those of a natural corpus of English. We then used these instantiated tests to compare three popular sequence-to-sequence architectures: an LSTM-based ( _LSTMS2S_ ), a convolution-based ( _ConvS2S_ ) and an all-attention model ( _Transformer_ ). For each test, we conducted a number of auxiliary tests that can be used to further increase the understanding of how this aspect is treated by a particular architecture. Below, we provide a summary of the results of these experiments.[18] 

## **7.2 Summary of results** 

While the overall accuracy on PCFG SET was relatively high for all models, a more detailed picture is given by the five compositionality tests. These tests indicated that, despite our careful data design, high scores do still not necessarily imply that the trained models fully represent the true underlying generative system and illustrated how different models handle different aspects that could be considered important for compositional learning. 

Firstly, our **systematicity** test showed that none of the architectures successfully generalises to pairs of words that were not observed together during training, a result that confirms earlier studies such as the ones from Loula et al. (2018) and Lake and Baroni (2018). The difference between the systematicity scores and the overall task accuracy is quite stark for all models: a drop of 33%, 34% and 22% for LSTMS2S, ConvS2S and Transformer, respectively. This suggests that the low 

> 18. At the risk of being redundant, we repeat that these results should not be taken as general claims about LSTMs, convolutional networks or transformers. Neural models can be sensitive to small changes in hyper-parameters and learning regimes and we did not investigate the effect of changing the hyper-parameters. Perhaps using a deeper LSTM, a transformer with more attention heads, or convolutions with a wider kernel width would show different patterns. We leave these questions open for future work. With the results below, we merely want to show that – keeping the tests fixed – interesting differences but also similarities between different models can be found. 

31 

Hupkes, Dankers, Mul & Bruni 

accuracy on the systematicity test does not stem from poor systematic capacity in general, but that rather from the fact that the models use different segmentations of the input, applying – for instance – multiple functions at once, instead of all of the functions in a sequential manner. While larger chunking to ease processing is not necessarily a bad strategy, it is desirable if models can also maintain a separate representation of the units that make up such chunks, as these units could be useful or needed in other sequences. 

With our **productivity** test, we assessed if models can productively generalise to sequences that are longer than the ones they observed in training. To evaluate this, we redistributed the training examples such that there is a strict separation of the input sequence lengths in the train and test data. To tease apart the overall difficulty of modelling longer sequences from the ability to generalise to unseen lengths, we compared the results with the accuracies of models that are trained on data sets that contain at least some evidence for longer sequences. None of the architectures exhibited strong productive power to sequences of unseen lengths. By computing how often models’ predictions were strictly contained within the true output sequence, we assess if the poor productive power of all models is caused by early emission of the end-of-sequence symbol. We find that such cases indeed exist, but that early stopping of the generation is not the main cause of the low productivity scores. 

With our **substitutivity** test, we compared how models react to artificially introduced synonyms occurring in different types of scenarios. Rather than considering their behaviour in terms of sequence accuracy, in this test, we computed how _consistent_ models’ predictions are – correct or incorrect – when a word is substituted with a synonym. When synonyms are equally distributed in the input data, both Transformer and ConvS2S obtain high consistency scores, while LSTMS2S is substantially less consistent. This difference is also reflected in the distance between the embeddings of words and synonyms, which is much lower for Transformer and ConvS2S. When one of the synonyms is only presented in a few very short sequences, the consistency score of ConvS2S drops to the same level as LSTMS2S, while Transformer still maintains a relatively high synonym consistency. Also the embeddings of synonyms remain relatively close in Transformer models’ embedding space, despite the fact that they are distributionally dissimilar. 

To tease apart the ability to learn from very few examples and to infer synonymity, we also considered how consistent models are on _incorrect_ outputs. Here, we observed that none of the models can be said to truly treat words and their counterparts as synonyms. Transformer is the most consistent, but with a low score of only 0.34. This test shows an interesting difference between LSTMS2S and ConvS2S: where the former appears to be better at inferring that words are synonyms, the latter is better at few-shot learning a word’s meaning from very few examples. 

With our **localism** test, we considered if models apply local composition operations that are true to the syntactic tree of an input sequence, or rather compute the meaning of a sequence in a more global fashion. In line with the results of the systematicity test, models do not appear to truly follow the syntactic tree of the input to compute its meaning. In 54%, 41% and 46% of the test samples for LSTMS2S, ConvS2S and Transformer, respectively, enforcing a local computation results in a different answer than the original answer provided by the model. An error analysis suggests that these results are largely due to function applications to longer string sequences. With an additional test in which we monitored the accuracy of models on functions applied to increasingly long string inputs, we find evidence that models may not learn general-purpose representations of functions, but instead use different protocols for _copy once_ or _copy twice_ . We saw that the accuracy of LSTMS2S immediately drops to 0 when string inputs are longer than the ones observed in training. The performance of ConvS2S and Transformer, instead, drops rapidly, but remains above 0 for slightly longer string inputs. These results indicate that LSTMS2S may indeed not have learned a generalpurpose representation for functions, while the decreasing accuracy of ConvS2S and Transformer could be related more to performance rather than competence issues. 

In our last test, we studied **overgeneralisation** during training, by monitoring the behaviour of models on artificially introduced _exceptions_ to rules for four function pairs. We found that for small amounts of exceptions (up to 0.1% of the number of occurrences of the least occurring 

32 

Compositionality decomposed: how do neural networks generalise? 

function of a function pair) all architectures overgeneralise at the beginning of their training. As overgeneralisation implies that models overextend rules in cases where this is explicitly contradicted by the data, we take this as a clear indication that models in fact capture the underlying rule at that point. For very small amounts of exceptions (0.01%), both Transformer and LSTMS2S failed to learn the exception at all: even after their training has converged they overgeneralise on the sequences containing exceptions. To a lesser extent, also ConvS2S struggles with capturing exceptions that have a low frequency. LSTMS2S generally appears to have difficulty with accommodating both rules and exceptions. Often, after learning that a certain rule should not be applied, LSTMS2S models do not memorise the true target but proceed to predict something which matches neither this target nor the general rule. ConvS2S and Transformer do not show such patterns: when their _overgeneralisation_ score goes down, their _memorisation_ score goes up. Aside from at the beginning of their training, they rarely predict something outside of these options. For larger percentages of exceptions (from 0.5%), none of the architectures really exhibits overgeneralisation behaviour. 

## **7.3 Conclusion and future work** 

With a proposed collection of tests, we aimed to cover several facets of compositionality. We believe that as such, this collection of tests can serve as an evaluation paradigm to probe the ability of different neural network architectures in the light of compositionality. We hope that the tests and their results can help facilitate a general discussion of what it means for neural models to be compositional and what we would like them to represent. There are, of course, also aspects of compositionality that we did not cover. We therefore do not consider our evaluation an endpoint, but rather a stepping stone on the way, which we hope can provide the grounds for a clearer discussion concerning the role and importance of compositionality in neural networks, including both aspects that we did and did not include. 

We instantiated our tests on an artificial data set that is entirely explainable in terms of compositional phenomena. This permitted us to focus on the compositional ability of different models in the face of compositional data and allowed us to isolate compositional processing from other signals that are found in more realistic data sets. However, it leaves open the question of how much the compositional traits we identified are expressed and can be exploited by networks when facing natural data. Despite the fact that they are not informed by knowledge of language or semantic composition, neural networks have achieved tremendous successes in almost all natural language processing tasks. While their performance is still far from perfect, it is not evident that their remaining failures stem from their inability to deal with compositionality. In the future, we plan to instantiate our tests also in natural language domains such as translation and summarisation. The results of such a study would provide valuable information about how well models pick up compositional patterns in more noisy environments, but – perhaps even more importantly – could also provide insights about the importance of these different aspects of compositionality to model natural data. 

In summary, we provided an evaluation paradigm that allows a researcher to test the extent to which five distinct, theoretically motivated aspects of compositionality are represented by artificial neural networks. By instantiating these tests for an artificial data set and applying the resulting tests on three different successful sequence-to-sequence architectures, we shed some light on which aspects of compositionality may prove problematic for different architectures. These results illustrate well that to test for compositionality in neural networks it does not suffice to consider an accuracy score on a single downstream task, even if this task is designed to be highly compositional. Models may capture some compositional aspects of this data set very well, but fail to model other aspects that could be considered part of a compositional behaviour. As such, the results themselves demonstrate the need for the more extensive set of evaluation criteria that we aim to provide with this work. We hope that future researchers will use our collection of tests to evaluate new models, to investigate the impact of hyper-parameters or to study how compositional behaviour is acquired during training. To facilitate the usage of our test suite we have made the PCFG SET data generator, all test sets 

33 

Hupkes, Dankers, Mul & Bruni 

and the models trained by us available online.[19] We further hope that our theoretical motivation, the tests themselves and the analysis that we presented of its application on three different sequenceto-sequence architectures will prove to be a step in the direction of having a clearer discussion about compositionality in the context of deep learning, both from a practical and a theoretical perspective. 

## **Acknowledgments** 

We thank Marco Baroni, Yoav Goldberg, Aureli Herbelot, Louise McNally, Ryan Nefdt, Sandro Pezzelle, Shane Steinert-Threlkeld and Willem Zuidema for taking the time to proofread earlier versions of this paper and giving us feedback. Furthermore, we thank our anonymous reviewers and editor Stephen Clark for their interesting comments and helpful suggestions. 

Dieuwke Hupkes is funded by the Netherlands Organization for Scientific Research (NWO), through a Gravitation Grant 024.001.006 to the Language in Interaction Consortium. Elia Bruni is funded by the European Union’s Horizon 2020 research and innovation program under the Marie Sklodowska-Curie grant agreement No 790369 (MAGIC). 

## **References** 

- Andreas, J. (2019). Measuring compositionality in representation learning. In _Proceedings of the 7th International Conference on Learning Representations (ICLR)_ . 

- Bahdanau, D., Cho, K., and Bengio, Y. (2015). Neural machine translation by jointly learning to align and translate. In _Proceedings of the 3rd International Conference on Learning Representations (ICLR)_ . 

- Bahdanau, D., Murty, S., Noukhovitch, M., Nguyen, T. H., de Vries, H., and Courville, A. (2018). Systematic generalization: What is required and can it be learned? In _Proceedings of the 6th International Conference on Learning Representations (ICLR)_ . 

- Bai, S., Kolter, J. Z., and Koltun, V. (2018). An empirical evaluation of generic convolutional and recurrent networks for sequence modeling. _CoRR_ , abs/1803.0127. 

- Baroni, M. and Zamparelli, R. (2010). Nouns are vectors, adjectives are matrices: representing adjective-noun constructions in semantic space. In _Proceedings of the 2010 Conference on Empirical Methods in Natural Language Processing (EMNLP)_ , pages 1183–1193. 

- Batali, J. (1994). Artificial evolution of syntactic aptitude. In _Proceedings of the 16th Annual Conference of the Cognitive Science Society (CogSci)_ , pages 27–32. 

- Belinkov, Y., M`arquez, L., Sajjad, H., Durrani, N., Dalvi, F., and Glass, J. (2017). Evaluating layers of representation in neural machine translation on part-of-speech and semantic tagging tasks. In _Proceedings of the 8th International Joint Conference on Natural Language Processing (IJCNLP)_ , volume 1, pages 1–10. 

- Blevins, T., Levy, O., and Zettlemoyer, L. (2018). Deep RNNs encode soft hierarchical syntax. In _Proceedings of the 56th Annual Meeting of the Association for Computational Linguistics (ACL)_ , volume 2, pages 14–19. 

- Bojar, O., Buck, C., Chatterjee, R., Federmann, C., Graham, Y., Haddow, B., Huck, M., JimenoYepes, A., Koehn, P., and Kreutzer, J., editors (2017). _Proceedings of the Second Conference on Machine Translation (WMT)_ . 

> 19. `https://github.com/i-machine-think/am-i-compositional` 

34 

Compositionality decomposed: how do neural networks generalise? 

- Boleda, G. and Herbelot, A. (2016). Formal distributional semantics: introduction to the special issue. _Computational Linguistics_ , 42(4):619–635. 

- Bowman, S. R., Manning, C. D., and Potts, C. (2015). Tree-structured composition in neural networks without tree-structured architectures. In _Proceedings of the 2015th International Conference on Cognitive Computation: Integrating Neural and Symbolic Approaches_ , pages 37–42. 

- Carnap, R. (1947). _Meaning and necessity: A study in semantics and modal logic_ . University of Chicago Press. 

- Chomsky, N. (1956). Three models for the description of language. _IRE Transactions on information theory_ , 2(3):113–124. 

- Chorowski, J. K., Bahdanau, D., Serdyuk, D., Cho, K., and Bengio, Y. (2015). Attention-based models for speech recognition. In _Advances in Neural Information Processing Systems (NIPS)_ , pages 577–585. 

- Christiansen, M. H. and Chater, N. (1999). Toward a connectionist model of recursion in human linguistic performance. _Cognitive Science_ , 23(2):157–205. 

- Chung, J., Gulcehre, C., Cho, K., and Bengio, Y. (2014). Empirical evaluation of gated recurrent neural networks on sequence modeling. _CoRR_ , abs/1412.3555. 

- Clark, S. (2015). Vector space models of lexical meaning. _The Handbook of Contemporary semantic theory_ , pages 493–522. 

- Coecke, B., Sadrzadeh, M., and Clark, S. (2010). Mathematical foundations for a compositional distributional model of meaning. _Linguistic analysis_ , 36(1-4):345–384. 

- Denil, M., Demiraj, A., Kalchbrenner, N., Blunsom, P., and de Freitas, N. (2014). Modelling, visualising and summarising documents with a single convolutional neural network. _CoRR_ , abs/1406.3830. 

- Dess`ı, R. and Baroni, M. (2019). CNNs found to jump around more skillfully than RNNs: Compositional generalization in seq2seq convolutional networks. In _Proceedings of the 57th Annual Meeting of the Association for Computational Linguistics (ACL)_ , pages 3919–3923. 

- Dubois, Y., Dagan, G., Hupkes, D., and Bruni, E. (2019). Location attention for extrapolation to longer sequences. _CoRR_ , abs/1911.03872. 

- Elman, J. L. (1991). Distributed representations, simple recurrent networks, and grammatical structure. _Machine learning_ , 7(2-3):195–225. 

- Erk, K. (2012). Vector space models of word meaning and phrase meaning: A survey. _Language and Linguistics Compass_ , 6(10):635–653. 

- Fodor, J. A. and Pylyshyn, Z. W. (1988). Connectionism and cognitive architecture: a critical analysis. _Cognition_ , 28(1-2):3–71. 

- Gehring, J., Auli, M., Grangier, D., and Dauphin, Y. N. (2017a). A convolutional encoder model for neural machine translation. In _Proceedings of the 55th Annual Meeting of the Association for Computational Linguistics (ACL)_ , volume 1, pages 123–135. 

- Gehring, J., Auli, M., Grangier, D., Yarats, D., and Dauphin, Y. N. (2017b). Convolutional sequence to sequence learning. In _Proceedings of the 34th International Conference on Machine Learning (ICML)_ , pages 1243–1252. 

35 

Hupkes, Dankers, Mul & Bruni 

- Giulianelli, M., Harding, J., Mohnert, F., Hupkes, D., and Zuidema, W. (2018). Under the hood: Using diagnostic classifiers to investigate and improve how language models track agreement information. In _Proceedings of the 2018 EMNLP Workshop BlackboxNLP: Analyzing and Interpreting Neural Networks for NLP_ , pages 240–248. 

- Goldberg, Y. (2019). Assessing BERT’s syntactic abilities. _CoRR_ , abs/1901.05287. 

- Goller, C. and Kuchler, A. (1996). Learning task-dependent distributed representations by backpropagation through structure. In _Proceedings of International Conference on Neural Networks (ICNN)_ , volume 1, pages 347–352. 

- Gulordava, K., Bojanowski, P., Grave, E., Linzen, T., and Baroni, M. (2018). Colorless green recurrent networks dream hierarchically. In _Proceedings of the 2018 Conference of the North American Chapter of the Association for Computational Linguistics: Human Language Technologies (NAACL-HLT)_ , volume 1, pages 1195–1205. 

- He, X. and Golub, D. (2016). Character-level question answering with attention. In _Proceedings of the 2016 Conference on Empirical Methods in Natural Language Processing (EMNLP)_ , pages 1598–1607. 

- Hirschberg, J. and Manning, C. D. (2015). Advances in natural language processing. _Science_ , 349(6245):261–266. 

- Hochreiter, S. and Schmidhuber, J. (1997). Long short-term memory. _Neural computation_ , 9(8):1735– 1780. 

- Hupkes, D., Singh, A., Korrel, K., Kruszewski, G., and Bruni, E. (2019). Learning compositionally through attentive guidance. In _International Conference on Computational Linguistics and Intelligent Text Processing (CICLing)_ . 

- Hupkes, D., Veldhoen, S., and Zuidema, W. (2018). Visualisation and ‘diagnostic classifiers’ reveal how recurrent and recursive neural networks process hierarchical structure. _Journal of Artificial Intelligence Research_ , 61:907–926. 

- Husserl, E. (1913). _Logische Untersuchungen_ . Max Niemeyer. 

- Jacobson, P. (2002). The (dis)organization of the grammar: 25 years. _Linguistics and Philosophy_ , 25(5):601–626. 

- Janssen, T. (1983). _Foundations and applications of Montague grammar_ . Mathematisch Centrum. 

- Johnson, J., Hariharan, B., van der Maaten, L., Fei-Fei, L., Zitnick, C. L., and Girshick, R. (2017). CLEVR: A diagnostic dataset for compositional language and elementary visual reasoning. In _IEEE Conference on Computer Vision and Pattern Recognition (CVPR)_ , pages 1988–1997. 

- Jozefowicz, R., Vinyals, O., Schuster, M., Shazeer, N., and Wu, Y. (2016). Exploring the limits of language modeling. _CoRR_ , abs/1602.02410. 

- Kalchbrenner, N., Grefenstette, E., and Blunsom, P. (2014). A convolutional neural network for modelling sentences. In _Proceedings of the 52nd Annual Meeting of the Association for Computational Linguistics (ACL)_ , volume 1, pages 655–665. 

- Kartsaklis, D. (2014). Compositional operators in distributional semantics. _Springer Science Reviews_ , 2(1-2):161–177. 

36 

Compositionality decomposed: how do neural networks generalise? 

- Kim, Y., Rush, A. M., Yu, L., Kuncoro, A., Dyer, C., and Melis, G. (2019). Unsupervised recurrent neural network grammars. In _Proceedings of the 2019 Conference of the North American Chapter of the Association for Computational Linguistics: Human Language Technologies (NAACL-HLT)_ , volume 1, pages 1105–1117. 

- Klein, G., Kim, Y., Deng, Y., Senellart, J., and Rush, A. M. (2017). OpenNMT: Open-source toolkit for neural machine translation. In Bansal, M. and Ji, H., editors, _Proceedings of the 55th Annual Meeting of the Association for Computational Linguistics (ACL), System Demonstrations_ , pages 67–72. 

- Korrel, K., Hupkes, D., Dankers, V., and Bruni, E. (2019). Transcoding compositionally: using attention to find more generalizable solutions. In _Proceedings of the 2019 ACL Workshop BlackboxNLP: Analyzing and Interpreting Neural Networks for NLP_ , page 111. 

- Lake, B. and Baroni, M. (2018). Generalization without systematicity: On the compositional skills of sequence-to-sequence recurrent networks. In _proceedings of the 35th International Conference on Machine Learning (ICML)_ , pages 4487–4499. 

- Lakretz, Y., Kruszewski, G., Desbordes, T., Hupkes, D., Dehaene, S., and Baroni, M. (2019). The emergence of number and syntax units in LSTM language models. In _Proceedings of the 2019 Conference of the North American Chapter of the Association for Computational Linguistics: Human Language Technologies (NAACL-HLT)_ , volume 1. 

- Le, P. and Zuidema, W. (2015). The forest convolutional network: compositional distributional semantics with a neural chart and without binarization. In _Proceedings of the 2015 Conference on Empirical Methods in Natural Language Processing (EMNLP)_ , pages 1155–1164. 

- Lin, Y., Tan, Y. C., and Frank, R. (2019). Open sesame: Getting inside BERT’s linguistic knowledge. In _Proceedings of the 2018 EMNLP Workshop BlackboxNLP: Analyzing and Interpreting Neural Networks for NLP_ , pages 241–253. 

- Linzen, T., Dupoux, E., and Goldberg, Y. (2016). Assessing the ability of LSTMs to learn syntaxsensitive dependencies. _Transactions of the Association for Computational Linguistics_ , 4:521–535. 

- Liˇska, A., Kruszewski, G., and Baroni, M. (2018). Memorize or generalize? Searching for a compositional RNN in a haystack. In _Proceedings of AEGAP (FAIM Joint Workshop on Architectures and Evaluation for Generality, Autonomy and Progress in AI)_ . 

- Loula, J., Baroni, M., and Lake, B. M. (2018). Rearranging the familiar: testing compositional generalization in recurrent networks. In _Proceedings of the 2018 EMNLP Workshop BlackboxNLP: Analyzing and Interpreting Neural Networks for NLP_ , pages 108–114. 

- Manning, C. D., Surdeanu, M., Bauer, J., Finkel, J., Bethard, S. J., and McClosky, D. (2014). The Stanford CoreNLP natural language processing toolkit. In _Proceedings of the 52nd Annual Meeting of the Association for Computational Linguistics (ACL), System Demonstrations_ , pages 55–60. 

- Marcus, G. F. (2003). _The algebraic mind: Integrating connectionism and cognitive science_ . MIT press. 

- Marcus, G. F., Pinker, S., Ullman, M., Hollander, M., Rosen, T. J., Xu, F., and Clahsen, H. (1992). Overregularization in language acquisition. _Monographs of the society for research in child development_ , pages i–178. 

37 

Hupkes, Dankers, Mul & Bruni 

- Mareˇcek, D. and Rosa, R. (2018). Extracting syntactic trees from transformer encoder self-attentions. In _Proceedings of the 2018 EMNLP Workshop BlackboxNLP: Analyzing and Interpreting Neural Networks for NLP_ , pages 347–349. 

- McCoy, R. T., Linzen, T., Dunbar, E., and Smolensky, P. (2019). RNNs implicitly implement tensor-product representations. In _Proceedings of the 7th International Conference on Learning Representations (ICLR)_ . 

- Miller, G. A. and Charles, W. G. (1991). Contextual correlates of semantic similarity. _Language and cognitive processes_ , 6(1):1–28. 

- Mitchell, J. and Lapata, M. (2008). Vector-based models of semantic composition. In _Proceedings of the 46th Annual Meeting of the Association for Computational Linguistics: Human Language Technology (ACL-HLT)_ , pages 236–244. 

- Mul, M. and Zuidema, W. (2019). Siamese recurrent networks learn first-order logic reasoning and exhibit zero-shot compositional generalization. _CoRR_ , abs/1906.00180. 

- Pagin, P. (2003). Communication and strong compositionality. _Journal of Philosophical Logic_ , 32(3):287–322. 

- Pagin, P. and Westerst˚ahl, D. (2010). Compositionality i: Definitions and variants. _Philosophy Compass_ , 5(3):250–264. 

- Partee, B. (1995). Lexical semantics and compositionality. _An invitation to cognitive science: Language_ , 1:311–360. 

- Penke, M. (2012). The dual-mechanism debate. In _The Oxford handbook of compositionality_ . Oxford University Press. 

- Pinker, S. (1984). _Language learnability and language development_ . Cambridge, MA: Harvard University Press. 

- Plate, T. (1991). Holographic reduced representations: convolution algebra for compositional distributed representations. In _Proceedings of the 12th International Joint Conference on Artificial Intelligence (IJCAI)_ , volume 1, pages 30–35. 

- Potts, C. (2019). A case for deep learning in semantics: Response to pater. _Language_ . 

- Pullum, G. K. and Scholz, B. C. (2010). Recursion and the infinitude claim. _Recursion in human language_ , 104:113–38. 

- Radford, A., Wu, J., Child, R., Luan, D., Amodei, D., and Sutskever, I. (2019). Language models are unsupervised multitask learners. _OpenAI Blog_ , 1(8). 

- Raganato, A. and Tiedemann, J. (2018). An analysis of encoder representations in transformer-based machine translation. In _Proceedings of the 2018 EMNLP Workshop BlackboxNLP: Analyzing and Interpreting Neural Networks for NLP_ , pages 287–297. 

- Rodriguez, P. (2001). Simple recurrent networks learn context-free and context-sensitive languages by counting. _Neural computation_ , 13(9):2093–118. 

- Rodriguez, P., Wiles, J., and Elman, J. L. (1999). A recurrent neural network that learns to count. _Connection Science_ , 11(1):5–40. 

- Rumelhart, D. E. and McClelland, J. L. (1986). _Parallel distributed processing: explorations in the microstructure of cognition_ , volume 2, chapter On learning the past tenses of English verbs, pages 216–271. MIT Press, Cambridge. 

38 

Compositionality decomposed: how do neural networks generalise? 

- Saxton, D., Grefenstette, E., Hill, F., and Kohli, P. (2019). Analysing mathematical reasoning abilities of neural models. In _Proceedings of the 7th International Conference on Learning Representations (ICLR)_ . 

- Shi, X., Padhi, I., and Knight, K. (2016). Does string-based neural MT learn source syntax? In _Proceedings of the 2016 Conference on Empirical Methods in Natural Language Processing (EMNLP)_ , pages 1526–1534. 

- Smolensky, P. (1990). Tensor product variable binding and the representation of symbolic structures in connectionist systems. _Artificial intelligence_ , 46(1-2):159–216. 

- Socher, R., Manning, C. D., and Ng, A. Y. (2010). Learning continuous phrase representations and syntactic parsing with recursive neural networks. In _Proceedings of the NIPS2010 Deep Learning and Unsupervised Feature Learning Workshop_ , pages 1–9. 

- Soulos, P., McCoy, T., Linzen, T., and Smolensky, P. (2019). Discovering the compositional structure of vector representations with role learning networks. In _Proceedings of the NeurIPS 2019 Workshop on Context and Compositionality in biological and artificial neural systems_ . 

- Sutskever, I., Vinyals, O., and Le, Q. V. (2014). Sequence to sequence learning with neural networks. In _Advances in Neural Information Processing Systems (NIPS)_ , pages 3104–3112. 

- Szab´o, Z. (2012). The case for compositionality. _The Oxford handbook of compositionality_ , 64:80. 

- Tenney, I., Das, D., and Pavlick, E. (2019a). BERT rediscovers the classical NLP pipeline. In _Proceedings of the 57th Annual Meeting of the Association for Computational Linguistics (ACL)_ , pages 4593–4601. 

- Tenney, I., Xia, P., Chen, B., Wang, A., Poliak, A., McCoy, R. T., Kim, N., Van Durme, B., Bowman, S. R., Das, D., et al. (2019b). What do you learn from context? Probing for sentence structure in contextualized word representations. In _Proceedings of the 7th International Conference on Learning Representations (ICLR)_ . 

- Tran, K., Bisazza, A., and Monz, C. (2018). The importance of being recurrent for modeling hierarchical structure. In _Proceedings of the 2018 Conference on Empirical Methods in Natural Language Processing (EMNLP)_ , pages 4731–4736. 

- Turney, P. D. and Pantel, P. (2010). From frequency to meaning: Vector space models of semantics. _Journal of Artificial Intelligence Research_ , 37:141–188. 

- Vaswani, A., Shazeer, N., Parmar, N., Uszkoreit, J., Jones, L., Gomez, A. N., Kaiser, �L., and Polosukhin, I. (2017). Attention is all you need. In _Advances in Neural Information Processing Systems (NIPS)_ , pages 5998–6008. 

- Veldhoen, S., Hupkes, D., and Zuidema, W. (2016). Diagnostic classifiers: Revealing how neural networks process hierarchical structure. In _Proceedings of the NIPS2016 Workshop on Cognitive Computation: Integrating Neural and Symbolic Approaches_ . 

- Vig, J. and Belinkov, Y. (2019). Analyzing the structure of attention in a transformer language model. _Proceedings of the 2019 ACL Workshop BlackboxNLP: Analyzing and Interpreting Neural Networks for NLP_ , pages 63–76. 

- Weiss, G., Goldberg, Y., and Yahav, E. (2018a). Extracting automata from recurrent neural networks using queries and counterexamples. In _Proceedings of the 35th International Conference on Machine Learning (ICML)_ , volume 80, pages 5244–5253. 

39 

Hupkes, Dankers, Mul & Bruni 

- Weiss, G., Goldberg, Y., and Yahav, E. (2018b). On the practical computational power of finite precision RNNs for language recognition. In _Proceedings of the 56th Annual Meeting of the Association for Computational Linguistics (ACL)_ , volume 2, pages 740–745. 

- Wiles, J. and Elman, J. (1995). Learning to count without a counter: A case study of dynamics and activation landscapes in recurrent networks. In _Proceedings of the 17th Annual Conference of the Cognitive Science Society (CogSci)_ , pages 482–487. 

- Wolf, T. (2019). Some additional experiments extending the tech report “Assessing BERTs syntactic abilities” by Yoav Goldberg. Technical report. 

- Zadrozny, W. (1994). From compositional to systematic semantics. _Linguistics and philosophy_ , 17(4):329–342. 

- Zaremba, W. and Sutskever, I. (2014). Learning to execute. _CoRR_ , abs/1410.4615. 

40 

Compositionality decomposed: how do neural networks generalise? 

## **Appendix A. Naturalisation of artificial data** 

The artificially generated PCFG SET data are transformed so as to mimic the distribution of a natural language data set according to the following procedure: 

1. Use a natural language data set _DN_ , define a set of features _F_ , and for each _f ∈ F_ , compute the value _f_ ( _s_ ) for each sentence _s ∈DN_ . 

2. Generate a large sample _DR_ of PCFG SET data using random probabilities on production rules for each instance. 

3. Transform _DR_ as follows: 

- (i) For each feature _f ∈ F_ , specify a _feature increment if_ . 

- (ii) For each _s ∈DN_ , compute the _partitioning vector v_ ( _s_ ), which is the concatenation of the values _⌊f_ ( _s_ ) _/if ⌋_ for each feature _f ∈ F_ . 

- (iii) Partition _DN_ into subsets by clustering instances with the same partitioning vector. For any such subset _DN[i]_[,][let] _[v]_[(] _[D] N[i]_[)][denote][the][partitioning][vector][of][its][members.][And][for] any partitioning vector **v** , let _vN[−]_[1][(] **[v]**[)][denote][the][subset] _[D] N[i][⊆D][N]_[whose][members][have] partitioning vector **v** (so that _v_ ( _DN[i]_[) =] **[ v]**[).] 

- (iv) Of the identified subsets, determine the largest set _DN[i][⊆D][N]_[.][Call][this][set] _[D] N_[max] . 

- (v) Partition _DR_ in the same way as _DN_ , yielding subsets _DR[i]_[.][Let][the][subset] _[D] R[i]_[such][that] _v_ ( _DR[i]_[) =] _[ v]_[(] _[D] N_[max] ) be _DR_[max] . 

- (vi) Initialise an empty set _DR[′]_[.] 

- _N_[(] _[v]_[(] _[D] R[i]_[))] _[|][×][|][D] R_[max] _|_ 

- (vii) Of each _DR[i]_[,][randomly][pick] _[|][v][−]_[1] _|DN_[max] _|_ members, and assign them to _DR[′]_[.] 

- (viii) If necessary, repeat (i) - (vii) for different feature increments _fi_ . For _n_ features, fit an _n_ -variate Gaussian to each of the transformed sets _DR[′]_[.][Choose][the][set][with][the][lowest] Kullback-Leibler divergence from the _n_ -variate Gaussian approximation of _DN_ . 

4. Use maximum likelihood estimation to estimate the PCFG parameters of _DR[′]_[and][generate] more PCFG SET data using these parameters. 

5. If necessary, apply step 3 to the data thus generated. 

41 

