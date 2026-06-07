# File: intersection-of-two-arrays-ii/solution.py

**Date:** 2026-06-06
**Time:** 17:06

## `intersection-of-two-arrays-ii/solution.py`

### Purpose

Solves [LeetCode 350 — Intersection of Two Arrays II](https://leetcode.com/problems/intersection-of-two-arrays-ii/). Unlike the simpler "Intersection of Two Arrays" (problem 349) which returns distinct common elements, this variant preserves duplicate counts: if `1` appears three times in `nums1` and twice in `nums2`, the result includes `1` twice.

### Key Components

**`intersect(nums1, nums2) -> list[int]`** — The sole public function. Takes two integer lists, returns their multiset intersection.

Contract: each element in the output appears exactly `min(count_in_nums1, count_in_nums2)` times. Output order follows `nums2`'s iteration order.

### Patterns

**Counter-decrement pattern.** Rather than building two Counters and taking the minimum (which `Counter.__and__` supports), this builds a single Counter from `nums1`, then walks `nums2` while decrementing counts. This is a streaming consumption pattern — it processes `nums2` in one pass without materializing a second frequency map.

This is idiomatic for the follow-up question LeetCode poses: "What if `nums2` is streamed from disk?" Only `nums1` needs to fit in memory; `nums2` can be read element-by-element.

### Dependencies

**Imports:** `collections.Counter` — used to build the frequency map of `nums1`.

**Imported by:** `intersection-of-two-arrays-ii/test_solution.py`. The long "Imported By" list in the prompt is misleading — those are test files across the entire repo that happen to import `Counter` from `collections`, not files that import this solution.

### Flow

1. Build a `Counter` from `nums1` — O(n) time, O(n) space where n = len(nums1).
2. Iterate `nums2`. For each element, check if the counter has remaining capacity (`counts[num] > 0`). If yes, append to result and decrement. If no, skip.
3. Return `result`.

Total: O(n + m) time, O(min(n, m)) space for the result (though the counter always uses O(n) — an optimization would be to always counter the smaller array).

### Invariants

- **Count conservation:** `counts[num]` can never go negative. The `> 0` guard ensures each element is consumed at most as many times as it appeared in `nums1`.
- **No sorting required.** Works on unsorted input, unlike the two-pointer alternative which requires O(n log n + m log m) sorting.
- **`Counter` default behavior:** `Counter` returns `0` for missing keys (not `KeyError`), so the `counts[num] > 0` check handles elements in `nums2` that don't exist in `nums1` without explicit membership testing.

### Error Handling

None. The function trusts its inputs are lists of integers per the LeetCode contract. Empty lists produce an empty result naturally — the Counter is empty or the loop has nothing to iterate.

## Topics to Explore

- [file] `intersection-of-two-arrays/solution.py` — The simpler variant (problem 349) that returns distinct elements only; compare to see how duplicate handling changes the approach
- [file] `intersection-of-two-arrays-ii/test_solution.py` — Test cases reveal edge cases: empty arrays, no overlap, full overlap, duplicate-heavy inputs
- [general] `counter-vs-sorting-tradeoff` — This problem has three canonical approaches (Counter, sorting+two-pointers, binary search); understanding when each wins matters for the follow-up questions LeetCode asks
- [file] `intersection-of-three-sorted-arrays/solution.py` — Extension to three arrays with a sorted-input constraint, which shifts the optimal strategy to two-pointers

## Beliefs

- `intersect-preserves-min-frequency` — Each element appears in the output exactly `min(count_in_nums1, count_in_nums2)` times, never more
- `intersect-output-follows-nums2-order` — Result elements appear in the order they are encountered in `nums2`, not `nums1`
- `intersect-counter-never-goes-negative` — The `> 0` guard prevents decrementing a counter below zero, which would produce false matches
- `intersect-streams-nums2` — Only `nums1` is fully materialized in memory (as a Counter); `nums2` is consumed in a single pass, making this suitable when `nums2` is too large to hold in memory

