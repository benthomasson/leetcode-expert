# File: check-if-all-1s-are-at-least-length-k-places-away/solution.py

**Date:** 2026-06-06
**Time:** 15:35

## Purpose

This file implements the solution to [LeetCode 1437: Check If All 1's Are At Least Length K Places Away](https://leetcode.com/problems/check-if-all-1s-are-at-least-length-k-places-away/). It owns exactly one responsibility: given a binary array and an integer `k`, determine whether every pair of adjacent 1s has at least `k` zeros between them.

## Key Components

### `Solution.kLengthApart(nums, k) -> bool`

The single method on the class. Contract:

- **Input**: `nums` is a list of 0s and 1s; `k` is a non-negative integer representing the minimum gap required between any two 1s.
- **Output**: `True` if every pair of 1s in `nums` has at least `k` elements separating them, `False` otherwise.
- **Edge cases**: If there are zero or one 1s in the array, always returns `True` (no pair to violate the constraint).

## Patterns

**Sentinel-based last-seen tracking.** The variable `last` is initialized to `-1` as a sentinel meaning "no 1 encountered yet." The `if last != -1` guard on line 15 skips the distance check for the very first 1, since there's nothing to compare it against. This avoids a separate boolean flag or special first-iteration logic.

**Early exit on violation.** The method returns `False` the instant it finds a pair of 1s that are too close, avoiding unnecessary iteration over the rest of the array. The `True` return at line 17 is only reached if the entire array is scanned without a violation.

**Gap arithmetic.** The expression `i - last - 1` computes the number of elements *strictly between* positions `last` and `i`. For example, if 1s are at indices 2 and 5, the gap is `5 - 2 - 1 = 2` (indices 3 and 4). This is compared against `k`.

## Dependencies

- **Imports**: `List` from `typing` — used only for the type annotation on `nums`.
- **Imported by**: The corresponding `test_solution.py` in the same directory, plus (per the provided context) hundreds of other test files across the repo that appear to share a common test harness importing solution modules.

## Flow

1. Initialize `last = -1` (no 1 seen).
2. Iterate over `nums` with index and value via `enumerate`.
3. On encountering a `1`:
   - If a previous 1 exists (`last != -1`), compute the gap `i - last - 1`.
   - If the gap is less than `k`, return `False` immediately.
   - Update `last` to the current index `i`.
4. If the loop completes without returning `False`, return `True`.

Time complexity: O(n) single pass. Space complexity: O(1) — only the `last` variable is tracked.

## Invariants

- **`last` always holds the index of the most recently seen 1**, or `-1` if none has been seen. This is maintained by the unconditional `last = i` assignment inside the `if num == 1` block.
- **The gap check is between consecutive 1s only.** Because `last` is updated every time a 1 is found, the check always compares adjacent 1s — if consecutive pairs pass, all pairs pass (transitivity of minimum spacing).

## Error Handling

None. The method assumes valid input per the LeetCode contract (binary array, non-negative `k`). No exceptions are raised or caught.

## Topics to Explore

- [file] `check-if-all-1s-are-at-least-length-k-places-away/test_solution.py` — See the test cases and edge cases exercised against this solution
- [file] `check-if-all-1s-are-at-least-length-k-places-away/review.md` — Read the code review for quality notes and alternative approaches
- [function] `can-place-flowers/solution.py:canPlaceFlowers` — Similar gap-between-elements pattern applied to a greedy placement problem
- [function] `max-consecutive-ones/solution.py:findMaxConsecutiveOnes` — Another single-pass binary array scan with position tracking
- [general] `sentinel-vs-flag-pattern` — When `-1` sentinel initialization is preferable to a boolean flag for "first occurrence" logic

## Beliefs

- `k-length-apart-linear-time` — `kLengthApart` runs in O(n) time with O(1) space via a single pass tracking the last seen 1's index
- `k-length-apart-gap-is-exclusive` — The gap `i - last - 1` counts elements strictly between two 1s, not including the 1s themselves
- `k-length-apart-sentinel-minus-one` — The sentinel value `-1` for `last` ensures the first 1 in the array never triggers a false violation
- `k-length-apart-consecutive-sufficiency` — Only consecutive pairs of 1s are checked; if all consecutive pairs satisfy the distance, all pairs do

