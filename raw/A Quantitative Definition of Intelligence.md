---
title: "A Quantitative Definition of Intelligence"
source: "https://arxiv.org/html/2604.10873v1"
author:
published:
created: 2026-06-23
description:
tags:
  - "clippings"
---
Kang-Sin Choi  
Ewha Womans University  
kangsin@ewha.ac.kr

###### Abstract

We propose an operational, quantitative definition of intelligence for arbitrary physical systems. The intelligence density of a system is the ratio of the logarithm of its independent outputs to its total description length. A system memorizes if its description length grows with its output count; it knows if its description length remains fixed while its output count diverges. The criterion for knowing is generalization: a system knows its domain if a single finite mechanism can produce correct outputs across an unbounded range of inputs, rather than storing each answer individually. We argue that meaning over a domain is a selection and ordering of functions that produces correct outputs, and that a system whose intelligence density diverges necessarily captures this structure. The definition (1) places intelligence on a substrate-independent continuum from logic gates to brains, (2) blocks Putnam’s pancomputationalist triviality argument via an independence condition on outputs, and (3) resolves Searle’s Chinese Room Argument by showing that any finite rulebook handling an infinite domain must generalize.

## 1 Introduction

What is intelligence? Despite a century of research in psychology, artificial intelligence, and philosophy of mind, no consensus definition exists. Legg and Hutter [^22] collected over seventy definitions from the literature and observed that “a fundamental problem in artificial intelligence is that nobody really knows what intelligence is.” The problem is not merely academic. Without a definition, central questions—Can machines understand? Is a large language model intelligent?—reduce to competing intuitions about a term that has never been made precise.

Turing [^39] was the first to approach the question with care. Rather than defining intelligence, he proposed replacing the question “Can machines think?” with a behavioral test. He anticipated virtually every objection raised in the following decades: the argument from consciousness, Lady Lovelace’s objection that machines can only do what we tell them, and the argument from the continuity of the nervous system. He observed that machines “take me by surprise with great frequency,” that the substrate of computation—electrical, mechanical, or otherwise—“cannot be of theoretical importance,” and in a 1951 letter that the difference between machine and brain is “largely a quantitative matter” [^40].

Turing’s intuitions were remarkably prescient, but he stopped short of a formal definition. The present paper supplies one. We propose a single quantitative metric that formalizes what Turing intuited: intelligence is computation, and computation is measurable. The central distinction of this paper is between *memorizing* and *knowing*: a system memorizes if its description length grows with its output count; it knows if its description length remains fixed while its output count diverges. This distinction is not a matter of degree but of asymptotic structure, and it is the formal content of the intuition that intelligence is generalization. The central criterion is not the absolute value of the metric but its *scaling behavior*: a system knows its domain if, as the domain of inputs grows without bound, its intelligence density diverges rather than vanishes. A persistent source of confusion in this area has been the conflation of intelligence with consciousness [^36]. We define intelligence only. Consciousness—whether it exists, what it requires, whether machines can have it—is a separate question, beyond our scope.

The paper proceeds as follows. Section 2 motivates the definition through Searle’s Chinese Room Argument. Section 3 gives the formal definition and analyzes its properties. Section 4 relates the definition to Legg-Hutter, Integrated Information Theory, and Chollet. Section 5 argues that meaning is correct function composition. Section 6 addresses properties and objections. Section 7 discusses falsifiability. Section 8 concludes.

## 2 The Chinese room revisited

A natural starting point is Searle’s Chinese Room Argument (CRA) [^31], which imagines a monolingual English speaker in a room, following a rulebook to manipulate Chinese symbols. Chinese questions are slipped in through a slot; following the book, the man produces Chinese answers that are indistinguishable from those of a native speaker. Searle contends that neither the man nor the system understands Chinese: the man merely shuffles symbols syntactically, without grasping their meaning.

The major replies—the Systems Reply, the Robot Reply, the Virtual Mind Reply, and Dennett’s “intuition pump” critique—all argue about *who* or *what* in the room understands, without defining what understanding *is*. The Systems Reply claims that “the whole system”—the man, the rulebook, the room—understands Chinese, but cannot say where in the system the understanding resides or how to measure it. Without a definition, Searle can always retreat to “but that’s not *real* understanding.” His ultimate retreat is biological naturalism: understanding requires the specific causal powers of biological neurons [^32] —a substrate claim, addressed by substrate independence (Section 3). The common failure is not a lack of ingenuity but a lack of a shared criterion. We take a different approach: rather than arguing about who in the room understands, we examine the rulebook itself and ask what it must contain. Our answer is precise: wherever there is a finite mechanism that generalizes—an algorithm whose $\mathcal{I}(n)\to\infty$ —there is knowing. This is not the Systems Reply. We do not claim the room “as a whole” knows; we claim the *rulebook* knows, because it contains the computation that generalizes. Our central claim is:

> The rulebook must generalize.

In the original CRA, the rulebook is given and we never ask where it came from. But the intelligence is *in the rulebook*. Someone—a programmer, a linguist, a culture—had to understand Chinese and the domains it covers in order to write it. The rules for handling arithmetic, geography, history, and open-ended conversation represent compressed, generalized knowledge. Once written, the book operates independently of its author, answering questions its author never considered. The book now contains the intelligence—produced by its author’s understanding, but operating on its own. We do not say the student “merely follows instructions.”

We now examine what this book must contain. A competent Chinese speaker can answer arithmetic questions posed in Chinese—“What is $4\times 34$?” or “What is $7{,}823+4{,}567$?”—expressed in Chinese numerals and characters. If the rulebook enables the room to pass the Turing test for Chinese, it must handle such questions for *arbitrary* numbers—a Chinese interrogator can ask about any arithmetic problem.

Now consider two possible designs for the arithmetic portion of the rulebook:

Design A (lookup table) The book contains a table listing every possible arithmetic problem and its answer: $1\times 1=1$, $2\times 1=2$, …, $34\times 182=6{,}188$, …, together with the corresponding Chinese characters.

Design B (algorithm) The book contains rules for multiplication via repeated addition, addition via carry rules, and carry rules via binary XOR and AND, together with rules for converting between Chinese numerals and the internal representation.

###### Proposition 1.

The arithmetic portion of any finite rulebook that passes the Turing test for Chinese must be algorithmic (Design B), not a lookup table (Design A).

The argument is straightforward. The set of arithmetic questions expressible in Chinese is countably infinite (any pair of natural numbers can be named in Chinese). A lookup table for all such questions requires infinitely many entries, each of positive size—hence infinite storage. The rulebook is a physical object with finite pages. Therefore, the arithmetic portion cannot be a lookup table. It must use a finite algorithm that generalizes across all inputs.

This argument uses arithmetic only because the infinity of the input domain is mathematically indisputable. But the same logic applies to every open-ended component of Chinese conversation: there are infinitely many possible questions about geography, history, counting, comparisons, hypotheticals, and novel combinations of these. The arithmetic case is simply the cleanest proof that the rulebook must generalize. It follows that Searle’s rulebook, if finite, necessarily contains algorithms that produce correct outputs for inputs never explicitly listed—that is, they go beyond what was “told” to the system. Whether this constitutes “knowing” depends on how one defines the term. We provide such a definition in Section 3.

The distinction between Design A and Design B also addresses a complementary challenge posed by Block [^5], who imagined a “Blockhead”: a giant lookup table storing correct responses for every possible conversation of bounded length. Blockhead passes the Turing test but clearly does not understand—the mirror image of Searle’s argument. For unbounded domains, Blockhead is physically impossible (infinite storage required). For bounded domains, the challenge appears to survive. We return to it in Section 3, where our metric provides the formal criterion.

Choosing Design B introduces a computer. It is not important to whom it belongs—the man or the rulebook—but the computation is important in the sense of generalization established above. The computer and a set of rules for manipulating it, which we now call a *system*, generate the intelligence. In the spirit of Searle’s Premise 3—“syntax is not sufficient for semantics”—one must also ask whether such a system can generate meaningful sentences, not merely syntactically well-formed ones. This question requires careful treatment; we defer it to Section 5, where we argue that meaning over a domain is a selection and ordering of functions that produces correct outputs, and that a system which generalizes necessarily captures this structure.

The arguments of this section do not depend on a formal definition of intelligence—Proposition 1 requires only that the rulebook is finite and the domain is infinite. But a formal definition quantifies the insight: it measures *how much* a system generalizes, distinguishes generalization from memorization precisely, and places all systems on a common scale. We develop this definition in the next section.

## 3 The formal definition

Intelligence need not be biological. Proposition 1 makes no reference to substrate: the argument that a finite rulebook must generalize applies whether the rulebook is paper, silicon, or neural tissue. Turing observed that Babbage’s Analytical Engine was entirely mechanical: “since all digital computers are in a sense equivalent, we see that this use of electricity cannot be of theoretical importance” [^39]. Any adequate definition of intelligence must therefore be substrate-independent: it must assign the same value to the same computation regardless of what physical medium implements it.

The Chinese Room Argument also suggests a natural measure. A system that memorizes stores each output individually: its description length grows with the number of outputs it can produce. A system that generalizes compresses: its description length stays fixed while the number of outputs grows. The ratio of outputs to description length captures this distinction—it diverges for algorithms and vanishes for lookup tables. Taking the logarithm of the output count follows Shannon’s convention: independent outputs contribute additively, just as independent information sources do.

