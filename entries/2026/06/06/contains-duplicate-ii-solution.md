# File: contains-duplicate-ii/solution.py

**Date:** 2026-06-06
**Time:** 15:50

## Contains Duplicate II — Solution Explanation

### Purpose

This file solves [LeetCode 219: Contains Duplicate II](https://leetcode.com/problems/contains-duplicate-ii/). It determines whether an array contains two distinct indices `i` and `j` such that `nums[i] == nums[j]` and `abs(i - j) <= k`. It owns the single `Solution.containsNearbyDuplicate` method, which is the standard LeetCode entry point.

### Key Components

**`Solution.containsNearbyDuplicate(nums, k) -> bool`**

- **Input contract**: `nums` is a list of integers, `k` is a non-negative integer representing the maximum allowed index gap.
- **Output contract**: Returns `True` if any value appears twice within `k` positions; `False` otherwise.
- **Core data structure**: `last_seen: dict[int, int]` — maps each value to the most recent index where it was seen.

### Patterns

**Hash map for O(1) lookups.** Rather than a brute-force O(n*k) nested scan, this uses a dictionary to check in constant time whether a value was seen recently. This is the canonical "value → last index" pattern seen across many LeetCode sliding-window and duplicate-detection problems (compare with `two-sum/solution.py`).

**Single-pass greedy update.** The dictionary always stores the *most recent* index for each value, not the first. This is correct because if a value at index `j` is too far from its earlier occurrence at index `i`, any future occurrence at index `m > j` will be closer to `j` than to `i`. Storing only the latest index is sufficient — you never need to check against older occurrences.

**Early return.** The function short-circuits on the first duplicate found within range, avoiding unnecessary iteration.

### Dependencies

- **Imports**: `typing.List` — used only for the type annotation on `nums`. The modern `list[int]` syntax in the `last_seen` annotation suggests mixed-era typing (the `List` import could be dropped in Python 3.9+).
- **Imported by**: `contains-duplicate-ii/test_solution.py` directly. The massive "Imported By" list in the context is an artifact of the test harness importing `Solution` generically across the repo — those tests don't actually use *this* solution.

### Flow

1. Initialize empty dict `last_seen`.
2. Iterate over `nums` with index `i` and value `num`.
3. If `num` exists in `last_seen` AND `i - last_seen[num] <= k`, return `True`.
4. Unconditionally update `last_seen[num] = i` (overwriting any previous index).
5. If the loop completes without finding a match, return `False`.

The subtlety is in step 4: the update happens *after* the check, and it happens regardless of whether the check passed. This means the dict always reflects the latest index, which is the optimal position to measure future distances from.

### Invariants

- **`last_seen[v]` is always the largest index `j < i` where `nums[j] == v`** at the point when index `i` is being processed. This monotonically increasing property is what makes it safe to discard older indices.
- **The distance check `i - last_seen[num]` is always non-negative** because `i` strictly increases and `last_seen[num]` was set at some earlier iteration.

### Error Handling

None. The function assumes valid inputs per LeetCode constraints. An empty `nums` list or `k=0` (only self-match, which can't happen with distinct indices) are handled implicitly — the loop either doesn't execute or the distance check always fails.

### Complexity

- **Time**: O(n) — single pass, O(1) dictionary operations per element.
- **Space**: O(n) — worst case, every element is unique and stored in the dict.

An alternative approach uses a sliding-window *set* of size `k`, evicting the oldest element when the window exceeds `k`. That caps space at O(k) but is slightly more code. This solution trades a potentially larger dict for simpler logic.

## Topics to Explore

- [file] `contains-duplicate-ii/test_solution.py` — Verify which edge cases are covered (empty array, k=0, all duplicates, no duplicates)
- [function] `two-sum/solution.py:Solution.twoSum` — Uses the same value-to-index hash map pattern for a different goal (finding complement pairs)
- [general] `sliding-window-set-variant` — The O(k) space alternative that maintains a fixed-size window set instead of a full dictionary
- [file] `contains-duplicate-ii/plan.md` — Check whether the plan documents the choice between dict vs. sliding-window approaches

## Beliefs

- `last-seen-stores-latest-index` — `last_seen[num]` always holds the most recent index where `num` appeared, never an earlier one
- `single-pass-linear-time` — The algorithm makes exactly one pass over `nums` with O(1) work per element, giving O(n) time complexity
- `early-return-on-first-match` — The function returns `True` on the first duplicate found within distance `k`, not after scanning all pairs
- `no-input-validation` — The function performs no validation on `nums` or `k`; it assumes LeetCode-compliant inputs

