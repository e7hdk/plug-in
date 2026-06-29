# Changelog

All notable changes to this plugin are documented here. Format follows
[Keep a Changelog](https://keepachangelog.com/); versions follow [SemVer](https://semver.org/).

## [0.2.0] - 2026-06-29

Brownfield onboarding + agent memory. The org can now join an **existing** codebase, not just a
fresh one, and key agents accumulate knowledge across sessions.

### Added

- **`codebase-analyst`** agent (37 total) — reverse-engineers an existing repo: detects the stack,
  maps modules/boundaries/data flow, and drafts the constitution from the real code.
- **`/onboard`** command (10 total) — existing-repo onboarding with a **cost gate**: a cheap shell
  survey (files/LOC/languages) → a token estimate across four **analysis tiers** (low/medium/high/
  full) → your approval → a **recursive map-reduce** (one scoped worker per module, splitting until
  each fits context; at `full`, every significant source file is read by some worker) →
  **hierarchical/tree synthesis** (the merge never overflows one context) → an honest per-module
  **coverage** report. Vendored/generated/binary excluded by design.
- **Per-agent memory** on `architect`, `debugger`, `reviewer`, `security`, `codebase-analyst`
  (`memory: project` + read-before/update-after), plus a documented two-layer model: durable
  checked-in docs (ADRs, postmortems, `docs/architecture.md`) as institutional memory, and opt-in
  per-agent memory installed by `/init-org` / `/onboard`.
- **AGENT-ORG.md §10 (Memory)** documenting both layers and the constitution-loading rule.

### Fixed

- **Constitution now auto-loads.** `/init-org` and `/onboard` create a root `CLAUDE.md` that imports
  `@AGENTS.md` — Claude Code auto-loads `CLAUDE.md`, not `AGENTS.md`, for the main session and every
  subagent, so the constitution + Active roster actually load.

### Notes

- Plugin-shipped agents ignore the `memory` frontmatter field; per-agent memory is activated by
  installing a project-local copy (the `/init-org` / `/onboard` memory step), trading plugin
  auto-update for that one agent.

## [0.1.0] - 2026-06-25

Initial release — a drop-in, **depth-scalable AI agent organization** for any SaaS repo.
Stack-neutral: the product/stack specifics live in the host's `AGENTS.md`.

### Added

- **36 agents** across the pods:
  - **Lead** — orchestrator.
  - **Engineering** — product, architect, backend-builder (+ api-builder, data-builder,
    worker-builder), frontend-builder, mobile-builder, design, docs, debugger, data-engineer,
    i18n-engineer.
  - **Quality** — reviewer, qa, security, e2e-qa, perf-qa, a11y-reviewer, supply-chain-security,
    mobile-qa.
  - **Platform** — devops, sre, release-manager, dba, incident-commander, mobile-release.
  - **GTM** — growth, sales, support, data, finance.
  - **Governance** — compliance, privacy, legal-review.
- **9 commands** — `/init-org`, `/scale-org`, `/spec`, `/feature`, `/next-issue`, `/review`,
  `/ship`, `/standup`, `/incident`.
- **Verify-on-write hook** (`hooks/hooks.json`) that runs the host's verify gate via
  `${CLAUDE_PROJECT_DIR}/${user_config.verify_command}` — only if that script exists.
- **`userConfig`** prompted at install — `verify_command`, `deploy_command`, `default_branch`,
  `tracker`.
- **Templates** — `AGENTS.template.md` (the host constitution), per-area nested rules, and a
  recommended `permissions` block (`settings.template.json`).
- **Expertise profiles** on three axes — languages (rust, typescript, go, python, java, cpp),
  domains (hft, ecommerce, b2b-saas, fintech, marketing-site, devtools), and capabilities
  (mobile, i18n) — woven into `AGENTS.md` by `/init-org`.
- **Three user axes** — **depth** (Lean/Team/Scale-up/Enterprise, enforced via an Active roster
  in `AGENTS.md`), **capability toggles**, and a documented **compute tier** (low/medium/high/ultra;
  shipped default = medium).
- **`AGENT-ORG.md`** — the org design (pods, depth presets, compute tiers, delegation contract).
- **CI** (`.github/workflows/validate.yml`) + a description-trigger lint (`scripts/lint-agents.sh`)
  that fails any agent description lacking an auto-delegation trigger phrase.

### Design notes

- Agents are stack-neutral; one generic role + a pluggable expertise profile (no per-language
  agent explosion).
- Charters apply researched best practices: trigger-rich `description` fields, role-criticality
  model tiering, a four-part delegation contract (objective / output / tools / boundaries), and
  explicit "when not to fan out" guidance.

[0.2.0]: https://github.com/e7hdk/plug-in/releases/tag/plug-in--v0.2.0
[0.1.0]: https://github.com/e7hdk/plug-in/releases/tag/plug-in--v0.1.0
