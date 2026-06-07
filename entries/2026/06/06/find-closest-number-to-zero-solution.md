# File: find-closest-number-to-zero/solution.py

**Date:** 2026-06-06
**Time:** 16:36

## `find-closest-number-to-zero/solution.py`

### Purpose

This file solves [LeetCode 2239 — Find Closest Number to Zero](https://leetcode.com/problems/find-closest-number-to-zero/). It's one of hundreds of standardized solution modules in the `leetcode-implementations` repo, each owning a single problem's algorithm.

### Key Components

**`robot_instructions(nums: list[int]) -> int`** — The sole public function. Despite the misleading name (should be something like `findClosestNumber`), it implements the correct algorithm: find the element in `nums` with the smallest absolute value, breaking ties by preferring the positive number.

The contract:
- **Input**: A non-empty list of integers.
- **Output**: The integer closest to zero. If two numbers are equidistant (e.g., `-2` and `2`), return the positive one.

### Patterns

**Linear scan with running best.** The function initializes `best` to `nums[0]`, then iterates through the rest. The update condition on line 14 is a two-part predicate:

1. `abs(num) < abs(best)` — strictly closer to zero, or
2. `abs(num) == abs(best) and num > best` — same distance but larger value (i.e., positive wins over negative)

This is the standard "argmin with tiebreaker" idiom. No sorting, no extra data structures — O(n) time, O(1) space.

### Dependencies

**Imports**: None. Pure standalone function.

**Imported by**: The "Imported By" list is misleading — it shows ~400+ test files, which means this function name (`robot_instructions`) is the shared export convention across *all* solution modules, not that these tests actually test this specific solution. The real consumer is `find-closest-number-to-zero/test_solution.py`.

### Flow

1. Seed `best` with the first element.
2. For each remaining element, check if it's strictly closer to zero, or tied but positive.
3. Return `best` after a single pass.

### Invariants

- **Non-empty input assumed.** `nums[0]` is accessed unconditionally — an empty list raises `IndexError`.
- **Positive tiebreaker.** The `num > best` clause guarantees that between `-k` and `k`, the function returns `k`.
- **Stability toward first occurrence.** If two candidates have identical value (not just absolute value), the first one wins because the condition uses strict `>`, not `>=`.

### Error Handling

None. The function trusts its caller to provide a non-empty list of integers, consistent with LeetCode's guarantees. An empty list would crash at `nums[0]`.

---

## Topics to Explore

- [file] `find-closest-number-to-zero/test_solution.py` — See the test cases to understand edge cases the solution handles (single element, all negatives, symmetric pairs)
- [file] `find-closest-number-to-zero/review.md` — Contains the code review with algorithmic analysis and potential issues like the wrong function name
- [general] `function-naming-convention` — The function is named `robot_instructions` rather than matching the problem; investigate whether this is a repo-wide bug from code generation or an intentional shared entry point name
- [file] `find-closest-number-to-zero/plan.md` — The plan document that preceded implementation, showing the design rationale

## Beliefs

- `closest-to-zero-positive-tiebreak` — When two numbers have equal absolute value, `robot_instructions` always returns the positive one due to the `num > best` guard
- `closest-to-zero-linear-time` — The algorithm runs in O(n) time with O(1) extra space via a single pass over the input
- `closest-to-zero-wrong-function-name` — The exported function is named `robot_instructions` instead of a name matching the problem (e.g., `findClosestNumber`), suggesting a code-generation naming bug shared across the repo
- `closest-to-zero-no-empty-guard` — The function will raise `IndexError` on an empty list; it relies on the LeetCode constraint that `nums` is non-empty