With this in mind, we now state the formal definitions.<sup>1</sup>

###### Definition 1 (Intelligence density).

Let $S$ be a physical system with total description length $C(S)$ (measured in bits)—the length of the program and data required to specify $S$. Let $N(S)$ be the number of *independent* outputs $S$ can produce in response to distinct inputs. The intelligence density of $S$ is:

$$
\mathcal{I}(S)=\frac{\log_{2}N(S)}{C(S)}
$$

For a Turing machine, $C(S)$ is the contents of the tape before execution; for a neural network, the total size of its weights; for a lookup table, the number of entries times bits per entry. The $\log_{2}N$ in the numerator follows Boltzmann’s statistical mechanics: just as entropy $S=k_{B}\ln\Omega$ counts the logarithm of the number of microstates, $\mathcal{I}$ counts the logarithm of the number of independent outputs. Shannon [^34] adopted the same logarithmic form for information theory, with base 2 giving the unit of bits. The independence condition below plays the role of Shannon’s requirement that information sources be independent for entropy to be additive.

Although we write $\mathcal{I}(S)$, intelligence density is properly a property of a system *relative to a domain and a level of description*. Both $C(S)$ and $N(S)$ depend on the chosen level: a brain measured at the synaptic level with linguistic outputs is a different computational system from the same brain measured at the molecular level with protein-folding outputs. The appropriate level is fixed by the evaluation domain—a Turing test selects the synaptic level; a study of cellular adaptation selects the molecular level—and once fixed, $C(S)$ and $N(S)$ are determined. The shorthand $\mathcal{I}(S)$ is therefore understood as $\mathcal{I}(S,D)$ with the domain $D$ implicit. This is analogous to temperature: we write $T(S)$ as a property of a system, while understanding that temperature is defined relative to a chosen set of degrees of freedom. The relativity is not a defect of the measure but a correct reflection of the fact that intelligence is always intelligence *with respect to* some domain of inputs and outputs.

The key term is “independent”:

###### Definition 2 (Independent outputs).

Two outputs $o_{1}$ and $o_{2}$ of a system $S$ are independent if neither can be predicted from the other by any description shorter than the output itself. Formally, $K(o_{1}\mid o_{2})\approx K(o_{1})$ and $K(o_{2}\mid o_{1})\approx K(o_{2})$, where $K$ denotes Kolmogorov complexity.

The use of Kolmogorov complexity here has a natural operational interpretation. An interrogator who tries to predict $o_{1}$ from $o_{2}$ is, in effect, searching for a short description of $o_{1}$ given $o_{2}$. The most powerful conceivable interrogator—one with unlimited computational resources and optimal compression—would find the shortest such description, achieving exactly $K(o_{1}\mid o_{2})$. Kolmogorov complexity is therefore the *idealized interrogator*: the limit approached as the interrogator becomes more capable. A real interrogator is a computable approximation of this limit. The more intelligent the interrogator, the closer its judgment comes to $K$.

This reinterpretation has two consequences. First, it resolves the incomputability concern: $K$ is not a quantity to be computed in practice but a theoretical ideal that real interrogators approximate. The incomputability of $K$ is no more problematic than the inaccessibility of the Carnot limit in thermodynamics—it defines the ideal without requiring it to be achieved. Second, it dissolves the worry about interrogator disagreement: two interrogators may differ, but they disagree only to the extent that one is a better approximation of $K$ than the other. There is a fact of the matter, given by $K$, even if no finite interrogator reaches it.

###### Definition 3 (Generalization).

Let $n$ parameterize the size of domain $D$ (e.g., the number of digits for arithmetic, the board size for chess). A system $S$ *generalizes over* $D$ if $C(S)$ remains finite as $n\to\infty$ and $\mathcal{I}(S,n)\to\infty$ —that is, intelligence density diverges as domain size grows without bound. Equivalently: $S$ generalizes over $D$ if the number of independent outputs $N(S,n)$ grows without bound while $C(S)$ remains fixed—a growth rate achievable only by a system whose finite mechanism captures the generative structure of $D$, not by any lookup table. We say that $S$ *knows* $D$ when this condition is met.

A crucial point is that Definition 3 applies to a *single* system $S$ with fixed description length, not to a family of systems whose description length grows with the domain. For a single fixed lookup table, the question of scaling does not arise: the table covers only a finite domain and simply cannot produce outputs for inputs beyond its range. The scaling $\mathcal{I}(n)\to 0$ describes what happens if we imagine a family of ever-larger tables, each storing more entries—their description length grows at least as fast as their output count, so intelligence density vanishes. By contrast, a single algorithm with fixed description length handles every $n$, so $\mathcal{I}(n)\to\infty$. This is the formal content of the difference between memorization and knowing: memorization requires a new, larger system for every expansion of the domain; knowing does not.

Note that “extensibility” is not a hypothetical property requiring future modification of the system. A large language model with frozen weights that correctly multiplies arbitrary numbers already demonstrates extensibility: its finite parameters contain the algorithm, and the algorithm covers the infinite domain now. The system does not need to be extended; it already generalizes. The context window is an engineering constraint on input size, not a bound on the algorithm’s scope—just as the finite pages of Searle’s rulebook constrain how long a single conversation can be, without limiting the space of conversations the rules can handle.

### 3.1 The meaning of intelligence density ℐ\\cal I

The metric $\mathcal{I}$ plays two roles that should be clearly distinguished.

*Scaling role (knowing vs. memorization):* The key criterion is not the absolute value of $\mathcal{I}$ but its asymptotic behavior: does $\mathcal{I}(n)$ diverge or vanish? Definition 3 asks whether $\mathcal{I}(n)\to\infty$ as the domain scales. This is the intelligence criterion proper. A system with $\mathcal{I}\ll 1$ in a fixed domain may fully know that domain, provided $\mathcal{I}(n)\to\infty$ as the domain expands. A bloated, redundant implementation of a correct algorithm has low intelligence density in any fixed domain, but it still knows, because its $\mathcal{I}(n)\to\infty$. Conversely, a system with high $\mathcal{I}$ in a fixed domain but no capacity to extend to larger inputs does not know it—it has merely computed efficiently within a bounded scope. The XOR gate exemplifies this: $\mathcal{I}=0.25$, but the domain is frozen and cannot scale.

*Density role (efficiency and comparison):* $\mathcal{I}$ is a *density*, not a total. A small flame has higher temperature than a large room, but the room contains far more thermal energy. Similarly, a single XOR gate has higher intelligence density than a human brain in a fixed domain, because the gate uses every bit of its 4-bit description for computation. The brain’s $\sim$ $10^{14}$ bits of synaptic description include massive redundancy—parallel pathways, cached representations, pre-computed motor programs—all trading density for speed. An LLM evaluated on XOR alone shows $\mathcal{I}\ll 1$ —it deploys $\sim$ $10^{12}$ parameters to answer a two-bit question—but when the domain expands to cover language, reasoning, and arithmetic simultaneously, $N$ explodes and $\mathcal{I}(n)$ diverges. The low density on any single domain is not a limitation; it is the cost of multi-domain coverage. Given two systems that both know, $\mathcal{I}$ measures how efficiently each uses its description length. A compact algorithm has higher density than a redundant one implementing the same function. This is the formal content of overfitting: adding capacity without adding generalization lowers $\mathcal{I}$.

When a system covers multiple independent domains simultaneously, the total number of independent outputs is the product of the outputs across domains, since an output in one domain carries no information about an output in another. Therefore $\log_{2}N_{\text{total}}=\sum_{i}\log_{2}N_{i}$: the contributions add. The scaling of $\mathcal{I}$ is then dominated by the fastest-growing domain. A system that handles both $n$ -digit multiplication ($\log_{2}N=\Theta(n)$) and chess on an $M$ -square board ($\log_{2}N=\Theta(M)$) has $\log_{2}N_{\text{total}}=\Theta(n)+\Theta(M)$, with the chess term dominating for large boards. More generally, the intelligence of a system that covers many domains scales with its richest domain—but all domains contribute, and covering more domains with the same $C$ strictly increases $\mathcal{I}$. This is why a general-purpose system such as a large language model, despite having lower $\mathcal{I}$ than a dedicated algorithm on any single domain, accumulates an $N$ that no single-domain system can match.

The fundamental quantity for comparing how richly two systems generalize is $\log_{2}N(S)$ as a function of domain size—not as a function of any particular parameterization $n$, but as a function of the domain itself. For $n$ -digit multiplication, the domain is the set of all pairs of $n$ -digit numbers, and $\log_{2}N$ grows as $O(n)$ under the natural parameterization by digit count. This is exact: the independence condition is fully satisfied, and $n$ is the unambiguous measure of problem size.

For other domains, the choice of $n$ is not unique. An $n\times n$ chess engine could equally be parameterized by $n$ (the side length) or by $M=n^{2}$ (the total number of squares). Under the first, $\log_{2}N=O(n^{2})$; under the second, $\log_{2}N=O(M)$. These are the same scaling expressed differently. The exponent $d$ in $\log_{2}N=\Theta(n^{d})$ therefore depends on the choice of $n$ and is not an intrinsic property of the system. What is intrinsic is $\log_{2}N$ as a function of the domain, and the question of whether it diverges—which is all that Definition 3 requires. When a natural parameterization exists (as in arithmetic), $d$ provides a convenient summary. When it does not (as in chess or language), the raw growth of $\log_{2}N$ is the correct quantity to consider, and comparisons between systems are best made directly in terms of $N$.

