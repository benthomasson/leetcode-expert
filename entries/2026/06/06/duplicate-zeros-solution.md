# File: duplicate-zeros/solution.py

**Date:** 2026-06-06
**Time:** 16:28

## `duplicate-zeros/solution.py`

### Purpose

This file solves [LeetCode 1089 - Duplicate Zeros](https://leetcode.com/problems/duplicate-zeros/). Given a fixed-length integer array, it duplicates each occurrence of zero by shifting all elements to the right, discarding elements that fall off the end. The modification is done **in-place** with no return value.

### Key Components

**`duplicateZeros(arr: list[int]) -> None`** — The sole function. It modifies `arr` in place so that every `0` is followed by an inserted `0`, with trailing elements pushed off the array. Returns nothing.

### Patterns

The solution uses a **two-pass, right-to-left copy** pattern — a classic technique for in-place array expansion problems where the output is the same buffer as the input:

1. **First pass (left-to-right scan):** Count how many zeros exist among the elements that will survive the duplication. This determines where the "write head" starts — effectively computing the mapping between source and destination indices without allocating extra space.

2. **Second pass (right-to-left copy):** Walk backward through the surviving elements, placing each at its final position. Zeros get written twice. Writing right-to-left avoids overwriting elements that haven't been read yet.

This is the same strategy used in problems like "merge sorted array in place" or "move elements with gap insertion." It avoids O(n) shifting per zero (which would give O(n^2)) and avoids O(n) extra space.

### Dependencies

**Imports:** None — pure standalone function with no library dependencies.

**Imported by:** `duplicate-zeros/test_solution.py` directly, plus the massive list of other test files shown in the context (likely an artifact of a shared test harness or conftest importing all solutions).

### Flow

**First pass — find the split point (lines 5-11):**

```
zeros = 0, i = 0
while i + zeros < n:     # stop when source + offset reaches end of array
    if arr[i] == 0:
        zeros += 1        # each zero needs one extra slot
    i += 1
i -= 1                    # back up to the last surviving element
```

The loop invariant: `i + zeros` tracks where element `arr[i]` would land in the output. When `i + zeros >= n`, we've identified all elements that fit. After the loop, `i` points one past the last survivor, so it's decremented.

**Edge case handling (lines 14-17):**

When the last surviving element is a zero and `i + zeros == n` (exactly at the boundary), that zero only gets *one* copy — there's no room for the duplicate. This block writes that single zero at the end and adjusts both pointers before the main copy loop.

This is the trickiest part of the algorithm. Without it, the second pass would try to write two copies and overrun the array.

**Second pass — right-to-left copy (lines 19-24):**

```
while j >= 0:
    arr[j] = arr[i]       # copy element to its final position
    j -= 1
    if arr[i] == 0:       # zeros get a second copy
        arr[j] = 0
        j -= 1
    i -= 1
```

`i` walks the source (surviving elements), `j` walks the destination (end of array). Every element moves right by the number of zeros that precede it.

### Invariants

- **O(1) extra space:** Only scalar variables (`zeros`, `i`, `j`) are used — no auxiliary array.
- **O(n) time:** Two linear passes over the array.
- **Array length is preserved:** The function never changes `len(arr)`.
- **Right-to-left copy safety:** Because `j >= i` always holds during the second pass, writes never destroy unread source data.
- **Boundary zero gets single copy:** The edge case block guarantees no out-of-bounds write when the split falls exactly on a zero.

### Error Handling

None. The function assumes valid input per LeetCode constraints (non-empty list of non-negative integers). No bounds checking, no exceptions. An empty list would cause `i -= 1` to set `i = -1` and the second pass loop wouldn't execute, which happens to be safe.

---

## Topics to Explore

- [file] `duplicate-zeros/test_solution.py` — Verify which edge cases are covered, especially the boundary-zero scenario
- [file] `duplicate-zeros/plan.md` — See what approach was considered before implementation and whether alternatives were evaluated
- [general] `right-to-left-in-place-expansion` — The same two-pass pattern appears in merge-sorted-array and similar problems in this repo
- [function] `move-zeroes/solution.py:moveZeroes` — Complementary problem (compact instead of expand) that uses similar pointer techniques
- [file] `duplicate-zeros/review.md` — Check whether the review flagged the boundary edge case or identified the time/space complexity

## Beliefs

- `duplicate-zeros-O1-space` — The solution uses O(1) auxiliary space; no temporary array is allocated
- `duplicate-zeros-boundary-zero-special-case` — When the last surviving element is a zero that lands exactly at position n, it receives only one copy to avoid overrun
- `duplicate-zeros-right-to-left-prevents-overwrite` — The second pass writes right-to-left so the destination pointer is always ahead of or equal to the source pointer, preventing data loss
- `duplicate-zeros-two-pass-linear` — The algorithm runs in exactly two passes over the array, giving O(n) time complexity

