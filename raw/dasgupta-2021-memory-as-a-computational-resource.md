---
title: "Memory as a Computational Resource"
source: "https://www.sciencedirect.com/science/article/pii/S1364661320303053?via%3Dihub"
author:
  - "[[Samuel J. Gershman]]"
published:
created: 2026-10-13
description: "Computer scientists have long recognized that naive implementations of algorithms often result in a paralyzing degree of redundant computation. More s…"
tags:
  - "clippings"
---
### Published by![Society Logo](https://ars.els-cdn.com/content/image/Dcellpress.gif)

Society Logo

## Review

,

[View **PDF**](https://www.sciencedirect.com/science/article/pii/S1364661320303053/pdfft?md5=1c26287420d7620b1d726759c04b438f&pid=1-s2.0-S1364661320303053-main.pdf) [View Open Manuscript](https://www.sciencedirect.com/science/article/am/pii/S1364661320303053)

[10.1016/j.tics.2020.12.008](https://doi.org/10.1016/j.tics.2020.12.008)

## Highlights

## Keywords

memory

;

mental arithmetic

;

mental imagery

;

inference

;

planning

;

amortization

- [Previous article in this issue](https://www.sciencedirect.com/science/article/pii/S1364661320303016)
- [Next article in this issue](https://www.sciencedirect.com/science/article/pii/S136466132030303X)

## The Efficiency of Computational Reuse

Many computational problems would be impossible to solve without the use of memory. Consider, for example, the problem of finding the shortest path between two locations. Naively, you might try solving this problem by brute force, enumerating all possible *n* -step paths. If at each step you can move in one of *k* directions, then you would have to enumerate *k* <sup><em>n</em></sup> paths, an astronomical number for even small *n* (for just ten steps and four directions, there are over one million possible paths). Fortunately, the problem has internal structure that can be exploited: some paths are subcomponents of longer paths, so you can reuse computation of the subpaths when computing the longer path. If you already know the shortest paths from A to B and B to C, you can combine them to find the shortest path from A to C going through B; all other paths touching these three locations can be ignored. To apply this strategy, it is necessary to store information about subpaths so that they can be reused later. Path planning is an example of how the recursive structure of a problem can be used to implement a **space–time trade-off** (see ): redundant computation (which costs time) can be avoided by storing partial solutions in memory (which costs space) \[\].

The idea that responses can be stored in memory and reused to answer future queries has a long history in cognitive science. Caching is implicit in the work of De Groot \[\] and Newell *et al*. \[\] and has been advocated more explicitly by Logan and his colleagues \[\]. A rather different (but equally ubiquitous) role for memory has been developed in production system architectures like ACT-R \[\] and SOAR \[\], where memory serves to strengthen and link together elementary computations (productions) into more complex cognitive skills. We discuss these cognitive models of computational reuse in. Modern computer science approaches to computational reuse go beyond these models to provide practical solutions to the issues of generalization, persistence, and decomposition, as we discuss in the next section.

Box 1

Comparing Cognitive Models of Reuse

Logan’s instance theory of automaticity \[\] exemplifies the top-down approach to computational reuse: function outputs (problem solutions) are stored with their inputs (stimuli) and retrieved whenever a new input matches the stored input. This form of reuse is top-down in the sense that the output of the most complex function call is stored and reused; all intermediate computations are forgotten. This has the advantage, shared with classical memoization techniques, that it is simple to implement and can be applied very generally, but also shares the disadvantage of failing to exploit the internal structure of complex computations. For example, many probabilistic inference algorithms exploit conditional independence (e.g., the Markov property; ) to break complex problems down into simpler subproblems. Stored solutions to these subproblems can then be used to assemble solutions to the complex problems.

Production system architectures such as ACT-R \[,\] and SOAR \[\] exemplify the bottom-up approach to computational reuse: intermediate computations (productions) can be strengthened, making them more likely to be activated in the future. They can also be compiled to form more complex computations (chunks) that are then subject to strengthening. This approach has the advantage that it can flexibly reuse intermediate computations when this is advantageous. In practice, this form of reuse can be tricky to implement effectively. Storing intermediate computations means that there is a very large database, placing onerous demands on storage and retrieval \[\].

Another issue for reuse in production systems concerns the normative assumptions underlying strengthening procedures. In the ACT-R architecture \[\], strengthening is based on the marginal probability of evoking a production or chunk. This implicitly assumes that the posterior over production/chunk sequences is factorized, similar to mean-field approximations in variational inference \[\]. This assumption is computationally convenient because it avoids the problem of computing a posterior over the combinatorial space of sequences. However, the cost is that such an approximation can be highly inaccurate.

We begin this review with a general overview of computational reuse strategies. We then examine four domains of cognitive science in which these strategies have been studied: mental arithmetic, mental imagery, probabilistic inference, and planning.

## Approaches to Computational Reuse

In an influential paper \[\], the computer scientist Donald Michie proposed **memoization** as a technique to reduce redundant computation. Function calls are intercepted by a ‘memoizer’ that inspects a cache (the memo-table) of past function calls and their outputs. If a function has previously been called with the same inputs, then the previously computed result is reused. If the target function itself has not been memoized, any subfunctions that have been memoized can be intercepted as the target function is executed.

We can use the classic example of the Fibonacci series to illustrate these ideas. The Fibonacci series is defined recursively as the sum of the previous two function values:\[1\]with initial conditions *f* (0) = 0 and *f* (1) = 1. Implemented naively, you get a computation graph shown in A, where the same function is called multiple times with the same input. Memoization works by wrapping *f* (*n*) in a memoizer, which consults a memo-table each time the function is called to determine whether it has been called before, in which case the cached output can be reused (B).

![Figure 1](https://ars.els-cdn.com/content/image/1-s2.0-S1364661320303053-gr1.jpg)

Download: Download high-res image (118KB)

Practical memoization schemes must address a number of issues. One is generalization. Michie recognized that a memo-table might be too rigid for some problems, particularly when the input space is vast and the probability of a repeated function call is low. He proposed to solve this problem by interpolating between cached outputs. For example, *f* (*n*) is monotonically increasing in *n*, so *f* (*n*) must lie between *f* (*n*  − 1) and *f* (*n*  + 1). In fact, Johannes Kepler observed that the ratio between consecutive Fibonacci numbers converges to a constant (the golden ratio), which implies that for large *n* the output is the geometric mean of the outputs for the neighboring inputs:\[2\]

Thus, Fibonacci numbers can always be approximated by geometrically interpolating neighboring numbers, if these are in the memo-table. When the queries take the form of natural numbers, similarity is clearly defined, making interpolation easy. Gauging query similarity might not be as obvious for other domains.

A second issue concerns persistence. Because there are inevitably space constraints, memoization must be selective about what it stores and when it discards information \[,\]. At one extreme (minimal space cost), the memo-table is erased after each function call. At the other extreme (maximal space cost), the memo-table persists indefinitely across function calls. Many of the psychological phenomena we consider later require persistence beyond a single function call, but it is an open question how long these completed computations persist in memory and in what form.

A third issue concerns decomposition strategy. The Fibonacci example above illustrates a ‘top-down’ strategy in which subfunctions are cached ‘lazily’ whenever they are called; in this way, more complex functions are invoked before simpler ones. An alternative ‘bottom-up’ decomposition strategy (sometimes referred to as tabulation \[\]) is to call the simpler functions first and then build up to the complex functions.

## Four Case Studies

In the following subsections, we discuss computational reuse as a cognitive mechanism in four domains. Despite their many differences, these domains have in common the property that they benefit from algorithmic efficiency via problem decomposition and partial reuse. Empirical findings from these domains show that training strengthens memory for computational results. We first consider the domains of mental arithmetic and imagery, where existing cognitive models have invoked caching and reuse. We then discuss more recent work applying these ideas to planning and probabilistic inference. Machine learning has long studied these problems to find computationally feasible solutions that invoke sophisticated forms of reuse. We review these approaches and how they might inform our understanding of cognitive mechanisms.

### Arithmetic

When children learn arithmetic, they appear to rely on counting routines. For example, when given single digit addition problems (e.g., 4 + 5), they initialize a counter at the larger addend (5) and then increment it by 1 at a roughly constant rate until the number of increments equals the smaller addend (4). The strongest evidence for this ‘min-count’ model comes from chronometric data showing that response times increase linearly with the minimum addend \[\]. By the age of 10 years, most children appear to rely primarily on a different strategy, retrieving addition facts directly from memory, as evidenced by a dramatic flattening of the response time function \[,, \]. A similar shift is observed in adults trained to perform alphabet arithmetic (e.g., *A*  + 2 = *C*). Due to the unfamiliarity of these problems, adults are effectively placed in a situation similar to the child first learning arithmetic and transition with experience from counting to memory retrieval (A) \[,\].

![Figure 2](https://ars.els-cdn.com/content/image/1-s2.0-S1364661320303053-gr2.jpg)

Download: Download high-res image (236KB)

This shift from algorithm to memory was elevated to a general theory of cognitive skill acquisition by Gordon Logan in his ‘instance theory of automaticity’ \[\] (see for comparison with other models). The key idea is that each time an algorithm is called, its output is stored in memory and can be potentially reused later. Logan formalized the competition between algorithm and memory as a race, whereby behavioral outputs were based on the first process to complete. With practice, more memory traces are available and hence it becomes more likely that one of them will win the race. The instance theory of automaticity is a theory of memoized cognition: it posits that reuse operates ‘top-down’ by storing the outputs of completed computations in a memo-table (long-term declarative memory).

There is also some evidence for ‘bottom-up’ strategies in mental arithmetic. For example, when faced with multidigit arithmetic problems (e.g., 31 + 25), older children often adopt a decomposition strategy in which the addends are split into tens and units (e.g., 31 is split into 30 and 1), so that the multidigit problem can be solved by simple addition (31 + 25 = 30 + 20 + 1 + 5) \[,, \]. This decomposition is not easily addressed by existing top-down race models (e.g., Logan’s model) that store the final response for future reuse without any decomposition into intermediate computations.

### Imagery

The study of mental imagery parallels the study of mental arithmetic reviewed in the previous section. In a classic experiment, Shepard and Metzler \[\] asked subjects to judge whether two line drawings depicted the same 3D object. On trials in which the drawings depicted rotated versions of the same object, response times increased linearly with the angular difference, consistent with the hypothesis that subjects were mentally rotating the object much as they would a physical object. These findings are analogous to the response time functions for mental arithmetic, suggesting an underlying iterative accumulation algorithm (counting or rotating). Imagery also increasingly relies on memory over the course of training \[,\]. Tarr and Pinker \[\] found that response time functions for mental rotation flatten considerably after extensive practice (B). This again fits with a top-down instance-based memoization theory of the form proposed by Logan \[\].

Also similar to arithmetic, effective memoization in this domain requires us to go beyond the reuse of individual instances. For example, considerable evidence from studies of motion perception suggest that we represent multipart objects using a hierarchy of relative coordinate frames \[,, \], including the dependency structure of scenes and objects at each level. This permits a form of partial reuse and bottom-up memoization: the relative poses of each part can be computed and cached for reuse in a whole-object transformation \[\]. This suggests that the unit of computational reuse is not whole instances; humans learn representations that permit more effective partial reuse and generalization.

### Probabilistic Inference

Perception is frequently faced with ambiguity: the size, shape, brightness, and color of objects are not uniquely resolved by their sensory traces. Higher-level cognitive processes like language understanding and social inference are similarly hampered by ambiguity. Probability theory offers a self-consistent framework for reasoning under ambiguity and has served as a useful normative benchmark for understanding how the brain deals with ambiguity \[,, \].

Consider an agent who has observed data *d* (e.g., a doctor is told that a patient has a cough). There are multiple latent variables (denoted by *z*) that could potentially have produced *d*. For example, the cough could have been generated by the common cold, or by lung cancer. Some values of *z* are more likely to have produced *d* than others (in this example, lung cancer produces coughing more reliably than the common cold). In addition, some values of *z* are more likely to occur *a priori* than others (the common cold is more likely than lung cancer). Probability theory tells us that the optimal inference takes the form of a posterior probability distribution, as prescribed by Bayes’ rule:\[3\]where *P* (*d*  ∣  *z*) is the likelihood of the data under hypothesis *z* and *P* (*z*) is the prior. Intuitively, the likelihood captures the fit between a hypothesis and data, and the prior captures knowledge about the frequency of occurrence for a hypothesis (although probability theory can also accommodate hypotheses that only exist in our minds rather than in the external world).

The fundamental problem for any resource-limited agent is that Bayes’ rule is intractable in the general case. This problem arises ubiquitously, for example, any time there is a combinatorial hypothesis space. In the clinical diagnosis example, there may be multiple nonexclusive conditions (e.g., a person may have the common cold and lung cancer at the same time). Thus, combinatorial structure runs into the same kind of exponential explosion in time complexity found in planning problems. Fortunately, just as agents can harness the Markov property in the service of planning (see next section), they can also harness the Markov property in the service of probabilistic inference, breaking complex inference problems into simpler ones (). We can recognize this strategy as a form of bottom-up computational reuse of solutions to subproblems in order to avoid redundant computation.

Box 2

Breaking Down Inference Problems Using the Markov Property

For illustration, we analyze a simple model in which Bayes’ rule is actually tractable, despite the combinatorial structure. Suppose an agent observes a data sequence *d* <sub>1:<em>n</em></sub>  = \[*d* <sub>1</sub>, …, *D* <sub><em>n</em></sub>\] and the agent assumes that this sequence was generated by a corresponding sequence of latent states *z* <sub>1:<em>n</em></sub>  = \[*z* <sub>1</sub>, …, *z* <sub><em>n</em></sub>\]. If the agent wants to compute the posterior over the state at time *n*, then probability theory dictates that it has to marginalize over all possible state histories (i.e., all the different ways it could have arrived at *z* <sub><em>n</em></sub>):\[I\]

In other words, the agent would have to do inference over the combinatorial hypothesis space of *n* -step state sequences. If the latent variables are continuous, the summation is replaced with integration, which makes the problem potentially even more challenging.

Critically, if the agent also assumes that the generative process is a **hidden Markov model**, in which observations and transitions between states depend only on the current state, then it can break the problem down as follows:\[II\]

Notice that now the agent only needs to marginalize over the last state, not the whole sequence. Furthermore, *P* (*z* <sub><em>n</em> −1</sub>  ∣  *d* <sub>1:<em>n</em> −1</sub>) is simply the posterior from the last time step. This means that the equation can be applied iteratively at each time step to maintain the exact posterior distribution. The basic idea of using Markov assumptions to break a complex inference problem down into simpler problems appears in many different contexts, including more challenging inference problems \[\].

The implication for memory is that only the sufficient statistics of the posterior need to be stored in order to implement probabilistic inference and these statistics can be updated based on the currently available data (*d* <sub><em>n</em></sub>) without retrieving past data. Thus, inference algorithms can reduce their computational footprint by exploiting the structure of the probabilistic model and storing the appropriate intermediate computations.

A classic example of cached inference is the Kalman filter, which implements exact inference in a linear-Gaussian hidden Markov model (a special case of the model described in ). In part because of its resemblance to nonprobabilistic error-driven learning rules, the Kalman filter has been proposed as a psychologically plausible model of learning \[,, \]. Moreover, it can be implemented in biologically plausible neural circuits \[,, \]. What makes the Kalman filter efficient is that it stores intermediate results (the posterior **sufficient statistics**) in a cache and updates them in closed form at the next time step, thereby bootstrapping intermediate computations. This keeps the computational cost of inference bounded even when dealing with an infinite stream of data.

While the kind of caching strategy described earlier is a powerful tool for exact inference, there are many probabilistic models in which it is either still too expensive (e.g., if the sufficient statistics are not low-dimensional) or cannot be applied at all (e.g., if the marginalization lacks a closed form solution). One approach to this problem is to follow in the spirit of the Kalman filter, but instead approximate these computations. This can be achieved using Monte Carlo sampling \[\], variational approximation \[\], as well as combinations of the two \[,\] that utilize their complementary benefits. These generalizations of the Kalman filter have been used to model human probabilistic inference in sequential tasks, like multiple object-tracking \[\] and sentence comprehension \[\], that do not have simple closed form solutions. However, these approximate computations can also be very expensive: Monte Carlo sampling requires many samples to give good estimates and variational inference requires a sometimes expensive optimization in order to get good approximations. An alternative is to instead use a top-down approach that directly caches inferences from previous experience.

A resurgence of interest in this kind of top-down memoization for probabilistic inference was recently kindled by the development of the variational auto-encoder, a neural network that maps data inputs to an approximate posterior \[\]. In essence, the neural network functions as a distributed memo-table, obviating the need for bottom-up iterative computation. The variational auto-encoder is an example of a more general family of algorithms, known as **amortized inference**, which replace iterative computation with a fast parametrized ‘recognition model’ \[,,, \]. The parameters of this recognition model can be learned concurrently with the parameters of the generative model. When the recognition model takes the form of a neural network parametrized by synaptic weights, we refer to it as a ‘recognition network’. Such a network is a sophisticated version of Michie’s interpolation approach to memoization, able to operate on inputs it has never seen before by generalizing from past inputs. The strengths and shortcomings of top-down memoization with recognition networks can be traced back to the strengths and shortcomings of neural networks in general. They are very expressive and can interpolate well even in complex and high dimensional inference problems like visual recognition and natural language processing. However, as they currently stand, they require a lot of data and struggle to generalize compositionally \[,\].

Recent work in psychology and neuroscience has explored whether the brain may be using amortized inference. Yildirim and colleagues \[\] have proposed that the ventral visual stream linking primary visual cortex to the medial temporal lobe implements a fast recognition network for object and scene perception. Applying this proposal to face perception, they showed how such a model could efficiently compute inferences about 3D form and face identity, matching human robustness to variation in lighting and pose \[\]. They also showed that the internal representations encoded by the recognition network matched population activity of neurons recorded in macaque ventral visual stream during face processing.

In another line of work \[,\], we have tested a key implication of amortized inference: past inferences should exert an influence on future inferences, because they imprint themselves on the parameters of the recognition model. We demonstrated experimentally that inferences are biased by recent inferences computed for other queries and that this bias depends on the overlap between the queries. To explain such biases, we showed how amortization using a neural network leads to sharing of structure between different posteriors, provided the network is capacity-limited (e.g., with a bottleneck in the mapping from input to output) \[\] (). Such sharing can also explain a number of biases reported in the psychology literature. For example, people are much more accurate at Bayesian inference when the probabilities are realistic \[,\]. This finding is at odds with the view that the brain relies solely on a general-purpose inference engine that operates on arbitrary probabilities. By contrast, our theory accommodates this finding by assuming that the recognition network preferentially allocates its limited capacity to answering high probability queries. This preferential allocation is an automatic consequence of training the recognition network on queries drawn from the environment. We further showed that experimentally manipulating the historical query distribution can shift the pattern of bias, consistent with the preferential allocation hypothesis.

![Figure 3](https://ars.els-cdn.com/content/image/1-s2.0-S1364661320303053-gr3.jpg)

Download: Download high-res image (301KB)

### Planning

Planning a sequence of actions to maximize cumulative reward is challenging because the number of possible sequences explodes combinatorially with the planning horizon. With only two actions, an agent would have to compare over 1000 different action sequences just to plan over a ten-step horizon. An archetypal example of such planning is in games like chess and Go. Understanding this kind of planning, both how humans do it as well as how to artificially replicate it, has historically played a central role in both the study of artificial intelligence as well as cognitive science \[,,,\].

Exact planning requires that we evaluate every possible game tree and then choose the best one. Several empirical studies have found that humans do not perform this kind of exact planning and often evaluate game states based on memory of familiar board positions from previous games \[,,, \]. These studies provide evidence that humans rely on memoization and partial reuse for efficient planning, but still leave many questions unanswered about the precise mechanism of reuse. In the following section we consider various computational implementations of memoization for planning, their use in modern machine learning, as well as their cognitive and neural signatures.

To simplify the problem, we first outline a standard set of assumptions made about the structure of the environment, known as a **Markov decision process (MDP)**. An agent can move between states by selecting actions and collecting rewards; critically, the rewards and transitions depend only on the current state and action. This is known as the Markov property and allows us to write the expected cumulative reward (value) in a recursive form known as the **Bellman equation** \[\]:\[4\]where *s* denotes the current state, *a* denotes the action, *R* (*s*, *a*) is the expected reward, and the expectation denotes an average of the value function over the next step state () and action (). In some cases a discount factor multiplies the second term, to capture down-weighting of distal rewards. The Bellman equation underwrites most efficient planning algorithms, because it lets the planner decompose a complex problem into a series of simpler ones. Specifically, an agent can iterate over states and actions, recomputing the action that maximizes the right-hand side, and this procedure (known as **value iteration**) is guaranteed to converge to the optimal policy in a finite number of iterations.

To compute the expectation in the Bellman equation, the agent needs access to a model of the environment, in particular the transition function that specifies the probabilities of each possible next state given the current state and action. In some domains, this function is not available, but the agent can still find the optimal policy by interacting with the environment and using samples from these interactions to approximate the expectation (Equation ). This leads to a family of ‘model-free’ reinforcement learning algorithms, the most prominent of which is known as **temporal difference learning** \[\]. This can still be challenging in domains that contain many possible states, resulting in a large and unwieldy memo-table for the Q-value of every state-action pair. The key innovation of deep reinforcement learning \[,\] is to instead use a neural network to learn this mapping. Similar to the amortized recognition network from the previous section, a Q-network operates as a distributed memo-table, permitting partial reuse across similar inputs and generalization to new inputs.

When we have access to an internal model but calculating the expectation is too expensive, we can use the internal model as a simulator, generating fictive experience ‘offline’ that can then be cached into a temporal difference learning algorithm \[\]. These simulations themselves are also expensive and can be intelligently allocated by prioritizing the exploration of states and actions with high cached values \[\]. This strategic use of a model in conjunction with temporal difference learning was a crucial part of the recent successes in superseding human performance in Go \[\].

The model-based and model-free algorithms described earlier have in common their reliance on a bottom-up decomposition approach: subproblems are solved and then cached for reuse in solving larger problems. These algorithms have been highly successful as theories of how the brain solves sequential decision-making problems \[\]. Caching can explain why humans and other animals sometimes make decisions based on ‘stale’ information, choosing actions that bring them to previously high-value states that have been devalued \[,,, \], for example, when rodents press a lever to obtain food on which they have been satiated and hence do not want to consume. This pattern of behavior arises if some parts of the cache have not yet been updated after other parts have been updated (inducing inconsistencies between the cached values). Partial cache updating is an inevitable consequence of a resource-constrained planning system that must prioritize some updates over others; when more cognitive resources, time, or incentives are available, humans exhibit a greater propensity for cache updating \[,,,,, \]. For example, when given the opportunity to mentally simulate from their internal model during quiet rest, people show a greater degree of behavioral adaptation to task changes \[\], consistent with offline cache updating. Furthermore, the degree of adaptation tracks neural measures of mental simulation \[\].

Memoization can also provide insight into how old plans are reused to solve new problems. Huys and colleagues \[\] analyzed human behavior in a planning task in which subjects selected a sequence of actions to maximize rewards, starting from a randomly chosen state on each trial (A). Subjects did not in general choose the optimal path, instead relying on several heuristics. Most relevant for our purposes, they exhibited a bias towards paths that adhered to previously chosen subpaths (policy ‘fragments’). For example, the optimal four-step path starting in state 1 is 1-2-5-1-2 (B). However, subjects preferred the path 1-2-3-4-2. Borrowing ideas from earlier theoretical work \[,\], Huys and colleagues explained this bias as follows: subjects had already solved the optimal three-step path and they then reused this solution in solving the four-step path. This has the advantage of reducing the planning problem to a single-step choice, while still achieving a good (albeit suboptimal) solution. Consistent with the findings from mental arithmetic and imagery described earlier, the degree of fragment reuse increased across trials, ostensibly due to filling of the memo-table. Partition into fragments also carries similarities to the decomposition strategies used in these domains for partial reuse.

![Figure 4](https://ars.els-cdn.com/content/image/1-s2.0-S1364661320303053-gr4.jpg)

Download: Download high-res image (220KB)

Policy fragmentation has kinship with a broader set of ideas about the role of memory in sequential decision making \[,\]. Of particular relevance is the work of Lengyel and Dayan \[\], who proposed that entire sequences of actions are remembered as a unit and reused later when an agent occupies the same starting state. They argued that this form of ‘episodic control’ was particularly valuable when an agent has very little experience in a domain. In the low-data regime, agents cannot hope to build an accurate internal model of the world, nor can they hope to accurately estimate cached values by averaging samples, so episodic memories may be the agent’s best bet (a claim supported by simulations and mathematical analysis). Recent work in artificial intelligence has combined this idea with the generalization permitted by neural networks to solve challenging sequential decision problems, demonstrating impressive gains in learning speed \[,, \].

## Concluding Remarks

Within psychology and neuroscience, memory has traditionally been studied as a goal in itself; memory tasks (e.g., list learning) explicitly study how information is stored and retrieved. In this review, we have argued for a conceptualization of memory as a ubiquitous participant in efficient computation. Similar ideas have historically been advocated for in cognitive science (), however, modern machine learning algorithms go beyond these approaches. These algorithms use powerful function approximation architectures to adaptively determine what information to store. They are also disciplined by domain knowledge (e.g., the Markov property and the Bellman equation) that provides principled constraints on the structure of memory.

The exercise of formalizing human cognition in computational terms has directly highlighted just how computationally expensive several of the tasks we naturally perform can be. This review highlights a crucial component of how intelligent behavior can arise despite limited computational power: by the use of memory as a computational resource. There remain several open questions in how this resource is deployed (see Outstanding Questions).Outstanding Questions

What are the costs of computations, both the time required to perform new computations, as well as the space required to cache

How does the brain negotiate this space–time trade-off in choosing when to cache computations?

How are cached computations generalized to novel inputs?

How can we combine top-down and bottom-up memoization schemes to reap their complementary benefits?

What kinds of representations permit partial reuse by integrating information from cached values and new computation?

What are the memory systems (episodic, declarative, semantic, etc.) that underlie the caching of computations? How can we study their roles behaviorally and neurally?

Computational rationality or resource rationality posit another kind of trade-off, between accuracy and computational cost. What is the role of memory as a computational resource in this trade-off?

## Acknowledgments

We are grateful to Tyler Brooke-Wilson, Timothy O’Donnell, Vikash Mansinghka, and Stuart Shieber for helpful comments. This work was supported by a gift from Microsoft Research, the Multi-University Research Initiative (), and by the Center for Brains, Minds and Machines (CBMM), funded by NSF STC award.

## References

## Glossary

**Amortized inference**

memoizing the process of inference, by learning a mapping from data to the parameters of the posterior distribution.

**Bellman equation**

a recursive formulation of the value function for an MDP.

**Hidden Markov model**

a generative sequence model consisting of two components: a transition distribution that samples the next hidden state based on the current one, and an observation distribution that samples an observation conditional on the hidden state.

**Markov decision process (MDP)**

a mathematical framework to model sequential decision making. It consists of a set of states, a set of actions, the probability that action *a* in state *s* leads to state , and the reward received when taking action *a* in state *s*. Rewards and transitions are conditionally independent of history given the current state and action.

**Memoization**

storing the results of expensive function calls and returning the cached result when the same inputs occur again, in order to speed up algorithms or programs.

**Space–time trade-off**

where an algorithm trades increased time usage with decreased space usage and vice versa. This is sometimes also called a time–memory trade-off.

**Sufficient statistic**

a summary of a data set that completely determines the parameters governing the data distribution.

**Temporal difference learning**

approximates value iteration when the Bellman equation cannot be computed (the expectation over states is unavailable or intractable) by sampling from the environment and incrementally updating value estimates based on each sample.

**Value iteration**

solves the Bellman equation for an MDP by updating value estimates to locally satisfy the Bellman equation until convergence.

[View Abstract](https://www.sciencedirect.com/science/article/abs/pii/S1364661320303053)