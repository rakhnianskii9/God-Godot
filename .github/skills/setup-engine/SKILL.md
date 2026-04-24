---
name: setup-engine
description: "Configure the project's game engine and version. Records the engine in the workspace's chosen project-context file, detects knowledge gaps, and populates engine reference docs when the version is beyond the LLM's training data."
argument-hint: "[engine] | [engine version] | refresh | upgrade [old-version] [new-version] | no args for guided selection"
user-invocable: true
---

## Vendor Source Rule

- If this task touches third-party addons, templates, examples, or integration choices in this workspace, start with `/home/projects/gamedev/godot-lib-pazzle/README.md` and follow `.github/instructions/vendor-sourcing.instructions.md`.

When this skill is invoked:

## 1. Parse Arguments

Four modes:

- **Full spec**: `/setup-engine godot 4.6` — engine and version provided
- **Version only**: `/setup-engine 4.6` — Godot version provided directly
- **No args**: `/setup-engine` — fully guided Godot setup (version + language + defaults)
- **Refresh**: `/setup-engine refresh` — update reference docs (see Section 10)
- **Upgrade**: `/setup-engine upgrade [old-version] [new-version]` — migrate to a new engine version (see Section 11)

If the first argument is `godot`, treat any second argument as the requested version.
If the first argument looks like a version number, treat it as `godot [version]`.

---

## 2. Guided Mode (No Arguments)

If no version is specified, run a Godot-first setup flow:

### Check for existing game concept
- Read `design/gdd/game-concept.md` if it exists — extract genre, scope, platform
   targets, art style, team size, and any pinned Godot recommendation from `/brainstorm`
- If no concept exists, inform the user:
  > "No game concept found. Consider running `/brainstorm` first to discover what
   > you want to build. Or tell me about your game and I can help you choose a
   > Godot version, language, and default constraints."

### Ask in this order:

**Question 1 — Target platform** (ask first, always, via `vscode_askQuestions`):
- Prompt: "What platforms are you targeting for this game?"
- Options: `PC (Steam / Epic)` / `Mobile (iOS / Android)` / `Console` / `Web / Browser` / `Multiple platforms`
- Record the answer — it drives export presets, performance budgets, and input defaults.

**Question 2 — Rendering scope**:
- Prompt: "What rendering scope fits this project best?"
- Options: `2D` / `Stylized 3D` / `Mixed 2D and 3D` / `Not sure yet`
- Use this to frame shader complexity, scene composition, and asset pipeline defaults.

**Question 3 — Language preference**:
- Prompt: "Which Godot language setup do you want to optimize for?"
- Options: `GDScript` / `C#` / `Both` / `Need guidance`
- If they need guidance, resolve it in Section 4 before editing any files.

**Question 4 — Version strategy**:
- Prompt: "Should I pin the latest stable Godot, or a specific version you already use?"
- Options: `Latest stable` / `I already have a version in mind` / `Need advice from the concept`
- If they already have a version, record it. If they need advice, recommend the latest stable unless a dependency or platform constraint says otherwise.

### Produce a Godot setup recommendation

Do NOT turn this into a multi-engine comparison. The goal is to pin a Godot setup that fits the project's constraints.

Present:
- The recommended Godot version strategy (latest stable vs explicitly pinned version)
- The recommended language choice with tradeoffs for this project
- The main platform constraints to keep in mind (mobile/web/console/performance)
- A short note that this is a starting configuration, not an irreversible choice

Use `vscode_askQuestions` to confirm:
- `[Recommended setup]`
- `Adjust the version`
- `Adjust the language`
- `Adjust both`
- `Type something`

If the user wants to go deeper, answer concept-specific questions about Godot constraints: scene streaming, input stack, rendering pipeline, memory budgets, platform exports, or language boundaries.

---

## 3. Look Up Current Version

Once the engine is chosen:

- If version was provided, use it
- If no version provided, use the official engine release page or release notes to find the latest stable release.
  - Confirm with the user: "The latest stable [engine] is [version]. Use this?"

---

