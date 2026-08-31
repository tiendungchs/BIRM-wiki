---
title: "A hierarchy of intrinsic timescales across primate cortex"
source: "https://www.nature.com/articles/nn.3862"
author:
  - "[[John D Murray]]"
  - "[[Alberto Bernacchia]]"
  - "[[David J Freedman]]"
  - "[[Ranulfo Romo]]"
  - "[[Jonathan D Wallis]]"
  - "[[Xinying Cai]]"
  - "[[Camillo Padoa-Schioppa]]"
  - "[[Tatiana Pasternak]]"
  - "[[Hyojung Seo]]"
  - "[[Daeyeol Lee]]"
  - "[[Xiao-Jing Wang]]"
published: 2014-11-10
created: 2026-08-31
description: "Primate cortex can be organized with specialization and hierarchical principles, but presently there is little evidence for how it is organized temporally. Across six separate datasets, the authors find a hierarchical ordering of intrinsic fluctuation of spiking activity, with timescales that increase from sensory to prefrontal areas. Specialization and hierarchy are organizing principles for primate cortex, yet there is little direct evidence for how cortical areas are specialized in the temporal domain. We measured timescales of intrinsic fluctuations in spiking activity across areas and found a hierarchical ordering, with sensory and prefrontal areas exhibiting shorter and longer timescales, respectively. On the basis of our findings, we suggest that intrinsic timescales reflect areal specialization for task-relevant computations over multiple temporal ranges."
tags:
  - "clippings"
---
## Abstract

Specialization and hierarchy are organizing principles for primate cortex, yet there is little direct evidence for how cortical areas are specialized in the temporal domain. We measured timescales of intrinsic fluctuations in spiking activity across areas and found a hierarchical ordering, with sensory and prefrontal areas exhibiting shorter and longer timescales, respectively. On the basis of our findings, we suggest that intrinsic timescales reflect areal specialization for task-relevant computations over multiple temporal ranges.

## Main

Hierarchy provides a parsimonious description of various functional differences across cortical areas. For instance, the sizes of spatial receptive fields increase along the visual hierarchy [^1], and a posterior-anterior hierarchy exists for cognitive abstraction within prefrontal cortex [^2]. In the temporal domain, higher cortical areas can activate selectively for stimuli that are coherent over longer periods of time [^3] [^4]. It remains an open question whether temporal specialization arises from a cortical area's intrinsic dynamical properties, that is, related to dynamics that exist even in the absence of direct stimulus processing. We hypothesized that differential dynamics would be manifested in the timescales of fluctuations in single-neuron spiking activity.

