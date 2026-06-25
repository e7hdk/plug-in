# Rust — expertise profile

## Idioms
- Error handling: return `Result<T, E>` with typed errors (`thiserror`/`anyhow` at boundaries).
  No `unwrap()`/`expect()`/`panic!` on production paths — they're allowed only in tests and
  truly-unreachable invariants (documented).
- Concurrency / async: Tokio for async I/O; don't block the runtime (`spawn_blocking` for CPU/sync
  work). Prefer message passing (`mpsc`) and bounded channels over shared mutable state; if you
  share, `Arc<Mutex<…>>`/`RwLock` with the lock held as briefly as possible.
- Typing / safety: lean on the type system and ownership; avoid `unsafe` unless justified and
  isolated with a safety comment. Model state with enums, not booleans.

## Tooling & verify
- Format: `cargo fmt` · Lint: `cargo clippy -- -D warnings` · Test: `cargo test` · (build: `cargo build`).
- The verify gate runs: `cargo fmt --check && cargo clippy -- -D warnings && cargo test`.

## Testing
- Framework: built-in `#[test]` + `cargo test` (consider `proptest` for invariants). Deterministic —
  no real network/clock/DB; inject via traits and use in-memory fakes.

## Gotchas / never-do
- `unwrap()`/`expect()` on a fallible prod path; `.clone()` to silence the borrow checker without
  thinking; blocking calls inside async; unbounded channels/queues; swallowing errors with `let _ =`.

## Role notes
- builder: make illegal states unrepresentable; propagate errors with `?`; bound every queue.
- reviewer: hunt panics on prod paths, lock scope/contention, and `unsafe` without justification.
- security: integer overflow in arithmetic on untrusted input; deserialization of untrusted data.
