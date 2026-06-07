# File: maximum-enemy-forts-that-can-be-captured/solution.py

**Date:** 2026-06-06
**Time:** 17:37

## `maximum-enemy-forts-that-can-be-captured/solution.py`

### Purpose

Solves [LeetCode 2511: Maximum Enemy Forts That Can Be Captured](https://leetcode.com/problems/maximum-enemy-forts-that-can-be-captured/). The file owns a single function that computes the maximum number of enemy forts (represented as `0`) that can be captured by moving your army from a friendly fort (`1`) to an empty position (`-1`), or vice versa, in a straight line over only enemy forts.

### Key Components

**`max_captured_forts(forts: list[int]) -> int`** — The sole public function. Takes a list where each element is `-1` (empty), `0` (enemy fort), or `1` (your fort). Returns the maximum count of enemy forts between any valid pair of endpoints.

A "valid pair" is two non-zero values of *opposite sign* with only `0`s between them.

### Patterns

**Anchor-tracking scan.** Rather than brute-forcing all pairs (O(n^2)), the algorithm keeps a single pointer `last_non_zero` to the most recent index where `forts[i] != 0`. When the next non-zero value is found, it checks whether the two endpoints differ in sign — if so, the gap `i - last_non_zero - 1` counts the enemy forts between them.

This is a standard "last-seen" idiom: skip irrelevant elements, compare the current non-zero to the previous non-zero. It runs in O(n) time and O(1) space.

### Dependencies

**Imports:** None — pure stdlib, no external dependencies.

**Imported by:** The `test_solution.py` in its own directory. The large "Imported By" list in the prompt is an artifact of the test harness — those other test files don't actually import *this* solution; they import their own respective solutions via the same relative pattern.

### Flow

1. Initialize `result = 0` (best gap found) and `last_non_zero = -1` (no anchor yet).
2. Iterate over `forts` with index `i` and value `val`.
3. If `val != 0` (i.e., it's `1` or `-1`):
   - If an anchor exists (`last_non_zero != -1`) and the anchor's value differs from `val` (`forts[last_non_zero] != val`), the segment between them is all `0`s — compute the count as `i - last_non_zero - 1` and update `result`.
   - Update `last_non_zero = i` regardless (even if signs match — the old anchor can never produce a better result than starting fresh from here).
4. Return `result`.

### Invariants

- **Only `0`s exist between valid endpoints.** The algorithm never explicitly checks this — it relies on the problem guarantee that the array contains only `-1`, `0`, and `1`. Since it jumps between non-zero indices, everything in between is necessarily `0`.
- **Bidirectional capture.** Moving from `1` to `-1` *or* from `-1` to `1` are both valid. The condition `forts[last_non_zero] != val` handles both directions symmetrically — no separate forward/backward passes needed.
- **`last_non_zero` is always updated** when a non-zero is encountered, even when the signs match. This ensures the anchor stays as close as possible to future candidates.

### Error Handling

None. The function assumes well-formed input per the LeetCode contract. An empty list or all-zeros list returns `0` naturally (no non-zero pair is ever found).

---

## Topics to Explore

- [file] `maximum-enemy-forts-that-can-be-captured/test_solution.py` — See what edge cases the test suite covers (all-zeros, single element, adjacent non-zeros)
- [file] `maximum-enemy-forts-that-can-be-captured/plan.md` — Read the planning doc to see if alternative approaches (two-pointer, prefix scan) were considered
- [general] `anchor-tracking-pattern` — The "last-seen non-zero" idiom recurs in problems like max-consecutive-ones, trapping rain water, and container-with-most-water
- [function] `count-hills-and-valleys-in-an-array/solution.py:countHillValley` — Another problem that skips equal neighbors and compares non-equal anchors, same structural pattern

## Beliefs

- `max-captured-forts-linear-time` — `max_captured_forts` runs in O(n) time with a single pass and O(1) auxiliary space
- `max-captured-forts-bidirectional` — The algorithm captures both 1-to-(-1) and (-1)-to-1 movements in a single pass via the `!=` sign check
- `max-captured-forts-anchor-greedy` — `last_non_zero` is updated on every non-zero element, not just on successful captures, ensuring the closest valid anchor is always used
- `max-captured-forts-no-validation` — The function performs no input validation; it assumes all elements are in {-1, 0, 1} per the problem contract

