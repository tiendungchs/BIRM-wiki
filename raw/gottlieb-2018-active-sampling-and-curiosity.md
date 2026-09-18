---
title: "Towards a neuroscience of active sampling and curiosity - Nature Reviews Neuroscience"
source: "https://www.nature.com/articles/s41583-018-0078-0"
author:
  - "[[Jacqueline Gottlieb]]"
  - "[[Pierre-Yves Oudeyer]]"
published: 2018-11-05
created: 2026-09-18
description: "In natural behaviour, animals actively interrogate their environments using endogenously generated ‘question-and-answer’ strategies. However, in laboratory settings participants typically engage with externally imposed stimuli and tasks, and the mechanisms of active sampling remain poorly understood. We review a nascent neuroscientific literature that examines active-sampling policies and their relation to attention and curiosity. We distinguish between information sampling, in which organisms reduce uncertainty relevant to a familiar task, and information search, in which they investigate in an open-ended fashion to discover new tasks. We review evidence that both sampling and search depend on individual preferences over cognitive states, including attitudes towards uncertainty, learning progress and types of information. We propose that, although these preferences are non-instrumental and can on occasion interfere with external goals, they are important heuristics that allow organisms to cope with the high complexity of both sampling and search, and generate curiosity-driven investigations in large, open environments in which rewards are sparse and ex ante unknown. Animals may adopt an active-sampling strategy to assess their environment. In this Review, Jacqueline Gottlieb and Pierre-Yves Oudeyer explore the emerging neuroscientific literature examining active sampling and how it relates to attention and curiosity."
tags:
  - "clippings"
---
## Abstract

In natural behaviour, animals actively interrogate their environments using endogenously generated ‘question-and-answer’ strategies. However, in laboratory settings participants typically engage with externally imposed stimuli and tasks, and the mechanisms of active sampling remain poorly understood. We review a nascent neuroscientific literature that examines active-sampling policies and their relation to attention and curiosity. We distinguish between information sampling, in which organisms reduce uncertainty relevant to a familiar task, and information search, in which they investigate in an open-ended fashion to discover new tasks. We review evidence that both sampling and search depend on individual preferences over cognitive states, including attitudes towards uncertainty, learning progress and types of information. We propose that, although these preferences are non-instrumental and can on occasion interfere with external goals, they are important heuristics that allow organisms to cope with the high complexity of both sampling and search, and generate curiosity-driven investigations in large, open environments in which rewards are sparse and ex ante unknown.

## Introduction

Since the earliest days of psychology and neuroscience, it has been recognized that the stream of evidence impinging on sensory receptors is ambiguous and incomplete, and animals must use active inference to make sense of the world. In vision, which is a dominant sensory modality in humans and non-human primates, the brain must use a retinal input that is 2D, constantly moving and ambiguous to infer the true state of a world that is stable, 3D and populated by meaningful entities. The relative insufficiency of the raw sensory input and the consequent need for active interpretation extend to all sensory modalities and all types of decision makers and behavioural situations. The efficiency with which biological nervous systems satisfy this goal is arguably a crowning achievement of evolution; its magnitude is made fully apparent by modern artificial intelligence applications such as drones or self-driving cars, in which it remains a considerable challenge to interpret rich, naturalistic sensory streams.

Among the most striking manifestations of active interpretation is the fact that, rather than building complete representations of all the information available to them, intelligent beings sparsely sample the rich, incoming sensory streams. Sparse sampling is a necessity for any limited-capacity organism that can sense much more information than it can fully process. Sampling is routinely manifested in attention and active-sensing behaviours, whereby animals inspect — that is, touch, listen, whisk or look at — selected sensory cues. In addition, it is expressed in intrinsically motivated behaviours such as curiosity that reflect animals’ interest in specific topics or questions.

Despite the ubiquity and importance of sampling strategies, the organization and neural substrates of these strategies remain oddly unexplored. Studies of curiosity are relative newcomers to the neuroscience field [^1] [^2]. Similarly, although attention and active sensing have been investigated in voluminous literatures, these literatures focus on the ways in which attention and active sensing modulate other systems after they are deployed, rather than on the mechanisms that direct attention and generate sampling policies. Therefore, very little is known regarding the motives that drive attention and curiosity [^3]. How do animals deem some sources of information to be more attention-worthy than others? How do they decide which stimuli or questions warrant investigation and which ones can be safely ignored?

Here, we review a nascent neuroscientific literature that examines these questions relying on novel active-sampling tasks inspired by earlier studies in cognitive psychology and the animal-learning literature (for examples, see refs [^4] [^5] [^6]). We take an unusually integrative approach and focus on the commonalities between attention and curiosity and their relationship with decision-making, in particular in the learning and exploration–exploitation literature. Although attention and curiosity each encompass distinct and heterogeneous mechanisms and have been discussed in separate literatures, we propose that an integrative approach is appropriate at this stage because it highlights a core question that is relevant to both processes: which factor or factors motivate animals to engage with a stimulus or a question?

