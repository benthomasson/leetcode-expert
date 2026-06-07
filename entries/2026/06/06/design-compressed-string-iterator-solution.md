# File: design-compressed-string-iterator/solution.py

**Date:** 2026-06-06
**Time:** 16:17

## `design-compressed-string-iterator/solution.py`

### Purpose

This file implements [LeetCode 604 — Design Compressed String Iterator](https://leetcode.com/problems/design-compressed-string-iterator/). It provides a `StringIterator` class that lazily decompresses a run-length encoded string one character at a time, without ever materializing the full expanded string. The file also contains its own test suite inline.

### Key Components

**`StringIterator`** — The core class. Constructed with a compressed string like `"L1e2t1C1o1d1e1"` where each letter is followed by its repetition count (which can be multi-digit).

- **`__init__(self, compressedString)`** — Stores the raw string and initializes a cursor (`_i`), then immediately calls `_extract_next()` to prime the first character/count pair.
- **`_extract_next(self)`** — Parses the next `(char, count)` pair from `_s` starting at position `_i`. Reads one character, then scans forward through consecutive digits to build the count. If the string is exhausted, sets `_char = ' '` and `_count = 0` as sentinel values.
- **`next(self) -> str`** — Returns the current character and decrements the count. When the count hits zero, advances to the next pair. Returns `' '` (space) if exhausted.
- **`hasNext(self) -> bool`** — Returns `True` iff `_count > 0`.

### Patterns

**Lazy cursor-based parsing.** Rather than pre-parsing all `(char, count)` pairs into a list, the iterator maintains a read cursor (`_i`) and only parses the next pair when the current one is fully consumed. This gives O(1) memory regardless of how large the counts are — important since counts can reach 10^9 (see `test_large_count`).

**Sentinel-based exhaustion.** When the input is consumed, the iterator falls into a terminal state where `_char = ' '` and `_count = 0`. The space character doubles as both the sentinel and the return value for `next()` after exhaustion — this matches the LeetCode spec exactly.

**Self-contained test module.** Tests live in the same file via `unittest.TestCase` and run with `python -m unittest` or `python solution.py`. A separate `test_solution.py` exists alongside it for the project's test harness.

### Dependencies

**Imports:** Only `unittest` from the standard library. No external dependencies.

**Imported by:** The massive `Imported By` list in the repo context is misleading — those are cross-references from a code-expert indexing tool, not actual Python imports. The real consumer is `design-compressed-string-iterator/test_solution.py`, which imports `StringIterator` from this module.

### Flow

1. Constructor receives `"a12b3"`, stores it, sets cursor `_i = 0`.
2. `_extract_next()` reads `_s[0]` → `'a'`, scans digits `_s[1:3]` → `"12"`, sets `_char = 'a'`, `_count = 12`, advances `_i = 3`.
3. Each `next()` call returns `'a'` and decrements `_count`. On the 12th call, `_count` hits 0 and `_extract_next()` fires again: reads `'b'`, count `3`, `_i = 5`.
4. After 3 more `next()` calls, `_extract_next()` finds `_i >= len(_s)`, sets the sentinel state.
5. Subsequent `next()` calls return `' '` indefinitely.

### Invariants

- **`_count >= 0` always.** `_count` is decremented only when `hasNext()` is true (i.e., `_count > 0`), so it never goes negative.
- **`_extract_next` is called exactly once per pair.** It fires in the constructor and then only when `_count` reaches zero inside `next()`. It's never called from `hasNext()`.
- **`hasNext()` is pure.** It has no side effects — calling it repeatedly doesn't advance the iterator. The test `test_has_next_does_not_consume` verifies this.
- **Input format is trusted.** The code assumes the compressed string strictly alternates between a single character and a positive integer. No validation is performed — a malformed input like `"12a"` would produce undefined behavior.

### Error Handling

There is none. The code trusts its input per the LeetCode contract. If `_s` contains no digits after a character, `int(self._s[self._i:j])` would receive an empty string and raise `ValueError`. This is by design — the problem guarantees valid input.

---

## Topics to Explore

- [file] `design-compressed-string-iterator/test_solution.py` — The external test harness that imports `StringIterator`; shows how the project's test infrastructure consumes solution classes
- [function] `design-compressed-string-iterator/solution.py:_extract_next` — The parsing core; worth tracing through edge cases like single-digit vs multi-digit counts and end-of-string
- [general] `run-length-encoding-variants` — Compare this cursor-based approach against pre-parsing into a list of tuples, or using `re.findall(r'([a-zA-Z])(\d+)', s)` for upfront extraction
- [file] `moving-average-from-data-stream/solution.py` — Another stateful iterator/stream design problem in this repo; compare the internal state management patterns
- [general] `iterator-protocol-vs-leetcode-api` — How this custom `next()`/`hasNext()` API differs from Python's `__iter__`/`__next__` protocol and when you'd bridge between them

## Beliefs

- `exhausted-iterator-returns-space` — When the compressed string is fully consumed, `next()` returns `' '` (space character) indefinitely, matching the LeetCode spec's sentinel value
- `lazy-single-pair-parsing` — The iterator parses at most one `(char, count)` pair at a time; it never pre-processes the entire compressed string into a data structure
- `multi-digit-counts-supported` — Counts can be arbitrarily large integers (e.g., `1000000000`); the digit-scanning loop in `_extract_next` handles multi-digit numbers correctly
- `has-next-is-side-effect-free` — `hasNext()` only checks `_count > 0` and never modifies iterator state or triggers parsing

