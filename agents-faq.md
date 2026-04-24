# FAQ: с кем работать и кого когда звать

Этот файл описывает не "всех агентов подряд", а реальный рабочий контур под solo Godot workflow в этом репо.

## Короткий ответ

Если совсем коротко:

- По умолчанию начинай с `game-orchestrator`.
- Для дизайна чаще всего нужен `game-designer`.
- Для техники чаще всего нужны `technical-director` и `godot-specialist`.
- Для планирования, приоритетов и "что делать дальше" нужен `producer`.
- Для UI, HUD и player flow нужен `ux-designer`.
- Для визуального направления нужен `art-director`.

Практически это значит так:

- Самый безопасный вход: `game-orchestrator`
- Самая частая пара после появления идеи: `game-designer` + `technical-director`
- Самый частый engine-level агент во время реальной разработки: `godot-specialist`
- Самый частый агент для порядка и фокуса: `producer`

## Основная таблица

| Ситуация | Кого звать первым | Когда это делать | Что он решает | Кого он обычно подтянет внутри |
|---|---|---|---|---|
| Вообще не понимаю, с чего начать | `game-orchestrator` | Самый старт, размытая задача, смешанный запрос | Классифицирует задачу и отправляет в нужную ветку | `creative-director`, `technical-director`, `producer` |
| Есть только идея игры, хочу понять направление | `creative-director` | Нулевой этап, формирование fantasy, tone, pillars | Собирает верхнеуровневое творческое направление | `game-designer`, `art-director`, `narrative-director`, `audio-director`, `ux-designer` |
| Нужно придумать core loop, прогрессию, бой, экономику, правила | `game-designer` | После общей идеи, до кода | Формирует механику и player-facing правила | `systems-designer`, `level-designer`, `ux-designer` |
| Нужно понять, как это технически строить | `technical-director` | До серьезной реализации и при любой технеопределенности | Архитектура, границы систем, tech risk, code review | `godot-specialist`, `gameplay-programmer`, `ai-programmer`, `tools-programmer`, `devops-engineer`, `performance-analyst`, `qa-lead`, `security-engineer`, `technical-artist` |
| Нужен именно Godot-side разбор: scene tree, autoload, node pattern, resource flow | `godot-specialist` | Когда вопрос уже engine-specific | Godot-архитектура, API, scene/node patterns | `godot-gdscript-specialist`, `godot-shader-specialist` |
| Нужно продумать UI, HUD, меню, onboarding, controls | `ux-designer` | До UI-реализации и во время нее | UX flow, interaction patterns, accessibility application, UI implementation | `accessibility-specialist` |
| Нужен визуальный стиль, asset direction, art bible, UI look | `art-director` | Когда понятна игровая идея и нужен визуальный язык | Визуальная идентичность и художественные правила | `technical-artist`, `ux-designer` |
| Нужно разложить работу по этапам, приоритетам, scope, sprint, next steps | `producer` | Сразу после концепта и дальше постоянно | Планирование, sequencing, scope, release coordination | `qa-lead`, `prototyper` |
| Нужен быстрый throwaway prototype, чтобы проверить гипотезу | `producer` | Когда надо проверить идею без production-качества | Организует validation spike и время, и рамки | `prototyper` |
| Дизайн уже есть, пора реально кодить feature | `technical-director` | Перед hands-on implementation | Выбирает технического исполнителя и ограничивает scope реализации | `gameplay-programmer`, `godot-specialist`, `ai-programmer`, другие техлистья по задаче |
| Нужен код-ревью, архитектурный стоп-сигнал или решение технического конфликта | `technical-director` | Любой спорный или рискованный момент | Дает техническое ruling | `godot-specialist`, `qa-lead`, `performance-analyst`, `security-engineer` |
| Нужен релизный контроль, QA gate, порядок перед ship | `producer` | До QA handoff и релиза | Собирает quality/release поток | `qa-lead`, при необходимости `technical-director` |

## Общая схема

Это намеренно упрощенная схема только для user-facing поверхности, без внутренних листьев.

