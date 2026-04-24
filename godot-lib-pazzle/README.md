# Godot Pazzle Vendor Set

Локальные копии репозиториев из `Godot-pazzle.md`. Вложенные `.git` удалены, чтобы файлы оставались частью основного дерева проекта.

Для каждой библиотеки ниже указаны:
- **Что делает** — короткое описание назначения.
- **Компоненты** — ключевые узлы/классы/ресурсы (технические имена) + человеческое объяснение (деревья, мобы, машины, инвентарь и т.д.).
- **Где лежит** — путь к коду и точкам входа внутри этого вендор-сета.

---

## 🧠 Архитектура и логика (база для ИИ)

### 1. godot-state-charts — конечные автоматы (FSM/HSM) на узлах
- **Что делает:** иерархические state-машины как дерево узлов сцены. Состояния, переходы, охранные условия, история — всё через инспектор.
- **Компоненты:**
  - `StateChart`, `State`, `CompoundState`, `ParallelState`, `HistoryState` — состояния персонажа/двери/босса/UI-экрана.
  - `Transition`, `AllOfGuard`, `AnyOfGuard`, `ExpressionGuard` — условные переходы (например, «если HP < 0 → state Dead»).
  - `AnimationPlayerState`, `AnimationTreeState` — синхронизация состояний с анимациями.
- **Где лежит:**
  - Аддон: [alternatives/derkork__godot-statecharts/addons/godot_state_charts/](alternatives/derkork__godot-statecharts/addons/godot_state_charts/)
  - Примеры: [alternatives/derkork__godot-statecharts/godot_state_charts_examples/](alternatives/derkork__godot-statecharts/godot_state_charts_examples/)
  - Доки: [alternatives/derkork__godot-statecharts/docs/](alternatives/derkork__godot-statecharts/docs/)

### 2. beehave — деревья поведения (Behavior Trees) для врагов и NPC
- **Что делает:** AI мобов, боссов, питомцев и патрулей через визуальное дерево узлов.
- **Компоненты:**
  - `BeehaveTree`, `Blackboard` — корень AI и общая «память» моба.
  - Composites: `Sequence`, `Selector`, `SimpleParallel`, `SequenceRandom`, `SelectorRandom`, `SequenceReactive`, `SequenceStar` — порядок принятия решений (атаковать → перезарядиться → отступить).
  - Decorators: `Inverter`, `Repeater`, `Cooldown`, `Delayer`, `Limiter`, `TimeLimiter`, `UntilFail`, `Failer`, `Succeeder` — модификаторы (кулдаун способности, повтор патруля, задержка реакции).
  - Leaves: `ActionLeaf`, `ConditionLeaf`, `BlackboardSet/Has/Erase/Compare` — действия моба (выстрелить, идти к игроку) и проверки (видит ли цель).
  - Debug: панель отладки и метрики дерева.
- **Где лежит:**
  - Аддон: [beehave/addons/beehave/](beehave/addons/beehave/) (узлы — [beehave/addons/beehave/nodes/](beehave/addons/beehave/nodes/))
  - Примеры мобов: [beehave/examples/](beehave/examples/)
  - Тесты: [beehave/test/](beehave/test/)

### 3. godot-steering-ai-framework — стиринг-поведение (движение, погоня, избегание)
- **Что делает:** плавное перемещение агентов: преследование, бегство, обход препятствий, следование за лидером, формации.
- **Компоненты:** `GSAIAgent`, `GSAISteeringBehavior` (Seek, Flee, Pursue, Evade, Arrive, Wander, Separation, Cohesion, Alignment, ObstacleAvoidance, FollowPath, LookWhereYouGo).
- **Человеческими словами:** «бот гонится за игроком, но обходит коробки», «стая мобов держит строй», «машина едет по точкам пути».
- **Где лежит:**
  - Аддон: [godot-steering-ai-framework/godot/addons/com.gdquest.godot-steering-ai-framework/](godot-steering-ai-framework/godot/addons/com.gdquest.godot-steering-ai-framework/)
  - Демки: [godot-steering-ai-framework/godot/Demos/](godot-steering-ai-framework/godot/Demos/)
  - Референс API: [godot-steering-ai-framework/reference.json](godot-steering-ai-framework/reference.json)

