---
name: fb-front-react-practices
description: 'Use when writing or reviewing React in packages/fb-front or packages/whatsapp: hooks, state, react-query, perf, accessibility, TypeScript, and component boundaries.'
user-invocable: true
disable-model-invocation: false
---
# fb-front React Practices

Use this skill when writing or reviewing React code in `packages/fb-front` or `packages/whatsapp`.

## Scope
- `packages/fb-front/**`
- `packages/whatsapp/**`
- Does NOT apply to `packages/ui` (MUI/Flowise UI — separate conventions).

## Components
- Small, single-responsibility components.
- Extract logic into custom hooks and utility functions.
- Prefer composition over inheritance.

## Effects
- `useEffect` — only for side effects (subscriptions, DOM mutations, fetching).
- Always specify correct dependency arrays.
- Always provide cleanup functions where needed (listeners, timers, subscriptions).

## Performance
- `React.memo`, `useMemo`, `useCallback` — only when there is a measured re-render problem or an expensive computation. Do not wrap everything "just in case".
- Avoid inline object/array literals in JSX props when they cause unnecessary re-renders.

## State management
- Local state — in the component (`useState`, `useReducer`).
- Cross-page / shared state — in a store (Zustand or context). Do not hoist state globally without a reason.
- Server state — `@tanstack/react-query` (already used in the project). Prefer it over manual `useEffect` + `useState` for data fetching.

## Lists & keys
- Use stable, unique identifiers as keys (IDs from data). Never use array index as a key for dynamic lists.

## Styling
- `fb-front` / `whatsapp` — Tailwind + Flowbite (`flowbite-react`).
- `ui` — MUI only.
- Do not mix styling systems across module boundaries.

## Accessibility (a11y)
- Use semantic HTML elements (`<button>`, `<nav>`, `<main>`, `<section>`, etc.).
- Add `aria-*` attributes where semantics are insufficient.
- Ensure focus styles are visible.
- Clickable areas must be at least 44×44 px.

## TypeScript
- Never use `any` — prefer `unknown` and narrow explicitly.
- Type all component props and hook return values.
- Use `zod` or equivalent schemas for runtime validation of external data (API responses, form inputs).

## Fonts (Cyrillic)
- Approved Cyrillic-friendly fonts: Manrope, Montserrat, Raleway, Playfair Display, Oswald, PT Sans, PT Serif.
- Do not introduce new fonts without explicit approval.

## Definition of Done
- No `any` types added.
- No `useEffect` without cleanup where cleanup is needed.
- No array-index keys on dynamic lists.
- Server data fetched via `@tanstack/react-query`.
- Semantic HTML + basic `aria-*` in place.

## Output Contract

Return:
- affected components/hooks
- rule violations found or `none found`
- react-query/state-management note when server data is involved
- a11y/type/perf notes
