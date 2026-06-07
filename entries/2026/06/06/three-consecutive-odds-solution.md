# File: three-consecutive-odds/solution.py

**Date:** 2026-06-06
**Time:** 19:29

## `three-consecutive-odds/solution.py`

### Purpose

Solves [LeetCode 1550 — Three Consecutive Odds](https://leetcode.com/problems/three-consecutive-odds/). Given an integer array, determine whether any three consecutive elements are all odd. This is a straightforward array-scanning problem classified as Easy.

### Key Components

**`Solution.threeConsecutiveOdds(self, arr: List[int]) -> bool`** — The single method. It maintains a running count of consecutive odd numbers seen so far, returning `True` the moment that count hits 3, or `False` after exhausting the array.

### Patterns

**Streaming counter with reset.** Rather than checking every triplet with a sliding window or triple-nested index comparison (`arr[i] % 2 and arr[i+1] % 2 and arr[i+2] % 2`), the solution uses a single counter that increments on odd and resets to 0 on even. This is a common idiom for "k consecutive elements matching a predicate" — it generalizes to any k by changing the threshold.

**Early exit.** The function returns `True` as soon as the condition is met, skipping the remainder of the array. Worst case is a full scan (O(n)), best case is O(1) if the first three elements are odd.

### Dependencies

- **Imports:** `List` from `typing` — standard type annotation, no runtime effect.
- **Imported by:** The `test_solution.py` in the same directory, plus hundreds of unrelated test files listed in the "Imported By" section (those are likely an artifact of how the repo's import graph was resolved — they don't actually import *this* solution).

### Flow

1. Initialize `count = 0`.
2. Iterate through each `num` in `arr`.
3. If `num` is odd (`num % 2 == 1`), increment `count`. If `count` reaches 3, return `True` immediately.
4. If `num` is even, reset `count` to 0.
5. If the loop completes without hitting 3, return `False`.

### Invariants

- **`count` is always in [0, 2] during iteration** — the moment it would reach 3, the function exits.
- **`count` represents the length of the current consecutive-odd suffix** of the elements seen so far.
- The odd check uses `num % 2 == 1`, which is correct for positive integers (per the constraint `1 <= arr[i] <= 1000`) but would fail for negative odds (where `% 2 == -1`). The constraint makes this safe here.

### Error Handling

None. The function trusts the caller to pass a valid list of integers within the stated constraints. No bounds checking, no empty-list guard — an empty list correctly returns `False` since the loop body never executes.

## Topics to Explore

- [file] `three-consecutive-odds/test_solution.py` — See which edge cases the test suite covers (empty array, exactly three elements, all odd, all even)
- [file] `three-consecutive-odds/review.md` — Read the code review for commentary on alternative approaches and complexity analysis
- [function] `consecutive-characters/solution.py:Solution.maxPower` — Same streaming-counter pattern applied to finding the longest run of a single character
- [general] `streaming-counter-pattern` — How the reset-on-mismatch counter generalizes to "k consecutive matching elements" problems across the repo
- [file] `check-if-all-1s-are-at-least-length-k-places-away/solution.py` — A related consecutive-element constraint problem using a similar scanning approach

## Beliefs

- `three-consecutive-odds-linear-time` — `threeConsecutiveOdds` runs in O(n) time and O(1) space, making a single pass with no auxiliary data structures.
- `three-consecutive-odds-early-exit` — The function returns `True` on the first triplet found; it does not scan the entire array when a match exists early.
- `three-consecutive-odds-positive-only` — The odd check `num % 2 == 1` is correct only for non-negative integers; negative odd numbers would yield `-1` and be missed, but the problem constraints guarantee positivity.
- `three-consecutive-odds-counter-invariant` — The `count` variable always equals the number of consecutive odd elements ending at the current position, reset to 0 on any even element.

