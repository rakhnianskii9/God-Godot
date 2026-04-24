---
name: orchestration-qa
description: 'Use when validating workspace orchestration and control-plane files: agents, skills, MCP, hooks, instructions, AGENTS registry, .github/bin scripts, .github/context artifacts, model naming, canonical paths, and legacy trace cleanup.'
user-invocable: true
disable-model-invocation: false
---
# Orchestration QA Skill

Use this skill when validating that agent orchestration is configured and functioning in the workspace.
Trigger: changes to `.github/agents/*`, `.github/skills/*`, `.github/mcp/*`, `.github/hooks/*`, `.github/instructions/*`, `.github/bin/*`, `.github/context/*`, `.github/tasks.md`.

Goal: validate the whole orchestration control plane, not just syntax. The skill must catch structural breakage, stale paths, false summaries, doctrine drift, retired-mechanism traces, and script/artifact mismatches across `.github`.

## Validation Checklist

### 1. Agent Files (`.github/agents/*.agent.md`)
- [ ] Every `.agent.md` has valid YAML frontmatter: `name`, `description`, `tools`, `model`, `user-invocable`, `disable-model-invocation`
- [ ] `model` uses qualified format `Model Name (vendor)` — e.g. `Claude Opus 4.6 (copilot)`, never `opus-4.6` or `codex`
- [ ] `tools` array references only valid tool namespaces in the VS Code environment
- [ ] Subagent agents (`user-invocable: false`) are listed in at least one parent's `agents:` array
- [ ] User-invocable agents have `disable-model-invocation: true`
- [ ] All agents reference `code-rules.instructions.md` in their body text
- [ ] Hard guardrail against `git reset/restore/clean` present in every agent with write tools
- [ ] `agents:` field (subagent list) matches actual `.agent.md` files in directory
- [ ] Discovery surface quality: `description` is specific enough for agent selection and contains realistic trigger terms for the role
- [ ] Tool-contract compliance: body text does not mandate nonexistent tool namespaces or unavailable MCP/tool names