To organize the discussion, we introduce an important distinction between information sampling and information search. Information sampling involves gathering information relevant for a familiar task, such as looking at relevant stimuli while driving or asking for the answer to a trivia question. Information search, by contrast, refers to situations in which [agents](https://www.nature.com/articles/s41583-018-0078-0#Glos1) explore without prior knowledge of the task or goal. We emphasize the fact that both sampling and, especially, search entail high levels of complexity that are not fully recognized by current normative learning and decision theories [^7]. Finally, we propose that animals cope with this complexity using systems of belief-based utility [^8], which confer value to information as a good in itself and motivate them to explore under conditions in which they must consider many alternatives and the relevant states and potential rewards are ex ante unknown.

Insofar as the questions we consider are related to fundamental ontological constraints of uncertainty and capacity limitations, our discussion draws on many strands of literature to which we cannot do full justice in this brief Review. For further enquiry, the interested reader is referred to excellent studies of active inference and information demand in cognitive psychology and computer science [^4] [^9] [^10] [^11], studies of curiosity in personality and affective psychology [^12] [^13] [^14] [^15], work on child development and education [^2] [^16] [^17] [^18] [^19] [^20], experimental and theoretical considerations of information demand in economics [^21] [^22] [^23], and discussions in philosophy [^24] and the popular literature [^25].

## Active interrogation

In both neuroscience and psychology, the prevailing approach to studying brain and behaviour has been to provide participants with a preselected source of information — typically a sensory cue — and to require them to attend to, memorize or otherwise act on that cue. Studies of active sampling, by contrast, extend this approach by allowing participants to determine which source of information to consult before choosing an action. This apparently simple methodological change prompts a significant conceptual shift. Rather than being solely concerned with reactive processes by which agents process given sensory cues, this approach begs the question of how agents proactively determine which stimulus or question they wish to explore. As we will see in the following sections, this exposes multiple unexplored questions at the interface of traditional studies of cognition, decision-making and motivation.

Because the commodity that is sought by active-sampling behaviours is information, understanding the principles behind these behaviours requires a discussion of an individual’s informational (or epistemic) states. Indeed, it is the extent of an agent’s knowledge at the start of an investigation that defines the key distinction between information sampling and information search.

In information-sampling scenarios, animals gather information in the context of a familiar task that is oriented towards a known goal. These scenarios describe most instrumental tasks that are tested in the laboratory, in which participants seek to maximize an external reward such as money or food and which emulate goal-directed natural behaviours, such as walking, driving or preparing tea [^26] [^27]. In all these behaviours, the decision maker knows the task structure, and this knowledge allows them to focus on a relatively small set of task-relevant actions and cues. For instance, a driver knows that they are likely to experience uncertainty when reaching an intersection and that specific stimuli (such as a traffic light) will help them resolve that uncertainty [^28]. As we discuss in the following sections, information sampling in these familiar instrumental settings is closely related to the exploration–exploitation literature and can be modelled as a strategy of reducing momentary uncertainty to maximize long-term operant gains [^29].

In the case of information search, by contrast, agents investigate under conditions of much higher uncertainty, before knowing whether a useful pattern exists or what it may be. Consider a primitive human who notices that sparks fly when striking two stones. Although the human may notice and be surprised by the spark, they have few bases on which to decide whether and for how long to investigate this observation. Because the human knows next to nothing about the potential uses of fire and sparks, their decision cannot be motivated by reward maximization. Moreover, because they have very little knowledge of the possible explanation of what may give rise to the spark, they must consider a very large set of potentially relevant stimuli and hypotheses. Unlike the driver in the previous example, who can restrict their sampling to a small set of relevant cues, an agent motivated by curiosity must consider a much larger set of potentially relevant hypotheses and invest considerable time and effort into learning and discovery before knowing whether they can reap any benefits from their investigations.

Nevertheless, humans and other animals become curious about specific questions in what seems to be a targeted, non-random fashion, suggesting that they make well-defined choices even in conditions of ignorance and ambiguity. A central argument we make in this Review is that current normative theories (including learning and decision theories) fail to provide adequate descriptions of these choices because they do not take into account their computational complexity [^7] [^30]. We propose instead the alternative view that animals cope with complexity using systems of intrinsic motivations, including curiosity, by which they assign value to specific types of information gain or (changes in) cognitive states, independently of external rewards or environment structure.

We start by reviewing studies of instrumental information sampling and their relation to the attention and exploration–exploitation literatures. We continue by discussing non-instrumental sampling (or information seeking) tasks that operationalize intrinsically motivated sampling and open the door to studies of information search and curiosity.

## Attention and decisions

Many studies of information sampling have been carried out in the domain of eye movements and visual attention, which are our key means of sampling visual information. Studies of eye movements and attention, however, have remained largely separate from the decision literature. Let us start by reviewing this conceptual separation and the ways in which active sampling can help to bridge this gap.

On one side of this great divide, studies of selective attention examine the mechanisms by which the brain modulates the representation of sensory cues. Most extensively developed in the visual systems of humans and non-human primates, this literature documents a range of attentional modulations that shape early and mid-level visual representations, and proposes that these modulations are driven by top-down input from higher-order control networks distributed in the frontal, parietal and temporal lobes [^31] (Fig. [1a](https://www.nature.com/articles/s41583-018-0078-0#Fig1)). In monkeys, neurons in parts of this network, most notably the frontal eye fields (FEFs) and the lateral intraparietal (LIP) area, have visual responses that are spatially tuned and highly selective for task-relevant cues, and are thought to encode sparse priority maps in which only attention-worthy items are strongly represented and which can direct spatial attention or gaze [^32] [^33]. On the other side of the attention–decision divide, decision research explores how animals select between alternative actions [^34] [^35]. These studies have traced the encoding of sensory cues, and the subsequent mechanisms, which are distributed throughout the basal ganglia, the frontal cortex and the parietal lobes that read out the sensory representations, map them on relevant actions and mediate the learning of action–outcome associations [^34] [^35] [^36] (Fig. [1a](https://www.nature.com/articles/s41583-018-0078-0#Fig1)).

![Fig. 1: Proposed architectures of attention and decision-making in current research.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs41583-018-0078-0/MediaObjects/41583_2018_78_Fig1_HTML.png?as=webp)

Fig. 1: Proposed architectures of attention and decision-making in current research.

However, although these studies provide our foundational knowledge of cognitive and brain function, they adopt a simplifying assumption that limits their explanatory power and enforces their conceptual separation. This is the assumption that animals act with near-complete knowledge of a decision situation.

In studies of decision-making, participants select actions from a set of predefined, clearly presented options. Consistent with this empirical practice, decision models that are applied to the data assume that the brain compares the representations of the pre-specified sources of ‘signal’ and ‘noise’. These theories (most notably, signal detection theory and its dynamical variants, sequential sampling and drift diffusion models) allow the possibility that the decision maker has uncertainty about the specific values of decision-relevant states and some degree of control over how much information to sample to reduce that uncertainty and, in some variants, can incorporate attention-like modulations of decision thresholds or the rate of evidence accumulation (for examples, see refs [^37] [^38]). However, these models universally assume that the agent has ex ante knowledge about the identity of the relevant states — that is, which portions of the environment constitute a signal and noise; they make no attempt to explain how the agent makes that determination.

Studies of selective attention allow the possibility that the brain differentially weights sensory cues, but they also start from the simplifying assumption that the decision maker knows to what to attend. In tasks of selective attention, humans are explicitly instructed, for instance, to “look for the T among the Ls”, and monkeys are extensively trained to attend to specific features or locations [^39]. Likewise, neurocomputational models assume that the frontoparietal network has a priority map and can use it to orient gaze and attention, but they do not explain how the map is computed.

In their existing incarnation, therefore, studies of attention and decision-making adopt the simplistic assumption that decision makers have near-perfect knowledge of the relevant aspects of a decision situation [^3] [^27] [^40]. They are thus ill-equipped to capture realistic scenarios in which decision makers must consider multiple potentially relevant attributes and determine which attribute to attend when choosing an action.

## Instrumental sampling

In contrast to the traditional approach described in the previous section, studies of active sampling directly address the nature of information-sampling policies. In these studies, participants are allowed to determine not only which action to take but also which one of several cues to consult before choosing that action. By examining participants’ information demand (as expressed through an eye movement or the press of a button), this approach naturally bridges the divide between attention and decision research. Specifically, it reframes attention as one of several actions that an agent can take that has the role of reducing uncertainty and can be optimized to best serve a given situation (Fig. [1b](https://www.nature.com/articles/s41583-018-0078-0#Fig1)).

In instrumental-sampling scenarios, agents are presumed to seek information that is relevant to a task and can decide which stimulus to sample on the basis of their familiarity with the task-relevant actions and cues. Consider again a driving scenario in which you reach an intersection and must decide what to do (Fig. [2](https://www.nature.com/articles/s41583-018-0078-0#Fig2)). When arriving at the intersection, you may have uncertainty about which action to take — “should I step on the accelerator or the brake?” — and you may expect that the traffic light will reduce that uncertainty. This can be formally described as a distribution of beliefs about the relevant actions, which is initially uncertain (uniform) but is expected to become more heavily skewed towards one of the options if you look at the appropriate cue (Fig. [2](https://www.nature.com/articles/s41583-018-0078-0#Fig2)). In a framework of probabilistic inference, changes in belief distributions can be measured as the difference between the dispersions (uncertainties) of the prior and posterior distributions, using metrics such as Shannon entropy, the Kullback–Leibler divergence or probability gains [^5] [^28]. These measures of expected changes in belief states can, in turn, serve as decision variables for sampling policies. An estimate of expected information gain would motivate the driver to look at the traffic light rather than a cloud, as the light is expected to reduce their uncertainty about the relevant actions to a greater extent than the cloud.

![Fig. 2: Evolution of beliefs when sampling information in different contexts.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs41583-018-0078-0/MediaObjects/41583_2018_78_Fig2_HTML.png?as=webp)

Fig. 2: Evolution of beliefs when sampling information in different contexts.

It is critical to note that, because instrumental information by definition pertains to a desirable goal, it has value only insofar as it furthers that goal. Technically, the value of instrumental information depends on the value of the outcome one seeks to achieve and the marginal increase in the probability of obtaining that outcome when acting with, relative to without, the information [^41] [^42]. In the preceding example, looking at the traffic light has no value per se; it has value only if it helps a driver safely cross an intersection.

Perhaps relying on this direct link between rewards and a reduction in decision uncertainty, many studies to date have focused on each factor individually. At one end of the spectrum, a recent study modelled attention on the basis of simple reward associative rules. The authors trained participants to choose between several options that differed in their reward probabilities while simultaneously learning which stimulus feature was associated with the highest probability [^43]. They proposed that attention is allocated to features on the basis of their recent reward history and that this is mediated by changes in connectivity between networks of cognitive control and reward valuation (specifically, the dorsal frontoparietal network and the ventromedial prefrontal cortex). It must be noted, however, that the simple setting that the authors used for that task (where a visual feature had a one-to-one mapping with rewarded actions) cannot be applied directly to most natural conditions, in which cues bear arbitrary relations with future states and actions [^44].

Several studies addressed these scenarios by modelling visual search as a mechanism for reducing uncertainty in a belief-updating framework similar to that described in Fig. [2](https://www.nature.com/articles/s41583-018-0078-0#Fig2) (refs [^45] [^46] [^47] [^48]. In a series of functional MRI studies, it was proposed that the brain learns the reliability of alternative sensory cues (the potential of a cue to reduce uncertainty) by dynamically tracking visual prediction errors — that is, the extent to which the predictions made by a cue are confirmed or violated — and that this learning depends on the functional connectivity between several areas, including the temporal–parietal junction, the putamen, the FEF and the intraparietal sulcus [^49] [^50] [^51]. Finally, a neurophysiological study in monkeys showed that LIP neurons encoded the relative reliability of competing visual cues and could guide the monkeys’ strategy for sampling the more informative cue [^52] (Fig. [3a,b](https://www.nature.com/articles/s41583-018-0078-0#Fig3)). The evidence for reliability-based attention control is consistent with reports of reliability-based cue integration [^53] and with studies of explicit information demand during categorization [^54], suggesting that it is a widespread cognitive strategy.

![Fig. 3: Neurons in lateral intraparietal area encode expected gains in information during instrumental sampling.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs41583-018-0078-0/MediaObjects/41583_2018_78_Fig3_HTML.png?as=webp)

Fig. 3: Neurons in lateral intraparietal area encode expected gains in information during instrumental sampling.

Importantly, studies of instrumental information demand are closely related to the exploration–exploitation literature [^29]. This literature documents several strategies through which animals and humans trade off between gathering rewards from well-known, familiar options versus exploring less familar options in order to potentially enhance the reward probability on longer time scales. These studies show that humans use targeted exploration, preferentially sampling options with higher uncertainty when this maximizes long-term operant gains [^55] [^56] [^57]. A related proposal is that humans rapidly adjust the weights (leverage) that they afford to different sensory features in ways that compensate for decision variability [^58] [^59] [^60]. Additional studies suggest that humans detect points in time in which the structure of the environment changes and upregulate arousal and learning rates specifically at these points [^61]. Analogous findings in monkeys show that saccade-related activity in the FEF differs for exploratory and exploitative saccades [^62]. Finally, LIP neurons have enhanced reward learning at the informative step in a two-step task in which only one of the decisions was consequential for the final reward, implying that the cells reflected the correct temporal credit assignment independently of the delay between a choice and its outcome [^63]. While the tasks used in these studies are substantially different from those used in attention research, the results are closely related. Both lines of research support the conclusion that humans and monkeys can detect task junctures with high uncertainty and take actions to reduce that uncertainty, including initiating attentional sampling and upregulating arousal and learning rates.

Many open questions remain regarding the mechanisms of instrumental-sampling policies. One important set of questions involves the role of cognitive effort. As we noted above, sampling policies depend on hierarchical, top-down mechanisms that maintain a memory of the task-relevant cues. Acquiring information is associated with belief updating and longer fixation duration [^52], and changing the attentional set entails cognitive effort [^64] [^65], potentially reducing performance in tasks that require high flexibility [^66] [^67]. Thus, a full understanding of sampling requires a better characterization of the neural mechanisms underlying cognitive effort and top-down attention control [^68] [^69] [^70]. A final consideration is that humans have imperfect metacognitive accuracy [^71] [^72], and the control of behaviour based on uncertainty develops slowly with age [^56], suggesting that behaviour based on decision uncertainty has important limitations.In closing, let us return to the point we made at the outset — that, in instrumental scenarios, a reduction in decision uncertainty is closely related with an increase in reward gains. Because of this correlation, most studies did not attempt to determine whether the two quantities can be dissociated. Strikingly, however, a recent in monkeys shows that the brain honours this dissociation. The study showed that LIP neurons encode the reliability of visual cues independently of the rewards expected from acting based on these cues [^52]. Specifically, these neurons differentiated between cues that provided decision-relevant information of different levels of reliability versus uninformative cues that had equivalent reward probability (Fig. [3c](https://www.nature.com/articles/s41583-018-0078-0#Fig3)). This finding suggests that the brain encodes the expected reduction in uncertainty independently of expected gains in reward, an important idea that is further supported by experiments on non-instrumental sampling and curiosity.

## Intrinsic motivation

Converging evidence shows that, in addition to gathering information to serve behavioural goals, animals are motivated to obtain information as a good in itself. Pure information preferences have been demonstrated in species as diverse as pigeons, humans and monkeys using so-called non-instrumental tasks, in which animals can observe predictive cues but cannot take actions based on these cues [^73] [^74] [^75] [^76] [^77].

In a task of this kind used in a neurophysiological study, monkeys had, in each trial, a 50:50 chance of receiving a large or small reward and, before receiving the outcome, could choose to inspect one of two cues that provided early reward information [^75]. Similar to an [instrumental context](https://www.nature.com/articles/s41583-018-0078-0#Glos2), the cues differed in their reliability, allowing the monkeys to form more-or-less accurate predictions regarding the outcome (Fig. [2b](https://www.nature.com/articles/s41583-018-0078-0#Fig2)). However, critically different from instrumental contexts, the monkeys could not take actions based on the information — that is, they had no instrumental incentive to observe a particular cue (compare Fig. [2a](https://www.nature.com/articles/s41583-018-0078-0#Fig2) and Fig. [2b](https://www.nature.com/articles/s41583-018-0078-0#Fig2)). Despite this lack of incentive, monkeys showed robust preferences for viewing informative (rather than uninformative) cues. Moreover, these preferences were encoded by neurons implicated in reward and motivation in the orbitofrontal cortex [^78] and midbrain dopamine cells [^75], supporting the view that animals assign intrinsic value to engaging with reliable cues.

Understanding the logic of such pure information demand poses major conundrums for decision theories. In the absence of instrumental incentives, what motivates an individual to know or observe certain items? Although our forays into this question are in their infancy, two main hypotheses have been advanced in the theoretical literature. These views propose, alternatively, that individuals have an intrinsic desire for the early resolution of uncertainty [^21] or that they are simply motivated to engage with positive items [^23] [^79] [^80].

These hypotheses predict substantially different sampling strategies. An individual who is intrinsically motivated to reduce uncertainty (independently of material gain) will attempt to maximize the accuracy of their beliefs, that is, to gather more precise information. By contrast, an individual who is intrinsically motivated to engage with positive cues will gather information in a biased fashion and may preferentially seek out pleasant but less accurate cues. Such a person may eagerly enquire about an upcoming vacation because this information makes them feel good, but they may avoid enquiring about a medical diagnosis because this produces dread and anxiety.

Emerging evidence suggests that reward-dependent attentional biases are pervasive in animals and humans and depend on dopaminergic mechanisms. One hypothesis, formalized in the context of reinforcement learning theory, is that dopamine neurons confer value to stimuli that allow animals to anticipate (savour) a positive outcome [^81]. According to this view, stimuli that signal an increase in reward trigger a dopamine prediction error response, which, in addition to promoting learning, assigns value to engaging with the predictor itself. If the predictor is separate from the instrumental goal, this can interfere with the appropriate actions. For instance, some rats exhibit so-called sign tracking behaviours, in which they orient themselves towards a light that predicts a reward rather than to the magazine that delivers the reward [^82]. Similarly, if monkeys view a reward-predictive cue at one visual location, they have difficulty making saccades to a separate location, and the neural correlates of these attentional biases are expressed in saccade-related activity in the superior colliculus and LIP area [^83] [^84] [^85]. These paradoxical effects of rewards reflect the fact that animals assign value to reward predictors above and beyond their valuation of the rewarded actions.

A second mechanism by which dopamine can produce attentional biases is by producing ‘reward-based salience’ — plasticity that confers visual salience independently of reward anticipation. This idea is supported by a large body of evidence showing that humans automatically orient to stimuli that have past reward associations even when the stimuli appear as irrelevant distractors (and presumably do not affect reward anticipation) [^86] [^87]. Moreover, monkeys proactively search for redundant reward cues (Fig. [4a](https://www.nature.com/articles/s41583-018-0078-0#Fig4)), suggesting that reward-based salience motivates not only reactive orienting but also information demand in the absence of predictive utility [^88]. Finally, studies in humans show that reward-based distraction is associated with activation of the substantia nigra–ventral tegmental areas and that the ability to suppress such distraction depends on frontal and parietal areas associated with cognitive control [^87] [^89] [^90].

![Fig. 4: Eye movements are impacted by non-instrumental search and curiosity.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs41583-018-0078-0/MediaObjects/41583_2018_78_Fig4_HTML.png?as=webp)

Fig. 4: Eye movements are impacted by non-instrumental search and curiosity.

In addition to inducing motivational conflict between task-irrelevant and task-relevant cues, reward-based attentional biases can impair the identification of informative items [^91]. In a particularly elegant demonstration, researchers trained human participants to search for targets in natural scenes such that different targets were associated with monetary gains or the evasion of loss [^92]. Although the targets had equal informativeness and operant value, object-selective cortical areas more faithfully encoded targets associated with gains rather than the evasion of loss, whereas the intraparietal sulcus had a less biased (strictly uncertainty-driven) target-related response. In a similar vein, the human N2pc response — a reliable electroencephalographic signature of spatial attention — was enhanced by reward probability independently of predictive value in a gambling task [^93].

Together, these results underscore the multifaceted effects of rewards on attention and show that rewards can bias attention in a potentially maladaptive fashion by conferring intrinsic value to sensory cues. Such attentional biases coexist with uncertainty reduction mechanisms, making it imperative to understand their neural substrates.

## Curiosity

The fact that animals and humans seek information even when it serves no obvious purpose seems closely related to curiosity, and studies of information seeking have set the stage for recent investigations of the neural mechanisms of curiosity [^78] [^94].

Curiosity, the intrinsic desire to know, has long been recognized as an important motive that influences human behaviour throughout the lifespan [^8] [^13] [^95]. Investigators as early as Berlyne proposed that curiosity is of several kinds, including perceptual curiosity (interest in specific stimuli), diversive curiosity (novelty or sensation seeking) and epistemic curiosity (interest in specific topics) [^13]. As we discuss below, recent work in artificial intelligence suggests that the term ‘curiosity’ also applies to sensorimotor actions, as expressed, for example, by a child intent on learning how to manipulate a toy [^17],[^96]. All these behaviours can be computationally characterized as the autonomously generated motivation to answer a question in the absence of instrumental incentives. The question may be about the state of the environment (“what is out there in the universe?”) or how the environment can be manipulated (“how can I make the toy light up and play tunes?”).

The finding that individuals assign utility to non-instrumental information provides an obvious starting point for laboratory investigations of curiosity [^1] [^2]. Recent experiments extended this approach to study epistemic curiosity, using tasks in which participants rate their interest in a trivia question, such as “how many tons of steel are in the Eiffel tower?” [^97] [^98] [^99] [^100]. An additional study examined perceptual curiosity by exposing people to ambiguous (blurry) images, which were followed, in a fraction of trials, by visual disambiguation [^101]. These investigations take us a step beyond the interest in material outcomes and raise the question of how people become interested in natural knowledge domains.

Extending the results from information-seeking tasks, these studies have linked curiosity with the widespread activation of systems of motivation, memory and attention. Higher curiosity ratings are associated with increased functional MRI activation in midbrain reward structures, including the caudate nucleus and the substantia nigra–ventral tegmental areas [^94] [^97] [^98] [^101], supporting the idea that information is intrinsically motivating. In addition, questions that evoke higher curiosity are associated with better memory for the answer and enhanced connectivity between the ventral tegmental area and the hippocampus [^97] [^98]. Finally, perceptual curiosity engages frontal and parietal areas implicated in attention and cognitive control [^101]. Participants with higher trait curiosity (assessed by personality questionnaires) engage in more widespread saccadic exploration of visual scenes [^102]; additionally, in trivia tasks, higher curiosity is associated with faster anticipatory shifts of gaze to the expected location of the answer (Fig. [4b](https://www.nature.com/articles/s41583-018-0078-0#Fig4)), and curiosity levels can be read out by machine learning algorithms using only gaze patterns [^99]. These nascent studies of curiosity may shed light on complex aspects of human behaviour such as aesthetic appreciation [^12] [^13]. The longstanding idea that aesthetic pleasure is evoked by stimuli with intermediate levels of predictability, novelty or complexity [^103] [^104] suggests a link between aesthetics and informational demands, which is becoming amenable to investigation on the basis of recent studies that probe novelty–familiarity preferences [^105] [^106] and the role of sensory complexity [^107]. Moreover, the surprising finding that approximately 5% of humans do not experience pleasure from music despite having normal music perception and normal responses to monetary rewards raises the additional possibility that, in addition to activating the general purpose motivational and reward systems, aesthetic appreciation depends on domain-specific rewards [^108].

Studies of epistemic curiosity, in turn, touch on the question of how humans develop lifelong interests and skills. The information gap theory suggests that curiosity arises when an individual encounters a question and generates a set of possible answers to it based on their previous knowledge, which in turn define a degree of uncertainty that a person may wish to resolve [^79]. Consistent with this proposed reliance on prior knowledge and memory, curiosity peaks if an individual has intermediate confidence that they know the answer to a question but declines if their confidence is too high or too low, indicating too little familiarity with the topic [^2] [^98] [^99]. The involvement of memory may be critically important for generating specific information search rather than a non-specific search for novelty (diversive curiosity). Particularly, it may allow individuals to systematically build on knowledge domains they have some familiarity with and thereby develop lifelong interests and skills [^15] [^19].

## Curiosity as a tool for discovery

In the previous sections, we described evidence that humans and other animals assign intrinsic value to knowledge and information, but we have yet to discuss what such intrinsic utility may be useful for. What advantage do organisms derive from systems of intrinsic motivation and curiosity? In this final section, we propose that to answer this question, we must look beyond the ‘small-world’ information-sampling scenarios we have considered thus far and consider instead the full scope of curiosity-driven information search, in which decision makers cope with very high complexity on extended timescales, as is the case during scientific research or long-term learning (developmental or educational) trajectories.

In the computational modelling literature, a common approach [^17] [^109] to describing information search is to propose that humans and other animals are intrinsically motivated to learn the hidden structure of their environment (or, in technical terms, a ‘world model’), on the basis of the default assumption that this knowledge is useful for solving new problems that were not previously known or suspected [^110] [^111]. This perspective underlies several recent theories of curiosity, including normative (for example, the free-energy principle [^109] [^112]) and heuristic (for example, the learning progress hypothesis [^17]) approaches. For instance, the free-energy principle proposes that learners select actions that optimize their beliefs — or equivalently, minimize surprise — over all possible states and hypotheses regarding the world [^109] [^112].

However, as noted by other investigators [^7] [^30], such a normative account does not take into account the complexity of the search process vis a vis the biological reality of limited capacity. To quote Bossaerts and Murawski, in normative theories, “a decision problem with two alternatives is not distinguished from one with 2 <sup>100</sup> alternatives”.[^7] As such, these theories are incompatible with the abundant evidence that humans, in even moderately complex laboratory paradigms (for example, requiring advance planning over several steps), produce inconsistent solutions [^113] and adopt frugal heuristics that rely only on a very limited set of the available cues [^30]. In the domain of artificial intelligence, it is likewise well appreciated that normative optimization schemes such as active Bayesian inference scale poorly with problem complexity [^114]; even non-parametric sampling-based models that reduce computational costs [^115] do not allow the systems to scale up to realistic problems of embodied control [^116].

In artificial intelligence, heuristic optimization mechanisms are the standard solution to computational complexity. Converging evidence shows that heuristics that assign intrinsic value to information gains can guide efficient information search and discovery (Box [1](https://www.nature.com/articles/s41583-018-0078-0#Sec8)). Robot-learning experiments that examined which heuristic mechanisms could scale to real-world, real-time learning in embodied agents fuelled the development of new theories of human epistemic curiosity, such as the learning progress hypothesis [^17] [^117].

As a concrete example, consider a study in which a humanoid robot interacts with a set of objects with hidden interdependencies — for instance, a cylindrical object that is too far away to be moved by hand but can be moved with a stick, which can itself be moved only by appropriate movements of the robot’s arm and hand gripper — as well as with objects that cannot be controlled (although the robot does not initially know what is learnable) [^118] (Fig. [5a](https://www.nature.com/articles/s41583-018-0078-0#Fig5)). In a classic reinforcement learning approach, the robot learns only if it receives an external reward (for example, if it can move the cylindrical object), which in this case would be exceedingly rare, producing learning that is prohibitively slow. By contrast, an algorithm [^116],[^117],[^118] based on intrinsic information rewards allows an agent to define its own goals, focusing on those where learning progress is possible in practice, and to remain motivated to learn to achieve these self-generated goals even when the material rewards are rare or unknown. This process leads the agent to discover a variety of effects that it can produce in the environment, acting as stepping stones for further discoveries, while avoiding spending too much time on goals that are either too easy or too difficult.

![Fig. 5: Artificial curiosity based on learning progress and autonomous goal sampling.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs41583-018-0078-0/MediaObjects/41583_2018_78_Fig5_HTML.png?as=webp)

Fig. 5: Artificial curiosity based on learning progress and autonomous goal sampling.

The learning progress models have been used to study these heuristics [^17],[^116],[^117], using a low-level learning module that incrementally learns a predictive world model as new observations are collected and a metacognitive module that uses unsupervised learning to build representations of discrete tasks, estimate the prediction errors that a robot has in a task and provide intrinsic rewards if it detects an improvement in predicting or controlling the task. In the previous robotic example, this architecture motivates the robot to start by moving its hands, self-generating goals to reach with the hand, which initially provides maximal learning progress. In so doing, the robot serendipitously discovers how to move the stick, which it then identifies as a new niche of learning progress and focus. In turn, owing to the physical couplings in the environment, the robot discovers how to move the cylindrical object when moving the stick, creating a new niche of progress. Meanwhile, the robot learns to avoid interacting with distractor objects, from which little can be learned. Motivated by its own learning progress, the robot thus generates autonomous goals and progressively discovers new skills, and importantly, it does so without requiring advance knowledge of the environmental structure or the external rewards [^17],[^117],[^118].

The efficiency of these intrinsically motivated architectures has provided support to the learning progress hypothesis [^17] and raises the question of whether biological organisms might implement similar mechanisms. Although this remains an open question for future research, it is noteworthy that the predictions of learning progress models are consistent with psychological observations, in particular accounting for major phase transitions in infant development of vocalizations and tool use [^119] [^120], and that software providing learning-progress-based personalized sequences of exercises improves childrens’ learning in educational settings [^121].

A particularly important parallel is the fact that, consistent with behaviours reported in children and adults [^2] [^16] [^122], a learning progress architecture generates a self-organized exploration curriculum that progresses from easier to more difficult tasks and favours tasks of intermediate difficulty [^123] [^124] (Fig. [5b](https://www.nature.com/articles/s41583-018-0078-0#Fig5)). Direct laboratory evidence supporting this view comes from a task in which adult humans freely interacted with a set of games of varying difficulty [^125]. Despite the fact that the participants received no specific instructions, they spontaneously organized their exploration in increasing order of difficulty and, after surveying the entire set of available tasks, settled on intermediate games in which their performance was 70–80% correct for the bulk of the session and gradually progressed to games of higher difficulty, consistent with the predictions of a learning progress mechanism [^125] (Fig. [6](https://www.nature.com/articles/s41583-018-0078-0#Fig6)). Continued development of strategic student tasks of this kind, in which participants freely explore a set of learning problems of varying difficulty, will help test the biological plausibility of the learning-progress-based process and clarify the behavioural and neural mechanisms by which the brain autonomously organizes information search and generates useful discoveries.

![Fig. 6: Self-organized play in a laboratory game.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fs41583-018-0078-0/MediaObjects/41583_2018_78_Fig6_HTML.png?as=webp)

Fig. 6: Self-organized play in a laboratory game.

## Conclusions

We reviewed emerging neuroscientific evidence of the mechanisms generating information demand. We emphasized the fact that, although animals can often learn sophisticated goal-directed sampling policies, they also have intrinsic information preferences that are independent of instrumental demands, and they endogenously bias their attention and learning towards specific types of information and specific levels of challenge or accuracy.

We also proposed that these intrinsic drives are double-edged swords. On the one hand, in instrumental settings, intrinsic preferences may generate sampling biases and suboptimal learning strategies [^44]. On the other hand, in novel or exploratory contexts, they may represent critically important heuristics for generating intermediate goals, organizing curiosity-driven investigations and making discoveries that would otherwise require implausibly complex optimization strategies.

The scant neuroscientific evidence available to date suggests that intrinsic information preferences depend on systems of reward and motivation and interact antagonistically or synergistically with systems of cognitive control that generate goal-directed sampling policies. Although our understanding of these mechanisms is in its infancy, their continued investigation promises to shed light on important topics that fall at the intersection of traditional studies on cognition and decision-making, including aesthetic preferences, active learning and intrinsic motivation, preferences for self-challenge and the engagement of control, which have thus far remained poorly explored.

## References

## Acknowledgements

The authors acknowledge support from the Human Frontiers Science Program (Collaborative Research Grant RGP0018/2016 to J.G. and P.-Y.O.), an Inria Neurocuriosity grant (to J.G. and P.-Y.O.), the National Eye Institute (RO1 grant to J.G.) and the National Institute of Mental Health (RO1 grant to J.G.).

### Reviewer information

*Nature Reviews Neuroscience* thanks V. Stuphorn and the other anonymous reviewers for their contribution to the peer review of this work.

## Ethics declarations

### Competing interests

The authors declare no competing interests.

## Additional information

### Publisher’s note

Springer Nature remains neutral with regard to jurisdictional claims in published maps and institutional affiliations.

## Glossary

Agents

Any entities that are capable of learning and decision-making, including humans, other animals and artificial intelligence applications such as robots and self-driving cars.

Instrumental context

A context in which agents are motivated by the desire to obtain a known goal, which is operationalized in the laboratory as maximizing a material reward (such as money, points, food or safety).

## Rights and permissions

[^1]: Gottlieb, J., Oudeyer, P. Y., Lopes, M. & Baranes, A. Information seeking, curiosity and attention: computational and empirical mechanisms. *Trends Cogn. Sci.* **17**, 585–593 (2013).

[Google Scholar](http://scholar.google.com/scholar_lookup?&title=Information%20seeking%2C%20curiosity%20and%20attention%3A%20computational%20and%20empirical%20mechanisms&journal=Trends%20Cognitive%20Sci.&volume=17&pages=585-593&publication_year=2013&author=Gottlieb%2CJ&author=Oudeyer%2CPY&author=Lopes%2CM&author=Baranes%2CA)

[^2]: Kidd, C. & Hayden, B. Y. The psychology and neuroscience of curiosity. *Neuron* **88**, 449–460 (2015).

[CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2MXhslyrtrrI) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=26539887) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4635443) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20psychology%20and%20neuroscience%20of%20curiosity&journal=Neuron&volume=88&pages=449-460&publication_year=2015&author=Kidd%2CC&author=Hayden%2CBY)

[^3]: Gottlieb, J., Hayhoe, M., Hikosaka, O. & Rangel, A. Attention, reward and information seeking. *J. Neurosci.* **34**, 15497–154504 (2014).

[CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2MXlslalsg%3D%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=25392517) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4228145) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Attention%2C%20reward%20and%20information%20seeking&journal=J.%20Neurosci.&volume=34&pages=15497-154504&publication_year=2014&author=Gottlieb%2CJ&author=Hayhoe%2CM&author=Hikosaka%2CO&author=Rangel%2CA)

[^4]: Rehder, B. & Hoffman, A. B. Eye tracking and selective attention in category learning. *Cogn. Psychol.* **51**, 1–41 (2005).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=16039934) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Eye%20tracking%20and%20selective%20attention%20in%20category%20learning&journal=Cogn.%20Psychol.&volume=51&pages=1-41&publication_year=2005&author=Rehder%2CB&author=Hoffman%2CAB)

[^5]: Nelson, J. Finding useful questions: on Bayesian diagnosticity, probability, impact and information gain. *Psychol. Rev.* **112**, 979–999 (2005).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=16262476) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Finding%20useful%20questions%3A%20on%20Bayesian%20diagnosticity%2C%20probability%2C%20impact%20and%20information%20gain&journal=Psychol.%20Rev.&volume=112&pages=979-999&publication_year=2005&author=Nelson%2CJ)

[^6]: Coenen, A., Nelson, J. & Gureckis, T. Asking the right questions about the psychology of human inquiry: nine open challenges. *Psychon Bull. Rev.* [https://doi.org/10.3758/s13423-018-1470-5](https://doi.org/10.3758/s13423-018-1470-5) (2018).

[Article](https://doi.org/10.3758%2Fs13423-018-1470-5) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=29869025) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Asking%20the%20right%20questions%20about%20the%20psychology%20of%20human%20inquiry%3A%20nine%20open%20challenges&journal=Psychon%20Bull.%20Rev.&doi=10.3758%2Fs13423-018-1470-5&publication_year=2018&author=Coenen%2CA&author=Nelson%2CJ&author=Gureckis%2CT)

[^7]: Bossaerts, P. & Murawski, C. Computational complexity and human decision-making. *Trends Cogn. Sci.* **21**, 917–929 (2017).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=29149998) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Computational%20complexity%20and%20human%20decision-making&journal=Trends%20Cogn.%20Sci.&volume=21&pages=917-929&publication_year=2017&author=Bossaerts%2CP&author=Murawski%2CC)

[^8]: Loewenstein, G. & Molnar, A. The renaissance of belief-based utility in economics. *Nat. Hum. Behav.* **2**, 166–167 (2018).

[Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20renaissance%20of%20belief-based%20utility%20in%20economics&journal=Nature%20Hum.%20Behav.&volume=2&pages=166-167&publication_year=2018&author=Loewenstein%2CG&author=Molnar%2CA)

[^9]: Chater, N. & Loewenstein, G. The under-appreciated drive for sense-making. *J. Econ. Behav. Organiz.* **126**, 137–154 (2016).

[Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20under-appreciated%20drive%20for%20sense-making&journal=J.%20Econom.%20Behav.%20Organiz.&volume=126&pages=137-154&publication_year=2016&author=Chater%2CN&author=Loewenstein%2CG)

[^10]: Wu, C. M., Meder, B., Filimon, F. & Nelson, J. D. Asking better questions: how presentation formats influence information search. *J. Exp. Psychol. Learn. Mem. Cogn* **43**, 1274–1297 (2017).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=28318286) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Asking%20better%20questions%3A%20how%20presentation%20formats%20influence%20information%20search&journal=J.%20Exp.%20Psychol%20Learn.%20Mem.%20Cogn.&volume=43&pages=1274-1297&publication_year=2017&author=Wu%2CCM&author=Meder%2CB&author=Filimon%2CF&author=Nelson%2CJD)

[^11]: Markant, D. B. & Gureckis, T. M. Is it better to select or to receive? Learning via active and passive hypothesis testing. *J. Exp. Psychol. Gen.* **143**, 94–122 (2014).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=23527948) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Is%20it%20better%20to%20select%20or%20to%20receive%3F%20Learning%20via%20active%20and%20passive%20hypothesis%20testing&journal=J.%20Exp.%20Psychol.%20Gen.&volume=143&pages=94-122&publication_year=2014&author=Markant%2CDB&author=Gureckis%2CTM)

[^12]: Berlyne, D. *Conflict, Arousal and Curiosity* (McGraw-Hill, 1960).

[^13]: Berlyne, D. E. A theory of human curiosity. *Br. J. Psychol.* **45**, 180–191 (1954).

[CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaG2M%2FgtFOmsg%3D%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=A%20theory%20of%20human%20curiosity&journal=Br.%20J.%20Psychol.%2C%20General%20Section&volume=45&pages=180-191&publication_year=1954&author=Berlyne%2CDE)

[^14]: Litman, J. A. in *Issues in the Psychology of Motivation* (ed. Zelick, P. R.) (Nova Science Publishers, 2007).

[^15]: Silvia, P. J. *Exploring the Psychology of Interest* (Oxford Univ. Press, 2006).

[^16]: Di Domenico, S. I. & Ryan, R. M. The emerging neuroscience of intrinsic motivation: a new frontier in self-determination research. *Front. Hum. Neurosci.* [https://doi.org/10.3389/fnhum.2017.00145](https://doi.org/10.3389/fnhum.2017.00145) (2017).

[Article](https://doi.org/10.3389%2Ffnhum.2017.00145) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=28392765) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC5364176) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20emerging%20neuroscience%20of%20intrinsic%20motivation%3A%20a%20new%20frontier%20in%20self-determination%20research&journal=Front.%20Hum.%20Neurosci.&doi=10.3389%2Ffnhum.2017.00145&publication_year=2017&author=Domenico%2CSI&author=Ryan%2CRM)

[^17]: Kaplan, F. & Oudeyer, P.-Y. In search of the neural circuits of intrinsic motivation. *Frontiers Neurosci.* **1**, 225–225 (2007). **This is a clear and succinct review of the concepts and computational models of intrinsic motivation and their importance to artificial intelligence**

[Google Scholar](http://scholar.google.com/scholar_lookup?&title=In%20search%20of%20the%20neural%20circuits%20of%20intrinsic%20motivation&journal=Frontiers%20Neurosci.&volume=1&pages=225-225&publication_year=2007&author=Kaplan%2CF&author=Oudeyer%2CP-Y)

[^18]: Gopnik, A. Scientific thinking in young children: theoretical advances, empirical research, and policy implications. *Science* **337**, 1623–1627 (2012).

[CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC38Xhtl2ntrjI) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=23019643) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Scientific%20thinking%20in%20young%20children%3A%20theoretical%20advances%2C%20empirical%20research%2C%20and%20policy%20implications&journal=Science&volume=337&pages=1623-1627&publication_year=2012&author=Gopnik%2CA)

[^19]: Renninger, K. A. & Hidi, S. E. *The Power of Interest for Motivation and Engagement* (Routledge, NY, 2016).

[Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20Power%20of%20Interest%20for%20Motivation%20and%20Engagement&publication_year=2015&author=Renninger%2CK%20Ann)

[^20]: Begus, K., Gliga, T. & Southgate, V. Infants’ preferences for native speakers are associated with an expectation of information. *Proc. Natl Acad. Sci. USA* **113**, 12397–12402 (2016).

[CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC28Xhs1ykurjJ) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=27791064) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Infants%E2%80%99%20preferences%20for%20native%20speakers%20are%20associated%20with%20an%20expectation%20of%20information&journal=Proc.%20Natl%20Acad.%20Sci.%20USA&volume=113&pages=12397-12402&publication_year=2016&author=Begus%2CK&author=Gliga%2CT&author=Southgate%2CV)

[^21]: Kreps, D. M. & Porteus, E. L. Temporal resolution of uncertainty and dynamic choice theory. *Econometrica* **46**, 185–200 (1978).

[Google Scholar](http://scholar.google.com/scholar_lookup?&title=Temporal%20resolution%20of%20uncertainty%20and%20dynamic%20choice%20theory&journal=Econometrica&volume=46&pages=185-200&publication_year=1978&author=Kreps%2CDM&author=Porteus%2CEL)

[^22]: Caplin, A. & Dean, M. Revealed preference, rational inattention and costly information acquisition. *Am. Econ. Rev.* **105**, 2183–2203 (2015).

[Google Scholar](http://scholar.google.com/scholar_lookup?&title=Revealed%20preference%2C%20rational%20inattention%20and%20costly%20information%20acquisition&journal=Am.%20Econom.%20Rev.&volume=105&pages=2183-2203&publication_year=2015&author=Caplin%2CA&author=Dean%2CM)

[^23]: Caplin, A. & Leahy, J. Psychological expected utility theory and anticipatory feelings. *Q. J. Econ.* **116**, 55–79 (2001).

[Google Scholar](http://scholar.google.com/scholar_lookup?&title=Psychological%20expected%20utility%20theory%20and%20anticipatory%20feelings&journal=Q.%20J.%20Econ&volume=116&pages=55-79&publication_year=2001&author=Caplin%2CA&author=Leahy%2CJ)

[^24]: Clark, A. *Surfing Uncertainty: Prediction, Action and the Embodied Mind*. (Oxford Univ. Press, 2015).

[^25]: Livio, M. *Why? What Makes Us Curious?*. (Simon and Schuster, 2017).

[^26]: Hayhoe, M. & Ballard, D. Modeling task control of eye movements. *Curr. Biol.* **24**, 622–628 (2014). **This paper provides an excellent overview of empirical and modelling studies of eye movement control in natural tasks**

[Google Scholar](http://scholar.google.com/scholar_lookup?&title=Modeling%20task%20control%20of%20eye%20movements&journal=Curr.%20Biol.&volume=24&pages=622-628&publication_year=2014&author=Hayhoe%2CM&author=Ballard%2CD)

[^27]: Tatler, B. W., Hayhoe, M. N., Land, M. F. & Ballard, D. H. Eye guidance in natural vision: reinterpreting salience. *J. Vis.* **11**, 5–25 (2011).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=21622729) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3134223) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Eye%20guidance%20in%20natural%20vision%3A%20reinterpreting%20salience&journal=J.%20Vis.&volume=11&pages=5-25&publication_year=2011&author=Tatler%2CBW&author=Hayhoe%2CMN&author=Land%2CMF&author=Ballard%2CDH)

[^28]: Bach, D. R. & Dolan, R. J. Knowing how much you don’t know: a neural organization of uncertainty estimates. *Nat. Rev. Neurosci.* **13**, 572–586 (2012).

[CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC38XpvFCrtL8%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=22781958) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Knowing%20how%20much%20you%20don%E2%80%99t%20know%3A%20a%20neural%20organization%20of%20uncertainty%20estimates&journal=Nat.%20Rev.%20Neurosci.&volume=13&pages=572-586&publication_year=2012&author=Bach%2CDR&author=Dolan%2CRJ)

[^29]: Cohen, J. D., McClure, S. M. & Yu, A. J. Should I stay or should I go? How the human brain manages the trade-off between exploitation and exploration. *Phil. Trans. R. Soc. B* **362**, 933–942 (2007).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=17395573) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Should%20i%20stay%20or%20should%20i%20go%3F%20How%20the%20human%20brain%20manages%20the%20trade-off%20between%20exploitation%20and%20exploration&journal=Phil.%20Trans.%20R.%20Soc.%20B&volume=362&pages=933-942&publication_year=2007&author=Cohen%2CJD&author=McClure%2CSM&author=Yu%2CAJ)

[^30]: Todd, P. M. & Gigerenzer, G. Précis of simple heuristics that make us smart. *Behav. Brain Sci.* **23**, 727–780 (2000).

[CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DC%2BD3MzjslCrtA%3D%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=11301545) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Pr%C3%A9cis%20of%20simple%20heuristics%20that%20make%20us%20smart&journal=Behav.%20Brain%20Sci.&volume=23&pages=727-780&publication_year=2000&author=Todd%2CPM&author=Gigerenzer%2CG)

[^31]: Reynolds, J. H. & Heeger, D. J. The normalization model of attention. *Neuron* **61**, 168–185 (2009).

[CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD1MXitVamurk%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=19186161) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC2752446) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20normalization%20model%20of%20attention&journal=Neuron&volume=61&pages=168-185&publication_year=2009&author=Reynolds%2CJH&author=Heeger%2CDJ)

[^32]: Thompson, K. G. & Bichot, N. P. A visual salience map in the primate frontal eye field. *Prog. Brain Res.* **147**, 251–262 (2005).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=15581711) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=A%20visual%20salience%20map%20in%20the%20primate%20frontal%20eye%20field&journal=Prog.%20Brain%20Res.&volume=147&pages=251-262&publication_year=2005&author=Thompson%2CKG&author=Bichot%2CNP)

[^33]: Bisley, J. W. & Goldberg, M. E. Attention, intention, and priority in the parietal lobe. *Annu. Rev. Neurosci.* **33**, 1–21 (2010).

[CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC3cXhsFartr%2FE) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=20192813) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3683564) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Attention%2C%20intention%2C%20and%20priority%20in%20the%20parietal%20lobe&journal=Annu.%20Rev.%20Neurosci.&volume=33&pages=1-21&publication_year=2010&author=Bisley%2CJW&author=Goldberg%2CME)

