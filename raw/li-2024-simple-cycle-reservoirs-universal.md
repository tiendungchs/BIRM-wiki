# li-scr-universal-2024

> Converted from `li-scr-universal-2024.pdf` on 2026-08-18 via `pymupdf4llm`.
> Layout artefacts (broken equations, interleaved columns) are conversion noise, not the source.

---

Journal of Machine Learning Research 25 (2024) 1-28 Submitted 8/23; Revised 3/24; Published 5/24

# **Simple Cycle Reservoirs are Universal**

**Boyu** **Li** boyuli@nmsu.edu
_Department_ _of_ _Mathematical_ _Sciences_
_New_ _Mexico_ _State_ _University_
_Las_ _Cruces,_ _New_ _Mexico,_ _88003,_ _USA_

**Robert** **Simon** **Fong** r.s.fong@bham.ac.uk
_School_ _of_ _Computer_ _Science_
_University_ _of_ _Birmingham_
_Birmingham,_ _B15_ _2TT,_ _UK_

**Peter** **Tiˇno** p.tino@bham.ac.uk

_School_ _of_ _Computer_ _Science_

_University_ _of_ _Birmingham_

_Birmingham,_ _B15_ _2TT,_ _UK_

**Editor:** Christian Shelton

**Abstract**

Reservoir computation models form a subclass of recurrent neural networks with fixed
non-trainable input and dynamic coupling weights. Only the static readout from the state
space (reservoir) is trainable, thus avoiding the known problems with propagation of gradient information backwards through time. Reservoir models have been successfully applied
in a variety of tasks and were shown to be universal approximators of time-invariant fading
memory dynamic filters under various settings. Simple cycle reservoirs (SCR) have been
suggested as severely restricted reservoir architecture, with equal weight ring connectivity of the reservoir units and input-to-reservoir weights of binary nature with the same
absolute value. Such architectures are well suited for hardware implementations without
performance degradation in many practical tasks. In this contribution, we rigorously study
the expressive power of SCR in the complex domain and show that they are capable of universal approximation of any unrestricted linear reservoir system (with continuous readout)
and hence any time-invariant fading memory filter over uniformly bounded input streams.

**Keywords:** Reservoir Computing, Simple Cycle Reservoir, Universal Approximation

**1.** **Introduction**

When learning from time series data it is necessary to adequately account for temporal
dependencies in the data stream. Two main approaches emerged in the machine learning
literature. In the first approach, “time is traded for space” - under the assumption of finite
memory, we collect the relevant time series history in the form of extended input that is
then further processed in a static manner. Various forms of neural auto-regressive models
Lin et al. (1996) or transformers provide examples of this approach Vaswani et al. (2017).
In the second approach, we impose a parametric state-space model structure in which the
state vector dynamically encodes all relevant information in the time series observed so far.
The output is then again read-out from the state in the form of a static readout. Recurrent

_⃝_ c 2024 Boyu Li, Robert Simon Fong, and Peter Tiˇno.

License: CC-BY 4.0, see `[https://creativecommons.org/licenses/by/4.0/](https://creativecommons.org/licenses/by/4.0/)` . Attribution requirements are provided
at `[http://jmlr.org/papers/v25/23-1075.html](http://jmlr.org/papers/v25/23-1075.html)` .

Li, Fong, and Tiˇno

neural networks (e.g. Downey et al. (2017)) and Kalman filters Kalman (1960) are examples
of this work stream.

Of particular interest to us is a class of recurrent neural networks where the state
formation and update part of the architecture is fixed and non-trainable. Models of this
kind Jaeger (2001); Maass et al. (2002); Tiˇno and Dorffner (2001) are known as “reservoir
computation (RC) models” Lukosevicius and Jaeger (2009) with Echo State Networks (ESN)
Jaeger (2001, 2002a,b); Jaeger and Haas (2004) being one of its simplest representatives.
In its basic form, ESN is a recurrent neural network with a fixed state transition part
(reservoir) and a simple trainable linear readout. In addition, the connection weights in
the ESN reservoir, as well as the input weights are randomly generated. The reservoir
weights need to be scaled to ensure the “Echo State Property” (ESP): the reservoir state
is an “echo” of the entire input history and does not depend on the initial state. In
practice, sometimes it is the spectral radius that is the focus of scaling, although in general,
spectral radius _<_ 1 does not guarantee the ESP. However, in this study we focus on ESNs
with linear reservoir dynamics and in this case Grigoryeva and Ortega (2021) proved that
spectral radius _<_ 1 is actually equivalent to the ESP (Proposition 4.2 (i)).

ESNs have been successfully applied in a variety of tasks Jaeger and Haas (2004); Bush
and Anderson (July 2005); Tong et al. (2007). Many extensions of the classical ESN have
been suggested in the literature, e.g. deep ESN Gallicchio et al. (2017), intrinsic plasticity
Schrauwen et al. (2008); Steil (2007), decoupled reservoirs Xue et al. (2007), leaky-integrator
reservoir units Jaeger et al. (2007), filter neurons with delay-and-sum readout Holzmann
and Hauser (2009) etc.

Given the simplicity of ESN, it is natural to ask what is their representational power,
compared with the general class of time-invariant fading memory dynamic filters. In a series
of influential papers, Grigoryeva and Ortega rigorously studied this question and showed
the “universality” of ESN as simple yet powerful approximators of fading memory filters
Grigoryeva and Ortega (2018b,a). Universal approximation capability was first established
in the _L_ <sup>_∞_</sup> sense for deterministic, as well as almost surely uniformly bounded stochastic
inputs Grigoryeva and Ortega (2018a). This was later extended in Gonon and Ortega (2019)
to _L_ <sup>_p_</sup>, 1 _≤_ _p_ _<_ _∞_ and not necessarily almost surely uniformly bounded stochastic inputs.
Crucially, ESN universality can be obtained even if the state transition dynamics is linear,
provided the readout map is polynomial Grigoryeva and Ortega (2018a).

However, the above results are existential in nature and the issue of what exactly the
fixed reservoir and input-to-reservoir couplings should be remains an open problem. Indeed,
the specification of such couplings requires numerous trials and even luck Xue et al. (2007)
and strategies to select different reservoirs for different applications have not been adequately devised. Random connectivity and weight structure of the reservoir is unlikely to
be optimal. Moreover, imposing a constraint on the spectral radius of the reservoir matrix
is a weak tool to set the reservoir parameters Ozturk et al. (2007).

Rodan and Tiˇno (2010) posed the following question: What is the minimal number of
degrees of freedom in the reservoir design to achieve performances on par with the ones
reported in the reservoir computation literature? The answer was rather surprising: It is
often sufficient to consider connections forming a simple cycle (ring) among the reservoir
units, all connections with the same weight. As for the input-to-reservoir coupling, in
the case of linear reservoirs with non-linear readout, all that matters is the sign pattern

2

Simple Cycle Reservoirs are Universal

across the input weights, the absolute value of the weights can be the same (e.g. set to
1). While such extremely constrained reservoir architectures are well suited for hardware
implementations Coarer et al. (2018); Appeltant et al. (2011); Nakajima et al. (2021), it
is less obvious to understand why simple cycle reservoirs (SCR) appear to be sufficient in
many applications. Some headway in this direction has been made along the lines of memory
capacity Rodan and Tiˇno (2010) and temporal feature spaces Tiˇno (2020). Here we ask a
different question: Can it be that simple cycle reservoir structures are actually universal
in the sense outlined above? We will show that in the complex domain (cyclic coupling of
reservoir units with the same (complex) weight; input-to-reservoir couplings constrained to
_±_ 1, _±i_ ) the answer is “yes”! If we constrain the input-to-reservoir couplings to _±_ 1, a twin
SCR is needed with two reservoir cycles operating in parallel on the same input stream.

**2.** **The** **Setup**

Let us first briefly recall the notion of fading memory property in the context of our study.
Consider input-output systems (filters) that map _{_ **c** _t}t∈_ Z _−_ _⊂_ C <sup>_m_</sup> to _{_ **y** _t}t∈_ Z _−_ _⊂_ C <sup>_d_</sup> with
the imposition that at each _t_ the output **y** _t_ is determined only by the past inputs _{_ **c** _t′}t′≤t_ .
Such systems are called causal.

We would now like to characterise situations where the influence of inputs from deeper
past on the present output is gradually fading out. In other words, under such inputoutput systems, given a time instance _t_, two input sequences **c** and **c** <sup>_′_</sup> having “similar recent
histories” up to time _t_ (but not necessarily the deeper past ones) will yield “similar outputs”
at _t_ . This can be formalised for example through topological arguments as follows (see e.g.
(Grigoryeva and Ortega, 2018a)): Consider a norm _∥·∥_ on C <sup>_m_</sup> . The infinite product space
consisting of left-infinite sequences _{_ **c** _t}t∈_ Z _−_ can be endowed with a Banach space structure
by considering e.g. the supremum norm assigning to each sequence **c** = _{_ **c** _t}t∈_ Z _−_ the norm

_∥_ **c** _∥∞_ := sup

_t∈_ Z _−_

_∥_ **c** _t∥_ _._

If we wanted to assign more weight on the recent items than on the past ones, we could
modify the supremum norm into a weighted norm,

_∥_ **c** _∥_ **w** := sup

_t∈_ Z _−_

_∥wt ·_ **c** _t∥_ _,_

where **w** = _{wt}t∈_ Z _−_ is a weighting sequence, i.e. a strictly decreasing sequence (in the
reverse time order) of positive real numbers with a fixed maximal element (e.g. _w_ 0 = 1).
The space _{_ **c** _∈_ (C <sup>_m_</sup> ) <sup>Z</sup> <sup>_−_</sup> _|_ _∥_ **c** _∥_ **w** _<_ _∞}_ equipped with the weighted norm _∥·∥_ **w** forms a
Banach space <sup>1</sup> (Grigoryeva and Ortega, 2018b). Analogously, given a (possibly different)
weighting sequence **v** = _{vt}t∈_ Z _−_, we define a norm on the output left-infinite sequences
**y** = _{_ **y** _t}t∈_ Z _−_, _∥_ **y** _∥_ **v** := sup _t∈_ Z _−_ _∥vt ·_ **y** _t∥_ (the norm _∥·∥_ is this time defined on C <sup>_d_</sup> ). We now
require the maps realised by the causal input-output systems be continuous with respect to
the topologies generated by the weighted norms _∥·∥_ **w** and _∥·∥_ **v** . Such input-output systems
are said to have the _fading_ _memory_ _property_ (FMP) <sup>2</sup> .

1. In the case of uniformly bounded inputs (the setting of this study), all left-infinite sequences have finite
weighted norm.
2. We note that the systems we study in this paper will have a stronger FMP, in particular, the _λ_ -exponential
FMP, for some 0 _< λ <_ 1, where the elements of the weighting sequence are given by _wt_ = _e_ <sup>_λt_</sup> . However,

3

Li, Fong, and Tiˇno

We now proceed by introducing the basic building blocks needed for the developments
in this study.

**Definition** **1** _A_ **_linear_** **_reservoir_** **_system_** _is_ _formally_ _defined_ _as_ _the_ _triplet_ _R_ := ( _W, V, h_ )
_where_ _the_ **_dynamic_** **_coupling_** _W_ _is_ _an_ _n × n_ _matrix,_ _the_ **_input-to-state_** **_coupling_** _V_ _is_
_an_ _n × m_ _matrix,_ _and_ _the_ _state-to-output_ _mapping_ _(_ **_readout_** _)_ _h_ : C <sup>_n_</sup> _→_ C <sup>_d_</sup> _is_ _a_ _(trainable)_
_continuous_ _function._

_The_ _corresponding_ _linear_ _dynamical_ _system_ _is_ _given_ _by:_

         **x** _t_ = _W_ **x** _t−_ 1 + _V_ **c** _t_
(2.1)
**y** _t_ = _h_ ( **x** _t_ )

_where_ _{_ **c** _t}t∈_ Z _−_ _⊂_ C <sup>_m_</sup> _,_ _{_ **x** _t}t∈_ Z _−_ _⊂_ C <sup>_n_</sup> _,_ _and_ _{_ **y** _t}t∈_ Z _−_ _⊂_ C <sup>_d_</sup> _are_ _the_ _external_ _inputs,_ _states_
_and_ _outputs,_ _respectively._ _We_ _abbreviate_ _the_ _dimensions_ _of_ _R_ _by_ ( _n, m, d_ ) _._

_We_ _make_ _the_ _following_ _assumptions_ _for_ _the_ _system:_

_1._ _W_ _is_ _assumed_ _to_ _be_ _strictly_ **_contractive_** _._ _In_ _other_ _words,_ _its_ _operator_ _norm_ _∥W_ _∥_ _<_ 1 _._
_The_ _system_ (2.1) _thus_ _satisfies_ _the_ _fading_ _memory_ _property_ _(FMP)._

_2._ _We_ _assume_ _the_ _input_ _stream_ _is_ _{_ **c** _t}t∈_ Z _−_ _is_ **_uniformly_** **_bounded_** _._ _In_ _other_ _words,_
_there_ _exists_ _a_ _constant_ _M_ _such_ _that_ _∥_ **c** _t∥≤_ _M_ _for_ _all_ _t ∈_ Z _−._

_The_ _contractiveness_ _of_ _W_ _and_ _the_ _uniform_ _boundedness_ _of_ _input_ _stream_ _imply_ _that_ _the_
_images_ _of_ _the_ _inputs_ **c** _∈_ (C <sup>_m_</sup> ) <sup>Z</sup> <sup>_−_</sup> _under_ _the_ _linear_ _reservoir_ _system_ _live_ _in_ _a_ _compact_ _space_
_X_ _⊂_ C <sup>_n_</sup> _._ _With_ _slight_ _abuse_ _of_ _mathematical_ _terminology_ _we_ _call_ _X_ _a_ **_state_** **_space_** _._

Under the assumptions outlined above in Definition 1, for each left infinite time series
_c_ = _{_ **c** _t}t∈_ Z _−_, the system (2.1) has a unique solution given by

**x** _t_ ( _c_ ) =

_n≥_ 0

_W_ <sup>_n_</sup> _V_ **c** _t−n,_

**y** _t_ ( _c_ ) = _h_ ( **x** _t_ ( _c_ )) _._

To ease the mathematical notation we will refer to the solution simply as _{_ ( **x** _t,_ **y** _t_ ) _}t_ .

**Definition** **2** _For_ _two_ _reservoir_ _systems_ _R_ = ( _W, V, h_ ) _(with_ _dimensions_ ( _n, m, d_ ) _)_ _and_
_R_ <sup>_′_</sup> = ( _W_ <sup>_′_</sup> _, V_ <sup>_′_</sup> _, h_ <sup>_′_</sup> ) _(with_ _dimensions_ ( _n_ <sup>_′_</sup> _, m, d_ ) _):_

