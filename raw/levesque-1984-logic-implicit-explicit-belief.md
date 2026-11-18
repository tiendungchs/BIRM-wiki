# levesque-1984-logic-implicit-explicit-belief

> Converted from `levesque-1984-logic-implicit-explicit-belief.pdf` on 2026-11-18 via `pymupdf4llm`.
> Layout artefacts (broken equations, interleaved columns) are conversion noise, not the source.

---

From: AAAI-84 Proceedings. Copyright ©1984, AAAI (www.aaai.org). All rights reserved.

tically indistinguishable. This might suggest that any realistic the syntactic and the possible-world approaches so that different
semantics for belief will have to include (something isomorphic sets of sentences can represent the same beliefs without requirto) a set of sentences to distinguish between the two belief sets ing that all logically equivalent sets **do** so. We now show that
above. The usual way to interpret a sentence like La in a stan- there is a reasonably intuitive semantics for belief that **has** these
dard Kripke framework is to **have** a model structure that con- properties.
tains a set of possible worlds, an accessibility relation and other
things. It appears that to interpret a sentence like **_Ba,_** a model
structure will have to contain an explicit set of sentences. This is 3. **Situations**

indeed what happens in the formalizations of belief of [S] and (61
that share our goal **of** avoiding logical omniscience. A slightly On closer examination, the reason the possible-world ap

more sophisticated approach is that of [7] where the semantic preach to belief or knowledge leads to logical omniscience is that

structure contains only an initial set of sentences (representing beliefs are characterized completely by a set of possible worlds

a base set of beliefs) and a set of logically sound deductive rules (namely, those that are accessible from a given possible world).

for obtaining new derived beliefs. Logical omniscience is avoided Intuitively, these possible worlds are to be thought of as the full

there by allowing the deductive rules to be logically incomplete. range of what the agent thinks the world might be like. If he

With or without deductive rules, I will refer to this approach to only believes that **_p_** is true, the set of worlds will be all those

modelling belief **_as_** the **_.yntactic_** approach since syntactic entities where **_p_** is true: some, for example, where **_q_** is true, others, where

have to be included within the semantic structures. **_q_** is false. However, because sentences which are tautologies will

also be true in all these possible worlds, the agent is thought of
Apart from this perhaps ill-advised mixture of syntax and

as believing them just as if they were among his active beliefs.
semantics, the syntactic approach suffers from a serious defect

In terms of the possible worlds, there is no way to distinguish **_p_**
that is the opposite of the problem with possible worlds. A

also be true in all these possible worlds, the agent is thought of
Apart from this perhaps ill-advised mixture of syntax and

from these tautologies.
possible-world semantics is, in some sense, too **_coarse-grained_** to

model belief in that it cannot distinguish belief sets that logically One way to avoid all these tautologies is to to make this no
imply the same set of sentences. The syntactic approach, on tion of what an agent thinks the world is like be more relevant

the ocher hand, is too **_fine-grained_** in that it considers any two to what he actually believes. This can be done by replacing the

sets of sentences as distinct semantic entities and, consequently, possible worlds by a different kind of semantic entity that does

different belief sets. not necessarily deal with the truth of all sentences. In partic
ular, sentences not relevant to what an agent actually believes
To see why this a problem, consider, for example, the disjunc
(including some tautologies) need not get a truth value at all.
tion of LY and 8. There is no reason to suppose that

ular, sentences not relevant to what an agent actually believes
To see why this a problem, consider, for example, the disjunc

**_B(a v,9)_** **_E_** B(/3V a)

Following [8] (but not too closely), we will call this sort of partial
possible world **a Gtuation.** bughly speaking, a situation may

would be **_valid_** given a syntactic understanding of **_B_** since **(@VP)** support the truth of some sentences and the falsity of others,

may be in the belief set while (/? **V** a) may not.2 The trouble but may fail to deal with other sentences at all.

with this is that if we consider intuitively what For example, consider the situation of me sitting at my ter

**_“It is believed_** **_that either_** **_o or /I is true.’_** minal at work. We might say that this situation supports the

fact that I’m at work, that somebody is at my terminal, that
is saying, the order seems to be completely irrelevant. It is

there is either a terminal or a book at my desk, and so on. On

almost an accident of lexical notation that we had to choose one

there is either a terminal or a book at my desk, and so on. On

almost an accident of lexical notation that we had to choose one

the other hand, it does not support the contention that my wife
of the disjuncts to go first. Yet, the syntactic approach makes

is at home, that she is not out shopping, or even that she is at

the left to right order of disjuncts **semanticallysignificant** **in** that

is at home, that she is not out shopping, or even that she is at

the left to right order of disjuncts **semanticallysignificant** **in** that

home or not at home. Although the latter **is** certainly **_true, me_**
we can believe one ordering but fail to believe the other.
sitting at my terminal does not deal with it one way **or** another.
The obvious counter to this is that the logic of the syntactic

One way of thinking about situations is as generalizations of

approach has to be embellished to avoid these spurious syntactic

possible worlds where not every sentence in **a language**

One way of thinking about situations is as generalizations of

distinctions. For example, we might insist as part of the seman
tics that to be well-formed, any belief set containing **(ckVb)** must

also contain (/? **V** cr) (or, for Konolige, the obvious deduction

rule must be present). The trouble with this kind of constraint

is that it is semantically unmotivated. For example, should we

possible worlds where not every sentence in **a language** **is re-**

quired to have a truth value. Conversely, we can think of **pos-**

sible worlds as those limiting cases of situations where every

sentence does have a truth value. Indeed, the concept of a pos
sible world being **_compatible_** with a situation is intuitively clear:

is that it is semantically unmotivated. For example, should we

every sentence whose truth is supported by the situation should
also insist that any set containing 11~ must also contain cr?

come out true in that possible world and every sentence whose

Should every belief set containing a and b also contain (a ha)?

Should every belief set contain the ‘Lobviousn tautologies such

come out true in that possible world and every sentence whose

falsity is supported should come out false. Again **drawing** **from**

Should every belief set contain the ‘Lobviousn tautologies such

(81, we will also allow for **_incoherent_** situations with which no
as (a > a)? Where do we stop ? Clearly, it would be preferable

possible world is compatible. These are situations that (at least

to have a semantics where restrictions such as these **_follow_** from

possible world is compatible. These are situations that (at least

to have a semantics where restrictions such as these **_follow_** from

seem to) support both the truth and falsity of some sentence.
the meaning of **_Ba_** and not the other way around. In other

From the point of view of modelling belief, these are very useful

words, we want a semantics (like that of possible worlds) that

From the point of view of modelling belief, these are very useful

words, we want a semantics (like that of possible worlds) that

since they will allow an agent to have an incoherent picture of

is based on some concept of **_truth_** rather than on a collection

the world.
of **_ad hoc_** restrictions to sets of sentences. Ideally, moreover,
The “trick”, then, that underlies the logic of belief to follow
the granularity of the semantics should lie somewhere between
is to identify explicit belief with a **_Bet_** o{aituationa rather than

is based on some concept of **_truth_** rather than on a collection

**21n Konolige’s #y&em, one disjunction** **may** **be deducible while the other** possible worlds. Before examining the formal details, there is
mav not. one point to make. Traditional lonics of knowledge **and belief**

**199**

have dealt not only with world knowledge but also with metaknowledge, that is, knowledge about knowledge. To be able
to deal with this in our case is somewhat of a problem since
we would have to deal with a whole raft of questions about
what is believed about what is explicitly or implicitly believed.
For example, even without assuming that everything believed
is true, it is not clear whether or not B(La - CX) should be
valid. For reasons given in [3], **_L(La_** **_> CY) should_** be valid even
if belief does not, in general, imply truth. Instead of trying to
settle all of these questions here and now, we will ignore them
completely. The language below will simply not contain any
sentences where a B or a L appears within the scope of another.
This will simplify the semantics immensely while still illustrating
how the two concepts can co-exist naturally.

**4. A Formal Semantics**

The language we are considering (call it L) is formed in the
obvious way from a set of atomic sentences P using the standard connectives **V,** A, and 1 for disjunction, conjunction, and
negation respectively, and two uuary connectives B and L. Only
regular propositional sentences (without a B or a L) can occur
within the scope of these last two connectives. We assume that
other connectives such as > and E can be understood in t(erms
of the original ones.s

Sentences of L are interpreted semantically in terms of a **_model_**
**_atructute_** **_(S,B,T,3)_** w ere .S is a set, h **_B_** is a subset of S, and
both t and 3 are functions from P (the atomic sentences) to
subsets of S. Intuitively, S is the set of all situations with **_B_**
being those situations that could be the actual one according
to what is believed. For any atomic sentence p, T(p) are the
situations that support the truth of **_p_** and **_3(p)_** are those that
support the falsity of **_p._**

To deal with the possible worlds compatible with a situation
in a model structure, we define W by the following:

W(3) = { 3’ E S 1 for every **_p E_** **P,**

a) a’ is a member of exactly one of **_7(p)_** and **_3(p),_**
b) if 3 is a member of **_7(p),_** then so is Q’,
and c) if **_a_** is a member of **_3(p),_** then so is s’.}

The first condition aboves guarantees that s’ will be a possible
world, while the last two guarantee compatibility. Also, for any
subset S * of S, we will let W (S’) mean the union of all W (8)
for every s in S’.
,*
Given a semantic structure (S, **_8, T,3_** **_), we can_** define the
**_support_** **_relations_** /==T and +p holding between situations and sentences of L. Intuitively, 8 kTa when 8 supports the truth of CX,
and .9 kp Q when s supports the falsity of Q. More formally, we
have the following:

kT and k=F E S x L and are defined by

1. **_skTpiff8ET(p)._**

**_u k=p p_** iff d E **3(p).**

**aWe may eventually want a special implication operator, especially for sen-**

**tences that are obiects of belief.**

**_200_**

**_5. J kT Ba_** iff for every 3’ in 8, 8’ bTa.
**_a kFBcr_** iff 3 **_IfTBa._**

**_6._** J /== La iff for every 3’ in W(B), 3’ k=a.
3 +FLa iff 8 kTLa.

If 9 is an element of W(S) ( i.e. 8 is a possible world), then if
B +=a, we say that **_a is true at_** a and otherwise that a **ia joke**

**_at_** 8. Thus, as to be expected, a sentence is true iff it is not false
iff its negation is false. Finally, we say that a is **_valid_** and write
/= a provided that for any model structure (S, B, T,3 ) and any
J in W(S), (Y is true at s. The satisfiablitity of a sentence (or of
a set of sentences) can be defined analogously. This completes
the semantics of L.

While space precludes a lengthy examination of the properties
of L, here are the major highlights. First of all, L handles its
standard propositional subset correctly in that all instances of
propositional tautologies are valid and, moreover, any sentence
not containing a **_B_** or L is valid iff it is a standard tautology.

As for implicit belief, it is easy to see that all tautologies are
implicitly believed and that it is closed under implication. In
other words, we have

If + Q (where Q is propositional), then b La and

k (La A L(cK 3 /4)) 3 L/9.

Equally important, the sentence **_(Ba_** - La) is valid, meaning
that everything that is explicitly believed is an implicit belief.
In fact, if a sentence is a logical consequence’ of what is believed,
then it is implicitly believed. Unfortunately, the converse does
not hold since in some interpretations, there may be sentences
that are true in the right set of possible worlds without being implied by what is believed. For example, if a sentence is
necessarily **_true_** then it will be an implicit belief-even if it is
not logically valid-a generic problem with the possible-world
semantics for knowledge and belief that seems to have gone unnoticed in the literature. We should not be **_too_** concerned about
this, however, since it does not affect either the valid or the satisfiable sentences of L, but only whether or not certain **_infinite_**
sets of sentences are satisfiable.5

Of course, the major issue here is how the **_B_** operator behaves.
Before examining the valid sentences containing B, it is worth
copsidering some satisfiable sets of sentences that show that belief does not suffer from logical omniscience. The following sets
are all satisfiable:
.

1. {Bp,B(p~q),-Bq} Th <sup>is s ows that beliefs are not closed</sup> h
’ under implication.

**‘A sentence Q is** **_a_** **logical consequence of** **_a_** **set L’ of sentences iff L’** U {TX}

**is unsatisfiable.**

**6There is, moreover, a fairly simple way to eliminate the problem of non-**
**logical necessary truths always being implicitly believed.** **Call a model**
**structure ezpunriue if** **for** **any set of** **_atomic_** **sentences, there is a possible**
**world in the structure such that the atomic sentences it supports is precisely**
**that set.** **Now while there are certainly model st.ructures that** **_are_** **not**
**expansive, it can be shown that the validity or satisfiability of a sentence**
**would not change if these were defined in terms of expansive structures**
**only. With this definition, moreover, a sentence would indeed be implicitly**
**believed if and only ilit** **_was_** **lonicallv implied bv what was believed.**

2. **_(1B(pv_** **_-p)}_** A va i sentence need not be believed. Id

3. { Bp, **_-B(p_** **A** **_(q_** **V** **_-q))}_** A logical equivalent to a belief
need not be believed.

4. **_{Bp, B-p,_** **_-Bq}_** B 1 f e ie s can be inconsistent without every
sentence being believed.

The above sets show what freedom the logic allows in terms
of beliel; to demonstrate that the logic does impose reasonable
constraints on belief, we must look at the valid sentences of L.
We will present these in terms of a proof theory for L that is both
sound and complete with respect to the above semantics. The
important point, however, is that unlike the syntactic approach,
these constraints follow from the semantics. The only reason to
consider a proof theory here is that it does provide an elegant
and vivid way to examine the valid sentences of L (especially
those using **_B).’_**

**5. A Proof Theory**

The proof theory of L must begin with a propositional basis
of some sort to guarantee that all tautologies are present. The
simplest way to do this is to have a single rule of inference,
**_Modus_** Ponens, and the usual three axioms that can be found
in any elementary logic textbook. To this basic system we will
adjoin a collection of new axioms for implicit and explicit belief
but no new rules of inference.

The appropriate axioms for implicit belief should make sure
that it contains all tautologies and all beliefs and is closed under
implication. This can be achieved with three axiom schemata:

1. Lo, where a is a tautology.

2. **_(Ba 3 La)._**

3. **kr** **A** **.+** **3** **a)** **3** **Lg.**

For explicit belief, on the other hand, we have to dream up a
set of axioms stating what has to be believed when something
else is. In other words, we need a set of axioms of the form
**_(Ba_** - **_BB),_** for various 0 and /?. Remarkably enough, this work
has already been done for us in what is called relevance logic [9].
This logic deals with a relationship between pairs of sentences
called **_entailment_** that is a proper subset of logical implication.
Entailment is based on the intuition that the antecedent of an
implication should be relevant to the consequent. As it turns
out, entailment and belief are very closely related, as the following key result attains:

Theorem 1: /= **_(Ba > B/?)_** **_if7 a_** entails /?.

The proof of this theorem’ is based on a correspondence between
our semantics of situations and a semantics of four truth-values
described in 1111. What this tells us is that L contains relevance
logic as a subpart: questions of entailment can be reduced t.o
questions of belief in L. Moreover, we get this relevance logic
without having to give up classical logic and the normal interpretation of > and the other connectives.

**‘We could imagine constructing** **_a_** **decision procedure for L directly from the**

**above without even passing through a proof theory at all.** **Such** **A decision**
**procedure, after all, is what counts when building a system that reasons**
**with L.**

**‘Proofs of this and the two other quoted theorems can be found in [lo],** **_a_**

**slinhtlv revised version of this Daoer.**

So all that is needed to characterize the constraints satisfied
by belief is to apply a set of axioms for entailment in relevance
logic **to** belief. One such set given in [9] is the following:

This particular axiomatization states that belief must respect

properties of the logical operators such as commutativity, associativity, distibutivity, De Morgan’s laws and double negation.
Nothing in these axioms forces all the logical consequences of
what is believed to be believed (as in axioms 1 and 3, above, for
implicit belief), although each one forces **_Some_** consequences to
be believed (e.g., by axiom 8, a double negation of a sentence
must be believed if the sentence itself is).

Another way to understand these axioms (except for **the** very
last one) is as constraints on the individuation of beliefs. For
example, (cr **V 8)** is believed iff (/l **V a)** is because these are two
lexical notations for the same belief. In this sense, it is not that
there is an automatic inference from one belief to another, but
rather two ways of describing a single belief.

This, in itself, does not **_juSti&/_** the axioms, however. It **is**
easy to imagine logics of belief that are different from this one,
omitting certain of the above constraints or perhaps adding additional ones. Indeed, there is not much to designing a proof
theory with any collection of constraints on belief. The interesting fact about **_this_** particular set of a,xioms, however, is that it
corresponds so nicely to an independently motivated semantic
theory. Specifically, we have the following result:

Theorem 2: (Soundness and Completeness)
A sentence **_of_** L **_is_** **a** **_theorem_** of **_the_** above logic iff it **_is_** valid.

Furthermore, and perhaps most importantly, the logic of L has
very attractive computational properties as well, which we now
turn to.

**0. The Payoff**

What does this new logic of belief buy us? One thing is a language that can be used to formally reason about the beliefs of
other agents without assuming logical omniscience, If we imagine a system planning speech acts as in [12], we can represent
what it knows about the beliefs of another as a theory in L. It
could then plan to remind someone of something he only believes
implicitly. Similarly, it could take someone through certain steps
of an argument or proof, at each stage pointing out implications
of the other agent’s beliefs.

There are any number of ways to mechanize the necessary reasoning in L. One currently fashionable method involves translating evervthine: into first-order Ionic and running a resolution

4.

5.

6.

7.

8.

9.

B(o A B) E **_B(/‘?_** **A a).**
**_B(a v a) E B(/!3_** **V a).**

**B(a** **A (B A 7))** **=** **B((a** **A 8) A r)-**
**B(a** **v (B v 7))** **=** **B(b** **V b’j V -Y).**

**B(a** **A (B V +I)) =** **B((o** **A B) V (a A r))-**
**B(a** **v (B A 7))** **-** **B((a** **V 8** **A b V -/j)-**

**B-+rVj3)** **GE** B(yaA+).
B+A\) E B(lcrV 18).

**_B-VTK G_** **_Ba._**

**_Ba_** **A** **_B/3 z_** **_B(a_** **A a).**

**_Bav_** **_B/9 >_** B(LIVB).

201

theorem-prover **over** the results. This would involve the usual
encoding of sentences of L as terms and characterizing either its
validity or provability (or both) using **a** first-order theory. **Just**
doing this, however, would miss **a** very important feature of L,
namely that calculating propositional beliefs is much easier than
doing general propositional reasoning.

Consider, in particular, the role **of** a logical Knowledge Representation system (such **as KRYPTON** **[13])** that is given as **a**
knowledge base (or KB) **a** finite set of sentences in some language. What a knowledge-based system using this KB (such as
a robot) will be interested in is whether or not some proposition
is true of the application domain (e.g. “Is it raining outside?“).
The ideal way of answering this kind of questions is yes if the
question follows from what is in the KB, no if its negation does
and unknown otherwise. The sad fact of the matter, however,
is that for all but extremely simple languages (including some
without quantifiers) this question-answering is computationally
intractable. This might be tolerable if the kind of question you
ask is an open problem in mathematics where you are willing
to stop arid redirect the theorem-prover **with problem-specific**

**heuristics** **if it seems** **to be thrashing.** **If, on the other** **hand,** **a**
robot is trying to decide whether or not to use an umbrella, and
calls a Knowledge Representation system utility as **a** subroutine,
this kind of behaviour is unacceptable.

A possible solution to the problem is for the Knowledge Representation system to manage **what is explicitly** **believed** **rather**
**than** **its implications.** In those cases where a question cannot
be **answered** **directly** **on** the **basis of what** is believed, the robot

**can decide** **to try to figure out** the **answer** **by determining** the
implications of what it believes. Moreover, new facts can be
sought and the question can even be abandoned it it becomes

**too expensive** **to pursue** **(e.g.** the **robot can decide** **to bring its**
umbrella just to be safe). The point is that this more general
form of reasoning can be controlled very carefully depending on
the situation since it is no longer just a subroutine call to a
Knowledge Representation system. The robot can, in fact, **_plan_**

**to figure something** **out just as it** would plan any other activity.

This is all very speculative, of course. How do we know,
for example, that it is any easier to calculate **what** **is believed**
rather than its implications? There is, fortunately, fairly strong
evidence for this, at least in the propositional cme:

Theorem 3: Suppose KB and Q are **_propositional_** **_sentences_** **_in_**
conjunctive **_norm_** al form. **_Determining_** **_if KB fogically_** **_implies_**
**_a is co-J/P-complete_** **_but determining_** **_if KB entails_** **_a_** **has** an
**_O(mn)_** **_ajgorjthm,_** **_where m = ]KBl and n = lal._**

