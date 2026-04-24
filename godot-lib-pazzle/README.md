# Godot Pazzle Vendor Set for my-game

`godot-lib-pazzle/` в этом workspace не является отдельной игрой. Это локальный вендор-набор и каталог референсов для текущего проекта в [../my-game/](../my-game/).

Сейчас `my-game/` минимален: там есть базовый проект Godot, одна сцена и один стартовый скрипт. Поэтому смысл этой папки простой: здесь собраны готовые системы, которые можно быстро изучать, сравнивать и точечно переносить в текущую игру по мере роста проекта.

## Что здесь где

| Путь | Роль в workspace |
|---|---|
| [../my-game/](../my-game/) | текущий игровой проект |
| [./](./) | локальный набор аддонов, шаблонов и референсных репозиториев |
| [alternatives/](alternatives/) | локальные замены для источников, которые не удалось взять по исходной ссылке |

## Как пользоваться этим каталогом

1. Начинай не с библиотеки, а с задачи в `my-game`: инвентарь, AI, камера, диалоги, мобильный ввод, сохранения.
2. Для выбранной задачи открывай у нужной библиотеки в первую очередь `addons/`, `examples/`, `docs/` и тесты, если они есть.
3. Не пытайся интегрировать весь набор сразу. Бери один основной инструмент на одну зону ответственности: одну FSM, одну систему инвентаря, одну систему диалогов и так далее.
4. `alternatives/` используй как источник кода и сравнения API, а не как место для бездумного копирования всего подряд.
5. Если библиотека решает ту же задачу, что уже покрыта другой библиотекой из списка, сначала выбирай одну основную, а вторую держи как fallback или источник идей.

## Рекомендуемый стартовый стек для текущего проекта

| Зона | Что брать первым | Зачем |
|---|---|---|
| Состояния и flow | `godot-statecharts` | игрок, враги, двери, UI-экраны, фазы босса |
| AI врагов | `beehave` + `godot-steering-ai-framework` | решения + движение |
| Данные и предметы | `pandora` + `gloot` | игровые данные отдельно от кода + инвентарь |
| Диалоги и подача | `godot_dialogue_manager`, `phantom-camera`, `godot_sound_manager`, `GoTween` | быстрый прирост качества презентации |
| Управление и mobile | `godot_input_helper`, `virtual-joystick-godot`, `godot-touch-input-manager` | единый ввод и мобильные жесты |
| Сохранения и онлайн | `Godot-Save-System`, `GodotFirebase`, `nakama-godot` | локальный прогресс, облако, мультиплеер |
| Тесты и дебаг | `gut`, `panku-console`, `godot-logger` | быстрая диагностика и регресс-контроль |

## Карта библиотек

### Архитектура, gameplay и AI

