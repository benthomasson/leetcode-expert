# File: read-n-characters-given-read4/solution.py

**Date:** 2026-06-06
**Time:** 18:39

## Purpose

This file implements LeetCode #157 — **Read N Characters Given Read4**. It solves the problem of reading exactly `n` characters from a file using only a low-level `read4` API that reads at most 4 characters at a time. The file is self-contained: it defines the simulated API (`Reader4`), the solution (`Solution`), and a full test suite (`TestSolution`).

## Key Components

### `Reader4` (base class, lines 7–22)

Simulates the `read4` API that LeetCode provides but doesn't let you see. It wraps a string as a virtual file with an internal cursor (`_pos`).

- **`__init__(self, file: str)`** — stores the file content and initializes position to 0.
- **`read4(self, buf4: List[str]) -> int`** — reads up to 4 characters into `buf4`, advances `_pos`, returns the actual count read. This is the only I/O primitive the solution is allowed to use.

### `Solution` (lines 25–46, extends `Reader4`)

- **`read(self, buf: List[str], n: int) -> int`** — the core algorithm. Repeatedly calls `read4` into a temporary 4-element buffer, copies the lesser of `count` (chars actually read) and `n - total` (chars still needed) into `buf`, and stops when either `n` characters have been collected or `read4` returns fewer than 4 (EOF reached).

### `TestSolution` (lines 49–89)

Nine test cases exercising boundary conditions: file shorter than `n`, exact match, file longer than `n`, single-char files, reads aligned and unaligned to 4-byte boundaries, and `n` much larger than the file.

## Patterns

**Adapter/Inheritance pattern**: `Solution` extends `Reader4` to gain access to `read4`, mirroring LeetCode's problem structure where the solution class inherits the API. This is the standard LeetCode convention for "given an API" problems.

**Buffered reading**: The 4-element temporary buffer (`buf4`) acts as a small intermediary between the fixed-size read primitive and the variable-size output buffer — the classic pattern for bridging mismatched I/O granularities.

**Copy-what-you-need with `min`**: `to_copy = min(count, n - total)` prevents over-reading past the requested `n`, which is the key correctness detail.

## Dependencies

**Imports**: `unittest` (stdlib) and `List` from `typing`. No external dependencies.

**Imported by**: The "Imported By" list in the prompt is misleading — those are unrelated test files across the repo that happen to import `unittest`, not actual consumers of this module. The only real dependent is `read-n-characters-given-read4/test_solution.py`, and the tests are already inline in this file.

## Flow

1. Caller creates `Solution("some file content")`, which initializes `Reader4._pos = 0`.
2. Caller allocates a destination buffer `buf` of size `>= n` and calls `sol.read(buf, n)`.
3. `read` loops:
   - Calls `read4(buf4)` → fills up to 4 chars, returns `count`.
   - Computes `to_copy = min(count, n - total)`.
   - Copies `to_copy` chars from `buf4` into `buf[total..total+to_copy]`.
   - Increments `total`.
   - If `count < 4`, the file is exhausted → break.
4. Returns `total`, the number of characters actually placed in `buf`.

## Invariants

- **`total <= n` always holds** — enforced by the `while total < n` guard and the `min(count, n - total)` cap on each copy.
- **`read4` returns 0–4** — guaranteed by the `while count < 4` loop and the file-length bound.
- **Single-use**: `read` is designed to be called once per `Solution` instance (no internal buffer carryover). This distinguishes it from LeetCode #158 (Read N Characters Given Read4 II — Call Multiple Times).
- **`buf` must be pre-allocated** to at least `n` elements by the caller.

## Error Handling

None. The code assumes valid inputs — `buf` is large enough, `n >= 0`, and `file` is a string. This is typical for LeetCode solutions where input constraints are guaranteed by the problem.

## Topics to Explore

- [general] `read4-ii-multiple-calls` — The follow-up problem (LeetCode #158) where leftover bytes in `buf4` must be carried across calls, requiring an instance-level buffer — a significant design change from this single-call version.
- [function] `read-n-characters-given-read4/solution.py:read` — Trace what happens when `n` is not a multiple of 4 (e.g., `n=7` on a 10-char file) to understand why `min(count, n - total)` is load-bearing.
- [file] `read-n-characters-given-read4/review.md` — Check whether the review captures the single-call vs. multi-call distinction and any noted edge cases.
- [general] `buffered-io-pattern` — This pattern (small fixed-size reads assembled into variable-size output) recurs in systems programming — compare with how `fread`/`BufferedReader` work.

## Beliefs

- `read4-reads-at-most-4` — `Reader4.read4` always returns a value in `[0, 4]` and advances the internal position by exactly that amount.
- `solution-read-never-exceeds-n` — `Solution.read` places at most `n` characters into `buf`, enforced by `min(count, n - total)` on every copy iteration.
- `solution-is-single-call` — `Solution.read` has no instance-level carryover buffer, so calling it a second time on the same instance resumes from wherever `_pos` stopped, but any leftover bytes from the last `read4` call are lost.
- `eof-detected-by-short-read` — The loop terminates early when `read4` returns fewer than 4, which is the sole EOF signal.

