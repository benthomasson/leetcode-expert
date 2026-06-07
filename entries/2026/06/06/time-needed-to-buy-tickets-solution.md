# File: time-needed-to-buy-tickets/solution.py

**Date:** 2026-06-06
**Time:** 19:30

## Purpose

This file solves [LeetCode 2073: Time Needed to Buy Tickets](https://leetcode.com/problems/time-needed-to-buy-tickets/). It models a queue where each person buys one ticket per second, then goes to the back of the line. The function computes how many seconds elapse before the person at index `k` finishes buying all their tickets.

## Key Components

### `time_to_buy_tickets(tickets, k) -> int`

The single exported function. Instead of simulating the queue round by round (O(n * max(tickets))), it computes the answer in a single pass (O(n)) by reasoning about how many times each person gets to buy before person `k` finishes.

**Contract**: Given a list of positive integers `tickets` and a valid index `k`, returns the total seconds until `tickets[k]` reaches zero.

## Patterns

**Closed-form simulation avoidance.** The naive approach is to loop through the queue repeatedly, decrementing each person's count. This solution replaces that simulation with a mathematical observation:

- Person `i` standing **before or at** `k` (`i <= k`) gets to buy in every round that person `k` does, including `k`'s final round. So they contribute `min(tickets[i], tickets[k])` seconds.
- Person `i` standing **after** `k` (`i > k`) misses `k`'s final round — by the time it's their turn in that last round, `k` has already finished. So they contribute `min(tickets[i], tickets[k] - 1)` seconds.

This is a common LeetCode idiom: replacing an explicit simulation with per-element contribution analysis.

## Dependencies

**Imports**: None — pure function with no external dependencies.

**Imported by**: The "Imported By" list in the prompt is misleading — those are test files across the entire repo that likely share a common test runner or import pattern, not files that actually call `time_to_buy_tickets`. The real consumer is `time-needed-to-buy-tickets/test_solution.py`.

## Flow

1. Initialize `total = 0`.
2. Iterate over each person `(i, t)` in `tickets`.
3. For `i <= k`: add `min(t, tickets[k])` — this person buys in all rounds up to and including `k`'s last.
4. For `i > k`: add `min(t, tickets[k] - 1)` — this person doesn't get a turn in `k`'s final round.
5. Return `total`.

## Invariants

- **Index validity**: `k` must be a valid index into `tickets`. No bounds checking is performed.
- **Positive tickets**: The logic assumes `tickets[k] >= 1`. If `tickets[k] == 0`, the `tickets[k] - 1` term becomes `-1`, which would produce incorrect results (negative contributions from the `min`).
- **Ordering split at k**: The before/after asymmetry is the core invariant — people at indices `<= k` get one more round than people at indices `> k`.

## Error Handling

None. The function trusts its inputs per LeetCode conventions. Invalid inputs (empty list, out-of-bounds `k`, non-positive ticket counts) produce undefined behavior rather than exceptions.

## Topics to Explore

- [file] `time-needed-to-buy-tickets/test_solution.py` — Validate the edge cases: k at boundaries, single-element list, all-equal tickets
- [file] `time-needed-to-buy-tickets/plan.md` — See the initial problem decomposition and whether simulation was considered before the O(n) approach
- [file] `time-needed-to-buy-tickets/review.md` — Check if the review flagged the zero-ticket edge case or discussed the simulation-vs-closed-form tradeoff
- [general] `simulation-to-formula-pattern` — Many queue/circular problems (e.g., `number-of-students-unable-to-eat-lunch`, `pass-the-pillow`) use the same pattern of replacing simulation with per-element contribution
- [function] `pass-the-pillow/solution.py:passThePillow` — Another circular-traversal problem that likely uses modular arithmetic instead of simulation

## Beliefs

- `tickets-o-n-single-pass` — The solution runs in O(n) time with a single pass over the array, avoiding O(n * max(tickets)) simulation
- `split-at-k-boundary` — People at indices <= k contribute `min(t, tickets[k])` and people after k contribute `min(t, tickets[k] - 1)`, reflecting that post-k people miss the final round
- `tickets-k-ge-1-assumed` — The function assumes `tickets[k] >= 1`; a zero value would cause `tickets[k] - 1 = -1` and incorrect results from the `min` for post-k elements
- `no-imports-pure-function` — The solution has zero dependencies and is a pure function of its inputs

