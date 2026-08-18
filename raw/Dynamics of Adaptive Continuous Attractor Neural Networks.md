---
title: "Dynamics of Adaptive Continuous Attractor Neural Networks"
source: "https://arxiv.org/html/2410.06517v1"
author:
published:
created: 2026-06-21
description:
tags:
  - "clippings"
---
###### Abstract

Attractor neural networks consider that neural information is stored as stationary states of a dynamical system formed by a large number of interconnected neurons. The attractor property empowers a neural system to encode information robustly, but it also incurs the difficulty of rapid update of network states, which can impair information update and search in the brain. To overcome this difficulty, a solution is to include adaptation in the attractor network dynamics, whereby the adaptation serves as a slow negative feedback mechanism to destabilize which are otherwise permanently stable states. In such a way, the neural system can, on one hand, represent information reliably using attractor states, and on the other hand, perform computations wherever rapid state updating is involved. Previous studies have shown that continuous attractor neural networks with adaptation (A-CANNs) exhibits rich dynamical behaviors accounting for various brain functions. In this paper, we present a comprehensive review of the rich diverse dynamics of A-CANNs. Moreover, we provide a unified mathematical framework to understand these different dynamical behaviors, and briefly discuss about their biological implications.

Yujun Li <sup>1</sup>, Tianhao Chu <sup>3</sup>, Si Wu <sup>2,3</sup>  
<sup>1</sup> Yuanpei College, Peking University, China  
<sup>2</sup> School of Psychological and Cognitive Sciences,Peking University, China  
<sup>3</sup> Academy for Advanced Interdisciplinary Studies, Peking University, China

Keywords: CANN, neural adaptation, neural dynamics

## 1 Introduction

Attractor networks are a class of neural network models which consider that neural information is encoded as stationary states of a dynamical system formed by a large number of interconnected neurons. An early influential attractor network model is the Hopfield network [^1], which considers that representations of information (neuronal activity patterns) are stored as local minimums of an energy function of the network dynamics. The Hopfield model typically considers that the stored information representations are random patterns, which leads to discrete attractors in the state space (see Fig.1a). These discrete attractors ensure that once the initial state of the network falls into the basin of an attractor, the network state will robustly converge to it, achieving the so-called associative memory.

Although the Hopfield model can explain associative memory for independent information representations, it falls to account for situations when representations are highly correlated or the information takes continuous values. In such a case, a new type of attractor network model called continuous attractor neural networks (CANNs) was developed [^2] [^3] [^4], in which the network attractors form a continuous subspace to represent the stored information in a continuous manner (see Fig.1b), such as the orientation, head-direction, or spatial-location of an object [^5] [^6] [^7]. A key property of a CANN is that the network is neutrally stable on the attractor space, which allows the neural system to track the movement of an object smoothly by updating the corresponding neural representations continuously, such as for tracking head rotation or performing path integration [^8] [^9].

