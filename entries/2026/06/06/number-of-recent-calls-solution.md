# File: number-of-recent-calls/solution.py

**Date:** 2026-06-06
**Time:** 18:20

## `number-of-recent-calls/solution.py`

### Purpose

This file is the complete solution for [LeetCode 933 — Number of Recent Calls](https://leetcode.com/problems/number-of-recent-calls/). It owns both the implementation (`RecentCounter`) and its test suite. The problem asks you to design a class that counts how many requests have occurred in the last 3000 milliseconds.

### Key Components

**`RecentCounter`** — A stateful counter backed by a deque (`self.q`). It exposes a single method:

- **`ping(t: int) -> int`** — Records a request at timestamp `t`, evicts all timestamps older than `t - 3000` from the front of the queue, and returns the count of requests remaining in the window `[t-3000, t]`.

**`TestRecentCounter`** — Five unit tests covering the example case, single-ping, all-within-window, large-gap eviction, and the exact boundary at 3000ms.

### Patterns

**Sliding window via deque**: This is the textbook approach. Because timestamps arrive in strictly increasing order, stale entries are always at the front. A `deque` gives O(1) `append` and `popleft`, making the amortized cost per `ping` O(1) — each timestamp enters the deque once and leaves once across the lifetime of the object.

**Self-contained file**: Solution and tests live in the same module with `if __name__ == "__main__": unittest.main()`, matching the repo-wide convention.

### Dependencies

**Imports**: `collections.deque` (the sliding window data structure) and `unittest` (test framework).

**Imported by**: The `test_solution.py` in this same directory, plus the "Imported By" list in the prompt shows hundreds of other test files — but that list appears to be the full repo's test suite, not specific to this file. The actual direct dependent is `number-of-recent-calls/test_solution.py`.

### Flow

1. `__init__` creates an empty deque.
2. Each `ping(t)` appends `t` to the right end.
3. A `while` loop pops from the left as long as `self.q[0] < t - 3000`. This is safe because `t` was just appended, so the deque is never empty during the loop.
4. `len(self.q)` returns the count of timestamps in `[t-3000, t]`.

### Invariants

- **Strictly increasing timestamps**: The problem guarantees each `t` is strictly greater than the previous. The code depends on this — if timestamps could repeat or decrease, the eviction loop's assumption that stale entries are at the front would break.
- **Deque is never empty during eviction**: The just-appended `t` satisfies `t >= t - 3000`, so `self.q[0] < t - 3000` will be false before the deque empties. No guard against `IndexError` is needed.
- **Inclusive window**: The boundary check is `<` (strict), not `<=`, meaning `t - 3000` itself is included in the count. The test at line 43 (`ping(3001)` returns 2 with the first ping at 1) confirms this.

### Error Handling

None. The code trusts the LeetCode contract that `t` is always a valid, strictly increasing integer. No defensive checks, no exceptions — appropriate for a competitive programming solution.

## Topics to Explore

- [file] `number-of-recent-calls/plan.md` — The approach reasoning written before implementation
- [file] `number-of-recent-calls/review.md` — Post-implementation review and complexity analysis
- [file] `moving-average-from-data-stream/solution.py` — Another sliding-window-over-a-stream design problem using similar deque mechanics
- [general] `deque-vs-list-for-sliding-windows` — Why `deque.popleft()` is O(1) while `list.pop(0)` is O(n), and when that matters
- [file] `implement-queue-using-stacks/solution.py` — Related queue-based design problem in this repo

## Beliefs

- `ping-amortized-o1` — Each `ping` call is amortized O(1) because every timestamp enters and exits the deque exactly once across all calls.
- `deque-never-empty-during-eviction` — The `while self.q[0]` loop cannot raise `IndexError` because the just-appended `t` always satisfies the window boundary, preventing full drain.
- `window-boundary-inclusive` — The eviction condition `self.q[0] < t - 3000` keeps timestamps equal to `t - 3000` in the window, making both endpoints of `[t-3000, t]` inclusive.
- `strictly-increasing-timestamps-required` — The solution's correctness depends on the guarantee that successive `t` values are strictly increasing; out-of-order inputs would break the front-eviction invariant.

