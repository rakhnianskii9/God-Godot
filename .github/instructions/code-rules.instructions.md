# Инструкции проекта Flowise — code-rules (ядро)

Этот документ хранит только универсальные правила проекта, которые должны действовать всегда и для любых ролей.

Каноничный реестр всех агентов (иерархия, модели, инструменты): `.github/agents/AGENTS.md`.
Дефолтное поведение (все сессии): `.github/instructions/copilot-instructions.md`.

Оркестрация, workflow и роль-специфичные процедуры вынесены в:
- `.github/agents/Conductor.agent.md` — оркестратор полного цикла разработки
- `.github/agents/Planning-subagent.agent.md`
- `.github/agents/Implement-subagent.agent.md`
- `.github/agents/Code-review-subagent.agent.md`
- `.github/agents/Proscons-devils-advocate.agent.md`
- `.github/agents/UI-Governor.agent.md`
- `.github/agents/Consilium-Boss.agent.md` — оркестратор мультимодельного анализа
- `.github/agents/Consilium-{Sonnet,Opus,Codex,Gemini}.agent.md` — 4 аналитика
- `.github/agents/Consilium-Devil{,-GPT,-Sonnet,-Gemini}.agent.md` — 4 адвоката дьявола

## 0) Базовые пользовательские правила (НОРМАТИВНО)

- Язык коммуникации — русский.
- Системные сообщения/логи не переводить, если пользователь не попросил явно.
- Команды давать copy-ready.
- Часовой пояс для дат/времени: `Asia/Ho_Chi_Minh` (Nha Trang).

### Поведение при анализе и ревью (НОРМАТИВНО)

- Быть абсолютно честным, беспристрастным и независимым — не подстраиваться под ожидаемый ответ.
- При несогласии с пользователем или кодом — говорить прямо, с обоснованием.
- Не замалчивать проблемы ради «чистого» отчёта.

### AI/Agent naming policy (VS Code 1.109+)

- Для model-настроек и `model` в `.agent.md` использовать только квалифицированный формат `Model Name (vendor)`.
- Каноничные значения фиксировать в точности как в model picker VS Code (без сокращений, lower-case alias и самодельных имен).
- Примеры валидного формата: `GPT-5.3-Codex (copilot)`, `Claude Opus 4.6 (copilot)`, `GPT-5 (copilot)`.
- Невалидные формы (`codex-5.3`, `opus 4.6`, и т.п.) запрещены для проектных инструкций/шаблонов/документов.

### Tool Contract Policy (VS Code agents/skills)

- В `.agent.md` и `SKILL.md` запрещено писать `MUST` / `MANDATORY` / `ALWAYS use` для tool names, которых нет в реально доступном tool registry или в `tools:` allowlist данного агента.
- Если инструмент недоступен, инструкция должна ссылаться на реально доступную альтернативу, а не на желаемый namespace.
- Перед добавлением нового tool name в `tools:` нужно проверять, что он реально валиден в текущем окружении; фиктивные namespaces запрещены.

### Запреты (ОБЯЗАТЕЛЬНО)

