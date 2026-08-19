# litman-eqprop-without-limits-2025

> Converted from `litman-eqprop-without-limits-2025.pdf` on 2026-08-18 via `pymupdf4llm`.
> Layout artefacts (broken equations, interleaved columns) are conversion noise, not the source.

---

# Equilibrium Propagation Without Limits

Elon Litman <sup>1</sup>

_We liberate Equilibrium Propagation (EP) from the limit of infinitesimal perturbations by_
_establishing a finite-nudge foundation for local credit assignment. By modeling network states_
_as Gibbs-Boltzmann distributions rather than deterministic points, we prove that the gradient_
_of the difference in Helmholtz free energy between a nudged and free phase is exactly the_
_difference in expected local energy derivatives. This validates the classic Contrastive Hebbian_
_Learning_ _update_ _as_ _an_ _exact_ _gradient_ _estimator_ _for_ _arbitrary_ _finite_ _nudging,_ _requiring_
_neither infinitesimal approximations nor convexity. Furthermore, we derive a generalized_
_EP algorithm based on the path integral of loss-energy covariances, enabling learning with_
_strong error signals that standard infinitesimal approximations cannot support._

**1** **INTRODUCTION**

Backpropagation provides an efficient solution to the credit assignment problem in layered and recurrent networks [40, 33] and underpins most contemporary
applications of deep neural networks [22, 19, 14, 36]. At the same time, the algorithm relies on a dedicated backward pass that transports errors through the
network using the exact transpose of the forward weights. This weight transport
requirement and the associated non-locality are widely regarded as biologically
implausible and difficult to reconcile with the constraints of real neural circuits

[7, 13, 3, 25, 42]. Empirical and theoretical work in neuroscience instead points
to synaptic plasticity rules that depend on locally available variables such as pre
and postsynaptic activity [15], their timing [12, 6], and possibly a small number of
modulatory signals [38].

This tension has motivated a broad search for learning rules that are both
powerful and local. Proposals include multivariate Hebbian and three-factor rules,
feedback alignment and its variants [24, 30], target propagation [23], and predictive
coding style architectures that attempt to approximate error backpropagation
with local computations [41, 27, 5]. While these approaches relax strict weight
symmetry and can achieve reasonable performance, they often lack a clean global

**AFFILIATION** <sup>1</sup> Stanford University
**CORRESPONDENCE** elonlit@stanford.edu
**VERSION** December 1, 2025

<u>Elon Litman</u> <u>Equilibrium Propagation Without Limits</u>

objective, or they rely on auxiliary mechanisms whose physical or biological status
is unclear [3, 25, 42].

Energy based models provide a natural framework in which to formulate local
learning [17, 1, 21]. In this setting a network is defined by an energy function over
states and parameters, and its dynamics can be viewed as a relaxation process
that lowers this energy [16, 8]. Contrastive Hebbian Learning (CHL) [28, 32, 43]
and Equilibrium Propagation (EP) [34, 35] are two influential schemes that exploit
this structure. Both use a free phase, in which the network state is driven only by
the input, and a nudged phase, in which a supervisory signal biases the system
toward target configurations [10, 20, 31]. Parameters are updated according to the
difference between local statistics measured in the two phases, which yields a
local two-phase learning rule.

Despite their appeal, the theoretical status of these methods is incomplete. In
its classical form, CHL is derived for architectures with symmetric weights and a
single well defined energy function [28, 43]. Under those assumptions, contrastive
updates can be identified with gradients of a likelihood or related energy based
objective [21]. As soon as the infinitesimal limit is relaxed, which is required
for noise tolerance in physical implementations and in biological circuits, the
learning rule remains well defined but it is no longer obvious what global quantity
it optimizes, if any [43, 24, 8]. EP addresses the weight transport issue by avoiding
an explicit backward pass. It couples the energy to a supervised loss via a nudging
parameter and recovers the gradient of the supervised objective in the limit of
an infinitesimal perturbation [34, 35, 10]. In practice, however, finite nudging is
required for stable learning, which introduces bias relative to the true gradient.
Moreover, most analyses assume deterministic dynamics at zero temperature,
in which the network state is identified with a single energy minimum [1], an
idealization that is difficult to justify for complex nonconvex energy landscapes

[26, 9, 29].

This paper develops a statistical mechanics foundation for contrastive learning
that resolves these issues. Instead of treating the network as a deterministic energy
minimizer, we model its state as a random variable distributed according to a
Gibbs–Boltzmann measure at finite temperature, defined by an energy function
and a task-dependent loss. Within this framework we introduce the stochastic
contrastive objective, defined as the difference in Helmholtz free energy between
the nudged and free phases. This objective depends only on the underlying energy
based model and the loss and is well defined for arbitrary nonlinear architectures,
nonconvex energy landscapes, and finite temperature dynamics [26, 9, 29].

2

<u>Elon Litman</u> <u>Equilibrium Propagation Without Limits</u>

We prove that the stochastic contrastive objective admits two exact and complementary gradient representations. The first expresses the gradient as the
difference between the expected local energy derivatives under the nudged and
free Gibbs distributions. This shows that the familiar two-phase contrastive update
implements exact gradient descent on a well defined free energy objective, rather
than an approximation to some other quantity, and it does so without requiring
symmetric weights or an infinitesimal nudging limit. The second representation
expresses the same gradient as an integral, over the nudging strength, of the
covariance between the loss and the local energy derivatives. This yields a finite
nudging generalization of Equilibrium Propagation in which the classical EP rule
appears as a first order approximation around the free phase [34, 35, 10, 20]. Finally, using the Gibbs variational principle, we show that the stochastic contrastive
objective is a regularized proxy objective of the expected supervised loss, as it
decomposes into an accuracy term and an information term that penalizes the
Kullback–Leibler divergence between nudged and free distributions. This links
our framework to variational inference [18, 39, 4], the information bottleneck

[37, 2], and free energy based theories of brain function [11, 5].

The rest of the paper develops these results formally. We first introduce the
statistical mechanics formalism and define the stochastic contrastive objective. We
then derive the exact gradient formulas, establish the variational and informationtheoretic interpretations, and discuss implications for local learning algorithms
and their relationship to existing contrastive and equilibrium methods.

**2** **THE HELMHOLTZIAN FOUNDATION FOR CONTRASTIVE LEARNING**

We begin by formalizing our theory, moving from the standard deterministic
view to a more general statistical one.

**2.1** **FROM DETERMINISTIC STATES TO GIBBS DISTRIBUTIONS**

Let the state of the network be a vector _𝑠_ ∈S, where S is a measurable state
space (e.g., R <sup>_𝑛_</sup> ). Let the learnable parameters be a vector _𝜃_ ∈ Θ ⊆ R <sup>_𝑝_</sup> .

**Definition2.1** (Energy, Loss, and Objective Kernel) **.** _An energy function 𝐸_ : Θ×S → R
_is a measurable function, assumed to be continuously differentiable in 𝜃. A loss function_
_ℓ_ : S → R _is a measurable function, independent of 𝜃. For a nudging parameter 𝛽_ ∈[0 _,_ 1]
_and a temperature 𝑇>_ 0 _(often set to_ 1 _without loss of generality), the objective kernel is_
_𝐹_ ( _𝜃, 𝛽, 𝑠_ ) ≜ _𝐸_ ( _𝜃, 𝑠_ ) + _𝛽ℓ_ ( _𝑠_ ) _._

