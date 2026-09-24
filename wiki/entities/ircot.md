# IRCoT — Re-Querying a Fixed Store With the Reasoner's Own Last Step

**IRCoT (Interleaving Retrieval with Chain-of-Thought) alternates one generated reasoning sentence with one retrieval. The next query is the sentence just generated, not the question and not the retrieved text. The index is a fixed BM25 store. Nothing is written or trained. Against a single question-based read at the same 15-paragraph budget, recall rises by 3.5–22.6 points and answer F1 by up to 15.3, on four multi-hop open-domain QA sets. The per-step query is not a fixed function of the goal (`G60`). But the query changes at every step, and the baseline is budget-matched, not compute-matched. So this is the wiki's first measured multi-pass retrieval. It is not the re-read `G123` asks for.**

> **Provenance.** Trivedi, Balasubramanian, Khot & Sabharwal 2023, *Interleaving retrieval with chain-of-thought reasoning for knowledge-intensive multi-step questions*, ACL 2023 / arXiv:2212.10509 (`raw/trivedi-2023-interleaving-retrieval-with-chain-of-thought-reasoning.md`, ar5iv clip). Everything below is from that source unless marked. Recall and scaling numbers are figure-only in the clip except where the text quotes them. The step cap (footnote 4) and the per-step paragraph cap (footnote 5) are not in the clip.

---

## Architecture

| Component | Spec | Note |
|---|---|---|
| **Store** | BM25 (Elasticsearch) over a paragraph corpus: HotpotQA's Wikipedia; corpora built from the 2WikiMultihopQA, MuSiQue and IIRC contexts | Fixed. No dense encoder, no write, no training |
| **Reasoner** | Frozen language model: GPT3 `code-davinci-002` (175B) or Flan-T5 at 0.2B / 0.7B / 3B / 11B | Few-shot only. 15 hand-written chain-of-thought demonstrations per set, 3 sets drawn from 20 annotations |
| **Step 0** | Retrieve `K` paragraphs with the question `Q` as query | `K ∈ {2,4,6,8}`, tuned on 100 dev questions |
| **Reason step** | Generate the next sentence `s_t` from `(Q, all paragraphs so far, s_1…s_{t−1})`. Keep the **first** generated sentence only | Demonstrations show gold paragraphs + `M ∈ {1,2,3}` distractors |
| **Retrieve step** | `query_t = s_t` → `K` more paragraphs, **appended** to the set | Set capped at 15 paragraphs to fit the context window (8K word pieces for GPT3; 6K imposed on Flan-T5 by GPU memory) |
| **Stop rule** | `s_t` contains `"answer is:"`, or the step count reaches a hand-set maximum | A string match plus a constant. No learned halting |
| **Reader** | A separate from-scratch pass over the final set. Chain-of-thought prompting for GPT3, direct prompting for Flan-T5 (each is the better choice for that model, App. E) | Could be dropped. See the reader ablation below |

The loop in one line:

`P_0 = BM25(Q, K)`; for `t ≥ 1`: `s_t = LM(Q, P_{t−1}, s_{<t})[first sentence]`, `P_t = P_{t−1} ∪ BM25(s_t, K)`, until stop. Answer `= Reader(Q, P_T)`.

**The metric's control.** Every retriever gets a maximum of 15 paragraphs. The one-step baseline (OneR) gets its own `K ∈ {5,…,15}` tuned on dev. Recall of gold paragraphs is therefore *fixed-budget optimal recall*. It matches **what is read out**. It does not match **what is spent**: IRCoT makes one LM call per sentence plus one retrieval per step, and OneR makes none before the reader.

---

## Key results

### Retrieval recall gain over one-step retrieval (text-quoted, points)

| Reasoner | HotpotQA | 2WikiMultihopQA | MuSiQue | IIRC |
|---|---|---|---|---|
| Flan-T5-XXL (11B) | +7.9 | +14.3 | +3.5 | +10.2 |
| GPT3 (175B) | +11.3 | +22.6 | +12.5 | +21.2 |

### Answer F1, all reader × retriever cells (App. Table 4, mean ± sd over 3 demonstration sets)

