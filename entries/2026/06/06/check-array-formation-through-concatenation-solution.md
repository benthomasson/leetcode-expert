# File: check-array-formation-through-concatenation/solution.py

**Date:** 2026-06-06
**Time:** 15:34

## Purpose

This file solves [LeetCode 1640: Check Array Formation Through Concatenation](https://leetcode.com/problems/check-array-formation-through-concatenation/). It determines whether a target array `arr` can be reconstructed by concatenating sub-arrays from `pieces` in some order, without reordering elements within any piece.

It's a standalone solution module following the repo's convention: one `solution.py` per problem directory, exporting a single function.

## Key Components

### `canFormArray(arr, pieces) -> bool`

The only public function. It checks whether `arr` can be formed by concatenating elements of `pieces` in some order.

**Contract:**
- `arr` contains distinct integers (problem guarantee)
- Each sub-array in `pieces` contains distinct integers
- Elements across all `pieces` are distinct
- Returns `True` if some ordering of `pieces` concatenates to exactly `arr`

## Patterns

**Hash-map lookup by first element.** The solution exploits the distinctness constraint: since all integers across `pieces` are unique, each piece can be uniquely identified by its first element. Line 13 builds `lookup = {p[0]: p for p in pieces}` — a dict mapping each piece's leading value to the full piece. This turns what could be an O(n*m) search into O(1) per position.

**Greedy linear scan.** The `while` loop (lines 14-20) walks `arr` left-to-right with index `i`. At each position, it finds the piece that must start here (via `lookup.get(arr[i])`), then verifies the entire piece matches the corresponding slice of `arr` element-by-element, advancing `i` as it goes. If it reaches the end, the formation is valid.

## Dependencies

**Imports:** None — pure stdlib Python using only built-in types (`list`, `dict`).

**Imported by:** The `test_solution.py` in the same directory. The "Imported By" list in the prompt is misleading — those are test files for *other* problems, likely an artifact of the repo's test infrastructure sharing a common runner, not actual imports of this function.

## Flow

1. **Index pieces** — Build `{first_element: piece}` mapping. O(total elements in pieces).
2. **Walk `arr`** — For each position `i`:
   - Look up `arr[i]` in the map. If missing → `False` (no piece starts with this value).
   - Iterate through the matched piece, comparing each value against `arr[i]`, `arr[i+1]`, etc. If any mismatch or `arr` runs out before the piece does → `False`.
   - Advance `i` past the entire matched piece.
3. **Return `True`** if `i` reaches `len(arr)`.

**Time complexity:** O(n) where n = len(arr). Each element is visited exactly once. Building the lookup is O(sum of piece lengths), which is at most O(n).

**Space complexity:** O(n) for the lookup dict.

## Invariants

- **Distinctness is load-bearing.** The `{p[0]: p}` dict construction assumes no two pieces share a first element. If they did, one would silently overwrite the other. The problem guarantees this.
- **Full coverage required.** The algorithm doesn't explicitly check that all pieces are used, but it doesn't need to — if `arr` is fully consumed by matched pieces and each piece matches a contiguous slice, the formation is valid. Unused pieces are implicitly fine (the problem allows using a subset? Actually no — but since all piece elements are distinct subsets of `arr`, full traversal of `arr` implies all pieces were consumed).
- **Order within pieces is fixed.** The inner `for val in piece` loop enforces that elements within each piece appear in their original order.

## Error Handling

No exceptions are raised. The function communicates failure solely through its `False` return value, triggered by two conditions:
1. `piece is None` (line 16) — `arr[i]` doesn't match any piece's first element.
2. `arr[i] != val` or `i >= len(arr)` (line 19) — a matched piece doesn't align with the corresponding slice of `arr`.

The bounds check `i >= len(arr)` on line 19 prevents index-out-of-range when a piece extends beyond `arr`'s length.

## Topics to Explore

- [file] `check-array-formation-through-concatenation/test_solution.py` — See what edge cases are tested (empty pieces, single-element arrays, mismatched orderings)
- [file] `check-array-formation-through-concatenation/review.md` — The code review may note alternative approaches or complexity analysis
- [general] `first-element-keyed-lookup` — This pattern (indexing by a unique leading element) recurs in problems with distinctness constraints; compare with `destination-city` which uses a similar set-based approach
- [function] `make-two-arrays-equal-by-reversing-subarrays/solution.py:canBeEqual` — A related "can you rearrange pieces to match" problem, but with different constraints on reordering

## Beliefs

- `canformarray-linear-time` — `canFormArray` runs in O(n) time where n is the length of `arr`, visiting each element exactly once
- `distinctness-required-for-correctness` — The lookup-by-first-element strategy is only correct because the problem guarantees all integers across all pieces are distinct
- `no-piece-usage-validation` — The function does not explicitly verify that every piece in `pieces` was used; correctness relies on the problem's guarantee that piece elements are a subset of `arr`
- `bounds-check-before-comparison` — The inner loop checks `i >= len(arr)` before `arr[i] != val` to prevent an out-of-bounds access when a piece would extend past the end of `arr`