We now discuss the properties of this measure.

### 3.2 No Computation (ℐ≈0\\mathcal{I}\\approx 0)

A rock produces no distinguishable input-dependent outputs: $N(S)\leq 1$, so $\mathcal{I}(S)=0$. More precisely, a rock’s outputs (e.g., its temperature changes, vibration responses) are almost entirely predictable from one another—the independence condition collapses the count to near zero. A river is filtered by the same condition: its output (water flows downhill) is essentially one response to a vast range of inputs, since changing slope from $30^{\circ}$ to $31^{\circ}$ produces an output almost entirely predictable from the output at $30^{\circ}$. $N(S)\approx 1$, so $\mathcal{I}\approx 0$. That $\mathcal{I}$ assigns a near-zero value to rivers and rocks is not a weakness but a feature: intelligence density, like temperature, is graded, and every physical system has some value of it, possibly very low.

### 3.3 Memorization (ℐ→0\\mathcal{I}\\to 0)

If a system stores every input-output pair explicitly, with $m$ entries of $b$ bits each, then $C=mb$, $N=m$, and $\mathcal{I}=\log_{2}m/(mb)$, which is always less than $1$ and decreases as the table grows. A large lookup table has $\mathcal{I}\approx 0$. The system memorizes; it does not generalize.

We can now give a precise refutation of Block’s Blockhead (Section 2). A Blockhead for conversations of length $L$ over vocabulary $V$ requires $C=V^{L}\cdot b$ bits, where $b$ is the bits per response. Its $N=V^{L}$ and $\mathcal{I}=\log_{2}V^{L}/(V^{L}\cdot b)=L\log_{2}V/(V^{L}\cdot b)$. As $L$ grows, the numerator grows linearly while the denominator grows exponentially: $\mathcal{I}(L)\to 0$. Blockhead is a lookup table, and $\mathcal{I}$ diagnoses it as such regardless of how convincing its outputs appear.

Two further points sharpen the refutation. First, the physical storage is prohibitive even for modest $L$. With $V=10^{4}$ and $L=100$, $C>10^{400}$ bits—exceeding the number of atoms in the observable universe ($\sim 10^{80}$) by a factor of $10^{320}$. The word “infinite” is not required: a domain that is merely large enough to be linguistically interesting is already physically impossible for any lookup table.

Second, a lookup table cannot handle cross-domain queries it has not explicitly stored. A Blockhead prepared with addition entries cannot answer a multiplication question, even if both are expressible in the same language. A genuine knower with a finite algorithm handles both, and any novel combination of domains, without additional storage. A Turing test can freely combine domains—arithmetic, geography, hypotheticals—and any Blockhead with finite coverage will fail at their intersections. In terms of $\mathcal{I}$: the knower’s $\mathcal{I}(n)\to\infty$ because a single finite $C$ covers all cross-domain combinations; Blockhead’s $C$ must grow with every new combination, so $\mathcal{I}(n)\to 0$.

### 3.4 Computation without knowing (ℐ=Θ(1)\\mathcal{I}=\\Theta(1))

A single binary logic gate—XOR, AND, or OR—has two input bits, one output bit, and $C\approx 4$ bits of structure. It produces $N=2$ independent outputs (0 and 1, neither predictable from the other). Therefore $\mathcal{I}=\log_{2}2/4=0.25$. The gate computes, but its domain is fixed: there is no $n$ to vary, no sense in which performance scales. $\mathcal{I}$ remains constant.

An $n$ -bit adder circuit correctly adds any two $n$ -bit numbers. One might expect this to count as knowing addition. Under our framework, it does not. An $n$ -bit adder is a *specific physical system* with $C=O(n)$: doubling the input width requires a new circuit with roughly twice as many gates. The family $\{S_{1},S_{2},S_{4},\ldots\}$ is not a single system with fixed $C$ but a sequence of ever-larger systems, each handling a fixed domain. No single circuit in the family handles all $n$; each is specialized to its own input width.

This makes the circuit family structurally analogous to a lookup table family. Both require a new, larger system for every expansion of the domain. The circuit family is far more efficient— $C$ grows linearly rather than exponentially—but the scaling structure is the same: $C$ grows with $n$, so no single system achieves $\mathcal{I}(n)\to\infty$. The XOR gate and the circuit family arrive at $\mathcal{I}=\Theta(1)$ by different routes—fixed domain versus growing domain with growing $C$ —but the result is the same: computation without knowing.

This is a novel prediction of the framework: two systems producing identical outputs over any finite domain are classified differently. The circuit computes addition correctly for its input width, but it does not *know* addition in the sense of Definition 3, because knowing requires a single fixed mechanism that scales. The algorithm knows because its finite description covers the infinite domain. This distinction corresponds precisely to the uniform/non-uniform divide in computational complexity theory [^3].<sup>2</sup> Uniform computation uses a single Turing machine (fixed $C$) for all input sizes, while non-uniform computation uses a different circuit for each input size ($C$ grows with $n$). A non-uniform circuit family can even compute undecidable functions by hardwiring the answer for each $n$ —the extreme case of memorization. Our four-way partition refines this classical dichotomy by further distinguishing the rate at which $C$ grows.

### 3.5 Knowing (ℐ→∞\\mathcal{I}\\to\\infty)

A finite program that handles a large input domain produces very many independent outputs while $C(S)$ remains fixed. As the domain scales, $\mathcal{I}(S,n)$ grows without bound—it diverges. The program must capture the structure of the domain to compress many possibilities into finite rules. This compression is generalization; generalization is intelligence.

Consider multiplication. A lookup table for single-digit multiplication stores $81$ entries of $\sim$ 7 bits each: $C\approx 567$ bits, $N=81$, $\mathcal{I}=\log_{2}81/567\approx 0.011$. Now consider the standard multiplication algorithm, which uses this lookup table plus $\sim$ 100 bits of carry and digit-decomposition rules, for a total of $C\approx 667$ bits. For $n$ -digit $\times$ $n$ -digit multiplication, there are $\sim\!10^{2n}$ distinct input pairs, so $N\approx 10^{2n}$, $\log_{2}N\approx 6.6n$, and $\mathcal{I}\approx 6.6n/667$:

| Domain | $N$ | $\log_{2}N$ | $\mathcal{I}$ |
| --- | --- | --- | --- |
| $1$ -digit $\times$ $1$ -digit (lookup) | $81$ | $6.3$ | $0.011$ |
| $10$ -digit $\times$ $10$ -digit | $\sim\!10^{20}$ | $66$ | $0.1$ |
| $100$ -digit $\times$ $100$ -digit | $\sim\!10^{200}$ | $664$ | $1.0$ |
| $n$ -digit $\times$ $n$ -digit | $\sim\!10^{2n}$ | $\sim\!6.6n$ | $>1$ for large $n$ |

As the domain grows, $\mathcal{I}(n)$ diverges—it grows without bound as $n\to\infty$ —while the lookup table’s $\mathcal{I}(n)\to 0$.<sup>3</sup> Note that all multiplication results are independent: knowing $123\times 456=56{,}088$ does not allow one to predict $789\times 234=184{,}626$ without running the algorithm, so $K(o_{2}\mid o_{1})\approx K(o_{2})$. This contrasts sharply with a pseudo-random number generator, where each output determines the next and $K(o_{2}\mid o_{1})\approx 0$. The precise value of $\mathcal{I}$ at any fixed $n$ depends on how $C$ is measured, but the divergence of $\mathcal{I}(n)$ is robust to any reasonable choice. This qualitative distinction—diverging versus vanishing $\mathcal{I}(n)$ —is the central contribution of the definition.

As a sanity check, an $n$ -digit addition algorithm yields similar scaling: $\log_{2}N\sim 6.6n$ with a smaller $C$ (no multiplication table needed). The two algorithms have comparable $\mathcal{I}$, which is correct—both generalize equally well across their respective domains. Multiplication is more *complex* (larger $C$), but not more *intelligent*. The metric correctly distinguishes complexity from intelligence.

The metric also captures redundancy. A 99 $\times$ 99 lookup table stores $9{,}801$ entries of $\sim$ 14 bits each: $C\approx 137{,}000$ bits, $N=9{,}801$, $\mathcal{I}\approx 0.0001$. But the 9 $\times$ 9 table plus the multiplication algorithm ($C\approx 667$ bits) produces all $9{,}801$ outputs and infinitely more. The $9{,}720$ additional entries in the larger table are entirely redundant—derivable from the smaller mechanism. Storing them increases $C$ without increasing $N$, so $\mathcal{I}$ drops. This is the formal content of overfitting: adding capacity without adding generalization. The same principle explains why overparameterized neural networks can be pruned or quantized with little loss of performance—the removed parameters were redundant, and removing them increases $\mathcal{I}$.