```text
┌──────────────────────────────────────────────────────────────────────────────────────────────┐
│                            ОБЩАЯ СХЕМА РАБОТЫ С АГЕНТАМИ                                    │
├──────────────────────────────────────────────────────────────────────────────────────────────┤
│                                                                                              │
│                               ┌──────────────────────┐                                       │
│                               │   ТЫ / НОВАЯ ЗАДАЧА  │                                       │
│                               └──────────┬───────────┘                                       │
│                                          │                                                   │
│                                          ▼                                                   │
│                           ┌────────────────────────────────┐                                 │
│                           │       game-orchestrator        │                                 │
│                           │      default entry point       │                                 │
│                           └──────────┬─────────┬───────────┘                                 │
│                                      │         │                                             │
│                         ┌────────────┘         └────────────┐                                │
│                         ▼                                   ▼                                │
│            ┌────────────────────────┐          ┌────────────────────────┐                    │
│            │   creative-director    │          │   technical-director   │                    │
│            └──────────┬─────────────┘          └──────────┬─────────────┘                    │
│                       │                                   │                                  │
│                       ▼                                   ▼                                  │
│      ┌─────────────────────────────┐       ┌─────────────────────────────┐                   │
│      │ game-designer               │       │ godot-specialist            │                   │
│      │ art-director                │       │ gameplay / ai / tools / ... │                   │
│      │ ux-designer                 │       │ perf / qa / sec / tech-art  │                   │
│      └─────────────────────────────┘       └─────────────────────────────┘                   │
│                                                                                              │
│                               ┌────────────────────────┐                                      │
│                               │        producer        │                                      │
│                               │ plan / scope / release │                                      │
│                               └────────────────────────┘                                      │
│                                                                                              │
│  Прямые user-facing shortcuts, если lane уже ясен:                                           │
│  creative-director, technical-director, producer, game-designer, art-director,              │
│  ux-designer, godot-specialist                                                               │
└──────────────────────────────────────────────────────────────────────────────────────────────┘
```

## Как реально работать с нуля

Если ты начинаешь игру с пустого листа, нормальный рабочий порядок обычно такой:

1. `game-orchestrator` — если запрос еще смешанный и ты не уверен, куда идти.
2. `creative-director` — зафиксировать fantasy, tone, high-level frame.
3. `game-designer` — собрать core loop, правила, системы, progression.
4. `producer` — разложить это в реалистичный порядок и scope.
5. `technical-director` — превратить дизайн в архитектуру и implementation plan.
6. `godot-specialist` — принять конкретные Godot-решения по сценам, узлам, ресурсам, API.
7. `ux-designer` — когда появляются экраны, HUD, flows, controls.
8. `art-director` — когда нужен визуальный язык, asset direction и consistency.

Если задача уже узкая, можно не идти каждый раз через `game-orchestrator`.
Но если запрос смешанный, это все еще лучший вход.

## Что входит в каждого верхнеуровнего

Ниже уже не общая схема, а внутренняя декомпозиция: кто внутри кого живет и за что обычно отвечает.

### 1. `game-orchestrator`

```text
┌──────────────────────────────────────────────────────────────┐
│                    game-orchestrator                         │
├──────────────────────────────────────────────────────────────┤
│ Роль: верхний роутер                                        │
│                                                              │
│  ┌──────────────────────┐                                    │
│  │ creative-director    │                                    │
│  └──────────────────────┘                                    │
│  ┌──────────────────────┐                                    │
│  │ technical-director   │                                    │
│  └──────────────────────┘                                    │
│  ┌──────────────────────┐                                    │
│  │ producer             │                                    │
│  └──────────────────────┘                                    │
└──────────────────────────────────────────────────────────────┘
```

Что делает:

- Не решает доменную задачу сам.
- Разводит запрос по трем главным дорожкам: creative, technical, production.
- Это главный safe entry point, если запрос неоднородный.

### 2. `creative-director`