In a deterministic setting, the system’s state would be a minimizer of _𝐹_ . We
generalize this by defining a probability distribution over all states.

3

<u>Elon Litman</u> <u>Equilibrium Propagation Without Limits</u>

**Definition 2.2** (Gibbs-Boltzmann Distribution) **.** _The Gibbs-Boltzmann distribution is_
_a probability measure on_ S _with density function 𝜌𝛽_ ( _𝑠_ ; _𝜃_ ) _given by:_

(1)

<u>1</u>
_𝜌𝛽_ ( _𝑠_ ; _𝜃_ ) = _𝑍𝛽_ ( _𝜃_ ) <sup>exp</sup>

�− <sup>_𝐹_</sup> <sup>(</sup> <sup>_𝜃, 𝛽, 𝑠_</sup> <sup>)</sup>

_𝑇_

_where 𝑍𝛽_ ( _𝜃_ ) _is the partition function, a normalization constant ensuring the distribution_
_integrates to one:_

_𝑍𝛽_ ( _𝜃_ ) =

∫

S

exp

�− <sup>_𝐹_</sup> <sup>(</sup> <sup>_𝜃, 𝛽, 𝑠_</sup> <sup>)</sup>

_𝑇_

d _𝑠._ (2)

_We refer to 𝜌_ 0 ( _𝑠_ ; _𝜃_ ) _as the free distribution and 𝜌_ 1 ( _𝑠_ ; _𝜃_ ) _as the nudged distribution._

**2.2** **THE HELMHOLTZ FREE ENERGY AND THE STOCHASTIC CONTRASTIVE OBJECTIVE**

The partition function is the central quantity in statistical mechanics. Its
logarithm is directly related to the system’s free energy.

**Definition 2.3** (Helmholtz Free Energy) **.** _The Helmholtz Free Energy 𝐴_ : Θ×[0 _,_ 1] → R
_is defined as:_

_𝐴_ ( _𝜃, 𝛽_ ) ≜            - _𝑇_ log _𝑍𝛽_ ( _𝜃_ ) _._ (3)

_The free energy 𝐴_ ( _𝜃, 𝛽_ ) _is the effective energy of the entire ensemble of states, accounting_
_for both the average energy and the entropy of the distribution. It serves as the statistical_
_generalization of the deterministic value function_ min _𝑠_ _𝐹_ ( _𝑠_ ) _._

With this, we can define our main objective function for learning.

**Definition 2.4** (Stochastic Contrastive Objective) **.** _The stochastic contrastive objective_

_𝐽_ : Θ → R _is the difference between the nudged and free Helmholtz free energies:_

_𝐽_ ( _𝜃_ ) ≜ _𝐴_ ( _𝜃,_ 1) − _𝐴_ ( _𝜃,_ 0) _._ (4)

This objective measures the thermodynamic work required to transform the
system from its free state to its nudged, target-aware state. Minimizing _𝐽_ ( _𝜃_ ) corresponds to adjusting parameters _𝜃_ such that the target information embodied
by _ℓ_ ( _𝑠_ ) aligns with the natural energy landscape _𝐸_ ( _𝜃, 𝑠_ ), reducing the cost of this
transformation.

**2.3** **REGULARITY CONDITIONS**

Our results, while general, rely on standard regularity conditions from mathematical physics to ensure that the defined quantities are well-behaved. We assume
the following for all relevant _𝜃_ and _𝛽_ :

4

<u>Elon Litman</u> <u>Equilibrium Propagation Without Limits</u>

**Finiteness of Partition Functions.** The integrals defining the partition functions
_𝑍𝛽_ ( _𝜃_ ) are finite. This requires that exp(− _𝐹_ / _𝑇_ ) decays sufficiently fast over the state
space S.

**Differentiability under the Integral Sign.** The function _𝐸_ ( _𝜃, 𝑠_ ) is sufficiently
regular such that differentiation with respect to _𝜃_ and _𝛽_ and integration over _𝑠_
can be interchanged (i.e., the Leibniz integral rule is applicable). This is typically
satisfied if ∇ _𝜃𝐸_ ( _𝜃, 𝑠_ ) is dominated by an integrable function of _𝑠_ . See Appendix A
for details.

**3** **EXACT GRADIENTS FOR THE CONTRASTIVE OBJECTIVE**

We now present our main theorems, which provide exact expressions for the
gradient of the objective _𝐽_ ( _𝜃_ ).

**Theorem 3.1** (Gradient as Expectation Contrast) **.** _Under Assumption 2.3, the gradient_
_of the stochastic contrastive objective_ _𝐽_ ( _𝜃_ ) _is given exactly by the difference between the_
_expected partial derivative of the energy under the nudged (𝛽_ = 1 _) and free (𝛽_ = 0 _) Gibbs_
_distributions:_

∇ _𝜃_ _𝐽_ ( _𝜃_ ) = E _𝑠_ ∼ _𝜌_ 1 ( _𝑠_ ; _𝜃_ ) [∇ _𝜃𝐸_ ( _𝜃, 𝑠_ )] − E _𝑠_ ∼ _𝜌_ 0 ( _𝑠_ ; _𝜃_ ) [∇ _𝜃𝐸_ ( _𝜃, 𝑠_ )] _._ (5)

_Proof._ The gradient of the Helmholtz free energy _𝐴_ ( _𝜃, 𝛽_ ) with respect to the parameters _𝜃_ is:

<u>1</u>
∇ _𝜃_ _𝐴_ ( _𝜃, 𝛽_ ) = ∇ _𝜃_ [− _𝑇_ log _𝑍𝛽_ ( _𝜃_ )] = − _𝑇_ _𝑍𝛽_ ( _𝜃_ ) <sup>∇</sup> <sup>_𝜃𝑍𝛽_</sup> <sup>(</sup> <sup>_𝜃_</sup> <sup>)</sup> <sup>_._</sup> (6)

By Assumption 2.3, we can apply the Leibniz integral rule to differentiate the
partition function:

∫

S

∇ _𝜃_

exp

∇ _𝜃𝑍𝛽_ ( _𝜃_ ) = ∇ _𝜃_

∫

=

S

∫

=

S

exp

�− <sup>_𝐸_</sup> <sup>(</sup> <sup>_𝜃, 𝑠_</sup> <sup>) +</sup> <sup>_𝛽ℓ_</sup> <sup>(</sup> <sup>_𝑠_</sup> <sup>)</sup>

_𝑇_

d _𝑠_ (7)

��

�− <sup>_𝐹_</sup> <sup>(</sup> <sup>_𝜃, 𝛽, 𝑠_</sup> <sup>)</sup>

_𝑇_

�− <sup>_𝐹_</sup> <sup>(</sup> <sup>_𝜃, 𝛽, 𝑠_</sup> <sup>)</sup>

_𝑇_

��− <sup><u>1</u></sup>

_𝑇_

d _𝑠_ (8)

∇ _𝜃𝐸_ ( _𝜃, 𝑠_ )d _𝑠_ (9)

exp

∫

S

= − <sup><u>1</u></sup>

_𝑇_

_𝑍𝛽_ ( _𝜃_ ) _𝜌𝛽_ ( _𝑠_ ; _𝜃_ )∇ _𝜃𝐸_ ( _𝜃, 𝑠_ )d _𝑠_ (10)

