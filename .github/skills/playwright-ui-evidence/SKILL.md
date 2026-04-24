---
name: playwright-ui-evidence
description: 'Use when UI evidence is needed: screenshots, console issues, network failures, route verification, and frontend change verification in the built-in browser on the fb-front dev server.'
user-invocable: true
disable-model-invocation: false
---
# UI Visual Evidence

Use this skill when you need runtime evidence for UI or UX issues, regressions, or post-implementation verification.

The skill name is kept for backward compatibility inside the current agent system, but frontend change verification is now a built-in-browser-only path.

## Scope
- Prefer the narrowest scope possible (single page/flow).
- For fb-front UI: focus on `packages/fb-front/**` flows unless the task explicitly targets other modules.

## When to use
- “нужны реальные скрины до/после”
- “в консоли ошибки”
- “проверь сеть / запросы / 401/403/404”
- “воспроизведи баг в браузере”

## Rules
- Treat as **read-only evidence** unless the parent Conductor explicitly allows actions.
- Always capture:
  - URL
  - viewport size
  - screenshots (AFTER-only for implementation verification; before/after only when the task explicitly requires comparison)
  - console logs (errors/warnings)
  - key network requests (status + URL)

## Verification Path: Built-in Browser Tools (VS Code 1.110+)
For post-implementation frontend change verification and single-page validation, use VS Code's built-in browser tools:
- `open_browser_page`
- `navigate_page`
- `read_page`
- `screenshot_page`
- `click_element`

Use this path when you need:
- a quick AFTER screenshot
- page text or element visibility confirmation
- route-level verification on a running dev server

Do not switch to Playwright MCP or chrome-devtools MCP as an alternative verification path for frontend changes.

## Dev Server (default target for post-implementation checks)
- fb-front dev server: `cd /home/projects/new-flowise/packages/fb-front && pnpm dev` → `http://localhost:5173`
- Only AFTER screenshots are needed for implementation verification — no BEFORE captures required.
- User authenticates the app manually before the verification cycle.
- Docker build is not part of this verification path.

## Evidence
- Screenshot paths (or tool output)
- Console/network snippets showing the defect or the fix
- Minimal reproduction steps (copy-ready)

## Output Contract
- State that the built-in browser path was used.
- If the page could not be opened or the dev server was unavailable, report `NOT_COLLECTED` explicitly.
- Keep evidence focused on the affected route or flow; avoid broad exploratory browsing.

Preferred report shape:
- target URL/route
- evidence path used
- screenshots captured
- console/network result
- reproduction status: reproduced | verified-fixed | not-collected
