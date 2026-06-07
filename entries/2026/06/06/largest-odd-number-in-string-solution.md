# File: largest-odd-number-in-string/solution.py

**Date:** 2026-06-06
**Time:** 17:16

## Purpose

This file solves [LeetCode 1903 — Largest Odd Number in String](https://leetcode.com/problems/largest-odd-number-in-string/). It contains both the solution function and its unit tests in a single module. The responsibility is narrow: given a numeric string, find the largest-valued substring that represents an odd number.

## Key Components

### `largest_odd_number(num: str) -> str`

The core solver. Takes a string of digit characters (no leading zeros) and returns the largest odd-valued substring, or `""` if none exists.

The key insight is that any prefix `num[:k]` is larger than any shorter prefix `num[:j]` where `j < k`, because `num` has no leading zeros. So the largest odd substring is always the longest one — which means we just need to find the rightmost odd digit and return everything up to and including it.

### `TestLargestOddNumber`

Nine test cases covering:
- Odd digit only at the start (`"52"` → `"5"`)
- All even digits (`"4206"` → `""`)
- Last digit odd — entire string returned (`"35427"`)
- Single-character strings (odd and even)
- Odd digit in the middle (`"1234"` → `"123"`)
- All odd digits
- Stress: 100k-character all-even string
- Stress: 100k characters with a single odd digit at the end

## Patterns

**Right-to-left scan.** The loop iterates from the last index toward index 0. This is the natural direction because we want the rightmost odd digit — the first match is the answer and we return immediately. No need to track a "best so far."

**Early return.** The function returns as soon as it finds the first odd digit from the right. The fallback `return ""` at the end handles the all-even case.

**Oddness check via modular arithmetic.** `int(num[i]) % 2 == 1` converts a single character to int and checks parity. This works because the oddness of a number is determined solely by its last digit, and here each character is a single digit.

## Dependencies

**Imports:** Only `unittest` from the standard library — no external dependencies.

**Imported by:** The "Imported By" list in the prompt is misleading — it lists hundreds of unrelated test files. This is likely an artifact of a bulk import-scanning tool picking up `unittest` usage across the repo. The actual solution function is self-contained and not imported by other solutions.

## Flow

1. Start at the last character of `num` (index `len(num) - 1`).
2. Walk left one character at a time.
3. At each position, check if the digit is odd.
4. On the first odd digit found, return the prefix `num[:i+1]` — this is the longest (and therefore largest) substring ending in an odd digit.
5. If the loop completes without finding an odd digit, return `""`.

The time complexity is O(n) in the worst case (all even digits), O(1) best case (last digit is odd). Space is O(1) beyond the returned slice (which in Python is a new string, so O(n) for the output).

## Invariants

- **No leading zeros assumption.** The problem guarantees `num` has no leading zeros, which is why the longest prefix ending at an odd digit is always the largest odd substring. If leading zeros were possible, `"052"` would need different handling.
- **Digit-only input.** The function assumes every character in `num` is `'0'`–`'9'`. No validation is performed.
- **Non-empty input.** The function works on empty strings (returns `""` via the fallback), but the LeetCode constraint guarantees `len(num) >= 1`.

## Error Handling

None. The function trusts its input per the problem constraints. Passing non-digit characters would cause `int()` to raise `ValueError`. Passing `None` would raise `TypeError` on `len()`. This is appropriate for a LeetCode solution where input is guaranteed well-formed.

## Topics to Explore

- [file] `largest-odd-number-in-string/plan.md` — The solution strategy and any alternative approaches considered before implementation
- [file] `largest-odd-number-in-string/review.md` — Post-implementation review notes, likely covering correctness and complexity analysis
- [function] `largest-odd-number-in-string/test_solution.py:TestLargestOddNumber` — The separate test file may contain additional edge cases beyond the inline tests
- [general] `right-to-left-scan-pattern` — Other solutions in this repo that use right-to-left string scanning (e.g., `remove-digit-from-number-to-maximize-result`) to compare idioms
- [general] `greedy-string-prefix-problems` — Related LeetCode problems where the answer is a prefix/suffix of the input, using the same "find the boundary" technique

## Beliefs

- `rightmost-odd-digit-determines-answer` — The largest odd substring is always `num[:k+1]` where `k` is the index of the rightmost odd digit, because longer prefixes are numerically larger and the no-leading-zeros constraint ensures they're valid
- `linear-worst-case-constant-best-case` — The function runs in O(n) worst case (all even digits) and O(1) best case (last digit is odd), with a single pass and no auxiliary data structures
- `empty-string-signals-no-odd-substring` — The function returns `""` (not `None` or `-1`) when no odd digit exists, matching the LeetCode contract
- `no-input-validation` — The function performs no validation on `num` — it assumes digit-only, non-empty, no-leading-zeros input per the problem constraints