= − <sup>_𝑍𝛽_</sup> <sup>(</sup> <sup>_𝜃_</sup> <sup>)</sup> E _𝑠_ ∼ _𝜌𝛽_ ( _𝑠_ ; _𝜃_ ) [∇ _𝜃𝐸_ ( _𝜃, 𝑠_ )] _._ (11)

_𝑇_

5

<u>Elon Litman</u> <u>Equilibrium Propagation Without Limits</u>

Substituting this expression back into the equation for ∇ _𝜃_ _𝐴_ ( _𝜃, 𝛽_ ):

<u>1</u>
∇ _𝜃_ _𝐴_ ( _𝜃, 𝛽_ ) = − _𝑇_
_𝑍𝛽_ ( _𝜃_ )

�− <sup>_𝑍𝛽_</sup> <sup>(</sup> <sup>_𝜃_</sup> <sup>)</sup> E _𝑠_ ∼ _𝜌𝛽_ ( _𝑠_ ; _𝜃_ ) [∇ _𝜃𝐸_ ( _𝜃, 𝑠_ )]

_𝑇_

(12)

= E _𝑠_ ∼ _𝜌𝛽_ ( _𝑠_ ; _𝜃_ ) [∇ _𝜃𝐸_ ( _𝜃, 𝑠_ )] _._ (13)

This shows that the gradient of the free energy is the expectation of the energy
gradient. The gradient of our objective _𝐽_ ( _𝜃_ ) follows from the linearity of the
gradient operator:

∇ _𝜃_ _𝐽_ ( _𝜃_ ) = ∇ _𝜃_ [ _𝐴_ ( _𝜃,_ 1) − _𝐴_ ( _𝜃,_ 0)] = ∇ _𝜃_ _𝐴_ ( _𝜃,_ 1) −∇ _𝜃_ _𝐴_ ( _𝜃,_ 0) _._ (14)

Applying our derived result for _𝛽_ = 1 and _𝛽_ = 0 immediately yields the theorem:

∇ _𝜃_ _𝐽_ ( _𝜃_ ) = E _𝑠_ ∼ _𝜌_ 1 ( _𝑠_ ; _𝜃_ ) [∇ _𝜃𝐸_ ( _𝜃, 𝑠_ )] − E _𝑠_ ∼ _𝜌_ 0 ( _𝑠_ ; _𝜃_ ) [∇ _𝜃𝐸_ ( _𝜃, 𝑠_ )] _._ (15)

**Remark 3.2** (Connection to CHL and EP) **.** _Theorem 3.1 provides the statistical foun-_
_dation for the two-phase contrastive learning rule. It demonstrates that a learning rule_
_based on the difference of local statistics_ ∇ _𝜃𝐸_ _between a nudged and a free phase performs_
_exact gradient descent on the well-defined objective_ _𝐽_ ( _𝜃_ ) _. In the zero-temperature limit_
_(𝑇_ → 0 _), the Gibbs distributions 𝜌𝛽_ _concentrate on the global minimizers of 𝐹_ ( _𝜃, 𝛽, 𝑠_ ) _,_
_and this result recovers the deterministic rule from prior work, but now without needing_
_assumptions of convexity or unique minima._

Our second theorem provides an alternative expression for the gradient, connecting it to the path taken by the system as the nudging strength _𝛽_ increases from
0 to 1. We first establish a lemma.

**Lemma 3.3** (Derivative of Free Energy w.r.t. Nudging) **.** _The partial derivative of the_
_Helmholtz free energy with respect to the nudging parameter_ _𝛽_ _is the expected value of_
_the loss function:_

_𝜕𝐴_ ( _𝜃, 𝛽_ )

= E _𝑠_ ∼ _𝜌𝛽_ ( _𝑠_ ; _𝜃_ ) [ _ℓ_ ( _𝑠_ )] _._ (16)
_𝜕𝛽_

_Proof._ Following a similar procedure as in Theorem 3.1:

_𝜕𝐴_ ( _𝜃, 𝛽_ ) <u>1</u>

= − _𝑇_
_𝜕𝛽_ _𝑍𝛽_ ( _𝜃_ )

6

_𝜕𝑍𝛽_ ( _𝜃_ )

_._ (17)
_𝜕𝛽_

<u>Elon Litman</u> <u>Equilibrium Propagation Without Limits</u>

Differentiating the partition function with respect to _𝛽_ :

_𝜕𝑍𝛽_ ( _𝜃_ )

=
_𝜕𝛽_

∫

S

��− <sup>_ℓ_</sup> <sup>(</sup> <sup>_𝑠_</sup> <sup>)</sup> 
_𝑇_

exp

∫

S

�− <sup>_𝐸_</sup> <sup>(</sup> <sup>_𝜃, 𝑠_</sup> <sup>) +</sup> <sup>_𝛽ℓ_</sup> <sup>(</sup> <sup>_𝑠_</sup> <sup>)</sup>

_𝑇_

d _𝑠_ (18)

= − <sup><u>1</u></sup>

_𝑇_

_𝑍𝛽_ ( _𝜃_ ) _𝜌𝛽_ ( _𝑠_ ; _𝜃_ ) _ℓ_ ( _𝑠_ )d _𝑠_ = − <sup>_𝑍𝛽_</sup> <sup>(</sup> <sup>_𝜃_</sup> <sup>)</sup> E _𝑠_ ∼ _𝜌𝛽_ [ _ℓ_ ( _𝑠_ )] _._ (19)

_𝑇_

Substituting this back gives the result:

_𝜕𝐴_ ( _𝜃, 𝛽_ ) <u>1</u>

= − _𝑇_
_𝜕𝛽_ _𝑍𝛽_ ( _𝜃_ )

�− <sup>_𝑍𝛽_</sup> <sup>(</sup> <sup>_𝜃_</sup> <sup>)</sup> E _𝑠_ ∼ _𝜌𝛽_ [ _ℓ_ ( _𝑠_ )]

_𝑇_

= E _𝑠_ ∼ _𝜌𝛽_ [ _ℓ_ ( _𝑠_ )] _._ (20)

**Theorem 3.4** (Gradient as Integrated Covariance) **.** _The_ _gradient_ _of_ _the_ _objective_

_𝐽_ ( _𝜃_ ) _is given by the integral of the covariance between the loss and the energy gradient,_
_evaluated along the path of distributions from_ _𝛽_ = 0 _to_ _𝛽_ = 1 _:_

∇ _𝜃_ _𝐽_ ( _𝜃_ ) = − <sup><u>1</u></sup>

_𝑇_

∫ 1

Cov _𝑠_ ∼ _𝜌𝛽_ ( _𝑠_ ; _𝜃_ ) [ _ℓ_ ( _𝑠_ ) _,_ ∇ _𝜃𝐸_ ( _𝜃, 𝑠_ )] d _𝛽._ (21)
0

_Proof._ By the Fundamental Theorem of Calculus and Lemma 3.3, we can write

_𝐽_ ( _𝜃_ ) as an integral:

∫ 1

E _𝑠_ ∼ _𝜌𝛽_ ( _𝑠_ ; _𝜃_ ) [ _ℓ_ ( _𝑠_ )]d _𝛽._ (22)
0

_𝐽_ ( _𝜃_ ) = _𝐴_ ( _𝜃,_ 1) − _𝐴_ ( _𝜃,_ 0) =

