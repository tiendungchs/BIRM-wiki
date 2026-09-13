---
title: "A Model of Inductive Bias Learning"
source: "https://arxiv.org/abs/1106.0245"
created: 2026-09-13
tags:
  - "pdf2md"
---

# baxter-2000-model-of-inductive-bias-learning

> Converted from `baxter-2000-model-of-inductive-bias-learning.pdf` on 2026-09-13 via `pymupdf4llm`.
> Layout artefacts (broken equations, interleaved columns) are conversion noise, not the source.

---

Journal of Artificial Intelligence Research 12 (2000) 149–198 Submitted 11/99; published 3/00

# **A Model of Inductive Bias Learning**

**Jonathan Baxter** JONATHAN.BAXTER@ANU.EDU.AU

_Research School of Information Sciences and Engineering_

_Australian National University, Canberra 0200, Australia_

**Abstract**

A major problem in machine learning is that of inductive bias: how to choose a learner’s hypothesis space so that it is large enough to contain a solution to the problem being learnt, yet small
enough to ensure reliable generalization from reasonably-sized training sets. Typically such bias is
supplied by hand through the skill and insights of experts. In this paper a model for _automatically_
_learning_ bias is investigated. The central assumption of the model is that the learner is embedded
within an _environment_ of related learning tasks. Within such an environment the learner can sample
from multiple tasks, and hence it can search for a hypothesis space that contains good solutions to
many of the problems in the environment. Under certain restrictions on the set of all hypothesis
spaces available to the learner, we show that a hypothesis space that performs well on a sufficiently
large number of training tasks will also perform well when learning novel tasks in the same environment. Explicit bounds are also derived demonstrating that learning multiple tasks within an
environment of related tasks can potentially give much better generalization than learning a single
task.

**1.** **Introduction**

Often the hardest problem in any machine learning task is the initial choice of hypothesis space;
it has to be large enough to contain a solution to the problem at hand, yet small enough to ensure
good generalization from a small number of examples (Mitchell, 1991). Once a suitable bias has
been found, the actual learning task is often straightforward. Existing methods of bias generally
require the input of a human expert in the form of heuristics and domain knowledge (for example,
through the selection of an appropriate set of features). Despite their successes, such methods are
clearly limited by the accuracy and reliability of the expert’s knowledge and also by the extent to
which that knowledge can be transferred to the learner. Thus it is natural to search for methods for
_automatically learning_ the bias.

In this paper we introduce and analyze a formal model of _bias_ _learning_ that builds upon
the PAC model of machine learning and its variants (Vapnik, 1982; Valiant, 1984; Blumer,
Ehrenfeucht, Haussler, & Warmuth, 1989; Haussler, 1992). These models typically take the
following general form: the learner is supplied with a hypothesis space H and training data

z = f(x1 ; y1 ); : : : ; (xm ; ym )g drawn independently according to some underlying distribution P

on X - Y . Based on the information contained in z, the learner’s goal is to select a hypothesis