[^34]: Hanks, T. D. & Summerfield, C. Perceptual decision making in rodents, monkeys, and humans. *Neuron* **93**, 15–31 (2017).

[CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2sXlt12mtA%3D%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=28056343) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Perceptual%20decision%20making%20in%20rodents%2C%20monkeys%2C%20and%20humans&journal=Neuron&volume=93&pages=15-31&publication_year=2017&author=Hanks%2CTD&author=Summerfield%2CC)

[^35]: Kable, J. W. & Glimcher, P. W. The neurobiology of decision: consensus and controversy. *Neuron* **63**, 733–745 (2009).

[CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD1MXhsVCjsrnJ) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=19778504) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC2765926) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20neurobiology%20of%20decision%3A%20consensus%20and%20controversy&journal=Neuron&volume=63&pages=733-745&publication_year=2009&author=Kable%2CJW&author=Glimcher%2CPW)

[^36]: Lee, D., Seo, H. & Jung, M. W. Neural basis of reinforcement learning and decision making. *Annu. Rev. Neurosci.* **35**, 287–308 (2012).

[CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC38XhtFegsbvL) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=22462543) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3490621) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Neural%20basis%20of%20reinforcement%20learning%20and%20decision%20making&journal=Annu.%20Rev.%20Neurosci.&volume=35&pages=287-308&publication_year=2012&author=Lee%2CD&author=Seo%2CH&author=Jung%2CMW)

