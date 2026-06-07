# File: count-square-sum-triples/solution.py

**Date:** 2026-06-06
**Time:** 16:04

## `count-square-sum-triples/solution.py`

### Purpose

Solves [LeetCode 1925 — Count Square Sum Triples](https://leetcode.com/problems/count-square-sum-triples/). Given an integer `n`, count the number of ordered triples `(a, b, c)` where `1 <= a, b, c <= n` and `a² + b² = c²` (Pythagorean triples). The triple is ordered, so `(3, 4, 5)` and `(4, 3, 5)` are both counted.

### Key Components

**`Solution.countTriples(self, n: int) -> int`** — the single method. Takes an upper bound `n`, returns the count of valid ordered Pythagorean triples.

### Patterns

**Hash-set lookup for O(1) membership testing.** Instead of a third nested loop over `c`, the solution precomputes `squares = {i * i for i in range(1, n + 1)}` — the set of all perfect squares up to `n²`. Then for each `(a, b)` pair, it checks `a² + b²` against this set in constant time, reducing what would be O(n³) to O(n²).

This is the standard "enumerate two dimensions, look up the third" pattern you see across many LeetCode solutions involving triplet constraints.

### Dependencies

**Imports:** None — pure standard library, no external dependencies.

**Imported by:** The `count-square-sum-triples/test_solution.py` file imports this class. The massive "Imported By" list in the prompt is a red herring — those are unrelated test files that happen to share the same import pattern (`from solution import Solution`) via relative imports in their own directories, not actual imports of *this* file.

### Flow

1. Build a set of all perfect squares from `1²` to `n²`.
2. Enumerate all `(a, b)` pairs where `1 <= a, b <= n` (both orderings).
3. Compute `s = a² + b²`. If `s` is in the precomputed set, that means some `c` in `[1, n]` satisfies `c² = s`, so increment the count.
4. Return the total count.

The key insight: checking `s in squares` implicitly validates `c <= n` because the set only contains squares of values up to `n`.

### Invariants

- **Ordered counting**: `(a, b)` and `(b, a)` are counted separately (both loop variables range independently from 1 to n). This matches the problem's requirement for ordered triples.
- **Bounded c**: The set-membership check inherently enforces `c <= n` — if `a² + b²` equals some value not in `{1², 2², ..., n²}`, it won't match.
- **Positive values only**: Both loops start at 1, satisfying `1 <= a, b, c`.

### Error Handling

None. The method assumes valid input per LeetCode constraints (`1 <= n <= 250`). No edge-case guards for `n = 0` or negative values.

### Complexity

- **Time:** O(n²) — two nested loops, each O(1) for the set lookup.
- **Space:** O(n) — the `squares` set holds `n` elements.

For the constraint `n <= 250`, this gives at most 62,500 iterations — trivially fast.

## Topics to Explore

- [file] `count-square-sum-triples/test_solution.py` — Verify which test cases exercise edge behavior (e.g., `n=1` where no triple exists, `n=5` where `(3,4,5)` and `(4,3,5)` are the only matches)
- [file] `count-square-sum-triples/review.md` — See if the review flagged the O(n²) approach vs. alternative strategies (e.g., enumerating known Pythagorean triple generators)
- [general] `pythagorean-triple-generation` — Euclid's formula `a = m²-n², b = 2mn, c = m²+n²` can generate all primitive triples in O(sqrt(n)) pairs, which would be asymptotically faster but more complex
- [function] `count-good-triplets/solution.py:countGoodTriplets` — Another triplet-counting problem; compare how it handles the three-variable constraint (likely O(n³) since it lacks a set-lookup shortcut)

## Beliefs

- `count-triples-counts-ordered-pairs` — `countTriples` counts ordered `(a, b)` pairs, so `(3,4,5)` and `(4,3,5)` are both counted, producing even results for all valid `n`
- `square-set-enforces-c-bound` — The precomputed `squares` set only contains `i²` for `i in [1, n]`, so the membership check implicitly enforces `c <= n` without an explicit comparison
- `count-triples-time-complexity` — `countTriples` runs in O(n²) time and O(n) space, with the set lookup converting a potential O(n³) brute force into a two-loop solution
- `count-triples-no-dedup` — The solution does not deduplicate `a` and `b` (e.g., by requiring `a <= b`), which is correct because the problem asks for ordered triples

