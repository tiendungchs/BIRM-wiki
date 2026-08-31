---
title: "The Firing Rate Fallacy"
source: "https://artemkirsanov.substack.com/p/the-firing-rate-fallacy"
author:
  - "[[Artem Kirsanov]]"
published: 2026-02-16
created: 2026-09-01
description: "Neurons are not Geiger counters."
tags:
  - "clippings"
---
There is one assumption that underpins modern AI and almost all computational neuroscience. It is the belief that the fundamental “currency” of the brain is the **firing rate**.

In Deep Learning, we treat the output of a neuron as a real number (like 0.7 or 12.8). We hand-wave this as “some measure of activity” because we need the system to be differentiable and compatible with floating-point operations.

But when we try to ground this in biology, we run into a problem.

Real neurons don’t send continuous numbers. They send discrete pulses called **spikes**. To turn these spikes into the smooth numbers we use in analysis, we assume the neuron acts like a Geiger counter ⚡

The mental model goes like this: The neuron has an internal analog state (the “true” rate, encoded in the cell’s physiological state like membrane voltage or calcium gradients), and the **spikes are just random samples drawn from that rate, like a Poisson process.** To “read” the message, the downstream neuron must listen for a while and count the clicks to estimate the average rate.

![](https://substackcdn.com/image/fetch/$s_!92vf!,w_1456,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Ffba4e0df-a282-4864-aa38-98ce549fb299_1200x700.png)

This model makes the math work. It unlocks quantitative analyses like dimensionality reduction or decoding. But when you look at the physical constraints of the brain, the "Geiger Counter" logic falls apart.

## 1) The Speed Limit (Latency)

The first problem is the speed of processing in the brain.

We know that human visual object recognition occurs in roughly **150 milliseconds**. We also know this signal passes through a hierarchy of about 10 processing stages (Retina to LGN to V1 to V2, and so on) (Thorpe, Fize & Marlot 1996)

This leaves a strict budget: **10 to 15 milliseconds per layer.**

Given the relatively low firing rates of cortical neurons, this creates a fundamental sampling problem.

A downstream neuron will statistically observe either zero spikes or, rarely, one or two, during this time window. It is mathematically impossible to reliably estimate the firing rate from 1–2 spikes. The variance of the estimator is simply too high.

## 2) The Moving World (Non-stationarity)

Rate coding also implicitly assumes the input stays constant long enough for the neuron to reach a steady state and for the receiver to count the spikes.

But the real world is not static. Our eyes make saccadic movements every 200–300 milliseconds, shifting the entire visual field. Even between eye movements, objects move and lighting shifts.

Mathematically, this means the underlying “true rate” is changing faster than the window required to measure it.

The brain faces a paradox. If it uses a short time window to catch rapid changes, the variance is too high to distinguish signal from noise. If it uses a long window to smooth out the noise, it lags behind reality and blurs the signal.

## 3) The “Noise” is Fake

The rate coding view relies on the idea that spike timing is random. It assumes that if you show a neuron the same image twice, the spike times will be different because of biological noise, even if the “rate” is the same.

However, experiments by Mainen & Sejnowski (1997) dismantled this assumption.

They showed that if you inject a constant current (a flat stimulus) into a neuron, the spike timing is indeed random. But real neurons don’t receive flat constant currents. They receive complex, fluctuating synaptic input. When the researchers injected a *fluctuating* current and repeated the experiment, the neuron fired at the **exact same times**, reproducible with millisecond precision.

The “noise” assumed by rate coding models isn’t inherent randomness. It is just the neuron responding precisely to inputs we failed to control for.

## The Layer of the Onion

Now, don’t get me wrong. I am not saying the firing rate is a useless concept.

Averaging spikes over time or across populations has been unreasonably effective for decades. It gave us tuning curves, population geometry, and the foundations of motor control.

But in science, different truths exist at different scales. Newtonian mechanics is “true” enough to build a bridge, but if you zoom in close enough, it dissolves into Quantum Mechanics.

Similarly, the firing rate is a valid statistical summary of what the brain is doing over *seconds*. But if we want to understand how the brain computes in *milliseconds*, how it recognizes a predator in the brush before you can even blink, the statistical summary is too slow. We need to look at the layer below.

---

I will leave you with some food for thought here. We are modeling the brain as a machine that counts averages, but the biology suggests a machine that relies on precise timing.

If neurons effectively have only one spike to send before the computation moves on, then the information cannot be in the *number* of spikes. It must be in the specific *time* that the spike arrives.

So perhaps we need new tools and mathematical frameworks to reason about this…

Until next week,

artem