![Refer to caption](https://arxiv.org/html/2410.06517v1/x1.png)

Figure 1: Discrete and continuous attractor network model. a. An illustration of discrete concept and discrete attractors. Each attractor represents a single concept or item, such as dog, cat and bird. b. An illustration of continuous feature and continuous attractor. Head direction cells represent the continuous angular orientations of the rodent’s head movement during exploration in a new environment. The stationary states of a CANN form a subspace in which the network states are neutrally stable. The subspace is illustrated as a canyon in the energy space. The movement of the network state along the canyon corresponds to the position shift of the bump.

Strictly speaking, both the Hopfield network and CANNs are idealised mathematical models, which correspond to two extreme situations, respectively, i.e., when neural information representations are independent to each other or constitute a continuous spectrum. In reality, neural representations may have a correlation structure in between the two ends, and consequently, the structure of the attractor space of the neural network has a form in between those of the Hopfield network and CANNs. Nevertheless, through studying the simplified Hopfield network and CANNs, it gives us insight into understanding how general attractor networks contribute to brain functions.

The key property of an attractor network is that it holds information representations as stationary states of the network, which endows the neural system with the capacity of representing information reliably and retrieving information robustly. In practice, however, the neural system needs not only to represent information reliably, but also to process it efficiently. For instance, during a memory recall task, the neural system often needs to search memory candidates over a large state space by updating its current state rapidly. This requires the neural representation to have sufficient mobility, which seems to contradict with the demand of maintaining stability of information representation. To overcome this dilemma, a solution is to introduce an additional mechanism to destabilize attractors to increase the mobility of the network state, and such a mechanism can be neural adaptation.

Neural adaptation refers to a general phenomenon that a neural system exploits negative feedback to suppress its responses when the activity level is high. Neural adaptation can occur either at the single neuron level via spike frequency adaptation (SFA) [^4] [^10] or at the synapse level via short-term plasticity (STP) [^11] [^12] [^13], both widely existing in neural systems. The time scale of neural adaptation is typically much slower than that of single neuron and synapse dynamics. Thus, by incorporating adaptation in an attractor network, it, on one hand, allows the network to hold an active state in a short time scale to encode information reliably, and on the other hand, enables the network to update states in a long time scale easily.

In previous works, the authors and their collaborates have studied the model of CANNs with adaptation [^14] [^15], referred to as adaptive CANNs (A-CANNs) hereafter. They showed that an A-CANN exhibits rich dynamical behaviors not shared by a CANN without adaptation, and these rich dynamics contribute to various brain functions. In this paper, we provide a comprehensive review of these studies. In particular, we present new theoretical analyses which link the different dynamical behaviors reported in previous publications, and hence provide a unified mathematical framework to understand these different results. Limited by space, our focus is on presenting the mathematical analyses of the rich dynamics of A-CANNs, and their biological implications are only briefly discussed.

The organization of the paper is as follows. In Sec.2, we first introduce a model of A-CANN which adopts SFA as the adaptation mechanism, and then present a projection method to simplify the dynamics of the A-CANN, which is crucial for theoretical analysis. In Sec.3, we study the spontaneous dynamics of the A-CANN, including the static bump state when the adaptation is weak and the travelling wave state when the adaptation strength is large enough. In Sec.4, we study the tracking dynamics of the A-CANN when the network receives an external moving input. We show that depending on the relative strengths of adaptation and external input, the network exhibits three different states, which are smoothing tracking, oscillatory tracking, and travelling wave. The biological implications of these states are discussed. In Sec.5, we study the stochastic dynamics of the A-CANN when the adaptation is noisy. We show that when the noisy adaptation strength is around the boundary of travelling wave, the spontaneous dynamics of the network state exhibits the characteristic of Lévy flight. In Sec.6, overall conclusions and discussions of this work are given. Finally, Appendixes present the detailed mathematical analyses of the network model.

## 2 Adaptive Continuous Attractor Neural Networks

![Refer to caption](https://arxiv.org/html/2410.06517v1/x2.png)

Figure 2: An adaptive continuous attractor neural network (A-CANN) model. a. An illustration of the structure of an one-dimensional A-CANN. Neurons are uniformly distributed in the feature space x ∈ ( − ∞, + ) 𝑥 x\\in(-\\infty,+\\infty) italic\_x ∈ ( - ∞, + ∞ ) to encode a continuous variable (e.g. orientation or direction). Neurons are connected with each other recurrently with weights J ⁢ ′ 𝐽 superscript J(x,x^{\\prime}) italic\_J ( italic\_x, italic\_x start\_POSTSUPERSCRIPT ′ end\_POSTSUPERSCRIPT ), and they receive the adaptation current V t 𝑉 𝑡 V(x,t) italic\_V ( italic\_x, italic\_t ) and the external input I e 𝐼 𝑒 I^{ext}(x,t) italic\_I start\_POSTSUPERSCRIPT italic\_e italic\_x italic\_t end\_POSTSUPERSCRIPT ( italic\_x, italic\_t ). b. An illustration of the dynamics of a single neuron in the A-CANN. c. An illustration of the first two motion modes of a CANN. An arbitrary network state (red curve) can be approximated as the superposition of a steady bump state and the distortions in the bump shape including the height ( v 0 subscript 𝑣 v\_{0} italic\_v start\_POSTSUBSCRIPT 0 end\_POSTSUBSCRIPT ), position( 1 v\_{1} italic\_v start\_POSTSUBSCRIPT 1 end\_POSTSUBSCRIPT ), and so on.

### 2.1 An A-CANN model

We begin with a one-dimensional A-CANN, where neurons are distributed uniformly in a feature space denoted by $x$, with $x$ ranging over the entire real line $(-\infty,\infty)$ (see Fig. 2a), and neurons are interconnected recurrently. Let $U(x,t)$ be the synaptic input that a neuron at $x$ receives at time $t$, and $r(x,t)$ the corresponding firing rate. The network’s dynamics is described as follows:

$$
\displaystyle\tau\frac{dU(x,t)}{dt}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle-U(x,t)+\rho\int_{-\infty}^{\infty}J(x,x^{\prime})r(x^{\prime},t)%
\,dx^{\prime}-V(x,t)+I^{ext}(x,t),
$$
$$
\displaystyle r(x,t)
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\frac{U(x,t)^{2}}{1+k\rho\int_{-\infty}^{\infty}U^{2}(x^{\prime},%
t),dx^{\prime}},
$$

where $\tau$ is the time constant of $U(x,t)$ and $\rho$ the neuron density. The connection strength between neurons at $x$ and $x^{\prime}$ is denoted as $J(x,x^{\prime})$, which takes the Gaussian form $J(x,x^{\prime})=J_{0}/(\sqrt{2\pi}a)\exp[-(x-x^{\prime})^{2}/(2a^{2})]$, with $J_{0}$ controlling the maximum connection strength and $a$ the range of neuronal interactions. The parameter $k$ in Eq. (2) controls the amplitude of divisive normalization, which reflects the contribution of inhibitory neurons not explicitly represented in the model. In real biological systems, divisive normalization can be realized via shunting inhibition of inhibitory neurons [^16]. It is noteworthy that the neuronal connection profile is translation-invariant in the feature space, i.e., $J(x,x^{\prime})$ is a function of difference $(x-x^{\prime})$. This is the key structure of a CANN. $I^{ext}(x,t)$ denotes the external input to the network.

What distinguishes an A-CANN from a conventional CANN is the term $-V(x,t)$ on the right hand-side of Eq. (1). It represents the adaptation current and can be bio-physically traced back to the effect of spike frequency adaptation (SFA) in neuronal dynamics. Although we adopts SFA as the adaptation mechanism in this work, others such as short-term synaptic depression (STD) can also serve as the mechanism. The dynamics of the adaptation is written as (see the illustration in Fig. 2b),

$$
\tau_{v}\frac{dV(x,t)}{dt}=-V(x,t)+mU(x,t),
$$

where $\tau_{v}$ is the time constant of $V(x,t)$ and $\tau_{v}\gg\tau$ holds, implying that the adaptation effect caused by neuronal activity is delayed. The parameter $m$ controls the strength of SFA, i.e., the larger the value of $m$ is, the stronger the adaptation effect.

### 2.2 The simplified dynamics of the A-CANN

We introduce how to use a projection method to simplify the dynamics of the A-CANN, which enables us to further carry out theoretical analysis. Previous studies have shown that because of the localized and translation-invariant recurrent connections, the state of the CANN can be largely approximated as of the Gaussian shape, known as the bump state [^17] [^15] (see illustration in Fig. 2c). The bumps are expressed as

$$
\displaystyle U_{0}(x,t)
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle A_{u}\exp\left\{-\frac{\left[x-z(t)\right]^{2}}{4a^{2}}\right\},
$$
$$
\displaystyle V_{0}(x,t)
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle A_{v}\exp\left\{-\frac{\left[x-z(t)+s_{v}(t)\right]^{2}}{4a^{2}}%
\right\},
$$
$$
\displaystyle r_{0}(x,t)
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle A_{r}\exp\left\{-\frac{\left[x-z(t)\right]^{2}}{2a^{2}}\right\},
$$

where $z(t)$ denotes the bump position, and $A_{u}$, $A_{v}$, and $A_{r}$ denote the heights of bumps $U_{0}(x,t),V_{0}(x,t)$, and $r_{0}(x,t)$, respectively. $s_{v}(t)$ represents the discrepancy between the neural activity bump $U(x,t)$ and the adaptation current $V(x,t)$.

The efficacy of the seemingly over-idealistic Gaussian-shaped state comes from that even the bump state is disturbed by noises, the attractor dynamics of the network will rapidly clean out those distortions perpendicular to the attractor space, thereby maintaining the Gaussian-shaped neural activities [^18] [^17]. Therefore, in below analyses, we assume that Eqs. (4-6) hold when the external input $I^{ext}(x,t)$ or the adaptation current $V(x,t)$ is small.

Substituting Eqs. (4-6) into Eqs. (1-3), we have (see Appendix A),

$$
\displaystyle A_{r}
$$
 
$$
\displaystyle=\frac{A_{u}^{2}}{1+k\rho\sqrt{2\pi}aA_{u}^{2}},
$$
$$
\displaystyle\tau\left[A_{u}\frac{x-z}{2a^{2}}\frac{dz}{dt}+\frac{dA_{u}}{dt}%
\right]\mathcal{N}(z,2a)
$$
 
$$
\displaystyle=(-A_{u}+\frac{\rho J_{0}}{\sqrt{2}}A_{r})\mathcal{N}(z,2a)
$$
 
$$
\displaystyle-A_{v}\mathcal{N}(z-s_{v},2a)
$$
 
$$
\displaystyle+I^{ext}(x,t),
$$
$$
\displaystyle\tau_{v}\left[A_{v}\frac{x-z+s_{v}}{2a^{2}}\frac{d(z-s_{v})}{dt}+%
\frac{dA_{v}}{dt}\right]\mathcal{N}(z-s_{v},2a)
$$
 
$$
\displaystyle=-A_{v}\mathcal{N}(z-s_{v},2a)
$$
 
$$
\displaystyle+mA_{u}\mathcal{N}(z,2a),
$$

where $\mathcal{N}(\mu,\sigma)$ denotes the Gaussian function, $\mathcal{N}(z,\sigma)=\exp\left[-\left(x-z\right)^{2}/2\sigma^{2}\right]$. At first glance, Eqs. (8-9) may appear to be intractable due to the high dimensionality ($2N$, with $N$ the number of neurons). However, a key property of CANNs is that their dynamics are dominated by a few motion modes, which correspond to the distortions of the bump in height, position, width, etc. (see Fig.2d) [^17]. Therefore, by projecting the network dynamics onto these dominant motion modes, we can significantly simplify the network dynamics [^17]. Typically, projecting onto the first two motion modes is sufficient to capture the main features of the network dynamics.

For the bump $U(x,t)$, the first two motion modes are,

$$
\displaystyle u_{0}(x,t)
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\exp\left\{-\frac{[x-z(t)]^{2}}{4a^{2}}\right\},
$$
$$
\displaystyle u_{1}(x,t)
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\left[x-z(t)\right]\exp\left\{-\frac{[x-z(t)]^{2}}{4a^{2}}\right\}.
$$

For the bump $V(x,t)$, the first two motion modes are,

$$
\displaystyle v_{0}(x,t)
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\exp\left\{-\frac{[x-z(t)+d(t)]^{2}}{4a^{2}}\right\},
$$
$$
\displaystyle v_{1}(x,t)
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\left[x-z(t)+d(t)\right]\exp\left\{-\frac{[x-z(t)+d(t)]^{2}}{4a^{%
2}}\right\}.
$$

Projecting Eqs. (8-9) onto the first two dominant motion modes, we obtain (see Appendix B),

$$
\displaystyle\tau\frac{dA_{u}}{dt}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle(-A_{u}+\frac{\rho J_{0}}{\sqrt{2}}A_{r})-A_{v}\exp\left(-\frac{s%
_{v}(t)^{2}}{8a^{2}}\right)+\int_{x}I^{ext}(x,t)u_{0}(x)dx,
$$
$$
\displaystyle\tau A_{u}\frac{dz}{dt}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle s_{v}(t)A_{v}\exp\left(-\frac{s_{v}(t)^{2}}{8a^{2}}\right)+\int_%
{x}I^{ext}(x,t)u_{1}(x)dx,
$$
$$
\displaystyle\tau_{v}\frac{dA_{v}}{dt}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle-A_{v}+mA_{u}\exp\left(-\frac{s_{v}(t)^{2}}{8a^{2}}\right),
$$
$$
\displaystyle\tau_{v}A_{v}\frac{ds_{v}}{dt}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle s_{v}(t)\exp\left(-\frac{s_{v}(t)^{2}}{8a^{2}}\right)\left(\frac%
{\tau_{v}}{\tau A_{u}}A_{v}^{2}-mA_{u}\right)+\frac{\tau_{v}A_{v}}{\tau A_{u}}%
\int_{x}I^{ext}(x,t)u_{1}(x)dx.
$$

The dimension of the A-CANN dynamics is now reduced to four. In the following sections, we will use these simplified equations to study the dynamics of A-CANN.

## 3 Spontaneous Dynamics of the A-CANN

In this section, we study the spontaneous dynamics of the A-CANN. By spontaneous dynamics, it refers to the dynamical behaviors of the A-CANN without the drive of external input.

The spontaneous/intrinsic dynamics of neural circuits has gained increasing attention in the field due to its important contributions to information processing in the brain. For instance, the spontaneous activity patterns observed in the developing visual system have been found to play a crucial role in the refinement of neural connections and the establishment of functional circuits [^19] [^20]. Similarly, ongoing oscillations in the brain have been linked to important cognitive processes such as attention, perception, and memory [^21]. An appealing substrate for these oscillations is the spontaneous hippocampal replay referring to the reactivation and replay of neural activity patterns in the hippocampus. It occurs during the rest or sleep period (offline) and involves sequential reactivation of specific neurons or groups of neurons that were active during previous awake experiences. It is suggested that the hippocampal replay plays a crucial role in memory consolidation and spatial navigation, as it supports the strengthening and integration of newly acquired experiences [^22] [^23]. Through replay, most heavy computations of constructing representation space take place offline, thus the computational burden is reduced in online behaviors.

Moreover, the study of spontaneous activity is crucial in understanding neurological and psychiatric disorders, as abnormal patterns of intrinsic activity have been observed in conditions like epilepsy, schizophrenia, and autism spectrum disorders [^24] [^25]. Analyzing these spontaneous dynamics can provide valuable insights into the underlying neural mechanisms of such disorders and aid in developing potential therapeutic strategies.

### 3.1 Static bump state

We first study the condition when the A-CANN holds static bumps as its stationary states. When no external input exists, the network dynamics given by Eqs. (14-LABEL:project\_V1\_) are further simplified to be,

$$
\displaystyle\frac{dA_{u}}{dt}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\frac{1}{\tau}\left(-A_{u}+\frac{\rho J_{0}}{\sqrt{2}}A_{r}-A_{v}%
\right),
$$
$$
\displaystyle\frac{dz}{dt}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\frac{s_{v}(t)A_{v}}{\tau A_{u}},
$$
$$
\displaystyle\frac{dA_{v}}{dt}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\frac{1}{\tau_{v}}\left(-A_{v}+mA_{u}\right),
$$
$$
\displaystyle\frac{ds_{v}(t)}{dt}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle s_{v}(t)\left(\frac{A_{v}}{\tau A_{u}}-\frac{mA_{u}}{\tau_{v}A_{%
v}}\right).
$$

In the above, we have applied the condition $s_{v}(t)<<a$ which gives $\exp\left[-s_{v}(t)^{2}/8a^{2}\right]\approx 1$. This approximation holds well in practice.

In the static bump state, the bump center remains stationary, i.e., $dz/dt=0$, $s_{v}(t)=0$, and bump heights are constant, i.e., $dA_{u}/dt=dA_{v}/dt=dA_{r}/dt=0$. Substituting these constraints into Eqs.(18-21), we have,

$$
\displaystyle(-A_{u}+\frac{\rho J_{0}}{\sqrt{2}}A_{r})-A_{v}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle 0,
$$
$$
\displaystyle-A_{v}+mA_{u}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle 0.
$$

Combining with Eq. (7), we obtain,

$$
\displaystyle A_{u}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\frac{\rho J_{0}+\sqrt{\rho^{2}J_{0}^{2}-8\sqrt{2\pi}(1+m)^{2}k%
\rho a}}{4\sqrt{\pi}(1+m)k\rho a}.
$$
$$
\displaystyle A_{v}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle mA_{u},
$$
$$
\displaystyle A_{r}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\frac{\sqrt{2}(1+m)}{\rho J_{0}}A_{u}.
$$

Thus, the static bump state is solved. To verify the theoretical result, we conducted simulations of the original network dynamics. Eq. (24) predicts that increasing the global inhibition $k$ decreases the the height of the neural activity bump $A_{u}$. Fig. 3a shows that our theoretical analysis agrees very well with the simulation.

We proceed to analyze the stability of the static bump state by examining how the global inhibition strength $k$ and adaptation strength $m$ impact the bump state. A widely used and powerful tool in computational neuroscience for studying the dynamics of complex systems is Jacobian matrix, which provides valuable information about the local behavior of a system at certain point in phase space. By analyzing the eigenvalues of Jacobian matrix, we can determine the stability of the state and classify it as a fixed point, a limit cycle, or a chaotic attractor. The signs of the eigenvalues reveal the motion tendency of the system under small perturbations, indicating whether they will cause the system to return to its steady-state or diverge from it. Specifically, we calculate the eigenvalues of the matrix derived from Eqs.(18 - 21). The Jacobian matrix is calculated to be:

$$
\textbf{M}=\left(\begin{array}[]{cccc}\frac{1}{\tau}\left(-1+\frac{\sqrt{2}%
\rho J_{0}A_{u}}{(1+\sqrt{2\pi}k\rho aA_{u}^{2})^{2}}\right)&-\frac{1}{\tau}&0%
&0\\
\frac{m}{\tau_{v}}&-\frac{1}{\tau_{v}}&0&0\\
-\frac{s_{v}(t)A_{v}}{\tau A_{u}^{2}}&\frac{s_{v}(t)}{\tau A_{u}}&0&\frac{A_{v%
}}{\tau A_{u}}\\
-\frac{s_{v}(t)A_{v}}{\tau A_{u}^{2}}&\frac{s_{v}(t)}{\tau A_{u}}&0&\left(%
\frac{A_{v}}{\tau A_{u}}-\frac{mA_{u}}{\tau_{v}A_{v}}\right)\\
\end{array}\right).
$$

Considering the condition $s_{v}(t)\approx 0$ near the steady state, we observe that the matrix becomes block-diagonal, where the dynamics of $A_{u}(t)$ and $A_{v}(t)$ are completely independent of the dynamics of $z(t)$ and $s_{v}(t)$. Therefore, we can simplify the calculation by separating the 4-rank matrix into two smaller 2-rank matrices.

First, we focus on the 2-rank Jacobian matrix of the dynamics of $A_{u}(t)$ and $A_{v}(t)$, which yields:

$$
\textbf{M}_{1}=\left(\begin{array}[]{cc}\frac{1}{\tau}\left(-1+\frac{\sqrt{2}%
\rho J_{0}A_{u}}{(1+\sqrt{2\pi}k\rho aA_{u}^{2})^{2}}\right)&-\frac{1}{\tau}\\
\frac{m}{\tau_{v}}&-\frac{1}{\tau_{v}}\\
\end{array}\right).
$$

Denote the eigenvalues of the Jacobian matrix as $\lambda_{1}$ and $\lambda_{2}$. For the solution to be stable, both eigenvalues need to be negative, which require that,

$$
\displaystyle\lambda_{1}+\lambda_{2}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\frac{1}{2}\left[-1+\frac{\sqrt{2}A_{u}J_{0}\rho}{(1+\sqrt{2\pi}k%
\rho aA_{u}^{2})^{2}}-\frac{\tau}{\tau_{v}}\right]<0,
$$
$$
\displaystyle\lambda_{1}\lambda_{2}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\frac{\tau}{\tau_{v}}\left(m+1-\frac{\sqrt{2}A_{u}J_{0}\rho}{(1+%
\sqrt{2\pi}k\rho aA_{u}^{2})^{2}}\right)\geq 0.
$$

The above inequalities are satisfied when,

$$
\displaystyle 0<k<k_{c1}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\frac{\rho J_{0}^{2}(1+\frac{\tau}{\tau_{v}})(1+2m-\frac{\tau}{%
\tau_{v}})}{8\sqrt{2\pi}a(1+m)^{4}},
$$
$$
\displaystyle 0<k<k_{c2}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\frac{\rho J_{0}^{2}}{8\sqrt{2\pi}a(1+m)^{2}}.
$$

It is easy to check that $k_{c2}<k_{c1}$. Thus, the first condition for the network to hold static bumps as its steady state is $0<k<k_{c2}$.

Second, we study the 2-rank Jacobian matrix of the the dynamics of $z(t)$ and $s_{v}(t)$, which gives,

$$
\textbf{M}_{2}=\left(\begin{array}[]{cc}0&\frac{m}{\tau}\\
0&\frac{m}{\tau}-\frac{1}{\tau_{v}}\end{array}\right).
$$

It’s easy to check that the eigenvalues are $\lambda_{1}=0,\lambda_{2}=m-\tau/\tau_{v}$. Thus, the second condition for the static bump state to be stable is $m<\tau/\tau_{v}$.

In summary, the parametric conditions for the A-CANN holding a static bump as its stationary state without relying on external input are that both the inhibition and adaptation need to be sufficiently small, satisfying $0<k<k_{c2}$ and $m<\tau/\tau_{v}$. These agree with our intuition, as too strong inhibition will suppress neuronal activities and too large adaptation will destabilize the static bump (see below).

### 3.2 Traveling wave state

The above analysis reveals that for the A-CANN holding static bump states, it requires the adaptation strength $m<\tau/\tau_{v}$. If $m>\tau/\tau_{v}$, the strong adaptation will destabilize the bump, causing the bump to move spontaneously in the feature space (illustrated in Fig.3b). This is called the traveling wave state [^4] [^14] [^26] [^27]. In this section, we study the condition for the A-CANN holding the traveling wave state.

Let us denote the speed of travelling wave to be $v_{int}$, which is also called the intrinsic speed of the A-CANN, as its value only depends on the network parameters. Without loss of generality, the bump center can be expressed as $z(t)=v_{int}t$. At the travelling wave state, the bump heights remain invariant, i.e., $dA_{u}/dt=dA_{v}/dt=0$. The network dynamics Eqs. (14-LABEL:project\_V1\_) are simplified to be,

$$
\displaystyle A_{u}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\frac{\rho J_{0}}{\sqrt{2}}A_{r}-A_{v}\exp\left(-\frac{s_{v}(t)^{%
2}}{8a^{2}}\right),
$$
$$
\displaystyle\tau A_{u}v_{int}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle s_{v}(t)A_{v}\exp\left(-\frac{s_{v}(t)^{2}}{8a^{2}}\right),
$$
$$
\displaystyle A_{v}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle mA_{u}\exp\left(-\frac{s_{v}(t)^{2}}{8a^{2}}\right),
$$
$$
\displaystyle\tau_{v}A_{v}\frac{ds_{v}(t)}{dt}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle s_{v}(t)\exp\left(-\frac{s_{v}(t)^{2}}{8a^{2}}\right)\left(\frac%
{\tau_{v}}{\tau A_{u}}A_{v}^{2}-mA_{u}\right).
$$

Combining the above equations with Eq. (7), we can analytically solve the travelling wave state, which are given by (Appendix C):

$$
\displaystyle A_{u}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\frac{\rho J_{0}+\sqrt{\rho^{2}J_{0}^{2}-8\sqrt{2\pi}k\rho a(1+%
\sqrt{\frac{m\tau}{\tau_{v}}})^{2}}}{4\sqrt{\pi}k\rho a(1+\sqrt{\frac{m\tau}{%
\tau_{v}}})},
$$
$$
\displaystyle A_{v}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\frac{\rho J_{0}+\sqrt{\rho^{2}J_{0}^{2}-8\sqrt{2\pi}k\rho a(1+%
\sqrt{\frac{m\tau}{\tau_{v}}})^{2}}}{2\sqrt{2\pi}k\rho^{2}aJ_{0}},
$$
$$
\displaystyle A_{r}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\sqrt{\frac{m\tau}{\tau_{v}}}\exp\left[\frac{1-\sqrt{\frac{\tau}{%
m\tau_{v}}}}{2}\right]\frac{\rho J_{0}+\sqrt{\rho^{2}J_{0}^{2}-8\sqrt{2\pi}k%
\rho a(1+\sqrt{\frac{m\tau}{\tau_{v}}})^{2}}}{4\sqrt{\pi}k\rho a(1+\sqrt{\frac%
{m\tau}{\tau_{v}}})},
$$
$$
\displaystyle s_{v}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle 2a\sqrt{1-\sqrt{\frac{\tau}{m\tau_{v}}}},
$$
$$
\displaystyle v_{int}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\frac{2a}{\tau_{v}}\sqrt{\frac{m\tau_{v}}{\tau}-\sqrt{\frac{m\tau%
_{v}}{\tau}}}.
$$

Thus, the travelling wave speed is given by $v_{int}=a/\tau_{v}\sqrt{m\tau_{v}/\tau-\sqrt{m\tau_{v}/\tau}}$, and the lag of the adaptation current to the bump center $s_{v}$ remain a constant. Fig. 3c confirms that theoretical prediction of the intrinsic speed $v_{int}$ agrees well with the simulation result. From Eq. (42), we also observe that for the traveling wave speed $v_{int}$ to take a real value, it requires,

$$
m>\frac{\tau}{\tau_{v}},
$$

which is consistent with the stability analysis in the previous section. Combining Eqs. (32,43), we can draw the phase diagram of the spontaneous states of the A-CANN, which is depicted in Fig.3d.

#### 3.2.1 Biological implications of travelling wave

Spontaneous propagation of neural activity has been widely observed in both in vitro and in vivo experiments conducted on the cortex [^28] [^29] and sub-cortical areas like hippocampus [^30] [^31]. Here, our model suggests a mechanism to generate these spontaneous activities as a consequence of neural adaptation. Consider a bump emerges randomly at a location in the attractor space due to noises. Because of the adaptation, those neurons around the bump position (i.e., those most active neurons) receive the strongest suppression, which destabilizes the bump at the current location. Aided by recurrent interactions between neurons, the bump moves away to the neighborhood, where the adaptation starts to destabilize the bump at the new location again. Consequently, the bump keeps moving in the attractor space, and the network exhibits the travelling wave behavior.

The traveling wave behavior may play important roles in neural information processing. Intuitively, it enables a neural system to progressively visit all stationary states, and hence endows the neural system with the capacity of actively retrieving all stored memories. This could support cognitive functions where memory search and memory consolidation are involved [^23]. Tracing computational roles of traveling wave could be a fascinating avenue for future research.

![Refer to caption](https://arxiv.org/html/2410.06517v1/x3.png)

Figure 3: The spontaneous dynamics of the A-CANN. a. The bump height A u subscript 𝐴 𝑢 A\_{u} italic\_A start\_POSTSUBSCRIPT italic\_u end\_POSTSUBSCRIPT vs. the global inhibition strength k 𝑘 italic\_k. b. An illustration of the travelling wave state of the A-CANN. The bumps U 𝑈 italic\_U (red) and V 𝑉 italic\_V (blue) moves spontaneously with the speed v i ⁢ n t 𝑣 𝑖 𝑛 𝑡 v\_{int} italic\_v start\_POSTSUBSCRIPT italic\_i italic\_n italic\_t end\_POSTSUBSCRIPT, and the discrepancy between their centers is s 𝑠 italic\_s c. As the adaptation strength m 𝑚 italic\_m increases across a threshold 0 = τ / 𝜏 m\_{0}=\\tau/\\tau\_{v} italic\_m start\_POSTSUBSCRIPT 0 end\_POSTSUBSCRIPT = italic\_τ / italic\_τ start\_POSTSUBSCRIPT italic\_v end\_POSTSUBSCRIPT, the steady state of the A-CANN changes from static bump ( v\_{int}=0 italic\_v start\_POSTSUBSCRIPT italic\_i italic\_n italic\_t end\_POSTSUBSCRIPT = 0 ) to travelling wave ( > v\_{int}>0 italic\_v start\_POSTSUBSCRIPT italic\_i italic\_n italic\_t end\_POSTSUBSCRIPT > 0 ). d. The phase diagram of spontaneous states of the A-CANN. Parameters are: 0.4 𝑎 a=0.4 italic\_a = 0.4, J 1 𝐽 J\_{0}=1 italic\_J start\_POSTSUBSCRIPT 0 end\_POSTSUBSCRIPT = 1 0.76 k=0.76 italic\_k = 0.76 3 \\tau=3ms italic\_τ = 3 italic\_m italic\_s 152 \\tau\_{v}=152ms italic\_τ start\_POSTSUBSCRIPT italic\_v end\_POSTSUBSCRIPT = 152 italic\_m italic\_s ρ 128 ( 2 π ) 𝜌 𝜋 \\rho=128/(2\\pi) italic\_ρ = 128 / ( 2 italic\_π ) 0.3 m=0.3 italic\_m = 0.3 α 0.2 𝛼 \\alpha=0.2 italic\_α = 0.2 e x 0.5 𝑒 𝑥 v\_{ext}=0.5/s italic\_v start\_POSTSUBSCRIPT italic\_e italic\_x italic\_t end\_POSTSUBSCRIPT = 0.5 / italic\_s

## 4 Tracking Dynamics of the A-CANN

In the above, we have studied the spontaneous dynamics of the A-CANN in the absence of external inputs. In this section, we further study the tracking dynamics of the A-CANN when an external moving input is presented. When no adaptation exists, the continuous manifold of attractor states enables a conventional CANN to track a moving input smoothly with a constant delay [^17] [^18] [^32]. When adaptation is included, it induces rich tracking behaviors of the network [^14] [^33].

Without loss of generality, we consider the external moving input taking the below form,

$$
I^{ext}(x,t)=\alpha\exp\left[-\frac{(x-v_{ext}t)^{2}}{4a^{2}}\right],
$$

where $v_{ext}$ is the speed of the external input and $\alpha$ controls the strength of the input.

For the convenience of analysis, we assume that the bump heights remain constants during the tracking process, i.e., $dA_{u}/dt=0,dA_{v}/dt=0,dA_{r}/dt=0$ (this assumption is not always feasible as in the case of oscillatory tracking, nevertheless, it gives good approximation results). Substituting Eq. (44) and constant amplitude assumption into the network dynamics Eqs. (14-LABEL:project\_V1\_), we obtain the simplified tracking dynamics, which are:

$$
\displaystyle A_{u}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\frac{\rho J_{0}}{\sqrt{2}}A_{r}+\alpha\exp\left(-\frac{s_{u}(t)^%
{2}}{8a^{2}}\right)-A_{v}\exp\left(-\frac{s_{v}(t)^{2}}{8a^{2}}\right),
$$
$$
\displaystyle A_{v}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle mA_{u}\exp\left(-\frac{s_{v}(t)^{2}}{8a^{2}}\right),
$$
$$
\displaystyle\frac{ds_{u}(t)}{dt}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\frac{A_{v}}{\tau A_{u}}s_{v}(t)\exp\left(-\frac{s_{v}(t)^{2}}{8a%
^{2}}\right)-\frac{\alpha}{\tau A_{u}}s_{u}(t)\exp\left(-\frac{s_{u}(t)^{2}}{8%
a^{2}}\right)-v_{ext},
$$
$$
\displaystyle\frac{ds_{v}(t)}{dt}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\left(\frac{A_{v}}{\tau A_{u}}-\frac{mA_{u}}{\tau_{v}A_{v}}\right%
)s_{v}(t)\exp\left(-\frac{s_{v}(t)^{2}}{8a^{2}}\right)-\frac{\alpha}{\tau A_{u%
}}s_{u}(t)\exp\left(-\frac{s_{u}(t)^{2}}{8a^{2}}\right),
$$

where $s_{u}(t)$ denotes the discrepancy between the neural activity and the external input bumps, i.e., $s_{u}(t)=z(t)-v_{ext}t$.

In the blow study, we focus on the case that the speed of the external input complies with the condition $v_{ext}\ll a/\tau_{v}$. This is the biologically relevant regime in practice. For instance, if to model head rotation with biologically plausible parameters such as $\tau_{v}=100ms$ and $a=50^{\circ}$, $v_{ext}=0.1a/\tau_{v}$ corresponds to a speed of $500^{\circ}/s$, which is quite fast for head rotation of rodents. Furthermore, we take the approximations $\exp(-s_{v}^{2}/8a^{2})\approx 1$ and $\exp(-s_{u}^{2}/8a^{2})\approx 1$, as they always hold in practice. From Eqs. (45-46), we have

$$
(m+1)A_{u}-\frac{\rho J_{0}}{\sqrt{2}}\frac{A_{u}^{2}}{1+\sqrt{2\pi}ak\rho A_{%
u}^{2}}-\alpha=0.
$$

Eq. (49) can be rearranged into a general cubic equation of $A_{u}$, which is written as,

$$
a_{3}A_{u}^{3}+a_{2}A_{u}^{2}+a_{1}A_{u}+a_{0}=0,
$$

where $a_{3}=\sqrt{2\pi}(m+1)ak\rho$, $a_{2}=-\sqrt{2\pi}ak\rho\alpha-\rho J_{0}/\sqrt{2}$, $a_{1}=m+1$, and $a_{0}=-\alpha$. It is easy to check that Eq. (50) only has one real solution, which is written as,

$$
A_{u}=\left[-\frac{q}{2}+\sqrt{(\frac{q}{2})^{2}+(\frac{p}{3})^{3}}\right]^{1/%
3}+\left[-\frac{q}{2}-\sqrt{(\frac{q}{2})^{2}+(\frac{p}{3})^{3}}\right]^{1/3},
$$

where $q=(3a_{3}a_{1}-a_{2}^{2})/(3a_{3}^{2})$ and $p=(27a_{3}^{2}a_{0}-9a_{3}a_{2}a_{1}+2a_{2}^{3})/(27a_{3}^{3})$. The form of $A_{u}$ given by Eq. (51) is quite complicated. By numerical simulation, we find that the condition $\sqrt{2\pi}ak\rho A_{u}^{2}\gg 1$ always holds. This gives $A_{u}^{2}/(1+\sqrt{2\pi}ak\rho A_{u}^{2})\approx 1/\sqrt{2\pi}ak\rho$. Thus, the expression of $A_{u}$ can be simplified to be,

$$
A_{u}=\frac{J_{0}+2\sqrt{\pi}ak\alpha}{2\sqrt{\pi}ak(1+m)}.
$$

From Eq. (46), we have $A_{v}\approx mA_{u}$. In the below, we continue to solve the dynamics of $s_{u}(t)$ and $s_{v}(t)$, which vary with different parameter conditions.

![Refer to caption](https://arxiv.org/html/2410.06517v1/x4.png)

Figure 4: Smooth tracking of the A-CANN. a. An illustration of the smooth tracking state of A-CANN. The neural activity bump U ⁢ ( x, t ) 𝑈 𝑥 𝑡 U(x,t) italic\_U ( italic\_x, italic\_t ) moves at the speed v e subscript 𝑣 𝑒 v\_{ext} italic\_v start\_POSTSUBSCRIPT italic\_e italic\_x italic\_t end\_POSTSUBSCRIPT of the external input I superscript 𝐼 I^{ext}(x,t) italic\_I start\_POSTSUPERSCRIPT italic\_e italic\_x italic\_t end\_POSTSUPERSCRIPT ( italic\_x, italic\_t ) with a separation s u 𝑠 𝑢 s\_{u} italic\_s start\_POSTSUBSCRIPT italic\_u end\_POSTSUBSCRIPT. The adaptation current V 𝑉 V(x,t) italic\_V ( italic\_x, italic\_t ) is delayed by s\_{v} italic\_s start\_POSTSUBSCRIPT italic\_v end\_POSTSUBSCRIPT with respect to the bump. b. Depending on the relative sizes of and i n 𝑖 𝑛 v\_{int} italic\_v start\_POSTSUBSCRIPT italic\_i italic\_n italic\_t end\_POSTSUBSCRIPT (scaled by τ / 𝜏 \\tau/\\tau\_{v} italic\_τ / italic\_τ start\_POSTSUBSCRIPT italic\_v end\_POSTSUBSCRIPT ), the bump can either lead the external input ( > 0 s\_{u}>0 italic\_s start\_POSTSUBSCRIPT italic\_u end\_POSTSUBSCRIPT > 0, anticipate tracking state) or lag the external input ( < s\_{u}<0 italic\_s start\_POSTSUBSCRIPT italic\_u end\_POSTSUBSCRIPT < 0, delayed tracking state). c. For small speed values, the A-CANN achieves a roughly constant anticipation time 𝑎 t\_{ant} italic\_t start\_POSTSUBSCRIPT italic\_a italic\_n italic\_t end\_POSTSUBSCRIPT with respect to the external input. d. The anticipation time increases roughly linearly with adaptation strength m 𝑚 italic\_m. Parameters are: = 0.4 a=0.4 italic\_a = 0.4 J 1 𝐽 J\_{0}=1 italic\_J start\_POSTSUBSCRIPT 0 end\_POSTSUBSCRIPT = 1 k 5 𝑘 k=5 italic\_k = 5 \\tau=1ms italic\_τ = 1 italic\_m italic\_s 48 \\tau\_{v}=48ms italic\_τ start\_POSTSUBSCRIPT italic\_v end\_POSTSUBSCRIPT = 48 italic\_m italic\_s ρ 512 2 π 𝜌 𝜋 \\rho=512/(2\\pi) italic\_ρ = 512 / ( 2 italic\_π ) α 0.19 𝛼 \\alpha=0.19 italic\_α = 0.19 0.1 m=0.1 italic\_m = 0.1 in ( ), 0.5 v\_{ext}=0.5/s italic\_v start\_POSTSUBSCRIPT italic\_e italic\_x italic\_t end\_POSTSUBSCRIPT = 0.5 / italic\_s ).

### 4.1 Smooth tracking state

We begin by studying the smooth tracking state, in which the neural bump tracks the external input in a phase-locking manner, in terms of that the discrepancy between the neural activity bump and the external input bump $s_{u}(t)$, and the discrepancy between the neural activity bump and the adaptation current bump $s_{v}(t)$ are constants, i.e., $ds_{u}(t)/dt=0$ and $ds_{v}(t)/dt=0$. This occurs when the external input strength is sufficiently strong or the adaptation strength is sufficiently weak.

Substituting $ds_{u}(t)/dt=0,ds_{v}(t)/dt=0$ into Eqs. (47-LABEL:project\_V1\_tracking), we have,

$$
\displaystyle s_{u}\exp\left(-\frac{s_{u}^{2}}{8a^{2}}\right)
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\frac{\tau A_{u}v_{ext}}{\alpha}\left[\frac{\tau_{v}}{m\tau}\left%
(\frac{A_{v}}{A_{u}}\right)^{2}-1\right],
$$
$$
\displaystyle s_{v}\exp\left(-\frac{s_{v}^{2}}{8a^{2}}\right)
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\frac{\tau_{v}A_{v}v_{ext}}{mA_{u}}.
$$

Combining Eqs. (53-54) with Eqs. (45-46), we solve the smooth tracking state, which gives,

$$
\displaystyle s_{v}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\tau_{v}v_{ext},
$$
$$
\displaystyle s_{u}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\frac{\tau_{v}v_{ext}\left[m\exp\left(-\frac{\tau_{v}^{2}v_{ext}^%
{2}}{4a^{2}}\right)-\frac{\tau}{\tau_{v}}\right]}{1-\frac{\rho J_{0}A_{r}}{%
\sqrt{2}A_{u}}-m\left(\exp\left(-\frac{\tau_{v}^{2}v_{ext}^{2}}{4a^{2}}\right)%
\right)^{2}}.
$$

It can be checked from Eq. (56) that when $v_{int}>v_{ext}$, $s_{u}>0$, that is, the neural activity bump leads the external input.

Furthermore, when the conditions $v_{ext}\ll a/\tau_{v}$ and $s_{u}\ll 2\sqrt{2}a$ are satisfied, the value of $s_{u}$ can be approximated to be

$$
s_{u}\approx\frac{A_{u}v_{ext}\tau_{v}}{\alpha}(m-\frac{\tau}{\tau_{v}}),
$$

which indicates that $s_{u}$ increases linearly with $v_{ext}$. In such a case, the anticipation time is a constant independent of the input speed, which is calculated to be

$$
t_{ant}=\frac{s}{v_{ext}}\approx\frac{A_{u}\tau_{v}}{\alpha}(m-\frac{\tau}{%
\tau_{v}}).
$$

These theoretical results are verified by simulations (Fig.4b-c).

In summary, we have two observations: 1) the neural bump of the A-CANN can track the external moving input in an anticipative manner when $v_{int}>v_{ext}$; 2) the anticipation time can be approximated as a constant for a wide range of input speeds.

#### 4.1.1 Stability analysis of the smooth tracking state

We proceed to study the stability of the smooth tracking state. The Jacobian matrix of the simplified tracking dynamics in Eqs. (47-LABEL:project\_V1\_tracking) is calculated to be:

$$
\textbf{M}=\left(\begin{array}[]{cc}-\frac{\alpha}{\tau A_{u}}F(s_{u})&\frac{A%
_{v}}{\tau A_{u}}F(s_{v})\\
-\frac{\alpha}{\tau A_{u}}F(s_{u})&\left(\frac{A_{v}}{\tau A_{u}}-\frac{mA_{u}%
}{\tau_{v}A_{v}}\right)F(s_{v})\end{array}\right),
$$

where the function $F(x)=(1-x^{2}/4a^{2})\exp(-x^{2}/8a^{2})$. The matrix can be further simplified as,

$$
\textbf{M}=\frac{A_{v}}{\tau A_{u}}F(s_{u})\left(\begin{array}[]{cc}-\phi&1\\
-\phi&(1-\theta)\end{array}\right),
$$

in which,

$$
\displaystyle\theta
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\frac{m\tau}{\tau_{v}}(\frac{A_{u}}{A_{v}})^{2},
$$
$$
\displaystyle\phi
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\frac{\alpha}{A_{v}}\frac{F(s_{u})}{F(s_{v})}.
$$

According to the Vieta theorem, the eigenvalues of the Jacobian matrix $\bf{M}$, denoted as $\lambda_{1}$ and $\lambda_{2}$, satisfy,

$$
\displaystyle\lambda_{1}+\lambda_{2}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle 1-\theta-\phi,
$$
$$
\displaystyle\lambda_{1}\lambda_{2}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\phi\theta>0.
$$

For the smooth tracking state to be stable, it requires that both eigenvalues have negative real parts, which implies:

$$
\theta+\phi>1.
$$

We consider that the external input speed $v_{ext}\ll a/\tau_{v}$ and the discrepancies $s_{u}\ll a$ and $s_{v}\ll a$. Under these conditions, we have the approximations $F(s_{u})\approx F(s_{v})\approx 1$ and $A_{v}\approx mA_{u}$ (see Eq. (46)). Substituting Eqs. (61-62, 46) into Eq. (65), we get,

$$
m-\frac{\tau}{\tau_{v}}<\frac{\alpha}{A_{u}}.
$$

Based on Eq. (66), we differentiate two different situations on the stability of the smooth tracking state: 1) when the adaptation strength is too weak to produce a traveling wave, i.e., $m<\tau/\tau_{v}$, the smooth tracking state is stable since Eq. (66) always holds (note $\alpha\geq 0$). 2) When the adaptation strength $m>\tau/\tau_{v}$, the smooth tracking state is stable only when $m<\tau/\tau_{v}+\alpha/A_{u}$, i.e., it requires the external input strength $\alpha$ to be sufficiently large.

