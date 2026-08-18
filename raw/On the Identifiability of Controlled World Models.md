---
title: "On the Identifiability of Controlled World Models"
source: "https://arxiv.org/abs/2607.22430"
author:
  - "[[Xiangteng Zhang]]"
  - "[[Yang Guan]]"
  - "[[Bo Zhang]]"
  - "[[Hongyang Li]]"
  - "[[Ya-Qin Zhang]]"
  - "[[Shengbo Eben Li]]"
published: 2026-07-24
created: 2026-08-11
description: "Joint identifiability theory for action-conditioned (LeJEPA-style) world models. Setting: invertible observation map g, LINEAR-GAUSSIAN latent dynamics z_{t+1} = A z_t + B a_t + xi_t, stationary z ~ N(0,I_d), encoder constrained to h(x_t) ~ N(0,I_d), squared-loss predictor F(h(x_t), a_t) targeting the conditional mean. ACTIONS ARE OBSERVED INPUTS - nothing here infers an action alphabet. Two margins: representation margin gamma_rep(pi) = lambda_min(R_pi) - lambda_max(R_pi)^2 with R_pi = Cov(A z_t + B a_t); transition margin rho_tr(pi) = lambda_min(E_z[Cov_pi(a_t | z_t)]) - the weakest conditional action excitation, a property of the BEHAVIOR POLICY. Main theorem is SUFFICIENT (if both margins > 0 then every global minimizer identifies latent state and controlled conditional mean up to an orthogonal Q), not iff. Theorem 2: encoder excess risk Delta_enc relative to gamma_rep controls deviation from Q z_t (eta = Delta_enc/gamma_rep, valid only when Delta_enc <= c gamma_rep). Theorem 3: an ATTAINABLE counterfactual-error amplification growing as 1/sigma^2, diverging in the deterministic-policy limit. Empirically: at sigma = 0 on-policy prediction stays accurate while counterfactual error is large and A and B are not separately identifiable. Stated limits: invertible observations, linear-Gaussian dynamics, exact representation constraint, conditional mean only, population (not finite-sample). Also proves state-only prediction recovers the behavior-policy-averaged future and does NOT identify how alternative actions change the next state. Experiments are synthetic: four nonlinear observation maps, five runs. Unreviewed arXiv preprint (v2), arXiv:2607.22430."
tags:
  - "clippings"
  - "identifiability"
  - "world-models"
  - "jepa"
  - "exploration"
  - "counterfactual"
---

Title: On the Identifiability of Controlled World Models
Venue: arXiv preprint (v2, 2026-07-27); no peer review at time of ingest. Text below extracted from the arXiv v2 HTML.


## On the Identifiability of Controlled World Models

World model serves as a promising tool to infer environment dynamics under high-dimensional observations and candidate actions.
Recently, LeCun’s JEPA provides a compelling framework for learning such models in representation space.
Its action-conditioned extension plays a central role in visual control and latent-space planning, but leaves a fundamental question: can it recover the controlled dynamics from nonlinear observations?
This paper presents a joint identifiability condition for controlled world models with Gaussian latent states, which consists of two coupled components: (1) representation identifiability and (2) transition identifiability.
The former depends on the spectral separation property while the latter is related to non-degenerate variation of conditional action.
We prove that when this condition holds, minimizing the LeJEPA-style predictive objective can recover both latent states and controlled dynamics in the sense of orthogonal transformation.
We further prove that the upper bound of transition prediction error is inversely proportional to the spectral separation margin.
We also characterize an attainable amplification of counterfactual prediction error that scales inversely with the weakest conditional action-excitation margin.
The theoretical predictions are empirically supported across four nonlinear observation settings.

## 1 Introduction

Figure 1: Overview of controlled world-model identifiability. An encoder maps nonlinear observations to a standard-Gaussian latent representation, and an action-conditioned predictor models the next representation. Representation identifiability is governed by a predictable-signal spectral margin, while transition identifiability additionally depends on the weakest conditional action excitation.

World models seek to capture how an environment evolves, enabling an agent to anticipate future states, simulate the consequences of its behavior, and support decision-making and planning through a latent predictive model. They have become increasingly important in developing physics-native intelligence, including embodied robotics, autonomous driving, and physical data generation. In general, world models encode images, videos, or sensory measurements into compact state representations and learn environmental dynamics in the latent space. Such representations can subsequently support behavior prediction, policy learning, value estimation, and trajectory optimization. In control settings, these capabilities require a model that captures how the future state varies across candidate actions.

Controlled world models are defined as a class of world models characterized by latent transition predictor conditioned on both the current latent state and the action candidates.
By explicitly relating states, actions, and future states, they provide the structure needed to compare candidate actions, evaluate counterfactual outcomes, and support model-based planning.
A prominent framework for learning such models from high-dimensional observations is the Joint-Embedding Predictive Architecture (JEPA), which trains model parameters by minimizing the prediction error between two temporally related observations. Meanwhile, it uses regularization or distributional constraints on the latent space to prevent representational collapse (LeCun 2022 ; Assran et al. 2023 ; Bardes et al. 2024 ; Balestriero and LeCun 2025 ) . Recent methods such as LeWorldModel and V-JEPA 2-AC incorporate actions into latent prediction and have demonstrated promising performance in visual control, policy learning, and latent-space planning (Assran and others 2025 ; Hafner et al. 2025 ; Zhan et al. 2025a ; Maes et al. 2026 ) .
Despite these empirical advances, existing results do not establish whether controlled world models can correctly identify both the latent state representation and the underlying transition dynamics. This question, which we refer to as the identifiability problem of controlled world models, remains theoretically underexplored.

Theoretical analysis of dynamical systems from data has advanced primarily in settings where system states can be directly observed. Recent work in data-driven control has examined controllability from sampled transitions (Yang et al. 2024a ) , stability certification from finite data (Yang et al. 2024b ) , and canonical representations of transition data (Zhan et al. 2025b ) . These studies characterize system properties and transition structure from data, but presuppose a fixed and observed state coordinate system. Controlled world models do not have access to such coordinates because the latent state must itself be inferred from nonlinear observations. This additional ambiguity gives rise to two coupled identification problems. Representation identifiability concerns whether the encoder identifies the latent state, which is generally impossible without additional structure (Locatello et al. 2019 ; Khemakhem et al. 2020 ; Hyvärinen et al. 2024 ) . Under Gaussian assumptions, recent LeJEPA theory establishes representation identifiability up to an orthogonal transformation (Klindt et al. 2026 ) , yet leaves the controlled transition unidentified. Transition identifiability concerns whether the predictor identifies the controlled dynamics. Classical system identification emphasizes the need for informative action variation, often formalized through persistent excitation (Willems et al. 2005 ) , but assumes direct access to state coordinates and therefore does not address representation identification. These two lines of theory address complementary parts of the problem, but neither establishes when action-conditioned latent prediction jointly identifies the state representation and controlled dynamics.

In this paper, we fill the gap by developing a systematic identifiability theory for controlled world models under nonlinear observations. Representation identifiability is characterized by a spectral separation property of the predictable signal induced by the behavior policy, whereas transition identifiability is governed by the non-degeneracy of conditional action variation given the current state. Under controlled spectral separation and sufficient conditional action excitation, we prove that every global minimizer of the population objective identifies the true latent state and the full controlled conditional-mean dynamics under a common orthogonal transformation. We then establish quantitative identifiability guarantees in the presence of encoder excess risk and predictor error. Our analysis further shows that conditional action excitation determines the strength of transition identification: weakly excited action directions can admit small training error while producing substantially larger errors in counterfactual action responses. Finally, we connect the identified transition model to goal-conditioned latent planning and empirically examine how action coverage affects representation identifiability, transition identifiability, counterfactual prediction, and planning across nonlinear observation maps and behavior policies.

Our main contributions are summarized as follows:

• We establish sufficient conditions for joint representation and transition identifiability in controlled world models with invertible nonlinear observations and linear Gaussian latent dynamics. Representation identifiability is guaranteed under a spectral separation condition jointly determined by the controlled dynamics and behavior policy, whereas transition identification over the full state-action space is guaranteed under positive conditional action excitation. Together, these conditions guarantee recovery of the latent state and the controlled conditional mean up to a common orthogonal transformation.

We establish sufficient conditions for joint representation and transition identifiability in controlled world models with invertible nonlinear observations and linear Gaussian latent dynamics. Representation identifiability is guaranteed under a spectral separation condition jointly determined by the controlled dynamics and behavior policy, whereas transition identification over the full state-action space is guaranteed under positive conditional action excitation. Together, these conditions guarantee recovery of the latent state and the controlled conditional mean up to a common orthogonal transformation.

• We derive quantitative identification guarantees under imperfect optimization by using a Hermite decomposition of the learned representation, and show that the upper bounds on transition prediction error scale inversely with the spectral separation margin, while predictor approximation error enters the transition bound additively.

We derive quantitative identification guarantees under imperfect optimization by using a Hermite decomposition of the learned representation, and show that the upper bounds on transition prediction error scale inversely with the spectral separation margin, while predictor approximation error enters the transition bound additively.

• We characterize the attainable amplification of counterfactual prediction error by perturbing the predictor along the least excited action direction, and show that the amplification factor is inversely proportional to the weakest conditional action-excitation margin.

We characterize the attainable amplification of counterfactual prediction error by perturbing the predictor along the least excited action direction, and show that the amplification factor is inversely proportional to the weakest conditional action-excitation margin.

## 2 Related Work

## Latent world models for planning.

World models have been widely studied as internal predictive models for planning and control.
Early neural world models learned compact latent dynamics for imagination-based policy learning (Ha and Schmidhuber 2018 ; Hafner et al. 2019 ; Mu et al. 2020 ) , while later model-based reinforcement learning methods developed probabilistic latent dynamics, value-aware dynamics, and model-predictive control (Hansen et al. 2022 , 2024 ; Zhan et al. 2025a ; Li 2023 ) in learned state spaces (Hafner et al. 2020 , 2025 ; Schrittwieser et al. 2020 ) .
These results establish that learned latent dynamics can be useful for planning, but not that the learned state or controlled transition is identifiable from nonlinear observations.
Our work targets this missing structural question: when does a latent world model identify both the state and the controlled conditional-mean transition?

## Joint embedding predictive learning and latent prediction.

Joint embedding predictive architectures learn by predicting target representations rather than reconstructing pixels, making them attractive for representation learning and latent world modeling (Assran and others 2025 ; Bardes et al. 2024 ) .
Recent world models extend this principle to latent dynamics without pixel reconstruction, while using regularization or target encoders to prevent representational collapse (Balestriero and LeCun 2025 ; Maes et al. 2026 ) .
Under Gaussian latent assumptions, recent theory for LeJEPA shows that prediction from passive observation pairs can recover latent states up to an orthogonal transformation, but does not establish identifiability of dynamics conditioned on actions (Klindt et al. 2026 ) .
We study this controlled setting and show that, when data are generated by a behavior policy, representation recovery and controlled transition recovery are characterized by distinct identifiability margins.

## Action-conditioned and latent-action world models.

A growing body of work incorporates actions into latent world models so that different candidate actions induce different predicted futures.
This includes action-conditioned predictors for robot planning, end-to-end latent world models with action-sensitive objectives, and latent-action models that infer abstract actions from videos or visual feature differences (Assran and others 2025 ; Maes et al. 2026 ) .
These methods reflect an important shift from passive future prediction to controlled prediction, where the model is expected to represent how the world responds to alternative actions.
However, action conditioning is usually justified empirically, through action sensitivity, rollout quality, or downstream planning performance.
The gap is not whether actions can be inserted into latent predictors, but when action-conditioned prediction makes the action effect itself identifiable.

## Identifiability and system identification.