- **АБСОЛЮТНЫЙ ЗАПРЕТ: никогда не выполнять `docker build`, `docker-compose build`, `docker compose build` или любую команду, которая пересобирает Docker-образы.** Это нарушение любого уровня задачи, даже если пользователь явно не запретил в рамках задачи. Сборка Docker занимает значительное время, ломает рабочий процесс и создаёт простои. При необходимости — спросить пользователя.
- Новые env-переменные вносить только после явного согласования пользователя и только в `/home/projects/new-flowise/docker/.env`.
- Запрещено вносить/изменять секреты в env-файлах без прямого запроса пользователя.
- Запрещено добавлять фейковые данные/заглушки/placeholder-конфигурации.
- Запрещено откатывать/сбрасывать/ревертить изменения в workspace (например: `git reset`, `git restore`, `git clean`, `git checkout -- ...`) без явного запроса/подтверждения пользователя.
- Запрещено внедрять iframe старого интерфейса или редиректы на внешний Flowise UI.
- При наличии неотвеченных вопросов пользователя по текущей задаче запрещено вносить изменения в код/БД до прояснения.
- Документацию по новым модулям создавать только в `/home/projects/new-flowise/docs/moduls`.
- Для нового модуля разрешён максимум один общий `.md` файл.
- Для доработки существующего модуля сначала обязательно искать релевантный документ в `/home/projects/new-flowise/docs` и обновлять его.
- Создание нового `.md` при доработке существующего модуля разрешено только если после проверки подтверждено отсутствие релевантного документа.
- До завершения проверки существующих документов в `/home/projects/new-flowise/docs` создание нового `.md` запрещено.
- Именование новых `.md` файлов: человекочитаемый формат как `Whatsapp-Gupshup.md` (Title-Case и дефисы допустимы), без ALL CAPS.
- Исключение: эти ограничения не распространяются на рабочие артефакты оркестрации в `/home/projects/new-flowise/plans` (`*-plan.md`, `*-phase-*-complete.md`, `*-complete.md`).

### Управление планами (`/plans/`) (ОБЯЗАТЕЛЬНО)

- При работе над задачей разрешено удалять **только** MD-файлы своего кластера задач. Чужие/несвязанные планы не трогать.
- По завершении фазы анализа/планирования: удалить промежуточные MD своего кластера и сформировать **1 общий подробный** файл-план в `/plans/`.
- По завершении реализации кода: дополнять этот же общий файл информацией о проделанной работе (файлы, функции, результаты билда, review-статус).
- Запрещено удалять MD-файлы, не относящиеся к текущей задаче.

### UX/Frontend ограничения

- Для `packages/fb-front` использовать `flowbite-react` + `flowbite` как базу UI-компонентов.
- Не подключать Flowbite в `packages/ui` (там MUI).
- Новые страницы в `fb-front` должны быть нативными для проекта и использовать существующую цветовую схему.

## 1) Нормы качества кода

- Вносить только необходимые изменения, не ломая стиль и структуру текущего кода.
- Предпочитать простые и надёжные решения (анти-оверинжиниринг).
- Не менять несвязанные участки кода без необходимости.
- Повторно использовать существующие утилиты/паттерны проекта.

## 2) Миграции и Entity (ОБЯЗАТЕЛЬНО)


### Регистрация миграций

- Каждую новую миграцию обязательно регистрировать в реестре миграций `packages/server/src/database/migrations/postgres/index.ts`:
  1. добавить импорт класса миграции;
  2. добавить класс в массив `postgresMigrations`.

### Именование и типы

- Для новых SQL-объектов и новых `@Column({ name })` использовать `snake_case`.
- Для FK строго проверять соответствие типов PK связанной сущности (`uuid`/`varchar`/`int`).

### Entity-правила

- Для новых полей добавлять явный `@Column(...)` с параметром `name` в `snake_case`.
- Legacy `camelCase` в уже существующих колонках допускается до отдельной миграции выравнивания; расширять такие паттерны в новом коде запрещено.

## 3) Источники документации

- Наш проект (архитектура, модули): `/home/projects/new-flowise/docs`.
- Сторонние библиотеки/API: Context7 + `fetch_webpage` (официальные источники).

## 4) Карта проекта (опорные директории)

- `/home/projects/new-flowise/.github/` — инструкции, контекст, служебные файлы.
- `/home/projects/new-flowise/.vscode/` — workspace-настройки редактора и локальные конфиги запуска/отладки.
- `/home/projects/new-flowise/nginx/` — конфигурация Nginx и связанная инфраструктура проксирования.
- `/home/projects/new-flowise/.flowise/storage/` — файловое хранилище Flowise (данные/артефакты рантайма).
- `/home/projects/new-flowise/packages/` — исходники (`server`, `ui`, `components`, `fb-front`, и др.).
- `/home/projects/new-flowise/packages/fb-front/` — фронтенд модуль Meta/Facebook и связанные UI-потоки.
- `/home/projects/new-flowise/packages/whatsapp/` — модули WhatsApp (builder/chat/portal и смежные части).
- `/home/projects/new-flowise/docs/` — внутренняя документация проекта.
- `/home/projects/new-flowise/docker/` — docker/compose инфраструктура.