#### 4.1.2 Biological implications of anticipative tracking

A CANN can track an external moving input smoothly, a property that has been used to model spatial navigation in the hippocampus [^34]. The tracking of a CANN is, however, always lagging behind the true location of the external input, as it takes time for the network responding to the external input change. Here, we show that by including strong enough adaptation in the neural dynamics, the A-CANN is able to track an external moving input anticipatively. The underlying mechanism can be intuitively understood as follows. The adaptation induces intrinsic mobility of the neural bump, in term of that the bump tends to move spontaneously as travelling wave at the speed $v_{int}$ when the adaptation strength is sufficiently strong, while the external moving input wants to drive the bump to moves at the speed $v_{ext}$. These two forces compete with each other, leading to that the bump leads the external input when $v_{int}>v_{ext}$. Furthermore, if the speed of the external input is not too large, the bump leads the external input with a constant leading time.

Time delays are pervasive and significant in the brain, as the transmission of neural signal over hierarchical layers take time. If these delays are not compensated properly, our perception and reaction will lag behind the real circumstance in the external world significantly, impairing our vision and movement. The anticipative tracking behavior of the A-CANN may provide a simple yet effective mechanism to compensate these delays. For instance, the experiment depicted that the internal head-direction representation in the anterior thalamus of a rat anticipates the animal’s head-direction by about $20-25$ ms, independent of the rotation speed of the head [^35]. The head-direction system has been modeled using CANNs [^36], and the A-CANN can justify the constant anticipation time as observed in the experiment.