## 4. Update the Workspace Engine Record

### Language Selection (Godot only)

If Godot was chosen, ask the user which language to use **before** showing the proposed Technology Stack:

> "Godot supports two primary languages:
>
>   **A) GDScript** — Python-like, Godot-native, fastest iteration. Best for beginners, solo devs, and teams coming from Python or Lua.
>   **B) C#** — .NET 8+, stronger IDE tooling, better fit for teams already standardized on C#, and a slight performance advantage on heavy logic.
>   **C) Both** — GDScript for gameplay/UI scripting, C# for performance-critical systems. Advanced setup — requires .NET SDK alongside Godot.
>
> Which will this project primarily use?"

Record the choice. It determines the workspace engine record, naming conventions, specialist routing, and which agent is spawned for code files throughout the project.

---

Read the current workspace contract files and show the user the proposed engine-record changes.
Ask: "May I write these engine settings to the chosen project-context file?"

Wait for confirmation before making any edits.

Update the Technology Stack section, replacing the `[CHOOSE]` placeholders with the actual values using the Godot template that matches the selected language. See **Appendix A** at the bottom of this skill for the GDScript, C#, and mixed-language variants.

---

## 5. Populate Project Technical Preferences

After updating the workspace's chosen engine record, capture the same preferences in a user-approved project-local preferences file. This workspace does not ship with a default technical-preferences path. Read any existing project-local template first, then fill in:

### Engine & Language Section
- Fill from the engine choice made in step 4

### Naming Conventions (engine defaults)

Use the matching Godot naming conventions from **Appendix A**:
- `A2` for GDScript projects
- `A2` C# variant for C# projects
- `A2` mixed-language guidance when both languages are in use

### Input & Platform Section

Populate `## Input & Platform` using the answers gathered in Section 2 (or extracted
from the game concept). Derive the values using this mapping:

| Platform target | Gamepad Support | Touch Support |
|-----------------|-----------------|---------------|
| PC only | Partial (recommended) | None |
| Console | Full | None |
| Mobile | None | Full |
| PC + Console | Full | None |
| PC + Mobile | Partial | Full |
| Web | Partial | Partial |

For **Primary Input**, use the dominant input for the game genre:
- Action/RPG/platformer targeting console → Gamepad
- Strategy/point-and-click/RTS → Keyboard/Mouse
- Mobile game → Touch
- Cross-platform → ask the user

Present the derived values and ask the user to confirm or adjust before writing.

Example filled section:
```markdown
## Input & Platform
- **Target Platforms**: PC, Console
- **Input Methods**: Keyboard/Mouse, Gamepad
- **Primary Input**: Gamepad
- **Gamepad Support**: Full
- **Touch Support**: None
- **Platform Notes**: All UI must support d-pad navigation. No hover-only interactions.
```

### Remaining Sections
- **Performance Budgets**: Use `vscode_askQuestions`:
  - Prompt: "Should I set default performance budgets now, or leave them for later?"
  - Options: `[A] Set defaults now (60fps, 16.6ms frame budget, engine-appropriate draw call limit)` / `[B] Leave as [TO BE CONFIGURED] — I'll set these when I know my target hardware`
  - If [A]: populate with the suggested defaults. If [B]: leave as placeholder.
- **Testing**: Suggest a Godot-appropriate framework (GdUnit4 or GUT) — ask before adding.
- **Forbidden Patterns**: Leave as placeholder — do NOT pre-populate.
- **Allowed Libraries**: Leave as placeholder — do NOT pre-populate dependencies the project does not currently need. Only add a library here when it is actively being integrated, not speculatively.

> **Guardrail**: Never add speculative dependencies to Allowed Libraries. For example, do NOT add GodotSteam unless Steam integration is actively beginning in this session. Post-launch integrations should be added to Allowed Libraries when that work begins, not during engine setup.

### Engine Specialists Routing

Also populate the `## Engine Specialists` section in that project-local preferences file using the Godot routing table from **Appendix A**. Pick the GDScript, C#, or mixed-language variant that matches the language choice from Section 4.

