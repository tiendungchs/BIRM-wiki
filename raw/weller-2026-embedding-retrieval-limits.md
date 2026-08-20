# weller-embedding-retrieval-limits-2026

> Converted from `weller-embedding-retrieval-limits-2026.pdf` on 2026-08-18 via `pymupdf4llm`.
> Layout artefacts (broken equations, interleaved columns) are conversion noise, not the source.

---

<u>Published as a conference paper at ICLR 2026</u>

## ON THE THEORETICAL LIMITATIONS OF EMBEDDING-BASED RETRIEVAL

**Orion Weller** <sup>**1,2**</sup> **Michael Boratko** <sup>**1**</sup> **Iftekhar Naim** <sup>**1**</sup> **Jinhyuk Lee** <sup>**1**</sup>

1Google DeepMind, 2Johns Hopkins University

oweller@cs.jhu.edu,jinhyuklee@google.com

ABSTRACT

Vector embeddings have been tasked with an ever-increasing set of retrieval tasks
over the years, with a nascent rise in using them for reasoning, instruction-following,
coding, and more. These new benchmarks push embeddings to work for _any query_
and _any notion of relevance_ that could be given. While prior works have pointed
out theoretical limitations of vector embeddings, there is a common assumption
that these difficulties are exclusively due to unrealistic queries, and those that are
not can be overcome with better training data and larger models. In this work, we
demonstrate that we may encounter these theoretical limitations in realistic settings
with extremely simple queries. We connect known results in learning theory,
showing that the number of top- _k_ subsets of documents capable of being returned
as the result of some query is limited by the dimension of the embedding. We
empirically show that this holds true even if we directly optimize on the test set with
free parameterized embeddings. We then create a realistic dataset called LIMIT
that stress tests embedding models based on these theoretical results, and observe
that even state-of-the-art models fail on this dataset despite the simple nature of the
task. Our work shows the limits of embedding models under the existing single
vector paradigm and calls for future research to develop new techniques that can
resolve this fundamental limitation.

1 INTRODUCTION

Over the last two decades, information retrieval (IR) has moved from models dominated by sparse
techniques (such as BM25 Robertson et al. (1995)) to those that use neural language models (LM)
as their backbones (Lee et al., 2019; Craswell et al., 2020; Izacard et al., 2021; Wang et al., 2022).
These neural models are predominantly used in a single vector capacity, where they output a single
_embedding_ representing the entire input (also known as _dense retrieval_ ). These embedding models
are capable of generalizing to new retrieval datasets and have been tasked with solving increasingly
complicated retrieval problems (Thakur et al., 2021; Enevoldsen et al., 2025; Lee et al., 2025).

In recent years this has been pushed even further with the rise of instruction-following retrieval
benchmarks, where models are asked to represent **any relevance definition** for **any query** (Weller
et al., 2025a;c; Song et al., 2025; Xiao et al., 2024; Su et al., 2024). For example, the QUEST dataset
(Malaviya et al., 2023) uses logical operators to combine different concepts, studying the difficulty
of retrieval for complex queries (e.g., “Moths or Insects or Arthropods of Guadeloupe”). On the
other hand, datasets such as BRIGHT (Su et al., 2024) explore the challenges arising from different
definitions of relevance by defining relevance in ways that require reasoning. One subtask includes
reasoning over a given Leetcode problem (the query) to find other Leetcode problems that share a
subtask (e.g. others problems using dynamic programming). Although models cannot solve these
benchmarks yet, the community has proposed these problems in order to push the boundaries of what
dense retrievers are capable of—which is now implicitly _every task_ that could be defined.

Rather than proposing empirical benchmarks to gauge what embedding models can achieve, we seek
to understand at a more fundamental level what the limitations are. Since embedding models use

1

<u>Published as a conference paper at ICLR 2026</u>

q1
q2
q3

Leslie Laham likes Apples and Candy.
#### …

|Col1|Col2|
|---|---|
|_Quokkas_|_Quokkas_|
|_Apples_|_Apples_|
|||

Figure 1: A depiction of the LIMIT dataset creation process, based on theoretical limitations. We test
**all combinations** of relevance for _N_ documents (i.e. in the figure, all combinations of relevance for
three documents with two relevant documents per query) and instantiate it using a simple mapping.

vector representations in geometric space, there exist well-studied fields of mathematical research
(Papadimitriou & Sipser, 1982) that could be used to analyze these representations.

Our work aims to bridge this gap, connecting known theoretical results in linear algebra with modern
advancements in neural information retrieval. We draw upon research in high-dimensional geometry
to provide a lower bound on the embedding dimension needed to represent a given combination
of relevant documents and queries. Specifically, we show that for a given embedding dimension _d_
**there exist top-** _k_ **combinations of documents that cannot be returned** —no matter the query—
highlighting a theoretical and fundamental limit to embedding models.

To show that this theoretical limit is true for any retrieval model or training dataset, we test a setting
where the vectors themselves are directly optimized with the test data. This allows us to empirically
show how the embedding dimension enables the solving of retrieval tasks. We find that there exists a
crucial point for each embedding dimension ( _d_ ) where the number of documents is too large for the
embedding dimension to encode all combinations. We then gather these crucial points for a variety of
_d_ and show that this relationship can be modeled empirically with a polynomial function.

We also go one step further and construct a realistic but simple dataset based on these theoretical
limitations (called LIMIT). <sup>1</sup> Despite the simplicity of the task (e.g., who likes Apples? and
Jon likes Apples, ...), we find it is very difficult for even state-of-the-art embedding
models (Lee et al., 2025; Zhang et al., 2025) on MTEB (Enevoldsen et al., 2025), and practically
impossible for models with small embedding dimensions using standard optimization techniques.

Overall, our work contributes: (1) a theoretical basis for the fundamental limitations of embedding
models, (2) a best-case empirical analysis showing that this proof holds for any dataset instantiation
(by free embedding optimization), and (3) a simple real-world natural language instantiation called
LIMIT that even state-of-the-art embedding models cannot solve.

These results imply interesting findings for the community: on one hand we see neural embedding
models becoming immensely successful. However, academic benchmarks test only a small amount
of the queries that could be issued (and these queries are often overfitted to), hiding these limitations.
Our work shows that as the tasks given to embedding models require returning ever-increasing
combinations of top- _k_ relevant documents (e.g., through instructions connecting previously unrelated
documents with logical operators), we will reach a limit of combinations they can represent.

Thus, the community should be aware of these limitations, both when creating evals and also by using
alternate architectures—such as cross-encoders / multi-vector / more expressive similarity functions
—when trying to handle the full range of instruction queries, i.e. _any query and relevance definition_ .

