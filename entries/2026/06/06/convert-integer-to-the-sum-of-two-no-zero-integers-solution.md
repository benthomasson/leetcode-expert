# File: convert-integer-to-the-sum-of-two-no-zero-integers/solution.py

**Date:** 2026-06-06
**Time:** 15:52

## `convert-integer-to-the-sum-of-two-no-zero-integers/solution.py`

### Purpose

This file solves [LeetCode 1317](https://leetcode.com/problems/convert-integer-to-the-sum-of-two-no-zero-integers/): given an integer `n`, return two positive integers `a` and `b` such that `a + b = n` and neither `a` nor `b` contains the digit `0` in its decimal representation. It's one of ~400+ problem solutions in the `leetcode-implementations` repo, each owning a single problem's algorithm.

### Key Components

**`no_zero_integers(n: int) -> list[int]`** — The sole function. Contract: accepts an integer `n` in `[2, 10^4]`, returns a two-element list `[a, b]` where `a + b == n`, both `a > 0` and `b > 0`, and neither contains the digit `'0'`.

### Patterns

**Linear scan with string-based digit check.** The function iterates `a` from `1` to `n-1`, computes `b = n - a`, and checks both for the absence of `'0'` via `str()` conversion. It returns on the first valid pair found — a greedy/brute-force approach that's perfectly adequate given the constraint `n <= 10^4`.

This is a common idiom across the repo: a module-level function (not wrapped in a `Solution` class) with type hints and a docstring.

### Dependencies

**Imports:** None — pure Python, no stdlib or third-party dependencies.

**Imported by:** Its own `test_solution.py`, plus (per the `Imported By` list) hundreds of other test files. That "imported by" list is almost certainly an artifact of the repo's test harness structure rather than actual cross-problem dependencies — each `test_solution.py` likely imports its own sibling `solution.py` via a shared mechanism, and the static analysis picked up all test files that use the same import pattern.

### Flow

1. Loop `a` from `1` through `n-1`.
2. Compute `b = n - a`.
3. Convert both `a` and `b` to strings, check if `'0'` appears in either.
4. On the first pair where neither contains `'0'`, return `[a, b]`.

The loop always terminates before exhausting the range because a valid decomposition is guaranteed to exist for `n >= 2` (e.g., `n = 2` yields `[1, 1]`).

### Invariants

- **Both outputs are positive**: `a >= 1` (loop starts at 1) and `b >= 1` (loop ends before `a == n`).
- **Sum equals input**: `a + b == n` by construction (`b = n - a`).
- **No zeros in either number**: enforced by the string containment check.
- **First valid pair wins**: the function returns the smallest valid `a`, which means it's deterministic — same input always produces the same output.

### Error Handling

None. The function has no guard clauses, no exceptions, and no handling for out-of-range inputs. If `n < 2`, the loop would either return a degenerate result (e.g., `n=1` loops `a=1..0` — an empty range) or the function would fall off the end and implicitly return `None`. The docstring states the precondition `2 <= n <= 10^4`, and the caller is expected to honor it.

### Complexity

- **Time:** O(n * d) worst case, where d is the number of digits in n. For `n <= 10^4`, this is trivially fast — at most ~10,000 iterations with 5-character string checks.
- **Space:** O(1) beyond the string conversions.

## Topics to Explore

- [file] `convert-integer-to-the-sum-of-two-no-zero-integers/test_solution.py` — See how the function is tested and what edge cases are covered (e.g., `n=2`, `n=10`, `n=10000`)
- [file] `convert-integer-to-the-sum-of-two-no-zero-integers/review.md` — The code review may discuss whether the brute-force approach is optimal or flag the lack of input validation
- [general] `no-zero-integer-math-approach` — An alternative O(d) solution exists: build `a` digit-by-digit from the most significant digit, ensuring neither `a` nor `n-a` ever produces a zero digit — worth comparing against this brute-force
- [file] `subtract-the-product-and-sum-of-digits-of-an-integer/solution.py` — Another digit-manipulation problem that uses string conversion; compare the shared idiom

## Beliefs

- `no-zero-integers-returns-smallest-a` — `no_zero_integers` always returns the pair with the smallest possible first element, since it scans `a` upward from 1 and returns on first match
- `no-zero-integers-no-input-validation` — The function performs no input validation; inputs outside `[2, 10^4]` can produce `None` or incorrect results silently
- `no-zero-integers-string-based-zero-check` — Zero-digit detection is done via `'0' not in str(x)` rather than arithmetic modulo operations
- `no-zero-integers-guaranteed-termination` — For any `n >= 2`, the loop is guaranteed to find a valid pair before exhausting the range, because at minimum `a=1, b=n-1` or similar single-digit decompositions exist for small n, and multi-digit numbers always have zero-free decompositions