∫ 1

0

_𝜕𝐴_ ( _𝜃, 𝛽_ )

d _𝛽_ =
_𝜕𝛽_

We now take the gradient of this expression with respect to _𝜃_ . Assumption 2.3
allows interchanging the gradient and the integral over _𝛽_ :

∇ _𝜃_ _𝐽_ ( _𝜃_ ) =

∫ 1

∇ _𝜃_
0

- E _𝑠_ ∼ _𝜌𝛽_ ( _𝑠_ ; _𝜃_ ) [ _ℓ_ ( _𝑠_ )] d _𝛽._ (23)

We analyze the inner term ∇ _𝜃_ E _𝑠_ ∼ _𝜌𝛽_ [ _ℓ_ ( _𝑠_ )] using the log-derivative trick:

∇ _𝜃_ E _𝑠_ ∼ _𝜌𝛽_ [ _ℓ_ ( _𝑠_ )] = ∇ _𝜃_

∫

=

S

∫

=

S

∫

S

_𝜌𝛽_ ( _𝑠_ ; _𝜃_ ) _ℓ_ ( _𝑠_ )d _𝑠_ (24)

(∇ _𝜃𝜌𝛽_ ( _𝑠_ ; _𝜃_ )) _ℓ_ ( _𝑠_ )d _𝑠_ (25)

_𝜌𝛽_ ( _𝑠_ ; _𝜃_ )(∇ _𝜃_ log _𝜌𝛽_ ( _𝑠_ ; _𝜃_ )) _ℓ_ ( _𝑠_ )d _𝑠_ (26)

= E _𝑠_ ∼ _𝜌𝛽_ [ _ℓ_ ( _𝑠_ )∇ _𝜃_ log _𝜌𝛽_ ( _𝑠_ ; _𝜃_ )] _._ (27)

7

<u>Elon Litman</u> <u>Equilibrium Propagation Without Limits</u>

The gradient of the log-density is:

∇ _𝜃_ log _𝜌𝛽_ ( _𝑠_ ; _𝜃_ ) = ∇ _𝜃_

�− <sup>_𝐹_</sup> <sup>(</sup> <sup>_𝜃, 𝛽, 𝑠_</sup> <sup>)</sup> - log _𝑍𝛽_ ( _𝜃_ )

_𝑇_

(28)

= − _𝑇_ <sup><u>1</u></sup> <sup>∇</sup> <sup>_𝜃𝐸_</sup> <sup>(</sup> <sup>_𝜃, 𝑠_</sup> <sup>) −∇</sup> <sup>_𝜃_</sup> <sup>log</sup> <sup>_𝑍𝛽_</sup> <sup>(</sup> <sup>_𝜃_</sup> <sup>)</sup> (29)

= − _𝑇_ <sup><u>1</u></sup> <sup>∇</sup> <sup>_𝜃𝐸_</sup> <sup>(</sup> <sup>_𝜃, 𝑠_</sup> <sup>) −</sup> _𝑍𝛽_ <u>1(</u> _𝜃_ ) <sup>∇</sup> <sup>_𝜃𝑍𝛽_</sup> <sup>(</sup> <sup>_𝜃_</sup> <sup>)</sup> (30)

= − _𝑇_ <sup><u>1</u></sup>

_𝑇_ <sup><u>1</u></sup> <sup>∇</sup> <sup>_𝜃𝐸_</sup> <sup>(</sup> <sup>_𝜃, 𝑠_</sup> <sup>) +</sup> _𝑇_ <sup><u>1</u></sup>

(31)
_𝑇_ <sup><u>1</u></sup> <sup>∇</sup> <sup>_𝜃_</sup> <sup>_𝐴_</sup> <sup>(</sup> <sup>_𝜃, 𝛽_</sup> <sup>)</sup> <sup>_._</sup>

From the proof of Theorem 3.1, we know ∇ _𝜃_ _𝐴_ ( _𝜃, 𝛽_ ) = E _𝑠_ ∼ _𝜌𝛽_ [∇ _𝜃𝐸_ ( _𝜃, 𝑠_ )]. Substituting
this back:

�− _𝑇_ <sup><u>1</u></sup>

_𝑇_ <sup><u>1</u></sup> <sup>∇</sup> <sup>_𝜃𝐸_</sup> <sup>(</sup> <sup>_𝜃, 𝑠_</sup> <sup>) +</sup> _𝑇_ <sup><u>1</u></sup>

_𝑇_ <sup><u>1</u></sup> <sup>E</sup> <sup>_𝑠_</sup> <sup>∼</sup> <sup>_𝜌𝛽_</sup> <sup>[∇</sup> <sup>_𝜃𝐸_</sup> <sup>(</sup> <sup>_𝜃, 𝑠_</sup> <sup>)]</sup>

��
(32)

∇ _𝜃_ E _𝑠_ ∼ _𝜌𝛽_ [ _ℓ_ ( _𝑠_ )] = E _𝑠_ ∼ _𝜌𝛽_

_ℓ_ ( _𝑠_ )

= − <sup><u>1</u></sup>

_𝑇_

E _𝑠_ ∼ _𝜌𝛽_ [ _ℓ_ ( _𝑠_ )∇ _𝜃𝐸_ ( _𝜃, 𝑠_ )] − E _𝑠_ ∼ _𝜌𝛽_ [ _ℓ_ ( _𝑠_ )]E _𝑠_ ∼ _𝜌𝛽_ [∇ _𝜃𝐸_ ( _𝜃, 𝑠_ )]

(33)

= − _𝑇_ <sup><u>1</u></sup> <sup>Cov</sup> <sup>_𝑠_</sup> <sup>∼</sup> <sup>_𝜌𝛽_</sup> <sup>[</sup> <sup>_ℓ_</sup> <sup>(</sup> <sup>_𝑠_</sup> <sup>)</sup> <sup>_,_</sup> <sup>∇</sup> <sup>_𝜃𝐸_</sup> <sup>(</sup> <sup>_𝜃, 𝑠_</sup> <sup>)]</sup> <sup>_._</sup> (34)

Finally, substituting this expression into our integral form for ∇ _𝜃_ _𝐽_ ( _𝜃_ ) yields the
theorem.

**Remark 3.5** (Connection to Equilibrium Propagation) **.** _Theorem 3.4 provides the_
_exact, finite-𝛽_ _foundation for Equilibrium Propagation. The EP update rule is derived_
_by approximating this integral with a first-order Taylor expansion around_ _𝛽_ = 0 _. Our_
_result shows that the true gradient is an accumulation of covariances along the entire_
_thermodynamic path. Learning seeks to adjust parameters 𝜃_ _to induce an anti-correlation_
_between states with high loss and states that are sensitive to changes in 𝜃._

**4** **CONNECTION TO SUPERVISED LEARNING**

We now investigate how minimizing our objective _𝐽_ ( _𝜃_ ) relates to minimizing
the standard supervised loss, which we can define as the expected loss under the
free distribution, Lsup ( _𝜃_ ) ≜ E _𝑠_ ∼ _𝜌_ 0 [ _ℓ_ ( _𝑠_ )]. We show that _𝐽_ ( _𝜃_ ) is a regularized proxy
objective of this quantity. We first state the Gibbs variational principle.

