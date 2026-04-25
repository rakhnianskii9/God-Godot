# ⚡ GOD-GODOT

> **"Manual code sux. Orchestration is divine."**

![Status](https://img.shields.io/badge/Status-GOD_MODE-black?style=for-the-badge&logo=godotengine)
![GDScript](https://img.shields.io/badge/GDScript-90.3%25-green?style=for-the-badge)
![C#](https://img.shields.io/badge/C%23-3.7%25-purple?style=for-the-badge&logo=csharp)
![Architecture](https://img.shields.io/badge/Architecture-E2E_Orchestration-success?style=for-the-badge)
![Agents](https://img.shields.io/badge/AI_Agents-30%2B-blueviolet?style=for-the-badge)
![Engine](https://img.shields.io/badge/Godot-4.x-478CBF?style=for-the-badge&logo=godotengine)

---

## 🔥 What this actually is

**GOD-GODOT** isn't just a monorepo. It's a **fully automated end-to-end gamedev pipeline for Godot 4.x**, where you **stop writing code by hand** and start **directing a staff of 30+ AI agents** — each one owning its domain better than the average junior you'd hire.

You drop in an idea — the orchestrator routes it across departments (design / tech / production / art / ux / qa). Every agent does its job through **its own tool contract** (MCP, LSP, terminal, Godot scene API, GitHub Actions, browser automation). The output: **a working feature shipped through CI/CD with no manual coding**.

This is **not an "AI assistant"**. It's **a full game studio in a single repository**, where you're the creative director and the agents are your team.

---

## 💎 The value, in one screen

| What you usually do by hand | What GOD-GODOT does for you |
| :--- | :--- |
| Hand-write GDScript and chase bugs | `game-orchestrator` routes the task → `godot-specialist` implements, `qa-lead` tests |
| Wade through 15 vendor addons | `godot-lib-pazzle` is already wired in; agents know which plugin fits which job |
| Burn days on CI/CD | Pipeline is set up; agents edit `.github/workflows` themselves |
| Argue with yourself about architecture | `technical-director` issues the ruling, `godot-specialist` confirms at engine level |
| Forget about accessibility, UX, audio | `ux-designer`, `accessibility-specialist`, `audio-director` join in automatically |
| Bounce between Scene Tree, code, Git, browser | One prompt → agents pull the right tools themselves |

**Bottom line:** you push the game forward **at the speed of thought**, not at the speed of your keyboard.

---

## 🏛 Architecture: end-to-end orchestration, top to bottom

```
┌──────────────────────────────────────────────────────────────────────┐
│                         YOU (creative input)                         │
└──────────────────────────────┬───────────────────────────────────────┘
                               ▼
                  ┌────────────────────────────┐
                  │     game-orchestrator      │  ◄── classifies
                  │   (default entry point)    │      and routes
                  └──┬──────────┬──────────┬───┘
                     ▼          ▼          ▼
            ┌──────────────┐ ┌────────┐ ┌──────────────────┐
            │  creative    │ │ producer│ │   technical      │
            │  director    │ │         │ │   director       │
            └──────┬───────┘ └────┬────┘ └────────┬─────────┘
                   ▼              ▼               ▼
       game-designer        scope/release   godot-specialist
       art-director         qa-lead         gameplay-programmer
       narrative-director   prototyper      ai-programmer
       audio-director                       performance-analyst
       ux-designer                          security-engineer
                                            tools-programmer
                                            devops-engineer
                                            technical-artist
                               │
                               ▼
        ┌───────────────────────────────────────────────────┐
        │  TOOL LAYER: MCP servers · LSP · Terminal · Git   │
        │  Godot scene/script API · Browser automation      │
        │  GitHub Actions · Notebook · Memory · Diagrams    │
        └───────────────────────┬───────────────────────────┘
                                ▼
                ┌────────────────────────────────┐
                │   godot-lib-pazzle  (Core)     │
                │   my-game           (App)      │
                │   .github/workflows (CI/CD)    │
                └────────────────────────────────┘
```

**Layers are isolated. Contracts are strict. Communication goes through the Event Bus and Godot signals. Zero presentation leakage into the core.**

---

## 📂 Monorepo layout

| Workspace | Role | Who works there |
| :--- | :--- | :--- |
| **`godot-lib-pazzle/`** | Core mechanics library. A vendor set of 20+ battle-tested addons (statecharts, beehave, gloot, pandora, phantom-camera, dialogue-manager, gut, etc.) | `technical-director`, `godot-specialist`, `game-designer` |
| **`my-game/`** | App client. Scenes, scripts, UI, audio, monetization. | `gameplay-programmer`, `ux-designer`, `art-director` |
| **`.github/agents/`** | AI agent manifests: roles, tool contracts, scope. | `game-orchestrator` |
| **`.github/skills/`** | Reusable skill packs for agents. | every agent |
| **`.github/instructions/`** | Source of truth for coding rules, validation policy, project constraints. | every agent |
| **`.github/context/`** | Curated reference: Godot best practices, breaking changes, deprecated APIs. | Godot specialists |
| **`.vscode/`** | MCP servers, settings, tasks, launch configs for debugging GDScript and C# side by side. | runtime |

---

## ⚙️ Tech stack

| Tech | Role in the architecture |
| :--- | :--- |
| **GDScript (90.3%)** | Main API, UI logic, state machines, scene graph orchestration. |
| **HTML / CSS (5%)** | Custom templates for Web exports (HTML5/WebGL). |
| **C# (3.7%)** | Graph algorithms and heavy validation inside `godot-lib-pazzle`. |
| **Kotlin (0.3%)** | Godot Android Plugins for native SDK integration. |
| **Python (0.2%)** | CI/CD automation (preprocessing, version bumps). |

---

## 🤖 The AI agent crew

The full role map, tool contracts, and MCP layout live in **[`agents-faq.md`](./agents-faq.md)**.

### Top lane (user-facing — start here):

| Role | When to call | What it does |
| :--- | :--- | :--- |
| **`game-orchestrator`** | Not sure — go here | Classifies the request and routes it across departments |
| **`creative-director`** | Idea, tone, vision | Locks in fantasy / pillars / tone |
| **`game-designer`** | Mechanics, loop, balance | Core loop, progression, economy |
| **`technical-director`** | Architecture, code review | Tech ruling, picks the implementer |
| **`godot-specialist`** | Engine-specific questions | Scene Tree, autoload, signals, resources |
| **`producer`** | Scope, sprint, release | Sequencing, milestones, release gate |
| **`ux-designer`** | UI, HUD, controls, onboarding | Player-facing flow and accessibility |
| **`art-director`** | Visual style, asset rules | Art bible, look & feel |

Underneath sit **20+ narrow specialists**: `gameplay-programmer`, `ai-programmer`, `systems-designer`, `level-designer`, `narrative-director`, `audio-director`, `qa-lead`, `security-engineer`, `performance-analyst`, `tools-programmer`, `devops-engineer`, `technical-artist`, `accessibility-specialist`, `prototyper`, plus feature specialists (`godot-csharp-specialist`, `godot-shader-specialist`, `godot-gdextension-specialist`, `network-programmer`, `localization-lead`, `analytics-engineer`, `live-ops-designer`).

---

## 🔌 Tool & MCP layer

Agents don't operate "by text" — they operate through **real tools**:

- **6 project-local MCP servers** (`.vscode/mcp.json`): `crash`, `context7`, `octocode`, `godot-coding-solo`, `godot-tomyud1`, `rpg-game-server`
- **Built-in GitHub MCP** with 12 toolsets: repos, issues, code_search, pull_requests, actions, code_security, secret_protection, security_advisories, copilot, copilot_spaces, github_support_docs_search
- **Godot MCP**: scene management, script editing, resource inspection, project analysis, input mapping, collision/mesh tooling — **agents edit the Godot project directly**, no window switching
- **LSP** for semantic symbol navigation
- **Browser automation** (Playwright) for UI validation
- **Terminal + tasks** for builds, tests, exports
- **Memory layer** (user / session / repo scope) — agents remember context across sessions

Full inventory in **[`agents-faq.md`](./agents-faq.md)**.

---

## 🚀 CI/CD pipeline

Push to `main` → GitHub Actions automatically:

1. **Static analysis & linting** — Python scripts + static analysis for GDScript/C#
2. **Core compilation** — build `godot-lib-pazzle`
3. **E2E export** — export `my-game` for Web and Android
4. **Automated deploy** — publish artifacts to GitHub Releases

Any agent can edit the pipeline through `devops-engineer` — without leaving the chat.

---

## 🛠 Getting started

```bash
git clone https://github.com/rakhnianskii9/gamedev.git
cd gamedev
code .
```

Then:

1. Open VS Code — MCP servers and agents are picked up from `.vscode/mcp.json` and `.github/agents/`.
2. Open the Copilot chat.
3. Type: **"@game-orchestrator I want to build a roguelike with deck-building"**.
4. Watch a 30+ agent crew turn it into a design doc, architecture, scope, and the first commits.

---

## 📚 Docs

- **[`agents-faq.md`](./agents-faq.md)** — full agent map, tool contracts, MCP layer, routing rules
- **[`hints.md`](./hints.md)** — development standards and code conventions
- **[`godot-lib-pazzle/README.md`](./godot-lib-pazzle/README.md)** — mechanics and addon vendor set
- **[`.github/instructions/`](./.github/instructions/)** — source of truth for every agent
- **[`.github/context/`](./.github/context/)** — Godot reference, best practices, breaking changes

---

## 🧠 Philosophy

> **Manual code sux. Orchestration is divine.** 
>
> You shouldn't have to remember 47 Godot patterns, 20 vendor addons, 12 MCP servers, and 6 CI stages.
> You should remember **what game you want to make**.
>
> GOD-GODOT handles the rest.

---




