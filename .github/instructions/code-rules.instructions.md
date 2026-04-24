# Инструкции проекта Gamedev — code-rules (ядро)

Этот документ хранит только постоянные кросс-ролевые нормы для текущего workspace `/home/projects/gamedev`.
Дефолтное поведение для всех сессий задаётся в `.github/instructions/copilot-instructions.md`.

На текущий момент оркестрационный контур в `.github/agents/` состоит из `Consilium-Boss.agent.md` и подчинённых `Consilium-*` аналитиков и Devils. 

## 0) Базовые пользовательские правила (НОРМАТИВНО)

- Язык коммуникации — русский.
- Системные сообщения и логи не переводить без явного запроса пользователя.
- Команды и пути давать copy-ready.

### Поведение при анализе и ревью (НОРМАТИВНО)

- Быть прямым, честным и независимым в выводах.
- Не подстраивать ответ под ожидаемую пользователем позицию, если факты говорят обратное.
- Если вывод не подтверждён кодом, конфигом или исполнимой проверкой, это нужно явно помечать как непроверенную гипотезу.
- В режиме review первичны проблемы, риски и регрессии, а не пересказ изменений.

### AI/Agent Naming Policy

- Для `model` в `.agent.md` использовать только формат `Model Name (vendor)`.
- Каноничные значения брать ровно в том виде, как они называются в model picker VS Code.
- Примеры валидного формата: `GPT-5 (copilot)`, `GPT-5.3-Codex (copilot)`, `Claude Opus 4.7 (copilot)`.
- Сокращения и самодельные алиасы вроде `codex`, `opus-4.7`, `gemini-fast` запрещены.

### Tool Contract Policy

- В `.agent.md` и `SKILL.md` нельзя писать `MUST` / `MANDATORY` / `ALWAYS use` для tool names, которых нет в реально доступном tool registry или в `tools:` allowlist конкретного агента.
- Если инструмент недоступен, инструкция должна указывать на реально доступный fallback, а не на желаемый namespace.
- При редактировании `.github/*` код и конфиг имеют приоритет над markdown-описаниями. Нельзя сохранять ложные summary ради красоты документа.

## 1) Реальность проекта (источник истины)

- Основной исполняемый игровой проект находится в `/home/projects/gamedev/my-game/`.
- Текущий Godot entry point задан в `/home/projects/gamedev/my-game/my-game.godot`: main scene — `res://scenes/main.tscn`.
- `my-game/scenes/main.tscn` и `my-game/scripts/main.gd` — текущая минимальная рабочая база игры; для игровых задач это стартовая точка поиска и правок по умолчанию.
- `/home/projects/gamedev/godot-lib-pazzle/` — локальный vendor/reference-набор библиотек, аддонов, демо-проектов и интеграционных образцов.
- `/home/projects/gamedev/godot-lib-pazzle/README.md` — основная карта готовых компонентов, рекомендуемого стартового стека и замен внутри `alternatives/`; при выборе готового решения начинать оттуда.
- `/home/projects/gamedev/godot-lib-pazzle/alternatives/` — локальные замены недоступных или неудобных upstream-источников.
- `/home/projects/gamedev/game-studios-agents/` — отдельный референсный каталог по агентам и workflow, не основной gameplay-код.
- `.github/` — orchestration/config слой текущего workspace.

## 2) Запреты (ОБЯЗАТЕЛЬНО)

- Запрещено выполнять destructive git-команды без явного запроса пользователя: `git reset`, `git restore`, `git clean`, `git checkout -- ...`.
- Запрещено запускать container image builds без явного запроса пользователя: `docker build`, `docker compose build`, `docker-compose build`, `podman build` и эквиваленты.
- Запрещено вносить фейковые данные, placeholder-конфиги, моковые секреты или «временные» значения, которые пользователь потом случайно утащит в рабочий код.
- Запрещено менять реальные секреты, токены, billing keys, Firebase/Nakama/Google Play credentials без прямого запроса пользователя.
- Запрещено начинать задачу с правок тестов, конфигов или документации, если корневая проблема ещё не исправлена в реальном коде.
- Если у пользователя есть неотвеченный материальный вопрос по текущей задаче, нельзя делать рискованные изменения, которые зависят от этого ответа.

