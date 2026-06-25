# Java — expertise profile

## Idioms
- Immutability first: `record`s and `final` fields; return `Optional<T>` instead of `null`.
- Errors: use exceptions deliberately (checked for recoverable, unchecked for bugs); never swallow,
  never `catch (Exception)` and continue. Re-interrupt on `InterruptedException`.
- Resources: try-with-resources for anything `Closeable`. Constructor injection over field injection.
- Collections/streams for transforms; respect the `equals`/`hashCode` contract.

## Tooling & verify
- Format: `spotless` (google-java-format) · Static: `checkstyle` + `spotbugs`/`errorprone` · Test: JUnit.
- The verify gate runs (Gradle): `./gradlew spotlessCheck check test` (or `mvn -q verify`).

## Testing
- JUnit 5 + AssertJ + Mockito. Deterministic — inject the clock and collaborators; no real network.

## Gotchas / never-do
- NPEs from returning/accepting `null`; mutable shared state without synchronization; leaking
  resources (no try-with-resources); broken `equals`/`hashCode`; swallowing `InterruptedException`.

## Role notes
- builder: immutable types, try-with-resources, constructor injection, `Optional` at boundaries.
- reviewer: null handling, thread-safety, resource closing, exception swallowing.
- security: unsafe deserialization; XXE in XML parsers; SQL via `Statement` (use `PreparedStatement`).