**Lemma 4.1** (Gibbs Variational Principle) **.** _The Helmholtz free energy_ _𝐴_ ( _𝜃, 𝛽_ ) _is the_
_minimum of the variational free energy functional over all probability distributions_
_𝑞_ ( _𝑠_ ) _:_

       
_𝐴_ ( _𝜃, 𝛽_ ) = min _𝑞_ E _𝑠_ ∼ _𝑞_ ( _𝑠_ ) [ _𝐸_ ( _𝜃, 𝑠_ ) + _𝛽ℓ_ ( _𝑠_ )] − _𝑇𝑆_ ( _𝑞_ )

8

_,_ (35)

<u>Elon Litman</u> <u>Equilibrium Propagation Without Limits</u>

_where_

∫

_𝑞_ ( _𝑠_ ) log _𝑞_ ( _𝑠_ )d _𝑠_ (36)

_𝑆_ ( _𝑞_ ) = −

_is the differential entropy of the distribution 𝑞. The minimum is achieved uniquely at_
_𝑞_ ( _𝑠_ ) = _𝜌𝛽_ ( _𝑠_ ; _𝜃_ ) _._

**Theorem 4.2** (Variational Bound on Supervised Loss) **.** _The stochastic contrastive_
_objective_ _𝐽_ ( _𝜃_ ) _provides a tight variational lower bound on the expected supervised loss_
_under the free distribution:_

_𝐽_ ( _𝜃_ ) ≤ E _𝑠_ ∼ _𝜌_ 0 ( _𝑠_ ; _𝜃_ ) [ _ℓ_ ( _𝑠_ )] _._ (37)

_Proof._ From the Gibbs Variational Principle (Lemma 4.1), the free energy _𝐴_ ( _𝜃,_ 1)
is the minimum of the variational free energy functional. Therefore, for any trial
distribution _𝑞_ ( _𝑠_ ), we have:

_𝐴_ ( _𝜃,_ 1) ≤ E _𝑠_ ∼ _𝑞_ ( _𝑠_ ) [ _𝐸_ ( _𝜃, 𝑠_ ) + _ℓ_ ( _𝑠_ )] − _𝑇𝑆_ ( _𝑞_ ) _._ (38)

Let us choose the free distribution _𝑞_ ( _𝑠_ ) = _𝜌_ 0 ( _𝑠_ ; _𝜃_ ) as our specific trial distribution.
Substituting this in:

_𝐴_ ( _𝜃,_ 1) ≤ E _𝑠_ ∼ _𝜌_ 0 [ _𝐸_ ( _𝜃, 𝑠_ ) + _ℓ_ ( _𝑠_ )] − _𝑇𝑆_ ( _𝜌_ 0) (39)

= E _𝑠_ ∼ _𝜌_ 0 [ _𝐸_ ( _𝜃, 𝑠_ )] + E _𝑠_ ∼ _𝜌_ 0 [ _ℓ_ ( _𝑠_ )] − _𝑇𝑆_ ( _𝜌_ 0) _._ (40)

By definition, the Helmholtz free energy of the free system is

_𝐴_ ( _𝜃,_ 0) = E _𝑠_ ∼ _𝜌_ 0 [ _𝐸_ ( _𝜃, 𝑠_ )] − _𝑇𝑆_ ( _𝜌_ 0) _._ (41)

Substituting this into our inequality gives:

_𝐴_ ( _𝜃,_ 1) ≤ _𝐴_ ( _𝜃,_ 0) + E _𝑠_ ∼ _𝜌_ 0 [ _ℓ_ ( _𝑠_ )] _._ (42)

Rearranging the terms yields the final result:

_𝐽_ ( _𝜃_ ) = _𝐴_ ( _𝜃,_ 1) − _𝐴_ ( _𝜃,_ 0) ≤ E _𝑠_ ∼ _𝜌_ 0 [ _ℓ_ ( _𝑠_ )] _._ (43)

**Remark** **4.3.** _Theorem_ _4.2_ _establishes_ _𝐽_ ( _𝜃_ ) _as_ _a_ _lower_ _bound,_ _but_ _the_ _justification_
_for_ _minimizing_ _it_ _is_ _twofold._ _First,_ _for_ _non-negative_ _losses,_ _𝐽_ ( _𝜃_ ) = 0 _if_ _and_ _only_ _if_
E _𝜌_ 0 [ _ℓ_ ( _𝑠_ )] = 0 _; thus, global minima of the objective are global minima of the supervised_
_loss. Second, as we will see in Theorem 5.1,_ _𝐽_ ( _𝜃_ ) _effectively minimizes the loss under the_
_nudged distribution while simultaneously pulling the free distribution toward it via KL_
_regularization._

9

<u>Elon Litman</u> <u>Equilibrium Propagation Without Limits</u>

**5** **INFORMATION-THEORETIC INTERPRETATION**

We now reveal that _𝐽_ ( _𝜃_ ) can be decomposed into two competing terms: an
information-theoretic cost that measures the distance between the free and nudged
distributions, and a performance cost that measures the residual loss in the nudged
state. This decomposition provides a direct link to the principles of variational
inference and the information bottleneck.

**Theorem 5.1** (Information-Performance Decomposition) **.** _Under the same condi-_
_tions as before,_ _𝐽_ ( _𝜃_ ) _can be exactly decomposed as:_

_𝐽_ ( _𝜃_ ) = E _𝑠_ ∼ _𝜌_ 1 ( _𝑠_ ; _𝜃_ ) [ _ℓ_ ( _𝑠_ )] + _𝑇_ KL( _𝜌_ 1 ( _𝑠_ ; _𝜃_ ) ∥ _𝜌_ 0 ( _𝑠_ ; _𝜃_ )) (44)

_where_ KL( _𝑝_ ∥ _𝑞_ ) _is the Kullback-Leibler (KL) divergence between distributions_ _𝑝_ _and 𝑞._

_Proof._ The proof proceeds directly from the definition of the KL divergence. Let
_𝜌_ 1 ≜ _𝜌_ 1 ( _𝑠_ ; _𝜃_ ) and _𝜌_ 0 ≜ _𝜌_ 0 ( _𝑠_ ; _𝜃_ ) for brevity. The KL divergence from the free distribution _𝜌_ 0 to the nudged distribution _𝜌_ 1 is defined as:

- _𝜌_ <u>1</u> ( _𝑠_ )
_𝜌_ 0 ( _𝑠_ )

KL( _𝜌_ 1 ∥ _𝜌_ 0) =

∫

_𝜌_ 1 ( _𝑠_ ) log

S

d _𝑠._ (45)

We first analyze the logarithm term. By the definition of the Gibbs distributions:

_𝜌𝜌_ <u>10</u> (( _𝑠𝑠_ )) <sup>=</sup> <sup>_𝑍_</sup> _𝑍_ <sup><u>0</u></sup> 1 <sup>(</sup> ( <sup>_𝜃_</sup> _𝜃_ <sup>)</sup> )

<u>exp (−(</u> _𝐸_ ( _𝜃, 𝑠_ ) + _ℓ_ ( _𝑠_ ))/ _𝑇_ )

(46)
exp (− _𝐸_ ( _𝜃, 𝑠_ )/ _𝑇_ )

= <sup>_𝑍_</sup> <sup><u>0</u></sup> <sup>(</sup> <sup>_𝜃_</sup> <sup>)</sup>

_𝑍_ 1 ( _𝜃_ ) <sup>exp</sup>