z = f(x

; y

); : : : ; (x

; y

1

1

m

m

h : X ! Y from H minimizing some measure er

h : X ! Y from H minimizing some measure erP (h) of expected loss with respect to P (for ex
ample, in the case of squared loss erP (h) := E ( x;y )�P ( h(x) - y )2 ). In such models the learner’s

bias is represented by the choice of H ; if H does not contain a good solution to the problem, then,
regardless of how much data the learner receives, it cannot learn.

Of course, the best way to bias the learner is to supply it with an H containing just a single optimal hypothesis. But finding such a hypothesis is precisely the original learning problem, so in the

P

(h) := E

( h(x) - y )

P

( x;y )�P

- c 2000 AI Access Foundation and Morgan Kaufmann Publishers. All rights reserved.

BAXTER

PAC model there is no distinction between bias learning and ordinary learning. Or put differently,
the PAC model does not model the process of inductive bias, it simply takes the hypothesis space H
as given and proceeds from there. To overcome this problem, in this paper we assume that instead
of being faced with just a single learning task, the learner is embedded within an _environment_ of
related learning tasks. The learner is supplied with a _family_ of hypothesis spaces H = fH g, and its
goal is to find a bias (i.e. hypothesis space H 2 H ) that is appropriate for the entire environment.
A simple example is the problem of handwritten character recognition. A preprocessing stage that
identifies and removes any (small) rotations, dilations and translations of an image of a character
will be advantageous for recognizing all characters. If the set of all individual character recognition
problems is viewed as an environment of learning problems (that is, the set of all problems of the
form “distinguish ‘A’ from all other characters”, “distinguish ‘B’ from all other characters”, and
so on), this preprocessor represents a bias that is appropriate for all problems in the environment.
It is likely that there are many other currently unknown biases that are also appropriate for this
environment. We would like to be able to learn these automatically.

There are many other examples of learning problems that can be viewed as belonging to environments of related problems. For example, each individual face recognition problem belongs to an
(essentially infinite) set of related learning problems (all the other individual face recognition problems); the set of all individual spoken word recognition problems forms another large environment,
as does the set of all fingerprint recognition problems, printed Chinese and Japanese character recognition problems, stock price prediction problems and so on. Even medical diagnostic and prognostic
problems, where a multitude of diseases are predicted from the same pathology tests, constitute an
environment of related learning problems.

In many cases these “environments” are not normally modeled as such; instead they are treated
as single, multiple category learning problems. For example, recognizing a group of faces would
normally be viewed as a single learning problem with multiple class labels (one for each face in
the group), not as multiple individual learning problems. However, if a reliable classifier for each
individual face in the group can be constructed then they can easily be combined to produce a
classifier for the whole group. Furthermore, by viewing the faces as an environment of related
learning problems, the results presented here show that bias can be learnt that will be good for
learning novel faces, a claim that cannot be made for the traditional approach.

This point goes to the heart of our model: we are not not concerned with adjusting a learner’s
bias so it performs better on some _fixed_ set of learning problems. Such a process is in fact just
ordinary learning but with a richer hypothesis space in which some components labelled “bias” are
also able to be varied. Instead, we suppose the learner is faced with a (potentially infinite) stream of
tasks, and that by adjusting its bias on some subset of the tasks it improves its learning performance
on future, as yet unseen tasks.

Bias that is appropriate for all problems in an environment must be learnt by sampling from
many tasks. If only a single task is learnt then the bias extracted is likely to be specific to that
task. In the rest of this paper, a general theory of bias learning is developed based upon the idea of
learning multiple related tasks. Loosely speaking (formal results are stated in Section 2), there are
two main conclusions of the theory presented here:

  - Learning multiple related tasks reduces the sampling burden required for good generalization,
at least on a number-of-examples-required-per-task basis.

150

A MODEL OF INDUCTIVE BIAS LEARNING

  - Bias that is learnt on sufficiently many training tasks is likely to be good for learning novel
tasks drawn from the same environment.

The second point shows that a form of _meta-generalization_ is possible in bias learning. Ordinarily, we say a learner generalizes well if, after seeing sufficiently many training examples, it
produces a hypothesis that with high probability will perform well on future examples of the same
task. However, a bias learner generalizes well if, after seeing sufficiently many training _tasks_ it produces a _hypothesis space_ that with high probability contains good solutions to novel tasks. Another
term that has been used for this process is _Learning to Learn_ (Thrun & Pratt, 1997).

Our main theorems are stated in an agnostic setting (that is, H does not necessarily contain a
hypothesis space with solutions to all the problems in the environment), but we also give improved
bounds in the realizable case. The sample complexity bounds appearing in these results are stated
in terms of combinatorial parameters related to the complexity of the set of all hypothesis spaces H
available to the bias learner. For Boolean learning problems (pattern classification) these parameters
are the bias learning analogue of the _Vapnik-Chervonenkis_ _dimension_ (Vapnik, 1982; Blumer et al.,
1989).
As an application of the general theory, the problem of learning an appropriate set of neuralnetwork features for an environment of related tasks is formulated as a bias learning problem. In
the case of continuous neural-network features we are able to prove upper bounds on the number
of training tasks and number of examples of each training task required to ensure a set of features
that works well for the training tasks will, with high probability, work well on novel tasks drawn
from the same environment. The upper bound on the number of tasks scales as O (b) where b is
a measure of the complexity of the possible feature sets available to the learner, while the upper
bound on the number of examples of each task scales as O (a + b=n) where O (a) is the number
of examples required to learn a task if the “true” set of features (that is, the correct bias) is already
known, and n is the number of tasks. Thus, in this case we see that as the number of related tasks
learnt increases, the number of examples required of each task for good generalization decays to
the minimum possible. For Boolean neural-network feature maps we are able to show a matching
lower bound on the number of examples required per task of the same form.

**1.1** **Related Work**

There is a large body of previous algorithmic and experimental work in the machine learning and
statistics literature addressing the problems of inductive bias learning and improving generalization
through multiple task learning. Some of these approaches can be seen as special cases of, or at least
closely aligned with, the model described here, while others are more orthogonal. Without being
completely exhaustive, in this section we present an overview of the main contributions. See Thrun
and Pratt (1997, chapter 1) for a more comprehensive treatment.

- **Hierarchical Bayes.** The earliest approaches to bias learning come from Hierarchical Bayesian
methods in statistics (Berger, 1985; Good, 1980; Gelman, Carlin, Stern, & Rubim, 1995).
In contrast to the Bayesian methodology, the present paper takes an essentially empirical
process approach to modeling the problem of bias learning. However, a model using a mixture
of hierarchical Bayesian and information-theoretic ideas was presented in Baxter (1997a),
with similar conclusions to those found here. An empirical study showing the utility of the
hierarchical Bayes approach in a domain containing a large number of related tasks was given
in Heskes (1998).

151

BAXTER

- **Early machine learning work.** In Rendell, Seshu, and Tcheng (1987) “VBMS” or _Variable Bias_
_Management System_ was introduced as a mechanism for selecting amongst different learning
algorithms when tackling a new learning problem. “STABB” or _Shift_ _To_ _a_ _Better_ _Bias_ (Utgoff, 1986) was another early scheme for adjusting bias, but unlike VBMS, STABB was not
primarily focussed on searching for bias applicable to large problem domains. Our use of an
“environment of related tasks” in this paper may also be interpreted as an “environment of
analogous tasks” in the sense that conclusions about one task can be arrived at by analogy
with (sufficiently many of) the other tasks. For an early discussion of analogy in this context, see Russell (1989, S4.3), in particular the observation that for analogous problems the
sampling burden _per task_ can be reduced.

- **Metric-based approaches.** The metric used in nearest-neighbour classification, and in vector
quantization to determine the nearest code-book vector, represents a form of inductive bias.
Using the model of the present paper, and under some extra assumptions on the tasks in
the environment (specifically, that their marginal input-space distributions are identical and
they only differ in the conditional probabilities they assign to class labels), it can be shown
that there is an _optimal_ metric or distance measure to use for vector quantization and onenearest-neighbour classification (Baxter, 1995a, 1997b; Baxter & Bartlett, 1998). This metric
can be learnt by sampling from a subset of tasks from the environment, and then used as a
distance measure when learning novel tasks drawn from the same environment. Bounds on
the number of tasks and examples of each task required to ensure good performance on novel
tasks were given in Baxter and Bartlett (1998), along with an experiment in which a metric
was successfully trained on examples of a subset of 400 Japanese characters and then used as
a fixed distance measure when learning 2600 as yet unseen characters.

A similar approach is described in Thrun and Mitchell (1995), Thrun (1996), in which a
neural network’s output was trained to match labels on a novel task, while simultaneously
being forced to match its gradient to _derivative_ information generated from a distance metric
trained on previous, related tasks. Performance on the novel tasks improved substantially
with the use of the derivative information.

Note that there are many other adaptive metric techniques used in machine learning, but these
all focus exclusively on adjusting the metric for a fixed set of problems rather than learning a
metric suitable for learning novel, related tasks (bias learning).

- **Feature learning or learning internal representations.** As with adaptive metric techniques,
there are many approaches to feature learning that focus on adapting features for a fixed task
rather than learning features to be used in novel tasks. One of the few cases where features
have been learnt on a subset of tasks with the explicit aim of using them on novel tasks was
Intrator and Edelman (1996) in which a low-dimensional representation was learnt for a set
of multiple related image-recognition tasks and then used to successfully learn novel tasks of
the same kind. The experiments reported in Baxter (1995a, chapter 4) and Baxter (1995b),
Baxter and Bartlett (1998) are also of this nature.

- **Bias learning in Inductive Logic Programming (ILP).** Predicate invention refers to the process in ILP whereby new predicates thought to be useful for the classification task at hand
are added to the learner’s domain knowledge. By using the new predicates as background domain knowledge when learning novel tasks, predicate invention may be viewed as a form of

152

A MODEL OF INDUCTIVE BIAS LEARNING

inductive bias learning. Preliminary results with this approach on a chess domain are reported
in Khan, Muggleton, and Parson (1998).

- **Improving performance on a fixed reference task.** “Multi-task learning” (Caruana, 1997)
trains extra neural network outputs to match related tasks in order to improve generalization
performance on a fixed reference task. Although this approach does not explicitly identify the
extra bias generated by the related tasks in a way that can be used to learn novel tasks, it is
an example of exploiting the bias provided by a set of related tasks to improve generalization
performance. Other similar approaches include Suddarth and Kergosien (1990), Suddarth and
Holden (1991), Abu-Mostafa (1993).

- **Bias as computational complexity.** In this paper we consider inductive bias from a samplecomplexity perspective: how does the learnt bias decrease the number of examples required of
novel tasks for good generalization? A natural alternative line of enquiry is how the runningtime or computational complexity of a learning algorithm may be improved by training on
related tasks. Some early algorithms for neural networks in this vein are contained in Sharkey
and Sharkey (1993), Pratt (1992).

- **Reinforcement Learning.** Many control tasks can appropriately be viewed as elements of sets
of related tasks, such as learning to navigate to different goal states, or learning a set of
complex motor control tasks. A number of papers in the reinforcement learning literature
have proposed algorithms for both sharing the information in related tasks to improve average
generalization performance across those tasks Singh (1992), Ring (1995), or learning bias
from a set of tasks to improve performance on future tasks Sutton (1992), Thrun and Schwartz
(1995).

**1.2** **Overview of the Paper**

In Section 2 the bias learning model is formally defined, and the main sample complexity results
are given showing the utility of learning multiple related tasks and the feasibility of bias learning.
These results show that the sample complexity is controlled by the size of certain covering numbers
associated with the set of all hypothesis spaces available to the bias learner, in much the same way
as the sample complexity in learning Boolean functions is controlled by the _Vapnik-Chervonenkis_
dimension (Vapnik, 1982; Blumer et al., 1989). The results of Section 2 are upper bounds on
the sample complexity required for good generalization when learning multiple tasks and learning
inductive bias.

The general results of Section 2 are specialized to the case of feature learning with neural networks in Section 3, where an algorithm for training features by gradient descent is also presented.
For this special case we are able to show matching lower bounds for the sample complexity of
multiple task learning. In Section 4 we present some concluding remarks and directions for future
research. Many of the proofs are quite lengthy and have been moved to the appendices so as not to
interrupt the flow of the main text.

The following tables contain a glossary of the mathematical symbols used in the paper.

153

BAXTER

Symbol Description First Referenced

X Input Space 155

Y Output Space 155

P Distribution on X - Y (learning task) 155

l Loss function 155

H Hypothesis Space 155

h Hypothesis 155

erP (h) Error of hypothesis h on distribution P 156

z Training set 156

A Learning Algorithm 156

er^ z (h) Empirical error of h on training set z 156

P Set of all learning tasks P 157

Q Distribution over learning tasks 157

H Family of hypothesis spaces 157

erQ (H ) Loss of hypothesis space H on environment Q 158

z (n; m) -sample 158

er^ z (H ) Empirical loss of H on z 158

A Bias learning algorithm 159

hl Function induced by h and l 159

Hl Set of hl 159

; : : : ; hn;l 159

(h

; : : : ; hn

)

l Average of h1;l

1

l Same as (h1

l Same as (h

h

; : : : ; h

)l 159

n

n

l Set of (h

n

H

H

H

H

160

; : : : ; h

n )l 159

1

n

l Set of H

n

n

l 159

n

 Function on probability distributions 160

Set of H

P Pseudo-metric on H

Q Pseudo-metric on H

n

d

d

n

l 160

160

160

 

N ("; H

    

C ("; H

N ("; H

; d

; dP

) Covering number of H

Q

) Capacity of H

160

n

l 160

) Covering number of H

n

l 160

C ("; H

n

l

n

l

) Capacity of H

h Sequence of n hypotheses (h1 ;

h Sequence of n hypotheses (h

; : : : ; h

n ) 163

P Sequence of n distributions (P1

; : : : ; Pn

) 163

(h) Average loss of h on P 164

(h) Average loss of h on z 164

erP

er^ z

F Set of feature maps 166

G Output class composed with feature maps f 166

G Æ f Hypothesis space associated with f 166

Gl Loss function class associated with G 166

N ("; Gl

; d

) Covering number of Gl 166

P

l 166

C ( "; Gl

) Capacity of G

0
166

0

d

(f ; f

0

) Pseudo-metric on feature maps f ; f

[P ;Gl ℄

N ("; F ; d[P ;G

℄ ) Covering number of F 166

154

℄

l

A MODEL OF INDUCTIVE BIAS LEARNING

Symbol Description First Referenced

N ("; F ; d[P ;G

℄ ) Covering number of F 166

C

l

("; F ) Capacity of F 166

Gl

w Neural network hypothesis space 167

H

H

(m) Growth function of H 172

jx

H restricted to vector x 172

H

VCdim(H ) Vapnik-Chervonenkis dimension of H 172

H

H

H (n; m) Growth function of H 173

(n) Dimension function of H 173

jx

jx

H restricted to matrix x 173

H restricted to matrix x 173

H

H (

d

d( H ) Upper dimension function of H 173

d( H ) Lower dimension function of H 173

n on P 175

n

) Optimal performance of H

optP

( H

- Metric on R

d

+
179

n 179

h

- - - - - h

1 <sup>,</sup> : : :, h

1

H1

n Average of h

n Set of h1

n Set of h

- - - - - hn 180

- - - - - H

(2m;n) Permutations on integer pairs 182

- Permuted z 182

z� Permuted z 182

1 <sup>metric on functions</sup> h 182

) Empirical l

d

0

(h; h

z

er^ P

(H ) Optimal average error of H on P 185

**2.** **The Bias Learning Model**

In this section the bias learning model is formally introduced. To motivate the definitions, we first
describe the main features of ordinary (single-task) supervised learning models.

**2.1** **Single-Task Learning**

Computational learning theory models of supervised learning usually include the following ingredients:

  - An _input space_ X and an _output space_ Y,

  - a _probability distribution_ P on X  - Y,

  - a _loss function_ l : Y  - Y ! R, and

  - a _hypothesis space_ H which is a set of _hypotheses_ or functions h : X ! Y .

As an example, if the problem is to learn to recognize images of Mary’s face using a neural network,
then X would be the set of all images (typically represented as a subset of R d where each component

then X would be the set of all images (typically represented as a subset of R d where each component

is a pixel intensity), Y would be the set f0; 1g, and the distribution P would be peaked over images
of different faces and the correct class labels. The learner’s hypothesis space H would be a class of
neural networks mapping the input space R d to f0; 1g . The loss in this case would be discrete loss:

d to f0; 1g . The loss in this case would be discrete loss:

0

l (y ; y ) :=

1 if y 6= y

0 if y = y

155

0

0 (1)

BAXTER

Using the loss function allows us to present a unified treatment of both pattern recognition ( Y =

f0; 1g, l as above), and real-valued function learning ( _e.g._ regression) in which Y = R and usually

0 0

; y ) = (y - y )2 .

The goal of the learner is to select a hypothesis h 2 H with minimum _expected loss_ :

0

0

l (y ; y

) = (y - y

)

erP

(h) :=

Z

X �Y

l (h(x); y ) dP (x; y ): (2)

Of course, the learner does not know P and so it cannot search through H for an h minimizing

erP (h) . In practice, the learner samples repeatedly from X - Y according to the distribution P to

generate a _training set_

er

P

z := f(x

; y

); : : : ; (x

; y

m )g: (3)

1

1

m

Based on the information contained in z the learner produces a hypothesis h 2 H . Hence, in general
a learner is simply a map A from the set of all training samples to the hypothesis space H :

[

m

A :

(X - Y )

! H

m>0

(stochastic learner’s can be treated by assuming a distribution-valued A .)
Many algorithms seek to minimize the _empirical_ loss of h on z, where this is defined by:

m

X

er^ z

(h) :=

1

m

l (h(xi

); y

i

): (4)

i=1

Of course, there are more intelligent things to do with the data than simply minimizing empirical
error—for example one can add regularisation terms to avoid over-fitting.

However the learner chooses its hypothesis h, if we have a _uniform_ bound (over all h 2 H ) on
the probability of large deviation between er^ z (h) and erP (h), then we can bound the learner’s gen
eralization error erP (h) as a function of its empirical loss on the training set er^ z (h) . Whether such

a bound holds depends upon the “richness” of H . The conditions ensuring convergence between

er^ z (h) and erP (h) are by now well understood; for Boolean function learning ( Y = f0; 1g, discrete

loss), convergence is controlled by the _VC-dimension_ <sup>1</sup> of H :

(h) and er

z

P

P

(h) as a function of its empirical loss on the training set er^

z

er^

(h) and er

z

P

**Theorem 1.** _Let_ P _be_ _any_ _probability_ _distribution_ _on_ X - f0; 1g _and_ _suppose_ z =

f(x1

; y1

); : : : ; (xm

; ym

)g _is generated_ _by sampling_ m _times from_ X - f0; 1g _according_ _to_ P _._ _Let_

d := VCdim(H ) _._ _Then_ _with_ _probability_ _at_ _least_ 1 - Æ _(over_ _the_ _choice_ _of_ _the_ _training_ _set_ z _),_ **all**

h 2 H _will satisfy_

��1=2

(5)

4

Æ

2em

d

+ log

erP

(h) - er^

z (h) +

32

m

d log

Proofs of this result may be found in Vapnik (1982), Blumer et al. (1989), and will not be
reproduced here.

1. The VC dimension of a class of Boolean functions H is the largest integer d such that there exists a subset S :=

d Boolean functions on S .

fx1

; : : : ; xd g - X such that the restriction of H to S contains all 2

156

A MODEL OF INDUCTIVE BIAS LEARNING

Theorem 1 only provides conditions under which the deviation between erP (h) and er^ z (h) is

likely to be small, it does not guarantee that the true error erP (h) will actually be small. This is

governed by the choice of H . If H contains a solution with small error and the learner minimizes
error on the training set, then with high probability erP (h) will be small. However, a bad choice of

H will mean there is no hope of achieving small error. Thus, the _bias_ of the learner in this model <sup>2</sup>

is represented by the choice of hypothesis space H .

**2.2** **The Bias Learning Model**

The main extra assumption of the bias learning model introduced here is that the learner is embedded in an _environment_ of related tasks, and can sample from the environment to generate multiple
training sets belonging to multiple different tasks. In the above model of ordinary (single-task)
learning, a learning task is represented by a distribution P on X - Y . So in the bias learning
model, an environment of learning problems is represented by a pair (P ; Q) where P is the set of
all probability distributions on X - Y (i.e., P is the set of all possible learning problems), and Q is a
distribution on P . Q controls which learning problems the learner is likely to see <sup>3</sup> . For example, if
the learner is in a face recognition environment, Q will be highly peaked over face-recognition-type
problems, whereas if the learner is in a character recognition environment Q will be peaked over
character-recognition-type problems (here, as in the introduction, we view these environments as
sets of individual classification problems, rather than single, multiple class classification problems).

Recall from the last paragraph of the previous section that the learner’s bias is represented by its
choice of hypothesis space H . So to enable the learner to learn the bias, we supply it with a _family_
or set of hypothesis spaces H := fH g .

Putting all this together, formally a _learning to learn_ or _bias learning_ problem consists of:

  - an _input space_ X and an _output space_ Y (both of which are separable metric spaces),

  - a _loss function_ l : Y  - Y ! R,

  - an _environment_ (P ; Q) where P is the set of all probability distributions on X  - Y and Q is
a distribution on P,

  - a _hypothesis space family_ H = fH g where each H 2 H is a set of functions h : X ! Y .

From now on we will assume the loss function l has range [0; 1℄, or equivalently, with rescaling,
we assume that l is bounded.

2. The bias is also governed by how the learner uses the hypothesis space. For example, under some circumstances the
learner may choose not to use the full power of H (a neural network example is early-stopping). For simplicity in
this paper we abstract away from such features of the algorithm A and assume that it uses the entire hypothesis space

H .
3. Q ’s domain is a  - -algebra of subsets of P . A suitable one for our purposes is the Borel  - -algebra B (P ) generated
by the topology of weak convergence on P . If we assume that X and Y are separable metric spaces, then P is also
a separable metric space in the Prohorov metric (which metrizes the topology of weak convergence) (Parthasarathy,
1967), so there is no problem with the existence of measures on B (P ) . See Appendix D for further discussion,
particularly the proof of part 5 in Lemma 32.

157

Theorem 1 only provides conditions under which the deviation between er

P

(h) and er^

z

P

P

(h) will be small. However, a bad choice of

BAXTER

We define the goal of a bias learner to be to find a hypothesis space H 2 H minimizing the
following loss:

Z

er

Z

inf

h2H

inf

h2H

erP

Q

(H ) :=

Z

=

P

(h) dQ(P ) (6)

l (h(x); y ) dP (x; y ) dQ(P ):

P

X �Y

The only way erQ (H ) can be small is if, with high Q -probability, H contains a good solution h to

any problem P drawn at random according to Q . In this sense erQ (H ) measures how appropriate

The only way er

Q

any problem P drawn at random according to Q . In this sense erQ (H ) measures how appropriate

the bias embodied by H is for the environment (P ; Q) .
In general the learner will not know Q, so it will not be able to find an H minimizing erQ (H )

directly. However, the learner can sample from the environment in the following way:

Q

Q

- Sample n times from P according to Q to yield:

P1

; : : : ; P

n <sup>.</sup>

- Sample m times from X - Y according to each Pi <sup>to yield:</sup>

zi

= f(xi1

; yi1

) : : : ; (xim

; yim )g .

- The resulting n training sets—henceforth called an (n; m) _-sample_ if they are generated by the
above process—are supplied to the learner. In the sequel, an (n; m) -sample will be denoted
by z and written as a matrix:

(x11

; y

11

) - - - (x

; y

) = z

1m

1m

z := ... ... ... ...

1

n

(7)

(x

; y

) - - - (xnm

; y

nm

) = z

n1

n1

An (n; m) -sample is simply n training sets z1

n <sup>sampled</sup> <sup>from</sup> n different learning tasks

; : : : ; z

P1 ; : : : ; Pn <sup>, where each</sup> <sup>task is selected</sup> <sup>according</sup> <sup>to the environmental</sup> <sup>probability</sup> <sup>distribution</sup> Q .

The size of each training set is kept the same primarily to facilitate the analysis.

P

; : : : ; P

1

Based on the information contained in z, the learner must choose a hypothesis space H 2 H .
One way to do this would be for the learner to find an H minimizing the _empirical loss_ on z, where
this is defined by:

n

X

er^ z

(h) (8)

er^ z (H ) :=

1

n

i=1

inf

h2H

i

Note that er^ z (H ) is simply the average of the best possible empirical error achievable on each

training set zi <sup>,</sup> <sup>using</sup> <sup>a</sup> <sup>function</sup> <sup>from</sup> H . It is a biased estimate of erQ (H ) . An unbiased esti

Note that er^

z

training set zi <sup>,</sup> <sup>using</sup> <sup>a</sup> <sup>function</sup> <sup>from</sup> H . It is a biased estimate of erQ (H ) . An unbiased esti
mate of erQ (H ) would require choosing an H with minimal average error over the n distributions

i <sup>,</sup> <sup>using</sup> <sup>a</sup> <sup>function</sup> <sup>from</sup> H . It is a biased estimate of er

Q

(H ) would require choosing an H with minimal average error over the n distributions

Q

P

1

n

n

P

; : : : ; P

inf

er

1

1 n

: As with ordinary learning, it is likely there are more intelligent things to do with the training data : : ; Pn <sup>, where this is defined by</sup> n i=1 inf h2H erPi (h) .

n <sup>, where this is defined by</sup>

h2H

P

i

i=1

z than minimizing (8). Denoting the set of all (n; m) -samples by ( X - Y )(n;m), a general “bias

learner” is a map A that takes (n; m) -samples as input and produces hypothesis spaces H 2 H as
output:

(n;m)

! H : (9)

A :

[

n>0

m>0

(X - Y )

158

A MODEL OF INDUCTIVE BIAS LEARNING

(as stated, A is a deterministic bias learner, however it is trivial to extend our results to stochastic
learners).

Note that in this paper we are concerned only with the sample complexity properties of a bias
learner A ; we do not discuss issues of the computability of A .
Since A is searching for entire hypothesis spaces H within a family of such hypothesis spaces

H, there is an extra representational question in our model of bias learning that is not present in
ordinary learning, and that is how the family H is represented and searched by A . We defer this
discussion until Section 2.5, after the main sample complexity results for this model of bias learning
have been introduced. For the specific case of learning a set of features suitable for an environment
of related learning problems, see Section 3.

Regardless of how the learner chooses its hypothesis space H, if we have a uniform bound (over
all H 2 H ) on the probability of large deviation between er^ z (H ) and erQ (H ), and we can compute

an upper bound on er^ z (H ), then we can bound the bias learner’s “generalization error” erQ (H ) .

With this view, the question of generalization within our bias learning model becomes: how many
tasks ( n ) and how many examples of each task ( m ) are required to ensure that er^ z (H ) and erQ (H )

are close with high probability, uniformly over all H 2 H ? Or, informally, how many tasks and how
many examples of each task are required to ensure that a hypothesis space with good solutions to
all the training tasks will contain good solutions to novel tasks drawn from the same environment?

It turns out that this kind of uniform convergence for bias learning is controlled by the “size”
of certain function classes derived from the hypothesis space family H, in much the same way as
the VC-dimension of a hypothesis space H controls uniform convergence in the case of Boolean
function learning (Theorem 1). These “size” measures and other auxiliary definitions needed to
state the main theorem are introduced in the following subsection.

**2.3** **Covering Numbers**

z

(H ) and er

Q

z

(H ), then we can bound the bias learner’s “generalization error” er

Q

(H ) and er

z

Q

**Definition 1.** _For any hypothesis_ h : X ! Y _, define_ hl : X - Y ! [0; 1℄ _by_

hl

(x; y ) := l (h(x); y ) (10)

_For any hypothesis space_ H _in the hypothesis space family_ H _, define_

Hl := fhl

: h 2 H g: (11)

_For any sequence of_ n _hypotheses_ (h

; : : : ; hn

n

1 X

! [0; 1℄ _by_

1 ; : : : ; h

n

)l

n

: (X - Y )

) _, define_ (h1

(xi

); y

i

): (12)

(h1

; : : : ; h

n

)l

(x1

; y

1

n )

; : : : ; x

) :=

l (hi

n

; yn

n

(h
l <sup>_to denote_</sup>

_We will also use_ h

; : : : ; h

i=1

l <sup>_._</sup> <sup>_For any_</sup> H _in the hypothesis space family_ H _, define_

1

n

Hl

:= f(h1

; : : : ; h

n

n

)l

; : : : ; h

n

: h1

2 H g: (13)

_Define_

: (14)

[

H2 H

n

Hl

H

:=

l

159

BAXTER

In the first part of the definition above, hypotheses h : X ! Y are turned into functions hl

l
mapping X - Y ! [0; 1℄ by composition with the loss function. Hl <sup>is then just the collection of all</sup>

such functions where the original hypotheses come from H . Hl <sup>is often called a</sup> <sup>_loss-function class_</sup> <sup>.</sup>

In our case we are interested in the average loss across n tasks, where each of the n hypotheses

n

is chosen from a fixed hypothesis space H . This motivates the definition of hl <sup>and</sup> Hl <sup>.</sup> <sup>Finally,</sup>

n

H l <sup>is the</sup> <sup>collection</sup> <sup>of all</sup> (h1 ; : : : ; hn )l <sup>,</sup> <sup>with</sup> <sup>the restriction</sup> <sup>that all</sup> h1 ; : : : ; hn <sup>belong</sup> <sup>to a single</sup>

hypothesis space H 2 H .

H
l <sup>and</sup>

n

l <sup>.</sup> <sup>Finally,</sup>

n

n

(h
l <sup>is the</sup> <sup>collection</sup> <sup>of all</sup>

n

H

; : : : ; h

)

; : : : ; h

1

n

l <sup>,</sup> <sup>with</sup> <sup>the restriction</sup> <sup>that all</sup> h

1

                      
**Definition 2.** _For each_ H 2 H _, define_ H

                     

: P ! [0; 1℄ _by_

 

H

(P ) := inf

h2H

erP

(h): (15)

_For the hypothesis space family_ H _, define_

                     

H

:= fH

: H 2 H g: (16)

- that controls how large the (n; m) -sample z must be to ensure

It is the “size” of H

n

H
l <sup>and</sup>

er^ z (H ) and erQ (H ) are close uniformly over all H 2 H . Their size will be defined in terms of

certain covering numbers, and for this we need to define how to measure the distance between

n

elements of H l <sup>and also between elements of</sup> H - .

er^

(H ) and er

z

Q

n

H
l <sup>and also between elements of</sup>

- .

n

**Definition 3.** _Let_ P = (P

**Definition 3.** _Let_ P = (P1 ; : : : ; Pn ) _be any sequence of_ n _probability distributions_ _on_ X - Y _._ _For_

0 n

_any_ hl ; h 2 H l <sup>_, define_</sup>

; : : : ; P

1

n

n

n

l <sup>_, define_</sup>

; h

2 H

l

0

l

(17)

Z

(X �Y )

dP

; y

n

) - h

)

(x

; y

; : : : ; xn

; y

n

)j

dP

(h

l

) :=

jhl

(x

1

; : : : ; xn

0

l

1

1

0

; hl

1

n

(x

; y

) : : : dP

; y

; y

1

1

1

n

n

2 H

- _, define_

                          
_Similarly, for any distribution_ Q _on_ P _and any_ H

; H2

(xn

  

2

1

1 (

    

dQ (H1

  

; H2 ) :=

Z

P

jH

(P ) - H

(P )j dQ(P ) (18)

d
P <sup>and</sup>

n

H
l <sup>and</sup>

- respectively.

It is easily verified that d

H
Q <sup>are pseudo-metrics4</sup> <sup>on</sup>

**Definition 4.** _An_ " _-cover_ _of_ ( H

; : : : ; H

N

g _such_ _that_ _for_ _all_ H

; d

) _is_ _a_ _set_ fH

2 H

- _,_

Q

 

1

   

dQ (H

  

; H

i

                                   
) - " _for_ _some_ i = 1 : : : N _._ _Note_ _that_ _we_ _do_ _not_ _require_ _the_ Hi <sup>_to_</sup> <sup>_be_</sup> <sup>_contained_</sup> <sup>_in_</sup>

                                
H - _, just that they be measurable_ _functions_ _on_ P _._ _Let_ N ("; H ; dQ ) _denote_ _the size of the smallest_

_such cover._ _Define the_ capacity _of_ H - _by_

- _, just that they be measurable_ _functions_ _on_ P _._ _Let_ N ("; H

H

; d

Q

- _by_

 

) (19)

C ("; H

) := sup

Q

N ("; H

; dQ )

_where_ _the_ _supremum_ _is_ _over_ _all_ _probability_ _measures_ _on_ P _._ N ("; H

n

_where_ _the_ _supremum_ _is_ _over_ _all_ _probability_ _measures_ _on_ P _._ N ("; H l ; dP ) _is_ _defined_ _in_ _a_ _similar_

n

_way, using_ dP <sup>_in place of_</sup> dQ <sup>_._</sup> <sup>_Define the_</sup> <sup>capacity</sup> <sup>_of_</sup> H l <sup>_by:_</sup>

n

; d

P

l

Q <sup>_._</sup> <sup>_Define the_</sup> <sup>capacity</sup> <sup>_of_</sup> H

n

l <sup>_by:_</sup>

d
P <sup>_in place of_</sup>

n

n

l

) (20)

C ("; H

) := sup

P

N ("; H

n

l

; d

P

_where now the supremum is over all sequences of_ n _probability measures on_ X - Y _._

4. A pseudo-metric d is a metric without the condition that d(x; y ) = 0 ) x = y .

160

A MODEL OF INDUCTIVE BIAS LEARNING

**2.4** **Uniform Convergence for Bias Learners**

Now we have enough machinery to state the main theorem. In the theorem the hypothesis space
family is required to be _permissible_ . Permissibility is discussed in detail in Appendix D, but note
that it is a weak measure-theoretic condition satisfied by almost all “real-world” hypothesis space
families. All logarithms are to base e .

**Theorem 2.** _Suppose_ X _and_ Y _are_ _separable_ _metric_ _spaces_ _and_ _let_ Q _be_ _any_ _probability_ _distri-_
_bution_ _on_ P _,_ _the_ _set_ _of_ _all_ _distributions_ _on_ X - Y _._ _Suppose_ z _is_ _an_ (n; m) _-sample_ _generated_ _by_
_sampling_ n _times from_ P _according to_ Q _to give_ P1 ; : : : ; Pn <sup>_, and then sampling_</sup> m _times from each_

Pi <sup>_to generate_</sup> zi = f(xi1 ; yi1 ); : : : ; (xim ; yim )g _,_ i = 1; : : : ; n _._ _Let_ H = fH g _be any_ _permissible_

_hypothesis space family._ _If the number of tasks_ n _satisfies_

; : : : ; P

1

n <sup>_, and then sampling_</sup> m _times from each_

P

i <sup>_to generate_</sup> zi

= f(x

; y

); : : : ; (x

; y

i

i1

i1

im

im

(

)

 

64

;

2

"

 

64

;

2

"

8C

; H

; (21)

; (22)

n - max

256

2

"

log

_and the number of examples_ m _of each task satisfies_

           

256 8C (

"

32

Æ

"

;

32

Æ

; H

 

n

)

l

m - max

log

2

n"

_then with probability at least_ 1 - Æ _(over the_ (n; m) _-sample_ z _), all_ H 2 H _will satisfy_

erQ

(H ) - er^ z

(H ) + " (23)

_Proof._ See Appendix A.

There are several important points to note about Theorem 2:

                 - n

Provided the capacities C ("; H ) and C ("; H l ) are finite, the theorem shows that _any_ bias

learner that selects hypothesis spaces from H can bound its generalisation error erQ (H ) in

terms of er^ z (H ) for sufficiently large (n; m) -samples z . Most bias learner’s will not find the

exact value of er^ z (H ) because it involves finding the smallest error of any hypothesis h 2 H

on each of the n training sets in z . But any upper bound on er^ z (H ) (found, for example

by gradient descent on some error function) will still give an upper bound on er Q (H ) . See

Section 3.3.1 for a brief discussion on how this can be achieved in a feature learning setting.

1. Provided the capacities C ("; H

) and C ("; H

n

l

Q

z

z

z

Q

2. In order to learn bias (in the sense that er

(H ) and er^ z

(H ) and er^

(H ) are close uniformly over all

Q

H 2 H ), both the number of tasks n and the number of examples of each task m must
be sufficiently large. This is intuitively reasonable because the bias learner must see both
sufficiently many tasks to be confident of the nature of the environment, and sufficiently
many examples of each task to be confident of the nature of each task.

3. Once the learner has found an H 2 H with a small value of er^

Once the learner has found an H 2 H with a small value of er^ z (H ), it can then use H to

learn novel tasks P drawn according to Q . One then has the following theorem bounding the
sample complexity required for good generalisation when learning with H (the proof is very
similar to the proof of the bound on m in Theorem 2).

z

161

BAXTER

**Theorem 3.** _Let_ z = f(x1

; y1

); : : : ; (xm

; y

m

)g _be a training set generated by sampling from_

X - Y _according_ _to some distribution_ P _._ _Let_ H _be a permissible_ _hypothesis_ _space._ _For all_

"; Æ _with_ 0 < "; Æ < 1 _, if the number of training examples_ m _satisfies_

(

)

16

2

"

(24)

;

4C

"

16

Æ

; Hl

m - max

64

2

"

log

_then with probability at least_ 1 - Æ _, all_ h 2 H _will satisfy_

erP

(h) - er^

z

(h) + ":

The capacity C ("; H ) appearing in equation (24) is defined in an analogous R fashion to the

0

capacities in Definition 4 (we just use the pseudo-metric dP (hl ; hl ) := X �Y jhl (x; y ) 

0

h amples required for good generalisation l (x; y )j dP (x; y ) ). The important thingwhen learning novel tasks is proportionalto note about Theorem 3 is that the numberto the log-of ex
arithm of the capacity of the learnt hypothesis space H . In contrast, if the learner does not
do any bias learning, it will have no reason to select one hypothesis space H 2 H over any
other and consequently it would have to view as a candidate solution any hypothesis in any
of the hypothesis spaces H 2 H . Thus, its sample complexity will be proportional to the

1

capacity of [H2 H fHl g = H l <sup>, which in general will be considerably larger than the capacity</sup>

R

(h

; h

) :=

jh

(x; y ) 

P

l

0

l

l

X �Y

0

l

h

1

capacity of [H2 H fHl g = H l <sup>, which in general will be considerably larger than the capacity</sup>

of any individual H 2 H . So by learning H the learner has _learnt to learn_ in the environment

1

fH

g = H

H2 H

l

(P ; Q) in the sense that it needs far smaller training sets to learn novel tasks.

4. Having learnt a hypothesis space H with a small value of er^

Having learnt a hypothesis space H with a small value of er^ z (H ), Theorem 2 tells us that

with probability at least 1 - Æ, the expected value of inf h2H erP (h) on a novel task P will be

less than er^ z (H ) + " . Of course, this does not rule out really bad performance on some tasks

P . However, the probability of generating such “bad” tasks can be bounded. In particular,
note that erQ (H ) is just the expected value of the function H - over P, and so by Markov’s

inequality, for - - 0,

z

er

h2H

P

z

(H ) + " . Of course, this does not rule out really bad performance on some tasks

Q

(H ) is just the expected value of the function H

Pr

P : inf

h2H

er

(h) - 

= Pr fP : H

     

(P ) - - g

P

E

H

=

Q

 

er

(H )

Q

 

er^ z

(H ) + "

(with probability 1      - Æ ).

 

5. Keeping the accuracy and confidence parameters "; Æ fixed, note that the number of examples
required of each task for good generalisation obeys

: (25)

 

)

m = O

1

n

log C ( "; H

n

l

So provided log C ("; H

n

l

n

Soexamplesprovidedrequired log C ( of "; H each l ) increasestask will _decrease_ sublinearlyas withthe number n, the upperof tasksboundincreases.on theThisnumbershowsof

that for suitably constructed hypothesis space families it is possible to _share_ information
between tasks. This is discussed further after Theorem 4 below.

162

A MODEL OF INDUCTIVE BIAS LEARNING

**2.5** **Choosing the Hypothesis Space Family** H **.**

Theorem 2 only provides conditions under which er^ z (H ) and erQ (H ) are close, it does not guaran
tee that erQ (H ) is actually small. This is governed by the choice of H . If H contains a hypothesis

Theorem 2 only provides conditions under which er^

z

(H ) and er

Q

tee that erQ (H ) is actually small. This is governed by the choice of H . If H contains a hypothesis

space H with a small value of erQ (H ) and the learner is able to find an H 2 H minimizing error on

the (n; m) sample z (i.e., minimizing er^ z (H ) ), then, for sufficiently large n and m, Theorem 2 en
sures that with high probability erQ (H ) will be small. However, a bad choice of H will mean there

is no hope of finding an H with small error. In this sense the choice of H represents the _hyper-bias_
of the learner.

Note that from a sample complexity point of view, the _optimal_ hypothesis space family to choose
is one containing a single, minimal hypothesis space H that contains good solutions to all of the
problems in the environment (or at least a set of problems with high Q -probability), and no more.
For then there is no bias learning to do (because there is no choice to be made between hypothesis
spaces), the output of the bias learning algorithm is guaranteed to be a good hypothesis space for
the environment, and since the hypothesis space is minimal, learning any problem within the environment using H will require the smallest possible number of examples. However, this scenario
is analagous to the trivial scenario in ordinary learning in which the learning algorithm contains a
single, optimal hypothesis for the problem being learnt. In that case there is no learning to be done,
just as there is no bias learning to be done if the correct hypothesis space is already known.

At the other extreme, if H contains a single hypothesis space H consisting of all possible functions from X ! Y then bias learning is impossible because the bias learner cannot produce a
restricted hypothesis space as output, and hence cannot produce a hypothesis space with improved
sample complexity requirements on as yet unseen tasks.

Focussing on these two extremes highlights the minimal requirements on H for successful bias
learning to occur: the hypothesis spaces H 2 H must be strictly smaller than the space of all
functions X ! Y, but not so small or so “skewed” that none of them contain good solutions to a
large majority of the problems in the environment.

It may seem that we have simply replaced the problem of selecting the right bias (i.e., selecting
the right hypothesis space H ) with the equally difficult problem of selecting the right hyper-bias (i.e.,
the right hypothesis space family H ). However, in many cases selecting the right hyper-bias is far
easier than selecting the right bias. For example, in Section 3 we will see how the feature selection
problem may be viewed as a bias selection problem. Selecting the right features can be extremely
difficult if one knows little about the environment, with intelligent trial-and-error typically the best
one can do. However, in a bias learning scenario, one only has to specify that a set of features should
exist, find a loosely parameterised set of features (for example neural networks), and then learn the
features by sampling from multiple related tasks.

**2.6** **Learning Multiple Tasks**

Q

Q

z

Q

It may be that the learner is not interested in learning to learn, but just wants to learn a fixed set
of n tasks from the environment (P ; Q) . As in the previous section, we assume the learner starts
out with a hypothesis space family H, and also that it receives an (n; m) -sample z generated from
the n distributions P1 ; : : : ; Pn <sup>.</sup> <sup>This time, however,</sup> <sup>the learner</sup> <sup>is simply looking</sup> <sup>for</sup> n hypotheses

(h1 ; : : : ; hn ), all contained in the same hypothesis space H, such that the average generalization

error of the n hypotheses is minimal. Denoting (h1 ; : : : ; hn ) by h and writing P = (P1 ; : : : ; Pn ),

; : : : ; P

1

n <sup>.</sup> <sup>This time, however,</sup> <sup>the learner</sup> <sup>is simply looking</sup> <sup>for</sup> n hypotheses

(h

; : : : ; h

1

n

; : : : ; h

; : : : ; P

1

n

) by h and writing P = (P

1

n

),

163

BAXTER

this error is given by:

i ) (26)

erP (h) :=

=

1

n

1

n

n

X

i=1

erPi

(h

l (hi

(x); y ) dPi

i

n Z

X

X �Y

i=1

n

(x; y );

and the empirical loss of h on z is

(hi ) (27)

er^ z

(h) :=

=

1

n

X

i=1

n

er^ z

l (hi

i (xij

i

m

X

j =1

1

n

X 1

m

i=1

); y

ij

):

As before, regardless of how the learner chooses (h

As before, regardless of how the learner chooses (h1 ; : : : ; hn ), if we can prove a uniform bound on

the probability of large deviation between er^ z (h) and erP (h) then any (h1 ; : : : ; hn ) that perform

well on the training sets z will with high probability perform well on future examples of the same
tasks.

; : : : ; h

1

n

(h) and er

(h) then any (h

; : : : ; h

z

P

1

n

**Theorem 4.** _Let_ P = (P

**Theorem 4.** _Let_ P = (P1 ; : : : ; Pn ) _be_ n _probability distributions on_ X - Y _and let_ z _be an_ (n; m) _-_

_sample_ _generated_ _by_ _sampling_ m _times_ _from_ X - Y _according_ _to each_ Pi <sup>_._</sup> <sup>_Let_</sup> H = fH g _be_ _any_

_permissible hypothesis space family._ _If the number of examples_ m _of each task satisfies_

; : : : ; P

1

n

 

162 (28)

"

n

)

l

;

4C (

; H

"

16

Æ

m - max

64

2

n"

log

_then with probability at least_ 1 - Æ _(over the choice of_ z _), any_ h 2 H

n _will satisfy_

erP

(h) - er^ z

(h) + " (29)

_(recall Definition 4 for the meaning of_ C ("; H

n

l ) _)._

_Proof._ Omitted (follow the proof of the bound on m in Theorem 2).

The bound on m in Theorem 4 is virtually identical to the bound on m in Theorem 2, and note
again that it depends _inversely_ on the number of tasks n (assuming that the first part of the “max”

" n

expression is the dominate one).a function of n . The following Lemma shows that this growth is always small enough to ensure thatWhether this helps depends on the rate of growth of C ( 16 ; H l ) as

we never do worse by learning multiple tasks (at least in terms of the upper bound on the number of
examples required per task).

"

16

; H

n

l

**Lemma 5.** _For any hypothesis space family_ H _,_

1

l

- C ( "; H

1

l

�n

"; H

: (30)

C

"; H

n

l ) - C

164

A MODEL OF INDUCTIVE BIAS LEARNING

_Proof._ Let K denote the set of all functions (h

_Proof._ Let K denote the set of all functions (h1 ; : : : ; hn )l <sup>where each</sup> hi <sup>can</sup> <sup>be</sup> <sup>a member</sup> <sup>of any</sup>

n n

hypothesis space H 2 H (recall Definition - 1). - Then H l - K and so C ( "; H l ) - C ("; K ) . By

1

Lemma 29 in Appendix B, C ( "; K ) - C "; H n and so the right hand inequality follows.

; : : : ; h

)

n

- K and so C ( "; H

n

1

n

h
l <sup>where each</sup>

H 2 H     - C ( "; H )     - C ("; K

                  -                  - l l

1

Lemma 29 in Appendix B, C ( "; K ) - C "; H l n and so the right hand inequality follows.

For the first inequality, let P be any probability measure on X  - Y and let P be the measure on (X - Y )n obtained by using P on the first copy of X - Y in the product, and ignoring

l

l

"; H

1

l

sure on (X - Y )n obtained by using P on the first copy of X - Y in the product, and ignoring

n 1

all other elements of the product. Let N be an " -cover for ( H l ; dP ) . Pick any hl 2 H l <sup>and</sup>

let (g1 ; : : : ; gn )l 2 N be such that dP ((h; h; : : : ; h)l ; (g1 ; : : : ; gn )l ) - " . But by construction,

n

1

; d

) . Pick any hl

2 H

P

l

l

; : : : ; g

)

((h; h; : : : ; h)

; (g

; : : : ; g

)

1

n

l

l

n

l

2 N be such that d

P

1

) - " . But by construction,

dP

((h; h; : : : ; h)l

; (g1

; : : : ; g

n

)l

) = d

(h; (g

), which establishes the first inequality.

1

)l

By Lemma 5

P

1

l

: (31)

log C

"; H

1

l

- log C ("; H

n

l

) - n log C

"; H

So keeping the accuracy parameters " and Æ fixed, and plugging (31) into (28), we see that the upper
bound on the number of examples required of each task never _increases_ with the number of tasks,
and at best decreases as O (1=n) . Although only an upper bound, this provides a strong hint that
learning multiple related tasks should be advantageous on a “number of examples required per task”
basis. In Section 3 it will be shown that for feature learning all types of behavior are possible, from
no advantage at all to O (1=n) decrease.

**2.7** **Dependence on** "

In Theorems 2, 3 and 4 the bounds on sample complexity all scale as 1="2 . This behavior can be

improved to 1=" if the empirical loss is always guaranteed to be zero (i.e., we are in the realizable
case). The same behavior results if we are interested in relative deviation between empirical and
true loss, rather than absolute deviation. Formal theorems along these lines are stated in Appendix
A.3.

**3.** **Feature Learning**

The use of restricted feature sets is nearly ubiquitous as a method of encoding bias in many areas of
machine learning and statistics, including classification, regression and density estimation.

In this section we show how the problem of choosing a set of features for an environment of

                                          - n

are calculated for general feature classes in Section 3.2.related tasks can be recast as a bias learning problem. ExplicitThese bounds are applied to the problem ofbounds on C ( H ; ") and C ( H l ; ")
learning a neural network feature set in Section 3.3.

n

l

; ") and C ( H

**3.1** **The Feature Learning Model**

Consider the following quote from Vapnik (1996):

The classical approach to estimating multidimensional functional dependencies is
based on the following belief:

Real-life problems are such that there exists a small number of “strong features,” simple
functions of which (say linear combinations) approximate well the unknown function.
Therefore, it is necessary to carefully choose a low-dimensional feature space and then
to use regular statistical techniques to construct an approximation.

165

BAXTER

In general a set of “strong features” may be viewed as a function f : X ! V mapping the input
space X into some (typically lower) dimensional space V . Let F = ff g be a set of such feature
maps (each f may be viewed as a set of features (f1 ; : : : ; fk ) if V = R k ). It is the f that must be

“carefully chosen” in the above quote. In general, the “simple functions of the features” may be
represented as a class of functions G mapping V to Y . If for each f 2 F we define the hypothesis
space G Æ f := fg Æ f : g 2 G g, then we have the hypothesis space family H

; : : : ; f

1

k

) if V = R

H := fG Æ f : f 2 F g: (32)

Now the problem of “carefully choosing” the right features f is equivalent to the bias learning
problem “find the right hypothesis space H 2 H ”. Hence, provided the learner is embedded within

                             - n

an environment of related tasks, and the capacitiesus that the feature set f can be _learnt_ rather than C carefully ( H ; ") andchosen. C ( H l ; This ") are finite, Theorem 2 tellsrepresents an important

simplification, as choosing a set of features is often the most difficult part of any machine learning
problem.

                            - n

The theorem is specialized to neural network classes in Section 3.3.In Section 3.2 we give a theorem bounding C ( H ; ") and C ( H l ; ") for general feature classes.

Note that we have forced the function class G to be the same for all feature maps f, although
this is not necessary. Indeed variants of the results to follow can be obtained if G is allowed to vary
with f .

**3.2** **Capacity Bounds for General Feature Classes**

Notationally it is easier to view the feature maps f as mapping from X - Y to V - Y by (x; y ) 7!

(f (x); y ), and also to absorb the loss function l into the definition of G by viewing each g 2 G as a
map from V - Y into [0; 1℄ via (v ; y ) 7! l (g (v ); y ) . Previously this latter function would have been
denoted gl <sup>but in what follows we will drop the subscript</sup> l where this does not cause confusion. The

class to which gl <sup>belongs will still be denoted by</sup> Gl <sup>.</sup>

With the above definitions let Gl Æ F := fg Æ f : g 2 Gl ; f 2 F g . Define the capacity of Gl <sup>in</sup>

the usual way,

n

l

; ") and C ( H

n

;

l

In Section 3.2 we give a theorem bounding C ( H

; ") and C ( H

class to which gl <sup>belongs will still be denoted by</sup> Gl <sup>.</sup>

With the above definitions let Gl Æ F := fg Æ f

G
l <sup>belongs will still be denoted by</sup>

Æ F := fg Æ f : g 2 G

l

l

; f 2 F g . Define the capacity of G

C ("; Gl

) := sup

P

N ("; Gl

; dP

)

where the supremum is over all probability measures on V - Y, and dP

0

(g ; g

) :=

R

V �Y

jg (v ; y ) 

0

g (v ; y )j dP (v ; y ) . To define the capacity of F we first define a pseudo-metric d[P ;Gl ℄ <sup>on</sup> F by

“pulling back” the L1 metric on R through Gl <sup>as follows:</sup>

0

(v ; y )j dP (v ; y ) . To define the capacity of F we first define a pseudo-metric d

0

g

1 metric on R through G

[P ;G

l

l <sup>as follows:</sup>

sup

g 2Gl

Z

X �Y

0

0

(x; y )j dP (x; y ): (33)

d

0

(f ; f ) :=

jg Æ f (x; y ) - g Æ f

[P ;Gl ℄

It is easily verified that d[P ;Gl ℄ <sup>is a pseudo-metric.</sup> <sup>Note that for</sup> d[P ;Gl ℄ <sup>to be well defined the supre-</sup>

mum over Gl <sup>in the integrand must be measurable.</sup> <sup>This is guaranteed if the hypothesis space family</sup>

It is easily verified that d

[P ;G

℄ <sup>is a pseudo-metric.</sup> <sup>Note that for</sup> d

[P ;G

l

l

l <sup>in the integrand must be measurable.</sup> <sup>This is guaranteed if the hypothesis space family</sup>

H = fGl Æ f : f 2 F g is permissible (Lemma 32, part 4). Now define N ("; F ; d[P ;Gl ℄ ) to be the

smallest " -cover of the pseudo-metric space (F ; d[P ;G ℄ ) and the " -capacity of F (with respect to Gl <sup>)</sup>

l ℄

H = fG

l

Æ f : f 2 F g is permissible (Lemma 32, part 4). Now define N ("; F ; d

[P ;G

smallestas " -cover of the pseudo-metric space (F ; d[P ;Gl ℄ ) and the " -capacity of F (with respect to Gl <sup>)</sup>

[P ;G

℄ ) and the " -capacity of F (with respect to G

℄

l

CG

("; F ) := sup

P

N ("; F ; d[P ;G

℄ )

l

l

where the supremum is over all probability measures on X - Y . Now we can state the main theorem
of this section.

166

A MODEL OF INDUCTIVE BIAS LEARNING

**Theorem 6.** _Let_ H _be a hypothesis space family as in equation_ (32) _._ _Then for all_ "; "1

; "2

- 0 _with_

" = "1

+ "2 <sup>_,_</sup>

C

C ("; H

C ("; H

n

l

) - C ( "

) - CGl

; Gl

n

)

Gl

("2

1

; F ) (34)

( "; F ) (35)

_Proof._ See Appendix B.

**3.3** **Learning Neural Network Features**

In general, a set of features may be viewed as a map from the (typically high-dimensional) input
space R d to a much smaller dimensional space R k ( k - d ). In this section we consider approximat

space R d to a much smaller dimensional space R k ( k - d ). In this section we consider approximat
ing such a feature map by a one-hidden-layer neural network with d input nodes and k output nodes
(Figure 1). We denote the set of all such feature maps by f�w = (�w ;1 ; : : : ; �w ;k ) : w 2 D g where

D is a bounded subset of R W ( W is the number of weights (parameters) in the first two layers).

This set is the F of the previous section.

d

Each feature �w ;i : R ! [0; 1℄, i = 1; : : : ; k is defined by

d to a much smaller dimensional space R

= (�

; : : : ; 

) : w 2 D g where

w

w ;1

w ;k

D is a bounded subset of R

d

! [0; 1℄, i = 1; : : : ; k is defined by

: R

w ;i

0

(x) := 

l

X

j =1

v

h

(x) + v

1

A
(36)

w ;i

ij

j

il +1

where hj

(x) is the output of the j th node in the first hidden layer, (v

where hj (x) is the output of the j th node in the first hidden layer, (vi1 ; : : : ; vil +1 ) are the output

node parameters for the i th feature and - is a “sigmoid” squashing function - : R ! [0; 1℄ . Each

d

first layer hidden node hi : R ! R, i = 1; : : : ; l, computes

; : : : ; v

j

i1

il +1

d

! R, i = 1; : : : ; l, computes

: R

i

0

xj

+ uid+1

1

A
(37)

hi (x) := 

d

X

j =1

u

ij

where (ui1 ; : : : ; uid+1 ) are the hidden node’s parameters. We assume - is Lipschitz. <sup>5</sup> The weight

vector for the entire feature map is thus

where (u

; : : : ; u

i1

id+1

w = (u11

; : : : ; u

1d+1

; : : : ; u

; : : : ; u

; v11

; : : : ; v

1l +1

; : : : ; v

; : : : ; v

)

l 1

l d+1

k 1

k l +1

and the total number of feature parameters W = l (d + 1) + k (l + 1) .
For argument’s sake, assume the “simple functions” of the features (the class G of the previous
section) are squashed affine maps using the same sigmoid function - above (in keeping with the
“neural network” flavor of the features). Thus, each setting of the feature weights w generates a
hypothesis space:

k

X

i=1

)

; (38)

Hw

:=

(

 

�w ;i

!

+ �k +1

: (�

1

; : : : ; 

0

) 2 D

i

k +1

0 is a bounded subset of R

where D

k
+1 . The set of all such hypothesis spaces,

H := fHw

: w 2 D g (39)

0

5. - is Lipschitz if there exists a constant K such that j� (x) - - (x

167

2 R .

0

)j - K jx - x

0 0

j for all x; x

BAXTER

**Multiple Output Classes**

**Input**

Figure 1: Neural network for feature learning. The feature map is implemented by the first two

hidden layers. The n output nodes correspond to the n different tasks in the (n; m)     sample z . Each node in the network computes a squashed linear function of the nodes in
the previous layer.

is a hypothesis space family. The restrictions on the output layer weights (�1 ; : : : ; �k +1 ) and feature

weights w, and the restriction to a Lipschitz squashing function are needed to obtain finite upper
bounds on the covering numbers in Theorem 2.

is a hypothesis space family. The restrictions on the output layer weights (�

; : : : ; 

1

k +1

Finding a good set of features for the environment (P ; Q) is equivalent to finding a good hypothesis space Hw 2 H, which in turn means finding a good set of feature map parameters w .

As in Theorem 2, the correct set of features may be learnt by finding a hypothesis space with
small error on a sufficiently large (n; m) -sample z . Specializing to squared loss, in the present
framework the empirical loss of Hw <sup>on</sup> z (equation (8)) is given by

w

w <sup>on</sup> z (equation (8)) is given by

"

!

#

- yij

(40)

2

n

X

i=1

m

X

j =1

er^ z

(Hw

) =

1

n

)2D

k

X

l =1

�l

l �w ;l

(xij

) + �0

0

1

m

(�0

;�

1

inf

;:::;�

k

Since our sigmoid function - only has range [0; 1℄, we also restrict the outputs Y to this range.

3.3.1 ALGORITHMS FOR FINDING A GOOD SET OF FEATURES

Provided the squashing function - is differentiable, gradient descent (with a small variation on
backpropagation to compute the derivatives) can be used to find feature weights w minimizing (40)
(or at least a local minimum of (40)). The only extra difficulty over and above ordinary gradient
descent is the appearance of “ inf ” in the definition of er^ z (Hw ) . The solution is to perform gradient

descent over both the output parameters (�0 ; : : : ; �k ) for each node and the feature weights w . For

more details see Baxter (1995b) and Baxter (1995a, chapter 4), where empirical results supporting
the theoretical results presented here are also given.

(H

z

w

; : : : ; 

0

k

168

A MODEL OF INDUCTIVE BIAS LEARNING

3.3.2 SAMPLE COMPLEXITY BOUNDS FOR NEURAL-NETWORK FEATURE LEARNING

The size of z ensuring that the resulting features will be good for learning novel tasks from the same
environment is given by Theorem 2. All we have to do is compute the logarithm of the covering

n        
numbers C ("; H ) and C ("; H ) .

) .

n

) and C ("; H

l

        
**Theorem 7.** _Let_ H =

Hw

Hw : w 2 R

(

k

X

:= 

i=1

i

W

_be a hypothesis space family where each_ Hw <sup>_is of the form_</sup>

!

)

k

; : : : ; 

k ) 2 R

;

- 

(�) + 

w ;i

0

: (�1

_where_ 

_where_ �w = (�w ;1 ; : : : ; �w ;k ) _is a neural_ _network with_ W _weights mapping_ _from_ R d _to_ R k _._ _If the_

_feature_ _weights_ w _and the output_ _weights_ �0 ; �1 ; : : : ; �k <sup>_are bounded,_</sup> <sup>_the squashing_</sup> <sup>_function_</sup> - _is_

_Lipschitz,_ l _is squared loss, and the output space_ Y = [0; 1℄ _(any bounded subset of_ R _will do), then_
_there exist constants_ �; �0 _(independent of_ "; W _and_ k _) such that for all_ " - 0 _,_

d _to_ R

= (�

; : : : ; 

) _is a neural_ _network with_ W _weights mapping_ _from_ R

w

w ;1

w ;k

; 

; : : : ; 

0

1

0 _(independent of_ "; W _and_ k _) such that for all_ " - 0 _,_

n

l

 

log C ("; H

log C ("; H

) - 2 ( (k + 1)n + W ) log

0

) - 2W log

- (41)

"

- (42)

"

_(recall that we have specialized to squared loss here)._

_Proof._ See Appendix B.

Noting that our neural network hypothesis space family H is permissible, plugging (41) and (42)
into Theorem 2 gives the following theorem.

**Theorem 8.** _Let_ H = fH

**Theorem 8.** _Let_ H = fHw g _be_ _a_ _hypothesis_ _space_ _family_ _where_ _each_ _hypothesis_ _space_ Hw <sup>_is_</sup> <sup>_a_</sup>

_set_ _of_ _squashed_ _linear_ _maps_ _composed_ _with a_ _neural_ _network_ _feature_ _map,_ _as_ _above._ _Suppose_ _the_
_number of features is_ k _, and the total number of feature weights is W. Assume all feature weights and_
_output weights are bounded,_ _and the squashing_ _function_ - _is Lipschitz._ _Let_ z _be an_ (n; m) _-sample_
_generated from the environment_ (P ; Q) _._ _If_

w

g _be_ _a_ _hypothesis_ _space_ _family_ _where_ _each_ _hypothesis_ _space_ H

  

n - O

1

2

"

W log

W

1

"

+ log

1

log

"

��

1

Æ

1

+

n

; (43)

_and_

��

n

��

(44)

m - O

1

2

"

k + 1 +

1

Æ

log

_then with probability at least_ 1 - Æ _any_ H

w

2 H _will satisfy_

erQ

(H

w

) - er^ z

169

(H

w

) + ": (45)

BAXTER

3.3.3 DISCUSSION

1. Keeping the accuracy and confidence parameters " and Æ fixed, the upper bound on the number
of examples required of each task behaves like O (k + W =n) . If the learner is simply learning

n fixed tasks (rather than learning to learn), then the same upper bound also applies (recall
Theorem 4).

2. Note that if we do away with the feature map altogether then W = 0 and the upper bound on

m becomes O (k ), independent of n (apart from the less important Æ term). So in terms of the
upper bound, learning n tasks becomes just as hard as learning one task. At the other extreme,
if we fix the output weights then effectively k = 0 and the number of examples required of
each task decreases as O (W =n) . Thus a range of behavior in the number of examples required
of each task is possible: from no improvement at all to an O (1=n) decrease as the number of
tasks n increases (recall the discussion at the end of Section 2.6).

3. Once the feature map is learnt (which can be achieved using the techniques outlined in Baxter,
1995b; Baxter & Bartlett, 1998; Baxter, 1995a, chapter 4), only the output weights have to be
estimated to learn a novel task. Again keeping the accuracy parameters fixed, this requires no
more that O (k ) examples. Thus, as the number of tasks learnt increases, the upper bound on
the number of examples required of each task decays to the minimum possible, O (k ) .

4. If the “small number of strong features” assumption is correct, then k will be small. However,
typically we will have very little idea of what the features are, so to be confident that the neural
network is capable of implementing a good feature set it will need to be very large, implying

W  - k . O (k + W =n) decreases most rapidly with increasing n when W  - k, so at least in
terms of the upper bound on the number of examples required per task, learning small feature
sets is an ideal application for bias learning. However, the upper bound on the number of
tasks does not fare so well as it scales as O (W ) .

3.3.4 COMPARISON WITH TRADITIONAL MULTIPLE-CLASS CLASSIFICATION

A special case of this multi-task framework is one in which the marginal distribution on the input
space PijX <sup>is the same for each task</sup> i = 1; : : : ; n, and all that varies between tasks is the conditional

distribution over the output space Y . An example would be a multi-class problem such as face
recognition, in which Y = f1; : : : ; ng where n is the number of faces to be recognized and the
marginal distribution on X is simply the “natural” distribution over images of those faces. In that
case, if for every example xij <sup>we have—in addition to the sample</sup> yij <sup>from the</sup> i th task’s conditional

distribution on Y —samples from the remaining n - 1 conditional distributions on Y, then we can
view the n training sets containing m examples each as one large training set for the multi-class
problem with mn examples altogether. The bound on m in Theorem 8 states that mn should be

O (nk + W ), or proportional to the total number of parameters in the network, a result we would
expect from <sup>6</sup> (Haussler, 1992).

So when specialized to the traditional multiple-class, single task framework, Theorem 8 is consistent with the bounds already known. However, as we have already argued, problems such as face
recognition are not really single-task, multiple-class problems. They are more appropriately viewed

6. If each example can be classified with a “large margin” then naive parameter counting can be improved upon (Bartlett,
1998).

170

A MODEL OF INDUCTIVE BIAS LEARNING

as a (potentially infinite) collection of distinct binary classification problems. In that case, the goal
of bias learning is not to find a single n -output network that can classify some subset of n faces
well. It is to learn a set of features that can reliably be used as a fixed preprocessing for distinguishing any single face from other faces. This is the new thing provided by Theorem 8: it tells us that
provided we have trained our n -output neural network on sufficiently many examples of _sufficiently_
_many tasks_, we can be confident that the common feature map learnt for those n tasks will be good
for learning _any_ new, as yet unseen task, provided the new task is drawn from the same distribution
that generated the training tasks. In addition, learning the new task only requires estimating the k
output node parameters for that task, a vastly easier problem than estimating the parameters of the
entire network, from both a sample and computational complexity perspective. Also, since we have
high confidence that the learnt features will be good for learning novel tasks drawn from the same
environment, those features are themselves a candidate for further study to learn more about the
nature of the environment. The same claim could not be made if the features had been learnt on too
small a set of tasks to guarantee generalization to novel tasks, for then it is likely that the features
would implement idiosyncrasies specific to those tasks, rather than “invariances” that apply across
all tasks.

When viewed from a bias (or feature) learning perspective, rather than a traditional n -class
classification perspective, the bound m on the number of examples required of each task takes on
a somewhat different meaning. It tells us that provided n is large (i.e., we are collecting examples
of a large number tasks), then we really only need to collect a few more examples than we would
otherwise have to collect if the feature map was already known ( k + W =n examples vs. k examples).
So it tells us that the burden imposed by feature learning can be made negligibly small, at least when
viewed from the perspective of the sampling burden required of each task.

**3.4** **Learning Multiple Tasks with Boolean Feature Maps**

Ignoring the accuracy and confidence parameters " and Æ, Theorem 8 shows that the number of
examples required of each task when learning n tasks with a common neural-network feature map
is bounded above by O (k + W =n), where k is the number of features and W is the number of
adjustable parameters in the feature map. Since O (k ) examples are required to learn a single task
once the true features are known, this shows that the upper bound on the number of examples
required of each task decays (in order) to the minimum possible as the number of tasks n increases.
This suggests that learning multiple tasks is advantageous, but to be truly convincing we need to
prove a lower bound of the same form. Proving lower bounds in a real-valued setting ( Y = R )
is complicated by the fact that a single example can convey an infinite amount of information, so
one typically has to make extra assumptions, such as that the targets y 2 Y are corrupted by a
noise process. Rather than concern ourselves with such complications, in this section we restrict
our attention to Boolean hypothesis space families (meaning each hypothesis h 2 H 1 maps to

Y = f�1g and we measure error by discrete loss l (h(x); y ) = 1 if h(x) 6= y and l (h(x); y ) = 0
otherwise).

We show that the sample complexity for learning n tasks with a Boolean hypothesis space family

H is controlled by a “VC dimension” type parameter d H (n) (that is, we give nearly matching upper

and lower bounds involving d H (n) ). We then derive bounds on d H (n) for the hypothesis space

H is controlled by a “VC dimension” type parameter d

H

and lower bounds involving d H (n) ). We then derive bounds on d H (n) for the hypothesis space

family considered in the previous section with the Lipschitz sigmoid function - replaced by a hard
threshold (linear threshold networks).

H

(n) ). We then derive bounds on d

H

171

BAXTER

As well as the bound on the number of examples required per task for good generalization across
those tasks, Theorem 8 also shows that features performing well on O (W ) _tasks_ will generalize well
to novel tasks, where W is the number of parameters in the feature map. Given that for many feature
learning problems W is likely to be quite large (recall Note 4 in Section 3.3.3), it would be useful
to know that O (W ) tasks are in fact _necessary_ without further restrictions on the environmental
distributions Q generating the tasks. Unfortunately, we have not yet been able to show such a lower
bound.

There is some empirical evidence suggesting that in practice the upper bound on the number of
tasks may be very weak. For example, in Baxter and Bartlett (1998) we reported experiments in
which a set of neural network features learnt on a subset of only 400 Japanese characters turned out
to be good enough for classifying some 2600 unseen characters, even though the features contained
several hundred thousand parameters. Similar results may be found in Intrator and Edelman (1996)
and in the experiments reported in Thrun (1996) and Thrun and Pratt (1997, chapter 8). While
this gap between experiment and theory may be just another example of the looseness inherent in
general bounds, it may also be that the analysis can be tightened. In particular, the bound on the
number of tasks is insensitive to the size of the class of output functions (the class G in Section 3.1),
which may be where the looseness has arisen.

3.4.1 UPPER AND LOWER BOUNDS FOR LEARNING n TASKS WITH BOOLEAN HYPOTHESIS
SPACE FAMILIES

First we recall some concepts from the theory of Boolean function learning. Let H be a class of
Boolean functions on X and x = (x1 ; : : : ; xm ) 2 X m . Hjx <sup>is the set of all binary vectors obtainable</sup>

by applying functions in H to x :

; : : : ; x

) 2 X

m . H

1

m

H

:= f(h(x1

); : : : ; h(x

m

)) : h 2 H g:

Clearly jHjx

m . If jHjx

jx

j = 2m we say H _shatters_ x . The _growth function_ of H is defined by

j - 2

:

�H

(m) := max

x2X m

 

�H

jx

The _Vapnik-Chervonenkis_ _dimension_ VCdim(H ) is the size of the largest set shattered by H :

m

VCdim(H ) := maxfm : 

(m) = 2

g:

H

An important result in the theory of learning Boolean functions is Sauer’s Lemma (Sauer, 1972), of
which we will also make use.

**Lemma 9 (Sauer’s Lemma).** _For a Boolean function class_ H _with_ VCdim(H ) = d _,_

 

m

i

d

em

d

;

(m) 

H

d

X

i=0

_for all positive integers_ m _._

We now generalize these concepts to learning n tasks with a Boolean hypothesis space family.

172

A MODEL OF INDUCTIVE BIAS LEARNING

**Definition 5.** _Let_ H _be_ _a_ _Boolean_ _hypothesis_ _space_ _family._ _Denote_ _the_ n - m _matrices_ _over_ _the_
_input_ _space_ X _by_ X (n;m) _._ _For each_ x 2 X (n;m) _and_ H 2 H _,_ _define_ Hjx <sup>_to be_</sup> <sup>_the set_</sup> <sup>_of (binary)_</sup>

_matrices,_

(n;m) _and_ H 2 H _,_ _define_ H

(n;m) _._ _For each_ x 2 X

h1

hn

(x

x _..._ 11 ) - _..._ - - h1 (x _..._ 1m )

n1

) - - - h

(x

11

1

1m

Hjx

:=

82

<

6

4

:

: h

; : : : ; h

:

2 H

9

=

;

:

n

(x

1 ) - - - hn

(xnm

)

3

7

5

:

 

 

_Define_

_Now for each_ n - 0; m - 0 _, define_ 

         - H

H

:=

[

H2 H

Hjx :

1

jx

H

(n; m) _by_

(n; m) := max

x2X (n;m)

H

jx

 

 

_Note that_ - H

_Define_

**Lemma 10.**

H

d ( H ) - d( H )

nm _._ _If_

d

(n) := maxfm : 

= 2nm _we say_ H **shatters** _the matrix_ x _._ _For each_ n - 0 _let_

nm

(n; m) - 2

H jx

(n; m) = 2

H

d( H ) : = VCdim( H

1

) _and_

g:

d( H ) : = max

H2 H

VCdim(H ):

��

  

; d( H )

��

d( H )

n

  

+ d ( H )

d H

(n) - max

d ( H )

n

1

2

_Proof._ The first inequality is trivial from the definitions. To get the second term in the maximum
in the second inequality, choose an H 2 H with VCdim(H ) = d( H ) and construct a matrix

x 2 X (n;m) whose rows are of length d( H ) and are shattered by H . Then clearly H shatters x . For

the first term in the maximum take a sequence x = (x1 ; : : : ; x ) shattered by H 1 (the hypothesis

x 2 X

the first term in the maximum take a sequencespace consisting of the union over all hypothesis spaces from x = (x1 ; : : : ; xHd ( ), and distribute its elements equally H ) ) shattered by H 1 (the hypothesis

among the rows of x (throw away any leftovers). The set of matrices

; : : : ; x

) shattered by H

1

d ( H )

82

<

6

4

:

h(x

11 ) - - - h(x1m )

... ... ...

) - - - h(x

3

7

5

11

1m

1

: h 2 H

9

=

;

:

h(xn1

where m = bd ( H )=n is a subset of H

**Lemma 11.**

) - - - h(xnm

)

jx <sup>and has size</sup> 2nm .

em

H (n)

�nd

(n)

H

    

(n; m) 

H

d

173

BAXTER

_Proof._ Observe that for each n, 

_Proof._ Observe that for each n, - H (n; m) = �H (nm) where H is the collection of all Boolean

functions on sequences x1 ; : : : ; xnm <sup>obtained</sup> <sup>by first choosing</sup> n functions h1 ; : : : ; hn <sup>from</sup> <sup>some</sup>

(n; m) = 

H

H

; : : : ; x

; : : : ; h

n <sup>from</sup> <sup>some</sup>

1

nm <sup>obtained</sup> <sup>by first choosing</sup> n functions h1

1

H 2 H, and then applying h

H 2 H, and then applying h1 <sup>to the first</sup> m examples, h2 <sup>to the second</sup> m examples and so on. By

the definition of d H (n), VCdim(H ) = nd H (n), hence the result follows from Lemma 9 applied to

1 <sup>to the first</sup> m examples, h

(n), hence the result follows from Lemma 9 applied to

H

(n), VCdim(H ) = nd

H

H .

If one follows the proof of Theorem 4 (in particular the proof of Theorem 18 in Appendix

n

A) then it is clear that for all - - 0, C ( H l ; ") may be replaced by - H (n; 2m) in the Boolean

case. Making this replacement in Theorem 18, and using the choices of �; - from the discussion
following Theorem 26, we obtain the following bound on the probability of large deviation between
empirical and true performance in this Boolean setting.

; ") may be replaced by 

n

H

l

**Theorem 12.** _Let_ P = (P1

**Theorem 12.** _Let_ P = (P

; : : : ; P

) _be_ n _probability_ _distributions_ _on_ X - f�1g _and_ _let_ z _be an_

n

(n; m) _-sample generated by sampling_ m _times from_ X - f�1g _according to each_ Pi <sup>_. Let_</sup> H = fH g

_be any permissible Boolean hypothesis space family._ _For all_ 0 < - - 1 _,_

n

Pr f z : 9h 2 H

: erP

(h) - er^ z

(h) + "g - 4�

H

2

(n; 2m) exp (�� nm=64): (46)

**Corollary 13.** _Under_ _the_ _conditions_ _of_ _Theorem_ _12,_ _if_ _the_ _number_ _of_ _examples_ m _of_ _each_ _task_
_satisfies_

(n) log

2d

m 

88

2

"

1

n

log

 

4 (47)

Æ

+

H

22

"

_then with probability at least_ 1 - Æ _(over the choice of_ z _), any_ h 2 H

n _will satisfy_

erP

_Proof._ Applying Theorem 12, we require

(h) - er^ z

(h) + " (48)

2

4� H

(n; 2m) exp (��

 

nm=64) - Æ;

     

which is satisfied if

; (49)

2em

m 

64

2

d H

1

n

1

e

log

4

Æ

(n) log

d

(n)

+

H

where we have used Lemma 11. Now, for all a - 1, if

m =

1

1 +

e

a log

1 +

a;

then m - a log m . So setting a = 64d

88

m        

2

"

H

(n)="2, (49) is satisfied if

2d

H (n) log

174

4

log

Æ

22

"

+

1

n

:

A MODEL OF INDUCTIVE BIAS LEARNING

Corollary 13 shows that any algorithm learning n tasks using the hypothesis space family H
requires no more than

+

��

(50)

m = O

1

2

"

d

1

n

log

1

Æ

H

1

(n) log

"

examples of each task to ensure that with high probability the average true error of any n hypotheses
it selects from H n is within " of their average empirical error on the sample z . We now give a

it selects from H n is within " of their average empirical error on the sample z . We now give a

theorem showing that if the learning algorithm is required to produce n hypotheses whose average
true error is within " of the _best_ _possible_ _error_ (achievable using H n ) for an arbitrary sequence of

1

distributions P1 ; : : : ; Pn <sup>, then within a</sup> log " <sup>factor the number of examples in equation (50) is also</sup>

necessary.

1

; : : : ; P

n <sup>, then within a</sup> log

1

For any sequence P = (P

; : : : ; P

) of n probability distributions on X - f�1g, define

n

1

n

optP

( H

n

) by

opt

( H

) := inf

h2 H n

erP

(h):

P

**Theorem 14.** _Let_ H _be_ _a_ _Boolean_ _hypothesis_ _space_ _family_ _such_ _that_ H 1 _contains_ _at_ _least_ _two_

_functions._ _For each_ n = 1; 2; : : : ; _let_ An <sup>_be any learning algorithm taking as input_</sup> (n; m) _-samples_

**Theorem 14.** _Let_ H _be_ _a_ _Boolean_ _hypothesis_ _space_ _family_ _such_ _that_ H

n <sup>_be any learning algorithm taking as input_</sup> (n; m) _-samples_

(n;m) _and_ _producing_ _as_ _output_ n _hypotheses_ h = (h

z 2 (X - f�1g)

; : : : ; h

) 2 H

n _._ _For_ _all_

1

n

0 < " < 1=64 _and_ 0 < Æ < 1=64 _, if_

             

��

1

8Æ (1 - 2Æ )

H

616

d

(n)

2

m <

1

2

"

+ (1 - "

)

1

n

log

_then_ _there_ _exist_ _distributions_ P = (P

_then_ _there_ _exist_ _distributions_ P = (P1 ; : : : ; Pn ) _such_ _that_ _with_ _probability_ _at_ _least_ Æ _(over_ _the_

_random choice of_ z _),_

; : : : ; P

1

n

n

er

(A

(z)) - opt

( H

) + "

P

n

P

_Proof._ See Appendix C

3.4.2 LINEAR THRESHOLD NETWORKS

Theorems 13 and 14 show that within constants and a log (1=") factor, the sample complexity of
learning n tasks using the Boolean hypothesis space family H is controlled by the complexity parameter d H (n) . In this section we derive bounds on d H (n) for hypothesis space families constructed

as thresholded linear combinations of Boolean feature maps. Specifically, we assume H is of the
form given by (39), (38), (37) and (36), where now the squashing function - is replaced with a hard
threshold: (

H

(n) . In this section we derive bounds on d

H

(

- (x) :=

1 if x - 0 ;

�1 otherwise ;

and we don’t restrict the range of the feature and output layer weights. Note that in this case the
proof of Theorem 8 does not carry through because the constants �; �0 in Theorem 7 depend on the

Lipschitz bound on - .

**Theorem 15.** _Let_ H _be a hypothesis space family of the form given in_ (39) _,_ (38) _,_ (37) _and_ (36) _, with_
_a hard threshold sigmoid function_ - _._ _Recall that the parameters_ d _,_ l _and_ k _are the input dimension,_
_number of hidden nodes in the feature map and number of features (output nodes in the feature map)_

175

BAXTER

_respectively._ _Let_ W := l (d + 1) + k (l + 1) _(the_ _number_ _of_ _adjustable_ _parameters_ _in_ _the_ _feature_
_map)._ _Then,_

   

+ k + 1 log 2

d

H (n) - 2

W

n

( 2e(k + l + 1)) :

d

_Proof._ Recall that for each w 2 R W, �w : R ! R k denotes the feature map with parameters w .

For each x 2 X (n;m), let �w jx <sup>denote the matrix</sup>

_Proof._ Recall that for each w 2 R

W, 

d

: R

! R

w

(n;m), let 

w jx <sup>denote the matrix</sup>

2

6

4

�w

�w

(x

... x11 ) - ... - - �w (x ... 1m )

) - - - 

) - - - �w

(x

3

7

5 :

11

w

1m

(xn1

(x

nm

)

Note that H jx <sup>is the</sup> <sup>set</sup> <sup>of</sup> <sup>all</sup> <sup>binary</sup> n - m matrices obtainable by composing thresholded linear

functions with the elements of �w jx <sup>, with the restriction</sup> <sup>that the same function</sup> <sup>must be applied</sup> <sup>to</sup>

each element in a row (but the functions may differ between rows). With a slight abuse of notation,
define

- :

W

(n; m) := max

x2X (n;m)

: w 2 R

��

- �w jx

Fix x 2 X

Fix x 2 X (n;m) . By Sauer’s Lemma, each node in the first hidden layer of the feature map computes

at most ( emn=(d + 1)) d+1 functions on the nm input vectors in x . Thus, there can be at most

l

(emn=(d + 1)) (d+1) distinct functions from the input to the output of the first hidden layer on

the nm points in x . Fixing the first hidden layer parameters, each node in the second layer of the

l

feature map computes at most (emn=(l + 1)) +1 functions on the image of x produced at the output

d+1 functions on the nm input vectors in x . Thus, there can be at most

(emn=(d + 1))

l

feature map computes at most (emn=(l + 1)) +1 functions on the image of x produced at the output

k (l +1)

of the first hidden layer. Thus the second hidden layer computes no more than ( emn=(l + 1))

k (l +1)

functions on the output of the first hidden layer on the nm points in x . So, in total,

�k (l +1)

l (d+1)

emn

l + 1

(n; m) 

emn

d + 1

:

Now, for each possible matrix 

Now, for each possible matrix �w jx <sup>, the number of functions computable on each row of</sup> �w jx <sup>by a</sup>

k

thresholded linear combination of the output of the feature map is at most (em=(k + 1)) +1 . Hence,

the number of binary sign assignments obtainable by applying linear threshold functions to all the

n(k

rows is at most ( em=(k + 1)) +1) . Thus,

w jx <sup>, the number of functions computable on each row of</sup> 

n(k +1) . Thus,

k (l +1)

�n(k +1)

�l (d+1) 

emn

n(k + 1)

emn

l + 1

(n; m) 

emn

d + 1

:

H

f (x) := x log x is a convex function, hence for all a; b; - 0,

f

k a + l b +

k + l + 1

�k a+l b+

1

k + l + 1

1

a

(k f (a) + l f (b) + f ( ))

:

�k a

1

b

�l b 

1

)

k + l + 1

k a + l b +

Substituting a = l + 1, b = d + 1 and = n(k + 1) shows that

�W +n(k +1)

(n; m) 

emn(k + l + 1)

W + n(k + 1)

176

: (51)

H

A MODEL OF INDUCTIVE BIAS LEARNING

Hence, if

log

(52)

  

+ k + 1

m 

W

n

2

emn(k + l + 1)

W + n(k + 1)

then 

  - H (n; m) < 2 d H (n)  - a  - x  - a log 2 x

if x = 2a log 2 2a . Setting x = emn(k + l + 1)=(W + n(k + 1)) and a = e(k + l + 1) shows that

(52) is satisfied if m = 2(W =n + k + 1) log 2 (2e(k + l + 1)) .

**Theorem 16.** _Let_ H _be_ _as in_ _Theorem_ _15_ _with the_ _following_ _extra_ _restrictions:_ d - 3 _,_ l - k _and_

k - d _._ _Then_

(n; m) < 2

H

nm and so by definition d

H

(n) - m . For all a - 1, observe that x - a log

2

2

(2e(k + l + 1)) .

��

W

2n

   

+ k + 1

d

(n) 

1

2

H

_Proof._ We bound d( H ) and d( H ) and then apply Lemma 10. In the present setting H 1 contains all

three-layer linear-threshold networks with d input nodes, l hidden nodes in the first hidden layer, k
hidden nodes in the second hidden layer and one output node. From Theorem 13 in Bartlett (1993),
we have

1 l (k                       - 1)

VCdim( H

) - dl +

+ 1;

2

which under the restrictions stated above is greater than W =2 . Hence d( H ) - W =2 .
As k  - d and l  - k we can choose a feature weight assignment so that the feature map is the
identity on k components of the input vector and insensitive to the setting of the reminaing d - k
components. Hence we can generate k + 1 points in X whose image under the feature map is
shattered by the linear threshold output node, and so d( H ) = k + 1 .

Combining Theorem 15 with Corrolary 13 shows that

��

W

n

m - O

1

2

"

+ k + 1

log

1

"

+

1

n

log

��

1

Æ

examples of each task suffice when learning n tasks using a linear threshold hypothesis space family,
while combining Theorem 16 with Theorem 14 shows that if

W

n

��

��

m - 

1

2

"

+ k + 1

+

1

n

log

1

Æ

then any learning algorithm will fail on some set of n tasks.

**4.** **Conclusion**

The problem of inductive bias is one that has broad significance in machine learning. In this paper
we have introduced a formal model of inductive bias learning that applies when the learner is able
to sample from multiple related tasks. We proved that provided certain covering numbers computed
from the set of all hypothesis spaces available to the bias learner are finite, any hypothesis space
that contains good solutions to sufficiently many training tasks is likely to contain good solutions to
novel tasks drawn from the same environment.

In the specific case of learning a set of features, we showed that the number of examples m
required of each task in an n -task training set obeys m = O (k + W =n), where k is the number of

177

BAXTER

features and W is a measure of the complexity of the feature class. We showed that this bound is
essentially tight for Boolean feature maps constructed from linear threshold networks. In addition,
we proved that the number of tasks required to ensure good performance from the features on novel
tasks is no more than O (W ) . We also showed how a good set of features may be found by gradient
descent.

The model of this paper represents a first step towards a formal model of hierarchical approaches
to learning. By modelling a learner’s uncertainty concerning its environment in probabilistic terms,
we have shown how learning can occur simultaneously at both the base level—learn the tasks at
hand—and at the meta-level—learn bias that can be transferred to novel tasks. From a technical
perspective, it is the assumption that tasks are distributed probabilstically that allows the performance guarantees to be proved. From a practical perspective, there are many problem domains that
can be viewed as probabilistically distributed sets of related tasks. For example, speech recognition
may be decomposed along many different axes: words, speakers, accents, etc. Face recognition
represents a potentially infinite domain of related tasks. Medical diagnosis and prognosis problems
using the same pathology tests are yet another example. All of these domains should benefit from
being tackled with a bias learning approach.

Natural avenues for further enquiry include:

- **Alternative constructions for** H **.** Although widely applicable, the specific example on feature
learning via gradient descent represents just one possible way of generating and searching
the hypothesis space family H . It would be interesting to investigate alternative methods,
including decision tree approaches, approaches from Inductive Logic Programming (Khan
et al., 1998), and whether more general learning techniques such as boosting can be applied
in a bias learning setting.

- **Algorithms for automatically determining the hypothesis space family** H **.** In our model the
structure of H is fixed _apriori_ and represents the _hyper-bias_ of the bias learner. It would
be interesting to see to what extent this structure can also be learnt.

- **Algorithms for automatically determining task relatedness.** In ordinary learning there is usually little doubt whether an individual _example_ belongs to the same learning task or not.
The analogous question in bias learning is whether an individual learning task belongs to a
given set of related tasks, which in contrast to ordinary learning, does not always have such
a clear-cut answer. For most of the examples we have discussed here, such as speech and
face recognition, the task-relatedness is not in question, but in other cases such as medical
problems it is not so clear. Grouping too large a subset of tasks together as related tasks could
clearly have a detrimental impact on bias-learning or multi-task learning, and there is emprical evidence to support this (Caruana, 1997). Thus, algorithms for automatically determining
task-relatedness are a potentially useful avenue for further research. In this context, see Silver
and Mercer (1996), Thrun and O’Sullivan (1996). Note that the question of task relatedness
is clearly only meaningful _relative_ to a particular hypothesis space family H (for example, all
possible collections of tasks are related if H contains every possible hypothesis space).

- **Extended hierarchies.** For an extension of our two-level approach to arbitrarily deep hierarchies,
see Langford (1999). An interesting further question is to what extent the hierarchy can
be inferred from data. This is somewhat related to the question of automatic induction of
structure in graphical models.

178

A MODEL OF INDUCTIVE BIAS LEARNING

**Acknowledgements**

This work was supported at various times by an Australian Postgraduate Award, a Shell Australia Postgraduate Fellowship, U.K Engineering and Physical Sciences Research Council grants
K70366 and K70373, and an Australian Postdoctoral Fellowship. Along the way, many people
have contributed helpful comments and suggestions for improvement including Martin Anthony,
Peter Bartlett, Rich Caruana, John Langford, Stuart Russell, John Shawe-Taylor, Sebastian Thrun
and several anonymous referees.

**Appendix A.** **Uniform Convergence Results**

Theorem 2 provides a bound (uniform over all H 2 H ) on the probability of large deviation between

erQ (H ) and er^ z (H ) . To obtain a more general result, we follow Haussler (1992) and introduce the

following parameterized class of metrics on R + :

er

(H ) and er^

Q

z

+ :

d�

[ x; y ℄ :=

jx - y j

;

x + y + 

where - - 0 . Our main theorem will be a uniform bound on the probability of large values of

d� [erQ (H ); erz (H )℄, rather than j erQ (H ) - er^ z (H )j . Theorem 2 will then follow as a corollary, as

will better bounds for the realizable case er^ z (H ) = 0 (Appendix A.3).

d

[er

(H ); er

(H ) - er^

Q

z

(H )℄, rather than j er

Q

z

z (H ) = 0 (Appendix A.3).

z

**Lemma 17.** _The following three properties of_ d� <sup>_are easily established:_</sup>

_1._ _For all_ r; s - 0 _,_ 0 - d�

[ r; s℄ - 1

_2._ _For all_ 0 - r - s - t _,_ d�

[r; s℄ - d�

[r; t℄ _and_ d�

[ s; t℄ - d�

[r; t℄ _._

_3._ _For_ 0 - r; s - 1 _,_

jr �sj

jr �sj

- d� [ r; s℄ 

             - +2              

For ease of exposition we have up until now been dealing explicitly with hypothesis spaces H
containing functions h : X ! Y, and then constructing loss functions hl <sup>mapping</sup> X - Y ! [0; 1℄

by hl (x; y ) := l (h(x); y ) for some loss function l : Y �Y ! [0; 1℄ . However, in general we can view

hl <sup>just as a function</sup> <sup>from an abstract</sup> <sup>set</sup> Z ( X - Y ) to [0; 1℄ and ignore its particular construction

in terms of the loss function l . So for the remainder of this section, unless otherwise stated, all
hypothesis spaces H will be sets of functions mapping Z to [0; 1℄ . It will also be considerably more
convenient to transpose our notation for (n; m) -samples, writing the n training sets as columns
instead of rows:

- +2

l

(x; y ) := l (h(x); y ) for some loss function l : Y �Y ! [0; 1℄ . However, in general we can view

z

: : : z

z =

11 ... ... 1 ... n

z : : : z

m1

mn

where each zij 2 Z . Recalling the definition of (X - Y )(n;m) (Equation 9 and prior discussion),

with this transposition z lives in (X - Y ) (m;n) . The following definition now generalizes quantities

where each z

ij

2 Z . Recalling the definition of (X - Y )

with this transposition z lives in (X - Y ) (m;n) . The following definition now generalizes quantities

like er^ z (H ), erP (H ) and so on to this new setting.

(H ), er

z

P

(H ) and so on to this new setting.

**Definition 6.** Let H

; : : : ; H

n <sup>be</sup> n sets of functions mapping Z into [0; 1℄ . For any h1

2

1

H1 ; : : : ; h

n

- - - - - hn <sup>or simply</sup> h denote the map

n

X

2 Hn <sup>, let</sup> h

1

(z

)

h(~z ) = 1=n

i=1

179

h

i

i

for all ~z = (z

; : : : ; z

) 2 Z

1

n

n . Let H

1

BAXTER

- - - - - H

n <sup>denote</sup> <sup>the</sup> <sup>set</sup> <sup>of</sup> <sup>all</sup> <sup>such</sup> <sup>functions.</sup> <sup>Given</sup>

) (or equivalently an element z of

h 2 H1

- - - - - H

n <sup>and</sup> m elements of (X - Y )

1 ; : : : ; ~zm

(m;n) by writing the ~z

)n, (~z1

m

X

(X - Y )

i <sup>as rows), define</sup>

er^ z (h) :=

1

m

h(~zi )

i=1

(recall equation (8)). Similarly, for any product probability measure P = P1

(X - Y )n, define

- - - - - P

n <sup>on</sup>

erP

(h) :=

Z

Z n

h(~z ) dP(~z )

0

(recall equation (26)). For _any_ h; h

0 n

(recall equation (26)). For _any_ h; h : ( X - Y ) ! [0; 1℄ (not necessarily of the form h1 - - - - - hn <sup>),</sup>

define Z

n

! [0; 1℄ (not necessarily of the form h

0

: ( X - Y )

- - - - - h

1

Z

(~z )j dP(~z )

0

jh(~z ) - h

dP

0

(h; h ) :=

Z n

(recall equation (17)). For any class of functions H mapping (X - Y )n to [0; 1℄, define

C ("; H ) := sup

P

N ( "; H ; dP

)

n and N ( "; H ; d

where the supremum is over all product probability measures on (X - Y )

where the supremum is over all product probability measures on (X - Y )n and N ( "; H ; dP ) is the

size of the smallest " -cover of H under dP <sup>(recall Definition 4).</sup>

P

P <sup>(recall Definition 4).</sup>

The following theorem is the main result from which the rest of the uniform convergence results
in this paper are derived.

**Theorem 18.** _Let_ H - H

n _into_

- - - - - H

1

(X                - Y )
n <sup>_be a permissible class of functions mapping_</sup>

(m;n) _be_ _generated_ _by_ m - 2=(�

- ) _independent_ _trials_ _from_ (X - Y )

[0; 1℄ _._ _Let_ z 2 (X - Y )

n

2

_according to some product probability measure_ P = P

  

(m;n)

- - - - - P

 

1

n <sup>_._</sup> <sup>_For all_</sup> - - 0 _,_ 0 < - < 1 _,_

Pr

z 2 (X - Y )

: sup

H

d

(h); er

P

(h)℄ - 

[er^ z

2

               - 4C (�� =8; H ) exp (��

The following immediate corollary will also be of use later.

**Corollary 19.** _Under the same conditions as Theorem 18, if_

- nm=8): (53)

(

)

  

; H

2

2

8

2

 - n

: sup

H

d

log

��

8

Æ

;

; (54)

 

_then_

(m;n)

Pr

m  - max

(

z 2 (X - Y )

4C

 - [ er^

(h); er

(h)℄ - 

- Æ (55)

z

P

**A.1** **Proof of Theorem 18**

The proof is via a double symmetrization argument of the kind given in chapter 2 of Pollard (1984).
I have also borrowed some ideas from the proof of Theorem 3 in Haussler (1992).

180

A MODEL OF INDUCTIVE BIAS LEARNING

A.1.1 FIRST SYMMETRIZATION

An extra piece of notation: for all z 2 (X - Y )(2m;n), let z(1) be the top half of z and z(2) be the

bottom half, viz:

z

: : : z

z

: : : z

z(1) =

11 ... ... 1 ... n

z : : : z

z(2) =

m+1 ... ;1 ... m+1 ... ;n

: : : z2m;n

m1

mn

z2m;1

The following lemma is the first “symmetrization trick.” We relate the probability of large deviation
between an empirical estimate of the loss and the true loss to the probability of large deviation
between two independent empirical estimates of the loss.

**Lemma 20.** _Let_ H _be_ _a_ _permissible_ _set_ _of_ _functions_ _from_ ( X - Y )n _into_ [0; 1℄ _and_ _let_ P _be_ _a_

2

_probability measure on_ (X - Y )n _._ _For all_ - - 0; 0 < - < 1 _and_ m - 2 - <sup>_,_</sup>

**Lemma 20.** _Let_ H _be_ _a_ _permissible_ _set_ _of_ _functions_ _from_ ( X - Y )

n _._ _For all_ - - 0; 0 < - < 1 _and_ m 

2

2

 

- <sup>_,_</sup>

(m;n)

: sup

H

d

Pr

z 2 (X - Y )

(h); er

P

z 2 Z

(h)℄ - 

(2m;n)

: sup

H

[er^ z

d

: (56)

z(2)

(h)

2

- 2 Pr

(h); er^

er^ z(1) (

_Proof._ Note first that permissibility of H guarantees the measurability - of suprema - over H
(Lemma 32 part 5). By the triangle inequality for d� <sup>,</sup> <sup>if</sup> d� er^ z(1) (h); er P (h) - - and

- <sup>,</sup> <sup>if</sup> d�

z(1)

er^

(h); er

(h)

- - and

P

  

d�

er^ z(2)

n

< �=2, then d�

 

- �=2 . Thus,

  

 - 

er^ z(1)

 

- er^

(h); er

   

P (h)

(h); er^

z(2)

(h); er^ z(2) (

  

(h)

(h)

Pr

(2m;n)

z 2 (X - Y )

: 9h 2 H : d

n

 

z(1)

2

< �=2

(2m;n)

- Pr

z 2 ( X - Y )

er^ z(1)

 

er^ z(2)

(h); er

(h); er

jer^

P

P

  

(h)

  

(h)

- - and

  

(57)

 

2

By Chebyshev’s inequality, for any fixed h,

n

(m;n)

Pr

z 2 (X - Y )

: d�

[er^ z

(h); er

P (h)℄ <

: 9h 2 H : d�

d�

 

2

 

(h)j

:

<

z

P

:

- Pr

- 1 

1

2

(m;n)

z 2 (X - Y )

(h) - er

  

erP

(h)(1 - er

2

P

(h))

m� 

=4

as m - 2=(�

2

as m - 2=(� - ) and erP (h) - 1 . Substituting this last expression into the right hand side of (57)

gives the result.

2

- ) and er

P

181

BAXTER

A.1.2 SECOND SYMMETRIZATION

The second symmetrization trick bounds the probability of large deviation between two empirical
estimates of the loss (i.e. the right hand side of (56)) by computing the probability of large deviation when elements are randomly permuted between the first and second sample. The following
definition introduces the appropriate permutation group for this purpose.

**Definition 7.** For all integers m; n - 1, let �(2m;n) <sup>denote</sup> <sup>the</sup> <sup>set</sup> <sup>of</sup> <sup>all</sup> <sup>permutations</sup> - of the

sequence of pairs of integers f(1; 1); : : : ; (1; n); : : : ; (2m; 1); : : : ; (2m; n)g such that for all i, 1 
i - m, either - (i; j ) = (m + i; j ) and - (m + i; j ) = (i; j ) or - (i; j ) = (i; j ) and - (m + i; j ) =

(m + i; j ) .

)(2m;n) and any - 2 

For any z 2 (X - Y )

(2m;n) <sup>, let</sup>

: : : z

- (1;1)

z� :=

z

z

- (1 ... ;1) ... - (1 ... ;n)

- (2m;1)

: : : z� (2m;n) :

**Lemma 21.** _Let_ H = H1

(X                - Y )
n <sup>_be_</sup> <sup>_a_</sup> <sup>_permissible_</sup> <sup>_set_</sup> <sup>_of_</sup> <sup>_functions_</sup> <sup>_mapping_</sup>

(2m;n) _and_ _let_

- - - - - H

)n _into_

[0; 1℄ _(as in the_ _statement_ _of Theorem_ _18)._ _Fix_ z 2 (X - Y ) (2m;n) _and_ _let_ H^ := ff 1 ; : : : ; f M g _be_

P

0 1 2m 0

_an_ �� =8 _-cover for_ (H ; dz ) _, where_ dz (h; h ) := jh(~zi ) - h (~zi )j _where the_ ~zi <sup>_are the rows_</sup>

[0; 1℄ _(as in the_ _statement_ _of Theorem_ _18)._ _Fix_ z 2 (X - Y )

1

M

^

H := ff

; : : : ; f

P

0 1 2m 0

_an_ �� =8 _-cover for_ (H ; dz ) _, where_ dz (h; h ) := 2m i=1 jh(~zi ) - h (~zi )j _where the_ ~zi <sup>_are the rows_</sup>

_of_ z _._ _Then,_

) _, where_ d

1

2m

i=1

0

0

)j _where the_ ~z

(h; h

) :=

jh(~z

) - h

(~z

z

z

i

i

2m

(f

2

(1)

M

(h); er^

n

  

(h)

Pr

- 2 �(2m;n)

: sup d�

H

er^ z�

z�

(2)

; (58)

i

i

 

)

); er^

4

: d

 

er^

X

Pr

i=1

- 2 

 

z�

(2)

(f

(2m;n)

z� (1)

_where each_ - 2 �(2m;n) <sup>_is chosen uniformly at random._</sup>

                           

_Proof._ Fix - 2 

_Proof._ Fix - 2 �(2m;n) <sup>and let</sup> h 2 H be such that d� er^ z� (1) (h); er^ z� (2) (h) - �=2 (if there is

no such h for any - we are already done). Choose f 2 H^ such that dz (h; f ) - �� =8 . Without loss

of generality we can assume f is of the form f = f1 - - - - - fn <sup>.</sup> <sup>Now,</sup>

(2m;n) <sup>and let</sup> h 2 H be such that d

er^

(h); er^

(h)

 

z

(1)

z

(2)

 

H^ such that d

^

z

- - - - - f

1

n <sup>.</sup> <sup>Now,</sup>

 - (i;j )

- mn

�Pn

- j =1

�Pn

- j =1

hj

(z

ij

) - fj

(z

ij

 

 

)�

2

dz (h; f ) =

=

   

- mn

P

2m

i=1

P

2m

i=1

  

P

m

i=1

�P2m

hj (z

) - f

j

(z� (i;j )

 

 

)�

�Pm

 - i=1

P

n

j =1

(z�

 

hj

) - fj

 

)

- (i;j )

(z� (i;j )

- mn +

+

i=m+1

P

2m

P

n

j =1

P

h

n

(z� (i;j )

 

(z� (i;j )

 

)

j

) + fj

h

(z�

 

) - f

(z� (i;j )

 - 

)

j

j

- (i;j )

j =1

P

n

- mn +

hj

(z� (i;j )

) + fj

(z� (i;j )

 

)

 

j =1

  

(f ) + d

 

i=m+1

(h); er^

(h); er^ z

(2) (f )

:

= d�

er^ z� (1)

 

er^ z� (2)

z

(1)

182

A MODEL OF INDUCTIVE BIAS LEARNING

Hence, by the triangle inequality for d� <sup>,</sup>

2       

d

(h; f )+ d�

er^ z�

 

(f ); er^

  

(f )

er^ z�

 

(h); er^

 

z

(1)

z� (2)

- d�

 

(1)

z�

(1)

(59)

(f ); er^

 

(h); er^

z�

(h); er^ z

+ d

er^ z�

 

er^ z

er^ z�

   

- d�

(2)

(1)

z

  

(f )

   

(2) (f )

(2)

(2)

(f )

  

(h)

+ d�

 

) :

(1)

 

 

 

2

But - dz (h; f ) �� �=4 by construction - and d� er^ z� (1) (h); er^ z� (2) (h) - �=2 by assumption, so

(59) implies d� er^ z (1) (f ); er^ z (2) (f ) - �=4 . Thus,

But

2

(h); er^

(h)

d

er^

z

(h; f ) - �=4 by construction and d�

z

(1)

z

(2)

 

 

er^

(f ); er^

(f )

- �=4 . Thus,

 

z

(1)

z

(2)

  

: 9h 2 H : d�

er^ z�

n

 - 2 �(2m;n)

 

er^ z

(h); er^

 

  

(h)

 

2

^

(1)

z

(2)

: 9f 2

H : d�

(1)

 

4

n

 - 2  

(f ); er^

  

(f ) ) 

;

(2m;n)

z�

(2)

which gives (58).

Now we bound the probability of each term in the right hand side of (58).

n

**Lemma 22.** _Let_ f : (X - Y )

! [0; 1℄ _be_ _any_ _function_ _that_ _can_ _be_ _written_ _in_ _the_ _form_ f =

 

f1

- - - - - fn <sup>_._</sup> <sup>_For any_</sup> z 2 (X - Y )(2m;n) _,_

n

               

��

- 2 exp

)  - fj (z

��

) 

2

- mn

8

; (60)

(f ); er^

(f )

fj

 

4

(z

Pr

- 2 

: d�

er^ z�

z� (2)

(2m;n)

(1)

_where each_ - 2 �(2m;n) <sup>_is chosen uniformly at random._</sup>

_where each_ - 2 

  

(f ) =

_Proof._ For any - 2 

        

n

j =1

P

  - (i;j )

P P

- (m+i;j )

: (61)

�Pm

- i=1

(2m;n) <sup>,</sup>

(f ); er^

d�

er^ z�

(1)

z� (2)

n

j =1

 - mn +

2m

i=1

fj

(zij

)

To simplify the notation denote fj

(zij ) by �ij <sup>.</sup> <sup>For</sup> <sup>each</sup> <sup>pair</sup> ij, 1 - i - m, 1 - j - n, let

Y
ij <sup>be</sup> <sup>an</sup> <sup>independent</sup> <sup>random</sup> <sup>variable</sup> <sup>such</sup> <sup>that</sup>

Y

Y

= 

- �m+i;j <sup>with</sup> <sup>probability</sup> 1=2 and

ij

m+i;j <sup>with</sup> <sup>probability</sup> 1=2 and

ij

- (m+i;j )

- �ij <sup>with probability</sup> 1=2 . From (61),

            

ij

= �m+i;j

n

(1)

m

4

Pr

- 2 

: d�

er^ z

(2)

(z� (i;j )

  

(f ) 

:

z�

 

 

 

(f ); er^ z

n

19

=

�ij A

;

X

j =1

2m

X

i=1

0

2m

X

 - mn +

i=1

n

X

j =1

= Pr

= Pr

(2m;n)

8

<

 - 2  

8�

<�� Xm

  

  

:

  - i=1

- mn +

�X

 

 

 - i=1

0

fj

) - fj

(z

  

  

��

) ) ��

  

4

:

(2m;n)

     

n 

X 

Yij ��

j =1 

n

X

j =1

�ij

19

=

A

;

4

For zero-mean independent random variables Y

For zero-mean independent random variables Y1 ; : : : ; Yk <sup>with</sup> <sup>bounded</sup> <sup>ranges</sup> ai - Yi - bi <sup>,</sup> <sup>Ho-</sup>

effding’s inequality (Devroye, Gy¨orfi, & Lugosi, 1996) is

; : : : ; Y

- Y

- b

1

k <sup>with</sup> <sup>bounded</sup> <sup>ranges</sup> ai

i

i

k

i=1

(

)

2

)

!

:

i

- 2 exp

183

- P

2�

(bi

- 

Pr

k

X

i=1

Yi

2

- a

BAXTER

[�j�
ij <sup>is</sup>

Noting that the range of each Y

- �i

0

B

i+m;j

2

 

32

)j℄, we have

ij

- �i+m;j

19

=

)j; j�ij

�ij

i

m

X

i=1

X

j =1

A

;

- 2 exp

1

C

A

:

2

2

)

P

P

n

j =1

- 

h

 - mn +

m

i=1

n

X

j =1

n

�ij

P

2m

X

i=1

P

P

2m

i=1

(�

4

0

 - mn +

Pr

8�

  

<

  

  

  

:

  

Y

P

n

j =1

2

)

2

n

(

j =1

ij

i+m;j

P

ij

P

Let - =

2m

i=1

2 exp

- 1,

P

i2

2

)

n

j =1

0

B

�ij <sup>.</sup> <sup>As</sup> 0 - 

 

32

ij <sup>.</sup> <sup>As</sup> 0 - 

 

- 

m+ij

 

ij

(�ij

h

2

P

n

m

i=1

 

i+m;j

:

;

2

2m

i=1

(�ij

- mn +

m

i=1

ij

1

C

A

P

j =1

- 

- 2 exp

- - . Hence,

2

(� mn + - )

32�

P

n

j =1

2

(� mn + - )

=� is minimized by setting - = - mn giving a value of 4� mn . Hence

                 

n

Pr     - 2 �(2m;n)

as required.

- mn

(1)

2

��

8

)) exp

  

(f )

4

- 2 exp

: d�

er^ z

(f ); er^

z� (2)

 

A.1.3 PUTTING IT TOGETHER

For fixed z 2 ( X - Y ) (2m;n), Lemmas 21 and 22 give:

  

(h); er^

  

(h)

 

2

Pr

- 2 �(2m;n) : sup

H

d�

er^ z�

(1)

z� (2)

- mn

8

- 2N (�� =8; H ; dz

 

Note that d

Note that dz <sup>is</sup> <sup>simply</sup> dP <sup>where</sup> P = (P1 ; : : : ; Pn ) and each Pi <sup>is</sup> <sup>the</sup> <sup>empirical</sup> <sup>distribution</sup> <sup>that</sup>

puts point mass 1=m on each zj i ; j = 1; : : : ; 2m (recall Definition 3). Hence,

d
z <sup>is</sup> <sup>simply</sup>

P = (P
P <sup>where</sup>

; : : : ; P

) and each Pi

1

n

j i

; j = 1; : : : ; 2m (recall Definition 3). Hence,

(2m;n)

Pr

- 2 �(2m;n) ; z 2 ( X - Y )

: sup d�

H

er^ z�

(1)

(h); er^

2

z�

   

(2) (h)

      

- 2C (�� =8; H ) exp 

:

2

- mn

8

Now, for a random choice of z, each z

Now, for a random choice of z, each zij <sup>in</sup> z is independently (but not identically) distributed and 
only ever swaps zij <sup>and</sup> zi+m;j <sup>(so that</sup> - swaps a zij <sup>drawn according to</sup> Pj <sup>with another component</sup>

drawn according to the same distribution). Thus we can integrate out with respect to the choice of

z
ij <sup>and</sup>

i+m;j <sup>(so that</sup> - swaps a z

P
ij <sup>drawn according to</sup>

- and write

  

2

: sup

H

Pr

(2m;n)

z 2 (X - Y )

d�

er^ z(1)

(h); er^

z(2)

  

(h) 

      

- 2C (�� =8; H ) exp 

:

2

- mn

8

Applying Lemma 20 to this expression gives Theorem 18.

184

A MODEL OF INDUCTIVE BIAS LEARNING

**A.2** **Proof of Theorem 2**

Another piece of notation is required for the proof. For any hypothesis space H and any probability
measures P = (P1 ; : : : ; Pn ) on Z, let

; : : : ; P

) on Z, let

1

n

n

X

i=1

erPi

(h):

er^ P

(H ) :=

1

n

inf

h2H

Note that we have used er^

Note that we have used er^ P (H ) rather than erP (H ) to indicate that er^ P (H ) is another empirical

estimate of erQ (H ) .

With the (n; m) -sampling process, in addition to the sample z there is also generated a sequence of probability measures, P = ( P1 ; : : : ; Pn ) although these are not supplied to the learner.

(n;m) n

This notion is used in the following Lemma, where Prf(z; P) 2 (X - Y ) - P : Ag means

“the probability of generating a sequence of measures P from the environment (P ; Q) and then an

(H ) to indicate that er^

P

(H ) rather than er

P

P

Q

; : : : ; P

1

n

(n;m)

n

- P

(n; m) -sample z according to P such that A holds”.

**Lemma 23.** _If_

    

(n;m) n

Pr

(z; P) 2 (X - Y )

   

n

- P

: sup

H

d�

[er^ z

(H ); er^

(H )℄ 

 

2

Æ

; (62)

2

_and_

_then_

Pr

P 2 P

: sup d�

H

(n;m)

[ er^ P (

(H ); er

(H )℄ 

P

 

2

Pr

z 2 (X - Y )

: sup

H

d�

[er^ z

Q

(H ); erQ

(H )℄ - 

Æ

; (63)

2

 - Æ:

_Proof._ Follows directly from the triangle inequality for d� <sup>.</sup>

We treat the two inequalities in Lemma 23 separately.

A.2.1 INEQUALITY (62)

In the following Lemma we replace the supremum over H 2 H in inequality (62) with a supremum
over h 2 H n .

**Lemma 24.**

: sup

H

d

Pr

(n;m)

(z; P) 2 (X - Y )

(

n

- P

[ er^

(H ); er^

   

(H )℄ - 

 

z

(n;m)

P

n

: sup

H nl

(64)

- Pr

(z; P) 2 (X - Y )

185

- P

d�

[er^

z

(h); er

)

(h)℄ - 

P

BAXTER

_Proof._ Suppose that (z; P) are such that sup

_Proof._ Suppose that (z; P) are such that sup H d� [er^ z (H ); er^ P (H )℄ - - . Let H satisfy this in
equality. Suppose first that er^ z (H ) - er^ P (H ) . By the definition of er^ z (H ), for all " - 0 there

n

exists h 2 H := H - - - - - H such that er^ z (h) < er^ z (H ) + " . Hence by property (3) of the d�

metric, for all " - 0, there exists h 2 H n such that d� [ er^ z (h); er^ z (H )℄ < " . Pick an arbitrary h

satisfying this inequality. By definition, er^ P (H ) - erP (h), and so er^ z (H ) - er^ P (H ) - erP (h) .

As d� [er^ z (H ); er^ P (H )℄ - - (by assumption), by the compatibility of d� <sup>with the ordering</sup> <sup>on the</sup>

reals, d� [er^ z (H ); er P (h)℄ - - = - + Æ, say. By the triangle inequality for d� <sup>,</sup>

d

[er^

(H ); er^

z

P

H

(H ) - er^

(H ) . By the definition of er^

z

P

z

n

:= H - - - - - H such that er^

(h) < er^

(H ) + " . Hence by property (3) of the d

z

z

n such that d

[ er^

(h); er^

z

z

(H ) - er

(h), and so er^ z

(H ) - er^

(H ) - er

P

P

z

P

P

[er^

(H ); er^

(H )℄ - - (by assumption), by the compatibility of d

z

P

[er^

(H ); er

z

P

(h)℄ - - = - + Æ, say. By the triangle inequality for d

- <sup>,</sup>

d

[er^ z (

(h); er

P

(h)℄ + d�

[er^ z

(h); er^

z

(H )℄ - d

(H ); er

P

(h)℄ = - + Æ:

 

[er^ z (

Thus d

Thus d� [er^ z (h); er P (h)℄ - - + Æ - " and for any " - 0 an h satisfying this inequality can be

found. Choosing " = Æ shows that there exists h 2 H n such that d� [er^ z (h); er P (h)℄ - - .

If instead, er^ P (H ) < er^ z (H ), then an identical argument can be run with the role of z and P

interchanged. Thus in both cases,

n such that d

[er^

(h); er

z

P

Choosing " = Æ shows that there exists h 2 H n such that d� [er^ z (h); er P (h)℄  -  - .

If instead, er^ P (H ) < er^ z (H ), then an identical argument can be run with the role of

[er^

(h); er

z

P

(H ) < er^

P

z

sup d�

H

[er^ z (H ); er^ P

(H )℄ - - ) 9h 2 H

n

l

: d�

[er^ z (

(h); er

)

P

(h)℄ - �;

)

which completes the proof of the Lemma.

By the nature of the (n; m) sampling process,

(

(n;m) n

[ er^

(h); er

(h)℄ - 

Pr

(z; P) 2 ( X - Y )

Z

(

(

z 2 (X  - Y )

- P

sup

H nl

: d

z

P

d�

: sup

H nl

(n;m)

(P): (65)

P

(h)℄ - 

n

dQ

[ er^ z

(h); er

=

Pr

n

P 2P

Now H

n

l

n n

Now H l - K - - - - - K where K := fhl : h 2 H : H 2 H g and H l <sup>is permissible by the assumed</sup>

n

permissibility of H (Lemma 32, Appendix D). Hence H l <sup>satisfies</sup> <sup>the</sup> <sup>conditions</sup> <sup>of</sup> <sup>Corollary</sup> <sup>19</sup>

and so combining Lemma 24, Equation (65) and substituting �=2 for - and Æ =2 for Æ in Corollary
19 gives the following Lemma on the sample size required to ensure (62) holds.

- K - - - - - K where K := fhl

: h 2 H : H 2 H g and H

n

l

n

**Lemma 25.** _If_

_then_

Pr

(z; P) 2 ( X - Y )

   

m - max

32

2

)

n

)

l

8C (�� =16; H

Æ

;

  

8

2

- 

- n

log

n

 

(n;m)

Æ

2

:

 

- P

: sup

H

d

[ er^

(H ); er^

(H )℄ 

z

P

2

A.2.2 INEQUALITY (63)

P

Note that er

n

 

(P

(H ) = E

where P is distributed according to erP (H ) = n i=1 H (PQi . So to bound the left-hand-side of (63) we can apply Corollary erQ (H ) = E P �Q H (P H (P )
19 with n = 1, m replaced by n, H replaced by H -, - and Æ replaced by �=2 and Æ =2 respectively,

P replaced by Q and Z replaced by P . Note that H - is permissible whenever H is (Lemma 32).

Thus, if

(H ) =

1

n

H

H

(P ), i.e the expectation of H

) and er

Q

P

i

P �Q

i=1

-, - and Æ replaced by �=2 and Æ =2 respectively,

P replaced by Q and Z replaced by P . Note that H

)

(66)

n - max

32

2

log

8C (�� =16; H

Æ

186

;

8

2

 

A MODEL OF INDUCTIVE BIAS LEARNING

then inequality (63) is satisfied.

Now, putting together Lemma 23, Lemma 25 and Equation 66, we have proved the following
more general version of Theorem 2.

**Theorem 26.** _Let_ H _be a permissible_ _hypothesis_ _space_ _family and let_ z _be an_ (n; m) _-sample gen-_
_erated from the environment_ ( P ; Q) _._ _For all_ 0 < �; Æ < 1 _and_ - - 0 _, if_

)

8

2

32

2

log

        

8C (�� =16; H

Æ

8C (�� =16; H

;

n

8

2

;

32

2

l

)

;

log

- n

Q (H )℄ - 

 

_then_

n    - max

_and_ m - max

Pr

(n;m)

z 2 (X - Y ) : sup

H

d�

Æ

[er^ z (H ); er

- Æ

To get Theorem 2, observe that erQ (H )   - er^ z (H ) + " ) d� [ er^ z (H ); er Q (H )℄   - "=(2 +   - ) .

2

Setting - = "=(2 + - ) and maximizing - - gives - = 2 . Substituting - = "=4 and - = 2 into

Theorem 26 gives Theorem 2.

To get Theorem 2, observe that er

(H ) - er^

(H ) + " ) d

[ er^

(H ); er

Q

z

z

Q

2

**A.3** **The Realizable Case**

In Theorem 2 the sample complexity for both m and n scales as 1="2 . This can be improved to

1=" if instead of requiring er

er Q (H )              - er^ z (H ) + erQ (H )              - �er^ z (H ) + "

for some - - 1 . To see this, observe that erQ (H ) - er^ z (H )(1 + �)=(1 - �) + �� =(1 - �) )

d� [er^ z (H ); er Q (H )℄ - -, so setting �� =(1 - �) = " in Theorem 26 and treating - as a constant

gives:

(H ) - er^

(H ) + ", we require only that er

(H ) - �er^

Q

z

Q

z

(H ) - er^

(H )(1 + �)=(1 - �) + �� =(1 - �) )

Q

z

d

[er^

(H ); er

z

Q

**Corollary 27.** _Under the same conditions as Theorem 26, for all_ " - 0 _and_ 0 < �; Æ < 1 _, if_

�(1 - �)"n

(n;m)

 

32

log

�(1 - �)"

32

8C ((1 - �)"=16; H

Æ

8C ((1 - �)"=16; H

)

;

n

8

�(1 - �)"

)

l

8

;

�(1 - �)"

 

log

;

_then_

     

n    - max

     

_and_ m - max

  

(H ) + "

- Æ:

Pr

z 2 ( X - Y )

: sup

H

erQ

(H ) 

Æ

1 + 

1 - 

er^ z

These bounds are particularly useful if we know that er^ z (H ) = 0, for then we can set   - = 1=2

(which maximizes �(1 - �) ).

These bounds are particularly useful if we know that er^

z

**Appendix B.** **Proof of Theorem 6**

Recalling Definition 6, for H of the form given in (32), H

n

n

l <sup>can be written</sup>

H l

= fg1

Æ f - - - - - gn

Æ f : g1

; : : : ; gn

2 G f 2 F g :

l <sup>and</sup>

To write H

n

l <sup>as</sup> <sup>a</sup> <sup>composition</sup> <sup>of</sup> <sup>two</sup> <sup>function</sup> <sup>classes</sup> <sup>note</sup> <sup>that</sup> <sup>if</sup> <sup>for</sup> <sup>each</sup> f : X ! V we define

n

n

n by

f : (X - Y )

! (V - Y )

    

f (x1 ; y1

; : : : ; xn

; y

n

) := (f (x1 )

187

); y

; : : : ; f (x

); y

)

1

n

n

then g1

F g,

Æ f - - - - - gn

Æ f = g

1

- - - - - g

Æ

H

BAXTER

f� . Thus, setting Gln

= G

:= G

- - - - - G F := f

l <sup>and</sup>

f�: f 2

n

l

F := f
l <sup>and</sup>

n

l

n

l

Æ F : (67)

The following two Lemmas will enable us to bound C ("; H

) .

n

l

**Lemma 28.** _Let_ H : X - Y ! [0; 1℄ _be_ _of_ _the_ _form_ H = Gl

Æ F _where_ X - Y

F

�! V - Y

Gl

�!

l

[0; 1℄ _._ _For all_ "1

- 0 _,_

; "2

; F ) C ("2

; G

l

):

C ("1

+ "

2

; H ) - CG

("

1

l

_Proof._ Fix a measure P on X - Y and let F be a minimum size "

_Proof._ Fix a measure P on X - Y and let F be a minimum size "1 <sup>-cover</sup> <sup>for</sup> (F ; d[P ;Gl ℄ ) . By

definition jF j - CGl ("1 ; F ) . For each f 2 F let Pf <sup>be the measure on</sup> V - Y defined by Pf (S ) =

�1 �1

P (f (S )) for any set S in the - -algebra on V - Y ( f is measurable so f (S ) is measurable).

Let Gf <sup>be</sup> <sup>a</sup> <sup>minimum</sup> <sup>size</sup> "2 <sup>-cover</sup> <sup>for</sup> (Gl ; dP ) . By definition again, jGf j - C ("2 ; Gl ) . Let

1 <sup>-cover</sup> <sup>for</sup> (F ; d

[P ;G

℄

l

("

; F ) . For each f 2 F let P

(S ) =

f <sup>be the measure on</sup> V - Y defined by Pf

f

G

1

l

�1

�1

P (f

(S )) for any set S in the - -algebra on V - Y ( f is measurable so f

f <sup>be</sup> <sup>a</sup> <sup>minimum</sup> <sup>size</sup> "2

"2 <sup>-cover</sup> <sup>for</sup> (Gl

; d

) . By definition again, jG

j - C ("

; G

) . Let

f

l

l

P

2

f

N := fg Æ f : f 2 F and g 2 Gf g . Note that jN j - CGl ("1 ; F )C ("2 ; Gl ) so the Lemma will be

proved if N can be shown to be an "1 + "2 <sup>-cover</sup> <sup>for</sup> (H ; dP ) . So, given any g Æ f 2 H choose

N := fg Æ f : f 2 F and g 2 Gf

g . Note that jN j - CG

("

; F )C ("

; G

2

G

1

f

l

l

) . So, given any g Æ f 2 H choose

+ "

1

2 <sup>-cover</sup> <sup>for</sup> (H ; d

P

0 (g ; g

l ℄

0

0

2 F such that d[P ;G

2 F such that d

0

0

g
1 <sup>and</sup>

0

0

0

2 <sup>.</sup> <sup>Now,</sup>

f

(f ; f

) - "

0

2 G

0 such that dP

0 such that d

) - "2 <sup>.</sup> <sup>Now,</sup>

f

0

0

0

dP

(g Æ f ; g

Æ f

) - d

 - d

P

(g Æ f ; g Æ f

0

(f ; f ) + d

(g Æ f

0

; g

Æ f

)

f

0

) + dP

(g ; g

)

[P ;Gl ℄

Pf 0

- "

+ "2

:

1

where the first line follows from the triangle inequality for d

where the first line follows from the triangle inequality for dP <sup>and</sup> <sup>the</sup> <sup>second</sup> <sup>line</sup> <sup>follows</sup> <sup>from</sup>

0 0 0 0 0 0

the facts: dP (g Æ f ; g Æ f ) = dP (g ; g ) and dP (g Æ f ; g Æ f ) - d[P ;G ℄ (f ; f ) . Thus N is an

0

0

0

0

0

0

(g Æ f

; g

Æ f

) = d

(g ; g

0

) and d

(g Æ f ; g Æ f

) - d

(f ; f

0

) . Thus N is an

P

P

P

[P ;G

l ℄

) and so the result follows. f

"1

+ "

2 <sup>-cover for</sup> (H ; dP

2 <sup>-cover for</sup> (H ; d

Recalling the definition of H1

**Lemma 29.**

- - - - - H

n <sup>(Definition 6), we have the following Lemma.</sup>

n

Y

C ("; H1

- - - - - H

n

1

) 

C ("; Hi )

n <sup>on</sup> (X - Y )n . Let N

(X   - Y )
n <sup>on</sup>

1

; : : : ; N

_Proof._ Fix a product probability measure P = P1

i=1

- - - - - P

n <sup>be</sup>

" -covers of (H1

n <sup>.</sup> <sup>Given</sup> h = h

; dP1

) : : : ; (H

; d

- - - - - N

2

n

Pn

) . and let N = N1

1

- - - - - hn

2 N such that d

        

Z    - n

) - " for each i = 1; : : : ; n . Now,

        

Xn 

        

H1

- - - - - H

n <sup>, choose</sup> g1

n <sup>, choose</sup> g

- - - - - g

) =

 

Pi

(hi

; gi

Z

n

X

i=1

(h

d

- - - - - h

n

n

- - - - - g

n

- - - - - H

1

n

1

n

 

 

 

d

(zi

)�

 

dP(z

1

; : : : ; z

)

) 

g

P

(h1

; g1

hi

(zi

i

n

n

X

i=1

; g

)

i=1

jNi j the result follows.

Pi

i

Q

n

i

Thus N is an " -cover for H1

Thus N is an " -cover for H

 - ":

jN j =
n <sup>and as</sup>

188

i=1

A MODEL OF INDUCTIVE BIAS LEARNING

**B.1** **Bounding** C ( "; H

From Lemma 28,

and from Lemma 29,

l

C ( "

n

)

l

)

C

"1

n

n

+ "

2

; G

Æ F

; G

- C ( "

; Gl

) CGl n

"2

; F

- (68)

1

n

: (69)

; G

l

n

)

1

l

) - C ("1

Using similar techniques to those used to prove Lemmas 28 and 29, C

Usingsatisfy similar techniques to those used to prove Lemmas 28 and 29, CGl n ("; F ) can be shown to

n

G

l

n

CGl

("

2 ; F ) - CG

( "

2 ; F ) : (70)

2

l

Equations (67), (68), (69) and (70) together imply inequality (34).

**B.2** **Bounding** C ("; H

)

We wish to prove that C ("; H

Gl

) - C

( "; F ) when H is a hypothesis space family of the form

Æ f, and that

H = fGl

                 
Æ f : f 2 F g . Note that each H

               

2 H

- corresponds to some Gl

H

(P ) = inf

g 2G

erP

(g Æ f ):

l

Any probability measure Q on P induces a probability measure QX �Y <sup>on</sup> X - Y, defined by

Z

Q

(S ) =

P (S ) dQ(P )

X �Y

P

for any S in the - -algebra on X - Y . Note also that if h; h0 are bounded, positive functions on an

arbitrary set A, then

 

 

 - inf

 

a2A

h(a) - inf

a2A

   

0 (a)�

0

0

: (71)

h

   

   

0 (a)�

   

- sup

a2A

h(a) - h

Let Q be any probability measure on the space P of probability measures on X - Y . Let H

1

; H

1 2

be two elements of H - with corresponding hypothesis spaces Gl Æ f1 ; Gl Æ f2 <sup>.</sup> <sup>Then,</sup>

- with corresponding hypothesis spaces Gl

Æ f

; G

Æ f

2 <sup>.</sup> <sup>Then,</sup>

l

l

1

  

; H2 ) =

  

  

Z

P

Z

P

Z

P

 

 

 

 

inf

g 2G

(x; y ) - g Æ f

erP

l

jerP

(g Æ f1

(g Æ f

) - inf

g 2G

erP

     

     

(g Æ f2 )��

dQ

  

(H1

1

dQ(P )

sup

g 2Gl

Z

) - er

P

l

(g Æ f2 )j dQ(P ) (by (71) above)

1

jg Æ f

(x; y )j dP (x; y ) dQ(P )

1

2

sup

g 2Gl

℄

= d[Q

X �Y

;G

(f1

; f

2

):

X �Y

l

The measurability of sup

The measurability of supGl g Æ f is guaranteed by the permissibility of H (Lemma 32 part 4, Ap

            -             
pendix D). From dQ (H ; H ) - d[Q ;G ℄ (f1 ; f2 ) we have,

G

l

2

(H

; H

) - d

(f

; f

) we have,

Q

1 ;

1

2

[Q

;G

℄

X �Y

 

l

) - N

"; F ; d[Q

 

N ("; H

; dQ

;Gl ℄

℄

; (72)

X �Y

which gives inequality (35).

189

BAXTER

**B.3** **Proof of Theorem 7**

In order to prove the bounds in Theorem 7 we have to apply Theorem 6 to the neural network
hypothesis space family of equation (39). In this case the structure is

k

G

�! [0; 1℄

 

R

F

�! R

d

where G = f(x1

; : : : ; xk

) 7! 

P

k

i=1

x

1

; : : : ; 

) 2 U g for some bounded

+ 

; 

k

i

i

0

: (�0

subset U of R

k
+1 and some Lipschitz squashing function - . The feature class F : R

d

k

! R

is the set of all one hidden layer neural networks with d inputs, l hidden nodes, k outputs, - as
the squashing function and weights w 2 T where T is a bounded subset of R W . The Lipschitz

the squashing function and weights w 2 T where T is a bounded subset of R W . The Lipschitz

restriction on - and the bounded restrictions on the weights ensure that F and G are Lipschitz

0 0

classes. Hence there exists b < 1 such that for all f 2 F and x; x 2 R d, kf (x) - f (x )k <

0 0 0 0

bkx - x k and for all g 2 G and x; x 2 R k, jg (x) - g (x )j < bkx - x k where k - k is the L1 <sup>norm</sup>

in each case. The loss function is squared loss.

0

0

2 R

0

d, kf (x) - f (x

)k <

0 0

k and for all g 2 G and x; x

0

0

0

k, jg (x) - g (x

0

0

0

k where k - k is the L

bkx - x

2 R

)j < bkx - x

Now, gl

0

(x; y ) = l (g (x); y ) = (g (x) - y )2, hence for all g ; g

0

2, hence for all g ; g

0

2 G and all probability measures

P on R

k

 - [0; 1℄ (recall that we assumed the output space Y was [0; 1℄ ),

Z

0

 

2 

g (v ) - g

2

dP (v ; y )

d

0

; gl ) =

 - 2

- (g (v ) - y )

P

(gl

k

 

�(g (v ) - y )2

       

0       

R

Z

�[0;1℄

  

  

(v )

dPR

k (v ); (73)

Rk

where P

k derived from P . Similarly, for all f ; f

0

where PRk is the marginal distribution on R k derived from P . Similarly, for all f ; f 2 F and

d

probability measures P on R - [0; 1℄,

0

R

k is the marginal distribution on R

- [0; 1℄,

d

kf (x) - f

   

Z

Rd

0

1

(x)k dP

d[P ;G

℄ (f ; f

 

0

) - 2b

  

1

(x): (74)

l ℄

Define

Rd

;

C

"; G ; L

:= sup

P

N

"; G ; L

(P )

where the supremum is over all probability measures on (the Borel subsets of) R k, and

(P )

(P ) metric. Similarly set,

1

1

is the size of the smallest " -cover of G under the L (

is the size of the smallest " -cover of G under the L

N

"; G ; L

 

:= sup

P

  

(P )

;

1

1

C

"; F ; L

N

1

"; F ; L

where now the supremum is over all probability measures on R d . Equations (73) and (74) imply

(75)

C ("; G

) - C

"

2

1

; G ; L

"

2b

   

1

; F ; L (76)

 

CGl

l

( "; F ) - C

Applying Theorem 11 from Haussler (1992), we find

                    

C

 

C

"

2

"

2b

; F ; L

; Gl

1

; L

1

2eb

"

2

2eb

"

:

2k +2

�2W

Substituting these two expressions into (75) and (76) and applying Theorem 6 yields Theorem
7.

190

A MODEL OF INDUCTIVE BIAS LEARNING

**Appendix C.** **Proof of Theorem 14**

This proof follows a similar argument to the one presented in Anthony and Bartlett (1999) for
ordinary Boolean function learning.

First we need a technical Lemma.

**Lemma 30.** _Let_ - _be_ _a_ _random_ _variable_ _uniformly_ _distributed_ _on_ f1=2 + - =2; 1=2 - - =2g _,_ _with_

0 < - < 1 _._ _Let_ �1

�m <sup>_be i.i.d._</sup> f1; �1g _-valued_ _random variables_ _with_ Pr(�i

; : : : ; 

i

= 1) = - _for all_

:

n

i _._ _For any function_ f _mapping_ f1; �1g

! f1=2 + - =2; 1=2 - - =2g _,_

" q

1

#

m�

2

2

1��

Pr f �1

; : : : ; �m

: f (�1

; : : : ; 

m

) 6= �g 

1 

1 - e

4

_Proof._ Let N (� ) denote the number of occurences of +1 in the random sequence - = (�

_Proof._ Let N (� ) denote the number of occurences of +1 in the random sequence - = (�1 ; : : : ; �m ) .

The function f can be viewed as a decision rule, i.e. based on the observations -, f tries to guess
whether the probability of +1 is 1=2 + - =2 or 1=2 - - =2 . The optimal decision rule is the Bayes
estimator: f (�1 ; : : : ; �m ) = 1=2 + - =2 if N (� ) - m=2, and f (�1 ; : : : ; �m ) = 1=2 - - =2 otherwise.

Hence,

; : : : ; 

1

m

; : : : ; 

) = 1=2 + - =2 if N (� ) - m=2, and f (�

; : : : ; 

1

m

1

m

2

 

 - 1

�� =

 

2

   

m 

   

+

Pr ( f (� ) 6= �) 

    

1

2

1

2

Pr

+

Pr

1

2

N (� ) 

 

N (� ) 

m

2

Pr

N (� ) <

     

m  

     

 

2

2

 - =

1

2

1

2

2

 - =

 

2

which is half the probability that a binomial (m; 1=2 - - =2) random variable is at least m=2 . By
Slud’s inequality (Slud, 1977),

s !

2

1

Pr (f (� ) 6= �) 

2

Pr

Z 

m�

2

1 - 

where Z is normal (0; 1) . Tate’s inequality (Tate, 1953) states that for all x - 0,

h

i

p

1

Pr ( Z - x) 

2

:

1 

�x2

1 - e

Combining the last two inequalities completes the proof.

(n;m) be shattered by H, with m = d

Let x 2 X (n;m) be shattered by H, with m = d H (n) . For each row i in x let Pi <sup>be the set of</sup>

all 2d distributions P on X - f�1g such that P (x; 1) = P (x; 0) = 0 if x is not contained in the

Let x 2 X

H

(n) . For each row i in x let P

d distributions P on X - f�1g such that P (x; 1) = P (x; 0) = 0 if x is not contained in the

i th row of x, and for each j = 1; : : : ; d

; 1) = (1 - - )=(2d

(n)) and P (xij

(n)) and P (x

; �1) =

H

(n), P (xij

(n), P (x

H

- - )=(2d H (n)) . Let P := P1 - - - - - Pn <sup>.</sup>

Note that for P = (P1 ; : : : ; Pn ) 2 P

(1 - - )=(2d

- - - - - P

H

(n)) . Let P := P

1

; : : : ; P

) 2 P, the optimal error opt

( H

n

) is achieved by any sequence

1

n

H

P

(xij ; 1) = (1 + - )=(2d

   

= (h1

n

i

n

h

; : : : ; h

       
) such that h

(xij

) = 1 if and only if Pi

(n)), and H

always contains such a sequence because H shatters x . The optimal error is then

d

(n)

XH

j =1

n

X

i=1

2d

1 - 

n

) =

opt P

( H

) = erP

  

(h

1

n

Pi

fh

i

(x) 6= y g =

191

n

1 X

n

i=1

=

1 - 

2

;

(n)

H

) 6= h

and for any h = (h1 ;

and for any h = (h1

n

(h) = optP

; : : : ; h

) 2 H

n,

n

)g j : (77)

er

( H

) +

BAXTER

jf (i; j ) : h (x

(xij

P

i

ij

 

i (

nd

(n)

H

For any (n; m) -sample z, let each element mij <sup>in the array</sup>

m11

- - - m

1d

H

m(z) :=

... ... 1d ... H (n)

mn1

- - - mnd

H (n)

equal the number of occurrences of x

equal the number of occurrences of xij <sup>in</sup> z .

Now, if we select P = (P1 ; : : : ; Pn )

Now, if we select P = (P1 ; : : : ; Pn ) uniformly at random from P, and generate an (n; m)  
sample z using P, then for h = An (z) (the output of the learning algorithm) we have:

; : : : ; P

1

n

(z) (the output of the learning algorithm) we have:

n

n

X

i=1

ij

(xij

E ( jf (i; j ) : hi

(xij

   

) 6= hi

ij

(x

)g j) =

=

X

m

X

m

P (m)E ( jf (i; j ) : h

P (m)

(xij

(x

)g j j m)

i

   

) 6= hi (

d

(n)

XH

j =1

) 6= h

)jmij

)

P ( h(x

ij

where P (m) is the probability of generating a configuration m of the xij <sup>under the</sup> (n; m) -sampling

process and the sum is over all possible configurations. From Lemma 30,

r

2

3

5

m

2

ij

1��

P (h(x

) 6= h

  

) 

1

1

4

2

41 

X

XH

j =1

2

ij

hence

 

E

nd

1

H (n)

nd

d

(n)

;

2

1

41 

4

r

1  - e

3

5

m

ij

- 2

2

1��

jf (i; j ) : h

i (xij

) 6= h

(x

ij

(xij )

)g j

)jmij

j 

i

i

(n)

m

q

1  - e

n

X

P (m)

i=1

m�

 

#

2

d

(n)(1��

)

(78)

H

H

"

1

1  

4

1 - e

by Jensen’s inequality. Since for any [0; 1℄ -valued random variable Z, Pr(Z - x) - E Z - x, (78)
implies:

 

Pr

(x

jf(i; j ) : hi

"

1

q

1  - e

   

) 6= hi

(x

)gj - - 

#

m� 2

2

- (1 - - )�

ij

ij

nd

1

H (n)

where

d

(n)(1��

)

(79)

- :=

1 

4

and - 2 [0; 1℄ . Plugging this into (77) shows that

Pr f (P; z) : er

(An

(z)) - opt

( H

H

n

) + - �� g - (1 - - )�:

P

P

192

A MODEL OF INDUCTIVE BIAS LEARNING

Since the inequality holds over the random choice of P, it must also hold for some specific choice
of P . Hence for any learning algorithm An <sup>there is some sequence of distributions</sup> P such that

n

Pr fz : er

(An

(z)) - opt

( H

) + - �� g - (1 - - )�:

P

Setting

ensures

P

(1 - - )� - Æ; and - �� - "; (80)

Pr f z : er

Assuming equality in (80), we get

(A

(z)) - opt

( H

"

Æ

n

) + "g  - Æ: (81)

P

1 - 

 

:

- =

n

Æ

1 - 

P

; - =

Solving (79) for m, and substituting the above expressions for - and - shows that (81) is satisfied
provided

"

 

�2

�2

#

- 1

 

1 - 

2

(1  -  - ) (82)

8Æ (1 - - - 2Æ )

m - d H

(n)

Æ

"

log

Setting - = 1 - aÆ for some a - 4 ( a - 4 since - < 1=4 and - = Æ =(1 - - ) ), and assuming

"; Æ - 1=(k a) for some k - 2, (82) becomes

 

2

k

log

d H

(n)

2

1 

m 

2

a

: (83)

8(a - 2)

a

Subject to the constraint a - 4, the right hand side of (83) is approximately maximized at a =

8:7966, at which point the value exceeds d

1=9k and

m         

then

2

(n)(1 - 2=k )=(220"

H

d

(n)

) . Thus, for all k - 1, if "; Æ 

; (84)

n

) + "g  - Æ:

1 

2

2

k

H

220"

Pr f z : er

(A

n (z)) - opt

( H

P

P

To obtain the Æ -dependence in Theorem 14 observe that by assumption H 1 contains at least two

functions h1 ; h2 <sup>, hence there exists an</sup> x 2 X such that h1 (x) 6= h2 (x) . Let P - be two distributions

                -                 
concentrated on (x; 1) and (x; �1) such that P (x; h1 (x)) = (1 - ")=2 and P (x; h2 (x)) =

To obtain the Æ -dependence in Theorem 14 observe that by assumption H

; h

(x) 6= h

(x) . Let P

1

2 <sup>, hence there exists an</sup> x 2 X such that h1

1

2

(x; h

(x)) = (1 - ")=2 and P

(x; h

(x)) =

1

2

(1 - ")=2 . Let P

+

+

- be the product distributions on

:= P

- - - - - P

- - - - - P

); h

) n generated by P

-, and h

+ and P

(X - f�1g)

:= (h

:= P

; : : : ; h

:= (h

; : : : ; h

) . Note that h

1 1 1 2 2 2 2

are both in H n . If P is one of P� and the learning algorithm An <sup>chooses the wrong hypothesis</sup> h,

then

1

1

1

2

2

2

h
1 <sup>and</sup>

n . If P is one of P

- and the learning algorithm A

erP

(h) - optP ( H

193

n

) = ":

BAXTER

Now, if we choose P uniformly at random from fP

+                  
Now, if we choose P uniformly at random from fP ; P g and generate an (n; m) -sample z ac
cording to P, Lemma 30 shows that

+

; P

"

#

q

nm"2

1�"2

n

1 - e

Prf(P; z) : erP

which is at least Æ if

(An (z)) - optP

2

( H

1

) + "g 

1

4

1 

;

n

m <

1 - "

2

"

log

1 (85)

8Æ (1 - 2Æ )

provided 0 < Æ < 1=4 . Combining the two constraints on m : (84) (with k = 7 ) and (85), and using

maxfx1

; x

2

g 

1

2

(x1

+ x

2

) finishes the proof.

**Appendix D.** **Measurability**

In order for Theorems 2 and 18 to hold in full generality we had to impose a constraint called
“permissibility” on the hypothesis space family H . Permissibility was introduced by Pollard (1984)
for ordinary hypothesis classes H . His definition is very similar to Dudley’s “image admissible
Suslin” (Dudley, 1984). We will be extending this definition to cover hypothesis space families.

Throughout this section we assume all functions h map from (the complete separable metric
space) Z into [0; 1℄ . Let B (T ) denote the Borel - -algebra of any topological space T . As in Section
2.2, we view P, the set of all probability measures on Z, as a topological space by equipping it
with the topology of weak convergence. B (P ) is then the - -algebra generated by this topology. The
following two definitions are taken (with minor modifications) from Pollard (1984).

**Definition 8.** _A set_ H _of_ [0; 1℄ _-valued functions on_ Z _is_ indexed _by the set_ T _if there exists a function_

f : Z - T ! [0; 1℄ _such that_

H = f f (          - ; t) : t 2 T g :

**Definition 9.** _The set_ H _is_ permissible _if it can be indexed by a set_ T _such that_

_1._ T _is an analytic subset of a Polish_ <sup>7</sup> _space_ T _, and_

_2._ _the_ _function_ f : Z  - T ! [0; 1℄ _indexing_ H _by_ T _is_ _measurable_ _with respect_ _to_ _the_ _product_

  - _-algebra_ B (Z )   - B (T ) _._

An analytic subset T of a Polish space T is simply the continuous image of a Borel subset X
of another Polish space X . The analytic subsets of a Polish space include the Borel sets. They
are important because projections of analytic sets are analytic, and can be measured in a complete
measure space whereas projections of Borel sets are not necessarily Borel, and hence cannot be
measured with a Borel measure. For more details see Dudley (1989), section 13.2.

**Lemma 31.** H1

_Proof._ Omitted.

; : : : ; H

n <sup>_are all permissible._</sup>

n

- - - - - Hn : (X - Y )

! [0; 1℄ _is permissible if_ H1

We now define permissibility of hypothesis space families.

7. A topological space is called _Polish_ if it is metrizable such that it is a complete separable metric space.

194

A MODEL OF INDUCTIVE BIAS LEARNING

**Definition 10.** _A hypothesis_ _space family_ H = fH g _is_ permissible _if there_ _exist sets_ S _and_ T _that_
_are analytic subsets of Polish spaces_ S _and_ T _respectively,_ _and a function_ f : Z - T - S ! [0; 1℄ _,_
_measurable with respect to_ S - B (T ) - B (S ) _, such that_

:

H =

ff ( - ; t; s) : t 2 T g : s 2 S

Let (X ; �; �) be a measure space and T be an analytic subset of a Polish space. Let A(X )
denote the analytic subsets of X . The following three facts about analytic sets are taken from
Pollard (1984), appendix C.

(a) If (X ; �; �) is complete then A(X )  -  - .

(b) A(X  - T ) contains the product  - -algebra  -  - B (T ) .

(c) For any set Y in A(X - T ), the projection �X

Y of Y onto X is in A(X ) .

Recall Definition 2 for the definition of H   - . In the following Lemma we assume that (Z ; B (Z ))

has been completed with respect to any probability measure P, and also that (P ; B (P )) is complete
with respect to the environmental measure Q .

**Lemma 32.** _For any permissible hypothesis space family_ H _,_

_1._ H

n

l <sup>_is permissible._</sup>

_2._ fh 2 H : H 2 H g _is permissible._

_3._ H _is permissible for all_ H 2 H _._

_4._ supH <sup>_and_</sup> inf

H <sup>_are measurable for all_</sup> H 2 H _._

_5._ H

_6._ H

- _is measurable for all_ H 2 H _._

- _is permissible._

_Proof._ As we have absorbed the loss function into the hypotheses h, H

n

l <sup>is</sup> <sup>simply</sup> <sup>the</sup> <sup>set</sup> <sup>of</sup> <sup>all</sup>

n -fold products H - - - - - H such that H 2 H . Thus (1) follows from Lemma 31. (2) and (3)
are immediate from the definitions. As H is permissible for all H 2 H, (4) can be proved by an
identical argument to that used in the “Measurable Suprema” section of Pollard (1984), appendix
C.

For (5), note that for any Borel-measurable R h : Z ! [0; 1℄, the function h : P ! [0; 1℄ defined
by h(P ) := h(z ) dP (z ) is Borel measurable Kechris (1995, chapter 17). Now, permissibility of

R

h(z ) dP (z ) is Borel measurable Kechris (1995, chapter 17). Now, permissibility of

Z

H automatically implies permissibility of H := fh : h 2 H g, and H

                                    
H automatically implies permissibility of H := fh : h 2 H g, and H = inf H <sup>so</sup> H - is measurable

by (4).

Now let H be indexed by f : Z  - T  - S !R [0; 1℄ in the appropriate way. To prove (6),
define g : P - T - S ! [0; 1℄ by g (P ; t; s) := Z f (z ; t; s) dP (z ) . By Fubini’s theorem g is a

B (P ) - B (T ) - B (S ) -measurable function. Let G : P - S ! [0; 1℄ be defined by G(P ; s) :=

inf t2T g (P ; t; s) . G indexes H - in the appropriate way for H - to be permissible, provided it can

be shown that G is B (P ) - B (S ) -measurable. This is where analyticity becomes important. Let

= inf

H
H <sup>so</sup>

R

f (z ; t; s) dP (z ) . By Fubini’s theorem g is a

- in the appropriate way for H

inf

t2T

g (P ; t; s) . G indexes H

g� := f(P ; t; s) : g (P ; t; s) - �g . By property (b) of analytic sets, A (P - T - S ) contains g� <sup>.</sup>

The set G� := f(P ; s) : G(P ; s) - �g is the projection of g� <sup>onto</sup> P - S, which by property (c) is

g

:= f(P ; t; s) : g (P ; t; s) - �g . By property (b) of analytic sets, A (P - T - S ) contains g

The set G� := f(P ; s) : G(P ; s) - �g is the projection of g� <sup>onto</sup> P - S, which by property (c) is

also analytic. As (P ; B (P ); Q) is assumed complete, G� <sup>is measurable, by property (a).</sup> <sup>Thus</sup> G is

a measurable function and the permissibility of H - follows.

:= f(P ; s) : G(P ; s) - �g is the projection of g

- follows.

195

BAXTER

**References**

Abu-Mostafa, Y. (1993). A method for learning from hints. In Hanson, S. J., Cowan, J. D., & Giles,

C. L. (Eds.), _Advances_ _in_ _Neural_ _Information_ _Processing_ _Systems_ _5_, pp. 73–80 San Mateo,
CA. Morgan Kaufmann.

Anthony, M., & Bartlett, P. L. (1999). _Neural Network Learning:_ _Theoretical_ _Foundations_ . Cam
bridge University Press, Cambridge, UK.

Bartlett, P. L. (1993). Lower bounds on the VC-dimension of multi-layer threshold networks. In

_Proccedings_ _of_ _the_ _Sixth_ _ACM_ _Conference_ _on_ _Computational_ _Learning_ _Theory_, pp. 44–150
New York. ACM Press. Summary appeared in Neural Computation, 5, no. 3.

Bartlett, P. L. (1998). The sample complexity of pattern classification with neural networks: the

size of the weights is more important than the size of the network. _IEEE_ _Transactions_ _on_
_Information Theory_, _44_ (2), 525–536.

Baxter, J. (1995a). _Learning_ _Internal_ _Representations_ . Ph.D. thesis, Department of Mathematics and Statistics, The Flinders University of South Australia. Copy available from
http://wwwsyseng.anu.edu.au/    - jon/papers/thesis.ps.gz.

Baxter, J. (1995b). Learning internal representations. In _Proceedings_ _of_ _the_ _Eighth_ _International_

_Conference_ _on_ _Computational_ _Learning_ _Theory_, pp. 311–320. ACM Press. Copy available
from http://wwwsyseng.anu.edu.au/    - jon/papers/colt95.ps.gz.

Baxter, J. (1997a). A Bayesian/information theoretic model of learning to learn via multiple task

sampling. _Machine Learning_, _28_, 7–40.

Baxter, J. (1997b). The canonical distortion measure for vector quantization and function approx
imation. In _Proceedings_ _of_ _the_ _Fourteenth_ _International_ _Conference_ _on_ _Machine_ _Learning_,
pp. 39–47. Morgan Kaufmann.

Baxter, J., & Bartlett, P. L. (1998). The canonical distortion measure in feature space and 1-NN

classification. In _Advances in Neural Information Processing Systems 10_, pp. 245–251. MIT
Press.

Berger, J. O. (1985). _Statistical_ _Decision_ _Theory_ _and_ _Bayesian_ _Analysis_ . Springer-Verlag, New

York.

Blumer, A., Ehrenfeucht, A., Haussler, D., & Warmuth, M. K. (1989). Learnability and the vapnik
chervonenkis dimension. _Journal of the ACM_, _36_, 929–965.

Caruana, R. (1997). Multitask learning. _Machine Learning_, _28_, 41–70.

Devroye, L., Gy¨orfi, L., & Lugosi, G. (1996). _A_ _Probabilistic_ _Theory_ _of_ _Pattern_ _Recognition_ .
Springer, New York.

Dudley, R. M. (1984). _A Course on Empirical Processes_, Vol. 1097 of _Lecture Notes in Mathemat-_

_ics_, pp. 2–142. Springer-Verlag.

Dudley, R. M. (1989). _Real Analysis and Probability_ . Wadsworth & Brooks/Cole, California.

196

A MODEL OF INDUCTIVE BIAS LEARNING

Gelman, A., Carlin, J. B., Stern, H. S., & Rubim, D. B. (Eds.). (1995). _Bayesian_ _Data_ _Analysis_ .

Chapman and Hall.

Good, I. J. (1980). Some history of the hierarchical Bayesian methodology. In Bernardo, J. M.,

Groot, M. H. D., Lindley, D. V., & Smith, A. F. M. (Eds.), _Bayesian_ _Statistics_ _II_ . University
Press, Valencia.

Haussler, D. (1992). Decision theoretic generalizations of the pac model for neural net and other

learning applications. _Information and Computation_, _100_, 78–150.

Heskes, T. (1998). Solving a huge number of similar tasks: a combination of multi-task learning and

a hierarchical Bayesian approach. In Shavlik, J. (Ed.), _Proceedings of the 15th International_
_Conference on Machine Learning (ICML ’98)_, pp. 233–241. Morgan Kaufmann.

Intrator, N., & Edelman, S. (1996). How to make a low-dimensional representation suitable for

diverse tasks. _Connection Science_, _8_ .

Kechris, A. S. (1995). _Classical Descriptive Set Theory_ . Springer-Verlag, New York.

Khan, K., Muggleton, S., & Parson, R. (1998). Repeat learning using predicate invention. In Page,

C. D. (Ed.), _Proceedings of the 8th International Workshop on Inductive Logic Programming_
_(ILP-98)_, LNAI 1446, pp. 65–174. Springer-Verlag.

Langford, J. C. (1999). Staged learning. Tech. rep., CMU, School of Computer Science.
http://www.cs.cmu.edu/    - jcl/research/ltol/staged latest.ps.

Mitchell, T. M. (1991). The need for biases in learning generalisations. In Dietterich, T. G., &

Shavlik, J. (Eds.), _Readings in Machine Learning_ . Morgan Kaufmann.

Parthasarathy, K. R. (1967). _Probabiliity Measures on Metric Spaces_ . Academic Press, London.

Pollard, D. (1984). _Convergence of Stochastic Processes_ . Springer-Verlag, New York.

Pratt, L. Y. (1992). Discriminability-based transfer between neural networks. In Hanson, S. J.,

Cowan, J. D., & Giles, C. L. (Eds.), _Advances_ _in Neural_ _Information_ _Processing_ _Systems_ _5_,
pp. 204–211. Morgan Kaufmann.

Rendell, L., Seshu, R., & Tcheng, D. (1987). Layered concept learning and dynamically-variable

bias management. In _Proceedings_ _of_ _the_ _Tenth_ _International_ _Joint_ _Conference_ _on_ _Artificial_
_Intelligence (IJCAI ’87)_, pp. 308–314. IJCAI, Inc.

Ring, M. B. (1995). _Continual Learning in Reinforcement Environments_ . R. Oldenbourg Verlag.

Russell, S. (1989). _The Use of Knowledge in Analogy and Induction_ . Morgan Kaufmann.

Sauer, N. (1972). On the density of families of sets. _Journal_ _of_ _Combinatorial_ _Theory_ _A_, _13_,
145–168.

Sharkey, N. E., & Sharkey, A. J. C. (1993). Adaptive generalisation and the transfer of knowledge.

_Artificial Intelligence Review_, _7_, 313–328.

197

BAXTER

Silver, D. L., & Mercer, R. E. (1996). The parallel transfer of task knowledge using dynamic
learning rates based on a measure of relatedness. _Connection Science_, _8_, 277–294.

Singh, S. (1992). Transfer of learning by composing solutions of elemental sequential tasks. _Ma-_

_chine Learning_, _8_, 323–339.

Slud, E. (1977). Distribution inequalities for the binomial law. _Annals of Probability_, _4_, 404–412.

Suddarth, S. C., & Holden, A. D. C. (1991). Symolic-neural systems and the use of hints in devel
oping complex systems. _International Journal of Man-Machine Studies_, _35_, 291–311.

Suddarth, S. C., & Kergosien, Y. L. (1990). Rule-injection hints as a means of improving net
work performance and learning time. In _Proceedings_ _of_ _the_ _EURASIP Workshop_ _on_ _Neural_
_Networks_ Portugal. EURASIP.

Sutton, R. (1992). Adapting bias by gradient descent: An incremental version of delta-bar-delta. In

_Proceedings_ _of_ _the_ _Tenth_ _National_ _Conference_ _on_ _Artificial_ _Intelligence_, pp. 171–176. MIT
Press.

Tate, R. F. (1953). On a double inequality of the normal distribution. _Annals_ _of_ _Mathematical_

_Statistics_, _24_, 132–134.

Thrun, S. (1996). Is learning the n-th thing any easier than learning the first?. In _Advances in Neural_

_Information Processing Systems 8_, pp. 640–646. MIT Press.

Thrun, S., & Mitchell, T. M. (1995). Learning one more thing. In _Proceedings of the International_

_Joint Conference on Artificial Intelligence_, pp. 1217–1223. Morgan Kaufmann.

Thrun, S., & O’Sullivan, J. (1996). Discovering structure in multiple learning tasks: The TC al
gorithm. In Saitta, L. (Ed.), _Proceedings_ _of_ _the_ _13th_ _International_ _Conference_ _on_ _Machine_
_Learning (ICML ’96)_, pp. 489–497. Morgen Kaufmann.

Thrun, S., & Pratt, L. (Eds.). (1997). _Learning to Learn_ . Kluwer Academic.

Thrun, S., & Schwartz, A. (1995). Finding structure in reinforcement learning. In Tesauro, G.,

Touretzky, D., & Leen, T. (Eds.), _Advances in Neural Information Processing Systems_, Vol. 7,
pp. 385–392. MIT Press.

Utgoff, P. E. (1986). Shift of bias for inductive concept learning. In _Machine Learning:_ _An Artificial_

_Intelligence Approach_, pp. 107–147. Morgan Kaufmann.

Valiant, L. G. (1984). A theory of the learnable. _Comm. ACM_, _27_, 1134–1142.

Vapnik, V. N. (1982). _Estimation of Dependences Based on Empirical Data_ . Springer-Verlag, New

York.

Vapnik, V. N. (1996). _The Nature of Statistical Learning Theory_ . Springer Verlag, New York.

198
