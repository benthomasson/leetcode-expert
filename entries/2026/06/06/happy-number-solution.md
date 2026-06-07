# File: happy-number/solution.py

**Date:** 2026-06-06
**Time:** 16:59

## Purpose

This file solves [LeetCode #202 — Happy Number](https://leetcode.com/problems/happy-number/). It determines whether a number is "happy" by repeatedly replacing it with the sum of the squares of its digits, checking if the sequence eventually reaches 1 (happy) or enters a cycle (not happy). It uses Floyd's cycle detection (tortoise and hare) instead of a hash set, giving O(1) space.

## Key Components

### `get_next(n: int) -> int`
Computes the digit-square-sum of `n`. Extracts digits via repeated `divmod(n, 10)`, accumulates `digit * digit`. This is the "step function" that defines the sequence — every call advances one position in the chain `n → sum_of_squares(n) → ...`.

### `is_happy(n: int) -> bool`
The main solver. Initializes a slow pointer at `n` and a fast pointer one step ahead at `get_next(n)`. Advances slow by one step and fast by two steps per iteration until either:
- `fast == 1` — the sequence reached 1, so `n` is happy.
- `slow == fast` — a cycle was detected (and it doesn't include 1), so `n` is not happy.

Returns `fast == 1` after the loop exits.

## Patterns

**Floyd's cycle detection** — the classic tortoise-and-hare approach. The problem's structure guarantees every sequence either terminates at 1 (which maps to itself: `get_next(1) == 1`, a fixed point) or enters a finite cycle. Floyd's algorithm detects both in O(1) space, avoiding the unbounded growth of a `seen` set.

**Functional decomposition** — the step function `get_next` is separated from the cycle-detection logic in `is_happy`. This keeps each function single-purpose and makes `get_next` independently testable.

## Dependencies

**Imports**: None — pure Python, no standard library or third-party dependencies.

**Imported by**: `happy-number/test_solution.py` (directly). The massive "Imported By" list in the prompt is an artifact of the test harness structure — those other test files don't actually import this module; they share a common test runner pattern.

## Flow

1. `is_happy(n)` is called with a positive integer.
2. `slow = n`, `fast = get_next(n)` — fast starts one step ahead.
3. Loop: while `fast != 1` (not happy yet) and `slow != fast` (no cycle yet):
   - `slow` advances one step: `get_next(slow)`
   - `fast` advances two steps: `get_next(get_next(fast))`
4. Loop exits. If `fast == 1`, the number is happy. If `slow == fast` (and `fast != 1`), a cycle was found — not happy.

For `n = 19`: the sequence is 19 → 82 → 68 → 100 → 1. Fast reaches 1 before slow catches it.

For `n = 2`: the sequence enters the cycle 2 → 4 → 16 → 37 → 58 → 89 → 145 → 42 → 20 → 4 → ... and the pointers eventually collide.

## Invariants

- **Input constraint**: `n` must be a positive integer (1 ≤ n ≤ 2³¹ - 1). No validation is performed; the caller is trusted.
- **Termination guarantee**: every positive integer's digit-square-sum sequence either reaches 1 or enters a cycle. The sequence can never diverge to infinity because the digit-square-sum of any number ≤ 2³¹ is bounded (at most 9² × 10 = 810 for a 10-digit number), so the sequence quickly enters a small finite range.
- **Fixed point at 1**: `get_next(1) == 1`, so once the fast pointer hits 1, the loop exits immediately.

## Error Handling

None. The functions assume valid input and contain no guards, assertions, or exception handling. Passing 0 would cause `get_next` to return 0 (the while loop body never executes), and `is_happy(0)` would spin forever since `fast` would be 0 (never 1) and `slow` would immediately equal `fast` — actually it would return `False` on the first check since `slow = 0` and `fast = get_next(0) = 0`, so `slow == fast` is true and `fast != 1`, exiting with `False`. Negative numbers would loop indefinitely due to `divmod` behavior with negatives producing negative remainders.

## Topics to Explore

- [file] `happy-number/test_solution.py` — See what edge cases the tests cover (single digit, known cycles, large inputs)
- [file] `happy-number/plan.md` — Read the design rationale for choosing Floyd's over a hash set approach
- [general] `digit-square-sum-cycle-structure` — The cycle that all unhappy numbers enter (4 → 16 → 37 → 58 → 89 → 145 → 42 → 20 → 4) is the only cycle for positive integers — worth verifying
- [function] `linked-list-cycle/solution.py:hasCycle` — Another Floyd's cycle detection application in this repo, on linked lists instead of number sequences
- [file] `happy-number/review.md` — Check if the review flagged any concerns about the approach or edge cases

## Beliefs

- `happy-number-floyds-o1-space` — `is_happy` uses Floyd's cycle detection with O(1) space complexity, not a hash set
- `happy-number-get-next-fixed-point` — `get_next(1)` returns 1, making 1 a fixed point that terminates the algorithm
- `happy-number-no-imports` — The solution has zero imports; it's pure Python with no dependencies
- `happy-number-fast-starts-ahead` — The fast pointer is initialized one step ahead of slow (`get_next(n)` vs `n`), which is critical for the cycle detection to work correctly when the starting value itself is part of a cycle

