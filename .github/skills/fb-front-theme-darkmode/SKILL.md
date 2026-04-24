---
name: fb-front-theme-darkmode
description: 'Use when fb-front dark/light/system theme logic is duplicated, drifting, flickering, or inconsistent across Tailwind, MUI, Flowbite, and runtime UI evidence.'
user-invocable: true
disable-model-invocation: false
---
# fb-front Theme + Dark Mode (Single Source of Truth)

Use this skill to eliminate duplicated theme logic and make dark mode consistent.

## Scope
- ONLY `packages/fb-front/**`

## Goals
- Exactly one theme controller (light/dark/system).
- One persistent key (localStorage) and one DOM switch (`html.dark` class).
- Tailwind, MUI, Flowbite all reflect the same tokens.

## Checks
- No duplicate ThemeProviders controlling conflicting sources.
- Tokens exist for both light and dark.
- MUI ThemeProvider derives palette from the same tokens.
- Flowbite theme override (if used) derives from the same tokens.

## Failure Modes to Catch

- duplicate theme controllers
- localStorage key drift
- `html.dark` not reflecting actual selected mode
- hydration flicker or initial wrong theme flash
- dark and light tokens diverging from the same semantic source

## Evidence
- File paths for providers
- AFTER screenshots for the affected dark/light states captured in the built-in browser on `cd /home/projects/new-flowise/packages/fb-front && pnpm dev`
- Console: no hydration/theme flicker issues
