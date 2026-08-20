---
title: "AdaWorld: Learning Adaptable World Models with Latent Actions"
source: "https://arxiv.org/abs/2503.18938"
author:
  - "[[Shenyuan Gao]]"
  - "[[Siyuan Zhou]]"
  - "[[Yilun Du]]"
  - "[[Jun Zhang]]"
  - "[[Chuang Gan]]"
published: 2025-03-24
created: 2026-08-11
description: "AdaWorld: action-aware world model pretraining where the action condition is a CONTINUOUS latent action extracted self-supervised from raw video by an information-bottleneck autoencoder (encoder sees two consecutive frames, decoder must predict the second from the first plus the compact code; beta = 2e-4 trades expressiveness against context disentangling). Pretrained on ~2000M frames from four public datasets (SSv2, Ego4D, Open X-Embodiment, MiraData) plus video auto-collected from 1016 Gym Retro + Procgen environments. Adaptation to an unseen environment = learning the MAPPING from its action space to latent actions: 100 samples per action and 800 finetune steps. Key numbers: LIBERO action transfer FVD 767.0 vs 1545.2 action-agnostic / 1409.5 optical-flow-conditioned / 1504.5 discrete VQ-8 (Genie-style); SSv2 473.4 vs 847.2/702.8/726.8; Procgen visual planning (MPC) 56.67% average with finetune, 44.83% without, vs 26.00% action-agnostic and 26.17% RANDOM (i.e. the action-agnostic baseline is at chance); unseen-env PSNR/LPIPS gains over discrete and flow baselines are small (e.g. Habitat 23.58/0.327 vs 23.31/0.342). UMAP over 1000 samples per action from Habitat/Minecraft/DMLab shows same-action clustering across environments (context invariance), but the paper states lower beta increases expressiveness while REDUCING cross-environment action overlap. Limitations stated: not real-time, cannot create novel content beyond the initial scene, no extremely long rollouts. ICML 2025 (PMLR v267, gao25u), arXiv:2503.18938v4."
tags:
  - "clippings"
  - "vocabulary-co-discovery"
  - "latent-actions"
  - "world-models"
  - "transfer"
  - "information-bottleneck"
---

Title: AdaWorld: Learning Adaptable World Models with Latent Actions
Venue: ICML 2025 (PMLR v267). Text below extracted from the arXiv v4 HTML.


## AdaWorld: Learning Adaptable World Models with Latent Actions

World models aim to learn action-controlled future prediction and have proven essential for the development of intelligent agents. However, most existing world models rely heavily on substantial action-labeled data and costly training, making it challenging to adapt to novel environments with heterogeneous actions through limited interactions. This limitation can hinder their applicability across broader domains. To overcome this limitation, we propose AdaWorld , an innovative world model learning approach that enables efficient adaptation. The key idea is to incorporate action information during the pretraining of world models. This is achieved by extracting latent actions from videos in a self-supervised manner, capturing the most critical transitions between frames. We then develop an autoregressive world model that conditions on these latent actions. This learning paradigm enables highly adaptable world models, facilitating efficient transfer and learning of new actions even with limited interactions and finetuning. Our comprehensive experiments across multiple environments demonstrate that AdaWorld achieves superior performance in both simulation quality and visual planning.

adaptable-world-model.github.io

## 1 Introduction

Figure 1: Different world model learning paradigms. Prior methods often require expensive labeling and training to achieve action controllability in new environments. To overcome this, we introduce latent actions as a unified condition for action-aware pretraining from videos, enabling highly adaptable world modeling. Our world model, dubbed AdaWorld , can readily transfer actions across contexts without training. By initializing the control interface with the corresponding latent actions, AdaWorld can also be adapted into specialized world models efficiently and achieve significantly better planning results than the action-agnostic baseline.

Intelligent agents should perform effectively across various tasks (Reed et al., 2022 ; Lee et al., 2022 ; Durante et al., 2024 ; Raad et al., 2024 ) . A promising solution to this objective is developing world models that can simulate different environments (Wu et al., 2023 , 2024 ; Yang et al., 2024c ; Hansen et al., 2024 ) . Recent world models are typically initialized from pretrained video models (Xiang et al., 2024 ; Agarwal et al., 2025 ; He et al., 2025 ) . Despite improved generalization, these models still require substantial action labels and high training costs to acquire precise action controllability. While pseudo labels can be annotated for videos (Baker et al., 2022 ; Zhang et al., 2022 ) , defining a unified action format for general environments is challenging. As a result, existing methods often require costly training when adapting to new environments with varying action specifications (Gao et al., 2024 ; Chi et al., 2024 ; Che et al., 2025 ) . These limitations pose great challenges for transferring and learning new actions based on limited interactions and finetuning.

As humans, we can estimate the effects of different actions through limited experiences (Ha & Schmidhuber, 2018 ) . This ability likely arises from our internal representations of actions learned from extensive observations (Rizzolatti et al., 1996 ; Romo et al., 2004 ; Dominici et al., 2011 ) . These common knowledge can be reused across different contexts and associated with specific action spaces efficiently (Rybkin et al., 2019 ; Schmeckpeper et al., 2020 ; Sun et al., 2024 ) . Consequently, humans can easily transfer observed actions to various contexts and imagine the transitions of new environments through a few interactions (Poggio & Bizzi, 2004 ) . These insights motivate us to ponder: can we achieve human-like adaptability in world modeling by learning transferrable action representations from observations?

In this paper, we propose AdaWorld , an innovative pretraining approach for highly adaptable world models. Unlike previous methods that only pretrain on action-agnostic videos, we argue that incorporating action information during pretraining will significantly enhance the adaptability of world models. As illustrated in Figure 1 , the adaptability of AdaWorld primarily manifests in two aspects: (1) Given one demonstration of an action, AdaWorld can readily transfer that action to various contexts without further training. (2) It can also be efficiently adapted into specialized world models with raw action inputs via minor interactions and finetuning, enabling more effective planning in various environments.

AdaWorld consists of two key components: a latent action autoencoder that extracts actions from unlabeled videos, and an autoregressive world model that takes the extracted actions as conditions. Our main challenge is that in-the-wild videos often involve complicated contexts ( e.g . , colors and textures), which hinders effective action recognition. To overcome this challenge, we introduce an information bottleneck design to our latent action autoencoder. Specifically, the latent action encoder extracts a compact encoding from two consecutive frames. We refer to this encoding as latent action hereinafter, as it is used to represent the transition between these two frames. Based on the latent action and the former frame, the latent action decoder makes its best effort to predict the subsequent frame. By minimizing the prediction loss using the minimal information encoded in the latent action, our autoencoder is encouraged to disentangle the most critical action from its context. Unlike previous methods (Bruce et al., 2024 ; Chen et al., 2024b ; Ye et al., 2025 ) that focus on playability and behavior cloning, we compress the latent actions into a continuous latent space to maximize expressiveness and enable flexible composition. We find that our latent actions are context-invariant and can be effectively transferred across different contexts.

We then pretrain an autoregressive world model that conditions on the latent actions. Thanks to the strong transferability of our latent actions, the resulting world model is readily adaptable to various environments. In particular, since our world model has learned to simulate different actions represented by any latent actions, adapting to a new environment is akin to finding the mapping of corresponding latent actions for its action space. Given one demonstration of an action, our model can readily transfer the demonstrated action by extracting the latent action with latent action encoder and reusing it across different contexts. When action labels are provided, we can similarly obtain their latent actions and initialize the control interface efficiently. This enables us to adapt our model to specialized world models with minimal finetuning. When only a limited number of interactions are available ( e.g . , 50 interactions), our approach is significantly more efficient than pretraining from action-agnostic videos.

Note that our approach is as scalable as existing video pretraining methods (Seo et al., 2022 ; Mendonca et al., 2023 ; Wu et al., 2023 ; Agarwal et al., 2025 ; He et al., 2025 ; Yu et al., 2025 ) . To enhance the generalization ability of AdaWorld, we collect a large corpus of videos from thousands of environments through automated generation. The resulting dataset encompasses extensive interactive scenarios, spanning from ego perspectives and third-person views to virtual games and real-world activities. After action-aware pretraining at scale, we show that the adaptability of AdaWorld can seamlessly generalize to a wide variety of domains.

In summary, we make the following contributions:

• We present AdaWorld, an autoregressive world model that is highly adaptable across various environments. It can readily transfer actions to different contexts and allows efficient adaptation with limited interactions.

We present AdaWorld, an autoregressive world model that is highly adaptable across various environments. It can readily transfer actions to different contexts and allows efficient adaptation with limited interactions.

• We establish AdaWorld on a large-scale dataset sourced from extremely diverse environments. After extensive pretraining, AdaWorld demonstrates strong generalization capabilities across various domains.

We establish AdaWorld on a large-scale dataset sourced from extremely diverse environments. After extensive pretraining, AdaWorld demonstrates strong generalization capabilities across various domains.

• We conduct comprehensive experiments across multiple environments to verify the efficacy of AdaWorld. Our model achieves promising results in action transfer, world model adaptation, and visual planning.

We conduct comprehensive experiments across multiple environments to verify the efficacy of AdaWorld. Our model achieves promising results in action transfer, world model adaptation, and visual planning.

## 2 Method

In this section, we first introduce the architectural design of our latent action autoencoder ( Sec. 2.1 ). By leveraging the latent actions as conditions, we then build an autoregressive world model through action-aware pretraining ( Sec. 2.2 ). Finally, we demonstrate how our model facilitates highly adaptable world modeling ( Sec. 2.3 ).

## 2.1 Latent Action Autoencoder

Instead of only taking actionless videos for world model pretraining, our key innovation is to incorporate action information during the pretraining phase. Benefiting from the pretrained knowledge of action controllability, the resulting world models can be efficiently adapted using limited ground truth actions. However, action labels are rarely available for in-the-wild videos. While a common practice is to collect these labels through interactions, collecting them across a multitude of environments incurs significant labor. Furthermore, defining a unified action format across diverse environments is often unfeasible, and current world models require costly training to accommodate new action formats.

Figure 2: Latent action autoencoder. With an information bottleneck design, our latent action autoencoder is able to extract the most critical action information from videos and compresses it into a continuous latent action.

To address these challenges, instead of relying on explicit action annotations, we propose extracting latent actions from videos as a unified condition for world model pretraining. Nevertheless, in general videos, the action information is often entangled with the contexts, posing significant difficulty for effective action recognition. Inspired by the observation that agents’ actions often drive the dominant variation in most interactive scenarios (Rybkin et al., 2019 ; Menapace et al., 2021 , 2022 ; Bruce et al., 2024 ) , we introduce an information bottleneck to automatically differentiate actions from observations.

To be specific, we instantiate a latent action autoencoder based on the Transformer architecture (Vaswani et al., 2017 ) , where the encoder extracts the latent action a ~ ~ 𝑎 \tilde{a} over~ start_ARG italic_a end_ARG from two consecutive frames f t : t + 1 subscript 𝑓 : 𝑡 𝑡 1 f_{t:t+1} italic_f start_POSTSUBSCRIPT italic_t : italic_t + 1 end_POSTSUBSCRIPT , and the decoder predicts the subsequent frame f t + 1 subscript 𝑓 𝑡 1 f_{t+1} italic_f start_POSTSUBSCRIPT italic_t + 1 end_POSTSUBSCRIPT based on the latent action a ~ ~ 𝑎 \tilde{a} over~ start_ARG italic_a end_ARG and the former frame f t subscript 𝑓 𝑡 f_{t} italic_f start_POSTSUBSCRIPT italic_t end_POSTSUBSCRIPT . The latent action encoder divides two frames f t : t + 1 subscript 𝑓 : 𝑡 𝑡 1 f_{t:t+1} italic_f start_POSTSUBSCRIPT italic_t : italic_t + 1 end_POSTSUBSCRIPT into image patches of size 16 × 16 16 16 16\times 16 16 × 16 . These patches are then projected to patch embeddings and flattened along the spatial dimension. Afterwards, they are concatenated with two learnable tokens a t : t + 1 subscript 𝑎 : 𝑡 𝑡 1 a_{t:t+1} italic_a start_POSTSUBSCRIPT italic_t : italic_t + 1 end_POSTSUBSCRIPT . Sinusoidal position embeddings (Dosovitskiy et al., 2021 ) are also applied to each frame to indicate the spatial information. To efficiently encode the tokens from these two frames, we employ a spatiotemporal Transformer (Bruce et al., 2024 ) with L 𝐿 L italic_L stacked blocks. Each block comprises interleaved spatial and temporal attention modules, followed by a feed-forward network. The spatial attention can attend to all tokens within each frame, while the temporal attention has access to the two tokens in the same spatial positions across the two frames. We also incorporate rotary embeddings (Su et al., 2024 ) in temporal attentions to indicate the causal relationship. After sufficient attention correlations, the learnable tokens a t : t + 1 subscript 𝑎 : 𝑡 𝑡 1 a_{t:t+1} italic_a start_POSTSUBSCRIPT italic_t : italic_t + 1 end_POSTSUBSCRIPT can adaptively aggregate the temporal dynamics between the two input frames. We then discard all tokens and only project a t + 1 subscript 𝑎 𝑡 1 a_{t+1} italic_a start_POSTSUBSCRIPT italic_t + 1 end_POSTSUBSCRIPT to estimate the posterior of the latent action ( μ a ~ , σ a ~ ) subscript 𝜇 ~ 𝑎 subscript 𝜎 ~ 𝑎 (\mu_{\tilde{a}},\sigma_{\tilde{a}}) ( italic_μ start_POSTSUBSCRIPT over~ start_ARG italic_a end_ARG end_POSTSUBSCRIPT , italic_σ start_POSTSUBSCRIPT over~ start_ARG italic_a end_ARG end_POSTSUBSCRIPT ) following the standard VAE (Kingma & Welling, 2014 ) . Subsequently, we sample a ~ ~ 𝑎 \tilde{a} over~ start_ARG italic_a end_ARG from the approximated posterior and attach it to f t subscript 𝑓 𝑡 f_{t} italic_f start_POSTSUBSCRIPT italic_t end_POSTSUBSCRIPT , which is then sent to the latent action decoder. The latent action decoder is a spatial Transformer that predicts the subsequent frame f t + 1 subscript 𝑓 𝑡 1 f_{t+1} italic_f start_POSTSUBSCRIPT italic_t + 1 end_POSTSUBSCRIPT in the pixel space. The whole latent action autoencoder is optimized with the VAE objective:

[TABLE] ℒ θ , ϕ p ⁢ r ⁢ e ⁢ d ⁢ ( f t + 1 ) = subscript superscript ℒ 𝑝 𝑟 𝑒 𝑑 𝜃 italic-ϕ subscript 𝑓 𝑡 1 absent \displaystyle\mathcal{L}^{pred}_{\theta,\phi}(f_{t+1})= caligraphic_L start_POSTSUPERSCRIPT italic_p italic_r italic_e italic_d end_POSTSUPERSCRIPT start_POSTSUBSCRIPT italic_θ , italic_ϕ end_POSTSUBSCRIPT ( italic_f start_POSTSUBSCRIPT italic_t + 1 end_POSTSUBSCRIPT ) = 𝔼 q ϕ ⁢ ( a ~ | f t : t + 1 ) ⁢ log ⁡ p θ ⁢ ( f t + 1 | a ~ , f t ) subscript 𝔼 subscript 𝑞 italic-ϕ conditional ~ 𝑎 subscript 𝑓 : 𝑡 𝑡 1 subscript 𝑝 𝜃 conditional subscript 𝑓 𝑡 1 ~ 𝑎 subscript 𝑓 𝑡 \displaystyle\;\mathbb{E}_{q_{\phi}(\tilde{a}|f_{t:t+1})}\log p_{\theta}(f_{t+%
1}|\tilde{a},f_{t}) blackboard_E start_POSTSUBSCRIPT italic_q start_POSTSUBSCRIPT italic_ϕ end_POSTSUBSCRIPT ( over~ start_ARG italic_a end_ARG | italic_f start_POSTSUBSCRIPT italic_t : italic_t + 1 end_POSTSUBSCRIPT ) end_POSTSUBSCRIPT roman_log italic_p start_POSTSUBSCRIPT italic_θ end_POSTSUBSCRIPT ( italic_f start_POSTSUBSCRIPT italic_t + 1 end_POSTSUBSCRIPT | over~ start_ARG italic_a end_ARG , italic_f start_POSTSUBSCRIPT italic_t end_POSTSUBSCRIPT ) (1) − D K ⁢ L ( q ϕ ( a ~ | f t : t + 1 ) | | p ( a ~ ) ) . \displaystyle-D_{KL}(q_{\phi}(\tilde{a}|f_{t:t+1})||p(\tilde{a})). - italic_D start_POSTSUBSCRIPT italic_K italic_L end_POSTSUBSCRIPT ( italic_q start_POSTSUBSCRIPT italic_ϕ end_POSTSUBSCRIPT ( over~ start_ARG italic_a end_ARG | italic_f start_POSTSUBSCRIPT italic_t : italic_t + 1 end_POSTSUBSCRIPT ) | | italic_p ( over~ start_ARG italic_a end_ARG ) ) .

