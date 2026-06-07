# File: count-substrings-with-only-one-distinct-letter/solution.py

**Date:** 2026-06-06
**Time:** 16:04

## `count-substrings-with-only-one-distinct-letter/solution.py`

### Purpose

This file solves [LeetCode 1180 — Count Substrings with Only One Distinct Letter](https://leetcode.com/problems/count-substrings-with-only-one-distinct-letter/). Given a string of lowercase letters, it counts how many substrings contain exactly one distinct character. For example, `"aaabb"` yields 9: `a, a, a, aa, aa, aaa, b, b, bb`.

It's a standalone solution module following the repo's convention of one problem per directory.

### Key Components

**`count_letters(s: str) -> int`** — The sole public function. Takes a string, returns an integer count. The contract is straightforward: any string of lowercase English letters in, total count of single-character substrings out.

### Patterns

The solution uses a **run-length grouping** pattern with a two-pointer/counter approach:

1. Walk through `s` with an outer index `i`.
2. For each position, expand `count` while the next character matches `s[i]`.
3. Apply the closed-form formula `n*(n+1)/2` to get the number of substrings from a run of `n` identical characters. This is the triangular number — every contiguous sub-run of length 1 through `n` is a valid substring.
4. Advance `i` past the entire run.

This avoids the naive O(n^2) enumeration. The while-loop pair gives O(n) time since each character is visited exactly once by the inner loop across the entire execution.

### Dependencies

**Imports:** None. Pure Python, no standard library or third-party dependencies.

**Imported by:** The `test_solution.py` in the same directory, plus ~400+ test files across the repo. The massive "Imported By" list is likely an artifact of a shared test harness or test runner that imports all solution modules, not an indication that other solutions depend on `count_letters` functionally.

### Flow

```
s = "aaabb"

i=0: count=3 (a,a,a match) → result += 3*4//2 = 6 → i jumps to 3
i=3: count=2 (b,b match)   → result += 2*3//2 = 3 → i jumps to 5
i=5: loop ends → return 9
```

The outer `while` advances `i` by `count` each iteration, so the two loops together make exactly one pass over the string.

### Invariants

- `i` always points to the start of an unexplored run. After processing, `i += count` guarantees no character is visited twice.
- `count` is always ≥ 1 (initialized to 1 before the inner loop), so the triangular number formula always contributes at least 1.
- The formula `count * (count + 1) // 2` is exact — integer division is safe because one of `count` or `count+1` is always even.

### Error Handling

None. An empty string causes the outer `while` to never execute, returning 0 — which is the correct answer. No input validation is performed; the function trusts the caller to provide a valid lowercase string per the LeetCode contract.

## Topics to Explore

- [file] `count-substrings-with-only-one-distinct-letter/test_solution.py` — See what edge cases are tested (empty string, single char, all identical, alternating)
- [function] `consecutive-characters/solution.py:maxPower` — A closely related problem that finds the *longest* run rather than summing triangular numbers over all runs
- [function] `count-binary-substrings/solution.py:countBinarySubstrings` — Another run-length problem where adjacent group sizes interact
- [file] `positions-of-large-groups/solution.py` — Uses the same run-length grouping pattern but collects group boundaries instead of counting substrings

## Beliefs

- `count-letters-linear-time` — `count_letters` runs in O(n) time because each character is consumed by exactly one iteration of the inner while loop across the entire execution
- `triangular-number-correctness` — A run of `n` identical characters contributes exactly `n*(n+1)/2` single-character substrings, covering all sub-runs of length 1 through n
- `count-letters-no-dependencies` — The solution module has zero imports and depends only on Python built-in operators
- `empty-string-returns-zero` — `count_letters("")` returns 0 without any special-case code, handled implicitly by the outer while-loop guard