[^37]: Krajbich, I., Armel, C. & Rangel, A. Visual fixations and the computation and comparison of value in simple choice. *Nat. Neurosci.* **13**, 1292–1298 (2010).

[CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC3cXhtFCnsb3M) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=20835253) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Visual%20fixations%20and%20the%20computation%20and%20comparison%20of%20value%20in%20simple%20choice&journal=Nat.%20Neurosci.&volume=13&pages=1292-1298&publication_year=2010&author=Krajbich%2CI&author=Armel%2CC&author=Rangel%2CA)

[^38]: Krajbich, I., Lu, D., Camerer, C. & Rangel, A. The attentional drift-diffusion model extends to simple purchasing decisions. *Front. Psychol.* **3**, 193 (2012).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=22707945) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3374478) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20attentional%20drift-diffusion%20model%20extends%20to%20simple%20purchasing%20decisions&journal=Front.%20Psychol.&volume=3&publication_year=2012&author=Krajbich%2CI&author=Lu%2CD&author=Camerer%2CC&author=Rangel%2CA)

[^39]: Gottlieb, J. Attention, learning, and the value of information. *Neuron* **76**, 281–295 (2012).

[CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC38XhsFCksLjO) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=23083732) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3479649) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Attention%2C%20learning%2C%20and%20the%20value%20of%20information&journal=Neuron&volume=76&pages=281-295&publication_year=2012&author=Gottlieb%2CJ)

