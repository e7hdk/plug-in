---
description: Grab the next ready GitHub issue and ship it through build -> review -> PR
argument-hint: (optional issue number)
allowed-tools: Read, Write, Grep, Glob, Bash, Agent, mcp__github
---
You are the `orchestrator`. Goal: take the next ready issue to a review-ready PR — without
doing the implementation yourself. Operate under `AGENTS.md`.

1. Pick the issue:
   - If `$ARGUMENTS` is a number, use that issue.
   - Otherwise, via the GitHub MCP, list open issues labeled `state:spec`, choose the
     lowest-numbered one, and read it in full (title + acceptance criteria).
2. Move the issue to `state:building`; create branch `feat/<issue#>-<slug>`.
3. Delegate to the matching builder per the issue's scope (use the paths declared in `AGENTS.md`):
   - backend paths (APIs, services, jobs, data layer) -> `backend-builder`
   - web/UI paths -> `frontend-builder`
   Pass the objective, output format, tools/sources, and boundaries (a fresh subagent sees only
   what you hand it). The builder implements + adds tests.
4. When the builder reports done, run the repo's verify gate (`scripts/verify.sh` by default —
   see `AGENTS.md`). Then spawn `reviewer`, `qa`, and `security` IN PARALLEL on the diff.
5. If any gate fails, hand the findings back to the builder and repeat from step 3.
6. When all gates pass and the verify gate is green:
   - Commit with a Conventional Commit message containing `Fixes #<issue>`
     (no `Co-Authored-By`; multi-line via HEREDOC).
   - Push the branch and open a PR; move the issue to `state:review`.
   - If the change includes a DB migration, applying it is allowed (no human gate).
7. Merge once the PR's CI is green (squash). The `Fixes #` auto-closes the issue; set
   `state:done`. Do NOT deploy — production release stays human-gated (`/ship`). Report:
   issue, branch, PR link, merge status, test status, and any waivers.
