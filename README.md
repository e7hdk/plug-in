# plug-in — a drop-in AI agent organization for any SaaS repo

`/plugin install plug-in@plug-in` gives any SaaS repository an instant, versioned
**engineering + GTM organization**: an orchestrator that routes work to narrow specialists,
a GitHub-Issues task bus, parallel quality gates, and mechanical guardrails.

You fill in one `AGENTS.md` (your product + stack + rules); the agents do the rest.

> **Status:** v0.2.0. 37 stack-neutral agents + 10 commands; greenfield (`/init-org`) **and
> existing-repo (`/onboard`) onboarding**, per-agent memory, expertise profiles,
> depth/capability/compute axes, a verify hook, and CI.

## What you get

- **An orchestrator → specialist topology.** One lead decomposes a goal into issues and
  routes each to the right specialist; it never writes product code itself.
- **A GitHub-Issues task bus.** issue → branch → build → parallel gates → PR → merge → ship.
- **Parallel quality gates** on every PR: `reviewer` ∥ `qa` ∥ `security` (block merge on fail).
- **Mechanical guardrails.** No secrets, no force-push; deploy / money / outbound are human-gated.

### Roster (37 agents today)

`orchestrator` · `product` · `architect` · `codebase-analyst` · `backend-builder` · `api-builder` · `data-builder` ·
`worker-builder` · `frontend-builder` · `mobile-builder` · `mobile-qa` · `mobile-release` · `design` ·
`reviewer` · `qa` · `security` · `e2e-qa` ·
`perf-qa` · `a11y-reviewer` · `supply-chain-security` · `devops` · `sre` · `release-manager` ·
`dba` · `incident-commander` · `docs` · `debugger` · `data-engineer` · `growth` · `sales` · `support` · `data` · `finance` · `i18n-engineer` · `compliance` · `privacy` · `legal-review`

The org is designed to scale by **depth** — Lean (~8) → Team (~16) → Scale-up (~32) →
Enterprise (~60) — plus capability toggles (mobile, ai/ml, i18n, …). See
[`plugin/AGENT-ORG.md`](./plugin/AGENT-ORG.md) for the full pod map, the depth presets, and the
planned specialist roster.

### Commands

`/init-org` · `/onboard` · `/scale-org` · `/spec` · `/feature` · `/next-issue` · `/review` · `/ship` · `/standup` · `/incident`

`/init-org` scaffolds a **fresh** repo (`AGENTS.md`, `CLAUDE.md`, issue labels, nested rules, and the
**active roster** for your depth). `/onboard` does the same for an **existing** repo — it analyzes the
code, generates `AGENTS.md` + a `docs/architecture.md` map from the real stack, and wires up `CLAUDE.md`.
`/scale-org <depth>` changes the active roster later as the team grows; the orchestrator routes only to
active agents.

## Guardrails

- **Verify-on-write hook** (ships with the plugin): after any `Write`/`Edit`, it runs your
  verify gate — the `verify_command` setting, `scripts/verify.sh` by default — but only if that
  script exists, so repos without a gate pay nothing.
- **Recommended permissions** (`plugin/templates/settings.template.json`): deny secrets +
  force-push + `rm -rf`, ask on deploy/infra, allow read/test/git/the GitHub task bus. `/init-org`
  merges it into your `.claude/settings.json`; extend `allow` with your stack's commands.

## Configuration (prompted at install)

`verify_command` (default `scripts/verify.sh`) · `deploy_command` · `default_branch` (default
`main`) · `tracker` (default `github`). Everything else product- or stack-specific lives in your
repo's `AGENTS.md`.

## Install

```
/plugin marketplace add <owner>/plug-in
/plugin install plug-in@plug-in
```

Dogfood without publishing (loads for one session):

```
claude --plugin-dir ./plugin
```

## Repository layout

```
plug-in/
├── .claude-plugin/marketplace.json   # marketplace: name "plug-in", one plugin
├── plugin/
│   ├── .claude-plugin/plugin.json    # the plugin manifest (+ userConfig)
│   ├── AGENT-ORG.md                  # org design: pods, depth presets, roster
│   ├── agents/                       # the agent charters (flat — subfolders break discovery)
│   ├── commands/                     # the slash commands
│   ├── hooks/hooks.json              # verify-on-write hook
│   └── templates/                    # AGENTS.md + nested rules + permissions + expertise profiles
├── scripts/lint-agents.sh            # description-trigger lint
├── .github/workflows/validate.yml    # CI: json syntax + lint + plugin/marketplace validate
├── plugin-dev/                       # build plan + frozen source snapshot (not shipped)
├── LICENSE
└── README.md
```

## License

MIT — see [LICENSE](./LICENSE).