Taking the logarithm of this ratio:

- 
 - <sup>_ℓ_</sup> <sup>(</sup> <sup>_𝑠_</sup> <sup>)</sup> _._ (47)

_𝑇_

= log

- _𝑍_ <u>0</u> ( _𝜃_ )
_𝑍_ 1 ( _𝜃_ )

- - <sup>_ℓ_</sup> <sup>(</sup> <sup>_𝑠_</sup> <sup>)</sup> (48)

_𝑇_

log

 - _𝜌_ <u>1</u> ( _𝑠_ )
_𝜌_ 0 ( _𝑠_ )

= −(log _𝑍_ 1 ( _𝜃_ ) − log _𝑍_ 0 ( _𝜃_ )) − <sup>_ℓ_</sup> <sup>(</sup> <sup>_𝑠_</sup> <sup>)</sup> _._ (49)

_𝑇_

Recalling the definition of the Helmholtz Free Energy, _𝐴_ ( _𝜃, 𝛽_ ) = − _𝑇_ log _𝑍𝛽_ ( _𝜃_ ), we
have log _𝑍𝛽_ ( _𝜃_ ) = − _𝐴_ ( _𝜃, 𝛽_ )/ _𝑇_ . Substituting this in:

�− <sup>_𝐴_</sup> <sup>(</sup> <sup>_𝜃,_</sup> <sup><u>1)</u></sup> 
_𝑇_

�− <sup>_𝐴_</sup> <sup>(</sup> <sup>_𝜃,_</sup> <sup><u>0)</u></sup>

_𝑇_

�� - <sup>_ℓ_</sup> <sup>(</sup> <sup>_𝑠_</sup> <sup>)</sup> (50)

_𝑇_

log

- _𝜌_ <u>1</u> ( _𝑠_ )
_𝜌_ 0 ( _𝑠_ )

= −

= <sup>_𝐴_</sup> <sup>(</sup> <sup>_𝜃,_</sup> <sup><u>1) −</u></sup> <sup>_𝐴_</sup> <sup>(</sup> <sup>_𝜃,_</sup> <sup><u>0)</u></sup>

<sup>(</sup> <sup>_𝑠_</sup> <sup>)</sup> _._ (51)

_𝑇_

<sup>) −</sup> <sup>_𝐴_</sup> <sup>(</sup> <sup>_𝜃,_</sup> <sup><u>0)</u></sup> - <sup>_ℓ_</sup> <sup>(</sup> <sup>_𝑠_</sup> <sup>)</sup>

_𝑇_ _𝑇_

10

<u>Elon Litman</u> <u>Equilibrium Propagation Without Limits</u>

By the definition of our objective, _𝐽_ ( _𝜃_ ) = _𝐴_ ( _𝜃,_ 1) − _𝐴_ ( _𝜃,_ 0), this simplifies to:

  - _𝜌_ <u>1</u> ( _𝑠_ )

log

_𝜌_ 0 ( _𝑠_ )

= <sup>_𝐽_</sup> <sup>(</sup> <sup>_𝜃_</sup> <sup>) −</sup> <sup>_ℓ_</sup> <sup>(</sup> <sup>_𝑠_</sup> <sup>)</sup> _._ (52)

_𝑇_

Now, we substitute this back into the definition of the KL divergence:

KL( _𝜌_ 1 ∥ _𝜌_ 0) =

∫

S

_𝜌_ 1 ( _𝑠_ )

- _𝐽_ ( _𝜃_ ) − _ℓ_ ( _𝑠_ ) 
_𝑇_

d _𝑠_ (53)

= <sup><u>1</u></sup>

_𝑇_

∫

S

_𝜌_ 1 ( _𝑠_ ) _𝐽_ ( _𝜃_ )d _𝑠_ - <sup><u>1</u></sup>

_𝑇_

∫

S

_𝜌_ 1 ( _𝑠_ ) _ℓ_ ( _𝑠_ )d _𝑠._ (54)

Since _𝐽_ ( _𝜃_ ) is a constant with respect to the integration variable _𝑠_, and ∫ _𝜌_ 1 ( _𝑠_ )d _𝑠_ = 1,

the first term simplifies. The second term is, by definition, the expectation of _ℓ_ ( _𝑠_ )
under _𝜌_ 1.

Since _𝐽_ ( _𝜃_ ) is a constant with respect to the integration variable _𝑠_, and

∫

KL( _𝜌_ 1 ∥ _𝜌_ 0) = <sup>_𝐽_</sup> <sup>(</sup> <sup>_𝜃_</sup> <sup>)</sup>

_𝑇_ <sup><u>1</u></sup> <sup>E</sup> <sup>_𝑠_</sup> <sup>∼</sup> <sup>_𝜌_</sup> <sup>1 [</sup> <sup>_ℓ_</sup> <sup>(</sup> <sup>_𝑠_</sup> <sup>)]</sup> <sup>_._</sup> (55)

<sup>(</sup> <sup>_𝜃_</sup> <sup>)</sup> - <sup><u>1</u></sup>

_𝑇_ _𝑇_

Rearranging this equation to solve for _𝐽_ ( _𝜃_ ) yields the theorem:

_𝐽_ ( _𝜃_ ) = E _𝑠_ ∼ _𝜌_ 1 [ _ℓ_ ( _𝑠_ )] + _𝑇_ KL( _𝜌_ 1 ∥ _𝜌_ 0) _._ (56)

**Remark** **5.2** (Mechanism of Learning) **.** _While_ _Theorem_ _4.2_ _establishes_ _𝐽_ ( _𝜃_ ) _as_ _a_
_lower bound on the supervised loss_ E _𝜌_ 0 [ _ℓ_ ] _, minimizing a lower bound does not strictly_
_guarantee minimization of the target. Theorem 5.1 resolves this by identifying_ _𝐽_ ( _𝜃_ ) _as_
_a regularized surrogate rather than a loose bound. The objective explicitly minimizes_
_the loss in the nudged phase (𝜌_ 1 _) while simultaneously minimizing the KL divergence_
_between 𝜌_ 1 _and 𝜌_ 0 _. This compels the free phase to emulate the low-energy statistics of_
_the nudged phase, effectively distilling the supervisory signal into the network’s natural_
_dynamics._

**6** **RESULTS**

We evaluated finite–nudge Equilibrium Propagation (EP) on Fashion–MNIST
using a single–layer energy–based network with `tanh` units. Holding architecture
and optimization constant, we varied only the learning rule and nudging strength

_𝛽_ . Figure 1 summarizes the structural, statistical, and practical implications of
our findings. First, we assessed classification performance (Fig. 1, Panel C). We
compared four training schemes: classical infinitesimal EP ( _𝛽_ = 0 _._ 01), finite–nudge

11

<u>Elon Litman</u> <u>Equilibrium Propagation Without Limits</u>

EP ( _𝛽_ = 1 _._ 0), a discrete path–integral variant, and standard backpropagation. Infinitesimal EP failed, stalling near chance (20–30% accuracy). Conversely, both
finite–nudge and path–integral EP rapidly achieved ∼ 80% accuracy, closely tracking the backpropagation baseline. These results confirm that large- _𝛽_ contrastive
learning is a competitive training mechanism, while the infinitesimal regime is
ineffective for this task.

