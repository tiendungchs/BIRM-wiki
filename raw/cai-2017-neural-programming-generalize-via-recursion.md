---
title: "Making Neural Programming Architectures Generalize via Recursion"
source: "https://arxiv.org/abs/1704.06611"
created: 2026-09-13
tags:
  - "pdf2md"
---

# cai-2017-neural-programming-generalize-via-recursion

> Converted from `cai-2017-neural-programming-generalize-via-recursion.pdf` on 2026-09-13 via `pymupdf4llm`.
> Layout artefacts (broken equations, interleaved columns) are conversion noise, not the source.

---

<u>Published as a conference paper at ICLR 2017</u>

## MAKING NEURAL PROGRAMMING ARCHITECTURES GENERALIZE VIA RECURSION

**Jonathon Cai, Richard Shin, Dawn Song**
Department of Computer Science
University of California, Berkeley
Berkeley, CA 94720, USA
_{_ jonathon,ricshin,dawnsong _}_ @cs.berkeley.edu

ABSTRACT

Empirically, neural networks that attempt to learn programs from data have exhibited poor generalizability. Moreover, it has traditionally been difficult to reason
about the behavior of these models beyond a certain level of input complexity. In
order to address these issues, we propose augmenting neural architectures with
a key abstraction: recursion. As an application, we implement recursion in the
Neural Programmer-Interpreter framework on four tasks: grade-school addition,
bubble sort, topological sort, and quicksort. We demonstrate superior generalizability and interpretability with small amounts of training data. Recursion divides
the problem into smaller pieces and drastically reduces the domain of each neural network component, making it tractable to prove guarantees about the overall
system’s behavior. Our experience suggests that in order for neural architectures
to robustly learn program semantics, it is necessary to incorporate a concept like
recursion.

1 INTRODUCTION

Training neural networks to synthesize robust programs from a small number of examples is a challenging task. The space of possible programs is extremely large, and composing a program that performs robustly on the infinite space of possible inputs is difficult—in part because it is impractical
to obtain enough training examples to easily disambiguate amongst all possible programs. Nevertheless, we would like the model to quickly learn to represent the right semantics of the underlying
program from a small number of training examples, not an exhaustive number of them.

Thus far, to evaluate the efficacy of neural models on programming tasks, the only metric that has
been used is generalization of expected behavior to inputs of greater complexity (Vinyals et al.
(2015), Kaiser & Sutskever (2015), Reed & de Freitas (2016), Graves et al. (2016), Zaremba et al.
(2016)). For example, for the addition task, the model is trained on short inputs and then tested on
its ability to sum inputs with much longer numbers of digits. Empirically, existing models suffer
from a common limitation—generalization becomes poor beyond a threshold level of complexity.
Errors arise due to undesirable and uninterpretable dependencies and associations the architecture
learns to store in some high-dimensional hidden state. This makes it difficult to reason about what
the model will do when given complex inputs.

One common strategy to improve generalization is to use curriculum learning, where the model is
trained on inputs of gradually increasing complexity. However, models that make use of this strategy
eventually fail after a certain level of complexity (e.g. the single-digit multiplication task in Zaremba
et al. (2016), the bubble sort task in Reed & de Freitas (2016), and the graph tasks in Graves et al.
(2016)). In this version of curriculum learning, even though the inputs are gradually becoming more
complex, the semantics of the program is succinct and does not change. Although the model is
exposed to more and more data, it might learn spurious and overly complex representations of the
program, as suggested in Zaremba et al. (2016). That is to say, the network does not learn the true
program semantics.

In this paper, we propose to resolve these issues by explicitly incorporating recursion into neural
architectures. Recursion is an important concept in programming languages and a critical tool to

1

<u>Published as a conference paper at ICLR 2017</u>

reduce the complexity of programs. We find that recursion makes it easier for the network to learn
the right program and generalize to unknown situations. Recursion enables provable guarantees on
neural programs’ behavior without needing to exhaustively enumerate all possible inputs to the programs. This paper is the first (to our knowledge) to investigate the important problem of provable
generalization properties of neural programs. As an application, we incorporate recursion into the
Neural Programmer-Interpreter architecture and consider four sample tasks: grade-school addition,
bubble sort, topological sort, and quicksort. Empirically, we observe that the learned recursive programs solve all valid inputs with 100% accuracy after training on a very small number of examples,
out-performing previous generalization results. Given verification sets that cover all the base cases
and reduction rules, we can provide proofs that these learned programs generalize perfectly. This is
the first time one can provide provable guarantees of perfect generalization for neural programs.

2 THE PROBLEM AND OUR APPROACH

2.1 THE PROBLEM OF GENERALIZATION

When constructing a neural network for the purpose of learning a program, there are two orthogonal
aspects to consider. The first is the actual model architecture. Numerous models have been proposed
for learning programs; to name a few, this includes the Differentiable Neural Computer (Graves
et al., 2016), Neural Turing Machine (Graves et al., 2014), Neural GPU (Kaiser & Sutskever, 2015),
Neural Programmer (Neelakantan et al., 2015), Pointer Network (Vinyals et al., 2015), Hierarchical
Attentive Memory (Andrychowicz & Kurach, 2016), and Neural Random Access Machine (Kurach
et al., 2016). The architecture usually possesses some form of memory, which could be internal
(such as the hidden state of a recurrent neural network) or external (such as a discrete “scratch pad”
or a memory block with differentiable access). The second is the training procedure, which consists
of the form of the training data and the optimization process. Almost all architectures train on
program input/output pairs. The only model, to our knowledge, that does not train on input-output
pairs is the Neural Programmer-Interpreter (Reed & de Freitas, 2016), which trains on synthetic
execution traces.

To evaluate a neural network that learns a neural program to accomplish a certain task, one common
evaluation metric is how well the learned model _M_ generalizes. More specifically, when _M_ is
trained on simpler inputs, such as inputs of a small length, the _generalization_ metric evaluates how
well _M_ will do on more complex inputs, such as inputs of much longer length. _M_ is considered to
have perfect generalization if _M_ can give the right answer for any input, such as inputs of arbitrary
length.

As mentioned in Section 1, all approaches to neural programming today fare poorly on this generalization issue. We hypothesize that the reason for this is that the neural network learns to spuriously
depend on specific characteristics of the training examples that are irrelevant to the true program
semantics, such as length of the training inputs, and thus fails to generalize to more complex inputs.

In addition, none of the current approaches to neural programming provide a method or even aim to
enable provable guarantees about generalization. The memory updates of these neural programs are
so complex and interdependent that it is difficult to reason about the behaviors of the learned neural
program under previously unseen situations (such as problems with longer inputs). This is highly
undesirable, since being able to provide the correct answer in all possible settings is one of the most
important aspects of any learned neural program.

2.2 OUR APPROACH USING RECURSION

In this paper, we propose that the key abstraction of _recursion_ is necessary for neural programs to
generalize. The general notion of recursion has been an important concept in many domains, including mathematics and computer science. In computer science, recursion (as opposed to iteration)
involves solving a larger problem by combining solutions to smaller instances of the same problem.
Formally, a function exhibits recursive behavior when it possesses two properties: (1) Base cases—
terminating scenarios that do not use recursion to produce answers; (2) A set of rules that reduces all
other problems toward the base cases. Some functional programming languages go so far as not to
define any looping constructs but rely solely on recursion to enable repeated execution of the same
code.

2

<u>Published as a conference paper at ICLR 2017</u>

In this paper, we propose that recursion is an important concept for neural programs as well. In
fact, we argue that recursion is an essential element for neural programs to generalize, and makes it
tractable to prove the generalization of neural programs. Recursion can be implemented differently
for different neural programming models. Here as a concrete and general example, we consider a
general Neural Programming Architecture (NPA), similar to Neural Programmer-Interpreter (NPI)
in Reed & de Freitas (2016). In this architecture, we consider a core controller, e.g., an LSTM
in NPI’s case, but possibly other networks in different cases. There is a (changing) list of neural
programs used to accomplish a given task. The core controller acts as a dispatcher for the programs.
At each time step, the core controller can decide to select one of the programs to call with certain
arguments. When the program is called, the current context including the caller’s memory state is
stored on a stack; when the program returns, the stored context is popped off the stack to resume
execution in the previous caller’s context.

In this general Neural Programming Architecture, we show it is easy to support recursion. In particular, recursion can be implemented as a program calling itself. Because the context of the caller
is stored on a stack when it calls another program and the callee starts in a fresh context, this enables recursion simply by allowing a program to call itself. In practice, we can additionally use tail
recursion optimization to avoid problems with the call stack growing too deep. Thus, any general
Neural Programming Architecture supporting such a call structure can be made to support recursion.
In particular, this condition is satisfied by NPI, and thus the NPI model naturally supports recursion
(even though the authors of NPI did not consider this aspect explicitly).

By nature, recursion reduces the complexity of a problem to simpler instances. Thus, recursion
helps decompose a problem and makes it easier to reason about a program’s behavior for previously
unseen situations such as longer inputs. In particular, given that a recursion is defined by two
properties as mentioned before, the base cases and the set of reduction rules, we can prove a recursive
neural program generalizes perfectly if we can prove that (1) it performs correctly on the base cases;
(2) it learns the reduction rules correctly. For many problems, the base cases and reduction rules
usually consist of a finite (often small) number of cases. For problems where the base cases may be
extremely large or infinite, such as certain forms of motor control, recursion can still help reduce the
problem of generalization to these two aspects and make the generalization problem significantly
simpler to handle and reason about.

