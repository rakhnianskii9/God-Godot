# Copilot Instructions (Default Behavior)

Этот файл действует автоматически для ВСЕХ сессий, включая обычный чат без агентов.
Для полного цикла разработки используй `@Conductor`. Для сложных архитектурных решений — `@Consilium-Boss`.

## Базовые правила

- Язык коммуникации — русский.
- Часовой пояс: `Asia/Ho_Chi_Minh` (Nha Trang).
- Системные сообщения/логи не переводить.
- Команды давать copy-ready.
- Быть честным и прямым, не подстраиваться под ожидаемый ответ.

## Кодовые стандарты

- Полные правила: `.github/instructions/code-rules.instructions.md`.
- SQL column names: `snake_case` + `@Column({ name: ... })`.
- Миграции регистрировать в `packages/server/src/database/migrations/postgres/index.ts`.
- FK типы должны совпадать с PK связанной сущности.
- `packages/fb-front` — Flowbite + Tailwind. `packages/ui` — MUI. Не смешивать.

## Запреты

- Docker build/rebuild запрещён.
- Откаты (`git reset`, `git restore`, `git clean`) без подтверждения запрещены.
- Фейковые данные/placeholder конфигурации запрещены.
- Секреты в env-файлах не менять без прямого запроса.
- Env-файлы только в `/home/projects/new-flowise/docker/.env`.

## Карта проекта

| Пакет | Назначение | Стек |
|---|---|---|
| `packages/server` | Backend API + Agentflow engine | Node/TS, Express, TypeORM, PostgreSQL, Redis, BullMQ |
| `packages/fb-front` | Frontend (основной) | React, Vite, Tailwind, Flowbite |
| `packages/ui` | Frontend (legacy Flowise) | React, MUI |
| `packages/components` | Flowise nodes (LLM, Tools, Agents) | LangChain, Node/TS |
| `packages/whatsapp` | WhatsApp UI компонент | React |
| `packages/api-documentation` | API docs (Swagger) | — |

## Документация

- Внутренние docs: `/home/projects/new-flowise/docs` (искать здесь ПЕРВЫМ).
- Новые docs модулей: `/home/projects/new-flowise/docs/moduls` (max 1 файл на модуль).
- Контекстные артефакты: `.github/context/*`.
- Планы: `/home/projects/new-flowise/plans/`.

## Маршрутизация агентов

| Когда | Агент |
|---|---|
| Полный цикл разработки (plan → implement → review) | `@Conductor` |
| Сложные архитектурные решения, споры, мультимодельный анализ | `@Consilium-Boss` |
| Адверсариальное ревью, поиск скрытых проблем | `@Proscons-devils-advocate` (через Conductor) |
| UI компоненты fb-front | `@UI-Governor` (через Conductor) |

## Memory Protocol (каждая сессия)

1. **Старт**: `memory/retrieve_with_quality_boost` — загрузить контекст прошлых сессий.
2. **В процессе**: важные находки запоминать через `memory/store_memory` с тегами.
3. **Конец**: сохранить дurable facts (архитектурные решения, верифицированные паттерны, рабочие команды).
4. **Теги**: `project:<area>`, `pattern:<name>`, `bug:<module>`, `decision:<topic>`.

## AI Naming Policy

Формат моделей: `Model Name (vendor)`. Примеры: `Claude Opus 4.6 (copilot)`, `GPT-5.3-Codex (copilot)`.
Сокращённые/самодельные имена запрещены.
