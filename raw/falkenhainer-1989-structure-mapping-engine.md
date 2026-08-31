# falkenhainer-1989-structure-mapping-engine

> Converted from `falkenhainer-1989-structure-mapping-engine.pdf` on 2026-08-31 via `pymupdf4llm`.
> Layout artefacts (broken equations, interleaved columns) are conversion noise, not the source.

---

# The Structure-Mapping Engine: Algorithm and Examples

Brian Falkenhainer
Qualitative Reasoning Group
Department of Computer Science

Kenneth D . Forbus
Qualitative Reasoning Group
Department of Computer Science

Dedre Gentner
Psychology Department

**Abstract**

This paper describes the _Structure-Mapping Engine_ **(SME),** **a program for studying analogical**
**processing** **.** **SME** **has been built to explore Gentner's** _Structure-mapping theory_ _of analogy, and_
_provides a "tool kit" for constructing matching algorithms consistent with this theory. Its_
_flexibility enhances cognitive simulation studies by simplifying experimentation . Furthermore,_

**SME** **is very efficient, making it a useful component in machine learning systems as well** **. We**
**review the Structure-mapping theory and describe the design of the engine . We analyze the**

**complexity of the algorithm, and demonstrate that most of the steps are polynomial, typically**
**bounded by** _0 (N2_ _) ._ _Next we demonstrate some examples of its operation taken from our_
_cognitive simulation studies and work in machine learning_ _. Finally, we compare_ **SME** **to other**
**analogy programs and discuss several areas for future work.**

This paper appeared in
_Artificial Intelligence,_ _41,_ _1989, pp 1-63._

_For more information, please contact_

_forbus@ils_ _.nwu .edu_

_The Structure-Mapping Engine_ _1_

#### **1 Introduction**

In analogy, a given situation is understood by comparison with another similar situation . Analogy
may be used to guide reasoning, to generate conjectures about an unfamiliar domain, or to generalize
several experiences into an abstract schema . Consequently, analogy is of great interest to both
cognitive psychologists and artificial intelligence researchers . Psychologists wish to clarify the
mechanisms underlying analogy in order to understand human learning and reasoning . Artificial

Intelligence researchers wish to emulate analogical processing on computers to produce more flexible
reasoning and learning systems.

This paper describes the _Structure-Mapping Engine_ (SME), a program built to explore the computational aspects of Gentner 's _Structure-mapping theory_ _of analogical processing [27,29]_ _._ **SME** **has**
**been used both as a cognitive simulation of human analogical processing and as a component in a**
**larger machine learning system.**

SME is both flexible and efficient . It constructs all consistent ways to interpret a potential analogy
and does so without backtracking . **SME** **provides a "tool kit" for building matchers satisfying the**
**structural consistency constraint of Gentner's theory . The rest of the constraints definining a**
**matcher are specified by a collection of rules, which indicate local, partial matches and estimate**
**how strongly they should be believed . The program uses these estimates and a novel procedure for**
**combining the local matches to efficiently produce and evaluate all consistent global matches.**

Cognitive simulation studies can offer important insights for understanding the human mind.
They serve to verify psychological theories and supply a detailed vocabulary for describing cognitive
processes . Cognitive simulations can provide "idealized subjects", whose prior knowledge and set of

