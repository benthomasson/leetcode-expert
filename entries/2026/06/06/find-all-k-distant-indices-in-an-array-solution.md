# File: find-all-k-distant-indices-in-an-array/solution.py

**Date:** 2026-06-06
**Time:** 16:33

## `find-all-k-distant-indices-in-an-array/solution.py`

### Purpose

This file solves [LeetCode 2200 — Find All K-Distant Indices in an Array](https://leetcode.com/problems/find-all-k-distant-indices-in-an-array/). It's one solution module in a large repo of LeetCode implementations, each following the same convention: a single `solution.py` exporting one function that matches the problem's signature.

### Key Components

**`find_k_distant_indices(nums, key, k) -> List[int]`** — The sole public function. Given a 0-indexed array `nums`, a target value `key`, and a distance threshold `k`, it returns the sorted list of all indices `i` where there exists some index `j` such that `nums[j] == key` and `|i - j| <= k`.

### Patterns

**Brute-force expansion from key positions.** The algorithm iterates over the array once to find every index `j` where `nums[j] == key`, then for each such `j`, adds the entire range `[j-k, j+k]` (clamped to array bounds) into a set. The set handles deduplication when ranges from different key positions overlap.

The final `sorted()` call converts the set to a sorted list, satisfying the problem's requirement that the output be in increasing order.

This is O(n * k) time in the worst case (every element matches `key` and `k` is large), with O(n) space for the set. For the problem's constraints (n, k ≤ 1000), this is well within limits.

### Dependencies

**Imports:** Only `List` from `typing` — no external or project-internal dependencies.

**Imported by:** The corresponding `test_solution.py` in the same directory, plus hundreds of other test files listed in the "Imported By" section. That's an artifact of the test harness importing a shared utility or test infrastructure, not direct coupling to this function.

### Flow

1. Capture `n = len(nums)`.
2. Initialize an empty `set` for result indices.
3. For each `(j, val)` in `nums`:
   - If `val == key`, iterate `i` from `max(0, j - k)` to `min(n, j + k + 1)` (exclusive upper bound), adding each `i` to the set.
4. Return `sorted(result)`.

The `max(0, ...)` / `min(n, ...)` clamping prevents out-of-bounds indices. The `+1` in `j + k + 1` makes the range inclusive of `j + k`.

### Invariants

- The returned list is sorted and contains no duplicates (guaranteed by `set` + `sorted`).
- Every index in the result satisfies `|i - j| <= k` for at least one `j` where `nums[j] == key`.
- All returned indices are valid (in `[0, n)`), enforced by the clamping logic.

### Error Handling

None. The function assumes valid inputs per the LeetCode contract. If `key` doesn't appear in `nums`, the result is an empty list. If `nums` is empty, the loop body never executes and an empty list is returned.

---

## Topics to Explore

- [file] `find-all-k-distant-indices-in-an-array/test_solution.py` — See what edge cases the tests cover (empty arrays, overlapping ranges, key not present)
- [file] `find-all-k-distant-indices-in-an-array/review.md` — Check whether the review flagged the O(n*k) complexity or suggested an O(n) two-pointer alternative
- [general] `k-distant-optimal-approach` — An O(n) solution is possible by tracking a "coverage window" while scanning left-to-right, merging overlapping ranges without a set
- [file] `find-all-k-distant-indices-in-an-array/plan.md` — Understand which approaches were considered before settling on brute-force expansion

## Beliefs

- `k-distant-uses-set-dedup` — Overlapping ranges from multiple key positions are deduplicated via a Python `set`, not by merging intervals
- `k-distant-output-always-sorted` — The return value is always in ascending order because `sorted()` is called on the set before returning
- `k-distant-clamping-prevents-oob` — `max(0, j-k)` and `min(n, j+k+1)` guarantee all indices in the result are within `[0, n)`
- `k-distant-brute-force-complexity` — Worst-case time is O(n*k) when every element equals `key`, acceptable for the problem's n,k ≤ 1000 constraints