Variable neuronal activity is ubiquitous across the cortex [^5] [^6], yet it has been unclear what the timescales underlying this variability are or whether they differ across areas. Neuronal activity fluctuates over a wide range of timescales, with potential contributions from distinct underlying mechanisms. For example, the timescales of correlated fluctuations of activity within a local microcircuit are likely longer than those of single-neuron burstiness and refractoriness [^7] but shorter than those of drifts in arousal. In typical electrophysiological recordings from behaving animals, spike trains from a single neuron are recorded over many trials of a task. Using single-neuron spike trains, we sought to characterize underlying fluctuations in activity that are not locked to trial onset. To measure the timescales of these fluctuations, we used the spike-count autocorrelation for pairs of time bins separated by a time lag. The spike-count autocorrelation is calculated as the correlation coefficient between the number of spikes in each time bin across all trials (Online [Methods](https://www.nature.com/articles/nn.3862#Sec2)). As the time lag increases, the autocorrelation decays according to the fluctuation timescales [^8] ([Supplementary Note](https://www.nature.com/articles/nn.3862#MOESM44)).

We measured intrinsic timescales using single-neuron spike trains in data sets from 6 research groups, recorded in a total of 26 monkeys, that include 7 cortical areas ([Fig. 1a](https://www.nature.com/articles/nn.3862#Fig1)). Five cortical areas are constituents of the visual-prefrontal hierarchy, including sensory, parietal association and prefrontal cortex: medial-temporal (MT) area in visual cortex, lateral intraparietal (LIP) area in parietal association cortex, lateral prefrontal cortex (LPFC), orbitofrontal cortex (OFC) and anterior cingulate cortex (ACC). To test for generality of results outside the visual system, we also examined two somatosensory areas: primary somatosensory cortex (S1) and secondary somatosensory cortex (S2). These areas span multiple levels of the anatomical hierarchy defined by the laminar patterns of long-range projections among cortical areas [^9] [^10] ([Fig. 1b](https://www.nature.com/articles/nn.3862#Fig1)). For each data set, monkeys were engaged in cognitive tasks. We restricted our analysis to one epoch of the task, the foreperiod that begins each trial. During the foreperiod, the monkey was in a controlled, attentive state awaiting stimulus onset (fixation of eye position for visual tasks, lever hold for the somatosensory task). This restriction minimizes stimulus-related confounds and allows application of the same analyses across areas and data sets. This definition of intrinsic timescale does not refer to single-neuron physiology or imply that the timescale does not change with stimulus conditions.

![Figure 1: Spike-count autocorrelation reveals a hierarchical ordering of intrinsic timescales.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fnn.3862/MediaObjects/41593_2014_Article_BFnn3862_Fig1_HTML.jpg?as=webp)

Figure 1: Spike-count autocorrelation reveals a hierarchical ordering of intrinsic timescales.

The decay of autocorrelation with increasing time lag could be well fit by an exponential decay with an offset ([Fig. 1c](https://www.nature.com/articles/nn.3862#Fig1)). This fit was obtained at the population level rather than the single-neuron level (Online [Methods](https://www.nature.com/articles/nn.3862#Sec2) and [Supplementary Figs. 1](https://www.nature.com/articles/nn.3862#Fig3) and [2](https://www.nature.com/articles/nn.3862#Fig4)), enabling us to extract an intrinsic timescale as a population-level statistic for each area in a data set. Within each data set, the intrinsic timescales differed across areas, in the range of 50–350 ms. Over all data sets, we found a consistent ordering of the intrinsic timescales across cortical areas (*P* < 10 <sup>−5</sup>, *r* <sub>s</sub> = 0.89, Spearman's rank correlation) ([Fig. 1d](https://www.nature.com/articles/nn.3862#Fig1)). Sensory cortex showed shorter timescales, parietal association cortex showed intermediate timescales and prefrontal cortex showed longer timescales, with medial prefrontal area ACC consistently showing the longest timescale in our data sets. Both visual and somatosensory systems had hierarchical ordering. Differences in intrinsic timescales could not be explained by differences in mean firing rates across areas ([Supplementary Fig. 3](https://www.nature.com/articles/nn.3862#Fig5)). Notably, this hierarchy of intrinsic timescales aligns with the anatomical hierarchy defined by long-range projections among cortical areas [^9] [^10] (*P* = 0.002, *r* <sub>s</sub> = 0.97, Spearman's rank correlation), although our physiologically defined hierarchy differs from the anatomical hierarchy for OFC. The correspondence between physiological, anatomical and functional hierarchies suggests the functional importance of these timescales in large-scale cortical coordination.

What is the potential relevance of intrinsic timescales to functions that may operate over longer timescales? We examined whether the intrinsic timescale (in the range of 50–350 ms) may be correlated with the capacity for neurons in an area to sustain signals over long behavioral timescales (for example, 5–10 s). Neuronal fluctuations include contributions that operate over a wide range of timescales. Long timescales contribute an effective offset to the autocorrelation ([Fig. 2a](https://www.nature.com/articles/nn.3862#Fig2) and [Supplementary Note](https://www.nature.com/articles/nn.3862#MOESM44)). The offset can therefore reflect the strength of fluctuations at long timescales that cannot be resolved with a limited duration of the foreperiod. We found that the autocorrelation offset positively correlates with the intrinsic timescale (*P* = 0.004, *t* <sub>9</sub> = 3.4, *t* -test) ([Fig. 2b](https://www.nature.com/articles/nn.3862#Fig2)). We also found that the offset reflects the strength of trial-to-trial correlations (*P* = 0.002, *t* <sub>9</sub> = 3.9, *t* -test), indicating that a portion of long-timescale variability persists across trials ([Supplementary Fig. 4](https://www.nature.com/articles/nn.3862#Fig6)). These results imply that hierarchy may exist across multiple temporal ranges.

![Figure 2: Links between intrinsic timescales and longer functional timescales.](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fnn.3862/MediaObjects/41593_2014_Article_BFnn3862_Fig2_HTML.jpg?as=webp)

Figure 2: Links between intrinsic timescales and longer functional timescales.

Of relevance to function, fluctuations at long timescales can include contributions from long-lasting memory traces of stimuli or task variables such as reward. In the Lee data set, which includes areas LIP, LPFC and ACC, we previously measured at the single-neuron level the temporal modulation of neuronal activity by reward events during a decision-making task [^11] ([Supplementary Fig. 5](https://www.nature.com/articles/nn.3862#Fig7)). We refer to the time constant characterizing the decay of a neuron's modulation by reward as its reward timescale. Consistent with this link between intrinsic timescale and long functional timescales, the order of areas according to median reward timescale aligns with the order according to intrinsic timescale ([Fig. 2c](https://www.nature.com/articles/nn.3862#Fig2)). It is noteworthy that the median reward timescale is an order of magnitude longer than the intrinsic timescale. These results support the interpretation that intrinsic timescales may reflect areal specialization for task-relevant computations over long timescales.

In summary, our physiological analyses show that cortical areas follow a hierarchical ordering in their timescales of intrinsic fluctuations. One interpretation of their functional relevance is that these timescales set the duration over which a neural circuit integrates its inputs [^12]. In this interpretation, shorter timescales in sensory areas enable them to rapidly detect or faithfully track dynamic stimuli [^13] [^14]. By contrast, prefrontal areas can utilize longer timescales to integrate information and improve the signal-to-noise ratio in short-term memory or decision-making computations [^12] [^15]. There is known hierarchical specialization across areas at the functional level in sensory and cognitive processing [^1] [^2] [^3].

The present study leaves as an open question what underlying mechanisms contribute to this hierarchy of intrinsic timescales. Computational models of recurrent neural circuits have demonstrated multiple potential mechanisms [^12]. A longer intrinsic timescale in the circuit could reflect longer timescales of cellular or synaptic dynamics [^12]. Consistent with this mechanism, there are interareal differences in the dynamical properties of recurrent excitatory synapses, including differential composition of glutamate receptors [^16], expression of short-term synaptic plasticity [^17] and level of neuromodulation [^18]. Interareal differences in cellular physiology can also be driven by factors such as neuronal morphology [^19]. A longer timescale in the circuit could also arise from stronger synaptic connections mediating recurrent excitation, which slows intrinsic dynamics by partially canceling leak [^12]. There are increases across the cortical hierarchy in the number and density of excitatory synapses onto pyramidal cells [^20], which may reflect increased recurrent strength across areas. Modeling studies have further shown that strong recurrent connections can endow a cortical circuit with the capability to exhibit persistent activity in working memory and slow accumulation of information in decision making [^15]. A hierarchy of intrinsic timescales may link neurophysiological properties to functional specialization.

## Methods

### Data sets.

All experimental methods met standards of the US National Institutes of Health and were approved by the relevant institutional animal care and use committees at University of Rochester, Harvard Medical School, University of Chicago, University of California, Berkeley, Washington University School of Medicine and Universidad Nacional Autónoma de México. Experimental details for the data sets have been reported previously [^21] [^22] [^23] [^24] [^25] [^26] [^27] [^28] [^29] [^30] [^31] [^32] [^33] [^34] [^35] [^36] [^37] [^38]. We used single-neuron spike train data, recorded in macaque monkeys, from the foreperiod of various cognitive tasks. Although their precise ages were not known, all monkeys used in these experiments were adults. For the Romo data set, the foreperiod entailed holding a lever by the free hand; for all other data sets, the foreperiod entailed fixation of eye position to a central target. Criteria for selecting data sets were that they comprised multiple cortical areas and that the task foreperiod had durations of at least 500 ms with minimal task-related stimulus during the foreperiod (for visual tasks, only a fixation point on the screen). Only completed trials were analyzed. Cells and trials were filtered for further analysis by two criteria. To allow computation of spike-count autocorrelation, we required that each time bin have a nonzero mean firing rate [^39]. To minimize spurious autocorrelation caused by very slow drift of firing rates across the recording session, we selected the longest block of trials in which the total foreperiod spike count was statistically stationary across trials [^40].

The Pasternak data set consists of neurons recorded in MT and LPFC [^21] [^22] [^23] [^24] [^25]. Monkeys compared two motion stimuli separated by a brief delay. The foreperiod duration was either 500 ms or 1,000 ms. For single neurons recorded over multiple tasks, each task-neuron pair was treated as a separate single neuron to control for task-dependent changes in foreperiod firing. Single-neuron counts were 485 from MT (2 male monkeys) and 427 from LPFC (4 male monkeys). The Freedman data set contains neurons from MT, LIP and LPFC [^26] [^27]. Monkeys performed a motion-delayed match-to-category task. The foreperiod duration was 500 ms. Single-neuron counts were 59 from MT (2 male monkeys), 222 from LIP (4 male monkeys) and 458 from LPFC (2 male monkeys). The Lee data set consists of neurons recorded in LIP, LPFC and ACC [^28] [^29] [^30]. Monkeys performed a competitive decision-making task called matching pennies. The foreperiod duration was 500 ms. Single-neuron counts were 192 from LIP (1 female, 2 male monkeys), 293 from LPFC (1 female, 4 male monkeys) and 146 from ACC (2 male monkeys). The Wallis data set contains neurons from LPFC, OFC and ACC [^31] [^32] [^33]. Monkeys performed tasks involving value-based choice. The foreperiod duration was 1,000 ms. Single-neuron counts were 946 from LPFC (6 male monkeys), 481 from OFC (7 male monkeys) and 841 from ACC (6 male monkeys). The Padoa-Schioppa data set contains neurons from LPFC, OFC and ACC [^34] [^35] [^36] [^37]. Monkeys performed tasks involving value-based choice. The foreperiod duration was 1,500 ms. Single-neuron counts were 1,024 from LPFC (1 female, 1 male monkeys), 1,768 from OFC (1 female, 1 male monkeys) and 987 from ACC (1 female, 1 male monkeys). The Romo data set contains cells from S1 and S2 (ref. [^38]). Two monkeys performed a vibrotactile delayed discrimination task. The foreperiod duration was variable, with a minimum of 1,400 ms. Single-neuron counts were 711 from S1 (2 male monkeys) and 928 from S2 (2 male monkeys).

### Analysis.

Our primary analysis was the temporal autocorrelation of spike counts, which we computed in the following way for single neurons. We divided the foreperiod into separate, successive time bins of duration Δ. We set Δ = 50 ms; results were similar for changes of ± 20%. For two time bins, indexed by their onset times *i* Δ and *j* Δ, we computed the across-trial correlation between spike counts *N* in those time bins using the Pearson's correlation coefficient *R*:

![](https://media.springernature.com/lw500/springer-static/image/art%3A10.1038%2Fnn.3862/MediaObjects/41593_2014_Article_BFnn3862_Equ1_HTML.gif)

in which covariance (Cov) and variance (Var) are computed across trials for those time bins and is the mean spike count for a particular bin. Notably, spike-count autocorrelation corrects for nonstationarity in the mean firing rate during the foreperiod (for example, ramping) because covariance and variance subtract the mean spike count for each time bin.

Based on our theoretical calculations for doubly stochastic processes ([Supplementary Note](https://www.nature.com/articles/nn.3862#MOESM44)), the decay of autocorrelation was fit to the population of neurons within an area by an exponential decay with an offset as a function of the time lag *k* Δ between time bins (*k* = | *i* − *j* |):

![](https://media.springernature.com/lw500/springer-static/image/art%3A10.1038%2Fnn.3862/MediaObjects/41593_2014_Article_BFnn3862_Equ2_HTML.gif)

in which *τ* is the intrinsic timescale and *B* is the offset that reflects the contribution of timescales much longer than our observation window. Some areas in the data sets showed signs of refractoriness or negative adaptation at short time lags ([Fig. 1c](https://www.nature.com/articles/nn.3862#Fig1)), which would not be captured by equation (2). To accommodate this feature of the autocorrelation data, fitting started at the time lag with maximum decrease of the mean autocorrelation. We fit equation (2) to the full autocorrelation data for all neurons and times; fits were therefore performed at the population level rather than single-neuron level, yielding a set of fit parameters for an area in a data set. For the visual presentation in [Figure 1c](https://www.nature.com/articles/nn.3862#Fig1), autocorrelation was averaged across neurons and times. Autocorrelation averaged across neurons but not time is presented in [Supplementary Figure 1](https://www.nature.com/articles/nn.3862#Fig3), and autocorrelation averaged across time but not neurons is presented in [Supplementary Figure 2](https://www.nature.com/articles/nn.3862#Fig4).

Equation (2) was fit to the autocorrelation data using nonlinear least-squares fitting via the Levenberg-Marquardt algorithm (through the SciPy function optimize.curve\_fit). The parameter covariance matrix generated by the Levenberg-Marquardt fitting procedure describes the dependence between parameters in fitting an individual area in a data set. A positive (negative) off-diagonal term for two parameters indicates that increasing one parameter will increase (decrease) the other to optimize the fit. For most areas (11 of 16), this term had a negative sign, indicating that the positive correlation between *τ* and *B* shown in [Figure 2b](https://www.nature.com/articles/nn.3862#Fig2) was not a consequence of the fitting procedure. Standard error for fit parameters was computed by the delete-one jackknife procedure.

To test for hypothesized relationships between two measures, we used a linear regression model:

![](https://media.springernature.com/lw500/springer-static/image/art%3A10.1038%2Fnn.3862/MediaObjects/41593_2014_Article_BFnn3862_Equ3_HTML.gif)

in which *δ* <sub><i>d,k</i></sub> is a dummy variable, which is 1 if data set *d* matches *k* and 0 otherwise. This model assumes that all data sets have a linear dependence of *y* on *x* across all data sets (*m*) and allows data sets to have different constant terms (*b* <sub><i>k</i></sub>). The statistical significance of a regressor, in particular the dependence term *m*, was assessed by a *t* -test. This regression analysis was applied to test three dependences: (i) *x* is intrinsic timescale, *y* is autocorrelation offset ([Fig. 2b](https://www.nature.com/articles/nn.3862#Fig2)); (ii) *x* is mean firing rate, *y* is intrinsic timescale ([Supplementary Fig. 3](https://www.nature.com/articles/nn.3862#Fig5)); and (iii) *x* is trial-to-trial correlation, *y* is autocorrelation offset ([Supplementary Fig. 4](https://www.nature.com/articles/nn.3862#Fig6)). We assessed normality of residuals for the regression analyses; in all cases, the magnitude of skew was <0.4. Statistical significance (defined by *P* < 0.05), or lack thereof, for each test was preserved if a single constant term (*b* <sub><i>k</i></sub> = *b*) was used for all data sets.

To test for correlation between the timescale hierarchy and anatomical hierarchy, we calculated the Spearman's rank correlation between the ordering of areas by mean timescale and the discrete anatomical ordering shown in [Figure 1b](https://www.nature.com/articles/nn.3862#Fig1). The rank correlation coefficient was the same for the visual-prefrontal system (MT, LIP, LPFC, OFC, ACC) and for the somatosensory-prefrontal hierarchy (S1, S2, LPFC, OFC, ACC). Unless otherwise stated, reported *P* values are one sided as we tested a priori hypotheses of positive correlations between variables. Custom Python code was used for all analyses; analysis code is available from the authors upon request.

A [Supplementary Methods Checklist](https://www.nature.com/articles/nn.3862#MOESM45) is available.

## References

## Acknowledgements

We thank R. Chaudhuri and H.F. Song for discussions, and W. Chaisangmongkon and A. Ponce-Alvarez for assistance with data sets. Funding was provided by US Office of Naval Research grant N00014-13-1-0297 and US National Institutes of Health (NIH) grant R01MH062349 (X.-J.W.); NIH grant R01DA029330 (D.L.); NIH grants R01EY11749 and T32EY07125 (T.P.); NIH grant R01DA032758 and Whitehall Foundation grant 2010-12-13 (C.P.-S.); NIH grants R01DA19028 and P01NS040813 (J.D.W.); grants from Dirección General de Asuntos del Personal Académico–Universidad Nacional Autónoma de México and Consejo Nacional de Ciencia y Tecnología México (R.R.); and NIH grant R01EY019041 (D.J.F.).

## Ethics declarations

### Competing interests

The authors declare no competing financial interests.

## Integrated supplementary information

### Supplementary Figure 1 Spike-count autocorrelations in time.

Normalized autocorrelation matrices are shown for each area in a dataset. The matrix shows the mean correlation of the spike count in each time bin with the spike count in every other time bin, averaged across neurons. These show that the autocorrelation is roughly stationary across time during the foreperiod.

### Supplementary Figure 2 Single neurons exhibit heterogeneous autocorrelations.

Light grey traces show the spike-count autocorrelation as function of time lag for single neurons, averaged across time points. Circles mark the population mean at each time lag, and the curve shows the exponential fit to the population data. The observation of single-neuron heterogeneity reinforces the interpretation of intrinsic timescale as a characteristic at the population level rather than at the single-neuron level.

### Supplementary Figure 3 Differences in mean firing rates across areas do not account for hierarchy of intrinsic timescales.

Mean firing rates varied substantially across datasets and across areas within datasets. There was no significant dependence of intrinsic timescale on mean firing rate (*P* = 0.51, *t* (9) = −0.69, two-tailed *t* -test, regression slope *m* = −5.5 ± 7.9 ms/Hz; *P* = 0.16, *r* <sub><i>s</i></sub> = −0.34, Spearman’s rank correlation, two-tailed). Error bars mark s.e.

### Supplementary Figure 4 Autocorrelation offset reflects trial-to-trial correlation.

Trial-to-trial correlation was calculated as the Pearson correlation coefficient between the foreperiod spike count in each trial and the spike count in the next trial. We hypothesized that autocorrelation offset would positively correlate with trial-to-trial correlation, and found a significant positive correlation between them. This indicates that the autocorrelation offset includes contributions from variability at timescales are comparable to or longer than the trial duration. Colored lines show trends for individual datasets. The arrow shows the slope of dependence from a regression analysis (slope *m* = 1.3 ± 0.3). Error bars mark s.e.

### Supplementary Figure 5 Hierarchical ordering of areas by timescale of reward memory.

In the Lee dataset, we previously measured timescales of the decay of memory traces for past rewards in single-neuron firing rates, while monkeys performed a competitive decision-making task. (**a**) The cumulative distribution of reward timescales in LIP (n = 160), LPFC (n = 243), and ACC (n = 134). For neurons fit with the sum of two reward timescales, we used the harmonic mean of the two timescales. (**b**) Median reward timescale for the three areas. Error bars mark s.e.

## Supplementary information

### Supplementary Text and Figures (download PDF )

Supplementary Figures 1–5 and Supplementary Note (PDF 7450 kb)

### Supplementary Methods Checklist (download PDF )

(PDF 382 kb)

## Rights and permissions

[^1]: Lennie, P. *Perception* **27**, 889–935 (1998).

[Article](https://doi.org/10.1068%2Fp270889) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaK1M3is1WjtQ%3D%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=&journal=Perception&doi=10.1068%2Fp270889&volume=27&pages=889-935&publication_year=1998&author=Lennie%2CP)

[^2]: Badre, D. & D'Esposito, M. *Nat. Rev. Neurosci.* **10**, 659–669 (2009).

[Article](https://doi.org/10.1038%2Fnrn2667) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD1MXpsleqsrw%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=&journal=Nat.%20Rev.%20Neurosci.&doi=10.1038%2Fnrn2667&volume=10&pages=659-669&publication_year=2009&author=Badre%2CD&author=D%27Esposito%2CM)

[^3]: Hasson, U., Yang, E., Vallines, I., Heeger, D.J. & Rubin, N. *J. Neurosci.* **28**, 2539–2550 (2008).

[Article](https://doi.org/10.1523%2FJNEUROSCI.5487-07.2008) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD1cXjt1Ggsrk%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=&journal=J.%20Neurosci.&doi=10.1523%2FJNEUROSCI.5487-07.2008&volume=28&pages=2539-2550&publication_year=2008&author=Hasson%2CU&author=Yang%2CE&author=Vallines%2CI&author=Heeger%2CDJ&author=Rubin%2CN)

[^4]: Honey, C.J. et al. *Neuron* **76**, 423–434 (2012).

[Article](https://doi.org/10.1016%2Fj.neuron.2012.08.011) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC38XhsFClt7jN) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=&journal=Neuron&doi=10.1016%2Fj.neuron.2012.08.011&volume=76&pages=423-434&publication_year=2012&author=Honey%2CCJ)

[^5]: Churchland, M.M. et al. *Nat. Neurosci.* **13**, 369–378 (2010).

[Article](https://doi.org/10.1038%2Fnn.2501) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC3cXit1SmtLg%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=&journal=Nat.%20Neurosci.&doi=10.1038%2Fnn.2501&volume=13&pages=369-378&publication_year=2010&author=Churchland%2CMM)

[^6]: Goris, R.L.T., Movshon, J.A. & Simoncelli, E.P. *Nat. Neurosci.* **17**, 858–865 (2014).

[Article](https://doi.org/10.1038%2Fnn.3711) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2cXmvFSjt7c%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=&journal=Nat.%20Neurosci.&doi=10.1038%2Fnn.3711&volume=17&pages=858-865&publication_year=2014&author=Goris%2CRLT&author=Movshon%2CJA&author=Simoncelli%2CEP)

[^7]: Maimon, G. & Assad, J.A. *Neuron* **62**, 426–440 (2009).

[Article](https://doi.org/10.1016%2Fj.neuron.2009.03.021) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD1MXmsFWjtLg%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=&journal=Neuron&doi=10.1016%2Fj.neuron.2009.03.021&volume=62&pages=426-440&publication_year=2009&author=Maimon%2CG&author=Assad%2CJA)

[^8]: Churchland, A.K. et al. *Neuron* **69**, 818–831 (2011).

[Article](https://doi.org/10.1016%2Fj.neuron.2010.12.037) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC3MXit1Knuro%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=&journal=Neuron&doi=10.1016%2Fj.neuron.2010.12.037&volume=69&pages=818-831&publication_year=2011&author=Churchland%2CAK)

[^9]: Felleman, D.J. & Van Essen, D.C. *Cereb. Cortex* **1**, 1–47 (1991).

[Article](https://doi.org/10.1093%2Fcercor%2F1.1.1) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaK38zltlGmsg%3D%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=&journal=Cereb.%20Cortex&doi=10.1093%2Fcercor%2F1.1.1&volume=1&pages=1-47&publication_year=1991&author=Felleman%2CDJ&author=Van%20Essen%2CDC)

[^10]: Barbas, H. & Rempel-Clower, N. *Cereb. Cortex* **7**, 635–646 (1997).

[Article](https://doi.org/10.1093%2Fcercor%2F7.7.635) [CAS](https://www.nature.com/articles/cas-redirect/1:STN:280:DyaK1c%2FjvVymtA%3D%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=&journal=Cereb.%20Cortex&doi=10.1093%2Fcercor%2F7.7.635&volume=7&pages=635-646&publication_year=1997&author=Barbas%2CH&author=Rempel-Clower%2CN)

[^11]: Bernacchia, A., Seo, H., Lee, D. & Wang, X.-J. *Nat. Neurosci.* **14**, 366–372 (2011).

[Article](https://doi.org/10.1038%2Fnn.2752) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC3MXhvVCqur8%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=&journal=Nat.%20Neurosci.&doi=10.1038%2Fnn.2752&volume=14&pages=366-372&publication_year=2011&author=Bernacchia%2CA&author=Seo%2CH&author=Lee%2CD&author=Wang%2CX-J)

[^12]: Goldman, M.S., Compte, A. & Wang, X.-J. in *Encyclopedia of Neuroscience* (ed. Squire, L.R.) 165–178 (Academic Press, Oxford, 2008).

[^13]: Buracas, G.T., Zador, A.M., DeWeese, M.R. & Albright, T.D. *Neuron* **20**, 959–969 (1998).

[Article](https://doi.org/10.1016%2FS0896-6273%2800%2980477-8) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DyaK1cXjs1SgtL0%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=&journal=Neuron&doi=10.1016%2FS0896-6273%2800%2980477-8&volume=20&pages=959-969&publication_year=1998&author=Buracas%2CGT&author=Zador%2CAM&author=DeWeese%2CMR&author=Albright%2CTD)

[^14]: Salinas, E., Hernandez, A., Zainos, A. & Romo, R. *J. Neurosci.* **20**, 5503–5515 (2000).

[Article](https://doi.org/10.1523%2FJNEUROSCI.20-14-05503.2000) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD3cXlt1Whsr4%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=&journal=J.%20Neurosci.&doi=10.1523%2FJNEUROSCI.20-14-05503.2000&volume=20&pages=5503-5515&publication_year=2000&author=Salinas%2CE&author=Hernandez%2CA&author=Zainos%2CA&author=Romo%2CR)

[^15]: Wang, X.-J. *Neuron* **36**, 955–968 (2002).

[Article](https://doi.org/10.1016%2FS0896-6273%2802%2901092-9) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD38XpslWlsL8%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=&journal=Neuron&doi=10.1016%2FS0896-6273%2802%2901092-9&volume=36&pages=955-968&publication_year=2002&author=Wang%2CX-J)

[^16]: Wang, H., Stradtman, G.G., Wang, X.-J. & Gao, W.-J. *Proc. Natl. Acad. Sci. USA* **105**, 16791–16796 (2008).

[Article](https://doi.org/10.1073%2Fpnas.0804318105) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD1cXhtlertrfK) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=&journal=Proc.%20Natl.%20Acad.%20Sci.%20USA&doi=10.1073%2Fpnas.0804318105&volume=105&pages=16791-16796&publication_year=2008&author=Wang%2CH&author=Stradtman%2CGG&author=Wang%2CX-J&author=Gao%2CW-J)

[^17]: Wang, Y. et al. *Nat. Neurosci.* **9**, 534–542 (2006).

[Article](https://doi.org/10.1038%2Fnn1670) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD28XivFSiurw%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=&journal=Nat.%20Neurosci.&doi=10.1038%2Fnn1670&volume=9&pages=534-542&publication_year=2006&author=Wang%2CY)

[^18]: Fuster, J. *The Prefrontal Cortex* (Academic Press, New York, 2008).

[^19]: Amatrudo, J.M. et al. *J. Neurosci.* **32**, 13644–13660 (2012).

[Article](https://doi.org/10.1523%2FJNEUROSCI.2581-12.2012) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC38XhsVyqsrrP) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=&journal=J.%20Neurosci.&doi=10.1523%2FJNEUROSCI.2581-12.2012&volume=32&pages=13644-13660&publication_year=2012&author=Amatrudo%2CJM)

[^20]: Elston, G.N. *Cereb. Cortex* **13**, 1124–1138 (2003).

[Article](https://doi.org/10.1093%2Fcercor%2Fbhg093) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=&journal=Cereb.%20Cortex&doi=10.1093%2Fcercor%2Fbhg093&volume=13&pages=1124-1138&publication_year=2003&author=Elston%2CGN)

[^21]: Bisley, J.W., Zaksas, D., Droll, J.A. & Pasternak, T. *J. Neurophysiol.* **91**, 286–300 (2004).

[Article](https://doi.org/10.1152%2Fjn.00870.2003) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=&journal=J.%20Neurophysiol.&doi=10.1152%2Fjn.00870.2003&volume=91&pages=286-300&publication_year=2004&author=Bisley%2CJW&author=Zaksas%2CD&author=Droll%2CJA&author=Pasternak%2CT)

[^22]: Zaksas, D. & Pasternak, T. *J. Neurophysiol.* **94**, 4156–4167 (2005).

[Article](https://doi.org/10.1152%2Fjn.00505.2005) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=&journal=J.%20Neurophysiol.&doi=10.1152%2Fjn.00505.2005&volume=94&pages=4156-4167&publication_year=2005&author=Zaksas%2CD&author=Pasternak%2CT)

[^23]: Zaksas, D. & Pasternak, T. *J. Neurosci.* **26**, 11726–11742 (2006).

[Article](https://doi.org/10.1523%2FJNEUROSCI.3420-06.2006) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD28Xht1Glu7jM) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=&journal=J.%20Neurosci.&doi=10.1523%2FJNEUROSCI.3420-06.2006&volume=26&pages=11726-11742&publication_year=2006&author=Zaksas%2CD&author=Pasternak%2CT)

[^24]: Hussar, C.R. & Pasternak, T. *Neuron* **64**, 730–743 (2009).

[Article](https://doi.org/10.1016%2Fj.neuron.2009.11.018) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC3cXks1ClsL0%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=&journal=Neuron&doi=10.1016%2Fj.neuron.2009.11.018&volume=64&pages=730-743&publication_year=2009&author=Hussar%2CCR&author=Pasternak%2CT)

[^25]: Hussar, C.R. & Pasternak, T. *J. Neurosci.* **32**, 2747–2761 (2012).

[Article](https://doi.org/10.1523%2FJNEUROSCI.5135-11.2012) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC38Xjt1Crs7w%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=&journal=J.%20Neurosci.&doi=10.1523%2FJNEUROSCI.5135-11.2012&volume=32&pages=2747-2761&publication_year=2012&author=Hussar%2CCR&author=Pasternak%2CT)

[^26]: Freedman, D.J. & Assad, J.A. *Nature* **443**, 85–88 (2006).

[Article](https://doi.org/10.1038%2Fnature05078) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD28XptFCmtb0%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=&journal=Nature&doi=10.1038%2Fnature05078&volume=443&pages=85-88&publication_year=2006&author=Freedman%2CDJ&author=Assad%2CJA)

[^27]: Swaminathan, S.K. & Freedman, D.J. *Nat. Neurosci.* **15**, 315–320 (2012).

[Article](https://doi.org/10.1038%2Fnn.3016) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC38Xnt1Kktg%3D%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=&journal=Nat.%20Neurosci.&doi=10.1038%2Fnn.3016&volume=15&pages=315-320&publication_year=2012&author=Swaminathan%2CSK&author=Freedman%2CDJ)

[^28]: Seo, H., Barraclough, D.J. & Lee, D. *J. Neurosci.* **29**, 7278–7289 (2009).

[Article](https://doi.org/10.1523%2FJNEUROSCI.1479-09.2009) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD1MXntFGkur4%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=&journal=J.%20Neurosci.&doi=10.1523%2FJNEUROSCI.1479-09.2009&volume=29&pages=7278-7289&publication_year=2009&author=Seo%2CH&author=Barraclough%2CDJ&author=Lee%2CD)

[^29]: Seo, H., Barraclough, D.J. & Lee, D. *Cereb. Cortex* **17** (suppl. 1), i110–i117 (2007).

[Article](https://doi.org/10.1093%2Fcercor%2Fbhm064) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=&journal=Cereb.%20Cortex&doi=10.1093%2Fcercor%2Fbhm064&volume=17&issue=suppl.%201&pages=i110-i117&publication_year=2007&author=Seo%2CH&author=Barraclough%2CDJ&author=Lee%2CD)

[^30]: Seo, H. & Lee, D. *J. Neurosci.* **27**, 8366–8377 (2007).

[Article](https://doi.org/10.1523%2FJNEUROSCI.2369-07.2007) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD2sXpsVGnt74%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=&journal=J.%20Neurosci.&doi=10.1523%2FJNEUROSCI.2369-07.2007&volume=27&pages=8366-8377&publication_year=2007&author=Seo%2CH&author=Lee%2CD)

[^31]: Kennerley, S.W., Dahmubed, A.F., Lara, A.H. & Wallis, J.D. *J. Cogn. Neurosci.* **21**, 1162–1178 (2009).

[Article](https://doi.org/10.1162%2Fjocn.2009.21100) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=&journal=J.%20Cogn.%20Neurosci.&doi=10.1162%2Fjocn.2009.21100&volume=21&pages=1162-1178&publication_year=2009&author=Kennerley%2CSW&author=Dahmubed%2CAF&author=Lara%2CAH&author=Wallis%2CJD)

[^32]: Kennerley, S.W. & Wallis, J.D. *J. Neurosci.* **29**, 3259–3270 (2009).

[Article](https://doi.org/10.1523%2FJNEUROSCI.5353-08.2009) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD1MXjsVamtL8%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=&journal=J.%20Neurosci.&doi=10.1523%2FJNEUROSCI.5353-08.2009&volume=29&pages=3259-3270&publication_year=2009&author=Kennerley%2CSW&author=Wallis%2CJD)

[^33]: Hosokawa, T., Kennerley, S.W., Sloan, J. & Wallis, J.D. *J. Neurosci.* **33**, 17385–17397 (2013).

[Article](https://doi.org/10.1523%2FJNEUROSCI.2221-13.2013) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC3sXhslCjtrfP) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=&journal=J.%20Neurosci.&doi=10.1523%2FJNEUROSCI.2221-13.2013&volume=33&pages=17385-17397&publication_year=2013&author=Hosokawa%2CT&author=Kennerley%2CSW&author=Sloan%2CJ&author=Wallis%2CJD)

[^34]: Padoa-Schioppa, C. & Assad, J.A. *Nature* **441**, 223–226 (2006).

[Article](https://doi.org/10.1038%2Fnature04676) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD28XksVGnsrk%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=&journal=Nature&doi=10.1038%2Fnature04676&volume=441&pages=223-226&publication_year=2006&author=Padoa-Schioppa%2CC&author=Assad%2CJA)

[^35]: Padoa-Schioppa, C. & Assad, J.A. *Nat. Neurosci.* **11**, 95–102 (2008).

[Article](https://doi.org/10.1038%2Fnn2020) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BD1cXhtFCltg%3D%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=&journal=Nat.%20Neurosci.&doi=10.1038%2Fnn2020&volume=11&pages=95-102&publication_year=2008&author=Padoa-Schioppa%2CC&author=Assad%2CJA)

[^36]: Cai, X. & Padoa-Schioppa, C. *J. Neurosci.* **32**, 3791–3808 (2012).

[Article](https://doi.org/10.1523%2FJNEUROSCI.3864-11.2012) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC38XktlOlt7w%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=&journal=J.%20Neurosci.&doi=10.1523%2FJNEUROSCI.3864-11.2012&volume=32&pages=3791-3808&publication_year=2012&author=Cai%2CX&author=Padoa-Schioppa%2CC)

[^37]: Cai, X. & Padoa-Schioppa, C. *Neuron* **81**, 1140–1151 (2014).

[Article](https://doi.org/10.1016%2Fj.neuron.2014.01.008) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC2cXisFCjsbo%3D) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=&journal=Neuron&doi=10.1016%2Fj.neuron.2014.01.008&volume=81&pages=1140-1151&publication_year=2014&author=Cai%2CX&author=Padoa-Schioppa%2CC)

[^38]: Ponce-Alvarez, A., Nácher, V., Luna, R., Riehle, A. & Romo, R. *J. Neurosci.* **32**, 11956–11969 (2012).

[Article](https://doi.org/10.1523%2FJNEUROSCI.6176-11.2012) [CAS](https://www.nature.com/articles/cas-redirect/1:CAS:528:DC%2BC38XhtlaltL7E) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=&journal=J.%20Neurosci.&doi=10.1523%2FJNEUROSCI.6176-11.2012&volume=32&pages=11956-11969&publication_year=2012&author=Ponce-Alvarez%2CA&author=N%C3%A1cher%2CV&author=Luna%2CR&author=Riehle%2CA&author=Romo%2CR)

[^39]: Ogawa, T. & Komatsu, H. *J. Neurophysiol.* **103**, 2433–2445 (2010).

[Article](https://doi.org/10.1152%2Fjn.01066.2009) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=&journal=J.%20Neurophysiol.&doi=10.1152%2Fjn.01066.2009&volume=103&pages=2433-2445&publication_year=2010&author=Ogawa%2CT&author=Komatsu%2CH)

[^40]: Nishida, S. et al. *Cereb. Cortex* **24**, 1671–1685 (2014).

[Article](https://doi.org/10.1093%2Fcercor%2Fbht031) [Google Scholar](http://scholar.google.com/scholar_lookup?&title=&journal=Cereb.%20Cortex&doi=10.1093%2Fcercor%2Fbht031&volume=24&pages=1671-1685&publication_year=2014&author=Nishida%2CS)