Identifiability is a central difficulty in nonlinear representation learning.
Classical results in nonlinear ICA and unsupervised disentanglement show that latent variables are generally not identifiable from nonlinear observations without additional assumptions or structural signals (Hyvärinen and Pajunen 1999 ; Locatello et al. 2019 ) .
Positive identifiability results introduce such structure through temporal dependence, auxiliary variables, conditional latent distributions, or interventions (Hyvarinen and Morioka 2016 ; Hyvarinen et al. 2019 ; Khemakhem et al. 2020 ; Schölkopf et al. 2021 ; von Kügelgen et al. 2023 ; Varici et al. 2024 ) .
In parallel, classical system identification emphasizes that identifying controlled dynamics requires sufficiently informative inputs, often formalized through persistent excitation or related rank conditions (Van Overschee and De Moor 1996 ; Willems et al. 2005 ) .
These literatures cover complementary pieces of the problem, but neither directly gives identifiability for controlled world models: representation-learning results usually do not identify controlled transitions, while system-identification results often assume observed or linearly measured states.
Our analysis combines the two perspectives under nonlinear observations, showing when sufficient conditional action excitation and a representation-identifiability spectral condition make the representation and controlled conditional-mean transition jointly identifiable.

## 3 Method

## 3.1 Problem Formulation

We formulate controlled latent prediction to separate two identification problems that are entangled in observations: identifying a valid state coordinate and identifying how that state responds to actions. An action-conditioned predictor is necessary because a state-only predictor sees only the transition averaged over the behavior policy; however, conditioning on the action is informative only to the extent that the data contain action variation conditional on the state.

## World and behavior distribution.

Let z t ∈ ℝ d z_{t}\in\mathbb{R}^{d} be the latent state and x t = g ​ ( z t ) x_{t}=g(z_{t}) its observation under an unknown invertible map g g . Invertibility isolates the representation problem from information loss in the observation process: the learner must undo a nonlinear change of coordinates, but the observation still contains the full state. Trajectories are collected under a behavior policy π ​ ( a t ∣ z t ) \pi(a_{t}\mid z_{t}) , which, together with the environment, induces the training distribution P π P_{\pi} . Making this distribution explicit is essential because transition identification depends on the policy’s conditional action support.

We use a stationary linear–Gaussian latent system as the minimal setting in which these effects can be analyzed exactly. Gaussianity gives a tractable spectral decomposition and is compatible with the standard-Gaussian representation constraint; linear controlled dynamics keep state and action effects separate; and stationarity provides a common marginal distribution across consecutive representations.

The latent state satisfies z t ∼ 𝒩 ​ ( 0 , I d ) z_{t}\sim\mathcal{N}(0,I_{d}) , and the behavior policy induces a centered jointly Gaussian distribution P π ​ ( z t , a t ) P_{\pi}(z_{t},a_{t}) . The state and action may be dependent, and the conditional action covariance may be singular.

The latent dynamics are z t + 1 = A ​ z t + B ​ a t + ξ t z_{t+1}=Az_{t}+Ba_{t}+\xi_{t} , where ξ t \xi_{t} is zero-mean Gaussian noise independent of ( z t , a t ) (z_{t},a_{t}) . The process is stationary with z t + 1 ∼ 𝒩 ​ ( 0 , I d ) z_{t+1}\sim\mathcal{N}(0,I_{d}) .

## Learner.

The learner consists of an encoder h : 𝒳 → ℝ d h:\mathcal{X}\to\mathbb{R}^{d} and a deterministic action-conditioned predictor F F . We study its population objective, defined as the expected prediction loss under the stationary data-generating distribution P π P_{\pi} induced by the behavior policy:

[TABLE] ℒ π ​ ( h , F ) = 𝔼 P π ​ [ ‖ h ​ ( x t + 1 ) − F ​ ( h ​ ( x t ) , a t ) ‖ 2 2 ] . \mathcal{L}_{\pi}(h,F)=\mathbb{E}_{P_{\pi}}\left[\|h(x_{t+1})-F(h(x_{t}),a_{t})\|_{2}^{2}\right]. (1)

The squared loss makes the predictor target the conditional mean in representation space rather than the full conditional distribution. We constrain h ​ ( x t ) ∼ 𝒩 ​ ( 0 , I d ) h(x_{t})\sim\mathcal{N}(0,I_{d}) , as in LeJEPA-style Gaussian regularization, to prevent collapse and fix the representation scale while retaining the unavoidable rotational symmetry of the latent distribution.

For every admissible encoder h h , the predictor class can realize the optimal conditional-mean predictor F h ⋆ ​ ( h ​ ( x t ) , a t ) := 𝔼 ​ [ h ​ ( x t + 1 ) ∣ h ​ ( x t ) , a t ] F_{h}^{\star}(h(x_{t}),a_{t}):=\mathbb{E}[h(x_{t+1})\mid h(x_{t}),a_{t}] .
The learned predictor is continuous in its representation and action inputs.

## 3.2 Identifiability of Controlled World Models

## Representation identifiability.

We define representation identifiability as the existence of an orthogonal matrix Q ∈ O ​ ( d ) Q\in O(d) such that

[TABLE] h ​ ( g ​ ( z ) ) = Q ​ z . h(g(z))=Qz.

This defines latent-state identifiability up to an orthogonal transformation.

## Transition identifiability.

We define transition identifiability under P π P_{\pi} as

[TABLE] F ​ ( y , a ) = Q ​ A ​ Q ⊤ ​ y + Q ​ B ​ a F(y,a)=QAQ^{\top}y+QBa

This definition can also be denoted as F ​ ( h ​ ( g ​ ( z ) ) , a ) = Q ​ ( A ​ z + B ​ a ) F(h(g(z)),a)=Q(Az+Ba) . This concerns the controlled conditional mean in the identified coordinates.

## Identification margins.

Representation identifiability is governed by the predictable signal available under the behavior policy:

[TABLE] R π \displaystyle R_{\pi} := Cov P π ⁡ ( 𝔼 ​ [ z t + 1 ∣ z t , a t ] ) = Cov P π ⁡ ( A ​ z t + B ​ a t ) , \displaystyle=\operatorname{Cov}_{P_{\pi}}\!\left(\mathbb{E}[z_{t+1}\mid z_{t},a_{t}]\right)=\operatorname{Cov}_{P_{\pi}}(Az_{t}+Ba_{t}), (2) γ rep ​ ( π ) \displaystyle\gamma_{\mathrm{rep}}(\pi) := λ min ​ ( R π ) − λ max ​ ( R π ) 2 . \displaystyle=\lambda_{\min}(R_{\pi})-\lambda_{\max}(R_{\pi})^{2}.

Stationarity gives Cov ⁡ ( ξ t ) = I d − R π ⪰ 0 \operatorname{Cov}(\xi_{t})=I_{d}-R_{\pi}\succeq 0 . The representation margin γ rep ​ ( π ) \gamma_{\mathrm{rep}}(\pi) compares the weakest first-order predictable direction with the strongest higher-order nonlinear alternative.

Transition identifiability is governed by the action variation that remains after conditioning on the current state:

[TABLE] Σ tr ​ ( π ) \displaystyle\Sigma_{\mathrm{tr}}(\pi) := 𝔼 z t ​ [ Cov π ⁡ ( a t ∣ z t ) ] , \displaystyle=\mathbb{E}_{z_{t}}\!\left[\operatorname{Cov}_{\pi}(a_{t}\mid z_{t})\right], (3) ρ tr ​ ( π ) \displaystyle\rho_{\mathrm{tr}}(\pi) := λ min ​ ( Σ tr ​ ( π ) ) . \displaystyle=\lambda_{\min}\!\left(\Sigma_{\mathrm{tr}}(\pi)\right).

The transition margin ρ tr ​ ( π ) \rho_{\mathrm{tr}}(\pi) is the weakest conditional action excitation. Under the jointly Gaussian behavior model, Cov π ⁡ ( a t ∣ z t ) \operatorname{Cov}_{\pi}(a_{t}\mid z_{t}) does not depend on z t z_{t} ; hence, ρ tr ​ ( π ) > 0 \rho_{\mathrm{tr}}(\pi)>0 gives full conditional support over the action space.

The two margins address different failure modes. A positive γ rep ​ ( π ) \gamma_{\mathrm{rep}}(\pi) separates the latent coordinates from nonlinear predictive features. A positive ρ tr ​ ( π ) \rho_{\mathrm{tr}}(\pi) distinguishes the controlled response in every action direction and gives full support to the joint Gaussian state-action distribution. Together with continuity of F F , this support extends transition identification from an almost-sure statement under P π P_{\pi} to the entire state-action space.

We can now state the main identification result. In the Gaussian setting, the eigenvalues of R π R_{\pi} determine the predictability of the first-order latent components, whereas any higher-order component has predictable energy at most λ max ​ ( R π ) 2 \lambda_{\max}(R_{\pi})^{2} . A positive representation margin therefore makes every true latent direction more predictable than any nonlinear alternative.

Suppose Assumptions 1 – 3 hold and the observation map g g is invertible. Consider the objective in Eq. ( 1 ) over encoders satisfying h ​ ( x t ) ∼ 𝒩 ​ ( 0 , I d ) h(x_{t})\sim\mathcal{N}(0,I_{d}) . If

[TABLE] γ rep ​ ( π ) > 0 and ρ tr ​ ( π ) > 0 , \gamma_{\mathrm{rep}}(\pi)>0\qquad\text{and}\qquad\rho_{\mathrm{tr}}(\pi)>0,

then every global minimizer ( h , F ) (h,F) of ℒ π \mathcal{L}_{\pi} identifies the latent state and the controlled conditional mean up to an orthogonal transformation. Specifically, there exists Q ∈ O ​ ( d ) Q\in O(d) such that

[TABLE] h ​ ( g ​ ( z t ) ) = Q ​ z t , \displaystyle h(g(z_{t}))=Qz_{t}, F ​ ( h ​ ( g ​ ( z t ) ) , a t ) = Q ​ ( A ​ z t + B ​ a t ) , a.s. \displaystyle F(h(g(z_{t})),a_{t})=Q(Az_{t}+Ba_{t}),\quad\text{a.s.}

Moreover, in the identified coordinates, the predictor satisfies F ​ ( y , a ) = Q ​ A ​ Q ⊤ ​ y + Q ​ B ​ a F(y,a)=QAQ^{\top}y+QBa for every ( y , a ) ∈ ℝ d × ℝ m (y,a)\in\mathbb{R}^{d}\times\mathbb{R}^{m} .

The optimal objective value is tr ⁡ ( Cov ⁡ ( ξ t ) ) = d − tr ⁡ ( R π ) \operatorname{tr}(\operatorname{Cov}(\xi_{t}))=d-\operatorname{tr}(R_{\pi}) .
Conversely, for any Q ∈ O ​ ( d ) Q\in O(d) , the encoder defined by h Q ​ ( g ​ ( z ) ) = Q ​ z h_{Q}(g(z))=Qz and the predictor F Q ​ ( y , a ) = Q ​ A ​ Q ⊤ ​ y + Q ​ B ​ a F_{Q}(y,a)=QAQ^{\top}y+QBa attain this minimum.

The theorem separates two identification problems that are often conflated. The representation margin rules out nonlinear reparameterizations and identifies the latent state up to an orthogonal transformation. Conditional action excitation then identifies how that state responds to every action. Positive excitation gives full state-action support; together with continuity of F F , this upgrades an almost-sure on-policy statement to identification over the entire state-action space.

## Proof sketch.

