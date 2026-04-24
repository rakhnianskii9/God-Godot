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

## Как раскладывать `godot-lib-pazzle` по агентам

Ниже уже не общая orchestration-схема, а практическая карта по локальному vendor set из [godot-lib-pazzle/README.md](./godot-lib-pazzle/README.md).

Как это читать:

- `Кого звать первым` — агент, с которого лучше начинать разговор о библиотеке.
- `Кто обычно продолжает` — кто чаще всего подхватывает решение после первичного выбора.
- `alternatives/` считать частью той же строки: локальная замена наследует того же владельца, что и основная библиотека.
- Если вопрос не про конкретную библиотеку, а про смешанную фичу, все еще начинай с `game-orchestrator`.

### Архитектура, gameplay и AI

| Библиотека | Кого звать первым | Кто обычно продолжает | Когда это основная связка |
|---|---|---|---|
| `godot-statecharts` | `game-designer` | `technical-director`, `godot-specialist`, `gameplay-programmer`, `ai-programmer` | Когда нужно разложить player/enemy/UI flow по состояниям и потом встроить это в Godot-архитектуру |
| `beehave` | `game-designer` | `ai-programmer`, `godot-specialist`, `performance-analyst` | Когда врагам или NPC уже мало FSM и нужен поведенческий выбор |
| `godot-steering-ai-framework` | `ai-programmer` | `godot-specialist`, `performance-analyst` | Когда проблема уже не в выборе действия, а в пространственном движении, avoidance и pursuit |
| `pandora` | `game-designer` | `systems-designer`, `technical-director`, `godot-specialist`, `gameplay-programmer` | Когда данные, баланс и сущности надо вытащить из кода в data-driven слой |
| `gloot` | `game-designer` | `ux-designer`, `godot-specialist`, `gameplay-programmer` | Когда появляются предметы, слоты, стаки, сундуки и inventory UI |
| `EventBus` | `technical-director` | `godot-specialist`, `tools-programmer`, `gameplay-programmer` | Когда нужно развязать UI, звук, квесты и gameplay-системы по событиям |
| `Godot-Component-System` | `technical-director` | `godot-specialist`, `gameplay-programmer` | Когда проект реально уходит в component-heavy/data-driven архитектуру, а не просто в node tree |

### Ввод и mobile

| Библиотека | Кого звать первым | Кто обычно продолжает | Когда это основная связка |
|---|---|---|---|
| `godot_input_helper` | `ux-designer` | `accessibility-specialist`, `godot-specialist`, `gameplay-programmer` | Когда нужно унифицировать keyboard/gamepad/touch input и rebinding |
| `godot-touch-input-manager` | `ux-designer` | `accessibility-specialist`, `godot-specialist`, `gameplay-programmer` | Когда игра реально идет в mobile и нужны жесты выше уровня сырых touch events |
| `virtual-joystick-godot` | `ux-designer` | `accessibility-specialist`, `gameplay-programmer` | Когда нужен mobile movement/aim stick и важно не сломать player feel |
| `godot-google-play-billing` | `producer` | `technical-director`, `devops-engineer`, `feature/godot-csharp-specialist` | Когда обсуждаются Android IAP, store constraints, release risk и platform integration |

### Сохранения, переходы и runtime-скелет

| Библиотека | Кого звать первым | Кто обычно продолжает | Когда это основная связка |
|---|---|---|---|
| `Godot-Save-System` | `technical-director` | `godot-specialist`, `gameplay-programmer`, `qa-lead` | Когда нужно быстро ввести persistence и сразу думать о versioning, restore и regression risk |
| `scene_manager` | `technical-director` | `godot-specialist`, `ux-designer`, `gameplay-programmer` | Когда проект перестает быть одной сценой и появляется navigation flow между меню, уровнями и loading transitions |
| `godot-game-template` | `technical-director` | `producer`, `godot-specialist` | Когда нужен architectural bootstrap или референс структуры проекта, а не точечный addon |

### Камера, UI, диалоги и presentation

| Библиотека | Кого звать первым | Кто обычно продолжает | Когда это основная связка |
|---|---|---|---|
| `phantom-camera` | `art-director` | `technical-artist`, `godot-specialist`, `gameplay-programmer` | Когда камера уже влияет на feel, staging, combat readability или cutscene presentation |
| `godot_dialogue_manager` | `narrative-director` | `ux-designer`, `godot-specialist`, `gameplay-programmer` | Когда диалог уже не просто текст, а ветвления, переменные, UI и narrative flow |
| `godot_sound_manager` | `audio-director` | `godot-specialist`, `gameplay-programmer`, `technical-artist` | Когда музыка и SFX надо централизовать, а не разбрасывать по сценам |
| `GoTween` | `ux-designer` | `technical-artist`, `gameplay-programmer` | Когда нужен UI polish, feedback, tween chains и motion orchestration |
| `godot-accessibility` | `ux-designer` | `accessibility-specialist`, `godot-specialist` | Когда вопрос в screen reader, accessible UI flow и специальных assistive patterns |
| `scatter` | `level-designer` | `technical-artist`, `godot-specialist` | Когда уровни, декор или spawn layout начинают собираться полуавтоматически |

### Тесты, debug и эксплуатация