_1._ _We_ _say_ _the_ _two_ _systems_ _are_ **_equivalent_** _if_ _for_ _any_ _input_ _stream,_ _the_ _two_ _systems_
_generate_ _the_ _same_ _output_ _stream._ _More_ _precisely,_ _for_ _any_ _input_ _c_ = _{_ **c** _t}t∈_ Z _−_ _,_ _the_
_solutions_ _{_ ( **x** _t,_ **y** _t_ ) _}t_ _and_ _{_ ( **x** <sup>_′_</sup> _t_ <sup>_,_</sup> <sup>**y**</sup> <sup>_′_</sup> _t_ <sup>)</sup> <sup>_}t_</sup> <sup>_for_</sup> <sup>_systems_</sup> <sup>_R_</sup> <sup>_and_</sup> <sup>_R′,_</sup> <sup>_given_</sup> <sup>_by:_</sup>

<sup>_′_</sup> _t_ <sup>_,_</sup> <sup>**y**</sup> <sup>_′_</sup> _t_

<sup>_′_</sup> _t_ <sup>)</sup> <sup>_}t_</sup> <sup>_for_</sup> <sup>_systems_</sup> <sup>_R_</sup> <sup>_and_</sup> <sup>_R′,_</sup> <sup>_given_</sup> <sup>_by:_</sup>



 _and_



**y** _t_ = _h_ ( **x** _t_ ( _c_ )) = _h_



 <sup>�</sup>

_j≥_ 0



_W_ <sup>_j_</sup> _V_ **c** _t−j_

 _,_

_W_ <sup>_′_</sup> <sup>�</sup> <sup>_j_</sup> _V_ <sup>_′_</sup> **c** _t−j_

**y** <sup>_′_</sup> _t_ <sup>=</sup> <sup>_h′_</sup> <sup>�</sup>

**x** <sup>_′_</sup> _t_

- = _h_ <sup>_′_</sup>

 <sup>�</sup>

_j≥_ 0

<sup>_′_</sup> _t_ <sup>(</sup> <sup>_c_</sup> <sup>)</sup>

_respectively,_ _satisfy_ **y** _t_ = **y** <sup>_′_</sup> _t_ <sup>_for_</sup> <sup>_all_</sup> <sup>_t._</sup>

for the case of uniformly bounded inputs we study here, the _λ_ -exponential FMP implies FMP for any
weighting sequence (Grigoryeva and Ortega, 2018a).

4

Simple Cycle Reservoirs are Universal

_2._ _For_ _ϵ_ _>_ 0 _,_ _we_ _say_ _the_ **_two_** **_systems_** **_are_** _ϵ_ **_-close_** _if_ _the_ _outputs_ _of_ _the_ _two_ _systems,_
_given any input stream, are ϵ-close._ _That is (under the notation above), ∥_ **y** _t −_ **y** <sup>_′_</sup> _t_ <sup>_∥_</sup> 2 <sup>_< ϵ_</sup>

_for_ _all_ _t._

**Remark** **3** _Since_ _norms_ _on_ _finite-dimensional_ _spaces_ _are_ _equivalent,_ _we_ _can_ _replace_ _the_ 2 _-_
_norm_ _in_ _the_ _definition_ _of_ _ϵ-close_ _by_ _any_ _other_ _norm_ _on_ C <sup>_d_</sup> _._ _Our_ _main_ _results_ _do_ _not_ _depend_
_on_ _the_ _particular_ _choice_ _of_ _the_ _norm._ _All_ _subsequent_ _norms_ _over_ _scalar_ _fields_ _are_ 2 _-norms_
_unless_ _specified_ _otherwise._

**Remark** **4** _Our notion of system equivalence differs from the more structural (iso)morphism_
_approaches_ _sometimes_ _taken_ _in_ _control_ _and_ _systems_ _theory._ _For_ _example,_ _the_ _system_ _equiva-_
_lence in Grigoryeva and Ortega (2021) is treated as system isomorphism, that is, equivalence_
_not_ _only_ _in_ _terms_ _of_ _filter_ _map_ _equivalence_ _-_ _“the_ _same_ _inputs_ _leading_ _to_ _the_ _same_ _outputs”_

_-_ _but_ _also_ _equivalence_ _in_ _terms_ _of_ _preservation_ _of_ _the_ _internal_ _dynamics._ _In_ _particular,_ _it_
_involves_ _a_ _map_ _between_ _the_ _states_ _of_ _the_ _two_ _systems:_ _two_ _systems_ _are_ _isomorphic_ _if_ _there_
_is_ _a_ _bijection_ _f_ _that_ _maps_ _the_ _states_ _of_ _one_ _system_ _R_ 1 _to_ _the_ _states_ _of_ _another_ _system_ _R_ 2
_such_ _that_ _f_ _preserves_ _the_ _state_ _evolution,_ _as_ _well_ _as_ _the_ _readout._

For the rest of the section, we outline the main results of the paper. We begin by
following definitions:

**Definition** **5** _Let_ _P_ = [ _pij_ ] _be_ _an_ _n × n_ _matrix._

_1._ _We_ _say_ _P_ _is_ _a_ **_permutation_** **_matrix_** _if_ _there_ _exists_ _a_ _permutation_ _σ_ _in_ _the_ _symmetric_

_group_ _Sn_ _such_ _that_ _pij_ =

1 _,_ _if_ _σ_ ( _i_ ) = _j,_

0 _,_ _if_ _otherwise._

_2._ _We_ _say_ _a_ _permutation_ _matrix_ _P_ _is_ _a_ **_full-cycle_** **_permutation_** <sup>3</sup> _if_ _its_ _corresponding_
_permutation_ _σ_ _∈_ _Sn_ _is_ _a_ _cycle_ _permutation_ _of_ _length_ _n._

Let _P_ be an _n × n_ permutation matrix associated with _σ_ _∈_ _Sn_, and let _{ei}_ <sup>_n_</sup> _i_ =1 <sup>be</sup> <sup>the</sup>

canonical basis for C <sup>_n_</sup> . One can easily verify that _Pei_ = _eσ_ ( _i_ ), which defines a permutation
of the basis vectors by _σ_ .

