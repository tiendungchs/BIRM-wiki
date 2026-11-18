# plotkin-1970-note-on-inductive-generalization

> Converted from `plotkin-1970-note-on-inductive-generalization.pdf` on 2026-11-18 via `pymupdf4llm`.
> Layout artefacts (broken equations, interleaved columns) are conversion noise, not the source.

---

### 8

#### A Note on Inductive Generalization

Gordon D. Plotkin

Department of Machine Intelligence and Perception
University of

In the course of the discussion on Reynolds' (1970) paper in this volume, it
became apparent that some of our work was related to his, and we therefore present it here.

R.J.Popplestone originated the idea that generalizations and least
generalizations of literals existed and would be useful when looking for
methods ofinduction. We refer the reader to his paper in this volume for
an account of some of his methods (Popplestone 1970).

Generalizations of clauses can also be of interest. Consider the following
induction:

The result of heating this bit of iron to 419°C was that it melted.
The result of heating that bit of iran to 419°C was that it melted.
The result of heating any bit of iron to 419°C is that it melts:
We can formalize this as:

Bitofiron (bit I) A Heated (bit 1,419):::> Melted (bit I)
Bitofiron (bit 2) A Heated (bit 2,419):::> Melted (bit 2)
(x) Bitofiron _(x)_ A Heated _(x,_ 419) :::> Melted _(x)_
Note that both antecedents and conclusion can be expressed as clauses in
the usual first-order language with function symbols. Our aim is to find a
rule depending on the form of the antecedents which will generate the
conclusion in this and similar cases. It will turn out that the conclusion is
the least generalization of its antecedents.

We say that the literal _L1_ is more general than the literal 14 if £117=£2 for
some substitution c. For clauseswe say that.the clause CI ismore general than
the clause C2if Ct subsumes _C2._ Although the implication relationship might
give interesting results, the weaker subsumption relationship allows a more
manageable theory. For example, we do not even know whether implication
between clauses is a decidable relationship or not.

A least generalization of some clauses or literals is a generalization which
is less general than any other such generalization. For example, _P(g(x),_ x)
is a least generalization of _{P(g(a()), a()), P(g(b()), b())}_ and _P(g(x),_ x)

153

MECHANIZED REASONING

is a least generalization of _{Q(x)v P(g(aO),_ aO), _R(x)v_ _P(g(bO),_ :bOn.
We give another, more complex example taken froma board game situation
later in the paper. OUf logical language is that of Robinson (1965). MacLane '
and Birkhoff (1967) is a good reference for our algebraic language.

PRELIMINARIES

We will use the symbols _t,_ tI, _U,_ ••• for terms, _L,_ LI, _M,_ _._ . . for literals, '
_D,_ DI, _D,_ ... for clauses, _<p_ for a function symbol or a predicate symbol or
the negation sign followed by a predicate symbol.

A _word_ is a literal or a term. We will use the symbols _V,_ Vb _W,_ ... for
words.

We denote sequences of integers, perhaps empty, by the symbols _I, J,_ ....
We say that _t_ is in the _lth_ place in _W_ iff:
when _l=_ <), _t=_ Wor
##### when l= <it,, in), then W has the form <P(tl' . ", tm) and and t

is in the _Ciz._, _in)th_ place in _tit._ For example, _x_ is in the <)th place in x,
the (2)th place in _g(y, x)_ and in the <3, 2)th place in _Pea, b, g(y, x»._

Note that _t_ is never in the <)th place in _L._ We say that _t_ is _in W,_ if _t_ is in
the _lth_ place in Wfor some _I._

WI _Wz_ (read 'WI is more general than _Wz')_ iff _W1cr= Wz_ for some
substitution cr. For example, _P(x, x,[(g(y)))_ _1(3),_ _j(g(x)))._
We can take _0'= {1(3)_ [x, _xIY}._

Cl _Cz_ (read _'C1_ is more general than _Cz')_ iff _Cl<T£_ Czfor some substitution

