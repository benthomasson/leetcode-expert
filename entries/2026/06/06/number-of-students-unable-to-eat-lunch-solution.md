# File: number-of-students-unable-to-eat-lunch/solution.py

**Date:** 2026-06-06
**Time:** 18:23

## Purpose

This file solves [LeetCode 1700: Number of Students Unable to Eat Lunch](https://leetcode.com/problems/number-of-students-unable-to-eat-lunch/). The problem simulates a cafeteria queue: students line up for sandwiches, each student prefers either circular (0) or square (1) sandwiches, and the sandwich stack is served top-first. A student who doesn't like the top sandwich goes to the back of the line. The process deadlocks when no remaining student wants the top sandwich.

## Key Components

### `countStudents(students, sandwiches) -> int`

The main solver. Takes two lists of 0s and 1s and returns how many students can't eat.

**Contract**: `students` contains preferences (0 or 1), `sandwiches` is an ordered stack (index 0 = top). Returns a non-negative integer in `[0, len(students)]`.

### `min_time_to_remove_balloons`

A module-level alias pointing to `countStudents`. Likely exists because the test harness or a related problem variant expects this name.

## Patterns

**Counter-based simulation avoidance.** The naive approach simulates the queue rotation — O(n^2) in the worst case. This solution recognizes that the queue order doesn't matter: what matters is *whether any student remaining wants the current top sandwich*. A `Counter` tracks how many students want each type. This reduces the problem to a single linear scan of the sandwich stack.

This is a common idiom in this repo's solutions: replace simulation with counting/frequency analysis when the order of consumption is determined by supply, not queue position.

## Dependencies

**Imports**: `collections.Counter` — the only dependency. No custom modules.

**Imported by**: The `test_solution.py` in this same directory. The massive "Imported By" list in the metadata is an artifact of the repo's test infrastructure — those test files likely share a common import pattern, not a direct dependency on this module.

## Flow

1. Count how many students want type-0 vs type-1 sandwiches.
2. Iterate through sandwiches top-to-bottom.
3. For each sandwich `s`: if `count[s] == 0`, no remaining student wants it — the queue is deadlocked. Return the sum of all remaining students (`count[0] + count[1]`).
4. Otherwise, decrement `count[s]` (one student of that preference eats) and continue.
5. If all sandwiches are consumed, return 0.

## Invariants

- At any point during iteration, `count[0] + count[1]` equals the number of students still waiting.
- The loop terminates either at a deadlock (early return) or after exhausting all sandwiches.
- The algorithm is correct because queue rotation only changes *when* a student eats, not *whether* they eat. A student of the right type will always eventually reach the front — unless the top sandwich has no takers at all.

## Error Handling

None. The function assumes valid input per LeetCode constraints (non-empty lists of 0s and 1s, equal lengths). No bounds checking, type validation, or exception handling — appropriate for a competitive programming solution.

## Topics to Explore

- [file] `number-of-students-unable-to-eat-lunch/test_solution.py` — See which edge cases are tested (empty inputs, all-same preferences, immediate deadlock)
- [file] `number-of-students-unable-to-eat-lunch/plan.md` — The planning doc may explain why simulation was rejected in favor of counting
- [function] `time-needed-to-buy-tickets/solution.py:timeNeedsToBuyTickets` — Another queue-simulation problem likely solved with a similar "skip the simulation" insight
- [general] `counter-over-simulation` — Survey other solutions in this repo that replace queue/stack simulation with frequency counting (e.g., `lemonade-change`, `implement-queue-using-stacks`)

## Beliefs

- `counter-deadlock-detection` — The algorithm detects deadlock by checking `count[s] == 0`, which is equivalent to "no student in the queue wants the current top sandwich," regardless of queue ordering.
- `linear-time-guarantee` — The solution runs in O(n) time and O(1) space (the Counter has at most 2 keys), compared to O(n^2) for naive simulation.
- `queue-order-irrelevance` — The correctness relies on the insight that queue position determines eating order but not eating possibility — any student of the matching type will eventually rotate to the front.
- `alias-is-identity` — `min_time_to_remove_balloons` is the same function object as `countStudents`, not a wrapper — calling either has identical behavior.

