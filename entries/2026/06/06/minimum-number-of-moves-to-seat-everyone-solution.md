# File: minimum-number-of-moves-to-seat-everyone/solution.py

**Date:** 2026-06-06
**Time:** 17:59

## `minimum-number-of-moves-to-seat-everyone/solution.py`

### Purpose

This file solves [LeetCode 2037: Minimum Number of Moves to Seat Everyone](https://leetcode.com/problems/minimum-number-of-moves-to-seat-everyone/). It contains both the solution and its unit tests in a single module — the standard structure across this repository. The problem: given two arrays of equal length (seat positions and student positions), find the minimum total number of moves to assign each student to a unique seat, where a "move" is one position left or right.

### Key Components

**`min_moves_to_seat(seats, students) -> int`** — The sole function. It accepts two `list[int]` of equal length and returns the minimum total displacement. The entire implementation is a one-liner:

```python
return sum(abs(a - b) for a, b in zip(sorted(seats), sorted(students)))
```

**`TestMinMovesToSeat`** — Seven test cases covering LeetCode's three examples, single-element input, already-matched arrays, uniform positions, and duplicate values.

### Patterns

**Sort-and-pair greedy.** The solution sorts both arrays independently, then zips them together and sums the absolute differences. This is the canonical greedy approach for minimum-cost bipartite matching on a line: when both sequences are sorted, pairing the i-th smallest seat with the i-th smallest student is provably optimal. Any crossing assignment would increase total cost (by the rearrangement inequality).

**Single-file solution+test layout.** Consistent with every other problem directory in this repo — `solution.py` contains the function and inline `unittest` tests, runnable via `python -m unittest` or `if __name__ == "__main__"`.

### Dependencies

**Imports:** Only `unittest` from the standard library. No external packages.

**Imported by:** The massive `imported_by` list is misleading — it reflects test files across the repo that likely share a test runner (`run_tests.py`) or import infrastructure, not direct usage of `min_moves_to_seat` itself.

### Flow

1. `sorted(seats)` and `sorted(students)` produce two ascending copies — O(n log n) each.
2. `zip(...)` pairs elements by index — the smallest seat with the smallest student, etc.
3. `abs(a - b)` computes per-pair displacement.
4. `sum(...)` aggregates total moves.

The entire computation is a single pass over two sorted arrays. Time complexity: **O(n log n)** dominated by the sorts. Space: **O(n)** for the sorted copies.

### Invariants

- Both input lists must have the same length (enforced by the problem contract, not by code). If they differ, `zip` silently truncates to the shorter one — producing a wrong answer, not an error.
- The greedy pairing is optimal only because displacement is an absolute-value (convex) cost on a 1D line. The code implicitly relies on this mathematical property.

### Error Handling

None. The function trusts its inputs match the LeetCode specification. No length checks, no type validation. Empty lists return 0 (correct — `sum` of an empty generator).

## Topics to Explore

- [function] `height-checker/solution.py:heightChecker` — Another sort-and-compare-by-index pattern; compare how the same greedy insight applies to counting mismatches vs. summing displacements
- [general] `greedy-sort-pair-optimality` — Why sorting both arrays and pairing by rank minimizes total absolute displacement (rearrangement inequality proof)
- [file] `array-partition/solution.py` — Related problem where pairing sorted elements optimizes a different objective (maximizing sum of pair minimums)
- [file] `run_tests.py` — The shared test runner that explains why hundreds of `test_solution.py` files appear in the `imported_by` list

## Beliefs

- `sort-pair-greedy-optimal` — Sorting both arrays and pairing by index always yields the minimum total absolute displacement for 1D assignment problems
- `zip-truncation-silent` — If `seats` and `students` have different lengths, the function silently returns a partial (wrong) answer rather than raising
- `o-n-log-n-complexity` — The solution's time complexity is O(n log n) due to the two sorts; the summation pass is O(n)
- `empty-input-returns-zero` — Passing two empty lists returns 0 without error, which is the correct answer for the vacuous case