| Reasoner / reader | Retrieval | HotpotQA | 2WikiMQA | MuSiQue | IIRC |
|---|---|---|---|---|---|
| Flan-T5-XXL, direct | none | 25.3 | 32.7 | 13.7 | 28.9 |
| | one-step | 49.7 | 51.2 | 25.8 | 40.0 |
| | **IRCoT** | **59.1** | **66.5** | **30.8** | **42.5** |
| GPT3, chain-of-thought | none | 47.5 | 41.2 | 25.2 | **52.1** |
| | one-step | 53.6 | 54.8 | 29.4 | 49.8 |
| | **IRCoT** | **60.7** | **68.0** | **36.5** | 49.9 |

- **Retrieval recall is not answer accuracy.** On IIRC, GPT3 gains 21.2 recall points and no F1. The no-retrieval GPT3 chain-of-thought reader (52.1) beats both retrieval readers. The authors attribute this to parametric knowledge that already covers IIRC.
- **Factual errors in the generated chain** (GPT3, 40 hand-annotated questions per dataset): no retrieval > one-step > IRCoT. IRCoT cuts errors vs one-step by **50%** on HotpotQA and **40%** on 2WikiMultihopQA.
- **Where the errors fall** (Tables 2, 5, qualitative). No retrieval errs on hop 1 and the rest of the chain follows the error. One-step retrieval fixes hop 1, the fact nearest the question, and errs on a later hop. IRCoT fixes each hop.
- **Scale.** IRCoT recall beats one-step at every size, including 0.2B, and the margin roughly grows with size. The Fig. 8 caption says "0.3B". The text says 0.2B. IRCoT QA beats one-step QA at every size except the smallest. **Flan-T5-XL (3B) with IRCoT beats one-step and no-retrieval GPT3 (58× larger) on all three datasets tested.**
- **Out of distribution.** Demonstrations from one dataset tested on another keep the same order: IRCoT > one-step > none.
- **Leaderboard** (not head-to-head: corpora, retrievers and LMs differ). Exact match | F1: HotpotQA 49.3 | 60.7, 2WikiMQA 57.7 | 68.0, MuSiQue 26.5 | 36.5. That is above ReAct, SelfAsk, RECITE and Internet-Augmented QA. Contemporaneous DSP (HotpotQA, +2.0) and a newer DecomP (2WikiMQA, +2.8) edge past it. The authors' reading: 2WikiMQA's few templated decomposition patterns suit explicit question decomposition.

### The reader ablation: a fresh decision vs the in-flight one (App. Table 6, F1)

| | HotpotQA | 2WikiMQA | MuSiQue | IIRC |
|---|---|---|---|---|
| Flan-T5-XXL, separate reader | 59.1 | 66.5 | 30.8 | 42.5 |
| Flan-T5-XXL, answer taken from the retrieval-time chain | 52.6 | 60.9 | 24.9 | 40.3 |
| GPT3, separate reader | 60.7 | 68.0 | 36.5 | 49.9 |
| GPT3, answer taken from the retrieval-time chain | 61.0 | **70.4** | 31.5 | 48.4 |

The retrieval-time chain commits to each sentence while the evidence is still arriving. The reader re-derives from scratch with the final set in view from the start. For the 11B model the fresh pass is better on all four sets (+2.2 to +6.5). For GPT3 it is mixed: +5.0 on MuSiQue, −2.4 on 2WikiMQA.

---

## Limitations

