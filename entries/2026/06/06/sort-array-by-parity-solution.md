# File: sort-array-by-parity/solution.py

**Date:** 2026-06-06
**Time:** 19:11

## Purpose

This file is the self-contained solution and test suite for [LeetCode 905 — Sort Array By Parity](https://leetcode.com/problems/sort-array-by-parity/). It owns the algorithm implementation and its correctness verification. Within the `leetcode-implementations` repo, each problem gets its own directory with `solution.py`, `test_solution.py`, `plan.md`, and `review.md`; this file combines the solution and tests into one module.

## Key Components

### `Solution.sortArrayByParity(nums: List[int]) -> List[int]`

Partitions `nums` in-place so all even integers precede all odd integers. Returns the mutated array. The relative order within evens or odds is **not** preserved (this is acceptable per the problem spec — any valid partition is accepted).

**Contract:** Accepts a list of integers where `1 <= len(nums) <= 5000` and `0 <= nums[i] <= 5000`. Returns the same list object, modified in place.

### `TestSortArrayByParity`

Twelve test methods, all delegating to the `_check` helper.

### `_check(nums)`

The verification oracle. It:
1. Copies the input (`nums[:]`) so the original is preserved for assertion.
2. Calls `sortArrayByParity` on the copy.
3. Asserts the result is structurally valid: all evens come before all odds (`result == evens + odds`).
4. Asserts the result is a permutation of the input (`sorted(result) == sorted(nums)`).

This is a property-based style of assertion — it doesn't check for a single expected output but verifies the two invariants any correct answer must satisfy.

## Patterns

**Two-pointer partition (Lomuto/Hoare hybrid).** The algorithm uses converging `left` and `right` pointers, a standard in-place partitioning idiom. It resembles the partition step of quicksort but with a fixed predicate (even vs. odd) rather than a pivot value.

The branching logic handles three cases each iteration:
- `left` is already even → advance `left`
- `right` is already odd → retreat `right`
- Otherwise `left` is odd and `right` is even → swap and move both

This avoids unnecessary swaps and guarantees progress on every iteration.

**Property-based test oracle.** Rather than hardcoding expected outputs (which would be fragile given that multiple valid orderings exist), `_check` verifies structural properties. This is the right testing pattern when the answer isn't unique.

## Dependencies

**Imports:** `typing.List` (type annotation) and `unittest` (test framework). No project-internal dependencies.

**Imported by:** The "Imported By" list in the prompt is misleading — it lists hundreds of test files across the repo, which likely share a common test runner or import infrastructure, not a direct dependency on this specific solution. The actual direct dependent is `sort-array-by-parity/test_solution.py`.

## Flow

1. Initialize `left = 0`, `right = len(nums) - 1`.
2. Loop while `left < right`:
   - If `nums[left]` is even, it's already in the correct half — increment `left`.
   - Else if `nums[right]` is odd, it's already in the correct half — decrement `right`.
   - Else both are misplaced — swap them and move both pointers inward.
3. Return `nums`.

The loop terminates because at least one pointer moves inward on every iteration. When `left >= right`, every element at index `< left` is even and every element at index `> right` is odd. The element at the meeting point (if `left == right`) is correctly placed regardless of parity.

## Invariants

- **Partition invariant:** At every iteration, `nums[0..left)` contains only evens and `nums(right..end]` contains only odds.
- **Permutation invariant:** Only swaps are performed — no elements are added or removed.
- **Termination:** Each iteration advances at least one of `left` or `right`, and the loop exits when they cross.
- **O(n) time, O(1) space:** Single pass with no auxiliary data structures.

## Error Handling

None. The function assumes valid input per the LeetCode constraints. An empty list would cause `right = -1`, but the `while left < right` guard would skip the loop and return the empty list correctly — so it handles that edge case implicitly even though the constraints guarantee `len >= 1`.

---

## Topics to Explore

- [file] `sort-array-by-parity-ii/solution.py` — The variant problem where even/odd elements must go to even/odd *indices* specifically, requiring a different two-pointer strategy
- [function] `sort-array-by-parity/solution.py:_check` — The property-based oracle pattern used here is reusable for any problem with non-unique valid outputs
- [general] `two-pointer-partition-variants` — Compare this converging two-pointer approach against the single-pointer "writer" approach (used in move-zeroes) and the Dutch National Flag three-way partition
- [file] `move-zeroes/solution.py` — A closely related partitioning problem that uses a different single-pass strategy worth comparing

## Beliefs

- `sort-by-parity-in-place` — `sortArrayByParity` mutates and returns the input list; it allocates no auxiliary array
- `sort-by-parity-linear` — The algorithm runs in O(n) time with O(1) extra space via a single converging two-pointer pass
- `sort-by-parity-progress` — Every iteration of the while loop advances at least one of `left` or `right`, guaranteeing termination in at most n steps
- `sort-by-parity-tests-property-based` — Tests verify two structural properties (evens-before-odds and permutation-of-input) rather than checking against hardcoded expected outputs

