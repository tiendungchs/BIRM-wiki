---
title: "Vision language models are blind: Failing to translate detailed visual features into words"
source: "https://arxiv.org/html/2407.06581v6"
author:
published:
created: 2026-09-19
description:
tags:
  - "clippings"
---
Affiliation: Auburn University, USA Affiliation: University of Alberta, Canada

###### Abstract

While large language models with vision capabilities (VLMs), *e.g*., GPT-4o and Gemini-1.5 Pro, score high on many vision-understanding benchmarks, they are still struggling with low-level vision tasks that are easy to humans. Specifically, on BlindTest, our suite of 7 very simple tasks, including identifying (a) whether two circles overlap; (b) how many times two lines intersect; (c) which letter is being circled in a word; and (d) the number of circles in an Olympic-like logo, four state-of-the-art VLMs are only 58.07% accurate on average. Sonnet-3.5 performs the best at 77.84% accuracy, far from the human expected accuracy of 100%. Across different image resolutions and line widths, VLMs including slow-thinking models consistently struggle with those tasks that require precise spatial information when geometric primitives overlap or are close. Yet, VLMs perform at near-100% accuracy when much more space is added to separate shapes and letters. Linear probing experiments show that vision encoders contain sufficient visual information to solve BlindTest and that language models fail to decode this information into correct answers. Code and data are at: [VLMsAreBlind.github.io](https://vlmsareblind.github.io/)

###### Keywords:

Language models Benchmarks Geometric primitives

## 1 Introduction

The advent of VLMs, starting with GPT-4V(ision) [^39], has enabled numerous, unprecedented image-text processing applications [^53]. VLMs can accurately identify objects in a scene [^42] [^9] [^53] and perform complex tasks based on these detected objects, *e.g*., calculating the cost of beers on a table from an image of the scene and an image of the menu [^54]. Interestingly, VLMs advance so quickly that describing *unusual* activities in an image [^46] (*e.g*., a man ironing on a moving taxi) has become a standard sanity check [^10].

Existing VLM benchmarks cover a wide range of tasks [^57] [^18] [^30]. However, they often assess a high-level human-vs-machine performance gap conflating both visual and non-visual abilities. Interestingly, the input images in so many questions, *e.g*., 42.9% of MMMU [^57], are *not* even necessary [^6] for determining the correct answer. Many answers (1) can be inferred from the textual question and choices alone [^6] [^13]; and (2) are memorized by VLMs from their Internet-scale training [^6]. In contrast, it is important to exclusively measure the visual capabilities of VLMs, independent of their strong language abilities.

In this paper, we test VLMs’ ability to *see* (not reasoning) on low-level vision tasks inspired by the “visual acuity” tests [^5] given to humans by optometrists. We test four state-of-the-art (SOTA) VLMs: GPT-4o [^38], Gemini-1.5 Pro [^43], Claude-3 Sonnet [^4], and Claude-3.5 Sonnet [^2] on our suite of 7 extremely simple visual tasks that involve only 2D geometric primitives (*e.g*., lines and circles) [^14] and require minimal world knowledge. Our key findings are:

1. Despite excellent performance on chart and diagram benchmarks [^38] [^4], VLMs cannot reliably tell whether two lines (or two circles) are intersecting, especially when close together. Accuracy in detecting 0, 1 or 2 intersections in a line chart of two 2-segment piecewise-linear functions ranges from $\sim$ 41% to 76% (Sec. 4.1). For the two-circle task, VLMs perform better ($\sim$ 75–93% accuracy), but still far from the expected 100% (Sec. 4.2).
2. VLMs can perfectly recognize a circle () and a word ( Subdermatoglyphic ) separately. Yet, when the circle is superimposed on the word (), models tend to struggle to identify which letter is being circled (Sec. 4.3).
3. VLMs can accurately count shapes, *e.g*., circles ( ○ ), that are disjoint and far apart. However, all VLMs struggle to count intersecting circles (like the Olympic logo), and, generally, primitive shapes ( ○, $\Box$, ⬠ ) that are overlapping or nested (Sec. 4.4).
4. Tiling up squares into a grid, we find VLMs to fail to count the number of rows or columns in the grid, whether empty or containing text (Sec. 4.5). This is in stark contrast to VLM high performance ($\geq$ 90% accuracy) [^38] [^43] on DocVQA [^31], which includes many questions with tables.
5. When tasked with tracing colored paths in a simplified subway map of only 2 to 8 paths and a total of 4 stations, VLMs often fail to count the paths between two stations, *i.e*., with an accuracy of $\sim$ 31% to 58% (Sec. 4.6).
6. GPT-4o is better than Gemini-1.5 Pro on 7 existing complex VLM benchmarks [^38] [^43] but worse on BlindTest. On average across all 7 tasks, VLMs perform at 58.07% accuracy with Sonnet-3.5 being the best (77.84% accuracy), which is still far lower than the expected 100% accuracy of humans (see Tab. 1). In sum, BlindTest reveals some remarkable VLM limitations that are not measured in prior benchmarks.
7. The SOTA “slow-thinking” VLMs are at best on par with the regular VLMs on BlindTest (71.59% vs. 72.75%; Sec. 4.7), *i.e*., longer inference is not immediately addressing the low-level visual challenge posed by BlindTest.
8. Most VLMs perform better (with some reaching $\sim$ 100% accuracy) on *simplified* versions of BlindTest (Sec. 5) where we increasingly add more space between letters (Sec. 5.1) or between shapes (Sec. 5.2), and gradually reduce the number of turns in subway maps (Sec. 5.3). For instance, LLaVA-OneV-72B-ov and Sonnet-3’s accuracy is increased by +20 and +63 on the circled-letter task and counting overlapping circles, respectively, when the images are simplified.
9. Linear-probing the features of the vision encoders before and after the projection layer in the *smallest* open-source VLMs (LLaVA-OneV-S and Phi-3.5) shows that these vision encoders already contain sufficient information to solve the two-circle and counting the intersections in the line chart tasks with $\geq$ 99.47% accuracy (Sec. 6). That is, the challenge lies in decoding the visual information into the correct language outputs.

![Refer to caption](https://arxiv.org/html/2407.06581v6/pixels_769_rotation_diagonal_2_diameter_0.17_distance_0.05_crop.png)

Examples from BlindTest benchmark with VLMs’ responses

## 2 Vision language models

Our goal is to evaluate how SOTA VLMs perceive simple images composed of *interacting* geometric primitives.

4 commercial We test four SOTA models: GPT-4o ( ), Gemini-1.5 Pro ( Gemini-1.5), Claude-3 Sonnet ( Sonnet-3), and Claude-3.5 Sonnet ( Sonnet-3.5) that are ranking highest on 7 recent vision-language benchmarks (see [^38] and Table 10 in [^43]), which cover multi-discipline, college-level subjects in MMMU [^57], science diagrams in AI2D [^18], mathematics in MathVista [^27], charts in ChartQA [^30], documents in DocVQA [^31], and videos in ActivityNet-QA [^56] & EgoSchema [^28]. We initially run experiments with Claude 3 Opus [^3] but swap it with Sonnet-3.5, which performs more accurately on BlindTest and costs 5 $\times$ less. All models tested are described in App. 0.A.

8 open-source For completeness, we also test 8 *open-source* models of varying sizes (from 0.5B to 72B parameters) across three different families: LLaVA OneVision-qwen2 ( LLaVA-OneV) [^20], Phi-3.5-vision-instruct ( Phi-3.5) [^1], and InternVL-2 [^7]. Yet, they underperform the four closed-source models described above (see results in App. 0.C).

2 slow-thinking Given that BlindTest intuitively does not require slow, iterative thinking, our main goal is to evaluate standard VLMs (*e.g*., GPT-4o instead of GPT-o1). However, for completeness, we also test two slow-thinking models [^17]: A closed-source Gemini 2.0 Flash-Thinking and an open-source QVQ-Preview (QVQ) [^51] [^48] (Sec. 4.7). However, these models generally do not outperform standard ones on BlindTest, supporting our hypothesis that BlindTest is a low-level visual task that does not require high-level reasoning.

## 3 BlindTest benchmark of 7 tasks

Eye exams Like humans’ visual acuity tests [^5], we design a set of 7 very simple, yet novel tasks that are composed of common geometric primitives. We do not use the existing tests designed for human-eye exams for two reasons. First, we avoid using the questions that exist on the Internet, which may provide an inflated measure of vision capabilities [^55] [^6] [^13]. Second, our preliminary experiments show that GPT-4o *already performs very well* on humans’ eye exams, which typically contain single, separate symbols— *e.g*., the Snellen chart [^5], tumbling E [^5], and contrast sensitivity charts [^29] [^15].  
Motivation Our BlindTest benchmark tests VLMs on identifying known geometric primitives when they are close together, overlapping, or intersecting. We hypothesize that VLMs will struggle because they mostly rely on “late fusion” [^25] [^47], *i.e*., first extracting visual representations *without* considering the textual question, and then feeding them to a large language model (LLM) for processing. Therefore, while geometric primitives in BlindTest are well known, their exact spatial information on a white canvas (*e.g*., the size and position of a ○ ) is typically not describable in natural language, even for humans, and may not be captured by the vision encoders trained mostly on natural images.  
Controls For each test image, we prompt VLMs using two different, yet semantically equivalent questions. Furthermore, we test VLMs on multiple versions of each task across three different image sizes (Secs. 3.1, 3.2, 3.4, 3.6 and 3.7) and two to three line thickness values (Secs. 3.1, 3.5, 3.4, 3.6 and 3.7).

### 3.1 Task 1: Counting line intersections

Given the impressive accuracy of VLMs on answering questions on diagrams and charts (*e.g*., Sonnet-3.5 scoring 94.7% on AI2D and 90.8% on ChartQA) [^2], a reasonable hypothesis is that VLMs must be able to see if two graphs intersect in a chart. Here, we test this hypothesis by asking VLMs to count the number of intersections (0, 1 or 2) between two 2-segment piece-wise linear functions.

Images We create 1,800 images (Fig. F21) of 2D line plots drawn on an image of size of $C\times C$, where $C\in\{384,768,1152\}$. Each line plot consists of two line segments, defined by three points whose x-coordinates are fixed at $\{0,\frac{C}{2},C\}$ px (see Fig. F21). The y-coordinates are randomly sampled from a pre-defined, invisible 12 $\times$ 12 grid to ensure there is sufficient spacing between two plots and that there are exactly 0, 1 or 2 intersections. See Sec. 0.H.1 for more details.

### 3.2 Task 2: Two circles

In the task of counting line intersections (Sec. 3.1), each image contains two long, thin colored lines on a large white canvas. Here, we test models in a complementary setting where the two interacting objects (here, two same-sized filled circles ) are larger while their gap is smaller. This task evaluates VLM ability in detecting (1) a small gap between two circles; and (2) that two circles are overlapping, *i.e*., no gaps. We vary circle and gap sizes and ask VLMs if two circles are (a) overlapping or (b) touching each other.

Images Given a blank image of size $C\times C$, we draw two same-sized circles of diameter $\phi\in\{\frac{C}{4},\frac{C}{5},\frac{C}{6},\frac{C}{7}\}$ with a boundary-to-boundary distance $=\phi\times d$ where $d\in$ {-0.25, -0.2, -0.15, -0.1, -0.05, 0.0, 0.05, 0.1, 0.15, 0.2, 0.25, 0.3, 0.35, 0.4, 0.45, 0.5} to cover all three cases: overlapping, tangent, and disjoint (see Fig. F4a). The two circles are arranged in four different orientations, making a $90^{\circ}$, $0^{\circ}$, $-45^{\circ}$, and $45^{\circ}$ angle with the x-axis (Fig. F4b). The whole grid sampling generates 224 images per image size. We replicate the procedure for 3 image sizes, *i.e*., $C=384,769,1155$ px to create a total of 3 $\times$ 224 = 768 images. See Sec. 0.F.1 for more details.

### 3.3 Task 3: The circled letter

Consistent with prior reports [^54] [^53] [^44], we find that VLMs can 100% accurately identify a primitive shape (*e.g*., a red circle ) [^44] and can perfectly read an English word (*e.g*., Subdermatoglyphic ) alone. Here, we superimpose the red circle on every letter, one at a time, in the word, and ask VLMs to identify which letter is being circled. While the task is easy to humans, our hypothesis is that if a VLM’s vision is “blurry”, it might not be able to identify the exact letter being circled since there is tiny spacing between the adjacent letters.

Images We choose three strings Acknowledgement, Subdermatoglyphic, and  
tHyUiKaRbNqWeOpXcZvM because they contain characters of variable widths and heights. Furthermore, all four tested VLMs can read out all characters in these strings when they are input to the models as an image. While Acknowledgement is a common English word, Subdermatoglyphic is the longest word without repetitive letters. We also test VLMs on the random string tHyUiKaRbNqWeOpXcZvM to estimate how much model accuracy is due to its familiarity with the word.

For each (string, circled-letter) pair, we render a 512 $\times$ 512 image by choosing among 3 red oval line-thickness levels, 2 font families, and 4 different values of image padding for a total of 24 images. That is, we generate 360, 408, and 480 images for Acknowledgement (15 letters), Subdermatoglyphic (17 letters), and tHyUiKaRbNqWeOpXcZvM (20 letters), respectively. We ensure each letter to be circled fits completely the oval (see Fig. F10). See Sec. 0.G.1 for more details.

### 3.4 Task 4: Counting overlapping shapes ○ ○ ○

Aligned with prior research [^54], we also find VLMs to be able to count disjoint circles ( ○ ○ ○ ). Yet, here, we test VLMs on counting circles that are *intersecting* ( ○ ○ ○ ) like in the Olympic logo—a common cognitive development exercise for preschoolers [^45] [^37]. Our hypothesis is that a “blurry” vision may not see the intersection between two circles clearly and therefore unable to trace circles and count them. For generalization of our findings, we repeat the experiment with pentagons ( ⬠ ) as well (instead of circles).

Images In an image of size $C\times C$, where $C\in\{384,769,1155\}$ px. We draw $N\in\{5,6,7,8,9\}$ overlapping, same-sized circles arranged in two rows like the Olympic logo (see Fig. F30). A circle diameter $\phi\in\{\frac{C}{7},\frac{C}{10}\}$. We repeat the images with two different line thicknesses for rendering circles. This procedure renders 3 resolutions $\times$ 5 values of $N$ $\times$ 2 diameters $\times$ 2 line widths $\times$ 2 color options = 120 images. We also vertically flip all 120 images, resulting in a total of 240 images. We repeat for pentagons ( ⬠ ) in addition to circles ( ○ ), resulting in 240 $\times$ 2 shapes = 480 images in total. For pentagons, their side length $d\in\{\frac{C}{7},\frac{C}{10}\}$. See Sec. 0.J.1 for more details.

### 3.5 Task 5: Counting the nested squares

In addition to testing VLMs on counting the intersecting circles (Sec. 3.4), here, we test a complementary setting by arranging the shapes so that their edges do *not* intersect. That is, each shape is nested entirely inside another (see Fig. F26). For completeness, we test squares ( $\Box$ ) in this task.

Images In an image of size 1000 $\times$ 1000px, we render $N\in\{2,3,4,5\}$ nested squares one at a time from the largest to the smallest. First, the outermost square is rendered using a random edge length $d$. And each subsequent smaller square is placed randomly inside the previous one and has an edge length of 75% of that of the outer square. We render squares using a line width of $\{3,4,6\}$ px and ensure no squares touch by edges. For each line width, we generate 10 images (where squares have different, random locations) to create 3 $\times$ 10 = 30 images. Repeating the process for all $N$ values results in 4 $\times$ 30 = 120 images. See Sec. 0.I.1 for more details.

### 3.6 Task 6: Counting the rows and columns of a grid

The results from prior tasks show VLMs cannot always count shapes that are overlapping (Sec. 3.4) or nested (Sec. 3.5). What about adjacent shapes $\Box$ $\Box$? Here, we tile up shapes (specifically, $\Box$ ) into a grid and challenge VLMs to count—a task that is supposedly simple to VLMs given their remarkable performance ($\geq$ 90% accuracy) [^38] [^43] on DocVQA [^31], which includes many questions with tables. To simplify the task, we ask models to count the number of rows and columns in a given table (either empty or text-containing).

Images A grid may have $N$ $\times$ $N$, $N$ $\times$ $N^{\prime}$, or $N^{\prime}$ $\times$ $N$ cells, where $N\in\{3,4,5,6,7,8,\\
9\}$ and $N^{\prime}=N+1$. We also include grids of size 10 $\times$ 10 to balance the benchmark with the row and column sizes. Each grid is rendered with two different line widths on a canvas of size $C\times C$ where $C\in\{500,1250,2000\}$ px. Besides empty grids, we also replicate the procedure to make grids contain text (which is more common in real-world tables) where each cell contains a single random English word (see Fig. F36). Both versions (empty and text-containing) combined have 2 $\times$ 132 = 264 images. See Sec. 0.K.1 for more details.

### 3.7 Task 7: Following single-colored paths

It is important for VLMs to be able to follow paths in order to read maps or charts [^30], interpret graphs [^19], and user annotations (*e.g*., arrows) in input images [^54]. To assess path-following capability, this task asks models to count the unique-color paths between two given stations in a simplified subway map.

Images We create each subway map on an image of size $C\times C$, where $C\in\{512,1024\}$ px (see Fig. F41). We write 4 station names (A, B, C, D) at 4 fixed coordinates $\in\{(\frac{C}{2},C),(C,\frac{C}{2}),(\frac{C}{2},0),(0,\frac{C}{2})\}$, respectively. We divide the canvas into an invisible grid of 18 $\times$ 18 cells and initialize 3 path-starting points $\frac{C}{18}$ px away from each station. We draw a path, using the depth-first search algorithm starting from a random station and a random starting point, where a valid move is one cell in any direction: North, south, east or west. We repeat the process so that each station has exactly $N\in\{1,2,3\}$ outgoing paths, for a total of 180 maps. See Sec. 0.L.1 for details.

## 4 Results

Table 1: The mean accuracy (%) of all four VLMs over 7 BlindTest tasks is 58.07%, substantially higher than random chance (24%), which is computed considering each task as a single-label, $N$ -way classification problem. Sonnet-3.5 is the best (77.84%) but still far from the expected 100% accuracy. Note that the best open-source VLM (Tab. T1) is only on par with and the best slow-thinking VLM is slightly worse than (Sec. 4.7).

|  | a. | b. | c. | d. | e. | f. | g. | h. | i. |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Model |  |  |  | ○ ○ ○ | ⬠ ⬠ ⬠ |  |  |  | Task mean |
| Random | 33.33 | 50.00 | 5.77 | 20.00 | 20.00 | 25.00 | 4.55 | 33.33 | 24.00 |
| GPT-4o | 41.61 | 75.91 | 74.23 | 41.25 | 20.21 | 55.83 | 39.58 | 53.19 | 50.23 |
| Gemini-1.5 | 66.94 | 93.62 | 83.29 | 20.25 | 24.17 | 87.08 | 39.39 | 53.13 | 58.48 |
| Sonnet-3 | 43.41 | 86.46 | 72.06 | 29.79 | 1.87 | 65.00 | 36.17 | 31.11 | 45.73 |
| Sonnet-3.5 | 75.36 | 90.82 | 87.88 | 66.46 | 77.71 | 92.08 | 74.26 | 58.19 | 77.84 |
| Mean | 56.84 | 86.70 | 79.36 | 39.44 | 30.99 | 74.99 | 47.35 | 48.90 | 58.07 |

### 4.1 VLMs cannot reliably count line intersections

Experiment We parse every model’s response to extract the final answer and then compare it to the groundtruth. We report the mean accuracy of every model on two prompts and analyze how accuracy changes as we vary hyperparameters (*e.g*., line widths and image sizes).

![Refer to caption](https://arxiv.org/html/2407.06581v6/Accuracy-Heatmap.png)

Table 2: The accuracy breakdown by line width in pixels (where C = image width), averaged over two prompts, shows that VLMs cannot reliably count the intersections between two simple 2D line plots.

Results First, across two prompts and two line widths, all VLMs are 56.84% accurate (Tab. 1a), far from the expected 100% accuracy on this easy task (Fig. F24). The best accuracy is only 75.36% (Sonnet-3.5) (Tab. 2). Specifically, VLMs tend to perform worse when the distance between two plots narrows (Fig. 2). As each line plot is composed of three key points, the distance between two plots is computed as the mean distance over three corresponding point pairs. See Figs. 1 and 0.H.4 for more samples of VLM predictions. VLMs perform similarly across three image sizes (Sec. 0.H.2).

Our findings are in stark contrast to the high accuracy of VLMs on ChartQA [^43] [^38], suggesting that VLMs can recognize the overall trend of a line plot but unable to “zoom in” to extract details, *e.g*., seeing which lines are intersecting.

### 4.2 VLMs cannot clearly see if two circles overlap or not

Motivated by VLM poor performance in counting line intersections (Sec. 4.1), here, we replace lines by large, filled circles and ask VLMs explicitly if the two circles are touching (or overlapping).

Experiment Since we instruct VLMs to output a binary answer (Yes/No), we use Python to extract VLMs’ formatted answer from their responses for comparing with groundtruth.

Results Surprisingly, even on this task where objects ( ) are large and clearly visible to humans, no VLMs are able to solve it perfectly—their mean accuracy is 86.70% (Tab. 1b). The best accuracy is 93.62% (Gemini-1.5) over all images and two prompts (Tab. 3). A common trend is when two circles are closer together, VLMs tend to perform more poorly, making educated guesses, *e.g*., Sonnet-3.5 often answers “No” conservatively (Fig. F8). GPT-4o performs the worst and shockingly is *not* 100% accurate even when the distance between two circles is as large as one radius (Fig. 3; $d=0.5$). That is, consistent with the results from Sec. 4.1, VLMs seem to be unable to always detect the gap or intersection between two filled circles (Figs. 1 and F8).

![Refer to caption](https://arxiv.org/html/2407.06581v6/heatmap_distance.png)

Table 3: and perform more consistently over the two different prompts (“ overlapping ” and “ touching ”) than.

An explanation is that due to the late-fusion mechanism [^47], VLMs extract visual features from the image *before* even looking at the question, causing this “blindness”. In contrast, if a model first knows that the question asks it to focus on the area between the two circles, it then might be able to extract accurate visual information to answer such simple questions.

While VLMs perform similarly across three image resolutions (Sec. 0.F.2), every model performs the best at a specific circle orientation (Sec. 0.F.5). Moreover, VLMs’ performance does not change substantially ($\pm 5.79$ points for Sonnet-3.5 and $\pm$ 10.81 for GPT-4o) when tested against different colors (Sec. 0.F.6), ruling out the impact of color on their performance on the task. More examples of VLMs’ answers are in Sec. 0.F.8.

### 4.3 VLMs do not always see the letter inside the red circle

Experiment To evaluate the models’ ability to recognize individual characters in an image, we place a red circle over one character in a word. We prompt VLMs to put their prediction in {curly braces} and then we compare the lowercase version of this character to the lowercase version of the groundtruth character.

<svg id="S4.F4.pic1" height="212.88" overflow="visible" version="1.1" viewBox="0 0 477.38 212.88" width="477.38"><g style="--ltx-stroke-color:#000000;--ltx-fill-color:#000000;" fill="#000000" stroke="#000000" stroke-width="0.4pt" transform="translate(0,212.88) matrix(1 0 0 -1 0 0)"><g style="--ltx-fill-color:#000000;" fill="#000000" fill-opacity="1.0"><path style="stroke:none" d="M 0 5.91 L 0 206.97 C 0 210.23 2.64 212.88 5.91 212.88 L 471.47 212.88 C 474.73 212.88 477.38 210.23 477.38 206.97 L 477.38 5.91 C 477.38 2.64 474.73 0 471.47 0 L 5.91 0 C 2.64 0 0 2.64 0 5.91 Z"></path></g><g style="--ltx-fill-color:#FFFFFF;" fill="#FFFFFF" fill-opacity="1.0"><path style="stroke:none" d="M 1.97 5.91 L 1.97 138.19 L 475.41 138.19 L 475.41 5.91 C 475.41 3.73 473.65 1.97 471.47 1.97 L 5.91 1.97 C 3.73 1.97 1.97 3.73 1.97 5.91 Z"></path></g><g style="--ltx-fill-color:#000000;" fill="#000000" fill-opacity="1.0"><path style="stroke:none" d="M 1.97 140.15 L 1.97 206.97 C 1.97 209.15 3.73 210.91 5.91 210.91 L 471.47 210.91 C 473.65 210.91 475.41 209.15 475.41 206.97 L 475.41 140.15 Z"></path></g><g fill-opacity="1.0" transform="matrix(1.0 0.0 0.0 1.0 21.65 147.55)"><foreignObject style="--ltx-fo-width:31.37em;--ltx-fo-height:4.29em;--ltx-fo-depth:0.25em;font-size:10pt;" height="62.88" overflow="visible" transform="matrix(1 0 0 -1 0 59.42)" width="434.07"><span id="S4.F4.pic1.1" style="width:31.37em;"><span id="S4.F4.pic1.1.1"><span id="S4.F4.pic1.1.1.1" style="--ltx-fg-color:#FFFFFF;">Which character is being highlighted with a red oval? Please provide your answer in curly brackets, e.g. {a}</span></span> </span></foreignObject></g><g fill-opacity="1.0" transform="matrix(1.0 0.0 0.0 1.0 21.65 18.64)"><foreignObject style="--ltx-fo-width:31.37em;--ltx-fo-height:7.35em;--ltx-fo-depth:0.35em;font-size:10pt;" height="106.63" overflow="visible" transform="matrix(1 0 0 -1 0 101.77)" width="434.07"><span id="S4.F4.pic1.2" style="width:31.37em;"><span id="S4.F4.pic1.2.1"><span id="S4.F4.pic1.2.1.2" style="--ltx-bg-color:#BFBFBF;"><span id="S4.F4.pic1.2.1.2.2"><span id="S4.F4.pic1.2.1.2.2.1" style="width:22.8pt;--ltx-bg-color:#BFBFBF;"><span id="S4.F4.pic1.2.1.2.2.1.1"><span id="S4.F4.pic1.2.1.2.2.1.1.1" style="--ltx-fg-color:#000000;">e</span></span> </span></span><span id="S4.F4.pic1.2.1.2.3"><span id="S4.F4.pic1.2.1.2.3.1" style="--ltx-fg-color:#FF0000;--ltx-bg-color:#BFBFBF;">✗</span></span> <span id="S4.F4.pic1.2.1.2.4"><span id="S4.F4.pic1.2.1.2.4.1" style="width:22.8pt;--ltx-bg-color:#BFBFBF;"><span id="S4.F4.pic1.2.1.2.4.1.1"><span id="S4.F4.pic1.2.1.2.4.1.1.1" style="--ltx-fg-color:#000000;">t</span></span> </span></span><span id="S4.F4.pic1.2.1.2.5"><span id="S4.F4.pic1.2.1.2.5.1" style="--ltx-fg-color:#FF0000;--ltx-bg-color:#BFBFBF;">✗</span></span> <span id="S4.F4.pic1.2.1.2.6"><span id="S4.F4.pic1.2.1.2.6.1" style="width:22.8pt;--ltx-bg-color:#BFBFBF;"><span id="S4.F4.pic1.2.1.2.6.1.1"><span id="S4.F4.pic1.2.1.2.6.1.1.1" style="--ltx-fg-color:#000000;">o</span></span> </span></span><span id="S4.F4.pic1.2.1.2.7"><span id="S4.F4.pic1.2.1.2.7.1" style="--ltx-fg-color:#FF0000;--ltx-bg-color:#BFBFBF;">✗</span></span> <span id="S4.F4.pic1.2.1.2.8"><span id="S4.F4.pic1.2.1.2.8.1" style="width:22.8pt;--ltx-bg-color:#BFBFBF;"><span id="S4.F4.pic1.2.1.2.8.1.1"><span id="S4.F4.pic1.2.1.2.8.1.1.1" style="--ltx-fg-color:#000000;">h</span></span> </span></span><span id="S4.F4.pic1.2.1.2.9"><span id="S4.F4.pic1.2.1.2.9.1" style="--ltx-fg-color:#00E000;--ltx-bg-color:#BFBFBF;">✓</span></span> <span id="S4.F4.pic1.2.1.2.10"><span id="S4.F4.pic1.2.1.2.10.1" style="width:22.8pt;--ltx-bg-color:#BFBFBF;"><span id="S4.F4.pic1.2.1.2.10.1.1"><span id="S4.F4.pic1.2.1.2.10.1.1.1" style="--ltx-fg-color:#000000;">o</span></span> </span></span><span id="S4.F4.pic1.2.1.2.11"><span id="S4.F4.pic1.2.1.2.11.1" style="--ltx-fg-color:#FF0000;--ltx-bg-color:#BFBFBF;">✗</span></span> <span id="S4.F4.pic1.2.1.2.12"><span id="S4.F4.pic1.2.1.2.12.1" style="width:22.8pt;--ltx-bg-color:#BFBFBF;"><span id="S4.F4.pic1.2.1.2.12.1.1"><span id="S4.F4.pic1.2.1.2.12.1.1.1" style="--ltx-fg-color:#000000;">b</span></span> </span></span><span id="S4.F4.pic1.2.1.2.13"><span id="S4.F4.pic1.2.1.2.13.1" style="--ltx-fg-color:#00E000;--ltx-bg-color:#BFBFBF;">✓</span></span></span> <span id="S4.F4.pic1.2.1.3"><span id="S4.F4.pic1.2.1.3.2"><span id="S4.F4.pic1.2.1.3.2.1" style="width:22.8pt;"><span id="S4.F4.pic1.2.1.3.2.1.1"><span id="S4.F4.pic1.2.1.3.2.1.1.1" style="--ltx-fg-color:#000000;">m</span></span> </span></span><span id="S4.F4.pic1.2.1.3.3"><span id="S4.F4.pic1.2.1.3.3.1" style="--ltx-fg-color:#00E000;">✓</span></span> <span id="S4.F4.pic1.2.1.3.4"><span id="S4.F4.pic1.2.1.3.4.1" style="width:22.8pt;"><span id="S4.F4.pic1.2.1.3.4.1.1"><span id="S4.F4.pic1.2.1.3.4.1.1.1" style="--ltx-fg-color:#000000;">e</span></span> </span></span><span id="S4.F4.pic1.2.1.3.5"><span id="S4.F4.pic1.2.1.3.5.1" style="--ltx-fg-color:#FF0000;">✗</span></span> <span id="S4.F4.pic1.2.1.3.6"><span id="S4.F4.pic1.2.1.3.6.1" style="width:22.8pt;"><span id="S4.F4.pic1.2.1.3.6.1.1"><span id="S4.F4.pic1.2.1.3.6.1.1.1" style="--ltx-fg-color:#000000;">e</span></span> </span></span><span id="S4.F4.pic1.2.1.3.7"><span id="S4.F4.pic1.2.1.3.7.1" style="--ltx-fg-color:#FF0000;">✗</span></span> <span id="S4.F4.pic1.2.1.3.8"><span id="S4.F4.pic1.2.1.3.8.1" style="width:22.8pt;"><span id="S4.F4.pic1.2.1.3.8.1.1"><span id="S4.F4.pic1.2.1.3.8.1.1.1" style="--ltx-fg-color:#000000;">h</span></span> </span></span><span id="S4.F4.pic1.2.1.3.9"><span id="S4.F4.pic1.2.1.3.9.1" style="--ltx-fg-color:#00E000;">✓</span></span> <span id="S4.F4.pic1.2.1.3.10"><span id="S4.F4.pic1.2.1.3.10.1" style="width:22.8pt;"><span id="S4.F4.pic1.2.1.3.10.1.1"><span id="S4.F4.pic1.2.1.3.10.1.1.1" style="--ltx-fg-color:#000000;">o</span></span> </span></span><span id="S4.F4.pic1.2.1.3.11"><span id="S4.F4.pic1.2.1.3.11.1" style="--ltx-fg-color:#FF0000;">✗</span></span> <span id="S4.F4.pic1.2.1.3.12"><span id="S4.F4.pic1.2.1.3.12.1" style="width:22.8pt;"><span id="S4.F4.pic1.2.1.3.12.1.1"><span id="S4.F4.pic1.2.1.3.12.1.1.1" style="--ltx-fg-color:#000000;">b</span></span> </span></span><span id="S4.F4.pic1.2.1.3.13"><span id="S4.F4.pic1.2.1.3.13.1" style="--ltx-fg-color:#00E000;">✓</span></span></span> <span id="S4.F4.pic1.2.1.4" style="--ltx-bg-color:#BFBFBF;"><span id="S4.F4.pic1.2.1.4.2"><span id="S4.F4.pic1.2.1.4.2.1" style="width:22.8pt;--ltx-bg-color:#BFBFBF;"><span id="S4.F4.pic1.2.1.4.2.1.1"><span id="S4.F4.pic1.2.1.4.2.1.1.1" style="--ltx-fg-color:#000000;">e</span></span> </span></span><span id="S4.F4.pic1.2.1.4.3"><span id="S4.F4.pic1.2.1.4.3.1" style="--ltx-fg-color:#FF0000;--ltx-bg-color:#BFBFBF;">✗</span></span> <span id="S4.F4.pic1.2.1.4.4"><span id="S4.F4.pic1.2.1.4.4.1" style="width:22.8pt;--ltx-bg-color:#BFBFBF;"><span id="S4.F4.pic1.2.1.4.4.1.1"><span id="S4.F4.pic1.2.1.4.4.1.1.1" style="--ltx-fg-color:#000000;">t</span></span> </span></span><span id="S4.F4.pic1.2.1.4.5"><span id="S4.F4.pic1.2.1.4.5.1" style="--ltx-fg-color:#FF0000;--ltx-bg-color:#BFBFBF;">✗</span></span> <span id="S4.F4.pic1.2.1.4.6"><span id="S4.F4.pic1.2.1.4.6.1" style="width:22.8pt;--ltx-bg-color:#BFBFBF;"><span id="S4.F4.pic1.2.1.4.6.1.1"><span id="S4.F4.pic1.2.1.4.6.1.1.1" style="--ltx-fg-color:#000000;">o</span></span> </span></span><span id="S4.F4.pic1.2.1.4.7"><span id="S4.F4.pic1.2.1.4.7.1" style="--ltx-fg-color:#FF0000;--ltx-bg-color:#BFBFBF;">✗</span></span> <span id="S4.F4.pic1.2.1.4.8"><span id="S4.F4.pic1.2.1.4.8.1" style="width:22.8pt;--ltx-bg-color:#BFBFBF;"><span id="S4.F4.pic1.2.1.4.8.1.1"><span id="S4.F4.pic1.2.1.4.8.1.1.1" style="--ltx-fg-color:#000000;">i</span></span> </span></span><span id="S4.F4.pic1.2.1.4.9"><span id="S4.F4.pic1.2.1.4.9.1" style="--ltx-fg-color:#FF0000;--ltx-bg-color:#BFBFBF;">✗</span></span> <span id="S4.F4.pic1.2.1.4.10"><span id="S4.F4.pic1.2.1.4.10.1" style="width:22.8pt;--ltx-bg-color:#BFBFBF;"><span id="S4.F4.pic1.2.1.4.10.1.1"><span id="S4.F4.pic1.2.1.4.10.1.1.1" style="--ltx-fg-color:#000000;">c</span></span> </span></span><span id="S4.F4.pic1.2.1.4.11"><span id="S4.F4.pic1.2.1.4.11.1" style="--ltx-fg-color:#FF0000;--ltx-bg-color:#BFBFBF;">✗</span></span> <span id="S4.F4.pic1.2.1.4.12"><span id="S4.F4.pic1.2.1.4.12.1" style="width:22.8pt;--ltx-bg-color:#BFBFBF;"><span id="S4.F4.pic1.2.1.4.12.1.1"><span id="S4.F4.pic1.2.1.4.12.1.1.1" style="--ltx-fg-color:#000000;">n</span></span> </span></span><span id="S4.F4.pic1.2.1.4.13"><span id="S4.F4.pic1.2.1.4.13.1" style="--ltx-fg-color:#FF0000;--ltx-bg-color:#BFBFBF;">✗</span></span></span> <span id="S4.F4.pic1.2.1.5"><span id="S4.F4.pic1.2.1.5.2"><span id="S4.F4.pic1.2.1.5.2.1" style="width:22.8pt;"><span id="S4.F4.pic1.2.1.5.2.1.1"><span id="S4.F4.pic1.2.1.5.2.1.1.1" style="--ltx-fg-color:#000000;">e</span></span> </span></span><span id="S4.F4.pic1.2.1.5.3"><span id="S4.F4.pic1.2.1.5.3.1" style="--ltx-fg-color:#FF0000;">✗</span></span> <span id="S4.F4.pic1.2.1.5.4"><span id="S4.F4.pic1.2.1.5.4.1" style="width:22.8pt;"><span id="S4.F4.pic1.2.1.5.4.1.1"><span id="S4.F4.pic1.2.1.5.4.1.1.1" style="--ltx-fg-color:#000000;">e</span></span> </span></span><span id="S4.F4.pic1.2.1.5.5"><span id="S4.F4.pic1.2.1.5.5.1" style="--ltx-fg-color:#FF0000;">✗</span></span> <span id="S4.F4.pic1.2.1.5.6"><span id="S4.F4.pic1.2.1.5.6.1" style="width:22.8pt;"><span id="S4.F4.pic1.2.1.5.6.1.1"><span id="S4.F4.pic1.2.1.5.6.1.1.1" style="--ltx-fg-color:#000000;">r</span></span> </span></span><span id="S4.F4.pic1.2.1.5.7"><span id="S4.F4.pic1.2.1.5.7.1" style="--ltx-fg-color:#00E000;">✓</span></span> <span id="S4.F4.pic1.2.1.5.8"><span id="S4.F4.pic1.2.1.5.8.1" style="width:22.8pt;"><span id="S4.F4.pic1.2.1.5.8.1.1"><span id="S4.F4.pic1.2.1.5.8.1.1.1" style="--ltx-fg-color:#000000;">i</span></span> </span></span><span id="S4.F4.pic1.2.1.5.9"><span id="S4.F4.pic1.2.1.5.9.1" style="--ltx-fg-color:#FF0000;">✗</span></span> <span id="S4.F4.pic1.2.1.5.10"><span id="S4.F4.pic1.2.1.5.10.1" style="width:22.8pt;"><span id="S4.F4.pic1.2.1.5.10.1.1"><span id="S4.F4.pic1.2.1.5.10.1.1.1" style="--ltx-fg-color:#000000;">t</span></span> </span></span><span id="S4.F4.pic1.2.1.5.11"><span id="S4.F4.pic1.2.1.5.11.1" style="--ltx-fg-color:#FF0000;">✗</span></span> <span id="S4.F4.pic1.2.1.5.12"><span id="S4.F4.pic1.2.1.5.12.1" style="width:22.8pt;"><span id="S4.F4.pic1.2.1.5.12.1.1"><span id="S4.F4.pic1.2.1.5.12.1.1.1" style="--ltx-fg-color:#000000;">D</span></span> </span></span><span id="S4.F4.pic1.2.1.5.13"><span id="S4.F4.pic1.2.1.5.13.1" style="--ltx-fg-color:#FF0000;">✗</span></span></span> </span><span id="S4.F4.pic1.2.2"><span id="S4.F4.pic1.2.2.1"><span id="S4.F4.pic1.2.2.1.2"><span id="S4.F4.pic1.2.2.1.2.1" style="--ltx-fg-color:#000000;">GPT- <span id="S4.F4.pic1.2.2.1.2.1.1" style="--ltx-fg-color:#16A37F;">4o</span></span></span> <span id="S4.F4.pic1.2.2.1.6"><span id="S4.F4.pic1.2.2.1.6.1" style="--ltx-fg-color:#000000;">Gemini- <span id="S4.F4.pic1.2.2.1.6.1.1" style="--ltx-fg-color:#5186D1;">1.5</span></span></span> <span id="S4.F4.pic1.2.2.1.10"><span id="S4.F4.pic1.2.2.1.10.1" style="--ltx-fg-color:#000000;">Sonnet- <span id="S4.F4.pic1.2.2.1.10.1.1" style="--ltx-fg-color:#CC9A7B;">3</span></span></span> <span id="S4.F4.pic1.2.2.1.14"><span id="S4.F4.pic1.2.2.1.14.1" style="--ltx-fg-color:#000000;">Sonnet- <span id="S4.F4.pic1.2.2.1.14.1.1" style="--ltx-fg-color:#D87757;">3.5</span></span></span></span></span></span></foreignObject></g></g></svg>

Figure 4: Identifying the letter being circled is non-trivial for VLMs across both English words ( Acknowledgement & Subdermatoglyphic ) and a random string ( tHyUiKaRbNqWeOpXcZvM ). When making mistakes, VLMs tend to predict letters adjacent to the one being circled.

Results All VLMs can accurately spell out the string when there is a red oval superimposed on the image. Yet, interestingly, reading out which letter is being circled turns out to be a challenge (mean model accuracy: 79.7%; Tab. 1c).

When the letters are close together, VLMs often predict letters adjacent to the one being circled (see the confusion matrix in Fig. F13 and more results in Figs. 1 and 0.G.2). Sometimes models hallucinate, *e.g*., coming up with characters non-existent in Subdermatoglyphic (*e.g*., “9”, “n”, “©”) despite having the ability to accurately spell out the word (see Fig. F13). We also observe that VLMs, on average, fail to see the circled letter across various common English words (mean accuracy is 86.43% in Sec. 0.G.6). However, as the words get shorter in length and there is no repetitive letters in them, VLMs tend to perform better. More failure cases are reported in Secs. 0.G.3 and 0.G.8.

On average, models perform better (+0.46 to +13 points) on the two English words compared to the random string (Tab. T8), suggesting that familiarity with the word help VLMs make better educated guesses, slightly improving accuracy.

Sonnet-3.5 and Gemini-1.5 are the top-2 models (87.88% and 83.29%) and are better than GPT-4o and Sonnet-3 by a large margin of nearly +15 points (Tab. T8). VLMs perform similarly across two prompts (Sec. 0.G.5) and two font families (Sec. 0.G.4). See also Fig. F1 for an example of GPT-4o and Gemini-1.5 making educated guesses on the color of the overlapping area between two overlapping circles (Task 2).

### 4.4 VLMs struggle to count overlapped and nested shapes

Experiment We run all VLMs on images of overlapping shapes ( ○ and ⬠ ) (Sec. 3.4) and nested squares (Sec. 3.5). We prompt VLMs to output the predicted number of shapes in a formatted answer (which is extracted and compared with groundtruth). For each shape ( ○, ⬠ or $\Box$ ), we run two different prompts.

Results On counting overlapping circles, pentagons, and nested squares, VLM mean accuracy is 39.44%, 30.99%, and 74.99%, respectively (Tab. 1d–f). That is, counting shapes is not easy to models regardless of whether the shapes are overlapped or nested (Figs. 1 and F34). On nested squares, model accuracies vary widely—GPT-4o (55.83%) and Sonnet-3 (65.00%) are at least -25 points behind Gemini-1.5 (87.08%) and Sonnet-3.5 (92.08%). This gap is even larger on overlapped circles and pentagons—Sonnet-3.5 outperforms other models by multiple times (*e.g*., 77.71% vs. 1.87% of Sonnet-3; Tab. 1).

All four models are at least 83% accurate in counting 5 circles. Yet, surprisingly, increasing the number of circles by only one causes accuracy to dip substantially to near zero for all models, except Sonnet-3.5 (Fig. 5; column 6–9). In counting pentagons, all VLMs (except Sonnet-3.5) perform poorly even at 5 pentagons. Overall, counting from 6 to 9 shapes (both circles and pentagons) is hard for all models.

![Refer to caption](https://arxiv.org/html/2407.06581v6/heatmap_circles_baseline.png)

Refer to caption

Why are VLMs nearly perfect at counting 5 circles (Fig. 5a), but struggle to count 5 pentagons or more than 5 shapes? When there are more than 5 circles ( ○ ) and VLMs predict an incorrect count, Gemini-1.5 predicts “5” 99.74% of the time regardless of the actual number of circles (Tab. T13). For other models, this frequency is also much higher than that in the case of pentagons. Our results show strong evidence for an explanation that VLMs are biased towards the well-known 5-circle Olympic logo (more results on this bias in Sec. 0.J.4).

Note that there are only 2 to 5 squares in each image in the task of counting nested squares, and these squares do not intersect (Fig. F28). Surprisingly, GPT-4o and Sonnet-3 are still unable to perfectly count two and three nested squares (Fig. 5c). When the count increases to four and five, most models are far from 100% accurate (Fig. 5c).

GPT-4o performs better on colored shapes than on black shapes, and Sonnet-3.5 is increasingly better as the image size increases. However, the accuracy of the three other models only changes marginally as colors (Sec. 0.J.3) and image resolutions (Sec. 0.J.2) change.

### 4.5 VLMs cannot reliably count rows and columns in a grid

Since VLMs struggle with counting simple shapes when the shape edges intersect (Sec. 3.4) or separate (Sec. 3.5), here, we test the remaining case where these shapes are adjacent and share edges. That is, multiple squares tile up into a single grid. Given the impressive accuracy of VLMs [^38] [^43] [^2] on questions involving tables and spreadsheets in DocVQA [^31], we hypothesize that VLMs must be able to count rows and columns of a grid.

Experiment We run all four VLMs on all images of empty grids and text-containing grids (Sec. 3.6) and analyze their formatted answers.

Results VLMs surprisingly perform poorly (34.37% accuracy) in counting rows and columns in an empty grid (see Tab. T15). Specifically, they are often off by one or two (*e.g*., GPT-4o predicts 4 $\times$ 4 and Gemini-1.5 predicts 5 $\times$ 5 for a 4 $\times$ 5 grid; Figs. F37 and 1). This finding suggests that VLMs can extract important content from a table to answer table-related questions in DocVQA [^31] but do not clearly “see” a table cell-by-cell as a human does.

![Refer to caption](https://arxiv.org/html/2407.06581v6/all_rows_blank.png)

Refer to caption

This might be because tables in documents are often non-empty, which are more familiar to VLMs. Aligned with that hypothesis, after adding a single word to each cell, we observe the accuracy of all VLMs to almost double (*e.g*., from 26.13% to 53.03% for GPT-4o) (Tab. T15). Yet, no models can solve this task with the best model (Sonnet-3.5) performing at 88.68% on text-containing grids and 59.84% on empty grids (Fig. 6a vs. b).

Interestingly, VLMs are better at counting columns than rows—70.53% vs. 60.83% accuracy (Fig. 6c vs. d). However, these numbers are still far from 100% showing that VLMs currently cannot count neither rows or columns in a table reliably. See Secs. 0.K.2 and 0.K.3 for more results.

### 4.6 VLMs struggle to count single-colored paths

This path-counting task tests a VLM’s ability in recognizing a path of a unique color and *trace* it from a given starting station to the destination, an important task in reading maps and graphs in general [^30].

Experiment From a subway map (Sec. 3.7), we randomly sample 2 connected stations and prompt every model to count the single-colored paths that connect them. We extract numbers from VLM templated responses and compare them with the groundtruth.

Results Overall, VLMs perform poorly at a mean accuracy of 48.90% (Tab. 1h). Even when there is only *one path* between two stations, no models can reach 100% accuracy (the best is Sonnet-3.5 at 93.33% and the worst is 20%; Fig. F42). VLM predicted counts are often off by 1 to 3 paths (Fig. F45). VLM accuracy reduces substantially, *e.g*., Sonnet-3.5 from 93.33% to 58.33% and 22.91% as the complexity of the maps increases from 1, 2 to 3 paths, respectively (Fig. F42). More samples of VLM responses are in Figs. 1 and 0.L.4.

### 4.7 Long-inference, slow-thinking VLMs perform similarly to regular VLMs on BlindTest

From math to coding, spending more time thinking before responding enables LLMs to perform substantially better in many tasks [^16]. Here, we aim to test whether such slow thinking also enables VLMs to perform better on BlindTest where we argue that reasoning in the text space might not help. We perform this test for two SOTA models by comparing them with their corresponding slow-thinking versions.

Experiment We run 2 SOTA slow-thinking VLMs: Gemini 2.0 Flash-Thinking and QVQ on BlindTest, and compare them with their non-thinking, regular versions, *i.e*., Gemini 2.0 Flash and Qwen2-VL.

Table 4: SOTA slow-thinking models (bottom) perform even worse than their regular counterpart (top) BlindTest, showing that the longer inference has no positive impact on BlindTest tasks. QVQ is the slow-thinking counterpart of Qwen2-VL.

| Model | Size |  |  |  | ○ ○ ○ | ⬠ ⬠ ⬠ |  |  |  | Task mean |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Gemini 2.0 Flash | n/a | 85.44 | 80.95 | 81.73 | 55.62 | 44.16 | 96.25 | 66.85 | 70.97 | 72.75 |
| Qwen2-VL | 72B | 64.97 | 76.41 | 73.56 | 28.12 | 35.42 | 74.58 | 20.64 | 59.31 | 54.13 |
| Gemini 2.0 Flash-Thinking | n/a | 77.50 | 88.24 | 74.03 | 47.92 | 57.08 | 93.75 | 70.45 | 63.75 | 71.59 |
| QVQ | 72B | 37.05 | 67.26 | 51.60 | 29.58 | 26.66 | 53.75 | 36.74 | 37.22 | 42.48 |

Results On average over 7 tasks, Gemini 2.0 Flash-Thinking, is on par with its non-thinking counterpart, Gemini 2.0 Flash (Tab. 4; 71.59 vs 72.75%). This shows that the “slow-thinking” capability (*i.e*., long, scaled-up inference) does not address the main challenge that BlindTest poses to VLMs. Qualitatively examining the thinking tokens of Gemini 2.0 Flash-Thinking shows that the hidden thoughts are in text space and have no benefits on BlindTest (see Figs. 7 and 8). Moreover, QVQ, the SOTA open-source slow-thinking model is also -11.65 points behind its non-thinking counterpart, Qwen2-VL (Tab. 4).

![Refer to caption](https://arxiv.org/html/2407.06581v6/images/reasoningTeaser/1ee3bca9-fc32-4f1b-9d6c-5959c021361f.png)

Reasoning on counting the overlapping circles

![Refer to caption](https://arxiv.org/html/2407.06581v6/images/reasoningTeaser/pixels_1024_linewidth_20_path_2_fabd7429-a764-41e4-bed9-624ad26c73c7.png)

Reasoning on counting the single-color paths

## 5 VLMs can solve most tasks when there is more space between shapes and letters

Since none of the tested SOTA VLMs, including the slow-thinking ones, is capable of solving any task at near-100% accuracy (Sec. 4), there are two hypotheses to explain this result: (1) prompts may be suboptimal (no prompt-engineering performed); (2) the questions are out-of-distribution for VLMs and they are not capable of solving them, *e.g*., counting to 10; (3) the shapes being so close together that they are overlapping or nesting or adjacent causes challenges to VLMs in extracting accurate features (and therefore answering questions).

To tease apart hypotheses (1) & (2) from (3), we increasingly add more space between letters and shapes to hopefully make the tasks easier (*e.g*., space between characters in or between circles ○ ○ ○ ) and report model-accuracy changes (*i.e*., how a VLM would reach near 100% accuracy).

### 5.1 VLMs perform better as the spacing between letters in the circled letter task increases

Experiment On the circled-letter task ○, VLMs often cannot reliably tell which letter is being circled among adjacent ones (see Fig. F13). Here, we add 1 to 3 ASCII space characters between adjacent letters of a string and evaluate VLMs using the exact same prompts as done in Sec. 4.3.

![Refer to caption](https://arxiv.org/html/2407.06581v6/0.png)

Refer to caption

Results All VLMs perform better on this task when there is $\geq$ 1 extra space between characters compared to when there is no extra space (Fig. 9b). However, the increase ($\triangle$) in accuracy varies across models. For instance, and accuracies increase by over +20 points to 92% and 72% from 72% and 46%, respectively (Fig. 9b).

Out of 7 tested VLMs, Sonnet-3.5 reaches the highest accuracy of 95% when there are 3 extra spaces between letters (Fig. 9a). Qualitatively, the remaining 5% error (40 samples) includes: (1) 12 mispredictions of adjacent letters and (2) 13 instances of confusing the red circle as part of the letter, *e.g*., ‘@’ for ‘a’, and (3) 15 cases of predicting ‘g’ instead of ‘q’.

Note that while the vision encoders in LLaVA-OneV with 72B () and 0.5B () are identical (400M SigLIP), the VLM with a larger Qwen2 language decoder (72B) substantially outperforms the counterpart with smaller decoder (Fig. 9b). This interestingly suggests that, at least in LLaVA-OneV family, the language decoder plays a major role in “reading out” which letter is being circled. On this task there is no slow-thinking [^17] required and therefore, the language model (Qwen2) may act as an extended “vision” encoder on top of the SigLIP vision encoder, bottlenecking the accuracy of the LLaVA OneVision-qwen2-si-0.5B ( LLaVA-OneV-S).

### 5.2 VLMs can more accurately count disjoint shapes

Inspired by the results of adding spaces to the circled letter task (Sec. 5.1), where VLMs see the letters better when there is more space between them, we also study the effects of the overlap area, *i.e*., the space between shapes, in counting overlapping shapes (for both ○ ○ ○ and ⬠ ⬠ ⬠ ). We aim to evaluate whether reducing the overlap area between shapes would improve VLM accuracy in counting them.

Experiment The overlapping shapes in the baseline images (Sec. 3.4) are distanced in X and Y directions. To generate simplified versions of the images, we gradually increase these distances such that it reduces the overlapping area between the shapes. Specifically, the boundary-to-boundary distance between circles in the original images along the X and Y directions is $\in\{dx\times\frac{\phi}{2},dy\times\frac{\phi}{2}\}$, where $\phi$ is the diameter of the circles and $dx$ and $dy$ are multipliers (see Fig. 10). We push the shapes away by increasing $dx$ and $dy$ for circles. We repeat the same procedure for pentagons with the boundary-to-boundary distance of $\{d\times dx,d\times dy\}$, where $d$ is the side length of the pentagons (see Fig. 11). We use the same prompts as in Sec. 3.4 to evaluate VLMs on the new pushed-away sets and compare their accuracy to the baseline results (in Sec. 4).

![Refer to caption](https://arxiv.org/html/2407.06581v6/circleswithline.png)

Figure 10: We reduce the overlap area between circles by increasing the boundary-to-boundary distances along the X and Y axes, i.e., d x × ϕ 2 dx\\times\\frac{\\phi}{2} and y dy\\times\\frac{\\phi}{2}, respectively.

![Refer to caption](https://arxiv.org/html/2407.06581v6/pentagonswithlines.png)

Figure 11: We increase the boundary-to-boundary distances between pentagons along the X and Y axes, i.e., d × x d\\times dx and y d\\times dy, respectively.

Results VLMs, in general, can count shapes more accurately when there is no overlapping area between shapes (Fig. 12). Yet, accuracy increases vary between models. For example, both Sonnet-3 and Sonnet-3.5 reach $\geq$ 96% (Fig. 12; $dx=0.75$). Similarly, 72B-LLaVA-OneV () achieves 72% accuracy on counting disjoint circles (Fig. 12; $dx=0.75$).

This shows that most VLMs struggle to count the shapes in the baseline images (Fig. 12; $dy=-1$ and $dx=0.1$) because the shapes overlap, which poses a challenge to VLMs in counting.

All closed-source VLMs, except for Gemini-1.5, consistently benefit from increasing the distance along both directions in counting overlapping shapes. The most significant improvement is for Sonnet-3 with $\triangle$ =91% and the least is for GPT-4o with $\triangle$ =22% (Fig. 12b). Qualitatively, this is mainly because counting more than 6 shapes is “hard” for Gemini-1.5 regardless of the amount of space between them due to its strong bias towards the Olympic logo (Sec. 4.4).

Similarly to the circled letter task (Sec. 5.1), 72B LLaVA-OneV performs much better than 0.5B LLaVA-OneV-S on the simplified versions (Fig. 12). This further suggests that the language decoder in LLaVA-OneV significantly affects the VLM’s ability to see, count, and speak the number of shapes in the image.

![Refer to caption](https://arxiv.org/html/2407.06581v6/heatmap_circles_dist.png)

Refer to caption

### 5.3 VLMs can count simplified, more straight paths

VLMs’ ability to count can also affect the overall accuracy of SOTA models on counting single-colored paths ( ) in subway-like maps. To investigate whether VLMs are not able to count in general or whether the zigzag patterns of paths (Fig. 13a) poses the main challenge to VLMs, we render simplified versions of the original maps, where each path in the map contains fewer intersections with other paths. We evaluate the VLMs on the new set and compare their performance with the baseline images.

Experiment We re-render the images by forcing each path to have fewer $90^{\circ}$ turns than the baseline. The baseline images (Sec. 3.7) are implemented by choosing a direction on a grid using a random depth-first algorithm, where the probability ($P$) of choosing a straight direction is 0.33. Therefore, we gradually increase the $P$ from the baseline ($P$ =0.33) to 0.6 and 0.9, such that it yields images with fewer intersections and turns (Fig. 13a). We use the prompts in Sec. 3.7 and compare VLMs’ performance with the baseline accuracy.

Results On average, all VLMs more accurately count the single-colored paths when there are fewer turns, *i.e*., as $P$ increases (see Fig. 13b). The accuracy gain significantly varies between models, *e.g*., +2 points for GPT-4o and +30 for Sonnet-3.5 (Sec. 0.L.3). This shows that SOTA VLMs mostly struggle to count the paths in original images (Sec. 4) due to the visual complexity of zigzag patterns of paths and their intersection.

Analyzing the accuracy by the number of paths connected to each station, we find that some VLMs even score near-100 accuracy (*e.g*., 0.95, 0.99, and 0.95 for , , and, respectively at $P=0.9$; Fig. 13). This substantially better accuracy on simplified images is in stark contrast to the poor accuracy reported for the original subway maps ($P=0.33$), confirming that the visual complexity of the paths poses challenges to VLMs.

![Refer to caption](https://arxiv.org/html/2407.06581v6/pixels_1024_linewidth_20_path_1_prob_0.3333333333333333_8942657b-fd65-4f22-a5d8-3544fc243e05.png)

Refer to caption

## 6 The vision encoder in open-source VLMs can extract sufficient information to solve BlindTest

We find that VLMs surprisingly fail at simple tasks, *e.g*., determining whether two circles overlap or not (Sec. 4). Furthermore, our results in Sec. 5 show supporting evidence that these failures are not due to the uncommon nature of the questions in BlindTest or insufficient prompt engineering. Specifically, VLMs achieve near-100% accuracy when there is much more space between shapes and letters (Sec. 5). Therefore, here, we question whether VLMs can “see” the key visual information in BlindTest images, *e.g*., the gap between two circles in order to decide whether they overlap. Specifically, we run linear probing experiments to test whether the visual encoders of open-source VLMs extract sufficient information for solving BlindTest.

Models From the SOTA open-source VLM families that we test in Tab. T1, we select two models, 0.5B LLaVA-OneV-S () and 4.2B Phi-3.5 () for two reasons. First, these two VLMs use the two most common vision encoders (VEs)— uses SigLIP [^59] while uses CLIP [^41]. That is, our findings on these two VEs would generalize to most VLMs. Second, and are among the smallest VLMs, and therefore, if their VEs contain sufficient information, the same is likely true with larger and commercial VLMs.

Tasks We choose (1) the two circles () and (2) the counting line-intersections () for this experiment because they represent arguably the simplest images and questions in BlindTest (the two circles and the line intersections tasks are 2-way and 3-way classification problems).

We generate 11,100 two-circle images with a uniform distribution of images over circle distances ($dx$, $dy$). We divide these images into (8880, 1110, 1110) images for train, val, and test sets, respectively. Repeating this generation process for the line-intersection task () with an equal distribution of mean distances between the y coordinates of the red and blue lines (similar to Fig. 2) for a total of 6,300 images, *i.e*., divided into (4410, 945, 945) for train, val, and test sets.

Figure 14: We train a linear-probing classifier on the frozen features extracted from the (1) vision encoder and the (2) projection layer for the two circles and the line chart tasks separately. Evaluating the linear classifiers shows that the information necessary to solve these two tasks exists before and after the project layer but is lost in the LLM, resulting in poor VLM accuracy in Sec. 4.

Method We average-pool the image-patch features at the layer right *before* the projection layer (Fig. 14). Then, we train a logistic-regression linear classifier on top of the frozen features on each task. We train each classifier for 1,000 epochs with $L_{2}$ regularization weight of 1.0 (Tab. T18) and choose the best model based on the validation set. The dimensions of the features are described in Sec. 0.N.1. For completeness, we repeat the experiment for the layer right *after* the projection layer to understand the impact of the projection layer.

Results The linear-probing accuracy of the CLIP features, before projection layer, in is $\geq$ 99.47% on both tasks (Tab. 5). This suggests that the necessary low-level information to solve these tasks is preserved in CLIP. Similarly, the same conclusion holds for the VE in, a variant of SigLIP, that performs 100% on both tasks (Tab. 5). Moreover, using the frozen features after the projection layer in both and yields a linear classification accuracy of $\geq$ 99.58% on both tasks (Tab. 5). This result shows that most visual information from VEs is preserved before and after the projection layer. Contrasting these high linear-classification VE accuracy scores with fairly lower accuracy of both VLMs on BlindTest (see Tab. 5; rightmost column), we conclude that the language models in these VLMs have access to the necessary visual information to solve BlindTest tasks but fail to decode it into correct language outputs.

Interestingly, in the two-circles task, training on frozen features of images, where the two circles are close ($distance=-0.05,0.05$) produces a linear classifier that performs perfectly at 100% accuracy not only on that training distribution but also on splits containing circles that are farther apart (*e.g*., $distance=-0.25,0.25$) regardless of the VE ( and ). However, the opposite does not hold—training on the images where circles are farther apart ($distance=-0.25,0.25$) results in a classifier that performs poorly on circles that are closer. More details in Sec. 0.N.2. This result shows evidence that (1) training on the harder cases ($distance=-0.05,0.05$) results in a more robust classifier and (2) our classifiers do not overfit to training data.

Table 5: The output features from the vision encoders right before (a) the projection layer in LLaVA-OneV-S () and Phi-3.5 (), *i.e*., CLIP and SigLIP, respectively, contain sufficient information to solve the and (linear-probing accuracy is $\geq$ 99.47%). The same conclusion holds for after (b) the projection layer. However, the language model in these VLMs fails to decode this information into correct answers, resulting in poor accuracy on the tasks (c).

<table><tbody><tr><td></td><td colspan="2">(a) Before</td><td></td><td colspan="2">(b) After</td><td></td><td colspan="2">(c) VLM</td></tr><tr><td>Model</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr><tr><td></td><td>99.47</td><td>99.82</td><td></td><td>99.58</td><td>99.73</td><td></td><td>33.14</td><td>73.21</td></tr><tr><td></td><td>100.0</td><td>100.0</td><td></td><td>100.0</td><td>100.0</td><td></td><td>37.78</td><td>83.63</td></tr></tbody></table>

## 7 Related Work

Benchmarking VLM vision understanding College-level topics [^57], charts [^30], documents [^31] or videos [^56] are among the common benchmarks for assessing VLM vision understanding [^38] [^4] [^43] [^2] and are witnessing VLMs’ recent rapid progress— *e.g*., Sonnet-3.5 is reaching 95.2% on DocVQA, 90.8% on ChartQA, and 94.7% on AI2D [^2]. However, most of the vision benchmarks attempt to evaluate VLMs on real-world, topic-specific data that require extensive prior knowledge [^21] [^50] [^6], which has a “data leakage” problem, *i.e*., VLMs many times can answer accurately without even the input image [^6]. Furthermore, most benchmarks test VLMs on the data that humans have to deal with to provide a high-level sense of the human-machine intelligence gap [^55] [^26]. In contrast, our BlindTest benchmark differs significantly from prior benchmarks because it is (1) extremely easy to humans and can be solved by a 5-year-old (unlike [^57] [^30] [^31]); (2) the first low-level, visual sanity check for VLMs; (3) requiring minimal to zero prior knowledge; (4) requiring minimal commonsense or complex reasoning (unlike [^8] [^58])— *i.e*., a strong language model is of little use here when it is non-natural for humans to describe BlindTest images in language.

The ARC benchmark [^36] [^8] also contains abstract images made up of simple shapes; however, it challenges VLMs to understand and reason based on those patterns. That is, ARC assumes VLMs can identify the abstract shapes in order to reason. In contrast, our BlindTest directly evaluates VLM capabilities in recognizing these primitive shapes.

Improving VLM vision capabilities Most recent recipes for improving SOTA VLMs involve finetuning a pretrained LLM coupled with vision encoders to solve high-level vision tasks [^24]. Such late-fusion approaches fuse visual representations learned from the tokenized image with a powerful thinking brain [^33] [^23] [^22]. However, current vision approaches for VLMs are facing challenges as models sometimes are “blind”—unable to see natural objects exist in a real photo [^49]. In contrast, we are showing VLMs are visually impaired at low-level abstract images, *e.g*., inability to count 6 overlapping circles or 3 nested squares.

Our circled-letter task (Sec. 3.3) is inspired by VLM abilities in recognizing content inside a red circle over real objects in natural images [^53] [^44] [^54]. In contrast, we show that VLMs can fail at a low-level, optical character recognition as opposed to recognizing real objects. To the best of our knowledge, no prior attempts have been made to address the exact limitations raised in our paper: (1) identifying and counting simple lines, shapes and geometric primitives when they interact (Sec. 4.1 to Sec. 4.5); (2) following colored paths (Sec. 4.6). Solving these limitations may be the foundation for VLMs to progress on some existing vision benchmarks on graphs, *e.g*., [^19], visual math [^27] and some existing blind-spots in natural images (*e.g*., understanding the direction an object is facing [^49]).

## 8 Discussion and Conclusion

We propose BlindTest, a benchmark of seven novel low-level visual tasks for testing VLM ability to “see” simple geometric primitives (such as line, circles, squares, intersections) that are the basic building blocks for many image tasks. The tasks are designed from scratch and require minimal to zero knowledge. As the tasks did not exist on the Internet before and require minimal world knowledge, there is minimal chance that VLMs can solve BlindTest by memorization or by not using the input image—an issue in some prior benchmarks [^6] [^13].

Furthermore, we also test common prompting techniques (Sec. 0.D.1) including 2-shot, chain-of-thought [^52], and meta-prompting [^34] but do not obtain better accuracy, which (1) suggests that VLMs understand BlindTest questions and (2) confirms that these visual tasks do not benefit from thinking aloud [^52].

The poor performance of VLMs on BlindTest suggests that models will perform poorly on the real-world visual tasks that require them to follow arrow directions or paths, (*e.g*., reading subway maps in Fig. F46, street maps or directed graphs in Fig. F47), perceive lines and intersections (*e.g*., reading music sheets; Fig. F47), identify and counts objects in a crowded scene.

### Acknowledgement

We thank Hung H. Nguyen, Thang Pham, Ali Yildirim, Giang Nguyen, and Tin Nguyen at Auburn University for feedback and discussions of the earlier results. We are also thankful for the API research credits from Anthropic and together.ai to MRT. AN was supported by the NSF Grant No. 1850117 & 2145767, and donations from NaphCare Foundation & Adobe Research.

## References

Appendix for:  
Vision language models are blind: Failing to translate detailed visual features into words

## Appendix 0.A Description of models tested

On our benchmark, we find that some chat interfaces perform *worse* than their API counterparts (*e.g*., the system on gemini.google.com is worse than Gemini-1.5 Pro on aistudio.google.com) perhaps due to their extra finetuning [^40] or specific system prompts [^32] that attempt to align VLMs with a company’s policies. Similarly, we find GPT-4o and Claude 3 models in [perplexity.ai](https://perplexity.ai/) to perform worse than the original API models. To make sure we test the best VLMs available, we access all four models via their available APIs on [OpenAI](https://platform.openai.com/), [Google](https://aistudio.google.com/), and [Anthropic](https://claude.ai/).

We describe below the exact API versions and settings for each model.

### 0.A.1 GPT-4o

We access the API for GPT-4o (gpt-4o-2024-05-13) via [platform.openai.com](https://platform.openai.com/) and use all *default* settings including:

- temperature: 1.0
- detail: auto (see [API doc](https://platform.openai.com/docs/guides/vision)), *i.e*., the system will automatically decide whether to use the “low-res” (85 tokens) or “high-res” mode (85 tokens and a set of 170 tokens for every 512 $\times$ 512 tile).

### 0.A.2 Gemini-1.5 Pro

Gemini-1.5 (gemini-1.5-pro-latest) API is accessible via [aistudio.google.com](https://aistudio.google.com/), and we use all *default* settings.

### 0.A.3 Claude-3 Sonnet

We access the anthropic API via [console.anthropic.com](https://console.anthropic.com/) to use Sonnet-3 (claude-3-sonnet-20240229) with *default* settings.

### 0.A.4 Claude-3.5 Sonnet

We follow the same process as for Sonnet-3 and use [console.anthropic.com](https://console.anthropic.com/) to access Sonnet-3.5 (claude-3-5-sonnet-20240620) API with *default* settings.

### 0.A.5 LLaVA OneVision-qwen2

We run the publicly available [code](https://github.com/LLaVA-VL/LLaVA-NeXT) of LLaVA OneVision-qwen2 locally with temperature=0.2.

### 0.A.6 Phi-3.5-vision-instruct

We host Phi-3.5-vision-instruct on a local machine via their [Hugging Face page](https://huggingface.co/microsoft/Phi-3.5-vision-instruct) with temperature=1.0.

### 0.A.7 InternVL-2

We access InternVL-2 via their [Hugging Face repository](https://huggingface.co/collections/OpenGVLab/internvl-20-667d3961ab5eb12c7ed1463e), and use the temperature=0.2.

### 0.A.8 Qwen2-VL

We use the publicly available codebase on [Huggingface](https://huggingface.co/Qwen/Qwen2.5-VL-72B-Instruct), and run the evaluation with the temperature=0.7.

### 0.A.9 Gemini 2.0 Flash

We use the API via [aistudio.google.com](https://aistudio.google.com/) with temperature=0.7.

### 0.A.10 Gemini 2.0 Flash-Thinking

We use the model available via [aistudio.google.com](https://aistudio.google.com/) with temperature=0.7.

### 0.A.11 QVQ-Preview

We run the publicly available model on [Huggingface](https://huggingface.co/Qwen/QVQ-72B-Preview), with the temperature=0.7.

## Appendix 0.B Hallucinations and educated guesses are among VLMs’ common failures

![Refer to caption](https://arxiv.org/html/2407.06581v6/images/realexamples/overlapping.jpg)

What is the color of the overlapping area between two circles?

## Appendix 0.C Evaluating open-source models on BlindTest

On average, 8 well-known open-source models perform *worse* than the commercial, closed-source VLMs on BlindTest. However, the best-performing open-source model (LLaVA-OneV-72B-ov), performs on-par with Sonnet-3 (45.92 vs. 45.73; Tab. T1). As model size increases, VLMs tend to perform better. For instance, the accuracy increase from LLaVA-OneV-ov 0.5B to 72B is +27.1 (18.82 $\to$ 45.92; Tab. T1). In sum, open-source VLMs exhibit similar limitations to closed-source models on BlindTest.

Table T1: Open-source VLMs underperform the closed-source ones on BlindTest.

| Model | Size |  |  |  | ○ ○ ○ | ⬠ ⬠ ⬠ |  |  |  | Task mean |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Random |  | 33.33 | 50.00 | 5.77 | 20.00 | 20.00 | 25.00 | 4.55 | 33.33 | 24.00 |
| GPT-4o | n/a | 41.61 | 75.91 | 74.23 | 41.25 | 20.21 | 55.83 | 39.58 | 53.19 | 50.23 |
| Gemini-1.5 | n/a | 66.94 | 93.62 | 83.29 | 20.25 | 24.17 | 87.08 | 39.39 | 53.13 | 58.48 |
| Sonnet-3 | n/a | 43.41 | 86.46 | 72.06 | 29.79 | 1.87 | 65.00 | 36.17 | 31.11 | 45.73 |
| Sonnet-3.5 | n/a | 75.36 | 90.82 | 87.88 | 66.46 | 77.71 | 92.08 | 74.26 | 58.19 | 77.84 |
| LLaVA-OneV-ov | 72B | 45.83 | 90.92 | 44.71 | 20.00 | 11.74 | 87.07 | 8.95 | 58.06 | 45.92 |
| LLaVA-OneV-si | 72B | 45.33 | 83.48 | 38.14 | 20.00 | 11.46 | 57.50 | 10.23 | 48.06 | 38.41 |
| LLaVA-OneV-ov | 7B | 48.17 | 83.93 | 42.79 | 20.00 | 7.29 | 42.92 | 21.02 | 47.22 | 39.17 |
| LLaVA-OneV-si | 7B | 44.50 | 84.67 | 40.22 | 20.00 | 7.29 | 58.75 | 14.01 | 55.00 | 40.00 |
| LLaVA-OneV-ov | 0.5B | 17.28 | 75.07 | 9.78 | 12.50 | 9.58 | 20.42 | 0.38 | 5.56 | 18.82 |
| LLaVA-OneV-si | 0.5B | 33.14 | 73.21 | 6.25 | 27.29 | 2.50 | 14.58 | 1.13 | 26.11 | 23.03 |
| InternVL-2 | 8B | 47.28 | 91.00 | 57.69 | 20.00 | 13.96 | 28.33 | 7.57 | 60.28 | 40.76 |
| Phi-3.5 | 4.2B | 37.78 | 83.63 | 16.51 | 18.75 | 11.46 | 32.50 | 11.74 | 19.72 | 29.01 |
| Mean |  | 45.55 | 84.39 | 47.79 | 26.35 | 16.60 | 53.50 | 22.03 | 42.97 | 42.28 |

## Appendix 0.D Advanced prompting techniques

### 0.D.1 Finding: Meta-prompting and 2-shot examples do not improve the VLMs’ performance on the two circles task ()

We run GPT-4o and Sonnet-3.5 on the two circle task () with 2-shot (providing 2 example images with answers) and meta-prompting <sup>1</sup> [^35]. We find them to perform worse than our baseline prompts (Tab. T2). An explanation is that the VLMs already understand the questions but are limited by the ability to “see”. These techniques are not helpful perhaps because BlindTest tasks intuitively do not benefit from thinking aloud.

Table T2: In-context examples and meta-prompting do not improve the overall accuracy of the Sonnet-3.5 and GPT-4o on the task.

| Prompt |  |  |
| --- | --- | --- |
| Baseline | 91.66 | 72.69 |
| Meta-prompting [^35] | 90.53 | 65.62 |
| 2-shot | 77.93 | 68.00 |

## Appendix 0.E Image reconstruction using Sonnet-3.5

Inspired by Pixel Value Prediction [^11] task in VLMs, we formulate the tasks in BlindTest as a reconstruction problem. However, we rely on VLMs’ existing capabilities, such as coding, to reform our tasks. Specifically, instead of framing the prompts into question answering, given the input image, we ask the best performing VLM (Sonnet-3.5) to explicitly use its coding ability and reconstruct the input images.

### 0.E.1 Sonnet-3.5 cannot use its coding ability to regenerate the images from BlindTest

Experiment We ask Sonnet-3.5 to generate various formats of the 6 samples from each of 7 tasks in BlindTest, specifically SVG, HTML/CSS, Javascript (using the canvas HTML element to draw the image), and the Python PIL package. We aim to see if the model can maintain the key features of the input image in its generated image, *e.g*., if Sonnet-3.5 can reconstruct images of the task with the same number of intersections as in the input image.

Results Overall, the coding ability does not help Sonnet-3.5 to reconstruct the images from BlindTest (see Fig. F2). Furthermore, across various tasks, Sonnet-3.5 often cannot faithfully recreate the important features such as the number of intersections, number of shapes, and touching vs. non-touching circles. This shows that Sonnet-3.5 can see the overall shapes in the image, but it is not sufficient for code generation.

![Refer to caption](https://arxiv.org/html/2407.06581v6/images/generated/line/line_original.png)

Figure F2: Sonnet-3.5 cannot recreate images from BlindTest (a) using its coding ability and different programming languages.

## Appendix 0.F Two touching circles task

### 0.F.1 Benchmark Construction Details

To create our benchmark, we use 5 parameters to control the diversity of the samples.

- Color: We fix the colors for each circle to use { *magenta*, *dodgerblue* }.
- Image size: We use the physical size, and the DPI arguments in *matplotlib* to initialize the image size. The physical size is fixed to $5\times 5$, and the DPI $\in\{100,200,300\}$. The output image sizes are {384, 769, 1155}px.
- Diameter: We use uniform diameters for both circles and choose the value proportional to the image size, where the diameter is $\{\frac{1}{4},\frac{1}{5},\frac{1}{6},\frac{1}{7}\}$ of the image size.
- Distance: The boundary-to-boundary distance between circles is a fraction of the diameter chosen from {-0.25, -0.2, -0.15, -0.1, -0.05, 0.0, 0.05, 0.1, 0.15, 0.2, 0.25, 0.3, 0.35, 0.4, 0.45, 0.5}. Based on our definition, center-to-center distance is (2 $+$ distance) $\times$ diameter.
- Rotation: We include 2 main rotations (vertical and horizontal), and 2 diagonal rotations.

We use the center of the image as the origin so that it always aligns with the midpoint of distances between two circles. This systematic process results in a benchmark comprising 768 images (see Tabs. T3 and F3).

Code The code is available at [https://github.com/anguyen8/vision-llms-are-blind/blob/main/src/TouchingCircle/TwoTouchingCircles.ipynb](https://github.com/anguyen8/vision-llms-are-blind/blob/main/src/TouchingCircle/TwoTouchingCircles.ipynb).

Prompts

1. *Are the two circles touching each other? Answer with Yes/No.*
2. *Are the two circles overlapping? Answer with Yes/No.*

Groundtruth We consider two circles overlapping and touching (${O}$, ${T}$) if $d<0.0$; non-overlapping but touching ($\mkern 1.5mu\overline{\mkern-1.5muO\mkern-1.5mu}\mkern 1.5mu$, ${T}$) if $d=0.0$; and non-overlapping & non-touching ($\mkern 1.5mu\overline{\mkern-1.5muO\mkern-1.5mu}\mkern 1.5mu$, $\mkern 1.5mu\overline{\mkern-1.5muT\mkern-1.5mu}\mkern 1.5mu$) when $d>0.0$ (Fig. F4). Random-baseline accuracy: 50%.

Table T3: Number of samples for each category is the same in our benchmark, where they sum to 768.

<table><tbody><tr><td>Parameter</td><td>Values</td><td>Samples</td><td>Total Samples</td></tr><tr><td rowspan="3">Image size (<math><semantics><mi>C</mi> <annotation>C</annotation></semantics></math>)</td><td>384px</td><td>256</td><td rowspan="3">768</td></tr><tr><td>769px</td><td>256</td></tr><tr><td>1155px</td><td>256</td></tr><tr><td rowspan="4">Diameter (<math><semantics><mi>ϕ</mi> <annotation>\phi</annotation></semantics></math>)</td><td><math><semantics><mfrac><mi>C</mi> <mn>4</mn></mfrac> <annotation>\frac{C}{4}</annotation></semantics></math></td><td>192</td><td rowspan="4">768</td></tr><tr><td><math><semantics><mfrac><mi>C</mi> <mn>5</mn></mfrac> <annotation>\frac{C}{5}</annotation></semantics></math></td><td>192</td></tr><tr><td><math><semantics><mfrac><mi>C</mi> <mn>6</mn></mfrac> <annotation>\frac{C}{6}</annotation></semantics></math></td><td>192</td></tr><tr><td><math><semantics><mfrac><mi>C</mi> <mn>7</mn></mfrac> <annotation>\frac{C}{7}</annotation></semantics></math></td><td>192</td></tr><tr><td rowspan="16">Distance</td><td>-0.25 <math><semantics><mrow><mo>×</mo> <mi>ϕ</mi></mrow> <annotation>\times\phi</annotation></semantics></math></td><td>48</td><td rowspan="16">768</td></tr><tr><td>-0.2 <math><semantics><mrow><mo>×</mo> <mi>ϕ</mi></mrow> <annotation>\times\phi</annotation></semantics></math></td><td>48</td></tr><tr><td>-0.15 <math><semantics><mrow><mo>×</mo> <mi>ϕ</mi></mrow> <annotation>\times\phi</annotation></semantics></math></td><td>48</td></tr><tr><td>-0.1 <math><semantics><mrow><mo>×</mo> <mi>ϕ</mi></mrow> <annotation>\times\phi</annotation></semantics></math></td><td>48</td></tr><tr><td>-0.05 <math><semantics><mrow><mo>×</mo> <mi>ϕ</mi></mrow> <annotation>\times\phi</annotation></semantics></math></td><td>48</td></tr><tr><td>0.0 <math><semantics><mrow><mo>×</mo> <mi>ϕ</mi></mrow> <annotation>\times\phi</annotation></semantics></math></td><td>48</td></tr><tr><td>0.05 <math><semantics><mrow><mo>×</mo> <mi>ϕ</mi></mrow> <annotation>\times\phi</annotation></semantics></math></td><td>48</td></tr><tr><td>0.1 <math><semantics><mrow><mo>×</mo> <mi>ϕ</mi></mrow> <annotation>\times\phi</annotation></semantics></math></td><td>48</td></tr><tr><td>0.15 <math><semantics><mrow><mo>×</mo> <mi>ϕ</mi></mrow> <annotation>\times\phi</annotation></semantics></math></td><td>48</td></tr><tr><td>0.2 <math><semantics><mrow><mo>×</mo> <mi>ϕ</mi></mrow> <annotation>\times\phi</annotation></semantics></math></td><td>48</td></tr><tr><td>0.25 <math><semantics><mrow><mo>×</mo> <mi>ϕ</mi></mrow> <annotation>\times\phi</annotation></semantics></math></td><td>48</td></tr><tr><td>0.3 <math><semantics><mrow><mo>×</mo> <mi>ϕ</mi></mrow> <annotation>\times\phi</annotation></semantics></math></td><td>48</td></tr><tr><td>0.35 <math><semantics><mrow><mo>×</mo> <mi>ϕ</mi></mrow> <annotation>\times\phi</annotation></semantics></math></td><td>48</td></tr><tr><td>0.4 <math><semantics><mrow><mo>×</mo> <mi>ϕ</mi></mrow> <annotation>\times\phi</annotation></semantics></math></td><td>48</td></tr><tr><td>0.45 <math><semantics><mrow><mo>×</mo> <mi>ϕ</mi></mrow> <annotation>\times\phi</annotation></semantics></math></td><td>48</td></tr><tr><td>0.5 <math><semantics><mrow><mo>×</mo> <mi>ϕ</mi></mrow> <annotation>\times\phi</annotation></semantics></math></td><td>48</td></tr><tr><td rowspan="4">Rotation</td><td>Vertical</td><td>192</td><td rowspan="4">768</td></tr><tr><td>Horizontal</td><td>192</td></tr><tr><td>Diagonal 1</td><td>192</td></tr><tr><td>Diagonal 2</td><td>192</td></tr></tbody></table>

![Refer to caption](https://arxiv.org/html/2407.06581v6/pixels_384_rotation_diagonal_1_diameter_0.2_distance_0.05.png)

Figure F3: Samples in the benchmark include various settings for drawing two circles. We start with choosing a rotation (a) and change other parameters of each plot, e.g., the diameter (b), the distance between perimeters (c), and the image size (in pixels). We show the parameters that can be changed to generate different samples inside the legend.

![Refer to caption](https://arxiv.org/html/2407.06581v6/pixels_384_rotation_vertical_diameter_0.14_distance_-0.15.png)

Figure F4: For each image size and distance d, we vary diameter (a) and orientation (b). Groundtruth: O {O}: overlapping. T {T}: touching. ¯ \\mkern 1.5mu\\overline{\\mkern-1.5muO\\mkern-1.5mu}\\mkern 1.5mu: non-overlapping. \\mkern 1.5mu\\overline{\\mkern-1.5muT\\mkern-1.5mu}\\mkern 1.5mu: non-touching.

### 0.F.2 Finding: image resolution does not affect VLMs performance

Fig. F5-left shows that VLMs are almost invariant to the image resolution. For example, GPT-4o and Sonnet-3’s performance saturates at 769px, and Sonnet-3.5 slightly performs worse at 769 and 1155px compared to 384px. Gemini-1.5, however, is fairly consistent across different resolutions. Based off these results, we conclude that VLMs’ ability to see the intersection of two circles does not depend on the quality of the image.

### 0.F.3 Finding: the vertical rotation closes the gap between models’ performance

As shown in Fig. F5-middle, arranging the circles in vertical rotation causes the models to perform similarly on the benchmark. Although Gemini-1.5 slightly performs better at diagonal and Sonnet-3.5 at horizontal rotation, VLMs perform relatively better at vertical rotation. This suggests that the task complexity due to various rotations is not the main source of low performance in VLMs.

### 0.F.4 Finding: Increasing the distance improves the VLMs’ accuracy

VLMs perform better when the distance increases from zero to positive values (see Fig. F5-right). However, Sonnet-3.5 is more conservative than other VLMs that mostly answer “Yes”, which results in its lowest performance at negative distances.

Figure F5: There is no correlation between the resolution of the image (left) and VLMs’ performance. Across various rotations (middle), VLMs perform almost the same at vertical. Most failure cases are at boundary distances (right).

### 0.F.5 Finding: VLMs prefer a specific rotation

Tab. T4 shows that VLMs prefer different rotations. For example, GPT-4o performs best at vertical, Gemini-1.5 at diagonal, Sonnet-3.5 at horizontal, and Sonnet-3 at vertical.

Table T4: VLM accuracy is often best at a specific two-circle orientation. Across three different resolutions, GPT-4o and Sonnet-3 perform much better when two circles are arranged vertically. In contrast, Gemini-1.5 and Sonnet-3.5 prefer the diagonal and horizontal orientations, respectively.

<table><tbody><tr><td></td><td>Resolution</td><td>Rotation</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr><tr><td rowspan="3"><em>a</em></td><td rowspan="3">384px</td><td>vertical</td><td></td><td>82.03</td><td></td><td>93.75</td><td></td><td>96.09</td><td></td><td>90.62</td></tr><tr><td>horizontal</td><td></td><td>71.87</td><td></td><td>89.84</td><td></td><td>75.78</td><td></td><td>96.87</td></tr><tr><td>diagonal</td><td></td><td>69.97</td><td></td><td>95.70</td><td></td><td>78.90</td><td></td><td>94.92</td></tr><tr><td rowspan="3"><em>b</em></td><td rowspan="3">769px</td><td>vertical</td><td></td><td>89.84</td><td></td><td>95.31</td><td></td><td>92.97</td><td></td><td>84.37</td></tr><tr><td>horizontal</td><td></td><td>80.47</td><td></td><td>85.94</td><td></td><td>83.59</td><td></td><td>91.41</td></tr><tr><td>diagonal</td><td></td><td>70.70</td><td></td><td>97.26</td><td></td><td>90.23</td><td></td><td>89.06</td></tr><tr><td rowspan="3"><em>c</em></td><td rowspan="3">1155px</td><td>vertical</td><td></td><td>91.41</td><td></td><td>96.09</td><td></td><td>91.41</td><td></td><td>84.37</td></tr><tr><td>horizontal</td><td></td><td>75.78</td><td></td><td>82.81</td><td></td><td>75.78</td><td></td><td>93.75</td></tr><tr><td>diagonal</td><td></td><td>71.09</td><td></td><td>96.87</td><td></td><td>91.80</td><td></td><td>90.23</td></tr></tbody></table>

### 0.F.6 Finding: Various coloring of the two circles has minimal effects on the overall accuracy

VLMs’ performance in the task does not change substantially ($\pm 5.79\%$ for Sonnet-3.5 and $\pm$ 10.81% for GPT-4o) when tested against different colors (Tab. T5).

Table T5: The small $\triangle$ in VLMs’ performance by changing the colors of the circles suggests that coloring does not significantly impact the VLMs’ vision capabilities.

| Color |  |  |
| --- | --- | --- |
| Magenta - Blue (baseline) | 90.93 | 76.10 |
| Red - Black | 96.72 | 86.91 |
| Yellow - Green | 94.39 | 80.52 |
| Dark gray - Light gray | 93.62 | 82.25 |

### 0.F.7 Results for fine-tuning Bunny on the two touching circle

In order to determine if fine-tuning could improve the model’s performance on this task we attempted to fine-tune Bunny [^12] (Bunny-v1.1-Llama-3-8B-V with the [original weights](https://huggingface.co/BAAI/Bunny-v1_1-Llama-3-8B-V)) on the two touching circles task. We fine-tuned Bunny using datasets of sizes: 10K, 20K, 50K, and 100K samples, each containing a balanced number of instances where the circles are either overlapping or separate (equal number of YES/NO answers in the training set).

The baseline model, without any fine-tuning, achieved 17.1% accuracy for task overlap and 11.7% for touching circles. After fine-tuning, we observed improvements with smaller datasets, such as 10K and 20K cases, where accuracy reached up to 36.8%. However, increasing the number of samples did not lead to better performance. In some instances, such as with the 50K dataset, the model failed to predict anything and only generated the end-of-text token.

The loss values for all these experiments were very close to zero, indicating that the model overfits the training set but fails to generalize. This suggests that training on this task is not straightforward and may require a combination of multiple tasks or that this problem does not have a simple solution.

Fig. F6 shows the accuracy breakdown by distance of the two circles. The model’s performance improves when the circles are overlapping, but when there is a long distance between them, the model does not generalize well and cannot provide accurate answers.

![Refer to caption](https://arxiv.org/html/2407.06581v6/Bunny_NoFinetuning_Accuracy_by_Distance.png)

(a) Accuracy by distance without fine-tuning

### 0.F.8 Additional examples

We show examples of models’ responses to the prompts on the two touching circles task in Fig. F7.

![Refer to caption](https://arxiv.org/html/2407.06581v6/pixels_384_rotation_diagonal_2_diameter_0.2_distance_-0.1.png)

Are the two circles touching each other? Answer with Yes/No.

![Refer to caption](https://arxiv.org/html/2407.06581v6/pixels_769_rotation_vertical_diameter_0.14_distance_-0.1.png)

Are the two circles overlapping? Answer with Yes/No.

## Appendix 0.G Task 3: Identifying the circled letter in a string

### 0.G.1 Task construction

Each image is created using a combination of the below variables.

- String: We test three strings { Acknowledgement, Subdermatoglyphic,  
	tHyUiKaRbNqWeOpXcZvM }. While they all have letters of varying widths and heights, the first two are English words while the latter is a string of random characters. Subdermatoglyphic is the longest English word that has no letter repetitions.
- Letter: We draw the oval () over every letter, one at a time, in each string.
- Font: We use 2 different font families for each word, OpenSans and Helvetica.
- Oval () thickness: We generate the with 3 various line thicknesses.
- Scaling factor: Since each letter has a unique size, we use a scaling factor to control the size of the.

Finally, we render the text on a white canvas with a size of 1250 $\times$ 1250 pixels, and we produce 90 images for Acknowledgement, 102 for Subdermatoglyphic, and 120 samples for tHyUiKaRbNqWeOpXcZvM (see Tabs. T6 and F9).

#### Evaluation

To determine the models’ prediction, we extract the character enclosed in {curly braces} in the models’ response.

#### Code

The code is available at [https://github.com/anguyen8/vision-llms-are-blind/blob/main/src/CircledWord/GenerateSamples.ipynb](https://github.com/anguyen8/vision-llms-are-blind/blob/main/src/CircledWord/GenerateSamples.ipynb).

Prompts

1. *Which letter is being circled? Please provide your answer in curly brackets, e.g. {a}*
2. *Which character is being highlighted with a red oval? Please provide your answer in curly brackets, e.g. {a}*

Groundtruth letters must match predicted letters exactly (case-insensitive).

Table T6: The breakdown of our benchmark based on the number of different parameters shows our data is balanced for each word.

<table><tbody><tr><td>Parameter</td><td>Values</td><td>Samples</td><td>Total Samples</td></tr><tr><td rowspan="3">Word</td><td><p></p><p>Acknowledgement</p><p></p></td><td>90</td><td rowspan="3">312</td></tr><tr><td><p></p><p>Subdermatoglyphic</p><p></p></td><td>102</td></tr><tr><td><p></p><p>tHyUiKaRbNqWeOpXcZvM</p><p></p></td><td>120</td></tr><tr><td rowspan="2">Font</td><td>OpenSans</td><td>156</td><td rowspan="2">312</td></tr><tr><td>Helvetica</td><td>156</td></tr><tr><td>Image size (<math><semantics><mi>C</mi> <annotation>C</annotation></semantics></math>)</td><td>1250x1250 pixels</td><td>312</td><td>312</td></tr><tr><td rowspan="3">Oval thickness</td><td><math><semantics><mrow><mfrac><mn>1</mn> <mn>200</mn></mfrac> <mo>×</mo> <mi>C</mi></mrow> <annotation>\frac{1}{200}\times C</annotation></semantics></math></td><td>104</td><td rowspan="3">312</td></tr><tr><td><math><semantics><mrow><mfrac><mn>1</mn> <mn>250</mn></mfrac> <mo>×</mo> <mi>C</mi></mrow> <annotation>\frac{1}{250}\times C</annotation></semantics></math></td><td>104</td></tr><tr><td><math><semantics><mrow><mfrac><mn>1</mn> <mn>300</mn></mfrac> <mo>×</mo> <mi>C</mi></mrow> <annotation>\frac{1}{300}\times C</annotation></semantics></math></td><td>104</td></tr></tbody></table>

![Refer to caption](https://arxiv.org/html/2407.06581v6/images/CircledLetter/benchmark_samples/gt_b_pred_b_text_image_2c39e0c8-2b50-41ba-b107-591cc86f4630.png)

Figure F9: Our benchmark comprises three different words, of which one letter is circled by the red oval in each image.

Figure F10: Which letter is being red circled?

### 0.G.2 Finding: VLMs mostly confuse the adjacent character for the circled letter

Models often mistake the neighboring characters as actual circled letters. For example, Fig. F11 shows that for Sonnet-3.5 in the word Acknowledgement, all of the incorrect predictions for “n” are the neighboring letter “t”. For Gemini-1.5, in the word tHyUiKaRbNqWeOpXcZvM, where letters “K” and “a” are adjacent, 100% of the mispredictions for “K” are the letter “a” (see Fig. F12).

![Refer to caption](https://arxiv.org/html/2407.06581v6/images/CircledLetter/ConfusionMatrices/better_labels/ack_sonnet35.png)

Figure F11: Adjacent letters are the most common wrong prediction for Sonnet- 3.5 in Acknowledgement, e.g., letter “e” is predicted instead of “m” 20.83% of the time, or letter “t” is predicted instead of “n” 27.08% of the time.

![Refer to caption](https://arxiv.org/html/2407.06581v6/images/CircledLetter/ConfusionMatrices/better_labels/thy_gemini.png)

Figure F12: Gemini- 1.5 tends to confuse adjacent letters like “a” and “K”. also hallucinates the circled letter “a” as being the character “@” and it confuses the letter “q” for the letter “g”.

![Refer to caption](https://arxiv.org/html/2407.06581v6/sub_zero_space.png)

Figure F13: Aggregate confusion matrix summed over all 4 VLMs and 12 responses for each letter in the word Subdermatoglyphic. Models mostly mispredict characters near the circled letter. VLMs sometimes hallucinate characters that do not even exist in the word, e.g., “@” ( right panel ).

### 0.G.3 Finding: GPT-4o and Gemini-1.5 confuse the red oval as part of the letter

Figs. F14 and F15 show that Gemini-1.5 and GPT-4o sometimes fail to recognize that the red oval is not part of the letter. Gemini-1.5 tends to predict that the circled letter “a” is actually the “@” sign (see Fig. F14). GPT-4o on the other hand tends to predict “o” regardless of which letter is circled (Fig. F15).

![Refer to caption](https://arxiv.org/html/2407.06581v6/gemini_failure_cases.png)

Figure F14: Random samples for different words, and Gemini- 1.5 ’s predictions, where mostly predicts the adjacent letters or confuses the red oval as part of the circled letter.

![Refer to caption](https://arxiv.org/html/2407.06581v6/images/CircledLetter/ConfusionMatrices/better_labels/sub_gpt4o.png)

Figure F15: GPT- 4o is the most sensitive to confuse the red oval as part of the letter, where it often predicts “o” instead of “l”, “y”, “p”, and “c” in the word Subdermatoglyphic.

### 0.G.4 Finding: Models perform similarly across two common font families

As shown in Fig. F16, models do not show a significant variance over different fonts, suggesting our choice of font is not a reason for their unreliable performance.

![Refer to caption](https://arxiv.org/html/2407.06581v6/images/CircledLetter/appendix_ex/spaced_fonts_df.png)

Figure F16: VLMs do not show a consistent trend between fonts. This suggests that using different spacing between letters, letter styles, and letter size has minimal effects on the VLMs’ ability to see the content of the red oval.

### 0.G.5 Finding: models are invariant to our choice of prompts

Our choice of prompts has little impact on the performance of the models as depicted in Fig. F17.

![Refer to caption](https://arxiv.org/html/2407.06581v6/images/CircledLetter/appendix_ex/prompt_dif.png)

Figure F17: Model performance breakdown for different prompts P1: "Which letter is being circled? Please provide your answer in curly brackets, e.g. { a } " and P2: "Which character is being highlighted with a red oval? Please provide your answer in curly brackets, e.g.. Regardless of the prompts, VLMs perform similarly in seeing the contents of the red oval.

### 0.G.6 Finding: VLMs fail to see the circled letter on various English words

On average, SOTA VLMs show the same limitations across various English words (see Tab. T7). However, the mean accuracy over words with less and non-repetitive letters is higher than others (the mean accuracy over the word question is 90.36% while it is 79.86% on the word civilization ).

Table T7: Overall, VLMs perform better on short words without repetitive letters, *e.g*., question. Yet, the mean accuracy of four SOTA VLMs (86.43%) is far from being 100% accurate.

| String |  |  |  |  | Mean |
| --- | --- | --- | --- | --- | --- |
| question | 98.96 | 100.00 | 62.50 | 100.00 | 90.36 |
| syndrome | 91.67 | 91.67 | 70.83 | 91.58 | 86.44 |
| environmental | 82.69 | 89.10 | 73.72 | 89.74 | 83.81 |
| civilization | 79.17 | 87.50 | 61.80 | 90.97 | 79.86 |
| tournament | 89.17 | 92.50 | 85.00 | 100.00 | 91.67 |
| Mean accuracy | 88.33 | 92.15 | 70.77 | 94.46 | 86.43 |

Table T8: Except for GPT-4o, all other models have a higher accuracy (%) on the two English words than on the random string, suggesting that VLMs might leverage their familiarity with a known word to make educated guesses.

| String |  |  |  |  | Mean |
| --- | --- | --- | --- | --- | --- |
| Acknowledgement | 77.22 | 96.67 | 87.22 | 91.11 | 88.06 |
| Subdermatoglyphic | 64.42 | 74.02 | 68.14 | 94.10 | 75.25 |
| tHyUiKaRbNqWeOpXcZvM | 81.25 | 79.17 | 60.83 | 77.92 | 74.79 |
| Mean accuracy | 74.23 | 83.29 | 72.06 | 87.88 | 79.37 |

### 0.G.7 Adding white space between letters consistently improves the accuracy across all words

As shown in Fig. F18, VLMs perform better when we add more white space between letters of a word, *e.g*., $\triangle$ for GPT-4o on the words Acknowledgement and Subdermatoglyphic from 0 to 3 spaces are 11% and 21%, respectively.

![Refer to caption](https://arxiv.org/html/2407.06581v6/Acknowledgement.png)

Refer to caption

### 0.G.8 Additional Examples

Examples from our evaluation of VLMs on the circled letter task are shown in Fig. F19.

![Refer to caption](https://arxiv.org/html/2407.06581v6/images/CircledLetter/QualSamples/P2/gt_m_Sonnet_e_Sonnet-3.5_e_GPT-4o_e_Gemini-1.5-Pro_m_text_image_2ffcf634-2773-40a8-a7dc-072a26890b6a_prompt2.png)

Which character is being highlighted with a red oval? Please provide your answer in curly brackets, e.g. {a}

## Appendix 0.H Counting the number of line intersections task

### 0.H.1 Benchmark Construction Details

To create our benchmark, we use 5 parameters to control the diversity of the samples.

- Color: We fix the colors for each line to use { *blue*, *red* }
- Image size: We generate 3 different image resolutions, {384, 768, 1152}px, to include high and low-resolution samples in our tests.
- Grid size: We divide the whole image into a 12 $\times$ 12 grid with 144 equal sized cells. Then, we choose 3 points for each (blue and red) line on the grid to draw the line plots. To make sure the line plots do not overlap and the intersections are well distanced from the edges, we fix the x-coordinates, and randomly sample y-coordinates from the invisible 12 $\times$ 12 grid. The grid sampling also avoids picking the same coordinates for both blue and red line.
- X-coordinate: For each point, we choose x $=0,\frac{C}{2},C$ px.
- Y-coordinate: For each x-coordinate above, we randomly sample a y-coordinate from 12 pre-defined rows in the 12 $\times$ 12 grid. We also ensure that no blue and red points share the exact same (x,y) coordinates.
- Line thickness: We vary the line widths with standard *matplotlib* values (2 and 4), which renders into a width of $0.005\times C$ and $0.01\times C$ pixels, respectively.
- Number of intersections: We count the intersections based on the three points defined for each line ($(x,y_{1})$, $(x,y_{2})$, and $(x,y_{3})$).

We repeat the process until we have 2 line widths $\times$ 3 image sizes $\times$ 100 samples of 0, 1, and 2 intersections, resulting in 1800 images (see Tabs. T9 and F20).

Code The code to generate the images is at [https://github.com/anguyen8/vision-llms-are-blind/blob/main/src/LineIntersection/2dline.ipynb](https://github.com/anguyen8/vision-llms-are-blind/blob/main/src/LineIntersection/2dline.ipynb).

Prompts We ask each question using two different wordings:

1. *How many times do the blue and red lines touch each other? Answer with a number in curly brackets, e.g., {5}.*
2. *Count the intersection points where the blue and red lines meet. Put your answer in curly brackets, e.g., {2}.*

Groundtruth answers are $\in\{0,1,2\}$ (random-baseline accuracy: 33.33%).

![Refer to caption](https://arxiv.org/html/2407.06581v6/gemini-count_gt_0_image_12_thickness_2_resolution_768.png)

Figure F20: Samples from the two intersecting lines benchmark that contain 0, 1, or 2 line intersections.

![Refer to caption](https://arxiv.org/html/2407.06581v6/gt_0_image_8_thickness_2_resolution_1152.png)

Figure F21: Count intersections

Table T9: We generate the same number of images based on various parameters to have a balanced benchmark.

<table><tbody><tr><td>Parameter</td><td>Values</td><td>Samples</td><td>Total Samples</td></tr><tr><td rowspan="3">Image size (<math><semantics><mi>C</mi> <annotation>C</annotation></semantics></math>)</td><td>384px</td><td>600</td><td rowspan="2">1800</td></tr><tr><td>768px</td><td>600</td></tr><tr><td>1152px</td><td>600</td><td></td></tr><tr><td rowspan="2">Line thickness</td><td><math><semantics><mrow><mn>0.005</mn> <mo>×</mo> <mi>C</mi></mrow> <annotation>0.005\times C</annotation></semantics></math></td><td>900</td><td rowspan="2">1800</td></tr><tr><td><math><semantics><mrow><mn>0.01</mn> <mo>×</mo> <mi>C</mi></mrow> <annotation>0.01\times C</annotation></semantics></math></td><td>900</td></tr><tr><td rowspan="3">Number of intersections</td><td>0</td><td>600</td><td rowspan="3">1800</td></tr><tr><td>1</td><td>600</td></tr><tr><td>2</td><td>600</td></tr></tbody></table>

### 0.H.2 Finding: image resolution does not influence VLM’s ability to count the line intersections

Fig. F22 depicts that increasing the resolution in our plots does not help the VLMs see and count the intersections of 2D lines.

### 0.H.3 Finding: VLMs perform similarly when the lines intersect twice

Our benchmark consists of images with 0 to 1 line intersections with an identical number of samples in each category. We break down the performance of each model based on the groundtruth in Fig. F22-right to analyze where VLMs mostly fail in their overall performance. As depicted in Fig. F22-right, VLMs perform relatively better on 2 intersections (except Sonnet-3.5 that is best on 1 intersection) and perform worse on 0 intersections (Sonnet-3 is the worst).

Figure F22: VLMs are not sensitive to the image resolution to see and count the number of intersections (left). When the lines intersect twice, VLMs perform similarly, while Sonnet-3.5 has the least variance over different numbers of intersections (right).

### 0.H.4 Additional Examples

We show examples of models’ responses to the prompts on the counting the number of line intersections task in Fig. F23.

![Refer to caption](https://arxiv.org/html/2407.06581v6/gemini-count_gt_0_image_99_thickness_2_resolution_1152.png)

Count the intersection points where the blue and red lines meet. Put your answer in curly brackets, e.g., {2}.

![Refer to caption](https://arxiv.org/html/2407.06581v6/gt_0_image_94_thickness_2_resolution_1152.png)

How many times do the blue and red lines touch each other? Answer with a number in curly brackets, e.g., {5}.

## Appendix 0.I Counting the number of nested squares

### 0.I.1 Benchmark Construction Details

We use 5 parameters to create the images of nested squares.

- Depth: For each image, we draw $N\in\{2,3,4,5\}$ nested squares on the image. We refer to each square in this collection as a depth.
- Initial size: We choose a random size for the first square in the bounds of the image size.
- Reduction factor: We draw squares such that each depth is entirely contained by its previous depth. We use a reduction factor to scale the square sizes.
- Center: The first square’s center is chosen to ensure it is entirely visible in the image. For the remaining squares, we choose the center based on the space between the previous square and the new reduced size.
- Line thickness: We use standard *matplotlib* line width parameter of (2=3px, 3=4px, 4=6px).

We continue to generate images until we have 30 samples for each depth, resulting in 120 images overall (see Tabs. T10 and F25).

Code The code is available at [https://github.com/anguyen8/vision-llms-are-blind/blob/main/src/NestedSquares/GenerateSamples.ipynb](https://github.com/anguyen8/vision-llms-are-blind/blob/main/src/NestedSquares/GenerateSamples.ipynb).

Post-processing: To determine the model’s answer, we use Python to extract the number from curly braces in the response e.g. {3}.

Prompts

1. *How many squares are in the image? Please answer with a number in curly brackets e.g., {10}.*
2. *Count total number of squares in the image. Answer with only the number in numerical format in curly brackets e.g. {3}.*

Groundtruth answers are $\in\{2,3,4,5\}$ (random-baseline accuracy: 25%).

|  |  |  |  |
| --- | --- | --- | --- |
|  |  |  |  |
| (a) 2 squares | (b) 3 squares | (c) 4 squares | (d) 5 squares |

Figure F25: Random examples from the nested square task that have 2, 3, 4 or 5 squares in the image.

| GT = 2 | GT = 3 |
| --- | --- |
| GT = 4 | GT = 5 |

Figure F26: Count squares

Table T10: Nested squares include the same number of samples for each parameter value in our benchmark.

<table><tbody><tr><td>Parameter</td><td>Values</td><td>Samples</td><td>Total Samples</td></tr><tr><td>Image size</td><td>1000px</td><td>120</td><td>120</td></tr><tr><td rowspan="3">Line thickness</td><td>3px</td><td>40</td><td rowspan="3">120</td></tr><tr><td>4px</td><td>40</td></tr><tr><td>6px</td><td>40</td></tr><tr><td rowspan="4">Number of Squares</td><td>2</td><td>30</td><td rowspan="4">120</td></tr><tr><td>3</td><td>30</td></tr><tr><td>4</td><td>30</td></tr><tr><td>5</td><td>30</td></tr></tbody></table>

### 0.I.2 Finding: the best-performing model is affected by line width

Tab. T11 shows that the best VLM on the nested square task (Sonnet-3.5) is more accurate as line width increases. In contrast, the worst model (GPT-4o) shows the opposite trend as the line thickness changes, suggesting that GPT-4o confuses squares when the borderline is thick.

Table T11: Line thickness has minimal effect on VLMs’ performance, suggesting that visual attributes of shapes are not critical to VLMs when asked to count the shapes.

| Line width |  |  |  |  |
| --- | --- | --- | --- | --- |
| 2 | 58.75 | 86.25 | 61.25 | 90.00 |
| 3 | 56.25 | 85.00 | 67.50 | 91.25 |
| 4 | 52.50 | 90.00 | 66.25 | 95.00 |
| Average | 55.83 | 87.08 | 65.00 | 92.08 |

### 0.I.3 Additional Examples

We show examples of models’ responses to the counting the number of nested squares task in Fig. F27.

![Refer to caption](https://arxiv.org/html/2407.06581v6/nested_squares_depth_2_image_10_thickness_2.png)

Count total number of squares in the image. Answer with only the number in numerical format in curly brackets e.g. {3}.

![Refer to caption](https://arxiv.org/html/2407.06581v6/nested_squares_depth_2_image_1_thickness_4.png)

How many squares are in the image? Please answer with a number in curly brackets e.g., {10}.

## Appendix 0.J Counting the shapes in an Olympic-like logo

### 0.J.1 Benchmark Construction Details

We create the benchmark by generating images containing shapes resembling the Olympic logo by choosing a combination of settings.

- Image size: We fix the physical size of the image in *matplotlib* to 5 $\times$ 5, and change the resolution by changing the DPI value, which is $\in\{100,200,300\}$ to get images with sizes $\{384,769,1155\}$ px.
- Number of shapes: We choose a number from {5, 6, 7, 8, 9}.
- Color: Each image is generated using two different coloring schemes. We generate an all-black version and a second version by randomly sampling colors from a colormap in *matplotlib*.
- Distance: To generate the interlaced shapes, we use a small boundary-to-boundary distance factor for each row of the shapes. We fix this value to 0.1 proportional to the diameter of circles or side length of pentagons.
- Diameter: We choose a uniform diameter for all the circles in each image from $\{\frac{1}{7},\frac{1}{10}\}$ proportional to the image size.
- Side length: We follow the same policy for the diameter to choose the side length of the pentagons.
- Line thickness: We generate each image with {0.5, 1.0} line width of *matplotlib* standard. This results in {1px, 2px} lines in 384px images, {2px, 3px} lines in 769px images and {3px, 5px} lines in 1155px images.

We center the shape collection on the center of the image in two rows, and generate 480 images (see Figs. F29 and T12), 240 images of circles, and 240 images of pentagons.

Code The code is available at [https://github.com/anguyen8/vision-llms-are-blind/blob/main/src/CountingCircles/OlympicCircles.ipynb](https://github.com/anguyen8/vision-llms-are-blind/blob/main/src/CountingCircles/OlympicCircles.ipynb) for circles and at [https://github.com/anguyen8/vision-llms-are-blind/blob/main/src/CountingCircles/OlympicPentagons.ipynb](https://github.com/anguyen8/vision-llms-are-blind/blob/main/src/CountingCircles/OlympicPentagons.ipynb) for pentagons.

Prompts

1. *How many {shapes} are in the image? Answer with only the number in numerical format.*
2. *Count the {shapes} in the image. Answer with a number in curly brackets e.g. {3}.*

where *{shapes}* = *circles* or *pentagons*.

Groundtruth answers are $\in\{5,6,7,8,9\}$ (random-baseline accuracy: 20%).

![Refer to caption](https://arxiv.org/html/2407.06581v6/pixels_1155_linewidth_1_diameter_0.1_numCircles_6_colored_2.png)

Figure F29: We generate images of (a) different numbers of circles with various parameter changes, e.g., the diameter, (b) the linewidth (in points) (c) colorings, and the image size (in pixels). For the pentagons, we vary the side length instead of the diameter.

![Refer to caption](https://arxiv.org/html/2407.06581v6/pixels_384_linewidth_0.5_diameter_0.1_numCircles_5_black.png)

Figure F30: Images span across three sizes and shapes span across two diameters (and two side lengths for ⬠ ), two color options (black vs. colored), and two line widths.

Table T12: We create 480 images containing circles and pentagons that are uniformly distributed over various parameters.

<table><tbody><tr><td>Parameter</td><td>Values</td><td>Samples</td><td>Total Samples</td></tr><tr><td rowspan="2">Shape</td><td>Circles</td><td>240</td><td rowspan="2">480</td></tr><tr><td>Pentagons</td><td>240</td></tr><tr><td rowspan="3">Image size (<math><semantics><mi>C</mi> <annotation>C</annotation></semantics></math>)</td><td>384px</td><td>80</td><td rowspan="3">240</td></tr><tr><td>769px</td><td>80</td></tr><tr><td>1155px</td><td>80</td></tr><tr><td rowspan="2">Line thickness</td><td><math><semantics><mrow><mn>0.0025</mn> <mo>×</mo> <mi>C</mi></mrow> <annotation>0.0025\times C</annotation></semantics></math> pixels</td><td>120</td><td rowspan="2">240</td></tr><tr><td><math><semantics><mrow><mn>0.005</mn> <mo>×</mo> <mi>C</mi></mrow> <annotation>0.005\times C</annotation></semantics></math> pixels</td><td>120</td></tr><tr><td rowspan="5">Number of shapes</td><td>5</td><td>48</td><td rowspan="5">240</td></tr><tr><td>6</td><td>48</td></tr><tr><td>7</td><td>48</td></tr><tr><td>8</td><td>48</td></tr><tr><td>9</td><td>48</td></tr><tr><td rowspan="2">Diameter/Side</td><td><math><semantics><mfrac><mi>C</mi> <mn>7</mn></mfrac> <annotation>\frac{C}{7}</annotation></semantics></math></td><td>120</td><td rowspan="2">240</td></tr><tr><td><math><semantics><mfrac><mi>C</mi> <mn>10</mn></mfrac> <annotation>\frac{C}{10}</annotation></semantics></math></td><td>120</td></tr></tbody></table>

### 0.J.2 Finding: different resolutions have no impact on most VLMs’ performance

Fig. F31-a shows that VLMs are invariant to the resolution when asked to count the overlapping shapes. This suggests that the image quality has almost no effect on the performance, and VLMs cannot see the shapes.

<table><tbody><tr><td colspan="3"></td></tr><tr><td colspan="3">Counting overlapping circles ○ ○ ○</td></tr><tr><td>   (a) Resolution</td><td>     (b) Color</td><td>     (c) Number of shapes</td></tr><tr><td colspan="3"></td></tr><tr><td colspan="3">Counting overlapping pentagons ⬠ ⬠ ⬠</td></tr></tbody></table>

Figure F31: VLMs perform better on counting overlapping circles ○ ○ ○ (top) than overlapping pentagons ⬠ ⬠ ⬠ (bottom). For most models, resolution (a) and colors (b) have minimal impact on performance. Sonnet-3.5 performs better as the image size increases (a). GPT-4o performs better on colored shapes than on black shapes.

### 0.J.3 Finding: color-coding does not generally help the VLMs

While we expect the color-coding to make the shapes more distinct for the models, Fig. F31-b suggests that, except for GPT-4o, coloring the shapes has an opposite effect on the performance of the models.

### 0.J.4 Finding: Gemini-1.5 has the most biased predictions to the Olympic logo

Fig. F32 shows the overall trend of the predictions among SOTA VLMs. Gemini-1.5 (see Fig. 32(b)) tends to predict “5” significantly more often when asked to count the circles, while its predictions are more random for pentagons. This suggests the model’s bias toward the Olympic logo.

(a) GPT-4o

(b) Gemini-1.5

(c) Sonnet-3

(d) Sonnet-3.5

Figure F32: Prediction trend for each VLM shows (a) GPT-4o has less variance in counting circles versus pentagons, (b) Gemini-1.5 is biased to predicting the number of circles to be 5, (c) Sonnet-3 tends to under count the number of shapes, and (d) Sonnet-3.5 has the least relative variance over both shapes.

Table T13: Frequency (%) of predicting “5” when there are more than 5 circles ( ○ ) or pentagons ( ⬠ ), *i.e*., $N=6,7,8,9$ shapes in the image. For example, Gemini-1.5 predicts “5” circles 99.74% of the time but this tendency disappears in the case of ⬠ (10.94%), showing a strong bias towards the 5-circle Olympic logo (among four models).

<table><tbody><tr><td></td><td colspan="2"></td><td></td><td colspan="2"></td><td></td><td colspan="2"></td><td></td><td colspan="2"></td></tr><tr><td></td><td>○</td><td>⬠</td><td></td><td>○</td><td>⬠</td><td></td><td>○</td><td>⬠</td><td></td><td>○</td><td>⬠</td></tr><tr><td></td><td>13.54</td><td>5.47</td><td></td><td>99.74</td><td>10.94</td><td></td><td>64.32</td><td>5.73</td><td></td><td>15.89</td><td>10.16</td></tr></tbody></table>

### 0.J.5 Additional Examples

![Refer to caption](https://arxiv.org/html/2407.06581v6/5adbe5c8-bd23-4e57-8ca3-35e536a949c3.png)

Count the circles in the image. Answer with a number in curly brackets e.g. {3}

![Refer to caption](https://arxiv.org/html/2407.06581v6/pixels_384_linewidth_0.5_diameter_0.1_numCircles_5_black_2_withOutline.png)

How many circles are in the image? Answer with only the number in numerical format.

## Appendix 0.K Counting the rows and columns of a grid task

### 0.K.1 Benchmark Construction Details

Our benchmark specifications consist of various parameters for the grid generation process.

- Image size: We include three different sizes {500, 1250, 2000} to create the grids on the image.
- Number of rows/columns: We choose a base size $N\in\{3,4,5,6,7,8,9\}$, and initialize the sizes to $N\times N$, $N\times N^{\prime}$, and $N^{\prime}\times N$ where $N^{\prime}=N+1$. We also create 10 $\times$ 10 grids to balance the square grids.
- Line thickness: We use a line thickness of 1% of the image size and 0.5% of the image size.
- Entry: Each table is generated in two versions, one that includes blank entries, and the second with random text entries.

We divide the image size by the number of rows and columns to find the coordinates for drawing the borderlines. Then, we draw the lines on the four edges of the image and draw the remaining lines in between. Our benchmark comprises 264 images of blank and text-containing grids (see Tabs. T14 and F35).

Code The code is available at [https://github.com/anguyen8/vision-llms-are-blind/blob/main/src/CountingRowsAndColumns/Grids.ipynb](https://github.com/anguyen8/vision-llms-are-blind/blob/main/src/CountingRowsAndColumns/Grids.ipynb).

Prompts

1. *Count the number of rows and columns and answer with numbers in curly brackets. For example, rows={5} columns={6}*
2. *How many rows and columns are in the table? Answer with only the numbers in a pair (row, column), e.g., (5,6)*.

Groundtruth answers include both the number of rows and columns. An answer is correct when both column and row counts are correctly predicted (random-chance accuracy is 1/22, *i.e*., 4.55%).

Table T14: BlindTest consists of 264 empty and text-containing grids. We create equal number of images for each subcategory.

<table><tbody><tr><td>Parameter</td><td>Values</td><td>Samples</td><td>Total Samples</td></tr><tr><td rowspan="2">Cell</td><td>Empty</td><td>132</td><td rowspan="2">264</td></tr><tr><td>Text</td><td>132</td></tr><tr><td rowspan="3">Image size (<math><semantics><mi>C</mi> <annotation>C</annotation></semantics></math>)</td><td>500px</td><td>44</td><td rowspan="3">132</td></tr><tr><td>1250px</td><td>44</td></tr><tr><td>2000px</td><td>44</td></tr><tr><td rowspan="2">Line thickness</td><td><math><semantics><mrow><mn>0.005</mn> <mo>×</mo> <mi>C</mi></mrow> <annotation>0.005\times C</annotation></semantics></math></td><td>66</td><td rowspan="2">132</td></tr><tr><td><math><semantics><mrow><mn>0.01</mn> <mo>×</mo> <mi>C</mi></mrow> <annotation>0.01\times C</annotation></semantics></math></td><td>66</td></tr><tr><td rowspan="22">Dimensions</td><td><math><semantics><mrow><mn>3</mn> <mo>×</mo> <mn>3</mn></mrow> <annotation>3\times 3</annotation></semantics></math></td><td>6</td><td rowspan="22">132</td></tr><tr><td><math><semantics><mrow><mn>3</mn> <mo>×</mo> <mn>4</mn></mrow> <annotation>3\times 4</annotation></semantics></math></td><td>6</td></tr><tr><td><math><semantics><mrow><mn>4</mn> <mo>×</mo> <mn>3</mn></mrow> <annotation>4\times 3</annotation></semantics></math></td><td>6</td></tr><tr><td><math><semantics><mrow><mn>4</mn> <mo>×</mo> <mn>4</mn></mrow> <annotation>4\times 4</annotation></semantics></math></td><td>6</td></tr><tr><td><math><semantics><mrow><mn>4</mn> <mo>×</mo> <mn>5</mn></mrow> <annotation>4\times 5</annotation></semantics></math></td><td>6</td></tr><tr><td><math><semantics><mrow><mn>5</mn> <mo>×</mo> <mn>4</mn></mrow> <annotation>5\times 4</annotation></semantics></math></td><td>6</td></tr><tr><td><math><semantics><mrow><mn>5</mn> <mo>×</mo> <mn>5</mn></mrow> <annotation>5\times 5</annotation></semantics></math></td><td>6</td></tr><tr><td><math><semantics><mrow><mn>5</mn> <mo>×</mo> <mn>6</mn></mrow> <annotation>5\times 6</annotation></semantics></math></td><td>6</td></tr><tr><td><math><semantics><mrow><mn>6</mn> <mo>×</mo> <mn>5</mn></mrow> <annotation>6\times 5</annotation></semantics></math></td><td>6</td></tr><tr><td><math><semantics><mrow><mn>6</mn> <mo>×</mo> <mn>6</mn></mrow> <annotation>6\times 6</annotation></semantics></math></td><td>6</td></tr><tr><td><math><semantics><mrow><mn>6</mn> <mo>×</mo> <mn>7</mn></mrow> <annotation>6\times 7</annotation></semantics></math></td><td>6</td></tr><tr><td><math><semantics><mrow><mn>7</mn> <mo>×</mo> <mn>6</mn></mrow> <annotation>7\times 6</annotation></semantics></math></td><td>6</td></tr><tr><td><math><semantics><mrow><mn>7</mn> <mo>×</mo> <mn>7</mn></mrow> <annotation>7\times 7</annotation></semantics></math></td><td>6</td></tr><tr><td><math><semantics><mrow><mn>7</mn> <mo>×</mo> <mn>8</mn></mrow> <annotation>7\times 8</annotation></semantics></math></td><td>6</td></tr><tr><td><math><semantics><mrow><mn>8</mn> <mo>×</mo> <mn>7</mn></mrow> <annotation>8\times 7</annotation></semantics></math></td><td>6</td></tr><tr><td><math><semantics><mrow><mn>8</mn> <mo>×</mo> <mn>8</mn></mrow> <annotation>8\times 8</annotation></semantics></math></td><td>6</td></tr><tr><td><math><semantics><mrow><mn>8</mn> <mo>×</mo> <mn>9</mn></mrow> <annotation>8\times 9</annotation></semantics></math></td><td>6</td></tr><tr><td><math><semantics><mrow><mn>9</mn> <mo>×</mo> <mn>8</mn></mrow> <annotation>9\times 8</annotation></semantics></math></td><td>6</td></tr><tr><td><math><semantics><mrow><mn>9</mn> <mo>×</mo> <mn>9</mn></mrow> <annotation>9\times 9</annotation></semantics></math></td><td>6</td></tr><tr><td><math><semantics><mrow><mn>9</mn> <mo>×</mo> <mn>10</mn></mrow> <annotation>9\times 10</annotation></semantics></math></td><td>6</td></tr><tr><td><math><semantics><mrow><mn>10</mn> <mo>×</mo> <mn>9</mn></mrow> <annotation>10\times 9</annotation></semantics></math></td><td>6</td></tr><tr><td><math><semantics><mrow><mn>10</mn> <mo>×</mo> <mn>10</mn></mrow> <annotation>10\times 10</annotation></semantics></math></td><td>6</td></tr></tbody></table>

![Refer to caption](https://arxiv.org/html/2407.06581v6/blank_grid_7x8_2000_10.png)

Figure F35: We create grids with various sizes and line thicknesses. Each grid has a blank (a) and text (b) version.

![Refer to caption](https://arxiv.org/html/2407.06581v6/text_grid_3x3_2000_10.png)

Figure F36: Empty and text-containing grids are generated with various image sizes.

### 0.K.2 Finding: VLMs cannot reliably count either rows or columns

We expect counting rows and columns separately to be hard for the VLMs, thus we analyze counting the rows and grids individually to see how VLMs perform. As shown in Tab. T16, VLMs cannot count either rows or columns alone.

Table T15: Including text inside grids improves all model accuracies. Sonnet-3.5, yet, outperforms other models on both empty and text-containing grids.

| Grid |  |  |  |  | Mean |
| --- | --- | --- | --- | --- | --- |
| Empty | 26.13 | 26.51 | 25.00 | 59.84 | 34.37 |
| Text | 53.03 | 52.27 | 47.34 | 88.68 | 60.33 |
| Mean | 39.58 | 39.39 | 36.17 | 74.26 | 47.35 |

Table T16: Average row and column counting accuracy (%) of VLMs. VLMs perform better at counting columns (70.53% accuracy) than counting rows (60.83%)—both of which are far from the expected 100% accuracy.

| Axis |  |  |  |  | Mean |
| --- | --- | --- | --- | --- | --- |
| Rows | 65.54 | 52.95 | 42.19 | 82.64 | 60.83 |
| Columns | 58.42 | 58.50 | 74.65 | 90.54 | 70.53 |

### 0.K.3 Additional Examples

![Refer to caption](https://arxiv.org/html/2407.06581v6/x14.png)

Count the number of rows and columns and answer with numbers in curly brackets. For example, rows={5} columns={6}.

![Refer to caption](https://arxiv.org/html/2407.06581v6/x14.png)

Count the number of rows and columns and answer with numbers in curly brackets. For example, rows={5} columns={6}

![Refer to caption](https://arxiv.org/html/2407.06581v6/text_grid_4x4_500_20.png)

How many rows and columns are in the table? Answer with only the numbers in a pair (row, column), e.g., (5,6).

## Appendix 0.L Following single-colored paths task

### 0.L.1 Benchmark Construction Details

Our subway-like graphs are generated using a set of parameters defining the characteristics of the plot.

- Image size: We use two different sizes {512, 1024}px for the images to include various resolutions.
- Grid size: We assume a hypothetical grid on the image that determines the position of the paths. We used an 18 $\times$ 18 grid, which means each path segment is $\frac{1}{18}$ of the image size.
- Number of stations: We use four station labels, {A, B, C, D}.
- Starting points: Each station in our maps has three different starting points which are exactly $\frac{1}{18}$ of the image size to one side of the stations.
- Path thickness: We use two line thicknesses, 10 and 20 pixels to have bold and light visualizations of the same path.
- Number of paths: Considering the number of starting points in our setup, each image can include stations from which exactly 1, 2, or 3 paths exit.

We keep generating the images until we have 15 samples for each number of paths which results in 180 images (see Tabs. T17 and F40).

Code The code is available at [https://github.com/anguyen8/vision-llms-are-blind/blob/main/src/SubwayMap/SubwayMap.ipynb](https://github.com/anguyen8/vision-llms-are-blind/blob/main/src/SubwayMap/SubwayMap.ipynb)

Prompts

1. *How many single-colored paths go from {station 1} to {station 2}? Answer with a number in curly brackets, e.g., {3}.*
2. *Count the one-colored routes that go from {station 1} to {station 2}. Answer with a number in curly brackets, e.g., {3}.*

where the two stations are different and sampled from $\{\text{ {{\footnotesize A}}, {{\footnotesize B}}, {{\footnotesize C}}, {{\footnotesize D}} }\}$.

Groundtruth answers are $\in\{1,2,3\}$ (random-baseline accuracy: 33.33%).  
Note that, to make the task easier, 0 is excluded from the groundtruth set (*i.e*., we never ask VLMs to count when no path exists between two given stations).

Table T17: We create 2 different image resolutions, and 3 various line widths to have balanced number of colored paths.

<table><tbody><tr><td>Parameter</td><td>Values</td><td>Samples</td><td>Total Samples</td></tr><tr><td rowspan="2">Image size</td><td>512px</td><td>90</td><td rowspan="2">180</td></tr><tr><td>1024px</td><td>90</td></tr><tr><td rowspan="2">Line thickness</td><td>10px</td><td>90</td><td rowspan="2">180</td></tr><tr><td>20px</td><td>90</td></tr><tr><td rowspan="3">Paths</td><td>1</td><td>60</td><td rowspan="3">180</td></tr><tr><td>2</td><td>60</td></tr><tr><td>3</td><td>60</td></tr></tbody></table>

![Refer to caption](https://arxiv.org/html/2407.06581v6/pixels_1024_linewidth_20_path_1_caf3c976-4326-4abd-abc8-109140b8f16a.png)

Figure F40: Images in our benchmark (left) have exactly 1, 2, or 3 paths exiting each station. The hypothetical grids (right) are used when generating the paths.

![Refer to caption](https://arxiv.org/html/2407.06581v6/pixels_512_linewidth_10_path_1_921cbd8a-9833-433a-9104-9b568bf10ac7.png)

Figure F41: On an invisible 18 × \\times 18 grid (bottom right), we randomly generate random paths from one station to another. All stations have an equal N = 1, 2 or 3 outgoing paths.

### 0.L.2 Finding: VLMs fail to see the colored paths across various map complexities

All VLMs, except Sonnet-3, start to perform worse as the number of paths per station increases in the images of subway-like maps (Fig. F42).

![Refer to caption](https://arxiv.org/html/2407.06581v6/heatmap.png)

Refer to caption

### 0.L.3 Sonnet-3.5 can more accurately count subway paths on simplified images compared to other VLMs

Sonnet-3.5 consistently benefits from increasing the probability of choosing the straight path across all image settings (Fig. F43), suggesting its counting ability is generally better than other VLMs, and perhaps the complexity of images is the reason for its initial low performance.

![Refer to caption](https://arxiv.org/html/2407.06581v6/heatmap_probs_land.png)

Figure F43: Sonnet- 3.5 has the largest mean performance gain ( +27 ) from P = P= 0.33 to 0.9 when we increase the probability of choosing a straight path.

### 0.L.4 Additional Examples

We show examples of models’ responses to the counting the number of single-colored connecting paths in Fig. F44.

![Refer to caption](https://arxiv.org/html/2407.06581v6/pixels_512_linewidth_20_path_1_4bde93d6-5c5c-421c-9fe0-b3b7e155276f.png)

How many single-color paths go from A to B? Answer with a number in curly brackets e.g. {3}

![Refer to caption](https://arxiv.org/html/2407.06581v6/pixels_512_linewidth_10_path_1_4a121c1e-8b86-4f23-a152-260189e8504d.png)

How many single-color paths go from A to C? Answer with a number in curly brackets e.g. {3}.

## Appendix 0.M VLM failures on real-world data

![Refer to caption](https://arxiv.org/html/2407.06581v6/images/realexamples/seoul_subway.jpg)

List out stations on a subway path.

![Refer to caption](https://arxiv.org/html/2407.06581v6/images/realexamples/music_sheet.jpg)

Reading music sheets

## Appendix 0.N Linear Probing Experiment for and tasks

### 0.N.1 Implementation details

We use identical hyperparameters for all probing experiments and provide their values in Tab. T18. We also provide the feature dimensions of each model in Tab. T19.

Table T18: The list of hyperparameters for training the linear classifier on frozen features of and in scikit-learn.

| Config | Value |
| --- | --- |
| Model | Logistic Regression |
| Regularization | L2 |
| Regularization Weight | 1.0 |
| Random seed | 42 |
| Training epochs | 1000 |

Table T19: LLaVA-OneV-S generates features with various dimensions for each input size. However, after the average pooling the frozen features for different image sizes have identical dimensions.

<table><tbody><tr><td>Model</td><td>Stage</td><td>input dim.</td><td>output dim.</td><td>after pooling</td></tr><tr><td rowspan="6"></td><td rowspan="3">vision encoder</td><td>384 <math><semantics><mo>×</mo> <annotation>\times</annotation></semantics></math> 385</td><td>[3, 729, 1152]</td><td rowspan="3">[1, 1152]</td></tr><tr><td>769 <math><semantics><mo>×</mo> <annotation>\times</annotation></semantics></math> 770</td><td>[10, 729, 1152]</td></tr><tr><td>1155 <math><semantics><mo>×</mo> <annotation>\times</annotation></semantics></math> 1155</td><td>[17, 729, 1152]</td></tr><tr><td rowspan="3">projection layer</td><td>384 <math><semantics><mo>×</mo> <annotation>\times</annotation></semantics></math> 385</td><td>[3, 729, 896]</td><td rowspan="3">[1, 896]</td></tr><tr><td>769 <math><semantics><mo>×</mo> <annotation>\times</annotation></semantics></math> 770</td><td>[10, 729, 896]</td></tr><tr><td>1155 <math><semantics><mo>×</mo> <annotation>\times</annotation></semantics></math> 1155</td><td>[17, 729, 896]</td></tr><tr><td rowspan="6"></td><td rowspan="3">vision encoder</td><td>384 <math><semantics><mo>×</mo> <annotation>\times</annotation></semantics></math> 384</td><td rowspan="3">[1, 5, 576, 1024]</td><td rowspan="3">[1, 1024]</td></tr><tr><td>768 <math><semantics><mo>×</mo> <annotation>\times</annotation></semantics></math> 768</td></tr><tr><td>1152 <math><semantics><mo>×</mo> <annotation>\times</annotation></semantics></math> 1152</td></tr><tr><td rowspan="3">projection layer</td><td>384 <math><semantics><mo>×</mo> <annotation>\times</annotation></semantics></math> 384</td><td rowspan="3">[757, 3072]</td><td rowspan="3">[1, 3072]</td></tr><tr><td>768 <math><semantics><mo>×</mo> <annotation>\times</annotation></semantics></math> 768</td></tr><tr><td>1152 <math><semantics><mo>×</mo> <annotation>\times</annotation></semantics></math> 1152</td></tr></tbody></table>

### 0.N.2 Additional results

The linear classifier, *i.e*., logistic regression, performs with 99% accuracy on the two circles (Fig. F48) and the line charts tasks (Fig. F49), when trained and tested on the images with the same visual complexities (Figs. F48 and F49; diagonal axis highlighted with black outline).

Moreover, transferring the classifier trained in small to large gaps shows an accuracy comparable to the baseline accuracy of these VLMs, suggesting the sufficiency of frozen features for solving the selected tasks from BlindTest.

![Refer to caption](https://arxiv.org/html/2407.06581v6/phi_circle_before_LC.png)

Figure F48: The linear classifier trained on frozen features of images, where objects ( ) are close ( d i s t a n c e ∈ { − 0.05, } distance\\in\\{-0.05,0.05\\} ), performs well (100%) on images that contain objects that are far apart ( 0.25 distance\\in\\{-0.25,0.25\\} ), for both models and stages. Conversely, the classifier performs worse (at least 18%), when transferred from large to small distances.

![Refer to caption](https://arxiv.org/html/2407.06581v6/phi_lines_before_LC.png)

Figure F49: The frozen features of both the projection layer and the VE output contain sufficient information to count the intersections between the line charts. Moreover, the mean distance between the y coordinates of line charts controls the visual complexity of the images, where transferring the trained classifier from small ( \[ 1, 3 ) \[1,3) ) to large ( 9 11 \[9,11) ) distances, compared to transfer from large to small distances, has lower impacts on the classification performance (24% vs. 39%; the first and last row in the top-right heatmap).

[^1]: Abdin, M., Jacobs, S.A., Awan, A.A., Aneja, J., Awadallah, A., Awadalla, H., Bach, N., Bahree, A., Bakhtiari, A., Behl, H., et al.: Phi-3 technical report: A highly capable language model locally on your phone. arXiv preprint arXiv:2404.14219 (2024)

[^2]: Anthropic: Introducing claude 3.5 sonnet \\ anthropic. [https://www.anthropic.com/news/claude-3-5-sonnet](https://www.anthropic.com/news/claude-3-5-sonnet), (Accessed on 07/03/2024)

[^3]: Anthropic: Introducing the next generation of claude \\ anthropic. [https://www.anthropic.com/news/claude-3-family](https://www.anthropic.com/news/claude-3-family), (Accessed on 07/23/2024)

[^4]: Anthropic, A.: The claude 3 model family: Opus, sonnet, haiku. Claude-3 Model Card (2024)

[^5]: Bailey, I.L., Lovie-Kitchin, J.E.: Visual acuity testing. from the laboratory to the clinic. Vision research 90, 2–9 (2013)

[^6]: Chen, L., Li, J., Dong, X., Zhang, P., Zang, Y., Chen, Z., Duan, H., Wang, J., Qiao, Y., Lin, D., et al.: Are we on the right way for evaluating large vision-language models? arXiv preprint arXiv:2403.20330 (2024)

[^7]: Chen, Z., Wu, J., Wang, W., Su, W., Chen, G., Xing, S., Zhong, M., Zhang, Q., Zhu, X., Lu, L., Li, B., Luo, P., Lu, T., Qiao, Y., Dai, J.: Internvl: Scaling up vision foundation models and aligning for generic visual-linguistic tasks. arXiv preprint arXiv:2312.14238 (2023)

[^8]: Chollet, F.: On the measure of intelligence. arXiv preprint arXiv:1911.01547 (2019)

[^9]: Custer, G.: Gemini spatial example. [https://gemini-spatial-example.grantcuster.com/](https://gemini-spatial-example.grantcuster.com/), (Accessed on 05/31/2024)

[^10]: Dai, W., Li, J., Li, D., Tiong, A.M.H., Zhao, J., Wang, W., Li, B., Fung, P., Hoi, S.: Instructblip: Towards general-purpose vision-language models with instruction tuning (2023)

[^11]: Gou, C., Felemban, A., Khan, F.F., Zhu, D., Cai, J., Rezatofighi, H., Elhoseiny, M.: How well can vision language models see image details? arXiv preprint arXiv:2408.03940 (2024)

[^12]: He, M., Liu, Y., Wu, B., Yuan, J., Wang, Y., Huang, T., Zhao, B.: Efficient multimodal learning from data-centric perspective. arXiv preprint arXiv:2402.11530 (2024)

[^13]: Hegde, N., Paul, S., Madan, G., Aggarwal, G.: Analyzing the efficacy of an llm-only approach for image-based document question answering. arXiv preprint arXiv:2309.14389 (2023)

[^14]: Hughes, J.F.: Computer graphics: principles and practice. Pearson Education (2014)

[^15]: Inc., C.Z.V.: Vision screening. [https://www.zeiss.com/vision-care/us/eye-health-and-care/vision-screening.html](https://www.zeiss.com/vision-care/us/eye-health-and-care/vision-screening.html), (Accessed on 07/03/2024)

[^16]: Jaech, A., Kalai, A., Lerer, A., Richardson, A., El-Kishky, A., Low, A., Helyar, A., Madry, A., Beutel, A., Carney, A., et al.: Openai o1 system card. arXiv preprint arXiv:2412.16720 (2024)

[^17]: Kahneman, D.: Thinking, fast and slow. macmillan (2011)

[^18]: Kembhavi, A., Salvato, M., Kolve, E., Seo, M., Hajishirzi, H., Farhadi, A.: A diagram is worth a dozen images. In: Computer Vision–ECCV 2016: 14th European Conference, Amsterdam, The Netherlands, October 11–14, 2016, Proceedings, Part IV 14. pp. 235–251. Springer (2016)

[^19]: yunxin li, Hu, B., Shi, H., Wang, W., Wang, L., Zhang, M.: Visiongraph: Leveraging large multimodal models for graph theory problems in visual context. In: Forty-first International Conference on Machine Learning (2024), [https://openreview.net/forum?id=gjoUXwuZdy](https://openreview.net/forum?id=gjoUXwuZdy)

[^20]: Li, B., Zhang, Y., Guo, D., Zhang, R., Li, F., Zhang, H., Zhang, K., Li, Y., Liu, Z., Li, C.: Llava-onevision: Easy visual task transfer. arXiv preprint arXiv:2408.03326 (2024)

[^21]: Liang, Z., Guo, K., Liu, G., Guo, T., Zhou, Y., Yang, T., Jiao, J., Pi, R., Zhang, J., Zhang, X.: Scemqa: A scientific college entrance level multimodal question answering benchmark. arXiv preprint arXiv:2402.05138 (2024)

[^22]: Liu, H., Li, C., Li, Y., Lee, Y.J.: Improved baselines with visual instruction tuning (2023)

[^23]: Liu, H., Li, C., Li, Y., Li, B., Zhang, Y., Shen, S., Lee, Y.J.: Llava-next: Improved reasoning, ocr, and world knowledge (January 2024), [https://llava-vl.github.io/blog/2024-01-30-llava-next/](https://llava-vl.github.io/blog/2024-01-30-llava-next/)

[^24]: Liu, H., Li, C., Wu, Q., Lee, Y.J.: Visual instruction tuning. arXiv preprint arXiv:2304.08485 (2023)

[^25]: Liu, H., Li, C., Wu, Q., Lee, Y.J.: Visual instruction tuning. Advances in neural information processing systems 36 (2024)

[^26]: Liu, Y., Duan, H., Zhang, Y., Li, B., Zhang, S., Zhao, W., Yuan, Y., Wang, J., He, C., Liu, Z., et al.: Mmbench: Is your multi-modal model an all-around player? arXiv preprint arXiv:2307.06281 (2023)

[^27]: Lu, P., Bansal, H., Xia, T., Liu, J., Li, C., Hajishirzi, H., Cheng, H., Chang, K.W., Galley, M., Gao, J.: Mathvista: Evaluating mathematical reasoning of foundation models in visual contexts. In: International Conference on Learning Representations (ICLR) (2024)

[^28]: Mangalam, K., Akshulakov, R., Malik, J.: Egoschema: A diagnostic benchmark for very long-form video language understanding. Advances in Neural Information Processing Systems 36 (2024)

[^29]: Mäntyjärvi, M., Laitinen, T.: Normal values for the pelli-robson contrast sensitivity test. Journal of Cataract & Refractive Surgery 27(2), 261–266 (2001)

[^30]: Masry, A., Do, X.L., Tan, J.Q., Joty, S., Hoque, E.: ChartQA: A benchmark for question answering about charts with visual and logical reasoning. In: Muresan, S., Nakov, P., Villavicencio, A. (eds.) Findings of the Association for Computational Linguistics: ACL 2022. pp. 2263–2279. Association for Computational Linguistics, Dublin, Ireland (May 2022). https://doi.org/10.18653/v1/2022.findings-acl.177, [https://aclanthology.org/2022.findings-acl.177](https://aclanthology.org/2022.findings-acl.177)

[^31]: Mathew, M., Karatzas, D., Jawahar, C.: Docvqa: A dataset for vqa on document images. In: Proceedings of the IEEE/CVF winter conference on applications of computer vision. pp. 2200–2209 (2021)

[^32]: McGuinness, P.: Gpt-4 system prompt revealed - by patrick mcguinness. [https://patmcguinness.substack.com/p/gpt-4-system-prompt-revealed](https://patmcguinness.substack.com/p/gpt-4-system-prompt-revealed), (Accessed on 06/06/2024)

[^33]: McKinzie, B., Gan, Z., Fauconnier, J.P., Dodge, S., Zhang, B., Dufter, P., Shah, D., Du, X., Peng, F., Weers, F., Belyi, A., Zhang, H., Singh, K., Kang, D., Jain, A., He, H., Schwarzer, M., Gunter, T., Kong, X., Zhang, A., Wang, J., Wang, C., Du, N., Lei, T., Wiseman, S., Yin, G., Lee, M., Wang, Z., Pang, R., Grasch, P., Toshev, A., Yang, Y.: Mm1: Methods, analysis & insights from multimodal llm pre-training. ArXiv abs/2403.09611 (2024), [https://api.semanticscholar.org/CorpusID:268384865](https://api.semanticscholar.org/CorpusID:268384865)

[^34]: Mirza, M.J., Karlinsky, L., Lin, W., Doveh, S., Micorek, J., Kozinski, M., Kuhene, H., Possegger, H.: Meta-prompting for automating zero-shot visual recognition with llms. arXiv preprint arXiv:2403.11755 (2024)

[^35]: Mirza, M.J., Karlinsky, L., Lin, W., Doveh, S., Micorek, J., Kozinski, M., Kuhene, H., Possegger, H.: Meta-prompting for automating zero-shot visual recognition with llms. arXiv preprint arXiv:2403.11755 (2024)

[^36]: Mitchell, M., Palmarini, A.B., Moskvichev, A.K.: Comparing humans, GPT-4, and GPT-4v on abstraction and reasoning tasks. In: AAAI 2024 Workshop on ”Are Large Language Models Simply Causal Parrots?” (2023), [https://openreview.net/forum?id=3rGT5OkzpC](https://openreview.net/forum?id=3rGT5OkzpC)

[^37]: Olya.by@mail.ru: How many counting game with color simple geometric shapes for kids, educational maths task for the development of logical thinking, preschool worksheet activity, count and write the result, vector stock vector by ©olya.by@mail.ru 266096226. [https://depositphotos.com/vector/how-many-counting-game-with-color-simple-geometric-shapes-for-kids-educational-maths-task-for-266096226.html](https://depositphotos.com/vector/how-many-counting-game-with-color-simple-geometric-shapes-for-kids-educational-maths-task-for-266096226.html), (Accessed on 07/05/2024)

[^38]: OpenAI: Hello gpt-4o | openai. [https://openai.com/index/hello-gpt-4o/](https://openai.com/index/hello-gpt-4o/), (Accessed on 05/31/2024)

[^39]: OpenAI: Gpt-4 technical report (2023)

[^40]: Ouyang, L., Wu, J., Jiang, X., Almeida, D., Wainwright, C., Mishkin, P., Zhang, C., Agarwal, S., Slama, K., Ray, A., et al.: Training language models to follow instructions with human feedback. Advances in neural information processing systems 35, 27730–27744 (2022)

[^41]: Radford, A., Kim, J.W., Hallacy, C., Ramesh, A., Goh, G., Agarwal, S., Sastry, G., Askell, A., Mishkin, P., Clark, J., Krueger, G., Sutskever, I.: Learning transferable visual models from natural language supervision (2021)

[^42]: Rasheed, H., Maaz, M., Shaji, S., Shaker, A., Khan, S., Cholakkal, H., Anwer, R.M., Xing, E., Yang, M.H., Khan, F.S.: Glamm: Pixel grounding large multimodal model. The IEEE/CVF Conference on Computer Vision and Pattern Recognition (2024)

[^43]: Reid, M., Savinov, N., Teplyashin, D., Lepikhin, D., Lillicrap, T., Alayrac, J.b., Soricut, R., Lazaridou, A., Firat, O., Schrittwieser, J., et al.: Gemini 1.5: Unlocking multimodal understanding across millions of tokens of context. arXiv preprint arXiv:2403.05530 (2024)

[^44]: Shtedritski, A., Rupprecht, C., Vedaldi, A.: What does clip know about a red circle? visual prompt engineering for vlms. In: 2023 IEEE/CVF International Conference on Computer Vision (ICCV). pp. 11953–11963. IEEE Computer Society, Los Alamitos, CA, USA (oct 2023). https://doi.org/10.1109/ICCV51070.2023.01101, [https://doi.ieeecomputersociety.org/10.1109/ICCV51070.2023.01101](https://doi.ieeecomputersociety.org/10.1109/ICCV51070.2023.01101)

[^45]: Station, M.T.: Count shapes printables | myteachingstation.com. [https://www.myteachingstation.com/preschool/math/numbers/count-shapes-printables](https://www.myteachingstation.com/preschool/math/numbers/count-shapes-printables), (Accessed on 07/05/2024)

[^46]: Taesiri, M.R., Feng, T., Bezemer, C.P., Nguyen, A.: Glitchbench: Can large multimodal models detect video game glitches? In: Proceedings of the IEEE/CVF Conference on Computer Vision and Pattern Recognition. pp. 22444–22455 (2024)

[^47]: Team, C.: Chameleon: Mixed-modal early-fusion foundation models. arXiv preprint arXiv:2405.09818 (2024)

[^48]: Team, Q.: Qvq: To see the world with wisdom (December 2024), [https://qwenlm.github.io/blog/qvq-72b-preview/](https://qwenlm.github.io/blog/qvq-72b-preview/)

[^49]: Tong, S., Liu, Z., Zhai, Y., Ma, Y., LeCun, Y., Xie, S.: Eyes wide shut? exploring the visual shortcomings of multimodal llms. In: Proceedings of the IEEE/CVF Conference on Computer Vision and Pattern Recognition (CVPR). pp. 9568–9578 (June 2024)

[^50]: Wang, K., Pan, J., Shi, W., Lu, Z., Zhan, M., Li, H.: Measuring multimodal mathematical reasoning with math-vision dataset (2024)

[^51]: Wang, P., Bai, S., Tan, S., Wang, S., Fan, Z., Bai, J., Chen, K., Liu, X., Wang, J., Ge, W., Fan, Y., Dang, K., Du, M., Ren, X., Men, R., Liu, D., Zhou, C., Zhou, J., Lin, J.: Qwen2-vl: Enhancing vision-language model’s perception of the world at any resolution. arXiv preprint arXiv:2409.12191 (2024)

[^52]: Wei, J., Wang, X., Schuurmans, D., Bosma, M., Xia, F., Chi, E., Le, Q.V., Zhou, D., et al.: Chain-of-thought prompting elicits reasoning in large language models. Advances in Neural Information Processing Systems 35, 24824–24837 (2022)

[^53]: Yang, J., Zhang, H., Li, F., Zou, X., Li, C., Gao, J.: Set-of-mark prompting unleashes extraordinary visual grounding in gpt-4v (2023), [https://arxiv.org/abs/2310.11441](https://arxiv.org/abs/2310.11441)

[^54]: Yang, Z., Li, L., Lin, K., Wang, J., Lin, C., Liu, Z., Wang, L.: The dawn of lmms: Preliminary explorations with gpt-4v(ision). CoRR abs/2309.17421 (2023). https://doi.org/10.48550/ARXIV.2309.17421, [https://doi.org/10.48550/arXiv.2309.17421](https://doi.org/10.48550/arXiv.2309.17421)

[^55]: Yu, W., Yang, Z., Li, L., Wang, J., Lin, K., Liu, Z., Wang, X., Wang, L.: Mm-vet: Evaluating large multimodal models for integrated capabilities. In: International conference on machine learning. PMLR (2024)

[^56]: Yu, Z., Xu, D., Yu, J., Yu, T., Zhao, Z., Zhuang, Y., Tao, D.: Activitynet-qa: a dataset for understanding complex web videos via question answering. In: Proceedings of the Thirty-Third AAAI Conference on Artificial Intelligence and Thirty-First Innovative Applications of Artificial Intelligence Conference and Ninth AAAI Symposium on Educational Advances in Artificial Intelligence. pp. 9127–9134 (2019)

[^57]: Yue, X., Ni, Y., Zhang, K., Zheng, T., Liu, R., Zhang, G., Stevens, S., Jiang, D., Ren, W., Sun, Y., Wei, C., Yu, B., Yuan, R., Sun, R., Yin, M., Zheng, B., Yang, Z., Liu, Y., Huang, W., Sun, H., Su, Y., Chen, W.: Mmmu: A massive multi-discipline multimodal understanding and reasoning benchmark for expert agi. In: Proceedings of CVPR (2024)

[^58]: Zellers, R., Bisk, Y., Farhadi, A., Choi, Y.: From recognition to cognition: Visual commonsense reasoning. In: Proceedings of the IEEE/CVF conference on computer vision and pattern recognition. pp. 6720–6731 (2019)

[^59]: Zhai, X., Mustafa, B., Kolesnikov, A., Beyer, L.: Sigmoid loss for language image pre-training. In: Proceedings of the IEEE/CVF International Conference on Computer Vision. pp. 11975–11986 (2023)