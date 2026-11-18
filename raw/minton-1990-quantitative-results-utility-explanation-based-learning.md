# minton-1990-quantitative-results-utility-explanation-based-learning

> Converted from `minton-1990-quantitative-results-utility-explanation-based-learning.pdf` on 2026-11-18 via `pymupdf4llm`.
> Layout artefacts (broken equations, interleaved columns) are conversion noise, not the source.

---

ARTIFICIAL INTELLIGENCE 363

## **Quantitative Results Concerning the** **Utility of Explanation-Based Learning***

**Steven Minton****

_Computer Science Department, Carnegie-Mellon University,_
_Pittsburgh, PA 15213, USA_

ABSTRACT

_In order to solve problems effectively, a problem solver must be able to exploit domain-specific_
_search control knowledge. Although previous research has demonstrated that explanation-based_
_learning is a viable approach for acquiring such knowledge, in practice the control knowledge_
_learned via EBL may not be useful. To be useful, the cumulative benefits of applying the knowledge_
_must outweigh the cumulative costs of testing whether the knowledge is applicable. Unlike most_
_previous systems that use EBL, the PRODIGY system evaluates the costs and benefits of the control_
_knowledge it learns. Furthermore, the system produces useful control knowledge by actively_
_searching for "good" explanations---explanations_ _that can be profitably employed to control_
_problem solving._ _This paper summarizes a set of experiments measuring the effectiveness of_
_PRODIGY's EBL method (and its components) in several different domains._

**1. Introduction**

The capability to learn and exploit search control knowledge is critically
important for domain-independent problem solvers (e.g., theorem provers,
planners) due to the exponential size of the search spaces they typically
confront. Recent research has shown that explanation-based learning (EBL) is a
powerful technique for learning search control knowledge, including macrooperators [10, 22, 29], chunks [34], and search heuristics [27, 36]. However,
EBL is not _guaranteed_ to improve problem solving performance. Indeed, in
many cases performance can even degrade. The problem is that control
knowledge has a hidden cost that can often defeat its purpose--the cost of
testing whether the knowledge is applicable as the search is carried out. To
actually improve efficiency, an EBL program must generate control knowledge

  - Revised version of the paper that won the Artificial Intelligence Journal Best Paper Award at
AAAI-88, St. Paul, MN.

** Current address: Sterling Federal Systems, Artificial Intelligence Branch, NASA Ames
Research Center, Mail Stop 244-17, Moffett Field, CA 94035, USA.

_Artificial Intelligence_ **42** (1990) 363-391
_0004-3702/90/$3.50 ©_ 1990, Elsevier Science Publishers B.V. (North-Holland)

364 s. MINTON

that is _effective--its_ benefits must outweigh its costs. Previous research in EBL
has ignored this issue, which we refer to as the _utility_ problem; most studies
have simply demonstrated that EBL can improve performance on particular
examples. In practice, however, it is much more difficult to improve performance over a population of examples than it is to improve performance on
isolated examples.

PRODIGY [23, 25, 26] is a general problem solver with an EBL module that
searches for effective control knowledge. This paper considers how EBL is used
by the PRODIGY system, focusing on a set of comprehensive experiments
designed to test the performance of the PRODIGY EBL module and its components. After a brief discussion of the utility problem and an overview of the
system, we describe the experimental method and the results of the study. The
results reveal the significance of the utility issue and the relative effectiveness
of PRODIGY's EBL method. We conclude by considering the strengths and
weaknesses of both the learning method and the experimental design used to
evaluate the method.

**2. EBL and the Utility Problem**

Table 1 shows a high-level specification of the input and output of EBL,
adapted from Mitchell et al. [27]. EBL begins with a high-level _target concept_
and a _training example_ for that concept. Using the _domain_ _theory,_ a set of
axioms describing the domain, one can explain why the training example is an
instance of the target concept. The explanation is essentially a proof that shows
how the training example satisfies the target concept definition. ~ By finding the

Table l
Specification of EBL

**Input:**

_- Target concept:_ A concept to be learned.

_- Training example:_ An example of the target concept.

_- Domain theory:_ A set of rules and facts to be used in explaining how the training example is

an example of the target concept.

_- Operationality criterion:_ A predicate over descriptions, specifying the form in which the

learned description must be expressed.

Output:

**-** A description that is both a generalization of the training example and a specialization of the

target concept, which satisfies the operationality criterion.

lit is not strictly necessary for the explanation to be a proof. If the explanation relies on
assumptions, or facts that are not given by the domain theory, then the explanation will not have
the status of a proof. In this case, the learned knowledge is not guaranteed to be correct.
Sometimes this is very useful, such as when approximations need to be learned [7, 37]. However,
all of the work reported in this paper assumes the domain theory is complete and consistent, and
the explanations are treated as proofs.

QUANTITATIVE RESULTS ON UTILITY OF EBL 365

weakest conditions under which the explanation holds [23], EBL will produce a
_learned description_ that is both a generalization of the training example, and a
specialization of the target concept. The learned description must satisfy the
_operationality criterion,_ a test which insures that the description will serve as an
efficient recognizer for the target concept.

As an example (also adapted from [27]) consider the target concept (SAFETO-STACK X y), that is, object x can be safely placed on object y without object
y collapsing• Let us suppose our training example is a demonstration that a
particular book, Principles-of-AI, can be safely placed upon a particular table,
Coffee-Table-1. If our domain theory contains assertions such as those shown
below, we can construct a proof that Principles-of-AI is safe to stack on
Coffee-Table-l, because all books are lighter than tables• The resulting learned
description would therefore be (AND (IS-BOOK x) (IS-TABLE y)).

_Domain theory:_

(IS-BOOK PRINCIPLES-OF-AI)

(SAFE-TO-STACK X y)
if (OR (LIGHTER X y) (NOT-FRAGILE y))

(LIGHTER X y)
if (AND (WEIGHT X Wl) (WEIGHT y w2) (LESS-THAN W 1 W2) )
(LESS-THAN W 5-LBS)
if (AND (IS-BOOK X) (WEIGHT X W)) [default]

(GREATER-THAN W 10-LBS)
if (AND (IS-TABLE y) (WEIGHT y w)) [default l

(LESS-THAN W 1 W3)
if (AND (LESS-THAN w 1 w2) (LESS-THAN w 2 w3) )

(LESS-THAN W 1 W3)
if (AND (LESS-THAN w I w2) (GREATER-THAN w 3 w2) )

The actual purpose of EBL is not to learn more about the target concept, but
to re-express the target concept in a more "operational" manner. While the
precise definition of operationality may vary from system to system, efficiency
for recognition is normally the implicit basis for an operationality criterion [16].
(Otherwise, if efficiency is of no concern, the target concept could be used as
is, since it is exactly defined by the domain theory.)

One can visualize a standard EBL program operating as follows• After being
given a training example, EBL produces a learned description which is a
generalization of the example. If the next training example is not covered by
this description, another learned description is produced• If the third example
is not covered by either of the two previous examples, another description is

366 s. MINTON

learned, and so on. Thus, the program incrementally re-expresses the target
concept disjunctively, where each disjunct is one of the descriptions learned
from an individual trial. In other words, EBL produces a set of special-case
descriptions of the target concept.

Supposedly the operationality criterion insures that each of the individual
learned descriptions can be efficiently tested. However, this ignores the
cumulative cost of testing the descriptions. Furthermore, as traditionally
viewed, the operationality criterion does not take into account how the learned
description will be used to improve the performance system, which determines
its benefit. In practice, as pointed out by Keller [16], the operationality criteria
employed by EBL systems to date have been largely unrealistic, or even
non-existent.

For these reasons, if we consider EBL systems that learn control knowledge
(and almost all implemented EBL systems fall into this category), learning may
actually slow down the system. This has been documented in EBL macrooperator learning systems such as MORRIS [22], and more recently in SOAR [38]
and other EBL systems [20, 33]. The degradation phenomenon does not have to
be artificially induced in these systems; it can occur under normal operating
circumstances, as described in the following section. One reason that the
problem has not received much attention until now is that few EBL systems
have been extensively tested.

**3. Initial Experiments with the Utility Problem**

The work described in this paper was originally motivated by the author's
experience with an early EBL system for playing simple two-person games (such
as Gomoku) [21]. Although learning improved the system's level of play, the
system slowed down dramatically as more complex rules were learned. It was
not unusual to learn rules with left-hand sides containing hundreds of conjuncts. Such rules would quickly overwhelm the system, despite the use of an
efficient RETE [11] pattern matcher. The results from the game-playing system
suggested that other EBL systems might be subject to similar problems. 2 To
investigate this hypothesis, an attempt was made to reproduce the results
reported with the STRIPS macro-operator technique [10], one of the earliest and
most clearly specified EBL methods.

As pointed out by Mooney and Bennet [30], the STRIPS technique is almost
identical to more recently developed EBL algorithms such as their EGGS
method and Mitchell et al.'s EBG method [27]. After STRIPS produces a plan (a
sequence of operators) that solves a given problem, the system generalizes the

