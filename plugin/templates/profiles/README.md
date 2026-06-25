# Expertise profiles

Profiles are **pluggable expertise data** — not agents. They keep the agent *roles* generic
(one `backend-builder`, one `reviewer`, …) while making them **sharp** for a specific language
and domain. A host on Rust + HFT gets a `backend-builder` that behaves like a Rust HFT engineer,
without shipping a `rust-hft-backend-builder.md`.

## Three axes

- **`languages/<lang>.md`** — idioms, tooling, the verify command, testing discipline, and
  footguns for one language. Sharpens every builder/reviewer working in that language.
- **`domains/<domain>.md`** — what matters in a vertical (NFRs, gates, concerns) **and the
  recommended org shape** (depth + capability toggles + key roster). Selecting a domain
  configures the org — this is the "context-aware agent selection."
- **`capabilities/<capability>.md`** — a cross-cutting feature axis (mobile, ai/ml, i18n,
  payments, agency) turned on regardless of depth; it adds its agents to the active roster and
  weaves its constraints (e.g. mobile's "no instant rollback") across the org.

## How they're applied

`/init-org` asks the host for its **language(s)** and **domain**, then **weaves** the chosen
profiles into the host's constitution:
- the language profile → the relevant area's nested `AGENTS.md` (e.g. the backend root),
- the domain profile → the root `AGENTS.md` ("Domain context" + the recommended roster).

The generic agents already read `AGENTS.md` and the nearest nested `AGENTS.md`, so no new
mechanism is needed — the expertise rides the existing rail.

## Who picks the stack

- **Existing repo:** the stack is already declared in `AGENTS.md`; agents follow it. No choice.
- **Greenfield:** the user picks the language at onboarding; the `architect` proposes options
  with trade-offs and the human confirms (a stack choice is a human-gated, hard-to-reverse
  decision). `/init-org` then weaves the matching profiles.

## Adding a profile

Copy `_TEMPLATE.md` in the relevant folder and fill it in. Keep it to idioms + tooling +
gotchas (languages) or NFRs + recommended org + gates (domains) — not a tutorial. Profiles are
the easiest thing to contribute and the safest to extend.