### 4.2 Oscillatory tracking state

We further study the tracking dynamics of the A-CANN when the smooth tracking state is unstable. Eq. (66) shows that the bifurcation point is at $m_{0}=\alpha A_{u}+\tau/\tau_{v}$. As $m$ increases from a small value to be larger than $m_{0}$, the real parts of eigenvalues $\lambda_{1}$ and $\lambda_{2}$ change sign from negative to positive. At the bifurcation point, the phase space formed by $ds_{u}/dt$ and $ds_{v}/dt$ changes its topology. The type of bifurcation depends on the imaginary parts of eigenvalues at the fixed point, which is given by,

$$
\Delta=\sqrt{(1-\theta-\phi)^{2}-4\phi\theta}.
$$

At the bifurcation point, $\lambda_{1}+\lambda_{2}=1-\theta-\phi=0$ holds, which leads to $\Delta^{2}=-4\phi\theta<0$. As a result, the bifurcation point $m_{0}$ is Hopf bifurcation, in term of that the eigenvalues change their signs through the imaginary axis (see illustration in Fig.5b) [^37]. Hopf bifurcation incurs the emergence of limit cycle dynamics of a dynamical system (see Fig. 5a) [^37]. This leads to the neural bump of the A-CANN tracks the external input in an oscillatory way, in term of that the neural bump will sweep forth and back around the external input [^26] [^38] [^39] (Fig. 5c).

![Refer to caption](https://arxiv.org/html/2410.06517v1/x5.png)

Figure 5: Oscillatory tracking of the A-CANN. a. Eigenvalues cross the imaginary axis from a non-zero point. b. Geometric interpretation of the Hopf bifurcation and the emergence of oscillatory tracking. The Hopf bifurcation is generated when the eigenvalues cross the imaginary axis, which leads to oscillation (red line). c. The oscillatory tracking process of the A-CANN. The bump center (blue dashed line) tracks the position of the external input (black line) in an oscillatory way with a constant offset d 0 > subscript 𝑑 d\_{0}>0 italic\_d start\_POSTSUBSCRIPT 0 end\_POSTSUBSCRIPT > 0. The parameters are chosen, such that ω ≈ 8 ⁢ H z 𝜔 𝐻 𝑧 \\omega\\approx 8Hz italic\_ω ≈ 8 italic\_H italic\_z is in the range of theta frequency. - e. The oscillation frequency increases approximately linearly over a wide range of m 𝑚 italic\_m ( ) and α 𝛼 \\alpha italic\_α ). f. Phase diagram of the tracking dynamics of the A-CANN. Parameters are: = 0.4 𝑎 a=0.4 italic\_a = 0.4, J 1 𝐽 J\_{0}=1 italic\_J start\_POSTSUBSCRIPT 0 end\_POSTSUBSCRIPT = 1 k 0.76 𝑘 k=0.76 italic\_k = 0.76 τ 3 s 𝜏 𝑠 \\tau=3ms italic\_τ = 3 italic\_m italic\_s v 152 𝑣 \\tau\_{v}=152ms italic\_τ start\_POSTSUBSCRIPT italic\_v end\_POSTSUBSCRIPT = 152 italic\_m italic\_s ρ 128 / 2 π ) 𝜌 𝜋 \\rho=128/(2\\pi) italic\_ρ = 128 / ( 2 italic\_π ) 0.3 m=0.3 italic\_m = 0.3 0.2 \\alpha=0.2 italic\_α = 0.2 x t 0.5 𝑒 𝑥 𝑡 v\_{ext}=0.5/s italic\_v start\_POSTSUBSCRIPT italic\_e italic\_x italic\_t end\_POSTSUBSCRIPT = 0.5 / italic\_s.

For the convenience of analysis, in the oscillatory tracking state, we assume that the discrepancies $s_{u}(t)$ and $s_{v}(t)$ undergo harmonic oscillations, which are expressed as:

$$
\displaystyle s_{u}(t)=c_{u}sin(\omega t)+d_{u},
$$
$$
\displaystyle s_{v}(t)=c_{v}sin(\omega t+\gamma)+d_{v},
$$

where $c_{u},c_{v}$ and $\omega$ represent the amplitudes and frequency of the bump oscillation, $d_{u}$ and $d_{v}$ represent the average offsets between the bump oscillation and the external input, $\gamma$ represents the phase offset between the bumps of $U(x,t)$ and $V(x,t)$.

Substituting Eqs. (68-69) and (7) into the tracking dynamics given by Eqs. (45-LABEL:project\_V1\_tracking), and further taking the approximations that $\exp(-s_{u}^{2}/8a^{2})\approx\exp(-s_{v}^{2}/8a^{2})\approx 1$ and that bump heights $A_{u},A_{v}$ and $A_{r}$ are constants, we get,

$$
\displaystyle A_{u}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\frac{\rho J_{0}}{\sqrt{2}}\frac{A_{u}^{2}}{1+k\rho\sqrt{2\pi}aA_%
{u}^{2}}+\alpha-A_{v},
$$
$$
\displaystyle A_{v}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle mA_{u},
$$
$$
\displaystyle c_{u}\omega\cos{\omega t}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\frac{A_{v}}{\tau A_{u}}(c_{v}\sin{(\omega t+\gamma)}+d_{v})-%
\frac{\alpha}{\tau A_{u}}(c_{u}\sin{\omega t}+d_{u})-v_{ext},
$$
$$
\displaystyle c_{v}\omega\cos{(\omega t+\gamma)}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle-\frac{mA_{u}}{\tau_{v}A_{v}}(c_{v}\sin{(\omega t+\gamma)}+d_{v})%
+c_{u}\omega\cos\omega t+v_{ext}.
$$

Eqs. (72-73) can be re-written as,

$$
\displaystyle c_{u}\omega\cos{\omega t}+\frac{\alpha}{\tau A_{u}}(c_{u}\sin{%
\omega t}+d_{u})=\frac{A_{v}}{\tau A_{u}}c_{v}\sin{(\omega t+\gamma)}+\frac{A_%
{v}}{\tau A_{u}}d_{v}-v_{ext},
$$
$$
\displaystyle\frac{\alpha}{\tau A_{u}}(c_{u}\sin{\omega t}+d_{u})=\left(\frac{%
A_{v}}{\tau A_{u}}-\frac{mA_{u}}{\tau_{v}A_{v}}\right)(c_{v}\sin{(\omega t+%
\gamma)}+d_{v})-c_{v}\omega\cos{(\omega t+\gamma)}.
$$

At first glance, it may appear to be impossible to solve for six unknown variables ($c_{u},c_{v},\omega,\gamma,d_{u}$, and $d_{v}$) with only two equations. However, by applying the trigonometric transformation formula and $A_{v}=mA_{u}$, we can transform Eqs. (74-75) into a form where both sides of two equations can be represented as sine waves, which are:

$$
\displaystyle c_{u}\omega\sqrt{1+\left(\frac{\alpha}{\tau A_{u}\omega}\right)^%
{2}}\sin{(\omega t+\psi_{1})}+\frac{\alpha}{\tau A_{u}}d_{u}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\frac{m}{\tau}c_{v}\sin{(\omega t+\gamma)}+\frac{m}{\tau}d_{v}-v_%
{ext},
$$
$$
\displaystyle c_{v}\sqrt{\tau_{v}^{2}\omega^{2}+1}\sin{(\omega t+\gamma+\psi_{%
2})}+d_{v}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\tau_{v}\left(c_{u}\omega\cos\omega t+v_{ext}\right),
$$

where $\psi_{1}=\arcsin(1/\sqrt{1+(\frac{\alpha}{\tau A_{u}\omega})^{2}})$, and $\psi_{2}=\arcsin(\tau_{v}\omega/\sqrt{\tau_{v}^{2}\omega^{2}+1})$.

We can obtain six equations by equating the amplitudes, phase, and constant offset of both sides of Eqs. (76, 77), which are:

$$
\displaystyle c_{u}\omega\sqrt{1+\left(\frac{\alpha}{\tau A_{u}\omega}\right)^%
{2}}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\frac{m}{\tau}c_{v},
$$
$$
\displaystyle\psi_{1}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\gamma,
$$
$$
\displaystyle\frac{\alpha}{\tau A_{u}}d_{u}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\frac{m}{\tau}d_{v}-v_{ext},
$$
$$
\displaystyle c_{v}\sqrt{\tau_{v}^{2}\omega^{2}+1}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\tau_{v}c_{u}\omega,
$$
$$
\displaystyle\gamma+\psi_{2}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\frac{\pi}{2},
$$
$$
\displaystyle d_{v}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\tau_{v}v_{ext}.
$$

Finally, combining Eqs.(78-83), we solve the oscillatory tracking state, which are given by,

