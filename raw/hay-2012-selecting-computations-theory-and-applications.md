# hay-2012-selecting-computations-theory-and-applications

> Converted from `hay-2012-selecting-computations-theory-and-applications.pdf` on 2026-10-13 via `pymupdf4llm`.
> Layout artefacts (broken equations, interleaved columns) are conversion noise, not the source.

---

# **Selecting Computations: Theory and Applications**

**Nicholas** **Hay** **and** **Stuart** **Russell**

Computer Science Division

University of California

Berkeley, CA 94720
_{_ `nickjhay,russell` _}_ `@cs.berkeley.edu`

**Abstract**

Sequential decision problems are often approximately solvable by simulating possible
future action sequences. _Metalevel_ decision
procedures have been developed for selecting _which_ action sequences to simulate, based
on estimating the expected improvement in
decision quality that would result from any
particular simulation; an example is the recent work on using bandit algorithms to control Monte Carlo tree search in the game
of Go. In this paper we develop a theoretical basis for metalevel decisions in the
statistical framework of Bayesian _selection_
_problems_, arguing (as others have done) that
this is more appropriate than the bandit
framework. We derive a number of basic
results applicable to Monte Carlo selection
problems, including the first finite sampling
bounds for optimal policies in certain cases;
we also provide a simple counterexample to
the intuitive conjecture that an optimal policy will necessarily reach a decision in all
cases. We then derive heuristic approximations in both Bayesian and distribution-free
settings and demonstrate their superiority to
bandit-based heuristics in one-shot decision
problems and in Go.

**1** **Introduction**

The broad family of sequential decision problems includes combinatorial search problems, game playing,
robotic path planning, model-predictive control problems, Markov decision processes (MDP), whether fully
or partially observable, and a huge range of applications. In almost all realistic instances, exact solution
is intractable and approximate methods are sought.
Perhaps the most popular approach is to simulate a

**David** **Tolpin** **and** **Solomon** **Eyal** **Shimony**

Department of Computer Science
Ben-Gurion University of the Negev

Beer Sheva 84105, Israel
_{_ `tolpin,shimony` _}_ `@cs.bgu.ac.il`

limited number of possible future action sequences, in
order to find a move in the current state that is (hopefully) near-optimal. In this paper, we develop a theoretical framework to examine the problem of selecting _which_ future sequences to simulate. We derive a
number of new results concerning optimal policies for
this selection problem as well as new heuristic policies
for controlling Monte Carlo simulations. As described
below, these policies outperform previously published
methods for “flat” selection and game-playing in Go.

The basic ideas behind our approach are best explained in a familiar context such as game playing.
A typical game-playing algorithm chooses a move by
first exploring a tree or graph of move sequences and
then selecting the most promising move based on this
exploration. Classical algorithms typically explore in a
fixed order, imposing a limit on exploration depth and
using pruning methods to avoid irrelevant subtrees;
they may also reuse some previous computations (see
Section 6.2). Exploring unpromising or highly predictable paths to great depth is often wasteful; for a
given amount of exploration, decision quality can be
improved by directing exploration towards those actions sequences whose outcomes are helpful in selecting
a good move. Thus, the _metalevel_ decision problem is
to choose what future action sequences to explore (or,
more generally, what deliberative computations to do),
while the _object-level_ decision problem is to choose an
action to execute in the real world.

That the metalevel decision problem can itself be formulated and solved decision-theoretically was noted
by Matheson (1968), borrowing from the related concept of _information_ _value_ _theory_ (Howard, 1966). In
essence, computations can be selected according to
the expected improvement in decision quality resulting
from their execution. I. J. Good (1968) independently
proposed using this idea to control search in chess, and
later defined “Type II rationality” to refer to agents
that optimally solve the metalevel decision problem
before acting. As interest in probabilistic and decision

theoretic approaches in AI grew during the 1980s, several authors explored these ideas further (Dean and
Boddy, 1988; Doyle, 1988; Fehling and Breese, 1988;
Horvitz, 1987). Work by Russell and Wefald (1988,
1991a,b) formulated the metalevel sequential decision
problem, employing an explicit model of the results of
computational actions, and applied this to the control
of game-playing search in Othello with encouraging results.

An independent thread of research on metalevel control began with work by Kocsis and Szepesv´ari (2006)
on the UCT algorithm, which operates in the context
of _Monte_ _Carlo_ _tree_ _search_ (MCTS) algorithms. In
MCTS, each computation takes the form of a simulation of a randomized sequence of actions leading from
a leaf of the current tree to a terminal state. UCT
is primarily a method for selecting a leaf from which
to conduct the next simulation, and forms the core of
the successful MoGo algorithm for Go playing (Gelly
and Silver, 2011). The UCT algorithm is based on
the the theory of bandit problems (Berry and Fristedt, 1985) and the asymptotically near-optimal UCB1
bandit algorithm (Auer et al., 2002). UCT applies
UCB1 recursively to select actions to perform within
simulations.

It is natural to consider whether the two independent threads are consistent; for example, are bandit
algorithms such as UCB1 approximate solutions to
some particular case of the metalevel decision problem defined by Russell and Wefald? The answer, perhaps surprisingly, is no. The essential difference is
that, in bandit problems, every trial involves executing a real object-level action with real costs, whereas
in the metareasoning problem the trials are _simula-_
_tions_ whose cost is usually independent of the utility of the action being simulated. Hence, as Audibert
et al. (2010) and Bubeck et al. (2011) have also noted,
UCT applies bandit algorithms to problems that are
not bandit problems.

One consequence of the mismatch is that bandit policies are inappropriately biased away from exploring actions whose current utility estimates are low. Another
consequence is the absence of any notion of “stopping”
in bandit algorithms, which are designed for infinite sequences of trials. A metalevel policy needs to decide
when to stop deliberating and execute a real action.

Analyzing the metalevel problem within an appropriate theoretical framework ought to lead to more effective algorithms than those obtained within the bandit
framework. For Monte Carlo computations, in which
samples are gathered to estimate the utilities of actions, the metalevel decision problem is an instance
of the _selection_ _problem_ studied in statistics (Bech

hofer, 1954; Swisher et al., 2003). Despite some recent
work (Frazier and Powell, 2010; Tolpin and Shimony,
2012b), the theory of selection problems is less well
understood than that of bandit problems. Most work
has focused on the probability of selection error rather
than optimal policies in the Bayesian setting (Bubeck
et al., 2011). Accordingly, we present in Sections 2
and 3 a number of results concerning optimal policies
for the general case as well as specific finite bounds on
the number of samples collected by optimal policies
for Bernoulli arms with beta priors. We also provide a
simple counterexample to the intuitive conjecture that
an optimal policy should not spend more on deciding
than the decision is worth; in fact, it is possible for an
optimal policy to compute forever. We also show by
counterexample that optimal _index_ _policies_ (Gittins,
1989) may not exist for selection problems.

Motivated by this theoretical analysis, we propose in
Sections 4 and 5 two families of heuristic approximations, one for the Bayesian case and one for the
distribution-free setting. We show empirically that
these rules give better performance than UCB1 on
a wide range of standard (non-sequential) selection
problems. Section 6 shows similar results for the case
of guiding Monte Carlo tree search in the game of Go.

**2** **On** **optimal** **policies** **for** **selection**

In a selection problem the decision maker is faced with
a choice among alternative arms <sup>1</sup> . To make this choice,
they may gather evidence about the utility of each of
these alternatives, at some cost. The objective is to
maximize the _net_ _utility_, i.e., the expected utility of
the final arm selected, less the cost of gathering the
evidence. In the classical case (Bechhofer, 1954), evidence might consist of physical samples from a product
batch; in a metalevel problem with Monte Carlo simulations, the evidence consists of outcomes of sampling
computations:

**Definition** **1.** _A_ **_metalevel_** **_probability_** **_model_** _is_
_a_ _tuple_ ( _U_ 1 _, . . ., Uk, E_ ) _consisting_ _of_ _jointly_ _distributed_
_random_ _variables:_

_•_ _Real_ _random_ _variables_ _U_ 1 _, . . ., Uk,_ _where_ _Ui_ _is_ _the_
_utility_ _of_ _arm_ _i,_ _and_

