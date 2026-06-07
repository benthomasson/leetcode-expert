# File: maximum-difference-by-remapping-a-digit/solution.py

**Date:** 2026-06-06
**Time:** 17:37

## Purpose

This file is a self-contained LeetCode solution for [LeetCode 2566: Maximum Difference by Remapping a Digit](https://leetcode.com/problems/maximum-difference-by-remapping-a-digit/). It owns both the algorithm (`diffMaxMin`) and its test suite (`TestDiffMaxMin`). The problem asks: given an integer, you can pick one digit and remap all its occurrences to any other digit (once to maximize, once to minimize). Return the difference between the max and min achievable values.

## Key Components

### `diffMaxMin(num: int) -> int`

The sole algorithmic function. Contract:

- **Input**: A positive integer `1 <= num <= 10^8`.
- **Output**: The difference between the largest and smallest values obtainable by remapping all occurrences of a single chosen digit.
- **No mutation**: Pure function, no side effects.

### `TestDiffMaxMin`

Nine unit tests covering LeetCode examples, edge cases (single digit, all-9s, all-same digits, `1`, upper constraint `10^8`).

## Patterns

**Greedy digit selection via string replacement.** The algorithm converts the number to a string, then uses `str.replace` to simulate digit remapping. Two greedy choices:

1. **Maximize**: Find the first digit that isn't `9` and remap all its occurrences to `9`. If the number is already all 9s, `max_val` stays as `num`.
2. **Minimize**: Always remap the leading digit (`s[0]`) to `0`. This works because leading zeros are allowed in the "remapped" value (they collapse via `int()`), and remapping the leading digit guarantees the largest positional drop.

**Self-contained module pattern**: Solution + tests in one file, runnable via `python solution.py` or a test runner.

## Dependencies

- **Imports**: Only `unittest` from the standard library. No external dependencies.
- **Imported by**: The `test_solution.py` files listed in the "Imported By" section are spurious — they likely import from their *own* `solution.py`, not this one. The one real dependent is `maximum-difference-by-remapping-a-digit/test_solution.py`.

## Flow

1. Convert `num` to string `s`.
2. **Max path**: Iterate through digits of `s`. On the first non-`9` digit `d`, replace all occurrences of `d` with `'9'` and parse back to int. If all digits are 9, skip (max_val remains `num`).
3. **Min path**: Replace all occurrences of `s[0]` with `'0'`, parse to int. Leading zeros vanish naturally via `int()`.
4. Return `max_val - min_val`.

For `num = 11891`: max remaps `1→9` → `99899`, min remaps `1→0` → `890`. Result: `99009`.

## Invariants

- `max_val >= num`: remapping a non-9 digit to 9 can only increase or maintain the value.
- `min_val <= num`: remapping the leading digit to 0 can only decrease or maintain the value.
- `min_val >= 0`: the smallest possible result is 0 (all digits become 0).
- The `break` on line 19 ensures only the *first* non-9 digit is chosen for remapping — this is optimal because the first such digit occupies the highest place value.

## Error Handling

None. The function trusts the caller to provide a valid positive integer per the LeetCode constraint. No input validation, no exceptions. `int()` on a string of all zeros returns `0`, which is the correct behavior for the min case.

## Topics to Explore

- [file] `maximum-difference-by-remapping-a-digit/plan.md` — Planning notes that may reveal alternative approaches considered
- [file] `maximum-difference-by-remapping-a-digit/review.md` — Code review notes covering correctness and edge cases
- [function] `maximum-69-number/solution.py:diffMaxMin` — A closely related problem (remap exactly one digit of 6/9) that uses the same greedy "first non-optimal digit" strategy
- [general] `str-replace-digit-remapping` — The `str.replace` idiom for digit remapping appears across several solutions in this repo (e.g., `maximum-69-number`); understanding its limits (it replaces *all* occurrences) is key
- [file] `maximum-difference-by-remapping-a-digit/test_solution.py` — The external test file that imports this solution

## Beliefs

- `max-remap-first-non-nine` — The max value is always achieved by remapping the leftmost non-9 digit to 9, because that digit has the highest positional weight among improvable digits.
- `min-remap-always-leading-digit` — The min value is always achieved by remapping `s[0]` to 0, regardless of what `s[0]` is — if `s[0]` is already 0 (impossible since `num >= 1`), min_val equals num.
- `all-nines-max-unchanged` — When all digits are 9, the `for/break` loop completes without entering the `if` body, so `max_val` remains equal to `num`.
- `str-replace-replaces-all-occurrences` — `str.replace(d, '9')` remaps *every* occurrence of digit `d`, not just the first — this matches the problem's "remap a digit" semantics where choosing digit `d` affects all positions.
- `leading-zero-collapse` — `int(s.replace(s[0], '0'))` correctly handles leading zeros because Python's `int()` ignores them, producing the intended minimized value.