### 4. pandora — менеджер игровых данных (RPG-статы, предметы, категории)
- **Что делает:** редактор данных в Godot для предметов, врагов, оружия, скиллов; хранит данные отдельно от кода.
- **Компоненты:**
  - `Pandora` (autoload API), `PandoraEntity`, `PandoraCategory`, `PandoraProperty` — сущности (меч, зелье, монстр) и их свойства (урон, цена, вес).
  - Backend/Storage — сохранение базы данных в `.json`/ресурсы.
  - UI редактора в Godot — таблицы предметов, дерево категорий, импорт/экспорт.
- **Где лежит:**
  - Аддон: [pandora/addons/pandora/](pandora/addons/pandora/) (API — [pandora/addons/pandora/api.gd](pandora/addons/pandora/api.gd), модель — [pandora/addons/pandora/model/](pandora/addons/pandora/model/), UI — [pandora/addons/pandora/ui/](pandora/addons/pandora/ui/))

### 5. gloot — система инвентаря (сетка как в Diablo и слоты)
- **Что делает:** инвентарь, экипировка, сундуки, drag-n-drop, стек предметов, ограничения по весу/размеру.
- **Компоненты:**
  - Core: `Inventory`, `InventoryItem`, `ItemSlot`, `ItemCount`, `StackManager`, `ProtoTree` — модели «рюкзак», «слот шлема», «стопка стрел».
  - Constraints: ограничения веса/размера/совместимости.
  - UI: `CtrlInventory`, `CtrlInventoryGrid`, `CtrlInventoryGridBasic`, `CtrlInventoryUniversal`, `CtrlItemSlot`, `CtrlDraggableInventoryItem`, `CtrlInventoryCapacity` — готовые виджеты Diablo-сетки и слотов экипировки.
- **Где лежит:**
  - Аддон: [gloot/addons/gloot/](gloot/addons/gloot/) (core — [gloot/addons/gloot/core/](gloot/addons/gloot/core/), UI — [gloot/addons/gloot/ui/](gloot/addons/gloot/ui/))
  - Примеры: [gloot/examples/](gloot/examples/)
  - Тесты: [gloot/tests/](gloot/tests/)

### 6. EventBus — глобальная шина событий (паттерн Event Bus)
- **Что делает:** связывает системы (UI ↔ здоровье ↔ звуки) без жёстких зависимостей.
- **Компоненты:** автозагрузка `EventBus`, файл `Events.gd` со списком сигналов, паттерн `EventBus.emit("on_player_died", ...)` / `EventBus.connect(...)`.
- **Человеческими словами:** «моб умер → одной строкой узнают UI, звук, статистика и квесты».
- **Где лежит:**
  - Код: [alternatives/mikica1986vee__EventBus_for_Godot_engine/EventBus/](alternatives/mikica1986vee__EventBus_for_Godot_engine/EventBus/)
  - Каталог сигналов: [alternatives/mikica1986vee__EventBus_for_Godot_engine/Events.gd](alternatives/mikica1986vee__EventBus_for_Godot_engine/Events.gd)
  - Примеры: [alternatives/mikica1986vee__EventBus_for_Godot_engine/Examples/](alternatives/mikica1986vee__EventBus_for_Godot_engine/Examples/)

---

## 📱 Мобильная специфика и управление

### 7. GodotTouchInputManager — жесты для мобильных (свайп, пинч, двойной тап)
- **Что делает:** превращает сырые touch-события в высокоуровневые жесты.
- **Компоненты:**
  - Autoload `InputManager.gd`, утилиты `RawGesture.gd`, `Util.gd`.
  - События в [godot-touch-input-manager/CustomInputEvents/](godot-touch-input-manager/CustomInputEvents/): `InputEventScreenSwipe`, `InputEventScreenPinch`, `InputEventScreenTwist`, `InputEventMultiScreenDrag`, `InputEventSingleScreenTap`, `InputEventSingleScreenLongPress`, `InputEventSingleScreenDrag` и т.д.
