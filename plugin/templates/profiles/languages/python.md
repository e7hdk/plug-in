# Python — expertise profile

## Idioms
- Typing: type hints on every public function; run a strict checker (mypy/pyright). Model data with
  `dataclasses`/`pydantic`, not loose dicts.
- Error handling: raise/catch specific exceptions — never bare `except:`; don't swallow. Validate
  external input at the edge (pydantic).
- Style: prefer pure functions + dependency injection; context managers for resources; f-strings.

## Tooling & verify
- Format+lint: `ruff format --check . && ruff check .` · Types: `mypy .` (or `pyright`) · Test: `pytest -q`.
- The verify gate runs: `ruff format --check . && ruff check . && mypy . && pytest -q`.

## Testing
- `pytest` + fixtures. Deterministic — no real network/clock/DB; inject clients, use `freezegun`/
  `responses`, in-memory fakes.

## Gotchas / never-do
- Mutable default arguments (`def f(x=[])`); bare `except:`; swallowing exceptions; untyped public
  APIs; circular imports; `assert` for runtime validation (stripped under -O).

## Role notes
- builder: type public APIs, inject dependencies, keep functions pure where possible.
- reviewer: mutable defaults, bare excepts, missing/loose types, hidden I/O in "pure" code.
- security: `eval`/`exec`/`pickle`/`yaml.load` on untrusted input; SQL via string formatting;
  `subprocess(..., shell=True)`.
