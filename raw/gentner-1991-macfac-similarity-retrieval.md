# macfac-gentner-forbus-1991

> Converted from `macfac-gentner-forbus-1991.pdf` on 2026-08-18 via `pymupdf4llm`.
> Layout artefacts (broken equations, interleaved columns) are conversion noise, not the source.

---

MAC/FAC: A Mo del of Similarity-based Retrieval

Dedre Gentner and Kenneth D. Forbus

The Institute for the Learning Sciences, Northwestern University

1890 Maple Avenue, Evanston, IL, 60201

Abstract

We present a mo del of similarity-based retrieval

which attempts to capture three psychological phe
nomena: (1) p eople are extremely go  - d at judging

similarity and analogy when given items to compare.

(2) Sup ercial remindings are much more frequent

than structural remindings. (3) People sometimes

exp erience and use purely structural analogical re
mindings. Our mo del, called MAC/FAC (for \many are

called but few are chosen") consists of two stages.

The rst stage (MAC) uses a computationally cheap,

non-structural matcher to lter candidates from a

p  - ol of memory items. That is, we redundantly en
co de structured representations as content vectors,

whose dot pro duct yields an estimate of how well the

corresp onding structural representations will match.

The second stage (FAC) uses SME to compute a true

structural match b etween the prob e and output from

the rst stage. MAC/FAC has b een fully imple
mented, and we show that it is capable of mo deling

patterns of access found in psychological data.

Intro duction

Similarity-based remindings range from the sublime to

the stupid. On one extreme is b eing reminded by - c
taves in music of the p erio dic table in chemistry. On the

other extreme are times when a bicycle reminds you of

a pair of eyeglasses. Most often, remindings are some
where in b etween, such as when a bicycle reminds you of

another bicycle. Our theoretical attention is inevitably

drawn to sp ontaneous analogy, i.e., structural similarity

unsupp orted by surface similarity, partly b ecause it oers

p erhaps our b est entree to studying the creative pro cess.

However, a go - d mo del must also capture the frequency

of dierent outcomes, and research on the psychology of

memory retrieval p oints inescapably to a prep onderance of

the latter two typ es of similarity { (mundane) literal simi
larity, based on b oth structural and sup ercial commonal
ities { and (dumb) sup ercial similarity, based on surface

commonalities. Rare events are hard to mo del. A major

challenge for research on similarity-based reminding is to

devise a mo del that will pro duce chie
y literal-similarity

and sup ercial remindings, but still pro duce - ccasional

analogical remindings.

This pap er presents MAC/FAC, a mo del of similarity
based reminding which attempts to capture these phenom
ena. We rst review psychological evidence on retrieval

and mapping of similarity comparisons and describ e the

design of MAC/FAC. We then describ e computational ex
p eriements which simulate the patterns of access found in

a psychological exp eriment, and close by describing fur
ther avenues to explore.

Framework

Similarity-based transfer can b e decomp osed into subpro
cesses. Given that a p erson has some current target situ
ation in working memory, transfer from prior knowledge

requires at least (1) accessing a similar (base) situation

in long-term memory, (2) creating a mapping from the

base to the target, and (3) evaluating the mapping. In

the structure-mapping framework (Gentner, 1983, 1988),

mapping is the pro cess by which two representations

present in working memory are aligned and further in
ferences imp orted. The pro cess of computing a mapping

from one situation to another is governed by the con
straints of structural consistency and one-to-one mapping.

This account diers from most psychological treatments

by dening similarity in terms of corresp ondences b etween

structured representations. Matches can b e distinguished

according to the kinds of commonalities present. An anal
ogy is a match based on a common system of relations,

A literal sim

esp ecially involving higher-order relations.

1

ilarity match includes b oth common relational structure

and common object descriptions. Surface matches are

based primarily on common object descriptions along with

some shared rst-order relations.

There is considerable evidence that p eople are go  - d at

mapping. People can readily align two situations, pre
serving structurally imp ortant commonalties, making the

appropriate lower-order substitutions, and mapping addi
tional predicates into the target as candidate inferences.

For example, Clement & Gentner (in press) showed p eo
ple analogies and asked which of two lower-order relations,

1

We dene the order of an item in a representation as fol

lows: Objects and constants are order 0. The order of a state

ment is one plus the maximum of the order of its arguments.

b oth shared by base and target, was most imp ortant to

the match. Subjects chose relations that were governed

by shared higher-order relations. In a second study, sub
jects showed the same sensitivity to connectivity and sys
tematicity in cho osing which predicates to map as can
didate inferences from base to target. Further, p eople

rate metaphors as more apt when they are based on rela
tional commonalities than when they are based on com
mon object-descriptions (Gentner & Clement, 1988) and

they rate pairs of stories as more sound when they share

higher-order relational structure than when they share

object-descriptions (Gentner & Landers, 1985; Ratter
mann & Gentner, 1987). We also nd eects of relational

structure on judgments of similarity (Goldstone, Medin &

Gentner, in press; Rattermann & Gentner, 1987) and on

the way in which p eople align p erceptually similar pictures

(Markman & Gentner, 1990).

An adequate mo del of human similarity and analogy

must capture this sensitivity to structural commonality,

by involving structural representations and pro cesses that

align them. This would seem to require abandoning some

highly in
uential mo dels of similarity: e.g., mo deling sim
ilarity as the intersection of indep endent feature sets or

as the dot pro duct of feature vectors. However, we show

b elow that a variant of these nonstructural mo dels can b e

useful in describing some asp ects of access.

Similarity-based Access from Long-term Memory: There

is psychological evidence that access to long-term memory

relies more on surface commonalities and less on struc
tural commonalities than do es mapping. For example,

p eople often fail to access p otentially useful analogs (Gick

and Holyoak, 1980). Ross (1984, 1987) further showed

that, although p eople in a problem-solving task are often

reminded of prior problems, these remindings are often

based on surface similarity rather than on structural sim
ilarities b etween the solution principles.

In our research we used the \Karla the hawk" stories

to investigate the determinants of similarity-based access.

We put p eople in the p osition of trying to access anal
ogy and similarity matches from long-term memory and

asked which kinds of comparisons were easiest to retrieve

(Gentner & Landers, 1985; Rattermann & Gentner, 1987).

Subjects rst read a large set of stories. Two weeks later,

they were given new stories which matched the original

ones in various ways. Some were true analogs of the rst

stories; others were surface matches, sharing lower-order

events and object descriptors but not higher-order rela
tional structure. Subjects were asked to write out any

prior stories recalled while reading the new stories. After
wards, they rated all the pairs for soundness: i.e., how well

inferences could b e carried from one story to the other.

The results showed that, although subjects rated the

analogies as much more sound than the surface matches,

they were more likely to retrieve surface matches. Surface

similarity was the b est predictor of memory access, while

similarity in relational structure was the b est predictor

of subjective soundness and also of subjective similarity.

This disso ciation held not only b etween subjects, but also

within subjects. That is, subjects given the soundness

task immediately after the cued retrieval task judged that

the very matches that had come to their minds most easily

(the mere-app earance matches) were highly unsound (i.e.,

unlikely to b e useful in inference). This suggests that

analogical access may b e based on qualitatively distinct

pro cesses from analogical inferencing2

.

Comparison to Current Approaches. Some mo dels of

similarity assume smart pro cesses op erating over richly

articulated representations. Most case-based reasoning

mo dels have this character (Schank, 1982; Kolo dner,

1988). These mo dels are rich enough to capture pro cesses

like case alignment and adaptation. But their mo dels of

memory access involve intelligent indexing of structured

representations, which can predict sup erhuman access b e
havior; that is, that p eople should typically access the

b est structural match, even if it lacks surface similarity

with the current situation. Further, mo dels that assume

that elab orate structural mapping pro cesses are used to

compare the current situation with stored situations have

the disadvantage of b eing hard to scale up to large data

bases. The reverse set of advantages and disadvantages

holds for approaches that mo del similarity as the result

of a dot pro duct (or some other op eration) over feature

vectors, as is commonly done in mathematical mo dels of

human memory (e.g., Medin & Schaer, 1978) and in con
nectionist mo dels of learning (Smolensky, 1988). These

mo dels, with their nonstructured representations and rel
atively simple pro cesses, do not allow for the structural

precision of p eople's similarity judgments and inferences.

However, they provide an app ealing mo del of access since:

(1) these computations are simple enough to make it fea
sible to compute many such matches and cho ose the b est

(the scaling criterion); and (2) b eing simple, these mo d
els will not always pro duce the b est match (the fallibility

criterion). While this might b e a disadvantage in a norma
tive mo del, it could b e an advantage in mo deling human

similarity-based access, provided that the b est match is

sometimes pro duced. Next we prop ose an approach that

we think may oer the b est of b oth kinds of mo dels.

The MAC/FAC mo del

The complexity of the phenomena in similarity-based ac
cess suggests a two-stage mo del. Consider the computa
tional constraints on access. The large numb er of cases in

memory and the sp eed of human access suggests a compu
tationally cheap pro cess. But the requirement of judging

soundness, essential to establishing whether a match can

yield useful results, suggests an exp ensive match pro cess.

A common solution is to use a two-stage pro cess, where

a computationally cheap lter is used to pick out a sub
set of likely candidates for more exp ensive pro cessing (c.f.

Bareiss & King, 1989). MAC/FAC uses this strategy. The

2

The nding is not that higher-order relations do not con

tribute to retrieval. Adding higher-order relations led to non
signicantly more retrieval in two studies and to a small but

signicant b enet in the third. The p oint is simply that higher
order commonalities have a much bigger eect on mapping

once the two analogs are present than they do on similarity

based retrieval.

puzzling phenomena noted previously, we claim, can b e

understo - d in terms of the interactions of its two stages.

Figure 1 illustrates the comp onents of the MAC/FAC

mo del. The inputs are a p - ol of memory items and a

probe, i.e., a description for which a match is to b e found.

The output is a memory description and a comparison of

this description with the prob e.

There is little consensus ab out the global structure of

long-term memory. Consequently, we assume only that at

some stage in access there is a p - ol of descriptions from

which we must select one (or a few) which is most similar

to a prob e. We are uncommitted as to the size of this p - ol.

It could b e the whole of long-term memory, or a subset of

it if one p ostulates mechanisms for restricting the scop e

.

of search, such as spreading activation or indexing

3

Both stages consist of a matcher, which is applied to ev
ery input description, and a selector, which uses the evalu
ation of the matcher to select which comparisons are pro
duced as the output of that stage. Conceptually, matchers

are applied in parallel within each stage. Since the role

of the MAC stage is to pro duce plausible candidates for the

FAC stage, we discuss FAC rst.

The FAC stage

The FAC matcher is simply the literal similarity compu
tation dened by structure-mapping. Its output is a set

of corresp ondences b etween the structural descriptions, a

numerical structural evaluation of the overall quality of

the match, and a set of candidate inferences represent
ing the surmises ab out the prob e sanctioned by the com
parison. In subsequent pro cessing, the structural evalu
ation provides one source of information ab out how se
riously to take the match, and the candidate inferences

provide p otential new knowledge ab out the prob e which

must b e tested and evaluated by other means. We imple
ment this computation using SME, the Structure-Mapping

Engine (Falkenhainer, Forbus & Gentner, 1989).

We use literal similarity rather than analogy in order

to get the high observed frequency of surface remindings,

which would mostly b e rejected if FAC were strictly an

analogy matcher. We b elieve this choice is ecologically

sound b ecause mundane matches are often the b est guides

to action. Riding a new bicycle, for instance, is often just

like riding other bicycles (Gentner, 1989; Medin & Ortony,

1989). Asso ciating actions with particular complex de
scriptions makes go - d computational sense b ecause such

asso ciations can often b e made b efore one can delinate

exactly which asp ects of a situation are relevant.

Currently FAC selects as output the b est match, based

on its structural evalution, and any others within 10% of

it. In pilot studies we have exp erimented with various cri
teria, such as broadening the p ercentage, selecting a xed

numb er, and so forth. We settled on the 10% criteria b e
cause it generally returns a single result, only pro ducing

multiple results when there are two extremely close can
didates. Dep ending on the assumptions one makes ab out

subsequent pro cessing, a mo dication which places a strict

upp er b ound on the numb er pro duced (say, two) may also

b e appropriate.

Sometimes a prob e reminds us of nothing. There are

several ways this can arise in the MAC/FAC mo del. First,

the FAC stage may not receive any candidates from the

MAC stage (see b elow). Second, FAC might reject all can
didates provided. This shows up by no match hyp othe
ses b eing created; this has - ccurred, alb eit rarely. Third,

there could b e a threshold on structural evaluations, so

that matches b elow a certain quality simply were not con
sidered. We view this as psychologically plausible, but do

not include such thresholds currently b ecause we have not

yet found go - d constraints on them.

The MAC stage

Even though the FAC stage is reasonably ecient4

, it is to 

3

In current AI systems indexing often yields a unique de

exp ensive to consider running it exhaustively on realistic
sized memories as the \inner lo op" in an analogical pro
cessing system. The MAC stage uses an extremely cheap

matcher to estimate how well FAC would rate comparisons,

to lter candidates down to a manageable numb er.

One estimate is the numb er of match hyp otheses that

FAC would generate in comparing a prob e to a memory

item, the numerosity of the comparison. If very few lo
cal matches are hyp othesized, then clearly the b est global

interpretation cannot b e large. On the other hand, nu
merosity is not a p erfect estimator, since having a large

numb er of lo cal matches do es not guarentee a large global

interpretation. This is true b ecause (1) match hyp otheses

can end up b eing ungrounded b ecause some of their argu
ments cannot b e placed into corresp ondence (and are thus

ignored), and (2) the mutual incompatibilities intro duced

by the 1:1 constraint may prevent a single large interpre
tation from forming, yielding instead several small ones.

The most straightforward way to compute numerosity

is to actually generate and count the match hyp otheses.

This is what our original version of MAC/FAC did (Gentner,

1989). It also partly what ARCS (Thagard et al 1990) do es.

ARCS builds much of the network which ACME would build

b etween target and base but b etween the prob e and every

item in memory. We view these solutions as psychologi
cally and computationally implausible. Even with parallel

and/or neural hardware, it is hard to see how the exp ense

of generating match hyp othesis networks b etween a prob e

and everything in a large p - ol of memory can provide re
alistic resp onse times. Instead, we turn to a novel means

of estimating numerosity.

Let P b e the set of functors (i.e., predicates, functions,

and connectives) used in the descriptions that constitute

scription; we view this prop erty as unlikely to scale. For ex
ample, there could b e dozens or even hundreds of exp eriences

which are similar enough to b e put in the same index entry, yet

dierent enough to make it worthwhile to save them as distinct

to generate a global interpretation, using the greedy merge

algorithm of Forbus & Oblinger (1990).

4

O(n2

) for match hyp othesis generation, where n is the

2

))

numb er of items in base or target, and roughly O(l og (n

memories.

Figure 1: The MAC/FAC mo del

**P** **r** **o** **b** **e**

S

E
L

E
C

T
O

R

|Col1|Col2|C - Ve c t o r<br>M a t c h e r|
|---|---|---|
||||
||||
||||
||||

**M** **e** **m** **o** **r** **y**

**M** **A** **C** **S** **t** **a** **g** **e** **F** **A** **C** **S** **t** **a** **g** **e**

memory items and prob es. We dene the content vector

of a structured description as follows. A content vector

is an n-tuple of numb ers, each comp onent corresp onding

to a particular element of P. Given a description D, the

value of each comp onent of its content vector indicates

how many times the corresp onding element of P - ccurs

in D. Comp onents corresp onding to elements of P which

do not app ear in statements of D have the value zero.

One simple algorithm for computing content vectors is to

simply to count the numb er of - ccurrences of each functor

in the description. Thus if there were four - ccurrence s of

IMPLIES in a story, the value for the IMPLIES comp onent

of its content vector would b e four5 . Thus content vectors

are easy to compute from a structured representation and

can b e stored economically.

The MAC matcher works as follows: Each memory item

has a content vector stored with it. When a prob e enters,

its content vector is computed. A score is computed for

each item in the memory p - ol by taking the dot pro d
uct of its content vector with the prob e's content vector.

These scores are fed to the MAC selector, which pro duces

as output the b est match and everything within 10% of it,

as in the FAC stage. (We plan to add a threshold so that

if every match is to - low MAC returns nothing.)

Clearly, measuring similarity using content vectors has

critical limitations, since the actual relational structure is

not taken into account. But the dot pro duct can b e used

to estimate relative similarity, since it is a go - d approx
imation to numerosity. (Essentially, the pro duct of each

corresp onding comp onent is an overestimate of the num
b er of match hyp otheses that would b e created b etween

functors of that typ e.) Content vectors are insucient b e

cause they do not provide the corresp ondences and candi
date inferences which provide the p ower of analogy. But

by feeding MAC's results to the structural matcher of the

FAC stage, we obtain the required inferential p ower.

This MAC matcher has the prop erties we desire. It is

cheap, and could b e implemented using a variety of mas
sively parallel computation schemes, including connec
tionist. Next, we demonstrate that MAC/FAC provides a

go - d approximation of psychological data.

Computational Exp eriments

We have successfully tested MAC/FAC on a variety of de
scriptions, including simple metaphors and physics sce
narios. Here we compare the p erformance of MAC/FAC

with that of human subjects, using the \Karla the Hawk"

stories. For these studies, we wrote sets of stories con
sisting of base stories plus four variants, created by

systematically varying the kind of commonalities. All

stories share rst-order relations, but vary as follows:

Common Common

h.o. relations object attributes

LS: Yes Yes

SF: No Yes

AN: Yes No

FOR: No No

5

We have also exp erimented with normalized content vec

As discussed ab ove, subjects rated analogy (AN) and

literal similarity (LS) as more sound than surface (SF)

and FOR matches (matches based only on common rst
order relations, primarily events). Previously, we tested

SME running in analogy mo de on SF and AN matches and

found that it correctly re
ected these human soundness

rankings (Forbus & Gentner, 1989; Skorstad et al, 1987).

Here we seek to capture human retrieval patterns: Do es

MAC/FAC duplicate the human prop ensity for retrieving SF

and LS matches rather than AN and FOR matches. The

idea is to give MAC/FAC a memory set of stories, then prob e

with various new stories. To count as a retrieval, a story

must make it through b oth MAC and FAC.

tors, to minimize the eects of size discrepancies. So far we

have seen no signicant empirical dierence b etween these al
gorithms, but we susp ect that normalization will b e necessary

when adding retrieval thresholds.

Table 1: Prop ortion of correct retrievals given dierent

kinds of prob es

1. Memory contains 9 base stories and 9 FOR matches; prob es

were the 9 LS, 9 SF, and 9 AN stories.

2. The rows show prop ortion of times the correct base story

was retrieved for dierent prob e typ es.

Prob es MAC FAC

LS 1.0 1.0

SF 0.89 0.89

AN 0.67 0.56

In the psychological exp eriment, the human subjects

had a memory set consisting of 32 stories, of which 20

were base stories and 12 were distractors. They were later

presented with 20 prob e stories which matched the base

stories as follows: 5 LS matches, 5 AN matches, 5 SF

matches and 5 FOR matches and told to write down any

prior stories of which they were reminded. The prop or
tions of remindings for dierent match typ es were .56 for

LS, .53 for SF, .12 for AN and .09 for FOR. Across three

variations of this study, this retrievability order has b een

stable: LS SF - AN FOR.

For the computational exp eriments, we enco ded predi
cate calculus representations for 9 of the 20 story sets (45

stories). These stories are used in all three exp eriments

describ ed b elow.

Simulation Experiment 1. In our rst study, we put the

9 base stories in memory, along with the 9 FOR stories

which served as distractors. We then used each of the

variants { LS, SF, and AN { as prob es. This roughly

resembles the original task, but MAC/FAC's job is easier

b ecause (1) it has only 18 stories in memory, while subjects

had 32, in addition to their vast background knowledge;

(2) subjects were tested after a week's delay, which may

have caused some memory deterioration.

Table 1 shows the prop ortion of times the base story

made it through MAC and through FAC. MAC/FAC's p erfor
mance is much b etter than that of the human subjects,

p erhaps partly b ecause of the dierences noted ab ove.

However, its results show the same ordering as those of

human subjects: LS - SF - AN.

Simulation Experiment 2. To give MAC/FAC a stronger

challenge, we put the four variants of each base story into

memory. This made a larger memory set (36 stories) and

also one with many comp eting similar choices. Each base

story in turn was used as a prob e. This is almost the

reverse of the task subjects faced, and is more dicult.

Table 2 shows the mean numb er of matches of dierent

similarity typ es that succeed in getting through MAC and

through FAC. There are several interesting p oints here.

First, the retrieval results (i.e., the numb er that make

it through b oth stages) ordinally match the results for

human subjects: LS - SF - AN - FOR. This degree of

t is encouraging, given the dierence in task. Second,

as exp ected, MAC pro duces some matches that are rejected

by FAC. This numb er dep ends partly on the criteria for

the two stages. Here, with MAC and FAC b oth set at 10%,

Table 2: Mean numb ers of dierent match typ es retrieved

when base stories used as prob es

1. Memory contains 36 stories (LS, SF, AN, and FOR for 9

story sets); the 9 base stories used as prob es

2. Other = any retrieval from a story set dierent from the one

to which the base b elongs.

Retrievals MAC FAC

LS 0.78 0.78

SF 0.67 0.44

AN 0.33 0.11

FOR 0.22 0.0

Other 1.33 0.22

Table 3: Mean numb ers of dierent match typ es retrieved

with base stories as prob es

1. Memory contains 27 stories (9 SF, 9 AN, 9 FOR); 9 base

stories used as prob es.

Retrievals MAC FAC

SF 0.89 0.78

AN 0.56 0.45

FOR 0.22 0.11

Other 1.11 0.11

the mean numb er of memory items pro duced by MAC is

3.3, and the mean numb er accepted by FAC is 1.5. Third,

as exp ected, FAC succeeds in acting as a structural lter

on the MAC matches. It accepts all of the LS matches

MAC prop oses and some of the partial matches (i.e., SF

and AN), and while rejecting most of the inappropriate

matches (i.e., FOR and matches with stories from other

sets).

Simulation Experiment 3. In the prior simulation, LS

matches were the resounding winner. While this is re
assuring, it is also interesting to know which matches

are retrieved when there are no p erfect overall matches.

Therefore we removed the LS variants from memory and

rep eated the second simulation exp eriment, again probing

with the base stories. As Table 3 shows, SF matches are

now the clear winners in b oth the MAC and FAC stages.

Again, the ordinal results match well with those of sub
jects: SF - AN - FOR.

Summary of Simulation Experiments. The results are

encouraging. First, MAC/FAC's ordinal results match those

of human subjects. In contrast, the closest comp eting

mo del, Thagard et al's (1991) ARCS mo del of similarity
based retrieval, when given the Karla the hawk story in

memory (along with 100 fables as distractors) and the

four similarity variants as prob es, pro duced two viola
tions in its order of asymptotic activation. Its asymptotic

activations were LS (.67), FOR (-.11), SF (-.17), AN (
.27). Thus MAC/FAC explains the data b etter than ARCS.

This is esp ecially interesting b ecause Thagard et al argue

that a complex lo calist connectionist network which in
tegrates semantic, structural, and pragmatic constraints

is required to mo del similarity-based reminding. While

such mo dels are intriguing, MAC/FAC shows that a simpler

mo del can provide a b etter account of the data.

Finally, and most imp ortantly, MAC/FAC's overall pat
tern of b ehavior captures the motivating phenomena: (1)

it pro duces a large numb er of LS matches, thus satis
fying the primacy of the mundane criterion; (2) it pro
duces a fairly large numb er of SF matches, thus satisfying

the fallibility criterion; (3) it pro duces a small numb er of

analogical matches, thus satisfying the existence of rare

events criterion; and nally, (4) its algorithms are simple

enough to apply over large-scale memories, thus satisfying

the scalability criterion.

Discussion

We have presented MAC/FAC, a two-stage similarity-based

mo del of access. The MAC stage uses content vectors, a

novel summary of structured representations, to provide

an inexp ensive \wide net" search of memory, whose re
sults are pruned by the more exp ensive literal similarity

matcher of the FAC stage to arrive at useful, structurally

sound matches. We demonstrated that MAC/FAC can sim
ulate the patterns of access exhibited by human subjects.

We b elieve that the psychological issues MAC/FAC raises

are worth further study. MAC/FAC is reasonably ecient,

even on serial machines, so we b elieve it could b e a useful

comp onent in p erformance-oriented AI systems also.

In addition to the psychological issues raised earlier,

there are several computational studies in preparation us
ing MAC/FAC. These include:

Experiments with larger know ledge bases: A crucial ques
tion for any access mo del is how well it scales to sub
stantially larger memories. Two avenues we are exploring

are: (1) using the CYC knowledge base as a source of

descriptions and (2) using MAC/FAC as a to ol on the ILS

Story Archive Project to aid in sp otting p otentially rele
vant links b etween stories.

Larger-scale process models: Several psychological ques
tions ab out access cannot b e studied without emb edding

MAC/FAC in a more comprehensive mo del of analogical

pro cessing. For example, there is ample evidence that

subjects can \tune" their similarity judgements when the

items b eing compared are b oth already in working mem
ory. While it seems clear that MAC is imp enetrable, it

is hard to tell whether or not FAC is tunable or whether

a separate similarity engine is required. Order eects in

analogical problem solving (Keane, in press) suggest the

latter. How can the access system b e used to incremen
tally construct abstractions and indexing information to

help structure long-term memory (c.f. Skorstad, Gentner,

and Medin 1988)?