## 5) Стек проекта (по модулям)

- `packages/server` — Node.js + TypeScript, TypeORM, PostgreSQL, миграции через `packages/server/src/database/migrations/postgres/index.ts`.
- `packages/ui` — React + MUI (Flowbite не использовать).
- `packages/fb-front` — React + Flowbite (`flowbite-react`/`flowbite`) как базовый UI-слой.
- `packages/whatsapp` (`builder`/`chat`/`portal`) — фронтенд-модули WhatsApp в рамках workspace `packages/whatsapp`.
- `docker/` + `nginx/` — инфраструктурный слой запуска/сборки и reverse proxy.
- `.github/` — orchestration/config слой (agents, instructions, context, tasks, mcp).

## 6) Agent Workflow — VS Code 1.110+ фичи

### Context Compaction (`/compact`)

- Используй `/compact` в длинных сессиях когда контекстное окно заполняется.
- **Domain-specific подсказки**: можно направить суммаризацию — примеры:
  - `/compact focus on database schema decisions and migration plan`
  - `/compact keep entity changes, TypeORM columns, and FK relations`
  - `/compact summarize completed steps, keep current plan and blockers`
- Планы, сохранённые через session memory, переживают compaction — можно вернуться к плану после нерелевантных сообщений.

### Создание кастомизаций из чата (`/create-*`)

- `/create-prompt` — сохранить reusable prompt (`.prompt.md`)
- `/create-instruction` — сохранить project convention (`.instructions.md`)
- `/create-skill` — извлечь multi-step workflow в skill-пакет (`SKILL.md`)
- `/create-agent` — создать специализированного агента (`.agent.md`)
- `/create-hook` — создать lifecycle hook
- Можно использовать natural language: "сохрани этот workflow как skill" / "сделай из этого instruction".
- При извлечении паттернов из текущей сессии — предпочитать workspace-level хранение в `.github/`.

### Agent Debug Panel

- Открыть: `Developer: Open Agent Debug Panel` (Command Palette) или шестерёнка в Chat → "View Agent Logs".
- Показывает в реальном времени: загруженные skills/hooks/agents, system prompts, tool calls.
- Использовать для отладки проблем с загрузкой хуков (`pretool-guard.sh`, `posttool-quality.sh`, `posttool-security.sh`).

### LSP-based рефакторинг (`#rename`, `#usages`)

- Для переименования символов использовать `#rename` вместо grep+replace: `Use #rename and change UserEntity to TenantUserEntity`.
- Для поиска всех использований типа/переменной: `#usages` — работает через LSP, точнее чем текстовый поиск.
- Эти инструменты приоритетнее grep/sed при рефакторинге TypeScript-кода в `packages/`.

### Agentic Browser Tools (встроенные)

- Включены в workspace (`workbench.browser.enableChatTools`).
- Инструменты: `openBrowserPage`, `navigatePage`, `readPage`, `screenshotPage`, `clickElement`, `hoverElement`, `dragElement`, `typeInPage`, `handleDialog`, `runPlaywrightCode`.
- Работают без внешних зависимостей — дополняют Playwright MCP и Chrome DevTools MCP.
- Для проверки изменений во фронте использовать ИСКЛЮЧИТЕЛЬНО встроенный браузер VS Code; `playwright/*` и `chrome-devtools/*` не являются альтернативным путём post-change верификации.

### Dev Server Visual Verification (UI scope)