Compared to the original pixel space, the dimension of our latent action is extremely compact. Hence, it is challenging to forward the entire subsequent frame to the decoder via latent action. To minimize the prediction error of the subsequent frame, the latent action a ~ ~ 𝑎 \tilde{a} over~ start_ARG italic_a end_ARG must encapsulate the most critical variations relative to the former frame. This results in context-invariant action representations that closely correspond to the true actions taken by the agents.

Figure 3: Action-aware pretraining. We extract latent actions from unlabeled videos using the latent action encoder. By leveraging the extracted actions as a unified condition, we pretrain a world model that can perform autoregressive rollouts at inference.

Figure 4: Action transfer from demonstrations. By extracting and reusing the latent actions in different contexts, AdaWorld can readily transfer the demonstrated actions from source videos to various target scenes without training. Please see Appendix C for more results.

Nevertheless, we empirically find that our latent action autoencoder, trained using the aforementioned formulation, struggles to express diverse transitions between frames. This problem arises because the standard VAE imposes a strong constraint on posterior distributions. Conversely, removing this constraint may compromise the disentanglement ability of VAE (Burgess et al., 2017 ) . To remedy this, we adopt the β 𝛽 \beta italic_β -VAE formulation (Higgins et al., 2017 ; Alemi et al., 2017 ) , which introduces an
adjustable hyperparameter β 𝛽 \beta italic_β :

[TABLE] ℒ θ , ϕ p ⁢ r ⁢ e ⁢ d ⁢ ( f t + 1 ) = subscript superscript ℒ 𝑝 𝑟 𝑒 𝑑 𝜃 italic-ϕ subscript 𝑓 𝑡 1 absent \displaystyle\mathcal{L}^{pred}_{\theta,\phi}(f_{t+1})= caligraphic_L start_POSTSUPERSCRIPT italic_p italic_r italic_e italic_d end_POSTSUPERSCRIPT start_POSTSUBSCRIPT italic_θ , italic_ϕ end_POSTSUBSCRIPT ( italic_f start_POSTSUBSCRIPT italic_t + 1 end_POSTSUBSCRIPT ) = 𝔼 q ϕ ⁢ ( a ~ | f t : t + 1 ) ⁢ log ⁡ p θ ⁢ ( f t + 1 | a ~ , f t ) subscript 𝔼 subscript 𝑞 italic-ϕ conditional ~ 𝑎 subscript 𝑓 : 𝑡 𝑡 1 subscript 𝑝 𝜃 conditional subscript 𝑓 𝑡 1 ~ 𝑎 subscript 𝑓 𝑡 \displaystyle\;\mathbb{E}_{q_{\phi}(\tilde{a}|f_{t:t+1})}\log p_{\theta}(f_{t+%
1}|\tilde{a},f_{t}) blackboard_E start_POSTSUBSCRIPT italic_q start_POSTSUBSCRIPT italic_ϕ end_POSTSUBSCRIPT ( over~ start_ARG italic_a end_ARG | italic_f start_POSTSUBSCRIPT italic_t : italic_t + 1 end_POSTSUBSCRIPT ) end_POSTSUBSCRIPT roman_log italic_p start_POSTSUBSCRIPT italic_θ end_POSTSUBSCRIPT ( italic_f start_POSTSUBSCRIPT italic_t + 1 end_POSTSUBSCRIPT | over~ start_ARG italic_a end_ARG , italic_f start_POSTSUBSCRIPT italic_t end_POSTSUBSCRIPT ) (2) − β D K ⁢ L ( q ϕ ( a ~ | f t : t + 1 ) | | p ( a ~ ) ) . \displaystyle-\beta\,D_{KL}(q_{\phi}(\tilde{a}|f_{t:t+1})||p(\tilde{a})). - italic_β italic_D start_POSTSUBSCRIPT italic_K italic_L end_POSTSUBSCRIPT ( italic_q start_POSTSUBSCRIPT italic_ϕ end_POSTSUBSCRIPT ( over~ start_ARG italic_a end_ARG | italic_f start_POSTSUBSCRIPT italic_t : italic_t + 1 end_POSTSUBSCRIPT ) | | italic_p ( over~ start_ARG italic_a end_ARG ) ) .

The additional hyperparameter enables us to flexibly control the information contained by the latent actions. In practice, we empirically adjust this hyperparameter to achieve a good trade-off between expressiveness and context disentangling ability of our latent actions. As shown in Figure 4 , our latent action autoencoder can extract context-invariant actions that are transferrable across different contexts.

## 2.2 Action-Aware Pretraining

Figure 5: Action composition. We compose two actions by averaging their latent actions in the continuous latent space, resulting in a new action that merges the functions of both. This indicates that our latent action space is semantically continuous in the meanings of actions.

After training the latent action autoencoder, we can use its encoder to automatically extract action information from videos. This allows us to incorporate action information for world model pretraining, which we refer to as action-aware pretraining . To realize this, we pretrain a world model that predicts the next frame conditioned on the current latent action. As shown in Figure 3 , we utilize the latent action encoder to extract the latent actions between frames and send them as inputs for our world model. Unlike previous methods that often predict video clips (Yang et al., 2024c ; Xiang et al., 2024 ; Agarwal et al., 2025 ) , our model supports frame-level control, offering finer granularity for interaction. To ensure smooth transitions, we maintain a short-term memory with K 𝐾 K italic_K historical frames. During inference, our model can predict a sequence of future frames by autoregressively repeating the next-frame prediction process and appending the predicted frames to the memory.

Although it may seem straightforward to repurpose the latent action decoder as the function of world model, it only makes coarse predictions via a single forward pass, resulting in significant quality degradation after several interactions. To achieve genuine predictions, we establish an independent world model based on diffusion models. Specifically, we initialize the world model with Stable Video Diffusion (SVD) (Blattmann et al., 2023 ) , a latent diffusion model trained with the EDM framework (Karras et al., 2022 ) . Different from the original SVD, we only denoise one noisy frame each time. To enable deep aggregation with the action information, the latent action is concatenated with both the timestep embedding and the CLIP image embedding from the original SVD. The last frame in memory is used as the condition image of SVD. To inherit the pretrained temporal modeling capability, we encode the historical frames using the SVD image encoder and concatenate them with the noise latent map of the frame to predict. Since the number of available historical frames may vary in practice, we randomly sample historical frames with a maximum length of 6 during training and send the memory length condition to the world model. Following previous practices (He et al., 2022 ; Valevski et al., 2025 ) , noise augmentation is also applied to corrupt the historical frames during training. This augmentation can effectively alleviate the long-term drift problem, even when no noise is applied during inference. We pretrain the world model on our large-scale dataset by minimizing the following diffusion loss:

[TABLE] ℒ pretrain = 𝔼 𝒙 0 , ϵ , t ⁢ [ ‖ 𝒙 0 − 𝒙 ^ 0 ⁢ ( 𝒙 t , t , 𝒄 ) ‖ 2 ] , subscript ℒ pretrain subscript 𝔼 subscript 𝒙 0 italic-ϵ 𝑡 delimited-[] superscript norm subscript 𝒙 0 subscript ^ 𝒙 0 subscript 𝒙 𝑡 𝑡 𝒄 2 \mathcal{L}_{\text{pretrain}}=\mathbb{E}_{\boldsymbol{x}_{0},\epsilon,t}\Big{[%
}\|\boldsymbol{x}_{0}-\hat{\boldsymbol{x}}_{0}(\boldsymbol{x}_{t},t,%
\boldsymbol{c})\|^{2}\Big{]}, caligraphic_L start_POSTSUBSCRIPT pretrain end_POSTSUBSCRIPT = blackboard_E start_POSTSUBSCRIPT bold_italic_x start_POSTSUBSCRIPT 0 end_POSTSUBSCRIPT , italic_ϵ , italic_t end_POSTSUBSCRIPT [ ∥ bold_italic_x start_POSTSUBSCRIPT 0 end_POSTSUBSCRIPT - over^ start_ARG bold_italic_x end_ARG start_POSTSUBSCRIPT 0 end_POSTSUBSCRIPT ( bold_italic_x start_POSTSUBSCRIPT italic_t end_POSTSUBSCRIPT , italic_t , bold_italic_c ) ∥ start_POSTSUPERSCRIPT 2 end_POSTSUPERSCRIPT ] , (3)

where 𝒙 ^ 0 subscript ^ 𝒙 0 \hat{\boldsymbol{x}}_{0} over^ start_ARG bold_italic_x end_ARG start_POSTSUBSCRIPT 0 end_POSTSUBSCRIPT is the prediction of our world model and 𝒄 𝒄 \boldsymbol{c} bold_italic_c is the conditioning information which includes historical frames and the latent action a ~ ~ 𝑎 \tilde{a} over~ start_ARG italic_a end_ARG .

## 2.3 Highly Adaptable World Models

After action-aware pretraining across various environments, the world model can be controlled by different latent actions, making it highly adaptable for multiple applications, including efficient action transfer, world model adaptation, and even action creation.

Efficient action transfer. When presented with a demonstration video, we use the latent action encoder to extract a sequence of latent actions. This enables us to disentangle the action from its context and replicate it across different contexts. Specifically, given the initial frame from a new context, we can reuse the extracted latent action sequence as the conditions to generate a new video autoregressively. As demonstrated in Figure 4 , AdaWorld naturally transfers actions from source videos to various contexts.

Efficient world model adaptation. AdaWorld also allows efficient world model adaptation with limited action labels and training steps. Specifically, after collecting a few action-video pairs through interactions, we use the latent action encoder to infer their latent actions. Thanks to the continuity of our latent action space, latent actions for the same label can be averaged directly. We empirically find that the averaged embedding consistently represents the intended action. Thus, for a new environment with N 𝑁 N italic_N discrete actions, we initialize a specialized world model using N 𝑁 N italic_N averaged latent actions and finetune the whole model for a few steps. For environments with continuous action spaces, since there are infinite options, we add a lightweight MLP to map raw action inputs to the latent action interface. The interface can also be efficiently initialized by finetuning the MLP with minimal action-latent action pairs. Figure 6 shows that the models initialized in aforementioned ways can be efficiently adapted to take control inputs through minimal finetuning.

Action composition and creation. It is also noteworthy that AdaWorld enables several unique applications compared to existing world models. For instance, it allows the composition of new actions by interpolating observed actions within the latent space, as demonstrated in Figure 5 . In addition, by collecting and clustering latent actions, we can easily create a flexible number of control options with distinct functions and strong controllability. This suggests that AdaWorld could serve as an alternative to generative interactive environments (Bruce et al., 2024 ) . See Appendix C for experimental details on action creation.

## 3 Experiments

In this section, we first demonstrate AdaWorld’s strengths in action transfer in Sec. 3.1 . We then study how efficient world model adaptation enables better simulation and planning in Sec. 3.2 . Lastly, we analyze the effectiveness of our designs with ablation studies in Sec. 3.3 .

To thoroughly understand the adaptability of our approach, we compare AdaWorld with three representative baselines:

• Action-agnostic pretraining. In this setup, we train a world model that shares the same architecture as AdaWorld but always takes zeros as action conditions during pretraining. This baseline is used to demonstrate the effect of the predominant pretraining paradigm that relies only on action-agonistic videos (Mendonca et al., 2023 ; Wu et al., 2023 ; Gao et al., 2024 ; Che et al., 2025 ; Agarwal et al., 2025 ; He et al., 2025 ) .

Action-agnostic pretraining. In this setup, we train a world model that shares the same architecture as AdaWorld but always takes zeros as action conditions during pretraining. This baseline is used to demonstrate the effect of the predominant pretraining paradigm that relies only on action-agonistic videos (Mendonca et al., 2023 ; Wu et al., 2023 ; Gao et al., 2024 ; Che et al., 2025 ; Agarwal et al., 2025 ; He et al., 2025 ) .

• Optical flow as an action-aware condition. We automatically predict optical flows from videos using UniMatch (Xu et al., 2023a ) . The flow maps are downsampled to 16 × 16 16 16 16\times 16 16 × 16 and flattened as conditional encodings to replace the latent actions during pretraining. This baseline serves as an alternative solution for extracting action information from unlabeled videos.

Optical flow as an action-aware condition. We automatically predict optical flows from videos using UniMatch (Xu et al., 2023a ) . The flow maps are downsampled to 16 × 16 16 16 16\times 16 16 × 16 and flattened as conditional encodings to replace the latent actions during pretraining. This baseline serves as an alternative solution for extracting action information from unlabeled videos.

• Discrete latent action as an action-aware condition. We also implement a variant of the latent action autoencoder based on the standard VQ-VAE (Van Den Oord et al., 2017 ) . Instead of using a continuous latent action space, this variant adopts a VQ codebook with 8 discrete codes following Genie (Bruce et al., 2024 ) .

Discrete latent action as an action-aware condition. We also implement a variant of the latent action autoencoder based on the standard VQ-VAE (Van Den Oord et al., 2017 ) . Instead of using a continuous latent action space, this variant adopts a VQ codebook with 8 discrete codes following Genie (Bruce et al., 2024 ) .

Except for the above modifications, we align other training settings for the baselines and our method. The world models of all compared methods are trained for 50K iterations to ensure a fair comparison. Our training dataset comprises four publicly accessible datasets (Goyal et al., 2017 ; Grauman et al., 2022 ; O’Neill et al., 2024 ; Ju et al., 2024 ) and videos collected automatically from 1016 environments in Gym Retro (Nichol et al., 2018 ) and Procgen Benchmark (Cobbe et al., 2020 ) . This results in about 2000 million frames of interactive scenarios in total. More details about our datasets and implementation are provided in Appendices A and B .

## 3.1 Action Transfer

AdaWorld can readily transfer a demonstrated action to various contexts without further training. Below, we provide both qualitative and quantitative evaluations to showcase how effectively AdaWorld performs action transfer.

Qualitative results. We transfer action sequences of length 20 through autoregressive generation in Figure 4 . It shows that AdaWorld can effectively disentangle the demonstrated actions and emulate them across contexts. Qualitative comparison with other baselines can be found in Appendix C .

Quantitative results. To quantitatively compare with other baselines, we construct a evaluation set sourced from the unseen LIBERO (Liu et al., 2023 ) and Something-Something v2 (SSv2) (Goyal et al., 2017 ) datasets. Specifically, we select and pair videos from the same tasks in LIBERO and the same labels among the top-10 most frequent labels in SSv2, resulting in 1300 pairs for evaluation (more details in Appendix D ). While the selected video pairs contain similar actions, we find that the video pairs from LIBERO often differ in the arrangement of objects, and those from SSv2 have significant differences in contexts. For each video pair, we take the first video as the demonstration video and use the first frame from the second video as the initial frame. We then generate videos by extracting action conditions from the demonstration video and employing different models to autoregressively predict the next 20 frames from the initial frame. The evaluation is performed by measure the generated videos against the original videos using Fréchet Video Distance (FVD) (Unterthiner et al., 2018 ) . To complement the FVD evaluation, which reflects overall distribution similarity, we additionally employ Embedding Cosine Similarity (ECS) (Sun et al., 2024 ) that performs frame-level measurements with I3D (Carreira & Zisserman, 2017 ) . We further conduct a human evaluation on a set of 50 video pairs from LIBERO and SSv2, respectively. Four volunteers are invited to judge whether the action is successfully transferred or not. Both the automatic and human evaluations in Table 1 demonstrate that our continuous latent action achieves the best action transfer performance, underscoring its capability to express more nuanced actions without losing generality.

