# HFT / low-latency trading — domain profile

## What matters (NFRs / priorities, ranked)
1. **Latency is the product** — tail latency (p99/p99.9), not the mean. A correct-but-slow path
   is a defect.
2. **Determinism** — same input → same output and same timing envelope; no surprise GC/alloc.
3. **Correctness under concurrency** — race-free order/position/risk state; no lost or duplicated fills.
4. Throughput and backpressure; observability of latency at every hop.

## Recommended org
- Depth: **scale-up** or **enterprise**.
- Capabilities: usually **none** of mobile/i18n; data/ml only if signal-driven.
- Key roster (emphasize): backend-builder (systems/low-latency lens), **perf-qa**, **sre**,
  data-engineer, security, architect. Reviewer runs a latency lens.
- De-emphasize / skip: growth, sales, support, design (minimal or off — there's no funnel).

## Domain gates / concerns
- **Benchmark regression gate:** a change that regresses p99 latency or allocates on the hot path
  is a blocker, with numbers. No heap allocation, locks, syscalls, or logging on the hot path.
- Deterministic tests + reproducible benchmarks; wall-clock and RNG injected.
- Risk/position limits and kill-switches are correctness gates, not features.

## Role notes
- product/architect: optimize for latency + determinism; choose data structures and memory layout
  deliberately (preallocate, arenas, lock-free where proven). Record the latency budget per hop.
- builders/qa: prove against the tail — preallocate, avoid GC/heap on hot paths, measure p99 with a
  repeatable harness; perf-qa owns the benchmark gate.
- security: still real (market data integrity, auth to venues, secret keys) but must be perf-aware.
