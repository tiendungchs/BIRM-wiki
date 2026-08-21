---
title: "ARC-AGI v2 Leaderboard"
source: "https://llm-stats.com/benchmarks/arc-agi-v2"
author:
  - "[[LLM Stats]]"
published: 2026-05-07
created: 2026-07-02
description: "ARC-AGI v2 leaderboard — GPT-5.5 leads 16 AI models at 0.850. ARC-AGI-2 is an upgraded benchmark for measuring abstract reasoning and problem-solving abilities…"
tags:
  - "clippings"
---
## ARC-AGI v2

[Paper](https://arxiv.org/abs/2505.11831)

## Progress Over Time

Interactive timeline showing model performance evolution on ARC-AGI v2

State-of-the-art frontier

Open

Proprietary

## ARC-AGI v2 Leaderboard

16 models

| # | Model | Score | Size | Context | Cost | License |
| --- | --- | --- | --- | --- | --- | --- |
| 1 | [GPT-5.5](https://llm-stats.com/models/gpt-5.5)  OpenAI | 0.850 | — | 1.1M | $5.00 / $30.00 |  |
| 2 | [Gemini 3.1 Pro](https://llm-stats.com/models/gemini-3.1-pro-preview)  Google | 0.771 | — | 1.0M | $2.50 / $15.00 |  |
| 3 | [GPT-5.4](https://llm-stats.com/models/gpt-5.4)  OpenAI | 0.733 | — | 1.0M | $2.50 / $15.00 |  |
| 4 | [Gemini 3.5 Flash](https://llm-stats.com/models/gemini-3.5-flash)  Google | 0.721 | — | 1.0M | $1.50 / $9.00 |  |
| 5 | [Claude Opus 4.6](https://llm-stats.com/models/claude-opus-4-6)  Anthropic | 0.688 | — | 1.0M | $5.00 / $25.00 |  |
| 6 | [Claude Sonnet 4.6](https://llm-stats.com/models/claude-sonnet-4-6)  Anthropic | 0.583 | — | 200K | $3.00 / $15.00 |  |
| 7 | [GPT-5.2 Pro](https://llm-stats.com/models/gpt-5.2-pro-2025-12-11)  OpenAI | 0.542 | — | — | — |  |
| 8 | [GPT-5.2](https://llm-stats.com/models/gpt-5.2-2025-12-11)  OpenAI | 0.529 | — | 400K | $1.75 / $14.00 |  |
| 9 | [Muse Spark](https://llm-stats.com/models/muse-spark)  Meta | 0.425 | — | — | — |  |
| 10 | [Claude Opus 4.5](https://llm-stats.com/models/claude-opus-4-5-20251101)  Anthropic | 0.376 | — | — | — |  |
| 11 | [Gemini 3 Flash](https://llm-stats.com/models/gemini-3-flash-preview)  Google | 0.336 | — | 1.0M | $0.50 / $3.00 |  |
| 12 | [Gemini 3 Pro](https://llm-stats.com/models/gemini-3-pro-preview)  Google | 0.311 | — | — | — |  |
| 13 | [Grok-4](https://llm-stats.com/models/grok-4)  xAI | 0.159 | — | — | — |  |
| 14 | [Claude Opus 4](https://llm-stats.com/models/claude-opus-4-20250514)  Anthropic | 0.086 | — | — | — |  |
| 15 | [o3](https://llm-stats.com/models/o3-2025-04-16)  OpenAI | 0.065 | — | — | — |  |
| 16 | [Gemini 2.5 Pro](https://llm-stats.com/models/gemini-2.5-pro)  Google | 0.049 | — | 1.0M | $1.25 / $10.00 |  |

Notice missing or incorrect data?

About this benchmark

## What is ARC-AGI v2?

ARC-AGI-2 is an upgraded benchmark for measuring abstract reasoning and problem-solving abilities in AI systems through visual grid transformation tasks. It evaluates fluid intelligence via input-output grid pairs (1x1 to 30x30) using colored cells (0-9), requiring models to identify underlying transformation rules from demonstration examples and apply them to test cases. Designed to be easy for humans but challenging for AI, focusing on core cognitive abilities like spatial reasoning, pattern recognition, and compositional generalization.

ARC-AGI v2 is a multimodal benchmark evaluating models on reasoning, spatial reasoning, and vision tasks. LLM Stats tracks **16 models** on this benchmark, scored on a 0–1 scale. The current average is 0.5, with the leader at 0.8.

Compare leaders on the [best AI for reasoning](https://llm-stats.com/leaderboards/best-ai-for-reasoning), [best AI for spatial reasoning](https://llm-stats.com/benchmarks/category/spatial_reasoning) and [best AI for vision](https://llm-stats.com/leaderboards/best-ai-for-image-understanding) leaderboards.

## Current leaders

GPT-5.5 from OpenAI currently leads the ARC-AGI v2 leaderboard with a score of 0.850 across 16 evaluated AI models.

## Source paper

Title

ARC-AGI-2: A New Challenge for Frontier AI Reasoning Systems

Authors

Francois Chollet, Mike Knoop, Gregory Kamradt, Bryan Landers, and 1 others

Published

May 17, 2025

arXiv

[2505.11831](https://arxiv.org/abs/2505.11831)

Abstract

The Abstraction and Reasoning Corpus for Artificial General Intelligence (ARC-AGI), introduced in 2019, established a challenging benchmark for evaluating the general fluid intelligence of artificial systems via a set of unique, novel tasks only requiring minimal prior knowledge. While ARC-AGI has spurred significant research activity over the past five years, recent AI progress calls for benchmarks capable of finer-grained evaluation at higher levels of cognitive complexity. We introduce ARC-AGI-2, an upgraded version of the benchmark. ARC-AGI-2 preserves the input-output pair task format of its predecessor, ensuring continuity for researchers. It incorporates a newly curated and expanded set of tasks specifically designed to provide a more granular signal to assess abstract reasoning and problem-solving abilities at higher levels of fluid intelligence. To contextualize the difficulty and characteristics of ARC-AGI-2, we present extensive results from human testing, providing a robust baseline that highlights the benchmark's accessibility to human intelligence, yet difficulty for current AI systems. ARC-AGI-2 aims to serve as a next-generation tool for rigorously measuring progress towards more general and human-like AI capabilities.

### What is the ARC-AGI v2 benchmark?

ARC-AGI-2 is an upgraded benchmark for measuring abstract reasoning and problem-solving abilities in AI systems through visual grid transformation tasks. It evaluates fluid intelligence via input-output grid pairs (1x1 to 30x30) using colored cells (0-9), requiring models to identify underlying transformation rules from demonstration examples and apply them to test cases. Designed to be easy for humans but challenging for AI, focusing on core cognitive abilities like spatial reasoning, pattern recognition, and compositional generalization.

### What is the ARC-AGI v2 leaderboard?

The ARC-AGI v2 leaderboard ranks 16 AI models based on their performance on this benchmark. Currently, [GPT-5.5](https://llm-stats.com/models/gpt-5.5) by OpenAI leads with a score of 0.850. The average score across all models is 0.451.

### What is the highest ARC-AGI v2 score?

The highest ARC-AGI v2 score is 0.850, achieved by [GPT-5.5](https://llm-stats.com/models/gpt-5.5) from OpenAI.

### How many models are evaluated on ARC-AGI v2?

16 models have been evaluated on the ARC-AGI v2 benchmark, with 0 verified results and 13 self-reported results.

### Where can I find the ARC-AGI v2 paper?

The ARC-AGI v2 paper is available at [https://arxiv.org/abs/2505.11831](https://arxiv.org/abs/2505.11831). The paper details the methodology, dataset construction, and evaluation criteria.

### What categories does ARC-AGI v2 cover?

ARC-AGI v2 is categorized under reasoning, spatial reasoning, and vision. The benchmark evaluates multimodal models.

### Which model offers the best value on ARC-AGI v2?

Among models scoring within 10% of the leader, [Gemini 3.1 Pro](https://llm-stats.com/models/gemini-3.1-pro-preview) from Google is the cheapest, at $2.50 per million input tokens with a score of 0.771.

### How recent are the ARC-AGI v2 leaderboard results?

The ARC-AGI v2 leaderboard was last updated in July 2026 and currently includes 16 evaluated models.