# schultz-1997-neural-substrate-prediction-reward

> Converted from `schultz-1997-neural-substrate-prediction-reward.pdf` on 2026-08-31 via `pymupdf4llm`.
> Layout artefacts (broken equations, interleaved columns) are conversion noise, not the source.

---

48. H. S. Mayberg _et al., Ann. Neurol._ 28, 57 (1990).
49. R. M. Cohen _et_ _al._, _Neuropsychopharmacology_ 2,
241 (1989).
50. J. E. LeDoux, _Sci. Am._ 6, 50 (June 1994); M. Davis,
_Annu. Rev. Neurosci._ 15, 353 (1992).
51. J. E. LeDoux, _Curr. Opin. Neurobiol._ 2, 191 (1992); L.
M. Romanski and J. E. LeDoux, _J. Neurosci._ 12, 4501
(1992); J. L. Armony, J. D. Cohen, D. Servan-Schreiber, J. E. LeDoux, _Behav. Neurosci._ 109, 246 (1995).
52. K. P. Corodimas and J. E. LeDoux, _Behav. Neurosci._
109, 613 (1995).
53. M. J. D. Miserendino, C. B. Sananes, K. R. Melia,
M. Davis, _Nature_ 345, 716 (1990); C. Farb _et_ _al._,

_Brain Res._ 593, 145 (1992); M. Davis, D. Rainne, M.
Cassell, _Trends_ _Neurosci._ 17, 208 (1994).
54. M. E. P. Seligman, _J. Abnorm. Psychol._ 74, 1 (1976);
F. Schneider _et_ _al.,_ _Am._ _J._ _Psychiatry_ 153, 206
(1996).
55. W. C. Drevets _et_ _al_ ., _J._ _Neuroscience_ 12, 3628
(1992).
56. Ssupported in part by National Institiute of Mental
Health grants MH31593, MH40856, and MHCRC43271; by a Research Scientist Award,
MH00625; and by an Established Investigator Award
from the National Association for Research in
Schizophrenia and Affective Disorders.

# **A Neural Substrate of** **Prediction and Reward**

Wolfram Schultz, Peter Dayan, P. Read Montague*

The capacity to predict future events permits a creature to detect, model, and manipulate
the causal structure of its interactions with its environment. Behavioral experiments
suggest that learning is driven by changes in the expectations about future salient events
such as rewards and punishments. Physiological work has recently complemented these
studies by identifying dopaminergic neurons in the primate whose fluctuating output
apparently signals changes or errors in the predictions of future salient and rewarding
events. Taken together, these findings can be understood through quantitative theories
of adaptive optimizing control.

### A n adaptive organism must be able to

predict future events such as the presence of
mates, food, and danger. For any creature,
the features of its niche strongly constrain
the time scales for prediction that are likely
to be useful for its survival. Predictions give
an animal time to prepare behavioral reactions and can be used to improve the choices an animal makes in the future. This
anticipatory capacity is crucial for deciding
between alternative courses of action because some choices may lead to food whereas others may result in injury or loss of
resources.

Experiments show that animals can predict many different aspects of their environments, including complex properties such as
the spatial locations and physical characteristics of stimuli ( _1_ ). One simple, yet useful
prediction that animals make is the probable time and magnitude of future rewarding
events. “Reward” is an operational concept
for describing the positive value that a creature ascribes to an object, a behavioral act,

W. Schultz is at the Institute of Physiology, University of
Fribourg, CH-1700 Fribourg, Switzerland. E-mail:
Wolfram.Schultz@unifr.ch P. Dayan is in the Department of Brain and Cognitive Sciences, Center for Biological and Computational Learning, E-25 MIT, Cambridge, MA 02139, USA. E-mail: dayan@ai.mit.edu P.
R. Montague is in the Division of Neuroscience, Center
for Theoretical Neuroscience, Baylor College of Medicine, 1 Baylor Plaza, Houston, TX 77030, USA. E-mail:
read@bcm.tmc.edu

*To whom correspondence should be addressed.

or an internal physical state. The function
of reward can be described according to the
behavior elicited ( _2_ ). For example, appetitive or rewarding stimuli induce approach
behavior that permits an animal to consume. Rewards may also play the role of
positive reinforcers where they increase the
frequency of behavioral reactions during
learning and maintain well-established appetitive behaviors after learning. The reward value associated with a stimulus is not
a static, intrinsic property of the stimulus.
Animals can assign different appetitive values to a stimulus as a function of their
internal states at the time the stimulus is
encountered and as a function of their experience with the stimulus.

One clear connection between reward
and prediction derives from a wide variety
of conditioning experiments ( _1_ ). In these
experiments, arbitrary stimuli with no intrinsic reward value will function as rewarding stimuli after being repeatedly associated
in time with rewarding objects—these objects are one form of unconditioned stimulus (US). After such associations develop,
the neutral stimuli are called conditioned
stimuli (CS). In the descriptions that follow, we call the appetitive CS the sensory
cue and the US the reward. It should be
kept in mind, however, that learning that
depends on CS-US pairing takes many different forms and is not always dependent on
reward (for example, learning associated

**<mark>ARTICLES</mark>**

with aversive stimuli). In standard conditioning paradigms, the sensory cue must
consistently precede the reward in order for
an association to develop. After conditioning, the animal’s behavior indicates that the
sensory cue induces a prediction about the
likely time and magnitude of the reward
and tends to elicit approach behavior. It
appears that this form of learning is associated with a transfer of an appetitive or
approach-eliciting component of the reward back to the sensory cue.

Some theories of reward-dependent
learning suggest that learning is driven by
the unpredictability of the reward by the
sensory cue ( _3_, _4_ ). One of the main ideas is
that no further learning takes place when
the reward is entirely predicted by a sensory
cue (or cues). For example, if presentation
of a light is consistently followed by food, a
rat will learn that the light predicts the
future arrival of food. If, after such training,
the light is paired with a sound and this pair
is consistently followed by food, then something unusual happens—the rat’s behavior
indicates that the light continues to predict
food, but the sound predicts nothing. This
phenomenon is called “blocking.” The prediction-based explanation is that the light
fully predicts the food that arrives and the
presence of the sound adds no new predictive (useful) information; therefore, no association developed to the sound ( _5_ ). It
appears therefore that learning is driven by
deviations or “errors” between the predicted
time and amount of rewards and their actual experienced times and magnitudes [but
see ( _4_ )].

Engineered systems that are designed to
optimize their actions in complex environments face the same challenges as animals,
except that the equivalent of rewards and
punishments are determined by design
goals. One established method by which
artificial systems can learn to predict is
called the temporal difference (TD) algorithm ( _6_ ). This algorithm was originally
inspired by behavioral data on how animals
actually learn predictions ( _7_ ). Real-world
applications of TD models abound. The
predictions learned by TD methods can also
be used to implement a technique called
dynamic programming, which specifies how
a system can come to choose appropriate
actions. In this article, we review how these
computational methods provide an interpretation of the activity of dopamine neurons thought to mediate reward-processing
and reward-dependent learning. The connection between the computational theory
and the experimental results is striking and
provides a quantitative framework for future
experiments and theories on the computational roles of ascending monoaminergic
systems ( _8–13_ ).

