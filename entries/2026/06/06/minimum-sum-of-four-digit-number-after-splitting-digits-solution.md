# File: minimum-sum-of-four-digit-number-after-splitting-digits/solution.py

**Date:** 2026-06-06
**Time:** 18:02

## Purpose

This file solves [LeetCode 2160: Minimum Sum of Four Digit Number After Splitting Digits](https://leetcode.com/problems/minimum-sum-of-four-digit-number-after-splitting-digits/). It owns both the solution logic and its unit tests in a single module. Given a 4-digit integer, it splits the digits into two 2-digit numbers such that their sum is minimized.

## Key Components

### `min_operations(num: int) -> int`

Despite the name (which mirrors LeetCode's original naming), this function computes the minimum sum achievable by splitting a 4-digit number's digits into two 2-digit integers. The contract:

- **Input**: A positive integer with exactly 4 digits (1000–9999).
- **Output**: The minimum possible sum of two integers formed from those digits.

### `TestMinOperations`

Six test cases covering LeetCode examples, edge cases (all-same digits, boundary values), and a sequential-digit case.

## Patterns

**Greedy via sorting.** The core insight: sort the four digits ascending, then interleave them across two numbers. The two smallest digits become the tens digits (high-weight positions), the two largest become the units digits (low-weight positions). Specifically:

```
digits[0]*10 + digits[2]  +  digits[1]*10 + digits[3]
```

This is a common greedy pattern for digit-partition problems — minimize the contribution of large digits by placing them in low-significance positions.

**Self-contained module.** Solution + tests colocated in one file, runnable via `python solution.py`. This is the convention across the entire repo.

## Dependencies

**Imports:** Only `unittest` from the standard library — no external dependencies.

**Imported by:** The massive `Imported By` list is misleading. Those are *test files from other problems* that share the same test runner infrastructure (`run_tests.py` at repo root), not files that actually import `min_operations`. The function itself has no downstream consumers.

## Flow

1. Convert `num` to a string, iterate each character, cast to `int` → produces 4 individual digits.
2. Sort the digits ascending.
3. Construct two 2-digit numbers by pairing `digits[0]` with `digits[2]` and `digits[1]` with `digits[3]` — the two smallest digits occupy the tens place, the two largest occupy the units place.
4. Return the sum.

For `num = 2932`: digits → `[2, 2, 3, 9]` sorted → `(2*10 + 3) + (2*10 + 9)` = `23 + 29` = `52`.

## Invariants

- The sorted array guarantees `digits[0] <= digits[1] <= digits[2] <= digits[3]`, which is what makes the tens/units assignment optimal.
- The function assumes exactly 4 digits. Inputs outside 1000–9999 would produce incorrect results (fewer or more digits), but no validation enforces this — it relies on LeetCode's problem constraints.

## Error Handling

None. No input validation, no exception handling. Invalid inputs (non-integers, numbers with fewer/more than 4 digits, negative numbers) would either crash at `str(num)` iteration or silently produce wrong answers. This is intentional for a competitive programming context.

## Topics to Explore

- [file] `split-with-minimum-sum/solution.py` — Solves the generalized version (LeetCode 2578) for arbitrary digit counts, likely uses the same greedy-sort pattern
- [function] `minimum-sum-of-four-digit-number-after-splitting-digits/solution.py:min_operations` — Verify whether the interleaving assignment `(0,2),(1,3)` vs `(0,3),(1,2)` matters (it doesn't — both yield the same sum since `a*10+c + b*10+d == a*10+d + b*10+c`)
- [file] `run_tests.py` — The repo-level test runner that discovers and executes all per-problem test suites
- [general] `greedy-digit-partition` — The broader class of problems where sorting digits and assigning to positional weights yields optimal splits

## Beliefs

- `sort-then-interleave-optimal` — Sorting digits ascending and assigning the two smallest to tens places always minimizes the two-number sum for exactly 4 digits.
- `interleave-pairing-irrelevant` — Swapping which sorted digit pairs with which (e.g., `(0,2)+(1,3)` vs `(0,3)+(1,2)`) produces identical sums because the units digits simply swap between the two numbers.
- `no-input-validation` — `min_operations` performs no bounds checking; inputs outside 1000–9999 silently produce incorrect results.
- `function-name-mismatch` — The function is named `min_operations` (likely from the LeetCode template) but computes a minimum *sum*, not a count of operations.