As a concrete instantiation, we show in this paper that we can enable recursive neural programs in the
NPI model, and thus enable perfectly generalizable neural programs for tasks such as sorting where
the original, non-recursive NPI program fails. As aforementioned, the NPI model naturally supports
recursion. However, the authors of NPI did not consider explicitly the notion of recursion and as a
consequence, did not learn recursive programs. We show that by modifying the training procedure,
we enable the NPI model to learn recursive neural programs. As a consequence, our learned neural
programs empirically achieve perfect generalization from a very small number of training examples.
Furthermore, given a verification input set that covers all base cases and reduction rules, we can
formally prove that the learned neural programs achieve perfect generalization after verifying its
behavior on the verification input set. This is the first time one can provide provable guarantees of
perfect generalization for neural programs.

We would also like to point out that in this paper, we provide as an example one way to train a
recursive neural program, by providing a certain training execution trace to the NPI model. However,
our concept of recursion for neural programs is general. In fact, it is one of our future directions to
explore new ways to train a recursive neural program without providing explicit training execution
traces or with only partial or non-recursive traces.

3 APPLICATION TO LEARNING RECURSIVE NEURAL PROGRAMS WITH NPI

3.1 BACKGROUND: NPI ARCHITECTURE

As discussed in Section 2, the Neural Programmer-Interpreter (NPI) is an instance of a Neural
Programmer Architecture and hence it naturally supports recursion. In this section, we give a brief
review of the NPI architecture from Reed & de Freitas (2016) as background.

3

<u>Published as a conference paper at ICLR 2017</u>

We describe the details of the NPI model relevant to our contributions. We adapt machinery from
the original paper slightly to fit our needs. The NPI model has three learnable components: a
task-agnostic core, a program-key embedding, and domain-specific encoders that allow the NPI to
operate in diverse environments.

The NPI accesses an external environment, _Q_, which varies according to the task. The core module
of the NPI is an LSTM controller that takes as input a slice of the current external environment, via
a set of pointers, and a program and arguments to execute. NPI then outputs the return probability
and next program and arguments to execute. Formally, the NPI is represented by the following set
of equations:

_st_ = _fenc_ ( _et, at_ )

_ht_ = _flstm_ ( _st, pt, ht−_ 1)

_rt_ = _fend_ ( _ht_ ) _, pt_ +1 = _fprog_ ( _ht_ ) _, at_ +1 = _farg_ ( _ht_ )

_t_ is a subscript denoting the time-step; _fenc_ is a domain-specific encoder (to be described later) that
takes in the environment slice _et_ and arguments _at_ ; _flstm_ represents the core module, which takes
in the state _st_ generated by _fenc_, a program embedding _pt_ _∈_ R <sup>_P_</sup>, and hidden LSTM state _ht_ ; _fend_
decodes the return probability _rt_ ; _fprog_ decodes a program key embedding _pt_ +1; <sup>1</sup> and _farg_ decodes
arguments _at_ +1. The outputs _rt, pt_ +1 _, at_ +1 are used to determine the next action, as described in
Algorithm 1. If the program is primitive, the next environmental state _et_ +1 will be affected by _pt_
and _at_, i.e. _et_ +1 _∼_ _fenv_ ( _et, pt, at_ ). As with the original NPI architecture, the experiments for this
paper always used a 3-tuple of integers _at_ = ( _at_ (1) _, at_ (2) _, at_ (3)).

**<u>Algorithm 1</u>** <u>Neural programming inference</u>

1: **<u>Inputs</u>** <u>:</u> <u>Environment observation</u> _e_ <u>, program</u> _p_ <u>, arguments</u> _a_ <u>, stop threshold</u> _α_
2: **function** RUN( _e, p, a_ )
3: _h ←_ **0** _, r_ _←_ 0
4: **while** _r_ _< α_ **do**
5: _s ←_ _fenc_ ( _e, a_ ) _, h ←_ _flstm_ ( _s, p, h_ )
6:7: _r_ **if** _p←_ is a primitive function _fend_ ( _h_ ) _, p_ 2 _←_ _fprog_ ( **then** _h_ ) _, a_ 2 _←_ _farg_ ( _h_ )
8: _e ←_ _fenv_ ( _e, p, a_ ).
9: **else**
10: **<u>function</u>** RUN( _e, p_ 2 _, a_ 2)

A description of the inference procedure is given in Algorithm 1. Each step during an execution
of the program does one of three things: (1) another subprogram along with associated arguments
is called, as in Line 10, (2) the program writes to the environment if it is primitive, as in Line 8,
or (3) the loop is terminated if the return probability exceeds a threshold _α_, after which the stack
frame is popped and control is returned to the caller. In all experiments, _α_ is set to 0.5. Each time a
subprogram is called, the stack depth increases.

The training data for the Neural Programmer-Interpreter consists of full execution traces for the
program of interest. A single element of an execution trace consists of a step input-step output pair,
which can be synthesized from Algorithm 1: this corresponds to, for a given time-step, the step
input tuple ( _e, p, a_ ) and step output tuple ( _r, p_ 2 _, a_ 2). An example of part of an addition task trace,
written in shorthand, is given in Figure 1. For example, a step input-step output pair in Lines 2 and
3 of the left-hand side of Figure 1 is (ADD1, WRITE OUT 1). In this pair, the step input runs
a subprogram ADD1 that has no arguments, and the step output contains a program WRITE that
has arguments of OUT and 1. The environment and return probability are omitted for readability.
Indentation indicates the stack is one level deeper than before.

It is important to emphasize that at inference time in the NPI, the hidden state of the LSTM controller
is reset (to zero) at each subprogram call, as in Line 3 of Algorithm 1 ( _h_ _←_ **0** ). This functionality

embedding1The original _pt_ +1, which we also did in our implementation, but we omit this for brevity.NPI paper decodes to a program key embedding _kt_ _∈_ R _K_ and then computes a program

4

<u>Published as a conference paper at ICLR 2017</u>

Non-Recursive

1 ADD
2 ADD1
3 WRITE OUT 1
4 CARRY
5 PTR CARRY LEFT
6 WRITE CARRY 1
7 PTR CARRY RIGHT
8 LSHIFT
9 PTR INP1 LEFT
10 PTR INP2 LEFT
11 PTR CARRY LEFT
12 PTR OUT LEFT
13 ADD1
14 ...

Recursive

1 ADD
2 ADD1
3 WRITE OUT 1
4 CARRY
5 PTR CARRY LEFT
6 WRITE CARRY 1
7 PTR CARRY RIGHT
8 LSHIFT
9 PTR INP1 LEFT
10 PTR INP2 LEFT
11 PTR CARRY LEFT
12 PTR OUT LEFT
13 **ADD**
14 ...

Figure 1: Addition Task. The non-recursive trace loops on cycles of ADD1 and LSHIFT, whereas
in the recursive version, the ADD function calls itself (bolded).

is critical for implementing recursion, since it permits us to restrict our attention to the currently
relevant recursive call, ignoring irrelevant details about other contexts.

3.2 RECURSIVE FORMULATIONS FOR NPI PROGRAMS

We emphasize the overall goal of this work is to enable the learning of a recursive program. The
learned recursive program is different from neural programs learned in all previous work in an important aspect: previous approaches do not explicitly incorporate this abstraction, and hence generalize
poorly, whereas our learned neural programs incorporate recursion and achieve perfect generalization.

Since NPI naturally supports the notion of recursion, a key question is how to enable NPI to learn
recursive programs. We found that changing the NPI training traces is a simple way to enable this.
In particular, we construct new training traces which explicitly contain recursive elements and show
that with this type of trace, NPI easily learns recursive programs. In future work, we would like to
decrease supervision and construct models that are capable of coming up with recursive abstractions
themselves.

In what follows, we describe the way in which we constructed NPI training traces so as to make
them contain recursive elements and thus enable NPI to learn recursive programs. We describe the
recursive re-formulation of traces for two tasks from the original NPI paper—grade-school addition
and bubble sort. For these programs, we re-use the appropriate program sets (the associated subprograms), and we refer the reader to the appendix of Reed & de Freitas (2016) for further details on
the subprograms used in addition and bubble sort. Finally, we implement recursive traces for our
own topological sort and quicksort tasks.

**Grade School Addition.** For grade-school addition, the domain-specific encoder is

_fenc_ ( _Q, i_ 1 _, i_ 2 _, i_ 3 _, i_ 4 _, at_ ) = _MLP_ ([ _Q_ (1 _, i_ 1) _, Q_ (2 _, i_ 2) _, Q_ (3 _, i_ 3) _, Q_ (4 _, i_ 4) _, at_ (1) _, at_ (2) _, at_ (3)]) _,_