available processes is completely known to the experimenter . Unfortunately, cognitive simulations
tend to be complex and computationally expensive (c .f. [2,67] . Complexity can obscure the
relationship between the theory and the program . While all design decisions affect a program's
performance, not all of them are directly motivated by the theory being tested . To assign credit
properly (or to model performance in detail) requires exploring a space of similar architectures.

Such explorations are very difficult if the major way to change the program's operation is surgery
on the code. Complex programs also tend to be computationally expensive, which usually means
fewer experiments are performed and fewer possibilities are explored . While there have been several
important AI programs that study computational aspects of analogy (e .g ., [5,73,74], they were not
designed to satisfy the above criteria.

Over the last decade there have been a variety of programs that simulate different aspects of
analogical processing (as reviewed in Section 5) . However, the progress to date has been disappointingly slow . Often papers describe programs that work on only a handful of carefully chosen
examples, and do not specify the algorithms in a replicable fashion . We believe the difficulty has
been in part the lack of a good problem decomposition . Without some theoretically motivated
decomposition of analogy, it is easy to merge distinct problems, and become lost in the space of
possible mechanisms . Our decomposition, described in the next section, is psychologically motivated . Roughly, **SME** **focuses on the** _mapping_ _process in analogy, leaving the_ _access_ _and_ _application_

_aspects to future studies_ _. The power of the program and its success on a wide variety of examples_
_(over 40 as of this writing) provides additional evidence that the decomposition is a good one._

This paper examines the architecture of the Structure-Mapping Engine and how it has been used
for machine learning and cognitive simulation . First, we review Gentner's Structure-mapping theory

and some of the psychological evidence for it . Next we discuss the organization of **SME,** **including**

_The Structure-Mapping Engine_ _2_

knowledge representation conventions and the algorithm . After a complexity analysis, we then
illustrate SME's operation on several examples drawn from machine learning and cognitive simulation
studies . Related work in both AI and psychology is reviewed next, followed by a discussion of future
work.

### 2 Structure-mapping Theory

The theoretical framework for this research is Gentner's Structure-mapping theory of analogy

[27,28,29,30,31,32] . Structure-mapping describes the set of implicit constraints by which people
interpret analogy and similarity. The central idea is that an analogy is a mapping of knowledge
from one domain (the base) into another (the target) which conveys that a system of relations
known to hold in the base also holds in the target . The target objects do not have to resemble their
corresponding base objects . Objects are placed in correspondence by virtue of corresponding roles
in the common relational structure.

This structural view of analogy is based on the intuition that analogies are about relations,
rather than simple features . No matter what kind of knowledge (causal models, plans, stories,
etc.), it is the structural properties (i .e ., the interrelationships between the facts) that determine
the content of an analogy . For example, consider the water flow and heat flow situations shown in

Figure 1 . These situations are thought to be analogous because they share the complex relationship
known as "flow" . In each, we have a rough picture of something flowing downhill, from a source
to a destination . We prefer to ignore the appearances and even specific defining properties of the
objects, such as the fact that water and coffee are both liquids . Indeed, focusing on these attributes
tends to confuse our picture of the analogy.

**2 .1** **Subprocesses in analogy**

Structure-mapping decomposes analogical processing into three stages ([33,26,30], see also [9,10,39,48]:

_1._ _Access_ _:_ _Given a current_ _target situation, retrieve from long-term memory another description,_
_the_ _base,_ _which is analogous or similar to the target._

_2._ _Mapping and Inference :_ _Construct a mapping consisting of correspondences between the_
_base and target . This mapping can include additional knowledge in the base that can be_
_transferred to the target . These are the_ _candidate inferences sanctioned by the analogy._

_3._ _Evaluation and Use_ _:_ _Estimate the "quality" of the match . Three kinds of criteria are involved_

_[30,31] . The_ _structural_ _criteria include the number of similarities and differences, the degree_
_of structural similarity involved, and the amount and type of new knowledge the analogy_
_provides via the candidate inferences_ _. The second criteria concerns the_ _validity_ _of the match_
_and the inferences it sanctions . The inferences must be checked against current world knowl-_
_edge to ensure that the analogy at least makes sense, and may require additional inferential_
_work to refine the results . The third criteria is_ _relevance, i_ _.e.,_ _whether or not the analogy is_

_useful to the reasoner's current purposes_ _. Structure-mapping focuses on structural criteria_
_only, since they define and distinguish analogy from other kinds of inference._

The Structure-Mapping Engine emulates the mapping stage of analogy and provides a structural, domain-independent evaluation of the match. While we believe it can be used to model

_The Structure-Mapping Engine_ _3_

access, and provides useful results for accounts of evaluation and use (see [16,17], we will ignore
these issues for most of this paper.

**2 .2** **Constraints on Analogy**

Structure-mapping defines similarity in terms of matches between the internal structures of the descriptions being compared . Consequently, we need some terminology for describing such structures.

Section 3 .1 will introduce several formal descriptions . Here we provide some motivating intuitions.
Consider a propositional statement, like

```
   CAUSE[GREATER-THAN(x,y), BREAK(x)]

```

The chief relation involved in this statement is CAUSE, and its arguments are GREATER-THAN(x,y)
```
and BREAK(x) . We can view this statement in the usual way as a tree, i .e ., the root of the tree
is a node whose label is the predicate CAUSE and the root's children are nodes representing the
relation's arguments (Figure 2 provides an example of this view) . This view is useful in understanding Structure-mapping because it provides a spatial metaphor for collections of statements.
For instance, we can say that the arguments are "below" the CAUSE statement in the internal structure of the description, and describe a collection of statements with logical constraints between
them (explicitly represented by statements involving logical connectives and/or relationships) as a
"connected" system of relations.
```

One formal definition is needed before proceeding . We define the _order_ _of an item in a repre-_
_sentation as follows : Objects and constants are order O . The order of a predicate is one plus the_
_maximum of the order of its arguments_ _. Thus_ **GREATER-THAN** **(x, y) is** **first-order if x and y are**
```
objects, and CAUSE [GREATER-THAN (x, y), BREAK (x) ] is second-order . Examples of higher-order
```

**relations include** **CAUSE** **and** **IMPLIES** **.** **This definition of order should** _not_ _be confused with the_
_standard definition of the order of a logic .' Using the tree view of statements, this definition of_
_order indicates how deep the structure is below an item_ _. Notice that intricate explanations with_

' Under the standard definition, a logic is first-order if variables only range over objects and second-order when it
permits variables to range over predicates as well .

_The Structure-Mapping Engine_ _4_

many layers of justifications can give rise to representation structures of high order, since there will
be a high degree of nesting.

Let {S i }, {Ti } denote the items in the base and target representations, respectively . Let the

```
subsets {bz},{tz} denote the objects in the base and target, respectively . The tacit constraints on
the analogical mapping M can be characterized as follows:

```

1 . Objects in the base are placed in correspondence with objects in the target:

M : bz - t2

2. Isolated object descriptions are discarded unless they are involved in a larger relational structure.

e .g . RED(b) + RED(t)

3. Relations between objects in the base tend to be mapped across:

e .g . COLLIDE (bz, bj ) —p COLLIDE (t i, t j )

4. The particular relations mapped are determined by _systematicity,_ _as defined by the existence_
_of higher-order constraining relations which can themselves be mapped:_

e .g . CAUSE [PUSH (bz, bj ), COLLIDE (b j, b k ) ]
```
       CAUSE[PUSH(tz,t j ),COLLIDE(t j,t k )]

```

We require M to be _one-to-one :_ _that is, no base item maps to two target items and no target_
_item maps to two base items_ _. Furthermore, we require M to be_ _structurally consistent ._ _This means_
_that, in addition to being 1 :1, if M maps Bz onto_ Tj, then it must also map the arguments of Bz onto
```
the corresponding arguments of Tj .
```

Consider for example a simple analogy between heat-flow and water-flow . Figure 2 shows a
simplified version of what a learner might know about the situations pictured in Figure 1 . In order
to comprehend the analogy "Heat is like water" a learner must do the following (although not
necessarily in this order):

1. Set up the object correspondences between the two domains:

```
        water — heat, pipe — bar, beaker — coffee, vial ice-cube

```

2. Discard object attributes, such as **LIQUID (water) .**

3. Map base relations such as

```
     GREATER-THAN[PRESSURE(beaker), PRESSURE(vial)]

```

to the corresponding relations in the target domain .

_The Structure-Mapping Engine_ _5_

Figure 2 : Simplified water flow and heat flow descriptions.

4. Observe systematicity: i .e., keep relations belonging to a systematic relational structure in
preference to isolated relationships . In this example,

```
     CAUSE(GREATER-THAN[PRESSURE(beaker), PRESSURE(vial)],
         FLOW(beaker, vial, water, pipe))

```

is mapped into

```
     CAUSE(GREATER-THAN[TEMPERATURE(coffee), TEMPERATURE(ice-cube)],
         FLOW(coffee, ice-cube, heat, bar))

```

while isolated relations, such as

```
     GREATER-THAN[DIAMETER(beaker), DIAMETER(vial)]

   are discarded.

```

The _systematicity_ _principle is central to analogy . Analogy conveys a system of connected knowl-_
_edge, not a mere assortment of independent facts . Preferring systems of predicates that contain_
_higher-order relations with inferential import is a structural expression of this tacit preference for_
_coherence and deductive power in analogy. Thus, it is the amount of common higher-order re-_
_lational structure that determines which of several possible matches is preferred . For example,_
_suppose in the previous example we were concerned with objects differing in specific heat, such as_

_a metal ball-bearing and a marble of equal mass, rather than temperatures . Then_ DIAMETER would
```
enter the mapping instead of (or in addition to) PRESSURE, since DIAMETER affects the capacity of
a container, the analogue to specific heat .

```

_The Structure-Mapping Engine_ _6_

**2 .3 Other** **types of similarity**

In addition to analogy, the distinctions introduced by Structure-mapping theory provide definitions
for several other kinds of similarity . In all cases, we require one-to-one, structurally consistent
mappings . As we have seen, in _analogy_ _only relational structures are mapped. Aspects of object_
_descriptions which play no role in the relational structure are ignored. By contrast, in_ _literal sim-_

_ilarity_ _both relational predicates and object-descriptions are mapped_ _._ _2_ _Literal similarity typically_
_occurs in within-domain comparisons, in which the objects involved look alike as well as act alike._
_An example of a literal similarity is the comparison "Kool-Aid is like juice_ _." In_ _mere-appearance_
_matches, it is primarily the object-descriptions which are mapped, as in the metaphor_

"The road is like a silver ribbon"

A fourth kind of mapping is the _abstraction mapping ._ _Here, the entities in the base domain_
_are variables, rather than objects_ _. Few, if any, attributes exist that do not contribute to the base's_
_relational structure . Applying an abstraction match is very close to the instantiation of a rule . The_
_difference is that only entities may be variables, whereas in many pattern-directed rule systems_
_predicates may be used in substitutions as well._

**2 .4** **Empirical evidence**

Although the focus of this paper is on computational modeling, two sets of psychological findings

are particularly relevant . First, empirical psychological studies have borne out the prediction that
systematicity is a key element of people's implicit rules for analogical mapping . Adults focus on
shared systematic relational structure in interpreting analogy . They tend to include relations and
omit attributes in their interpretations of analogy, and they judge analogies as more sound and more

apt if base and target share systematic relational structure [27,33,34] . In developmental work, it has
been found that eight-year olds (but not five-year olds) are better at performing difficult mappings
when the base structure is systematic [35] . Second, there is also empirical evidence that the
different types of similarity comparisons defined by Structure-mapping have different psychological
properties [29,30,31].

### 3 The Structure-Mapping Engine

A simulation of Gentner's theory has been implemented in the Structure-Mapping Engine (SME).

Given descriptions of a base and target, SME constructs all structurally consistent mappings between
them. The mappings consist of pairwise matches between statements and entities in the base

and target, plus the set of analogical inferences sanctioned by the mapping . SME also provides
a structural evaluation score for each mapping according to the constraints of systematicity and
structural consistency . For example, given the descriptions of water flow and heat flow shown in

Figure 2, **SME** **would offer several alternative interpretations** **. In one interpretation, the central**
**inference is that water flowing from the beaker to the vial corresponds to heat flowing from the**
**coffee to the ice cube . Alternatively, one could map water to coffee, since they are both liquids.**

2 Notice that our structural characterization of literal similarity differs from some other psychological approaches
(e .g ., [63]) .

_The Structure-Mapping Engine_ _7_

The first interpretation has a higher structural evaluation score than the second, since a larger
relational structure can be mapped.

Importantly, SME is not a single matcher, but a simulator for a class of matchers . The Structuremapping notion of structural consistency is built into the system . However, what local elements can
match and how these combinations are scored can be changed by implementing new _match rules_
_that govern what pairwise matches between predicates are allowable and provide local measures of_
_evidence_ _. Thus, for example, SME can be used to simulate all the similarity comparisons sanctioned_
_by Structure-mapping theory, not just analogy . Since the match rules can include arbitrary lisp_
_code, it is possible to implement many other kinds of matchers as well._

This section describes the SME algorithm in sufficient detail to allow replication . We start by
specifying some simple conventions for knowledge representation which are essential to understanding the algorithm.

**3 .1** **Representation conventions**

We make as few representational assumptions as possible so that SME remains domain-independent.
We use a typed (higher-order, in the standard sense) predicate calculus to represent facts . The
constructs of this language are:

**Entities** **:** **Individuals and constants.**

**Predicates :** **There are three types :** _functions, attributes,_ _and_ _relations_ _._ _Each is described below._

_Dgroup_ _:_ _A description group is_ _a collection of entities and facts about them, considered as a unit._

_We examine each construct in turn._

**3** **.1 .1 Entities**

Entities are logical individuals, i .e ., the objects and constants of a domain . Typical entities include
physical objects, their temperature, and the substance they are made of. Primitive entities are the
tokens or constants of a description and are declared with the def Entity form:

(defEntity _(name)_

_[ :type_ _(EntityType)]_

_[ :constant? {t I nil}] )_

Entities can also be specified in the usual way by compound terms, i .e . the term (Pressure
We1132) refers to a quantity.

The : type option establishes a hierarchy of entity types . For example, we state that our sun is
a particular instance of a star with

(defEntity sun :type Star)

Constants are declared by using the :constant? option, as in

(defEntity zero :type number :constant? t)

_The Structure-Mapping Engine_ _8_

**3** **.1 .2 Predicates**

Classically, "predicate" refers to any functor in a predicate calculus statement . We divide predicates
into three categories:

**Functions** **Functions map one or more entities into another entity or constant . For example,**
```
   (PRESSURE piston) maps the physical object piston into the quantity which describes its
   pressure . We treat functions whose range are truth values as relations (see below), rather than
   functions . Consequently, Structure-mapping treats functions differently from other types of
   predicates . It allows substitution of functions to acknowledge their role as an indirect way of
   referring to entities.

```

**Attributes** **An attribute describes some property of an entity. Examples of attributes include**
```
   RED and CIRCLE . We restrict attributes to take only one argument – if there are multiple
```

arguments we classify the predicate as a relation . It is well-known that a combination of a
function and a constant is logically equivalent to an attribute . For example,

```
     (RED BlockA)
```

and
```
     (_ (COLOR BlockA) RED)

```

are logically equivalent . However, these two forms do not behave identically under Structuremapping . We assume that a reasoner has a particular piece of information represented in one
form or another, but not both, at any particular time (we return to this issue in Section 6 .1).

**Relations** **Like attributes, relations range over truth values . Relations always have multiple argu-**

**ments, and the arguments can be other predicates as well as entities** **. (However, we classify**
**logical connectives, regardless of the number of arguments, as relations .) Examples of rela-**
**tions include** **CAUSE, GREATER-THAN,** **and** **IMPLIES.**

Predicates are declared with the def Predicate form . It has several options:

(defPredicate _(Name) (ArgumentDeclarations) (PredicateType)_

_:expression-type_ _(DefinedType)_

[ :commutative? {t I nil}]

[ :n-ary? {t I nil}] )

_(PredicateType) is either function, attribute, or relation, according to what kind of predicate_
_(Name) is_ _._ _The_ _(ArgumentDeclarations)_ _specifies the predicate's arity and allows the arguments_
_to be named and typed. For_ _example, the_ _declaration:_

**(defPredicate** **CAUSE** **((antecedent sevent) (consequent sevent)) relation)**

states that **CAUSE is** **a two-place relational predicate** **. Its arguments are called antecedent and**
```
consequent, both of type sevent . (We use sevent to mean the union of states and events .) The
names and types of arguments are for the convenience of the representation builder, and are not

```

_The Structure-Mapping Engine_ _9_

currently used by SME . However, the predicate type is very important to the algorithms, as we will
see below.

The optional declarations :commutative? and :n-ary? provide SME with important syntactic
information . : commutative? indicates that the predicate is commutative, and thus the order of
arguments is unimportant when matching . : n-ary? indicates that the predicate can take any
number of arguments . Declaring n-ary predicates reduces the need for applying associativity to
binary predicates [62] . Examples of commutative n-ary predicates include AND, OR, and SUM . Making
these distinctions allows SME to

**3** **.1 .3 Expressions and Dgroups**

For simplicity, predicate instances and compound terms are called expressions . _A Description_

_Group,_ _or_ _dgroup, is_ _a collection of primitive entities and expressions concerning them . Dgroups_
_are defined with the defDescription form:_

**(defDescription** _(DescriptionName)_

**entities** _((Entity ]. ), (Entity_ _2_ _),_ _._ _._ _., (Entityz) )_
_expressions_ _((ExpressionDeclarations)))_

where _(ExpressionDeclarations)_ _take the form_

_(expression)_ _or_
_((expression)_ _: name_ _(ExpressionName) )_

The :name option is provided for convenience ; _(expression)_ _will be substituted for every occurrence_
_of_ _(ExpressionName)_ _in the dgroup's expressions when the dgroup is created_ _. For example, the_
_description of water flow depicted in Figure 2 was given to_ SME as

**(defDescription simple-water-flow**

**entities** **(water beaker vial pipe)**
expressions (((flow beaker vial water pipe) :name wflow)
((pressure beaker) :name pressure-beaker)
((pressure vial) :name pressure-vial)
((greater pressure-beaker pressure-vial) :name >pressure)
((greater (diameter beaker) (diameter vial)) :name >diameter)
((cause >pressure wflow) :name cause-flow)
(flat-top water)
(liquid water)))

The description of heat flow depicted in Figure 2 was given to SME as

(defDescription simple-heat-flow

entities (coffee ice-cube bar heat)
expressions (((flow coffee ice-cube heat bar) :name hflow)
((temperature coffee) :name temp-coffee)
((temperature ice-cube) :name temp-ice-cube)

_The Structure-Mapping Engine_ _10_

((greater temp-coffee temp-ice-cube) :name >temperature)
(flat-top coffee)
(liquid coffee)) )

Notice that each expression does not need to be declared explicitly ; for example, SME will automatically create and name expressions corresponding to (diameter beaker) and (diameter vial) in
the water flow description.

We will refer to the expressions and entities in a dgroup collectively as _items ._ _To describe the_

SME algorithm we need some terminology to express the structural relations between items . These
relationships form directed acyclic graphs, so we adopt some standard graph-theory terminology.

Each item corresponds to a vertex in a graph . When item _Ii_ _has_ _I,_ _as an argument, there will be_
_a directed arc from the node corresponding to_ _Iz_ _to the node corresponding to 1_ j . The _offspring of_
_an expression are its arguments. By definition, primitive entities (i .e ., those denoted by constants)_
_have no offspring . Expressions which name entities by compound terms are treated like any other_
_item. An item I_ l which is in the transitive closure (arguments _of arguments, etc .)_ _of another item_

_1_ 2 is said to be _a descendant of 1_ 2 _,_ _while 1_ 2 is said to be an _ancestor of I_ l _._ _An item with no_
_ancestors is called a_ _root._ _The term_ _Reachable(I)_ _refers to the transitive closure_ _of the subgraph_
_starting at_ _I_ _._ _We define the_ **_depth_** _of an item with respect to_ _Reachable(I)_ _by the minimum number_
_of_ _arcs it takes to reach the item starting from I._

**3 .2 The** **SME Algorithm : Overview**

Given descriptions _of_ _a base and a target, represented as dgroups,_ SME builds all structurally
consistent interpretations _of_ _the comparison between them_ _. Each interpretation_ _of_ _the match is_
_called_ _a global mapping,_ _or_ _gmap_ _._ _3_ _Gmaps consist_ _of_ _three parts:_

_1._ _Correspondences :_ _A set_ _of_ _pairwise matches between the expressions and entities_ _of the two_
_dgroups._

_2._ _Candidate Inferences :_ _A set_ _of new expressions which the comparison suggests holds in the_
_target dgroup._

_3._ _Structural Evaluation Score :_ _(Called_ _SES for brevity) A numerical estimate_ _of match quality_
_based on the gmap's structural properties._

Following the Structure-mapping theory, we use only purely structural criteria to construct and
evaluate the mappings . SME has no other knowledge _of either base or target domain . Neither rules_
_of_ _inference nor even logical connectives themselves are built into the algorithm . Each candidate_
_inference must be interpreted as a surmise, rather than a logically valid conclusion_ _. The SES reflects_
_the aesthetics_ _of the particular type_ _of comparison, not validity or potential usefulness . Testing the_
_validity_ _of_ _candidate inferences and determining the utility_ _of_ _a match are left to other modules,_

_as described in Section 2._

_Match rules specify what pairwise matches are possible and provide measures_ _of quality used in_
_computing the SES. These rules are the key to_ SME's flexibility. To build a new matcher one simply

3 The definition of gmap is inspired in part by de Kleer's work on assumption-based truth maintenance, although
we do not use an ATMS in the actual code . The idea of combining local solutions by constructing maximally
consistent sets is analogous to the process of interpretation construction in an ATMS . We also find bit-vectors a useful
implementation technique for the set operations needed to maintain structural consistency .

_The Structure-Mapping Engine_ _11_

loads a new set of match rules . This has several important advantages . First, we can simulate all
of the similarity comparisons sanctioned by Structure-mapping theory with one program . Second,
we could in theory "tune" the rules if needed to simulate particular kinds of human performance

(although, importantly, this flexibility has not been needed so far!) . Third, we can also simulate a
number of other analogy systems (including [40,73], as described below) for comparison purposes.

Conceptually, the SME algorithm is divided into four stages:

_1._ _Local match construction :_ _Finds all pairs of ((Baseltem), (Targetltem))_ _that potentially can_
_match ._ _A Match Hypothesis is_ _created for each such pair to represent the possibility that this_
_local match is part of a global match._

_2._ _Gmap construction :_ _Combines the local matches into maximal consistent collections of cor-_
_respondences._

_3._ _Candidate inference construction_ _:_ _Derives the inferences suggested by each gmap._

_4._ _Match Evaluation :_ _Attaches evidence to each local match hypothesis and uses this evidence_
_to compute structural evaluation scores for each gmap._

We now describe each computation in detail, using a simple example to illustrate their operation.

3 .2 .1 Step 1: Local match construction

Given two dgroups, SME begins by finding potential matches between items in the base and target
(see Figure 3) . Allowable matches are specified by _match constructor_ _rules, which take the form:_

(MHCrule _((Trigger) (BaseV ariable) (TargetVariable)_

_:test_ _(TestForm)J)_
_(Body) )_

In all match constructor rules, _(Body) will be executed in an environment in which_ _(BaseVariable)_
_and_ _(TargetVariable)_ _are bound to items from the base and target dgroups, respectively . If_
_(TestForm) is_ _present, the bindings must satisfy the test (i_ _.e ., the form when evaluated must_
_return non-NIL_ _. There are two possible values for_ _(TestForm)_ _._ _A_ _:filter trigger indicates that_
_the rule is applied to each pair of items from the base and target_ _. These rules create an initial set_
_of match hypotheses between individual base and target expressions . For example, the following_
_rule hypothesizes a match between any two expressions that have the same functor:_

###### (MHCrule ( :filter ?b ?t :test (equal (expression-functor ?b)

(expression-functor ?t)))
(install-MH ?b ?t))

An : intern trigger indicates that the rule should be run on each newly created match hypothesis, binding the variables to its base and target items . These rules create additional matches
suggested by the given match hypothesis. For example, hypothesizing matches between every pair
of entities would lead to combinatorial explosions . Instead, we can use an : intern rule to create
match hypotheses between entities in corresponding argument positions of other match hypotheses,
since these correspondences will be required for structural consistency .

_The Structure-Mapping Engine_ _12_

Figure 3 : Local Match Construction . The graphs corresponding to the water flow and heat flow
descriptions of Figure 2 are depicted on the left and right panels, respectively . The squares and
triangles in the middle represent the match hypotheses created by the literal similarity rules for
these dgroups . The dashed arrows indicate which base and target items are conjectured as matching
by each match hypothesis . The squares represent match hypotheses involving expressions, while the
triangles represent match hypotheses involving entities . Notice how sparse the match is . Expression
matches are only created when relations are identical, and matches between functions and entities

are only created to support expression matches . This "middle out" local match computation
provides SME with much of its power.

Appendix A lists the rule sets used to implement each similarity comparison of StructureMapping _(analogy, literal similarity,_ _and_ _mere appearance)_ _._ _Notice that each rule set is small and_
_simple (we describe the evidence rules below)_ _. The literal similarity rule set uses only three match_
_constructor rules. One rule is the filter rule shown above_ _. The other two are intern rules. The_
_content of the first is, roughly,_

"If the match hypothesis concerns two facts, then create match hypotheses between any
corresponding arguments that are both functions or entities ."

The second is a specialization of this which runs only on commutative predicates (i .e ., the _"corre-_
_sponding_ _arguments" condition is removed)_ _. The analogy rule set differs in that matches are created_
_between attributes only when they are part of some higher-order structure . The mere appearance_
_rule set differs by completely ignoring higher-order structure._

The result of running the match constructor rules is a collection of match hypotheses . We
denote the hypothesis that _bz_ _and_ _tj_ _match by_ _MH(bz, t_ _j )_ _._ _When no ambiguity will result, we_
_will simply say_ _MH ._ _We will use the same terminology to refer to the structural properties of_

_The Structure-Mapping Engine_ _13_

graphs of match hypotheses (offspring, descendants, ancestors, root) as we use for describing items
in dgroups . To wit, the collection of match hypotheses can be viewed as a directed acyclic graph,
with at least one (and possibly many) roots.

Example : Simple analogy between heat and water In this example we will use the _literal_

_similarity_ _rule set, rather than_ _analogy,_ _in order to better illustrate the algorithm_ _. The result of_
_running these rules on the water flow and heat flow dgroups of Figure 2 is shown in Figure 3 (see_

_also Figure 4)_ _. Each match hypothesis locally pairs an item from the base dgroup with an item_
_from the target dgroup._

There are several points to notice in Figure 4 . First, there can be more than one match hypothesis involving any particular base or target item . Here, TEMPERATURE can match with both
```
PRESSURE and DIAMETER, since there are corresponding matches between the GREATER-THAN expressions in both dgroups (MH-1 and MH-6) . Second, note that with the exception of functions,
predicates must match identically . Entities, on the other hand, are matched on the basis of their
roles in the predicate structure . Thus while TEMPERATURE can match either PRESSURE or DIAMETER,
GREATER cannot match anything but GREATER . This distinction reflects the fact that functions are
often used to refer to objects, which are fair game for substitution under analogy . Third, not every possible correspondence is created . We do not, for example, attempt to match TEMPERATURE
with water or heat with beaker . Functions only match with other functions ; and local matches
between entities are only created when justified by some other match . In general, this significantly
constrains the number of possible matches.

```

**3** **.2 .2 Step 2** **: Global Match Construction**

The second step in the SME algorithm combines local match hypotheses into collections of global
```
matches (gmaps) . Intuitively, each global match is the largest possible set of match hypotheses
that depend on the same one to one object correspondences.
```

More formally, gmaps consist of _maximal, structurally consistent_ _collections of match hypothe-_
_ses . A collection of match hypotheses is_ _structurally consistent_ _if it satisfies two constraints:_

_1._ _One-to-one_ _:_ _The match hypotheses in the collection do not assign the same base item to_
_multiple target items or any target item to multiple base items._

_2._ _Support :_ _If a match hypothesis_ MH is in the collection, then so are match hypotheses which
```
   pair up all of the arguments of MH's base and target items.

```

The one-to-one constraint allows straightforward substitutions in candidate inferences . The support
constraint preserves connected predicate structure . A collection is maximal if adding any additional
match hypothesis would render the collection structurally inconsistent.

Requiring structural consistency both reduces the number of possible global collections and helps
preserve the soundness and plausibility of the candidate inferences . Without it, every collection of
local matches would need to be considered, and effort would be wasted on degenerate many-to-one
mappings without any possible inferential value . The maximality condition also serves to reduce
the number of gmaps, since otherwise every subset of a gmap could itself be a gmap.

Global matches are built in two steps :

_The Structure-Mapping Engine_ _14_

Figure 4 : Water Flow / Heat Flow Analogy After Local Match Construction . Here we show
the graph of match hypotheses depicted schematically in Figure 3, augmented by links indicating
expression-to-arguments relationships . Match hypotheses which are not descended from others are
called _roots (e.g_ _.,_ _the matches between the_ _GREATER predicates,_ _Mil-1_ _and_ _MH-6,_ _and the match for_
_the predicate_ _FLOW,_ _MH-9)_ _._ _Match hypotheses between entities are called_ _Emaps (e .g_ _.,_ _the match_
_between beaker and coffee,_ _MH-4)_ _._ _Emaps play an important role in algorithms based on structural_
_consistency ._

_The Structure-Mapping Engine_ _15_

_1._ _Compute consistency relationships :_ _For each match hypothesis, generate (a) the set of entity_
_mappings it entails, (b) what match hypotheses it locally conflicts with, and (c) what match_
_hypotheses it is structurally inconsistent with._

_2._ _Merge match hypotheses :_ _Compute gmaps by successively combining match hypotheses as_
_follows:_

_(a)_ _Form initial combinations :_ _Form an initial set of gmaps from each maximal, structurally_

_consistent, connected subgraph of match hypotheses._

_(b)_ _Combine dependent gmaps :_ _Merge initial gmaps that have overlapping base structure,_
_subject to structural consistency._

_(c)_ _Combine independent collections :_ _Form maximal, complete gmaps by merging the partial_

_gmaps from the previous step, again subject to structural consistency._

Importantly, the process of gmap _construction is_ _completely independent of gmap_ _evaluation._
_Which gmaps are constructed depends solely on structural consistency . Numerical evidence, de-_
_scribed below, is used only to compare their relative merits._

We now describe the algorithm in detail.

**Computing consistency relationships** **Consistency checking is the crux of gmap construction.**
**Consequently, we compute for each match hypothesis (a) the entity mappings it entails and (b) the**
**set of match hypotheses it is inconsistent with.**

Consider a particular match hypothesis _MH(bz, tj )_ _involving base item_ _bz_ _and target item_
_tj ._ _If_ _bz, tj_ _are expressions, then by the support constraint the match hypotheses linking their_
_arguments must also be in any collection that_ _MH(bz, tj) is_ _in. Appying this constraint recursively,_
_all descendents of_ _MH(bz, t_ _j )_ _must be in the same collections if it is structurally consistent (see_
_Figure 5) . Since the chain of descendants ends with match hypotheses involving entities, each_
_match hypothesis implies a specific set of entity correspondences:_

**Definition 1 .** **An** _emap is_ _a match hypothesis between entities ._ _Emaps(MH(bz, tj ))_ _represents_
_the set of emaps implied by a match hypothesis_ _MH(bz, t_ _j ) . Emaps(MH(bz, tj)) is_ _simply the union_
_of the Emaps supported by_ _MH(bz, t_ _j)'s_ _descendants. We also include match hypotheses involving_
_functions in_ _Emaps(MH(bz, tj))._

To enforce one-to-one mappings we must associate with each _MH(bz, t_ _j )_ _the set of match hypotheses_
_that provide alternate mappings for for_ _bz_ _and_ _tj_ _._ _Clearly, no member of this set can be in the same_

_gmap with_ _MH(bz, t_ _j)._

**Definition 2 .** **Given a match hypothesis** _MH(bz, tj_ _),_ _the set_ _Conflicting(MH(bz, tj ))_ _consists of_
_the set of match hypotheses that represent the alternate mappings for_ _bz_ _and_ _tj_ _:_

###### _Con flicting(MH(bz, tj )) [ U b k Ebase{MH(bk ) tj) b k ~ bz}~ U_

_[_ _U_ <sup>_tkEtarget{MH(bi) tk) tk_</sup> ~ <sup>_t~}~_</sup>

_The Structure-Mapping Engine_ _16_

Figure 5 : Water Flow - Heat Flow analogy after computation of _Conflicting_ _relationships_ _. Simple_
_lines show the tree-like graph that the support constraint imposes upon match hypotheses_ _. Lines_
_with circular endpoints indicate the_ _Conflicting_ _relationships between matches . Some of the original_
_lines from MH construction have been left in to show the source of a few_ _Conflicting_ _relations._

The set _Conflicting(MH(bz, tj))_ _only notes local inconsistencies (see Figure 5)_ _. However, we_
_can use it and_ _Emaps(MH(bz_ _i tj ))_ _to recursively define the set of all match hypotheses that can_
_never be in the same gmap as_ _MH(bz i tj )._

**Definition 3 .** **The set** _NoGood(MHH)_ _is the set of all match hypotheses which can never appear_
_in the same gmap as_ _MHz_ _._ _This set is recursively defined as follows : if_ _MHz is_ _an emap, then_

_NoGood(MHH) = Conflicting(MHH_ _)_ _._ _Otherwise,_ _NoGood(MHH )_ _is the union of MHz_ _'s Conflict-_
_ing_ _set with the_ _NoGood_ _sets for all of its descendents, i .e .,_
##### _NoGood(MHH ) = Conflicting(MH H ) U U MH,EArge(mNop ood (MHj)_

We compute _Conflicting, Emaps,_ _and_ _No Good_ _sets as follows. First,_ _Conflicting is_ _computed_
_for each match hypothesis, since it requires only local information_ _. Second,_ _Emaps_ _and_ _No Good_

_are computed for each emap. Third,_ _Emaps_ _and_ _No Good_ _sets are computed for all other match_
_hypotheses by propagating the results from Emaps upwards to their ancestors._

We make two observations about this computation . First, these operations can be efficiently implemented via bit vectors . For example, SME assigns a unique bit position to each match hypothesis,

and carries out union and intersection operations by using OR and AND bit operations . Second, it is
important to look for _justification holes_ _in the match hypothesis graph — match hypotheses whose_

_arguments fail to match . Such match hypotheses will always violate the support constraint, and_

_The Structure-Mapping Engine_ _17_

hence should be removed . For example, if one of the PRESSURE - TEMPERATURE match hypotheses
```
had not been formed (see Figure 4), then the match between their governing GREATER predicates
would be removed . Notice that removing justification holes eliminates many blatantly incorrect
matches, such as trying to place an eighth-order IMPLIES in correspondence with a second-order
IMPLIES.
```

The next step in gmap construction is to identify those match hypotheses which are internally
inconsistent, and thus cannot be part of any gmap . This can happen when the descendents of a
match hypothesis imply mutually incompatible bindings.

**Definition 4 .** **A match hypothesis is** _inconsistent if the emaps of one subgraph of its descendants_
_conflicts with the emaps entailed by another subgraph of its descendants:_

_Inconsistent(MH_ _H_ _)_ _Emaps(MHH_ _)_ _n_ _NoGood(MHH_ _)_ ~ _0_

Clearly, every ancestor of an inconsistent match hypothesis is also inconsistent . By caching the
_No Good_ _sets, inconsistent match hypotheses can be identified easily._

Global match construction proceeds by collecting sets of consistent match hypotheses . Since
gmaps are defined to be maximal, we begin from roots and work downward rather than starting
bottom-up . If a root is consistent, then the entire structure under it must be consistent, and thus
forms an initial gmap . If the graph of match hypotheses had only a single consistent root, this
step would suffice. However, typically there are several roots, and hence several initial gmaps . To
obtain true gmaps, that is, _maximal collections of match hypotheses, these initial gmaps must then_
_be merged into larger, structurally consistent collections._

**Merge Step 1 : Form initial combinations** **.** **The first step is to combine interconnected and**

**consistent structures (Figure 6a)** **. Each consistent root, and its descendants, forms an initial**
**gmap . If a root is inconsistent, then the same procedure is applied recursively to each de-**
**scendant (i .e** **., each immediate descendant is now considered as a root)** **. The resulting set will**
**be called** _Gmaps_ l _._ _The procedure is:_

1 . Let _Gmaps_ l _= O._

2 . For every root _MH(bz, tj_ _)_

(a) If _—iInconsistent(MH(bz, tj )),_ _then create a gmap_ _GM_ _such that_

_Elements(GM) = Reachable(MH(bz, t j ))._

(b) If _Inconsistent(MH(bz, t_ _j )),_ _then recurse on_ _Ofspring(MH(bz, tj ))._

3 . For every _GM_ _E_ _Gmaps_ l _,_
_(a)_ _NoGood(GM)_ _=_ _UMx(bzitj)ERoots(GM)NoGood(MH(bij t;))_
###### _(b) Emaps(GM) = UMH(bz iyERoots(GM)Emaps (MH ( bi,tj ))_

In this step inconsistent match hypotheses have been completely eliminated . However, we do
not have true gmaps, since the sets of correspondences are not maximal. To obtain maximality,
elements of _Gmapsithat_ _are consistent with one another must be merged . Consistency between_
_two gmaps can be defined as follows:_
###### _Elements(GMapz) n NoGood(GMapj ) _ 0_

_Consistent(GMapz,GMapj ) i~"_
A _NoGood(GMapz)_ _n_ _Elements(GMapj_ _)_ _=_ _0_

_The Structure-Mapping Engine_ _18_

Figure 6 : Gmap Construction . (a) Merge step 1 : Interconnected and consistent . (b) Merge step

2 : Consistent members of the same base structure . (c) Merge step 3 : Any further consistent
combinations.

**Merge Step 2 : Combine connected gmaps .** **Consider two elements of** _Gmaps l_ _which share_

_base structure, i_ _.e., whose roots in the base structure are identical . Since we are assuming_
_distinct elements, either (a) their correspondences are structurally inconsistent or (b) there_
_is some structure in the base which connects them that does not appear in the target (if it_
_did, match hypotheses would have been created which would bring the two elements under a_
_common match hypothesis root, hence they would not be distinct)_ _. Combining such elements,_
_when consistent, leads to potential support for candidate inferences . We call the partial gmaps_

_resulting from this merge Gmaps_ _2 (Figure 6b)._

**Merge Step 3 : Combine independent collections .** **Consider two elements of** _Gmaps_ _l_ _which_

_have no overlap between their relational correspondences . Clearly, any such pair could be_
_merged without inconsistency, if they sanction consistent sets of emaps . This final step_
_generates all consistent combinations of gmaps from_ _Gmapsl_ _by successive unions, keeping_
_only those combinations that are maximal (Figure 6c)._

**Example : Simple analogy between heat and water** **Figure 6 shows how the gmaps are**
**formed from the collection of match hypotheses for the simple water-flow/heat-flow example** **. After**
**merge step 1, only isolated collections stemming from common roots exist** **. Merge step 2 combines**
**the** PRESSURE to TEMPERATURE mapping with the FLOW mapping, since they have common base
```
structure (i .e ., the base structure root is the CAUSE predication) . Finally, merge step 3 combines
the isolated water and coffee attributes (see Figure 7) . Notice that the FLOW mapping is structurally

```

_The Structure-Mapping Engine_ _19_

consistent with the DIAMETER to TEMPERATURE mapping . However, because merge step 2 placed the

FLOW mapping into the same gmap as the PRESSURE to TEMPERATURE mapping, merge step 3 was
unable to combine the FLOW mapping with the DIAMETER to TEMPERATURE gmap.

**3** **.2 .3 Step 3** **: Compute Candidate Inferences**

Each gmap represents a set of correspondences that can serve as an interpretation of the match.
For new knowledge to be generated about the target, there must be information from the base
which can be carried over into the target . Not just any information can be carried over — it must
be consistent with the substitutions imposed by the gmap, and it must be _structurally grounded_ _in_
_the gmap_ _. By structural grounding, we mean that its subexpressions must at some point intersect_
_the base information belonging to the gmap_ _. Such structures form the_ _candidate inferences_ _of a_

_gmap._

To compute the candidate inferences for a gmap _GM,_ _SME begins by examining each root_ _B_ _R_
_in the base dgroup to see if it is an ancestor of any match hypothesis roots in the gmap_ _. If it is,_
_then any elements in_ _Descendants(B_ _R )_ _which are not in_ _Baseltems(GM)_ _are included in the set_
_of candidate inferences._

The candidate inferences often include entities . Whenever possible, SME replaces all occurrences
of base entities with their corresponding target entities . Sometimes, however, there will be base
entities that have no corresponding target entity ; i .e ., the base entity is not part of any match
hypothesis for that gmap . What SME does depends on the type of entity . If the base entity is a
constant, such as zero, it can be brought directly into the target unchanged (a flag is provided
to turn on this behavior) . Otherwise, SME introduces a new, hypothetical entity into the target
which is represented as a skolem function of the original base entity. Such entities are represented

as ( :skolem base-entity).

Recall that Structure-mapping does not guarantee that any candidate inference is valid . Each
candidate inference is only a surmise, which must be tested by other means . By theoretical assumption, general testing for validity and relevance is the province of other modules which use SME's
output . 4 However, SME does provide a weak consistency check based on purely structural consider
ations . In particular, it discards a candidate inference when (a) the predicate is non-commutatitive
and (b) its arguments are simply a permuted version of the arguments to another expression involving that predicate in the target domain . For example, if (GREATER (MASS sun) (MASS planet) )
existed in the target, (GREATER (MASS planet) (MASS sun)) would be discarded as a candidate
inference.

Example : Simple analogy between heat and water In Figure 7, gmap #1 has the top level

CAUSE predicate as its sole candidate inference . In other words, this gmap suggests that the cause
of the flow in the heat dgroup is the difference in temperatures.

Suppose the FLOW predicate was missing in the target dgroup . Then the candidate inferences for
a gmap corresponding to the pressure inequality would include expressions involving both CAUSE
and FLOW, as well as conjectured target entities corresponding to water (heat) and pipe (bar).
The two skolemized entities would be required because the FLOW match provides the match from
water and pipe to heat and bar, respectively . Note also that GREATER-THAN [DIAMETER(coffee),

**4** **One such module is described in [16,17]** **.**

_The Structure-Mapping Engine_ _20_

```
 Rule File : literal-similarity .rules Number of Match Hypotheses : 14

 Match Hypotheses:

   (0 .6500 0 .0000) (>PRESSURE >TEMP)
   (0 .7120 0 .0000) (PRESS-BEAKER TEMP-COFFEE)
   (0 .7120 0 .0000) (PRESS-VIAL TEMP-ICE-CUBE)
   (0 .9318 0 .0000) (BEAKER-6 COFFEE-1)
   (0 .6320 0 .0000) (PIPE-8 BAR-3)
```

      -       - 0

      -       - 0

```
 Global Mappings:

  Gmap #1 : (>PRESSURE >TEMPERATURE) (PRESSURE-BEAKER TEMP-COFFEE)
         (PRESSURE-VIAL TEMP-ICE-CUBE) (WFLOW HFLOW)
     Emaps : (beaker coffee) (vial ice-cube) (water heat) (pipe bar)
     Weight : 5 .99
     Candidate Inferences : (CAUSE >TEMPERATURE HFLOW)

  Gmap #2 : (>DIAMETER >TEMPERATURE) (DIAMETER-1 TEMP-COFFEE)
         (DIAMETER-2 TEMP-ICE-CUBE)
     Emaps : (beaker coffee) (vial ice-cube)
     Weight : 3 .94
     Candidate Inferences:

  Gmap #3 : (LIQUID-3 LIQUID-5) (FLAT-TOP-4 FLAT-TOP-6)
     Emaps : (water coffee)
     Weight : 2 .44
     Candidate Inferences:

```

Figure 7 : Complete SME interpretation of Water Flow - Heat Flow Analogy.

```
DIAMETER(ice cube) ] is not a valid candidate inference for the first gmap because it does not
intersect the existing gmap structure.

```

**3** **.2 .4 Step 4** **: Compute Structural Evaluation Scores**

Typically a particular base and target pair will give rise to several gmaps, each representing a different interpretation . Selecting the "best" interpretation of an analogy, as mentioned previously, can
involve non-structural critera . However, as the psychological results indicated, evaluation includes

an important structural component . SME provides a programmable mechanism for computing a
_structural evaluation score_ _(SES) for each gmap . This score can be used to rank-order the gmaps_
_or as a factor in some external evaluation procedure._

The structural evaluation score is computed in two phases, each using _match evidence rules_ _to_
_assign and manage numerical scores_ _. The first phase assigns weights to individual match hypotheses,_

_The Structure-Mapping Engine_ _21_

and the second phase computes a score for each gmap by combining the evidence for the match
hypotheses comprising its correspondences . After a brief introduction to the evidence processing
mechanism, we describe each phase in turn.

The management of numerical evidence is performed by _a_ _Belief Maintenance System_ _(BMS)_

_[15] . The BMS is much like a standard TMS, using horn clauses as justifications. However, the_
_justifications are annotated with evidential weights, so that "degrees of belief" may be propagated._

_A modified version of Dempster-Shafer formalism is used for expressing and combining evidence._
```
Belief in a proposition is expressed by the pair (s (A), s (—i A) ), where s (A) represents the current
amount of support for A and s(— A) is the current support against A . A simplified form of Dempster's rule of combination [60,53,37,15] allows combining evidence from multiple justifications . For
example, given that Belief (A)=(0 .4, 0) and Belief (B)=(0 .6, 0), together with (IMPLIES A
C) (0 .8 0 ) and (IMPLIES B C) (1 0), Dempster ' s rule provides a belief in C equal to (0 .728, 0 .0) . In
addition to providing evidence combination, these justifications provide useful explanations about
the structural evaluation (see [15]).
  Two caveats about the role of numerical evidence in SME : (1) While we have found DempsterShafer useful, our algorithms are independent of its details, and should work with any reasonable
formalism for combining evidence . (2) We use numerical evidence to provide a simple way to
combine local information . These weights have nothing to do with any probabilistic or evidential
information about the base or target per se.

```

**Assigning local evidence** **Each match hypothesis and gmap has an associated BMS node to**
**record evidential information . The match evidence rules can add evidence directly to a match**
**hypothesis based on its local properties or indirectly by installing relationships between them.**

**Syntactically, these rules are similar to the match constructor rules . For example,**

(assert! 'same-functor)
(rule (( :intern (MH ?b ?t) :test (and (expression? ?b) (expression? ?t)

**(eq (expression-functor ?b)**

**(expression-functor ?t)))))**
```
    (assert! (implies same-functor (MH ?b ?t) (0 .5 . 0 .0))))

```

states that "if the base item and target item of a match hypothesis are expressions with the
same functors, then supply 0 .5 evidence in favor of the match hypothesis ." (The assertion of

same-functor provides a global record for explanatory purposes that this factor was considered
in the structural evaluation .) The complete set of evidence rules used in this paper are listed in
Appendix A.

The ability to install relationships between match hypotheses provides a simple, local implementation of the systematicity constraint . Recall that the systematicity constraint calls for prefering
expressions involving higher-order relationships belonging to a systematic structure over isolated
relationships . We implement this preference by passing evidence from a match involving a relationship to the matches involving its arguments . The following rule accomplishes this, propagating

80% of a match hypothesis' belief to its offspring:

(rule (( :intern (MH ?b1 ?t1))

( :intern (MH ?b2 ?t2) :test (children-of? ?b2 ?t2 ?b1 ?t1)))
```
    (assert! (implies (MH ?b1 ?t1) (MH ?b2 ?t2) (0 .8 . 0 .0))))

```

_The Structure-Mapping Engine_ _22_

The more matched structure that exists above a given match hypothesis, the more that hypothesis
will be believed . The effect cascades, so that entity mappings involved in a large systematic
structure receive much higher scores than those which are not . Thus this "trickle down" effect
provides a local encoding of the systematicity principle.

**Computing the Structural Evaluation Score** **The structural evaluation score for a gmap**
**is simply the sum of the evidence for its match hypotheses . While simplistic, summation has**
**sufficed for most of the examples encountered so far** **. There are a number of other factors that are**
**potentially relevant as well, which we discuss in Section 6** **.3 .1 . Consequently, to provide maximum**
**flexibility, evidence rules are used to compute the evidence of gmaps as well.**

Originally we combined evidence for gmaps according to Dempster's rule, so that the sum of
beliefs for all the gmaps equaled 1 [20] . We discovered two problems with this scheme . First,

Dempster's rule is susceptible to roundoff, which caused stability problems when a large number
of match hypotheses supported a gmap . Second, normalizing gmap evidence prevents us from
comparing matches using different base domains (as one would want to do for access experiments),
since the score would be a function of the other gmaps for a particular base and target pair.

**Example : Simple analogy between heat and water** **Returning to Figure 7, note that the**
**best interpretation (i .e., the one which has the highest structural evaluation score) is the one we**
**would intuitively expect . In this interpretation,** beaker maps to coffee, vial maps to ice-cube,
```
water maps to heat, pipe maps to bar, and PRESSURE maps to TEMPERATURE . Furthermore, we
have the candidate inference that the temperature difference is what causes the flow of heat.

```

**3 .3** **Complexity analysis**

Here we analyze the complexity of the SME algorithm . Because it depends critically on both the
```
input descriptions and the match rules, strict bounds are hard to determine . However, we give both
best and worst case analyses for each step, and provide estimates of typical performance based on
our experience . The decomposition used in the analysis is show in Figure 8 . We use the following
notation in the analysis:

```

_eb_ _Number of entities in the base dgroup._

_et_ _Number of entities in the target dgroup._

_3b_ _= Number of expressions in the base dgroup._

_3t_ _Number of expressions in the target dgroup._

_M = Number of match hypotheses._

J - Number of gmaps

_Nb_ = _eb+3b_
##### _Nt = et+3t_

_N_ _Nb+Nt_ 2

_The Structure-Mapping Engine_ _23_

```
  1 . Run MHC rules to construct match hypotheses.
```

**2** **. Calculate the** _Conflicting_ **set for each match hypothesis.**

**3** **. Calculate the** _EMaps_ and _NoGood_ sets for each match hypothesis by upward
```
   propagation from entity mappings.

  4 . Merge match hypotheses into gmaps.

    (a) Interconnected and consistent.

    (b) Consistent members of same base structure.

    (c) Any further consistent combinations.

  5 . Calculate the candidate inferences for each gmap.

  6 . Score the matches

    (a) Local match scores.
    (b) Global structural evaluation scores.

```

Figure 8 : Summary of SME algorithm.

###### **3 .3 .1 Analysis of Step # 1 : local match construction**

SME does not restrict either the number of match rules or their complexity . There is nothing to
prevent one from writing a rule that examines extensive information from external sources (e .g .,

a knowledge-base, plans, goals, etc .) . However, the rule sets which implement the comparisons of
Structure-mapping theory consist of only a few simple rules each . This reduction of computational
complexity is one of the advantages of the Structure-mapping account, since it restricts the tests
performed in rules to local properties of the representation . Consequently, we assume rule execution
takes unit time, and focus on the total number of rules executed . The :filter rules are run for
each pair of base and target predicates . Consequently, they will always require 0 _(Nb_ _* NO_ _._ _Each_

_: intern rule is run once on every match hypothesis . In the worst case,_ _M_ _= Nb_ _* Nt_ _,_ _or roughly_
_N_ 2 _._ _But in practice, the actual number of match hypotheses is substantially less, usually on the_
_order of cN,_ _where c is less than 5 and_ _N is_ _the average of_ _Nb_ _and_ _N_ <sup>_t_</sup> _._ _Thus, in practice,_ _: intern_
_rules have a run time of approximately 0(N)._

###### 3 .3 .2 Analysis of Step # 2 : Calculating Conflicting

Recall that SME assigns a _Conflicting_ _set to each match hypothesis,_ _MH(bz, t_ _j )_ _which represents_
_the alternate mappings for_ _bz_ _and_ _tj_ _._ _The conflicting sets are calculated by examining each base_

_and target item to gather the match hypotheses which mention them_ _. Let C be the average number_
_of alternative matches each item in the base and target appears in . SME loops through the C match_
_hypotheses twice_ _: once to form the bitwise union of these match hypotheses and once to update_
_each hypotheses'_ _Conflicting_ _set . Thus, the entire number of bit vector operations is_

_(3b*2C)+(eb*2C)+(3t_ _*2C)+(et*2C)_

_The Structure-Mapping Engine_ _24_

The worst case is when a match hypothesis is created between every base and target item . If
###### we also assume Nb = Nt, then C = Nt in that case . The number of operations becomes 4Nt 2

_or approximately_ _0(N_ _2 ) ._ _Conversely, the best case performance occurs when C is 1, producing_

_0(max(Nb, Nt))_ _operations_ _. In our experiments so far, we find that C is typically quite small, and_
_so far has always been less than 10 . Consequently, the typical performance lies between_ _0 (N)_ _and_

_0(N 2)._

###### _3.3 .3 Analysis of Step # 3 : Emaps and No Good calculation_

Recall that once the _Conflicting_ _sets are calculated, the_ _Emaps_ _and_ _NoGood sets are propagated_
_upwards from the entity mappings through the match hypotheses . By caching which_ _MH(bz, tj)'s_
_correspond to emaps and using a queue, we only operate on each node once_ _. Hence the worst and_
_best case performance of this operation is 0(M), which in the worst case is_ _0(N_ _2 )._

**3** **.3 .4** **Analysis** **of Step #** **4** **:** **Gmap** **construction**

Global matches are formed in three steps . The first step collects all of the consistent connected
components of match hypotheses by starting at the match hypothesis roots, walking downwards to
find consistent structures . Each graph walk takes at most _0(Nz),_ _where_ _Ni_ _is the number of nodes_

_Reachable_ _from the current match hypothesis root . If there are_ _NR_ _roots, then the first merge step_
_(Step 4(a)) takes_ _0 (NR * Ni ) ._ _Assuming that most of the match hypotheses will appear in only one_
_or two subgraphs (some roots may share substructure), we can approximate this by saying that the_
_first merge step is 0(M) . Call the number of partial gmaps formed at this stage 9P1._

Perhaps surprisingly, the complexity of the previous steps has been uniformly low . Sophisticated
matching computations usually have much worse performance, and SME cannot completely escape
this . In particular, the worst case for steps 4(b) and 4(c) is O (N!) (although worst-case for one
implies best-case for the other).

Step 4(b) combines partial gmaps from Step 4(a) that intersect the same base structure . This
requires looping through each base description root to find which partial gmaps intersect it, and then

generating every consistent, maximal combination of them . In the worst case, every gmap could
intersect the same base structure . This would mean generating all possible consistent, maximal
sets of gmaps, which is equivalent to Step 4(c), so we defer this part of the analysis until then . In
the other extreme, none of the gmaps share a common base structure, and so step 4(b) requires

0(9P1 2 ) operations, although this is not the best-case performance (see below) . Typically, the
second merge step is very quick and displays near best-case performance.

Step 4(c) completes gmap construction by generating all consistent combinations of the partial
gmaps, discarding those which are not maximal . The complexity of this final merge step is directly
related to the degree of structure in the base and target domains and how many different predicates

are in use . Worst-case performance occurs when the description language is flat (i .e ., no higher-order
structure) and the same predicate occurs many times in both the base and the target . Consider a
language with a single, unary predicate, and base and target dgroups each consisting of _N_ _distinct_
_expressions. In this case every base expression can match with every target expression, and each_
_such match will suggest matching in turn the entities that serve as their arguments . This reduces_
_to the problem of finding all isomorphic mappings between two equal size sets, which is 0(N!)._

Now let us consider the best case . If the base and target dgroups give rise to a match hypothesis
graph that has but one root, and that root is consistent, then there is only one gmap! The second

_The Structure-Mapping Engine_ _25_

and third merge steps in this case are now independent of _N, i_ _.e.,_ _constant-time._

Of course, the typical case is somewhere between these two extremes . Typically the vocabulary
of predicates is large, and the relationships between entities diverse . Structure provides a strong
restriction on the number of possible interpretations for an analogy . By the time SME gets to Step
4, many of the match hypotheses have been filtered out as being structurally impossible . Steps 4(a)
and 4(b) have already merged many partial gmaps, reducing the number of elements which may
be combined . The identicality constraint of Structure-Mapping (encoded in the match rules) also
reduces typical-case complexity, since match hypotheses are only created between relations when
functors are identical . Thus, SME will perform badly on large descriptions with no structure and
extensive predicate repetition, but SME will perform well on large descriptions with deep networks of
diverse higher-order relationships . Semantically, the former case roughly corresponds to a jumble
of unconnected expressions, and the latter case to a complex argument or theory . The better
organized and justified the knowledge, the better SME will perform.

While the potential complexity of Step 4(b) is O (N!), our experience is that this step is very
quick and displays near best-case performance in practice . We suspect the worst-case behavior
is very unlikely to occur, since it requires that all members of _Gmaps_ _l_ _intersect the same base-_
_structure and so must be merged in all possible ways . However, partial gmaps intersecting the same_
_base structure are almost always consistent with one another, meaning that step 2 would usually_
###### _merge Gmaps l into one gmap in 0(9 13 1 ) time. On the other hand, it is easy to hand-generate_

_examples which illustrate the worst-case performance for Step 4(c), and this step in practice can_
_take signficant work._

**3** **.3 .5 Analysis of Step # 5 : Finding candidate inferences**

The candidate inferences are gathered by looping through the base description roots for each gmap,
collecting missing base expressions whenever their structure intersects a match hypothesis in the

gmap. Each expression is tested to ensure that (1) it is not already matched with part of the
target description, and (2) whether it represents a contradiction of an existing target expression.

The size of the typical candidate inference is inversely related to the percentage of base structure
roots: more roots implies less structure to infer, and vice versa . Thus in the worst case we have

_0 (9_ _* 3_ **_b_** _* 3t),_ _or roughly_ _0 (N_ **4** _) ._ _However, this is an extreme worst-case . First, the_ _3t_ _term implies_
_that we check every target expression on each iteration . The algorithm actually only checks the_
###### _pertinent target expressions (i .e ., those with the same functor), giving a tighter bound of 0(N 3)._

_In the best case, there will only be one gmap and no candidate inferences, producing constant time_
_behavior._

**3** **.3 .6 Analysis of Step # 6** **: SES computation**

The complexity of the BMS is difficult to ascertain . Fortunately, it is irrelevant to our analysis
since the BMS can be eliminated if detailed justifications of evidential results are not required.

For example, the first version of SME [20] used specialized evidence rules which had most of the
flexibility of the BMS-based rules yet ran in 0(M) time.

Although the flexibility of the BMS can be valuable, in fact the majority of SME's processing
time takes place within it – typically 70 to 80%. So far this has not been a serious performance
limtation, since on the examples in this paper (and most of the examples we have examined), SME
runs in a matter of a few seconds on a Symbolics machine .

_The Structure-Mapping Engine_ _26_

## 4 Examples

The Structure-Mapping Engine has been applied to over 40 analogies, drawn from a variety of
domains and tasks . It is being used in psychological studies, comparing human responses with
those of SME for both short stories and metaphors . It is also serving as a module in a machine
```
learning program called PHINEAS, which uses analogy to discover and refine qualitative models of
physical processes such as water flow and heat flow . Here we discuss a few examples to demonstrate
SME ' s flexibility and generality.

```

**4 .1** **Methodological constraints**

Flexibility is a two-edged sword . The danger in using a program like SME is that one could imagine
```
tailoring the match construction and evidence rules for each new example . Little would be learned
by using the program in this way — we would have at best a series of "wind-up toys", a collection
of ad-hoc programs which shed little theoretical light . Here we describe our techniques for reducing
tailorability.
```

First, all the cognitive simulation experiments were run with a fixed collection of rule sets,
listed in Appendix A. Each rule set represented a particular type of comparison sanctioned by
the Structure-mapping theory (i .e ., analogy, literal similarity, and mere appearance) . The mere

appearance rules **(MA)** **match only low-order items : attributes and first-order relations . The analogy**
```
rules (AN) match systems of higher-order relations, while the literal similarity rules (LS) match both
low-order and higher-order structure . The first two examples in this section use the AN rules, while
the last uses both AN and MA rules, as indicated.
```

While the choice of match construction rules is dictated by Structure-mapping, the particular
values of evidence weights are not . Although we have not performed a sensitivity analysis, in our
preliminary explorations it appears that the gmap rankings are not overly sensitive to the particular
values of evidence weights . (Recall that which gmaps are constructed is _independent_ _of the weights,_

_and is determined only by the construction rules and structural consistency .)_

Second, we have accumulated a standard description vocabulary which is used in all experiments.
This is particularly important when encoding natural language stories, where the translation into a
formal representation is underconstrained . By accumulating representation choices across stories,
we attempt to free ourselves from biasing the descriptions for particular examples.

Third, we have tested SME with descriptions generated automatically by other AI programs . A
```
representation developed to perform useful inferences has fewer arbitrary choices than a representation developed specifically for learning research . So far, we have used descriptions generated by
two different qualitative simulation programs with encouraging results . For example, SME actually
performs better on a water-flow / heat-flow comparison using more complex descriptions generated by GIZMO [23] than on many hand-generated descriptions . We are working on other, similar
systems, as described in Section 6 .3 .1.

```

**4 .2** **Solar System - Rutherford Atom Analogy**

The Rutherford model of the hydrogen atom was a classic use of analogy in science . The hydrogen
atom was explained in terms of the better understood behavior of the solar system . We illustrate
```
SME's operation on this example with a simplified representation, shown in Figure 9 .

```

_The Structure-Mapping Engine_ _27_

Figure 9 : Solar System - Rutherford Atom Analogy.

SME constructed three possible interpretations . The highest-ranked mapping (SES = 6 .03) pairs
up the nucleus with the sun and the planet with the electron . This mapping is based on the mass
inequality in the solar system playing the same role as the mass inequality in the atom . It sanctions
the inference that the differences in masses, together with the mutual attraction of the nucleus and
the electron, causes the electron to revolve around the nucleus . This is the standard interpretation
of this analogy.

The other major gmap (SES = 4 .04) has the same entity correspondences, but maps the temperature difference between the sun and the planets onto the mass difference between the nucleus

and the electron . The SES for this gmap is low for two reasons. First, temperature and mass are
different functions, and hence they receive less local evidence . The second, and more important,
reason is that there is no mappable systematic structure associated with temperature in the base
dgroup. Thus other relations, such as the match for ATTRACTS, do not enter into this gmap . We
could in theory know alot more about the thermal properties of the solar system than its dynamics, yet unless there is some relational ground in the target description there will not be a set of

_mappable_ _systematic relations . (If we instead were explaining a home heating system in terms of_
_the solar system the situation would be the reverse_ _.)_

The third gmap is a spurious collection of match hypotheses which imply that the mass of the
sun should correspond to the mass of the electron, and the mass of the planet should correspond to
the mass of the nucleus . There is even less structural support for this interpretation (SES = 1 .87).

This example demonstrates an important aspect of the Structure-mapping account of analogy.
The interpretation preferred on structural grounds is also the one with the most inferential import.
This is not an accident ; the systematicity principle captures the structural features of well-supported
arguments . Using the Structure-mapping analogy rules (AN), SME prefers interpretations based on
a deep theory (i .e ., a subset of a dgroup containing a system of higher-order relations) to those
based on shallow associations (i .e ., a subset of a dgroup containing an assortment of miscellaneous
facts).

**4 .3 Discovering heat flow**

_The Structure-Mapping Engine_ _28_

Figure 10 : Two examples of water-flow and heat-flow.

```
The PHINEAS program [16,17,19] learns by observation . When presented with a new behavior,
it attempts to explain it in terms of its theories of the world . These theories are expressed as
```

qualitative models of physical processes using Forbus' _Qualitative Process Theory_ _[21,22] . When it_
_is given a behavior that it cannot explain, an analogical learning module is invoked which attempts_
_to generate a new or revised model that can account for the new observation . This module uses_
```
SME in two ways . 5 First SME is used to form a match between a previous experience which has
been explained and the current behavior . These correspondences then provide the foundation for
constructing a model that can explain the new observation based on the model for the previous
behavior.
```

For example, suppose that the program was presented with measurements of the heat-flow
situation depicted in Figure 10 and described in Figure 11 . If the domain model does not include
```
a theory of heat flow, PHINEAS will be unable to interpret the new observation . 6 Using SME,
PHINEAS constructs an analogy with the previously encountered water-flow experience also shown
in Figures 10 and 11 . This match establishes that certain properties from the two situations
behave in the same way . As shown in Figure 11, the roles of the beaker and the vial in the water
flow history are found to correspond to the roles of the horse shoe and water in the heat flow
history, respectively . PHINEAS stores the correspondences that provide a mapping between entities
or between their quantities (e .g ., Pressure and Temperature) for later reference.
```

When it is satisfied that the chosen water-flow history is sufficiently analogous to the current
```
situation, PHINEAS begins a deeper analysis of the analogy . It fetches the domain used to generate
its prior understanding of the base (water-flow) experience . Its description of water-flow, shown in
Figure 12, is a straightforward qualitative model similar to that used in other projects [23,26] . This
model states that if we have an aligned fluid path between the beaker and the vial (i .e ., the path
either has no valves or if it does, they are all open), and the pressure in the beaker is greater than
the pressure in the vial, then a liquid-flow process will be active . This process has a flow rate which
is proportional to the difference between the two pressures . The flow rate has a positive influence
on the amount of water in the vial and a negative influence on the amount of water in the beaker.

```

5 In this example PHINEAS is using the Structure-mapping analogy rules . In normal operation, it uses a rule set
that examines an IS-A hieararchy to relax the identicality constraint and a relevance-influenced match evaluation
criteria that is sensitive to the system's current reasoning goals [19].

6 PHINEAS uses the ATMI theory of measurement interpretation to explain observations . See [24] for details .

_The Structure-Mapping Engine_ _29_

**Water-Flow** **History** **Heat-Flow History**

```
(Situation SO) (Situation SO)
(Decreasing (Pressure (At beaker SO))) (Decreasing (Temp (At horse-shoe SO)))
(Increasing (Pressure (At vial SO))) (Increasing (Temp (At water SO)))
(Decreasing (Amount-of (At beaker SO))) (Greater (Temp (At horse-shoe SO))
(Increasing (Amount-of (At vial SO))) (Temp (At water SO)))
(Greater (Pressure (At beaker SO))
      (Pressure (At vial SO)))

```

```
(Situation Si) (Situation Si)
(Meets SO Si) (Meets SO Si)
(Constant (Pressure (At beaker Si))) (Constant (Temp
(Constant (Pressure (At vial Si))) (Constant (Temp
(Constant (Amount-of (At beaker Si))) (Equal-To (Temp
(Constant (Amount-of (At vial Si))) (Temp
(Equal-To (Pressure (At beaker Si))
      (Pressure (At vial Si)))

```

```
(At horse-shoe Si)))
(At water Si)))
(At horse-shoe Si))
(At water Si)))

```

```
(Function-Of (Pressure ?x) (Function-Of (Temp ?x)
        (Amount-of ?x)) (Heat ?x))

```

**Behavioral Correspondences**

Pressure 4-4 Temperature
Amount-of 4-4 **Heat**
SO 4-4 SO
Si 4-4 Si
beaker 4-4 **horse-shoe**
vial 4-4 water

Figure 11 : Analogical match between water-flow history and heat-flow history.

_The Structure-Mapping Engine_ _30_

Figure 12 : Qualitative Process Theory model of liquid flow.

Using SME a second time, this theory is matched to the current heat-flow situation using the
correspondences established with the behavioral analogy . The output is shown in Figure 13 . The
entity and function correspondences provided by the behavioral analogy provide signficant constraint for carrying over the explanation . SME's rule-based architecture is critical to this operation:
PHINEAS imposes these constraints by using a set of match constructor rules that only allow hypotheses consistent with the specific entity and function correspondences previously established.

Entities and functions left without a match after the accessing stage are still allowed to match other
unmatched entities and functions . For example, the rule

(MHC-rule ( :filter ?b ?t :test (sanctioned-pairing? (expression-functor ?b)

(expression-functor ?t)))
(install-MH ?b ?t))

forces a match between those quantities which were found to be analogous in the behavioral analogy

(e .g ., PRESSURE and TEMPERATURE) and prevents any alternate matches for these quantities (e .g .,
AMOUNT-OF and TEMPERATURE).

This example demonstrates several points . First, the second analogy which imports the theoretical explanation of the new phenomena is composed almost entirely of candidate inferences,
since the system had no prior model of heat flow . Hence, the model was _constructed_ _by analogy_

_The Structure-Mapping Engine_ _31_

```
Gmap #1 : { (AMOUNT-OF-35 HEAT-WATER) (AMOUNT-OF-33 HEAT-HSHOE)
       (PRESSURE-BEAKER TEMP-HSHOE) (PRESSURE-VIAL TEMP-WATER) }
   Emaps : { (beaker horse-shoe) (vial water) }
   Weight : 2 .675
   Candidate Inferences : (IMPLIES
                   (AND (ALIGNED ( :skolem pipe))
                      (GREATER-THAN (A TEMP-HSHOE) (A TEMP-WATER)))
                   (AND (Q = (FLOW-RATE pi) (- TEMP-HSHOE TEMP-WATER))
                      (GREATER-THAN (A (FLOW-RATE pi)) zero)
                      (I+ HEAT-WATER (A (FLOW-RATE pi)))
                        (I- HEAT-HSHOE (A (FLOW-RATE pi)))))

```

Figure 13 : An Analogically Inferred Model of Heat Flow.

rather than augmented by analogy . This shows the power of SME's candidate inference mechanism.
```
Second, the example illustrates how SME's rule-based architecture can support tasks in which the
entity correspondences are given prior to the match, rather than derived as a result of the match.
Finally, it shows the utility of introducing skolemized entities into the candidate inferences . The
results produced by SME (Figure 13) contain the entity ( : skolem pipe) . This indicates that, at
the moment, the heat path is a conjectured entity . At this time, the system inspects its knowledge
of paths to infer that immersion or physical contact is a likely heat path . However, we note that
much knowledge gathering and refinement may still take place while leaving the heat path as a
```

conjectured entity . For example, in the history of science _ether was postulated to provide a medium_
_for the flow of light waves because other kinds of waves required a medium._

**4 .4** **Modeling Human Analogical Processing**

```
SME is being used in several cognitive simulation studies . Our goal is to compare human responses
with those of SME's for a variety of tasks and problems . For example, two psychological stud```

ies [33,56] have explored the variables that determine the _accessibility_ _of a similarity match and_
_the_ _inferential soundness_ _of a match . Structure-mapping predicts that the degree of systematic_
_relational overlap will determine soundness [29]_ _. In contrast, Gentner [30,31] has suggested that_
_the accessibility of potential matches in long-term memory is heavily influenced by surface sim-_
_ilarity_ _. Psychological studies have supported both hypotheses [33,56,58]_ _. In order to verify the_
_computational assumptions we then ran_ SME on the same examples . Here we briefly summarize the
```
simulation methodology and the results ; for details see [65].
```

The hypotheses were tested psychologically as follows . Pairs of short stories were constructed
which were similar in different ways : in particular, some pairs embodied mere appearance and some

analogy . ? Subjects first read a large set of stories . Then, in a second session, subjects saw similar
```
stories and tried to retrieve the original stories (the access measure) . After that, the subjects
were then asked to judge the inferential soundness of each of the story pairs . For the cognitive

  7 0ther kinds of matches, including literal similarity, were also used . Here we discuss only analogy and mere
appearance

```

_The Structure-Mapping Engine_ _32_

**Base Story**
Karla, an old hawk, lived at the top of a tall oak tree . One afternoon, she saw a hunter on the ground with a
bow and some crude arrows that had no feathers . The hunter took aim and shot at the hawk but missed . Karla
knew that hunter wanted her feathers so she glided down to the hunter and offered to give him a few . The hunter
was so grateful that he pledged never to shoot at a hawk again . He went off and shot deer instead.

**Target Story - Analogy**
Once there was a small country called Zerdia that learned to make the world's smartest computer.
One day Zerdia was attacked by its warlike neighbor, Gagrach . But the missiles were badly aimed and the attack
failed . The Zerdian government realized that Gagrach wanted Zerdian computers so it offered to sell some of its
computers to the country. The government of Gagrach was very pleased . It promised never to attack Zerdia again.

**Target Story - Mere-Appearance**
Once there was an eagle named Zerdia who donated a few of her tailfeathers to a sportsman so he would promise
never to attack eagles.

One day Zerdia was nesting high on a rocky cliff when she saw the sportsman coming with a crossbow . Zerdia
flew down to meet the man, but he attacked and felled her with a single bolt . As she fluttered to the ground Zerdia
realized that the bolt had her own tailfeathers on it.

Figure 14 : Story Set Number 5.

simulation study, five triads of stories — a base, a mere-appearance match, and an analogy match
were encoded (15 in all) . Then pairs of stories were presented to SME, using different rule sets
corresponding to analogy (the AN rules) and mere appearance (the MA rules) . The results from
the AN rules were used to estimate soundness, while the results from the MA rules were used to
estimate accessibility. One of these story groups will be discussed in detail, showing how SME was
used to simulate a test subject.

In the story set shown in Figure 14, the original story concerned a hawk named Karla who
survives an attack by a hunter . Two target stories were used as potential analogies for the Karla
narration . One was designed to be truly analogous (TA5) and describes a small country named

Zerdia that survives an attack by another country . The other story (MA5) was designed to be
only superficially similar and describes an eagle named Zerdia who is killed by a sportsman . The
representation of the Karla story given to SME was:

```
  (CAUSE (EQUALS (HAPPINESS HUNTER) HIGH)
       (PROMISE HUNTER KARLA (NOT (ATTACK HUNTER KARLA))))
  (CAUSE (OBTAIN HUNTER FEATHERS) (EQUALS (HAPPINESS HUNTER) HIGH))
  (CAUSE (OFFER KARLA FEATHERS HUNTER) (OBTAIN HUNTER FEATHERS))
  (CAUSE (REALIZE KARLA (DESIRE HUNTER FEATHERS)) (OFFER KARLA FEATHERS HUNTER))
  (FOLLOW (EQUALS (SUCCESS (ATTACK HUNTER KARLA)) FAILED)
       (REALIZE KARLA (DESIRE HUNTER FEATHERS)))
  (CAUSE (NOT (USED-FOR FEATHERS CROSS-BOW)) (EQUALS (SUCCESS (ATTACK HUNTER KARLA)) FAILED))
  (FOLLOW (SEE KARLA HUNTER) (ATTACK HUNTER KARLA))
  (WEAPON CROSS-BOW)
  (KARLAS-ASSET FEATHERS)
  (WARLIKE HUNTER)
  (PERSON HUNTER)
  (BIRD KARLA)

```

The results from human subjects showed that (1) in the soundness evaluation task, as predicted

_The Structure-Mapping_ **_Engine_** **_33_**

**Analogical Match from** _Karla_ _to_ _Zerdia the country (TA5)._

```
Rule File : analogy .rules Number of Match Hypotheses : 54 Number of GMaps : 1

Gmap #1:
  (CAUSE-PROMISE CAUSE-PROMISE) (SUCCESS-ATTACK SUCCESS-ATTACK) (HAPPY-HUNTER HAPPY-GAGRACH)
  (HAPPINESS-HUNTER HAPPINESS-GAGRACH) (REALIZE-DESIRE REALIZE-DESIRE) (CAUSE-TAKE CAUSE-BUY)
  (ATTACK-HUNTER ATTACK-GAGRACH) (DESIRE-FEATHERS DESIRE-SUPERCOMPUTER) (FAILED-ATTACK FAILED-ATTACK)
  (TAKE-FEATHERS BUY-SUPERCOMPUTER) (CAUSE-FAILED-ATTACK CAUSE-FAILED-ATTACK)
  (CAUSE-OFFER CAUSE-OFFER) (FOLLOW-REALIZE FOLLOW-REALIZE) (HAS-FEATHERS USE-SUPERCOMPUTER)
  (CAUSE-HAPPY CAUSE-HAPPY) (NOT-ATTACK NOT-ATTACK) (PROMISE-HUNTER PROMISE)
  (NOT-HAS-FEATHERS NOT-USE-SUPERCOMPUTER) (OFFER-FEATHERS OFFER-SUPERCOMPUTER)
 Emaps : (HIGH23 HIGH17) (FEATHERS20 SUPERCOMPUTER14) (CROSS-BOW21 MISSILES15)
      (HUNTER19 GAGRACH13) (KARLA18 ZERDIAl2) (FAILED22 FAILED16)
 Weight : 22 .362718

```

**Analogical Match from** _Karla_ _to_ _Zerdia the eagle (MA5)._

```
Rule File : analogy .rules Number of Match Hypotheses : 47 Number of GMaps : 1

Gmap #1:
  (PROMISE-HUNTER PROMISE) (DESIRE-FEATHERS DESIRE-FEATHERS) (TAKE-FEATHERS TAKE-FEATHERS)
  (CAUSE-OFFER CAUSE-OFFER) (OFFER-FEATHERS OFFER-FEATHERS) (HAS-FEATHERS HAS-FEATHERS)
  (REALIZE-DESIRE REALIZE-DESIRE) (ATTACK-HUNTER ATTACK-SPORTSMAN) (NOT-ATTACK NOT-ATTACK)
  (SUCCESS-ATTACK SUCCESS-ATTACK) (FOLLOW-SEE-ATTACK FOLLOW-SEE) (SEE-KARLA SEE-ZERDIA)
  (FAILED-ATTACK SUCCESSFUL-ATTACK) (CAUSE-TAKE CAUSE-TAKE)
 Emaps : (FAILED22 TRUE11) (KARLA18 ZERDIA7) (HUNTER19 SPORTSMAN8)
      (FEATHERS20 FEATHERS9) (CROSS-BOW21 CROSS-BOW10)
 Weight : 16 .816530

```

Figure 15 : SME ' s Analysis of Story Set 5, Using the TA Rules.

by Gentner 's systematicity principle, people judged analogies as more sound than mere appearance
matches ; and (2) in the memory access task, people were far more likely to retrieve surface similarity
matches than analogical matches.

To test SME as a cognitive simulation of how people determine the soundness of an analogy, SME
was run using its analogy (AN) match rules on each base-target pair of stories – that is, base/mere
appearance story and base/analogical story . Figure 15 shows the output of SME for the AN task.
For example, "Zerdia the country" (the analogy) was found to be a better analogical match (SES
= 22 .4) to the original Karla story than "Zerdia the eagle" (SES = 16 .8) . Overall, SME as an
analogical mapping engine agrees quite well with the soundness rating of human subjects.

We also used SME to test the claim that the human access patterns resulting from a dependence
on surface similarity matches (objects and object-attribute overlap) . To test this, SME was run on
each of the pairs using its mere-appearance (MA) match rules. This measured their degree of
superficial overlap . Again, over the five stories SME's rankings match those of human subjects . For
example, the output of SME for the MA task is given in Figure 16, which shows that the eagle
story (SES = 7 .7) has a higher MA rating than the country story (SES = 6 .4) .

_The Structure-Mapping_ **_Engine_** **_34_**

**Analogical Match from** _Karla_ _to_ _Zerdia the country (TA5)._

```
Rule File : appearance-match .rules Number of Match Hypotheses : 12 Number of GMaps : 1

Gmap #1:
  (HAPPINESS-HUNTER HAPPINESS-GAGRACH) (ATTACK-HUNTER ATTACK-GAGRACH) (TAKE-FEATHERS BUY-SUPERCOMPUTER)
  (WARLIKE-HUNTER WARLIKE-GAGRACH) (DESIRE-FEATHERS DESIRE-SUPERCOMPUTER)
  (HAS-FEATHERS USE-SUPERCOMPUTER) (OFFER-FEATHERS OFFER-SUPERCOMPUTER) (WEAPON-BOW WEAPON-BOW)
 Emaps : (KARLA1 ZERDIAl2) (FEATHERS3 SUPERCOMPUTER14) (CROSS-BOW4 MISSILES15) (HUNTER2 GAGRACH13)
 Weight : 6 .411572

```

**Analogical Match from** _Karla_ _to_ _Zerdia the eagle (MA5)._

```
Rule File : appearance-match .rules Number of Match Hypotheses : 14 Number of GMaps : 1

Gmap #1:
  (OFFER-FEATHERS OFFER-FEATHERS) (TAKE-FEATHERS TAKE-FEATHERS) (ATTACK-HUNTER ATTACK-SPORTSMAN)
  (SEE-KARLA SEE-ZERDIA) (HAS-FEATHERS HAS-FEATHERS) (BIRD-KARLA BIRD-ZERDIA) (WEAPON-BOW WEAPON-BOW)
  (DESIRE-FEATHERS DESIRE-FEATHERS) (WARLIKE-HUNTER WARLIKE-SPORTSMAN) (PERSON-HUNTER PERSON-SPORTSMAN)
 Emaps : (FEATHERS3 FEATHERS9) (CROSS-BOW4 CROSS-BOW1O) (HUNTER2 SPORTSMAN8) (KARLA1 ZERDIA7)
 Weight : 7 .703568

```

Figure 16 : SME ' s Analysis of Story Set 5, Using the MA Rules.

It should be noted that the access mimicking task is not a true simulation . To do this would
require finding and selecting the prior story from a large set of potential matches . Rather, SME
is acting as a bookkeeper to count the variable (here, degree of surface overlap) being claimed as
causally related to the variable being measured (accessibility of matches) . The results demonstrate
that surface similarity, as strictly defined and used in SME's match rules, match well with people's
retrieval patterns in an access task.

This study illustrates the viability of SME as a cognitive simulation of human processing of
analogy. We make two additional observations . First, the results demonstrate the considerable
leverage for cognitive modeling that SME's architecture provides . We know of no other generalpurpose matcher which successfully models two _distinct_ _kinds of human similarity comparisons._

_Second, the short story analogies show that_ SME is capable of matching large structures as well as
the smaller, simpler structures shown previously.

**4 .5 Removing all external constraints**

**What example should this be - an isomorphic type example, or one of the ones already**
**given (WF-HF or SS-RA) to show comparison?**

**4 .6 Performance Evaluation**

SME is written in Common Lisp . The examples in this paper were run on a Symbolics 3640 with
8 megabytes of RAM . Table 1 shows SME's performance for each example in this paper . All run

_The Structure-Mapping Engine_ _35_

_Table 1_ _:_ SME performance on described examples.

Number target
expressions/entities # MH's # Gmaps

Total BMS

run time

Total match

run time

Example

Number base
expressions/entities

Simple Water-Heat 11/4 6/4 14 3 0.70 0 .23
Solar System-Atom 12/2 9/2 16 3 0.91 0 .28
**PHINEAS** **behavioral** 40/8 27/6 69 6 9.68 1 .92
**PHINEAS** **theory** 19/11 13/6 10 1 0 .17 0 .66
Base5-TA5 (AN) 26/6 24/6 54 1 5 .34 0 .87
Base5-MA5 (AN) 26/6 24/5 47 1 4.55 0 .98
Base5-TA5 (MA) 26/6 24/6 12 1 0.38 0 .36
Base5-MA5 (MA) 26/6 24/5 14 1 0.73 0 .46
NOTE : All times are given in seconds . Total match time is total SME run time minus BMS run time.

times are in seconds . We have separated the BMS run time from the total run time to give a
more accurate account of SME's speed, since the computational cost of the BMS can be removed
```
if necessary. This data indicated that SME is extremely fast at producing unevaluated gmaps . In
fact, it would seem to be close to linear in the number of match hypotheses and in the number
of base and target expressions . The majority of the run time is spent within the BMS, producing
structural evaluation scores . However, the total run times are sufficiently short that we have opted
to continue using the BMS for now, since it has proven to be a valuable analysis tool.
```

The longest runtime occurred for the behavioral match between the water-flow and heat-flow
observations (PHINEAS behavioral) . While the descriptions for this example were the largest, the
```
primary source of slowdown was the flat representations used to describe the situations.

### 5 Comparison With Other Work

```

The Structure-mapping theory has received a great deal of convergent theoretical support in artificial intelligence and psychology . Although there are differences in emphasis, there is now widespread

agreement on the basic elements of one-to-one mappings of objects with carryover of predicates
([5,6,38,41,46,47,57,59,73,66]) . Moreover, several of these researchers have adopted special cases of
the systematicity principle . For example, Carbonell focuses on plans and goals as the high-order
relations that give constraint to a system, while Winston [74] focuses on causality . Structuremapping theory subsumes these treatments in three ways . First, it defines mapping rules which are
independent of particular domains or primitives. Second, the Structure-mapping characterization

applies across a range of applications of analogy, including problem solving, understanding explanations, etc . Third, the Structure-mapping account treats analogy as one of a family of similarity
comparisons, each with particular psychological privileges, and thus explains more phenomena.

Some models have combined an explicit Structure-mapping component to generate potential
interpretations of a given analogy with a pragmatic component to select the relevant interpretation

(e .g ., [5,47] . Given our experience with PHINEAS, we believe SME will prove to be a useful tool for
```
such systems.
  SME computes a structural match first, and then uses this structural match to derive candidate
inferences . The implementations of Winston [73] and Burstein [5] are similar to SME in this respect.
An alternate strategy is used by Winston [74], Kedar-Cabelli [47], Carbonell [6,7], and Greiner

```

_The Structure-Mapping Engine_ _36_

[38] . These programs do not perform a match _per se,_ _but instead attempt to carry over "relevant"_
_structure first and modify it until it applies to the target domain_ _. The match arises as an implicit_
_result of the structure modification . We know of no complexity results available for this technique,_
_but we suspect it is much worse than_ **SME .** **It appears that there is great potential for extensive**
**search in the modification method . Furthermore, the modification method effectively requires that**
**the access mechanism is able to provide only salient structures (e** **.g** **.,** **_purpose-directed [47]),_** **_since_**
**_the focusing mechanism of a partial match is not present . This means these systems are unlikely_**
**_to ever derive a surprising result from an analogy._**

A very different approach is taken by Holyoak [44] . In this account, there is no separate
stage of structural matching. Instead, analogy is completely driven by the goals of the current
problem-solving context . Retrieval of the base domain is driven by an abstract scheme of current
problem-solving goals . Creating the mapping is interleaved with other problem-solving activities.

This "pragmatic" account, while appealing in some ways, has several crucial limitations . First,
the pragmatic model has no account of soundness in terms of systematicity . Without structural
consistency, the search space for matching explodes (see below) . Second, the pragmatic account can
only be defined in problem-solving contexts . Yet analogy is used for purposes other than problem
solving, including many contexts in which relevance does not apply . Analogy can be used to explain

a new concept and to focus attention on a particular aspect of a situation . Analogy can result in
noticing commonalities and conclusions that are totally irrelevant to the purpose at hand . Thus

an analogy interpretation algorithm that requires relevance cannot be a general solution [30,31].
Third, psychological data indicates that access is driven by surface similarity, not relevance, as
described previously.

We believe the modularity imposed by the Structure-mapping account has several desirable
features over the pragmatic account . In the Structure-mapping account, the same match procedure
is used for all applications of analogy. For example, in a problem-solving environment, current plans

and goals influence what is accessed . Once base and target are both present, the analogy mapping
is performed, independently of the particular context . Its results can then be examined and tested

as part of the problem-solving process (see [30,31].

SME demonstrates that an independent, structural matcher can be built which is useful in several
tasks and for a variety of examples (over 40 at this writing) . By contrast, no clear algorithms have
been presented based on the pragmatic account, and published accounts so far [43] describe only
two running examples . Another issue is that of potential complexity . The "typical case" bounds we
have been able to derive so far are not very precise, and a more complete complexity analysis would
certainly be desirable . However, the analysis so far indicates reasonable typical case performance

(roughly, _0(N_ _2 )),_ _and the empirical results bear this out . Our excellent performance arises from_
_the fact that_ **SME focuses on** _local properties of the representation . On the other hand, the pragmatic_

_account appears to involve arbitrary inference, and arbitrary amounts of knowledge, in the mapping_
_process_ _. Thus we would expect that the average-case computational complexity of a pragmatically_
_oriented matcher will be dramatically worse than_ **SME.**

##### 5 .1 Matching Algorithms

To our knowledge, SME is unique in that it generates all structurally consistent analogical mappings without search . Previous matchers have utilized heuristic search through the space of possible matches, typically returning a single, best match (e .g., [14,40,49,51,68,69,72,73,74]) . Some

_The Structure-Mapping Engine_ _37_

researchers on analogy have suggested that generating all possible interpretations is computation
ally intractable [40,73,49] . Our analysis and empirical results indicate that this conclusion must
be substantially modified . Only when structural constraints do not exist, or are ignored, does the
computation become intractable . For instance, in [49] the knowledge base was uniform and had no
higher-order structure . In such cases exponential explosions are unavoidable.

Winston's original matcher [73] heuristically searched for a single best match . It begins by
enumerating all entity pairings and works upward to match relations, thus generating all **NEb!/(NEb-**

**N** **Et** **)!** **possible entity pairings** **. Because SME only introduces entity pairings when suggested by**
**potential shared relational structure, it typically generates many fewer entity pairings** **. Some limited**

**amount of pruning due to domain-specific category information was also available on demand,**
**such as requiring that males match with males . By contrast, SME ignores attributes when in**

**analogy mode, unless they play a role in a larger systematic structure** **. Winston's scoring scheme**
**would attribute one point for each shared relation (e .g** **., LOVE, CAUSE), property (e .g** **., STRONG,**
**BEAUTIFUL), and class classification (e .g., A-KIND-OF(?x, woman)) . Unlike SME** **'s analogy rules,**
**this scheme makes no distinction between a single, systematic relational chain and a large collection**
**of independent facts.**

Winston's later system [74] used _importance-dominated matching,_ _where certain relationships_
_(such as causal or other constraining relationships) were placed in correspondence first, and helped_
_guide the rest of the match_ _. This is similar in spirit to SME's_ _: intern match constructor rules,_
_which generate hypotheses necessary for structural consistency based on a local hypothesis_ _. How-_
_ever, instead of assembling global solutions from local matches as SME does, Winston's matcher_
_constructed correspondences by heuristic search, guided in part by functions which determine the_
_similarity of parts_ _. The notion of structural consistency was never formalized and exploited as a_
_constraint . However, Winston's system was the first to be tested on a wide variety of examples_
_from several domains, thus setting an important methodological example . It still stands today_

_as the most complete analogical reasoning and learning system, incorporating a model of access,_
_reasoning via precedents, and learning new rules from examples._

Kline 's RELAX system [49] focused on matching relations rather than entities . RELAX did
not attempt to maintain structural consistency, allowing many-to-one mappings between entities
or predicate instances . In conjunction with a semantic network, RELAX was able to match items
having quite different syntax (e .g., (Segment Al A2) matching (Angle Al X A2)) . However, there
was no guarantee that the best match would be found due to local pruning during search.

Programs for forming inductive generalizations have also addressed the partial matching problem. These systems use a heuristically pruned search to build up sets of correspondences between
terms which are then variablized to form generalized concept descriptions . Since these systems were
not designed for analogy, they resemble the operation of SME programmed as a literal graph matcher

(e .g ., they could not match Pressure to Temperature) . Hayes-Roth & McDermott 's SPROUTER

[40] and Diettrich & Michalski 's INDUCE 1 .2 [14] possess our restriction of one-to-one consistency in
matching . Vere 's THOTH system [68,69] uses less stringent match criteria . Once the initial sets of
matched terms are built, previously unmatched terms may be added to the match if their constants

are in related positions . In the process, THOTH may allow many—to—one mappings between terms.

The usefulness of many–to–one mappings in matches has been discussed in the literature

[40,49] . Hayes-Roth & McDermott [40] advocate the need for many-to-one mappings among entities. Kline [49] calls for many-to-one mappings between propositions as well . For example,

Kline points out that in trying to match a description of National League baseball to American

_The Structure-Mapping Engine_ _38_

League baseball, the statement (male NLpitcher) should match both (male ALpitcher) and

(male ALdesignatedhitter).

Allowing many–to–one mappings undercuts structural consistency, which in our view is central
to analogy. Many–to–one mappings appear to be permitted in artistic metaphor, but are not
viewed as acceptable by subjects in explanatory, predictive analogies [28,36] . However, we agree
that multiple mappings are sometimes useful [11] . We propose that many–to–one mappings should
be viewed as multiple analogies between the same base and target . Since SME produces all of the
interpretations of an analogy, a postprocessor could keep more than one of them to achieve the

advantages of many–to–one mappings, without sacrificing consistency and structural clarity. Thus,
in the baseball example, SME would produce an _offense_ _interpretation and a_ _defense interpretation._

**5 .2 Other** **Pattern-Matching systems**

Clearly Structure-mapping is a form of pattern-matching, but it is different than previous patternmatchers. For example, it should be clear that Structure-mapping neither subsumes unification
nor is subsumed by it . Consider the pair of statements

(CAUSE (FLY PERSON1) (FALL PERSON1))
(CAUSE (FLY PERSON2) (FALL PERSON2))

These could be part of a legitimate analogy, with PERSON1 being mapped to PERSON2, but these
two statements do not unify since PERSON1 and PERSON2 are distinct constants . Conversely,

**(CAUSE (?X** **PERSON1) (FALL PERSON1))**
**(CAUSE** **(FLY ?Y) (FALL ?Z))**

will unify, assuming ? indicates variables, with the substitutions:

?X FLY

?Y PERSON1
?Z PERSON1

However, since Structure-mapping treats variables as constants, these statments fail to be analogous
in two ways . First, FLY and ?X are treated as distinct relations, and thus cannot match . Second,

?Y and ?Z are considered to be distinct entities, and thus are forbidden to map to the same target
item (i .e ., PERSON1).

Most importantly, the goals of Structure-mapping and unification are completely different.
Unification seeks a set of substitutions which makes two statements identical . Structure-mapping
seeks a set of correspondences between two descriptions which can suggest additional inferences.

Unlike unification, partial matches are perfectly acceptable.

Several of the implementation techniques used in SME are however similar in spirit to those
used in _axiomatized unifiers_ _[4,52,54], which use equational theories (such as associativity and_
_commutativity) to extend equality beyond identicality ._

_The Structure-Mapping Engine_ _39_

#### **6 Discussion**

We have described the Structure-Mapping Engine, a tool-kit for building matchers consistent with
Gentner's Structure-mapping theory of analogy and similarity . We have described SME's algorithm
```
in sufficient detail to allow replication by other researchers . 8 SME is both efficient and flexible.
```

A particular matching algorithm is specified by a set of _constructor rules_ _and_ _evidence rules ._ _It_
_produces all structurally consistent interpretations of a match, without backtracking . The interpre-_
_tations include the candidate inferences suggested by the match and a structural evaluation score,_
_which gives a rough measure of quality_ _._ SME has been used both in cognitive simulation studies and
```
a machine learning project . In the cognitive simulation studies, the results so far indicate that SME,
when guided with analogy rules, replicates human performance . In the machine learning project
(PHINEAS), SME ' s flexibility provides the means for constructing new qualitative theories to explain
observations.
```

While our complexity analysis indicates that SME's worst-case performance is factorial, the
```
empirical experience is that the typical behavior is much better than that . Importantly, the characteristic which determines efficiency is not size, but the degree of structure of the knowledge.
Unlike many AI systems, SME performs better with more systematic, relational descriptions.
```

In this section we discuss some broader implications of the project, and sketch some of our plans
for future work.

6.1 Representational issues

The SME algorithm is of necessity sensitive to the detailed form of the representation, since we are
```
forbidding domain-specific inference in the matching process . Existing AI systems rarely have more
than one or two distinct ways to describe any particular situation or theory . But as our programs
grow more complex (or as we consider modeling the range and depth of human knowledge) the number of structurally distinct representations for the same situation is likely to increase . For example,
a story might be represented at the highest level by a simple classification (i .e ., GREEK-TRAGEDY),
at an intermediate level by relationships involving the major characters (i .e ., (CAUSE (MELTING
WAX) FALL23)), and at the lowest level by something like conceptual dependencies . An engineer ' s
knowledge of a calculator might include its functional description, the algorithms it uses, and the
axioms of arithmetic expressed in set theory . Unless there is some window of overlap between the
levels of description for base and target, no analogy will be found . When our representations reach
this complexity, how could SME cope?
```

There are several possible approaches to this problem. Consider the set of possible representations for a description . Assume these representations can be ordered (at least partially) in terms of
degree of abstraction. If two descriptions are too abstract, there will either be no predicate overlap

(e .g ., **GREEK-TRAGEDY** **versus** **SHAKESPEARE-DRAMA)** **or identity (e .g** **.,** **TRAGEDY** **versus** **TRAGEDY)** **.** **On**
```
the other hand, if two descriptions are greatly detailed, there can be too many spurious, inconsequential matches (e .g ., describing the actions of characters every microsecond) . The problem is to
find levels of description which provide useful analogies . We believe one solution is to invoke SME
repeatedly, using knowledge of the definitions of predicates to "slide" the base or target descriptions
up or down in the space of possible representations appropriately.
```

8 SME is publically available for interested researchers . There is a manual available [18] which provides extensive
implementation-level details and interface information .

_The Structure-Mapping Engine_ _40_

An orthogonal consideration is the degree of systematicity . Worst-case behavior tends to occur
when representations are large and relatively flat . Changes in representation can make large differences . For example, a PHINEAS problem which took SME 53 minutes was reduced to 34 seconds
```
by imposing more systematic structure . We are currently exploring these trade-offs to formulate
more precise constraints on useful representations for analogical reasoning and learning.

```

**6.2** **Addressing the** **Combinatorics**

As we have shown, SME is _0 (N_ _2 )_ _except for the last critical merge step, which has_ _0 (NO_ _worst-case_
_performance . Our experience with both small (11 expressions) and large (71 expressions) domain_
_descriptions indicates that performance is more a function of representation and repetitiveness_
_rather than a function of size . We have found that even moderately structural domain descriptions_
_produce excellent performance . However, in practice it is not always convenient to avoid traditional,_
_flat domain representations_ . For example, SME is unable to duplicate Kline's baseball analogy
```
[49] within a reasonable amount of time (i .e ., hours) . This is due to his flat description of the
domain (e .g ., (MALE catcher), (BATS left-fielder), (BATS center-fielder), etc .) . Thus for
some cases, generating all possible interpretations of an analogy may be prohibitive . Previous
analogy programs used matching algorithms that are specifically designed around heuristic search
mechanisms . SME offers a clean line between generating all possibilities and imposing heuristic
```

limitations . If we stop after the first merge step, SME provides an _0 (N_ _2_ _)_ _algorithm for generating_
_the complete set of initial gmaps! The subsequent merge steps could then be heuristically driven_
_through a limited search procedure (e .g., beam-search, best-first, etc_ _.) to produce the best or N_
_best maximal interpretations_ . Alternatively, we could retain the current SME design (recall that
```
the second merge step is required to support candidate inference generation and is almost always
###### _0(N 2 ) or better) and simply drop the troublesome third merge step . This is an (unused) option_
```

_that the current implementation provides_ _. We have not yet explored the ramifications of dropping_
```
merge step 3, although work with PHINEAS has indicated the need for the maximality criterion in
practice.
  In the next sections, we discuss the potential for parallel versions of the SME algorithm . In particular, we argue that (1) there are many opportunities for parallel speedup, and (2) the expensive
merge steps can be eliminated in principle.

```

**6** **.2 .1 Medium-grained Parallel Architectures**

We begin by examining each stage of the algorithm to see how it might be decomposed into parallel
operations, and what kinds of speedups might result . First we assume a software architecture that

allows tasks to be spawned for parallel execution (such as [1]), and we ignore communications and
setup costs.

**Constructing Match Hypotheses** **All** **:filter rules can be run independently, giving rise to**

_0 (N_ <sup>_2_</sup> _)_ _tasks. With enough processors this could be done in constant time, assuming the_
_Structure-Mapping match constructor rules . Each_ _: intern rule can be run on every match_
_hypothesis as it gets created_ _. Since these rules can in turn create new match hypotheses, but_
_only involving an expression's arguments, the best speed-up would be roughly the log of the_
_input_ _._

_The Structure-Mapping Engine_ _41_

**Computing** _Conflicting, Emaps,_ _and_ _NoGood_ _sets_ _The_ _Conflicting set_ _computation is completely_

_local . It could either be organized around each base or target item, or around pairs of match_
_hypotheses_ _. Finding the_ _Emaps_ _and_ _No Good_ _sets require propagation of results upwards, and_
_hence again will take log time._

**Merge Step 1 : Form initial combinations** **Recall that this step starts from the roots of the**

**match hypothesis graph, adding the subgraph to the list of gmaps if the hypothesis is not**
**inconsistent and recursing on its offspring otherwise . The results from each root are inde-**
**pendent, and so may be done as separate tasks . If each recursive step spawns a new process**
**to handle each offspring, then the minimum time is proportional again to the order of the**
**highest root in the graph.**

**Merge Step 2 : Combine dependent but unconnected gmaps** **Recall that this step combines**

**initial gmaps which share common base structure and are not inconsistent when taken to-**
**gether** **. This procedure can be carried out bottom-up, merging pairs which share base struc-**
**ture and are consistent together and then recursing on the results** **. The computation time**
**will be logarithmic in the number of gmaps.**

**Merge Step 3 : Combine independent collections** **This can be performed like the previous**

**step, but skipping pairs of gmaps that have common structure (since they would have been**
**merged previously and hence must be inconsistent) . Again, with enough processors the time**
**is bounded by the log of the number of gmaps. However, since the number of gmaps is in the**
**worst case factorial, the number of tasks required could become rather large.**

This cursory analysis no doubt glosses over several problems lurking in creating a highly parallel
version of the **SME** **algorithm . However, we believe such algorithms could be very promising.**

**SME's** **simplicity also raises another interesting experimental possibility** **. Given that currently**
**many medium-grain parallel computers are being built with reasonable amounts of RAM and a lisp**
**environment on each machine, one can imagine simply loading a copy of** **SME** **into each processor.**
**Access experiments, for example, would be greatly sped up by allowing a pool of** **SME's** **to work over**
**the knowledge base in a distributed fashion.**

**6** **.2 .2 Connectionist Architectures**

Another interesting approach would be to only generate a single, best gmap while still maintaining

SME's "no search" policy . The problem of choosing among all possible interpretations in analogy
processing is very much like choosing among possible interpretations of the sentence "John shot two
bucks" in natural language processing . A "no search" solution to this natural language problem was
provided by the connectionist work of Waltz and Pollack [71] . Rather than explicitly constructing

all possible sentence interpretations and then choosing the best one, Waltz and Pollack used their
networks to implicitly represent all of the possible choices . Given a particular network, spreading

activation and lateral inhibition were used to find the single best interpretation . This work in
fact inspired the use of the BMS for representing evidential relationships and helped motivate the
decomposition of the processing into the local/global steps.

Consider the network produced by **SME** **prior to the gmap merge steps (shown in Figure 5).**
**Some match hypotheses support each other (grounding criterion) while others inhibit each other**
_(Conflicting_ _relations) . Viewing this as a spreading activation, lateral inhibition network, it appears_

_The Structure-Mapping Engine_ _42_

that standard connectionist relaxation techniques could be used to produce a "best" interpretation
without explicitly generating all gmaps . Furthermore, it may be possible to generate the secondbest, third-best, etc . interpretations on demand by inhibiting the nodes of the best interpretation,
forcing the second best to rise . Thus **SME** **would be able to establish a global interpretation simply**

**as an indirect consequence of the establishment of local structural consistency and systematicity.**
**This would eliminate the single most expensive computation of the** **SME** **algorithm** **. By eliminating**
**explicit generation of all gmaps, the complexity of the algorithm could drop to the** _0(N_ _2 )_ _required_
_to generate the connectionist network._

**6.3 Future Work**

**6** **.3 .1 Cognitive Simulation**

We are conducting additional cognitive simulation studies of analogical reasoning, memory, and
learning involving **SME** **.** **One line of experiments concerns the development of analogical reason-**
**ing . Psychological research shows a marked developmental shift in analogical processing. Young**
**children rely on surface information in analogical mapping** **; at older ages, systematic mappings**

**are preferred [34,35,45,70] . Further, there is some evidence that a similar shift from surface to**
**systematic mappings occurs in the novice-expert transition in adults [8,50,57,58].**

In both cases there are two very different interpretations for the analogical shift: (1) acquisition
of knowledge ; or (2) a change in the analogy algorithm . The knowledge-based interpretation is
that children and novices lack the necessary relational structures to guide their analogizing . The
second explanation is that the algorithm for analogical mapping changes, either due to maturation or learning . In human learning it is difficult to decide this issue, since exposure to domain
knowledge and practice in analogy and reasoning tend to occur simultaneously . SME gives us a
unique opportunity to vary independently the analogy algorithm and the amount and kind of domain knowledge . For example, we can compare identical evaluation algorithms operating on novice
versus expert representations, or we can compare different analogy evaluation rules operating on
the same representation.

There are two problems with our current structural evaluation score computation . First, there
are several other structural properties which should enter into the SES, such as the number and
size of connected components, the existence and structure of the candidate inferences . Second, it
is not normalized with respect to the sizes of the base and target domains . The current SES can
be used to compare matches of different bases to the same target, or different targets to the same
base . But it cannot be used to compare two completely different analogies (i .e., different bases and
different targets) . Janice Skorstad is building a programmable _structural evaluator_ _module that_
_will let us experiment with these factors and different normalization schemes [64] . We suspect that_
_being able to tune the structural evaluation criteria might allow us to model individual differences_
_in analogical processing . For example, a conservative strategy might favor taking gmaps with some_
_candidate inferences but not too many, in order to maximize the probability of being correct._

We are also exploring ways to reduce the potential for tailorability in the process of translating
descriptions provided as experimental stimuli for human subjects into formal representations for **SME**
**input . For example, Janice Skorstad is creating a graphical editor for producing graphical figures**
**for experimental stimuli . One output of the editor is a picture which can be used as a stimulus**
**for psychological experiments . The other output is a set of symbolic assertions with numerical**
**parameters, which is expanded into** **SME** **input by a simple inference engine that calculates spatial**

_REFERENCES_ _43_

relationships, such as INSIDE or LEFT-OF . Inspired by Winston ' s use of a pidgin-English parser for
```
input [74], we are also seeking a parser that, perhaps in conjunction with a simple inference engine,
can produce useful descriptions of stories.

```

**6** **.3 .2 Machine Learning Studies**

Falkenhainer's **PHINEAS** **program is part of the** _Automated Physicist Project_ _at the University of_
_Illinois_ _. This project, led by Forbus and Gerald DeJong, is building a collection of programs that_
_use qualitative and quantitative techniques for reasoning and learning about the physical world._

_DeJong and his students have built several programs that use Explanation-Based Learning [12,13]_
_to acquire knowledge of the physical world [61,55] . Forbus' group has developed a number of_
_useful qualitative reasoning programs [24,25,42] which can be used in learning projects (as_ **PHINEAS**
```
demonstrates) . By combining these results, we hope to build systems that can reason about a wide
range of physical phenomena and learn both from observation and by being taught.

#### 7 Acknowledgements

```

The authors wish to thank Janice Skorstad, Danny Bobrow, and Steve Chien for helpful comments
on prior drafts of this paper . Janice Skorstad provided invaluable assistance in encoding domain
models. Alan Frisch provided pointers into the unification literature.

This research is supported by the Office of Naval Research, Contract No . N00014-85-K-0559.
Additional support has been provided by IBM, both in the form of a Graduate Fellowship for

Falkenhainer and a Faculty Development award for Forbus . The equipment used in this research
was provided by an equipment grant from the Information Sciences Division of the Office of Naval

Research, and from a gift from Texas Instruments.

##### **References**

[1] Allen, D ., Steinberg, S . and Stabile, L . Recent developments in Butterfly Lisp . _Proceedings of_

_AAAI-87,_ _Seattle, 1987._

[2] Anderson, J ., _The Architecture of Cognition,_ _Harvard University Press, Cambridge, Mass,_

_1983._

[3] Buckley, _S .,_ _Sun up to sun down,_ _McGraw-Hill Company, New York, 1979._

[4] Bundy, A ., _The computer modelling of mathematical reasoning,_ _Academic Press, 1983_

[5] Burstein, M ., Concept formation by incremental analogical reasoning and debugging, in : _Pro-_

_ceedings of the Second International Workshop on Machine Learning,_ _University of Illinois,_
_Monticello, Illinois, June, 1983 . A revised version appears in_ _Machine Learning_ _: An Artifi-_

_cial Intelligence Approach Vol_ _. II,_ _R_ _.S . Michalski, J .G . Carbonell, and T .M. Mitchell (Eds .),_
_Morgan Kaufman, 1986._

[6] Carbonell, J .G ., Learning by Analogy : Formulating and generalizing plans from past ex
perience, in : _Machine Learning: An Artificial Intelligence Approach,_ _R .S . Michalski, J_ _.G._
_Carbonell, and T .M . Mitchell (Eds.), Morgan Kaufman, 1983_ _._

_REFERENCES_ _44_

[7] Carbonell, J.G ., Derivational analogy in problem solving and knowledge acquisition, in : _Pro-_

_ceedings_ _of the Second International Machine Learning Workshop,_ _University of Illinois, Mon-_
ticello, Illinois, June, 1983 . A revised version appears in _Machine Learning : An Artificial Ap-_
_proach Vol_ _. II,_ _R_ _.S. Michalski, J .G . Carbonell, and T .M . Mitchell (Eds .), Morgan Kaufman,_
1986.

[8] Chi, M .T .H., R . Glaser, E . Reese, Expertise in problem solving . In R . Sternberg (Ed .), _Ad-_

_vances in the psychology_ _of human intelligence_ _(Vol . 1) . Hillsdale, N .J., Erlbaum, 1982._

[9] Clement, J . Analogy generation in scientific problem solving . _Proceedings_ _of the third annual_

_meeting_ _of_ _the Cognitive Science Society,_ _1981._

[10] Clement, J . Analogical reasoning patterns in expert problem solving . _Proceedings_ _of the fourth_

_annual meeting_ _of_ _the Cognitive Science Society,_ _1982._

[11] Collins, A.M., & Gentner, D . How people construct mental models . In D . Holland and N . Quinn

(Eds .) _Cultural models in language and thought ._ _Cambridge, England_ _: Cambridge University,_
_1987._

[12] DeJong, G. Generalizations based on explanations . _Proceedings_ _of_ _the Seventh International_

_Joint Conference on Artificial Intelligence,_ _August, 1981_

[13] DeJong, G ., and Mooney, R . Explanation-based Learning : An alternative view . _Machine_

_Learning,_ _Volume 1, No . 2, 1986_

[14] Diettrich, T ., & Michalski, R .S ., Inductive learning of structural descriptions : evaluation

criteria and comparative review of selected methods, _Artificial Intelligence_ _16,_ _257-294, 1981._

[15] Falkenhainer, B ., Towards a general-purpose belief maintenance system, in : J .F . Lem
mer (Ed .), _Uncertainty in Artificial Intelligence, Volume II,_ _1987_ _. Also Technical Report,_
_UIUCDCS-R-87-1717, Department of Computer Science, University of Illinois, 1987._

[16] Falkenhainer, B ., An examination of the third stage in the analogy process : Verification
Based Analogical Learning, Technical Report UIUCDCS-R-86-1302, Department of Computer
Science, University of Illinois, October, 1986 . A summary appears in _Proceedings_ _of_ _the Tenth_
_International Joint Conference on Artificial Intelligence,_ _Milan, Italy, August, 1987._

[17] Falkenhainer, B ., Scientific theory formation through analogical inference, _Proceedings_ _of_ _the_

_Fourth International Machine Learning Workshop,_ _Irvine, CA, June, 1987._

[18] Falkenhainer, B ., The SME user's manual, Technical Report UIUCDCS-R-88-1421, Depart
ment of Computer Science, University of Illinois, 1988.

[19] Falkenhainer, B ., Learning from Physical Analogies : An adaptive approach to understanding

physical observations, Ph .D . Thesis, University of Illinois, (in preparation).

[20] Falkenhainer, B ., K.D . Forbus, D . Gentner, The Structure-Mapping Engine, _Proceedings_ _of_

_the Fifth National Conference on Artificial Intelligence,_ _August, 1986._

[21] Forbus, K .D ., "Qualitative Reasoning about Physical Processes ", _Proceedings_ _of_ _the Seventh_

_International Joint Conference on Artificial Intelligence,_ _August, 1981_ _._

_REFERENCES_ _45_

[22] Forbus, K .D., Qualitative Process Theory, _Artificial Intelligence_ _24,_ _1984._

[23] Forbus, K .D., Qualitative Process Theory, Technical Report No . 789, MIT Artificial Intelli
gence Laboratory, July, 1984.

[24] Forbus, K . Interpreting measurements of physical systems, in : _Proceedings of the Fifth National_

_Conference on Artificial Intelligence,_ _August, 1986._

[25] Forbus, K. The Qualitative Process Engine, Technical Report UIUCDCS-R-86-1288, Depart
ment of Computer Science, University of Illinois, December, 1986.

[26] Forbus, K .D. and D . Gentner, Learning Physical Domains : Towards a theoretical framework,

In _Proceedings of the Second International Machine Learning Workshop,_ _University of Illinois,_
_Monticello, Illinois, June, 1983 . A revised version appears in_ _Machine Learning : An Arti-_
_ficial Approach Vol. II,_ _R .S . Michalski, J .G. Carbonell, and T_ _.M . Mitchell (Eds_ _.), Morgan_

_Kaufmann, 1986._

[27] Gentner, D., The structure of analogical models in science, BBN Tech . Report No . 4451,

Cambridge, MA ., Bolt Beranek and Newman Inc ., 1980.

[28] Gentner, D., Are scientific analogies metaphors?, in : Miall, D ., _Metaphor_ _: Problems and_

_Perspectives,_ _Harvester Press, Ltd ., Brighton, England, 1982._

[29] Gentner, D ., Structure-mapping : A theoretical framework for analogy, _Cognitive Science 7(2),_

_1983._

[30] Gentner, D ., Mechanisms of analogy . To appear in S . Vosniadou and A . Ortony, (Eds .), _Simi-_

_larity and analogical reasoning ._ _Presented in June, 1986._

[31] Gentner, D ., Analogical inference and analogical access, in A . Preiditis (Ed .), _Analogica_ _: Pro-_

_ceedings of the First Workshop on Analogical Reasoning,_ _London, Pitman Publishing Co ., 1988_
_Presented in December, 1986._

[32] Gentner, D ., & D .R. Gentner, Flowing waters or teeming crowds : Mental models of electricity,

In D. Gentner & A .L. Stevens, (Eds .), _Mental Models,_ _Erlbaum Associates, Hillsdale, N_ _.J .,_
_1983._

[33] Gentner, D ., & R . Landers, Analogical reminding : A good match is hard to find . In _Proceedings_

_of the International Conference on Systems, Man and Cybernetics ._ _Tucson, Arizona, 1985._

[34] Gentner, D . Metaphor as structure-mapping : The relational shift . _Child Development,_ **_59,_**

**_47-59, 1988._**

[35] Gentner, D ., & C . Toupin, Systematicity and Surface Similarity in the Development of Analogy,

_Cognitive Science,_ _1986._

[36] Gentner, D., Falkenhainer, B ., & Skorstad, J . Metaphor : The good, the bad and the ugly.

_Proceedings of the Third Conference on Theoretical Issues in Natural Language Processing,_
_Las Cruces, New Mexico, January, 1987 ._

_REFERENCES_ _46_

[37] Ginsberg, M .L., Non-Monotonic reasoning using Dempster 's rule, _Proceedings_ _of_ _the Fourth_

_National Conference on Artificial Intelligence,_ _August, 1984._

[38] Greiner, R., Learning by understanding analogies, _Artificial Intelligence_ _35 (1),_ _81-125, 1988._

[39] Hall, R . Computational approaches to analogical reasoning : A comparative analysis . To appear

in _Artificial Intelligence._

[40] Hayes-Roth, F ., McDermott, J . An interference matching technique for inducing abstractions,

_Communications_ _of the ACM,_ _21(5),_ _May, 1978._

[41] Hofstadter, D .R., The Copycat project: An experiment in nondeterministic and creative analo
gies. M .I.T . A .I . Laboratory memo 755 . Cambridge, Mass : M .I.T ., 1984.

[42] Hogge, J . Compiling plan operators from domains expressed in qualitative process theory,

_Proceedings_ _of_ _the Sixth National Conference on Artificial Intelligence,_ _Seattle, WA, July,_
_1987._

[43] Holland, J .H ., Holyoak, K .J ., Nisbett, R .E., & Thagard, P ., _Induction_ _: Processes_ _of inference,_

_learning, and discovery,_ _1987._

[44] Holyoak, K .J . The pragmatics of analogical transfer . In G .H. Bower (Ed .), _The psychology_ _of_

_learning and motivation_ _. Vol. I._ _New York_ _: Academic Press, 1984._

[45] Holyoak, K .J ., E .N. Juin, D .O. Gillman (in press) . Development of analogical problem-solving

skill . _Child Development._

[46] Indurkhya, B ., "Constrained Semantic Transference : A formal theory of metaphors," Technical

Report 85/008, Boston University, Department of Computer Science, October, 1985.

[47] Kedar-Cabelli, S ., Purpose-Directed Analogy. _Proceedings_ _of the Seventh Annual Conference_

_of the Cognitive Science Society,_ _Irvine, CA, 1985._

[48] Kedar-Cabelli, S . T. (in press) . Analogy : From a unified perspective . To appear in D . H.

Heiman (Ed .), _Analogical reasoning_ _: Perspectives_ _of_ _artificial intelligence, cognitive science,_

_and_ **_philosophy ._** **_Dordrecht, Nolland_** **_: D_** **_._** **_Reidel_** **_Publishing Company._**

**[49]** **Kline, P** **.J** **.,** **"Computing** **the similarity** **of structured objects by means of a heuristic search for**

**correspondences", Ph .D** **. Thesis, Department of Psychology, University of Michigan, 1983.**

[50] Larkin, J .H. Problem representations in physics . In D . Gentner & A .L. Stevens (Eds .) _Mental_

_Models ._ _Hillsdale, N .J., Lawrence Erlbaum Associates, 1983._

[51] Michalski, R .S ., " Pattern recognition as rule-guided inductive inference " _IEEE Transactions_

_on Pattern Analysis and Machine Intelligence 2(4),_ _pp . 349-361, 1980._

[52] Plotkin, G .D., Building in equational theories, in : _Machine Intelligence 7,_ _Meltzer, B_ _. &_
_Michie, D_ _. (Eds .), John Wiley & Sons, 1972._

[53] Prade, H ., "A synthetic view of approximate reasoning techniques," _Proceedings_ _of_ _the Eighth_

_International Joint Conference on Artificial Intelligence,_ _1983_ _._

_REFERENCES_ _47_

[54] Raulefs, P., Siekmann J ., Szabo, P ., & Unvericht, E ., A short survey on the state of the art in

matching and unification problems, _ACM SIGSAM Bulletin_ _13(2),_ _14-20, May, 1979._

[55] Rajamoney, S ., DeJong, G., and Faltings, B . Towards a model of conceptual knowledge acquisi
tion through directed experimentation . _Proceedings_ _of the Ninth International Joint Conference_

_on Artificial Intelligence,_ _Los Angeles, CA, August, 1985._

[56] Rattermann, M .J., and Gentner, D . Analogy and Similarity : Determinants of accessibility and

inferential soundness, _Proceedings_ _of the Cognitive Science Society,_ _July, 1987._

[57] Reed, S .K., A Structure-mapping model for word problems . _Journal_ _of Experimental Psychol-_

_ogy_ _: Learning, Memory, and Cognition,_ _13(1),_ _124-139, 1987._

[58] Ross, B .H., Remindings and their effects in learning a cognitive skill, _Cognitive Psychology,_

_16,_ _371-416, 1984._

[59] Rumelhart, D .E., & Norman, D .A., Analogical processes in learning . In J .R. Anderson (Ed .),

_Cognitive skills and their acquisition,_ _Hillsdale, N_ _.J ., Erlbaum, 1981._

[60] Shafer, G ., _A mathematical theory_ _of_ _evidence,_ _Princeton University Press, Princeton, New_

_Jersey, 1976._

[61] Shavlik, J .W . Learning about momentum conservation . _Proceedings_ _of the Ninth International_

_Joint Conference on Artificial Intelligence,_ _Los Angeles, CA, August, 1985_

[62] Stickel, M. A complete unification algorithm for associative-commutative functions, in : _Pro-_

_ceedings_ _of IJCAI-75,_ _Tbilisi, Georgia, USSR, 71-76, 1975._

[63] Tversky, A . Representation of structure in similarity data : Problems and prospects . _Psychome-_

_trika_ _39,_ _373-421, 1974._

[64] Skorstad, J ., A structural approach to abstraction processes during concept learning, Master's

Thesis, 1988.

[65] Skorstad, J ., Falkenhainer, B ., Gentner, D ., Analogical Processing : A simulation and empiri
cal corroboration, in : _Proceedings_ _of the Sixth National Conference on Artificial Intelligence,_
_Seattle, WA, August, 1987._

[66] Van Lehn, K . & J .S . Brown, Planning nets : A representation for formalizing analogies and

semantic models of procedural skills . In R .E . Snow, P.A . Federico & W .E . Montague (Eds .),
_Aptitude, learning and instruction : Cognitive process analyses ._ _Hillsdale, N_ _.J . Erlbaum, 1980._

[67] Van Lehn, K ., "Felicity conditions for human skill acquisition : Validating an AI-based theory,"

Xerox Palo Alto Research Center Technical Report CIS-21, 1983.

[68] Vere, S ., "Induction of concepts in the predicate calculus", _Proceedings_ _of the Fourth Interna-_

_tional Joint Conference on Artificial Intelligence,_ _1975._

[69] Vere, S ., "Inductive learning of relational productions", In Waterman & Hayes-Roth (Eds .),

_Pattern-Directed Inference Systems,_ _1978_ _._

_REFERENCES_ _48_

[70] Vosniadou, S ., On the development of metaphoric competence . University of Illinois:

Manuscript submitted for publication, 1985.

[71] Waltz, D .L. & Pollack, J .B., Massively Parallel Parsing : A strongly interactive model of natural

language interpretation, _Cognitive Science 9,_ _51-74, 1985._

[72] Winston, P.H ., Learning structural descriptions from examples, Ph .D. thesis, Report AI
TR-231, Artificial Intelligence Laboratory, Massachusetts Institute of Technology, Cambridge,
1970.

[73] Winston, P .H., Learning and Reasoning by Analogy, _Communications of the ACM,_ _23(12),_

_1980._

[74] Winston, P .H., Learning new principles from precedents and exercises, _Artificial Intelligence,_

_19, 321-350, 1982_ _._

_REFERENCES_ _49_

### A SME Match Rules

The construction of a match is guided by a set of _match rules_ _that specify which expressions_
_and entities in the base and target might match and estimate the believability of each possible_
_component of a match_ _. In our experiments using SME, we currently use three types of rule sets,_

_literal similarity, analogy,_ _and_ _mere appearance._

###### A.1 Literal Similarity (LS) Rules

The _literal similarity_ _rules look at both relations and object descriptions._

;;;; _Define MH constructor rules_

_;; If predicates are the same, match them_

```
(MHC-rule ( :filter ?b ?t :test (eq (expression-functor ?b) (expression-functor ?t)))
   (install-MH ?b ?t))

```

;; _Intern rule for non-commutative predicates - corresponding arguments only._
_;; Match compatible arguments of already matched items_

```
(MHC-rule ( :intern ?b ?t :test (and (expression? ?b) (expression? ?t)
                      (not (commutative? (expression-functor ?b)))
                      (not (commutative? (expression-functor ?t)))))
   (do ((bchildren (expression-arguments ?b) (cdr bchildren))
      (tchildren (expression-arguments ?t) (cdr tchildren)))
     ((or (null bchildren) (null tchildren)))
    (cond ((and (entity? (first bchildren)) (entity? (first tchildren)))
        (install-MH (first bchildren) (first tchildren)))
       ((and (function? (expression-functor (first bchildren)))
           (function? (expression-functor (first tchildren))))
        (install-MH (first bchildren) (first tchildren))))))

```

;; _Intern rule for commutative predicates - any "compatible" arguments, regardless of order._
_;; Match compatible arguments of already matched items_

```
(MHC-rule ( :intern ?b ?t :test (and (expression? ?b) (expression? ?t)
                      (commutative? (expression-functor ?b))
                      (commutative? (expression-functor ?t))))
   (dolist (bchild (expression-arguments ?b))
    (dolist (tchild (expression-arguments ?t))
     (cond ((and (entity? bchild) (entity? tchild))
         (install-MH bchild tchild))
         ((and (function? (expression-functor bchild)) (function? (expression-functor tchild)))
         (install-MH bchild tchild))))))

```

;;; ; _Define MH evidence rules_

_;; having the same functor is a good sign_

```
(assert! same-functor)

(rule (( :intern (MH ?b ?t) :test (and (expression? ?b) (expression? ?t)
                       (eq (expression-functor ?b) (expression-functor ?t)))))
  (if (function? (expression-functor ?b))
    (assert! (implies same-functor (MH ?b ?t) (0 .2 . 0 .0)))
    (assert! (implies same-functor (MH ?b ?t) (0 .5 . 0 .0)))))

```

_REFERENCES_ _50_

_;;check children (arguments) match potential_

```
(initial-assertion (assert! 'arguments-potentially-match))

(rule (( :intern (MH ?b ?t) :test (and (expression? ?b) (expression? ?t))))
  (if (children-match-potential ?b ?t)
    (assert! (implies arguments-potentially-match (MH ?b ?t) (0 .4 . 0 .0)))
    (assert! (implies arguments-potentially-match (MH ?b ?t) (0 .0 . 0 .8)))))

```

_;;if their order is similar, this is good. If the item is a function,_
_;; ignore since order comparisons give false support here._

```
(initial-assertion (assert! 'order-similarity))

(rule (( :intern (MH ?b ?t) :test (and (expression? ?b) (expression? ?t)
                       (not (function? (expression-functor ?b)))
                       (not (function? (expression-functor ?t))))))
  (cond ((= (expression-order ?b) (expression-order ?t))
      (assert! (implies order-similarity (MH ?b ?t) (0 .3 . 0 .0))))
      ((or (= (expression-order ?b) (1+ (expression-order ?t)))
         (= (expression-order ?b) (1- (expression-order ?t))))
      (assert! (implies order-similarity (MH ?b ?t) (0 .2 . 0 .05))))))

```

_;;propagate evidence down - systematicity_
_;; support for the arg will be 0.8 of the current support for the parent_

```
(rule (( :intern (MH ?bl ?tl) :test (and (expression? ?bl) (expression? ?tl)
                        (not (commutative? (expression-functor ?bl)))))
     ( :intern (MH ?b2 ?t2) :test (children-of? ?b2 ?t2 ?bl ?tl)))
   (sme :assert! (implies (MH ?bl ?tl) (MH ?b2 ?t2) (0 .8 . 0 .0))))

(rule (( :intern (MH ?bl ?tl) :test (and (expression? ?bl) (expression? ?tl)
                        (commutative? (expression-functor ?bl))))
     ( :intern (MH ?b2 ?t2) :test (and (member ?b2 (expression-arguments ?bl) :test #'eq)
                        (member ?t2 (expression-arguments ?tl) :test #'eq))))
   (sme :assert! (implies (MH ?bl ?tl) (MH ?b2 ?t2) (0 .8 . 0 .0))))

```

;;; ; _Gmap rules_

_;; Support from its MH's_ _. At this time we ignore other expressionors such as number_
_;; of candidate inferences, etc._

```
(rule (( :intern (GMAP ?gm)))
  (dolist (mh (gm-elements ?gm))
    (assert! '(implies,(mh-form mh) (GMAP ?gm)))))

###### A.2 Analogy (AN) Rules

```

The _analogy_ _rules prefer systems of relations and discriminate against object descriptions_ _. The_
_analogy evidence rules are identical to the literal similarity evidence rules and are not repeated_
_here_ _. The match constructor rules only differ in their check for attributes:_

;;;; _Define MH constructor rules_

_REFERENCES_ _51_

;; _If predicates are the same, match them_

```
(MHC-rule ( :filter ?b ?t :test (and (eq (expression-functor ?b) (expression-functor ?t))
                      (not (attribute? (expression-functor ?b)))))
   (install-MH ?b ?t))

```

;; _Match compatible arguments of already matched items._
_;; Notice attributes are allowed to match here, since they are part of some higher relation that matched._

_;; Intern rule for non-commutative predicates - corresponding arguments only._

```
(MHC-rule ( :intern ?b ?t :test (and (expression? ?b) (expression? ?t)
                      (not (commutative? (expression-functor ?b)))
                      (not (commutative? (expression-functor ?t)))))
   (do ((bchildren (expression-arguments ?b) (cdr bchildren))
      (tchildren (expression-arguments ?t) (cdr tchildren)))
     ((or (null bchildren) (null tchildren)))
    (cond ((and (entity? (first bchildren)) (entity? (first tchildren)))
        (install-MH (first bchildren) (first tchildren)))
       ((and (function? (expression-functor (first bchildren)))
           (function? (expression-functor (first tchildren))))
        (install-MH (first bchildren) (first tchildren)))
       ((and (attribute? (expression-functor (first bchildren)))
           (eq (expression-functor (first bchildren)) (expression-functor (first tchildren))))
        (install-MH (first bchildren) (first tchildren))))))

```

;; _Intern rule for commutative predicates - any "compatible" arguments, not necessarily corresponding._

```
(MHC-rule ( :intern ?b ?t :test (and (expression? ?b) (expression? ?t)
                      (commutative? (expression-functor ?b))
                      (commutative? (expression-functor ?t))))
   (dolist (bchild (expression-arguments ?b))
    (dolist (tchild (expression-arguments ?t))
     (cond ((and (entity? bchild) (entity? tchild))
         (install-MH bchild tchild))
         ((and (function? (expression-functor bchild))
            (function? (expression-functor tchild)))
         (install-MH bchild tchild))
         ((and (attribute? (expression-functor bchild))
            (eq (expression-functor bchild) (expression-functor tchild)))
         (install-MH bchild tchild))))))

###### A.3 Mere Appearance (MA) Rules
```

The mere appearance rules focus on object descriptions and prevent matches between functions or
relations. As a result, the number of evidence rules is greatly reduced.

;;;; _Define MH constructor rules_

```
(MHC-rule ( :filter ?b ?t :test (and (eq (expression-functor ?b) (expression-functor ?t))
                      (<= (expression-order ?b) 1)
                      (<= (expression-order ?t) 1)))
   (install-MH ?b ?t))

(MHC-rule ( :intern ?b ?t :test (and (expression? ?b) (expression? ?t)

```

_REFERENCES_ _52_

```
                      (not (commutative? (expression-functor ?b)))
                      (not (commutative? (expression-functor ?t)))))
   (do ((bchildren (expression-arguments ?b) (cdr bchildren))
      (tchildren (expression-arguments ?t) (cdr tchildren)))
     ((or (null bchildren) (null tchildren)))
    (if (and (entity? (first bchildren)) (entity? (first tchildren)))
      (install-MH (first bchildren) (first tchildren)))))

(MHO-rule ( :intern ?b ?t :test (and (expression? ?b) (expression? ?t)
                      (commutative? (expression-functor ?b))
                      (commutative? (expression-functor ?t))))
   (dolist (bchild (expression-arguments ?b))
    (dolist (tchild (expression-arguments ?t))
     (if (and (entity? bchild) (entity? tchild))
       (install-MH bchild tchild)))))

```

;;; ; _Define MH evidence rules_

_;; having the same functor is a good sign_

```
(initial-assertion (assert! 'same-functor))

(rule (( :intern (MH ?b ?t) :test (and (expression? ?b) (expression? ?t)
                       (eq (expression-functor ?b) (expression-functor ?t)))))
    (cond ((attribute? (expression-functor ?b))
         (assert! (implies same-functor (MH ?b ?t) (0 .5 . 0 .0))))
        ((= 1 (max (expression-order ?b) (expression-order ?t)))
         (assert! (implies same-functor (MH ?b ?t) (0 .4 . 0 .0))))))

```

_;;propagate evidence down - only for entity MH's caused by attribute pairings_
_;; support for the arg will be 0.9 of the current support for the parent_

```
(rule (( :intern (MH ?bl ?tl) :test (and (expression? ?bl) (expression? ?tl)
                        (<= (max (expression-order ?bl)(expression-order ?tl)) 1)
                        (not (commutative? (expression-functor ?bl)))))
     ( :intern (MH ?b2 ?t2) :test (children-of? ?b2 ?t2 ?bl ?tl)))
   (sme :assert! (implies (MH ?bl ?tl) (MH ?b2 ?t2) (0 .9 . 0 .0))))

(rule (( :intern (MH ?bl ?tl) :test (and (expression? ?bl) (expression? ?tl)
                        (<= (max (expression-order ?bl)(expression-order ?tl)) 1)
                        (commutative? (expression-functor ?bl))))
     ( :intern (MH ?b2 ?t2) :test (and (member ?b2 (expression-arguments ?bl) :test #'eq)
                        (member ?t2 (expression-arguments ?tl) :test #'eq))))
   (sme :assert! (implies (MH ?bl ?tl) (MH ?b2 ?t2) (0 .9 . 0 .0))))

```

;;; ; _Gmap rules_

_;;; Support from_ **_its MH's_** **_. At this time we_** _ignore other expressionors_ **_such_** _as_ **_number_** _of candidate_ **_inferences_**

```
(rule (( :intern (GMAP ?gm)))
  (dolist (mh (gm-elements ?gm))
    (assert! '(implies,(mh-form mh) (GMAP ?gm)))))

### B Sample Domain Descriptions

```

In this section we show the domain descriptions given to SME for the described examples .

_REFERENCES_ _53_

B .1 Simple Water Flow - Heat Flow

Water Flow

```
(defEntity water :type inanimate)
(defEntity beaker :type inanimate)
(defEntity vial :type inanimate)
(defEntity pipe :type inanimate)

(defDescription simple-water-flow
  entities (water beaker vial pipe)
  expressions (((flow beaker vial water pipe) :name wflow)
       ((pressure beaker) :name pressure-beaker)
       ((pressure vial) :name pressure-vial)
       ((greater pressure-beaker pressure-vial) :name >pressure)
       ((greater (diameter beaker) (diameter vial)) :name >diameter)
       ((cause >pressure wflow) :name cause-flow)
       (flat-top water)
       (liquid water)))

```

Heat Flow

```
(defEntity coffee :type inanimate)
(defEntity ice-cube :type inanimate)
(defEntity bar :type inanimate)
(defEntity heat :type inanimate)

(defDescription simple-heat-flow
  entities (coffee ice-cube bar heat)
  expressions (((flow coffee ice-cube heat bar) :name hflow)
       ((temperature coffee) :name temp-coffee)
       ((temperature ice-cube) :name temp-ice-cube)
       ((greater temp-coffee temp-ice-cube) :name >temperature)
       (flat-top coffee)
       (liquid coffee)))

```

B .2 Solar-System - Rutherford Atom

Solar System

```
(defEntity sun :type inanimate)
(defEntity planet :type inanimate)

(defDescription solar-system
  entities (sun planet)
  expressions (((mass sun) :name mass-sun)
       ((mass planet) :name mass-planet)
       ((greater mass-sun mass-planet) :name >mass)
       ((attracts sun planet) :name attracts)
       ((revolve-around planet sun) :name revolve)
       ((and >mass attracts) :name andl)
       ((cause andl revolve) :name cause-revolve)
       ((temperature sun) :name temp-sun)
       ((temperature planet) :name temp-planet)

```

_REFERENCES_ _54_

```
       ((greater temp-sun temp-planet) :name >temp)
       ((gravity mass-sun mass-planet) :name force-gravity)
       ((cause force-gravity attracts) :name why-attracts)))

```

Rutherford Atom

```
(defEntity nucleus :type inanimate)
(defEntity electron :type inanimate)

(defDescription rutherford-atom
  entities (nucleus electron)
  expressions (((mass nucleus) :name mass-n)
       ((mass electron) :name mass-e)
       ((greater mass-n mass-e) :name >mass)
       ((attracts nucleus electron) :name attracts)
       ((revolve-around electron nucleus) :name revolve)
       ((charge electron) :name q-electron)
       ((charge nucleus) :name q-nucleus)
       ((opposite-sign q-nucleus q-electron) :name >charge)
       ((cause >charge attracts) :name why-attracts)))

```

B .3 Karla Stories

Zerdia the eagle - base story

```
(defEntity Karla)
(defEntity hunter)
(defEntity feathers)
(defEntity cross-bow)
(defEntity Failed)
(defEntity high)

(defDescription base-5
  entities (Karla hunter feathers cross-bow Failed high)
  expressions (((bird Karla) :name bird-Karla)
       ((person hunter) :name person-hunter)
       ((warlike hunter) :name warlike-hunter)
       ((Karlas-asset feathers) :name feathers-asset)
       ((weapon cross-bow) :name weapon-bow)
       ((used-for feathers cross-bow ) :name has-feathers)
       ((not has-feathers) :name not-has-feathers)
       ((attack hunter Karla) :name attack-hunter)
       ((not attack-hunter) :name not-attack)
       ((see Karla hunter) :name see-Karla)
       ((follow see-Karla attack-hunter) :name follow-see-attack)
       ((success attack-hunter) :name success-attack)
       ((equals success-attack Failed) :name failed-attack)
       ((cause not-has-feathers failed-attack) :name cause-failed-attack)
       ((desire hunter feathers) :name desire-feathers)
       ((realize Karla desire-feathers) :name realize-desire)
       ((follow failed-attack realize-desire) :name follow-realize)
       ((offer Karla feathers hunter) :name offer-feathers)
       ((cause realize-desire offer-feathers) :name cause-offer)
       ((obtain hunter feathers) :name take-feathers)
       ((cause offer-feathers take-feathers) :name cause-take)

```

_REFERENCES_ _55_

```
       ((happiness hunter) :name happiness-hunter)
       ((equals happiness-hunter high) :name happy-hunter)
       ((cause take-feathers happy-hunter) :name cause-happy)
       ((promise hunter Karla not-attack) :name promise-hunter)
       ((cause happy-hunter promise-hunter) :name cause-promise)))

```

Zerdia the country - TA5

```
(defEntity Zerdia)
(def Entity Gagrach)
(defEntity supercomputer)
(defEntity missiles)
(defEntity failed)
(defEntity high)

(defDescription to-5
  entities (Zerdia Gagrach supercomputer missiles failed high)
  expressions (((country Zerdia) :name country-Zerdia)
       ((country Gagrach) :name country-Gagrach)
       ((warlike Gagrach) :name warlike-Gagrach)
       ((Zerdias-asset supercomputer) :name supercomputer-asset)
       ((weapon missiles) :name weapon-bow)
       ((used-for supercomputer missiles ) :name use-supercomputer)
       ((not use-supercomputer) :name not-use-supercomputer)
       ((attack Gagrach Zerdia) :name attack-Gagrach)
       ((not attack-Gagrach) :name not-attack)
       ((success attack-Gagrach) :name success-attack)
       ((equals success-attack failed) :name failed-attack)
       ((cause not-use-supercomputer failed-attack) :name cause-failed-attack)
       ((desire Gagrach supercomputer) :name desire-supercomputer)
       ((realize Zerdia desire-supercomputer) :name realize-desire)
       ((follow failed-attack realize-desire) :name follow-realize)
       ((offer Zerdia supercomputer Gagrach) :name offer-supercomputer)
       ((cause realize-desire offer-supercomputer) :name cause-offer)
       ((obtain Gagrach supercomputer) :name buy-supercomputer)
       ((cause offer-supercomputer buy-supercomputer) :name cause-buy)
       ((happiness Gagrach) :name happiness-Gagrach)
       ((equals happiness-Gagrach high) :name happy-Gagrach)
       ((cause buy-supercomputer happy-Gagrach) :name cause-happy)
       ((promise Gagrach Zerdia not-attack) :name promise)
       ((cause happy-Gagrach promise) :name cause-promise)))

```

**Zerdia the hawk - MA5**

```
(defEntity Zerdia)
(defEntity sportsman)
(defEntity feathers)
(defEntity cross-bow)
(defEntity true)

(defDescription ma-5
  entities (Zerdia sportsman feathers cross-bow true)
  expressions (((bird Zerdia) :name bird-Zerdia)
       ((person sportsman) :name person-sportsman)
       ((warlike sportsman) :name warlike-sportsman)

```

_REFERENCES_ _56_

```
       ((Zerdias-asset feathers) :name feathers-asset)
       ((weapon cross-bow) :name weapon-bow)
       ((used-for feathers cross-bow ) :name has-feathers)
       ((desire sportsman feathers) :name desire-feathers)
       ((realize Zerdia desire-feathers) :name realize-desire)
       ((offer Zerdia feathers sportsman) :name offer-feathers)
       ((cause realize-desire offer-feathers) :name cause-offer)
       ((obtain sportsman feathers) :name take-feathers)
       ((cause offer-feathers take-feathers) :name cause-take)
       ((attack sportsman Zerdia) :name attack-sportsman)
       ((not attack-sportsman) :name not-attack)
       ((promise sportsman Zerdia not-attack) :name promise)
       ((cause take-feathers promise) :name cause-promise)
       ((see Zerdia sportsman) :name see-Zerdia)
       ((follow promise see-Zerdia) :name follow-promise)
       ((follow see-Zerdia attack-sportsman) :name follow-see)
       ((success attack-sportsman) :name success-attack)
       ((equals success-attack true) :name successful-attack)
       ((cause has-feathers successful-attack) :name cause-success-attack)
       ((realize Zerdia has-feathers) :name realize-Zerdia)
       ((follow successful-attack realize-Zerdia) :name follow-succ-attack)))

```
