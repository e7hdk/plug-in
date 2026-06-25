# Changelog

All notable changes to this plugin are documented here. Format follows
[Keep a Changelog](https://keepachangelog.com/); versions follow [SemVer](https://semver.org/).

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

[0.1.0]: https://github.com/e7hdk/plug-in/releases/tag/plug-in--v0.1.0