**1593**
http://www.sciencemag.org � SCIENCE � VOL. 275 � 14 MARCH 1997

lever as soon as the light is illuminated, and
this behavioral change correlates with two
remarkable changes in the dopamine neuron output: (i) the primary reward no longer
elicits a phasic response; and (ii) the onset
of the (predictive) light now causes a phasic
activation in dopamine cell output (Fig. 1,
middle). The changes in dopaminergic activity strongly resemble the transfer of an
animal’s appetitive behavioral reaction
from the US to the CS.

In trials where the reward is not delivered at the appropriate time after the onset
of the light, dopamine neurons are depressed markedly below their basal firing
rate exactly at the time that the reward
should have occurred (Fig. 1, bottom). This
well-timed decrease in spike output shows
that the expected time of reward delivery
based on the occurrence of the light is also
encoded in the fluctuations in dopaminergic activity ( _18_ ). In contrast, very few dopamine neurons respond to stimuli that predict aversive outcomes.

The language used in the foregoing description already incorporates the idea that
dopaminergic activity encodes expectations
about external stimuli or reward. This interpretation of these data provides a link to an
established body of computational theory ( _6,_
_7_ ). From this perspective, one sees that dopamine neurons do not simply report the occurrence of appetitive events. Rather, their outputs appear to code for a deviation or error
between the actual reward received and predictions of the time and magnitude of reward.
These neurons are activated only if the time
of the reward is uncertain, that is, unpredicted
by any preceding cues. Dopamine neurons are
therefore excellent feature detectors of the
“goodness” of environmental events relative
to learned predictions about those events.
They emit a positive signal (increased spike
production) if an appetitive event is better
than predicted, no signal (no change in spike
production) if an appetitive event occurs as
predicted, and a negative signal (decreased
spike production) if an appetitive event is
worse than predicted (Fig. 1).

**Computational Theory and Model**

The TD algorithm ( _6, 7_ ) is particularly well
suited to understanding the functional role
played by the dopamine signal in terms of
the information it constructs and broadcasts
( _8, 10, 12_ ). This work has used fluctuations
in dopamine activity in dual roles (i) as a
supervisory signal for synaptic weight
changes ( _8,_ _10,_ _12_ ) and (ii) as a signal to
influence directly and indirectly the choice
of behavioral actions in humans and bees
( _9_ - _11_ ). Temporal difference methods have
been used in a wide spectrum of engineering
applications that seek to solve prediction

**Information Encoded in**

**Dopaminergic Activity**

Dopamine neurons of the ventral tegmental
area (VTA) and substantia nigra have long
been identified with the processing of rewarding stimuli. These neurons send their
axons to brain structures involved in motivation and goal-directed behavior, for example, the striatum, nucleus accumbens,
and frontal cortex. Multiple lines of evidence support the idea that these neurons
construct and distribute information about
rewarding events.

First, drugs like amphetamine and cocaine exert their addictive actions in part by
prolonging the influence of dopamine on
target neurons ( _14_ ). Second, neural pathways associated with dopamine neurons are
among the best targets for electrical selfstimulation. In these experiments, rats press
bars to excite neurons at the site of an implanted electrode ( _15_ ). The rats often
choose these apparently rewarding stimuli
over food and sex. Third, animals treated
with dopamine receptor blockers learn less
rapidly to press a bar for a reward pellet ( _16_ ).
All the above results generally implicate
midbrain dopaminergic activity in rewarddependent learning. More precise information about the role played by midbrain dopaminergic activity derives from experiments
in which activity of single dopamine neurons
is recorded in alert monkeys while they perform behavioral acts and receive rewards.

In these latter experiments ( _17_ ), dopamine neurons respond with short, phasic
activations when monkeys are presented
with various appetitive stimuli. For example, dopamine neurons are activated when
animals touch a small morsel of apple or
receive a small quantity of fruit juice to the
mouth as liquid reward (Fig. 1). These phasic activations do not, however, discriminate between these different types of rewarding stimuli. Aversive stimuli like air
puffs to the hand or drops of saline to the
mouth do not cause these same transient
activations. Dopamine neurons are also activated by novel stimuli that elicit orienting
reactions; however, for most stimuli, this
activation lasts for only a few presentations.
The responses of these neurons are relatively homogeneous—different neurons respond in the same manner and different
appetitive stimuli elicit similar neuronal responses. All responses occur in the majority
of dopamine neurons (55 to 80%).

Surprisingly, after repeated pairings of
visual and auditory cues followed by reward,
dopamine neurons change the time of their
phasic activation from just after the time of
reward delivery to the time of cue onset. In
one task, a naı¨ve monkey is required to
touch a lever after the appearance of a small
light. Before training and in the initial
phases of training, most dopamine neurons
show a short burst of impulses after reward
delivery (Fig. 1, top). After several days of
training, the animal learns to reach for the

**Do dopamine neurons report an error�**

**Fig.** **1.** Changes in dopamine neurons’ **Do dopamine neurons report an error�**
output code for an error in the prediction of **in the prediction of reward?**

absence of prediction—hence a positive
error in the prediction of reward. The dopamine neuron is activated by this unpredicted occurrence of juice. ( **Middle** ) After

reward, and the reward occurs according

ron is activated by the reward-predicting
stimulus but fails to be activated by the
predicted reward (right). ( **Bottom** ) After
learning, the conditioned stimulus predicts

cause of a mistake in the behavioral response of the monkey. The activity of the
dopamine neuron is depressed exactly at
the time when the reward would have occurred. The depression occurs more than
1 s after the conditioned stimulus without

dicted reward. Neuronal activity is aligned
on the electronic pulse that drives the solenoid valve delivering the reward liquid (top) or the onset of the
conditioned visual stimulus (middle and bottom). Each panel shows the peri-event time histogram and
raster of impulses from the same neuron. Horizontal distances of dots correspond to real-time intervals.
Each line of dots shows one trial. Original sequence of trials is plotted from top to bottom. CS,
conditioned, reward-predicting stimulus; R, primary reward.

**1594**
SCIENCE � VOL. 275 � 14 MARCH 1997 � http://www.sciencemag.org

**<mark>ARTICLES</mark>**

cues, each would have its own vector representation and its own vector of weights,
and Eq. 4 would be summed over all the
cues.

_Comparing model and data._ We now turn
this apparatus toward the neural and behavioral data described above. To construct
and use an error signal similar to the TD
error above, a neural system would need to
possess four basic features: (i) access to a
measure of reward value _r_ ( _t_ ); (ii) a signal
measuring the temporal derivative of the
ongoing prediction of reward - _V_ <sup>_ˆ_</sup> ( _t_ - 1) 
_ˆV_ ( _t_ ); (iii) a site where these signals could be
summed; and (iv) delivery of the error signal to areas constructing the prediction in
such a way that it can control plasticity.

