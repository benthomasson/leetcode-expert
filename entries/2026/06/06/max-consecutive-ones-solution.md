# File: max-consecutive-ones/solution.py

**Date:** 2026-06-06
**Time:** 17:32

## `max-consecutive-ones/solution.py`

### Purpose

This file implements the solution to **LeetCode 485 — Max Consecutive Ones**. It owns exactly one responsibility: given a binary array (only 0s and 1s), return the length of the longest contiguous run of 1s.

### Key Components

**`findMaxConsecutiveOnes(nums: list[int]) -> int`** — The sole public function. Takes a binary array, returns an integer. The naming follows LeetCode's camelCase convention rather than PEP 8, which is consistent across this repo.

### Patterns

**Single-pass streaming accumulator.** The function uses two variables — `max_streak` (global best) and `current` (current run length) — and makes exactly one pass over the input. This is the canonical pattern for "longest run of X" problems: increment a counter on match, reset on mismatch, track the maximum.

The `max_streak` update is done eagerly inside the `if n == 1` branch rather than at every iteration or after the loop. This avoids a redundant comparison on every 0-element and also avoids needing a final `max(max_streak, current)` after the loop — when the array ends with 1s, the update already happened on the last 1.

**No standard library usage.** The solution avoids `itertools.groupby`, `max()` with a generator, or other compact alternatives in favor of explicit state tracking. This is typical for LeetCode solutions optimizing for clarity about time/space complexity.

### Dependencies

**Imports:** None. This is a pure function with zero dependencies.

**Imported by:** The "Imported By" list is misleadingly large — those ~400+ test files likely share a common test harness that imports all solutions, not specific usage of this function. The direct consumer is `max-consecutive-ones/test_solution.py`.

### Flow

1. Initialize `max_streak = 0` and `current = 0`.
2. For each element `n` in `nums`:
   - If `n == 1`: increment `current`, update `max_streak` if `current` exceeds it.
   - Else: reset `current` to 0.
3. Return `max_streak`.

The key insight is that `max_streak` is only updated inside the `n == 1` branch. This works because the maximum can only increase when we see a 1, never when we see a 0.

### Invariants

- **Input contract:** `nums` must contain only 0s and 1s. The code doesn't validate this — it treats any non-1 value as a streak-breaker, so values like 2 would silently reset the counter.
- **Empty input:** Returns 0 for an empty list (the loop never executes, `max_streak` stays 0). This is correct.
- **Post-condition:** The return value equals `max(len(run) for run in consecutive_groups_of_ones)`, or 0 if no 1s exist.

### Error Handling

None. The function assumes valid input and will raise `TypeError` only if `nums` is not iterable. There's no explicit error handling, which is standard for LeetCode solutions.

### Complexity

- **Time:** O(n) — single pass.
- **Space:** O(1) — two integer variables regardless of input size.

---

## Topics to Explore

- [file] `max-consecutive-ones/test_solution.py` — See what edge cases the test suite covers (empty array, all 1s, all 0s, single element)
- [file] `longer-contiguous-segments-of-ones-than-zeros/solution.py` — A variation that compares longest 1-run vs longest 0-run, likely reuses this same accumulator pattern
- [file] `consecutive-characters/solution.py` — Generalized version of the same pattern applied to arbitrary character runs, not just binary
- [general] `streaming-accumulator-pattern` — How this single-pass pattern with reset-on-mismatch appears across multiple solutions in the repo (e.g., longest increasing subsequence, max subarray)

## Beliefs

- `max-consecutive-ones-single-pass` — `findMaxConsecutiveOnes` runs in O(n) time and O(1) space with exactly one pass over the input
- `max-consecutive-ones-eager-update` — The maximum is updated inside the `n == 1` branch only, eliminating the need for a post-loop `max()` call
- `max-consecutive-ones-zero-on-empty` — The function returns 0 for empty input and for arrays containing no 1s, without special-casing either
- `max-consecutive-ones-no-validation` — The function does not validate that elements are 0 or 1; any non-1 value acts as a streak terminator

