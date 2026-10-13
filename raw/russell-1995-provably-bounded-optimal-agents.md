# russell-1995-provably-bounded-optimal-agents

> Converted from `russell-1995-provably-bounded-optimal-agents.pdf` on 2026-10-13 via `pymupdf4llm`.
> Layout artefacts (broken equations, interleaved columns) are conversion noise, not the source.

---

Journal of Artificial Intelligence Research ( ) -0 Submitted / ; published / 

Provably Bounded-Optimal Agents

Stuart J. Russell russell@cs.berkeley.edu

Computer Science Division, University of California

Berkeley, CA 0, USA

Devika Subramanian devika@cs.cornell.edu

Computer Science Department, Cornel l University

Ithaca, NY , USA

Abstract

Since its inception, artificial intelligence has relied up on a theoretical foundation cen

tred around perfect rationality as the desired prop erty of intelligent systems. We argue,

as others have done, that this foundation is inadequate b ecause it imp oses fundamentally

unsatisfiable requirements. As a result, there has arisen a wide gap b etween theory and

practice in AI, hindering progress in the field. We prop ose instead a prop erty called bounded

optimality. Roughly sp eaking, an agent is b ounded-optimal if its program is a solution to

the constrained optimization problem presented by its architecture and the task environ

ment. We show how to construct agents with this prop erty for a simple class of machine

architectures in a broad class of real-time environments. We illustrate these results using

a simple mo del of an automated mail sorting facility. We also define a weaker prop erty,

asymptotic bounded optimality (ABO), that generalizes the notion of optimality in classical

complexity theory. We then construct universal ABO programs, i.e., programs that are

ABO no matter what real-time constraints are applied. Universal ABO programs can b e

used as building blo cks for more complex systems. We conclude with a discussion of the

prosp ects for b ounded optimality as a theoretical basis for AI, and relate it to similar trends

in philosophy, economics, and game theory.

. Intro duction

Since b efore the b eginning of artificial intelligence, philosophers, control theorists and

economists have lo oked for a satisfactory definition of rational b ehaviour. This is needed to

underpin theories of ethics, inductive learning, reasoning, optimal control, decision-making,

and economic mo delling. Doyle ( ) has prop osed that AI itself b e defined as the com

putational study of rational b ehaviour|effectively equating rational b ehaviour with intelli

gence. The role of such definitions in AI is to ensure that theory and practice are correctly

aligned. If we define some prop erty P, then we hop e to b e able to design a system that

provably p ossesses prop erty P . Theory meets practice when our systems exhibit P in real

ity. Furthermore, that they exhibit P in reality should b e something that we actually care

ab out. In a sense, the choice of what P to study determines the nature of the field.

There are a numb er of p ossible choices for P :

  - Perfect rationality: the classical notion of rationality in economics and philosophy.

A p erfectly rational agent acts at every instant in such a way as to maximize its

exp ected utility, given the information it has acquired from the environment. Since

action selection requires computation, and computation takes time, p erfectly rational

agents do not exist for non-trivial environments.

�c AI Access Foundation and Morgan Kaufmann Publishers. All rights reserved.

Russell & Subramanian

- Calculative rationality: the notion of rationality studied in AI. A calculatively rational

agent eventually returns what would have b een the rational choice at the b eginning of

its delib eration. There exist systems such as influence diagram evaluators that exhibit

this prop erty for a decision-theoretic definition of rational choice, and systems such

as nonlinear planners that exhibit it for a logical definition of rational choice. This

is assumed to b e an interesting prop erty for a system to exhibit since it constitutes

an \in-principle" capacity to do the right thing. Calculative rationality is of limited

value in practice, b ecause the actual b ehaviour exhibited by such systems is absurdly

far from b eing rational; for example, a calculatively rational chess program will cho ose

0

the right move, but may take 0

times to - long to do so. As a result, AI system

builders often ignore theoretical developments, b eing forced to rely on trial-and-error

engineering to achieve their goals. Even in simple domains such as chess, there is little

theory for designing and analysing high-p erformance programs.

  - Metalevel rationality: a natural resp onse to the problems of calculative rationality.

A metalevel rational system optimizes over the ob ject-level computations to b e p er

formed in the service of selecting actions. In other words, for each decision it finds

the optimal combination of computation-sequence-plus-action, under the constraint

that the action must b e selected by the computation. Full metalevel rationality is

seldom useful b ecause the metalevel computations themselves take time, and the met

alevel decision problem is often more difficult than the ob ject-level problem. Simple

approximations to metalevel rationality have proved useful in practice|for exam

ple, metalevel p olicies that limit lo okahead in chess programs|but these engineering

exp edients merely serve to illustrate the lack of a theoretical basis for agent design.

  - Bounded optimality: a b ounded optimal agent b ehaves as well as p ossible given its

computational resources. Bounded optimality sp eci�es optimal programs rather than

optimal actions or optimal computation sequences. Only by the former approach

can we avoid placing constraints on intelligent agents that cannot b e met by any

program. Actions and computations are, after all, generated by programs, and it is

over programs that designers have control.

We make three claims:

. A system that exhibits b ounded optimality is desirable in reality.

. It is p ossible to construct provably b ounded optimal programs.

. Artificial intelligence can b e usefully characterized as the study of b ounded optimality,

particularly in the context of complex task environments and reasonably p owerful

computing devices.

The first claim is unlikely to b e controversial. This pap er supp orts the second claim in

detail. The third claim may, or may not, stand the test of time.

We b egin in section with a necessarily brief discussion of the relationship b etween

b ounded optimality and earlier notions of rationality. We note in particular that some im

p ortant distinctions can b e missed without precise definitions of terms. Thus in section we

provide formal definitions of agents, their programs, their b ehaviour and their rationality.

Provably bounded-optimal agents

Together with formal descriptions of task environments, these elements allow us to prove

that a given agent exhibits b ounded optimality. Section examines a class of agent archi

tectures for which the problem of generating b ounded optimal configurations is efficiently

soluble. The solution involves a class of interesting and practically relevant optimization

problems that do not app ear to have b een addressed in the scheduling literature. We il

lustrate the results by showing how the throughput of an automated mail-sorting facility

might b e improved. Section initiates a discussion of how b ounded optimal configurations

might b e learned from exp erience in an environment. In section , we define a weaker prop

erty, asymptotic bounded optimality (ABO), that may b e more robust and tractable than

the strict version of b ounded optimality. In particular, we can construct universal ABO

programs. A program is universally ABO if it is ABO regardless of the sp eci�c form of

time dep endence of the utility function.

Universal ABO programs can therefore b e used as

building blo cks for more complex systems. We conclude with an assessment of the prosp ects

for further development of this approach to artificial intelligence.

. Historical Persp ective

The classical idea of p erfect rationality, which develop ed from Aristotle's theories of ethics,

work by Arnauld and others on choice under uncertainty, and Mill's utilitarianism, was put

on a formal fo oting in decision theory by Ramsey ( ) and vonNeumann and Morgernstern

( ). It stipulates that a rational agent always act so as to maximize its expected utility.

The exp ectation is taken according to the agent's own b eliefs; thus, p erfect rationality do es

not require omniscience.

In artificial intelligence, the logical definition of rationality, known in philosophy as the

\practical syllogism", was put forward by McCarthy ( ), and reiterated strongly by

Newell ( ). Under this definition, an agent should take any action that it b elieves is

guaranteed to achieve any of its goals. If AI can b e said to have had a theoretical foun

dation, then this definition of rationality has provided it. McCarthy b elieved, probably

correctly, that in the early stages of the field it was imp ortant to concentrate on \epistemo

logical adequacy" b efore \heuristic adequacy" | that is, capability in principle rather than

in practice. The metho dology that has resulted involves designing programs that exhibit

calculative rationality, and then using various sp eedup techniques and approximations in

the hop e of getting as close as p ossible to p erfect rationality. Our b elief, alb eit unproven, is

that the simple agent designs that fulfill the sp eci�cation of calculative rationality may not

provide go - d starting p oints from which to approach b ounded optimality. Moreover, a the

oretical foundation based on calculative rationality cannot provide the necessary guidance

in the search.

It is not clear that AI would have embarked on the quest for calculative rationality had it

not b een op erating in the halcyon days b efore formal intractability results were discovered.

One resp onse to the sp ectre of complexity has b een to rule it out of b ounds. Levesque and

Brachman ( ) suggest limiting the complexity of the environment so that calculative and

p erfect rationality coincide. Doyle and Patil ( ) argue strongly against this p osition.

. This usage of the term \universal" derives from its use in the scheduling of randomized algorithms by

Luby, Sinclair and Zuckerman ( ).

Russell & Subramanian

Economists have used p erfect rationality as an abstract mo del of economic entities, for

the purp oses of economic forecasting and designing market mechanisms. This makes it

p ossible to prove theorems ab out the prop erties of markets in equilibrium. Unfortunately,

as Simon ( ) p ointed out, real economic entities have limited time and limited p owers

of delib eration. He prop osed the study of bounded rationality, investigating \: : : the shap e

of a system in which effectiveness in computation is one of the most imp ortant weap ons

of survival." Simon's work fo cussed mainly on satis�cing designs, which delib erate until

reaching some solution satisfying a preset \aspiration level." The results have descrip

tive value for mo delling various actual entities and p olicies, but no general prescriptive

framework for b ounded rationality was develop ed. Although it proved p ossible to calculate

optimal aspiration levels for certain problems, no structural variation was allowed in the

agent design.

In the theory of games, b ounds on the complexity of players have b ecome a topic of

intense interest. For example, it is a troubling fact that defection is the only equilibrium

strategy for unb ounded agents playing a fixed numb er of rounds of the Prisoners' Dilemma

game. Neyman's theorem (Neyman,  ), recently proved by Papadimitriou and Yan

nakakis ( ), shows that an essentially co op erative equilibrium exists if each agent is a

finite automaton with a numb er of states that is less than exp onential in the numb er of

rounds. This is essentially a b ounded optimality result, where the b ound is on space rather

than on sp eed of computation. This typ e of result is made p ossible by a shift from the

problem of selecting actions to the problem of selecting programs.

I. J. Go   - d ( ) distinguished b etween p erfect or \typ e I" rationality, and metalevel

or \typ e I I" rationality. He defines this as \the maximization of exp ected utility taking into

account deliberation costs." Simon ( ) also says: \The global optimization problem is

to find the least-cost or b est-return decision, net of computational costs." Although typ e I I

rationality seems to b e a step in the right direction, it is not entirely clear whether it can b e

made precise in a way that resp ects the desirable intuition that computation is imp ortant.

We will try one interpretation, although there may b e others.

The key issue is the space

over which the \maximization" or \optimization" - ccurs. Both Go - d and Simon seem to