### Collaborative Step
Present the filled-in preferences to the user. For Godot, include the chosen language and note where the full naming conventions and routing tables live:
> "Here are the default technical preferences for [engine] ([language if Godot]). The naming conventions and specialist routing are in Appendix A of this skill — I'll apply the [GDScript/C#/Both] variant. Want to customize any of these, or shall I save the defaults?"

For all other engines, present the defaults directly without referencing the appendix.

Wait for approval before writing the file.

---

## 6. Determine Knowledge Gap

Check whether the engine version is likely beyond the LLM's training data.

**Known approximate coverage** (update this as models change):
- LLM knowledge cutoff: **May 2025**
- Godot: training data likely covers up to ~4.3

Compare the user's chosen version against these baselines:

- **Within training data** → `LOW RISK` — reference docs optional but recommended
- **Near the edge** → `MEDIUM RISK` — reference docs recommended
- **Beyond training data** → `HIGH RISK` — reference docs required

Inform the user which category they're in and why.

---

## 7. Populate Engine Reference Docs

### If WITHIN training data (LOW RISK):

Create or refresh `.github/context/VERSION.md`:

```markdown
# [Engine] — Version Reference

| Field | Value |
|-------|-------|
| **Engine Version** | [version] |
| **Project Pinned** | [today's date] |
| **LLM Knowledge Cutoff** | May 2025 |
| **Risk Level** | LOW — version is within LLM training data |

## Note

This engine version is within the LLM's training data. Engine reference
docs are optional but can be added later if agents suggest incorrect APIs.

Run `/setup-engine refresh` to populate the full `.github/context/` reference set at any time.
```

Do NOT create breaking-changes.md, deprecated-apis.md, etc. — they would
add context cost with minimal value.

### If BEYOND training data (MEDIUM or HIGH RISK):

Create the full reference doc set by searching the web:

1. **Search for the official migration/upgrade guide**:
   - `"[engine] [old version] to [new version] migration guide"`
   - `"[engine] [version] breaking changes"`
   - `"[engine] [version] changelog"`
   - `"[engine] [version] deprecated API"`

2. **Fetch and extract** from official documentation:
   - Breaking changes between each version from the training cutoff to current
   - Deprecated APIs with replacements
   - New features and best practices

Ask: "May I create or refresh the engine reference docs under `.github/context/`?"

Wait for confirmation before writing any files.

3. **Create or refresh the full reference directory**:
   ```
   .github/context/
   ├── VERSION.md                 # Version pin + knowledge gap analysis
   ├── breaking-changes.md        # Version-by-version breaking changes
   ├── deprecated-apis.md         # "Don't use X → Use Y" tables
   ├── current-best-practices.md  # New practices since training cutoff
   └── modules/                   # Per-subsystem references (create as needed)
   ```

4. **Populate each file** using real data from the web searches, following
   the format established in existing reference docs. Every file must have
   a "Last verified: [date]" header.

5. **For module files**: Only create modules for subsystems where significant
   changes occurred. Don't create empty or minimal module files.

---

## 8. Update the Curated Reference Layer

Ask: "May I update any active engine-reference imports to point at `.github/context/VERSION.md`?"

Wait for confirmation, then update the `@` import under "Engine Version Reference" to point to the
curated reference layer if such an import exists:

```markdown
## Engine Version Reference

@.github/context/VERSION.md
```

If the workspace already treats `.github/context/VERSION.md` as canonical, skip this step and report that no import change was needed.

---

## 9. Update Agent Instructions

Ask: "May I add a Version Awareness section to the engine specialist agent files?" before making any edits.

For the chosen engine's specialist agents, verify they have a
"Version Awareness" section. If not, add one following the pattern in
the existing Godot specialist agents.

The section should instruct the agent to:
1. Read `.github/context/VERSION.md`
2. Check deprecated APIs before suggesting code
3. Check breaking changes for relevant version transitions
4. Use official docs or Context7 to verify uncertain APIs

---

## 10. Refresh Subcommand

