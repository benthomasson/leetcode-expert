# File: maximum-population-year/solution.py

**Date:** 2026-06-06
**Time:** 17:41

## `maximum-population-year/solution.py`

### Purpose

This file solves [LeetCode 1854 — Maximum Population Year](https://leetcode.com/problems/maximum-population-year/). It determines the earliest year in which the most people are simultaneously alive, given a list of `[birth, death]` pairs where a person is alive during `[birth, death-1]` (i.e., death year is exclusive).

### Key Components

**`maxAliveYear(logs: list[list[int]]) -> int`** — The sole public function. Takes a list of birth/death pairs and returns the earliest year with peak population.

- **`delta`**: A 101-element array representing the year range 1950–2050. Each index maps to a year via `index + 1950`. Acts as a difference array where `+1` marks a birth and `-1` marks a death.
- **`running`**: Prefix-sum accumulator that reconstructs the actual population at each year from the delta array.
- **`max_pop` / `best_year`**: Track the maximum population seen so far and the corresponding year. Because the scan is left-to-right, the earliest year wins ties naturally.

### Patterns

**Difference array (sweep line)**: Instead of incrementing every year a person is alive (O(n * range)), the solution records only boundary events — `+1` at birth, `-1` at death — then reconstructs population via prefix sum. This is a standard O(n + range) technique for range-increment queries.

The year range is hardcoded to `[1950, 2050]` per the problem constraints, making the delta array a fixed 101 elements. The offset `- 1950` maps calendar years to zero-based indices.

### Dependencies

**Imports**: None. Pure algorithmic code with no external dependencies.

**Imported by**: The `test_solution.py` file in the same directory imports this function. The "Imported By" list in the prompt is misleading — those are unrelated test files that happen to share a test harness pattern, not actual consumers of this function.

### Flow

1. **Build delta array**: For each person `[birth, death]`, increment `delta[birth - 1950]` and decrement `delta[death - 1950]`. The decrement at `death` (not `death - 1`) is correct because the person is alive only through `death - 1`.
2. **Prefix-sum scan**: Walk `delta` left to right, accumulating `running`. At each index, if `running > max_pop`, update `max_pop` and `best_year`.
3. **Return `best_year`**.

### Invariants

- **Year range**: The problem guarantees `1950 <= birth < death <= 2050`. The delta array is sized exactly for this range. Out-of-range inputs would cause an index error.
- **Tie-breaking**: The left-to-right scan with strict `>` comparison guarantees the earliest year wins when multiple years share the same peak population.
- **Death exclusivity**: `delta[death - 1950] -= 1` correctly models the person not being alive in their death year. If you mistakenly used `death - 1`, you'd undercount the population drop by one year.

### Error Handling

None. The function assumes valid input per LeetCode constraints. An empty `logs` list returns `1950` (the initial `best_year` value with `max_pop = 0`), which is arguably wrong but matches LeetCode's constraint that `logs` is non-empty.

---

## Topics to Explore

- [file] `maximum-population-year/test_solution.py` — See how edge cases (single person, ties, adjacent intervals) are tested
- [file] `maximum-population-year/plan.md` — The solution approach and alternative strategies considered before implementation
- [general] `difference-array-technique` — The sweep-line / difference-array pattern reappears in problems like range addition, meeting rooms II, and car pooling
- [function] `meeting-rooms/solution.py:minMeetingRooms` — A related sweep-line problem that extends this pattern to find maximum overlap of intervals
- [file] `maximum-population-year/review.md` — Post-implementation review notes on correctness and complexity

## Beliefs

- `delta-array-off-by-one-correct` — The death-year decrement at `delta[death - 1950]` correctly models exclusive death semantics; a person born in 1990 who dies in 2000 contributes to population for years 1990–1999.
- `tie-breaking-earliest-year` — Strict `>` in the comparison `running > max_pop` guarantees the earliest year is returned when multiple years share peak population.
- `fixed-range-assumption` — The solution hardcodes the year range `[1950, 2050]` (101 elements); inputs outside this range will raise an `IndexError`.
- `linear-time-complexity` — The algorithm runs in O(n + R) time where n is the number of log entries and R is the fixed range (101), making it effectively O(n).