The difference between a lookup table and an algorithm reduces to *reuse*. A lookup table dedicates $b$ bits of storage to each output; nothing is shared. An algorithm stores a rule once and applies it to every input: the carry rule for addition is stored once but used at every digit position, for every pair of numbers, at every scale. What $\mathcal{I}$ measures is precisely this: the ratio of reuse to storage. Reuse is possible only when the rule captures a *pattern* —a regularity shared across inputs. Capturing patterns is generalization. Generalization is reuse. A system that reuses has $\mathcal{I}\to\infty$ as the domain scales; a system that memorizes has $\mathcal{I}\to 0$.

The mechanism that enables reuse is iteration (or recursion). The addition algorithm applies the same carry-and-add step to each digit position; the multiplication algorithm applies the same single-digit multiply and accumulate to each pair. Without a loop, a system can only process a fixed-size input—its computation depth is bounded, and so is its domain. A feedforward network without recurrence, like a combinational circuit, falls in this category: fixed input dimension, fixed domain, $\mathcal{I}=\Theta(1)$. Iteration is therefore the minimal computational requirement for knowing. This is weaker than Turing completeness—a bounded loop suffices—but stronger than mere function evaluation.

The following table summarizes $\mathcal{I}$ across the continuum of systems, showing $C(S)$ <sup>4</sup>, $\log_{2}N$, and the resulting $\mathcal{I}$ scaling explicitly. A system *knows* its domain (Definition 3) if $\mathcal{I}(n)\to\infty$.

| System | $C(S)$ | $\log_{2}N$ | $\mathcal{I}$ scaling | Status |
| --- | --- | --- | --- | --- |
| Rock | $>0$ | $\approx 0$ | $\approx 0$ | No computation |
| River | $>0$ | $\approx 0$ | $\approx 0$ | No independent outputs |
| Pseudo-random generator | $>0$ | $\approx 0$ | $\approx 0$ | Outputs not independent |
| Lookup table ($n$ entries) | $\Theta(n)$ | $\Theta(n)$ | $\to 0$ | Memorization |
| $n$ -bit adder circuit (family) | $O(n)$ | $\Theta(n)$ | $\Theta(1)$ | Computes, doesn’t know |
| XOR / AND / OR gate | $O(1)$ | $\Theta(1)$ | $0.25$ | Fixed domain |
| Addition algorithm | $O(1)$ | $\Theta(n)$ | $\to\infty$ | Knows |
| Multiplication algorithm | $O(1)$ | $\Theta(n)$ | $\to\infty$ | Knows |
| Chess engine ($M$ squares) | $O(1)$ | $\Theta(M)$ | $\to\infty$ | Knows |
| LLM (multiple domains) | $O(1)$ | diverges | $\to\infty$ | Knows |
| Human brain | $O(1)$ | diverges | $\to\infty$ | Knows |

The table reveals a four-way partition. Systems with no generative structure have $\mathcal{I}\approx 0$. Lookup tables have $C$ growing proportionally with $N$, so $\mathcal{I}\to 0$: storage scales with output, leaving no room for compression. A hardware circuit family such as the $n$ -bit adder occupies an intermediate position: both $C$ and $\log_{2}N$ grow with $n$, giving bounded $\mathcal{I}$. The circuit computes correctly at each fixed width, but it is a different system for each $n$ —it does not know addition in the sense of Definition 3. A fixed-domain system such as a logic gate has constant $C$ and constant $\log_{2}N$, giving constant $\mathcal{I}$ —it computes, but its domain does not scale. Knowing systems have $C=O(1)$ fixed while $\log_{2}N$ diverges: the same finite mechanism covers an unbounded domain. This is the only configuration that yields $\mathcal{I}\to\infty$, and it is the only configuration that satisfies Definition 3. The criterion is therefore not the absolute value of $\mathcal{I}$ but its asymptotic behavior: does it diverge or not? For multiplication and addition this is exact; for chess, LLMs, and brains the divergence is qualitatively clear while the precise rate is an open empirical question.

### 3.6 Real Systems, gradedness

Definition 2 treats independence as binary. In practice, independence is graded: “A dog barks” and “A dog runs” share the subject “dog”—they are neither fully independent nor fully dependent. A continuous measure based on normalized conditional Kolmogorov complexity $K(o_{1}\mid o_{2})/K(o_{1})$ would yield a continuous $N_{\text{eff}}(S)$ and a more nuanced $\mathcal{I}$. We leave this refinement to future work; the binary version suffices for the qualitative distinction between lookup tables and algorithms. Under the graded view, every fixed algorithm has $\mathcal{I}_{\text{eff}}=\Theta(1)$ regardless of domain, because the effective number of independent “base facts” is finite and fixed. A multiplication algorithm knows $\sim$ 100 base facts (the 9 $\times$ 9 table plus carry rules); all $10^{200}$ outputs for 100-digit inputs are recombinations of these. A lookup table, by contrast, has $\mathcal{I}_{\text{eff}}\to 0$ as the domain grows. The qualitative distinction— $\Theta(1)$ versus vanishing—is robust to the choice of binary or graded independence.

For large language models, exact computation of $\mathcal{I}$ remains an open problem: $C$ is measurable (parameter count $\times$ bits per parameter), but estimating $N$ requires assessing pairwise independence of outputs via compression-based approximations of Kolmogorov complexity—a task that has not yet been carried out at scale. The qualitative determination, however, is clear: an LLM with $\sim$ $10^{12}$ finite parameters produces correct responses to effectively infinite novel inputs, so $\mathcal{I}\to\infty$.

The natural parameterization of the LLM domain is sentence length $L$. As $L$ grows, the number of possible sentences over vocabulary $V$ scales as $V^{L}$, giving $\log_{2}N\leq L\log_{2}V=\Theta(L)$. Under the parameterization $n=L$, the scaling is therefore at most linear: $\log_{2}N=O(L)$. Whether this upper bound is tight depends on how many of the $V^{L}$ possible sentences yield genuinely independent outputs under Definition 2. Closely related sentences—“Paris is the capital” versus “Paris is the capital of France”—share most of their information and are far from independent. Semantically unrelated sentences—the answer to an arithmetic question versus the answer to a geography question—are independent. The effective $N_{\text{eff}}(L)$ after the independence condition is applied counts only the latter, and its precise growth rate with $L$ is an open empirical question. The vocabulary size $V$ is an alternative parameterization, but it is less natural: $V$ is architecturally fixed, whereas $L$ varies freely within the context window and governs the scaling of the input space. We therefore regard $n=L$ as the correct parameter, note that $\log_{2}N_{\text{eff}}(L)$ diverges with $L$ (establishing that LLMs know their domain), and leave the precise exponent to future work.

### 3.7 Turing completeness and the scale of ℐ\\mathcal{I}

Turing completeness requires only addition and conditional branching [^24]. Since these basic operations already have $\mathcal{I}=\Theta(1)$ at fixed domains, all Turing-complete systems—from a minimal register machine to a human brain—operate at the same *order* of intelligence density in any fixed snapshot. What differs between them is $N$: the number and diversity of domains they handle.

But Turing completeness is not required for generalization, and therefore not required for knowing. A frozen feedforward network with fixed weights is a fixed function—not a Turing machine—yet it generalizes to inputs absent from its training data. A large language model with a fixed context window is, strictly speaking, a very large fixed function. $\mathcal{I}$ applies to any finite input-output system, whether or not it is Turing complete. This confirms Turing’s intuition that the difference is “largely a quantitative matter” [^40].

### 3.8 Operationalizing CC

The total description length $C$ is well-defined for digital systems (bit count of parameters, program, and stored data) but less clear for biological systems. The description length of a human brain could be measured by the number of synapses ($\sim$ $10^{14}$), the number of neurons ($\sim$ $10^{10}$), or the number of atoms—each yielding a different $\mathcal{I}$.

This ambiguity reflects scale-dependence, not conceptual weakness. The situation is analogous to effective theories in physics: at different energy scales, the relevant degrees of freedom change. Quantum chromodynamics describes quarks and gluons; nuclear physics describes protons and neutrons; chemistry describes atoms and bonds. Each level has its own variables, and quantities computed at one level need not equal those computed at another. No one considers this a deficiency of physics.

Similarly, $\mathcal{I}$ is computed within a chosen level of description, and different levels define *different systems* with different degrees of freedom. The brain measured at the neuron level, with linguistic outputs, is a different computational system from the brain measured at the molecular level, with protein-folding outputs. The evaluation domain determines the appropriate level: a Turing test selects the neuron level (inputs and outputs are sentences); a study of cellular adaptation selects the molecular level (inputs and outputs are chemical signals). At each level, both $C$ and $N(S)$ are determined by the degrees of freedom at that level, and $\mathcal{I}$ is meaningful within that level. For digital systems, the natural degrees of freedom are clear (parameters, memory cells). For biological systems, the appropriate level is an empirical question guided by the domain of evaluation. The core argument (Proposition 1) requires only that $C$ is finite, which holds at any level for any physical system.

Even within a single level, measurement conventions can vary: a neural network’s $C$ could be measured as parameter count $\times$ 32 bits (full precision) or parameter count $\times$ 16 bits (half precision), yielding $\mathcal{I}$ values differing by a factor of two. As noted in the scaling role above, this affects snapshot values but not the divergence criterion, since rescaling $C$ by a constant factor does not change asymptotic behavior.

## 4 Relation to prior measures

### 4.1 Kolmogorov complexity

Our metric has a precise relationship to Kolmogorov complexity. The Kolmogorov complexity $K(x)$ of a string $x$ is the length of the shortest program that produces $x$ on a universal Turing machine:

$$
K(x)=\min_{p}\{|p|:U(p)=x\}
$$

$K$ measures how much a single output can be *compressed*. Our $\mathcal{I}(S)$ is the inverse direction:

$$
\displaystyle K
$$
 
$$
\displaystyle:\text{output}\to\text{minimum program size}
$$
 
$$
\displaystyle\mathcal{I}
$$
 
$$
\displaystyle:\text{program size}\to\text{maximum independent outputs}
$$

Kolmogorov complexity measures *compression efficiency* —how concisely a given output can be described. Our metric measures *generative power* —how many genuinely different outputs a given mechanism can produce. The former evaluates the output; the latter evaluates the system. Prior work treats intelligence as a necessary condition for compression (to compress well, one must generalize). Our definition treats computation as a sufficient condition for intelligence (to generalize is to be intelligent).

The two measures are *dual*, viewing the same phenomenon from opposite directions. $K$ measures *meaning density* —how much irreducible content each bit carries. $\mathcal{I}$ measures *meaning breadth* —how many such outputs the system generates from its finite mechanism.

|  | Kolmogorov $K$ | Intelligence $\mathcal{I}$ |
| --- | --- | --- |
| Direction | Output $\to$ program | Program $\to$ outputs |
| Measures | Meaning density of one output | Meaning breadth of one system |
| High value | Non-redundant, meaning-rich | Generative, generalizing |
| Low value | Redundant, compressible | Memorizing, lookup table |

A crucial distinction separates meaningful high- $K$ outputs from random ones. A truly random string has high $K$ but carries no systematic relationship to any input. A pseudo-random generator produces a deterministic sequence from a seed: each output is computed from the previous one via a fixed function $s_{t+1}=f(s_{t})$, so given the seed and algorithm, every output is predictable from any other— $K(o_{2}\mid o_{1})\ll K(o_{2})$. The entire sequence is one independent output (the seed); $N_{\text{eff}}=1$, so $\log_{2}N\approx 0$. In both cases, the independence condition filters them out. The duality extends to incomputability: for $K$, the output is given but finding the shortest program is incomputable; for $\mathcal{I}$, the system is given but determining output independence requires computing $K$ —equally incomputable. The two measures face the same barrier from opposite sides.

The compression-intelligence literature [^20] [^37] has established one direction: the ability to compress data requires intelligence. Our definition formalizes the complementary direction. Together, the two directions complete the picture: compression measures the intelligence *required by* a task; $\mathcal{I}$ measures the intelligence density *of* a system. Whether this duality can be made mathematically precise—perhaps as an adjunction or a Galois connection between appropriate categories—is an open question. A related principle is Rissanen’s [^30] Minimum Description Length (MDL): the best model of data is the one that minimizes the sum of model description length and data-given-model description length. $\mathcal{I}$ can be viewed as the inverse of MDL—where MDL finds the optimal $C$ for given data, $\mathcal{I}$ measures the generative power of a given $C$. A model that achieves high $\mathcal{I}$ is precisely the kind of model MDL selects: maximum coverage from minimum description.

### 4.2 Legg-Hutter universal intelligence

Legg and Hutter [^22] proposed the most rigorous prior definition of machine intelligence:

$$
\Upsilon(\pi)=\sum_{\mu\in E}2^{-K(\mu)}\cdot V_{\mu}^{\pi}
$$

where $\pi$ is an agent, $E$ is the class of all computable environments, $K(\mu)$ is the Kolmogorov complexity of environment $\mu$, $V_{\mu}^{\pi}$ is the expected cumulative reward of agent $\pi$ in $\mu$, and $2^{-K(\mu)}$ is the Solomonoff prior assigning higher weight to simpler environments.

Our framework differs in two respects. First, $\mathcal{I}$ operates at the level of the system’s internal capacity, requiring no environment or reward specification. Under our definition, an XOR gate has $\mathcal{I}>0$ in isolation; under Legg-Hutter, the answer depends on which environment and reward are supplied. Second, $\mathcal{I}$ is computable for simple systems—it yields $0.25$ for an XOR gate with pencil and paper—whereas $\Upsilon$ cannot be computed even for the simplest case, since it requires summing over all computable environments. Neither Legg-Hutter nor its descendants address whether computation constitutes knowing. This is not a weakness of Legg-Hutter, which was designed for a different purpose, but it leaves a gap that motivates the present work.

Despite these differences, the two measures coincide under the additional assumption of evolutionary selection. Consider a biological agent $\pi$ in a fixed physical environment $\mu_{\text{phys}}$. Let $D(\pi)$ be the set of environmental situations for which $\pi$ produces outputs that increase survival probability. In isolation, $\mathcal{I}$ measures generative capacity without regard to correctness. Under evolutionary selection, however, this separation collapses: organisms that generalize incorrectly are eliminated. Among survivors, broader generalization entails broader correct generalization.

###### Proposition 2.

Assume: (A1) the environment $\mu_{\text{phys}}$ is fixed; (A2) reward equals expected survival duration; (A3) the agent population has reached selection–mutation equilibrium, so that surviving agents generalize correctly— $N(\pi)$ independent outputs that survive selection are outputs in $D(\pi)$. Under these conditions, $\Upsilon(\pi)\big|_{\mu_{\text{phys}}}$ is monotonically increasing in $\mathcal{I}(\pi)$, and the two measures induce the same ordering over agents.

###### Proof sketch.

(1) By definition, higher $\mathcal{I}(\pi)$ with fixed $C_{\pi}$ means larger $N(\pi)$. (2) By assumption (A3), among survivors $N(\pi)$ independent outputs correspond to $N(\pi)$ situations handled correctly, so $|D(\pi)|$ is non-decreasing in $N(\pi)$. (3) A larger $D(\pi)$ implies higher per-step survival probability $p(\pi)=\Pr[x_{t}\in D(\pi)]$, since a greater fraction of the environment’s challenges fall within the agent’s competence. (4) Expected cumulative reward is $V_{\mu_{\text{phys}}}^{\pi}=r/(1-p(\pi))$ under a geometric survival model with per-step reward $r>0$, which is strictly increasing in $p(\pi)$. (5) Since $2^{-K(\mu_{\text{phys}})}$ is a positive constant for fixed $\mu_{\text{phys}}$, $\Upsilon(\pi)\big|_{\mu_{\text{phys}}}=2^{-K(\mu_{\text{phys}})}\cdot V_{\mu_{\text{phys}}}^{\pi}$ inherits the strict monotonicity in $p$, hence in $|D|$, hence in $\mathcal{I}$. ∎

Assumption (A3) is the critical one: it requires that selection has had sufficient time to eliminate agents that generalize broadly but incorrectly. This is the standard assumption of evolutionary equilibrium analysis. The proposition shows that $\Upsilon$ is a special case of $\mathcal{I}$: it is what $\mathcal{I}$ becomes when an evolutionary environment supplies the reward signal that $\mathcal{I}$ itself does not require. Evolution provides the evaluator; $\mathcal{I}$ measures what the evaluator selects for.

### 4.3 Integrated Information Theory

IIT [^38] measures consciousness via $\Phi$, not intelligence, but shares a similar formal structure (quantitative, information-theoretic, graded). Aaronson’s [^1] criticism that grids of XOR gates produce arbitrarily high $\Phi$ is not a problem for $\mathcal{I}$: minimal computation has minimal intelligence density.

### 4.4 Chollet’s skill-acquisition efficiency

Chollet [^9] proposes an Algorithmic Information Theory (AIT) based definition in which intelligence is *skill-acquisition efficiency*. His framework requires specifying prior knowledge, a task distribution, and training experience. Our framework shares Chollet’s core insight—that intelligence is generalization, not memorization—but $\mathcal{I}(S)$ applies more broadly: it requires only the system itself, allowing application to systems that do not “learn” in Chollet’s sense.

What Chollet captures that we do not is learning efficiency: two systems with identical $\mathcal{I}$ may have reached that state with very different amounts of training data. However, Chollet’s central concern—that unlimited data can “buy” arbitrary skill—is already resolved by $\mathcal{I}$: a lookup table has $\mathcal{I}<1$ regardless of how much data produced it. The final state, not the path, is what $\mathcal{I}$ measures. Similarly, Chollet’s framework does not engage with whether computation constitutes knowing. The present work attempts to fill this complementary role.

## 5 Meaning as arrangement

Section 2 claimed that syntax encoding the right structure may constitute semantics. Searle’s Premise 3—“syntax is not sufficient for semantics”—assumes that meaning is something beyond the arrangement of symbols. We argue otherwise: meaning over a domain $D$ is a selection and ordering of functions that produces correct outputs for all inputs from $D$. There is nothing more to meaning than this.

### 5.1 Tasks as function composition

A task over a domain $D$ is a mapping from inputs to correct outputs. Any system that performs this task implements a composition of primitive functions $f_{k}\circ f_{k-1}\circ\cdots\circ f_{1}$, where the selection $\{f_{1},\ldots,f_{k}\}$ determines which primitives are used and the ordering determines in what sequence they are applied. Meaning over $D$ is the correct selection and ordering—the arrangement that produces correct outputs for all inputs from $D$.

