---
name: fb-front-design-system-builder
description: 'Use when fb-front needs design-system governance: tokens, wrappers, component zones, migration path, and consistency without rewriting the whole UI stack.'
user-invocable: true
disable-model-invocation: false
---
# fb-front Design System Builder (Hybrid)

Use this skill to standardize UI in `packages/fb-front` without rewriting the whole UI stack.

## Scope
- ONLY `packages/fb-front/**`
- Do not touch `packages/ui` (Flowise UI) or other frontends.

## Source of truth
- `packages/fb-front/design_guidelines.md`
- `packages/fb-front/client/src/index.css` (CSS variables / tokens)
- `packages/fb-front/tailwind.config.ts` (token mapping)

## Goals
- Establish **SSOT tokens** (colors/light+dark, spacing, radius, typography, shadows).
- Enforce usage via wrappers and guardrails (no hard-coded colors/spacing).
- Define allowed-zones for Flowbite/MUI/Radix to avoid style collisions.

## Context-first checklist (adapted from VibeBaza `frontend-design`)
- State the **purpose** of the UI change (which flow, what user value)
- List **constraints** (existing tokens/theme/libs, perf/a11y, module boundaries)
- Commit to **consistency goal** first (no new fonts/palettes/layout styles unless explicitly requested)

## Deliverables (checkable)
- Token taxonomy: primitive → semantic (documented)
- Hybrid policy: Flowbite vs MUI vs Radix (allowed-zones + rationale)
- Migration checklist for screens/components
- Evidence requirements for UI changes (AFTER screenshot in the built-in browser on `cd /home/projects/new-flowise/packages/fb-front && pnpm dev` + console clean)

## Definition of Done (DoD)
- New UI code uses tokens (CSS vars/Tailwind mapping), not hard-coded colors.
- Dark mode works consistently.
- No duplicate ThemeProvider behavior.
- A small set of wrapper components exists (or an explicit decision why not).

## Evidence
- Links to changed files under `packages/fb-front/**`
- Built-in browser screenshot path + viewport
- Grep summary for forbidden patterns (if used)

## Anti-Patterns

- hard-coded colors/spacings in new UI code
- introducing a new styling system without explicit rationale
- mixing Flowbite, MUI, and Radix in one screen without a boundary explanation
- redesigning established screens when the task was only consistency or extension work
