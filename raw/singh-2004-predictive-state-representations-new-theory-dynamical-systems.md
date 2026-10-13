# singh-2004-predictive-state-representations-new-theory-dynamical-systems

> Converted from `singh-2004-predictive-state-representations-new-theory-dynamical-systems.pdf` on 2026-10-13 via `pymupdf4llm`.
> Layout artefacts (broken equations, interleaved columns) are conversion noise, not the source.

---

512 SINGH ET AL. UAI 2004

##### **Predictive State Representations: A New Theory for Modeling** **Dynamical Systems**

**Satinder** **Singh** **Michael** **R.** **James**

Computer Science and Engineering

University of Michigan

Ann Arbor, MI 48109
_{_ baveja,mrjames,mrudary _}_ @umich.edu

**Matthew** **R.** **Rudary**

**Abstract**

Modeling dynamical systems, both for control purposes and to make predictions about
their behavior, is ubiquitous in science and
engineering. Predictive state representations
(PSRs) are a recently introduced class of
models for discrete-time dynamical systems.
The key idea behind PSRs and the closely
related OOMs (Jaeger’s observable operator
models) is to represent the state of the system as a set of predictions of observable
outcomes of experiments one can do in the
system. This makes PSRs rather different
from history-based models such as n <sup>_th_</sup> -order
Markov models and hidden-state-based models such as HMMs and POMDPs. We introduce an interesting construct, the systemdynamics matrix, and show how PSRs can be
derived simply from it. We also use this construct to show formally that PSRs are more
general than both n <sup>_th_</sup> -order Markov models
and HMMs/POMDPs. Finally, we discuss
the main difference between PSRs and OOMs
and conclude with directions for future work.

**1** **Introduction**

Modeling dynamical systems, both for control purposes and to make predictions about their behavior, is
ubiquitous in science and engineering. Different disciplines often develop different mathematical formalisms
for building models—differential equations in physics,
finite-automata in computer science, logic and graphical models in artificial intelligence (AI), sequential decision processes in operations research (OR); these are
but a few examples. Often the differences among the
formalisms are motivated by properties of the class of
dynamical systems of interest to the different fields. In
this paper, we are exclusively interested in the class of

general discrete-time, finite-observation, and stochastic dynamical systems. This class includes many of
the problems of interest to the AI subfields of machine
learning, reinforcement learning (RL), and planning.
At the heart of current research in these subfields are
hidden Markov models (HMMs) and their controlled
counterparts partially observable Markov decision processes (POMDPs). Recently, Littman, Sutton, and
Singh (2001) proposed a class of models called _pre-_
_dictive_ _state_ _representations_ (PSRs) as an alternative
to HMMs and POMDPs.

The key idea behind PSRs, and the closely related observable operator models or OOMs (Jaeger, 1997), is
to represent the state of the system as a set of predictions of observable outcomes of tests or experiments
one could do in the system. Thus, unlike hiddenstate-based POMDP models, PSRs are expressed entirely in terms of observable quantities. Learning PSR
models of dynamical systems from observation data
should therefore be easier and less prone to local minima problems than learning POMDP models from observation data (Shatkay & Kaelbling, 1997). At the
same time, PSRs do not have the severe limitations of
history-based _n_ <sup>_th_</sup> -order Markov models, another class
of models of dynamical systems based on purely observable quantities. Recent work on PSRs has begun
to theoretically and empirically explore these advantages (Singh, Littman, Jong, Pardoe, & Stone, 2003;
James & Singh, 2004).

In this paper we present a new and more comprehensive theory of PSRs than was available heretofore. The
original development of PSRs by Littman et al. (2001)
focused on their relationship to POMDPs and in particular showed how to convert a POMDP model to
a PSR model. Here we present a new mathematical construct, the system-dynamics matrix ( _D_ ), that
can be used to describe any controlled or uncontrolled
dynamical system. This matrix _D_ is not a model of
the system but should be viewed as the system itself.
We define the _linear_ _dimension_ of a dynamical sys

UAI 2004 SINGH ET AL. 513

tem as the rank of its system-dynamics matrix. We
use _D_ to re-derive predictive state representations in a
more general way than the derivation in Littman et al.
(2001). We prove that dynamical systems with linear
dimension _n_ can always be modeled by PSRs of size _n_
but that there exist such systems that cannot be modeled by any finite HMM/POMDP and any finite-order
Markov model. Finally, we discuss the relationship between PSRs and the earlier work on OOMs by Jaeger
(1997).

**2** **The** **System-Dynamics** **Matrix**

An uncontrolled dynamical system can be viewed abstractly as a generator of observations. At time step
_i_, it produces an observation _oi_ from some set _O_ . The
system itself can be viewed as a probability distribution over all possible futures of all lengths. A future is just a sequence of observations from the beginning of time. The prediction of a length- _k_ future _t_ = _o_ <sup>1</sup> _o_ <sup>2</sup> _. . . o_ <sup>_k_</sup>, denoted _p_ ( _t_ ), is the probability that the first _k_ observations are precisely _t_, i.e.,
_p_ ( _t_ ) = _prob_ ( _o_ 1 = _o_ <sup>1</sup> _, . . ., ok_ = _o_ <sup>_k_</sup> ) where _oi_ is the actual observation at time step _i_ . A controlled dynamical system, on the other hand, takes inputs from some
set _A_ and generates observations from set _O_ . Thus a
future in a controlled system is a sequence of actionobservation pairs from the beginning of time. Again
the system itself can be viewed as a probability distribution over all possible futures, but in this case conditional on the actions input to the system. Accordingly,
a prediction for a length- _k_ future _t_ = _a_ <sup>1</sup> _o_ <sup>1</sup> _· · · a_ <sup>_k_</sup> _o_ <sup>_k_</sup>