For a fixed encoder, squared loss is minimized by the conditional mean of h ​ ( x t + 1 ) h(x_{t+1}) given ( h ​ ( x t ) , a t ) (h(x_{t}),a_{t}) . Minimizing prediction risk is thus equivalent to maximizing the predictable energy of the representation. Expand h ∘ g h\circ g in the Gaussian Hermite basis. First-order components are governed by the eigenvalues of R π R_{\pi} , while every higher-order component contributes at most λ max ​ ( R π ) 2 \lambda_{\max}(R_{\pi})^{2} times its variance. When γ rep ​ ( π ) > 0 \gamma_{\mathrm{rep}}(\pi)>0 , an optimum can therefore contain only first-order components. The Gaussian constraint makes the resulting linear map orthogonal, so h ​ ( g ​ ( z ) ) = Q ​ z h(g(z))=Qz . Substitution into the dynamics yields the predictor Q ​ ( A ​ z + B ​ a ) Q(Az+Ba) ; positive conditional excitation and continuity extend the identity to every ( y , a ) ∈ ℝ d × ℝ m (y,a)\in\mathbb{R}^{d}\times\mathbb{R}^{m} . The full proof appears in the first proof section of the appendix.

## 3.3 Approximate Identifiability

The preceding result assumes exact global optimality. To quantify graceful degradation away from this ideal, let F h ⋆ ​ ( h ​ ( x t ) , a t ) := 𝔼 ​ [ h ​ ( x t + 1 ) ∣ h ​ ( x t ) , a t ] F_{h}^{\star}(h(x_{t}),a_{t}):=\mathbb{E}[h(x_{t+1})\mid h(x_{t}),a_{t}] denote its optimal conditional-mean predictor, and let ℒ ⋆ := d − tr ⁡ ( R π ) \mathcal{L}^{\star}:=d-\operatorname{tr}(R_{\pi}) denote the minimum risk in Theorem 1 . We separate error due to the representation from error due to the learned predictor by defining Δ enc := ℒ π ​ ( h , F h ⋆ ) − ℒ ⋆ \Delta_{\rm enc}:=\mathcal{L}_{\pi}(h,F_{h}^{\star})-\mathcal{L}^{\star} and the predictor-side error as Δ pred := 𝔼 P π ​ ‖ F ​ ( h ​ ( x t ) , a t ) − F h ⋆ ​ ( h ​ ( x t ) , a t ) ‖ 2 \Delta_{\rm pred}:=\mathbb{E}_{P_{\pi}}\|F(h(x_{t}),a_{t})-F_{h}^{\star}(h(x_{t}),a_{t})\|^{2} .

Suppose the conditions of Theorem 1 hold except that ( h , F ) (h,F) need not be a global minimizer of ℒ π \mathcal{L}_{\pi} . There exist universal constants c , C > 0 c,C>0 such that, if h ​ ( x t ) ∼ 𝒩 ​ ( 0 , I d ) h(x_{t})\sim\mathcal{N}(0,I_{d}) and Δ enc ≤ c ​ γ rep ​ ( π ) \Delta_{\rm enc}\leq c\,\gamma_{\mathrm{rep}}(\pi) , then there exists Q ∈ O ​ ( d ) Q\in O(d) such that, with η := Δ enc / γ rep ​ ( π ) \eta:=\Delta_{\rm enc}/\gamma_{\mathrm{rep}}(\pi) ,

[TABLE] 𝔼 ​ ‖ h ​ ( g ​ ( z t ) ) − Q ​ z t ‖ 2 ≤ C ​ η , \mathbb{E}\|h(g(z_{t}))-Qz_{t}\|^{2}\leq C\eta,

Moreover, defining ε F ​ ( z , a ) := F ​ ( h ​ ( g ​ ( z ) ) , a ) − Q ​ ( A ​ z + B ​ a ) \varepsilon_{F}(z,a):=F(h(g(z)),a)-Q(Az+Ba) , we have

[TABLE] 𝔼 P π ​ [ ‖ ε F ​ ( z t , a t ) ‖ 2 ] ≤ C ​ Δ pred + C ​ ( 1 + ‖ A ‖ op 2 ) ​ η . \mathbb{E}_{P_{\pi}}\!\left[\|\varepsilon_{F}(z_{t},a_{t})\|^{2}\right]\leq C\Delta_{\rm pred}+C\bigl(1+\|A\|_{\rm op}^{2}\bigr)\eta. (4)

The two errors affect different parts of the learned world model. The encoder excess risk controls deviation from an orthogonal copy of the latent state; the predictor error captures the additional cost of using F F rather than the optimal predictor for that representation. The factor 1 / γ rep ​ ( π ) 1/\gamma_{\mathrm{rep}}(\pi) exposes the conditioning of approximate representation identification: as the spectral gap narrows, nonlinear features become nearly as predictive as the true latent directions.

## Proof sketch.

The risk attained by F h ⋆ F_{h}^{\star} is determined by the predictable energy of h ​ ( x t + 1 ) h(x_{t+1}) . Its Hermite expansion shows that the representation margin bounds the total variance in higher-order components by O ​ ( Δ enc / γ rep ​ ( π ) ) O(\Delta_{\rm enc}/\gamma_{\mathrm{rep}}(\pi)) . The remaining first-order component is close to an orthogonal map because h ​ ( x t ) ∼ 𝒩 ​ ( 0 , I d ) h(x_{t})\sim\mathcal{N}(0,I_{d}) , which gives the representation bound. Combining this error with the deviation of F F from F h ⋆ F_{h}^{\star} gives the predictor bound. The full proof is provided in the corresponding appendix section.

## 3.4 Counterfactual Error Amplification

Theorem 2 provides an in-distribution transition-error guarantee under P π P_{\pi} . Planning and control, however, require predictions for actions that may be rare under this distribution, so small on-policy error need not imply reliable counterfactual prediction. We characterize this gap in the identified coordinates y = Q ​ z y=Qz , where the true conditional-mean predictor is F ⋆ ​ ( y , a ) = Q ​ A ​ Q ⊤ ​ y + Q ​ B ​ a F^{\star}(y,a)=QAQ^{\top}y+QBa .

For a predictor F F , define its on-policy excess risk relative to F ⋆ F^{\star} as

[TABLE] ℰ π ​ ( F ) \displaystyle\mathcal{E}_{\pi}(F) := 𝔼 P π ​ [ ‖ Q ​ z t + 1 − F ​ ( Q ​ z t , a t ) ‖ 2 ] \displaystyle=\mathbb{E}_{P_{\pi}}\!\left[\|Qz_{t+1}-F(Qz_{t},a_{t})\|^{2}\right] (5) − 𝔼 P π ​ [ ‖ Q ​ z t + 1 − F ⋆ ​ ( Q ​ z t , a t ) ‖ 2 ] . \displaystyle\quad-\mathbb{E}_{P_{\pi}}\!\left[\|Qz_{t+1}-F^{\star}(Qz_{t},a_{t})\|^{2}\right].

Let μ π ​ ( z ) := 𝔼 π ​ [ a t ∣ z t = z ] \mu_{\pi}(z):=\mathbb{E}_{\pi}[a_{t}\mid z_{t}=z] . To isolate the role of conditional coverage, consider a counterfactual distribution with the same conditional mean but identity covariance: a cf = μ π ​ ( z ) + η cf a_{\rm cf}=\mu_{\pi}(z)+\eta_{\rm cf} , where η cf ∼ 𝒩 ​ ( 0 , I m ) \eta_{\rm cf}\sim\mathcal{N}(0,I_{m}) is independent of z z . Its transition error is

[TABLE] ℰ cf ​ ( F ) := 𝔼 ​ [ ‖ F ​ ( Q ​ z , a cf ) − F ⋆ ​ ( Q ​ z , a cf ) ‖ 2 ] . \mathcal{E}_{\rm cf}(F):=\mathbb{E}\left[\|F(Qz,a_{\rm cf})-F^{\star}(Qz,a_{\rm cf})\|^{2}\right]. (6)

For this counterfactual analysis, we additionally assume that the predictor class contains F ⋆ ​ ( y , a ) + D ​ ( a − μ π ​ ( Q ⊤ ​ y ) ) F^{\star}(y,a)+D(a-\mu_{\pi}(Q^{\top}y)) for every matrix D ∈ ℝ d × m D\in\mathbb{R}^{d\times m} .

Suppose the conditions of Theorem 1 and the additional predictor-class condition above hold. For every δ > 0 \delta>0 , the predictor class contains a continuous predictor F δ F_{\delta} satisfying

[TABLE] ℰ π ​ ( F δ ) = δ , ℰ cf ​ ( F δ ) = δ ρ tr ​ ( π ) . \mathcal{E}_{\pi}(F_{\delta})=\delta,\qquad\mathcal{E}_{\rm cf}(F_{\delta})=\frac{\delta}{\rho_{\mathrm{tr}}(\pi)}.

The theorem shows that exact transition identifiability does not imply well-conditioned approximate identification. When ρ tr ​ ( π ) > 0 \rho_{\mathrm{tr}}(\pi)>0 , every action direction has nonzero conditional variation, so the controlled transition is identified at a global optimum. However, when ρ tr ​ ( π ) \rho_{\mathrm{tr}}(\pi) is small, the behavior policy provides little variation along the least-excited action direction, and the training objective weakly penalizes errors in the corresponding action response. The constructed rank-one perturbation exploits precisely this direction: it incurs on-policy excess risk δ \delta , while its counterfactual error is δ / ρ tr ​ ( π ) \delta/\rho_{\mathrm{tr}}(\pi) . Thus, ρ tr ​ ( π ) \rho_{\mathrm{tr}}(\pi) acts as a conditioning parameter for approximate transition identification. This construction provides an attainable lower bound on counterfactual error amplification, rather than a uniform upper bound over the predictor class.

## Proof sketch.

The conditional-mean orthogonality identity rewrites the on-policy excess risk as the mean squared deviation from F ⋆ F^{\star} . Let v min v_{\min} be a unit eigenvector of Σ tr ​ ( π ) \Sigma_{\mathrm{tr}}(\pi) with eigenvalue ρ tr ​ ( π ) \rho_{\mathrm{tr}}(\pi) , and perturb F ⋆ F^{\star} in this action direction by a rank-one map scaled by δ / ρ tr ​ ( π ) \sqrt{\delta/\rho_{\mathrm{tr}}(\pi)} . Under the behavior policy, the residual action has covariance Σ tr ​ ( π ) \Sigma_{\mathrm{tr}}(\pi) , so the perturbation contributes exactly δ \delta ; under the counterfactual distribution its covariance is I m I_{m} , giving error δ / ρ tr ​ ( π ) \delta/\rho_{\mathrm{tr}}(\pi) . The full proof is provided in the Appendix C .

At ρ tr ​ ( π ) = 0 \rho_{\mathrm{tr}}(\pi)=0 , some action direction has no residual variation once the state is fixed. Predictors may then agree exactly on the behavior distribution while disagreeing under counterfactual actions, making the controlled transition structurally non-identifiable outside the behavior support.

For the following state-dependent Gaussian policy, we show that the transition margin reduces directly to the exploration-noise variance.

Consider the behavior-policy family a t = 1 − σ 2 ​ K ​ z t + σ ​ η t a_{t}=\sqrt{1-\sigma^{2}}\,Kz_{t}+\sigma\eta_{t} , where η t ∼ 𝒩 ​ ( 0 , I m ) \eta_{t}\sim\mathcal{N}(0,I_{m}) , η t ⟂ z t \eta_{t}\perp z_{t} , and σ ∈ [ 0 , 1 ] \sigma\in[0,1] . Then

[TABLE] Σ tr ​ ( π σ ) = σ 2 ​ I m , ρ tr ​ ( π σ ) = σ 2 . \Sigma_{\mathrm{tr}}(\pi_{\sigma})=\sigma^{2}I_{m},\qquad\rho_{\mathrm{tr}}(\pi_{\sigma})=\sigma^{2}.

Consequently, for every σ > 0 \sigma>0 and δ > 0 \delta>0 , the predictor class contains a continuous predictor F δ F_{\delta} satisfying ℰ π σ ​ ( F δ ) = δ \mathcal{E}_{\pi_{\sigma}}(F_{\delta})=\delta and ℰ cf ​ ( F δ ) = δ / σ 2 \mathcal{E}_{\rm cf}(F_{\delta})=\delta/\sigma^{2} .
Thus the construction attains a counterfactual amplification factor of 1 / σ 2 1/\sigma^{2} . At σ = 0 \sigma=0 , the behavior policy is deterministic given the state, and the controlled transition is not identifiable outside its support.

