---
title: "Simplicity: a unifying principle in cognitive science?"
source: "https://www.cell.com/trends/cognitive-sciences/fulltext/S1364-6613(02)00005-0"
author:
  - "[[Nick Chater]]"
  - "[[Paul Vitányi]]"
published:
created: 2026-10-13
description: "Much of perception, learning and high-level cognition involves finding patterns indata. But there are always infinitely many patterns compatible with any finite amountof data. How does the cognitive system choose ‘sensible’ patterns? A long traditionin epistemology, philosophy of science, and mathematical and computational theoriesof learning argues that patterns ‘should’ be chosen according to how simply they explainthe data. This article reviews research exploring the idea that simplicity drivesa wide range of cognitive processes."
tags:
  - "clippings"
---
## Abstract

Much of perception, learning and high-level cognition involves finding patterns in data. But there are always infinitely many patterns compatible with any finite amount of data. How does the cognitive system choose ‘sensible’ patterns? A long tradition in epistemology, philosophy of science, and mathematical and computational theories of learning argues that patterns ‘should’ be chosen according to how simply they explain the data. This article reviews research exploring the idea that simplicity drives a wide range of cognitive processes. We outline mathematical theory, computational results and empirical data that underpin this viewpoint.

The cognitive apparatus finds patterns in the data that it receives. Perception involves finding patterns in the external world, from sensory input. Language acquisition involves finding patterns in linguistic input, in order to determine the structure of the language. High-level cognition involves finding patterns in information, to form categories and to infer causal relations.

## 1 Simplicity and the problem of induction

