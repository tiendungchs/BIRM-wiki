# hansen-2001-lao-star-heuristic-search-solutions-with-loops

> Converted from `hansen-2001-lao-star-heuristic-search-solutions-with-loops.pdf` on 2026-11-18 via `pymupdf4llm`.
> Layout artefacts (broken equations, interleaved columns) are conversion noise, not the source.

---

Artificial Intelligence 129 (2001) 35–62

# LAO*: A heuristic search algorithm that finds solutions with loops

Eric A. Hansen <sup>a</sup> <sup>_,_</sup> <sup>∗</sup>, Shlomo Zilberstein <sup>b</sup>

a _Computer Science Department, Mississippi State University,_ _Mississippi State, MS 39762, USA_

b _Computer Science Department, University of Massachusetts, Amherst, MA 01002, USA_

Received 15 February 2000; received in revised form 8 March 2001

**Abstract**

Classic heuristic search algorithms can find solutions that take the form of a simple path (A*), a
tree, or an acyclic graph (AO*). In this paper, we describe a novel generalization of heuristic search,
called LAO*, that can find solutions with loops. We show that LAO* can be used to solve Markov
decision problems and that it shares the advantage heuristic search has over dynamic programming
for other classes of problems. Given a start state, it can find an optimal solution without evaluating
the entire state space.  2001 Elsevier Science B.V. All rights reserved.

_Keywords:_ Heuristic search; Dynamic programming; Markov decision problems

**1.** **Introduction**

One of the most widely-used frameworks for problem-solving in artificial intelligence
is state-space search. A state-space search problem is defined by a set of states, a set of
actions (or operators) that map states to successor states, a start state, and a set of goal
states. The objective is to find a sequence of actions that transforms the start state into a
goal state, and also optimizes some measure of the quality of the solution.

Two well-known heuristic search algorithms for state-space search problems are A* and
AO* [18]. A* finds a solution that takes the form of a sequence of actions leading in a path
from the start state to a goal state. AO* finds a solution that has a conditional structure
and takes the form of a tree, or more generally, an acyclic graph. But no heuristic search

 - Corresponding author.
_E-mail address:_ hansen@cs.msstate.edu (E.A. Hansen).

0004-3702/01/$ – see front matter  2001 Elsevier Science B.V. All rights reserved.
PII: S0004-3702(01)00106-0

36 _E.A. Hansen, S. Zilberstein / Artificial Intelligence_ _129 (2001) 35–62_

algorithm has been developed that can find a solution that takes the form of a cyclic graph,
that is, a solution with loops.

For many problems that can be formalized in the state-space search model, it does not
make sense for a solution to contain loops. A loop in a solution to a theorem-proving
problem represents circular reasoning. A loop in a solution to a problem-reduction task
represents a failed reduction to primitive subproblems. However, there is an important
class of problems for which it does make sense for a solution to contain loops. These
problems can be formalized as Markov decision processes, a framework that is widely
used in artificial intelligence for problems of planning and learning under uncertainty [1,
5]. A _Markov decision process_ (MDP) models problems of sequential decision making that
include actions that transform a state into one of several possible successor states, with each
possible state transition occurring with some probability. A solution to an MDP takes the
form of a mapping from states to actions called a _policy_ . A policy is executed by observing
the current state and taking the action prescribed for it. A solution represented in this
way implicitly contains both branches and loops. Branching is present because the state
that stochastically results from an action determines the next action. Looping is present
because the same state may be revisited under a policy. (As an example of a plan with a
conditional loop, consider an action that has its desired effect with probability less than
one and otherwise has no effect. An appropriate plan might be to repeat the action until it
“succeeds”.)

An optimal policy can be found using a dynamic programming algorithm such as policy
iteration or value iteration [2]. But a disadvantage of dynamic programming is that it
evaluates the entire state space. In effect, it finds a policy for every possible starting
state. By contrast, heuristic search algorithms solve a problem for a particular starting
state and use an admissible heuristic to focus the search, and remove from consideration
regions of the state space that can’t be reached from the start state by an optimal solution.
For problems with large state spaces, heuristic search has an advantage over dynamic
programming because it can find an optimal solution for a start state without evaluating
the entire state space.

This advantage is well-known for problems that can be solved by A* or AO*. In fact, an
important theorem about the behavior of A* is that (under certain conditions) it evaluates
the minimal number of states among all algorithms that find an optimal solution using the
same heuristic [7]. A related result has also been established for AO* [3]. In this paper,
we generalize the heuristic search approach to find solutions with loops and show that the
resulting algorithm, which we call LAO*, can solve planning problems that are formalized
as MDPs.

The paper is organized as follows. Section 2 reviews dynamic programming algorithms
for MDPs and heuristic search algorithms for state-space search problems, and discusses
their relationship. Section 3 introduces the LAO* algorithm and Section 4 describes some
extensions of this algorithm that illustrate the relevance of heuristic search techniques
to the problem of solving MDPs more efficiently. Section 5 describes the performance
of LAO* on two test problems, and discusses some search control issues that affect its
efficiency.

_E.A. Hansen, S. Zilberstein / Artificial Intelligence_ _129 (2001) 35–62_ 37

**2.** **Background**

We begin with a review of MDPs and dynamic programming algorithms for solving
them. We then review the heuristic search algorithm AO*, and discuss the relationship
between dynamic programming and heuristic search.

_2.1._ _Markov decision processes_

We consider an MDP with a finite set of states, _S_ . For each state _i_ ∈ _S_, let _A(i)_ denote
a finite set of actions available in that state. Let _pij_ _(a)_ denote the probability that taking
action _a_ in state _i_ results in a transition to state _j_ . Let _ci(a)_ denote the expected immediate
cost of taking action _a_ in state _i_ .

We focus on a special class of MDPs called _stochastic_ _shortest-path_ _problems_ [2]
because it generalizes traditional shortest-path problems for which artificial intelligence
(AI) search algorithms have been developed. (The name “shortest-path” reflects an
interpretation of action costs as arc lengths.) A stochastic shortest-path problem is an MDP
with a set of terminal states, _T_ ⊆ _S_ . For every terminal state _i_ ∈ _T_, no action can cause a
transition out of this state (i.e., it is an absorbing state) and the immediate cost of any action
taken in this state is zero. Formally, _pii(a)_ = 1 and _ci(a)_ = 0 for all _i_ ∈ _T_ and _a_ ∈ _A(i)_ .
For all other states, immediate costs are assumed to be positive for every action, that is,
_ci(a) >_ 0 for all states _i_ ∈ _/_ _T_ and actions _a_ ∈ _A(i)_ . The objective is to reach a terminal
state while incurring minimum expected cost. Thus, we can think of terminal states as goal
states and we will use the terms “terminal state” and “goal state” interchangeably from
now on. Because the probabilistic outcomes of actions can create a nonzero probability
of revisiting the same state, the worst-case number of steps needed to reach a goal state
cannot be bounded. Hence, stochastic shortest-path problems are said to have an _indefinite_
_horizon_ .

A solution to an indefinite-horizon MDP can be represented as a stationary mapping
from states to actions, _π_ : _S_ → _A_, called a _policy_ . A policy is said to be _proper_ if, for every
state, it ensures that a goal state is reached with probability 1.0. For a proper policy, the
expected cost for reaching a goal state from each state _i_ ∈ _S_ is finite and can be computed
by solving the following system of | _S_ | linear equations in | _S_ | unknowns:

_f_ <sup>_π_</sup> _(i)_ =

- 0 if _i_ is a goal state,

(1)

_ci_ _(π(i))_ + <sup>�</sup> _j_ ∈ _S_ <sup>_pij_</sup> <sup>_(π(i))f π_</sup> <sup>_(j)_</sup> otherwise.

We call _f_ <sup>_π_</sup> the _evaluation function_ of policy _π_ . We assume that the stochastic shortest-path
problems we consider have at least one proper policy, and that every improper policy has
infinite expected cost for at least one state. This assumption is made by Bertsekas [2] in
developing the theory of stochastic shortest-path problems. It generalizes the assumption
for deterministic shortest-path problems that there is a path to the goal state from every
other state, and all cycles have positive cost.

A policy _π_ is said to dominate a policy _π_ <sup>′</sup> if _f_ <sup>_π_</sup> _(i)_ ⩽ _f_ <sup>_π_</sup> <sup>′</sup> _(i)_ for every state _i_ . An optimal
policy, _π_ <sup>∗</sup>, dominates every other policy, and its evaluation function, _f_ <sup>∗</sup>, satisfies the

38 _E.A. Hansen, S. Zilberstein / Artificial Intelligence_ _129 (2001) 35–62_

following system of | _S_ | nonlinear equations in | _S_ | unknowns, called the Bellman optimality
equation:

_f_ <sup>∗</sup> _(i)_ =

- 0 if _i_ is a goal state,

      -       
min _a_ ∈ _A(i)_ _ci(a)_ + <sup>�</sup> _j_ ∈ _S_ <sup>_pij_</sup> <sup>_(a)f_</sup> <sup>∗</sup> <sup>_(j)_</sup> otherwise.

- _ci(a)_ + <sup>�</sup>

_j_ ∈ _S_ <sup>_pij_</sup> <sup>_(a)f_</sup> <sup>∗</sup> <sup>_(j)_</sup>

if _i_ is a goal state,

- (2)
otherwise.

Dynamic programming algorithms for MDPs find the evaluation function that satisfies
the Bellman equation by successively improving an estimated evaluation function, _f_, by
performing _backups_ . For each state _i_, a backup takes the following form:

_j_ ∈ _S_

_pij (a)f (j)_

_f (i)_ := min

_ci(a)_ +

_._ (3)

_a_ ∈ _A(i)_

Performing a backup for every state _i_ in the state set is referred to as a _dynamic-_
_programming update_ . It is the core step of dynamic-programming algorithms for solving
MDPs. The fact that a backup is performed for every state in the state set is characteristic
of dynamic programming, which evaluates all problem states.