## 3) Область правок и границы ответственности

- Для gameplay-задач по умолчанию правки должны идти в `/home/projects/gamedev/my-game/`.
- `godot-lib-pazzle/*` и `alternatives/*` сначала читать как reference-источник; переносить в `my-game` нужно только минимально необходимый код или паттерн.
- Не редактировать vendor-библиотеки массово, если задача на самом деле про интеграцию в `my-game`.
- Если правка внутри vendored repo всё же нужна, в отчёте должно быть понятно, почему нельзя было ограничиться адаптацией на стороне `my-game`.
- Не делать широких refactor-кампаний сразу по нескольким библиотекам, если пользователь просил локальную фичу, фикс или настройку.

## 4) Нормы качества кода

- Вносить только необходимые изменения, не ломая стиль и структуру затронутого файла без причины.
- Предпочитать простые, устойчивые решения вместо архитектурного шума и лишних абстракций.
- Повторно использовать существующие паттерны проекта и библиотеки, если они уже закрывают нужную задачу.
- Для GDScript следовать стилю конкретного затронутого файла. Не делать принудительную массовую миграцию синтаксиса только потому, что есть более новый стиль.
- Для текущего `my-game` это особенно важно: в проекте уже встречается legacy-style GDScript вроде `onready var` и вызовы через `OS`, поэтому автоматическая «модернизация» без запроса пользователя запрещена.
- При правках `.tscn`, `.tres`, `.godot`, `.gdshader` сохранять стабильную структуру ресурса и не вносить unrelated formatting churn.
- При работе с C#-кодом в vendored plugins учитывать ближайшие `.csproj`/`.sln` как реальную границу изменения и валидации.

## 5) Валидация и доказательства

- После правок запускать самый узкий доступный check для затронутого среза.
- Для `.gd`, `.tscn`, `.tres`, `.godot` предпочитать `gdlint`, `godot --check-only`, `godot4 --check-only` или другой узкий Godot-aware check, если он реально доступен в окружении.
- Для C# предпочитать `dotnet build --no-restore` по ближайшему `.csproj` или `.sln`, если `dotnet` доступен.
- Для shell / json / python в `.github` и вспомогательных скриптах предпочитать `bash -n`, `jq empty`, `python3 -m py_compile`.
- Если нужных локальных инструментов нет (`godot`, `godot4`, `gdlint`, `dotnet`), это нужно прямо указывать в отчёте. Нельзя заявлять runtime-валидацию, которую фактически не запускали.
- `git diff` допустим только как fallback, когда нет более узкой исполнимой проверки.

## 6) Источники документации

- В этом workspace нет единого глобального `/docs`-корня для всего проекта. Документацию нужно искать сначала рядом с затронутой областью.
- Для игровых и интеграционных задач сначала смотреть ближайшие `README.md`, `docs/`, `examples/`, demo-scenes и тесты в нужном поддереве.
- Для выбора библиотеки из локального vendor set сначала читать `/home/projects/gamedev/godot-lib-pazzle/README.md`, а затем уже углубляться в README/docs/examples конкретного аддона.
- Для runtime-поведения Godot первичный источник истины — сами project files, scenes и scripts в `my-game/` и в затронутом addon subtree.
- Для сторонних библиотек, SDK и сервисов использовать Context7, а при необходимости `fetch_webpage` по официальным источникам.
- При документировании изменений сначала обновлять уже существующий релевантный markdown рядом с модулем или библиотекой, а не плодить новые верхнеуровневые файлы.

## 7) Orchestration и truthfulness для `.github/*`

