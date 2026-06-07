# File: first-bad-version/solution.py

**Date:** 2026-06-06
**Time:** 16:50

## `first-bad-version/solution.py`

### Purpose

This file solves [LeetCode 278 — First Bad Version](https://leetcode.com/problems/first-bad-version/). It finds the earliest bad version in a sequence `[1, n]` where versions transition from good to bad at some point and never go back. The function minimizes calls to the `isBadVersion` API — a constraint of the original problem.

### Key Components

**`first_bad_version(n, isBadVersion)`** — The sole public function. It accepts the version count `n` and a predicate `isBadVersion`, and returns the smallest integer `v` in `[1, n]` where `isBadVersion(v)` is `True`.

The signature departs from LeetCode's class-based convention (where `isBadVersion` is inherited via `VersionControl`). Instead, it takes the predicate as a parameter via dependency injection, making it testable without subclassing.

### Patterns

**Left-biased binary search.** The loop maintains the invariant that the answer is in `[left, right]`. When `isBadVersion(mid)` is true, the answer could be `mid` itself, so `right = mid` (not `mid - 1`). When false, `mid` is definitely not the answer, so `left = mid + 1`. The loop exits when `left == right`, which is the answer.

**Overflow-safe midpoint.** `mid = left + (right - left) // 2` avoids integer overflow that `(left + right) // 2` could cause in languages with fixed-width integers. In Python this is unnecessary (arbitrary-precision ints), but it's a good habit and matches the canonical binary search template.

### Dependencies

**Imports:** `typing.Callable` — used only for the type annotation on `isBadVersion`.

**Imported by:** `first-bad-version/test_solution.py` directly. The "Imported By" list in the prompt is misleading — those hundreds of test files import from their *own* `solution.py`, not this one; LeetCode repos typically share no cross-problem imports.

### Flow

1. Initialize `left = 1`, `right = n`.
2. Loop while `left < right`:
   - Compute `mid` (biased toward `left`).
   - If `mid` is bad, narrow to `[left, mid]`.
   - If `mid` is good, narrow to `[mid + 1, right]`.
3. Return `left` (which equals `right`).

Each iteration halves the search space, so the function makes at most `ceil(log2(n))` calls to `isBadVersion`.

### Invariants

- **Monotonic predicate assumed.** The code assumes there exists some version `v` where all versions `< v` are good and all versions `>= v` are bad. If the predicate is non-monotonic, behavior is undefined.
- **At least one bad version assumed.** If no version is bad, the function returns `n` without detecting the error.
- **`left <= right` throughout.** The update rules guarantee this: `left` only increases, `right` only decreases, and the loop exits before they cross.

### Error Handling

None. The function trusts its inputs — no validation of `n >= 1`, no check that `isBadVersion` is callable, and no handling of the "no bad version exists" edge case. This is appropriate for a LeetCode solution where constraints are guaranteed.

## Topics to Explore

- [file] `first-bad-version/test_solution.py` — How the dependency-injected `isBadVersion` is constructed in tests
- [file] `guess-number-higher-or-lower/solution.py` — Nearly identical binary search structure with a three-way comparison instead of a boolean predicate
- [file] `binary-search/solution.py` — Standard binary search for a target value; contrast the loop exit condition and bounds update
- [general] `left-biased-vs-right-biased-binary-search` — When to use `right = mid` vs `right = mid - 1` and how it affects termination
- [file] `first-bad-version/plan.md` — Design rationale and alternative approaches considered

## Beliefs

- `first-bad-version-log-n-api-calls` — `first_bad_version` makes at most `ceil(log2(n))` calls to `isBadVersion`, the minimum possible for a comparison-based search.
- `first-bad-version-left-equals-right-at-exit` — The while loop exits exactly when `left == right`, so the return value is deterministic regardless of which variable is returned.
- `first-bad-version-injectable-predicate` — The `isBadVersion` predicate is passed as a parameter rather than inherited, decoupling the solution from LeetCode's `VersionControl` base class.
- `first-bad-version-assumes-monotonic-input` — The solution produces correct results only if the predicate is monotonic (all good versions precede all bad versions); it does not validate this.