Table 1: Action transfer comparison. In both datasets, AdaWorld excels at transferring the demonstrated actions to different contexts.

[TABLE] Method LIBERO SSv2 FVD ↓ ↓ \downarrow ↓ ECS ↑ ↑ \uparrow ↑ Human ↑ ↑ \uparrow ↑ FVD ↓ ↓ \downarrow ↓ ECS ↑ ↑ \uparrow ↑ Human ↑ ↑ \uparrow ↑ Act-agnostic 1545.2 0.702 0% 847.2 0.592 1% Flow cond. 1409.5 0.724 2% 702.8 0.611 10.5% Discrete cond. 1504.5 0.700 3.5% 726.8 0.596 21.5% AdaWorld 767.0 0.804 70.5% 473.4 0.639 61.5%

Table 2: Action-controlled simulation quality when adapting to four unseen environments. All results are tested after 800 finetuning steps, using 100 samples for each discrete action (Habitat, Minecraft, DMLab) or 100 continuous trajectory samples (nuScenes).

[TABLE] Method Habitat (discrete action) Minecraft (discrete action) DMLab (discrete action) nuScenes (continuous action) PSNR ↑ ↑ \uparrow ↑ LPIPS ↓ ↓ \downarrow ↓ PSNR ↑ ↑ \uparrow ↑ LPIPS ↓ ↓ \downarrow ↓ PSNR ↑ ↑ \uparrow ↑ LPIPS ↓ ↓ \downarrow ↓ PSNR ↑ ↑ \uparrow ↑ LPIPS ↓ ↓ \downarrow ↓ Act-agnostic 20.34 0.450 19.44 0.532 20.96 0.386 20.86 0.475 Flow cond. 22.49 0.373 20.71 0.492 22.22 0.357 20.94 0.462 Discrete cond. 23.31 0.342 21.33 0.465 22.36 0.349 21.28 0.450 AdaWorld 23.58 0.327 21.59 0.457 22.92 0.335 21.60 0.436

Figure 6: PSNR curves for world model adaptation. With limited samples and training steps, AdaWorld adapts to the action controls of new environments more rapidly than conventional pretraining methods.

## 3.2 World Model Adaptation

We also investigate how the proposed method benefits efficient world model adaptation in terms of simulation quality and visual planning performance.

## 3.2.1 Simulation Quality

Setup. To evaluate the simulation quality after adaptation, we choose three environments with discrete action space (Habitat (Savva et al., 2019 ) , Minecraft, DMLab (Beattie et al., 2016 ) ) and one environment with continuous action space (nuScenes (Caesar et al., 2020 ) ) that are not included in our training dataset. Each environment has a validation set consisting of 300 samples, which is used to evaluate the adaption quality in terms of PSNR (Hore & Ziou, 2010 ) and LPIPS (Zhang et al., 2018 ) . To demonstrate the adaptability with restricted labels, we collect only 100 samples for each action in every discrete environment and 100 trajectories for nuScenes. Using the limited interaction data, we then finetune all compared world models for 800 steps with a batch size of 32 and a learning rate of 5 × 10 − 5 5 superscript 10 5 5\times 10^{-5} 5 × 10 start_POSTSUPERSCRIPT - 5 end_POSTSUPERSCRIPT . The learning rate for the pretrained weights is discounted by a factor of 0.1. For the action-agnostic baseline, we initialize action embeddings with random parameters. For the other three models, we use the averaged action conditions extracted from the 100 samples to initialize the action embeddings as described in Sec. 2.3 . Note that for nuScenes, we add a two-layer MLP to map continuous displacements to the latent action interface. The MLP is fine-tuned with limited action-latent action pairs for 3K steps, which takes less than 30 seconds on a single GPU.

Results. As reported in Table 2 , AdaWorld achieves the best fidelity after finetuning with limited interactions and compute. The comparison results suggest that the proposed method allows the world models to efficiently simulate new action controls in unseen environments. Note that all action-aware variants significantly outperform the action-agnostic baseline, underlining the importance of our key innovation, i.e . , incorporating action information during pretraining.

To further demonstrate our sample efficiency and finetuning efficiency, we conduct more comparative experiments using different sample numbers and finetuning steps on Minecraft and nuScenes. We show the evolving curves of PSNR in Figure 6 . In all cases, AdaWorld performs much better at the beginning and improves significantly faster after a few finetuning steps. This suggests that our approach provides a superior initialization for efficient world model adaptation compared to conventional pretraining methods.

Table 3: Visual planning results in games. For all selected scenes from four Procgen environments, we report the success rate and standard error with 5 random seeds. AdaWorld achieves higher average success rates than other baselines as well as Q-learning even without finetuning. Oracle : We use the ground truth simulator for MPC, which indicate the upper bound of this planning strategy.

[TABLE] Method Success Rate ↑ ↑ \uparrow ↑ Heist Jumper Maze CaveFlyer Average Random 19.33 ± plus-or-minus \pm ± 4.41% 22.00 ± plus-or-minus \pm ± 2.50% 41.33 ± plus-or-minus \pm ± 5.44% 22.00 ± plus-or-minus \pm ± 2.50% 26.17 ± plus-or-minus \pm ± 2.55% Act-agnostic 20.67 ± plus-or-minus \pm ± 3.55% 20.67 ± plus-or-minus \pm ± 2.45% 39.33 ± plus-or-minus \pm ± 2.87% 23.33 ± plus-or-minus \pm ± 1.84% 26.00 ± plus-or-minus \pm ± 0.98% AdaWorld w/o finetune 38.67 ± plus-or-minus \pm ± 2.01% 68.00 ± plus-or-minus \pm ± 2.25% 41.33 ± plus-or-minus \pm ± 2.72% 31.33 ± plus-or-minus \pm ± 2.50% 44.83 ± plus-or-minus \pm ± 1.37% w/ finetune 66.67 ± plus-or-minus \pm ± 4.09% 58.67 ± plus-or-minus \pm ± 2.50% 68.00 ± plus-or-minus \pm ± 1.69% 33.33 ± plus-or-minus \pm ± 3.80% 56.67 ± plus-or-minus \pm ± 2.16% Q-learning 22.67 ± plus-or-minus \pm ± 3.87% 47.33 ± plus-or-minus \pm ± 6.71% 4.67 ± plus-or-minus \pm ± 0.81% 34.00 ± plus-or-minus \pm ± 6.17% 27.17 ± plus-or-minus \pm ± 1.27% Oracle (GT env.) 86.67 ± plus-or-minus \pm ± 3.16% 77.33 ± plus-or-minus \pm ± 2.67% 84.67 ± plus-or-minus \pm ± 2.91% 74.00 ± plus-or-minus \pm ± 3.99% 80.67 ± plus-or-minus \pm ± 2.11%

Table 4: Visual planning results in robot tasks. The success rates and standard errors are obtained over 4 runs for each task from VP 2 . We also report the aggregated success rates normalized by the scores of the ground truth simulator on the right.

[TABLE] Method Success Rate ↑ ↑ \uparrow ↑ Robosuite push Open slide Blue button Green button Red button Upright block Aggregate Act-agnostic 17.50 ± plus-or-minus \pm ± 0.50% 1.67 ± plus-or-minus \pm ± 1.67% 5.00 ± plus-or-minus \pm ± 1.67% 3.33 ± plus-or-minus \pm ± 0.00% 0.00 ± plus-or-minus \pm ± 0.00% 1.67 ± plus-or-minus \pm ± 1.67% 5.03 AdaWorld 63.50 ± plus-or-minus \pm ± 1.71% 5.83 ± plus-or-minus \pm ± 2.85% 29.17 ± plus-or-minus \pm ± 2.50% 10.83 ± plus-or-minus \pm ± 2.50% 10.00 ± plus-or-minus \pm ± 2.36% 5.00 ± plus-or-minus \pm ± 0.96% 21.54

## 3.2.2 Visual Planning in Games

Setup. After learning action controls, world models can be utilized for planning. To demonstrate the superiority of AdaWorld in planning performance, we first compare it with the action-agnostic baseline in video game environments using sampling-based model predictive control (MPC) optimized by Cross-Entropy Method (De Boer et al., 2005 ; Chua et al., 2018 ) . The MPC planning and optimization procedure are deferred to Sec. B.4 . We define a goal-reaching task based on the Procgen benchmark (Cobbe et al., 2020 ) and select 30 scenes from each of four environments (Heist, Jumper, Maze, CaveFlyer). This ensures that the specified goals can be reached within an acceptable number of steps (more details in Appendix E ). For each scene, we randomly collect 100 samples for each action in the default action space ( LEFT , DOWN , UP , RIGHT ). Based on the collected samples, the pretrained world models are finetuned for 500 steps with a batch size of 32 and a learning rate of 5 × 10 − 5 5 superscript 10 5 5\times 10^{-5} 5 × 10 start_POSTSUPERSCRIPT - 5 end_POSTSUPERSCRIPT . We then use the finetuned world models to perform MPC planning in the selected scenes. The reward is defined as the cosine similarity between the predicted observations and the image of the final state. The planning is deemed successful if the agent reaches the final state within 20 steps.

Results. Table 3 presents the success rates averaged over 5 random seeds. While the action-agnostic baseline performs similarly to random planning, AdaWorld substantially increase the success rates across all environments. This indicates that our approach not only adapts more efficiently but also enables more effective planning. Visit our project page to see planning demonstrations of agents in games.

Additionally, we evaluate the visual planning performance without finetuning our model using the collected samples. In particular, we only utilize the averaged latent actions derived from these samples as action embeddings for the corresponding scenes. The results in Table 3 indicate that even without updating model weights, our variant still outperforms the finetuned action-agnostic pretraining baseline.

To further demonstrate the effectiveness of our approach, we also compare the planning results with Q-learning (Sutton & Barto, 2018 ) , a classical model-free reinforcement learning method. For each scene, we construct a Q-table using the same samples collected for the MPC planning. The states of Q-table are represented by quantized images, and the rewards are obtained by computing the cosine similarity with the goal image. As shown in Table 3 , AdaWorld significantly dominates the Q-learning method, suggesting that our approach makes more effective use of limited interactions.

## 3.2.3 Visual Planning in Robot Tasks

Setup. To verify our efficacy in robot control tasks, we pretrain a low-resolution variant of AdaWorld and evaluate the planning performance on the VP 2 benchmark (Tian et al., 2023 ) after adaptation. The planning is also sampling-based and is performed using the model-predictive path integral (MPPI) (Williams et al., 2016 ; Nagabandi et al., 2020 ) . We focus on a similar compute-efficient setting and finetune the pretrained variant and an action-agnostic baseline for 1K steps. The evaluation is conducted on 100 tabletop Robosuite tasks (Zhu et al., 2020 ) and 7 RoboDesk tasks (Kannan et al., 2021 ) . More details are in Sec. B.5 .

Results. Table 4 reports the success rates on VP 2 . We omit the Flat block and Open drawer tasks from RoboDesk, as they do not yield meaningful scores under our constrained adaptation setting. The results show that AdaWorld adapts more efficiently with limited finetuning steps and improves the planning performance by a clear margin.

## 3.3 Ablation and Analysis

Interface initialization. We ablate the latent action initialization approaches in Sec. 2.3 with random initialization and adapt the resultant model to the unseen Minecraft and nuScenes. Figure 6 shows that randomly initializing the control interface of AdaWorld results in a quality drop at the beginning. Nevertheless, it is noteworthy that although our variant is slightly worse than the action-agnostic pretraining baseline when the finetuning begins, it rapidly surpasses the action-agnostic baseline after just 200 steps. This is because AdaWorld has learned a highly adaptable control interface through action-aware pretraining, allowing it to efficiently adapt to an unseen environment by simply fitting the action embeddings for the new action space.

Table 5: Impacts of training data diversity. Increasing data diversity enhances the generalization of latent actions to new domains.

[TABLE] Training Data Procgen PSNR ↑ ↑ \uparrow ↑ LPIPS ↓ ↓ \downarrow ↓ OpenX 25.51 0.318 Retro 26.43 0.250 Retro+OpenX 26.62 0.234

Table 6: Generality of AdaWorld. Applying action-aware pretraining to iVideoGPT also significantly improves its adaptability.

[TABLE] Model BAIR PSNR ↑ ↑ \uparrow ↑ LPIPS ↓ ↓ \downarrow ↓ iVideoGPT 16.59 0.220 iVideoGPT+AdaWorld 17.40 0.204

Data diversity. We also study the impact of data mixture to the generalization ability of latent actions. To this end, we implement three latent action autoencoder with different combinations of Open X-Embodiment (OpenX) (O’Neill et al., 2024 ) and Gym Retro (Nichol et al., 2018 ) datasets for 40K steps. We then assess the latent action decoder predictions of these three variants on Procgen benchmark (Cobbe et al., 2020 ) in Table 5 . Surprisingly, we discover that even though OpenX mainly consists of real-world robot videos, incorporating OpenX helps the latent action autoencoder generalize to the unseen 2D virtual games in Procgen. This suggests that further increasing data diversity may positively affect the generalization of our latent actions.

Method generality. To demonstrate the generality of our method, we use iVideoGPT (Wu et al., 2024 ) as a state-of-the-art baseline. iVideoGPT is an action-controlled world model with an autoregressive Transformer architecture. It is pretrained by action-agnostic video prediction and adds a linear projection to learn action control during finetuning. For fair comparison, we implement a variant by conditioning iVideoGPT with our latent actions during pretraining. The training details can be found in Sec. B.6 . After finetuning, we compare action-controlled simulation quality on BAIR robot pushing dataset (Ebert et al., 2017 ) in Table 6 . The proposed action-aware pretraining significantly enhances the adaptability of iVideoGPT, suggesting that our method is generally applicable to different world models.

Hyperparameter choice. In Eq. ( 2 ), the hyperparameter β 𝛽 \beta italic_β is adjusted to achieve a good trade-off between expressiveness and context disentangling ability of latent actions. To provide a more intuitive illustration, we randomly collect 1000 samples for each action from Habitat, Minecraft, and DMLab, and use UMAP (McInnes et al., 2018 ) for visualization. Figure 7 shows that the same actions, even from different environments, are clustered together, which validates the context-invariant property of our latent actions. Note that noise exists because the action inputs cannot be executed in certain states ( e.g . , cannot go ahead when an obstacle is in front). We also compare samples inferred by a model trained with a lower β 𝛽 \beta italic_β . Although this results in more differentiable latent actions, it also reduces action overlap across environments thus sacrificing disentanglement ability. We therefore set β 𝛽 \beta italic_β as 2 × 10 − 4 2 superscript 10 4 2\times 10^{-4} 2 × 10 start_POSTSUPERSCRIPT - 4 end_POSTSUPERSCRIPT by default.

Figure 7: UMAP of latent actions. Reducing the value of β 𝛽 \beta italic_β increases expressiveness but sacrifices disentanglement from context.

## 4 Conclusion

In this paper, we introduce AdaWorld , a new world model learning approach that facilitates efficient adaptation across various environments. It is highly adaptable in transferring and learning new actions with limited interactions and finetuning. Extensive experiments and analyses demonstrate the superior adaptability of AdaWorld, highlighting its potential as a new paradigm for world model pretraining.

Limitations. While AdaWorld promotes adaptable world modeling, several challenges remain. First, it does not operate at real-time frequency. Future work could incorporate distillation and sampling techniques (Feng et al., 2024 ; Yin et al., 2025 ) to accelerate inference speed. Similar to prior works (Yang et al., 2024e ) , AdaWorld struggles to create novel content when the rollout exceeds the initial scene. This issue is likely to be solved by scaling model and training data (Bruce et al., 2024 ; Bar et al., 2025 ) . Additionally, our model falls short in achieving extremely long-term rollouts, and we will explore potential solutions (Chen et al., 2024a ; Feng et al., 2024 ; Ruhe et al., 2024 ) in future work. We also append some primary failure cases in Appendix C .

## Acknowledgements

Shenyuan Gao and Jun Zhang were supported by the Hong Kong Research Grants Council under the NSFC/RGC Collaborative Research Scheme grant CRS_HKUST603/22.