We call a matrix _W_ **a** **contractive** **permutation** (resp. **a** **contractive** **full-cycle**
**permutation** if _W_ = _aP_ for some scalar _a_ _∈_ (0 _,_ 1) _⊂_ R and _P_ is a permutation (resp.
full-cycle permutation).

Rodan and Tiˇno (2010) introduced a minimum complexity reservoir system with a
contractive full-cycle permutation dynamical coupling matrix. In the following definition,
we recall its linear form, as well as its extension to input-to-state coupling in the complex
domain:

**Definition** **6** _A_ _linear_ _reservoir_ _system_ _R_ = ( _W, V, h_ ) _with_ _dimensions_ ( _n, m, d_ ) _is_ _called:_

_•_ _A_ **_Simple_** **_Cycle_** **_Reservoir_** **_(SCR)_** <sup>4</sup> _if:_

3. Also called left circular shift or cyclic permutation in the literature
4. Note that in Rodan and Tiˇno (2010) there is an additional requirement that the sign pattern in the
binary input-to-state coupling _V_ is a-periodic. Also, although all the input weights have the same
absolute value, it does not have to be 1. The sign aperiodicity and scaling of the input weights are not
needed for the developments in this study.

5

Li, Fong, and Tiˇno

_1._ _W_ _is_ _a_ _contractive_ _full-cycle_ _permutation,_ _and_

_2._ _V_ _∈_ M _n×m_ ( _{−_ 1 _,_ 1 _}_ ) _._

_•_ _A_ **_Complex_** **_Simple_** **_Cycle_** **_Reservoir_** **_(_** C **_-SCR)_** _if:_

_1._ _W_ _is_ _a_ _contractive_ _full-cycle_ _permutation,_ _and_

_2._ _V_ _∈_ M _n×m_ _and_ _all_ _entries_ _of_ _V_ _are_ _either_ _±_ 1 _or_ _±i_ _._

We also introduce a composite reservoir structure with multiple contractive full-cycle
permutation couplings and binary input weights:

**Definition** **7** _For_ _k_ _>_ 1 _,_ _a_ _linear_ _reservoir_ _system_ _R_ = ( _W, V, h_ ) _with_ _dimensions_ ( _n, m, d_ )
_is_ _called_ _a_ **Multi-Cycle** **Reservoir** **of** **order** _k_ _if:_

_1._ _W_ _is_ _block-diagonal_ _with_ _k_ _(not_ _necessarily_ _identical)_ _blocks_ _of_ _contractive_ _full-cycle_
_permutation_ _couplings_ _W_ 1 _,_ _...,_ _Wk,_ _of_ _dimensions_ _ni × ni,_ _i_ = 1 _,_ 2 _, ..., k,_

_k_

_i_ =1

_W_ :=

 _W_ 1



_W_ 2

_..._



 _,_

_ni_ = _n,_

_Wk_

_and_

_2._ _V_ _∈_ M _n×m_ ( _{−_ 1 _,_ 1 _}_ ) _._

The state **x** _∈_ C <sup>_n_</sup> of such a multi-cycle system is composed of the _k_ component states
**x** <sup>(</sup> <sup>_i_</sup> <sup>)</sup> _∈_ C <sup>_ni_</sup>, _i_ = 1 _,_ 2 _, ..., k_, **x** = ( **x** <sup>(1)</sup> _, ...,_ **x** <sup>(</sup> <sup>_k_</sup> <sup>)</sup> ). In our case, the readout will act on a linear
combination of the component states,

_h_ ( **x** ) = _h_

where _ai_ _∈_ C are mixing coefficients.

- _k_

 - _ai ·_ **x** <sup>(</sup> <sup>_i_</sup> <sup>)</sup>

_i_ =1

_,_

Of particular interest will be simple multi-cycle structures with identical full-cycle
blocks:

**Definition** **8** _A_ _linear_ _reservoir_ _is_ _called_ _a_ **Simple** **Multi-Cycle** **Reservoir** **(SMCR)**
**of** **order** _k_ _if_ _it_ _is_ _a_ _Multi-Cycle_ _Reservoir_ _of_ _order_ _k_ _with_ _k_ _<u>identical</u>_ _(contractive_ _full-cycle_
_permutation)_ _blocks._

Finally, we introduce a minimal version of the multi-cycle reservoir system with just two
(not necessarily identical) blocks:

**Definition** **9** _A linear reservoir is called a_ **Twin Simple Cycle Reservoir (Twin SCR)**
_if_ _it_ _is_ _a_ _Multi-Cycle_ _Reservoir_ _of_ _order_ 2 _._

6

Simple Cycle Reservoirs are Universal

We note that while this study considers contractive dynamics (by requiring the operator
norm of the state space coupling to satisfy _∥W_ _∥_ _<_ 1), for the FMP to hold one only needs
a weaker condition on _W_ involving the spectral radius, namely _ρ_ ( _W_ ) _<_ 1. FMP under the
stronger condition _||W_ _|| <_ 1 has been established in Jaeger (2010) or Grigoryeva and Ortega
(2019)(Theorem 7). Under the weaker condition _ρ_ ( _W_ ) _<_ 1 it can be shown using the ESP
property in Grigoryeva and Ortega (2021)(Proposition 4.2 (i)) together with Manjunath
(2022)(Theorem 3).

**2.1** **Summary** **of** **Essential** **Notations**

We conclude this section by summarizing the essential mathematical notations used in the
subsequent sections.

Fields are denoted by blackboard-bold capital letters, for example, R _,_ C and K denote
real numbers, complex numbers and arbitrary field respectively. In addition, we denote by
T _⊂_ C the unit circle in C. The set M _m×n_ (K) contains all _m_ -by- _n_ matrices over the field
K. Given an _n_ -by- _m_ matrix _W_ _∈_ M _n×m_, _∥W_ _∥_ denotes its operator norm. Hilbert spaces
are written in calligraphic font such as _H_ .

Capital letters typically denote matrices with some symbols reserved for specially structured matrices. Examples include _P_ for permutation matrices, _U_ for unitary matrices, and
D for diagonal matrices (unless specified otherwise). The exceptions are:

_•_ _M_  - the uniform upper bound of input stream.

_•_ _J_ : C <sup>_n_</sup> _�→_ C <sup>_n′_</sup>  - the canonical embedding of C <sup>_n_</sup> onto the first _n_ -coordinates of C <sup>_n′_</sup>

with _n_ <sup>_′_</sup> _≥_ _n_, and

_•_ _Qn_ : C <sup>_n_</sup> <sup>1</sup> _�→_ C <sup>_n_</sup>  - the canonical projection of the first _n_ coordinates ( _n_ 1 _≥_ _n_ ).

Bold lower case letters such as **v** _∈_ K <sup>_n_</sup> denote column vectors with the assumption that
K = C throughout the paper, unless specified otherwise. For vectors **v** _∈_ K <sup>_n_</sup>, _∥_ **v** _∥_ = _∥_ **v** _∥_ 2
denotes its Euclidean norm. Vector valued left infinite time series are indexed with a
subscript _t_, denoted by _{_ **x** _t}t∈_ Z _−_ _⊂_ C <sup>_n_</sup> . For vectors **x** _∈_ C <sup>_n_</sup>, the entries are denoted
by ( _x_ 1 _, x_ 2 _, . . ., xn_ ) <sup>_⊤_</sup> . In the case where there are multiple reservoir systems involved, the
state vectors of the _i_ <sup>_th_</sup> reservoir system would be indicated with an additional upper script
**x** <sup>(</sup> _t_ <sup>_i_</sup> <sup>)</sup> _∈_ C <sup>_n_</sup> .

**3.** **Summary** **of** **Main** **Results**

Motivated by the minimum complexity reservoir architecture Rodan and Tiˇno (2010), our
main goal is to study the universality properties of such radically constrained reservoir
structures with simple cyclic interconnections in the dynamic coupling and binary input
weights.

The flow of our argumentation is summarized in Figure 1 below. Each arrow in the
diagram denotes an approximation step. The symbol _≺_ indicates an increase in the approximant state space dimensionality. In particular, we show (Theorem 20) that <u>any</u> linear
reservoir system (2.1) can be approximated by a Complex Simple Cycle Reservoir. The
situation changes if we wanted to constrain the input weights solely to _{−_ 1 _,_ +1 _}_ as in the

7

Li, Fong, and Tiˇno

minimum complexity reservoirs Rodan and Tiˇno (2010), while maintaining the universal approximation capabilities. One can either use a Twin Simple Cycle Reservoir (Theorem 21),
or further insist on identical cyclic reservoir blocks (which may be advantageous from a
hardware implementation point of view), in which case a Simple Multi-Cycle Reservoir of
order greater than 2 may be needed (Theorem 15). The details of each approximation step
will be fleshed-out and summarized in more technical manner in Section 7.

**Universality** **of** **linear** **Reser-**
**voir** **System** **with** **Unitary** **Dy-**
**namical** **Coupling**

**Linear** **Reservoir** **System**

**Universality** **of** **linear** **Reser-**
**voir** **system** **with** **Cyclic** **Per-**
**mutation** **Dynamical** **Coupling**

**Definition** **8**

**Universality** **of**
C **-SCR,**
**Definition** **6**

**Universality** **of**
**Twin** **SCR**,
**Definition** **9**

Figure 1: Flow of the main results of this paper

Crucially, these results enable us to connect to the work of Grigoryeva and Ortega
(2018a)(Corollary 11) proving that linear reservoir systems with polynomial readouts are
universal: any time-invariant fading memory filter can be approximated by a linear reservoir system. Since we show that our extremely constrained reservoir cyclic structures can
approximate to arbitrary precision any linear reservoir system with continuous (hence also
polynomial) readout, we end up with a rather surprising conclusion: Any time-invariant
fading memory filter can be approximated to arbitrary precision by (i) a C-SCR, (ii) a
SMCR, and (iii) a Twin SCR. Yet, besides the reservoir size, they all have a <u>single</u> <u>degree</u>
<u>of</u> <u>freedom</u> <u>in</u> <u>the</u> <u>reservoir</u> <u>dynamic</u> <u>coupling</u> _W_ - the cycle weight parameter _λ_ (spectral
radius of _W_ ). To summarize: C-SCR, SMCR, and Twin SCR are all universal reservoir
structures with a single tunable reservoir weight parameter.

Last, but not least, all our poofs are constructive. Hence, given any linear reservoir
structure, we can explicitly construct its simple approximator with a single tunable parameter, which can be of vital importance in hardware implementations of reservoir systems
Coarer et al. (2018); Appeltant et al. (2011); Nakajima et al. (2021).

8

Simple Cycle Reservoirs are Universal

**4.** **Unitary** **Dilation** **of** **Linear** **Reservoirs**

As an intermediate step towards constructing C-SCR approximators we first establish approximation capabilities of linear reservoir systems with unitary dynamic coupling _W_ . In
particular, using the Dilation Theory we show that given any linear reservoir system and
_ϵ_ _>_ 0, we can construct an _ϵ_ -close linear reservoir system with unitary _W_ . We begin by
introducing notions from the Dilation Theory.

Dilation Theory is a branch in operator theory that seeks to embed a linear operator in
another with desirable properties. Given an _n × n_ matrix _W_ _∈_ M _n×n_ over C with operator
norm _∥W_ _∥≤_ 1, Halmos (1950) observed that one can embed _W_ in a unitary operator

_U_ ˜ =

- _W_ _DW ∗_
_DW_ _−W_ <sup>_∗_</sup>

where _DW_ = ( _I_ _−_ _W_ <sup>_∗_</sup> _W_ ) <sup>1</sup> <sup>_/_</sup> <sup>2</sup> and _DW ∗_ = ( _I_ _−_ _WW_ <sup>_∗_</sup> ) <sup>1</sup> <sup>_/_</sup> <sup>2</sup> . Here, _∥W_ _∥≤_ 1 is necessary so
that _I −_ _WW_ <sup>_∗_</sup> and _I −_ _W_ <sup>_∗_</sup> _W_ are positive semidefinite. We notice that in this construction,
however, the information on _W_ is lost when we try to compute powers of _U_ <sup>˜</sup>, as _U_ <sup>˜</sup> <sup>2</sup> no longer
has _W_ <sup>2</sup> in the upper left block. The seminal work of Sz.-Nagy (1953) (see also, Sch¨affer
(1955)) proved that one can find a unitary operator _U_ on an infinite-dimensional Hilbert
space _H_ and an isometric embedding _J_ : C <sup>_n_</sup> _→H_ such that _W_ <sup>_k_</sup> = _J_ <sup>_∗_</sup> _U_ <sup>_k_</sup> _J_ for all _k_ _∈_ Z.

The space _H_ in Sz.Nagy’s dilation is necessarily infinite-dimensional in general. However,
if we only require _W_ <sup>_k_</sup> = _J_ <sup>_∗_</sup> _U_ <sup>_k_</sup> _J_ for all 1 _≤_ _k_ _≤_ _N_, a result of Egerv´ary (1954) shows that
this can be achieved with the following ( _N_ + 1) _n ×_ ( _N_ + 1) _n_ unitary matrix _U_ :



_W_ 0 0 _· · ·_ _· · ·_ 0 _DW ∗_
_DW_ 0 0 _· · ·_ _· · ·_ 0 _−W_ <sup>_∗_</sup>





0 _I_ 0 _· · ·_ _· · ·_ 0 0
... 0 ... ... ...
... ... ... ... ...
... ... 0 ...
0 _· · ·_ _· · ·_ _· · ·_ 0 _I_ 0

_U_ =



_._

The embedding isometry will be now realised by an ( _N_ + 1) _n × n_ matrix _J_ over C. For
more background on Dilation Theory we refer interested readers to Paulsen (2002).

It will often be the case that when we transform one reservoir system into another the
corresponding readout mappings will be closely related to each other. In particular:

**Definition** **10** _Given_ _two_ _functions_ _h, g_ _sharing_ _the_ _same_ _domain_ _D_ _⊂_ K <sup>_n_</sup> _,_ _where_ K <sup>_n_</sup> _is_
_a_ _field,_ _we_ _say_ _that_ _g_ **_is_** _h_ **_with_** **_linearly_** **_transformed_** **_domain_** _if_ _there_ _exists_ _a_ _linear_
_transformation_ _over_ K <sup>_n_</sup> _with_ _the_ _corresponding_ _matrix_ _A_ _such_ _that_ _g_ ( **x** ) = _h_ ( _A_ **x** ) _for_ _all_
**x** _∈_ _D._

We now demonstrate how to use the dilation technique to obtain _ϵ_ -close approximating
reservoir systems with a unitary matrix _W_ .

9

Li, Fong, and Tiˇno

**Theorem** **11** _Let_ _R_ = ( _W, V, h_ ) _be_ _a_ _reservoir_ _system_ _defined_ _by_ _contraction_ _W_ _with_
_∥W_ _∥_ =: _λ_ _∈_ (0 _,_ 1) _and_ _satisfying_ _the_ _assumptions_ _of_ _Definition_ _1._ _Given_ _ϵ_ _>_ 0 _,_ _there_
_exists_ _a_ _reservoir_ _system_ _R_ <sup>_′_</sup> = ( _W_ <sup>_′_</sup> _, V_ <sup>_′_</sup> _, h_ <sup>_′_</sup> ) _that_ _is_ _ϵ-close_ _to_ _R_ _with_ _W_ <sup>_′_</sup> = _λU_ _for_ _a_ _unitary_
_U_ _._ _Moreover,_ _h_ <sup>_′_</sup> _is_ _h_ _with_ _linearly_ _transformed_ _domain._

**Proof** The uniform boundedness of input stream and contractiveness of _W_ imply that the
state space _X_ _⊆_ C <sup>_n_</sup> is closed and bounded, hence compact. The continuous readout map
_h_ is therefore uniformly continuous on the state space _X_ . By the uniform continuity of _h_,
for any _ϵ_ _>_ 0, there exists _δ_ _>_ 0 such that for any **x** _,_ **x** <sup>_′_</sup> _∈_ _X_ with _∥_ **x** _−_ **x** <sup>_′_</sup> _∥_ _<_ _δ_, we have
_∥h_ ( **x** ) _−_ _h_ ( **x** <sup>_′_</sup> ) _∥_ _<_ _ϵ_ . Let _λ_ = _∥W_ _∥_ and let _M_ denote the uniform bound of _{_ **c** _t}_ such that
**c** _t_ _≤_ _M_ for all _t_ . Since _λ <_ 1, we can choose _N_, such that:

2 _M_ _∥V ∥_ 

_t>N_

_∥W_ _∥_ <sup>_t_</sup> = 2 _M_ _∥V ∥_ <sup>_<u>λN</u>_</sup> <sup>+1</sup>

1 _−_ _λ_ <sup>_< δ._</sup>

Let _W_ 1 = _W/λ_ and _n_ <sup>_′_</sup> = ( _N_ + 1) _· n_ . We have _∥W_ 1 _∥_ = 1 and therefore by Egerv´ary’s
dilation, there exists a unitary _n_ <sup>_′_</sup> _× n_ <sup>_′_</sup> matrix _U_ such that for all 1 _≤_ _k_ _≤_ _N_, we have:

_W_ 1 <sup>_k_</sup> <sup>=</sup> <sup>_J_</sup> <sup>_∗U_</sup> <sup>_kJ,_</sup>

where _J_ : C <sup>_n_</sup> _�→_ C <sup>_n′_</sup> is the canonical embedding of C <sup>_n_</sup> onto the first _n_ -coordinates of C <sup>_n′_</sup> .
Let _W_ <sup>_′_</sup> = _λU_, then it follows immediately that:

_W_ <sup>_k_</sup> = _λ_ <sup>_k_</sup> _W_ 1 <sup>_k_</sup> <sup>=</sup> <sup>_J_</sup> <sup>_∗_</sup> <sup>(</sup> <sup>_λU_</sup> <sup>)</sup> <sup>_k J_</sup> <sup>=</sup> <sup>_J_</sup> <sup>_∗_</sup> <sup>�</sup> _W_ <sup>_′_</sup> <sup>�</sup> <sup>_k_</sup> _J._

Define an _n_ <sup>_′_</sup> _× n_ matrix by:

_,_ (4.1)

_V_ <sup>_′_</sup> =

- _V_
0

and the map _h_ <sup>_′_</sup> : C <sup>_n′_</sup> _→_ C <sup>_d_</sup> given by _h_ <sup>_′_</sup> = _h ◦_ _J_ <sup>_∗_</sup>, which is:

_h_ <sup>_′_</sup> ( _x_ 1 _, x_ 2 _, · · ·_ _, xn, · · ·_ _, xn′_ ) := _h_ ( _x_ 1 _, x_ 2 _, · · ·_ _, xn_ ) _._ (4.2)

We now show that the reservoir system _R_ <sup>_′_</sup> = ( _W_ <sup>_′_</sup> _, V_ <sup>_′_</sup> _, h_ <sup>_′_</sup> ) is _ϵ_ -close to _R_ = ( _W, V, h_ ). For
any input stream _{_ **c** _t}t∈_ Z _−_, the states under the reservoir system _R_ <sup>_′_</sup> is given by:

- _W_ <sup>_′_</sup> <sup>�</sup> <sup>_k_</sup> _V_ <sup>_′_</sup> **c** _t−k_ (4.3)

**x** <sup>_′_</sup> _t_ <sup>=</sup>

_k≥_ 0

For each _k_ _≥_ 0, we denote the upper left _n × n_ block of ( _W_ <sup>_′_</sup> ) <sup>_k_</sup> by _Ak_ . In other words:

_W_ <sup>_′_</sup> <sup>�</sup> <sup>_k_</sup> =

- _Ak_ _∗_ 
_._

_∗_ _∗_

This splits into two cases. For each 0 _≤_ _k_ _≤_ _N_, we have _Ak_ = _W_ <sup>_k_</sup> by construction of _W_ <sup>_′_</sup> .
Otherwise, for _k_ _>_ _N_, the power _k_ is beyond the dilation power bound and we no longer

10

Simple Cycle Reservoirs are Universal

have _Ak_ = _W_ <sup>_k_</sup> in general. Nevertheless, since _Ak_ is a submatrix of _W_ <sup>_k_</sup>, its operator norm
is bounded from above:

_∥Ak∥≤_

��� _W k_ ��� _≤_ �� _W ′_ �� _k_ = _λk._

By Equation (4.1), we have _V_ <sup>_′_</sup> **c** _t−k_ =

(4.3) thus becomes:

- _V_ **c** _t−k_
0

and the state **x** <sup>_′_</sup> _t_ <sup>of</sup> <sup>_R′_</sup> <sup>from</sup> <sup>Equation</sup>

and the state **x** <sup>_′_</sup> _t_

**x** <sup>_′_</sup> _t_ <sup>=</sup>

=

=

=

_k≥_ 0

_k≥_ 0

_N_

_k_ =0

�� _Nk_ =0 <sup>_W kV_</sup> <sup>**c**</sup> <sup>_t−k_</sup>

_∗_

_W_ <sup>_′_</sup> <sup>�</sup> <sup>_k_</sup> _V_ <sup>_′_</sup> **c** _t−k_

+

�� _k>N_ <sup>_AkV_</sup> <sup>**c**</sup> <sup>_t−k_</sup>

_∗_

- _Ak_ _∗_ �� _V_ **c** _t−k_
_∗_ _∗_ 0

- _W k_ _∗_ �� _V_ **c** _t−k_
_∗_ _∗_ 0

+

_k>N_

- _Ak_ _∗_ �� _V_ **c** _t−k_
_∗_ _∗_ 0

_._

Let _J_ <sup>_∗_</sup> ( **x** <sup>_′_</sup> _t_

<sup>_′_</sup> _t_ <sup>)</sup> <sup>be</sup> <sup>the</sup> <sup>first</sup> <sup>_n_</sup> <sup>-coordinates</sup> <sup>of</sup> <sup>**x**</sup> <sup>_′_</sup> _t_

<sup>_′_</sup> _t_ <sup>.</sup> <sup>We</sup> <sup>have</sup>

_J_ <sup>_∗_</sup> ( **x** <sup>_′_</sup> _t_ <sup>) =</sup>

_N_

_k_ =0

_W_ <sup>_k_</sup> _V_ **c** _t−k_ +

_k>N_

_AkV_ **c** _t−k._

Comparing this with the state generated by the reservoir system _R_, which is given by:

_k>N_

_N_

- _W_ <sup>_k_</sup> _V_ **c** _t−k_ +

_k_ =0

**x** _t_ =

- _W_ <sup>_k_</sup> _V_ **c** _t−k_ =

_k≥_ 0

_W_ <sup>_k_</sup> _V_ **c** _t−k,_

it follows immediately that:

 ����� _≤_ _k>N_

_∥Ak∥_ +

  _∥V ∥_ _M._
��� _W k_ ���

�� _J_ _∗_ ( **x** _′t_ <sup>)</sup> <sup>_−_</sup> <sup>**x**</sup> <sup>_t_</sup>

�� =

 �����0 + _k>N_

_Ak −_ _W_ <sup>_k_</sup> <sup>�</sup> _V_ **c** _t−k_

Notice we have _∥W_ <sup>_k_</sup> _∥≤∥W_ _∥_ <sup>_k_</sup> = _λ_ <sup>_k_</sup> and we also showed _∥Ak∥≤_ _λ_ <sup>_k_</sup>, and therefore:

_∥J_ <sup>_∗_</sup> ( **x** <sup>_′_</sup> _t_ <sup>)</sup> <sup>_−_</sup> <sup>**x**</sup> <sup>_t∥≤_</sup>

_k>N_

2 _λ_ <sup>_k_</sup> _∥V ∥M_ _< δ._

By Equation (4.2) _h_ <sup>_′_</sup> ( **x** _t_ ) = _h_ ( _J_ <sup>_∗_</sup> ( **x** _t_ )) and by uniform continuity of _h_ we have:

This finishes the proof.

_∥_ **y** _t −_ **y** _t_ <sup>_′_</sup> <sup>_∥_</sup> <sup>=</sup> <sup>_∥h_</sup> <sup>(</sup> <sup>**x**</sup> <sup>_t_</sup> <sup>)</sup> <sup>_−_</sup> <sup>_h_</sup> <sup>(</sup> <sup>_J_</sup> <sup>_∗_</sup> <sup>(</sup> <sup>**x**</sup> <sup>_t_</sup> <sup>))</sup> <sup>_∥_</sup> <sup>_< ϵ._</sup>

11

Li, Fong, and Tiˇno

**5.** **From** **Unitary** **to** **Permutation** **State** **Coupling**

In this section, we show that for any reservoir system with unitary state coupling, we can
construct an equivalent reservoir system with a full cyclic coupling of state units weighted by
a single common connection weight value. To that end, we first show that matrix similarity
of dynamical coupling implies reservoir equivalence.

**Proposition** **12** _Let_ _W_ _be_ _a_ _contraction_ _and_ _let_ _R_ = ( _W, V, h_ ) _denote_ _the_ _corresponding_
_reservoir_ _system._ _Suppose_ _S_ _is_ _an_ _invertible_ _matrix_ _such_ _that_ _W_ <sup>_′_</sup> = _S_ <sup>_−_</sup> <sup>1</sup> _WS_ _and_ _∥W_ <sup>_′_</sup> _∥_ _<_ 1 _._
_Then_ _there_ _exists_ _a_ _reservoir_ _system_ _R_ <sup>_′_</sup> = ( _W_ <sup>_′_</sup> _, V_ <sup>_′_</sup> _, h_ <sup>_′_</sup> ) _that_ _is_ _equivalent_ _to_ _R._

**Proof**
Let _V_ <sup>_′_</sup> = _S_ <sup>_−_</sup> <sup>1</sup> _V_ and _h_ <sup>_′_</sup> ( **x** ) = _h_ ( _S_ **x** ). Given inputs _{_ **c** _t}t∈_ Z _−_, we have the solutions
to the systems _R_ = ( _W, V, h_ ) given by



_W_ <sup>_n_</sup> _V_ **c** _t−n_  _._

**y** _t_ = _h_



 <sup>�</sup>

_n≥_ 0

Similarly the solutions to _R_ <sup>_′_</sup> = ( _W_ <sup>_′_</sup> _, V_ <sup>_′_</sup> _, h_ <sup>_′_</sup> ) is given by:





**y** <sup>_′_</sup> _t_ <sup>=</sup> <sup>_h′_</sup>

**y** <sup>_′_</sup> _t_



 <sup>�</sup>

_n≥_ 0

 _W_ <sup>_′_</sup> <sup>�</sup> <sup>_n_</sup> _V_ <sup>_′_</sup> **c** _t−n_



 _S ·_



( _S_ <sup>_−_</sup> <sup>1</sup> _WS_ ) <sup>_n_</sup> _S_ <sup>_−_</sup> <sup>1</sup> _V_ **c** _t−n_







= _h_

= _h_

_n≥_ 0

_W_ <sup>_n_</sup> _V_ **c** _t−n_

 = **y** _t._

 <sup>�</sup>

_n≥_ 0

This proves that the two systems are equivalent.

We now show that for any given unitary state coupling we can always find a full-cycle
permutation that is close to it to arbitrary precision. This is done by perturbing a given
unitary matrix to one that is unitarily equivalent to a cyclic permutation. It is well known
that the eigenvalues of unitary matrices lie on the unit circle T in C, and the eigenvalues
of cyclic permutations are the roots of unities in C. Given a unitary matrix _U_, we can
therefore first perturb its eigenvalues to a subset of eigenvalues of a cyclic permutation
matrix. The remaining roots of unity (eigenvalues of the cyclic permutation) not covered
by the previous operation are then filled in using direct sum with the diagonal matrix
consisting of the missing eigenvalues.

**Proposition** **13** _Let U_ _be an n×n unitary matrix and δ_ _>_ 0 _be an arbitrarily small positive_
_number._ _There_ _exists_ _an_ _n_ 1 _× n_ 1 _matrix_ _A_ _with_ _n_ 1 _>_ _n_ _that_ _is_ _unitarily_ _equivalent_ _to_ _a_
_full-cycle_ _permutation,_ _and_ _an_ ( _n_ 1 _−_ _n_ ) _×_ ( _n_ 1 _−_ _n_ ) _diagonal_ _matrix_ _D_ _such_ _that:_

   - _U_ 0
���� _A −_ 0 _D_ ����� _< δ._

12

Simple Cycle Reservoirs are Universal

**Proof** Given an integer _ℓ_ _≥_ 1, the complete set of _ℓ_ <sup>_th_</sup> roots of unity, denoted by _Rℓ_ =
_{e_ <sup>_i_</sup> <sup><u>2</u></sup> <sup>_<u>kπ</u>_</sup> _ℓ_ : 0 _≤_ _k_ _≤_ _ℓ_ _−_ 1 _}_ _⊂_ T, is a collection of uniformly positioned points along the

complex circle T. It is well known from elementary matrix analysis that an _ℓ_ _× ℓ_ full-cycle
permutation matrix is unitarily equivalent to a diagonal matrix whose diagonal entries
consist of the complete set _Rℓ_ of _ℓ_ <sup>_th_</sup> roots of unity. Therefore, an _ℓ_ _×_ _ℓ_ matrix _X_ is unitarily
equivalent to a full-cycle permutation if and only if its eigenvalues are precisely _Rℓ_ .

Let _U_ be a fixed _n × n_ unitary matrix _U_ and denote its eigenvalues by _{ω_ 1 _, · · ·_ _, ωn}_ .
Since _U_ is unitary, _|ωj|_ = 1 and thus _wj_ _∈_ T for all _j_ = 1 _, . . ., n_ . We write _wj_ = _e_ <sup>2</sup> <sup>_πiaj_</sup> for
_aj_ _∈_ [0 _,_ 1). For any _δ_ _>_ 0, pick an integer _ℓ_ 0 _>_ 0 such that

_<u>πi</u>_
_ℓ_ 0

���1 _−_ _e_

��� _< δ._

We claim that there exists distinct integers _b_ 1 _, · · ·_ _, bn_, 0 _≤_ _bj_ _< ℓ_ 0 _· n_ such that

���� _aj_ _−_ _ℓ_ 0 _<u>b ·j n</u>_ ���� _≤_ 21 _ℓ_ 0

Indeed, for each _j_, the range for allowable _bj_ is given by

_ajℓ_ 0 _n −_ <sup>_<u>n</u>_</sup> 2 <sup>_< bj_</sup> <sup>_< ajℓ_</sup> <sup>0</sup> <sup>_n_</sup> <sup>+</sup> <sup>_<u>n</u>_</sup> 2 <sup>_._</sup>

This is an interval of length _n_, and thus there are precisely _n_ possible choices of _bj_ . Since
we need to pick _n_ of _bj_ ’s, it is always possible to make _b_ 1 _, · · ·_ _, bn_ distinct. We thus obtain
distinct integers _{bj}_ <sup>_n_</sup> _j_ =1 <sup>satisfying</sup>

_<u>bj</u>_ <u>1</u>

_._

���� _aj_ _−_ _ℓ_ 0 _· n_ ���� _<_ 2 _ℓ_ 0

We have that:

��� 21 _ℓ_ 0
���1 _−_ _e_ 2 _πi_ ��� _< δ._
���� _≤_

_bj_
_ℓ_ 0 _·n_
���� _ωj_ _−_ _e_ 2 _πi_

��� _aj_ _−_ _ℓ_ 0 _bj·n_
���� = ����1 _−_ _e_ 2 _πi_

Let _n_ 1 = _ℓ_ 0 _· n_ . Consider two diagonal matrices _DU_ := diag _{ω_ 1 _, · · ·_ _, ωn}_ and _D_ 1 :=

diag

- _e_ <sup>2</sup> <sup>_πi_</sup> _n_ <sup>_<u>b</u>_</sup> <sup><u>1</u></sup> 1

_n_ <sup>_<u>b</u>_</sup> <sup><u>1</u></sup> 1 _, · · ·_ _, e_ <sup>2</sup> <sup>_πi_</sup> _n_ <sup>_<u>bn</u>_</sup> 1

_n_ 1

. Then:

���� _< δ._

_∥DU_ _−_ _D_ 1 _∥_ = max
_j∈{_ 1 _,...,n}_

_bj_
_n_ 1
���� _ωj_ _−_ _e_ 2 _πi_

Let _S_ be unitary such that _U_ = _S_ <sup>_∗_</sup> _DU_ _S_ . Let _U_ 1 := _S_ <sup>_∗_</sup> _D_ 1 _S_, then by construction we have

- _n_

_⊂Rn_ 1,

2 _πibj_
_n_ 1

_∥U_ _−_ _U_ 1 _∥_ _< δ_ . Moreover, the set of eigenvalues of _U_ 1, given by _σU_ 1 =

_e_

_j_ =1

consists of distinct _n_ <sup>_th_</sup> 1

consists of distinct _n_ <sup>_th_</sup> 1 <sup>roots</sup> <sup>of</sup> <sup>unity.</sup> <sup>Whilst</sup> <sup>this</sup> <sup>is</sup> <sup>not</sup> <sup>a</sup> <sup>_complete_</sup> <sup>set</sup> <sup>of</sup> <sup>roots</sup> <sup>of</sup> <sup>unity</sup>

_Rn_ 1, we can complete the set by filling in the missing ones. More precisely let _D_ be the
diagonal matrix consisting of all the missing _n_ 1-th roots of unity, _D_ = _diag{Rn_ 1 _\ σU_ 1 _}_,
where

<u>2</u> _<u>πib</u>_
_n_ 1 : 1 _≤_ _b ≤_ _n_ 1 _, b̸_ = _bj_

_._

_Rn_ 1 _\ σU_ 1 :=

_e_

13

Li, Fong, and Tiˇno

Then _D_ _∈_ C _d×d_ with _d_ = _|Rn_ 1 _|_ _−|σU_ 1 _|_ = _n_ 1 _−_ _n_ . The block diagonal matrix _A_ :=

- _U_ 1 0 
_∈_ C _n_ 1 _×n_ 1 is unitarily equivalent to a cyclic permutation as its eigenvalues form a

0 _D_

complete set of roots of unity _Rn_ 1. Finally, by the construction of _A_ :

   - _U_ 0
���� _A −_ 0 _D_

����� = ����

����� = _∥U_ 1 _−_ _U_ _∥_ _< δ,_

- _U_ 1 _−_ _U_ 0
0 0

as desired.

**Theorem** **14** _Let_ _U_ _be_ _an_ _n × n_ _unitary_ _matrix_ _and_ _W_ = _λU_ _with_ _λ_ _∈_ (0 _,_ 1) _._ _Let_ _R_ =
( _W, V, h_ ) _be_ _a_ _reservoir_ _system_ _that_ _satisfies_ _the_ _assumptions_ _of_ _Definition_ _1_ _with_ _state_
_coupling_ _W_ _._ _For_ _any_ _ϵ >_ 0 _,_ _there_ _exists_ _a_ _reservoir_ _system_ _Rc_ = ( _Wc, Vc, hc_ ) _that_ _is_ _ϵ-close_
_to_ _R_ _such_ _that:_

_1._ _Wc_ _is_ _a_ _contractive_ _full-cycle_ _permutation_ _with_ _∥Wc∥_ = _∥W_ _∥_ = _λ ∈_ (0 _,_ 1) _,_ _and_

_2._ _hc_ _is_ _h_ _with_ _linearly_ _transformed_ _domain._

**Proof** Let _ϵ >_ 0 be arbitrary. By the proof of Theorem 11, the state space _X_ is compact and
we can choose _δ_ such that _∥_ **x** _−_ **x** <sup>_′_</sup> _∥_ _< δ_ implies _∥h_ ( **x** ) _−_ _h_ ( **x** <sup>_′_</sup> ) _∥_ _< ϵ_ . Let _M_ := sup _∥_ **c** _t∥_ _< ∞_,
since _λ <_ 1 we can pick _N_ _>_ 0 such that

2 _M_ _∥V ∥_                

_k>N_

Once we fix such an _N_, pick _δ_ 0 _>_ 0 such that

_λ_ <sup>_k_</sup> _<_ <sup>_<u>δ</u>_</sup> (5.1)

2 <sup>_._</sup>

_M_ _∥V ∥_

_N_

_k_ =0

(( _λ_ + _δ_ 0) <sup>_k_</sup> _−_ _λ_ <sup>_k_</sup> ) _<_ <sup>_<u>δ</u>_</sup> (5.2)

2 <sup>_._</sup>

(( _λ_ + _δ_ 0) <sup>_k_</sup> _−_ _λ_ <sup>_k_</sup> ) _<_ <sup>_<u>δ</u>_</sup>

2

Such a _δ_ 0 exists because the left-hand side is a finite sum that is continuous in _δ_ 0 and tends
to 0 as _δ_ 0 _→_ 0. According to Proposition 13, there exists a _n_ 1 _×n_ 1 matrix _A_ that is unitarily
equivalent to a full-cycle permutation and a diagonal matrix _D_ such that

   - _U_ 0
���� _A −_ 0 _D_

����� _<_ _λ_ <u>1</u> <sup>min</sup> <sup>_{δ, δ_</sup> <sup>0</sup> <sup>_}._</sup>

Let _Qn_ : C <sup>_n_</sup> <sup>1</sup> _�→_ C <sup>_n_</sup> be the canonical projection onto the first _n_ coordinates. Consider
the reservoir systems _R_ 0 := ( _W_ 0 _, V_ 0 _, h_ 0) and _R_ 1 := ( _W_ 1 _, V_ 0 _, h_ 0) defined by the following:

- - _V_
_,_ _V_ 0 =

0

_W_ 0 = _λ_

- _U_ 0
0 _D_

_W_ 1 = _λA,_ _h_ 0( **x** ) = _h_ ( _Qn_ ( **x** )) _._

Notice that the choice of _A_ ensures that _∥W_ 1 _−_ _W_ 0 _∥_ _<_ min _{δ, δ_ 0 _}_ .

14

Simple Cycle Reservoirs are Universal

The rest of the proof is outlined as follows: We first show that _R_ 0 is equivalent to _R_,
and then prove that _R_ 1 is _ϵ_ -close to _R_ 0. By Proposition 13, _A_ is unitarily equivalent to a
full-cycle permutation matrix, and the desired results follow from Proposition 12. We now
flesh out the above outline:

We first establish that _R_ 0 is equivalent to _R_ . For any input stream _{_ **c** _t}t∈_ Z _−_, the solution
to _R_ 0 is given by

**y** <sup>(0)</sup> _t_ = _h_ 0



 <sup>�</sup>

_k≥_ 0

_W_ 0 <sup>_kV_</sup> <sup>0</sup> <sup>**c**</sup> <sup>_t−k_</sup>

_W_ 0 <sup>_k_</sup>









= _h_

= _h_

= _h_



 _Qn_

_Qn_



 <sup>�</sup>

_k≥_ 0



 <sup>�</sup>

_k≥_ 0

_W_ <sup>_k_</sup> _V_ **c** _t−k_  _._

�( _λU_ ) _k_ 0 �� _V_
0 ( _λD_ ) <sup>_k_</sup> 0

**c** _t−k_

��� _k≥_ 0 <sup>_W kV_</sup> <sup>**c**</sup> <sup>_t−k_</sup>

0



���

This is precisely the solution to _R_ .

We now show that _R_ 1 is _ϵ_ -close to _R_ 0.
First, we observe that since _Qn_ is a projection onto the first _n_ -coordinates, it has operator
norm _∥Qn∥_ = 1 and thus whenever _∥_ **x** _−_ **x** <sup>_′_</sup> _∥_ _<_ _δ_, **x** _,_ **x** <sup>_′_</sup> _∈_ C <sup>_n_</sup> <sup>1</sup>, we have _∥Qn_ **x** _−_ _Qn_ **x** <sup>_′_</sup> _∥_ _<_ _δ_
and thus _∥h_ ( _Qn_ **x** ) _−_ _h_ ( _Qn_ **x** <sup>_′_</sup> ) _∥_ _<_ _ϵ_ . Therefore it suffices to prove that for any input _{_ **c** _t}_,
the solution to _R_ 0, given by

**x** <sup>(0)</sup> _t_ =

_k≥_ 0

_W_ 0 <sup>_kV_</sup> <sup>0</sup> <sup>**c**</sup> <sup>_t−k,_</sup>

is within _δ_ to the solution to _R_ 1, given by

**x** <sup>(1)</sup> _t_ =

_k≥_ 0

_W_ 1 <sup>_kV_</sup> <sup>0</sup> <sup>**c**</sup> <sup>_t−k._</sup>

has _∥V_ 0 _∥_ = _∥V ∥_, hence:

By construction _V_ 0 =

- _V_
0

��� **x** _t_ (0) _−_ **x** <sup>(1)</sup> _t_

��� =

_≤_

=

������

_k≥_ 0

_N_

_k_ =0

���� _W_ 0 <sup>_k_</sup> <sup>_−_</sup> <sup>_W k_</sup> 1 ���� _∥V ∥_ _M_ + 
_j>N_

���� _W_ 0 <sup>_k_</sup> <sup>_−_</sup> <sup>_W k_</sup> 1 ���� _∥V ∥_ _M._ (5.3)

���� _W_ 0 <sup>_k_</sup>

( _W_ 0 <sup>_k_</sup> <sup>_−_</sup> <sup>_W k_</sup> 1 <sup>)</sup> <sup>_V_</sup> <sup>0</sup> <sup>**c**</sup> <sup>_t−k_</sup>

( _W_ 0 <sup>_k_</sup>

������

_k≥_ 0

���( _W k_ 0 <sup>_−_</sup> <sup>_W ′_</sup> 1 <sup>_k_</sup> <sup>)</sup> ��� _∥V_ 0 _∥_ _M_

Consider the matrix ∆= _W_ 0 _−_ _W_ 1, we then have _∥_ ∆ _∥_ _<_ _δ_ 0 and for each 0 _≤_ _j_ _≤_ _N_,
_W_ 0 <sup>_j_</sup> <sup>_−_</sup> <sup>_W j_</sup> 1 <sup>=</sup> <sup>(</sup> <sup>_W_</sup> <sup>1 + ∆)</sup> <sup>_j_</sup> <sup>_−_</sup> <sup>_W j_</sup> 1 <sup>.</sup> <sup>Expanding</sup> <sup>(</sup> <sup>_W_</sup> <sup>1 + ∆)</sup> <sup>_j_</sup> <sup>,</sup> <sup>we</sup> <sup>get</sup> <sup>a</sup> <sup>summation</sup> <sup>of</sup> <sup>2</sup> <sup>_j_</sup> <sup>terms</sup> <sup>of</sup>

15

Li, Fong, and Tiˇno

_i_ <sup>_j_</sup> =1 <sup>_Xi_</sup> <sup>,</sup> <sup>where</sup> <sup>each</sup> <sup>_Xi_</sup> <sup>=</sup> <sup>_W_</sup> <sup>1</sup> <sup>or</sup> <sup>∆.</sup> <sup>For</sup> <sup>_s_</sup> <sup>=</sup> <sup>0</sup> <sup>_, . . ., j_</sup> <sup>,</sup> <sup>each</sup> <sup>of</sup> <sup>the</sup> <sup>2</sup> <sup>_j_</sup> <sup>terms</sup> <sup>has</sup>

the form <sup>�</sup> _i_ <sup>_j_</sup>

��� _≤∥W_ 1 _∥j−s∥_ ∆ _∥s_ if there are _s_ copies of ∆among _Xi_ . Removing the term

norm

 - _j_
��� _i_ =1 <sup>_Xi_</sup>

_W_ 1 <sup>_j_</sup> <sup>from</sup> <sup>(</sup> <sup>_W_</sup> <sup>1 + ∆)</sup> <sup>_j_</sup> <sup>results</sup> <sup>in</sup> <sup>all</sup> <sup>the</sup> <sup>remaining</sup> <sup>terms</sup> <sup>containing</sup> <sup>at</sup> <sup>least</sup> <sup>one</sup> <sup>copy</sup> <sup>of</sup> <sup>∆.</sup>

We thus arrive at:

��� _W j_ 0 <sup>_−_</sup> <sup>_W j_</sup> 1 ��� = ���( _W_ 1 + ∆) _j_ _−_ _W j_ 1 ���

_≤_

_≤_

_j_

_s_ =1

_j_

_s_ =1

- _j_ - _∥W_ 1 _∥_ <sup>_j−s_</sup> _∥_ ∆ _∥_ <sup>_s_</sup>
_s_

- _j_

_s_

_λ_ <sup>_j−s_</sup> _δ_ 0 <sup>_s_</sup>

0 <sup>_s_</sup> <sup>= (</sup> <sup>_λ_</sup> <sup>+</sup> <sup>_δ_</sup> <sup>0)</sup> <sup>_j_</sup> <sup>_−_</sup> <sup>_λj._</sup> (5.4)

Combining the above with Equation (5.2), we have:

_N_

_j_ =0

(( _λ_ + _δ_ 0) <sup>_j_</sup> _−_ _λ_ <sup>_j_</sup> ) _<_ <sup>_<u>δ</u>_</sup>

2 <sup>_._</sup>

(( _λ_ + _δ_ 0) <sup>_j_</sup> _−_ _λ_ <sup>_j_</sup> ) _<_ <sup>_<u>δ</u>_</sup>

2

_M_ _∥V ∥_

_N_

_j_ =0

_∥_ ( _W_ 0 <sup>_j_</sup> <sup>_−_</sup> <sup>_W j_</sup> 1 <sup>)</sup> <sup>_∥≤_</sup> <sup>_M_</sup> <sup>_∥V ∥_</sup>

On the other hand by Equation (5.1), we obtain:

_j>N_

( _∥W_ 0 _∥_ <sup>_j_</sup> + _∥W_ 1 _∥_ <sup>_j_</sup> )

_∥_ ( _W_ 0 <sup>_j_</sup> <sup>_−_</sup> <sup>_W j_</sup> 1 <sup>)</sup> <sup>_∥_</sup> _≤_ _M_ _∥V ∥_

_M_ _∥V ∥_

_j>N_

_≤_ 2 _M_ _∥V ∥_ 

_j>N_

_<u>δ</u>_
_<_ 2 <sup>_._</sup>

_λ_ <sup>_j_</sup>

With the two inequalities above, Equation (5.3) thus becomes:

_∥_ **x** <sup>(0)</sup> _t_

<sup>(0)</sup> _t_ _−_ **x** <sup>(1)</sup> _t_

<sup>(1)</sup> _t_ <sup>_∥_</sup> <sup>_< δ._</sup>

Uniform continuity of _h_ implies ��� _h_ ( **x** _t_ (0) <sup>)</sup> <sup>_−_</sup> <sup>_h_</sup> <sup>(</sup> <sup>**x**</sup> <sup>(1)</sup> _t_ <sup>)</sup> ��� _< ϵ_, proving _R_ 1 is _ϵ_ -close to _R_ 0.

Finally, by Proposition 13 _A_ is unitarily equivalent to a full-cycle permutation matrix
_P_, i.e. there exists unitary matrix _S_ such that _S_ <sup>_∗_</sup> _AS_ = _P_ . By Proposition 12, we obtain a
reservoir system _Rc_ = ( _Wc, Vc, hc_ ) with _Wc_ = _λP_, such that _Rc_ is equivalent to _R_ 1, which
is in turn _ϵ_ -close to _R_ 0. Since the original reservoir system _R_ is equivalent to _R_ 0, _R_ is
therefore _ϵ_ -close to _Rc_, as desired.

Uniform continuity of _h_ implies

��� _h_ ( **x** _t_ (0) <sup>)</sup> <sup>_−_</sup> <sup>_h_</sup> <sup>(</sup> <sup>**x**</sup> <sup>(1)</sup> _t_

<sup>(1)</sup> _t_ <sup>)</sup>

**6.** **Universality** **of** **Simple** **Multi-Cycle** **Reservoir,** C **-SCR,** **and** **Twin** **SCRs**

We are now ready to prove the main results: the universality of three distinctive linear
reservoir systems: Simple Multi-Cycle Reservoir, Complex Simple Cycle Reservoir and a
Twin Simple Cycle Reservoir. We begin by showing that any linear reservoir system _R_

16

Simple Cycle Reservoirs are Universal

is _ϵ_ -close to a Simple Multi-Cycle Reservoir _R_ <sup>_′_</sup> = ( _W_ <sup>_′_</sup> _, V_ <sup>_′_</sup> _, h_ <sup>_′_</sup> ). That is, the approximant
system _R_ <sup>_′_</sup> has both a contractive coupling matrix _W_ <sup>_′_</sup> in block-diagonal form with identical
contractive full-cycle permutation blocks, and an input map (input-to-state coupling) _V_ <sup>_′_</sup>

whose entries are all _±_ 1.

**Theorem** **15** _For_ _any_ _reservoir_ _system_ _R_ = ( _W, V, h_ ) _that_ _satisfies_ _the_ _assumptions_ _of_
_Definition_ _1_ _and_ _any_ _ϵ_ _>_ 0 _,_ _there_ _exists_ _a_ _Simple_ _Multi-Cycle_ _Reservoir_ _R_ <sup>_′_</sup> = ( _W_ <sup>_′_</sup> _, V_ <sup>_′_</sup> _, h_ <sup>_′_</sup> )
_that_ _is_ _ϵ-close_ _to_ _R._ _Moreover,_ _∥W_ _∥_ = _∥W_ <sup>_′_</sup> _∥_ _and_ _h_ <sup>_′_</sup> _is_ _h_ _with_ _linearly_ _transformed_ _domain._

**Proof** Consider a reservoir system _R_ = ( _W, V, h_ ) with dimensions ( _n, m, d_ ). By Theorem 11
and Theorem 14, we may assume without loss of generality that the coupling matrix _W_ is a
contractive full-cycle permutation, that is, _W_ = _λP_ for some full-cycle permutation _P_ and
_λ_ = _∥W_ _∥_ _<_ 1.

Let _{Ei}_ <sup>_nm_</sup> _i_ =1 <sup>be</sup> <sup>a</sup> <sup>vector</sup> <sup>space</sup> <sup>basis</sup> <sup>for</sup> <sup>M</sup> <sup>_n×m_</sup> <sup>such</sup> <sup>that</sup> <sup>each</sup> <sup>_Ei_</sup> <sup>_∈_</sup> <sup>M</sup> <sup>_n×m_</sup> <sup>(</sup> <sup>_{_</sup> <sup>1</sup> <sup>_, −_</sup> <sup>1</sup> <sup>_}_</sup> <sup>).</sup>

We have _V_ = <sup>�</sup> _aiEi_ for some constants _ai_ _∈_ C. Consider the permutation reservoir
_R_ <sup>_′_</sup> = ( _W_ <sup>_′_</sup> _, V_ <sup>_′_</sup> _, h_ <sup>_′_</sup> ) of dimension ( _n_ <sup>2</sup> _m, m, d_ ) defined by the following:





...
_Enm_

_E_ 1
_E_ 2

_W_ <sup>_′_</sup> :=

 _W_



...



_V_ <sup>_′_</sup> :=
 _,_





 

_W_

_h_ <sup>_′_</sup> ( **x** <sup>(1)</sup> _, · · ·_ _,_ **x** <sup>(</sup> <sup>_nm_</sup> <sup>)</sup> ) = _h_

- _nm_

 

_i_ =1

_ai_ **x** <sup>(</sup> <sup>_i_</sup> <sup>)</sup>

_._

By construction entries in _V_ <sup>_′_</sup> are all _±_ 1 and _W_ <sup>_′_</sup> is block-diagonal with _nm_ identical blocks
of _W_ . _W_ <sup>_′_</sup> is therefore a contractive _permutation_ ; We note that _W_ <sup>_′_</sup> is no longer a full-cycle
permutation from this step.

Given any input stream _{ct}t∈_ Z _−_, the solution to _R_ <sup>_′_</sup> is given by:



_W_ <sup>_′_</sup> <sup>�</sup> <sup>_n_</sup> _V_ <sup>_′_</sup> **c** _t−n_  _,_

**y** <sup>_′_</sup> _t_ <sup>=</sup> <sup>_h′_</sup>



 <sup>�</sup>

_n≥_ 0

where by construction:



 _._





...

- _n≥_ 0 <sup>_W nEnm_</sup> <sup>**c**</sup> <sup>_t−n_</sup>

- _n≥_ 0 <sup>_W nE_</sup> <sup>1</sup> <sup>**c**</sup> <sup>_t−n_</sup>

- _n≥_ 0 <sup>_W nEe_</sup> <sup>**c**</sup> <sup>_t−n_</sup>

_n≥_ 0

_W_ <sup>_′_</sup> <sup>�</sup> <sup>_n_</sup> _V_ <sup>_′_</sup> **c** _t−n_ =

17

Li, Fong, and Tiˇno

Therefore,



_nm_

 



 <sup>�</sup>

_n≥_ 0



 <sup>�</sup>

_n≥_ 0

_W_ <sup>_n_</sup> _V_ **c** _t−n_





 = _h_

= _h_

= _h_







_W_ <sup>_n_</sup> _Enm_ **c** _t−n_ 

_h_ <sup>_′_</sup>



 <sup>�</sup>

_n≥_ 0

_W_ <sup>_′_</sup> <sup>�</sup> <sup>_n_</sup> _V_ <sup>_′_</sup> **c** _t−n_

_n≥_ 0

_ai_

_i_ =1

_W_ <sup>_n_</sup>

- _nm_

 

_i_ =1

_aiEnm_



**c** _t−n_





This is precisely the solution to _R_ = ( _W, V, h_ ).

We have now shown that any reservoir system _R_ defined by a full-cycle permutation
coupling and arbitrary input map is equivalent to Simple Multi-Cycle Reservoir in the sense
of Definition 6. By Theorem 11 and Theorem 14, any reservoir system is _ϵ_ -close to a Simple
Multi-cycle Reservoir. The remaining two cases of Simple Cycle Reservoir structures require
a more careful construction.

We first show that a full-cycle block arrangement of individual full-cycle permutation
blocks can be under some conditions rearranged into a larger full-cycle permutation matrix.

**Lemma** **16** _Let_ _n, k_ _be_ _two_ _natural_ _numbers_ _such_ _that_ gcd( _n, k_ ) = 1 _._ _Let_ _P_ _be_ _an_ _n × n_
_full-cycle_ _permutation._ _Consider_ _the_ _nk × nk_ _matrix:_







_P_ 1 =



0 0 0 _. . ._ 0 _P_
_P_ 0 0 _. . ._ 0 0
0 _P_ 0 _. . ._ 0 0
_..._ _..._ _..._ _..._
0 _. . ._ _P_ 0

_._

_Then_ _P_ 1 _is_ _a_ _full-cycle_ _permutation._

**Proof** By construction, _P_ 1 is a permutation matrix since each row and each column has
all 0 except one entry of 1. Denote the canonical basis in R <sup>_nk_</sup> by _E_ := _{_ **e** 1 _,_ **e** 2 _, · · ·_ _,_ **e** _nk}_ .

For each _i_ = 0 _, . . ., k_ _−_ 1, consider the _i_ <sup>_th_</sup> block _Ei_ := _{_ **e** _in_ + _j}_ <sup>_n_</sup> _j_ =1 <sup>_⊂E_</sup> <sup>.</sup> Then by

construction _P_ 1 maps the _Ei_ to _Ei_ +1, i.e.

_P_ 1 : _{_ **e** _in_ + _j}_ <sup>_n_</sup> _j_

<sup>_n_</sup> _j_ =1 <sup>_�→{_</sup> <sup>**e**</sup> <sup>_in_</sup> <sup>+</sup> <sup>_j_</sup> <sup>+</sup> <sup>_n}n_</sup> _j_

<sup>_n_</sup> _j_ =1 <sup>=</sup>

- - _n_
**e** ( _i_ +1) _n_ + _j_ _j_ =1

Consider the 0 <sup>_th_</sup> block _E_ 0 = _{_ **e** 1 _, . . .,_ **e** _n}_ and **e** 1’s orbit under _P_ 1 denoted by _P_ 1 <sup>_s_</sup> <sup>**e**</sup> <sup>1,</sup> <sup>then:</sup>

_P_ 1 <sup>_s_</sup> <sup>**e**</sup> <sup>1</sup> <sup>_∈E_</sup> <sup>0</sup> <sup>_⇔_</sup> <sup>(1 +</sup> <sup>_sn_</sup> <sup>)</sup> mod ( _nk_ ) _∈{_ 1 _, . . ., n}_

_⇔∃α ∈_ Z such that _s_ = _αk_

_⇔_ _k_ _| s._

18

Simple Cycle Reservoirs are Universal

When _k_ _|_ _s_, _P_ 1 <sup>_s_</sup>

When _k_ _|_ _s_, _P_ 1 <sup>_s_</sup> <sup>**e**</sup> <sup>1</sup> <sup>=</sup> <sup>_P s_</sup> <sup>**e**</sup> <sup>1</sup> <sup>_∈E_</sup> <sup>0.</sup> <sup>Since</sup> <sup>_P_</sup> <sup>is</sup> <sup>a</sup> <sup>full-cycle</sup> <sup>permutation</sup> <sup>of</sup> <sup>dimension</sup> <sup>_n_</sup> <sup>,</sup> <sup>for</sup>

each 1 _≤_ _i ≤_ _n_, _P_ <sup>_s_</sup> **e** _i_ = **e** _i_ if and only if _n | s_ . Therefore, **e** 1 = _P_ 1 <sup>_s_</sup> <sup>**e**</sup> <sup>1</sup> <sup>=</sup> <sup>_P s_</sup> <sup>**e**</sup> <sup>1</sup> <sup>implies</sup> <sup>_n | s_</sup> <sup>.</sup>

Combining the above with the assumption that gcd( _k, n_ ) = 1, we have that _P_ 1 <sup>_s_</sup> <sup>**e**</sup> <sup>1</sup> <sup>=</sup> <sup>**e**</sup> <sup>1</sup>

if and only if _nk_ _| s_ . The permutation _P_ 1 thus contains a cycle whose length is at least _nk_ .
Hence, _P_ 1 is a full-cycle permutation.

1 _≤_ _i ≤_ _n_, _P_ <sup>_s_</sup> **e** _i_ = **e** _i_ if and only if _n | s_ . Therefore, **e** 1 = _P_ 1 <sup>_s_</sup> <sup>**e**</sup> <sup>1</sup> <sup>=</sup> <sup>_P s_</sup> <sup>**e**</sup> <sup>1</sup> <sup>implies</sup> <sup>_n | s_</sup> <sup>.</sup>

Combining the above with the assumption that gcd( _k, n_ ) = 1, we have that _P_ 1 <sup>_s_</sup> <sup>**e**</sup> <sup>1</sup> <sup>=</sup>

**Example** **1** _We_ _emphasis_ _that_ _the_ _condition_ gcd( _n, k_ ) = 1 _is_ _crucial_ _in_ _Lemma_ _16._ _Con-_
_sider_ _a_ _simple_ _example_ _where_ _n_ = 2 _and_ _k_ = 3 _._ _Let_ _P_ _be_ _the_ _matrix_ _for_ _cyclic_ _permutation_
(1 _,_ 2) _,_

_P_ =

_From_ _our_ _construction,_ _the_ _matrix_ _P_ 1 _is_

�0 1�

_._

1 0







_P_ 1 =



1
1
1
1
1
1

_One_ _can_ _check_ _that_ _P_ 1 _corresponds_ _to_ _the_ _cyclic_ _permutation_ (1 _,_ 4 _,_ 5 _,_ 2 _,_ 3 _,_ 6) _._ _If_ _we_ _picked_
_k_ = 2 _,_ _then_





 _,_

_P_ 1 =

_which_ _is_ _not_ _a_ _full-cycle_ _permutation._



1
1
1
1

**Lemma** **17** _For any n×m real matrix V_ _and δ_ _>_ 0 _,_ _there exists k_ _matrices {F_ 1 _, · · ·_ _, Fk} ⊂_
M _n×m_ ( _{−_ 1 _,_ 1 _}_ ) _and_ _a_ _constant_ _integer_ _N_ _>_ 0 _such_ _that:_

_V_ _−_ <sup><u>1</u></sup>

_N_

������

_k_

_Fj_

_j_ =1

_< δ_
������

_Moreover,_ _k_ _can_ _be_ _chosen_ _such_ _that_ gcd( _k, n_ ) = 1 _._

**Proof** Let _E_ := _{Ei}_ <sup>_nm_</sup> _i_ =1 <sup>_⊂_</sup> <sup>M</sup> <sup>_n×m_</sup> <sup>(</sup> <sup>_{−_</sup> <sup>1</sup> <sup>_,_</sup> <sup>1</sup> <sup>_}_</sup> <sup>) be a vector space basis for M</sup> <sup>_n×m_</sup> <sup>(R) such that</sup>

entries of each _Ei_ are _±_ 1. There exists constants _ai_ _∈_ R such that

_V_ =

_nm_

_aiEi._

_i_ =1

Let _L_ := max _{∥Ei∥_ : 1 _≤_ _i ≤_ _nm}_ . Pick an integer _N_ large enough such that <sup>_<u>nm</u>_</sup> _N_ <sup>_<_</sup> 2 _<u>δL</u>_ <sup>.</sup>

Since _m >_ 1, we also have <sup>_<u>nL</u>_</sup> _N_ <sup>_<_</sup> 2 <sup>_<u>δ</u>_</sup> <sup>.</sup> <sup>Pick</sup> <sup>a</sup> <sup>set</sup> <sup>of</sup> <sup>integers</sup> <sup>_B_</sup> <sup>:=</sup> <sup>_{bi_</sup> <sup>: 1</sup> <sup>_≤_</sup> <sup>_i ≤_</sup> <sup>_nm}_</sup> <sup>such</sup> <sup>that:</sup>

Let _L_ := max _{∥Ei∥_ : 1 _≤_ _i ≤_ _nm}_ . Pick an integer _N_ large enough such that <sup>_<u>nm</u>_</sup> _N_

<sup>_<u>nL</u>_</sup> _N_ <sup>_<_</sup> 2 <sup>_<u>δ</u>_</sup>

2 <sup>_<u>δ</u>_</sup> <sup>.</sup> <sup>Pick</sup> <sup>a</sup> <sup>set</sup> <sup>of</sup> <sup>integers</sup> <sup>_B_</sup> <sup>:=</sup> <sup>_{bi_</sup> <sup>: 1</sup> <sup>_≤_</sup> <sup>_i ≤_</sup> <sup>_nm}_</sup> <sup>such</sup> <sup>that:</sup>

_<u>δ</u>_

���� _ai −_ _Nbi_ ���� _<_ 2 _Lnm_ <sup>_._</sup>

_<u>δ</u>_
���� _<_ 2 _Lnm_ <sup>_._</sup>

19

Li, Fong, and Tiˇno

We can always find such _bi_ since allowable values of _bi_ lie inside an interval of length _LnmNδ_ <sup>_>_</sup> <sup>2</sup>
centred at _Nai_ _∈_ R.

Let _k_ 0 = <sup>�</sup> _i_ <sup>_nm_</sup> =1 <sup>_|bi|_</sup> <sup>and</sup> <sup>pick</sup> <sup>the</sup> <sup>smallest</sup> <sup>integer</sup> <sup>_k_</sup> <sup>_≥_</sup> <sup>_k_</sup> <sup>0</sup> <sup>such</sup> <sup>that</sup> <sup>gcd(</sup> <sup>_k, n_</sup> <sup>)</sup> <sup>=</sup> <sup>1.</sup> <sup>It</sup> <sup>is</sup>

clear that _k_ _< k_ 0 + _n_ .

Now we pick _k_ matrices _{F_ 1 _, · · ·_ _, Fk} ⊂_ _E_ as follows:

1. For each 1 _≤_ _i ≤_ _nm_, sgn( _bi_ ) _Ei_ is a matrix whose entries are _±_ 1. For each _i_ we then
take _|bi|_ -copies of sgn( _bi_ ) _Ei_ .

Repeating the process across all _i_ _∈{_ 1 _, . . ., nm}_, we obtain a total number of _k_ 0 =

 - _nmi_ =1 <sup>_|bi|_</sup> <sup>matrices</sup> <sup>whose</sup> <sup>entries</sup> <sup>are</sup> <sup>all</sup> <sup>_±_</sup> <sup>1</sup> <sup>(namely</sup> <sup>sgn(</sup> <sup>_bi_</sup> <sup>)</sup> <sup>_Ei_</sup> <sup>for</sup> <sup>each</sup> <sup>_bi_</sup> <sup>_∈_</sup> <sup>_B_</sup> <sup>).</sup> <sup>We</sup>
label these matrices as _F_ 1 _, . . ., Fk_ 0.

2. Pick _k_ _−_ _k_ 0 copies of a single basis matrix _Ej_ . Without loss of generality, we may
choose _j_ = 1. These will be labelled as _Fk_ 0+1 through _Fk_ .

Now by construction:

������

������

�����

_nm_

_i_ =1

���� _ai −_ _Nbi_

_V_ _−_ <sup><u>1</u></sup>

_N_

������

_k_

_j_ =1

_i_ =1

_nm_

_Fj_

=
������

_≤_

=

_≤_

_nm_

������

+
������

<u>1</u>

_N_

������

_k_

_j_ = _k_ 0+1

_Fj_

_aiEi −_ <sup><u>1</u></sup>

_N_

_k_

_j_ =1

_k_ 0

_j_ =1

_Fj_

_Fj_

������

_i_ =1

_nm_

_aiEi −_ <sup><u>1</u></sup>

_N_

������

<u>1</u>

_N_

_Fj_

_Ei_

����� +

_k_

_j_ = _k_ 0+1

������

_i_ =1

- _ai −_ <sup>_<u>|bi|</u>_</sup> <sup><u>sgn(</u></sup> <sup>_<u>bi</u>_</sup> <sup><u>)</u></sup>

_N_

���� _∥Ei∥_ + _N_ <u>1</u>

_k_

- _∥Fj∥_

_j_ = _k_ 0+1

_<u>δ</u>_
_< nm ×_ _× L_
2 _Snm_ <sup>_× L_</sup> <sup>+</sup> <sup>_<u>|k −</u>_</sup> _N_ <sup>_<u>k</u>_</sup> <sup><u>0</u></sup> <sup>_<u>|</u>_</sup>

_≤_ 2 <sup>_<u>δ</u>_</sup> <sup>+</sup> <sup>_<u>nL</u>_</sup> _N_ <sup>_< δ_</sup>

**Remark** **18** _By_ _the_ _proof_ _of_ _Lemma_ _17,_ _we_ _see_ _that_ _k_ _>_ _k_ 0 = <sup>�</sup> _i_ <sup>_nm_</sup> =1 <sup>_|bi|_</sup> <sup>_>_</sup> <sup>_nm._</sup> <sup>_Typically_</sup>

_bi’s_ _are_ _assumed_ _to_ _be_ _larger_ _than_ 1 _,_ _which_ _results_ _in_ _increased_ _dimensionality._ _This_ _is_ _the_
_price_ _for_ _having_ _<u>both</u>_ _a_ _full-cyclic_ _permutation_ _state_ _coupling_ _<u>and</u>_ _restricted_ _binary_ _complex_
_input_ _weights._

**Corollary** **19** _For_ _any_ _n_ _×_ _m_ _complex_ _matrix_ _V_ _and_ _δ_ _>_ 0 _,_ _there_ _exists_ _k_ _matrices_
_{F_ 1 _, · · ·_ _, Fk}_ _where_ _each_ _Fi_ _∈_ M _n×m_ ( _±_ 1) _or_ M _n×m_ ( _±i_ ) _and_ _a_ _constant_ _integer_ _N_ _>_ 0
_such_ _that:_

_k_

       
_V_ _−_ <sup><u>1</u></sup> _Fj_ _< δ_

_N_

������ _j_ =1 ������

_k_

_Fj_

_< δ_
������

_N_

_j_ =1

20

Simple Cycle Reservoirs are Universal

_Moreover,_ _k_ _can_ _be_ _chosen_ _such_ _that_ gcd( _k, n_ ) = 1 _._

One can easily modify the proof of Lemma 17 to prove this Corollary. The proof is omitted
here.

We now prove that Complex Simple Cycle Reservoirs are universal.

**Theorem** **20** _For_ _any_ _reservoir_ _system_ _R_ = ( _W, V, h_ ) _of_ _dimensions_ ( _n, m, d_ ) _that_ _satisfies_
_the_ _assumptions_ _of_ _Definition_ _1_ _and_ _any_ _ϵ_ _>_ 0 _,_ _there_ _exists_ _a_ C _-SCR_ _R_ <sup>_′_</sup> = ( _W_ <sup>_′_</sup> _, V_ <sup>_′_</sup> _, h_ <sup>_′_</sup> ) _of_
_dimension_ ( _n_ <sup>_′_</sup> _, m, d_ ) _that_ _is_ _ϵ-close_ _to_ _R._ _Moreover,_ _∥W_ _∥_ = _∥W_ <sup>_′_</sup> _∥_ _and_ _h_ <sup>_′_</sup> _is_ _h_ _with_ _linearly_
_transformed_ _domain._

**Proof** Consider a reservoir system _R_ = ( _W, V, h_ ) with dimensions ( _n, m, d_ ). Without loss
of generality, we assume that _W_ is a contractive full-cycle permutation. For any _ϵ_ _>_ 0,
pick _δ_ _>_ 0 such that _∥_ **x** _−_ **x** <sup>_′_</sup> _∥_ _<_ _δ_ implies _|h_ ( **x** ) _−_ _h_ ( **x** <sup>_′_</sup> ) _|_ _<_ _ϵ_ . We now construct a C-SCR
_R_ <sup>_′_</sup> = ( _W_ <sup>_′_</sup> _, V_ <sup>_′_</sup> _, h_ <sup>_′_</sup> ) that is _ϵ_ -close to _R_ .

Applying Corollary 19, we obtain _n × m_ matrices _{Fj}_ <sup>_k_</sup> _j_ =1 <sup>whose</sup> <sup>entries</sup> <sup>are</sup> <sup>either</sup> <sup>all</sup>

_±_ 1 or _±i_, and _N_ _>_ 0 sufficiently large such that

_V_ _−_ <sup><u>1</u></sup>

_N_

������

_k_

_j_ =1

_Fj_ _<_ <sup><u>(1</u></sup> <sup>_<u>−</u>_</sup> <sup>_<u>λ</u>_</sup> <sup><u>)</u></sup> <sup>_<u>δ</u>_</sup> _,_

_M_

������

where _M_ = sup _{∥_ **c** _t∥}t∈_ Z _−_, and _k_ satisfies gcd( _k, n_ ) = 1. Let _W_ = _λP_ with _λ_ = _∥W_ _∥_ and
_P_ being a full-cycle permutation. Applying Lemma 16 we obtain a full-cycle permutation
_nk × nk_ matrix _P_ 1. Consider the reservoir system _R_ <sup>_′_</sup> = ( _W_ <sup>_′_</sup> _, V_ <sup>_′_</sup> _, h_ <sup>_′_</sup> ) defined by the triplet:



_,_ _V_ <sup>_′_</sup> =













_W_ <sup>_′_</sup> = _λP_ 1 = _λ ·_



0 0 0 _. . ._ 0 _P_
_P_ 0 0 _. . ._ 0 0
0 _P_ 0 _. . ._ 0 0
... ... ... ...
0 _. . ._ _P_ 0



_F_ 1
_F_ 2

...
_Fk_

_k_

_j_ =1

_h_ <sup>_′_</sup> <sup>�</sup>

**x** <sup>(1)</sup> _, . . .,_ **x** <sup>(</sup> <sup>_k_</sup> <sup>)�</sup>

= _h_



 _._

 <sup><u>1</u></sup>

_N_

 <sup><u>1</u></sup>

**x** <sup>(</sup> <sup>_j_</sup> <sup>)</sup>

For any input stream _{_ **c** _t}t∈_ Z _−_, the solution to _R_ and _R_ <sup>_′_</sup> are given respectively by:





 _._



 <sup>�</sup>

_i≥_ 0

_W_ <sup>_′_</sup> <sup>�</sup> <sup>_i_</sup> _V_ <sup>_′_</sup> **c** _t−i_

<sup>_′_</sup> _t_ <sup>=</sup> <sup>_h′_</sup>

**y** _t_ = _h_



 <sup>�</sup>

_i≥_ 0

_W_ <sup>_i_</sup> _V_ **c** _t−i_

 _,_ **y** <sup>_′_</sup> _t_ <sup>=</sup> <sup>_h′_</sup>

Note that, by construction _W_ <sup>_′_</sup> cycles through _k_ subspaces with dimension _n_ and applies _W_
on each of them. Thus,



_W_ <sup>_′_</sup> <sup>�</sup> <sup>_i_</sup> _V_ <sup>_′_</sup> **c** _t−i_ =



_W_ <sup>_i_</sup> _F_ (1+ _i_ mod _k_ ) <sup>**c**</sup> _t−i_
_W_ <sup>_i_</sup> _F_ (2+ _i_ mod _k_ ) <sup>**c**</sup> _t−i_
...
_W_ <sup>_i_</sup> _F_ ( _k_ + _i_ mod _k_ ) <sup>**c**</sup> _t−i_



 _._

21

Li, Fong, and Tiˇno

Since for each _i_, _{F_ (1+ _i_ mod _k_ ) _, F_ (2+ _i_ mod _k_ ) _, . . ., F_ ( _k_ + _i_ mod _k_ ) _}_ is simply a permutation of
_{F_ 1 _, . . ., Fk}_ . We obtain:

**y** <sup>_′_</sup> _t_ <sup>=</sup> <sup>_h_</sup>

= _h_



 <sup><u>1</u></sup>

_N_



 <sup>�</sup>

_i≥_ 0

_k_

_j_ =1

_W_ <sup>_i_</sup> <sup><u>1</u></sup>

_N_

_W_ <sup>_i_</sup> <sup><u>1</u></sup>

_i≥_ 0

_W_ <sup>_i_</sup> _F_ ( _j_ + _i_ mod _k_ ) <sup>**c**</sup> _t−i_





_k_

_j_ =1





_Fj_

 

 **c** _t−i_  _,_

**c** _t−i_ and **x** _t_ = <sup>�</sup> _i≥_ 0 <sup>_W iV_</sup> <sup>**c**</sup> <sup>_t−i_</sup> <sup>.</sup> <sup>We</sup> <sup>have,</sup>

Now let **x** <sup>_′_</sup> _t_

_i≥_ 0 <sup>_W i_</sup> _N_ <sup><u>1</u></sup>

_N_

<sup>_′_</sup> _t_ <sup>= �</sup>

�� _k_
_j_ =1 <sup>_Fj_</sup>

������



_Fj_  **c** _t−i_

�� **x** _t −_ **x** _′t_

�� =

_≤_



 _V_ _−_ <sup><u>1</u></sup>

_N_

_V_ _−_ <sup><u>1</u></sup>

_N_

������

_k_

_j_ =1

������

_j≥_ 0

_W_ <sup>_i_</sup>

_i≥_ 0

_λ_ <sup>_i_</sup> _M_

_k_

_j_ =1

_Fj_

������

<u>1</u>
_<_ = _δ_
1 _−_ _λ_ <sup>_M_</sup> <sup><u>(1</u></sup> <sup>_<u>−</u>_</sup> _M_ <sup>_<u>λ</u>_</sup> <sup><u>)</u></sup> <sup>_<u>δ</u>_</sup>

Therefore **y** _t_ is _ϵ_ -close to **y** <sup>_′_</sup> _t_ <sup>by</sup> <sup>continuity</sup> <sup>of</sup> <sup>_h_</sup> <sup>and</sup> <sup>thus</sup> <sup>_R′_</sup> <sup>is</sup> <sup>_ϵ_</sup> <sup>-close</sup> <sup>to</sup> <sup>_R_</sup> <sup>.</sup> <sup>By</sup> <sup>construction,</sup>

_W_ <sup>_′_</sup> is a contractive full-cycle permutation and entries of _V_ <sup>_′_</sup> are either all _±_ 1 or _±i_ .

Using a similar argument, we can also prove that an assembly of two SCR (Simple Cycle
Reservoir over R) is universal. The argument is to apply the same process for Re( _V_ ) and
Im( _V_ ) respectively to get a Multi-Cycle Reservoir of order 2.

**Theorem** **21** _For_ _any_ _reservoir_ _system_ _R_ = ( _W, V, h_ ) _of_ _dimensions_ ( _n, m, d_ ) _and_ _any_
_ϵ >_ 0 _,_ _there_ _exists_ _a_ _Twin_ _Simple_ _Cycle_ _Reservoir_ _R_ <sup>_′_</sup> = ( _W_ <sup>_′_</sup> _, V_ <sup>_′_</sup> _, h_ <sup>_′_</sup> ) _of_ _dimension_ ( _n_ <sup>_′_</sup> _, m, d_ )
_that_ _is_ _ϵ-close_ _to_ _R._ _Moreover,_ _∥W_ _∥_ = _∥W_ <sup>_′_</sup> _∥_ _and_ _h_ <sup>_′_</sup> _is_ _h_ _with_ _linearly_ _transformed_ _domain._

**Proof** Consider the reservoir system _R_ = ( _W, V, h_ ) where _W_ is a contractive full-cycle
permutation. Write _V_ = _Vr_ + _iVi_ where _Vr, Vi_ are real and imaginary parts of _V_ respectively.
For any _ϵ >_ 0, pick _δ_ _>_ 0 such that _∥_ **x** _−_ **x** <sup>_′_</sup> _∥_ _< δ_ implies _|h_ ( **x** ) _−h_ ( **x** <sup>_′_</sup> ) _| < ϵ_ . We now construct
a Multi-Cycle Reservoir of order 2, _R_ <sup>_′_</sup> = ( _W_ <sup>_′_</sup> _, V_ <sup>_′_</sup> _, h_ <sup>_′_</sup> ), that is _ϵ_ -close to _R_ .

Apply Lemma 17 on _Vr_ and _Vi_ to obtain constants _Nr, Ni_ _>_ 0 and _real-valued_ matrices
_{F_ 1 _, . . ., Fkr_ _}_ and _{G_ 1 _, . . ., Gki}_ whose entries are all _±_ 1, such that

_Vr −_ <sup><u>1</u></sup>

_Nr_

������

_Vi −_ <sup><u>1</u></sup>

_Ni_

������

_kr_

_Fj_

_j_ =1

_ki_

_Gj_

_j_ =1

22

_<_ <sup><u>(1</u></sup> <sup>_<u>−</u>_</sup> <sup>_<u>λ</u>_</sup> <sup><u>)</u></sup> <sup>_<u>δ</u>_</sup> _,_

2 _M_

������

_<_ <sup><u>(1</u></sup> <sup>_<u>−</u>_</sup> <sup>_<u>λ</u>_</sup> <sup><u>)</u></sup> <sup>_<u>δ</u>_</sup> _,_

2 _M_

������

Simple Cycle Reservoirs are Universal

where _kr, ki_ _>_ 0 are chosen such that gcd( _kr, n_ ) = gcd( _ki, n_ ) = 1. Let _W_ = _λP_ for a
full-cycle permutation _P_ and _λ_ = _∥W_ _∥_ . Apply Lemma 16 _twice_ to obtain a _nkr × nkr_ fullcycle permutation _Pr_ and a _nki × nki_ full-cycle permutation _Pi_ . Consider reservoir system
_R_ <sup>_′_</sup> = ( _W_ <sup>_′_</sup> _, V_ <sup>_′_</sup> _, h_ <sup>_′_</sup> ) defined by the triplet:





_,_



_W_ <sup>_′_</sup> = _λ_ ( _Pr ⊕_ _Pi_ ) _,_ _V_ <sup>_′_</sup> =





_F_ 1

...
_Fkr_

_G_ 1

...
_Gki_

_ki_

_j_ =1

**x** <sup>_′_</sup> <sup>(</sup> <sup>_j_</sup> <sup>)</sup>

_kr_

_j_ =1

**x** <sup>(</sup> <sup>_j_</sup> <sup>)</sup> + <sup>_<u>i</u>_</sup>

_Ni_

**x** <sup>(</sup> <sup>_j_</sup> <sup>)</sup> + <sup>_<u>i</u>_</sup>

_h_ <sup>_′_</sup> ( **x** <sup>(1)</sup> _, . . .,_ **x** <sup>(</sup> <sup>_kr_</sup> <sup>)</sup> _,_ **x** <sup>_′_</sup> <sup>(1)</sup> _, . . .,_ **x** <sup>_′_</sup> <sup>(</sup> <sup>_ki_</sup> <sup>)</sup> ) = _h_

 <sup><u>1</u></sup>

_Nr_





_R_ <sup>_′_</sup> = ( _W_ <sup>_′_</sup> _, V_ <sup>_′_</sup> _, h_ <sup>_′_</sup> ) is a Multi-Cycle Reservoir of order 2. Consider the state of the system
given by:

- _W_ <sup>_n_</sup> _Vr_ **c** _t−n_ + _i ·_

_n≥_ 0

**x** _t_ =

=

_n≥_ 0

_n≥_ 0

_W_ <sup>_n_</sup> _V_ **c** _t−n_

_W_ <sup>_n_</sup> ( _Vr_ + _iVi_ ) **c** _t−n_ =

_W_ <sup>_n_</sup> _Vi_ **c** _t−n._

_n≥_ 0

The rest of the proof is similar to that of Theorem 20. The first half of the sum <sup>�</sup> _n≥_ 0 <sup>_W nVr_</sup> <sup>**c**</sup> <sup>_t−n_</sup>

can be arbitrarily approximated by

( _λPr_ ) <sup>_n_</sup> <sup><u>1</u></sup>

_Nr_

( _λPr_ ) <sup>_n_</sup> <sup><u>1</u></sup>





_Nr_

_j_ =1

_Fj_

_n≥_ 0



 **c** _t−n,_

and by a symmetric argument the second half of the sum <sup>�</sup> _n≥_ 0 <sup>_W nVi_</sup> <sup>**c**</sup> <sup>_t−n_</sup> <sup>can be arbitrarily</sup>

approximated by



( _λPi_ ) <sup>_n_</sup> <sup><u>1</u></sup>

_Ni_

( _λPi_ ) <sup>_n_</sup> <sup><u>1</u></sup>

 _Ni_

 



_j_ =1

_n≥_ 0



 **c** _t−n._

_Gj_

Therefore it follows from a similar argument of the proof of Theorem 20 that **x** _t_ is close to
**x** <sup>_′_</sup> _t_ <sup>,</sup> <sup>and</sup> <sup>_R′_</sup> <sup>is</sup> <sup>_ϵ_</sup> <sup>-close</sup> <sup>to</sup> <sup>_R_</sup> <sup>.</sup>

**7.** **Summary** **and** **Universality** **in** **the** **Space** **of** **Fading** **Memory** **Filters**

Having finished our exploration of universality properties of simple reservoir structures
employing only scaled full-cycle permutations in the dynamic coupling and binary input-tostate coupling, we now present in Figure 2 a birds-eye overview of the results and argumentation flow presented so far. Each arrow represents an approximation step with the symbol

23

Li, Fong, and Tiˇno

_≺_ indicating an increase in the approximant state space dimensionality. By Definition 1,
the symbols _W, V, h, n_ denote the dynamic coupling, input-to-state coupling, readout, and
dimension of the state space, respectively of the corresponding reservoir system.

We begin with an arbitrary linear reservoir system _R_ = ( _W, V, h_ ) in the top-left-handcorner. We first construct, by Theorem 11, a linear reservoir system _RU_ with a unitary
dynamic coupling _WU_ which is _ϵ_ -close to _R_ . By Theorem 14, we then transform _RU_ into an
_ϵ_ -close linear reservoir system _RU_ <sup>_′_</sup> <sup>with</sup> <sup>contractive</sup> <sup>cyclic-permutation</sup> <sup>dynamic</sup> <sup>coupling.</sup>

Based on this, given any linear reservoir system _R_, we can construct an _ϵ_ -close linear reservoir system which is a Simple Multi-Cycle Reservoir(Theorem 15), Complex Simple Cycle
Reservoir (Theorem 20), or a Twin Simple Cycle Reservoir (Theorem 21) respectively.

Combining this result with Corollary 11 of Grigoryeva and Ortega (2018a) implies that
all three types of linear reservoir systems described in Definition 6 are universal in the
category of time-invariant fading memory filters. We illustrate this with C-SCR as the
cases of Simple Multi-Cycle Reservoir and Twin SCR follow the same argumentation.

Grigoryeva and Ortega (2018a)(Corollary 11) establishes that linear reservoir systems
with polynomial readouts are universal, in the sense that any time-invariant fading memory filter can be approximated by to arbitrary precision by a linear reservoir system. In
other words, given any time-invariant fading-memory filter _F_ and _ϵ_ _>_ 0, <u>there</u> <u>exists</u> a
linear reservoir system _R_ with polynomial readout _h_ and the corresponding linear reservoir
function _HR_ such that _HR_ is _ϵ_ -close to _F_ in the space of real-valued continuous functions
over the space of uniformly bounded input. By Theorem 20, given a linear reservoir system
_R_ with a polynomial readout _h_, we can <u>construct</u> a C-SCR _R_ <sup>_′_</sup> that is _ϵ_ -close to _R_ in the
space of linear reservoir systems. Moreover, the readout of _R_ <sup>_′_</sup>, denoted by _h_ <sup>_′_</sup>, is _h_ with
linearly transformed domain, meaning that _h_ <sup>_′_</sup> is a polynomial of the same degree as _h_ . It
is worth noting that our results are not restricted to polynomial readouts, as long as they
are continuous.

**Theorem** **22** _Any_ _time-invariant_ _fading_ _memory_ _filter_ _over_ _uniformly_ _bounded_ _inputs_ _can_
_be_ _approximated_ _to_ _arbitrary_ _precision_ _by_ _a_ _Simple_ _Multi-Cycle_ _Reservoir,_ _a_ C _-SCR,_ _or_ _a_
_Twin_ _SCR,_ _each_ _endowed_ _with_ _a_ _polynomial_ _readout._

**8.** **Conclusion**

We have shown that even severely restricted linear reservoir architectures with continuous
readouts, employing only scaled full-cycle permutation dynamic couplings and binary inputto-state couplings are capable of universal approximation of any unrestricted linear reservoir
system (with continuous readout) and hence any time-invariant fading memory filter over
uniformly bounded input streams.

These results support empirical studies reporting the competitive performance of simple
cyclic reservoir structures (e.g. Rodan and Tiˇno (2010); Wang et al. (2019); Matthew
et al. (2020)), as well as theoretical investigations of the representational power of such
architectures in terms of memory and state space organisation (Tiˇno (2020); Rodan and
Tiˇno (2010)).

Universality guarantees of simple reservoir architectures that lend themselves naturally
to physical implementations (Coarer et al. (2018); Appeltant et al. (2011); Nakajima et al.

24

Simple Cycle Reservoirs are Universal






_R_ := ( _W, V, h_ )

_W_ _∈_ C _n×n_
_V_ _∈_ C _m×n_
_h_ : C <sup>_n_</sup> _→_ C <sup>_d_</sup>

**Unitary** **universal**

_RU_ := ( _WU_ _, VU_ _, hU_ )
_WU_ := _λ · U_ _∈_ C( _N_ +1) _n×_ ( _N_ +1) _n_

...










_U_ :=





_W_ _DW ∗_

_DW_ _−W_ <sup>_∗_</sup>

_,_ _VU_ :=

_I_

- _V_

0

_λ_ := _∥W_ _∥_

_I_ 0

_hU_ ( _x_ ) = _h_ ( _Pn_ ( _x_ ))
_nU_ := ( _N_ + 1) _n_

_W_ C := _λ · P_ 1 _∈_ C _n′U_ <sup>_·_</sup>

<sup>_′_</sup> _U_ <sup>_· k_</sup> <sup>;</sup> <sup>_k_</sup> <sup>satisfies</sup> <sup>gcd(</sup> <sup>_k, n′_</sup>

<sup>_′_</sup> _U_ <sup>_·k_</sup>






<sup>_′_</sup> _U_ <sup>_> nU_</sup> <sup>_,_</sup> <sup>_S_</sup> <sup>–</sup> <sup>unitary</sup> <sup>transform</sup>

**Cyclic** **Permutation** **universal**
_RU_ <sup>_′_</sup> <sup>:= (</sup> <sup>_W ′_</sup> _U_ <sup>_, V_</sup> _U_ <sup>_′_</sup> <sup>_, h′_</sup> _U_ <sup>)</sup>





_U_ <sup>_′_</sup> <sup>:= (</sup> <sup>_W ′_</sup> _U_

<sup>_′_</sup> _U_ <sup>_, V_</sup> _U_ <sup>_′_</sup>

_U_ <sup>_′_</sup> <sup>_, h′_</sup> _U_

 _∼_ = _λ · P,_

<sup>_′_</sup> _U_ <sup>)</sup>

_′U_ <sup>_·k×n′_</sup>

_W_ <sup>_′_</sup>

 _U_ 0

0 _D_

_U_ <sup>_′_</sup> <sup>=</sup> <sup>_λ ·_</sup>







0 0 0 _. . ._ 0 _P_

_P_ 0 0 _. . ._ 0 0

0 _P_ 0 _. . ._ 0 0
... ... ... ...

0 _. . ._ _P_ 0

_· · ·_ ( _†_ )

_P_ - cyclic permutation, _P_ _∈_ C _n′_

_U_

_P_ 1 :=

_′U_ <sup>_×n′_</sup> _U_

_VU_ <sup>_′_</sup>

_Pn′_

_′U_ <sup>(</sup> <sup>_S∗_</sup> <sup>**x**</sup> <sup>)</sup>

_U_ <sup>_′_</sup> <sup>:=</sup> <sup>_S_</sup>

_VU_

0

_,_ _h_ <sup>_′_</sup> _U_ <sup>(</sup> <sup>**x**</sup> <sup>) =</sup> <sup>_hU_</sup>

_n_ <sup>_′_</sup>

_V_ C _∈_ M _m×n′U_

_h_ C( **x** 1 _, . . .,_ **x** _k_ ) = _h_ <sup>_′_</sup> _U_

_′U_ <sup>_·k_</sup> <sup>(</sup> <sup>_{−_</sup> <sup>1</sup> <sup>_,_</sup> <sup>1</sup> <sup>_}_</sup> <sup>)</sup> <sup>OR</sup> <sup>_V_</sup> <sup>C</sup> <sup>_∈_</sup> <sup>M</sup> <sup>_m×n′_</sup>

<sup>_′_</sup> _U_ <sup>_·k_</sup> <sup>(</sup> <sup>_{−i, i}_</sup> <sup>)</sup>

- <u>1</u>
_N_ <sup>C</sup>

- _kj_ =1 <sup>**x**</sup> <sup>_j_</sup>

_n_ C = _n_ <sup>_′_</sup>

_U_

_U_ <sup>_′_</sup> <sup>) = 1</sup>






<sup>_′_</sup> _U_ <sup>_·_</sup> <sup>(</sup> <sup>_n_</sup> _U_ <sup>_′_</sup>

**SMCR** **universal**

_RP_ := ( _WP, VP, hP_ )
_WP_ _∈_ C( _n′U_ <sup>)</sup> 2 _·m×_ ( _n′U_ <sup>)</sup>

<sup>_′_</sup> _U_ <sup>) = gcd(</sup> <sup>_kr, n′_</sup>

<sup>)</sup> 2 _·m×_ ( _n′U_ <sup>)</sup>

_WP_ _∈_ C( _n′U_ <sup>)</sup> 2 _·m×_ ( _n′U_ <sup>)</sup> 2 _·m_

_WP_ - contractive permutation.

**Twin** **SCR** **universal**

_R_ R := ( _W_ R _, V_ R _, h_ R)

_W_ R := _λ_ ( _Pr ⊕_ _Pi_ ) = _λ ·_

_Pr_ 0

0 _Pi_

_′U_ <sup>)</sup>

 _λ · P_





_′U_ <sup>_·_</sup> <sup>(</sup> <sup>_kr_</sup> <sup>+</sup> <sup>_ki_</sup> <sup>)</sup> <sup>_×n′_</sup>

_,_





_λ · P_

_WP_ :=

...






where both _Pr, Pi_, has form ( _†_ ) _._
_W_ R _∈_ C _n′U_ <sup>_·_</sup> <sup>(</sup> <sup>_kr_</sup> <sup>+</sup> <sup>_ki_</sup> <sup>)</sup> <sup>_×n′_</sup> _U_ <sup>_·_</sup> <sup>(</sup> <sup>_kr_</sup> <sup>+</sup> <sup>_ki_</sup> <sup>)</sup>

_W_ R _∈_ C _n′U_ <sup>_·_</sup> <sup>(</sup> <sup>_kr_</sup> <sup>+</sup> <sup>_ki_</sup> <sup>)</sup> <sup>_×n′_</sup> _U_ <sup>_·_</sup> <sup>(</sup> <sup>_kr_</sup> <sup>+</sup> <sup>_ki_</sup> <sup>)</sup>

_V_ R _∈_ M _m×n′U_ <sup>_·_</sup> <sup>(</sup> <sup>_kr_</sup> <sup>+</sup> <sup>_ki_</sup> <sup>) (</sup> <sup>_{−_</sup> <sup>1</sup> <sup>_,_</sup> <sup>1</sup>

_n′U_ <sup>_·_</sup> <sup>(</sup> <sup>_kr_</sup> <sup>+</sup> <sup>_ki_</sup> <sup>) (</sup> <sup>_{−_</sup> <sup>1</sup> <sup>_,_</sup> <sup>1</sup> <sup>_}_</sup> <sup>)</sup>

_VP_ _∈_ M _m×_ ( _n′U_

2 _·m_ ( _{−_ 1 _,_ 1 _}_ )

_′U_ <sup>)</sup>

= _h_ <sup>_′_</sup> _U_

_h_ R( **x** 1 _, . . .,_ **x** _kr_ _,_ **x** <sup>_′_</sup> 1

_′U_ <sup>_m_</sup> <sup>) :=</sup> <sup>_h_</sup> _U_ <sup>_′_</sup>

_hP_ ( **x** 1 _, · · ·_ _,_ **x** _n′U_

_U_

�� _nU′_ <sup>_m_</sup>
_i_ =1 <sup>_ai_</sup> <sup>**x**</sup> <sup>_i_</sup>

- _kj_ =1 _r_ <sup>**x**</sup> <sup>_j_</sup> <sup>+</sup> _Nii_ <sup>R</sup>

<sup>_′_</sup> 1 <sup>_, . . .,_</sup> <sup>**x**</sup> <sup>_′_</sup> _ki_ <sup>)</sup>

- <u>1</u>
_Nr_ <sup>R</sup>

- _ki_
_j_ =1 <sup>**x**</sup> _j_ <sup>_′_</sup>

- _ki_
_j_ =1 <sup>**x**</sup> _j_ <sup>_′_</sup>

_n_ R = _n_ <sup>_′_</sup>

_np_ = _n_ <sup>_′_</sup>

_U_ <sup>_′_</sup> <sup>_m_</sup> <sup>)</sup>

_n_ R = _n_ <sup>_′_</sup> _U_ <sup>_·_</sup> <sup>(</sup> <sup>_kr_</sup> <sup>+</sup> <sup>_ki_</sup> <sup>)</sup>

_kr, ki_ satisfies gcd( _kr, n_ <sup>_′_</sup>

<sup>_′_</sup> _U_ <sup>) = 1</sup>

Figure 2: Detailed flow of the main results of this paper

(2021)) represent an important step in transferring reservoir computation ideas to real-world
and industrial applications.