Thus, any positive exploration noise gives full conditional action support, yet transition identification becomes increasingly ill-conditioned as σ \sigma decreases. The attainable factor in this construction grows as 1 / σ 2 1/\sigma^{2} and diverges in the deterministic-policy limit.

## 4 Experiments

The experiments test three implications of the theory through controlled comparisons. The representation-margin sweep varies spectral separation while maintaining non-degenerate conditional action excitation. The behavior-policy sweep varies conditional action excitation while keeping the representation regime fixed. The planning evaluation then measures how counterfactual transition errors affect downstream action selection. Together, these experiments distinguish the roles of γ rep \gamma_{\rm rep} and ρ tr \rho_{\rm tr} and evaluate their consequences for control.

## 4.1 Representation Identifiability

To examine how spectral separation affects representation identifiability, actions are sampled independently from a standard Gaussian, fixing ρ tr = 1 \rho_{\rm tr}=1 , while the predictable-signal spectrum is varied across the sufficient-condition boundary γ rep = 0 \gamma_{\rm rep}=0 . Conditional action excitation therefore remains non-degenerate throughout, so changes in identification quality can be attributed to the representation regime. The sweep is repeated for all four observation maps.

Spectral separation consistently improves identification across observation maps. In the identifiable regime, the encoder inverts each nonlinear observation map and identifies the latent polar structure up to an approximately orthogonal transformation (Figure 2 ). As shown in Figure 3 , both representation and controlled transition errors decrease as the weakest predictable direction strengthens. By fixing the action excitation, this joint improvement supports the predicted role of spectral separation in identifying the latent coordinates and the dynamics expressed in those coordinates. Notably, the estimation error changes smoothly through γ rep = 0 \gamma_{\rm rep}=0 , indicating that the theorem is providing only a sufficient condition.

Figure 2: Representation geometry across nonlinear observation maps. The left panel shows the latent state z z ; each remaining column shows the observation x = g ​ ( z ) x=g(z) above and the learned representation y = h ​ ( x ) y=h(x) below. Shared colors and polar calibration curves track corresponding latent locations.

Figure 3: Identification performance as the representation margin γ rep \gamma_{\rm rep} increases. Left: normalized representation error E rep E_{\rm rep} ; right: normalized controlled-transition error E tr E_{\rm tr} . Lines and shading show means and 95% confidence intervals over five runs.

## 4.2 Transition Identifiability and Counterfactual Prediction

The transition experiment keeps the representation regime and controlled conditional mean fixed while varying only the conditional action excitation induced by the behavior policy. The policy family preserves a standard-Gaussian action marginal while satisfying

[TABLE] Cov ⁡ ( a t ∣ z t ) = σ 2 ​ I , ρ tr ​ ( π σ ) = σ 2 . \operatorname{Cov}(a_{t}\mid z_{t})=\sigma^{2}I,\qquad\rho_{\rm tr}(\pi_{\sigma})=\sigma^{2}. (7)

Thus, σ \sigma changes conditional coverage without changing the marginal action scale. At σ = 0 \sigma=0 , the data constrain only the closed-loop map A + B ​ K A+BK , while positive σ \sigma restores full conditional support, though identification remains poorly conditioned under weak excitation. The representation margin stays positive throughout. We compare behavior-action error with error under a broader intervention distribution and separately estimate the state and action components of the learned transition. Unlike Theorem 3 , the experimental counterfactual distribution is fixed across coverage levels, so the experiment tests the predicted amplification trend rather than the exact theoretical factor. Full details are given in the supplemental materials.

Conditional action coverage determines whether behavioral accuracy extends to alternative actions. At σ = 0 \sigma=0 , prediction remains accurate on behavior actions, while counterfactual error is large and the state and action components are not separately identifiable (Figures 4 and 5 ). Increasing conditional excitation improves counterfactual prediction and both transition components. Since representation error remains low and γ rep > 0 \gamma_{\rm rep}>0 throughout, these improvements are attributable to transition excitation rather than representation quality. Thus, action conditioning and low behavioral prediction error alone do not guarantee reliable responses to alternative controls.

Figure 4: Counterfactual transition error across actions at a fixed state. Predicted next states are orthogonally aligned with the latent coordinates for evaluation.

Figure 5: Transition identification as conditional action coverage increases. Top: conditional-mean transition error and empirical counterfactual amplification under a fixed intervention distribution. Bottom: relative estimation errors for the state and action components, represented by matrices A A and B B , respectively. Lines and shading show means and 95% confidence intervals over five runs.

## 4.3 Consequences for Goal-Conditioned Planning

Counterfactual transition errors matter for planning because the planner must compare action sequences that may depart from the behavior distribution. We test this mechanism with a goal-conditioned planner that encodes the current and goal observations, rolls out a shared bank of bounded action sequences, and selects the sequence whose predicted endpoint is closest to the encoded goal. The selected sequence is then evaluated under the true conditional-mean dynamics. The candidate bank is fixed across models so that performance differences reflect the learned rollouts rather than the search distribution.

The improvement in transition identification carries over to planning performance. Under limited conditional coverage, inaccurate rollouts distort the predicted reachable set and the selected sequence can execute far from its predicted endpoint. As coverage increases, the predicted and true reachable sets become progressively better aligned (Figure 6 ). This geometric improvement is reflected in action-selection performance across all observation maps: mean terminal error over a shared set of reachable goals decreases sharply and is nearly eliminated in the well-excited regime (Figure 7 ). Averaging over goals rules out the accidental success that can occur for an individual discrete target. These results show that counterfactual transition errors under limited conditional excitation have measurable consequences for control: they distort candidate evaluation and increase the terminal error of model-based action selection.

Figure 6: Predicted and true terminal sets across conditional action coverage. Predicted endpoints are orthogonally aligned with the latent coordinates for visualization. The dotted segment indicates the prediction error for the selected sequence.

Figure 7: Goal-conditioned planning error as conditional action coverage increases. Curves report mean terminal error across goals reachable by the candidate bank; shading shows 95% confidence intervals across five runs.

## 5 Conclusion

This paper establishes a joint identifiability theory for controlled world models from nonlinear observations. We show that action-conditioned latent prediction can jointly identify the latent representation up to an orthogonal transformation and the controlled conditional-mean transition, provided that predictable-signal spectral separation and sufficient conditional action excitation hold. In contrast, state-only prediction captures the behavior-policy-averaged future and does not generally identify how alternative actions affect the next state. We further derive quantitative identifiability bounds and show that weak conditional action excitation can make transition identification poorly conditioned, allowing accurate on-policy prediction to coexist with substantially larger counterfactual error. Experiments support the distinct roles of representation and transition identifiability and demonstrate how improved transition identification leads to more reliable latent-space planning. Our analysis is limited to invertible observations, linear Gaussian latent dynamics, an exact representation constraint, and identification of the controlled conditional mean. Future work should extend these guarantees to finite-sample settings and to nonlinear or partially observed dynamics.

## References

M. Assran, Q. Duval, I. Misra, P. Bojanowski, P. Vincent, M. Rabbat, Y. LeCun, and N. Ballas (2023) Self-Supervised Learning From Images With a Joint-Embedding Predictive Architecture . In Proceedings of the IEEE/CVF Conference on Computer Vision and Pattern Recognition , pp. 15619–15629 . Cited by: §1 .

M. Assran et al. (2025) V-JEPA 2: Self-Supervised Video Models Enable Understanding, Prediction and Planning . arXiv . External Links: 2506.09985 , Document Cited by: §1 , §2 , §2 .

R. Balestriero and Y. LeCun (2025) LeJEPA: Provable and Scalable Self-Supervised Learning Without the Heuristics . arXiv . External Links: 2511.08544 , Document Cited by: §1 , §2 .

A. Bardes, Q. Garrido, J. Ponce, X. Chen, M. Rabbat, Y. LeCun, M. Assran, and N. Ballas (2024) Revisiting Feature Prediction for Learning Visual Representations from Video . Cited by: §1 , §2 .

D. Ha and J. Schmidhuber (2018) World Models . External Links: 1803.10122 , Document Cited by: §2 .

D. Hafner, T. Lillicrap, J. Ba, and M. Norouzi (2020) Dream to control: learning behaviors by latent imagination . Cited by: §2 .

D. Hafner, T. Lillicrap, I. Fischer, R. Villegas, D. Ha, H. Lee, and J. Davidson (2019) Learning latent dynamics for planning from pixels . In International Conference on Machine Learning , pp. 2555–2565 . Cited by: §2 .

D. Hafner, J. Pasukonis, J. Ba, and T. Lillicrap (2025) Mastering diverse control tasks through world models . Nature 640 ( 8059 ), pp. 647–653 . External Links: ISSN 1476-4687 , Document Cited by: §1 , §2 .

N. Hansen, H. Su, and X. Wang (2024) TD-MPC2: Scalable, Robust World Models for Continuous Control . International Conference on Learning Representations 2024 , pp. 47376–47405 . Cited by: §2 .

N. A. Hansen, H. Su, and X. Wang (2022) Temporal Difference Learning for Model Predictive Control . In Proceedings of the 39th International Conference on Machine Learning , pp. 8387–8406 . External Links: ISSN 2640-3498 Cited by: §2 .

A. Hyvärinen, I. Khemakhem, and R. Monti (2024) Identifiability of latent-variable and structural-equation models: from linear to nonlinear . Annals of the Institute of Statistical Mathematics 76 ( 1 ), pp. 1–33 . External Links: ISSN 1572-9052 , Document Cited by: §1 .

A. Hyvarinen and H. Morioka (2016) Unsupervised Feature Extraction by Time-Contrastive Learning and Nonlinear ICA . In Advances in Neural Information Processing Systems , Vol. 29 . Cited by: §2 .

A. Hyvärinen and P. Pajunen (1999) Nonlinear independent component analysis: Existence and uniqueness results . Neural Networks 12 ( 3 ), pp. 429–439 . External Links: ISSN 0893-6080 , Document Cited by: §2 .

A. Hyvarinen, H. Sasaki, and R. Turner (2019) Nonlinear ICA Using Auxiliary Variables and Generalized Contrastive Learning . In Proceedings of the Twenty-Second International Conference on Artificial Intelligence and Statistics , pp. 859–868 . External Links: ISSN 2640-3498 Cited by: §2 .

I. Khemakhem, D. Kingma, R. Monti, and A. Hyvarinen (2020) Variational Autoencoders and Nonlinear ICA: A Unifying Framework . In Proceedings of the Twenty Third International Conference on Artificial Intelligence and Statistics , pp. 2207–2217 . External Links: ISSN 2640-3498 Cited by: §1 , §2 .

D. Klindt, Y. LeCun, and R. Balestriero (2026) When Does LeJEPA Learn a World Model? . arXiv . External Links: 2605.26379 , Document Cited by: §1 , §2 .

Y. LeCun (2022) A path towards autonomous machine intelligence version 0.9. 2, 2022-06-27 . Open Review 62 ( 1 ), pp. 1–62 . Cited by: §1 .

S. E. Li (2023) Reinforcement learning for sequential decision and optimal control . Springer . External Links: ISBN 978-981-19-7784-8 Cited by: §2 .

F. Locatello, S. Bauer, M. Lucic, G. Raetsch, S. Gelly, B. Schölkopf, and O. Bachem (2019) Challenging Common Assumptions in the Unsupervised Learning of Disentangled Representations . In Proceedings of the 36th International Conference on Machine Learning , pp. 4114–4124 . External Links: ISSN 2640-3498 Cited by: §1 , §2 .

