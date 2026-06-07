# File: count-largest-group/solution.py

**Date:** 2026-06-06
**Time:** 16:00

## Purpose

This file solves [LeetCode 1399 — Count Largest Group](https://leetcode.com/problems/count-largest-group/). Given an integer `n`, numbers from 1 to `n` are grouped by their digit sum. The function returns how many groups share the maximum group size.

For example, with `n = 13`: digit sums partition `{1..13}` into groups like `{1,10} → sum 1`, `{2,11} → sum 2`, `{3,12} → sum 3`, `{4,13} → sum 4`, `{5}`, ..., `{9}`. The largest groups have size 2; there are 4 such groups, so the answer is 4.

## Key Components

**`countLargestGroup(n: int) -> int`** — The sole function. It:
1. Computes the digit sum for every integer in `[1, n]`
2. Counts how many integers share each digit sum
3. Returns the number of groups tied for the largest count

## Patterns

**Single-expression Counter construction**: The entire grouping is done in one `Counter(generator)` call. The generator `sum(int(d) for d in str(i))` computes digit sums via string conversion — idiomatic Python for digit decomposition but not the fastest approach (repeated `int`/`str` conversions). For LeetCode constraints (`n ≤ 10^4`), this is fine.

**Two-pass max-then-count**: Classic pattern — find the max value first, then count how many entries match it. No early termination or single-pass optimization, which keeps the code readable at no meaningful cost given the input bounds.

## Dependencies

**Imports**: `collections.Counter` — the only external dependency. Standard library, no third-party packages.

**Imported by**: The "Imported By" list in the prompt is misleading — those are test files across the entire repo that happen to import `Counter` from `collections`, not files that import this solution. The actual consumer is `count-largest-group/test_solution.py`.

## Flow

```
n=13
  → range(1, 14) generates [1, 2, ..., 13]
  → each i → str(i) → sum of int(digit) → digit sum
  → Counter({1:2, 2:2, 3:2, 4:2, 5:1, 6:1, 7:1, 8:1, 9:1})
  → max_size = 2
  → count groups with value == 2 → return 4
```

All work is O(n * d) where d is the number of digits in n (at most 5 for the constraint `n ≤ 10^4`). Space is O(n) for the Counter, bounded by the number of distinct digit sums (at most 36 for a 4-digit number, so effectively O(1) for the Counter itself).

## Invariants

- `n ≥ 1` is assumed — `range(1, n+1)` would produce an empty range for `n=0`, and `max()` on an empty Counter would raise `ValueError`.
- Every integer in `[1, n]` belongs to exactly one group (partitioned by digit sum).
- `counts` is never empty when `n ≥ 1`, so the `max()` call is safe under the problem's constraints.

## Error Handling

None. If `n ≤ 0`, `max(counts.values())` raises `ValueError` on an empty sequence. The function trusts the caller to satisfy the LeetCode constraint `1 ≤ n ≤ 10^4`.

## Topics to Explore

- [file] `count-largest-group/test_solution.py` — Verify which edge cases are covered (n=1, n=10000, boundary values)
- [function] `maximum-number-of-balls-in-a-box/solution.py:countBalls` — Same digit-sum grouping pattern applied to a different problem; compare approaches
- [general] `digit-sum-computation-patterns` — Arithmetic (`n % 10`, `n // 10`) vs string-based (`sum(int(d) for d in str(i))`) digit decomposition tradeoffs across this repo
- [file] `count-largest-group/plan.md` — Design rationale and alternative approaches considered before implementation

## Beliefs

- `digit-sum-grouping-via-string` — Digit sums are computed by converting to string and summing character values, not by arithmetic modulo/division
- `no-guard-for-empty-input` — `countLargestGroup` will raise `ValueError` if called with `n ≤ 0` because `max()` receives an empty sequence
- `linear-scan-two-pass` — The function makes exactly two passes over the Counter values: one for `max()`, one for the count of groups matching the max
- `bounded-group-count` — The number of distinct digit-sum groups is at most 36 (for `n ≤ 9999`, max digit sum is `9+9+9+9=36`), so the Counter has O(1) keys relative to input size