A fundamental puzzle is what we term the problem of induction: infinitely many patterns are compatible with any finite set of data (see [Fig. 1](#FIG1)). So, for example, an infinity of curves pass through any finite set of points ([Fig. 1a](#FIG1)); an infinity of symbol sequences are compatible with any subsequence of symbols ([Fig. 1b](#FIG1)); infinitely many grammars are compatible with any finite set of observed sentences ([Fig. 1c](#FIG1)); and infinitely many perceptual organizations can fit any specific visual input ([Fig. 1d](#FIG1)). Some patterns are more cognitively natural than others. But why? And are cognitively natural continuations reliable in prediction?

![](https://www.cell.com/cms/10.1016/S1364-6613(02)00005-0/asset/35254c5b-3e21-42ca-a211-2a116253250a/main.assets/gr1.gif)

Fig. 1 There are always infinitely many patterns compatible with any finite body of data. The general problem is illustrated in (a), where there is an infinite number of continuous functions that can be made to pass through a set of data points. (b) The same issue arises for discrete data: the alternating black and white squares on the left illustrate a sequence of binary data. But, as the right-hand side indicates, the overall pattern of which this data are a part could continue in any way. The ‘middle’ continuation is more cognitively natural. But why? (c) extends the point to grammar induction from a tiny ‘corpus’ of language data. Grammar 1 provides a linguistically reasonable analysis; Grammar 2 can produce any word sequence whatever and is clearly wildly overgeneral; Grammar 3 produces just the sentences in the corpus and nothing more. Human learners favour reasonable analyses; but why? (d) The limitless possible hypotheses for elaborating partial perceptual input. Only completion ii. (black dashed line) is seriously entertained, although i. and iii. are also compatible with the data.

These illustrations are quite abstract; but, importantly, the same issue arises even if the input is arbitrarily rich: although some specific patterns will be eliminated by such enrichment, an infinite number of incompatible patterns will always remain. What principle allows the cognitive system to solve the problem of induction, and choose appropriately from these infinite sets of possibilities?

Any such principle must meet two criteria: (1) it must solve the problem of induction successfully; (2) it must explain empirical data in cognition. We argue that the best approach to (1) is to choose patterns that provide the simplest explanation of the data; and that this approach provides a powerful in-road to (2), in line with a long tradition of psychological research.

The physicist and philosopher Mach

1.

Mach, E.

*The Analysis of Sensations and the Relation of the Physical to the Psychical.*Dover Publications, 1959

[Google Scholar](https://scholar.google.com/scholar?q=E.MachThe+Analysis+of+Sensations+and+the+Relation+of+the+Physical+to+the+Psychical1959Dover+Publications)

proposed the following radical idea: that the cognitive system should (criterion i), and does (criterion ii), prefer patterns that provide simple descriptions of the data. Here, a description must allow the data to be reconstructed, and the simplicity of a description is measured by its length.

Mach's proposal traces its roots back to Ockham's razor; that, in explanation, entities should not be multiplied beyond necessity; and to Newton's statement in the *Principia* that we ‘admit no more causes of natural things than are both true and sufficient to explain the appearances’. But to make Mach's proposal precise required a theory of description complexity, which necessitated awaiting further mathematical developments.

## 2 Quantifying simplicity

These mathematical developments came in two steps. First, Shannon's information theory justified log <sub>2</sub> (1/ *p*) as a code length for items with probability *p*. This is helpful for providing code lengths of highly repetitive data patterns, which can be assigned probabilities, such as low-level perceptual properties, phonemes, words and so on

2.

Hochberg, J. ∙ McAlister, E.

**A quantitative approach to figure ‘goodness’**

*J. Exp. Psychol.* 1953; **46**:361-364

. Second, the critical generalization to algorithmic information theory by Kolmogorov, Solomonoff and Chaitin defined the complexity *K* (*x*) of any object, *x*, by the length of the shortest program for *x* in any standard (universal) computer programming language

3.

Li, M. ∙ Vitányi, P.

*An Introduction to Kolmogorov Complexity and its Applications.*Springer-Verlag, 1997

[Crossref](https://doi.org/10.1007/978-1-4757-2606-0)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1007%2F978-1-4757-2606-0)

. Surprisingly, it turns out that the choice of programming language does not matter, up to a constant additive factor. Moreover, algorithmic information theory turns out to agree closely with standard information theory, where the latter theory applies at all. Crucially, the algorithmic definition of simplicity applies to individual objects, whereas Shannon's definition depends on associating *probabilities* with objects.

Intuitively, then, we can regard the cognitive system's goal as compressing data: coding it in such a form that it can be recovered by some computable process (the mathematics allow that compression may be ‘lossy’ – i.e. information may be thrown away by the cognitive system, but we do not consider this here). Choices between patterns are determined by the degree of compression they provide – compression thus provides a measure of the strength of evidence for a pattern. This viewpoint forges potential connections between compression and pattern-finding as computational projects. Note that the shortest code for data also provides its least redundant representation; elimination of redundancy has been viewed as central to pattern recognition both in humans

4.

Attneave, F.

**Some informational aspects of visual perception**

*Psychol. Rev.* 1954; **61**:183-193

5.

Barlow, H.B.

**Possible principles underlying the transformation of sensory messages**

Rosenblith, W. (Editor)

**Sensory Communication**

MIT Press, 1959; 217-234

[Google Scholar](https://scholar.google.com/scholar?q=H.B.BarlowPossible+principles+underlying+the+transformation+of+sensory+messagesW.RosenblithSensory+Communication1959MIT+Press217234)

and machines

6.

Watanabe, S.

**Information-theoretical aspects of inductive and deductive inference**

*IBM J. Res. Dev.* 1960; **4**:208-231

[Crossref](https://doi.org/10.1147/rd.42.0208)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1147%2Frd.42.0208)

.

More importantly, formalizing simplicity provides a candidate solution to the problem of induction, described above. The infinity of patterns, all compatible with any set of data, are not all equal: the cognitive system should prefer that pattern that gives the shortest code for the data.

Regarding criterion (1) above, there are two beautiful and important mathematical results that justify this choice as a solution to the problem of induction

7.

Vitányi, P. ∙ Li, M.

**Minimum description length induction, bayesianism and kolmogorov complexity**

*IEEE Trans. Inf. Theory.* 2000; **46**:446-464

. One is that, under quite general conditions, the shortest code for the data are also the most probable (according to a Bayesian analysis, using the so-called ‘universal prior’). A second result is that the shortest code can be used for prediction, with a high probability of ‘convergence’ on largely correct predictions. Finally, a third powerful line of justification for simplicity as an effective method of induction is its widespread use in machine learning

8.

Quinlan, J. ∙ Rivest, R.

**Inferring decision trees using the minimum description length principle**

*Inf. Comput.* 1989; **80**:227-248

9.

Wallace, C. ∙ Freeman, P.

**Estimation and inference by compact coding**

*J. Roy. Stat. Soc. Series B.* 1987; **49**:240-251

[Google Scholar](https://scholar.google.com/scholar?q=C.WallaceP.FreemanEstimation+and+inference+by+compact+codingJ.+Roy.+Stat.+Soc.+Series+B491987240251)

and statistics

10.

Rissanen, J. (1989) Stochastic complexity and statistical inquiry. *World Scientific Series in Computer Science* (Vol 15), World Scientific.

[Google Scholar](https://scholar.google.com/scholar?q=Rissanen%2C+J.+%281989%29+Stochastic+complexity+and+statistical+inquiry.+World+Scientific+Series+in+Computer+Science+%28Vol+15%29%2C+World+Scientific.)

.

## 3 Simplicity as a cognitive principle

So, simplicity appears to go some way towards meeting criterion (1): justifying why patterns should be chosen according to simplicity. What about criterion (2)? Does simplicity explain empirical data in cognitive science? [Table 1](#TBL1) describes a range of models of cognitive phenomena, from low- and high-level visual perception, language processing, similarity judgments, and mental processes in explicit scientific inference. The breadth of domains in which simplicity has proved to be a powerful organizing principle in cognitive modelling is encouraging.

| **Cognitive process** | **Data** | **Codes** | **Computer science/mathematical approaches** | **Cognitive science applications** |
| --- | --- | --- | --- | --- |
| Low-level perception | Sensoryinput/artificially captured images | Filters in early vision | Image compression  25.  Fisher, Y.  **Fractal Image Compression: Theory and Application**  Fisher, Y. (Editor)  Springer Verlag, 1995  [Crossref](https://doi.org/10.1007/978-1-4612-2472-3)  [Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1007%2F978-1-4612-2472-3) | Early vision as compression  22.  Olshausen, B.A. ∙ Field, D.J.  **Sparse coding with an overcomplete basis set: a strategy employed by V1?**  *Vision Res.* 1997; **37**:3311-3325  [Crossref](https://doi.org/10.1016/S0042-6989\(97\)00169-7)  [Scopus (2743)](https://www.cell.com/servlet/linkout?suffix=e_1_5_1_2_22_2&dbid=137438953472&doi=10.1016%2FS1364-6613%2802%2900005-0&key=2-s2.0-0030779611)  [PubMed](https://pubmed.ncbi.nlm.nih.gov/9425546/)  [Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1016%2FS0042-6989%2897%2900169-7&pmid=9425546)  23.  Wolff, J.G.  **Language acquisition, data compression and generalization**  *Lang. Commun.* 1982; **2**:57-89  [Crossref](https://doi.org/10.1016/0271-5309\(82\)90035-0)  [Scopus (51)](https://www.cell.com/servlet/linkout?suffix=e_1_5_1_2_23_2&dbid=137438953472&doi=10.1016%2FS1364-6613%2802%2900005-0&key=2-s2.0-0002621540)  [Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1016%2F0271-5309%2882%2990035-0) |
| High-level perception | Sensory input/output of early perceptual | Representations of higher level structure | Pattern theory  26.  Mumford, D.  **Pattern theory: a unifying perspective**  Knill, D. ∙ Richards, W. (Editors)  **Perception as Bayesian Inference**  Cambridge University Press, 1996; 25-62  [Crossref](https://doi.org/10.1017/CBO9780511984037.003)  [Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1017%2FCBO9780511984037.003) | Principle of economy  1.  Mach, E.  *The Analysis of Sensations and the Relation of the Physical to the Psychical.*Dover Publications, 1959  [Google Scholar](https://scholar.google.com/scholar?q=E.MachThe+Analysis+of+Sensations+and+the+Relation+of+the+Physical+to+the+Psychical1959Dover+Publications) |
|  | Processing |  |  | Perceptual organization  14.  Garner, W.  *The Processing of Information and Structure.*Erlbaum, 1974  [Google Scholar](https://scholar.google.com/scholar?q=W.GarnerThe+Processing+of+Information+and+Structure1974Erlbaum)  27.  Leeuwenberg, E. ∙ Boselie, F.  **Against the likelihood principle in visual form perception**  *Psychol. Rev.* 1988; **95**:485-491  [Crossref](https://doi.org/10.1037/0033-295X.95.4.485)  [Scopus (45)](https://www.cell.com/servlet/linkout?suffix=e_1_5_1_2_27_2&dbid=137438953472&doi=10.1016%2FS1364-6613%2802%2900005-0&key=2-s2.0-0024100450)  [PubMed](https://pubmed.ncbi.nlm.nih.gov/3057528/)  [Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1037%2F0033-295X.95.4.485&pmid=3057528) |
| Language acquisition | Linguistic input | Representations of language structure | Text compression  28.  Bell, T.C....  *Modelling For Text Compression.*Prentice Hall, 1990  [Google Scholar](https://scholar.google.com/scholar?q=T.C.BellModelling+For+Text+Compression1990Prentice+Hall) | Phonological  29.  Goldsmith, J.  **Probabilistic models of grammar: phonology as information minimization**  *Phonological Studies.* 2002; 5  [Google Scholar](https://scholar.google.com/scholar?q=J.GoldsmithProbabilistic+models+of+grammar%3A+phonology+as+information+minimizationPhonological+Studies20025)  and morpholgical analysis  30.  Goldsmith, J.  **Unsupervised learning of the morphology of a natural language**  *Comput. Linguist.* 2001; **2**:153-198  [Crossref](https://doi.org/10.1162/089120101750300490)  [Scopus (468)](https://www.cell.com/servlet/linkout?suffix=e_1_5_1_2_30_2&dbid=137438953472&doi=10.1016%2FS1364-6613%2802%2900005-0&key=2-s2.0-0041079008)  [Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1162%2F089120101750300490)  , segmentation  24.  Barlow, H.B....  **Finding minimum entropy codes**  *Neural Comput.* 1989; **1**:412-423  [Crossref](https://doi.org/10.1162/neco.1989.1.3.412)  [Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1162%2Fneco.1989.1.3.412)  31.  Brent, M.R. ∙ Cartwright, T.A.  **Distributional regularity and phonotactic constraints are useful for segmentation**  *Cognition.* 1996; **61**:93-125  [Crossref](https://doi.org/10.1016/S0010-0277\(96\)00719-6)  [PubMed](https://pubmed.ncbi.nlm.nih.gov/8990969/)  [Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1016%2FS0010-0277%2896%2900719-6&pmid=8990969)  and grammar induction  32.  Grünwald, P.  **Symbolic, connectionist and statistical approaches to learning for natural language processing**  Wermter, S. (Editor)  **Lecture Notes in Artificial Intelligence 1040**  Springer Verlag, 1996; 203-216  [Google Scholar](https://scholar.google.com/scholar?q=P.Gr%C3%BCnwaldSymbolic%2C+connectionist+and+statistical+approaches+to+learning+for+natural+language+processingS.WermterLecture+Notes+in+Artificial+Intelligence+10401996Springer+Verlag203216)  33.  Clark, R.  **Information theory, complexity, and linguistic descriptions**  Bertolo, S. (Editor)  **Parametric Linguistics and Learnability**  Cambridge University Press, 2001; 126-171  [Google Scholar](https://scholar.google.com/scholar?q=R.ClarkInformation+theory%2C+complexity%2C+and+linguistic+descriptionsS.BertoloParametric+Linguistics+and+Learnability2001Cambridge+University+Press126171) |
| High-level cognition | High-level representations of knowledge | Similarity, causal relations | Information distance  34.  Bennett, C.H....  **Information distance**  *IEEE Trans. Inf. Theory.* 1998; **44**:1407-1423  [Crossref](https://doi.org/10.1109/18.681318)  [Scopus (345)](https://www.cell.com/servlet/linkout?suffix=e_1_5_1_2_34_2&dbid=137438953472&doi=10.1016%2FS1364-6613%2802%2900005-0&key=2-s2.0-0032124110)  [Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1109%2F18.681318) | Similarity as representational distortion  18.  Shepard, R.N.  **Toward a universal law of generalization for psychological science**  *Science.* 1987; **237**:1317-1323  [Crossref](https://doi.org/10.1126/science.3629243)  [Scopus (1717)](https://www.cell.com/servlet/linkout?suffix=e_1_5_1_2_18_2&dbid=137438953472&doi=10.1016%2FS1364-6613%2802%2900005-0&key=2-s2.0-0023223978)  [PubMed](https://pubmed.ncbi.nlm.nih.gov/3629243/)  [Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1126%2Fscience.3629243&pmid=3629243) |
|  |  |  | Gencompress  35.  Li, M. *et al.* The similarity metric. In *Proc. 14th ACM–SIAM symposium on Discrete Algorithms* (in press).  [Google Scholar](https://scholar.google.com/scholar?q=Li%2C+M.+et+al.+The+similarity+metric.+In+Proc.+14th+ACM%E2%80%93SIAM+symposium+on+Discrete+Algorithms+%28in+press%29.) | Categorization by compression  36.  Pothos, E. ∙ Chater, N.  **A simplicity principle in unsupervised human categorization**  *Cogn. Sci.* 2002; **26**:303-343  [Crossref](https://doi.org/10.1207/s15516709cog2603_6)  [Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1207%2Fs15516709cog2603_6) |
| Scientific inference | Scientific data | Theoretical knowledge | Machine induction systems  9.  Wallace, C. ∙ Freeman, P.  **Estimation and inference by compact coding**  *J. Roy. Stat. Soc. Series B.* 1987; **49**:240-251  [Google Scholar](https://scholar.google.com/scholar?q=C.WallaceP.FreemanEstimation+and+inference+by+compact+codingJ.+Roy.+Stat.+Soc.+Series+B491987240251) | Ockham, Newton Mach's principle of economy  1.  Mach, E.  *The Analysis of Sensations and the Relation of the Physical to the Psychical.*Dover Publications, 1959  [Google Scholar](https://scholar.google.com/scholar?q=E.MachThe+Analysis+of+Sensations+and+the+Relation+of+the+Physical+to+the+Psychical1959Dover+Publications) |
|  |  |  | Foundations of statistics  10.  Rissanen, J. (1989) Stochastic complexity and statistical inquiry. *World Scientific Series in Computer Science* (Vol 15), World Scientific.  [Google Scholar](https://scholar.google.com/scholar?q=Rissanen%2C+J.+%281989%29+Stochastic+complexity+and+statistical+inquiry.+World+Scientific+Series+in+Computer+Science+%28Vol+15%29%2C+World+Scientific.) | Formal measures of simplicity  37.  Kemeny, J.G.  **The use of simplicity in induction**  *Phil. Rev.* 1953; **62**:391-408  [Crossref](https://doi.org/10.2307/2182878)  [Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.2307%2F2182878)  38.  Sober, E.  *Simplicity.*Clarendon Press, 1975  [Crossref](https://doi.org/10.1093/acprof:oso/9780198244073.001.0001)  [Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1093%2Facprof%3Aoso%2F9780198244073.001.0001) |

Table 1

Pattern-finding by simplicity: a sample of research [<sup>a</sup>](#TBLFN1)

a

Many pattern-finding problems have been successfully approached by mathematicians and computer scientists using a simplicity principle. In many of these areas, the simplicity principle has also been used as a starting point for modelling cognition.

- [Open table in a new tab](https://www.cell.com/action/showFullTableHTML?isHtml=true&tableId=TBL1&pii=S1364-6613%2802%2900005-0)

But how does the simplicity principle stand up to direct empirical testing? This question is difficult to answer, for two reasons:

- *The representation problem*: Although, in the limit, and assuming the brain has universal Turing-machine power and Kolmogorov complexity is language invariant, many specific, non-asymptotic empirical predictions from simplicity depend on assumptions about mental representation, which will affect what regularities can be detected. And the mental representation of perceptual and linguistic stimuli is highly contentious in cognitive science.
- *The search problem*: The cognitive system might prefer the simplest interpretation that it can find, but be unable to find a simple pattern of interest. Thus, without creating a full-scale cognitive model, involving assumptions about representation and perhaps also search, precise predictions from the simplicity viewpoint cannot be obtained
	11.
	Van der Helm, P.A. ∙ Leeuwenberg, E.L.J.
	**Goodness of visual regularities: a non-transformational approach**
	*Psychol. Rev.* 1996; **3**:429-456
	.

There are, however, several lines of evidence that appear to be consonant with the simplicity viewpoint.

- A vast range of phenomena in perceptual organization, including the Gestalt laws of closure, good continuation and common fate, have been widely interpreted as revealing a preference for simplicity. [Box 1](#TBX1) discusses some complex cases. The main theoretical alternative, the Bayesian approach to visual perception
	12.
	Knill, D. ∙ Richards, W.
	*Perception as Bayesian Inference.*Cambridge University Press, 1996
	[Crossref](https://doi.org/10.1017/CBO9780511984037)
	[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1017%2FCBO9780511984037)
	is mathematically closely related to the simplicity principle
	13.
	Chater, N.
	**Reconciling simplicity and likelihood principles in perceptual organization**
	*Psychol. Rev.* 1996; **103**:566-581
	.
	Box 1
	Box 1. Empirical data
	Various qualitative aspects of the resolution of perceptual ambiguity can be understood in terms of simplicity. In each of [Fig. Ia–c](#FIG2), the left-hand side schematically represents a visual input, and the right-hand figure represents possible interpretations. [Figure Ia](#FIG2) illustrates that preferred perceptual organizations typically have a relatively good (although not necessarily perfect) fit with the data – here a somewhat consonant triangle interpretation is favoured over a very unlikely square interpretation. Patterns with good data-fit provide short codes for the data, given the pattern, and are preferred by the simplicity principle. [Figure Ib](#FIG2) illustrates the complementary preference for simple patterns: the 2-D straight line projected image is thus preferred to a highly irregular curve in the plane, even though, when viewed from one specific angle, this can project a perfect 2-D line. [Figure Ic](#FIG2) reveals the importance of precision in visual coding. The figure illustrates a preference for interpreting a small ellipse as that ellipse in the plane perpendicular to the viewer, rather than a larger, but geometrically similar, ellipse at a highly skewed angle (another possible interpretation is a circle, at a moderately skewed angle). Thus, data-fit, and, apparently, complexity-of-pattern appear identical here. How can the simplicity principle distinguish the two elliptical interpretations? The answer is that the projection is much more stable for the perpendicular ellipse; for the highly skewed ellipse the angle of orientation must be specified more precisely, costing additional code length, to obtain an equally good fit with the data. Finally, [Fig. Id](#FIG2) illustrates that simpler interpretations are taken to have causal significance. The right-hand 2-D figure is perceived as a projection of a wire cube; the left-hand figure is perceived as an irregular 2-D figure. Importantly, the joints of the wire cube are perceived as rigid, whereas the joints of the irregular 3-D figure are perceived as potentially flexible. The joints of the cube are perceived as rigid presumably because, otherwise, this ‘simple’ arrangement would be a remarkable coincidence (analogously, a sequence of 100 heads from a coin would be interpreted as indicating that the coin is biased). Thus, causal structure can be inferred on the basis of simplicity.
	![](https://www.cell.com/cms/10.1016/S1364-6613(02)00005-0/asset/9e8ef103-f590-4e72-8df5-c71124244582/main.assets/gr2.gif)
	Fig. I Interpretations of perceptual input. (See text for details).
	Qualitative demonstrations of this kind have also been supplemented by formal theories in psychology that seek to explain the interpretations of perceptual figures as minimizing code length [\[a,b\]](#BIB39).
	### References
	1.
	Hochberg, J. ∙ McAlister, E.
	**A quantitative approach to figure ‘goodness’**
	*J. Exp. Psychol.* 1953; **46**:361-364
	2.
	Van der Helm, P.A. ∙ Leeuwenberg, P.A.
	**Goodness of visual regularities: a non-transformational approach**
	*Psychol. Rev.* 1996; **103**:429-456
	[Crossref](https://doi.org/10.1037/0033-295X.103.3.429)
	[PubMed](https://pubmed.ncbi.nlm.nih.gov/8759043/)
	[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1037%2F0033-295X.103.3.429&pmid=8759043)
- Items with simple descriptions are typically easier to detect in noise
	2.
	Hochberg, J. ∙ McAlister, E.
	**A quantitative approach to figure ‘goodness’**
	*J. Exp. Psychol.* 1953; **46**:361-364
	11.
	Van der Helm, P.A. ∙ Leeuwenberg, E.L.J.
	**Goodness of visual regularities: a non-transformational approach**
	*Psychol. Rev.* 1996; **3**:429-456
	.
- The simplicity of a code for a stimulus quantifies the amount of structure uncovered in that stimulus. The more structure people can find in a stimulus, the easier they find it to process and remember
	14.
	Garner, W.
	*The Processing of Information and Structure.*Erlbaum, 1974
	[Google Scholar](https://scholar.google.com/scholar?q=W.GarnerThe+Processing+of+Information+and+Structure1974Erlbaum)
	and the less random it appears
	15.
	Falk, R. ∙ Konold, C.
	**Making sense of randomness: implicit encoding as a bias for judgment**
	*Psychol. Rev.* 1997; **104**:301-318
	.
- The speed of learning for Boolean concepts (e.g. A or B or C; A and (B or C), etc) is closely predicted by the shortest code length for those concepts
	16.
	Feldman, J.
	**Minimization of Boolean complexity in human concept learning**
	*Nature.* 2000; **407**:630-633
	.
- Similarity can be viewed as a function of the simplicity of the distortion required to turn one representation into the other. This viewpoint makes empirical predictions that are not captured by existing spatial or feature-based theories of similarity, but which have been confirmed
	17.
	Hahn, U....
	**Similarity as transformation**
	*Cognition.* 2002;
	in press
	[Google Scholar](https://scholar.google.com/scholar?q=U.HahnSimilarity+as+transformationCognition2002in+press)
	.
- Shepard's Universal Law of Generalization
	18.
	Shepard, R.N.
	**Toward a universal law of generalization for psychological science**
	*Science.* 1987; **237**:1317-1323
	, which implies that items have a probability of confusion that is a negative exponential function of the distance between them in an internal ‘space’, can be derived from the assumption that the psychological similarity between two objects is a function of the complexity of the simplest transformation between them, with minimal additional assumptions
	19.
	Chater, N. ∙ Vitányi, P.
	**Generalized law of universal generalization**
	*J. Math. Psychol.* 2002;
	in press
	[Google Scholar](https://scholar.google.com/scholar?q=N.ChaterP.Vit%C3%A1nyiGeneralized+law+of+universal+generalizationJ.+Math.+Psychol.2002in+press)
	.
- The physiology of early vision, including receptive-field structures, and phenomena such as lateral inhibition, seems adapted to maximize information compression from visual input
	20.
	Blakemore, C.
	*Vision: Coding and Efficiency.*Cambridge University Press, 1990
	[Google Scholar](https://scholar.google.com/scholar?q=C.BlakemoreVision%3A+Coding+and+Efficiency1990Cambridge+University+Press)
	. On the other hand, both theoretical and empirical arguments suggest that, the brain also uses highly redundant ‘sparse’ neural codes for perceptual input
	21.
	Gardner-Medwin, A.R.
	**The limits of counting accuracy in distributed neural representations**
	*Neural Comput.* 2001; **13**:477-504
	22.
	Olshausen, B.A. ∙ Field, D.J.
	**Sparse coding with an overcomplete basis set: a strategy employed by V1?**
	*Vision Res.* 1997; **37**:3311-3325
	.

## 4 Conclusion

Since Mach, a number of theorists have proposed the sweeping idea that much of cognition concerns compression

23.

Wolff, J.G.

**Language acquisition, data compression and generalization**

*Lang. Commun.* 1982; **2**:57-89

, or the elimination of redundancy

24.

Barlow, H.B....

**Finding minimum entropy codes**

*Neural Comput.* 1989; **1**:412-423

[Crossref](https://doi.org/10.1162/neco.1989.1.3.412)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1162%2Fneco.1989.1.3.412)

. This ‘simplicity principle’ has been developed into a mathematically rigorous method for finding patterns in data

3.

Li, M. ∙ Vitányi, P.

*An Introduction to Kolmogorov Complexity and its Applications.*Springer-Verlag, 1997

[Crossref](https://doi.org/10.1007/978-1-4757-2606-0)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1007%2F978-1-4757-2606-0)

, has served as the foundation for a broad range of cognitive models, and is consistent with a range of empirical data. We suggest that simplicity is worth pursuing as a potentially important unifying principle across many areas of cognitive science.

## Acknowledgements

This work was partially supported by the Human Frontiers Science Foundation, EU Training Network HPRN-CT-1999–00065, the Leverhulme Trust, an ESRC/DTI Link Award, and by Oliver, Wyman and Company. We thank Khalilah Khan and Ursula Richards for invaluable help in preparation of figures and text.

## References

[1.](#body-ref-BIB1-1 "View in article")

Mach, E.

*The Analysis of Sensations and the Relation of the Physical to the Psychical.*Dover Publications, 1959

[Google Scholar](https://scholar.google.com/scholar?q=E.MachThe+Analysis+of+Sensations+and+the+Relation+of+the+Physical+to+the+Psychical1959Dover+Publications)

[2.](#body-ref-BIB2-1 "View in article")

Hochberg, J. ∙ McAlister, E.

**A quantitative approach to figure ‘goodness’**

*J. Exp. Psychol.* 1953; **46**:361-364

[3.](#body-ref-BIB3-1 "View in article")

Li, M. ∙ Vitányi, P.

*An Introduction to Kolmogorov Complexity and its Applications.*Springer-Verlag, 1997

[Crossref](https://doi.org/10.1007/978-1-4757-2606-0)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1007%2F978-1-4757-2606-0)

[4.](#body-ref-BIB5 "View in article")

Attneave, F.

**Some informational aspects of visual perception**

*Psychol. Rev.* 1954; **61**:183-193

[5.](#body-ref-BIB5 "View in article")

Barlow, H.B.

**Possible principles underlying the transformation of sensory messages**

Rosenblith, W. (Editor)

**Sensory Communication**

MIT Press, 1959; 217-234

[Google Scholar](https://scholar.google.com/scholar?q=H.B.BarlowPossible+principles+underlying+the+transformation+of+sensory+messagesW.RosenblithSensory+Communication1959MIT+Press217234)

[6.](#body-ref-BIB6 "View in article")

Watanabe, S.

**Information-theoretical aspects of inductive and deductive inference**

*IBM J. Res. Dev.* 1960; **4**:208-231

[Crossref](https://doi.org/10.1147/rd.42.0208)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1147%2Frd.42.0208)

[7.](#body-ref-BIB7 "View in article")

Vitányi, P. ∙ Li, M.

**Minimum description length induction, bayesianism and kolmogorov complexity**

*IEEE Trans. Inf. Theory.* 2000; **46**:446-464

[8.](#body-ref-BIB9-1 "View in article")

Quinlan, J. ∙ Rivest, R.

**Inferring decision trees using the minimum description length principle**

*Inf. Comput.* 1989; **80**:227-248

[9.](#body-ref-BIB9-1 "View in article")

Wallace, C. ∙ Freeman, P.

**Estimation and inference by compact coding**

*J. Roy. Stat. Soc. Series B.* 1987; **49**:240-251

[Google Scholar](https://scholar.google.com/scholar?q=C.WallaceP.FreemanEstimation+and+inference+by+compact+codingJ.+Roy.+Stat.+Soc.+Series+B491987240251)

[10.](#body-ref-BIB10-1 "View in article")

Rissanen, J. (1989) Stochastic complexity and statistical inquiry. *World Scientific Series in Computer Science* (Vol 15), World Scientific.

[Google Scholar](https://scholar.google.com/scholar?q=Rissanen%2C+J.+%281989%29+Stochastic+complexity+and+statistical+inquiry.+World+Scientific+Series+in+Computer+Science+%28Vol+15%29%2C+World+Scientific.)

[11.](#body-ref-BIB11-1 "View in article")

Van der Helm, P.A. ∙ Leeuwenberg, E.L.J.

**Goodness of visual regularities: a non-transformational approach**

*Psychol. Rev.* 1996; **3**:429-456

[12.](#body-ref-BIB12 "View in article")

Knill, D. ∙ Richards, W.

*Perception as Bayesian Inference.*Cambridge University Press, 1996

[Crossref](https://doi.org/10.1017/CBO9780511984037)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1017%2FCBO9780511984037)

[13.](#body-ref-BIB13 "View in article")

Chater, N.

**Reconciling simplicity and likelihood principles in perceptual organization**

*Psychol. Rev.* 1996; **103**:566-581

[14.](#body-ref-BIB27 "View in article")

Garner, W.

*The Processing of Information and Structure.*Erlbaum, 1974

[Google Scholar](https://scholar.google.com/scholar?q=W.GarnerThe+Processing+of+Information+and+Structure1974Erlbaum)

[15.](#body-ref-BIB15 "View in article")

Falk, R. ∙ Konold, C.

**Making sense of randomness: implicit encoding as a bias for judgment**

*Psychol. Rev.* 1997; **104**:301-318

[16.](#body-ref-BIB16 "View in article")

Feldman, J.

**Minimization of Boolean complexity in human concept learning**

*Nature.* 2000; **407**:630-633

[17.](#body-ref-BIB17 "View in article")

Hahn, U....

**Similarity as transformation**

*Cognition.* 2002;

in press

[Google Scholar](https://scholar.google.com/scholar?q=U.HahnSimilarity+as+transformationCognition2002in+press)

[18.](#body-ref-BIB18-1 "View in article")

Shepard, R.N.

**Toward a universal law of generalization for psychological science**

*Science.* 1987; **237**:1317-1323

[19.](#body-ref-BIB19 "View in article")

Chater, N. ∙ Vitányi, P.

**Generalized law of universal generalization**

*J. Math. Psychol.* 2002;

in press

[Google Scholar](https://scholar.google.com/scholar?q=N.ChaterP.Vit%C3%A1nyiGeneralized+law+of+universal+generalizationJ.+Math.+Psychol.2002in+press)

[20.](#body-ref-BIB20 "View in article")

Blakemore, C.

*Vision: Coding and Efficiency.*Cambridge University Press, 1990

[Google Scholar](https://scholar.google.com/scholar?q=C.BlakemoreVision%3A+Coding+and+Efficiency1990Cambridge+University+Press)

[21.](#body-ref-BIB22-2 "View in article")

Gardner-Medwin, A.R.

**The limits of counting accuracy in distributed neural representations**

*Neural Comput.* 2001; **13**:477-504

[22.](#body-ref-BIB23-1 "View in article")

Olshausen, B.A. ∙ Field, D.J.

**Sparse coding with an overcomplete basis set: a strategy employed by V1?**

*Vision Res.* 1997; **37**:3311-3325

[23.](#body-ref-BIB23-1 "View in article")

Wolff, J.G.

**Language acquisition, data compression and generalization**

*Lang. Commun.* 1982; **2**:57-89

[24.](#body-ref-BIB31 "View in article")

Barlow, H.B....

**Finding minimum entropy codes**

*Neural Comput.* 1989; **1**:412-423

[Crossref](https://doi.org/10.1162/neco.1989.1.3.412)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1162%2Fneco.1989.1.3.412)

[25.](#body-ref-BIB25 "View in article")

Fisher, Y.

**Fractal Image Compression: Theory and Application**

Fisher, Y. (Editor)

Springer Verlag, 1995

[Crossref](https://doi.org/10.1007/978-1-4612-2472-3)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1007%2F978-1-4612-2472-3)

[26.](#body-ref-BIB26 "View in article")

Mumford, D.

**Pattern theory: a unifying perspective**

Knill, D. ∙ Richards, W. (Editors)

**Perception as Bayesian Inference**

Cambridge University Press, 1996; 25-62

[Crossref](https://doi.org/10.1017/CBO9780511984037.003)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1017%2FCBO9780511984037.003)

[27.](#body-ref-BIB27 "View in article")

Leeuwenberg, E. ∙ Boselie, F.

**Against the likelihood principle in visual form perception**

*Psychol. Rev.* 1988; **95**:485-491

[28.](#body-ref-BIB28 "View in article")

Bell, T.C....

*Modelling For Text Compression.*Prentice Hall, 1990

[Google Scholar](https://scholar.google.com/scholar?q=T.C.BellModelling+For+Text+Compression1990Prentice+Hall)

[29.](#body-ref-BIB29 "View in article")

Goldsmith, J.

**Probabilistic models of grammar: phonology as information minimization**

*Phonological Studies.* 2002; 5

[Google Scholar](https://scholar.google.com/scholar?q=J.GoldsmithProbabilistic+models+of+grammar%3A+phonology+as+information+minimizationPhonological+Studies20025)

[30.](#body-ref-BIB30 "View in article")

Goldsmith, J.

**Unsupervised learning of the morphology of a natural language**

*Comput. Linguist.* 2001; **2**:153-198

[31.](#body-ref-BIB31 "View in article")

Brent, M.R. ∙ Cartwright, T.A.

**Distributional regularity and phonotactic constraints are useful for segmentation**

*Cognition.* 1996; **61**:93-125

[Crossref](https://doi.org/10.1016/S0010-0277\(96\)00719-6)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/8990969/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1016%2FS0010-0277%2896%2900719-6&pmid=8990969)

[32.](#body-ref-BIB33 "View in article")

Grünwald, P.

**Symbolic, connectionist and statistical approaches to learning for natural language processing**

Wermter, S. (Editor)

**Lecture Notes in Artificial Intelligence 1040**

Springer Verlag, 1996; 203-216

[Google Scholar](https://scholar.google.com/scholar?q=P.Gr%C3%BCnwaldSymbolic%2C+connectionist+and+statistical+approaches+to+learning+for+natural+language+processingS.WermterLecture+Notes+in+Artificial+Intelligence+10401996Springer+Verlag203216)

[33.](#body-ref-BIB33 "View in article")

Clark, R.

**Information theory, complexity, and linguistic descriptions**

Bertolo, S. (Editor)

**Parametric Linguistics and Learnability**

Cambridge University Press, 2001; 126-171

[Google Scholar](https://scholar.google.com/scholar?q=R.ClarkInformation+theory%2C+complexity%2C+and+linguistic+descriptionsS.BertoloParametric+Linguistics+and+Learnability2001Cambridge+University+Press126171)

[34.](#body-ref-BIB34 "View in article")

Bennett, C.H....

**Information distance**

*IEEE Trans. Inf. Theory.* 1998; **44**:1407-1423

[35.](#body-ref-BIB35 "View in article")

Li, M. *et al.* The similarity metric. In *Proc. 14th ACM–SIAM symposium on Discrete Algorithms* (in press).

[Google Scholar](https://scholar.google.com/scholar?q=Li%2C+M.+et+al.+The+similarity+metric.+In+Proc.+14th+ACM%E2%80%93SIAM+symposium+on+Discrete+Algorithms+%28in+press%29.)

[36.](#body-ref-BIB36 "View in article")

Pothos, E. ∙ Chater, N.

**A simplicity principle in unsupervised human categorization**

*Cogn. Sci.* 2002; **26**:303-343

[Crossref](https://doi.org/10.1207/s15516709cog2603_6)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1207%2Fs15516709cog2603_6)

[37.](#body-ref-BIB38 "View in article")

Kemeny, J.G.

**The use of simplicity in induction**

*Phil. Rev.* 1953; **62**:391-408

[Crossref](https://doi.org/10.2307/2182878)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.2307%2F2182878)