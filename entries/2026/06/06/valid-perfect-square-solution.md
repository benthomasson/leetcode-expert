# File: valid-perfect-square/solution.py

**Date:** 2026-06-06
**Time:** 19:40

## `valid-perfect-square/solution.py`

### Purpose

This file solves [LeetCode 367 — Valid Perfect Square](https://leetcode.com/problems/valid-perfect-square/). It determines whether a given positive integer is a perfect square **without** using a built-in square root function. It's one of ~500 problem solutions in the `leetcode-implementations` repo, each following the same directory convention (`problem-slug/solution.py`).

### Key Components

**`is_perfect_square(num: int) -> bool`** — The sole public function. Takes a positive integer in `[1, 2^31 - 1]` and returns whether some integer `m` exists such that `m * m == num`.

### Patterns

**Binary search on the answer space.** Rather than iterating candidates linearly or using Newton's method, the solution binary-searches the range `[1, num]` for a value whose square equals `num`. This is the canonical "binary search on value" pattern — the search space is monotonic (squaring is strictly increasing for positive integers), so standard binary search applies directly.

The midpoint calculation `mid = lo + (hi - lo) // 2` avoids integer overflow in languages with fixed-width integers. In Python this is technically unnecessary (arbitrary-precision ints), but it's a good habit that makes the solution portable.

### Dependencies

**Imports:** None — pure computation with no library dependencies.

**Imported by:** The "Imported By" list in the prompt is misleading — those are unrelated test files across the entire repo that happen to share a common test harness import pattern. The actual consumer is `valid-perfect-square/test_solution.py`, which imports `is_perfect_square` to test it.

### Flow

1. Initialize `lo = 1`, `hi = num`.
2. While the search window is non-empty (`lo <= hi`):
   - Compute `mid` as the floor midpoint.
   - Compute `sq = mid * mid`.
   - If `sq == num`: found the root, return `True`.
   - If `sq < num`: the candidate is too small, narrow to the upper half (`lo = mid + 1`).
   - If `sq > num`: the candidate is too large, narrow to the lower half (`hi = mid - 1`).
3. If the loop exits without a match, `num` has no integer square root — return `False`.

**Time complexity:** O(log n). **Space complexity:** O(1).

### Invariants

- **Precondition:** `num >= 1` (guaranteed by the problem constraints). The function doesn't validate this — passing `num = 0` would still work (loop runs with `lo=1, hi=0`, exits immediately returning `False`), but negative values would silently return `False`.
- **Loop invariant:** If `num` is a perfect square, its root lies in `[lo, hi]`. Each iteration shrinks the interval by at least one element, guaranteeing termination.
- **No overflow risk in Python**, but `mid * mid` can be large — for `num = 2^31 - 1`, the maximum `mid * mid` is roughly `2^62`, well within Python's arbitrary-precision handling.

### Error Handling

None. The function is a pure predicate with no failure modes under valid input. No exceptions are raised or caught.

## Topics to Explore

- [file] `valid-perfect-square/test_solution.py` — See what edge cases (1, large primes, max int) are covered in the test suite
- [file] `arranging-coins/solution.py` — Another problem solved via binary search on value, likely structurally similar
- [function] `binary-search/solution.py:search` — The vanilla binary search implementation in this repo, to compare the template
- [general] `newton-method-vs-binary-search` — Newton's method converges in O(log log n) for this problem; worth understanding the tradeoff
- [file] `first-bad-version/solution.py` — A "binary search on condition" variant where the predicate is an external API call rather than arithmetic

## Beliefs

- `binary-search-on-value-pattern` — `is_perfect_square` uses binary search over `[1, num]` with O(log n) time and O(1) space, making no library calls
- `overflow-safe-midpoint` — The midpoint is computed as `lo + (hi - lo) // 2` rather than `(lo + hi) // 2`, preventing overflow in fixed-width integer languages
- `zero-input-returns-false` — Passing `num=0` produces `False` (the loop body never executes because `lo=1 > hi=0`), even though 0 is technically a perfect square
- `no-sqrt-dependency` — The solution satisfies the LeetCode constraint of not using any built-in square root or exponentiation function

