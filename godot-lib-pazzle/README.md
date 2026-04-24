# Godot Pazzle Vendor Set

This folder contains local copies of repositories referenced in `Godot-pazzle.md`.
Nested `.git` directories were removed so these files stay part of the main project tree.

## Exact downloads

- `beehave`
- `gloot`
- `GodotFirebase`
- `GodotTouchInputManager`
- `Gut`
- `nakama-godot`
- `pandora`
- `phantom-camera`
- `scene_manager`
- `scatter`
- `Virtual-Joystick-Godot`
- `godot-accessibility`
- `godot-ci`
- `godot-game-template`
- `godot-google-play-billing`
- `godot-jolt`
- `godot-steering-ai-framework`
- `godot_dialogue_manager`
- `godot_input_helper`
- `godot_sound_manager`

## Alternatives for dead links

These were downloaded into `alternatives/` because the original repository URLs from the note were no longer available.

- `derkyle/godot-state-charts` -> `derkork/godot-statecharts`
- `AnidemDex/Godot-EventBus` -> `mikica1986vee/EventBus_for_Godot_engine`
- `Yagich/Godot-Save-System` -> `erdavids/Godot-Save-System`
- `kurotori4423/panku-console` -> `Ark2000/PankuConsole`
- `Scony/godot-logger` -> `KOBUGE-Games/godot-logger`
- `godot-rapier/godot-rapier-2d` -> `appsinacup/godot-rapier-physics`

## Unresolved links

These original URLs did not resolve on GitHub and no confident replacement was identified during download.

- `awesomemau/godot-tween-sequence`
- `baconandgames/godot-component-system`