There are two related dynamic programming algorithms for indefinite-horizon MDPs:
policy iteration and value iteration. Policy iteration is summarized in Table 1. It interleaves
the dynamic-programming update, used for policy improvement, with policy evaluation.
When the current policy _π_ is not optimal, the dynamic-programming update finds a new
policy _π_ <sup>′</sup> such that _f_ <sup>_π_</sup> <sup>′</sup> _(i)_ ⩽ _f_ <sup>_π_</sup> _(i)_ for every state _i_ and _f_ <sup>_π_</sup> <sup>′</sup> _(i) < f_ <sup>_π_</sup> _(i)_ for at least one
state _i_ . Because the number of possible policies is finite and policy iteration improves the
current policy each iteration, it converges to an optimal policy after a finite number of
iterations.

Value iteration is summarized in Table 2. Each iteration, it improves an evaluation
function _f_ by performing a dynamic programming update. When the evaluation function

Table 1
Policy iteration

1. Start with an initial policy _π_ .

2. _Evaluate policy_ : Compute the evaluation function _f_ <sup>_π_</sup> for policy _π_ by solving the following set
of | _S_ | equations in | _S_ | unknowns,

_f_ <sup>_π_</sup> _(i)_ = _ci_ _(π(i))_ +

_j_ ∈ _S_

_pij_ _(π(i))f_ <sup>_π_</sup> _(j)._

3. _Improve policy_ : For each state _i_ ∈ _S_, let

      
_π_ <sup>′</sup> _(i)_ := arg min

_a_ ∈ _A(i)_

 
_ci_ _(a)_ +

_j_ ∈ _S_

_pij (a)f_ <sup>_π_</sup> _(j)_

_._

Resolve ties arbitrarily, but give preference to the currently selected action.

4. _Convergence_ _test_ : If _π_ <sup>′</sup> is the same as _π_, go to step 5. Otherwise, set _π_ = _π_ <sup>′</sup> and go to step 2.

5. Return an optimal policy.

_E.A. Hansen, S. Zilberstein / Artificial Intelligence_ _129 (2001) 35–62_ 39

Table 2
Value iteration

1. Start with an initial evaluation function _f_ and parameter _ε_ for detecting convergence to an
_ε_ -optimal evaluation function.

2. _Improve evaluation function_ : For each state _i_ ∈ _S_,

    

_pij (a)f (j)_ _._

_f_ <sup>′</sup> _(i)_ := min

_a_ ∈ _A(i)_

_ci_ _(a)_ +

_j_ ∈ _S_

3. _Convergence_ _test_ : If the error bound of the evaluation function is less than or equal to _ε_, go to
step 4. Otherwise, set _f_ = _f_ <sup>′</sup> and go to step 2.

4. Extract an _ε_ -optimal policy from the evaluation function as follows. For each state _i_ ∈ _S_,

_j_ ∈ _S_

_π(i)_ := arg min

_a_ ∈ _A(i)_

_ci_ _(a)_ +

_pij (a)f (j)_

_._

is sufficiently close to optimal, as measured by an error bound, a policy can be extracted
from the evaluation function as follows:

_j_ ∈ _S_

_pij (a)f (j)_

_._ (4)

_π(i)_ := arg min

_ci(a)_ +

_a_ ∈ _A(i)_

For stochastic shortest-path problems, an error bound can be computed based on the
_Bellman residual_ of the dynamic programming update, which is

_r_ = max

_i_ ∈ _S_

�� _f_ ′ _(i)_ - _f (i)_ �� _,_ (5)

and the mean first passage times for every state _i_ under the current policy _π_ . The _mean_
_first passage time_ for state _i_ under policy _π_, denoted _φ_ <sup>_π_</sup> _(i)_, is the expected number of time
steps it takes to reach a goal state, beginning from state _i_ and following policy _π_ . Mean
first passage times can be computed by solving the following system of linear equations
for all _i_ ∈ _S_ :

  
_pij_ _π(i)_

_φ_ <sup>_π_</sup> _(j)._ (6)

_φ_ <sup>_π_</sup> _(i)_ = 1 +

_j_ ∈ _S_

Given the Bellman residual and mean first passage times, a lower bound, _f_ <sup>_L_</sup>, on the optimal
evaluation function, _f_ <sup>∗</sup>, is given by:

_f_ <sup>_L_</sup> _(i)_ = _f_ <sup>_π_</sup> _(i)_   - _φ_ <sup>_π_</sup> _(i)_ _r,_ (7)

where _f_ <sup>_π_</sup> is the evaluation function of policy _π_ . For value iteration, an upper bound, _f_ <sup>_U_</sup>,
on the optimal evaluation function is given by:

_f_ <sup>_U_</sup> _(i)_ = _f_ <sup>_π_</sup> _(i)_ + _φ_ <sup>_π_</sup> _(i)_ _r._ (8)

For policy iteration, the current evaluation function is an upper bound on the optimal
evaluation function. The maximum difference between the upper and lower bounds,

40 _E.A. Hansen, S. Zilberstein / Artificial Intelligence_ _129 (2001) 35–62_

Table 3
Trial-based RTDP

1. Start with an admissible evaluation function _f_ .

2. Repeat the following trial _n_ times.

_Trial_ : Set the current state _i_ to the start state and repeat the following steps _m_ times or until a goal state
is reached.

(a) Improve the evaluation function by performing the following backup for the current state _i_,

_._

_f (i)_ := min

_a_ ∈ _A(i)_

_ci_ _(a)_ +

_pij (a)f (j)_

_j_ ∈ _S_

(b) Take the action determined to be best for state _i_ by the backup and change the current state _i_ to the
state that results from a stochastic transition caused by the action.

3. Extract a partial policy from evaluation function _f_ as follows. For each state _i_ ∈ _S_ that can be reached
from the start state by selecting actions greedily,

_π(i)_ := arg min

_a_ ∈ _A(i)_

  
_ci_ _(a)_ +

_j_ ∈ _S_

_pij_ _(a)f (j)_

_._

defined as max _i_ ∈ _S_ | _f_ <sup>_U_</sup> _(i)_ - _f_ <sup>_L_</sup> _(i)_ |, gives a bound on the error of the current solution.
A solution is _ε_ -optimal if the error bound is less than _ε_ . For any real number _ε >_ 0, both
policy iteration and value iteration converge to an _ε_ -optimal solution after a finite number
of iterations.

_Real-time_ _dynamic_ _programming_ We are particularly interested in stochastic shortestpath problems that include a start state, _s_ ∈ _S_, and for which the objective is to find a
solution that minimizes the expected cost of reaching a goal state from the start state.
Bertsekas [2] does not discuss this special case of a stochastic shortest-path problem.
However, Barto et al. [1] do and note that it generalizes the classic AI search problem
of finding a minimum-cost path from a start state to a goal state. Because finding
a minimum-cost solution from a start state to a goal state is a special case of the
problem of finding a minimum-cost solution from every state to a goal state, it can
be solved using either policy iteration or value iteration. However, neither of these
algorithms uses knowledge of the start state to focus computation on just those states
that are reachable from the start state by following an optimal policy. Instead, both repeat
an improvement step (the dynamic programming update) that updates the evaluation
function for all states. In effect, both algorithms solve an MDP for all possible starting
states.

Barto et al. [1] describe an algorithm called _real-time_ _dynamic_ _programming_ (RTDP)
that avoids exhaustive evaluation of the state set. Table 3 summarizes _trial-based RTDP_,
which solves an MDP by organizing computation as a sequence of trials. Each trial consists
of a sequence of steps. In each step, an action is selected based on lookahead search of

_E.A. Hansen, S. Zilberstein / Artificial Intelligence_ _129 (2001) 35–62_ 41

depth one or more, and the current state is updated based on the outcome of the action. In
addition, the evaluation function is updated for a subset of states that includes the current
state. At the beginning of each trial, the current state is set to the start state. A trial ends
when the goal state is reached, or after a specified number of steps. An important feature of
trial-based RTDP is that the evaluation function is only updated for states that are reached
from the start state when actions are selected greedily based on the current evaluation
function. Thus, RTDP may ignore large regions of the state space. Barto et al. [1] prove
that under certain reasonable conditions, RTDP converges (asymptotically) to an optimal
solution without necessarily evaluating the entire state space. They relate this result to
heuristic search theory by showing that it generalizes the convergence theorem of Korf’s
learning real-time heuristic search algorithm (LRTA*) [11].

Dean et al. [5] describe a related algorithm that performs policy iteration on a subset
of the states of an MDP, using various methods to identify the most relevant states
and gradually increasing the subset until eventual convergence (or until the algorithm is
stopped). The subset of states is called an _envelope_ and a policy defined on this subset
of states is called a _partial policy_ . Adding states to an envelope is similar to expanding a
partial solution in a search graph and the idea of using a heuristic to evaluate the fringe
states of an envelope has been explored [6,21]. However, this algorithm is presented as
a modification of policy iteration (and value iteration), rather than a generalization of
heuristic search. In particular, the assumption is explicitly made that convergence to an
optimal policy requires evaluating the entire state space.

Both RTDP and the related envelope algorithm are motivated by the problem of search
(or planning) in real time. Both allow search to be interleaved with execution. The time
constraint on search is usually the time before the next action needs to be executed, and
both Dean et al. [5] and Tash and Russell [21] describe decision-theoretic approaches to
optimizing the value of search in the interval between actions. The possibility of using
real-time search to solve MDPs raises the following question: is there an off-line heuristic
search algorithm that can solve MDPs? Before addressing this question directly, we review
the framework of state-space heuristic search.

_2.2._ _Heuristic search in AND/OR graphs_

Like an MDP, a state-space search problem is defined by a set of states (including a start
state and a set of goal states), a set of actions that cause state transitions, and a cost function
that specifies costs for state transitions. The objective is to find a minimal-cost path from
the start state to a goal state. It is customary to formalize a state-space search problem as a
graph in which each node of the graph represents a problem state and each arc represents a
state transition that results from taking an action. We use the same notation for state-space
search problems as for MDPs. Let _S_ denote the set of possible states, let _s_ ∈ _S_ denote a
start state that corresponds to the root of the graph, and let _T_ ⊂ _S_ denote a set of goal (or
terminal) states that occur at the leaves of the graph. Let _A_ denote a finite set of actions
and let _A(i)_ denote the set of actions applicable in state _i_ .

The most general state-space search problem considered in the AI literature is AND/OR
graph search. Following Martelli and Montanari [14] and Nilsson [18], we define an
AND/OR graph as a hypergraph. Instead of arcs that connect pairs of states as in an

