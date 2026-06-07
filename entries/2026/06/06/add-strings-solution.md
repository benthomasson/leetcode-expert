# File: add-strings/solution.py

**Date:** 2026-06-06
**Time:** 15:12

## `add-strings/solution.py`

### Purpose

This file solves [LeetCode 415: Add Strings](https://leetcode.com/problems/add-strings/). It implements arbitrary-precision addition of two non-negative integers represented as strings, without converting them to integers or using built-in big-integer libraries. This is the kind of constraint you'd see in an interview — the point is to simulate grade-school column addition manually.

### Key Components

**`Solution.addStrings(num1: str, num2: str) -> str`** — The only method. Takes two digit strings, returns their sum as a digit string. No mutation of inputs.

### Flow

The algorithm walks both strings from right to left (least significant digit first), exactly like you'd add numbers by hand:

1. **Initialize** two pointers `i`, `j` at the last index of each string, plus a `carry` accumulator.
2. **Loop** while there are digits remaining in either string OR there's a carry to propagate.
3. **Extract digits** using `ord(char) - 48` — converting ASCII to integer without `int()`. If a pointer has gone past the beginning of its string, that digit is 0.
4. **Compute** `total = d1 + d2 + carry`, then `divmod(total, 10)` splits it into the new carry and the current digit.
5. **Append** the digit (converted back via `chr(digit + 48)`) to a result list.
6. **Reverse** the result list at the end, since digits were accumulated in reverse order.

### Patterns

- **Two-pointer from the tail**: A standard idiom for processing aligned sequences of different lengths. The `if i >= 0 else 0` guards handle length mismatch without padding.
- **ASCII arithmetic instead of `int()`/`str()`**: Uses `ord() - 48` and `chr() + 48` to convert between characters and digit values. This avoids `int()` entirely — possibly to satisfy the problem's constraint against built-in integer conversion, or simply for speed.
- **Reverse-at-end accumulation**: Appending to a list and reversing once is O(n), versus prepending which would be O(n^2) with a list.

### Dependencies

**Imports**: None. Pure standard library, no external dependencies.

**Imported by**: The "Imported By" list in the prompt is misleading — those are test files across the entire repo that happen to follow a common import pattern. The actual consumer is `add-strings/test_solution.py`, which tests this solution. The rest are unrelated test files that import their own respective solutions.

### Invariants

- Inputs are assumed to be valid non-negative integer strings (no sign, no leading zeros except `"0"` itself). The code does no validation.
- The loop termination condition `while i >= 0 or j >= 0 or carry` guarantees that a final carry (e.g., `"999" + "1" = "1000"`) is always emitted. Without the `or carry` clause, results like `"1000"` would be truncated to `"000"`.
- `divmod(total, 10)` ensures `carry` is always 0 or 1 and `digit` is always 0–9, since the maximum value of `total` is 9 + 9 + 1 = 19.

### Error Handling

None. The code assumes well-formed input per the LeetCode contract. Passing non-digit characters, empty strings, or negative numbers would produce garbage or crash on index access.

## Topics to Explore

- [file] `add-strings/test_solution.py` — See what edge cases are tested (empty strings, carry chains, unequal lengths)
- [file] `add-to-array-form-of-integer/solution.py` — A related problem that adds an integer to an array-form number; likely uses a similar carry-propagation pattern
- [general] `ascii-arithmetic-pattern` — Several solutions in this repo may use `ord()`/`chr()` instead of `int()`/`str()` for digit conversion; worth checking if this is a codebase-wide convention
- [file] `add-digits/solution.py` — Another digit-manipulation problem; compare the approach to see if digit extraction differs
- [general] `reverse-accumulation-vs-deque` — Whether any solutions use `collections.deque.appendleft()` instead of list-reverse for building results right-to-left

## Beliefs

- `add-strings-no-int-conversion` — `addStrings` converts digits using `ord()/chr()` arithmetic and never calls `int()` or `str()` on digit characters
- `add-strings-carry-propagation` — The loop continues after both strings are exhausted if `carry > 0`, ensuring results like `"999" + "1" = "1000"` are correct
- `add-strings-linear-time` — The algorithm runs in O(max(len(num1), len(num2))) time with a single pass and a single reversal
- `add-strings-no-input-validation` — No validation is performed on inputs; non-digit characters or empty strings would produce incorrect results silently

