# File: the-employee-that-worked-on-the-longest-task/solution.py

**Date:** 2026-06-06
**Time:** 19:27

## `the-employee-that-worked-on-the-longest-task/solution.py`

### Purpose

This file solves [LeetCode 2432: The Employee That Worked on the Longest Task](https://leetcode.com/problems/the-employee-that-worked-on-the-longest-task/). It owns the single responsibility of determining which employee worked the longest uninterrupted task, given a chronological log of task completions.

### Key Components

**`worker_with_longest_task(n, logs)`** — The sole public function.

- **Inputs**: `n` (number of employees, unused in the logic but part of the LeetCode signature), `logs` (a list of `[employee_id, leave_time]` pairs sorted ascending by `leave_time`).
- **Output**: The `employee_id` of whoever worked the single longest task. On a tie, the smallest `employee_id` wins.

### Patterns

**Single-pass greedy scan.** The function iterates through `logs` once, maintaining the best candidate seen so far. This is the canonical pattern for "find the max/min with a tiebreaker" problems — O(n) time, O(1) space.

**Implicit first-task handling.** The first entry's duration is `logs[0][1] - 0`, which equals `logs[0][1]`. The code seeds `best_duration` with `logs[0][1]` directly, avoiding an explicit subtraction from zero. The loop then starts at index 1, computing subsequent durations as deltas between consecutive leave times.

### Dependencies

**Imports**: None. Pure function with no external dependencies.

**Imported by**: The `test_solution.py` in the same directory. The "Imported By" list in the prompt is misleading — those are unrelated test files across the repo, likely an artifact of a shared test runner or import-scanning tool, not actual consumers of this function.

### Flow

1. Seed `best_id` and `best_duration` from the first log entry (task started at time 0, ended at `logs[0][1]`).
2. Track `prev_time` as the end of the last task.
3. For each subsequent entry `i`:
   - Compute `duration = logs[i][1] - prev_time`.
   - Update best if this duration is strictly longer, **or** equal duration with a smaller employee id.
   - Advance `prev_time`.
4. Return `best_id`.

### Invariants

- **`logs` is non-empty and sorted by leave time.** The code indexes `logs[0]` unconditionally — an empty list would crash.
- **Tie-breaking favors the smaller id.** The condition `duration == best_duration and logs[i][0] < best_id` ensures that if two tasks have equal length, the employee with the lower id is retained. This matches the problem's specification exactly.
- **`n` is accepted but unused.** The employee count doesn't affect the algorithm; it exists only to match the LeetCode function signature.

### Error Handling

None. The function trusts its inputs entirely — no validation of list bounds, types, or sort order. This is standard for LeetCode solutions operating within guaranteed constraints.

---

## Topics to Explore

- [file] `the-employee-that-worked-on-the-longest-task/test_solution.py` — See what edge cases the tests cover (empty logs, single entry, ties)
- [file] `the-employee-that-worked-on-the-longest-task/review.md` — The review may note alternative approaches or subtle correctness issues
- [function] `slowest-key/solution.py:slowestKey` — Structurally similar problem (find the max-duration event with a tiebreaker), worth comparing approaches
- [general] `greedy-single-pass-pattern` — Many solutions in this repo use the seed-then-scan pattern; understanding it as a template accelerates reading other files

## Beliefs

- `first-task-starts-at-zero` — The first task's duration is implicitly `logs[0][1] - 0`, which the code captures by seeding `best_duration = logs[0][1]`
- `tie-break-smallest-id` — When two tasks have equal duration, the function retains the employee with the strictly smaller id, not the one encountered first
- `parameter-n-unused` — The `n` parameter exists solely to match the LeetCode signature and has no effect on the output
- `single-pass-o1-space` — The algorithm makes exactly one pass over `logs` and uses constant auxiliary space (three scalars)