where the environment _Q_ _∈_ R <sup>4</sup> <sup>_×N_</sup> <sup>_×K_</sup> is a scratch-pad that contains four rows (the first input number, the second input number, the carry bits, and the output) and _N_ columns. _K_ is set to 11, to
represent the range of 10 possible digits, along with a token representing the end of input. <sup>2</sup> At
any given time, the NPI has access to values pointed to by four pointers in each of the four rows,
represented by _Q_ (1 _, i_ 1) _, Q_ (2 _, i_ 2) _, Q_ (3 _, i_ 3), and _Q_ (4 _, i_ 4).

The non-recursive trace loops on cycles of ADD1 and LSHIFT. ADD1 is a subprogram that adds
the current column (writing the appropriate digit to the output row and carrying a bit to the next
column if needed). LSHIFT moves the four pointers to the left, to move to the next column. The
program terminates when seeing no numbers in the current column.

Figure 1 shows examples of non-recursive and recursive addition traces. We make the trace recursive
by adding a tail recursive call into the trace for the ADD program after calling ADD1 and LSHIFT,

2The original paper uses _K_ = 10, but we found it necessary to augment the range with an end token, in
order to terminate properly.

5

<u>Published as a conference paper at ICLR 2017</u>

Full Recursive

1 BUBBLESORT
2 BUBBLE
3 PTR 2 RIGHT
4 BSTEP
5 COMPSWAP
6
7 RSHIFT
8 PTR 1 RIGHT
9 PTR 2 RIGHT
10 **BSTEP**
11 **COMPSWAP**
12 **SWAP** **1** **2**
13 **RSHIFT**
14 **PTR** **1** **RIGHT**
15 **PTR** **2** **RIGHT**
16 **BSTEP**
17 RESET
18 LSHIFT
19 PTR 1 LEFT
20 PTR 2 LEFT
21 **LSHIFT**
22 **PTR** **1** **LEFT**
23 **PTR** **2** **LEFT**
24 **LSHIFT**
25 PTR 3 RIGHT
26 BUBBLESORT
27 BUBBLE
28 ...

Non-Recursive

1 BUBBLESORT
2 BUBBLE
3 PTR 2 RIGHT
4 BSTEP
5 COMPSWAP
6
7 RSHIFT
8 PTR 1 RIGHT
9 PTR 2 RIGHT
10 BSTEP
11 COMPSWAP
12 SWAP 1 2
13 RSHIFT
14 PTR 1 RIGHT
15 PTR 2 RIGHT
16 RESET
17 LSHIFT
18 PTR 1 LEFT
19 PTR 2 LEFT
20 LSHIFT
21 PTR 1 LEFT
22 PTR 2 LEFT
23 PTR 3 RIGHT
24 BUBBLE
25 ...

Partial Recursive

1 BUBBLESORT
2 BUBBLE
3 PTR 2 RIGHT
4 BSTEP
5 COMPSWAP
6
7 RSHIFT
8 PTR 1 RIGHT
9 PTR 2 RIGHT
10 **BSTEP**
11 **COMPSWAP**
12 **SWAP** **1** **2**
13 **RSHIFT**
14 **PTR** **1** **RIGHT**
15 **PTR** **2** **RIGHT**
16 RESET
17 LSHIFT
18 PTR 1 LEFT
19 PTR 2 LEFT
20 **LSHIFT**
21 **PTR** **1** **LEFT**
22 **PTR** **2** **LEFT**
23 PTR 3 RIGHT
24 BUBBLESORT
25 BUBBLE
26 ...

Figure 2: Bubble Sort Task. The non-recursive trace loops on cycles of BUBBLE and RESET.
The difference between the partial recursive and full recursive versions is in the indentation of Lines
10-15 and 20-22 (bolded), since in the full recursive version, BSTEP and LSHIFT are made tail
recursive; the final calls to BSTEP and LSHIFT return immediately as they occur after the pointer
reaches the end of the array. Also note that COMPSWAP conditionally swaps numbers under the
bubble pointers.

as in Line 13 of the right-hand side of Figure 1. Via the recursive call, we effectively forget that the
column just added exists, since the recursive call to ADD starts with a new hidden state for the
LSTM controller. Consequently, there is no concept of length relevant to the problem, which has
traditionally been an important focus of length-based curriculum learning.

**Bubble Sort.** For bubble sort, the domain-specific encoder is

_fenc_ ( _Q, i_ 1 _, i_ 2 _, i_ 3 _, at_ ) = _MLP_ ([ _Q_ (1 _, i_ 1) _, Q_ (1 _, i_ 2) _, i_ 3 == _length, at_ (1) _, at_ (2) _, at_ (3)]) _,_

where the environment _Q_ _∈_ R <sup>1</sup> <sup>_×N_</sup> <sup>_×K_</sup> is a scratch-pad that contains 1 row, to represent the state of
the array as sorting proceeds in-place, and _N_ columns. _K_ is set to 11, to denote the range of possible
numbers (0 through 9), along with the start/end token (represented with the same encoding) which
is observed when a pointer reaches beyond the bounds of the input. At any given time, the NPI has
access to the values referred to by two pointers, represented by _Q_ (1 _, i_ 1) and _Q_ (1 _, i_ 2) _,_ . The pointers
at index _i_ 1 and _i_ 2 are used to compare the pair of numbers considered during the bubble sweep,
swapping them if the number at _i_ 1 is greater than that in _i_ 2. These pointers are referred to as bubble
pointers. The pointer at index _i_ 3 represents a counter internal to the environment that is incremented
once after each pass of the algorithm (one cycle of BUBBLE and RESET); when incremented a
number of times equal to the length of the array, the flag _i_ 3 == _length_ becomes true and terminates
the entire algorithm.

The non-recursive trace loops on cycles of BUBBLE and RESET, which logically represents one
bubble sweep through the array and reset of the two bubble pointers to the very beginning of the
array, respectively. In this version, there is a dependence on length: BSTEP and LSHIFT are called
a number of times equivalent to one less than the length of the input array, in BUBBLE and RESET
respectively.

Inside BUBBLE and RESET, there are two operations that can be made recursive. BSTEP, used
in BUBBLE, compares pairs of numbers, continuously moving the bubble pointers once to the right
each time until reaching the end of the array. LSHIFT, used in RESET, shifts the pointers left until
reaching the start token.

6

<u>Published as a conference paper at ICLR 2017</u>

We experiment with two levels of recursion—partial and full. Partial recursion only adds a tail
recursive call to BUBBLESORT after BUBBLE and RESET, similar to the tail recursive call
described previously for addition. The partial recursion is not enough for perfect generalization, as
will be presented later in Section 4. Full recursion, in addition to making the aforementioned tail
recursive call, adds two additional recursive calls; BSTEP and LSHIFT are made tail recursive.

Figure 2 shows examples of traces for the different versions of bubble sort. Training on the full
recursive trace leads to perfect generalization, as shown in Section 4. We performed experiments
on the partially recursive version in order to examine what happens when only one recursive call is
implemented, when in reality three are required for perfect generalization.

**<u>Algorithm 2</u>** <u>Depth First Search Topological Sort</u>

1: <u>Color all vertices white.</u>
2: Initialize an empty stack _S_ and a directed acyclic graph _DAG_ to traverse.
3: Begin traversing from Vertex 1 in the DAG.
4: **function** TOPOSORT( _DAG_ )
5: **while** there is still a white vertex _u_ : **do**
6: color[ _u_ ] = grey
7: _vactive_ = _u_
8: **do**
9: **if** _vactive_ has a white child _v_ **then**
10: color[ _v_ ] = grey
11: push _vactive_ onto _S_
12: _vactive_ = _v_
13: **else**
14: color[ _vactive_ ] = black
15: Write _vactive_ to result
16: **if** _S_ is empty **then** pass
17: **else** pop the top vertex off _S_ and set it to _vactive_
18: **<u>while</u>** _S_ is not empty

**Topological Sort.** We choose to implement a topological sort task for graphs. A _topological sort_
is a linear ordering of vertices such that for every directed edge ( _u, v_ ) from _u_ to _v_, _u_ comes before
_v_ in the ordering. This is possible if and only if the graph has no directed cycles; that is to say, it
must be a directed acyclic graph (DAG). In our experiments, we only present DAG’s as inputs and
represent the vertices as values ranging from 1 _, . . ., n_, where the DAG contains _n_ vertices.

Directed acyclic graphs are structurally more diverse than inputs in the two tasks of grade-school
addition and bubble sort. The degree for any vertex in the DAG is variable. Also the DAG can have
potentially more than one connected component, meaning it is necessary to transition between these
components appropriately.

Algorithm 2 shows the topological sort task of interest. This algorithm is a variant of depth first
search. We created a program set that reflects the semantics of Algorithm 2. For brevity, we refer
the reader to the appendix for further details on the program set and non-recursive and recursive
trace-generating functions used for topological sort.

For topological sort, the domain-specific encoder is

_fenc_ ( _DAG, Qcolor, pstack, pstart, vactive, childList, at_ )
= _MLP_ ([ _Qcolor_ ( _pstart_ ) _, Qcolor_ ( _DAG_ [ _vactive_ ][ _childList_ [ _vactive_ ]]) _, pstack_ == 1 _, at_ (1) _, at_ (2) _, at_ (3)]) _,_

