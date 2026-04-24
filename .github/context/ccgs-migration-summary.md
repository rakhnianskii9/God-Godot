# External Framework Migration Summary

This repository previously carried a retired external framework as an external
reference set. Before removing it, the useful Godot-specific content was
selected and normalized into the active workspace control plane.

## Retained

- Godot version/reference docs now live in `.github/context/`:
  - `VERSION.md`
  - `breaking-changes.md`
  - `current-best-practices.md`
  - `deprecated-apis.md`
  - `modules/*.md`
- Godot agent QA reference now lives in `.github/context/godot-agent-test-specs.md`
- Local Godot agent review checklist now lives in `.github/context/godot-agent-audit-checklist.md`
- The skill-testing framework now lives in `.github/skill-testing-framework/`
  because active local skills still depend on its catalog, rubric, templates,
  and agent/skill behavioral specs.

## Not Retained

- The rest of the top-level external framework repository (`design/`, `docs/`, legacy hidden config,
  and other non-retained project scaffolding)
  Reason: the active workspace already has its own `.github/agents/`,
  `.github/instructions/`, `.github/skills/`, hooks, MCP configuration, and
  the necessary Godot references were extracted into local retained paths.

## Deletion Rule

After the retained files above are present and validated, the
That retired external framework tree is safe to remove from the workspace.