is the probability that the first _k_ observations are

_o_ <sup>1</sup> _· · · o_ <sup>_k_</sup> given that the first _k_ actions are _a_ <sup>1</sup> _· · · a_ <sup>_k_</sup>, i.e.,
_p_ ( _t_ ) = _prob_ ( _o_ 1 = _o_ <sup>1</sup> _, . . . ok_ = _o_ <sup>_k_</sup> _|a_ 1 = _a_ <sup>1</sup> _, . . . ak_ = _a_ <sup>_k_</sup> ),
where _ai_ is the actual action at time step _i_ . In controlled systems it is convenient to think of futures as
_tests_ or experiments one can do on the system. Thus,
for test _t_ the prediction _p_ ( _t_ ) is the probability of that
test succeeding, i.e., of observing _t_ ’s sequence of observations upon doing _t_ ’s sequence of actions. Hereafter,
we will refer to futures as tests for both controlled and
uncontrolled systems.

Given an ordering over all possible tests _t_ 1 _t_ 2 _. . ._, the
system’s probability distribution over all tests, defines
an infinite _system-dynamics_ _vector_ _d_, such that the
_i_ <sup>_th_</sup> element of _d_ is the prediction of the _i_ <sup>_th_</sup> test in
the ordering, i.e., _di_ = _p_ ( _ti_ ). Throughout, we will assume that the tests are arranged in order of increasing
length and within the same length in lexicographic order. Figure 1a presents a pictorial view of the vector
_d_ . The predictions in _d_ have the following properties,
illustrated in Figure 1b:

_•_ _∀i_ 0 _≤_ _di_ _≤_ 1

a)

tests of length 1 tests of length 2

t

t

Figure 1: a) Each of _d_ ’s entries corresponds to the
prediction of a test. b) Properties of the predictions
imply structure in _d_ .

_•_ Let _T_ (¯ _a_ ) be the set of tests whose action sequences
equal _a_ ¯. Then _∀k ∀a_ ¯ _∈A_ <sup>_k_</sup> _,_ <sup>�</sup> _t∈T_ (¯ _a_ ) <sup>_p_</sup> <sup>(</sup> <sup>_t_</sup> <sup>) = 1</sup>

_•_ _∀t ∀a ∈A,_ _p_ ( _t_ ) = <sup>�</sup> _o∈O_ <sup>_p_</sup> <sup>(</sup> <sup>_tao_</sup> <sup>)</sup> <sup>_._</sup>

These properties imply that the infinite systemdynamics vector _d_ has a good deal of structure. One
way to make this structure explicit is to consider a matrix, _D_, whose columns correspond to tests and whose
rows correspond to histories (see Figure 2). In an uncontrolled system a _history_ is the sequence of observations from the beginning of time while in a controlled
system a history is the sequence of action-observation
pairs from the beginning of time. The interpretation is
that a history is a future or test that has already happened. We define a history-conditional prediction for a
test _t_ = _a_ <sup>1</sup> _o_ <sup>1</sup> _· · · a_ <sup>_k_</sup> _o_ <sup>_k_</sup> given a history _h_ = _a_ 1 _o_ 1 _· · · ajoj_,
as _p_ ( _t|h_ ) = _prob_ ( _oj_ +1 = _o_ <sup>1</sup> _, . . ., oj_ + _k_ = _o_ <sup>_k_</sup> _|h, aj_ +1 =
_a_ <sup>1</sup> _, . . ., aj_ + _k_ = _a_ <sup>_k_</sup> ). The history-conditional prediction
in the uncontrolled case can be defined analogously.
We define an ordering over histories _h_ 1 _h_ 2 _. . ._ similar
to the ordering over tests, though we include the zerolength or _initial_ history, _φ_, as the first history in the
ordering. Then

_Dij_ = _p_ ( _tj|hi_ ) = <sup>_<u>p</u>_</sup> <sup><u>(</u></sup> <sup>_<u>hitj</u>_</sup> <sup><u>)</u></sup> (1)

_p_ ( _hi_ ) <sup>_,_</sup>

and each row of _D_ has the same properties as _d_ had. In
fact, the system-dynamics vector _d_ is the first row of
the matrix _D_ (see Figure 2). The matrix _D_ with its infinitely many rows and columns is uniquely determined
by the vector _d_ because both the numerator and the
denominator of the rightmost term in Equation 1 are
elements of _d_ . We call _D_ the _system-dynamics_ _matrix_ .

514 SINGH ET AL. UAI 2004

#### h = φ

# ... t ...

#### φ

#### h 2

#### h

Figure 2: The rows in the system-dynamics matrix
correspond to all possible histories (pasts), while the
columns correspond to all possible tests (futures). The
entries in the matrix are the predictions of tests given
histories.

Because uncontrolled systems can be viewed as special
cases of controlled systems in which there is only one
action available, we will develop and present our results below for the controlled case. All of our results
apply to the uncontrolled case unless noted otherwise.

**3** **Models**

We emphasize that the system-dynamics matrix is not
a model of the system; rather it is the system itself.
Indeed, we will use _D_ and dynamical system interchangeably. In other words, _D_ places no constraints
on the dynamical system at all other than our starting assumptions of discrete-time and finite actions and
observations; for example, there is no assumption of
stationarity of any sort. The matrix _D_ forms the basis
of our new theory of PSRs.

