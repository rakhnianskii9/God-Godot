---
name: fb-front-datetime-timezone
description: 'Use when fb-front shows dates, times, ranges, relative time, or timezone-sensitive values and you need one consistent Asia/Ho_Chi_Minh formatting contract.'
user-invocable: true
disable-model-invocation: false
---
# fb-front DateTime/Timezone Contract

Use this skill to standardize how dates/times are shown to users.

## Scope
- ONLY `packages/fb-front/**`

## Defaults
- Timezone: `Asia/Ho_Chi_Minh`
- Format: define once per task or module and reuse consistently

## Rules
- Avoid local page-level `formatDate()` clones.
- Avoid `toLocaleString()` without explicit `timeZone`.
- Prefer one shared helper module (for example `client/src/lib/datetime/*`).
- Distinguish explicitly between:
	- date-only values
	- date+time values
	- relative time labels
	- persisted UTC timestamps rendered in local UI time
- Do not mix browser-local implicit timezone behavior with explicit UI timezone rules.

## Evidence
- Search results showing duplicate/local formatting helpers removed or consolidated
- Exact helper/module used as the formatting source of truth
- Example UI screenshots from the built-in browser on `cd /home/projects/new-flowise/packages/fb-front && pnpm dev` proving consistent output
- If a shared helper does not yet exist, state the chosen temporary contract and where consolidation should happen next

## Output Contract

Return:
- formatting source of truth
- affected files
- timezone/format decisions
- evidence of consistency
- open edge cases, if any