_•_ _A_ _countable_ _set_ _E_ _of_ _random_ _variables,_ _each_ _vari-_
_able_ _E_ _∈E_ _being_ _a_ _computation_ _that_ _can_ _be_ _per-_
_formed_ _and_ _whose_ _value_ _is_ _the_ _result_ _of_ _that_ _com-_
_putation,_ _where_ _e_ _∈_ _E_ _will_ _denote_ _that_ _e_ _is_ _a_ _po-_
_tential_ _value_ _of_ _the_ _computation_ _E._

1Alternative actions are known as _arms_ in the bandit
setting; we borrow this terminology for uniformity.

For simplicity, in the below we’ll assume the utilities
_Ui_ are bounded, without loss of generality in [0 _,_ 1].

**Example** **1** (Bernoulli sampling) **.** _In_ _the_ **_Bernoulli_**
**_metalevel_** **_probability_** **_model_** _,_ _each_ _arm_ _will_ _either_
_succeed_ _or_ _not_ _Ui_ _∈{_ 0 _,_ 1 _},_ _with_ _an_ _unknown_ _latent_
_frequency_ _of_ _success_ Θ _i,_ _and_ _a_ _set_ _of_ _stochastic_ _sim-_
_ulations_ _of_ _possible_ _consequences_ _E_ = _{Eij|_ 1 _≤_ _i_ _≤_
_k, j_ _∈_ N _}_ _that_ _can_ _be_ _performed:_

Θ _i_

iid
_∼_ Uniform[0 _,_ 1] _for_ _i ∈{_ 1 _, . . ., k}_

_Ui_ _|_ Θ _i_ _∼_ Bernoulli(Θ _i_ ) _for_ _i ∈{_ 1 _, . . ., k}_

_MDP_ _M_ = ( _S, s_ 0 _, As, T, R_ ) _such_ _that_

_S_ = _{⊥} ∪{⟨e_ 1 _. . ., en⟩_ : _ei_ _∈_ _Ei_ _for_ _all_ _i,_

_for_ _finite_ _n ≥_ 0 _and_ _distinct_ _Ei_ _∈E}_

_s_ 0 = _⟨⟩_

_As_ = _{⊥} ∪Es_

_where ⊥∈_ _S_ _is the unique terminal state, where Es_ _⊆E_
_is_ _a_ _state-dependent_ _subset_ _of_ _allowed_ _computations,_
_and_ _when_ _given_ _any_ _s_ = _⟨e_ 1 _, . . ., en⟩∈_ _S,_ _computa-_
_tional_ _action_ _E_ _∈E,_ _and_ _s_ <sup>_′_</sup> = _⟨e_ 1 _, . . ., en, e⟩∈_ _S_ _where_
_e ∈_ _E,_ _we_ _have:_

_T_ ( _s, E, s_ <sup>_′_</sup> ) = _P_ ( _E_ = _e | E_ 1 = _e_ 1 _, . . ., En_ = _en_ )

_T_ ( _s, ⊥, ⊥_ ) = 1

_R_ ( _s, E, s_ <sup>_′_</sup> ) = _−c_

_R_ ( _s, ⊥, ⊥_ ) = max _µi_ ( _s_ )

_i_

_where_ _µi_ ( _s_ ) = E[ _Ui_ _| E_ 1 = _e_ 1 _, . . ., En_ = _en_ ] _._

Note that when stopping in state _s_, the expected utility of action _i_ is by definition _µi_ ( _s_ ), so the optimal action to take is _i_ <sup>_∗_</sup> _∈_ argmax _i µi_ ( _s_ ) which has expected
utility _µi∗_ ( _s_ ) = max _i µi_ ( _s_ ).

One can optionally add an external constraint on the
number of computational actions, or their total cost,
in the form of a deadline or _budget_ . This bridges with
the related area of budgeted learning (Madani et al.,
2004). Although this feature is not formalized in the
MDP, it can be added by including either time or past
total cost as part of the state.

**Example** **2** (Bernoulli sampling) **.** _In_ _the_ _Bernoulli_
_metalevel_ _probability_ _model_ _(Example_ _1),_ _note_ _that:_

Θ _i_ _| Ei_ 1 _, . . ., Eini_ _∼_ Beta( _si_ + 1 _, fi_ + 1) (1)

_Eij_ _|_ Θ _i_

iid
_∼_ Bernoulli(Θ _i_ ) _for_ _i ∈{_ 1 _, . . ., k},_ _j_ _∈_ N

_The_ **_one-armed_** **_Bernoulli_** **_metalevel_** **_probability_**
**_model_** _has_ _k_ = 2 _,_ Θ1 = _λ_ _∈_ [0 _,_ 1] _a_ _constant,_ _and_
Θ2 _∼_ Uniform[0 _,_ 1] _._

A metalevel probability model, when combined with a
cost of computation _c_ _>_ 0, <sup>2</sup> defines a metalevel decision problem: what is the optimal strategy with which
to choose a sequence of computations _E_ _∈E_ in order
to maximize the agent’s net utility? Intuitively, this
strategy should choose the computations that give the
most evidence relevant to deciding which arm to use,
stopping when the cost of computation outweighs the
benefit gained. We formalize the selection problem as a
Markov Decision Process (see, e.g., Puterman (1994)):

**Definition** **2.** _A_ _(countable_ _state,_ _undiscounted)_
**_Markov_** **_Decision_** **_Process_** _(MDP)_ _is_ _a_ _tuple_ _M_ =
( _S, s_ 0 _, As, T, R_ ) _where:_ _S_ _is_ _a_ _countable_ _set_ _of_ _states,_
_s_ 0 _∈_ _S_ _is_ _the_ _fixed_ _initial_ _state,_ _As_ _is_ _a_ _countable_ _set_
_of_ _actions_ _available_ _in_ _state_ _s_ _∈_ _S,_ _T_ ( _s, a, s_ <sup>_′_</sup> ) _is_ _the_
_transition_ _probability_ _from_ _s_ _∈_ _S_ _to_ _s_ <sup>_′_</sup> _∈_ _S_ _after_ _per-_
_forming_ _action_ _a_ _∈_ _As,_ _and_ _R_ ( _s, a, s_ <sup>_′_</sup> ) _is_ _the_ _expected_
_reward_ _received_ _on_ _such_ _a_ _transition._

To formulate the metalevel decision problem as an
MDP, we define the states as sequences of computation outcomes and allow for a terminal state when the
agent chooses to stop computing and act:

**Definition** **3.** _Given_ _a_ _metalevel_ _probability_ _model_ <sup>3</sup>

( _U_ 1 _, . . ., Uk, E_ ) _and_ _a_ _cost_ _of_ _computation_ _c_ _>_ 0 _,_ _a_
_corresponding_ **_metalevel_** **_decision_** **_problem_** _is_ _any_

2The assumption of a fixed cost of computation is a
simplification; precise conditions for its validity are given
by Harada (1997).

3Definition 1 made no assumption about the computational result variables _Ei_ _∈E_, but for simplicity in the
following we’ll assume that each _Ei_ takes one of a countable set of values. Without loss of generality, we’ll further
assume the domains of the computational variables _E_ _∈E_
are disjoint.

E[ _Ui_ _| Ei_ 1 _, . . ., Eini_ ] = ( _si_ + 1) _/_ ( _ni_ + 2) (3)

_by_ _standard_ _properties_ _of_ _these_ _distributions,_ _where_
_si_ = <sup>�</sup> _j_ <sup>_n_</sup> =1 <sup>_i_</sup> <sup>_Ein_</sup> _i_ <sup>_is the number of simulated successes of_</sup>

_arm_ _i,_ _and_ _fi_ = _ni −_ _si_ _the_ _failures._ _By_ _Equation_ _(1),_
_the_ _state_ _space_ _is_ _the_ _set_ _of_ _all_ _k_ _pairs_ ( _si, fi_ ) _;_ _Equa-_
_tions_ _(2)_ _and_ _(3)_ _suffice_ _to_ _give_ _the_ _transition_ _proba-_
_bilities_ _and_ _terminal_ _rewards,_ _respectively._ _The_ _one-_
_armed_ _Bernoulli_ _case_ _is_ _similar,_ _requiring_ _as_ _state_ _just_
( _s, f_ ) _defining_ _the_ _posterior_ _over_ Θ2 _._