We begin by defining the concept of the _linear_ _dimen-_
_sion_ of a dynamical system as the _rank_ of its corresponding system-dynamics matrix. The linear dimension of a system is equal to the dimension of the system
as defined by Jaeger (1998) and, in the uncontrolled
case, the minimum effective degree of freedom as defined by Ito, Amari, and Kobayashi (1992). We will
show why the rank of _D_ corresponds to a linear rather
than nonlinear dimension later in this paper. But first,
we remark that the rank of _D_ is a measure of the complexity of the dynamical system and thus we should
expect that a model of the dynamical system should
have a complexity that is a function of the linear dimension.

Traditionally, a model of a dynamical system is something that can be used both as a simulator—to generate sequences of observations given sequences of

actions—and as a predictor—to maintain state and
make predictions about future behaviors while interacting with a system. In our context, an equivalent
definition is that a model is something that can generate the system-dynamics matrix exactly. Most models
are composed of the following pieces: a state representation that is a _sufficient_ _statistic_ of history, a specification of the initial state, and model parameters and
update function that together define how the model
updates the state as actions get taken and observations noted.

Before we derive a PSR model of a dynamical system from _D_, we consider the relationship between
_n_ <sup>_th_</sup> -order Markov models and _D_ and then between
HMMs/POMDPs and _D_ .

**3.1** **History-Based** **Models**

An _n_ <sup>_th_</sup> -order Markov model makes the assumption
that the next observation probabilities are conditionally independent of the history given the last _n_ actionobservation pairs. The state of such a system in history
_h_, denoted _s_ ( _h_ ), is represented by the length- _n_ suffix of
_h_ ; the initial state is the suffix that is equivalent to the
null history. There are _k_ = ( _|A||O|_ ) <sup>_n_</sup> possible states.
The parameters of this model are the _k|A||O|_ observation probabilities, arranged into _|A|_ matrices _{O_ <sup>_a_</sup> _}_,
where _Oij_ <sup>_a_</sup> <sup>=</sup> <sup>_prob_</sup> <sup>(</sup> <sup>_oj|s_</sup> <sup>(</sup> <sup>_hi_</sup> <sup>)</sup> <sup>_, a_</sup> <sup>).</sup> The state is main
tained simply; when a new action-observation pair is
observed, the state is updated to the length- _n_ suffix of
the new history.

Generating _D_ from this model is straightforward: using the chain rule, _p_ ( _a_ <sup>1</sup> _o_ <sup>1</sup> _· · · a_ <sup>_n_</sup> _o_ <sup>_n_</sup> _|h_ ) is given by computing _prob_ ( _o_ <sup>_n_</sup> _|ha_ <sup>1</sup> _o_ <sup>1</sup> _· · · a_ <sup>_n−_</sup> <sup>1</sup> _o_ <sup>_n−_</sup> <sup>1</sup> _a_ <sup>_n_</sup> ) _· · · prob_ ( _o_ <sup>1</sup> _|ha_ <sup>1</sup> ).
Each of the probabilities in the product is obtained directly from the parameter matrices _{O_ <sup>_a_</sup> _}_ by mapping
histories to states by using length- _n_ suffixes.

But how complex a dynamical system can be modeled
by a _n_ <sup>_th_</sup> -order Markov model? In other words, what is
the maximal rank of _D_ that can be generated by such
a model?

**Theorem** **1** _The_ _dynamical_ _system_ _corresponding_ _to_
_an_ _n_ <sup>_th_</sup> _-order_ _Markov_ _model_ _cannot_ _have_ _linear_ _dimen-_
_sion_ _greater_ _than_ _k_ = ( _|A||O|_ ) <sup>_n_</sup> _._

**Proof** Given that an _n_ <sup>_th_</sup> -order Markov model cannot distinguish between any two histories that have
the same length- _n_ suffix, it is clear that the _D_ matrix generated by such a model cannot have more than
_k_ = ( _|A||O|_ ) <sup>_n_</sup> unique rows, and thus has rank at most
_k_ . The rank and therefore the linear dimension of the
_D_ generated by such a model is at most _k_ . 

Later, we will show that there are systems with finite

UAI 2004 SINGH ET AL. 515

linear dimension that cannot be represented by an _n_ <sup>_th_</sup> order Markov model for any finite _n_ . Intuitively, this
is because a matrix with finite rank may have infinitely
many distinct rows. Taken together, these results show
the known fact that _n_ <sup>_th_</sup> -order Markov models are quite
limited in scope.

**3.2** **Models** **with** **Hidden** **States**

POMDPs/HMMs are models based on the notion of
underlying hidden or nominal states and directly address the limitations of history-based models. They
maintain state information by keeping track of the
probabilities of being in each of these nominal states
as a function of history. Thus, the state representation of a _k_ -state POMDP is a _k ×_ 1 belief state vector
_b_ ( _h_ ), where _bi_ ( _h_ ) is the probability that the system is
in nominal state _i_ given that history _h_ has been observed. The initial state is _b_ ( _φ_ ). The parameters of
this model are the transition probabilities of the underlying MDP (that describes the unseen dynamics of
the nominal states) and the observation probabilities;
that is, a set of _k × k_ stochastic matrices _{T_ <sup>_a_</sup> _}_, where
_Tij_ <sup>_a_</sup> <sup>is</sup> <sup>the</sup> <sup>probability</sup> <sup>of</sup> <sup>transitioning</sup> <sup>from</sup> <sup>nominal</sup>

