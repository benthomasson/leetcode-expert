# File: intersection-of-two-arrays/solution.py

**Date:** 2026-06-06
**Time:** 17:07

## `intersection-of-two-arrays/solution.py`

### Purpose

This file implements the solution to [LeetCode 349: Intersection of Two Arrays](https://leetcode.com/problems/intersection-of-two-arrays/). It owns the responsibility of computing the unique common elements between two integer arrays. In this repo's structure, each problem gets its own directory with `solution.py`, `test_solution.py`, `plan.md`, and `review.md` — this is the executable solution module.

### Key Components

**`Solution.intersection(nums1, nums2) -> List[int]`** — The sole public method. Takes two lists of integers and returns a list of integers that appear in both, with no duplicates.

The contract: given any two integer lists (including empty), return a list containing each shared value exactly once, in arbitrary order.

### Patterns

**Set intersection idiom** — The implementation converts both inputs to sets and uses Python's `&` operator (set intersection), then converts back to a list. This is the canonical Pythonic one-liner for this problem class. It delegates all deduplication and membership testing to the built-in `set` type.

**LeetCode class convention** — The `Solution` class with a specifically-named method matches LeetCode's expected submission format. The class is stateless; it's purely a namespace for the method.

### Dependencies

**Imports:** `List` from `typing` — used only for the type annotation in the method signature.

**Imported by:** The `test_solution.py` in this same directory imports the `Solution` class. The massive "Imported By" list in the repo context is misleading — those are test files for *other* problems that happen to share the same import pattern (`from solution import Solution`), not actual consumers of this specific file.

### Flow

1. `set(nums1)` — O(n) construction, deduplicates `nums1`
2. `set(nums2)` — O(m) construction, deduplicates `nums2`
3. `&` — set intersection, iterates the smaller set and probes the larger; O(min(n, m)) average
4. `list(...)` — materializes the result set into a list

Total: O(n + m) time, O(n + m) space.

### Invariants

- Output contains no duplicates (guaranteed by set intersection).
- Output order is not guaranteed — sets are unordered. LeetCode accepts any order for this problem.
- Elements in the output are a subset of both input arrays.

### Error Handling

None. The method trusts its inputs are `List[int]` as typed. Empty inputs naturally produce an empty result (empty set intersection). No validation, no exceptions — appropriate for a LeetCode solution where input constraints are guaranteed by the judge.

## Topics to Explore

- [file] `intersection-of-two-arrays-ii/solution.py` — The follow-up problem (LeetCode 350) where duplicates must be preserved in the output, requiring a different approach (Counter/multiset instead of set)
- [file] `intersection-of-two-arrays/test_solution.py` — See what edge cases are covered (empty arrays, no overlap, full overlap, duplicates in input)
- [file] `intersection-of-three-sorted-arrays/solution.py` — Extension to three sorted arrays — likely uses a different strategy exploiting the sorted invariant
- [function] `intersection-of-multiple-arrays/solution.py:intersection` — Generalization to N arrays; check whether it chains pairwise intersection or uses `set.intersection(*sets)`
- [general] `set-vs-sorting-tradeoff` — When the interviewer asks for O(1) extra space, the sorted two-pointer approach becomes relevant; compare with the hash-based approach here

## Beliefs

- `intersection-returns-unique` — `Solution.intersection` never returns duplicate values, regardless of duplicates in the inputs
- `intersection-time-linear` — The solution runs in O(n + m) average time via hash-based set operations, not O(n log n) sorting
- `intersection-order-nondeterministic` — Output element order is not guaranteed and may vary across Python versions or runs
- `intersection-no-mutation` — The method does not modify `nums1` or `nums2`; it constructs new sets from them