### 2. Agent Layer Reality
- [ ] If `.github/agents/` is empty, active docs and instructions do not claim custom agents are available
- [ ] If custom agents exist, no orphan agents remain (every non-user-invocable agent appears in a parent's `agents:` list)
- [ ] If custom agents exist, there are no circular references (agent A → B → A)
- [ ] If custom agents exist, role split is internally coherent and not duplicated or contradictory across files

### 3. Skills (`.github/skills/*/SKILL.md`)
- [ ] Every skill directory contains a `SKILL.md` file
- [ ] SKILL.md has valid frontmatter: `name`, `description`
- [ ] Skills referenced in active agent routing tables actually exist as directories
- [ ] If custom agents exist, their referenced skill directories exist; if no custom agents exist, active docs do not imply that every skill must be agent-bound
- [ ] Skill descriptions contain trigger phrases strong enough for discovery
- [ ] Skill scope matches the file type: workflow bundle vs always-on instruction vs agent responsibility is not confused

### 4. MCP Servers (`.github/mcp/mcp.json`)
- [ ] JSON is valid and parseable
- [ ] Every MCP server referenced in agent `tools:` exists in mcp.json
- [ ] No hardcoded secrets in mcp.json args (only env var references like `${ENV_VAR}`)
- [ ] Server commands point to valid executables (npx, node, python3, etc.)
- [ ] Control-plane summaries are truthful: MCP servers claimed in `AGENTS.md`, instructions, or skills actually exist in `mcp.json`
- [ ] No stale platform claims: removed or never-configured servers are not advertised as available
- [ ] Environment variable references are consistent with the current runtime contract and do not point to retired paths

### 5. Hooks (`.github/hooks/`)
- [ ] `hooks.json` is valid JSON with `PreToolUse` and/or `PostToolUse` arrays
- [ ] Every hook script referenced in hooks.json exists and is executable
- [ ] Hook scripts output valid JSON (`{"continue": true}` or denial with reason)
- [ ] pretool-guard blocks: rm -rf, git reset/restore/clean, docker build, pnpm build:compose
- [ ] Hook coverage matches project rules: posttool hooks reflect current quality/security expectations from instructions
- [ ] Hook references use real relative paths and do not point to deleted scripts

### 6. Operational Orchestration Artifacts
- [ ] `.github/bin/update-ide` matches the current control plane and does not reference retired systems, old paths, or removed editors/integrations
- [ ] `.github/bin/start-scorecard-loop` does not reference removed orchestration layers as if they were active
- [ ] If `.github/tasks.md` is absent or `task-manager` is not active, docs and MCP configs do not claim it as a source of truth
- [ ] `.github/context/*` contains only active context artifacts used by the current orchestration model
- [ ] `.github/context/project-tree.md` reflects the current `.github` structure after orchestration changes

### 7. Cross-File Consistency
- [ ] `instructions/copilot-instructions.md` exists and references `instructions/code-rules.instructions.md`
- [ ] If `agents/AGENTS.md` exists, it lists only actual agents from `.github/agents/`; if it does not exist, no active doc claims it exists
- [ ] If agent registry files exist, their model names match frontmatter `model` values
- [ ] Any skill routing table that exists in active docs or agents matches actual skills in `.github/skills/`
- [ ] Canonical paths are correct everywhere: no stale references to `.github/AGENTS.md` or `.github/copilot-instructions.md` if the real files live under subdirectories
- [ ] Registry summaries do not claim capabilities absent from actual config (for example MCP families, hooks, scripts, or user-invocable agents)

### 8. Orchestration Doctrine Consistency
- [ ] Startup protocol is consistent with the currently enabled MCP/tooling and does not require removed layers like `memory` or `task-manager` when they are absent
- [ ] If memory lifecycle rules are documented, they match the actually enabled memory path instead of a removed server
- [ ] Solve-loop / completion doctrine is explicit where intended and does not contradict global instructions
- [ ] Review/scorecard/deep-analysis/diagnostics modes are only described where a real owner file still exists
- [ ] MCP degradation-tag policy is consistent across orchestration files
- [ ] Docker-build prohibition and non-Docker validation policy are consistent across instructions, hooks, and agent docs

### 9. Legacy Trace Hygiene
- [ ] Retired mechanisms are fully removed from active `.github` control plane (for example session registries, attempts registries, obsolete editors, removed wrappers)
- [ ] Archive data may preserve history, but active docs/scripts/skills must not instruct agents to use retired mechanisms
- [ ] No stale examples, prompts, or helper scripts mention a specific old incident as if it were normative workflow

### 10. Model Naming (AI Naming Policy)
- [ ] Scan all `.agent.md` files for `model:` values
- [ ] Each value matches pattern: `<Model Name> (<vendor>)` — e.g. `Claude Opus 4.6 (copilot)`
- [ ] No abbreviated forms: `codex`, `opus`, `sonnet`, `gemini` without full qualification
- [ ] Descriptions include model name for traceability

### 11. Review Method
- [ ] Validate syntax first, then hierarchy, then cross-file truthfulness, then doctrine, then legacy-trace hygiene
- [ ] Prefer findings ordered by severity: CRITICAL → WARNING → INFO
- [ ] Treat code/config reality as source of truth over markdown summaries when they conflict
- [ ] If a summary table and runtime config disagree, report the summary as false rather than assuming intent

## Output Format

```markdown
## Orchestration QA Report

| # | Severity | Check | Status | File | Issue | Fix |
|---|----------|-------|--------|------|-------|-----|
| 1 | CRITICAL/WARNING/INFO | Agent frontmatter | PASS/FAIL | path | detail | action |
| ... | ... | ... | ... | ... | ... |

**Summary**: X/Y checks passed. {PASS | FAIL — N critical issues}

**Truthfulness Gaps**
- List every place where docs/registry/skill text claims a capability that the actual control plane does not provide.

**Doctrine Gaps**
- List mismatches in startup protocol, memory lifecycle, solve-loop, scorecard, diagnostics, or degradation-tag policy.

**Legacy Trace Gaps**
- List any retired mechanism still referenced in active `.github` files.
```

## Severity Levels
- **CRITICAL**: Agent won't load or delegates to nonexistent subagent → must fix immediately
- **WARNING**: Stale reference, false summary, doctrine drift, or missing operational validation → fix in next cleanup
- **INFO**: Optimization opportunity, no functional impact