If invoked as `/setup-engine refresh`:

1. Read the existing `.github/context/VERSION.md` to get
   the current engine and version
2. Use official release notes, migration docs, or Context7 to check for:
   - New engine releases since last verification
   - Updated migration guides
   - Newly deprecated APIs
3. Update all reference docs with new findings
4. Update "Last verified" dates on all modified files
5. Report what changed

---

## 11. Upgrade Subcommand

If invoked as `/setup-engine upgrade [old-version] [new-version]`:

### Step 1 — Read Current Version State

Read `.github/context/VERSION.md` to confirm the current pinned
version, risk level, and any migration note URLs already recorded. If
`old-version` was not provided as an argument, use the pinned version from this
file.

### Step 2 — Fetch Migration Guide

Use the official migration guide, release notes, and breaking-change docs between
`old-version` and `new-version`:

- Prefer the migration guide URL already recorded in VERSION.md when present.
- Otherwise locate the guide from the engine's official docs or release pages.
- Cross-check breaking changes and changelog notes before drafting the upgrade plan.

Extract: renamed APIs, removed APIs, changed defaults, behavior changes, and
any "must migrate" items.

### Step 3 — Pre-Upgrade Audit

Scan `src/` for code that uses APIs known to be deprecated or changed in the
target version:

- Use Grep to search for deprecated API names extracted from the migration
  guide (e.g., old function names, removed node types, changed property names)
- List each file that matches, with the specific API reference found

Present the audit results as a table:

```
Pre-Upgrade Audit: [engine] [old-version] → [new-version]
==========================================================

Files requiring changes:
  File                              | Deprecated API Found       | Effort
  --------------------------------- | -------------------------- | ------
  src/gameplay/player_movement.gd   | old_api_name               | Low
  src/ui/hud.gd                     | removed_node_type          | Medium

Breaking changes to watch for:
  - [change description from migration guide]
  - [change description from migration guide]

Recommended migration order (dependency-sorted):
  1. [system/layer with fewest dependencies first]
  2. [next system]
  ...
```

If no deprecated APIs are found in `src/`, report: "No deprecated API usage
found in src/ — upgrade may be low-risk."

### Step 4 — Confirm Before Updating

Ask the user before making any changes:

> "Pre-upgrade audit complete. Found [N] files using deprecated APIs.
> Proceed with upgrading VERSION.md to [new-version]?
> (This will update the pinned version and add migration notes — it does NOT
> change any source files. Source migration is done manually or via stories.)"

Wait for explicit confirmation before continuing.

### Step 5 — Update VERSION.md

After confirmation:

1. Update `.github/context/VERSION.md`:
   - `Engine Version` → `[new-version]`
   - `Project Pinned` → today's date
   - `Last Docs Verified` → today's date
   - Re-evaluate and update the `Risk Level` and `Post-Cutoff Version Timeline`
     table if the new version falls beyond the LLM knowledge cutoff
   - Add a `## Migration Notes — [old-version] → [new-version]` section
     containing: migration guide URL, key breaking changes, deprecated APIs
     found in this project, and recommended migration order from the audit

2. If `.github/context/breaking-changes.md` or `.github/context/deprecated-apis.md`
   exist, append the new version's changes to those files.

### Step 6 — Post-Upgrade Reminder

After updating VERSION.md, output:

```
VERSION.md updated: [engine] [old-version] → [new-version]

Next steps:
1. Migrate deprecated API usages in the [N] files listed above
2. Run /setup-engine refresh after upgrading the actual engine binary to
   verify no new deprecations were missed
3. Run /architecture-review — the engine upgrade may invalidate ADRs that
   reference specific APIs or engine capabilities
4. If any ADRs are invalidated, run /propagate-design-change to update
   downstream stories
```

---

## 12. Output Summary

After setup is complete, output:

```
Engine Setup Complete
=====================
Engine:          [name] [version]
Language:        [GDScript | C# | GDScript + C#]
Knowledge Risk:  [LOW/MEDIUM/HIGH]
Reference Docs:  [created/skipped]
Project context:  [updated]
Tech Prefs:      [created/updated]
Agent Config:    [verified]

Next Steps:
1. Review .github/context/VERSION.md
2. [If from /brainstorm] Run /map-systems to decompose your concept into individual systems
3. [If from /brainstorm] Run /design-system to author per-system GDDs (guided, section-by-section)
4. [If from /brainstorm] Run /prototype [core-mechanic] to test the core loop
5. [If fresh start] Run /brainstorm to discover your game concept
6. Create your first milestone: /sprint-plan new
```

---

Verdict: **COMPLETE** — engine configured and curated reference docs populated.

## Guardrails

- NEVER guess an engine version — always verify via official docs/release pages or user confirmation
- NEVER overwrite existing reference docs without asking — append or update
- If reference docs already exist for a different engine, ask before replacing
- Always show the user what you're about to change before making project-context edits
- If the official sources are ambiguous, show the evidence to the user and let them decide
- When the user chose **GDScript**: copy the GDScript workspace engine-record template from Appendix A1 exactly. NEVER add "C++ via GDExtension" to the Language field. GDScript projects may use GDExtension, but it is not a primary project language. If native extensions become necessary later, route that decision through `technical-director` — it still does not make C++ a primary project language.

---

## Appendix A — Godot Language Configuration

All Godot-specific variants for language-dependent configuration. Referenced from Sections 4 and 5 — only relevant when Godot is the chosen engine. Use the subsection matching the language chosen in Section 4.

---

### A1. Workspace Engine Record Templates

**GDScript:**
```markdown
- **Engine**: Godot [version]
- **Language**: GDScript
- **Build System**: SCons (engine), Godot Export Templates
- **Asset Pipeline**: Godot Import System + custom resource pipeline
```

> **Guardrail**: When using this GDScript template, write the Language field as exactly "`GDScript`" — no additions. Do NOT append "C++ via GDExtension" or any other language. The C# template below includes GDExtension because C# projects commonly wrap native code; GDScript projects do not.

**C#:**
```markdown
- **Engine**: Godot [version]
- **Language**: C# (.NET 8+, primary), C++ via GDExtension (native plugins only)
- **Build System**: .NET SDK + Godot Export Templates
- **Asset Pipeline**: Godot Import System + custom resource pipeline
```

**Both — GDScript + C#:**
```markdown
- **Engine**: Godot [version]
- **Language**: GDScript (gameplay/UI scripting), C# (performance-critical systems), C++ via GDExtension (native only)
- **Build System**: .NET SDK + Godot Export Templates
- **Asset Pipeline**: Godot Import System + custom resource pipeline
```

---

### A2. Naming Conventions

**GDScript:**
- Classes: PascalCase (e.g., `PlayerController`)
- Variables/functions: snake_case (e.g., `move_speed`)
- Signals: snake_case past tense (e.g., `health_changed`)
- Files: snake_case matching class (e.g., `player_controller.gd`)
- Scenes: PascalCase matching root node (e.g., `PlayerController.tscn`)
- Constants: UPPER_SNAKE_CASE (e.g., `MAX_HEALTH`)

**C#:**
- Classes: PascalCase (`PlayerController`) — must also be `partial`
- Public properties/fields: PascalCase (`MoveSpeed`, `JumpVelocity`)
- Private fields: `_camelCase` (`_currentHealth`, `_isGrounded`)
- Methods: PascalCase (`TakeDamage()`, `GetCurrentHealth()`)
- Signal delegates: PascalCase + `EventHandler` suffix (`HealthChangedEventHandler`)
- Files: PascalCase matching class (`PlayerController.cs`)
- Scenes: PascalCase matching root node (`PlayerController.tscn`)
- Constants: PascalCase (`MaxHealth`, `DefaultMoveSpeed`)

**Both — GDScript + C#:**
Use GDScript conventions for `.gd` files and C# conventions for `.cs` files. Mixed-language files do not exist — the boundary is per-file. When in doubt about which language a new system should use, ask the user and record the decision in that project-local preferences file.