42 _E.A. Hansen, S. Zilberstein / Artificial Intelligence_ _129 (2001) 35–62_

Fig. 1. (a) shows an OR node with two arcs leaving it, one for action _a_ 1 and one for action _a_ 2. Each arc leads to an
AND node with two successor OR nodes, one for each possible successor state. (By convention, a square denotes
an OR node and a circle denotes an AND node. In the terminology of decision analysis, a square corresponds
to a choice node and a circle corresponds to a chance node.) (b) shows a state, indicated by a circle, with two
2-connectors leaving it, one for action _a_ 1 and one for action _a_ 2. Each 2-connector leads to two possible successor
states. The representation on the right, using state nodes and _k_ -connectors, is equivalent to the representation on
the left, which uses OR and AND nodes.

ordinary graph, a hypergraph has _hyperarcs_ or _k-connectors_ that connect a state to a set
of _k_ successor states. Fig. 1 relates the concept of OR and AND nodes to the concept of a
hyperarc or _k_ -connector.

A _k_ -connector can be interpreted in different ways. In problem-reduction search, it is
interpreted as the transformation of a problem into _k_ subproblems. We consider problems
of planning under uncertainty in which it is interpreted as an action with an uncertain
outcome. The action transforms a state into one of _k_ possible successor states, with a
probability attached to each successor. We let _pij (a)_ denote the probability that taking
action _a_ in state _i_ results in a transition to state _j_ . This interpretation of AND/OR graphs
is made by Martelli and Montanari [14] and Pattipati and Alexandridis [19], among others.

In AND/OR graph search, a solution takes the form of an acyclic subgraph called a
_solution graph_, which is defined as follows:

 - the start state belongs to a solution graph;

 - for every nongoal state in a solution graph, exactly one outgoing _k_ -connector
(corresponding to an action) is part of the solution graph and each of its successor
states also belongs to the solution graph;

 - every directed path in the solution graph terminates at a goal state.
A cost function assigns a cost to each _k_ -connector. Let _ci(a)_ denote the cost for the _k_ connector that corresponds to taking action _a_ in state _i_ . We assume each goal state has a
cost of zero. A minimal-cost solution graph is found by solving the following system of
equations,

_f_ <sup>∗</sup> _(i)_ =

- 0 if _i_ is a goal state,
min _a_ ∈ _A(i)_ - _ci(a)_ + � _j_ ∈ _S_ <sup>_pij_</sup> <sup>_(a)f_</sup> <sup>∗</sup> <sup>_(j)_</sup> <sup>�</sup> otherwise,

if _i_ is a goal state,

(9)

- _ci(a)_ + � _j_ ∈ _S_ <sup>_pij_</sup> <sup>_(a)f_</sup> <sup>∗</sup> <sup>_(j)_</sup> <sup>�</sup> otherwise,

where _f_ <sup>∗</sup> _(i)_ denotes the cost of an optimal solution for state _i_ and _f_ <sup>∗</sup> is called the optimal
_evaluation function_ . Note that this is identical to the optimality equation defined for MDPs
in Eq. (2), although we now assume the solution can be represented as an acyclic graph.
This assumption means that a goal state can be reached from the start state after a bounded
number of actions (where the bound is equal to the longest path from the start state to a
goal state). By contrast, a stochastic shortest-path problem has an unbounded or indefinite

_E.A. Hansen, S. Zilberstein / Artificial Intelligence_ _129 (2001) 35–62_ 43

horizon. Thus the traditional framework of AND/OR graph search does not directly apply
to stochastic shortest-path problems.

_AO*_ For state-space search problems that are formalized as AND/OR graphs, an optimal
solution graph can be found using the heuristic search algorithm AO*. Nilsson [16,17] first
described a version of AO* for searching AND/OR trees to find a solution in the form of
a tree. Martelli and Montanari [13,14] generalized this algorithm for searching AND/OR
graphs to find a solution in the form of an acyclic graph. Nilsson [18] also used the name
AO* for this more general algorithm. Because any acyclic graph can be unfolded into an
equivalent tree, the tree-search and graph-search versions of AO* solve the same class of
problems. The graph-search version is more efficient when the same state can be reached
along different paths because it avoids performing duplicate searches.

Like other heuristic search algorithms, AO* can find an optimal solution without
considering every problem state. Therefore, a graph is not usually supplied explicitly to
the search algorithm. An implicit graph, _G_, is specified implicitly by a start state _s_ and
a successor function. The search algorithm constructs an _explicit_ _graph_, _G_ <sup>′</sup>, that initially
consists only of the start state. A tip or leaf state of the explicit graph is said to be terminal
if it is a goal state; otherwise, it is said to be nonterminal. A nonterminal tip state can be
expanded by adding to the explicit graph its outgoing _k_ -connectors (one for each action)
and any successor states not already in the explicit graph.

AO* solves a state-space search problem by gradually building a solution graph,
beginning from the start state. A _partial_ _solution_ _graph_ is defined similarly to a solution
graph, with the difference that the tip states of a partial solution graph may be nonterminal
states of the implicit AND/OR graph. A partial solution graph is defined as follows:

 - the start state belongs to a partial solution graph;

 - for every nontip state in a partial solution graph, exactly one outgoing _k_ -connector
(corresponding to an action) is part of the partial solution graph and each of its
successor states also belongs to the partial solution graph;

 - every directed path in a partial solution graph terminates at a tip state of the explicit
graph.
As with solution graphs, there are many possible partial solution graphs and an
evaluation function can be used to rank them. The cost of a partial solution graph is defined
similarly to the cost of a solution graph. The difference is that if a tip state of a partial
solution graph is nonterminal, it does not have a cost that can be propagated backwards.
Instead, we assume there is an admissible heuristic estimate _h(i)_ of the minimal-cost
solution graph for state _i_ . A heuristic evaluation function _h_ is said to be _admissible_ if
_h(i)_ ⩽ _f_ <sup>∗</sup> _(i)_ for every state _i_ . We can recursively calculate an admissible heuristic estimate
_f (i)_ of the optimal cost of any state _i_ in the explicit graph as follows:

_h(i)_ if _i_ is a nonterminal tip state,

     -      
min _a_ ∈ _A(i)_ _ci(a)_ + <sup>�</sup> _j_ ∈ _S_ <sup>_pij (a)f (j)_</sup> otherwise.

- _ci(a)_ + <sup>�</sup>

_j_ ∈ _S_ <sup>_pij (a)f (j)_</sup>

0 if _i_ is a goal state,

_f (i)_ =






otherwise. (10)

The best partial solution graph can be determined at any time by propagating heuristic
estimates from the tip states of the explicit graph to the start state. If we mark the action

44 _E.A. Hansen, S. Zilberstein / Artificial Intelligence_ _129 (2001) 35–62_

Table 4
AO*

1. The explicit graph _G_ <sup>′</sup> initially consists of the start state _s_ .

2. While the best solution graph has some nonterminal tip state:

(a) _Expand best partial solution_ : Expand some nonterminal tip state _n_ of the best partial solution graph and

add any new successor states to _G_ <sup>′</sup> . For each new state _i_ added to _G_ <sup>′</sup> by expanding _n_, if _i_ is a goal state
then _f (i)_ := 0; else _f (i)_ := _h(i)_ .

(b) _Update state costs and mark best actions_ :

i. Create a set _Z_ that contains the expanded state and all of its ancestors in the explicit graph along

marked action arcs. (I.e., only include ancestor states from which the expanded state can be reached
by following the current best solution.)
ii. Repeat the following steps until _Z_ is empty.

A. Remove from _Z_ a state _i_ such that no descendent of _i_ in _G_ <sup>′</sup> occurs in _Z_ .
B. Set _f (i)_ := min _a_ ∈ _A(i)_ [ _ci_ _(a)_ + <sup>�</sup> _j_ <sup>_pij_</sup> <sup>_(a)f (j)_</sup> <sup>]</sup> <sup>and</sup> <sup>mark</sup> <sup>the</sup> <sup>best</sup>

Set _f (i)_ := min _a_ ∈ _A(i)_ [ _ci_ _(a)_ + <sup>�</sup> _j_ <sup>_pij_</sup> <sup>_(a)f (j)_</sup> <sup>]</sup> <sup>and</sup> <sup>mark</sup> <sup>the</sup> <sup>best</sup> <sup>action</sup> <sup>for</sup> <sup>_i_</sup> <sup>.</sup> <sup>(When</sup>

determining the best action resolve ties arbitrarily, but give preference to the currently marked
action.)

3. Return an optimal solution graph.

that minimizes the value of each state, the best partial solution graph can be determined by
starting at the root of the graph and selecting the best action for each reachable state.

Table 4 outlines the algorithm AO* for finding a minimal-cost solution graph in an
acyclic AND/OR graph. It interleaves forward expansion of the best partial solution with
a cost revision step that updates estimated state costs and the best partial solution. In the
simplest version of AO*, the costs of the expanded state and all of its ancestor states in the
explicit graph are updated [13]. However, Martelli and Montanari [14] and Nilsson [18]
note that the only ancestor states that may have their costs change are those from which
the expanded state can be reached by taking marked actions (i.e., by choosing the best
action for each state). Thus, the parenthetical remark in step 2(b)i of Table 4 indicates that
a parent _i_ of state _j_ is not added to _Z_ unless both the estimated cost of state _j_ has changed,
and state _j_ can be reached from state _i_ by choosing the best action for state _i_ .

To simplify exposition, we have omitted from our outline of AO* a solve-labeling
procedure that is often included in the algorithm to improve efficiency. Briefly, a state
is labeled solved if it is a goal state or if all of its successor states are labeled solved.
Labeling states as solved can improve the efficiency of the solution expansion step because
it is unnecessary to search below a solved state for nonterminal tip states.

We also note that the best partial solution graph may have many nonterminal tip states.
AO* works correctly no matter which of these tip states is chosen for expansion. However,
the efficiency of AO* can be improved by using a good selection function to choose which
nonterminal tip state of the best partial solution graph to expand next. Possibilities include
selecting the tip state with the least estimated cost, or selecting the tip state with greatest
probability of being reached.