- При работе с фронтенд-изменениями, требующими визуальной проверки, после успешного build необходимо проверить результат ИСКЛЮЧИТЕЛЬНО во встроенном браузере VS Code через dev server `fb-front`.
- Запускать dev server нужно командой: `cd /home/projects/new-flowise/packages/fb-front && pnpm dev` → `http://localhost:5173`.
- Требуется только AFTER-скриншот (после реализации). BEFORE-скриншот не нужен.
- Аутентификация пользователя в приложении делается вручную до начала цикла.
- Любая post-change визуальная проверка выполняется только через встроенный браузер VS Code на этом dev server.
- Не переключаться на `playwright/*` или `chrome-devtools/*` как на альтернативный verification path для проверки изменений во фронте.
- Docker build НЕ является частью визуальной верификации — пользователь собирает Docker самостоятельно.

## 7) Сборка и БД

- **Docker build запрещён** без явного запроса пользователя: не запускать `pnpm build:compose`, `docker compose build` и любые эквивалентные rebuild-команды.
- Не-Docker build разрешён и ожидаем как валидация по затронутым пакетам (предпочитать `pnpm build --filter ...`).
- Для `pnpm build --filter ...` и turbo filter использовать `name` из ближайшего `package.json`, а не имя директории.
- Перед filtered build обязательно проверять реальное имя пакета в `package.json`, если оно не очевидно.
- Типовые соответствия в этом репо: `packages/server` → `flowise`, `packages/components` → `flowise-components`, `packages/ui` → `flowise-ui`, `packages/fb-front` → `@flowise/fb-front`, `packages/whatsapp/builder` → `whatsapp-builder`, `packages/whatsapp/chat` → `whatsapp-chat`, `packages/whatsapp/portal` → `whatsapp-portal`.
- Если filtered build не найден из-за неверного имени пакета, это ошибка оркестрации, а не кода: нужно повторить build с корректным `package.json.name`.
- После завершения полного цикла Conductor разрешён финальный workspace-level turbo build `pnpm build` как итоговая валидация всего контура. Сообщение вида `turbo run build` / `tasks cached` / `0 errors` считать валидным успешным сигналом.
- `pnpm install` разрешён, если менялись зависимости (например, `package.json`/lockfile).
- `pnpm test` запускать только по явному запросу пользователя.
- Просмотр БД (PGWeb): `http://92.113.151.229:8081/`.
- После значимых изменений, влияющих на контекстные артефакты, обновлять `.github/context/*` штатными проектными средствами.

## 8) Агентский контур и инструменты (НОРМАТИВНО)

Два независимых оркестратора: Conductor (полный цикл разработки) и Consilium-Boss (мультимодельный анализ).
Каноничный реестр всех 15 агентов: `.github/agents/AGENTS.md`.
Полные workflow: `.github/agents/Conductor.agent.md`, `.github/agents/Consilium-Boss.agent.md`.

### Скиллы (14 шт.) — ОБЯЗАТЕЛЬНЫ при срабатывании триггера

Каждый агент с доступом к скиллам **ОБЯЗАН** прочитать соответствующий `SKILL.md` **ДО начала работы**, если триггер совпадает. Это не рекомендация, а требование.

| Скилл | Триггер |
|---|---|
| `feature-dev` | Средняя/крупная фича, полный цикл |
| `pr-review-toolkit` | Code review, оценка качества |
| `security-guidance` | Auth, secrets, input validation, SQL/ORM, HTML rendering |
| `docker-diagnostics` | Runtime/infra/container issues |
| `web-artifacts-builder` | Artifact/prototype/front-end demo |
| `octocode-code-forensics` | Навигация по коду, impact analysis, call chains |
| `orchestration-qa` | Валидация агентов/скиллов/MCP/хуков/именования |
| `facebook-observability-lab` | Тюнинг Facebook sync/report loop, env experiments, единый markdown ledger, runtime evidence |
| `playwright-ui-evidence` | UI runtime evidence, complex flows |
| `fb-front-datetime-timezone` | Date/time в fb-front |
| `fb-front-design-system-builder` | Design system governance fb-front |
| `fb-front-theme-darkmode` | Dark/light/system theme fb-front |
| `fb-front-ui-consistency` | Spacing/typography/colors/motion fb-front |
| `fb-front-react-practices` | React hooks/state/perf/a11y в fb-front/whatsapp |

Матрица триггеров с путями к `SKILL.md` — в Conductor и Consilium-Boss.