2The paper describing the game-playing system predated the term "explanation-based
learning," but it introduced an early domain-independent characterization of the technique, under
the name "constraint-based generalization." This characterization was used to argue that a variety
of learning systems all used the same general method.

QUANTITATIVE RESULTS ON UTILITY OF EBL 367

plan and stores it as a macrop for solving subsequent problems. From an EBL
point of view, the plan produced by STRIPS "explains" why the goal was
achievable [25].

Experiments with the STRIPS macro-operator technique confirmed that problem solving efficiency may degrade significantly as macro-operators are learned

[22]. Two versions of a STRIPS-like architecture were tested. One version of the
system, called MAX, saved all learned macro-operators. Another version,
called MORRIS, selectively saved only those macro-operators that ranked high
on either of two simple utility measures. Macro-operators were considered to
be high in utility if they were frequently used, or if they helped avoid local
maxima in MORRIS' hill-climbing search. Over a series of 25 examples, MORRIS'
selective learning performed significantly better than the classical STRIPS
approach used by MAX where all macro-operators were saved.

The MAX/MORRIS experiments revealed that macro-operator learning has
several distinct effects on the search process. First, learning changes the order
in which the search space is traversed. Operator sequences that have previously
succeeded (i.e., those encoded as macro-operators) are tried before other
sequences. We refer to this as the _re-ordering effect_ (or "experiential bias"

[22]). In the MAX/MORRIS experiments, this was the primary source of
potential performance improvement.

Another effect is _decreased path cost:_ the cost of reaching a state via a
macro-operator may be less than the cost of testing and applying the corresponding sequence of primitive operators. However, this is normally a very
minor effect unless precondition ordering and other compilation schemes are
used [23]. In general, there is little difference in matching a macro-operator's
preconditions versus successively matching the preconditions of the corresponding primitive operators)

A third effect is that of _increased redundancy,_ which tends to degrade
performance. There are two sources of increased redundancy. First, the
learned macro-operators duplicate a portion of the original search space. Thus,