## Impact Statement

This paper presents work whose goal is to advance the field of machine intelligence. There are many potential societal consequences of our work, none which we feel must be specifically highlighted here.

## References

Agarwal et al. (2025) Agarwal, N., Ali, A., Bala, M., Balaji, Y., Barker, E., Cai, T., Chattopadhyay, P., Chen, Y., Cui, Y., Ding, Y., et al. Cosmos World Foundation Model Platform for Physical AI. arXiv preprint arXiv:2501.03575 , 2025.

Alemi et al. (2017) Alemi, A. A., Fischer, I., Dillon, J. V., and Murphy, K. Deep Variational Information Bottleneck. In ICLR , 2017.

Alonso et al. (2024) Alonso, E., Jelley, A., Micheli, V., Kanervisto, A., Storkey, A., Pearce, T., and Fleuret, F. Diffusion for World Modeling: Visual Details Matter in Atari. In NeurIPS , 2024.

Baker et al. (2022) Baker, B., Akkaya, I., Zhokov, P., Huizinga, J., Tang, J., Ecoffet, A., Houghton, B., Sampedro, R., and Clune, J. Video PreTraining (VPT): Learning to Act by Watching Unlabeled Online Videos. In NeurIPS , 2022.

Bar et al. (2025) Bar, A., Zhou, G., Tran, D., Darrell, T., and LeCun, Y. Navigation World Models. In CVPR , 2025.

Beattie et al. (2016) Beattie, C., Leibo, J. Z., Teplyashin, D., Ward, T., Wainwright, M., Küttler, H., Lefrancq, A., Green, S., Valdés, V., Sadik, A., et al. DeepMind Lab. arXiv preprint arXiv:1612.03801 , 2016.

Blattmann et al. (2023) Blattmann, A., Dockhorn, T., Kulal, S., Mendelevitch, D., Kilian, M., Lorenz, D., Levi, Y., English, Z., Voleti, V., Letts, A., et al. Stable Video Diffusion: Scaling Latent Video Diffusion Models to Large Datasets. arXiv preprint arXiv:2311.15127 , 2023.

Bruce et al. (2024) Bruce, J., Dennis, M. D., Edwards, A., Parker-Holder, J., Shi, Y., Hughes, E., Lai, M., Mavalankar, A., Steigerwald, R., Apps, C., et al. Genie: Generative Interactive Environments. In ICML , 2024.

Bu et al. (2024) Bu, Q., Zeng, J., Chen, L., Yang, Y., Zhou, G., Yan, J., Luo, P., Cui, H., Ma, Y., and Li, H. Closed-Loop Visuomotor Control with Generative Expectation for Robotic Manipulation. In NeurIPS , 2024.

Bu et al. (2025) Bu, Q., Cai, J., Chen, L., Cui, X., Ding, Y., Feng, S., Gao, S., He, X., Huang, X., Jiang, S., et al. AgiBot World Colosseo: A Large-Scale Manipulation Platform for Scalable and Intelligent Embodied Systems. arXiv preprint arXiv:2503.06669 , 2025.

Burgess et al. (2017) Burgess, C. P., Higgins, I., Pal, A., Matthey, L., Watters, N., Desjardins, G., and Lerchner, A. Understanding Disentangling in β 𝛽 \beta italic_β -VAE. In NeurIPS Workshops , 2017.

Caesar et al. (2020) Caesar, H., Bankiti, V., Lang, A. H., Vora, S., Liong, V. E., Xu, Q., Krishnan, A., Pan, Y., Baldan, G., and Beijbom, O. nuScenes: A Multimodal Dataset for Autonomous Driving. In CVPR , 2020.

Carreira & Zisserman (2017) Carreira, J. and Zisserman, A. Quo Vadis, Action Recognition? A New Model and the Kinetics Dataset. In CVPR , 2017.

Che et al. (2025) Che, H., He, X., Liu, Q., Jin, C., and Chen, H. GameGen-X: Interactive Open-World Game Video Generation. In ICLR , 2025.

Chen et al. (2024a) Chen, B., Monso, D. M., Du, Y., Simchowitz, M., Tedrake, R., and Sitzmann, V. Diffusion Forcing: Next-Token Prediction Meets Full-Sequence Diffusion. In NeurIPS , 2024a.

Chen et al. (2024b) Chen, X., Guo, J., He, T., Zhang, C., Zhang, P., Yang, D. C., Zhao, L., and Bian, J. IGOR: Image-GOal Representations are the Atomic Control Units for Foundation Models in Embodied AI. arXiv preprint arXiv:2411.00785 , 2024b.

Chen et al. (2024c) Chen, Y., Ge, Y., Li, Y., Ge, Y., Ding, M., Shan, Y., and Liu, X. Moto: Latent Motion Token as the Bridging Language for Robot Manipulation. arXiv preprint arXiv:2412.04445 , 2024c.

Chi et al. (2024) Chi, X., Zhang, H., Fan, C.-K., Qi, X., Zhang, R., Chen, A., Chan, C.-m., Xue, W., Luo, W., Zhang, S., et al. EVA: An Embodied World Model for Future Video Anticipation. arXiv preprint arXiv:2410.15461 , 2024.

Chua et al. (2018) Chua, K., Calandra, R., McAllister, R., and Levine, S. Deep Reinforcement Learning in a Handful of Trials using Probabilistic Dynamics Models. In NeurIPS , 2018.

Cobbe et al. (2020) Cobbe, K., Hesse, C., Hilton, J., and Schulman, J. Leveraging Procedural Generation to Benchmark Reinforcement Learning. In ICML , 2020.

Cui et al. (2024) Cui, Z. J., Pan, H., Iyer, A., Haldar, S., and Pinto, L. DynaMo: In-Domain Dynamics Pretraining for Visuo-Motor Control. In NeurIPS , 2024.

De Boer et al. (2005) De Boer, P.-T., Kroese, D. P., Mannor, S., and Rubinstein, R. Y. A Tutorial on the Cross-Entropy Method. Annals of Operations Research , 2005.

Dominici et al. (2011) Dominici, N., Ivanenko, Y. P., Cappellini, G., d’Avella, A., Mondì, V., Cicchese, M., Fabiano, A., Silei, T., Di Paolo, A., Giannini, C., et al. Locomotor Primitives in Newborn Babies and Their Development. Science , 2011.

Dosovitskiy et al. (2021) Dosovitskiy, A., Beyer, L., Kolesnikov, A., Weissenborn, D., Zhai, X., Unterthiner, T., Dehghani, M., Minderer, M., Heigold, G., Gelly, S., Uszkoreit, J., and Houlsby, N. An Image is Worth 16x16 Words: Transformers for Image Recognition at Scale. In ICLR , 2021.

Du et al. (2023) Du, Y., Yang, S., Dai, B., Dai, H., Nachum, O., Tenenbaum, J., Schuurmans, D., and Abbeel, P. Learning Universal Policies via Text-Guided Video Generation. In NeurIPS , 2023.

Du et al. (2024) Du, Y., Yang, M., Florence, P., Xia, F., Wahid, A., Ichter, B., Sermanet, P., Yu, T., Abbeel, P., Tenenbaum, J. B., et al. Video Language Planning. In ICLR , 2024.

Durante et al. (2024) Durante, Z., Sarkar, B., Gong, R., Taori, R., Noda, Y., Tang, P., Adeli, E., Lakshmikanth, S. K., Schulman, K., Milstein, A., et al. An Interactive Agent Foundation Model. arXiv preprint arXiv:2402.05929 , 2024.

Ebert et al. (2017) Ebert, F., Finn, C., Lee, A. X., and Levine, S. Self-Supervised Visual Planning with Temporal Skip Connections. In CoRL , 2017.

Edwards et al. (2019) Edwards, A., Sahni, H., Schroecker, Y., and Isbell, C. Imitating Latent Policies from Observation. In ICML , 2019.

Feng et al. (2024) Feng, R., Zhang, H., Yang, Z., Xiao, J., Shu, Z., Liu, Z., Zheng, A., Huang, Y., Liu, Y., and Zhang, H. The Matrix: Infinite-Horizon World Generation with Real-Time Moving Control. arXiv preprint arXiv:2412.03568 , 2024.

Gao et al. (2024) Gao, S., Yang, J., Chen, L., Chitta, K., Qiu, Y., Geiger, A., Zhang, J., and Li, H. Vista: A Generalizable Driving World Model with High Fidelity and Versatile Controllability. In NeurIPS , 2024.

Goyal et al. (2017) Goyal, R., Ebrahimi Kahou, S., Michalski, V., Materzynska, J., Westphal, S., Kim, H., Haenel, V., Fruend, I., Yianilos, P., Mueller-Freitag, M., et al. The “Something Something” Video Database for Learning and Evaluating Visual Common Sense. In ICCV , 2017.

Grauman et al. (2022) Grauman, K., Westbury, A., Byrne, E., Chavis, Z., Furnari, A., Girdhar, R., Hamburger, J., Jiang, H., Liu, M., Liu, X., et al. Ego4D: Around the World in 3,000 Hours of Egocentric Video. In CVPR , 2022.

Ha & Schmidhuber (2018) Ha, D. and Schmidhuber, J. Recurrent World Models Facilitate Policy Evolution. In NeurIPS , 2018.

Hafner et al. (2023) Hafner, D., Pasukonis, J., Ba, J., and Lillicrap, T. Mastering Diverse Domains through World Models. arXiv preprint arXiv:2301.04104 , 2023.

Hansen et al. (2024) Hansen, N., Su, H., and Wang, X. TD-MPC2: Scalable, Robust World Models for Continuous Control. In ICLR , 2024.

Hassan et al. (2025) Hassan, M., Stapf, S., Rahimi, A., Rezende, P., Haghighi, Y., Brüggemann, D., Katircioglu, I., Zhang, L., Chen, X., Saha, S., et al. GEM: A Generalizable Ego-Vision Multimodal World Model for Fine-Grained Ego-Motion, Object Dynamics, and Scene Composition Control. In CVPR , 2025.

He et al. (2025) He, H., Zhang, Y., Lin, L., Xu, Z., and Pan, L. Pre-Trained Video Generative Models as World Simulators. arXiv preprint arXiv:2502.07825 , 2025.

He et al. (2022) He, Y., Yang, T., Zhang, Y., Shan, Y., and Chen, Q. Latent Video Diffusion Models for High-Fidelity Long Video Generation. arXiv preprint arXiv:2211.13221 , 2022.

Higgins et al. (2017) Higgins, I., Matthey, L., Pal, A., Burgess, C. P., Glorot, X., Botvinick, M. M., Mohamed, S., and Lerchner, A. beta-VAE: Learning Basic Visual Concepts with a Constrained Variational Framework. In ICLR , 2017.

Hong et al. (2025) Hong, Y., Liu, B., Wu, M., Zhai, Y., Chang, K.-W., Li, L., Lin, K., Lin, C.-C., Wang, J., Yang, Z., et al. SlowFast-VGen: Slow-Fast Learning for Action-Driven Long Video Generation. In ICLR , 2025.

Hore & Ziou (2010) Hore, A. and Ziou, D. Image Quality Metrics: PSNR vs. SSIM. In ICPR , 2010.

Hu et al. (2023) Hu, A., Russell, L., Yeo, H., Murez, Z., Fedoseev, G., Kendall, A., Shotton, J., and Corrado, G. GAIA-1: A Generative World Model for Autonomous Driving. arXiv preprint arXiv:2309.17080 , 2023.

Ju et al. (2024) Ju, X., Gao, Y., Zhang, Z., Yuan, Z., Wang, X., Zeng, A., Xiong, Y., Xu, Q., and Shan, Y. MiraData: A Large-Scale Video Dataset with Long Durations and Structured Captions. In NeurIPS Datasets and Benchmarks , 2024.

Kaiser et al. (2020) Kaiser, L., Babaeizadeh, M., Milos, P., Osinski, B., Campbell, R. H., Czechowski, K., Erhan, D., Finn, C., Kozakowski, P., Levine, S., et al. Model-Based Reinforcement Learning for Atari. In ICLR , 2020.

Kannan et al. (2021) Kannan, H., Hafner, D., Finn, C., and Erhan, D. RoboDesk: A Multi-Task Reinforcement Learning Benchmark. https://github.com/google-research/robodesk , 2021.

Karras et al. (2022) Karras, T., Aittala, M., Aila, T., and Laine, S. Elucidating the Design Space of Diffusion-Based Generative Models. In NeurIPS , 2022.

Kazemi et al. (2024) Kazemi, N., Savov, N., Paudel, D., and Van Gool, L. Learning Generative Interactive Environments by Trained Agent Exploration. In NeurIPS Workshops , 2024.

Kim et al. (2024) Kim, M. J., Pertsch, K., Karamcheti, S., Xiao, T., Balakrishna, A., Nair, S., Rafailov, R., Foster, E., Lam, G., Sanketi, P., et al. OpenVLA: An Open-Source Vision-Language-Action Model. In CoRL , 2024.

Kim et al. (2020) Kim, S. W., Zhou, Y., Philion, J., Torralba, A., and Fidler, S. Learning to Simulate Dynamic Environments with GameGAN. In CVPR , 2020.

Kim et al. (2021) Kim, S. W., Philion, J., Torralba, A., and Fidler, S. DriveGAN: Towards a Controllable High-Quality Neural Simulation. In CVPR , 2021.

Kingma & Welling (2014) Kingma, D. P. K. and Welling, M. Auto-Encoding Variational Bayes. In ICLR , 2014.

Ko et al. (2024) Ko, P.-C., Mao, J., Du, Y., Sun, S.-H., and Tenenbaum, J. B. Learning to Act from Actionless Videos through Dense Correspondences. In ICLR , 2024.

Kong et al. (2024) Kong, W., Tian, Q., Zhang, Z., Min, R., Dai, Z., Zhou, J., Xiong, J., Li, X., Wu, B., Zhang, J., et al. HunyuanVideo: A Systematic Framework For Large Video Generative Models. arXiv preprint arXiv:2412.03603 , 2024.

Lee et al. (2022) Lee, K.-H., Nachum, O., Yang, M. S., Lee, L., Freeman, D., Guadarrama, S., Fischer, I., Xu, W., Jang, E., Michalewski, H., et al. Multi-Game Decision Transformers. In NeurIPS , 2022.

Ling et al. (2025) Ling, P., Bu, J., Zhang, P., Dong, X., Zang, Y., Wu, T., Chen, H., Wang, J., and Jin, Y. MotionClone: Training-Free Motion Cloning for Controllable Video Generation. In ICLR , 2025.

Liu et al. (2023) Liu, B., Zhu, Y., Gao, C., Feng, Y., Liu, Q., Zhu, Y., and Stone, P. LIBERO: Benchmarking Knowledge Transfer for Lifelong Robot Learning. In NeurIPS Datasets and Benchmarks , 2023.

Loshchilov & Hutter (2019) Loshchilov, I. and Hutter, F. Decoupled Weight Decay Regularization. In ICLR , 2019.

Lu et al. (2024) Lu, T., Shu, T., Xiao, J., Ye, L., Wang, J., Peng, C., Wei, C., Khashabi, D., Chellappa, R., Yuille, A., et al. GenEx: Generating an Explorable World. arXiv preprint arXiv:2412.09624 , 2024.

Lu et al. (2025) Lu, T., Shu, T., Yuille, A., Khashabi, D., and Chen, J. Generative World Explorer. In ICLR , 2025.

Mazzaglia et al. (2024) Mazzaglia, P., Verbelen, T., Dhoedt, B., Courville, A., and Rajeswar, S. GenRL: Multimodal-Foundation World Models for Generalization in Embodied Agents. In NeurIPS , 2024.

McInnes et al. (2018) McInnes, L., Healy, J., and Melville, J. UMAP: Uniform Manifold Approximation and Projection for Dimension Reduction. arXiv preprint arXiv:1802.03426 , 2018.

Menapace et al. (2021) Menapace, W., Lathuiliere, S., Tulyakov, S., Siarohin, A., and Ricci, E. Playable Video Generation. In CVPR , 2021.

Menapace et al. (2022) Menapace, W., Lathuilière, S., Siarohin, A., Theobalt, C., Tulyakov, S., Golyanik, V., and Ricci, E. Playable Environments: Video Manipulation in Space and Time. In CVPR , 2022.