$$
\displaystyle d_{u}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\frac{\tau_{v}A_{u}}{\alpha}v_{ext}(m-\frac{\tau}{\tau_{v}}),
$$
$$
\displaystyle d_{v}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle v_{ext}\tau_{v},
$$
$$
\displaystyle\omega
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\sqrt{\frac{2\sqrt{\pi}\alpha ak(1+m)}{\tau\tau_{v}(J_{0}+2\sqrt{%
\pi}ak\alpha)}},
$$
$$
\displaystyle\psi_{1}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\arcsin(\frac{1}{\sqrt{1+(\frac{\alpha}{\tau A_{u}\omega})^{2}}}),
$$
$$
\displaystyle c_{u}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle c_{v}\sqrt{1+\frac{\tau A_{u}}{\tau_{v}\alpha}}.
$$

From Eq. (86), we see that the oscillation frequency $\omega$ of the bump increases sublinearly with both the external input strength $\alpha$ and the adaptation strength $m$. Simulation results confirm these theoretical results (Fig. 5d and e).

#### 4.2.1 Stability analysis of the oscillatory tracking state

We proceed to analyze the stability of the oscillatory tracking state. As the adaptation strength $m$ continuously increase, the real parts of eigenvalues $\lambda_{1}$ and $\lambda_{2}$ keep increasing and their imaginary parts decrease to zero. The conditions for both eigenvalues being positive numbers are

$$
\displaystyle\lambda_{1}+\lambda_{2}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle 1-\theta-\phi>0,
$$
$$
\displaystyle\Delta^{2}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle(\phi+\theta-1)^{2}-4\theta\phi\geq 0,
$$

which is equivalent to

$$
\displaystyle\theta+\phi+\sqrt{\theta\phi}<1.
$$

We consider that the external input speed $v_{ext}\ll a/\tau_{v}$ and the discrepancies $s_{u}\ll a$ and $s_{v}\ll a$. Under these conditions, we have the approximations $F(s_{u})\approx F(s_{v})\approx 1$ and $A_{v}\approx mA_{u}$ (see Eq. (46)). Substituting Eqs. (61-62) and (46) into Eq. (91), we get (?),

$$
m-\frac{\tau}{\tau_{v}}>\frac{\alpha}{A_{u}}\left(1+\sqrt{\frac{\tau}{\tau_{v}%
}\frac{A_{u}}{\alpha}}\right).
$$

In this case, since both two eigenvalues are positive, the network state deviates from a fixed point, and the network falls into the state of travelling wave.

#### 4.2.2 Biological implications of oscillatory tracking

We can intuitively understand how the A-CANN generates oscillatory tracking. Adaptation induces intrinsic mobility of the neural bump. Given that the strength of the external input is fixed. If the adaptation is too strong, the neural bump will move spontaneously as if no external input, realizing travelling wave; if the adaptation is too weak, the external input will drive the neural bump to move at its speed, realizing smooth tracking. Oscillatory tracking occurs when the adaptation strength has an intermediate value, whereby the neural bump tries to run away but is pulled back by the external input, causing the neural bump moves back and forth around the external input.

Oscillatory tracking of the A-CANN can account for a number of theta response characteristics of hippocampal place cells during navigation found in rat experiments. By choosing the parameters properly, we can set the frequency of bump oscillation in the range of theta band, independent of the speed of the external input. At the population level, the oscillation of the bump center around the external input resembles theta sweeps of the decoded position based on place cell activities around the true position of the moving rat. At the single neuron level, the forward and backward sweeps of the neural bump lead to that each neuron generates bursting responses at the theta rhythm, and the firing phases of a neuron in each theta cycle preceeds or proceeds, respectively, as the external input transfers through the receptive field of the neuron. This resembles the phase precession and procession phenomena observed in the expriments. For details, please refer to [^39]. Both theta sweeps and phase shift have been suggested to play important roles in spatial information encoding and memory formation.

### 4.3 Phase diagram of the tracking dynamics of the A-CANN

From Eqs. (66,92), we get the phase diagram of the tracking dynamics of A-CANN. Particularly, by gradually increasing the adaptation strength $m$ while keeping the external input strength $\alpha$ fixed (or equivalently, by keeping the adaptation strength $m$ fixed while gradually increasing the external input strength $\alpha$), we have

- Smooth tracking state, in which the neural bump tracks the external input at the speed $v_{ext}$ in a phase-locking manner. This occurs for $m-\tau/\tau_{v}<\alpha/A_{u}$. Furthermore, depending on the relative amplitudes of $v_{ext}$ and $v_{int}$, the neural bump can either lead the external input when $v_{int}>v_{ext}$ or lag behind the input when $v_{int}<v_{ext}$. In particular, for small speed of the external input ($v_{ext}\ll a/\tau_{v}$) and $m>\tau/\tau_{v}$, the neural bump tracks the external input with a constant anticipation time.
- Oscillatory tracking state, in which the neural bump tracks the external input in an oscillatory manner. This occurs for $\alpha/A_{u}<m-\tau/\tau_{v}<\alpha/A_{u}\left(1+\sqrt{\frac{\tau}{\tau_{v}}%
	\frac{A_{u}}{\alpha}}\right)$.
- Traveling wave state, in which the neural bump moves freely at the speed $v_{int}$. This occurs for $m-\tau/\tau_{v}>\alpha/A_{u}\left(1+\sqrt{\frac{\tau}{\tau_{v}}\frac{A_{u}}{%
	\alpha}}\right)$.

The phase diagram of the A-CANN is presented in Fig. 5f. Our theoretical analyses agree well with simulation results.

## 5 Noisy adaptation generates Diffusion and Super-diffusion Dynamics in CANNs

In the previous sections, we have discussed the dynamics of the A-CANN without noise. In reality, however, real biological nervous systems are full of endogenous and exogenous noises at neuronal dynamics and signal transmission. Extensive researches have shown that noises introduce randomness in network dynamics, which can enhance neural information processing (see, e.g., [^40] [^41] [^42]). In the below, we study how noises affect the dynamics of the A-CANN and their implications on neural information processing. In particular, in addition to noises on the neuronal dynamics, we also consider noises on the adaptation dynamics.

With noises, the dynamics of the A-CANN are re-written as,

$$
\displaystyle\tau\frac{dU(x,t)}{dt}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle-U(x,t)+\rho\int_{-\infty}^{\infty}J(x,x^{\prime})r(x^{\prime},t)%
\,dx^{\prime}-V(x,t)+I^{ext}(x,t)+\sigma_{U}\xi_{U}(x,t),
$$
$$
\displaystyle\tau_{v}\frac{dV(x,t)}{dt}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle-V(x,t)+mU(x,t)+\sigma_{m}\xi_{m}(x,t)f\left[U(x,t)\right],
$$

where the term $\sigma_{U}\xi_{U}(x,t)$ represents noises on the neuronal dynamics, with $\sigma_{U}$ the noise strength and $\xi_{U}(x,t)$ Gaussian white noise of zero mean and unit variance. The term $\sigma_{m}\xi_{m}(x,t)f[U(x,t)]$ represents noises on the adaptation dynamics, with $\sigma_{m}$ controlling the noise strength and $\xi_{m}(x,t)$ Gaussian white noise of zero mean and unit variance; the function $f[U(x,t)]$ denoting how the noise strength depends on the neuronal activity.

### 5.1 Spontaneous dynamics of the noisy A-CANN

We first study the spontaneous dynamics of the noisy A-CANN by setting $I^{ext}(x,t)=0$. We consider $f[U(x,t)]=U(x,t)$ for the clarity of theoretical analysis. Again, we assume that the network state can be approximately to be of the Gaussian form, which hold when noises are not too strong.

Substituting Eqs. (4-5) into Eqs. (93-94) and (2), we obtain,

$$
\displaystyle A_{r}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\frac{A_{u}^{2}}{1+k\rho\sqrt{2\pi}aA_{u}^{2}},
$$
$$
\displaystyle\tau\left[A_{u}\frac{x-z}{2a^{2}}\frac{dz}{dt}+\frac{dA_{u}}{dt}%
\right]\mathcal{N}(z,2a)
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle(-A_{u}+\frac{\rho J_{0}}{\sqrt{2}}A_{r})\mathcal{N}(z,2a)
$$
 
$$
\displaystyle-A_{v}\mathcal{N}(z-s,2a)+\sigma_{U}\xi_{U}(x,t),
$$
$$
\displaystyle\tau_{v}\left[A_{v}\frac{x-z+s}{2a^{2}}\frac{d(z-s)}{dt}+\frac{dA%
_{v}}{dt}\right]\mathcal{N}(z-s,2a)
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle-A_{v}\mathcal{N}(z-s,2a)
$$
 
$$
\displaystyle+[m+\sigma_{m}\xi_{m}(x,t)]A_{u}\mathcal{N}(z,2a),
$$

where $s$ denotes the separation between $U$ and $V$ bumps, while other notations keep the same as in previous sections.

We project Eqs. (LABEL:dynamics\_u(t)\_noisy-97) onto the two dominating motion modes of the network dynamics, i.e., the bump height ($u_{0}(x|z)$) and position ($u_{1}(x|z)$), and obtain,

$$
\displaystyle\tau\frac{dA_{u}}{dt}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle(-A_{u}+\frac{\rho J_{0}}{\sqrt{2}}A_{r})-A_{v}\exp\left(-\frac{s%
(t)^{2}}{8a^{2}}\right)+\frac{1}{\sqrt{2\pi}a}\sigma_{U}\xi_{U,0}(t),
$$
$$
\displaystyle\tau A_{u}\frac{dz}{dt}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle s(t)A_{v}\exp\left(-\frac{s(t)^{2}}{8a^{2}}\right)+\sqrt{\frac{2%
}{\pi}}\sigma_{U}\xi_{U,1}(t),
$$
$$
\displaystyle\tau_{v}\frac{dA_{v}}{dt}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle-A_{v}+[m+\frac{1}{2\sqrt{\pi}a}\sigma_{m}\xi_{m,0}(t)]A_{u}\exp%
\left(-\frac{s(t)^{2}}{8a^{2}}\right),
$$
$$
\displaystyle\tau_{v}A_{v}\frac{ds}{dt}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle s(t)\exp\left(-\frac{s(t)^{2}}{8a^{2}}\right)\left(\frac{\tau_{v%
}}{\tau A_{u}}A_{v}^{2}-[m+\frac{1}{2\sqrt{\pi}a}\sigma_{m}\xi_{m,0}(t)]A_{u}\right)
$$
 
$$
\displaystyle+\frac{\tau_{v}A_{v}}{\tau A_{u}}\sqrt{\frac{2}{\pi}}\sigma_{m}%
\xi_{m,1}(t),
$$

where $\xi_{U,0}(t)$, $\xi_{U,1}(t)$, $\xi_{m,0}(t)$, $\xi_{m,1}(t)$ are the projections of $\xi_{U}(t)$ and $\xi_{m}(t)$ onto the two motion modes, respectively, and they are still Gaussian noises of zero mean and unit variance.

The previous sections have shown that in the case of no noises, $m_{0}=\tau/\tau_{v}$ is the critical point, below which ($m<m_{0}$) the network holds the static bump state and above which ($m>m_{0}$) the network holds the travelling wave state. Intuitively, it is understandable that when Gaussian white noises are included, they causes the neural bump to experience local Brownian motion when $m\ll m_{0}$, while they have little effect on the travelling wave when $m\gg m_{0}$. The interesting phenomenon happens when $m$ is close to the boundary $m_{0}$, as noises will cause the effective adaptation strength $\tilde{m}(t)$ to fluctuate around the boundary, leading to that the neural bump to exhibit a mixed movement pattern: temporally Brownian motion when $\tilde{m}(t)<m_{0}$ and temporally large-size movement caused by travelling wave when $\tilde{m}(t)<m_{0}$. Such a motion pattern is called Lévy flights. In below, we analyze this Lévy flights state.

For the convenience of analysis, we consider that the levels of noises are low and that the variances of bump heights $A_{u}$ and $A_{v}$ are negligible. Under these approximations, Eqs. (99,101) can be simplified as,

$$
\displaystyle\tau\frac{dz}{dt}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle ms(t)+\sqrt{\frac{2}{\pi}}\frac{\sigma_{U}}{A_{u}}\xi_{U,1}(t),
$$
$$
\displaystyle\tau_{v}\frac{ds}{dt}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle-[1-\frac{\tau_{v}}{\tau}m+\frac{\sigma_{m}}{2\sqrt{\pi}am}\xi_{m%
,0}(t)]s(t)+\sqrt{\frac{2}{\pi}(\frac{\tau_{v}\sigma_{U}}{\tau A_{u}})^{2}+%
\frac{1}{2\pi}(\frac{\sigma_{m}}{m})^{2}}\xi_{s}(t),
$$

where $\xi_{s}(t)$ is Gaussian white noise of zero mean and unit variance.

Eq. (102) shows that the bump position $z(t)$ is determined by two parts, a drift term ($ms(t)$) reflecting the contribution of adaptation and a diffusion term ($\sqrt{2/\pi}(\sigma_{U}/A_{u})\xi_{U,1}(t)$) reflecting the contribution of noises on the neuronal dynamics. It is evident that, in the absence of adaptation ($m=0$), the dynamics of the bump center expressed by Eq. (102) degenerate into a Brownian motion process driven by Gaussian noise [^43].

To solve the dynamics of $z(t)$, we first solve the dynamics of $s(t)$. For clearance, we re-organize Eq. (LABEL:project\_V1\_noi) as,

$$
\displaystyle\tau_{v}\frac{ds}{dt}=-(\mu+\gamma\xi_{m,0})s+\sigma_{s}\xi_{s},
$$

where $\mu=1-m\tau_{v}/\tau$ denotes the distance-to-boundary ratio, reflecting the gap between the mean adaptation strength and the boundary of the travelling wave ($\tau/\tau_{v}$). $\gamma=\sigma_{m}/(2\sqrt{\pi}am)$ denotes the noise-to-strength ratio, reflecting the relative amplitude of noises. $\sigma_{s}=\sqrt{2\tau_{v}^{2}\sigma_{U}^{2}/(\pi\tau^{2}A_{u}^{2})+2a^{2}%
\gamma^{2}}$ represents the re-scaled neuronal noises.

We first consider that no noise in the adaptation ($\gamma=0$). In such a case, if $\mu<0$, i.e., $m>\tau/\tau_{v}$, $s(t)$ will simply increase monotonically with time without converging to any stable points. If $\mu>0$, i.e., $0<m<\tau/\tau_{v}$, the evolution of the equation proposed in Eq. (104) gives rise to an Ornstein-Uhlenbeck (OU) process [^44], and the distribution of $s(t)$ is Gaussian [^44]. It can be written as,

$$
\displaystyle p^{st}(s)=\sqrt{\frac{\mu}{\pi\sigma_{s}^{2}}}\exp\left[-\frac{%
\mu s^{2}}{.}{\sigma_{s}^{2}}\right]
$$

