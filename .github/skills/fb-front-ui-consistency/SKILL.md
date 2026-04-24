---
name: fb-front-ui-consistency
description: 'Use when fb-front UI needs consistency review or repair: spacing, typography, colors, layout hierarchy, motion, and anti-AI-drift governance.'
user-invocable: true
disable-model-invocation: false
---
# fb-front UI Consistency (Order > Aesthetics)

Use this skill when the UI is inconsistent (AI-style drift) and the priority is order, clarity, and predictable UX.

## Scope
- ONLY `packages/fb-front/**`

## Non-negotiables
- Prefer consistency over novelty.
- No new random colors/spacing/radius.
- Motion must be purposeful (micro-interactions), not decorative.

## Context-first framing (adapted from VibeBaza `frontend-design`)
- Purpose: what user flow/problem this screen solves
- Constraints: existing tokens/theme/libs/perf/a11y rules we must follow
- Consistency goal: match the current fb-front design system (no “bold redesign” unless explicitly requested)

## Checklist
- Spacing uses a fixed scale (4/8/16/24/32...) and is consistent across pages.
- Typography scale is consistent (headings/body/labels).
- Colors come from tokens (no Tailwind raw grays/reds unless approved).
- Focus/hover states exist and are accessible.
- Layout hierarchy is stable across views.

## Evidence Requirements

- changed files under `packages/fb-front/**`
- AFTER screenshot or visual evidence for the affected route from the built-in browser on `cd /home/projects/new-flowise/packages/fb-front && pnpm dev` when runtime verification is possible
- concrete examples of inconsistency, not generic taste statements
- token/source references when flagging color or spacing drift

## Output
- Problems grouped by: colors, spacing, typography, components, motion
- Concrete fix list with DoD + evidence pointers