b e referring to the space of p ossible delib erations asso ciated with a particular decision.

Conceptually, there is an \ob ject-level machine" that executes a sequence of computations

under the control of a \meta-level machine." The outcome of the sequence is the selection of

an external action. An agent exhibits typ e I I rationality if at the end of its delib eration and

subsequent action, its utility is maximized compared to all p ossible delib erate/act pairs in

which it could have engaged. For example, Go - d discusses one p ossible application of typ e

I I rationality in chess programs. In this case, the ob ject-level steps are no de expansions in

the game tree, followed by backing up of leaf no de evaluations to show the b est move. For

simplicity we will assume a p er-move time limit. Then a typ e I I rational agent will execute

whichever sequence of no de expansions cho oses the b est move, of all those that finish b efore

. For example, it is conceivable that Go - d and Simon really intended to refer to finding an agent design

that minimizes delib eration costs in general. All their discussions, however, seem to b e couched in terms

of finding the right delib eration for each decision. Thus, typ e I I or metalevel rationality coincides with

b ounded optimality if the b ounded optimal agent is b eing designed for a single decision in a single

situation.

the time limit.

Provably bounded-optimal agents

Unfortunately, the computations required in the \metalevel machine" to

select the ob ject-level delib eration may b e extremely exp ensive. Go - d actually prop oses a

fairly simple (and nearly practical) metalevel decision pro cedure for chess, but it is far from

optimal. It is hard to see how a typ e I I rational agent could justify executing a sub optimal

ob ject-level computation sequence if we limit the scop e of the optimization problem to a

single decision. The difficulty can only b e resolved by thinking ab out the design of the

agent program, which generates an unb ounded set of p ossible delib erations in resp onse to

an unb ounded set of circumstances that may arise during the life of the agent.

Philosophy has also seen a gradual evolution in the definition of rationality. There has

b een a shift from consideration of act utilitarianism | the rationality of individual acts | to

rule utilitarianism, or the rationality of general p olicies for acting. This shift has b een caused

by difficulties with individual versus so cietal rationality, rather than any consideration of

the difficulty of computing rational acts. Some consideration has b een given more recently

to the tractability of general moral p olicies, with a view to making them understandable

and usable by p ersons of average intelligence (Brandt,  ). Cherniak ( ) has suggested

a definition of \minimal rationality", sp ecifying lower b ounds on the reasoning p owers of

any rational agent, instead of upp er b ounds. A philosophical prop osal generally consistent

with the notion of b ounded optimality can b e found in Dennett's \Moral First Aid Manual"

( ). Dennett explicitly discusses the idea of reaching equilibrium within the space of

decision pro cedures. He uses as an example the PhD admissions pro cedure of a philosophy

department. He concludes, as do we, that the b est pro cedure may b e neither elegant nor

illuminating. The existence of such a pro cedure, and the pro cess of reaching it, are the

main p oints of interest.

Many researchers in AI, some of whose work is discussed b elow, have worked on the

problem of designing agents with limited computational resources. The AAAI Sym

p osium on AI and Limited Rationality (Fehling & Russell,   ) contains an interesting

variety of work on the topic. Much of this work is concerned with metalevel rationality.

Metareasoning | reasoning ab out reasoning | is an imp ortant technique in this area,

since it enables an agent to control its delib erations according to their costs and b ene�ts.

Combined with the idea of anytime (Dean & Bo ddy,  ) or flexible algorithms (Horvitz,

 ), that return b etter results as time go es by, a simple form of metareasoning allows

an agent to b ehave well in a real-time environment. A simple example is provided by

iterative-deep ening algorithms used in game-playing. Breese and Fehling ( 0) apply sim

ilar ideas to controlling multiple decision pro cedures. Russell and Wefald (  ) give a

general metho d for precompiling certain asp ects of metareasoning so that a system can e�

ciently estimate the effects of individual computations on its intentions, giving fine-grained

control of reasoning. These techniques can all b e seen as approximating metalevel rational

ity; they provide useful insights into the general problem of control of reasoning, but there

is no reason to supp ose that the approximations used are optimal in any sense.

The intuitive notion of b ounded optimality seems to have b ecome current in the AI

community in the mid- 0's. Horvitz ( ) uses the term bounded optimality to refer

to \the optimization of computational utility given a set of assumptions ab out exp ected

. One would imagine that in most cases the move selected will b e the same move selected by a Typ e

I agent, but this is in a sense \accidental" b ecause further delib eration might cause the program to

abandon it.

Russell & Subramanian

problems and constraints in reasoning resources." Russell and Wefald ( ) say that an

agent exhibits b ounded optimality for a given task environment \if its program is a solution

to the constrained optimization problem presented by its architecture." Recent work by

Etzioni (  ) and Russell and Zilb erstein ( ) can b e seen as optimizing over a well

defined set of agent designs, thereby making the notion of b ounded optimality more precise.

In the next section, we build a suitable set of general definitions from the ground up, so

that we can b egin to demonstrate examples of provably b ounded optimal agents.

. Agents, Architectures and Programs

Intuitively, an agent is just a physical entity that we wish to view in terms of its perceptions

and actions. What counts in the first instance is what it do es, not necessarily what it thinks,

or even whether it thinks at all. This initial refusal to consider further constraints on the

internal workings of the agent (such as that it should reason logically, for example) helps in

three ways: first, it allows us to view such \cognitive faculties" as planning and reasoning

as - ccurring in the service of finding the right thing to do; second, it makes ro om for those

among us (Agre & Chapman,  ; Bro oks,  ) who take the p osition that systems can

do the right thing without such cognitive faculties; third, it allows more freedom to consider

various sp eci�cations, b oundaries and interconnections of subsystems.

We b egin by de�ning agents and environments in terms of the actions and p ercepts

that they exchange, and the sequence of states they go through. The agent is describ ed

by an agent function from p ercept sequences to actions. This treatment is fairly standard

(see, e.g., Genesereth & Nilsson,  ). We then go \inside" the agent to lo ok at the agent

program that generates its actions, and define the \implementation" relationship b etween

a program and the corresp onding agent function. We consider p erformance measures on

agents, and the problem of designing agents to optimize the p erformance measure.

. Sp ecifying agents and environments

An agent can b e describ ed abstractly as a mapping (the agent function) from p ercept

sequences to actions. Let O b e the set of p ercepts that the agent can receive at any instant,

and A b e the set of p ossible actions the agent can carry out in the external world. Since

we are interested in the b ehaviour of the agent over time, we intro duce a set of time p oints

or instants, T. The set T is totally ordered by the < relation with a unique least element.

Without loss of generality, we let T b e the set of non-negative integers.

The p ercept history of an agent is a sequence of p ercepts indexed by time. We define

T

T

: T ! Og. The prefix of a history O

T

T

the set of p ercept histories to b e O

t

T

= fO

O

till time t is denoted O

and is the pro jection of O

t

on [0::t]. We can define the set of

T

t

T

p ercept history prefixes as O

T T

= fO

j t T; O

O

g. Similarly, we define the set of

t

action histories A

= fA

t

: T ! Ag. The set of action history prefixes is A

T T

, defined as

the set of pro jections A

of histories A

A

.

Definition Agent function: a mapping

t

f : O

! A

0

Provably bounded-optimal agents

where

T

A (t) = f (O

t

)

Note that the agent function is an entirely abstract entity, unlike the agent program that

implements it. Note also that the \output" of the agent function for a given p ercept sequence

may b e a null action, for example if the agent is still thinking ab out what to do. The agent

function sp eci�es what the agent do es at each time step. This is crucial to the distinction

b etween p erfect rationality and calculative rationality.

Agents live in environments. The states of an environment E are drawn from a set X.

T T

The set of p ossible state tra jectories is defined as X

T

= fX

: T ! Xg. The agent do es not

necessarily have full access to the current state X

(t), but the p ercept received by the agent

do es dep end on the current state through the perceptual filtering function fp

. The effects

of the agent's actions are represented by the environment's transition function f

, which

e

sp eci�es the next state given the current state and the agent's action. An environment is

therefore defined as follows:

Definition Environment E : a set of states X with a distinguished initial state X0

, a

transition function f

T

and a perceptual filter function f

such that

e

p

X

(0) = X0

T

(A

T

T

X

T

(t + ) = fe

T

(t); X

(t))

O

(t) = fp

T

(X

(t))

The state history X

is thus determined by the environment and the agent function. We

use the notation effects(f ; E ) to denote the state history generated by an agent function

t

f op erating in an environment E . We will also use the notation [E ; A

t

] to denote the

state history generated by applying the action sequence A

environment E .

starting in the initial state of

Notice that the environment is discrete and deterministic in this formulation. We can

extend the definitions to cover non-deterministic and continuous environments, but at the

cost of additional complexity in the exp osition. None of our results dep end in a significant

way on discreteness or determinism.

. Sp ecifying agent implementations

We will consider a physical agent as consisting of an architecture and a program. The

architecture is resp onsible for interfacing b etween the program and the environment, and

for running the program itself. With each architecture M, we asso ciate a finite programming

language L

, which is just the set of all programs runnable by the architecture. An agent

M

program is a program l LM

that takes a p ercept as input and has an internal state drawn

from a set I with initial state i

. (The initial internal state dep ends on the program l,

0

but we will usually suppress this argument.) The set of p ossible internal state histories is

T

till time t is denoted I

T

T

T

I

t

I

= fI

: T ! I g. The prefix of an internal state history I

T

and is the pro jection of I

on [0::t].

Russell & Subramanian

Definition An architecture M is a fixed interpreter for an agent program that runs the

program for a single time step, updating its internal state and generating an action:

- I - O ! I - A

T

T

where

M : LM

T

T

hI

(t + ); A

(t)i = M (l ; I

(t); O

(t))

Thus, the architecture generates a stream of actions according to the dictates of the program.

Because of the physical prop erties of the architecture, running the program for a single

time step results in the execution of only a finite numb er of instructions. The program may

often fail to reach a \decision" in that time step, and as a result the action pro duced by the

architecture may b e null (or the same as the previous action, dep ending on the program

design).

. Relating agent sp eci�cations and implementations

We can now relate agent programs to the corresp onding agent functions. We will say that an

agent program l running on a machine M implements the agent function Ag ent(l ; M ). The

agent function is constructed in the following definition by sp ecifying the action sequences

pro duced by l running on M for all p ossible p ercept sequences. Note the imp ortance of the

\Markovian" construction using the internal state of the agent to ensure that actions can

only b e based on the past, not the future.

Definition A program l running on M implements the agent function f = Ag ent(l ; M ),

t

T

) = A

(t) where

