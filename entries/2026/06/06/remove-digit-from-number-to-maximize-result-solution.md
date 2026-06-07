# File: remove-digit-from-number-to-maximize-result/solution.py

**Date:** 2026-06-06
**Time:** 18:45

## Purpose

This file solves [LeetCode 2259 — Remove Digit From Number to Maximize Result](https://leetcode.com/problems/remove-digit-from-number-to-maximize-result/). Given a number as a string and a target digit, it removes exactly one occurrence of that digit to produce the lexicographically largest possible result. It's an O(n) greedy solution.

## Key Components

### `max_number_after_remove_digit(number: str, digit: str) -> str`

The single exported function. Contract:

- **Input**: `number` — a string of digits representing a positive integer; `digit` — a single character that appears at least once in `number`.
- **Output**: The largest possible number string after removing exactly one occurrence of `digit`.
- **Guarantee**: Always removes exactly one occurrence. Never returns the original string unchanged.

## Patterns

**Greedy with fallback.** The algorithm uses a single-pass greedy strategy with two rules:

1. **Early exit (greedy pick):** Scan left-to-right. If a matching digit is immediately followed by a *strictly larger* digit (`number[i + 1] > digit`), remove it and return. Removing a smaller digit that precedes a larger one shifts all subsequent digits left, increasing the number's value at that position.

2. **Fallback (last occurrence):** If no greedy opportunity is found, remove the *last* occurrence of the digit. This is correct because when the digit is always followed by an equal-or-smaller digit (or is at the end), removing the rightmost one preserves the most significant larger digits.

The variable `last` tracks the index of the most recent occurrence seen so far, serving double duty as both the fallback target and an implicit "digit was found" flag.

## Dependencies

**Imports:** None — pure standard Python, no external or stdlib imports.

**Imported by:** The file is imported by its own `test_solution.py`. The "Imported By" list in the prompt is misleading — those hundreds of test files each import their *own* solution module, not this one. Only `remove-digit-from-number-to-maximize-result/test_solution.py` actually imports this file.

## Flow

```
number = "1231", digit = "1"

i=0: ch='1' == '1' → last=0, next char '2' > '1' → return "231"  ✓

number = "551", digit = "5"

i=0: ch='5' == '5' → last=0, next char '5' NOT > '5' → continue
i=1: ch='5' == '5' → last=1, next char '1' NOT > '5' → continue
i=2: ch='1' != '5' → continue
→ fallback: remove index 1 → "51"
```

The key data transformation is string slicing: `number[:i] + number[i + 1:]` removes the character at index `i` by concatenating the prefix and suffix around it.

## Invariants

1. **At least one occurrence exists.** The function assumes `digit` appears in `number`. If it doesn't, `last` remains `-1` and the fallback `number[:-1] + number[0:]` silently truncates the last character — a bug if the precondition is violated.
2. **Greedy correctness.** The first matching digit followed by a larger digit is always the optimal removal point. This holds because removing it causes the larger successor to shift into that position, and no earlier removal could produce a larger result (earlier digits either don't match or are followed by equal/smaller digits).
3. **Fallback correctness.** When no greedy match exists, every occurrence of `digit` is followed by an equal-or-smaller digit (or is at the end). Removing the last occurrence minimizes the damage to high-order positions.

## Error Handling

None. The function has no defensive checks. It trusts the caller to provide valid input per LeetCode's constraints (digit appears in number, number is non-empty, all characters are valid digits). Invalid input produces silently wrong results rather than exceptions.

## Topics to Explore

- [file] `remove-digit-from-number-to-maximize-result/test_solution.py` — See the edge cases tested and verify the greedy/fallback split is covered
- [file] `remove-digit-from-number-to-maximize-result/plan.md` — The planning doc may explain why this greedy approach was chosen over brute-force
- [function] `largest-odd-number-in-string/solution.py:largest_odd_number` — Another greedy string-digit problem with a similar scan-and-slice pattern
- [general] `greedy-digit-removal` — The general technique of removing k digits to maximize/minimize a number (see LeetCode 402 for the k>1 generalization using a monotonic stack)

## Beliefs

- `greedy-early-exit-correctness` — Removing the first occurrence of `digit` that is immediately followed by a strictly larger digit always yields the maximum result
- `fallback-removes-last-occurrence` — When no greedy opportunity exists, the algorithm removes the rightmost occurrence of `digit`, which is optimal when all occurrences are followed by equal-or-smaller digits
- `single-pass-linear-time` — The algorithm runs in O(n) time with O(1) extra space (excluding the output string allocation)
- `no-input-validation` — The function assumes `digit` appears at least once in `number`; violating this precondition causes silent misbehavior via `last = -1`

