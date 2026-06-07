# File: pascals-triangle/solution.py

**Date:** 2026-06-06
**Time:** 18:29

## Purpose

This file implements [LeetCode 118 — Pascal's Triangle](https://leetcode.com/problems/pascals-triangle/). It owns exactly one responsibility: given a row count `numRows`, produce the first `numRows` rows of Pascal's triangle as a list of lists. It's a standalone solution module following the repo's convention of one problem per directory with `solution.py`, `test_solution.py`, `plan.md`, and `review.md`.

## Key Components

### `generate(numRows: int) -> list[list[int]]`

The sole public function. Contract:

- **Input**: integer `numRows` in range `[1, 30]` (per LeetCode constraints — not validated in code).
- **Output**: a list of `numRows` lists, where row `i` (0-indexed) has `i + 1` elements representing the `i`-th row of Pascal's triangle.
- **Pure function** — no side effects, no mutation of inputs.

## Patterns

**Iterative bottom-up construction.** Rather than using recursion or a math formula (`C(n, k)`), the solution builds each row from the previous one. This is the classic DP-style approach for Pascal's triangle:

1. Initialize each row as all 1s (correct for the boundary elements).
2. Overwrite the interior elements by summing adjacent elements from the prior row.

This avoids factorial computation and keeps the logic O(numRows^2) in both time and space — which matches the output size, so it's optimal.

**Pre-fill then patch.** The idiom `row = [1] * (i + 1)` sets both boundary values (first and last) to 1 upfront. The inner loop `for j in range(1, i)` only touches interior positions. When `i < 2`, `range(1, i)` is empty, so rows 0 and 1 (`[1]` and `[1, 1]`) are produced correctly without special-casing.

## Dependencies

**Imports**: None. The function uses only built-in Python types and operations.

**Imported by**: The corresponding `pascals-triangle/test_solution.py` imports `generate` for testing. The massive "Imported By" list in the prompt is misleading — those are unrelated test files that happen to share a common test harness pattern, not actual importers of this module's `generate` function.

## Flow

```
generate(5)
  i=0: row = [1]                          → triangle = [[1]]
  i=1: row = [1, 1]    (inner loop empty) → triangle = [[1], [1,1]]
  i=2: row = [1, 1, 1] → row[1] = 1+1=2  → triangle = [[1], [1,1], [1,2,1]]
  i=3: row = [1,1,1,1] → row[1]=1+2=3, row[2]=2+1=3
                                           → [..., [1,3,3,1]]
  i=4: row = [1,1,1,1,1] → row[1]=1+3=4, row[2]=3+3=6, row[3]=3+1=4
                                           → [..., [1,4,6,4,1]]
```

Each row reads from `triangle[i-1]` (the already-appended previous row) at positions `j-1` and `j`, producing the standard Pascal's identity: `C(n,k) = C(n-1,k-1) + C(n-1,k)`.

## Invariants

- Every row `i` has exactly `i + 1` elements.
- `row[0]` and `row[i]` are always 1 (boundary condition, enforced by pre-fill).
- The inner loop index `j` in `range(1, i)` guarantees `j-1 >= 0` and `j <= i-1`, so `triangle[i-1][j-1]` and `triangle[i-1][j]` are always valid lookups — no bounds checking needed.
- `triangle` grows by exactly one row per iteration, so `triangle[i-1]` is always the most recently appended row.

## Error Handling

None. The function trusts its caller to pass a valid `numRows >= 1`. Passing 0 returns `[]` (the loop doesn't execute). Passing a negative value also returns `[]`. No exceptions are raised or caught.

## Topics to Explore

- [file] `pascals-triangle-ii/solution.py` — The follow-up problem that returns only the k-th row, likely using O(k) space instead of O(n^2)
- [file] `pascals-triangle/test_solution.py` — See which edge cases and row counts are tested
- [file] `pascals-triangle/plan.md` — The planning document that preceded this implementation
- [general] `iterative-vs-combinatorial-pascals` — Compare this DP approach to direct binomial coefficient computation `C(n,k) = n! / (k!(n-k)!)` for trade-offs in precision and speed
- [function] `climbing-stairs/solution.py:climbStairs` — Another bottom-up DP solution in the repo that follows the same "build from previous" pattern

## Beliefs

- `pascal-generate-pure` — `generate` is a pure function with no side effects, no imports, and no mutation of external state
- `pascal-boundary-by-prefill` — Boundary values (first and last element of each row = 1) are set by pre-filling with `[1] * (i + 1)`, not by conditional logic
- `pascal-inner-loop-safe` — The inner loop `range(1, i)` guarantees all `triangle[i-1]` lookups are in-bounds without explicit bounds checking
- `pascal-zero-rows-returns-empty` — Calling `generate(0)` returns `[]` since the outer loop range is empty, even though this is outside the stated LeetCode constraints

