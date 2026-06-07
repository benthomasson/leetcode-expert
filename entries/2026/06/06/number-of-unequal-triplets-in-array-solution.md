# File: number-of-unequal-triplets-in-array/solution.py

**Date:** 2026-06-06
**Time:** 18:24

## `number-of-unequal-triplets-in-array/solution.py`

### Purpose

Solves [LeetCode 2475](https://leetcode.com/problems/number-of-unequal-triplets-in-array/): given an array `nums`, count index triplets `(i, j, k)` with `i < j < k` where all three values are pairwise distinct (`nums[i] != nums[j]`, `nums[j] != nums[k]`, `nums[i] != nums[k]`).

### Key Components

**`Solution.countTriplets(nums: List[int]) -> int`** — The single method. Takes a list of positive integers, returns the count of valid triplets.

### Patterns

The solution uses a **group-contribution sweep** rather than brute-force enumeration. Instead of O(n³) nested loops, it:

1. Groups elements by value via `Counter(nums)`.
2. Sweeps through the groups in arbitrary order, maintaining a running `left` count of elements in already-processed groups.

For each group with count `c`:
- `left` = elements in groups already visited
- `right = n - left - c` = elements in groups not yet visited
- `left * c * right` = the number of triplets that pick one element from a "left" group, one from the current group, and one from a "right" group.

This works because any set of three elements with pairwise distinct values spans exactly three distinct groups. That triple of groups is counted exactly once — when the group that falls in the middle of the processing order is visited. The index ordering constraint (`i < j < k`) is satisfied because choosing 3 items from 3 groups yields 1 ordered arrangement each, and `a * b * c` already counts all unordered selections which map 1-to-1 to ordered index triples.

### Dependencies

**Imports:**
- `collections.Counter` — frequency counting
- `typing.List` — type annotation

**Imported by:** The corresponding `test_solution.py` in the same directory.

### Flow

```
nums = [4, 4, 2, 4, 3]

Counter(nums) → {4: 3, 2: 1, 3: 1}

Iteration:
  c=3 (value 4): left=0, right=5-0-3=2  → 0*3*2 = 0
  c=1 (value 2): left=3, right=5-3-1=1  → 3*1*1 = 3
  c=1 (value 3): left=4, right=5-4-1=0  → 4*1*0 = 0

result = 3
```

### Invariants

- **`left + c + right == n`** at every iteration — the three pools partition the entire array.
- The loop visits each distinct value group exactly once. After the loop, `left == n`.
- The algorithm is **order-independent** — the iteration order of `Counter.values()` doesn't affect the result, because every triple of distinct groups is counted when the "middle" group (in processing order) is visited.

### Complexity

- **Time:** O(n) — one pass to build the Counter, one pass over distinct values.
- **Space:** O(k) where k = number of distinct values.

### Error Handling

None. The method trusts its input matches LeetCode constraints (1 <= nums.length <= 1000, 1 <= nums[i] <= 1000). No edge-case guards for empty arrays — unnecessary given the constraint.

---

## Topics to Explore

- [file] `number-of-unequal-triplets-in-array/test_solution.py` — See what edge cases the tests cover (single-value arrays, all-distinct arrays, duplicates)
- [function] `count-good-triplets/solution.py:countGoodTriplets` — A related triplet-counting problem that may use a different technique due to its absolute-difference constraints
- [general] `group-contribution-sweep` — This "left * current * right" pattern appears in several combinatorics problems (e.g., counting subarrays, number of arithmetic triplets) and is worth recognizing as a reusable idiom
- [file] `number-of-good-pairs/solution.py` — Similar Counter-based counting, but for pairs instead of triplets — a simpler instance of the same pattern

---

## Beliefs

- `triplet-count-is-linear` — `countTriplets` runs in O(n) time and O(k) space where k is the number of distinct values, avoiding the O(n³) brute-force approach
- `left-right-partition-invariant` — At every loop iteration, `left + c + right == len(nums)`, ensuring the three pools partition the full array
- `order-independence` — The result is the same regardless of which order `Counter.values()` yields the group counts, because each triple of distinct groups is counted exactly once across the sweep
- `no-index-tracking-needed` — Despite the problem requiring `i < j < k` ordering, the algorithm never tracks indices — the combinatorial identity `a * b * c` (one from each of three groups) equals the count of ordered index triples directly