state _i_ to nominal state _j_, and a set of _k_ _× k_ diagonal matrices _{O_ <sup>_ao_</sup> _}_ where _Oii_ <sup>_ao_</sup> <sup>is</sup> <sup>the</sup> <sup>probability</sup> <sup>of</sup>

observing _o_ while leaving state _i_ by means of action _a_ .
Note that _∀a_ <sup>�</sup> _o∈O_ <sup>_Oao_</sup> <sup>=</sup> <sup>_I_</sup> <sup>.</sup> <sup>The state is updated by</sup>

computing

_b_ <sup>_T_</sup> ( _hao_ ) = _b_ <sup>_<u>bTT</u>_</sup> ( <sup><u>(</u></sup> _h_ <sup>_<u>h</u>_</sup> ) <sup><u>)</u></sup> _T_ <sup>_<u>Ta a</u>_</sup> _O_ <sup>_<u>Oaoao</u>_</sup> **1** <sup>_,_</sup> (2)

**Proof** Let _p_ ( _t|si_ ) be the prediction for test _t_ generated by the POMDP for a belief state that assigns
probability 1 to the system being in nominal state _si_
(note that it need not be possible to manipulate the
system into such a belief state). Let _U_ be the ( _k × ∞_ )
matrix whose ( _ij_ ) <sup>_th_</sup> entry is _p_ ( _tj|si_ ). _U_ has _k_ rows,
and so it has rank no more than _k_ .

Now consider the _D_ matrix generated by the POMDP.
The row of _D_ corresponding to a history _h_ is simply
_b_ <sup>_T_</sup> ( _h_ ) _U_, where _b_ ( _h_ ) is the belief state after observing
_h_ . Thus _D_ may be generated by computing the matrix multiplication _BU_, where _B_ is a ( _∞× k_ ) matrix
with whose _i_ <sup>_th_</sup> row is the belief state corresponding
to history _hi_ (see Figure 3). Because both _B_ and _U_
have rank no more than _k_, _D_ has rank no more than
_k_ . Thus, no dynamical system that can be modeled
by a POMDP with _k_ nominal states may have a linear
dimension that is greater than _k_ .

               

Because an HMM is simply a POMDP with a single
action, we can use Theorem 2 to assert:

**Corollary** **3** _A_ _HMM_ _with_ _k_ _nominal_ _states_ _can-_
_not_ _model_ _a_ _dynamical_ _system_ _with_ _linear_ _dimension_
_greater_ _than_ _k._

Although POMDPs are more expressive than _n_ <sup>_th_</sup> order Markov models, there are dynamical systems
with finite linear dimension that cannot be modeled
by any finite POMDP. Jaeger (1998) presents an uncontrolled system that has a linear dimension of 3, but
that cannot be modeled by any finite HMM. We do not
repeat the construction here. And because all _n_ <sup>_th_</sup> order Markov models can be represented as POMDPs,
there are some dynamical systems with finite linear dimension that cannot be modeled by a finite POMDP
or an _n_ <sup>_th_</sup> -order Markov model for any finite _n_ .

**4** **Predictive** **State** **Representations**

We now derive PSR models directly from the systemdynamics matrix. For any _D_ with rank _k_, there must
exist _k_ linearly independent columns and rows; these
may not be unique. Consider any set of _k_ linearly
independent columns of _D_ and let the tests corresponding to those columns be _Q_ = _{q_ 1 _q_ 2 _· · · qk}_ . We
call the tests in _Q_ the _core_ _tests_ (see Figure 4). Let
the submatrix of _D_ that contains just the columns
for the core tests be denoted _D_ ( _Q_ ). The state representation of the PSR model is the set of predictions for the core tests. Thus, for any history _h_, the
state of the PSR model is given by the column vector
_p_ ( _Q|h_ ) = [ _p_ ( _q_ 1 _|h_ ) _p_ ( _q_ 2 _|h_ ) _· · · p_ ( _qk|h_ )]. The initial state
is _p_ ( _Q|φ_ ), the entries of the first row in _D_ ( _Q_ ).

where **1** is a _k ×_ 1 vector of all 1’s.

_D_ can be generated from a POMDP by generating each
test’s prediction as follows:

_p_ ( _a_ <sup>1</sup> _o_ <sup>1</sup> _· · · a_ <sup>_n_</sup> _o_ <sup>_n_</sup> _|h_ ) = _b_ ( _h_ ) _T_ <sup>_a_</sup> <sup>1</sup> _O_ <sup>_a_</sup> <sup>1</sup> <sup>_o_</sup> <sup>1</sup> _· · · T_ <sup>_an_</sup> _O_ <sup>_anon_</sup> **1**

Again, we ask what the linear dimension is of systems
that can be perfectly modeled by a POMDP.

**Theorem** **2** _A_ _POMDP_ _with_ _k_ _nominal_ _states_ _can-_
_not_ _model_ _a_ _dynamical_ _system_ _with_ _linear_ _dimension_
_greater_ _than_ _k._

k

s

T

s s

b (h )

T

s

T

b (h )

i

Figure 3: The system-dynamics matrix generated by
a POMDP model with _k_ nominal states is the product
of an _∞× k_ matrix ( _B_ ) and a _k × ∞_ matrix ( _U_ ).

516 SINGH ET AL. UAI 2004

h =
1

φ

<sup>h</sup> 2

h

i

|Q ={q t sts ...|q1 q ...|} qk ... t|
|---|---|---|
|1t<br>...||..<br>jt|
|_D(   )_<br>Q|_D(   )_<br>Q|_D(   )_<br>Q|

