# File: destination-city/solution.py

**Date:** 2026-06-06
**Time:** 16:19

## Purpose

This file solves [LeetCode 1436 — Destination City](https://leetcode.com/problems/destination-city/). Given a list of directed paths between cities that form a single linear chain (no branches, no cycles), it finds the terminal city — the one that appears only as a destination, never as a source.

It's a standalone solution module following the repo's convention: one `Solution` class per problem directory, with a corresponding `test_solution.py` for validation.

## Key Components

### `Solution.destCity(paths: List[List[str]]) -> str`

The only method. Takes a list of `[source, destination]` pairs and returns the city with no outgoing edge.

**Contract**: `paths` is non-empty and forms a valid linear chain per the problem's guarantees. Returns a single city name as a string. Raises `ValueError` on empty input.

## Patterns

**Set-based membership test**: The algorithm builds a set of all source cities, then scans destinations to find one absent from that set. This is the canonical O(n) approach for this problem — it avoids graph construction entirely by exploiting the fact that in a linear chain, exactly one city will never be a departure point.

**Early return on match**: The `for` loop returns as soon as it finds the destination city, avoiding unnecessary iteration. Given the problem guarantees, this always fires.

**Defensive fallback**: The `return ""` at the end is unreachable under valid input but satisfies the type checker / linter by ensuring all code paths return a value.

## Dependencies

**Imports**: Only `typing.List` — no external dependencies.

**Imported by**: `destination-city/test_solution.py` directly. The massive "Imported By" list in the context is misleading — those are other problems' test files that import their own `solution.py`, not this one. The cross-referencing tool likely matched on the common `from solution import Solution` pattern shared across all problem directories.

## Flow

1. Guard clause: reject empty `paths` with `ValueError`.
2. Build `sources` — a set comprehension over `path[0]` for every path. This is O(n) time and space.
3. Iterate over `paths` again, checking each `path[1]` (destination) against `sources`.
4. Return the first destination not in `sources`.

Total: two passes over `paths`, O(n) time, O(n) space for the set.

## Invariants

- **Non-empty input**: Enforced explicitly via the `ValueError` guard.
- **Exactly one terminal city**: Assumed from the problem statement. The algorithm returns the *first* such city found; if the input were malformed with multiple terminals, only the first encountered would be returned.
- **Linear chain structure**: The algorithm doesn't verify this — it trusts the problem's guarantee that paths form a connected line with no loops or branches.

## Error Handling

Only one explicit error: `ValueError` for empty input. No handling for malformed path entries (e.g., paths with fewer than 2 elements) or non-string values — these would surface as index errors or unexpected behavior at the caller's level, consistent with the repo's LeetCode-style trust-the-input convention.

## Topics to Explore

- [file] `destination-city/test_solution.py` — Validate which edge cases are covered (single path, long chains, etc.)
- [file] `destination-city/review.md` — See the code review notes for this solution's tradeoffs
- [function] `find-center-of-star-graph/solution.py:findCenter` — Similar set-membership pattern applied to a star graph topology
- [general] `set-vs-graph-solutions` — Many LeetCode graph problems can be reduced to set operations when the structure is constrained (linear chains, stars, trees)

## Beliefs

- `destcity-linear-time` — `destCity` runs in O(n) time and O(n) space where n is the number of paths, using a source-set membership check rather than graph traversal.
- `destcity-early-return` — The method returns on the first destination not found in the source set; under valid input this always triggers during the loop, making the trailing `return ""` dead code.
- `destcity-no-graph-construction` — The solution never builds an adjacency list or graph object; it exploits the linear-chain constraint to reduce the problem to set difference.
- `destcity-empty-input-guard` — Empty input is the only explicitly validated precondition; malformed path entries (wrong length, wrong types) are not checked.

