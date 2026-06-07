# File: min-cost-climbing-stairs/solution.py

**Date:** 2026-06-06
**Time:** 17:50

## `min-cost-climbing-stairs/solution.py`

### Purpose

This file solves [LeetCode 746 — Min Cost Climbing Stairs](https://leetcode.com/problems/min-cost-climbing-stairs/). It computes the minimum cost to reach the top of a staircase where each step has an associated cost and you can climb one or two steps at a time, starting from either step 0 or step 1.

### Key Components

**`Solution.minCostClimbingStairs(cost: List[int]) -> int`** — The single method. Takes a cost array (length >= 2) and returns the minimum total cost to reach past the last step.

### Patterns

**Space-optimized bottom-up DP.** The classic DP formulation for this problem uses an array `dp[i] = cost[i] + min(dp[i-1], dp[i-2])`, representing the minimum cost to reach step `i` and pay its toll. This solution compresses that array into two rolling variables:

- `prev2` tracks `dp[i-2]`
- `prev1` tracks `dp[i-1]`

After the loop, `min(prev1, prev2)` gives the answer because you can reach the top (one past the last index) from either of the last two steps.

This is the same rolling-variable idiom used in `climbing-stairs/solution.py` for the Fibonacci-like stair counting problem — the two are structurally related.

### Dependencies

**Imports:** `List` from `typing` — used only for the type annotation.

**Imported by:** `min-cost-climbing-stairs/test_solution.py` directly. The long "Imported By" list in the prompt is an artifact of the shared `Solution` class name across the repo — those test files import their own local `solution.py`, not this one.

### Flow

1. Initialize `prev2 = cost[0]`, `prev1 = cost[1]` — base cases for the first two steps.
2. For each step `i` from 2 to `len(cost) - 1`:
   - Compute the new `prev1` as `cost[i] + min(prev1, prev2)` — cheapest way to arrive at step `i`.
   - Shift `prev2` to the old `prev1` via tuple unpacking.
3. Return `min(prev1, prev2)` — you can step over the top from either of the last two positions.

### Invariants

- **Input constraint:** `len(cost) >= 2` is assumed (matches the LeetCode guarantee). No guard for shorter inputs.
- **Loop invariant:** After processing index `i`, `prev1 == dp[i]` and `prev2 == dp[i-1]`.
- **Non-negative costs:** The problem guarantees `0 <= cost[i] <= 999`, so `min` comparisons are well-defined and the result is non-negative.

### Error Handling

None. The method trusts the caller to provide a valid input per the LeetCode contract. An empty or single-element list would raise an `IndexError` on the base-case initialization.

---

## Topics to Explore

- [file] `climbing-stairs/solution.py` — The closely related problem (count distinct ways vs. minimize cost) likely uses the same rolling-variable DP pattern
- [file] `min-cost-climbing-stairs/test_solution.py` — See which edge cases are tested (two-element input, uniform costs, increasing/decreasing costs)
- [file] `min-cost-climbing-stairs/plan.md` — The planning doc may describe alternative approaches considered (full DP array, recursion with memoization)
- [general] `space-optimized-dp` — This O(1)-space technique recurs across DP problems in this repo (Fibonacci, house robber, etc.)

## Beliefs

- `min-cost-dp-uses-constant-space` — The solution uses O(1) auxiliary space via two rolling variables instead of an O(n) DP array
- `min-cost-final-answer-is-min-of-last-two` — The final `min(prev1, prev2)` is necessary because you can reach the top from either of the last two steps
- `min-cost-assumes-length-ge-2` — The code will raise `IndexError` if `cost` has fewer than 2 elements; it relies on the LeetCode constraint for safety
- `min-cost-loop-invariant` — After iteration `i`, `prev1` holds the minimum cost to reach and pay step `i`, and `prev2` holds the same for step `i-1`