_0'._ CI _Cz_ means that Cl subsumes _Cz_ in the usual terminology. For example,
_P(x)v P(fO)_ We can take _0'=_ {[Olx}.
In both cases,the relation is a quasi-ordering, We have chosen to write
rather than _LI";i:;Lz_ as Reynolds (1970) does, because in the case of
clauses, is 'almost' s, Further, if _Ll_ is the universal closure ofLand _D_ is
the element of the Lindenbaum algebra corresponding to _Li,_ then we have
_L_ _1_ _«i;_ iff _Ll-+.£!_ iff

WORDS

Suppose that we can show that a property holds for variables and constants,
and that whenever it holds for lx,..., _t;_ then it holds for _<p(tt._ •••, _tn)._
Then the property holds for all words. This method of proof is called induetion on words.

We write WI'""" _Wz_ when _W2_ and _WI._ As is a quasi-ordering,
this defines an equivalence relation. It is known that _WI'""" W2_ iff WI and _Wz_
are alphabetic variants.

Two words are _compatible_ iffthey are both terms or have the same predicate
letter and sign.

If _K_ is a set of words, then _W_ is a _leastgeneralization_ of _K_ iff:
1. For every Vin _K,_ _V._
2. If for every _V_ in _K,_ WI _V,_ then _WI_ _W._

154

PLOTKIN

It follows from 2 that if WI, _Wz_ are any two least generalizations of _K,_
then _WI-WZ._

We can define also the least generalization as a product in the following
category. The objects are the words and _a_ is a morphism from _V_ to _W_ iff

_Vcr=_ W'and _a_ acts as the identity, e, on variables not in _V._ Vis then a least
generalization of _{Wi,_ _Wz}_ iff it is a product of WI and _Wz._ We could also
have defined the dual of the least generalization. This would just be the most
general unification of Robinson (1965) and would be the coproduct in the
above category. This approach was suggested in a personal communication
by R. M. Burstall, but we have not followed it up to any degree.

_Theorem_ 1,
Every non-empty, finite set of words has a least generalization iff any two
words in the set are compatible.

Let _WI,_ _Wz_ be any two compatible words. The following algorithm
terminates at stage 3, and the assertion made there is then correct.
1. Set Vf to Wf(i= 1,2). Set Sf to s(i= 1,2). s is the empty substitution.
2. Try to find terms th _tz_ which have the same place in VI, _V2_ respectively
and such that h =l= _tz_ and either _tt_ and _tz_ begin with different function letters or
else at least one of them is a variable.
3. If there are no such _ti,_ _tz_ then halt. VI is a least generalization of _{WI,_ _Wz}_
and _Vl= V2,_ Vf8 f = _W_ _i(i=l,_ _2)._
4. Choose a variable _x_ distinct from any in _VI_ or _Vz_ and wherever _tl_ and _tz_
occur in the same place in _VI_ and _V2,_ replace each by _x._
5. Change Sf to _{t_ _ilx }si(i = l, 2)._
6. Go to 2.
_Example._ We will use the algorithm to find a least generalization of

