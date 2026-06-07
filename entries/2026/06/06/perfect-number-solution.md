# File: perfect-number/solution.py

**Date:** 2026-06-06
**Time:** 18:32

## Purpose

This file solves [LeetCode 507 — Perfect Number](https://leetcode.com/problems/perfect-number/). A perfect number is a positive integer equal to the sum of its proper divisors (all positive divisors excluding itself). For example, 28 = 1 + 2 + 4 + 7 + 14.

It's one of ~500 solution files in the `leetcode-implementations` repo, each following the same structure: a `Solution` class with the method signature LeetCode expects.

## Key Components

**`Solution.checkPerfectNumber(self, num: int) -> bool`** — the only method. Takes a positive integer and returns whether it's a perfect number.

## Patterns

**Square-root divisor search.** Instead of checking all candidates up to `num`, the loop runs only to `isqrt(num)`. When it finds a divisor `i`, it also harvests the complementary divisor `num // i` in the same iteration. This is the standard O(sqrt(n)) approach for divisor enumeration.

**Paired divisor harvesting with dedup guard.** The check `if i != num // i` (line 19) prevents double-counting when `num` is a perfect square and `i == num // i`. Without this, a number like 4 would count its square root twice.

**Seed value of 1.** `divisor_sum` starts at 1 (line 16) because 1 is always a proper divisor of any `num > 1`, and the loop starts at 2. This avoids a special case inside the loop.

## Dependencies

**Imports:** `math` — used solely for `math.isqrt`, the integer square root (avoids floating-point truncation bugs that `int(math.sqrt(n))` can introduce for large `n`).

**Imported by:** `perfect-number/test_solution.py` directly. The massive "Imported By" list in the prompt is an artifact of how the repo's test harness discovers solution modules — those other test files don't actually import this solution.

## Flow

1. **Early exit:** if `num <= 1`, return `False`. This handles 0, 1, and negative inputs — none of which can be perfect numbers (the smallest is 6).
2. **Accumulate divisors:** loop `i` from 2 through `isqrt(num)`. For each `i` that divides `num`, add both `i` and its pair `num // i` (unless they're equal).
3. **Compare:** return whether the accumulated sum equals `num`.

## Invariants

- `num` must be > 1 for the divisor loop to execute; the guard on line 14 enforces this.
- The divisor sum never includes `num` itself — the loop stops at `isqrt(num)`, which is always < `num` for `num > 1`, and the seed of 1 is a proper divisor by definition.
- `isqrt` guarantees exact integer arithmetic — no floating-point edge cases for large inputs.

## Error Handling

None. The method trusts that `num` is an integer (per LeetCode's contract). Non-integer inputs would raise a `TypeError` from `math.isqrt` or the `%` operator, which is appropriate — this is an internal boundary, not a user-facing API.

## Topics to Explore

- [file] `perfect-number/test_solution.py` — See which edge cases (1, 6, 28, 496, large non-perfect numbers) the test suite covers
- [file] `perfect-number/review.md` — The code review may note alternative approaches (e.g., hardcoding the six known perfect numbers below 10^8)
- [function] `three-divisors/solution.py:Solution.isThree` — Another divisor-counting problem that likely uses the same sqrt-loop pattern
- [general] `isqrt-vs-sqrt` — Why `math.isqrt` is preferred over `int(math.sqrt(n))` for large integers (floating-point precision loss near 2^53)
- [file] `construct-the-rectangle/solution.py` — Another solution that uses paired-divisor search from the square root

## Beliefs

- `perfect-number-sqrt-complexity` — `checkPerfectNumber` runs in O(sqrt(n)) time and O(1) space
- `perfect-number-excludes-self` — The divisor sum never includes `num` itself; the loop upper bound and seed value jointly guarantee this
- `perfect-number-handles-perfect-squares` — The `i != num // i` guard prevents double-counting the square root when `num` is a perfect square
- `perfect-number-rejects-leq-1` — Inputs <= 1 are rejected before the loop, correctly returning False for 0, 1, and negative numbers

