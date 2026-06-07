# File: uncommon-words-from-two-sentences/solution.py

**Date:** 2026-06-06
**Time:** 19:35

## `uncommon-words-from-two-sentences/solution.py`

### Purpose

This file solves [LeetCode 884 — Uncommon Words from Two Sentences](https://leetcode.com/problems/uncommon-words-from-two-sentences/). It owns the single function `uncommon_from_sentences`, which identifies words that appear exactly once across two input sentences combined. It follows the repo's convention of one solution file per problem directory.

### Key Components

**`uncommon_from_sentences(s1: str, s2: str) -> List[str]`** — The sole public function. Takes two space-separated sentences and returns all words whose total frequency across both sentences is exactly 1.

The contract is simple: a word is "uncommon" if and only if it appears exactly once in the union of both sentences. This means a word appearing twice in one sentence (and zero times in the other) is *not* uncommon — the counting is global, not per-sentence.

### Patterns

The solution uses a **count-and-filter** idiom: build a frequency map, then select entries matching a predicate. This is the canonical approach for frequency-based selection problems in this repo.

The key insight is concatenating the sentences before splitting (`(s1 + " " + s2).split()`), which collapses the two-sentence problem into a single-counter problem. This works because the definition of "uncommon" is a global frequency of exactly 1 — there's no need to track which sentence a word came from.

### Dependencies

**Imports:**
- `collections.Counter` — provides the frequency map
- `typing.List` — return type annotation

**Imported by:** The `test_solution.py` in the same directory, plus hundreds of other test files across the repo (the "Imported By" list in the prompt is misleading — those test files import their *own* solution modules, not this one; only `uncommon-words-from-two-sentences/test_solution.py` actually imports this function).

### Flow

1. Concatenate `s1` and `s2` with a space separator
2. Split into a word list via `str.split()` (splits on any whitespace, discards empty strings)
3. Pass the list to `Counter`, producing a `{word: count}` mapping
4. List comprehension filters to words where `count == 1`

The entire computation is a single expression chain — no intermediate state, no mutation.

### Invariants

- Input sentences contain only lowercase letters and spaces (per the LeetCode constraint). The code doesn't enforce this but relies on it — uppercase "Hello" and lowercase "hello" would be treated as distinct words.
- `str.split()` without arguments handles multiple consecutive spaces and leading/trailing whitespace correctly, so the concatenation `s1 + " " + s2` is safe even if either string is empty.
- The returned list order follows `Counter.items()` iteration order, which is insertion order (Python 3.7+). In practice this means words appear in the order they're first encountered left-to-right across the combined sentence.

### Error Handling

None. The function trusts its inputs conform to the LeetCode spec. Passing `None` would raise `TypeError` at the concatenation. Non-string inputs are not guarded against — appropriate for a LeetCode solution where inputs are guaranteed.

## Topics to Explore

- [file] `uncommon-words-from-two-sentences/test_solution.py` — Test cases reveal edge cases the solution must handle (empty strings, all-duplicate inputs, single-word sentences)
- [file] `count-common-words-with-one-occurrence/solution.py` — A closely related problem that also uses `Counter` with frequency == 1 but must track per-list membership
- [function] `uncommon-words-from-two-sentences/solution.py:uncommon_from_sentences` — Consider whether the concatenation approach could produce false matches if words contain spaces (it can't, given the LeetCode constraints, but worth understanding why)
- [general] `counter-vs-defaultdict` — When `Counter` is preferable to `defaultdict(int)` for frequency problems in this repo

## Beliefs

- `uncommon-counts-globally` — A word appearing twice in one sentence and zero times in the other is excluded; frequency is counted across the union, not per-sentence
- `concat-then-split-is-equivalent` — Concatenating with a space and splitting is equivalent to splitting each sentence independently and merging, because `str.split()` handles multiple consecutive spaces
- `output-order-is-insertion-order` — The returned list preserves the left-to-right first-occurrence order of words across the combined input (Python 3.7+ dict ordering guarantee)
- `no-input-validation` — The function performs no validation; it assumes inputs are non-None lowercase-letter-and-space strings per LeetCode constraints

