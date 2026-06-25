---
description: Triage and diagnose a production incident, draft a postmortem
argument-hint: <incident-id-or-description>
allowed-tools: Read, Grep, Glob, Bash, Agent, mcp__github
---
Coordinate the response to incident: $ARGUMENTS

1. Assess severity. If sev-high / customer-impacting, flag for a human NOW. Where the org runs it,
   `incident-commander` owns coordination — severity, role assignments, the running timeline, and
   (human-gated) status comms.
2. `debugger` reproduces, isolates, and diagnoses the root cause. **Mitigate first** (rollback /
   flag-off via `devops`/`sre`) before chasing the perfect fix; confirm recovery from signals.
3. Open a fix Issue/PR and hand to the relevant builder (objective/output/tools/boundaries).
4. Draft a blameless postmortem (timeline, cause, fix, prevention) → `docs`; turn prevention items
   into tracked issues.
