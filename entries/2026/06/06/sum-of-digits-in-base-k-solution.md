# File: sum-of-digits-in-base-k/solution.py

**Date:** 2026-06-06
**Time:** 19:21



## Purpose

This file solves [LeetCode 1837 — Sum of Digits in Base K](https://leetcode.com/problems/sum-of-digits-in-base-k/). It converts a base-10 integer `n` into its base-`k` representation and returns the sum of the resulting digits (back in base 10). It's a single-function module — no classes, no imports, no state.

## Key Components

### `sum_base(n: int, k: int) -> int`

The sole public function. Contract:

- **Input**: `n` (1 ≤ n ≤ 100), `k` (2 ≤ k ≤ 10)
- **Output**: The sum of digits of `n` written in base `k`
- **Side effects**: None

Example: `sum_base(34, 6)` → 34 in base 6 is `54` (5×6 + 4), so the digit sum is 9.

## Patterns

The function uses the standard **repeated division** idiom for base conversion. Rather than building the full base-`k` string and then summing characters, it accumulates the digit sum on the fly — each `n % k` extracts the least-significant digit, and `n //= k` shifts down. This is the canonical approach: O(log_k(n)) time, O(1) space, no string allocation.

The `while n:` loop is idiomatic Python for "until n becomes zero." Since `n ≥ 1` on entry, the loop always executes at least once.

## Dependencies

**Imports**: None — pure arithmetic, no standard library needed.

**Imported by**: The `"Imported By"` list in the prompt is misleading — those are test files across the entire repo that share a common test harness or conftest, not files that actually call `sum_base`. The only direct consumer is `sum-of-digits-in-base-k/test_solution.py`.

## Flow

```
n=34, k=6
─────────────────────────
Iter 1: total += 34 % 6 = 4  → total=4,  n = 34 // 6 = 5
Iter 2: total += 5 % 6  = 5  → total=9,  n = 5 // 6  = 0
Loop ends (n == 0)
Return 9
```

Data flows linearly: `n` is consumed destructively (mutated via `//=`), and `total` monotonically increases.

## Invariants

- **Loop termination**: Guaranteed because `n //= k` with `k ≥ 2` strictly decreases a positive `n` toward zero.
- **No negative digits**: With `n ≥ 1` and `k ≥ 2`, `n % k` is always in `[0, k-1]`, so `total` is non-negative.
- **Input range**: The docstring states constraints (1 ≤ n ≤ 100, 2 ≤ k ≤ 10) but does not enforce them — this is typical for LeetCode solutions where the judge guarantees valid input.

## Error Handling

None. If `n=0` is passed, the loop body never executes and the function returns 0 (which happens to be correct). If `k=0` or `k=1` is passed, the function will raise `ZeroDivisionError` or loop forever, respectively. These are outside the stated contract.

## Topics to Explore

- [file] `sum-of-digits-in-base-k/test_solution.py` — See what edge cases the test suite covers and whether `n=0` or boundary values are tested
- [file] `sum-of-digits-in-base-k/plan.md` — Understand the planning rationale and whether alternative approaches (string conversion, recursion) were considered
- [function] `base-7/solution.py:convertToBase7` — A related problem that builds the full base-k string representation rather than just summing digits
- [function] `add-digits/solution.py:addDigits` — The digital root problem, which applies repeated digit-summing until a single digit remains — a natural extension of this pattern
- [general] `repeated-division-idiom` — How `divmod`-based base conversion appears across multiple solutions in this repo (base-7, hexadecimal, excel-column-title)

## Beliefs

- `sum-base-no-allocation` — `sum_base` computes the digit sum without constructing the base-k string, using O(1) space
- `sum-base-terminates-for-valid-input` — The while loop terminates in O(log_k(n)) iterations because integer division by k≥2 strictly decreases a positive n
- `sum-base-no-input-validation` — The function relies on the caller to satisfy the documented constraints; passing k=1 causes an infinite loop, k=0 raises ZeroDivisionError
- `sum-base-pure-function` — `sum_base` has no imports, no side effects, and no state — it is a pure arithmetic function