defined as fol lows. For any environment E = (X; fe

; f

p

), f (O

T

T

(t + ); A (

T

T

hI

(t)i = M (l ; I

T

T

O

(t) = fp

(X

T

(t); O

(t))

T

T

X

(t + ) = fe (A

T

(t); X

(t))

(t))

X

I

(0) = X0

(0) = i0

T

Although every program l induces a corresp onding agent function Ag ent(l ; M ), the

action that follows a given p ercept is not necessarily the agent's \resp onse" to that p ercept;

b ecause of the delay incurred by delib eration, it may only reflect p ercepts - ccurring much

earlier in the sequence. Furthermore, it is not p ossible to map every agent function to an

implementation l LM

. We can define a subset of the set of agent functions f that are

implementable on a given architecture M and language LM

:

F easibl e(M ) = ff j l L

; f = Ag ent(l ; M )g

M

Feasibility is related to, but clearly distinct from, the notion of computability. Computabil

ity refers to the existence of a program that eventual ly returns the output sp eci�ed by

a function, whereas feasibility refers to the pro duction of the output at the appropriate

p oint in time. The set of feasible agent functions is therefore much smaller than the set of

computable agent functions.

Provably bounded-optimal agents

. Performance measures for agents

To evaluate an agent's p erformance in the world, we define a real-valued utility function U

on state histories:

T

U : X

! <

The utility function should b e seen as external to the agent and its environment. It defines

the problem to b e solved by the designer of the agent. Some agent designs may incorp orate

an explicit representation of the utility function, but this is by no means required. We will

use the term task environment to denote the combination of an environment and a utility

function.

Recall that the agent's actions drive the environment E through a particular sequence

of states in accordance with the function effects(f ; E ). We can define the value of an agent

function f in the environment E as the utility of the state history it generates:

V (f ; E ) = U (effects(f ; E ))

If the designer has a set E of environments with a probability distribution p over them,

instead of a single environment E, then the value of the agent in E is defined as the

exp ected value over the elements of E. By a slight abuse of notation,

X

V (f ; E) =

p(E )V (f ; E )

E E

We can assign a value V (l ; M ; E ) to a program l executed by the architecture M in the

environment E simply by lo oking at the effect of the agent function implemented by the

program:

V (l ; M ; E ) = V (Ag ent(l ; M ); E ) = U (effects(Ag ent(l ; M ); E ))

As ab ove, we can extend this to a set of p ossible environments as follows:

X

V (l ; M ; E) =

p(E )V (l ; M ; E )

E E

. Perfect rationality and b ounded optimality

As discussed in Section , a p erfectly rational agent selects the action that maximizes its

exp ected utility, given the p ercepts so far. In our framework, this amounts to an agent

function that maximizes V (f ; E) over all p ossible agent functions.

Definition A perfectly rational agent for a set E of environments has an agent function

fopt

such that

fopt

= argmax

(V (f ; E))

f

This definition is a p ersuasive sp eci�cation of an optimal agent function for a given

set of environments, and underlies several recent pro jects in intelligent agent design (Dean

& Wellman, ; Doyle,  ; Hansson & Mayer,   ). A direct implementation of this

sp eci�cation, which ignores the delay incurred by delib eration, do es not yield a reasonable

Russell & Subramanian

solution to our problem { the calculation of exp ected utilities takes time for any real agent.

In terms of our simple formal description of agents intro duced ab ove, it is easy to see where

the difficulty has arisen. In designing the agent program, logicists and decision theorists

have concentrated on sp ecifying an optimal agent function f

in order to guarantee the

selection of the b est action history. The function fopt

opt

is indep endent of the architecture M .

Unfortunately, no real program in L

implements this function in a non-trivial environment,

M

b ecause optimal actions cannot usually b e computed b efore the next p ercept arrives. That

is, quite frequently, f

F easibl e(M ).

opt

Supp ose the environment consists of games of chess under tournament rules against some

p opulation of human grandmasters, and supp ose M is some standard p ersonal computer.

Then fopt

describ es an agent that always plays in such a way as to maximize its total

exp ected p oints against the opp osition, where the maximization is over the moves it makes.

We claim that no p ossible program can play this way. It is quite p ossible, using depth-first

alpha-b eta search to termination, to execute the program that cho oses (say) the optimal

minimax move in each situation, but the agent function induced by this program is not the

same as fopt

. In particular, it ignores such p ercepts as the dropping of its flag indicating a

loss on time.

The trouble with the p erfect rationality definition arose b ecause of unconstrained op

timization over the space of f 's in the determination of fopt

, without regard to feasibility.

(Similarly, metalevel rationality assumes unconstrained optimization over the space of de

lib erations.) To escap e this quandary, we prop ose a machine-dep endent standard of ratio

nality, in which we maximize V over the implementable set of agent functions F easibl e(M ).

That is, we imp ose optimality constraints on programs rather than on agent functions or

deliberations.

Definition A bounded-optimal agent with architecture M for a set E of environments

has an agent program l

such that

lopt

opt

= argmaxl LM V (l ; M ; E)

We can see immediately that this sp eci�cation avoids the most obvious problems with

Typ e I and Typ e I I rationality. Consider our chess example, and supp ose the computer has

a total program memory of megabytes. Then there are

p ossible programs that can

b e represented in the machine, of which a much smaller numb er play legal chess. Under

tournament conditions, one or more of these programs will have the b est exp ected p erfor

mance. Each is a suitable candidate for lopt

. Thus b ounded optimality is, by definition, a

feasible sp eci�cation; moreover, a program that achieves it is highly desirable. We are not

yet ready to announce the identity of lopt

b egin with a more restricted problem.

for chess on an eight-megabyte PC, so we will

. Provably Bounded-Optimal Agents

In order to construct a provably b ounded optimal agent, we must carry out the following

steps:

  - Sp ecify the prop erties of the environment in which actions will b e taken, and the

utility function on the b ehaviours.

Provably bounded-optimal agents

  - Sp ecify a class of machines on which programs are to b e run.

  - Prop ose a construction metho d.

  - Prove that the construction metho d succeeds in building b ounded optimal agents.

The metho dology is similar to the formal analysis used in the field of optimal control, which

studies the design of control lers (agents) for plants (environments). In optimal control

theory, a controller is viewed as an essentially instantaneous implementation of an optimal

agent function. In contrast, we fo cus on the computation time required by the agent, and

the relation b etween computation time and the dynamics of the environment.

. Episo dic, real-time task environments

In this section, we will consider a restricted class of task environments which we call episodic

environments. In an episo dic task environment, the state history generated by the actions of

the agent can b e considered as divided into a series of episodes, each of which is terminated

by an action. Let A?

- A b e a distinguished set of actions that terminate an episo de.

The utility of the complete history is given by the sum of the utilities of each episo de,

which is determined in turn by the state sequence. After each A A?

, the environment

\resets" to a state chosen at random from a stationary probability distribution P

. In

init

order to include the effects of the choice of A in the utility of the episo de, we notionally

divide the environment state into a \configuration" part and a \value" part, such that

the configuration part determines the state transitions while the value part determines the

utility of a state sequence. Actions in A?

reset the configuration part, while their \value"

is recorded in the value part. These restrictions mean that each episo de can b e treated as

a separate decision problem, and translate into the following prop erty: if agent program l

has higher exp ected utility on individual episo des than agent l

utility in the corresp onding episo dic task environment.

, it will have higher exp ected

A real-time task environment is one in which the utility of an action dep ends on the

time at which it is executed. Usually, this dep endence will b e sufficiently strong to make

calculative rationality an unacceptably bad approximation to p erfect rationality.

An automated mail sorter

provides an illustrative example of an episo dic task environ

ment (see Figure ). Such a machine scans handwritten or printed addresses (zip co des) on

mail pieces and dispatches them to appropriate bins. Each episo de starts with the arrival of

a new mail piece and terminates with the execution of the physical action recommended by

the sorter: routing of the piece to a sp eci�c bin. The \configuration part" of the environ

ment corresp onds to the letter feeder side, which provides a new, randomly selected letter

after the previous letter is sorted. The \value part" of the state corresp onds to the state of

the receiving bins, which determines the utility of the pro cess. The aim is to maximize the

accuracy of sorting while minimizing the reject p ercentage and avoiding jams. A jam - ccurs

if the current piece is not routed to the appropriate bin, or rejected, b efore the arrival of

the next piece.

We now provide formal definitions for three varieties of real-time task environments:

fixed deadlines, fixed time cost and sto chastic deadlines.

. See (Sackinger et al.  ; Boser et al.  ) for details of an actual system. The application was

suggested to us by Bernhard Boser after an early presentation of our work at the NEC Symp osium.

Russell & Subramanian

**camera**

**reject**

**zipcode**
**buckets**

Figure : An automated mail-sorting facility provides a simple example of an episo dic,

real-time task environment.

.. Fixed deadlines

The simplest and most commonly studied kind of real-time task environment contains a

deadline at a known time. In most work on real-time systems, such deadlines are describ ed

informally and systems are built to meet the deadline. Here, we need a formal sp eci�cation

in order to connect the description of the deadline to the prop erties of agents running in

deadline task environments. One might think that deadlines are part of the environment

description, but in fact they are mainly realized as constraints on the utility function. One

can see this by considering the opp osite of a deadline | the \starter's pistol." The two

are distinguished by differing constraints on the utilities of acting b efore or after a sp eci�c

time.

Definition Fixed dead line: The task environment hE ; U i has a fixed dead line at time td

if the fol lowing conditions hold.

- Taking an action in A?

t

at any time before the dead line results in the same utility:

(td

fi)

T

- A

(t)])

U ([E ; A

]) = U ([E ; A

fi)

(t

and A

d

(t�)

, and A

where \fi" denotes sequence concatenation, t - td

T

, A (t) A?

td

contain no action in A?

.

- Actions taken after td

t

have no effect on utility:

t td

U ([E ; A

]) - U ([E ; A

]) if U ([E ; A

]) - U ([E ; A

]) and t - t

d

.. Fixed time cost

Task environments with approximately fixed time cost are also very common. Examples

include consultations with lawyers, keeping a taxi waiting, or dithering over where to invest

one's money. We can define a task environment with fixed time cost c by comparing the

utilities of actions taken at different times.

Provably bounded-optimal agents

Definition Fixed time cost: The task environment hE ; U i has a fixed time cost if, for

satisfying

T

t

t

and A

T

any action history prefixes A

T

() A

(

() A

(t

) A?

and A

(t

) = A

(t

)

(t

fi) (t

and A

fi)

contain no action in A?

the utilities differ by the difference in time cost:

t

U ([E ; A

t

]) = U ([E ; A

]) - c(t

- t

)

Strictly sp eaking, there are no task environments with fixed time cost. Utility values have a

finite range, so one cannot continue incurring time costs indefinitely. For reasonably short

times and reasonably small costs, a linear utility p enalty is a useful approximation.

.. Stochastic deadlines

While fixed-deadline and fixed-cost task environments - ccur frequently in the design of

real-time systems, uncertainty ab out the time-dep endence of the utility function is more

common. It also turns out to b e more interesting, as we see b elow.

A sto chastic deadline is represented by uncertainty concerning the time of  - ccurrence of

a fixed deadline. In other words, the agent has a probability distribution p

P

for the deadline

d

(t) = . We

time t

. We assume that the deadline must come eventually, so that

p

d

also define the cumulative deadline distribution Pd

d

t T

.

If the deadline do es not   - ccur at a known time, then we need to distinguish b etween

two cases:

  - The agent receives a p ercept, called a herald (Dean & Bo ddy,  ), which announces

an imp ending deadline. We mo del this using a distinguished p ercept O

T

:

d

O

(td

) = Od

If the agent resp onds immediately, then it \meets the deadline."

- No such p ercept is available, in which case the agent is walking blindfolded towards

the utility cliff. By delib erating further, the agent risks missing the deadline but may

improve its decision quality. An example familiar to most readers is that of deciding

whether to publish a pap er in its current form, or to emb ellish it further and risk

b eing \sco op ed." We do not treat this case in the current pap er.

Formally, the sto chastic deadline case is similar to the fixed deadline case, except that t

t

is

d

drawn from the distribution pd . The utility of executing an action history prefix A

in E is

the exp ectation of the utilities of that state history prefix over the p ossible deadline times.

Definition Stochastic dead line: A task environment class hE; U i of fixed-dead line task

environments has a stochastic dead line distributed according to pd

t

if, for any action history

0

prefix A

,

t

U ([E; A ]) =

0

X

0

t0

; A

t

p

(t

0

)U ([E

])

d

t

T

where hEt

; U i is a task environment in hE; U i with a fixed dead line at t

.

Russell & Subramanian

The mail sorter example is well describ ed by a sto chastic deadline. The time b etween

the arrival of mail pieces at the image pro cessing station is distributed according to a density

function pd, which will usually b e Poisson.

. Agent programs and agent architecture

We consider simple agent programs for episo dic task environments, constructed from ele

ments of a set R = fr

; : : : ; rn

g of decision pro cedures or rules. Each decision pro cedure

recommends (but do es not execute) an action Ai

A?

, and an agent program is a fixed

sequence of decision pro cedures. For our purp oses, a decision pro cedure is a black b ox with

two parameters:

- a run time t

- 0, which is an integer that represents the time taken by the pro cedure

i

to compute an action.

- a quality qi

- 0, which is a real numb er. This gives the exp ected reward resulting

from executing its action Ai

at the start of an episo de:

qi

= U ([E ; Ai ]) ()

Let M

Let t

denote an agent architecture that executes decision pro cedures in the language J .

J

denote the maximum runtime of the decision pro cedures that can b e accommo dated

M

in M . For example, if the runtime of a feedforward neural network is prop ortional to its

size, then t

will b e the runtime of the largest neural network that fits in M .

M

The architecture M executes an agent program s = s

: : : sm

by running each decision

pro cedure in turn, providing the same input to each as obtained from the initial p ercept.

When a deadline arrives (at a fixed time td

, or heralded by the p ercept O

d

), or when

the entire sequence has b een completed, the agent selects the action recommended by the

highest-quality pro cedure it has executed:

T

T

M (s; I

M (s; I

(td

T

(t

); O

); O

(t

T

(ts

)) = hi

)) = hi

T

T

T

(t

(t

s

(t))i

d ))i

))i where t

=

0

; action(I

; action(I

; action(I

d

s

P

s

ti

s

M (s; I

T

(t); Od

s

()

(t)) is the

0

) = hi0

T

i

T

(t) such that action(I

where M up dates the agent's internal state history I

action recommended by a completed decision pro cedure with the highest quality. When

this action is executed, the internal state of the agent is re-initialized to i

. This agent

0

design works in all three of the task environment categories describ ed ab ove.

Next we derive the value V (s; M ; E ) of an agent program s in environment E running

on M for the three real-time regimes and show how to construct b ounded optimal agents

for these task environments.

. Bounded optimality with fixed deadlines

From Equation , we know that the agent picks the action in A

recommended by the

?

decision pro cedure r with the highest quality that is executed b efore the deadline td

arrives.

- td

. From Definition

()

Let s

: : : sj

Provably bounded-optimal agents

Pj

b e the longest prefix of the program s such that

i=

ti

and Equation , it follows that

V (s; M ; E ) = Qj

where Qi

= maxfq

; : : : ; qi g. Given this expression for the value of the agent program, we

can easily show the following:

Theorem Let r - = arg maxri

R;ti fitd

qi . The singleton sequence r - is a bounded optimal

program for M in an episodic task environment with a known dead line td

.

That is, the b est program is the single decision pro cedure of maximum quality whose runtime

is less than the deadline.

. Bounded optimality with fixed time cost

From Equation , we know that the agent picks the action in A?

recommended by the b est

decision pro cedure in the sequence, since M runs the entire sequence s = s

there is no deadline. From Definition and Equation , we have

Xm

: : : sm

when

()

V (s; M ; E ) = Qm - c

ti

i=

Given this expression for the value of the agent program, we can easily show the following:

Theorem Let r - = arg maxr

R

- cti . The singleton sequence r - is a bounded optimal

qi

i

program for M in an episodic task environment with a fixed time cost c.

That is, the optimal program is the single decision pro cedure whose quality, net of time

cost, is highest.

. Bounded optimality with sto chastic deadlines

With a sto chastic deadline distributed according to p

, the value of an agent pro

gram s = s

P

: : : sm

d

is an exp ectation. From Definition, we can calculate this as

pd

(t)V (s; M ; Et

), where hEt ;

; U i is a task environment with a fixed deadline at t. Af

t T

ter substituting for V (s; M ; Et

) from Equation , this expression simpli�es to a summation,

th

over the pro cedures in the sequence, of the probability of interruption after the i

pro cedure

in the sequence multiplied by the quality of the b est completed decision pro cedure:

m

X

P

i+

(

j =

t

P

i

( j =

P

m

t

V (s) - V (s; M ; E) =

R

t 0 0

[Pd

j )]Qi

ti .

j

) - Pd

(t) = for t 

0

where Pd (t) =

d

p

(t

)dt

i=

0

and P

d

fi i=

A simple example serves to illustrate the value function. Consider R = fr

; r

; r

()

g. The

rule r

has a quality of 0. and needs seconds to run: we will represent this by r

= (0: ; ).

The other rules are r

= (0: ; ); r

= (0: ; ). The deadline distribution function p

is a

d

uniform distribution over 0 to 0 seconds. The value of the sequence r

r

r

is

V (r

r

r

) = [: - :]: + [ - :]: + [ - ]: = :

A geometric intuition is given by the notion of a performance profile, as shown in Fig

ure .

_q_

Russell & Subramanian

_2_ _5_ _7_

_0.7_

_0.5_

_0.2_

Figure : Performance profile for r

r

r

, with p

sup erimp osed.

d

Definition 0 Performance profile: For a sequence s, the performance profile Q

the quality of the action returned if the agent is interrupted at t:

i

X

(t) gives

s

Qs

(t) = maxfqi

:

tj

- tg

j =

For a uniform deadline density function, the value of a sequence is prop ortional to the

area under the p erformance profile up to the last p ossible interrupt time. Note that the

height of the profile during the interval of length ti

the b est of the previous rules.

while rule i is running is the quality of

From Definition 0, we have the following obvious prop erty:

Lemma The performance profile of any sequence is monotonical ly nondecreasing.

It is also the case that a sequence with higher quality decisions at all times is a b etter

sequence:

) - V (s

).

(t), then V (s

Lemma If t Q

(t) - Q

.

s

In this case we say that Qs

s

dominates Q

s

We can use the idea of p erformance profiles to establish some useful prop erties of optimal

sequences.

Lemma There exists an optimal sequence that is sorted in increasing order of q 's.

P

n

Without Lemma , there are

n

i! p ossible sequences to consider. The ordering con

i=

straint eliminates all but

sequences. It also means that in pro ofs of prop erties of se

quences, we now need consider only ordered sequences. In addition, we can replace Qi

in

Equation by qi

.

The following lemma establishes that a sequence can always b e improved by the addition

of a b etter rule at the end:

Lemma For every sequence s = s

step z with qz

- q

sm

, V (sz ) - V (s).

: : : sm sorted in increasing order of quality, and single

 0

Provably bounded-optimal agents

Corollary There exists an optimal sequence ending with the highest-quality rule in R .

The following lemma reflects the obvious intuition that if one can get a b etter result in

less time, there's no p oint sp ending more time to get a worse result:

Lemma There exists an optimal sequence whose rules are in nondecreasing order of t

.

i

We now apply these preparatory results to derive algorithms that construct b ounded

optimal programs for various deadline distributions.

.. General distributions

For a general deadline distribution, the dynamic programming metho d can b e used to obtain

an optimal sequence of decision rules in pseudo-p olynomial time. We construct an optimal

sequence by using the definition of V (s; M ; E ) in Equation . Optimal sequences generated

by the metho ds are ordered by qi

, in accordance with Lemma .

We construct the table S (i; t), where each entry in the table is the highest value of

any sequence that ends with rule ri

at time t. We assume the rule indices are arranged in

P

.

increasing order of quality, and t ranges from the start time 0 to the end time L =

The up date rule is:

ti

ri

R

S (i; t) = maxk [0::: i�]

with b oundary condition

[S (k ; t - ti

) + (qi

- q

(t)]]

k

)[ - Pd

S (i; 0) = 0 for each rule i and S (0; t) = 0 for each time t

From Corollary , we can read off the b est sequence from the highest value in row n of the

matrix S .

Theorem The DP algorithm computes an optimal sequence in time O (n

the number of decision procedures in R.

L) where n is

The dep endence on L in the time complexity of the DP algorithm means that the algo

rithm is not p olynomial in the input size. Using standard rounding and scaling metho ds,

however, a fully p olynomial approximation scheme can b e constructed. Although we do not

have a hardness pro of for the problem, John Binder ( ) has shown that if the deadline

distribution is used as a constant-time oracle for finding values of P (t), any algorithm will

require an exp onential numb er of calls to the oracle in the worst case.

.. Long uniform distributions

If the deadline is uniformly distributed over a time interval greater than the sum of the

running times of the rules, we will call the distribution a long uniform distribution. Consider

the rule sequence s = s

: : : sm

drawn from the rule set R. With a long uniform distribution,

the probability that the deadline arrives during rule si

of the sequence s is indep endent of

the time at which s

V (s; M ; E) =

starts. This p ermits a simpler form of Equation :

m�

i=

Pd

i

P

(ti+

)qi

+ q

m

( 

P

m

i=

Pd

(t

)) ()

i

Russell & Subramanian

To derive an optimal sequence under a long uniform distribution, we obtain a recursive

sp eci�cation of the value of a sequence as with a R and s = s

in R.

: : : sm

b eing some sequence

V (as; M ; E) = V (s; M ; E) + qa Pd

(t

) - qm

Pd

(t

a

) ()

This allows us to define a dynamic programming scheme for calculating an optimal sequence

using a state function S (i; j ) denoting the highest value of a rule sequence that starts with

rule i and ends in rule j . From Lemma and Equation , the up date rule is:

S (i; j ) = maxi<k �j

with b oundary condition

[S (k ; j ) + Pd

(t

k

- P

d

)q

j

] ()

( )

)qi

(ti

S (i; i) = ( - Pd

(ti

))qi

From Corollary , we know that an optimal sequence for the long uniform distribution ends

in r

, the rule with the highest quality in R. Thus, we only need to examine S (i; n); 

n

i - n. Each entry requires O (n) computation, and there are n entries to compute. Thus,

the optimal sequence for the long uniform case can b e calculated in O (n

).

Theorem An optimal sequence of decision procedures for a long uniform dead line dis

tribution can be determined in O (n

R.

) time where n is the number of decision procedures in

.. Short uniform distributions

P

n

When

P

(ti

) - , for a uniform deadline distribution Pd

, we call it short. This means

d

i=

that some sequences are longer than the last p ossible deadline time, and therefore some rules

in those sequences have no p ossibility of executing b efore the deadline. For such sequences,

we cannot use Equation to calculate V (s). However, any such sequence can b e truncated

by removing all rules that would complete execution after the last p ossible deadline. The

value of the sequence is unaffected by truncation, and for truncated sequences the use of

Equation is justi�ed. Furthermore, there is an optimal sequence that is a truncated

sequence.

Since the up date rule correctly computes S (i; j ) for truncated sequences, we can use

it with short uniform distributions provided we add a check to ensure that the sequences

considered are truncated. Unlike the long uniform case, however, the identity of the last rule

in an optimal sequence is unknown, so we need to compute all n

entries in the S (i; j ) table.

Each entry computation takes O (n) time, thus the time to compute an optimal sequence is

O (n

).

Theorem An optimal sequence of decision procedures for a short uniform dead line dis

tribution can be determined in O (n

R.

) time where n is the number of decision procedures in

Provably bounded-optimal agents

.. Exponential distributions

�� t

For an exp onential distribution, P

(t) = - e

. Exp onential distributions allow an optimal

d

sequence to b e computed in p olynomial time. Let pi

stand for the probability that rule i

�� ti

is interrupted, assuming it starts at 0. Then pi

distribution, V (s; M ; E) simpli�es out as:

m�

(ti

( - p

) = - e

i

: For the exp onential

= Pd

m

d

h

p

i

h

j =

i

)

q

+

)

qm

V (s; M ; E) =

X

i=

i

�j =

( - p

j

i+

i

j

This yields a simple recursive sp eci�cation of the value V (as; M ; E) of a sequence that

b egins with the rule a:

V (as; M ; E) = ( - pa

)p

qa

+ ( - pa

)V (s; M ; E)

We will use the state function S (i; j ) which represents the highest value of any rule sequence

starting with i and ending in j .

S (i; j ) = max

[( - pi

)p

qi

+ ( - pi )S (k ; j )]

i<k �j

k

with b oundary condition S (i; i) = qi

( - pi

). For any given j, S (i; j ) can b e calculated in

O (n

). From Corollary , we know that there is an optimal sequence whose last element is

the highest-valued rule in R.

Theorem An optimal sequence of decision procedures for an exponential ly distributed

stochastic dead line can be determined in O (n

procedures in R.

) time where n is the number of decision

The pro of is similar to the long uniform distribution case.

. Simulation results for a mail-sorter

The preceding results provide a set of algorithms for optimizing the construction of an agent

program for a variety of general task environment classes. In this section, we illustrate these

results and the p ossible gains that can b e realized in a sp eci�c task environment, namely,

a simulated mail-sorter.

First, let us b e more precise ab out the utility function U on episo des. There are four

p ossible outcomes; the utility of outcome i is ui

.

. The zip co de is successfully read and the letter is sent to the correct bin for delivery.

. The zip co de is misread and the letter go es to the wrong bin.

. The letter is sent to the reject bin.

. The next letter arrives b efore the recognizer has finished, and there is a jam. Since

letter arrival is heralded, jams cannot  - ccur with the machine architecture given in

Equation .

Russell & Subramanian

1

0.8

0.6

0.4

0.2

0

0 2 4 6 8 10

Computation Time (sec)

��x

0 2 4 6 8 10

Time (sec)

1

0.8

0.6

0.4

0.2

0

Figure : (a) Accuracy profile ( - e

mean     - = sec

Without loss of generality, we set u

), for - = 0: . (b) Poisson arrival distribution, for

= :0 and u

= 0:0. If the probability of a rule

recommending a correct destination bin is pi

, then q

i

= p

u

+ ( - pi

)u

= pi

. We assume

i

that u

- u

, hence there is a threshold probability b elow which the letter should b e sent

to the reject bin instead. We will therefore include in the rule set R a rule rr ej ect

that

has zero runtime and recommends rejection. The sequence construction algorithm will then

automatically exclude rules with quality lower than q

= u

. The overall utility for an

r ej ect

episo de is chosen to b e a linear combination of the quality of sorting (qi

), the probability of

rejection or the rejection rate (given by P (t

), where t

is the runtime of the first non-reject

rule executed), and the sp eed of sorting (measured by the arrival time mean).

The agent program in (Boser et al.  ) uses a single neural network on a chip.

We show that under a variety of conditions an optimized sequence of networks can do

significantly b etter than any single network in terms of throughput or accuracy. We examine

the following exp erimental conditions:

  - We assume that a network that executes in time t has a recognition accuracy p that

��t

dep ends on t. We consider p = - e

. The particular choice of - is irrelevant b ecause

the scale chosen for t is arbitrary. We cho ose - = 0:, for convenience (Figure (a)).

We include rr ej ect

with q

r ej ect

= u

and t

= 0.

r ej ect

- We consider arrival time distributions that are Poisson with varying means. Fig

ure (b) shows three example distributions, for means , , and seconds.

- We create optimized sequences from sets of 0 networks with execution times taken

at equal intervals from t = to 0.

- We compare

(a) BO sequence: a b ounded optimal sequence;

(b) Best singleton: the b est single rule;

(c) 0% rule: the rule whose execution time is the mean of the distribution (i.e., it

will complete in 0% of cases);

Provably bounded-optimal agents

1

0.8

0.6

0.4

0.2

0

Mean arrival time

Figure : Graph showing the achievable utility p er second as a function of the average time

p er letter, for the four program typ es.     - = 0: .

(d) 0% rule: the rule whose execution time guarantees that it will complete in 0%

of cases.

In the last three cases, we add rr ej ect

it automatically.

as an initial step; the BO sequence will include

- We measure the utility p er second as a function of the mean arrival rate (Figure ).

This shows that there is an optimal setting of the sorting machinery at letters p er

minute (inter-arrival time = 0 seconds) for the b ounded optimal program, given that

we have fixed  - at 0. .

- Finally, we investigate the effect of the variance of the arrival time on the relative

p erformance of the four program typ es. For this purp ose, we use a uniform distribution

centered around 0 seconds but with different widths to vary the variance without

affecting the mean (Figure ).

We notice several interesting things ab out these results:

- The p olicy of cho osing a rule with a 0% probability of completion p erforms p - orly

for rapid arrival rates (fi  - ), but catches up with the p erformance of the b est single

rule for slower arrival rates (fi  - ). This is an artifact of the exp onential accuracy

profile for any  -  - 0:, where the difference in quality of the rules with run times

greater than seconds is quite small.

- The p olicy of cho osing a rule with a 0% probability of completion fares as well as

the b est single rule for very high arrival rates (fi  - ), but rapidly diverges from it

thereafter, p erforming far worse for arrival time means greater than seconds.

Russell & Subramanian

1

0.8

0.6

0.4

0.2

0

0 20 40 60 80 100 120

Variance in arrival time

Figure : Graphs showing the utility gain p er second as a function of the arrival time

variance, for the four program typ es for the uniform distribution with a mean of

0 seconds.

  - Both the b est sequence and the b est single rule give their b est overall p erformance

at an arrival rate of around letters p er minute. The p erformance advantage of the

optimal sequence over the b est single rule is ab out % at this arrival rate. It should

b e noted that this is a significant p erformance advantage that is obtainable with no

extra computational resources. For slower arrival rates (fi    - ), the difference b etween

the p erformance of the b est rule and the b est sequence arises from the decreased

rejection rate of the b est sequence. With the exp onential accuracy profile (fi    - 0:)

the advantage of running a rule with a shorter completion time ahead of a longer rule

is the ability to reduce the probability of rejecting a letter. For high arrival rates

(inter-arrival times of to seconds), it is useful to have a few short rules instead of

a longer single rule.

  - Figure shows that the b est sequence p erforms b etter than the b est single rule as the

variance of the arrival time increases.

The p erformance of the optimal sequence also

app ears to b e largely unaffected by variance. This is exactly the b ehaviour we exp ect

to observe | the ability to run a sequence of rules instead of committing to a single

one gives it robustness in the face of increasing variance. Since realistic environments

can involve unexp ected demands of many kinds, the p ossession of a variety of default

b ehaviours of graded sophistication would seem to b e an optimal design choice for a

b ounded agent.

. The p erformance of the 0% rule is fiat b ecause the uniform distributions used in this exp eriment have

fixed mean and are symmetric, so that the 0% rule is always the rule that runs for 0 seconds. The

0% rule changes with the variance, and the curve exhibits some discretization effects. These could b e

eliminated using a finer-grained set of rules.

Provably bounded-optimal agents

. Learning Approximately Bounded-Optimal Programs

The ab ove derivations assume that a suitable rule set R is available ab initio, with correct

qualities qi

and runtimes ti

, and that the deadline distribution is known. In this section, we

study ways in which some of this information can b e learned, and the implications of this

for the b ounded optimality of the resulting system. We will concentrate on learning rules

and their qualities, leaving runtimes and deadline distributions for future work.

The basic idea is that the learning algorithms will converge, over time, to a set of

optimal comp onents | the most accurate rules and the most accurate quality estimates for

them. As this happ ens, the value of the agent constructed from the rules, using the quality

estimates, converges to the value of lopt

learned agent:

. Thus there are two sources of sub optimality in the

  - The rules in R may not b e the b est p ossible rules | they may recommend actions

that are of lower utility than those that would b e recommended by some other rules.

  - There may b e errors in estimating the exp ected utility of the rule. This can cause the

algorithms given ab ove to construct sub optimal sequences, even if the b est rules are

available.

Our notional metho d for constructing b ounded optimal agents () learns sets of indi

vidual decision pro cedures from episo dic interactions, and () arranges them in a sequence

using one of the algorithms describ ed earlier so that the p erformance of an agent using

the sequence is at least as go - d as that of any other such agent. We assume a parameter

ized learning algorithm L

that will b e used to learn one rule for each p ossible runtime

k f ; : : : ; tM

J ;k

g. Since there is never a need to include two rules with the same runtime

in the R, this obviates the need to consider the entire rule language J in the optimization

pro cess.

Our setting places somewhat unusual requirements on the learning algorithm. Like

most learning algorithms, LJ ;k

works by observing a collection T of training episo des in E,

including the utility obtained for each episo de. We do not, however, make any assumptions

ab out the form of the correct decision rule. Instead, we make assumptions ab out the

hyp otheses, namely that they come from some finite language J

, the set of programs

k

in J of complexity at most k . This setting has b een called the agnostic learning setting by

Kearns, Schapire and Sellie ( ), b ecause no assumptions are made ab out the environment

at all. It has b een shown (Theorems and in Kearns, Schapire and Sellie,  ) that, for

some languages J, the error in the learned approximation can b e b ounded to within - of

the b est rule in J

that fits the examples, with probability - - . The sample size needed

k

to guarantee these b ounds is p olynomial in the complexity parameter k, as well as

and

.

In addition to constructing the decision pro cedures, LJ ;k

outputs estimates of their

quality q

. Standard Cherno�-Ho e�ding b ounds can b e used to limit the error in the quality

i

estimate to b e within �q

is also p olynomial in

�q

�q

with probability - �q

. The sample size for the estimation of quality

and

.

Thus the error in each agnostically learned rule is b ounded to within  - of the b est rule

in its complexity class with probability - - . The error in the quality estimation of these

rules is b ounded by �q

with probability - 

q . From these b ounds, we can calculate a b ound

on the utility deficit in the agent program that we construct, in comparison to lopt :

Russell & Subramanian

Theorem Assume an architecture MJ

that executes sequences of decision procedures in

an agnostical ly learnable language J whose runtimes range over [::t

]. For real time task

M

environments with fixed time cost, fixed dead line, and stochastic dead line, we can construct

a program l such that

V (l

; M ; E) - V (l ; M ; E) - - + �q

opt

with probability greater than - m(fi + 

), where m is the number of decision procedures in

q

lopt

.

Pro of: We prove this theorem for the sto chastic deadline regime, where the b ounded

optimal program is a sequence of decision pro cedures. The pro ofs for the fixed cost and

fixed deadline regimes, where the b ounded optimal program is a singleton, follow as a

                                     

sp ecial case. Let the b est decision pro cedures for E b e the set R

                                    

= fr

; : : : ; rn

g, and

 

let lopt

= s

: : : sm

b e an optimal sequence constructed from R

. Let R = fr

; : : : rn

g b e

the set of decision pro cedures returned by the learning algorithm. With probability greater

        

than - m�, q

- q

- - for all i, where q

. The error in the

i

i

refers to the true quality of ri

i

estimated quality q^i

of decision pro cedure ri

is also b ounded: with probability greater than

- m�q

, jq^i

- q

j - 

for all i.

Let s = s

   

i q

: : : sm b e those rules in R that come from the same runtime classes as the

- 

rules s

: : : sm

in R

. Then, by Equation , we have

V (l

; M ; E) - V (s; M ; E) - 

opt

b ecause the error in V is a weighted average of the errors in the individual qi . Similarly, we

have

jV^ (s; M ; E)     - V (s; M ; E)j     - �q

Now supp ose that the sequence construction algorithm applied to R pro duces a sequence

0

0

: : : sl . By definition, this sequence appears to b e optimal according to the estimated

^

l = s

value function V . Hence

^ ^

V (l ; M ; E) 

V (s; M ; E)

As b efore, we can b ound the error on the estimated value:

jV^ (l ; M ; E)     - V (l ; M ; E)j     - �q

Combining the ab ove inequalities, we have

V (l

; M ; E) - V (l ; M ; E) - - + �q

opt

Although the theorem has practical applications, it is mainly intended as an illustration

of how a learning pro cedure can converge on a b ounded optimal configuration. With some

additional work, more general error b ounds can b e derived for the case in which the rule

execution times ti

and the real-time utility variation (time cost, fixed deadline, or deadline

distribution) are all estimated from the training episo des. We can also obtain error b ounds

for the case in which the rule language J is divided up into a smaller numb er of coarser

runtime classes, rather than the p otentially huge numb er that we currently use.

Provably bounded-optimal agents

. Asymptotic Bounded Optimality

The strict notion of b ounded optimality may b e a useful philosophical landmark from which

to explore artificial intelligence, but it may b e to - strong to allow many interesting, general

results to b e obtained. The same observation can b e made in ordinary complexity theory:

although absolute efficiency is the aim, asymptotic efficiency is the game. That a sorting

algorithm is O (n log n) rather than O (n

) is considered significant, but replacing a \multiply

by " by a \shift-left bit" is not considered a real advance. The slack allowed by the

definitions of complexity classes is essential in building on earlier results, in obtaining robust

results that are not restricted to sp eci�c implementations, and in analysing the complexity of

algorithms that use other algorithms as subroutines. In this section, we b egin by reviewing

classical complexity. We then prop ose definitions of asymptotic b ounded optimality that

have some of the same advantages, and show that classical optimality is a sp ecial case of

asymptotic b ounded optimality. Lastly, we rep ort on some preliminary investigations into

the use of asymptotic b ounded optimality as a theoretical to ol in constructing universal

real-time systems.

. Classical complexity

A problem, in the classical sense, is defined by a pair of predicates - and such that output

z is a solution for input x if and only if fi(x) and (x; z ) hold. A problem instance is an

input satisfying fi, and an algorithm for the problem class always terminates with an output

z satisfying (x; z ) given an input x satisfying fi(x). Asymptotic complexity describ es the

growth rate of the worst-case runtime of an algorithm as a function of the input size. We

can define this formally as follows. Let Ta

     

(x) b e the runtime of algorithm a on input x,

and let T

(n) b e the maximum runtime of a on any input of size n. Then algorithm a has

a

complexity O (f (n)) if

k ; n0

n n - n0

   

) Ta

(n) - k f (n)

Intuitively, a classically optimal algorithm is one that has the lowest p ossible complexity.

For the purp oses of constructing an asymptotic notion of b ounded optimality, it will b e

useful to have a definition of classical optimality that do es not mention the complexity

directly. This can b e done as follows:

Definition Classical ly optimal algorithm: An algorithm a is classical ly optimal if and

only if

     

(n) - k Ta0

(n)

k ; n0

0

a ; n n - n

0

   

) Ta

To relate classical complexity to our framework, we will need to define the sp ecial case of task

environments in which traditional programs are appropriate. In such task environments,

an input is provided to the program as the initial p ercept, and the utility function on

environment histories ob eys the following constraint:

Definition Classical task environment: hE

problem P if

(

; U i is a classical task environment for

P

u(T (l ; M ; EP

)) if l outputs a correct solution for P

V (l ; M ; EP

) =

0 otherwise

Russell & Subramanian

where T (l ; M ; EP

) is the running time for l in EP

on M, M is a universal Turing machine,

and u is some positive decreasing function.

The notion of a problem class in classical complexity theory thus corresp onds to a class of

classical task environments of unb ounded complexity. For example, the Traveling Salesp er

son Problem contains instances with arbitrarily large numb ers of cities.

. Varieties of asymptotic b ounded optimality

The first thing we will need is a complexity measure on environments. Let n(E ) b e a suitable

measure of the complexity of an environment. We will assume the existence of environment

classes that are of unb ounded complexity. Then, by analogy with the definition of classical

optimality, we can define a worst-case notion of asymptotic b ounded optimality (ABO).

      

Letting V

we have

(l ; M ; n; E) b e the minimum value of V (l ; M ; E ) for all E in E of complexity n,

Definition Worst-case asymptotic bounded optimality: an agent program l is timewise

(or spacewise) worst-case asymptotical ly bounded optimal in E on M i�

) V

0

(l ; M ; n; E)

k ; n0

0

l ; n n  - n

0

(l ; k M ; n; E) - V

where k M denotes a version of the machine M speeded up by a factor k (or with k times

more memory).

In English, this means that the program is basically along the right lines if it just needs a

faster (larger) machine to have worst-case b ehaviour as go - d as that of any other program

in all environments.

If a probability distribution is asso ciated with the environment class E, then we can use

the exp ected value V (l ; M ; E) to define an average-case notion of ABO:

Definition Average-case asymptotic bounded optimality: an agent program l is timewise

(or spacewise) average-case asymptotical ly bounded optimal in E on M i�

0

k l

0

V (l ; k M ; E) - V (l ; M ; E)

For b oth the worst-case and average-case definitions of ABO, we would b e happy with a

program that was ABO for a nontrivial environment on a nontrivial architecture M, unless

k were enormous.

In the rest of the pap er, we will use the worst-case definition of ABO.

Almost identical results can b e obtained using the average-case definition.

The first observation that can b e made ab out ABO programs is that classically optimal

programs are a sp ecial case of ABO programs:

. The classical definitions allow for optimality up to a constant factor k in the runtime of the algorithms.

One might wonder why we chose to use the constant factor to expand the machine capabilities, rather

than to increase the time available to the program. In the context of ordinary complexity theory, the

two alternatives are exactly equivalent, but in the context of general time-dep endent utilities, only the

former is appropriate. It would not b e p ossible to simply \let l run k times longer," b ecause the programs

we wish to consider control their own execution time, trading it off against solution quality. One could

imagine slowing down the entire environment by a factor of k, but this is merely a less realistic version

of what we prop ose.

. This connection was suggested by Bart Selman.

00

Provably bounded-optimal agents

Theorem A program is classical ly optimal for a given problem P if and only if it is

timewise worst-case ABO for the corresponding classical task environment class hEP

This observation follows directly from Definitions , , and .

; U i.

In summary, the notion of ABO will provide the same degree of theoretical robustness

and machine-indep endence for the study of b ounded systems as asymptotic complexity do es

for classical programs. Having set up a basic framework, we can now b egin to exercise the

definitions.

. Universal asymptotic b ounded optimality

Asymptotic b ounded optimality is defined with resp ect to a sp eci�c value function V . In

constructing real-time systems, we would prefer a certain degree of indep endence from the

temp oral variation in the value function. We can achieve this by de�ning a family V of value

functions, differing only in their temp oral variation. By this we mean that the value function

preserves the preference ordering of external actions over time, with all value functions in

the family having the same preference ordering.

For example, in the fixed-cost regime we can vary the time cost c to generate a family of

value functions; in the sto chastic deadline case, we can vary the deadline distribution Pd

to

generate another family. Also, since each of the three regimes uses the same quality measure

for actions, then the union of the three corresp onding families is also a family. What we will

show is that a single program, which we call a universal program, can b e asymptotically

b ounded-optimal regardless of which value function is chosen within any particular family.

Definition Universal asymptotic bounded optimality (UABO): An agent program l is

UABO in environment class E on M for the family of value functions V i� l is ABO in E

on M for every Vi

V .

A UABO program must comp ete with the ABO programs for every individual value function

in the family. A UABO program is therefore a universal real-time solution for a given task.

Do UABO programs exist? If so, how can we construct them?

It turns out that we can use the scheduling construction from (Russell & Zilb erstein,

 ) to design UABO programs. This construction was designed to reduce task environ

ments with unknown interrupt times to the case of known deadlines, and the same insight

applies here. The construction requires the architecture M to provide program concatena

tion (e.g., the LISP prog construct), a conditional-return construct, and the null program

fi. The universal program lU

has the form of a concatenation of individual programs of

increasing runtime, with an appropriate termination test after each. It can b e written as

lU

= [l0

- l

- - - lj

- - fi]

where each lj

program in L

consists of a program and a termination test. The program part in lj

is any

that corresp onds to a fixed deadline

M

that is ABO in E for a value function Vj

j

at t

=

fi, where - is a time increment smaller than the execution time of any non-null

d

program in L

.

M

. The value function must therefore b e separable (Russell & Wefald,   ), since this preservation of rank

order allows a separate time cost to b e defined. See chapter of (Keeney & Rai�a,  ) for a thorough

discussion of time-dep endent utility.

0

_q_

Russell & Subramanian

_0.7_

_0.5_

_0.2_

|Col1|lU on 4M<br>lopt on M<br>p(t)|Col3|Col4|Col5|Col6|Col7|Col8|Col9|Col10|Col11|Col12|Col13|
|---|---|---|---|---|---|---|---|---|---|---|---|---|
||||||||||||||
||||||||||||||
||||||||||||||
||||||||||||||
||||||||||||||

_0_ _10_

Figure : Performance profiles for l

running on M, and for l

_t_

running on M

U

Before pro ceeding to a statement that lU

opt

is indeed UABO, let us lo ok at an example.

Consider the simple, sequential machine architecture describ ed earlier. Supp ose we can

select rules from a three-rule set with r

= (0: ; ), r

= (0: ; ) and r

= (0: ; ). Since

the shortest runtime of these rules is seconds, we let - = . Then we lo ok at the optimal

programs l

These are:

0 ; l

; l

; l

; : : : for the fixed-deadline task environments with td

= ; ; ; ; : : :.

l0

= fi; l

= r

; l

= r

; l

= r

; : : :

Hence the sequence of programs in lU

is [fi; r

; r

; r

; : : :].

Now consider a task environment class with a value function Vi

that sp eci�es a sto chastic

deadline uniformly distributed over the range [0: : : 0]. For this class, lopt

= r

r

is a

b ounded optimal sequence.

It turns out that lU

has higher utility than lopt

provided it is

run on a machine that is four times faster. We can see this by plotting the two p erformance

profiles: QU

for l

U

on M and Q

on M . QU

dominates Qopt

, as shown in Figure .

opt

for lopt

To establish that the lU

construction yields UABO programs in general, we need to

                 

define a notion of worst-case p erformance profile. Let Q

(t; l ; M ; n; E) b e the minimum

value obtained by interrupting l at t, over all E in E of complexity n. We know that each

lj

in l

U

0

l

satis�es the following:

0

0

(l ; M ; n; E)

; n n - n

) V

(lj ; kj

        

M ; n; E) - Vj

 

j

for constants kj

j

, nj

. The aim is to prove that

 

i

U

0

(l ; M ; n; E)

Vi

V k ; n0

0

l ; n n  - n0

) V

