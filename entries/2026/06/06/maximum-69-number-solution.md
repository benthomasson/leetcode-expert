# File: maximum-69-number/solution.py

**Date:** 2026-06-06
**Time:** 17:33

## `maximum-69-number/solution.py`

### Purpose

This file solves [LeetCode 1323 — Maximum 69 Number](https://leetcode.com/problems/maximum-69-number/). It provides a single function that, given a positive integer composed only of digits 6 and 9, returns the largest number achievable by changing at most one digit.

### Key Components

**`maximum69Number(num: int) -> int`** — The sole function. It converts the integer to a string, replaces the *first* occurrence of `'6'` with `'9'`, and converts back to int.

### Patterns

**String-as-mutable-proxy**: Python integers are immutable and don't support positional digit access. The solution sidesteps this by round-tripping through `str`, using `str.replace` for the mutation, then casting back with `int()`. This is idiomatic for digit-manipulation problems in Python.

**Greedy leftmost replacement**: `str.replace("6", "9", 1)` targets the leftmost `'6'`. This is correct because flipping the highest-order 6 to a 9 produces the largest possible increase — each position is worth 10x the next, so greedy-left is optimal. If no `'6'` exists (e.g., `9999`), `replace` is a no-op and the original number is returned unchanged.

### Dependencies

**Imports**: None — pure stdlib, no external packages.

**Imported by**: The `"Imported By"` list in the prompt is misleading — those are test files across the entire repo that share a common test harness, not files that actually call `maximum69Number`. The real consumer is `maximum-69-number/test_solution.py`.

### Flow

1. `str(num)` — e.g., `9669` → `"9669"`
2. `.replace("6", "9", 1)` — `"9669"` → `"9969"` (only the first `'6'` at index 1 is replaced)
3. `int(...)` — `"9969"` → `9969`

The entire function is a single expression — no branching, no loops.

### Invariants

- **Input constraint**: `num` consists only of digits 6 and 9. The function doesn't validate this — it relies on the LeetCode contract. If violated (e.g., `num=123`), `replace` would still run but the result wouldn't be meaningful in the problem's domain.
- **At most one change**: The `count=1` argument to `replace` enforces exactly one substitution (or zero if no `'6'` exists).
- **Monotonic improvement**: Changing a 6→9 can only increase the number; changing a 9→6 would decrease it. So the function never considers 9→6.

### Error Handling

None. The function trusts its caller to provide valid input per the LeetCode spec. No exceptions are raised or caught.

## Topics to Explore

- [file] `maximum-69-number/test_solution.py` — See what edge cases are tested (all-9s, single digit, leading 6)
- [file] `maximum-69-number/plan.md` — The approach reasoning before implementation
- [file] `maximum-difference-by-remapping-a-digit/solution.py` — A harder variant: remap *all* occurrences of one digit to another, finding both max and min
- [general] `greedy-digit-manipulation` — Pattern family where the leftmost/rightmost digit choice dominates; compare with `largest-number-after-digit-swaps-by-parity`
- [function] `maximum-69-number/solution.py:maximum69Number` — Try an alternative approach: math-only (find the highest power of 10 where digit is 6, add 3×that power) to avoid string conversion

## Beliefs

- `max69-greedy-leftmost` — Replacing the leftmost 6 with 9 is provably optimal because higher-order digit positions have exponentially greater value
- `max69-no-op-on-all-nines` — When `num` contains no 6s, the function returns the input unchanged with no special-case code
- `max69-single-expression` — The entire solution is a single return expression with no control flow, leveraging `str.replace` count parameter for the "at most one change" constraint
- `max69-no-input-validation` — The function assumes the LeetCode invariant (digits are only 6 or 9) and performs no validation

