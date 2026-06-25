---
description: Run reviewer, qa, and security in parallel on a PR
argument-hint: <pr-number-or-branch>
allowed-tools: Read, Grep, Glob, Bash, Agent, mcp__github
---
For PR $ARGUMENTS, spawn the core gates in parallel: `reviewer`, `qa`, `security`.

Also spawn the specialist lenses the diff warrants (when those agents are in the roster):
- UI/web changes → `a11y-reviewer`
- hot-path / performance-sensitive changes → `perf-qa`
- a cross-cutting user flow → `e2e-qa`
- dependency/lockfile changes → `supply-chain-security`

Collect every verdict. Summarize blockers. Approve only if all the gates that ran pass;
otherwise return the required changes grouped by owner.
