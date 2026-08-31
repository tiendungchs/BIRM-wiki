---
title: "Every Spike Rewires the Rule"
source: "https://artemkirsanov.substack.com/p/every-spike-rewires-the-rule"
author:
  - "[[Artem Kirsanov]]"
published: 2026-02-23
created: 2026-09-01
description: "Synaptic plasticity is messier than textbook models suggest"
tags:
  - "clippings"
---
Last week we talked about the firing rate fallacy: the idea that the brain probably isn't counting spikes, but relying on their precise relative timing. If that's true, it raises a natural follow-up question: **how does the brain learn with individual spikes?**

The standard answer is **Spike-Timing Dependent Plasticity (STDP)**, a rule that adjusts the strength of a synapse based on the relative timing of spikes in the two neurons it connects.

> If neuron A fires just *before* neuron B, the synapse A→B gets stronger (Long-Term Potentiation). If A fires just *after* B, the synapse gets weaker (Long-Term Depression). The closer the two spikes are in time, the larger the effect.

You can think of it as an extension of the old Hebbian idea (“neurons that fire together wire together”) but with a crucial temporal twist. It’s not just that they fire together, it’s *who fired first*. Causality matters.

![](https://substackcdn.com/image/fetch/$s_!CXcY!,w_1456,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Fb1981142-fd56-470b-a53c-5a0de5845849_1200x700.png)

Mathematically, this is captured by a pair of exponential decays centered around zero delay. Positive delays (pre before post) result in weight potentiation that decays with time lag; negative delays (post before pre) give weight depression that also decays with time. The exact shape of this curve – the "STDP kernel" – has been measured in cortical slices and turns out to be asymmetric. The potentiation side is stronger but narrow, while the depression side is weaker but lingers longer. This asymmetry seems to matter, but it's not the main point today.

The main point is what happens when you move beyond textbook spike *pairs*.

## Interactions start to matter

Most descriptions of STDP show you two neurons, two spikes, one clean delay **Δt**. But real neurons don’t politely take turns. In a functioning brain, both sides of a synapse are firing complex trains of spikes, creating a mess of different pre-post pairs.

So how do you compute the total weight change? How to assign the pairing between pre and post spikes to calculate **Δt**?

The dominant assumption was simple: **take every possible pair** of pre and post spikes, compute the STDP effect for each, and add them up. **Every pair contributes independently.**

In 2002, Robert Froemke and Yang Dan [tested](https://www.nature.com/articles/416433a) this directly. They took cortical neurons (rat visual cortical slices) and stimulated different pairs of cells with carefully constructed **spike triplets** (two spikes on one side, one on the other) and **quadruplets**, then measured the actual synaptic change.

The results did not match the independent model. Not even close.

## The Suppression Rule

What Froemke and Dan found was that **the first spike in a sequence dominates**. If a neuron fires twice in quick succession, the second spike contributes almost nothing to plasticity. It’s as if the neuron’s capacity to induce learning temporarily shuts down after each spike and needs time to recover.

They formalized this with a simple mechanism. Each neuron (pre and post) carries an internal "efficacy" variable between 0 and 1. When the neuron spikes, its efficacy drops to zero. It then recovers exponentially back toward 1 with a time constant on the order of tens of milliseconds (~34 ms on the presynaptic side, ~75 ms on the postsynaptic side).

The weight change for any spike pair is then just the standard STDP value *scaled* by the efficacies of both spikes involved. First spikes in a train have efficacy near 1, so they drive learning normally. Spikes that follow quickly after have efficacy near 0, so their contribution is suppressed.

$$
\Delta W = \underset{i , j}{\sum} \underset{\text{suppression}}{\underbrace{\epsilon_{i}^{\text{pre}} \cdot \epsilon_{j}^{\text{post}}}} \cdot F \left(\Delta t_{i j}\right)
$$

Here **F(Δt)** is the standard STDP window with two exponentials and **ε** is the recovery efficacy of each spike (0 right after firing, exponentially recovering toward 1). The summation runs over all pre-post spike pairs, but because **ε** drops to zero after each spike, the first pair dominates and the rest are suppressed.

This one modification of multiplying by a recovery variable on each side was enough to explain the experimental triplet and quadruplet data that the independent model couldn't.

## Why this matters

But this is just one nonlinearity in what is almost certainly a much more complex picture. The real brain has neuromodulators gating learning on and off, homeostatic mechanisms rescaling weights globally, and plasticity rules that depend on dendritic location. How all of these interact across timescales is still largely unknown.

This matters beyond neuroscience too. While modern deep learning optimizers can accumulate gradient history, but each update still acts on the system independently and it doesn’t reshape the networks’s ability to learn from the next one. If biology is telling us that the *interactions* between updates matter as well, then there might be a class of more powerful learning rules we haven’t explored yet because they don’t fit the independent-update assumption baked into current frameworks...

Until next week,

artem