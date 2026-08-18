Published as: _Nature_ . 2015 May 14; 521(7551): 186–191. 

## **Neural dynamics for landmark orientation and angular path integration** 

## **Johannes D. Seelig** and **Vivek Jayaraman** 

Janelia Research Campus, Howard Hughes Medical Institute, 19700 Helix Drive, Ashburn, VA 20147, USA. 

## **Summary** 

Many animals navigate using a combination of visual landmarks and path integration. In mammalian brains, head direction cells integrate these two streams of information by representing an animal's heading relative to landmarks, yet maintaining their directional tuning in darkness based on self-motion cues. Here we use two-photon calcium imaging in head-fixed flies walking on a ball in a virtual reality arena to demonstrate that landmark-based orientation and angular path integration are combined in the population responses of neurons whose dendrites tile the ellipsoid body — a toroidal structure in the center of the fly brain. The population encodes the fly's azimuth relative to its environment, tracking visual landmarks when available and relying on self-motion cues in darkness. When both visual and self-motion cues are absent, a representation of the animal's orientation is maintained in this network through persistent activity — a potential substrate for short-term memory. Several features of the population dynamics of these neurons and their circular anatomical arrangement are suggestive of ring attractors — network structures proposed to support the function of navigational brain circuits. 

Visual landmarks can provide animals with a reliable indicator of their whereabouts[1] . In the absence of such cues, many animals track their position relative to a reference point by continuously monitoring their own motion, a process called path integration[2] . Estimates of position based purely on self-motion cues, however, can accumulate error over time. Successful navigation then, requires animals to flexibly combine these distinct sources of information[1] . In mammalian brains this process of integration is evident in head direction (HD) cells[3] — neurons sensitive to an animal's heading relative to visual cues in its surroundings that maintain their representation of heading in total darkness using selfmotion cues[4] . With their smaller brains and identifiable neurons, insects offer tractable systems to examine such navigational neural computations[5] . Indeed, many insects (e.g., desert ants and honeybees[6,7] ) are known to navigate using landmarks and path integration[1] . Experiments in a variety of insects indicate the involvement of the central complex (CX) — a brain region conserved across insects — in such behavior. In the fruit fly, behavioral 

Users may view, print, copy, and download text and data-mine the content in such documents, for the purposes of academic research, subject always to the full Conditions of use:http://www.nature.com/authors/editorial_policies/license.html#terms Correspondence and requests for material should be addressed to V.J. (vivek@janelia.hhmi.org).. AUTHOR CONTRIBUTIONS 

Both authors designed the study, performed data analysis and wrote the manuscript. J.S. carried out all experiments. The authors declare no competing financial interests. 

Seelig and Jayaraman 

Page 2 

genetics experiments have suggested that the CX is required for several components of navigation, including memory for visual landmarks[8] , patterns[9] and places[10] , and directional motor control[11] . Electrophysiological recordings in immobilized locusts[12] and butterflies[13 ] have revealed a map-like representation for polarized light E-vector orientations that may enable sun-compass navigation[14] . Extracellular recordings from CX neurons in tethered walking cockroaches have shown encodings of turning direction[15] and of wide-field optic flow[16] — a potential cue for self-motion. However, previous studies of visual responses in the CX were conducted under conditions in which insects passively viewed visual stimuli. We sought to uncover integrative neural processes relevant to navigation in the CX by allowing a tethered fly to control and respond to visual stimuli[17] while simultaneously recording its neural activity and behavior. 

We used two-photon imaging with the genetically encoded calcium indicator GCaMP6f[18] to monitor neural responses in the CX while a head-fixed fly walked on an air-supported ball within a light-emitting-diode (LED) arena[19,20] (Fig. 1a, b; see Methods). In previous experiments, we identified a subset of neurons with projections to the CX — and, specifically, to rings of the ellipsoid body (EB) — that show strong tuning to localized visual features[20] including vertical stripes, a class of stimuli that also induce innate fixational responses in flies[21,22] . To probe how such visual information might be utilized within the CX we now focused on a class of columnar neurons of the CX, each of which sends dendrites to a specific wedge of the EB (Fig. 1c, d). These neurons are abbreviated here as EBw.s neurons (see Methods)[13,23-27] . We monitored the dendritic responses of the entire EBw.s population in the EB (Fig. 1e) during walking, both under closed-loop virtual reality (VR) conditions in which the rotation of visual patterns was driven by the fly's turning movement on the ball and in darkness (Extended Data Fig. 1). 

## **Compass-like representation of landmark orientation** 

When flies were exposed to a single vertical stripe stimulus (Extended Data Fig. 1a), we observed a sector of activity, or bump, in the EB that rotated concurrently with the stripe as the fly turned on the ball (Fig. 1f, j, k; Supplementary Video 1, Extended Data Fig. 2a-c). The spatial extent of the visual arena (270°) was mapped to the full angular extent (360°) of the EB (Extended Data Fig. 2d, see Methods). A population vector average (PVA) of EBw.s activity (Fig. 1g, h) sufficed to reliably decode the stripe's azimuthal position relative to the fly, or, equivalently, the fly's virtual orientation relative to the stripe (Fig. 1g-i, l, see Methods), with a fly-specific angular offset (Fig. 1m). Offsets occasionally changed between trials (for example, Fly 2 and Fly 10 in Fig. 1m and Extended Data Fig. 2e), but seldom within a trial (Extended Data Fig. 2f). Such differences in the locking of the EBw.s activity bump to visual cue position suggest that EBw.s population activity cannot be a static retinotopic representation of the animal's surroundings[20] . 

The single-stripe EBw.s responses (Fig. 1) could result from a tuning to visual features[20] , or from a more abstracted representation of the fly's orientation with respect to its environment. To distinguish between these possibilities, we asked how EBw.s population activity changes in a more complex visual scene with multiple features (Fig. 2a; Extended Data Fig. 1b). In this environment, a visual feature map would produce an EBw.s activity pattern of increased 

_Nature_ . Author manuscript; available in PMC 2016 January 07. 

Seelig and Jayaraman 

Page 3 

width and complexity. Instead, consistent with EBw.s activity representing the fly's orientation, we observed a single bump of similar width (Fig. 2a-c, Supplementary Video 2, Extended Data Fig. 3a-c), the spatial extent of the arena was once again mapped onto the EB (Extended Data Fig. 3d), and the PVA estimate of the fly's azimuth remained accurate (Fig. 2d-g, Extended Data Fig. 3e, f). 

All the cues used thus far provided the fly with landmarks that uniquely define its orientation in the environment. An activity bump could thus represent either the fly's angular position within the visual scene or its orientation relative to a specific landmark within it. We next placed the fly in a visual scene with two identical vertical stripes positioned to map exactly opposite each other on the EB ring (Extended Data Fig. 1c, Extended Data Fig. 4a). Consistent with EBw.s activity representing orientation by flexibly locking to a single landmark, the resulting EBw.s representation again involved a single bump (Extended Data Fig. 4b-f; Supplementary Video 3), with the same mapping of the visual scene onto the EB as before (Extended Data Fig. 4g). PVA estimates were well correlated with the orientation of the fly in the scene (Extended Data Fig. 4h-m), regardless of which stripe was directly in front of the fly (Supplementary Video 3). In a few cases, however, we observed that EBw.s activity transitioned from one offset to another relative to the visual cues (Extended Data Fig. 5a-c, Supplementary Video 4), potentially reflecting the ambiguity inherent in determining landmark-guided orientation in an environment with multiple indistinguishable visual landmarks. Taken together, these data are consistent with a function for the EBw.s population as an internal compass that adaptively represents the fly's orientation relative to visual landmarks. 

## **Dominant influence of visual landmarks over self-motion cues** 

Our closed-loop VR experiments directly couple the fly's turning movements to the rotation of the visual scene. To disambiguate the contributions of visual landmark position and selfmotion cues to the EBw.s representation of the fly's orientation, we performed two sets of manipulations with a single stripe pattern. First, we instantaneously shifted cue position during a period of closed-loop walking (Fig. 3a; also see Methods). If EBw.s responses arise from self-motion cues rather than landmark orientation, the abrupt shift in landmark azimuthal position should not by itself induce matching shifts in EBw.s activity. Instead, we observed that EBw.s. population activity moved to match the cue shift, preserving the initial offset between the EBw.s bump and visual cue azimuth (Extended Data Fig. 6a, b, Fig. 3b; Supplementary Video 5). Thus, local landmarks rather than self-motion cues appear to determine the position of the EBw.s bump. Interestingly, the bump did not always move instantaneously. In response to the first landmark shift in Extended Data Fig. 6b (see also Supplementary Video 5), for example, the bump rapidly tracks the shifted visual landmark, but the second abrupt displacement of the landmark elicits a much slower response. 