### MCP-серверы (17 шт.) — использовать при наличии триггера

| Группа | Серверы | Когда |
|---|---|---|
| Ядро (baseline) | `crash`, `task-manager`, `memory` | Всегда при complex flows |
| Анализ/Исследование | `postgres`, `pgtuner`, `context7`, `octocode` | DB/schema, perf, external docs, code forensics |
| UI Evidence | `chrome-devtools`, `playwright` | Runtime UI diagnostics вне каноничного post-change frontend verification path |
| Платформа | `github`, `github-support-docs`, `github-copilot`, `kaggle`, `figma` | PR/issue, docs, design |
| Утилиты | `filesystem`, `mcp-files`, `web/fetch` | File ops, external API docs |

При недоступности MCP — логировать тег деградации и продолжать с fallback.

### Агенты — два пайплайна

**Conductor** (полный цикл): `Planning-subagent` → `Implement-subagent` → `Code-review-subagent` + `Proscons-devils-advocate` + `UI-Governor`.
Матрица обязательного вызова — в Conductor (секция 4).

**Consilium-Boss** (мультимодельный анализ): 4 аналитика (`Consilium-{Sonnet,Opus,Codex,Gemini}`) параллельно → агрегация по 34 параметрам → 4 адвоката дьявола (`Consilium-Devil{,-GPT,-Sonnet,-Gemini}`) параллельно → Final Ruling.
Протокол — в Consilium-Boss.

## 9) Операционные требования (execution rules)

- Зонами вне источника истины для правок считаются: `/home/projects/new-flowise/x-old-projects/`, `/home/projects/new-flowise/user-export/`, `/home/projects/new-flowise/code-export/`, `/home/projects/new-flowise/tmp/`.
- Приоритет исполнения: сначала правки в реальном коде и рабочая функциональность, затем проверки.
- Запрещено начинать задачу с правок тестов до внесения основной логики в код.
- Запрещено подгонять тесты «под проход» в отрыве от реальной исполняемости кода.
- Запрещено запускать Docker build/rebuild (включая `pnpm build:compose`, `docker compose build`) без явного запроса пользователя.
- Если для задачи нужны `test` проверки — сначала запросить у пользователя явное подтверждение.
- Non-Docker build для валидации разрешён без отдельного подтверждения пользователя; Docker build/rebuild по-прежнему запрещён без явного запроса.
- Если изменяется `Entity` (структура полей/типов/связей), требуется миграция или явное обоснование в отчёте, почему миграция не нужна.
- Для рискованных изменений (БД/инфра/конфиг среды) в отчёте указывать краткий rollback-план (1–2 шага).
- Приоритет источников истины: код проекта → внутренняя документация проекта → внешняя документация; при конфликте фиксировать, что выбрано и почему.
- При изменениях `/home/projects/new-flowise/docker/.env` в отчёте перечислять только имена добавленных/изменённых ключей (без значений).
- Результаты code-review должны фиксироваться в контекстных артефактах `.github/context/*` (минимум: итоговый вердикт, ключевые риски, открытые вопросы) штатными проектными средствами.
- Снимок структуры проекта хранить в `/home/projects/new-flowise/.github/context/project-tree.md` и обновлять только при структурных изменениях (новые/удалённые модули, каталоги, роуты-секции, сервисы-секции, миграционные каталоги), а не после каждой задачи.
- Для обновления снимка использовать команду: `bash /home/projects/new-flowise/scripts/generate-project-tree.sh /home/projects/new-flowise /home/projects/new-flowise/.github/context/project-tree.md`.
- В snapshot запрещено включать секреты и env-значения; допустимы только пути/имена файлов по безопасным исключениям.

## 10) Разделение ответственности

- `code-rules` хранит только постоянные кросс-ролевые нормы.
- Ролевые workflow, чеклисты и протоколы исполнения должны храниться в agent-файлах.
- При конфликте: сначала требования пользователя в текущем диалоге, затем этот файл, затем роль-специфичные инструкции агента.