Although AND/OR graphs are usually assumed to be acyclic, the possibility of searching
cyclic AND/OR graphs has been studied [10]. In previous work, however, the solution
graph is assumed to be acyclic. In Section 3, we consider how to generalize AND/OR
graph search to find cyclic solution graphs.

_E.A. Hansen, S. Zilberstein / Artificial Intelligence_ _129 (2001) 35–62_ 45

_Dynamic programming and heuristic search_ It is possible to find an optimal solution to
an AND/OR search problem using dynamic programming, instead of using AO*. Given
a complete AND/OR graph containing every problem state, backwards induction can be
performed to find the optimal action for every state. Starting from goal states that have
a cost of zero, the optimality equation can be solved by performing a backup for each
nonterminal state in backwards order from the leaves of the AND/OR graph toward the
root. Given the optimal cost for every successor of a state, the optimal cost for a state can
be determined by performing a single backup for that state. Because a backup is performed
once for each state and each backup has constant-time complexity, the complexity of
backwards induction is linear in the number of states, even though the number of possible
solution graphs is exponential in the number of states.

Dynamic programming is said to be an _implicit-enumeration algorithm_ because it finds
an optimal solution without evaluating all possible solutions. Once an optimal solution
for a state is found, Bellman’s principle of optimality allows us to infer that an optimal
solution that reaches this state must include the solution that is optimal for this state. This
is the reason for solving the problem in a backwards order from the leaves of the tree
to the root, recursively combining solutions to increasingly larger subproblems until the
original problem is solved. Using Bellman’s principle of optimality to avoid enumerating
all possible solutions is sometimes called _pruning by dominance_ .

Pruning by dominance, upon which dynamic programming relies, is a technique for
pruning the space of solutions so that not every solution has to be evaluated in order to find
the best one. It is not a technique for pruning the state space. However, it is also possible
to prune states, and thus avoid generating the entire AND/OR graph, by using a technique
called _pruning_ _by_ _bounds_ . This approach is taken by branch-and-bound algorithms. To
avoid evaluating the entire AND/OR graph, a branch-and-bound algorithm generates the
graph incrementally in a forward direction, beginning from the start state at the root of the
graph. It does not generate and evaluate subgraphs that can be pruned by comparing upper
and lower bounds on their optimal cost. Given a lower-bound function (or equivalently, an
admissible heuristic evaluation function), it uses the following rule to avoid generating and
evaluating a subgraph of an AND/OR graph: if a lower bound on the optimal cost of one
_k_ -connector (corresponding to one possible action) is greater than an upper bound on the
cost of the state (determined by evaluating a subgraph that begins at another _k_ -connector),
then the first _k_ -connector cannot be part of an optimal solution and the subgraph below it
does not need to be evaluated.

Like branch-and-bound, best-first heuristic search can find an optimal solution without
evaluating every state in the AND/OR graph. It is called “best-first” because it uses the
lower-bound function to determine which tip state of the explicit graph to expand next, as
well as to prune the search space. Instead of expanding states in a depth-first (or breadthfirst) order, the idea of best-first search is to expand states in an order that maximizes the
effect of pruning. The objective is to find an optimal solution while evaluating as little of
the AND/OR graph as possible. A “best-first” order for expanding an AND/OR graph is to
expand the state that is most likely to be part of an optimal solution. This means expanding
a tip state of the best partial solution graph.

So, in order to expand the graph in best-first order, AO* must identify the best partial
solution graph in an explicit graph. To do so, AO* uses backwards induction to propagate

46 _E.A. Hansen, S. Zilberstein / Artificial Intelligence_ _129 (2001) 35–62_

state costs from the leaves of the explicit graph to its root. In other words, AO* uses
dynamic programming in its cost revision step. In its forward expansion step, it uses the
start state and an admissible heuristic to focus computation on the part of the AND/OR
graph where an optimal solution is likely to be. In summary, AO* uses branch-and-boundin
its forward expansion step and dynamic programming in its cost revision step. Integrating
these two techniques makes it possible to find an optimal solution as efficiently as possible,
without evaluating the entire state space. It also suggests a similar strategy for solving
MDPs using heuristic search.

**3.** **LAO***

We now describe LAO*, a simple generalization of AO* that can find solutions with
loops. (The “L” in the name LAO* stands for “loop”.) LAO* is a heuristic search algorithm
that can find optimal solutions for MDPs without evaluating the entire state space. Thus, it
provides a useful alternative to dynamic programming algorithms for MDPs such as value
iteration and policy iteration.

It is straightforward to represent an indefinite-horizon MDP as an AND/OR graph. We
let each state of the AND/OR graph correspond to a state of the MDP and we let each
_k_ -connector correspond to an action with _k_ possible outcomes. In reviewing MDPs and
AND/OR graph search, we used the same notation for their transition functions, cost
functions, and optimality equations, to help clarify the close relationship between these
two frameworks. A difference is that a solution to an indefinite-horizon MDP contains
loops (i.e., it allows the same state to be visited more than once). Loops express indefinitehorizon behavior.

The classic AO* algorithm can only solve problems that have acyclic solutions because
the backwards induction algorithm used in its cost revision step assumes an acyclic
solution. The key step in generalizing AO* to create LAO* is to recognize that the cost
revision step of AO* is a dynamic programming algorithm, and to generalize this step
appropriately. Instead of using backwards induction, state costs can be updated by using
a dynamic programming algorithm for indefinite-horizon MDPs, such as policy iteration
or value iteration. This simple generalization creates the algorithm LAO* summarized in
Table 5.

As in AO*, the cost revision step of LAO* is only performed on the set of states that
includes the expanded state and the states in the explicit graph from which the expanded
state can be reached by taking marked actions (i.e., by choosing the best action for each
state). This is the set _Z_ in step 2(b) of Table 5. The estimated cost of states that are not in
this subset are unaffected by any change in the cost of the expanded state or its ancestors.

The cost revision step of LAO* can be performed using either policy iteration or value
iteration. An advantage of using policy iteration is that it can compute an exact cost for
each state of the explicit graph after a finite number of iterations, based on the heuristic
estimates at the tip states. When value iteration is used, convergence to exact state costs
is asymptotic. However, this disadvantage is usually offset by the improved efficiency of
value iteration for larger problems.

_E.A. Hansen, S. Zilberstein / Artificial Intelligence_ _129 (2001) 35–62_ 47

Table 5
LAO*

1. The explicit graph _G_ <sup>′</sup> initially consists of the start state _s_ .

2. While the best solution graph has some nonterminal tip state:

(a) _Expand best partial solution_ : Expand some nonterminal tip state _n_ of the best partial solution graph and

add any new successor states to _G_ <sup>′</sup> . For each new state _i_ added to _G_ <sup>′</sup> by expanding _n_, if _i_ is a goal state
then _f (i)_ := 0; else _f (i)_ := _h(i)_ .

(b) _Update state costs and mark best actions_ :

i. Create a set _Z_ that contains the expanded state and all of its ancestors in the explicit graph along

marked action arcs. (I.e., only include ancestor states from which the expanded state can be reached
by following the current best solution.)
ii. Perform dynamic programming (policy iteration or value iteration) on the states in set _Z_ to update

state costs and determine the best action for each state.

3. _Convergence_ _test_ : If policy iteration was used in step 2(b)ii, go to step 4. Else perform value iteration on the
states in the best solution graph. Continue until one of the following two conditions is met. (i) If the error
bound falls below _ε_, go to step 4. (ii) If the best current solution graph changes so that it has an unexpanded
tip state, go to step 2.

4. Return an optimal (or _ε_ -optimal) solution graph.

Because LAO* allows a solution graph to contain loops, forward search from the start
state to identify the best partial solution graph (and the states on its fringe) terminates at
any state that represents a loop back to an already expanded state of the best partial solution
graph, as well as at a goal state or nonterminal tip state.

In both AO* and LAO*, the fringe of the best partial solution graph may contain many
unexpanded states and the choice of which state to expand next is nondeterministic. That
is, both AO* and LAO* work correctly no matter what heuristic is used to select which
nonterminal tip state of the best partial solution graph to expand next. A well-chosen state
selection heuristic can improve performance, however. Possibilities include expanding the
state with the highest probability of being reached from the start state or expanding the
state with the least cost, as already discussed for AO*.

_Example_ Fig. 2 shows a simple example of a stochastic shortest-path problem and the
steps that LAO* takes to solve it. The “gridworld” in which a path is to be found is shown
in (a). The states of the problem are the cells of the grid, which are numbered from 1 to 8.
The problem is to find the shortest path from the start state, labeled 1, to an absorbing goal
state, labeled 4. There are three available actions in each state. One action is an attempt to
move one cell north (N), one action is an attempt to move one cell east (E), and one action
is an attempt to move one cell south (S). Each action is successful in moving to the intended
cell with probability 0.5, if there is a cell in the direction of movement. Otherwise, there is
no move and the state remains unchanged. Hence, state transitions are stochastic. There is
a cost of one for each action taken in a nongoal state. An admissible heuristic estimate of
the optimal cost of each state is the length of a deterministic path from the state to the goal.
The steps that LAO* takes to solve this problem are shown in (b) through (e) of Fig. 2.
LAO* terminates when a solution graph is found, without needing to consider states 5, 6,
or 7.

48 _E.A. Hansen, S. Zilberstein / Artificial Intelligence_ _129 (2001) 35–62_

Fig. 2. (a) shows the grid for the stochastic shortest-path problem. (b) shows the root node of the explicit graph
(corresponding to the start state) at the beginning of the search. (c) shows the result of expanding the start state.
(d) shows the result of expanding state 2, which is the only state on the fringe of the best partial solution graph.
(e) shows the result of expanding state 3. Solid lines show the best partial solution graph, and dashed lines show
the rest of the explicit graph. The estimated cost of each state is shown in the lower half of the node.

_Admissibility_ LAO* shares the properties of AO* and other heuristic search algorithms.
Given an admissible heuristic evaluation function, all state costs in the explicit graph are
admissible after each step and LAO* converges to an optimal or _ε_ -optimal solution without
(necessarily) evaluating all problem states. We first prove this for the case in which policy
iteration is used in the cost revision step. Then we prove it for the case in which value
iteration is used in the cost revision step.

**Theorem 1.** _If the heuristic evaluation function h is admissible and policy iteration is used_
_to perform the cost revision step of LAO*, then_ :