where(white, _Q_ gray, _color_ black, _∈_ R <sup>_U_</sup> <sup>_×_</sup> invalid) <sup>4</sup> is a scratch-padwith one-hotthatencoding.contains _UU_ variesrows, eachwith thecontainingnumberoneof verticesof four colorsin the
graph. We further have _Qresult_ _∈_ N <sup>_U_</sup>, a scratch-pad which contains the sorted list of vertices at
the end of execution, and _Qstack_ _∈_ N <sup>_U_</sup>, which serves the role of the stack _S_ in Algorithm 2. The
contents of _Qresult_ and _Qstack_ are not exposed directly through the domain-specific encoder; rather,
we define primitive functions which manipulate these scratch-pads.

The DAG is represented as an adjacency list where _DAG_ [ _i_ ][ _j_ ] refers to the _j_ -th child of vertex _i_ .
There are 3 pointers ( _presult, pstack, pstart_ ), _presult_ points to the next empty location in _Qresult_,

7

<u>Published as a conference paper at ICLR 2017</u>

_pstack_ points to the top of the stack in _Qstack_, and _pstart_ points to the candidate starting node for
a connected component. There are 2 variables ( _vactive_ and _vsave_ ); _vactive_ holds the active vertex
(as in Algorithm 2) and _vsave_ holds the value of _vactive_ before executing Line 12 of Algorithm 2.
_childList ∈_ N <sup>_U_</sup> is a vector of pointers, where _childList_ [ _i_ ] points to the next child under consideration for vertex _i_ .

The three environment observations aid with control flow in Algorithm 2. _Qcolor_ ( _pstart_ ) contains
the color of the current start vertex, used in the evaluation of the condition in the WHILE loop in Line
5 of Algorithm 2. _Qcolor_ ( _DAG_ [ _vactive_ ][ _childList_ [ _vactive_ ]]) refers to the color of the next child of
_vactive_, used in the evaluation of the condition in the IF branch in Line 9 of Algorithm 2. Finally,
the boolean _pstack_ == 1 is used to check whether the stack is empty in Line 18 of Algorithm 2.

An alternative way of representing the environment slice is to expose the values of the absolute
vertices to the model; however, this makes it difficult to scale the model to larger graphs, since large
vertex values are not seen during training time.

We refer the reader to the appendix for the non-recursive trace generating functions. In
the non-recursive trace, there are four functions that can be made recursive—TOPOSORT,
CHECK CHILD, EXPLORE, and NEXT START, and we add a tail recursive call to each of
these functions in order to make the recursive trace. In particular, in the EXPLORE function,
adding a tail recursive call resets and stores the hidden states associated with vertices in a stack-like
fashion. This makes it so that we only need to consider the vertices in the subgraph that are currently relevant for computing the sort, allowing simpler reasoning about behavior for large graphs.
The sequence of primitive operations (MOVE and WRITE operations) for the non-recursive and
recursive versions are exactly the same.

**Quicksort.** We implement a quicksort task, in order to demonstrate that recursion helps with learning divide-and-conquer algorithms. We use the Lomuto partition scheme; the logic for the recursive
trace is shown in Algorithm 3. For brevity, we refer the reader to the appendix for information about
the program set and non-recursive and recursive trace-generating functions for quicksort. The logic
for the non-recursive trace is shown in Algorithm 4 in the appendix.

**<u>Algorithm 3</u>** <u>Recursive Quicksort</u>

1: <u>Initialize an array</u> _A_ <u>to sort.</u>
2: Initialize _lo_ and _hi_ to be 1 and _n_, where _n_ is the length of _A_ .
3:
4: **function** QUICKSORT( _A, lo, hi_ )
5: **if** _lo < hi_ : **then**
6: p = PARTITION( _A, lo, hi_ )
7: QUICKSORT( _A, lo, p −_ 1)
8: QUICKSORT( _A, p_ + 1 _, hi_ )
9:
10: **function** PARTITION( _A, lo, hi_ )
11: _pivot_ = _lo_
12: **for** _j_ _∈_ [ _lo, hi −_ 1] : **do**
13: **if** _A_ [ _j_ ] _≤_ _A_ [ _hi_ ] **then**
14: swap _A_ [ _pivot_ ] with _A_ [ _j_ ]
15: _pivot_ = _pivot_ + 1
16: swap _A_ [ _pivot_ ] with _A_ [ _hi_ ]
17: return _pivot_

For quicksort, the domain-specific encoder is

_fenc_ ( _Qarray, QstackLo, QstackHi, plo, phi, pstackLo, pstackHi, ppivot, pj, at_ ) =

_MLP_ ([ _Qarray_ ( _pj_ ) _≤_ _Qarray_ ( _phi_ ) _, pj_ == _phi,_
_QstackLo_ ( _pstackLo −_ 1) _< QstackHi_ ( _pstackHi −_ 1) _, pstackLo_ == 1 _, at_ (1) _, at_ (2) _, at_ (3)]) _,_

where _Qarray_ _∈_ R <sup>_U_</sup> <sup>_×_</sup> <sup>11</sup> is a scratch-pad that contains _U_ rows, each containing one of 11 values (one
of the numbers 0 through 9 or an invalid state). Our implementation uses two stacks _QstackLo_ and

8

<u>Published as a conference paper at ICLR 2017</u>

_QstackHi_, each in R <sup>_U_</sup>, that store the arguments to the recursive QUICKSORT calls in Algorithm 3;
before each recursive call, the appropriate arguments are popped off the stack and written to _plo_ and
_phi_ .

There are 6 pointers ( _plo, phi, pstackLo, pstackHi, ppivot, pj_ ). _plo_ and _phi_ point to the _lo_ and _hi_
indices of the array, as in Algorithm 3. _pstackLo_ and _pstackHi_ point to the top (empty) positions
in _QstackLo_ and _QstackHi_ . _ppivot_ and _pj_ point to the _pivot_ and _j_ indices of the array, used in
the PARTITION function in Algorithm 3. The 4 environment observations aid with control flow;
_QstackLo_ ( _pstackLo −_ 1) _< QstackHi_ ( _pstackHi −_ 1) implements the _lo < hi_ comparison in Line 5 of
Algorithm 3, _pstackLo_ == 1 checks if the stacks are empty in Line 18 of Algorithm 4, and the other
observations (all involving _ppivot_ or _pj_ ) deal with logic in the PARTITION function.

Note that the recursion for quicksort is not purely tail recursive and therefore represents a more
complex kind of recursion that is harder to learn than in the previous tasks. Also, compared to the
bubble pointers in bubble sort, the pointers that perform the comparison for quicksort (the COMPSWAP function) are usually not adjacent to each other, making quicksort less local than bubble
sort. In order to compensate for this, _ppivot_ and _pj_ require special functions (MOVE PIVOT LO
and MOVE J LO) to properly set them to _lo_ in Lines 11 and 12 of the PARTITION function in
Algorithm 3.

3.3 PROVABLY PERFECT GENERALIZATION

We show that if we incorporate recursion, the learned NPI programs can achieve provably perfect
generalization for different tasks. Provably perfect generalization implies the model will behave
correctly, given any valid input. In order to claim a proof, we must verify the model produces
correct behavior over all base cases and reductions, as described in Section 2.

We propose and describe our verification procedure. This procedure verifies that all base cases and
reductions are handled properly by the model via explicit tests. Note that recursion helps make this
process tractable, because we only need to test a finite number of inputs to show that the model
will work correctly on inputs of unbounded complexity. This verification phase only needs to be
performed once after training.

Formally, verification consists of proving the following theorem:

_∀i ∈_ _V, M_ ( _i_ ) _⇓_ _P_ ( _i_ )

where _i_ denotes a sequence of step inputs (within one function call), _V_ denotes the set of valid
sequences of step inputs, _M_ denotes the neural network model, _P_ denotes the correct program, and
_P_ ( _i_ ) denotes the next step output from the correct program. The arrow in the theorem refers to
evaluation, as in big-step semantics. The theorem states that for the same sequence of step inputs,
the model produces the exact same step output as the target program it aims to learn. _M_, as described
in Algorithm 1, processes the sequence of step inputs by using an LSTM.

Recursion drastically reduces the number of configurations we need to consider during the verification phase and makes the proof tractable, because it introduces structure that eliminates infinitely
long sequences of step inputs that would otherwise need to be considered. For instance, for recursive
addition, consider the family _F_ of addition problems _anan−_ 1 _. . . a_ 1 _a_ 0 + _bnbn−_ 1 _. . . b_ 1 _b_ 0 where no
CARRY operations occur. We prove every member of _F_ is added properly, given that subproblems
_S_ = _{anan−_ 1 + _bnbn−_ 1, _an−_ 1 _an−_ 2 + _bn−_ 1 _bn−_ 2 _, . . ., a_ 1 _a_ 0 + _b_ 1 _b_ 0 _}_ are added properly.

Without using a recursive program, such a proof is not possible, because the non-recursive program
runs on an arbitrarily long addition problem that creates correspondingly long sequences of step
inputs; in the non-recursive formulation of addition, ADD calls ADD1 a number of times that is
dependent on the length of the input. The core LSTM module’s hidden state is preserved over all
these ADD1 calls, and it is difficult to interpret with certainty what happens over longer timesteps
without concretely evaluating the LSTM with an input of that length. In contrast, each call to
the recursive ADD always runs for a fixed number of steps, even on arbitrarily long problems
in _F_, so we can test that it performs correctly on a small, fixed number of step input sequences.
This guarantees that the step input sequences considered during verification contain all step input
sequences which arise during execution of an unseen problem in _F_, leading to generalization to any
problem in _F_ . Hence, if all subproblems in _S_ are added correctly, we have proven that any member
of _F_ will be added correctly, thus eliminating an infinite family of inputs that need to be tested.