As a second manipulation, we varied the closed-loop gain that coupled the fly's rotational movements on the ball to the movement of the visual cue (Fig. 3c). If EBw.s activity is determined by the fly's orientation relative to the landmark, the bump should move in lockstep with landmark rotation rather than with the fly's turning movements. Indeed, in almost all cases, activity in the EBw.s population faithfully followed the visual cue (Fig. 3d- 

_Nature_ . Author manuscript; available in PMC 2016 January 07. 

Seelig and Jayaraman 

Page 4 

g, Extended Data Fig. 6c). Consistent with this, the relationship between walking rotation and EBw.s bump movement was strongly dependent on closed-loop gain (Fig. 3h), whereas the relationship between visual cue movement and rotation of the EBw.s bump scaled only slightly with gain (Fig. 3i). Nevertheless, we occasionally observed examples of EBw.s activity being more influenced by the animal's rotation than cue movement, particularly in situations of low gain (Extended Data Fig. 6d-f). Overall, as has been observed in the mammalian HD system[4] , the EBw.s compass predominantly relies on visual landmarks. 

## **Angular path integration in the absence of visual cues** 

A key feature of mammalian HD cells is their ability to retain their compass-like function in the absence of visual information using path integration[4] . We searched for evidence of angular path integration — tracking of orientation by self-motion cues — by imaging EBw.s population responses of flies walking in complete darkness without prior exposure to a closed-loop visual scene on the ball (Fig. 4a). As in all visually stimulated conditions, EBw.s activity in the dark settled into a single bump, and then tracked the fly's turning movements on the ball (Fig. 4b-d; Supplementary Video 6-8, Extended Data Fig. 7a-e, h). However, the PVA estimate of orientation based on the activity in the EBw.s population often degraded over time (Fig. 4d, Extended Data Fig. 7b, f, h, i), with EBw.s activity not tracking very small or slow angular movements (Extended Data Fig. 7g, j, and Extended Data Fig. 8). Although the fly's potentially impaired ability to track its rotation when tethered on a ball may contribute to the measured drift, it likely also reflects a common limitation of path integrators in the absence of corrective feedback[4,28] . We also noted some fly-to-fly variability in the effective (measured) gain between ball rotation and EBw.s bump movement in these experiments (Extended Data Fig. 7f, i). However, prior exposure to specific closed-loop gains in visual surroundings only had a negligible influence on the effective gain between ball rotation and EBw.s activity in darkness (Extended Data Fig. 9). Overall, these results show that the EBw.s population performs angular path integration in darkness by relying exclusively on self-motion cues, albeit with a gradual accumulation of error in its orientation estimate. 

## **Persistent activity maintains representation of orientation** 

Having established that both visual landmark information and self-motion cues contribute to EBw.s population activity, we next asked how the system responds to the absence of both sources of orientation information. Specifically, we examined EBw.s activity during epochs when the fly stopped walking while in the dark. In almost all such cases, the EBw.s population maintained a representation of the fly's orientation (Fig. 4e-i; Extended Data Fig. 10a-f; Supplementary Video 7 and 8). This representation persisted even when EBw.s calcium activity was low, as evident in the fact that renewed bouts of movement caused a bump to reappear in exactly the wedges expected based on the last orientation of the fly (Fig. 4h and Extended Data Fig. 10a, c, e, Supplementary Videos 7 and 8). This representation of orientation sometimes persisted for more than 30 seconds (Fig. 4i, Extended Data Fig. 10b, d, f). Such persistence was also a feature of EBw.s dynamics when the fly remained standing in a visual environment (Extended Data Fig 10g-r), extending beyond durations that elicit adaptation in early visual circuits[29] . Thus, even in the absence 

_Nature_ . Author manuscript; available in PMC 2016 January 07. 

Page 5 

Seelig and Jayaraman 

self-motion cues, EBw.s population activity maintains a stable representation of the fly's orientation in its environment with or without visual landmarks. 

## **Discussion** 

The ability of animals to combine continuous path integration with potentially intermittent landmark-based orienting enables navigation in a wide diversity of environmental conditions[1,6] . We studied the activity dynamics of a complete population of identified CX neurons in tethered walking flies and found that this network uses information from both landmark-based and angular path integration systems to create a compass-like representation of the animal's orientation in the environment. 

Previous studies have described static visual maps in the CX[12,13,20] . Such maps may allow navigating insects to maintain a sun-compass-based heading direction[12,13,27,30] . Here we found that EBw.s neurons track the fly's orientation relative to visual landmarks in a variety of different visual environments (Fig. 1, Fig. 2), suggesting that the CX dynamically adapts to estimate the fly's orientation within its visual surroundings (Extended Data Fig. 2d, Extended Data Fig. 3d, Extended Data Fig. 4g). Subsets of ring neurons likely bring information about spatially localized visual features[20] to specific rings of the ellipsoid body[31] . It is unknown how this information is converted into an abstract and flexible representation of the animal's orientation relative to landmarks[32] , but EBw.s responses in a symmetric environment with two indistinguishable cues (Extended Data Fig. 4 and Extended Data Fig. 5) hint at an underlying winner-take-all process for landmark selection[33] . Combining landmark orientation with information about the animal's movement effectively creates an internal reference frame for the animal in its surroundings. Many of the CX's proposed functions in directed locomotion[11,15] , visual place learning[10] , and actionselection[34] may rely on this internal reference. Although the EBw.s population tracks the fly's rotational movements in darkness, we do not yet know where and how translational motion — an important component of a complete navigational system — is incorporated. Additionally, while the calcium sensor we chose for our imaging experiments has the temporal resolution necessary to capture EBw.s representations of the fly's angular rotation (see Methods), it lacks the precision necessary for us to determine whether EBw.s activity represents the fly's predicted future orientation or its estimate of current orientation. 

Our observation that EBw.s activity was maintained in the absence of self-motion suggests that internal dynamics play a significant role in shaping neural activity in the fly brain, much as they do in the brains of larger animals. Persistent activity in the CX can maintain compass information when the fly is standing in darkness for 30 seconds — two orders of magnitude longer than might be explained by calcium sensor decay kinetics[18] . Persistent activity has been shown to support maintenance of eye position in the goldfish[35] and has been proposed to underlie working memory in mammals[36] . In the CX, this activity may allow the fly to retain a short-term orientation memory even when landmarks are temporarily out of sight[8] . Consistent with this notion, the EBw.s activity bump largely remained tethered to the position of one landmark even in the presence of another identical landmark in front of the fly (Extended Data Fig. 4i). The bump also did not always shift instantaneously following an 

_Nature_ . Author manuscript; available in PMC 2016 January 07. 

Page 6 

Seelig and Jayaraman 

abrupt displacement of visual landmarks, as if temporarily retaining the original orientation reference before locking on to its new position (Extended Data Fig. 6b). 

Several models have been proposed to explain how visual landmark and self-motion cues are integrated at the level of HD cell activity in mammals[37] . Most rely on circuits organized as ring attractors: neurons are schematized as being arranged in a circle based on their preferred directions[38] , with connection strengths that depend on their angular separation[37] . With initial sensory input, such a circuit can generate and sustain a localized activity bump. The bump's position on the circle corresponds to the animal's heading which is then updated by directional drive from self-motion signaling neurons. Direct experimental evidence in support of these models has been difficult to obtain in mammals due to the distributed nature of the underlying circuits. Although the functional connectivity between EBw.s neurons is not yet known, we have observed several of the expected features of ring attractor models[37,39,40] in the dynamics of this population of CX neurons: organization of activity into a localized bump, movement of the bump to neighboring wedges based on self-motion, drift in bump location in darkness, persistent activity, and both abrupt jumps and gradual transitions of the activity bump when triggered by strong visual input. Cell-intrinsic mechanisms could also underlie some of these features, including, for example, persistent activity[35,41,42] . The genetic tools available in _Drosophila_ to target and manipulate the activity of identified cell types should allow different models for visually guided orientation and angular path integration to be discriminated at the level of synaptic, cellular and network mechanism. 

## **METHODS** 

## **Fly stocks** 

All calcium imaging experiments were performed with 8-11 day old female _UASGCaMP6f;R60D05-GAL4_ flies. Flies were randomly picked from their housing vials for all experiments. 

