# Godot Agent Audit Checklist

Use this checklist when reviewing changes to the Godot agent layer under
`.github/agents/godot-*.agent.md`.

## Reference Wiring

- [ ] Agents read `.github/context/VERSION.md` before version-sensitive guidance
- [ ] Agents use `.github/context/breaking-changes.md` for migration risk checks
- [ ] Agents use `.github/context/deprecated-apis.md` before suggesting APIs
- [ ] Agents use `.github/context/current-best-practices.md` or `.github/context/modules/*.md` when the specialty requires them
- [ ] No agent still points at `docs/engine-reference/godot/*`

## Workspace Contract

- [ ] Agent body references `.github/instructions/code-rules.instructions.md`
- [ ] Agent body treats `.github/instructions/copilot-instructions.md` as part of the active workspace contract
- [ ] Agent body includes the destructive git guardrail (`git reset`, `git restore`, `git clean`, `git checkout -- ...`)

## Tool-Contract Hygiene

- [ ] No body text mandates retired tool names such as `Task tool` or `WebSearch`
- [ ] No body text instructs the agent to wait for `Write/Edit tools`
- [ ] Delegation uses the actual Godot specialist names in this workspace

## Current Godot Roles

- [ ] `godot-specialist`
- [ ] `godot-gdscript-specialist`
- [ ] `godot-csharp-specialist`
- [ ] `godot-shader-specialist`
- [ ] `godot-gdextension-specialist`

## Quick Validation Commands

- [ ] `grep -R "docs/engine-reference/godot/|Task tool|WebSearch|Write/Edit tools|May I write" .github/agents/godot-*.agent.md`
- [ ] `grep -R "\.github/context/VERSION.md|code-rules.instructions.md" .github/agents/godot-*.agent.md`
- [ ] Run editor diagnostics or `get_errors` on the touched `.agent.md` files