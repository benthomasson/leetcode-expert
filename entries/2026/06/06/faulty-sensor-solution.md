# File: faulty-sensor/solution.py

**Date:** 2026-06-06
**Time:** 16:31

## `faulty-sensor/solution.py`

### Purpose

This file solves [LeetCode 1826 — Faulty Sensor](https://leetcode.com/problems/faulty-sensor/). Given two sensor arrays that should be identical but one may have dropped a single reading (causing all subsequent values to shift left by one, with an arbitrary value appended at the end), determine which sensor is defective — or report that it's indeterminate.

### Key Components

**`Solution.badSensor(sensor1, sensor2) -> int`**

The single method. Contract:
- **Input**: Two integer lists of equal length representing sensor readings.
- **Output**: `1` if sensor1 is defective, `2` if sensor2 is, `-1` if it can't be determined (either both hypotheses hold or neither does).

### Flow

The algorithm has three stages:

1. **Find first divergence** (lines 14–16): Walk both arrays in lockstep until a mismatch is found. This prefix of agreement tells us nothing — the defect must be at or after position `i`.

2. **Early exit** (lines 18–19): If `i >= n - 1`, the arrays are either identical or differ only at the very last element. In both cases, you can't distinguish which sensor dropped a value — either hypothesis produces a valid shifted suffix — so return `-1`.

3. **Test both hypotheses** (lines 21–27): 
   - **`s1_bad`**: If sensor1 dropped the value at index `i`, then `sensor1[i:n-1]` (the shifted tail) should equal `sensor2[i+1:]` (the original tail after the mismatch).
   - **`s2_bad`**: Symmetric check — if sensor2 dropped a value, `sensor2[i:n-1]` should equal `sensor1[i+1:]`.
   
   If both or neither hypothesis holds, return `-1`. Otherwise return which sensor is faulty.

### Patterns

- **Two-pointer prefix scan** to find the first point of interest, skipping irrelevant matching prefix.
- **Slice comparison** for suffix matching — idiomatic Python, leveraging list equality. This is O(n) but concise.
- **Symmetry exploitation**: The two hypotheses are mirror images of each other, tested with the same shape of slice comparison.

### Dependencies

- **Imports**: Only `typing.List` (standard library type hint).
- **Imported by**: `faulty-sensor/test_solution.py` for testing.

### Invariants

- Both input arrays must have the same length (problem constraint, not validated).
- The `i >= n - 1` guard is critical: when the mismatch is at the last position, both shift hypotheses trivially succeed because the "shifted tail" is empty, making the result indeterminate.
- The slice `sensor1[i:n-1]` intentionally drops the last element — that's the "garbage" value appended by the sensor after the shift.

### Error Handling

None. The code trusts its inputs per LeetCode conventions — no bounds checking, no type validation. Invalid inputs (different-length arrays, empty arrays) would produce undefined behavior, not exceptions.

## Topics to Explore

- [file] `faulty-sensor/test_solution.py` — Test cases reveal edge cases: identical arrays, last-element-only difference, ambiguous shifts
- [general] `shift-detection-problems` — Family of problems where one sequence is a shifted/deleted version of another (e.g., check-if-array-is-sorted-and-rotated, remove-one-element-to-make-the-array-strictly-increasing)
- [function] `faulty-sensor/solution.py:badSensor` — Trace through a case where both hypotheses hold (e.g., `[1,2,2,2]` and `[1,2,2,2]`) to internalize the `-1` return path
- [file] `faulty-sensor/plan.md` — Design rationale and alternative approaches considered before implementation

## Beliefs

- `faulty-sensor-indeterminate-when-suffix-trivial` — When the first mismatch is at or beyond `n-1`, the method always returns `-1` because both shift hypotheses are vacuously satisfiable.
- `faulty-sensor-slice-comparison-is-o-n` — The two slice equality checks each copy and compare up to `n` elements, making the overall algorithm O(n) time and O(n) space.
- `faulty-sensor-mutual-exclusion-decides` — The method returns a definitive answer (1 or 2) only when exactly one of the two shift hypotheses matches; if both match or neither does, it returns `-1`.
- `faulty-sensor-no-input-validation` — The method assumes both arrays are the same length and non-empty, with no defensive checks.

