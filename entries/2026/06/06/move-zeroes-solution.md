# File: move-zeroes/solution.py

**Date:** 2026-06-06
**Time:** 18:09

## `move-zeroes/solution.py`

### Purpose

This file solves [LeetCode 283 - Move Zeroes](https://leetcode.com/problems/move-zeroes/). It owns exactly one responsibility: rearranging an integer list in-place so that all zeros move to the end while the relative order of non-zero elements is preserved.

### Key Components

**`moveZeroes(nums: list[int]) -> None`** — The sole function. It mutates `nums` in-place and returns nothing. The contract matches LeetCode's expected signature: the caller inspects the modified list, not a return value.

### Patterns

The algorithm uses the **two-pointer / snowball** pattern:

- `insert_pos` is the slow pointer — it tracks where the next non-zero element should land.
- `i` is the fast pointer — it scans every element sequentially.

When `nums[i] != 0`, the values at `insert_pos` and `i` are swapped, then `insert_pos` advances. This is a swap-based variant rather than the overwrite-then-fill approach. The swap is always safe: when `insert_pos == i`, it's a no-op self-swap; when `insert_pos < i`, the element at `insert_pos` is guaranteed to be zero (it was either originally zero or was swapped there by a previous iteration).

### Dependencies

**Imports:** None — pure standard Python, no external or stdlib imports.

**Imported by:** The "Imported By" list in the prompt is misleading — those are test files from *other* problems that happen to share a common test harness or import mechanism. The direct consumer is `move-zeroes/test_solution.py`.

### Flow

1. Initialize `insert_pos = 0`.
2. Iterate `i` from `0` to `len(nums) - 1`.
3. On each non-zero `nums[i]`, swap `nums[insert_pos]` with `nums[i]` and increment `insert_pos`.
4. After the loop, positions `[0, insert_pos)` hold all non-zero values in original order; positions `[insert_pos, len(nums))` are all zeros.

Single pass, O(n) time, O(1) space.

### Invariants

- **Loop invariant:** At the start of each iteration, `nums[0:insert_pos]` contains exactly the non-zero elements seen so far, in their original relative order, and `nums[insert_pos:i]` contains only zeros.
- **Stability:** Non-zero elements never change their relative ordering — they're placed left-to-right as encountered.
- **In-place:** No auxiliary array is allocated. The swap approach means at most `n` swaps total (each non-zero element is swapped at most once).

### Error Handling

None. The function trusts its caller to pass a valid `list[int]`. Empty lists and all-zero lists work correctly — the loop body simply never executes or never triggers a swap, respectively. This is consistent with LeetCode's contract where inputs are guaranteed valid.

---

## Topics to Explore

- [file] `move-zeroes/test_solution.py` — See what edge cases the test suite covers (empty list, single element, no zeros, all zeros)
- [file] `move-zeroes/plan.md` — The planning doc may capture why the swap approach was chosen over overwrite-then-fill
- [function] `remove-duplicates-from-sorted-array/solution.py:removeDuplicates` — Another classic two-pointer in-place mutation problem; compare the pointer mechanics
- [function] `remove-element/solution.py:removeElement` — Nearly identical structure (partition elements in-place by predicate); the generalization of this pattern
- [general] `in-place-array-partitioning` — The family of problems (move zeroes, remove element, sort colors) that use slow/fast pointer partitioning on arrays

## Beliefs

- `move-zeroes-single-pass` — `moveZeroes` completes in exactly one pass over the array (single `for` loop, no second fill phase)
- `move-zeroes-swap-not-overwrite` — The algorithm uses element swaps rather than overwriting non-zeros to front and filling zeros after, which means it performs at most `n` swaps and never needs a second pass
- `move-zeroes-stable-ordering` — Non-zero elements maintain their original relative order after the function completes
- `move-zeroes-no-return-value` — The function returns `None`; the caller must inspect the mutated input list to observe results