L. Maes, Q. L. Lidec, D. Scieur, Y. LeCun, and R. Balestriero (2026) LeWorldModel: Stable End-to-End Joint-Embedding Predictive Architecture from Pixels . arXiv . External Links: 2603.19312 , Document Cited by: §1 , §2 , §2 .

Y. Mu, B. Peng, Z. Gu, S. E. Li, C. Liu, B. Nie, J. Zheng, and B. Zhang (2020) Mixed Reinforcement Learning for Efficient Policy Optimization in Stochastic Environments . In 2020 20th International Conference on Control, Automation and Systems (ICCAS) , pp. 1212–1219 . External Links: ISSN 2642-3901 , Document Cited by: §2 .

B. Schölkopf, F. Locatello, S. Bauer, N. R. Ke, N. Kalchbrenner, A. Goyal, and Y. Bengio (2021) Toward Causal Representation Learning . Proceedings of the IEEE 109 ( 5 ), pp. 612–634 . External Links: ISSN 1558-2256 , Document Cited by: §2 .

J. Schrittwieser, I. Antonoglou, T. Hubert, K. Simonyan, L. Sifre, S. Schmitt, A. Guez, E. Lockhart, D. Hassabis, T. Graepel, T. Lillicrap, and D. Silver (2020) Mastering Atari, Go, chess and shogi by planning with a learned model . Nature 588 ( 7839 ), pp. 604–609 . External Links: ISSN 1476-4687 , Document Cited by: §2 .

P. Van Overschee and B. De Moor (1996) Subspace Identification for Linear Systems . Springer US , Boston, MA . External Links: Document , ISBN 978-1-4613-8061-0 978-1-4613-0465-4 Cited by: §2 .

B. Varici, E. Acartürk, K. Shanmugam, and A. Tajer (2024) General Identifiability and Achievability for Causal Representation Learning . In Proceedings of The 27th International Conference on Artificial Intelligence and Statistics , pp. 2314–2322 . External Links: ISSN 2640-3498 Cited by: §2 .

J. von Kügelgen, M. Besserve, L. Wendong, L. Gresele, A. Kekić, E. Bareinboim, D. Blei, and B. Schölkopf (2023) Nonparametric Identifiability of Causal Representations from Unknown Interventions . In Advances in Neural Information Processing Systems , Vol. 36 , pp. 48603–48638 . Cited by: §2 .

J. C. Willems, P. Rapisarda, I. Markovsky, and B. L. M. De Moor (2005) A note on persistency of excitation . Systems & Control Letters 54 ( 4 ), pp. 325–329 . External Links: ISSN 0167-6911 , Document Cited by: §1 , §2 .

Y. Yang, L. Tao, L. Wang, and S. E. Li (2024a) Controllability test for nonlinear datatic systems . Communications in Transportation Research 4 , pp. 100143 . External Links: ISSN 2772-4247 , Document Cited by: §1 .

Y. Yang, Z. Zheng, and S. E. Li (2024b) On the Stability of Datatic Control Systems . arXiv . External Links: 2401.16793 , Document Cited by: §1 .

G. Zhan, L. Wang, X. Zhang, J. Gao, M. TOMIZUKA, and S. E. Li (2025a) Bootstrap Off-policy with World Model . In Advances in Neural Information Processing Systems , Vol. 38 , pp. 134093–134121 . Cited by: §1 , §2 .

G. Zhan, Z. Zheng, and S. E. Li (2025b) Canonical form of datatic description in control systems . In 2025 American Control Conference (ACC) , pp. 3479–3484 . Cited by: §1 .

## Appendix A Proof of Theorem 1

Throughout the proof, equalities between measurable functions are understood up to the relevant Gaussian measure.
Let w = ( z t ⊤ , a t ⊤ ) ⊤ w=(z_{t}^{\top},a_{t}^{\top})^{\top} , C = [ A ​ B ] C=[A\;B] , and Σ w := Cov ⁡ ( w ) \Sigma_{w}:=\operatorname{Cov}(w) . Under Assumptions 1–2, w ∼ 𝒩 ​ ( 0 , Σ w ) w\sim\mathcal{N}(0,\Sigma_{w}) , z t + 1 = C ​ w + ξ t z_{t+1}=Cw+\xi_{t} , and

[TABLE] R π := Cov ⁡ ( 𝔼 ​ [ z t + 1 ∣ z t , a t ] ) = C ​ Σ w ​ C ⊤ . R_{\pi}:=\operatorname{Cov}\!\left(\mathbb{E}[z_{t+1}\mid z_{t},a_{t}]\right)=C\Sigma_{w}C^{\top}.

The independent-noise special case Σ w = I d + m \Sigma_{w}=I_{d+m} gives R π = C ​ C ⊤ = A ​ A ⊤ + B ​ B ⊤ R_{\pi}=CC^{\top}=AA^{\top}+BB^{\top} .

For any admissible encoder h h , the squared-loss optimal predictor is F h ⋆ ​ ( h ​ ( z t ) , a t ) = 𝔼 ​ [ h ​ ( z t + 1 ) ∣ h ​ ( z t ) , a t ] F_{h}^{\star}(h(z_{t}),a_{t})=\mathbb{E}[h(z_{t+1})\mid h(z_{t}),a_{t}] .
Moreover, minimizing the prediction loss over F F is equivalent to maximizing

[TABLE] J ( h ) := 𝔼 [ ∥ 𝔼 [ h ( z t + 1 ) ∣ h ( z t ) , a t ] ∥ 2 ] . J(h):=\mathbb{E}\!\left[\left\|\mathbb{E}[h(z_{t+1})\mid h(z_{t}),a_{t}]\right\|^{2}\right].

The first claim follows from the conditional-mean optimality of squared loss.
By the Pythagorean identity for conditional expectation,

[TABLE] inf F ℒ ​ ( h , F ) = 𝔼 ​ ‖ h ​ ( z t + 1 ) ‖ 2 − J ​ ( h ) . \inf_{F}\mathcal{L}(h,F)=\mathbb{E}\|h(z_{t+1})\|^{2}-J(h).

Since h h is standard Gaussian and the process is stationary, 𝔼 ​ ‖ h ​ ( z t + 1 ) ‖ 2 = d \mathbb{E}\|h(z_{t+1})\|^{2}=d .
Thus minimizing prediction loss is equivalent to maximizing J ​ ( h ) J(h) .
∎

Let h ​ ( z ) = ∑ k ≥ 1 h k ​ ( z ) h(z)=\sum_{k\geq 1}h_{k}(z) be the vector-valued Hermite decomposition under z ∼ 𝒩 ​ ( 0 , I d ) z\sim\mathcal{N}(0,I_{d}) , and write the linear component as h 1 ​ ( z ) = L ​ z h_{1}(z)=Lz .
Let τ 1 := 𝔼 ​ ‖ h 1 ​ ( z ) ‖ 2 = tr ⁡ ( L ​ L ⊤ ) \tau_{1}:=\mathbb{E}\|h_{1}(z)\|^{2}=\operatorname{tr}(LL^{\top}) .
If the eigenvalues of R π R_{\pi} are 1 > λ 1 ≥ ⋯ ≥ λ d > 0 1>\lambda_{1}\geq\cdots\geq\lambda_{d}>0 , then every admissible h h satisfies

[TABLE] J ​ ( h ) ≤ tr ⁡ ( R π ) − ( λ d − λ 1 2 ) ​ ( d − τ 1 ) . J(h)\leq\operatorname{tr}(R_{\pi})-(\lambda_{d}-\lambda_{1}^{2})(d-\tau_{1}).

Since h ​ ( z t ) h(z_{t}) is a function of z t z_{t} , conditioning on ( z t , a t ) (z_{t},a_{t}) can only increase predictable energy, so

[TABLE] J ( h ) ≤ 𝔼 [ ∥ 𝔼 [ h ( z t + 1 ) ∣ z t , a t ] ∥ 2 ] . J(h)\leq\mathbb{E}\!\left[\left\|\mathbb{E}[h(z_{t+1})\mid z_{t},a_{t}]\right\|^{2}\right].

Write w = Σ w 1 / 2 ​ u w=\Sigma_{w}^{1/2}u for u ∼ 𝒩 ​ ( 0 , I d + m ) u\sim\mathcal{N}(0,I_{d+m}) , and set M := C ​ Σ w 1 / 2 M:=C\Sigma_{w}^{1/2} . Then z t + 1 = M ​ u + ξ t z_{t+1}=Mu+\xi_{t} is a Gaussian channel with M ​ M ⊤ = R π MM^{\top}=R_{\pi} . Its canonical correlations are therefore the square roots of the eigenvalues of R π R_{\pi} . By the standard Hermite–Mehler decomposition for Gaussian channels, the first-order Hermite component is contracted according to R π R_{\pi} , while every Hermite component of degree at least two has predictable energy at most λ 1 2 \lambda_{1}^{2} times its variance.
Therefore,

[TABLE] J ​ ( h ) ≤ tr ⁡ ( L ​ R π ​ L ⊤ ) + λ 1 2 ​ ( d − τ 1 ) . J(h)\leq\operatorname{tr}(LR_{\pi}L^{\top})+\lambda_{1}^{2}(d-\tau_{1}).

It remains to control the linear term.
Whitening gives I d = 𝔼 ​ [ h ​ ( z ) ​ h ​ ( z ) ⊤ ] I_{d}=\mathbb{E}[h(z)h(z)^{\top}] , and Hermite orthogonality implies L ​ L ⊤ ⪯ I d LL^{\top}\preceq I_{d} .
Hence

[TABLE] tr ⁡ ( L ​ R π ​ L ⊤ ) ≤ tr ⁡ ( R π ) − λ d ​ ( d − τ 1 ) . \operatorname{tr}(LR_{\pi}L^{\top})\leq\operatorname{tr}(R_{\pi})-\lambda_{d}(d-\tau_{1}).

Combining the two inequalities gives the result.
∎

For any orthogonal Q ∈ O ​ ( d ) Q\in O(d) , the encoder h Q ​ ( z ) = Q ​ z h_{Q}(z)=Qz is admissible.
Its optimal predictor is F Q ​ ( h Q ​ ( z t ) , a t ) = Q ​ ( A ​ z t + B ​ a t ) F_{Q}(h_{Q}(z_{t}),a_{t})=Q(Az_{t}+Ba_{t}) , and the corresponding predictable energy is

[TABLE] J ​ ( h Q ) = 𝔼 ​ ‖ Q ​ ( A ​ z t + B ​ a t ) ‖ 2 = tr ⁡ ( R π ) . J(h_{Q})=\mathbb{E}\|Q(Az_{t}+Ba_{t})\|^{2}=\operatorname{tr}(R_{\pi}).

Thus the maximum value of J ​ ( h ) J(h) is at least tr ⁡ ( R π ) \operatorname{tr}(R_{\pi}) .

By Lemma 2 , every admissible encoder satisfies

Under the controlled spectral separation condition λ d − λ 1 2 > 0 \lambda_{d}-\lambda_{1}^{2}>0 , any global maximizer must have τ 1 = d \tau_{1}=d .
Since the total Hermite energy of h h is d d , all higher-order Hermite components vanish, and hence h ​ ( z ) = L ​ z h(z)=Lz a.s.
The standard-Gaussian constraint gives L ​ L ⊤ = I d LL^{\top}=I_{d} , so L ∈ O ​ ( d ) L\in O(d) .
Setting Q = L Q=L proves state identifiability.

Finally, for y t = h ​ ( z t ) = Q ​ z t y_{t}=h(z_{t})=Qz_{t} , the optimal predictor satisfies

[TABLE] F ⋆ ​ ( y t , a t ) = 𝔼 ​ [ Q ​ z t + 1 ∣ Q ​ z t , a t ] = Q ​ A ​ Q ⊤ ​ y t + Q ​ B ​ a t . F^{\star}(y_{t},a_{t})=\mathbb{E}[Qz_{t+1}\mid Qz_{t},a_{t}]=QAQ^{\top}y_{t}+QBa_{t}.

