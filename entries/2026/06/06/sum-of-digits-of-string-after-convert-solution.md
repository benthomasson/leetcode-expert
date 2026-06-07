# File: sum-of-digits-of-string-after-convert/solution.py

**Date:** 2026-06-06
**Time:** 19:22

## `sum-of-digits-of-string-after-convert/solution.py`

### Purpose

This file implements LeetCode problem 1945: *Sum of Digits of String After Convert*. It owns the complete solution and its test suite in a single module — consistent with the repo's convention of co-locating solution and tests per problem directory.

The problem: given a lowercase string `s`, replace each letter with its 1-indexed alphabet position (a=1, ..., z=26), concatenate those numbers into a single numeric string, then repeatedly sum that string's digits `k` times. Return the final integer.

### Key Components

**`Solution.getLucky(self, s: str, k: int) -> int`** — The core algorithm. Contract:
- `s` contains only lowercase English letters.
- `k >= 1` (at least one digit-sum transform is always applied).
- Returns a non-negative integer.

**`TestGetLucky`** — Seven unit tests covering LeetCode's three examples, single-character edge cases (`'a'` and `'z'`), a repeated-character case (`'zzzz'`), and a convergence test with high `k`.

### Flow

The algorithm has two phases:

1. **Convert** (line 14): Each character maps to its alphabet position via `ord(c) - ord('a') + 1`, producing strings like `"26"` for `'z'`. These are concatenated — not summed — so `"zbax"` becomes `"2621124"`, not `[26, 2, 1, 24]`.

2. **Transform** (lines 15–17): The first digit-sum happens immediately on `num_str` (line 15). The remaining `k - 1` transforms loop over the digits of the running `result` integer. This split avoids converting back to string unnecessarily on the first pass — `num_str` is already a string, so summing its digits directly is natural.

After a single digit-sum, the result is at most `9 * len(num_str)`. For the maximum input (1000 characters of `'z'`), `num_str` has 2000 digits, so the first sum is at most 18,000 — a 5-digit number. The second sum is at most 45. By the third iteration the value is a single digit and stays fixed, which is why `test_high_k` with `k=10` works correctly.

### Patterns

- **Single-file solution+test**: Every problem directory follows this layout. The `if __name__ == "__main__"` guard lets each file run standalone via `python solution.py`.
- **Generator-based digit summing**: `sum(int(d) for d in str(result))` is the idiomatic Python pattern for digit summation — no modular arithmetic needed.
- **First-pass special casing**: The initial conversion result is a string (not an int), so the first digit-sum is computed separately from the loop that operates on `int → str → sum`.

### Dependencies

**Imports**: Only `unittest` from stdlib — no external dependencies.

**Imported by**: The `test_solution.py` files listed in the context don't actually import this file — they're test files for *other* problems that happen to share the same structural pattern. The `sum-of-digits-of-string-after-convert/test_solution.py` is the one that tests this code (likely importing `Solution` from it).

### Invariants

- `k >= 1` is assumed — the code always performs at least one digit-sum (line 15), then loops `k - 1` more times. Passing `k=0` would still execute one sum, which would violate the problem spec if taken literally.
- The input string contains only lowercase `a`–`z`. The `ord(c) - ord('a') + 1` mapping produces values 1–26; any other character would produce incorrect or negative values silently.
- After any digit-sum pass, `result` is a non-negative integer, so `str(result)` is always a valid digit string (no sign character to worry about).

### Error Handling

None. The code trusts its inputs per LeetCode convention — no validation, no exceptions. Invalid input (empty string, uppercase, non-alpha) produces silently wrong results rather than errors.

## Topics to Explore

- [file] `add-digits/solution.py` — Same digit-sum-until-convergence pattern; likely uses the digital root formula `1 + (n-1) % 9` as an O(1) shortcut
- [file] `calculate-digit-sum-of-a-string/solution.py` — Related problem that groups digits before summing; compare the chunking approach
- [file] `difference-between-element-sum-and-digit-sum-of-an-array/solution.py` — Another digit-extraction problem; see if it uses the same `int(d) for d in str(n)` idiom
- [general] `digital-root-convergence` — Why repeated digit sums always converge to a single digit (the digital root), and when the closed-form `1 + (n-1) % 9` applies vs. when you must iterate
- [function] `sum-of-digits-of-string-after-convert/solution.py:getLucky` — Trace through with `s="leetcode", k=2` to see how the two-phase structure works end-to-end

## Beliefs

- `first-sum-on-string` — `getLucky` computes the first digit-sum directly from the concatenated numeric string, avoiding an intermediate conversion to `int` (which could be thousands of digits long)
- `k-minus-one-loop` — The `for` loop runs `k - 1` iterations, not `k`, because the initial sum on `num_str` counts as the first transform
- `convergence-by-k3` — For any valid input (up to 1000 lowercase letters), the result stabilizes to a single digit by the third transform at most, making large `k` values effectively no-ops after that point
- `no-input-validation` — The function assumes `s` contains only `a`–`z` and `k >= 1`; violating either produces silently wrong results, not errors
- `ord-offset-mapping` — Letter-to-position mapping uses `ord(c) - ord('a') + 1`, producing multi-character strings for letters j–z (positions 10–26), which is why the concatenation step is necessary rather than simple per-character digit extraction