Next, we analyzed the signal–to–noise ratio (SNR) of the state updates (Fig. 1,
Panel B). We measured the SNR of the activity difference Δ _𝑠_ = _𝑠𝛽_ - _𝑠_ 0 over repeated
Langevin runs. For _𝛽_ ≲ 10 <sup>−2</sup>, the update signal was indistinguishable from sampling noise. As _𝛽_ approached 1, SNR improved by an order of magnitude. This
empirically confirms that finite nudging unlocks a signal regime inaccessible to
the classical small- _𝛽_ limit.

Finally, we inspected the orientation of the parameter updates (Fig. 1, Panel A).
We measured the cosine similarity between the practical contrastive update and
two benchmarks: the exact supervised gradient (∇Lsup) and the Monte Carlo
estimate of the free–energy gradient (∇ _𝐽𝛽_ ). Alignment was negligible near _𝛽_ ≈ 10 <sup>−3</sup>

but increased monotonically, reaching ∼ 0 _._ 5 at _𝛽_ = 1. Thus, finite–nudge EP aligns
with the true thermodynamic objective and, by operating at large _𝛽_, overcomes
the noise limitations that cripple infinitesimal approaches.

**7** **CONCLUSION**

This work decouples Equilibrium Propagation from the infinitesimal limit. We
proved that finite-nudge learning is not a biased approximation of backpropagation, but exact gradient descent on the Helmholtz free energy difference. This
statistical view reinterprets the _error_ of large nudges as a variational term that
minimizes the divergence between free and target distributions. Empirically,
unlocking the finite-nudge regime solves the signal-to-noise problem that cripples
infinitesimal approaches.

**REFERENCES**

[1] David H. Ackley, Geoffrey E. Hinton, and Terrence J. Sejnowski. A learning

algorithm for Boltzmann machines. _Cognitive Science_, 9(1):147–169, 1985.

[2] Alexander A. Alemi, Ian Fischer, Joshua V. Dillon, and Kevin Murphy. Deep

variational information bottleneck. In _International Conference on Learning_
_Representations_, 2017.

12

<u>Elon Litman</u> <u>Equilibrium Propagation Without Limits</u>

0.4

0.2

0.0

0.2

10 3 10 2 10 1 10 <sup>0</sup>

Nudging strength

|Col1|B: SNR of s vs|
|---|---|
|1||
|<br>2|<br>2|
|<br>2<br>|<br>2<br>|
|<br>|<br>|

Nudging strength

90

80

70

60

50

40

30

20

10

2 4 6 8 10
Epoch

Figure 1: **Thermodynamic validation on Fashion–MNIST.** Experiments utilize a
single hidden-layer energy-based network with `tanh` units. **(A) Gradient Align-**
**ment:** Cosine similarity between the practical contrastive update _𝑔_ ˆ ( _𝛽_ ) and two
references: the supervised backprop gradient ∇Lsup and the true free-energy gradient ∇ _𝐽𝛽_ . Alignment improves monotonically with _𝛽_, confirming that large nudges
remain gradient-like. **(B) Signal-to-Noise Ratio:** SNR of the state perturbation
Δ _𝑠_ = _𝑠𝛽_ - _𝑠_ 0. Finite nudging ( _𝛽_ → 1) yields high SNR, whereas infinitesimal nudges
( _𝛽_ ≲ 10 <sup>−2</sup> ) are dominated by sampling noise. **(C) Test Accuracy:** Finite-nudge
( _𝛽_ = 1 _._ 0) and path-integral EP achieve ∼ 80% accuracy, closely tracking standard
backprop. Classical infinitesimal EP ( _𝛽_ = 0 _._ 01) fails to learn.

[3] Yoshua Bengio, Dong-Hyun Lee, Jörg Bornschein, Thomas Mesnard, and

Zhouhan Lin. Towards biologically plausible deep learning. _arXiv preprint_
_arXiv:1502.04156_, 2015.

[4] David M. Blei, Alp Kucukelbir, and Jon D. McAuliffe. Variational inference:

A review for statisticians. _Journal_ _of_ _the_ _American_ _Statistical_ _Association_,
112(518):859–877, 2017.

[5] Rafal Bogacz. A tutorial on the free-energy framework for modelling percep
tion and learning. _Journal of Mathematical Psychology_, 76:198–211, 2017.

[6] Natalia Caporale and Yang Dan. Spike timing–dependent plasticity: A Heb
bian learning rule. _Annual Review of Neuroscience_, 31:25–46, 2008.

[7] Francis Crick. The recent excitement about neural networks. _Nature_,
337(6203):129–132, 1989.

[8] Yilun Du and Igor Mordatch. Implicit generation and modeling with energy
based models. In _Advances in Neural Information Processing Systems_, 32, 2019.

13

<u>Elon Litman</u> <u>Equilibrium Propagation Without Limits</u>

[9] Andreas Engel and Christian Van den Broeck. _Statistical Mechanics of Learning_ .

Cambridge University Press, 2001.

[10] Maxence Ernoult, Julie Grollier, Damien Querlioz, Yoshua Bengio, and Ben
jamin Scellier. Updates of equilibrium propagation match gradients of backpropagation through time in an RNN with static input. In _Advances in Neural_
_Information Processing Systems_, 32, 2019.

[11] Karl Friston. The free-energy principle: a unified brain theory? _Nature_
_Reviews Neuroscience_, 11(2):127–138, 2010.

[12] Wulfram Gerstner and Werner M. Kistler. _Spiking_ _Neuron_ _Models:_ _Single_

_Neurons, Populations, Plasticity_ . Cambridge University Press, 2002.

[13] Stephen Grossberg. Competitive learning: From interactive activation to

adaptive resonance. _Cognitive Science_, 11(1):23–63, 1987.

[14] Kaiming He, Xiangyu Zhang, Shaoqing Ren, and Jian Sun. Deep residual

learning for image recognition. In _IEEE Conference on Computer Vision and_
_Pattern Recognition_, pages 770–778, 2016.

[15] Donald O. Hebb. _The Organization of Behavior: A Neuropsychological Theory_ .

Wiley, New York, 1949.

[16] Geoffrey E. Hinton. Training products of experts by minimizing contrastive

divergence. _Neural Computation_, 14(8):1771–1800, 2002.

[17] John J. Hopfield. Neural networks and physical systems with emergent col
lective computational abilities. _Proceedings of the National Academy of Sciences_,
79(8):2554–2558, 1982.

[18] Michael I. Jordan, Zoubin Ghahramani, Tommi S. Jaakkola, and Lawrence K.

Saul. An introduction to variational methods for graphical models. _Machine_
_Learning_, 37(2):183–233, 1999.

[19] Alex Krizhevsky, Ilya Sutskever, and Geoffrey E. Hinton. ImageNet classi
fication with deep convolutional neural networks. In _Advances_ _in_ _Neural_
_Information Processing Systems_, 25, 2012.

[20] Axel Laborieux, Maxence Ernoult, Benjamin Scellier, Yoshua Bengio, Julie

Grollier, and Damien Querlioz. Scaling equilibrium propagation to deep
convnets by drastically reducing its gradient estimator bias. _Frontiers_ _in_
_Neuroscience_, 15:633674, 2021.

14

<u>Elon Litman</u> <u>Equilibrium Propagation Without Limits</u>

[21] Yann LeCun, Sumit Chopra, Raia Hadsell, Marc’Aurelio Ranzato, and Fu-Jie