Mendonca et al. (2023) Mendonca, R., Bahl, S., and Pathak, D. Structured World Models from Human Videos. In RSS , 2023.

Micheli et al. (2023) Micheli, V., Alonso, E., and Fleuret, F. Transformers are Sample-Efficient World Models. In ICLR , 2023.

Nagabandi et al. (2020) Nagabandi, A., Konolige, K., Levine, S., and Kumar, V. Deep Dynamics Models for Learning Dexterous Manipulation. In CoRL , 2020.

Nichol et al. (2018) Nichol, A., Pfau, V., Hesse, C., Klimov, O., and Schulman, J. Gotta Learn Fast: A New Benchmark for Generalization in RL. arXiv preprint arXiv:1804.03720 , 2018.

Nikulin et al. (2025) Nikulin, A., Zisman, I., Tarasov, D., Lyubaykin, N., Polubarov, A., Kiselev, I., and Kurenkov, V. Latent Action Learning Requires Supervision in the Presence of Distractors. arXiv preprint arXiv:2502.00379 , 2025.

O’Neill et al. (2024) O’Neill, A., Rehman, A., Gupta, A., Maddukuri, A., Gupta, A., Padalkar, A., Lee, A., Pooley, A., Gupta, A., Mandlekar, A., et al. Open X-Embodiment: Robotic Learning Datasets and RT-X Models. In ICRA , 2024.

Pearce et al. (2024) Pearce, T., Rashid, T., Bignell, D., Georgescu, R., Devlin, S., and Hofmann, K. Scaling Laws for Pre-Training Agents and World Models. arXiv preprint arXiv:2411.04434 , 2024.

Peebles & Xie (2023) Peebles, W. and Xie, S. Scalable Diffusion Models with Transformers. In ICCV , 2023.

Poggio & Bizzi (2004) Poggio, T. and Bizzi, E. Generalization in Vision and Motor Control. Nature , 2004.

Qi et al. (2025) Qi, H., Yin, H., Du, Y., and Yang, H. Strengthening Generative Robot Policies through Predictive World Modeling. arXiv preprint arXiv:2502.00622 , 2025.

Raad et al. (2024) Raad, M. A., Ahuja, A., Barros, C., Besse, F., Bolt, A., Bolton, A., Brownfield, B., Buttimore, G., Cant, M., Chakera, S., et al. Scaling Instructable Agents Across Many Simulated Worlds. arXiv preprint arXiv:2404.10179 , 2024.

Reed et al. (2022) Reed, S., Zolna, K., Parisotto, E., Colmenarejo, S. G., Novikov, A., Barth-Maron, G., Gimenez, M., Sulsky, Y., Kay, J., Springenberg, J. T., et al. A Generalist Agent. In TMLR , 2022.

Ren et al. (2025) Ren, Z., Wei, Y., Guo, X., Zhao, Y., Kang, B., Feng, J., and Jin, X. VideoWorld: Exploring Knowledge Learning from Unlabeled Videos. In CVPR , 2025.

Rigter et al. (2024) Rigter, M., Gupta, T., Hilmkil, A., and Ma, C. AVID: Adapting Video Diffusion Models to World Models. arXiv preprint arXiv:2410.12822 , 2024.

Rizzolatti et al. (1996) Rizzolatti, G., Fadiga, L., Gallese, V., and Fogassi, L. Premotor Cortex and the Recognition of Motor Actions. Cognitive Brain Research , 1996.

Romo et al. (2004) Romo, R., Hernández, A., and Zainos, A. Neuronal Correlates of a Perceptual Decision in Ventral Premotor Cortex. Neuron , 2004.

Ruhe et al. (2024) Ruhe, D., Heek, J., Salimans, T., and Hoogeboom, E. Rolling Diffusion Models. In ICML , 2024.

Rybkin et al. (2019) Rybkin, O., Pertsch, K., Derpanis, K. G., Daniilidis, K., and Jaegle, A. Learning What You Can Do before Doing Anything. In ICLR , 2019.

Savva et al. (2019) Savva, M., Kadian, A., Maksymets, O., Zhao, Y., Wijmans, E., Jain, B., Straub, J., Liu, J., Koltun, V., Malik, J., et al. Habitat: A Platform for Embodied AI Research. In ICCV , 2019.

Schmeckpeper et al. (2020) Schmeckpeper, K., Xie, A., Rybkin, O., Tian, S., Daniilidis, K., Levine, S., and Finn, C. Learning Predictive Models From Observation and Interaction. In ECCV , 2020.

Schmidt & Jiang (2024) Schmidt, D. and Jiang, M. Learning to Act without Actions. In ICLR , 2024.

Seo et al. (2022) Seo, Y., Lee, K., James, S. L., and Abbeel, P. Reinforcement Learning with Action-Free Pre-Training from Videos. In ICML , 2022.

Seo et al. (2023) Seo, Y., Hafner, D., Liu, H., Liu, F., James, S., Lee, K., and Abbeel, P. Masked World Models for Visual Control. In CoRL , 2023.

Su et al. (2024) Su, J., Ahmed, M., Lu, Y., Pan, S., Bo, W., and Liu, Y. RoFormer: Enhanced Transformer with Rotary Position Embedding. Neurocomputing , 2024.

Sun et al. (2024) Sun, Y., Zhou, H., Yuan, L., Sun, J. J., Li, Y., Jia, X., Adam, H., Hariharan, B., Zhao, L., and Liu, T. Video Creation by Demonstration. arXiv preprint arXiv:2412.09551 , 2024.

Sutton (1991) Sutton, R. S. Dyna, an Integrated Architecture for Learning, Planning, and Reacting. ACM Sigart Bulletin , 1991.

Sutton & Barto (2018) Sutton, R. S. and Barto, A. G. Reinforcement Learning: An Introduction. MIT Press , 2018.

Tian et al. (2023) Tian, S., Finn, C., and Wu, J. A Control-Centric Benchmark for Video Prediction. In ICLR , 2023.

Unterthiner et al. (2018) Unterthiner, T., Van Steenkiste, S., Kurach, K., Marinier, R., Michalski, M., and Gelly, S. Towards Accurate Generative Models of Video: A New Metric & Challenges. arXiv preprint arXiv:1812.01717 , 2018.

Valevski et al. (2025) Valevski, D., Leviathan, Y., Arar, M., and Fruchter, S. Diffusion Models are Real-Time Game Engines. In ICLR , 2025.

Van Den Oord et al. (2017) Van Den Oord, A., Vinyals, O., et al. Neural Discrete Representation Learning. In NeurIPS , 2017.

Vaswani et al. (2017) Vaswani, A., Shazeer, N., Parmar, N., Uszkoreit, J., Jones, L., Gomez, A. N., Kaiser, Ł., and Polosukhin, I. Attention is All You Need. In NeurIPS , 2017.

Villar-Corrales & Behnke (2025) Villar-Corrales, A. and Behnke, S. PlaySlot: Learning Inverse Latent Dynamics for Controllable Object-Centric Video Prediction and Planning. arXiv preprint arXiv:2502.07600 , 2025.

Wang et al. (2025) Wang, L., Zhao, K., Liu, C., and Chen, X. Learning Real-World Action-Video Dynamics with Heterogeneous Masked Autoregression. arXiv preprint arXiv:2502.04296 , 2025.

Wang et al. (2024) Wang, X., Zhu, Z., Huang, G., Chen, X., Zhu, J., and Lu, J. DriveDreamer: Towards Real-World-Driven World Models for Autonomous Driving. In ECCV , 2024.

Watter et al. (2015) Watter, M., Springenberg, J., Boedecker, J., and Riedmiller, M. Embed to Control: A Locally Linear Latent Dynamics Model for Control from Raw Images. In NeurIPS , 2015.

Willi et al. (2024) Willi, T., Jackson, M. T., and Foerster, J. N. Jafar: An Open-Source Genie Reimplemention in JAX. In ICML Workshops , 2024.

Williams et al. (2016) Williams, G., Drews, P., Goldfain, B., Rehg, J. M., and Theodorou, E. A. Aggressive Driving with Model Predictive Path Integral Control. In ICRA , 2016.

Wu et al. (2023) Wu, J., Ma, H., Deng, C., and Long, M. Pre-Training Contextualized World Models with In-the-Wild Videos for Reinforcement Learning. In NeurIPS , 2023.

Wu et al. (2024) Wu, J., Yin, S., Feng, N., He, X., Li, D., Hao, J., and Long, M. iVideoGPT: Interactive VideoGPTs are Scalable World Models. In NeurIPS , 2024.

Wu et al. (2022) Wu, P., Escontrela, A., Hafner, D., Abbeel, P., and Goldberg, K. DayDreamer: World Models for Physical Robot Learning. In CoRL , 2022.

Wu et al. (2025) Wu, Y., Tian, R., Swamy, G., and Bajcsy, A. From Foresight to Forethought: VLM-In-the-Loop Policy Steering via Latent Alignment. arXiv preprint arXiv:2502.01828 , 2025.

Xiang et al. (2024) Xiang, J., Liu, G., Gu, Y., Gao, Q., Ning, Y., Zha, Y., Feng, Z., Tao, T., Hao, S., Shi, Y., et al. Pandora: Towards General World Model with Natural Language Actions and Video States. arXiv preprint arXiv:2406.09455 , 2024.

Xu et al. (2023a) Xu, H., Zhang, J., Cai, J., Rezatofighi, H., Yu, F., Tao, D., and Geiger, A. Unifying Flow, Stereo and Depth Estimation. IEEE TPAMI , 2023a.

Xu et al. (2023b) Xu, M., Xu, Z., Chi, C., Veloso, M., and Song, S. XSkill: Cross Embodiment Skill Discovery. In CoRL , 2023b.

Yang et al. (2024a) Yang, J., Gao, S., Qiu, Y., Chen, L., Li, T., Dai, B., Chitta, K., Wu, P., Zeng, J., Luo, P., et al. Generalized Predictive Model for Autonomous Driving. In CVPR , 2024a.

Yang et al. (2024b) Yang, M., Du, Y., Dai, B., Schuurmans, D., Tenenbaum, J. B., and Abbeel, P. Probabilistic Adaptation of Text-to-Video Models. In ICLR , 2024b.

Yang et al. (2024c) Yang, M., Du, Y., Ghasemipour, K., Tompson, J., Schuurmans, D., and Abbeel, P. Learning Interactive Real-World Simulators. In ICLR , 2024c.

Yang et al. (2024d) Yang, M., Li, J., Fang, Z., Chen, S., Yu, Y., Fu, Q., Yang, W., and Ye, D. Playable Game Generation. arXiv preprint arXiv:2412.00887 , 2024d.

Yang et al. (2024e) Yang, S., Walker, J., Parker-Holder, J., Du, Y., Bruce, J., Barreto, A., Abbeel, P., and Schuurmans, D. Video as the New Language for Real-World Decision Making. In ICML , 2024e.

Yang et al. (2025) Yang, Z., Teng, J., Zheng, W., Ding, M., Huang, S., Xu, J., Yang, Y., Hong, W., Zhang, X., Feng, G., et al. CogVideoX: Text-to-Video Diffusion Models with An Expert Transformer. In ICLR , 2025.

Yatim et al. (2024) Yatim, D., Fridman, R., Bar-Tal, O., Kasten, Y., and Dekel, T. Space-Time Diffusion Features for Zero-Shot Text-Driven Motion Transfer. In CVPR , 2024.

Ye et al. (2025) Ye, S., Jang, J., Jeon, B., Joo, S., Yang, J., Peng, B., Mandlekar, A., Tan, R., Chao, Y.-W., Lin, B. Y., et al. Latent Action Pretraining from Videos. In ICLR , 2025.

Ye et al. (2023) Ye, W., Zhang, Y., Abbeel, P., and Gao, Y. Become a Proficient Player with Limited Data through Watching Pure Videos. In ICLR , 2023.

Yin et al. (2025) Yin, T., Zhang, Q., Zhang, R., Freeman, W. T., Durand, F., Shechtman, E., and Huang, X. From Slow Bidirectional to Fast Causal Video Generators. In CVPR , 2025.

Yu et al. (2025) Yu, J., Qin, Y., Wang, X., Wan, P., Zhang, D., and Liu, X. GameFactory: Creating New Games with Generative Interactive Videos. arXiv preprint arXiv:2501.08325 , 2025.

Zhang et al. (2022) Zhang, J., Zhu, R., and Ohn-Bar, E. SelfD: Self-Learning Large-Scale Driving Policies From the Web. In CVPR , 2022.

Zhang et al. (2024) Zhang, L., Kan, M., Shan, S., and Chen, X. PreLAR: World Model Pre-Training with Learnable Action Representation. In ECCV , 2024.

Zhang et al. (2018) Zhang, R., Isola, P., Efros, A. A., Shechtman, E., and Wang, O. The Unreasonable Effectiveness of Deep Features as a Perceptual Metric. In CVPR , 2018.

Zhen et al. (2024) Zhen, H., Qiu, X., Chen, P., Yang, J., Yan, X., Du, Y., Hong, Y., and Gan, C. 3D-VLA: A 3D Vision-Language-Action Generative World Model. In ICML , 2024.

Zhou et al. (2024a) Zhou, G., Pan, H., LeCun, Y., and Pinto, L. DINO-WM: World Models on Pre-Trained Visual Features enable Zero-Shot Planning. arXiv preprint arXiv:2411.04983 , 2024a.

Zhou et al. (2024b) Zhou, S., Du, Y., Chen, J., Li, Y., Yeung, D.-Y., and Gan, C. RoboDreamer: Learning Compositional World Models for Robot Imagination. In ICML , 2024b.

Zhu et al. (2024) Zhu, F., Wu, H., Guo, S., Liu, Y., Cheang, C., and Kong, T. IRASim: Learning Interactive Real-Robot Action Simulators. arXiv preprint arXiv:2406.14540 , 2024.

Zhu et al. (2020) Zhu, Y., Wong, J., Mandlekar, A., Martín-Martín, R., Joshi, A., Nasiriany, S., and Zhu, Y. robosuite: A Modular Simulation Framework and Benchmark for Robot Learning. arXiv preprint arXiv:2009.12293 , 2020.

## Appendix A Datasets

## A.1 Data Collection and Generation

Our training data is primarily sourced from four publicly accessible datasets (Goyal et al., 2017 ; Grauman et al., 2022 ; O’Neill et al., 2024 ; Ju et al., 2024 ) that represent various actions in typical interactive scenarios. For the videos from Open X-Embodiment (O’Neill et al., 2024 ) , we keep both egocentric and exocentric demonstrations to encompass a wide spectrum of action patterns. Note that we manually remove the unfavorable subsets that are dominated by static, nonconsecutive, low-frequency and low-resolution frames.

To further enrich the diversity of our data, we also automatically generate a massive number of transitions from two gaming platforms developed by OpenAI (Nichol et al., 2018 ; Cobbe et al., 2020 ) . We manually search on the Internet and import the ROMs we found into Gym Retro (Nichol et al., 2018 ) , resulting in a total of 1000 interactive environments (see Table 8 for the full list). For the 16 environments in Procgen (Cobbe et al., 2020 ) , we hold out 1000 start levels for evaluation and use the remaining 9000 levels for training. All samples are generated using the “hard” mode. We take a random action at each time step to collect 1M transitions for each Gym Retro environment and 10M for each Procgen environment. Unlike Genie (Bruce et al., 2024 ) that samples all actions uniformly in their case study, we employ a biased action sampling strategy to encourage broader exploration. Specifically, we increase the probability of selecting a particular action for a short period and then alternate these probabilities in the subsequent period. As shown in Figure 8 , this simple strategy leads to much more diverse scenes in our data. Generating data with reinforcement learning agents may further boost the scene diversity (Kazemi et al., 2024 ; Yang et al., 2024d ; Valevski et al., 2025 ) , which we leave for future work. In Figure 9 , we visualize some representative environments in our final dataset.

## A.2 Data Mixture

Since the datasets vary in size and diversity, it is challenging to balance them perfectly. Therefore, we simply weight all subsets according to the number of videos during training. We report detailed statistics of our training data in Table 7 .

Table 7: Data organization. Data sources, generation procedures, approximated frame counts, and mixture ratios for our training.

