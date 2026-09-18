---
title: "A Neural Signature of Hierarchical Reinforcement Learning"
source: "https://www.cell.com/neuron/fulltext/S0896-6273(11)00499-5"
author:
  - "[[José J.F. Ribas-Fernandes]]"
  - "[[Alec Solway]]"
  - "[[Carlos Diuk]]"
  - "[[Joseph T. McGuire]]"
  - "[[Andrew G. Barto]]"
  - "[[Yael Niv]]"
  - "[[Matthew M. Botvinick]]"
published:
created: 2026-09-18
description: "Human behavior displays hierarchical structure: simple actions cohere into subtasksequences, which work together to accomplish overall task goals. Although the neuralsubstrates of such hierarchy have been the target of increasing research, they remainpoorly understood. We propose that the computations supporting hierarchical behaviormay relate to those in hierarchical reinforcement learning (HRL), a machine-learningframework that extends reinforcement-learning mechanisms into hierarchical domains."
tags:
  - "clippings"
---
## Summary

Human behavior displays hierarchical structure: simple actions cohere into subtask sequences, which work together to accomplish overall task goals. Although the neural substrates of such hierarchy have been the target of increasing research, they remain poorly understood. We propose that the computations supporting hierarchical behavior may relate to those in hierarchical reinforcement learning (HRL), a machine-learning framework that extends reinforcement-learning mechanisms into hierarchical domains. To test this, we leveraged a distinctive prediction arising from HRL. In ordinary reinforcement learning, reward prediction errors are computed when there is an unanticipated change in the prospects for accomplishing overall task goals. HRL entails that prediction errors should also occur in relation to task *subgoals*. In three neuroimaging studies we observed neural responses consistent with such subgoal-related reward prediction errors, within structures previously implicated in reinforcement learning. The results reported support the relevance of HRL to the neural processes underlying hierarchical behavior.

## Highlights

- In hierarchical tasks, temporal-difference prediction errors occur with subgoals
- These signals are clearest in cingulate and insular cortices
- Subgoal PEs may also occur in amygdala, habenula, and nucleus accumbens
- Subgoal PEs may represent a neural signature of hierarchical reinforcement learning

## Introduction

