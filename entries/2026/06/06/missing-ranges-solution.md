# File: missing-ranges/solution.py

**Date:** 2026-06-06
**Time:** 18:06

## Missing Ranges — `missing-ranges/solution.py`

### Purpose

This file solves [LeetCode 163: Missing Ranges](https://leetcode.com/problems/missing-ranges/). Given a sorted array of unique integers and a `[lower, upper]` bound, it identifies all gaps — contiguous ranges of integers not present in `nums` but within the bounds — and returns them as formatted strings.

### Key Components

**`find_missing_ranges(nums, lower, upper) -> List[str]`** — The main solver. Walks the sorted array once, comparing each element against `next_expected`. Whenever `num > next_expected`, the gap `[next_expected, num - 1]` is a missing range. After the loop, any remaining gap between the last element and `upper` is captured.

**`_format_range(a, b) -> str`** — Formats a range as either a single number (`"3"`) when `a == b`, or an arrow-delimited pair (`"3->5"`) when `a < b`. This is a private helper — the underscore prefix signals it's an internal detail of this module.

### Patterns

- **Sentinel / boundary tracking**: Instead of inserting `lower - 1` and `upper + 1` into the array (a common alternative), the code uses `next_expected` as a running cursor. This avoids mutating or copying the input.
- **Post-loop residual check**: The `if next_expected <= upper` after the loop handles the tail gap — a standard idiom when a loop processes pairs of adjacent elements but the final boundary isn't paired with a successor.
- **Extract-and-name formatting**: Delegating string formatting to `_format_range` keeps the main function focused on gap detection logic.

### Dependencies

**Imports**: Only `List` from `typing` — no external or internal dependencies.

**Imported by**: `missing-ranges/test_solution.py` consumes this directly. The "Imported By" list in the prompt is misleading — those are test files across the entire repo that import from their own `solution.py`, not from this one.

### Flow

1. Initialize `result = []` and `next_expected = lower`.
2. For each `num` in the sorted input:
   - If `num > next_expected`, the integers `[next_expected, num - 1]` are missing. Format and append.
   - Advance `next_expected` to `num + 1`.
3. After the loop, if `next_expected <= upper`, the tail `[next_expected, upper]` is missing. Format and append.
4. Return `result`.

Time complexity: O(n). Space complexity: O(1) beyond the output list.

### Invariants

- **Input must be sorted and unique** — the algorithm doesn't verify this; it's a precondition from the problem statement. Duplicates or unsorted input would produce incorrect ranges.
- **All elements in `nums` are within `[lower, upper]`** — again a precondition. An element below `lower` would cause `next_expected` to skip past valid range starts; an element above `upper` would generate a spurious gap.
- **`_format_range` is only called with `a <= b`** — guaranteed by the `num > next_expected` guard (which ensures `next_expected <= num - 1`) and the `next_expected <= upper` guard.

### Error Handling

None. The function trusts its inputs per the LeetCode contract. No exceptions are raised or caught. If `nums` is empty, the loop body never executes, and the post-loop check captures the entire `[lower, upper]` range — this is correct behavior, not an error case.

## Topics to Explore

- [file] `missing-ranges/test_solution.py` — See what edge cases are covered (empty array, single-element, no gaps, full range missing)
- [file] `missing-ranges/plan.md` — The approach reasoning and alternative designs considered before implementation
- [function] `missing-ranges/solution.py:_format_range` — Trivial now, but worth checking if the LeetCode problem later changed its output format to `List[List[int]]` (which it did in newer versions)
- [general] `boundary-cursor-pattern` — Compare this `next_expected` approach against the alternative of prepending `lower-1` / appending `upper+1` to the array, used in some other solutions in this repo
- [file] `missing-number/solution.py` — Related problem with a different technique (arithmetic sum or XOR vs. linear scan)

## Beliefs

- `missing-ranges-linear-time` — `find_missing_ranges` processes the input in a single O(n) pass with no sorting, binary search, or set construction
- `missing-ranges-no-input-mutation` — The function never modifies `nums`; gap detection is driven entirely by the `next_expected` cursor
- `format-range-single-vs-arrow` — `_format_range` returns `"a"` when endpoints are equal and `"a->b"` otherwise; it is never called with `a > b`
- `missing-ranges-empty-input-correct` — When `nums` is empty, the function returns the single range `[lower, upper]` formatted as one string

