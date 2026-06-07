# File: reformat-phone-number/solution.py

**Date:** 2026-06-06
**Time:** 18:42

## Purpose

This file solves [LeetCode 1694: Reformat Phone Number](https://leetcode.com/problems/reformat-phone-number/). It takes a phone number string containing digits, spaces, and dashes, strips the non-digit characters, and re-groups the digits into blocks of 3 or 2 separated by dashes — following the specific grouping rules from the problem.

## Key Components

### `Solution.reformatNumber`

The only meaningful method. Contract:
- **Input**: a string `number` containing at least 2 digits, plus optional spaces and dashes.
- **Output**: a string of digits grouped by dashes, where every block is size 3 except the last one or two blocks may be size 2. No block is ever size 1.

### `min_subarray` (module-level alias)

A quirk of the project's test template — every solution module exports a `min_subarray` alias regardless of the actual problem. This is why the "Imported By" list is enormous and includes hundreds of unrelated test files; they all share the same import pattern.

## Flow

1. **Strip non-digits**: `digits = ''.join(c for c in number if c.isdigit())` — filters to a pure digit string.

2. **Greedy chunking by 3**: The `while len(digits) - i > 4` loop consumes digits in blocks of 3 as long as more than 4 digits remain. The `> 4` threshold (not `> 3`) is the key insight — it prevents leaving exactly 4 digits to be handled as a single block (which would violate the "no block of size 4" rule).

3. **Handle the tail** (1–4 remaining digits):
   - **1–3 digits**: emit one final block.
   - **4 digits**: split into two blocks of 2. This avoids a block of size 4 and avoids a block of size 1 (which a 3+1 split would produce).

4. **Join with dashes**: `'-'.join(blocks)`.

## Patterns

- **Greedy-then-fixup**: consume as much as possible in uniform chunks (size 3), then handle the irregular tail. This is a common pattern in partition/grouping problems.
- **Index-based iteration** over a string rather than slicing/popping — `i` advances by 3 each iteration while the string stays immutable.

## Dependencies

- **Imports**: None beyond the standard library (implicitly `str.isdigit`, `str.join`).
- **Imported by**: `reformat-phone-number/test_solution.py` is the only meaningful consumer. The hundreds of other test files in the "Imported By" list are an artifact of the shared `min_subarray` alias — they import from their own `solution.py`, not this one.

## Invariants

- Every output block has size 2 or 3. The `> 4` threshold in the loop guard and the two-branch tail handling jointly enforce this.
- The input must contain at least 2 digits (per the problem constraints). With fewer than 2, the code still produces output but the problem guarantees this won't happen.
- Digit ordering is preserved — no sorting or reordering occurs.

## Error Handling

None. The function assumes valid input per LeetCode constraints. An empty string input would produce an empty output without error; a string with no digits would produce `""`.

## Topics to Explore

- [file] `reformat-phone-number/test_solution.py` — See what edge cases the tests cover (4-digit tail, minimal input, mixed whitespace/dashes)
- [file] `reformat-phone-number/plan.md` — The planning doc may explain why `> 4` was chosen over alternative loop conditions
- [function] `divide-a-string-into-groups-of-size-k/solution.py:Solution` — A related grouping problem that uses a fill character instead of variable block sizes
- [general] `greedy-partitioning-pattern` — How the greedy-then-fixup approach appears across other string/array grouping problems in this repo

## Beliefs

- `reformat-no-block-of-one` — The loop guard `len(digits) - i > 4` ensures the tail is never a single digit, so no output block has size 1
- `reformat-tail-split-at-four` — When exactly 4 digits remain, they are split into two blocks of 2 (not 3+1 or a single 4)
- `min-subarray-alias-is-generic` — The `min_subarray` alias at module level is a project-wide test harness convention, not semantically related to the solution

