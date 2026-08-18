---
title: "Exploring the cognitive and motor functions of the basal ganglia: an integrative review of computational cognitive neuroscience models"
source: "https://www.frontiersin.org/journals/computational-neuroscience/articles/10.3389/fncom.2013.00174/full"
author:
  - "[[Sebastien Helie]]"
  - "[[Srinivasa Chakravarthy]]"
  - "[[Ahmed  A. Moustafa]]"
published: 2013-12-06
created: 2026-06-20
description: "Many computational models of the basal ganglia have been proposed over the past twenty-five years. While computational neuroscience models have focused on cl..."
tags:
  - "clippings"
---
- 1\. Department of Psychological Sciences, Purdue University West Lafayette, IN, USA
- 2\. Department of Biotechnology, Indian Institute of Technology Madras, India
- 3\. Marcs Institute for Brain and Behaviour and School of Social Sciences and Psychology, University of Western Sydney Sydney, NSW, Australia

Article metrics

[View details](#metrics)

69

Citations

14,8k

Views

4,1k

Downloads

## Abstract

Many computational models of the basal ganglia (BG) have been proposed over the past twenty-five years. While computational neuroscience models have focused on closely matching the neurobiology of the BG, *computational cognitive neuroscience* (CCN) models have focused on how the BG can be used to implement cognitive and motor functions. This review article focuses on CCN models of the BG and how they use the neuroanatomy of the BG to account for cognitive and motor functions such as categorization, instrumental conditioning, probabilistic learning, working memory, sequence learning, automaticity, reaching, handwriting, and eye saccades. A total of 19 BG models accounting for one or more of these functions are reviewed and compared. The review concludes with a discussion of the limitations of existing CCN models of the BG and prescriptions for future modeling, including the need for computational models of the BG that can simultaneously account for cognitive and motor functions, and the need for a more complete specification of the role of the BG in behavioral functions.

## Introduction

The basal ganglia (BG) are a group of nuclei at the base of the forebrain that are strongly connected to the cortex. While the role of the BG had historically been restricted to motor function, a substantive amount of recent research suggests that the BG are also involved in a variety of cognitive functions (Steiner and Tseng, ). Behavioral and neural experiments with human and non-human animals have informed our understanding of the BG function for over a century, and the past two decades have seen an increased use of computational models to simulate the anatomy and functionality of the BG. The most anatomically detailed computational neuroscience models seldom go as far as simulating complex animal behavior (because of complexity issues), but simpler (less anatomically detailed) models can be used to simultaneously account for some anatomical details and complex animal behavior. The strength of these later *computational cognitive neuroscience* (CCN) models lies in that they can simultaneously account for both neuroscience data and behavioral data (Ashby and Helie, ).

This review article focuses on CCN models of the BG and classifies existing models according to cognitive and motor function. The remainder of this article is organized as follows. First, the anatomy that is usually included in CCN models of the BG is reviewed. This anatomy section is incomplete by design, as only details that are simulated to account for specific cognitive or motor function are included. Next, we review CCN models used to simulate six different cognitive functions, namely categorization, instrumental conditioning, probabilistic learning, working memory, sequence learning, and automaticity. This presentation is followed by CCN models of motor function. Computational cognitive neuroscience models of motor functions are separated into models of reaching, handwriting, and eye saccades. The review concludes with a discussion of the limitations of existing CCN models of the BG and prescriptions for future modeling. Future directions emphasize the need for CCN models of the BG that can simultaneously account for cognitive and motor functions, and the need for a more complete specification of the role of the BG in the reviewed functions.

## Neuroanatomy of the basal ganglia

The BG include the striatum (caudate, putamen, nucleus accumbens), the globus pallidus (GP), the subthalamic nucleus (STN), the substantia nigra (SN), the ventral tegmental area, and the olfactory tubercle (see Figure [^1]). The striatum receives the majority of afferent connections whereas the internal segment of the GP Globus pallidus (internal) (GPi) and SN pars reticulate (SNr) are the sources of the majority of efferent connections that target cortical regions via the thalamus. Based on both structural and functional evidence, the striatum is often divided into a ventral and a dorsal part. The ventral striatum includes the nucleus accumbens, ventromedial portions of the caudate and putamen, and the olfactory tubercle. The dorsal striatum, which is usually the main focus of CCN models of the BG, includes the remainder of the caudate and putamen.

Figure 1

Virtually all of the neocortex sends excitatory (glutamatergic) projections to the striatum (Reiner, ). Corticostriatal input is massively convergent with estimates ranging from 5,000 to 10,000 cortical neurons converging on a single striatal medium spiny neuron (MSN; the main striatal projection neurons) (Kincaid et al., ). Classically, corticostriatal organization is thought to follow a fairly strict spatial topography (Kemp and Powell, ). Along the rostral-to-caudal extent of the BG, the cortical afferents tend be more prevalent from rostral-to-caudal cortical regions. For instance, ventral striatum receives input predominantly from orbitofrontal cortex, ventromedial prefrontal cortex, and anterior cingulate cortex (ACC). As one moves caudally within the striatum, inputs from areas 9, 46, and 8 become more prevalent (Haber et al.,; Calzavara et al., ), followed by inputs from premotor regions (area 6) with the most caudal motor and somatosensory cortical regions projecting preferentially to the caudal putamen (Flaherty and Graybiel, ). Spatial topography holds as you continue rostrally and ventrally through parietal and temporal cortices as well as other extrastriate visual areas (Kemp and Powell,; Yeterian and Pandya,,, ).

The thalamus provides another major source of input to the BG (Wilson, ), with the majority of thalamostriatal projections originating from the parafascicular-centromedian (CMPf) complex (Smith et al., ). Thalamic input to the striatum synapses on both MSNs and cholinergic tonically active neurons (TANs; a class of large-body interneurons) (Smith et al., ), with the latter likely playing an important role in modulating cortico-striatal synaptic plasticity (Ashby and Crossley, ). Finally, thalamic input to the striatum is in a position to modulate BG function by virtue of cortico-thalamo-striatal connections and striatal-thalamo-striatal feedback (Smith et al., ).

The BG also receives dopaminergic input that plays a critical role in modulating striatal activity. Dopamine is projected from the ventral tegmental area and SN pars compacta to the BG and prefrontal cortex, among other brain regions. Dopamine firing patterns fluctuate between two different modes: phasic and tonic. While the phasic mode is fast-acting and spans milliseconds, the tonic mode is long-acting and can span minutes or hours. The dissociable function of both phasic and tonic dopamine is debatable (Dreher and Burnod,; Assadi et al.,; Moustafa et al., ). However, various studies suggest that phasic dopamine plays a key role in synaptic plasticity and reinforcement learning (Wickens et al.,; Reynolds et al., ), while tonic dopamine is important for speeding-up reaction times (Niv et al.,; Moustafa et al., ) and controlling the signal-to-noise ratio (Durstewitz and Seamans, ).

Information flow through the BG follows two distinct pathways (see Figure [^1]). Striatal MSNs in the direct pathway project directly to the output nuclei (e.g., GPi) and selectively express D1-like receptors (i.e., D1 and D5; Gerfen et al., ). The striatal MSNs in the indirect pathway project to the external segment of the GP Globus pallidus (external) (GPe) prior to reaching the output nuclei of the BG (e.g., GPi), and selectively express D2-like receptors (i.e., D2, D3, and D4; Gerfen and Young, ). In addition to the direct and indirect pathways, the STN is another major input structure of the BG receiving extensive cortical and thalamic input. This so-called hyperdirect pathway provides a means by which frontal cortical regions can monosynapically influence STN function (Nambu et al., ).

With abundant dopamine receptors in the BG affecting the dynamics of the different pathways, most CCN models of the BG include a role for dopamine. One important way of testing whether the hypothesized role for dopamine in the model is adequate is to simulate the model under dopamine-depleted conditions. Specifically, reducing the amount of dopamine available in the model should produce Parkinsonian symptoms. Parkinson’s disease (PD) is caused by the accelerated death of dopamine producing neurons. The pattern of cell loss is opposite to that of, and more severe than in, normal aging. Within the SN pars compacta, cell loss is predominately found in the ventral tier with less (but still extensive) damage in the dorsal tier (Fearnley and Lees,; Gibb and Lees, ). In contrast, normal aging yields substantially less cell loss and in a dorsal-to-ventral pattern. Parkinsonian motor symptoms appear after a loss of 60–70% of SN pars compacta cells and 70–80% of dopamine levels in striatal nuclei (Bernheimer et al.,; Gibb and Lees, ). Motor symptoms include tremor, rigidity, bradykinesia, and akinesia. In addition to motor deficits, non-demented PD patients present cognitive symptoms that resemble those observed in patients with frontal damage. Numerous studies documenting cognitive deficits of PD patients have revealed impairment in a variety of tasks related to memory, learning, visuospatial skills, and attention (e.g., Gotham et al.,; Price et al., ).

## Cognitive function

While many cognitive functions have been attributed to the BG (for a review, see Steiner and Tseng, ), relatively few have been modeled and numerically simulated using CCN models, i.e., models that can simultaneously account for both neurobiological and behavioral data. Hence, this review does not constitute an attempt at reviewing all the cognitive and motor functions attributed to the BG: the focus is on CCN models of the BG. Note that the model descriptions included are conceptual, in that implementation details and mathematical formulations are not discussed. The reader is referred to the cited original papers for model details and equations. Table [^2] summarizes the reviewed models along with their respective components.

Table 1

<table><thead><tr><td></td><td>DP (1)</td><td>IP (2)</td><td>HP (3)</td><td>Str</td><td>GPi</td><td>GPe</td><td>STN</td></tr></thead><tbody><tr><td colspan="7"><b>Cognitive</b></td></tr><tr><td>Ashby et al. ()</td><td>X</td><td></td><td></td><td>X</td><td>X</td><td></td><td></td></tr><tr><td>Moustafa and Gluck ()</td><td>X</td><td></td><td></td><td>X</td><td></td><td></td><td></td></tr><tr><td>Ashby and Crossley ()</td><td>X</td><td></td><td></td><td>X</td><td>X</td><td></td><td></td></tr><tr><td>Frank ()</td><td>X</td><td>X</td><td></td><td>X</td><td>X</td><td>X</td><td></td></tr><tr><td>Guthrie et al. ()</td><td>X</td><td></td><td>X</td><td>X</td><td>X</td><td></td><td>X</td></tr><tr><td>Monchi et al. ()</td><td>X</td><td></td><td></td><td>X</td><td>X</td><td></td><td></td></tr><tr><td>Ashby et al. ()</td><td>X</td><td></td><td></td><td>X</td><td>X</td><td></td><td></td></tr><tr><td>Frank et al. ()</td><td>X</td><td></td><td></td><td>X</td><td>X</td><td></td><td></td></tr><tr><td>Moustafa and Maida ()</td><td>X</td><td></td><td></td><td>X</td><td></td><td></td><td></td><td></td></tr><tr><td>Schroll et al. ()</td><td>X</td><td></td><td>X</td><td>X</td><td>X</td><td>X</td><td>X</td></tr><tr><td>Nakahara et al. ()</td><td>X</td><td></td><td>X</td><td>X</td><td></td><td></td><td></td></tr><tr><td>Ashby et al. ()</td><td>X</td><td></td><td></td><td>X</td><td>X</td><td></td><td></td></tr><tr><td>Chersi et al. ()</td><td>X</td><td>X</td><td>X</td><td>X</td><td>*</td><td>X</td><td>X</td></tr><tr><td colspan="7"><b>Motor</b></td></tr><tr><td>Bischoff ()</td><td>X</td><td>X</td><td></td><td>X</td><td>X</td><td>X</td><td>X</td></tr><tr><td>Magdoom et al. ()</td><td>X</td><td>X</td><td></td><td>X</td><td></td><td></td><td></td></tr><tr><td>Gangadhar et al. ()</td><td></td><td>X</td><td></td><td></td><td></td><td>X</td><td>X</td></tr><tr><td>Contreras-Vidal and Stelmach ()</td><td>X</td><td>X</td><td>X</td><td>X</td><td>X</td><td>X</td><td>X</td></tr><tr><td>Dominey and Arbib ()</td><td>X</td><td></td><td></td><td>X</td><td>*</td><td></td><td></td></tr><tr><td>Krishnan et al. ()</td><td>X</td><td>X</td><td></td><td>X</td><td>*</td><td>X</td><td>X</td></tr></tbody></table>

Summary of the basal ganglia components included in the reviewed models.

*Note. DP = Direct pathway \[(1) in Figure [^1]\]; IP = Indirect pathway \[(2) in Figure [^1]\]; HP = Hyperdirect pathway \[(3) in Figure [^1]\]; Str = Striatum; GPi = Globus pallidus (internal); GPe = Globus pallidus (external); STN = Subthalamic nucleus. \* These models used the substantia nigra pars reticulate (SNr) as their output node of the basal ganglia. In this context, the SNr is functionally equivalent to the GPi*.

### Categorization

Categorization is the ubiquitous process by which individual items are grouped to form categories. The massive convergence of cortico-striatal connectivity makes the BG an ideal site for categorization, and much research supports the role of the BG in category learning (for a review, see Seger, ).

#### Models

One of the earliest and most prominent neurobiological models of categorization is called COVIS (Ashby et al., ). COVIS is a multiple-system theory that was originally developed to account for the many behavioral dissociations between verbal and non-verbal categorization (as described by the general recognition theory; Ashby and Gott, ). COVIS includes an hypothesis-testing system and a procedural learning system. The hypothesis-testing system can quickly learn a small set of (e.g., verbal) categories (those that can be found by hypothesis-testing and often be verbally described) while the procedural learning system can learn any type of arbitrary categories in a slow trial-and-error manner (e.g., non-verbal). Each categorization system relies on a separate brain circuit but, interestingly, they both include the BG. In the hypothesis-testing system, the BG is used to support working memory maintenance and for rule switching. In the procedural system, the BG is used to learn stimulus—response associations. The COVIS model of categorization has been used to simulate a large number of category learning experiments and made several behavioral predictions, many of which have been later confirmed by empirical experiments (for a review, Maddox and Ashby, ). For example, COVIS predicts that delaying the feedback in verbal categorization should not affect performance (because the hypothesis-testing system relies on working memory) whereas delaying feedback in non-verbal categorization should impair learning (because the procedural learning system relies on dopamine-mediated reinforcement learning in the BG). This prediction was confirmed in Ashby et al. (). In addition, reducing dopamine levels in COVIS can account for many cognitive symptoms in PD patients such as perseveration, reduced sensitivity to negative feedback, and others (see Helie et al.,, ). Likewise, dopamine elevation can account for the effect of positive affect on verbal category learning (Helie et al., ). While most COVIS simulations have used a rate version of the model, a spiking version of the procedural-learning system has been used to account for some categorization results and extended to account for instrumental conditioning (Ashby and Crossley, ) and automaticity (Ashby et al., ).

As an alternative, Moustafa and Gluck (,) proposed a computational model of the striatum and prefrontal cortex that focuses on the dopamine projections to these areas as well as their interactions during multi-cue category learning. In this task, participants learn to select and pay attention to a single cue among a multi-cue pattern, and then make a categorization response. Participants learn this task via corrective feedback. In the model, the prefrontal cortex is essential for attentional selection while the striatum is used for motor response selection. Similar to COVIS, the Moustafa and Gluck (,) model can account for categorization deficits in PD patients by reducing dopamine levels in both the BG and prefrontal cortex, which is in agreement with empirical results (Kaasinen et al.,; Silberstein et al., ). Additionally, the Moustafa and Gluck (,) model can account for some effects of dopaminergic and anticholinergic medication. The Moustafa and Gluck (,) model assumes that the administration of anticholinergic medications in PD interferes with hippocampal function, which is also in agreement with empirical studies (Meco et al.,; Pondal et al.,; Ehrt et al.,; Herzallah et al., ). In contrast, the current version of COVIS has not been used to simulate medication effects in PD.

#### Synthesis

The reviewed models of categorization both agree that the BG, and its interaction with the prefrontal cortex, are essential for category learning. Furthermore, they agree that dopamine levels in both the BG and prefrontal cortex are important. While COVIS (Ashby et al., ) has been used to simulate a wider range of categorization tasks, the Moustafa and Gluck (,) model has been used to simulate more details in a smaller subset. For example, one limitation of the Moustafa and Gluck (,) model is that it does not simulate complex multi-cue learning tasks that involve paying attention to more than one stimulus (which can be done using COVIS). However, the Moustafa and Gluck (,) model can simulate the effect of dopaminergic medication, whereas COVIS has not been used to simulate medication effects. One important difference between the COVIS and Moustafa and Gluck (,) model is that COVIS assigns a different role for BG and cortical dopamine, namely error signal and signal gain (respectively). In contrast, Moustafa and Gluck (,) assign both of these roles to dopamine in both the BG and the prefrontal cortex. In addition, an important limitation of both models is that they oversimplify the anatomy of the BG by not including the indirect and hyperdirect pathways. Future work aimed at increasing the biological accuracy of COVIS and the Moustafa and Gluck (,) models may highlight some additional key differences between the modeling approaches and allow for selecting the most appropriate BG model of categorization.

### Instrumental conditioning

Instrumental conditioning (also called “operant” conditioning) is a process by which animals learn to behave in a way that will maximize reward and minimize punishment. In a typical instrumental conditioning experiment, a neutral environment is altered and begins generating rewards (acquisition phase). Next, the reward is removed from the environment and the environment reverts to its neutral state (extinction phase). Extinction is usually followed by a reacquisition phase, where the reward is introduced again in the same neutral environment. Typically, a new behavior is learned during the acquisition phase, and progressively disappears during the extinction phase. The behavior reappears during the reacquisition phase, usually at a much faster rate than during the initial acquisition phase. This phenomenon is called *fast reacquisition*. Much evidence implicates the BG in instrumental conditioning (e.g., O’Doherty et al.,; Yin et al., ), but the neurobiology underlying extinction and fast reacquisition is poorly understood.

#### Models

Ashby and Crossley () proposed a spiking model of the direct pathway of the BG (see Figure [^1]) inspired by the COVIS procedural learning system (Ashby et al., ) to account for instrumental conditioning. The Ashby and Crossley () model focuses on the TANs, a population of cholinergic interneurons in the striatum that is rarely included in CCN models of the BG. Pakhotin and Bracci () have shown that TANs play an important role in inhibiting cortical activation of the MSNs (i.e., the projection neurons generally modeled in the direct and indirect pathways). As suggested by their name, TANs have a high baseline firing rate, but they learn to pause in rewarding contexts (Apicella, ). Ashby and Crossley () suggest that one possible role for the TANs is to protect striatal learning from catastrophic interference and allow for fast reacquisition. In addition to the direct pathway, the Ashby and Crossley () model includes a sensory association area, the supplementary motor area (SMA), and the CMPf complex.

The Ashby and Crossley () model is an opened loop through the BG (from sensory association cortex to the SMA). The stimulus activates the sensory association cortex, which in turn activates the striatum and the direct pathway of the BG. At the same time, the context activates the CMPf complex, which transmits activation to the TANs (this pathway is not included in Figure [^1]). At the beginning of an experiment, the simulated subject does not know that the context is rewarding. Hence, the TANs do not pause, and the MSNs in the direct pathway cannot be activated by the sensory association cortex. This prevents stimulus—response association learning. During the acquisition phase, the TANs quickly learn that the context is rewarding and pause. The MSNs are thus released from inhibition and the model learns to produce the rewarding behavior using reinforcement learning. Next, during the extinction phase, the TANs learn that the context is no longer rewarding and stop pausing. This change inhibits the MSNs and interrupts cortico-striatal learning. Hence, the associations that were learned during the acquisition phase are protected. Finally, during the reacquisition phase, the context becomes rewarding again, and the TANs learn to pause. The MSNs are released from inhibition, and the learned associations are in the same state as in the acquisition phase, which produces fast reacquisition. Using this process, the model has been used to reproduce the acquisition, extinction, and fast reacquisition phases typical of instrumental conditioning and single-cell recording data from TANs showing that the cells learn to pause in rewarding contexts (Ashby and Crossley, ).

#### Synthesis

The Ashby and Crossley () model is the only CCN model of instrumental conditioning that can simultaneously account for behavioral (e.g., fast reacquisition) and single-cell data (from the TANs). This model constitutes an important step in that it provides an implementation and numerical simulation of the theory that TANs learn to pause in rewarding contexts, and how this can affect reinforcement learning in the BG. However, the neuroanatomy of the BG was simplified in that only the direct pathway through one of the cortico-BG loops was included. It is unclear at this time how the TANs’ dynamics would affect the indirect pathway, or how the model would behave if more than one loops was included. Future work is needed to verify how the theory implemented in Ashby and Crossley () behaves in a more detailed model of the BG.

### Probabilistic learning

Probabilistic learning typically refers to tasks where the association between the response and the reward is uncertain. Unlike most categorization experiments, the same response to the same stimulus can result in different outcomes on different trials. While probabilistic learning has been shown to rely on the BG since the mid-1990s (Knowlton et al., ), it took a decade before CCN models of the BG were used to attempt to account for probabilistic learning.

#### Models

The Frank () model was originally proposed to account for cognitive deficits in parkinsonism. The model includes both the direct and indirect pathways through the BG (see Figure [^1]), the premotor cortex, and an unspecified input area (probably located in posterior cortex) (so the model is an opened loop). In the Frank () model, the input activates both the premotor cortex and the striatum. However, cortical activation is insufficient to produce a response, so BG processing is required to gate the correct response. The focus of the model is on: (1) the role of the indirect pathway in probabilistic learning and (2) the role of dopamine in probabilistic learning. In the Frank () model, the direct pathway is in charge of selecting the appropriate action (Go) whereas the indirect pathway is in charge of inhibiting inappropriate actions (NoGo). The direct and indirect pathways converge in the GPi and compete to control GPi activation, and eventually the response. Simulation results show that removing the indirect pathway in the model reduces performance, suggesting that both the direct and indirect pathways are essential in probabilistic learning. In addition, the effect of the indirect pathway needs to be specific to each action (so that the indirect pathway can individually inhibit each action).

As described in the neuroanatomy section above, the competition between the direct and indirect pathways is modulated by dopamine (the second focus of the Frank () model). Specifically, higher dopamine levels increase activation in the direct pathway (e.g., through D1 receptors) and reduces activation in the indirect pathway (e.g., through D2 receptors). Hence, dopamine release following unexpected rewards results in long-term potentiation (LTP) in the direct pathway and long-term depression (LTD) in the indirect pathway. In contrast, dopamine dips following the unexpected absence of a reward reduces activation and produces LTD in the direct pathway but increases activation and produces LTP in the indirect pathway. The simulation results suggest that the dynamic range of the dopamine signal is crucial in probabilistic learning and reversal learning (e.g., when the response—reward associations are changed during learning). Reducing (to simulate PD) or increasing (to simulate medication overdose) dopamine levels can result in simulated Parkinsonian symptoms (Frank, ).

Another interesting model of probabilistic learning was recently proposed by Guthrie et al. (). The Guthrie et al. () model is based on an earlier computational neuroscience model of the BG that focuses on the interaction between the direct and hyperdirect pathways (Leblois et al., ). The Guthrie et al. () model includes two cortico-BG closed-loop that interact in the striatum. The first loop is called the “cognitive” loop and is used to identify the visual symbols used in the probabilistic learning task. The second loop is called the “motor” loop and is used to select a response based on the observed symbols. Some of the corticostriatal projections affect both loops, but the rest of the circuit is segregated. In both loops, the direct pathway is in charge of selecting the correct channel (i.e., identifying the symbols or the response) while the hyperdirect pathway sends non-specific inhibition to the GPi to produce a center-surround decision process. All corticostriatal synapses are plastic (using dopamine-mediated reinforcement learning) and the cognitive loop gradually learns to bias the motor loop, thus producing faster reaction times. The model successfully reproduces both neural firing rates and behavioral data in the double-arm bandit task.

The categorization models reviewed earlier have also been applied to probabilistic learning. The Moustafa and Gluck () model focused on the role of dopamine in probabilistic learning. In addition to simulating probabilistic learning with normal dopamine levels, Moustafa and Gluck () have simulated the effect of decreased dopamine (as in PD) and the effect of dopaminergic medication in both the BG and prefrontal cortex. The COVIS model has also been used to simulate probabilistic learning (Helie et al., ). While COVIS was not used to simulate medication effects, the model could account for probabilistic learning with normal and reduced (as in PD) dopamine levels (with a dosage effect such that lowest levels of dopamine produced worst performance; see Knowlton et al., ).

#### Synthesis

The reviewed models of probabilistic learning tend to be more biologically detailed than the reviewed models of categorization. Specifically, the Frank () model includes the direct and indirect pathways, whereas the Guthrie et al. () model includes the direct and hyperdirect pathways. In contrast, COVIS (Ashby et al., ) and the Moustafa and Gluck (,) models only included the direct pathway. Interestingly, however, the Frank () model does not include the same details as the Guthrie et al. () model. Both models include the direct pathway for action selection, and use dopamine-mediated reinforcement learning to learn corticostriatal synapses. However, the Frank () model uses the indirect pathway as a channel-specific excitatory process to cancel inappropriate actions whereas Guthrie et al. () use the hyperdirect pathway as a non-specific excitatory process to cancel inappropriate actions. Neither model includes both the indirect and hyperdirect pathways. While there is agreement on the need for an excitatory process to enhance the contrast between the selected and non-selected actions, the exact process is still to be determined.

While the categorization models only included the direct pathway of the BG, one of their strengths is that, in addition to their generality, they also include other brain areas. For instance, Unlike the Frank () model, the Moustafa and Gluck (,) model simulates the role of prefrontal cortex and its dopamine projections, which is in agreement with empirical studies (Mulder et al.,; Histed et al., ). Also, analysis of the parameter space in the COVIS simulations challenges the role of the BG for procedural learning in probabilistic learning, and suggests instead that the BG are used for hypothesis-testing in this task (Gluck et al., ). So, both categorization models agree on an important role for the prefrontal cortex in probabilistic learning, and this role is missing from both the Frank () and the Guthrie et al. () models. The most productive future approach might be to add a prefrontal cortex to the existing probabilistic learning models and see how this addition affects the dynamic of the different BG pathways.

### Working memory

Working memory is a cognitive function used to maintain and manipulate information in real-time for a short duration (seconds). While working memory has traditionally been associated with the prefrontal cortex (Fuster, ), Monchi et al. () proposed that the BG may be required to maintain information in prefrontal cortex.

#### Models

The Monchi et al. () model was originally proposed to account for working memory deficits in PD and schizophrenia. The model includes three BG-thalamocortical closed loops: two with the prefrontal cortex (one for spatial information and the other for object information), and one through the ACC (for strategy selection). In all three cases, only the direct pathway through the BG was included (see Figure [^1]). The role of the two prefrontal-BG loops is to maintain working memory information about the stimuli, whereas the ACC maintains the adopted strategy by inhibiting all the prefrontal cortex loops except one (i.e., representing the selected strategy). Visual input to the BG comes from the posterior parietal cortex (spatial) and inferior temporal cortex (object). The model output is located in the premotor cortex, and the nucleus accumbens (not shown in Figure [^1]) is used to provide feedback. In the model, the visual stimulus is input to the prefrontal cortex loops, and the stimulus activity is propagated through the direct pathway of the BG. As a result, the thalamus is released from GPi inhibition, and activation produced by the stimulus in the prefrontal cortex reverberates through closed-loops with the thalamus. When a response is required, the prefrontal cortex transfers its activation to the premotor cortex. If the response is incorrect, the nucleus accumbens sends a feedback signal to the ACC loop, which selects a new strategy by switching its inhibition to different prefrontal cortex loops. The Monchi et al. () model has been used to simulate a delayed response task and the Wisconsin Card Sorting Test. Interestingly, reducing the connection strengths within the BG-thalamocortical loops produces Parkinsonian symptoms, whereas reducing nucleus accumbens activity produces deficits similar to those observed in schizophrenia (Monchi et al., ).

Five years later, Ashby et al. () proposed the FROST model to account for intact spatial working memory maintenance. Similar to the Monchi et al. () model, FROST includes the direct pathway of the BG (see Figure [^1]), and working memory maintenance relies on reverberating activation between the prefrontal cortex and the thalamus. However, unlike in the Monchi et al. () model, only one prefrontal cortex loop is included, and thalamic activation is not sufficient to maintain prefrontal activity: a second set of closed-loops between the prefrontal cortex and posterior cortex needs to be simultaneously activated to maintain working memory information. In Ashby et al. (), the focus is on simulating spatial working memory tasks, and the area of posterior cortex required for working memory maintenance is the posterior parietal cortex. However, it is likely the case that the specific location in posterior cortex depends on what information is being maintained. For instance, if the items being maintained in working memory were objects, then it is likely that the posterior cortex area involved would be inferior temporal cortex. Another difference between FROST and the Monchi et al. () model is that the striatum in FROST is activated by a different population of prefrontal neurons (separate from the working memory maintenance prefrontal population) whereas the same prefrontal neurons are used to activate the striatum and maintain information in Monchi et al. (). As a result, the striatum becomes activated only after the stimulus has disappeared in FROST, whereas the striatum becomes activated as soon as the stimulus appears in Monchi et al. (). These differences between FROST and Monchi et al. () were motivated by recent single-cell recording results reviewed in Ashby et al. (). FROST has been used to reproduce single-cell recordings from many experiments in several brain regions, in addition to accounting for working memory capacity limitation and the relation between memory span and the ability to ignore distracting information (Ashby et al., ).

One common theme of the two previous models is that working memory activity is maintained by closed-loops between the thalamus and prefrontal cortex, and the main role of the BG is to release the thalamus from inhibition and allow for the reverberating activation to take place. However, this view was challenged by Frank et al. () who proposed a model of BG-prefrontal cortex interaction in working memory. Specifically, Frank et al. () argued that in order for the thalamus to contribute to working memory maintenance in the way described by the previous models, it would need to have a dedicated number of cells comparable to the number of cells dedicated to working memory in prefrontal cortex (which is unlikely). Instead, the Frank et al. () model proposes that working memory maintenance is accomplished by reverberating loops between two cell populations within the prefrontal cortex. Similar to Monchi et al. () and FROST (Ashby et al., ), the Frank et al. () model includes the direct pathway through the BG (see Figure [^1]), but the role of the direct pathway is to “turn on the switch” on the prefrontal cortex cells and allow for reverberating activation. The “switch” can only be turned on if the prefrontal cortex cells from one population simultaneously receive activation from the BG and the other prefrontal cortex cell population. Once the switch is “on”, the BG is no longer required for working memory maintenance. The Frank et al. () model has been used to simulate the 1-2-AX task, a working memory task that requires maintenance but also switching and selecting new items (Frank et al., ). Specifically, the 1-2-AX task requires the subject to maintain two cues in working memory in order to correctly select a response to a target sequence. The identity of the target sequence depends on the previous cue, which is used to trigger selection and switching.

One topic that was not addressed by any of the previous models of working memory is learning. How can the brain learn what is important, and what needs to be maintained in working memory? Moustafa and Maida () proposed a computational model of prefrontal cortex and BG interactions that is similar to the Frank et al. () model except that Moustafa and Maida () also simulate: (a) temporal difference learning based on phasic dopamine signaling and (b) more than one corticostriatal loops that are responsible for both motor and cognitive processes. Specifically, the model includes a cortico-striatal motor loop and a cortico-striatal cognitive loop whose functions are action selection (choosing motor responses) and cognitive selection (choosing the perceptual information to be maintained in working memory), respectively. The model can account for the separate roles of the motor and cognitive loops in working memory maintenance, including delayed-response tasks.

Schroll et al. () recently proposed a CCN model of working memory to address the problem of learning complex working memory tasks. The Schroll et al. () model includes two separate BG-thalamocortical closed loops, one through the prefrontal cortex for maintenance and another through motor cortex to produce a response. Only the direct pathways were used for maintenance and response selection, but the hyperdirect pathway was also included in the prefrontal loop as a reset mechanism (see Figure [^1]). Specifically, visual information enters the model through the inferior temporal cortex, which then activates the lateral prefrontal cortex. This activation is transferred through the direct pathway of the BG and releases the thalamus from inhibition, which in turn activates the lateral prefrontal cortex. In the Schroll et al. () model, working memory activation in the prefrontal cortex is maintained by a reverberating activation loop through the direct pathway, so the BG does not only act as a gating mechanism but is part of the maintenance loop (unlike Monchi et al.,; Frank et al.,; Ashby et al., ). At any moment, the prefrontal cortex can activate the STN, which increases activation in the GPi and interrupt working memory maintenance (i.e., the reset mechanism). More importantly, the connectivity between the prefrontal cortex and the striatum and the connections between the prefrontal cortex and the STN are learned using dopamine-mediated reinforcement learning. Hence, the model can automatically adapt and only maintain information that is rewarded in working memory. The model has been used to simulate a delayed response task, a delayed alternation task, and the 1-2-AX task (Schroll et al., ).

#### Synthesis

Working memory is one of the most active areas for CCN modeling of the BG. Five different models were reviewed, each having both commonalities and differences. First, all five models focused on the interaction between the BG and the prefrontal cortex, but only included the direct pathway of the BG for working memory maintenance and response selection. Hence, the neuroanatomy of the BG was not very detailed. Also, all models except Schroll et al. () used the BG as a gating mechanism that turns working memory maintenance “on” or “off”. The main difference is that Monchi et al. () and Ashby et al. () used the BG to gate closed loops between the prefrontal cortex and the thalamus, whereas Frank et al. () and Moustafa and Maida () used the BG to gate closed loop between two populations of prefrontal cortex units. This differs from Schroll et al. () where the BG was not used for gating, but instead was part of the working memory maintenance mechanism itself (i.e., the closed loop went through the BG). In all cases, however, working memory maintenance was achieved by closed loop through the prefrontal cortex.

Another important difference between the models is that the Ashby et al. () and the Moustafa and Maida () models focused on simple maintenance tasks. In contrast, the Monchi et al. (), Frank et al. (), and Schroll et al. () models were able to simulate more complex tasks involving hierarchical structures and switching. Only the Moustafa and Maida () and the Schroll et al. () models include learning mechanisms that allowed for selecting the relevant information that needs to be maintained in working memory. The other models assumed a pre-filtering of the information.

Interestingly, there seems to be a progression and a building up of knowledge related to CCN models of working memory. The Schroll et al. () model is the most recent, and also the most detailed. It is the only model that can learn and simulate complex tasks. However, this model departs from all the others in that the BG is not used as a gating mechanism but is part of the maintenance mechanism. This departure from previous modeling is not extensively discussed in Schroll et al. (), and it is unclear at this point what motivated this departure. More work is needed to determine which of these two roles the BG play in working memory, but the overlap in the models, and the progression in functionality, suggest a steady progress in CCN modeling of working memory.

### Sequence learning

Almost all our everyday behaviors and cognitive activities can be interpreted as a sequence of steps that bring us closer to achieving a goal. One key question is how can we learn to chain these sequences of substeps? Miyachi et al. (, ) have gathered much data suggesting that the BG is important in learning such sequences.

#### Models

Nakahara et al. () formalized Miyachi et al. (, ) findings into a CCN model. According to Nakahara et al. (), sequences are learned in both visual and motor coordinates. The visual sequences are learned by a BG-thalamocortical closed-loop linking the anterior striatum with the dorsolateral prefrontal cortex while motor sequences are learned by a BG-thalamocortical closed-loop linking the posterior striatum with the SMA. Only the direct pathway through the BG is included in each loop (see Figure [^1]), and both the visual and motor loops learn every sequence in parallel using reinforcement learning. The visual loop learns faster than the motor loop, and response coordination between the loops is controlled by the pre-SMA. According to Nakahara et al. (), the visual loop relies on working memory and is important for rapid acquisition of sequences. However, the motor loop is more reliable and produces movement more rapidly after training. As a result, control is gradually transferred from the visual loop to the motor loop in the Nakahara et al. () model. The Nakahara et al. () model has been used to account for: (1) the time course of learning (including single-cell recordings and lesion studies); (2) the effect of opposite hand use; (3) the effect of sequence reversal; and (4) the change in brain locus from early to late sequence production (Nakahara et al., ).

#### Synthesis

The Nakahara et al. () model is interesting for several reasons. First, it successfully accounts for lesion data, single-cell recordings, and behavioral phenomena. In addition, the transition from a visual loop to a motor loop represents an early attempt at bridging the gap between cognitive and motor functions of the BG. However, a recent study by Desmurget and Turner () challenges the generality of the Nakahara et al. () model. Specifically, Desmurget and Turner () had monkeys perform a sequence of visually-cued joystick movements aimed at moving a cursor into a pre-determined part of a computer screen. After some training, muscimol was injected into the motor segment of the GPi to functionally disconnect the BG from the frontal cortex. The results show that the kinematics of the movements were impaired, but not sequence knowledge. Desmurget and Turner () interpreted these results as suggesting that the BG contributes to motor execution in automatic sequence production, but not to the motor sequencing or the storage of the overlearned sequence. This result is problematic for the Nakahara et al. () model.

### Automaticity

Automaticity results from overtraining in a task until performance requires little attentional resources and becomes highly rigid (Helie et al.,; Helie and Cousineau, ). Many computational models of automaticity development have assigned a role for the BG.

#### Models

First, in the Nakahara et al. () model of sequence learning (above), automaticity in sequence production is characterized by a gradual transfer from the visual loop (which learns sequences in visual coordinates) to the motor loop (which learns sequences in motor coordinates). This corresponds well with the results of Miyachi et al. (, ), who showed using single-cell recordings that task-sensitive cells in early learning are mostly located in the anterior striatum whereas selective cells in late sequence production are mostly located in the posterior striatum (Miyachi et al., ). This specialization of the striatum is further supported by inactivation studies where muscimol (a GABA agonist) was injected in different parts of the striatum in early and late sequence production. Well-learned sequence production was selectively disrupted by muscimol injection in the middle-posterior putamen while early sequence production was selectively disrupted by muscimol injection in the anterior caudate and putamen (Miyachi et al., ).

However, a recent study by Desmurget and Turner () challenges the generality of the Nakahara et al. () model. Specifically, injecting muscimol into the motor segment of the GPi to functionally disconnect the BG from the frontal cortex affects the kinematics of the movements but not sequence knowledge. These results suggest that the BG contributes to motor execution in automatic sequence production, but not to the motor sequencing or the storage of the overlearned sequence. Interestingly, the results of Desmurget and Turner () are consistent with a neurobiological model of automaticity in perceptual categorization (SPEED) (Ashby et al., ). SPEED uses the procedural system of COVIS (Ashby et al., ) (i.e., the direct pathway of an opened loop between posterior cortex and premotor areas) but also includes a Hebbian learning mechanism between posterior cortex and premotor areas. The role of the BG in SPEED is to learn to produce the correct categorization responses early in training to ensure that the correct motor plan in the premotor areas is consistently activated shortly after the visual representation in associative cortex (using dopamine-mediated reinforcement learning). This consistent association between associative and premotor cortical activity triggers Hebbian learning between associative cortex (stimulus) and the premotor areas (response), and the direct cortico-cortical connections eventually become strong enough so that the BG is no longer required to produce a response. When responding becomes purely cortical, the skill is said to be “automatic” \[note that this is different from Nakahara et al. (), in which the posterior striatum is still required for automatic sequence production\]. SPEED has been used to simulate single-cell recordings data in many categorization experiments, as well as human reaction times and accuracies in categorization (Ashby et al.,; Helie and Ashby, ).

While the Hikosaka et al. () and SPEED models can account for how behavior becomes automatic, they cannot account for how automatic responses are overridden by goal-directed behavior when needed (e.g., when the stimulus—response associations change). Chersi et al. () proposed a computational model of automaticity in instrumental conditioning that can account for the change back to goal-directed behavior when needed. The Chersi et al. () model includes the prefrontal cortex (for goal representation), the motor cortex (for action representation), the sensory cortex (for stimulus representation), the BG (for action selection), and the thalamus (to relay information between the BG and the motor cortex). Two sets of connections are plastic: (1) connections from the prefrontal cortex to the motor cortex (to learn goal—response associations) and (2) connections from the sensory cortex to the striatum (to learn stimulus—response associations). According to this model, the stimulus activates the sensory cortex, which in turn activates a goal in prefrontal cortex and action representations in the striatum. For automatic behavior, the striatal activation propagates through both the direct and indirect pathways (see Figure [^1]) of the BG and an action is selected by inhibiting all but one action at the output level (SNr, but it is functionally equivalent to the GPi shown in Figure [^1]). The action that is not inhibited activates the appropriate response in motor cortex (through the thalamus). For goal-directed behaviors, the prefrontal activation propagates to the appropriate action in motor cortex. When an automatic action needs to be overwritten by a goal-directed behavior, the prefrontal cortex sends activation to the STN, which hyperpolarizes the SNr and prevents the BG from controlling the motor response (Chersi et al., ). The model has been successfully used to account for the development of automaticity in an instrumental conditioning task and the reversal of stimulus—response associations after automaticity had developed (Chersi et al., ).

#### Synthesis

The Nakahara et al. () and the Chersi et al. () models both assign the role of producing automatic behavior to the BG. However, this “classic” role of the BG in automaticity is difficult to reconcile with the Desmurget and Turner () data. As an alternative, SPEED (Ashby et al., ) also assigns an important role to the BG in automaticity, but this role is restricted to training automatic cortico-cortical projections that can account for automaticity. Simply put, the BG is required to learn automatic behaviors, but the BG is no longer required to produce automatic behaviors once the cortico-cortical connectivity is sufficiently strong. The SPEED model can account for the Desmurget and Turner () data, but it includes only the direct pathway of one loop through the BG. In contrast, the Nakahara et al. () model includes two loops through the BG (only the direct pathways) and the Chersi et al. () model includes both the direct and indirect pathways, but only one loop through the BG (similar to SPEED). In addition to being the most biologically detailed, the Chersi et al. () model is the only reviewed model that can override automatic behavior using goal-directed behavior. This is an important function that was not accounted for by the previous models. However, like the Nakahara et al. () model, the Chersi et al. () model cannot account for the Desmurget and Turner () data. To summarize, each one of these models was designed to account for a different aspect of automatic behavior, and successfully accounts for the aspect of automaticity for which it was designed. The next step is to explore how each one of these candidate models can account for the missing function/data that was the focus of the other candidate models.

## Motor function

This section describes motor functions that have been attributed to the BG and that have been simulated using CCN models. Hence, computational models that focus only on modeling biological data or motor function (e.g., kinematics) were not included. Similar to the section reviewing cognitive functions above, the model descriptions are conceptual, in that implementation details and formalities are not discussed. The reader is referred to the cited original papers for details and equations. Table [^2] summarizes the reviewed models along with their respective components.

### Reaching

The BG has been implicated in reaching movements for many years (for a review, see Bischoff, ). Not surprisingly, PD patients show unmistakable changes in reaching movements, which can be used for diagnostic purposes (Brown and Jahanshahi, ). Simple reaching movements in PD patients show longer reaction times and movement times than normal controls. This reduced movement speed seen in PD reaching is called bradykinesia. From a physiological perspective, a typical reaching movement under normal conditions consists of a sequence of agonist-antagonist bursts. In contrast, a PD reaching movement is generally multi-staged and involves multiple agonist bursts. Furthermore, PD reaching movements have greater variability of hand position for larger movements (Sheridan and Flowers, ). PD patients also show impairment in sequential movements (Weiss et al., ). For example, during movements aimed at reaching a glass of water, PD patients exhibit an inordinately long pause between the reaching and retrieval of the glass.

#### Models

Several computational models relating dopamine deficiencies to impaired reaching movements have been proposed. One of the first models of PD reaching movements is the model of Bischoff (). Bischoff () model includes the prefrontal cortex (for working memory/learning), the SMA (for sequence generation), the pre-SMA (for sequence preparation), motor cortex (for movement parameters), the thalamus (to filter information from the BG to cortex), and the BG. The BG model assigns complementary roles to the direct and indirect pathways (see Figure [^1]). According to Bischoff (), the role of the direct pathway is to inform the motor cortex of the movement’s next sensory state, while the role of the indirect pathway is to inhibit competing movements. The function of dopamine is to keep the balance between the two pathways, which is impaired in PD. The Bischoff () model was used to simulate the reciprocal aiming task, a task where subjects are asked to alternatively tap a stylus between two targets as quickly as possible. Reducing the dopamine levels in the simulation reproduced bradykinesia and the exaggerated pauses in sequential movements observed in PD.

Magdoom et al. () also proposed a model of the role of the BG in PD reaching movements. The model is cast in the framework of reinforcement learning and focuses on interactions between the motor cortex and the BG. The Magdoom et al. () model uses the classical interpretations of BG pathways according to which the direct pathway facilitates movement, (i.e., the “Go” pathway), while the indirect pathway inhibits movements (i.e., the “NoGo” pathway). Switching between the two pathways is thought to be driven by striatal dopamine levels. However, Magdoom et al. () also deviate from the classical “Go”/“NoGo” model of the BG by adding an intermediate regime called the *explore* regime. The explore regime is used to control the stochasticity of action selection when the gradient is absent or too weak to allow for reinforcement learning. The indirect pathway is proposed to be the substrate supporting the explore regime. Simulations show that under dopamine-deficient conditions of PD, the model spends less time in the “Go” regime while spending more time in the remaining two regimes. These regime changes were used to account for a variety of features of impaired reaching movements in PD including movement undershoot (Van Gemmert et al., ), bradykinesia, and increased path variability (Sheridan and Flowers, ).

#### Synthesis

Two models that highlight the role of the BG in reaching were reviewed. The Bischoff () model includes, in addition to the BG, cortical areas such as prefrontal areas, the SMA and the pre-SMA. The model captures bradykinesia and abnormal pauses in sequential movements under Parkinsonian conditions. The reaching model of Magdoom et al. () also incorporates the BG and the motor cortex. However, the Magdoom et al. () model is cast in the framework of reinforcement learning, whereas there is no learning in the Bischoff () model. Focus on learning makes the Magdoom et al. () model consistent with the proposed role of BG in error correction (Lawrence, ). As a result, the Magdoom et al. () model is more general and is consistent with the view that a wide range of BG functions can be explained within the framework of reinforcement learning (Chakravarthy et al., ). The compatibility of the Magdoom et al. () model with other CCN models of BG function may facilitate integration to achieve a more complete model of BG function.

### Handwriting

Handwriting is a fine motor skill. PD patients often exhibit an impaired form of handwriting, known as micrographia, characterized by reduced letter size, a “kinky” handwriting contour, and abnormal fluctuations in velocity and acceleration (Teulings and Stelmach,; Van Gemmert et al.,; Gangadhar et al., ). As a result, handwriting features like stroke size, peak acceleration, and stroke duration have been attributed to the BG and used for diagnosis of PD (Phillips et al.,; Van Gemmert et al., ).

#### Models

Although models of PD handwriting are scanty, extensive work has been done on modeling handwriting generation. One of the earliest insights into modeling handwriting consisted of performing a Fourier-like resolution of handwriting into oscillatory components (Hollerbach, ). This notion has led to the development of oscillatory or spiking neural network models of handwriting generation that can be trained to produce single characters (Schomaker,; Kalveram, ). However, the models of Schomaker () and Kalveram () suffered from the absence of a plausible procedure for initializing the phases of neural oscillators, a difficulty that was solved in an oscillatory neural network model of handwriting generation proposed by Gangadhar et al. ().

While the above-described models did not explicitly include the BG, Gangadhar et al. () combined the Gangadhar et al. () handwriting generation model with a model of the BG. Similar to handwriting patterns observed in PD patients, the Gangadhar et al. () model exhibits micrographia under conditions of reduced dopamine. Another significant feature of the model is the role of the dynamics of the STN and the GPe, which are connected as a loop to produce complex oscillations. Under pathological conditions, the oscillations of the STN and the GPe in the model are highly correlated, resembling the correlated neural firing from STN and GPe neurons under dopamine-deficient conditions observed in real electrophysiology experiments (Bergman et al.,; Brown et al., ). Under the influence of correlated oscillations of STN and GPe, the Gangadhar et al. () model produces handwriting with large fluctuations in velocity in addition to diminutive letter size.

As another example, Contreras-Vidal and Stelmach () attached a BG model to the VITE-WRITE model (Bullock et al., ) to simulate PD handwriting. The Contreras-Vidal and Stelmach () model includes the direct, indirect, and hyperdirect pathways of the BG (see Figure [^1]), the SMA, and other motor and premotor areas. The role of the SMA is to read-in the next motor subprogram from the movement plan, while the role of the other motor and premotor areas is to produce the movement selected by the SMA. The role of the BG is to modulate the dynamics of the formation of movement trajectories (produced by VITE-WRITE). Reducing dopamine in the model to simulate PD results in reduced letter size, as observed in PD patients.

#### Synthesis

Two models of PD handwriting were reviewed above. The model of Contreras-Vidal and Stelmach () combines the VITE-WRITE model (Bullock et al., ) with a BG model. The essence of the model consists of showing that dopamine reduction in PD causes an imbalance in the outputs of the direct and indirect pathways. Although constructed out of considerably different modeling components, the model of Gangadhar et al. () also shows an imbalance in the activations of the direct and indirect pathways under simulated PD conditions, which causes a reduction in letter size. In addition, Gangadhar et al. () also account for the oscillations in STN-GPe interaction. Loss of complexity in these oscillations under PD conditions were linked to higher velocity fluctuations and distorted handwriting contour in PD handwriting. To summarize, the indirect pathway appears to be critical in accounting for handwriting.

### Eye saccades

Eye saccades are rapid, darting eye movements that shift the fovea to points of interest in the visual scene. There is an extensive cortical and subcortical network that is responsible for saccade generation, and the BG play a key role among the subcortical substrates for saccade generation (Hikosaka et al., ). The influence of BG on saccades is propagated via the superior colliculus, a midbrain nucleus with a central role in saccade generation (not shown in Figure [^1]). Studies on Parkinsonian monkeys prepared by MPTP (a neurotoxin used to destroy dopaminergic neurons) infusion have observed prolonged saccades, longer reaction times, smaller peak velocities, and smaller amplitudes (Kato et al., ). Smaller peak velocities and smaller amplitudes in PD saccades may be comparable to bradykinesia and hypometria found in PD reaching movements. Similarly, analogous to PD tremor in extremities, some PD patients exhibit square-wave jerks in visually guided saccades (Rascol et al., ).

#### Models

Computational modeling literature that specifically focuses on the role of BG in saccade generation is rather limited. Dominey and Arbib () proposed a model of the role of the BG in sequential saccade generation. Their model includes a number of relevant neural substrates such as the superior colliculus, thalamus, frontal eye fields, and the BG. In the Dominey and Arbib () model, the BG is used as an indirect link between the frontal eye field and the superior colliculus, and its main function is to prevent saccades while a target stimulus is foveated. As such, only the direct pathway through the BG is modeled. The Dominey and Arbib () model has been used to simulate simple saccade data, memory saccade data, double saccade data, compensatory saccade data, and lesion data.

Two decades later, Krishnan et al. () proposed a model of the role of the BG in saccade generation using the principle of reinforcement learning. Similar to their model of PD reaching movement (Magdoom et al., ), the indirect pathway serves as an explorer that drives the saccades toward more rewarding targets. The model was able to successfully simulate two forms of visual search, namely feature search and conjunction search, a sequential saccade task, and a directional saccade task. When PD-related changes were incorporated in the model by reducing BG output, the model exhibited increased search times (Krishnan et al., ).

#### Synthesis

Two models of the role of BG in saccade generation were reviewed above (Dominey and Arbib,; Krishnan et al., ). Both models can account for a range of saccade data in normal and lesioned/pathological conditions. The anatomical components incorporated by the two models are also quite similar. However, there are two main distinguishing features between the two models. One of these features is anatomical: the Dominey and Arbib () model does not include the indirect pathway in the BG, whereas the indirect pathway plays a key role in the Krishnan et al. () model. The second feature is functional: the Dominey and Arbib () model does not involve learning, while that of Krishnan et al. () model is based on reinforcement learning. These key differences make the Krishnan et al. () model more biologically and functionally detailed.

## General discussion

This article presented a review of CCN models of cognitive and motor functions. The 19 reviewed models were organized to highlight BG functionality and classified according to six cognitive functions (i.e., categorization, instrumental conditioning, probabilistic learning, working memory, sequence learning, and automaticity) and three motor functions (i.e., reaching, handwriting, and visual saccades). On the one hand, some of the reviewed models are standalone models of specific functions of BG, e.g., the reaching model of Bischoff (). On the other hand, there are models that are specific instances of a more general learning framework applied to BG function. COVIS (Ashby et al.,,; Ashby and Crossley, ), and the models of Chakravarthy and colleagues (Krishnan et al.,; Magdoom et al., ) belong to the second category. For example, both the models of Krishnan et al. () and Magdoom et al. () used a nearly identical reinforcement learning-based approach to account for the specific motor functions of reaching and saccade generation. A review article by Chakravarthy et al. () proposes that an expanded framework based on reinforcement learning, adapted to BG anatomy and physiology, can be used to explain a wide variety of BG functions. Such a proposal needs a more extensive modeling and experimental investigation for further confirmation. However, interestingly, CCN models accounting for more than one function were accounting for more than one cognitive function or more than one motor function. None of the reviewed CCN models could account for at least one motor and one cognitive function simultaneously. This may be a serious limitation as behavioral experiments are beginning to reveal important interactions between motor and cognitive processes. Below, we discuss how cognitive processes might impact motor function, and point to novel directions for computational modeling studies.

### Interaction of motor and cognitive processes

While none of the models included simultaneously accounted cognitive and motor functions, they all had a cognitive and motor component. For example, the Ashby and Crossley () model made a cognitive decision, but it also included premotor areas associated with the response. It just did not include a detailed model of the motor response (e.g., how is the left button pressed). Likewise, the Gangadhar et al. () has to include a cognitive component specifying what character is to be drawn. However, the focus is on how the movement is produced. Perhaps the model that comes closest to integrating motor and cognitive functions is the model of Guthrie et al. (). In this model, both a cognitive and a motor decision are taken, and the interaction between these decisions is accounted for. However, this model does not include a detailed simulation of how the movement is produced. Therefore, it was only discussed in the context of cognitive function.

One way to explore how cognitive and motor functions interact is to explore disease states. For example, akinesia and bradykinesia in PD are arguably associated with BG (and corticostriatal circuits) dysfunction, while tremor is perhaps associated with cerebellar, thalamic, and STN abnormalities (Kassubek et al.,; Probst-Cousin et al.,; Weinberger et al.,; Zaidel et al.,; Mure et al., ). For example, Schillaci et al. () found that PD patients with akinesia and rigidity as the predominant symptoms have significantly more widespread dopamine loss in the striatum than PD patients with tremor as the predominant symptom. Because these different brain areas (e.g., striatum, cerebellum) are also involved in different cognitive functions, it is reasonable to hypothesize that different PD motor symptoms may be associated with different cognitive impairments. Accordingly, Jankovic et al. () found that PD patients with predominant tremor are less cognitively impaired than patients with bradykinesia. Below we explore some specific PD motor symptoms and their relation to cognition.

#### Akinesia

Experimental studies have shown that PD patients with severe akinesia are generally more cognitively impaired than PD patients with predominant tremor (Vakil and Herishanu-Naaman,; Poletti et al.,,; Poletti and Bonuccelli, ). For instance, PD patients with severe akinesia and rigidity symptoms are more impaired than PD patients with severe resting tremor at working memory tasks (Moustafa et al., ). Likewise, studies have shown that PD patients with tremor are usually less cognitively impaired than PD patients with akinesia or gait dysfunction (Burn et al.,; Lyros et al.,; Oh et al.,; Domellof et al., ). For example, Vakil and Herishanu-Naaman () found that tremor-dominant PD patients are less impaired at procedural learning than akinesia-dominant PD patients.

Most motor models of the BG and corticostriatal circuit function have been able to explain the occurrence of akinesia and bradykinesia, but not tremor (Obeso et al., ). We suggest that motor performance may rely on cognitive processes in two different ways: (a) maintenance of motor plans in working memory while performing a sequence of movements, such as hand/leg movement, grasping, or reaching (Hayhoe et al.,; Ohbayashi et al.,; Piek et al.,; Issen and Knill, ); or (b) maintenance of goals in working memory while performing a motor act, such as maintaining the goal of grasping the cup in working memory while moving the hands (Batuev,; McIntyre et al.,; Matsumoto et al., ). This relationship between cognitive and motor processes could explain why some cognitive training programs are effective at treating motor dysfunction in PD patients (Disbrow et al., ). Although this is speculative, computational models are needed to explicitly study the complex relationship between motor and cognitive processes in healthy subjects and PD patients.

#### Freezing of gait

Freezing of gait—paroxysmal cessation of motor output—is a common symptom in advanced PD (Hoehn and Yahr stage 2+) (Giladi et al., ). Freezing of gait is debilitating since it often leads to falls and, importantly, is not manageable by common psychopharmacological medications (Giladi et al.,; Matar et al., ).

Research shows that perceptual and cognitive factors play a role in successful locomotion and the occurrence of freezing of gait episodes in PD patients (Lewis and Barker,; Naismith et al.,; Matar et al., ). For example, providing auditory or visual cues or instructions can often reduce the occurrence of freezing behavior in PD patients (Lewis and Barker, ). Other studies found that walking dysfunction in PD is related to difficulty in resolving response interference produced by distractors (Plotnik et al.,; Vandenbossche et al., ). Locomotive dysfunction in PD is associated with brain volume changes (Kostic et al.,; Tessitore et al., ) and aberrant neural activity within the prefrontal cortex (Matsui et al.,; Shine et al., ), suggesting a role for cognitive processes in locomotion.

There are currently no computational models that simulate the role of cognitive processes in the occurrence of freezing of gait in PD patients. Prior computational models of BG-cortex interactions have focused on the simulation of cognitive processes (O’Reilly and Frank, ), learning, or simple action selection in static environments (Gurney et al., ) without considering how cognitive factors might affect motor actions such as locomotion. Future models should simulate how the cortex represents multiple inputs (including perceptual and cognitive) that feed into the BG, which is important for action selection (e.g., move right, left, forward, etc.). Future models should also be more dynamical in that they should continuously receive and update perceptual input from the environment and produce motor output (step right, left, …), which then takes the model to a new perceptual input, and so forth.

### What is the role of the basal ganglia in cognitive and motor function?

In addition to the current unavailability of CCN models of the BG that can simultaneously account for cognitive and motor function, another limitation of the current state of BG modeling is the absence of consensus on the specific function of the BG in a given task. For example, many CCN models of working memory assign a role for the BG, but some models use the BG as a gating mechanism allowing for thalamo-cortical loops (e.g., Monchi et al.,; Ashby et al., ), while others use the BG as a gating mechanism for cortico-cortical loops (e.g., Frank et al., ) or as the actual maintenance mechanism (Schroll et al., ). As with many other cognitive and motor functions, CCN models are critical in pinpointing the specific function of the BG in the cognitive task (e.g., working memory). Computational models can be simulated to identify the consequences of different design choices, and these predictions need to be tested empirically. While models tend to do very well at simulating the function that motivated the model, it is unclear at this point how the model can handle other (different) functions. One way to select useful BG CCN models is to consider generalization capabilities. Towards this end, general integrative frameworks are most useful. For example, the reinforcement learning approach of Chakravarthy and colleagues (Krishnan et al.,; Magdoom et al., ) or the COVIS-based approach of Ashby and colleagues (Ashby et al.,; Apicella,; Ashby and Crossley, ) are useful because they have been used to account for functions that were outside of the original scope of the model. Other models of cognitive and motor functions need to be generalized to account for data for which they were not originally designed to build biological “cognitive architectures”. Frameworks that are already general should attempt to bridge the gap between CCN models of cognitive function and CCN models of motor function. This could be achieved by integrating existing models. For example, a detailed CCN model of motor function could be added to the COVIS framework. Likewise, a detailed CCN model of cognitive function could be added to the reinforcement-learning-based approach of Chakravarthy and colleagues. While more data will help in eliminating some of the candidate CCN BG models, generalization and integration will be required to avoid overfitting the model to the available data.

## Statements

### Conflict of interest

The authors declare that the research was conducted in the absence of any commercial or financial relationships that could be construed as a potential conflict of interest.

## References

- 1
	ApicellaP. (2007). Leading tonically active neurons of the striatum from reward detection to context recognition. *Trends Neurosci.*30, 299–306. 10.1016/j.tins.2007.03.011
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/17420057)
	- [CrossRef](https://doi.org/10.1016/j.tins.2007.03.011)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=P..%2BApicella&publication_year=2007&title=Leading%2Btonically%2Bactive%2Bneurons%2Bof%2Bthe%2Bstriatum%2Bfrom%2Breward%2Bdetection%2Bto%2Bcontext%2Brecognition&journal=Trends+Neurosci.&volume=30&pages=299-306)
- 2
	AshbyF. G.Alfonso-ReeseL. A.TurkenA. U.WaldronE. M. (1998). A neuropsychological theory of multiple systems in category learning. *Psychol. Rev.*105, 442–481. 10.1037//0033-295x.105.3.442
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/9697427)
	- [CrossRef](https://doi.org/10.1037//0033-295x.105.3.442)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=F.%2BG..%2BAshby&author=L.%2BA..%2BAlfonso-Reese&author=A.%2BU..%2BTurken&author=E.%2BM..%2BWaldron&publication_year=1998&title=A%2Bneuropsychological%2Btheory%2Bof%2Bmultiple%2Bsystems%2Bin%2Bcategory%2Blearning&journal=Psychol.+Rev.&volume=105&pages=442-481)
- 3
	AshbyF. G.CrossleyM. J. (2011). A computational model of how cholinergic interneurons protect striatal-dependent learning. *J. Cogn. Neurosci.*23, 1549–1566. 10.1162/jocn.2010.21523
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/20521851)
	- [CrossRef](https://doi.org/10.1162/jocn.2010.21523)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=F.%2BG..%2BAshby&author=M.%2BJ..%2BCrossley&publication_year=2011&title=A%2Bcomputational%2Bmodel%2Bof%2Bhow%2Bcholinergic%2Binterneurons%2Bprotect%2Bstriatal-dependent%2Blearning&journal=J.+Cogn.+Neurosci.&volume=23&pages=1549-1566)
- 4
	AshbyF. G.EllS. W.ValentinV. V.CasaleM. B. (2005). FROST: a distributed neurocomputational model of working memory maintenance. *J. Cogn. Neurosci.*17, 1728–1743. 10.1162/089892905774589271
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/16269109)
	- [CrossRef](https://doi.org/10.1162/089892905774589271)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=F.%2BG..%2BAshby&author=S.%2BW..%2BEll&author=V.%2BV..%2BValentin&author=M.%2BB..%2BCasale&publication_year=2005&title=FROST%3A%2Ba%2Bdistributed%2Bneurocomputational%2Bmodel%2Bof%2Bworking%2Bmemory%2Bmaintenance&journal=J.+Cogn.+Neurosci.&volume=17&pages=1728-1743)
- 5
	AshbyF. G.EllS. W.WaldronE. M. (2003). Procedural learning in perceptual categorization. *Mem. Cognit.*31, 1114–1125. 10.3758/bf03196132
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/14704026)
	- [CrossRef](https://doi.org/10.3758/bf03196132)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=F.%2BG..%2BAshby&author=S.%2BW..%2BEll&author=E.%2BM..%2BWaldron&publication_year=2003&title=Procedural%2Blearning%2Bin%2Bperceptual%2Bcategorization&journal=Mem.+Cognit.&volume=31&pages=1114-1125)
- 6
	AshbyF. G.EnnisJ. M.SpieringB. J. (2007). A neurobiological theory of automaticity in perceptual categorization. *Psychol. Rev.*114, 632–656. 10.1037/0033-295x.114.3.632
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/17638499)
	- [CrossRef](https://doi.org/10.1037/0033-295x.114.3.632)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=F.%2BG..%2BAshby&author=J.%2BM..%2BEnnis&author=B.%2BJ..%2BSpiering&publication_year=2007&title=A%2Bneurobiological%2Btheory%2Bof%2Bautomaticity%2Bin%2Bperceptual%2Bcategorization&journal=Psychol.+Rev.&volume=114&pages=632-656)
- 7
	AshbyF. G.GottR. E. (1988). Decision rules in the perception and categorization of multidimensional stimuli. *J. Exp. Psychol. Learn. Mem. Cogn.*14, 33–53. 10.1037/0278-7393.14.1.33
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/2963894)
	- [CrossRef](https://doi.org/10.1037/0278-7393.14.1.33)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=F.%2BG..%2BAshby&author=R.%2BE..%2BGott&publication_year=1988&title=Decision%2Brules%2Bin%2Bthe%2Bperception%2Band%2Bcategorization%2Bof%2Bmultidimensional%2Bstimuli&journal=J.+Exp.+Psychol.+Learn.+Mem.+Cogn.&volume=14&pages=33-53)
- 8
	AshbyF. G.HelieS. (2011). A tutorial on computational cognitive neuroscience: modeling the neurodynamics of cognition. *J. Math. Psychol.*55, 273–289. 10.1016/j.jmp.2011.04.003
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/21841845)
	- [CrossRef](https://doi.org/10.1016/j.jmp.2011.04.003)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=F.%2BG..%2BAshby&author=S..%2BHelie&publication_year=2011&title=A%2Btutorial%2Bon%2Bcomputational%2Bcognitive%2Bneuroscience%3A%2Bmodeling%2Bthe%2Bneurodynamics%2Bof%2Bcognition&journal=J.+Math.+Psychol.&volume=55&pages=273-289)
- 9
	AssadiS. M.YucelM.PantelisC. (2009). Dopamine modulates neural networks involved in effort-based decision-making. *Neurosci. Biobehav. Rev.*33, 383–393. 10.1016/j.neubiorev.2008.10.010
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/19046987)
	- [CrossRef](https://doi.org/10.1016/j.neubiorev.2008.10.010)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=S.%2BM..%2BAssadi&author=M..%2BYucel&author=C..%2BPantelis&publication_year=2009&title=Dopamine%2Bmodulates%2Bneural%2Bnetworks%2Binvolved%2Bin%2Beffort-based%2Bdecision-making&journal=Neurosci.+Biobehav.+Rev.&volume=33&pages=383-393)
- 10
	BatuevA. S. (1989). Neuronal mechanisms of goal-directed behaviour in monkeys. *Int. J. Neurosci.*44, 59–66. 10.3109/00207458908986183
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/2518573)
	- [CrossRef](https://doi.org/10.3109/00207458908986183)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=A.%2BS..%2BBatuev&publication_year=1989&title=Neuronal%2Bmechanisms%2Bof%2Bgoal-directed%2Bbehaviour%2Bin%2Bmonkeys&journal=Int.+J.+Neurosci.&volume=44&pages=59-66)
- 11
	BergmanH.WhichmanT.KarmonB.DeLongM. R. (1994). The primate subthalamic nucleus. II. neural activity in MPTP model of Parkinsonism. *J. Neurophysiol.*72, 507–520.
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=H..%2BBergman&author=T..%2BWhichman&author=B..%2BKarmon&author=M.%2BR..%2BDeLong&publication_year=1994&title=The%2Bprimate%2Bsubthalamic%2Bnucleus.%2BII.%2Bneural%2Bactivity%2Bin%2BMPTP%2Bmodel%2Bof%2BParkinsonism&journal=J.+Neurophysiol.&volume=72&pages=507-520)
- 12
	BernheimerH.BirkmayerW.HornykiewiczO.JellingerK.SeitelbergerF. (1973). Brain dopamine and the syndromes of Parkinson and huntington clinical, morphological and neurochemical correlations. *J. Neurol. Sci.*20, 415–455. 10.1016/0022-510x(73)90175-5
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/4272516)
	- [CrossRef](https://doi.org/10.1016/0022-510x\(73\)90175-5)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=H..%2BBernheimer&author=W..%2BBirkmayer&author=O..%2BHornykiewicz&author=K..%2BJellinger&author=F..%2BSeitelberger&publication_year=1973&title=Brain%2Bdopamine%2Band%2Bthe%2Bsyndromes%2Bof%2BParkinson%2Band%2Bhuntington%2Bclinical%2C%2Bmorphological%2Band%2Bneurochemical%2Bcorrelations&journal=J.+Neurol.+Sci.&volume=20&pages=415-455)
- 13
	BischoffA. (1998). *Modeling the Basal Ganglia in the Control of Arm Movements*. Doctoral Dissertation, University of Southern California.
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=A..%2BBischoff&publication_year=1998&journal=Modeling+the+Basal+Ganglia+in+the+Control+of+Arm+Movements)
- 14
	BrownP.OliveroA.MazzoneP.InsolaA.TonaliP.LazzaroV. D. (2001). Dopamine dependency of oscillations in between subthalamic neucleus and pallidum in Parkinson’s disease. *J. Neurosci.*21, 1033–1038.
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/11157088)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=P..%2BBrown&author=A..%2BOlivero&author=P..%2BMazzone&author=A..%2BInsola&author=P..%2BTonali&author=V.%2BD..%2BLazzaro&publication_year=2001&title=Dopamine%2Bdependency%2Bof%2Boscillations%2Bin%2Bbetween%2Bsubthalamic%2Bneucleus%2Band%2Bpallidum%2Bin%2BParkinson%E2%80%99s%2Bdisease&journal=J.+Neurosci.&volume=21&pages=1033-1038)
- 15
	BrownR. G.JahanshahiM. (1996). Cognitive-motor function in Parkinson’s disease. *Eur. Neurol.*36, 24–31. 10.1159/000118880
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/8791018)
	- [CrossRef](https://doi.org/10.1159/000118880)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=R.%2BG..%2BBrown&author=M..%2BJahanshahi&publication_year=1996&title=Cognitive-motor%2Bfunction%2Bin%2BParkinson%E2%80%99s%2Bdisease&journal=Eur.+Neurol.&volume=36&pages=24-31)
- 16
	BullockD.GrossbergS.MannesC. (1993). A neural network model for cursive script production. *Biol. Cybern.*70, 15–28. 10.1007/bf00202562
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/PUBMED::UNDEFINED)
	- [CrossRef](https://doi.org/10.1007/bf00202562)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=D..%2BBullock&author=S..%2BGrossberg&author=C..%2BMannes&publication_year=1993&title=A%2Bneural%2Bnetwork%2Bmodel%2Bfor%2Bcursive%2Bscript%2Bproduction&journal=Biol.+Cybern.&volume=70&pages=15-28)
- 17
	BurnD. J.RowanE. N.AllanL. M.MolloyS.O’BrienJ. T.McKeithI. G. (2006). Motor subtype and cognitive decline in Parkinson’s disease, Parkinson’s disease with dementia and dementia with Lewy bodies. *J. Neurol. Neurosurg. Psychiatry* 77, 585–589. 10.1136/jnnp.2005.081711
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/16614017)
	- [CrossRef](https://doi.org/10.1136/jnnp.2005.081711)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=D.%2BJ..%2BBurn&author=E.%2BN..%2BRowan&author=L.%2BM..%2BAllan&author=S..%2BMolloy&author=J.%2BT..%2BO%E2%80%99Brien&author=I.%2BG..%2BMcKeith&publication_year=2006&title=Motor%2Bsubtype%2Band%2Bcognitive%2Bdecline%2Bin%2BParkinson%E2%80%99s%2Bdisease%2C%2BParkinson%E2%80%99s%2Bdisease%2Bwith%2Bdementia%2Band%2Bdementia%2Bwith%2BLewy%2Bbodies&journal=J.+Neurol.+Neurosurg.+Psychiatry&volume=77&pages=585-589)
- 18
	CalzavaraR.MaillyP.HaberS. N. (2007). Relationship between the corticostriatal terminals from areas 9 and 46 and those from area 8A, dorsal and rostral premotor cortex and area 24c: an anatomical substrate for cognition to action. *Eur. J. Neurosci.*26, 2005–2024. 10.1111/j.1460-9568.2007.05825.x
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/17892479)
	- [CrossRef](https://doi.org/10.1111/j.1460-9568.2007.05825.x)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=R..%2BCalzavara&author=P..%2BMailly&author=S.%2BN..%2BHaber&publication_year=2007&title=Relationship%2Bbetween%2Bthe%2Bcorticostriatal%2Bterminals%2Bfrom%2Bareas%2B9%2Band%2B46%2Band%2Bthose%2Bfrom%2Barea%2B8A%2C%2Bdorsal%2Band%2Brostral%2Bpremotor%2Bcortex%2Band%2Barea%2B24c%3A%2Ban%2Banatomical%2Bsubstrate%2Bfor%2Bcognition%2Bto%2Baction&journal=Eur.+J.+Neurosci.&volume=26&pages=2005-2024)
- 19
	ChakravarthyV.JosephD.BapiR. S. (2010). What do the basal ganglia do? A modeling perspective. *Biol. Cybern.*103, 237–253. 10.1007/s00422-010-0401-y
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/20644953)
	- [CrossRef](https://doi.org/10.1007/s00422-010-0401-y)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=V..%2BChakravarthy&author=D..%2BJoseph&author=R.%2BS..%2BBapi&publication_year=2010&title=What%2Bdo%2Bthe%2Bbasal%2Bganglia%2Bdo%3F%2BA%2Bmodeling%2Bperspective&journal=Biol.+Cybern.&volume=103&pages=237-253)
- 20
	ChersiF.MirolliM.PezzuloG.BaldassarreG. (2013). A spiking model of the cortico-basal ganglia circuits for goal-directed and habitual action learning. *Neural Netw.*41, 212–224. 10.1016/j.neunet.2012.11.009
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/23266482)
	- [CrossRef](https://doi.org/10.1016/j.neunet.2012.11.009)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=F..%2BChersi&author=M..%2BMirolli&author=G..%2BPezzulo&author=G..%2BBaldassarre&publication_year=2013&title=A%2Bspiking%2Bmodel%2Bof%2Bthe%2Bcortico-basal%2Bganglia%2Bcircuits%2Bfor%2Bgoal-directed%2Band%2Bhabitual%2Baction%2Blearning&journal=Neural+Netw.&volume=41&pages=212-224)
- 21
	Contreras-VidalJ.StelmachG. (1995). A neural model of basal ganglia-thalamocortical relations in normal and Parkinsonian movement. *Biol. Cybern.*73, 467–476. 10.1007/bf00201481
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/7578481)
	- [CrossRef](https://doi.org/10.1007/bf00201481)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=J..%2BContreras-Vidal&author=G..%2BStelmach&publication_year=1995&title=A%2Bneural%2Bmodel%2Bof%2Bbasal%2Bganglia-thalamocortical%2Brelations%2Bin%2Bnormal%2Band%2BParkinsonian%2Bmovement&journal=Biol.+Cybern.&volume=73&pages=467-476)
- 22
	DesmurgetM.TurnerR. S. (2010). Motor sequences and the basal ganglia: kinematics, not habits. *J. Neurosci.*30, 7685–7690. 10.1523/jneurosci.0163-10.2010
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/20519543)
	- [CrossRef](https://doi.org/10.1523/jneurosci.0163-10.2010)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=M..%2BDesmurget&author=R.%2BS..%2BTurner&publication_year=2010&title=Motor%2Bsequences%2Band%2Bthe%2Bbasal%2Bganglia%3A%2Bkinematics%2C%2Bnot%2Bhabits&journal=J.+Neurosci.&volume=30&pages=7685-7690)
- 23
	DisbrowE. A.RussoK. A.HigginsonC. I.YundE. W.VenturaM. I.ZhangL.et al. (2012). Efficacy of tailored computer-based neurorehabilitation for improvement of movement initiation in Parkinson’s disease. *Brain Res.*1452, 151–164. 10.1016/j.brainres.2012.02.073
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/22459048)
	- [CrossRef](https://doi.org/10.1016/j.brainres.2012.02.073)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=E.%2BA..%2BDisbrow&author=K.%2BA..%2BRusso&author=C.%2BI..%2BHigginson&author=E.%2BW..%2BYund&author=M.%2BI..%2BVentura&author=L..%2BZhang&publication_year=2012&title=Efficacy%2Bof%2Btailored%2Bcomputer-based%2Bneurorehabilitation%2Bfor%2Bimprovement%2Bof%2Bmovement%2Binitiation%2Bin%2BParkinson%E2%80%99s%2Bdisease&journal=Brain+Res.&volume=1452&pages=151-164)
- 24
	DomellofM. E.ElghE.ForsgrenL. (2011). The relation between cognition and motor dysfunction in drug-naive newly diagnosed patients with Parkinson’s disease. *Mov. Disord.*26, 2183–2189. 10.1002/mds.23814
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/21661051)
	- [CrossRef](https://doi.org/10.1002/mds.23814)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=M.%2BE..%2BDomellof&author=E..%2BElgh&author=L..%2BForsgren&publication_year=2011&title=The%2Brelation%2Bbetween%2Bcognition%2Band%2Bmotor%2Bdysfunction%2Bin%2Bdrug-naive%2Bnewly%2Bdiagnosed%2Bpatients%2Bwith%2BParkinson%E2%80%99s%2Bdisease&journal=Mov.+Disord.&volume=26&pages=2183-2189)
- 25
	DomineyP. F.ArbibM. A. (1992). A cortico-subcortical model for generation of spatially accurate sequential saccades. *Cereb. Cortex* 2, 153–175. 10.1093/cercor/2.2.153
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/1633413)
	- [CrossRef](https://doi.org/10.1093/cercor/2.2.153)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=P.%2BF..%2BDominey&author=M.%2BA..%2BArbib&publication_year=1992&title=A%2Bcortico-subcortical%2Bmodel%2Bfor%2Bgeneration%2Bof%2Bspatially%2Baccurate%2Bsequential%2Bsaccades&journal=Cereb.+Cortex&volume=2&pages=153-175)
- 26
	DreherJ. C.BurnodY. (2002). An integrative theory of the phasic and tonic modes of dopamine modulation in the prefrontal cortex. *Neural Netw.*15, 583–602. 10.1016/s0893-6080(02)00051-5
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/12371514)
	- [CrossRef](https://doi.org/10.1016/s0893-6080\(02\)00051-5)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=J.%2BC..%2BDreher&author=Y..%2BBurnod&publication_year=2002&title=An%2Bintegrative%2Btheory%2Bof%2Bthe%2Bphasic%2Band%2Btonic%2Bmodes%2Bof%2Bdopamine%2Bmodulation%2Bin%2Bthe%2Bprefrontal%2Bcortex&journal=Neural+Netw.&volume=15&pages=583-602)
- 27
	DurstewitzD.SeamansJ. K. (2008). The dual-state theory of prefrontal cortex dopamine function with relevance to catechol-o-methyltransferase genotypes and schizophrenia. *Biol. Psychiatry* 64, 739–749. 10.1016/j.biopsych.2008.05.015
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/18620336)
	- [CrossRef](https://doi.org/10.1016/j.biopsych.2008.05.015)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=D..%2BDurstewitz&author=J.%2BK..%2BSeamans&publication_year=2008&title=The%2Bdual-state%2Btheory%2Bof%2Bprefrontal%2Bcortex%2Bdopamine%2Bfunction%2Bwith%2Brelevance%2Bto%2Bcatechol-o-methyltransferase%2Bgenotypes%2Band%2Bschizophrenia&journal=Biol.+Psychiatry&volume=64&pages=739-749)
- 28
	EhrtU.BroichK.LarsenJ. P.BallardC.AarslandD. (2010). Use of drugs with anticholinergic effect and impact on cognition in Parkinson’s disease: a cohort study. *J. Neurol. Neurosurg. Psychiatry* 81, 160–165. 10.1136/jnnp.2009.186239
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/19770163)
	- [CrossRef](https://doi.org/10.1136/jnnp.2009.186239)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=U..%2BEhrt&author=K..%2BBroich&author=J.%2BP..%2BLarsen&author=C..%2BBallard&author=D..%2BAarsland&publication_year=2010&title=Use%2Bof%2Bdrugs%2Bwith%2Banticholinergic%2Beffect%2Band%2Bimpact%2Bon%2Bcognition%2Bin%2BParkinson%E2%80%99s%2Bdisease%3A%2Ba%2Bcohort%2Bstudy&journal=J.+Neurol.+Neurosurg.+Psychiatry&volume=81&pages=160-165)
- 29
	FearnleyJ. M.LeesA. J. (1991). Ageing and Parkinson’s disease: substantia nigra regional selectivity. *Brain* 114, 2283–2301. 10.1093/brain/114.5.2283
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/1933245)
	- [CrossRef](https://doi.org/10.1093/brain/114.5.2283)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=J.%2BM..%2BFearnley&author=A.%2BJ..%2BLees&publication_year=1991&title=Ageing%2Band%2BParkinson%E2%80%99s%2Bdisease%3A%2Bsubstantia%2Bnigra%2Bregional%2Bselectivity&journal=Brain&volume=114&pages=2283-2301)
- 30
	FlahertyA. W.GraybielA. M. (1994). Input-output organization of the sensorimotor striatum in the squirrel monkey. *J. Neurosci.*14, 599–610.
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/7507981)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=A.%2BW..%2BFlaherty&author=A.%2BM..%2BGraybiel&publication_year=1994&title=Input-output%2Borganization%2Bof%2Bthe%2Bsensorimotor%2Bstriatum%2Bin%2Bthe%2Bsquirrel%2Bmonkey&journal=J.+Neurosci.&volume=14&pages=599-610)
- 31
	FrankM. J. (2005). Dynamic dopamine modulation in the basal ganglia: a neurocomputational account of cognitive deficits in medicated and nonmedicated Parkinsonism. *J. Cogn. Neurosci.*17, 51–72. 10.1162/0898929052880093
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/15701239)
	- [CrossRef](https://doi.org/10.1162/0898929052880093)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=M.%2BJ..%2BFrank&publication_year=2005&title=Dynamic%2Bdopamine%2Bmodulation%2Bin%2Bthe%2Bbasal%2Bganglia%3A%2Ba%2Bneurocomputational%2Baccount%2Bof%2Bcognitive%2Bdeficits%2Bin%2Bmedicated%2Band%2Bnonmedicated%2BParkinsonism&journal=J.+Cogn.+Neurosci.&volume=17&pages=51-72)
- 32
	FrankM. J.LoughryB.O’ReillyR. C. (2001). Interactions between frontal cortex and basal ganglia in working memory: a computational model. *Cogn. Affect. Behav. Neurosci.*1, 137–160. 10.3758/cabn.1.2.137
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/12467110)
	- [CrossRef](https://doi.org/10.3758/cabn.1.2.137)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=M.%2BJ..%2BFrank&author=B..%2BLoughry&author=R.%2BC..%2BO%E2%80%99Reilly&publication_year=2001&title=Interactions%2Bbetween%2Bfrontal%2Bcortex%2Band%2Bbasal%2Bganglia%2Bin%2Bworking%2Bmemory%3A%2Ba%2Bcomputational%2Bmodel&journal=Cogn.+Affect.+Behav.+Neurosci.&volume=1&pages=137-160)
- 33
	FusterJ. M. (2008). *The Prefrontal Cortex*. 4th Edn. Singapore: Academic Press.
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=J.%2BM..%2BFuster&publication_year=2008&journal=The+Prefrontal+Cortex)
- 34
	GangadharG.JosephD.ChakravarthyV. S. (2007). An oscillatory neuromotor model of handwriting generation. *Int. J. Document Anal. Recognition* 10, 69–84. 10.1007/s10032-007-0046-0
	- [CrossRef](https://doi.org/10.1007/s10032-007-0046-0)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=G..%2BGangadhar&author=D..%2BJoseph&author=V.%2BS..%2BChakravarthy&publication_year=2007&title=An%2Boscillatory%2Bneuromotor%2Bmodel%2Bof%2Bhandwriting%2Bgeneration&journal=Int.+J.+Document+Anal.+Recognition&volume=10&pages=69-84)
- 35
	GangadharG.JosephD.ChakravarthyV. S. (2008). Understanding Parkinsonian handwriting using a computational model of basal ganglia. *Neural Comput.*20, 2491–2525. 10.1162/neco.2008.03-07-498
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/18386983)
	- [CrossRef](https://doi.org/10.1162/neco.2008.03-07-498)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=G..%2BGangadhar&author=D..%2BJoseph&author=V.%2BS..%2BChakravarthy&publication_year=2008&title=Understanding%2BParkinsonian%2Bhandwriting%2Busing%2Ba%2Bcomputational%2Bmodel%2Bof%2Bbasal%2Bganglia&journal=Neural+Comput.&volume=20&pages=2491-2525)
- 36
	GangadharG.JosephD.SrinivasanA. V.SubramanianD.KeshavanS.ChakravarthyV. S. (2009). A computational model of Parkinsonian handwriting that high lights the role of the indirect pathway in the basal ganglia. *Hum. Mov. Sci.*28, 602–618. 10.1016/j.humov.2009.07.008
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/19720411)
	- [CrossRef](https://doi.org/10.1016/j.humov.2009.07.008)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=G..%2BGangadhar&author=D..%2BJoseph&author=A.%2BV..%2BSrinivasan&author=D..%2BSubramanian&author=S..%2BKeshavan&author=V.%2BS..%2BChakravarthy&publication_year=2009&title=A%2Bcomputational%2Bmodel%2Bof%2BParkinsonian%2Bhandwriting%2Bthat%2Bhigh%2Blights%2Bthe%2Brole%2Bof%2Bthe%2Bindirect%2Bpathway%2Bin%2Bthe%2Bbasal%2Bganglia&journal=Hum.+Mov.+Sci.&volume=28&pages=602-618)
- 37
	GerfenC. R.EngberT. M.MahanL. C.SuselZ.ChaseT. N.MonsmaF. J.et al. (1990). D1 and D2 dopamine receptor-regulated gene expression of striatonigral and striatopallidal neurons. *Science* 250, 1429–1432. 10.1126/science.2147780
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/2147780)
	- [CrossRef](https://doi.org/10.1126/science.2147780)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=C.%2BR..%2BGerfen&author=T.%2BM..%2BEngber&author=L.%2BC..%2BMahan&author=Z..%2BSusel&author=T.%2BN..%2BChase&author=F.%2BJ..%2BMonsma&publication_year=1990&title=D1%2Band%2BD2%2Bdopamine%2Breceptor-regulated%2Bgene%2Bexpression%2Bof%2Bstriatonigral%2Band%2Bstriatopallidal%2Bneurons&journal=Science&volume=250&pages=1429-1432)
- 38
	GerfenC. R.YoungW. S. (1988). Distribution of striatonigral and striatopallidal peptidergic neurons in both patch and matrix compartments: an in situ hybridization histochemistry and fluorescent retrograde tracing study. *Brain Res.*460, 161–167. 10.1016/0006-8993(88)91217-6
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/2464402)
	- [CrossRef](https://doi.org/10.1016/0006-8993\(88\)91217-6)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=C.%2BR..%2BGerfen&author=W.%2BS..%2BYoung&publication_year=1988&title=Distribution%2Bof%2Bstriatonigral%2Band%2Bstriatopallidal%2Bpeptidergic%2Bneurons%2Bin%2Bboth%2Bpatch%2Band%2Bmatrix%2Bcompartments%3A%2Ban%2Bin%2Bsitu%2Bhybridization%2Bhistochemistry%2Band%2Bfluorescent%2Bretrograde%2Btracing%2Bstudy&journal=Brain+Res.&volume=460&pages=161-167)
- 39
	GibbW. R.LeesA. J. (1991). Anatomy, pigmentation, ventral and dorsal subpopulations of the substantia nigra and differential cell death in Parkinson’s disease. *J. Neurol. Neurosurg. Psychiatry* 54, 388–396. 10.1136/jnnp.54.5.388
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/1865199)
	- [CrossRef](https://doi.org/10.1136/jnnp.54.5.388)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=W.%2BR..%2BGibb&author=A.%2BJ..%2BLees&publication_year=1991&title=Anatomy%2C%2Bpigmentation%2C%2Bventral%2Band%2Bdorsal%2Bsubpopulations%2Bof%2Bthe%2Bsubstantia%2Bnigra%2Band%2Bdifferential%2Bcell%2Bdeath%2Bin%2BParkinson%E2%80%99s%2Bdisease&journal=J.+Neurol.+Neurosurg.+Psychiatry&volume=54&pages=388-396)
- 40
	GiladiN.McMahonD.PrzedborskiS.FlasterE.GuilloryS.KosticV.et al. (1992). Motor blocks in Parkinson’s disease. *Neurology* 42, 333–339. 10.1212/WNL.42.2.333
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/1736161)
	- [CrossRef](https://doi.org/10.1212/WNL.42.2.333)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=N..%2BGiladi&author=D..%2BMcMahon&author=S..%2BPrzedborski&author=E..%2BFlaster&author=S..%2BGuillory&author=V..%2BKostic&publication_year=1992&title=Motor%2Bblocks%2Bin%2BParkinson%E2%80%99s%2Bdisease&journal=Neurology&volume=42&pages=333-339)
- 41
	GluckM. A.ShohamyD.MyersC. (2002). How do people solve the “Weather Prediction” Task?: individual variability in strategies for probabilistic category learning. *Learn. Mem.*9, 408–418. 10.1101/lm.45202
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/12464701)
	- [CrossRef](https://doi.org/10.1101/lm.45202)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=M.%2BA..%2BGluck&author=D..%2BShohamy&author=C..%2BMyers&publication_year=2002&title=How%2Bdo%2Bpeople%2Bsolve%2Bthe%2B%E2%80%9CWeather%2BPrediction%E2%80%9D%2BTask%3F%3A%2Bindividual%2Bvariability%2Bin%2Bstrategies%2Bfor%2Bprobabilistic%2Bcategory%2Blearning&journal=Learn.+Mem.&volume=9&pages=408-418)
- 42
	GothamA. M.BrownR. G.MarsdenC. D. (1988). “Frontal” cognitive function in patients with Parkinson’s disease “on”and “off” levodopa. *Brain* 111, 299–321. 10.1093/brain/111.2.299
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/3378138)
	- [CrossRef](https://doi.org/10.1093/brain/111.2.299)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=A.%2BM..%2BGotham&author=R.%2BG..%2BBrown&author=C.%2BD..%2BMarsden&publication_year=1988&title=%E2%80%9CFrontal%E2%80%9D%2Bcognitive%2Bfunction%2Bin%2Bpatients%2Bwith%2BParkinson%E2%80%99s%2Bdisease%2B%E2%80%9Con%E2%80%9Dand%2B%E2%80%9Coff%E2%80%9D%2Blevodopa&journal=Brain&volume=111&pages=299-321)
- 43
	GurneyK.PrescottT. J.RedgraveP. (2001). A computational model of action selection in the basal ganglia. II. Analysis and simulation of behaviour. *Biol. Cybern.*84, 411–423. 10.1007/pl00007985
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/11417053)
	- [CrossRef](https://doi.org/10.1007/pl00007985)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=K..%2BGurney&author=T.%2BJ..%2BPrescott&author=P..%2BRedgrave&publication_year=2001&title=A%2Bcomputational%2Bmodel%2Bof%2Baction%2Bselection%2Bin%2Bthe%2Bbasal%2Bganglia.%2BII.%2BAnalysis%2Band%2Bsimulation%2Bof%2Bbehaviour&journal=Biol.+Cybern.&volume=84&pages=411-423)
- 44
	GuthrieM.LebloisA.GarenneA.BoraudT. (2013). Interaction between cognitive and motor cortico-basal ganglia loops during decision making: a computational study. *J. Neurophysiol.*109, 3025–3040. 10.1152/jn.00026.2013
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/23536713)
	- [CrossRef](https://doi.org/10.1152/jn.00026.2013)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=M..%2BGuthrie&author=A..%2BLeblois&author=A..%2BGarenne&author=T..%2BBoraud&publication_year=2013&title=Interaction%2Bbetween%2Bcognitive%2Band%2Bmotor%2Bcortico-basal%2Bganglia%2Bloops%2Bduring%2Bdecision%2Bmaking%3A%2Ba%2Bcomputational%2Bstudy&journal=J.+Neurophysiol.&volume=109&pages=3025-3040)
- 45
	HaberS. N.KimK. S.MaillyP.CalzavaraR. (2006). Reward-related cortical inputs define a large striatal region in primates that interface with associative cortical connections, providing a substrate for incentive-based learning. *J. Neurosci.*26, 8368–8376. 10.1523/jneurosci.0271-06.2006
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/16899732)
	- [CrossRef](https://doi.org/10.1523/jneurosci.0271-06.2006)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=S.%2BN..%2BHaber&author=K.%2BS..%2BKim&author=P..%2BMailly&author=R..%2BCalzavara&publication_year=2006&title=Reward-related%2Bcortical%2Binputs%2Bdefine%2Ba%2Blarge%2Bstriatal%2Bregion%2Bin%2Bprimates%2Bthat%2Binterface%2Bwith%2Bassociative%2Bcortical%2Bconnections%2C%2Bproviding%2Ba%2Bsubstrate%2Bfor%2Bincentive-based%2Blearning&journal=J.+Neurosci.&volume=26&pages=8368-8376)
- 46
	HayhoeM.AivarP.ShrivastavahA.MruczekR. (2002). Visual short-term memory and motor planning. *Prog. Brain Res.*140, 349–363. 10.1016/s0079-6123(02)40062-3
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/12508602)
	- [CrossRef](https://doi.org/10.1016/s0079-6123\(02\)40062-3)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=M..%2BHayhoe&author=P..%2BAivar&author=A..%2BShrivastavah&author=R..%2BMruczek&publication_year=2002&title=Visual%2Bshort-term%2Bmemory%2Band%2Bmotor%2Bplanning&journal=Prog.+Brain+Res.&volume=140&pages=349-363)
- 47
	HelieS.AshbyG. F. (2009). “A neurocomputational model of automaticity and maintenance of abstract rules,” in *Proceedings of the International Joint Conference on Neural Networks (IEEE Press)*, 1192–1198.
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=S..%2BHelie&author=G.%2BF..%2BAshby&publication_year=2009&title=A%2Bneurocomputational%2Bmodel%2Bof%2Bautomaticity%2Band%2Bmaintenance%2Bof%2Babstract%2Brules&journal=Proceedings+of+the+International+Joint+Conference+on+Neural+Networks+%28IEEE+Press%29&pages=1192-1198)
- 48
	HelieS.CousineauD. (2011). The cognitive neuroscience of automaticity: behavioral and brain signatures. *Cogn. Sci.*6, 25–43.
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=S..%2BHelie&author=D..%2BCousineau&publication_year=2011&title=The%2Bcognitive%2Bneuroscience%2Bof%2Bautomaticity%3A%2Bbehavioral%2Band%2Bbrain%2Bsignatures&journal=Cogn.+Sci.&volume=6&pages=25-43)
- 49
	HelieS.PaulE. J.AshbyF. G. (2012a). A neurocomputational account of cognitive deficits in Parkinson’s disease. *Neuropsychologia* 50, 2290–2302. 10.1016/j.neuropsychologia.2012.05.033
	- [CrossRef](https://doi.org/10.1016/j.neuropsychologia.2012.05.033)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=S..%2BHelie&author=E.%2BJ..%2BPaul&author=F.%2BG..%2BAshby&publication_year=2012a&title=A%2Bneurocomputational%2Baccount%2Bof%2Bcognitive%2Bdeficits%2Bin%2BParkinson%E2%80%99s%2Bdisease&journal=Neuropsychologia&volume=50&pages=2290-2302)
- 50
	HelieS.PaulE. J.AshbyF. G. (2012b). Simulating the effect of dopamine imbalance on cognition: from positive affect to Parkinson’s disease. *Neural. Netw.*32, 74–85. 10.1016/j.neunet.2012.02.033
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/22402326)
	- [CrossRef](https://doi.org/10.1016/j.neunet.2012.02.033)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=S..%2BHelie&author=E.%2BJ..%2BPaul&author=F.%2BG..%2BAshby&publication_year=2012b&title=Simulating%2Bthe%2Beffect%2Bof%2Bdopamine%2Bimbalance%2Bon%2Bcognition%3A%2Bfrom%2Bpositive%2Baffect%2Bto%2BParkinson%E2%80%99s%2Bdisease&journal=Neural.+Netw.&volume=32&pages=74-85)
- 51
	HelieS.WaldschmidtJ. G.AshbyF. G. (2010). Automaticity in rule-based and information-integration categorization. *Atten. Percept. Psychophys.*72, 1013–1031. 10.3758/app.72.4.1013
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/20436197)
	- [CrossRef](https://doi.org/10.3758/app.72.4.1013)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=S..%2BHelie&author=J.%2BG..%2BWaldschmidt&author=F.%2BG..%2BAshby&publication_year=2010&title=Automaticity%2Bin%2Brule-based%2Band%2Binformation-integration%2Bcategorization&journal=Atten.+Percept.+Psychophys.&volume=72&pages=1013-1031)
- 52
	HerzallahM. M.MoustafaA. A.MiskA. J.Al-DweibL. H.AbdelrazeqS. A.MyersC. E.et al. (2010). Depression impairs learning whereas anticholinergics impair transfer generalization in Parkinson patients tested on dopaminergic medications. *Cogn. Behav. Neurol.*23, 98–105. 10.1097/wnn.0b013e3181df3048
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/20535058)
	- [CrossRef](https://doi.org/10.1097/wnn.0b013e3181df3048)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=M.%2BM..%2BHerzallah&author=A.%2BA..%2BMoustafa&author=A.%2BJ..%2BMisk&author=L.%2BH..%2BAl-Dweib&author=S.%2BA..%2BAbdelrazeq&author=C.%2BE..%2BMyers&publication_year=2010&title=Depression%2Bimpairs%2Blearning%2Bwhereas%2Banticholinergics%2Bimpair%2Btransfer%2Bgeneralization%2Bin%2BParkinson%2Bpatients%2Btested%2Bon%2Bdopaminergic%2Bmedications&journal=Cogn.+Behav.+Neurol.&volume=23&pages=98-105)
- 53
	HikosakaO.TakikawaY.KawagoeR. (2000). Role of the basal ganglia in the control of purposive saccadic eye movements. *Physiol. Rev.*80, 953–978.
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/10893428)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=O..%2BHikosaka&author=Y..%2BTakikawa&author=R..%2BKawagoe&publication_year=2000&title=Role%2Bof%2Bthe%2Bbasal%2Bganglia%2Bin%2Bthe%2Bcontrol%2Bof%2Bpurposive%2Bsaccadic%2Beye%2Bmovements&journal=Physiol.+Rev.&volume=80&pages=953-978)
- 54
	HistedM. H.PasupathyA.MillerE. K. (2009). Learning substrates in the primate prefrontal cortex and striatum: sustained activity related to successful actions. *Neuron* 63, 244–253. 10.1016/j.neuron.2009.06.019
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/19640482)
	- [CrossRef](https://doi.org/10.1016/j.neuron.2009.06.019)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=M.%2BH..%2BHisted&author=A..%2BPasupathy&author=E.%2BK..%2BMiller&publication_year=2009&title=Learning%2Bsubstrates%2Bin%2Bthe%2Bprimate%2Bprefrontal%2Bcortex%2Band%2Bstriatum%3A%2Bsustained%2Bactivity%2Brelated%2Bto%2Bsuccessful%2Bactions&journal=Neuron&volume=63&pages=244-253)
- 55
	HollerbachJ. M. (1981). An oscillation theory of handwriting. *Biol. Cybern.*39, 139–156. 10.1007/bf00336740
	- [CrossRef](https://doi.org/10.1007/bf00336740)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=J.%2BM..%2BHollerbach&publication_year=1981&title=An%2Boscillation%2Btheory%2Bof%2Bhandwriting&journal=Biol.+Cybern.&volume=39&pages=139-156)
- 56
	IssenL. A.KnillD. C. (2012). Decoupling eye and hand movement control: visual short-term memory influences reach planning more than saccade planning. *J. Vis.*12, 1–13. 10.1167/12.1.3
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/22219310)
	- [CrossRef](https://doi.org/10.1167/12.1.3)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=L.%2BA..%2BIssen&author=D.%2BC..%2BKnill&publication_year=2012&title=Decoupling%2Beye%2Band%2Bhand%2Bmovement%2Bcontrol%3A%2Bvisual%2Bshort-term%2Bmemory%2Binfluences%2Breach%2Bplanning%2Bmore%2Bthan%2Bsaccade%2Bplanning&journal=J.+Vis.&volume=12&pages=1-13)
- 57
	JankovicJ.McDermottM.CarterJ.GauthierS.GoetzC.GolbeL.et al. (1990). Variable expression of Parkinson’s disease: a base-line analysis of the DATATOP cohort. *Neurology* 40, 1529–1534. 10.1212/wnl.40.10.1529
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/2215943)
	- [CrossRef](https://doi.org/10.1212/wnl.40.10.1529)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=J..%2BJankovic&author=M..%2BMcDermott&author=J..%2BCarter&author=S..%2BGauthier&author=C..%2BGoetz&author=L..%2BGolbe&publication_year=1990&title=Variable%2Bexpression%2Bof%2BParkinson%E2%80%99s%2Bdisease%3A%2Ba%2Bbase-line%2Banalysis%2Bof%2Bthe%2BDATATOP%2Bcohort&journal=Neurology&volume=40&pages=1529-1534)
- 58
	KaasinenV.NurmiE.BergmanJ.EskolaO.SolinO.SonninenP.et al. (2001). Personality traits and brain dopaminergic function in Parkinson’s disease. *Proc. Natl. Acad. Sci. U S A* 98, 13272–13277. 10.1073/pnas.231313198
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/11687621)
	- [CrossRef](https://doi.org/10.1073/pnas.231313198)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=V..%2BKaasinen&author=E..%2BNurmi&author=J..%2BBergman&author=O..%2BEskola&author=O..%2BSolin&author=P..%2BSonninen&publication_year=2001&title=Personality%2Btraits%2Band%2Bbrain%2Bdopaminergic%2Bfunction%2Bin%2BParkinson%E2%80%99s%2Bdisease&journal=Proc.+Natl.+Acad.+Sci.+U+S+A&volume=98&pages=13272-13277)
- 59
	KalveramK. T. (1998). “A neural oscillator model learning given trajectories, or how an allo-imitation algorithm can be implemented into a motor controller,” in *Motor Behavior and Human Skill: A Multi-Disciplinary Approach*, ed PiekJ. (Champaign, IL, USA: Human Kinetics Publishers), 127–140.
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=K.%2BT..%2BKalveram&publication_year=1998&title=A%2Bneural%2Boscillator%2Bmodel%2Blearning%2Bgiven%2Btrajectories%2C%2Bor%2Bhow%2Ban%2Ballo-imitation%2Balgorithm%2Bcan%2Bbe%2Bimplemented%2Binto%2Ba%2Bmotor%2Bcontroller&journal=Motor+Behavior+and+Human+Skill%3A+A+Multi-Disciplinary+Approach&pages=127-140)
- 60
	KassubekJ.JuenglingF. D.HellwigB.SpreerJ.LuckingC. H. (2002). Thalamic gray matter changes in unilateral Parkinsonian resting tremor: a voxel-based morphometric analysis of 3-dimensional magnetic resonance imaging. *Neurosci. Lett.*323, 29–32. 10.1016/s0304-3940(02)00111-8
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/11911983)
	- [CrossRef](https://doi.org/10.1016/s0304-3940\(02\)00111-8)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=J..%2BKassubek&author=F.%2BD..%2BJuengling&author=B..%2BHellwig&author=J..%2BSpreer&author=C.%2BH..%2BLucking&publication_year=2002&title=Thalamic%2Bgray%2Bmatter%2Bchanges%2Bin%2Bunilateral%2BParkinsonian%2Bresting%2Btremor%3A%2Ba%2Bvoxel-based%2Bmorphometric%2Banalysis%2Bof%2B3-dimensional%2Bmagnetic%2Bresonance%2Bimaging&journal=Neurosci.+Lett.&volume=323&pages=29-32)
- 61
	KatoM.MiyashitaN.HikosakaO.MatsumuraM.UsuiS.KoriA. (1995). Eye movements in monkeys with local dopamine depletion in caudate nucleus.I. Deficits in spontaneous saccades. *J. Neurosci.*15, 912–927.
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/7823189)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=M..%2BKato&author=N..%2BMiyashita&author=O..%2BHikosaka&author=M..%2BMatsumura&author=S..%2BUsui&author=A..%2BKori&publication_year=1995&title=Eye%2Bmovements%2Bin%2Bmonkeys%2Bwith%2Blocal%2Bdopamine%2Bdepletion%2Bin%2Bcaudate%2Bnucleus.I.%2BDeficits%2Bin%2Bspontaneous%2Bsaccades&journal=J.+Neurosci.&volume=15&pages=912-927)
- 62
	KempJ. M.PowellT. P. S. (1970). The cortico-striate projections in the monkey. *Brain* 93, 525–546. 10.1093/brain/93.3.525
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/4990231)
	- [CrossRef](https://doi.org/10.1093/brain/93.3.525)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=J.%2BM..%2BKemp&author=T.%2BP.%2BS..%2BPowell&publication_year=1970&title=The%2Bcortico-striate%2Bprojections%2Bin%2Bthe%2Bmonkey&journal=Brain&volume=93&pages=525-546)
- 63
	KincaidA. E.ZhengT.WilsonC. J. (1998). Connectivity and convergence of single corticostriatal axons. *J. Neurosci.*18, 4722–4731.
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/9614246)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=A.%2BE..%2BKincaid&author=T..%2BZheng&author=C.%2BJ..%2BWilson&publication_year=1998&title=Connectivity%2Band%2Bconvergence%2Bof%2Bsingle%2Bcorticostriatal%2Baxons&journal=J.+Neurosci.&volume=18&pages=4722-4731)
- 64
	KnowltonB. J.MangelsJ. A.SquireL. R. (1996). A neostriatal habit learning system in humans. *Science* 273, 1399–1402. 10.1126/science.273.5280.1399
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/8703077)
	- [CrossRef](https://doi.org/10.1126/science.273.5280.1399)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=B.%2BJ..%2BKnowlton&author=J.%2BA..%2BMangels&author=L.%2BR..%2BSquire&publication_year=1996&title=A%2Bneostriatal%2Bhabit%2Blearning%2Bsystem%2Bin%2Bhumans&journal=Science&volume=273&pages=1399-1402)
- 65
	KosticV. S.AgostaF.PievaniM.StefanovaE.Jecmenica-LukicM.ScaraleA.et al. (2012). Pattern of brain tissue loss associated with freezing of gait in Parkinson disease. *Neurology* 78, 409–416. 10.1212/wnl.0b013e318245d23c
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/22282641)
	- [CrossRef](https://doi.org/10.1212/wnl.0b013e318245d23c)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=V.%2BS..%2BKostic&author=F..%2BAgosta&author=M..%2BPievani&author=E..%2BStefanova&author=M..%2BJecmenica-Lukic&author=A..%2BScarale&publication_year=2012&title=Pattern%2Bof%2Bbrain%2Btissue%2Bloss%2Bassociated%2Bwith%2Bfreezing%2Bof%2Bgait%2Bin%2BParkinson%2Bdisease&journal=Neurology&volume=78&pages=409-416)
- 66
	KrishnanR.RatnaduraiS.SubramanianD.ChakravarthyV. S.RengaswamyM. (2011). Modeling the role of basal ganglia in saccade generation: is the indirect pathway the explorer?*Neural Netw.*24, 801–813. 10.1016/j.neunet.2011.06.002
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/21726978)
	- [CrossRef](https://doi.org/10.1016/j.neunet.2011.06.002)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=R..%2BKrishnan&author=S..%2BRatnadurai&author=D..%2BSubramanian&author=V.%2BS..%2BChakravarthy&author=M..%2BRengaswamy&publication_year=2011&title=Modeling%2Bthe%2Brole%2Bof%2Bbasal%2Bganglia%2Bin%2Bsaccade%2Bgeneration%3A%2Bis%2Bthe%2Bindirect%2Bpathway%2Bthe%2Bexplorer%3F&journal=Neural+Netw.&volume=24&pages=801-813)
- 67
	LawrenceA. D. (2000). Error correction and the basal ganglia: similar computations for action, cognition and emotion?*Trends Cogn. Sci.*4, 365–367. 10.1016/s1364-6613(00)01535-7
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/11025274)
	- [CrossRef](https://doi.org/10.1016/s1364-6613\(00\)01535-7)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=A.%2BD..%2BLawrence&publication_year=2000&title=Error%2Bcorrection%2Band%2Bthe%2Bbasal%2Bganglia%3A%2Bsimilar%2Bcomputations%2Bfor%2Baction%2C%2Bcognition%2Band%2Bemotion%3F&journal=Trends+Cogn.+Sci.&volume=4&pages=365-367)
- 68
	LebloisA.BoraudT.MeissnerW.BergmanH.HanselD. (2006). Competition between feedback loops underlies normal and pathological dynamics in the basal ganglia. *J. Neurosci.*26, 3567–3583. 10.1523/jneurosci.5050-05.2006
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/16571765)
	- [CrossRef](https://doi.org/10.1523/jneurosci.5050-05.2006)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=A..%2BLeblois&author=T..%2BBoraud&author=W..%2BMeissner&author=H..%2BBergman&author=D..%2BHansel&publication_year=2006&title=Competition%2Bbetween%2Bfeedback%2Bloops%2Bunderlies%2Bnormal%2Band%2Bpathological%2Bdynamics%2Bin%2Bthe%2Bbasal%2Bganglia&journal=J.+Neurosci.&volume=26&pages=3567-3583)
- 69
	LewisS. J.BarkerR. A. (2009). A pathophysiological model of freezing of gait in Parkinson’s disease. *Parkinsonism Relat. Disord.*15, 333–338. 10.1016/j.parkreldis.2008.08.006
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/18930430)
	- [CrossRef](https://doi.org/10.1016/j.parkreldis.2008.08.006)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=S.%2BJ..%2BLewis&author=R.%2BA..%2BBarker&publication_year=2009&title=A%2Bpathophysiological%2Bmodel%2Bof%2Bfreezing%2Bof%2Bgait%2Bin%2BParkinson%E2%80%99s%2Bdisease&journal=Parkinsonism+Relat.+Disord.&volume=15&pages=333-338)
- 70
	LyrosE.MessinisL.PapathanasopoulosP. (2008). Does motor subtype influence neurocognitive performance in Parkinson’s disease without dementia?*Eur. J. Neurol.*15, 262–267. 10.1111/j.1468-1331.2007.02046.x
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/18190508)
	- [CrossRef](https://doi.org/10.1111/j.1468-1331.2007.02046.x)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=E..%2BLyros&author=L..%2BMessinis&author=P..%2BPapathanasopoulos&publication_year=2008&title=Does%2Bmotor%2Bsubtype%2Binfluence%2Bneurocognitive%2Bperformance%2Bin%2BParkinson%E2%80%99s%2Bdisease%2Bwithout%2Bdementia%3F&journal=Eur.+J.+Neurol.&volume=15&pages=262-267)
- 71
	MaddoxW. T.AshbyF. G. (2004). Dissociating explicit and procedural-learning based systems of perceptual category learning. *Behav. Processes* 66, 309–332. 10.1016/j.beproc.2004.03.011
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/15157979)
	- [CrossRef](https://doi.org/10.1016/j.beproc.2004.03.011)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=W.%2BT..%2BMaddox&author=F.%2BG..%2BAshby&publication_year=2004&title=Dissociating%2Bexplicit%2Band%2Bprocedural-learning%2Bbased%2Bsystems%2Bof%2Bperceptual%2Bcategory%2Blearning&journal=Behav.+Processes&volume=66&pages=309-332)
- 72
	MagdoomM.SubramanianD.ChakravarthyV. S.RavindranB.AmariS.MeenakshisundaramN. (2011). Modeling basal ganglia for understanding Parkinsonian reaching movements. *Neural Comput.*23, 477–516. 10.1162/neco\_a\_00073
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/21105828)
	- [CrossRef](https://doi.org/10.1162/neco_a_00073)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=M..%2BMagdoom&author=D..%2BSubramanian&author=V.%2BS..%2BChakravarthy&author=B..%2BRavindran&author=S..%2BAmari&author=N..%2BMeenakshisundaram&publication_year=2011&title=Modeling%2Bbasal%2Bganglia%2Bfor%2Bunderstanding%2BParkinsonian%2Breaching%2Bmovements&journal=Neural+Comput.&volume=23&pages=477-516)
- 73
	MatarE.ShineJ. M.NaismithS. L.LewisS. J. (2013). Using virtual reality to explore the role of conflict resolution and environmental salience in freezing of gait in Parkinson’s disease. *Parkinsonism Relat. Disord.*19, 937–942. 10.1016/j.parkreldis.2013.06.002
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/23831480)
	- [CrossRef](https://doi.org/10.1016/j.parkreldis.2013.06.002)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=E..%2BMatar&author=J.%2BM..%2BShine&author=S.%2BL..%2BNaismith&author=S.%2BJ..%2BLewis&publication_year=2013&title=Using%2Bvirtual%2Breality%2Bto%2Bexplore%2Bthe%2Brole%2Bof%2Bconflict%2Bresolution%2Band%2Benvironmental%2Bsalience%2Bin%2Bfreezing%2Bof%2Bgait%2Bin%2BParkinson%E2%80%99s%2Bdisease&journal=Parkinsonism+Relat.+Disord.&volume=19&pages=937-942)
- 74
	MatsuiH.UdakaF.MiyoshiT.HaraN.TamauraA.OdaM.et al. (2005). Three-dimensional stereotactic surface projection study of freezing of gait and brain perfusion image in Parkinson’s disease. *Mov. Disord.*20, 1272–1277. 10.1002/mds.20520
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/16007622)
	- [CrossRef](https://doi.org/10.1002/mds.20520)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=H..%2BMatsui&author=F..%2BUdaka&author=T..%2BMiyoshi&author=N..%2BHara&author=A..%2BTamaura&author=M..%2BOda&publication_year=2005&title=Three-dimensional%2Bstereotactic%2Bsurface%2Bprojection%2Bstudy%2Bof%2Bfreezing%2Bof%2Bgait%2Band%2Bbrain%2Bperfusion%2Bimage%2Bin%2BParkinson%E2%80%99s%2Bdisease&journal=Mov.+Disord.&volume=20&pages=1272-1277)
- 75
	MatsumotoK.SuzukiW.TanakaK. (2003). Neuronal correlates of goal-based motor selection in the prefrontal cortex. *Science* 301, 229–232. 10.1126/science.1084204
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/12855813)
	- [CrossRef](https://doi.org/10.1126/science.1084204)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=K..%2BMatsumoto&author=W..%2BSuzuki&author=K..%2BTanaka&publication_year=2003&title=Neuronal%2Bcorrelates%2Bof%2Bgoal-based%2Bmotor%2Bselection%2Bin%2Bthe%2Bprefrontal%2Bcortex&journal=Science&volume=301&pages=229-232)
- 76
	McIntyreJ.StrattaF.LacquanitiF. (1998). Short-term memory for reaching to visual targets: psychophysical evidence for body-centered reference frames. *J. Neurosci.*18, 8423–8435.
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/9763485)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=J..%2BMcIntyre&author=F..%2BStratta&author=F..%2BLacquaniti&publication_year=1998&title=Short-term%2Bmemory%2Bfor%2Breaching%2Bto%2Bvisual%2Btargets%3A%2Bpsychophysical%2Bevidence%2Bfor%2Bbody-centered%2Breference%2Bframes&journal=J.+Neurosci.&volume=18&pages=8423-8435)
- 77
	MecoG.CasacchiaM.LazzariR.FranzeseA.CastellanaF.CartaA.et al. (1984). Mental impairment in Parkinson’s disease. The role of anticholinergic drugs. *Acta Psychiatr. Belg.*84, 325–335.
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/6507124)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=G..%2BMeco&author=M..%2BCasacchia&author=R..%2BLazzari&author=A..%2BFranzese&author=F..%2BCastellana&author=A..%2BCarta&publication_year=1984&title=Mental%2Bimpairment%2Bin%2BParkinson%E2%80%99s%2Bdisease.%2BThe%2Brole%2Bof%2Banticholinergic%2Bdrugs&journal=Acta+Psychiatr.+Belg.&volume=84&pages=325-335)
- 78
	MiyachiS.HikosakaO.LuX. (2002). Differential activation of monkey striatal neurons in the early and late stages of procedural learning. *Exp. Brain Res.*146, 122–126. 10.1007/s00221-002-1213-7
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/12192586)
	- [CrossRef](https://doi.org/10.1007/s00221-002-1213-7)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=S..%2BMiyachi&author=O..%2BHikosaka&author=X..%2BLu&publication_year=2002&title=Differential%2Bactivation%2Bof%2Bmonkey%2Bstriatal%2Bneurons%2Bin%2Bthe%2Bearly%2Band%2Blate%2Bstages%2Bof%2Bprocedural%2Blearning&journal=Exp.+Brain+Res.&volume=146&pages=122-126)
- 79
	MiyachiS.HikosakaO.MiyashitaK.KárádiZ.RandM. K. (1997). Differential roles of monkey striatum in learning of sequential hand movement. *Exp. Brain Res.*115, 1–5. 10.1007/pl00005669
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/9224828)
	- [CrossRef](https://doi.org/10.1007/pl00005669)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=S..%2BMiyachi&author=O..%2BHikosaka&author=K..%2BMiyashita&author=Z..%2BK%C3%A1r%C3%A1di&author=M.%2BK..%2BRand&publication_year=1997&title=Differential%2Broles%2Bof%2Bmonkey%2Bstriatum%2Bin%2Blearning%2Bof%2Bsequential%2Bhand%2Bmovement&journal=Exp.+Brain+Res.&volume=115&pages=1-5)
- 80
	MonchiO.TaylorJ. G.DagherA. (2000). A neural model of working memory processes in normal subjects, Parkinson’s disease and schizophrenia for fMRI design and predictions. *Neural Netw.*13, 953–973. 10.1016/s0893-6080(00)00058-7
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/11156204)
	- [CrossRef](https://doi.org/10.1016/s0893-6080\(00\)00058-7)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=O..%2BMonchi&author=J.%2BG..%2BTaylor&author=A..%2BDagher&publication_year=2000&title=A%2Bneural%2Bmodel%2Bof%2Bworking%2Bmemory%2Bprocesses%2Bin%2Bnormal%2Bsubjects%2C%2BParkinson%E2%80%99s%2Bdisease%2Band%2Bschizophrenia%2Bfor%2BfMRI%2Bdesign%2Band%2Bpredictions&journal=Neural+Netw.&volume=13&pages=953-973)
- 81
	MoustafaA. A.BellP.EissaA. M.HewediD. H. (2013). The effects of clinical motor variables and medication dosage on working memory in Parkinson’s disease. *Brain Cogn.*82, 137–145. 10.1016/j.bandc.2013.04.001
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/23660434)
	- [CrossRef](https://doi.org/10.1016/j.bandc.2013.04.001)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=A.%2BA..%2BMoustafa&author=P..%2BBell&author=A.%2BM..%2BEissa&author=D.%2BH..%2BHewedi&publication_year=2013&title=The%2Beffects%2Bof%2Bclinical%2Bmotor%2Bvariables%2Band%2Bmedication%2Bdosage%2Bon%2Bworking%2Bmemory%2Bin%2BParkinson%E2%80%99s%2Bdisease&journal=Brain+Cogn.&volume=82&pages=137-145)
- 82
	MoustafaA. A.CohenM. X.ShermanS. J.FrankM. J. (2008). A role for dopamine in temporal decision making and reward maximization in Parkinsonism. *J. Neurosci.*28, 12294–12304. 10.1523/jneurosci.3116-08.2008
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/19020023)
	- [CrossRef](https://doi.org/10.1523/jneurosci.3116-08.2008)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=A.%2BA..%2BMoustafa&author=M.%2BX..%2BCohen&author=S.%2BJ..%2BSherman&author=M.%2BJ..%2BFrank&publication_year=2008&title=A%2Brole%2Bfor%2Bdopamine%2Bin%2Btemporal%2Bdecision%2Bmaking%2Band%2Breward%2Bmaximization%2Bin%2BParkinsonism&journal=J.+Neurosci.&volume=28&pages=12294-12304)
- 83
	MoustafaA. A.GluckM. A. (2011a). A neurocomputational model of dopamine and prefrontal-striatal interactions during multi-cue category learning by Parkinson’s patients. *J. Cogn. Neurosci.*23, 151–167. 10.1162/jocn.2010.21420
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/20044893)
	- [CrossRef](https://doi.org/10.1162/jocn.2010.21420)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=A.%2BA..%2BMoustafa&author=M.%2BA..%2BGluck&publication_year=2011a&title=A%2Bneurocomputational%2Bmodel%2Bof%2Bdopamine%2Band%2Bprefrontal-striatal%2Binteractions%2Bduring%2Bmulti-cue%2Bcategory%2Blearning%2Bby%2BParkinson%E2%80%99s%2Bpatients&journal=J.+Cogn.+Neurosci.&volume=23&pages=151-167)
- 84
	MoustafaA. A.GluckM. A. (2011b). Computational cognitive models of prefrontal-striatal-hippocampal interactions in Parkinson’s disease and schizophrenia. *Neural Netw.*24, 575–591. 10.1016/j.neunet.2011.02.006
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/21411277)
	- [CrossRef](https://doi.org/10.1016/j.neunet.2011.02.006)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=A.%2BA..%2BMoustafa&author=M.%2BA..%2BGluck&publication_year=2011b&title=Computational%2Bcognitive%2Bmodels%2Bof%2Bprefrontal-striatal-hippocampal%2Binteractions%2Bin%2BParkinson%E2%80%99s%2Bdisease%2Band%2Bschizophrenia&journal=Neural+Netw.&volume=24&pages=575-591)
- 85
	MoustafaHerzallahM. M.GluckM. A. (2013). Dissociating the cognitive effects of levodopa versus dopamine agonists in a neurocomputational model of learning in Parkinson’s disease. *Neurodegener. Dis.*11, 102–111. 10.1159/000341999
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/23128796)
	- [CrossRef](https://doi.org/10.1159/000341999)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=.%2BMoustafa&author=M.%2BM..%2BHerzallah&author=M.%2BA..%2BGluck&publication_year=2013&title=Dissociating%2Bthe%2Bcognitive%2Beffects%2Bof%2Blevodopa%2Bversus%2Bdopamine%2Bagonists%2Bin%2Ba%2Bneurocomputational%2Bmodel%2Bof%2Blearning%2Bin%2BParkinson%E2%80%99s%2Bdisease&journal=Neurodegener.+Dis.&volume=11&pages=102-111)
- 86
	MoustafaA. A.MaidaA. S. (2007). Using TD learning to simulate working memory performance in a model of the prefrontal cortex and basal ganglia. *Cogn. Syst. Res.*8, 262–281. 10.1016/j.cogsys.2007.02.001
	- [CrossRef](https://doi.org/10.1016/j.cogsys.2007.02.001)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=A.%2BA..%2BMoustafa&author=A.%2BS..%2BMaida&publication_year=2007&title=Using%2BTD%2Blearning%2Bto%2Bsimulate%2Bworking%2Bmemory%2Bperformance%2Bin%2Ba%2Bmodel%2Bof%2Bthe%2Bprefrontal%2Bcortex%2Band%2Bbasal%2Bganglia&journal=Cogn.+Syst.+Res.&volume=8&pages=262-281)
- 87
	MulderA. B.NordquistR. E.OrgutO.PennartzC. M. (2003). Learning-related changes in response patterns of prefrontal neurons during instrumental conditioning. *Behav. Brain Res.*146, 77–88. 10.1016/j.bbr.2003.09.016
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/14643461)
	- [CrossRef](https://doi.org/10.1016/j.bbr.2003.09.016)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=A.%2BB..%2BMulder&author=R.%2BE..%2BNordquist&author=O..%2BOrgut&author=C.%2BM..%2BPennartz&publication_year=2003&title=Learning-related%2Bchanges%2Bin%2Bresponse%2Bpatterns%2Bof%2Bprefrontal%2Bneurons%2Bduring%2Binstrumental%2Bconditioning&journal=Behav.+Brain+Res.&volume=146&pages=77-88)
- 88
	MureH.HiranoS.TangC. C.IsaiasI. U.AntoniniA.MaY.et al. (2011). Parkinson’s disease tremor-related metabolic network: characterization, progression and treatment effects. *Neuroimage* 54, 1244–1253. 10.1016/j.neuroimage.2010.09.028
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/20851193)
	- [CrossRef](https://doi.org/10.1016/j.neuroimage.2010.09.028)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=H..%2BMure&author=S..%2BHirano&author=C.%2BC..%2BTang&author=I.%2BU..%2BIsaias&author=A..%2BAntonini&author=Y..%2BMa&publication_year=2011&title=Parkinson%E2%80%99s%2Bdisease%2Btremor-related%2Bmetabolic%2Bnetwork%3A%2Bcharacterization%2C%2Bprogression%2Band%2Btreatment%2Beffects&journal=Neuroimage&volume=54&pages=1244-1253)
- 89
	NaismithS. L.ShineJ. M.LewisS. J. (2010). The specific contributions of set-shifting to freezing of gait in Parkinson’s disease. *Mov. Disord.*25, 1000–1004. 10.1002/mds.23005
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/20198644)
	- [CrossRef](https://doi.org/10.1002/mds.23005)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=S.%2BL..%2BNaismith&author=J.%2BM..%2BShine&author=S.%2BJ..%2BLewis&publication_year=2010&title=The%2Bspecific%2Bcontributions%2Bof%2Bset-shifting%2Bto%2Bfreezing%2Bof%2Bgait%2Bin%2BParkinson%E2%80%99s%2Bdisease&journal=Mov.+Disord.&volume=25&pages=1000-1004)
- 90
	NakaharaH.DoyaK.HikosakaO. (2001). Parallel cortico-basal ganglia mechanisms for acquisition and execution of visuomotor sequences-a computational approach. *J. Cogn. Neurosci.*13, 626–647. 10.1162/089892901750363208
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/11506661)
	- [CrossRef](https://doi.org/10.1162/089892901750363208)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=H..%2BNakahara&author=K..%2BDoya&author=O..%2BHikosaka&publication_year=2001&title=Parallel%2Bcortico-basal%2Bganglia%2Bmechanisms%2Bfor%2Bacquisition%2Band%2Bexecution%2Bof%2Bvisuomotor%2Bsequences-a%2Bcomputational%2Bapproach&journal=J.+Cogn.+Neurosci.&volume=13&pages=626-647)
- 91
	NambuA.TokunoH.TakadaM. (2002). Functional significance of the cortico-subthalamo-pallidal ‘hyperdirect’ pathway. *Neurosci. Res.*43, 111–117. 10.1016/s0168-0102(02)00027-5
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/12067746)
	- [CrossRef](https://doi.org/10.1016/s0168-0102\(02\)00027-5)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=A..%2BNambu&author=H..%2BTokuno&author=M..%2BTakada&publication_year=2002&title=Functional%2Bsignificance%2Bof%2Bthe%2Bcortico-subthalamo-pallidal%2B%E2%80%98hyperdirect%E2%80%99%2Bpathway&journal=Neurosci.+Res.&volume=43&pages=111-117)
- 92
	NivY.DawN. D.JoelD.DayanP. (2007). Tonic dopamine: opportunity costs and the control of response vigor. *Psychopharmacology (Berl)* 191, 507–520. 10.1007/s00213-006-0502-4
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/17031711)
	- [CrossRef](https://doi.org/10.1007/s00213-006-0502-4)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=Y..%2BNiv&author=N.%2BD..%2BDaw&author=D..%2BJoel&author=P..%2BDayan&publication_year=2007&title=Tonic%2Bdopamine%3A%2Bopportunity%2Bcosts%2Band%2Bthe%2Bcontrol%2Bof%2Bresponse%2Bvigor&journal=Psychopharmacology+%28Berl%29&volume=191&pages=507-520)
- 93
	ObesoJ. A.MarinC.Rodriguez-OrozC.BlesaJ.Benitez-TeminoB.Mena-SegoviaJ.et al. (2008). The basal ganglia in Parkinson’s disease: current concepts and unexplained observations. *Ann. Neurol.*64, S30–S46. 10.1002/ana.21481
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/19127584)
	- [CrossRef](https://doi.org/10.1002/ana.21481)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=J.%2BA..%2BObeso&author=C..%2BMarin&author=C..%2BRodriguez-Oroz&author=J..%2BBlesa&author=B..%2BBenitez-Temino&author=J..%2BMena-Segovia&publication_year=2008&title=The%2Bbasal%2Bganglia%2Bin%2BParkinson%E2%80%99s%2Bdisease%3A%2Bcurrent%2Bconcepts%2Band%2Bunexplained%2Bobservations&journal=Ann.+Neurol.&volume=64&pages=S30-S46)
- 94
	O’DohertyJ.DayanP.SchultzJ.DeichmannR.FristonK.DolanR. J. (2004). Dissociable roles of ventral and dorsal striatum in instrumental conditioning. *Science* 304, 452–454. 10.1126/science.1094285
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/15087550)
	- [CrossRef](https://doi.org/10.1126/science.1094285)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=J..%2BO%E2%80%99Doherty&author=P..%2BDayan&author=J..%2BSchultz&author=R..%2BDeichmann&author=K..%2BFriston&author=R.%2BJ..%2BDolan&publication_year=2004&title=Dissociable%2Broles%2Bof%2Bventral%2Band%2Bdorsal%2Bstriatum%2Bin%2Binstrumental%2Bconditioning&journal=Science&volume=304&pages=452-454)
- 95
	OhJ. Y.KimY. S.ChoiB. H.SohnE. H.LeeA. Y. (2009). Relationship between clinical phenotypes and cognitive impairment in Parkinson’s disease (PD). *Arch. Gerontol. Geriatr.*49, 351–354. 10.1016/j.archger.2008.11.013
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/19136159)
	- [CrossRef](https://doi.org/10.1016/j.archger.2008.11.013)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=J.%2BY..%2BOh&author=Y.%2BS..%2BKim&author=B.%2BH..%2BChoi&author=E.%2BH..%2BSohn&author=A.%2BY..%2BLee&publication_year=2009&title=Relationship%2Bbetween%2Bclinical%2Bphenotypes%2Band%2Bcognitive%2Bimpairment%2Bin%2BParkinson%E2%80%99s%2Bdisease%2B%28PD%29&journal=Arch.+Gerontol.+Geriatr.&volume=49&pages=351-354)
- 96
	OhbayashiM.OhkiK.MiyashitaY. (2003). Conversion of working memory to motor sequence in the monkey premotor cortex. *Science* 301, 233–236. 10.1126/science.1084884
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/12855814)
	- [CrossRef](https://doi.org/10.1126/science.1084884)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=M..%2BOhbayashi&author=K..%2BOhki&author=Y..%2BMiyashita&publication_year=2003&title=Conversion%2Bof%2Bworking%2Bmemory%2Bto%2Bmotor%2Bsequence%2Bin%2Bthe%2Bmonkey%2Bpremotor%2Bcortex&journal=Science&volume=301&pages=233-236)
- 97
	O’ReillyR. C.FrankM. J. (2006). Making working memory work: a computational model of learning in the prefrontal cortex and basal ganglia. *Neural Comput.*18, 283–328. 10.1162/089976606775093909
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/16378516)
	- [CrossRef](https://doi.org/10.1162/089976606775093909)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=R.%2BC..%2BO%E2%80%99Reilly&author=M.%2BJ..%2BFrank&publication_year=2006&title=Making%2Bworking%2Bmemory%2Bwork%3A%2Ba%2Bcomputational%2Bmodel%2Bof%2Blearning%2Bin%2Bthe%2Bprefrontal%2Bcortex%2Band%2Bbasal%2Bganglia&journal=Neural+Comput.&volume=18&pages=283-328)
- 98
	PakhotinP.BracciE. (2007). Cholinergic interneurons control the excitatory input to the striatum. *J. Neurosci.*27, 391–400. 10.1523/jneurosci.3709-06.2007
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/17215400)
	- [CrossRef](https://doi.org/10.1523/jneurosci.3709-06.2007)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=P..%2BPakhotin&author=E..%2BBracci&publication_year=2007&title=Cholinergic%2Binterneurons%2Bcontrol%2Bthe%2Bexcitatory%2Binput%2Bto%2Bthe%2Bstriatum&journal=J.+Neurosci.&volume=27&pages=391-400)
- 99
	PiekJ. P.DyckM. J.NiemanA.AndersonM.HayD.SmithL. M.et al. (2004). The relationship between motor coordination, executive functioning and attention in school aged children. *Arch. Clin. Neuropsychol.*19, 1063–1076. 10.1016/j.acn.2003.12.007
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/15533697)
	- [CrossRef](https://doi.org/10.1016/j.acn.2003.12.007)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=J.%2BP..%2BPiek&author=M.%2BJ..%2BDyck&author=A..%2BNieman&author=M..%2BAnderson&author=D..%2BHay&author=L.%2BM..%2BSmith&publication_year=2004&title=The%2Brelationship%2Bbetween%2Bmotor%2Bcoordination%2C%2Bexecutive%2Bfunctioning%2Band%2Battention%2Bin%2Bschool%2Baged%2Bchildren&journal=Arch.+Clin.+Neuropsychol.&volume=19&pages=1063-1076)
- 100
	PhillipsJ. G.StelmachG. E.TeasdaleN. (1991). What can indices of handwriting quality tell us about Parkinsonian handwriting?*Hum. Mov. Sci.*10, 301–314. 10.1016/0167-9457(91)90009-m
	- [CrossRef](https://doi.org/10.1016/0167-9457\(91\)90009-m)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=J.%2BG..%2BPhillips&author=G.%2BE..%2BStelmach&author=N..%2BTeasdale&publication_year=1991&title=What%2Bcan%2Bindices%2Bof%2Bhandwriting%2Bquality%2Btell%2Bus%2Babout%2BParkinsonian%2Bhandwriting%3F&journal=Hum.+Mov.+Sci.&volume=10&pages=301-314)
- 101
	PlotnikM.GiladiN.DaganY.HausdorffJ. M. (2011). Postural instability and fall risk in Parkinson’s disease: impaired dual tasking, pacing and bilateral coordination of gait during the “ON” medication state. *Exp. Brain Res.*210, 529–538. 10.1007/s00221-011-2551-0
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/21279632)
	- [CrossRef](https://doi.org/10.1007/s00221-011-2551-0)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=M..%2BPlotnik&author=N..%2BGiladi&author=Y..%2BDagan&author=J.%2BM..%2BHausdorff&publication_year=2011&title=Postural%2Binstability%2Band%2Bfall%2Brisk%2Bin%2BParkinson%E2%80%99s%2Bdisease%3A%2Bimpaired%2Bdual%2Btasking%2C%2Bpacing%2Band%2Bbilateral%2Bcoordination%2Bof%2Bgait%2Bduring%2Bthe%2B%E2%80%9CON%E2%80%9D%2Bmedication%2Bstate&journal=Exp.+Brain+Res.&volume=210&pages=529-538)
- 102
	PolettiM.BonuccelliU. (2013). Acute and chronic cognitive effects of levodopa and dopamine agonists in patients with Parkinson’s disease: a review. *Ther. Adv. Psychopharmacol.*3, 101–113. 10.1177/2045125312470130
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/24167681)
	- [CrossRef](https://doi.org/10.1177/2045125312470130)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=M..%2BPoletti&author=U..%2BBonuccelli&publication_year=2013&title=Acute%2Band%2Bchronic%2Bcognitive%2Beffects%2Bof%2Blevodopa%2Band%2Bdopamine%2Bagonists%2Bin%2Bpatients%2Bwith%2BParkinson%E2%80%99s%2Bdisease%3A%2Ba%2Breview&journal=Ther.+Adv.+Psychopharmacol.&volume=3&pages=101-113)
- 103
	PolettiM.EmreM.BonuccelliU. (2011). Mild cognitive impairment and cognitive reserve in Parkinson’s disease. *Parkinsonism Relat. Disord.*17, 579–586. 10.1016/j.parkreldis.2011.03.013
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/21489852)
	- [CrossRef](https://doi.org/10.1016/j.parkreldis.2011.03.013)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=M..%2BPoletti&author=M..%2BEmre&author=U..%2BBonuccelli&publication_year=2011&title=Mild%2Bcognitive%2Bimpairment%2Band%2Bcognitive%2Breserve%2Bin%2BParkinson%E2%80%99s%2Bdisease&journal=Parkinsonism+Relat.+Disord.&volume=17&pages=579-586)
- 104
	PolettiM.FrosiniD.PagniC.BaldacciF.NicolettiV.TognoniG.et al. (2012). Mild cognitive impairment and cognitive-motor relationships in newly diagnosed drug-naive patients with Parkinson’s disease. *J. Neurol. Neurosurg. Psychiatry* 83, 601–606. 10.1136/jnnp-2011-301874
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/22492216)
	- [CrossRef](https://doi.org/10.1136/jnnp-2011-301874)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=M..%2BPoletti&author=D..%2BFrosini&author=C..%2BPagni&author=F..%2BBaldacci&author=V..%2BNicoletti&author=G..%2BTognoni&publication_year=2012&title=Mild%2Bcognitive%2Bimpairment%2Band%2Bcognitive-motor%2Brelationships%2Bin%2Bnewly%2Bdiagnosed%2Bdrug-naive%2Bpatients%2Bwith%2BParkinson%E2%80%99s%2Bdisease&journal=J.+Neurol.+Neurosurg.+Psychiatry&volume=83&pages=601-606)
- 105
	PondalM.Del SerT.BermejoF. (1996). Anticholinergic therapy and dementia in patients with Parkinson’s disease. *J. Neurol.*243, 543–546. 10.1007/bf00886877
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/8836945)
	- [CrossRef](https://doi.org/10.1007/bf00886877)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=M..%2BPondal&author=T..%2BDel%2BSer&author=F..%2BBermejo&publication_year=1996&title=Anticholinergic%2Btherapy%2Band%2Bdementia%2Bin%2Bpatients%2Bwith%2BParkinson%E2%80%99s%2Bdisease&journal=J.+Neurol.&volume=243&pages=543-546)
- 106
	PriceA.FiloteoJ. V.MaddoxW. T. (2009). Rule-based category learning in patients with Parkinson’s disease. *Neuropsychologia* 47, 1213–1226. 10.1016/j.neuropsychologia.2009.01.031
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/19428385)
	- [CrossRef](https://doi.org/10.1016/j.neuropsychologia.2009.01.031)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=A..%2BPrice&author=J.%2BV..%2BFiloteo&author=W.%2BT..%2BMaddox&publication_year=2009&title=Rule-based%2Bcategory%2Blearning%2Bin%2Bpatients%2Bwith%2BParkinson%E2%80%99s%2Bdisease&journal=Neuropsychologia&volume=47&pages=1213-1226)
- 107
	Probst-CousinS.DruschkyA.NeundorferB. (2003). Disappearance of resting tremor after “stereotaxic” thalamic stroke. *Neurology* 61, 1013–1014. 10.1212/01.wnl.0000086810.14643.fc
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/14557586)
	- [CrossRef](https://doi.org/10.1212/01.wnl.0000086810.14643.fc)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=S..%2BProbst-Cousin&author=A..%2BDruschky&author=B..%2BNeundorfer&publication_year=2003&title=Disappearance%2Bof%2Bresting%2Btremor%2Bafter%2B%E2%80%9Cstereotaxic%E2%80%9D%2Bthalamic%2Bstroke&journal=Neurology&volume=61&pages=1013-1014)
- 108
	RascolO.SabatiniU.Simonetta-MoreauM.MontastrucL.RascolA.ClanetM. (1991). Square wave jerks in Parkinsonian syndromes. *J. Neurol. Neurosurg. Psychiatry* 54, 599–602. 10.1136/jnnp.54.7.599
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/1895124)
	- [CrossRef](https://doi.org/10.1136/jnnp.54.7.599)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=O..%2BRascol&author=U..%2BSabatini&author=M..%2BSimonetta-Moreau&author=L..%2BMontastruc&author=A..%2BRascol&author=M..%2BClanet&publication_year=1991&title=Square%2Bwave%2Bjerks%2Bin%2BParkinsonian%2Bsyndromes&journal=J.+Neurol.+Neurosurg.+Psychiatry&volume=54&pages=599-602)
- 109
	ReinerA. (2010). “Organization of corticostriatal projection neuron types,” in *Handbook of Basal Ganglia Structure and Function*, eds SteinerH.TsengK. Y. (New York, NY: Academic Press), 323–340.
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=A..%2BReiner&publication_year=2010&title=Organization%2Bof%2Bcorticostriatal%2Bprojection%2Bneuron%2Btypes&journal=Handbook+of+Basal+Ganglia+Structure+and+Function&pages=323-340)
- 110
	ReynoldsJ. N. J.HylandB. I.WickensJ. R. (2001). A cellular mechanism of reward-related learning. *Nature* 413, 67–70. 10.1038/35092560
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/11544526)
	- [CrossRef](https://doi.org/10.1038/35092560)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=J.%2BN.%2BJ..%2BReynolds&author=B.%2BI..%2BHyland&author=J.%2BR..%2BWickens&publication_year=2001&title=A%2Bcellular%2Bmechanism%2Bof%2Breward-related%2Blearning&journal=Nature&volume=413&pages=67-70)
- 111
	SchillaciO.ChiaravallotiA.PierantozziM.Di PietroB.KochG.BruniC.et al. (2011). Different patterns of nigrostriatal degeneration in tremor type versus the akinetic-rigid and mixed types of Parkinson’s disease at the early stages: molecular imaging with 123I-FP-CIT SPECT. *Int. J. Mol. Med.*28, 881–886. 10.3892/ijmm.2011.764
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/21811760)
	- [CrossRef](https://doi.org/10.3892/ijmm.2011.764)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=O..%2BSchillaci&author=A..%2BChiaravalloti&author=M..%2BPierantozzi&author=B..%2BDi%2BPietro&author=G..%2BKoch&author=C..%2BBruni&publication_year=2011&title=Different%2Bpatterns%2Bof%2Bnigrostriatal%2Bdegeneration%2Bin%2Btremor%2Btype%2Bversus%2Bthe%2Bakinetic-rigid%2Band%2Bmixed%2Btypes%2Bof%2BParkinson%E2%80%99s%2Bdisease%2Bat%2Bthe%2Bearly%2Bstages%3A%2Bmolecular%2Bimaging%2Bwith%2B123I-FP-CIT%2BSPECT&journal=Int.+J.+Mol.+Med.&volume=28&pages=881-886)
- 112
	SchomakerL. R. B. (1991). *Simulation and Recognition of Handwriting Movements: A Vertical Approach to Modeling Human Motor Behavior*. (Doctoral Dissertation, Nijmegen University).
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=L.%2BR.%2BB..%2BSchomaker&publication_year=1991&journal=Simulation+and+Recognition+of+Handwriting+Movements%3A+A+Vertical+Approach+to+Modeling+Human+Motor+Behavior)
- 113
	SchrollH.VitayJ.HamkerF. H. (2012). Working memory and response selection: a computational account of interactions among cortico-basal ganglio-thalamic loops. *Neural Netw.*26, 59–74. 10.1016/j.neunet.2011.10.008
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/22075035)
	- [CrossRef](https://doi.org/10.1016/j.neunet.2011.10.008)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=H..%2BSchroll&author=J..%2BVitay&author=F.%2BH..%2BHamker&publication_year=2012&title=Working%2Bmemory%2Band%2Bresponse%2Bselection%3A%2Ba%2Bcomputational%2Baccount%2Bof%2Binteractions%2Bamong%2Bcortico-basal%2Bganglio-thalamic%2Bloops&journal=Neural+Netw.&volume=26&pages=59-74)
- 114
	SegerC. A. (2008). How do the basal ganglia contribute to categorization? Their roles in generalization, response selection and learning via feedback. *Neurosci. Biobehav. Rev.*32, 265–278. 10.1016/j.neubiorev.2007.07.010
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/17919725)
	- [CrossRef](https://doi.org/10.1016/j.neubiorev.2007.07.010)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=C.%2BA..%2BSeger&publication_year=2008&title=How%2Bdo%2Bthe%2Bbasal%2Bganglia%2Bcontribute%2Bto%2Bcategorization%3F%2BTheir%2Broles%2Bin%2Bgeneralization%2C%2Bresponse%2Bselection%2Band%2Blearning%2Bvia%2Bfeedback&journal=Neurosci.+Biobehav.+Rev.&volume=32&pages=265-278)
- 115
	SheridanM. R.FlowersK. A. (1990). Movement variability and bradykinesia in Parkinson’s disease. *Brain* 113, 1149–1161. 10.1093/brain/113.4.1149
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/2397387)
	- [CrossRef](https://doi.org/10.1093/brain/113.4.1149)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=M.%2BR..%2BSheridan&author=K.%2BA..%2BFlowers&publication_year=1990&title=Movement%2Bvariability%2Band%2Bbradykinesia%2Bin%2BParkinson%E2%80%99s%2Bdisease&journal=Brain&volume=113&pages=1149-1161)
- 116
	ShineJ. M.MatarE.LewisS. J. G. (2013). Differential neural activation patterns in patients with Parkinson’s disease and freezing of gait in response to concurrent cognitive and motor load. *PLoS One* 8:e52602. 10.1371/journal.pone.0052602
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/23382821)
	- [CrossRef](https://doi.org/10.1371/journal.pone.0052602)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=J.%2BM..%2BShine&author=E..%2BMatar&author=S.%2BJ.%2BG..%2BLewis&publication_year=2013&title=Differential%2Bneural%2Bactivation%2Bpatterns%2Bin%2Bpatients%2Bwith%2BParkinson%E2%80%99s%2Bdisease%2Band%2Bfreezing%2Bof%2Bgait%2Bin%2Bresponse%2Bto%2Bconcurrent%2Bcognitive%2Band%2Bmotor%2Bload&journal=PLoS+One&volume=8)
- 117
	SilbersteinP.PogosyanA.KuhnA. A.HottonG.TischS.KupschA.et al. (2005). Cortico-cortical coupling in Parkinson’s disease and its modulation by therapy. *Brain* 128, 1277–1291. 10.1093/brain/awh480
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/15774503)
	- [CrossRef](https://doi.org/10.1093/brain/awh480)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=P..%2BSilberstein&author=A..%2BPogosyan&author=A.%2BA..%2BKuhn&author=G..%2BHotton&author=S..%2BTisch&author=A..%2BKupsch&publication_year=2005&title=Cortico-cortical%2Bcoupling%2Bin%2BParkinson%E2%80%99s%2Bdisease%2Band%2Bits%2Bmodulation%2Bby%2Btherapy&journal=Brain&volume=128&pages=1277-1291)
- 118
	SmithY.GalvanA.RajuD.WichmannT. (2010). “Anatomical and functional organization of the thalamostriatal systems,” in *Handbook of Basal Ganglia Structure and Function*, eds SteinerH.TsengK. Y. (New York, NY: Academic Press), 381–396.
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=Y..%2BSmith&author=A..%2BGalvan&author=D..%2BRaju&author=T..%2BWichmann&publication_year=2010&title=Anatomical%2Band%2Bfunctional%2Borganization%2Bof%2Bthe%2Bthalamostriatal%2Bsystems&journal=Handbook+of+Basal+Ganglia+Structure+and+Function&pages=381-396)
- 119
	SmithY.RajuD. V.PareJ. F.SidibeM. (2004). The thalamostriatal system: a highly specific network of the basal ganglia circuitry. *Trends Neurosci.*27, 520–527. 10.1016/j.tins.2004.07.004
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/15331233)
	- [CrossRef](https://doi.org/10.1016/j.tins.2004.07.004)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=Y..%2BSmith&author=D.%2BV..%2BRaju&author=J.%2BF..%2BPare&author=M..%2BSidibe&publication_year=2004&title=The%2Bthalamostriatal%2Bsystem%3A%2Ba%2Bhighly%2Bspecific%2Bnetwork%2Bof%2Bthe%2Bbasal%2Bganglia%2Bcircuitry&journal=Trends+Neurosci.&volume=27&pages=520-527)
- 120
	SteinerH.TsengK. Y. (2010). *Handbook of Basal Ganglia Structure and Function*. New York: Academic Press.
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=H..%2BSteiner&author=K.%2BY..%2BTseng&publication_year=2010&journal=Handbook+of+Basal+Ganglia+Structure+and+Function)
- 121
	TessitoreA.AmboniM.CirilloG.CorboD.PicilloM.RussoA.et al. (2012). Regional gray matter atrophy in patients with Parkinson disease and freezing of gait. *AJNR Am. J. Neuroradiol.*33, 1804–1809. 10.3174/ajnr.a3066
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/22538070)
	- [CrossRef](https://doi.org/10.3174/ajnr.a3066)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=A..%2BTessitore&author=M..%2BAmboni&author=G..%2BCirillo&author=D..%2BCorbo&author=M..%2BPicillo&author=A..%2BRusso&publication_year=2012&title=Regional%2Bgray%2Bmatter%2Batrophy%2Bin%2Bpatients%2Bwith%2BParkinson%2Bdisease%2Band%2Bfreezing%2Bof%2Bgait&journal=AJNR+Am.+J.+Neuroradiol.&volume=33&pages=1804-1809)
- 122
	TeulingsH. L.StelmachG. E. (1991). Control of stroke size, peak acceleration and stroke duration in Parkinsonian handwriting. *Hum. Mov. Sci.*10, 315–334. 10.1016/0167-9457(91)90010-u
	- [CrossRef](https://doi.org/10.1016/0167-9457\(91\)90010-u)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=H.%2BL..%2BTeulings&author=G.%2BE..%2BStelmach&publication_year=1991&title=Control%2Bof%2Bstroke%2Bsize%2C%2Bpeak%2Bacceleration%2Band%2Bstroke%2Bduration%2Bin%2BParkinsonian%2Bhandwriting&journal=Hum.+Mov.+Sci.&volume=10&pages=315-334)
- 123
	VakilE.Herishanu-NaamanS. (1998). Declarative and procedural learning in Parkinson’s disease patients having tremor or bradykinesia as the predominant symptom. *Cortex* 34, 611–620. 10.1016/s0010-9452(08)70518-5
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/9800094)
	- [CrossRef](https://doi.org/10.1016/s0010-9452\(08\)70518-5)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=E..%2BVakil&author=S..%2BHerishanu-Naaman&publication_year=1998&title=Declarative%2Band%2Bprocedural%2Blearning%2Bin%2BParkinson%E2%80%99s%2Bdisease%2Bpatients%2Bhaving%2Btremor%2Bor%2Bbradykinesia%2Bas%2Bthe%2Bpredominant%2Bsymptom&journal=Cortex&volume=34&pages=611-620)
- 124
	VandenbosscheJ.DeroostN.SoetensE.SpildoorenJ.VercruysseS.NieuwboerA.et al. (2011). Freezing of gait in Parkinson disease is associated with impaired conflict resolution. *Neurorehabil. Neural Repair* 25, 765–773. 10.1177/1545968311403493
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/21478498)
	- [CrossRef](https://doi.org/10.1177/1545968311403493)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=J..%2BVandenbossche&author=N..%2BDeroost&author=E..%2BSoetens&author=J..%2BSpildooren&author=S..%2BVercruysse&author=A..%2BNieuwboer&publication_year=2011&title=Freezing%2Bof%2Bgait%2Bin%2BParkinson%2Bdisease%2Bis%2Bassociated%2Bwith%2Bimpaired%2Bconflict%2Bresolution&journal=Neurorehabil.+Neural+Repair&volume=25&pages=765-773)
- 125
	Van GemmertA. W. A.AdlerC. H.StelmachG. E. (2003). Parkinson’s disease patients undershoot target size in handwriting and similar tasks. *J. Neurol. Neurosurg. Psychiatry* 74, 1502–1508. 10.1136/jnnp.74.11.1502
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/14617705)
	- [CrossRef](https://doi.org/10.1136/jnnp.74.11.1502)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=A.%2BW.%2BA..%2BVan%2BGemmert&author=C.%2BH..%2BAdler&author=G.%2BE..%2BStelmach&publication_year=2003&title=Parkinson%E2%80%99s%2Bdisease%2Bpatients%2Bundershoot%2Btarget%2Bsize%2Bin%2Bhandwriting%2Band%2Bsimilar%2Btasks&journal=J.+Neurol.+Neurosurg.+Psychiatry&volume=74&pages=1502-1508)
- 126
	Van GemmertA. W. A.TeulingsH. L.Contreras–VidalJ. L.StelmachG. E. (1999). Parkinson’s disease and the control of size and speed in handwriting. *Neuropsychologia* 37, 685–694. 10.1016/s0028-3932(98)00122-5
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/10390030)
	- [CrossRef](https://doi.org/10.1016/s0028-3932\(98\)00122-5)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=A.%2BW.%2BA..%2BVan%2BGemmert&author=H.%2BL..%2BTeulings&author=J.%2BL..%2BContreras%E2%80%93Vidal&author=G.%2BE..%2BStelmach&publication_year=1999&title=Parkinson%E2%80%99s%2Bdisease%2Band%2Bthe%2Bcontrol%2Bof%2Bsize%2Band%2Bspeed%2Bin%2Bhandwriting&journal=Neuropsychologia&volume=37&pages=685-694)
- 127
	WeinbergerM.HutchisonW. D.LozanoA. M.HodaieM.DostrovskyJ. O. (2009). Increased gamma oscillatory activity in the subthalamic nucleus during tremor in Parkinson’s disease patients. *J. Neurophysiol.*101, 789–802. 10.1152/jn.90837.2008
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/19004998)
	- [CrossRef](https://doi.org/10.1152/jn.90837.2008)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=M..%2BWeinberger&author=W.%2BD..%2BHutchison&author=A.%2BM..%2BLozano&author=M..%2BHodaie&author=J.%2BO..%2BDostrovsky&publication_year=2009&title=Increased%2Bgamma%2Boscillatory%2Bactivity%2Bin%2Bthe%2Bsubthalamic%2Bnucleus%2Bduring%2Btremor%2Bin%2BParkinson%E2%80%99s%2Bdisease%2Bpatients&journal=J.+Neurophysiol.&volume=101&pages=789-802)
- 128
	WeissP.StelmachG. E.HefterH. (1997). Programming of a movement sequence in Parkinson’s disease. *Brain* 120, 91–102. 10.1093/brain/120.1.91
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/9055800)
	- [CrossRef](https://doi.org/10.1093/brain/120.1.91)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=P..%2BWeiss&author=G.%2BE..%2BStelmach&author=H..%2BHefter&publication_year=1997&title=Programming%2Bof%2Ba%2Bmovement%2Bsequence%2Bin%2BParkinson%E2%80%99s%2Bdisease&journal=Brain&volume=120&pages=91-102)
- 129
	WickensJ. R.BeggA. J.ArbuthnottG. W. (1996). Dopamine reverses the depression of rat corticostriatal synapses which normally follows high-frequency stimulation of cortex in vitro. *Neuroscience* 70, 1–5. 10.1016/0306-4522(95)00436-m
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/8848115)
	- [CrossRef](https://doi.org/10.1016/0306-4522\(95\)00436-m)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=J.%2BR..%2BWickens&author=A.%2BJ..%2BBegg&author=G.%2BW..%2BArbuthnott&publication_year=1996&title=Dopamine%2Breverses%2Bthe%2Bdepression%2Bof%2Brat%2Bcorticostriatal%2Bsynapses%2Bwhich%2Bnormally%2Bfollows%2Bhigh-frequency%2Bstimulation%2Bof%2Bcortex%2Bin%2Bvitro&journal=Neuroscience&volume=70&pages=1-5)
- 130
	WilsonC. J. (2004). “Basal ganglia,” in *The Synaptic Organization of the Brain*, ed ShepherdG. M. (New York: Oxford University Press), 361–414.
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=C.%2BJ..%2BWilson&publication_year=2004&title=Basal%2Bganglia&journal=The+Synaptic+Organization+of+the+Brain&pages=361-414)
- 131
	YeterianE. H.PandyaD. N. (1993). Striatal connections of the parietal association cortices in rhesus monkeys. *J. Comp. Neurol.*332, 175–197. 10.1002/cne.903320204
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/8331211)
	- [CrossRef](https://doi.org/10.1002/cne.903320204)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=E.%2BH..%2BYeterian&author=D.%2BN..%2BPandya&publication_year=1993&title=Striatal%2Bconnections%2Bof%2Bthe%2Bparietal%2Bassociation%2Bcortices%2Bin%2Brhesus%2Bmonkeys&journal=J.+Comp.+Neurol.&volume=332&pages=175-197)
- 132
	YeterianE. H.PandyaD. N. (1995). Corticostriatal connections of extrastriate visual areas in rhesus monkeys. *J. Comp. Neurol.*352, 436–457. 10.1002/cne.903520309
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/7706560)
	- [CrossRef](https://doi.org/10.1002/cne.903520309)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=E.%2BH..%2BYeterian&author=D.%2BN..%2BPandya&publication_year=1995&title=Corticostriatal%2Bconnections%2Bof%2Bextrastriate%2Bvisual%2Bareas%2Bin%2Brhesus%2Bmonkeys&journal=J.+Comp.+Neurol.&volume=352&pages=436-457)
- 133
	YeterianE. H.PandyaD. N. (1998). Corticostriatal connections of the superior temporal region in rhesus monkeys. *J. Comp. Neurol.*399, 384–402. 10.1002/(sici)1096-9861(19980928)399:3<384::aid-cne7>3.0.co;2-x
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/9733085)
	- [CrossRef](https://doi.org/10.1002/\(sici\)1096-9861\(19980928\)399:3%3C384::aid-cne7%3E3.0.co;2-x)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=E.%2BH..%2BYeterian&author=D.%2BN..%2BPandya&publication_year=1998&title=Corticostriatal%2Bconnections%2Bof%2Bthe%2Bsuperior%2Btemporal%2Bregion%2Bin%2Brhesus%2Bmonkeys&journal=J.+Comp.+Neurol.&volume=399&pages=384-402)
- 134
	YinH. H.OstlundS. B.KnowltonB. J.BalleineB. W. (2005). The role of the dorsomedial striatum in instrumental conditioning. *Eur. J. Neurosci.*22, 513–523. 10.1111/j.1460-9568.2005.04218.x
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/16045504)
	- [CrossRef](https://doi.org/10.1111/j.1460-9568.2005.04218.x)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=H.%2BH..%2BYin&author=S.%2BB..%2BOstlund&author=B.%2BJ..%2BKnowlton&author=B.%2BW..%2BBalleine&publication_year=2005&title=The%2Brole%2Bof%2Bthe%2Bdorsomedial%2Bstriatum%2Bin%2Binstrumental%2Bconditioning&journal=Eur.+J.+Neurosci.&volume=22&pages=513-523)
- 135
	ZaidelA.ArkadirD.IsraelZ.BergmanH. (2009). Akineto-rigid vs. tremor syndromes in Parkinsonism. *Curr. Opin. Neurol.*22, 387–393. 10.1097/wco.0b013e32832d9d67
	- [Pubmed Abstract](https://pubmed.ncbi.nlm.nih.gov/19494773)
	- [CrossRef](https://doi.org/10.1097/wco.0b013e32832d9d67)
	- [Google Scholar](http://scholar.google.com/scholar_lookup?author=A..%2BZaidel&author=D..%2BArkadir&author=Z..%2BIsrael&author=H..%2BBergman&publication_year=2009&title=Akineto-rigid%2Bvs.%2Btremor%2Bsyndromes%2Bin%2BParkinsonism&journal=Curr.+Opin.+Neurol.&volume=22&pages=387-393)

## Summary

Keywords

basal ganglia, computational cognitive neuroscience, cognitive function, motor function, Parkinson’s disease

Citation

Helie S, Chakravarthy S and Moustafa AA (2013) Exploring the cognitive and motor functions of the basal ganglia: an integrative review of computational cognitive neuroscience models. *Front. Comput. Neurosci.* 7:174. doi: [10.3389/fncom.2013.00174](http://dx.doi.org/10.3389/fncom.2013.00174)

Received

31 July 2013

Accepted

15 November 2013

Published

06 December 2013

Volume

7 - 2013

Edited by

Izhar Bar-Gad, Bar-Ilan University, Israel

Reviewed by

Thomas Boraud, Université de Bordeaux, CNRS, France; Arvind Kumar, University of Freiburg, Germany

Copyright

[^1]: Figure 1                   

Virtually all of the neocortex sends excitatory (glutamatergic) projections to the striatum (Reiner, ). Corticostriatal input is massively convergent with estimates ranging from 5,000 to 10,000 cortical neurons converging on a single striatal medium spiny neuron (MSN; the main striatal projection neurons) (Kincaid et al., ). Classically, corticostriatal organization is thought to follow a fairly strict spatial topography (Kemp and Powell, ). Along the rostral-to-caudal extent of the BG, the cortical afferents tend be more prevalent from rostral-to-caudal cortical regions. For instance, ventral striatum receives input predominantly from orbitofrontal cortex, ventromedial prefrontal cortex, and anterior cingulate cortex (ACC). As one moves caudally within the striatum, inputs from areas 9, 46, and 8 become more prevalent (Haber et al.,; Calzavara et al., ), followed by inputs from premotor regions (area 6) with the most caudal motor and somatosensory cortical regions projecting preferentially to the caudal putamen (Flaherty and Graybiel, ). Spatial topography holds as you continue rostrally and ventrally through parietal and temporal cortices as well as other extrastriate visual areas (Kemp and Powell,; Yeterian and Pandya,,, ).

The thalamus provides another major source of input to the BG (Wilson, ), with the majority of thalamostriatal projections originating from the parafascicular-centromedian (CMPf) complex (Smith et al., ). Thalamic input to the striatum synapses on both MSNs and cholinergic tonically active neurons (TANs; a class of large-body interneurons) (Smith et al., ), with the latter likely playing an important role in modulating cortico-striatal synaptic plasticity (Ashby and Crossley, ). Finally, thalamic input to the striatum is in a position to modulate BG function by virtue of cortico-thalamo-striatal connections and striatal-thalamo-striatal feedback (Smith et al., ).

The BG also receives dopaminergic input that plays a critical role in modulating striatal activity. Dopamine is projected from the ventral tegmental area and SN pars compacta to the BG and prefrontal cortex, among other brain regions. Dopamine firing patterns fluctuate between two different modes: phasic and tonic. While the phasic mode is fast-acting and spans milliseconds, the tonic mode is long-acting and can span minutes or hours. The dissociable function of both phasic and tonic dopamine is debatable (Dreher and Burnod,; Assadi et al.,; Moustafa et al., ). However, various studies suggest that phasic dopamine plays a key role in synaptic plasticity and reinforcement learning (Wickens et al.,; Reynolds et al., ), while tonic dopamine is important for speeding-up reaction times (Niv et al.,; Moustafa et al., ) and controlling the signal-to-noise ratio (Durstewitz and Seamans, ).

Information flow through the BG follows two distinct pathways (see Figure ). Striatal MSNs in the direct pathway project directly to the output nuclei (e.g., GPi) and selectively express D1-like receptors (i.e., D1 and D5; Gerfen et al., ). The striatal MSNs in the indirect pathway project to the external segment of the GP Globus pallidus (external) (GPe) prior to reaching the output nuclei of the BG (e.g., GPi), and selectively express D2-like receptors (i.e., D2, D3, and D4; Gerfen and Young, ). In addition to the direct and indirect pathways, the STN is another major input structure of the BG receiving extensive cortical and thalamic input. This so-called hyperdirect pathway provides a means by which frontal cortical regions can monosynapically influence STN function (Nambu et al., ).

With abundant dopamine receptors in the BG affecting the dynamics of the different pathways, most CCN models of the BG include a role for dopamine. One important way of testing whether the hypothesized role for dopamine in the model is adequate is to simulate the model under dopamine-depleted conditions. Specifically, reducing the amount of dopamine available in the model should produce Parkinsonian symptoms. Parkinson’s disease (PD) is caused by the accelerated death of dopamine producing neurons. The pattern of cell loss is opposite to that of, and more severe than in, normal aging. Within the SN pars compacta, cell loss is predominately found in the ventral tier with less (but still extensive) damage in the dorsal tier (Fearnley and Lees,; Gibb and Lees, ). In contrast, normal aging yields substantially less cell loss and in a dorsal-to-ventral pattern. Parkinsonian motor symptoms appear after a loss of 60–70% of SN pars compacta cells and 70–80% of dopamine levels in striatal nuclei (Bernheimer et al.,; Gibb and Lees, ). Motor symptoms include tremor, rigidity, bradykinesia, and akinesia. In addition to motor deficits, non-demented PD patients present cognitive symptoms that resemble those observed in patients with frontal damage. Numerous studies documenting cognitive deficits of PD patients have revealed impairment in a variety of tasks related to memory, learning, visuospatial skills, and attention (e.g., Gotham et al.,; Price et al., ).

[^2]: Table 1  

<table><thead><tr><td></td><td>DP (1)</td><td>IP (2)</td><td>HP (3)</td><td>Str</td><td>GPi</td><td>GPe</td><td>STN</td></tr></thead><tbody><tr><td colspan="7"><b>Cognitive</b></td></tr><tr><td>Ashby et al. ()</td><td>X</td><td></td><td></td><td>X</td><td>X</td><td></td><td></td></tr><tr><td>Moustafa and Gluck ()</td><td>X</td><td></td><td></td><td>X</td><td></td><td></td><td></td></tr><tr><td>Ashby and Crossley ()</td><td>X</td><td></td><td></td><td>X</td><td>X</td><td></td><td></td></tr><tr><td>Frank ()</td><td>X</td><td>X</td><td></td><td>X</td><td>X</td><td>X</td><td></td></tr><tr><td>Guthrie et al. ()</td><td>X</td><td></td><td>X</td><td>X</td><td>X</td><td></td><td>X</td></tr><tr><td>Monchi et al. ()</td><td>X</td><td></td><td></td><td>X</td><td>X</td><td></td><td></td></tr><tr><td>Ashby et al. ()</td><td>X</td><td></td><td></td><td>X</td><td>X</td><td></td><td></td></tr><tr><td>Frank et al. ()</td><td>X</td><td></td><td></td><td>X</td><td>X</td><td></td><td></td></tr><tr><td>Moustafa and Maida ()</td><td>X</td><td></td><td></td><td>X</td><td></td><td></td><td></td><td></td></tr><tr><td>Schroll et al. ()</td><td>X</td><td></td><td>X</td><td>X</td><td>X</td><td>X</td><td>X</td></tr><tr><td>Nakahara et al. ()</td><td>X</td><td></td><td>X</td><td>X</td><td></td><td></td><td></td></tr><tr><td>Ashby et al. ()</td><td>X</td><td></td><td></td><td>X</td><td>X</td><td></td><td></td></tr><tr><td>Chersi et al. ()</td><td>X</td><td>X</td><td>X</td><td>X</td><td>*</td><td>X</td><td>X</td></tr><tr><td colspan="7"><b>Motor</b></td></tr><tr><td>Bischoff ()</td><td>X</td><td>X</td><td></td><td>X</td><td>X</td><td>X</td><td>X</td></tr><tr><td>Magdoom et al. ()</td><td>X</td><td>X</td><td></td><td>X</td><td></td><td></td><td></td></tr><tr><td>Gangadhar et al. ()</td><td></td><td>X</td><td></td><td></td><td></td><td>X</td><td>X</td></tr><tr><td>Contreras-Vidal and Stelmach ()</td><td>X</td><td>X</td><td>X</td><td>X</td><td>X</td><td>X</td><td>X</td></tr><tr><td>Dominey and Arbib ()</td><td>X</td><td></td><td></td><td>X</td><td>*</td><td></td><td></td></tr><tr><td>Krishnan et al. ()</td><td>X</td><td>X</td><td></td><td>X</td><td>*</td><td>X</td><td>X</td></tr></tbody></table>

Summary of the basal ganglia components included in the reviewed models.

*Note. DP = Direct pathway \[(1) in Figure \]; IP = Indirect pathway \[(2) in Figure \]; HP = Hyperdirect pathway \[(3) in Figure \]; Str = Striatum; GPi = Globus pallidus (internal); GPe = Globus pallidus (external); STN = Subthalamic nucleus. \* These models used the substantia nigra pars reticulate (SNr) as their output node of the basal ganglia. In this context, the SNr is functionally equivalent to the GPi*.

### Categorization

Categorization is the ubiquitous process by which individual items are grouped to form categories. The massive convergence of cortico-striatal connectivity makes the BG an ideal site for categorization, and much research supports the role of the BG in category learning (for a review, see Seger, ).

#### Models

One of the earliest and most prominent neurobiological models of categorization is called COVIS (Ashby et al., ). COVIS is a multiple-system theory that was originally developed to account for the many behavioral dissociations between verbal and non-verbal categorization (as described by the general recognition theory; Ashby and Gott, ). COVIS includes an hypothesis-testing system and a procedural learning system. The hypothesis-testing system can quickly learn a small set of (e.g., verbal) categories (those that can be found by hypothesis-testing and often be verbally described) while the procedural learning system can learn any type of arbitrary categories in a slow trial-and-error manner (e.g., non-verbal). Each categorization system relies on a separate brain circuit but, interestingly, they both include the BG. In the hypothesis-testing system, the BG is used to support working memory maintenance and for rule switching. In the procedural system, the BG is used to learn stimulus—response associations. The COVIS model of categorization has been used to simulate a large number of category learning experiments and made several behavioral predictions, many of which have been later confirmed by empirical experiments (for a review, Maddox and Ashby, ). For example, COVIS predicts that delaying the feedback in verbal categorization should not affect performance (because the hypothesis-testing system relies on working memory) whereas delaying feedback in non-verbal categorization should impair learning (because the procedural learning system relies on dopamine-mediated reinforcement learning in the BG). This prediction was confirmed in Ashby et al. (). In addition, reducing dopamine levels in COVIS can account for many cognitive symptoms in PD patients such as perseveration, reduced sensitivity to negative feedback, and others (see Helie et al.,, ). Likewise, dopamine elevation can account for the effect of positive affect on verbal category learning (Helie et al., ). While most COVIS simulations have used a rate version of the model, a spiking version of the procedural-learning system has been used to account for some categorization results and extended to account for instrumental conditioning (Ashby and Crossley, ) and automaticity (Ashby et al., ).

As an alternative, Moustafa and Gluck (,) proposed a computational model of the striatum and prefrontal cortex that focuses on the dopamine projections to these areas as well as their interactions during multi-cue category learning. In this task, participants learn to select and pay attention to a single cue among a multi-cue pattern, and then make a categorization response. Participants learn this task via corrective feedback. In the model, the prefrontal cortex is essential for attentional selection while the striatum is used for motor response selection. Similar to COVIS, the Moustafa and Gluck (,) model can account for categorization deficits in PD patients by reducing dopamine levels in both the BG and prefrontal cortex, which is in agreement with empirical results (Kaasinen et al.,; Silberstein et al., ). Additionally, the Moustafa and Gluck (,) model can account for some effects of dopaminergic and anticholinergic medication. The Moustafa and Gluck (,) model assumes that the administration of anticholinergic medications in PD interferes with hippocampal function, which is also in agreement with empirical studies (Meco et al.,; Pondal et al.,; Ehrt et al.,; Herzallah et al., ). In contrast, the current version of COVIS has not been used to simulate medication effects in PD.

#### Synthesis

The reviewed models of categorization both agree that the BG, and its interaction with the prefrontal cortex, are essential for category learning. Furthermore, they agree that dopamine levels in both the BG and prefrontal cortex are important. While COVIS (Ashby et al., ) has been used to simulate a wider range of categorization tasks, the Moustafa and Gluck (,) model has been used to simulate more details in a smaller subset. For example, one limitation of the Moustafa and Gluck (,) model is that it does not simulate complex multi-cue learning tasks that involve paying attention to more than one stimulus (which can be done using COVIS). However, the Moustafa and Gluck (,) model can simulate the effect of dopaminergic medication, whereas COVIS has not been used to simulate medication effects. One important difference between the COVIS and Moustafa and Gluck (,) model is that COVIS assigns a different role for BG and cortical dopamine, namely error signal and signal gain (respectively). In contrast, Moustafa and Gluck (,) assign both of these roles to dopamine in both the BG and the prefrontal cortex. In addition, an important limitation of both models is that they oversimplify the anatomy of the BG by not including the indirect and hyperdirect pathways. Future work aimed at increasing the biological accuracy of COVIS and the Moustafa and Gluck (,) models may highlight some additional key differences between the modeling approaches and allow for selecting the most appropriate BG model of categorization.

### Instrumental conditioning

Instrumental conditioning (also called “operant” conditioning) is a process by which animals learn to behave in a way that will maximize reward and minimize punishment. In a typical instrumental conditioning experiment, a neutral environment is altered and begins generating rewards (acquisition phase). Next, the reward is removed from the environment and the environment reverts to its neutral state (extinction phase). Extinction is usually followed by a reacquisition phase, where the reward is introduced again in the same neutral environment. Typically, a new behavior is learned during the acquisition phase, and progressively disappears during the extinction phase. The behavior reappears during the reacquisition phase, usually at a much faster rate than during the initial acquisition phase. This phenomenon is called *fast reacquisition*. Much evidence implicates the BG in instrumental conditioning (e.g., O’Doherty et al.,; Yin et al., ), but the neurobiology underlying extinction and fast reacquisition is poorly understood.

#### Models

Ashby and Crossley () proposed a spiking model of the direct pathway of the BG (see Figure ) inspired by the COVIS procedural learning system (Ashby et al., ) to account for instrumental conditioning. The Ashby and Crossley () model focuses on the TANs, a population of cholinergic interneurons in the striatum that is rarely included in CCN models of the BG. Pakhotin and Bracci () have shown that TANs play an important role in inhibiting cortical activation of the MSNs (i.e., the projection neurons generally modeled in the direct and indirect pathways). As suggested by their name, TANs have a high baseline firing rate, but they learn to pause in rewarding contexts (Apicella, ). Ashby and Crossley () suggest that one possible role for the TANs is to protect striatal learning from catastrophic interference and allow for fast reacquisition. In addition to the direct pathway, the Ashby and Crossley () model includes a sensory association area, the supplementary motor area (SMA), and the CMPf complex.

The Ashby and Crossley () model is an opened loop through the BG (from sensory association cortex to the SMA). The stimulus activates the sensory association cortex, which in turn activates the striatum and the direct pathway of the BG. At the same time, the context activates the CMPf complex, which transmits activation to the TANs (this pathway is not included in Figure ). At the beginning of an experiment, the simulated subject does not know that the context is rewarding. Hence, the TANs do not pause, and the MSNs in the direct pathway cannot be activated by the sensory association cortex. This prevents stimulus—response association learning. During the acquisition phase, the TANs quickly learn that the context is rewarding and pause. The MSNs are thus released from inhibition and the model learns to produce the rewarding behavior using reinforcement learning. Next, during the extinction phase, the TANs learn that the context is no longer rewarding and stop pausing. This change inhibits the MSNs and interrupts cortico-striatal learning. Hence, the associations that were learned during the acquisition phase are protected. Finally, during the reacquisition phase, the context becomes rewarding again, and the TANs learn to pause. The MSNs are released from inhibition, and the learned associations are in the same state as in the acquisition phase, which produces fast reacquisition. Using this process, the model has been used to reproduce the acquisition, extinction, and fast reacquisition phases typical of instrumental conditioning and single-cell recording data from TANs showing that the cells learn to pause in rewarding contexts (Ashby and Crossley, ).

#### Synthesis

The Ashby and Crossley () model is the only CCN model of instrumental conditioning that can simultaneously account for behavioral (e.g., fast reacquisition) and single-cell data (from the TANs). This model constitutes an important step in that it provides an implementation and numerical simulation of the theory that TANs learn to pause in rewarding contexts, and how this can affect reinforcement learning in the BG. However, the neuroanatomy of the BG was simplified in that only the direct pathway through one of the cortico-BG loops was included. It is unclear at this time how the TANs’ dynamics would affect the indirect pathway, or how the model would behave if more than one loops was included. Future work is needed to verify how the theory implemented in Ashby and Crossley () behaves in a more detailed model of the BG.

### Probabilistic learning

Probabilistic learning typically refers to tasks where the association between the response and the reward is uncertain. Unlike most categorization experiments, the same response to the same stimulus can result in different outcomes on different trials. While probabilistic learning has been shown to rely on the BG since the mid-1990s (Knowlton et al., ), it took a decade before CCN models of the BG were used to attempt to account for probabilistic learning.

#### Models

The Frank () model was originally proposed to account for cognitive deficits in parkinsonism. The model includes both the direct and indirect pathways through the BG (see Figure ), the premotor cortex, and an unspecified input area (probably located in posterior cortex) (so the model is an opened loop). In the Frank () model, the input activates both the premotor cortex and the striatum. However, cortical activation is insufficient to produce a response, so BG processing is required to gate the correct response. The focus of the model is on: (1) the role of the indirect pathway in probabilistic learning and (2) the role of dopamine in probabilistic learning. In the Frank () model, the direct pathway is in charge of selecting the appropriate action (Go) whereas the indirect pathway is in charge of inhibiting inappropriate actions (NoGo). The direct and indirect pathways converge in the GPi and compete to control GPi activation, and eventually the response. Simulation results show that removing the indirect pathway in the model reduces performance, suggesting that both the direct and indirect pathways are essential in probabilistic learning. In addition, the effect of the indirect pathway needs to be specific to each action (so that the indirect pathway can individually inhibit each action).

As described in the neuroanatomy section above, the competition between the direct and indirect pathways is modulated by dopamine (the second focus of the Frank () model). Specifically, higher dopamine levels increase activation in the direct pathway (e.g., through D1 receptors) and reduces activation in the indirect pathway (e.g., through D2 receptors). Hence, dopamine release following unexpected rewards results in long-term potentiation (LTP) in the direct pathway and long-term depression (LTD) in the indirect pathway. In contrast, dopamine dips following the unexpected absence of a reward reduces activation and produces LTD in the direct pathway but increases activation and produces LTP in the indirect pathway. The simulation results suggest that the dynamic range of the dopamine signal is crucial in probabilistic learning and reversal learning (e.g., when the response—reward associations are changed during learning). Reducing (to simulate PD) or increasing (to simulate medication overdose) dopamine levels can result in simulated Parkinsonian symptoms (Frank, ).

Another interesting model of probabilistic learning was recently proposed by Guthrie et al. (). The Guthrie et al. () model is based on an earlier computational neuroscience model of the BG that focuses on the interaction between the direct and hyperdirect pathways (Leblois et al., ). The Guthrie et al. () model includes two cortico-BG closed-loop that interact in the striatum. The first loop is called the “cognitive” loop and is used to identify the visual symbols used in the probabilistic learning task. The second loop is called the “motor” loop and is used to select a response based on the observed symbols. Some of the corticostriatal projections affect both loops, but the rest of the circuit is segregated. In both loops, the direct pathway is in charge of selecting the correct channel (i.e., identifying the symbols or the response) while the hyperdirect pathway sends non-specific inhibition to the GPi to produce a center-surround decision process. All corticostriatal synapses are plastic (using dopamine-mediated reinforcement learning) and the cognitive loop gradually learns to bias the motor loop, thus producing faster reaction times. The model successfully reproduces both neural firing rates and behavioral data in the double-arm bandit task.

The categorization models reviewed earlier have also been applied to probabilistic learning. The Moustafa and Gluck () model focused on the role of dopamine in probabilistic learning. In addition to simulating probabilistic learning with normal dopamine levels, Moustafa and Gluck () have simulated the effect of decreased dopamine (as in PD) and the effect of dopaminergic medication in both the BG and prefrontal cortex. The COVIS model has also been used to simulate probabilistic learning (Helie et al., ). While COVIS was not used to simulate medication effects, the model could account for probabilistic learning with normal and reduced (as in PD) dopamine levels (with a dosage effect such that lowest levels of dopamine produced worst performance; see Knowlton et al., ).

#### Synthesis

The reviewed models of probabilistic learning tend to be more biologically detailed than the reviewed models of categorization. Specifically, the Frank () model includes the direct and indirect pathways, whereas the Guthrie et al. () model includes the direct and hyperdirect pathways. In contrast, COVIS (Ashby et al., ) and the Moustafa and Gluck (,) models only included the direct pathway. Interestingly, however, the Frank () model does not include the same details as the Guthrie et al. () model. Both models include the direct pathway for action selection, and use dopamine-mediated reinforcement learning to learn corticostriatal synapses. However, the Frank () model uses the indirect pathway as a channel-specific excitatory process to cancel inappropriate actions whereas Guthrie et al. () use the hyperdirect pathway as a non-specific excitatory process to cancel inappropriate actions. Neither model includes both the indirect and hyperdirect pathways. While there is agreement on the need for an excitatory process to enhance the contrast between the selected and non-selected actions, the exact process is still to be determined.

While the categorization models only included the direct pathway of the BG, one of their strengths is that, in addition to their generality, they also include other brain areas. For instance, Unlike the Frank () model, the Moustafa and Gluck (,) model simulates the role of prefrontal cortex and its dopamine projections, which is in agreement with empirical studies (Mulder et al.,; Histed et al., ). Also, analysis of the parameter space in the COVIS simulations challenges the role of the BG for procedural learning in probabilistic learning, and suggests instead that the BG are used for hypothesis-testing in this task (Gluck et al., ). So, both categorization models agree on an important role for the prefrontal cortex in probabilistic learning, and this role is missing from both the Frank () and the Guthrie et al. () models. The most productive future approach might be to add a prefrontal cortex to the existing probabilistic learning models and see how this addition affects the dynamic of the different BG pathways.

### Working memory

Working memory is a cognitive function used to maintain and manipulate information in real-time for a short duration (seconds). While working memory has traditionally been associated with the prefrontal cortex (Fuster, ), Monchi et al. () proposed that the BG may be required to maintain information in prefrontal cortex.

#### Models

The Monchi et al. () model was originally proposed to account for working memory deficits in PD and schizophrenia. The model includes three BG-thalamocortical closed loops: two with the prefrontal cortex (one for spatial information and the other for object information), and one through the ACC (for strategy selection). In all three cases, only the direct pathway through the BG was included (see Figure ). The role of the two prefrontal-BG loops is to maintain working memory information about the stimuli, whereas the ACC maintains the adopted strategy by inhibiting all the prefrontal cortex loops except one (i.e., representing the selected strategy). Visual input to the BG comes from the posterior parietal cortex (spatial) and inferior temporal cortex (object). The model output is located in the premotor cortex, and the nucleus accumbens (not shown in Figure ) is used to provide feedback. In the model, the visual stimulus is input to the prefrontal cortex loops, and the stimulus activity is propagated through the direct pathway of the BG. As a result, the thalamus is released from GPi inhibition, and activation produced by the stimulus in the prefrontal cortex reverberates through closed-loops with the thalamus. When a response is required, the prefrontal cortex transfers its activation to the premotor cortex. If the response is incorrect, the nucleus accumbens sends a feedback signal to the ACC loop, which selects a new strategy by switching its inhibition to different prefrontal cortex loops. The Monchi et al. () model has been used to simulate a delayed response task and the Wisconsin Card Sorting Test. Interestingly, reducing the connection strengths within the BG-thalamocortical loops produces Parkinsonian symptoms, whereas reducing nucleus accumbens activity produces deficits similar to those observed in schizophrenia (Monchi et al., ).

Five years later, Ashby et al. () proposed the FROST model to account for intact spatial working memory maintenance. Similar to the Monchi et al. () model, FROST includes the direct pathway of the BG (see Figure ), and working memory maintenance relies on reverberating activation between the prefrontal cortex and the thalamus. However, unlike in the Monchi et al. () model, only one prefrontal cortex loop is included, and thalamic activation is not sufficient to maintain prefrontal activity: a second set of closed-loops between the prefrontal cortex and posterior cortex needs to be simultaneously activated to maintain working memory information. In Ashby et al. (), the focus is on simulating spatial working memory tasks, and the area of posterior cortex required for working memory maintenance is the posterior parietal cortex. However, it is likely the case that the specific location in posterior cortex depends on what information is being maintained. For instance, if the items being maintained in working memory were objects, then it is likely that the posterior cortex area involved would be inferior temporal cortex. Another difference between FROST and the Monchi et al. () model is that the striatum in FROST is activated by a different population of prefrontal neurons (separate from the working memory maintenance prefrontal population) whereas the same prefrontal neurons are used to activate the striatum and maintain information in Monchi et al. (). As a result, the striatum becomes activated only after the stimulus has disappeared in FROST, whereas the striatum becomes activated as soon as the stimulus appears in Monchi et al. (). These differences between FROST and Monchi et al. () were motivated by recent single-cell recording results reviewed in Ashby et al. (). FROST has been used to reproduce single-cell recordings from many experiments in several brain regions, in addition to accounting for working memory capacity limitation and the relation between memory span and the ability to ignore distracting information (Ashby et al., ).

One common theme of the two previous models is that working memory activity is maintained by closed-loops between the thalamus and prefrontal cortex, and the main role of the BG is to release the thalamus from inhibition and allow for the reverberating activation to take place. However, this view was challenged by Frank et al. () who proposed a model of BG-prefrontal cortex interaction in working memory. Specifically, Frank et al. () argued that in order for the thalamus to contribute to working memory maintenance in the way described by the previous models, it would need to have a dedicated number of cells comparable to the number of cells dedicated to working memory in prefrontal cortex (which is unlikely). Instead, the Frank et al. () model proposes that working memory maintenance is accomplished by reverberating loops between two cell populations within the prefrontal cortex. Similar to Monchi et al. () and FROST (Ashby et al., ), the Frank et al. () model includes the direct pathway through the BG (see Figure ), but the role of the direct pathway is to “turn on the switch” on the prefrontal cortex cells and allow for reverberating activation. The “switch” can only be turned on if the prefrontal cortex cells from one population simultaneously receive activation from the BG and the other prefrontal cortex cell population. Once the switch is “on”, the BG is no longer required for working memory maintenance. The Frank et al. () model has been used to simulate the 1-2-AX task, a working memory task that requires maintenance but also switching and selecting new items (Frank et al., ). Specifically, the 1-2-AX task requires the subject to maintain two cues in working memory in order to correctly select a response to a target sequence. The identity of the target sequence depends on the previous cue, which is used to trigger selection and switching.

One topic that was not addressed by any of the previous models of working memory is learning. How can the brain learn what is important, and what needs to be maintained in working memory? Moustafa and Maida () proposed a computational model of prefrontal cortex and BG interactions that is similar to the Frank et al. () model except that Moustafa and Maida () also simulate: (a) temporal difference learning based on phasic dopamine signaling and (b) more than one corticostriatal loops that are responsible for both motor and cognitive processes. Specifically, the model includes a cortico-striatal motor loop and a cortico-striatal cognitive loop whose functions are action selection (choosing motor responses) and cognitive selection (choosing the perceptual information to be maintained in working memory), respectively. The model can account for the separate roles of the motor and cognitive loops in working memory maintenance, including delayed-response tasks.

Schroll et al. () recently proposed a CCN model of working memory to address the problem of learning complex working memory tasks. The Schroll et al. () model includes two separate BG-thalamocortical closed loops, one through the prefrontal cortex for maintenance and another through motor cortex to produce a response. Only the direct pathways were used for maintenance and response selection, but the hyperdirect pathway was also included in the prefrontal loop as a reset mechanism (see Figure ). Specifically, visual information enters the model through the inferior temporal cortex, which then activates the lateral prefrontal cortex. This activation is transferred through the direct pathway of the BG and releases the thalamus from inhibition, which in turn activates the lateral prefrontal cortex. In the Schroll et al. () model, working memory activation in the prefrontal cortex is maintained by a reverberating activation loop through the direct pathway, so the BG does not only act as a gating mechanism but is part of the maintenance loop (unlike Monchi et al.,; Frank et al.,; Ashby et al., ). At any moment, the prefrontal cortex can activate the STN, which increases activation in the GPi and interrupt working memory maintenance (i.e., the reset mechanism). More importantly, the connectivity between the prefrontal cortex and the striatum and the connections between the prefrontal cortex and the STN are learned using dopamine-mediated reinforcement learning. Hence, the model can automatically adapt and only maintain information that is rewarded in working memory. The model has been used to simulate a delayed response task, a delayed alternation task, and the 1-2-AX task (Schroll et al., ).

#### Synthesis

Working memory is one of the most active areas for CCN modeling of the BG. Five different models were reviewed, each having both commonalities and differences. First, all five models focused on the interaction between the BG and the prefrontal cortex, but only included the direct pathway of the BG for working memory maintenance and response selection. Hence, the neuroanatomy of the BG was not very detailed. Also, all models except Schroll et al. () used the BG as a gating mechanism that turns working memory maintenance “on” or “off”. The main difference is that Monchi et al. () and Ashby et al. () used the BG to gate closed loops between the prefrontal cortex and the thalamus, whereas Frank et al. () and Moustafa and Maida () used the BG to gate closed loop between two populations of prefrontal cortex units. This differs from Schroll et al. () where the BG was not used for gating, but instead was part of the working memory maintenance mechanism itself (i.e., the closed loop went through the BG). In all cases, however, working memory maintenance was achieved by closed loop through the prefrontal cortex.

Another important difference between the models is that the Ashby et al. () and the Moustafa and Maida () models focused on simple maintenance tasks. In contrast, the Monchi et al. (), Frank et al. (), and Schroll et al. () models were able to simulate more complex tasks involving hierarchical structures and switching. Only the Moustafa and Maida () and the Schroll et al. () models include learning mechanisms that allowed for selecting the relevant information that needs to be maintained in working memory. The other models assumed a pre-filtering of the information.

Interestingly, there seems to be a progression and a building up of knowledge related to CCN models of working memory. The Schroll et al. () model is the most recent, and also the most detailed. It is the only model that can learn and simulate complex tasks. However, this model departs from all the others in that the BG is not used as a gating mechanism but is part of the maintenance mechanism. This departure from previous modeling is not extensively discussed in Schroll et al. (), and it is unclear at this point what motivated this departure. More work is needed to determine which of these two roles the BG play in working memory, but the overlap in the models, and the progression in functionality, suggest a steady progress in CCN modeling of working memory.

### Sequence learning

Almost all our everyday behaviors and cognitive activities can be interpreted as a sequence of steps that bring us closer to achieving a goal. One key question is how can we learn to chain these sequences of substeps? Miyachi et al. (, ) have gathered much data suggesting that the BG is important in learning such sequences.

#### Models

Nakahara et al. () formalized Miyachi et al. (, ) findings into a CCN model. According to Nakahara et al. (), sequences are learned in both visual and motor coordinates. The visual sequences are learned by a BG-thalamocortical closed-loop linking the anterior striatum with the dorsolateral prefrontal cortex while motor sequences are learned by a BG-thalamocortical closed-loop linking the posterior striatum with the SMA. Only the direct pathway through the BG is included in each loop (see Figure ), and both the visual and motor loops learn every sequence in parallel using reinforcement learning. The visual loop learns faster than the motor loop, and response coordination between the loops is controlled by the pre-SMA. According to Nakahara et al. (), the visual loop relies on working memory and is important for rapid acquisition of sequences. However, the motor loop is more reliable and produces movement more rapidly after training. As a result, control is gradually transferred from the visual loop to the motor loop in the Nakahara et al. () model. The Nakahara et al. () model has been used to account for: (1) the time course of learning (including single-cell recordings and lesion studies); (2) the effect of opposite hand use; (3) the effect of sequence reversal; and (4) the change in brain locus from early to late sequence production (Nakahara et al., ).

#### Synthesis

The Nakahara et al. () model is interesting for several reasons. First, it successfully accounts for lesion data, single-cell recordings, and behavioral phenomena. In addition, the transition from a visual loop to a motor loop represents an early attempt at bridging the gap between cognitive and motor functions of the BG. However, a recent study by Desmurget and Turner () challenges the generality of the Nakahara et al. () model. Specifically, Desmurget and Turner () had monkeys perform a sequence of visually-cued joystick movements aimed at moving a cursor into a pre-determined part of a computer screen. After some training, muscimol was injected into the motor segment of the GPi to functionally disconnect the BG from the frontal cortex. The results show that the kinematics of the movements were impaired, but not sequence knowledge. Desmurget and Turner () interpreted these results as suggesting that the BG contributes to motor execution in automatic sequence production, but not to the motor sequencing or the storage of the overlearned sequence. This result is problematic for the Nakahara et al. () model.

### Automaticity

Automaticity results from overtraining in a task until performance requires little attentional resources and becomes highly rigid (Helie et al.,; Helie and Cousineau, ). Many computational models of automaticity development have assigned a role for the BG.

#### Models

First, in the Nakahara et al. () model of sequence learning (above), automaticity in sequence production is characterized by a gradual transfer from the visual loop (which learns sequences in visual coordinates) to the motor loop (which learns sequences in motor coordinates). This corresponds well with the results of Miyachi et al. (, ), who showed using single-cell recordings that task-sensitive cells in early learning are mostly located in the anterior striatum whereas selective cells in late sequence production are mostly located in the posterior striatum (Miyachi et al., ). This specialization of the striatum is further supported by inactivation studies where muscimol (a GABA agonist) was injected in different parts of the striatum in early and late sequence production. Well-learned sequence production was selectively disrupted by muscimol injection in the middle-posterior putamen while early sequence production was selectively disrupted by muscimol injection in the anterior caudate and putamen (Miyachi et al., ).

However, a recent study by Desmurget and Turner () challenges the generality of the Nakahara et al. () model. Specifically, injecting muscimol into the motor segment of the GPi to functionally disconnect the BG from the frontal cortex affects the kinematics of the movements but not sequence knowledge. These results suggest that the BG contributes to motor execution in automatic sequence production, but not to the motor sequencing or the storage of the overlearned sequence. Interestingly, the results of Desmurget and Turner () are consistent with a neurobiological model of automaticity in perceptual categorization (SPEED) (Ashby et al., ). SPEED uses the procedural system of COVIS (Ashby et al., ) (i.e., the direct pathway of an opened loop between posterior cortex and premotor areas) but also includes a Hebbian learning mechanism between posterior cortex and premotor areas. The role of the BG in SPEED is to learn to produce the correct categorization responses early in training to ensure that the correct motor plan in the premotor areas is consistently activated shortly after the visual representation in associative cortex (using dopamine-mediated reinforcement learning). This consistent association between associative and premotor cortical activity triggers Hebbian learning between associative cortex (stimulus) and the premotor areas (response), and the direct cortico-cortical connections eventually become strong enough so that the BG is no longer required to produce a response. When responding becomes purely cortical, the skill is said to be “automatic” \[note that this is different from Nakahara et al. (), in which the posterior striatum is still required for automatic sequence production\]. SPEED has been used to simulate single-cell recordings data in many categorization experiments, as well as human reaction times and accuracies in categorization (Ashby et al.,; Helie and Ashby, ).

While the Hikosaka et al. () and SPEED models can account for how behavior becomes automatic, they cannot account for how automatic responses are overridden by goal-directed behavior when needed (e.g., when the stimulus—response associations change). Chersi et al. () proposed a computational model of automaticity in instrumental conditioning that can account for the change back to goal-directed behavior when needed. The Chersi et al. () model includes the prefrontal cortex (for goal representation), the motor cortex (for action representation), the sensory cortex (for stimulus representation), the BG (for action selection), and the thalamus (to relay information between the BG and the motor cortex). Two sets of connections are plastic: (1) connections from the prefrontal cortex to the motor cortex (to learn goal—response associations) and (2) connections from the sensory cortex to the striatum (to learn stimulus—response associations). According to this model, the stimulus activates the sensory cortex, which in turn activates a goal in prefrontal cortex and action representations in the striatum. For automatic behavior, the striatal activation propagates through both the direct and indirect pathways (see Figure ) of the BG and an action is selected by inhibiting all but one action at the output level (SNr, but it is functionally equivalent to the GPi shown in Figure ). The action that is not inhibited activates the appropriate response in motor cortex (through the thalamus). For goal-directed behaviors, the prefrontal activation propagates to the appropriate action in motor cortex. When an automatic action needs to be overwritten by a goal-directed behavior, the prefrontal cortex sends activation to the STN, which hyperpolarizes the SNr and prevents the BG from controlling the motor response (Chersi et al., ). The model has been successfully used to account for the development of automaticity in an instrumental conditioning task and the reversal of stimulus—response associations after automaticity had developed (Chersi et al., ).

#### Synthesis

The Nakahara et al. () and the Chersi et al. () models both assign the role of producing automatic behavior to the BG. However, this “classic” role of the BG in automaticity is difficult to reconcile with the Desmurget and Turner () data. As an alternative, SPEED (Ashby et al., ) also assigns an important role to the BG in automaticity, but this role is restricted to training automatic cortico-cortical projections that can account for automaticity. Simply put, the BG is required to learn automatic behaviors, but the BG is no longer required to produce automatic behaviors once the cortico-cortical connectivity is sufficiently strong. The SPEED model can account for the Desmurget and Turner () data, but it includes only the direct pathway of one loop through the BG. In contrast, the Nakahara et al. () model includes two loops through the BG (only the direct pathways) and the Chersi et al. () model includes both the direct and indirect pathways, but only one loop through the BG (similar to SPEED). In addition to being the most biologically detailed, the Chersi et al. () model is the only reviewed model that can override automatic behavior using goal-directed behavior. This is an important function that was not accounted for by the previous models. However, like the Nakahara et al. () model, the Chersi et al. () model cannot account for the Desmurget and Turner () data. To summarize, each one of these models was designed to account for a different aspect of automatic behavior, and successfully accounts for the aspect of automaticity for which it was designed. The next step is to explore how each one of these candidate models can account for the missing function/data that was the focus of the other candidate models.