```text
┌──────────────────────────────────────────────────────────────────────────────┐
│                           creative-director                                  │
├──────────────────────────────────────────────────────────────────────────────┤
│  ┌──────────────────────────────┐   ┌──────────────────────────────────────┐ │
│  │ game-designer                │   │ art-director                         │ │
│  │ ├─ systems-designer          │   │ ├─ technical-artist                 │ │
│  │ ├─ level-designer            │   │ └─ ux-designer                      │ │
│  │ └─ ux-designer               │   │    └─ accessibility-specialist      │ │
│  │    └─ accessibility-specialist │  └──────────────────────────────────────┘ │
│  └──────────────────────────────┘                                             │
│                                                                                │
│  ┌──────────────────────────────┐   ┌──────────────────────────────────────┐   │
│  │ narrative-director           │   │ audio-director                       │   │
│  └──────────────────────────────┘   └──────────────────────────────────────┘   │
│                                                                                │
│  ┌──────────────────────────────────────────────────────────────────────────┐   │
│  │ ux-designer                                                             │   │
│  │ └─ accessibility-specialist                                             │   │
│  └──────────────────────────────────────────────────────────────────────────┘   │
└──────────────────────────────────────────────────────────────────────────────┘
```

Что входит в него:

- `game-designer` — игровые правила, systems thinking, player-facing logic.
- `art-director` — визуальная идентичность и style direction.
- `narrative-director` — мир, лор, персонажи, текст.
- `audio-director` — звуковое направление.
- `ux-designer` — игрокоцентричные flows и UI-side experience.

Когда звать:

- Когда вопрос влияет на идентичность игры, а не только на реализацию.
- Когда дизайн, визуал, narrative и UX начинают спорить между собой.

### 3. `technical-director`

```text
┌──────────────────────────────────────────────────────────────────────────────┐
│                           technical-director                                 │
├──────────────────────────────────────────────────────────────────────────────┤
│  ┌──────────────────────────────┐   ┌──────────────────────────────────────┐ │
│  │ godot-specialist             │   │ gameplay-programmer                  │ │
│  │ ├─ godot-gdscript-specialist │   └──────────────────────────────────────┘ │
│  │ └─ godot-shader-specialist   │   ┌──────────────────────────────────────┐ │
│  └──────────────────────────────┘   │ ai-programmer                        │ │
│                                     └──────────────────────────────────────┘ │
│  ┌──────────────────────────────┐   ┌──────────────────────────────────────┐ │
│  │ tools-programmer             │   │ devops-engineer                      │ │
│  └──────────────────────────────┘   └──────────────────────────────────────┘ │
│  ┌──────────────────────────────┐   ┌──────────────────────────────────────┐ │
│  │ performance-analyst          │   │ qa-lead                              │ │
│  └──────────────────────────────┘   └──────────────────────────────────────┘ │
│  ┌──────────────────────────────┐   ┌──────────────────────────────────────┐ │
│  │ security-engineer            │   │ technical-artist                     │ │
│  └──────────────────────────────┘   └──────────────────────────────────────┘ │
└──────────────────────────────────────────────────────────────────────────────┘
```

Что входит в него:

- `godot-specialist` — engine authority для Godot.
- `gameplay-programmer` — hands-on feature implementation.
- `ai-programmer` — поведение, state machines, pathfinding.
- `tools-programmer` — внутренние тулзы и authoring workflow.
- `devops-engineer` — build, CI/CD, export, deployment.
- `performance-analyst` — профилинг и bottlenecks.
- `qa-lead` — тестовая стратегия и quality gate.
- `security-engineer` — hardening, privacy, exploit review.
- `technical-artist` — мост между art и engine.

Когда звать:

- Когда вопрос уже не "что за игра", а "как это строить технически".
- Когда есть архитектурный риск, спор о реализации или need for code review.

### 4. `godot-specialist`

```text
┌──────────────────────────────────────────────────────────────┐
│                      godot-specialist                        │
├──────────────────────────────────────────────────────────────┤
│  ┌──────────────────────────────┐                            │
│  │ godot-gdscript-specialist    │                            │
│  └──────────────────────────────┘                            │
│  ┌──────────────────────────────┐                            │
│  │ godot-shader-specialist      │                            │
│  └──────────────────────────────┘                            │
└──────────────────────────────────────────────────────────────┘
```

Что входит в него:

- `godot-gdscript-specialist` — GDScript idioms, typing, signals, coroutines, clean GDScript architecture.
- `godot-shader-specialist` — shader, material, and rendering-specific work.

Когда звать:

- Когда спор идет именно про Godot patterns.
- Когда задача уже техническая, но еще слишком engine-specific для общего `technical-director` ruling.

### 5. `producer`

