# File: minimum-amount-of-time-to-fill-cups/solution.py

**Date:** 2026-06-06
**Time:** 17:52

## Explanation

### Purpose

This file solves [LeetCode 2335: Minimum Amount of Time to Fill Cups](https://leetcode.com/problems/minimum-amount-of-time-to-fill-cups/). A water dispenser can fill **at most 2 cups of different types** per second (or 1 cup of any type). Given three cup counts, find the minimum seconds to fill all of them.

### Key Components

**`min_seconds(amount: list[int]) -> int`** — The sole function. It computes the answer as a closed-form expression rather than simulating the process:

```python
return max(max(amount), (sum(amount) + 1) // 2)
```

This takes the maximum of two lower bounds:

1. **`max(amount)`** — The dominant-type bound. Even if you pair the largest type with a different type every second, you still need at least this many seconds.
2. **`(sum(amount) + 1) // 2`** — The throughput bound. You fill at most 2 cups per second, so you need at least `ceil(total / 2)` seconds. The `+1` with integer division implements ceiling without floating point.

### Patterns

**Closed-form over simulation.** Many greedy solutions to this problem sort and re-pick the two largest counts each round (O(n * max) with a heap). This solution recognizes that both lower bounds are always *achievable* — you can always construct a valid filling schedule that hits whichever bound is tighter — so it collapses to O(1).

**Ceiling division idiom.** `(n + d - 1) // d` is the standard Python integer ceiling division pattern. Here `d = 2`, so it's `(sum + 1) // 2`.

### Dependencies

- **Imports:** None. Pure arithmetic on built-in types.
- **Imported by:** `minimum-amount-of-time-to-fill-cups/test_solution.py` (directly). The large "Imported By" list in the prompt is an artifact of the repo's test harness structure — those other test files don't actually import this solution.

### Flow

1. Compute `max(amount)` — the single largest cup count.
2. Compute `(sum(amount) + 1) // 2` — ceiling of half the total.
3. Return whichever is larger.

No loops, no branching, no mutation.

### Invariants

- `amount` must contain exactly 3 non-negative integers (per the problem constraints). The function doesn't validate this — it relies on the caller (LeetCode harness) to guarantee it.
- The result is always `>= max(amount)` and `>= ceil(sum(amount) / 2)`.

### Error Handling

None. An empty list would raise on `max(amount)`. Negative values would produce a mathematically valid but semantically meaningless result. Both are outside the problem's constraint space.

### Why the formula is correct

The key insight is a proof sketch: if `max(amount) >= sum_of_other_two`, the largest type dominates and you pair it with the others until they run out, then fill the rest alone — exactly `max(amount)` seconds. If `max(amount) < sum_of_other_two`, you can always interleave the three types to fill 2 cups every second (except possibly the last), giving `ceil(total / 2)`. In neither case can you do better, so these bounds are tight.

## Topics to Explore

- [file] `minimum-amount-of-time-to-fill-cups/test_solution.py` — See which edge cases are tested (all zeros, one dominant type, equal distribution)
- [file] `minimum-amount-of-time-to-fill-cups/plan.md` — The planning doc may capture the reasoning path from simulation to closed-form
- [general] `greedy-to-closed-form-reductions` — Other problems in this repo where a greedy simulation collapses to O(1) math (e.g., `count-of-matches-in-tournament`, `minimum-cuts-to-divide-a-circle`)
- [function] `minimum-amount-of-time-to-fill-cups/review.md` — Review notes may discuss the correctness proof or alternative approaches considered

## Beliefs

- `fill-cups-o1-time` — `min_seconds` runs in O(1) time and space regardless of input values
- `fill-cups-two-lower-bounds` — The result is always `max(max(amount), ceil(sum(amount)/2))`, and both bounds are achievable
- `fill-cups-no-validation` — The function assumes exactly 3 non-negative integers; it performs no input validation
- `fill-cups-ceiling-div-idiom` — `(sum(amount) + 1) // 2` computes `ceil(sum / 2)` using integer arithmetic, avoiding float precision issues