Given a metalevel decision problem _M_ =
( _S, s_ 0 _, As, T, R_ ) one defines policies and value
functions as in any MDP. A (deterministic, stationary) **metalevel** **policy** _π_ is a function mapping states
_s ∈_ _S_ to actions to take in that state _π_ ( _s_ ) _∈_ _As_ .

_Ei_ ( _ni_ +1) _| Ei_ 1 _, . . ., Eini_ _∼_ Bernoulli

- _<u>si</u>_ <u>+ 1</u>
_ni_ + 2

(2)

The **value** **function** for a policy _π_ gives the expected
total reward received under that policy starting from a
given state _s ∈_ _S_, and the **Q-function** does the same
when starting in a state _s_ _∈_ _S_ and taking a given
action _a ∈_ _As_ :

          
_R_ ( _Si, π_ ( _Si_ ) _, Si_ +1) _| S_ 0 = _s_

_VM_ <sup>_π_</sup>

_M_ <sup>_π_</sup> <sup>(</sup> <sup>_s_</sup> <sup>) = E</sup> <sup>_π_</sup> _M_

_M_

- _N_

_i_ =0

(4)

where _N_ _∈_ [0 _, ∞_ ] is the random time the MDP is
terminated, i.e., the unique time where _π_ ( _SN_ ) = _⊥_,
and similarly for the Q-function _Q_ <sup>_π_</sup> _M_ <sup>(</sup> <sup>_s, a_</sup> <sup>).</sup>

As usual, an **optimal** **policy** _π_ <sup>_∗_</sup>, when it exists, is one
that maximizes the value from every state _s_ _∈_ _S_, i.e.,
if we define for each _s ∈_ _S_

_VM_ <sup>_∗_</sup>

_π_ <sup>_V_</sup> _M_ <sup>_π_</sup>

_M_ <sup>_∗_</sup> <sup>(</sup> <sup>_s_</sup> <sup>) = sup</sup> _π_

_M_ <sup>_π_</sup> <sup>(</sup> <sup>_s_</sup> <sup>)</sup> <sup>_,_</sup>

then an optimal policy _π_ <sup>_∗_</sup> satisfies _VM_ <sup>_π∗_</sup>

_M_ <sup>_π∗_</sup> <sup>(</sup> <sup>_s_</sup> <sup>) =</sup> <sup>_V_</sup> _M_ <sup>_∗_</sup>

then an optimal policy _π_ <sup>_∗_</sup> satisfies _VM_ <sup>_π∗_</sup> <sup>(</sup> <sup>_s_</sup> <sup>) =</sup> <sup>_V_</sup> _M_ <sup>_∗_</sup> <sup>(</sup> <sup>_s_</sup> <sup>) for</sup>

all _s ∈_ _S_, where we break ties in favor of stopping.

The optimal policy must balance the cost of computations with the improved decision quality that results.
This tradeoff is made clear in the value function:

**Theorem** **4.** _The_ _value_ _function_ _of_ _a_ _metalevel_ _deci-_
_sion_ _process_ _M_ = ( _S, s_ 0 _, As, T, R_ ) _is_ _of_ _the_ _form_

_M_ <sup>_π_</sup> <sup>(</sup> <sup>_s_</sup> <sup>) = E</sup> _M_ <sup>_π_</sup>

_µi_ ( _SN_ ) _| S_ 0 = _s_ ]
_i_

_VM_ <sup>_π_</sup>

_M_ <sup>_π_</sup> <sup>[</sup> <sup>_−c N_</sup> <sup>+ max</sup>

_where_ _N_ _denotes_ _the_ _(random)_ _total_ _number_ _of_ _com-_
_putations_ _performed;_ _similarly_ _for_ _Q_ <sup>_π_</sup> _M_ <sup>(</sup> <sup>_s, a_</sup> <sup>)</sup> <sup>_._</sup>

In many problems, including the Bernoulli sampling
model of Example 2, the state space is infinite. Does
this preclude solving for the optimal policy? Can infinitely many computations be performed?

There is in full generality an upper bound on the _ex-_
_pected_ number of computations a policy performs:

**Theorem** **5.** _The_ _optimal_ _policy’s_ _expected_ _number_ _of_
_computations_ _is_ _bounded_ _by_ _the_ _value_ _of_ _perfect_ _infor-_
_mation_ _(Howard,_ _1966)_ _times_ _the_ _inverse_ _cost_ 1 _/c:_

E <sup>_π∗_</sup> [ _N_ _| S_ 0 = _s_ ] _≤_ <sup><u>1</u></sup>

_c_

E[max

max _µi_ ( _s_ )

_i_

_and_ Θ2 _is_ 1 _/_ 3 _or_ 2 _/_ 3 _with_ _equal_ _probability._ _Simu-_
_lating_ _arm_ _1_ _gains_ _nothing,_ _and_ _after_ ( _s, f_ ) _simulated_
_successes and failures of arm 2 the posterior odds ratio_
_is_

_<u>P</u>_ <u>(Θ2</u> <u>= 2</u> _<u>/</u>_ <u>3</u> _<u>| s, f</u>_ <u>)</u>
_P_ (Θ2 = 1 _/_ 3 _| s, f_ ) <sup>=</sup> (1 <sup><u>(2</u></sup> _/_ <sup>_<u>/</u>_</sup> 3) <sup><u>3)</u></sup> <sup>_ss_</sup> (2 <sup><u>(1</u></sup> _/_ <sup>_<u>/</u>_</sup> 3) <sup><u>3)</u></sup> <sup>_ff_</sup> <sup>= 2</sup> <sup>_s−f_</sup> <sup>_._</sup>

_Note_ _that_ _this_ _ratio_ _completely_ _specifies_ _the_ _posterior_
_distribution_ _of_ Θ2 _,_ _and_ _hence_ _the_ _distribution_ _of_ _the_
_utilities_ _and_ _all_ _future_ _computations._ _Thus,_ _whether_ _it_
_is_ _optimal_ _to_ _continue_ _is_ _a_ _function_ _only_ _of_ _this_ _ratio,_
_and thus of s−f_ _._ _For sufficiently low cost,_ _the optimal_
_policy_ _samples_ _when_ _s_ _−_ _f_ _equals_ _−_ 1 _,_ 0 _,_ _or_ 1 _._ _But_
_with_ _probability_ 1 _/_ 3 _,_ _a_ _state_ _with_ _s −_ _f_ = 0 _transitions_
_to_ _another_ _state_ _s −_ _f_ = 0 _after_ _two_ _samples,_ _giving_
_finite,_ _although_ _exponentially_ _decreasing,_ _probability_ _to_
_arbitrarily_ _long_ _sequences_ _of_ _computations._

However, in a number of settings, including the original Bernoulli model of Example 1, we can prove an
upper bound on the number of computations. For
reasons of space, and for its later use in Section 4,
we prove here the bound for the one-armed Bernoulli
model.

Before we can do this, we need to get an analytical
handle on the optimal policy. The key is through a
natural approximate policy:

**Definition** **6.** _Given_ _a_ _metalevel_ _decision_ _problem_
_M_ = ( _S, s_ 0 _, As, T, R_ ) _, the_ **_myopic_** **_policy_** _π_ <sup>_m_</sup> ( _s_ ) _is de-_
_fined_ _to_ _equal_ argmax _a∈As Q_ <sup>_m_</sup> ( _s, a_ ) _where_ _Q_ <sup>_m_</sup> ( _s, ⊥_ ) =
max _i µi_ ( _s_ ) _and_

_Q_ <sup>_m_</sup> ( _s, E_ ) = E _M_ [ _−c_ + max _µi_ ( _S_ 1) _| S_ 0 = _s, A_ 0 = _E_ ] _._

_i_

The myopic policy (known as the metalevel greedy approximation with single-step assumption in (Russell
and Wefald, 1991a)) takes the best action, to either
stop or perform a computation, under the assumption that at most one further computation can be performed. It has a tendency to stop too early, because
changing one’s mind about which real action to take
often takes more than one computation. In fact, we
have:

**Theorem 7.** _Given a metalevel decision problem M_ =
( _S, s_ 0 _, As, T, R_ ) _if_ _the_ _myopic_ _policy_ _performs_ _some_
_computation_ _in_ _state_ _s_ _∈_ _S,_ _then_ _the_ _optimal_ _policy_
_does_ _too,_ _i.e.,_ _if_ _π_ <sup>_m_</sup> ( _s_ ) _̸_ = _⊥_ _then_ _π_ <sup>_∗_</sup> ( _s_ ) _̸_ = _⊥._

Despite this property, the stopping behavior of the myopic policy does have a close connection to that of the
optimal policy:

**Definition** **8.** _Given_ _a_ _metalevel_ _decision_ _problem_
_M_ = ( _S, s_ 0 _, As, T, R_ ) _,_ _a_ _subset_ _S_ <sup>_′_</sup> _⊆_ _S_ _of_ _states_
_is_ **_closed_** **_under_** **_transitions_** _if_ _whenever_ _s_ <sup>_′_</sup> _∈_ _S_ <sup>_′_</sup> _,_
_a ∈_ _As′,_ _s_ <sup>_′′_</sup> _∈_ _S,_ _and_ _T_ ( _s_ <sup>_′_</sup> _, a, s_ <sup>_′′_</sup> ) _>_ 0 _,_ _we_ _have_ _s_ <sup>_′′_</sup> _∈_ _S_ <sup>_′_</sup> _._

_Ui_ _| S_ 0 = _s_ ] _−_ max
_i_ _i_

_._

_Further,_ _any_ _policy_ _π_ _with_ _infinite_ _expected_ _number_ _of_
_computations has negative infinite value,_ _hence the op-_
_timal_ _policy_ _stops_ _with_ _probability_ _one._

Although the _expected_ number of computations is always bounded, there are important cases in which the
_actual_ number is not, such as the following inspired by
the sequential probability ratio test (Wald, 1945):

**Example** **3.** _Consider_ _the_ _Bernoulli_ _sampling_ _model_
_for_ _two_ _arms_ _but_ _with_ _a_ _different_ _prior:_ Θ1 = 1 _/_ 2 _,_

**Theorem 9.** _Given a metalevel decision problem M_ =
( _S, s_ 0 _, As, T, R_ ) _and_ _a_ _subset_ _S_ <sup>_′_</sup> _⊆_ _S_ _of_ _states_ _closed_
_under_ _transitions,_ _if_ _the_ _myopic_ _policy_ _stops_ _in_ _all_
_states_ _s_ <sup>_′_</sup> _∈_ _S_ <sup>_′_</sup> _then_ _the_ _optimal_ _policy_ _does_ _too._

Using these results connecting the behavior of the optimal and myopic policies, we can prove our bound:

**Theorem** **10.** _The_ _one-armed_ _Bernoulli_ _decision_ _pro-_
_cess_ _with_ _constant_ _arm_ _λ_ _∈_ [0 _,_ 1] _performs_ _at_ _most_
_λ_ (1 _−_ _λ_ ) _/c −_ 3 _≤_ 1 _/_ 4 _c −_ 3 _computations._

_Proof._ Using Definition 6 and Example 2, we determine which states the myopic policy stops in by bounding _Q_ <sup>_m_</sup> ( _s, E_ ). For a state ( _s, f_ ), let _µ_ = ( _s_ +1) _/_ ( _n_ +2)
be the mean utility for arm 2, where _n_ = _s_ + _f_ . Fixing
_n_ and maximizing over _µ_, we get sufficient condition
for stopping Since the set of states satisfying Equation (5) is closed under

_the_ _known_ _value_ _λ._ _As_ _the_ _context_ _λ_ _varies_ _the_ _op-_
_timal_ _action_ _inverts_ _from_ _observing_ _1_ _to_ _observing_ _2._
_Inversions_ _like_ _this_ _are_ _impossible_ _for_ _index_ _policies._

0.3

0.2

0.1

0

-0.1

-0.2

-0.3

-2 -1.5 -1 -0.5 0 0.5 1 1.5 2

Utility of fixed alternative (λ)

<sup>_<u>λ</u>_</sup> <sup><u>(1</u></sup> <sup>_<u>−</u>_</sup> <sup>_<u>λ</u>_</sup> <sup><u>)</u></sup> _n ≥_ <sup>_<u>λ</u>_</sup> <sup><u>(1</u></sup> <sup>_<u>−</u>_</sup> <sup>_<u>λ</u>_</sup> <sup><u>)</u></sup>

( _n_ + 3) _c_

_c ≥_ <sup>_<u>λ</u>_</sup> <sup><u>(1</u></sup> <sup>_<u>−</u>_</sup> <sup>_<u>λ</u>_</sup> <sup><u>)</u></sup>

<sup>_<u>λ</u>_</sup> <sup><u>)</u></sup> _−_ 3 (5)