- `godot-statecharts` — конечные автоматы и иерархические состояния. Для текущего проекта это первая точка входа для поведения игрока, врагов, интерактивных объектов и UI flow. Смотреть: [alternatives/derkork__godot-statecharts/addons/godot_state_charts/](alternatives/derkork__godot-statecharts/addons/godot_state_charts/), [alternatives/derkork__godot-statecharts/godot_state_charts_examples/](alternatives/derkork__godot-statecharts/godot_state_charts_examples/), [alternatives/derkork__godot-statecharts/docs/](alternatives/derkork__godot-statecharts/docs/).
- `beehave` — behavior trees для врагов, NPC и scripted encounters. Полезен там, где простого FSM уже мало и нужен выбор из нескольких тактик. Смотреть: [beehave/addons/beehave/](beehave/addons/beehave/), [beehave/examples/](beehave/examples/), [beehave/test/](beehave/test/).
- `godot-steering-ai-framework` — стиринг для преследования, избегания, wander и движения по траектории. Хорошо дополняет `beehave`, когда у врага есть и решение, и сложная моторика. Смотреть: [godot-steering-ai-framework/godot/addons/com.gdquest.godot-steering-ai-framework/](godot-steering-ai-framework/godot/addons/com.gdquest.godot-steering-ai-framework/), [godot-steering-ai-framework/godot/Demos/](godot-steering-ai-framework/godot/Demos/), [godot-steering-ai-framework/reference.json](godot-steering-ai-framework/reference.json).
- `pandora` — база игровых сущностей и свойств: предметы, оружие, враги, скиллы. Подходит, если хочется держать баланс и контент отдельно от скриптов `my-game`. Смотреть: [pandora/addons/pandora/](pandora/addons/pandora/), [pandora/addons/pandora/model/](pandora/addons/pandora/model/), [pandora/addons/pandora/ui/](pandora/addons/pandora/ui/).
- `gloot` — инвентарь, экипировка, гриды, слоты, стаки и ограничения. Бери, если в `my-game` появляются предметы, рюкзак, сундуки или экипировка. Смотреть: [gloot/addons/gloot/](gloot/addons/gloot/), [gloot/addons/gloot/core/](gloot/addons/gloot/core/), [gloot/addons/gloot/ui/](gloot/addons/gloot/ui/), [gloot/examples/](gloot/examples/).
- `EventBus` — простая шина событий для развязки систем. Полезна, если UI, звук, квесты и статистика не должны знать друг о друге напрямую. Смотреть: [alternatives/mikica1986vee__EventBus_for_Godot_engine/EventBus/](alternatives/mikica1986vee__EventBus_for_Godot_engine/EventBus/), [alternatives/mikica1986vee__EventBus_for_Godot_engine/Events.gd](alternatives/mikica1986vee__EventBus_for_Godot_engine/Events.gd), [alternatives/mikica1986vee__EventBus_for_Godot_engine/Examples/](alternatives/mikica1986vee__EventBus_for_Godot_engine/Examples/).

### Ввод и мобильная специфика

- `godot-touch-input-manager` — высокоуровневые touch-жесты: swipe, pinch, twist, tap, long-press. Нужен, если `my-game` целится в mobile и обычных `InputEventScreenTouch` уже мало. Смотреть: [godot-touch-input-manager/](godot-touch-input-manager/), [godot-touch-input-manager/CustomInputEvents/](godot-touch-input-manager/CustomInputEvents/).
- `virtual-joystick-godot` — виртуальный джойстик для экрана. Подходит для мобильного управления персонажем, камерой или прицелом. Смотреть: [virtual-joystick-godot/addons/virtual_joystick/](virtual-joystick-godot/addons/virtual_joystick/).
- `godot-google-play-billing` — Android IAP через Google Play Billing. Нужен только если в проекте действительно будут покупки или подписки. Смотреть: [godot-google-play-billing/godot-google-play-billing/](godot-google-play-billing/godot-google-play-billing/), [godot-google-play-billing/demo/](godot-google-play-billing/demo/), [godot-google-play-billing/docs/](godot-google-play-billing/docs/).
- `godot_input_helper` — единый слой ввода для клавиатуры, геймпада и тача, плюс rebinding и UI-подсказки. Хорошая базовая библиотека, если хочется нормализовать управление на раннем этапе. Смотреть: [godot_input_helper/addons/input_helper/](godot_input_helper/addons/input_helper/), [godot_input_helper/addons/input_helper/components/](godot_input_helper/addons/input_helper/components/), [godot_input_helper/addons/input_helper/views/](godot_input_helper/addons/input_helper/views/).

### Сохранения, сервисы и онлайн

