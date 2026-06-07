# File: count-number-of-pairs-with-absolute-difference-k/solution.py

**Date:** 2026-06-06
**Time:** 16:01

## `count-number-of-pairs-with-absolute-difference-k/solution.py`

### Purpose

This file solves [LeetCode 2006: Count Number of Pairs With Absolute Difference K](https://leetcode.com/problems/count-number-of-pairs-with-absolute-difference-k/). It owns a single responsibility: given an array `nums` and integer `k`, count all pairs `(i, j)` where `i < j` and `|nums[i] - nums[j]| == k`.

### Key Components

**`count_number_of_pairs_with_absolute_difference_k(nums, k) -> int`** — The sole exported function. It takes a list of integers and a target difference, returns the count of qualifying pairs.

### Patterns

The solution uses the **frequency map reduction** pattern instead of brute-force O(n^2) pair enumeration. The key insight: for any value `v`, every element equal to `v` can pair with every element equal to `v + k` to satisfy `|a - b| == k`. By iterating over unique values rather than indices, it avoids double-counting — it only checks `v + k` (not `v - k`), which means each qualifying pair is counted exactly once.

This is a common idiom in this repo for pair-counting problems (see also `count-equal-and-divisible-pairs-in-an-array`, `number-of-good-pairs`).

### Dependencies

**Imports:** `collections.Counter` — used to build the frequency map in a single pass.

**Imported by:** `count-number-of-pairs-with-absolute-difference-k/test_solution.py`. The massive "Imported By" list in the prompt is misleading — those are unrelated test files that happen to share the same test harness import structure, not actual consumers of this function.

### Flow

1. Build a `Counter` from `nums` — O(n) pass producing `{value: count}`.
2. Iterate over each unique value `v` in the counter.
3. For each `v`, check if `v + k` exists in the counter.
4. If so, add `freq[v] * freq[v + k]` to the result — this is the number of pairs where one element equals `v` and the other equals `v + k`.
5. Return the accumulated count.

The multiplication works because any of the `freq[v]` elements can pair with any of the `freq[v+k]` elements. The directional check (`v + k` only, never `v - k`) ensures each pair is counted once: the pair `(v, v+k)` is discovered when iterating `v`, and would not be rediscovered as `(v+k, v+k-k)` because that's the same `v`.

### Invariants

- **No double-counting:** Only checks `v + k`, not `v - k`. Since `k >= 1`, `v` and `v + k` are always distinct, and every qualifying pair is covered exactly once across all iterations.
- **Constraint range:** The docstring specifies `1 <= nums[i] <= 100` and `1 <= k <= 99`, which means `v + k <= 199` — always a valid integer, no overflow concern.
- **Index ordering is implicit:** The problem asks for pairs where `i < j`, but since we're only counting (not enumerating), and each unordered pair `{a, b}` maps to exactly one ordered pair `(i, j)` per occurrence, the frequency product gives the correct count without tracking indices.

### Error Handling

None. The function assumes valid input per LeetCode constraints. No validation on empty lists, negative values, or `k == 0` (which would require special handling since `v + 0 == v` would count self-pairs incorrectly — but `k >= 1` by constraint).

## Topics to Explore

- [file] `count-number-of-pairs-with-absolute-difference-k/test_solution.py` — See what edge cases the test suite covers and whether `k=0` is tested
- [function] `number-of-good-pairs/solution.py:count_number_of_good_pairs` — Same frequency-map-then-multiply pattern applied to pairs where `nums[i] == nums[j]`
- [function] `count-equal-and-divisible-pairs-in-an-array/solution.py:count_equal_and_divisible_pairs_in_an_array` — Similar pair-counting problem but with an additional divisibility constraint that forces a different approach
- [general] `counter-based-pair-counting` — How `Counter` multiplication generalizes across LeetCode pair problems: when you can reduce from O(n^2) to O(n) by counting values instead of enumerating indices

## Beliefs

- `absolute-diff-k-no-double-count` — Checking only `v + k` (not `v - k`) guarantees each valid pair is counted exactly once, because `k >= 1` makes the relationship asymmetric over unique values.
- `absolute-diff-k-linear-time` — The algorithm runs in O(n) time and O(n) space via `Counter`, avoiding the O(n^2) brute-force approach.
- `absolute-diff-k-ignores-indices` — The solution never tracks element indices; it relies on the algebraic fact that frequency products equal ordered-pair counts for distinct values.
- `absolute-diff-k-assumes-positive-k` — The function would miscount if `k == 0` (it would count `freq[v]^2` instead of `C(freq[v], 2)`), but this is safe under the stated constraint `k >= 1`.