_c_

Figure 1: Optimal Q-values of computing relative to
stopping as a function of the utility of the fixed alternative. Note the inversion where for low _λ_ observing
action 1 is strictly optimal, while for medium _λ_ observing action 2 is strictly optimal.

There is, however, a restriction on what kind of influence the context can have:

**Definition** **11.** _Given_ _a_ _metalevel_ _decision_ _problem_
_M_ = ( _S, s_ 0 _, As, T, R_ ) _,_ _and_ _a_ _constant_ _λ_ _∈_ R _,_ _define_
_Mλ_ = ( _S, s_ 0 _, As, T, Rλ_ ) _to_ _be_ _M_ _with_ _an_ _additional_
_action_ _of_ _known_ _value_ _λ,_ _defined_ _by:_

_Rλ_ ( _s, E, s_ <sup>_′_</sup> ) = _R_ ( _s, E, s_ <sup>_′_</sup> )

_Rλ_ ( _s, ⊥, ⊥_ ) = max _{λ, R_ ( _s, ⊥, ⊥_ ) _}_

Note this is equivalent to adding an extra arm with
constant value _Uk_ +1 = _λ_ .

**Theorem** **12.** _Given_ _a_ _metalevel_ _decision_ _problem_
_M_ = ( _S, s_ 0 _, As, T, R_ ) _,_ _there_ _exists_ _a_ _real_ _interval_ _I_ ( _s_ )
_for_ _every_ _state_ _s ∈_ _S_ _such_ _that_ _it_ _is_ _optimal_ _to_ _stop_ _in_
_state_ _s_ _in_ _Mµ_ _iff_ _µ_ _∈/_ _I_ ( _s_ ) _._ _Furthermore,_ _I_ ( _s_ ) _contains_
max _i µi_ ( _s_ ) _whenever_ _it_ _is_ _nonempty._

**4** **The** **blinkered** **policy**

The myopic policy is an extreme approximation, often
stopping far too early. A better approximation can be
obtained, at least for the case where each computation
can only affect the value of one action. The technical
definition (closely related to _subtree_ _independence_ in
Russell and Wefald’s work) is as follows:

**Definition** **13.** _A_ _metalevel_ _probability_ _model_
( _U_ 1 _, . . ., Uk, E_ ) _has_ **_independent_** **_actions_** _if_ _the_ _com-_
_putational variables can be partitioned E_ = _E_ 1 _∪· · ·∪Ek_

Since the set of states satisfying Equation (5) is closed
under transitions ( _n_ only increases), by Theorem 7.
Finally, note max _λ∈_ [0 _,_ 1] _λ_ (1 _−_ _λ_ ) = 1 _/_ 4.

A key implication is that the _optimal_ policy can be
computed in time _O_ (1 _/c_ <sup>2</sup> ), i.e., quadratic in the inverse cost. This is particularly appropriate when the
cost of computation is relatively high, such as in simulation experiments (Swisher et al., 2003), or when the
decision to be made is critical.

**3** **Context** **effects** **and** **non-indexability**

The Gittins index theorem (Gittins, 1979) is a famous
structural result for bandit problems. It states that in
bandit problems with independent reward distribution
for each arm and geometric discounting, the optimal
policy is an **index** **policy** : each arm is assigned a
real-valued index based on its state only, such that it
is optimal to sample the arm with greatest index.

The analogous result does _not_ hold for metalevel decision problems, even when the action’s values are independent (this formalized later in Definition 13):

