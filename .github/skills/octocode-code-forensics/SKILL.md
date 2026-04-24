---
name: octocode-code-forensics
description: 'Use when tracing code reality in this repo: where defined, who calls it, impact surface, execution path, boundary mapping, and read-only code forensics before implementation or review.'
user-invocable: true
disable-model-invocation: false
---
## Vendor Source Rule

- If this task touches third-party addons, templates, examples, or integration choices in this workspace, start with `/home/projects/gamedev/godot-lib-pazzle/README.md` and follow `.github/instructions/vendor-sourcing.instructions.md`.

# Code Forensics (Search + Usages)

Use this skill for evidence-first navigation in a large repo: locate definitions, usages, boundaries, and execution paths before coding or review.

## Trigger Phrases

Load this skill when the task asks:
- where something is defined
- who calls or uses a symbol
- how data flows through the system
- what else will break if this changes
- which files own a route, job, entity, or UI flow

## Required Forensics Funnel

1. `search/codebase` or `search/searchSubagent` to find the symbol, route, or implementation area.
2. `search/usages` to reconstruct references and the impact surface.
3. `read/readFile` only on the narrowed files needed to confirm behavior.
4. Summarize execution path, boundaries, and blast radius.

Do not skip from a broad search straight to implementation claims without `search/usages` or equivalent reference tracing.

## When to Use

- “где определено / кто вызывает / как течёт”
- impact analysis before refactors
- debugging cross-module bugs
- tracing route → service → DB or frontend → API → backend chains

## Required Evidence

- exact files consulted
- symbol/reference locations when applicable
- reconstructed flow or boundary map
- blast radius summary
- uncertainty note if the chain could not be fully verified

## Output Contract

Return:
- relevant files
- key symbols or entry points
- execution-flow summary
- impact/blast radius
- open uncertainty, if any