Figure 4: The core tests of a PSR are selected by finding _k_ linearly independent columns of _D_ .

Note that by the definition of rank of a matrix, all
the columns of _D_ are a linear combination of the
columns in _D_ ( _Q_ ). In fact, for every test _t_, there exists a weight vector of length _k_, _mt_, such that _D_ (t),
the column of _D_ corresponding to test _t_, is given by
_D_ ( _t_ ) = _D_ ( _Q_ ) _mt_ . This means that for any history _h_,
_p_ ( _t|h_ ) = _p_ <sup>_T_</sup> ( _Q|h_ ) _mt_ ; thus this PSR is called a _linear_
PSR. This allows us to compute a state update:

<sup><u>(</u></sup> <sup>_<u>aoqi|h</u>_</sup> <sup><u>)</u></sup>

_p_ ( _ao|h_ ) <sup>=</sup> <sup>_<u>p</u>_</sup> _p_ <sup>_TT_</sup> <sup><u>(</u></sup> ( <sup>_<u>Q</u>_</sup> _Q_ <sup>_<u>|h</u>_</sup> _|h_ <sup><u>)</u></sup> ) <sup>_<u>m</u>_</sup> _m_ <sup>_<u>aoq</u>_</sup> _ao_ <sup>_<u>i</u>_</sup>

_p_ ( _qi|hao_ ) = <sup>_<u>p</u>_</sup> <sup><u>(</u></sup> <sup>_<u>aoqi|h</u>_</sup> <sup><u>)</u></sup>

_p_ ( _ao|h_ )

_p_ <sup>_T_</sup> ( _Q|h_ ) _mao_

We can combine the entire update into a single equation by defining the matrices _Mao_, where the _j_ <sup>_th_</sup> column of _Mao_ is simply _maoqj_ ; then the update is given
by

_p_ <sup>_T_</sup> ( _Q|hao_ ) = <sup>_<u>pT</u>_</sup> <sup><u>(</u></sup> <sup>_<u>Q|h</u>_</sup> <sup><u>)</u></sup> <sup>_<u>Mao</u>_</sup>

_p_ <sup>_T_</sup> ( _Q|h_ ) _mao_

_._ (3)

**Lemma** **5** _A_ _linear_ _PSR_ _with_ _k_ _core_ _tests_ _can-_
_not_ _model_ _a_ _dynamical_ _system_ _with_ _linear_ _dimension_
_greater_ _than_ _k._

**Proof** In a PSR with _k_ core tests _Q_, the prediction for any test _t_ for a history _h_ is given by
_p_ ( _t|h_ ) = _p_ <sup>_T_</sup> ( _Q|h_ ) _mt_ for some weight vector _mt_ . Thus
in the _D_ matrix generated by the PSR, the column
corresponding to _t_, _D_ ( _t_ ), satisfies _D_ ( _t_ ) = _D_ ( _Q_ ) _mt_ .
Thus, each column of _D_ is a linear combination of the
_k_ columns corresponding to the core tests, and _D_ has
rank no more than _k_ . 

Thus, there is an equivalence between systems of finite linear dimension and systems that are modeled
by linear PSRs with a finite number of core tests.

**Theorem** **6** _Linear PSRs with k_ _core tests are equiv-_
_alent_ _to_ _dynamical_ _systems_ _with_ _linear_ _dimension_ _k._

**Proof** This follows from Lemmas 4 and 5. 

Why is it that linear PSRs can model a larger class of
dynamical systems than POMDPs? The main reason
is that the update parameters of a PSR (see Equation 3) are **not** constrained to be non-negative while
the update parameters of a POMDP (see Equation 2)
are constrained to be non-negative.

**5** **Nonlinear** **Models**

We defined the linear dimension of a dynamical system as the rank of the _D_ matrix because, as we showed
in deriving PSRs, there always exists a set of predictions of that size that allowed linear computation of
the prediction for any test. In this sense the linear
PSR state is a _linearly_ sufficient statistic of the history.
There may of course be a set of tests _N_ = _{n_ 1 _. . . nc}_
of size less than _|Q|_ whose predictions constitute a
nonlinear sufficient statistic, such that for all tests _t_,
_p_ ( _t|h_ ) = _ft_ ( _p_ ( _N_ _|h_ )) for some nonlinear function _ft_ .
Note that it is crucial that _ft_ is independent of _h_, or
else _p_ ( _N_ _|h_ ) won’t be a sufficient statistic. When such
a nonlinear sufficient statistic exists, a nonlinear PSR
can be defined with update function

Therefore the model parameters in a PSR are
_{maoq}a∈A,o∈O,q∈Q_ and _{mao}a∈A,o∈O_ . Note that the
model parameters may contain negative numbers in
them; this sets them apart from POMDP model parameters.

Finally, a PSR model generates _D_ as follows: for
any test _t_ = _a_ <sup>1</sup> _o_ <sup>1</sup> _· · · a_ <sup>_n_</sup> _o_ <sup>_n_</sup>, its weight vector _mt_ =
_Ma_ 1 _o_ 1 _· · · Man−_ 1 _on−_ 1 _manon_ (Littman et al., 2001) can
be computed from the model parameters and then
used to generate the column _D_ ( _t_ ).

**Lemma** **4** _A_ _dynamical_ _system_ _with_ _linear_ _dimen-_
_sion_ _k_ _can_ _be_ _modeled_ _by_ _a_ _linear_ _PSR_ _with_ _k_ _core_
_tests._