**Example** **4** (Non-indexability) **.** _Consider_ _a_ _metalevel_
_probability_ _model_ _with_ _three_ _actions._ _U_ 1 _is_ _equally_
_likely_ _to_ _be_ _−_ 1 _._ 5 _or_ 1 _._ 5 _(low_ _mean,_ _high_ _variance),_ _U_ 2
_is equally likely to be_ 0 _._ 25 _or_ 1 _._ 75 _(high mean, low vari-_
_ance),_ _and_ _U_ 3 = _λ_ _has_ _a_ _known_ _value_ _(the_ _context)._
_The_ _two_ _computations_ _are_ _to_ _observe_ _exactly_ _U_ 1 _and_
_U_ 2 _,_ _respectively,_ _each_ _with_ _cost_ 0 _._ 2 _._ _The_ _corresponding_
_metalevel_ _MDP_ _has_ _9_ _states_ _and_ _can_ _be_ _solved_ _exactly._
_Figure_ _1_ _plots_ _Q_ <sup>_∗_</sup> _λ_ <sup>(</sup> <sup>_s_</sup> <sup>0</sup> <sup>_, Ui_</sup> <sup>)</sup> <sup>_−_</sup> <sup>_Q∗_</sup> _λ_ <sup>(</sup> <sup>_s_</sup> <sup>0</sup> <sup>_, ⊥_</sup> <sup>)</sup> <sup>_as_</sup> <sup>_a_</sup> <sup>_function_</sup> <sup>_of_</sup>

<sup>_∗_</sup> _λ_ <sup>(</sup> <sup>_s_</sup> <sup>0</sup> <sup>_, Ui_</sup> <sup>)</sup> <sup>_−_</sup> <sup>_Q∗_</sup> _λ_

<sup>_∗_</sup> _λ_ <sup>(</sup> <sup>_s_</sup> <sup>0</sup> <sup>_, ⊥_</sup> <sup>)</sup> <sup>_as_</sup> <sup>_a_</sup> <sup>_function_</sup> <sup>_of_</sup>

_such_ _that_ _such_ _that_ _the_ _sets_ _{Ui} ∪Ei_ _are_ _independent_
_of_ _each_ _other_ _for_ _different_ _i._

With independent actions, we can talk about metalevel
policies that focus on computations affecting a single action. These policies are not myopic—they can
consider arbitrarily many computations—but they are
_blinkered_ because they can look in only a single direction at a time:

**Definition** **14.** _Given_ _a_ _metalevel_ _decision_ _prob-_
_lem_ _M_ = ( _S, s_ 0 _, As, T, R_ ) _with_ _independent_ _actions,_
_the_ **_blinkered_** **_policy_** _π_ <sup>_b_</sup> _is_ _defined_ _by_ _π_ <sup>_b_</sup> ( _s_ ) =
argmax _a∈As Q_ <sup>_b_</sup> ( _s, a_ ) _where_ _Q_ <sup>_b_</sup> ( _s, ⊥_ ) = _⊥_ _and_ _for_ _Ei_ _∈_
_Ei_

for which we compute _Q_ <sup>_∗_</sup>

_Mi,m_ <sup>1</sup> <sup>(</sup> <sup>_s_</sup> <sup>).4</sup> <sup>This</sup> <sup>will</sup> <sup>be</sup> <sup>worth</sup>

the cost in the same situations as mentioned at the
end of Section 2.

for which we compute _Q_ <sup>_∗_</sup>

_M_ <sup>1</sup>

_Q_ <sup>_b_</sup> ( _s, Ei_ ) = sup

_Q_ <sup>_π_</sup> ( _s, Ei_ ) (6)

Figure 2 compares the blinkered policy to several other
policies from the literature, using a Bernoulli sampling
problem with _k_ = 25 and a wide range of values for
the step cost _c_ . Performance is measured by expected
_regret_, where the regret includes the cost of sampling:
_R_ = (max _i Ui_ ) _−Uj_ + _c n_ where _n_ is the number of computations and _j_ is the action actually selected. The
blinkered policy significantly outperforms all others.
The myopic policy plateaus as it quickly reaches a position where no single computation can change the final
action choice. ESPb performs quite well given that is
making a normal approximation to the Beta posterior.
The curves for UCB1-B and UCB1-b show that even
given a good stopping rule, UCB1’s choice of actions
to sample is not ideal.

1

_π∈_ Π <sup>_b_</sup> _i_

_where_ Π <sup>_b_</sup> _i_ <sup>_is_</sup> <sup>_the_</sup> <sup>_set_</sup> <sup>_of_</sup> <sup>_policies_</sup> <sup>_π_</sup> <sup>_where_</sup> <sup>_π_</sup> <sup>(</sup> <sup>_s_</sup> <sup>)</sup> <sup>_∈Ei_</sup> <sup>_for_</sup>

_all_ _s ∈_ _S._

Clearly, blinkered policies are better than myopic:
_Q_ <sup>_m_</sup> ( _s, a_ ) _≤_ _Q_ <sup>_b_</sup> ( _s, a_ ) _≤_ _Q_ <sup>_∗_</sup> ( _s, a_ ). Moreover, the blinkered policy can be computed in time proportional to
the number of arms, by breaking the decision problem
into separate subproblems:

**Definition** **15.** _Given_ _a_ _metalevel_ _decision_ _problem_
_M_ = ( _S, s_ 0 _, As, T, R_ ) _with_ _independent_ _actions,_ _a_
**_one-action_** **_metalevel_** **_decision_** **_problem_** _for_ _i_ =
1 _, . . ., k_ _is_ _the_ _metalevel_ _decision_ _problem_ _Mi,λ_ <sup>1</sup> =
( _Si, s_ 0 _, As_ 0 _, Ti, Ri_ ) _defined_ _by_ _the_ _metalevel_ _probability_
_model_ ( _U_ 0 _, Ui, Ei_ ) _with_ _U_ 0 = _λ._

Note that given a state _s_ of a metalevel decision problem, we can form a state _si_ by taking only the results
of computations in _Ei_ (see Definition 3). By action
independence, _µi_ ( _s_ ) is a function only of _si_ .

**Theorem** **16.** _Given_ _a_ _metalevel_ _decision_ _problem_
_M_ = ( _S, s_ 0 _, As, T, R_ ) _with_ _independent_ _actions,_ _let_
_Mi,λ_ <sup>1</sup> _i_ <sup>_be_</sup> <sup>_the_</sup> <sup>_ith_</sup> <sup>_one-action_</sup> <sup>_metalevel_</sup> <sup>_decision_</sup> <sup>_prob-_</sup>

_lem_ _for_ _i_ = 1 _, . . ., k._ _Then_ _for_ _any_ _s_ _∈_ _S,_ _whenever_
_Ei_ _∈_ _As ∩Ei_ _we_ _have:_

0.1

<sup>_b_</sup> _M_ <sup>(</sup> <sup>_s, Ei_</sup> <sup>) =</sup> <sup>_Q∗_</sup>

_i,µ_ <sup>1</sup> <sup>_∗_</sup>

_Q_ <sup>_b_</sup>

_M_ <sup>1</sup>

( _si, Ei_ )

_−i_

_where_ _µ_ <sup>_∗_</sup> _−i_ <sup>= max</sup> <sup>_j̸_</sup> <sup>=</sup> <sup>_i µj_</sup> <sup>(</sup> <sup>_s_</sup> <sup>)</sup> <sup>_._</sup>

Theorem 16 shows that to compute the blinkered policy we need only compute the optimal policies for _k_
separate one-action problems.

For the Bernoulli problem with _k_ actions, the oneaction metalevel decision problems are all one-action
Bernoulli problems (Example 1). By Theorem 10 these
policies perform at most 1 _/_ 4 _c −_ 3 computations. As
a result, the blinkered policy can be numerically computed in time _O_ ( _D/c_ <sup>2</sup> ) independent of _k_ by backwards
induction, where _D_ is the number of points _λ_ _∈_ [0 _,_ 1]

0.1 0.01 0.001

Cost

Figure 2: Average regret of various policies as a function of the cost in a 25-action Bernoulli sampling problem, over 1000 trials. Error bars omitted as they are
negligible (the relative error is at most 0.03).

**5** **Upper** **bounds** **on** **Value** **of**
**Information**

In many practical applications of the selection problem, such as search in the game of Go, prior distributions are unavailable. <sup>5</sup> In such cases, one can still
bound the value of information of myopic policies using _concentration_ _inequalities_ to derive distributionindependent bounds on the VOI. We obtain such
bounds under the following assumptions:

4In our experiments below, _D_ = 129 points are equally
spaced, using linear interpolation between points.

