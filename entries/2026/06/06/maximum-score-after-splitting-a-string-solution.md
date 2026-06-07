# File: maximum-score-after-splitting-a-string/solution.py

**Date:** 2026-06-06
**Time:** 17:44

## `maximum-score-after-splitting-a-string/solution.py`

### Purpose

This file implements the solution for [LeetCode 1422: Maximum Score After Splitting a String](https://leetcode.com/problems/maximum-score-after-splitting-a-string/). It owns a single responsibility: given a binary string, find the split point that maximizes the sum of zeros in the left part plus ones in the right part.

### Key Components

**`max_score_after_splitting(s: str) -> int`** — The sole public function. Takes a string of `'0'`/`'1'` characters (length >= 2) and returns the maximum score across all valid split positions, where score = count of `'0'` in left substring + count of `'1'` in right substring.

### Patterns

**Sliding partition with running counters.** Rather than slicing the string at each position and counting (which would be O(n^2)), this uses a single-pass O(n) approach:

1. Pre-compute the total count of `'1'`s in the entire string — this starts as the right-side ones count.
2. Sweep a partition point left-to-right. At each step, the current character moves from the right partition to the left:
   - If it's `'0'`, `zeros_left` increases (good for the left score).
   - If it's `'1'`, `ones_right` decreases (it's no longer on the right side).
3. Track the running maximum of `zeros_left + ones_right`.

This is a standard technique for partition-optimization problems: maintain two complementary accumulators and slide the boundary.

### Dependencies

**Imports:** None — pure stdlib, no external dependencies.

**Imported by:** The `test_solution.py` in the same directory. The large "Imported By" list in the prompt is an artifact of the test runner infrastructure — those other test files don't actually import *this* solution; they share the same test harness pattern.

### Flow

```
s = "011101"

Step 0: ones_right = 4, zeros_left = 0
  i=0: s[0]='0' → zeros_left=1, ones_right=4 → score=5
  i=1: s[1]='1' → zeros_left=1, ones_right=3 → score=4
  i=2: s[2]='1' → zeros_left=1, ones_right=2 → score=3
  i=3: s[3]='1' → zeros_left=1, ones_right=1 → score=2
  i=4: s[4]='0' → zeros_left=2, ones_right=1 → score=3

max_score = 5 (split after index 0: left="0", right="11101")
```

### Invariants

- **Both partitions must be non-empty**: the loop runs `range(len(s) - 1)`, stopping before the last character. This ensures the right partition always has at least one character, and since `i` starts at 0, the left partition always has at least one character after the first iteration.
- **`zeros_left + ones_right + ones_left + zeros_right == len(s)`** at every step (conservation — all characters are accounted for, though `ones_left` and `zeros_right` aren't tracked since they don't contribute to the score).
- **`max_score` is monotonically non-decreasing** through the loop — it only updates via `max()`.

### Error Handling

None. The function trusts its caller to pass a valid binary string of length >= 2 (matching the LeetCode contract). No validation, no exceptions. This is appropriate for a competitive-programming solution where inputs are guaranteed by the problem constraints.

## Topics to Explore

- [file] `maximum-score-after-splitting-a-string/test_solution.py` — See what edge cases are covered (single zeros/ones, all-same strings, length-2 inputs)
- [file] `maximum-score-after-splitting-a-string/plan.md` — The pre-implementation reasoning and approach selection
- [function] `best-time-to-buy-and-sell-stock/solution.py:maxProfit` — Another single-pass partition-style optimization over an array, useful for comparing the pattern
- [general] `sliding-partition-pattern` — How other problems in this repo use the "precompute total, then slide a boundary" technique (e.g., `find-pivot-index`, `minimum-value-to-get-positive-step-by-step-sum`)

## Beliefs

- `single-pass-o-n-complexity` — `max_score_after_splitting` runs in O(n) time and O(1) space by maintaining two running counters instead of slicing
- `non-empty-partition-guarantee` — The loop bound `range(len(s) - 1)` enforces that both left and right substrings are always non-empty at every split point evaluated
- `no-input-validation` — The function performs no validation on input; it assumes a binary string of length >= 2 per the LeetCode contract
- `precompute-then-transfer-idiom` — The right-side count is initialized to the full-string count of `'1'`, then elements are "transferred" to the left side as the partition sweeps right