[^40]: Gottlieb, J. Understanding active sampling strategies: empirical approaches and implications for attention and decision reseeaerch. *Cortex* **102**, 150–160 (2018). **This is an overview of empirical approaches to information sampling in neurophysiology**

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=28919222) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Understanding%20active%20sampling%20strategies%3A%20empirical%20approaches%20and%20implications%20for%20attention%20and%20decision%20reseeaerch&journal=Cortex&volume=102&pages=150-160&publication_year=2018&author=Gottlieb%2CJ)

[^41]: Johnson, L., Sullivan, B., Hayhoe, M. & Ballard, D. H. Predicting human visuomotor behavior in a driving task. *Phil. Trans. R. Soc. B.* **369**, 20130044 (2014).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=24395971) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Predicting%20human%20visuomotor%20behavior%20in%20a%20driving%20task&journal=Phil.%20Trans.%20R.%20Soc.%20B.&volume=369&publication_year=2014&author=Johnson%2CL&author=Sullivan%2CB&author=Hayhoe%2CM&author=Ballard%2CDH)

[^42]: Sullivan, B. T., Johnson, L., Rothkopf, C. A., Ballard, D. & Hayhoe, M. The role of uncertainty and reward on eye movements in a virtual driving task. *J. Vis.* **12**, 19 (2012).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=23262151) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3587015) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20role%20of%20uncertainty%20and%20reward%20on%20eye%20movements%20in%20a%20virtual%20driving%20task&journal=J.%20Vis.&volume=12&publication_year=2012&author=Sullivan%2CBT&author=Johnson%2CL&author=Rothkopf%2CCA&author=Ballard%2CD&author=Hayhoe%2CM)

[^43]: Leong, Y., Radulescu, A., Daniel, R., DeWoskin, V. & Niv, Y. Dynamic interaction between reinforcement learning and attention in multidimensional environments. *Neuron* **93**, 451–463 (2017).

[CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2sXht12kur4%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=28103483) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC5287409) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Dynamic%20interaction%20between%20reinforcement%20learning%20and%20attention%20in%20multidimensional%20environments&journal=Neuron&volume=93&pages=451-463&publication_year=2017&author=Leong%2CY&author=Radulescu%2CA&author=Daniel%2CR&author=DeWoskin%2CV&author=Niv%2CY)

[^44]: Wilson, R. C. & Niv, Y. Inferring relevance in a changing world. *Front. Hum. Neurosci.* **5**, 189 (2011).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=22291631) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Inferring%20relevance%20in%20a%20changing%20world&journal=Front.%20Hum.%20Neurosci.&volume=5&publication_year=2011&author=Wilson%2CRC&author=Niv%2CY)

[^45]: Najemnik, J. & Geisler, W. S. Eye movement statistics in humans are consistent with an optimal search strategy. *J. Vis* **8**, 4 (2008).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=18484810) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC2868380) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Eye%20movement%20statistics%20in%20humans%20are%20consistent%20with%20an%20optimal%20search%20strategy&journal=J.%20Vis&volume=8&publication_year=2008&author=Najemnik%2CJ&author=Geisler%2CWS)

[^46]: Yang, S. C., Lengyel, M. & Wolpert, D. M. Active sensing in the categorization of visual patterns. *eLife* **5**, e12215 (2016). **This paper provides evidence for information-based eye movement strategies using behavioural analysis and Bayesian modelling in humans**

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=26880546) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4764587) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Active%20sensing%20in%20the%20categorization%20of%20visual%20patterns&journal=eLife&volume=5&publication_year=2016&author=Yang%2CSC&author=Lengyel%2CM&author=Wolpert%2CDM)

[^47]: Najemnik, J. & Geisler, W. S. Optimal eye movement strategies in visual search. *Nature* **434**, 387–391 (2005).

[CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD2MXit1yqsr8%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=15772663) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Optimal%20eye%20movement%20strategies%20in%20visual%20search&journal=Nature&volume=434&pages=387-391&publication_year=2005&author=Najemnik%2CJ&author=Geisler%2CWS)

[^48]: Renninger, L. W., Verghese, P. & Coughlan, J. Where to look next? Eye movements reduce local uncertainty. *J. Vis* **7**, 6 (2007).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=17461684) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Where%20to%20look%20next%3F%20Eye%20movements%20reduce%20local%20uncertainty&journal=J.%20Vis&volume=7&publication_year=2007&author=Renninger%2CLW&author=Verghese%2CP&author=Coughlan%2CJ)

[^49]: Vossel, S., Vossel, S., Mathys, C., Stephan, K. E. & Friston, K. J. Cortical coupling reflects bayesian belief updating in the deployment of spatial attention. *J. Neurosci.* **35**, 11532–11542 (2015). **This is an analysis of attention in a Bayesian framework using functional MRI in humans**

[CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2MXhsVylsrjO) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=26290231) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4540794) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Cortical%20coupling%20reflects%20bayesian%20belief%20updating%20in%20the%20deployment%20of%20spatial%20attention&journal=J.%20Neurosci.&volume=35&pages=11532-11542&publication_year=2015&author=Vossel%2CS&author=Vossel%2CS&author=Mathys%2CC&author=Stephan%2CKE&author=Friston%2CKJ)

[^50]: Vossel, S. et al. Spatial attention, precision, and bayesian inference: a study of saccadic response speed. *Cereb. Cortex* **24**, 1436–1450 (2014).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=23322402) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Spatial%20attention%2C%20precision%2C%20and%20bayesian%20inference%3A%20a%20study%20of%20saccadic%20response%20speed&journal=Cerebral%20Cortex&volume=24&pages=1436-1450&publication_year=2014&author=Vossel%2CS)

[^51]: Vossel, S., Thiel, C. M. & Fink, G. R. Cue validity modulates the neural correlates of covert endogenous orienting of attention in parietal and frontal cortex. *NeuroImage* **32**, 1257–1264 (2006).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=16846742) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Cue%20validity%20modulates%20the%20neural%20correlates%20of%20covert%20endogenous%20orienting%20of%20attention%20in%20parietal%20and%20frontal%20cortex&journal=NeuroImage&volume=32&pages=1257-1264&publication_year=2006&author=Vossel%2CS&author=Thiel%2CCM&author=Fink%2CGR)

[^52]: Foley, N. C., Kelley, S. P., Mhatre, H., Lopes, M. & Gottlieb, J. Parietal neurons encode expected gains in instrumental information. *Proc. Natl Acad. Sci.* **114**, E3315–E3323 (2017). **This paper demonstrates that oculomotor neurons encode expected information gains in monkeys**

[CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2sXlsV2ns7k%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=28373569) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Parietal%20neurons%20encode%20expected%20gains%20in%20instrumental%20information&journal=Proc.%20Natl%20Acad.%20Sci.&volume=114&pages=E3315-E3323&publication_year=2017&author=Foley%2CNC&author=Kelley%2CSP&author=Mhatre%2CH&author=Lopes%2CM&author=Gottlieb%2CJ)

[^53]: Ernst, M. O. & Banks, M. S. Humans integrate visual and haptic information in a statistically optimal fashion. *Nature* **415**, 429–433 (2002).

[CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD38XhtVCntrY%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=11807554) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Humans%20integrate%20visual%20and%20haptic%20information%20in%20a%20statistically%20optimal%20fashion&journal=Nature&volume=415&pages=429-433&publication_year=2002&author=Ernst%2CMO&author=Banks%2CMS)