(1) _f (i)_ ⩽ _f_ <sup>∗</sup> _(i) for every state i, after each step of LAO*_ ;
(2) _f (i)_ = _f_ <sup>∗</sup> _(i) for every state i_ _of the best solution graph, when LAO* terminates_ ;
(3) _LAO* terminates after a finite number of iterations._

_E.A. Hansen, S. Zilberstein / Artificial Intelligence_ _129 (2001) 35–62_ 49

**Proof.** (1) The proof is by induction. Every state _i_ ∈ _G_ is assigned an initial heuristic cost
estimate and _h(i)_ ⩽ _f_ <sup>∗</sup> _(i)_ by the admissibility of the heuristic evaluation function. The
solution expansion step does not change the cost of any states and so it is sufficient to
consider the cost revision step. We make the inductive assumption that at the beginning of
this step, _f (i)_ ⩽ _f_ <sup>∗</sup> _(i)_ for every state _i_ ∈ _G_ . If all the tip states of _G_ <sup>′</sup> have optimal costs,
then all the nontip states in _G_ <sup>′</sup> must converge to their optimal costs when policy iteration
is performed on them by the convergence proof for policy iteration. But by the induction
hypothesis, all the tip states of _G_ <sup>′</sup> have admissible costs. It follows that the nontip states in
_G_ <sup>′</sup> must converge to costs that are as good or better than optimal when policy iteration is
performed on them.

(2) The search algorithm terminates when the best solution graph for _s_ is complete, that
is, has no unexpanded states. For every state _i_ in this solution graph, it is contradictory to
suppose _f (i) < f_ <sup>∗</sup> _(i)_ since that implies a complete solution that is better than optimal. By
(1) we know that _f (i)_ ⩽ _f_ <sup>∗</sup> _(i)_ for every state in _G_ <sup>′</sup> . Therefore _f (i)_ = _f_ <sup>∗</sup> _(i)_ .

(3) It is obvious that LAO* terminates after a finite number of iterations if the implicit
graph _G_ is finite, or equivalently, the number of states in the MDP is finite. (When the state
set is not finite, it may still converge in some cases.) ✷

**Theorem 2.** _If the heuristic evaluation function h is admissible and value iteration is used_
_to perform the cost revision step of LAO*, then_ :

(1) _f (i)_ ⩽ _f_ <sup>∗</sup> _(i) for every state i_ _at every point in the algorithm_ ;
(2) _f (i) converges to within ε of f_ <sup>∗</sup> _(i) for every state i_ _of the best solution graph, after_

_a finite number of iterations._

**Proof.** (1) The proof is by induction. Every state _i_ ∈ _G_ is assigned an initial heuristic cost
estimate and _f (i)_ = _h(i)_ ⩽ _f_ <sup>∗</sup> _(i)_ by the admissibility of the heuristic evaluation function.
We make the inductive hypothesis that at some point in the algorithm, _f (i)_ ⩽ _f_ <sup>∗</sup> _(i)_ for
every state _i_ ∈ _G_ . If a backup is performed for any state _i_,

_j_ ∈ _S_

_j_ ∈ _S_

_pij (a)f (j)_

     
_pij (a)f_ <sup>∗</sup> _(j)_ = _f_ <sup>∗</sup> _(i),_

_f (i)_ = min

_a_ ∈ _A(i)_

⩽ min

_ci(a)_ +

_ci(a)_ +

_a_ ∈ _A(i)_

where the last equality restates the Bellman optimality equation.

(2) Because the graph is finite, LAO* must eventually find a solution graph that has no
nonterminal tip states. Performing value iteration on the states in this solution graph makes
the error bound of the solution arbitrarily small after a finite number of iterations, by the
convergence proof of value iteration for stochastic shortest-path problems [2]. ✷

_Convergence_ _test_ If the cost revision step of LAO* computes exact state costs (for
example, using policy iteration), LAO* converges when the best solution graph does
not have any nonterminal tip states. This is the same convergence test used by AO*.
It guarantees that the solution to which LAO* converges is optimal. When state costs
are updated approximately (for example, using value iteration), then when LAO* finds a

50 _E.A. Hansen, S. Zilberstein / Artificial Intelligence_ _129 (2001) 35–62_

solution graph that does not have any nonterminal tip states, this solution is not necessarily
optimal. In this case, an additional convergence test can be used to determine when the
solution is _ε_ -optimal.

The convergence test is simple and is summarized in step 3 of Table 5. It consists of
performing value iteration on the set of states visited by the current best solution graph.
Because value iteration may change the best action for some state, the best solution graph
may change from one iteration to the next. If the best solution graph changes to that it
includes a nonterminal tip state, control is passed from the convergence test back to the
main algorithm so that the best partial solution can be expanded and re-evaluated. When
the best solution graph does not contain any nonterminal tip states, its error bound can be
computed. The convergence test is repeated until the error bound falls below _ε_ . When it
does, LAO* terminates with an _ε_ -optimal solution.

The error bound is the difference between an upper and lower bound on the optimal
cost of the start state of the solution. (This is different from the error bound for dynamic
programming, which is the maximum difference over all states, not just the start state.)
Because the current estimated cost of the start state is admissible, it serves as a lower
bound. An upper bound on the optimal cost of the start state is equal to _f_ <sup>_π_</sup> _(s)_ + _φ_ <sup>_π_</sup> _(s)r_,
where _f_ <sup>_π_</sup> _(s)_ is the estimated cost of the start state under the current policy _π_, _φ_ <sup>_π_</sup> _(s)_ is
the mean first passage time from the start state to any goal state under this policy, and
_r_ = max _i_ ∈ _SG_ | _f_ <sup>′</sup> _(i)_ - _f (i)_ |, is the Bellman residual for this iteration of the convergence
test, where _SG_ ⊆ _S_ denotes the set of states visited by the current best solution graph.
Because the estimated cost of every state in the explicit graph is admissible, the Bellman
residual only needs to be computed for the states visited by the best solution in order to
determine the error bound of the solution. Similarly, first passage times only need to be
computed for states in the solution graph.

We note that while Barto et al. [1] prove that RTDP converges to an optimal solution,
they do not describe a convergence test for RTDP or a method for computing an error
bound. The convergence test and error bound described here may also be adapted for use
by RTDP.

_Relationship to_ _RTDP_ Both AO* and LAO*, as summarized in Tables 4 and 5, update
the evaluation function for all ancestor states (along marked arcs) of an expanded state,
whenever the best partial solution graph is expanded. They do so in order to maintain
accurate estimates of state costs for every state in the explicit graph. Updating the
evaluation function for all states in the explicit graph can be time consuming, however,
especially for LAO*, which uses a more complex dynamic programming algorithm.
Therefore, it is useful to point out that LAO* only needs to update the evaluation function
for the ancestor states of an expanded state that are in the best partial solution graph, in
order to ensure eventual convergence to an optimal or _ε_ -optimal solution. To make this
change to LAO*, as summarized in Table 5, we simply change the phrase “explicit graph”
to “best partial solution graph” in step 2(b)i of the algorithm. We described LAO* as we
originally did to emphasize its similarity to AO*. (But if we made this same change to
AO*, it would also still converge to an optimal solution.)

With this modification, the previous convergence theorems for LAO* still hold, by the
following reasoning. Consider any state _i_ in the explicit graph that is not also in the best

_E.A. Hansen, S. Zilberstein / Artificial Intelligence_ _129 (2001) 35–62_ 51

partial solution graph. If _f (i)_ is not updated, its value will be less than it would be if it
were updated—and therefore, it will still be admissible. Since _f (i)_ is less than it would be
if it were updated, it is more likely that it will be selected for inclusion in the best partial
solution graph. If it is not, it would not have been part of the best partial solution graph
even if it had been updated. If it is selected for inclusion in the best partial solution graph,
then _f (i)_ will be updated.

The observation that LAO* only needs to update _f_ for states in the current best solution
graph, in order to converge to an optimal solution, relates LAO* more closely to RTDP,
which only updates _f_ for states that can be reached from the start state by following the
current best solution.

**4.** **Extensions**

While RTDP is a real-time search algorithm and LAO* is an off-line search algorithm,
both solve the same class of MDPs and both converge to an optimal solution without
evaluating all problem states. An advantage of deriving LAO* from the heuristic search
algorithm AO* is that it makes it easier to generalize refinements of classic heuristic search
algorithms for use in solving MDPs more efficiently. To illustrate this, we describe some
extensions of LAO* that are suggested by its derivation from AO* (and ultimately, from
A*). We conclude by briefly discussing the extension of LAO* to other MDPs besides
stochastic shortest-path problems.

_4.1._ _Pathmax_

In A* search, a heuristic evaluation function _h_ is said to be _consistent_ if it is both
admissible and _h(i)_ ⩽ _ci_ _(a)_ + _h(j)_ for every state _i_ ∈ _S_ and action _a_ ∈ _A(i)_, where _j_
is the successor state of state _i_ when action _a_ is taken. Consistency is a desirable property
because it ensures that state costs increase monotonically as the algorithm converges. If a
heuristic evaluation function is admissible but not consistent, state costs need not increase
monotonically. However, they can be made to do so by adding a _pathmax_ operation to the
update step of the algorithm, as first suggested by Mérõ [15]. This common improvement
of A* and AO* can also be made to LAO*.

For problems with stochastic state transitions, we generalize the definition of consistency
as follows: a heuristic evaluation function _h_ is said to be _consistent_ if it is both admissible
and _h(i)_ ⩽ _ci(a)_ + <sup>�</sup> _j_ <sup>_pij (a)h(j)_</sup> <sup>for every state</sup> <sup>_i_</sup> <sup>∈</sup> <sup>_S_</sup> <sup>and action</sup> <sup>_a_</sup> <sup>∈</sup> <sup>_A(i)_</sup> <sup>, where</sup> <sup>_j_</sup> <sup>is a</sup>

possible successor state of state _i_ when action _a_ is taken. A pathmax operation is added to
LAO* by changing the formula used to update state costs as follows:

_f (i),_ min

_ci(a)_ +

_j_ ∈ _S_

_pij (a)f (j)_

_f (i)_ := max

_a_ ∈ _A(i)_

��
_._ (10)