This proves controlled transition identifiability.
Moreover, ρ tr ​ ( π ) > 0 \rho_{\rm tr}(\pi)>0 makes the conditional covariance Cov ⁡ ( a t ∣ z t ) \operatorname{Cov}(a_{t}\mid z_{t}) positive definite. Since Cov ⁡ ( z t ) = I d \operatorname{Cov}(z_{t})=I_{d} , the Schur-complement criterion implies that Σ w \Sigma_{w} is positive definite, so the jointly Gaussian behavior distribution has a strictly positive density on ℝ d + m \mathbb{R}^{d+m} . The continuous difference between F ​ ( Q ​ z , a ) F(Qz,a) and Q ​ ( A ​ z + B ​ a ) Q(Az+Ba) therefore vanishes everywhere once it vanishes. Equivalently, in identified coordinates, F ​ ( y , a ) = Q ​ A ​ Q ⊤ ​ y + Q ​ B ​ a F(y,a)=QAQ^{\top}y+QBa for every ( y , a ) ∈ ℝ d × ℝ m (y,a)\in\mathbb{R}^{d}\times\mathbb{R}^{m} .
The remaining prediction loss is the irreducible noise variance, namely tr ⁡ ( Cov ⁡ ( ξ t ) ) = d − tr ⁡ ( R π ) \operatorname{tr}(\operatorname{Cov}(\xi_{t}))=d-\operatorname{tr}(R_{\pi}) .
∎

## Appendix B Proof of Theorem 2

We use the notation of Theorem 2 .
Let R π := Cov ⁡ ( A ​ z t + B ​ a t ) = C ​ Σ w ​ C ⊤ R_{\pi}:=\operatorname{Cov}(Az_{t}+Ba_{t})=C\Sigma_{w}C^{\top} , with eigenvalues 1 > λ 1 ≥ ⋯ ≥ λ d > 0 1>\lambda_{1}\geq\cdots\geq\lambda_{d}>0 , and let γ rep ​ ( π ) := λ d − λ 1 2 \gamma_{\rm rep}(\pi):=\lambda_{d}-\lambda_{1}^{2} .
For an encoder satisfying h ​ ( z t ) ∼ 𝒩 ​ ( 0 , I d ) h(z_{t})\sim\mathcal{N}(0,I_{d}) , write h ​ ( z ) = L ​ z + g ​ ( z ) h(z)=Lz+g(z) for its Hermite decomposition and F h ⋆ ​ ( h ​ ( z t ) , a t ) := 𝔼 ​ [ h ​ ( z t + 1 ) ∣ h ​ ( z t ) , a t ] F_{h}^{\star}(h(z_{t}),a_{t}):=\mathbb{E}[h(z_{t+1})\mid h(z_{t}),a_{t}] .
Define J ​ ( h ) := 𝔼 ​ ‖ F h ⋆ ​ ( h ​ ( z t ) , a t ) ‖ 2 J(h):=\mathbb{E}\|F_{h}^{\star}(h(z_{t}),a_{t})\|^{2} .

Let r := 𝔼 ​ ‖ g ​ ( z ) ‖ 2 r:=\mathbb{E}\|g(z)\|^{2} .
If ℒ ​ ( h , F h ⋆ ) ≤ ℒ ⋆ + Δ enc \mathcal{L}(h,F_{h}^{\star})\leq\mathcal{L}^{\star}+\Delta_{\rm enc} , then

[TABLE] r ≤ C ​ Δ enc γ rep ​ ( π ) . r\leq C\frac{\Delta_{\rm enc}}{\gamma_{\rm rep}(\pi)}.

Since h ​ ( z t ) ∼ 𝒩 ​ ( 0 , I d ) h(z_{t})\sim\mathcal{N}(0,I_{d}) , ℒ ​ ( h , F h ⋆ ) = d − J ​ ( h ) \mathcal{L}(h,F_{h}^{\star})=d-J(h) . The excess-risk assumption therefore gives J ​ ( h ) ≥ tr ⁡ ( R π ) − Δ enc J(h)\geq\operatorname{tr}(R_{\pi})-\Delta_{\rm enc} .

On the other hand, the controlled Hermite contraction used in the exact proof gives

[TABLE] J ​ ( h ) ≤ tr ⁡ ( L ​ R π ​ L ⊤ ) + λ 1 2 ​ r . J(h)\leq\operatorname{tr}(LR_{\pi}L^{\top})+\lambda_{1}^{2}r.

[TABLE] tr ⁡ ( L ​ R π ​ L ⊤ ) ≤ tr ⁡ ( R π ) − λ d ​ r . \operatorname{tr}(LR_{\pi}L^{\top})\leq\operatorname{tr}(R_{\pi})-\lambda_{d}r.

Combining the two displays yields ( λ d − λ 1 2 ) ​ r ≤ Δ enc (\lambda_{d}-\lambda_{1}^{2})r\leq\Delta_{\rm enc} , which proves the claim.
∎

Under the assumptions of Lemma 3 , there exists Q ∈ O ​ ( d ) Q\in O(d) such that

[TABLE] 𝔼 ​ ‖ h ​ ( z t ) − Q ​ z t ‖ 2 ≤ C ​ Δ enc γ rep ​ ( π ) . \mathbb{E}\|h(z_{t})-Qz_{t}\|^{2}\leq C\frac{\Delta_{\rm enc}}{\gamma_{\rm rep}(\pi)}.

Since h ​ ( z t ) ∼ 𝒩 ​ ( 0 , I d ) h(z_{t})\sim\mathcal{N}(0,I_{d}) , Hermite orthogonality gives

[TABLE] I d = L ​ L ⊤ + Cov ⁡ ( g ​ ( z ) ) . I_{d}=LL^{\top}+\operatorname{Cov}(g(z)).

Therefore

[TABLE] ‖ L ​ L ⊤ − I d ‖ F = ‖ Cov ⁡ ( g ​ ( z ) ) ‖ F ≤ r . \|LL^{\top}-I_{d}\|_{F}=\|\operatorname{Cov}(g(z))\|_{F}\leq r.

By stability of the polar decomposition, there exists Q ∈ O ​ ( d ) Q\in O(d) such that ‖ L − Q ‖ F 2 ≤ C ​ r \|L-Q\|_{F}^{2}\leq Cr .
Using again the orthogonality between the linear and higher-order Hermite components,

[TABLE] 𝔼 ​ ‖ h ​ ( z t ) − Q ​ z t ‖ 2 = ‖ L − Q ‖ F 2 + 𝔼 ​ ‖ g ​ ( z t ) ‖ 2 ≤ C ​ r . \mathbb{E}\|h(z_{t})-Qz_{t}\|^{2}=\|L-Q\|_{F}^{2}+\mathbb{E}\|g(z_{t})\|^{2}\leq Cr.

The result follows from Lemma 3 and γ rep ​ ( π ) ≤ 1 \gamma_{\rm rep}(\pi)\leq 1 .
∎

Let η := Δ enc / γ rep ​ ( π ) \eta:=\Delta_{\rm enc}/\gamma_{\rm rep}(\pi) .
Lemma 4 gives an orthogonal matrix Q ∈ O ​ ( d ) Q\in O(d) such that 𝔼 ​ ‖ h ​ ( z t ) − Q ​ z t ‖ 2 ≤ C ​ η \mathbb{E}\|h(z_{t})-Qz_{t}\|^{2}\leq C\eta .
This proves the state-identification bound.

It remains to prove the transition-identification bound.
Let e ​ ( z ) := h ​ ( z ) − Q ​ z e(z):=h(z)-Qz .
For the optimal predictor F h ⋆ F_{h}^{\star} , we decompose

[TABLE] F h ⋆ ​ ( h ​ ( z t ) , a t ) \displaystyle F_{h}^{\star}(h(z_{t}),a_{t}) − Q ​ ( A ​ z t + B ​ a t ) \displaystyle-Q(Az_{t}+Ba_{t}) (8) = 𝔼 ​ [ e ​ ( z t + 1 ) ∣ h ​ ( z t ) , a t ] \displaystyle=\mathbb{E}[e(z_{t+1})\mid h(z_{t}),a_{t}] + 𝔼 ​ [ Q ​ A ​ z t ∣ h ​ ( z t ) , a t ] − Q ​ A ​ z t . \displaystyle\quad+\mathbb{E}[QAz_{t}\mid h(z_{t}),a_{t}]-QAz_{t}.

The first term is bounded by Jensen’s inequality and stationarity:

[TABLE] 𝔼 ∥ 𝔼 [ e ( z t + 1 ) ∣ h ( z t ) , a t ] ∥ 2 ≤ 𝔼 ∥ e ( z t + 1 ) ∥ 2 = 𝔼 ∥ e ( z t ) ∥ 2 . \mathbb{E}\|\mathbb{E}[e(z_{t+1})\mid h(z_{t}),a_{t}]\|^{2}\leq\mathbb{E}\|e(z_{t+1})\|^{2}=\mathbb{E}\|e(z_{t})\|^{2}.

For the second term, conditional expectation is the best L 2 L^{2} approximation by functions of ( h ​ ( z t ) , a t ) (h(z_{t}),a_{t}) .
Using Q ​ A ​ Q ⊤ ​ h ​ ( z t ) QAQ^{\top}h(z_{t}) as a candidate, and writing r t := 𝔼 ​ [ Q ​ A ​ z t ∣ h ​ ( z t ) , a t ] − Q ​ A ​ z t r_{t}:=\mathbb{E}[QAz_{t}\mid h(z_{t}),a_{t}]-QAz_{t} , gives

[TABLE] 𝔼 ​ ‖ r t ‖ 2 \displaystyle\mathbb{E}\|r_{t}\|^{2} ≤ ‖ A ‖ op 2 ​ 𝔼 ​ ‖ h ​ ( z t ) − Q ​ z t ‖ 2 . \displaystyle\leq\|A\|_{\rm op}^{2}\mathbb{E}\!\left\|h(z_{t})-Qz_{t}\right\|^{2}. (9)

Thus

[TABLE] 𝔼 ​ ‖ F h ⋆ ​ ( h ​ ( z t ) , a t ) − Q ​ ( A ​ z t + B ​ a t ) ‖ 2 ≤ C ​ ( 1 + ‖ A ‖ op 2 ) ​ η . \mathbb{E}\|F_{h}^{\star}(h(z_{t}),a_{t})-Q(Az_{t}+Ba_{t})\|^{2}\leq C(1+\|A\|_{\rm op}^{2})\eta.

Finally, for a learned predictor F F satisfying 𝔼 ​ ‖ F ​ ( h ​ ( z t ) , a t ) − F h ⋆ ​ ( h ​ ( z t ) , a t ) ‖ 2 ≤ Δ pred \mathbb{E}\|F(h(z_{t}),a_{t})-F_{h}^{\star}(h(z_{t}),a_{t})\|^{2}\leq\Delta_{\rm pred} , the triangle inequality yields

[TABLE] 𝔼 ​ ‖ F ​ ( h ​ ( z t ) , a t ) − Q ​ ( A ​ z t + B ​ a t ) ‖ 2 \displaystyle\mathbb{E}\!\left\|F(h(z_{t}),a_{t})-Q(Az_{t}+Ba_{t})\right\|^{2} ≤ C ​ Δ pred \displaystyle\leq C\Delta_{\rm pred} (10) + C ​ ( 1 + ‖ A ‖ op 2 ) ​ η . \displaystyle\quad+C(1+\|A\|_{\rm op}^{2})\eta.

This completes the proof.
∎

## Appendix C Proof of Theorem 3

Let Y t = Q ​ z t Y_{t}=Qz_{t} . Under the identified coordinates,

