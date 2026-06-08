# Iterative Review Exposes Latent Knowledge in LLMs

**Date:** 2026-06-07
**Source:** Observations from two expert agent pipelines — 510 LeetCode solutions and 37 DDIA reference implementations

---

## The Core Finding

AI coding agents don't get it right the first time. Not because they lack the knowledge, but because a single generation pass samples only one trajectory through the model's knowledge space. The same model that generates a bug during coding can identify that bug during review — if you ask it the right question from the right angle.

This was demonstrated independently across two domains:

- **LeetCode (algorithmic):** 510 AI-generated solutions → 17 bugs found through belief network analysis
- **DDIA (distributed systems):** 37 AI-generated reference implementations → 30 bugs found across 3 rounds of analysis

In both cases, the bugs were not obscure. The model "knew" about every one of them. It knows `list.pop(0)` is O(n). It knows `n &= n - 1` loops forever on negative Python integers. It knows you need checksums during compaction, not just during writes. But it didn't apply that knowledge during generation.

## Why Single-Pass Generation Is Insufficient

During code generation, the model optimizes for "produce a working solution." This activates a specific subset of its knowledge — algorithmic patterns, API usage, the happy path. It produces code that is correct for the stated inputs and passes the stated tests.

During review, the model optimizes for "find everything wrong with this code." This activates a different subset — edge cases, performance pitfalls, naming conventions, defensive practices. It finds problems that the generator didn't consider because the generator wasn't looking for problems.

These are not different models. They are different sampling trajectories through the same model's distribution. The knowledge is there in both cases. What differs is which part of the knowledge gets activated by the prompt and context.

## The Evidence: Six Passes, Six Layers

The LeetCode pipeline made this visible. Each pass activated knowledge the previous one didn't:

1. **Generation** — AI produced 510 solutions. Optimized for correctness against LeetCode's judge. Solutions passed all tests.

2. **Explanation** (code-expert explain) — AI examined each solution and extracted observations. Found things the generator didn't flag: `binary_gap` loops forever on negative input, `pillowHolder(1, t)` divides by zero, 52 functions named after the wrong problem.

3. **Belief extraction** (propose-beliefs) — AI synthesized observations into patterns. Found cross-cutting themes: "solutions never validate input," "single-pass streaming is the dominant shape," "correctness comes from construction not validation." 1,641 beliefs accepted.

4. **Derivation** (derive) — AI built reasoning chains from beliefs. Combined premises into higher-order conclusions: "quality inversion between algorithmic and engineering quality," "convergence without coordination driven by domain constraints." 113 derived beliefs across 8 depth levels.

5. **Review** (review-beliefs) — AI evaluated its own derivations adversarially. Found 28 invalid (conclusions don't follow from premises), 29 insufficient (overgeneralize beyond evidence), 15 unnecessary (redundant). The reviewer caught errors the deriver made.

6. **Gated belief analysis** (list-gated) — The belief network identified 18 concrete code-level bugs that contradicted higher-level beliefs. These were real, fixable bugs — not theoretical concerns.

Each pass was performed by the same underlying model. Each surfaced knowledge that the previous passes didn't. The pipeline's value is not in any single pass but in the structured iteration.

## The Mechanism: Sampling Coverage

An LLM's knowledge is not a lookup table. It is a high-dimensional distribution over possible responses, shaped by training data. A single forward pass samples one point from this distribution. That sample is influenced by:

- **The prompt** — "write a solution" vs. "find bugs in this solution" activate different regions
- **The context** — seeing one solution vs. seeing 510 solutions and their patterns
- **The framing** — "is this correct?" vs. "what would a skeptic say about this derivation?"

Iteration works because each pass changes the prompt, context, and framing. The explain pass asks "what does this code do?" The propose pass asks "what patterns emerge across all explanations?" The derive pass asks "what follows from combining these patterns?" The review pass asks "does this conclusion actually follow from these premises?"

Each question activates different knowledge. The sum of all passes covers more of the model's knowledge space than any single pass could.

## The Implication: Review Is Not Optional

This has a direct practical consequence: review is not a quality-assurance step bolted onto the end of generation. It is the primary mechanism for extracting knowledge that generation leaves on the table.

A pipeline that generates code without iterative review is leaving most of the model's knowledge unused. The generator will produce code that works. The reviewer will find ways it fails. The deriver will find patterns across the failures. The adversarial reviewer will find where the patterns overreach. Each layer adds coverage.

This is why the derive-review-repair cycle exists as a loop, not a one-shot pipeline. Each round of repair changes the code, which changes what the next round of review can find. The process converges — each round finds fewer new issues — but the first round alone is never enough.

## The Parallel to Human Engineering

This property of LLMs mirrors a well-known property of human engineering: code review catches bugs that the author missed, even when the author and reviewer have the same skill level. The author was focused on making it work. The reviewer is focused on finding where it breaks. Same knowledge, different activation.

What the LLM case adds is scale and measurability. We can count exactly how many bugs each pass found (17 in the LeetCode case, 30 in the DDIA case). We can trace exactly which beliefs gated which conclusions. We can measure convergence across rounds. The mechanism is the same as human code review, but the belief network makes it auditable.

## For Builders of AI Coding Systems

If you are building systems that use LLMs to generate code:

- **Plan for multiple passes.** Single-pass generation is the minimum viable product, not the finished system. Budget for at least explain → propose → review cycles.
- **Vary the angle.** Each pass should ask a different question. Don't just re-run generation — explain, then synthesize, then derive, then challenge. Different framings activate different knowledge.
- **Make contradictions structural.** The gated belief mechanism — where concrete observations block general conclusions — turns "I think there might be a bug" into "this specific line contradicts this specific claim." Structural contradictions are actionable; vague suspicions are not.
- **Measure convergence.** Track how many new issues each round finds. When rounds stop finding new issues, the pipeline has covered the model's accessible knowledge for this domain. Until then, keep iterating.
- **The model has the knowledge.** If your pipeline isn't finding bugs, the problem is not the model — it's the pipeline. Change the angle, change the framing, change the context. The knowledge is in there. You just have to sample it.