## **Nomenclature** 

EBw.s neurons are referred to variously as eb-pb-vbo[25] , EIP[26] and EBw.s-PBg.b-gall.b[24 ] neurons in the fly literature. They may be homologous to CL1a neurons in the locust[27] and butterfly[13] . 

## **Fly preparation for imaging during walking** 

The fly was anesthetized on ice and transferred to a cold plate at 4°C. The fly's proboscis was pressed onto its head and immobilized with wax. To maximize the fly's field of view we used a two-piece pyramidal stainless steel shim holder[19] similar to those previously used for tethered flying fly experiments[20,43] . The fly was glued to a pin and positioned in the holder using a micromanipulator and fixed in the holder with UV gel as previously described[19,20] . The fly body axis was angled at 31° ± 5° (measured for 5 flies) with respect to the tracking system to orient the EB optimally with respect to the microscope's focal plane. To stop brain movement due to the pulsation of muscle M16, we cut the muscle — or the nerves innervating the muscle — with dissection needles if necessary. The fly holder (including the 

_Nature_ . Author manuscript; available in PMC 2016 January 07. 

Seelig and Jayaraman 

Page 7 

micromanipulator) was then transferred to the two-photon microscope and secured using magnetic mounts. As previously described[19,20] , the fly was positioned on an air-supported ball with a three-axis micromanipulator and the walking velocity of the fly was monitored using a camera system. For all experiments described in the main figures we used a 6-mmdiameter, 40-mg ball[19] . For the experiments in the dark described in Extended Data Fig. 7hj, we used a 10-mm-diameter, 175-mg ball. All balls were made of polyurethane foam. 

For experiments with visual cues, we removed parts of the antennae (funiculus and arista) to reduce the fly's tendency to touch the holder. 

For experiments in which flies walked in the dark we additionally coated the eyes of a subset of flies with black paint (Premiere Acrylic Colors, Mars Black). For the 6-mm-ball experiments, Flies 4-11 had coated eyes, while Flies 2-13 had coated eyes for the 10-mmball experiments. The number of trials per fly was as follows (Fly (number of trials)). 6-mm ball: 1(15), 2(8), 3(8), 4(8), 5(11), 6(10), 7(8), 8(10), 9(17), 10(10), 11(11). 10-mm ball: 1(7), 2(3), 3(8), 4(12), 5(10), 6(8), 7(6), 8(5), 9(3), 10(14), 11(8), 12(6), 13(11). All trials across all conditions lasted 140s. 

## **Two-photon calcium imaging** 

Calcium imaging was performed using a custom-built two-photon microscope controlled with ScanImage 4.2[44] . We used an Olympus 40× objective (LUMPlanFl/IR, NA 0.8) and a GaAsP photomultiplier tube (H7422PA-40, Hamamatsu). A Chameleon Ultra II laser (Coherent, Santa Clara, CA) tuned to 920 nm was used as the excitation source with the power adjusted to below 20 mW at the sample. We used the same saline as in previous studies[20] but adjusted the calcium concentration to 2.5 mM. Focal planes were selected to optimize coverage of the part of the EB innervated by EBw.s neurons. We imaged from 5- plane volumes at a rate of 8.507 Hz with an equal spacing of between 4 μm to 6 μm between individual focal planes. 

The calcium signals we measured may reflect synaptic input, action potential output or some combination of both. We chose GCaMP6f[18] for our experiments because it offers the temporal resolution necessary to capture EBw.s representation of the fly's angular rotation. Based on _in vivo_ measurements of responses to 20 Hz spiking at the _Drosophila_ larval neuromuscular junction, GCaMP6f has a time-to-peak of ~141 ms (close to the 8.507 Hz frame rate of our imaging system) and a decay time of ~380 ms[18] . Assuming that one complete rotation of the fly is represented by activity moving through the 16 wedges of the EB, each wedge represents 22.5° of rotation. The maximum average rotational velocity reached by a fly in our experiments was ~ 35°/s (Extended Data Fig. 1), which would result in a bump of activity moving across a wedge no faster than ~640 ms on average. Thus, possible lags in the calcium signals introduced by the rise and decay times of GCaMP6f would not compromise the detection of these activity changes. Although we do not know the actual change in electrical activity associated with the calcium transients we see, the kinetics of GCaMP6f provide a considerable margin of error. 

_Nature_ . Author manuscript; available in PMC 2016 January 07. 

Seelig and Jayaraman 

Page 8 

## **Visual stimulation** 

**Visual arena—** Visual stimuli were presented on a cylindrical LED display[45] spanning 270° in azimuth and 120° in elevation, and tilted by 10° towards the fly. The display was covered with a color filter and a diffuser as previously described[19,20] . 

**Visual stimuli for closed-loop walking experiments—** We used three different visual stimuli: (i) a bright vertical stripe spanning 120° in elevation and 15° in azimuth, (ii) two bright stripes of the same dimensions separated by 135° (resulting in a pattern that was invariant to rotations by 135°), and (iii) a pattern containing several vertical and horizontal stripes (Extended Data Fig. 1a-c). The number of trials (in brackets) for each fly for each of these conditions was: (i) 1(7), 2(6), 3(9), 4(11), 5(15), 6(13), 7(3), 8(7), 9(7), 10(6), 11(5), 12(9), 13(9), 14(10), 15(6); (ii) 1(12), 2(8), 3(10), 4(3), 5(6), 6(8), 7(16); (iii) 1(6) (same as fly 1 in (ii)), 2(2) (same as fly 2 in (ii)), 3(5) (same as fly 4 in (ii)), 4(3), 5(7) (same as fly 5 in (ii)), 6(11), 7(4), 8(11), 9(12). 

In cue-shift experiments each trial consisted of two cue shifts by the same angular distance within each trial (either by 60° or 120°) after at least 50 s of closed-loop behavior. The first cue shift was counterclockwise from the current position and the next, 50 s later, clockwise by the same angular amount from the current position. Cue shift experiments were performed with a subset of the flies in (i). A 60° cue shift was used for flies 7(2), 11(3), 13(3), 15(2) and 120°cue shift for flies 7(2), 8(3), 9(1), 11(3), 13(3), 15(2). 