5The analysis is also applicable to some Bayesian settings, using “fake” samples to simulate prior distributions.

1. Samples are iid given the value of the arms
(variables), as in the Bayesian schemes such as
Bernoulli sampling.

2. The expectation of a selection in a belief state is
equal to the sample mean (and therefore, after
sampling terminates, the arm with the greatest
sample mean will be selected).

When considering possible samples in the blinkered
semi-myopic setting, two cases are possible: either the
<u>arm</u> _α_ with the highest sample mean _X_ _α_ is tested, and
_X_ _α_ becomes lower than _X_ _β_ of the <u>second-best</u> arm _β_ ;
or, another arm _i_ is tested, and _X_ _i_ becomes higher
than _X_ _α_ .

Our bounds below are applicable to any bounded distribution (without loss of generality bounded in [0 _,_ 1]).
Similar bounds can be derived for certain unbounded
distributions, such as the normally distributed prior
value with normally distributed sampling. We derive
a VOI bound for testing an arm a fixed _N_ times, where
_N_ can be the remaining budget of available samples or
any other integer quantity. Denote by Λ <sup>_b_</sup> _i_ <sup>the</sup> <sup>intrinsic</sup>

VOI of testing the _i_ th arm _N_ times, and the number
of samples already taken from the _i_ th arm by _ni_ .

**Theorem** **17.** Λ <sup>_b_</sup> _i_ <sup>_is_</sup> <sup>_bounded_</sup> <sup>_from_</sup> <sup>_above_</sup> <sup>_as_</sup>

ity (Maurer and Pontil, 2009), or through a more careful application of the Hoeffding inequality, resulting in:

<sup>_b_</sup> _i_ <sup>_≤_</sup> <sup>_<u>N</u>_</sup> <sup>_√π_</sup>

_ni_ <sup>_~~√~~_</sup> _<u>ni</u>_

- _~~n~~_ _i_
(1 _−X_ _i_ <sup>)</sup> <sup>_√ni_</sup>

<u>�</u>

_−_ erf

( _X_

_~~n~~_ _α_
_α_ <sup>_−_</sup> <sup>_X_</sup>

_~~n~~_ _i_ <u>��</u>
_i_ <sup>)</sup> <sup>_√ni_</sup>

Λ <sup>_b_</sup>

_ni_ <sup>_~~√~~_</sup> _<u>ni</u>_

erf

_<u>N</u>_ <sup>_√_</sup> _<u>π</u>_

<sup>_b_</sup> _α_ <sup>_≤_</sup> _nα_ <sup>_~~√~~_</sup> _<u>nα</u>_

_X_

_~~n~~_ _α_
_α_ _√nα_

_−_ erf

( _X_

_~~n~~_ _α_
_α_ <sup>_−_</sup> <sup>_X_</sup>

_~~n~~_ _β_ <u>��</u>
_β_ <sup>)</sup> <sup>_√nα_</sup>

(10)

Λ <sup>_b_</sup> _α_

erf

Selection problems usually separate out the decision
of _whether_ to sample or to stop (called the stopping
policy), and _what_ to sample. We’ll examine the first
issue here, along with the empirical evaluation of the
above approximate algorithms, and the second in the
following section.

Assuming that the sample costs are constant, a semimyopic policy will decide to test the arm that has the
best current VOI estimate. When the distributions
are unknown, it makes sense to use the upper bounds
established in Theorem 17, as we do in the following.
This evaluation assumes a fixed budget of samples,
which is completely used up by each of the candidate
schemes, making a stopping criterion irrelevant.

<sup>_b_</sup> _α_ <sup>_≤_</sup> <sup>_NX_</sup>

_~~n~~_ _β_
_β_ <sup>)</sup>

Λ <sup>_b_</sup>

_~~n~~_ _β_
_<u>β</u>_

<sup>_NX_</sup>

_nα_

_~~n~~_ _α_ + _N_

Pr( _X_ _α_ _≤_ _X_

<sup>_b_</sup> _i|i̸_ = _α_ <sup>_≤_</sup> <sup>_<u>N</u>_</sup> <sup><u>(1</u></sup> <sup>_<u>−</u>_</sup> <sup>_<u>X</u>_</sup>

_~~n~~_ _α_
_α_ <sup>)</sup> (7)

|Col1|G|Col3|Col4|Col5|Col6|Col7|
|---|---|---|---|---|---|---|
||G<br>G<br>G<br>G<br>G<br>G<br>G<br>G UCB1<br>VOI<br>VOI+|G<br>G<br>G<br>G<br>G<br>G<br>G<br>G UCB1<br>VOI<br>VOI+|G<br>G<br>G<br>G<br>G<br>G<br>G<br>G UCB1<br>VOI<br>VOI+|G<br>G<br>G<br>G<br>G<br>G<br>G<br>G UCB1<br>VOI<br>VOI+|G UCB1<br>VOI<br>VOI+|G UCB1<br>VOI<br>VOI+|
||||||||
||||||||
||||||||
||||||||
||||||||

200 500 1000

Nsamples

Λ <sup>_b_</sup> _i_ _̸_

_~~n~~_ _α_

_̸_ <sup>_<u>−</u>_</sup> <sup>_<u>X</u>_</sup> _<u>α</u>_ <sup><u>)</u></sup>

_ni_

Pr( _X_

_~~n~~_ _i_ + _N_
_i_ _≥_ _X_

The probabilities can be bounded from above using
the Hoeffding inequality (Hoeffding, 1963):

**Theorem** **18.** _The_ _probabilities_ _in_ _Equation_ _(7)_ _are_
_bounded_ _from_ _above_ _as_

_~~n~~_ _α_
_α_ <sup>_−_</sup> <sup>_X_</sup>

_~~n~~_ _α_
_α_ <sup>_−_</sup> <sup>_X_</sup>

_~~n~~_ _β_
_β_ <sup>)</sup> <sup>_≤_</sup> <sup>2 exp</sup>

_~~n~~_ _β_
_β_ <sup>)</sup> <sup>_≤_</sup> <sup>2 exp</sup>

_−ϕ_ ( _X_

_−ϕ_ ( _X_

_~~n~~_ _ββ_ <sup>)2</sup> <sup>_nα_</sup>

_~~n~~_ _i_ _i_ <sup>)2</sup> <sup>_ni_</sup>

