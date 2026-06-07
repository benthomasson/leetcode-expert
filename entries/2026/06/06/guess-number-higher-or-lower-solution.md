# File: guess-number-higher-or-lower/solution.py

**Date:** 2026-06-06
**Time:** 16:58

## `guess-number-higher-or-lower/solution.py`

### Purpose

This file solves [LeetCode 374 — Guess Number Higher or Lower](https://leetcode.com/problems/guess-number-higher-or-lower/). It implements a binary search against a black-box oracle (`guess()`) to find a secretly picked number within the range `[1, n]`. The file's sole responsibility is housing the `Solution.guessNumber` method that LeetCode's judge calls.

### Key Components

**`Solution.guessNumber(self, n: int) -> int`** — The only method. Given an upper bound `n`, it returns the picked number by querying the `guess` API repeatedly, halving the search space each iteration.

**`guess(num: int) -> int`** (external) — A pre-defined API injected by LeetCode's runtime. The contract is:
- Returns `0` if `num` equals the picked number
- Returns `-1` if `num` is **higher** than the picked number (counterintuitive — not "the pick is lower," but "your guess is too high")
- Returns `1` if `num` is **lower** than the picked number

### Patterns

**Classic binary search with an oracle.** Rather than searching a sorted array, the search predicate is delegated to an external function. The structure is textbook: maintain `low`/`high` bounds, probe the midpoint, and contract the interval based on the oracle's response.

**Overflow-safe midpoint calculation.** `mid = low + (high - low) // 2` avoids integer overflow that `(low + high) // 2` would cause in languages with fixed-width integers. In Python this is technically unnecessary (arbitrary-precision ints), but it's a good habit and signals awareness of the classic pitfall.

### Dependencies

**Imports:** None explicit. The `guess` function is injected into the module's namespace by LeetCode's judge at runtime. The comment block at the top documents this contract.

**Imported by:** `guess-number-higher-or-lower/test_solution.py` — the local test harness. The "Imported By" list in the prompt appears to be a repo-wide artifact (every test file listed), not specific importers of this module.

### Flow

1. Initialize search bounds: `low = 1`, `high = n`.
2. Loop while `low <= high`:
   - Compute `mid` (overflow-safe).
   - Call `guess(mid)`.
   - If `result == 0`: found it, return `mid`.
   - If `result == -1`: guess was too high, shrink upper bound (`high = mid - 1`).
   - If `result == 1`: guess was too low, raise lower bound (`low = mid + 1`).
3. Return `-1` as a sentinel — structurally unreachable given the problem's guarantee that a valid pick exists in `[1, n]`.

**Time complexity:** O(log n). Each iteration halves the search space.  
**Space complexity:** O(1). Only three variables maintained.

### Invariants

- The picked number is always within `[low, high]` at the start of each iteration — this is the loop invariant that guarantees correctness.
- `low` and `high` converge strictly (each branch moves a bound by at least 1), so the loop terminates in at most `ceil(log2(n))` iterations.
- The problem guarantees exactly one valid pick in `[1, n]`, so the `return -1` is dead code under valid inputs.

### Error Handling

None. The function trusts its inputs completely — `n >= 1` and `guess()` behaves per its contract. The `return -1` at the end is a defensive fallback for an impossible state, not a real error path. No exceptions are raised or caught.

---

## Topics to Explore

- [file] `guess-number-higher-or-lower/test_solution.py` — How the test harness mocks the `guess` API to make this testable outside LeetCode
- [file] `binary-search/solution.py` — The standard binary search on a sorted array; compare how the predicate differs from the oracle-based approach here
- [file] `first-bad-version/solution.py` — Another oracle-based binary search (LeetCode 278); structurally almost identical but with a boolean predicate instead of a ternary one
- [general] `guess-api-sign-convention` — The `guess()` return values are notoriously confusing (-1 means "too high," not "go lower"); worth verifying in any adaptation
- [file] `search-insert-position/solution.py` — Binary search variant that must handle the "not found" case with an insertion point, unlike this problem which guarantees a hit

## Beliefs

- `binary-search-oracle-pattern` — `guessNumber` uses standard binary search but replaces array-index comparison with a ternary oracle function (`guess()`), making it a search over an implicit sorted sequence
- `overflow-safe-midpoint` — The midpoint is computed as `low + (high - low) // 2` rather than `(low + high) // 2`, preventing overflow in fixed-width integer languages (redundant in Python but idiomatic)
- `unreachable-return-minus-one` — The `return -1` on line 22 is dead code under valid problem constraints; it exists purely as a structural guard
- `guess-api-inverted-semantics` — `guess()` returns `-1` when the guess is too high (not too low), which is the opposite of what many developers expect from a comparison function

