# Mobile — capability profile

<!-- Turn on when the product ships a native/cross-platform mobile app. Declare the stack
(React Native / Flutter / native Swift+Kotlin) in AGENTS.md; the language profile (swift/kotlin/
dart/typescript) composes with this. -->

## What this capability adds
Mobile is not "web on a small screen." It introduces, as first-class concerns:
- **No instant rollback** — a shipped build lives on devices until users update. Everything risky
  goes behind a feature flag / server kill-switch, with a defined **force-update** (min supported version).
- **Offline & lifecycle** — offline-first with sync + conflict resolution; background→foreground,
  OS-kill + state restoration, deep links, push notifications.
- **Constrained devices** — perf budgets: cold-start time, frame rate (no scroll jank), memory,
  and app-size impact of dependencies.
- **Store gatekeeping** — App Store / Play review can reject; privacy labels / data-safety / iOS ATT,
  permission justification, signing & provisioning.
- **Platform conventions** — Apple HIG vs Material; safe areas, touch targets, dynamic type, dark mode.

## Agents it activates
`mobile-builder`, `mobile-qa`, `mobile-release`. (For native-both teams that want it, split
`mobile-builder` into `ios-builder` + `android-builder` via a host override.)

## Gates / concerns
- A mobile feature ships with its offline + error + permission-denied states, not just the happy path.
- Releases are human-gated through `mobile-release`, carry a rollback story (flag/kill-switch/force-update),
  and watch crash-free rate during phased rollout.
- No signing secrets in the repo; permissions requested in context with a justification.

## Role notes
- mobile-builder: offline/lifecycle/perf + platform conventions.
- mobile-qa: the device/OS matrix + interruptions/permissions/network failure modes (real devices for push/camera/biometrics/perf).
- mobile-release: signing, store review, phased rollout, force-update.
- design: platform conventions (HIG/Material), safe areas, touch targets.
- security: secure on-device storage (keychain/keystore), cert pinning, no secrets in the bundle.
