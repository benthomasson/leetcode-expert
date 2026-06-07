# File: longest-nice-substring/solution.py

**Date:** 2026-06-06
**Time:** 17:27

## Purpose

This file solves [LeetCode 1763 — Longest Nice Substring](https://leetcode.com/problems/longest-nice-substring/). A "nice" substring is one where every letter that appears also appears in the opposite case (e.g., if `'a'` is present, `'A'` must also be present, and vice versa). The solution finds the longest such substring, returning the earliest one on ties.

## Key Components

### `Solution.longestNiceSubstring(self, s: str) -> str`

The sole method. It uses **divide and conquer**: find a character that violates the "nice" property (its case-swapped counterpart is missing), split on it, and recurse into both halves.

## Patterns

**Divide and conquer via a "bad character" split.** The key insight: if character `c` at index `i` has no case-counterpart anywhere in `s`, then `c` cannot belong to any nice substring of `s`. So any nice substring must lie entirely in `s[:i]` or `s[i+1:]`. This turns a brute-force O(n^3) check into an O(n^2) worst-case recursion (each level scans the string once and splits it).

The pattern resembles quicksort's partitioning — the "bad character" acts as a pivot. Best case is O(n log n) when splits are balanced; worst case is O(n^2) when every split is near one end.

**`set` + `swapcase` for O(1) membership check.** Building `char_set = set(s)` once per recursive call lets each character check its counterpart in constant time.

## Dependencies

**Imports:** None — pure stdlib Python.

**Imported by:** `longest-nice-substring/test_solution.py` directly. The "Imported By" list in the prompt is misleading — those are other problems' test files, likely sharing a common test harness that imports `Solution` generically, not importing this specific file.

## Flow

1. **Base case:** If `len(s) < 2`, no nice substring is possible — return `""`.
2. **Build character set** from the entire current string.
3. **Scan left to right** for the first character whose `swapcase()` is absent from the set.
4. **Split and recurse** on `s[:i]` (left) and `s[i+1:]` (right).
5. **Return the longer result**, preferring `left` on ties (`len(left) >= len(right)`). This ensures the leftmost/earliest substring wins on equal length, matching the problem's tie-breaking rule.
6. **If no bad character found**, the entire string is nice — return `s`.

## Invariants

- **Left-bias on ties:** `left if len(left) >= len(right) else right` — the `>=` ensures the earlier (leftmost) substring wins when lengths are equal, which satisfies the LeetCode constraint to return the earliest one.
- **The split character is excluded from both halves.** `s[:i]` ends before `i`; `s[i+1:]` starts after it. The bad character is provably in no nice substring, so discarding it is safe.
- **Termination:** Each recursive call operates on a strictly shorter string (at least one character is removed), so recursion always terminates.

## Error Handling

None needed — the function handles edge cases structurally. Empty/single-char strings hit the base case. The `for` loop naturally falls through to `return s` when all characters have their counterpart.

## Topics to Explore

- [file] `longest-nice-substring/test_solution.py` — See what edge cases are covered (empty, single char, all-nice, no-nice, ties)
- [file] `longest-nice-substring/plan.md` — Check if alternative approaches (brute force, bitmask) were considered
- [general] `divide-and-conquer-string-problems` — Compare with similar LeetCode split-on-violation patterns (e.g., Strobogrammatic Number, string partitioning)
- [function] `longest-nice-substring/solution.py:longestNiceSubstring` — Profile worst-case behavior on strings like `"aAbBcCdD..."` vs `"abcABC"` to see how split balance affects runtime

## Beliefs

- `nice-substring-left-bias-on-tie` — When left and right recursive results have equal length, the left (earlier) result is returned, satisfying LeetCode's "return the substring that occurs first" requirement.
- `nice-substring-worst-case-quadratic` — The divide-and-conquer approach is O(n^2) worst case when every split produces one empty and one n-1 length partition (analogous to quicksort's worst case).
- `nice-substring-no-imports` — The solution uses only Python builtins (`set`, `str.swapcase`, `enumerate`, `len`) with zero external dependencies.
- `nice-substring-split-correctness` — Splitting on a character with no case-counterpart is sound because that character cannot appear in any nice substring, so the answer must lie entirely in one of the two halves.

