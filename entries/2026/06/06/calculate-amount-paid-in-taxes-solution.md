# File: calculate-amount-paid-in-taxes/solution.py

**Date:** 2026-06-06
**Time:** 15:28

## `calculate-amount-paid-in-taxes/solution.py`

### Purpose

This file solves [LeetCode 2303 — Calculate Amount Paid in Taxes](https://leetcode.com/problems/calculate-amount-paid-in-taxes/). It implements a progressive tax calculator: given a set of tax brackets and an income, compute the total tax owed. The file is self-contained — it holds both the solution function and its unit tests.

### Key Components

**`tax_amount(brackets, income) -> float`** (line 7)

The sole public function. Contract:
- `brackets`: a list of `[upper_bound, percent]` pairs, sorted by `upper_bound` ascending. Each bracket defines a ceiling and a tax rate for income in that band.
- `income`: non-negative integer.
- Returns the total tax as a float.

The function models how real progressive taxation works: each bracket taxes only the *marginal* income within that band, not the full income.

### Flow

The loop (lines 17–22) walks brackets in order, maintaining `prev` as the lower bound of the current band:

1. Compute `taxable = min(upper, income) - prev` — the income falling within this band.
2. If `taxable <= 0`, income has been fully accounted for; break early.
3. Accumulate `taxable * percent / 100` into `tax`.
4. Advance `prev = upper` to set the floor for the next band.

The `min(upper, income)` clamp is the key insight — it ensures the final bracket only taxes income up to the actual income, not the full bracket ceiling.

### Patterns

- **Single-pass greedy**: O(n) where n is the number of brackets. No sorting needed because the input is guaranteed sorted.
- **Early termination**: the `taxable <= 0` check breaks as soon as income is exhausted, skipping higher brackets entirely.
- **Inline tests**: tests live alongside the solution in the same file rather than in a separate test module, though `test_solution.py` also exists and imports from here.

### Dependencies

**Imports**: only `unittest` from the standard library — no external dependencies.

**Imported by**: the `test_solution.py` in this directory, plus hundreds of other `test_solution.py` files across the repo. The "Imported By" list in the prompt is misleading — those other test files don't actually import *this* solution; they share the same structural pattern (each imports its own directory's `solution`). The real dependent is `calculate-amount-paid-in-taxes/test_solution.py`.

### Invariants

- **Brackets must be sorted by `upper_bound`**: the algorithm relies on walking bands low-to-high. Unsorted input produces wrong results silently.
- **`prev` starts at 0**: assumes the first bracket covers income from 0 up to its upper bound.
- **No negative income handling**: income is assumed non-negative. Negative income would produce 0 tax (the `taxable <= 0` guard fires immediately).

### Error Handling

None. The function trusts its inputs — no validation of bracket ordering, no checks for negative percentages or income. This is typical for LeetCode solutions where inputs are guaranteed by the problem constraints.

### Tests

Seven test cases (lines 25–46) cover:
- The two LeetCode examples (`test_example1`, `test_example2`)
- Zero income (`test_example3`)
- Income landing exactly on a bracket boundary
- Single bracket covering full income
- 0% and 100% tax rates

All use `assertAlmostEqual` to handle floating-point comparison, which is appropriate given the `/100` division.

## Topics to Explore

- [file] `calculate-amount-paid-in-taxes/test_solution.py` — The external test file; check whether it adds edge cases beyond the inline tests
- [file] `calculate-amount-paid-in-taxes/plan.md` — The solving strategy and approach notes for this problem
- [general] `progressive-vs-flat-tax-modeling` — Understanding why `min(upper, income) - prev` correctly models marginal taxation
- [function] `calculate-amount-paid-in-taxes/solution.py:tax_amount` — Trace through with a multi-bracket example to verify the `prev` bookkeeping

## Beliefs

- `tax-amount-is-single-pass` — `tax_amount` computes the result in a single O(n) pass over the brackets list with early termination
- `tax-amount-assumes-sorted-brackets` — The algorithm produces incorrect results if `brackets` is not sorted by `upper_bound` ascending; no validation enforces this
- `min-clamp-ensures-marginal-taxation` — `min(upper, income)` prevents a bracket from taxing more income than actually earned, which is the core correctness invariant
- `float-division-in-tax-calculation` — Tax is accumulated as a float via `percent / 100`, so results may have floating-point imprecision (tests use `assertAlmostEqual`)