```text
┌──────────────────────────────────────────────────────────────┐
│                           producer                           │
├──────────────────────────────────────────────────────────────┤
│  ┌──────────────────────────────┐                            │
│  │ qa-lead                      │                            │
│  └──────────────────────────────┘                            │
│  ┌──────────────────────────────┐                            │
│  │ prototyper                   │                            │
│  └──────────────────────────────┘                            │
└──────────────────────────────────────────────────────────────┘
```

Что входит в него:

- `qa-lead` — test planning, regression thinking, release gates.
- `prototyper` — быстрые throwaway-проверки гипотез.

Когда звать:

- Когда надо понять очередность, scope, milestones, что делать дальше.
- Когда нужна быстрая проверка идеи без production hardening.

### 6. `game-designer`

```text
┌──────────────────────────────────────────────────────────────┐
│                        game-designer                         │
├──────────────────────────────────────────────────────────────┤
│  ┌──────────────────────────────┐                            │
│  │ systems-designer             │                            │
│  └──────────────────────────────┘                            │
│  ┌──────────────────────────────┐                            │
│  │ level-designer               │                            │
│  └──────────────────────────────┘                            │
│  ┌──────────────────────────────┐                            │
│  │ ux-designer                  │                            │
│  │ └─ accessibility-specialist  │                            │
│  └──────────────────────────────┘                            │
└──────────────────────────────────────────────────────────────┘
```

Что входит в него:

- `systems-designer` — формулы, progression curves, economy math, status interactions.
- `level-designer` — encounter layout, pacing, space.
- `ux-designer` — player-facing clarity там, где rules упираются в presentation.

Когда звать напрямую:

- Когда вопрос уже точно про механику, а не про vision целиком.
- Это один из самых частых ежедневных агентов после начального этапа.

### 7. `art-director`

```text
┌──────────────────────────────────────────────────────────────┐
│                         art-director                         │
├──────────────────────────────────────────────────────────────┤
│  ┌──────────────────────────────┐                            │
│  │ technical-artist             │                            │
│  └──────────────────────────────┘                            │
│  ┌──────────────────────────────┐                            │
│  │ ux-designer                  │                            │
│  │ └─ accessibility-specialist  │                            │
│  └──────────────────────────────┘                            │
└──────────────────────────────────────────────────────────────┘
```

Что входит в него:

- `technical-artist` — VFX, render, art-pipeline, and perf bridge.
- `ux-designer` — там, где визуальный стиль встречается с UI.

Когда звать напрямую:

- Когда вопрос уже не про механику и не про архитектуру, а про look and feel.

### 8. `ux-designer`

```text
┌──────────────────────────────────────────────────────────────┐
│                         ux-designer                          │
├──────────────────────────────────────────────────────────────┤
│  ┌──────────────────────────────┐                            │
│  │ accessibility-specialist     │                            │
│  └──────────────────────────────┘                            │
└──────────────────────────────────────────────────────────────┘
```

Что входит в него:

- `accessibility-specialist` — audits, standards, release-blocking accessibility findings.

Когда звать напрямую:

- Когда задача про HUD, screen flow, menus, input UX, onboarding, readability.

## Как интерпретировать эту структуру

Важно понимать несколько вещей:

1. Один и тот же агент может встречаться в нескольких ветках.
   Например, `ux-designer` виден и под `creative-director`, и под `game-designer`, и под `art-director`. Это не три разных агента, а один и тот же агент, доступный из разных управленческих контекстов.

2. Не все агенты должны вызываться вручную.
   Сейчас user-facing слой намеренно сжат. Это значит, что обычный ручной вход идет через:
   - `game-orchestrator`
   - `creative-director`
   - `technical-director`
   - `producer`
   - `game-designer`
   - `art-director`
   - `ux-designer`
   - `godot-specialist`

3. Листья нужны не для выбора из меню, а для точной внутренней делегации.
   То есть тебе обычно не нужно думать "мне нужен gameplay-programmer или performance-analyst". Ты формулируешь задачу на уровне `technical-director`, а он уже решает, кого включать дальше.

4. Для solo workflow это полезнее, чем плоский список из десятков ролей.
   Иначе тебе пришлось бы каждый раз вручную выбирать слишком узкую роль еще до того, как задача правильно классифицирована.

5. Некоторые листья принадлежат сразу нескольким верхним владельцам.
   Это нормально. Например:
   - `ux-designer` сидит и под `creative-director`, и под `game-designer`, и под `art-director`
   - `technical-artist` reachable и из арт-ветки, и из тех-ветки
   - `qa-lead` используется и продюсерской веткой, и тех-веткой

