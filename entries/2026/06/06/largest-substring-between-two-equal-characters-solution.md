# File: largest-substring-between-two-equal-characters/solution.py

**Date:** 2026-06-06
**Time:** 17:18

## Purpose

This file solves [LeetCode 1624: Largest Substring Between Two Equal Characters](https://leetcode.com/problems/largest-substring-between-two-equal-characters/). It owns a single responsibility: given a string, find the maximum length of a substring that sits between two occurrences of the same character. If no character appears twice, return `-1`.

## Key Components

### `maxLengthBetweenEqualCharacters(s: str) -> int`

The sole public function. Its contract:

- **Input**: a string `s` of lowercase English letters.
- **Output**: an integer — the length of the longest substring strictly between two equal characters, or `-1` if no character repeats.
- **Side effects**: none. Pure function.

### `first_seen: dict[str, int]`

A lookup table mapping each character to the index where it was **first** encountered. This is the core data structure — by only recording the first occurrence, the algorithm maximizes the gap `i - first_seen[c] - 1` for every subsequent occurrence.

## Patterns

**First-occurrence hash map** — a standard idiom for this class of problem. Rather than comparing all pairs of equal characters (O(n²)), you store only the earliest index per character and compute the distance on every later hit. This is the canonical O(n) approach.

**Running maximum** — `result` accumulates the best answer seen so far via `max()`, so the function needs only a single pass.

**Sentinel initialization** — `result` starts at `-1`, which is both the correct answer for "no duplicates found" and a safe initial value since any valid substring length (≥ 0) will replace it.

## Dependencies

**Imports**: None. The solution uses only Python builtins (`dict`, `enumerate`, `max`).

**Imported by**: The "Imported By" list in the prompt is misleading — it reflects test files across the entire repo that share a common test harness or import pattern, not files that actually call `maxLengthBetweenEqualCharacters`. The real consumer is `largest-substring-between-two-equal-characters/test_solution.py`.

## Flow

1. Initialize `first_seen` (empty dict) and `result` (-1).
2. Iterate over the string with index `i` and character `c`.
3. **If `c` was seen before**: compute the substring length between the first occurrence and the current one (`i - first_seen[c] - 1`). Update `result` if this is larger.
4. **If `c` is new**: record `i` in `first_seen`.
5. Return `result`.

The `-1` in the distance formula excludes the two boundary characters themselves — it counts only what's *between* them.

## Invariants

- `first_seen[c]` is always the **minimum** index at which `c` appears. The `else` branch ensures we never overwrite an earlier index with a later one.
- `result` is monotonically non-decreasing across iterations.
- For any character appearing k times, the algorithm implicitly considers only the pair (first, current) for each visit, which is sufficient because stretching from the first occurrence always yields the longest possible gap.

## Error Handling

There is none — and none is needed. The function handles all edge cases structurally:
- Empty string → loop doesn't execute → returns `-1`.
- All unique characters → `c in first_seen` is never true → returns `-1`.
- Single character → same as all-unique case.

No exceptions are raised or caught.

## Topics to Explore

- [file] `largest-substring-between-two-equal-characters/test_solution.py` — See the test cases and edge cases being validated
- [file] `largest-substring-between-two-equal-characters/plan.md` — The problem decomposition and approach selection before implementation
- [function] `degree-of-an-array/solution.py:findShortestSubArray` — Uses the same first/last-occurrence pattern but tracks both endpoints per value
- [general] `first-occurrence-hashmap-pattern` — This pattern recurs across many solutions in the repo (e.g., contains-duplicate-ii, check-distances-between-same-letters) — worth understanding as a family

## Beliefs

- `first-seen-never-overwritten` — `first_seen[c]` is written exactly once per distinct character; subsequent occurrences of `c` take the `if` branch and never update the stored index.
- `single-pass-linear-time` — The algorithm visits each character exactly once, giving O(n) time and O(k) space where k is the alphabet size (at most 26).
- `minus-one-sentinel-is-dual-purpose` — The initial value `-1` serves both as "no answer found" and as a correct return value, so no post-loop fixup is needed.
- `gap-formula-excludes-endpoints` — The expression `i - first_seen[c] - 1` counts characters strictly between positions `first_seen[c]` and `i`, not including either boundary character.