[TABLE] Category Data Source Automated # Frames Ratios 2D Video Game Gym Retro (Nichol et al., 2018 ) ✓ 1000M 49% Procgen Benchmark (Cobbe et al., 2020 ) ✓ 144M 2% Robot Data Open X-Embodiment (O’Neill et al., 2024 ) ✗ 170M 30% Human Activity Ego4D (Grauman et al., 2022 ) ✗ 330M 1% Something-Something V2 (Goyal et al., 2017 ) ✗ 7M 3% 3D Rendering MiraData (Ju et al., 2024 ) ✗ 200M 14% City Walking MiraData (Ju et al., 2024 ) ✗ 120M 1%

Figure 8: Effect of our biased action sampling strategy. Compared to the uniform action sampling strategy, our biased scheme enables agents to explore longer horizons.

Table 8: Full list of collected Gym Retro environments. We import 1000 ROMs from the web for automated data generation at scale.

[TABLE] 1942-Nes 1943-Nes 3NinjasKickBack-Genesis 8Eyes-Nes AaahhRealMonsters-Genesis AbadoxTheDeadlyInnerWar-Nes AcceleBrid-Snes ActRaiser2-Snes ActionPachio-Snes AddamsFamily-GameBoy AddamsFamily-Genesis AddamsFamily-Nes AddamsFamily-Sms AddamsFamily-Snes AddamsFamilyPugsleysScavengerHunt-Nes AddamsFamilyPugsleysScavengerHunt-Snes AdvancedBusterhawkGleylancer-Genesis Adventure-Atari2600 AdventureIsland-GameBoy AdventureIsland3-Nes AdventureIslandII-Nes AdventuresOfBatmanAndRobin-Genesis AdventuresOfBayouBilly-Nes AdventuresOfDinoRiki-Nes AdventuresOfDrFranken-Snes AdventuresOfKidKleets-Snes AdventuresOfMightyMax-Genesis AdventuresOfMightyMax-Snes AdventuresOfRockyAndBullwinkleAndFriends-Genesis AdventuresOfRockyAndBullwinkleAndFriends-Nes AdventuresOfRockyAndBullwinkleAndFriends-Snes AdventuresOfStarSaver-GameBoy AdventuresOfYogiBear-Snes AeroFighters-Snes AeroStar-GameBoy AeroTheAcroBat-Snes AeroTheAcroBat2-Genesis AeroTheAcroBat2-Snes AfterBurnerII-Genesis AfterBurst-GameBoy AirBuster-Genesis AirCavalry-Snes AirDiver-Genesis AirRaid-Atari2600 Airstriker-Genesis Airwolf-Nes AlfredChicken-GameBoy AlfredChicken-Nes AlfredChicken-Snes Alien-Atari2600 Alien3-Nes Alien3-Sms AlienSoldier-Genesis AlienSyndrome-Sms AlienVsPredator-Snes Alleyway-GameBoy AlphaMission-Nes AlteredBeast-Genesis Amagon-Nes AmazingPenguin-GameBoy AmericanGladiators-Genesis Amidar-Atari2600 ArchRivalsTheArcadeGame-Genesis ArcherMacleansSuperDropzone-Snes ArdyLightfoot-Snes Argus-Nes ArielTheLittleMermaid-Genesis Arkanoid-Nes ArkistasRing-Nes Armadillo-Nes ArrowFlash-Genesis ArtOfFighting-Genesis ArtOfFighting-Snes Assault-Atari2600 Asterix-Atari2600 Asterix-Sms Asterix-Snes AsterixAndObelix-GameBoy AsterixAndTheGreatRescue-Genesis AsterixAndTheGreatRescue-Sms AsterixAndThePowerOfTheGods-Genesis AsterixAndTheSecretMission-Sms Asteroids-Atari2600 Asteroids-GameBoy AstroRabby-GameBoy AstroRoboSasa-Nes AstroWarrior-Sms Astyanax-Nes Athena-Nes Atlantis-Atari2600 AtlantisNoNazo-Nes AtomicRoboKid-Genesis AtomicRunner-Genesis AttackAnimalGakuen-Nes AttackOfTheKillerTomatoes-GameBoy AttackOfTheKillerTomatoes-Nes AwesomePossumKicksDrMachinosButt-Genesis Axelay-Snes AyrtonSennasSuperMonacoGPII-Genesis BOB-Genesis BOB-Snes BWings-Nes BackToTheFuturePartIII-Genesis BadDudes-Nes BadStreetBrawler-Nes BakuretsuSenshiWarrior-GameBoy BalloonFight-Nes BalloonKid-GameBoy Baltron-Nes BananaPrince-Nes BanishingRacer-GameBoy BankHeist-Atari2600 Barbie-Nes BarkleyShutUpAndJam-Genesis BarkleyShutUpAndJam2-Genesis BarneysHideAndSeekGame-Genesis BartSimpsonsEscapeFromCampDeadly-GameBoy Batman-Genesis BatmanReturns-Genesis BatmanReturns-Nes BatmanReturns-Snes BattleArenaToshinden-GameBoy BattleBull-GameBoy BattleCity-Nes BattleMasterKyuukyokuNoSenshiTachi-Snes BattleSquadron-Genesis BattleTechAGameOfArmoredCombat-Genesis BattleUnitZeoth-GameBoy BattleZequeDen-Snes BattleZone-Atari2600 Battletoads-Genesis Battletoads-Nes BattletoadsDoubleDragon-Genesis BattletoadsDoubleDragon-Snes BattletoadsInBattlemaniacs-Snes BattletoadsInRagnaroksWorld-GameBoy BeamRider-Atari2600 BeautyAndTheBeastBellesQuest-Genesis BeautyAndTheBeastRoarOfTheBeast-Genesis BebesKids-Snes Berzerk-Atari2600 BillAndTedsExcellentGameBoyAdventure-GameBoy BiminiRun-Genesis BinaryLand-Nes BioHazardBattle-Genesis BioMetal-Snes BioMiracleBokutteUpa-Nes BioSenshiDanIncreaserTonoTatakai-Nes BirdWeek-Nes BishoujoSenshiSailorMoon-Genesis BishoujoSenshiSailorMoonR-Snes BlaZeonTheBioCyborgChallenge-Snes BladeEagle-Sms BladesOfVengeance-Genesis BlockKuzushi-Snes BlockKuzushiGB-GameBoy Blockout-Genesis BodyCount-Genesis BombJack-GameBoy BomberRaid-Sms BonkersWaxUp-Sms BoobyBoys-GameBoy BoobyKids-Nes BoogermanAPickAndFlickAdventure-Genesis BoogermanAPickAndFlickAdventure-Snes BoogieWoogieBowling-Genesis BoulderDash-GameBoy BoulderDash-Nes Bowling-Atari2600 Boxing-Atari2600 BoxingLegendsOfTheRing-Genesis BramStokersDracula-Genesis BramStokersDracula-Nes BramStokersDracula-Snes BrawlBrothers-Snes BreakThru-Nes Breakout-Atari2600 BronkieTheBronchiasaurus-Snes BubbaNStix-Genesis BubbleAndSqueak-Genesis BubbleBobble-Nes BubbleBobble-Sms BubbleBobblePart2-Nes BubbleGhost-GameBoy BubsyII-Genesis BubsyII-Snes BubsyInClawsEncountersOfTheFurredKind-Genesis BubsyInClawsEncountersOfTheFurredKind-Snes BuckyOHare-Nes BugsBunnyBirthdayBlowout-Nes BullsVersusBlazersAndTheNBAPlayoffs-Genesis BullsVsLakersAndTheNBAPlayoffs-Genesis BuraiFighter-Nes BurningForce-Genesis CacomaKnightInBizyland-Snes Cadash-Genesis CalRipkenJrBaseball-Genesis Caliber50-Genesis CaliforniaGames-Genesis Cameltry-Snes CannonFodder-Genesis CannonFodder-Snes CaptainAmericaAndTheAvengers-Genesis CaptainAmericaAndTheAvengers-Nes CaptainAmericaAndTheAvengers-Snes CaptainCommando-Snes CaptainPlanetAndThePlaneteers-Genesis CaptainPlanetAndThePlaneteers-Nes CaptainSilver-Nes Carnival-Atari2600 Castelian-Nes CastleOfIllusion-Genesis Castlevania-Nes CastlevaniaBloodlines-Genesis CastlevaniaDraculaX-Snes CastlevaniaIIIDraculasCurse-Nes CastlevaniaTheNewGeneration-Genesis CatNindenTeyandee-Nes Centipede-Atari2600 ChacknPop-Nes Challenger-Nes ChampionsWorldClassSoccer-Genesis ChampionshipProAm-Genesis ChaosEngine-Genesis ChaseHQII-Genesis CheeseCatAstropheStarringSpeedyGonzales-Genesis CheeseCatAstropheStarringSpeedyGonzales-Sms ChesterCheetahTooCoolToFool-Genesis ChesterCheetahTooCoolToFool-Snes ChesterCheetahWildWildQuest-Genesis ChesterCheetahWildWildQuest-Snes ChiChisProChallengeGolf-Genesis ChikiChikiBoys-Genesis Choplifter-Nes ChoplifterIIIRescueSurvive-Snes ChopperCommand-Atari2600 ChouFuyuuYousaiExedExes-Nes ChoujikuuYousaiMacross-Nes ChoujikuuYousaiMacrossScrambledValkyrie-Snes ChubbyCherub-Nes ChuckRock-Genesis ChuckRock-Sms ChuckRock-Snes ChuckRockIISonOfChuck-Genesis ChuckRockIISonOfChuck-Sms CircusCaper-Nes CircusCharlie-Nes CityConnection-Nes ClayFighter-Genesis Claymates-Snes Cliffhanger-Genesis Cliffhanger-Nes Cliffhanger-Snes CloudMaster-Sms CluCluLand-Nes CobraTriangle-Nes CodeNameViper-Nes CollegeSlam-Genesis Columns-Genesis ColumnsIII-Genesis CombatCars-Genesis ComicalMachineGunJoe-Sms ComixZone-Genesis Conan-Nes CongosCaper-Snes ConquestOfTheCrystalPalace-Nes ContraForce-Nes CoolSpot-Genesis CoolSpot-Sms CoolSpot-Snes CosmicEpsilon-Nes CosmoGangTheVideo-Snes CrackDown-Genesis CrazyClimber-Atari2600 CrossFire-Nes CrueBallHeavyMetalPinball-Genesis Curse-Genesis CutieSuzukiNoRingsideAngel-Genesis CutthroatIsland-Genesis CyberShinobi-Sms Cyberball-Genesis Cybernator-Snes CyborgJustice-Genesis DJBoy-Genesis DaffyDuckInHollywood-Sms DaffyDuckTheMarvinMissions-Snes DaisenpuuTwinHawk-Genesis DananTheJungleFighter-Sms DangerousSeed-Genesis DariusForce-Snes DariusII-Genesis DariusTwin-Snes DarkCastle-Genesis Darkman-Nes Darwin4081-Genesis DashGalaxyInTheAlienAsylum-Nes DashinDesperadoes-Genesis DavidRobinsonsSupremeCourt-Genesis DazeBeforeChristmas-Genesis DazeBeforeChristmas-Snes DeadlyMoves-Genesis DeathDuel-Genesis DeepDuckTroubleStarringDonaldDuck-Sms Defender-Atari2600 DefenderII-Nes DemonAttack-Atari2600 DennisTheMenace-Snes DesertStrikeReturnToTheGulf-Genesis DevilCrashMD-Genesis DevilishTheNextPossession-Genesis DickTracy-Genesis DickTracy-Sms DickVitalesAwesomeBabyCollegeHoops-Genesis DigDugIITroubleInParadise-Nes DiggerTheLegendOfTheLostCity-Nes DimensionForce-Snes DinoCity-Snes DinoLand-Genesis DirtyHarry-Nes DonDokoDon-Nes DonkeyKong-Nes DonkeyKong3-Nes DonkeyKongCountry-Snes DonkeyKongCountry2-Snes DonkeyKongCountry3DixieKongsDoubleTrouble-Snes DonkeyKongJr-Nes DoubleDragon-Genesis DoubleDragon-Nes DoubleDragonIITheRevenge-Genesis DoubleDragonIITheRevenge-Nes DoubleDragonVTheShadowFalls-Genesis DoubleDribbleThePlayoffEdition-Genesis DoubleDunk-Atari2600 DrRobotniksMeanBeanMachine-Genesis DragonPower-Nes DragonSpiritTheNewLegend-Nes DragonTheBruceLeeStory-Genesis DragonTheBruceLeeStory-Snes DragonsLair-Snes DragonsRevenge-Genesis DreamTeamUSA-Genesis DynamiteDuke-Genesis DynamiteDuke-Sms DynamiteHeaddy-Genesis ESPNBaseballTonight-Genesis EarnestEvans-Genesis EarthDefenseForce-Snes ElViento-Genesis ElementalMaster-Genesis ElevatorAction-Atari2600 ElevatorAction-Nes EliminateDown-Genesis Enduro-Atari2600 EuropeanClubSoccer-Genesis ExMutants-Genesis Exerion-Nes F1-Genesis FZSenkiAxisFinalZone-Genesis FaeryTaleAdventure-Genesis FamilyDog-Snes Fantasia-Genesis FantasticDizzy-Genesis FantasyZone-Sms FantasyZoneIIOpaOpaNoNamida-Nes FantasyZoneIITheTearsOfOpaOpa-Sms FantasyZoneTheMaze-Sms FatalFury-Genesis FatalFury2-Genesis FatalLabyrinth-Genesis FatalRewind-Genesis FelixTheCat-Nes FerrariGrandPrixChallenge-Genesis FightingMasters-Genesis FinalBubbleBobble-Sms FinalFight-Snes FinalFight2-Snes FinalFight3-Snes FinalFightGuy-Snes FireAndIce-Sms FirstSamurai-Snes FishingDerby-Atari2600 FistOfTheNorthStar-Nes Flicky-Genesis Flintstones-Genesis Flintstones-Snes FlintstonesTheRescueOfDinoAndHoppy-Nes FlyingDragonTheSecretScroll-Nes FlyingHero-Nes FlyingHeroBugyuruNoDaibouken-Snes ForemanForReal-Genesis ForgottenWorlds-Genesis FormationZ-Nes FoxsPeterPanAndThePiratesTheRevengeOfCaptainHook-Nes FrankThomasBigHurtBaseball-Genesis Freeway-Atari2600 Frogger-Genesis FrontLine-Nes Frostbite-Atari2600 FushigiNoOshiroPitPot-Sms GIJoeARealAmericanHero-Nes GIJoeTheAtlantisFactor-Nes GadgetTwins-Genesis Gaiares-Genesis GainGround-Genesis GalagaDemonsOfDeath-Nes GalaxyForce-Sms GalaxyForceII-Genesis Gauntlet-Genesis Gauntlet-Sms Geimos-Nes GeneralChaos-Genesis GhostsnGoblins-Nes GhoulSchool-Nes GhoulsnGhosts-Genesis Gimmick-Nes GlobalDefense-Sms GlobalGladiators-Genesis Gods-Genesis Gods-Snes GokujouParodius-Snes GoldenAxe-Genesis GoldenAxeIII-Genesis Gopher-Atari2600 Gradius-Nes GradiusII-Nes GradiusIII-Snes GradiusTheInterstellarAssault-GameBoy Granada-Genesis Gravitar-Atari2600 GreatCircusMysteryStarringMickeyAndMinnie-Genesis GreatCircusMysteryStarringMickeyAndMinnie-Snes GreatTank-Nes GreatWaldoSearch-Genesis GreendogTheBeachedSurferDude-Genesis Gremlins2TheNewBatch-Nes GrindStormer-Genesis Growl-Genesis GuardianLegend-Nes GuerrillaWar-Nes GunNac-Nes Gunship-Genesis Gynoug-Genesis Gyrodine-Nes Gyruss-Nes HammerinHarry-Nes HangOn-Sms HardDrivin-Genesis HarleysHumongousAdventure-Snes Havoc-Genesis HeavyBarrel-Nes HeavyNova-Genesis HeavyUnitMegaDriveSpecial-Genesis Hellfire-Genesis HelloKittyWorld-Nes Hero-Atari2600 HighStakesGambling-GameBoy HomeAlone-Genesis HomeAlone2LostInNewYork-Genesis HomeAlone2LostInNewYork-Nes Hook-Genesis Hook-Snes HuntForRedOctober-Nes HuntForRedOctober-Snes Hurricanes-Genesis Hurricanes-Snes IMGInternationalTourTennis-Genesis IceClimber-Nes IceHockey-Atari2600 Ikari-Nes IkariIIITheRescue-Nes Ikki-Nes Imperium-Snes Incantation-Snes IncredibleCrashDummies-Genesis IncredibleHulk-Genesis IncredibleHulk-Sms IncredibleHulk-Snes IndianaJonesAndTheLastCrusade-Genesis IndianaJonesAndTheTempleOfDoom-Nes InsectorX-Genesis InsectorX-Nes InspectorGadget-Snes IronSwordWizardsAndWarriorsII-Nes IshidoTheWayOfStones-Genesis IsolatedWarrior-Nes ItchyAndScratchyGame-Snes IzzysQuestForTheOlympicRings-Genesis IzzysQuestForTheOlympicRings-Snes Jackal-Nes JackieChansActionKungFu-Nes JajamaruNoDaibouken-Nes JamesBond007TheDuel-Genesis JamesBond007TheDuel-Sms JamesBondJr-Nes JamesPond2CodenameRoboCod-Sms JamesPond3-Genesis JamesPondIICodenameRobocod-Genesis JamesPondUnderwaterAgent-Genesis Jamesbond-Atari2600 Jaws-Nes JellyBoy-Snes JetsonsCogswellsCaper-Nes JetsonsInvasionOfThePlanetPirates-Snes JewelMaster-Genesis JoeAndMac-Genesis JoeAndMac-Nes JoeAndMac-Snes JoeAndMac2LostInTheTropics-Snes JourneyEscape-Atari2600 JourneyToSilius-Nes Joust-Nes JuJuDensetsuTokiGoingApeSpit-Genesis JudgeDredd-Genesis JudgeDredd-Snes JungleBook-Genesis JungleBook-Nes JungleBook-Snes JusticeLeagueTaskForce-Genesis KaGeKiFistsOfSteel-Genesis Kaboom-Atari2600 KabukiQuantumFighter-Nes KaiketsuYanchaMaru2KarakuriLand-Nes KaiketsuYanchaMaru3TaiketsuZouringen-Nes KaiteTsukutteAsoberuDezaemon-Snes KamenNoNinjaAkakage-Nes Kangaroo-Atari2600 KanshakudamaNageKantarouNoToukaidouGojuusanTsugi-Nes KeroppiToKeroriinuNoSplashBomb-Nes KidChameleon-Genesis KidIcarus-Nes KidKlownInCrazyChase-Snes KidKlownInNightMayorWorld-Nes KidNikiRadicalNinja-Nes KingOfDragons-Snes KingOfTheMonsters2-Genesis KingOfTheMonsters2-Snes KirbysAdventure-Nes KnightsOfTheRound-Snes Krull-Atari2600 KungFu-Nes KungFuHeroes-Nes KungFuKid-Sms KungFuMaster-Atari2600 LandOfIllusionStarringMickeyMouse-Sms LastActionHero-Genesis LastActionHero-Nes LastActionHero-Snes LastBattle-Genesis LastStarfighter-Nes LawnmowerMan-Genesis Legend-Snes LegendOfGalahad-Genesis LegendOfKage-Nes LegendOfPrinceValiant-Nes LegendaryWings-Nes LethalEnforcers-Genesis LethalEnforcersIIGunFighters-Genesis LethalWeapon-Snes LifeForce-Nes LineOfFire-Sms LittleMermaid-Nes LowGManTheLowGravityMan-Nes LuckyDimeCaperStarringDonaldDuck-Sms MCKids-Nes MUSHA-Genesis MagicBoy-Snes MagicSword-Snes MagicalQuestStarringMickeyMouse-Snes MagicalTaruruutoKun-Genesis Magmax-Nes MaouRenjishi-Genesis MappyLand-Nes MarbleMadness-Genesis MarbleMadness-Sms MarioBros-Nes Marko-Genesis Marsupilami-Genesis MarvelLand-Genesis Mask-Snes MasterOfDarkness-Sms McDonaldsTreasureLandAdventure-Genesis MechanizedAttack-Nes MegaMan-Nes MegaMan2-Nes MegaManTheWilyWars-Genesis MegaSWIV-Genesis MegaTurrican-Genesis MendelPalace-Nes MetalStorm-Nes MichaelJacksonsMoonwalker-Genesis MichaelJacksonsMoonwalker-Sms MickeyMousecapade-Nes MidnightResistance-Genesis MightyBombJack-Nes MightyFinalFight-Nes MightyMorphinPowerRangers-Genesis MightyMorphinPowerRangersTheMovie-Genesis MightyMorphinPowerRangersTheMovie-Snes Millipede-Nes MitsumeGaTooru-Nes MoeroTwinBeeCinnamonHakaseOSukue-Nes MonsterInMyPocket-Nes MonsterLair-Genesis MonsterParty-Nes MontezumaRevenge-Atari2600 MoonPatrol-Atari2600 MortalKombat-Genesis MortalKombat3-Genesis MortalKombatII-Genesis MrNutz-Genesis MrNutz-Snes MsPacMan-Genesis MsPacMan-Nes MsPacMan-Sms MsPacman-Atari2600 MutantVirusCrisisInAComputerWorld-Nes MyHero-Sms MysteryQuest-Nes NARC-Nes NHL94-Genesis NHL941on1-Genesis NameThisGame-Atari2600 NewZealandStory-Genesis NewZealandStory-Sms Ninja-Sms NinjaCrusaders-Nes NinjaGaiden-Nes NinjaGaiden-Sms NinjaGaidenIIITheAncientShipOfDoom-Nes NinjaGaidenIITheDarkSwordOfChaos-Nes NinjaKid-Nes NoahsArk-Nes NormysBeachBabeORama-Genesis OperationWolf-Nes Ottifants-Genesis Ottifants-Sms OutToLunch-Snes OverHorizon-Nes POWPrisonersOfWar-Nes PacInTime-Snes PacManNamco-Nes PacMania-Genesis PacMania-Sms PanicRestaurant-Nes Paperboy-Genesis Paperboy-Nes Paperboy-Sms Paperboy2-Genesis Parodius-Nes Parodius-Snes PeaceKeepers-Snes PenguinKunWars-Nes Phalanx-Snes Phelios-Genesis Phoenix-Atari2600 PinkGoesToHollywood-Genesis PiratesOfDarkWater-Snes PitFighter-Genesis PitFighter-Sms Pitfall-Atari2600 PitfallTheMayanAdventure-Genesis PitfallTheMayanAdventure-Snes PizzaPop-Nes Plok-Snes Pong-Atari2600 Pooyan-Atari2600 Pooyan-Nes Popeye-Nes PopnTwinBee-Snes PopnTwinBeeRainbowBellAdventures-Snes PorkyPigsHauntedHoliday-Snes PoseidonWars3D-Sms PowerAthlete-Genesis PowerPiggsOfTheDarkAge-Snes PowerStrike-Sms PowerStrikeII-Sms Predator2-Genesis Predator2-Sms PrehistorikMan-Snes PrivateEye-Atari2600 PsychicWorld-Sms Pulseman-Genesis PunchOut-Nes Punisher-Genesis Punisher-Nes PussNBootsPerosGreatAdventure-Nes PuttySquad-Snes QBert-Nes Qbert-Atari2600 QuackShot-Genesis Quartet-Sms Quarth-Nes RType-Sms RTypeIII-Snes RadicalRex-Genesis RadicalRex-Snes RaidenDensetsu-Snes RaidenDensetsuRaidenTrad-Genesis RainbowIslands-Nes RainbowIslandsStoryOfTheBubbleBobble2-Sms RamboFirstBloodPartII-Sms RamboIII-Genesis Rampage-Nes RangerX-Genesis RastanSagaII-Genesis Realm-Snes RenAndStimpyShowPresentsStimpysInvention-Genesis RenAndStimpyShowVeediots-Snes RenderingRangerR2-Snes Renegade-Nes Renegade-Sms RevengeOfShinobi-Genesis RiseOfTheRobots-Genesis RiskyWoods-Genesis Ristar-Genesis RivalTurf-Snes Riverraid-Atari2600 RoadRunner-Atari2600 RoadRunnersDeathValleyRally-Snes RoboCop2-Nes RoboCop3-Genesis RoboCop3-Nes RoboCop3-Sms RoboCop3-Snes RoboCopVersusTheTerminator-Sms RoboCopVersusTheTerminator-Snes RoboWarrior-Nes RoboccoWars-Nes Robotank-Atari2600 RocketKnightAdventures-Genesis RockinKats-Nes Rollerball-Nes Rollergames-Nes RollingThunder2-Genesis RunSaber-Snes RunningBattle-Sms RushnAttack-Nes SCATSpecialCyberneticAttackTeam-Nes SDHeroSoukessenTaoseAkuNoGundan-Nes Sagaia-Genesis Sagaia-Sms SaintSword-Genesis SameSameSame-Genesis SamuraiShodown-Genesis Sansuu5And6NenKeisanGame-Nes Satellite7-Sms Seaquest-Atari2600 SecondSamurai-Genesis SectionZ-Nes Seicross-Nes SeikimaIIAkumaNoGyakushuu-Nes SenjouNoOokamiIIMercs-Genesis ShadowDancerTheSecretOfShinobi-Genesis ShadowOfTheBeast-Genesis ShaqFu-Genesis Shatterhand-Nes Shinobi-Sms ShinobiIIIReturnOfTheNinjaMaster-Genesis SilverSurfer-Nes SimpsonsBartVsTheSpaceMutants-Genesis SimpsonsBartVsTheSpaceMutants-Nes SimpsonsBartVsTheWorld-Nes SimpsonsBartmanMeetsRadioactiveMan-Nes SkeletonKrew-Genesis Skiing-Atari2600 SkuljaggerRevoltOfTheWesticans-Snes SkyDestroyer-Nes SkyKid-Nes SkyShark-Nes SmartBall-Snes SmashTV-Nes Smurfs-Genesis Smurfs-Nes Smurfs-Snes SnakeRattleNRoll-Nes SnowBrothers-Nes Socket-Genesis SolDeace-Genesis Solaris-Atari2600 SoldiersOfFortune-Genesis SonSon-Nes SonicAndKnuckles-Genesis SonicAndKnuckles3-Genesis SonicBlast-Sms SonicBlastMan-Snes SonicBlastManII-Snes SonicTheHedgehog-Genesis SonicTheHedgehog-Sms SonicTheHedgehog2-Genesis SonicTheHedgehog2-Sms SonicTheHedgehog3-Genesis SonicWings-Snes SpaceHarrier-Nes SpaceHarrier-Sms SpaceHarrier3D-Sms SpaceHarrierII-Genesis SpaceInvaders-Atari2600 SpaceInvaders-Nes SpaceInvaders-Snes SpaceInvaders91-Genesis SpaceMegaforce-Snes SpankysQuest-Snes Sparkster-Genesis Sparkster-Snes SpartanX2-Nes SpeedyGonzalesLosGatosBandidos-Snes Spelunker-Nes SpiderManReturnOfTheSinisterSix-Sms Splatterhouse2-Genesis SpotGoesToHollywood-Genesis SprigganPowered-Snes SpyHunter-Nes Sqoon-Nes StarForce-Nes StarGunner-Atari2600 StarSoldier-Nes StarWars-Nes StarshipHector-Nes SteelEmpire-Genesis SteelTalons-Genesis Stinger-Nes StoneProtectors-Snes Stormlord-Genesis StreetFighterIISpecialChampionEdition-Genesis StreetSmart-Genesis StreetsOfRage-Genesis StreetsOfRage2-Genesis StreetsOfRage3-Genesis StreetsOfRageII-Sms Strider-Genesis SubTerrania-Genesis SubmarineAttack-Sms SunsetRiders-Genesis SuperAdventureIsland-Snes SuperAlfredChicken-Snes SuperArabian-Nes SuperBCKid-Snes SuperC-Nes SuperCastlevaniaIV-Snes SuperDoubleDragon-Snes SuperFantasyZone-Genesis SuperGhoulsnGhosts-Snes SuperHangOn-Genesis SuperJamesPond-Snes SuperMarioBros-Nes SuperMarioBros2Japan-Nes SuperMarioBros3-Nes SuperMarioWorld-Snes SuperMarioWorld2-Snes SuperPitfall-Nes SuperRType-Snes SuperSWIV-Snes SuperSmashTV-Genesis SuperSmashTV-Snes SuperSpaceInvaders-Sms SuperStarForce-Nes SuperStarWars-Snes SuperStarWarsReturnOfTheJedi-Snes SuperStarWarsTheEmpireStrikesBack-Snes SuperStrikeGunner-Snes SuperThunderBlade-Genesis SuperTrollIslands-Snes SuperTurrican-Snes SuperTurrican2-Snes SuperValisIV-Snes SuperWidget-Snes SuperWonderBoy-Sms SuperXeviousGumpNoNazo-Nes Superman-Genesis SupermanTheManOfSteel-Sms SwampThing-Nes SwordOfSodan-Genesis SydOfValis-Genesis SylvesterAndTweetyInCageyCapers-Genesis T2TheArcadeGame-Genesis T2TheArcadeGame-Sms TaiyouNoYuushaFighbird-Nes TakahashiMeijinNoBugutteHoney-Nes TargetEarth-Genesis TargetRenegade-Nes TaskForceHarrierEX-Genesis TazMania-Genesis TazMania-Sms TazMania-Snes TeenageMutantNinjaTurtles-Nes TeenageMutantNinjaTurtlesIIITheManhattanProject-Nes TeenageMutantNinjaTurtlesIITheArcadeGame-Nes TeenageMutantNinjaTurtlesIVTurtlesInTime-Snes TeenageMutantNinjaTurtlesTheHyperstoneHeist-Genesis TeenageMutantNinjaTurtlesTournamentFighters-Genesis TeenageMutantNinjaTurtlesTournamentFighters-Nes Tennis-Atari2600 Terminator-Genesis Terminator-Sms Terminator2JudgmentDay-Nes TerraCresta-Nes TetrastarTheFighter-Nes Tetris-GameBoy TetrisAttack-Snes TetsuwanAtom-Nes Thexder-Nes ThunderAndLightning-Nes ThunderBlade-Sms ThunderForceII-Genesis ThunderForceIII-Genesis ThunderForceIV-Genesis ThunderFox-Genesis ThunderSpirits-Snes Thundercade-Nes Tick-Genesis Tick-Snes TigerHeli-Nes TimePilot-Atari2600 TimeZone-Nes TinHead-Genesis TinyToonAdventures-Nes TinyToonAdventuresBusterBustsLoose-Snes TinyToonAdventuresBustersHiddenTreasure-Genesis Toki-Nes TomAndJerry-Snes TotalRecall-Nes TotallyRad-Nes ToxicCrusaders-Genesis ToxicCrusaders-Nes TrampolineTerror-Genesis TransBot-Sms TreasureMaster-Nes Trog-Nes Trojan-Nes TrollsInCrazyland-Nes TroubleShooter-Genesis Truxton-Genesis Turrican-Genesis Tutankham-Atari2600 TwinBee-Nes TwinBee3PokoPokoDaimaou-Nes TwinCobra-Nes TwinCobraDesertAttackHelicopter-Genesis TwinEagle-Nes TwinkleTale-Genesis TwoCrudeDudes-Genesis UNSquadron-Snes UchuuNoKishiTekkamanBlade-Snes UndeadLine-Genesis UniversalSoldier-Genesis Untouchables-Nes UpNDown-Atari2600 UrbanChampion-Nes UruseiYatsuraLumNoWeddingBell-Nes UzuKeobukseon-Genesis VRTroopers-Genesis VaporTrail-Genesis Vectorman-Genesis Vectorman2-Genesis Venture-Atari2600 ViceProjectDoom-Nes VideoPinball-Atari2600 Viewpoint-Genesis Vigilante-Sms VirtuaFighter-32x VolguardII-Nes WWFArcade-Genesis WaniWaniWorld-Genesis Wardner-Genesis Warpman-Nes WaynesWorld-Nes WereBackADinosaursStory-Snes WhipRush-Genesis Widget-Nes WizardOfWor-Atari2600 WizardsAndWarriors-Nes WiznLiz-Genesis Wolfchild-Genesis Wolfchild-Sms Wolfchild-Snes WolverineAdamantiumRage-Genesis WonderBoyInMonsterWorld-Sms WorldHeroes-Genesis WrathOfTheBlackManta-Nes WreckingCrew-Nes XDRXDazedlyRay-Genesis XKaliber2097-Snes XMenMojoWorld-Sms Xenon2Megablast-Genesis Xenophobe-Nes XeviousTheAvenger-Nes Xexyz-Nes YarsRevenge-Atari2600 YoukaiClub-Nes YoukaiDouchuuki-Nes YoungIndianaJonesChronicles-Nes Zanac-Nes Zaxxon-Atari2600 ZeroTheKamikazeSquirrel-Genesis ZeroTheKamikazeSquirrel-Snes ZeroWing-Genesis ZombiesAteMyNeighbors-Snes ZoolNinjaOfTheNthDimension-Genesis ZoolNinjaOfTheNthDimension-Sms ZoolNinjaOfTheNthDimension-Snes

