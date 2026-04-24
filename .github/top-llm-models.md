# Сравнение топовых AI-моделей (март 2026)

> **Дата анализа:** 6 марта 2026  
> **Источники:** Artificial Analysis Intelligence Index v4.0, LLM Stats, Chat Arena ELO, официальные бенчмарки вендоров  
> **Важно:** Независимо верифицированные данные — только Artificial Analysis (10 evaluations). Остальные бенчмарки — self-reported вендорами.

---

## Модели в сравнении

| Модель | Вендор | Контекст (API) | Контекст (VS Code) | Цена input/output ($/1M tok) | Скорость (tok/s) | TTFT (latency) |
|--------|--------|:--------------:|:-------------------:|-------------------------------|-------------------|------------------|
| **Gemini 3.1 Pro Preview** | Google | 1M | **173K** | $2 / $12 | ~100 | 38.4s |
| **GPT-5.4 xhigh** | OpenAI | 1.05M | **400K** | $2.5 / $15 | ~72 | 185s |
| **GPT-5.3 Codex xhigh** | OpenAI | 400k | **400K** | $1.75 / $14 | ~62 | 90.1s |
| **Claude Opus 4.6** | Anthropic | 200k | **192K** | $5 / $25 | ~44 | 14.9s |
| **Claude Sonnet 4.6** | Anthropic | 200k | **160K** | $3 / $15 | ~52 | 104.6s |

> **Важно:** Колонка "VS Code" — реальные лимиты контекста в нашей среде (Copilot model picker, март 2026). API-лимиты маркетинговые и недоступны напрямую.

---

## Сводная таблица: оценки по 10-балльной шкале

Критерии оценки основаны на независимых бенчмарках + практическом опыте. 10 = лучший в классе, 1 = худший.

| Критерий | Gemini 3.1 Pro | GPT-5.4 | GPT-5.3 Codex | Claude Opus 4.6 | Claude Sonnet 4.6 |
|----------|:--------------:|:-------:|:--------------:|:---------------:|:-----------------:|
| **Intelligence Index** (AA) | **10** | **10** | 9 | 8 | 8 |
| **Кодинг / SWE** | 8 | 9 | **10** | 9 | 8 |
| **Глубокое рассуждение** | 9 | **10** | 8 | **10** | 8 |
| **Следование инструкциям** | 9 | 8 | 8 | **10** | 9 |
| **Научные задачи (GPQA/HLE)** | **10** | 9 | 7 | 9 | 8 |
| **Скорость генерации** | **10** | 8 | 7 | 5 | 6 |
| **Латентность (TTFT)** | 8 | 3 | 5 | **10** | 4 |
| **Контекстное окно (VS Code)** | 5 | **10** | **10** | 7 | 5 |
| **Цена / качество** | **10** | 8 | 9 | 5 | 7 |
| **Безопасность / отказы** | 7 | 8 | 8 | **10** | **10** |
| **Работа с агентами** | 9 | 8 | **10** | 9 | 7 |
| **Мультимодальность** | **10** | 9 | 6 | 7 | 7 |
| | | | | | |
| **ИТОГО (из 120)** | **105** | **100** | **97** | **99** | **87** |
| **Средний балл** | **8.8** | **8.3** | **8.1** | **8.3** | **7.3** |

---

## Расшифровка критериев

### Intelligence Index (Artificial Analysis, независимый)
Композитный индекс из 10 независимых тестов: GDPval-AA, τ²-Bench Telecom, Terminal-Bench Hard, SciCode, AA-LCR, AA-Omniscience, IFBench, Humanity's Last Exam, GPQA Diamond, CritPt.

- **Gemini 3.1 Pro = 57** — делит 1-е место с GPT-5.4
- **GPT-5.4 = 57** — делит 1-е место
- **GPT-5.3 Codex = 54** — 3-е место
- **Claude Opus 4.6 = 53** — 4-е место
- **Claude Sonnet 4.6 = 52** — 5-е место

### Кодинг / SWE
SWE-Bench Verified, Terminal-Bench, SWE-Lancer IC-Diamond, OSWorld.

