# Copilot Instructions (Default Behavior)

Этот файл действует автоматически для всех сессий в текущем workspace `/home/projects/gamedev`.

Полные кросс-ролевые нормы находятся в `.github/instructions/code-rules.instructions.md`.

## Базовые правила

- Язык коммуникации — русский.
- Системные сообщения и логи не переводить без явного запроса пользователя.
- Команды, пути и последовательности действий давать copy-ready.
- Быть честным и прямым: если что-то не проверено, так и говорить.

## Фокус проекта

- Основной исполняемый проект — `/home/projects/gamedev/my-game/`.
- `my-game/my-game.godot` — текущий Godot project file; основной entry point сейчас идёт через `res://scenes/main.tscn`.
- `/home/projects/gamedev/godot-lib-pazzle/` — vendor/reference-набор библиотек и примеров для точечной интеграции в `my-game`.
- `/home/projects/gamedev/godot-lib-pazzle/README.md` — первая точка входа для выбора готового компонента, стартового стека и локальных замен в `alternatives/`.
- Для игровых задач по умолчанию сначала исследовать и править `my-game`, а не vendor-репозитории.

## Оркестрация

- В текущем `.github/agents/` реально присутствует `@Consilium-Boss` и его подагенты `Consilium-*`.
- Для сложных архитектурных решений, спорных подходов и мультимодельного анализа использовать `@Consilium-Boss`.
- Не ссылаться на `@Conductor`, `@UI-Governor` или `.github/agents/AGENTS.md` как на существующие элементы, пока они реально не добавлены в репозиторий.
- Для правок в `.github/instructions/**`, `.github/agents/**`, `.github/hooks/**` и других control-plane файлах сначала читать skill `orchestration-qa`.
- Для code forensics, impact analysis и поиска реального управляющего пути сначала читать skill `octocode-code-forensics`.

## Hooks

- В workspace уже работают guardrails из `.github/hooks/pretool-guard.sh`, `.github/hooks/posttool-quality.sh` и `.github/hooks/posttool-security.sh`.
- Если инструкция описывает поведение hooks, оно должно совпадать с реальными shell-скриптами, а не с устаревшими markdown-summary.

## Рабочие правила

- Править только необходимый срез и не расширять задачу без причины.
- Для GDScript сохранять стиль конкретного затронутого файла; не делать массовую синтаксическую миграцию без запроса пользователя.
- Vendor-библиотеки сначала читать как reference. Внутри них править только если задача действительно требует изменения vendored copy.
- Не навязывать этому workspace Flowise/React/TypeORM/pnpm-подходы, если задача относится к Godot-части проекта.

## Запреты

- Destructive git-команды (`git reset`, `git restore`, `git clean`, `git checkout -- ...`) без явного запроса пользователя запрещены.
- Container image builds (`docker build`, `docker compose build`, `docker-compose build`, `podman build`) без явного запроса пользователя запрещены.
- Фейковые данные, placeholder-конфиги и правки реальных секретов без прямого запроса пользователя запрещены.

## Документация и валидация

- В этом workspace нет единого общего `/docs` для всего проекта; сначала искать ближайшие `README.md`, `docs/`, `examples/` и demo-scenes рядом с затронутой областью.
- Для выбора готового решения в локальном vendor set сначала смотреть `godot-lib-pazzle/README.md`, потом уже README/docs/examples конкретной библиотеки.
- Для внешних библиотек и SDK использовать Context7 и официальные источники.
- После правок запускать самый узкий доступный check для затронутого среза. Если `godot`, `godot4`, `gdlint` или `dotnet` недоступны, это нужно явно указывать, а не имитировать успешную проверку.

## AI Naming Policy

- Формат моделей: `Model Name (vendor)`.
- Сокращённые и самодельные имена моделей запрещены.
