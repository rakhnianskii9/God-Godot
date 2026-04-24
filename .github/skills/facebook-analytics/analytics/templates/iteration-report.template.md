# Facebook Observability Lab Ledger

Generated: {{GENERATED_AT}}

Use this ledger for one experiment stream. Append one row per iteration and keep the chat answer aligned with the latest row.

## Context

| Field | Value |
|---|---|
| Module | Facebook report/background sync observability |
| Workspace | |
| Owner | |
| Baseline branch / commit | |
| Primary report or scope | |
| Default log artifact | `Zlogs.md` |

## Iteration Ledger

| Iteration | Timestamp (HCM) | Goal / Hypothesis | Env Profile | ENV Delta | Code Reality Drift | Run Kind | Run / Scope | Window | Result | Speed | Efficiency | Stability | Change Quality | Logs | Notes / Next Step |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|

## Metric Notes

| Dimension | What to record |
|---|---|
| Code Reality Drift | `none`, `detected`, or `fixed`; include stale assumption and files that restored truth |
| Speed | `durationMs`, `avgDurationMs`, `totalRowsReceived`, `rowsPerSecond` |
| Efficiency | `totalFetches`, `success/partial/failed`, `rowsInserted/Updated/Skipped`, `usableDataReached` |
| Stability | `errorCount`, gap count, repeated log faults, final verdict `PASS/WARN/FAIL` |
| Change Quality | build result, editor problems, docs/migration status, final verdict `PASS/WARN/FAIL/N/A` |

## Code Reality Evidence

| Evidence source | Notes |
|---|---|
| Current worker/service/entity files | |
| Relevant migrations | |
| Existing module doc `docs/moduls/Facebook.md` | |

## Query / API Evidence

| Evidence source | Notes |
|---|---|
| `facebook_observability_run` | |
| `facebook_insights_fetch_log` | |
| `facebook_ads_insight` | |
| `facebook_daily_snapshot` / derived tables | |
| `/ads/observability/*` endpoints | |
| `pnpm logs` -> `Zlogs.md` | |

## Stable Comparison Rules

- Keep workspace, report scope, date window, and trigger source fixed unless the iteration explicitly tests one of them.
- Record only the env variables intentionally changed in `ENV Delta`.
- If code reality drift is detected, resolve it before publishing the final verdict for the iteration.
- If code changed, add build and editor evidence before calling the iteration better.
- If code changed, also refresh logs and observability evidence after the edits and overwrite provisional values.
- If code did not change, mark `Change Quality` as `N/A (no code change)`.