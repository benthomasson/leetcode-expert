# File: intersection-of-three-sorted-arrays/solution.py

**Date:** 2026-06-06
**Time:** 17:06

## Purpose

This file solves [LeetCode 1213 — Intersection of Three Sorted Arrays](https://leetcode.com/problems/intersection-of-three-sorted-arrays/). It finds all integers that appear in all three input arrays, which are each sorted in strictly increasing order. It belongs to the repo's collection of LeetCode solutions, each isolated in its own directory with a standard layout (`solution.py`, `test_solution.py`, `plan.md`, `review.md`).

## Key Components

### `Solution.arraysIntersection`

**Signature:** `(arr1: List[int], arr2: List[int], arr3: List[int]) -> List[int]`

Three-pointer merge that walks all three arrays simultaneously in a single pass. Returns a sorted list of values present in every array.

## Patterns

**Three-pointer technique.** This is the canonical pattern for intersecting sorted sequences without extra space. Instead of using sets (O(n) space) or binary search (O(n log n)), it exploits the sorted invariant to advance pointers in lock-step — always advancing the pointer that points to the smallest value. When all three point to the same value, that value is in the intersection.

The branching logic at lines 20–26 implements this:

1. **All equal** → record the value, advance all three pointers.
2. **`arr1[i]` is the global min** → advance `i` (it can't match anything yet).
3. **`arr2[j] <= arr3[k]`** → `arr2[j]` is the smallest of the remaining two, advance `j`.
4. **Otherwise** → `arr3[k]` is smallest, advance `k`.

This is O(n₁ + n₂ + n₃) time, O(1) auxiliary space (ignoring the output list).

## Dependencies

**Imports:** Only `typing.List` — no external or internal dependencies.

**Imported by:** `intersection-of-three-sorted-arrays/test_solution.py` directly. The massive "Imported By" list in the prompt is an artifact of the repo's test scaffolding — those other test files don't actually import this solution; they share a common test runner or import pattern.

## Flow

1. Initialize three index variables `i`, `j`, `k` to 0.
2. Loop while all three indices are in bounds.
3. Compare the current elements at all three pointers.
4. If all match, append to `result` and advance all three.
5. Otherwise, advance the pointer pointing to the smallest element — this can never be part of a three-way match at its current position because at least one other array's current element is larger.
6. Return `result` once any array is exhausted.

## Invariants

- **Sorted input required.** The algorithm only works because each array is in strictly increasing order. If inputs were unsorted, the pointer-advance logic would skip valid matches.
- **Strictly increasing** — no duplicates within a single array. This means a three-way equality check is sufficient; there's no need to handle duplicate matches or count multiplicities.
- **Output is sorted** — values are appended in increasing order because the pointers only move forward through sorted arrays.
- **The `<=` comparisons (not `<`) in the elif branches are safe** because when two values are equal but the third differs, advancing either of the equal ones is correct — the other will catch up or be advanced on the next iteration.

## Error Handling

None. The function assumes valid input per the LeetCode contract (non-empty sorted arrays of integers). Empty arrays are handled implicitly — the while-loop condition short-circuits and returns `[]`.

## Topics to Explore

- [file] `intersection-of-three-sorted-arrays/test_solution.py` — See what edge cases are covered (empty arrays, no intersection, full overlap)
- [file] `intersection-of-two-arrays/solution.py` — Compare the two-array variant; likely uses a different technique (sets or two pointers)
- [file] `intersection-of-multiple-arrays/solution.py` — Generalized k-array intersection; see how it scales beyond three
- [function] `minimum-common-value/solution.py:Solution` — Two-pointer intersection finding the first common value in two sorted arrays — same pointer-advance pattern
- [general] `three-pointer-vs-set-intersection` — When three pointers beats set intersection: sorted input, strict ordering, and the desire for O(1) space

## Beliefs

- `three-pointer-linear-time` — `arraysIntersection` runs in O(n₁ + n₂ + n₃) time with O(1) auxiliary space by advancing the pointer at the smallest value
- `sorted-input-invariant` — The algorithm produces correct results only when all three input arrays are sorted in strictly increasing order
- `output-preserves-order` — The returned list is always in sorted (increasing) order because elements are appended as the pointers move forward
- `empty-input-safe` — If any input array is empty, the while-loop never executes and the function returns `[]` without error