[TABLE] Y t + 1 = Q ​ A ​ z t + Q ​ B ​ a t + Q ​ ξ t = F ⋆ ​ ( Y t , a t ) + Q ​ ξ t . Y_{t+1}=QAz_{t}+QBa_{t}+Q\xi_{t}=F^{\star}(Y_{t},a_{t})+Q\xi_{t}.

Since ξ t \xi_{t} is independent of ( z t , a t ) (z_{t},a_{t}) and has zero mean, F ⋆ ​ ( Y t , a t ) F^{\star}(Y_{t},a_{t}) is the conditional mean of Y t + 1 Y_{t+1} given ( Y t , a t ) (Y_{t},a_{t}) .

Consequently, the conditional-mean orthogonality identity gives, for every square-integrable predictor F F . Let d F ​ ( y , a ) := F ​ ( y , a ) − F ⋆ ​ ( y , a ) d_{F}(y,a):=F(y,a)-F^{\star}(y,a) .

[TABLE] ℰ π ​ ( F ) \displaystyle\mathcal{E}_{\pi}(F) = 𝔼 P π ​ [ ‖ d F ​ ( Y t , a t ) ‖ 2 ] . \displaystyle=\mathbb{E}_{P_{\pi}}\left[\|d_{F}(Y_{t},a_{t})\|^{2}\right]. (11)

Indeed, expanding the squared error yields

[TABLE] 𝔼 P π ​ [ ‖ Y t + 1 − F ​ ( Y t , a t ) ‖ 2 ] \displaystyle\mathbb{E}_{P_{\pi}}\left[\|Y_{t+1}-F(Y_{t},a_{t})\|^{2}\right] = 𝔼 P π ​ [ ‖ Y t + 1 − F ⋆ ​ ( Y t , a t ) ‖ 2 ] + 𝔼 P π ​ [ ‖ d F ​ ( Y t , a t ) ‖ 2 ] , \displaystyle\quad=\mathbb{E}_{P_{\pi}}\left[\|Y_{t+1}-F^{\star}(Y_{t},a_{t})\|^{2}\right]+\mathbb{E}_{P_{\pi}}\left[\|d_{F}(Y_{t},a_{t})\|^{2}\right],

because the cross term vanishes after conditioning on ( Y t , a t ) (Y_{t},a_{t}) .

Let v min ∈ ℝ m v_{\min}\in\mathbb{R}^{m} be a unit eigenvector of Σ tr ​ ( π ) \Sigma_{\mathrm{tr}}(\pi) associated with its smallest eigenvalue ρ tr ​ ( π ) > 0 \rho_{\mathrm{tr}}(\pi)>0 , and let u ∈ ℝ d u\in\mathbb{R}^{d} be any unit vector. Define

[TABLE] D δ := δ ρ tr ​ ( π ) ​ u ​ v min ⊤ D_{\delta}:=\sqrt{\frac{\delta}{\rho_{\mathrm{tr}}(\pi)}}\,uv_{\min}^{\top}

and construct

[TABLE] F δ ​ ( y , a ) := F ⋆ ​ ( y , a ) + D δ ​ ( a − μ π ​ ( Q ⊤ ​ y ) ) . F_{\delta}(y,a):=F^{\star}(y,a)+D_{\delta}\bigl(a-\mu_{\pi}(Q^{\top}y)\bigr).

Because ( z t , a t ) (z_{t},a_{t}) is jointly Gaussian, the conditional mean μ π ​ ( z ) = 𝔼 ​ [ a t ∣ z t = z ] \mu_{\pi}(z)=\mathbb{E}[a_{t}\mid z_{t}=z] is linear in z z . Hence F δ F_{\delta} is continuous and square-integrable.

Let r t := a t − μ π ​ ( z t ) r_{t}:=a_{t}-\mu_{\pi}(z_{t}) . By definition, 𝔼 ​ [ r t ∣ z t ] = 0 \mathbb{E}[r_{t}\mid z_{t}]=0 , and

[TABLE] 𝔼 ​ [ r t ​ r t ⊤ ] = 𝔼 z t ​ [ Cov π ⁡ ( a t ∣ z t ) ] = Σ tr ​ ( π ) . \mathbb{E}[r_{t}r_{t}^{\top}]=\mathbb{E}_{z_{t}}\left[\operatorname{Cov}_{\pi}(a_{t}\mid z_{t})\right]=\Sigma_{\mathrm{tr}}(\pi).

Using Eq. ( 11 ),

[TABLE] ℰ π ​ ( F δ ) \displaystyle\mathcal{E}_{\pi}(F_{\delta}) = 𝔼 ​ [ ‖ D δ ​ r t ‖ 2 ] \displaystyle=\mathbb{E}\left[\|D_{\delta}r_{t}\|^{2}\right] = tr ⁡ ( D δ ​ Σ tr ​ ( π ) ​ D δ ⊤ ) \displaystyle=\operatorname{tr}\left(D_{\delta}\Sigma_{\mathrm{tr}}(\pi)D_{\delta}^{\top}\right) = δ ρ tr ​ ( π ) ​ tr ⁡ ( u ​ v min ⊤ ​ Σ tr ​ ( π ) ​ v min ​ u ⊤ ) \displaystyle=\frac{\delta}{\rho_{\mathrm{tr}}(\pi)}\operatorname{tr}\left(uv_{\min}^{\top}\Sigma_{\mathrm{tr}}(\pi)v_{\min}u^{\top}\right) = δ ρ tr ​ ( π ) ​ ρ tr ​ ( π ) ​ ‖ u ‖ 2 = δ . \displaystyle=\frac{\delta}{\rho_{\mathrm{tr}}(\pi)}\rho_{\mathrm{tr}}(\pi)\|u\|^{2}=\delta.

Under the counterfactual distribution, a cf − μ π ​ ( z ) = η cf a_{\rm cf}-\mu_{\pi}(z)=\eta_{\rm cf} with η cf ∼ 𝒩 ​ ( 0 , I m ) \eta_{\rm cf}\sim\mathcal{N}(0,I_{m}) . Therefore,

[TABLE] ℰ cf ​ ( F δ ) \displaystyle\mathcal{E}_{\rm cf}(F_{\delta}) = 𝔼 ​ [ ‖ D δ ​ η cf ‖ 2 ] \displaystyle=\mathbb{E}\left[\|D_{\delta}\eta_{\rm cf}\|^{2}\right] = tr ⁡ ( D δ ​ D δ ⊤ ) \displaystyle=\operatorname{tr}(D_{\delta}D_{\delta}^{\top}) = ‖ D δ ‖ F 2 \displaystyle=\|D_{\delta}\|_{F}^{2} = δ ρ tr ​ ( π ) ​ ‖ u ‖ 2 ​ ‖ v min ‖ 2 \displaystyle=\frac{\delta}{\rho_{\mathrm{tr}}(\pi)}\|u\|^{2}\|v_{\min}\|^{2} = δ ρ tr ​ ( π ) . \displaystyle=\frac{\delta}{\rho_{\mathrm{tr}}(\pi)}.

This proves the result.
∎

For the behavior policy

[TABLE] a t = 1 − σ 2 ​ K ​ z t + σ ​ η t , a_{t}=\sqrt{1-\sigma^{2}}\,Kz_{t}+\sigma\eta_{t},

the conditional mean is μ π σ ​ ( z t ) = 1 − σ 2 ​ K ​ z t \mu_{\pi_{\sigma}}(z_{t})=\sqrt{1-\sigma^{2}}\,Kz_{t} . Since η t ∼ 𝒩 ​ ( 0 , I m ) \eta_{t}\sim\mathcal{N}(0,I_{m}) is independent of z t z_{t} ,

[TABLE] Cov π σ ⁡ ( a t ∣ z t ) = σ 2 ​ I m . \operatorname{Cov}_{\pi_{\sigma}}(a_{t}\mid z_{t})=\sigma^{2}I_{m}.

It follows immediately that

[TABLE] Σ tr ​ ( π σ ) = 𝔼 z t ​ [ Cov π σ ⁡ ( a t ∣ z t ) ] = σ 2 ​ I m \Sigma_{\mathrm{tr}}(\pi_{\sigma})=\mathbb{E}_{z_{t}}\left[\operatorname{Cov}_{\pi_{\sigma}}(a_{t}\mid z_{t})\right]=\sigma^{2}I_{m}

and hence

[TABLE] ρ tr ​ ( π σ ) = λ min ​ ( Σ tr ​ ( π σ ) ) = σ 2 . \rho_{\mathrm{tr}}(\pi_{\sigma})=\lambda_{\min}\left(\Sigma_{\mathrm{tr}}(\pi_{\sigma})\right)=\sigma^{2}.

For every σ > 0 \sigma>0 , applying
Theorem 3 gives ℰ cf ​ ( F δ ) = δ / σ 2 \mathcal{E}_{\rm cf}(F_{\delta})=\delta/\sigma^{2} .

When σ = 0 \sigma=0 , the action is the deterministic function a t = K ​ z t a_{t}=Kz_{t} , so a t − μ π 0 ​ ( z t ) = 0 a_{t}-\mu_{\pi_{0}}(z_{t})=0 . Let u ∈ ℝ d u\in\mathbb{R}^{d} and v ∈ ℝ m v\in\mathbb{R}^{m} be arbitrary unit vectors, and define

[TABLE] F ~ ​ ( y , a ) := F ⋆ ​ ( y , a ) + u ​ v ⊤ ​ ( a − μ π 0 ​ ( Q ⊤ ​ y ) ) . \widetilde{F}(y,a):=F^{\star}(y,a)+uv^{\top}\bigl(a-\mu_{\pi_{0}}(Q^{\top}y)\bigr).

Then F ~ = F ⋆ \widetilde{F}=F^{\star} under P π 0 P_{\pi_{0}} , and therefore ℰ π 0 ​ ( F ~ ) = 0 \mathcal{E}_{\pi_{0}}(\widetilde{F})=0 . Under the counterfactual action distribution,

[TABLE] ℰ cf ​ ( F ~ ) = 𝔼 ​ [ ‖ u ​ v ⊤ ​ η cf ‖ 2 ] = 1 . \mathcal{E}_{\rm cf}(\widetilde{F})=\mathbb{E}\left[\|uv^{\top}\eta_{\rm cf}\|^{2}\right]=1.

Thus distinct continuous predictors attain the same on-policy risk while producing different counterfactual predictions, proving structural non-identifiability at σ = 0 \sigma=0 .
∎

## Appendix D Experimental Details

## Model, optimization, and evaluation.

All experiments use two-dimensional latent states, observations, and actions. The encoder and action-conditioned predictor use 8-layer SiLU MLPs with hidden width 512. Both representation and coverage runs use 100 , 000 100{,}000 one-step transitions, 5 , 000 5{,}000 AdamW updates, gradient clipping at 1.0, and a 500-step warmup followed by cosine decay. They use batch size 1024, learning rate 10 − 3 10^{-3} , and weight decay 10 − 5 10^{-5} . The objective is

[TABLE] ℒ \displaystyle\mathcal{L} = ℒ pred + λ white ​ ℒ white + λ gauss ​ ℒ gauss , \displaystyle=\mathcal{L}_{\rm pred}+\lambda_{\rm white}\mathcal{L}_{\rm white}+\lambda_{\rm gauss}\mathcal{L}_{\rm gauss}, (12) λ white \displaystyle\lambda_{\rm white} = 1 , λ gauss = 50 . \displaystyle=1,\qquad\lambda_{\rm gauss}=0.

where ℒ gauss \mathcal{L}_{\rm gauss} is a sliced characteristic-function regularizer toward a standard Gaussian. Each run uses 10 , 000 10{,}000 evaluation transitions and a separate set of 5 , 000 5{,}000 states to fit the orthogonal Procrustes alignment Q ⋆ Q^{\star} . Both sweeps use five independent runs for each observation map.