[1Data and code are available at https://github.com/google-deepmind/limit](https://github.com/google-deepmind/limit)

2

<u>Published as a conference paper at ICLR 2026</u>

2 RELATED WORK

2.1 NEURAL EMBEDDING MODELS

There has been immense progress on embedding models in recent years (Lee et al., 2019; Craswell
et al., 2020; BehnamGhader et al., 2024), moving from simple web search (text-only) to advanced
instruction-following and multi-modal representations. These models generally followed advancements in language models, such as pre-trained LMs (Hoffmann et al., 2022), multi-modal LMs (Li
et al., 2024; Team, 2024), and advancements in instruction-following (Zhou et al., 2023; Ouyang
et al., 2022). Some of the prominent examples in retrieval include CoPali (Faysse et al., 2024) and
DSE (Ma et al., 2024) which focus on multimodal embeddings, Instructor (Su et al., 2022) and
FollowIR (Weller et al., 2024a) for instruction following, and GritLM (Muennighoff et al., 2024) and
Gemini Embeddings (Lee et al., 2025) for pre-trained LMs turned embedders.

Our work, though focused solely on textual representations for simplicity, **applies to all modalities**
**of single vector embeddings for any domain of dataset** . As the space of things to represent grows
(through instructions or multi-modality) they will increasingly run into these theoretical limitations.

2.2 EMPIRICAL TASKS PUSHING THE LIMITS OF DENSE RETRIEVAL

Retrieval models have been pushed beyond their initial use cases to handle a broad variety of areas.
Notable works include efforts to represent a wide group of domains (Thakur et al., 2021; Lee et al.,
2024), a diverse set of instructions (Weller et al., 2024a; Zhou et al., 2024; Oh et al., 2024; Weller
et al., 2025b), and to handle reasoning over the queries (Xiao et al., 2024; Su et al., 2024). This
has pushed the focus of embedding models from basic keyword matching to embeddings that can
represent the full semantic meaning of language. As such, it is more common than ever to connect
what were previously unrelated documents into the top- _k_ relevant set, <sup>2</sup> increasing the number of
combinations that models must be able to represent. This has motivated our interest in understanding
the limits of what embeddings can represent, as current work expects it to handle _every_ task.

Previous work has explored empirically the limits of models: Reimers & Gurevych (2020) showed
that smaller dimension embedding models have more false positives, especially with larger-scale
corpora. Ormazabal et al. (2019) showed the empirical limitations of models in the cross-lingual
setting and Yin & Shen (2018) showed how embedding dimensions relate to the bias-variance tradeoff.
In contrast, our work provides a theoretical connection between the embedding dimension and the
top-k sets it can retrieve, while also showing empirical limitations.

2.3 THEORETICAL LIMITS OF VECTORS IN GEOMETRIC SPACE

Understanding and finding nearest neighbors in semantic space has a long history in mathematics
research, with early work such as the Voronoi diagram being studied as far back as 1644 and
formalized in 1908 (Voronoi, 1908). The order- _k_ version of the Voronoi diagram (i.e. the Voronoi
diagram partitioning the space into regions based on their closest _k_ points) is obviously connected to
information retrieval and has been studied for many years (Clarkson, 1988). The number of such
regions is equal to the number of unique retrieval sets of size _k_, however this quantity is notoriously
difficult to bound tightly (Bohler et al., 2015; Lee, 1982; Chen et al., 2023).

We approach this problem from a different angle, asking not how many _k_ -subsets a given configuration
realizes, but rather what embedding dimension is _necessary_ to realize all _k_ -subsets with a guaranteed
score margin. By applying a classical sphere-packing volume argument (Vershynin, 2018; Conway
et al., 1999), we obtain a lower bound on the embedding dimension in terms of _n_, _k_, and the margin _γ_ .
Our result is conceptually related to the Johnson–Lindenstrauss lemma (Johnson et al., 1984), which
gives a _sufficient_ dimension to preserve pairwise distances among _n_ points; in contrast, our bound
gives a _necessary_ dimension to realize all retrieval sets with a margin. The role of the margin in
controlling the complexity of realizable configurations also parallels classical results in statistical
learning theory, including the fat-shattering dimension (Kearns & Schapire, 1994) and margin-based
generalization bounds for linear classifiers (Bartlett, 2002; Vapnik, 1998), where larger margins
similarly constrain the capacity of the hypothesis class.

2You can imagine an easy way to connect any two documents merely by using logical operators, i.e. X and Y.

3

<u>Published as a conference paper at ICLR 2026</u>

3 REPRESENTATIONAL CAPACITY OF VECTOR EMBEDDINGS

In this section we formally define the minimum embedding dimension required to satisfy a given
retrieval objective, and draw on classical sphere-packing results from high-dimensional geometry to
establish a lower bound. We note that this will be an extreme lower bound, as practical models have
to deal with other constraints such as learning through gradient descent and using LM tokenization.

**Setup.** Let _v_ 1 _, . . ., vn_ _∈_ R <sup>_d_</sup> be unit <sup>3</sup> document vectors, and let queries be unit vectors _u ∈_ R <sup>_d_</sup> . Fix
_γ_ _>_ 0. A _k_ -subset _S_ _⊆_ [ _n_ ] is realized with margin _γ_ if there exists a unit query _uS_ such that

min _i∈S_ <sup>_⟨uS, vi⟩≥_</sup> <sup>max</sup> _j /∈S_

min _i∈S_

<sup>max</sup> _j /∈S_ <sup>_⟨uS, vj⟩_</sup> <sup>+</sup> <sup>2</sup> <sup>_γ._</sup> (1)

Since _⟨u, vi⟩∈_ [ _−_ 1 _,_ 1] for unit vectors, any score gap is at most 2, hence equation 1 is feasible only
for 0 _< γ_ _≤_ 1. Throughout, log denotes the natural logarithm.

**Theorem** **1** (Dimension lower bound) **.** _Assume_ 1 _≤_ _k_ _<_ _n_ _and_ _that_ every _k-subset_ _S_ _⊆_ [ _n_ ] _is_
_realized with margin γ_ _as in equation 1._ _Then_

- _n_

_k_

_≤_

�1 + <sup><u>1</u></sup>
_γ_

- _n_
_<u>k</u>_

- _d_ log
_,_ _hence_ _d_ _≥_

log

_<u>k</u>_ (2)

<u>�</u> <u>�</u> _._
1 + 1 _/γ_

_Proof._ Fix two distinct _k_ -subsets _S̸_ = _T_ and choose _i ∈_ _S \ T_ and _j_ _∈_ _T_ _\ S_ . Applying equation 1
to _S_ and to _T_ gives

_⟨uS, vi −_ _vj⟩≥_ 2 _γ,_ _⟨uT, vj_ _−_ _vi⟩≥_ 2 _γ._

Adding yields _⟨uS_ _−_ _uT, vi −_ _vj⟩≥_ 4 _γ_ . By Cauchy–Schwarz and (universally, for _any_ unit vectors)
_∥vi −_ _vj∥≤∥vi∥_ + _∥vj∥_ = 2, we obtain _∥uS_ _−_ _uT ∥≥_ 2 _γ_ . Thus the _M_ = - _nk_ - unit queries _{uS}_

- _n_
_k_

_∥vi −_ _vj∥≤∥vi∥_ + _∥vj∥_ = 2, we obtain _∥uS_ _−_ _uT ∥≥_ 2 _γ_ . Thus the _M_ = - _nk_ - unit queries _{uS}_

are pairwise 2 _γ_ -separated, so the open balls _B_ ( _uS, γ_ ) are disjoint. Moreover, since _∥uS∥_ = 1, each
_B_ ( _uS, γ_ ) _⊆_ _B_ (0 _,_ 1 + _γ_ ), and therefore

- _Bd_ ( _γ_ )

- _Bd_ (1 + _γ_ )

- _._

_M_ _·_ vol

- _≤_ vol

Using vol( _Bd_ ( _r_ )) = _Cd r_ <sup>_d_</sup> for a constant _Cd_ depending only on _d_ (which cancels), we get _Mγ_ <sup>_d_</sup> _≤_
(1 + _γ_ ) <sup>_d_</sup>, i.e. - _nk_ - _≤_ �(1 + _γ_ ) _/γ_ - _d_ = �1 + 1 _/γ_ - _d_ . Rearranging yields equation 2.

- _n_
_k_

- _≤_

�(1 + _γ_ ) _/γ_

   
- _d_ = 1 + 1 _/γ_ - _d_ . Rearranging yields equation 2.

Corpus size _n_ _k_ = 2 _k_ = 10 _k_ = 100 _k_ = 1000

10 <sup>2</sup> 4 13 _trivial_           10 <sup>3</sup> 6 23 135 _trivial_
10 <sup>4</sup> 8 33 233 1354
10 <sup>5</sup> 10 42 329 2334
10 <sup>6</sup> 12 52 425 3296
10 <sup>7</sup> 14 61 521 4257
10 <sup>8</sup> 16 71 617 5217
10 <sup>9</sup> 17 81 713 6177
10 <sup>10</sup> 19 90 809 7137
10 <sup>11</sup> 21 100 905 8098

Table 1: Lower bounds for embedding dimension from Theorem 1 for _γ_ = 0 _._ 1. When _n_ and _k_ are
both 1000, the result is _trivial_ because �10001000� = 1 (there is only one _k_ -subset, hence no “irrelevant”

items to separate). We see for large _k_ and _n_ values these dimension requirements are already greater
than those currently used for web-scale search. **If these numbers are inflated by a small multiple**
**due to constraints on gradient learning or other LM-based constraints** (e.g. tokenization,
generalization) **these bounds are outside of any reasonable embedding dimension.**

3For simplicity, as nearly all SoTA retrieval models use unit vectors.

4

<u>Published as a conference paper at ICLR 2026</u>

3.0.1 IMPLICATIONS

**Numerical instantiation** We can illustrate the effects of this lower bound using _γ_ = 0 _._ 1 (score gap
2 _γ_ = 0 _._ 2), which is approximately standard for models based on empirical usage. Thus, equation 2
becomes _d ≥_ �log - _nk_ - _/_ log 11�, with a table for various _k_ and _n_ values in Table 1.

 - _n_
_k_

�log

- _/_ log 11

�, with a table for various _k_ and _n_ values in Table 1.

For _n ≫_ _k_, log

- _nk_ - _≈_ _k_ log( _en/k_ ), so equation 2 forces

        - _<u>k</u>_ <u>log(</u> _<u>en/k</u>_ <u>)</u>

_d_ = Ω

log(1 + 1 _/γ_ )

_._

A stricter margin requirement (larger _γ_ ) demands higher dimension, since log(1 + 1 _/γ_ ) decreases
with _γ_ (feasibility requires _γ_ _≤_ 1, so the denominator is at least log 2).

**Consequences** Due to space and speed requirements, most embeddings used for web-scale search
are quantized or truncated (e.g. through Matryoshka embeddings (Kusupati et al., 2022)) to less
than 1k dimensions, while the largest embeddings used in research are around 4096 (Zhang et al.,
2025). We see that even with a moderate margin, which is needed to handle noise from messy data or
quantization, the lower bounds in Table 1 can already be larger than what is used in practice.

Additional constraints on real-world models (such as needing to generalize, learn from gradient
descent, and use natural language and tokenization) will make the dimension required in practice
much higher. As Table 1 shows, even a small multiple of this lower bound would make the embedding
dimension requirement infeasible. This multiple seems well-founded, as we will show in the next
section from the best-case optimization setting (e.g. free embeddings).

4 EMPIRICAL CONNECTION: BEST CASE OPTIMIZATION

Having established a theoretical limitation of embedding models based on their embedding dimension
_d_, we seek to show that this holds empirically also.

To show the strongest optimization case possible, we design experiments where the vectors themselves
are directly optimizable with gradient descent. <sup>4</sup> We call this “free embedding” optimization, as the
embeddings are free to be optimized and not constrained by natural language, which imposes
constraints on any realistic embedding model. Thus, this shows whether it is feasible for **any**
**embedding** **model** to solve this problem: if the free embedding optimization cannot solve the
problem, real retrieval models will not be able to either. It is also worth noting that we do this by
directly optimizing the embeddings over the target qrel matrix (test set). This will not generalize to a
new dataset, but is done to show the highest performance that could possibly occur.

**Experimental Settings** We create a random document matrix (size _n_ ) and a random query matrix
with top- _k_ sets (of all combinations, i.e. size _m_ = - _nk_ �), both with unit vectors. We then directly

- _n_
_k_

with top- _k_ sets (of all combinations, i.e. size _m_ = - _nk_ �), both with unit vectors. We then directly

optimize for solving the constraints with the Adam optimizer (Kingma & Ba, 2014). <sup>5</sup> Each gradient
update is a full pass through all correct triples (i.e. full dataset batch-size) with the InfoNCE loss
function (Oord et al., 2018), <sup>6</sup> with all other documents as in-batch negatives (i.e. full dataset in batch).
As nearly all embedding models use normalized vectors, we do also (via projected gradient descent).
We perform early stopping when there is no improvement in the loss for 1000 iterations. We gradually
increase the number of documents (and thus the binomial amount of queries) until the optimization is
no longer able to solve the problem (i.e. achieve 100% accuracy). We call this the _critical-n_ point.

We focus on relatively small sizes for _n_, _k_, and _d_ due to the combinatorial explosion of combinations
with larger document values (i.e. 50k docs with top- _k_ of 100 gives 7.7e+311 combinations, which
would be equivalent to the number of query vectors of dimension _d_ in that free embedding experiment).

4This could also be viewed as an embedding model where each query/doc are a separate vector via lookup.
5We found similar results with SGD, but we use Adam for speed and similarity with existing training methods.
6In preliminary experiments, we found that InfoNCE performed best, beating MSE and Margin. As we are

              - _M_               - _<u>dr</u>_ _<u>∈Ri</u>_ <sup>exp(sim(</sup> <sup>_qi,dr_</sup> <sup>)</sup> <sup>_/τ_</sup> <sup>)</sup>

directly optimizing the vectors with full-dataset batches, this is _L_ total = _−_ _M_ <sup><u>1</u></sup> _i_ =1 <sup>log</sup> <u>�</u>

_dk_ _∈D_ <sup>exp(sim(</sup> <sup>_qi,dk_</sup> <sup>)</sup> <sup>_/τ_</sup> <sup>)</sup>
where _D_ is all docs, _dr_ is the relevant documents for query _qi_ and _dk_ are the non-relevant documents. For
experiments with sigmoid learning functions (e.g. Bangachev et al. (2025), see Appendix C)

directly optimizing the vectors with full-dataset batches, this is _L_ total = _−_ _M_ <sup><u>1</u></sup>

_M_

- _Mi_ =1 <sup>log</sup>

5

<u>Published as a conference paper at ICLR 2026</u>

We use _k_ = 2 and increase _n_ by one for each _d_ value until it breaks. We fit a polynomial regression
line to the data so we can model and extrapolate results outwards.

_−_ 10 _._ 5322 + 4 _._ 0309 _d_ + 0 _._ 0520 _d_ <sup>2</sup> + 0 _._ 0037 _d_ <sup>3</sup>
( _r_ <sup>2</sup> =0.999). Extrapolating this curve outward 400
gives the critical-n values (for embedding size):
500k (512), 1.7m (768), 4m (1024), 107m 200
(3072), 250m (4096). We note that this is the
best case: a real embedding model cannot di
0

|Col1|Col2|Col3|Col4|Col5|Col6|
|---|---|---|---|---|---|
|||||||
|<br>|<br>|~~ritical Poi~~<br>Regression|~~ nts~~<br> (Degree|3)||
|<br>|<br>|||||
|||||||
|||||||
|||||||

to match the test qrel matrix (and is constrained d
by factors such as “modeling natural language”).

Figure 2: The critical-n value where the

The results also show that the lower bounds in

dimensionality is too small to successfully

the previous section are a gross underestimate

represent all the top-2 combinations. We plot the

of real-world performance, as Table 1 shows a

trend line as a polynomial function.

lower bound of 4 for _n_ = 100 whereas we see
the free embeddings needing _d >_ 18 (e.g. a 4.5 multiplier even in the no-generalization or natural
language case). Overall, these numbers already show that for web-scale search, even the largest
embedding dimensions with ideal test-set optimization are not enough to model all combinations.

600

400

200

0

d

Figure 2: The critical-n value where the
dimensionality is too small to successfully
represent all the top-2 combinations. We plot the
trend line as a polynomial function.

5 EMPIRICAL CONNECTION: REAL-WORLD DATASETS

The free embedding experiments provide empirical evidence that our theoretical results hold true.
However, they still are abstract - what does this mean for real embedding models? In this section
we (1) draw connections from this theory to existing datasets and (2) create a trivially simple yet
extremely difficult retrieval task for existing SOTA models.

5.1 CONNECTION TO EXISTING DATASETS

Existing retrieval datasets typically use a static evaluation set with limited numbers of queries, as
relevance annotation is expensive to do for each query. This means practically that the space of
queries used for evaluation is a very small sample of the number of potential queries. For example, the
QUEST dataset (Malaviya et al., 2023) has 325k documents and queries with 20 relevant documents
per query, with a total of 3357 queries. The number of unique top-20 document sets that could
be returned with the QUEST corpus would be �32520 _k_ - which is equal to 7.1e+91 (larger than the

estimate of atoms in the observable universe, 10 <sup>82</sup> ). Thus, the 3k queries in QUEST can only cover
an infinitesimally small part of the qrel combination space.

Although it is not possible to instantiate all combinations when using large-scale corpora, search
evaluation datasets are a proxy for what any user would ask for and ideally would be designed to test
many combinations, as users will do. In many cases, developers of new evaluations simply choose
to use fewer queries due to cost or computational expense of evaluation. For example, QUEST’s
query “Novels from 1849 or George Sand novels” combines two categories of novels with the “OR”
operator - one could instantiate new queries to relate concepts through OR’ing other categories
together. Similarly, with the rise of search agents, we see greater usage of hyper-specific queries:
BrowseComp (Wei et al., 2025) has 5+ conditions per query, including range operators. With these
tools, it is possible to sub-select any top- _k_ relevant set with the right operators if the documents are
sufficiently expressive (i.e. non-trivial). Thus, that existing datasets choose to only instantiate some
of these combinations is mainly for practical reasons and not because of a lack of existence.

In contrast to these previous works, we seek to build a dataset that evaluates all combinations of
top- _k_ sets for a small number of documents. Rather than using difficult query operators like QUEST,
BrowseComp, etc. (which are already difficult for reasons outside of the qrel matrix) we choose very
simple queries and documents to highlight the difficulty of representing all top- _k_ sets themselves.

6

<u>Published as a conference paper at ICLR 2026</u>

0.8

0.6

0.4

0.2

0.0

32 512 1024 2048 3072 4096
Embed Dim

32 512 1024 2048 3072 4096
Embed Dim

32 512 1024 2048 3072 4096
Embed Dim

E5-Mistral 7B
Snowflake Arctic L

GritLM 7B
Promptriever Llama3 8B

Qwen3 Embed
Gemini Embed

BM25
GTE-ModernColBERT

Figure 3: Scores on the LIMIT task. Despite the simplicity of the task we see that SOTA models
struggle. We also see that the dimensionality of the model is a limiting factor and that as the
dimension increases, so does performance. Even multi-vector models struggle. Lexical models like
BM25 do very well due to their higher dimensionality. Stars indicate models trained with MRL.

5.2 THE LIMIT DATASET

**Dataset Construction** In order to have a natural language version of this dataset, we need some
way to map combinations of documents into something that could be retrieved with a query. One
simple <sup>7</sup> way to do this is to create a synthetic version with latent variables for queries and documents
and then instantiate it with natural language. For this mapping, we choose to use attributes that
someone could like (i.e. Jon likes Hawaiian pizza, sports cars, etc. ) as they are plentiful and don’t
present issues w.r.t. other items: one can like Hawaiian pizza but dislike pepperoni, all preferences
are valid. We then enforce two constraints for realism: (1) users shouldn’t have too many attributes,
thus keeping the documents short (less than 50 per user) and (2) each query should only ask for one
item to keep the task simple (i.e. “who likes X”). We gather a list of attributes a person could like
through prompting Gemini 2.5 Pro. We then clean it to a final 1850 items by iteratively asking it to
remove duplicates/hypernyms, while also checking the top failures with BM25 to ensure no overlap.

We choose to use 50k documents in order to have a hard but relatively small corpus and 1000 queries
to maintain statistical significance while still being fast to evaluate. For each query, we choose to use
two relevant documents (i.e. _k_ =2), both for simplicity in instantiating and to mirror previous work
(i.e. NQ, HotpotQA, etc. (Kwiatkowski et al., 2019; Yang et al., 2018)).

Our last step is to choose a qrel matrix to instantiate these attributes. Although we could not prove
the hardest qrel matrix definitively with theory, we intuit that our theoretical results imply that the
more interconnected the qrel matrix is (e.g. dense with all combinations) the harder it would be for
models to represent. Following this, we use the qrel matrix with the highest number of documents
for which all combinations would be just above 1000 queries for a top- _k_ of 2 (46 docs, since �462 - is

1035, the smallest above 1k).

We then assign random natural language attributes to the queries, adding these attributes to their
respective relevant documents (c.f. Figure 1). We give each document a random first and last name
from open-source lists of names. Finally, we randomly sample new attributes for each document until
all documents have the same number of attributes. As this setup has many more documents than
those that are relevant to any query (46 relevant documents, 49.95k non-relevant to any query) we
also create a “small” version with only the 46 documents that are relevant to one of the 1000 queries.

**Models** We evaluate the state-of-the-art embedding models including GritLM (Muennighoff et al.,
2024), Qwen 3 Embeddings (Zhang et al., 2025), Promptriever (Weller et al., 2024b), Gemini
Embeddings (Lee et al., 2025), Snowflake’s Arctic Embed Large v2.0 (Yu et al., 2024), and E5

7This is just one way, designed to be realistic and simple. However, our framework allows for any way of
instantiation – not stuck to this arbitrary natural language design.

7

<u>Published as a conference paper at ICLR 2026</u>

1.0

0.8

0.6

0.4

0.2

0.0

32 512 1024 2048 3072 4096
Embed Dim

32 512 1024 2048 3072 4096
Embed Dim

32 512 1024 2048 3072 4096
Embed Dim

E5-Mistral 7B
Snowflake Arctic L

GritLM 7B
Promptriever Llama3 8B

Qwen3 Embed
Gemini Embed

BM25
GTE-ModernColBERT

Figure 4: Scores on the LIMIT small task (N=46) over embedding dimensions. Despite having just
46 documents, models struggle even with recall@10 and cannot solve the task even with recall@20.

Mistral Instruct (Wang et al., 2022; 2023). These models range in embedding dimension (1024 to
4096) as well as in training style (instruction-based, hard negative optimized, etc.). We also evaluate
three non-single vector models to show the distinction: BM25 (Robertson et al., 1995; Lù, 2024),
gte-ModernColBERT (Chaffin, 2025a; Chaffin & Sourty, 2024), and a token-wise TF-IDF. <sup>8</sup>

We show results at the full embedding dimension and also with truncated embedding dimension
(typically used with matryoshka learning, aka MRL (Kusupati et al., 2022)). For models not trained
with MRL this will result in sub-par scores, thus, models trained with MRL are indicated with stars in
the plots. However, as there are no LLMs with an embedding dimension smaller than 384, we include
MRL for all models to small dimensions (32) to show the impact of embedding dimensionality.

**Results** Figure 3 shows the results on the full LIMIT while Figure 4 shows the results on the small
(46 document) version. **The results are surprising - models severely struggle even though the task**
**is trivially simple.** For example, in the full setting models struggle to reach even 20% recall@100
and in the 46 document version models cannot solve the task even with recall@20.

We see that model performance depends crucially on the
embedding dimensionality (better performance with bigger dimensions). Interestingly, models trained with more
diverse instruction, such as Promptriever, perform better,
perhaps because their training allows them to use more
of their embedding space (compared to models which are
trained with MRL and on a smaller range of tasks that
can perhaps be consolidated into a smaller embedding
manifold).

For alternative architectures, GTE-ModernColBERT does
significantly better than single-vector models (although far
from solving the task) while BM25 comes close to perfect
scores. Both of these alterative architectures (sparse and
multi-vector) offer various trade-offs, see §5.3 for analysis.

Figure 5: Training on LIMIT train does
not significantly help, indicating the
issue is not domain shift. But models
can solve it if they overfit to the test set.

1.0

0.8

0.6

0.4

0.2

0.0

32128 256 384 512 768 1024
Embed Dim

**Is this Domain Shift?** Although our queries look similar can solve it if they overfit to the test set.
to standard web search queries, we wondered whether
there could be some domain shift causing the low performance. If so, we would expect that training
on a training set of similar examples would significantly improve performance. On the other hand, if
the task was intrinsically hard, training on the training set would provide little help whereas training
on the test set would allow the model to overfit to those tokens (similar to the free embeddings).

To test this we take an off-the-shelf embedding model and train it on either the training set
(created synthetically using non-test set attributes) or the official test set of LIMIT. We use
lightonai/modernbert-embed-large (Chaffin, 2025c) and fine-tune it on these splits, us

8This model turns each unique item into a token and then does TF-IDF. We build it to show that it gets 100%
on all tasks (as it reverse engineers our dataset construction) and thus we do not include it in future charts.

8

<u>Published as a conference paper at ICLR 2026</u>

100

75

50

25

0

|97.8|Col2|Col3|Col4|Col5|Col6|Col7|Col8|Col9|Col10|Col11|Col12|Col13|LIMIT-Small|Col15|
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
|||83.5|83.5|83.5|83.5|83.5|83.5|83.5|83.5|83.5|83.5|LIMIT-Small Synonyms|LIMIT-Small Synonyms||
|||83.5|||||||||||||
|||||54.3<br>|54.3<br>|54.3<br>|54.3<br>|54.3<br>|54.3<br>|54.3<br>|54.3<br>|54.3<br>|54.3<br>|54.3<br>|
|||||25.6|25.6||~~38.4~~<br>29.5<br>~~19.4~~<br>~~19.0~~<br><br><br><br>|~~38.4~~<br>29.5<br>~~19.4~~<br>~~19.0~~<br><br><br><br>|~~38.4~~<br>29.5<br>~~19.4~~<br>~~19.0~~<br><br><br><br>|~~38.4~~<br>29.5<br>~~19.4~~<br>~~19.0~~<br><br><br><br>|~~38.4~~<br>29.5<br>~~19.4~~<br>~~19.0~~<br><br><br><br>|~~38.4~~<br>29.5<br>~~19.4~~<br>~~19.0~~<br><br><br><br>|~~38.4~~<br>29.5<br>~~19.4~~<br>~~19.0~~<br><br><br><br>|~~38.4~~<br>29.5<br>~~19.4~~<br>~~19.0~~<br><br><br><br>|
|||||25.6|25.6||~~38.4~~<br>29.5<br>~~19.4~~<br>~~19.0~~<br><br><br><br>||||||||
|||~~10.6~~|||||~~12.8~~||~~14.3~~||~~15.1~~<br>8.5<br>~~11.6~~|~~15.1~~<br>8.5<br>~~11.6~~|~~15.1~~<br>8.5<br>~~11.6~~|~~15.1~~<br>8.5<br>~~11.6~~|
||||||||||||||||

BM25 GTE-ColBERT Promptriever 8B GritLM 7B E5-Mistral 7B Snowflake Arctic Qwen3 Embed

Figure 6: Comparing scores on LIMIT small vs LIMIT small (synonym). Using synonyms makes the
task harder so all models perform worse. However, the lexical model (BM25) drops nearly 90%,
performing worse than most single-vector models on the synonym version of LIMIT. Thus, lexical
models have weaknesses of their own (see Section 5.3 for more discussion) and are not a panacea.

ing the full dataset for in batch negatives (excluding positives) using SentenceTransformers (Reimers
& Gurevych, 2019). We show a range of dimensions by projecting the hidden layer down to the
specified size during training (rather than using MRL).

Figure 5 shows the model trained on the training set cannot solve the problem, although it does see
very minor improvement from near zero recall@10 to up to 2.8 recall@10. The lack of performance
gains when training in-domain indicate that poor performance is not due to domain shift. By training
the model on the test set we see it can learn the task, overfitting on the tokens in the test queries. This
aligns with our free embedding results, that it is possible to overfit to the _N_ = 46 version with only
12 dimensions. However, it is notable that the real models with 64 dimensions still cannot completely
solve the task, implying **real models perform significantly worse than the bounds shown in §4** .

**What** **about** **Non-Lexical** **Matches?** Our previous results show that lexical models greatly
outperform their neural counterparts. However, this is not to imply that lexical models are a panacea although they have higher dimensionality than single-vector models, they have other shortcomings.

We illustrate this by creating a version of LIMIT-small that replaces all items in the corpus with their
synonyms, reducing the amount of lexical overlap. We ask Gemini 2.5 Pro to come up with synonyms
that don’t match any other existing synonyms or original items, by using either scientific names,
similar meanings, or if necessary hypernyms. This creates a mapping like “glasses” to “spectacles”,
etc. <sup>9</sup> We repeat the previous experiment on LIMIT-small (synonyms) and compare to LIMIT-small in
Figure 6. We find that all models drop in performance as the task is now more difficult, but BM25
drops the most and now underperforms the neural models (e.g. BM25 drops more than 89% whereas
Qwen3 embedding drops 38.9%). Thus, we can see that although lexical models have strengths like
higher dimensionality, they are limited by their keyword-only matching ability. We expand more
upon their strengths and weaknesses for instruction-following in Section 5.3.

**Implications** Single-vector models are fundamentally limited by their embedding dimension. The
LIMIT dataset is a particular instantiation, with very simple queries and documents, designed to
highlight this property. This small version of LIMIT can be embedded in just 12 dimensions (as
seen in the free embeddings experiments), yet all models fail to perform well, suggesting other
architectural weaknesses. Irrespective of the architecture involved, however, our framework can scale
the dataset’s difficulty to consistently demonstrate this fundamental limitation.

5.3 ALTERNATIVES TO EMBEDDING MODELS

Our previous results show both theoretically and empirically that embedding models cannot represent
all combinations of documents in their top- _k_ sets, making them unable to represent and solve some
retrieval tasks. As current embedding models have grown larger (e.g. up to 4096), this has helped
reduce negative effects for smaller dataset sizes. However, with enough combinations of top- _k_ sets
the dimensionality would have to increase to an infeasible size for non-toy datasets. Thus, although
they are useful for first stage results, more expressive retriever architectures will be needed.

**Cross-Encoders** Although not suitable for first stage retrieval at scale, they are already typically
used to improve first stage results. Is LIMIT challenging for rerankers also? We evaluate a long
context reranker, Gemini-2.5-Pro (Comanici et al., 2025) on the small setting as a comparison. We
give Gemini all 46 documents and all 1000 queries at once, asking it to output the relevant documents
for each query with one generation. We find that it can successfully solve (100%) all 1000 queries in
one forward pass. This is in contrast to even the best embedding models with a recall@2 of less than

9We note that it doesn’t remove all lexical overlap due to items like “Scuba Diving” -> “Underwater Diving”

9

<u>Published as a conference paper at ICLR 2026</u>

60% (Figure 4). Thus we can see that LIMIT is easy for state-of-the-art reranker models, which do
not have the same limitations based on embedding dimension.

**Multi-vector models** Multi-vector models are more expressive through the use of multiple vectors
per sequence combined with the MaxSim operator (Khattab & Zaharia, 2020). These models show
promise on the LIMIT dataset, with scores greatly above the single-vector models despite using a
smaller backbone (ModernBERT, Warner et al. (2024)). However, these models are not generally
used for instruction-following or reasoning-based tasks (see Chaffin (2025b) as one of the few that
exist), leaving it an open question to how well multi-vector techniques will transfer to these tasks.

**Sparse** **models** Sparse models (both lexical and neural) can be thought of as single vectors but
with very high dimensionality. This dimensionality helps BM25 avoid the problems of the neural
embedding models as seen in Figure 3. Since the _d_ of their vectors is high, they can scale to many
more combinations than their dense vector counterparts. However, it is less clear how to apply
sparse models to instruction-following and reasoning-based tasks where there is no lexical or even
paraphrase-like overlap. We leave this direction (and hybrid sparse/dense solutions) to future work.

We note that all of these options have various trade-offs and none provide a clear path to solving this
problem as-is. We leave it to future work to develop new techniques to mitigate these issues: perhaps
through one of these alterative categories or through new ideas around single-vector models that
can resolve the underlying issue (potentially through techniques such as hyperencoders (Killingback
et al., 2025) or other future work on single vector architectures yet to be developed).

6 CONCLUSION

We introduce the LIMIT dataset, which highlights a fundamental limitation of embedding models.
We provide a theoretical connection which shows that, for a fixed embedding dimension there will
be some set of documents such that certain sets are unattainable as top- _k_ sets. We show these
theoretical results hold empirically, through best case optimization of the vectors themselves, and
make a practical connection to existing state-of-the-art models by creating a realistic and simple
instantiation of the theory, called LIMIT, that these models cannot solve. Our results imply that the
community should reconsider how instruction-based retrieval will impact future retrievers.

LIMITATIONS

Although our experiments provide theoretical insight for the most common type of embedding model
(single vector) they do not hold necessarily for other architectures, such as multi-vector models.
Although we showed initial empirical results with non-single vector models, we leave it to future work
to extend our theoretical connections to these settings. We also did not show theoretical results for
the setting where the user allows some mistakes, e.g. capturing only the majority of the combinations.
We leave putting a bound on this scenario to future work and would invite the reader to examine
works like Ben-David et al. (2002).

We have shown the theoretical connection that proves that some combinations cannot be represented
by embedding models, however, we cannot prove apriori which _types_ of combinations they will fail
on. Thus, it is possible that there are some instruction-following or reasoning tasks they can solve
perfectly, however, _we do know_ that there exists some tasks that they will never be able to solve.

ACKNOWLEDGMENTS

We thank Tanmaya Dabral, Zhongli Ding, Anthony Chen, Ming-Wei Chang, Kenton Lee, and Kristina
Toutanova for their helpful feedback. We thank Kiril Bangachev, Guy Bresler, Iliyas Noman, Yury
Polyanskiy, Antonio Vergari, Adam Lopez, and Andreas Grivas for pointers to work on sign-rank.

REFERENCES

Noga Alon, Peter Frankl, and Vojtech Rodl. Geometrical realization of set systems and probabilistic

communication complexity. In _26th Annual Symposium on Foundations of Computer Science (sfcs_
_1985)_, pp. 277–280. IEEE, 1985.

10

<u>Published as a conference paper at ICLR 2026</u>

Samy Badreddine, Emile van Krieken, and Luciano Serafini. Breaking rank bottlenecks in knowledge

graph embeddings. _arXiv preprint arXiv:2506.22271_, 2025.

Kiril Bangachev, Guy Bresler, Iliyas Noman, and Yury Polyanskiy. Global minimizers of sigmoid

contrastive loss. _arXiv preprint arXiv:2509.18552_, 2025.

Peter L Bartlett. The sample complexity of pattern classification with neural networks: the size of the

weights is more important than the size of the network. _IEEE transactions on Information Theory_,
44(2):525–536, 2002.

Parishad BehnamGhader, Vaibhav Adlakha, Marius Mosbach, Dzmitry Bahdanau, Nicolas Chapados,

and Siva Reddy. Llm2vec: Large language models are secretly powerful text encoders. _arXiv_
_preprint arXiv:2404.05961_, 2024.

Shai Ben-David, Nadav Eiron, and Hans Ulrich Simon. Limitations of learning via embeddings in

euclidean half spaces. _Journal of Machine Learning Research_, 3(Nov):441–461, 2002.

Cecilia Bohler, Panagiotis Cheilaris, Rolf Klein, Chih-Hung Liu, Evanthia Papadopoulou, and

Maksym Zavershynskyi. On the complexity of higher order abstract voronoi diagrams. _Com-_
_putational_ _Geometry_, 48(8):539–551, 2015. ISSN 0925-7721. doi: https://doi.org/10.1016/j.
comgeo.2015.04.008. [URL https://www.sciencedirect.com/science/article/](https://www.sciencedirect.com/science/article/pii/S0925772115000346)
[pii/S0925772115000346.](https://www.sciencedirect.com/science/article/pii/S0925772115000346)

Antoine Chaffin. Gte-moderncolbert, 2025a. [URL https://huggingface.co/lightonai/](https://huggingface.co/lightonai/GTE-ModernColBERT-v1)

[GTE-ModernColBERT-v1.](https://huggingface.co/lightonai/GTE-ModernColBERT-v1)

Antoine Chaffin. Reason-moderncolbert, 2025b. URL [https://huggingface.co/](https://huggingface.co/lightonai/Reason-ModernColBERT)
[lightonai/Reason-ModernColBERT.](https://huggingface.co/lightonai/Reason-ModernColBERT)

Antoine Chaffin. Modernbert-embed-large, 2025c. URL [https://huggingface.co/](https://huggingface.co/lightonai/modernbert-embed-large)
[lightonai/modernbert-embed-large.](https://huggingface.co/lightonai/modernbert-embed-large)

Antoine Chaffin and Raphaël Sourty. Pylate: Flexible training and retrieval for late interaction models,

2024. [URL https://github.com/lightonai/pylate.](https://github.com/lightonai/pylate)

Bi Yu Chen, Huihuang Huang, Hui-Ping Chen, Wenxuan Liu, Xuan-Yan Chen, and Tao Jia. Efficient

algorithm for constructing order k voronoi diagrams in road networks. _ISPRS International Journal_
_of Geo-Information_, 12(4):172, 2023.

Kenneth L Clarkson. Applications of random sampling in computational geometry, ii. In _Proceedings_

_of the fourth annual symposium on Computational geometry_, pp. 1–11, 1988.

Gheorghe Comanici, Eric Bieber, Mike Schaekermann, Ice Pasupat, Noveen Sachdeva, Inderjit

Dhillon, Marcel Blistein, Ori Ram, Dan Zhang, Evan Rosen, et al. Gemini 2.5: Pushing the frontier
with advanced reasoning, multimodality, long context, and next generation agentic capabilities.
_arXiv preprint arXiv:2507.06261_, 2025.

John H Conway, Chaim Goodman-Strauss, and N Sloane. Recent progress in sphere packing. _Current_

_Developments in Mathematics_, 1999(1):37–76, 1999.

Nick Craswell, Bhaskar Mitra, Emine Yilmaz, Daniel Campos, and Ellen M Voorhees. Overview of

the trec 2019 deep learning track. _arXiv preprint arXiv:2003.07820_, 2020.

Kenneth Enevoldsen, Isaac Chung, Imene Kerboua, Márton Kardos, Ashwin Mathur, David Stap,

Jay Gala, Wissam Siblini, Dominik Krzemi´nski, Genta Indra Winata, et al. Mmteb: Massive
multilingual text embedding benchmark. _arXiv preprint arXiv:2502.13595_, 2025.

Manuel Faysse, Hugues Sibille, Tony Wu, Bilel Omrani, Gautier Viaud, Céline Hudelot, and Pierre

Colombo. Colpali: Efficient document retrieval with vision language models. _arXiv_ _preprint_
_arXiv:2407.01449_, 2024.

Andreas Grivas, Antonio Vergari, and Adam Lopez. Taming the sigmoid bottleneck: Provably

argmaxable sparse multi-label classification. In _Proceedings of the AAAI Conference on Artificial_
_Intelligence_, volume 38, pp. 12208–12216, 2024.

11

<u>Published as a conference paper at ICLR 2026</u>

Jordan Hoffmann, Sebastian Borgeaud, Arthur Mensch, Elena Buchatskaya, Trevor Cai, Eliza

Rutherford, Diego de Las Casas, Lisa Anne Hendricks, Johannes Welbl, Aidan Clark, et al.
Training compute-optimal large language models. _arXiv preprint arXiv:2203.15556_, 2022.

Gautier Izacard, Mathilde Caron, Lucas Hosseini, Sebastian Riedel, Piotr Bojanowski, Armand

Joulin, and Edouard Grave. Unsupervised dense information retrieval with contrastive learning.
_arXiv preprint arXiv:2112.09118_, 2021.

William B Johnson, Joram Lindenstrauss, et al. Extensions of lipschitz mappings into a hilbert space.

_Contemporary mathematics_, 26(189-206):1, 1984.

Michael J Kearns and Robert E Schapire. Efficient distribution-free learning of probabilistic concepts.

_Journal of Computer and System Sciences_, 48(3):464–497, 1994.

Omar Khattab and Matei Zaharia. Colbert: Efficient and effective passage search via contextualized

late interaction over bert. In _Proceedings of the 43rd International ACM SIGIR conference on_
_research and development in Information Retrieval_, pp. 39–48, 2020.

Julian Killingback, Hansi Zeng, and Hamed Zamani. Hypencoder: Hypernetworks for information

retrieval. In _Proceedings_ _of_ _the_ _48th_ _International_ _ACM_ _SIGIR_ _Conference_ _on_ _Research_ _and_
_Development in Information Retrieval_, pp. 2372–2383, 2025.

Diederik P Kingma and Jimmy Ba. Adam: A method for stochastic optimization. _arXiv preprint_

_arXiv:1412.6980_, 2014.

Aditya Kusupati, Gantavya Bhatt, Aniket Rege, Matthew Wallingford, Aditya Sinha, Vivek Ra
manujan, William Howard-Snyder, Kaifeng Chen, Sham Kakade, Prateek Jain, et al. Matryoshka
representation learning. _Advances in Neural Information Processing Systems_, 35:30233–30249,
2022.

Tom Kwiatkowski, Jennimaria Palomaki, Olivia Redfield, Michael Collins, Ankur Parikh, Chris

Alberti, Danielle Epstein, Illia Polosukhin, Jacob Devlin, Kenton Lee, et al. Natural questions: a
benchmark for question answering research. _Transactions of the Association for Computational_
_Linguistics_, 7:453–466, 2019.

Der-Tsai Lee. On k-nearest neighbor voronoi diagrams in the plane. _IEEE transactions on computers_,

100(6):478–487, 1982.

Jinhyuk Lee, Zhuyun Dai, Xiaoqi Ren, Blair Chen, Daniel Cer, Jeremy R Cole, Kai Hui, Michael

Boratko, Rajvi Kapadia, Wen Ding, et al. Gecko: Versatile text embeddings distilled from large
language models. _arXiv preprint arXiv:2403.20327_, 2024.

Jinhyuk Lee, Feiyang Chen, Sahil Dua, Daniel Cer, Madhuri Shanbhogue, Iftekhar Naim, Gus
tavo Hernández Ábrego, Zhe Li, Kaifeng Chen, Henrique Schechter Vera, et al. Gemini embedding:
Generalizable embeddings from gemini. _arXiv preprint arXiv:2503.07891_, 2025.

Kenton Lee, Ming-Wei Chang, and Kristina Toutanova. Latent retrieval for weakly supervised

open domain question answering. In Anna Korhonen, David Traum, and Lluís Màrquez (eds.),
_Proceedings of the 57th Annual Meeting of the Association for Computational Linguistics_, pp.
6086–6096, Florence, Italy, July 2019. Association for Computational Linguistics. doi: 10.18653/
v1/P19-1612. [URL https://aclanthology.org/P19-1612/.](https://aclanthology.org/P19-1612/)

Chunyuan Li, Zhe Gan, Zhengyuan Yang, Jianwei Yang, Linjie Li, Lijuan Wang, Jianfeng Gao, et al.

Multimodal foundation models: From specialists to general-purpose assistants. _Foundations and_
_Trends® in Computer Graphics and Vision_, 16(1-2):1–214, 2024.

Xing Han Lù. Bm25s: Orders of magnitude faster lexical search via eager sparse scoring. _arXiv_

_preprint arXiv:2407.03618_, 2024.

Xueguang Ma, Sheng-Chieh Lin, Minghan Li, Wenhu Chen, and Jimmy Lin. Unifying multimodal

retrieval via document screenshot embedding. _arXiv preprint arXiv:2406.11251_, 2024.

12

<u>Published as a conference paper at ICLR 2026</u>

Chaitanya Malaviya, Peter Shaw, Ming-Wei Chang, Kenton Lee, and Kristina Toutanova. Quest:

A retrieval dataset of entity-seeking queries with implicit set operations. _arXiv_ _preprint_
_arXiv:2305.11694_, 2023.

Niklas Muennighoff, Nouamane Tazi, Loïc Magne, and Nils Reimers. Mteb: Massive text embedding

benchmark. _arXiv preprint arXiv:2210.07316_, 2022.

Niklas Muennighoff, SU Hongjin, Liang Wang, Nan Yang, Furu Wei, Tao Yu, Amanpreet Singh, and

Douwe Kiela. Generative representational instruction tuning. In _ICLR 2024 Workshop:_ _How Far_
_Are We From AGI_, 2024.

Hanseok Oh, Hyunji Lee, Seonghyeon Ye, Haebin Shin, Hansol Jang, Changwook Jun, and Minjoon

Seo. Instructir: A benchmark for instruction following of information retrieval models. _arXiv_
_preprint arXiv:2402.14334_, 2024.

Aaron van den Oord, Yazhe Li, and Oriol Vinyals. Representation learning with contrastive predictive

coding. _arXiv preprint arXiv:1807.03748_, 2018.

Aitor Ormazabal, Mikel Artetxe, Gorka Labaka, Aitor Soroa, and Eneko Agirre. Analyzing the

limitations of cross-lingual word embedding mappings. _arXiv preprint arXiv:1906.05407_, 2019.

Long Ouyang, Jeffrey Wu, Xu Jiang, Diogo Almeida, Carroll Wainwright, Pamela Mishkin, Chong

Zhang, Sandhini Agarwal, Katarina Slama, Alex Ray, et al. Training language models to follow
instructions with human feedback. _Advances in neural information processing systems_, 35:27730–
27744, 2022.

Christos H Papadimitriou and Michael Sipser. Communication complexity. In _Proceedings of the_

_fourteenth annual ACM symposium on Theory of computing_, pp. 196–200, 1982.

Rohan Paul, Haw-Shiuan Chang, and Andrew McCallum. Multi-facet universal schema. In _Pro-_

_ceedings of the 16th Conference of the European Chapter of the Association for Computational_
_Linguistics:_ _Main Volume_, pp. 909–919, 2021.

Nils Reimers and Iryna Gurevych. Sentence-bert: Sentence embeddings using siamese bert-networks.

In _Proceedings of the 2019 Conference on Empirical Methods in Natural Language Processing_ .
Association for Computational Linguistics, 11 2019. [URL https://arxiv.org/abs/1908.](https://arxiv.org/abs/1908.10084)
[10084.](https://arxiv.org/abs/1908.10084)

Nils Reimers and Iryna Gurevych. The curse of dense low-dimensional information retrieval for large

index sizes. _arXiv preprint arXiv:2012.14210_, 2020.

Stephen E Robertson, Steve Walker, Susan Jones, Micheline M Hancock-Beaulieu, Mike Gatford,

et al. Okapi at trec-3. _Nist Special Publication Sp_, 109:109, 1995.

Tingyu Song, Guo Gan, Mingsheng Shang, and Yilun Zhao. Ifir: A comprehensive benchmark

for evaluating instruction-following in expert-domain information retrieval. _arXiv_ _preprint_
_arXiv:2503.04644_, 2025.

Hongjin Su, Weijia Shi, Jungo Kasai, Yizhong Wang, Yushi Hu, Mari Ostendorf, Wen-tau Yih,

Noah A Smith, Luke Zettlemoyer, and Tao Yu. One embedder, any task: Instruction-finetuned text
embeddings. _arXiv preprint arXiv:2212.09741_, 2022.

Hongjin Su, Howard Yen, Mengzhou Xia, Weijia Shi, Niklas Muennighoff, Han-yu Wang, Haisu Liu,

Quan Shi, Zachary S Siegel, Michael Tang, et al. Bright: A realistic and challenging benchmark
for reasoning-intensive retrieval. _arXiv preprint arXiv:2407.12883_, 2024.

Chameleon Team. Chameleon: Mixed-modal early-fusion foundation models. _arXiv_ _preprint_

_arXiv:2405.09818_, 2024.

Nandan Thakur, Nils Reimers, Andreas Rücklé, Abhishek Srivastava, and Iryna Gurevych. Beir: A

heterogenous benchmark for zero-shot evaluation of information retrieval models. _arXiv preprint_
_arXiv:2104.08663_, 2021.

13

<u>Published as a conference paper at ICLR 2026</u>

Nandan Thakur, Jimmy Lin, Sam Havens, Michael Carbin, Omar Khattab, and Andrew Drozdov.

Freshstack: Building realistic benchmarks for evaluating retrieval on technical documents. _arXiv_
_preprint arXiv:2504.13128_, 2025.

Vladimir Vapnik. _Statistical Learning Theory now plays a more active role: after the general analysis_

_of learning processes, the research in the area of synthesis of optimal algorithms was started. These_
_studies, however, do not belong to history yet. They are a subject of today’s research activities._
PhD thesis, These studies, however, do not belong to history yet. They are a subject of ..., 1998.

Roman Vershynin. _High-dimensional probability:_ _An introduction with applications in data science_,

volume 47. Cambridge university press, 2018.

Georges Voronoi. Nouvelles applications des paramètres continus à la théorie des formes quadra
tiques. deuxième mémoire. recherches sur les parallélloèdres primitifs. _Journal für die reine und_
_angewandte Mathematik (Crelles Journal)_, 1908(134):198–287, 1908.

David Wadden, Shanchuan Lin, Kyle Lo, Lucy Lu Wang, Madeleine van Zuylen, Arman Cohan, and

Hannaneh Hajishirzi. Fact or fiction: Verifying scientific claims. _arXiv preprint arXiv:2004.14974_,
2020.

Liang Wang, Nan Yang, Xiaolong Huang, Binxing Jiao, Linjun Yang, Daxin Jiang, Rangan Majumder,

and Furu Wei. Text embeddings by weakly-supervised contrastive pre-training. _arXiv preprint_
_arXiv:2212.03533_, 2022.

Liang Wang, Nan Yang, Xiaolong Huang, Linjun Yang, Rangan Majumder, and Furu Wei. Improving

text embeddings with large language models. _arXiv preprint arXiv:2401.00368_, 2023.

Benjamin Warner, Antoine Chaffin, Benjamin Clavié, Orion Weller, Oskar Hallström, Said

Taghadouini, Alexis Gallagher, Raja Biswas, Faisal Ladhak, Tom Aarsen, et al. Smarter, better, faster, longer: A modern bidirectional encoder for fast, memory efficient, and long context
finetuning and inference. _arXiv preprint arXiv:2412.13663_, 2024.

Jason Wei, Zhiqing Sun, Spencer Papay, Scott McKinney, Jeffrey Han, Isa Fulford, Hyung Won

Chung, Alex Tachard Passos, William Fedus, and Amelia Glaese. Browsecomp: A simple yet
challenging benchmark for browsing agents. _arXiv preprint arXiv:2504.12516_, 2025.

Orion Weller, Benjamin Chang, Sean MacAvaney, Kyle Lo, Arman Cohan, Benjamin Van Durme,

Dawn Lawrie, and Luca Soldaini. Followir: Evaluating and teaching information retrieval models
to follow instructions. _arXiv preprint arXiv:2403.15246_, 2024a.

Orion Weller, Benjamin Van Durme, Dawn Lawrie, Ashwin Paranjape, Yuhao Zhang, and Jack

Hessel. Promptriever: Instruction-trained retrievers can be prompted like language models. _arXiv_
_preprint arXiv:2409.11136_, 2024b.

Orion Weller, Benjamin Chang, Eugene Yang, Mahsa Yarmohammadi, Sam Barham, Sean MacA
vaney, Arman Cohan, Luca Soldaini, Benjamin Van Durme, and Dawn Lawrie. mfollowir: a
multilingual benchmark for instruction following in retrieval. _arXiv preprint arXiv:2501.19264_,
2025a.

Orion Weller, Kathryn Ricci, Marc Marone, Antoine Chaffin, Dawn Lawrie, and Benjamin Van Durme.

Seq vs seq: An open suite of paired encoders and decoders. _arXiv preprint arXiv:2507.11412_,
2025b.

Orion Weller, Kathryn Ricci, Eugene Yang, Andrew Yates, Dawn Lawrie, and Benjamin Van Durme.

Rank1: Test-time compute for reranking in information retrieval. _arXiv preprint arXiv:2502.18418_,
2025c.

Chenghao Xiao, G Thomas Hudson, and Noura Al Moubayed. Rar-b: Reasoning as retrieval

benchmark. _arXiv preprint arXiv:2404.06347_, 2024.

Zhilin Yang, Peng Qi, Saizheng Zhang, Yoshua Bengio, William W Cohen, Ruslan Salakhutdinov,

and Christopher D Manning. Hotpotqa: A dataset for diverse, explainable multi-hop question
answering. _arXiv preprint arXiv:1809.09600_, 2018.

14

<u>Published as a conference paper at ICLR 2026</u>

Zi Yin and Yuanyuan Shen. On the dimensionality of word embedding. _Advances_ _in_ _neural_

_information processing systems_, 31, 2018.

Puxuan Yu, Luke Merrick, Gaurav Nuti, and Daniel Campos. Arctic-embed 2.0: Multilingual retrieval

without compromise. _arXiv preprint arXiv:2412.04506_, 2024.

Yanzhao Zhang, Mingxin Li, Dingkun Long, Xin Zhang, Huan Lin, Baosong Yang, Pengjun Xie,

An Yang, Dayiheng Liu, Junyang Lin, Fei Huang, and Jingren Zhou. Qwen3 embedding: Advancing text embedding and reranking through foundation models. _arXiv preprint arXiv:2506.05176_,
2025.

Jeffrey Zhou, Tianjian Lu, Swaroop Mishra, Siddhartha Brahma, Sujoy Basu, Yi Luan, Denny

Zhou, and Le Hou. Instruction-following evaluation for large language models. _arXiv preprint_
_arXiv:2311.07911_, 2023.

Jianqun Zhou, Yuanlei Zheng, Wei Chen, Qianqian Zheng, Zeyuan Shang, Wei Zhang, Rui Meng,

and Xiaoyu Shen. Beyond content relevance: Evaluating instruction following in retrieval models.
_ArXiv_, abs/2410.23841, 2024. [URL https://api.semanticscholar.org/CorpusID:](https://api.semanticscholar.org/CorpusID:273707185)

[273707185.](https://api.semanticscholar.org/CorpusID:273707185)

15

<u>Published as a conference paper at ICLR 2026</u>

A RELATIONSHIP TO ORDER-K VORONOI REGIONS

We also provide an explanation for how our results compare to Clarkson (1988) which put bounds
on the number of regions in the order- _k_ Voronoi graph. The order- _k_ Voronoi graph is defined as the
set of points having a particular set of _n_ points in _S_ as its _n_ nearest neighbors. This maps nicely to
retrieval, as each order- _k_ region is equivalent to one retrieved set of top- _k_ results. Then the count of
unique regions in the Voronoi graph is the total number of combinations that could be returned for
those points. However, creating an empirical order-k Voronoi graph is computationally infeasible for
_d_ - 3, and theoretically it is hard to bound tightly. Thus we use a different approach for showing the
limitations of embedding models.

B HYPERPARAMETER AND COMPUTE DETAILS

**Inference** We use the default length settings for evaluating models using the MTEB framework
(Enevoldsen et al., 2025). As our dataset has relatively short documents (around 100 tokens), this
does not cause an issue.

**Training** For training on the LIMIT training and test set we use the SentenceTransformers library
(Reimers & Gurevych, 2019) using the MultipleNegativesRankingLoss. We use a full dataset batch
size and employ the no duplicates sampler to ensure that no in-batch negatives are duplicates of the
positive docs. We use a learning rate of 5e-5. We train for 5 epochs and limit the training set slightly
to the size of the test set (from 2.5k to 2k examples, matching test).

**Compute** Inference and training for LIMIT is done with A100 GPUs on Google Colab Pro. The
free embedding experiments are done mainly on H100 GPUs and TPU v5’s for larger size _N_ to
accommodate higher VRAM for full-dataset batch vector optimization.

C SIGMOID LOSS FUNCTION FOR FREE EMBEDDINGS

In concurrent work by Bangachev et al. (2025), they show that for vision-language embedding models
like CLIP (that more commonly use sigmoid loss functions) that the free-embedding experiments can
be solved in fewer dimensions than in our setting (assuming no margin). As our results found the
best performance with InfoNCE, which attempts to create the widest possible margin, this indicates
that there are additional questions to resolve around learnability. We welcome further insight into
this question both theoretically and empirically, as there exists widely disparate practices between
the vision-language community (where sigmoid loss functions are often SOTA) and the text-only
community (where sigmoid loss functions are almost never used due to worse performance).

This sigmoid learning is also closely related to other work, such as Grivas et al. (2024) and generally
on the topic of work such as (Badreddine et al., 2025; Paul et al., 2021)

D PROOF USING SIGN-RANK

In the initial version of this paper, we provided a theoretical bound without any margin requirement
based on the qrel matrices _sign rank_ . Although the proof is correct, the sign rank of the - _nk_ - matrix has

- _n_
_k_

based on the qrel matrices _sign rank_ . Although the proof is correct, the sign rank of the - _nk_ - matrix has

been established in previous work (Alon et al., 1985) and only depends on k. We include the proof
connecting notions relevant for retrieval with the classic notion of sign-rank, however we emphasize
that this will provide a weaker requirement on dimension as it assumes no margin.

D.1 FORMALIZATION

We consider a set of _m_ queries and _n_ documents with a ground-truth relevance matrix _A ∈{_ 0 _,_ 1 _}_ <sup>_m×n_</sup>,
where _Aij_ = 1 if and only if document _j_ is relevant to query _i_ . <sup>10</sup> Vector embedding models map each
query to a vector _ui_ _∈_ R <sup>_d_</sup> and each document to a vector _vj_ _∈_ R <sup>_d_</sup> . Relevance is modeled by the dot
product _u_ <sup>_T_</sup> _i_ <sup>_vj_</sup> <sup>, with the goal that relevant documents should score higher than irrelevant ones.</sup>

10The matrix _A_ is often called the “qrels” (query relevance judgments) matrix in information retrieval.

16

<u>Published as a conference paper at ICLR 2026</u>

Concatenating the vectors for queries in a matrix _U_ _∈_ R <sup>_d×m_</sup> and those for documents in a matrix
_V_ _∈_ R <sup>_d×n_</sup>, these dot products are the entries of the score matrix _B_ = _U_ <sup>_T_</sup> _V_ . The smallest embedding
dimension _d_ that can realize a given score matrix is, by definition, the rank of _B_ . Therefore, our
goal is equivalent to finding the minimum rank of a score matrix _B_ that correctly orders documents
according to the relevance specified in _A_, which we formalize in the following definition.

**Definition 1.** Given a matrix _A ∈_ R <sup>_m×n_</sup>, the **row-wise order-preserving rank of** _A_ is the smallest
integer _d_ such that there exists a rank- _d_ matrix _B_ that preserves the relative order of entries in each
row of _A_ . We denote this as

rankrop _A_ = min _{_ rank _B_ _| B_ _∈_ R <sup>_m×n_</sup> _,_ such that for all _i, j, k,_ if _Aij_ _> Aik_ then _Bij_ _> Bik}._

In other words, if _A_ is a binary ground-truth relevance matrix, rankrop _A_ is the minimum dimension
necessary for any vector embedding model to return relevant documents before irrelevant ones for
all queries. Alternatively, we might require that the scores of relevant documents can be cleanly
separated from those of irrelevant ones by a threshold.

**Definition 2.** Given a binary matrix _A ∈{_ 0 _,_ 1 _}_ <sup>_m×n_</sup> :

- The **row-wise thresholdable rank of** _A_ (rankrt _A_ ) is the minimum rank of a matrix _B_ for which
there exist row-specific thresholds _{τi}_ <sup>_m_</sup> _i_ =1 <sup>such that for all</sup> <sup>_i, j_</sup> <sup>,</sup> <sup>_Bij_</sup> <sup>_> τi_</sup> <sup>if</sup> <sup>_Aij_</sup> <sup>= 1 and</sup> <sup>_Bij_</sup> <sup>_< τi_</sup>

if _Aij_ = 0.

- The **globally thresholdable rank of** _A_ (rankgt _A_ ) is the minimum rank of a matrix _B_ for which
there exists a single threshold _τ_ such that for all _i, j_, _Bij_ _> τ_ if _Aij_ = 1 and _Bij_ _< τ_ if _Aij_ = 0.

**Remark** **1.** This two-sided separation condition may be seen as slightly stronger than requiring
_Bij_ _> τi_ if and only if _Aij_ = 1, however since there are only finitely many elements of _Bij_ we could
always perturb the latter threshold by a sufficient number such that the two-sided condition holds. <sup>11</sup>

D.2 THEORETICAL BOUNDS

For binary matrices, row-wise ordering/thresholding are equivalent notions of representation capacity.

**Proposition 1.** _For a binary matrix A ∈{_ 0 _,_ 1 _}_ <sup>_m×n_</sup> _, we have that_ rank _rop A_ = rank _rt A._

_Proof._ ( _≤_ ) Suppose _B_ and _τ_ satisfy the row-wise thresholdable rank condition. Since _A_ is a binary
matrix _Aij_ _>_ _Aik_ implies _Aij_ = 1 and _Aik_ = 0, thus _Bij_ _>_ _τi_ _>_ _Bik_, and hence _B_ also satisfies
the row-wise order-preserving condition.

( _≥_ ) Let _B_ satisfy the row-wise order-preserving condition, so _Aij_ _>_ _Aik_ implies _Bij_ _>_ _Bik_ . For
each row _i_, let _Ui_ = _{Bij_ _|_ _Aij_ = 1 _}_ and _Li_ = _{Bij_ _|_ _Aij_ = 0 _}_ . The row-wise order-preserving
condition implies that every element of _Ui_ is greater than every element of _Li_ . We can therefore
always find a threshold _τi_ separating them ( _e.g_ . _τi_ = (max _Li_ + min _Ui_ ) _/_ 2 if both are non-empty,
trivial otherwise). Thus _B_ is also row-wise thresholdable to _A_ .

The notions we have described so far are closely related to the sign rank of a matrix, which we use in
the rest of the paper to establish our main bounds.

**Definition 3** (Sign Rank) **.** The sign rank of a matrix _M_ _∈{−_ 1 _,_ 1 _}_ <sup>_m×n_</sup> is the smallest integer _d_ such
that there exists a rank _d_ matrix _B_ _∈_ R <sup>_m×n_</sup> whose entries have the same sign as those of _M_, i.e.

rank _± M_ = min _{_ rank _B_ _| B_ _∈_ R <sup>_m×n_</sup> such that for all _i, j_ we have sign _Bij_ = _Mij}._

In what follows, we use **1** _n_ to denote the _n_ -dimensional vector of ones, and **1** _m×n_ to denote an
_m × n_ matrix of ones.

**Proposition 2.** _Let A ∈{_ 0 _,_ 1 _}_ <sup>_m×n_</sup> _be a binary matrix._ _Then_ 2 _A −_ **1** _m×n_ _∈{−_ 1 _,_ 1 _}_ <sup>_m×n_</sup> _and_

rank _±_ (2 _A −_ **1** _m×n_ ) _−_ 1 _≤_ rank _rop A_ = rank _rt A ≤_ rank _gt A ≤_ rank _±_ (2 _A −_ **1** _m×n_ )

11Without loss of generality, we may assume the thresholds in the above definitions are not equal to any
elements of _B_ since we could increase the threshold of _τ_ by a sufficiently small _ϵ_ to preserve the inequality.

17

<u>Published as a conference paper at ICLR 2026</u>

_Proof._ N.b. the equality was already shown in Proposition 1. We prove each inequality separately.

**1.** rank **rt** _A ≤_ rank **gt** _A_ **:** True by definition, since any matrix satisfying the globally thresholdable
condition trivially satisfies a row-wise thresholdable condition with the same threshold for each row.

**2.** rank **gt** _A_ _≤_ rank _±_ (2 _A −_ **1** _m×n_ ) **:** Let _B_ be any matrix whose entries have the same sign as
2 _A −_ **1** _m×n_, then
_Bij_ _>_ 0 _⇐⇒_ 2 _Aij_ _−_ 1 _>_ 0 _⇐⇒_ _Aij_ = 1 _._

Thus _B_ satisfies the globally thresholdable condition with a threshold of 0.

**3.** rank _±_ (2 _A −_ **1** _m×n_ ) _−_ 1 _≤_ rank **rt** _A_ **:** Suppose _B_ satisfies the row-wise thresholdable condition
with minimal rank, so rankrt _A_ = rank _B_ and there exists _τ_ _∈_ R <sup>_m_</sup> such that _Bij_ _>_ _τi_ if _Aij_ = 1
and _Bij_ _<_ _τi_ if _Aij_ = 0. Then the entries of _B −_ _τ_ **1** <sup>_T_</sup> _n_ <sup>have the same sign as 2</sup> <sup>_A −_</sup> <sup>**1**</sup> <sup>_m×n_</sup> <sup>, since</sup>

and _Bij_ _<_ _τi_ if _Aij_ = 0. Then the entries of _B −_ _τ_ **1** <sup>_T_</sup> _n_ <sup>have the same sign as 2</sup> <sup>_A −_</sup> <sup>**1**</sup> <sup>_m×n_</sup> <sup>, since</sup>

( _B −_ _τ_ **1** <sup>_T_</sup> _n_ <sup>)</sup> <sup>_ij_</sup> <sup>=</sup> <sup>_Bij_</sup> <sup>_−_</sup> <sup>_τi_</sup> <sup>and</sup>

<sup>_T_</sup> _n_ <sup>)</sup> <sup>_ij_</sup> <sup>=</sup> <sup>_Bij_</sup> <sup>_−_</sup> <sup>_τi_</sup> <sup>and</sup>

_Bij_ _−_ _τi_ _>_ 0 _⇐⇒_ _Aij_ = 1 _⇐⇒_ 2 _Aij_ _−_ 1 _>_ 0 _,_ and (3)
_Bij_ _−_ _τi_ _<_ 0 _⇐⇒_ _Aij_ = 0 _⇐⇒_ 2 _Aij_ _−_ 1 _<_ 0 _._ (4)

Thus rank _±_ (2 _A −_ **1** _m×n_ ) _≤_ rank( _B −_ _τ_ **1** <sup>_T_</sup> _n_

<sup>_T_</sup> _n_ <sup>)</sup> <sup>_≤_</sup> <sup>rank(</sup> <sup>_B_</sup> <sup>) + rank(</sup> <sup>_τ_</sup> <sup>**1**</sup> <sup>_T_</sup> _n_

<sup>_T_</sup> _n_ <sup>) = rankrt</sup> <sup>_A_</sup> <sup>+ 1.</sup>

Combining these gives the desired chain of inequalities.

D.3 CONSEQUENCES

In the context of a vector embedding model, this provides a lower and upper bound on the dimension of
vectors required to exactly capture a given set of retrieval objectives, in the sense of row-wise ordering,
row-wise thresholding, or global thresholding. In particular, given some binary relevance matrix
_A ∈{_ 0 _,_ 1 _}_ <sup>_m×n_</sup>, we need at least rank _±_ (2 _A −_ **1** _m×n_ ) _−_ 1 dimensions to capture the relationships in
_A_ exactly, and can always accomplish this in at most rank _±_ (2 _A −_ **1** _m×n_ ) dimensions.

The cyclotomic polynomial construction presented in Alon et al. (1985) implies that any qrel matrix
has sign-rank at most 2 _k_, where _k_ is the largest number of documents for a particular query. The
construction results in unnormalized vectors, however this can be easily adapted to normalized vectors
by using one additional dimension. In agreement with Theorem 1, this construction requires infinite
precision in general, and is thus not feasible in practice.

D.4 CORRELATION WITH MTEB

BEIR (used in MTEB v1) (Thakur et al., 2021; Muennighoff
et al., 2022) has frequently been cited as something that embedding models have overfit to (Weller et al., 2025c; Thakur
et al., 2025). We compare performance on LIMIT to BEIR
in Figure 7. We see that performance is generally not correlated and that smaller models (like Arctic Embed) do worse on
both, likely due to embedding dimension and pre-trained model
knowledge.

E LLM USAGE

62

60

58

56

0.0 0.1 0.2
Limit Recall@100

Figure 7: No obvious correlation

between BEIR vs LIMIT.

LLMs were not used for any paper writing, only for coding help and title brainstorming.

F METRICS MEASURING QREL GRAPH DENSITY

We show two metrics that treat the qrel matrix as a graph and show that LIMIT has unique properties
compared to standard IR datasets (Table 2). We call these metrics Graph Density and Average Query
Strength and describe them below.

**Graph Density** We use the qrel matrix to construct the graph, where nodes are documents and an
edge exists between two documents if they are both relevant to at least one common query.

18

<u>Published as a conference paper at ICLR 2026</u>

For a given graph _G_ = ( _V, E_ ) with _V_ being the set of nodes and _E_ being the set of edges, the graph
density is defined as the ratio of the number of edges in the graph to the maximum possible number
of edges. For an undirected graph, the maximum possible number of edges is <sup>_<u>|V |</u>_</sup> <sup><u>(</u></sup> <sup>_<u>|V</u>_</sup> 2 <sup>_<u>|−</u>_</sup> <sup><u>1)</u></sup> . Thus, the

density _ρ_ is calculated as:

_<u>|E|</u>_
_ρ_ =

_<u>E|</u>_ <u>2</u> _<u>|E|</u>_

=

_<u>V |−</u>_ <u>1)</u> _|V |_ ( _|V | −_ 1)

2

_<u>|V |</u>_ <u>(</u> _<u>|V |−</u>_ <u>1)</u>

This metric indicates how connected the graph is; a density of 1 signifies a complete graph (all
possible edges exist), while a density close to 0 indicates a sparse graph. For a qrel dataset, the

**Average Query Strength** In a query-query graph where nodes are queries and edges represent
similarity between queries (e.g., Jaccard similarity of their relevant documents), the _strength_ of a
query node _i_, denoted _si_, is defined as the sum of the weights of all edges incident to it. If _wij_ is the
weight of the edge between query _i_ and query _j_, and _N_ ( _i_ ) is the set of neighbors of query _i_, then the
strength is:

_si_ =

_j∈N_ ( _i_ )

_wij_

The Average Query Strength ¯ _s_ is the mean of these strengths across all query nodes in the graph:

<u>1</u>
_s_ ¯ =
_|VQ|_

_i∈VQ_

_si_

where _VQ_ is the set of all query nodes in the graph. This metric provides an overall measure of how
strongly connected queries are to each other on average within the dataset, based on their shared
relevant documents.

**Comparisons to other datasets** We compare with standard IR Datasets such as NQ (Kwiatkowski
et al., 2019), HotpotQA (Yang et al., 2018), and SciFact (Wadden et al., 2020). We also show an
instruction-following dataset, FollowIR Core17 (Weller et al., 2024a). For all datasets, we use the
test set only. The results in Table 2 show that LIMIT has significantly higher values for both of these
metrics (i.e. 28 for query similarity compared to 0.6 or lower for the others).

Table 2: Metrics measuring the density of the qrel matrix. We see that LIMIT is significantly higher
than other datasets, but that the closest are instruction-following datasets such as Core17 from
FollowIR. Our empirical ablations suggest (although cannot definitively prove) that datasets with
higher values here will be harder for retrieval models to represent.

**Dataset Name** **Graph Density** **Average Query Strength**

NQ 0 0
HotPotQA 0.000037 0.1104
SciFact 0.001449 0.4222
FollowIR Core17 0.025641 0.5912
LIMIT 0.085481 28.4653

G TABLE FORMS OF FIGURES

In this section we show the table form of various figures. For Figure 3 it is Table 5, Figure 4 in
Table 4, Figure 2 in Table 6, and Figure 5 in Table 3.

19

<u>Published as a conference paper at ICLR 2026</u>

Split Dim Recall@2 Recall@10 Recall@100

Test 32 85.5 98.4 100.0
Test 64 90.4 98.7 100.0
Test 128 93.1 99.5 99.9
Test 256 94.2 99.7 100.0
Test 384 95.6 99.6 100.0
Test 512 94.0 99.5 99.9
Test 768 96.1 99.8 100.0
Test 1024 96.5 99.8 100.0

Train 32 0.0 0.0 0.0
Train 64 0.1 0.3 2.2
Train 128 0.2 0.7 3.1
Train 256 0.0 0.0 0.4
Train 384 1.1 2.7 8.3
Train 512 0.7 2.3 9.8
Train 768 0.7 2.4 9.9
Train 1024 1.0 2.8 11.2

Table 3: Fine-tuning results in table form. See Figure 5 for the comparable plot.

20

<u>Published as a conference paper at ICLR 2026</u>

Model Dim Recall@2 Recall@10 Recall@20

BM25 default 97.8 100.0 100.0
E5-Mistral 7B 32 7.9 32.6 56.2
E5-Mistral 7B 64 10.2 37.0 60.3
E5-Mistral 7B 128 14.5 41.9 65.9
E5-Mistral 7B 256 15.3 45.9 69.7
E5-Mistral 7B 512 22.2 54.7 74.8
E5-Mistral 7B 768 21.6 57.5 79.2
E5-Mistral 7B 1024 24.5 60.5 80.0
E5-Mistral 7B 2048 28.9 66.3 83.2
E5-Mistral 7B 3072 29.9 67.8 85.3
E5-Mistral 7B 4096 29.5 68.1 85.2
GTE-ModernColBERT default 83.5 97.6 99.1
GritLM 7B 32 7.8 33.5 56.3
GritLM 7B 64 9.4 35.9 59.6
GritLM 7B 128 14.2 42.7 64.9
GritLM 7B 256 17.3 46.2 68.3
GritLM 7B 512 21.8 55.6 76.7
GritLM 7B 768 23.8 58.1 80.1
GritLM 7B 1024 26.2 61.4 80.1
GritLM 7B 2048 33.0 69.1 86.2
GritLM 7B 3072 36.3 72.9 89.9
GritLM 7B 4096 38.4 75.4 90.5
Promptriever Llama3 8B 32 6.1 31.4 56.0
Promptriever Llama3 8B 64 8.9 35.8 62.3
Promptriever Llama3 8B 128 13.7 44.5 67.6
Promptriever Llama3 8B 256 18.5 52.1 74.1
Promptriever Llama3 8B 512 27.0 61.8 81.7
Promptriever Llama3 8B 768 35.5 69.0 84.7
Promptriever Llama3 8B 1024 38.0 73.5 89.1
Promptriever Llama3 8B 2048 46.2 83.6 94.2
Promptriever Llama3 8B 3072 49.2 87.3 96.6
Promptriever Llama3 8B 4096 54.3 90.0 97.7
Qwen3 Embed 32 8.3 30.6 53.9
Qwen3 Embed 64 9.4 35.5 57.6
Qwen3 Embed 128 11.6 38.3 60.8
Qwen3 Embed 256 14.3 41.6 63.8
Qwen3 Embed 512 16.1 43.7 66.0
Qwen3 Embed 768 17.2 45.3 69.3
Qwen3 Embed 1024 17.8 48.7 70.3
Qwen3 Embed 2048 19.5 51.5 72.4
Qwen3 Embed 3072 19.3 52.8 73.3
Qwen3 Embed 4096 19.0 52.3 73.8
Gemini Embed 2 4.2 23.0 45.5
Gemini Embed 4 4.2 21.9 46.0
Gemini Embed 8 4.9 23.2 47.0
Gemini Embed 16 5.2 24.7 47.5
Gemini Embed 32 6.3 25.2 50.6
Gemini Embed 64 6.9 30.6 55.0
Gemini Embed 128 7.7 37.0 62.9
Gemini Embed 256 14.6 46.9 69.7
Gemini Embed 512 23.3 58.4 77.9
Gemini Embed 768 28.8 67.5 84.5
Gemini Embed 1024 31.8 69.9 86.1
Gemini Embed 2048 31.9 70.3 87.1
Gemini Embed 3072 33.7 72.4 87.9
Snowflake Arctic L 32 8.3 30.3 53.8
Snowflake Arctic L 64 9.0 35.4 58.5
Snowflake Arctic L 128 12.7 41.3 65.1
Snowflake Arctic L 256 16.0 48.2 72.6
Snowflake Arctic L 512 16.7 51.3 74.1
Snowflake Arctic L 768 17.9 53.5 74.6
Snowflake Arctic L 1024 19.4 54.9 76.0
Snowflake Arctic L 2048 19.4 54.9 76.0
Snowflake Arctic L 3072 19.4 54.9 76.0
Snowflake Arctic L 4096 19.4 54.9 76.0

Table 4: Results for the LIMIT small version. See comparable Figure 4.

21

<u>Published as a conference paper at ICLR 2026</u>

Model Dim Recall@2 Recall@10 Recall@100

E5-Mistral 7B 32 0.0 0.0 0.5
E5-Mistral 7B 64 0.0 0.1 0.4
E5-Mistral 7B 128 0.1 0.3 1.0
E5-Mistral 7B 256 0.4 0.9 1.9
E5-Mistral 7B 512 0.7 1.3 3.8
E5-Mistral 7B 768 0.9 1.7 4.3
E5-Mistral 7B 1024 0.9 1.8 5.9
E5-Mistral 7B 2048 1.0 1.9 6.8
E5-Mistral 7B 3072 1.3 2.0 7.7
E5-Mistral 7B 4096 1.3 2.2 8.3
Snowflake Arctic L 32 0.0 0.1 0.6
Snowflake Arctic L 64 0.2 0.4 1.7
Snowflake Arctic L 128 0.1 0.3 1.8
Snowflake Arctic L 256 0.2 0.8 2.5
Snowflake Arctic L 512 0.3 1.0 2.5
Snowflake Arctic L 768 0.4 1.1 3.1
Snowflake Arctic L 1024 0.4 0.8 3.3
Snowflake Arctic L 2048 0.4 0.8 3.3
Snowflake Arctic L 3072 0.4 0.8 3.3
Snowflake Arctic L 4096 0.4 0.8 3.3
GritLM 7B 32 0.0 0.0 0.8
GritLM 7B 64 0.0 0.1 0.3
GritLM 7B 128 0.1 0.3 1.3
GritLM 7B 256 0.1 0.4 2.8
GritLM 7B 512 0.6 1.8 6.5
GritLM 7B 768 1.5 3.1 8.7
GritLM 7B 1024 1.8 3.5 10.6
GritLM 7B 2048 2.3 4.3 11.8
GritLM 7B 3072 2.0 4.3 12.9
GritLM 7B 4096 2.4 4.1 12.9
Promptriever Llama3 8B 32 0.0 0.0 0.1
Promptriever Llama3 8B 64 0.0 0.0 0.3
Promptriever Llama3 8B 128 0.0 0.1 0.6
Promptriever Llama3 8B 256 0.2 0.4 1.8
Promptriever Llama3 8B 512 0.6 1.4 5.4
Promptriever Llama3 8B 768 1.3 3.1 8.7
Promptriever Llama3 8B 1024 2.1 4.4 12.8
Promptriever Llama3 8B 2048 3.2 6.5 18.1
Promptriever Llama3 8B 3072 2.9 6.3 17.8
Promptriever Llama3 8B 4096 3.0 6.8 18.9
Qwen3 Embed 32 0.0 0.1 1.1
Qwen3 Embed 64 0.0 0.2 1.0
Qwen3 Embed 128 0.3 0.4 1.8
Qwen3 Embed 256 0.4 0.8 3.2
Qwen3 Embed 512 0.6 1.3 3.3
Qwen3 Embed 768 0.7 1.5 3.8
Qwen3 Embed 1024 0.7 1.6 4.6
Qwen3 Embed 2048 0.9 1.7 4.7
Qwen3 Embed 3072 0.8 1.6 4.8
Qwen3 Embed 4096 0.8 1.8 4.8
Gemini Embed 2 0.0 0.0 0.1
Gemini Embed 4 0.0 0.0 0.0
Gemini Embed 8 0.0 0.0 0.0
Gemini Embed 16 0.0 0.0 0.0
Gemini Embed 32 0.0 0.0 0.0
Gemini Embed 64 0.0 0.0 0.3
Gemini Embed 128 0.0 0.1 0.3
Gemini Embed 256 0.0 0.1 1.2
Gemini Embed 512 0.2 1.1 3.6
Gemini Embed 768 0.9 2.5 7.6
Gemini Embed 1024 1.3 2.7 8.1
Gemini Embed 2048 1.5 3.1 8.5
Gemini Embed 3072 1.6 3.5 10.0
GTE-ModernColBERT default 23.1 34.6 54.8
BM25 default 85.7 90.4 93.6

Table 5: Results on LIMIT. See comparable Figure 3.

22

<u>Published as a conference paper at ICLR 2026</u>

_d_ Critical- _n_

4 10
5 14
6 19
7 24
8 28
9 32
10 36
11 42
12 47
13 54
14 62
15 70
16 79
17 89
18 99
19 109
20 120
21 132
22 144
23 157
24 170
25 184
26 198
27 213
28 229
29 245
30 261
31 278
32 296
33 314
34 333
35 352
36 372
37 392
38 413
39 434
40 460
41 484
42 505
43 545
44 605
45 626

Table 6: Critical Values of n for different d values in the Free Embedding optimization experiments.

See Figure 2 for the corresponding figure.

Model BEIR LIMIT R@100

Snowflake Arctic 55.22 3.3
Promptriever 56.40 18.9
E5-Mistral 57.07 8.3
GritLM 57.40 12.9
Gemini Embed 62.65 10.0
Qwen3 Embed 62.76 4.8

Table 7: BEIR vs LIMIT results. See Figure 7 for the comparable plot.

23