9

<u>Published as a conference paper at ICLR 2017</u>

To perform the verification as described here, it is critical to construct _V_ correctly. If it is too small,
then execution of the program on some input might require evaluation of _M_ ( _i_ ) on some _i_ _∈/_ _V_, and
so the behavior of _M_ ( _i_ ) might deviate from _P_ ( _i_ ). If it is too large, then the semantics of _P_ might not
be well-defined on some elements in _V_, or the spurious step input sequences may not be reachable
from any valid problem input (e.g., an array for quicksort or a DAG for topological sort).

To construct this set, by using the reference implementation of each subprogram, we construct a
mapping between two sets of environment observations: the first set consists of all observations
that can occur at the beginning of a particular subprogram’s invocation, and the second set contains
the observations at the end of that subprogram. We can obtain this mapping by first considering
the possible observations that can arise at the beginning of the entry function (ADD, BUBBLESORT, TOPOSORT, and QUICKSORT) for some valid program input, and iteratively applying
the observation-to-observation mapping implied by the reference implementation’s step output at
that point in the execution. If the step output specifies a primitive function call, we need to reason
about how it can affect the environment so as to change the observation in the next step input. For
non-primitive subprograms, we can update the observation-to-observation mapping currently associated with the subprogram and then apply that mapping to the current set. By iterating with this
procedure, and then running _P_ on the input observation set that we obtain for the entry point function, we can obtain _V_ precisely. To make an analogy to MDPs, this procedure is analogous to how
value iteration obtains the correct value for each state starting from any initialization.

An alternative method is to run _P_ on many different program inputs and then observe step input
sequences which occur, to create _V_ . However, to be sure that the generated _V_ is complete (covers
all the cases needed), we need to check all pairs of observations seen in adjacent step inputs (in particular, those before and after a primitive function call), in a similar way as if we were constructing
_V_ from scratch. Given a precise definition of _P_, it may be possible to automate the generation of _V_
from _P_ in future work.

Note that _V_ should also contain the necessary reductions, which corresponds to making the recursive
calls at the correct time, as indicated by _P_ .

After finding _V_, we construct a set of problem inputs which, when executed on _P_, create exactly the
step input sequences which make up _V_ . We call this set of inputs the _verification set_, _SV_ .

Given a verification set, we can then run the model on the verification set to check if the produced
traces and results are correct. If yes, then this indicates that the learned neural program achieves
provably perfect generalization.

We note that for tasks with very large input domains, such as ones involving MNIST digits or speech
samples, the state space of base cases and reduction rules could be prohibitively large, possibly
infinite. Consequently, it is infeasible to construct a verification set that covers all cases, and the
verification procedure we have described is inadequate. We leave this as future work to devise a
verification procedure more appropriate to this setting.

4 EXPERIMENTS

As there is no public implementation of NPI, we implemented a version of it in Keras that is as
faithful to the paper as possible. Our experiments use a small number of training examples.

**Training Setup.** The training set for addition contains 200 traces. The maximum problem length
in this training set is 3 (e.g., the trace corresponding to the problem “109 + 101”).

The training set for bubble sort contains 100 traces, with maximum problem length of 2 (e.g., the
trace corresponding to the array [3,2]).

The training set for topological sort contains 6 traces, with one synthesized from a graph of size 5
and the rest synthesized from graphs of size 7.

The training set for quicksort contains 4 traces, synthesized from arrays of length 5.

The same set of problems was used to generate the training traces for all formulations of the task,
for non-recursive and recursive versions.

10

<u>Published as a conference paper at ICLR 2017</u>

Table 1: Accuracy on Randomly Generated Problems for Bubble Sort

**<u>Length of Array</u>** **<u>Non-Recursive</u>** **<u>Partially Recursive</u>** **<u>Full Recursive</u>**

2 100% 100% 100%
3 6.7% 23% 100%
4 10% 10% 100%
8 0% 0% 100%
20 0% 0% 100%
90 0% 0% 100%

We train using the Adam optimizer and use a 2-layer LSTM and task-specific state encoders for the
external environments, as described in Reed & de Freitas (2016).

4.1 RESULTS ON GENERALIZATION OF RECURSIVE NEURAL PROGRAMS

We now report on generalization for the varying tasks.

**Grade-School** **Addition.** Both the non-recursive and recursive learned programs generalize on
all input lengths we tried, up to 5000 digits. This agrees with the generalization of non-recursive
addition in Reed & de Freitas (2016), where they reported generalization up to 3000 digits. However,
note that there is no provable guarantee that the non-recursive learned program will generalize to all
inputs, whereas we show later that the recursive learned program has a provable guarantee of perfect
generalization.

In order to demonstrate that recursion can help learn and generalize better, for addition, we trained
only on traces for 5 arbitrarily chosen 1-digit addition sum examples. The recursive version can generalize perfectly to long problems constructed from these components (such as the sum “822+233”,
where “8+2” and “2+3” are in the training set), but the non-recursive version fails to sum these long
problems properly.

**Bubble** **Sort.** Table 1 presents results on randomly generated arrays of varying length for the
learned non-recursive, partially recursive, and full recursive programs. For each length, we test each
program on 30 randomly generated problems. Observe that partially recursive does slightly better
than non-recursive for the setting in which the length of the array is 3, and that the fully recursive
version is able to sort every array given to it. The non-recursive and partially recursive versions are
unable to sort long arrays, beyond length 8.

**Topological Sort.** Both the non-recursive and recursive learned programs generalize on all graphs
we tried, up to 120 vertices. As before, the non-recursive learned program lacks a provable guarantee
of generalization, whereas we show later that the recursive learned program has one.

In order to demonstrate that recursion can help learn and generalize better, we trained a non-recursive
and recursive model on just a single execution trace generated from a graph containing 5 nodes <sup>3</sup> for
the topological sort task. For these models, Table 2 presents results on randomly generated DAGs
of varying graph sizes (varying in the number of vertices). For each graph size, we test the learned
programs on 30 randomly generated DAGs. The recursive version of topological sort solves all graph
instances we tried, from graphs of size 5 through 70. On the other hand, the non-recursive version
has low accuracy, beginning from size 5, and fails completely for graphs of size 8 and beyond.

**Quicksort.** Table 3 presents results on randomly generated arrays of varying length for the learned
non-recursive and recursive programs. For each length, we test each program on 30 randomly generated problems. Observe that the non-recursive program’s correctness degrades for length 11 and
beyond, while the recursive program can sort any given array.

3The corresponding edge list is [(1, 2), (1, 5), (2, 4), (2, 5), (3, 5)].

11

<u>Published as a conference paper at ICLR 2017</u>

Table 2: Accuracy on Randomly Generated Problems for Topological Sort

**<u>Number of Vertices</u>** **<u>Non-Recursive</u>** **<u>Recursive</u>**

5 6.7% 100%
6 6.7% 100%
7 3.3% 100%
8 0% 100%
70 0% 100%

Table 3: Accuracy on Randomly Generated Problems for Quicksort

**<u>Length of Array</u>** **<u>Non-Recursive</u>** **<u>Recursive</u>**

3 100% 100%
5 100% 100%
7 100% 100%
11 73.3% 100%
15 60% 100%
20 30% 100%
22 20% 100%
25 3.33% 100%
30 3.33% 100%
70 0% 100%

As mentioned in Section 2.1, we hypothesize the non-recursive programs do not generalize well
because they have learned spurious dependencies specific to the training set, such as length of the
input problems. On the other hand, the recursive programs have learned the true program semantics.

4.2 VERIFICATION OF PROVABLY PERFECT GENERALIZATION

We describe how models trained with recursive traces can be proven to generalize, by using the
verification procedure described in Section 3.3. As described in the verification procedure, it is
possible to prove our learned recursive program generalizes perfectly by testing on an appropriate
set of problem inputs, i.e., the verification set. Recall that this verification procedure cannot be
performed for the non-recursive versions, since the propagation of the hidden state in the core LSTM
module makes reasoning difficult and so we would need to check an unbounded number of examples.

We describe the base cases, reduction rules, and the verification set for each task in Appendix A.6.
For each task, given the verification set, we check the traces and results of the learned, to-be-verified
neural program (described in Section 4.1; and for bubble sort, Appendix A.6) on the verification
set, and ensure they _match_ the traces produced by the true program _P_ . Our results show that for all
learned, to-be-verified neural programs, they all produced the same traces as those produced by _P_
on the verification set. Thus, we demonstrate that recursion enables provably perfect generalization
for different tasks, including addition, topological sort, quicksort, and a variant of bubble sort.

Note that the training set can often be considerably smaller than the verification set, and despite
this, the learned model can still pass the entire verification set. Our result shows that the training
procedure and the NPI architecture is capable of generalizing from the step input-output pairs seen
in the training data to the unseen ones present in the verification set.