- `Godot-Save-System` — простая локальная система сохранений. Подходит как быстрый старт до появления более сложного persistence-слоя. Смотреть: [alternatives/erdavids__Godot-Save-System/SaveSystem.tscn](alternatives/erdavids__Godot-Save-System/SaveSystem.tscn), [alternatives/erdavids__Godot-Save-System/Scenes/](alternatives/erdavids__Godot-Save-System/Scenes/).
- `GodotFirebase` — Firebase для авторизации, облачных данных, аналитики, storage, remote config и прочих сервисов. Подходит, если проекту нужны облачные фичи без собственного backend. Смотреть: [GodotFirebase/addons/godot-firebase/](GodotFirebase/addons/godot-firebase/), [GodotFirebase/addons/http-sse-client/](GodotFirebase/addons/http-sse-client/), [GodotFirebase/ios_plugins/](GodotFirebase/ios_plugins/).
- `nakama-godot` — клиент Heroic Labs Nakama для матчей, чата, лидербордов и realtime-сокетов. Имеет смысл, если проект идёт в мультиплеер или social features. Смотреть: [nakama-godot/addons/com.heroiclabs.nakama/](nakama-godot/addons/com.heroiclabs.nakama/).

### Камера, UI, диалоги и подача

- `phantom-camera` — виртуальные камеры, приоритеты, follow, look-at, shake и кинематографичная подача. Это один из самых полезных источников качества для боёв, катсцен и exploration-сцен. Смотреть: [phantom-camera/addons/phantom_camera/](phantom-camera/addons/phantom_camera/), [phantom-camera/addons/phantom_camera/scripts/phantom_camera/](phantom-camera/addons/phantom_camera/scripts/phantom_camera/), [phantom-camera/addons/phantom_camera/scripts/phantom_camera_host/](phantom-camera/addons/phantom_camera/scripts/phantom_camera_host/).
- `godot_dialogue_manager` — текстовые ветвящиеся диалоги с переменными, выборами и локализацией. Хороший кандидат, если в `my-game` будут NPC, квестовые разговоры или story flow. Смотреть: [godot_dialogue_manager/addons/dialogue_manager/](godot_dialogue_manager/addons/dialogue_manager/), [godot_dialogue_manager/addons/dialogue_manager/compiler/](godot_dialogue_manager/addons/dialogue_manager/compiler/), [godot_dialogue_manager/addons/dialogue_manager/components/](godot_dialogue_manager/addons/dialogue_manager/components/).
- `godot_sound_manager` — централизованный менеджер музыки, SFX и ambience. Подходит, если нужно быстро навести порядок в аудио и избежать ручного спавна `AudioStreamPlayer` по всему проекту. Смотреть: [godot_sound_manager/addons/sound_manager/](godot_sound_manager/addons/sound_manager/).
- `scene_manager` — менеджер переходов между сценами с готовыми эффектами. Полезен, когда проект перестаёт быть одной сценой и появляются уровни, меню и загрузочные переходы. Смотреть: [scene_manager/addons/scene_manager/](scene_manager/addons/scene_manager/), [scene_manager/addons/scene_manager/shader_patterns/](scene_manager/addons/scene_manager/shader_patterns/).
- `godot-tween-sequence` через `GoTween` — удобный API для tween-цепочек и grouped animations. Хорошо подходит для UI-реакций, подсказок, combat feedback и motion polish. Смотреть: [alternatives/okefonok__GoTween/](alternatives/okefonok__GoTween/), [alternatives/okefonok__GoTween/GoTween/](alternatives/okefonok__GoTween/GoTween/).

### Тесты, отладка и эксплуатация

- `gut` — главный кандидат для unit и integration тестов в Godot. Если появится реальная логика в `my-game`, это базовый инструмент для регрессий. Смотреть: [gut/addons/gut/](gut/addons/gut/).
- `panku-console` — внутриигровая консоль разработчика и REPL. Удобна для debug-сборок, когда нужно быстро дёргать функции и смотреть состояние мира. Смотреть: [alternatives/Ark2000__PankuConsole/addons/panku_console/](alternatives/Ark2000__PankuConsole/addons/panku_console/), [alternatives/Ark2000__PankuConsole/addons/panku_console/modules/](alternatives/Ark2000__PankuConsole/addons/panku_console/modules/).
- `godot-logger` — логирование с уровнями и выводом в файл. Полезно, если проект идёт на Android или нужен стабильный crash trail. Смотреть: [alternatives/KOBUGE-Games__godot-logger/](alternatives/KOBUGE-Games__godot-logger/), [alternatives/KOBUGE-Games__godot-logger/logger.gd](alternatives/KOBUGE-Games__godot-logger/logger.gd).
- `godot-ci` — шаблоны CI/CD для автосборки Godot-проектов. Это не геймплейная библиотека, а инфраструктурный референс. Смотреть: [godot-ci/](godot-ci/).