Consider the multiplication algorithm. It selects primitive functions—digit decomposition, single-digit multiplication, carry propagation, accumulation—and composes them in a specific order. This composition *is* what it means to know multiplication. Change the selection (replace carry with a different operation) and the outputs become wrong. Change the ordering (accumulate before carrying) and the outputs become wrong. The correct selection and ordering is the entire content of “knowing multiplication.” No further fact about meaning is needed.

The same analysis applies outside arithmetic. A thermostat selects three functions— $f_{1}$: sense temperature, $f_{2}$: compare to threshold, $f_{3}$: activate heater—and composes them in that order. Reverse the ordering (activate before sensing) and the system produces meaningless output. The correct composition *is* the thermostat’s knowledge of temperature regulation, minimal as it is. The universal approximation theorem [^10] [^18] guarantees that neural networks can in principle encode any such composition: a single hidden layer with sufficient units can approximate any continuous function. Since any task that maps inputs to outputs is a function, this means that the class of learnable function compositions is unrestricted—any correct arrangement over any domain can be represented in finite $C$.

### 5.2 Physical grounding

One might object that for language—the domain of the Chinese Room—correctness is harder to verify than for arithmetic. How do we know a sentence is “correct” without an observer to judge it? Harnad [^17] formalized this concern as the symbol grounding problem: symbols defined only in terms of other symbols remain ungrounded, and he argued that sensorimotor capacity is needed to anchor them. Brooks [^6] drew the same conclusion from robotics: intelligent systems must be embedded in the physical world, sensing and acting in it.

We agree that sensorimotor grounding provides one route to meaning—but it is not required by our framework. Consider a robot navigating a room: it selects functions— $f_{1}$: perceive obstacles, $f_{2}$: compute trajectory, $f_{3}$: execute motor command—and composes them in that order. If the selection is wrong (perceive without computing trajectory) or the ordering is wrong (execute before perceiving), the robot collides with the wall. The physical damage is an objective fact, independent of any observer. No one needs to judge whether the robot “really” navigated; the wall judges. Now, the same finite mechanism that controls the robot can also produce linguistic output about the room—“the door is on the left”—and the correctness of this output is grounded in the same function composition that keeps the robot from crashing. For such embodied systems, sensorimotor grounding is how meaning is acquired. A Blockhead robot that stores every possible sensor-motor pair faces the same physical impossibility as the conversational Blockhead of Section 3: the number of possible sensory configurations grows combinatorially, and no finite storage can cover them.

But sensorimotor grounding is optional, not constitutive. A multiplication algorithm has no sensors and no motors, yet it knows multiplication: $\mathcal{I}(n)\to\infty$. Its meaning is grounded not in physical interaction but in the structure of arithmetic itself—the correct function composition produces correct outputs for all inputs, and incorrect compositions do not. What is constitutive of meaning is correct function composition over a domain; sensorimotor interaction is one way—a powerful and natural way—to ensure that the composition is correct, but it is not the only way.

### 5.3 Syntax Is function composition

This analysis exhausts the content of syntax. Syntax comprises exactly two elements: the *selection* of functions (which primitives to use) and the *ordering* of functions (in what sequence to compose them). Even the choice of symbol set—binary, decimal, Chinese numerals—is a selection of encoding functions, reducible to the same framework. Rules and primitive operations are themselves compositions of lower-level functions: addition is a specific arrangement of XOR and AND gates. At the bottom, only primitive gates and their arrangement remain. Syntax, fully analyzed, is function composition—and correct function composition over a domain is meaning over that domain.

The idea that meaning arises from function composition has deep roots. Montague [^26] demonstrated that natural language semantics can be treated as compositional function application in typed lambda calculus, arguing that “there is no important theoretical difference between natural languages and the artificial languages of logicians.” The Curry-Howard correspondence [^11] [^19] establishes a still deeper connection: logical propositions correspond to types, proofs correspond to programs, and evaluation corresponds to proof simplification—meaning *is* computation structure. Our contribution is to extend this line of reasoning beyond language and logic to *arbitrary tasks*. Any task that maps inputs to outputs—multiplication, chess, medical diagnosis, motor control, conversation—is a function, and performing it correctly requires the right selection and ordering of sub-functions. Meaning over a domain is correct function composition over that domain, whether the domain is arithmetic, natural language, or visual recognition.

The four-way partition of Section 3 now gives a precise answer to Searle’s Premise 3: “syntax is not sufficient for semantics.” Searle claimed this holds universally. Our framework shows *when* it holds and when it does not. A lookup table or a hardware circuit family has syntax—rules, gates, structure—but does not constitute semantics: its $C$ must grow with the domain, so its arrangement does not capture the domain’s generative structure. An algorithm has syntax that *is* semantics: its fixed arrangement covers the infinite domain, so $\mathcal{I}(n)\to\infty$. Syntax is not sufficient for semantics when the arrangement fails to generalize; syntax *constitutes* semantics when it does.

### 5.4 Connection to ℐ\\mathcal{I}

How the arrangement is constructed—by a programmer, by gradient descent, or by evolution—is irrelevant to whether it constitutes knowing. A multiplication algorithm written by hand and a neural network trained on examples have the same $\mathcal{I}$ if they generalize equally. $\mathcal{I}$ measures the arrangement, not its origin. The interrogator—in the sense of Section 3, an agent probing output independence—estimates how many genuinely distinct outputs the system’s finite $C$ can produce. Whether those outputs are also *correct* is a separate question, answered by the evaluator (the domain structure, a benchmark, or a user). $\mathcal{I}$ formalizes what the interrogator does; correctness is the evaluator’s concern.

When the system’s domain is not known in advance, the interrogator discovers it by exploration: probing different domains—arithmetic, chess, language, geography—and estimating the independent output count $N_{i}$ in each. Since outputs from genuinely different domains are independent of one another (knowing $123\times 456$ does not predict the best chess move), the total count decomposes additively: $\log_{2}N_{\text{total}}=\sum_{i}\log_{2}N_{i}$. This is the formal content of what a Turing test does: it samples across domains to estimate the system’s total generative capacity. For systems with known domains—such as the multiplication algorithm analyzed in Section 3— $N$ can be computed directly without exploration.

The description length $C(S)$ is the cost of specifying the selection and ordering of functions. The output count $N(S)$ is the number of independent outputs this composition produces. A system knows domain $D$ (Definition 3) when a finite selection and ordering of functions—a finite $C$ —produces $N(S,n)\to\infty$ independent correct outputs as the domain scales. The system’s meaning is encoded entirely in its function composition; $\mathcal{I}$ measures how efficiently that composition covers the domain.

A note on independence. Two outputs $o_{1}$ and $o_{2}$ are independent when the function composition path that produces $o_{1}$ does not help predict $o_{2}$. For arithmetic this is clear: knowing $123\times 456=56{,}088$ does not predict $789\times 234=184{,}626$ without rerunning the computation, because different inputs activate different intermediate values at every step. For language the judgment is harder—“Paris is the capital of France” and “France’s capital is Paris” are dependent (same fact, different encoding), while “Paris is the capital of France” and “Water boils at 100 <sup>∘</sup> C” are independent. Exact counting of independent outputs requires approximating Kolmogorov complexity, which remains an open empirical problem. But the question this paper asks is not the exact count; it is whether $N$ diverges as the domain scales—and for any system with finite $C$ over an infinite domain, it does (Proposition 1).

A major tradition in linguistics and philosophy of language provides independent support for this view. Saussure [^33] argued that meaning is relational, not referential: “In language there are only differences without positive terms.” Wittgenstein [^41] reached a similar conclusion: “the meaning of words lies in their use.” Firth [^14] made it distributional: “You shall know a word by the company it keeps.” These traditions converge on the claim that relational structure—arrangement—captures a substantial portion of what we call meaning. Word embedding models provide empirical support: co-occurrence statistics alone capture semantic relationships with striking precision [^25] [^23] [^2]. Our argument does not depend on these traditions, but it is consistent with them: what they call “relational structure” is what we call “selection and ordering of functions.”

### 5.5 Correctness is relative

The definition of $\cal I$ makes no reference to correctness. Whether a system’s outputs are correct is determined by the domain’s structure— $123\times 456$ has exactly one correct answer, independent of any observer—or by an external evaluator (a teacher, a benchmark, a physical environment). $\mathcal{I}$ measures the system’s generative capacity; correctness is a separate question. A system with $\mathcal{I}(n)\to\infty$ that produces wrong outputs is a powerful but poorly calibrated generalizer, not an unintelligent one. This separation is not a weakness: it is the feature that makes $\mathcal{I}$ observer-independent. Correctness depends on the relationship between system and domain; generalization capacity belongs to the system alone.

Our framework separates generalization capacity from correctness. One might object that this leaves correctness ungrounded. But correctness is *always* relative to a domain or an evaluator. $1+1=0$ is correct relative to the structure of arithmetic (in a field with characteristic 2); a medical diagnosis is correct relative to the patient’s condition; a conversational response is correct relative to an evaluator’s judgment. $\mathcal{I}$ measures how many independent outputs a system can produce; whether those outputs are correct depends on the domain. The same output might be called creative in one context and erroneous in another; creativity and hallucination are the same generative capacity, judged by different evaluators. This separation is what makes $\mathcal{I}$ a property of the system alone, independent of any particular evaluator.

## 6 Properties and objections

### 6.1 Determinism and surprise