As it does for A* and AO*, use of the pathmax operation in LAO* can reduce the number
of states that are expanded to find an optimal solution, when the heuristic is not consistent.

52 _E.A. Hansen, S. Zilberstein / Artificial Intelligence_ _129 (2001) 35–62_

_4.2._ _Evaluation function decomposition_

The A* search algorithm relies on a familiar _f_ = _g_ + _h_ decomposition of the evaluation
function. Chakrabarti et al. [3] have shown that a similar decomposition of the evaluation
function is possible for AO* and that it supports a weighted heuristic version of AO*. We
first show that this _f_ = _g_ + _h_ decomposition of the evaluation function can be extended to
LAO*. Then we describe a similar weighted heuristic version of LAO*.

Each time a state _i_ is generated by A*, a new estimate _f (i)_ of the optimal cost from the
start state to a goal state is computed by adding _g(i)_, the cost-to-arrive from the start state
to _i_, to _h(i)_, the estimated cost-to-go from _i_ to a goal state. Each time a state _i_ is generated
by AO* or LAO*, the optimal cost from the start state to a goal state is also re-estimated.
In this case, it is re-estimated by updating the estimated cost of every ancestor state of state
_i_, including the start state. For the start state _s_, the estimated cost-to-go, denoted _f (s)_, is
decomposed into _g(s)_, the cost-to-arrive from the start state to a state on the fringe of the
best partial solution, and _h(s)_, the estimated cost-to-go from the fringe of the best partial
solution to a goal state. In other words, _g(s)_ represents the part of the solution cost that has
been explicitly computed so far and _h(s)_ represents the part of the solution cost that is still
only estimated. The same decomposition applies to every other state in the explicit graph.

For each state _i_, the values _f (i)_, _g(i)_, and _h(i)_ are maintained, with _f (i)_ = _g(i)_ + _h(i)_ .
After a state _i_ is generated by AO* or LAO*, and before it is expanded, _g(i)_ equals zero
and _f (i)_ equals _h(i)_ . After state _i_ is expanded, _f (i)_ is updated in the same manner as
before:

_j_ ∈ _S_

_pij (a)f (j)_

_f (i)_ := min

_ci(a)_ +

_._ (11)

_a_ ∈ _A(i)_

Having determined the action _a_ that optimizes _f (i)_, then _g(i)_ and _h(i)_ are updated as
follows:

_g(i)_ := _ci(a)_ +

_j_ ∈ _S_

_pij (a)g(j),_ (12)

_h(i)_ :=

_j_ ∈ _S_

_pij_ _(a)h(j)._ (13)

Once LAO* converges to a complete solution, note that _h(i)_ = 0 and _f (i)_ = _g(i)_ for every
state _i_ in the solution.

The possibility of decomposing the evaluation function of an MDP in this way elegantly
reflects the interpretation of an MDP as a state-space search problem that can be solved by
heuristic search. It also makes it possible to create a weighted heuristic that can improve
the efficiency of LAO* in exchange for a bounded decrease in the optimality of the solution
it finds.

_4.3._ _Weighted heuristic_

Pohl [20] first described how to create a weighted heuristic and showed that it can
improve the efficiency of A* in exchange for a bounded decrease in solution quality. Given

_E.A. Hansen, S. Zilberstein / Artificial Intelligence_ _129 (2001) 35–62_ 53

the familiar decomposition of the evaluation function, _f (i)_ = _g(i)_ + _h(i)_, a weight _w_, with
0 _._ 5 ⩽ _w_ ⩽ 1, is used to create a weighted heuristic, _f (i)_ = _(_ 1 − _w)g(i)_ + _wh(i)_ . Use of
this heuristic guarantees that solutions found by A* are no more than a factor of _w/(_ 1 - _w)_
worse than optimal [4]. Given a similar _f_ = _g_ + _h_ decomposition of the evaluation function
computed by LAO*, it is straightforward to create a weighted version of LAO* that can
find an _ε_ -optimal solution by evaluating a fraction of the states that LAO* might have to
evaluate to find an optimal solution.

Note that a _f_ = _g_ + _h_ decomposition of the evaluation function and a weighted heuristic
can also be used with RTDP. In fact, the idea of weighting a heuristic in order to find
a bounded-optimal solution is explored by Ishida and Shimbo [9] for Korf’s LRTA*
algorithm [11], which can be regarded as a special case of RTDP for solving deterministic
search problems. They create a weighted heuristic by multiplying the initial heuristic
estimate of each state’s value by a weight. (This approach is less flexible than one that
relies on the _f_ = _g_ + _h_ decomposition we have just described, however, because it does
not allow the weight to be adjusted in the course of the search.) They find that a weighted
heuristic can significantly reduce the number of states explored (expanded) by LRTA*
without significantly decreasing the quality of the solution it finds.

_4.4._ _Heuristic accuracy and search efficiency_

In all heuristic search algorithms, three sets of states can be distinguished. The _implicit_
_graph_ contains all problem states. The _explicit_ _graph_ contains those states that are
evaluated in the course of the search. The _solution_ _graph_ contains those states that are
reachable from the start state when the best solution is followed. The objective of a bestfirst heuristic search algorithm is to find an optimal solution graph while generating as
small an explicit graph as possible.

Like all heuristic search algorithms, the efficiency of LAO* depends crucially on the
heuristic evaluation function that guides the search. The more accurate the heuristic, the
fewer states need to be evaluated to find an optimal solution, that is, the smaller the
explicit graph generated by the search algorithm. For A*, the relationship between heuristic
accuracy and search efficiency has been made precise. Given two heuristic functions, _h_ 1
and _h_ 2, such that _h_ 1 _(i)_ ⩽ _h_ 2 _(i)_ ⩽ _f_ <sup>∗</sup> _(i)_ for all states _i_, the set of states expanded by A*
when guided by _h_ 2 is a subset of the set of states expanded by A* when guided by _h_ 1 [18].

A result this strong does not hold for AO*, or by extension, for LAO*. The reason it does
not is that the selection of the next state to expand on the fringe of the best partial solution
graph is nondeterministic. Although AO* and LAO* work correctly no matter which state
on the fringe of the best partial solution is expanded next, a particular choice may result in
some states being expanded that would not be if the choice were different. Nevertheless,
Chakrabarti et al. [3] show that a weaker result does hold for AO* and it is straightforward
to extend this result to LAO*.

Chakrabarti et al. [3] consider the worst-case set of states expanded by a search
algorithm. Adapting their analysis, let _W_ denote the worst-case set of states expanded
by LAO*, defined as follows:

 - the start state _s_ is in _W_ ;

54 _E.A. Hansen, S. Zilberstein / Artificial Intelligence_ _129 (2001) 35–62_

 - a state _i_ is in _W_ if there exists a partial solution graph _p_ with an evaluation function
_f_ <sup>_p_</sup> such that:

  - _f_ <sup>_p_</sup> _(s)_ ⩽ _f_ <sup>∗</sup> _(s)_ ;

  - every nontip state of _p_ is in _W_ ;

  - _i_ is a nonterminal tip state of _p_ ;

 - no other states are in _W_ .
Given this definition, we have the following theorem.

**Theorem 3.** _Given two heuristic functions, h_ 1 _and h_ 2 _, such that h_ 1 _(i)_ ⩽ _h_ 2 _(i)_ ⩽ _f_ <sup>∗</sup> _(i) for_
_all states i, the worst-case set of states expanded by LAO* when guided by h_ 2 _is a subset_
_of the worst-case set of states expanded by LAO* when guided by h_ 1 _._

**Proof.** For any partial solution graph for start state _s_, we have

_f_ 1 _(s)_ = _g(s)_ + _h_ 1 _(s),_

_f_ 2 _(s)_ = _g(s)_ + _h_ 2 _(s)._

Since _h_ 1 _(s)_ ⩽ _h_ 2 _(s)_, we have _f_ 1 _(s)_ ⩽ _f_ 2 _(s)_ . Thus, if _f_ 2 _(s)_ ⩽ _f_ <sup>∗</sup> _(s)_, we also have
_f_ 1 _(s)_ ⩽ _f_ <sup>∗</sup> _(s)_ . It follows that the worst-case set of states expanded by LAO* when guided
by _h_ 2 must be a subset of the worst-case set of states expanded by LAO* when guided
by _h_ 1. ✷

In other words, a more accurate heuristic does not necessarily make LAO* more
efficient. However, it makes it more efficient in the worst case. This result holds for a
“pure” version of LAO* that updates state costs exactly in the dynamic-programming step.
If LAO* updates state costs approximately, for example, by using value iteration with a
relaxed criterion for convergence, the effect on the set of states expanded in the worst case
is not as clear.

_4.5._ _Infinite-horizon problems_

We have presented the results of this paper for stochastic shortest-path problems. Many
MDPs do not include terminal (or goal) states, or if they do, there is no guarantee that a
terminal state can be reached from every other state. Problems that may never terminate are
called infinite-horizon MDPs. For an infinite-horizon problem, one way to ensure that every
state has a finite expected cost is to discount future costs by a factor _β_, with 0 ⩽ _β <_ 1. For
problems for which discounting is not reasonable, other optimality criteria, such as average
cost per transition, can be adopted. Variations of policy and value iteration algorithms for
these other optimality criteria have been developed [2]. By incorporating them into LAO*,
we claim that the results of this paper can be extended to infinite-horizon problems in a
straightforward way. Hansen and Zilberstein [8] consider LAO* for discounted infinitehorizon MDPs and give convergence proofs.

_E.A. Hansen, S. Zilberstein / Artificial Intelligence_ _129 (2001) 35–62_ 55

**5.** **Performance**

We now examine the performance of LAO* on two test problems. The first is the race
track problem used by Barto et al. [1] to illustrate the behavior of RTDP. The second is a
simple example of a supply-chain management problem that has been studied extensively
in operations research [12]. While further work is needed to fully evaluate LAO*, the two
problems allow us to observe some important aspects of its behavior and to improve its
implementation.