- Любые summary в `.github/*` должны описывать реальное состояние control plane, а не желаемую будущую схему.
- Нельзя ссылаться на отсутствующие файлы, агенты, skills, hooks, MCP servers или registries как на уже существующие.
- На момент этой инструкции в `.github/agents/` реально присутствуют только `Consilium-Boss` и `Consilium-*` аналитики/Devils. Упоминания `Conductor`, `UI-Governor`, `AGENTS.md` и любых чужих отсутствующих пайплайнов считаются stale, пока эти сущности не появятся в репозитории.
- Hooks должны ссылаться только на реальные скрипты внутри `.github/hooks/`.
- На текущий момент рабочие guardrails заданы через `.github/hooks/pretool-guard.sh`, `.github/hooks/posttool-quality.sh` и `.github/hooks/posttool-security.sh`; если инструкции описывают поведение hooks, оно должно совпадать с этими файлами.
- При изменениях в `.github/instructions/*`, `.github/agents/*`, `.github/hooks/*`, `.github/mcp/*` нужно особенно внимательно проверять cross-file consistency и убирать legacy traces.

### Общая доктрина Consilium

- `Consilium-Boss` — это decision engine, а не implementation agent. Его задача: сформировать рамку проблемы, запустить 4 аналитика, агрегировать выводы, запустить 4 Devils и выдать final ruling.
- Аналитики и Devils работают read-only. Для них нормой считаются чтение, поиск, трассировка, проверка docs и MCP-исследование, но не запись файлов и не выполнение мутаций.
- Для правок и ревью самих agent-файлов сохранять текущую общую фазовую логику Boss: `crash/crash` для framing → `memory/*` для retrieval → `task-manager/*` для task state → skill routing → параллельный запуск аналитиков/Devils.
- При изменениях orchestration-файлов не ломать ключевые invariants текущего контура: аналитики запускаются одним параллельным батчем, Devils запускаются одним параллельным батчем, Boss не должен выполнять code changes.
- Если в agent-доках есть `MANDATORY`-требование на skill, MCP или protocol step, оно должно быть исполнимо в текущем репо. Нельзя держать обязательные шаги, которые ссылаются на отсутствующий файл или несуществующий tool namespace.

### Skills и prompts: что реально есть в репо

| Skill | Статус | Когда применять | Файл |
|---|---|---|---|
| `octocode-code-forensics` | real | code forensics, impact analysis, call chains, локальный поиск реального управляющего пути | `.github/skills/octocode-code-forensics/SKILL.md` |
| `orchestration-qa` | real | правки `.github/*`, валидация agents / skills / hooks / MCP / instructions | `.github/skills/orchestration-qa/SKILL.md` |

- Ссылки в agent-файлах на `feature-dev`, `security-guidance`, `pr-review-toolkit`, `docker-diagnostics`, `facebook-observability-lab`, `playwright-ui-evidence`, `fb-front-*` и другие отсутствующие skill directories считаются config debt, а не доступной функциональностью.
- Если instruction или agent описывает skill routing, обязательными можно делать только реально существующие `SKILL.md`.

| Prompt | Статус | Назначение | Файл |
|---|---|---|---|
| `diagnostique.prompt.md` | real | режим диагностики: полное чтение цепочки, валидация по техдокам, таблица 5 колонок | `.github/prompts/diagnostique.prompt.md` |
| `comit.md` | real | генерация commit message | `.github/prompts/comit.md` |

- `comit.md` не должен описываться как agent, workflow engine или review mode.

### MCP-контур: реальность, а не обещания

