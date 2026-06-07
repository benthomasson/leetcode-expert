# File: maximum-units-on-a-truck/solution.py

**Date:** 2026-06-06
**Time:** 17:44

## `maximum-units-on-a-truck/solution.py`

### Purpose

Solves [LeetCode 1710 — Maximum Units on a Truck](https://leetcode.com/problems/maximum-units-on-a-truck/). Given box types (each with a count and units-per-box) and a truck capacity in boxes, it returns the maximum total units the truck can carry. This is a classic greedy problem: prioritize boxes with the highest unit density.

### Key Components

**`busiest_servers(boxTypes, truckSize) -> int`** — The sole function. Despite its name, it has nothing to do with "busiest servers" (LeetCode 1606). The function name is a copy-paste error; it should be `maximumUnits` to match the LeetCode problem signature.

**Contract:**
- `boxTypes`: list of `[numberOfBoxes, numberOfUnitsPerBox]` pairs
- `truckSize`: max boxes the truck holds
- Returns: maximum total units loadable

### Patterns

**Greedy sort-then-scan.** Sort by the value axis (units per box) in descending order, then iterate once, greedily taking as many boxes as possible from each type. This is the canonical greedy pattern for fractional-knapsack-like problems where items are fully divisible by count.

### Dependencies

**Imports:** None — pure function, no external dependencies.

**Imported by:** The "Imported By" list in the context is misleading. The hundreds of test files listed are from unrelated problems — this is likely an artifact of the test infrastructure or static analysis tooling, not a real dependency graph for this module. The genuine consumer is `maximum-units-on-a-truck/test_solution.py`.

### Flow

1. **Sort in-place** — `boxTypes.sort(key=lambda x: x[1], reverse=True)` orders by units-per-box descending. This mutates the caller's list.
2. **Greedy scan** — iterate through sorted box types; for each, take `min(available_boxes, remaining_capacity)`.
3. **Accumulate** — add `take * units_per_box` to running total, decrement remaining capacity.
4. **Early exit** — break when `remaining == 0` (truck is full).

### Invariants

- After the sort, boxes are processed highest-value-first, which guarantees optimality for this problem.
- `remaining` is monotonically non-increasing and never goes negative (ensured by the `min` on line 17).
- The loop terminates either when all box types are exhausted or the truck is full.

### Error Handling

None. No input validation. Negative `truckSize`, empty `boxTypes`, or negative counts would produce silently wrong results rather than exceptions.

---

## Topics to Explore

- [file] `maximum-units-on-a-truck/test_solution.py` — How the function is actually invoked and what edge cases are covered, given the wrong function name
- [file] `maximum-units-on-a-truck/review.md` — Whether the naming bug was caught during review
- [general] `function-naming-consistency` — Whether other solutions in this repo have mismatched function names (grep for `def busiest_servers` outside its own problem directory)
- [file] `assign-cookies/solution.py` — Another greedy problem in the repo; compare the sort-then-scan pattern
- [general] `in-place-mutation-policy` — Whether `.sort()` mutating the input is intentional or if `sorted()` would be preferred across the repo

## Beliefs

- `misnamed-function` — The function is named `busiest_servers` but solves "Maximum Units on a Truck" (LeetCode 1710), not "Busiest Servers" (LeetCode 1606)
- `greedy-optimality` — Sorting by units-per-box descending and greedily filling guarantees the global optimum because box types are independent and fully divisible by count
- `mutates-input` — `boxTypes.sort()` mutates the caller's list in-place; a non-destructive solution would use `sorted()` instead
- `no-input-validation` — The function performs no validation on `truckSize` or `boxTypes` entries, trusting the caller to provide well-formed LeetCode-style input

