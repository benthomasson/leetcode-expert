# File: student-attendance-record-i/solution.py

**Date:** 2026-06-06
**Time:** 19:18

## Purpose

This file solves [LeetCode 551 — Student Attendance Record I](https://leetcode.com/problems/student-attendance-record-i/). It determines whether a student qualifies for an attendance award based on two disqualifying conditions in their attendance string:

1. **2 or more absences** (`'A'`) total
2. **3 or more consecutive lates** (`'L'`)

The string consists only of characters `'A'` (absent), `'L'` (late), and `'P'` (present).

## Key Components

### `Solution.checkRecord(self, s: str) -> bool`

Single-pass classifier over the attendance string. Returns `True` if the student is eligible (passes both constraints), `False` otherwise.

**Contract**: Input is a string of `{'A', 'L', 'P'}` characters. Output is a boolean. No mutation, no side effects.

## Patterns

**Early-exit accumulator**: The method uses two counters (`absences`, `consecutive_lates`) and returns `False` the moment either threshold is reached. This avoids scanning the rest of the string once a disqualifying condition is found.

**State reset on transition**: `consecutive_lates` is reset to 0 whenever a non-`'L'` character is encountered (both `'A'` and `'P'` branches). This is correct because the problem asks for *consecutive* lates — any interruption breaks the streak.

Note that `absences` is monotonically increasing (never reset), while `consecutive_lates` is reset on every non-`'L'` character. This reflects the difference between the two rules: absences are global, consecutive lates are local.

## Dependencies

**Imports**: None. Pure standard Python.

**Imported by**: The `test_solution.py` in the same directory. The massive "Imported By" list in the prompt is misleading — those are unrelated test files in sibling problem directories that happen to share the same module naming convention. They import their own `solution.py`, not this one.

## Flow

1. Initialize `absences = 0`, `consecutive_lates = 0`
2. For each character `c` in `s`:
   - `'A'`: increment `absences`, return `False` if `>= 2`, reset `consecutive_lates`
   - `'L'`: increment `consecutive_lates`, return `False` if `>= 3`
   - `'P'` (the `else`): reset `consecutive_lates` only
3. If the loop completes without returning `False`, return `True`

**Complexity**: O(n) time, O(1) space — single pass with two integer counters.

## Invariants

- At every point in the loop, `absences` equals the count of `'A'` characters seen so far.
- `consecutive_lates` equals the length of the current unbroken run of `'L'` characters ending at the current position (or 0 if the current character isn't `'L'`).
- The function returns `False` at the earliest possible moment — it never processes a character after a disqualifying condition is detected.

## Error Handling

None. The function trusts its input is a valid attendance string. Characters outside `{'A', 'L', 'P'}` silently fall into the `else` branch, behaving like `'P'` (resetting the late counter, not incrementing absences). This is fine for LeetCode's constrained input guarantees.

## Topics to Explore

- [file] `student-attendance-record-i/test_solution.py` — Validates edge cases like strings with exactly 2 A's, exactly 3 consecutive L's, and boundary combinations
- [file] `student-attendance-record-i/plan.md` — Documents the problem decomposition and approach selection before implementation
- [general] `student-attendance-record-ii` — LeetCode 552 is the hard DP variant of this problem (count valid strings of length n), a significant complexity jump
- [function] `delete-characters-to-make-fancy-string/solution.py:Solution.makeFancyString` — Uses a similar consecutive-character tracking pattern (no 3 consecutive identical chars)
- [general] `single-pass-with-early-exit` — A recurring pattern across this repo for problems with disqualifying conditions

## Beliefs

- `early-exit-on-disqualify` — `checkRecord` returns `False` immediately upon finding 2 absences or 3 consecutive lates, never scanning further than necessary
- `consecutive-late-reset-on-any-non-L` — Both `'A'` and `'P'` reset `consecutive_lates` to 0, meaning absences break a late streak (which matches the problem specification)
- `unknown-chars-treated-as-present` — Any character not `'A'` or `'L'` falls into the `else` branch and behaves identically to `'P'`
- `o1-time-o1-space` — The solution is O(n) time and O(1) space with exactly two integer counters