- **Not a re-read.** The query at step `t` is `s_t`, so every retrieval is a *different* read of the same store. Nothing re-presents the same cue to test whether a first commitment survives. In `G123`'s terms this is the Universal Transformer's position: the representation is revised between passes, so the decision is never re-taken on the same evidence.
- **Not compute-matched.** The baseline controls the read-out budget (15 paragraphs), not the FLOPs or LM calls. The gain could come from re-deciding *or* from spending more. The source has no control that separates the two: e.g. OneR with `T` sampled question paraphrases as queries, or IRCoT with `s_t` replaced by a same-length non-inferential sentence. The Universal Transformer ran the control this needs: fixed 8- and 9-step models lose to a dynamic model averaging 8.2 steps ([[wiki/entities/universal-transformer.md]]).
- **The store only grows.** Paragraphs are appended until the cap, and nothing is ever removed. The authors propose reranking and selection as future work because the input must fit the context. This is an unscheduled buffer with no `suppress` or `clear` ([[wiki/concepts/memory-read-and-erase.md]]).
- **Halting and read frequency are hand-set.** The stop rule is a string match plus a step cap, and retrieval fires after every sentence whether it is needed or not. The authors name "dynamically deciding when to retrieve more information and when to perform additional reasoning" as the open problem. That is the controller [[wiki/architectural-gaps.md]] `G15` lacks. [[wiki/entities/self-rag.md]] supplies the *when* as a trained token, with a hand-set threshold, keyed on the same kind of cue (input ⊕ last generated segment). It is not reported on these multi-hop sets.
- **Needs a reasoner that can already write chains of thought.** Below 20B this ability is uncommon. The 0.2B model's recall gain does not reach the answer.
- **No settling curve.** Recall is reported at termination only. Gain per step, and whether the retrieved set stops changing before the stop rule fires, are not reported.
- **Reproducibility.** `code-davinci-002` was deprecated after submission. The Flan-T5 results carry the same trends and remain reproducible.

---

## Comparison to related models

| | One-step retrieve-and-read | **IRCoT** | [[wiki/entities/remerge.md]] | [[wiki/entities/universal-transformer.md]] |
|---|---|---|---|---|
| Store | fixed index | fixed index | separated episodic traces | the input context |
| What is recirculated | nothing | the reasoner's **derived statement** `s_t` | retrieved items + external input | the whole representation |
| Query at pass `t` | `Q` | `s_t` (changes every step) | input ⊕ previous retrieval | the current state |
| Termination | — | string match / step cap | attractor (retrieved set stops changing) | fixed `T` or halting unit |
| Write during the loop | no | no | no | no |
| Evidence | baseline | 4 datasets, 5 model sizes, OOD | none in the wiki (second-hand) | bAbI: ponder time tracks 1→3 supporting facts |

**(brainstorm) Why the derived statement, not the retrieved text, is the query.** REMERGE recirculates what was retrieved, so the next read is keyed on the *first hop's content*. IRCoT keys the next read on the *bridge entity the reasoner inferred from that content* ("…manufactured by Mack Rides"). The retrieved paragraph holds that entity somewhere in a long passage. The inferred sentence isolates it as a short query. So the reasoner acts as a query-compression step between reads, which lets a lexical index with no multi-hop structure support a path query. The untested prediction: replacing `s_t` with the top retrieved paragraph (REMERGE-style recirculation) should lose most of the gain on bridge questions and little on comparison questions.

---

## Connections

- **[[wiki/entities/remerge.md]]** — the machine test of that page's brainstorm "iterative re-query should help multi-hop retrieval, with no change to the index and no write". It passes (up to +22.6 recall at a fixed read-out budget). It differs in what is recirculated: the reasoner's derived bridge sentence, not the retrieved content. And it ends on a string match, not on a settled retrieved set.
- **[[wiki/concepts/retrieval-mediated-learning.md]]** — the query-time pole of that page's write-time/query-time table, now measured in a machine. Per-hop re-grounding cuts the per-hop error the table predicts for query-time composition: 40–50% fewer chains with a factual error than a single read. So the "multi-hop failure" is partly a single-read failure, not a query-time one (T334).
- **[[wiki/concepts/memory-read-and-erase.md]]** — a controller that issues reads at run time with a *state-derived* address, and an append-only buffer with a capacity cap and no removal operation. It has the read scheduler's address half, with no lead time, and none of the erase family (G49).
- **[[wiki/concepts/retrieval-capacity.md]]** — a third exit from the compositional-query ceiling, beside joint scoring and structural addressing: split one query naming a multi-hop set into a sequence of single-hop reads. Each read asks the index only for the small set its current key can name.
- **[[wiki/entities/self-rag.md]]** — the controller over this page's loop, trained rather than scheduled. A token decides per segment whether to read, and `K` passages are read in parallel and ranked by self-critique instead of appended. Neither system re-reads on a fixed cue, and neither baseline is compute-matched.

---

**Sources:** Trivedi et al. 2023 (`raw/trivedi-2023-interleaving-retrieval-with-chain-of-thought-reasoning.md`).