Pr( _X_

Pr( _X_

_~~n~~_ _α_ + _N_
_α_ _≤_ _X_

_~~n~~_ _α_ + _N_
_i|i̸_ = _α_ <sup>_≥_</sup> <sup>_X_</sup>

(8)

2 _−_ 1) <sup>2</sup> _>_ 1 _._ 37 _._

2( 1+ <sup><u>1+</u></sup> <sup>_~~√~~_</sup> <sup>_<u>n/N</u>_</sup> _n/N_ <sup>)2</sup>

2( 1+ <sup><u>1+</u></sup> <sup>_~~√~~_</sup> <sup>_<u>n/N</u>_</sup>

- _√_
= 8(

_where_ _ϕ_ = min

**Corollary** **19.** _An_ _upper_ _bound_ _on_ _the_ _VOI_ _estimate_
Λ <sup>_b_</sup> _i_ <sup>_is_</sup> <sup>_obtained_</sup> <sup>_by_</sup> <sup>_substituting_</sup> <sup>_Equation_</sup> <sup>_(8)_</sup> <sup>_into_</sup> <sup>_(7)._</sup>

_~~n~~_ _α_
_α_ <sup>_−_</sup> <sup>_X_</sup>

_~~n~~_ _ββ_ <sup>)2</sup> <sup>_nα_</sup>

(9)

<sup>_b_</sup> _α_ <sup>_≤_</sup> <sup>ˆΛ</sup> <sup>_b_</sup> _α_

_~~n~~_ _β_
_<u>β</u>_

<sup>_NX_</sup>

_nα_

Λ <sup>_b_</sup> _α_

<sup>_b_</sup> _α_ <sup>=</sup> <sup>2</sup> <sup>_NX_</sup>

exp

_−ϕ_ ( _X_

_~~n~~_ _α_
_α_ <sup>_−_</sup> <sup>_X_</sup>

Figure 3: Average regret of various policies as a function of the fixed number of samples in a 25-action
Bernoulli sampling problem, over 10000 trials.

The sampling policies are compared on random
Bernoulli selection problem instances. Figure 3 shows
results for randomly-generated selection problems with
25 Bernoulli arms, where the mean rewards of the arms
are distributed uniformly in [0 _,_ 1], for a range of sample
budgets 200 _.._ 2000, with multiplicative step of 2, averaging over 10000 trials. We compare UCB1 with the
policies based on the bounds in Equation (9) (VOI)
and Equation (10) (VOI+). UCB1 is always considerably worse than the VOI-aware sampling policies.

**6** **Sampling** **in** **trees**

The previous section addressed the selection problem
in the flat case. Selection in trees is more complicated. The goal of Monte-Carlo tree search (Chaslot

_~~n~~_ _i_ _i_ <sup>)2</sup> <sup>_ni_</sup>

<sup>_b_</sup> _i|i̸_ = _α_ <sup>_≤_</sup> <sup>ˆΛ</sup> _i_ <sup>_b_</sup>

_~~n~~_ _α_

<sup>_<u>−</u>_</sup> <sup>_<u>X</u>_</sup> _<u>α</u>_ <sup><u>)</u></sup>

_ni_

Λ <sup>_b_</sup> _i_ _̸_

_̸_ _i_ <sup>_b_</sup> <sup>=</sup> <sup><u>2</u></sup> <sup>_<u>N</u>_</sup> <sup><u>(1</u></sup> <sup>_<u>−</u>_</sup> <sup>_<u>X</u>_</sup>

exp

_−ϕ_ ( _X_

More refined bounds can be obtained through tighter
estimates on the probabilities in Equation (7), for
example, based on the empirical Bernstein inequal

et al., 2008) at the root node is usually to select an
action that appears to be the best based on outcomes
of _search_ _rollouts_ . But the goal of rollouts at non-root
nodes is different than at the root: here it is important to better approximate the value of the node, so
that selection at the root can be more informed. The
exact analysis of sampling at internal nodes is outside
the scope of this paper. At present we have no better
proposal for internal nodes than to use UCT there.

We thus propose the following hybrid sampling scheme
(Tolpin and Shimony, 2012a): at the _root node_, sample
based on the VOI estimate; at _non-root_ _nodes_, sample
using UCT.

Strictly speaking, even at the root node the stationarity assumptions <sup>6</sup> underlying our belief-state MDP
for selection do not hold exactly. UCT is an adaptive scheme, and therefore the values generated by
sampling at non-root nodes will typically cause values observed at children of the root node to be nonstationary. Nevertheless, sampling based on VOI estimates computed as for stationary distributions works
well in practice. As illustrated by the empirical evaluation (Section 6), estimates based on upper bounds
on the VOI result in good sampling policies, which exhibit performance comparable to the performance of
some state-of-the-art heuristic algorithms.

**6.1** **Stopping** **criterion**

When a sample has a known cost commensurable with
the value of information of a measurement, an upper
bound on the intrinsic VOI can also be used to stop
the sampling if the intrinsic VOI of any arm is less
than the total cost of sampling _C_ : max _i_ Λ _i_ _≤_ _C_ .

The VOI estimates of Equations (7) and (9) include
the remaining sample budget _N_ as a factor, but given
the cost of a single sample _c_, the cost of the remaining
samples accounted for in estimating the intrinsic VOI
is _C_ = _cN_ . _N_ can be dropped on both sides of the
inequality, giving a reasonable stopping criterion:

_α_ <sup>_≤_</sup> <sup>_X_</sup>

<sup>_b_</sup>

<u>1</u> _α_
_N_ <sup>Λ</sup> <sup>_b_</sup>

_~~n~~_ _β_
_<u>β</u>_

<sup>_X_</sup>

_nα_

Pr( _X_

_~~n~~_ _α_ + _N_ _~~n~~_ _α_
_α_ _≤_ _X_ _β_ <sup>)</sup> <sup>_≤_</sup> <sup>_c_</sup>

<u>1</u>
_N_ <sup>max</sup> _i_

_~~n~~_ _α_
_α_ <sup>)</sup> <sup>_≤_</sup> <sup>_c_</sup>

Λ <sup>_b_</sup> _i_

<sup>max</sup> _i_

_i_

<sup>_b_</sup> _i_ <sup>_≤_</sup> <sup>max</sup>

_~~n~~_ _α_

<u>(1</u> _<u>−</u>_ _<u>X</u>_ _<u>α</u>_ <sup><u>)</u></sup>

_ni_

_~~n~~_ _i_ + _N_

Pr( _X_ _i_ _≥_ _X_

_∀i_ : _i̸_ = _α_ (11)

The empirical evaluation (Section 6) confirms the viability of this stopping criterion and illustrates the influence of the sample cost _c_ on the performance of the
sampling policy. When the sample cost _c_ is unknown,

6This is not a restriction, however, of the general formalism in Section 2.

one can perform initial calibration experiments to determine a reasonable value, as done in the following.

**6.2** **Sample** **redistribution** **in** **trees**

The above hybrid approach assumes that the information obtained from rollouts in the current state is discarded after an real-world action is selected. In practice, many successful Monte-Carlo tree search algorithms reuse rollouts generated at earlier search states,
if the sample traverses the current search state during
the rollout; thus, the value of information of a rollout
is determined not just by the influence on the choice of
the action at the current state, but also by its potential
influence on the choice at future search states.

One way to account for this reuse would be to incorporate the ‘future’ value of information into a VOI
estimate. However, this approach requires a nontrivial extension of the theory of metareasoning for search.
Alternately, one can behave myopically with respect to
the search tree depth:

1. Estimate VOI as though the information is discarded after each step,

2. Stop early if the VOI is below a certain threshold
(see Section 6.1), and

3. Save the unused sample budget for search in future states, such that if the nominal budget is _N_,
and the unused budget in the last state is _Nu_, the
search budget in the next state will be _N_ + _Nu_ .

In this approach, the cost _c_ of a sample in the current
state is the VOI of increasing the budget of a future
state by one sample. It is unclear whether this cost can
be accurately estimated, but supposing a fixed value
for a given problem type and algorithm implementation would work. Indeed, the empirical evaluation
(Section 6.3) confirms that stopping and sample redistribution based on a learned fixed cost substantially
improve the performance of the VOI-based sampling
policy in game tree search.

**6.3** **Playing** **Go** **against** **UCT**

The hybrid policies were compared on the game Go, a
search domain in which UCT-based MCTS has been
particularly successful (Gelly and Wang, 2006). A
modified version of Pachi (Braudiˇs and Loup Gailly,
2011), a state of the art Go program, was used for the
experiments:

_•_ The UCT engine of Pachi was extended with VOIaware sampling policies at the first step.

_•_ The stopping criterion for the VOI-aware policy
was modified and based solely on the sample cost,
specified as a constant parameter. The heuristic
stopping criterion for the original UCT policy was
left unchanged.

_•_ The time-allocation model based on the fixed
number of samples was modified for _both_ _the_ _orig-_
_inal_ _UCT_ _policy_ _and_ _the_ _VOI-aware_ _policies_ such
that

**–** Initially, the same number of samples is avail
able to the agent at each step, independently
of the number of pre-simulated games;

**–** If samples were unused at the current step,

they become available at the next step.

While the UCT engine is not the most powerful engine of Pachi, it is still a strong player. On the other
hand, additional features of more advanced engines
would obstruct the MCTS phenomena which are the
subject of the experiment. The engines were com

|Col1|G<br>G<br>G|Col3|Col4|Col5|Col6|
|---|---|---|---|---|---|
|||||||
|||||||
|G|G|G|G|G|G|
|G|G|||||

|Col1|Col2|G 5000<br>7000<br>10000<br>15000|
|---|---|---|
|G<br>|G<br>G<br>G<br>G|G<br>G<br>G<br>G|
|1e−07<br>1e−05<br>1e−03<br>c<br>0<br>1e−06<br>1e−04|1e−07<br>1e−05<br>1e−03<br>c<br>0<br>1e−06<br>1e−04|1e−07<br>1e−05<br>1e−03<br>c<br>0<br>1e−06<br>1e−04|

Figure 4: Winning rate of the VOI-aware policy in
Go as a function of the cost _c_, for varying numbers of
samples per ply.

pared on the 9x9 board, for 5000, 7000, 1000, and
15000 samples (game simulations) per ply, each experiment repeated 1000 times. Figure 4 depicts a calibration experiment, showing the winning rate of the
VOI-aware policy against UCT as a function of the
stopping threshold _c_ (if the maximum VOI of a sample is below the threshold, the simulation is stopped,
and a move is chosen). Each curve in the figure corresponds to a certain number of samples per ply. For
the stopping threshold of 10 <sup>_−_</sup> <sup>6</sup>, the VOI-aware policy
is almost always better than UCT, and reaches the
winning rate of 64% for 10000 samples per ply.

Figure 5 shows the winning rate of VOI against UCT
_c_ = 10 <sup>_−_</sup> <sup>6</sup> . In agreement with the intuition (Figure 6.2), VOI-based stopping and sample redistribution is most influential for intermediate numbers of
samples per ply. When the maximum number of samples is too low, early stopping would result in poorly

5000 7000 10000 15000

Nsamples

Figure 5: Winning rate of the VOI-aware policy in
Go as a function of the number of samples, fixing cost
_c_ = 10 <sup>_−_</sup> <sup>6</sup> .

selected moves. On the other hand, when the maximum number of samples is sufficiently high, the VOI
of increasing the maximum number of samples in a
future state is low.

Note that if we disallowed reuse of samples in both
Pachi and in our VOI-based scheme, the VOI basedscheme win rate is even higher than shown in Figure 5.
This is as expected, as this setting (which is somewhat
unfair to Pachi) is closer to meeting the assumptions
underlying the selection MDP.

**7** **Conclusion**

The selection problem has numerous applications.
This paper formalized the problem as a belief-state
MDP and proved some important properties of the
resulting formalism. An application of the selection
problem to control of sampling was examined, and the
insights provided by properties of the MDP led to approximate solutions that improve the state of the art.
This was shown in empirical evaluation both in “flat”
selection and when extending the methods to gametree search for the game of Go.

The methods proposed in the paper open up several
new research directions. The first is a better approximate solution of the MDP, that should lead to even
better flat sampling algorithms for selection. A more
ambitious goal is extending the formalism to trees—
in particular, achieving better sampling at non-root
nodes, for which the purpose of sampling differs from
that at the root.

**Acknowledgments**

The research is partially supported by Israel Science
Foundation grant 305/09, National Science Foundation grant IIS-0904672, DARPA DSO FA8650-11-17153, the Lynne and William Frankel Center for Computer Sciences, and by the Paul Ivanier Center for
Robotics Research and Production Management.

**References**

J. Audibert, S. Bubeck, et al. Best arm identification

in multi-armed bandits. In _COLT_, 2010.

P. Auer, N. Cesa-Bianchi, and P. Fischer. Finite-time

analysis of the multiarmed bandit problem. _Machine_
_Learning_, 2002.

R. Bechhofer. A single-sample multiple decision pro
cedure for ranking means of normal populations
with known variances. _The_ _Annals_ _of_ _Mathemati-_
_cal_ _Statistics_, 25(1):16–39, 1954.

D. Berry and B. Fristedt. _Bandit_ _problems:_ _sequen-_

_tial_ _allocation_ _of_ _experiments_ . Chapman and Hall
London, 1985.

P. Braudiˇs and J. Loup Gailly. Pachi: State of the art

open source Go program. In _ACG_ _13_, 2011.

S. Bubeck, R. Munos, and G. Stoltz. Pure exploration in finitely-armed and continuous-armed bandits. _Theor. Comput. Sci._, 412(19):1832–1852, 2011.

G. Chaslot, S. Bakkes, I. Szita, and P. Spronck. Monte
Carlo tree search: A new framework for game AI.
In _AIIDE_, 2008.

T. Dean and M. Boddy. An analysis of time-dependent

planning. In _AAAI-88_, pages 49–54, 1988.

J. Doyle. Artificial intelligence and rational selfgovernment. Technical Report CMU-CS-88-124,
Computer Science Department, Carnegie-Mellon
University, Pittsburgh, PA, 1988.

M. Fehling and J. Breese. A computational model
for the decision-theoretic control of problem solving under uncertainty. In _Proceedings_ _of_ _the_ _Fourth_
_Workshop_ _on_ _Uncertainty_ _in_ _Artificial_ _Intelligence,_
_Minneapolis,_ _MN:_ _AAAI_, 1988.

P. Frazier and W. Powell. Paradoxes in learning and

the marginal value of information. _Decision_ _Analy-_
_sis_, 2010.

S. Gelly and D. Silver. Monte-carlo tree search and

rapid action value estimation in computer go. _Arti-_
_ficial_ _Intelligence_, 2011.

S. Gelly and Y. Wang. Exploration exploitation in Go:

UCT for Monte-Carlo Go. _Computer_, 2006.

J. Gittins. Bandit processes and dynamic allocation

indices. _Journal_ _of_ _the_ _Royal_ _Statistical_ _Society._ _Se-_
_ries_ _B_ _(Methodological)_, pages 148–177, 1979.

J. Gittins. _Multi-armed bandit allocation indices_ . John

Wiley & Sons, 1989.

I. J. Good. A five-year plan for automatic chess. In

E. Dale and D. Michie, editors, _Machine Intelligence_
_2_, pages 89–118. Oliver and Boyd, 1968.

D. Harada. Reinforcement learning with time. In _Proc._

_Fourteenth_ _National_ _Conference_ _on_ _Artificial_ _Intel-_
_ligence_, pages 577–582. AAAI Press, 1997.

W. Hoeffding. Probability inequalities for sums of
bounded random variables. _Journal_ _of_ _the_ _Ameri-_
_can_ _Statistical_ _Association_, 58(301):pp. 13–30, 1963.
ISSN 01621459.

E. J. Horvitz. Reasoning about beliefs and actions under computational resource constraints. In
_UAI_ . American Association for Artificial Intelligence, July 1987. Also in L. Kanal, T. Levitt, and J.
Lemmer, ed., _Uncertainty_ _in_ _Artificial_ _Intelligence_
_3,_ Elsevier, 1988, pps. 301-324.

R. A. Howard. Information value theory. _IEEE_ _Trans-_

_actions_ _on_ _Systems_ _Science_ _and_ _Cybernetics_, 1966.

L. Kocsis and C. Szepesv´ari. Bandit based monte-carlo

planning. _ECML_, 2006.

O. Madani, D. Lizotte, and R. Greiner. Active model

selection. In _Proceedings_ _of_ _the_ _20th_ _conference_ _on_
_Uncertainty_ _in_ _artificial_ _intelligence_, pages 357–365.
AUAI Press, 2004.

J. E. Matheson. The economic value of analysis and

computation. _Systems_ _Science_ _and_ _Cybernetics_, 4:
325–332, 1968.

A. Maurer and M. Pontil. Empirical Bernstein bounds

and sample-variance penalization. In _COLT_, 2009.

M. Puterman. _Markov_ _decision_ _processes:_ _Discrete_
_stochastic_ _dynamic_ _programming_ . John Wiley &
Sons, Inc., 1994.

S. Russell and E. Wefald. _Do_ _The_ _Right_ _Thing_ . The

MIT Press, 1991a.

S. Russell and E. Wefald. Principles of metareasoning.

_Artificial_ _Intelligence_, 1991b.

S. J. Russell and E. H. Wefald. Decision-theoretic con
trol of search: General theory and an application to
game-playing. Technical Report UCB/CSD 88/435,
Computer Science Division, University of California,
Berkeley, 1988.

J. R. Swisher, S. H. Jacobson, and E. Y¨ucesan.

Discrete-event simulation optimization using ranking, selection, and multiple comparison procedures:
A survey. _ACM Transactions on Modeling and Com-_
_puter_ _Simulation_, 2003.

D. Tolpin and S. E. Shimony. MCTS based on simple

regret. In _AAAI_ . AAAI Press, 2012a. To appear.

D. Tolpin and S. E. Shimony. Semimyopic measure
ment selection for optimization under uncertainty.
_IEEE_ _Transactions_ _on_ _Systems,_ _Man,_ _and_ _Cyber-_
_netics,_ _Part_ _B_, 42(2):565–579, 2012b.

A. Wald. Sequential tests of statistical hypotheses. _An-_

_nals_ _of_ _Mathematical_ _Statistics_, 16:117–186, 1945.