То есть правило такое:

- один и тот же leaf может быть reachable из разных managers
- это не значит, что его нужно звать вручную
- это значит, что разные верхние владельцы могут до него делегировать, когда вопрос входит в его узкую зону

## Какие агенты не входят в повседневный маршрут

Есть еще parked feature-агенты, но они сейчас не часть дефолтного everyday flow:

- `analytics-engineer`
- `godot-csharp-specialist`
- `godot-gdextension-specialist`
- `live-ops-designer`
- `localization-lead`
- `network-programmer`

Их не стоит брать как нормальную стартовую поверхность для игры с нуля в текущей конфигурации.
Если проект реально упрется в multiplayer, C#, GDExtension, dedicated live-ops, deep localization leadership или отдельную analytics-вертикаль, тогда их можно re-enable как first-class roles.

## Полный tool слой

Ниже уже не только роли, а весь tool layer, который сейчас реально используется в этом workspace.

### 1. Каноничные agent tool aliases

Это те alias-имена, которые реально используются в frontmatter `.agent.md`.

| Alias | Что означает на практике |
|---|---|
| `read` | Чтение файлов, директорий, конфигов, markdown, артефактов, изображений, notebook summary |
| `search` | Поиск по workspace: glob, grep, semantic/code search, обзор структуры |
| `edit` | Правки файлов и notebook-контента |
| `execute` | Терминал, задачи, проверки, сборки, запуск команд |
| `web` | Внешняя документация, web-fetch, browser/web lookup surface |
| `agent` | Делегация в subagents и manager->leaf orchestration |
| `todo` | План, task list, orchestration steps |

### 2. Полная tool matrix по user-facing агентам

| Агент | user-invocable | Tools |
|---|---|---|
| `game-orchestrator` | yes | `read`, `search`, `agent`, `todo` |
| `creative-director` | yes | `read`, `search`, `edit`, `web`, `agent` |
| `technical-director` | yes | `read`, `search`, `edit`, `execute`, `web`, `agent` |
| `producer` | yes | `read`, `search`, `edit`, `web`, `agent`, `todo` |
| `game-designer` | yes | `read`, `search`, `edit`, `web`, `agent` |
| `art-director` | yes | `read`, `search`, `edit`, `web`, `agent` |
| `ux-designer` | yes | `read`, `search`, `edit`, `execute`, `web`, `agent` |
| `godot-specialist` | yes | `read`, `search`, `edit`, `execute`, `web`, `agent` |

### 3. Полная tool matrix по скрытым активным leaf-агентам

| Агент | user-invocable | Tools |
|---|---|---|
| `accessibility-specialist` | no | `read`, `search`, `edit`, `execute` |
| `ai-programmer` | no | `read`, `search`, `edit`, `execute` |
| `audio-director` | no | `read`, `search`, `edit`, `web` |
| `devops-engineer` | no | `read`, `search`, `edit`, `execute` |
| `gameplay-programmer` | no | `read`, `search`, `edit`, `execute` |
| `godot-gdscript-specialist` | no | `read`, `search`, `edit`, `execute` |
| `godot-shader-specialist` | no | `read`, `search`, `edit`, `execute` |
| `level-designer` | no | `read`, `search`, `edit`, `web` |
| `narrative-director` | no | `read`, `search`, `edit`, `web` |
| `performance-analyst` | no | `read`, `search`, `edit`, `execute` |
| `prototyper` | no | `read`, `search`, `edit`, `execute` |
| `qa-lead` | no | `read`, `search`, `edit`, `execute` |
| `security-engineer` | no | `read`, `search`, `edit`, `execute` |
| `systems-designer` | no | `read`, `search`, `edit`, `web` |
| `technical-artist` | no | `read`, `search`, `edit`, `execute` |
| `tools-programmer` | no | `read`, `search`, `edit`, `execute` |

### 4. Tool matrix parked feature-агентов