### Физика и производительность

- `godot-rapier-physics` — альтернатива встроенной физике Godot для 2D и 3D через Rapier. Имеет смысл исследовать при большом количестве тел или если штатная физика упрётся в стабильность/производительность. Смотреть: [alternatives/appsinacup__godot-rapier-physics/](alternatives/appsinacup__godot-rapier-physics/), [alternatives/appsinacup__godot-rapier-physics/docs/](alternatives/appsinacup__godot-rapier-physics/docs/).
- `godot-jolt` — 3D-физика на Jolt. Актуально, если проект уходит в сложный 3D, транспорт, ragdoll или тяжёлую физику сцены. Смотреть: [godot-jolt/](godot-jolt/), [godot-jolt/docs/](godot-jolt/docs/), [godot-jolt/examples/](godot-jolt/examples/).

### Шаблоны, генерация и специальные плагины

- `godot-game-template` — каркас игры с переходами, меню и debug-shortcuts. Используй как источник архитектурных решений, а не как обязательную базу. Смотреть: [godot-game-template/](godot-game-template/), [godot-game-template/addons/ggt-core/scenes/](godot-game-template/addons/ggt-core/scenes/), [godot-game-template/addons/ggt-core/transitions/](godot-game-template/addons/ggt-core/transitions/).
- `scatter` — процедурная расстановка объектов, декора, растительности и spawn-паттернов. Полезен, если уровни начнут собираться полуавтоматически. Смотреть: [scatter/addons/proton_scatter/](scatter/addons/proton_scatter/), [scatter/addons/proton_scatter/src/](scatter/addons/proton_scatter/src/), [scatter/addons/proton_scatter/demos/](scatter/addons/proton_scatter/demos/).
- `godot-accessibility` — экранный диктор и accessibility-поддержка интерфейса. Важен, если хочется строить UI не только для обычного desktop/mobile потока. Смотреть: [godot-accessibility/](godot-accessibility/).
- `Godot-Component-System` — ECS-подход для сущностей, компонентов и систем. Подходит, если проект пойдёт в сторону data-driven архитектуры и большого количества переиспользуемых компонент. Смотреть: [alternatives/Beliar83__godot-component-system-asset/](alternatives/Beliar83__godot-component-system-asset/), [alternatives/Beliar83__godot-component-system-asset/addons/gcs/](alternatives/Beliar83__godot-component-system-asset/addons/gcs/), [alternatives/Beliar83__godot-component-system-asset/addons/uuid/](alternatives/Beliar83__godot-component-system-asset/addons/uuid/).

## Что важно помнить

- Это каталог кандидатов, а не утверждённый техстек. Не нужно тащить всё в `my-game`.
- Часть библиотек — самостоятельные демо-проекты или большие репозитории. Чаще всего нужен не весь репозиторий, а конкретный аддон, пример или паттерн интеграции.
- Некоторые библиотеки ориентированы на C# или расширенную сборочную инфраструктуру. Их стоит подключать только если у проекта реально появляется такая потребность.
- Если две библиотеки решают одну и ту же задачу, приоритет у той, у которой проще точка входа и чище путь интеграции в текущий `my-game`.

## Карта замен в `alternatives/`

Эти библиотеки представлены локальными заменами, потому что исходные ссылки из заметки были недоступны или неудобны для прямого импорта:

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

Сейчас все 28 пунктов из исходного списка представлены в дереве: либо точным репозиторием, либо локальной заменой в `alternatives/`.