_{P(f(aO, g(y»,_ _x, g(y))_, _P(h(aO, g(x»,_ _x, g(x))}._
Initially,

_VI=P(f(aO,_ _g(y»,_ _x,_ _g(y»_
_Vz=P(h(aO,_ _g(x»,_ _x, g(x»._
We take _tl=y,_ _tz=x_ and _z_ as the new variable. Then after 4,

_Vl=P(f(aO, g(z»,_ x, _g(z»_
_Vz=P(h(aO, g(z»,_ _x, g(z»_
and after 5,

SI= _{Ylz},_ Sz= {x]s}.
Next, we take _l1=f(aO,_ _g(z»,_ _t2=h(aO,_ _g(z»_ and _y_ as the new variable.
After 4 and 5, . .
_VI_ = _P(y,_ _x, g(z»_ = _Vz_

Sl= _{f(aO,g(z»)ly}{yjz}_

_=_ _{f(aO, g(y»)[y, Ylz}_
_82= {h(aO, g(z»ly}_ {xlr}
_= {h(aO,_ _g(x»IY,_ _x[z}._
The algorithm then halts with _P(y, x, g(z»)_ as the least generalization.

155

MECHANIZED REASONING

_Proof_ Evidently the compatibility condition is necessary. Let _{WI,_ ..., _Wn }_
be a finite compatible set of words. If _n=_ 1, then the theorem is trivial.
Suppose that the algorithm works and that inf _{V, W}_ is the result of
applying it to Vand _W._ Then it is easy to see that

inf _{WI>_ inf _{W2,_ ..., inf _{Wn- l,_ _Wn }_ ••• }}
is a least generalization of the set. Hence we need only show that the
algorithm works.

The rest of the proof proceeds as follows. In order to avoid a constant
repetition of the conditions on 11, 12 given in 2, we say that 11 and 12 are
_replaceable_ in _VI_ and _V2_ iff they fulfil the conditions of 2.

To show that the algorithm halts and that when it does _VI_ = _V2,_ we define
a _difference_ function by _difference_ _(VI,_ _V2)_ = number of members of the set
_{Ilif_ 11, 12 _are both in the Ith place in_ _Vi>_ _V2 respectively_ _then they are_ _replace-_
_ablein VIand V2 }_ _._ We also denote by _V{,_ Vi the result of replacing _tl_ and 12in

VI, _V2_ by _x_ in the way described in 4.

Lemma 1.2 then shows that every time a pair of replaceable terms is
replaced the difference drops. Consequently by lemma 1.1 it will eventually
##### become zero and when it does, lemma 1.1 shows that we must have VI = V2

and the algorithm will then halt.

We still have to show that the replacements take usin the correct direction.
##### First of all, VI < Vi since by lemma 1.3, VI { 1iI x} = Vj. It is also immediate

from this that when the algorithm halts, VISI=Wi' Now suppose that _W_ is
any lower bound of _{Wl._ _W2}._ Then a lower bound _Vis_ a product of Wi, _W2_
if the diagram of figure 1 can always be filledin along the dotted line, so that
it becomes commutative in a unique way.

Figure!

The category is the one defined above. In it there is either one or no
morphisms between any two objects and hence it is not necessary in figure 1
to name the morphisms. Indeed, if a diagram can be filled in at all, it can be
filled in commutatively and uniquely.

We show in lemma 1.4 that the diagram on figure 2 can be filled in commutatively.

156

PL OTKI N

Thus every time a replacement is made, the _Vi_ are greater than any lower
bound of WI, _Wz._ Consequently when the algorithm halts, wehave a product.
We now give the statements and proofs of the lemmas.

_W_

#### """"

### _r,_

Figure 2
_Lemma_ _1.1_
If _VI_ and _Vz_ are distinct compatible words, then there are _tl, tz_ which are
replaceable in them.
_Proof._ By induction on words on _VI._ If one of VI, _Vz_ is a constant or a

variable, or if they begin with different function symbols, then _VI,_ _Vz_ will
do for tl, _tz_ respectively.

If _VI_ is _<p(t}, .. ., tD_ and _Vz_ is _<p(tr,_ ..., then for some _i,_ _t},l:tr_ and
by the induction hypothesis, applied to _tl,_ there are Uj, _Uz_ which are replace##### able in r], tr and as tf, tr have the same place in VI, V2 respectively, they are

also replaceable in _VI,_ _V2._ _._
_Lemma_ _1.2_
If _VI, V2_ are distinct compatiblewords, then _Difference (V{,_ _V£)_ < _Difference_
_(VI,_ _Vz)._
_Proof._ By induction on words on _VI._ If one of _VI_ or _V2_ is a variable or a
constant then _tl= VI, tz=_ Vzand _V{_ = _V5.=x,_ so 0= _Difference_ ( _VI'_ _V2)_ < 1=

_Difference_ (Vl> _Vz)._

If _VI_ is/(vj, ..., _vn)_ and _Vz_ is _g(ul,_ ..., u",) where/i=g, then if _t,= V,(i=_
1, 2), 0= _Dijference_ ( _V_ {, _V2)_ < _Difference_ ( Vj, _V2 )_ _,_ by lemma l.1; otherwise,
#### Dijference(V;, = 1+ I Dijference(vi, u;)

1= l,m in(m.n)
#### <1+ I Differencei u, u;)

_i_ = l,min(m.n)
(by induction hypothesis, since _m, n;6_ 0)
#### =Dijference (Vl, V2 ) . In the remaining case

where _VI_ and _Vz_ both have the form _fP(tl, . ._ ., _tn),_ a similar but less complicated argument applies.
_Lemma_ _1.3_

_Vl{tdx }_ = Vi(i=l, 2) .
_Proof._ Since _Vi_ is obtained from _Vi_ by replacing some occurrences of _t,_ in

_Vi_ by _x,_ and since _x_ does not occur in _Vi'_ substituting _t_ _i_ for _x_ in _Vi_ will
produce _VI'_ _(i=_ 1,2).

157

MECHA NIZED REASONING

_Lemma_ _1.4_
If _VI,_ _V2_ are distinct compatible words and _VO'I=VI(i=_ 1,2), then there are
#### 0'{,0'5. so that VO'i= VHi =1,2).

_Proof._ It is convenient to denote by _l_ _i(U!> U2,_ t1. _t2)_ the result of applying
##### the operation of 4 to Ul, U2 on ui(i = 1, 2).

Let _0',={ufl Yt>_ _..., ui"IYm}_ _(i =_ _1, 2) ;_
_vi_ = /;( _u{,_ _t_ _1,_ _t2 )(_ i= 1, _2;j_ _=_ 1, _m);_

_0';= {vfiYl"'"_ _vf'/y",}_ (i=l, 2).
By lemma 1.3, 2). We show by induction on _V,_ that:
##### if V, VI, V2 are such that VO'l = Vi(i= 1,2), then VO';=V\(i= 1,2). Suppose that V is a constant, then V = VI = V2 and the result is trivial.

Suppose that Vis a variable, _y._ If _Y¢Yl_ for _i=l, m_ then _y= V= Vl= V2_ and
the result is again trivial. If _Y=YI_ say, then _VO'f=/,(VI,_ _V2,;t1._ _t2)=Vi._
Suppose Vis _cp(_ _u},_ .. ., un) then if _V/= cp(w{, ._, 0' _._

_VU[=cp(U1U[, .._ " _UnO';_ _)_ =cp( wi" 0" w,:) (by the induction hypothesis)
_=_ _Vi·_
This concludes the proof.

The next lemma is used in the proof of the existence of least generalizations
of clauses.
_Lemma_ 2

Let _K=_ { _W;I_ i = 1, _n}_ be a set of words with a least generalization _W_ and
##### substitutions Il,(i= 1, n) so that Wil l = WI(i= 1, n) . 1. If t is in W then t is a least generalization of { til.! i = 1, n}.

2. If _x, y_ _are_ variables in Wand _X/li=Y/l l(i=_ 1, _n)_ then _x =y._
_Proof._ 1. Evidently, _t_ is a generalization of _{til;! i=_ 1, _n }._ Suppose _u_ is any

other and that _UA.i_ _=t/l,(i=_ 1, _n) ._ Let _U7:_ be an alphabetic variant of _u_ such
that _U7:,_ _W_ have no common variables. Let _W'_ be _W,_ but with _t_ replaced by

_U7:_ wherever _t_ occurs in _W._ Then C I Ai U _Il,_ is defined- this follows from the
construction of 7:- and _W'_ ( t-1AIUIlI) = _WI(i=_ 1, _n)._ Hence there is a v so
that _W'_ v= _W,_ as _W_ is a least generalization of { Wd _i_ = 1, _n}_ . Hence _U_ (rv) =

_(U7:_ ) V= _t._ Hence, _t_ is a least generalization of _{til,_ Ii = 1, _n}._

2. Suppose that _y ¢ x._ Let _W'= W{Ylx} ._ Then _W',_ Ware not alphabetic
variants, but _W::;;; W'._ Let _W=_ _W[x,Y,_ _Y3_ _,_ ' . ., _Ym],_ where _x,_ _Y,Y3,·_ .., _Ym_
are the distinct variables of _W._ We have,

_W,= Wll i=_ _W[Xll j, Y/l"_ _Y3/li'_ .. " _Ym/l;]_

_=_ _W[Y/l I' YIl_ _l> Y31lb_ .. " _Ymlli_ _]_ (by hypothesis)
_=_ _Wry_ _,Y,Y3,_ .. " _Ym]/l,_
_=_ _W Il I(by_ construction). _(i=_ 1,n).
This contradicts the fact that _W_ is a least generalization of { _W;!_ i= 1, _n}._
_Hencey= x._
This completes the proof.

158

PLOTKIN

CLAUSES

Just as we did with words, we write _C",D,_ when _C:;;,D_ and _D:;;,C._ This
defines an equivalence relation. We also say that C is a least generalization
of a set of clauses, S, when:

1. FQr every _E_ in S, _C:;;'E._
2. Iffor every _E_ in S, _D:;;'E,_ then _D:;;,C._
Any two least generalizations of S are equivalent under _r«,_ However, when
C1- _Cz,_ C1 and C2 need not be alphabetic variants. For example, take

Cl= _{P(x), P(f())} ;_ _C2= {P(f())}._
It turns out that there is a reduced member of the equivalence class, under

 -, of any clause. This member is unique to within an alphabetic variant.
C is _reduced_ iff _D_ S C, _D_ - C implies that C;;;; _D._ In other words, C is reduced
iff it is equivalent to no proper subset of itself.
_Lemma_ 3

If _Cp.=C,_ then C and _CIl_ are alphabetic variants.
_Proof_ We regard C as a set ordered by:;;" and suppose without loss of
generality that _p._ acts as the identity on variables not in C. Let _L_ be in C. The
sequence _L=Lll_ <sup>_o_</sup> _,_ _Lp.l=Lp.,Lp.2,_ . . . is increasing relative to :;;,. As C is
finite and all members of 'the sequence are in C, it follows that for some
_i,_ Hence for some _N_ and for all Lin C, _LJ1N_
As _Cp.=_ C, there is an _M_ in _C_ so that _MJ1N=L,_ given _L_ in C. Hence, _L=_
_MJ1N_ - _Mp.N+l =LJ1,_ and so _p._ maps variables into variables. But as _Cp.=_ C,
C and _Cf.L_ have the same number of variables. Hence p.maps distinct variables
of C to distinct variables of _CJ1,_ and so C and Cp. are alphabetic variants,
thus completing the proof.

**_7-_**
If C", _D,_ and C and _D_ are reduced, then they are alphabetic variants. The
following algorithm gives a reduced subset, _E,_ of C such that _E",C._

1. Set _Eto_ C.
2. Find an _L_ in C and a substitution _a_ so that _EfJSE"",-_ _{L}._
If this is impossible, stop.

3. Change _E_ to _EfJ_ and go to 2.
(It is necessary to be able to test for subsumption in order to carry out
stage 2. Robinson ( 1965) gives one way to do this.)
_Proof_ As _C-D,_ there are _u,_ Y so that _Cp.sD,_ _b-s:«:_ Hence, _Cp.vsC._
#### But C is reduced so Cf.LV =C. Hence by lemma 3, p» maps the variables of C

into the variables of C in a 1-1 manner. Hence C and _D_ are alphabetic
variants.

The algorithm halts at stage 2, since the number of literals in _E_ is reduced
by at least one at stage 3 and so if it does not halt before then, it will halt
when this number is 1. If _C=@,_ then it will halt on first entering 2.

There is always a _p._ so that _Cp.sE._ For at stage 1, take _J1=0._ If one has such

159

MECHANIZED REASONING

a _f.l_ before stage 2, then _lUI_ will be one after stage 2. Hence,' when the
algorithm halts, _Cpf;E_ and _Ef;C,_ and then _C",E._ _._
Suppose _E_ is not reduced at termination. Then there is a proper subset
_E'_ of _E_ so that _E'_ '" _E._ So there is a _a_ such that _Ba_ f; _E'_ .Pick _L_ in _E""--E'._
Then _Eu_ s; _E'_ f; _E""--_ { _L_ }. This contradicts the fact that the algorithm has
terminated and completes the proof.

This theorem is useful as our method of producing least generalizations of
clauses tends to give clauses with many literals which may often be sub
stantiallyreduced by the above procedure.

Let S= _{Ci!i=_ 1, _n}_ be a set of clauses.
A set of literals, _K={Lili=_ 1, _n}_ is a _selection_ from S iff _LiECi(i=_ 1, _n)._
We can now state the main theorem.

_tTheorem 3Z_

Every finite set, S, of clauses has a least generalization which is not _fJ_ iff
S has a selection. If _Ci_ and _Cz_ are two clauses with at least one selection, then.
the following algorithm gives one of their least generalizations.

Let S={Cx, _C2},_ and let the selections from S be _{L}, Lr_ } _(1_ = 1, _n)_ where
_L{_ is in _Cj •_ Suppose that _L{=(± )p/(tlz,_ _...,_ where _(± )P_ is either
_P,_ or _Pl._ Let.li be a function letter with _k/_ places _(l_ = _n),_ and let _P_ be a
predicate letter with _n_ places. Let _M,_ be the literal .

_P(!l_ _(t{l'_ ..., _till),_ ..., _fn(t{m_ ..., _tinn)) (j=_ 1,2).

Find the least generalization of _{Mh_ _M2}_ by the method of theorem 1.
Suppose that this is

_M=P(fi_ (Ull' ..., _Ukl1)'_ •• _•,!n(U1m_ •• " _Ukn_ _)) ._ Let C be the clause

_{(± P)i(UW_ _._ _'_ _"_ _Uk/i)1 i=_ 1, _n}._

Then C is a least generalization of S ={Cl, _Cz}._

Evidently, it is not necessary in any actual calculation to change any _PI_
to the correspondingfi.
_Proof_ We begin by showing that the algorithm works. By theorem 1, there
are _Vi(i=_ 1,2) so that _MVi=Mi._ Fromlemma 2, it follows that _fi(Ulb_ .•.,

_Ukfi)_ is a least generalization of _{fi(tL,'.._ _",_ _ti_ _1i )U=_ _1,_ 2}.

Hence _L l_ _=_ (± _)Pi(U1b_ ..., _Ukji)_ is a.least generalization of _Ll}(i=_
_1, n)._

Hence _CVi=_ _{LDs;Ci_ and so C is a generalization of {Cr, _C2 }_ _._
_1=1_
Note also that by lemma 2, if _XVi=yvi(i=_ 1,2), then _x=y._
Now suppose that _E_ is any generalization of { _Cl,_ _Cz}._ We show that _E_ C.
Let _lXi_ be chosen so that _ElXif;Ci._ _(i=1,2),_ and let _E= {Mh_ _•••_ _,_ _M m} ._
_{MplXili=1,2}_ will be a selection, say _{LhLj,}._ Consequently,
the corresponding least generalization of the selection, and there is a _j3p_
so that _Mp{Jp=Lp'._

160

PLOTKIN

_m_
Hence, if u{3p exists, _E(ul3p)£_ _C_ and we will have finished. Now _ufJp_
p=l
exists precisely if, whenever _x_ is an individual variable in _M p1_ and _M p ]._

_(PI_ _¥=pz)_ then _xfJPl =xfJp].._ Let the notation _(A,_ _B_ literals; 0: a substitution) mean _Acx=B._ We have shown that the relationships described by
figure 3 hold:

_(i, k=_ I, 2)

. Figure 3

Now _x{3PI<_ is a term in 1, 2), which is a least generalization of
Hence, by lemma 2, _xl3Pk_ is a least generalization of _{xl3PkYl,_
##### x!3PkVZ} = {xO:l, xaz} from the diagram, (k= 1,2).

Consequently, _x{3P1'_ _x{3pz_ are alphabetic variants. Let _x},_ _Xz_ be variables
having the same place in _x/3Pl'_ _xfJpz_ respectively. Then as _xI3P1Vi=XfJPzVi=_
_xai(i=_ 1,2), it follows that _X1Vi=XZVi(i=_ 1,2). Hence by our note 011 the
properties of the _vi(i=_ 1,2) at the beginning of the proof, Xl _=xz._ Hence
_xfJPl =x{3p:z.'_ and _u/3p_ exists and C and so C is a least generalization of
{Cl, _Cz}._

Next, we note that C is not empty and indeed if a particular combination
of sign and predicate letter occurs in a selection from {Cl, _Cz}_ then it occurs
in C. Suppose that S= _{Ci}(i=_ 1, _q)_ is a finite set of clauses. If C _(:;6RJ)_ is a
generalization of S, there are _ai_ so that _Cai£ Gi,_ and if _L_ is in C, _{Lail i=_ 1, _q}_
is'a selection. On the other hand, _RJ_ is a generalization of S. Hence if S has no
selection its only, and hence its least, generalization is 0. Otherwise, by
nesting infs as in the proof of theorem I, we can find a least generalization
of S which, by the note at the beginning of this paragraph, will not be 0.
This completes the proof.

**AN** **EXA IVI PLE**
Suppose that some two-person game is being played on a board with two
squares, 10 and 20 and that the positions in figure 4 are won positions for
the first player: '
# Ixloll-xl-xl

Position Pi 0

Position _pzO_

FigUre 4

M

161

MECHANIZED REASONING

lOis the name of the left hand side square, and 20 of the right hand square;
PI0 and P20 are the names of the positions and _00,_ _XO_ are the names of
##### the marks 0, x: We describe the fact that these positions are wins by means

of the following two clauses:

1. Occ(lO, _XO,PI0)VOcc(20,_ 00,PI0)VWin(pI0).
_2._ _Occ(lO._ XO,P20) _VOcc(20,_ XO,PzO) _VWin(pzO)·_

The course of the calculation is indicated as follows:

_Occ(lO,_ XO.PIO) _Occ(lO._ _XO.p)_
_Occ(lO,_ _XO.P20)_ _Occ(lO._ _XO,p)_
OCC(lO. XO.PI0) _Occ(10,_ _XO.p)_ _Occ(nh_ _XO,p)_
_Occ(20,_ XO,pzO) _Occ(20._ _XO,p)_ _Occ(nh_ _XO,p)_

_Occ(20._ 00,PIO) _Occ(20, OO,p)_ _Occ(20, OO,p)_ _Occ(nz,_ _OO,p)_ _Occ(n2, x,p)_
_Occ(lO,_ XO,PzO) _Dec_ (1 0, _XO,p)_ _Occ(lO._ _XO,p)_ _Occ(nz,_ _XO,p)_ _Occ(n2, x,p)_

_Occ(20,_ 00,PIO) _Occ(20. OO,p)_ _Occ(20,_ _OO,p)_ _Occ(20, OO.p)_ _Occ(20, x,p)_
_Occ(20,_ XO,pzO) _Occ(20,_ _XO,p)_ _Occ(20._ _XO,p)_ _Occ(20._ _XO,p)_ _Occ(20, x,p)_

_Win_ (PI 0) _Win(p)_
_Win(p2_ (» _Win_ _(p)_
As indicated above, we have not replaced predicate symbols by function
symbols, and we have left _P_ implicit. Each vertical column displays _M,_ and
_M_ _z_ at an instance of stage 2 of the algorithm of theorem 1. In a given column,
the pairs of literals are corresponding arguments in _Ml_ and _M2._ We find

_t1_ and _tz_ by searching through _M;_ and _M2_ from left to right. As soon as two
literals have become the same in a column, we do not mention them in
subsequent columns.

Thus the least generalization is:

_Occ(lO,_ _XO,p)_ _VOcc(nl._ _X(),p)_ _VOcc(n2, x,p)_ VOcc(20, _x,p)_ _VWin(p)._

We use the algorithm of theorem 2. We can take _L=Occ(nl,_ _XO,p),_
_0'=_ {I 0 InI}. This gives
_Ca=Occ(l_ 0, _XO,p)_ _VOcc(n2, x,p)_ VOcc(20, _x,p)_ _VWin(p)._
Next, we can take _L=Occ(n2, x,p)_ and _0'=_ {20Inz} and obtain

Ca=Occ(lO, _XO,p)_ _VOcc(20,_ _x,p)_ _VWin(p)._
The algorithm stops at this point. The final clause says that if a position has
an _X_ in hole 1 and hole 2 has something in it, then the position is a win,
. which, given the evidence, is fairly reasonable.

We leave it to the reader to verify that the conclusion of the inductive
argument given at the beginning of this note is indeed a least generalization
of its antecedents. The main computational weakness in the method for
finding a reduced least generalization lies in that part of the reducing algorithm which requires a test for subsumption, For suppose that we are looking
for the inf of two clauses each with nine literals in a single predicate letter
(this can arise in descriptions of tic-tao-toe, say); there will be at least
eighty-one literals in the raw inf, and we will have to try to tell whether or
not a clause of eighty-one literals subsumes one of eighty.

162

PLOTKIN

FURTHER RESULTS

We give without proof some further results obtained on the algebraic nature
of the relation between clauses.
Let [Cj.denote the equivalence class under >- of C. We say that [C] _[D]_
iff _D._ It is easily seen that this is a proper definition.
The set of equivalence classes forms a lattice with the lattice operations
given by:

[CJn _[D]_ = [inf _{C,_ _D}]_

[C]U _[D]_ =
where c; is a substitution which standardizes the variables of C and _D_ apart.

This lattice is not modular. It has an infinite strictly ascending chain

_[C;]_ 1) where
_Cl={P(XO,_ Xl)}; Cj=Ci_IU{P(Xi_1, _xJ}._
This chain is bounded above by _{P(_ _x,_ _x)_ } .

. There is also a rather complicated infinite strictly descending chain,

_[Gil_ _(i';::_ 1) with the following properties:

1. No literal in any _C,_ contains any function symbols.
2. The clauses are all formed from a single binary predicate letter and a
single unary one.
Any infinite descending chain is bounded below by @. We hope to publish
the proofs elsewhere.

Acknowledgements
I should like to thank my supervisors R.J.Popplestone and R.M.Burstall for all the
different kinds of help they gave me. Particular thanks are due to Dr Bernard Meltzer,
without whose encouragement this paper would not have been written. The work was
supported by an SRC research studentship.

REFERENCES

MacLane, S. & Birkhoff, G. (1967) _Algebra._ New York: Macmillan.
Popplestone, R.J. (1970) An experiment in automatic induction. _Machine_ _Intelligence 5_

pp. 203-15 (eds Meltzer, B. & Michie, D.). Edinburgh: Edinburgh University Press.
Reynolds, J.e. (1970) Transformational systems and the algebraic structure of atomic

formulas. _MachineIntelligence_ 5 pp. 135-52 (eds Meltzer, B. & Michie, D.). Edinburgh:
Edinburgh University Press.
Robinson, J.A. (1965) A machine-oriented logic based on the resolution principle.

_J._ _Ass. comput._ _Mach.,_ 12, 23-41.

163
