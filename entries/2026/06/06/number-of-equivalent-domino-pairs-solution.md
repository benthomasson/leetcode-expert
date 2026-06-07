# File: number-of-equivalent-domino-pairs/solution.py

**Date:** 2026-06-06
**Time:** 18:18

## Purpose

This file solves [LeetCode 1128: Number of Equivalent Domino Pairs](https://leetcode.com/problems/number-of-equivalent-domino-pairs/). Two dominoes `[a, b]` and `[c, d]` are equivalent if either `(a == c and b == d)` or `(a == d and b == c)` — i.e., one is a rotation of the other. The solution counts all such pairs `(i, j)` where `i < j`.

## Key Components

### `Solution.num_equiv_domino_pairs`

**Input:** A list of dominoes, each a two-element list `[a, b]` with `1 <= a, b <= 9`.

**Output:** Integer count of equivalent pairs.

The method does two things in two lines:

1. **Canonicalize each domino** by sorting its values into `(min, max)` tuples. This collapses `[1, 2]` and `[2, 1]` into the same key `(1, 2)`, making equivalence a simple equality check.

2. **Count pairs via combinatorics.** For each group of `n` identical canonical dominoes, the number of distinct pairs is `n*(n-1)/2` (the "n choose 2" formula).

## Patterns

**Canonical-form + frequency counting** — the dominant pattern in this repo for pair/group-counting problems. Instead of comparing all O(n^2) pairs, normalize each element to a canonical form, count frequencies with `Counter`, then derive the answer from the counts. This is the same pattern used in `number-of-good-pairs` and `count-pairs-of-similar-strings`.

**Generator expression inside Counter** — the canonicalization and counting happen in a single expression with no intermediate list, keeping memory allocation minimal.

## Dependencies

**Imports:** `Counter` from `collections` (frequency map) and `List` from `typing` (type annotation only).

**Imported by:** The `test_solution.py` in this same directory. The massive "Imported By" list in the prompt is an artifact of the shared test infrastructure — those test files import from their own sibling `solution.py`, not from this one.

## Flow

```
dominoes: [[1,2],[2,1],[3,4],[5,6],[5,6]]
    │
    ▼  canonicalize each via (min, max)
[(1,2), (1,2), (3,4), (5,6), (5,6)]
    │
    ▼  Counter
{(1,2): 2, (3,4): 1, (5,6): 2}
    │
    ▼  n*(n-1)//2 per group
    1  +  0  +  1  =  2
```

## Invariants

- **Canonical form is commutative:** `(min(a,b), max(a,b))` guarantees `[a,b]` and `[b,a]` map to the same key. This is correct because domino equivalence is defined as unordered equality.
- **Value range `1 <= a, b <= 9`:** The problem constrains values, so the canonical key space is small (at most 45 distinct pairs). The solution doesn't exploit this but it means `Counter` overhead is negligible.
- **Integer division is exact:** `n*(n-1)` is always even (one of two consecutive integers is even), so `// 2` produces no truncation.

## Error Handling

None. The method trusts the caller to provide valid input per the LeetCode contract. Empty input returns 0 naturally (the `sum` over an empty `Counter` is 0).

---

## Topics to Explore

- [file] `number-of-equivalent-domino-pairs/test_solution.py` — See what edge cases are covered (empty list, all-identical dominoes, single element)
- [file] `number-of-good-pairs/solution.py` — Uses the same canonical-form + n-choose-2 pattern; compare how the canonicalization step differs
- [file] `count-pairs-of-similar-strings/solution.py` — Another pair-counting problem; explore how similarity is defined and canonicalized differently
- [general] `n-choose-2-counting` — The `n*(n-1)//2` formula appears across many solutions in this repo; understanding when it applies (counting unordered pairs from a group) is a transferable skill
- [function] `number-of-equivalent-domino-pairs/solution.py:num_equiv_domino_pairs` — Consider the alternative of using a tuple `(a*10+b)` as the canonical key (packing into a single int) for even cheaper hashing

## Beliefs

- `domino-canonical-form-is-sorted-tuple` — Dominoes are canonicalized as `(min(a,b), max(a,b))`, making equivalence reducible to equality
- `pair-count-uses-combinatorial-formula` — Pair counting uses `n*(n-1)//2` per frequency group rather than O(n^2) pairwise comparison
- `solution-is-linear-time` — The algorithm runs in O(n) time and O(k) space where k is the number of distinct canonical keys (at most 45)
- `empty-input-returns-zero` — An empty domino list produces 0 with no special-case handling, via the natural behavior of `sum` over an empty iterable