(l

; k M ; n; E) - Vi

Given the definition of worst-case p erformance profile, it is fairly easy to show the following

lemma (the pro of is essentially identical to the pro of of Theorem in Russell and Zilb erstein,

 ):

. Notice that, in our simple mo del, the output quality of a rule dep ends only on its execution time and

not on the input complexity. This also means that worst-case and average-case b ehaviour are the same.

0

Provably bounded-optimal agents

1

0.8

0.6

0.4

0.2

0

5 10 15 20 25 30 35 40

Mean arrival time

i

Figure : Throughput and accuracy improvement of l

arrival time,      - = 0., Poisson arrivals.

, as a function of mean

U

over lopt

Lemma If lU

    

is a universal program in E for V, and li

           

is ABO on M in E for Vi

V,

then Q

(t; l

; k M ; n; E) dominates Q

(t; li

; M ; n; E) for k - maxj

k

j

n

j .

U

, n - maxj

This lemma establishes that, for a small constant p enalty, we can ignore the sp eci�c real

time nature of the task environment in constructing b ounded optimal programs. However,

we still need to deal with the issue of termination. It is not p ossible in general for lU

to terminate at an appropriate time without access to information concerning the time

dep endence of the utility function. For example, in a fixed-time-cost task environment, the

appropriate termination time dep ends on the value of the time cost c.