Corollary 4: **_Assume_** **_KB and Q are as_** above. **_Then,_** **_in the_**
**_worst case, deciding_** **_if_**

**_a)_** **_/= (BKB 3 La)_** **_is very dJ%cult._**

**_b)_** **_+ ( BKES > Ba)_** **_is relatively_** **_easy._**

**What this amounts** **to is that if we consider** **answering** **questions**
of a given fixed size, the time it takes to calculate **what** the KB
**believes** **will grow linearly** **at worst with** the size of the KB, but
the time it takes to calculate the implications of **what** the KB
believes will grow **_ezponenfiallys_** **at worst** **with** the size of the
KB.

**sMore precisely, it will grow faster than any polynomial function, unless P**

**eauals NP.**

**202**

Returning now to the formal modelling of the beliefs of other
agents, the reason we would not want to simply run an untuned
resolution theorem-prover over encodings of sentences of L is
that we would lose the opportunity to exploit the computational
tractability of belief.

**Again,** **it is not so much** **that** **our logic is** the **_only_** one to
capture a semantically and computationally respectable notion
of belief. What it demonstrates, however, is **first,** **that** **it is**
possible to move away from closure under classical implication

**without** **espousing** the **syntactic** **approach** **and giving up semau-**
**tics altogether,** and second, that there is hope for **a** non-trivial
domain-independent Knowledge Representation deductive service. Of course, it remains to be seen whether these advantages
can be preserved for a language that includes meta-knowledge
and quantifiers. Discovering appropriate semantics and decision
procedures in these cases remains a difficult open problem.