- **GPT-5.3 Codex** — лидер: Terminal-Bench 2.0 = 77.3% (#1), SWE-Lancer IC-Diamond = 81% (#2), OSWorld-Verified = 65% (#2)
- **GPT-5.4** — сильный: SWE-Bench Verified высокий, но Codex специализированнее
- **Claude Opus 4.6** — SWE-Bench Verified 0.80 (#6), стабильно сильный
- **Gemini 3.1 Pro** — хорош, но не лидер в чистом кодинге
- **Claude Sonnet 4.6** — SWE-Bench Verified 0.80 (#6), на уровне Opus

### Глубокое рассуждение
GPQA Diamond, Humanity's Last Exam (HLE), CritPt, длинные цепочки reasoning.

- **GPT-5.4** — максимальная глубина reasoning, самый мощный в сложных логических задачах
- **Claude Opus 4.6** — Chat Arena #1 (ELO 1629), сильнейший в диалоговом reasoning
- **Gemini 3.1 Pro** — GPQA Diamond лидер, HLE сильный

### Следование инструкциям
IFBench, точность выполнения промптов, отсутствие hallucinations.

- **Claude Opus 4.6** — лучший: 10/10 на IFBench в нашем опыте, минимальные отклонения
- **Claude Sonnet 4.6** — наследует дисциплину Opus, чуть менее последователен
- **Gemini 3.1 Pro** — высокий IFBench балл

### Научные задачи
GPQA Diamond, SciCode, Humanity's Last Exam (HLE).

- **Gemini 3.1 Pro** — лидер по GPQA Diamond и SciCode
- **GPT-5.4** — близко к Gemini
- **Claude Opus 4.6** — GPQA 0.90 (#8)

### Скорость генерации
Tokens per second при среднем reasoning.

- **Gemini 3.1 Pro** — ~100 tok/s, абсолютный лидер
- **GPT-5.4** — ~72 tok/s
- **GPT-5.3 Codex** — ~62 tok/s
- **Claude Sonnet 4.6** — ~52 tok/s
- **Claude Opus 4.6** — ~44 tok/s, самый медленный

### Латентность (Time to First Token)
Время до первого токена — критично для интерактивных сценариев.

- **Claude Opus 4.6** — 14.9s, лучший TTFT среди reasoning-моделей
- **Gemini 3.1 Pro** — 38.4s
- **GPT-5.3 Codex** — 90.1s
- **Claude Sonnet 4.6** — 104.6s
- **GPT-5.4** — 185s, самый медленный старт

### Контекстное окно (VS Code реальность)
Реальные лимиты контекста в нашей VS Code среде (Copilot model picker).

- **GPT-5.4** — 400K (API: 1.05M, но в VS Code обрезан)
- **GPT-5.3 Codex** — 400K (совпадает с API)
- **Claude Opus 4.6** — 192K (API: 200K)
- **Gemini 3.1 Pro** — 173K (API: 1M, но в VS Code обрезан до 173K)
- **Claude Sonnet 4.6** — 160K (API: 200K)

> GPT-модели имеют 2x+ преимущество по контексту в VS Code. Это критично для агентов, работающих с большими кодовыми базами.

### Цена / качество
Соотношение Intelligence Index к стоимости output-токенов.

- **Gemini 3.1 Pro** — лучшее: Index 57 за $12/M output
- **GPT-5.3 Codex** — хорошее: Index 54 за $14/M output
- **GPT-5.4** — среднее: Index 57 за $15/M output
- **Claude Sonnet 4.6** — среднее: Index 52 за $15/M output
- **Claude Opus 4.6** — дорого: Index 53 за $25/M output

### Безопасность / минимизация отказов
Качество safety-слоя, отсутствие ложных отказов, корректные ограничения.

- **Claude Opus/Sonnet 4.6** — золотой стандарт: отказывает только когда действительно нужно, минимальные ложные срабатывания
- **GPT-5.4 / GPT-5.3** — хорошо, но иногда over-refuses
- **Gemini 3.1 Pro** — иногда пропускает нежелательный контент

### Работа с агентами
Autonomous agent loops, tool use, multi-step task completion.

- **GPT-5.3 Codex** — специализирован: лучший для Codex CLI, автономных dev-агентов
- **Claude Opus 4.6** — отличный в MCP/tool-use сценариях
- **Gemini 3.1 Pro** — сильный агент с длинным контекстом

### Мультимодальность
Работа с изображениями, видео, аудио, PDF.

- **Gemini 3.1 Pro** — полная мультимодальность: видео, аудио, изображения нативно
- **GPT-5.4** — изображения + PDF, без нативного видео
- **Claude модели** — изображения + PDF, ограниченная мультимодальность
- **GPT-5.3 Codex** — минимальная мультимодальность (заточен под код)

---

## Рейтинг по сценариям использования

### 1. Кодинг / разработка (IDE, агенты, code review)
1. **GPT-5.3 Codex** — специализирован, Terminal-Bench #1, лучший для Codex CLI
2. **Claude Opus 4.6** — лучший instruction-following, минимальные отклонения от задачи
3. **GPT-5.4** — мощный, но медленный старт (185s TTFT)
4. **Gemini 3.1 Pro** — быстрый, но менее точен в сложном рефакторинге
5. **Claude Sonnet 4.6** — хороший баланс цена/качество для рутинного кода

### 2. Научные исследования / сложные вопросы
1. **GPT-5.4** — максимальная глубина reasoning
2. **Gemini 3.1 Pro** — GPQA Diamond лидер, огромный контекст
3. **Claude Opus 4.6** — Chat Arena #1, сильный в диалоге
4. **Claude Sonnet 4.6** — дешевле Opus, близкий уровень
5. **GPT-5.3 Codex** — не его сценарий

### 3. Бизнес-автоматизация / чат-боты
1. **Gemini 3.1 Pro** — лучшая цена/качество, быстрый, 1M контекст
2. **Claude Sonnet 4.6** — надёжный, безопасный, разумная цена
3. **GPT-5.4** — мощный, но дороже
4. **Claude Opus 4.6** — дорогой для масштаба
5. **GPT-5.3 Codex** — не предназначен для чат-ботов

### 4. Творческие задачи / написание текстов
1. **Claude Opus 4.6** — Chat Arena #1, лучший стиль и нюансы
2. **GPT-5.4** — близко к Opus по качеству текстов
3. **Gemini 3.1 Pro** — хорош, иногда менее выразителен
4. **Claude Sonnet 4.6** — хороший текст, дешевле Opus
5. **GPT-5.3 Codex** — не его сценарий

### 5. Длинные документы / RAG
**В VS Code (реальные контексты):**
1. **GPT-5.4** — 400K контекст + сильный reasoning
2. **GPT-5.3 Codex** — 400K, хорош для кодовых баз
3. **Claude Opus 4.6** — 192K, очень точный в рамках окна
4. **Gemini 3.1 Pro** — 173K (не 1M!), но быстрый
5. **Claude Sonnet 4.6** — 160K, дешевле Opus

---

## Детальные бенчмарки (Artificial Analysis, 10 evaluations)

Все числа — из Artificial Analysis Intelligence Index v4.0 (независимая оценка, 282+ модели).

| Evaluation | Gemini 3.1 Pro | GPT-5.4 | GPT-5.3 Codex | Claude Opus 4.6 | Claude Sonnet 4.6 |
|------------|:--------------:|:-------:|:--------------:|:---------------:|:-----------------:|
| **GDPval-AA** | ~1600 | ~1580 | ~1520 | ~1550 | ~1633 |
| **τ²-Bench Telecom** | высокий | высокий | средний | 0.98 (#6) | 0.98 (#6) |
| **Terminal-Bench Hard** | средний | высокий | **77.3% (#1)** | средний | средний |
| **SciCode** | **лидер** | высокий | средний | средний | средний |
| **AA-LCR** | высокий | высокий | средний | высокий | средний |
| **AA-Omniscience** | высокий | высокий | средний | средний | средний |
| **IFBench** | высокий | средний | средний | **лидер** | высокий |
| **Humanity's Last Exam** | высокий | высокий | средний | средний | HLE #6 |
| **GPQA Diamond** | **лидер** | высокий | средний | 0.90 (#8) | 0.90 (#8) |
| **CritPt** | средний | средний | средний | высокий | средний |
| | | | | | |
| **Intelligence Index** | **57** | **57** | **54** | **53** | **52** |

> **Примечание:** Точные числа по каждому evaluation доступны не для всех моделей в разбивке. Intelligence Index — это единственная метрика, нормализованная по всем 10 тестам.

---

## Vendor-reported бенчмарки (self-reported, не верифицированы независимо)

### Claude Sonnet 4.6 (по данным LLM Stats)
| Бенчмарк | Результат | Место |
|-----------|-----------|-------|
| GDPval-AA | 1633/3000 | #1 |
| τ²-Bench Telecom | 0.98 | #6 |
| τ²-Bench Retail | 0.92 | #2 |
| GPQA | 0.90 | #8 |
| MMMLU | 0.89 | #8 |
| SWE-Bench Verified | 0.80 | #6 |
| ARC-AGI v2 | — | #4 |
| HLE | — | #6 |

### GPT-5.3 Codex (по данным LLM Stats)
| Бенчмарк | Результат | Место |
|-----------|-----------|-------|
| Terminal-Bench 2.0 | 77.3% | #1 |
| Cybersecurity CTF | 77.6% | #1 |
| SWE-Lancer IC-Diamond | 81% | #2 |
| OSWorld-Verified | 65% | #2 |
| SWE-Bench Pro | 57% | #2 |

### Claude Opus 4.6
| Метрика | Результат |
|---------|-----------|
| Chat Arena ELO | 1629 (#1) |

---

## Ключевые выводы

### Что проверено независимо (можно доверять):
- **Intelligence Index** — единственный кросс-модельный бенчмарк на единой шкале
- **Pricing / Speed / Latency** — измерено Artificial Analysis
- **Chat Arena ELO** — crowd-sourced, но большая выборка

### Что self-reported (с оговоркой):
- SWE-Bench Verified, OSWorld, BrowseComp, ARC-AGI-2 — заявлено вендорами
- Многие бенчмарки запускаются вендорами на собственных настройках (prompting, temperature, attempts)
- Нет единой методологии: OpenAI может давать 100 попыток, Anthropic — 1

### Общая тенденция:
1. **Разрыв между топами минимален** — 52-57 по Intelligence Index (разница ~10%)
2. **Специализация важнее общего балла** — Codex лучше в коде, Opus в reasoning, Gemini в скорости
3. **Цена/качество — главный дифференциатор** — Gemini даёт лучший ROI
4. **В VS Code контекст ≠ маркетинг** — GPT-модели 400K, Gemini 173K (не 1M!), Claude 160-192K

---

## Рекомендации для проекта

Для текущего Godot-first workspace:

| Задача | Рекомендация | Почему |
|--------|-------------|--------|
| **Daily coding (IDE)** | Claude Opus 4.6 | Лучший instruction-following, быстрый TTFT (14.9s), идеален для VS Code |
| **Сложный рефакторинг** | GPT-5.3 Codex | Terminal-Bench #1, 400K контекст, лучший для автономных agent-задач |
| **Code review** | Claude Opus 4.6 | Самый внимательный к деталям, минимальные hallucinations |
| **Архитектурный анализ** | GPT-5.4 | Максимальная глубина reasoning + 400K контекст (в VS Code) |
| **Быстрый прототип** | Gemini 3.1 Pro | 100 tok/s, дешёвый, 173K контекст |
| **Devil's advocate** | Claude Opus 4.6 или GPT-5.4 | Глубокий reasoning, разные perspective |
| **Consilium (аналитика)** | Смешать все | Каждая модель привносит уникальную перспективу |

---

## Источники

1. [Artificial Analysis — Intelligence Index](https://artificialanalysis.ai/intelligence)
2. [Artificial Analysis — Gemini 3.1 Pro vs GPT-5.4](https://artificialanalysis.ai/models/gemini-3-1-pro/vs/gpt-5-4)
3. [Artificial Analysis — Gemini 3.1 Pro vs Claude Opus 4.6](https://artificialanalysis.ai/models/gemini-3-1-pro/vs/claude-opus-4-6)
4. [Artificial Analysis — Gemini 3.1 Pro vs Claude Sonnet 4.6](https://artificialanalysis.ai/models/gemini-3-1-pro/vs/claude-sonnet-4-6)
5. [Artificial Analysis — Gemini 3.1 Pro vs GPT-5.3 Codex](https://artificialanalysis.ai/models/gemini-3-1-pro/vs/gpt-5-3-codex)
6. [Artificial Analysis — GPT-5.4 vs Claude Opus 4.6](https://artificialanalysis.ai/models/gpt-5-4/vs/claude-opus-4-6)
7. [Artificial Analysis — GPT-5.4 vs Claude Sonnet 4.6](https://artificialanalysis.ai/models/gpt-5-4/vs/claude-sonnet-4-6)
8. [Artificial Analysis — GPT-5.4 vs GPT-5.3 Codex](https://artificialanalysis.ai/models/gpt-5-4/vs/gpt-5-3-codex)
9. [Artificial Analysis — GPT-5.3 Codex vs Claude Opus 4.6](https://artificialanalysis.ai/models/gpt-5-3-codex/vs/claude-opus-4-6)
10. [Artificial Analysis — GPT-5.3 Codex vs Claude Sonnet 4.6](https://artificialanalysis.ai/models/gpt-5-3-codex/vs/claude-sonnet-4-6)
11. [LLM Stats — Claude Sonnet 4.6](https://llmstats.net/models/claude-sonnet-4-6)
12. [LLM Stats — GPT-5.3 Codex](https://llmstats.net/models/gpt-5.3-codex)
13. [LMArena — Chat Arena Leaderboard](https://lmarena.ai/?leaderboard)
14. [Anthropic — Claude 4.6 Model Card](https://docs.anthropic.com/en/docs/about-claude/models)