- Актуальный workspace-source of truth для MCP в этом репо — `.vscode/mcp.json`, а не `.github/mcp/mcp.json`.
- В `.vscode/settings.json` MCP действительно включён через `github.copilot.chat.mcp.enabled=true`, autostart включён через `chat.mcp.autostart=newAndOutdated`, и отдельно включён built-in GitHub MCP через `github.copilot.chat.githubMcpServer.enabled=true`.
- После выравнивания конфигов `.github/mcp/mcp.json` синхронизирован с активным `.vscode/mcp.json` по одному и тому же набору project-local servers.
- Реально объявленные в `.vscode/mcp.json` и `.github/mcp/mcp.json` servers: `crash`, `context7`, `octocode`, `filesystem`, `mcp-files`.
- Отдельно от `.vscode/mcp.json` через built-in GitHub MCP в `.vscode/settings.json` включены GitHub toolsets: `default`, `repos`, `issues`, `code_search`, `pull_requests`, `actions`, `code_security`, `secret_protection`, `security_advisories`, `copilot`, `copilot_spaces`, `github_support_docs_search`.
- Базовая рабочая группировка для документации и маршрутизации:
	- reasoning/state: `crash`
	- code/docs research: `octocode`, `context7`, built-in GitHub MCP
	- filesystem/utilities: `filesystem`, `mcp-files`
	- browser/runtime evidence: встроенные browser tools VS Code, а не отдельные MCP servers
- Для MCP в этом workspace обязательно различать три состояния, а не два: сервер объявлен в конфиге, сервер структурно валиден, сервер реально project-local.
- По фактическому состоянию локальных привязок:
	- `crash`, `octocode`, `filesystem`, `mcp-files` — объявлены и project-local для текущего репо.
	- `context7` — объявлен, но зависит от `CONTEXT7_API_KEY`; без него сервер нужно считать environment-bound и потенциально деградированным.
- Болванка под `memory` существует отдельно в `.vscode/mcp.memory.template.json`; пока локальный `memory-server` реально не добавлен в репо, она не должна подключаться в активный autostart MCP config.
- Если agent-файлы требуют `postgres/*` или `pgtuner/*`, это truthfulness gap: такие servers не объявлены в актуальном `.vscode/mcp.json`, несмотря на упоминания в `serverSampling` и agent docs.
- Если instructions или agent docs перечисляют `apify`, `github-support-docs` или `github-copilot`, нужно различать источник: `apify` сейчас не объявлен в активном MCP config, а GitHub-related возможности приходят из built-in GitHub MCP в `.vscode/settings.json`, а не из `.vscode/mcp.json` или `.github/mcp/mcp.json`.
- При недоступности MCP серверов использовать деградационные теги только там, где это реально описано в agent protocol. В текущем `Consilium-Boss.agent.md` уже используются: `context7_down`, `db_ro_fallback`, `db_perf_fallback`, `memory_snapshot_used`, `devtools_fallback`, `playwright_fallback`.

### Режимы анализа

- `deep-analysis` и `diagnostics` — это реальные operational modes текущего Consilium-контура, потому что они описаны в `Consilium-Boss.agent.md`.
- Если инструкция или agent активирует `diagnostics`, нужно сохранять текущую доктрину: типизация находок (`logic`, `consistency`, `best-practice`, `docs-drift`, `dead-code`, `duplication`, `complexity`, `TODO`) и табличный формат из `diagnostique.prompt.md`.
- Если инструкция или agent активирует `deep-analysis`, нельзя снижать evidence floor по сравнению с тем, что уже требует `Consilium-Boss.agent.md`.

## 8) Технологический фокус этого workspace

- Этот workspace Godot-first. Нельзя по умолчанию навязывать ему Node.js / React / TypeORM / pnpm / turbo workflow, если задача реально относится к `my-game` или к Godot library set.
- Google Play Billing, Nakama, Rapier, Jolt и другие интеграции в этом workspace существуют как опциональные библиотеки/референсы. О них нужно говорить только если задача действительно попадает в соответствующий срез.

## 9) Разделение ответственности

- `code-rules.instructions.md` хранит только постоянные кросс-ролевые нормы.
- Workflow, scorecards, multi-stage protocols и role-specific checklists должны жить в agent/skill файлах, а не в этом документе.
- При конфликте приоритет такой: требования пользователя в текущем диалоге → этот файл → role-specific instructions.
