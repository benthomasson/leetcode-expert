# File: design-hashset/solution.py

**Date:** 2026-06-06
**Time:** 16:18

## `design-hashset/solution.py`

### Purpose

This file implements [LeetCode 705 — Design HashSet](https://leetcode.com/problems/design-hashset/). It provides a from-scratch hash set (no built-in `set`) that supports `add`, `remove`, and `contains` on integer keys in the range `[0, 10^6]`. The file is self-contained: implementation and unit tests live together.

### Key Components

**`MyHashSet`** — The hash set class, backed by a fixed-size array of buckets (separate chaining).

| Member | Contract |
|--------|----------|
| `_num_buckets = 769` | Bucket count. A prime, which reduces collision clustering for modular hashing. |
| `_buckets: list[list[int]]` | Array of 769 independent lists. Each list holds keys that hash to that index. |
| `_hash(key) -> int` | Maps a key to a bucket index via `key % 769`. |
| `add(key)` | Appends `key` to its bucket only if not already present. Guarantees no duplicates within a bucket. |
| `remove(key)` | Removes `key` from its bucket. No-op if absent — never raises. |
| `contains(key) -> bool` | Linear scan of the bucket for membership. |

**`TestMyHashSet`** — Six test cases covering the LeetCode example, duplicate adds, remove-of-absent-key, boundary values (`0` and `10^6`), hash collisions (`0` and `769`), and empty-set lookup.

### Patterns

- **Separate chaining**: Each bucket is a plain `list`. Colliding keys coexist in the same list. This is the simplest collision-resolution strategy — no open addressing, no rehashing.
- **Prime bucket count**: 769 is prime, which distributes keys more uniformly under modular hashing than a power-of-two would (fewer systematic collisions for patterned inputs).
- **Guard-before-mutate idiom**: Both `add` and `remove` check membership (`if key not in bucket`) before modifying the list, making both idempotent.
- **Co-located tests**: Implementation and tests share the same file, which is the convention across this entire repository.

### Dependencies

- **Imports**: Only `unittest` from the standard library. No external packages.
- **Imported by**: `design-hashset/test_solution.py` (its dedicated test runner) plus hundreds of other `test_solution.py` files across the repo — those are likely an artifact of a shared test-discovery or import-graph tool, not actual runtime imports of `MyHashSet`.

### Flow

1. **Init**: `__init__` creates 769 empty lists — one per bucket.
2. **Add**: `_hash` computes the bucket index → linear scan of that bucket with `in` → append if absent.
3. **Remove**: Same hash → linear scan with `in` → `list.remove()` if found.
4. **Contains**: Same hash → `in` operator on the bucket list → return boolean.

All three public methods are O(n/k) average where n is the number of stored keys and k is 769, degrading to O(n) worst-case if all keys collide.

### Invariants

- **No duplicates per bucket**: `add` checks `key not in bucket` before appending, so each key appears at most once across the entire structure.
- **Bucket index stability**: A key always maps to the same bucket (`key % 769` is deterministic), so `contains` and `remove` always look in the right place after an `add`.
- **Idempotent operations**: Calling `add(k)` twice is equivalent to calling it once. Calling `remove(k)` on an absent key is a silent no-op.

### Error Handling

There is none — by design. The LeetCode contract guarantees keys are non-negative integers in `[0, 10^6]`, so no input validation is performed. `remove` silently does nothing for absent keys rather than raising `KeyError`.

---

## Topics to Explore

- [file] `design-hashmap/solution.py` — Sister problem (LeetCode 706) that likely uses the same bucket/chaining structure but stores key-value pairs instead of just keys
- [general] `prime-bucket-sizing` — Why 769 specifically: it's the smallest prime above 750, giving ~O(1) amortized ops for up to 10^4 keys at ~13 keys/bucket average
- [function] `design-hashset/solution.py:_hash` — Consider how the hash function would need to change if keys were strings or negative integers instead of bounded non-negative ints
- [general] `open-addressing-vs-chaining` — Alternative collision strategy (linear/quadratic probing) that avoids per-bucket list overhead but complicates deletion
- [file] `design-hashset/test_solution.py` — The external test file that imports this module; check whether it adds coverage beyond the inline tests

## Beliefs

- `hashset-bucket-count-is-prime` — MyHashSet uses exactly 769 buckets, a prime number, to reduce collision clustering under modular hashing
- `hashset-no-duplicates-invariant` — The `add` method checks membership before appending, guaranteeing each key appears in at most one bucket exactly once
- `hashset-remove-is-noop-for-absent` — Calling `remove(key)` when key is not in the set silently does nothing; it never raises an exception
- `hashset-all-ops-linear-in-bucket` — `add`, `remove`, and `contains` all perform a linear scan of the target bucket, making them O(n/769) average-case