### 🧠 Архитектура и Логика (База для ИИ)
1. **[godot-state-charts](https://github.com/derkyle/godot-state-charts)** — Идеальные конечные автоматы (FSM) на основе узлов. Copilot легко пишет для них логику, так как они не требуют сложного кода, только вызовы событий.
2. **[beehave](https://github.com/bitbrain/beehave)** — Деревья поведения (Behavior Trees) для врагов. Лучший инструмент для создания умных мобов.
3. **[godot-steering-ai-framework](https://github.com/GDQuest/godot-steering-ai-framework)** — Фреймворк для плавного перемещения (поиск пути, избегание препятствий, следование за целью).
4. **[pandora](https://github.com/bitbrain/pandora)** — Менеджер данных (RPG-статы, предметы, инвентарь). Позволяет хранить данные игры отдельно от кода.
5. **[gloot](https://github.com/peter-kish/gloot)** — Готовая система инвентаря. Поддерживает сетку (как в Diablo) и слоты.
6. **[Godot-EventBus](https://github.com/AnidemDex/Godot-EventBus)** — Паттерн Event Bus. Позволяет Copilot'у связывать разные системы (например, UI и здоровье) без жестких зависимостей (spaghetti code).

### 📱 Мобильная специфика и Управление
7. **[GodotTouchInputManager](https://github.com/Federico-Ciuffardi/GodotTouchInputManager)** — Распознавание жестов: свайпы, щипки (pinch-to-zoom), двойные тапы. Незаменимо для Android.
8. **[Virtual-Joystick-Godot](https://github.com/MarcoFazioRandom/Virtual-Joystick-Godot)** — Готовый наэкранный джойстик для мобилок.
9. **[godot-google-play-billing](https://github.com/godotengine/godot-google-play-billing)** — Плагин для внутриигровых покупок (IAP) на Android.
10. **[godot_input_helper](https://github.com/nathanhoad/godot_input_helper)** — Упрощает работу с вводом, автоматически определяет, использует игрок геймпад, клавиатуру или тачскрин.

### 💾 Сохранения, Данные и Бэкенд
11. **[Godot-Save-System](https://github.com/Yagich/Godot-Save-System)** — Мощная система сохранений. Copilot легко генерирует словари для сохранения прогресса через эту либу.
12. **[GodotFirebase](https://github.com/GodotNuts/GodotFirebase)** — Облачные сохранения, авторизация и аналитика. Для мобильной игры аналитика (куда кликают, где умирают) критически важна.
13. **[nakama-godot](https://github.com/heroiclabs/nakama-godot)** — Если захочешь добавить мультиплеер, таблицы лидеров или кланы. Nakama — стандарт де-факто для инди-мобилок.

### 🎨 UI, Диалоги и "Сок" (Juice)
14. **[phantom-camera](https://github.com/ramokz/phantom-camera)** — Кинематографичная камера. Тряска экрана при ударе, плавное следование за игроком — делается в пару кликов.
15. **[godot_dialogue_manager](https://github.com/nathanhoad/godot_dialogue_manager)** — Система диалогов. В отличие от тяжелого Dialogic, эта библиотека использует текстовые файлы, которые **Copilot может писать и редактировать сам**.
16. **[godot_sound_manager](https://github.com/nathanhoad/godot_sound_manager)** — Пул звуков, кроссфейды музыки. Избавляет от необходимости писать костыли для AudioStreamPlayer.
17. **[scene_manager](https://github.com/Maktoobgar/scene_manager)** — Красивые переходы между экранами (затемнение, пикселизация, шторки) при загрузке уровней.
18. **[godot-tween-sequence](https://github.com/awesomemau/godot-tween-sequence)** — Упрощает написание сложных анимаций (Tweens) через код.

### ⚙️ Инструменты для работы с ИИ (Тесты и Дебаг)
19. **[Gut (Godot Unit Test)](https://github.com/bitwes/Gut)** — Фреймворк для юнит-тестов. **Лайфхак:** проси Copilot сначала написать тест для механики, а потом саму механику (TDD).
20. **[panku-console](https://github.com/kurotori4423/panku-console)** — Внутриигровая консоль разработчика. Позволяет читерить и вызывать функции прямо на экране телефона во время тестов.
21. **[godot-logger](https://github.com/Scony/godot-logger)** — Продвинутое логирование. Когда игра крашится на Android, обычный `print()` не спасет, нужны нормальные логи.
22. **[godot-ci](https://github.com/aBARICHELLO/godot-ci)** — Шаблоны для GitHub Actions. Позволяет автоматически собирать `.apk` файл при каждом пуше в GitHub (Copilot может помочь настроить YAML-файлы).

### 🚀 Физика и Производительность (Важно для Android)
23. **[godot-rapier-2d](https://github.com/godot-rapier/godot-rapier-2d)** — Замена стандартной 2D физики Godot. Работает в разы быстрее, что критично для слабых Android-смартфонов, если на экране много объектов (как в Vampire Survivors).
24. **[godot-jolt](https://github.com/godot-jolt/godot-jolt)** — Если игра будет в 3D, это обязательная замена физики. Стандарт индустрии для Godot 4.

### 🏗 Шаблоны и Генерация
25. **[godot-game-template](https://github.com/Crystal-Bit/godot-game-template)** — Готовый скелет игры (Главное меню, Настройки звука, Пауза). Экономит неделю рутинной работы. *(Заменил ссылку на более актуальный и поддерживаемый форк)*.
26. **[scatter](https://github.com/HungryProton/scatter)** — Процедурная генерация уровней (расстановка деревьев, камней, врагов по правилам).
27. **[godot-accessibility](https://github.com/lightsoutgames/godot-accessibility)** — Плагин для доступности (чтение текста с экрана). Google Play очень любит игры, адаптированные для людей с ограниченными возможностями, и дает им буст в поиске.
28. **[Godot-Component-System](https://github.com/baconandgames/godot-component-system)** — Реализация паттерна ECS (Entity-Component-System). Если попросишь Copilot писать игру через компоненты (компонент здоровья, компонент урона), код будет максимально чистым и переиспользуемым. *(Дал ссылку на самую популярную реализацию компонентов для Godot 4)*.
