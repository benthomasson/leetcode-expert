# File: find-anagram-mappings/solution.py

**Date:** 2026-06-06
**Time:** 16:35

## Purpose

This file solves [LeetCode 760 — Find Anagram Mappings](https://leetcode.com/problems/find-anagram-mappings/). Given two arrays `nums1` and `nums2` where `nums2` is an anagram (permutation) of `nums1`, it returns an index mapping `mapping` such that `mapping[i] = j` means `nums1[i] == nums2[j]`.

It's one solution module in a large repository of LeetCode implementations, each following the same structure: `solution.py` + `test_solution.py` + optional `plan.md`/`review.md`.

## Key Components

**`anagramMappings(nums1, nums2) -> list[int]`** — The sole public function. Takes two integer lists of equal length where one is a permutation of the other, and returns a list of indices mapping each element in `nums1` to a matching position in `nums2`.

## Patterns

The solution uses **inverted-index lookup with consumption**: it pre-indexes all positions in `nums2` by value, then pops from each value's queue as positions are consumed. This is the standard O(n) pattern for this problem.

The choice of `deque` over a plain `list` is deliberate — `deque.pop()` is O(1) from the right, same as `list.pop()`, but using `deque` signals intent: this is a queue of available indices being consumed. In practice `list.pop()` would perform identically here since it pops from the right, but `deque` makes the "pool of positions" semantics explicit.

The `defaultdict(deque)` pattern avoids any key-existence checks — every value in `nums1` is guaranteed to appear in `nums2` (anagram precondition), so the deque is never empty when popped.

## Dependencies

**Imports:** `defaultdict` and `deque` from `collections` — both stdlib, no external dependencies.

**Imported by:** The `test_solution.py` files listed in the context aren't actually importing *this* file — that list appears to be a repo-wide cross-reference artifact. The real consumer is `find-anagram-mappings/test_solution.py`.

## Flow

1. Build `index_map`: iterate `nums2` with `enumerate`, appending each `(value -> index)` pair into the deque for that value.
2. Consume the map: for each value in `nums1`, pop an index from `index_map[val]`. The result list is built in a single list comprehension.

For `nums1 = [12, 28, 46]`, `nums2 = [46, 12, 28]`:
- After step 1: `{46: deque([0]), 12: deque([1]), 28: deque([2])}`
- Step 2 produces: `[1, 2, 0]`

## Invariants

- **Anagram precondition**: `nums2` must be a permutation of `nums1`. If violated, `pop()` on an empty deque raises `IndexError`.
- **One-to-one consumption**: each index in `nums2` is used exactly once. Duplicate values get multiple indices queued, and each pop consumes one. No index is reused.
- **Any valid mapping accepted**: when duplicates exist (e.g., `nums1 = [1, 1]`, `nums2 = [1, 1]`), the mapping is non-deterministic — either `[0, 1]` or `[1, 0]` is valid. The implementation returns indices in LIFO order (rightmost appended, rightmost popped).

## Error Handling

None. The function trusts the caller to satisfy the anagram precondition. An invalid input (missing value) would surface as an `IndexError` from `deque.pop()` on an empty deque — unhandled, which is appropriate for a LeetCode solution where inputs are guaranteed valid.

## Topics to Explore

- [file] `find-anagram-mappings/test_solution.py` — See what edge cases are tested, especially duplicate handling and single-element arrays
- [file] `find-anagram-mappings/review.md` — The code review may document alternative approaches (e.g., naive O(n²) with `list.index`) and why this one was chosen
- [general] `defaultdict-deque-index-pattern` — This inverted-index-with-consumption pattern recurs across problems like "find all pairs" and "shuffle reconstruction"
- [function] `two-sum/solution.py:twoSum` — Another hash-map-based index lookup problem; compare how index storage differs when you need one match vs. all matches

## Beliefs

- `anagram-mappings-linear-time` — `anagramMappings` runs in O(n) time and O(n) space via a single pass to build the index map and a single pass to consume it
- `anagram-mappings-duplicate-safe` — Duplicate values are handled correctly: each occurrence in `nums2` gets its own queued index, and each occurrence in `nums1` consumes exactly one
- `anagram-mappings-lifo-index-order` — When duplicates exist, indices are assigned in LIFO order (last-appended index is consumed first) due to `deque.pop()` popping from the right
- `anagram-mappings-no-input-validation` — The function performs no validation; violating the anagram precondition raises an unhandled `IndexError`