Figure 9: Diversity of our training dataset. Our curated dataset aggregates an extremely wide range of scenarios.

## Appendix B Implementation Details

## B.1 Architecture

The latent action autoencoder adopts a Transformer architecture with 500M parameters. It consists of 16 encoder blocks and 16 decoder blocks using 1024 channels and 16 attention heads. The dimension of the latent actions is 32. The autoregressive world model adopts a 3D UNet architecture following SVD (Blattmann et al., 2023 ) , with 1.5B trainable parameters and a memory length of 6. The default input resolution for both models is 256 × 256 256 256 256\times 256 256 × 256 .

## B.2 Training

The latent action autoencoder is trained for 200K steps from scratch with a batch size of 960. We employ the AdamW optimizer (Loshchilov & Hutter, 2019 ) with a learning rate of 2.5 × 10 − 5 2.5 superscript 10 5 2.5\times 10^{-5} 2.5 × 10 start_POSTSUPERSCRIPT - 5 end_POSTSUPERSCRIPT and a weight decay of 0.01. The hyperparameter β 𝛽 \beta italic_β is set to 2 × 10 − 4 2 superscript 10 4 2\times 10^{-4} 2 × 10 start_POSTSUPERSCRIPT - 4 end_POSTSUPERSCRIPT to achieve a good balance between representation capacity and context disentangling ability.