- **Человеческими словами:** свайпы по карте, pinch-to-zoom камеры, двойной тап для прицеливания, long-press для контекстного меню.
- **Где лежит:** [godot-touch-input-manager/](godot-touch-input-manager/)

### 8. virtual-joystick-godot — наэкранный джойстик
- **Что делает:** готовый виртуальный стик для управления персонажем/машиной/прицелом на телефоне.
- **Компоненты:** `virtual_joystick.gd`, `virtual_joystick_scene.tscn`, `virtual_joystick_instantiator.gd`, текстуры стика.
- **Где лежит:** [virtual-joystick-godot/addons/virtual_joystick/](virtual-joystick-godot/addons/virtual_joystick/)

### 9. godot-google-play-billing — внутриигровые покупки на Android (IAP)
- **Что делает:** Google Play Billing Library для покупок монет, премиума, подписок.
- **Компоненты:** Android-плагин (Gradle модуль `godot-google-play-billing/`), демо-проект, документация по интеграции.
- **Где лежит:**
  - Плагин: [godot-google-play-billing/godot-google-play-billing/](godot-google-play-billing/godot-google-play-billing/)
  - Демо: [godot-google-play-billing/demo/](godot-google-play-billing/demo/)
  - Доки: [godot-google-play-billing/docs/](godot-google-play-billing/docs/)

### 10. godot_input_helper — универсальный ввод (геймпад/клавиатура/тач)
- **Что делает:** автоопределяет устройство ввода, удобные ребайнды клавиш, подсказки иконок кнопок.
- **Компоненты:**
  - Autoload `InputHelper` (`input_helper.gd`), C#-вариант `InputHelper.cs`.
  - [godot_input_helper/addons/input_helper/components/](godot_input_helper/addons/input_helper/components/) — UI-компоненты (rebind row и пр.).
  - [godot_input_helper/addons/input_helper/views/](godot_input_helper/addons/input_helper/views/) — экраны настройки управления.
  - Иконки кнопок в [godot_input_helper/addons/input_helper/assets/](godot_input_helper/addons/input_helper/assets/).
- **Где лежит:** [godot_input_helper/addons/input_helper/](godot_input_helper/addons/input_helper/)

---

## 💾 Сохранения, данные и бэкенд

### 11. Godot-Save-System — система сохранений
- **Что делает:** сохранение/загрузка прогресса игрока через словари и `ConfigFile`.
- **Компоненты:** `SaveSystem.gd` (API сохранения), `SaveSystem.tscn`, демонстрационная сцена `Game.gd`/`Game.tscn`, файл сохранения `save-file.cfg`.
- **Где лежит:**
  - Код: [alternatives/erdavids__Godot-Save-System/SaveSystem.tscn](alternatives/erdavids__Godot-Save-System/SaveSystem.tscn), [alternatives/erdavids__Godot-Save-System/Scenes/](alternatives/erdavids__Godot-Save-System/Scenes/)

### 12. GodotFirebase — Firebase для Godot (auth, firestore, storage, аналитика)
- **Что делает:** облачные сохранения, авторизация, аналитика, Remote Config, push-уведомления.
- **Компоненты:**
  - `firebase/` — базовая точка входа и общий клиент Firebase.
  - `auth/` + `auth/providers/` — email/social авторизация.
  - `firestore/` + `field_transforms/` — документная база данных.
  - `database/` — Realtime Database.
  - `storage/` — файлы и облачные ассеты.
  - `functions/`, `dynamiclinks/`, `remote_config/`, `queues/` — serverless-функции, deep links, Remote Config и фоновые задачи.
  - `http-sse-client/` — HTTP SSE-клиент для стриминга событий.
