---
name: web-artifacts-builder
description: 'Use only for artifact, prototype, or demo generation that should stay isolated from production module conventions; not for regular fb-front/ui feature work.'
user-invocable: true
disable-model-invocation: false
---

# Web Artifacts Builder (Copilot Workspace Skill)

This workspace skill mirrors the Anthropic `web-artifacts-builder` workflow for GitHub Copilot.

## Scope

- prototypes
- demos
- isolated artifacts
- throwaway exploration that should not redefine production UI conventions

Do NOT use this skill as the default path for `packages/fb-front`, `packages/ui`, or other production module work unless the user explicitly asked for an artifact/demo workflow.

## Quick Start

1. Initialize project:
```bash
bash .github/skills/web-artifacts-builder/scripts/init-artifact.sh <project-name>
cd <project-name>
```

2. Build single-file artifact:
```bash
bash .github/skills/web-artifacts-builder/scripts/bundle-artifact.sh
```

## What this skill does

- Uses official upstream Anthropic scripts at runtime.
- Fetches the latest `init-artifact.sh`, `bundle-artifact.sh`, and required component archive.
- Executes upstream tooling in a temporary workspace, so your local repo stays clean.

## Notes

- Requires Node.js 18+ and internet access when running scripts.
- If your environment blocks outbound network, run scripts in an environment with GitHub access.
- Production stack rules still win: this skill must not silently override repo conventions around Flowbite/MUI/module boundaries.
