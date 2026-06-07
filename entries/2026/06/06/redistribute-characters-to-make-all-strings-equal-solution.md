# File: redistribute-characters-to-make-all-strings-equal/solution.py

**Date:** 2026-06-06
**Time:** 18:41

## Purpose

This file solves [LeetCode 1897: Redistribute Characters to Make All Strings Equal](https://leetcode.com/problems/redistribute-characters-to-make-all-strings-equal/). It determines whether you can redistribute characters freely across all strings in a list so that every string ends up identical. It owns a single pure function with no side effects.

## Key Components

### `redistribute_characters_to_make_all_strings_equal(words: list[str]) -> bool`

The sole public function. Contract: given a list of lowercase English strings, return `True` if and only if the characters can be redistributed so all strings become equal.

The algorithm:
1. Count every character across all strings combined.
2. For all strings to be identical, each character's total count must divide evenly by `n` (the number of strings). If any character has a count that isn't divisible by `n`, redistribution is impossible.

## Patterns

- **Aggregate-then-validate**: accumulate global state (character frequencies), then assert a uniform property over it. This is a common pattern for "can we partition evenly" problems.
- **Counter.update**: builds the frequency map incrementally rather than concatenating all strings first (`Counter("".join(words))` would also work but allocates an intermediate string).

## Dependencies

- **Imports**: `collections.Counter` — standard library, no external deps.
- **Imported by**: `redistribute-characters-to-make-all-strings-equal/test_solution.py` directly. The massive "Imported By" list in the prompt is an artifact of the test harness structure — those other test files don't actually import this function; they share a common test runner pattern.

## Flow

```
words → len(words) = n
      → Counter() accumulates char frequencies across all words
      → all(count % n == 0 for each character count) → bool
```

The entire function is a single pass over all characters (O(total chars)) plus one pass over the counter (O(unique chars)).

## Invariants

- **Divisibility rule**: every character count must be divisible by `n`. This is both necessary and sufficient because the problem allows arbitrary redistribution — you can move any character from any string to any other string.
- **Implicit**: `n >= 1` (LeetCode guarantees `1 <= words.length`), so no division-by-zero risk.

## Error Handling

None — the function trusts its input matches the LeetCode constraint (non-empty list of lowercase strings). No validation, no exceptions. This is appropriate for a contest solution where inputs are guaranteed valid.

## Topics to Explore

- [file] `redistribute-characters-to-make-all-strings-equal/test_solution.py` — See the test cases and edge cases covered
- [file] `redistribute-characters-to-make-all-strings-equal/review.md` — Code review notes on this solution's quality
- [function] `check-if-all-characters-have-equal-number-of-occurrences/solution.py:check_if_all_characters_have_equal_number_of_occurrences` — Related problem: equal frequency within a single string vs. across multiple strings
- [function] `divide-array-into-equal-pairs/solution.py:divide_array_into_equal_pairs` — Same divisibility-check pattern applied to array elements
- [general] `counter-divisibility-pattern` — How the "count % k == 0 for all" idiom recurs across partition/redistribution problems

## Beliefs

- `redistribute-chars-divisibility-is-necessary-and-sufficient` — The check `all(count % n == 0)` is both necessary and sufficient because characters can move freely between any two strings.
- `redistribute-chars-linear-time` — The function runs in O(C) time where C is the total number of characters across all words, plus O(U) for the final check where U is the number of unique characters.
- `redistribute-chars-no-input-validation` — The function performs no input validation and will raise `ZeroDivisionError` if called with an empty list, relying on LeetCode's guarantee that `words` is non-empty.
- `redistribute-chars-counter-update-avoids-concatenation` — Using `Counter.update` in a loop avoids allocating a single concatenated string, keeping peak memory proportional to unique characters rather than total characters.