Combining Eqs. (105) and (102), the dynamics of $dz/dt$ turns out to be determined by the sum of two Gaussian noise terms, which is still Gaussian. This implies that the bump takes on Brownian motion.

The dynamics of the bump center $z(t)$ becomes intriguing when the adaptation strength $m$ fluctuates, i.e. $\gamma>0$, since the multiplicative noise $\xi_{m}$ in the drift term will play its role. Utilizing Ito calculus, we can rewrite Eq. (104) as a first order difference equation,

$$
\displaystyle s(t+dt)
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle s(t)+\int_{t}^{t+dt}\left[-\frac{\mu s(t^{\prime})}{\tau_{v}}+%
\frac{\gamma s(t^{\prime})}{\sqrt{\tau_{v}}}\xi_{m}(t^{\prime})+\frac{\sigma_{%
s}}{\sqrt{\tau_{v}}}\xi_{s}(t^{\prime})\right]dt^{\prime},
$$
$$
\displaystyle=s(t)-\frac{\mu s(t)}{\tau_{v}}dt+\frac{1}{\sqrt{\tau_{v}}}\left[%
-s(t)\gamma dt\bar{\xi_{m}}+\sigma_{s}dt\bar{\xi_{s}}\right],
$$

where $dt\bar{\xi_{m}}$ and $dt\bar{\xi_{s}}$ are the Ito prescriptions in the limit of $dt\xrightarrow{}0$. To derive the Fokker-Planck equation, we adopt a smooth trail function $R(s)$ proposed by Rivers [^45] and calculate its time average,

$$
\displaystyle\left\langle R(t)\right\rangle=\int R(s)p(s,t)ds,
$$

where $p(s,t)$ is the distribution of $s(t)$ at time $t$. The evolution of the average value of $R(t)$ in a short interval $dt$ at time $t$ is given by,

$$
\displaystyle\left\langle R(t+dt)\right\rangle
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\left\langle\int R\left(s-\frac{\mu s}{\tau_{v}}dt+\frac{1}{\sqrt%
{\tau_{v}}}(-s\gamma dt\bar{\xi_{m}}+\sigma_{s}dt\bar{\xi_{s}})\right)p(s,t)ds%
\right\rangle,
$$
$$
\displaystyle=
$$
 
$$
\displaystyle\left\langle\int\left(R(s)+dtR^{\prime}(s)(-\frac{\mu}{\tau_{v}}s%
)+dtR^{\prime\prime}(s)(\frac{\sigma_{s}^{2}+\gamma^{2}s^{2}}{2\tau_{v}})%
\right)p(s,t)ds\right\rangle.
$$

Eq. (LABEL:Taylor\_R) is the first-order Taylor-series expansion of the trail function $R(\cdot)$. Note that the left side corresponds to the partial derivative of $p(s,t)$ with respect to $t$, and the right side corresponds to the partial derivative of $p(s,t)$ with respect to $s$. Thus we obtain the Fokker-Planck equation which describes the time evolution of the distribution of $s(t)$,

$$
\displaystyle\frac{\partial p(s,t)}{\partial t}=-\frac{\partial}{\partial s}%
\left(-\frac{\mu}{\tau_{v}}sp(s,t)\right)+\frac{\partial^{2}}{\partial s^{2}}%
\left(\frac{\sigma_{s}^{2}+\gamma^{2}s^{2}}{2\tau_{v}}p(s,t)\right).
$$

The stationary distribution of $p^{st}(s)$ is achieved when

$$
\displaystyle-\frac{\mu}{\tau_{v}}sp(s,t)=\frac{d}{ds}\left(\frac{\sigma_{s}^{%
2}+\gamma^{2}s^{2}}{2\tau_{v}}p(s,t)\right).
$$

Thus we obtain the stationary distribution of $s(t)$ by solving the corresponding Fokker-Planck equation, which gives,

$$
\displaystyle p(s)=c_{0}(\sigma_{s}^{2}+\gamma^{2}s^{2})^{-(1+\mu/\gamma^{2})},
$$

where $c_{0}$ is a normalization constant.

According to Eq. (102), the displacement of $z(t)$ in a short time interval $\delta t$ is calculated to be $||\Delta z||=||ms\delta t/\tau+\sqrt{2\delta t/(\pi\tau)}\sigma_{U}/A_{u}\xi_{%
U,1}||$. Substituting $s$ with its stationary distribution Eq. (112), we finally derive the distribution of $||\Delta z||$,

$$
\displaystyle p(||\Delta z||)=c_{1}||\Delta z||^{-1-\alpha},
$$

which clearly satisfies a power-law distribution with the exponent $\alpha=1+2\mu/\gamma^{2}$.

The above power-law distribution represents a typical diffusion (or random walk) process. When the diffusion parameter $\alpha$ satisfies $0<\alpha<2$, the distribution describes Lévy flights, also termed as anomalous diffusion or super diffusion. When $\alpha>2$, the above process degenerates to Brownian motion due to the Central Limit Theorem [^43]. Although both are random wanderings, Lévy flight and Brownian motion have different properties. The distribution of steps in Brownian motion can be drawn as a bell-shaped curve. Lévy flights, on the other hand, are a class of random processes with Markovian properties characterized by occasional long-range jumps, i.e. long-tailed asymptotic form as $|s|\xrightarrow{}\infty$. Therefore, Lévy flights are more prone to occasional long-range jumps in comparison to Brownian motion. We carry simulations to verify our theoretical results. Fig. 6c shows the phase diagram of the spontaneous dynamics of noisy A-CANN. Fig. 6a and b shows the comparison between the simulation results and the theoretical solutions of the distribution exponent $\alpha$.

#### 5.1.1 Biological implications of Lévy flights

The A-CANN with adaptation has the intrinsic mobility of generating a travelling wave when the adaptation strength is strong enough [^4] [^14]. The condition of $m_{0}=\tau/\tau_{v}$ defines the boundary of the traveling wave. Above the boundary, the bump moves spontaneously in the attractor space; while below the boundary, the bump remains static without external input or exhibits Brownian motion when external noise is present. When noises are considered in the adaptation strength, the A-CANN displays new interesting dynamical behaviors. Specifically, consider the mean of the adaptation strength is close to the traveling wave boundary, noises occasionally push the adaptation strength across the boundary, causing bump movement to temporarily fall into the traveling wave state, and the bump travels a long distance (long jump) in the attractor space. Over time, due to the adaptation strength fluctuations, the bump movement displays intermittent local Brownian motion (the adaptation strength below the boundary) and long-jump motion (the adaptation strength above the boundary), manifesting the characteristic of Lévy flights [^46].

Mathematically, Lévy flight is an efficient strategy for information search in an unknown open space [^47] [^48] [^49]. It has been widely found in animal forging behaviors and also in human psychology experiments, such as free memory recalls [^50] [^51]. Furthermore, recently, the data recorded in electrophysiological experiments also revealed that when experimental animals remain still, the sequential reactivation of place cells in the hippocampal region follow statistical characteristics of Lévy flights [^52]. Our model may offer a potential mechanism for explaining the patterns of sequential activation of place cells, thus providing more insights into the understanding of higher cognitive functions associated with them.