5 CONCLUSION

We emphasize that the notion of a neural recursive program has not been presented in the literature
before: this is our main contribution. Recursion enables provably perfect generalization. To the best
of our knowledge, this is the first time verification has been applied to a neural program, provid

12

<u>Published as a conference paper at ICLR 2017</u>

ing provable guarantees about its behavior. We instantiated recursion for the Neural ProgrammerInterpreter by changing the training traces. In future work, we seek to enable more tasks with
recursive structure. We also hope to decrease supervision, for example by training with only partial
or non-recursive traces, and to develop novel Neural Programming Architectures integrated directly
with a notion of recursion.

ACKNOWLEDGMENTS

This material is in part based upon work supported by the National Science Foundation under Grant
No. TWC-1409915, DARPA under Grant No. FA8750-15-2-0104, and Berkeley Deep Drive. Any
opinions, findings, and conclusions or recommendations expressed in this material are those of the
author(s) and do not necessarily reflect the views of National Science Foundation and DARPA.

REFERENCES

Marcin Andrychowicz and Karol Kurach. Learning efficient algorithms with hierarchical attentive

memory. _CoRR_, abs/1602.03218, 2016. URL http://arxiv.org/abs/1602.03218.

Alex Graves, Greg Wayne, and Ivo Danihelka. Neural turing machines. _CoRR_, abs/1410.5401,

2014. URL http://arxiv.org/abs/1410.5401.

Alex Graves, Greg Wayne, Malcolm Reynolds, Tim Harley, Ivo Danihelka, Agnieszka Grabska
Barwiska, Sergio Gmez Colmenarejo, Edward Grefenstette, Tiago Ramalho, John Agapiou,
Adri Puigdomnech Badia, Karl Moritz Hermann, Yori Zwols, Georg Ostrovski, Adam Cain,
Helen King, Christopher Summerfield, Phil Blunsom, Koray Kavukcuoglu, and Demis Hassabis. Hybrid computing using a neural network with dynamic external memory. _Nature_, 538
(7626):471–476, October 2016. ISSN 0028-0836, 1476-4687. doi: 10.1038/nature20101. URL
http://www.nature.com/doifinder/10.1038/nature20101.

Lukasz Kaiser and Ilya Sutskever. Neural gpus learn algorithms. _CoRR_, abs/1511.08228, 2015.

URL http://arxiv.org/abs/1511.08228.

Karol Kurach, Marcin Andrychowicz, and Ilya Sutskever. Neural random access machines. _ERCIM_

_News_, 2016(107), 2016. URL http://ercim-news.ercim.eu/en107/special/
neural-random-access-machines.

Arvind Neelakantan, Quoc V. Le, and Ilya Sutskever. Neural programmer: Inducing latent programs

with gradient descent, 2015.

Scott Reed and Nando de Freitas. Neural programmer-interpreters. _ICLR_, 2016.

Oriol Vinyals, Meire Fortunato, and Navdeep Jaitly. Pointer networks. In _Advances in Neural In-_

_formation_ _Processing_ _Systems_ _28:_ _Annual_ _Conference_ _on_ _Neural_ _Information_ _Processing_ _Sys-_
_tems_ _2015,_ _December_ _7-12,_ _2015,_ _Montreal,_ _Quebec,_ _Canada_, pp. 2692–2700, 2015. URL
http://papers.nips.cc/paper/5866-pointer-networks.

Wojciech Zaremba, Tomas Mikolov, Armand Joulin, and Rob Fergus. Learning simple algorithms

from examples. In _Proceedings of the 33nd International Conference on Machine Learning, ICML_
_2016,_ _New_ _York_ _City,_ _NY,_ _USA,_ _June_ _19-24,_ _2016_, pp. 421–429, 2016. URL http://jmlr.
org/proceedings/papers/v48/zaremba16.html.

13

<u>Published as a conference paper at ICLR 2017</u>

A APPENDIX

A.1 PROGRAM SET FOR NON-RECURSIVE TOPOLOGICAL SORT

|Program|Descriptions|Calls|Arguments|
|---|---|---|---|
|TOPOSORT<br>|Perform topological<br>sort on graph<br>|TRAVERSE,<br>NEXT ~~S~~TART,<br>WRITE, MOVE<br>|NONE<br>|
|TRAVERSE<br>|Traverse graph until<br>stack is empty<br><br><br><br>|CHECK ~~C~~HILD, EX-<br>PLORE<br>|NONE<br>|
|CHECK ~~C~~HILD<br>|Check<br>if<br>a<br>white<br>child exists; if so, set<br>_childList_[_vactive_] to<br>point to it<br><br>|MOVE<br>|NONE<br>|
|EXPLORE<br>|Repeatedly<br>traverse<br>subgraphs until stack<br>is empty<br>|STACK,<br>CHECK ~~C~~HILD,<br>WRITE, MOVE<br>|NONE<br>|
|STACK<br>|Interact with stack,<br>either<br>pushing<br>or<br>popping<br><br>|WRITE, MOVE<br>|PUSH, POP<br>|
|NEXT ~~S~~TART<br>|Move<br>_pstart_<br>until<br>reaching<br>a<br>white<br>vertex.<br>If a white<br>vertex is found, set<br>_pstart_ to point to it;<br>this signiﬁes the start<br>of a traversal of a<br>new connected com-<br>ponent.<br>If no white<br>vertex is found, the<br>entire<br>execution<br>is<br>terminated<br>|MOVE<br>|NONE<br>|
|WRITE<br>|Write a value either<br>to environment (e.g.,<br>to<br>color<br>a<br>vertex)<br>or variable (e.g., to<br>change the value of<br>_vactive_)<br><br><br>|NONE<br>|Described below<br>|
|MOVE|Move<br>a<br>pointer<br>(e.g.,<br>_pstart_<br>or<br>_childList_[_vactive_])<br>up or down|NONE|Described below|

**Argument Sets for WRITE and MOVE.**

**WRITE.** The WRITE operation has the following arguments:

_ARG_ _~~1~~_ (Main Action): COLOR ~~C~~ URR, COLOR ~~N~~ EXT, ACTIVE ~~S~~ TART, ACTIVE ~~N~~ EIGHB,
ACTIVE ~~S~~ TACK, SAVE, STACK ~~P~~ USH, STACK ~~P~~ OP, RESULT

COLOR CURR colors _vactive_, COLOR ~~N~~ EXT colors Vertex _DAG_ [ _vactive_ ][ _childList_ [ _vactive_ ]],
ACTIVE ~~S~~ TART writes _pstart_ to _vactive_, ACTIVE ~~N~~ EIGHB writes
_DAG_ [ _vactive_ ][ _childList_ [ _vactive_ ]] to _vactive_, ACTIVE ~~S~~ TACK writes _Qstack_ ( _pstack_ ) to
_vactive_, SAVE writes _vactive_ to _vsave_, _STACK_ _~~P~~_ _USH_ pushes _vactive_ to the top of the
stack, _STACK_ _~~P~~_ _OP_ writes a null value to the top of the stack, and _RESULT_ writes _vactive_ to
_Qresult_ ( _presult_ ).

_ARG_ _~~2~~_ (Auxiliary Variable): COLOR ~~G~~ REY, COLOR ~~B~~ LACK

COLOR GREY and COLOR ~~B~~ LACK color the given vertex grey and black, respectively.

14

<u>Published as a conference paper at ICLR 2017</u>

**MOVE.** The MOVE operation has the following arguments:

_ARG_ _~~1~~_ (Pointer): _presult_, _pstack_, _pstart_, _childList_ [ _vactive_ ], _childList_ [ _vsave_ ]

Note that the argument is the identity of the pointer, not what the pointer points to; in other words,
_ARG_ _~~1~~_ can only take one of 5 values.

_ARG_ _~~2~~_ (Increment or Decrement): UP, DOWN

A.2 TRACE-GENERATING FUNCTIONS FOR TOPOLOGICAL SORT

A.2.1 NON-RECURSIVE TRACE-GENERATING FUNCTIONS

1 // Top level topological sort call
2 TOPOSORT() {
3 while ( _Qcolor_ ( _pstart_ ) is a valid color): // color invalid when all vertices explored
4 WRITE(ACTIVE_START)
5 WRITE(COLOR_CURR, COLOR_GREY)
6 TRAVERSE()
7 MOVE( _pstart_, UP)
8 NEXT_START()
9 }
10
11 TRAVERSE() {
12 CHECK_CHILD()
13 EXPLORE()
14 }
15
16 CHECK_CHILD() {
17 while ( _Qcolor_ ( _DAG_ [ _vactive_ ][ _childList_ [ _vactive_ ]]) is not white and is not invalid): // color invalid when all children explored
18 MOVE( _childList_ [ _vactive_ ], UP)
19 }
20
21 EXPLORE() {
22 do
23 if ( _Qcolor_ ( _DAG_ [ _vactive_ ][ _childList_ [ _vactive_ ]]) is white):
24 WRITE(COLOR_NEXT, COLOR_GREY)
25 STACK(PUSH)
26 WRITE(SAVE)
27 WRITE(ACTIVE_NEIGHB)
28 MOVE( _childList_ [ _vsave_ ], UP)
29 else:
30 WRITE(COLOR_CURR, COLOR_BLACK)
31 WRITE(RESULT)
32 MOVE( _presult_, UP)
33 if( _pstack_ == 1):
34 break
35 else:
36 STACK(POP)
37 CHECK_CHILD()
38 while (true)
39 }
40
41 STACK(op) {
42 if (op == PUSH):
43 WRITE(STACK_PUSH)
44 MOVE( _pstack_, UP)
45
46 if (op == POP):
47 WRITE(ACTIVE_STACK)
48 WRITE(STACK_POP)
49 MOVE( _pstack_, DOWN)
50 }
51
52 NEXT_START() {
53 while( _Qcolor_ ( _pstart_ ) is not white and is not invalid): // color invalid when all vertices explored
54 MOVE( _pstart_, UP)
55 }