_Race_ _track_ _problem_ To illustrate the behavior of RTDP, Barto et al. [1] describe a test
problem that involves a simple simulation of a race car on a track. The race track has any
length and shape, and includes a starting line at one end and a finish line at the other.
The track is discretized into a grid of square cells, where each cell represents a possible
location of the car. Beginning at the starting line, the car attempts to move along the track
to the finish line. The state of the MDP is determined by the location of the car and its twodimensional velocity. The car can change its velocity by ±1 in each dimension, for a total
of nine actions. The actual acceleration/deceleration that results from each action is zero
with some probability, in order to make state transitions stochastic. It is as if an attempt to
accelerate or decelerate sometimes fails because of an unpredictable slip on the track. If
the car hits the track boundary, it is moved back to the start state. For a full description of
the problem, we refer to the paper by Barto et al. [1].

We test LAO* on an instance of this problem that has 21,371 states. When the race car
it driven optimally, it avoids large parts of the track as well as dangerous velocities. Thus,
only 2,248 states are visited by an optimal policy that starts at the beginning of the race
track. Table 6 summarizes the performance of LAO* on this problem. It shows the number
of states evaluated by LAO* as a function of two different admissible heuristics. The “zero
heuristic” sets the initial heuristic cost of each state to zero. The “shortest-path heuristic”
is computed by beginning from the set of goal states and determining the smallest possible
number of state transitions needed to reach a goal state, for each state. This more informed

Table 6
Results for race track problem with 21,371 states. Optimal solution visits only 2,248
states (Policy iteration is much slower than value iteration because exact policy
evaluation has cubic complexity in the number of states, compared to the quadratic
complexity of value iteration.)

Solution States Time to

Algorithm quality evaluated converge

Policy iteration Optimal 21,371 _>_ 10 minutes

Value iteration Optimal 21,371 15.7 sec

LAO* w/ zero heuristic Optimal 18,195 10.7 sec

LAO* w/ shortest-path heuristic Optimal 14,252 4.7 sec

LAO* w/ weight = 0.6 Optimal 8,951 3.1 sec

LAO* w/ weight = 0.67 +4% 4,508 1.8 sec

56 _E.A. Hansen, S. Zilberstein / Artificial Intelligence_ _129 (2001) 35–62_

heuristic enables LAO* to find an optimal solution by expanding fewer states. Weighting
the shortest-path heuristic allows a solution to be found by evaluating even fewer states,
although the solution is not necessarily optimal. These results illustrate the importance of
heuristic accuracy in limiting the number of states evaluated by LAO*.

The number of states evaluated by LAO* is only one factor that influences its efficiency.
Our experiments quickly revealed that a naive implementation of LAO* can be very
inefficient, even if it evaluates a fraction of the state space. The reason for this is that the
running time of LAO* is proportional to the total number of states evaluated multiplied by
the average number of times these states are evaluated. In a naive implementation of LAO*,
the fact that fewer states are evaluated can be offset by an increase in the average number
of evaluations of these states. Using the race track problem as an example, expanding just
one state on the fringe of the best partial solution graph at a time, and performing several
iterations of value iteration between each state expansion, results in many states being
evaluated tens of thousands of times before convergence.

We found that the performance of LAO* can be improved by using various techniques
to limit the number of times that states are evaluated. One technique is to expand multiple
states on the fringe of the best partial solution graph before performing the cost revision
step. (Nilsson [18] makes a similar suggestion for AO*.) For this problem, expanding
all states on the solution fringe before performing the cost revision step worked better
than expanding any subset of the fringe states (although we do not claim that this is the
best strategy in general.) We also found it helpful to limit the number of iterations of
value iteration in each cost revision step, and to limit the number of ancestor states on
which value iteration is performed. Because value and policy iteration are much more
computationally expensive than expanding the best partial solution graph, finding ways to
minimize the expense of the cost revision step usually improves the performance of LAO*.

With this in mind, Table 7 summarizes a more efficient implementation of LAO* that
limits the number of state backups by integrating them into the solution expansion step.
Beginning from the start state, LAO* searches the best partial solution graph in a depthfirst fashion. As each state is visited, including any newly expanded states on the fringe of
the solution graph, the state is pushed on the stack used to control the depth-first search.
(The state is also marked in order to avoid revisiting the same state during the depth-first
search.) As states are popped off the stack, a backup is performed to re-evaluate them. It

Table 7
An efficient version of LAO* that combines backups with solution expansion

1. The explicit graph _G_ <sup>′</sup> initially consists of the start state _s_ .

2. _Expand_ _best_ _partial_ _solution,_ _update_ _state_ _costs,_ _and_ _mark_ _best_ _actions_ : While the best solution graph has
some nonterminal tip state, perform a depth-first search of the best partial solution graph. For each visited
state _i_, in postorder traversal:

(a) If state _i_ is not expanded, expand it.
(b) Set _f (i)_ := min _a_ ∈ _A(i)_ [ _ci_ _(a)_ + <sup>�</sup> _j_ <sup>_pij_</sup> <sup>_(a)f (j)_</sup> <sup>] and mark the best</sup> <sup>action</sup> <sup>for</sup> <sup>_i_</sup> <sup>.</sup> <sup>(When determining</sup> <sup>the</sup>

best action resolve ties arbitrarily, but give preference to the currently marked action.)

3. _Convergence_ _test_ : Perform value iteration on the states in the best solution graph. Continue until one of the
following two conditions is met. (i) If the error bound falls below _ε_, go to step 4. (ii) If the best solution graph
changes so that it has an unexpanded tip state, go to step 2.

4. Return an _ε_ -optimal solution graph.

_E.A. Hansen, S. Zilberstein / Artificial Intelligence_ _129 (2001) 35–62_ 57

Fig. 3. Comparison of the convergence behavior of RTDP and LAO* on the race track problem. Both algorithms
use the shortest-path heuristic, which initializes the start state to 21.0. Although RTDP improves the solution
more quickly, LAO* converges to an _ε_ -optimal solution after four and a half seconds, indicated by the vertical
mark, whereas RTDP continues to run for more than three minutes without converging to the same value.

is possible to view this version of LAO* as a kind of “focused value iteration” because it
works the same as value iteration except that instead of updating all states each iteration, it
only updates states that are part of the best (partial) solution graph. LAO* expands the best
partial solution graph each iteration until a complete and optimal solution is found. The
last column of Table 6 shows convergence times for this more efficient implementation of
LAO*. (All timing results in this section are on a 300 MHz UltraSparc II.)

On the race track problem, the performance of this version of LAO* is competitive
with RTDP, as shown by Fig. 3. Trial-based RTDP improves the solution faster because
it focuses on high-probability paths through the state space, while LAO* systematically
explores all paths, including low-probability paths. However, LAO* converges to an _ε_ optimal solution after only four and a half seconds (with _ε_ = 0 _._ 000001), whereas RTDP
does not converge to a solution within 0.001 of this value after three minutes. The reason
for this is that RTDP tends to avoid updating states on very low-probability paths, and thus
is slow in propagating the low-probability state values needed for convergence.

This comparison suggests a combined strategy that focuses search on high-probability
paths first, to improve the solution quickly, and then searches more systematically as the
solution nears convergence. LAO* allows flexibility in how state expansions are mixed
with state backups, and more sophisticated search control strategies that exploit this
flexibility may further improve its performance.

_Supply-chain_ _problem_ Our second test problem is a simple supply-chain management
problem. A supply chain is a network of facilities (companies or departments) that are
responsible for procurement of materials, intermediate and finished product assembly,
and distribution of finished products to customers. Supply chains, with various degrees of
complexity, exist in both service and manufacturing. Supply-chain management requires
making decisions about the acquisition of raw materials; the manufacture, distribution,
and sale of a product; and optimal levels of inventory at various stages of the chain

58 _E.A. Hansen, S. Zilberstein / Artificial Intelligence_ _129 (2001) 35–62_

of production. Such problems require sequential decision making under uncertainty
(especially uncertainty about customer demand), and typically have very large state
spaces [12].

We consider a small example of such a problem. To manufacture a product, say a lamp,
we are dependent on supply of a part, say a flexible neck. Manufacture of the lamp depends
on other parts as well, such as a lamp shade, bulb, basement, and cable, but we consider
only supply of one part for this example. Demand for the product is stochastic. The problem
is to determine how many units of the product to produce, what price to sell the product for,
how many units of the part to order, and what inventory to keep on hand. A complicating
factor is that the cost of parts goes down if they are ordered in advance. Each order has a
guaranteed delivery time. The longer the period between ordering and delivery, the lower
the cost. This reflects the fact that advance notice allows the part manufacturer to increase
its own efficiency. We first specify the parameters of the problem. Then we describe the
performance of LAO*.

The problem state is defined by a tuple of state variables,

_(ordAmt,_ _ordTime,_ _invProd,_ _invPart,_ _demand,_ _price),_

where _ordAmt_ is the quantity of the part on order for each of the next _ordTime_ time periods,
_invProd_ is the current inventory of the product, _invPart_ is the current inventory of the part,
_demand_ defines a demand curve that gives the current demand for the product as a function
of price, and _price_ is the current price of the product. We assume that each of these state
variables has a finite number of possible values, beginning from a minimum value and
increasing by a fixed step size to a maximum possible value. The size of the state space is
the cardinality of the cross-product of the domains of the state variables.

An action consists of two decisions. The first is to (possibly) change the price of the
final product. The second is to (possibly) place a new order for parts. Each time period,
a maximal number of new products is produced based on the available parts and the
production capacity. Therefore, control of production is performed indirectly by limiting
the order of new parts. Once parts are available, we assume that it is beneficial to transform
them as soon as possible into complete products. To relax this assumption, one could add
to each action a third component that controls the production level.

To limit the number of possible actions (in a reasonable way), we allow the price of
the product to be increased or decreased by only the fixed step size each time period. The
number of actions and states is limited by the way we represent future orders. The most
general representation is an arbitrary vector of orders [ _ordAmt_ 1, _ordAmt_ 2, _ordAmt_ 3, _...,_
_ordAmtn_ ], where _ordAmti_ represents the number of parts on order for delivery after _i_ time
periods. Instead, we assume the same number of parts, _ordAmt_, is ordered for delivery
in each of the next _ordTime_ time periods. We also assume that existing orders form a
commitment that cannot be canceled or changed. An action can only increase _ordAmt_ or
_ordTime_, or both, up to some maximum. If no more parts are ordered, _ordTime_ decreases
by one each time period until it reaches zero. Then it is possible to order any number of
parts for any number of periods.