| Агент | Статус | Tools |
|---|---|---|
| `analytics-engineer` | parked | `read`, `search`, `edit`, `execute`, `web` |
| `godot-csharp-specialist` | parked | `read`, `search`, `edit`, `execute` |
| `godot-gdextension-specialist` | parked | `read`, `search`, `edit`, `execute` |
| `live-ops-designer` | parked | `read`, `search`, `edit`, `web` |
| `localization-lead` | parked | `read`, `search`, `edit`, `execute` |
| `network-programmer` | parked | `read`, `search`, `edit`, `execute` |

### 5. Что важно понимать про tools

- Frontmatter хранит alias-уровень, а не весь низкоуровневый runtime registry.
- То есть `execute` не означает один конкретный вызов, а целое семейство terminal/task tooling.
- То же самое с `read`, `search`, `edit`, `web`, `agent`, `todo`.
- Поэтому для truthfulness важны обе плоскости: alias в agent frontmatter и реальный runtime tool registry ниже.

## Полный MCP / МСП слой

Ниже уже не alias-уровень, а реальный MCP/МСП-контур этого workspace.

### 1. Реально подключённые project-local MCP servers из `.vscode/mcp.json`

| Server | Источник | Назначение |
|---|---|---|
| `crash` | `.vscode/mcp.json` | structured reasoning / state / chain-of-thought helper |
| `context7` | `.vscode/mcp.json` | актуальная библиотечная документация |
| `octocode` | `.vscode/mcp.json` | code exploration / repo research |
| `godot-coding-solo` | `.vscode/mcp.json` | часть Godot scene/script workflow |
| `godot-tomyud1` | `.vscode/mcp.json` | расширенный Godot scene/resource/script workflow |
| `rpg-game-server` | `.vscode/mcp.json` | RPG story / choice / progression tooling |

### 2. Built-in GitHub MCP surface, включённый через `.vscode/settings.json`

Это отдельный встроенный GitHub MCP, а не project-local server из `.vscode/mcp.json`.

| Toolset | Статус |
|---|---|
| `default` | enabled |
| `repos` | enabled |
| `issues` | enabled |
| `code_search` | enabled |
| `pull_requests` | enabled |
| `actions` | enabled |
| `code_security` | enabled |
| `secret_protection` | enabled |
| `security_advisories` | enabled |
| `copilot` | enabled |
| `copilot_spaces` | enabled |
| `github_support_docs_search` | enabled |

### 3. Прямо видимые MCP functions в текущем runtime

| MCP family | Exact functions |
|---|---|
| `crash` | `mcp_crash_crash` |
| `context7` | `mcp_context7_resolve-library-id`, `mcp_context7_query-docs` |
| `octocode` | `mcp_octocode_githubViewRepoStructure` |
| `godot-tomyud1` | `mcp_godot-tomyud1_create_folder`, `mcp_godot-tomyud1_disconnect_signal`, `mcp_godot-tomyud1_generate_2d_asset`, `mcp_godot-tomyud1_get_collision_layers`, `mcp_godot-tomyud1_get_godot_status`, `mcp_godot-tomyud1_instance_scene`, `mcp_godot-tomyud1_set_node_properties`, `mcp_godot-tomyud1_add_node`, `mcp_godot-tomyud1_move_node`, `mcp_godot-tomyud1_create_script`, `mcp_godot-tomyud1_edit_script` |
| `godot-coding-solo` | `mcp_godot-coding-_add_node`, `mcp_godot-coding-_create_scene` |
| `rpg-game-server` | `mcp_rpg-game-serv_createGame`, `mcp_rpg-game-serv_promptUserActions` |

### 4. MCP activator tools: GitHub / Octocode / local symbol navigation

| Domain | Exact activator tools |
|---|---|
| GitHub actions | `activate_github_actions_management` |
| GitHub comments | `activate_github_comments_interaction` |
| Pull request workflow | `activate_pull_request_management_tools` |
| GitHub Copilot task workflow | `activate_github_copilot_task_management` |
| Repository management | `activate_repository_management_tools` |
| Repository inspection | `activate_github_repository_inspection` |
| Copilot Spaces | `activate_copilot_space_management_tools` |
| Global security advisories | `activate_github_security_advisories` |
| GitHub search / teams | `activate_github_search_and_team_management` |
| Repo security / commit history | `activate_github_repository_security_and_commit_management` |
| GitHub code exploration | `activate_github_code_exploration_tools` |
| Local LSP navigation | `activate_local_symbol_navigation_tools` |