A system that knows a domain ($\mathcal{I}(n)\to\infty$) is fully deterministic—yet it surprises. This is not a contradiction; it is a consequence of the gap between determining and tracking. The functionalist tradition in philosophy of mind—Putnam’s [^28] machine functionalism, Fodor’s [^16] computational theory of mind, and Dennett’s [^12] intentional stance—established that mental states are defined by their functional roles, not by their substrate, and that we attribute “thinking” to systems whose behavior we cannot predict from lower-level descriptions. Our analysis makes this intuition precise: the impression of thought arises when $N$ exceeds the observer’s capacity to track.

The system’s outputs are determined by its program and input. In principle, an observer who knows the program could predict every output by running the computation step by step. But “in principle” is not “in practice.” The multiplication algorithm determines $6{,}741\times 8{,}923=60{,}163{,}443$, but the author of the algorithm does not know this product until the computation runs. Turing observed: “The view that machines cannot give rise to surprises is due, I believe, to a fallacy …the assumption that as soon as a fact is presented to a mind all consequences of that fact spring into the mind simultaneously with it” [^39].

The source of surprise is not non-determinism but the practical impossibility of tracking. A system with $\mathcal{I}(n)\to\infty$ produces $N$ independent outputs from a finite mechanism. The observer knows the *process* —the selection and ordering of functions that constitute $C$ —but does not follow every intermediate step for every input. The moment the observer stops tracking, even small differences in intermediate values can compound: a different carry at one digit position propagates through all subsequent positions, producing a completely different output. The observer who knows the algorithm but has not run it on this particular input is in the same position as someone who has never seen the algorithm: surprised. This is why humans receive the impression that a system “thinks.” The outputs appear intelligent precisely because the observer cannot predict them without performing the computation itself—and performing the computation is what the system already does. The impression of thought is the impression of untracked generalization.

This analysis requires only knowing, not understanding. The system need not have learned its program or be capable of modifying it. A hand-written algorithm surprises as effectively as a trained neural network, provided the observer has not tracked the computation. What learning adds is a practical guarantee of untrackability: when millions of training examples interact nonlinearly to shape the weights, even the architect cannot reconstruct which inputs produced which internal states, making surprise inevitable rather than contingent on the observer’s laziness.

Lady Lovelace’s deeper objection—that a machine cannot write *new* programs, only execute given ones—concerns the distinction between knowing and understanding identified in Section 8, and lies beyond the scope of the present paper.

### 6.2 On Putnam’s triviality argument

Putnam [^29] argued that every ordinary open physical system implements every abstract finite state automaton, making computational descriptions trivial. If this applied to our framework, every system would have $\mathcal{I}=\infty$.

The independence condition blocks this. Putnam’s construction works by *relabeling* physical states post hoc. But relabeling does not create genuinely independent outputs. If dynamics at $t_{1}$ determine dynamics at $t_{2}$, then $K(o_{t_{2}}\mid o_{t_{1}})\ll K(o_{t_{2}})$ —the outputs are not independent. A wall’s molecular motion produces no genuinely independent outputs in response to distinct inputs: $N(S)\approx 0$, so $\mathcal{I}\approx 0$.

### 6.3 Computability

Both $\mathcal{I}(S)$ and Legg-Hutter’s $\Upsilon$ depend on Kolmogorov complexity $K$, which is provably incomputable [^21]. However, the practical situations differ markedly. Legg-Hutter’s $\Upsilon$ cannot be computed even for a single XOR gate: it requires summing over all computable environments, each weighted by its Kolmogorov complexity. Our $\mathcal{I}$, by contrast, yields a concrete number for an XOR gate ($0.25$) with pencil and paper, and the multiplication scaling table in Section 3 provides exact values across an entire continuum of systems. No prior measure of intelligence has produced worked numerical examples at this level of concreteness.

The incomputability of $K$ is best understood not as a defect of the definition but as a feature of its idealization. As argued in Section 3, $K(o_{1}\mid o_{2})$ is the limit approached by an interrogator of increasing capability: it is the answer a perfect predictor would give. Real interrogators—compression algorithms, language models, human experts—are computable approximations of this limit. The incomputability of $K$ places the theoretical ideal beyond any finite computation, just as the Carnot efficiency places a thermodynamic ideal beyond any real engine, without undermining the usefulness of either concept. For the independence condition, this means: in practice, one uses the best available compressor or interrogator as a proxy for $K$, knowing that the true independence is the limit these proxies approach. For complex systems such as brains or large language models, exact computation of $\mathcal{I}$ remains open. But the qualitative determination—whether $\mathcal{I}(n)$ diverges or vanishes—is often decidable: a finite system that handles an infinite input domain (Proposition 1) cannot be a lookup table, so its $\mathcal{I}(n)$ diverges. Compression-based approximations of $K$ can tighten the quantitative bounds further.

The worked examples in Section 3 illustrate why exact computation of $K$ is unnecessary for the divergence criterion. For an XOR gate, $\mathcal{I}=0.25$ is exact—no approximation of $K$ is involved. For the multiplication algorithm, $\log_{2}N\approx 6.6n$ and $C\approx 667$ bits; the coefficient $6.6$ depends on the choice of base, and $C$ might be $600$ or $700$ bits under a different accounting, but these are constant factors that do not affect the divergence of $\mathcal{I}(n)=\Theta(n)$. For a lookup table, $\mathcal{I}(n)\to 0$ regardless of how generously one estimates $N$ or how conservatively one estimates $C$. The divergence criterion asks only for the order of growth, not the exact value—and order of growth is robust to the constant-factor uncertainties that incomputability introduces.

### 6.4 The Redefinition Objection

Perhaps the most fundamental objection: we have redefined intelligence, not shown that machines have it. This presupposes that there exists a “real” intelligence that our definition fails to capture. No one has ever produced a consensus definition; Legg and Hutter [^22] collected over seventy and found no convergence. Our $\mathcal{I}$ completes Turing’s move: if intelligence exists as a natural kind, $\mathcal{I}$ measures it; if it does not, $\mathcal{I}$ still measures a real physical quantity that does explanatory work. As for the objection that intelligence requires goals: $\mathcal{I}$ measures the computational capacity that *enables* goal-achievement, without requiring goals to be specified. Goals are orthogonal to generalization capacity.

Moreover, we are not redefining intelligence—we are formalizing what people already do. When judging intelligence, humans implicitly estimate intelligence density in three steps: (1) a *capacity filter* —dismissing systems with obviously small $C$ (rivers, rocks) as candidates; (2) *output diversity* —how many different, correct responses across different situations; and (3) *independence detection* —recognizing when an output is merely a rephrasing versus genuinely new information, an informal approximation of $K(o_{2}\mid o_{1})\approx K(o_{2})$. The summary table in Section 3 confirms that $\mathcal{I}$ reproduces these intuitive judgments across the full continuum from rocks to brains.

Two subsidiary objections can be addressed briefly. First, observer-dependence: Searle [^32] argued that whether a physical system “computes” depends on how an observer interprets it, and one might worry that defining intelligence in terms of inputs and outputs collapses the framework into behaviorism. Both concerns are answered by the same features of the definition. The independence condition provides an observer-independent criterion—whether outputs are independent is a fact about Kolmogorov complexity, not about observers. And unlike behaviorism, our metric references internal structure through $C$ in the denominator: a massive lookup table and a compact algorithm with identical input-output behavior have very different scaling. Second, the qualia objection insists that genuine understanding requires subjective phenomenal experience [^27] [^7], and the stochastic parrot objection [^4] insists that LLMs merely remix training data. Both reduce to the claim that computation is not “real” understanding. This paper defines intelligence, not consciousness (Section 1). The concept of qualia itself is contested [^13] [^8] [^15], but we need not enter that debate: $\mathcal{I}$ measures generalization capacity regardless of whether the system has experiences.

A related objection holds that $\mathcal{I}$ merely measures whether a program is general enough, not whether it thinks. Our thesis is that these are the same question at the level of knowing. If thinking requires something beyond generalization over a domain, that additional requirement must be specified. The only candidates are consciousness (beyond our scope) and the ability to generate new programs for novel domains (the subject of future work on understanding). Until a further requirement is articulated, “Is the program general enough?” and “Does it know?” are the same question, and $\mathcal{I}$ answers it.

Humans also weight *speed* of response when judging intelligence [^12]. This reveals a tradeoff that $\mathcal{I}$ captures indirectly. A system with minimal $C$ —the shortest possible program—achieves the highest intelligence density but may be slow, since every output must be computed from first principles. A system that caches intermediate results, stores redundant shortcuts, or maintains parallel pathways has a larger $C$ and therefore lower density, but responds faster. A second reason for large $C$ is multi-domain coverage: a system that handles arithmetic, chess, language, and motor control simultaneously requires a larger mechanism than one specialized to a single domain, even if each domain’s function composition is individually compact. Biological brains and large language models both exhibit large $C$ for both reasons—speed optimization and multi-domain coverage—which is why their $\mathcal{I}$ in any single fixed domain is modest. The qualitative determination—that $\mathcal{I}$ does not vanish as the domain scales—is unaffected by either tradeoff.

### 6.5 Falsifiability

Two types of counterexample would refute this definition.