It has been previously proposed that
midbrain dopamine neurons satisfy features

**Fig. 2.** Constructing and using a prediction error.
( **A** ) Interpretation of the anatomical arrangement
of inputs and outputs of the ventral tegmental area
( VTA). M1 and M2 represent two different cortical
modalities whose output is assumed to arrive at
the VTA in the form of a temporal derivative (surprise signal) _V_ <sup>_˙_</sup> ( _t_ ), which reflects the degree to
which the current sensory state differs from the
previous sensory state. The high degree of convergence forces _V_ <sup>_˙_</sup> ( _t_ ) to arrive at the VTA as a
scalar signal. Information about reward _r_ ( _t_ ) also
converges on the VTA. The VTA output is taken
as a simple linear sum �( _t_ ) - _r_ ( _t_ ) - _V_ <sup>_˙_</sup> ( _t_ ). The
widespread output connections of the VTA make
the prediction error �( _t_ ) simultaneously available to
structures constructing the predictions. ( **B** ) Temporal representation of a sensory cue. A cue like a
light is represented at multiple delays **x** _n_ from its
initial time of onset, and each delay is associated
with a separate adjustable weight **w** _n_ . These parameters **w** _n_ are adjusted according to the correlation of activity **x** _n_ and � and through training come
to act as predictions. This simple system stores
predictions rather than correlations.

problems analogous to those faced by living
creatures ( _19_ ). Temporal difference methods were introduced into the psychological
and biological literature by Richard Sutton
and Andrew Barto in the early 1980s ( _6_, _7_ ).
It is therefore interesting that this method
yields some insight into the output of dopamine neurons in primates.

There are two main assumptions in TD.
First, the computational goal of learning is
to use the sensory cues to predict a discounted sum of all future rewards _V_ ( _t_ ) within a learning trial:

_V_ ( _t_ ) � _E_ [� <sup>0</sup> _r_ ( _t_ ) �� <sup>1</sup> _r_ ( _t_ - 1)

�� <sup>2</sup> _r_ ( _t_    - 2) � ���] (1)

where _r_ ( _t_ ) is the reward at time _t_ and _E_ [�]
denotes the expected value of the sum of
future rewards up to the end of the trial. 0 �

- - 1 is a discount factor that makes rewards that arrive sooner more important
than rewards that arrive later. Predicting
the sum of future rewards is an important
generalization over static conditioning
models like the Rescorla-Wagner rule for
classical conditioning ( _1–4_ ). The second
main assumption is the Markovian one,
that is, the presentation of future sensory
cues and rewards depends only on the immediate (current) sensory cues and not the
past sensory cues.

As explained below, the strategy is to use
a vector describing the presence of sensory
cues **x** ( _t_ ) in the trial along with a vector of
adaptable weights **w** to make an estimate

_ˆV(t_ ) of the true _V_ ( _t_ ). The reason that the
sensory cue is written as a vector is explained
below. The difficulty in adjusting weights **w**
to estimate _V_ ( _t_ ) is that the system (that is,
the animal) would have to wait to receive all
its future rewards in a trial _r_ ( _t_ - 1), _r_ ( _t_ 2), . . . to assess its predictions. This latter
constraint would require the animal to remember over time which weights need
changing and which weights do not.

Fortunately, there is information available at each instant in time that can act as
a surrogate prediction error. This possibility
is implicit in the definition of _V_ ( _t_ ) because
it satisfies a condition of consistency
through time:

_V_ ( _t_ ) � _E_ [ _r_ ( _t_ ) �� _V_ ( _t_   - 1)] (2)

An error in the estimated predictions can
now be defined with information available
at successive time steps:

�� _t_ ) � _r_ ( _t_ ) �� _V_ <sup>_ˆ_</sup> ( _t_   - 1) � _V_ <sup>_ˆ_</sup> ( _t_ ) (3)

This �( _t_ ) is called the TD error and acts as
a surrogate prediction error signal that is
instantly available at time _t_ - 1. As described below, �( _t_ ) is used to improve the
estimates of _V_ ( _t_ ) and also to choose appropriate actions.

_Representing_ _a_ _stimulus_ _through_ _time._ We
suggested above that a set of sensory cues
along with an associated set of adaptable
weights would suffice to estimate _V_ ( _t_ ) (the
discounted sum of future rewards). It is,
however, not sufficient for the representation of each sensory cue (for example _,_ a
light) to have only one associated adaptable
weight because such a model would not
account for the data shown above—it
would not be able to represent both the
time of the cue and the time of reward
delivery. These experimental data show
that a sensory cue can predict reward delivery at arbitrary times into the near future.
This conclusion holds for both the monkeys’ behavior and the output of the dopamine neurons. If the time of reward delivery
is changed relative to the time of cue onset,
then the same cue will come to predict the
new time of reward delivery. The way in
which such temporal labels are constructed
in neural tissue is not known, but it is clear
that they exist ( _20_ ).

Given these facts, we assume that each
sensory cue consists of a vector of signals
**x** ( _t_ ) - { _x_ 1( _t_ ), _x_ 2( _t_ ), ��� } that represent the
light for variable lengths of time into the
future, that is, _xi(t_ ) is 1 exactly _i_ time steps
after the presentation of the light in the
trial and 0 otherwise (Fig. 2B). Each component of **x** ( _t_ ), _xi_ ( _t_ ), has its own prediction
weight _wi_ (Fig. 2B). This representation
means that if the light comes on at time _s_,
_x_ 1( _s_ - 1) � 1, _x_ 2( _s_ - 2) � 1, . . . represent
the light at 1, 2, . . . time steps into the
future and _w_ 1, _w_ 2, . . . are the respective
weights. The net prediction for cue **x** ( _t_ ) at
time _t_ takes the simple linear form

_ˆV_ ( _t_ ) � _ˆV_ ( **x** ( _t_ )) �� _iwixi_      - _t_ ) (4)

This form of temporal representation is
what Sutton and Barto ( _7_ ) call a complete
serial-compound stimulus and is related to
Grossberg’s spectral timing model ( _21_ ).
Unfortunately, virtually nothing is known
about how the brain represents a stimulus
for substantial periods of time into the
future; therefore, all temporal representations are underconstrained from a biological perspective.

As in trial-based models like the Rescorla-Wagner rule, the adaptable weights **w**
are improved according to the correlation
between the stimulus representations and
the prediction error. The change in weights
from one trial to the next is

    - _wi_ �� _x_    - _txi_ ( _t_ )�( _t_ ) (5)

where - _x_ is the learning rate for cue **x** ( _t_ )
and the sum over _t_ is taken over the course
of a trial. It has been shown that under
certain conditions this update rule (Eq. 5)
will cause _V_ <sup>_ˆ_</sup> ( _t_ ) to converge to the true _V_ ( _t_ )
( _22_ ). If there were many different sensory