In experiments that tested the influence of prior exposure to visual stimuli in closed loop on the gain between walking rotation and PVA estimate in darkness (Extended Data Fig. 9), we exposed the flies to 65 s of closed-loop walking with either low gain (mean closed-loop gain = 0.47 ± 0.04, close to the fly's default gain on the ball without prior closed-loop walking experience) or higher gain (mean set gain = 0.9 ± 0.16) with a single stripe, after which the stripe disappeared and the trial continued for another 60 s in darkness. For these experiments, we only used flies that showed strong rotational movement with low drift — as assessed at the onset of the experiment — to increase the accuracy of the gain calculation. We only recorded a small number of trials per fly, because the fly usually rotated more at the onset of experiments and walked forward more towards the end, leading to increased drift. For a subset of flies, we also tested the intrinsic gain of the flies walking in darkness without prior exposure to the closed-loop stimulus. The number of trials for experiments in which we combined closed-loop walking and walking in darkness were (fly number (trials with disappearing stripe/trials in darkness before exposure to closed-loop condition)): 1(5/0), 2(4/1), 3(3/1), 4(5/0), 5(7/1), 6(3/2), 7(4/1), 8(6/2), 9(5/1), 10(4/1), 11(4/1), 12(3/2), 13(5/2), 14(5/1), 15(1/2), 16(5/2), 17(3/2), 18(6/2), 19(4/2), 20(4/2), 21(5/2), 22(4/2), 23(4/1), 24(2/2), 25(4/2), 26(3/2). 

Closed-loop gains to convert rotation on the ball to displacement of the stripe around the arena were close to 1 (“normal gain”), but were varied from 0.4 to 1.6 in experiments to explore the effect of gain change on EBw.s representation. Actual values of the gain were verified by fitting changes in ball displacement to changes in pattern displacement on the arena. All patterns were displaced directly from one edge of the 270° arena to the other behind the fly rather than having them progress virtually through the 90° of visual field not 

_Nature_ . Author manuscript; available in PMC 2016 January 07. 

Seelig and Jayaraman 

Page 9 

represented by the arena. This was done to prevent abrupt changes in light intensity and to keep the number of features in the fly's visual field constant. 

All experiments with visual stimulation were performed in closed loop[46] . The voltage position signal of the tracking system was read with a DAQ board and discretized in 20 ms intervals using custom LabVIEW software which was also used to update the position of the visual stimulus[45] . 

## **Data analysis** 

We used MATLAB (MathWorks, Inc., Natick, MA) and the Circular Statistics Toolbox[47 ] for data analysis. All errors and error bars shown are standard deviation (S.D.). 

**Calculation of fluorescence changes—** Each imaged volume (stack of five frames) was averaged for analysis — we refer to this average as a ‘frame’. Each frame was spatially filtered with a 2-pixel-wide Gaussian filter after which background fluorescence was subtracted. Calcium transients recorded from behaving flies were smoothed with a 3rd order Savitzky-Golay filter over 7 frames (822 ms) for comparisons with behavioral data. The baseline (F0) for calculating ΔF/F0 was computed by averaging over the 10% of lowestintensity frames in each trial. For display only, MIP fluorescence intensity images shown in Figs. 1e, f, 2a and 4e were filtered with a 20-pixel-wide, 10-pixel-S.D. Gaussian filter (the size of each image is 216 pixels by 216 pixels). 

**ROI selection—** ROIs corresponding to 16 wedges of the EB were selected manually in videos of ΔF/F by drawing an ellipse (with a central hole, as depicted in Fig. 1f, g) that surrounded the EB, and then equally subdividing the ellipse into 16 wedges each spanning 22.5°. The number of wedges was selected based on the well-characterized EB wedge and PB glomerular innervation patterns of EBw.s neurons labeled by the _R60D05-Gal4_ line[24] . Some EBw.s neurons are known to arborize only in half- or demi-wedges[24] . Thus, our ROI selection and population analysis strategy may underestimate the actual resolution of the EBw.s system. 

**Population vector average (PVA)—** The PVA was computed as the weighted average of EB wedge angles ranging from 0 to 360°, with average ΔF/F values for each wedge used as a weight. This PVA estimate was smoothed with a box-car filter over 3 frames (352 ms). We used brewermap (S. Cobeldick, MathWorks file exchange) with color schemes from ColorBrewer.org to generate color maps for all PVA plots except for PVA amplitude, which we display in grayscale. For display of PVA estimates of orientation or walking rotation, raw PVA was offset by the median difference (circular distance) between PVA and either the visual cue position (for closed-loop trials in the arena) or the walking rotation signal (for trials in the dark). We computed the offset using epochs of walking in the final 80% of a trial, a period during which PVA estimates were typically more stable. The offset adjustment was necessitated by the fact that there was no stereotyped relationship between cue positions and EBw.s signal across flies (Fig. 1m, Extended Data Fig. 2e, f, Fig. 2f, Extended Data Fig. 3e, f, Extended Data Fig. 4j, l, m). The magnitude of the offset in many animals (Fig. 1m, Extended Data Fig. 2e, f, Extended Data Fig. 3e, f, Extended Data Fig. 4j, l) greatly 

_Nature_ . Author manuscript; available in PMC 2016 January 07. 

Seelig and Jayaraman 

Page 10 

exceeded the slight variance in the angle at which the tethered fly's head was fixed relative to the LED arena. The offset also occasionally changed between trials for the same fly. We did not monitor the fly's walking between trials, leaving open the possibility that these differences in offset arose purely from rotational movements of the fly (in the absence of closed-loop visual feedback) before initiation of the next closed-loop trial. 

**Analysis of number and width of activity bumps—** All ROIs with calcium transients above a set threshold were included in an activity bump. Each contiguous set of ROIs above threshold defined an individual bump. We used two separate methods to set the threshold. In Method 1 (used for all the main figures), the threshold was defined as 1-S.D. above the mean of calcium transients across ROIs for each imaging frame. In Method 2 (see Extended Data Fig. 2, Extended Data Fig. 3, Extended Data Fig. 4, and Extended Data Fig. 7), the threshold was defined as the mean of calcium transients across ROIs over the entire trial. The width of a bump in each frame was, in all cases, defined as the full width at half maximum (with minimum in each frame subtracted). We used the Kolmogorov-Smirnov two-sample test for tests of the null hypothesis that bump widths for two different stimulus conditions are drawn from the same distribution. P-values for this test are shown in the relevant figure legends. 

**Offset between pattern position and PVA estimate—** The offset between the pattern position and the PVA estimate was calculated as the circular distance between the PVA and the leftmost pixel of the pattern in Extended Data Fig. 1a-c across the entire trial for Extended Data Fig. 2e, Extended Data Fig. 3e, and Extended Data Fig. 4l, and averaged over all trials for each fly in Figures 1m and 2f, and Extended Data Fig. 4j. The S.D. of the offset was calculated as the circular S.D.[47] of the offset signal in each trial, and averaged across all trials. The pattern position from 0° to 270° was mapped to 0° to 360°, as explained below. 

**Mapping of 270° visual arena onto 360° EB—** To compute the mapping of the visual pattern onto the EB we calculated the gain — slope of a linear fit — between the unwrapped (see below) pattern position and the unwrapped PVA estimate for those trials in which the pattern moved over at least half the display. Since EBw.s activity in response to cues on the 270° LED arena was uniformly mapped to 360° of the EB (Extended Data Fig. 2d, Extended Data Fig. 3d, Extended Data Fig. 4g), visual cue positions on the 270° arena were mapped linearly to an arena spanning 360° in all plots and analyses to facilitate comparisons of cue position with PVA estimates and walking rotation. 

**Walking behavior analysis—** Ball movement was recorded at a sampling rate of 4 kHz[19] . Ball displacement and stimulus position were downsampled to match the corresponding two-photon scan rate (8.507 Hz). Velocities in Extended Data Fig. 1 were calculated over 20 frames (2.35 s) and averaged over the entire trial. Walking traces were subdivided into walking and standing epochs — only epochs that lasted at least 20 frames were considered for such classification. We only labeled epochs as ‘standing’ if the fly was standing for at least 20 successive imaging frames (2.35 s). 

**Correlation analysis—** Pearson's correlation coefficients were computed between two entire “unwrapped” time series, which is the cumulative sum of all angular displacements. 

_Nature_ . Author manuscript; available in PMC 2016 January 07. 

Seelig and Jayaraman 

Page 11 

For display only, we “wrapped” the angular data into the –pi to pi range. Only trials in which the fly walked for more than 30% of the time were used in summary plots of correlations and gains. For Fig. 1, we can reject the null hypothesis that true single-trial correlations are 0 with p < 0.05 for all trials except for 1/12 trials of Fly 3, 1/15 trials of Fly 5 and 1/9 trials of Fly 13. For these trials, the correlations are 0.028, 0.053 and 0.024 respectively. For Fig. 2g (multiple features) and Extended Data Fig. 4k (two stripes), p- values for correlations for all trials of all flies are < 0.05. For Extended Data Fig. 7b (walking in darkness), p > 0.05 for the correlations for only the following trials: 1/8 trials of Fly 3, 1/8 trials of Fly 4, 1/9 trials of Fly 6, 1/10 for Fly 8, 1/7 for Fly 9, 1/10 for Fly 10. For these trials, correlations are 0.056, 0.037, −0.023, −0.054, 0.039, and −0.026 respectively. 

**Computation of gains—** Closed-loop gains that translated ball rotation into movements of visual patterns on the LED arena were set to fixed values for each trial. However, differences in IR lighting conditions affected the optical mouse sensor chip system's computation of ball rotation slightly[19] , resulting in small variations in effective closed-loop gains. To compute true gain values, the ball's rotation about the vertical axis was linearly fit against the pattern position. The slope of this line was considered the actual gain for the trial. 

The relationship between rotation of activity around the EB and either walking rotation or visual cue rotation on the arena was captured by a linear fit. The gain between EBw.s activity rotation and either behavior or stimulus was computed as the slope of this line. 

In all cases above, gains were computed across 200 frames (23.51 s) or over the entire walking epoch for data in Fig. 3h, i. Two-dimensional distributions of correlation values for flies walking in darkness were computed using a window of 200 frames sliding along the time series in steps of 25 frames (2.94 s). For Fig. 3h, i we only included walking epochs for which the visual cue moved over at least half of the display, and calculated gains over the entire walking bout. 

**Comparison of angular velocity with PVA-estimated velocity—** For Extended Data Fig. 8, we computed angular velocity and PVA-estimated angular velocity using a 20-frame window (2.35 s) and plotted the values against each other for all trials in darkness for each fly. Points were then colored based on the mean PVA amplitude during the 20-frame epoch. 

**Analysis of persistent activity—** To compare changes in PVA estimates during periods when the fly was not walking, we selected epochs of alternating walking-standing-walking bouts, with walking bouts each lasting at least 5 frames (588 ms) and non-walking bouts lasting at least 20 frames (2.35 s), well beyond the persistence of calcium signals attributable to the decay kinetics of the indicator. All values were averaged over 5 frames (588 ms) before or after the stop and restart of walking, respectively. 

**Analysis of responses to cue shifts—** Changes in the offset between the visual cue position (the leftmost pixels of the cue seen from the fly's perspective) and the PVA estimate were computed as the mean circular distance over 100 frames (11.76 s). We compared the 100-frame mean offset before the first cue jump to the offset before the second cue jump, 

_Nature_ . Author manuscript; available in PMC 2016 January 07. 

Seelig and Jayaraman 

Page 12 

and the offset before the second cue jump to the offset at the end of the trial. For comparison, we also computed the expected change in PVA-cue offset if the PVA were not to follow visual cue position, in which case the PVA-cue offset would change by the magnitude of the cue jump. 

## **Extended Data** 

## **Extended Data Figure 1. Visual stimuli, walking velocities and fraction of time walking across flies and conditions** 

**a,** Single stripe pattern. **b,** Pattern with multiple features. **c,** Pattern with two identical stripes positioned symmetrically on the 270° visual display. In all closed-loop experiments, visual stimuli wrapped around the 270° arena, going directly from 0° to 270° and vice versa. **d-g** , Walking performance during closed-loop walking with a single stripe: **d,** Forward velocity; **e,** Magnitude of sideslip velocity; **f,** Magnitude of rotational velocity; **g,** Fraction of time walking across all trials. **h-k,** Same as **d-g** for the pattern with multiple features. **l-o,** Same as **d-g** for pattern with two stripes. **p-s,** Same as **d-g** for walking in the dark on a 6 mm diameter ball. **t-w,** Same as **d-g** for walking in the dark on a 10 mm diameter ball. **x-aa,** same as **d-g** for experiments with trials that combined epochs of closed-loop walking with epochs of walking in darkness (Extended Data Fig. 9). 

_Nature_ . Author manuscript; available in PMC 2016 January 07. 

Seelig and Jayaraman 

Page 13 

**Extended Data Figure 2. Closed-loop walking in visual environment with single stripe pattern a,** Mean and S.D. of the number of activity bumps as measured by Method 2 (see Methods) during all trials of all flies shown in Fig. 1. **b,** Mean and S.D. of the number of successive calcium imaging frames (recorded at 8.507 Hz) with more than one bump, measured using Method 1 (see Methods), for all flies shown in Fig. 1. **c,** Same as **b** , but computed using Method 2. **d,** Histogram of slopes of the linear fit between PVA estimate and pattern position during walking epochs, i.e., the gain between unwrapped PVA estimate and unwrapped pattern position. The pattern was mapped from 0°-to-270° to 0°-to-360° for PVA calculations (see Methods). Thus, a slope of 1 corresponds to a visual pattern on the 270° arena that maps to the entire ring of the ellipsoid body. Only those walking epochs during which the pattern moved over at least half of the visual display were included so as to obtain an accurate estimate of the slope (mean slope = 0.92 ± 0.32, n = 172 walking epochs, see Methods). **e,** Mean and S.D. of angular offsets between PVA position and pattern position for each trial (140 s, see Methods) for all flies. **f,** Mean and S.D. of S.D. of angular offset between PVA position and pattern position. 

_Nature_ . Author manuscript; available in PMC 2016 January 07. 

Seelig and Jayaraman 

Page 14 

**Extended Data Figure 3. Closed-loop walking in visual environment with multiple features a,** Mean and S.D. of the number of activity bumps as measured by Method 2 (see Methods) during all trials of all flies shown in Fig. 2. **b,** Mean and S.D. of the number of successive calcium imaging frames with more than one bump, measured using Method 1 (see Methods), for all flies shown in Fig. 2. **c,** Same as **b** , but computed using Method 2. **d,** Same as Extended Data Fig. 2d for the pattern with multiple features (mean slope = 0.97 ± 0.43, n = 74 walking epochs). **e,** Mean and S.D. of angular offsets between PVA position and pattern position for each trial (140s) for all flies. **f,** Mean and S.D. of S.D. of angular offset between PVA position and pattern position. 

**Extended Data Figure 4. Single activity bump during closed-loop walking in visual environment with two stripes** 

**a,** Closed-loop experiment in visual environment with two identical and symmetrically placed stripes. **b,** Mean and S.D. of number of bumps in EBw.s population activity across trials for each of 7 flies. **c,** Mean and S.D. of FWHM of bump. Distribution of bump widths 

_Nature_ . Author manuscript; available in PMC 2016 January 07. 

Page 15 

Seelig and Jayaraman 

is significantly different from that for single stripe stimulus (Fig. 1k); p = 4.5×.5[−6] (see Methods), mean width = 78.7° ± 15.6° for two-stripe trials versus 82.3° ± 11.5° for single stripe trials. **d,** Mean and S.D. of the number of activity bumps as measured by Method 2 (see Methods) during all trials for all flies. **e,** Mean and S.D. of the number of successive calcium imaging frames with more than one bump, measured using Method 1 (see Methods). **f,** Same as **e** , but computed using Method 2. **g,** Same as Extended Data Fig. 2d for the pattern with two stripes (mean slope = 1.08 ± 0.41, n = 96 walking epochs). **h,** EBw.s fluorescence transients during trial with two-stripe pattern (Fly 2 in **b** ). **i,** PVA estimate of fly's angular orientation compared to actual orientation. **j,** Mean and S.D. of angular offsets between PVA position and pattern position in all flies. **k,** Correlation between PVA estimate and actual orientation of original left stripe for all flies. **l,** Mean and S.D. of angular offsets between PVA position and pattern position for each trial for all flies. **m,** Mean and S.D. of S.D. of angular offset between PVA position and pattern position. 

## **Extended Data Figure 5. Example of EBw.s activity bump transitioning between locking to one of two identical visual cues placed symmetrically on LED arena** 

**a,** Sample frames from a calcium imaging time series showing single bump of EBw.s activity as the two-stripe pattern moved around the arena in a trial in which correlation between EBw.s activity and PVA estimate changes over a 4s period (Fly 6 in Extended Data Fig. 4b). Frames during jump indicated by red time stamps. Scale bar: 20 μm. **b,** EBw.s fluorescence transients during trial displayed in **a** . **c,** Decoding of fly's angular orientation using unwrapped PVA of EBw.s activity plotted against the fly's unwrapped orientation with respect to stripe 1 and stripe 2 in the visual scene with two stripes. Red box corresponds to period when the EB activity bump switches from locking to one stripe to locking to the other (identical) stripe. 

_Nature_ . Author manuscript; available in PMC 2016 January 07. 

Page 16 

Seelig and Jayaraman 

**Extended Data Figure 6. Competing influences of visual cue and self-motion on EBw.s activity a,** Fluorescence transients during cue shift trial (Fly 9 from Fig. 1j). Red box highlights epochs during which cue abruptly shifted to new position. **b,** Comparison of PVA estimate versus actual orientation. **c,** Correlations between PVA estimates and actual orientation relative to visual cue across trials and flies for different closed-loop gain values. **d,** Fluorescence transients in the EB during closed-loop trial with a low gain of 0.58 (Fly 6 in Fig. 1j-m). Superimposed brown line indicates PVA estimate of orientation. **e,** Decoding of fly's angular orientation using PVA of EBw.s activity plotted along with the pattern position and the fly's walking rotation. PVA closely matches walking rotation rather than visual cue rotation. Note that walking rotation exceeds visual cue angular rotation in this low gain trial. **f,** Comparison of PVA estimate versus accumulated rotation of visual cue and accumulated walking rotation on the ball shows PVA estimate more closely matches walking rotation than visual cue rotation. 

_Nature_ . Author manuscript; available in PMC 2016 January 07. 

Seelig and Jayaraman 

Page 17 

## **Extended Data Figure 7. EBw.s activity when flies walk in darkness on balls of two different diameters** 

**a,** Mean and S.D. of FWHM of bump when walking in darkness on 6 mm ball. Distribution of bump widths is significantly different from that for single stripe stimulus (Fig. 1k); p = 8×10[−9] (see Methods), mean width = 90.9° ± 11.2° for walking in darkness versus 82.3° ± 11.5° for single stripe. **b,** Correlations between accumulated PVA and walking rotation in the dark across flies for walking on 6 mm diameter ball. **c,** Mean and S.D. of the number of activity bumps as measured by Method 2 (see Methods) during all trials (6 mm ball). **d,** Mean and S.D. of the number of successive calcium imaging frames with more than one bump, measured using Method 1 (see Methods, 6 mm ball). **e,** Same as **d** , but computed using Method 2 (6 mm ball). **f,** Gain between accumulated PVA estimates of orientation and accumulated walking rotation across flies for 6 mm ball. **g,** Sliding window correlations (200 frames with a step size of 25 frames) between accumulated PVA estimate and accumulated walking rotation for different levels of S.D. of walking rotation for 6 mm ball (S.D. cutoff shown included 97% of epochs). Brown line connects highest-frequency bins. **h,** Correlations between accumulated PVA and walking rotation across flies when walking in the dark on 10 mm diameter ball. **i,** Same as **f** for 10 mm ball. **j,** Same as **g** for 10 mm ball. 

_Nature_ . Author manuscript; available in PMC 2016 January 07. 

Seelig and Jayaraman 

Page 18 

## **Extended Data Figure 8. Low rotational velocities during walking in darkness are not well captured by EBw.s activity** 

Comparison of angular velocity against PVA-estimated angular velocity for all flies walking in darkness on 6 mm ball (Fig. 4, see Methods). Each point is computed across a 20-frame window, and colored based on the strength of the PVA during that epoch. Three features are prominent: (i) Rotational velocity and PVA-estimated angular velocity are correlated, but with some spread and with different slopes for different flies, that is, effective walkingrotation-to-PVA gains can be different for different flies (see Extended Data Figure 7f, i). (ii) Low rotational velocities are not always well captured by EB activity which can drift under such conditions (see points near 0 of the y-axis). (iii) Most cases of EB activity drift appear to occur in phases when the PVA strength is low (as marked by dark blue points arranged in a horizontal line for low velocities). 

_Nature_ . Author manuscript; available in PMC 2016 January 07. 

Seelig and Jayaraman 

Page 19 

**Extended Data Figure 9. Gain and correlation coefficients for flies walking with a bright stripe and after the stripe has disappeared** 

**a** , Distribution of gains between accumulated walking rotation and accumulated PVA estimate for flies walking in the dark before exposure to visual stimulus in closed-loop experiment (mean = 0.47 ± 1.2, n = 397 walking bouts). **b,** Distribution of gains between accumulated walking rotation and PVA estimate of flies walking with a bright stripe with high (light red, mean = 0.86 ± 0.64, n = 147 walking bouts) or low (light blue, mean = 0.54 ± 0.5, n = 132) closed-loop gain. All gains used were close to the likely ‘natural’ gain. **c,** Distribution of gains between accumulated walking rotation and PVA estimate of flies walking in darkness after walking with a stripe under closed-loop control in high (red, mean = 0.57 ± 0.84, n = 150) or low (blue, mean = 0.46 ± 0.7, n = 134) gain conditions. **d,** Distribution of correlation coefficients between accumulated walking rotation and accumulated PVA estimate for flies walking in darkness before visual experience in the closed-loop setup (mean = 0.6 ± 0.42). **e,** Distribution of correlation coefficients between accumulated walking rotation and accumulated PVA estimate for flies walking with a stripe under closed-loop control with high (light red, mean = 0.79 ± 0.34) or low (light blue, mean = 0.85 ± 0.18) closed-loop gain. **f,** Distribution of correlation coefficients between accumulated walking rotation and accumulated PVA estimate for flies walking in darkness after walking with a stripe under closed-loop control with high (red, mean = 0.48 ± 0.43) or low (blue, mean = 0.49 ± 0.49) gain. P-values (Kolmogorov-Smirnov two-sample test) for tests of the null hypothesis that the correlations from two different conditions are drawn from the same distribution are as follows. 

The null hypothesis can be rejected at p < 0.05 for: gainDarkAfterHighGain vs gainDarkAfterLowGain: p = 0.04; gainDarkNaive vs gainDarkAfterHighGain: p = 0.01; gainStripeHighGain vs gainStripeLowGain: p = 4×10[−8] ; gainStripeHighGain vs gainDarkAfterHighGain: p = 3×10[−7] ; gainStripeLowGain vs gainDarkAfterLowGain: p = 0.05; gainStripeLowGain vs gainDarkNaive: p = 0.001; gainStripeHighGain vs gainDarkNaive: p = 1×10[−15] . It cannot be rejected for: gainDarkNaive vs gainDarkAfterLowGain: p = 0.2. 

Subscripts indicate conditions of the relevant experiments. DarkNaive: in darkness without previous exposure to closed-loop visual stimulus; DarkAfterLowGain: walking in darkness after a period of walking in closed loop with a single stripe stimulus under low closed-loop gain conditions; DarkAfterHighGain: walking in darkness after a period of walking in closed loop with a single stripe stimulus under high closed-loop gain conditions; 

_Nature_ . Author manuscript; available in PMC 2016 January 07. 

Seelig and Jayaraman 

Page 20 

StripeHighGain: walking with a single stripe under high closed-loop gain; StripeLowGain: walking with a single stripe under low closed-loop gain. 

## **Extended Data Figure 10. Maintenance of EB representation of orientation with persistent activity when the fly is standing** 

**a,** PVA estimate before stop compared to PVA estimate before restart for the 6 mm ball (r = 0.5, p = 1×10[−29] , n = 449, linear fit slope = 0.96 ± 0.02, p = 0, intercept: 0.2 ± 0.06, p = 0.0006, R[2] = 0.83). **b,** Difference in PVA before stop and before restart plotted against duration over which the fly was standing (mean standing time, tmean = 6.6 ± 5.1 s, mean PVA difference, ΔPVAmean = 0.09 ± 1). **c,** Same as **a** for the 10 mm ball (r=0.56, p=1×10[−31] , n = 374, intercept=0.1 ± 0.06, p = 0.09, slope = 0.97 ± 0.016, p = 0, n = 374, R[2 ] = 0.903). **d,** Same as **b** for the 10 mm ball (tmean = 6.2 ± 4.5 s, ΔPVAmean = 0.03 ± 0.8). **e,** PVA estimate before stop compared to PVA estimate at restart for the 10 mm ball (r=0.48, p = 1×10[−22] , n = 374, slope = 0.96 ± 0.02, p = 0, intercept=0.13 ± 0.06, p = 0.02, R[2] = 0.91). **f,** Difference in PVA estimate before stop and at restart for the 10 mm ball and duration over which the fly was standing (tmean= 6.1 ± 4.47 s, ΔPVAmean = 0.04 ± 0.9). **g,** PVA estimate before stop compared to PVA estimate before restart during closed-loop behavior with a single stripe (r = 0.64, p = 1.5×10[−46] , n = 388, intercept = 0.03 ± 0.07, p = 0.6, slope=1 ± 0.02, p = 0, R[2] = 0.85). **h,** Difference in PVA before stop and before restart in single stripe closed-loop trial plotted against duration for which the fly was not walking (tmean=4.85 ± 3.0 s, ΔPVAmean = 0.04 ± 0.74). **i,** PVA estimate before stop compared to PVA estimate at restart during closed-loop behavior with a single stripe (r = 0.67, p = 5×10[−52] , n = 388, 

_Nature_ . Author manuscript; available in PMC 2016 January 07. 

Seelig and Jayaraman 

Page 21 

intercept = 0.1 ± 0.06, p = 0.1, slope = 0.97 ± 0.02, p = 0, R[2] = 0.88). **j,** Difference in PVA estimate before stop and at restart during closed-loop behavior with a single stripe (tmean = 4.97 ± 3.0 s, ΔPVAmean = 0.02 ± 0.65) **. k-n,** Same as **g-j** for closed-loop walking with the pattern with multiple features. **g,** r = 0.66, p = 2×10[−19] , n = 146, intercept = 0.2 ± 0.1, p = 0.05, slope = 0.9 ± 0.03, p = 0, R[2] = 0.85. **h,** r = 0.6, p = 1.6×10[−14] , n = 146, intercept = 0.19 ± 0.11, p = 0.07, slope = 0.91 ± 0.03, p = 2.1×10[−64] , R[2] = 0.87. **i,** tmean = 6.3±7.4 s, ΔPVAmean = −0.1 ± 0.8. **j,** tmean = 6.4 ± 7.4 s, ΔPVAmean = −0.04 ± 0. 8. **o-r,** Same as **g-j** for closed-loop walking with two stripes. **o,** r = 0.6, p = 5.1×10[−15] , n = 139, intercept = 0.19 ± 0.11, p = 0.08, slope = 0.93 ± 0.03, p = 0, R[2] = 0.88. **p,** r = 0.7, p = 1.4×10[−21] , n = 139, intercept = 0.2 ± 0.1, p = 0.03, slope = 0.95 ± 0.03, p = 0, R[2] = 0.9. **q,** tmean = 5.6 ± 5.8 s, ΔPVAmean = 0.01 ± 0.7. **r,** tmean = 5.8 ± 5.8 s, ΔPVAmean = 0.1 ± 0.66. 

## **Supplementary Material** 

Refer to Web version on PubMed Central for supplementary material. 

## **ACKNOWLEDGMENTS** 

We thank T. Wolff and G. Rubin for sharing information about CX neuron morphology. We thank Janelia Fly Core, and in particular K. Hibbard and S. Coffman, for support, J. Liu for technical support, and V. Iyer for ScanImage support. We are grateful to A. Karpova, A. Leonardo, S. S. Kim, H. Haberkern, D. Turner-Evans, C. Dan, S. Wegener and R. Franconville for discussions and comments on the manuscript. We thank W. Denk, S. Druckmann, J. Dudman, A. Lee, K. Longden, M. Reiser, S. Romani, G. Rubin, Y. Sun, and T. Wolff for feedback on the manuscript. This work was supported by the Howard Hughes Medical Institute. 

## **REFERENCES** 

1. Collett TS, Graham P. Animal navigation: Path integration, visual landmarks and cognitive maps. Curr. Biol. 2004; 14:R475–R477. [PubMed: 15203020] 

2. Mittelstaedt ML, Mittelstaedt H. Homing by path integration in a mammal. Naturwissenschaften. 1980; 67:566–567. 

3. Taube JS, Muller RU, Ranck JB. Head-direction cells recorded from the postsubiculum in freely moving rats. 1. Description and quantitative analysis. J. Neurosci. 1990; 10:420–435. [PubMed: 2303851] 

4. Taube JS. The head direction signal: Origins and sensory-motor integration. Annu. Rev. Neurosci. 2007; 30:181–207. [PubMed: 17341158] 

5. Huston SJ, Jayaraman V. Studying sensorimotor integration in insects. Curr. Opin. Neurobiol. 2011; 21:527–534. [PubMed: 21705212] 

6. Wehner R. Desert ant navigation: how miniature brains solve complex tasks. J. Comp. Physiol. A. 2003; 189:579–588. 

7. Collett TS, Collett M. Path integration in insects. Curr. Opin. Neurobiol. 2000; 10:757–762. [PubMed: 11240286] 

8. Neuser K, Triphan T, Mronz M, Poeck B, Strauss R. Analysis of a spatial orientation memory in Drosophila. Nature. 2008; 453:1244–1247. [PubMed: 18509336] 

9. Liu G, et al. Distinct memory traces for two visual features in the Drosophila brain. Nature. 2006; 439:551–556. [PubMed: 16452971] 

10. Ofstad TA, Zuker CS, Reiser MB. Visual place learning in Drosophila melanogaster. Nature. 2011; 474:204–207. [PubMed: 21654803] 

11. Strauss R. The central complex and the genetic dissection of locomotor behaviour. Curr. Opin. Neurobiol. 2002; 12:633–638. [PubMed: 12490252] 

12. Heinze S, Homberg U. Maplike representation of celestial E-vector orientations in the brain of an insect. Science. 2007; 315:995–997. [PubMed: 17303756] 

_Nature_ . Author manuscript; available in PMC 2016 January 07. 

Seelig and Jayaraman 

Page 22 

13. Heinze S, Reppert SM. Sun compass integration of skylight cues in migratory monarch butterflies. Neuron. 2011; 69:345–358. [PubMed: 21262471] 

14. Pfeiffer K, Homberg U. Organization and functional roles of the central complex in the insect brain. Annu. Rev. Entomol. 2014; 59:165–184. [PubMed: 24160424] 

15. Guo P, Ritzmann RE. Neural activity in the central complex of the cockroach brain is linked to turning behaviors. J. Exp. Biol. 2013; 216:992–1002. [PubMed: 23197098] 

16. Kathman ND, Kesavan M, Ritzmann RE. Encoding wide-field motion and direction in the central complex of the cockroach Blaberus discoidalis. J. Exp. Biol. 2014; 217:4079–4090. [PubMed: 25278467] 

17. Dombeck DA, Reiser MB. Real neuroscience in virtual worlds. Curr. Opin. Neurobiol. 2012; 22:3– 10. [PubMed: 22138559] 

18. Chen TW, et al. Ultrasensitive fluorescent proteins for imaging neuronal activity. Nature. 2013; 499:295–300. [PubMed: 23868258] 

19. Seelig JD, et al. Two-photon calcium imaging from head-fixed Drosophila during optomotor walking behavior. Nat. Methods. 2010; 7:535–540. [PubMed: 20526346] 

20. Seelig JD, Jayaraman V. Feature detection and orientation tuning in the Drosophila central complex. Nature. 2013; 503:262–266. [PubMed: 24107996] 

21. Bausenwein B, Muller NR, Heisenberg M. Behavior-dependent activity labeling in the central complex of Drosophila during controlled visual stimulation. J. Comp. Neurol. 1994; 340:255–268. [PubMed: 8201021] 

22. Strauss R, Pichler J. Persistence of orientation toward a temporarily invisible landmark in Drosophila melanogaster. J. Comp. Physiol. A. 1998; 182:411–423. [PubMed: 9530834] 

23. Jenett A, et al. A GAL4-driver line resource for Drosophila neurobiology. Cell Rep. 2012; 2:991– 1001. [PubMed: 23063364] 

24. Wolff T, Iyer NA, Rubin GM. Neuroarchitecture and neuroanatomy of the Drosophila central complex: A GAL4-based dissection of protocerebral bridge neurons and circuits. J. Comp. Neurol. 523. 2015 

25. Hanesch U, Fischbach KF, Heisenberg M. Neuronal architecture of the central complex in Drosophila-melanogaster. Cell Tissue Res. 1989; 257:343–366. 

26. Lin CY, et al. A comprehensive wiring diagram of the protocerebral bridge for visual information processing in the Drosophila brain. Cell Rep. 2013; 3:1739–1753. [PubMed: 23707064] 

27. Heinze S, Gotthardt S, Homberg U. Transformation of polarized light information in the central complex of the locust. J. Neurosci. 2009; 29:11783–11793. [PubMed: 19776265] 

28. Mizumori SJY, Williams JD. Directionally selective mnemonic properties of neurons in the lateral dorsal nucleus of the thalamus of rats. J. Neurosci. 1993; 13:4015–4028. [PubMed: 8366357] 

29. Laughlin SB. The role of sensory adaptation in the retina. J. Exp. Biol. 1989; 146:39–62. [PubMed: 2689569] 

30. Bockhorst T, Homberg U. Amplitude and dynamics of polarization-plane signaling in the central complex of the locust brain. J. Neurophysiol. 2015 jn.00742.2014. 

31. Young JM, Armstrong JD. Structure of the adult central complex in Drosophila: Organization of distinct neuronal subsets. J. Comp. Neurol. 2010; 518:1500–1524. [PubMed: 20187142] 

32. Zeil J. Visual homing: an insect perspective. Curr. Opin. Neurobiol. 2012; 22:285–293. [PubMed: 22221863] 

33. Koch C, Ullman S. Shifts in selective visual attention: towards the underlying neural circuitry. Hum. Neurobiol. 1985; 4:219–227. [PubMed: 3836989] 

34. Strausfeld NJ, Hirth F. Deep homology of arthropod central complex and vertebrate basal ganglia. Science. 2013; 340:157–161. [PubMed: 23580521] 

35. Aksay E, et al. Functional dissection of circuitry in a neural integrator. Nat. Neurosci. 2007; 10:494–504. [PubMed: 17369822] 

36. Durstewitz D, Seamans JK, Sejnowski TJ. Neurocomputational models of working memory. Nat. Neurosci. 2000; 3:1184–1191. [PubMed: 11127836] 

37. Knierim JJ, Zhang KC. Attractor dynamics of spatially correlated neural activity in the limbic system. Annu. Rev. Neurosci. 2012; 35:267–285. [PubMed: 22462545] 

_Nature_ . Author manuscript; available in PMC 2016 January 07. 

Seelig and Jayaraman 

Page 23 

38. Peyrache A, Lacroix MM, Petersen PC, Buzsaki G. Internally organized mechanisms of the head direction sense. Nat. Neurosci. 2015; 18:569–75. [PubMed: 25730672] 

39. Arena P, Maceo S, Patané L, Strauss R. A spiking network for spatial memory formation: Towards a fly-inspired ellipsoid body model. Intl. Joint Conf. Neural Networks. 2013:1–6. 

40. Haferlach T, Wessnitzer J, Mangan M, Webb B. Evolving a neural model of insect path integration. Adapt. Behav. 2007; 15:273–287. 

41. Yoshida M, Hasselmo ME. Persistent firing supported by an intrinsic cellular mechanism in a component of the head direction system. J. Neurosci. 2009; 29:4945–4952. [PubMed: 19369563] 

42. Major G, Tank D. Persistent neural activity: prevalence and mechanisms. Curr. Opin. Neurobiol. 2004; 14:675–684. [PubMed: 15582368] 

43. Maimon G, Straw AD, Dickinson MH. Active flight increases the gain of visual motion processing in Drosophila. Nat. Neurosci. 2010; 13:393–399. [PubMed: 20154683] 

44. Pologruto TA, Sabatini BL, Svoboda K. ScanImage: flexible software for operating laser scanning microscopes. Biomed. Eng. Online. 2003; 2:13. [PubMed: 12801419] 

45. Reiser MB, Dickinson MH. A modular display system for insect behavioral neuroscience. J. Neurosci. Methods. 2008; 167:127–139. [PubMed: 17854905] 

46. Bahl A, Ammer G, Schilling T, Borst A. Object tracking in motion-blind flies. Nat. Neurosci. 2013; 16:730–738. [PubMed: 23624513] 

47. Berens P. CircStat: A MATLAB toolbox for circular statistics. J. Stat. Softw. 2009; 31:1–21. 

_Nature_ . Author manuscript; available in PMC 2016 January 07. 

Seelig and Jayaraman 

Page 24 

**Figure 1. Ellipsoid body activity tracks azimuth of visual cue a,** Schematic of setup. Inset: close-up of fly on air-supported ball (modified from[20] ). **b,** Schematic of fly central brain and CX: ellipsoid body (EB), fan-shaped body (FB), protocerebral bridge (PB), paired noduli (NO), lateral accessory lobe (LAL) and gall (Gall). MB: mushroom body. **c,** Each EBw.s neuron receives inputs from an EB wedge and sends outputs to a corresponding PB column, and to the gall[24,26] . The PB has 18 columns[24] , but EBw.s neurons only innervate the central 16. **d,** GFP-labeled EBw.s neurons in a brain counterstained with nc82 (Maximum intensity projection (MIP), reproduced with permission from Janelia FlyLight Image Database[23] ). **e,** MIP of two-photon imaging stack (5 frames, 5 μm apart, see Methods) showing EB processes of GCaMP6f-labeled EBw.s neurons. **f,** Top: Closed-loop walking with a vertical stripe. Bottom: EBw.s activity is measured in 16 regions of interest (ROIs). Sample frames from calcium imaging time series (Fly 15) showing MIP of EB activity bump (see Methods) as fly rotates visual cue around arena (top). Arrows at top of **h** indicate frame times. **g,** Steps to compute PVA based on EBw.s population activity. 

_Nature_ . Author manuscript; available in PMC 2016 January 07. 

Page 25 

Seelig and Jayaraman 

EB is unwrapped from Wedge 1 to Wedge 16 to display population time series in **h** . Superimposed is PVA estimate that incorporates trial-specific offset ( **m** ; see Methods). **h,** EBw.s fluorescence transients during single trial (same trial as **f** ). Color scale at right. Superimposed brown line indicates PVA estimate of angular orientation of visual cue. Top: Horizontal grayscale stripe shows PVA amplitude; intensity scale at left. **i,** PVA estimate of angular orientation plotted against actual orientation of visual cue (see Methods). **j,** Mean and standard deviation (S.D.) of number of activity bumps in EBw.s population activity across trials for each of 15 flies (see Methods). **k,** Mean and S.D. of full width at half maximum (FWHM) of activity bump across trials and flies (see Methods). **l,** Mean and S.D. of correlation between PVA estimate and actual orientation (pattern position) (see Methods). **m,** Mean and S.D. of angular offsets between PVA position and pattern position (see Methods, Extended Data Fig. 2e, f). All scale bars: 20 μm. 

_Nature_ . Author manuscript; available in PMC 2016 January 07. 

Page 26 

Seelig and Jayaraman 

**Figure 2. Ellipsoid body is not a retinotopic map of visual scene, but represents fly's orientation relative to visual landmarks** 

**a,** Closed-loop experiment in visual environment with multiple features (Fly 1 in **b** ). **b,** Mean and S.D. of number of bumps across trials for each of 9 flies. **c,** Mean and S.D. of FWHM of bump. Distribution of bump widths is not significantly different from that for single stripe stimulus (Fig. 1k); p = 0.14 (see Methods), mean width = 84.9° ± 12.6° for multiple feature trials versus 82.3° ± 11.5° for single stripe trials. **d,** EBw.s fluorescence transients (same trial as **a** ). **e,** PVA estimate of fly's angular orientation compared to actual orientation. **f,** Mean and S.D. of angular offsets (see Methods, Extended Data Fig. 3e, f). **g,** Correlation between PVA estimate and actual orientation. Scale bar: 20 μm. 

_Nature_ . Author manuscript; available in PMC 2016 January 07. 

Seelig and Jayaraman 

Page 27 

**Figure 3. EBw.s activity tracks landmark orientation cues over angular rotation when these cues are in conflict** 

**a,** In cue shift experiments, fly is in closed-loop control of stripe position until cue is abruptly shifted to new position (see Methods). **b,** Offset between PVA estimate and actual orientation relative to visual cue before and after cue shift. Plot compares actual offsets with those expected if EBw.s activity did not follow cue position (see Methods). N = 50 shifts (n = 6 flies), r = 0.85, pr = 0. Fit: slope = 0.78 ± 0.07, pslope = 0, R[2] = 0.72. **c,** In closed-loop gain change experiments, ball rotation drives movement of visual stimulus with different closed-loop gains. **d,** Fluorescence transients during trial with low gain of 0.6 (Fly 15 from Fig. 1j). **e,** Comparison of PVA estimate versus accumulated rotation of visual cue and walking rotation on ball (trial in **d** ). Walking rotation exceeds visual cue angular rotation in this low gain trial. **f,** Similar to **d** , but with high closed-loop gain of 1.3 (Fly 3 from Fig. 1j). **g,** Similar to **e** , but with high gain (trial in **f** ). **h** , Effective gain between walking rotation and PVA estimate for different closed-loop gains (r = 0.69, pr = 0, Fit: slope = 0.85 ± 0.07, pslope = 0, n = 172, R[2] = 0.48, see Methods). **i** , Effective gain between visual cue rotation and PVA 

_Nature_ . Author manuscript; available in PMC 2016 January 07. 

Seelig and Jayaraman 

Page 28 

estimate for different closed-loop gains (r = 0, pr = 15.1×10[−3] , Fit: slope = −0.17 ± 0.07, pslope = 0.02, n = 172, R[2] = 0.03, see Methods). 

_Nature_ . Author manuscript; available in PMC 2016 January 07. 

Seelig and Jayaraman 

Page 29 

**Figure 4. Path integration, drift and persistence in EBw.s activity in total darkness a,** Experiments with flies walking in total darkness. **b,** Mean and S.D. of number of bumps across trials for each of 11 flies. **c,** Fluorescence transients during trial in darkness (Fly 9 in **b** ). **d,** Accumulated ball rotation plotted against accumulated PVA estimate of fly's rotation. **e,** Sample frames from time series showing that EBw.s activity is maintained in absence of both visual cues and rotation (Fly 3 in **b** ). Scale bar: 20 μm. **f,** Fluorescence transients during trial in **e** . **g,** Representation of fly's angular orientation is maintained in the absence of rotation and resumes from previous wedge after long delay (gray rectangles indicate epochs of fly standing). **h,** Comparison of PVA estimate of orientation before stop and at restart for different standing bouts across n = 11 flies (r = 0.7, pr = 0, Fit: slope = 0.96 ± 0.17, pslope = 0, n = 499, R[2] = 0.879). **i,** Durations of standing bouts in **l** (tmean = 6.7 ± 5.1 s, ΔPVAmean = 0.017 ± 0.76 rad). 

_Nature_ . Author manuscript; available in PMC 2016 January 07. 