*False positive:* a system with $\mathcal{I}(n)\to\infty$ that no one would call intelligent. This would require a system with small capacity that produces many independent correct outputs across a large domain, yet fails to exhibit anything recognizable as knowing. We are not aware of such a system. A pseudo-random number generator might appear to have high $N$, but all known implementations are deterministic: given the seed and algorithm, every output is predictable from any other, so $K(o_{2}\mid o_{1})\ll K(o_{2})$ and the outputs are not independent. The independence condition filters them out.

*False negative:* a system with $\mathcal{I}(n)\to 0$ that everyone would call intelligent. This would require a system that clearly knows a domain but achieves its performance through pure memorization—a lookup table that knows. Block’s Blockhead is the canonical thought experiment here. For unbounded domains it is physically unrealizable (Proposition 1). For bounded but linguistically interesting domains, Section 3 establishes two further reasons Blockhead fails: (i) it cannot answer questions at the intersection of domains it has not explicitly stored, and (ii) the storage required for realistic conversational coverage exceeds the physical capacity of the universe. In all these cases, $\mathcal{I}(n)\to 0$ correctly diagnoses memorization.

A weaker but empirically accessible test: measure $\mathcal{I}$ for a range of systems (calculators, expert systems, language models, humans in restricted domains) and compare with human judgments of intelligence. If $\mathcal{I}$ fails to correlate with human judgments—after controlling for biases such as anthropomorphism, social cues, appearance, and confidence—the definition would require revision. Conversely, systematic discrepancies may reveal biases in human judgment rather than limitations in the metric. We consider this an important direction for future experimental work.

## 7 Conclusion

Prior debates about machine intelligence have been qualitative: does the system think or not? This paper replaces the binary question with a quantitative measure, and shows that the qualitative distinction—knowing versus not knowing—emerges from the measure’s asymptotic behavior rather than from an imposed threshold. We have proposed a quantitative definition of intelligence— $\mathcal{I}(S)=\log_{2}N(S)/C$ —and established its formal properties. The definition:

- Places intelligence on a substrate-independent continuum.
- Requires no observer, no externally defined reward, and no environment specification.
- Distinguishes generalization from memorization via the independence condition.
- Blocks Putnam’s triviality argument.

The definition has immediate consequences for several longstanding philosophical debates. Searle’s Chinese Room Argument [^31] is addressed by Proposition 1: any finite rulebook handling the infinite space of Chinese conversations must generalize, so $\mathcal{I}(\text{rulebook})\to\infty$, and by Definition 3, the rulebook knows Chinese. The intelligence is in the rulebook—in the algorithms that generalize across infinite inputs—not in the person executing it. The person is a processor, contributing no more to the intelligence of the output than a CPU contributes to the meaning of the software it runs. The summary table in Section 3 confirms that $\mathcal{I}$ reproduces intuitive judgments across the full continuum from rocks to brains, while revealing a four-way partition—no computation, memorization, computation without knowing, and knowing—that no prior framework has identified.

The question is not whether machines can think. Intelligence is generalization, and the measure of generalization is divergence: a finite system whose $\mathcal{I}(n)\to\infty$ knows its domain. Any machine that generalizes already “thinks”—to the degree that it generalizes. What Turing knew in 1950, we have now formalized.

A natural extension concerns the distinction between *knowing* and *understanding*. This paper measures the final state of a system—whether a given arrangement of functions generalizes over a domain. It does not ask whether the system can construct or modify that arrangement for new domains. A multiplication algorithm written by a programmer and a neural network that learned multiplication by gradient descent have the same $\mathcal{I}$, but the network can potentially learn new tasks while the algorithm cannot. Formalizing this distinction—between a system that executes a correct arrangement and a system that generates one—is the subject of future work.

## Acknowledgments

The author thanks the students of Science and Civilization (since 2012) for helpful discussions. He used Claude (Anthropic) for editing and discussion during the manuscript preparation. The final content was reviewed and approved by the author, who takes full responsibility for the work.

[^1]: Aaronson, S. (2014). Why I am not an integrated information theorist. Shtetl-Optimized.

[^2]: Allen, C. & Hospedales, T. (2019). Analogies explained: Towards understanding word embeddings. Proceedings of ICML 2019, 223–231.

[^3]: Arora, S. & Barak, B. (2009). Computational Complexity: A Modern Approach. Cambridge University Press.

[^4]: Bender, E. M. & Koller, A. (2020). Climbing towards NLU: On meaning, form, and understanding in the age of data. Proc. ACL 2020, 5185–5198.

[^5]: Block, N. (1981). Psychologism and behaviorism. The Philosophical Review, 90(1), 5–43.

[^6]: Brooks, R. A. (1991). Intelligence without representation. Artificial Intelligence, 47(1–3), 139–159.

[^7]: Chalmers, D. J. (1995). Facing up to the problem of consciousness. Journal of Consciousness Studies, 2(3), 200–219.

[^8]: Churchland, P. M. (1981). Eliminative materialism and the propositional attitudes. Journal of Philosophy, 78(2), 67–90.

[^9]: Chollet, F. (2019). On the measure of intelligence. arXiv:1911.01547.

[^10]: Cybenko, G. (1989). Approximation by superpositions of a sigmoidal function. Mathematics of Control, Signals, and Systems, 2(4), 303–314.

[^11]: Curry, H. B. (1934). Functionality in combinatory logic. Proceedings of the National Academy of Sciences, 20(11), 584–590.

[^12]: Dennett, D. C. (1987). Fast thinking. In The Intentional Stance, 324–337. MIT Press.

[^13]: Dennett, D. C. (1988). Quining qualia. In A. J. Marcel & E. Bisiach (Eds.), Consciousness in Contemporary Science, 42–77. Oxford University Press.

[^14]: Firth, J. R. (1957). A synopsis of linguistic theory, 1930–1955. In Studies in Linguistic Analysis, 1–32. Blackwell.

[^15]: Frankish, K. (2016). Illusionism as a theory of consciousness. Journal of Consciousness Studies, 23(11–12), 11–39.

[^16]: Fodor, J. A. (1975). The Language of Thought. Harvard University Press.

[^17]: Harnad, S. (1990). The symbol grounding problem. Physica D, 42(1–3), 335–346.

[^18]: Hornik, K., Stinchcombe, M. & White, H. (1989). Multilayer feedforward networks are universal approximators. Neural Networks, 2(5), 359–366.

[^19]: Howard, W. A. (1980). The formulae-as-types notion of construction. In J. P. Seldin & J. R. Hindley (Eds.), To H. B. Curry: Essays on Combinatory Logic, Lambda Calculus and Formalism, 479–490. Academic Press. (Original manuscript 1969.)

[^20]: Hutter, M. (2005). Universal Artificial Intelligence. Springer.

[^21]: Kolmogorov, A. N. (1965). Three approaches to the quantitative definition of information. Problems of Information Transmission, 1(1), 1–7.

[^22]: Legg, S. & Hutter, M. (2007). Universal intelligence: A definition of machine intelligence. Minds and Machines, 17(4), 391–444.

[^23]: Levy, O. & Goldberg, Y. (2014). Neural word embedding as implicit matrix factorization. Advances in Neural Information Processing Systems, 27, 2177–2185.

[^24]: Minsky, M. L. (1967). Computation: Finite and Infinite Machines. Prentice-Hall.

[^25]: Mikolov, T., Sutskever, I., Chen, K., Corrado, G. S. & Dean, J. (2013). Distributed representations of words and phrases and their compositionality. Advances in Neural Information Processing Systems, 26, 3111–3119.

[^26]: Montague, R. (1970). Universal grammar. Theoria, 36(3), 373–398.

[^27]: Nagel, T. (1974). What is it like to be a bat? The Philosophical Review, 83(4), 435–450.

[^28]: Putnam, H. (1967). The nature of mental states. In W. H. Capitan & D. D. Merrill (Eds.), Art, Mind, and Religion, 37–48. University of Pittsburgh Press.

[^29]: Putnam, H. (1988). Representation and Reality. MIT Press.

[^30]: Rissanen, J. (1978). Modeling by shortest data description. Automatica, 14(5), 465–471.

[^31]: Searle, J. R. (1980). Minds, brains, and programs. Behavioral and Brain Sciences, 3(3), 417–457.

[^32]: Searle, J. R. (1992). The Rediscovery of the Mind. MIT Press.

[^33]: Saussure, F. de (1916). Course in General Linguistics. Translated by W. Baskin. Columbia University Press, 1959.

[^34]: Shannon, C. E. (1948). A mathematical theory of communication. Bell System Technical Journal, 27(3), 379–423.

[^35]: Shannon, C. E. (1949). The synthesis of two-terminal switching circuits. Bell System Technical Journal, 28(1), 59–98.

[^36]: Seth, A. (2021). Being You: A New Science of Consciousness. Dutton.

[^37]: Solomonoff, R. J. (1964). A formal theory of inductive inference. Information and Control, 7(1), 1–22.

[^38]: Tononi, G. (2004). An information integration theory of consciousness. BMC Neuroscience, 5, 42.

[^39]: Turing, A. M. (1950). Computing machinery and intelligence. Mind, 59(236), 433–460.

[^40]: Turing, A. M. (c. 1951). Letter to B. H. Worsley. Archives Centre, King’s College, Cambridge.

[^41]: Wittgenstein, L. (1953). Philosophical Investigations. Translated by G. E. M. Anscombe. Blackwell.