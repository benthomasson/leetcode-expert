# File: calculate-money-in-leetcode-bank/solution.py

**Date:** 2026-06-06
**Time:** 15:30

## `calculate-money-in-leetcode-bank/solution.py`

### Purpose

Solves [LeetCode 1716](https://leetcode.com/problems/calculate-money-in-leetcode-bank/). The problem models a weekly savings pattern: on day 1 (Monday) of week 1 you deposit $1, incrementing by $1 each day through Sunday ($7). Each subsequent Monday starts $1 higher than the previous Monday. Given `n` days, return the total deposited.

### Key Components

**`Solution.totalMoney(n: int) -> int`** — the single method. It computes the answer in O(1) using closed-form arithmetic rather than simulating day by day.

### Flow

The method decomposes `n` into complete weeks and a remainder, then sums each part with arithmetic series formulas:

1. **`full_weeks = n // 7`** and **`remaining_days = n % 7`** — split the timeline.

2. **Complete weeks sum** — Week `k` (0-indexed) deposits values `(k+1), (k+2), ..., (k+7)`, totaling `28 + 7k`. Summing over all complete weeks:

   `weeks_total = full_weeks * 28 + 7 * full_weeks * (full_weeks - 1) // 2`

   This is `Σ(28 + 7k)` for `k = 0..full_weeks-1`, which expands to `28W + 7·W(W-1)/2`.

3. **Remaining days sum** — The partial week's Monday starts at deposit value `full_weeks + 1`. The remaining days deposit `(full_weeks+1), (full_weeks+2), ..., (full_weeks+remaining_days)`:

   `days_total = remaining_days * (full_weeks + 1) + remaining_days * (remaining_days - 1) // 2`

   This is the standard sum of an arithmetic sequence starting at `full_weeks + 1` with `remaining_days` terms.

4. **Return `weeks_total + days_total`**.

### Patterns

- **Closed-form over simulation**: avoids the naive O(n) loop by recognizing the deposit schedule as nested arithmetic series. This is the idiomatic approach for problems with regular additive patterns.
- **Integer-only arithmetic**: uses `//` throughout, keeping everything in `int` — no floating point.

### Dependencies

- **Imports**: None. Pure computation with no library dependencies.
- **Imported by**: `calculate-money-in-leetcode-bank/test_solution.py` (the "Imported By" list in the prompt is the full test suite across all problems — a shared test harness imports every solution).

### Invariants

- `n >= 1` is assumed (per LeetCode constraints: `1 <= n <= 1000`). No guard clause.
- The formulas rely on `full_weeks >= 0` and `0 <= remaining_days < 7`, which `//` and `%` guarantee for non-negative `n`.

### Error Handling

None. The method trusts its input matches the LeetCode contract. Passing `n = 0` would return `0` (correct by convention). Negative `n` would produce a nonsensical but non-crashing result due to Python's floor-division semantics.

---

## Topics to Explore

- [file] `calculate-money-in-leetcode-bank/test_solution.py` — Verify which edge cases (n=1, n=7, n=1000) are covered and how the test harness imports solutions
- [general] `arithmetic-series-closed-forms` — Understanding how `Σ(a + kd)` collapses to avoid loops, since many LeetCode easy problems follow this pattern
- [file] `arranging-coins/solution.py` — Another problem that decomposes into arithmetic series (triangular numbers), likely using a similar closed-form technique
- [file] `distribute-candies-to-people/solution.py` — A distribution problem with a similar week/remainder decomposition pattern

## Beliefs

- `closed-form-o1-complexity` — `totalMoney` runs in O(1) time and space regardless of `n`, using no loops or auxiliary data structures
- `week-k-total-is-28-plus-7k` — Each 0-indexed complete week `k` contributes exactly `28 + 7k` to the total, and the formula sums this series analytically
- `partial-week-starts-at-full-weeks-plus-1` — The first day of the leftover partial week deposits `full_weeks + 1`, not `full_weeks`, because the Monday deposit equals the 1-indexed week number
- `no-input-validation` — The method assumes `n >= 1` per LeetCode constraints and performs no bounds checking or type validation

