---
title: "Each Neuron Gets Its Own Gradient"
source: "https://artemkirsanov.substack.com/p/each-neuron-gets-its-own-gradient"
author:
  - "[[Artem Kirsanov]]"
published: 2026-03-02
created: 2026-09-01
description: "How a brain-computer interface experiment revealed vectorized error signals in cortical dendrites"
tags:
  - "clippings"
---
For the past few weeks I’ve been reading a lot on the role of dendrites in providing a substrate for biologically plausible alternatives to backpropagation in the brain, but most of what I was finding were theoretical ideas or computational models.

It looked like a very elegant idea: since top-down connections are known to preferentially target apical dendrites, it makes perfect sense that something about apical dendrite activity could play the role of a teaching signal. Yet, there was no direct experimental evidence. That is, until this week...

When I woke up Thursday morning and checked my feeds, I saw a paper with a title I couldn’t believe: “Vectorized instructive signals in cortical dendrites” [(Francioni et al., Nature 2026)](https://www.nature.com/articles/s41586-026-10190-7). I decided to read it over breakfast, but the Nature website went down for about 20 minutes. I guess I wasn’t the only one who couldn’t wait.

So, why is this such a big deal?

## The Elephant in a Room

Trying to study learning algorithms *in vivo* has a massive problem. We need to know the **objective function** of the brain, and how individual neurons contribute to that objective. Without that, we can’t compare what kind of credit signals arrive at a given neuron against what any algorithm would predict.

But we never really know the exact objective. Even during a well-defined task like visual discrimination, the individual neurons in visual cortex might be encoding some task-relevant latent variable we can’t pick up, an attentional state, or something else entirely. There is no ground-truth error signal to search for.

> 💡 There is one exception: **brain-computer interface (BCI) learning.** In a BCI task, neural activity is recorded in real time and mapped directly to task performance. The experimenter defines the mapping, which means the experimenter *knows* the reward function. This is the key insight that makes the whole paper possible.

## Experimental setup

Francioni et al. trained mice to control the orientation of a visual grating on a screen. But instead of a lever or joystick, the mice learned to modulate activity of neurons in their retrosplenial cortex (a region involved in spatial processing). Two groups of 4-5 neurons were designated as P+ (activity rotates the grating toward the target) and P- (activity rotates it away). The mice received visual feedback and rewards, and through trial and error their neural activity patterns shifted to boost P+ and suppress P- activity. This means the experimenters knew exactly how each neuron’s activity mapped to error!

Interestingly, the mice solved the task primarily by *suppressing* P- neurons while P+ neurons maintained their activity levels, an energy-efficient “learning by sparsification” strategy.

## Teaching signals on dendrites

While the mice learned, the researchers used two-photon imaging to simultaneously record calcium signals from the cell bodies (a proxy for neural activity) *and* the apical dendrites of the same neurons. For coincident calcium events detected in both compartments, they measured whether the dendritic signal was relatively amplified or attenuated compared to what the soma alone would predict (based on the linear relationship between somatic and dendritic event magnitudes for that neuron). They called this mismatch the **somato-dendritic (SD) residual**.

Here is where it gets interesting. The SD residuals encoded reward and trial outcome. And most importantly, they were **vectorized**: P+ neurons received one type of dendritic signal during error reduction (amplification) while P- neurons received the opposite (attenuation). Different neurons got different teaching signals tailored to their specific causal role in the task.

![](https://substackcdn.com/image/fetch/$s_!6q8D!,w_1456,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F18219acf-d3d9-4063-98d5-29f8891fd55e_1200x700.png)

This is consistent with the kind of neuron-specific feedback that algorithms like backpropagation and target propagation require: not a single scalar "good/bad" broadcast to everyone, but a signed, neuron-specific signal that tells each cell which direction to change.

The team also tested causality. They optogenetically activated NDNF+ inhibitory interneurons in layer 1 that specifically target apical dendrites. This abolished the vectorized error signals, and the mice stopped learning.

## What this means

For the first time, we have direct experimental evidence that cortical dendrites carry **neuron-specific instructive signals during learning**, and that disrupting them blocks learning. The brain appears to solve credit assignment by spatially segregating feedforward and feedback streams: bottom-up input arrives at the soma, top-down teaching signals arrive at the apical tuft. No need for the biologically implausible temporal separation that backpropagation uses in artificial networks.

The exact algorithm remains an open question, as the authors didn’t monitor the actual changes to synaptic weights (extremely hard to do in vivo). But at the very least, we can now rule out models where a scalar broadcast signal (like global dopamine) serving as a third factor in Hebbian-style plasticity rules is the only source of credit information. Something more structured: **vectorized and tailored to each neuron is reaching the apical dendrites.**

It’s also worth noting that the BCI task is essentially a one-layer problem: P+ and P- neurons directly control the output. The real challenge for credit assignment is in multi-layer networks, where a neuron’s contribution to task performance is indirect. Whether dendritic teaching signals can solve credit assignment across a hierarchy of cortical areas is the natural next question, and the BCI framework is well-positioned to test it.

That is what makes the BCI paradigm so exciting for probing learning in biological brains!

Until next week,

artem