Huang. A tutorial on energy-based learning. In G. Bakir, T. Hofmann, B.
Schölkopf, A. J. Smola, and B. Taskar, editors, _Predicting Structured Data_ . MIT
Press, 2006.

[22] Yann LeCun, Yoshua Bengio, and Geoffrey Hinton. Deep learning. _Nature_,

521(7553):436–444, 2015.

[23] Dong-Hyun Lee, Saizheng Zhang, Asja Fischer, and Yoshua Bengio. Difference

target propagation. In _Machine Learning and Knowledge Discovery in Databases_,
pages 498–515. Springer, 2015.

[24] Timothy P. Lillicrap, Daniel Cownden, Douglas B. Tweed, and Colin J. Aker
man. Random synaptic feedback weights support error backpropagation for
deep learning. _Nature Communications_, 7:13276, 2016.

[25] Timothy P. Lillicrap, Adam Santoro, Luke Marris, Colin J. Akerman, and

Geoffrey Hinton. Backpropagation and the brain. _Nature Reviews Neuroscience_,
21(6):335–346, 2020.

[26] Marc Mézard, Giorgio Parisi, and Miguel A. Virasoro. _Spin Glass Theory and_

_Beyond_ . World Scientific, Singapore, 1987.

[27] Beren Millidge, Alexander Tschantz, and Christopher L. Buckley. Predictive

coding approximates backprop along arbitrary computation graphs. _arXiv_
_preprint arXiv:2006.04182_, 2020.

[28] Javier R. Movellan. Contrastive Hebbian learning in the continuous Hopfield

model. In D. S. Touretzky, J. L. Elman, T. J. Sejnowski, and G. E. Hinton,
editors, _Connectionist Models:_ _Proceedings of the 1990 Summer School_, pages
10–17. Morgan Kaufmann, San Mateo, CA, 1990.

[29] Hidetoshi Nishimori. _Statistical Physics of Spin Glasses and Information Process-_

_ing: An Introduction_ . Oxford University Press, 2001.

[30] Arild Nøkland. Direct feedback alignment provides learning in deep neural

networks. In _Advances in Neural Information Processing Systems_, 29, 2016.

[31] Peter O’Connor, Efstratios Gavves, and Max Welling. Training a spiking neural

network with equilibrium propagation. In _Proceedings of the 22nd International_
_Conference on Artificial Intelligence and Statistics_, pages 1516–1523, 2019.

15

<u>Elon Litman</u> <u>Equilibrium Propagation Without Limits</u>

[32] Randall C. O’Reilly. Biologically plausible error-driven learning using lo
cal activation differences: The generalized recirculation algorithm. _Neural_
_Computation_, 8(5):895–938, 1996.

[33] David E. Rumelhart, Geoffrey E. Hinton, and Ronald J. Williams. Learn
ing internal representations by error propagation. In D. E. Rumelhart and
J. L. McClelland, editors, _Parallel Distributed Processing:_ _Explorations in the_
_Microstructure of Cognition, Volume 1_, pages 318–362. MIT Press, 1986.

[34] Benjamin Scellier and Yoshua Bengio. Equilibrium propagation: Bridging

the gap between energy-based models and backpropagation. _Frontiers in_
_Computational Neuroscience_, 11:24, 2017.

[35] Benjamin Scellier, Anirudh Goyal, Jonathan Binas, Thomas Mesnard, and

Yoshua Bengio. Generalization of equilibrium propagation to vector field
dynamics. _arXiv preprint arXiv:1808.04873_, 2018.

[36] David Silver, Aja Huang, Chris J. Maddison, Arthur Guez, Laurent Sifre,

George van den Driessche, Julian Schrittwieser, and colleagues. Mastering the game of Go with deep neural networks and tree search. _Nature_,
529(7587):484–489, 2016.

[37] Naftali Tishby, Fernando C. Pereira, and William Bialek. The information

bottleneck method. _arXiv preprint physics/0004057_, 2000.

[38] Robert Urbanczik and Walter Senn. Learning by the dendritic prediction of

somatic spiking. _Neuron_, 81(3):521–528, 2014.

[39] Martin J. Wainwright and Michael I. Jordan. Graphical models, exponen
tial families, and variational inference. _Foundations and Trends in Machine_
_Learning_, 1(1–2):1–305, 2008.

[40] Paul J. Werbos. Beyond regression: New tools for prediction and analysis in

the behavioral sciences. PhD thesis, Harvard University, 1974.

[41] James C. R. Whittington and Rafal Bogacz. An approximation of the error

backpropagation algorithm in a predictive coding network with local hebbian
synaptic plasticity. _Neural Computation_, 29(5):1229–1262, 2017.

[42] James C. R. Whittington and Rafal Bogacz. Theories of error back-propagation

in the brain. _Trends in Cognitive Sciences_, 23(3):235–250, 2019.

16

<u>Elon Litman</u> <u>Equilibrium Propagation Without Limits</u>

[43] Xiaohui Xie and H. Sebastian Seung. Equivalence of backpropagation and

contrastive Hebbian learning in a layered network. _Neural_ _Computation_,
15(2):441–454, 2003.

17

<u>Elon Litman</u> <u>Equilibrium Propagation Without Limits</u>

**A** **LEIBNIZ INTEGRAL RULE**

The proofs in Section 3 rely on the ability to interchange the order of integration
and differentiation. This is justified by the Leibniz integral rule (or differentiation
under the integral sign). A general version states:

**Theorem A.1** (Leibniz Integral Rule) **.** _Let_ Ω _be an open set in_ R <sup>_𝑝_</sup> _, and let_ _𝑓_ ( _𝑠, 𝜃_ ) _be a_
_function defined on_ S × Ω _. Assume that for all 𝜃_ ∈ Ω _,_ _𝑓_ ( _𝑠, 𝜃_ ) _is an integrable function_
_of 𝑠. Assume that for almost every 𝑠_ ∈S _, the partial derivative_ _𝜕𝜃_ <sup>_𝜕𝑓_</sup> _𝑖_ <sup>_exists for all 𝜃_</sup> <sup>∈</sup> <sup>Ω</sup> <sup>_._</sup>

_If there exists an integrable function 𝑔_ ( _𝑠_ ) _such that for all 𝜃_ ∈ Ω _,_ | _𝜕𝜃_ <sup>_𝜕𝑓_</sup> _𝑖_ <sup>(</sup> <sup>_𝑠, 𝜃_</sup> <sup>)|</sup> <sup>≤</sup> <sup>_𝑔_</sup> <sup>(</sup> <sup>_𝑠_</sup> <sup>)</sup> <sup>_for_</sup>

_almost every 𝑠_ ∈S _, then for all 𝜃_ ∈ Ω _:_

_𝜕_

_𝜕𝜃𝑖_

∫

S

_𝑓_ ( _𝑠, 𝜃_ )d _𝑠_ =

∫

S

_𝜕𝑓_

_𝜕𝜃𝑖_

( _𝑠, 𝜃_ )d _𝑠._

In our context, _𝑓_ ( _𝑠, 𝜃_ ) is the Gibbs factor exp(− _𝐹_ / _𝑇_ ), and Assumption 2.3 requires that its derivative with respect to _𝜃𝑖_ is dominated by a function _𝑔_ ( _𝑠_ ) that
is integrable over S. This is satisfied by a wide range of well-behaved energy
functions used in practice.

18