ACKNOWLEDGEMENTS

**This work wa done as** part **of the KRYPTON** project **at Fairchild** **and**
**I am indebted to its other members, Ron Brachman,** **Richard Fikes,**
**Peter Pat&Schneider,** **and** **Victoria Pigman, as well as to David Israel**

**of** **BBN, Joe Halpern** **and** **the other participants** **of the Knowledge**
**Seminar at IBM San Jose, and to the Best Western family of hotels.**

REFERENCES

**Hintikka, J.,** _Knowledge_ _and Belief:_ _An Inlroduction_ _to the Logic_
**o/ the** _Two_ **Notions, Cornell University Press, 1962.**

**Hintikka, J., Impossible** **Possible Worlds Vindicated,** **Journal of**
_f’hiiosophicnl_ **Logic, 4, 1975, 475-484.**

**Levesque,** **H. J., Foundations** **of a Functional** **Approach** **to**
**Knowledge Representation,** **Artijiciaf Intelligence, forthcoming.**

**Moore, R. C., Reasoning** **about** **Knowledge and Action, Techni-**
**cal Note 181, SRI International,** **Menlo Park, 1980.**

**Moore, R. C. and Head&,** **G., Computational** **Models of Beliefs**
**and the Semantics of Belief-Sentences,** **Technical Note 187, SRI**
**International,** **Menlo Park, 1979.**

