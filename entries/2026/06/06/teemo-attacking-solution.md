# File: teemo-attacking/solution.py

**Date:** 2026-06-06
**Time:** 19:26

## `teemo-attacking/solution.py`

### Purpose

This file solves [LeetCode 495 — Teemo Attacking](https://leetcode.com/problems/teemo-attacking/). It calculates the total duration that a target (Ashe) is poisoned given a series of attack timestamps and a fixed poison duration per attack. The key insight is that overlapping poison windows don't stack — a new attack resets the poison timer rather than extending it additively.

### Key Components

**`find_poisoned_duration(timeSeries, duration) -> int`**

The sole public function. Contract:
- **Input**: `timeSeries` — a non-decreasing list of integer timestamps; `duration` — a positive integer for how long each poison lasts.
- **Output**: total seconds the target is poisoned.
- **Edge cases handled**: empty `timeSeries` or zero `duration` both short-circuit to `0`.

### Patterns

**Greedy adjacent-pair comparison.** Rather than simulating time or merging intervals, the solution compares each consecutive pair of attacks and takes the minimum of the gap between them and the full duration. This is the standard O(n) greedy approach for interval-merge-style problems where intervals have uniform length.

The final `total += duration` on line 21 accounts for the last attack, which always contributes its full duration since no subsequent attack can truncate it.

### Dependencies

**Imports**: None — pure stdlib, no external dependencies.

**Imported by**: `teemo-attacking/test_solution.py` directly. The massive "Imported By" list in the prompt is an artifact of the repo's test harness structure — those other test files don't actually import this solution; they follow the same pattern but for their own problems.

### Flow

1. Guard clause: return 0 if inputs are trivially empty/zero.
2. Iterate pairs `(timeSeries[i], timeSeries[i+1])` for `i` in `[0, n-2]`.
3. For each pair, add `min(gap, duration)` to the running total. The `min` encodes the overlap logic: if the next attack comes before the current poison expires (`gap < duration`), only the gap counts; otherwise the full duration counts.
4. Add `duration` once for the final attack.
5. Return total.

### Invariants

- `timeSeries` is assumed sorted (non-decreasing) — the algorithm relies on `timeSeries[i+1] - timeSeries[i] >= 0`. No sort or validation is performed.
- Each gap contribution is clamped to `[0, duration]` by the `min`. Negative gaps can't occur given the sorted precondition.
- The last attack always contributes exactly `duration` seconds — there's no subsequent attack to truncate it.

### Error Handling

Minimal. The function guards against empty input and zero duration but does not validate types, negative values, or unsorted input. This is typical for LeetCode solutions where inputs are guaranteed by the problem constraints.

## Topics to Explore

- [file] `teemo-attacking/test_solution.py` — See what edge cases and boundary conditions are tested
- [file] `teemo-attacking/plan.md` — Read the problem decomposition and approach reasoning before implementation
- [file] `teemo-attacking/review.md` — Check the code review findings for this solution
- [general] `interval-merge-problems` — This greedy adjacent-pair pattern recurs in problems like Meeting Rooms, Merge Intervals, and Non-overlapping Intervals
- [file] `diet-plan-performance/solution.py` — Another sliding-window / sequential-scan problem in the repo for comparison

## Beliefs

- `teemo-no-interval-merging` — The solution avoids explicit interval construction or merging; it computes total poisoned time in a single O(n) pass using adjacent-pair min-clamping.
- `teemo-last-attack-full-duration` — The final attack always contributes exactly `duration` to the total, encoded by the unconditional `total += duration` after the loop.
- `teemo-sorted-precondition` — Correctness depends on `timeSeries` being non-decreasing; no runtime check enforces this.
- `teemo-overlap-semantics` — When two attacks overlap (`gap < duration`), only the gap between them counts — the poison timer resets rather than stacking.

