# File: count-odd-numbers-in-an-interval-range/solution.py

**Date:** 2026-06-06
**Time:** 16:02

## Purpose

This file solves [LeetCode 1523 — Count Odd Numbers in an Interval Range](https://leetcode.com/problems/count-odd-numbers-in-an-interval-range/). It provides a single function `count_odds` that computes the count of odd integers in a closed interval `[low, high]` using O(1) arithmetic rather than iteration.

## Key Components

### `count_odds(low: int, high: int) -> int`

The only function. It returns the number of odd integers in `[low, high]` inclusive.

The formula `(high + 1) // 2 - low // 2` works by leveraging a counting identity:

- `(high + 1) // 2` gives the count of odd numbers in `[0, high]` (equivalently, `[1, high]`). For any integer `n`, there are `(n + 1) // 2` odd numbers in `[0, n]`.
- `low // 2` gives the count of odd numbers in `[0, low - 1]` (equivalently, `[1, low - 1]`). For any integer `m`, there are `m // 2` odd numbers in `[0, m - 1]`.

Subtracting yields the count in `[low, high]`.

**Walk-through with examples:**

| low | high | `(high+1)//2` | `low//2` | result | odds in range |
|-----|------|---------------|----------|--------|---------------|
| 3   | 7    | 4             | 1        | 3      | {3, 5, 7}     |
| 2   | 8    | 4             | 1        | 3      | {3, 5, 7}     |
| 1   | 1    | 1             | 0        | 1      | {1}           |
| 2   | 2    | 1             | 1        | 0      | {}            |

## Patterns

- **Closed-form math over iteration**: The hallmark of this solution — O(1) time and space, avoiding a loop from `low` to `high`. This is the standard pattern for counting problems on integer intervals.
- **Prefix-sum difference**: The formula is structurally `f(high) - f(low - 1)`, a prefix-sum technique applied to the "count of odds up to n" function.

## Dependencies

**Imports**: None — pure arithmetic, no standard library or project imports.

**Imported by**: The `test_solution.py` in the same directory. The "Imported By" list in the prompt is misleading — those are unrelated test files that happen to share a common test harness import pattern, not actual importers of `count_odds`.

## Flow

Straight-line: one expression, one return. No branching, no loops, no mutation.

## Invariants

- **Precondition (implicit)**: `low <= high` and both are non-negative integers. The LeetCode constraint is `0 <= low <= high <= 10^9`. The function doesn't validate this — it relies on the caller (the LeetCode judge) to satisfy it. If `low > high`, the result would be negative or zero, which is mathematically consistent but semantically wrong.
- **Integer division**: Python's `//` floors toward negative infinity, which matters if this were ever called with negative inputs. For the non-negative domain specified by the problem, `//` behaves identically to truncation.

## Error Handling

None. The function is a pure arithmetic expression with no failure modes for valid inputs. No exceptions are raised or caught.

## Topics to Explore

- [file] `count-odd-numbers-in-an-interval-range/test_solution.py` — See what edge cases the tests cover (both-even bounds, both-odd, single element, etc.)
- [file] `count-odd-numbers-in-an-interval-range/plan.md` — How the solution approach was derived before implementation
- [general] `prefix-count-difference-pattern` — The `f(high) - f(low-1)` technique appears across many LeetCode counting problems (count primes in range, count divisibles, etc.)
- [function] `count-negative-numbers-in-a-sorted-matrix/solution.py:countNegatives` — Another counting problem in this repo that may use a different strategy (matrix structure vs. closed-form)

## Beliefs

- `count-odds-is-o1` — `count_odds` runs in O(1) time and space with no loops or recursion
- `count-odds-prefix-difference` — The formula computes "odds in [0, high]" minus "odds in [0, low-1]" via integer division
- `count-odds-no-validation` — `count_odds` does not validate that `low <= high` or that inputs are non-negative; it trusts the caller
- `count-odds-pure-function` — `count_odds` is a pure function with no side effects, no imports, and no dependencies

