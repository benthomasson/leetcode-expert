# File: kth-distinct-string-in-an-array/solution.py

**Date:** 2026-06-06
**Time:** 17:12

## `kth-distinct-string-in-an-array/solution.py`

### Purpose

This file solves [LeetCode 2053: Kth Distinct String in an Array](https://leetcode.com/problems/kth-distinct-string-in-an-array/). It owns a single function that finds the k-th string in `arr` that appears exactly once, preserving the original array order.

### Key Components

**`kth_distinct(arr: list[str], k: int) -> str`** — The sole public function. Contract:
- **Input**: a list of strings and a 1-indexed position `k`
- **Output**: the k-th distinct (count == 1) string in insertion order, or `""` if fewer than `k` distinct strings exist
- **Side effects**: none; mutates `k` locally but leaves `arr` untouched

### Patterns

**Two-pass with Counter**: The solution uses a classic frequency-counting idiom:
1. First pass (implicit inside `Counter(arr)`): count occurrences of every string.
2. Second pass (the `for s in arr` loop): iterate in original order, decrement a local counter `k` each time a unique string is found, and return immediately when `k` hits zero.

This is the canonical approach for "k-th unique element in order" problems — it separates the counting concern from the selection concern while preserving insertion order through the second linear scan.

**Early return**: The function short-circuits as soon as the k-th distinct string is found, avoiding unnecessary iteration over the rest of the array.

### Dependencies

**Imports**: `collections.Counter` — used for O(n) frequency counting.

**Imported by**: The file is consumed by `kth-distinct-string-in-an-array/test_solution.py`. The "Imported By" list in the prompt is misleading — those are test files across the entire repo that share a common test harness import pattern, not direct importers of this module.

### Flow

```
arr = ["d","b","c","b","c","a"], k = 2

Counter(arr) → {"d":1, "b":2, "c":2, "a":1}

Iterate arr:
  "d" → count=1 → k=1 (not zero, continue)
  "b" → count=2 → skip
  "c" → count=2 → skip
  "b" → count=2 → skip
  "c" → count=2 → skip
  "a" → count=1 → k=0 → return "a"
```

### Invariants

- `k` is treated as 1-indexed; the function decrements toward zero rather than counting up toward `k`.
- "Distinct" means exactly one occurrence in the entire array, not "unique among previously seen."
- The iteration order of the second pass matches the original array order, guaranteeing that the k-th distinct string respects insertion order.

### Error Handling

No exceptions are raised. The fallback `return ""` handles all degenerate cases uniformly: empty array, no distinct strings, or `k` exceeding the number of distinct strings. This matches LeetCode's expected contract.

### Complexity

- **Time**: O(n) — one pass to build the Counter, one pass to scan.
- **Space**: O(n) — the Counter stores up to n entries.

---

## Topics to Explore

- [file] `kth-distinct-string-in-an-array/test_solution.py` — See the test cases and edge cases exercised against this solution
- [file] `kth-distinct-string-in-an-array/review.md` — Code review notes that may document alternative approaches or tradeoffs considered
- [function] `first-unique-character-in-a-string/solution.py:firstUniqChar` — A closely related "first unique" problem using the same Counter + linear scan pattern
- [general] `counter-based-uniqueness-patterns` — How Counter-based uniqueness checks appear across this repo (e.g., `count-common-words-with-one-occurrence`, `sum-of-unique-elements`)
- [file] `kth-distinct-string-in-an-array/plan.md` — The planning document showing how the approach was chosen

## Beliefs

- `kth-distinct-returns-empty-on-insufficient-distincts` — `kth_distinct` returns `""` (not None or an exception) when fewer than `k` strings have count == 1
- `kth-distinct-preserves-insertion-order` — The second pass iterates `arr` in its original order, so "k-th distinct" respects the position strings first appear, not alphabetical or any other ordering
- `kth-distinct-is-one-indexed` — The parameter `k` is 1-indexed; passing `k=1` returns the first distinct string, not the second
- `kth-distinct-linear-time` — Both passes are O(n), making the overall solution O(n) time and O(n) space