[^54]: Nelson, J., McKenzie, C., Cottrell, G. & Sejnowski, T. Experience matters: information acquisition optimizes probability gain. *Psychol. Sci.* **21**, 960–969 (2010).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=20525915) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC2926803) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Experience%20matters%3A%20information%20acquisition%20optimizes%20probability%20gain&journal=Psychol.%20Sci.&volume=21&pages=960-969&publication_year=2010&author=Nelson%2CJ&author=McKenzie%2CC&author=Cottrell%2CG&author=Sejnowski%2CT)

[^55]: Zajkowski, W. K., Kossut, M. & Wilson, R. C. A causal role for right frontopolar cortex in directed, but not random, exploration. *eLife* **6**, e27430 (2017).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=28914605) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC5628017) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=A%20causal%20role%20for%20right%20frontopolar%20cortex%20in%20directed%2C%20but%20not%20random%2C%20exploration&journal=eLife&volume=6&publication_year=2017&author=Zajkowski%2CWK&author=Kossut%2CM&author=Wilson%2CRC)

[^56]: Somerville, L. H. et al. Charting the expansion of strategic exploratory behavior during adolescence. *J. Exp. Psychol. Gen.* **146**, 155–164 (2017).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=27977227) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Charting%20the%20expansion%20of%20strategic%20exploratory%20behavior%20during%20adolescence&journal=J.%20Exp.%20Psychol.%20Gen.&volume=146&pages=155-164&publication_year=2017&author=Somerville%2CLH)

[^57]: Manohar, S. G. & Husain, M. Attention as foraging for information and value. *Front. Hum. Neurosci.* **7**, 711 (2013).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=24204335) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3817627) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Attention%20as%20foraging%20for%20information%20and%20value&journal=Front.%20Hum.%20Neurosci.&volume=7&publication_year=2013&author=Manohar%2CSG&author=Husain%2CM)

[^58]: Krishnamurthy, K., Nassar, M. R., Sarode, S. & Gold, J. I. Arousal-related adjustments of perceptual biases optimize perception in dynamic environments. *Nat. Hum. Behav.* **1**, 0107 (2017).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=29034334) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC5638136) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Arousal-related%20adjustments%20of%20perceptual%20biases%20optimize%20perception%20in%20dynamic%20environments&journal=Nat.%20Hum.%20Behav.&volume=1&publication_year=2017&author=Krishnamurthy%2CK&author=Nassar%2CMR&author=Sarode%2CS&author=Gold%2CJI)

[^59]: Li, V., Herce Castañón, S., Solomon, J. A., Vandormael, H. & Summerfield, C. Robust averaging protects decisions from noise in neural computations. *PLOS Comput. Biol.* **13**, e1005723 (2017).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=28841644) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC5589265) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Robust%20averaging%20protects%20decisions%20from%20noise%20in%20neural%20computations&journal=PLOS%20Comput.%20Biol.&volume=13&publication_year=2017&author=Li%2CV&author=Herce%20Casta%C3%B1%C3%B3n%2CS&author=Solomon%2CJA&author=Vandormael%2CH&author=Summerfield%2CC)

[^60]: Spitzer, B., Waschke, L. & Summerfield, C. Selective overwiehgting of larger magnitudes during noisy numerical comparison. *Nat. Hum. Behav.* **1**, 0145 (2017).

[Google Scholar](http://scholar.google.com/scholar_lookup?&title=Selective%20overwiehgting%20of%20larger%20magnitudes%20during%20noisy%20numerical%20comparison&journal=Nat.%20Hum.%20Behav.&volume=1&publication_year=2017&author=Spitzer%2CB&author=Waschke%2CL&author=Summerfield%2CC)

[^61]: Gold, J. I. & Stocker, A. A. Visual decision-making in an uncertain and dynamic world. *Annu. Rev. Vis. Sci.* **3**, 227–250 (2017).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=28715956) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Visual%20decision-making%20in%20an%20uncertain%20and%20dynamic%20world&journal=Annu.%20Rev.%20Vis.%20Sci.&volume=3&pages=227-250&publication_year=2017&author=Gold%2CJI&author=Stocker%2CAA)

[^62]: Ebitz, R. B., Albarran, E. & Moore, T. Exploration disrupts choice-predictive signals and alters dynamics in prefrontal cortex. *Neuron* **97**, 450–461 (2018).

[CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC1cXit1OnsA%3D%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=29290550) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Exploration%20disrupts%20choice-predictive%20signals%20and%20alters%20dynamics%20in%20prefrontal%20cortex&journal=Neuron&volume=97&pages=450-461&publication_year=2018&author=Ebitz%2CRB&author=Albarran%2CE&author=Moore%2CT)

[^63]: Gersch, T. M., Foley, N. C., Eisenberg, I. & Gottlieb, J. Neural correlates of temporal credit assignment in the parietal lobe. *PLOS ONE* **9**, e88725 (2014).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=24523935) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3921206) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Neural%20correlates%20of%20temporal%20credit%20assignment%20in%20the%20parietal%20lobe&journal=PLOS%20ONE&volume=9&publication_year=2014&author=Gersch%2CTM&author=Foley%2CNC&author=Eisenberg%2CI&author=Gottlieb%2CJ)

[^64]: Rossi, A. F., Pessoa, L., Desimone, R. & Ungerleider, L. G. The prefrontal cortex and the executive control of attention. *Exp. Brain Res.* **192**, 489–497 (2009).

[Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20prefrontal%20cortex%20and%20the%20executive%20control%20of%20attention&journal=Exp.%20Brain%20Res.&volume=192&pages=489-497&publication_year=2009&author=Rossi%2CAF&author=Pessoa%2CL&author=Desimone%2CR&author=Ungerleider%2CLG)

[^65]: Rossi, A. F., Bichot, N. P., Desimone, R. & Ungerleider, L. G. Top down attentional deficits in macaques with lesions of lateral prefrontal cortex. *J. Neurosci.* **27**, 11306–11314 (2007).

[CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD2sXht1ekurrN) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=17942725) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Top%20down%20attentional%20deficits%20in%20macaques%20with%20lesions%20of%20lateral%20prefrontal%20cortex&journal=J.%20Neurosci.&volume=27&pages=11306-11314&publication_year=2007&author=Rossi%2CAF&author=Bichot%2CNP&author=Desimone%2CR&author=Ungerleider%2CLG)

[^66]: Morvan, C. & Maloney, L. Human visual search does not maximize the post-saccadic probability of identifying targets. *PLOS Comput. Biol.* **8**, e1002342 (2012). **This presents an intriguing demonstration that humans show suboptimal sampling strategies in a task requiring flexible adjustments based on estimates of visibility**

[CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC38XisFeqsrg%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=22319428) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3271024) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Human%20visual%20search%20does%20not%20maximize%20the%20post-saccadic%20probability%20of%20identifying%20targets&journal=PLOS%20Comput.%20Biol.&volume=8&publication_year=2012&author=Morvan%2CC&author=Maloney%2CL)

[^67]: Ghahghaei, S. & Verghese, P. Efficient saccade planning requires time and clear choices. *Vision Res.* **113B**, 125–136 (2015).

[Google Scholar](http://scholar.google.com/scholar_lookup?&title=Efficient%20saccade%20planning%20requires%20time%20and%20clear%20choices&journal=Vision%20Res.&volume=113B&pages=125-136&publication_year=2015&author=Ghahghaei%2CS&author=Verghese%2CP)

[^68]: Chong, T. T. et al. Neurocomputational mechanisms underlying subjective valuation of effort costs. *PLOS Biol.* **15**, e1002598 (2017).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=28234892) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC5325181) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Neurocomputational%20mechanisms%20underlying%20subjective%20valuation%20of%20effort%20costs&journal=PLOS%20Biol.&volume=15&publication_year=2017&author=Chong%2CTT)

[^69]: Shenhav, A. et al. Toward a rational and mechanistic account of mental effort. *Annu. Rev. Neurosci.* **40**, 99–124 (2017).

[CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2sXlsFShtro%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=28375769) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Toward%20a%20rational%20and%20mechanistic%20account%20of%20mental%20effort&journal=Annu.%20Rev.%20Neurosci.&volume=40&pages=99-124&publication_year=2017&author=Shenhav%2CA)

[^70]: Fan, J. An information theory account of cognitive control. *Front. Hum. Neurosci.* [https://doi.org/10.3389/fnhum.2014.00680](https://doi.org/10.3389/fnhum.2014.00680) (2014). **This paper proposes a reframing of theories of cognitive control from the perspective of informational constraints**

[Article](https://doi.org/10.3389%2Ffnhum.2014.00680) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=25228875) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4151034) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=An%20information%20theory%20account%20of%20cognitive%20control&journal=Front.%20Hum.%20Neurosci.&doi=10.3389%2Ffnhum.2014.00680&publication_year=2014&author=Fan%2CJ)

[^71]: Fleming, S. & Daw, N. Self-evaluation of decision-making: a general Bayesian framework for metacognitive computation. *Psychol. Rev.* **124**, 91–114 (2017).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=28004960) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC5178868) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Self-evaluation%20of%20decision-making%3A%20a%20general%20Bayesian%20framework%20for%20metacognitive%20computation&journal=Psychol.%20Rev.&volume=124&pages=91-114&publication_year=2017&author=Fleming%2CS&author=Daw%2CN)

[^72]: Zhang, H., Daw, N. D. & Maloney, L. T. Human representation of visuo-motor uncertainty as mixtures of orthogonal basis distributions. *Nat. Neurosci.* **18**, 1152–1158 (2015).

[CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2MXhtFeis77J) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=26120962) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4487408) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Human%20representation%20of%20visuo-motor%20uncertainty%20as%20mixtures%20of%20orthogonal%20basis%20distributions&journal=Nat.%20Neurosci.&volume=18&pages=1152-1158&publication_year=2015&author=Zhang%2CH&author=Daw%2CND&author=Maloney%2CLT)

[^73]: Vasconcelos, M., Monteiro, T. & Kacelnik, A. Irrational choice and the value of information. *Sci. Rep.* **5**, 13874 (2015).

[Google Scholar](http://scholar.google.com/scholar_lookup?&title=Irrational%20choice%20and%20the%20value%20of%20information&journal=Scientif.%20Rep.&volume=5&publication_year=2015&author=Vasconcelos%2CM&author=Monteiro%2CT&author=Kacelnik%2CA)

[^74]: Eliaz, K. & Schotter, A. Experimental testing of intrinsic preferences for noninstrumental information. *Am. Econ. Rev.* **97**, 166–169 (2007).

[Google Scholar](http://scholar.google.com/scholar_lookup?&title=Experimental%20testing%20of%20intrinsic%20preferences%20for%20noninstrumental%20information&journal=Am.%20Econom.%20Rev.&volume=97&pages=166-169&publication_year=2007&author=Eliaz%2CK&author=Schotter%2CA)

[^75]: Bromberg-Martin, E. S. & Hikosaka, O. Midbrain dopamine neurons signal preference for advance information about upcoming rewards. *Neuron* **63**, 119–126 (2009).

[CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD1MXpsFOnsL0%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=19607797) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC2723053) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Midbrain%20dopamine%20neurons%20signal%20preference%20for%20advance%20information%20about%20upcoming%20rewards&journal=Neuron&volume=63&pages=119-126&publication_year=2009&author=Bromberg-Martin%2CES&author=Hikosaka%2CO)

[^76]: Bennett, D., Bode, S., Brydevall, M., Warren, H. & Murawski, C. Intrinsic valuation of information in decision making under uncertainty. *PLOS Comp. Biol.* **12**, e1005020 (2016).

[Google Scholar](http://scholar.google.com/scholar_lookup?&title=Intrinsic%20valuation%20of%20information%20in%20decision%20making%20under%20uncertainty&journal=PLOS%20Comp.%20Biol.&volume=12&publication_year=2016&author=Bennett%2CD&author=Bode%2CS&author=Brydevall%2CM&author=Warren%2CH&author=Murawski%2CC)

[^77]: Brydevall, M., Bennett, D., Murawski, C. & Bode, S. The neural encoding of information prediction errors during non-instrumental information seeking. *Sci. Rep.* **8**, 6134 (2018).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=29666461) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC5904167) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20neural%20encoding%20of%20information%20prediction%20errors%20during%20non-instrumental%20information%20seeking&journal=Sci.%20Rep.&volume=8&publication_year=2018&author=Brydevall%2CM&author=Bennett%2CD&author=Murawski%2CC&author=Bode%2CS)

[^78]: Blanchard, T. C., Hayden, B. Y. & Bromberg-Martin, E. S. Orbitofrontal cortex uses distinct codes for different choice attributes in decisions motivated by curiosity. *Neuron* **85**, 602–614 (2015). **This paper demonstrates single-neuron encoding of non-instrumental information value in the monkey orbitofrontal cortex**

[CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2MXhsVeitr4%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=25619657) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4320007) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Orbitofrontal%20cortex%20uses%20distinct%20codes%20for%20different%20choice%20attributes%20in%20decisions%20motivated%20by%20curiosity&journal=Neuron&volume=85&pages=602-614&publication_year=2015&author=Blanchard%2CTC&author=Hayden%2CBY&author=Bromberg-Martin%2CES)

[^79]: Golman, R. & Loewenstein, G. Information gaps: a theory of preferences regarding the presence and absence of information. *Decision* **5**, 143–164 (2018).

[Google Scholar](http://scholar.google.com/scholar_lookup?&title=Information%20gaps%3A%20a%20theory%20of%20preferences%20regarding%20the%20presence%20and%20absence%20of%20information&journal=Decision&volume=5&pages=143-164&publication_year=2018&author=Golman%2CR&author=Loewenstein%2CG)

[^80]: Loewenstein, G. Anticipation and the valuation of delayed consumption. *Econ. J.* **97**, 666–684 (1987).

[Google Scholar](http://scholar.google.com/scholar_lookup?&title=Anticipation%20and%20the%20valuation%20of%20delayed%20consumption&journal=Econ.%20J.&volume=97&pages=666-684&publication_year=1987&author=Loewenstein%2CG)

[^81]: Iigaya, K., Story, G. W., Kurth-Nelson, Z., Dolan, R. J. & Dayan, P. The modulation of savouring by prediction error and its effects on choice. *eLife* **5**, e13747 (2016). **This paper presents a reinforcement learning model of non-instrumental information demand, proposing that, in addition to producing learning, dopaminergic reward prediction errors confer value to predictor states**

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=27101365) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4866828) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20modulation%20of%20savouring%20by%20prediction%20error%20and%20its%20effects%20on%20choice&journal=eLife&volume=5&publication_year=2016&author=Iigaya%2CK&author=Story%2CGW&author=Kurth-Nelson%2CZ&author=Dolan%2CRJ&author=Dayan%2CP)

[^82]: Flagel, S. B. & Robinson, T. E. Neurobiological basis of individual variation in stimulus-reward learning. *Curr. Opin. Behav. Sci.* **13**, 178–185 (2017).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=28670608) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC5486979) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Neurobiological%20basis%20of%20individual%20variation%20in%20stimulus-reward%20learning&journal=Curr.%20Opin.%20Behav.%20Sci.&volume=13&pages=178-185&publication_year=2017&author=Flagel%2CSB&author=Robinson%2CTE)

[^83]: Peck, C. J., Jangraw, D. C., Suzuki, M., Efem, R. & Gottlieb, J. Reward modulates attention independently of action value in posterior parietal cortex. *J. Neurosci.* **29**, 11182–11191 (2009).

[CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD1MXhtFOhu7rJ) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=19741125) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC2778240) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Reward%20modulates%20attention%20independently%20of%20action%20value%20in%20posterior%20parietal%20cortex&journal=J.%20Neurosci.&volume=29&pages=11182-11191&publication_year=2009&author=Peck%2CCJ&author=Jangraw%2CDC&author=Suzuki%2CM&author=Efem%2CR&author=Gottlieb%2CJ)

[^84]: Foley, N. C., Jangraw, D. C., Peck, C. & Gottlieb, J. Novelty enhances visual salience independently of reward in the parietal lobe. *J. Neurosci.* **34**, 7947–7957 (2014).

[CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2cXps12qsbk%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=24899716) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4044252) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Novelty%20enhances%20visual%20salience%20independently%20of%20reward%20in%20the%20parietal%20lobe&journal=J.%20Neurosci.&volume=34&pages=7947-7957&publication_year=2014&author=Foley%2CNC&author=Jangraw%2CDC&author=Peck%2CC&author=Gottlieb%2CJ)

[^85]: Isoda, M. & Hikosaka, O. A neural correlate of motivational conflict in the superior colliculus of the macaque. *J. Neurophysiol.* **100**, 1332–1342 (2008).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=18596188) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC2544459) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=A%20neural%20correlate%20of%20motivational%20conflict%20in%20the%20superior%20colliculus%20of%20the%20macaque&journal=J.%20Neurophysiol.&volume=100&pages=1332-1342&publication_year=2008&author=Isoda%2CM&author=Hikosaka%2CO)

[^86]: Anderson, B. The attention habit: how reward learning shapes attentional selection. *Ann. NY Acad. Sci.* **1369**, 24–39 (2016). **This is a comprehensive review of reward-related attention biases and their neural mechanisms and behavioural importance in humans**

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=26595376) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20attention%20habit%3A%20how%20reward%20learning%20shapes%20attentional%20selection&journal=Ann.%20NY%20Acad.%20Sci.&volume=1369&pages=24-39&publication_year=2016&author=Anderson%2CB)

[^87]: Hickey, C., Chelazzi, L. & Theeuwes, J. Reward guides vision when it’s your thing: trait reward-seeking in reward-mediated visual priming. *PLOS ONE* **5**, e14087 (2010).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=21124893) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC2990710) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Reward%20guides%20vision%20when%20it%E2%80%99s%20your%20thing%3A%20trait%20reward-seeking%20in%20reward-mediated%20visual%20priming&journal=PLOS%20ONE&volume=5&publication_year=2010&author=Hickey%2CC&author=Chelazzi%2CL&author=Theeuwes%2CJ)

[^88]: Daddaoua, N., Lopes, M. & Gottlieb, J. Intrinsically motivated oculomotor exploration guided by uncertainty reduction and conditioned reinforcement in non-human primates. *Sci. Rep.* **6**, 20202 (2016).

[CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC28XitFans74%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=26838344) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4738323) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Intrinsically%20motivated%20oculomotor%20exploration%20guided%20by%20uncertainty%20reduction%20and%20conditioned%20reinforcement%20in%20non-human%20primates&journal=Sci.%20Rep.&volume=6&publication_year=2016&author=Daddaoua%2CN&author=Lopes%2CM&author=Gottlieb%2CJ)

[^89]: Hickey, C., Chelazzi, L. & Theeuwes, J. Reward changes salience in human vision via the anterior cingulate. *J. Neurosci.* **30**, 11096–11103 (2010).

[CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC3cXhtFWms73O) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=20720117) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Reward%20changes%20salience%20in%20human%20vision%20via%20the%20anterior%20cingulate&journal=J.%20Neurosci.&volume=30&pages=11096-11103&publication_year=2010&author=Hickey%2CC&author=Chelazzi%2CL&author=Theeuwes%2CJ)

[^90]: Hickey, C. & Peelen, M. V. Neural mechanisms of incentive salience in naturalistic human vision. *Neuron* **85**, 512–518 (2015).

[CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2MXisFeru7s%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=25654257) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Neural%20mechanisms%20of%20incentive%20salience%20in%20naturalistic%20human%20vision&journal=Neuron&volume=85&pages=512-518&publication_year=2015&author=Hickey%2CC&author=Peelen%2CMV)

[^91]: Hunt, L. T., Rutledge, R. B., Malalasekera, W. M., Kennerley, S. W. & Dolan, R. J. Approach-induced biases in human information sampling. *PLOS Biol.* **14**, e2000638 (2016).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=27832071) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC5104460) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Approach-induced%20biases%20in%20human%20information%20sampling&journal=PLOS%20Biol.&volume=14&publication_year=2016&author=Hunt%2CLT&author=Rutledge%2CRB&author=Malalasekera%2CWM&author=Kennerley%2CSW&author=Dolan%2CRJ)

[^92]: Barbaro, L., Peelen, M. V. & Hickey, C. Valence, not utility, underlies reward-driven prioritization in human vision. *J. Neurosci.* **37**, 10438–10450 (2017). **This is among the first empirical demonstrations of reward-based and uncertainty-based modulations of visual representations in the human high-level cortex**

[CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC1cXhtl2ktb3M) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Valence%2C%20not%20utility%2C%20underlies%20reward-driven%20prioritization%20in%20human%20vision&journal=Joural%20Neurosci.&volume=37&pages=10438-10450&publication_year=2017&author=Barbaro%2CL&author=Peelen%2CMV&author=Hickey%2CC)

[^93]: San Martín, R., Appelbaum, L. G., Huettel, S. A. & Woldorff, M. G. Cortical brain activity reflecting attentional biasing toward reward-predicting cues covaries with economic decision-making performance. *Cereb. Cortex* **26**, 1–11 (2016).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=25139941) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Cortical%20brain%20activity%20reflecting%20attentional%20biasing%20toward%20reward-predicting%20cues%20covaries%20with%20economic%20decision-making%20performance&journal=Cereb.%20Cortex&volume=26&pages=1-11&publication_year=2016&author=San%20Mart%C3%ADn%2CR&author=Appelbaum%2CLG&author=Huettel%2CSA&author=Woldorff%2CMG)

[^94]: van Lieshout, L. L. F., Vandenbroucke, A. R. E., Müller, N. C. J., Cools, R. & de Lange, F. P. Induction and relief of curiosity elicit parietal and frontal activity. *J. Neurosci.* **38**, 2579–2588 (2018). **This is a demonstration of non-instrumental information value and its neural correlates in humans**

[Google Scholar](http://scholar.google.com/scholar_lookup?&title=Induction%20and%20relief%20of%20curiosity%20elicit%20parietal%20and%20frontal%20activity&journal=J.%20Neurosci.&volume=38&pages=2579-2588&publication_year=2018&author=Lieshout%2CLLF&author=Vandenbroucke%2CARE&author=M%C3%BCller%2CNCJ&author=Cools%2CR&author=Lange%2CFP)

[^95]: Loewenstein, G. The psychology of curiosity: a review and reinterpretation. *Psychol. Bull.* **116**, 75–98 (1994).

[Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20psychology%20of%20curiosity%3A%20a%20review%20and%20reinterpretation&journal=Psychol.%20Bull.&volume=116&pages=75-98&publication_year=1994&author=Loewenstein%2CG)

[^96]: Baldassare, G., Mirolli, M. (eds) *Intrinsically Motivated Learning in Natural and Artificial Systems* (Springer-Verlag, Berlin, 2013).

[Google Scholar](http://scholar.google.com/scholar_lookup?&title=Intrinsically%20Motivated%20Learning%20in%20Natural%20and%20Artificial%20Systems&publication_year=2013)

[^97]: Gruber, M. J., Gelman, B. D. & Ranganath, C. States of curiosity modulate hippocampus-dependent learning via the dopaminergic circuit. *Neuron* **84**, 486–496 (2014). **This paper demonstrates the effects of curiosity on memory and the hippocampus in humans**

[CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2cXhs1OrsbfO) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=25284006) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4252494) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=States%20of%20curiosity%20modulate%20hippocampus-dependent%20learning%20via%20the%20dopaminergic%20circuit&journal=Neuron&volume=84&pages=486-496&publication_year=2014&author=Gruber%2CMJ&author=Gelman%2CBD&author=Ranganath%2CC)

[^98]: Kang, M. J. et al. The wick in the candle of learning: epistemic curiosity activates reward circuitry and enhances memory. *Psychol. Sci.* **20**, 963–973 (2009).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=19619181) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20wick%20in%20the%20candle%20of%20learning%3A%20epistemic%20curiosity%20activates%20reward%20circuitry%20and%20enhances%20memory&journal=Psychol.%20Sci.&volume=20&pages=963-973&publication_year=2009&author=Kang%2CMJ)

[^99]: Baranes, A. F., Oudeyer, P. Y. & Gottlieb, J. Eye movements encode epistemic curiosity in human observers. *Vis. Res.* **117**, 81–90 (2015).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=26518743) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Eye%20movements%20encode%20epistemic%20curiosity%20in%20human%20observers&journal=Vis.%20Res.&volume=117&pages=81-90&publication_year=2015&author=Baranes%2CAF&author=Oudeyer%2CPY&author=Gottlieb%2CJ)

[^100]: Marvin, C. B. & Shohamy, D. Curiosity and reward: valence predicts choice and information prediction errors enhance learning. *J. Exp. Psychol. Gen.* **145**, 266–272 (2016).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=26783880) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Curiosity%20and%20reward%3A%20valence%20predicts%20choice%20and%20information%20prediction%20errors%20enhance%20learning&journal=J.%20Exp.%20Psychol.%20Gen.&volume=145&pages=266-272&publication_year=2016&author=Marvin%2CCB&author=Shohamy%2CD)