For the general case with deterministic time-dep endence, we can help out lU

                       

by sup

plying, for each Vi

, an \aspiration level" Qi

(t

i

i ; li

; M ; n; E), where ti

is the time at which

 

li

acts. lU

terminates when it has completed an l

j

- Qi

(ti

; li

; M ; n; E). By

with a suitable

such that qj

construction, this will happ en no later than t

b ecause of Lemma .

i

Theorem In task environments with deterministic time-dependence, an lU

aspiration level is UABO in E on M .

With deadline heralds, the termination test is somewhat simpler and do es not require any

additional input to lU

.

Theorem 0 In a task environment with stochastic dead lines, lU

it terminates when the herald arrives.

is UABO in E on M if

Returning to the mail-sorting example, it is fairly easy to see that l

(which consists of

U

a sequence of networks, like the optimal programs for the sto chastic deadline case) will b e

ABO in the fixed-deadline regime. It is not so obvious that it is also ABO in any particular

0

Russell & Subramanian

sto chastic deadline case | recall that b oth regimes can b e considered as a single family.

We have programmed a constructor function for universal programs, and applied it to the

mail-sorter environment class. Varying the letter arrival distribution gives us different value

functions Vi

i

V . Figure shows that lU

(on M ) has higher throughput and accuracy

than lopt