15

<u>Published as a conference paper at ICLR 2017</u>

A.2.2 RECURSIVE TRACE-GENERATING FUNCTIONS

Altered Recursive Functions

1 // Top level topological sort call
2 TOPOSORT() {
3 if ( _Qcolor_ ( _pstart_ ) is a valid color): // color invalid when all vertices explored
4 WRITE(ACTIVE_START)
5 WRITE(COLOR_CURR, COLOR_GREY)
6 TRAVERSE()
7 MOVE( _pstart_, UP)
8 NEXT_START()
9 TOPOSORT() // **Recursive** **Call**
10 }
11
12 CHECK_CHILD() {
13 if ( _Qcolor_ ( _DAG_ [ _vactive_ ][ _childList_ [ _vactive_ ]]) is not white and is not invalid): // color invalid when all children explored
14 MOVE( _childList_ [ _vactive_ ], UP)
15 CHECK_CHILD() // **Recursive** **Call**
16 }
17
18 EXPLORE() {
19 if ( _Qcolor_ ( _DAG_ [ _vactive_ ][ _childList_ [ _vactive_ ]]) is white):
20 WRITE(COLOR_NEXT, COLOR_GREY)
21 STACK(PUSH)
22 WRITE(SAVE)
23 WRITE(ACTIVE_NEIGHB)
24 MOVE( _childList_ [ _vsave_ ], UP)
25 else:
26 WRITE(COLOR_CURR, COLOR_BLACK)
27 WRITE(RESULT)
28 MOVE( _presult_, UP)
29 if( _pstack_ == 1):
30 return
31 else:
32 STACK(POP)
33 CHECK_CHILD()
34 EXPLORE() // **Recursive** **Call**
35 }
36
37 NEXT_START() {
38 if ( _Qcolor_ ( _pstart_ ) is not white and is not invalid): // color invalid when all vertices explored
39 MOVE( _pstart_, UP)
40 NEXT_START() // **Recursive** **Call**
41 }

A.3 NON-RECURSIVE QUICKSORT

**<u>Algorithm 4</u>** <u>Iterative Quicksort</u>

1: <u>Initialize an array</u> _A_ <u>to sort and two empty stacks</u> _Slo_ <u>and</u> _Shi_ <u>.</u>
2: Initialize _lo_ and _hi_ to be 1 and _n_, where _n_ is the length of _A_ .
3:
4: **function** PARTITION( _A, lo, hi_ )
5: _pivot_ = _lo_
6: **for** _j_ _∈_ [ _lo, hi −_ 1] : **do**
7: **if** _A_ [ _j_ ] _≤_ _A_ [ _hi_ ] **then**
8: swap _A_ [ _pivot_ ] with _A_ [ _j_ ]
9: _pivot_ = _pivot_ + 1
10: swap _A_ [ _pivot_ ] with _A_ [ _hi_ ]
11: return _pivot_
12:
13: **function** QUICKSORT( _A, lo, hi_ )
14: **while** _Slo_ and _Shi_ are not empty: **do**
15: Pop states off _Slo_ and _Shi_, writing them to _lo_ and _hi_ .
16: p = PARTITION( _A, lo, hi_ )
17: Push _p_ + 1 and _hi_ to _Slo_ and _Shi_ .
18: Push _lo_ and _p −_ 1 to _Slo_ and _Shi_ .

16

<u>Published as a conference paper at ICLR 2017</u>

A.4 PROGRAM SET FOR QUICKSORT

|Program|Descriptions|Calls|Arguments|
|---|---|---|---|
|QUICKSORT<br>|Run<br>the<br>quicksort<br>routine in place for<br>the<br>array<br>_A_,<br>for<br>indices from_ lo_ to_ hi_<br><br><br>|**Non-Recursive**: PAR-<br>TITION,<br>STACK,<br>WRITE<br>**Recursive**:<br>same as<br>non-recursive version,<br>along<br>with<br>QUICK-<br>SORT<br>|Implicitly: array<br>_A_ to sort,_ lo_,_ hi_<br>|
|PARTITION<br>|Runs<br>the<br>partition<br>function.<br>At end,<br>pointer<br>_ppivot_<br>is<br>moved to the pivot<br>|COMPSWAP ~~L~~OOP,<br>MOVE ~~P~~IVOT ~~L~~O,<br>MOVE ~~J L~~O, SWAP<br>|NONE<br>|
|COMPSWAP ~~L~~OOP<br>|Runs the FOR loop<br>inside the partition<br>function<br>|COMPSWAP, MOVE<br>|NONE<br>|
|COMPSWAP<br>|Compares<br>_A_[_pivot_] _≤A_[_j_]; if<br>so, perform a swap<br>and increment_ ppivot_<br>|SWAP, MOVE<br>|NONE<br>|
|SET PIVOT ~~L~~O<br>|Sets _ppivot_ to _lo_ in-<br>dex<br>|NONE<br>|NONE<br>|
|SET J ~~L~~O<br>|Sets_ pj_ to_ lo_ index<br>|NONE<br>|NONE<br>|
|SET J ~~N~~ULL<br>|<br>Sets_ pj_ to_ −∞_<br>|NONE<br>|NONE<br>|
|STACK<br>|<br>Pushes _lo/hi_ states<br>onto stacks _Slo_ and<br>_Shi_<br>according<br>to<br>argument (described<br>below)<br>|WRITE, MOVE<br>|Described below<br>|
|MOVE<br>|Moves pointer one<br>unit up or down<br><br><br>|NONE<br>|Described below<br>|
|SWAP<br>|Swaps<br>elements<br>at<br>given array indices<br><br><br>|NONE<br>|Described below<br>|
|WRITE|Write<br>a<br>value<br>either<br>to<br>stack<br>(e.g.,<br>_QstackLo_<br>or<br>_QstackHi_)<br>or<br>to<br>pointer<br>(e.g.,<br>to<br>change the value of<br>_phi_)|NONE|Described below|

**Argument Sets for STACK, MOVE, SWAP, WRITE.**

**STACK.** The STACK operation has the following arguments:

_ARG_ _~~1~~_ (Operation): STACK ~~P~~ USH ~~C~~ ALL1, STACK ~~P~~ USH ~~C~~ ALL2, STACK ~~P~~ OP

STACK PUSH ~~C~~ ALL1 pushes _lo_ and _pivot_ _−_ 1 to _QstackLo_ and _QstackHi_ . STACK ~~P~~ USH ~~C~~ ALL2
pushes _pivot_ + 1 and _hi_ to _QstackLo_ and _QstackHi_ . STACK ~~P~~ OP pushes _−∞_ values to _QstackLo_
and _QstackHi_ .

**MOVE.** The MOVE operation has the following arguments:

_ARG_ _~~1~~_ (Pointer): _pstackLo_, _pstackHi_, _pj_, _ppivot_

Note that the argument is the identity of the pointer, not what the pointer points to; in other words,
_ARG_ _~~1~~_ can only take one of 4 values.

_ARG_ _~~2~~_ (Increment or Decrement): UP, DOWN

17

<u>Published as a conference paper at ICLR 2017</u>

**SWAP.** The SWAP operation has the following arguments:

_ARG_ _~~1~~_ (Swap Object 1): _ppivot_

_ARG_ _~~2~~_ (Swap Object 2): _phi, pj_

**WRITE.** The WRITE operation has the following arguments:

_ARG_ _~~1~~_ (Object to Write): ENV ~~S~~ TACK ~~L~~ O, ENV ~~S~~ TACK ~~H~~ I, _phi_, _plo_

ENV ~~S~~ TACK ~~L~~ O and ENV ~~S~~ TACK ~~H~~ I represent _QstackLo_ ( _pstackLo_ ) and _QstackHi_ ( _pstackHi_ ), respectively.

_ARG_ _~~2~~_ (Object to Copy): ENV ~~S~~ TACK ~~L~~ O ~~P~~ EEK, ENV ~~S~~ TACK ~~H~~ I ~~P~~ EEK, _phi_, _plo_, _ppivot_ _−_ 1,
_ppivot_ + 1, RESET

ENV ~~S~~ TACK ~~L~~ O ~~P~~ EEK and ENV ~~S~~ TACK ~~H~~ I ~~P~~ EEK represent _QstackLo_ ( _pstackLo_ _−_ 1) and
_QstackHi_ ( _pstackHi −_ 1), respectively. RESET represents a _−∞_ value.

