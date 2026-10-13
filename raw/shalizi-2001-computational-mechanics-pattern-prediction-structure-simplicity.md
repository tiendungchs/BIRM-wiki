---
title: "Computational Mechanics:Pattern and Prediction, Structure and Simplicity"
source: "https://ar5iv.labs.arxiv.org/html/cond-mat/9907176"
author:
published: 2001-11-01
created: 2026-10-13
description: "Computational mechanics, an approach to structural complexity, defines aprocess’s causal states and gives a procedure for finding them. We show thatthe causal-state representation—an -machine—is the minimal oneconsi…"
tags:
  - "clippings"
---
## Computational Mechanics: Pattern and Prediction, Structure and Simplicity

Cosma Rohilla Shalizi and James P. Crutchfield Thanks: Permanent address: Physics Department, University of Wisconsin, Madison, WI 53706 Address: Santa Fe Institute, 1399 Hyde Park Road, Santa Fe, NM 87501  
Electronic addresses: {shalizi,chaos}@santafe.edu

###### Abstract

Computational mechanics, an approach to structural complexity, defines a process’s causal states and gives a procedure for finding them. We show that the causal-state representation—an $\epsilon$ -machine—is the minimal one consistent with accurate prediction. We establish several results on $\epsilon$ -machine optimality and uniqueness and on how $\epsilon$ -machines compare to alternative representations. Further results relate measures of randomness and structural complexity obtained from $\epsilon$ -machines to those from ergodic and information theories.

Santa Fe Institute Working Paper 99-07-044

Keywords: complexity, computation, entropy,

information, pattern, statistical mechanics.

Running Head: Computational Mechanics

###### pacs

02.50.Wp, 05.45, 05.65+b, 89.70.+c

## I Introduction

Organized matter is ubiquitous in the natural world, but the branch of physics which ought to handle it—statistical mechanics—lacks a coherent, principled way of describing, quantifying, and detecting the many different kinds of structure nature exhibits. Statistical mechanics has good measures of disorder in thermodynamic entropy and in related quantities, such as the free energies. When augmented with theories of critical phenomena [^1] and pattern formation [^2], it also has an extremely successful approach to analyzing patterns formed through symmetry breaking, both in equilibrium [^3] and, more recently, outside it [^4]. Unfortunately, these successes involve many ad hoc procedures—such as guessing relevant order parameters, identifying small parameters for perturbation expansion, and choosing appropriate function bases for spatial decomposition. It is far from clear that the present methods can be extended to handle all the many kinds of organization encountered in nature, especially those produced by biological processes.

Computational mechanics [^5] is an approach that lets us directly address the issues of pattern, structure, and organization. While keeping concepts and mathematical tools already familiar from statistical mechanics, it is distinct from the latter and complementary to it. In essence, from either empirical data or from a probabilistic description of behavior, it shows how to infer a model of the hidden process that generated the observed behavior. This representation—the $\epsilon$ -machine—captures the patterns and regularities in the observations in a way that reflects the causal structure of the process. Usefully, with this model in hand, one can extrapolate beyond the original observational data to make predictions of future behavior. Moreover, in a well defined sense that is the subject of the following, the $\epsilon$ -machine is the unique maximally efficient model of the observed data-generating process.

$\epsilon$ -Machines themselves reveal, in a very direct way, how information is stored in the process, and how that stored information is transformed by new inputs and by the passage of time. This, and not using computers for simulations and numerical calculations, is what makes computational mechanics “computational”, in the sense of “computation theoretic”.

The basic ideas of computational mechanics were introduced a decade ago [^6]. Since then they have been used to analyze dynamical systems [^7] [^8], cellular automata [^9], hidden Markov models [^10], evolved spatial computation [^11], stochastic resonance [^12], globally coupled maps [^13], and the dripping faucet experiment [^14]. Despite this record of successful application, there has been some uncertainty about the mathematical foundations of the subject. In particular, while it seemed evident from construction that an $\epsilon$ -machine captured the patterns inherent in a process and did so in a minimal way, no explicit proof of this was published. Moreover, there was no proof that, if the $\epsilon$ -machine was optimal in this way, it was the unique optimal representation of a process. These little-needed gaps have now been filled. Subject to some (reasonable) restrictions on the statistical character of a process, we prove that the $\epsilon$ -machine is indeed the unique optimal causal model. The rigorous proof of these results is the main burden of this paper. We gave preliminary versions of the optimality results—but not the uniqueness theorem, which is new here—in Ref. [^15].

The outline of the exposition is as follows. We begin by showing how computational mechanics relates to other approaches to pattern, randomness, and causality. The upshot of this is to focus our attention on patterns within a statistical ensemble and their possible representations. Using ideas from information theory, we state a quantitative version of Occam’s Razor for such representations. At that point we define causal states [^6], equivalence classes of behaviors, and the structure of transitions between causal states—the $\epsilon$ -machine. We then show that the causal states are ideal from the point of view of Occam’s Razor, being the simplest way of attaining the maximum possible predictive power. Moreover, we show that the causal states are uniquely optimal. This combination allows us to prove a number of other, related optimality results about $\epsilon$ -machines. We examine the assumptions made in deriving these optimality results, and we note that several of them can be lifted without unduly upsetting the theorems. We also establish bounds on a process’s intrinsic computation as revealed by $\epsilon$ -machines and by quantities in information and ergodic theories. Finally, we close by reviewing what has been shown and what seem like promising directions for further work on the mathematical foundations of computational mechanics.

A series of appendices provide supplemental material on information theory, equivalence relations and classes, $\epsilon$ -machines for time-reversed processes, semi-group theory, and connections and distinctions between computational mechanics and other fields.

To set the stage for the mathematics to follow and to motivate the assumptions used there, we begin now by reviewing prior work on pattern, randomness, and causality. We urge the reader interested only in the mathematical development to skip directly to Sec. II.6—a synopsis of the central assumptions of computational mechanics—and continue from there.

## II Patterns

To introduce our approach to—and even to argue that some approach is necessary for—discovering and describing patterns in nature we begin by quoting Jorge Luis Borges:

> These ambiguities, redundancies, and deficiencies recall those attributed by Dr. Franz Kuhn to a certain Chinese encyclopedia entitled Celestial Emporium of Benevolent Knowledge. On those remote pages it is written that animals are divided into (a) those that belong to the Emperor, (b) embalmed ones, (c) those that are trained, (d) suckling pigs, (e) mermaids, (f) fabulous ones, (g) stray dogs, (h) those that are included in this classification, (i) those that tremble as if they were mad, (j) innumerable ones, (k) those drawn with a very fine camel’s hair brush, (l) others, (m) those that have just broken a flower vase, (n) those that resemble flies from a distance.  
>   
> —J. L. Borges, “The Analytical Language of John Wilkins”, in Ref. [^16]; see also discussion in Ref. [^17].

The passage illustrates the profound gulf between patterns, and classifications derived from patterns, that are appropriate to the world and help us to understand it and those patterns which, while perhaps just as legitimate as prosaic regularities, are not at all informative. What makes the Celestial Emporium’s scheme inherently unsatisfactory, and not just strange, is that it tells us nothing about animals. We want to find patterns in a process that “divide it at the joints, as nature directs, not breaking any limbs in half as a bad carver might” [^18].

Computational mechanics is not directly concerned with pattern formation per se [^4]; though we suspect it will ultimately be useful in that domain. Nor is it concerned with pattern recognition as a practical matter as found in, say, neuropsychology [^19], psychophysics [^20], cognitive ethology [^21], computer engineering [^22], and signal and image processing [^23] [^24]. Instead, it is concerned with the questions of what patterns are and how patterns should be represented. One way to highlight the difference is to call this pattern discovery, rather than pattern recognition.

The bulk of the intellectual discourse on what patterns are has been philosophical. One distinct subset has been conducted under the broad rubric of mathematical logic. Within this there are approaches, on the one hand, that draw on (highly) abstract algebra and the theory of relations; on the other, that approach patterns via the theory of algorithms and effective procedures.

The general idea, in both approaches, is that some object ${\cal O}$ has a pattern ${\cal P}$ — ${\cal O}$ has a pattern “represented”, “described”, “captured”, and so on by ${\cal P}$ —if and only if we can use ${\cal P}$ to predict or compress ${\cal O}$. Note that the ability to predict implies the ability to compress, but not vice versa; here we stick to prediction. The algebraic and algorithmic strands differ mainly on how ${\cal P}$ itself should be represented; that is, they differ in how it is expressed in the vocabulary of some formal scheme.

We should emphasize here that “pattern” in this sense implies a kind of regularity, structure, symmetry, organization, and so on. In contrast, ordinary usage sometimes accepts, for example, speaking about the “pattern” of pixels in a particular slice of between-channels video “snow”; but we prefer to speak of that as the configuration of pixels.

### II.1 Algebraic Patterns

Although the problem of pattern discovery appears early, in Plato’s Meno [^25] for example, perhaps the first attempt to make the notion of “pattern” mathematically rigorous was that of Whitehead and Russell in Principia Mathematica. They viewed pattern as a property, not of sets, but of relations within or between sets, and accordingly they work out an elaborate relation-arithmetic [^26]; cf. [^27]. This starts by defining the relation-number of a relation between two sets as the class of all the relations that are equivalent to it under one-to-one, onto mappings of the two sets. In this framework relations share a common pattern or structure if they have the same relation-number. For instance, all square lattices have similar structure since their elements share the same neighborhood relation; as do all hexagonal lattices. Hexagonal and square lattices, however, exhibit different patterns since they have non-isomorphic neighborhood relations—i.e., since they have different relation-numbers. (See also recoding equivalence defined in Ref. [^28].) Less work has been done on this than they—especially Russell [^29] —had hoped. This may be due in part to a general lack of familiarity with Volume II of Ref. [^26].

A more recent attempt at developing an algebraic approach to patterns builds on semi-group theory and its Krohn-Rhodes decomposition theorem. Ref. [^30] discusses a range of applications of this approach to patterns. Along these lines, Rhodes and Nehaniv have tried to apply semi-group complexity theory to biological evolution [^31]. They suggest that the complexity of a biological structure can be measured by the number of subgroups in the decomposition of an automaton that describes the structure.

Yet another algebraic approach has been developed by Grenander and co-workers, primarily for pattern recognition [^32]. Essentially, this is a matter of trying to invent a minimal set of generators and bonds for the pattern in question. Generators can adjoin each other, in a suitable $n$ -dimensional space, only if their bonds are compatible. Each pair of compatible bonds at once specifies a binary algebraic operation and an observable element of the configuration built out of the generators. (Our construction in App. D, linking an algebraic operation with concatenations of strings, is analogous in a rough way.) Probabilities can be attached to these bonds, leading in a natural way to a (Gibbsian) probability distribution over entire configurations. Grenander and his colleagues have used these methods to characterize, inter alia, several biological phenomena [^33] [^34].

### II.2 Turing Mechanics: Patterns and Effective Procedures

The other path to patterns follows the traditional exploration of the logical foundations of mathematics, as articulated by Frege and Hilbert and pioneered by Church, Gödel, Post, Russell, Turing, and Whitehead. A more recent and relatively more popular approach goes back to Kolmogorov and Chaitin, who were interested in the exact reproduction of an individual object [^35] [^36] [^37] [^38]; in particular, their focus was discrete symbol systems, rather than (say) real numbers or other mathematical objects. The candidates for expressing the pattern ${\cal P}$ were universal Turing machine (UTM) programs—specifically, the shortest UTM program that can exactly produce the object ${\cal O}$. This program’s length is called ${\cal O}$ ’s Kolmogorov-Chaitin complexity. Note that any scheme—automaton, grammar, or what-not—that is Turing equivalent and for which a notion of “length” is well defined will do as a representational scheme. Since we can convert from one such device to another—say, from a Post tag system [^39] to a Turing machine—with only a finite description of the first system, such constants are easily assimilated when measuring complexity in this approach.

In particular, consider the first $n$ symbols ${\cal O}_{n}$ of ${\cal O}$ and the shortest program ${\cal P}_{n}$ that produces them. We ask, What happens to the limit

$$
\lim_{n\rightarrow\infty}{{|{\cal P}_{n}|\over n}}~,
$$

where $|{\cal P}|$ is the length in bits of program ${\cal P}$? On the one hand, if there is a fixed-length program ${\cal P}$ that generates arbitrarily many digits of ${\cal O}$, then this limit vanishes. Most of our interesting numbers, rational or irrational—such as $\pi$, $e$, $\sqrt{2}$ —are of this sort. These numbers are eminently compressible: the program ${\cal P}$ is the compressed description, and so it captures the pattern obeyed by the sequence describing ${\cal O}$. If the limit goes to $1$, on the other hand, we have a completely incompressible description and conclude, following Kolmogorov, Chaitin, and others, that $\cal O$ is random [^35] [^36] [^37] [^38] [^40] [^41]. This conclusion is the desired one: the Kolmogorov-Chaitin framework establishes, formally at least, the randomness of an individual object without appeals to probabilistic descriptions or to ensembles of reproducible events. And it does so by referring to a deterministic, algorithmic representation—the UTM.

There are many well-known difficulties with applying Kolmogorov complexity to natural processes. First, as a quantity, it is uncomputable in general, owing to the halting problem [^38]. Second, it is maximal for random sequences; this can be construed either as desirable, as just noted, or as a failure to capture structure, depending on one’s aims. Third, it only applies to a single sequence; again this is either good or bad. Fourth, it makes no allowance for noise or error, demanding exact reproduction. Finally, $\lim_{n\rightarrow\infty}|{\cal P}_{n}|/n$ can vanish, although the computational resources needed to run the program, such as time and storage, grow without bound.

None of these impediments have kept researchers from attempting to use Kolmogorov-Chaitin complexity for practical tasks—such as measuring the complexity of natural objects (e.g. Ref. [^42]), as a basis for theories of inductive inference [^43] [^44], and generally as a means of capturing patterns [^45]. As Rissanen [^46] says, this is akin to “learn\[ing\] the properties \[of a data set\] by writing programs in the hope of finding short ones!”

Various of the difficulties just listed have been addressed by subsequent work. Bennett’s logical depth accounts for time resources [^47]. (In fact, it is the time for the minimal-length program ${\cal P}$ to produce $\cal O$.) Koppel’s sophistication attempts to separate out the “regularity” portion of the program from the random or instance-specific input data [^48] [^49]. Ultimately, these extensions and generalizations remain in the UTM, exact-reproduction setting and so inherit inherent uncomputability.

### II.3 Patterns with Error

Motivated by these theoretical difficulties and practical concerns, an obvious next step is to allow our pattern ${\cal P}$ some degree of approximation or error, in exchange for shorter descriptions. As a result, we lose perfect reproduction of the original configuration from the pattern. Given the ubiquity of noise in nature, this is a small price to pay. We might also say that sometimes we are willing to accept small deviations from a regularity, without really caring what the precise deviation is. As pointed out in Ref. [^17] ’s conclusion, this is certainly a prime motivation in thermodynamic descriptions, in which we explicitly throw away, and have no interest in, vast amounts of microscopic detail in order to find a workable description of macroscopic observations.

Some interesting philosophical work on patterns-with-error has been done by Dennett, with reference not just to questions about the nature of patterns and their emergence but also to psychology [^50]. The intuition is that truly random processes can be modeled very simply—“to model coin-tossing, toss a coin.” Any prediction scheme that is more accurate than assuming complete independence ipso facto captures a pattern in the data. There is thus a spectrum of potential pattern-capturers ranging from the assumption of pure noise to the exact reproduction of the data, if that is possible. Dennett notes that there is generally a trade-off between the simplicity of a predictor and its accuracy, and he plausibly describes emergent phenomena [^51] [^52] as patterns that allow for a large reduction in complexity for only a small reduction in accuracy. Of course, Dennett was by no means the first to consider predictive schemes that tolerate error and noise; we discuss some of the earlier work in App. G. However, to our knowledge, he was the first to have made such predictors a central part of an explicit account of what patterns are. It must be noted that this account lacks the mathematical detail of the other approaches we have considered so far, and that it relies on the inexact prediction of a single configuration. In fact, it relies on exact predictors that are “fuzzed up” by noise. The introduction of noise, however, brings in probabilities, and their natural setting is in ensembles. It is in that setting that the ideas we share with Dennett can receive a proper quantitative treatment.

### II.4 Randomness: The Anti-Pattern?

We should at this point say a bit about the relations between randomness, complexity, and structure, at least as we use those words. Ignoring some foundational issues, randomness is actually rather well understood and well handled by classical tools introduced by Boltzmann [^53]; Fisher, Neyman, and Pearson [^54]; Kolmogorov [^35]; and Shannon [^55], among others. One tradition in the study of complexity in fact identifies complexity with randomness and, as we have just seen, this is useful for some purposes. As these purposes are not those of analyzing patterns in processes and in real-world data, however, they are not ours. Randomness simply does not correspond to a notion of pattern or structure at all and, by implication, neither Kolmogorov-Chaitin complexity nor any of its spawn measure pattern.

Nonetheless, some approaches to complexity conflate “structure” with the opposite of randomness, as conventionally understood and measured in physics by thermodynamic entropy or a related quantity, such as Shannon entropy. In effect, structure is defined as “one minus disorder”. In contrast, we see pattern—structure, organization, regularity, and so on—as describing a coordinate “orthogonal” to a process’s degree of randomness. That is, complexity (in our sense) and randomness each capture a useful property necessary to describe how a process manipulates information. This complementarity is even codified by the complexity-entropy diagrams introduced in Ref. [^6]. It should be clear now that when we use the word “complexity” we mean “degrees” of pattern, not degrees of randomness.

### II.5 Causation

We want our representations of patterns in dynamical processes to be causal—to say how one state of affairs leads to or produces another. Although a key property, causality enters our development only in an extremely weak sense, the weakest one can use mathematically, which is Hume’s [^56]: one class of event causes another if the latter always follows the former; the effect invariably succeeds the cause. As good indeterminists, in the following we replace this invariant-succession notion of causality with a more probabilistic one, substituting a homogeneous distribution of successors for the solitary invariable successor. (A precise statement appears in Sec. IV.1’s definition of causal states.) This approach results in a purely phenomenological statement of causality, and so it is amenable to experimentation in ways that stronger notions of causality—e.g., that of Ref. [^57] —are not. Ref. [^58] independently reaches a concept of causality essentially the same ours via philosophical arguments.

### II.6 Synopsis of Pattern

In line with these observations, the ideal, synthesizing approach to patterns would be at once:

1. Algebraic, giving us an explicit breakdown or decomposition of the pattern into its parts;
2. Computational, showing how the process stores and uses information;
3. Calculable, analytically or by systematic approximation;
4. Causal, telling us how instances of the pattern are actually produced; and
5. Naturally stochastic, not merely tolerant of noise but explicitly formulated in terms of ensembles.

This mix is precisely the brew we claim, in all modesty, to have on tap.

## III Patterns in Ensembles: Paddling around Occam’s Pool

Here a pattern ${\cal P}$ is something knowledge of which lets us predict, at better than chance rates, if possible, the future of sequences drawn from an ensemble ${\cal O}$: ${\cal P}$ has to be statistically accurate and confer some leverage or advantage as well. Let’s fix some notation and state the assumptions that will later let us prove the basic results.

### III.1 Hidden Processes

We restrict ourselves to discrete-valued, discrete-time stationary stochastic processes. (See Sec. VII.2 for discussion of these assumptions.) Intuitively, such processes are sequences of random variables $S_{i}$, the values of which are drawn from a countable set ${\cal A}$. We let $i$ range over all the integers, and so get a bi-infinite sequence

$$
\stackrel{{\scriptstyle\leftrightarrow}}{{S}}=\ldots S_{-1}S_{0}S_{1}\ldots~.
$$

In fact, we define a process in terms of the distribution of such sequences; cf. Ref. [^59].

###### Definition 1 (A Process)

Let ${\cal A}$ be a countable set. Let $\Omega={\cal A}^{\bf{\rm Z}}$ be the set of bi-infinite sequences composed from ${\cal A}$, $T_{i}:\Omega\mapsto{\cal A}$ be the function that returns the ${i}^{th}$ element ${s}_{i}$ of a bi-infinite sequence $\omega\in\Omega$, and ${\cal F}$ the field of cylinder sets of $\Omega$. Adding a probability measure ${\rm P}$ gives us a probability space $(\Omega,{\cal F},{\rm P})$, with an associated random variable $\stackrel{{\scriptstyle\leftrightarrow}}{{S}}$. A process is a sequence of random variables ${S}_{i}={T}_{i}(\stackrel{{\scriptstyle\leftrightarrow}}{{S}}),i\in{\mathbb{Z}}$.

Here, and throughout, we follow the convention of using capital letters to denote random variables and lower-case letters their particular values.

It follows from Def. 1 that there are well defined probability distributions for sequences of every finite length. Let ${\stackrel{{\scriptstyle\rightarrow}}{{S}}}_{t}^{L}$ be the sequence of $S_{t},S_{t+1},\ldots,S_{t+L-1}$ of $L$ random variables beginning at $S_{t}$. $\stackrel{{\scriptstyle\rightarrow}}{{S}}_{t}^{0}\equiv\lambda$, the null sequence. Likewise, ${\stackrel{{\scriptstyle\leftarrow}}{{S}}}_{t}^{L}$ denotes the sequence of $L$ random variables going up to $S_{t}$, but not including it; ${\stackrel{{\scriptstyle\leftarrow}}{{S}}}_{t}^{L}=\stackrel{{\scriptstyle\rightarrow}}{{S}}_{t-L}^{L}$. Both ${\stackrel{{\scriptstyle\rightarrow}}{{S}}}_{t}^{L}$ and ${\stackrel{{\scriptstyle\leftarrow}}{{S}}}_{t}^{L}$ take values from $s^{L}\in{\cal A}^{L}$. Similarly, $\stackrel{{\scriptstyle\rightarrow}}{{S}}_{t}$ and $\stackrel{{\scriptstyle\leftarrow}}{{S}}_{t}$ are the semi-infinite sequences starting from and stopping at $t$ and taking values $\stackrel{{\scriptstyle\rightarrow}}{{s}}$ and ${\stackrel{{\scriptstyle\leftarrow}}{{s}}}$, respectively.