across the entire range of arrival distributions.

Given the existence of UABO programs, it is p ossible to consider the b ehaviour of com

p ositions thereof. The simplest form of comp osition is functional comp osition, in which

the output of one program is used as input by another. More complex, nested comp osi

tional structures can b e entertained, including lo ops and conditionals (Zilb erstein,  ).

The main issue in constructing UABO comp ositions is how to allo cate time among the

comp onents. Provided that we can solve the time allo cation problem when we know the

total runtime allowed, we can use the same construction technique as used ab ove to gen

erate comp osite UABO programs, where optimality is among all p ossible comp ositions of

the comp onents. Zilb erstein and Russell ( ), show that the allo cation problem can b e

solved in linear time in the size of the comp osite system, provided the comp osition is a tree

of b ounded degree.

. Conclusions And Further Work

We examined three p ossible formal bases for artificial intelligence, and concluded that

b ounded optimality provides the most appropriate goal in constructing intelligent systems.

We also noted that similar notions have arisen in philosophy and game theory for more or

less the same reason: the mismatch b etween classically optimal actions and what we have

called feasible b ehaviours|those that can b e generated by an agent program running on a

computing device of finite sp eed and size.

We showed that with careful sp eci�cation of the task environment and the computing

device one can design provably b ounded-optimal agents. We exhibited only very simple

