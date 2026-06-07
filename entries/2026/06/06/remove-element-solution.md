# File: remove-element/solution.py

**Date:** 2026-06-06
**Time:** 18:46

## `remove-element/solution.py`

### Purpose

This file implements [LeetCode 27 — Remove Element](https://leetcode.com/problems/remove-element/). It solves the in-place array mutation variant where you must remove all occurrences of a given value from an array and return the count of remaining elements. The solution modifies `nums` directly — the caller inspects only the first `k` elements after the call.

### Key Components

**`removeElement(nums, val) -> int`** — The sole function. It takes a mutable list and a value to remove, compacts the non-matching elements to the front of the list, and returns the count `k` of retained elements. After the call, `nums[0:k]` contains exactly the elements not equal to `val`, in their original relative order.

### Patterns

**Two-pointer compaction (read/write pointers).** This is the canonical in-place partition pattern:
- `i` is the read pointer — scans every element.
- `k` is the write pointer — tracks where the next kept element should go.

The write pointer only advances when an element is retained, so it always satisfies `k <= i`. Elements at indices `>= k` are "garbage" — they may contain stale values, and the problem contract says they're ignored.

This is the same pattern used in `remove-duplicates-from-sorted-array/solution.py` and `move-zeroes/solution.py` in this repo. It's the standard approach when the problem requires stable in-place filtering with O(1) extra space.

### Dependencies

**Imports:** None. Pure function with no external dependencies.

**Imported by:** The `remove-element/test_solution.py` file directly. The "Imported By" list in the prompt shows ~400+ test files — this is an artifact of how the test harness is structured (likely a shared conftest or test utility that re-exports solution modules), not direct usage of `removeElement` itself.

### Flow

1. Initialize write pointer `k = 0`.
2. Iterate read pointer `i` from `0` to `len(nums) - 1`.
3. If `nums[i] != val`, copy `nums[i]` to `nums[k]` and increment `k`.
4. If `nums[i] == val`, skip — `k` doesn't advance, so this element is effectively dropped.
5. Return `k`.

For input `nums = [3, 2, 2, 3], val = 3`:
- `i=0`: `nums[0]=3` matches val, skip.
- `i=1`: `nums[1]=2` kept → `nums[0]=2`, `k=1`.
- `i=2`: `nums[2]=2` kept → `nums[1]=2`, `k=2`.
- `i=3`: `nums[3]=3` matches val, skip.
- Returns `2`, `nums[:2] = [2, 2]`.

### Invariants

- **Stability:** Retained elements preserve their original relative order.
- **Write-never-exceeds-read:** `k <= i` always holds, so the copy at `nums[k] = nums[i]` never overwrites an unread element.
- **In-place contract:** No new list is allocated. The mutation happens on the input list object, which matters because LeetCode's judge inspects `nums` by reference after the call.
- **O(1) space, O(n) time.**

### Error Handling

None. The function assumes valid inputs per the LeetCode contract: `nums` is a list of integers, `val` is an integer. Empty lists work correctly — the loop body never executes and `k=0` is returned.

---

## Topics to Explore

- [file] `remove-element/test_solution.py` — See how the test harness validates both the return value and the mutated array contents
- [function] `remove-duplicates-from-sorted-array/solution.py:removeDuplicates` — Same two-pointer compaction pattern, but the keep-condition is "different from previous kept element" instead of "not equal to val"
- [function] `move-zeroes/solution.py:moveZeroes` — Another variant: compact non-zeros forward, then backfill zeros
- [general] `in-place-two-pointer-family` — The family of problems (26, 27, 80, 283) that all use read/write pointer compaction with different predicates
- [file] `remove-element/plan.md` — The planning doc may capture alternative approaches considered (e.g., the swap-with-end variant that's O(n) but unstable)

## Beliefs

- `remove-element-uses-stable-compaction` — `removeElement` preserves the relative order of retained elements; it does not use the swap-to-end optimization
- `remove-element-write-never-exceeds-read` — The write pointer `k` is always `<= i`, so `nums[k] = nums[i]` never destroys an unread value
- `remove-element-pure-in-place` — The function allocates no auxiliary data structures; space complexity is O(1)
- `remove-element-handles-empty` — An empty input list returns 0 with no mutation, no special-case branch needed

