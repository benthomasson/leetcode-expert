# File: add-digits/solution.py

**Date:** 2026-06-06
**Time:** 15:12

## `add-digits/solution.py`

### Purpose

This file solves [LeetCode 258 — Add Digits](https://leetcode.com/problems/add-digits/). It computes the **digital root** of a non-negative integer: the single digit obtained by repeatedly summing all digits until only one digit remains. For example, `38 → 3+8=11 → 1+1=2`.

### Key Components

**`Solution.addDigits(self, num: int) -> int`** — The sole method. Takes a non-negative integer and returns its digital root (always 0–9).

### Patterns

The solution uses the **O(1) digital root formula** rather than iteratively summing digits:

```
digital_root(0) = 0
digital_root(n) = 1 + (n - 1) % 9   for n > 0
```

This is a well-known number theory result. The digital root of any positive integer is its value modulo 9, except when the result would be 0 (i.e., multiples of 9), where the answer is 9 instead. The expression `1 + (n - 1) % 9` encodes both cases in a single formula by shifting the modular arithmetic: it maps `n=9` to `9`, `n=18` to `9`, `n=1` to `1`, etc.

The naive approach — a loop that sums digits until `num < 10` — would be O(log n) per iteration with O(log log n) iterations. This formula eliminates all iteration.

### Dependencies

**Imports**: None. Pure computation with no library dependencies.

**Imported by**: The `test_solution.py` files listed in the "Imported By" section are a red herring — those are other problems' test files that happen to share a common test harness pattern (importing a `Solution` class from a sibling `solution.py`), not actual consumers of this specific `addDigits` method.

The real consumer is `add-digits/test_solution.py`.

### Flow

1. Guard: if `num == 0`, return `0` immediately.
2. Otherwise, compute and return `1 + (num - 1) % 9`.

No loops, no recursion, no mutation. Single-expression return for the non-zero case.

### Invariants

- **Input**: `num >= 0` (per LeetCode constraints). The code does not validate this — negative inputs would produce incorrect results since Python's `%` operator returns non-negative results for positive divisors, but `(negative - 1) % 9` would still be wrong semantically.
- **Output**: Always in `[0, 9]`. The modulo operation guarantees the result is in `[0, 8]`, and adding 1 shifts it to `[1, 9]`. The explicit zero-check covers the remaining case.

### Error Handling

None. The method assumes valid input per the LeetCode contract. No exceptions are raised or caught.

## Topics to Explore

- [file] `add-digits/test_solution.py` — See what edge cases the tests cover (0, single digits, large numbers, multiples of 9)
- [file] `add-digits/plan.md` — Check whether the plan considered the iterative approach vs. the formula
- [general] `digital-root-number-theory` — The mathematical proof that `1 + (n-1) % 9` equals repeated digit summation, rooted in the fact that 10 ≡ 1 (mod 9)
- [function] `sum-of-digits-of-string-after-convert/solution.py:Solution` — A related problem that also performs digit summation, likely using the iterative approach since it has a fixed iteration count

## Beliefs

- `add-digits-constant-time` — `addDigits` runs in O(1) time and space with no loops or recursion
- `add-digits-zero-special-case` — The explicit `num == 0` check is necessary because the formula `1 + (n-1) % 9` would return `9` for `num=0` (since `(-1) % 9 == 8` in Python)
- `add-digits-output-range` — The return value is always in the range [0, 9] for any non-negative input
- `add-digits-no-dependencies` — The solution uses no imports and depends only on Python's built-in integer arithmetic