[^101]: Jepma, M., Verdonschot, R. G., van Steenbergen, H., Rombouts, S. A. & Nieuwenhuis, S. Neural mechanisms underlying the induction and relief of perceptual curiosity. *Front. Behav. Neurosci.* [https://doi.org/10.3389/fnbeh.2012.00005](https://doi.org/10.3389/fnbeh.2012.00005) (2012). **This is a study of perceptual curiosity using functional MRI in humans**

[Article](https://doi.org/10.3389%2Ffnbeh.2012.00005) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=22347853) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3277937) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Neural%20mechanisms%20underlying%20the%20induction%20and%20relief%20of%20perceptual%20curiosity&journal=Front.%20Behav.%20Neurosci.&doi=10.3389%2Ffnbeh.2012.00005&publication_year=2012&author=Jepma%2CM&author=Verdonschot%2CRG&author=Steenbergen%2CH&author=Rombouts%2CSA&author=Nieuwenhuis%2CS)

[^102]: Risko, E. F., Anderson, N. C., Lanthier, S. & Kingstone, A. Curious eyes: individual differences in personality predict eye movement behavior in scene-viewing. *Cognition* **122**, 86–90 (2012).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=21983424) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Curious%20eyes%3A%20individual%20differences%20in%20personality%20predict%20eye%20movement%20behavior%20in%20scene-viewing&journal=Cognition&volume=122&pages=86-90&publication_year=2012&author=Risko%2CEF&author=Anderson%2CNC&author=Lanthier%2CS&author=Kingstone%2CA)

[^103]: Salimpoor, V. N., Zald, D. H., Zatorre, R. J., Dagher, A. & McIntosh, A. R. Predictions and the brain: how musical sounds become rewarding. *Trends Cogn. Sci.* **19**, 86–91 (2015).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=25534332) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Predictions%20and%20the%20brain%3A%20how%20musical%20sounds%20become%20rewarding&journal=Trends%20Cogn.%20Sci.&volume=19&pages=86-91&publication_year=2015&author=Salimpoor%2CVN&author=Zald%2CDH&author=Zatorre%2CRJ&author=Dagher%2CA&author=McIntosh%2CAR)

[^104]: Huron, D. *Sweet Anticipation: Music and the Psychology of Expectation* (MIT Press, 2006).

[^105]: Liao, H. I., Yeh, S. L. & Shimojo, S. Novelty versus familiarity principles in preference decisions: task-context of past experience matters. *Front. Psychol.* **2**, 43 (2011).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=21713246) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3110941) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Novelty%20versus%20familiarity%20principles%20in%20preference%20decisions%3A%20task-context%20of%20past%20experience%20matters&journal=Front.%20Psychol.&volume=2&publication_year=2011&author=Liao%2CHI&author=Yeh%2CSL&author=Shimojo%2CS)

[^106]: Park, J., Shimojo, E. & Shimojo, S. Roles of familiarity and novelty in visual preference judgments are segregated across object categories. *Proc. Natl Acad. Sci. USA* **107**, 14552–14555 (2010).

[CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC3cXhtVOgsLfK) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=20679235) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Roles%20of%20familiarity%20and%20novelty%20in%20visual%20preference%20judgments%20are%20segregated%20across%20object%20categories&journal=Proc.%20Natl%20Acad.%20Sci.%20USA&volume=107&pages=14552-14555&publication_year=2010&author=Park%2CJ&author=Shimojo%2CE&author=Shimojo%2CS)

[^107]: Güçlütürk, Y., Güçlü, U., van Gerven, M. & van Lier, R. Representations of naturalistic stimulus complexity in early and associative visual and auditory cortices. *Sci. Rep.* **8**, 3439 (2018).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=29467495) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC5821852) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Representations%20of%20naturalistic%20stimulus%20complexity%20in%20early%20and%20associative%20visual%20and%20auditory%20cortices&journal=Sci.%20Rep.&volume=8&publication_year=2018&author=G%C3%BC%C3%A7l%C3%BCt%C3%BCrk%2CY&author=G%C3%BC%C3%A7l%C3%BC%2CU&author=Gerven%2CM&author=Lier%2CR)

[^108]: Zatorre, R. J. Musical pleasure and reward: mechanisms and dysfunction. *Ann. NY Acad. Sci.* **1337**, 202–211 (2015).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=25773636) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Musical%20pleasure%20and%20reward%3A%20mechanisms%20and%20dysfunction&journal=Ann.%20NY%20Acad.%20Sci.&volume=1337&pages=202-211&publication_year=2015&author=Zatorre%2CRJ)

[^109]: Friston, K., FitzGerald, T., Rigoli, F., Schwartenbeck, P. & Pezzulo, G. Active inference: a process theory. *Neural Comput.* **29**, 1–49 (2016).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=27870614) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Active%20inference%3A%20a%20process%20theory&journal=Neural%20Comput.&volume=29&pages=1-49&publication_year=2016&author=Friston%2CK&author=FitzGerald%2CT&author=Rigoli%2CF&author=Schwartenbeck%2CP&author=Pezzulo%2CG)

[^110]: Sutton, R. S. & Barto, A. G. *Reinforcement Learning: an Introduction* (MIT Press, 1998).

[^111]: Daw, N. D., Gerschman, S. J., Seymour, B., Dayan, P. & Dolan, R. J. Model-based influences on human choices and striatal prediction errors. *Neuron* **69**, 1204–1215 (2011).

[CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC3MXjvFejsLY%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=21435563) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3077926) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Model-based%20influences%20on%20human%20choices%20and%20striatal%20prediction%20errors&journal=Neuron&volume=69&pages=1204-1215&publication_year=2011&author=Daw%2CND&author=Gerschman%2CSJ&author=Seymour%2CB&author=Dayan%2CP&author=Dolan%2CRJ)

[^112]: Friston, K. J. et al. Active inference, curiosity and insight. *Neural Comput.* **29**, 2633–2683 (2017).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=28777724) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Active%20inference%2C%20curiosity%20and%20insight&journal=Neural%20Comput.&volume=29&pages=2633-2683&publication_year=2017&author=Friston%2CKJ)

[^113]: Morewedge, C. K. & Kahneman, D. Associative processes in intuitive judgment. *Trends Cogn. Sci.* **14**, 435–440 (2010).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=20696611) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC5378157) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Associative%20processes%20in%20intuitive%20judgment&journal=Trends%20Cogn.%20Sci.&volume=14&pages=435-440&publication_year=2010&author=Morewedge%2CCK&author=Kahneman%2CD)

[^114]: Buckley, C., Kim, C. S., McGregor, S. & Seth, A. K. The free energy principle for action and perception: a mathematical review. *J. Math. Psychol.* **81**, 55–79 (2017).

[Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20free%20energy%20principle%20for%20action%20and%20perception%3A%20a%20mathematical%20review&journal=J.%20Math.%20Psychol.&volume=81&pages=55-79&publication_year=2017&author=Buckley%2CC&author=Kim%2CCS&author=McGregor%2CS&author=Seth%2CAK)

[^115]: Gershman, S. J. & Blei, D. M. A tutorial on Bayesian nonparametric models. *J. Math. Psychol.* **56**, 1–12 (2012).

[Google Scholar](http://scholar.google.com/scholar_lookup?&title=A%20tutorial%20on%20Bayesian%20nonparametric%20models&journal=J.%20Math.%20Psychol.&volume=56&pages=1-12&publication_year=2012&author=Gershman%2CSJ&author=Blei%2CDM)

[^116]: Baranes, A. & Oudeyer, P. Y. Active learning of inverse models with intrinsically motivated goal exploration in robots. *Rob. Auton. Syst.* **61**, 49–73 (2013).

[Google Scholar](http://scholar.google.com/scholar_lookup?&title=Active%20learning%20of%20inverse%20models%20with%20intrinsically%20motivated%20goal%20exploration%20in%20robots&journal=Rob.%20Auton.%20Syst.&volume=61&pages=49-73&publication_year=2013&author=Baranes%2CA&author=Oudeyer%2CPY)

[^117]: Oudeyer, P. Y., Kaplan, F. & Hafner, V. V. Instrinsic motivation systems for autonomous mental development. *IEEE Trans. Evol. Comput.* **11**, 265–286 (2007).

[Google Scholar](http://scholar.google.com/scholar_lookup?&title=Instrinsic%20motivation%20systems%20for%20autonomous%20mental%20development&journal=IEEE%20Trans.%20Evol.%20Comput.&volume=11&pages=265-286&publication_year=2007&author=Oudeyer%2CPY&author=Kaplan%2CF&author=Hafner%2CVV)

[^118]: Forestier, S. & Oudeyer, P. Y. in *Proc. IEEE/RSJ Int. Conf. on Intelligent Robots and Systems (IROS)* 3965–3972 (IEEE, 2016).

[^119]: Moulin-Frier, C., Nguyen, S. M. & Oudeyer, P.-Y. Self-organization of early vocal development in infants and machines: the role of intrinsic motivation. *Front. Psychol.* **4**, 1006 (2014).

[Article](https://doi.org/10.3389%2Ffpsyg.2013.01006) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=24474941) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Self-organization%20of%20early%20vocal%20development%20in%20infants%20and%20machines%3A%20the%20role%20of%20intrinsic%20motivation&journal=Front.%20Psychol.&doi=10.3389%2Ffpsyg.2013.01006&publication_year=2013&author=Moulin-Frier%2CC&author=Nguyen%2CSM&author=Oudeyer%2CP-Y)

[^120]: Forestier, S. & Oudeyer, P. Y. in *Proc. 39th Annual Meeting of the Cognitive Science Soc*. 2013–2018 (Cogsci, 2017).

[^121]: Clement, B., Roy, D., Oudeyer, P. Y. & Lopes, M. Multi-armed bandits for intelligent tutoring systems. *J. Educ. Data Mining* **7**, 2 (2015).

[^122]: Metcalfe, J. Metacognitive judgments and control of study. *Curr. Dir. Psychol. Sci.* **18**, 159–163 (2009).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=19750138) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC2742428) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Metacognitive%20judgments%20and%20control%20of%20study&journal=Curr.%20Dir.%20Psychol.%20Sci.&volume=18&pages=159-163&publication_year=2009&author=Metcalfe%2CJ)

[^123]: Lopes, M. & Oudeyer, P.-Y. in *Proc. IEEE Int. Conf. on Development and Learning and Epigenetic Robotics (ICDL)* 1–8 (IEEE, 2012).

[^124]: Son, L. & Sethi, R. Metacognitive control and optimal learning. *Cogn. Sci.* **30**, 759–774 (2006).

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=21702835) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Metacognitive%20control%20and%20optimal%20learning&journal=Cogn.%20Sci.&volume=30&pages=759-774&publication_year=2006&author=Son%2CL&author=Sethi%2CR)

[^125]: Baranes, A. F., Oudeyer, P. Y. & Gottlieb, J. The effects of task difficulty, novelty and the size of the search space on intrinsically motivated exploration. *Front. Neurosci.* **8**, 317 (2014). **This presents a novel laboratory task for examining intrinsically motivated exploration based on difficulty in humans**

[PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=25352771) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4196545) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=The%20effects%20of%20task%20difficulty%2C%20novelty%20and%20the%20size%20of%20the%20search%20space%20on%20intrinsically%20motivated%20exploration&journal=Front.%20Neurosci.&volume=8&publication_year=2014&author=Baranes%2CAF&author=Oudeyer%2CPY&author=Gottlieb%2CJ)

[^126]: Barto, A., Singh, S. & Chenatez, N. in *Proc. 3rd Int. Conf. Dvp. Learn* 112–119 (San Diego, CA, 2004).

[^127]: Schmidhuber, J. in *Proc. Int. Joint Conf. Neural Networks* **2**, 1458–1463 (IEEE, 1991).

[^128]: Bellemare, M. et al. in *Proc. Advances in Neural Information Processing Systems 29 Conf*. 1471–1479 (NIPS, 2016).

[^129]: Kulkarni, T. D., Narasimhan, K., Saeedi, A. & Tenenbaum, J. B. in *Proc. Advances in Neural Information Processing Systems 29 Conf*. 3675–3683 (NIPS, 2016).

[^130]: Pouget, A., Drugowitsch, J. & Kepecs, A. Confidence and certainty: distinct probabilistic quantities for different goals. *Nat. Neurosci.* **19**, 366–374 (2016).

[CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC28XjtVOjtL4%3D) [PubMed](http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=PubMed&dopt=Abstract&list_uids=26906503) [PubMed Central](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC5378479) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=Confidence%20and%20certainty%3A%20distinct%20probabilistic%20quantities%20for%20different%20goals&journal=Nat.%20Neurosci.&volume=19&pages=366-374&publication_year=2016&author=Pouget%2CA&author=Drugowitsch%2CJ&author=Kepecs%2CA)