### 5. MCP activator tools: Godot families

| Domain | Exact activator tools |
|---|---|
| Scene management (basic) | `activate_scene_management_tools` |
| Project management | `activate_project_management_tools` |
| UID management | `activate_uid_management_tools` |
| Scene management (advanced) | `activate_scene_management_tools_2` |
| Project analysis | `activate_project_analysis_tools` |
| Logging | `activate_logging_tools` |
| Input management | `activate_input_management_tools` |
| Scene creation | `activate_scene_creation_tools` |
| Script management | `activate_script_management_tools` |
| Project settings | `activate_project_settings_tools` |
| Resource inspection | `activate_resource_inspection_tools` |
| 3D scene tools | `activate_3d_scene_tools` |
| Resource management | `activate_resource_management_tools` |
| Collision / mesh management | `activate_collision_management_tools` |

### 6. MCP activator tools: RPG

| Domain | Exact activator tools |
|---|---|
| RPG story progression | `activate_rpg_game_story_progression_tools` |

## Полный runtime registry этой сессии

Это уже не agent frontmatter и не только MCP. Это полный tool surface текущего chat runtime, сгруппированный по семействам.

### 1. Files, workspace, search, edit

| Family | Exact tools |
|---|---|
| Files / dirs | `read_file`, `list_dir`, `create_directory`, `create_file`, `view_image` |
| Search | `file_search`, `grep_search`, `semantic_search` |
| Edit | `apply_patch` |
| Diagnostics | `get_errors`, `get_changed_files` |

### 2. Terminal and tasks

| Family | Exact tools |
|---|---|
| Terminal execution | `run_in_terminal`, `get_terminal_output`, `send_to_terminal`, `kill_terminal` |
| Terminal state | `terminal_last_command`, `terminal_selection` |
| Tasks | `create_and_run_task` |

### 3. Browser and page automation

| Family | Exact tools |
|---|---|
| Browser lifecycle | `open_browser_page`, `read_page`, `navigate_page`, `screenshot_page` |
| Page interaction | `click_element`, `hover_element`, `drag_element`, `type_in_page`, `handle_dialog` |
| Advanced browser automation | `run_playwright_code` |

### 4. Notebook tooling

| Family | Exact tools |
|---|---|
| Notebook create/edit | `create_new_jupyter_notebook`, `edit_notebook_file` |
| Notebook inspect/run | `copilot_getNotebookSummary`, `run_notebook_cell`, `read_notebook_cell_output` |

### 5. VS Code, planning, memory, user interaction

| Family | Exact tools |
|---|---|
| VS Code / setup | `create_new_workspace`, `get_project_setup_info`, `get_vscode_api`, `install_extension`, `run_vscode_command`, `vscode_searchExtensions_internal` |
| User interaction | `vscode_askQuestions` |
| Planning | `manage_todo_list` |
| Memory | `memory`, `resolve_memory_file_uri` |

### 6. Code intelligence and symbol operations

| Family | Exact tools |
|---|---|
| Symbol usage / rename | `vscode_listCodeUsages`, `vscode_renameSymbol` |
| Search / research helpers | `search_subagent`, `runSubagent` |

### 7. Web, docs, diagrams, misc

| Family | Exact tools |
|---|---|
| Web/docs | `fetch_webpage` |
| Diagram rendering | `renderMermaidDiagram` |

## Практическое правило выбора

Если сомневаешься, используй такое правило:

- Не уверен вообще -> `game-orchestrator`
- Вопрос про игру как опыт и правила -> `game-designer`
- Вопрос про код, архитектуру, реализацию -> `technical-director`
- Вопрос именно про Godot -> `godot-specialist`
- Вопрос про UI, menus, HUD, controls -> `ux-designer`
- Вопрос про визуальный стиль -> `art-director`
- Вопрос про порядок работ, scope и next steps -> `producer`

Этого достаточно для 90% реальных стартовых ситуаций.

## Сверхкороткая версия

```text
Не уверен -> game-orchestrator

Идея, тон, видение -> creative-director
Механики, loop, economy, progression -> game-designer
Архитектура, код, implementation -> technical-director
Godot-specific решение -> godot-specialist
UI, HUD, flow -> ux-designer
Visual style, asset rules -> art-director
План, prototype, sprint, release -> producer
```
