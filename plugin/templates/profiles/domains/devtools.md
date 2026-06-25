# Developer tools — domain profile

## What matters (NFRs / priorities, ranked)
1. **Developer experience** — clear errors, fast feedback, sane defaults; the product is the API/CLI/SDK ergonomics.
2. **API/CLI stability** — semver discipline; no breaking changes without a major bump + migration path.
3. **Docs quality** — runnable examples; docs ship with the change.
4. Performance and backward compatibility across versions.

## Recommended org
- Depth: **team → scale-up**.
- Capabilities: i18n rarely; ai/ml if the tool is AI-powered.
- Key roster (emphasize): backend-builder, **docs**, DX-focused frontend, **growth**/**content**;
  reviewer guards the public surface.
- De-emphasize / skip: heavy GTM sales motion early (devtools sell bottom-up).

## Domain gates / concerns
- **No breaking change** to a public API/CLI/SDK without a major version bump + deprecation notice.
- Docs + runnable examples updated in the same PR; helpful, actionable error messages.
- Backward-compat tests across supported versions; clear deprecation policy.

## Role notes
- product/architect: design the public surface for stability; treat every exported symbol as a contract.
- builders/qa/reviewer: guard semver; test the upgrade path; prove examples actually run.
- docs: examples are first-class; keep the changelog honest.