Intuitively, we can imagine starting with distributions for finite-length sequences and extending them gradually in both directions, until the infinite sequence is reached as a limit. While this can be a useful picture to have in mind, defining a process in this way raises some subtle measure-theoretic issues, such as how finite-dimensional distributions limit on an infinite-dimensional one [^60]. To avoid these we start with the infinite-dimensional distribution.

###### Definition 2 (Stationarity)

A process $S_{i}$ is stationary if and only if

$$
{\rm P}({\stackrel{{\scriptstyle\rightarrow}}{{S}}}_{t}^{L}=s^{L})={\rm P}(\stackrel{{\scriptstyle\rightarrow}}{{S}}_{0}^{L}=s^{L})~,
$$

for all $t\in{\mathbb{Z}}$, $L\in{\mathbb{Z}}^{+}$, and all $s^{L}\in{\cal A}^{L}$.

In other words, a stationary process is one that is time-translation invariant. Consequently, ${\rm P}(\stackrel{{\scriptstyle\rightarrow}}{{S}}_{t}=\stackrel{{\scriptstyle\rightarrow}}{{s}})={\rm P}(\stackrel{{\scriptstyle\rightarrow}}{{S}}_{0}=\stackrel{{\scriptstyle\rightarrow}}{{s}})$ and ${\rm P}(\stackrel{{\scriptstyle\leftarrow}}{{S}}_{t}={\stackrel{{\scriptstyle\leftarrow}}{{s}}})={\rm P}(\stackrel{{\scriptstyle\leftarrow}}{{S}}_{0}={\stackrel{{\scriptstyle\leftarrow}}{{s}}})$, and so we drop the subscripts from now on.

### III.2 The Pool

Our goal is to predict all or part of $\stackrel{{\scriptstyle\rightarrow}}{{S}}$ using some function of some part of $\stackrel{{\scriptstyle\leftarrow}}{{S}}$. We begin by taking the set ${\stackrel{{\scriptstyle\leftarrow}}{{\rm{\bf S}}}}$ of all pasts and partitioning it into mutually exclusive and jointly comprehensive subsets. That is, we make a class $\boldsymbol{{\cal R}}$ of subsets of pasts.<sup>1</sup> (See Fig. 1 for a schematic example.) Each $\rho\in\boldsymbol{{\cal R}}$ will be called a state or an effective state. When the current history ${\stackrel{{\scriptstyle\leftarrow}}{{s}}}$ is included in the set $\rho$, we will speak of the process being in state $\rho$. Thus, we define a function from histories to effective states:

$$
\eta:{\stackrel{{\scriptstyle\leftarrow}}{{\rm{\bf S}}}}\mapsto\boldsymbol{{\cal R}}~.
$$

A specific individual history ${\stackrel{{\scriptstyle\leftarrow}}{{s}}}\in{\stackrel{{\scriptstyle\leftarrow}}{{\rm{\bf S}}}}$ maps to a specific state $\rho\in\boldsymbol{{\cal R}}$; the random variable $\stackrel{{\scriptstyle\leftarrow}}{{S}}$ for the past maps to the random variable ${\cal R}$ for the effective states. It makes little difference whether we think of $\eta$ as being a function from a history to a subset of histories or a function from a history to the label of that subset. Each interpretation is convenient at different times, and we will use both.

Note that we could use any function defined on ${\stackrel{{\scriptstyle\leftarrow}}{{\rm{\bf S}}}}$ to partition that set, by assigning to the same $\rho$ all the histories ${\stackrel{{\scriptstyle\leftarrow}}{{s}}}$ on which the function takes the same value. Similarly, any equivalence relation on ${\stackrel{{\scriptstyle\leftarrow}}{{\rm{\bf S}}}}$ partitions it. (See App. B for more on equivalence relations.) Due to the way we defined a process’s distribution, each effective state has a well defined distribution of futures, though not necessarily a unique one.<sup>2</sup> Specifying the effective state thus amounts to making a prediction about the process’s future. All the histories belonging to a given effective state are treated as equivalent for purposes of predicting the future. (In this way, the framework formally incorporates traditional methods of time-series analysis; see App. G.1.)

