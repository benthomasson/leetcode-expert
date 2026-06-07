# File: logger-rate-limiter/solution.py

**Date:** 2026-06-06
**Time:** 17:24

## Logger Rate Limiter — LeetCode 359

### Purpose

This file implements the solution for [LeetCode 359: Logger Rate Limiter](https://leetcode.com/problems/logger-rate-limiter/). It provides a `Logger` class that acts as a message deduplication filter with a 10-second cooldown window. Its single responsibility is answering: "should this message be printed right now, given when it was last printed?"

### Key Components

**`Logger` class** — A stateful rate limiter with two members:

- `self.next_allowed: dict[str, int]` — Maps each message string to the earliest timestamp at which it can next be printed. This is the only state.
- `shouldPrintMessage(timestamp, message) -> bool` — The core method. Returns `True` and advances the cooldown window if the message is eligible; returns `False` otherwise.

### Patterns

**Lazy initialization via `dict.get` with default** — Instead of checking `message in self.next_allowed` and then branching, the code uses `self.next_allowed.get(message, 0)`. A never-seen message returns `0`, which any non-negative timestamp will satisfy. This collapses "first time" and "cooldown expired" into a single code path.

**Store-next-allowed instead of store-last-seen** — Rather than recording the last timestamp a message was printed and computing `timestamp - last >= 10` on each call, it precomputes `timestamp + 10` at acceptance time. This trades one subtraction per query for one addition per acceptance — a wash computationally, but it makes the comparison `timestamp >= self.next_allowed[message]` read more naturally.

### Dependencies

- **Imports**: None beyond builtins. The solution is self-contained.
- **Imported by**: `logger-rate-limiter/test_solution.py` directly. The massive "Imported By" list in the prompt is an artifact of the test harness — those other test files don't actually import this `Logger` class; they import their own respective solutions.

### Flow

1. Caller creates a `Logger()` instance — `next_allowed` starts empty.
2. On each `shouldPrintMessage(timestamp, message)` call:
   - Look up the message's next-allowed timestamp (default `0` if absent).
   - If `timestamp >= next_allowed`: update the entry to `timestamp + 10`, return `True`.
   - Otherwise: return `False`, no state change.

The entire decision is a single dict lookup + comparison. O(1) per call, O(n) space where n is the number of distinct messages ever seen.

### Invariants

- **Timestamps are non-decreasing** — the problem guarantees this. The solution relies on it: it never needs to handle a "late" message arriving before an earlier one that already advanced the window.
- **10-second cooldown is exclusive at the boundary** — `timestamp + 10` means the same message at exactly t+10 *will* be printed (`10 >= 10`). The window is `[t, t+10)` blocked, `[t+10, ∞)` open.
- **No memory eviction** — `next_allowed` grows monotonically. Every distinct message ever seen lives in the dict forever. Fine for LeetCode constraints, but a production rate limiter would need TTL-based eviction.

### Error Handling

None. The problem contract guarantees valid inputs (non-negative integers, non-null strings, non-decreasing timestamps). The code trusts those guarantees entirely — no validation, no exceptions.

## Topics to Explore

- [file] `logger-rate-limiter/test_solution.py` — See the test cases to understand edge behavior at the 10-second boundary
- [file] `logger-rate-limiter/plan.md` — The problem decomposition and approach selection before coding
- [general] `unbounded-dict-growth` — In production systems, this pattern leaks memory; explore sliding-window or LRU alternatives
- [function] `moving-average-from-data-stream/solution.py:MovingAverage` — Another stateful design problem using a similar "class with method calls over time" pattern
- [file] `number-of-recent-calls/solution.py` — A related rate/window problem that uses a queue instead of a dict

## Beliefs

- `logger-10s-boundary-inclusive` — A message printed at timestamp `t` can be printed again at exactly `t + 10` (the comparison is `>=`, not `>`).
- `logger-unseen-message-always-prints` — A message never seen before always returns `True` because `dict.get` defaults to `0` and all timestamps are non-negative.
- `logger-no-state-change-on-reject` — When `shouldPrintMessage` returns `False`, the dict is not modified; only accepted messages update `next_allowed`.
- `logger-unbounded-memory` — The `next_allowed` dict is never pruned, so memory grows with the number of distinct messages over the logger's lifetime.

