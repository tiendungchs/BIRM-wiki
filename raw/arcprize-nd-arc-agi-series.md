---
title: "What is ARC-AGI?"
source: "https://arcprize.org/arc-agi"
author:
published:
created: 2026-06-19
description: "The only AI benchmark that measures AGI progress."
tags:
  - "clippings"
---
## ARC-AGI Series

### Benchmarks for General Intelligence

#### Page Contents

### The Measure of Intelligence

In 2019, François Chollet published the influential paper " [On the Measure of Intelligence](https://arxiv.org/abs/1911.01547) " where he introduced the "Abstraction and Reasoning Corpus for Artificial General Intelligence" (ARC-AGI) benchmark to measure fluid intelligence.

It defined intelligence as skill-acquisition efficiency on unknown tasks. Simply put: how quickly can you learn *new* skills?

---

## Defining AGI

To make deliberate progress towards more intelligent and human-like systems, we need to be following an appropriate feedback signal. We need to rigorously define and measure intelligence.

There exists a gap between AI and humans. Today, AI can automate many valuable tasks, but only humans are capable of open-ended innovation and discovery. Our mission is to continually study frontier AI progress and create useful and scientifically grounded benchmarks to highlight the remaining gap.

One popular definition of AGI, "a system that can automate the majority of economically valuable work," while a useful goal, is an incorrect measure of intelligence.

Measuring task-specific skill is not a good proxy for intelligence.

Skill is heavily influenced by prior knowledge and experience. Unlimited priors or unlimited training data allows developers to "buy" levels of skill for a system. This masks a system's own generalization power.

Intelligence lies in broad or general-purpose abilities; it is marked by *skill-acquisition* and generalization, rather than skill itself.

The ability to acquire skills, abstractions, and reason generally are pre-requisites of an intelligence which can ultimately accelerate innovation.

The ARC Prize definition of AGI

AGI is a system that can match the learning efficiency of humans.

More formally:

> The intelligence of a system is a measure of its skill-acquisition efficiency over a scope of tasks, with respect to [priors](#priors), experience, and generalization difficulty.
> 
> — François Chollet, ["On the Measure of Intelligence"](https://arxiv.org/abs/1911.01547)

This means that a system is able to adapt to new problems it has not seen before and that its creators (developers) did not anticipate.

ARC-AGI is the only AI benchmark that measures our progress towards general intelligence.

---

## Core Knowledge Priors

A principle underlying ARC-AGI's design is the need to create a fair and meaningful comparison between artificial intelligence and human intelligence. To achieve this, ARC-AGI focuses on *fluid* intelligence (the ability to reason, solve novel problems, and adapt to new situations) rather than *crystallized* intelligence, which relies on accumulated knowledge and skills. This distinction is critical because crystallized intelligence, by definition, includes cultural knowledge and learned information, which would provide an unfair advantage.

ARC-AGI avoids this by restricting itself to *core knowledge priors*, those cognitive building blocks that are either present at birth or acquired very early in human development with minimal explicit instruction, as described by the Core Knowledge theory ([Elizabeth Spelke](https://www.harvardlds.org/wp-content/uploads/2017/01/SpelkeKinzler07-1.pdf)).

The rationale for using core knowledge priors is twofold. First, it isolates the capacity for *generalization* – the ability to take limited information and apply it to new, unseen instances. By limiting the "input" to universally accessible cognitive primitives, ARC-AGI forces the test-taker (human or AI) to demonstrate genuine problem-solving ability rather than rely on pre-existing, domain-specific knowledge.

If a benchmark included, for instance, tasks involving written English, it would immediately disadvantage any AI that hadn't been extensively pre-trained on vast text corpora. It would also disadvantage humans that did not know English. English, or any language, is a cultural artifact, not a measure of inherent cognitive ability. The same is true for any knowledge related to specific human cultures or practices.

Secondly, the restriction to core knowledge priors allows for a more accurate assessment of the *efficiency* of intelligence. The core idea is that the more intelligent entity should be the most efficient at using its *resources* to acquire a given task.

The resources can come in two forms:

1. **Prior Knowledge:** - This is the knowledge about the task domain that an entity brings into a task before being introduced to that task.
2. **Experience:** - This is the amount of novel relevant information accrued by an agent about the task.

That is to say, intelligence is the rate at which a learner turns its experience and priors into new skills at valuable tasks that involve uncertainty and adaptation.

If an AI system has access to extensive, task-specific prior knowledge that is not available to a human, its performance on that task becomes a measure of the *developer's* cleverness in encoding that knowledge, not the AI's inherent intelligence. By focusing solely on a small set of universally shared core knowledge priors, ARC-AGI ensures that success truly reflects the *system's* ability to learn and generalize, placing the AI and human on a comparable footing.

---

## Design Philosophy

### Easy for Humans, Hard for AI

At the core of ARC-AGI benchmark design is the the principle of "Easy for Humans, Hard for AI."

The human mind is our only existence proof of general intelligence. As such, we set it as our reference point to judge AI.

Many AI benchmarks measure performance on tasks that require extensive training or specialized knowledge (Ph.D.-level problems). ARC Prize focuses instead on tasks that humans solve effortlessly yet AI finds challenging which highlight fundamental gaps in AI's reasoning and adaptability.

This approach reveals the essential qualities of intelligence - such as the ability to generalize from limited examples, synthesize symbolic rules, and flexibly apply known concepts in novel contexts - that current AI systems struggle to replicate.

By emphasizing these human-intuitive tasks, we not only measure progress more clearly but also inspire researchers to pursue genuinely novel ideas, moving beyond incremental improvements toward meaningful breakthroughs.

![](https://www.youtube.com/watch?v=2W5D6J8om0c)