**1595**
http://www.sciencemag.org � SCIENCE � VOL. 275 � 14 MARCH 1997

(i), (ii), and (iii) listed above (Fig. 2A) ( _8_,
_10_, _12_ ). As indicated in Fig. 2, the dopamine neurons receive highly convergent input from many brain regions. The model
represents the hypothesis that this input
arrives in the form of a surprise signal that
measures the degree to which the current
sensory state differs from the last sensory
state. We assume that the dopamine neurons’ output actually reflects �( _t_ ) - _b_ ( _t_ ),
where _b_ ( _t_ ) is a basal firing rate ( _12_ ). Figure
3 shows the training of the model on a task
where a single sensory cue predicted the
future delivery of a fixed amount of reward
20 time steps into the future. The prediction error signal (top) matches the activity
of the real dopamine neurons over the
course of learning. The pattern of weights
that develops (bottom) provide the model’s
explanations for two well-described behavioral effects—blocking and secondary conditioning ( _1_ ). The model accounts for the
behavior of the dopamine neurons in a
variety of other experiments in monkeys
( _12_ ). The model also accounts for changes
in dopaminergic activity if the time of the
reward is changed ( _18_ ).

The model makes two other testable predictions: (i) in the presence of multiple
sensory cues that predict reward, the phasic

activation of the neurons will transfer to
the earliest consistent cue. (ii) After training on multiple sensory cues, omission of an
intermediate cue will be accompanied by a
phasic decrease in dopaminergic activity at
the time that the cue formerly occurred. For
example, after training a monkey on the
temporal sequence light 13light 23reward, the dopamine neurons should respond
phasically only to the onset of light 1. At
this point, if light 2 is omitted on a trial, the
activity in the neurons will depress at the
time that light 2 would have occurred.

_Choosing_ _and_ _criticizing_ _actions._ We
showed above how the dopamine signal can
be used to learn and store predictions; however, these same responses could also be
used to influence the choice of appropriate
actions through a connection with a technique called dynamic programming ( _23_ ).
We discuss below the connection to dynamic programming.

We introduce this use with a simple
example. Suppose a rat must move through
a maze to gain food. In the hallways of the
maze, the rat has two options available to it:
go forward a step or go backward a step. At
junctions, the rat has three or four directions from which to choose. At each position, the rat has various actions available to

**Fig.** **3.** Development of prediction
error signal through training. ( **Top** )

mine neuron output) as a function of

10 and time step 20 followed by

cause the associated weights are