| Библиотека | Кого звать первым | Кто обычно продолжает | Когда это основная связка |
|---|---|---|---|
| `gut` | `qa-lead` | `technical-director`, `gameplay-programmer`, `godot-specialist` | Когда игровая логика доросла до regression suite и ручных проверок уже мало |
| `PankuConsole` | `tools-programmer` | `qa-lead`, `gameplay-programmer` | Когда нужна внутриигровая dev-console для debug builds и быстрых ручных сценариев |
| `godot-logger` | `tools-programmer` | `technical-director`, `qa-lead`, `performance-analyst` | Когда нужен нормальный trail runtime-событий, а `print` уже не хватает |

### Короткое правило выбора

- Если библиотека меняет правила игры, баланс или состав систем, первым почти всегда будет `game-designer`.
- Если библиотека меняет архитектуру, интеграцию, scene tree, data flow или runtime contracts, первым почти всегда будет `technical-director` или `godot-specialist`.
- Если библиотека меняет HUD, input, readability, диалоговый UX или accessibility, первым почти всегда будет `ux-designer`.
- Если библиотека меняет подачу, камеру, звук или визуальный polish, первым почти всегда будет `art-director` или `audio-director`.
- Если библиотека нужна для тестов, debug-инструментов, release или platform pipeline, первым почти всегда будет `qa-lead`, `tools-programmer`, `devops-engineer` или `producer`.

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

Теперь схема снова role-based, а не `полный доступ у всех`.

Базовый реалистичный пакет для этого Godot workspace такой:

- `read` и `search` есть у всех агентов
- `edit` есть почти у всех доменных ролей, кроме чистого роутера `game-orchestrator`
- `execute` даётся только там, где роль реально должна что-то запускать, валидировать или автоматизировать

### 3. Реальные bundles по ролям

| Bundle | Агенты | Что им реально выдано |
|---|---|---|
| Routing core | `game-orchestrator` | `read`, `search`, `agent`, `todo`, `vscode_askQuestions`, `memory`, `crash/*` |
| Production orchestration | `producer` | planning/delegation bundle, `edit`, `web`, `todo`, `memory`, release-oriented GitHub activators |
| Creative leadership | `creative-director`, `game-designer`, `art-director` | `edit`, `web`, `agent`, `vscode_askQuestions`, `renderMermaidDiagram`, `view_image`, а narrative/game-design роли получают `rpg-game-server/*` там, где это осмысленно |
| UI / accessibility | `ux-designer`, `accessibility-specialist` | `execute`, `get_errors`, browser tools, `view_image`, плюс Godot UI-oriented scene/script/input tools |
| Technical governance | `technical-director` | самый широкий техпакет: `execute`, symbol tools, planning/memory, GitHub activators, Godot activators, `crash/*`, `context7/*`, `octocode/*`, Godot MCP wildcard-ы |
| Godot authority | `godot-specialist` | Godot architecture bundle: symbol tools, scene/script/project/resource activators, `context7/*`, `octocode/*`, Godot MCP wildcard-ы |
| Godot implementation | `gameplay-programmer`, `ai-programmer`, `godot-gdscript-specialist`, `godot-csharp-specialist`, `godot-gdextension-specialist`, `network-programmer`, `prototyper` | `execute`, `get_errors`, symbol tools, Godot scene/script/project/resource activators, `context7/*`, `octocode/*`, Godot MCP wildcard-ы |
| Visual Godot implementation | `godot-shader-specialist`, `technical-artist` | тот же implementation bundle, но ещё и `view_image` |
| Content / system specialists | `audio-director`, `narrative-director`, `level-designer`, `systems-designer`, `live-ops-designer`, `localization-lead` | в основном `read/search/edit/web`, диаграммы и narrative/RPG tooling только там, где это реально связано с ролью; `execute` у `localization-lead` оставлен для проверки i18n-пайплайна |
| QA | `qa-lead` | `execute`, `get_errors`, browser tools, GitHub actions/PR inspection, Godot QA-facing activators |
| Security | `security-engineer` | repo/security activators, symbol navigation, project analysis/logging, `context7/*`, `octocode/*` |
| Tooling / data | `devops-engineer`, `tools-programmer`, `performance-analyst`, `analytics-engineer` | VS Code/workspace tools, notebook tools там где нужны, GitHub ops, analysis tooling, `context7/*`, `octocode/*` |

### 4. Что важно понимать про tools

- Мы больше не делим роли искусственно ради галочки, но и не держим `superuser`-allowlist у каждого агента.
- Role boundary теперь подкреплена и body-текстом агента, и более узким `tools:`-контрактом.
- Parked feature-агенты тоже переведены на role-appropriate bundles, а не на отдельный `полный доступ` пакет.
- То есть в системе по-прежнему покрыт весь tool surface, но он теперь распределён по назначению, а не размазан равномерно.

## Полный MCP / МСП слой

Ниже уже не alias-уровень, а реальный MCP/МСП-контур этого workspace.

Важно:

- `godot-coding-solo/*` и `godot-tomyud1/*` выданы в основном technical/Godot/UI/QA/implementation ролям.
- `rpg-game-server/*` выдан только creative/narrative/design/live-ops ролям, где он реально связан с задачей.
- `context7/*` и `octocode/*` сосредоточены в technical, security, tooling и implementation ролях.
- `crash/*` оставлен только там, где он реально помогает orchestration/technical reasoning.
- Built-in GitHub MCP не приходит как project-local wildcard из `.vscode/mcp.json`; доступ к нему разложен через activator tools у producer/technical/devops/qa/security/tooling ролей.

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
