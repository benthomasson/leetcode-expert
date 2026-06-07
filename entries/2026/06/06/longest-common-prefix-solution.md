# File: longest-common-prefix/solution.py

**Date:** 2026-06-06
**Time:** 17:25

## Purpose

This file implements [LeetCode #14 — Longest Common Prefix](https://leetcode.com/problems/longest-common-prefix/). It provides a single function `longest_common_prefix` that finds the longest string prefix shared by all strings in a list. It's one of ~500+ solution modules in the `leetcode-implementations` repo, each owning exactly one problem's solution.

## Key Components

**`longest_common_prefix(strs: list[str]) -> str`** — The sole public function. Contract:
- Input: a list of strings (may be empty, may contain empty strings)
- Output: the longest prefix common to every string in the list, or `""` if none exists
- Pure function, no side effects

## Patterns

**Vertical scanning.** The algorithm uses the first string as a reference and scans character-by-character (vertically across all strings at position `i`), rather than comparing pairs of strings horizontally. This is the optimal approach when one string is much shorter than the others — it terminates as soon as a mismatch or end-of-string is hit, without examining characters past the answer.

**Early return on mismatch.** The inner loop returns immediately on the first character that doesn't match (`s[i] != char`) or when any string is too short (`i >= len(s)`). No unnecessary work after the prefix ends.

**First-element-as-pivot.** `strs[0]` is the reference string. The outer `enumerate` iterates its characters; the inner loop checks all remaining strings against it. This avoids computing `min(len(s) for s in strs)` upfront.

## Dependencies

**Imports:** None — pure stdlib Python with no external dependencies.

**Imported by:** The `test_solution.py` in this directory, plus ~400+ other test files across the repo. The "Imported By" list in the prompt is misleading — those test files don't actually import *this* solution. Each `test_solution.py` imports its own directory's `solution.py`. Only `longest-common-prefix/test_solution.py` imports this file.

## Flow

1. **Empty-list guard** (line 12): if `strs` is empty, return `""` immediately.
2. **Outer loop** (line 14): iterate through each character `char` at index `i` in `strs[0]`.
3. **Inner loop** (line 15): for each remaining string `s` in `strs[1:]`, check two conditions:
   - `i >= len(s)` — string `s` is shorter than the prefix seen so far
   - `s[i] != char` — character mismatch at position `i`
4. **Mismatch return** (line 17): on either condition, return `strs[0][:i]` — the prefix up to but not including position `i`.
5. **Full-match return** (line 19): if the outer loop completes without early return, the entire first string is a prefix of all others — return `strs[0]`.

## Invariants

- At the start of outer loop iteration `i`, all strings in `strs` share `strs[0][:i]` as a prefix.
- The function never indexes out of bounds on any string — the `i >= len(s)` check precedes `s[i]`.
- The returned string is always a prefix of `strs[0]` (either a slice or the whole thing).

## Error Handling

None explicit. The function relies on the caller providing a `list[str]`. If `strs` is empty, it returns `""`. If `strs` contains a single string, the inner loop body never executes, and the full string is returned. No exceptions are raised or caught.

## Topics to Explore

- [file] `longest-common-prefix/test_solution.py` — Edge cases tested: empty list, single string, all-identical strings, no common prefix
- [general] `vertical-vs-horizontal-scanning` — Compare this vertical scan to the alternative horizontal (pairwise reduction) approach and when each is faster
- [general] `trie-based-lcp` — How a trie data structure solves LCP and when it outperforms linear scanning (e.g., repeated queries over the same string set)
- [function] `longest-common-prefix/solution.py:longest_common_prefix` — Walk through the `strs[1:]` slice on each inner iteration — it allocates a new list each time; a `range(1, len(strs))` index loop would avoid that

## Beliefs

- `lcp-vertical-scan` — The algorithm scans characters column-by-column across all strings (vertical scanning), not by comparing pairs of strings sequentially
- `lcp-worst-case-complexity` — Worst-case time is O(S) where S is the sum of all characters in all strings, achieved when all strings are identical
- `lcp-early-termination` — The function terminates as soon as any single string diverges or ends, never examining characters past the common prefix length
- `lcp-empty-input-returns-empty` — An empty input list returns `""` without accessing any element