For y i = h ​ ( g ​ ( z i ) ) y_{i}=h(g(z_{i})) , the normalized representation and controlled-transition errors are

[TABLE] E rep \displaystyle E_{\rm rep} := ∑ i ‖ y i − Q ⋆ ​ z i ‖ 2 ∑ i ‖ z i ‖ 2 , \displaystyle=\frac{\sum_{i}\|y_{i}-Q^{\star}z_{i}\|^{2}}{\sum_{i}\|z_{i}\|^{2}}, (13) E tr \displaystyle E_{\rm tr} := ∑ i ‖ F ​ ( y i , a i ) − Q ⋆ ​ ( A ​ z i + B ​ a i ) ‖ 2 ∑ i ‖ A ​ z i + B ​ a i ‖ 2 . \displaystyle=\frac{\sum_{i}\|F(y_{i},a_{i})-Q^{\star}(Az_{i}+Ba_{i})\|^{2}}{\sum_{i}\|Az_{i}+Ba_{i}\|^{2}}.

All transition metrics compare predictions with the noise-free conditional mean, not with sampled next states.

## D.1 Representation Sweep

Let R θ R_{\theta} denote a two-dimensional rotation and define

[TABLE] A ​ ( q ) \displaystyle A(q) = R 30 ∘ ​ D ​ ( q ) ​ R 20 ∘ ⊤ , \displaystyle=R_{30^{\circ}}D(q)R_{20^{\circ}}^{\top}, (14) B ​ ( q ) \displaystyle B(q) = R 30 ∘ ​ D ​ ( q ) ​ R − 20 ∘ ⊤ , \displaystyle=R_{30^{\circ}}D(q)R_{-20^{\circ}}^{\top}, D ​ ( q ) \displaystyle D(q) = diag ⁡ ( 0.30 , q / 2 ) . \displaystyle=\operatorname{diag}\!\left(\sqrt{0.30},\sqrt{q/2}\right).

Actions are independent standard Gaussian, and the process covariance is Cov ⁡ ( ξ t ) = I − A ​ A ⊤ − B ​ B ⊤ \operatorname{Cov}(\xi_{t})=I-AA^{\top}-BB^{\top} . Consequently, z t z_{t} , a t a_{t} , and z t + 1 z_{t+1} are standard Gaussian in marginal distribution, while

[TABLE] spec ⁡ ( A ​ A ⊤ + B ​ B ⊤ ) = { 0.6 , q } , γ rep ​ ( q ) = q − 0.36 . \operatorname{spec}(AA^{\top}+BB^{\top})=\{0.6,q\},\qquad\gamma_{\rm rep}(q)=q-0.36.

We use

[TABLE] q ∈ { 0.1 , 0.2 , 0.3 , 0.36 , 0.4 , 0.5 , 0.6 } . q\in\{0.1,0.2,0.3,0.36,0.4,0.5,0.6\}.

The four observation maps are:

[TABLE] spiral: u = R 0.8 ​ π ​ ‖ z ‖ ​ z , \displaystyle u=R_{0.8\pi\|z\|}z, g ​ ( z ) = ( 1 + 0.45 ​ tanh ⁡ ( u 1 ) ) ​ u , \displaystyle g(z)=(1+0.45\tanh(u_{1}))u, parabolic: g ​ ( z ) = ( z 1 , z 2 + 0.75 ​ z 1 2 ) , \displaystyle g(z)=(z_{1},\ z_{2}+0.75z_{1}^{2}), sinusoidal: g ​ ( z ) = ( z 1 + 1.75 ​ sin ⁡ ( 1.5 ​ z 2 ) , z 2 ) , \displaystyle g(z)=(z_{1}+1.75\sin(1.5z_{2}),\ z_{2}), wave: u 1 = z 1 + 0.65 ​ sin ⁡ ( 1.4 ​ z 2 ) , \displaystyle u_{1}=z_{1}+0.65\sin(1.4z_{2}), u 2 = z 2 + 0.55 ​ sin ⁡ ( 1.2 ​ u 1 + 0.4 ) , \displaystyle u_{2}=z_{2}+0.55\sin(1.2u_{1}+0.4), g ​ ( z ) = ( u 1 + 0.40 ​ sin ⁡ ( 1.7 ​ u 2 − 0.3 ) , u 2 ) . \displaystyle g(z)=(u_{1}+0.40\sin(1.7u_{2}-0.3),\ u_{2}).

Figure 2 uses q = 0.50 q=0.50 .

## D.2 Coverage Sweep

We use the state-dependent Gaussian behavior policy

[TABLE] a t \displaystyle a_{t} = 1 − σ 2 ​ K ​ z t + σ ​ η t , \displaystyle=\sqrt{1-\sigma^{2}}\,Kz_{t}+\sigma\eta_{t}, (15) η t ∼ 𝒩 ​ ( 0 , I ) , η t ⟂ z t , K ​ K ⊤ = I . \displaystyle\eta_{t}\sim\mathcal{N}(0,I),\quad\eta_{t}\perp z_{t},\quad KK^{\top}=I.

The coverage levels and feedback matrix are

[TABLE] σ ∈ { 0 , 0.2 , 0.4 , 0.6 , 0.8 , 1 } , K = R 45 ∘ , \sigma\in\{0,0.2,0.4,0.6,0.8,1\},\qquad K=R_{45^{\circ}},

We reuse Eq. ( 14 ) with q = 0.50 q=0.50 and run the coverage sweep independently for all four observation maps listed above. Under the state-dependent policy in Eq. ( 15 ), the predictable covariance is

[TABLE] R π ​ ( σ ) = A ​ A ⊤ + B ​ B ⊤ + 1 − σ 2 ​ ( A ​ K ⊤ ​ B ⊤ + B ​ K ​ A ⊤ ) . R_{\pi}(\sigma)=AA^{\top}+BB^{\top}+\sqrt{1-\sigma^{2}}\left(AK^{\top}B^{\top}+BKA^{\top}\right). (16)

For each σ \sigma , we set the independent zero-mean process-noise covariance to

[TABLE] Cov ⁡ ( ξ t ) = I − R π ​ ( σ ) \operatorname{Cov}(\xi_{t})=I-R_{\pi}(\sigma)

so that current and next states have the same standard-Gaussian marginal. The controlled conditional mean A ​ z + B ​ a Az+Ba , observation map, and action marginal are fixed across the sweep, but the full stochastic transition kernel is therefore indexed by σ \sigma through this stationarity-preserving noise adjustment. The process-noise trace changes mildly, from 0.8 0.8 at σ = 0 \sigma=0 to 0.9 0.9 at σ = 1 \sigma=1 . The representation margin γ rep ​ ( σ ) = λ min ​ ( R π ​ ( σ ) ) − λ max ​ ( R π ​ ( σ ) ) 2 \gamma_{\rm rep}(\sigma)=\lambda_{\min}(R_{\pi}(\sigma))-\lambda_{\max}(R_{\pi}(\sigma))^{2} ranges from 0.118 0.118 to 0.140 0.140 and is not used as a training or model-selection gate.

The counterfactual actions are sampled once from 𝒩 ​ ( 0 , 2 2 ​ I ) \mathcal{N}(0,2^{2}I) and shared across all coverage levels and training runs. This intervention probes weakly covered parts of the action plane while keeping the evaluation distribution fixed across the sweep. For held-out states z i z_{i} , let y i = h ​ ( g ​ ( z i ) ) y_{i}=h(g(z_{i})) , let a i beh a_{i}^{\rm beh} denote the corresponding behavior action, and let a i cf ∼ 𝒩 ​ ( 0 , 2 2 ​ I ) a_{i}^{\rm cf}\sim\mathcal{N}(0,2^{2}I) denote the counterfactual action. The per-coordinate transition errors are

[TABLE] E trans beh \displaystyle E_{\rm trans}^{\rm beh} = 1 n ​ d ​ ∑ i = 1 n ‖ F ​ ( y i , a i beh ) − Q ⋆ ​ ( A ​ z i + B ​ a i beh ) ‖ 2 , \displaystyle=\frac{1}{nd}\sum_{i=1}^{n}\bigl\|F(y_{i},a_{i}^{\rm beh})-Q^{\star}(Az_{i}+Ba_{i}^{\rm beh})\bigr\|^{2}, (17) E trans cf \displaystyle E_{\rm trans}^{\rm cf} = 1 n ​ d ​ ∑ i = 1 n ‖ F ​ ( y i , a i cf ) − Q ⋆ ​ ( A ​ z i + B ​ a i cf ) ‖ 2 . \displaystyle=\frac{1}{nd}\sum_{i=1}^{n}\bigl\|F(y_{i},a_{i}^{\rm cf})-Q^{\star}(Az_{i}+Ba_{i}^{\rm cf})\bigr\|^{2}.

Their ratio E trans cf / E trans beh E_{\rm trans}^{\rm cf}/E_{\rm trans}^{\rm beh} is the empirical counterfactual amplification.

To assess identification of the state and action components separately, we sample independent probe actions a i probe ∼ 𝒩 ​ ( 0 , I ) a_{i}^{\rm probe}\sim\mathcal{N}(0,I) and fit

[TABLE] F ​ ( y i , a i probe ) ≈ M ^ ​ y i + N ^ ​ a i probe F(y_{i},a_{i}^{\rm probe})\approx\widehat{M}y_{i}+\widehat{N}a_{i}^{\rm probe}

by least squares. The relative component error is

[TABLE] E T \displaystyle E_{T} = ‖ T ^ − T ⋆ ‖ F ‖ T ⋆ ‖ F , \displaystyle=\frac{\|\widehat{T}-T^{\star}\|_{F}}{\|T^{\star}\|_{F}}, (18) ( T ^ , T ⋆ ) \displaystyle(\widehat{T},T^{\star}) ∈ { ( M ^ , Q ⋆ ​ A ​ Q ⋆ ⊤ ) , ( N ^ , Q ⋆ ​ B ) } . \displaystyle\in\left\{\left(\widehat{M},Q^{\star}AQ^{\star\top}\right),\left(\widehat{N},Q^{\star}B\right)\right\}.

The counterfactual field in Figure 4 uses z 0 = ( 1 , 0 ) z_{0}=(1,0) and an action grid over [ − 2.2 , 2.2 ] 2 [-2.2,2.2]^{2} .

## D.3 Planning Probe

The planning visualization uses the seed-0 spiral-map model at each coverage level. We set z init = ( 0 , 0 ) z_{\rm init}=(0,0) , horizon H = 6 H=6 , and visualization goal z g = ( 0.85 , 0.55 ) z_{g}=(0.85,0.55) . The current and goal observations are encoded as y init = h ​ ( g ​ ( z init ) ) y_{\rm init}=h(g(z_{\rm init})) and y g = h ​ ( g ​ ( z g ) ) y_{g}=h(g(z_{g})) . The common candidate bank contains 210 constant-action sequences: seven radii uniformly spaced from 0 to 1.4 1.4 , crossed with 30 uniformly spaced directions. For each candidate, the learned model is rolled forward from y init y_{\rm init} , and the selected sequence minimizes ‖ y ^ H − y g ‖ \|\widehat{y}_{H}-y_{g}\| . Thus neither the true latent coordinates nor Q ⋆ Q^{\star} enter action selection. After selection, Q ⋆ ⊤ Q^{\star\top} is used only to display predicted endpoints in the latent coordinate system. The executed endpoint is obtained from the true noise-free recursion z t + 1 = A ​ z t + B ​ a t z_{t+1}=Az_{t}+Ba_{t} .

The aggregate evaluation uses all five seeds for all four observation maps. Each of the 180 nonzero endpoints reachable by the common candidate bank is used once as a goal, and we report the mean executed terminal error over this goal set for each checkpoint. Because every goal is generated by a candidate in the bank, the candidate-bank oracle error is zero. Figure 7 reports the mean and bootstrap 95% confidence interval across seeds.