![Refer to caption](https://arxiv.org/html/2410.06517v1/x6.png)

Figure 6: Spontaneous dynamics of the noisy A-CANN. a. The Lévy exponent α 𝛼 \\alpha italic\_α vs. μ 𝜇 \\mu italic\_μ with γ = 0.77 𝛾 \\gamma=0.77 italic\_γ = 0.77. Note that when > 2 / superscript \\mu>\\gamma^{2}/2 italic\_μ > italic\_γ start\_POSTSUPERSCRIPT 2 end\_POSTSUPERSCRIPT / 2, all \\alpha>2 italic\_α > 2 (Brownian motion) will converge to \\alpha=2 italic\_α = 2 due to the Central Limit Theorem. b \\gamma italic\_γ 0.16 \\mu=0.16 italic\_μ = 0.16. c. The phase diagram of the network dynamics with respect to the distance-to-boundary and the noise-to-strength ratio d. The phase diagram of the network dynamics with respect to the input strength and the adaptation strength m 𝑚 italic\_m. Parameters are: π 10 𝑎 𝜋 a=\\pi/10 italic\_a = italic\_π / 10, J 0 subscript 𝐽 J\_{0}=10 italic\_J start\_POSTSUBSCRIPT 0 end\_POSTSUBSCRIPT = 10 k 0.05 𝑘 k=0.05 italic\_k = 0.05 τ ⁢ s 𝜏 𝑠 \\tau=10ms italic\_τ = 10 italic\_m italic\_s v 25 𝑣 \\tau\_{v}=25ms italic\_τ start\_POSTSUBSCRIPT italic\_v end\_POSTSUBSCRIPT = 25 italic\_m italic\_s ρ 1600 ( ) 𝜌 \\rho=1600/(2\\pi) italic\_ρ = 1600 / ( 2 italic\_π ) ¯ 0.56 \\bar{m}=0.56 over¯ start\_ARG italic\_m end\_ARG = 0.56 σ 6.4 𝜎 \\sigma\_{m}=6.4 italic\_σ start\_POSTSUBSCRIPT italic\_m end\_POSTSUBSCRIPT = 6.4 U 0.01 𝑈 \\sigma\_{U}=0.01 italic\_σ start\_POSTSUBSCRIPT italic\_U end\_POSTSUBSCRIPT = 0.01

## 6 Conclusion and Discussion

Attractor networks, such as the Hopfield network, are neural models where information is encoded as stationary states in a dynamic system of interconnected neurons. While the Hopfield model effectively explains associative memory with discrete attractors, it falls short for correlated or continuous information representations. This led to the development of continuous attractor neural networks (CANNs), which form continuous subspaces for smooth tracking of information like orientation or spatial location. By studying CANNs, we gain insights into the balance between stability and mobility in neural representations, crucial for both reliable information encoding and efficient processing. Adaptive mechanisms, like neural adaptation, introduce necessary dynamics for this balance. In this research, ‘neural adaptation’ refers to the common phenomenon of decaying neuronal activities in response to repeated or prolonged stimulation in neural networks.

Here we review and unify previous studies on adaptive CANNs, offering a comprehensive theoretical framework and discussing the resulting rich dynamical behaviors and their biological implications.

Although the equations governing the dynamics of continuous attractor neural networks (CANNs) seem complex due to their high dimensionality, their behavior is primarily influenced by a few dominant motion modes, such as changes in the bump’s height, position, and width (illustrated in Fig.2d). By focusing on these dominant modes, we can greatly simplify the analysis of the network behavior by turning the high-dimensional neurodynamic model into state space model.

The role of adaptation mainly manifests in enhancing the intrinsic mobility and expressing capabilities of the system. In summary, external input pattern and intrinsic parametric conditions together determine the dynamical behavior of the system.

Considering spontaneuous motion (without external input), A-CANN holds a static bump as its stationary state when both the inhibition and adaptation are sufficiently small, satisfying $0<k<k_{c2}$ and $m<\tau/\tau_{v}$. These agree with our intuition, as strong inhibition will suppress neuronal activities. If $m>\tau/\tau_{v}$, the strong adaptation will drag and untimately destabilize the static bump, causing the bump to move spontaneously in the feature space in a traveling wave manner. The wave enables a neural system to progressively visit all stationary points. This could endows cognitive functions of memory retrieval and memory consolidation [^23].

In a practical situation, the neural system receives external or upstream input all the time. If the adaptation is weak, the external input will drive the neural bump to move at its speed, realizing smooth tracking; if the adaptation is too strong, the neural bump will move spontaneously as if no external input, realizing previous travelling wave. When taking an intermediate value, oscillatory tracking occurs, in which the neural bump is attracted by the center of the external input and moves back and forth. Our bifurcation analysis explains the state transition principle of the aattractor neural network from the perspective of dynamic system, and the theoretical and simulation results fit well (Fig.3).

When noise is factored, the A-CANN exhibits novel dynamical behaviors. Specifically, when the mean adaptation strength approaches the boundary value of the traveling wave, noise perturbations occasionally push the adaptation strength beyond the boundary. This causes the bump movement to switch between intermittent local Brownian motion and long-jump motion, demonstrating the characteristic of Lévy flights [^46]. This behavior enables efficient searching in neural landscape and can function as a possible policy in information processing.

By responding to external stimuli and processing internal information, adaptation mechanisms enable systems to continuously adjust their structure and parameters to adapt to environmental changes and emerge more diverse dynamical states. This dynamic adjustment ability is crucial for the survival and evolution of complex systems in complicated changing environments. The manifestation of adaptation in external phenomena is reflected in the enhancement of the stability, robustness, and self-organization of the system. Through adaptation mechanisms, systems can maintain stable states under external disturbances and possess a certain self-repair capability. The computational significance of adaptation mechanisms is self-evident.

The implementation foundation of adaptation mechanisms lies in the sensitivity to dynamically adjust information processing according to current state. In artificial neural networks, this is typically achieved through weight adjustments, gain modulation, etc., while in biological neural networks, it involves spiking frequency adaptation, synaptic plasticity, and neuron alterations. Here we summarize the possible biological applications of the dynamical properties of A-CANN in the various states mentioned earlier.

Adaptation causes suppression around network bump, destabilizing it and driving it to move. This spontaneous movement, aided by recurrent neural interactions, results in traveling wave behavior. Such waves could facilitate active retrieval of stored memories, supporting cognitive functions like memory search and consolidation [^28] [^29] [^23].

CANNs track external moving inputs but typically lag behind. However, with strong adaptation, A-CANNs can track inputs anticipatively. The adaptation creates intrinsic mobility, causing the neural bump to move at an internal speed, competing with the speed of the external input. When the internal speed exceeds the external speed, the bump leads the input with a constant time. This mechanism could help compensate for neural signal transmission delays, ensuring timely perception and reaction, as seen in the head-direction system of rats [^35].

A-CANNs exhibit oscillatory tracking when adaptation strength is intermediate. This may theta oscillations in hippocampal place cells during navigation, where the bump’s oscillation frequency matches the theta band. This results in theta sweeps and phase shifts in neuron firing, contributing to spatial information encoding and memory formation [^39].

In the A-CANN, adaptation can cause the neural bump to move spontaneously, generating traveling waves when adaptation strength is high. Near the threshold of this strength, noise can push the system into traveling wave states, resulting in intermittent long jumps and local Brownian motion, characteristic of Lévy flights [^46]. Lévy flights are efficient for information search and have been observed in animal foraging and human memory recall. This model may explain the sequential activation patterns of hippocampal place cells during rest, providing insights into higher cognitive functions.

Overall, our study explores various dynamic behaviors of A-CANNs and their biological implications. The traveling wave behavior supports memory retrieval and cognitive functions. Anticipative tracking compensates for neural delays. Oscillatory tracking explains hippocampal theta rhythms. Lévy flights offer an efficient mechanism for information search and hippocampal place cell activation patterns. These findings provide a comprehensive understanding of how neural adaptation influences brain functions and cognition.

We highlights the key differences between A-CANNs and typical CANNs, emphasizing the crucial role of adaptation. Neural adaptation mechanisms introduce dynamic flexibility to the otherwise stable attractor states. This extra flexibility allows A-CANNs to explain a broader range of experimental phenomena, such as traveling waves, anticipative tracking, oscillatory behavior, and Lévy flights, observed in various neural systems.

The ability of our network to align with these diverse neural encoding phenomena suggests that A-CANN may represent a general mechanism for neural information storage and processing. Specifically, neural system may combine attractor dynamics with adaptation, effectively balancing stability and flexibility. Attractor dynamics ensure stable information storage, while adaptation facilitates flexible information search and retrieval. This dynamic interplay between stability and mobility enables the neural system to maintain robust representations while efficiently adapting to new experience and environmental changes.

In conclusion, adaptation mechanisms play an important and far-reaching role in abounding the dynamical properties of standard CANNs, with profound implications. This review not only contributes to a deeper understanding of the CANN but also provides new ideas and methods for the development and application of adaptation mechanism in neural networks under a unified analysis framework. It is hoped that the research in this paper can provide some reference and inspiration for further exploration and development in related fields.

### Acknowledgments

This work was support by: Science and Technology Innovation 2030-Brain Science and Brain-inspired Intelligence Project (No. 2021ZD0200204, SW).

## Appendix A: Gaussian bump

Considering the translational-invariant connection

$$
\displaystyle J(x,x^{\prime})=\frac{J_{0}}{\sqrt{2\pi}a}\exp[-(x-x^{\prime})^{%
2}/(2a^{2})]
$$

and the Gaussian shape approximation of the bump

$$
\displaystyle U_{0}(x,t)
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle A_{u}\exp\left\{-\frac{\left[x-z(t)\right]^{2}}{4a^{2}}\right\},
$$
$$
\displaystyle V_{0}(x,t)
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle A_{v}\exp\left\{-\frac{\left[x-z(t)+s_{v}(t)\right]^{2}}{4a^{2}}%
\right\},
$$
$$
\displaystyle r_{0}(x,t)
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle A_{r}\exp\left\{-\frac{\left[x-z(t)\right]^{2}}{2a^{2}}\right\},
$$

then the network dynamics

$$
\displaystyle\tau\frac{dU(x,t)}{dt}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle-U(x,t)+\rho\int_{-\infty}^{\infty}J(x,x^{\prime})r(x^{\prime},t)%
\,dx^{\prime}-V(x,t)+I^{ext}(x,t),
$$
$$
\displaystyle r(x,t)
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\frac{U(x,t)^{2}}{1+k\rho\int_{-\infty}^{\infty}U^{2}(x^{\prime},%
t),dx^{\prime}},
$$
$$
\displaystyle\tau_{v}\frac{dV(x,t)}{dt}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle-V(x,t)+mU(x,t),
$$

can be simplified as

$$
\displaystyle A_{r}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\frac{A_{u}^{2}}{1+k\rho\sqrt{2\pi}aA_{u}^{2}},
$$
$$
\displaystyle\tau\left[A_{u}\frac{x-z}{2a^{2}}\frac{dz}{dt}+\frac{dA_{u}}{dt}%
\right]exp[-\frac{(x-z)^{2}}{4a^{2}}]
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle(-A_{u}+\frac{\rho J_{0}}{\sqrt{2}}A_{r})exp[-\frac{(x-z)^{2}}{4a%
^{2}}]
$$
 
$$
\displaystyle-A_{v}exp[-\frac{(x-z+s_{v})^{2}}{4a^{2}}]+I^{ext}(x,t),
$$
$$
\displaystyle\tau_{v}\left[A_{v}\frac{x-z+s_{v}}{2a^{2}}\frac{d(z-s_{v})}{dt}+%
\frac{dA_{v}}{dt}\right]exp[-\frac{(x-z+s_{v})^{2}}{4a^{2}}]
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle-A_{v}exp[-\frac{(x-z+s_{v})^{2}}{4a^{2}}]
$$
 
$$
\displaystyle+mA_{u}exp[-\frac{(x-z)^{2}}{4a^{2}}],
$$

## Appendix B: projection method

For the bump $U(x,t)$, the first two motion modes are,

$$
\displaystyle u_{0}(x,t)
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\exp\left\{-\frac{[x-z(t)]^{2}}{4a^{2}}\right\},
$$
$$
\displaystyle u_{1}(x,t)
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\left[x-z(t)\right]\exp\left\{-\frac{[x-z(t)]^{2}}{4a^{2}}\right\}.
$$

For the bump $V(x,t)$, the first two motion modes are,

$$
\displaystyle v_{0}(x,t)
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\exp\left\{-\frac{[x-z(t)+d(t)]^{2}}{4a^{2}}\right\},
$$
$$
\displaystyle v_{1}(x,t)
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\left[x-z(t)+d(t)\right]\exp\left\{-\frac{[x-z(t)+d(t)]^{2}}{4a^{%
2}}\right\}.
$$

Projecting network dynamics Eqs. (8) onto the first two dominant motion modes of $u$ ($\int_{-\infty}^{\infty}f(x)u(x)dx$), we obtain

$$
\displaystyle Left
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\int\tau\left[A_{u}\frac{x-z}{2a^{2}}\frac{dz}{dt}+\frac{dA_{u}}{%
dt}\right]exp\left\{-\frac{(x-z)^{2}}{2a^{2}}\right\}dx=\sqrt{2\pi}a\tau\frac{%
dA_{u}}{dt},
$$
$$
\displaystyle right
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\int(-A_{u}+\frac{\rho J_{0}}{\sqrt{2}}A_{r})exp\left\{-\frac{(x-%
z)^{2}}{2a^{2}}\right\}dx-\int A_{v}exp\left\{-\frac{(x-z+s_{v})^{2}+(x-z)^{2}%
}{4a^{2}}\right\}dx
$$
 
$$
\displaystyle+\int I^{ext}exp\left\{-\frac{(x-z)^{2}}{4a^{2}}\right\}dx,
$$
$$
\displaystyle=
$$
 
$$
\displaystyle\sqrt{2\pi}a(-A_{u}+\frac{\rho J_{0}}{\sqrt{2}}A_{r})-\sqrt{2\pi}%
aA_{v}\exp\left(-\frac{s_{v}(t)^{2}}{8a^{2}}\right)+\int I^{ext}exp\left\{-%
\frac{(x-z)^{2}}{4a^{2}}\right\}dx,
$$

for $u_{0}$, and

$$
\displaystyle Left
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\int\tau\left[A_{u}\frac{(x-z)^{2}}{2a^{2}}\frac{dz}{dt}+(x-z)%
\frac{dA_{u}}{dt}\right]exp\left\{-\frac{(x-z)^{2}}{2a^{2}}\right\}dx,
$$
$$
\displaystyle=
$$
 
$$
\displaystyle 2a^{2}\tau A_{u}\frac{dz}{dt},
$$
$$
\displaystyle right
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\int(x-z)(-A_{u}+\frac{\rho J_{0}}{\sqrt{2}}A_{r})exp\left\{-%
\frac{(x-z)^{2}}{2a^{2}}\right\}dx
$$
 
$$
\displaystyle-\int(x-z)A_{v}exp\left\{-\frac{(x-z+s_{v})^{2}+(x-z)^{2}}{4a^{2}%
}\right\}dx
$$
 
$$
\displaystyle+\int(x-z)I^{ext}exp\left\{-\frac{(x-z)^{2}}{4a^{2}}\right\}dx,
$$
$$
\displaystyle=
$$
 
$$
\displaystyle 2a^{2}s_{v}A_{v}\exp\left(-\frac{s_{v}^{2}}{8a^{2}}\right)+\int(%
x-z)I^{ext}exp\left\{-\frac{(x-z)^{2}}{4a^{2}}\right\}dx,
$$

for $u_{1}$.

We can synthesize the above equations as

$$
\displaystyle\tau\frac{dA_{u}}{dt}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle(-A_{u}+\frac{\rho J_{0}}{\sqrt{2}}A_{r})-A_{v}\exp\left(-\frac{s%
_{v}(t)^{2}}{8a^{2}}\right)+\int_{x}I^{ext}(x,t)u_{0}(x)dx,
$$
$$
\displaystyle\tau A_{u}\frac{dz}{dt}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle s_{v}(t)A_{v}\exp\left(-\frac{s_{v}(t)^{2}}{8a^{2}}\right)+\int_%
{x}I^{ext}(x,t)u_{1}(x)dx.
$$

Projecting network dynamics Eqs. (8) onto the first two dominant motion modes of $u$, we obtain

$$
\displaystyle\tau_{v}\left[A_{v}\frac{x-z+s_{v}}{2a^{2}}\frac{d(z-s_{v})}{dt}+%
\frac{dA_{v}}{dt}\right]exp[-\frac{(x-z+s_{v})^{2}}{4a^{2}}]
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle-A_{v}exp[-\frac{(x-z+s_{v})^{2}}{4a^{2}}]
$$
 
$$
\displaystyle+mA_{u}exp[-\frac{(x-z)^{2}}{4a^{2}}],
$$
 
$$
\displaystyle Left
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\int\tau_{v}\left[A_{v}\frac{x-z+s_{v}}{2a^{2}}\frac{d(z-s_{v})}{%
dt}+\frac{dA_{v}}{dt}\right]exp\left\{-\frac{(x-z+s_{v})^{2}+(x-z)^{2}}{4a^{2}%
}\right\}dx,
$$
$$
\displaystyle=
$$
 
$$
\displaystyle\sqrt{2\pi}a\tau_{v}\left[A_{v}\frac{s_{v}}{4a^{2}}\frac{d(z-s_{v%
})}{dt}+\frac{dA_{v}}{dt}\right]\exp\left(-\frac{s_{v}^{2}}{8a^{2}}\right),
$$
$$
\displaystyle right
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\int mA_{u}exp\left\{-\frac{(x-z)^{2}}{2a^{2}}\right\}dx-\int A_{%
v}exp\left\{-\frac{(x-z+s_{v})^{2}+(x-z)^{2}}{4a^{2}}\right\}dx
$$
 
$$
\displaystyle+\int I^{ext}exp\left\{-\frac{(x-z)^{2}}{4a^{2}}\right\}dx,
$$
$$
\displaystyle=
$$
 
$$
\displaystyle\sqrt{2\pi}amA_{u}-\sqrt{2\pi}aA_{v}\exp\left(-\frac{s_{v}^{2}}{8%
a^{2}}\right)+\int I^{ext}exp\left\{-\frac{(x-z)^{2}}{4a^{2}}\right\}dx,
$$

for $u_{0}$, and

$$
\displaystyle Left
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\int\tau_{v}\left[A_{v}\frac{x-z+s_{v}}{2a^{2}}\frac{d(z-s_{v})}{%
dt}+\frac{dA_{v}}{dt}\right](x-z)exp\left\{-\frac{(x-z+s_{v})^{2}+(x-z)^{2}}{4%
a^{2}}\right\}dx,
$$
$$
\displaystyle=
$$
 
$$
\displaystyle\sqrt{2\pi}a\left[\frac{s_{v}}{2}\frac{dA_{v}}{dt}-(\frac{s_{v}^{%
2}}{8a}-\sqrt{\frac{\pi}{2}}a)A_{v}\frac{d(z-s_{v})}{dt}\right]\exp\left(-%
\frac{s_{v}^{2}}{8a^{2}}\right),
$$
$$
\displaystyle right
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\int mA_{u}(x-z)exp\left\{-\frac{(x-z)^{2}}{2a^{2}}\right\}dx-%
\int A_{v}(x-z)exp\left\{-\frac{(x-z+s_{v})^{2}+(x-z)^{2}}{4a^{2}}\right\}dx
$$
 
$$
\displaystyle+\int(x-z)I^{ext}exp\left\{-\frac{(x-z)^{2}}{4a^{2}}\right\}dx,
$$
$$
\displaystyle=
$$
 
$$
\displaystyle\sqrt{2\pi}aA_{v}\frac{s_{v}}{2}\exp\left(-\frac{s_{v}^{2}}{8a^{2%
}}\right)+\int(x-z)I^{ext}exp\left\{-\frac{(x-z)^{2}}{4a^{2}}\right\}dx,
$$

for $u_{1}$.

Combine these two equations and separate $A_{v}$ and $s_{v}$ using Eq. (133), we have

$$
\displaystyle\tau_{v}\frac{dA_{v}}{dt}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle-A_{v}+mA_{u}\exp\left(-\frac{s_{v}(t)^{2}}{8a^{2}}\right),
$$
$$
\displaystyle\tau_{v}A_{v}\frac{ds_{v}}{dt}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle s_{v}(t)\exp\left(-\frac{s_{v}(t)^{2}}{8a^{2}}\right)\left(\frac%
{\tau_{v}}{\tau A_{u}}A_{v}^{2}-mA_{u}\right)+\frac{\tau_{v}A_{v}}{\tau A_{u}}%
\int_{x}I^{ext}(x,t)u_{1}(x)dx.
$$

To sum up, we get the original of Eqs. (14-17).

## Appendix C: travelling wave solution

We further analyze the condition for the network holding a continuously moving bump (travelling wave) as its stationary state. In such a state, the bump moves at a constant speed and its position is expressed as,

$$
\displaystyle z(t)=v_{int}t,
$$

where $v_{int}$ is the intrinsic speed of the network explained in Sec.3. In the travelling state, the bump height and the discrepancy $d$ is a constant. With these conditions, Eqs. (8,9) are simplified to be,

$$
\displaystyle\tau\left(A_{u}\frac{x-z}{2a^{2}}v_{int}\right)\mathcal{N}(z,2a)
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle(-A_{u}+\frac{\rho J_{0}}{\sqrt{2}}A_{r})\mathcal{N}(z,2a)-A_{v}%
\mathcal{N}(z-s_{v},2a),
$$
$$
\displaystyle\tau_{v}\left(A_{v}\frac{x-z+s_{v}}{2a^{2}}v_{int}\right)\mathcal%
{N}(z-s_{v},2a)
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle-A_{v}\mathcal{N}(z-s_{v},2a)+mA_{u}\mathcal{N}(z,2a).
$$

Projecting both sides of Eq. (142) onto the motion mode $u_{0}(x)$ (given by Eq. (10)), we obtain

$$
\displaystyle Left
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle 0,
$$
$$
\displaystyle Right
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle(-A_{u}+\frac{\rho J_{0}}{\sqrt{2}}A_{r})\sqrt{2\pi}a-A_{v}\exp(-%
\frac{s_{v}^{2}}{8a^{2}})\sqrt{2\pi}a.
$$

Equating both sides, we have

$$
-A_{u}+\frac{\rho J_{0}}{\sqrt{2}}A_{r}-A_{v}\exp(-\frac{s_{v}^{2}}{8a^{2}})=0.
$$

Similarly, projecting Eq. (142) onto the motion mode $u_{1}(x)$ (given by Eq. (11)) and equating both sides, we obtain

$$
\tau A_{u}v_{int}=s_{v}A_{v}\exp(-\frac{s_{v}^{2}}{8a^{2}}).
$$

Again, projecting both sides of Eq. (143) onto the motion modes $u_{0}(x)$ and $u_{1}(x)$, respectively, and equating both sides, we obtain

$$
\displaystyle\frac{s_{v}}{4a^{2}}\tau_{v}A_{v}\exp(-\frac{s_{v}^{2}}{8a^{2}})v%
_{int}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle-A_{v}\exp(-\frac{s_{v}^{2}}{8a^{2}})+mA_{u},
$$
$$
\displaystyle\tau_{v}(1-\frac{s_{v}^{2}}{4a^{2}})v_{int}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle s_{v}.
$$

Summarize the four equations above, overall we have

$$
\displaystyle A_{u}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\frac{\rho J_{0}}{\sqrt{2}}A_{r}-A_{v}\exp\left(-\frac{s_{v}(t)^{%
2}}{8a^{2}}\right),
$$
$$
\displaystyle\tau A_{u}v_{int}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle s_{v}(t)A_{v}\exp\left(-\frac{s_{v}(t)^{2}}{8a^{2}}\right),
$$
$$
\displaystyle A_{v}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle mA_{u}\exp\left(-\frac{s_{v}(t)^{2}}{8a^{2}}\right),
$$
$$
\displaystyle\tau_{v}A_{v}\frac{ds_{v}(t)}{dt}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle s_{v}(t)\exp\left(-\frac{s_{v}(t)^{2}}{8a^{2}}\right)\left(\frac%
{\tau_{v}}{\tau A_{u}}A_{v}^{2}-mA_{u}\right),
$$

Combining the above equations with Eq. (7), we can analytically solve the five unknown parameters in travelling wave state:

$$
\displaystyle A_{u}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\frac{\rho J_{0}+\sqrt{\rho^{2}J_{0}^{2}-8\sqrt{2\pi}k\rho a(1+%
\sqrt{\frac{m\tau}{\tau_{v}}})^{2}}}{4\sqrt{\pi}k\rho a(1+\sqrt{\frac{m\tau}{%
\tau_{v}}})},
$$
$$
\displaystyle A_{v}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\frac{\rho J_{0}+\sqrt{\rho^{2}J_{0}^{2}-8\sqrt{2\pi}k\rho a(1+%
\sqrt{\frac{m\tau}{\tau_{v}}})^{2}}}{2\sqrt{2\pi}k\rho^{2}aJ_{0}},
$$
$$
\displaystyle A_{r}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\sqrt{\frac{m\tau}{\tau_{v}}}\exp\left[\frac{1-\sqrt{\frac{\tau}{%
m\tau_{v}}}}{2}\right]\frac{\rho J_{0}+\sqrt{\rho^{2}J_{0}^{2}-8\sqrt{2\pi}k%
\rho a(1+\sqrt{\frac{m\tau}{\tau_{v}}})^{2}}}{4\sqrt{\pi}k\rho a(1+\sqrt{\frac%
{m\tau}{\tau_{v}}})},
$$
$$
\displaystyle s_{v}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle 2a\sqrt{1-\sqrt{\frac{\tau}{m\tau_{v}}}},
$$
$$
\displaystyle v_{int}
$$
 
$$
\displaystyle=
$$
 
$$
\displaystyle\frac{2a}{\tau_{v}}\sqrt{\frac{m\tau_{v}}{\tau}-\sqrt{\frac{m\tau%
_{v}}{\tau}}}.
$$

[^1]: John J Hopfield. Neural networks and physical systems with emergent collective computational abilities. Proceedings of the national academy of sciences, 79(8):2554–2558, 1982.

[^2]: Shun-ichi Amari. Dynamics of pattern formation in lateral-inhibition type neural fields. Biological cybernetics, 27(2):77–87, 1977.

[^3]: Bard Ermentrout. Neural networks as spatio-temporal pattern-forming systems. Reports on progress in physics, 61(4):353, 1998.

[^4]: Paul C Bressloff. Spatiotemporal dynamics of continuum neural fields. Journal of Physics A: Mathematical and Theoretical, 45(3):033001, 2011.

[^5]: Rani Ben-Yishai, R Lev Bar-Or, and Haim Sompolinsky. Theory of orientation tuning in visual cortex. Proceedings of the National Academy of Sciences, 92(9):3844–3848, 1995.

[^6]: Francesco P Battaglia and Alessandro Treves. Attractor neural networks storing multiple space representations: a model for hippocampal place fields. Physical Review E, 58(6):7738, 1998.

[^7]: Simona Doboli, Ali A Minai, and Phillip J Best. Latent attractors: a model for context-dependent place representations in the hippocampus. Neural Computation, 12(5):1009–1043, 2000.

[^8]: John Conklin and Chris Eliasmith. A controlled attractor network model of path integration in the rat. Journal of computational neuroscience, 18:183–203, 2005.

[^9]: Mark C Fuhs and David S Touretzky. A spin glass model of path integration in rat medial entorhinal cortex. Journal of Neuroscience, 26(16):4266–4276, 2006.

[^10]: Boris Gutkin and Fleur Zeldenrust. Spike frequency adaptation. Scholarpedia, 9(2):30643, 2014.

[^11]: Larry F Abbott, JA Varela, Kamal Sen, and SB Nelson. Synaptic depression and cortical gain control. Science, 275(5297):221–224, 1997.

[^12]: Misha Tsodyks, Klaus Pawelzik, and Henry Markram. Neural networks with dynamic synapses. Neural computation, 10(4):821–835, 1998.

[^13]: Henry Markram, Yun Wang, and Misha Tsodyks. Differential signaling via the same axon of neocortical pyramidal neurons. Proceedings of the National Academy of Sciences, 95(9):5323–5328, 1998.

[^14]: Yuanyuan Mi, CC Fung, KY Wong, and Si Wu. Spike frequency adaptation implements anticipative tracking in continuous attractor neural networks. Advances in neural information processing systems, 27, 2014.

[^15]: CC Alan Fung, KY Michael Wong, He Wang, and Si Wu. Dynamical synapses enhance neural information processing: gracefulness, accuracy, and mobility. Neural computation, 24(5):1147–1185, 2012.

[^16]: Simon J Mitchell and R Angus Silver. Shunting inhibition modulates neuronal gain during synaptic excitation. Neuron, 38(3):433–445, 2003.

[^17]: CC Alan Fung, KY Michael Wong, and Si Wu. A moving bump in a continuous manifold: a comprehensive study of the tracking dynamics of continuous attractor neural networks. Neural Computation, 22(3):752–792, 2010.

[^18]: Si Wu, Kosuke Hamaguchi, and Shun-ichi Amari. Dynamics and computation of continuous attractors. Neural computation, 20(4):994–1025, 2008.

[^19]: Aaron G Blankenship and Marla B Feller. Mechanisms underlying spontaneous patterned activity in developing neural circuits. Nature Reviews Neuroscience, 11(1):18–29, 2010.

[^20]: Chiayu Chiu and Michael Weliky. Spontaneous activity in developing ferret visual cortex in vivo. Journal of Neuroscience, 21(22):8906–8914, 2001.

[^21]: Lawrence M Ward. Synchronous neural oscillations and cognitive processes. Trends in cognitive sciences, 7(12):553–559, 2003.

[^22]: David Dupret, Joseph O’neill, Barty Pleydell-Bouverie, and Jozsef Csicsvari. The reorganization and reactivation of hippocampal maps predict spatial memory performance. Nature neuroscience, 13(8):995–1002, 2010.

[^23]: Margaret F Carr, Shantanu P Jadhav, and Loren M Frank. Hippocampal replay in the awake state: a potential substrate for memory consolidation and retrieval. Nature neuroscience, 14(2):147–153, 2011.

[^24]: Georg Northoff and Niall W Duncan. How do abnormalities in the brain’s spontaneous activity translate into symptoms in schizophrenia? from an overview of resting state activity findings to a proposed spatiotemporal psychopathology. Progress in neurobiology, 145:26–45, 2016.

[^25]: Miao Chang, Elliot K Edmiston, Fay Y Womer, Qian Zhou, Shengnan Wei, Xiaowei Jiang, Yifang Zhou, Yuting Ye, Haiyan Huang, Xi-Nian Zuo, et al. Spontaneous low-frequency fluctuations in the neural system for emotional perception in major psychiatric disorders: amplitude similarities and differences across frequency bands. Journal of Psychiatry and Neuroscience, 44(2):132–141, 2019.

[^26]: Stephen Coombes, Peter beim Graben, Roland Potthast, and James Wright. Neural fields: theory and applications. Springer, 2014.

[^27]: Si Wu, KY Michael Wong, CC Alan Fung, Yuanyuan Mi, and Wenhao Zhang. Continuous attractor neural networks: candidate of a canonical model for neural information representation. F1000Research, 5, 2016.

[^28]: Heiko J Luhmann, Anne Sinning, Jenq-Wei Yang, Vicente Reyes-Puerta, Maik C Stüttgen, Sergei Kirischuk, and Werner Kilb. Spontaneous neuronal activity in developing neocortical networks: from single cells to large-scale interactions. Frontiers in neural circuits, 10:40, 2016.

[^29]: Anish Mitra and Marcus E Raichle. How networks communicate: propagation patterns in spontaneous brain activity. Philosophical Transactions of the Royal Society B: Biological Sciences, 371(1705):20150546, 2016.

[^30]: Oscar Herreras, C Largo, Jo& M Ibarz, GG Somjen, and R Martin del Rio. Role of neuronal synchronizing mechanisms in the propagation of spreading depression in the in vivo hippocampus. Journal of Neuroscience, 14(11):7087–7098, 1994.

[^31]: Martin Both, Florian Bähner, Oliver von Bohlen und Halbach, and Andreas Draguhn. Propagation of specific network patterns through the mouse hippocampus. Hippocampus, 18(9):899–908, 2008.

[^32]: Si Wu and Shun-ichi Amari. Computing with continuous attractors: stability and online aspects. Neural computation, 17(10):2215–2239, 2005.

[^33]: K Wong, He Wang, Si Wu, and Chi Fung. Attractor dynamics with synaptic depression. Advances in Neural Information Processing Systems, 23, 2010.

[^34]: Alexei Samsonovich and Bruce L McNaughton. Path integration and cognitive mapping in a continuous attractor neural network model. Journal of Neuroscience, 17(15):5900–5920, 1997.

[^35]: Hugh T Blair and Patricia E Sharp. Anticipatory head direction signals in anterior thalamus: evidence for a thalamocortical circuit that integrates angular head motion to compute head direction. Journal of Neuroscience, 15(9):6260–6270, 1995.

[^36]: Kechen Zhang. Representation of spatial orientation by the intrinsic dynamics of the head-direction cell ensemble: a theory. Journal of Neuroscience, 16(6):2112–2126, 1996.

[^37]: David G Luenberger. Introduction to dynamic systems: theory, models, and applications, volume 1. Wiley New York, 1979.

[^38]: Stefanos E Folias and Paul C Bressloff. Breathing pulses in an excitatory neural network. SIAM Journal on Applied Dynamical Systems, 3(3):378–407, 2004.

[^39]: Tianhao Chu, Zilong Ji, Junfeng Zuo, Wenhao Zhang, Tiejun Huang, Yuanyuan Mi, and Si Wu. Oscillatory tracking of continuous attractor neural networks account for phase precession and procession of hippocampal place cells. Advances in Neural Information Processing Systems, 35:33159–33172, 2022.

[^40]: Gergő Orbán, Pietro Berkes, József Fiser, and Máté Lengyel. Neural variability and sampling-based probabilistic representations in the visual cortex. Neuron, 92(2):530–543, 2016.

[^41]: Yang Qi and Pulin Gong. Fractional neural sampling as a theory of spatiotemporal probabilistic computations in neural circuits. Nature communications, 13(1):4572, 2022.

[^42]: Ralf M Haefner, Pietro Berkes, and József Fiser. Perceptual decision-making as probabilistic inference by neural sampling. Neuron, 90(3):649–660, 2016.

[^43]: Frederic Bartumeus. Lévy processes in animal movement: an evolutionary hypothesis. Fractals, 15(02):151–162, 2007.

[^44]: George E Uhlenbeck and Leonard S Ornstein. On the theory of the brownian motion. Physical review, 36(5):823, 1930.

[^45]: RJ Rivers. Path integral methods in quantum field theory. Cambridge University Press, 1988.

[^46]: Xingsi Dong, Tianhao Chu, Tiejun Huang, Zilong Ji, and Si Wu. Noisy adaptation generates lévy flights in attractor neural networks. Advances in Neural Information Processing Systems, 34:16791–16804, 2021.

[^47]: Gandhimohan M Viswanathan, Vsevolod Afanasyev, Sergey V Buldyrev, Eugene J Murphy, Peter A Prince, and H Eugene Stanley. Lévy flight search patterns of wandering albatrosses. Nature, 381(6581):413–415, 1996.

[^48]: Frederic Bartumeus, M G E da Luz, Gandhimohan M Viswanathan, and Jordi Catalan. Animal search strategies: a quantitative random-walk analysis. Ecology, 86(11):3078–3087, 2005.

[^49]: Andrew M Reynolds. Scale-free animal movement patterns: Lévy walks outperform fractional brownian motions and fractional lévy motions in random search scenarios. Journal of Physics A: Mathematical and Theoretical, 42(43):434006, 2009.

[^50]: Theo Rhodes and Michael T Turvey. Human memory retrieval as lévy foraging. Physica A: Statistical Mechanics and its Applications, 385(1):255–260, 2007.

[^51]: Tommaso Costa, Giuseppe Boccignone, Franco Cauda, and Mario Ferraro. The foraging brain: Evidence of lévy dynamics in brain networks. PloS one, 11(9):e0161702, 2016.

[^52]: Brad E Pfeiffer and David J Foster. Autoassociative dynamics in the generation of sequences of hippocampal place cells. Science, 349(6244):180–183, 2015.