agents, and it is likely that b ounded optimality in the strict sense is a difficult goal to

achieve when a larger space of agent programs is considered. More relaxed notions such

as asymptotic b ounded optimality (ABO) may provide more theoretically robust to ols for

further progress. In particular, ABO promises to yield useful results on comp osite agent

designs, allowing us to separate the problem of designing complex ABO agents into a discrete

structural problem and a continuous temp oral optimization problem that is tractable in

many cases. Hence, we have reason to b e optimistic that artificial intelligence can b e

usefully characterized as the study of b ounded optimality. We may sp eculate that provided

the computing device is neither to - small (so that small changes in sp eed or size cause

significant changes in the optimal program design) nor to - p owerful (so that classically

optimal decisions can b e computed feasibly), ABO designs should b e stable over reasonably

wide variations in machine sp eed and size and in environmental complexity. The details of

the optimal designs may b e rather arcane, and learning pro cesses will play a large part in

their discovery; we exp ect that the fo cus of this typ e of research will b e more on questions

of convergence to optimality for various structural classes than on the end result itself.

Perhaps the most imp ortant implication, b eyond the conceptual foundations of the field

itself, is that research on b ounded optimality applies, by design, to the practice of artificial

intelligence in a way that idealized, infinite-resource mo dels may not. We have given, by

0

Provably bounded-optimal agents

way of illustrating this definition, a b ounded optimal agent: the design of a simple system

consisting of sequences of decision pro cedures that is provably b etter than any other program

in its class. A theorem that exhibits a b ounded optimal design translates, by definition,

into an agent whose actual b ehaviour is desirable.

There app ear to b e plenty of worthwhile directions in which to continue the exploration

of b ounded optimality. From a foundational p oint of view, one of the most interesting

questions is how the concept applies to agents that can incorp orate a learning comp onent.

(Note that in section , the learning algorithm was external to the agent.) In such a

case, there will not necessarily b e a largely stable b ounded optimal configuration if the

agent program is not large enough; instead, the agent will have to adapt to a shorter-term

horizon and rewrite itself as it b ecomes obsolete.

With results on the preservation of ABO under comp osition, we can start to examine

much more interesting architectures than the simple pro duction system studied ab ove. For

example, we can lo ok at optimal search algorithms, where the algorithm is constrained to

apply a metalevel decision pro cedure at each step to decide which no de to expand, if any

(Russell & Wefald,   ). We can also extend the work on asymptotic b ounded optimality

to provide a utility-based analogue to \big-O" notation for describing the p erformance of

agent designs, including those that are sub optimal.

In the context of computational learning theory, it is obvious that the stationarity

requirement on the environment, which is necessary to satisfy the preconditions of PAC

