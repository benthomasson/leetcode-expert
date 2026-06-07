# File: richest-customer-wealth/solution.py

**Date:** 2026-06-06
**Time:** 18:55

## `richest-customer-wealth/solution.py`

### Purpose

This file solves [LeetCode 1672 — Richest Customer Wealth](https://leetcode.com/problems/richest-customer-wealth/). It owns exactly one responsibility: given a 2D grid of bank account balances, find the customer with the highest total wealth and return that amount.

### Key Components

**`Solution.maximumWealth(self, accounts: List[List[int]]) -> int`** — The sole method. Takes an `m x n` matrix where `accounts[i][j]` represents how much money customer `i` holds in bank `j`. Returns the maximum row-sum across all rows.

The implementation is a single expression: `max(sum(row) for row in accounts)`. It uses a generator expression to lazily compute each customer's total wealth (`sum(row)`), then `max()` selects the largest.

### Patterns

- **One-liner functional style** — No intermediate variables, no explicit loops. The solution chains `max` over a generator of `sum` calls, which is idiomatic Python for "reduce over a map."
- **Standard LeetCode class convention** — Method lives on a `Solution` class with no `__init__`, matching LeetCode's expected interface.

### Dependencies

**Imports:** `typing.List` — used only for the type annotation. At runtime, the code depends on nothing beyond builtins (`max`, `sum`).

**Imported by:** The test file `richest-customer-wealth/test_solution.py` imports this `Solution` class. The massive "Imported By" list in the prompt is misleading — those are test files from *other* problems that happen to share the same `from solution import Solution` pattern, not actual consumers of this specific file.

### Flow

1. The generator `(sum(row) for row in accounts)` iterates over each row (customer).
2. For each row, `sum(row)` computes the total across all banks.
3. `max(...)` consumes the generator and returns the largest total.

No intermediate data structure is allocated — the generator yields one integer at a time.

### Invariants

- `accounts` must be non-empty (at least one customer) — `max()` raises `ValueError` on an empty sequence. LeetCode guarantees `m >= 1`, so this is safe under the problem constraints.
- Each row must be iterable and contain numbers — guaranteed by the problem's `1 <= accounts[i][j] <= 1000` constraint.

### Error Handling

None. The code trusts its caller (LeetCode's judge) to provide valid input. An empty `accounts` list would crash with `ValueError` from `max()`, and non-numeric values would crash inside `sum()`. Both are impossible under the problem constraints.

### Complexity

- **Time:** O(m * n) — every cell is visited exactly once.
- **Space:** O(1) auxiliary — the generator avoids materializing a list of sums.

## Topics to Explore

- [file] `richest-customer-wealth/test_solution.py` — See what edge cases the test suite covers (single customer, single bank, uniform values)
- [file] `richest-customer-wealth/review.md` — The code review may discuss whether the one-liner is preferred over an explicit loop
- [general] `generator-vs-list-comprehension` — Why `max(sum(row) for row in accounts)` uses a generator (no `[]`) and the memory implications for large inputs
- [function] `kids-with-the-greatest-number-of-candies/solution.py:Solution` — Another "max over a list" pattern, worth comparing the structural similarity

## Beliefs

- `max-wealth-is-single-pass` — `maximumWealth` visits each cell exactly once with O(1) auxiliary space, using a generator rather than materializing intermediate results
- `empty-accounts-crashes` — Passing an empty list to `maximumWealth` raises `ValueError` from `max()`; the code does not guard against this because LeetCode guarantees `m >= 1`
- `no-external-dependencies` — The solution uses only Python builtins (`max`, `sum`) at runtime; the `typing.List` import is purely for annotation
- `solution-class-is-stateless` — `Solution` has no instance state; `maximumWealth` is a pure function that could equivalently be a standalone function