![Refer to caption](https://ar5iv.labs.arxiv.org/html/cond-mat/9907176/assets/OccamsPool.png)

Figure 1: A schematic picture of a partition of the set 𝐒 ← {\\stackrel{{\\scriptstyle\\leftarrow}}{{\\rm{\\bf S}}}} of all histories into some class of effective states: ℛ = { i: 1, 2 3 4 } \\boldsymbol{{\\cal R}}=\\{{\\cal R}\_{i}:i=1,2,3,4\\}. Note that the {\\cal R}\_{i} need not form compact sets; we simply draw them that way for clarity. One should have in mind Cantor sets or other more pathological structures.

We call the collection of all partitions $\boldsymbol{{\cal R}}$ of the set of histories ${\stackrel{{\scriptstyle\leftarrow}}{{\rm{\bf S}}}}$ Occam’s pool.

### III.3 A Little Information Theory

Since the bulk of the following development will be consumed with notions and results from information theory [^55], we now review several highlights briefly, for the benefit of readers unfamiliar with the theory and to fix notation. Appendix A lists a number of useful information-theoretic formulæ, which get called upon in our proofs. Throughout, our notation and style of proof follow those in Ref. [^62].

#### III.3.1 Entropy Defined

Given a random variable $X$ taking values in a countable set ${\cal A}$, the entropy of $X$ is

$$
\displaystyle H[X]
$$
 
$$
\displaystyle\equiv
$$
 
$$
\displaystyle-\sum_{x\in{\cal A}}{{\rm P}(X=x)\log_{2}{{\rm P}(X=x)}}~,
$$

taking $0\log{0}=0$. Notice that $H[X]$ is the expectation value of $-\log_{2}{{\rm P}(X=x)}$ and is measured in bits of information. Caveats of the form “when the sum converges to a finite value” are implicit in all statements about the entropies of infinite countable sets ${\cal A}$.

Shannon interpreted $H[X]$ as the uncertainty in $X$. (Those leery of any subjective component in notions like “uncertainty” may read “effective variability” in its place.) He showed, for example, that $H[X]$ is the mean number of yes-or-no questions needed to pick out the value of $X$ on repeated trials, if the questions are chosen to minimize this average [^55].

#### III.3.2 Joint and Conditional Entropies

We define the joint entropy $H[X,Y]$ of two variables $X$ (taking values in ${\cal A}$) and $Y$ (taking values in ${\cal B}$) in the obvious way,

$$
\displaystyle H
$$
 
$$
\displaystyle[X,Y]\equiv
$$
 
$$
\displaystyle-
$$
 
$$
\displaystyle\sum_{(x,y)\in{\cal A}\times{\cal B}}{{\rm P}(X=x{,\;}Y=y)\log_{2}{{\rm P}(X=x{,\;}Y=y)}}~.
$$

We define the conditional entropy $H[X|Y]$ of one random variable $X$ with respect to another $Y$ from their joint entropy:

$$
\displaystyle H[X|Y]
$$
 
$$
\displaystyle\equiv
$$
 
$$
\displaystyle H[X,Y]-H[Y]~.
$$

This also follows naturally from the definition of conditional probability, since ${\rm P}(X=x|Y=y)\equiv{\rm P}(X=x{,\;}Y=y)/{\rm P}(Y=y)$. $H[X|Y]$ measures the mean uncertainty remaining in $X$ once we know $Y$.

#### III.3.3 Mutual Information

The mutual information $I[X;Y]$ between two variables is defined to be

$$
\displaystyle I[X;Y]\equiv H[X]-H[X|Y]~.
$$

This is the average reduction in uncertainty about $X$ produced by fixing $Y$. It is non-negative, like all entropies here, and symmetric in the two variables.

### III.4 Patterns in Ensembles

It will be convenient to have a way of talking about the uncertainty of the future. Intuitively, this would just be $H[\stackrel{{\scriptstyle\rightarrow}}{{S}}]$, but in general that quantity is infinite and awkward to manipulate. (The special case in which $H[\stackrel{{\scriptstyle\rightarrow}}{{S}}]$ is finite is dealt with in App. F.) Normally, we evade this by considering $H[{\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{L}]$, the uncertainty of the next $L$ symbols, treated as a function of $L$. On occasion, we will refer to the entropy per symbol or entropy rate [^55] [^62]:

$$
\displaystyle h[\stackrel{{\scriptstyle\rightarrow}}{{S}}]
$$
 
$$
\displaystyle\equiv
$$
 
$$
\displaystyle\lim_{L\rightarrow\infty}{{1\over L}H[{\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{L}]}~,
$$

and the conditional entropy rate,

$$
\displaystyle h[\stackrel{{\scriptstyle\rightarrow}}{{S}}|X]
$$
 
$$
\displaystyle\equiv
$$
 
$$
\displaystyle\lim_{L\rightarrow\infty}{{1\over L}H[{\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{L}|X]}~,
$$

where $X$ is some random variable and the limits exist. For stationary stochastic processes, the limits always exist [^62].

These entropy rates are also always bounded above by $H[S]$; which is a special case of Eq. (85). Moreover, if $h[\stackrel{{\scriptstyle\rightarrow}}{{S}}]=H[S]$, the process consists of independent variables—independent, identically distributed (IID) variables, in fact, since we are only concerned with stationary processes here.

###### Definition 3 (Capturing a Pattern)

$\boldsymbol{{\cal R}}$ captures a pattern if and only if there exists an $L$ such that

$$
H[{\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{L}|{\cal R}]<LH[S]~.
$$

This says that $\boldsymbol{{\cal R}}$ captures a pattern when it tells us something about how the distinguishable parts of a process affect each other: $\boldsymbol{{\cal R}}$ exhibits their dependence. (We also speak of $\eta$, the function associated with pasts, as capturing a pattern, since this is implied by $\boldsymbol{{\cal R}}$ capturing a pattern.) Supposing that these parts do not affect each other, then we have IID random variables, which is as close to the intuitive notion of “patternless” as one is likely to state mathematically. Note that, because of the independence bound on joint entropies (Eq. (85)), if the inequality is satisfied for some $L$, it is also satisfied for every ${L}^{\prime}>L$. Thus, we can consider the difference $H[S]-H[{\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{L}|{\cal R}]/L$, for the smallest $L$ for which it is nonzero, as the strength of the pattern captured by $\boldsymbol{{\cal R}}$. We will now mark an upper bound (Lemma 12) on the strength of patterns; later we will show how to attain this upper bound (Thm. 42).

### III.5 The Lessons of History

We are now in a position to prove a result about patterns in ensembles that will be useful in connection with our later theorems about causal states.

###### Lemma 1 (Old Country Lemma)

For all $\boldsymbol{{\cal R}}$ and for all $L\in{\mathbb{Z}}^{+}$,

$$
H[{\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{L}|{\cal R}]\geq H[{\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{L}|\stackrel{{\scriptstyle\leftarrow}}{{S}}]~.
$$

Proof. By construction (Eq. (4)), for all $L$,

$$
H[{\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{L}|{\cal R}]=H[{\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{L}|\eta(\stackrel{{\scriptstyle\leftarrow}}{{S}})]~.
$$

But

$$
H[{\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{L}|\eta(\stackrel{{\scriptstyle\leftarrow}}{{S}})]\geq H[{\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{L}|\stackrel{{\scriptstyle\leftarrow}}{{S}}]~,
$$

since the entropy conditioned on a variable is never more than the entropy conditioned on a function of the variable (Eq. (96)). QED.

Remark 1. That is, conditioning on the whole of the past reduces the uncertainty in the future to as small a value as possible. Carrying around the whole semi-infinite past is rather bulky and uncomfortable and is a somewhat dismaying prospect. Put a bit differently: we want to forget as much of the past as possible and so reduce its burden. It is the contrast between this desire and the result of Eq. (12) that leads us to call this the Old Country Lemma.

Remark 2. Lemma 12 establishes the promised upper bound on the strength of patterns: viz., the strength of the pattern is at most $H[S]-H[{\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{L}|\stackrel{{\scriptstyle\leftarrow}}{{S}}]/{L}_{past}$, where ${L}_{past}$ is the least value of $L$ such that $H[{\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{L}|\stackrel{{\scriptstyle\leftarrow}}{{S}}]<LH[S]$.

### III.6 Minimality and Prediction

Let’s invoke Occam’s Razor: “It is vain to do with more what can be done with less” [^63]. To use the razor, we need to fix what is to be “done” and what “more” and “less” mean. The job we want done is accurate prediction, i.e., reducing the conditional entropies $H[{\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{L}|{\cal R}]$ as far as possible, the goal being to attain the bound set by Lemma 12. But we want to do this as simply as possible, with as few resources as possible. On the road to meeting these two constraints—minimal uncertainty and minimal resources—we will need a measure of the second. Since ${\rm P}(\stackrel{{\scriptstyle\leftarrow}}{{S}}={\stackrel{{\scriptstyle\leftarrow}}{{s}}})$ is well defined, there is an induced measure on the $\eta$ -states; i.e., ${\rm P}({\cal R}=\rho)$, the probability of being in any particular effective state, is well defined. Accordingly, we define the following measure of resources.

###### Definition 4

(Complexity of State Classes) The statistical complexity of a class $\boldsymbol{{\cal R}}$ of states is

$$
\displaystyle C_{\mu}(\boldsymbol{{\cal R}})
$$
 
$$
\displaystyle\equiv
$$
 
$$
\displaystyle H[{\cal R}]
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle-\sum_{\rho\in{\cal R}}{\rm P}({\cal R}=\rho)\log_{2}{\rm P}({\cal R}=\rho)~,
$$

when the sum converges to a finite value.

The $\mu$ in $C_{\mu}$ reminds us that it is a measure-theoretic property and depends ultimately on the distribution over the process’s sequences, which induces a measure over states.

The statistical complexity of a state class is the average uncertainty (in bits) in the process’s current state. This, in turn, is the same as the average amount of memory (in bits) that the process appears to retain about the past, given the chosen state class $\boldsymbol{{\cal R}}$. (We will later, in Def. 12, see how to define the statistical complexity of a process itself.) The goal is to do with as little of this memory as possible. Restated then, we want to minimize statistical complexity, subject to the constraint of maximally accurate prediction.

The idea behind calling the collection of all partitions of ${\stackrel{{\scriptstyle\leftarrow}}{{\rm{\bf S}}}}$ Occam’s pool should now be clear: One wants to find the shallowest point in the pool. This we now do.

## IV Computational Mechanics

> Those who are good at archery learnt from the bow and not from Yi the Archer. Those who know how to manage boats learnt from the boats and not from Wo.  
>   
> —Anonymous in Ref. [^64].

The ultimate goal of computational mechanics is to discern the patterns intrinsic to a process. That is, as much as possible, the goal is to let the process describe itself, on its own terms, without appealing to a priori assumptions about the process’s structure. Here we simply explore the consistency and well-definedness of these goals. Of course, practical constraints may keep us from doing more than approximating these ideals more or less grossly. Naturally, such problems, which always turn up in implementation, are much easier to address if we start from secure foundations.

### IV.1 Causal States

###### Definition 5

(A Process’s Causal States) The causal states of a process are the members of the range of the function $\epsilon:{\stackrel{{\scriptstyle\leftarrow}}{{\rm{\bf S}}}}\mapsto 2^{\stackrel{{\scriptstyle\leftarrow}}{{\rm{\bf S}}}}$ —the power set of ${\stackrel{{\scriptstyle\leftarrow}}{{\rm{\bf S}}}}$:

$$
\displaystyle\epsilon({\stackrel{{\scriptstyle\leftarrow}}{{s}}})\equiv\{{\stackrel{{\scriptstyle\leftarrow}}{{s}}}^{\prime}|{\rm P}(\stackrel{{\scriptstyle\rightarrow}}{{S}}=\stackrel{{\scriptstyle\rightarrow}}{{s}}
$$
 
$$
\displaystyle|
$$
 
$$
\displaystyle\stackrel{{\scriptstyle\leftarrow}}{{S}}={\stackrel{{\scriptstyle\leftarrow}}{{s}}})={\rm P}(\stackrel{{\scriptstyle\rightarrow}}{{S}}=\stackrel{{\scriptstyle\rightarrow}}{{s}}|\stackrel{{\scriptstyle\leftarrow}}{{S}}={\stackrel{{\scriptstyle\leftarrow}}{{s}}}^{\prime})~,
$$
$$
\displaystyle{\rm for~all}\stackrel{{\scriptstyle\rightarrow}}{{s}}\in\stackrel{{\scriptstyle\rightarrow}}{{S}},{\stackrel{{\scriptstyle\leftarrow}}{{s}}}^{\prime}\in\stackrel{{\scriptstyle\leftarrow}}{{S}}\}~,
$$

that maps from histories to sets of histories. We write the $i^{th}$ causal state as ${\cal S}_{i}$ and the set of all causal states as $\boldsymbol{{\cal S}}$; the corresponding random variable is denoted ${\cal S}$, and its realization $\sigma$.

The cardinality of $\boldsymbol{{\cal S}}$ is unspecified. $\boldsymbol{{\cal S}}$ can be finite, countably infinite, a continuum, a Cantor set, or something stranger still. Examples of these are given in Refs. [^5] and [^10]; see especially the examples for hidden Markov models given there.

Alternately and equivalently, we could define an equivalence relation ${\sim}_{\epsilon}$ such that two histories are equivalent if and only if they have the same conditional distribution of futures, and then define causal states as the equivalence classes generated by ${\sim}_{\epsilon}$. (In fact, this was the original approach [^6].) Either way, the divisions of this partition of ${\stackrel{{\scriptstyle\leftarrow}}{{\rm{\bf S}}}}$ are made between regions that leave us in different conditions of ignorance about the future.

This last statement suggests another, still equivalent, description of $\epsilon$:

$$
\displaystyle\epsilon({\stackrel{{\scriptstyle\leftarrow}}{{s}}})=\{{\stackrel{{\scriptstyle\leftarrow}}{{s}}}^{\prime}|{\rm P}({\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{L}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle{\stackrel{{\scriptstyle\rightarrow}}{{s}}}^{L}|\stackrel{{\scriptstyle\leftarrow}}{{S}}={\stackrel{{\scriptstyle\leftarrow}}{{s}}})={\rm P}({\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{L}={\stackrel{{\scriptstyle\rightarrow}}{{s}}}^{L}|\stackrel{{\scriptstyle\leftarrow}}{{S}}={\stackrel{{\scriptstyle\leftarrow}}{{s}}}^{\prime})~,
$$
$$
\displaystyle{\stackrel{{\scriptstyle\rightarrow}}{{s}}}^{L}\in{\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{L},
$$
$$
\displaystyle{\stackrel{{\scriptstyle\leftarrow}}{{s}}}^{\prime}\in\stackrel{{\scriptstyle\leftarrow}}{{S}}~,L\in{\mathbb{Z}}^{+}\}~.
$$

Using this we can make the original definition, Eq. (16), more intuitive by picturing a sequence of partitions of the space ${\stackrel{{\scriptstyle\leftarrow}}{{\rm{\bf S}}}}$ of all histories in which each new partition, induced using $L+1$, is a refinement of the previous one induced using $L$. At the coarsest level, the first partition ($L=1$) groups together those histories that have the same distribution for the very next observable. These classes are then subdivided using the distribution of the next two observables, then the next three, four, and so on. The limit of this sequence of partitions—the point at which every member of each class has the same distribution of futures, of whatever length, as every other member of that class—is the partition of ${\stackrel{{\scriptstyle\leftarrow}}{{\rm{\bf S}}}}$ induced by ${\sim}_{\epsilon}$. See App. B for a detailed discussion and review of the equivalence relation ${\sim}_{\epsilon}$.

Although they will not be of direct concern in the following, due to the time-asymptotic limits taken, there are transient causal states in addition to those (recurrent) causal states defined above in Eq. (16). Roughly speaking, the transient causal states describe how a lengthening sequence (a history) of observations allows us to identify the recurrent causal states with increasing precision. See the developments in App. B and in Refs. [^10] and [^65] for more detail on transient causal states.

Causal states are a particular kind of effective state, and they have all the properties common to effective states (Sec. III.2). In particular, each causal state ${\cal S}_{i}$ has several structures attached:

1. The index $i$ —the state’s “name”.
2. The set of histories that have brought the process to ${\cal S}_{i}$, which we denote $\{{\stackrel{{\scriptstyle\leftarrow}}{{s}}}\in{\cal S}_{i}\}$.
3. A conditional distribution over futures, denoted ${\rm P}(\stackrel{{\scriptstyle\rightarrow}}{{S}}|{\cal S}_{i})$, and equal to ${\rm P}(\stackrel{{\scriptstyle\rightarrow}}{{S}}|{\stackrel{{\scriptstyle\leftarrow}}{{s}}}),{\stackrel{{\scriptstyle\leftarrow}}{{s}}}\in{\cal S}_{i}$. Since we refer to this type of distribution frequently and since it is the “shape of the future”, we call it the state’s morph.

Ideally, each of these should be denoted by a different symbol, and there should be distinct functions linking each of these structures to their causal state. To keep the growth of notation under control, however, we shall be strategically vague about these distinctions. Readers may variously picture $\epsilon$ as mapping histories to (i) simple indices, (ii) subsets of histories, or (iii) ordered triples of indices, subsets, and morphs; or one may even leave $\epsilon$ uninterpreted, as preferred, without interfering with the development that follows.

![Refer to caption](https://ar5iv.labs.arxiv.org/html/cond-mat/9907176/assets/EpsilonPartition.png)

Figure 2: A schematic representation of the partitioning of the set 𝐒 ← {\\stackrel{{\\scriptstyle\\leftarrow}}{{\\rm{\\bf S}}}} of all histories into causal states 𝒮 i ∈ {\\cal S}\_{i}\\in\\boldsymbol{{\\cal S}}. Within each causal state all the individual histories s {\\stackrel{{\\scriptstyle\\leftarrow}}{{s}}} have the same morph—the same conditional distribution P ( S → | ) {\\rm P}(\\stackrel{{\\scriptstyle\\rightarrow}}{{S}}|{\\stackrel{{\\scriptstyle\\leftarrow}}{{s}}}) for future observables.

#### IV.1.1 Morphs

Each causal state has a unique morph, i.e., no two causal states have the same conditional distribution of futures. This follows directly from Def. 5, and it is not true of effective states in general. Another immediate consequence of that definition is that

$$
{\rm P}(\stackrel{{\scriptstyle\rightarrow}}{{S}}=\stackrel{{\scriptstyle\rightarrow}}{{s}}|{\cal S}=\epsilon({\stackrel{{\scriptstyle\leftarrow}}{{s}}}))={\rm P}(\stackrel{{\scriptstyle\rightarrow}}{{S}}=\stackrel{{\scriptstyle\rightarrow}}{{s}}|\stackrel{{\scriptstyle\leftarrow}}{{S}}={\stackrel{{\scriptstyle\leftarrow}}{{s}}}).
$$

(Again, this is not generally true of effective states.) This observation lets us prove a useful lemma about the conditional independence of the past $\stackrel{{\scriptstyle\leftarrow}}{{S}}$ and the future $\stackrel{{\scriptstyle\rightarrow}}{{S}}$.

###### Lemma 2

The past and the future are independent, conditioning on the causal states.

Proof. Recall that two random variables $X$ and $Z$ are conditionally independent if and only if there is a third variable $Y$ such that

$$
\displaystyle{\rm P}(X
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle x{,\;}Y=y{,\;}Z=z)
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle{\rm P}(X=x|Y=y){\rm P}(Z=z|Y=y){\rm P}(Y=y)~.
$$

That is, all of the dependence of $Z$ on $X$ is mediated by $Y$. For convenience below we note that, re-factoring the conditional probabilities, this is equivalent to the requirement that:

$$
\displaystyle{\rm P}(X
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle x{,\;}Y=y{,\;}Z=z)
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle{\rm P}(Z=z|Y=y){\rm P}(Y=y|X=x){\rm P}(X=x)~.
$$

Let us consider ${\rm P}(\stackrel{{\scriptstyle\leftarrow}}{{S}}={\stackrel{{\scriptstyle\leftarrow}}{{s}}}{,\;}{\cal S}=\sigma{,\;}\stackrel{{\scriptstyle\rightarrow}}{{S}}=\stackrel{{\scriptstyle\rightarrow}}{{s}})$.

$$
\displaystyle{\rm P}
$$
 
$$
\displaystyle(
$$
$$
\displaystyle\stackrel{{\scriptstyle\leftarrow}}{{S}}={\stackrel{{\scriptstyle\leftarrow}}{{s}}}{,\;}{\cal S}=\sigma{,\;}\stackrel{{\scriptstyle\rightarrow}}{{S}}=\stackrel{{\scriptstyle\rightarrow}}{{s}})
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle{\rm P}(\stackrel{{\scriptstyle\rightarrow}}{{S}}=\stackrel{{\scriptstyle\rightarrow}}{{s}}|{\cal S}=\sigma{,\;}\stackrel{{\scriptstyle\leftarrow}}{{S}}={\stackrel{{\scriptstyle\leftarrow}}{{s}}}){\rm P}({\cal S}=\sigma{,\;}\stackrel{{\scriptstyle\leftarrow}}{{S}}={\stackrel{{\scriptstyle\leftarrow}}{{s}}})
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle{\rm P}(\stackrel{{\scriptstyle\rightarrow}}{{S}}=\stackrel{{\scriptstyle\rightarrow}}{{s}}|{\cal S}=\sigma{,\;}\stackrel{{\scriptstyle\leftarrow}}{{S}}={\stackrel{{\scriptstyle\leftarrow}}{{s}}}){\rm P}({\cal S}=\sigma|\stackrel{{\scriptstyle\leftarrow}}{{S}}={\stackrel{{\scriptstyle\leftarrow}}{{s}}}){\rm P}(\stackrel{{\scriptstyle\leftarrow}}{{S}}={\stackrel{{\scriptstyle\leftarrow}}{{s}}})~.
$$

Now, ${\rm P}({\cal S}=\sigma|\stackrel{{\scriptstyle\leftarrow}}{{S}}={\stackrel{{\scriptstyle\leftarrow}}{{s}}})=0$, unless $\sigma=\epsilon({\stackrel{{\scriptstyle\leftarrow}}{{s}}})$, which case ${\rm P}({\cal S}=\sigma|\stackrel{{\scriptstyle\leftarrow}}{{S}}={\stackrel{{\scriptstyle\leftarrow}}{{s}}})=1$. Either way, the first two factors in the last line of Eq. (21) can be written, by Eq. (18),

$$
\displaystyle{\rm P}
$$
 
$$
\displaystyle(
$$
$$
\displaystyle\stackrel{{\scriptstyle\rightarrow}}{{S}}=\stackrel{{\scriptstyle\rightarrow}}{{s}}|{\cal S}=\sigma{,\;}\stackrel{{\scriptstyle\leftarrow}}{{S}}={\stackrel{{\scriptstyle\leftarrow}}{{s}}}){\rm P}({\cal S}=\sigma|\stackrel{{\scriptstyle\leftarrow}}{{S}}={\stackrel{{\scriptstyle\leftarrow}}{{s}}})
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle{\rm P}(\stackrel{{\scriptstyle\rightarrow}}{{S}}=\stackrel{{\scriptstyle\rightarrow}}{{s}}|{\cal S}=\sigma){\rm P}({\cal S}=\sigma|\stackrel{{\scriptstyle\leftarrow}}{{S}}={\stackrel{{\scriptstyle\leftarrow}}{{s}}})~,
$$

so that, substituting Eq. (22) into Eq. (21),

$$
\displaystyle{\rm P}
$$
 
$$
\displaystyle(
$$
$$
\displaystyle\stackrel{{\scriptstyle\leftarrow}}{{S}}={\stackrel{{\scriptstyle\leftarrow}}{{s}}}{,\;}{\cal S}=\sigma{,\;}\stackrel{{\scriptstyle\rightarrow}}{{S}}=\stackrel{{\scriptstyle\rightarrow}}{{s}})
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle{\rm P}(\stackrel{{\scriptstyle\rightarrow}}{{S}}=\stackrel{{\scriptstyle\rightarrow}}{{s}}|{\cal S}=\sigma){\rm P}({\cal S}=\sigma|\stackrel{{\scriptstyle\leftarrow}}{{S}}={\stackrel{{\scriptstyle\leftarrow}}{{s}}}){\rm P}(\stackrel{{\scriptstyle\leftarrow}}{{S}}={\stackrel{{\scriptstyle\leftarrow}}{{s}}})~.
$$

QED.

#### IV.1.2 Homogeneity

Following Ref. [^58], we introduce two new definitions and a lemma which are required later on, especially in the proof of Lemma 7 and the theorems depending on that lemma.

###### Definition 6

(Strict Homogeneity) A set $\bf X$ is strictly homogeneous with respect to a certain random variable $Y$ when the conditional distribution ${\rm P}(Y|{\bf X})$ for $Y$ is the same for all subsets of $\bf X$.

###### Definition 7

(Weak Homogeneity) A set $\bf X$ is weakly homogeneous with respect to $Y$ if $\bf X$ is not strictly homogeneous with respect to $Y$, but ${\bf X}\setminus{\bf X}_{0}$ ($\bf X$ with ${\bf X}_{0}$ removed) is, where ${\bf X}_{0}$ is a subset of $\bf X$ of measure $0$.

###### Lemma 3

(Strict Homogeneity of Causal States) A process’s causal states are the largest subsets of histories that are all strictly homogeneous with respect to futures of all lengths.

Proof. We must show that, first, the causal states are strictly homogeneous with respect to futures of all lengths and, second, that no larger strictly homogeneous subsets of histories could be made. The first point, the strict homogeneity of the causal states, is evident from Eq. (17): By construction, all elements of a causal state have the same morph, so any part of a causal state will have the same morph as the whole state. The second point likewise follows from Eq. (17), since the causal state by construction contains all the histories with a given morph. Any other set strictly homogeneous with respect to futures must be smaller than a causal state, and any set that includes a causal state as a proper subset cannot be strictly homogeneous. QED.

Remark. The statistical explanation literature would say that causal states are the “statistical-relevance basis for causal explanations”. The elements of such a basis are, precisely, the largest classes of combinations of independent variables with homogeneous distributions for the dependent variables. See Ref. [^58] for further discussion along these lines.

### IV.2 Causal State-to-State Transitions

The causal state at any given time and the next value of the observed process together determine a new causal state; this is proved shortly in Lemma. Thus, there is a natural relation of succession among the causal states; recall the discussion of causality in Sec. II.5. Moreover, given the current causal state, all the possible next values have well defined conditional probabilities. In fact, by construction the entire semi-infinite future does. Thus, there is a well defined probability ${T}_{ij}^{(s)}$ of the process generating the value $s\in{\cal A}$ and going to causal state ${\cal S}_{j}$, if it is in state ${\cal S}_{i}$.

###### Definition 8

(Causal Transitions) The labeled transition probability $T_{ij}^{(s)}$ is the probability of making the transition from state ${\cal S}_{i}$ to state ${\cal S}_{j}$ while emitting the symbol $s\in{\cal A}$:

$$
T_{ij}^{(s)}\equiv{\rm P}({\cal S}^{\prime}={\cal S}_{j}{,\;}\stackrel{{\scriptstyle\rightarrow}}{{S}}^{1}=s|{\cal S}={\cal S}_{i})~,
$$

where ${\cal S}$ is the current causal state and ${\cal S}^{\prime}$ its successor on emitting $s$. We denote the set $\{T_{ij}^{(s)}:s\in{\cal A}\}$ by $\bf T$.

###### Lemma 4 (Transition Probabilities)

$T_{ij}^{(s)}$ is given by

$$
\displaystyle T_{ij}^{(s)}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle{\rm P}({\stackrel{{\scriptstyle\leftarrow}}{{s}}}s\in{{\cal S}}_{j}|{\stackrel{{\scriptstyle\leftarrow}}{{s}}}\in{{\cal S}}_{i})
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle{{\rm P}({\stackrel{{\scriptstyle\leftarrow}}{{s}}}\in{{\cal S}}_{i}{,\;}{\stackrel{{\scriptstyle\leftarrow}}{{s}}}s\in{{\cal S}}_{j})\over{\rm P}({\stackrel{{\scriptstyle\leftarrow}}{{s}}}\in{{\cal S}}_{i})}~,
$$

where ${\stackrel{{\scriptstyle\leftarrow}}{{s}}}s$ is read as the semi-infinite sequence obtained by concatenating $s\in{\cal A}$ onto the end of ${\stackrel{{\scriptstyle\leftarrow}}{{s}}}$.

Proof.

$$
\displaystyle T^{(s)}_{ij}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle{\rm P}({\cal S}^{\prime}={\cal S}_{j}{,\;}\stackrel{{\scriptstyle\rightarrow}}{{S}}^{1}=s|{\cal S}={\cal S}_{i})
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle{{\rm P}({\cal S}^{\prime}={\cal S}_{j}{,\;}\stackrel{{\scriptstyle\rightarrow}}{{S}}^{1}=s{,\;}{\cal S}={\cal S}_{i})}\over{{\rm P}({\cal S}={\cal S}_{i})}~.
$$

Now ${\cal S}={\cal S}_{i}$ if and only if ${\stackrel{{\scriptstyle\leftarrow}}{{s}}}\in{\cal S}_{i}$, and ${\cal S}^{\prime}={\cal S}_{j}$ if and only ${\stackrel{{\scriptstyle\leftarrow}}{{s}}}^{\prime}\in{\cal S}_{j}$, where by ${\stackrel{{\scriptstyle\leftarrow}}{{s}}}^{\prime}$ we mean the history that is the immediate successor to ${\stackrel{{\scriptstyle\leftarrow}}{{s}}}$; for consistency, ${\stackrel{{\scriptstyle\leftarrow}}{{s}}}^{\prime}={\stackrel{{\scriptstyle\leftarrow}}{{s}}}s$. So we can rewrite Eq. (28) as

$$
\displaystyle T^{(s)}_{ij}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle{{\rm P}({\stackrel{{\scriptstyle\leftarrow}}{{s}}}\in{\cal S}_{i}{,\;}\stackrel{{\scriptstyle\rightarrow}}{{S}}^{1}=s{,\;}{\stackrel{{\scriptstyle\leftarrow}}{{s}}}^{\prime}\in{\cal S}_{j})}\over{{\rm P}({\cal S}={\cal S}_{i})}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle{{\rm P}({\stackrel{{\scriptstyle\leftarrow}}{{s}}}\in{\cal S}_{i}{,\;}\stackrel{{\scriptstyle\rightarrow}}{{S}}^{1}=s{,\;}{\stackrel{{\scriptstyle\leftarrow}}{{s}}}s\in{\cal S}_{j})}\over{{\rm P}({\cal S}={\cal S}_{i})}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle{{\rm P}({\stackrel{{\scriptstyle\leftarrow}}{{s}}}\in{\cal S}_{i}{,\;}{\stackrel{{\scriptstyle\leftarrow}}{{s}}}s\in{\cal S}_{j})}\over{{\rm P}({\cal S}={\cal S}_{i})}~.
$$

In the third line we used the fact that $\stackrel{{\scriptstyle\leftarrow}}{{S}}={\stackrel{{\scriptstyle\leftarrow}}{{s}}}$ and $\stackrel{{\scriptstyle\leftarrow}}{{S}}^{\prime}={\stackrel{{\scriptstyle\leftarrow}}{{s}}}s$ jointly imply $\stackrel{{\scriptstyle\rightarrow}}{{S}}^{1}=s$, making that condition redundant. QED.

Notice that $T_{ij}^{(\lambda)}=\delta_{ij}$; that is, the transition labeled by the null symbol $\lambda$ is the identity.

### IV.3 ϵ\\epsilon-Machines

The combination of the function $\epsilon$ from histories to causal states with the labeled transition probabilities $T_{ij}^{(s)}$ is called the $\epsilon$ -machine of the process [^5] [^6].

###### Definition 9 (An ϵ\\epsilon-Machine Defined)

The $\epsilon$ -machine of a process is the ordered pair $\{\epsilon,{\bf T}\}$, where $\epsilon$ is the causal state function and $\bf T$ is set of the transition matrices for the states defined by $\epsilon$.

Equivalently, we may denote an $\epsilon$ -machine by $\{\boldsymbol{{\cal S}},{\bf T}\}$.

To satisfy the algebraic requirement outlined in Sec. II.6, we make explicit the connection with semi-group theory.

###### Proposition 1 (ϵ\\epsilon-Machines Are Monoids)

The algebra generated by the $\epsilon$ -machine $\{\epsilon,{\bf T}\}$ is a semi-group with an identity element, i.e., it is a monoid.

Proof.SeeApp. D.

Remark.Duetothis,ϵ $-machinescanbeinterpretedascapturingaprocess^{\prime}s{generalizedsymmetries}.Anysubgroupsofan$ ϵ $-machine^{\prime}ssemi-groupare,infact,symmetriesinthemorefamiliarsense.\par\begin{lemma}{\bf($\epsilon$-Machines Are Deterministic)}
For each ${\cal S}_{i}$ and $s\in{\cal A}$, ${T}^{(s)}_{ij}>0$ only
for that ${\cal S}_{j}$ for which $\epsilon({\stackrel{{\scriptstyle\leftarrow}}{{s}}}\!s)={\cal S}_{j}$
if and only if $\epsilon({\stackrel{{\scriptstyle\leftarrow}}{{s}}})={\cal S}_{i}$, for all pasts ${\stackrel{{\scriptstyle\leftarrow}}{{s}}}$.
\end{lemma}$

Proof. The lemma is equivalent to asserting that for all $s\in{\cal A}$ and ${\stackrel{{\scriptstyle\leftarrow}}{{s}}},{{\stackrel{{\scriptstyle\leftarrow}}{{s}}}}^{\prime}\in{\stackrel{{\scriptstyle\leftarrow}}{{\rm{\bf S}}}}$, if $\epsilon({\stackrel{{\scriptstyle\leftarrow}}{{s}}})=\epsilon({{\stackrel{{\scriptstyle\leftarrow}}{{s}}}}^{\prime})$, then $\epsilon({\stackrel{{\scriptstyle\leftarrow}}{{s}}}\!s)=\epsilon({{\stackrel{{\scriptstyle\leftarrow}}{{s}}}}^{\prime}\!s)$. (${\stackrel{{\scriptstyle\leftarrow}}{{s}}}\!s$ is just another history and belongs to one or another causal state.)

Suppose this were not true. Then there would have to exist at least one future $\stackrel{{\scriptstyle\rightarrow}}{{s}}$ such that

$$
\displaystyle{\rm P}(\stackrel{{\scriptstyle\rightarrow}}{{S}}=\stackrel{{\scriptstyle\rightarrow}}{{s}}|\stackrel{{\scriptstyle\leftarrow}}{{S}}={\stackrel{{\scriptstyle\leftarrow}}{{s}}}\!s)
$$
 
$$
\displaystyle\neq
$$
 
$$
\displaystyle{\rm P}(\stackrel{{\scriptstyle\rightarrow}}{{S}}=\stackrel{{\scriptstyle\rightarrow}}{{s}}|\stackrel{{\scriptstyle\leftarrow}}{{S}}={\stackrel{{\scriptstyle\leftarrow}}{{s}}}^{\prime}\!s)~,
$$

when nonetheless $\epsilon({\stackrel{{\scriptstyle\leftarrow}}{{s}}})=\epsilon({\stackrel{{\scriptstyle\leftarrow}}{{s}}}^{\prime})$. Equivalently, we would have

$$
{{\rm P}(\stackrel{{\scriptstyle\leftrightarrow}}{{S}}={\stackrel{{\scriptstyle\leftarrow}}{{s}}}\!s\!\stackrel{{\scriptstyle\rightarrow}}{{s}})\over{\rm P}(\stackrel{{\scriptstyle\leftarrow}}{{S}}={\stackrel{{\scriptstyle\leftarrow}}{{s}}}\!s)}\neq{{\rm P}(\stackrel{{\scriptstyle\leftrightarrow}}{{S}}={\stackrel{{\scriptstyle\leftarrow}}{{s}}}^{\prime}\!s\!\stackrel{{\scriptstyle\rightarrow}}{{s}})\over{\rm P}(\stackrel{{\scriptstyle\leftarrow}}{{S}}={\stackrel{{\scriptstyle\leftarrow}}{{s}}}^{\prime}\!s)}~,
$$

where we read $s\!\stackrel{{\scriptstyle\rightarrow}}{{s}}$ as the semi-infinite string that begins $s$ and continues $\stackrel{{\scriptstyle\rightarrow}}{{s}}$. (Remember, the point at which we break the stochastic process into a past and a future is arbitrary.) However, the probabilities in the denominators are equal to ${\rm P}(\stackrel{{\scriptstyle\rightarrow}}{{S}}^{1}=s|\stackrel{{\scriptstyle\leftarrow}}{{S}}={\stackrel{{\scriptstyle\leftarrow}}{{s}}}){\rm P}(\stackrel{{\scriptstyle\leftarrow}}{{S}}={\stackrel{{\scriptstyle\leftarrow}}{{s}}})$ and ${\rm P}(\stackrel{{\scriptstyle\rightarrow}}{{S}}^{1}=s|\stackrel{{\scriptstyle\leftarrow}}{{S}}={\stackrel{{\scriptstyle\leftarrow}}{{s}}}^{\prime}){\rm P}(\stackrel{{\scriptstyle\leftarrow}}{{S}}={\stackrel{{\scriptstyle\leftarrow}}{{s}}}^{\prime})$, respectively, and by assumption ${\rm P}(\stackrel{{\scriptstyle\rightarrow}}{{S}}^{1}=s|\stackrel{{\scriptstyle\leftarrow}}{{S}}={\stackrel{{\scriptstyle\leftarrow}}{{s}}}^{\prime})={\rm P}(\stackrel{{\scriptstyle\rightarrow}}{{S}}^{1}=s|\stackrel{{\scriptstyle\leftarrow}}{{S}}={\stackrel{{\scriptstyle\leftarrow}}{{s}}})$, since $\epsilon({\stackrel{{\scriptstyle\leftarrow}}{{s}}}^{\prime})=\epsilon({\stackrel{{\scriptstyle\leftarrow}}{{s}}})$. Therefore, we would need

$$
{{\rm P}(\stackrel{{\scriptstyle\leftrightarrow}}{{S}}={\stackrel{{\scriptstyle\leftarrow}}{{s}}}s\stackrel{{\scriptstyle\rightarrow}}{{s}})\over{\rm P}(\stackrel{{\scriptstyle\leftarrow}}{{S}}={\stackrel{{\scriptstyle\leftarrow}}{{s}}})}\neq{{\rm P}(\stackrel{{\scriptstyle\leftrightarrow}}{{S}}={\stackrel{{\scriptstyle\leftarrow}}{{s}}}^{\prime}\!s\!\stackrel{{\scriptstyle\rightarrow}}{{s}})\over{\rm P}(\stackrel{{\scriptstyle\leftarrow}}{{S}}={\stackrel{{\scriptstyle\leftarrow}}{{s}}}^{\prime})}~.
$$

This is the same, though, as

$$
{\rm P}(\stackrel{{\scriptstyle\rightarrow}}{{S}}=s\!\stackrel{{\scriptstyle\rightarrow}}{{s}}|\stackrel{{\scriptstyle\leftarrow}}{{S}}={\stackrel{{\scriptstyle\leftarrow}}{{s}}})\neq{\rm P}(\stackrel{{\scriptstyle\rightarrow}}{{S}}=s\!\stackrel{{\scriptstyle\rightarrow}}{{s}}|\stackrel{{\scriptstyle\leftarrow}}{{S}}={\stackrel{{\scriptstyle\leftarrow}}{{s}}}^{\prime})~.
$$

This is to say that there is a future $s\!\stackrel{{\scriptstyle\rightarrow}}{{s}}$ that has different probabilities depending on whether we conditioned on ${\stackrel{{\scriptstyle\leftarrow}}{{s}}}$ or on ${{\stackrel{{\scriptstyle\leftarrow}}{{s}}}}^{\prime}$. But this contradicts the assumption that the two histories belong to the same causal state. Therefore, there is no such future $\stackrel{{\scriptstyle\rightarrow}}{{s}}$, and the alternative statement of the lemma is true. QED.

Remark 1. In automata theory [^66], a set of states and transitions is said to be deterministic if the current state and the next input—here, the next result from the original stochastic process—together fix the next state. This use of the word “deterministic” is often confusing, since many stochastic processes (e.g., simple Markov chains) are deterministic in this sense.

Remark 2. Starting from a fixed state, a given symbol always leads to at most one single state. But there can be several transitions from one state to another, each labeled with a different symbol.

Remark 3. Clearly, if $T^{(s)}_{ij}>0$, then $T^{(s)}_{ij}={\rm P}(\stackrel{{\scriptstyle\rightarrow}}{{S}}^{1}=s|{\cal S}={\cal S}_{i})$. In automata theory the “disallowed” transitions ($T^{(s)}_{ij}=0$) are sometimes explicitly represented and lead to a “reject” state indicating that the particular history does not occur.

###### Lemma 6

(Causal States Are Independent) The probability distributions over causal states at different times are conditionally independent.

Proof. What we wish to show is that, writing ${\cal S}$, ${\cal S}^{\prime}$, ${\cal S}^{\prime\prime}$ for the sequence of causal states at three successive times, ${\cal S}$ and ${{\cal S}}^{\prime\prime}$ are conditionally independent, given ${{\cal S}}^{\prime}$. We can do this directly:

$$
\displaystyle{\rm P}
$$
 
$$
\displaystyle(
$$
$$
\displaystyle{\cal S}=\sigma{,\;}{\cal S}^{\prime}=\sigma^{\prime}{,\;}{\cal S}^{\prime\prime}=\sigma^{\prime\prime})
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle{\rm P}({\cal S}^{\prime\prime}=\sigma^{\prime\prime}|{\cal S}=\sigma{,\;}{\cal S}^{\prime}=\sigma^{\prime}){\rm P}({\cal S}=\sigma{,\;}{\cal S}^{\prime}=\sigma^{\prime})
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle{\rm P}(\stackrel{{\scriptstyle\rightarrow}}{{S}}^{1}\in a|{\cal S}=\sigma{,\;}{\cal S}^{\prime}=\sigma^{\prime}){\rm P}({\cal S}=\sigma{,\;}{\cal S}^{\prime}=\sigma^{\prime})~,
$$

where $a$ is the subset of all symbols that lead from $\sigma^{\prime}$ to $\sigma^{\prime\prime}$. This is a well defined subset, in virtue of Lemma immediately preceding, which also guarantees the equality of conditional probabilities we have used. Likewise,

$$
{\rm P}({\cal S}^{\prime\prime}=\sigma^{\prime\prime}|{\cal S}^{\prime}=\sigma^{\prime})={\rm P}(\stackrel{{\scriptstyle\rightarrow}}{{S}}^{1}\in a|{\cal S}^{\prime}=\sigma^{\prime})~.
$$

But, by construction,

$$
{\rm P}(\stackrel{{\scriptstyle\rightarrow}}{{S}}^{1}\in a|{\cal S}=\sigma{,\;}{\cal S}^{\prime}=\sigma^{\prime})={\rm P}(\stackrel{{\scriptstyle\rightarrow}}{{S}}^{1}\in a|{\cal S}^{\prime}=\sigma^{\prime})~,
$$

and hence

$$
{\rm P}({\cal S}^{\prime\prime}=\sigma^{\prime\prime}|{\cal S}^{\prime}=\sigma^{\prime})={\rm P}({{\cal S}}^{\prime\prime}=\sigma^{\prime\prime}|{\cal S}=\sigma{,\;}{\cal S}^{\prime}=\sigma^{\prime})~.
$$

So, to resume,

$$
\displaystyle{\rm P}
$$
 
$$
\displaystyle(
$$
$$
\displaystyle{\cal S}=\sigma{,\;}{\cal S}^{\prime}=\sigma^{\prime}{,\;}{\cal S}^{\prime\prime}=\sigma^{\prime\prime})
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle{\rm P}({\cal S}^{\prime\prime}=\sigma^{\prime\prime}|{\cal S}^{\prime}=\sigma^{\prime}){\rm P}({\cal S}=\sigma{,\;}{\cal S}^{\prime}=\sigma^{\prime})
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle{\rm P}({\cal S}^{\prime\prime}=\sigma^{\prime\prime}|{\cal S}^{\prime}=\sigma^{\prime}){\rm P}({\cal S}^{\prime}=\sigma^{\prime}|{\cal S}=\sigma){\rm P}({\cal S}=\sigma)~.
$$

The last line follows from the definition of conditional probability and is equivalent to the more easily interpreted expression given by

$$
{\rm P}({\cal S}^{\prime\prime}|{\cal S}^{\prime}){\rm P}({\cal S}|{\cal S}^{\prime}){\rm P}({\cal S}^{\prime})~.
$$

Thus, applying mathematical induction to Eq. (41), causal states at different times are independent, conditioning on the intermediate causal states. QED.

Remark 1. This lemma strengthens the claim that the causal states are, in fact, the causally efficacious states: given knowledge of the present state, what has gone before makes no difference. (Again, recall the philosophical preliminaries of Sec. II.5.)

Remark 2. This result indicates that the causal states, considered as a process, define a kind of Markov chain. Thus, causal states can be roughly considered to be a generalization of Markovian states. We say “kind of” since the class of $\epsilon$ -machines is substantially richer [^5] [^10] than what one normally associates with Markov chains [^67] [^68].

###### Definition 10 (ϵ\\epsilon-Machine Reconstruction)

$\epsilon$ -Machine reconstruction is any procedure that given a process ${\rm P}(\stackrel{{\scriptstyle\leftrightarrow}}{{S}})$, or an approximation of ${\rm P}(\stackrel{{\scriptstyle\leftrightarrow}}{{S}})$, produces the process’s $\epsilon$ -machine $\{\boldsymbol{{\cal S}},{\bf T}\}$.

Givenamathematicaldescriptionofaprocess,onecanoftencalculateanalyticallyitsϵ $-machine.(Forexample,seethecomputationalmechanicsanalysisofspinsystemsinRef.\cite[cite]{[\@@bibref{Number}{DNCO}{}{}]}.)Thereisalsoawiderangeofalgorithmswhichreconstruct$ ϵ $-machinesfromempiricalestimatesof$ P ( S ↔ )$.Some,suchasthoseusedinRefs.~\cite[cite]{[\@@bibref{Number}{Calculi-of-emergence,Inferring-stat-compl,Computation-at-the-onset,Hanson-thesis}{}{}]},operatein``batch^{\prime\prime}mode,takingtherawdataasawholeandproducingthe$ ϵ $-machine.Otherscouldoperateincrementally,in``on-line^{\prime\prime}mode,takinginindividualmeasurementsandre-estimatingthesetofcausalstatesandtheirtransitionprobabilities.\par$

## V Optimalities and Uniqueness

We now show that: causal states are maximally accurate predictors of minimal statistical complexity; they are unique in sharing both properties; and their state-to-state transitions are minimally stochastic. In other words, they satisfy both of the constraints borrowed from Occam, and they are the only representations that do so. The overarching moral here is that causal states and $\epsilon$ -machines are the goals in any learning or modeling scheme. The argument is made by the time-honored means of proving optimality theorems. We address, in our concluding remarks (Sec. VII), the practicalities involved in attaining these goals.

![Refer to caption](https://ar5iv.labs.arxiv.org/html/cond-mat/9907176/assets/EpsilonAndBadEtaPartition.png)

Figure 3: An alternative class ℛ \\boldsymbol{{\\cal R}} of states (delineated by dashed lines) that partition 𝐒 ← {\\stackrel{{\\scriptstyle\\leftarrow}}{{\\rm{\\bf S}}}} overlaid on the causal states 𝒮 \\boldsymbol{{\\cal S}} (outlined by solid lines). Here, for example, 2 {\\cal S}\_{2} contains parts of 1 {\\cal R}\_{1}, {\\cal R}\_{2} 3 {\\cal R}\_{3} and 4 {\\cal R}\_{4}. The collection of all such alternative partitions form Occam’s pool. Note again that the i {\\cal R}\_{i} need not be compact nor simply connected, as drawn.

As part of our strategy, though, we also prove several results that are not optimality results; we call these lemmas to indicate their subordinate status. All of our theorems, and some of our lemmas, will be established by comparing causal states, generated by $\epsilon$, with other rival sets of states, generated by other functions $\eta$. In short, none of the rival states—none of the other patterns—can out-perform the causal states.

It is convenient to fix some additional notation. Let ${\cal S}$ be the random variable for the current causal state, $\stackrel{{\scriptstyle\rightarrow}}{{S}}^{1}\in{\cal A}$ the next “observable” we get from the original stochastic process, ${\cal S}^{\prime}$ the next causal state, ${\cal R}$ the current state according to $\eta$, and ${\cal R}^{\prime}$ the next $\eta$ -state. $\sigma$ will stand for a particular value (causal state) of ${\cal S}$ and $\rho$ a particular value of ${\cal R}$. When we quantify over alternatives to the causal states, we quantify over $\boldsymbol{{\cal R}}$.

###### Theorem 1

(Causal States are Maximally Prescient) [^15]

For all $\boldsymbol{{\cal R}}$ and all $L\in{\mathbb{Z}}^{+}$,

$$
H[{\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{L}|{\cal R}]\geq H[{\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{L}|{\cal S}]~.
$$

Proof. We have already seen that $H[{\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{L}|{\cal R}]\geq H[{\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{L}|\stackrel{{\scriptstyle\leftarrow}}{{S}}]$ (Lemma 12). But by construction (Def. 5),

$$
{\rm P}({\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{L}={\stackrel{{\scriptstyle\rightarrow}}{{s}}}^{L}|\stackrel{{\scriptstyle\leftarrow}}{{S}}={\stackrel{{\scriptstyle\leftarrow}}{{s}}})={\rm P}({\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{L}={\stackrel{{\scriptstyle\rightarrow}}{{s}}}^{L}|{\cal S}=\epsilon({\stackrel{{\scriptstyle\leftarrow}}{{s}}}))~.
$$

Since entropies depend only on the probability distribution, $H[{\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{L}|{\cal S}]=H[{\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{L}|\stackrel{{\scriptstyle\leftarrow}}{{S}}]$ for every $L$. Thus, $H[{\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{L}|{\cal R}]\geq H[{\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{L}|{\cal S}]$, for all $L$. QED.

Remark. That is to say, causal states are as good at predicting the future—are as prescient—as complete histories. In this, they satisfy the first requirement borrowed from Occam. Since the causal states are well defined and since they can be systematically approximated, we have shown that the upper bound on the strength of patterns (Def. 3 and Lemma 12, Remark) can in fact be reached. Intuitively, the causal states achieve this because, unlike effective states in general, they do not throw away any information about the future which might be contained in $\stackrel{{\scriptstyle\leftarrow}}{{S}}$. Even more colloquially, to paraphrase the definition of information in Ref. [^70], the causal states record every difference (about the past) that makes a difference (to the future). We can actually make this intuition quite precise, in an easy corollary to the theorem.

###### Corollary 1

(Causal States Are Sufficient Statistics) The causal states $\boldsymbol{{\cal S}}$ of a process are sufficient statistics for predicting it.

Proof. It follows from Thm. 42 and Eq. (8) that, for all $L\in{\mathbb{Z}}^{+}$,

$$
I[{\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{L};{\cal S}]=I[{\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{L};\stackrel{{\scriptstyle\leftarrow}}{{S}}]~,
$$

where $I$ was defined in Eq. (8). Consequently, the causal state is a sufficient statistic—see Refs. [^62] and [^71] —for predicting futures of any length. QED.

All subsequent results concern rival states that are as prescient as the causal states. We call these prescient rivals and denote a class of them $\boldsymbol{\hat{{\cal R}}}$.

###### Definition 11 (Prescient Rivals)

Prescient rivals $\boldsymbol{\hat{{\cal R}}}$ are states that are as predictive as the causal states; viz., for all $L\in{\mathbb{Z}}^{+}$,

$$
H[{\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{L}|\hat{{\cal R}}]=H[{\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{L}|{\cal S}]~.
$$

Remark. Prescient rivals are also sufficient statistics.

###### Lemma 7 (Refinement Lemma)

For all prescient rivals $\boldsymbol{\hat{{\cal R}}}$ and for each $\hat{\rho}\in\boldsymbol{\hat{{\cal R}}}$, there is a $\sigma\in\boldsymbol{{\cal S}}$ and a measure- $0$ subset $\hat{\rho}_{0}\subset\hat{\rho}$, possibly empty, such that $\hat{\rho}\setminus\hat{\rho}_{0}\subseteq\sigma$, where $\setminus$ is set subtraction.

Proof. We invoke a straightforward extension of Thm. 2.7.3 of Ref. [^62]: If $X_{1},X_{2},\ldots,X_{n}$ are random variables over the same set ${\cal A}$, each with distinct probability distributions, $\Theta$ a random variable over the integers from $1$ to $n$ such that ${\rm P}(\Theta=i)=\lambda_{i}$, and $Z$ a random variable over ${\cal A}$ such that $Z=X_{\Theta}$, then

$$
\displaystyle H[Z]
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle H[\sum_{i=1}^{n}\lambda_{i}X_{i}]
$$
 
$$
\displaystyle\geq
$$
 
$$
\displaystyle\sum_{i=1}^{n}\lambda_{i}H[X_{i}]~.
$$

In words, the entropy of a mixture of distributions is at least the mean of the entropies of those distributions. This follows since $H$ is strictly concave, which in turn follows from $x\log{x}$ being strictly convex for $x\geq 0$. We obtain equality in Eq. (46) if and only if all the $\lambda_{i}$ are either 0 or 1, i.e., if and only if $Z$ is at least weakly homogeneous (Def. 7).

The conditional distribution of futures for each rival state $\rho$ can be written as a weighted mixture of the morphs of one or more causal states. (Cf. Fig. 3.) Thus, by Eq. (46), unless every $\rho$ is at least weakly homogeneous with respect to ${\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{L}$ (for each $L$), the entropy of ${\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{L}$ conditioned on ${\cal R}$ will be higher than the minimum, the entropy conditioned on ${\cal S}$. So, in the case of the maximally predictive $\hat{{\cal R}}$, every $\hat{\rho}\in\boldsymbol{\hat{{\cal R}}}$ must be at least weakly homogeneous with respect to all ${\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{L}$. But the causal states are the largest classes that are strictly homogeneous with respect to all ${\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{L}$ (Lemma 3). Thus, the strictly homogeneous part of each $\hat{\rho}\in\boldsymbol{\hat{{\cal R}}}$ must be a subclass, possibly improper, of some causal state $\sigma\in\boldsymbol{{\cal S}}$. QED.

Remark 1. An alternative proof appears in App. E.

Remark 2. The content of the lemma can be made quite intuitive, if we ignore for a moment the measure- $0$ set $\hat{\rho}_{0}$ of histories mentioned in its statement. It then asserts that any alternative partition $\boldsymbol{\hat{{\cal R}}}$ that is as prescient as the causal states must be a refinement of the causal-state partition. That is, each $\hat{{\cal R}}_{i}$ must be a (possibly improper) subset of some ${\cal S}_{j}$. Otherwise, at least one $\hat{{\cal R}}_{i}$ would have to contain parts of at least two causal states. And so, using this $\hat{{\cal R}}_{i}$ to predict the future observables would lead to more uncertainty about $\stackrel{{\scriptstyle\rightarrow}}{{S}}$ than using the causal states. This is illustrated by Fig. 4, which should be contrasted with Fig. 3.

Adding the measure- $0$ set $\hat{\rho}_{0}$ of histories to this picture does not change its heuristic content much. Precisely because these histories have zero probability, treating them in an “inappropriate” way makes no discernible difference to predictions, morphs, and so on. There is a problem of terminology, however, since there seems to be no standard name for the relationship between the partitions $\boldsymbol{\hat{{\cal R}}}$ and $\boldsymbol{{\cal S}}$. We propose to say that the former is a refinement of the latter almost everywhere or, simply, a refinement a.e.

Remark 3. One cannot work the proof the other way around to show that the causal states have to be a refinement of the equally prescient $\hat{{\cal R}}$ -states. This is precluded because applying the theorem borrowed from Ref. [^62], Eq. (46), hinges on being able to reduce uncertainty by specifying from which distribution one chooses. Since the causal states are constructed so as to be strictly homogeneous with respect to futures, this is not the case. Lemma 3 and Thm. 42 together protect us.

Remark 4. Because almost all of each prescient rival state is wholly contained within a single causal state, we can construct a function $g:\boldsymbol{\hat{{\cal R}}}\mapsto\boldsymbol{{\cal S}}$, such that, if $\eta({\stackrel{{\scriptstyle\leftarrow}}{{s}}})=\hat{\rho}$, then $\epsilon({\stackrel{{\scriptstyle\leftarrow}}{{s}}})=g(\hat{\rho})$ almost always. We can even say that ${\cal S}=g(\hat{{\cal R}})$ almost always, with the understanding that this means that, for each $\hat{\rho}$, ${\rm P}({\cal S}=\sigma|\hat{{\cal R}}=\hat{\rho})>0$ if and only if $\sigma=g(\hat{\rho})$.

![Refer to caption](https://ar5iv.labs.arxiv.org/html/cond-mat/9907176/assets/RefinedPartition.png)

Figure 4: A prescient rival partition ℛ ^ \\boldsymbol{\\hat{{\\cal R}}} must be a refinement of the causal-state partition almost everywhere. That is, almost all of each i \\hat{{\\cal R}}\_{i} must contained within some 𝒮 j {\\cal S}\_{j}; the exceptions, if any, are a set of histories of measure 0. Here for instance 2 {\\cal S}\_{2} contains the positive-measure parts of 3 \\hat{{\\cal R}}\_{3}, 4 \\hat{{\\cal R}}\_{4}, and 5 \\hat{{\\cal R}}\_{5}. One of these rival states, say, could have member-histories in any or all of the other causal states, provided the total measure of such exceptional histories is zero. Cf. Fig..

###### Theorem 2 (Causal States Are Minimal)

[^15] For all prescient rivals $\boldsymbol{\hat{{\cal R}}}$,

$$
C_{\mu}(\boldsymbol{\hat{{\cal R}}})\geq C_{\mu}(\boldsymbol{{\cal S}})~.
$$

Proof. By Lemma 7, Remark 4, there is a function $g$ such that ${\cal S}=g(\hat{{\cal R}})$ almost always. But $H[f(X)]\leq H[X]$ (Eq. (93)) and so

$$
H[{\cal S}]=H[g(\hat{{\cal R}})]\leq H[\hat{{\cal R}}]~.
$$

but $C_{\mu}(\boldsymbol{\hat{{\cal R}}})=H[\hat{{\cal R}}]$ (Def. 4). QED.

Remark 1. We have just established that no rival pattern, which is as good at predicting the observations as the causal states, is any simpler, in the sense given by Def. 4, than the causal states. (This is the theorem of Ref. [^6].) Occam therefore tells us that there is no reason not to use the causal states. The next theorem shows that causal states are uniquely optimal, and so that Occam’s Razor all but forces us to use them.

Remark 2. Here it becomes important that we are trying to predict the whole of $\stackrel{{\scriptstyle\rightarrow}}{{S}}$ and not just some piece, ${\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{L}$. Suppose two histories ${\stackrel{{\scriptstyle\leftarrow}}{{s}}}$ and ${{\stackrel{{\scriptstyle\leftarrow}}{{s}}}}^{\prime}$ have the same conditional distribution for futures of lengths up to $L$, but differing ones after that. They would then belong to different causal states. An $\eta$ -state that merged those two causal states, however, would have just as much ability to predict ${\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{L}$ as the causal states. More, these ${\cal R}$ -states would be simpler, in the sense that the uncertainty in the current state would be lower. We conclude that causal states are optimal, but for the hardest job—that of predicting futures of all lengths.

Remark 3. We have already seen (Thm. 42, Remark 2) that causal states are sufficient statistics for predicting futures of all lengths; so are all prescient rivals. A minimal sufficient statistic is one that is a function of all other sufficient statistics [^62]. Since, in the course of the proof of Thm. 47, we have shown that there is a function $g$ from any $\hat{{\cal R}}$ to ${\cal S}$, we have also shown that causal states are minimal sufficient statistics.

We may now, as promised, define the statistical complexity of a process [^5] [^6].

###### Definition 12

(Statistical Complexity of a Process) The statistical complexity “ $C_{\mu}({\cal O})$ ” of a process $\cal O$ is that of its causal states: $C_{\mu}({\cal O})\equiv C_{\mu}(\boldsymbol{{\cal S}})$.

Due to the minimality of causal states we see that the statistical complexity measures the average amount of historical memory stored in the process. Without the minimality theorem, this interpretation would not be possible, since we could trivially elaborate internal states, while still generating the same observed process. $C_{\mu}$ for those states would grow without bound and so be arbitrary and not a characteristic property of the process [^17].

###### Theorem 3

(Causal States Are Unique) For all prescient rivals $\boldsymbol{\hat{{\cal R}}}$, if $C_{\mu}(\boldsymbol{\hat{{\cal R}}})=C_{\mu}(\boldsymbol{{\cal S}})$, then there exists an invertible function between $\boldsymbol{\hat{{\cal R}}}$ and $\boldsymbol{{\cal S}}$ that almost always preserves equivalence of state: $\boldsymbol{\hat{{\cal R}}}$ and $\eta$ are the same as $\boldsymbol{{\cal S}}$ and $\epsilon$, respectively, except on a set of histories of measure $0$.

Proof. From Lemma 7, we know that ${\cal S}=g(\hat{{\cal R}})$ almost always. We now show that there is a function $f$ such that $\hat{{\cal R}}=f({\cal S})$ almost always, implying that $g={f}^{-1}$ and that $f$ is the desired relation between the two sets of states. To do this, by Eq. (94) it is sufficient to show that $H[\hat{{\cal R}}|{\cal S}]=0$. Now, it follows from an information-theoretic identity (Eq. (90)) that

$$
H[{\cal S}]-H[{\cal S}|\hat{{\cal R}}]=H[\hat{{\cal R}}]-H[\hat{{\cal R}}|{\cal S}]~.
$$

Since, by Lemma 7 $H[{\cal S}|\hat{{\cal R}}]=0$, both sides of Eq. (49) are equal to $H[{\cal S}]$. But, by hypothesis, $H[\hat{{\cal R}}]=H[{\cal S}]$. Thus, $H[\hat{{\cal R}}|{\cal S}]=0$ and so there exists an $f$ such that $\hat{{\cal R}}=f({\cal S})$ almost always. We have then that $f(g(\hat{{\cal R}}))=\hat{{\cal R}}$ and $g(f({\cal S}))={\cal S}$, so $g={f}^{-1}$. This implies that $f$ preserves equivalence of states almost always: for almost all ${\stackrel{{\scriptstyle\leftarrow}}{{s}}},{\stackrel{{\scriptstyle\leftarrow}}{{s}}}^{\prime}\in{\stackrel{{\scriptstyle\leftarrow}}{{\rm{\bf S}}}}$, $\eta({\stackrel{{\scriptstyle\leftarrow}}{{s}}})=\eta({\stackrel{{\scriptstyle\leftarrow}}{{s}}}^{\prime})$ if and only if $\epsilon({\stackrel{{\scriptstyle\leftarrow}}{{s}}})=\epsilon({{\stackrel{{\scriptstyle\leftarrow}}{{s}}}}^{\prime})$. QED.

Remark. As in the case of the Refinement Lemma 7, on which the theorem is based, the measure- $0$ caveats seem unavoidable. A rival that is as predictive and as simple (in the sense of Def. 4) as the causal states, can assign a measure- $0$ set of histories to different states than the $\epsilon$ -machine does, but no more. This makes sense: such a measure- $0$ set makes no difference, since its members are never observed, by definition. By the same token, however, nothing prevents a minimal, prescient rival from disagreeing with the $\epsilon$ -machine on those histories.

###### Theorem 4

($\epsilon$ -Machines Are Minimally Stochastic) [^15] For all prescient rivals $\boldsymbol{\hat{{\cal R}}}$,

$$
H[\hat{{\cal R}}^{\prime}|\hat{{\cal R}}]\geq H[{\cal S}^{\prime}|{\cal S}]~,
$$

where ${\cal S}^{\prime}$ and $\hat{{\cal R}}^{\prime}$ are the next causal state of the process and the next $\eta$ -state, respectively.

Proof.FromLemma, S ^′ $isfixedby$ S $and$ S → ^1 $together,thus$ H\[ S ^′— S, S → ^1\] = 0 $byEq.~(\ref{functions-are-certain}).Therefore,fromthechainruleforentropiesEq.~(\ref{conditional-chain-rule}),\@@eqnarray WehavenoresultliketheDeterminismLemma\ref{automatism-lemma}fortherivalstates$ ^ R $, b u t e n t r o p i e s a r e a l w a y s n o n - n e g a t i v e :$H\[ ^ R ^′— ^ R, S → ^1\] ≥0$.Sinceforall$ L,H\[ S → ^L — ^ R \] = H\[ S → ^L — S \] $bythedefinition,Def.(\ref{PrescientRivals}),ofprescientrivals,$H\[ S → ^1— ^ R \] = H\[ S → ^1— S \]$.Nowweapplythechainruleagain,\@@eqnarray IngoingfromEq.~(\ref{conditional-entropy-of-next-symbol})toEq.~(\ref{conditional-entropy-of-next-symbol-and-state})wehaveusedEq.~(\ref{conditional-entropy-of-next-symbol-equals-entropy-of-next-causal-state}),andinthelaststepwehaveusedthechainruleoncemore.\par Usingthechainruleonelasttime,wehave\begin{equation}H[\hat{{\cal R}}^{\prime},{\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{1}|\hat{{\cal R}}]=H[{\hat{{\cal R}}}^{\prime}|\hat{{\cal R}}]+H[{\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{1}|\hat{{\cal R}}^{\prime},\hat{{\cal R}}]~.\end{equation}Puttingtheseexpansions,Eqs.~(\ref{FirstExpansion})and(\ref{SecondExpansion}),togetherweget\@@eqnarray FromLemma\ref{refinement-lemma},weknowthat$ S = g( ^ R )$,sothereisanotherfunction$ g^′ $fromorderedpairsof$ η $-statestoorderedpairsofcausalstates:$( S ^′, S ) = g^′( ^ R ^′, ^ R )$.Therefore,Eq.~(\ref{conditioning-on-function})implies\begin{equation}H[\stackrel{{\scriptstyle\rightarrow}}{{S}}^{1}|{\cal S}^{\prime},{\cal S}]\geq H[\stackrel{{\scriptstyle\rightarrow}}{{S}}^{1}|\hat{{\cal R}}^{\prime},\hat{{\cal R}}]~.\end{equation}Andso,wehavethat\@@eqnarray QED.\par{\it Remark.}Whatthistheoremsaysisthatthereisnomoreuncertaintyintransitionsbetweencausalstates,thanthereisinthetransitionsbetweenanyotherkindofprescienteffectivestates.Inotherwords,thecausalstatesapproachascloselytoperfectdeterminism---intheusualphysical,non-computation-theoreticsense---asanyrivalthatisasgoodatpredictingthefuture.Thissortofinternaldeterminismhaslongbeenheldtobeadesideratumofscientificmodels\cite[cite]{[\@@bibref{Number}{Bernard}{}{}]}.\par$

## VI Bounds

In this section we develop bounds between measures of structural complexity and entropy derived from $\epsilon$ -machines and those from ergodic and information theories, which are perhaps more familiar.

###### Definition 13 (Excess Entropy)

The excess entropy ${\bf E}$ of a process is the mutual information between its semi-infinite past and its semi-infinite future:

$$
{\bf E}\equiv I[\stackrel{{\scriptstyle\rightarrow}}{{S}};\stackrel{{\scriptstyle\leftarrow}}{{S}}]~.
$$

The excess entropy is a frequently-used measure of the complexity of stochastic processes and appears under a variety of names; e.g., “predictive information”, “stored information”, “effective measure complexity”, and so on [^73] [^74] [^75] [^76] [^77] [^78] [^79]. ${\bf E}$ measures the amount of apparent information stored in the observed behavior about the past. As we now establish, ${\bf E}$ is not, in general, the amount of memory that the process stores internally about its past; a quantity measured by $C_{\mu}$.

###### Theorem 5 (The Bounds of Excess)

The statistical complexity $C_{\mu}$ bounds the excess entropy ${\bf E}$:

$$
{{\bf E}}\leq C_{\mu}~,
$$

with equality if and only if $H[{\cal S}|\stackrel{{\scriptstyle\rightarrow}}{{S}}]=0$.

Proof. ${{\bf E}}=I[\stackrel{{\scriptstyle\rightarrow}}{{S}};\stackrel{{\scriptstyle\leftarrow}}{{S}}]=H[\stackrel{{\scriptstyle\rightarrow}}{{S}}]-H[\stackrel{{\scriptstyle\rightarrow}}{{S}}|\stackrel{{\scriptstyle\leftarrow}}{{S}}]$ and, by the construction of causal states, $H[\stackrel{{\scriptstyle\rightarrow}}{{S}}|\stackrel{{\scriptstyle\leftarrow}}{{S}}]=H[\stackrel{{\scriptstyle\rightarrow}}{{S}}|{\cal S}]$, so

$$
{{\bf E}}=H[\stackrel{{\scriptstyle\rightarrow}}{{S}}]-H[\stackrel{{\scriptstyle\rightarrow}}{{S}}|{\cal S}]=I[\stackrel{{\scriptstyle\rightarrow}}{{S}};{\cal S}]~.
$$

Thus, since the mutual information between two variables is never larger than the self-information of either one of them (Eq. (91)), ${{\bf E}}\leq H[{\cal S}]=C_{\mu}$, with equality if and only if $H[{\cal S}|\stackrel{{\scriptstyle\rightarrow}}{{S}}]=0$. QED.

Remark 1. Note that we have invoked $H[\stackrel{{\scriptstyle\rightarrow}}{{S}}]$, not $H[{\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{L}]$, but only while subtracting off quantities like $H[\stackrel{{\scriptstyle\rightarrow}}{{S}}|\stackrel{{\scriptstyle\leftarrow}}{{S}}]$. We need not worry, therefore, about the existence of a finite $L\rightarrow\infty$ limit for $H[{\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{L}]$, just that of a finite $L\rightarrow\infty$ limit for $I[{\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{L};\stackrel{{\scriptstyle\leftarrow}}{{S}}]$ and $I[{\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{L};{\cal S}]$. There are many elementary cases (e.g., the fair coin process) where the latter limits exist while the former do not.

Remark 2. At first glance, it is tempting to see ${\bf E}$ as the amount of information stored in a process. As Thm. 5 shows, this temptation should be resisted. ${\bf E}$ is only a lower bound on the true amount of information the process stores about its history, namely $C_{\mu}$. We can, however, say that ${\bf E}$ measures the apparent information in the process, since it is defined directly in terms of observed sequences and not in terms of hidden, intrinsic states, as $C_{\mu}$ is.

Remark 3. Perhaps another way to describe what ${\bf E}$ measures is to note that, by its implicit assumption of block-Markovian structure, it takes sequence-blocks as states. But even for the class of block-Markovian sources, for which such an assumption is appropriate, excess entropy and statistical complexity measure different kinds of information storage. Refs. [^65] and [^80] showed that in the case of one-dimensional range- $R$ spin systems, or any other block-Markovian source where block configurations are isomorphic to causal states:

$$
C_{\mu}={\bf E}+Rh_{\mu}~,
$$

for finite $R$. Only for zero-entropy-rate block-Markovian sources will the excess entropy, a quantity estimated directly from sequence blocks, equal the statistical complexity, the amount of memory stored in the process. Examples of such sources include periodic processes, for which we have $C_{\mu}={\bf E}=\log_{2}p$, where $p$ is the period.

###### Corollary 2

For all prescient rivals $\boldsymbol{\hat{{\cal R}}}$,

$$
{\bf E}\leq H[\hat{{\cal R}}]~.
$$

Proof. This follows directly from Thm. 47, since $H[\hat{{\cal R}}]\geq C_{\mu}$. QED.

###### Lemma 8

(Conditioning Does Not Affect Entropy Rate) For all prescient rivals $\boldsymbol{\hat{{\cal R}}}$,

$$
h[\stackrel{{\scriptstyle\rightarrow}}{{S}}]=h[\stackrel{{\scriptstyle\rightarrow}}{{S}}|\hat{{\cal R}}]~,
$$

where the entropy rate $h[\stackrel{{\scriptstyle\rightarrow}}{{S}}]$ and the conditional entropy rate $h[\stackrel{{\scriptstyle\rightarrow}}{{S}}|\hat{{\cal R}}]$ were defined in Eq. (9) and Eq. (10), respectively.

Proof. From Thm. 5 and its Corollary 65, we have

$$
\lim_{L\rightarrow\infty}{\left(H[{\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{L}]-H[{\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{L}|\hat{{\cal R}}]\right)}\leq\lim_{L\rightarrow\infty}{H[\hat{{\cal R}}]}~,
$$

or,

$$
\lim_{L\rightarrow\infty}{H[{\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{L}]-H[{\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{L}|\hat{{\cal R}}]\over L}\leq\lim_{L\rightarrow\infty}{H[\hat{{\cal R}}]\over L}~.
$$

Since, by Eq. (86), $H[{\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{L}]-H[{\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{L}|\hat{{\cal R}}]\geq 0$, we have

$$
h[\stackrel{{\scriptstyle\rightarrow}}{{S}}]-h[\stackrel{{\scriptstyle\rightarrow}}{{S}}|\hat{{\cal R}}]=0~.
$$

QED.

Remark. Forcing the process into a certain state $\hat{{\cal R}}=\hat{\rho}$ is akin to applying a controller, once. But in the infinite-entropy case, $H[{\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{L}]\rightarrow_{L\rightarrow\infty}\infty$, with which we are concerned, the future could contain (or consist of) an infinite sequence of disturbances. In the face of this “grand disturbance”, the effects of the finite control are simply washed out.

Another way of viewing this is to reflect on the fact that $h[\stackrel{{\scriptstyle\rightarrow}}{{S}}]$ accounts for the effects of all the dependencies between all the parts of the entire semi-infinite future. This, owing to the time-translation invariance of stationarity, is equivalent to taking account of all the dependencies in the entire process, including those between past and future. But these are what is captured by $h[\stackrel{{\scriptstyle\rightarrow}}{{S}}|\hat{{\cal R}}]$. It is not that conditioning on ${\cal R}$ fails to reduce our uncertainty about the future; it does so, for all finite times, and conditioning on ${\cal S}$ achieves the maximum possible reduction in uncertainty. Rather, the lemma asserts that such conditioning cannot effect the asymptotic rate at which such uncertainty grows with time.

###### Theorem 6 (Control Theorem)

Given a class $\boldsymbol{\hat{{\cal R}}}$ of prescient rivals,

$$
H[S]-h[\stackrel{{\scriptstyle\rightarrow}}{{S}}|\hat{{\cal R}}]\leq C_{\mu}~,
$$

where $H[S]$ is the entropy of a single symbol from the observable stochastic process.

Proof. As is well known (Ref. [^62]), for any stationary stochastic process,

$$
\lim_{L\rightarrow\infty}{H[{\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{L}]\over L}=\lim_{L\rightarrow\infty}{H[S_{L}|{\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{L-1}]}~.
$$

Moreover, the limits always exist. Up to this point, we have defined $h[\stackrel{{\scriptstyle\rightarrow}}{{S}}]$ in the manner of the left-hand side; recall Eq. (9). It will be convenient in the following to use that of the right-hand side.

From the definition of conditional entropy, we have

$$
\displaystyle H[{\stackrel{{\scriptstyle\leftarrow}}{{S}}}^{L}]
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle H[{\stackrel{{\scriptstyle\leftarrow}}{{S}}}^{1}|{\stackrel{{\scriptstyle\leftarrow}}{{S}}}^{L-1}]+H[{\stackrel{{\scriptstyle\leftarrow}}{{S}}}^{L-1}]
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle H[{\stackrel{{\scriptstyle\leftarrow}}{{S}}}^{L-1}|{\stackrel{{\scriptstyle\leftarrow}}{{S}}}^{1}]+H[{\stackrel{{\scriptstyle\leftarrow}}{{S}}}^{1}]~.
$$

So we can express the entropy of the last observable the process generated before the present as

$$
\displaystyle H[{\stackrel{{\scriptstyle\leftarrow}}{{S}}}^{1}]
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle H[{\stackrel{{\scriptstyle\leftarrow}}{{S}}}^{L}]-H[{\stackrel{{\scriptstyle\leftarrow}}{{S}}}^{L-1}|{\stackrel{{\scriptstyle\leftarrow}}{{S}}}^{1}]
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle H[{\stackrel{{\scriptstyle\leftarrow}}{{S}}}^{1}|{\stackrel{{\scriptstyle\leftarrow}}{{S}}}^{L-1}]+H[{\stackrel{{\scriptstyle\leftarrow}}{{S}}}^{L-1}]-H[{\stackrel{{\scriptstyle\leftarrow}}{{S}}}^{L-1}|{\stackrel{{\scriptstyle\leftarrow}}{{S}}}^{1}]
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle H[{\stackrel{{\scriptstyle\leftarrow}}{{S}}}^{1}|{\stackrel{{\scriptstyle\leftarrow}}{{S}}}^{L-1}]+I[{\stackrel{{\scriptstyle\leftarrow}}{{S}}}^{L-1};{\stackrel{{\scriptstyle\leftarrow}}{{S}}}^{1}]~.
$$

We go from Eq. (73) to Eq. (74) by substituting the first RHS of Eq. (72) for $H[{\stackrel{{\scriptstyle\leftarrow}}{{S}}}^{L}]$.

Taking the $L\rightarrow\infty$ limit has no effect on the LHS,

$$
H[{\stackrel{{\scriptstyle\leftarrow}}{{S}}}^{1}]=\lim_{L\rightarrow\infty}\left(H[{\stackrel{{\scriptstyle\leftarrow}}{{S}}}^{1}|{\stackrel{{\scriptstyle\leftarrow}}{{S}}}^{L-1}]+I[{\stackrel{{\scriptstyle\leftarrow}}{{S}}}^{L-1};{\stackrel{{\scriptstyle\leftarrow}}{{S}}}^{1}]\right)~.
$$

Since the process is stationary, we can move the first term in the limit forward to $H[{S}_{L}|{\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{L-1}]$. This limit is $h[\stackrel{{\scriptstyle\rightarrow}}{{S}}]$, by Eq. (71). Furthermore, because of stationarity, $H[{\stackrel{{\scriptstyle\leftarrow}}{{S}}}^{1}]=H[{\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{1}]=H[S]$. Shifting the entropy rate $h[\stackrel{{\scriptstyle\rightarrow}}{{S}}]$ to the LHS of Eq. (76) and appealing to time-translation once again, we have

$$
\displaystyle H[S]-h[\stackrel{{\scriptstyle\rightarrow}}{{S}}]
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\lim_{L\rightarrow\infty}{I[{\stackrel{{\scriptstyle\leftarrow}}{{S}}}^{L-1};{\stackrel{{\scriptstyle\leftarrow}}{{S}}}^{1}]}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle I[\stackrel{{\scriptstyle\leftarrow}}{{S}};{\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{1}]
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle H[{\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{1}]-H[{\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{1}|\stackrel{{\scriptstyle\leftarrow}}{{S}}]
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle H[{\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{1}]-H[{\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{1}|{\cal S}]
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle I[{\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{1};{\cal S}]
$$
 
$$
\displaystyle\leq
$$
 
$$
\displaystyle H[{\cal S}]=C_{\mu}~,
$$

where the last inequality comes from Eq. (91). QED.

Remark 1. The Control Theorem is inspired by, and is a version of, Ashby’s law of requisite variety [^81]. This states that applying a controller can reduce the uncertainty in the controlled variable by at most the entropy of the control variable. (This result has recently been rediscovered in Ref. [^82].) Thinking of the controlling variable as the causal state, we have here a limitation on the controller’s ability to reduce the entropy rate.

Remark 2. This is the only result so far where the difference between the finite- $L$ and the infinite- $L$ cases is important. For the analogous result in the finite case, see App. F, Thm. 111.

Remark 3. By applying Thm. 47 and Lemma 8, we could go from the theorem as it stands to $H[S]-h[\stackrel{{\scriptstyle\rightarrow}}{{S}}|\hat{{\cal R}}]\leq H[\hat{{\cal R}}]$. This has a pleasing appearance of symmetry to it, but is actually a weaker limit on the strength of the pattern or, equivalently, on the amount of control that fixing the causal state (or one of its rivals) can exert.

## VII Concluding Remarks

### VII.1 Discussion

Let’s review, informally, what we have shown. We began with questions about the nature of patterns and about pattern discovery. Our examination of these issues lead us to want a way of describing patterns that was at once algebraic, computational, intrinsically probabilistic, and causal. We then defined patterns in ensembles, in a very general and abstract sense, as equivalence classes of histories, or sets of hidden states, used for prediction. We defined the strength of such patterns (by their forecasting ability or prescience) and their statistical complexity (by the entropy of the states or the amount of information retained by the process about its history). We showed that there was a limit on how strong such patterns could get for each particular process, given by the predictive ability of the entire past. In this way, we narrowed our goal to finding a predictor of maximum strength and minimum complexity.

Optimal prediction led us to the equivalence relation ${\sim}_{\epsilon}$ and the function $\epsilon$ and so to representing patterns by causal states and their transitions—the $\epsilon$ -machine. Our first theorem showed that the causal states are maximally prescient; our second, that they are the simplest way of representing the pattern of maximum strength; our third theorem, that they are unique in having this double optimality. Further results showed that $\epsilon$ -machines are the least stochastic way of capturing maximum-strength patterns and emphasized the need to employ the efficacious but hidden states of the process, rather than just its gross observables, such as sequence blocks.

Why are $\epsilon$ -machine states causal? First, $\epsilon$ -machine architecture (say, as given by its semi-group algebra) delineates the dependency between the morphs ${\rm P}(\stackrel{{\scriptstyle\rightarrow}}{{S}}|\stackrel{{\scriptstyle\leftarrow}}{{S}})$, considered as events in which each new symbol determines the succeeding morph. Thus, if state $B$ follows state $A$ then $A$ is a cause of $B$ and $B$ is an effect of $A$. Second, $\epsilon$ -machine minimality guarantees that there are no other events that intervene to render $A$ and $B$ independent [^17].

The $\epsilon$ -machine is thus a causal representation of all the patterns in the process. It is maximally predictive and minimally complex. It is at once computational, since it shows how the process stores information (in the causal states) and transforms that information (in the state-to-state transitions), and algebraic (for details on which see App. D). It can be analytically calculated from given distributions and systematically approached from empirical data. It satisfies the basic constraints laid out in Sec. II.6.

These comments suggest that computational mechanics and $\epsilon$ -machines are related or may be of interest to a number of fields. Time series analysis, decision theory, machine learning, and universal coding theory explicitly or implicitly require models of observed processes. The theories of stochastic processes, formal languages and computation, and of measures of physical complexity are all concerned with representations of processes—concerns which also arise in the design of novel forms of computing devices. Very often the motivations of these fields are far removed from computational mechanics. But it is useful, if only by way of contrast, to touch briefly on these areas and highlight one or several connections with computational mechanics, and we do so in App. G.

### VII.2 Limitations of the Current Results

Let’s catalogue the restrictive assumptions we made at the beginning and that were used by our development.

1. We know exact joint probabilities over sequence blocks of all lengths for a process.
2. The observed process takes on discrete values.
3. The process is discrete in time.
4. The process is a pure time series; e.g., without spatial extent.
5. The observed process is stationary.
6. Prediction can only be based on the process’s past, not on any outside source of information.

The question arises, Can any be relaxed without much trouble?

One way to lift the first limitation is to develop a statistical error theory for $\epsilon$ -machine inference that indicates, say, how much data is required to attain a given level of confidence in an $\epsilon$ -machine with a given number of causal states. This program is underway and, given its initial progress, we describe several issues in more detail in the next section.

The second limitation probably can be addressed, but with a corresponding increase in mathematical sophistication. The information-theoretic quantities we have used are also defined for continuous random variables. It is likely that many of the results carry over to the continuous setting.

The third limitation also looks similarly solvable, since continuous-time stochastic process theory is moderately well developed. This may involve sophisticated probability theory or functional analysis.

As for the fourth limitation, there already exist tricks to make spatially extended systems look like time series. Essentially, one looks at all the paths through space-time, treating each one as if it were a time series. While this works well for data compression [^83], it is not yet clear whether it will be entirely satisfactory for capturing structure [^84]. More work needs to be done on this subject.

It is unclear at this time how to relax the assumption of stationarity. One can formally extend most of the results in this paper to non-stationary processes without much trouble. It is, however, unclear how much substantive content these extensions have and, in any case, a systematic classification of non-stationary processes is (at best) in its infant stages.

Finally, one might say that the last restriction is a positive feature when it comes to thinking about patterns and the intrinsic structure of a process. “Pattern” is a vague word, of course, but even in ordinary usage it is only supposed to involve things inside the process, not the rest of the universe. Given two copies of a document, the contents of one copy can be predicted with an enviable degree of accuracy by looking at the other copy. This tells us that they share a common structure, but says absolutely nothing about what that pattern is, since it is just as true of well-written and tightly-argued scientific papers (which presumably are highly organized) as it is of monkey-at-keyboard pieces of gibberish (which definitely are not).

### VII.3 Conclusions and Directions for Future Work

Computational mechanics aims to understand the nature of patterns and pattern discovery. We hope that the foregoing development has convinced the reader that we are neither being rash when we say that we have laid a foundation for those projects, nor that we are being flippant when we say that patterns are what $\epsilon$ -machines represent and that we discover them by $\epsilon$ -machine reconstruction. We would like to close by marking out two broad avenues for future work.

First, consider the mathematics of $\epsilon$ -machines themselves. We have just mentioned possible extensions in the form of lifting assumptions made in this development, but there are many other ways to go. A number of measure-theoretic issues relating to the definition of causal states (omitted here for brevity) deserve careful treatment, along the lines of Ref. [^10]. It would be helpful to have a good understanding of the measurement-resolution scaling properties of $\epsilon$ -machines for continuous-state processes, and of their relation to such ideas in automata theory as the Krohn-Rhodes decomposition [^30]. Anyone who manages to absorb Volume II of Ref. [^26] would probably be in a position to answer interesting questions about the structures that processes preserve, perhaps even to give a purely relation-theoretic account of $\epsilon$ -machines. We have alluded in a number of places to the trade-off between prescience and complexity. For a given process there is presumably a sequence of optimal machines connecting the one-state, zero-complexity machine with minimal prescience to the $\epsilon$ -machine. Each member of the path is the minimal machine for a certain degree of prescience; it would be very interesting to know what, if anything, we can say in general about the shape of this “prediction frontier”.

Second, there is $\epsilon$ -machine reconstruction, an activity about which we have said next to nothing. As we mentioned above (p. 10), there are already several algorithms for reconstructing machines from data, even “on-line” ones. It is fairly evident that these algorithms will find the true machine in the limit of infinite time and infinite data. What is needed is an understanding of the error statistics [^85] of different reconstruction procedures of the kinds of mistakes these procedures make and the probabilities with which they make them. Ideally, we want to find “confidence regions” for the products of reconstruction. The aim is to calculate (i) the probabilities of different degrees of reconstruction error for a given volume of data, (ii) the amount of data needed to be confident of a fixed bound on the error, or (iii) the rates at which different reconstruction procedures converge on the $\epsilon$ -machine. So far, an analytical theory has been developed that predicts the average number of estimated causal states as a function of the amount of data used when reconstructing certain kinds of processes [^86]. Once we possess a more complete theory of statistical inference for $\epsilon$ -machines, analogous perhaps to what already exists in computational learning theory, we will be in a position to begin analyzing, sensibly and rigorously, the multitude of intriguing patterns and information-processing structures the natural world presents.

## Acknowledgments

We thank Dave Albers, Dave Feldman, Jon Fetter, Rob Haslinger, Wim Hordijk, Amihan Huesmann, Cris Moore, Mitch Porter, Erik van Nimwegen, and Karl Young for advice on the manuscript; and the participants in the 1998 SFI Complex Systems Summer School, the Madison probability seminar, the Madison Physics Department’s graduate student mini-colloquium, and the Ann Arbor Complex Systems seminar for numerous helpful comments on earlier versions of these results. This work was supported at the Santa Fe Institute under the Computation, Dynamics, and Inference Program via ONR grant N00014-95-1-0975, NSF grant PHY-9970158, and DARPA contract F30602-00-2-0583.

## Appendix A Information-Theoretic FormulÆ

The following formulæ prove useful in the development. They are relatively intuitive, given our interpretation, and they can all be proved with little more than straight algebra; see Ref. [^62]. Below, $f$ is a function.

$$
\displaystyle H[X,Y]
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle H[X]+H[Y|X]
$$
 
$$
\displaystyle H[X,Y]
$$
 
$$
\displaystyle\geq
$$
 
$$
\displaystyle H[X]
$$
 
$$
\displaystyle H[X,Y]
$$
 
$$
\displaystyle\leq
$$
 
$$
\displaystyle H[X]+H[Y]
$$
 
$$
\displaystyle H[X|Y]
$$
 
$$
\displaystyle\leq
$$
 
$$
\displaystyle H[X]
$$
 
$$
\displaystyle H[X|Y]=H[X]
$$
 
$$
\displaystyle{\rm iff}
$$
 
$$
\displaystyle X{\rm is\ independent\ of\ }Y
$$
 
$$
\displaystyle H[X,Y|Z]
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle H[X|Z]+H[Y|X,Z]
$$
 
$$
\displaystyle H[X,Y|Z]
$$
 
$$
\displaystyle\geq
$$
 
$$
\displaystyle H[X|Z]
$$
 
$$
\displaystyle H[X]-H[X|Y]
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle H[Y]-H[Y|X]
$$
 
$$
\displaystyle I[X;Y]
$$
 
$$
\displaystyle\leq
$$
 
$$
\displaystyle H[X]
$$
 
$$
\displaystyle I[X;Y]=H[X]
$$
 
$$
\displaystyle{\rm iff}
$$
 
$$
\displaystyle H[X|Y]=0
$$
 
$$
\displaystyle H[f(X)]
$$
 
$$
\displaystyle\leq
$$
 
$$
\displaystyle H[X]
$$
 
$$
\displaystyle H[X|Y]=0
$$
 
$$
\displaystyle{\rm iff}
$$
 
$$
\displaystyle X=f(Y)
$$
 
$$
\displaystyle H[f(X)|Y]
$$
 
$$
\displaystyle\leq
$$
 
$$
\displaystyle H[X|Y]
$$
 
$$
\displaystyle H[X|f(Y)]
$$
 
$$
\displaystyle\geq
$$
 
$$
\displaystyle H[X|Y]
$$

Eqs. (83) and (88) are called the chain rules for entropies. Strictly speaking, the right hand side of Eq. (94) should read “for each $y$, ${\rm P}(X=x|Y=y)>0$ for one and only one $x$ ”.

## Appendix B The Equivalence Relation that Induces Causal States

Any relation that is reflexive, symmetric, and transitive is an equivalence relation.

Consider the set ${\stackrel{{\scriptstyle\leftarrow}}{{\rm{\bf S}}}}$ of all past sequences, of any length:

$$
{\stackrel{{\scriptstyle\leftarrow}}{{\rm{\bf S}}}}=\{{\stackrel{{\scriptstyle\leftarrow}}{{s}}}^{L}=s_{L-1}\cdots s_{-1}:\;s_{i}\in{\cal A},\;L\in{\mathbb{Z}}^{+}\}\;.
$$

Recall that ${\stackrel{{\scriptstyle\leftarrow}}{{s}}}^{0}=\lambda$, the empty string. We define the relation ${\sim}_{\epsilon}$ over ${\stackrel{{\scriptstyle\leftarrow}}{{\rm{\bf S}}}}$ by

$$
{\stackrel{{\scriptstyle\leftarrow}}{{s_{i}}}}^{K}~{\sim}_{\epsilon}~{\stackrel{{\scriptstyle\leftarrow}}{{s_{j}}}}^{L}\;\Leftrightarrow\;{\rm P}(\stackrel{{\scriptstyle\rightarrow}}{{S}}|{\stackrel{{\scriptstyle\leftarrow}}{{s_{i}}}}^{K})={\rm P}(\stackrel{{\scriptstyle\rightarrow}}{{S}}|{\stackrel{{\scriptstyle\leftarrow}}{{s_{j}}}}^{L})\;,
$$

for all semi-infinite $\stackrel{{\scriptstyle\rightarrow}}{{S}}=s_{0}s_{1}s_{2}\cdots$, where $K,L\in{\mathbb{Z}}^{+}$. Here we show that $\sim_{\epsilon}$ is an equivalence relation by reviewing the basic properties of relations, equivalence classes, and partitions. (The proof details are straightforward and are not included. See Ref. [^87].) We will drop the length variables $K$ and $L$ and denote by ${\stackrel{{\scriptstyle\leftarrow}}{{s}}},{\stackrel{{\scriptstyle\leftarrow}}{{s}}}^{\prime},{\stackrel{{\scriptstyle\leftarrow}}{{s}}}^{\prime\prime}\in\,{\stackrel{{\scriptstyle\leftarrow}}{{\rm{\bf S}}}}$ members of any length in the set ${\stackrel{{\scriptstyle\leftarrow}}{{\rm{\bf S}}}}$ of Eq. (97).

First, ${\sim}_{\epsilon}$ is a relation on ${\stackrel{{\scriptstyle\leftarrow}}{{\rm{\bf S}}}}$ since we can represent it as a subset of the Cartesian product

$$
{\stackrel{{\scriptstyle\leftarrow}}{{\rm{\bf S}}}}\times{\stackrel{{\scriptstyle\leftarrow}}{{\rm{\bf S}}}}=\{({\stackrel{{\scriptstyle\leftarrow}}{{s}}},{\stackrel{{\scriptstyle\leftarrow}}{{s}}}^{\prime}):{\stackrel{{\scriptstyle\leftarrow}}{{s}}},{\stackrel{{\scriptstyle\leftarrow}}{{s}}}^{\prime}\in{\stackrel{{\scriptstyle\leftarrow}}{{\rm{\bf S}}}}\}\;.
$$

Second, the relation ${\sim}_{\epsilon}$ is an equivalence relation on ${\stackrel{{\scriptstyle\leftarrow}}{{\rm{\bf S}}}}$ since it is

1. reflexive: ${\stackrel{{\scriptstyle\leftarrow}}{{s}}}{\sim}_{\epsilon}{\stackrel{{\scriptstyle\leftarrow}}{{s}}}$, for all ${\stackrel{{\scriptstyle\leftarrow}}{{s}}}\in{\stackrel{{\scriptstyle\leftarrow}}{{\rm{\bf S}}}}$;
2. symmetric: ${\stackrel{{\scriptstyle\leftarrow}}{{s}}}{\sim}_{\epsilon}{\stackrel{{\scriptstyle\leftarrow}}{{s}}}^{\prime}\Rightarrow{\stackrel{{\scriptstyle\leftarrow}}{{s}}}^{\prime}{\sim}_{\epsilon}{\stackrel{{\scriptstyle\leftarrow}}{{s}}}$; and
3. transitive: ${\stackrel{{\scriptstyle\leftarrow}}{{s}}}{\sim}_{\epsilon}{\stackrel{{\scriptstyle\leftarrow}}{{s}}}^{\prime}\;{\rm and}\;{\stackrel{{\scriptstyle\leftarrow}}{{s}}}^{\prime}{\sim}_{\epsilon}{\stackrel{{\scriptstyle\leftarrow}}{{s}}}^{\prime\prime}\Rightarrow{\stackrel{{\scriptstyle\leftarrow}}{{s}}}{\sim}_{\epsilon}{\stackrel{{\scriptstyle\leftarrow}}{{s}}}^{\prime\prime}$.

Third, if ${\stackrel{{\scriptstyle\leftarrow}}{{s}}}\in{\stackrel{{\scriptstyle\leftarrow}}{{\rm{\bf S}}}}$, the equivalence class of ${\stackrel{{\scriptstyle\leftarrow}}{{s}}}$ is

$$
[{\stackrel{{\scriptstyle\leftarrow}}{{s}}}]=\{{\stackrel{{\scriptstyle\leftarrow}}{{s}}}^{\prime}\in{\stackrel{{\scriptstyle\leftarrow}}{{\rm{\bf S}}}}:{\stackrel{{\scriptstyle\leftarrow}}{{s}}}^{\prime}{\sim}_{\epsilon}{\stackrel{{\scriptstyle\leftarrow}}{{s}}}\}\;.
$$

The set of all equivalence classes in ${\stackrel{{\scriptstyle\leftarrow}}{{\rm{\bf S}}}}$ is denoted ${\stackrel{{\scriptstyle\leftarrow}}{{\rm{\bf S}}}}/{\sim}_{\epsilon}$ and is called the factor set of ${\stackrel{{\scriptstyle\leftarrow}}{{\rm{\bf S}}}}$ with respect to ${\sim}_{\epsilon}$. In Sec. IV.1 we called the individual equivalence classes causal states ${\cal S}_{i}$ and denoted the set of causal states $\boldsymbol{{\cal S}}=\{{\cal S}_{i}:i=0,1,\ldots,k-1\}$. That is, $\boldsymbol{{\cal S}}={\stackrel{{\scriptstyle\leftarrow}}{{\rm{\bf S}}}}/{\sim}_{\epsilon}$. (We noted in the main development that the cardinality $k=|\boldsymbol{{\cal S}}|$ of causal states may or may not be finite.)

Finally, we list several basic properties of the causal-state equivalence classes.

1. $\bigcup_{{\stackrel{{\scriptstyle\leftarrow}}{{s}}}\in{\stackrel{{\scriptstyle\leftarrow}}{{\rm{\bf S}}}}}[{\stackrel{{\scriptstyle\leftarrow}}{{s}}}]={\stackrel{{\scriptstyle\leftarrow}}{{\rm{\bf S}}}}\;$.
2. $\bigcup_{i=0}^{k-1}{\cal S}_{i}={\stackrel{{\scriptstyle\leftarrow}}{{\rm{\bf S}}}}\;$.
3. $[{\stackrel{{\scriptstyle\leftarrow}}{{s}}}]=[{\stackrel{{\scriptstyle\leftarrow}}{{s}}}^{\prime}]\Leftrightarrow\,{\stackrel{{\scriptstyle\leftarrow}}{{s}}}{\sim}_{\epsilon}{\stackrel{{\scriptstyle\leftarrow}}{{s}}}^{\prime}\;$.
4. If ${\stackrel{{\scriptstyle\leftarrow}}{{s}}},{\stackrel{{\scriptstyle\leftarrow}}{{s}}}^{\prime}\in{\stackrel{{\scriptstyle\leftarrow}}{{\rm{\bf S}}}}$, either
	1. $[{\stackrel{{\scriptstyle\leftarrow}}{{s}}}]\bigcap\,[{\stackrel{{\scriptstyle\leftarrow}}{{s}}}^{\prime}]=\emptyset$ or
	2. $[{\stackrel{{\scriptstyle\leftarrow}}{{s}}}]=[{\stackrel{{\scriptstyle\leftarrow}}{{s}}}^{\prime}]\;$.
5. The causal states $\boldsymbol{{\cal S}}$ are a partition of ${\stackrel{{\scriptstyle\leftarrow}}{{\rm{\bf S}}}}$. That is,
	1. ${\cal S}_{i}\neq\emptyset$ for each $i$,
	2. $\bigcup_{i=0}^{k-1}{\cal S}_{i}={\stackrel{{\scriptstyle\leftarrow}}{{\rm{\bf S}}}}$, and
	3. ${\cal S}_{i}\cap{\cal S}_{j}=\emptyset$ for all $i\neq j$.

We denote the start state with ${\cal S}_{0}$. The start state is the causal state associated with ${\stackrel{{\scriptstyle\leftarrow}}{{s}}}=\lambda$. That is, ${\cal S}_{0}=[\lambda]$.

## Appendix C Time Reversal

The definitions and properties of the causal states obtained by scanning sequences in the opposite direction, i.e., the causal states $\stackrel{{\scriptstyle\rightarrow}}{{\bf S}}/{\sim}_{\epsilon}$, follow similarly to those derived just above in App. B. In general, ${\stackrel{{\scriptstyle\leftarrow}}{{\rm{\bf S}}}}/{\sim}_{\epsilon}\;\neq\;\stackrel{{\scriptstyle\rightarrow}}{{\bf S}}/{\sim}_{\epsilon}$. That is, past causal states are not necessarily the same as future causal states; past and future morphs can differ; unlike entropy rate [^15], past and future statistical complexities need not be equal: $\stackrel{{\scriptstyle\leftarrow}}{{C_{\mu}}}\neq\stackrel{{\scriptstyle\rightarrow}}{{C_{\mu}}}$; and so on. The presence or lack of this type of time-reversal symmetry, as reflected in these inequalities, is a fundamental property of a process.

## Appendix D ϵ\\epsilon-Machines are Monoids

A semi-group is a set of elements closed under an associative binary operator, but without a guarantee that every, or indeed any, element has an inverse [^88]. A monoid is a semi-group with an identity element. Thus, semi-groups and monoids are generalizations of groups. Just as the algebraic structure of a group is generally interpreted as a symmetry, we propose to interpret the algebraic structure of a semi-group as a generalized symmetry. The distinction between monoids and other semi-groups becomes important here: only semi-groups with an identity element—i.e., monoids—can contain subsets that are groups and so represent conventional symmetries.

We claim that the transformations that concatenate strings of symbols from ${\cal A}$ onto other such strings form a semi-group $G$, the generators of which are the transformations that concatenate the elements of ${\cal A}$. The identity element is to be provided by concatenating the null symbol $\lambda$. The concatenation of string $t$ onto the string $s$ is forbidden if and only if strings of the form $st$ have probability zero in a process. All such concatenations are to be realized by a single semi-group element denoted $\emptyset$. Since if ${\rm P}(st)=0$, then ${\rm P}(stu)={\rm P}(ust)=0$ for any string $u$, we require that $\emptyset g=g\emptyset=\emptyset$ for all $g\in G$. Can we provide a representation of this semi-group?

Recall that, from our definition of the labeled transition probabilities, ${T}^{(\lambda)}_{ij}=\delta_{ij}$. Thus, ${\bf T}^{(\lambda)}$ is an identity element. This suggests using the labeled transition matrices to form a matrix representation of the semi-group. Accordingly, first define ${U}^{(s)}_{ij}$ by setting ${U}^{(s)}_{ij}=0$ when ${T}^{(s)}_{ij}=0$ and ${U}^{(s)}_{ij}=1$ otherwise, to remove probabilities. Then define the set of matrices $\bf{U}=\{{\bf T}^{(\lambda)}\}\bigcup\{{\bf{U}}^{(s)}~,s\in{\cal A}\}$. Finally, define $G$ as the set of all matrices generated from the set $\mathbf{U}$ by recursive multiplication. That is, an element $g$ of $G$ is

$$
g^{(ab\ldots cd)}={\mathbf{U}}^{(d)}{\mathbf{U}}^{(c)}\ldots{\mathbf{U}}^{(b)}{\mathbf{U}}^{(a)}~,
$$

where $a,b,\ldots c,d\in{\cal A}$. Clearly, $G$ constitutes a semi-group under matrix multiplication. Moreover, ${g}^{(a\ldots bc)}=\mathbf{0}$ (the all-zero matrix) if and only if, having emitted the symbols $a\ldots b$ in order, we must arrive in a state from which it is impossible to emit the symbol $c$. That is, the zero-matrix $\mathbf{0}$ is generated if and only if the concatenation of $c$ onto $a\ldots b$ is forbidden. The element $\emptyset$ is thus the all-zero matrix $\mathbf{0}$, which clearly satisfies the necessary constraints. This completes the proof of Proposition 1.

We call the matrix representation—Eq. (101) taken over all words in ${\cal A}^{k}$ —of $G$ the semi-group machine of the $\epsilon$ -machine $\{\boldsymbol{{\cal S}},{\bf T}\}$. See Ref. [^89].

## Appendix E Alternate Proof of the Refinement Lemma

The proof of Lemma 7 carries through verbally, but we do not wish to leave loop-holes. Unfortunately, this means introducing two new bits of mathematics.

First of all, we need the largest classes that are strictly homogeneous (Def. 6) with respect to ${\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{L}$ for fixed $L$; these are, so to speak, truncations of the causal states. Accordingly, we will talk about ${\cal S}^{L}$ and $\sigma^{L}$, which are analogous to ${\cal S}$ and $\sigma$. We will also need to define the function $\phi_{\sigma\rho}^{L}\equiv{\rm P}({\cal S}^{L}=\sigma^{L}|{\cal R}=\rho)$.

Putting these together, for every $L$ we have

$$
\displaystyle H[{\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{L}|{\cal R}=\rho]
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle H[\sum_{{\sigma}^{L}}{{\phi}_{\sigma\rho}^{L}{\rm P}({\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{L}|{{\cal S}}^{L}={\sigma}^{L})}]
$$
 
$$
\displaystyle\geq
$$
 
$$
\displaystyle\sum_{{\sigma}^{L}}{{\phi}_{\sigma\rho}^{L}H[{\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{L}|{{\cal S}}^{L}={\sigma}^{L}]}~.
$$

Thus,

$$
\displaystyle H[{\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{L}
$$
 
$$
\displaystyle|
$$
 
$$
\displaystyle{\cal R}]=\sum_{\rho}{{\rm P}({\cal R}=\rho)H[{\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{L}|{\cal R}=\rho]}
$$
 
$$
\displaystyle\geq
$$
 
$$
\displaystyle\sum_{\rho}{{\rm P}({\cal R}=\rho)\sum_{{\sigma}^{L}}{{\phi}_{\sigma\rho}^{L}H[{\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{L}|{{\cal S}}^{L}={\sigma}^{L}]}}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\sum_{{\sigma}^{L},\rho}{{\rm P}({\cal R}=\rho){\phi}_{\sigma\rho}^{L}H[{\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{L}|{{\cal S}}^{L}={\sigma}^{L}]}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\sum_{{\sigma}^{L},\rho}{{\rm P}({{\cal S}}^{L}={\sigma}^{L}{,\;}{\cal R}=\rho)H[{\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{L}|{{\cal S}}^{L}={\sigma}^{L}]}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\sum_{{\sigma}^{L}}{{\rm P}({{\cal S}}^{L}={\sigma}^{L})H[\stackrel{{\scriptstyle\rightarrow}}{{S}}|{{\cal S}}^{L}={\sigma}^{L}]}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle H[{\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{L}|{{\cal S}}^{L}]~.
$$

That is to say,

$$
\displaystyle H[{\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{L}|{\cal R}]
$$
 
$$
\displaystyle\geq
$$
 
$$
\displaystyle H[{\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{L}|{{\cal S}}^{L}]~,
$$

with equality if and only if every ${\phi}_{\sigma\rho}^{L}$ is either $0$ or $1$. Thus, if $H[{\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{L}|\hat{{\cal R}}]=H[\stackrel{{\scriptstyle\rightarrow}}{{S}}|{{\cal S}}^{L}]$, every $\hat{\rho}$ is entirely contained within some ${\sigma}^{L}$; except for possible subsets of measure $0$. But if this is true for every $L$ —which, in the case of a prescient rival $\hat{{\cal R}}$, it is—then every $\hat{\rho}$ is at least weakly homogeneous (Def. 7) with respect to all ${\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{L}$. Thus, by Lemma 3, all its members, except for that same subset of measure $0$, belong to the same causal state. QED.

## Appendix F Finite Entropy for the Semi-Infinite Future

While cases where $H[\stackrel{{\scriptstyle\rightarrow}}{{S}}]$ is finite—more exactly, where $\lim_{L\rightarrow\infty}{H[{\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{L}]}$ exists and is finite—may be uninteresting for information-theorists, they are of great interest to physicists, since they correspond, among other things, to periodic and limit-cycle behaviors. There are, however, only two substantial differences between what is true of the infinite-entropy processes considered in the main body of the development and the finite-entropy case.

First, we can simply replace statements of the form “for all $L$, $H[{\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{L}]$ …” with $H[\stackrel{{\scriptstyle\rightarrow}}{{S}}]$. For example, the optimal prediction theorem (Thm. 42) for finite-entropy processes becomes for all $\boldsymbol{{\cal R}}$, $H[\stackrel{{\scriptstyle\rightarrow}}{{S}}|{\cal R}]\geq H[\stackrel{{\scriptstyle\rightarrow}}{{S}}|{\cal S}]$. The details of the proofs are, however, entirely analogous.

Second, we can prove a substantially stronger version of the control theorem (Thm. 6).

###### Theorem 7 (The Finite-Control Theorem)

For all prescient rivals $\boldsymbol{\hat{{\cal R}}}$,

$$
H[\stackrel{{\scriptstyle\rightarrow}}{{S}}]-H[\stackrel{{\scriptstyle\rightarrow}}{{S}}|\hat{{\cal R}}]\leq C_{\mu}~.
$$

Proof. By a direct application of Eq. (91) and the definition of mutual information Eq. (8), we have that

$$
H[\stackrel{{\scriptstyle\rightarrow}}{{S}}]-H[\stackrel{{\scriptstyle\rightarrow}}{{S}}|{\cal S}]\leq H[{\cal S}]~.
$$

But, by the definition of prescient rivals (Def. 45), $H[\stackrel{{\scriptstyle\rightarrow}}{{S}}|{\cal S}]=H[\stackrel{{\scriptstyle\rightarrow}}{{S}}|\hat{{\cal R}}]$, and, by definition, $C_{\mu}=H[{\cal S}]$. Substituting equals for equals gives us the theorem. QED.

## Appendix G Relations to Other Fields

### G.1 Time Series Modeling

The goal of time series modeling is to predict the future of a measurement series on the basis of its past. Broadly speaking, this can be divided into two parts: identify equivalent pasts and then produce a prediction for each class of equivalent pasts. That is, we first pick a function $\eta:{\stackrel{{\scriptstyle\leftarrow}}{{\rm{\bf S}}}}\mapsto\boldsymbol{{\cal R}}$ and then pick another function $p:\boldsymbol{{\cal R}}\mapsto\stackrel{{\scriptstyle\rightarrow}}{{\rm{\bf S}}}$. Of course, we can choose for the range of $p$ futures of some finite length (length 1 is popular) or even choose distributions over these. While practical applications often demand a single definite prediction—“You will meet a tall dark stranger”, there are obvious advantages to predicting a distribution—“You have a $.95$ chance of meeting a tall dark stranger and a $.05$ chance of meeting a tall familiar albino.” Clearly, the best choice for $p$ is the actual conditional distribution of futures for each $\rho\in\boldsymbol{{\cal R}}$. Given this, the question becomes what the best $\boldsymbol{{\cal R}}$ is; i.e., What is the best $\eta$? At least in the case of trying to understand the whole of the underlying process, we have shown that the best $\eta$ is, unambiguously, $\epsilon$. Thus, our discussion has implicitly subsumed that of traditional time series modeling.

Computational mechanics—in its focus on letting the process speak for itself through (possibly impoverished) measurements—follows the spirit that motivated one approach to experimentally testing dynamical systems theory. Specifically, it follows in spirit the methods of reconstructing “geometry from a time series” introduced by Refs. [^90] and [^91]. A closer parallel is found, however, in later work on estimating minimal equations of motion from data series [^92].

### G.2 Decision-Theoretic Problems

The classic focus of decision theory is “rules of inductive behavior” [^93] [^94] [^95]. The problem is to chose functions from observed data to courses of action that possess desirable properties. This task has obvious affinities to considering the properties of $\epsilon$ and its rivals $\eta$. We can go further and say that what we have done is consider a decision problem, in which the available actions consist of predictions about the future of the process. The calculation of the optimum rule of behavior in general faces formidable technicalities, such as providing an estimate of the utility of every different course of action under every different hypothesis about the relevant aspects of the world. On the one hand, it is not hard to concoct time-series tasks where the optimal rule of behavior does not use $\epsilon$ at all. On the other hand, if we simply aim to predict the process indefinitely far into the future, then because the causal states are minimal sufficient statistics for the distribution of futures (Thm. 47, Remark 4), the optimal rule of behavior will use $\epsilon$.

### G.3 Stochastic Processes

Clearly, the computational mechanics approach to patterns and pattern discovery involves stochastic processes in an intimate and inextricable way. Probabilists have, of course, long been interested in using information-theoretic tools to analyze stochastic processes, particularly their ergodic behavior [^59] [^96] [^97] [^98]. There has also been considerable work in the hidden Markov model and optimal prediction literatures on inferring models of processes from data or from given distributions [^10] [^99] [^100] [^101] [^102]. To the best of our knowledge, however, these two approaches have not been previously combined.

Perhaps the closest approach to the spirit of computational mechanics in the stochastic process literature is, surprisingly, the now-classical theory of optimal prediction and filtering for stationary processes, developed by Wiener and Kolmogorov [^103] [^104] [^105] [^106]. The two theories share the use of information-theoretic notions, the unification of prediction and structure, and the conviction that “the statistical mechanics of time series” is a “field in which conditions are very remote from those of the statistical mechanics of heat engines and which is thus very well suited to serve as a model of what happens in the living organism” [^106]. So far as we have been able to learn, however, no one has ever used this theory to explicitly identify causal states and causal structure, leaving these implicit in the mathematical form of the prediction and filtering operators. Moreover, the Wiener-Kolmogorov framework forces us to sharply separate the linear and nonlinear aspects of prediction and filtering, because it has a great deal of trouble calculating nonlinear operators [^105]. Computational mechanics is completely indifferent to this issue, since it packs all of the process’s structure into the $\epsilon$ -machine, which is equally calculable in linear or strongly nonlinear situations.

### G.4 Formal Language Theory and Grammatical Inference

A formal language is a set of symbol strings (“words” or “allowed words”) drawn from a finite alphabet. Every formal language may be described either by a set of rules (a “grammar”) for creating all and only the allowed words, by an abstract automaton which also generates the allowed words, or by an automaton which accepts the allowed words and rejects all “forbidden” words. Our $\epsilon$ -machines, stripped of probabilities, correspond to such automata—generative in the simple case or classificatory, if we add a reject state and move to it when none of the allowed symbols are encountered.

Since Chomsky [^107] [^108], it has been known that formal languages can be classified into a hierarchy, the higher levels of which have strictly greater expressive power. The hierarchy is defined by restricting the form of the grammatical rules or, equivalently, by limiting the amount and kind of memory available to the automata. The lowest level of the hierarchy is that of regular languages, which may be familiar to Unix-using readers as regular expressions. These correspond to finite-state machines and to hidden Markov models of finite dimension. In such cases, relatives of our minimality and uniqueness theorems are well known [^66], and the construction of causal states is analogous to the “Nerode equivalence classing” procedure [^66] [^109]. Our theorems, however, are not restricted to this low-memory, non-stochastic setting.

The problem of learning a language from observational data has been extensively studied by linguists, and by computer scientists interested in natural-language processing. Unfortunately, well developed learning techniques exist only for the two lowest classes in the Chomsky hierarchy, the regular and the context-free languages. (For a good account of these procedures see Ref. [^110].) Adapting and extending this work to the reconstruction of $\epsilon$ -machines should form a useful area of future research, a point to which we alluded in the concluding remarks.

### G.5 Computational and Statistical Learning Theory

The goal of computational learning theory [^111] [^112] is to identify algorithms that quickly, reliably, and simply lead to good representations of a target “concept”. The latter is typically defined to be a binary dichotomy of a certain feature or input space. Particular attention is paid to results about “probably approximately correct” (PAC) procedures [^113]: those having a high probability of finding members of a fixed “representation class” (e.g., neural nets, Boolean functions in disjunctive normal form, and deterministic finite automata). The key word here is “fixed”; as in contemporary time-series analysis, practitioners of this discipline acknowledge the importance of getting the representation class right. (Getting it wrong can make easy problems intractable.) In practice, however, they simply take the representation class as a given, even assuming that we can always count on it having at least one representation which exactly captures the target concept. Although this is in line with implicit assumptions in most of mathematical statistics, it seems dubious when analyzing learning in the real world [^5] [^114] [^115].

In any case, the preceding development made no such assumption. One of the goals of computational mechanics is, exactly, discovering the best representation. This is not to say that the results of computational learning theory are not remarkably useful and elegant, nor that one should not take every possible advantage of them in implementing $\epsilon$ -machine reconstruction. In our view, though, these theories belong more to statistical inference, particularly to algorithmic parameter estimation, than to foundational questions about the nature of pattern and the dynamics of learning.

Finally, in a sense computational mechanics’ focus on causal states is a search for a particular kind of structural decomposition for a process. That decomposition is most directly reflected in the conditional independence of past and future that causal states induce. This decomposition reminds one of the important role that conditional independence plays in contemporary methods for artificial intelligence, both for developing systems that reason in fluctuating environments [^116] and the more recently developed algorithmic methods of graphical models [^117] [^118].

### G.6 Description-Length Principles and Universal Coding Theory

Rissanen’s minimum description length (MDL) principle, most fully described in Ref. [^46], is a procedure for selecting the most concise generative model out of a family of models that are all statistically consistent with given data. The MDL approach starts from Shannon’s results on the connection between probability distributions and codes. Rissanen’s development follows the inductive framework introduced by Solomonoff [^43].

Suppose we choose a representation that leads to a class $\cal M$ of models and are given data set $X$. The MDL principle enjoins us to pick the model ${\rm M}\in{\cal M}$ that minimizes the sum of the length of the description of $X$ given $\rm M$, plus the length of description of $\rm M$ given $\cal M$. The description length of $X$ is taken to be $-\log{{\rm P}(X|{\rm M})}$; cf. Eq. (5). The description length of ${\rm M}$ may be regarded as either given by some coding scheme or, equivalently, by some distribution over the members of ${\cal M}$. (Despite the similarities to model estimation in a Bayesian framework [^119], Rissanen does not interpret this distribution as a Bayesian prior or regard description length as a measure of evidential support.)

The construction of causal states is somewhat similar to the states estimated in Rissanen’s context algorithm [^46] [^120] (and to the “vocabularies” built by universal coding schemes, such as the popular Lempel-Ziv algorithm [^121] [^122]). Despite the similarities, there are significant differences. For a random source—for which there is a single causal state—the context algorithm estimates a number of states that diverges (at least logarithmically) with the length of the data stream, rather than inferring a single state, as $\epsilon$ -machine reconstruction would. Moreover, we avoid any reference to encodings of rival models or to prior distributions over them; $C_{\mu}(\boldsymbol{{\cal R}})$ is not a description length.

### G.7 Measure Complexity

Ref. [^75] proposed that the appropriate measure of the complexity of a process was the “minimal average Shannon information needed” for optimal prediction. This true measure complexity was to be taken as the Shannon entropy of the states used by some optimal predictor. The same paper suggested that it could be approximated (from below) by the excess entropy; there called the effective measure complexity, as noted in Sec. VI above. This is a position closely allied to that of computational mechanics, to Rissanen’s MDL principle, and to the minimal embeddings introduced by the “geometry of a time series” methods [^90] just described.

In contrast to computational mechanics, however, the key notion of “optimal prediction” was left undefined, as were the nature and construction of the states of the optimal predictor. In fact, the predictors used required knowing the process’s underlying equations of motion. Moreover, the statistical complexity $C_{\mu}(\boldsymbol{{\cal S}})$ differs from the measure complexities in that it is based on the well defined causal states, whose optimal predictive powers are in turn precisely defined. Thus, computational mechanics is an operational and constructive formalization of the insights expressed in Ref. [^75].

### G.8 Hierarchical Scaling Complexity

Introduced in Ref. [^123], this approach seeks, like computational mechanics, to extend certain traditional ideas of statistical physics. In brief, the method is to construct a hierarchy of ${n}^{th}$ -order Markov models and examine the convergence of their predictions with the real distribution of observables as $n\rightarrow\infty$. The discrepancy between prediction and reality is, moreover, defined information theoretically, in terms of the relative entropy or Kullback-Leibler distance [^62] [^71]. (We have not used this quantity.) The approach implements Weiss’s discovery that for finite-state sources there is a structural distinction between block-Markovian sources (subshifts of finite type) and sofic systems. Weiss showed that, despite their finite memory, sofic systems are the limit of an infinite series of increasingly larger block-Markovian sources [^124].

The hierarchical-scaling-complexity approach has several advantages, particularly its ability to handle issues of scaling in a natural way (see Ref. [^123]). Nonetheless, it does not attain all the goals set in Sec. II.6. Its Markovian predictors are so many black boxes, saying little or nothing about the hidden states of the process, their causal connections, or the intrinsic computation carried on by the process. All of these properties, as we have shown, are manifest from the $\epsilon$ -machine. We suggest that a productive line of future work would be to investigate the relationship between hierarchical scaling complexity and computational mechanics, and to see whether they can be synthesized. Along these lines, hierarchical scaling complexity reminds us somewhat of hierarchical $\epsilon$ -machine reconstruction described in Ref. [^5].

### G.9 Continuous Dynamical Computing

Using dynamical systems as computers has become increasingly attractive over the last ten years or so among physicists, computer scientists, and others exploring the physical basis of computation [^125] [^126] [^127] [^128]. These proposals have ranged from highly abstract ideas about how to embed Turing machines in discrete-time nonlinear continuous maps [^7] [^129] to, more recently, schemes for specialized numerical computation that could in principle be implemented in current hardware [^130]. All of them, however, have been synthetic, in the sense that they concern designing dynamical systems that implement a given desired computation or family of computations. In contrast, one of the central questions of computational mechanics is exactly the converse: given a dynamical system, how can one detect what it is intrinsically computing?

We believe that having a mathematical basis and a set of tools for answering this question are important to the synthetic, engineering approach to dynamical computing. Using these tools we may be able to discover, for example, novel forms of computation embedded in natural processes that operate at higher speeds, with less energy, and with fewer physical degrees of freedom than currently possible.

## References

## Glossary of Notation

In the order of their introduction.

| Symbol | Description | Where Introduced |
| --- | --- | --- |
| ${\cal O}$ | Object in which we wish to find a pattern | Sec. II, p. II |
| ${\cal P}$ | Pattern in ${\cal O}$ | Sec. II, p. II |
| ${\cal A}$ | Countable alphabet | Sec. III.1, p. III.1 |
| $\stackrel{{\scriptstyle\leftrightarrow}}{{S}}$ | Bi-infinite, stationary, discrete stochastic process on ${\cal A}$ | Def. 1, p. 1 |
| $\stackrel{{\scriptstyle\leftrightarrow}}{{s}}$ | Particular realization of $\stackrel{{\scriptstyle\leftrightarrow}}{{S}}$ | Def. 1, p. 1 |
| ${\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{L}$ | Random variable for the next $L$ values of $\stackrel{{\scriptstyle\leftrightarrow}}{{S}}$ | Sec. III.1, p. 1 |
| ${\stackrel{{\scriptstyle\rightarrow}}{{s}}}^{L}$ | Particular value of ${\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{L}$ | Sec. III.1, p. 1 |
| ${\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{1}$ | Next observable generated by $\stackrel{{\scriptstyle\leftrightarrow}}{{S}}$ | Sec. III.1, p. 1 |
| ${\stackrel{{\scriptstyle\leftarrow}}{{S}}}^{L}$ | As ${\stackrel{{\scriptstyle\rightarrow}}{{S}}}^{L}$, but for the last $L$ values, up to the present | Sec. III.1, p. 1 |
| ${\stackrel{{\scriptstyle\leftarrow}}{{s}}}^{L}$ | Particular value of ${\stackrel{{\scriptstyle\leftarrow}}{{S}}}^{L}$ | Sec. III.1, p. 1 |
| $\stackrel{{\scriptstyle\rightarrow}}{{S}}$ | Semi-infinite future half of $\stackrel{{\scriptstyle\leftrightarrow}}{{S}}$ | Sec. III.1, p. 1 |
| $\stackrel{{\scriptstyle\rightarrow}}{{s}}$ | Particular value of $\stackrel{{\scriptstyle\rightarrow}}{{S}}$ | Sec. III.1, p. 1 |
| $\stackrel{{\scriptstyle\leftarrow}}{{S}}$ | Semi-infinite past half of $\stackrel{{\scriptstyle\leftrightarrow}}{{S}}$ | Sec. III.1, p. 1 |
| ${\stackrel{{\scriptstyle\leftarrow}}{{s}}}$ | Particular value of $\stackrel{{\scriptstyle\leftarrow}}{{S}}$ | Sec. III.1, p. 1 |
| $\lambda$ | Null string or null symbol | Sec. III.1, p. 1 |
| ${\stackrel{{\scriptstyle\leftarrow}}{{\rm{\bf S}}}}$ | Set of all pasts realized by the process $\stackrel{{\scriptstyle\leftrightarrow}}{{S}}$ | Sec. III.2, p. III.2 |
| $\boldsymbol{{\cal R}}$ | Partition of ${\stackrel{{\scriptstyle\leftarrow}}{{\rm{\bf S}}}}$ into effective states | Sec. III.2, p. III.2 |
| $\rho$ | Member-class of $\boldsymbol{{\cal R}}$; a particular effective state | Sec. III.2, p. III.2 |
| $\eta$ | Function from ${\stackrel{{\scriptstyle\leftarrow}}{{\rm{\bf S}}}}$ to $\boldsymbol{{\cal R}}$ | Sec. III.2, Eq. (4), p. 4 |
| ${\cal R}$ | Current effective ($\eta$) state, as a random variable | Sec. III.2, p. III.2 |
| ${{\cal R}}^{\prime}$ | Next effective state, as a random variable | Sec. III.2, p. III.2 |
| $H[X]$ | Entropy of the random variable $X$ | Sec. III.3.1, p. III.3.1 |
| $H[X,Y]$ | Joint entropy of the random variables $X$ and $Y$ | Sec. III.3.2, p. III.3.2 |
| $H[X\|Y]$ | Entropy of $X$ conditioned on $Y$ | Sec. III.3.2, p. III.3.2 |
| $I[X;Y]$ | Mutual information of $X$ and $Y$ | Sec. III.3.3, p. III.3.3 |
| $h_{\mu}[\stackrel{{\scriptstyle\rightarrow}}{{S}}]$ | Entropy rate of $\stackrel{{\scriptstyle\rightarrow}}{{S}}$ | Sec. III.4, Eq. (9), p. 9 |
| $h_{\mu}[\stackrel{{\scriptstyle\rightarrow}}{{S}}\|X]$ | Entropy rate of $\stackrel{{\scriptstyle\rightarrow}}{{S}}$ conditioned on $X$ | Sec. III.4, Eq. (10), p. 10 |
| $C_{\mu}(\boldsymbol{{\cal R}})$ | Statistical complexity of $\boldsymbol{{\cal R}}$ | Def. 4, p. 4 |
| $\boldsymbol{{\cal S}}$ | Set of the causal states of $\stackrel{{\scriptstyle\leftrightarrow}}{{S}}$ | Def. 5, p. 5 |
| $\sigma$ | Particular causal state | Def. 5, p. 5 |
| $\epsilon$ | Function from histories to causal states | Def. 5, p. 5 |
| ${\cal S}$ | Current causal state, as a random variable | Def. 5, p. 5 |
| ${{\cal S}}^{\prime}$ | Next causal state, as a random variable | Def. 5, p. 5 |
| ${\sim}_{\epsilon}$ | Relation of causal equivalence between two histories | Sec. IV.1, p. IV.1 |
| ${T}^{(s)}_{ij}$ | Probability of going from causal state $i$ to $j$, emitting $s$ | Def. 24, p. 24 |
| $\boldsymbol{\hat{{\cal R}}}$ | Set of prescient rival states | Def. 45, p. 45 |
| $\hat{\rho}$ | Particular prescient rival state | Def. 45, p. 45 |
| $\hat{{\cal R}}$ | Current prescient rival state, as a random variable | Def. 45, p. 45 |
| ${\hat{{\cal R}}}^{\prime}$ | Next prescient rival state, as a random variable | Def. 45, p. 45 |
| $C_{\mu}({\cal O})$ | Statistical complexity of the process ${\cal O}$ | Def. 12, p. 12 |
| $C_{\mu}$ | Without an argument, short for $C_{\mu}({\cal O})$ | Def. 12, p. 12 |
| ${\bf E}$ | Excess entropy | Def. 61, p. 61 |

[^1]: Julia M. Yeomans. Statistical Mechanics of Phase Transitions. Clarendon Press, Oxford, 1992.

[^2]: Paul Manneville. Dissipative Structures and Weak Turbulence. Academic Press, Boston, Massachusetts, 1990.

[^3]: P. M. Chaikin and T. C. Lubensky. Principles of Condensed Matter Physics. Cambridge University Press, Cambridge, England, 1995.

[^4]: Mark C. Cross and Pierre Hohenberg. Pattern Formation Out of Equilibrium. Reviews of Modern Physics, 65:851–1112, 1993.

[^5]: James P. Crutchfield. The calculi of emergence: Computation, dynamics, and induction. Physica D, 75:11–54, 1994.

[^6]: James P. Crutchfield and Karl Young. Inferring statistical complexity. Physical Review Letters, 63:105–108, 1989.

[^7]: James P. Crutchfield and Karl Young. Computation at the onset of chaos. In Zurek [^131], pages 223–269.

[^8]: Nicolás Perry and P.-M. Binder. Finite statistical complexity for sofic systems. Physical Review E, 60:459–463, 1999.

[^9]: James E. Hanson and James P. Crutchfield. Computational mechanics of cellular automata: An example. Physica D, 103:169–189, 1997.

[^10]: Daniel R. Upper. Theory and Algorithms for Hidden Markov Models and Generalized Hidden Markov Models. PhD thesis, University of California, Berkeley, 1997.

[^11]: James P. Crutchfield and Melanie Mitchell. The evolution of emergent computation. Proceedings of the National Academy of Sciences, 92:10742–10746, 1995.

[^12]: A. Witt, A. Neiman, and J. Kurths. Characterizing the dynamics of stochastic bistable systems by measures of complexity. Physical Review E, 55:5050–5059, 1997.

[^13]: Jordi Delgado and Ricard V. Solé. Collective-induced computation. Physical Review E, 55:2338–2344, 1997.

[^14]: W. M. Gonçalves, R. D. Pinto, J. C. Sartorelli, and M. J. de Oliveira. Inferring statistical complexity in the dripping faucet experiment. Physica A, 257:385–389, 1998.

[^15]: James P. Crutchfield and Cosma Rohilla Shalizi. Thermodynamic depth of causal states: Objective complexity via minimal representations. Physical Review E, 59:275–283, 1999.

[^16]: Jorge Luis Borges. Other Inquisitions, 1937–1952. University of Texas Press, Austin, 1964. Trans. Ruth L. C. Simms.

[^17]: James P. Crutchfield. Semantics and thermodynamics. In Martin Casdagli and Stephen Eubank, editors, Nonlinear Modeling and Forecasting, volume 12 of Santa Fe Institute Studies in the Sciences of Complexity, pages 317–359, Reading, Massachusetts, 1992. Addison-Wesley.

[^18]: Plato. Phaedrus.

[^19]: A. R. Luria. The Working Brain: An Introduction to Neuropsychology. Basic Books, New York, 1973.

[^20]: Norma Van Surdam Graham. Visual Pattern Analyzers, volume 16 of Oxford Psychology Series. Oxford University Press, Oxford, 1989.

[^21]: Sara J. Shettleworth. Cognition, Evolution and Behavior. Oxford University Press, Oxford, 1998.

[^22]: Julius T. Tou and Rafael C. Gonzalez. Pattern Recognition Principles. Addison-Wesley, Reading, Mass, 1974.

[^23]: Stephen P. Banks. Signal Processing, Image Processing, and Pattern Recognition. Prentice Hall, New York, 1990.

[^24]: Jae S. Lim. Two-Dimensional Signal and Image Processing. Prentice Hall, New York, 1990.

[^25]: Plato. Meno. In Sec. 80D Meno says: “How will you look for it, Socrates, when you do not know at all what it is? How will you aim to search for something you do not know at all? If you should meet it, how will you know that this is the thing that you did not know?” The same difficulty is raised in Theaetetus, Sec. 197 et seq.

[^26]: Alfred North Whitehead and Bertrand Russell. Principia Mathematica. Cambridge University Press, Cambridge, England, 2nd edition, 1925–27.

[^27]: Bertrand Russell. Introduction to Mathematical Philosophy. The Muirhead Library of Philosophy. George Allen and Unwin, London, revised edition, 1920. First edition, 1919. Reprinted New York: Dover Books, 1993.

[^28]: James P. Crutchfield. Information and its metric. In L. Lam and H. C. Morris, editors, Nonlinear Structures in Physical Systems—Pattern Formation, Chaos and Waves, page 119, New York, 1990. Springer-Verlag.

[^29]: Bertrand Russell. Human Knowledge: Its Scope and Limits. Simon and Schuster, New York, 1948.

[^30]: John Rhodes. Applications of Automata Theory and Algebra via the Mathematical Theory of Complexity to Biology, Physics, Psychology, Philosophy, Games, and Codes. University of California, Berkeley, California, 1971.

[^31]: Chrystopher L. Nehaniv and John L. Rhodes. Krohn-Rhodes theory, hierarchies, and evolution. In Boris Mirkin, F. R. McMorris, Fred S. Roberts, and Andrey Rzhetsky, editors, Mathematical Hierarchies and Biology: DIMACS workshop, November 13–15, 1996, volume 37 of DIMACS Series in Discrete Mathematics and Theoretical Computer Science, Providence, Rhode Island, 1997. American Mathematical Society.

[^32]: Ulf Grenander. Elements of Pattern Theory. Johns Hopkins Studies in the Mathematical Sciences. Johns Hopkins University Press, Baltimore, Maryland, 1996.

[^33]: Ulf Grenander, Y. Chow, and D. M. Keenan. Hands: A Pattern Theoretic Study of Biological Shapes, volume 2 of Research Notes in Neural Computing. Springer-Verlag, New York, 1991.

[^34]: Ulf Grenander and K. Manbeck. A stochastic shape and color model for defect detection in potatoes. American Statistical Association, 2:131–151, 1993.

[^35]: A. N. Kolmogorov. Three approaches to the quantitative definition of information. Problems of Information Transmission, 1:1–7, 1965.

[^36]: Gregory Chaitin. On the length of programs for computing finite binary sequences. Journal of the Association for Computing Machinery, 13:547–569, 1966.

[^37]: A. N. Kolmogorov. Combinatorial foundations of information theory and the calculus of probabilities. Russ. Math. Surveys, 38:29, 1983.

[^38]: Ming Li and Paul M. B. Vitanyi. An Introduction to Kolmogorov Complexity and its Applications. Springer-Verlag, New York, 1993.

[^39]: Marvin Minsky. Computation: Finite and Infinite Machines. Prentice-Hall, Englewood Cliffs, New Jersey, 1967.

[^40]: P. Martin-Löf. The definition of random sequences. Information and Control, 9:602–619, 1966.

[^41]: L. A. Levin. Laws of information conservation (nongrowth) and aspects of the foundation of probability theory. Problemy Peredachi Informatsii, 10:30–35, 1974. Translation: Problems of Information Transmission 10 (1974) 206–210.

[^42]: V. G. Gurzadyan. Kolmogorov complexity as a descriptor of cosmic microwave background maps. Europhysics Letters, 46:114–117, 1999. Also available as an electronic preprint, LANL archive, astro-phy/9902123.

[^43]: Raymond J. Solomonoff. A formal theory of inductive inference. Information and Control, 7:1–22 and 224–254, 1964.

[^44]: Paul Vitányi and Ming Li. Minimum description length induction, Bayesianism, and Kolmogorov complexity. Electronic pre-print, LANL Archive, cs.LG/9901014, 1999.

[^45]: Gary William Flake. The Computational Beauty of Nature: Computer Explorations of Fractals, Chaos, Complex Systems and Adaptation. MIT Press, Cambridge, Massachusetts, 1998.

[^46]: Jorma Rissanen. Stochastic Complexity in Statistical Inquiry. World Scientific, Singapore, 1989.

[^47]: Charles H. Bennett. How to define complexity in physics, and why. In Zurek [^131], pages 137–148.

[^48]: Moshe Koppel. Complexity, depth, and sophistication. Complex Systems, 1:1087–1091, 1987.

[^49]: Moshe Koppel and Henri Atlan. An almost machine-independent theory of program-length complexity, sophistication and induction. Information Sciences, 56:23–44, 1991.

[^50]: Daniel C. Dennett. Real patterns. Journal of Philosophy, 88:27–51, 1991. Reprinted in Dennett (1997).

[^51]: James P. Crutchfield. Is anything ever new? Considering emergence. In G. Cowan, D. Pines, and D. Melzner, editors, Complexity: Metaphors, Models, and Reality, volume 19 of Santa Fe Institute Studies in the Sciences of Complexity, pages 479–497, Reading, Massachusetts, 1994. Addison-Wesley.

[^52]: John H. Holland. Emergence: From Chaos to Order. Addison-Wesley, Reading, Massachusetts, 1998.

[^53]: Ludwig Boltzmann. Lectures on Gas Theory. University of California Press, Berkeley, 1964.

[^54]: Harald Cramér. Mathematical Methods of Statistics. Almqvist and Wiksells, Uppsala, 1945. Republished by Princeton University Press, 1946, as vol. 9 in the Princeton Mathematics Series, and as a paperback, in the Princeton Landmarks in Mathematics and Physics series, 1999.

[^55]: Claude E. Shannon. A mathematical theory of communication. Bell System Technical Journal, 27:379–423, 1948.

[^56]: David Hume. A Treatise of Human Nature: Being an Attempt to Introduce the Experimental Method of Reasoning into Moral Subjects. John Noon, London, 1739. Reprint (Oxford: Clarendon Press, 1951) of original edition, with notes and analytical index.

[^57]: Mario Bunge. Causality: The Place of the Causal Princple in Modern Science. Harvard University Press, Cambridge, Massachusetts, 1959. Reprinted as Causality and Modern Science, NY: Dover Books, 1979.

[^58]: Wesley C. Salmon. Scientific Explanation and the Causal Structure of the World. Princeton University Press, Princeton, 1984.

[^59]: Patrick Billingsley. Ergodic Theory and Information. Tracts on Probablity and Mathematical Statistics. Wiley, New York, 1965.

[^60]: Patrick Billingsley. Probability and Measure. Wiley Series in Probability and Mathematical Statistics. Wiley, New York, 1979.

[^61]: Bernard F. Schutz. Geometrical Methods of Mathematical Physics. Cambridge University Press, Cambridge, England, 1980.

[^62]: Thomas M. Cover and Joy A. Thomas. Elements of Information Theory. Wiley, New York, 1991.

[^63]: William of Ockham. Philosophical Writings: A Selection, Translated, with an Introduction, by Philotheus Boehner, O.F.M., Late Professor of Philosophy, The Franciscan Institute. Bobbs-Merrill, Indianapolis, 1964. first pub. various European cities, early 1300s.

[^64]: Anonymous. Kuan Yin Tzu, T’ang Dynasty. Written in China during the T’ang dynasty. Partial translation in Joseph Needham, Science and Civilisation in China, vol. II (Cambridge University Press, 1956), p. 73.

[^65]: David P. Feldman and James P. Crutchfield. Discovering non-critical organization: Statistical mechanical, information theoretic, and computational views of patterns in simple one-dimensional spin systems. Journal of Statistical Physics, submitted, 1998. Santa Fe Institute Working Paper 98-04-026, http://www.santafe.edu/projects/CompMech/ papers/ DNCO.html.

[^66]: John E. Hopcroft and Jeffrey D. Ullman. Introduction to Automata Theory, Languages, and Computation. Addison-Wesley, Reading, 1979. 2nd edition of Formal Languages and Their Relation to Automata, 1969.

[^67]: John G. Kemeny and J. Laurie Snell. Finite Markov Chains. Springer-Verlag, New York, 1976.

[^68]: John G. Kemeny, J. Laurie Snell, and Anthony W. Knapp. Denumerable Markov Chains. Springer-Verlag, New York, 2nd edition, 1976.

[^69]: James E. Hanson. Computational Mechanics of Cellular Automata. PhD thesis, University of California, Berkeley, 1993.

[^70]: Gregory Bateson. Mind and Nature: A Necessary Unity. E. P. Dutton, New York, 1979.

[^71]: Solomon Kullback. Information Theory and Statistics. Dover Books, New York, 2nd edition, 1968. First edition New York: Wiley, 1959.

[^72]: Claude Bernard. Introduction a l’etude de la medecine experimentale. J. B. Bailliere, Paris, 1865. Trans. by Henry Copley Green as Introduction to the Study of Experimental Medicine, New York: Macmillian, 1927; reprinted New York: Dover, 1957.

[^73]: James P. Crutchfield and Norman H. Packard. Symbolic dynamics of noisy chaos. Physica D, 7:201–223, 1983.

[^74]: Robert Shaw. The Dripping Faucet as a Model Chaotic System. Aerial Press, Santa Cruz, California, 1984.

[^75]: Peter Grassberger. Toward a quantitative theory of self-generated complexity. International Journal of Theoretical Physics, 25:907–938, 1986.

[^76]: Kristian Lindgren and Mats G. Nordahl. Complexity measures and cellular automata. Complex Systems, 2:409–440, 1988.

[^77]: W. Li. On the relationship between complexity and entropy for Markov chains and regular languages. Complex Systems, 5:381–399, 1991.

[^78]: Dirk Arnold. Information-theoretic analysis of phase transitions. Complex Systems, 10:143–155, 1996.

[^79]: William Bialek and Naftali Tishby. Predictive information. Electronic pre-print, LANL archive, cond-mat/9902341, 1999.

[^80]: James P. Crutchfield and David P. Feldman. Statistical complexity of simple one-dimensional spin systems. Physical Review E, 55:1239R–1243R, 1997.

[^81]: W. Ross Ashby. An Introduction to Cybernetics. Chapman and Hall, London, 1956.

[^82]: Hugo Touchette and Seth Lloyd. Information-theoretic limits of control. Physical Review Letters, 84:1156–1159, 1999.

[^83]: Abraham Lempel and Jacob Ziv. Compression of two-dimensional data. IEEE Transactions in Information Theory, IT-32:2–8, 1986.

[^84]: David P. Feldman. Computational Mechanics of Classical Spin Systems. PhD thesis, University of California, Davis, 1998. Available on-line at http://hornacek.coa.edu/dave/Thesis/thesis.html.

[^85]: Deborah Mayo. Error and the Growth of Experimental Knowledge. Science and Its Conceptual Foundations. University of Chicago Press, Chicago, 1996.

[^86]: James P. Crutchfield and Cristopher Douglas. Imagined complexity: Learning a random process. in preparation, 1999.

[^87]: Rudolf Lidl and Gunter Pilz. Applied Abstract Algebra. Springer, New York, 1984.

[^88]: E. S. Ljapin. Semigroups, volume 3 of Translations of Mathematical Monographs. American Mathematical Society, Providence, Rhode Island, 1963.

[^89]: Karl Young. The Grammar and Statistical Mechanics of Complex Physical Systems. PhD thesis, University of California, Santa Cruz, 1991.

[^90]: Norman H. Packard, James P. Crutchfield, J. Doyne Farmer, and Robert S. Shaw. Geometry from a time series. Physical Review Letters, 45:712–716, 1980.

[^91]: Floris Takens. Detecting strange attractors in fluid turbulence. In D. A. Rand and L. S. Young, editors, Symposium on Dynamical Systems and Turbulence, volume 898 of Lecture Notes in Mathematics, page 366, Berlin, 1981. Springer-Verlag.

[^92]: James P. Crutchfield and Bruce S. McNamara. Equations of motion from a data series. Complex Systems, 1:417–452, 1987.

[^93]: Jerzy Neyman. First Course in Probability and Statistics. Henry Holt, New York, 1950.

[^94]: David Blackwell and M. A. Girshick. Theory of Games and Statistical Decisions. Wiley, New York, 1954. Reprinted New York: Dover Books, 1979.

[^95]: R. Duncan Luce and Howard Raiffa. Games and Decisions: Introduction and Critical Survey. Wiley, New York, 1957.

[^96]: I. M. Gel’fand and A. M. Yaglom. Calculation of the amount of information about a random function contained in another such function. Uspekhi Matematicheski Nauk, 12:3–52, 1956. Trans. in American Mathematical Society Translations, 2nd series, 12 (1959): 199–246.

[^97]: Peter E. Caines. Linear Stochastic Systems. Wiley, New York, 1988.

[^98]: Robert M. Gray. Entropy and Information Theory. Springer-Verlag, New York, 1990.

[^99]: David Blackwell and Lambert Koopmans. On the identifiability problem for functions of finite Markov chains. Annals of Mathematical Statistics, 28:1011–1015, 1957.

[^100]: H. Ito, S.-I. Amari, and K. Kobayashi. Identifiability of hidden Markov information sources and their minimum degrees of freedom. IEEE Transactions on Information Theory, 38:324–333, 1992.

[^101]: H. Jaeger. Observable operator models for discrete stochastic time series. Neural Computation, forthcoming, 1999. ftp://ftp.gmd.de/GMD/ais/ publications/1999/.

[^102]: Paul Algoet. Universal schemes for prediction, gambling and portfolio selection. The Annals of Probability, 20:901–941, 1992. See also an important Correction, The Annals of Probability, 23 (1995): 474–478.

[^103]: A. N. Kolmogorov. Interpolation und extrapolation von stationären zufälligen folgen. Bull. Acad. Sci. U.S.S.R., Math., 3:3–14, 1941. In German.

[^104]: Norbert Wiener. Extrapolation, Interpolation, and Smoothing of Stationary Time Series: With Engineering Applications. The Technology Press of the Massachusetts Institute of Technology, Cambridge, Massachusetts, 1949. “First published during the war as a classifed report to Section ${\rm D}_{2}$, National Defense Research Council”.

[^105]: Norbert Wiener. Nonlinear Problems in Random Theory. The Technology Press of the Massachusetts Institute of Technology, Cambridge, Massachusetts, 1958.

[^106]: Norbert Wiener. Cybernetics: Or, Control and Communication in the Animal and the Machine. MIT Press, Cambridge, Massachusetts, 2nd edition, 1961. First edition New York: Wiley, 1948.

[^107]: Noam Chomsky. Three models for the description of language. IRE Transactions on Information Theory, 2:113, 1956.

[^108]: Noam Chomsky. Syntactic Structures, volume 4 of Janua linguarum, series minor. Mouton, The Hauge, 1957.

[^109]: B. A. Trakhtenbrot and Ya. M. Barzdin. Finite Automata. North-Holland, Amsterdam, 1973.

[^110]: Eugene Charniak. Statistical Language Learning. Language, Speech and Communication. MIT Press, Cambridge, Massachusetts, 1993.

[^111]: Michael J. Kearns and Umesh V. Vazirani. An Introduction to Computational Learning Theory. MIT Press, Cambridge, Massachusetts, 1994.

[^112]: V. N. Vapnik. The Nature of Statistical Learning Theory. Springer-Verlag, Berlin, 2nd edition, 2000.

[^113]: Leslie G. Valiant. A theory of the learnable. Communications of the Association for Computing Machinery, 27:1134–1142, 1984.

[^114]: Margaret A. Boden. Precis of The Creative Mind: Myths and Mechanisms. Behaviorial and Brain Sciences, 17:519–531, 1994.

[^115]: Chris Thornton. Truth from Trash: How Learning Makes Sense. Complex Adaptive Systems. MIT Press, Cambridge, Massachusetts, 2000.

[^116]: Judea Pearl. Causality: Models, Reasoning, and Inference. Cambridge University Press, Cambridge, England, 2000.

[^117]: M. I. Jordan, editor. Learning in Graphical Models, volume 89 of NATO Science Series D: Behavioral and Social Sciences, Dordrecht, 1998.

[^118]: Peter Spirtes, Clark Glymour, and Richard Scheines. Causation, Prediction, and Search. Adaptive Computation and Machine Learning. MIT Press, Cambridge, Massachusetts, 2000.

[^119]: David V. Lindley. Bayesian Statistics, a Review. Society for Industrial and Applied Mathematics, Philadelphia, 1972.

[^120]: Jorma Rissanen. Universal coding, information, prediction, and estimation. IEEE Transactions in Information Theory, IT-30:629–636, 1984.

[^121]: Abraham Lempel and Jacob Ziv. On the complexity of finite sequences. IEEE Transactions in Information Theory, IT-22:75–81, 1976.

[^122]: Jacob Ziv and Abraham Lempel. A universal algorithm for sequential data compression. IEEE Transactions in Information Theory, IT-23:337–343, 1977.

[^123]: Remo Badii and Antonio Politi. Complexity: Hierarchical Structures and Scaling in Physics, volume 6 of Cambridge Nonlinear Science Series. Cambridge University Press, Cambridge, 1997.

[^124]: Benjamin Weiss. Subshifts of finite type and sofic systems. Monatshefte für Mathematik, 77:462–474, 1973.

[^125]: Cristopher Moore. Recursion theory on the reals and continuous-time computation. Theoretical Computer Science, 162:23–44, 1996.

[^126]: Cristopher Moore. Dynamical recognizers: Real-time language recognition by analog computers. Theoretical Computer Science, 201:99–136, 1998.

[^127]: Pekka Orponen. A survey of continuous-time computation theory. In D.-Z. Du and K.-I Ko, editors, Advances in Algorithms, Languages, and Complexity, pages 209–224. Kluwer Academic, Dordrecht, 1997.

[^128]: Lenore Blum, Michael Shub, and Steven Smale. On a theory of computation and complexity over the real numbers: NP-completeness, recursive functions and universal machines. Bulletin of the American Mathematical Society, 21:1–46, 1989.

[^129]: Cristopher Moore. Unpredictability and undecidability in dynamical systems. Physical Review Letters, 64:2354–2357, 1990.

[^130]: Sudeshna Sinha and William L. Ditto. Dynamics based computation. Physical Review Letters, 81:2156–2159, 1998.

[^131]: Wojciech H. Zurek, editor. Complexity, Entropy, and the Physics of Information, volume 8 of Santa Fe Institute Studies in the Sciences of Complexity, Reading, Massachusetts, 1990. Addison-Wesley.