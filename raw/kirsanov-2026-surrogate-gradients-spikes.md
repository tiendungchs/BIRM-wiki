---
title: "The Smooth Lie That Makes Spikes Learn"
source: "https://artemkirsanov.substack.com/p/the-smooth-lie-that-makes-spikes"
author:
  - "[[Artem Kirsanov]]"
published: 2026-03-23
created: 2026-09-01
description: "When the right gradient doesn't exist, a wrong one will do"
tags:
  - "clippings"
---
Missed a post last week because I was a bit sick, but now it’s time to get back on track!

Last month we talked about how spiking neural networks (SNNs) are losing the hardware lottery: a brilliant idea in principle, but stranded on hardware that wasn’t built for them. But there is another obstacle, arguably more fundamental than hardware. It’s a mathematical one, and it blocked progress on training SNNs for years.

**You can’t take the gradient of a spike.**

This is the core problem. Modern deep learning runs on backpropagation, which requires every operation in the computational graph to be smooth and differentiable: you need to trace how a small nudge in any parameter would ripple forward through the network and nudge the loss. Under the hood it relies on the sequential application of chain rule – taking derivatives of atomic operations and chaining them together. This works beautifully when neurons output smooth, continuous values. But spiking neurons don’t do that.

A spiking neuron accumulates input into a membrane potential, and when that potential crosses a threshold, it emits a spike – a binary all-or-nothing event. Mathematically, the spiking mechanism is a **Heaviside step function**: output 0 below threshold, output 1 above. And the derivative of a step function is... well, zero everywhere except at the exact threshold, where it is infinite.

This is catastrophic for gradient-based learning, because if any derivative in the chain of operations is zero, the gradient dies – nothing propagates further. And since almost every input puts the neuron somewhere away from threshold, the gradient is almost always exactly zero. The network can’t learn.

Concretely, suppose a neuron’s spiking threshold is -50 mV and during the forward pass the voltage reached -51 mV – very close, but no spike. The derivative asks: how much does the output change if I nudge the synaptic strength by an **infinitesimally small amount**? The answer is zero, because an infinitesimal nudge to a synapse will shift the voltage infinitesimally – not by the 1 mV it needs to cross threshold. Yet intuitively, this neuron was *almost there*. A modest, finite increase in synaptic weight would almost certainly push it over. So while the gradient says “that synapse has no effect on the spike”, common sense says otherwise. Should we perhaps make the chain rule more “lenient”?

## Lying to the chain rule

The idea is surprisingly simple. We artificially make the backward pass, the machinery that calculates the derivatives, “blur its vision” a little bit.

During the **forward pass**, we use the true threshold function. Spikes are still binary, neurons output either 0 or 1, the network dynamics are faithful. However, during the **backward pass**, when we need to compute gradients, we swap the Heaviside derivative for the derivative of a smooth function that *approximates* the step — a **surrogate gradient**.

The most common choice is a sigmoid function (or a “fast sigmoid”, which looks like a sigmoid but avoids exponentiation for speed). Its derivative is a smooth, bell-shaped bump centered at threshold. The specific shape turns out not to matter much. What matters is that the surrogate derivative is (1) non-zero in a neighborhood of the threshold and (2) decays away from it, so that neurons far from threshold contribute weaker gradients, which makes intuitive sense.

![](https://substackcdn.com/image/fetch/$s_!dkrv!,w_1456,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F3867196c-06c9-4599-8553-6f6dfd7e9a2c_1200x700.png)

True Heaviside function (white) and sigmoid smooth approximations of it used on a backward pass

$$
\frac{\partial S}{\partial V} \left|\right._{\text{forward}} = \delta \left(V - V_{\text{th}}\right) \rightarrow \frac{\partial S}{\partial V} \left|\right._{\text{backward}} \approx \frac{1}{\left(\right. 1 + \beta \left|\right. V - V_{\text{th}} \left|\right. \left.\right)^{2}}
$$

The forward pass is the true dynamics. The backward pass tells a useful lie.

## Why it works

This should bother you. We are computing gradients of a function that is *not* the function we are actually evaluating. The loss landscape that the optimizer “sees” during backpropagation is not the real loss landscape of the spiking network. It’s a smoothed approximation.

And yet it works remarkably well. SNNs trained with surrogate gradients now reach competitive accuracy on standard benchmarks (CIFAR-10, or even ImageNet), approaching their non-spiking counterparts with analog activation values.

One intuition for why: the teaching signal used for weight adjustment (in our case the surrogate gradient) doesn’t need to be formally correct — it just needs to point in a roughly useful direction. If the true gradient (were it defined) would push a weight up, the surrogate gradient likely agrees on the sign, even if the magnitude is wrong. Optimization is surprisingly tolerant of approximate gradients, as long as they are correlated with the true optimal direction.

There is actually an interesting precedent for this. In 2016, Lillicrap et al. [showed](https://www.nature.com/articles/ncomms13276) that backpropagation still works even if you replace the exact transpose weight matrices used in the backward pass with **fixed random matrices** — a phenomenon they called **feedback alignment**. The network learns nearly as well, because during training the forward weights gradually align themselves to make the random feedback useful. If learning can succeed when the backward pass uses entirely random projections, it is perhaps less surprising that it succeeds when the backward pass uses a slightly wrong derivative shape. The bar for “good enough” gradient information turns out to be much lower than you might expect.

## Beyond spikes

What I find most interesting is that the idea is not specific to neuroscience or SNNs at all. Surrogate gradients are an instance of a more general trick: **when your computation contains a non-differentiable operation, replace its derivative (and only its derivative!) with something smooth during backpropagation.**

This same logic appears in training binary neural networks (where weights are quantized to ±1 using the sign function) and in differentiable rendering (where visibility is a step function). The pattern keeps showing up: forward pass respects the true discrete operation, backward pass substitutes a smooth approximation to keep gradients flowing.

It is a reminder that backpropagation is a tool, not a law. And sometimes the most productive thing you can do is lie to it. Just enough to get useful information, but not so much that it points you in the wrong direction.

Until next week,  
Artem