In recent years computational reinforcement learning (RL) (

52.

Sutton, R.S. ∙ Barto, A.G.

**Reinforcement Learning: An Introduction**

MIT Press, Cambridge, MA, 1998

[Google Scholar](https://scholar.google.com/scholar?q=R.S.SuttonA.G.BartoReinforcement+Learning%3A+An+Introduction1998MIT+PressCambridge%2C+MA)

) has provided an indispensable framework for understanding the neural substrates of learning and decision making (

39.

Niv, Y.

**Reinforcement learning in the brain**

*J. Math. Psychol.* 2009; **53**:139-154

), shedding light on the functions of dopaminergic and striatal nuclei, among other structures (

5.

Barto, A.G.

**Adaptive critics and the basal ganglia**

Houk, J.C. ∙ Davis, J. ∙ Beiser, D. (Editors)

**Models of Information Processing in the Basal Ganglia**

MIT Press, Cambridge, MA, 1995; 215-232

[Google Scholar](https://scholar.google.com/scholar?q=A.G.BartoAdaptive+critics+and+the+basal+gangliaJ.C.HoukJ.DavisD.BeiserModels+of+Information+Processing+in+the+Basal+Ganglia1995MIT+PressCambridge%2C+MA215232)

36.

Montague, P.R. ∙ Dayan, P. ∙ Sejnowski, T.J.

**A framework for mesencephalic dopamine systems based on predictive Hebbian learning**

*J. Neurosci.* 1996; **16**:1936-1947

[Crossref](https://doi.org/10.1523/JNEUROSCI.16-05-01936.1996)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/8774460/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1523%2FJNEUROSCI.16-05-01936.1996&pmid=8774460)

48.

Schultz, W. ∙ Dayan, P. ∙ Montague, P.R.

**A neural substrate of prediction and reward**

*Science.* 1997; **275**:1593-1599

). However, to date, ideas from RL have been applied mainly in very simple task settings, leaving it unclear whether related principles might pertain in cases of more complex behavior (for a discussion, see

18.

Daw, N.D. ∙ Frank, M.J.

**Reinforcement learning and higher level cognition: introduction to special issue**

*Cognition.* 2009; **113**:259-261

19.

Dayan, P. ∙ Niv, Y.

**Reinforcement learning: the good, the bad and the ugly**

*Curr. Opin. Neurobiol.* 2008; **18**:185-196

). Hierarchically structured behavior provides a particularly interesting test case, not only because hierarchy plays an important role in human action (

14.

Cooper, R. ∙ Shallice, T.

**Contention scheduling and the control of routine activities**

*Cogn. Neuropsychol.* 2000; **17**:297-338

33.

Lashley, K.S.

**The problem of serial order in behavior**

Jeffress, L.A. (Editor)

**Cerebral Mechanisms in Behavior: The Hixon Symposium**

Wiley, New York, 1951; 112-136

[Google Scholar](https://scholar.google.com/scholar?q=K.S.LashleyThe+problem+of+serial+order+in+behaviorL.A.JeffressCerebral+Mechanisms+in+Behavior%3A+The+Hixon+Symposium1951WileyNew+York112136)

), but also because there exist RL algorithms specifically designed to operate in a hierarchical context (

6.

Barto, A.G. ∙ Mahadevan, S.

**Recent advances in hierarchical reinforcement learning**

*Discrete Event Dyn. Syst.* 2003; **13**:341-379

[Crossref](https://doi.org/10.1023/A:1025696116075)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1023%2FA%3A1025696116075)

20.

Dietterich, T.G.

**The MAXQ method for hierarchical reinforcement learning**

Shavlik, J.W. (Editor)

**Proceedings of the Fifteenth International Conference on Machine Learning**

Morgan Kaufman, San Francisco, 1998; 118-126

[Google Scholar](https://scholar.google.com/scholar?q=T.G.DietterichThe+MAXQ+method+for+hierarchical+reinforcement+learningJ.W.ShavlikProceedings+of+the+Fifteenth+International+Conference+on+Machine+Learning1998Morgan+KaufmanSan+Francisco118126)

43.

Parr, R. ∙ Russell, S.

**Reinforcement learning with hierarchies of machines**

*Adv. Neural Inf. Process Sys.* 1998; **10**:1043-1049

[Google Scholar](https://scholar.google.com/scholar?q=R.ParrS.RussellReinforcement+learning+with+hierarchies+of+machinesAdv.+Neural+Inf.+Process+Sys.10199810431049)

53.

Sutton, R.S. ∙ Precup, D. ∙ Singh, S.

**Between MDPs and semi-MDPs: a framework for temporal abstraction in reinforcement learning**

*Artif. Intell.* 1999; **112**:181-211

).

Several researchers have proposed that such hierarchical reinforcement learning (HRL) algorithms may be relevant to understanding brain function, and a number of intriguing parallels to existing neuroscientific findings have been noted (

7.

Botvinick, M.M.

**Hierarchical models of behavior and prefrontal function**

*Trends Cogn. Sci. (Regul. Ed.).* 2008; **12**:201-208

9.

Botvinick, M.M. ∙ Niv, Y. ∙ Barto, A.C.

**Hierarchically organized behavior and its neural foundations: a reinforcement learning perspective**

*Cognition.* 2009; **113**:262-280

; Diuk et al., 2010, Soc. Neurosci., abstract, 907.14/KKK47

2.

Badre, D. ∙ Frank, M.J.

**Mechanisms of hierarchical reinforcement learning in cortico-striatal circuits 2: evidence from fMRI**

*Cereb. Cortex.* 2011;

in press. Published online June 21, 2011

[Google Scholar](https://scholar.google.com/scholar?q=D.BadreM.J.FrankMechanisms+of+hierarchical+reinforcement+learning+in+cortico-striatal+circuits+2%3A+evidence+from+fMRICereb.+Cortex2011in+press.+Published+online+June+21%2C+2011)

24.

Haruno, M. ∙ Kawato, M.

**Heterarchical reinforcement-learning model for integration of multiple cortico-striatal loops: fMRI examination in stimulus-action-reward association learning**

*Neural Netw.* 2006; **19**:1242-1254

). However, the relevance of HRL to neural function stands in need of empirical test.

In traditional RL (

52.

Sutton, R.S. ∙ Barto, A.G.

**Reinforcement Learning: An Introduction**

MIT Press, Cambridge, MA, 1998

[Google Scholar](https://scholar.google.com/scholar?q=R.S.SuttonA.G.BartoReinforcement+Learning%3A+An+Introduction1998MIT+PressCambridge%2C+MA)

), the agent selects among a set of elemental actions, typically interpreted as relatively simple motor behaviors. The key innovation in HRL is to expand the set of available actions so that the agent may now opt to perform not only elemental actions, but also multiaction subroutines, containing sequences of lower-level actions, as illustrated in [Figure 1](#fig1) (for a fuller description, see [Experimental Procedures](#sec-4) and

9.

Botvinick, M.M. ∙ Niv, Y. ∙ Barto, A.C.

**Hierarchically organized behavior and its neural foundations: a reinforcement learning perspective**

*Cognition.* 2009; **113**:262-280

).

![](https://www.cell.com/cms/10.1016/j.neuron.2011.05.042/asset/96f9aef2-40c7-4921-ab29-c65c345b44f1/main.assets/gr1_lrg.jpg)

Figure 1 Illustration of HRL Dynamics

Learning in HRL occurs at two levels. At a global level, the agent learns to select actions and subroutines so as to efficiently accomplish overall task goals. A fundamental assumption of RL is that goals are defined by their association with reward, and thus, the objective at this level is to discover behavior that maximizes long-term cumulative reward. Progress toward this objective is driven by temporal-difference (TD) procedures drawn directly from ordinary RL: following each action or subroutine, a reward prediction error (RPE) is generated, indicating whether the behavior yielded an outcome better or worse than initially predicted (see [Figure 1](#fig1) and [Experimental Procedures](#sec-4)), and this prediction error signal is used to update the behavioral policy. Importantly, outcomes of actions are evaluated with respect to the global goal of maximizing long-term reward.

At a second level, the problem is to learn the subroutines themselves. Intuitively, useful subroutines are designed to accomplish internally defined subgoals (

51.

Singh, S. ∙ Barto, A.G. ∙ Chentanez, N.

**Intrinsically motivated reinforcement learning**

Saul, L.K. ∙ Weiss, Y. ∙ Bottou, L. (Editors)

**Advances in Neural Information Processing Systems 17: Proceedings of the 2004 Conference**

MIT Press, Cambridge, MA, 2005; 1281-1288

[Google Scholar](https://scholar.google.com/scholar?q=S.SinghA.G.BartoN.ChentanezIntrinsically+motivated+reinforcement+learningL.K.SaulY.WeissL.BottouAdvances+in+Neural+Information+Processing+Systems+17%3A+Proceedings+of+the+2004+Conference2005MIT+PressCambridge%2C+MA12811288)

). For example, in the task of making coffee, one sensible subroutine would aim at adding cream. HRL makes the important assumption that the attainment of such subgoals is associated with a special form of reward, labeled *pseudo-reward* to distinguish it from “external” or primary reward. The distinction is critical because subgoals may not themselves be associated with primary reward. For example, adding cream to coffee may bring one closer to that rewarding first sip, but is not itself immediately rewarding. In an HRL context, accomplishment of this subgoal would yield pseudo-reward, but not primary reward.

Once the HRL agent enters a subroutine, prediction error signals indicate the degree to which each action has carried the agent toward the currently relevant subgoal and its associated pseudo-reward (see [Figure 1](#fig1) and [Experimental Procedures](#sec-4)). Note that these subroutine-specific prediction errors are unique to HRL. In what follows, we refer to them as pseudo-reward prediction errors (PPEs), reserving “reward prediction error” for prediction errors relating to primary reward.

In order to make these points concrete, consider the video game illustrated in [Figure 2](#fig2), which is based on a benchmark task from the computational HRL literature (

20.

Dietterich, T.G.

**The MAXQ method for hierarchical reinforcement learning**

Shavlik, J.W. (Editor)

**Proceedings of the Fifteenth International Conference on Machine Learning**

Morgan Kaufman, San Francisco, 1998; 118-126

[Google Scholar](https://scholar.google.com/scholar?q=T.G.DietterichThe+MAXQ+method+for+hierarchical+reinforcement+learningJ.W.ShavlikProceedings+of+the+Fifteenth+International+Conference+on+Machine+Learning1998Morgan+KaufmanSan+Francisco118126)

). Only the colored elements in the figure appear in the task display. The overall objective of the game is to complete a “delivery” as quickly as possible, using joystick movements to guide the truck first to the package and from there to the house. It is self-evident how this task might be represented hierarchically, with delivery serving as the (externally rewarded) top-level goal and acquisition of the package as an obvious subgoal. For an HRL agent, delivery would be associated with primary reward and acquisition of the package with pseudo-reward. (This observation is not meant to suggest that the task *must* be represented hierarchically. Indeed, it is an established point in the HRL literature that any hierarchical policy has an equivalent nonhierarchical or flat policy, as long as the underlying decision problem satisfies the Markov property.) Our neuroimaging experiments proceeded on the assumption that participants would represent the delivery task hierarchically. However, as we discuss later, the neuroimaging results themselves, together with results from a behavioral experiment, provided convergent evidence for the validity of this assumption. See [Supplemental Experimental Procedures](#supplementary-material), available online, for further discussion.

![](https://www.cell.com/cms/10.1016/j.neuron.2011.05.042/asset/d344be87-6b69-4d5d-9ef2-64584ad6cbfc/main.assets/gr2_lrg.jpg)

Figure 2 Task and Predictions from HRL and RL

Consider now a version of the task in which the package sometimes unexpectedly jumps to a new location before the truck reaches it. According to RL, a jump to point A in the figure, or any location within the ellipse shown, should trigger a positive RPE because the total distance that must be covered in order to deliver the package has decreased. (Note that we assume temporal discounting, which implies that attaining the goal faster is more rewarding. We also assume that current subgoal and goal distances are always immediately known, as they were for our experimental participants from the task display.) By the same token, a jump to point B or any other exterior point should trigger a negative RPE. Cases C, D, and E are quite different. Here, there is no change in the overall distance to the goal, and so no RPE should be triggered, either in standard RL or in HRL. However, in case C the distance to the subgoal has decreased. Thus, according to HRL, a jump to this location should trigger a positive PPE. Similarly, a jump to location D should trigger a negative PPE (note that location E is special, being the only location that should trigger neither an RPE nor a PPE). These points are illustrated in [Figure 2](#fig2) (right), which shows RPE and PPE time courses from simulations of the delivery task based on standard RL and HRL (for simulation methods, see [Experimental Procedures](#sec-4)).

These points translate directly into neuroscientific predictions. Previous research has revealed neural correlates of the RPE in numerous structures (

23.

Hare, T.A. ∙ O'Doherty, J. ∙ Camerer, C.F....

**Dissociating the role of the orbitofrontal cortex and the striatum in the computation of goal values and prediction errors**

*J. Neurosci.* 2008; **28**:5623-5630

55.

Ullsperger, M. ∙ von Cramon, D.Y.

**Error monitoring using external feedback: specific roles of the habenular complex, the reward system, and the cingulate motor area revealed by functional magnetic resonance imaging**

*J. Neurosci.* 2003; **23**:4308-4314

[PubMed](https://pubmed.ncbi.nlm.nih.gov/12764119/)

[Google Scholar](https://scholar.google.com/scholar_lookup?pmid=12764119)

). HRL predicts that neural correlates should also exist for the PPE. To test this, we had neurologically normal participants perform the delivery task from [Figure 2](#fig2) while undergoing EEG and, in two further experiments, fMRI.

## Results

### EEG Experiment

The EEG experiment included 9 participants, who performed the delivery task for a total of 60 min (190 delivery trials on average per participant). One-third of trials involved a jump event of type D from [Figure 2](#fig2); these events were intended to elicit a negative PPE. Earlier EEG research indicates that ordinary negative RPEs trigger a midline negativity typically centered on lead Cz, sometimes referred to as the feedback-related negativity or FRN (). Based on HRL, we predicted that a similar negativity would occur following the critical jumps (type D) in our task. To provide a baseline for comparison, another third of the trials involved jump events of type E.

Stimulus-aligned EEG averages indicated that class D-jump events triggered a phasic negativity in the EEG (p < 0.01 at Cz; [Figure 3](#fig3), left), relative to the E-jump control condition. (Like the ERP obtained in this study, the FRN sometimes takes the form of a relative negativity occupying the positive voltage domain, rather than absolute negativity. For germane examples, see

38.

Nieuwenhuis, S. ∙ Slagter, H.A. ∙ von Geusau, N.J.A....

**Knowing good from bad: differential activation of human cortical areas by positive and negative outcomes**

*Eur. J. Neurosci.* 2005; **21**:3161-3168

60.

Yeung, N. ∙ Holroyd, C.B. ∙ Cohen, J.D.

**ERP correlates of feedback and reward processing in the presence and absence of response choice**

*Cereb. Cortex.* 2005; **15**:535-544

.) Like the FRN, this negativity was largest in the fronto-central midline leads (including Cz, see [Figure 3](#fig3), right), and although the observed negativity peaked later than the typical FRN, its timing is consistent with studies of equivalent complexity of feedback ().

![](https://www.cell.com/cms/10.1016/j.neuron.2011.05.042/asset/4944686f-f933-409c-a6d8-72a4064a0253/main.assets/gr3_lrg.jpg)

Figure 3 Results of EEG Experiment

### fMRI Experiments

In our first fMRI experiment, a group of 30 new participants performed a slightly different version of the delivery task, again designed to elicit negative PPEs. As in the EEG experiment, one-third of trials included a jump of type D (as in [Figure 2](#fig2)), and another third included a jump of type E. Type D jumps, by increasing the distance to the subgoal, were again intended to trigger a PPE. However, in the fMRI version of the task, unlike the EEG version, the exact increase in subgoal distance varied across trials. Therefore, type D jumps were intended to induce PPEs that varied in magnitude ([Figure 2](#fig2)). Our analyses took a model-based approach (

40.

O'Doherty, J.P. ∙ Hampton, A. ∙ Kim, H.

**Model-based fMRI and its application to reward learning and decision making**

*Ann. N Y Acad. Sci.* 2007; **1104**:35-53

), testing for regions that showed phasic activation correlating positively with predicted PPE size.

A whole-brain general linear model analysis, thresholded at p < 0.01 (cluster-size thresholded to correct for multiple comparisons), revealed such a correlation in the dorsal anterior cingulate cortex (ACC; [Figure 4](#fig4)). This region has been proposed to contain the generator of the FRN (, although see

38.

Nieuwenhuis, S. ∙ Slagter, H.A. ∙ von Geusau, N.J.A....

**Knowing good from bad: differential activation of human cortical areas by positive and negative outcomes**

*Eur. J. Neurosci.* 2005; **21**:3161-3168

and [Discussion](#sec-3) below). In this regard the fMRI result is consistent with the result of our EEG experiment. The same parametric fMRI effect was also observed bilaterally in the anterior insula, a region often coactivated with the ACC in the setting of unanticipated negative events (

44.

Phan, K.L. ∙ Wager, T.D. ∙ Taylor, S.F....

**Functional neuroimaging studies of human emotions**

*CNS Spectr.* 2004; **9**:258-266

). The effect was also detected in right supramarginal gyrus, the medial part of lingual gyrus, and, with a negative coefficient, in the left inferior frontal gyrus. However, in a follow-up analysis we controlled for subgoal displacement (e.g., the distance between the original package location and point D in [Figure 2](#fig2)), a nuisance variable moderately correlated, across trials, with the change in distance to subgoal. Within this analysis only the ACC (p < 0.01), bilateral anterior insula (p < 0.01 left, p < 0.05 right), and right lingual gyrus (p < 0.01) continued to show significant correlations with the PPE.

![](https://www.cell.com/cms/10.1016/j.neuron.2011.05.042/asset/b1959080-eae2-4395-9c61-d5e10653df47/main.assets/gr4_lrg.jpg)

Figure 4 Results of fMRI Experiment 1

In a series of region-of-interest (ROI) analyses, we focused in on additional neural structures that, like the ACC, have been previously proposed to encode negative RPEs: the habenular complex (

47.

Salas, R. ∙ Baldwin, P. ∙ de Biasi, M....

*Front. Hum. Neurosci.* 2010; **4**:36

[PubMed](https://pubmed.ncbi.nlm.nih.gov/20485575/)

[Google Scholar](https://scholar.google.com/scholar_lookup?pmid=20485575)

55.

Ullsperger, M. ∙ von Cramon, D.Y.

**Error monitoring using external feedback: specific roles of the habenular complex, the reward system, and the cingulate motor area revealed by functional magnetic resonance imaging**

*J. Neurosci.* 2003; **23**:4308-4314

[PubMed](https://pubmed.ncbi.nlm.nih.gov/12764119/)

[Google Scholar](https://scholar.google.com/scholar_lookup?pmid=12764119)

), nucleus accumbens (NAcc) (

50.

Seymour, B. ∙ Daw, N. ∙ Dayan, P....

**Differential encoding of losses and gains in the human striatum**

*J. Neurosci.* 2007; **27**:4826-4831

), and amygdala (). (These analyses were intended to bring greater statistical power to bear on these regions, in part because their small size may have undermined our ability to detect activation in them in our whole-brain analysis, where a cluster-size threshold was employed.) The habenular complex was found to display greater activity following type D than type E jumps (p < 0.05), consistent with the idea that this structure is also engaged by negative PPEs. A comparable effect was also observed in the right, though not left, amygdala (p < 0.05).

In the NAcc, where some studies have observed deactivation accompanying negative RPEs (

30.

Knutson, B. ∙ Taylor, J. ∙ Kaufman, M....

**Distributed neural representation of expected value**

*J. Neurosci.* 2005; **25**:4806-4812

), no significant PPE effect was observed. However, it should be noted that NAcc deactivation with negative RPEs has been an inconsistent finding in previous work (for example, see ). More robust is the association between NAcc activation and positive RPEs (

23.

Hare, T.A. ∙ O'Doherty, J. ∙ Camerer, C.F....

**Dissociating the role of the orbitofrontal cortex and the striatum in the computation of goal values and prediction errors**

*J. Neurosci.* 2008; **28**:5623-5630

39.

Niv, Y.

**Reinforcement learning in the brain**

*J. Math. Psychol.* 2009; **53**:139-154

49.

Seymour, B. ∙ O'Doherty, J.P. ∙ Dayan, P....

**Temporal difference models describe higher-order learning in humans**

*Nature.* 2004; **429**:664-667

). To test this directly, we ran a second, smaller fMRI study designed to elicit positive PPEs, specifically looking for activation within a NAcc ROI. A total of 14 participants performed the delivery task, with jumps of type C (in [Figure 2](#fig2)) occurring on one-third of trials and jumps of type E on another third. As described earlier, a positive PPE is predicted to occur in association with type C jumps, and in this setting significant activation (p < 0.05) was observed in the right (though not left) NAcc, scaling with predicted PPE magnitude.

### Behavioral Experiment

We have characterized the results from our EEG and fMRI experiments as displaying a “signature” of HRL, in the sense that the PPE signal is predicted by HRL but not by standard RL algorithms ([Figure 2](#fig2)). However, there is an important caveat that we now consider. In our neuroimaging experiments we assumed that reaching the goal (the house) would be associated with primary reward. (The same points hold if “primary reward” is replaced with “secondary” or “conditioned reinforcement.”) We also assumed that reaching the subgoal (the package) was not associated with primary reward but only with pseudo-reward. However, what if participants did attach primary reward to the subgoal? If this were the case, it would present a difficulty for the interpretation of our neuroimaging results because it would lead standard RL to predict an RPE in association with events that change only subgoal distance (including C and D jumps in our neuroimaging task).

In view of these points, it was necessary to establish whether participants performing the delivery task did or did not attach primary reward to subgoal attainment. In order to evaluate this, we devised a modified version of the task. Here, 22 participants delivered packages as before, though without jump events. However, at the beginning of each delivery trial, two packages were presented in the display, which defined paths that could differ both in terms of their subgoal distance and the overall distance to the goal ([Figure 5](#fig5), left). Participants indicated with a key press which package they preferred to deliver.

![](https://www.cell.com/cms/10.1016/j.neuron.2011.05.042/asset/dfb3ad51-293a-4d53-a871-c062524d55ec/main.assets/gr5_lrg.jpg)

Figure 5 Results of Behavioral Experiment

We reasoned that if goal attainment were associated with primary reward, then (assuming ordinary temporal discounting) the overall goal distance associated with each of the two packages should influence choice. More importantly, if we were correct in our assumption that subgoal attainment carried no primary reward, then choice should not be influenced by subgoal distance, i.e., the distance from the truck to each of the two packages.

Participants' choices strongly supported both of these predictions. Logistic regression analyses indicated that goal distance had a strong influence on package choice (M = −7.6, p < 0.001; [Figure 5](#fig5), right; larger negative coefficients indicate a larger penalty on distances). However, subgoal distance exerted no appreciable influence on choice (p = 0.43), and the average regression coefficient was near zero (−0.16). The latter observation held even in a subset of trials where the two delivery options were closely matched in terms of overall distance (with ratios of overall goal distance between 0.8 and 1.2).

These behavioral results strongly favor our HRL account of delivery task, over a standard RL account. (The behavioral data are consistent with a standard RL model that attaches no reward to subgoal attainment, but as noted earlier, such a model offers no explanation for our neuroimaging results.) To further establish the point, we fit two computational models to individual subjects' choice data: (1) an HRL model, and (2) a standard RL model in which primary reward was attached to the subgoal (see [Experimental Procedures](#sec-4)). The mean Bayes factor across subjects—with values greater than one favoring the HRL model—was 4.31, and values across subjects differed significantly from one (two-tailed t test, p < 0.001; see [Figure 5](#fig5), right).

## Discussion

We predicted, based on HRL, that neural structures previously proposed to encode TD RPEs should also respond to PPEs—prediction errors tied to behavioral subgoals. Across three experiments using a task designed to elicit PPEs, without eliciting RPEs, we observed evidence consistent with this prediction. Negative PPEs were found to engage three structures previously reported to show activation with negative RPEs: ACC, habenula, and amygdala; and activation scaling with positive PPEs was observed in right NAcc, a location frequently reported to be engaged by positive RPEs.

Of course the association of these neural responses with the relevant task events does not uniquely support an interpretation in terms of HRL (see

45.

Poldrack, R.A.

**Can cognitive processes be inferred from neuroimaging data?**

*Trends Cogn. Sci. (Regul. Ed.).* 2006; **10**:59-63

). However, aspects of either the task or the experimental results do militate against the most tempting alternative interpretations. Our behavioral study provided evidence against primary reward at subgoal attainment, closing off an interpretation of the neuroimaging data in terms of standard RL. Given previous findings pertaining to the ACC, the effect we observed in this structure might be conjectured to reflect response conflict or error detection (). However, additional analyses of the EEG data (see [Figure S2](#supplementary-material) and [Supplemental Experimental Procedures](#supplementary-material)) indicated that the PPE effect persisted even after controlling for response accuracy and for response latency, each commonly regarded as an index of response conflict.

Another alternative that must be addressed relates to spatial attention. Jump events in our neuroimaging experiments presumably triggered shifts in attention, often complete with eye movements, and it is important to consider the possibility that differences between conditions on this level may have contributed to our central findings. Although further experiments may be useful in pinning down the precise role of attention in our task, there are several aspects of the present results that argue against an interpretation based purely on attention. Note that, in previous EEG research, exogenous shifts of attention have been associated with a midline positivity, the amplitude of which grows with stimulus eccentricity (

58.

Yamaguchi, S. ∙ Tsuchiya, H. ∙ Kobayashi, S.

**Electrophysiologic correlates of visuo-spatial attention shift**

*Electroencephalogr. Clin. Neurophysiol.* 1995; **94**:450-461

). (A midline negativity has been reported in at least one study focusing on endogenous attention (

22.

Grent-'t-Jong, T. ∙ Woldorff, M.G.

**Timing and sequence of brain activity in top-down control of visual-spatial attention**

*PLoS Biol.* 2007; **5**:e12

), but the timing of this potential differed dramatically from the difference wave in our EEG study, peaking at 1000–1200 ms poststimulus, hundreds of milliseconds after our effect ended.) In fact we observed such a positivity in our own data, in Cz, when we compared jump events (D and E) against occasions where the subgoal stayed put, an analysis specifically designed to uncover attentional effects ([Figure S3](#supplementary-material)). In contrast the PPE effect in our data took the form of a negative difference wave ([Figure 3](#fig3)), consistent with the predictions of HRL and contrary to those proceeding from previous research on attention.

Our fMRI results also resist an interpretation based on spatial attention alone. As detailed in the [Supplemental Experimental Procedures](#supplementary-material), we did find activation in or near the frontal eye fields and in the superior parietal cortex—regions classically associated with shifts of attention (

16.

Corbetta, M. ∙ Patel, G. ∙ Shulman, G.L.

**The reorienting system of the human brain: from environment to theory of mind**

*Neuron.* 2008; **58**:306-324

)—in an analysis contrasting all jump events with trials where the subgoal remained in its original location ([Figure S4](#supplementary-material)). However, as reported above, activity in these regions did not show any significant correlation with our PPE regressor ([Figure 4](#fig4)).

If one does adopt an HRL-based interpretation of the present results, then several interesting questions follow. Given the prevailing view that TD RPEs are signaled by phasic changes in dopaminergic activity (

48.

Schultz, W. ∙ Dayan, P. ∙ Montague, P.R.

**A neural substrate of prediction and reward**

*Science.* 1997; **275**:1593-1599

), one obvious question is whether the PPE might be signaled via the same channel. ACC activity in association with negative RPEs has been proposed to reflect phasic reductions in dopaminergic input (), and the habenula has been proposed to provide suppressive input to midbrain dopaminergic nuclei (

13.

Christoph, G.R. ∙ Leonzio, R.J. ∙ Wilcox, K.S.

**Stimulation of the lateral habenula inhibits dopamine-containing neurons in the substantia nigra and ventral tegmental area of the rat**

*J. Neurosci.* 1986; **6**:613-619

[PubMed](https://pubmed.ncbi.nlm.nih.gov/3958786/)

[Google Scholar](https://scholar.google.com/scholar_lookup?pmid=3958786)

34.

Matsumoto, M. ∙ Hikosaka, O.

**Lateral habenula as a source of negative reward signals in dopamine neurons**

*Nature.* 2007; **447**:1111-1115

). Thus, the implication of the ACC and habenula in the present study, as well as the involvement of the NAcc—another structure that has been proposed to show activity related to dopaminergic input (

37.

Nicola, S.M. ∙ Surmeier, J. ∙ Malenka, R.C.

**Dopaminergic modulation of neuronal excitability in the striatum and nucleus accumbens**

*Annu. Rev. Neurosci.* 2000; **23**:185-215

)—provides tentative, indirect support for dopaminergic involvement in HRL. At the same time, it should be noted that some ambiguity surrounds the role of dopamine in driving reward-outcome responses, particularly within the ACC (for a detailed review, see

29.

Jocham, G. ∙ Ullsperger, M.

**Neuropharmacology of performance monitoring**

*Neurosci. Biobehav. Rev.* 2009; **33**:48-60

). Indeed, some disagreement still exists concerning whether the dorsal ACC is responsible for generating the FRN (compare

28.

Holroyd, C.B. ∙ Nieuwenhuis, S. ∙ Yeung, N....

**Dorsal anterior cingulate cortex shows fMRI response to internal and external error signals**

*Nat. Neurosci.* 2004; **7**:497-498

38.

Nieuwenhuis, S. ∙ Slagter, H.A. ∙ von Geusau, N.J.A....

**Knowing good from bad: differential activation of human cortical areas by positive and negative outcomes**

*Eur. J. Neurosci.* 2005; **21**:3161-3168

56.

van Veen, V. ∙ Holroyd, C.B. ∙ Cohen, J.D....

**Errors without conflict: implications for performance monitoring theories of anterior cingulate cortex**

*Brain Cogn.* 2004; **56**:267-276

). Thus, the present findings must be interpreted with appropriate circumspection. Above all, it should be noted that our HRL-based interpretation does not necessarily require a role for dopamine in generating the observed neural events. Indeed, if the PPE were conveyed via phasic dopaminergic signaling, this would give rise to an interesting computational problem because proper credit assignment would require discrimination between PPE and RPE signals (for discussion, see

9.

Botvinick, M.M. ∙ Niv, Y. ∙ Barto, A.C.

**Hierarchically organized behavior and its neural foundations: a reinforcement learning perspective**

*Cognition.* 2009; **113**:262-280

).

Another important question for further research concerns the relation between the present findings and recent data concerning the representation of action hierarchies in the dorsolateral prefrontal cortex (

1.

Badre, D.

**Cognitive control, hierarchy, and the rostro-caudal organization of the frontal lobes**

*Trends Cogn. Sci. (Regul. Ed.).* 2008; **12**:193-200

7.

Botvinick, M.M.

**Hierarchical models of behavior and prefrontal function**

*Trends Cogn. Sci. (Regul. Ed.).* 2008; **12**:201-208

). Neuroimaging and neuropsychological studies have lately given rise to the idea that the prefrontal cortex may display a rostrocaudal functional topography, which separates out task representations based on some measure of abstractness (

3.

Badre, D. ∙ Hoffman, J. ∙ Cooney, J.W....

**Hierarchical cognitive control deficits following damage to the human frontal lobe**

*Nat. Neurosci.* 2009; **12**:515-522

12.

Christoff, K. ∙ Keramatian, K. ∙ Gordon, A.M....

**Prefrontal organization of cognitive control according to levels of abstraction**

*Brain Res.* 2009; **1286**:94-105

21.

Grafman, J.

**The human prefrontal cortex has evolved to represent components of structured event complexes**

Grafman, J. (Editor)

**Handbook of Neuropsychology**

Elsevier, Amsterdam, 2002

[Google Scholar](https://scholar.google.com/scholar?q=J.GrafmanThe+human+prefrontal+cortex+has+evolved+to+represent+components+of+structured+event+complexesJ.GrafmanHandbook+of+Neuropsychology2002ElsevierAmsterdam)

31.

Kouneiher, F. ∙ Charron, S. ∙ Koechlin, E.

**Motivation and cognitive control in the human prefrontal cortex**

*Nat. Neurosci.* 2009; **12**:939-945

). One speculation, which could be tested through further research, is that HRL-like mechanisms might be responsible for shaping such representations and gating them into working memory in an adaptive fashion (see

9.

Botvinick, M.M. ∙ Niv, Y. ∙ Barto, A.C.

**Hierarchically organized behavior and its neural foundations: a reinforcement learning perspective**

*Cognition.* 2009; **113**:262-280

46.

Reynolds, J.R. ∙ O'Reilly, R.C.

**Developing PFC representations using reinforcement learning**

*Cognition.* 2009; **113**:281-292

).

One final challenge for future research is to test predictions from HRL in settings involving learning-driven changes in action selection. As in many neuroscientific studies focusing on RL mechanisms, our task looked at prediction errors in a setting where behavioral policies were more or less stable. It may also prove useful to study the dynamics of learning in hierarchically structured tasks, as a further test of the relevance of HRL to neural function (see Diuk et al., 2010, Soc. Neurosci., abstract, 907.14/KKK47;

2.

Badre, D. ∙ Frank, M.J.

**Mechanisms of hierarchical reinforcement learning in cortico-striatal circuits 2: evidence from fMRI**

*Cereb. Cortex.* 2011;

in press. Published online June 21, 2011

[Google Scholar](https://scholar.google.com/scholar?q=D.BadreM.J.FrankMechanisms+of+hierarchical+reinforcement+learning+in+cortico-striatal+circuits+2%3A+evidence+from+fMRICereb.+Cortex2011in+press.+Published+online+June+21%2C+2011)

).

## Experimental Procedures

### An HRL Model of the Delivery Task

To make our computational predictions explicit, we implemented both a standard and a hierarchical RL model of the delivery task, based on the approach laid out in

9.

Botvinick, M.M. ∙ Niv, Y. ∙ Barto, A.C.

**Hierarchically organized behavior and its neural foundations: a reinforcement learning perspective**

*Cognition.* 2009; **113**:262-280

. Simulations were performed in MATLAB (The MathWorks, Natick, MA); the relevant code is available for download from [http://www.princeton.edu/∼matthewb](http://www.princeton.edu/~matthewb).

For the standard RL agent, the state on each step *t*, labeled *s <sub>t</sub>*, was represented by the goal distance (*gd*), the distance from the truck to the house, via the package, in units of navigation steps. For the HRL agent the state was represented by two numbers: *gd* and the subgoal distance (*sd*), i.e., the distance between the truck and the package. Goal attainment yielded a reward (*r*) of one for both agents, and subgoal attainment a pseudo-reward () of one for the HRL agent. On each step of the task, the agent was assumed to act optimally, i.e., to take a single step directly toward the package or, later in the task, toward the house. The HRL agent was assumed to select a subroutine () for attaining the package, which also resulted in direct steps toward this subgoal (for details of subtask specification and selection, see [Figure 1](#fig1) and

9.

Botvinick, M.M. ∙ Niv, Y. ∙ Barto, A.C.

**Hierarchically organized behavior and its neural foundations: a reinforcement learning perspective**

*Cognition.* 2009; **113**:262-280

53.

Sutton, R.S. ∙ Precup, D. ∙ Singh, S.

**Between MDPs and semi-MDPs: a framework for temporal abstraction in reinforcement learning**

*Artif. Intell.* 1999; **112**:181-211

).

For the standard RL agent, the state value at time *t*, *V(t)*, was defined as , using a discount factor = 0.9. Thus, the RPE on steps prior to goal attainment was:

(1)

The HRL agent calculated RPEs in the same manner but also calculated PPEs during execution of the subroutine . These were based on a subroutine-specific value function (see

9.

Botvinick, M.M. ∙ Niv, Y. ∙ Barto, A.C.

**Hierarchically organized behavior and its neural foundations: a reinforcement learning perspective**

*Cognition.* 2009; **113**:262-280

53.

Sutton, R.S. ∙ Precup, D. ∙ Singh, S.

**Between MDPs and semi-MDPs: a framework for temporal abstraction in reinforcement learning**

*Artif. Intell.* 1999; **112**:181-211

), defined as .

Thus, the PPE on each step prior to subgoal attainment was:

(2)

To generate the data shown in [Figure 2](#fig2), we imposed initial distances (*gd*, *sd*) equaling 949 and 524. Following two task steps in the direction of the package, at a point with distances 849 and 424, in order to represent jump events distances were changed to 599 and 424 for jump type A, 1449 and 424 for type B, 849 and 124 for type C, 849 and 724 for type D, and 849 and 424 for type E. Dashed data series in [Figure 2](#fig2) were generated with jumps to 849 and 236 for type C and 849 and 574 for type D.

### EEG Experiment

#### Participants

All experimental procedures were approved by the Institutional Review Board of Princeton University. Participants were recruited from the university community, and all gave their informed consent. Nine participants were recruited (ages 18–22 years, M = 19.7, 4 males, all right handed). All received course credit as compensation, and in addition received a monetary bonus based on their performance in the task.

#### Task and Procedure

Participants sat at a comfortable distance from a shielded CRT display in a dimly lit, sound-attenuating, electrically shielded room. A joystick was held in the right hand (Logitech International, Romanel-sur-Morges, Switzerland).

The computerized task was coded using MATLAB (The MathWorks) and the MATLAB Psychophysics Toolbox, version 3 (

10.

Brainard, D.H.

**The psychophysics toolbox**

*Spat. Vis.* 1997; **10**:433-436

). On each trial, three display elements appeared: a truck, a package, and a house ([Figure S1](#supplementary-material) A). These objects occupied the vertices of a virtual triangle with vertices at pixel coordinates 0 and 180, 150 and 30, and 0 and 180, relative to the center of the screen (resolution 1024 × 768) but assuming a random new rotation and reflection at the onset of each trial. The task was to move the truck first to the package and then to the house. Each joystick movement displaced the truck a fixed distance of 50 pixels. For reasons given below the orientation of the truck was randomly chosen after every such translation, and participants were required to tailor their joystick responses to the truck's orientation, as if they were facing its steering wheel ([Figure S1](#supplementary-material) A). For example if the front of the truck were oriented toward the bottom of the screen, rightward movement of the joystick would move the truck to the left. This aspect of the task was intended to ensure that intensive spatial processing occurred at each step of the task, rather than only following subgoal displacements.

Responses were registered when the joystick was tilted beyond half its maximum displacement ([Figure S1](#supplementary-material) A). Between responses the participant was required to restore the joystick to a central position ([Figures S1](#supplementary-material) A and S1B). When the truck passed within 30 pixels of the package, the package moved inside the truck icon and remained there for subsequent moves. When the truck containing the package passed within 35 pixels of the house, the display cleared, and a message reading “10¢” appeared for a duration of 300 ms (participants were paid their cumulative earnings at the end of the experiment). A central fixation cross then appeared for 700 ms before the onset of the next trial.

On every trial, after the first, second, or third truck movement, a brief tone occurred, and the package flashed for an interval of 200 ms, during which any joystick inputs were ignored. On one-third of such occasions, the package remained in its original location. On the remaining trials, at the onset of the tone, the package jumped to a new location. In half of such cases, the distance between the package's new position and the truck position was unchanged by the jump (case E in [Figure 2](#fig2) of the main text). In the remaining cases the distance from the truck to the package was increased by the jump, although the total distance from the truck to the house (via the package) remained the same (case D in [Figure 2](#fig2)). In these cases the jump always carried the package across an imaginary line connecting the truck and the house, and always resulted in a package-to-house distance of 160 pixels. In all three conditions the package would be on an ellipse defined by the locations of the old subgoal, the house, and the position of the truck at the time of the jump. By the definition of an ellipse, overall distance to the house was preserved.

At the outset of the experiment, each participant completed a 15 min training session, which was followed by the hour-long EEG testing session. Participants completed 190 trials on average (range 128–231). Trials were grouped into blocks, each containing six trials: two trials in which the position of the package did not change, two involving type E jumps, and two type D jumps. The order in which trials of a particular type occurred was pseudorandom within a block. Participants were given an opportunity to rest for a brief period between task blocks.

#### Data Acquisition

EEG data were recorded using Neuroscan (Charlotte, NC) caps with 128 electrodes and a Sensorium (Charlotte, VT) EPA-6 amplifier. The signal was sampled at 1000 Hz. All data were referenced online to a chin electrode, and after excluding bad channels were rereferenced to the average signal across all remaining channels (). EOG data were recorded using a single electrode placed below the left eye. Ocular artifacts were detected by thresholding a slow-moving average of the activity in this channel, and trials with artifacts were not included in the analysis. Less than four trials per subject matched this criterion and were excluded from the analysis (less than two per condition).

#### Data Analysis

Epochs of 1000 ms (200 ms baseline) were extracted from each trial, time locked to the package's change in position. The mean level of activity during the baseline interval was subtracted from each epoch. Trials containing type D jump were separated from trials containing jumps of type E, and ERPs were computed for each condition and participant by averaging the corresponding epochs. The ERPs shown in [Figure 3](#fig3) (main text) were computed by averaging across participants. The PPE effect was quantified in electrode Cz (following ).

The PPE effect was quantified for each subject by taking the mean voltage during the time window from 200 to 600 ms following each jump, for the two jump types. A one-tailed paired t test was used to evaluate the hypothesis that type D jumps elicited a more negative potential than type E jumps. For comparability with previous studies, topographic plots are shown for electrodes FP1, FP2, AFz, F3, Fz, F4, FT7, FC3, FCz, FC4, FT8, T7, C3, Cz, C4, T8, TP7, CP3, CPz, CP4, TP8, P7, P3, Pz, P4, P8, O1, Oz, and O2 (as in

60.

Yeung, N. ∙ Holroyd, C.B. ∙ Cohen, J.D.

**ERP correlates of feedback and reward processing in the presence and absence of response choice**

*Cereb. Cortex.* 2005; **15**:535-544

, F7 and F8 were an exception, given that the used cap did not have these electrode locations).

### fMRI Experiments

#### Participants

Participants were recruited from the university community and all gave their informed consent. For the first fMRI experiment, 33 participants were recruited (ages 18–37 years, M = 21.2, 20 males, all right handed). Three participants were excluded: two because of technical problems and one who was unable to complete the task in the available time. For the second experiment, 15 participants were recruited (ages 18–25 years, M = 20.5, 11 males, all were right handed). One participant was excluded for failure to complete the task in the available time. All participants received monetary compensation at a departmental standard rate. Participants in the second experiment also received a small monetary bonus based on task performance.

#### Task and Procedure

An MR-compatible joystick (MagConcept, Redwood City, CA) was used. The task was identical to the one used in the EEG experiment, with the following exceptions. For the first experiment initial positions of the icons were randomly assigned to the screen respecting a minimal distance of 150 pixels between icons. For the second experiment initial positions of the icons were rotations or reflections, varied randomly, of a preestablished arrangement of icons of a predetermined triangle with vertices truck (0, 200), package (151, −165), and house (0, −200) (coordinates are in pixels, referenced to the center of the screen). On type D jumps, the destination of the package was chosen randomly from all locations satisfying the conditions that they (1) increase truck-to-package distance, but (2) leave total path length to the goal (house) unchanged. The forced delay involved in the task interruption (tone, package flashing) totaled 900 ms. At the completion of each delivery, the message “Congratulations!” was displayed for 1000 ms ([Figure S1](#supplementary-material) D), followed by a fixation cross that remained on screen for 6000 ms.

The first fMRI experiment consisted of three parts: a 15 min behavioral practice outside the scanner, an 8 min practice inside the scanner during structural scan acquisition, and a third phase of approximately 45 min, where functional data were collected. During functional scanning, 90 trials were completed, in 6 runs of 15 trials each. At the beginning and end of each run, a central fixation cross was displayed for 10,000 ms. The average run length was 7.5 min (range 5.7–11).

The task and procedure in the second fMRI experiment were identical to those in the first, with the following exceptions. Type D jumps were replaced with type C jumps (see [Figure 2](#fig2) in the main text). In these cases, the distance between truck and package always decreased to 120 pixels. The message “10¢” appeared for 500 ms, indicating the bonus earned for that trial. Immediately following this, a fixation cross appeared for 2500 ms, followed by onset of the next trial. The average run length was 6.8 min (range 4.7–10.7).

#### Image Acquisition

Image acquisition protocols were the same for both experiments. Data were acquired with a 3 T Siemens Allegra (Malvern, PA) head-only MRI scanner, with a circularly polarized head volume coil. High-resolution (1 mm <sup>3</sup> voxels) T1-weighted structural images were acquired with an MP-RAGE pulse sequence at the beginning of the scanning session. Functional data were acquired using a high-resolution echo-planar imaging pulse sequence (3 × 3 × 3 mm voxels, 34 contiguous slices, 3 mm thick, interleaved acquisition, TR of 2000 ms, TE of 30 ms, flip angle 90°, field of view 192 mm, aligned with the anterior commissure-posterior commissure plane). The first five volumes of each run were ignored.

#### Data Analysis

Data analysis was similar for both experiments. Data were analyzed using AFNI software (

17.

Cox, R.W.

**AFNI: software for analysis and visualization of functional magnetic resonance neuroimages**

*Comput. Biomed. Res.* 1996; **29**:162-173

). The T1-weighted anatomical images were aligned to the functional data. Functional data were corrected for interleaved acquisition using Fourier interpolation. Head motion parameters were estimated and corrected allowing six-parameter rigid body transformations, referenced to the initial image of the first functional run. A whole-brain mask for each participant was created using the union of a mask for the first and last functional images. Spikes in the data were removed and replaced with an interpolated data point. Data were spatially smoothed until spatial autocorrelation was approximated by a 6 mm FHWM Gaussian kernel. Each voxel's signal was converted to percent change by normalizing it based on intensity. The mean image for each volume was calculated and used later as baseline regressor in the general linear model, except in the ROI analysis where the mean image of the whole brain was not subtracted from the data. Anatomical images were used to estimate normalization parameters to a template in Talairach space (

54.

Talairach, J. ∙ Tournoux, P.

**Co-Planar Stereotaxic Atlas of the Human Brain**

Thieme Medical Publishers, Inc., New York, 1988

[Google Scholar](https://scholar.google.com/scholar?q=J.TalairachP.TournouxCo-Planar+Stereotaxic+Atlas+of+the+Human+Brain1988Thieme+Medical+Publishers%2C+Inc.New+York)

), using SPM5 ([http://www.fil.ion.ucl.ac.uk/spm/](http://www.fil.ion.ucl.ac.uk/spm/)). These transformations were applied to parameter estimates from the general linear model.

#### General Linear Model Analysis

For each participant we created a design matrix modeling experimental events and including events of no interest. At the time of an experimental event, we defined an impulse and convolved it with a hemodynamic response. The following regressors were included in the model: (a) an indicator variable marking the occurrence of all auditory tone/package flash events; (b) an indicator variable marking the occurrence of all jump events (spanning jump types E and D in Experiment 1 and types E and C in Experiment 2); (c) an indicator variable marking the occurrence of type D jumps (C jumps in Experiment 2); (d) a parametric regressor indicating the change in distance to subgoal induced by each D (or C) jumps, mean centered; (e and f) indicator variables marking subgoal and goal attainment; and (g) an indicator variable marking all periods of task performance, from the initial presentation of the icons to the end of the trial. Also included were head motion parameters, and first- to third-order polynomial regressors to regress out scanner drift effects. In Experiment 1, a global signal regressor was also included (comparable analyses omitting the global signal regressor yielded statistically significant PPE effects in the ACC, bilateral insula, and lingual gyrus, in locations highly overlapping with those reported in the main text).

#### Group Analysis (Experiment 1)

For each regressor and for each voxel, we tested the sample of 30 subject-specific coefficients against zero in a two-tailed t test. We defined a threshold of p = 0.01 and applied correction for multiple comparison based on cluster size, using Monte Carlo simulations as implemented in AFNI's AlphaSim. We report results at a corrected p < 0.01.

#### Follow-up Analysis (Experiment 1)

Our experimental prediction related to the change in distance between truck and package induced by type D-jump events, i.e., the change in distance to subgoal, or PPE effect. However, jump events also varied in the degree to which they displaced the package (i.e., the distance from its original position to its post-jump position), and this distance correlated moderately with the increase in subgoal distance. Therefore, it was necessary to evaluate whether the regions of activation identified in our primary GLM analysis might simply be responding to subgoal displacement (and possible attendant visuospatial or motor processes), rather than the increase in distance to subgoal. To this end, we looked at each area identified in the primary GLM, asking whether the area continued to a show significant PPE effect even after this regressor was made orthogonal to subgoal displacement. In order to avoid bias in this procedure, we employed a leave-one-out cross-validation approach, as follows. For every subgroup of 29 participants (from the total sample of 30), we reran the original GLM, identifying voxels that: (1) showed the PPE effect at significance threshold of p = 0.05 (cluster-size thresholded to compensate for multiple comparisons); and (2) fell within 33 mm of the peak-activation coordinates for one of the six clusters identified in our primary GLM (dorsal anterior cingulate, bilateral anterior insulae, left lingual gyrus, left inferior frontal gyrus, and right supramarginal gyrus). The resulting clusters were used as ROIs for the critical test. Focusing on the one subject omitted from each 29 subject subsample, we calculated the mean coefficient within each ROI for the PPE effect, after orthogonalizing the PPE regressor to subgoal displacement (and including subgoal displacement in the GLM). This yielded 30 coefficients per ROI. Each set was tested for difference from zero, using a two-tailed t test.

#### ROI Analysis

For the first fMRI experiment, we defined NAcc based on anatomical boundaries on a high-resolution T1-weighted image for each participant; habenula, using peak Talairach coordinates (5, 25, 8), guided by

55.

Ullsperger, M. ∙ von Cramon, D.Y.

**Error monitoring using external feedback: specific roles of the habenular complex, the reward system, and the cingulate motor area revealed by functional magnetic resonance imaging**

*J. Neurosci.* 2003; **23**:4308-4314

[PubMed](https://pubmed.ncbi.nlm.nih.gov/12764119/)

[Google Scholar](https://scholar.google.com/scholar_lookup?pmid=12764119)

, surrounded by a sphere with a radius of 6 mm (

47.

Salas, R. ∙ Baldwin, P. ∙ de Biasi, M....

*Front. Hum. Neurosci.* 2010; **4**:36

[PubMed](https://pubmed.ncbi.nlm.nih.gov/20485575/)

[Google Scholar](https://scholar.google.com/scholar_lookup?pmid=20485575)

); and amygdala, drawn using the Talairach atlas in AFNI. For the second experiment we defined NAcc in the same way as for the first experiment. Mean coefficients were extracted from these regions for each participant. Reported coefficients for all ROIs are from general linear model analyses without subtraction of global signal. The sample of 30 (or 14 for the second experiment) subject-specific coefficients was tested against zero in a two-tailed t test, with a threshold of p < 0.05.

### Behavioral Experiment

#### Participants

A total of 22 participants were recruited from the Princeton University community (ages 18–22 years, 11 male). All provided informed consent and received a nominal payment.

#### Task and Procedure

The experiment was composed of three phases. In the first phase, participants completed ten deliveries, with the procedure matching that used in our fMRI studies. However, no jump events occurred in this or later phases of the experiment. The second phase consisted of ten further delivery trials. However, here, at the onset of each trial, the participant was required to choose between two packages ([Figure 5](#fig5)). The location of the truck and the house was chosen randomly. The location of one package, designated subgoal one, was randomly positioned along an ellipse with the truck and house as its foci and a major-to-minor axis ratio of 5/3. The position of the other package, subgoal two, was randomly chosen, subject to the constraint that it fall at least 100 pixels from each of the other icons.

At the onset of each trial, each package would be highlighted with a change of color, twice (in alternation with the other package), for a period of 1.5 s. Highlighting order was counterbalanced across trials. During this period the participant was required to press a key to indicate his or her preferred package when that package was highlighted. After the key press, the chosen subgoal would change to a new color. At the end of the choice period, the unchosen subgoal was removed, and participants were expected to initiate the delivery task. The remainder of each trial proceeded as in phase one.

The third and main phase of the experiment included 100 trials. One-third of these, interleaved in random order with the rest, followed the profile of phase two trials. The remaining trials began as in phase two but terminated immediately following the package-choice period.

#### Data Analysis

To determine the influence of goal and subgoal distance on package choice, we conducted a logistic regression on the choice data from phase three. Regressors included (1) the ratio of the distances from the truck to subgoal one and subgoal two, and (2) the ratio of the distances from the truck to the house through subgoal one and subgoal two. To test for significance across subjects, we carried out a two-tailed t test on the population of regression coefficients.

To further characterize the results, we fitted two RL models to each participant's phase-three choice data. One model assigned primary reward only to goal attainment and so was indifferent to subgoal distance per se. A second model assigned primary reward to the subgoal as well to the goal.

Value in the first case was a discounted number of steps to the goal, and in the second case it was a sum of discounted number of steps to the subgoal and to the goal. Choice was modeled using a softmax function, including a free inverse temperature parameter. The fmincon function in MATLAB was employed to fit discount factor and inverse temperature parameters for both models and reward magnitude for subgoal attainment for the second model. We then compared the fits of the two models calculating Bayes factor for each participant and performing a two-tailed t test on the factors.

## Acknowledgments

We thank Francisco Pereira for useful suggestions, and Steven Ibara, Wouter Kool, Janani Prabhakar, and Natalia Córdova for help with running participants. J.J.F.R.-F. was supported by the Fundação para a Ciência e Tecnologia, scholarship SFRH/BD/33273/2007, A.S. by an INRSA Training Grant in Quantitative Neuroscience 2 T32 MH065214, A.G.B. by AFOSR Grant FA9550-08-1-041, Y.N. by a Sloan Research Fellowship, and M.M.B. by the National Institute of Mental Health Grant P50 MH062196 and a Collaborative Activity Award from the James S. McDonnell Foundation.

## Supplemental Information (1)

[PDF (2.90 MB)](https://www.cell.com/cms/10.1016/j.neuron.2011.05.042/attachment/f40a10c2-7606-4be1-8cf2-584010d0afce/mmc1.pdf)

Document S1. Four Figures and Supplemental Experimental Procedures

## References

[1.](#body-ref-bib7-2 "View in article")

Badre, D.

**Cognitive control, hierarchy, and the rostro-caudal organization of the frontal lobes**

*Trends Cogn. Sci. (Regul. Ed.).* 2008; **12**:193-200

[2.](#body-ref-bib25 "View in article")

Badre, D. ∙ Frank, M.J.

**Mechanisms of hierarchical reinforcement learning in cortico-striatal circuits 2: evidence from fMRI**

*Cereb. Cortex.* 2011;

in press. Published online June 21, 2011

[Google Scholar](https://scholar.google.com/scholar?q=D.BadreM.J.FrankMechanisms+of+hierarchical+reinforcement+learning+in+cortico-striatal+circuits+2%3A+evidence+from+fMRICereb.+Cortex2011in+press.+Published+online+June+21%2C+2011)

[3.](#body-ref-bib32 "View in article")

Badre, D. ∙ Hoffman, J. ∙ Cooney, J.W....

**Hierarchical cognitive control deficits following damage to the human frontal lobe**

*Nat. Neurosci.* 2009; **12**:515-522

[5.](#body-ref-bib49-1 "View in article")

Barto, A.G.

**Adaptive critics and the basal ganglia**

Houk, J.C. ∙ Davis, J. ∙ Beiser, D. (Editors)

**Models of Information Processing in the Basal Ganglia**

MIT Press, Cambridge, MA, 1995; 215-232

[Google Scholar](https://scholar.google.com/scholar?q=A.G.BartoAdaptive+critics+and+the+basal+gangliaJ.C.HoukJ.DavisD.BeiserModels+of+Information+Processing+in+the+Basal+Ganglia1995MIT+PressCambridge%2C+MA215232)

[6.](#body-ref-bib54-1 "View in article")

Barto, A.G. ∙ Mahadevan, S.

**Recent advances in hierarchical reinforcement learning**

*Discrete Event Dyn. Syst.* 2003; **13**:341-379

[Crossref](https://doi.org/10.1023/A:1025696116075)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1023%2FA%3A1025696116075)

[7.](#body-ref-bib9-1 "View in article")

Botvinick, M.M.

**Hierarchical models of behavior and prefrontal function**

*Trends Cogn. Sci. (Regul. Ed.).* 2008; **12**:201-208

[8.](#body-ref-bib60 "View in article")

Botvinick, M. ∙ Nystrom, L.E. ∙ Fissell, K....

**Conflict monitoring versus selection-for-action in anterior cingulate cortex**

*Nature.* 1999; **402**:179-181

[9.](#body-ref-bib9-1 "View in article")

Botvinick, M.M. ∙ Niv, Y. ∙ Barto, A.C.

**Hierarchically organized behavior and its neural foundations: a reinforcement learning perspective**

*Cognition.* 2009; **113**:262-280

[12.](#body-ref-bib32 "View in article")

Christoff, K. ∙ Keramatian, K. ∙ Gordon, A.M....

**Prefrontal organization of cognitive control according to levels of abstraction**

*Brain Res.* 2009; **1286**:94-105

[13.](#body-ref-bib35 "View in article")

Christoph, G.R. ∙ Leonzio, R.J. ∙ Wilcox, K.S.

**Stimulation of the lateral habenula inhibits dopamine-containing neurons in the substantia nigra and ventral tegmental area of the rat**

*J. Neurosci.* 1986; **6**:613-619

[PubMed](https://pubmed.ncbi.nlm.nih.gov/3958786/)

[Google Scholar](https://scholar.google.com/scholar_lookup?pmid=3958786)

[14.](#body-ref-bib34 "View in article")

Cooper, R. ∙ Shallice, T.

**Contention scheduling and the control of routine activities**

*Cogn. Neuropsychol.* 2000; **17**:297-338

[15.](#body-ref-bib43 "View in article")

Cooper, J.C. ∙ Knutson, B.

**Valence and salience contribute to nucleus accumbens activation**

*Neuroimage.* 2008; **39**:538-547

[16.](#body-ref-bib16 "View in article")

Corbetta, M. ∙ Patel, G. ∙ Shulman, G.L.

**The reorienting system of the human brain: from environment to theory of mind**

*Neuron.* 2008; **58**:306-324

[17.](#body-ref-bib17 "View in article")

Cox, R.W.

**AFNI: software for analysis and visualization of functional magnetic resonance neuroimages**

*Comput. Biomed. Res.* 1996; **29**:162-173

[18.](#body-ref-bib19 "View in article")

Daw, N.D. ∙ Frank, M.J.

**Reinforcement learning and higher level cognition: introduction to special issue**

*Cognition.* 2009; **113**:259-261

[19.](#body-ref-bib19 "View in article")

Dayan, P. ∙ Niv, Y.

**Reinforcement learning: the good, the bad and the ugly**

*Curr. Opin. Neurobiol.* 2008; **18**:185-196

[20.](#body-ref-bib54-1 "View in article")

Dietterich, T.G.

**The MAXQ method for hierarchical reinforcement learning**

Shavlik, J.W. (Editor)

**Proceedings of the Fifteenth International Conference on Machine Learning**

Morgan Kaufman, San Francisco, 1998; 118-126

[Google Scholar](https://scholar.google.com/scholar?q=T.G.DietterichThe+MAXQ+method+for+hierarchical+reinforcement+learningJ.W.ShavlikProceedings+of+the+Fifteenth+International+Conference+on+Machine+Learning1998Morgan+KaufmanSan+Francisco118126)

[21.](#body-ref-bib32 "View in article")

Grafman, J.

**The human prefrontal cortex has evolved to represent components of structured event complexes**

Grafman, J. (Editor)

**Handbook of Neuropsychology**

Elsevier, Amsterdam, 2002

[Google Scholar](https://scholar.google.com/scholar?q=J.GrafmanThe+human+prefrontal+cortex+has+evolved+to+represent+components+of+structured+event+complexesJ.GrafmanHandbook+of+Neuropsychology2002ElsevierAmsterdam)

[22.](#body-ref-bib23 "View in article")

Grent-'t-Jong, T. ∙ Woldorff, M.G.

**Timing and sequence of brain activity in top-down control of visual-spatial attention**

*PLoS Biol.* 2007; **5**:e12

[23.](#body-ref-bib58-1 "View in article")

Hare, T.A. ∙ O'Doherty, J. ∙ Camerer, C.F....

**Dissociating the role of the orbitofrontal cortex and the striatum in the computation of goal values and prediction errors**

*J. Neurosci.* 2008; **28**:5623-5630

[24.](#body-ref-bib25 "View in article")

Haruno, M. ∙ Kawato, M.

**Heterarchical reinforcement-learning model for integration of multiple cortico-striatal loops: fMRI examination in stimulus-action-reward association learning**

*Neural Netw.* 2006; **19**:1242-1254

[28.](#body-ref-bib57 "View in article")

Holroyd, C.B. ∙ Nieuwenhuis, S. ∙ Yeung, N....

**Dorsal anterior cingulate cortex shows fMRI response to internal and external error signals**

*Nat. Neurosci.* 2004; **7**:497-498

[29.](#body-ref-bib30 "View in article")

Jocham, G. ∙ Ullsperger, M.

**Neuropharmacology of performance monitoring**

*Neurosci. Biobehav. Rev.* 2009; **33**:48-60

[30.](#body-ref-bib31 "View in article")

Knutson, B. ∙ Taylor, J. ∙ Kaufman, M....

**Distributed neural representation of expected value**

*J. Neurosci.* 2005; **25**:4806-4812

[31.](#body-ref-bib32 "View in article")

Kouneiher, F. ∙ Charron, S. ∙ Koechlin, E.

**Motivation and cognitive control in the human prefrontal cortex**

*Nat. Neurosci.* 2009; **12**:939-945

[32.](#body-ref-bib60 "View in article")

Krigolson, O.E. ∙ Holroyd, C.B.

**Evidence for hierarchical error processing in the human brain**

*Neuroscience.* 2006; **137**:13-17

[33.](#body-ref-bib34 "View in article")

Lashley, K.S.

**The problem of serial order in behavior**

Jeffress, L.A. (Editor)

**Cerebral Mechanisms in Behavior: The Hixon Symposium**

Wiley, New York, 1951; 112-136

[Google Scholar](https://scholar.google.com/scholar?q=K.S.LashleyThe+problem+of+serial+order+in+behaviorL.A.JeffressCerebral+Mechanisms+in+Behavior%3A+The+Hixon+Symposium1951WileyNew+York112136)

[34.](#body-ref-bib35 "View in article")

Matsumoto, M. ∙ Hikosaka, O.

**Lateral habenula as a source of negative reward signals in dopamine neurons**

*Nature.* 2007; **447**:1111-1115

[36.](#body-ref-bib49-1 "View in article")

Montague, P.R. ∙ Dayan, P. ∙ Sejnowski, T.J.

**A framework for mesencephalic dopamine systems based on predictive Hebbian learning**

*J. Neurosci.* 1996; **16**:1936-1947

[Crossref](https://doi.org/10.1523/JNEUROSCI.16-05-01936.1996)

[PubMed](https://pubmed.ncbi.nlm.nih.gov/8774460/)

[Google Scholar](https://scholar.google.com/scholar_lookup?doi=10.1523%2FJNEUROSCI.16-05-01936.1996&pmid=8774460)

[37.](#body-ref-bib38 "View in article")

Nicola, S.M. ∙ Surmeier, J. ∙ Malenka, R.C.

**Dopaminergic modulation of neuronal excitability in the striatum and nucleus accumbens**

*Annu. Rev. Neurosci.* 2000; **23**:185-215

[38.](#body-ref-bib61-1 "View in article")

Nieuwenhuis, S. ∙ Slagter, H.A. ∙ von Geusau, N.J.A....

**Knowing good from bad: differential activation of human cortical areas by positive and negative outcomes**

*Eur. J. Neurosci.* 2005; **21**:3161-3168

[39.](#body-ref-bib40-1 "View in article")

Niv, Y.

**Reinforcement learning in the brain**

*J. Math. Psychol.* 2009; **53**:139-154

[40.](#body-ref-bib41 "View in article")

O'Doherty, J.P. ∙ Hampton, A. ∙ Kim, H.

**Model-based fMRI and its application to reward learning and decision making**

*Ann. N Y Acad. Sci.* 2007; **1104**:35-53

[43.](#body-ref-bib54-1 "View in article")

Parr, R. ∙ Russell, S.

**Reinforcement learning with hierarchies of machines**

*Adv. Neural Inf. Process Sys.* 1998; **10**:1043-1049

[Google Scholar](https://scholar.google.com/scholar?q=R.ParrS.RussellReinforcement+learning+with+hierarchies+of+machinesAdv.+Neural+Inf.+Process+Sys.10199810431049)

[44.](#body-ref-bib45 "View in article")

Phan, K.L. ∙ Wager, T.D. ∙ Taylor, S.F....

**Functional neuroimaging studies of human emotions**

*CNS Spectr.* 2004; **9**:258-266

[45.](#body-ref-bib46 "View in article")

Poldrack, R.A.

**Can cognitive processes be inferred from neuroimaging data?**

*Trends Cogn. Sci. (Regul. Ed.).* 2006; **10**:59-63

[46.](#body-ref-bib47 "View in article")

Reynolds, J.R. ∙ O'Reilly, R.C.

**Developing PFC representations using reinforcement learning**

*Cognition.* 2009; **113**:281-292

[48.](#body-ref-bib49-1 "View in article")

Schultz, W. ∙ Dayan, P. ∙ Montague, P.R.

**A neural substrate of prediction and reward**

*Science.* 1997; **275**:1593-1599

[49.](#body-ref-bib50 "View in article")

Seymour, B. ∙ O'Doherty, J.P. ∙ Dayan, P....

**Temporal difference models describe higher-order learning in humans**

*Nature.* 2004; **429**:664-667

[50.](#body-ref-bib51 "View in article")

Seymour, B. ∙ Daw, N. ∙ Dayan, P....

**Differential encoding of losses and gains in the human striatum**

*J. Neurosci.* 2007; **27**:4826-4831

[51.](#body-ref-bib52 "View in article")

Singh, S. ∙ Barto, A.G. ∙ Chentanez, N.

**Intrinsically motivated reinforcement learning**

Saul, L.K. ∙ Weiss, Y. ∙ Bottou, L. (Editors)

**Advances in Neural Information Processing Systems 17: Proceedings of the 2004 Conference**

MIT Press, Cambridge, MA, 2005; 1281-1288

[Google Scholar](https://scholar.google.com/scholar?q=S.SinghA.G.BartoN.ChentanezIntrinsically+motivated+reinforcement+learningL.K.SaulY.WeissL.BottouAdvances+in+Neural+Information+Processing+Systems+17%3A+Proceedings+of+the+2004+Conference2005MIT+PressCambridge%2C+MA12811288)

[52.](#body-ref-bib53-1 "View in article")

Sutton, R.S. ∙ Barto, A.G.

**Reinforcement Learning: An Introduction**

MIT Press, Cambridge, MA, 1998

[Google Scholar](https://scholar.google.com/scholar?q=R.S.SuttonA.G.BartoReinforcement+Learning%3A+An+Introduction1998MIT+PressCambridge%2C+MA)

[53.](#body-ref-bib54-1 "View in article")

Sutton, R.S. ∙ Precup, D. ∙ Singh, S.

**Between MDPs and semi-MDPs: a framework for temporal abstraction in reinforcement learning**

*Artif. Intell.* 1999; **112**:181-211

[54.](#body-ref-bib55 "View in article")

Talairach, J. ∙ Tournoux, P.

**Co-Planar Stereotaxic Atlas of the Human Brain**

Thieme Medical Publishers, Inc., New York, 1988

[Google Scholar](https://scholar.google.com/scholar?q=J.TalairachP.TournouxCo-Planar+Stereotaxic+Atlas+of+the+Human+Brain1988Thieme+Medical+Publishers%2C+Inc.New+York)

[55.](#body-ref-bib58-1 "View in article")

Ullsperger, M. ∙ von Cramon, D.Y.

**Error monitoring using external feedback: specific roles of the habenular complex, the reward system, and the cingulate motor area revealed by functional magnetic resonance imaging**

*J. Neurosci.* 2003; **23**:4308-4314

[PubMed](https://pubmed.ncbi.nlm.nih.gov/12764119/)

[Google Scholar](https://scholar.google.com/scholar_lookup?pmid=12764119)

[56.](#body-ref-bib57 "View in article")

van Veen, V. ∙ Holroyd, C.B. ∙ Cohen, J.D....

**Errors without conflict: implications for performance monitoring theories of anterior cingulate cortex**

*Brain Cogn.* 2004; **56**:267-276

[58.](#body-ref-bib59 "View in article")

Yamaguchi, S. ∙ Tsuchiya, H. ∙ Kobayashi, S.

**Electrophysiologic correlates of visuo-spatial attention shift**

*Electroencephalogr. Clin. Neurophysiol.* 1995; **94**:450-461

[60.](#body-ref-bib61-1 "View in article")

Yeung, N. ∙ Holroyd, C.B. ∙ Cohen, J.D.

**ERP correlates of feedback and reward processing in the presence and absence of response choice**

*Cereb. Cortex.* 2005; **15**:535-544