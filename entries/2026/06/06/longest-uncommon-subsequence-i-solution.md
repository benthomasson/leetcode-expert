# File: longest-uncommon-subsequence-i/solution.py

**Date:** 2026-06-06
**Time:** 17:28

## `longest-uncommon-subsequence-i/solution.py`

### Purpose

Solves [LeetCode 521 — Longest Uncommon Subsequence I](https://leetcode.com/problems/longest-uncommon-subsequence-i/). This is one of LeetCode's most famously deceptive problems: it sounds like it requires subsequence enumeration, but the optimal solution is a two-line string comparison.

### Key Components

**`Solution.findLUSlength(a, b) -> int`** — The sole method. Takes two strings and returns the length of their longest uncommon subsequence, or `-1` if none exists.

An "uncommon subsequence" of two strings is a subsequence of one that is *not* a subsequence of the other. The key insight: **any string is a subsequence of itself**. So if `a != b`, the longer string (or either, if equal length) is automatically an uncommon subsequence — no character in the shorter string can "contain" a longer string as a subsequence. If `a == b`, every subsequence of one is also a subsequence of the other, so no uncommon subsequence exists.

### Patterns

**Mathematical reduction over brute force.** The entire problem collapses to an equality check. This is the canonical example of a "trick question" LeetCode problem where the naive approach (enumerate all subsequences, check each) is O(2^n) but the correct approach is O(n) string comparison.

### Dependencies

**Imports:** None — pure Python, no standard library usage.

**Imported by:** `longest-uncommon-subsequence-i/test_solution.py` directly. The massive "Imported By" list in the prompt is misleading — those are unrelated test files that likely share a common test harness or conftest, not actual consumers of this solution.

### Flow

1. Compare `a` and `b` for equality.
2. If equal: return `-1` (no uncommon subsequence exists).
3. If different: return `max(len(a), len(b))` — the longer string itself is the longest uncommon subsequence.

### Invariants

- Inputs are assumed to be lowercase English letter strings (per LeetCode constraints).
- The return value is always either `-1` or a positive integer.
- When `a != b`, the result is at least `max(1, 1) = 1` since LeetCode guarantees non-empty inputs.

### Error Handling

None. The method trusts its caller to provide valid strings, consistent with the LeetCode problem contract.

## Topics to Explore

- [file] `longest-uncommon-subsequence-i/test_solution.py` — See what edge cases the tests cover (equal strings, different lengths, same length but different content)
- [file] `longest-uncommon-subsequence-i/review.md` — The code review may call out the mathematical insight or discuss why brute force is unnecessary
- [general] `subsequence-vs-substring` — Understanding why "longest uncommon subsequence" between two *different* strings is always the longer string itself, not some internal subsequence
- [file] `longest-nice-substring/solution.py` — Another string problem that uses a non-obvious reduction; compare the solution strategies

## Beliefs

- `lus-equal-strings-return-negative-one` — When both input strings are identical, `findLUSlength` returns exactly `-1`
- `lus-different-strings-return-max-length` — When input strings differ, `findLUSlength` returns `max(len(a), len(b))`, never enumerating subsequences
- `lus-no-external-dependencies` — The solution imports nothing and uses only built-in Python string equality and `len()`
- `lus-constant-space` — The algorithm uses O(1) extra space beyond the input strings

