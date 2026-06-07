# File: apply-operations-to-an-array/solution.py

**Date:** 2026-06-06
**Time:** 15:14

## `apply-operations-to-an-array/solution.py`

### Purpose

This file is a self-contained solution to [LeetCode 2460: Apply Operations to an Array](https://leetcode.com/problems/apply-operations-to-an-array/). It owns both the algorithm implementation and its test suite. Within the `leetcode-implementations` repo, each problem directory follows this same pattern — `solution.py` holds the canonical solution plus inline unit tests.

### Key Components

**`performOps(nums: list[int]) -> list[int]`** — The sole public function. Takes a list of non-negative integers, applies pairwise doubling operations, then moves all zeros to the end. Returns a new list (the input is not mutated, since `result = nums[:]` copies first).

**`TestPerformOps`** — Eight test cases covering the contract: LeetCode examples, edge cases (all zeros, no duplicates, single pair), and tricky sequential interactions (consecutive triples, all-same, zeros between values).

### Patterns

The solution uses a classic **two-phase in-place transformation**:

1. **Phase 1 (lines 16–19)**: Single left-to-right pass. When adjacent elements are equal, double the left one and zero the right. This is sequential and order-dependent — the result of processing index `i` affects what index `i+1` sees.

2. **Phase 2 (lines 22–27)**: The "move zeros to end" idiom, implemented via a **write-pointer compaction**. Non-zero values are packed to the front using a `write` index, then trailing positions are filled with zeros. This is the same algorithm as LeetCode 283 (Move Zeroes).

The file bundles tests with the solution rather than importing from a separate test file, though `test_solution.py` also exists and imports from here.

### Dependencies

**Imports**: Only `unittest` from the standard library — no external dependencies.

**Imported by**: The `test_solution.py` in this directory imports `performOps`. The massive "Imported By" list in the prompt is misleading — those are *other* problems' test files that follow the same structural pattern, not actual importers of this specific function.

### Flow

Given input `[1, 2, 2, 1, 1, 0]`:

1. Copy: `result = [1, 2, 2, 1, 1, 0]`
2. Phase 1 iteration:
   - `i=0`: 1 ≠ 2, skip
   - `i=1`: 2 == 2 → `result = [1, 4, 0, 1, 1, 0]`
   - `i=2`: 0 ≠ 1, skip
   - `i=3`: 1 == 1 → `result = [1, 4, 0, 2, 0, 0]`
   - `i=4`: 0 ≠ 0? No, 0 == 0 → `result = [1, 4, 0, 2, 0, 0]` (doubling zero is still zero)
3. Phase 2 compaction: `[1, 4, 2, 0, 0, 0]`

### Invariants

- **Non-mutating**: The input list is never modified; `nums[:]` creates a shallow copy on line 14.
- **Phase ordering matters**: Phase 1 must complete before Phase 2. The doubling pass creates new zeros that Phase 2 must then relocate.
- **Left-to-right sequential dependency**: In Phase 1, index `i+1` is zeroed before index `i+1` is examined as the left element of the next pair. This means `[2, 2, 2]` produces `[4, 0, 2]` (not `[4, 0, 4]`) — the zeroed middle element doesn't match the third element.
- **Zero doubling is a no-op**: When `result[i] == result[i+1] == 0`, doubling zero is still zero and setting the next to zero is idempotent. The algorithm handles this correctly without a special case.

### Error Handling

None — the function assumes valid input per the LeetCode contract (non-negative integers, length ≥ 1). No bounds checking or type validation. The `unittest` runner is the only error surface, and it uses standard `assertEqual` assertions.

## Topics to Explore

- [file] `apply-operations-to-an-array/test_solution.py` — How the external test file imports and exercises `performOps`, and whether it adds coverage beyond the inline tests
- [file] `move-zeroes/solution.py` — The standalone version of Phase 2's zero-compaction algorithm, likely using the same write-pointer technique
- [general] `sequential-pairwise-operations` — How left-to-right order dependency in Phase 1 creates subtle behavior (e.g., triple-element cascades) that differs from a simultaneous-application model
- [file] `apply-operations-to-an-array/review.md` — The code review notes for this solution, which may flag alternative approaches or complexity analysis

## Beliefs

- `apply-ops-nonmutating` — `performOps` copies the input with `nums[:]` and never modifies the original list
- `apply-ops-phase-order` — Phase 1 (pairwise doubling) must execute fully before Phase 2 (zero compaction); reversing or interleaving them produces incorrect results
- `apply-ops-left-to-right-dependency` — Phase 1 processes pairs left-to-right, so zeroing `result[i+1]` affects the comparison at index `i+1` vs `i+2` in the next iteration
- `apply-ops-zero-doubling-noop` — Adjacent zeros trigger the doubling branch but produce no observable change (0*2=0, set next to 0), so no special-casing is needed

