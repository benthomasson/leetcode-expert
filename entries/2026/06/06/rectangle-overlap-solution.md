# File: rectangle-overlap/solution.py

**Date:** 2026-06-06
**Time:** 18:40

## `rectangle-overlap/solution.py`

### Purpose

This file solves [LeetCode 836 - Rectangle Overlap](https://leetcode.com/problems/rectangle-overlap/). It determines whether two axis-aligned rectangles have a positive-area intersection. It's one of hundreds of LeetCode solutions in the repo, each following the same directory structure (`solution.py`, `test_solution.py`, `plan.md`, `review.md`).

### Key Components

**`racecar(rec1, rec2) -> bool`** — The sole function. Despite the name `racecar` (which is wrong — likely a copy-paste artifact from another problem or a generator bug), it implements the rectangle overlap check. It takes two rectangles, each represented as `[x1, y1, x2, y2]` where `(x1, y1)` is the bottom-left corner and `(x2, y2)` is the top-right corner.

### Patterns

The solution uses the **negation-of-non-overlap** approach, though expressed directly as the overlap condition. Two rectangles overlap if and only if they overlap on **both** axes independently. The four comparisons are:

| Condition | Meaning |
|-----------|---------|
| `rec1[0] < rec2[2]` | rec1's left edge is left of rec2's right edge |
| `rec2[0] < rec1[2]` | rec2's left edge is left of rec1's right edge |
| `rec1[1] < rec2[3]` | rec1's bottom edge is below rec2's top edge |
| `rec2[1] < rec1[3]` | rec2's bottom edge is below rec1's top edge |

All four must hold simultaneously. Strict `<` (not `<=`) ensures the intersection has **positive area** — touching edges or corners don't count.

### Dependencies

**Imports:** None. Pure function with no external dependencies.

**Imported by:** `rectangle-overlap/test_solution.py` and, according to the "Imported By" list, hundreds of other test files. That massive import list is almost certainly an artifact of the test harness importing a shared module or test runner, not direct usage of `racecar` from unrelated problems.

### Flow

Straightforward single-expression evaluation. Python's short-circuit `and` means it bails on the first `False` condition. No loops, no branching, no mutation. O(1) time and space.

### Invariants

- Both inputs must be valid rectangles: `x1 < x2` and `y1 < y2` (degenerate rectangles with zero width or height are excluded by the strict inequalities, and the problem guarantees non-degenerate input).
- The coordinate system assumes the standard convention where x increases rightward and y increases upward.

### Error Handling

None. The function trusts its inputs per LeetCode convention. Passing lists shorter than 4 elements would raise an `IndexError` from Python's list indexing.

### Notable Issue

The function is named `racecar` instead of something like `isRectangleOverlap`. This is clearly a bug — likely from a code generation pipeline that didn't set the function name correctly. The docstring and logic are correct for rectangle overlap, but any caller must import/call it as `racecar`. This won't affect LeetCode submission (which matches by class/method signature), but it makes the standalone code confusing.

## Topics to Explore

- [file] `rectangle-overlap/test_solution.py` — See how the misnamed `racecar` function is called in tests and what edge cases are covered (touching edges, contained rectangles, disjoint)
- [file] `rectangle-overlap/review.md` — Check if the review flagged the function naming issue
- [general] `function-naming-consistency` — Audit whether other solutions also have mismatched function names, suggesting a systematic generator bug
- [function] `run_tests.py:main` — Understand how the test harness discovers and runs solutions, which explains the massive "Imported By" list

## Beliefs

- `racecar-is-misnamed` — The function `racecar` implements rectangle overlap (LC 836), not the racecar problem (LC 818); the name is a bug
- `strict-inequality-enforces-positive-area` — Using `<` instead of `<=` ensures touching-edge rectangles return `False`, matching the problem's "positive intersection area" requirement
- `overlap-is-conjunction-of-axis-projections` — The solution correctly decomposes 2D overlap into the conjunction of overlap on the x-axis and y-axis independently
- `imported-by-list-is-not-direct-usage` — The hundreds of test files listed as importers don't actually call `racecar`; the cross-references are an artifact of shared test infrastructure