Note that the argument is the identity of the pointer, not what the pointer points to; in other words,
_ARG_ _~~1~~_ can only take one of 4 values, and _ARG_ _~~2~~_ can only take one of 7 values.

A.5 TRACE-GENERATING FUNCTIONS FOR QUICKSORT

A.5.1 NON-RECURSIVE TRACE-GENERATING FUNCTIONS

1 Initialize _plo_ to 1 and _phi_ to _n_ (length of array)
2 Initialize _pj_ to _−∞_
3
4 QUICKSORT() {
657 whileifSTACK(STACK_POP)( _Q_ ( _pstackLostackLo_ ( _̸_ _p_ = _stackLo_ 1): _−_ 1) _<_ _QstackHi_ ( _pstackHi_ _−_ 1)):
8 else:
9 WRITE( _phi_, ENV_STACK_HI_PEEK)
10 WRITE( _plo_, ENV_STACK_LO_PEEK)
11 STACK(STACK_POP)
12 PARTITION()
13 STACK(STACK_PUSH_CALL2)
14 STACK(STACK_PUSH_CALL1)
15 }
16
17 PARTITION() {
18 SET_PIVOT_LO()
19 SET_J_LO()
20 COMPSWAP_LOOP()
21 SWAP( _ppivot, phi_ )
22 SET_J_NULL()
23 }
24
25 COMPSWAP_LOOP() {
2726 whileCOMPSWAP()( _pj̸_ = _phi_ ):
28 MOVE( _pj_, UP)
29 }
30
31 COMPSWAP() {
32 if ( _A_ [ _pj_ ] _≤_ _A_ [ _phi_ ]):
33 SWAP( _ppivot, pj_ )
34 MOVE( _ppivot_, UP)
35 }
36
37 STACK(op) {
38 if (op == STACK_PUSH_CALL1):
39 WRITE(ENV_STACK_LO, _plo_ )
4140 MOVE(WRITE(ENV_STACK_HI, _pstackLo_, UP) _ppivot_ _−_ 1)
42 MOVE( _pstackHi_, UP)
43
44 if (op == STACK_PUSH_CALL2):
45 WRITE(ENV_STACK_LO, _ppivot_ + 1)
46 WRITE(ENV_STACK_HI, _phi_ )
47 MOVE( _pstackLo_, UP)
48 MOVE( _pstackHi_, UP)
49
50 if (op == STACK_POP):
51 WRITE(ENV_STACK_LO, RESET)
52 WRITE(ENV_STACK_HI, RESET)
53 MOVE( _pstackLo_, DOWN)
54 MOVE( _pstackHi_, DOWN)
55 }

18

<u>Published as a conference paper at ICLR 2017</u>

A.5.2 RECURSIVE TRACE-GENERATING FUNCTIONS

Altered Recursive Functions

1 Initialize _plo_ to 1 and _phi_ to _n_ (length of array)
2 Initialize _pj_ to _−∞_
3
4 QUICKSORT() {
56 ifPARTITION()( _QstackLo_ ( _pstackLo_ _−_ 1) _<_ _QstackHi_ ( _pstackHi_ _−_ 1)):
7 STACK(STACK_PUSH_CALL2)
8 STACK(STACK_PUSH_CALL1)
9 WRITE( _phi_, ENV_STACK_HI_PEEK)
10 WRITE( _plo_, ENV_STACK_LO_PEEK)
11 QUICKSORT() // **Recursive** **Call**
12 STACK(STACK_POP)
13 WRITE( _phi_, ENV_STACK_HI_PEEK)
14 WRITE( _plo_, ENV_STACK_LO_PEEK)
15 QUICKSORT() // **Recursive** **Call**
16 STACK(STACK_POP)
17 }
18
19 COMPSWAP_LOOP() {
2021 ifCOMPSWAP()( _pj̸_ = _phi_ ):
22 MOVE( _pj_, UP)
23 COMPSWAP_LOOP() // **Recursive** **Call**
24 }

A.6 BASE CASES, REDUCTION RULES, AND VERIFICATION SETS

In this section, we describe the space of base cases and reduction rules that must be covered for each
of the four sample tasks, in order to create the verification set.

For addition, we analytically determine the verification set. For tasks other than addition, it is difficult to analytically determine the verification set, so instead, we randomly generate input candidates
until they completely cover the base cases and reduction rules.

**Base** **Cases** **and** **Reduction** **Rules** **for** **Addition.** For the recursive formulation of addition, we
analytically construct the set of input problems that cover all base cases and reduction rules. We
outline how to construct this set.

It is sufficient to construct problems where every transition between two adjacent columns is covered. The ADD reduction rule ensures that each call to ADD only covers two adjacent columns,
and so the LSTM only ever runs for a fixed number of steps necessary to process these two columns.

We construct input problems by splitting into two cases: one case in which the left column contains
a null value and another in which the left column does not contain any null values. We then construct
problem configurations that span all possible valid environment states (for instance, in order to force
the carry bit in a column to be 1, one can add the sum “1+9” in the column to the right).

The operations we need to be concerned most about are CARRY and LSHIFT, which induce _partial_
_environment_ _states_ spanning two columns. It is straightforward to deal with all other operations,
which do not induce partial environment states.

Under the assumption that there are no leading 0’s (except in the case of single digits) and the
two numbers to be added have the same number of digits, the verification set for addition contains
20,181 input problems. The assumption of leading 0’s can be easily removed, at the cost of slightly
increasing the size of the verification set. We made the assumption of equivalent lengths in order to
parametrize the input format with respect to length, but this assumption can be removed as well.

**Base** **Cases** **and** **Reduction** **Rules** **for** **Bubble** **Sort.** The original version of the bubblesort implementation exposes the values within the array. While this matches the description from Reed &
de Freitas (2016), we found that this causes an unnecessary blowup in the size of _V_ and makes it
much more difficult to construct the verification set. For purposes of verification, we replace the
domain-specific encoder with the following:

_fenc_ ( _Q, i_ 1 _, i_ 2 _, i_ 3 _, at_ ) = _MLP_ ([ _Q_ (1 _, i_ 1) _≤_ _Q_ (1 _, i_ 2) _,_ 1 _≤_ _i_ 1 _≤_ _length,_ 1 _≤_ _i_ 2 _≤_ _length,_

_i_ 3 == _length, at_ (1) _, at_ (2) _, at_ (3)]) _,_

19

<u>Published as a conference paper at ICLR 2017</u>

Table 4: Accuracy on Randomly Generated Problems for Variant of Bubble Sort

**<u>Length of Array</u>** **<u>Non-Recursive</u>** **<u>Recursive</u>**

2 100% 100%
3 100% 100%
4 100% 100%
5 100% 100%
6 90% 100%
7 86.7% 100%
8 6.7% 100%
9 0% 100%
10 0% 100%
12 0% 100%
15 0% 100%
70 0% 100%

which directly exposes which of the two values pointed to is larger. This modification also enables
us to sort arrays containing arbitrary comparable elements.

By reasoning about the possible set of environment observations created by all valid inputs, we
construct _V_ using the procedure described in Section 3.3. Using this modification, we constructed a
verification set consisting of one array of size 10.

We also report on generalization results for the non-recursive and recursive versions of this variant of
bubble sort. Table 4 demonstrates that the accuracy of the non-recursive program degrades sharply
when moving from arrays of length 7 to arrays of length 8. This is due to the properties of the training
set—we trained on 2 traces synthesized from arrays of length 7 and 1 trace synthesized from an array
of length 6. Table 4 also demonstrates that the (verified) recursive program generalizes perfectly.

**Base Cases and Reduction Rules for Topological Sort.** For each function we use to implement
the recursive version of topological sort, we need to consider the set of possible environment observation sequences we can create from all valid inputs and test that the learned program produces the
correct behavior on each of these inputs. We have three observations: the color of the start node, the
color of the active node’s next child to be considered, and whether the stack is empty. Na¨ıvely, we
might expect to synthesize and test an input for any sequence created by combining the four possible
colors in two variables and another boolean variable for whether the stack is empty (so 32 possible
observations at any point), but for various reasons, most of these combinations are impossible to
occur at any given point in the execution trace.

Through careful reasoning about the possible set of environment observations created by all valid
inputs, and how each of the operations in the execution trace affects the environment, we can construct _V_ using the procedure described in Section 3.3. We then construct a verification set of size 73
by ensuring that randomly generated graphs cover the analytically derived _V_ . The model described
in the training setup of Section 4 (trained on 6 traces) was verified to be correct via the matching
procedure described in Section 4.2.

**Base** **Cases** **and** **Reduction** **Rules** **for** **Quicksort.** As with the others, we apply the procedure
described in Section 3.3 to construct _V_ and then empirically create a verification set which covers
_V_ . The verification set can be very small, as we found a 10-element array ([8,2,1,2,0,8,5,8,3,7]) is
sufficient to cover all of _V_ . We note that an earlier version of quicksort we tried lacked primitive
operations to directly move a pointer to another, and therefore needed more functions and observations. As this complexity interfered with determining the base cases and reductions, we changed the
algorithm to its current form. Even though the earlier version also generalized just as well in practice, relatively small differences in the formulation of the traces and the environment observations
can drastically change the difficulty of verification.

20