**Proof** This follows from the derivation of PSRs
from _D_ above. 

Because linear PSRs with _k_ core tests generate predictions for a test through a linear operation, they cannot
represent systems with linear dimension more than _k_ .

It is helpful to see an example system in which a nonlinear PSR models a system more compactly than a
linear PSR. Littman et al. (2001) created the floatreset problem, a POMDP with 5 states, illustrated in
Figure 5. There are two actions and two observations.
The float action moves to the state on the right or left
with equal probability, and always results in observing
0. The reset action moves to the state on the far right.

_p_ ( _ni|hao_ ) = <sup>_<u>p</u>_</sup> <sup><u>(</u></sup> <sup>_<u>aoni|h</u>_</sup> <sup><u>)</u></sup>

<sup>_<u>aoni</u>_</sup> <sup><u>(</u></sup> <sup>_<u>p</u>_</sup> <sup><u>(</u></sup> <sup>_<u>Q|h</u>_</sup> <sup><u>))</u></sup>

_fao_ ( _p_ ( _Q|h_ )) <sup>_._</sup>

<sup><u>(</u></sup> <sup>_<u>aoni|h</u>_</sup> <sup><u>)</u></sup> = <sup>_<u>faoni</u>_</sup> <sup><u>(</u></sup> <sup>_<u>p</u>_</sup> <sup><u>(</u></sup> <sup>_<u>Q|h</u>_</sup> <sup><u>))</u></sup>

_p_ ( _ao|h_ ) _fao_ ( _p_ ( _Q|h_ ))

UAI 2004 SINGH ET AL. 517

o=0

o=0

**6** **PSRs** **and** **OOMs**

So far we have shown that linear PSRs are more general than two currently popular models in AI, namely
_n_ <sup>_th_</sup> -order Markov models and POMDPs. In fact, PSRs
share many of their properties with Jaeger’s OOMs.
Jaeger (1998) has also developed many algorithms for
OOMs and thus it is critical to understand the relationship between OOMs and PSRs so that research in
PSRs can leverage existing work on OOMs correctly.
We provide a beginning to this understanding in this
paper.

Motivated by the fact that HMMs can be difficult to
learn from observations of a system, Jaeger (1997)
developed OOMs as an alternative model for uncontrolled dynamical systems. <sup>1</sup> Subsequently, he extended OOMs to Input/Output OOMs (IO-OOMs),
which model controlled dynamical systems (Jaeger,
1998). In addition, Jaeger presented two versions each
of OOMs and IO-OOMs: an uninterpretable version,
in which the state vector has no interpretation, and
an interpretable version, in which the elements of the
state vector can be interpreted as predictions for a special kind of test in the system. Uninterpretable OOMs
and IO-OOMs, while interesting, are not amenable to
learning algorithms and thus we will focus on the interpretable versions of these models.

**6.1** **Interpretable** **OOMs** **for** **Uncontrolled**
**Systems**

The state vector in an interpretable OOM for an uncontrolled system is the set of predictions for a special
set of tests. Consider all tests (as we defined them
for uncontrolled systems) of some fixed length _m_ and
partition them into _k_ subsets. Let each subset, so produced, be a union-test. The prediction of a union-test
is the sum of the predictions for the tests in the union.
Thus, for a given _m_ and _k_, the state vector for an
OOM is a _k_ -dimensional stochastic vector, i.e., for every history _h_ its state vector sums to one and each
entry in the state vector is a probability.

On the one hand, union-tests are more general than the
tests used in uncontrolled-PSRs because the former are
unions of the latter tests. On the other hand, uniontests are less general than uncontrolled-PSR tests because they all have to be of the same length. In any

1The notation used in this paper to describe OOMs departs somewhat from Jaeger’s in order to remain consistent
with the rest of the paper; instead of using _a_ for actions, he
uses _r_, and instead of _o_ for observations, he uses _a_ . In addition, we use the terms action and observation as opposed to
Jaeger’s terms input and output, and define interpretable
OOMs and IO-OOMs in terms of tests instead of in terms
of characteristic events.

Figure 5: The float-reset problem.

If the system was already in that state, this results in
an observation of 1; otherwise, the observation is 0.
The system always starts in the far-right state.

Any linear PSR that models this system has (at
least) 5 core tests. One such PSR has the core tests
_{r_ 1 _, f_ 0 _r_ 1 _, f_ 0 _f_ 0 _r_ 1 _, f_ 0 _f_ 0 _f_ 0 _r_ 1 _, f_ 0 _f_ 0 _f_ 0 _f_ 0 _r_ 1 _}_ . Initially,
and after a reset action, the predictions for these core
tests are [1 _,_ 0 _._ 5 _,_ 0 _._ 5 _,_ 0 _._ 375 _,_ 0 _._ 375]. After a float action, each prediction is shifted left one place, and the
last prediction is updated by _p_ ( _f_ 0 _f_ 0 _f_ 0 _f_ 0 _r_ 1 _|hf_ 0) =
0 _._ 0625 _p_ ( _r_ 1 _|h_ ) _−_ 0 _._ 0625 _p_ ( _f_ 0 _r_ 1 _|h_ ) _−_ 0 _._ 75 _p_ ( _f_ 0 _f_ 0 _r_ 1 _|h_ ) +
0 _._ 75 _p_ ( _f_ 0 _f_ 0 _f_ 0 _r_ 1 _|h_ ) + _p_ ( _f_ 0 _f_ 0 _f_ 0 _f_ 0 _r_ 1 _|h_ ).