**Eberle, R. A., A Logic of Believing, Knowing and Inferring, Sun-**
_these_ **26, 1974, 356-382.**

**Konolige, K., A Deduction Model of Belief, Ph. D. Thesis, Com-**
**puter Science Department,** **Stanford University, in preparation.**

**Barwise,** **J. and Perry, J., Situations** **and Attitudes,** **Bradford**
**Books, Cambridge, MA, 1983.**

**Anderson,** **A. R. and Belnap, N. D., Entailment,** _The_ **Logic of**
_Releoance_ **and Necesaitg, Princeton University Press, 1975.**

**Levesque, H. J., A Logic of Implicit and Explicit Belief, Fairchild**
**Laboratory** **for Artificial** **Intelligence** **Research,** **Technical** **Re-**
**port, in preparation.**

**Belnap, N. D., A Useful Four-Valued Logic, in G. Epstein and J.**
**M. Dunn (eds.),** _Modern User_ of _Multiple-Valued_ **Logic, Reidel,**
**1977.**

**Perrault,** **C. R. and Cohen, P. R., Elements of a Plan-Based**
**Theory of Speech Acts, Cognitive Science 3, 1979, 177-212.**

**Brachman,** **R. J., Fikes, R. E., and Levesque,** **H. J., KRYP-**
**TON: A Functional** **Approach** **to Knowledge** **Representation,**
_IEEE Computer,_ **16** **(lo), 1983, 67-73.**
