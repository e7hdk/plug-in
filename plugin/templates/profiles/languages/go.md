# Go — expertise profile

## Idioms
- Error handling: return errors explicitly (`if err != nil`); wrap with `fmt.Errorf("...: %w", err)`
  to preserve the chain. Libraries don't `panic`. Sentinel/typed errors checked with `errors.Is/As`.
- Concurrency: goroutines + channels; pass `context.Context` for cancellation/deadlines; every
  goroutine has a clear exit. Protect shared state with a mutex or (better) don't share it.
- API design: accept interfaces, return concrete structs; keep interfaces small.

## Tooling & verify
- Format: `gofmt -l .` (and `goimports`) · Vet: `go vet ./...` · Lint: `golangci-lint run` · Test: `go test ./...`.
- The verify gate runs: `test -z "$(gofmt -l .)" && go vet ./... && golangci-lint run && go test -race ./...`.

## Testing
- Table-driven tests; `t.Parallel()` where safe; `-race` always in CI. `httptest` over real network;
  inject the clock. Deterministic.

## Gotchas / never-do
- Ignoring errors with `_ =`; goroutine leaks (no context/cancel); writing to a nil map; unbuffered
  channel deadlocks; capturing the loop variable (pre-1.22); `fmt.Sprintf` into SQL.

## Role notes
- builder: handle every error, thread `context`, bound and exit every goroutine.
- reviewer: goroutine leaks, races (`go test -race`), error wrapping, ignored returns.
- security: SQL/command injection via string building; unvalidated input; missing context timeouts.