- **Где лежит:**
  - Firebase аддон: [GodotFirebase/addons/godot-firebase/](GodotFirebase/addons/godot-firebase/)
  - SSE клиент: [GodotFirebase/addons/http-sse-client/](GodotFirebase/addons/http-sse-client/)
  - iOS-плагин: [GodotFirebase/ios_plugins/](GodotFirebase/ios_plugins/)

### 13. nakama-godot — мультиплеер, лидерборды, кланы (Heroic Labs Nakama)
- **Что делает:** клиент к Nakama-серверу: матчмейкинг, чат, дружбы, лидерборды, турниры, RT-сокет, Satori (A/B и эксперименты).
- **Компоненты:**
  - `Nakama.gd` — точка входа клиента.
  - `client/` — REST API; `socket/` — realtime (матчи, чат, статусы).
  - `api/` — DTO; `utils/` — вспомогательные.
  - `Satori.gd` + `Satori/` — экспериментирование/фиче-флаги.
- **Где лежит:** [nakama-godot/addons/com.heroiclabs.nakama/](nakama-godot/addons/com.heroiclabs.nakama/)

---

## 🎨 UI, диалоги и «сок» (juice)

### 14. phantom-camera — кинематографичная камера (2D/3D)
- **Что делает:** виртуальные камеры с приоритетами, плавный follow, look-at, тряска экрана, dead-zone, цели по нескольким объектам.
- **Компоненты:**
  - `PhantomCamera2D`, `PhantomCamera3D`, `PhantomCameraHost` — узлы виртуальных камер и хост.
  - Скрипты: [phantom-camera/addons/phantom_camera/scripts/phantom_camera/](phantom-camera/addons/phantom_camera/scripts/phantom_camera/), [phantom-camera/addons/phantom_camera/scripts/phantom_camera_host/](phantom-camera/addons/phantom_camera/scripts/phantom_camera_host/), `managers/`, `resources/`, `gizmos/`.
  - Inspector-панель и темы для редактора.
- **Человеческими словами:** «камера тряхнётся при взрыве», «плавно зумится при прицеливании», «переключилась на катсцену».
- **Где лежит:** [phantom-camera/addons/phantom_camera/](phantom-camera/addons/phantom_camera/)

### 15. godot_dialogue_manager — система диалогов на текстовых файлах
- **Что делает:** ветвящиеся диалоги, выборы, переменные, локализация; формат удобен Copilot для генерации.
- **Компоненты:**
  - Ядро: `dialogue_manager.gd`/`DialogueManager.cs`, `dialogue_resource.gd`, `dialogue_line.gd`, `dialogue_response.gd`, `dialogue_processor.gd`.
  - Компилятор `.dialogue`-файлов: [godot_dialogue_manager/addons/dialogue_manager/compiler/](godot_dialogue_manager/addons/dialogue_manager/compiler/)
  - UI компоненты: [godot_dialogue_manager/addons/dialogue_manager/components/](godot_dialogue_manager/addons/dialogue_manager/components/) и пример воздушного шарика [godot_dialogue_manager/addons/dialogue_manager/example_balloon/](godot_dialogue_manager/addons/dialogue_manager/example_balloon/).
  - Импорт/экспорт/локализация (`import_plugin.gd`, `export_plugin.gd`, `editor_translation_parser_plugin.gd`, `l10n/`).
- **Где лежит:** [godot_dialogue_manager/addons/dialogue_manager/](godot_dialogue_manager/addons/dialogue_manager/)

### 16. godot_sound_manager — пул звуков, музыка, эмбиент
- **Что делает:** менеджеры звуковых эффектов и музыки с пулом плееров и кроссфейдами.
- **Компоненты:**
  - Autoload `SoundManager` (`sound_manager.gd` / `SoundManager.cs`).
  - `sound_effects.gd` — пул SFX (выстрелы, шаги, удары).
  - `music.gd` — кроссфейд между треками.
  - `ambient_sounds.gd` — окружение (ветер, дождь, толпа).
  - `abstract_audio_player_pool.gd` — базовый пул `AudioStreamPlayer`.
- **Где лежит:** [godot_sound_manager/addons/sound_manager/](godot_sound_manager/addons/sound_manager/)