strong positive response (increased

at time step 60. By repeating the

in time by reward, the transient response of the model shifts to the
time of the earliest sensory cue

reward during an intermediate trial

be seen in an experiment as a

timing of reward delivery is learned

to the earliest sensory cue. ( **Bot-**

weights are all initially set to 0 (trial

occurs on trial 0, the weights begin
to grow. Eventually they all saturate to 1 so that the only transient is the unpredicted onset of the first
sensory cue. The depression in the surface results from the error trial where the reward was not delivered
at the expected time.

it, and the action chosen will affect its
future prospects for finding its way to food.
A wrong turn at one point may not be felt
as a mistake until many steps later when the
rat runs into a dead end. How is the rat to
know which action was crucial in leading it
to the dead end? This is called the temporal
credit assignment problem: Actions at one
point in time can affect the acquisition of
rewards in the future in complicated ways.

One solution to temporal credit assignment is to describe the animal as adopting
and improving a “policy” that specifies how
its actions are assigned to its states. Its state
is the collection of sensory cues associated
with each maze position. To improve a
policy, the animal requires a means to evaluate the value of each maze position. The
evaluation used in dynamic programming is
the amount of summed future reward expected from each maze position provided
that the animal follows its policy. The
summed future rewards expected from some
state [that is, _V_ ( _t_ )] is exactly what the TD
method learns, suggesting a connection
with the dopamine signal.

As the rat above explores the maze, its
predictions become more accurate. The predictions are considered “correct” once the
average prediction error <u>�(</u> _t_ ) is 0. At this
point, fluctuations in dopaminergic activity
represent an important “economic evaluation” that is broadcast to target structures:
Greater than baseline dopamine activity
means the action performed is “better than
expected” and less than baseline means
“worse than expected.” Hence, dopamine
responses provide the information to implement a simple behavioral strategy—take [or
learn to take ( _24_ )] actions correlated with
increased dopamine activity and avoid actions correlated with decreases in dopamine
activity.

A very simple such use of �( _t_ ) as an
evaluation signal for action choice is a form
of learned klinokinesis ( _25_ ), choosing one
action while �( _t_ ) - 0, and choosing a new
random action if �( _t_ ) - 0. This use of �( _t_ )
has been shown to account for bee foraging
behavior on flowers that yield variable returns ( _9_, _11_ ). Figure 4 shows the way in
which TD methods can construct for a mobile “creature” a useful map of the value of
certain actions.

A TD model was equipped with a simple
visual system (two, 200 by 200 pixel retinae) and trained on three different sensory
cues (colored blocks) that differed in the
amount of reward each contained (blue green - red). The model had three neurons, each sensitive only to the percentage
of one color in the visual field. Each colorsensitive neuron provides input to the prediction unit P (analog of VTA unit in Fig.
2) through a single weight. Dedicating only

**1596**
SCIENCE � VOL. 275 � 14 MARCH 1997 � http://www.sciencemag.org

**<mark>ARTICLES</mark>**

responsibility of these targets to pass out
information about the degree to which the
nondelivery of reward was “punishing.” It
was long ago proposed that rewards and
punishments represent opponent processes
and that the dynamics of opponency might
be responsible for many puzzling effects in
conditioning ( _28_ ).

A third issue raised by the model is the
relation between scalar signals of appetitive
values and vector signals with many components, including those that represent primary rewards and predictive stimuli. Simple
models like the one presented above may be
able to learn with a scalar signal only if the
scope of choices is limited. Behavior in
more realistic environmental situations requires vector signaling of the type of rewards and of the various physical components of the predictive stimuli. Without the
capacity to discriminate which stimuli are
responsible for fluctuations in a broadcast
scalar error signal, an agent may learn inappropriately, for example, it may learn to
approach food when it is actually thirsty.

Dopamine neurons emit an excellent appetitive error (teaching) signal without indicating further details about the appetitive
event. It is therefore likely that other reward-processing structures subserve the
analysis and discrimination of appetitive
events without constituting particularly efficient teaching signals. This putative division of labor between the analysis of physical and functional attributes and scalar

a single weight to each cue limits this “creature” to a one time step prediction on the
basis of its current state. After experiencing
each type of object multiple times, the
weights reflect the relative amounts of reward in each object, that is, _wb_ - _wg_ - _wr_ .
These three weights equip the creature with
a kind of cognitive map or “value surface”
with which to assay its possible actions (Fig.
4B).
The value surface above the arena is a
plot of the value function _V_ ( _x_, _y_ ) (height)
when the creature is placed in the indicated
corner and looks at every position ( _x_, _y_ ) in
the arena. The value _V_ ( _x_, _y_ ) of looking at
each position ( _x_, _y_ ) is computed as a linear
function of the weights ( _w_ b, _w_ g, _w_ r) associated with activity induced in the colorsensitive units. As this “creature” changes
its direction of gaze from one position ( _x_ 0,
_y_ 0) at time _t_ to another position ( _x_ 1, _y_ 1) at
time _t_ - 1, the difference in the values of
these two positions _V_ ( _t_ - 1) - _V_ ( _t_ ) is
available as the output �( _t_ ) of the prediction neuron P. In this example, when the
creature looks from point 1 to point 2, the
percentage of blue in its visual field increases. This increase is available as a positive
fluctuation (“things are better than expected”) in the output �( _t_ ) of neuron P. Similarly, looking from point 2 to point 1 causes
a large negative fluctuation in �( _t_ ) (“things
are worse than expected”). As discussed
above, these fluctuations could be used by
some target structure to decide whether to
move in the direction of sight. Directions
associated with a positive prediction error
are likely to yield increased future returns.

This example illustrates how only three
stored quantities (weights associated with
each color) and the capacity to look at
different locations endow this simple “creature” with a useful map of the quality of
different directions in the arena. This same
model has been given simple card-choice
tasks analogous to those given to humans
( _26_ ), and the model matches well the human behavior. It is also interesting that
humans develop a predictive galvanic skin
response that predicts appropriately which
card decks are good and which are bad ( _26_ ).

**Summary and Future Questions**

We have reviewed evidence that supports
the proposal that dopamine neurons in the
VTA and the substantia nigra report ongoing prediction errors for reward. The output
of these neurons is consistent with a scalar
prediction error signal; therefore, the delivery of this signal to target structures may
influence the processing of predictions and
the choice of reward-maximizing actions.
These conclusions are supported by data on
the activity changes of these neurons during

the acquisition and expression of a range of
simple conditioning tasks. This representation of the experimental data raises a number of important issues for future work.

The first issue concerns temporal representations, that is, how is any stimulus represented through time? A large body of
behavioral data show that animals can keep
track of the time elapsed from the presentation of a CS and make precise predictions
accordingly. We adopted a very simple
model of this capacity, but experiments
have yet to suggest where or how the temporal information is constructed and used
by the brain. It is not yet clear how far into
the future such predictions can be made;
however, one suspects that they will be
longer than the predictions made by structures that mediate cerebellar eyeblink conditioning and motor learning displayed by
the vestibulo-ocular reflex ( _27_ ). The time
scales that are ethologically important to a
particular creature should provide good
constraints when searching for mechanisms
that might construct and distribute temporal labels in the cerebral cortex.

A second issue is information about
aversive events. The experimental data suggest that the dopamine system provides information about appetitive stimuli, not
aversive stimuli. It is possible however that
the absence of an expected reward is interpreted as a kind of “punishment” to some
other system to which the dopamine neurons send their output. It would then be the

**A**

be easily built and used. ( **A** ) Architecture of the TD model. Three col

selection

The colored blocks contain varying

ry cue, the model can make only

er, combined with its capacity to
move its head or walk about the

able in the output �( _t_ ) of neuron P.

the corner as indicated. The height
of the surface codes for the value
_V_ ( _x_, _y_ ) of each location when viewed
from the corner where the “creature” is positioned. All the creature

tion to another (or move from one
position to another), and the differences in value _V_ ( _t_ - 1) � _V_ ( _t_ ) are coded in the changes in the firing rate
of P (see text).

Biased�

Reward

action�
selection

**1597**
http://www.sciencemag.org � SCIENCE � VOL. 275 � 14 MARCH 1997

12. P. R. Montague, P. Dayan, T. J. Sejnowski, _J. Neu-_
_rosci._ 16, 1936 (1996).
13. Other work has suggested an interpretation of
monoaminergic influences similar to that taken
above ( _8_   - _12_ ) [K. J. Friston, G. Tononi, G. N. Reeke,
O. Sporns, G. M. Edelman, _Neuroscience_ 59, 229
(1994); J. C. Houk, J. L. Adams, A. G. Barto, in
_Models of Information Processing in the Basal Gan-_
_glia_, J. C. Houk, J. L. Davis, D. G. Beiser, Eds. (MIT
Press, Cambridge, MA, 1995)], pp. 249–270. Other
models of monoaminergic influences have considered what could be called attention-based accounts
( _4_ ) rather than prediction error–based explanations

[D. Servan-Schreiber, H. Printz, J. D. Cohen, _Sci-_
_ence_ 249, 892 (1990)].
14. G. F. Koob, _Semin._ _Neurosci._ 4, 139 (1992); R. A.
Wise and D. C. Hoffman, _Synapse_ 10, 247 (1992); G.
DiChiara, _Drug Alcohol Depend._ 38, 95 (1995).
15. A. G. Phillips, S. M. Brooke, H. C. Fibiger, _Brain Res._
85, 13 (1975); A. G. Phillips, D. A. Carter, H. C.
Fibiger, _ibid._ 104, 221 (1976); F. Mora and R. D.
Myers, _Science_ 197, 1387 (1977); A. G. Phillips, F.
Mora, E. T. Rolls, _Psychopharmacology_ 62, 79
(1979); D. Corbett and R. A. Wise, _Brain Res._ 185, 1
(1980); R. A. Wise and P.-P. Rompre, _Annu._ _Rev._
_Psychol._ 40, 191 (1989).
16. Beninger,R. A. Wise, _Brain Res. Rev.Behav._ _Brain_ 6, 173 (1983); _Sci._ 5, 39 (1982);����R.andJ.
B. L. Hahn, _Science_ 220, 1304 (1983); R. J. Beninger, _Brain Res. Bull._ 23, 365 (1989); M. LeMoal and
H. Simon, _Physiol. Rev._ 71, 155 (1991); T. W. Robbins and B. J. Everitt, _Semin._ _Neurosci._ 4, 119
(1992).
17. W. Schultz, _J._ _Neurophysiol._ 56, 1439 (1986); R.
Romo and W. Schultz, _ibid._ 63, 592 (1990); W.
Schultz and R. Romo, _ibid._, p. 607; T. Ljungberg, P.
Apicella, W. Schultz, _ibid._ 67, 145 (1992); W.
Schultz, P. Apicella, T. Ljungberg, _J._ _Neurosci._ 13,
900 (1993); J. Mirenowicz and W. Schultz, _J._ _Neu-_
_rophysiol._ 72, 1024 (1994); W. Schultz _et al_ ., in _Mod-_
_els of Information Processing in the Basal Ganglia_, J.
C. Houk, J. L. Davis, D. G. Beiser, Eds. (MIT Press,
Cambridge, MA, 1995), pp. 233–248; J. Mirenowicz
and W. Schultz, _Nature_ 379, 449 (1996).
18. Recent experiments showed that the simple displacement of the time of reward delivery resulted in dopamine responses. In a situation in which neurons were
not driven by a fully predicted drop of juice, activations
reappeared when the juice reward occurred 0.5 s
earlier or later than predicted. Depressions were observed at the normal time of juice reward only if reward
delivery was late [J. R. Hollerman and W. Schultz,
_Soc. Neuroci. Abstr._ 22, 1388 (1996)].
19. G. Tesauro, _Commun._ _ACM_ 38, 58 (1995); D. P.
Bertsekas and J. N. Tsitsiklis, _Neurodynamic_ _Pro-_
_gramming_ (Athena Scientific, Belmont, NJ, 1996).
20. R. M. Church, in _Contemporary_ _Learning_ _Theories:_
_Instrumental Conditioning Theory and the Impact of_
_Biological Constraints on Learning_, S. B. Klein and R.
R. Mowrer, Eds. (Erlbaum, Hillsdale, NJ, 1989), p.
41; J. Gibbon, _Learn. Motiv._ 22, 3 (1991).
21. S. Grossberg and N. A. Schmajuk, _Neural Networks_
2, 79 (1989); S. Grossberg and J. W. L. Merrill, _Cog-_
_nit. Brain Res._ 1, 3 (1992).
22. P. Dayan, _Mach. Learn._ 8, 341 (1992); P. Dayan and
T. J. Sejnowski, _ibid._ 14, 295 (1994); T. Jaakkola, M.
I. Jordan, S. P. Singh, _Neural Computation_ 6, 1185
(1994).
23. R. E. Bellman, _Dynamic_ _Programming_ (Princeton
Univ. Press, Princeton, NJ, 1957); R. A. Howard,
_Dynamic Programming and Markov Processes_ (MIT
Press, Cambridge, MA, 1960).
24. A. G. Barto, R. S. Sutton, C. W. Anderson, _IEEE_
_Trans. Syst. Man Cybernetics_ 13, 834 (1983).
25. Bacterial klinokinesis has been described in great
detail. Early work emphasized the mechanisms required for bacteria to climb gradients of nutrients.
See R. M. Macnab and D. E. Koshland, _Proc._ _Natl._
_Acad._ _Sci._ _U.S.A._ 69, 2509 (1972); N. Tsang, R.
Macnab, D. E. Koshland Jr., _Science_ 181, 60 (1973);
H. C. Berg and R. A. Anderson, _Nature_ 245, 380
(1973); H. C. Berg _ibid._ 254, 389 (1975); J. L. Spudich and D. E. Koshland, _Proc._ _Natl._ _Acad._ _Sci._
_U.S.A._ 72, 710 (1975). The klinokinetic action-selection mechanism causes a TD model to climb hills

evaluation signals raises a fourth issue—
attention.

The model does not address the attentional functions of some of the innervated
structures, such as the nucleus accumbens
and the frontal cortex. Evidence suggests
that these structures are important for cases
in which different amounts of attention are
paid to different stimuli. There is, however,
evidence to suggest that the required attentional mechanisms might also operate at
the level of the dopamine neurons. Their
responses to novel stimuli will decrement
with repeated presentation and they will
generalize their responses to nonappetitive
stimuli that are physically similar to appetitive stimuli ( _29_ ). In general, questions
about attentional effects in dopaminergic
systems are ripe for future work.

The suggestions that a scalar predictionerror signal influences behavioral choices
receives support from the preliminary work
on human decision-making and from the
fact that changes in dopamine activity fluctuations parallel changes in the behavioral
performance of the monkeys ( _30_ ). In the
mammalian brain, the striatum is one site
where this kind of scalar evaluation could
have a direct effect on action choice, and
activity relating to conditioned stimuli is
seen in the striatum ( _31_ ). The widespread
projection of dopamine axons to striatal
neurons gives rise to synapses at dendritic
spines that are also contacted by excitatory
inputs from cortex ( _32_ ). This may be a site
where the dopamine signal influences behavioral choices by modulating the level of
competition in the dorsal striatum. Phasic
dopamine signals may lead to an augmentation of excitatory influences in the striatum ( _33_ ), and there is evidence for striatal
plasticity after pulsatile application of dopamine ( _34_ ). Plasticity could mediate the
learning of appropriate policies ( _24_ ).

The possibilities in the striatum for using
a scalar evaluation signal carried by changes
in dopamine delivery are complemented by
interesting possibilities in the cerebral cortex. In prefrontal cortex, dopamine delivery
has a dramatic influence on working memory ( _35_ ). Dopamine also modulates cognitive activation of anterior cingulate cortex
in schizophenic patients ( _36_ ). Clearly, dopamine delivery has important cognitive
consequences at the level of the cerebral
cortex. Under the model presented here,
changes in dopaminergic activity distribute
prediction errors to widespread target structures. It seems reasonable to require that the
prediction errors be delivered primarily to
those regions most responsible for making
the predictions; otherwise, one cortical region would have to deal with prediction
errors engendered by the bad guesses of
another region. From this point of view,

one could expect there to be a mechanism
that coupled local activity in the cortex to
an enhanced sensitivity of nearby dopamine
terminals to differences from baseline in
spike production along their parent axon.
There is experimental evidence that supports this possibility ( _37_ ).

Neuromodulatory systems like dopamine
systems are so named because they were
thought to modulate global states of the
brain at time scales and temporal resolutions much poorer than other systems like
fast glutamatergic connections. Although
this global modulation function may be accurate, the work discussed here shows that
neuromodulatory systems may also deliver
precisely timed information to specific target structures to influence a number of important cognitive functions.

**REFERENCES** **AND** **NOTES**
**___________________________**

1. A. Dickinson, _Contemporary Animal Learning Theory_
(Cambridge Univ. Press, Cambridge, 1980); N. J.
Mackintosh, _Conditioning_ _and_ _Associative_ _Learning_
(Oxford Univ. Press, Oxford, 1983); C. R. Gallistel,
_The_ _Organization_ _of_ _Learning_ (MIT Press, Cambridge, MA, 1990); L. A. Real, _Science_ 253, 980
(1991).
2. I. P. Pavlov, _Conditioned_ _Reflexes_ (Oxford Univ.
Press, Oxford, 1927); B. F. Skinner, _The Behavior of_
_Organisms_ (Appleton-Century-Crofts, New York,
1938); J. Olds, _Drives_ _and_ _Reinforcement_ (Raven,
New York 1977); R. A. Wise, in _The_ _Neuropharma-_
_cological Basis of Reward_, J. M. Liebeman and S. J.
Cooper, Eds. (Clarendon Press, New York, 1989); N.
W. White and P. M. Milner, _Annu. Rev. Psychol._ 43,
443 (1992); T. W. Robbins and B. J. Everitt, _Curr._
_Opin. Neurobiol._ 6, 228 (1996).
3. R. A. Rescorla and A. R. Wagner, in _Classical_ _Con-_
_ditioning_ _II:_ _Current_ _Research_ _and_ _Theory_, A. H.
Black and W. F. Prokasy, Eds. (Appleton-CenturyCrofts, New York, 1972), pp. 64–69.
4. N. J. Mackintosh, _Psychol. Rev._ 82, 276 (1975); J. M.
Pearce and G. Hall, _ibid._ 87, 532 (1980).
5. L. J. Kamin, in _Punishment and Aversive Behavior_, B.
A. Campbell and R. M. Church, Eds. (Appleton-Century-Crofts, New York (1969), pp. 279–296.
6. R. S. Sutton and A. G. Barto, _Psychol._ _Rev._ 88 (no.
2), 135 (1981); R. S. Sutton, _Mach._ _Learn._ 3, 9
(1988).
7. R. S. Sutton and A. G. Barto, _Proceedings_ _of_ _the_
_Ninth_ _Annual_ _Conference_ _of_ _the_ _Cognitive_ _Science_
_Society_ (Seattle, WA, 1987); in _Learning_ _and_ _Com-_
_putational_ _Neuroscience_, M. Gabriel and J. Moore,
Eds. (MIT Press, Cambridge, MA, 1989). For specific
application to eyeblink conditioning, see J. W. Moore
_et al_ ., _Behav. Brain Res._ 12, 143 (1986).
8. S. R. Quartz, P. Dayan, P. R. Montague, T. J. Sejnowski, _Soc. Neurosci. Abstr._ 18, 1210 (1992); P. R.
Montague, P. Dayan, S. J. Nowlan, A. Pouget, T. J.
Sejnowski, in _Advances_ _in_ _Neural_ _Information_ _Pro-_
_cessing Systems 5_, S. J. Hanson, J. D. Cowan, C. L.
Giles, Eds. (Morgan Kaufmann, San Mateo, CA,
1993), pp. 969–976.
9. P. R. Montague, P. Dayan, T. J. Sejnowski, in _Ad-_
_vances in Neural Information Processing Systems 6_,
G. Tesauro, J. D. Cowan, J. Alspector, Eds. (Morgan
Kaufmann, San Mateo, CA, 1994), pp. 598–605.
10. P. R. Montague and T. J. Sejnowski, _Learn. Mem._ 1,
1 (1994); P. R. Montague, _Neural-Network_ _Ap-_
_proaches to Cognition—Biobehavioral Foundations_,
J. Donahoe, Ed. (Elsevier, Amsterdam, in press); P.
R. Montague and P. Dayan, _A Companion to Cogni-_
_tive_ _Science_, W. Bechtel and G. Graham, Eds.
(Blackwell, Oxford, in press).
11. P. R. Montague, P. Dayan, C. Person, T. J. Sejnowski, _Nature_ 377, 725 (1995).

**1598**
SCIENCE � VOL. 275 � 14 MARCH 1997 � http://www.sciencemag.org

**<mark>ARTICLES</mark>**

defined by the sensory weights, that is, the model will
climb the surface defined by the value function _V_ .
26. A. R. Damasio, _Descartes’ Error_ (Putnam, New York,
1994); A. Bechara, A. R. Damasio, H. Damasio, S.
Anderson, _Cognition_ 50, 7 (1994).
27. S. P. Perrett, B. P. Ruiz, M. D. Mauk _J. Neurosci._ 13,
1708 (1993); J. L. Raymond, S. G. Lisberger, M. D.
Mauk _Science_ 272, 1126 (1996).
28. S. Grossberg, _Math._ _Biosci._ 15, 253 (1972); R. L.
Solomon and J. D. Corbit, _Psychol._ _Rev._ 81, 119
(1974); S. Grossberg, _ibid._ 89, 529 (1982).
29. W. Schultz and R. Romo, _J._ _Neurophysiol._ 63, 607
(1990); T. Ljungberg, P. Apicella, W. Schultz, _ibid._
67, 145 (1992); J. Mirenowicz and W. Schultz, _Na-_
_ture_ 379, 449 (1996).
30. W. Schultz, P. Apicella, T. Ljungberg, _J._ _Neurosci._
13, 900 (1993).
31. T. Aosaki _et al_ ., _ibid._ 14, 3969 (1994); A. M. Graybiel
_Curr. Opin. Neurobiol._ 5, 733 (1995); _Trends Neuro-_
_sci._ 18, 60 (1995). Recent models of sequence generation in the striatum use fluctuating dopamine input as a scalar error signal [G. S. Berns and T. J.
Sejnowski, in _Neurobiology_ _of_ _Decision_ _Making_, A.

defined by the sensory weights, that is, the model will Damasio, Ed. (Springer-Verlag, Berlin, 1996), pp. along their parent axon. This may result from local
climb the surface defined by the value function _V_ . 101–113. increases in nitric oxide production. In this manner,
A. R. Damasio, _Descartes’ Error_ (Putnam, New York, 32. T. F. Freund, J. F. Powell, A. D. Smith, _Neuroscience_ baseline dopamine release remains constant in inac1994); A. Bechara, A. R. Damasio, H. Damasio, S. 13, 1189 (1984); Y. Smith, B. D. Bennett, J. P. Bo- tive cortical areas while active cortical areas feel
Anderson, _Cognition_ 50, 7 (1994). lam, A. Parent, A. F. Sadikot, _J. Comp. Neurol._ 344, strongly the effect of increases and decreases in
S. P. Perrett, B. P. Ruiz, M. D. Mauk _J. Neurosci._ 13, 1 (1994). dopamine delivery due to increases and decreases
1708 (1993); J. L. Raymond, S. G. Lisberger, M. D. 33. C. Cepeda, N. A. Buchwald, M. S. Levine, _Proc. Natl._ in spike production along the parent dopamine axon.
Mauk _Science_ 272, 1126 (1996). _Acad. Sci. U. S. A._ 90, 9576 (1993). 38. We thank A. Damasio and T. Sejnowski for comS. Grossberg, _Math._ _Biosci._ 15, 253 (1972); R. L.

34. J. R. Wickens, A. J. Begg, G. W. Arbuthnott, _Neuro-_ ments and criticisms, and C. Person for help in

Solomon and J. D. Corbit, _Psychol._ _Rev._ 81, 119

_science_ 70, 1 (1996). generating figures. The theoretical work received

(1974); S. Grossberg, _ibid._ 89, 529 (1982).
W. Schultz and R. Romo, _J._ _Neurophysiol._ 63, 607 35. P. S. Goldman-Rakic, C. Leranth, M. S. Williams, N. continuing support from the Center for Theoretical
(1990); T. Ljungberg, P. Apicella, W. Schultz, _ibid._ Mons, M. Geffard, _Proc. Natl. Acad. Sci. U.S.A._ 86, Neuroscience at Baylor College of Medicine and
67, 145 (1992); J. Mirenowicz and W. Schultz, _Na-_ 9015 (1989); T. Sawaguchi and P. S. Goldman-Ra- the National Institutes of Mental Health (NIMH)
_ture_ 379, 449 (1996). kic, _Science_ 251, 947 (1991); G. V. Williams and P. (P.R.M.). P.D. was supported by Massachusetts
W. Schultz, P. Apicella, T. Ljungberg, _J._ _Neurosci._ S. Goldman-Rakic, _Nature_ 376, 572 (1995). Institute of Technology and the NIH. The primate
13, 900 (1993). 36. R. J. Dolan _et al_ ., _Nature_, 378 180 (1995). studies were supported by the Swiss National SciT. Aosaki _et al_ ., _ibid._ 14, 3969 (1994); A. M. Graybiel 37. P. R. Montague, C. D. Gancayco, M. J. Winn, R. B. ence Foundation, the McDonnell-Pew Foundation
_Curr. Opin. Neurobiol._ 5, 733 (1995); _Trends Neuro-_ Marchase, M. J. Friedlander, _Science_ 263, 973 (Princeton), the Fyssen Foundation (Paris), the Fon_sci._ 18, 60 (1995). Recent models of sequence gen- (1994). The mechanistic suggestion requires that lo- dation pour la Recherche Midicale (Paris), the Uniteration in the striatum use fluctuating dopamine in- cal cortical activity (presumably glutamatergic) in- ed Parkinson Foundation (Chicago), the Roche Reput as a scalar error signal [G. S. Berns and T. J. creases the sensitivity of nearby dopamine terminals search Foundation (Basel), the NIMH (Bethesda),
Sejnowski, in _Neurobiology_ _of_ _Decision_ _Making_, A. to differences from baseline in spike production and the British Council.

that can be produced or understood; and
# Language Acquisition and Use: reasoning capacities used in comprehending

Damasio, Ed. (Springer-Verlag, Berlin, 1996), pp.
101–113.
32. T. F. Freund, J. F. Powell, A. D. Smith, _Neuroscience_
13, 1189 (1984); Y. Smith, B. D. Bennett, J. P. Bolam, A. Parent, A. F. Sadikot, _J. Comp. Neurol._ 344,
1 (1994).
33. C. Cepeda, N. A. Buchwald, M. S. Levine, _Proc. Natl._
_Acad. Sci. U. S. A._ 90, 9576 (1993).
34. J. R. Wickens, A. J. Begg, G. W. Arbuthnott, _Neuro-_
_science_ 70, 1 (1996).
35. P. S. Goldman-Rakic, C. Leranth, M. S. Williams, N.
Mons, M. Geffard, _Proc. Natl. Acad. Sci. U.S.A._ 86,
9015 (1989); T. Sawaguchi and P. S. Goldman-Rakic, _Science_ 251, 947 (1991); G. V. Williams and P.
S. Goldman-Rakic, _Nature_ 376, 572 (1995).
36. R. J. Dolan _et al_ ., _Nature_, 378 180 (1995).
37. P. R. Montague, C. D. Gancayco, M. J. Winn, R. B.
Marchase, M. J. Friedlander, _Science_ 263, 973
(1994). The mechanistic suggestion requires that local cortical activity (presumably glutamatergic) increases the sensitivity of nearby dopamine terminals
to differences from baseline in spike production

# **Learning and Applying** **Probabilistic Constraints**

Mark S. Seidenberg

What kinds of knowledge underlie the use of language and how is this knowledge acquired? Linguists equate knowing a language with knowing a grammar. Classic “poverty
of the stimulus” arguments suggest that grammar identification is an intractable inductive
problem and that acquisition is possible only because children possess innate knowledge
of grammatical structure. An alternative view is emerging from studies of statistical and
probabilistic aspects of language, connectionist models, and the learning capacities of
infants. This approach emphasizes continuity between how language is acquired and how
it is used. It retains the idea that innate capacities constrain language learning, but calls
into question whether they include knowledge of grammatical structure.

### M odern thinking about language has been

dominated by the views of Noam Chomsky,
who created the generative paradigm within which most research has been conducted
for over 30 years ( _1_ ). This approach continues to flourish ( _2_ ), and although alternative theories exist, they typically share
Chomsky’s assumptions about the nature of
language and the goals of linguistic theory
( _3_ ). Research on language has arrived at a
particularly interesting point, however, because of important developments outside of
the linguistic mainstream that are converging on a different view of the nature of
language. These developments represent an
important turn of events in the history of
ideas about language.

**The Standard Theory**

The place to begin is with Chomsky’s classic questions ( _4_ ): (i) what constitutes
knowledge of a language, (ii) how is this
knowledge acquired, and (iii) how is it put

to use? The standard theory provides the
following answers ( _1–5_ ).

In answer to the first question, what one
knows is a grammar, a complex system of
rules and constraints that allows people to
distinguish grammatical from ungrammatical sentences. The grammar is an idealization that abstracts away from a variety of
so-called performance factors related to language use. The Competence Hypothesis is
that this idealization will facilitate the identification of generalizations about linguistic
knowledge that lie beneath overt behavior,
which is affected by many other factors.
Many phenomena that are prominent characteristics of language use are therefore set
aside. The clear cases that are often cited in
separating competence from performance
include dysfluencies and errors. In practice,
however, the competence theory also excludes other factors that affect language use,
including the nature of the perceptual and
motor systems that are used; memory capacities that limit the complexity of utterances

that can be produced or understood; and
reasoning capacities used in comprehending
text or discourse. The competence theory
also excludes information about statistical
and probabilistic aspects of language—for
example, the fact that verbs differ in how
often they occur in transitive and intransitive sentences (“John ate the candy” versus
“John ate,” respectively), or the fact that
when the subject of the verb “break” is
animate, it is typically the agent of the
action, but when it is inanimate, it is typically the entity being broken (compare
“John broke the glass” with “The glass
broke”). That this information should be
excluded was the point of Chomsky’s famous sentence “Colorless green ideas sleep
furiously” and the accompanying observation that, “I think that we are forced to
conclude that . . . probabilistic models give
no particular insight into some of the basic
problems of syntactic structure” ( _6_ ). Finally,
the competence theory also disregards the
communicative functions of language and
how they are achieved. These aspects of
language are acknowledged as important
but considered separable from core grammatical knowledge.

The grammar’s essential properties include generativity (it can be used to produce and comprehend an essentially infinite number of sentences); abstractness of
structure (it uses representations that are
not overtly marked in the surface forms of
utterances); modularity (the grammar is organized into components with different
types of representations governed by different principles); and domain specificity (language exhibits properties that are not seen
in other aspects of cognition; therefore, it
cannot be an expression of general capacities to think and to learn).

The second question regarding language

Neuroscience Program, University of Southern California,
Los Angeles, CA 90089–2520, USA. E-mail: marks@
gizmo.usc.edu

**1599**
http://www.sciencemag.org � SCIENCE � VOL. 275 � 14 MARCH 1997