3 The cost of precondition matching is typically the dominating cost in STRIPS-like systems. In
general, if a macro-operator is created from an operator sequence _opt, op2,...,_ then every
precondition of every primitive operator _opk_ in this sequence will also be a precondition of the
resulting macro-operator, except for preconditions that are guaranteed to be true due to the action
of earlier operators in the sequence. (A precondition of _opk_ is guaranteed to be true if an earlier
operator _opi, j < k,_ either tests or adds that same precondition, and no operator between _opi_ and
_opk_ can delete that condition.) Thus the number of preconditions in a macro-operator will normally
be less than the sum of the preconditions of the primitive operators from which it is composed, but
the difference is often relatively small. Furthermore, the cost of matching a list of preconditions
depends not only on the number of preconditions, but also on the number of bindings each
precondition generates. As described in [231, the number of bindings generated when matching a
macro-operator's preconditions can be expected to be the same as the number of bindings
generated when matching the corresponding operator sequence, assuming that the conditions are
tested in the same order.

368 s. MINTON

### I

op3 opl, op1, opl,
op2 op3 op4

Fig. 1. Complete conversion of search space into macro-operators illustrates potential increase in

redundancy.

if no macro-operators are useful in a given state, the problem solver will resort
to its primitive operators, and thereby may repeat some of the work that was
done when considering the macro-operators. Secondly, the learned macrooperators may have duplicate initial subsequences. So, for example, a macrooperator composed of primitive operators _opl_ and _op2_ will share many of the
same preconditions as a macro-operator composed of primitive operators _opl,_

and _op3._ Thus, the preconditions of a primitive operator, such as _opl,_ may be
tested again and again as each of the macro-operators containing that operator
is tested. Figure 1 shows the transformation produced by macro-operator
formation when all operator sequences are converted into macro-operators,
illustrating the potential increase in redundancy. In general, increased redundancy explains why a macro-operator learning system may perform _worse_
than a nonlearning system, as was observed in the MAX/MORRIS experiments.
(Various schemes are possible to reduce redundancy, such as creating a data
structure so that the shared preconditions are tested once. However, such
schemes are generally incompatible with techniques for reducing path cost,
such as re-ordering the preconditions of individual macro-operators.)

Experience with the MORRIS system indicated that the utility of macrooperator learning is highest when a small set of macro-operators can be learned
that is sufficient for solving most problems. In this case, the positive effect of
re-ordering is maximized, while the negative effect of redundancy is minimized. This principle was illustrated by the MORRIS experiments, and by other
systems [14, 18] as well. For example, Korf's macro-learning system [18]
employs a very powerful method for isolating a small, extremely useful set of
macro-operators. In fact, Korf's technique is so powerful that it can completely
eliminate search in domains such as Rubik's cube. Unfortunately, most domains do not exhibit the properties necessary to apply Korf's technique, and
thus weaker heuristics for finding useful macro-operators must be used by
general problem solvers such as MORRIS.

The lessons from macro-operator learning extend to EBL systems in general.
As mentioned above, classical EBL systems operate very similarly to macrooperator learning systems, even though they are often described using different
terminology. The correspondence between the two approaches has been
remarked upon in previous work [9, 23, 27, 30]. Formally, the correspondence

QUANTITATIVE RESULTS ON UTILITY OF EBL 369

is established by equating explanations with operator sequences [23]. (This is
straightforward, since any proof rule can be encoded as a STRIPS operator, and
any STRIPS operator can be encoded as a set of situation calculus proof rules.)
According to this view, both EBL systems and macro-operator systems take an
initial set of rules (the theory in an EBL system or the operators in a
macro-operator system) and convert those rules into macro-rules, which are
then used in preference to reasoning with the original set of rules.

The correspondence between EBL and macro-operator learning is similar to
the correspondence between EBL and partial evaluation [39]--formally, one
can establish that the techniques are equivalent, but in practice, they tend to be
used in different ways. In this paper, for example, we describe how the
PRODIGY EBL module reasons at the meta-level, and thus, unlike standard
macro-operator systems can learn about problem solving successes, failures,
goal-interactions, and other phenomena. Nevertheless, the effects that we have
identified above are still relevant to EBL in PRODIGY. Thus, as we will see,
finding a small set of useful rules and reducing redundancy are critical for
producing performance improvement in PRODIGY.

**3.1. Will the utility problem go away?**

It is sometimes claimed that the utility problem will be "solved" by the
development of highly parallel hardware and/or powerful indexing schemes.
This opinion is based on the belief that either of these developments would
make matching extremely inexpensive. If matching were inexpensive, this
would largely eliminate any question of EBL'S utility, since EBL, in effect,
converts a tree search problem into a matching problem. However, this
argument ignores two important points. First, the descriptions learned using

EBL are neither bounded in number nor in size. Secondly, the computational
cost of matching grows rapidly with the number and size of the learned
descriptions. Thus, the matching process requires search also (sometimes
referred to as _knowledge search_ [23, 38]).

Let us consider each of these points in turn. The number of learned
descriptions (where each learned description corresponds to the preconditions
of a macro-rule) depends on how many paths in the search space are considered useful, since each useful path is converted into a distinct learned
description. In the worst case, every path could conceivably be considered
useful. Furthermore, the size of each learned description may be very large,
depending on the number of rules used in the explanation. For example, even
in relatively simple domains such as the game-playing program's Gomoku
domain, rules with hundreds of preconditions were learned.

It is well established that the cost of matching increases rapidly with the size
and number of rules being matched. For example, matching a conjunctive
description containing existentially quantified variables is NP-complete [12,

370 s. MINTON

23]. The complexity of matching more expressive descriptions may be even
higher. In particular, matching descriptions that can have nested quantifiers,
such as those produced by PRODIGY, is PSPACE-complete [12, p. 233]. Thus, in
the worst case, the behavior of the system may be very poor as the learned
descriptions grow in number and size.

Therefore, while fast hardware and good indexing schemes can be extremely
useful for matching the learned descriptions, in general, they alone cannot
solve the utility problem. If a learning system can generate arbitrary descriptions as search control knowledge, then there will always be potential matching
problems. Instead, the solution to the utility problem is to avoid learning
overly expensive descriptions in the first place. The system should be sensitive
to the costs and savings of the descriptions it learns relative to its computational architecture.

4. Overview of PRODIGY

The PRODIGY system includes the following modules:

- A domain-independent means-ends analysis problem solver that includes a

simple reason-maintenance system and allows operators to have conditional effects. The problem solver's search (means-ends analysis) can be
guided by explicit control rules.

**-** An explanation-based learning facility for acquiring search control rules
from a problem solving trace. Explanations are constructed from an
axiomatized theory describing both the domain and the relevant aspects of
the problem solver's architecture.

**-** A graphics-oriented user-interface that enables the user to evaluate and
guide the system's problem solving and learning.

Several additional subsystems are under development, including modules for
abstraction learning [17], derivational analogy [2, 5], and learning by experimentation [4], as well as an interface to the CMU World Modelers system

[3]. This paper focuses only on the EBL module and its effect on problem
solving performance.

PRODIGY extends traditional problem solving and planning frameworks by
separating search control knowledge and domain knowledge. Thus, instead of
relying on complex, built-in search strategies, the PRODIGY problem solver
uses an approach we refer to as "casual commitment." If no control rules are
present to guide a decision, the problem solver makes a quick, arbitrary
choice, employing a simple default control structure. Presumably, if a decision
is important, appropriate control rules will eventually be acquired, either
automatically or through the user's intervention.

The problem solver's search is conducted by repeating the following decision
cycle:

QUANTITATIVE RESULTS ON UTILITY OF EBL 371

(1) A node in the search tree is chosen. A node consists of a set of goals and

a state of the world.
(2) One of the goals at that node is chosen.
(3) An operator relevant to fulfilling the goal is chosen.
(4) Bindings for the variables in the operator are selected. If the instantiated

operator is applicable, then it is applied to the state, otherwise PRODIGY
recursively subgoals on the operator's unmatched preconditions. In
either case, a new node in the search tree is created.

Control rules modify the default behavior by specifying that a particular
candidate (a node, goal, operator or bindings) should be either selected,
rejected, or preferred over another candidate.

For example, the following control rule is relevant to solving blocks world
problems; it states that if (ON x y) and (ON y z) are both goals at the current
node in the search tree, then the latter goal should be achieved first:

IF (AND (CURRENT-NODE _node)_

(CANDIDATE-GOAL _node_ (ON x y))
(CANDIDATE-GOAL _node_ (ON y z)))
THEN (PREFER GOAL (ON y z) TO (ON x y))

This information is useful because if (ON x y) is achieved first, subsequently
achieving (ON y z) will undo (ON x y). Using this rule PRODIGY can build
towers of arbitrary height correctly (i.e., from the bottom up). The rule is
learned by analyzing a problem solving trace in which the wrong order was
attempted first and explaining why the goal interaction occurred. The language
in which the rule is expressed is a form of first-order predicate calculus used
throughout the PRODIGY system. The language allows existential quantification, universal quantification over sets, negation, conjunction and disjunction.
(Only universal quantification is used in this paper, so the quantifiers have
been omitted for readability.)

**5. The PRODIGY EBL Component**

PRODIGY addresses the utility problem by searching for "good' explanations-explanations that result in effective control knowledge. The learning process
occurs in three stages. First, after each problem solving episode, the system
considers what to explain in the problem solving trace, and constructs an
explanation. Second, the system considers how best to represent the weakest
preconditions of the explanation. The resulting description becomes the lefthand side of a new control rule. Finally, the utility of the rule is measured
during subsequent problem solving to insure that it is useful.

372 s. MINTON

**$.I. Selecting what to learn and generating an initial explanation**

A significant difference between PRODIGY and most other EBL problem solving
systems is the range of target concepts that are employed. PRODIGY's target
concepts are meta-level concepts, such as SUCCEEDS, FAILS, and GOAL-INTERFERENCE, that describe problem solving phenomena. Most earlier EBL problem
solving systems, such as STRIPS [10] and LEX2 [28], were limited to learning
from solution sequences. In other words, their target concepts were essentially
the same as the goals of the problem solving system. PROD1GY's meta-level
target concepts enable it to take full advantage of the expressive power of its
control rules; for example, PRODIGY can explain why an alternative at a choice
point should be rejected, which is not possible in traditional macro-operator
learning systems. (Other EBL systems have also begun to exploit this capability

[13, 31].) Our intention was to provide a uniform, extensible framework for
producing explanations about any phenomena witnessed in a problem solving
trace, rather than a system specifically designed to reason from success, failure,
or any particular target concept.

Listed below are the four types of target concepts currently implemented in
PRODIGY. (Each type of target concept has a variation for nodes, goals,
operators and bindings.)

(1) SUCCEEDS: A control choice (of a node, goal, operator or bindings)

succeeds if it leads to a solution. Learning about successes results in
preference rules.
(2) FAILS: A choice fails if there is no solution consistent with that choice.

Learning about failures results in rejection rules.
(3) SOLE-ALTERNATIVE: A choice is a sole alternative if all other candidates

fail. Learning about sole alternatives results in selection rules.
(4) GOAL-INTERFERENCE: A choice results in goal interference if some

condition that was previously true must be re-achieved (in every solution
consistent with that choice). Learning about goal interference results in
preference rules.

The set of target concepts is declaratively specified to the system. Because
there can be many training examples for the various target concepts in a single
problem solving episode, each target concept is associated with heuristics for
selecting training examples. When examining the problem solving trace, PRODIGY uses these heuristics to pick out examples that appear to offer the most
promise of producing useful control rules. For example, the success of an
operator is deemed to be interesting only if other operators failed.

After an example of a target concept is selected, PRODIGY constructs an
explanation. (This process is described in detail elsewhere [23, 24].) Two sets
of axioms are employed: a set of architectural-level axioms describing the
relevant aspects of the problem solver and a set of domain-level axioms

QUANTITATIVE RESULTS ON UTILITY OF EBL 373

describing the task domain. Whereas the architectural-level axioms are handcrafted, the domain-level axioms are automatically derived from the problem
solving operators and any existing search control rules. To construct an
explanation, an algorithm called _explanation-based specialization_ (EBS) is used.
EBS maps directly from the problem solving trace into an explanation, as
described in [23]. No search is involved, since the explanation is determined
completely by the problem solving trace. The EBS algorithm then finds the
weakest preconditions of the explanation, which constitutes the initial learned
description.

**5.2. Compression: Improving an explanation**

The purpose of compression is to reduce the match cost of the descriptions
produced by EBS (and thereby increase the utility of the resulting search
control rules). Compression is essentially a simplification process. PRODIGY'S
compressor module operates on the learned description, first employing partial
evaluation [15], then applying domain-independent logical transformations, 4
and finally calling a theorem prover which can take advantage of user-supplied,
domain-specific simplification axioms. 5 To illustrate the effect of compression,
let us consider a very simple blocks world example. An initial learned
description, which states that (ON xx) is unachievable, can be simplified as
shown below. To do so the compressor employs some simple equivalence
preserving transformations and a domain-specific simplification axiom stating
that a block is either on the table, on another block, or being held.

(FAILS _goal node)_
if (AND (CURRENT-GOAL _node goal)_

(MATCHES _goal_ (ON x y))
(OR (AND (KNOWN (ON-TABLE y))

(EQUAL X y))
(AND (KNOWN (ON y z))

(EQUAL X y))
(AND (KNOWN (HOLDING y))

(EQUAL X y))))

4 PRODIGY's domain-independent transformations enable it to take advantage of standard
simplification rules, such as DeMorgan's law, as well as other transformations that are more
specific to the architecture, such as conjunct ordering heuristics.

5 The simplification axioms are optional. They are used because the domain operators do not
describe the domain completely. In particular, the set of legal initial states is unspecified. For
example, one simplification axiom for the blocks world states that the robot can be holding only
one block at a time, a fact that is impossible to ascertain from the operators alone. For each of the
domains described in this paper, the set of simplification axioms is very small.

374 s. MINTON

reduces to

(FAILS _goal node)_
if (AND (CURRENT-GOAL _node goal)_

(MATCHES GOAL (ON X X)))

In addition to simplifying individual descriptions, the compressor can also
combine results from multiple examples in order to reduce total match cost. A
very simple example is shown below. The first rule in the figure states that the
goal (HOLDING X) will succeed (i.e., can be achieved) if block x is on the table.
The second rule indicates that the goal (HOLDING y) will succeed if block y is
on another block. These can be compressed into a single rule stating that a goal
(HOLDING Z) will always succeed, since the block z must be either on the table
or on another block.

(SUCCEEDS _goal node)_
if (AND (CURRENT-GOAL _node goal)_

(MATCHES _goal_ (HOLDING x))
(KNOWN _node_ (IS-BLOCK x))
(KNOWN _node_ (ON-TABLE x)))

(SUCCEEDS _goal node)_
if (AND (CURRENT-GOAL _node goal)_

(MATCHES _goal_ (HOLDING y))
(KNOWN _node_ (IS-BLOCK y))
(KNOWN _node_ (IS-BLOCK w))
(KNOWN _node_ (ON y w)))
reduce to

(SUCCEEDS _goal node)_
if (AND (CURRENT-GOAL _node goal)_

(MATCHES _goal_ (HOLDING z)))

The compressor's task of minimizing description's match cost is, unfortunately, undecidable. To see this, consider that the most inexpensive descriptions to
match are (TRUE) and (FALSE), Therefore an optimal compressor would be
able to reduce all valid formulas to (TRUE) and all unsatisfiable formulas to
(FALSE). However, arbitrary first-order sentences can be represented in PRODIGY'S description language, and this task is undecidable for first-order logic.

In fact, PRODIGY'S compressor is not guaranteed to minimize match cost.
The compressor employs a set of heuristic transformations, each of which tends
to reduce match cost. In the first stage of compression, individual atomic
formulas are transformed to less expensive formulas (e.g., TRUE and FALSE)
via partial evaluation. In the second stage of compression, domain-independent

QUANTITATIVE RESULTS ON UTILITY OF EBL 375

logical transformations carry out more complex manipulations such as raising
common subexpressions. These first two stages terminate relatively quickly
given the set of transformations currently in the system. In the third stage, a
simple theorem prover applies optional, user-supplied simplification axioms,
each of which encodes a transformation, using a variation of Brown's scheme

[1]. Since theorem proving is a potentially unbounded process, PRODIGY will
terminate this process if it exceeds a specified time limit.

In practice, we have found that compression is crucial for making EBL useful
in PRODIGY. Compression eliminates a significant amount of redundancy in the
learned rules. The majority of the simplifications involve very simple reductions and reorderings; however, without these simplifications, the learned
control rules would have hundreds, if not thousands of terms. For example, the
architecture-level axioms for FAILS require several pages of dense logical
notation. Without compression, the descriptions learned by analyzing failures
tend to be pages long, and highly redundant.

**5.3. Evaluating the utility of an explanation**

The utility of a control rule learned by PRODIGY'S EBS process is measured in
terms of the speedup that results from the rule's use. Specifically, utility is
given by the cost/benefit formula:

_Utility = ( AvrSavings × ApplicFreq) - AvrMatchCost,_

where _AvrSavings_ is the average time savings produced when the rule is
applicable due to the fact that search is eliminated, _ApplicFreq_ is the probability that the rule is applicable when it is tested, and _AvrMatchCost_ is the average
time cost of matching the rule.

After learning a control rule, PRODIGY produces an initial estimate of the
rule's utility based on the training example that produced the rule. Specifically,
the system compares the time cost of matching the rule against the time savings

that the rule would have produced by eliminating search. Only if the savings
outweigh the cost is the rule included in the active set of control rules. This

estimation phase eliminates rules that are obviously poor. 6

After a rule is added to the system, PRODIGY attempts to empirically
validate the utility estimate, so that it can discard any remaining rules which

  - An important side-effect of this process is that it prevents ineffective rules from participating in
the explanation process. For each control rule in the system, there is a corresponding domain-level
axiom that is built so that, for instance, if a rejection rule fires, PRODIGY can explain why the
rejected alternative was rejected. When poor rules are added to the system, they tend to degrade
the explanations produced during the time that they are present, leading to a snowballing effect
where more and more poor rules are learned.

376 s. MINTON

are of negative utility. Although the match cost and application frequency of a
rule can be easily determined by direct measurement, determining the average
savings is more difficult. Doing so would require running the system with and
without the rule on each problem, and this would have to be done for each rule
in question. Because this would be excessively time consuming, PRODIGY relies
solely on the savings estimate (based on the example from which the rule was
learned) rather than computing the true average savings.

**6. Performance Results**

PRODIGY'S EBL learning component has been extensively tested in several
domains. These include the blocks world, an extension of the STRIPS robot
domain (including locking doors, keys, and a robot that can push and carry
objects), and a more complex machine shop scheduling domain. Scheduling
tasks require the problem solver to find a legal schedule for performing a set of
operations (involving a LATHE, DRILL-PRESS, GRINDER, etc.) on a variety of
objects. In all three domains PRODIGY's search space tends to grow exponentially with the size of the problem.

There are many problems from each domain in which learning produces
exponential speedup (i.e., after learning, similar problems are solved exponentially faster). However, as argued earlier, the real test of a learning method is
whether it improves performance with extended use in a problem solving
domain. Consequently, the main experimental results reported here concern
the system's performance in each domain after a large sample of training
problems have been solved.

To carry out the experiments, procedures for randomly generating problems
from each domain were devised. Each procedure includes parameters dictating
the maximum size of the problem to be generated. For example, the blocks
world procedure takes two parameters: the maximum number of blocks in the
initial state and the maximum number of goals to be achieved. Problems were
generated ranging from three blocks and three goals, to twelve blocks and
eight goals.

In each domain, the problem solver was given approximately one hundred
training problems to solve. As the training phase progressed, the maximum
problem size was gradually increased. The training phase was divided into
several subphases to allow the learning process to learn from simpler examples
first, and to insure that no rules were learned without undergoing utility
evaluation. (A detailed description of the training phase and the procedures for
generating problems can be found in [23].) Following the training phase,
learning was turned off, and the problem solver was presented with one
hundred test problems, again with gradually increasing maximum problem size.
For each problem, the problem solver was allowed to run for up to 80 CPU
seconds.

QUANTITATIVE RESULTS ON UTILITY OF EBL 377

**Results from the test phases for the three domains are summarized graphi-**
**cally in Fig. 2. 7 For comparison, the graphs show not only the performance of**
**the system with the learned rules, but also the performance of the system**
**without control rules, and the performance of the system with a set of**
**hand-coded control rules. (The hand-coded rules were written by other**
**members of the PRODIGY group, with the author's help.) The graphs show how**
**the cumulative problem solving time grows as the number of problems**
**increases. The cumulative time is the total problem solving time** **_over all_**
**_examples_** **up to that point. Thus, the slopes of the curves are positive because**
**the y-axis represents cumulative time. Because the problems are progressively**
**larger, and therefore tend to be more difficult, the** **_second derivatives_** **of the**
**curves are also positive.**

**Table 2 shows the number of test problems that remained unsolved in each**
**domain within the 80 CPU second time limit. The relatively large proportion of**
**unsolved problems for the "without rules" condition means that search was**
**frequently being cut off at 80 CPU seconds. This explains why the curves for**

**Blocksworld**

**_2O00_**
**_k_** **_I_** **_I_** **_I_**
**_"oo --I_** **_.a eOro,os I_**
**/** **Learned rulos** **I**
_1600. --|_ _........._ No **control rules** I '

**/** **&**
_1400_

_1200_

**_1000_**

**_8OO_**

**_6OO_**

.**t"***

,.."
.,

.,"

,.....-'"

**_400_**

**_2OO_**

/ ~ .//
..- ~

```
  10 20 30 40 50 60 70 80 90 100
```

**_Number of Problems_**

Fig. 2. **Overview of test phase results (from** [23]).

7 **Our discussion centers on the performance during the test phase, since the training phase** (and
**the one-time expense of learning) is assumed to be of lesser importance. It is worth mentioning,**
**however, that the time spent learning and the time spent problem solving were typically within** a
**factor of ten of each other, although there was significant variation from problem to problem.** In
**some cases learning took much less time than problem solving, on other occasions the opposite was**
**true. The cost of learning was correlated with both the size of the explored search tree and the**
**number of training examples that was selected.**

378 s. MINTON

STRIPS Robot Domain

```
  1 1 1

```

-- -- - Hand-coded rules
```
 - - Learned rules
        No control rules

```

_..oO"_
_.°.._

_,°,'"_

_.....o.-'"_

**_8_**

_6000_

_5000 --._

_4000_

_3000_

_2000_

_1000_

_°.°_ **_°_**
_,°_

_.°.°°_ _°'°_

_.°°_
_,°_
_.°._

_°,._

_°,*_
_°,_
_,.o °.°_
_~o..°°_

_J_

**_J_**

.... . ........... "' .,_,~-,1,,,-',,'~ - 

**_10_** **_20_**

_30_ _40_ _50_ _60_ _70_ _80_ _90_ _100_
**_Number of Problems_**

**Scheduling Domain**

_.**_

°.."

_3500_

_3000--_

_2500_

_2000_

_1500_

_1000._

_500_

_0_

```
 -- -- - Hand-coded rules
```

 - - Learned rules ."

......... No control rules .*' °*"

_I_
_10_

**...~...jl** ......

.-* *'"° J

_20_ _30_ _40_ _50_ _60_ _70_ _80_ _90_ _100_
_Number of Problems_

Fig. 2. _Continued._

Table 2
Number of unsolved test problems (within 80 CPU seconds)

Blocks STRIPS Scheduling
domain domain domain

With hand-coded rules 0 1 4
With learned rules 2 3 7
Without rules 19 49 32

QUANTITATIVE RESULTS ON UTILITY OF EBL 379

**the system running without control rules become relatively flat (approaching**
**linear) as the problems get large, rather than increasing exponentially.**

**The results from all three domains show the same general trends. In each**
**case, the system performed approximately 50-100% worse (in terms of**
**cumulative problem solving time) with the learned rules than with the expert**
**hand-coded rules, but much better than without control rules (although there**
**was significant variation on the individual problems). The difference between**
**learning and no-learning was especially dramatic in the** **STRIPS** **robot domain.**
**Table 3 lists more detailed performance results for every fifth problem from the**
**STRIPS domain test phase. The table indicates the time (in CPU seconds)**
**necessary to solve each problem without control rules, with the learned rules,**
**and with the hand-coded rules. In addition, the table indicates the number of**
**nodes expanded by the problem solver for each condition and next to this, in**
**parentheses, the number of nodes on the solution path. (The number of nodes**
**on the solution path is approximately twice the number of operators in the**
**solution, since for each operator the system will subgoai at one node, and then**
**apply the operator at a subsequent node.)**

**Why were the hand-coded rules more effective than the learned rules? Table**
**4 is illuminating. It shows the number of nodes explored and the average time**

**Table** 3
**Sample data from STRIPS domain test phase**

No **control rules** **Learned rules** **Hand-coded rules**

**Problem name** **Time Nodes** **Time Nodes** **Time Nodes**

SW-TST5 13.6 142(32) 8.3 32(32) 7.2 32(32)
SW-TST10 0.9 6(6) 1.2 6(6) 1.0 6(6)
SW-TST15 1.0 8(8) 1.6 8(8) 1.4 8(8)
SW-TST20 16.3 222(14) 4.7 14(14) 3.8 14(14)
SW-TST25 19.5 252(18) 4.6 18(18) 3.7 18(18)
SW-TST30 80.0 843" 12.9 42(42) 11.3 43(42)
SW-TST35 25.4 291(10) 6.9 19(10) 8.8 40(10)
SW-TST40 80.0 955 a 9.8 30(30) 16.0 70(30)
SW-TST45 80.0 840" 20.2 52(52) 25.3 99(52)
SW-TST50 80.0 872 a 16.1 46(46) 18.7 77(46)
SW-TST55 31.3 332(26) 9.3 26(26) 8.8 34(26)
SW-TST60 65.0 593(50) 20.4 52(50) 14.0 51(50)
SW-TST65 80.0 91T' 14.6 38(38) 11.8 39(38)
SW-TST70 80.0 588" 4.6 12(12) 3.3 12(12)
SW-TST75 80.0 742 a 27.7 55(30) 26.4 81(30)
SW-TST80 80.0 753" 19.3 43(34) 13.6 46(34)
SW-TST85 44.8 486(14) 6.0 14(14) 4.2 14(14)
SW-TST90 41.9 397(14) 6.8 14(14) 7.5 26(24)
SW-TST95 80.0 712 " 40.4 92(60) 13.4 40(40)
SW-TST100 80.0 793 " 30.6 67(60) 22.7 66(60)

a No **solution found within time limit.**

38O

Table 4
STRIPS robot domain, performance statistics

S. MINTON

Total nodes explored Average time per node

With hand-coded rules 3,992 0.274 seconds
With learned rules 4,038 0.379 seconds
Without rules 52,82l 0.098 seconds

necessary to examine each node, over all one hundred test problems in the
STRIPS domain. The data indicates that the learned rules and the hand-coded
rules were of comparable power; the total number of nodes explored in each
case was almost identical (approximately a factor of thirteen fewer nodes than
were explored without control rules). However, the use of control rules, both
learned _and_ hand-coded, increased the time necessary to expand each node
due to the extra processing time required to match the control rules. While the
extra cost was worthwhile, notice that the hand-coded rules were less expensive
to use than the learned rules, accounting for their better performance. In
summary, it would appear that for this domain the hand-coded rules and the
learned rules encoded roughly equivalent knowledge, but the learned rules did
not express the knowledge as efficiently. Presumably, this indicates that the
compression process can be improved. One cannot pin the blame solely on the
compressor, however, since its performance is highly dependent on the initial
description produced by EBS.

The results from the blocks world were similar, in that the learned rules were
approximately equivalent in coverage to the hand-coded rules, but more
expensive to use. Interestingly, the results from the scheduling domain,
summarized in Table 5, tell a slightly different story. In this case, the learned
rules were slighly _more_ efficient to evaluate than the hand-coded rules, but the
coverage of the learned rules was poorer, in that they did not focus the search
as well as the hand-coded rules. It appears that the learned rules were less
general than the hand-coded rules.

Finally, in evaluating the effectiveness of the learning mechanism, it is worth
noting that the learned rules were guaranteed to be correct, whereas the
hand-coded rules contained several errors. The errors were noticed only when
the solutions using the learned rules and hand-coded rules were compared.

Table 5
Scheduling domain, performance statistics

Total nodes explored Average time per node

With hand-coded rules 1,970 0.497 seconds
With learned rules 3,029 0.454 seconds
Without rules 33,790 0.096 seconds

QUANTITATIVE RESULTS ON UTILITY OF EBL 381

(The hand-coded rules were corrected before generating the final results shown
above.) Errors in the hand-coded rules were especially likely to crop up in the
more complex, less intuitive domains such as the scheduling domain. Coding
control rules can be a time-consuming, tedious process; in the scheduling
domain the task took approximately eight hours.

**6.1. Evaluating the system's components**

Analysis of the three most significant aspects of the PRODIGY EBL module (the
use of multiple meta-level target concepts, compression analysis, and utility
evaluation) reveal that they each contribute substantially to the overall effectiveness of the learning process.

A rough indication of the relative utility of the various target concepts can be
gained by comparing the relative number of rules learned from each target
concept that were empirically found to be useful. As shown in Table 6 below,
no individual target concept accounted for the improvement in problem solving
performance. To measure the contribution of compression, the blocks world
training phase and test phase problems were re-run with parts of the compressor "turned off." The results are shown in Fig. 3. As previously described,
compression occurs in three successive stages: partial evaluation, domainindependent transformations, and domain-specific transformations. Unfortunately, the first stage, partial evaluation cannot be turned off because it is
interleaved with (and necessary for) the EBS explanation process. With stages
two and three turned off during learning, the system's performance dropped to
a point which was actually worse than its performance without control rules.
With only the third stage of compression turned off, the system performed
approximately 40% worse in the test phase (but better than it did without any
control rules). Compression has such a significant effect because the explanations generated by PRODIGY can be verbose and repetitive, just as one might
expect machine-generated proofs to be. This is especially true when learning
from failures and goal-interferences. To explain why a failure (or a goalinterference) occurred, PRODIGY must explain why _all_ possible alternatives
resulted in failure (or a goal-interference). Typically, multiple alternatives fail

Table 6
Breakdown of rules learned by target concept type

Blocks world STRIPS Scheduling
domain domain domain

SUCCEEDS 1 6 6
FAILS 11 12 10
SOLE-ALTERNATIVE 4 6 4
OOAL-INTERFERENCE 3 6 17

**382** **s. MINTON**

**_2500_** **_,_**

**_2000_**

**_1500_**

**_1000_**

**_5_** **_0_** **_0_** **_-_** **_-_**

/

**-** **-** **Learn~** **rules**
**No control rules** 1"

. . . . **phase 3 shutdown** **/**
**-- • --** **phases 2 & 3 shutdown** _j_ **.** _."_ °"
_f._ _..°"_

Z ..
/'

r' ." .. J

r' ." .. J

**•**
# ;/
j. J ~ "°'"',t.- f'"
_¢" ...°"_ _f°'/_

**_10_** **_20_** **_30_** **_40_** **_50_** **_60_** **_70_** **_80_** **_90_** **_100_**
**_Number of Problems_**

Fig. 3. Contribution of **compression in the blocks world.**

**(or interfere) for the same reason, allowing ample opportunity for com-**
**pression.**

**The contribution of utility evaluation is summarized in Table 7. The table**
**lists the total number of training example/target concept pairs that were**
**explained via the EBS algorithm in the training phase for each domain. It also**
**indicates how many of the resulting control rules were initially estimated to be**
**useful, and the number of these control rules which passed empirical utility**
**validation.**

**To test the contribution of empirical utility validation, the blocks world**
**experiments were re-run without the validation step, so that the system saved**
**all rules estimated to be useful. As shown in Fig. 4, overall performance was**
**approximately sixty-five percent poorer than with the original learned rules,**
**but still better than without control rules. (When the utility estimation step was**
**also left out, performance deteriorated so rapidly that the full test phase could**
**not be completed due to resulting technical problems.)**

**Table** 7
**Contribution of utility evaluation**

**Blocks** **STRIPS** **Scheduling**
**domain** **domain** **domain**

**Examples analyzed** 328 588 946
**Control rules estimated to be useful** 69 130 243
**Control rules found to be useful** 19 30 37

**QUANTITATIVE RESULTS ON UTILITY OF EBL** **383**

**_2000_**

**_~_** **_1600 -_** **_-_**

**_~_** **_1400_**

**_1200_**

**_1000_**

_600_

**_40O_**

**_2OO_**

**I** **I** **I** **I**

**Learned rules**
**No control rules**

--  - -- No **utility analysis**,

_..•....•'•/.J_

_,j•:.~ "_ _fJ_
_J .:.1_ _/_

**• I°• ''**

_.•,.'•_

   - "• j. _/_
.•-" ~.
/

/"
f

## //

**_0_** **_10_** **_20_** **_30_** **_40_** **_50_** **_60_** **_70_** **_80_** **_90_** **_100_**
**_Number of Problems_**

Fig. 4. **Contribution of empirical utility validation in the blocks world.**

**7. Comparison with Macro-Operators**

**The learning system was also compared against traditional EBL macro-operator**
**techniques, using the same sets of training and test problems that were**
**described previously. To carry out the comparison, PRODIGY was modified so**
**that it could employ macro-operators in addition to the usual primitive**
**operators. Macro-operators and primitive operators were treated similarly,**
**with the following three exceptions: macro-operators were applied in prefer-**
**ence to primitive operators, macro-operators were used only for solving the**
**types of goals for which they were learned, and subgoaling on the precondi-**
**tions of macro-operators was disallowed. (These restrictions improved the**
**performance of the system.)**

**Both selective and unselective macro-operator learning techniques [22] were**
**tested. The selective macro-operator technique employed heuristics for de-**
**termining the most useful solution sequences (and subsequences) to learn.**
**These were essentially the same as the training example selection heuristics**
**that were used by the EBL module to learn from SUCCESS. s**

**In all three domains, the unselective macro-operator learning technique led**
**to performance degradation--the system ran considerably slower than it did**
**without any control rules• This was predicted from the results of the MAX/**

**The selection heuristics used by PRODIGY for macro-operator learning were weaker than those**
**used in the MORRIS system. We would have liked to directly compare MORRIS' selective**
**macro-operator learning technique with PRODIGY's learning technique, however, significant**
**differences between the MORRIS and PRODIGY architectures prevented us from using MORRIS'**
**selection heuristics [23]. For example, PRODIGY has no built-in evaluation function such as the**
**one that was used to learn MORRIS" t-macros.**

384 s. MINTON

MORRIS study. The performance of the selective macro-operator learning
technique varied with the domain. In the robot domain, performance improved
slightly, and in the scheduling domain performance degraded slightly. However, in the blocks world, selective macro-operator learning was as effective in
reducing search time as PRODIGY'S EBL method, although the solutions found
using macro-operators were almost fifty percent longer (and thus extremely
suboptimal).

Analyzing the results revealed why macro-operators were so effective at
reducing search time in the blocks world, and why the solutions were typically
suboptimal. Normally, the PRODIGY planner backtracks whenever a state-cycle
occurs (e.g. the planner puts block A on block B, and then removes block A
from block B). This helps the problem solver avoid suboptimal solutions. In
the blocks world, where state-cycles are frequent, significant backtracking may
be required before a cycle-free solution is found. When using macro-operators
the system "jumped" over intermediate states where cycles would have
normally been detected. In effect, the macro-operators caused the sytem to
trade solution quality for search time.

This effect is illustrated by the classic problem of achieving (AND
(ON A B)(ON B C)), where A, B and C are initially on the table. If PRODIGY is
not using macro-operators, and it orders (ON A B) before (ON B C), then it will
eventually have to backtrack over this decision; after putting A on B, there is
no way to put B on C without taking A off B (and creating a state-cycle). This
can be an expensive mistake, because the system may explore many alternative
methods for putting A on B before it realizes that ultimately all of these fail.
(For example, the system may consider many ways to achieve the subgoal
(HOLDING A) in order to put A on B.) Interestingly, the macro-operator
version of the system may have another alternative available so that it does not
backtrack to the goal-ordering decision. If, for instance, the macro-operator
(UNSTACKx y) (PUTDOWNx) (PICKUP y) is available, then it can be instantiated to (UNSTACK A B) (PUTDOWN A) (PICKUP B). This macro-operator
enables PRODIGY tO pickup B without noticing the state-cycle, so that it can
then put B on C. While the resulting solution is produced quickly, it is
suboptimal:

(PICKUP A)

(STACK A B)
(UNSTACK A B)
(PUTDOWN A) macro
**(PICKUP B)**
(STACK B C)
(PICKUP A)
(STACK A B)

QUANTITATIVE RESULTS ON UTILITY OF EBL 385

**8. Critique of the EBL Method**

The experiments presented in the previous section suggest that PRODIGY'S EBL
method significantly reduces problem solving time, especially when compared
to standard EBL techniques. However, the learned control rules were clearly
_not as effective_ as hand-coded control rules. In this section we consider the
three aspects of the system that improve upon standard EBL, and the shortcomings that still remain.

**8.1. Multiple types of explanations**

PRODIGY'S target concepts enable the system to learn from failure and goalinterference, in addition to learning from success. The need for this capability
became apparent during our experiments with macro-operator systems, such as
MORRIS, which can learn only from success. When we attempted to hand-code
control knowledge for MORRIS' robot domain, we found that much of the
obvious control knoweldge concerned what _not to do_ in a situation. Unfortunately, there was no way to encode that knowledge into a useful set of
macro-operators. Moreover, once we shifted from learning operator sequences
to learning control rules, we found that, intuitively speaking, there were a
variety of reasons for control decisions. The experimental results reported here
support our conjecture that learning from failures, goal-interactions and other
problem solving phenomena can be quite valuable, in addition to learning from
successes.

However, to achieve human-level performance, the current set of target
concepts and the accompanying theory must be expanded upon and/or refined.
This is borne out by an examination of the hand-coded rules for the three
domains investigated here, as well as a preliminary analysis of other domains.
For example, in scheduling domains, learning specifically about resource
bottlenecks appears to be a useful strategy. In planning domains, learning the
circumstances under which an action can achieve multiple goals simultaneously
appears promising. In general, we believe that the ability to support a wide
range of target concepts is essential for an EBL problem solver.

PRODIGY's explanations are also limited by the theory that accompanies the
target concepts. The architectural-level theory used by PRODIGY tO generate
explanations is hand-coded and has been highly engineered by the author so
that the resulting explanations are typically at a useful level of generality.
However, there are also many potentially useful explanations that PRODIGY
cannot generate. For example, in the blocks world, PRODIGY is incapable of
learning that if block x is under block y, the goal (CLEAR X) should be solved
before the goal (ON z y). The problem is that PRODIGY cannot formulate the
concept "under" with the axioms presently in the system. Learning the concept
"under" requires a recursive explanation, and the current version of PRODIGY
is not capable of generating recursive explanations. Due to this limitation the

386 s. MINTON

control rules PRODIGY learns can be overspecific. (The problem of learning
recursively defined concepts, referred to as the "generalization-to-N" problem
in EBL, has been addressed by Shavlik [35] and others [6, 8, 32].)

Another limitation is due to PRODIGY'S inability to explore competing
explanations. For example there may exist many possible explanations as to
why a particular choice fails. Specifically, at the leaf nodes of the search tree,
when a choice fails directly (e.g., because a goal-stack cycle is detected, or an
unachievable precondition is not true) the explanation algorithm always uses
the reason that the problem solver reports. When this explanation is propagated up the tree to explain why an entire subtree failed, it may turn out that
an alternative explanation would have produced a more useful rule. For
example, let us suppose that the goal (HOLDING x) fails because both PICKUP
and UNSTACK fail (these are the two relevant operators for achieving the goal).
Furthermore, suppose that PICKUP fails for _reason_ _1,_ and UNSTACK fails because
of either _reason~_ or _reason_ _2._ That is, either _reason~_ or _reason_ _2_ is sufficient to
explain the failure of UNSTACK. Unfortunately, PRODIGY is just as likely to
report either reason when it explains the failure of UNSTACK. If _reason_ _1_ is
chosen, then PRODIGY will learn that (HOLDING x) fails whenever _reason_ _1_ is
true, because both PICKUP and UNSTACK wilt fail. On the other hand, if _reason_ _2_
is picked, the PRODIGY will learn a less general rule, that (HOLDING x) fails
when both _reason~_ and _reason_ _2_ are true. This results from the explanation that
PICKUP will fail due to _reason~_ and UNSTACK will fail due to _reasons._
In general, we believe that EBL systems should support a broad range of
target concepts, they should have wide-spectrum theories that support explanations at varying levels of generality, and they should be able to explore
competing explanations. Furthermore, the system should be able to modify its
target concepts and theory to improve its learning performance. Currently,
PRODIGY's target concepts are too limited, its theory is too limited, and it
cannot compare competing explanations (it can only reject explanations with
negative utility). Furthermore, it is not capable of modifying either its target
concepts or theory. These are all areas for future work.

**8.2. Compression**

EBL can be regarded as a method for reformulating knowledge. We can view
the system as searching for a target concept representation that can be
efficiently tested. Because PRODIGY is capable of simplification (i.e., compression) as well as specialization (i.e., explanation), the space of reformulations is
correspondingly greater than if only specialization were possible. While most of
the simplifications that PRODIGY performs are simple, even trivial, our experiments have shown that the compression process contributes substantially to the
utility of PRODIGY's control rules, in part by reducing redundancy.

A significant drawback to the current implementation is that the explanation

QUANTITATIVE RESULTS ON UTILITY OF EBL 387

process occurs prior to, and independently of, the compression process. Thus it
is not possible to guide the explanation process in a direction that is likely to
produce useful simplifications. Another drawback is that compression only
applies equivalence-preserving transformations. Zweben and Chase [40] have
suggested a statistical approach where non-equivalence preserving transformations are applied in order to improve the learned knowledge. DeJong and
Mooney [9] suggest analytic methods for modifying the original explanations so
that the learned knowledge is more useful.

**8.3. Utility evaluation**

As was argued in Section 3, the learning process will only be successful if a
relatively small, powerful set of control rules can be identified. The use of
multiple target concepts enables PRODIGY to generate a greater variety of
explanations than previous systems, but without utility evaluation this strategy
is counterproductive. Because PRODIGY's utility evaluation process relies on
simple empirical timing measurements, it is relatively robust and quite general.
On the other hand, there are several outstanding problems. First, as described
in Section 5.3, the current system estimates each rule's savings, rather than
measuring the actual savings. The system could be improved by carrying out
the savings measurements on randomly selected problems, or using an analytic
savings metric. Second, the system considers the utility of each rule individually, but unfortunately, this is not guaranteed to find the _rule set_ with maximum
utility. Rules may interact with each other; for example, the addition of a new
selection rule may effect the application frequency of a pre-existing rejection
rule. To maximize the utility of the rule set, a more sophisticated strategy
would consider such interactions. Third, the utility evaluation process occurs
after the explanation and compression processes, and thus provides little
guidance in controlling these processes. Both explanation and compression
employ heuristics that are based on utility considerations, but these tend to be
quite weak.

**9. Critique of the Experimental Methodology**

Early work in EBL focused primarily on simple demonstrations showing that
the method would work on selected examples. However, as we have argued,
making EBL useful for large sets of problems is significantly more difficult. If an
EBL system is not sensitive to the utility of the explanations it produces, then its
overall performance is likely to be poor. The experiments described in this
paper serve two purposes. They support our claim that the utility problem can
have a significant impact, and they demonstrate that PRODIGY'S learning
method improves upon traditional EBL.

However, there are a number of difficult questions that remain to be
addressed. First and foremost, we have not adequately characterized the types

388 s. MINTON

of domains for which the learning method produces good results. We have
argued only that the learning method must produce a relatively small set of
control rules that are efficient to match. In [23], we proceed further, and
attempt to describe how the properties of a PRODIGY search space determine
whether such a set can be learned. Unfortunately, it is not the domain itself
that determines how useful learning will be, it is the domain's specification as a
set of operators. So, for example, we cannot say that PRODIGY performs well
in "the blocks world" we can only say that it performs well given our
representation of the blocks world.

The performance of the learning method also depends on the details of the
problem solving architecture. This can make it difficult to evaluate competing
learning methods, as illustrated by the subtle "optimality versus search time"
effect encountered when comparing the PRODIGY EBL method with macrooperator learning. In fact, we would like to directly compare PRODIGY with
other learning problem solvers, such as SOAR [19]; however, differences in
domain specification languages and problem solving architectures raise serious
methodological questions. Comparing PRODIGY tO SOAR is analogous to
comparing optimizing compilers for two different languages.

The preceding paragraphs have pointed out that the performance of a
learning system depends not only the particular problem sets that are presented, but also on the particular domain specification and the problem solving
architecture under consideration. To increase our confidence that that the
results described here will generalize to other situations, we attempted to
investigate varied domains, and tested the system on large sets of randomly
generated problems. Of course, theoretically speaking, there is no such thing
as an "average domain", no more than there is an "average problem" or an
"average architecture" (all of which are unbounded sets). To enable the results
described here to be reproduced and compared with results from competing
approaches, a manual for the PRODIGY system [26] and the domain specifications and problem generators [23] have been published, and all are available
from the author along with the system.

**10. Conclusion**

This article has argued that an EBL system must be sensitive to both the costs
and benefits of knowledge if it is to have a positive influence on performance.
We have implemented one approach that is consistent with this philosophy; the
PRODIGY EBL module attempts to identify a relatively small set of search
control rules, and represent them so that they can be matched efficiently. The
empirical results reported here demonstrate that, for the three domains
investigated, the PRODIGY EBL method can improve problem solving performance over large sets of problems. Moreover, the experiments show that
without the mechanisms used by PRODIGY (or mechanisms similar in effect),
EBL may not be useful.

QUANTITATIVE RESULTS ON UTILITY OF EBL 389

**There are clearly difficulties in comparing, replicating, and evaluating em-**
**pirical studies in machine learning. In spite of these problems, the fact that the**
**utility problem has been largely unacknowledged until recently illustrates the**
**importance of carrying out such studies. Empirical research can offer valuable**
**insight into complex problems, complementing theoretical analyses.**

ACKNOWLEDGEMENT

I would like to thank the members of the PRODIGY group, especially Craig Knoblock, Yolanda
Gil, and Jaime Carbonell, for their help in carrying out the experiments reported here. I would like
to thank Jaime Carbonell, Pat Langley, Jack Mostow and Allen Newell for suggesting these
experiments, and to Bernadette Kowalski for her help in revising this paper.

This research was supported in part by an AT&T Bell Laboratories Ph.D. Scholarship, in part
by NASA, in part by ONR under Contract N00014-84-K-0415 and in part by DARPA (DOD),
ARPA Order No. 4976 under contract F33615-87-C-1499, monitored by the Avionics Laboratory.
The views and conclusions contained in this document are those of the author and should not be
interpreted as representing the official policies, either expressed or implied, of these agencies.

REFERENCES

1. F.M. Brown, An experimental logic based on the fundamental deduction principle, _Artificial_
_Intelligence_ 30 (1986) 117-263.
2. J.G. Carbonell, Derivational analogy: A theory of reconstructive problem solving and
expertise acquisition, in: R.S. Michalski, J.G. Carbonell and T.M. Mitchell, eds., _Machine_
_Learning: An Artificial Intelligence Approach_ 2 (Morgan, Kaufmann, Los Altos, CA, 1986)
371-392.
3. J.G. Carbonell and G. Hood, The world modelers project: Objectives and simulator architecture, in: _Machine Learning: A Guide to Current Research_ (Kluwer Academic Press, Boston,
MA, 1986) 29-34.
4. J.G. Carbonell and Y. Gil, Learning by experimentation, in: _Proceedings Fourth International_
_Workshop on Machine Learning,_ Irvine, CA (1987) 256-266.
5. J.G. Carbonell and M.M. Veloso, Integrating derivational analogy into a general problemsolving architecture, in: _Proceedings Case-Based Reasoning Workshop,_ Clearwater Beach, FL
(1988) 104-124.
6. P.W. Cheng and J.G. Carbonell, Inducing iterative rules from experience: The FERMI
experiment, in: _Proceedings AAA1-86,_ Philadelphia, PA (1986) 490-495.
7. S.A. Chien, Extending explanation-based learning: Failure-driven schema refinement, in:
_Proceedings Third 1EEE Conference on Artificial Intelligence Applications,_ Orlando, FL (1987)
106-111.
8. W.W. Cohen, Generalizing number and learning from multiple examples in explanation based
learning, in: _Proceedings Fifth International Conference on Machine Learning,_ Ann Arbor, MI
(1988) 256-269.
9. G.F. DeJong and R. Mooney, Explanation-based learning: An alternative view, _Machine_
_Learning_ 1 (1986) 145-176.
10. R. Fikes, P. Hart and N. Nilsson, Learning and executing generalized robot plans, _Artificial_
_Intelligence_ 3 (1972) 251-288.
11. C.L. Forgy, Rete: A fast algorithm for the many pattern/many object pattern matching
problem, _Artificial Intelligence_ 19 (1982) 17-37.
12. M.R. Garey and D.S. Johnson, _Computers and Intractability: A Guide to the Theory of_
_NP-Completeness_ (Freeman, San Francisco, CA (1979).

390 s. MINTON

13. A. Gupta, Explanation-based failure recovery, in: _Proceedings" AAAI-87,_ Seattle, WA (1987)
606-610.
14. G.A. Iba, A heuristic approach to the discovery of macro-operators, _Machine Learning_ 3 (4)
(1989) 285-318.
15. K. Kahn, Partial evaluation as an example of the relationship between programming
methodology and AI, _A1 Mag._ 5 (1) (1984).
16. R.M. Keller, Defining operationality for explanation-based learning, in: _Proceedings AAAI-_
_87,_ Seattle, WA (1987) 482--487.
17. C.A. Knoblock, Learning hierarchies of abstraction spaces, in: _Proceedings Sixth International_
_Workshop on Machine Learning,_ Ithaca, NY (1989) 241-245.
18. R.E. Korf, Macro-operators: A weak method for learning, _Artificial Intelligence_ 26 (1985)
35-77.
19. J.E. Laird, P.S. Rosenbloom and A. Newell, Chunking in SOAR: The anatomy of a general
learning mechanism, _Machine Learning_ 1 (1986) 11-46.
20. S. Markovitch and P.D. Scott, The role of forgetting in learning, in: _Proceedings Fifth_
_International Conference on Machine Learning,_ Ann Arbor, MI (19881 459-465.
21. S. Minton, Constraint-based generalization, in: _Proceedings AAAI-84,_ Austin, TX (1984)
251-254.
22. S. Minton, Selectively generalizing plans for problem solving, in: _Proceedings 1JCAl-85,_ Los
Angeles, CA (1985) 596 602.
23. S. Minton, _Learning Search Control Knowledge: An Explanation-Based Approach_ (Kluwer
Academic Publishers, Boston, MA, 1988); also Tech. Rept. CMU-CS-88-133, Computer
Science Department, Carnegie-Mellon University, Pittsburgh, PA (1988).
24. S. Minton and J.G. Carbonell, Strategies for learning search control rules: An explanationbased approach, in: _Proceedings HCAI-87,_ Milan, Italy (1987) 228-235.
25. S. Minton, S. Carbonell, C. Knoblock, D.R. Kuokka, O. Etzioni and Y. Gil, Explanationbased learning: A problem solving perspective, _Artificial Intelligence_ 40 (1989) 63-118, Special
Issue on Machine Learning.
26. S. Minton, C.A. Knoblock, D.R. Kuokka, Y. Gil, R.L. Joseph and J.G. Carbonell, PRODIGY 2.0: The manual and tutorial, Tech. Rept., Carnegie-Mellon University, Pittsburgh, PA
(1989).
27. T. Mitchell, R. Keller and S. Kedar-Cabelli, Explanation-based generalization: A unifying
view, _Machine Learning_ 1 (1986) 47-8(/.
28. T. Mitchell, P. Utgoff and R. Banerji, Learning by experimentation: Acquiring and refining
problem-solving heuristics, in: R.S. Michalski, J.G. Carbonell and T.M. Mitchell, eds.,
_Machine Learning: An Artificial Intelligence Approach_ (Tioga, Palo Alto, CA, 1983) 163-190.
29. R.J. Mooney, Generalizing the order of operators in macro-operators, in: _Proceedings Fifth_
_International Conference on Machine Learning,_ Ann Arbor, MI (1988) 270-283.
3(1. R.J. Mooney and S.W. Bennet, A domain independent explanation-based generalizer, in:
_Proceedings AAAI-86,_ Philadelphia, PA (1986) 551 555.
31. J. Mostow and N. Bhatnagar, Failsafe: A floor planner that uses EBG to learn from its
failures, in: _Proceedings IJCAI-87,_ Milan, Italy (1987) 249-255.
32. A.E. Prieditis, Discovery of algorithms from weak methods, in: _Proceedings International_
_Meeting on Advances in Learning,_ Les Arcs, Switzerland (1986) 37-52.
33. A.E. Priedtis and J. Mostow, PROLEARN: Toward a Prolog interpreter that learns, in:
_Proceedings AAA1-87,_ Seattle, WA (1987) 494-498.
34. ES. Rosenbloom and J.E. Laird, Mapping explanation-based generalization onto SOAR, in:
_Proceedings AAAI-86,_ Philadelphia, PA (19861 561-567.
35. J.W. Shavlik and G.F. DeJong, An explanation-based approach to generalizing number, in:
_Proceedings 1JCAI-87,_ Milan, Italy (1987) 236-238.
36. B. Silver, Precondition analysis, in: R.S. Micbalski, J.G. Carboncll and T.M. Mitchell, eds,,

QUANTITATIVE RESULTS ON UTILITY OF EBL 391

_Machine Learning: An Artificial Intelligence Approach_ 2 (Morgan Kaufmann, Los Altos, CA,
1986) 647-670.
37. P. Tadepalli, Lazy explanation-based learning: A solution to the intractable theory problem,
in: _Proceedings IJCAI-89,_ Detroit, MI (1989) 694-700.
38. M. Tambe and A. Newel|, Some chunks are expensive, in: _Proceedings Fifth International_
_Conference on Machine Learning,_ Ann Arbor, MI (1988) 451-458.
39. F. van Harmelen and A. Bundy, Explanation-based generalisation = partial evaluation, _Artifi-_
_cial Intelligence_ 36 (1988) 401-412.
40. M. Zweben and M.P. Chase, Improving operationality with approximate heuristics, in:
_Proceedings AAAI Spring Symposium Series: Explanation-Based Learning,_ Palo Alto, CA
(1988) 100-106.

_Received May 1989_