### 17. scene_manager — переходы между сценами (затемнение, пиксели, шторки)
- **Что делает:** анимированные переходы при загрузке уровней + менеджер списка сцен.
- **Компоненты:**
  - Autoload `SceneManager` (`scene_manager.gd`, сцена `scene_manager.tscn`).
  - Шейдер переходов `scene_manager.gdshader` + 12 паттернов в [scene_manager/addons/scene_manager/shader_patterns/](scene_manager/addons/scene_manager/shader_patterns/) (circle, curtains, diagonal, dirt, horizontal, pixel, radial, scribbles, splashed_dirt, squares, vertical, crooked_tiles).
  - Редактор списка сцен: `scene_list.gd/tscn`, `scene_item.gd/tscn`, `sub_section.gd/tscn`.
- **Человеческими словами:** «затемнение перед боссом», «пиксельный переход в меню», «шторки между уровнями».
- **Где лежит:** [scene_manager/addons/scene_manager/](scene_manager/addons/scene_manager/)

### 18. godot-tween-sequence — упрощение Tween-анимаций
- **Что делает:** удобный API для последовательных и параллельных Tween-цепочек (всплывающий урон, дрожание UI, анимации меню).
- **Компоненты:**
  - `TweenSequence.cs` — последовательные и параллельные цепочки анимаций.
  - `TweenBuilder.cs`, `TweenBuilderBase.cs`, `VirtualBuilder.cs` — fluent builder для tween-сценариев.
  - `PathBuilder.cs` — анимации вдоль пути.
  - `GoTween.cs`, `GoTweenExtensions.cs`, `GoTween.TweenGroups.cs`, `GoTween.Queries.cs` — ядро API, группировка и запросы к активным tween'ам.
- **Где лежит:**
  - Загруженная замена: [alternatives/okefonok__GoTween/](alternatives/okefonok__GoTween/)
  - Исходники: [alternatives/okefonok__GoTween/GoTween/](alternatives/okefonok__GoTween/GoTween/)

---

## ⚙️ Инструменты для работы с ИИ (тесты и дебаг)

### 19. Gut (Godot Unit Test) — фреймворк юнит-тестов
- **Что делает:** unit/integration тесты, моки и стабы (doubles), параметризированные тесты, CLI-раннер.
- **Компоненты:**
  - Раннер `GutScene.tscn`, `cli/`, `awaiter.gd`.
  - `doubler.gd`, `double_tools.gd`, `double_templates/` — моки.
  - `comparator.gd`, `compare_result.gd`, `diff_tool.gd`, `diff_formatter.gd` — ассерты и сравнения.
  - `collected_test.gd`, `collected_script.gd` — сбор тестов.
  - `UserFileViewer.tscn` — просмотр файлов пользователя при отладке.
- **Где лежит:** [gut/addons/gut/](gut/addons/gut/)

### 20. panku-console — внутриигровая консоль разработчика
- **Что делает:** REPL прямо в работающей игре: выполнять GDScript, читерить, дёргать функции, смотреть переменные на телефоне.
- **Компоненты:**
  - Autoload `PankuConsole` (`console.gd` / `console.tscn`).
  - Модули: [alternatives/Ark2000__PankuConsole/addons/panku_console/modules/](alternatives/Ark2000__PankuConsole/addons/panku_console/modules/) (логи, виджеты, REPL, отладка переменных, перформанс).
  - Конфиг по умолчанию: `default_panku_config.cfg`.
- **Где лежит:** [alternatives/Ark2000__PankuConsole/addons/panku_console/](alternatives/Ark2000__PankuConsole/addons/panku_console/)

### 21. godot-logger — продвинутое логирование
- **Что делает:** уровни логов (DEBUG/INFO/WARN/ERROR/FATAL), модули, формат, запись в файл — для краш-логов на Android.
- **Компоненты:** autoload `Logger` (`logger.gd`), `plugin.gd`/`plugin.cfg`.
- **Где лежит:** [alternatives/KOBUGE-Games__godot-logger/](alternatives/KOBUGE-Games__godot-logger/) (основной файл — [alternatives/KOBUGE-Games__godot-logger/logger.gd](alternatives/KOBUGE-Games__godot-logger/logger.gd))