As for the state transition function, we assume that actions have deterministic effects,
but that demand is stochastic. Demand for the product is given by the formula

_demand(price)_ = _demand_   - e <sup>_α_</sup> <sup>·</sup> <sup>_price_</sup> _,_

_E.A. Hansen, S. Zilberstein / Artificial Intelligence_ _129 (2001) 35–62_ 59

where _α_ is a constant that characterizes this product, and _demand_ is a state variable that
changes stochastically each time period. With probability 0.3, it increases by one unit; with
probability 0.3, it decreases by one unit; and with probability 0.4, it remains unchanged.
The transition probabilities change when the demand variable is at its maximum or
minimum value. At its maximum value, it decreases with probability 0.4 and otherwise
remains unchanged. At its minimum value, it increases with probability 0.4 and otherwise
remains unchanged.

We treat this as a reward-maximization problem (which is a simple modification of a
cost-minimization problem). The overall reward is the difference between the income from
selling products and the associated costs. In each action cycle, the immediate income is
the number of products sold times the price of a product. The immediate cost has three
components: production cost, inventory storage cost, and the cost of ordering parts. The
former two are linear functions defined by the unit production cost, _CostProd_, and the unit
storage costs for inventory, _InvCostPart_ and _InvCostProd_ . The cost of an order depends on
a variable unit cost for a part, which is a monotonically decreasing function of time the
part is ordered in advance. The minimum cost, _MinCostPart_, applies if the part is ordered
at least _tmin_ time periods in advance. The maximum cost, _MaxCostPart_, applies if the part
if ordered less than _tmax_ time periods in advance. The cost changes linearly between _tmax_
and _tmin_ .

The objective is to maximize the discounted sum of rewards over an infinite horizon.
For discounted infinite-horizon problems, a simple admissible heuristic can be constructed
by assuming the maximum one-step reward is received each time period. We consider
an instance of the problem in which the variables can have the values shown in Table 8,
and the constants are: _InvCostProd_ = 1 _._ 0; _InvCostPart_ = 0 _._ 2; _ProductionCost_ = 1 _._ 80;
_ProductionCapacity_ = 1500; _tmax_ = 1; _tmin_ = 4; and _α_ = 0 _._ 207944. The discount factor
is 0.95.

This instance of the supply-chain problem has 36,000 states and 27 actions. We solve
the problem for the following start state: _ordAmt_ = 100; _ordTime_ = 2; _price_ = 10 _._ 00;
_demand_ = 4000; _invProd_ = 600; and _invPart_ = 0. An optimal policy visits only 680 states
and is found by expanding 14,229 states after 48 seconds. By comparison, value iteration
takes 238 seconds to solve the same problem.

Table 8
Variables for the supply-chain problem

Description Variable name Min value Max value Increment step

Order level _ordAmt_ 0 1800 600

Order periods _ordTim_ 1 4 1

Product price _price_ 5 17.50 1.25

Demand _demand_ 1000 16000 1500

Prod inventory _invProd_ 0 100 2000

Part inventory _invPart_ 0 400 200

Cost of part _costPart_ 1.40 2.00 N/A

60 _E.A. Hansen, S. Zilberstein / Artificial Intelligence_ _129 (2001) 35–62_

We have experimented with additional problem instances created by varying the
parameters of this problem and found that LAO* consistently outperforms value iteration.
It is well-suited for this supply-chain problem because, regardless of the starting state,
an optimal policy is to try to enter a certain steady state of production and orders, and this
steady state involves a small fraction of the state space (less than 2% in the above example).
While it is difficult to generalize these results to other problems, or even to more complex
supply-chain problems, they improve our intuition about the performance of LAO* and
show that it can be a useful algorithm.

_For what types of problem is LAO* useful?_ Given a start state and an admissible heuristic
to guide forward expansion of a partial solution, LAO* can find an optimal solution without
evaluating the entire state space. However, it only enjoys this advantage for problems for
which an optimal solution visits a fraction of the state space, beginning from the start state.
Many problems have this property, including our two test problems. But many do not. It
would be useful to have a way of identifying problems for which LAO* is effective. There
does not appear to be an easy answer to this question. Nevertheless, we make a few remarks
in this direction.

One relevant factor appears to be how much overlap there is between the sets of
successor states for different actions, taken in the same state. If there is little overlap,
a policy can more easily constrain the set of reachable states. If there is much (or even
complete) overlap, it cannot. For example, each action in the race track problem has two
possible successor states. The action of accelerating or decelerating either succeeds or fails.
(It fails due to a slip on the track. This is the stochastic element of the problem.) Thus, the
overlap between the successor states for different actions is limited to the case of failure.
Otherwise, each action has a distinct successor state. Now, consider the following slight
modification of the race track problem. With some small probability, each action has the
effect of any other action. In this case, every action has the same set of possible successor
states and the choice of one action instead of another does not affect the set of reachable
states. With this change to the race track problem, every policy visits all the states of the
race track problem.

Even for problems for which an optimal policy visits all (or most) of the state space,
LAO* may provide a useful framework for finding partial solutions under time constraints.
Instead of finding a complete policy, it can focus computation on finding a policy for a
subset of states that is most likely to be reached from the starting state. This approach
to solving MDPs approximately has been explored by Dean et al. [5]. The framework of
LAO* relates this approach more closely to classic heuristic search algorithms.

**6.** **Conclusion**

We have presented a generalization of AO*, called LAO*, that can find solutions with
loops, and we have shown that it can be used to solve indefinite-horizon MDPs. Like other
heuristic search algorithms, LAO* can find an optimal solution for a start state without
evaluating the entire state space.

_E.A. Hansen, S. Zilberstein / Artificial Intelligence_ _129 (2001) 35–62_ 61

Although real-time search has been applied to MDPs before [1,5,6,21], LAO* is the first
off-line heuristic search algorithm for MDPs. The derivation of LAO* from the classic
heuristic search algorithm AO* provides a foundation for a heuristic search approach to
MDPs. It also makes it easier to generalize enhancements of classic search algorithms for
use in solving MDPs more efficiently. The results presented in this paper illustrate the
relevance of the rich body of AI research on heuristic search to the problem of solving
MDPs more efficiently. They also help to clarify the relationship between classic AI search
techniques and dynamic programming algorithms developed in operations research.

**Acknowledgements**

We thank Dietrich Eisenhardt for implementing the supply chain example and running
the experiments on it. We thank the anonymous reviewers for helpful comments. Support
for this work was provided in part by the National Science Foundation under grant IIS9984952 to the first author and grants IRI-9624992 and IRI-9634938 to the second author.

**References**

[1] A.G. Barto, S.J. Bradtke, S.P. Singh, Learning to act using real-time dynamic programming, Artificial

Intelligence 72 (1995) 81–138.

[2] D. Bertsekas, Dynamic Programming and Optimal Control, Athena Scientific, Belmont, MA, 1995.

[3] P.P. Chakrabarti, S. Ghose, S.C. DeSarkar, Admissibility of AO* when heuristics overestimate, Artificial

Intelligence 34 (1988) 97–113.

[4] H.W. Davis, A. Bramanti-Gregor, J. Wang, The advantages of using depth and breadth components in

heuristic search, in: Z.W. Ras, L. Saitta (Eds.), Methodologies for Intelligent Systems Vol. 3, North-Holland,
Amsterdam, 1989, pp. 19–28.

[5] T. Dean, L.P. Kaelbling, J. Kirman, A. Nicholson, Planning under time constraints in stochastic domains,

Artificial Intelligence 76 (1995) 35–74.

[6] R. Dearden, C. Boutilier, Integrating planning and execution in stochastic domains, in: Proc. Tenth

Conference on Uncertainty in Artificial Intelligence, Washington, DC, 1994, pp. 162–169.

[7] R. Dechter, J. Pearl, Generalized best-first search strategies and the optimality of A*, J. ACM 32 (1985)

505–536.

[8] E.A. Hansen, S. Zilberstein, Heuristic search in cyclic AND/OR graphs, in: Proc. AAAI-98, Madison, WI,

1998, pp. 412–418.

[9] T. Ishida, M. Shimbo, Improving the learning efficiencies of realtime search, in: Proc. AAAI-96, Portland,

OR, 1996, pp. 305–310.

[10] P. Jiménez, C. Torras, An efficient algorithm for searching implicit AND/OR graphs with cycles, Artificial

Intelligence 124 (2000) 1–30.

[11] R. Korf, Real-time heuristic search, Artificial Intelligence 42 (1990) 189–211.

[12] Z. Lian, A. Deshmukh, J. Wang, Optimal frozen period in a periodic review inventory model with updateable

demand forecasts, in: Proc. 15th International Conference on Production Research, 1999.

[13] A. Martelli, U. Montanari, Additive AND/OR graphs, in: Proc. IJCAI-73, Stanford, CA, 1973, pp. 1–11.

[14] A. Martelli, U. Montanari, Optimizing decision trees through heuristically guided search, Comm.

ACM 21 (12) (1978) 1025–1039.

[15] L. Mérõ, A heuristic search algorithm with modifiable estimate, Artificial Intelligence 23 (1) (1984) 13–27.

[16] N.J. Nilsson, Search problem-solving and game-playing trees for minimal cost solutions, in: A. Morrell

(Ed.), Information Processing 68, Vol. 2, North-Holland, Amsterdam, 1969, pp. 1556–1562.

[17] N.J. Nilsson, Problem Solving Methods in Artificial Intelligence, McGraw-Hill, New York, 1971.

62 _E.A. Hansen, S. Zilberstein / Artificial Intelligence_ _129 (2001) 35–62_

[18] N.J. Nilsson, Principles of Artificial Intelligence, Tioga Publishing, Palo Alto, CA, 1980.

[19] K.R. Pattipati, M.G. Alexandridis, Application of heuristic search and information theory to sequential fault

diagnosis, IEEE Trans. Systems Man Cybernet. 20 (4) (1990) 872–887.

[20] I. Pohl, First results on the effect of error in heuristic search, Machine Intelligence 5 (1973) 219–236.

[21] J. Tash, S.J. Russell, Control strategies for a stochastic planner, in: Proc. AAAI-94, Seattle, WA, 1994,

pp. 1079–1085.