results, is to - restrictive. The fact that the agent learns may have some effect on the

distribution of future episo des, and little is known ab out learning in such cases (Aldous &

Vazirani,  0). We could also relax the deterministic and episo dic requirement to allow

non-immediate rewards, thereby making connections to current research on reinforcement

learning.

The computation scheduling problem we examined is interesting in itself, and do es not

app ear to have b een studied in the op erations research or combinatorial optimization liter

ature. Scheduling algorithms usually deal with physical rather than computational tasks,

hence the ob jective function usually involves summation of outputs rather than picking the

b est. We would like to resolve the formal question of its tractability in the general case, and

also to lo ok at cases in which the solution qualities of individual pro cesses are interdep endent

(such as when one can use the results of another). Practical extensions include computation

scheduling for parallel machines or multiple agents, and scheduling combinations of compu

tational and physical (e.g., job-shop and flow-shop) pro cesses, where ob jective functions are

a combination of summation and maximization. The latter extension broadens the scop e

of applications considerably. An industrial pro cess, such as designing and manufacturing a

car, consists of b oth computational steps (design, logistics, factory scheduling, insp ection

etc.) and physical pro cesses (stamping, assembling, painting etc.). One can easily imagine

many other applications in real-time financial, industrial, and military contexts.

It may turn out that b ounded optimality is found wanting as a theoretical framework. If

this is the case, we hop e that it is refuted in an interesting way, so that a b etter framework

can b e created in the pro cess.

0

Russell & Subramanian

App endix: Additional Pro ofs

This app endix contains formal pro ofs for three subsidiary lemmata in the main b - dy of the

pap er.

Lemma There exists an optimal sequence that is sorted in increasing order of q 's.

Pro of: Supp ose this is not the case, and s is an optimal sequence. Then there must b e

two adjacent rules i, i + where qi

0

0

- qi+

(see Figure ). Removal of rule i + yields a

i

sequence s

such that Q

0

(t) - Qs (t), from Lemma and the fact that t

i+

- t

+ t

. By

i+

0

i+

is ordered

s

Lemma , s

must also b e optimal. We can rep eat this removal pro cess until s

by qi

, proving the theorem by reductio ad absurdum.

Lemma For every sequence s = s

: : : sm

sorted in increasing order of quality, and single

step z with qz

- q

s

, V (sz ) - V (s).

m

Pro of: We calculate V (sz ) - V (s) using Equation and show that it is non-negative:

V (sz ) - V (s) = qz

= (q

[ - Pd

- q

((

P

m

j =

t

)] - qm

((

P

m

j =

t

j

)]

j

) + tz

) + tz

m

j =

tj ) + t

)[ - Pd

P

((

z

[ - Pd

)]

z

which is non-negative since qz

_q_

_qi+2_

_qi_

_qi-1_

_qi+1_

- q

_t i_

m

_t i+1_

.

m

Figure : Pro of for ordering by qi ; lower dotted line indicates original profile; upp er dotted

line indicates profile after removal of rule i + .

Lemma There exists an optimal sequence whose rules are in nondecreasing order of t

.

i

Pro of: Supp ose this is not the case, and s is an optimal sequence. Then there must b e

two adjacent rules i, i + where qi - qi+

0

0

and ti

- ti+

(see Figure ). Removal of rule i

0

yields a sequence s

such that Qs

(t) - Q

s (t), from Lemma . By Lemma , s

0

must also b e

optimal. We can rep eat this removal pro cess until s

by reductio ad absurdum.

0

is ordered by ti

, proving the theorem

_q_

Provably bounded-optimal agents

_qi+1_

_qi_

_qi-1_

_t i_

_t i+1_

Figure : Pro of for ordering by ti ; dotted line indicates profile after removal of rule i.

Acknowledgements

We would like to acknowledge stimulating discussions with Michael Fehling, Michael Gene

sereth, Russ Greiner, Eric Horvitz, Henry Kautz, Daphne Koller, and Bart Selman on the

sub ject of b ounded optimality; with Dorit Ho chbaum, Nimro d Megiddo, and Kevin Glaze

bro ok on the sub ject of dynamic programming for scheduling problems; and with Nick

Littlestone and Michael Kearns on the sub ject of agnostic learning. We would also like to

thank the reviewers for their many constructive suggestions. Many of the early ideas on

which this work is based arose in discussions with the late Eric Wefald. Thanks also to

Ron Parr for his work on the uniform-distribution case, Rhonda Righter for extending the

results to the exp onential distribution, and Patrick Zieske for help in implementing the dy

namic programming algorithm. The first author was supp orted by NSF grants IRI- 0,

IRI-  and IRI- 0, by a visiting fellowship from the SERC while on sabbatical

in the UK, and by the NEC Research Institute. The second author was supp orted by NSF

grant IRI- 0.

References

Agre, P., & Chapman, D. ( ). Pengi: An implementation of a theory of activity. In

Proc. th National Conference on Artificial Intel ligence, Seattle, WA. Morghan Kauf

mann.

Aldous, D., & Vazirani, U. ( 0). A markovian extension of valiant's learning mo del. In

Proc. st Annual Symposium on Foundations of Computer Science, St. Louis, MO.

IEEE Comput. So c. Press.

Binder, J. ( ). On the complexity of delib eration scheduling with sto chastic deadlines..

Boser, B. E., Sackinger, E., Bromley, J., & LeCun, Y. ( ). Hardware requirements for

neural network pattern classifiers | a case study and implementation. IEEE Micro,

, {0.

Brandt, R. ( ). In search of a credible form of rule utilitarianism. In Nakhnikian, G., &

Castaneda, H. (Eds.), Morality and the Language of Conduct.

0

Russell & Subramanian

Breese, J. S., & Fehling, M. R. ( 0). Control of problem-solving: Principles and architec

ture. In Shachter, R. D., Levitt, T., Kanal, L., & Lemmer, J. (Eds.), Uncertainty in

Artificial Intel ligence . North Holland: Amsterdam.

Bro oks, R. A. ( ). A robust, layered control system for a mobile rob ot. IEEE Journal

of Robotics and Automation,, {.

Cherniak, C. ( ). Minimal rationality. MIT Press: Cambridge.

Dean, T., & Bo ddy, M. ( ). An analysis of time-dep endent planning. In Proc. of AAAI

, pp.  {.

Dean, T. L., & Wellman, M. P. ( ). Planning and control. Morgan Kaufmann: San

Mateo, CA.

Dennett, D. ( ). The moral first aid manual. Tanner lectures on human values, University

of Michigan.

Doyle, J. ( ). What is rational psychology? toward a mo dern mental philosophy. AI

Magazine,, 0{.

Doyle, J. ( ). Artificial intelligence and rational self-government. Tech. rep.. Technical

rep ort CMU-CS--.

Doyle, J., & Patil, R. ( ). Two theses of knowledge representation: language restric

tions, taxonomic classification, and the utility of representation services. Artificial

intel ligence,, { .

Etzioni, O. (  ). Tractable decision-analytic control. In Proc. of st International Con

ference on Know ledge Representation and Reasoning, pp. {.

Fehling, M., & Russell, S. J. (  ). Proceedings of the AAAI Spring Symposium on Limited

Rationality. AAAI.

Genesereth, M. R., & Nilsson, N. J. ( ). Logical Foundations of Artificial Intel ligence.

Morgan Kaufmann: Mateo, CA.

Go - d, I. J. ( ). Twenty-seven principles of rationality. In In Go damb e, V. P., & Sprott,

D. A. (Eds.), Foundations of Statistical Inference, pp. 0{. Holt, Rinehart, Win

ston.: Toronto.

Hansson, O., & Mayer, A. (  ). Heuristic search as evidential reasoning. In Proceedings

of the Fifth Workshop on Uncertainty in Artificial Intel ligence, Windsor, Ontario.

Horvitz, E. J. ( ). Reasoning ab out b eliefs and actions under computational resource

constraints. In Levitt, T., Lemmer, J., & Kanal, L. (Eds.), Uncertainty in Artificial

Intel ligence . North Holland: Amsterdam.

Kearns, M., Schapire, R., & Sellie, L. ( ). Toward efficient agnostic learning. In Proc. th

Ann. Workshop on Computational Learning Theory, Pittsburgh, PA. Morgan Kauf

mann.

0

Provably bounded-optimal agents

Keeney, R., & Rai�a, H. ( ). Decisions with multiple objectives: Preferences and value

tradeo�s. Wiley: New York.

Levesque, H., & Brachman, R. ( ). Expressiveness and tractability in knowledge repre

sentation and reasoning. Computational Intel ligence,, { .

Luby, M., Sinclair, A., & Zuckerman, D. ( ). Optimal sp eedup of las vegas algorithms.

Information Processing Letters,, {0.

McCarthy, J. ( ). Programs with common sense. In Proceedings of the Symposium on

the Mechanization of Thought Processes, Teddington, England: HMSO.

Newell, A. ( ). The knowledge level. AI Magazine,, {0.

Neyman, A. ( ). Bounded complexity justi�es co op eration in the finitely rep eated pris

oners' dilemma. Economics Letters,, { .

Papadimitriou, C., & Yannakakis, M. ( ). On complexity as b ounded rationality. In

Proc. ACM Symposium on the Theory of Computation.

Ramsey, F. P. ( ). Truth and probability. In Braithwaite, R. (Ed.), The foundations of

mathematics and other logical essays. Harcourt Brace Jovanovich: New York.

Russell, S. J., & Wefald, E. H. (  a). On optimal game tree search using rational metar

easoning. In Proc. IJCAI- .

Russell, S. J., & Wefald, E. H. (  b). Principles of metareasoning. In Proc. KR- .

Russell, S. J., & Wefald, E. H. ( ). Do the right thing: Studies in limited rationality.

MIT Press: Cambridge, MA.

Russell, S. J., & Zilb erstein, S. ( ). Comp osing real-time systems. In Proc. IJCAI- ,

Sydney.

Sackinger, E., Boser, B. E., Bromley, J., & LeCun, Y. ( ). Application of the anna

neural network chip to high-sp eed character recognition. IEEE Transactions on Neural

Networks,,  {0.

Simon, H. A. ( ). On how to decide what to do. In Models of bounded rationality,

Volume .

Simon, H. A. ( ). Models of bounded rationality, Volume . MIT Press: Cambridge.

von Neumann, J., & Morgenstern, O. ( ). Theory of games and economic behavior.

Princeton University Press: Princeton.

Zilb erstein, S. ( ). Operational Rationality Through Compilation of Anytime Algorithms.

Ph.D. thesis, Computer Science Division, University of California, Berkeley.

Zilb erstein, S., & Russell, S. ( ). Optimal comp osition of real-time systems. Submitted

to Artificial Intel ligence.

0