---

### A3. Engine Specialists Routing

**GDScript:**
```markdown
## Engine Specialists
- **Primary**: godot-specialist
- **Language/Code Specialist**: godot-gdscript-specialist (all .gd files)
- **Shader Specialist**: godot-shader-specialist (.gdshader files, VisualShader resources)
- **UI Specialist**: godot-specialist (no dedicated UI specialist — primary covers all UI)
- **Additional Specialists**: none in the active graph
- **Routing Notes**: Invoke primary for architecture decisions, ADR validation, and cross-cutting code review. Invoke GDScript specialist for code quality, signal architecture, static typing enforcement, and GDScript idioms. Invoke shader specialist for material design and shader code. If native extensions become necessary, escalate through technical-director before widening the active graph.

### File Extension Routing

| File Extension / Type | Specialist to Spawn |
|-----------------------|---------------------|
| Game code (.gd files) | godot-gdscript-specialist |
| Shader / material files (.gdshader, VisualShader) | godot-shader-specialist |
| UI / screen files (Control nodes, CanvasLayer) | godot-specialist |
| Scene / resource / level files (.tscn, .tres) | godot-specialist |
| Native extension / plugin files (.gdextension, C++) | technical-director |
| General architecture review | godot-specialist |
```

**C#:**
```markdown
## Engine Specialists
- **Primary**: godot-specialist
- **Language/Code Specialist**: technical-director (C# specialist is currently parked outside the active graph)
- **Shader Specialist**: godot-shader-specialist (.gdshader files, VisualShader resources)
- **UI Specialist**: godot-specialist (no dedicated UI specialist — primary covers all UI)
- **Additional Specialists**: none in the active graph
- **Routing Notes**: Invoke primary for architecture decisions, ADR validation, and cross-cutting code review. Route all C# and `.csproj` work through technical-director until the parked C# specialist is explicitly re-enabled. Invoke shader specialist for material design and shader code. Route native C++ plugin work through technical-director as well.

### File Extension Routing

| File Extension / Type | Specialist to Spawn |
|-----------------------|---------------------|
| Game code (.cs files) | technical-director |
| Shader / material files (.gdshader, VisualShader) | godot-shader-specialist |
| UI / screen files (Control nodes, CanvasLayer) | godot-specialist |
| Scene / resource / level files (.tscn, .tres) | godot-specialist |
| Project config (.csproj, NuGet) | technical-director |
| Native extension / plugin files (.gdextension, C++) | technical-director |
| General architecture review | godot-specialist |
```

**Both — GDScript + C#:**
```markdown
## Engine Specialists
- **Primary**: godot-specialist
- **GDScript Specialist**: godot-gdscript-specialist (.gd files — gameplay/UI scripts)
- **C# Specialist**: technical-director (.cs files — active fallback while the dedicated C# specialist is parked)
- **Shader Specialist**: godot-shader-specialist (.gdshader files, VisualShader resources)
- **UI Specialist**: godot-specialist (no dedicated UI specialist — primary covers all UI)
- **Additional Specialists**: none in the active graph
- **Routing Notes**: Invoke primary for cross-language architecture decisions and which systems belong in which language. Invoke GDScript specialist for .gd files. Route `.cs` files, `.csproj` management, and native-extension decisions through technical-director until the parked specialists are explicitly re-enabled. Prefer signals over direct cross-language method calls at the boundary.

### File Extension Routing

| File Extension / Type | Specialist to Spawn |
|-----------------------|---------------------|
| Game code (.gd files) | godot-gdscript-specialist |
| Game code (.cs files) | technical-director |
| Cross-language boundary decisions | godot-specialist |
| Shader / material files (.gdshader, VisualShader) | godot-shader-specialist |
| UI / screen files (Control nodes, CanvasLayer) | godot-specialist |
| Scene / resource / level files (.tscn, .tres) | godot-specialist |
| Project config (.csproj, NuGet) | technical-director |
| Native extension / plugin files (.gdextension, C++) | technical-director |
| General architecture review | godot-specialist |
```