A glance at the initial prediction vector suggests there
may be a pattern to the values that _p_ ( _r_ 1 _|h_ ) takes on.
In fact, this is borne out by continuing the series; after the first transition (from 1 to 0 _._ 5), _p_ ( _r_ 1 _|h_ ) takes on
the same value twice in a row as long as the float action is repeated. This twice-repeated value decreases
monotonically and so _p_ ( _r_ 1 _|h_ ) and _p_ ( _f_ 0 _r_ 1 _|h_ ) together
uniquely determine the index into this infinite series.
Therefore, one can always look up the new prediction
for _p_ ( _f_ 0 _r_ 1 _|h_ ) for a float action from the series. Even
though we have not shown the explicit nonlinear calculation underlying the series, this argument suffices
to show that the predictions for these two tests constitute a nonlinear sufficient statistic of the history.
Thus there exists a nonlinear PSR for float-reset with
the predictions for just two tests as state.

This can be taken further.

**Theorem** **7** _There_ _exist_ _systems_ _with_ _nonlinear_ _di-_
_mension exponentially smaller than their linear dimen-_
_sion._

**Proof** (Sketch) Rudary and Singh (2004) present
the rotate register system. This system is a _k_ -bit rotate register, but only the far-left bit is observable.
There are three actions: The register can be rotated
either to the left or the right, and the visible bit can
be “flipped” (i.e. changed from 0 to 1 or vice versa).
A POMDP that models this system requires 2 <sup>_k_</sup> states,
and a linear PSR requires 2 <sup>_k_</sup> core tests. However, a
nonlinear PSR can model this system using only _k_ + 1
core tests. Thus, there is a nonlinear dimension to this
system that is exponentially smaller than its linear dimension. See Rudary and Singh (2004) for details. 

518 SINGH ET AL. UAI 2004

case, OOM states are always stochastic vectors while
PSR states have no such constraint. Given these differences what is the relationship between OOMs and
uncontrolled PSRs?

**Theorem** **8** _OOMs,_ _both_ _interpretable_ _and_ _uninter-_
_pretable,_ _with_ _dimension_ _k_ _are_ _equivalent_ _to_ _uncon-_
_trolled_ _linear_ _PSRs_ _with_ _k_ _core_ _tests._

**Proof** A linear PSR with _k_ core tests can model
any system with linear dimension _≤_ _k_ . Jaeger (1998)
proved that _k_ -dimensional interpretable OOMs are
equivalent to _k_ -dimensional uninterpretable OOMs,
which in turn are equivalent to uncontrolled dynamical systems of linear dimension _k_ . Thus, any system
that can be modeled by an uncontrolled linear PSR
with _k_ core tests can be modeled by an interpretable
OOM of dimension _k_, and vice versa. 

So even though uncontrolled PSRs and interpretable
OOMs have slightly different forms for uncontrolled
dynamical systems, they are equivalent in power and
in fact we have developed efficient algorithms (we omit
these here for lack of space) for converting one to the
other. The result for controlled dynamical systems is
very different and we turn to that next.

**6.2** **Interpretable** **IO-OOMs** **for** **Controlled**
**Systems**

As with OOMs, the state in an interpretable IO-OOM
is a vector of predictions for a special set of tests. Consider all tests (as we defined them for controlled systems) of some fixed length _m_ that share a particular
action sequence _a_ ¯ of length _m_ . Partition this set of
tests into _k_ union-tests. The prediction of a uniontest is again the sum of the predictions for the tests
in the union. Thus, for a given _m_, _a_ ¯, and _k_, the state
vector for an interpretable IO-OOM is a _k_ -dimensional
stochastic vector. The interesting constraint in interpretable IO-OOMs is the requirement that all uniontests share the same action sequence _a_ ¯. This guarantees a stochastic vector as state but, as we will show
below, places a crucial limit on the ability of interpretable IO-OOMs to model general dynamical systems.

**Theorem** **9** _There_ _exist_ _controlled_ _dynamical_ _sys-_
_tems_ _with_ _finite_ _linear_ _dimension_ _that_ _cannot_ _be_ _mod-_
_eled_ _by_ _any_ _interpretable_ _IO-OOM_ _of_ _any_ _dimension._

**Proof** We prove this theorem by presenting such
a system. Figure 6 shows a POMDP with 4 nominal
states that cannot be modeled by any interpretable
IO-OOM. Recall (from Theorem 2) that any system
that can be modeled by a POMDP with _k_ states has

##### Action a

##### Action b

Figure 6: The POMDP representation of a system that
cannot be correctly represented by an interpretable
IO-OOM. The labels on the arcs are observations.

linear dimension _≤_ _k_, and so the POMDP in Figure 6
has a finite linear dimension.

The key property of this system is that predicting the
outcome of action _a_ will not differentiate between nominal states _s_ 2 and _s_ 3, while predicting the outcome of
action _b_ will not differentiate between _s_ 1 and _s_ 3.

State _s_ 0 is the initial nominal state of the system. Both
actions produce the same transitions: When in nominal state _s_ 0, the next nominal state is _s_ 1, _s_ 2, or _s_ 3
with equal probability. When in one of the other nominal states, the next nominal state is _s_ 0. When moving from _s_ 0, both actions cause the same observations
to be emitted: _oi_ when entering _si_ . However, when
moving back to nominal state _s_ 0, each action causes
different observations. The observation emitted when
moving to _s_ 0 from _s_ 1 using action _a_ is _o_ 4 and _o_ 0 otherwise; when action _b_ is executed, the observation is