The autoregressive world model is trained for 80K steps with a batch size of 64 and a learning rate of 5 × 10 − 5 5 superscript 10 5 5\times 10^{-5} 5 × 10 start_POSTSUPERSCRIPT - 5 end_POSTSUPERSCRIPT on 16 NVIDIA A100 GPUs. We adopt a cosine learning rate scheduler with 10K warmup steps. To enhance prediction quality, exponential moving average is also applied during pretraining. The noise augmentation level is randomly selected from a range of 0.0 to 0.7, with an interval of 0.1.

For both latent action autoencoder training and world model pretraining, we randomly jitter the brightness of input frames to augment generalization ability. For all frames with varying aspect ratios, we apply center cropping to avoid padding irrelevant content. We check the meta information of all datasets and downsample the videos to approximately a frame rate of 10 Hz for training.

## B.3 Sampling

By default, we use 5 sampling steps with a classifier-free guidance scale of 1.05 to generate new frames. We do not add noise to the historical frames but condition the world model on an augmentation level of 0.1 as we find this improves the results. A timestep shifting strategy (Kong et al., 2024 ) is also applied to enhance generation quality.

## B.4 Visual Planning on the Procgen Benchmark

We summarize our model predictive control process for visual planning as below:

1. Given the current observation and the image of the final state, where the environment is about to restart with a positive reward, we calculate the current reward as the cosine similarity between them in RGB space. The planning objective is defined as the maximum reward obtained along the planned trajectory.

Given the current observation and the image of the final state, where the environment is about to restart with a positive reward, we calculate the current reward as the cosine similarity between them in RGB space. The planning objective is defined as the maximum reward obtained along the planned trajectory.

2. At each iteration, we sample a population of N 𝑁 N italic_N action sequences, each with a length of L 𝐿 L italic_L , from a distribution. The initial distribution is set to a uniform distribution over four actions ( LEFT , DOWN , UP , RIGHT ).

At each iteration, we sample a population of N 𝑁 N italic_N action sequences, each with a length of L 𝐿 L italic_L , from a distribution. The initial distribution is set to a uniform distribution over four actions ( LEFT , DOWN , UP , RIGHT ).

3. For each sampled action sequence, the world model is used to predict the resulting trajectory, and the reward is calculated for each trajectory.

For each sampled action sequence, the world model is used to predict the resulting trajectory, and the reward is calculated for each trajectory.

4. The top K 𝐾 K italic_K action sequences with the highest rewards are selected, and we update the distribution by increasing the sampling probabilities of these selected actions.

The top K 𝐾 K italic_K action sequences with the highest rewards are selected, and we update the distribution by increasing the sampling probabilities of these selected actions.

5. A new set of N 𝑁 N italic_N action sequences is sampled from the updated distribution, and the process repeats for i 𝑖 i italic_i Cross-Entropy Method iterations.

A new set of N 𝑁 N italic_N action sequences is sampled from the updated distribution, and the process repeats for i 𝑖 i italic_i Cross-Entropy Method iterations.

6. After i 𝑖 i italic_i optimization iterations, the first T 𝑇 T italic_T action in the action sequence with the highest probability is executed in the environment. The planning terminates either when the final state is achieved or when the search limit is exceeded.

After i 𝑖 i italic_i optimization iterations, the first T 𝑇 T italic_T action in the action sequence with the highest probability is executed in the environment. The planning terminates either when the final state is achieved or when the search limit is exceeded.

In practice, we use i = 2 𝑖 2 i=2 italic_i = 2 Cross-Entropy Method iterations. For each iteration, N = 100 𝑁 100 N=100 italic_N = 100 action sequences with a length of L = 15 𝐿 15 L=15 italic_L = 15 are sampled, and the best K = 10 𝐾 10 K=10 italic_K = 10 samples are selected to update the action sampling distribution. After the optimization procedure is done, the first T = 5 𝑇 5 T=5 italic_T = 5 actions are executed in the environment. We set the search limit to 20 steps. For efficiency, we use only 3 denoising steps and disable classifier-free guidance during planning.

## B.5 Visual Planning on the VP 2 Benchmark

We train low-resolution variants at a resolution of 64 × 64 64 64 64\times 64 64 × 64 for control-centric evaluation on the VP 2 benchmark. We follow the official protocol of VP 2 to evaluate all models. During adaptation, we use 5K given trajectories for Robosuite and 35K scripted trajectories with perturbations for RoboDesk for finetuning. Each world model is adapted for 1K steps with a batch size of 32 and a learning rate of 5 × 10 − 4 5 superscript 10 4 5\times 10^{-4} 5 × 10 start_POSTSUPERSCRIPT - 4 end_POSTSUPERSCRIPT . A cost below 0.05 is considered as success in Robosuite tabletop pushing tasks.

## B.6 iVideoGPT Training Details

We resume from the official OpenX checkpoint of iVideoGPT and do not finetune its tokenizer. The model is designed to predict 15 future frames from an initial frame. After pretraining iVideoGPT and our action-aware variant on OpenX for 27K extra steps, we finetune each model with robot actions for 1K steps on BAIR robot pushing dataset. The resulting models are tested on 256 test videos.

## Appendix C Additional Results

## C.1 Action Transfer

Qualitative comparison. We qualitatively compare AdaWorld trained for 50K steps with other baselines in Figure 10 . The results show that our approach is able to represent nuanced actions and exhibit strong transferability across contexts.

Visualizations. We attach more action transfer results in a number of environments in Figures 12 , 13 , 14 , 15 and 16 . Each sample is generated by transferring a latent action sequence with a length of 20.

Failure case study. We present typical failure cases of action transfer in Figure 21 . AdaWorld does not always perfectly understand physics and dynamics. It also struggles to produce high-quality content during long-term rollouts or dramatic view shifts.

## C.2 World Model Adaptation

To demonstrate the advantages of our approach, in Figure 11 , we visualize some simulation results on the held-in test set using the finetuned models in Sec. 3.2.1 . While the model pretrained with action-agnostic videos struggles to faithfully execute the action inputs, our model has rapidly acquired precise action controllability using the same number of steps. This underscores that our approach could serve as a better initialization method for world model adaptation compared to conventional methods.

## C.3 Action Creation through Clustering

As mentioned in Sec. 2.3 , AdaWorld can also easily create a flexible number of control options through latent action clustering. Specifically, we process our Procgen and Gym Retro training set using the latent action encoder to obtain the corresponding latent actions. To generate different control options, we apply K-means clustering to all latent actions, setting the number of clustering centers to the desired number of control options. To examine the controllability of varying actions derived with AdaWorld, we adopt the Δ Δ \Delta roman_Δ PSNR metric following Genie (Bruce et al., 2024 ) . Table 9 shows the Δ Δ \Delta roman_Δ PSNR of the latent action decoder predictions. The larger the Δ Δ \Delta roman_Δ PSNR, the more the predictions are affected by the action conditions and therefore the world model is more controllable. The results in Table 9 demonstrate that the control options derived with AdaWorld represent distinct meanings and exhibit comparable controllability to the discrete counterpart, while the latter does not support a customizable number of actions, as it is fixed once trained.

Table 9: Action controllability evaluation. AdaWorld supports customizing different numbers of actions with strong controllability.

[TABLE] Method Δ Δ \Delta roman_Δ PSNR 4 5 6 7 8 9 10 11 12 Discrete cond. N/A N/A N/A N/A 6.47 N/A N/A N/A N/A AdaWorld 5.67 5.15 7.28 8.23 6.26 7.32 6.07 6.68 6.53

## Appendix D Something-Something v2 Categories for Action Transfer

In Sec. 3.1 , we utilize the top-10 most frequently appearing categories from SSv2 for action transfer evaluation, including “Putting [something] on a surface”, “Moving [something] up”, “Pushing [something] from left to right”, “Moving [something] down”, “Covering [something] with [something]”, “Pushing [something] from right to left”, “Uncovering [something]”, “Taking [one of many similar things on the table]”, “Throwing [something]”, and “Putting [something] into [something]”.

## Appendix E Selected Scenes for Visual Planning

To guarantee an effective evaluation, we conduct an exhaustive search using the ground truth environments to identify viable Procgen test scenes that can be completed in an acceptable number of steps by goal image matching. This results in a total of 120 scenes for our visual planning experiments in Sec. 3.2.2 . In Figures 20 , 17 , 18 and 19 , we illustrate the initial states of all selected scenes. The scenes from survival-oriented environments ( e.g . , BigFish and BossFight) are not considered in our evaluation.

## Appendix F Related Work

## F.1 World Models

Driven by advances in deep generative models (Peebles & Xie, 2023 ; Yang et al., 2025 ) , world models have made encouraging strides recently. They aim to replicate the transitions of the world through generation (Sutton, 1991 ; Ha & Schmidhuber, 2018 ; Yang et al., 2024c ; Lu et al., 2024 , 2025 ; Agarwal et al., 2025 ) , enabling agents to perform decision making entirely in imagination even when confronted with unseen situations (Kaiser et al., 2020 ; Micheli et al., 2023 ; Hafner et al., 2023 ; Du et al., 2023 ; Mazzaglia et al., 2024 ) . This capability has proven beneficial for gaming agents (Kim et al., 2020 ; Alonso et al., 2024 ; Pearce et al., 2024 ; He et al., 2025 ) , autonomous vehicles (Kim et al., 2021 ; Hu et al., 2023 ; Yang et al., 2024a ; Gao et al., 2024 ; Wang et al., 2024 ; Bar et al., 2025 ; Hassan et al., 2025 ) , and real robots (Seo et al., 2023 ; Wu et al., 2022 ; Ko et al., 2024 ; Du et al., 2024 ; Zhen et al., 2024 ; Zhou et al., 2024b ; Wu et al., 2024 ; Zhu et al., 2024 ; Zhou et al., 2024a ; Bu et al., 2024 ; Wang et al., 2025 ; Qi et al., 2025 ; Wu et al., 2025 ) .

Despite the substantial benefits, existing works often suffer from costly training that requires extensive annotations to learn new actions in different environments. To mitigate this issue, some efforts have explored more efficient world modeling through pretraining from passive videos (Watter et al., 2015 ; Seo et al., 2022 ; Mendonca et al., 2023 ; Wu et al., 2023 ) . However, these methods primarily focus on obtaining compact world representations rather than learning control interfaces that can be readily adapted with limited interactions and computations. Another family of research investigates efficient online adaptation (Yang et al., 2024b ; Rigter et al., 2024 ; Hong et al., 2025 ) , but they primarily focus on parameter efficiency by assuming that the parameters of the pretrained video models are frozen or inaccessible.

While a recent study (Bruce et al., 2024 ) has explored learning interactive environments from 2D gameplay videos, it is limited to 8 fixed actions, which constrains its ability to express and adapt to more fine-grained actions. In contrast, we advocate for using a continuous latent action space, maximizing flexibility for efficient action transfer and enabling several unique applications for adaptable world modeling.

## F.2 Latent Action from Videos

Humans can comprehend the notion of various actions by observing others to behave (Rizzolatti et al., 1996 ; Rybkin et al., 2019 ; Schmeckpeper et al., 2020 ; Yatim et al., 2024 ; Ling et al., 2025 ) . To develop intelligent agents, it is intriguing to automatically extract similar action primitives from videos. Some approaches align human and robot manipulation videos in a shared space to derive meaningful action prototypes (Xu et al., 2023b ) . However, they require collecting semantically paired videos, which limits their scalability for most real-world tasks.

To avoid reliance on video pairs, some works extract implicit latent actions through fully unsupervised learning (Edwards et al., 2019 ; Menapace et al., 2021 , 2022 ; Ye et al., 2023 ; Schmidt & Jiang, 2024 ; Zhang et al., 2024 ; Sun et al., 2024 ; Villar-Corrales & Behnke, 2025 ) . However, they mainly focus on a single environment with limited complexity. While more recent works extend similar approaches to multiple datasets (Cui et al., 2024 ; Chen et al., 2024b , c ; Ye et al., 2025 ; Bu et al., 2025 ; Ren et al., 2025 ) , they mainly leverage latent actions as the objectives for behavior cloning. Consequently, they always adopt discrete actions to fit the policy networks (Kim et al., 2024 ) , leading to significant ambiguity due to discretization (Nikulin et al., 2025 ) . Thus, the potential of latent actions for adaptable world modeling remains underexplored.

Figure 10: Qualitative comparison of action transferability. AdaWorld can accurately identify the demonstrated action and precisely transfer it to another context, while the other baselines fall short in doing so.

Figure 11: Minecraft adaptation results after finetuning 800 steps with 100 samples for each action. Our approach efficiently achieves precise action controllability with minimal action-labeled data and finetuning, while the action-agnostic pretraining baseline fails to perform the correct actions.

Figure 12: Additional action transfer results by AdaWorld. Best viewed with zoom-in.

Figure 13: Additional action transfer results by AdaWorld. Best viewed with zoom-in.

Figure 14: Additional action transfer results by AdaWorld. Best viewed with zoom-in.

Figure 15: Additional action transfer results by AdaWorld. Best viewed with zoom-in.

Figure 16: Additional action transfer results by AdaWorld. Best viewed with zoom-in.

Figure 17: Heist scenes for planning evaluation. The figure illustrates the initial states of all selected scenes.

Figure 18: Jumper scenes for planning evaluation. The figure illustrates the initial states of all selected scenes.

Figure 19: Maze scenes for planning evaluation. The figure illustrates the initial states of all selected scenes.

Figure 20: CaveFlyer scenes for planning evaluation. The figure illustrates the initial states of all selected scenes.

Figure 21: Examples of failure cases. AdaWorld is by no means perfect in simulating real-world physics, dynamic agents, long-term rollouts, and significant view changes.