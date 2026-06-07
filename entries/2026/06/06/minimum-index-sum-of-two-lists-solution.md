# File: minimum-index-sum-of-two-lists/solution.py

**Date:** 2026-06-06
**Time:** 17:58

## Purpose

This file solves [LeetCode 599 — Minimum Index Sum of Two Lists](https://leetcode.com/problems/minimum-index-sum-of-two-lists/). Given two lists of restaurant names (unique strings), find the common restaurants where the sum of their indices across both lists is minimized. If multiple restaurants share the same minimum index sum, return all of them.

The file is self-contained: it defines the solution function and its unit tests in a single module, following the project-wide convention across `leetcode-implementations/`.

## Key Components

### `findRestaurant(list1, list2) -> list[str]`

The sole exported function. Contract:

- **Input**: Two lists of unique strings. No duplicates within a single list (guaranteed by the problem).
- **Output**: A list of all common strings whose index sum `i + j` (where `i` is the index in `list1`, `j` in `list2`) equals the global minimum index sum.
- **Time**: O(n + m) where n = len(list1), m = len(list2).
- **Space**: O(n) for the hash map built from `list1`.

### `TestFindRestaurant`

Seven test cases covering: single match, multiple matches with different sums, ties, single-element lists, full overlap, and early termination.

## Patterns

**Index map + single-pass scan**: The function builds a hash map from `list1` (string → index), then scans `list2` once. This avoids an O(n*m) brute-force comparison.

**Early termination optimization** (line 20–21): `if j > min_sum: break`. Once the `list2` index alone exceeds the current best sum, no future element can improve the answer — because `index_map[s]` is non-negative, so `index_map[s] + j >= j > min_sum`. This prunes the tail of `list2` without examining it.

**Greedy result replacement** (lines 22–26): When a strictly better sum is found, the result list is replaced entirely (`result = [s]`). Ties append. This avoids a second pass to filter.

## Dependencies

**Imports**: Only `unittest` from the standard library. No external dependencies.

**Imported by**: The "Imported By" list in the prompt is misleading — it reflects a project-wide cross-reference of test files that import `unittest`, not files that actually import this module. The real consumer is `minimum-index-sum-of-two-lists/test_solution.py`.

## Flow

1. **Build index map**: Enumerate `list1`, storing `{string: index}` in `index_map`. O(n).
2. **Scan `list2`**: For each `(j, s)` in `list2`:
   - **Prune**: If `j > min_sum`, stop — no candidate can beat the current best.
   - **Lookup**: If `s` exists in `index_map`, compute `idx_sum = index_map[s] + j`.
   - **Update**: If `idx_sum < min_sum`, reset result. If `idx_sum == min_sum`, append.
3. **Return** the accumulated result list.

## Invariants

- **`min_sum` is monotonically non-increasing** during the scan — it only decreases or stays the same.
- **`result` always contains exactly the strings matching the current `min_sum`** — it's fully replaced on improvement, appended on tie.
- **The early-exit condition is sound** because `index_map[s] >= 0` for all entries, so `idx_sum >= j`. Once `j > min_sum`, all remaining sums exceed the best.
- **Uniqueness within each list is assumed** — duplicates within `list1` would cause the later index to overwrite the earlier one in the map (harmless for correctness since the problem guarantees uniqueness).

## Error Handling

None. The function trusts its inputs per the LeetCode contract. No validation on empty lists, type checking, or bounds enforcement. If both lists are empty, the function returns `[]` naturally.

## Topics to Explore

- [file] `minimum-index-sum-of-two-lists/plan.md` — The planning doc may explain why this approach was chosen over alternatives (e.g., sorting-based or two-map intersection)
- [file] `minimum-index-sum-of-two-lists/review.md` — Post-implementation review; may flag edge cases or complexity analysis
- [function] `two-sum/solution.py:twoSum` — Same "build a map, scan the other collection" pattern applied to a numeric problem; good comparison point
- [general] `early-termination-in-index-problems` — The `j > min_sum` break is a pattern worth recognizing; it appears in problems where one variable's lower bound lets you prune the search space
- [file] `find-common-characters/solution.py` — Another "find commonalities across collections" problem using a different technique (character frequency intersection)

## Beliefs

- `early-exit-correctness` — The `if j > min_sum: break` on line 20 is correct because all index map values are non-negative, making `idx_sum >= j` an invariant
- `single-pass-after-map` — The algorithm touches each element of `list2` at most once after building the `list1` index map, giving O(n + m) total time
- `result-list-exact` — At every point during execution, `result` contains exactly the set of strings seen so far whose index sum equals the current `min_sum`
- `no-input-validation` — The function performs no validation; it assumes both inputs are non-empty lists of unique strings per the LeetCode contract

