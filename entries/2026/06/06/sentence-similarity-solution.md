# File: sentence-similarity/solution.py

**Date:** 2026-06-06
**Time:** 19:02

## `sentence-similarity/solution.py`

### Purpose

This file implements LeetCode problem **734 - Sentence Similarity**. It determines whether two sentences (represented as word lists) are "similar" given a set of explicitly defined word pairs. Similarity is checked word-by-word at matching positions — it is **not transitive** (if A~B and B~C, that does not imply A~C).

### Key Components

**`areSentencesSimilar(sentence1, sentence2, similarPairs) -> bool`** — The sole public function. Contract:

- Takes two word lists and a list of `[word1, word2]` similarity pairs.
- Returns `True` if and only if the sentences have equal length **and** every word at position `i` in `sentence1` either equals the word at position `i` in `sentence2` or appears with it in `similarPairs`.
- Similarity is symmetric (handled by inserting both `(x, y)` and `(y, x)`) but **not transitive**.

### Patterns

**Set-of-tuples for O(1) lookup** — The similarity pairs are pre-processed into a `set` of 2-tuples rather than left as a list of lists. This converts each pair-check from O(P) to O(1), making the overall algorithm O(N + P) where N is sentence length and P is the number of pairs.

**Early exit on length mismatch** — The length check at the top short-circuits before doing any pair processing.

**Generator expression with `all()`** — The final check uses `all()` with a generator, which short-circuits on the first mismatch rather than evaluating every position.

**Self-contained test file** — Tests are co-located via `unittest` in the same module, runnable with `python -m unittest` or `if __name__ == "__main__"`.

### Dependencies

**Imports:** Only `unittest` (stdlib). No external dependencies.

**Imported by:** The `test_solution.py` files listed in the "Imported By" section are an artifact of the repo's shared test infrastructure — they likely import a common test runner or share a pattern, not this specific solution. The direct consumer is `sentence-similarity/test_solution.py`.

### Flow

1. **Length guard** — If `len(sentence1) != len(sentence2)`, return `False` immediately.
2. **Build lookup set** — Iterate `similarPairs`, inserting both `(x, y)` and `(y, x)` into `similar_set`. This ensures symmetric lookup without needing to check both orderings later.
3. **Pairwise comparison** — `zip` the two sentences and for each `(w1, w2)` pair, accept if `w1 == w2` (identity) or `(w1, w2) in similar_set` (explicit similarity).

### Invariants

- **Equal-length requirement** — Sentences of different lengths are never similar, regardless of pairs.
- **No transitivity** — The test `test_no_transitivity` explicitly asserts that `["a"]` and `["c"]` are not similar even when `a~b` and `b~c` are given. This is a problem constraint, not a limitation.
- **Symmetry is enforced by construction** — Both orderings are inserted into the set, so pair direction in the input doesn't matter (verified by `test_reverse_pair_direction`).
- **Identity is always similar** — A word is always similar to itself (`w1 == w2` check), even if no pair mentions it.

### Error Handling

None. The function assumes valid inputs per the LeetCode contract — no `None` checks, no type validation. Empty sentences and empty pair lists are handled naturally by the iteration (both produce `True` via vacuous truth from `all()` over an empty zip).

## Topics to Explore

- [file] `sentence-similarity/test_solution.py` — The companion test file; may contain additional edge cases beyond the inline tests
- [file] `sentence-similarity/plan.md` — Pre-implementation plan showing the approach selection reasoning
- [file] `sentence-similarity/review.md` — Post-implementation review, likely covering complexity analysis and alternatives
- [general] `sentence-similarity-ii` — LeetCode 737 extends this problem with transitivity via Union-Find, a natural follow-up
- [general] `set-vs-dict-for-pair-lookup` — Whether a `dict[str, set[str]]` adjacency representation would be cleaner or faster for large pair lists

## Beliefs

- `sentence-similarity-no-transitivity` — `areSentencesSimilar` treats similarity as non-transitive: `a~b` and `b~c` does not imply `a~c`
- `sentence-similarity-symmetry-by-construction` — Symmetry is guaranteed by inserting both `(x,y)` and `(y,x)` into the lookup set during preprocessing, not by double-checking at query time
- `sentence-similarity-time-complexity` — The algorithm runs in O(N + P) time where N is sentence length and P is the number of similar pairs, due to set-based lookup
- `sentence-similarity-identity-implicit` — Word identity (`w1 == w2`) is handled by a direct equality check, not by requiring self-pairs in `similarPairs`

