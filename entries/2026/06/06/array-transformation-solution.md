# File: array-transformation/solution.py

**Date:** 2026-06-06
**Time:** 15:16

## `array-transformation/solution.py`

This solves [LeetCode 1243 - Array Transformation](https://leetcode.com/problems/array-transformation/). The problem: repeatedly adjust interior elements that are strict local minima (bump up by 1) or strict local maxima (bump down by 1), until the array stops changing.

### Key Components

**`array_transformation(arr: List[int]) -> List[int]`** — the sole export. Takes an integer array, returns the stable result after all transformations complete.

### Flow

1. **Defensive copy** (`arr = arr[:]`) — avoids mutating the caller's list.
2. **Fixed-point loop** (`while True`) — each iteration applies one round of transformations simultaneously:
   - Builds `new` as a snapshot of `arr`.
   - For each interior index `i` (1 through `len-2`), compares `arr[i]` against both neighbors **from the original round** (not the in-progress `new`), ensuring all updates within a round are based on the same state.
   - Local minima (`arr[i] < arr[i-1]` and `arr[i] < arr[i+1]`) get `+1`.
   - Local maxima (`arr[i] > arr[i-1]` and `arr[i] > arr[i+1]`) get `-1`.
   - Elements that are neither (plateaus, monotone runs, endpoints) stay unchanged.
3. **Convergence check** — if `new == arr`, the array is stable and returned. Otherwise `arr = new` and we loop.

### Patterns

- **Simultaneous update**: The classic cellular-automaton pattern — read from `arr`, write to `new`, then swap. This prevents earlier updates in the same pass from affecting later comparisons.
- **Fixed-point iteration**: Loop until output equals input. Guaranteed to terminate because local minima increase and local maxima decrease, monotonically narrowing the range of values toward their neighbors.

### Dependencies

- **Imports**: Only `typing.List` (type annotation).
- **Imported by**: `array-transformation/test_solution.py` directly. The massive "Imported By" list in the prompt is an artifact of the repo's test infrastructure — those other test files don't actually import this function.

### Invariants

- **Endpoints never change**: The loop runs over `range(1, len(arr) - 1)`, so `arr[0]` and `arr[-1]` are fixed throughout.
- **Strict inequality required**: An element equal to either neighbor is not a local extremum and stays put. This means plateaus are stable.
- **Convergence is guaranteed**: Each round can only move values toward their neighbors' range. Once no element is a strict local min or max, the process halts.

### Error Handling

None. The function assumes valid input (list of at least 1 integer, per the LeetCode constraints). An empty list would return immediately since the inner loop wouldn't execute and `new == arr` on the first check. A single-element list behaves the same way.

## Topics to Explore

- [file] `array-transformation/test_solution.py` — Verify which edge cases are covered (single element, two elements, already-stable arrays)
- [file] `array-transformation/plan.md` — See the original problem analysis and approach reasoning
- [general] `simultaneous-update-pattern` — Compare with other solutions in this repo that use the read-from-old/write-to-new idiom (e.g., `flood-fill`, `flipping-an-image`)
- [general] `fixed-point-convergence` — Why this loop always terminates: the sum of absolute differences to neighbors decreases monotonically each round
- [file] `array-transformation/review.md` — Check if the review flagged the O(n*k) time complexity where k is the number of rounds until convergence

## Beliefs

- `array-transform-endpoints-immutable` — The first and last elements of the array are never modified; only indices 1 through len-2 are candidates for change.
- `array-transform-simultaneous-update` — All comparisons in a single round use the pre-round snapshot (`arr`), not the in-progress mutations (`new`), making updates simultaneous rather than sequential.
- `array-transform-strict-comparison` — Only strict local minima/maxima trigger adjustments; elements equal to a neighbor are left unchanged.
- `array-transform-no-mutation` — The input list is copied on entry (`arr[:]`), so the caller's original list is never modified.