### 22. godot-ci — CI/CD шаблоны (GitHub Actions, Docker, Gitea)
- **Что делает:** контейнеры с Godot для автосборки `.apk`/Web/desktop в CI.
- **Компоненты:**
  - `Dockerfile` (стандарт), `mono.Dockerfile` (C#), `action.yml` (GitHub Action).
  - `getbutler.sh` — деплой в itch.io через Butler.
  - `get_dotnet_version.sh`, `gitea-godot-ci.yml`, `test-project/`.
- **Где лежит:** [godot-ci/](godot-ci/)

---

## 🚀 Физика и производительность

### 23. godot-rapier-physics — Rust-физика 2D/3D на движке Rapier
- **Что делает:** замена встроенной физики Godot. Стабильнее и быстрее на сценах с тысячами тел (бульки, частицы, Vampire-Survivors-стиль).
- **Компоненты:**
  - Rust-исходники: [alternatives/appsinacup__godot-rapier-physics/src/](alternatives/appsinacup__godot-rapier-physics/src/).
  - Сборки 2D: [alternatives/appsinacup__godot-rapier-physics/bin2d/](alternatives/appsinacup__godot-rapier-physics/bin2d/), 3D: [alternatives/appsinacup__godot-rapier-physics/bin3d/](alternatives/appsinacup__godot-rapier-physics/bin3d/).
  - Доки: [alternatives/appsinacup__godot-rapier-physics/docs/](alternatives/appsinacup__godot-rapier-physics/docs/).
  - В Godot задаётся через Project Settings → Physics → 2D/3D Physics Engine = Rapier.
- **Где лежит:** [alternatives/appsinacup__godot-rapier-physics/](alternatives/appsinacup__godot-rapier-physics/)

### 24. godot-jolt — 3D-физика на движке Jolt
- **Что делает:** замена 3D-физики Godot движком Jolt (быстрее, стабильнее для машин, рэгдоллов, толпы).
- **Компоненты:**
  - C++ исходники модуля: [godot-jolt/src/](godot-jolt/src/).
  - Сборка через CMake (`CMakeLists.txt`, `CMakePresets.json`, `cmake/`, `tools/`).
  - Примеры/доки: [godot-jolt/examples/](godot-jolt/examples/), [godot-jolt/docs/](godot-jolt/docs/).
- **Где лежит:** [godot-jolt/](godot-jolt/)

---

## 🏗 Шаблоны и генерация

### 25. godot-game-template — каркас игры (меню, настройки, пауза, переходы)
- **Что делает:** готовый скелет: главное меню, экран настроек звука, пауза, навигация по сценам, отладочные хоткеи.
- **Компоненты:**
  - `ggt-core` — менеджер сцен и переходов:
    - [godot-game-template/addons/ggt-core/scenes/](godot-game-template/addons/ggt-core/scenes/) (`scene-data.gd`, `scenes-history.gd`).
    - [godot-game-template/addons/ggt-core/transitions/](godot-game-template/addons/ggt-core/transitions/) (`transitions.gd/tscn`, `progress.gd`).
    - `config.tres` (главные настройки шаблона), `utils/`.
  - `ggt-debug-shortcuts` — отладочные клавиши:
    - [godot-game-template/addons/ggt-debug-shortcuts/autoload/](godot-game-template/addons/ggt-debug-shortcuts/autoload/) (`debug_shortcuts.gd/tscn`).
- **Где лежит:** [godot-game-template/](godot-game-template/)

### 26. scatter — процедурная расстановка объектов (деревья, камни, враги)
- **Что делает:** правила раскидывания префабов по форме (растительность, разрушаемые ящики, спавн-точки мобов).
- **Компоненты:**
  - Узлы: `ProtonScatter`, `ScatterItem`, `ScatterShape` (исходники — [scatter/addons/proton_scatter/src/](scatter/addons/proton_scatter/src/)).
  - `shapes/` — формы зон (бокс, сфера, путь, mesh).
  - `modifiers/` — модификаторы расстановки (плотность, вращение, отбраковка).
  - `particles/` — рендер через MultiMesh/частицы.
  - `presets/` — готовые пресеты (леса, города, разброс врагов).
  - Демо: [scatter/addons/proton_scatter/demos/](scatter/addons/proton_scatter/demos/).
- **Где лежит:** [scatter/addons/proton_scatter/](scatter/addons/proton_scatter/)

### 27. godot-accessibility — экранный диктор и доступность
- **Что делает:** озвучивание UI экранным диктором; буст видимости в Google Play за accessibility.
- **Компоненты:** autoload `Accessible.gd`, `Plugin.gd`, `ScreenReader.gd`.
- **Где лежит:** [godot-accessibility/](godot-accessibility/)

### 28. Godot-Component-System (ECS) — паттерн Entity-Component
- **Что делает:** строит сущности из компонентов (HealthComponent, DamageComponent, MovementComponent) — чистый и переиспользуемый код.
- **Компоненты:**
  - `gameObject.gd`, `baseGameObject.gd` — сущности/объекты игры.
  - `component.gd` — базовый класс компонента.
  - `gameSystem.gd`, `baseGameSystem.gd` — системы обработки компонентов.
  - `gameWorld.gd`, `baseGameWorld.gd` — игровой мир и жизненный цикл ECS.
  - `uuid.gd` — генерация уникальных идентификаторов сущностей.
- **Где лежит:**
  - Загруженная замена: [alternatives/Beliar83__godot-component-system-asset/](alternatives/Beliar83__godot-component-system-asset/)
  - Аддон ECS: [alternatives/Beliar83__godot-component-system-asset/addons/gcs/](alternatives/Beliar83__godot-component-system-asset/addons/gcs/)
  - UUID helper: [alternatives/Beliar83__godot-component-system-asset/addons/uuid/](alternatives/Beliar83__godot-component-system-asset/addons/uuid/)

---

## Карта замен (alternatives/)

Эти библиотеки скачаны под другим именем, потому что оригинальные ссылки не открывались:

| Из заметки | Использовано вместо | Папка |
|---|---|---|
| `derkyle/godot-state-charts` | `derkork/godot-statecharts` | [alternatives/derkork__godot-statecharts/](alternatives/derkork__godot-statecharts/) |
| `AnidemDex/Godot-EventBus` | `mikica1986vee/EventBus_for_Godot_engine` | [alternatives/mikica1986vee__EventBus_for_Godot_engine/](alternatives/mikica1986vee__EventBus_for_Godot_engine/) |
| `Yagich/Godot-Save-System` | `erdavids/Godot-Save-System` | [alternatives/erdavids__Godot-Save-System/](alternatives/erdavids__Godot-Save-System/) |
| `kurotori4423/panku-console` | `Ark2000/PankuConsole` | [alternatives/Ark2000__PankuConsole/](alternatives/Ark2000__PankuConsole/) |
| `Scony/godot-logger` | `KOBUGE-Games/godot-logger` | [alternatives/KOBUGE-Games__godot-logger/](alternatives/KOBUGE-Games__godot-logger/) |
| `godot-rapier/godot-rapier-2d` | `appsinacup/godot-rapier-physics` | [alternatives/appsinacup__godot-rapier-physics/](alternatives/appsinacup__godot-rapier-physics/) |
| `awesomemau/godot-tween-sequence` | `okefonok/GoTween` | [alternatives/okefonok__GoTween/](alternatives/okefonok__GoTween/) |
| `baconandgames/godot-component-system` | `Beliar83/godot-component-system-asset` | [alternatives/Beliar83__godot-component-system-asset/](alternatives/Beliar83__godot-component-system-asset/) |

Сейчас все 28 пунктов из списка представлены в дереве: либо точным репозиторием, либо локальной заменой в `alternatives/`.