_o_ 4 when leaving _s_ 2 and _o_ 0 otherwise.

It is easy to see that history provides enough information to determine the nominal state with certainty. At
times 0 _,_ 2 _,_ 4 _, . . ._, the system is in nominal state _s_ 0; the
observation emitted by the system identifies the next
nominal state. Since the observation emitted when returning to _s_ 0 is deterministic given the nominal state
and action, any complete model of the system should
predict perfectly the observations at times 1 _,_ 3 _,_ 5 _, . . ._ .

We now prove that no interpretable IO-OOM can
model this system. We start by showing that no interpretable IO-OOM with an input sequence of length
1 can model the system and complete the proof by
showing that no longer input sequence is sufficient.

Let us start with the input sequence _a_ ¯ = _a_ . There
are five observations, so there are five events that use
this as their action sequence. None of these events

UAI 2004 SINGH ET AL. 519

has a different probability when starting in _s_ 2 than it
does when starting in _s_ 3. Thus the state vector for an
interpretable IO-OOM with input sequence _a_ would
be the same when the system was in either of these
states, and would be unable to predict the observation
emitted when leaving those nominal states using action
_b_ .

Similarly, an interpretable IO-OOM with input sequence _a_ ¯ = _b_ would be unable to differentiate between
_s_ 1 and _s_ 3 and would not correctly predict the observation emitted when leaving those nominal states using
action _a_ .

Furthermore, no longer sequence is sufficient. Because
the system always returns to _s_ 0 on even time steps,
effectively resetting the system, knowing the behavior
of the system two time steps or more in advance does
not provide any information about the current state
of the system. Thus, no interpretable IO-OOM can
model this system. 

A corollary follows directly from Theorems 6 and 9:

**Corollary** **10** _There_ _exist_ _controlled_ _dynamical_ _sys-_
_tems_ _that_ _can_ _be_ _modeled_ _by_ _PSRs_ _that_ _cannot_ _be_ _mod-_
_eled_ _by_ _any_ _interpretable_ _IO-OOM;_ _PSRs_ _are_ _more_
_general_ _than_ _interpretable_ _IO-OOMs._

This severely limits the utility of IO-OOMs. Because
uninterpretable IO-OOMs are not verifiable in the
sense that they are not directly based on data produced by the system, it is difficult to infer them from
such data. In fact, the learning algorithm that Jaeger
(1998) presents for IO-OOMs only works for the interpretable version.

**7** **Conclusion** **and** **Future** **Work**

We have introduced the system-dynamics matrix, a
mathematical construct that provides an interesting
way of looking at discrete dynamical systems. Using
this matrix, we have re-derived PSRs in a very simple
way and showed that they are strictly more general
than both POMDPs and _n_ <sup>_th_</sup> -order Markov models.
The original formulation of PSRs by Littman et al.
(2001), though it resulted in exactly the same model as
this derivation, was arrived at through POMDPs and
was therefore more limited and complex. In addition,
we have shown that there exist dynamical systems with
nonlinear dimension that is exponentially smaller than
the linear dimension of those systems. Finally, we
have shown that in the case of uncontrolled dynamical systems, linear PSRs and interpretable OOMs are
equivalent, while in the case of controlled dynamical
systems, interpretable IO-OOMs are less general than
linear PSRs.

Taken together our results form the beginnings of a
theory of PSRs though, of course, much remains to
be done. We are currently pursuing the development of general nonlinear models by attempting to
estimate the nonlinear dimension directly from the
system-dynamics matrix.

**Acknowledgements**

The authors gratefully acknowledge many insightful
discussions on the content of this paper and on PSRs
more generally with Richard Sutton, Michael Littman
and Britton Wolfe. The authors also thank the anonymous reviewers for their helpful comments.

**References**

Ito, H., Amari, S.-I., & Kobayashi, K. (1992). Identifi
ability of hidden markov information sources and
their minimum degrees of freedom. _IEEE_ _Trans-_
_actions_ _on_ _Information_ _Theory_, _38_ (2), 324–333.

Jaeger, H. (1997). Observable operator processes and

conditioned continuation representations..

Jaeger, H. (1998). Discrete-time, discrete-valued ob
servable operator models: a tutorial. Tech. rep.,
German National Reserach Center for Information Technology. GMD Report 42.

James, M. R., & Singh, S. (2004). Learning and discov
ery of predictive state representations in dynamical systems with reset. In _International_ _Confer-_
_ence_ _on_ _Machine_ _Learning_ _(ICML)_ .

Littman, M. L., Sutton, R. S., & Singh, S. (2001). Pre
dictive representations of state. In _Advances_ _In_
_Neural_ _Information_ _Processing_ _Systems_ _14_ .

Rudary, M. R., & Singh, S. (2004). A nonlinear predic
tive state representation. In _Advances_ _in_ _Neural_
_Information_ _Processing_ _Systems_ _16_ . To appear.

Shatkay, H., & Kaelbling, L. (1997). Learning topologi
cal maps with weak local odometric information..
In _Proceedings_ _of_ _Fifteenth_ _International_ _Joint_
_Conference_ _on_ _Artificial_ _Intelligence(IJCAI-97)_ .

Singh, S., Littman, M. L., Jong, N. E., Pardoe, D.,

& Stone, P. (2003). Learning predictive state
representations. In _The_ _Twentieth_ _International_
_Conference_ _on_ _Machine_ _Learning_ _(ICML-2003)_ .
