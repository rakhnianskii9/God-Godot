# Сравнение топовых AI-моделей (март-апрель 2026)

> **Дата базового анализа:** 6 марта 2026  
> **Апдейт:** 24 апреля 2026  
> **Источники:** Artificial Analysis Intelligence Index v4.0 + model pages, LLM Stats, Chat Arena ELO, официальные бенчмарки вендоров  
> **Важно:** Независимо верифицированные данные — только Artificial Analysis (10 evaluations). Остальные бенчмарки — self-reported вендорами.
> **Примечание:** Ниже оставлен короткий delta-апдейт по Claude Opus 4.7 и GPT-5.5. Основные таблицы и сценарные рейтинги ниже уже пересчитаны под актуальный срез Artificial Analysis.

---

## Апдейт: Claude Opus 4.7 и GPT-5.5

### Быстрый срез (Artificial Analysis, 24 апреля 2026)

| Модель | Релиз | Intelligence Index (AA) | Контекст (API) | Цена input/output ($/1M tok) | Скорость (tok/s) | TTFT | Примечание |
|--------|-------|:-----------------------:|:--------------:|-------------------------------|------------------|------|------------|
| **Claude Opus 4.7 (max)** | 16 апреля 2026 | **57.28** | **1M** | $5 / $25 | **45.8** | **18.6s** | Knowledge cutoff: January 2026 |
| **GPT-5.5 (xhigh)** | 23 апреля 2026 | **60.24** | **922K** | $5 / $30 | н/д | н/д | В payload AA на 24 апреля 2026 speed/latency-поля ещё нулевые |

### Детальные AA-метрики

| Evaluation | Claude Opus 4.7 | GPT-5.5 |
|------------|:---------------:|:-------:|
| **GDPval-AA** | 1752.68 | **1781.81** |
| **τ²-Bench Telecom** | 0.886 | **0.939** |
| **Terminal-Bench Hard** | 51.5% | **60.6%** |
| **SciCode** | 0.545 | **0.561** |
| **AA-LCR** | 0.703 | **0.743** |
| **AA-Omniscience** | **26.167** | 20.067 |
| **IFBench** | 0.586 | **0.759** |
| **Humanity's Last Exam** | 0.396 | **0.443** |
| **GPQA Diamond** | 0.914 | **0.935** |
| **CritPt** | 0.120 | **0.271** |

### Что это меняет

- **GPT-5.5** — новый лидер этого документа по независимому `Artificial Analysis Intelligence Index`: **60.24** против **57** у прежних лидеров из мартовского среза.
- **Claude Opus 4.7** — фактически выходит на уровень верхней группы по общему intelligence, но не меняет тезис о высокой цене/медленной выдаче у Opus-линейки.
- Для **GPT-5.5** пока нельзя честно сравнивать скорость и TTFT с мартовской пятёркой: в текущем payload Artificial Analysis эти поля ещё не заполнены.

---

## Модели в сравнении

| Модель | Вендор | Intelligence Index (AA) | Контекст (API) | Цена input/output ($/1M tok) | Скорость (tok/s) | TTFT (latency) | Agentic / Coding Index |
|--------|--------|:-----------------------:|:--------------:|-------------------------------|------------------|----------------|:----------------------:|
| **GPT-5.5 (xhigh)** | OpenAI | **60.24** | 922K | $5 / $30 | н/д* | н/д* | **74.12 / 59.12** |
| **Claude Opus 4.7 (max)** | Anthropic | **57.28** | 1M | $5 / $25 | 45.8 | 18.6s | **71.29 / 52.51** |
| **Gemini 3.1 Pro Preview** | Google | **57.18** | 1M | $2 / $12 | **129.0** | 27.9s | 59.09 / 55.50 |
| **GPT-5.4 (xhigh)** | OpenAI | **56.80** | **1.05M** | $2.5 / $15 | 79.6 | 172.7s | 67.96 / 57.25 |
| **GPT-5.3 Codex (xhigh)** | OpenAI | **53.56** | 400K | $1.75 / $14 | 73.3 | 122.3s | 60.54 / 53.10 |
| **Claude Opus 4.6 (high)** | Anthropic | **46.46** | 1M | $5 / $25 | 39.8 | 1.9s | 64.22 / 47.56 |
| **Claude Sonnet 4.6 (non-reasoning)** | Anthropic | **44.38** | 1M | $3 / $15 | 45.9 | **1.4s** | 61.62 / 46.43 |

> **Важно:** Основной source of truth в этом пересчёте — прямые model pages Artificial Analysis, а не мартовский snapshot model picker в VS Code.
> **Важно:** Для GPT-5.5 current AA payload на 24 апреля 2026 ещё не заполняет speed/TTFT/end-to-end поля, поэтому они помечены как `н/д`, а не оцениваются по догадке.
> **Примечание:** Для Claude 4.6 в AA сейчас surface-ятся конкретные variants (`high` / `non-reasoning`), поэтому их цифры не совпадают с мартовской версией документа.

---

## Лидеры по категориям

Старую 10-балльную матрицу я заменил на фактическую сводку по лидерам. После апрельского апдейта ручные баллы начали сильнее искажать картину, чем помогать.

| Категория | Лидер | Кто рядом | Основание |
|-----------|-------|-----------|-----------|
| **Общий intelligence** | **GPT-5.5** | Claude Opus 4.7, Gemini 3.1 Pro, GPT-5.4 | II: 60.24 vs 57.28 / 57.18 / 56.80 |
| **Кодинг и agentic-work** | **GPT-5.5** | GPT-5.4, Claude Opus 4.7 | Agentic 74.12, Coding 59.12, TB Hard 60.6% |
| **Научные задачи** | **Gemini 3.1 Pro** | GPT-5.5, GPT-5.4 | GPQA 0.941, HLE 0.447, SciCode 0.589 |
| **Скорость генерации** | **Gemini 3.1 Pro** | GPT-5.4, GPT-5.3 Codex | 129 tok/s vs 79.6 / 73.3 |
| **TTFT / отзывчивость** | **Claude Sonnet 4.6** | Claude Opus 4.6, Claude Opus 4.7 | 1.4s vs 1.9s / 18.6s |
| **Контекст** | **GPT-5.4** | Gemini 3.1 Pro, Claude Opus 4.7, Claude 4.6 variants | 1.05M vs 1M-class |
| **Цена / качество** | **Gemini 3.1 Pro** | GPT-5.3 Codex, GPT-5.4 | II / blended price: 12.71 / 11.13 / 10.10 |
| **Баланс для review/analysis** | **Claude Opus 4.7** | GPT-5.5, GPT-5.4 | Высокий II без экстремального TTFT уровня GPT-5.4 |

---

## Расшифровка критериев

### Intelligence Index (Artificial Analysis, независимый)
Композитный индекс из 10 независимых тестов: GDPval-AA, τ²-Bench Telecom, Terminal-Bench Hard, SciCode, AA-LCR, AA-Omniscience, IFBench, Humanity's Last Exam, GPQA Diamond, CritPt.

- **GPT-5.5 = 60.24** — новый лидер документа по независимому AA composite score.
- **Claude Opus 4.7 = 57.28** и **Gemini 3.1 Pro = 57.18** — практически одна группа, с минимальным разрывом.
- **GPT-5.4 = 56.80** — очень близко к верхней группе, но уже не делит первое место.

### Кодинг / SWE

- По **текущему AA-срезу** лидер здесь уже **GPT-5.5**: Coding Index 59.12, Agentic Index 74.12, Terminal-Bench Hard 60.6%.
- **GPT-5.4** остаётся очень сильным кодовым reasoning-моделем, а **GPT-5.3 Codex** всё ещё выглядит как хороший специализированный dev-default по соотношению цена / профиль / привычный workflow.
- **Claude Opus 4.7** подтянулся ближе к GPT-линейке по agentic-задачам, но не обошёл верхние GPT по кодовым метрикам.

### Глубокое рассуждение
GPQA Diamond, Humanity's Last Exam (HLE), CritPt, длинные цепочки reasoning.

- **GPT-5.5** сейчас выглядит strongest overall reasoning-моделью по совокупности II, GPQA, HLE, CritPt и Agentic Index.
- **Claude Opus 4.7** и **GPT-5.4** — следующий эшелон для сложного анализа, но с разным trade-off: у Opus 4.7 лучше отзывчивость, у GPT-5.4 больше контекст.
- **Gemini 3.1 Pro** остаётся максимально сильным именно на research/science-срезе.

### Следование инструкциям
IFBench, точность выполнения промптов, отсутствие hallucinations.

- В **текущем AA IFBench** лидируют **Gemini 3.1 Pro (0.771)**, **GPT-5.5 (0.759)** и **GPT-5.3 Codex (0.754)**.
- **GPT-5.4 (0.739)** тоже остаётся в верхней группе.
- На этом именно независимом срезе Anthropic 4.6/4.7 не лидирует, поэтому старый тезис про безусловное первенство Opus я убрал.

### Научные задачи
GPQA Diamond, SciCode, Humanity's Last Exam (HLE).

- **Gemini 3.1 Pro** — лучший science/research default в этом документе: GPQA 0.941, HLE 0.447, SciCode 0.589.
- **GPT-5.5** идёт очень близко: GPQA 0.935, HLE 0.443, SciCode 0.561.
- **GPT-5.4** остаётся сильным третьим вариантом для science-heavy работы с большим контекстом.

### Скорость генерации
Tokens per second при среднем reasoning.

- **Gemini 3.1 Pro** — measured лидер по throughput: **129 tok/s**.
- Дальше идут **GPT-5.4 (79.6)** и **GPT-5.3 Codex (73.3)**.
- **GPT-5.5** здесь пока нельзя оценивать: current AA payload отдаёт `0/null` в performance-полях.

### Латентность (Time to First Token)
Время до первого токена — критично для интерактивных сценариев.

- **Claude Sonnet 4.6** — fastest TTFT: **1.4s**.
- **Claude Opus 4.6** — **1.9s**, **Claude Opus 4.7** — **18.6s**, **Gemini 3.1 Pro** — **27.9s**.
- GPT-линейка в measured TTFT всё ещё тяжёлая: **GPT-5.3 Codex 122.3s**, **GPT-5.4 172.7s**, а для **GPT-5.5** AA-поле пока пустое.

### Контекстное окно (API, не VS Code picker)

- **GPT-5.4** — крупнейшее окно в этом документе: **1.05M**.
- **Gemini 3.1 Pro**, **Claude Opus 4.7**, **Claude Opus 4.6** и **Claude Sonnet 4.6** — **1M-class**.
- **GPT-5.5** — **922K**, **GPT-5.3 Codex** — **400K**.

> Старые мартовские лимиты model picker VS Code я здесь больше не использую как основную метрику, потому что они не были повторно верифицированы в этом апдейте.

### Цена / качество
Соотношение Intelligence Index к стоимости output-токенов.

- По грубому ratio `Intelligence Index / blended price` лидер всё ещё **Gemini 3.1 Pro = 12.71**.
- Дальше идут **GPT-5.3 Codex = 11.13** и **GPT-5.4 = 10.10**.
- **GPT-5.5** и **Claude Opus 4.7** — очень сильные по capability, но уже не лидеры по ROI.

### Работа с агентами
Autonomous agent loops, tool use, multi-step task completion.

- По текущему **AA Agentic Index** лидер — **GPT-5.5 (74.12)**.
- Дальше идут **Claude Opus 4.7 (71.29)** и **GPT-5.4 (67.96)**.
- **GPT-5.3 Codex** остаётся хорошим pragmatic dev-agent choice, если нужен более дешёвый и привычный coding-first маршрут.

---

## Рейтинг по сценариям использования

### 1. Кодинг / разработка (IDE, агенты, code review)
1. **GPT-5.5** — strongest current AA coding/agentic profile, если acceptable отсутствие пока заполненных speed/TTFT полей.
2. **GPT-5.4** — почти тот же класс reasoning + максимальный контекст, но очень тяжёлый TTFT.
3. **GPT-5.3 Codex** — всё ещё отличный специализированный coding-default, особенно если нужен cheaper dev loop.
4. **Claude Opus 4.7** — сильный code-review / analysis вариант с куда более живым TTFT, чем у GPT-5.4.
5. **Gemini 3.1 Pro** — fastest measured output и сильный science/code mix, но agentic ниже топовых GPT.
6. **Claude Opus 4.6**
7. **Claude Sonnet 4.6**

### 2. Научные исследования / сложные вопросы
1. **Gemini 3.1 Pro** — лучший science stack по GPQA/HLE/SciCode.
2. **GPT-5.5** — почти догнал Gemini на science-срезе и лидирует по общему intelligence.
3. **GPT-5.4** — хороший выбор, если критичен максимально длинный контекст.
4. **Claude Opus 4.7** — сильный аналитический второй эшелон.
5. **GPT-5.3 Codex**
6. **Claude Opus 4.6**
7. **Claude Sonnet 4.6**

### 3. Бизнес-автоматизация / чат-боты
1. **Gemini 3.1 Pro** — лучший ROI + measured speed + 1M context.
2. **Claude Sonnet 4.6** — ультра-быстрый TTFT и вменяемая цена, если не нужен frontier-level интеллект.
3. **GPT-5.4** — дороговат по latency, но очень силён по capability/context.
4. **GPT-5.5** — capability-лидер, но цена выше, а публичных AA latency/speed данных пока нет.
5. **Claude Opus 4.7** — сильный, но не экономичный для масштаба.
6. **Claude Opus 4.6**
7. **GPT-5.3 Codex**

### 4. Творческие задачи / написание текстов
1. **Claude Opus 4.7** — наиболее вероятный текстовый лидер в этом срезе: высокий II + нормальный TTFT + сильная Anthropic-линия.
2. **GPT-5.5** — strongest generalist, если приоритет на raw capability.
3. **GPT-5.4** — очень силён, но менее приятен по latency.
4. **Claude Sonnet 4.6** — pragmatic value-pick для writing-heavy чатов.
5. **Gemini 3.1 Pro**
6. **Claude Opus 4.6**
7. **GPT-5.3 Codex**

> Этот сценарий остаётся самым субъективным в документе: независимого "creative writing benchmark" сопоставимого качества по всем моделям у нас нет.

### 5. Длинные документы / RAG
**По API-контексту, а не по мартовскому VS Code picker snapshot:**
1. **GPT-5.4** — 1.05M + высокий II.
2. **Claude Opus 4.7** — 1M + очень сильный analysis balance.
3. **Gemini 3.1 Pro** — 1M + лучший throughput / ROI.
4. **GPT-5.5** — 922K + лучший общий intelligence.
5. **Claude Opus 4.6** — 1M, но уже не frontier по intelligence.
6. **Claude Sonnet 4.6** — 1M и быстрый TTFT, если quality ceiling не главный.
7. **GPT-5.3 Codex** — 400K, хорош для кода, но по длинным документам окно уже ощутимо меньше.

---

## Детальные бенчмарки (Artificial Analysis, 10 evaluations)

Все числа ниже — из прямых model pages Artificial Analysis на 24 апреля 2026.

| Evaluation | GPT-5.5 | Claude Opus 4.7 | Gemini 3.1 Pro | GPT-5.4 | GPT-5.3 Codex | Claude Opus 4.6 | Claude Sonnet 4.6 |
|------------|:-------:|:---------------:|:--------------:|:-------:|:--------------:|:---------------:|:-----------------:|
| **GDPval-AA** | **1781.81** | 1752.68 | 1314.14 | 1673.63 | 1483.36 | 1594.79 | 1590.25 |
| **τ²-Bench Telecom** | **0.939** | 0.886 | **0.956** | 0.871 | 0.860 | 0.848 | 0.795 |
| **Terminal-Bench Hard** | **60.6%** | 51.5% | 53.8% | 57.6% | 53.0% | 48.5% | 46.2% |
| **SciCode** | 0.561 | 0.545 | **0.589** | 0.566 | 0.532 | 0.457 | 0.469 |
| **AA-LCR** | **0.743** | 0.703 | 0.727 | 0.740 | 0.740 | 0.583 | 0.577 |
| **AA-Omniscience** | 20.067 | **26.167** | **32.933** | 5.650 | 9.883 | 3.467 | -2.933 |
| **IFBench** | 0.759 | 0.586 | **0.771** | 0.739 | 0.754 | 0.446 | 0.412 |
| **Humanity's Last Exam** | 0.443 | 0.396 | **0.447** | 0.416 | 0.399 | 0.186 | 0.132 |
| **GPQA Diamond** | 0.935 | 0.914 | **0.941** | 0.920 | 0.915 | 0.840 | 0.799 |
| **CritPt** | **0.271** | 0.120 | 0.177 | 0.234 | 0.169 | 0.028 | 0.009 |
| | | | | | | | |
| **Intelligence Index** | **60.24** | 57.28 | 57.18 | 56.80 | 53.56 | 46.46 | 44.38 |

> **Примечание:** Точные числа по каждому evaluation доступны не для всех моделей в разбивке. Intelligence Index — это единственная метрика, нормализованная по всем 10 тестам.

---

## Vendor-Reported / Partial Benchmarks

Эта секция оставлена только как дополнительный контекст. Для межмодельного сравнения выше я опираюсь не на неё, а на Artificial Analysis.

### GPT-5.3 Codex (по данным LLM Stats)
| Бенчмарк | Результат | Место |
|-----------|-----------|-------|
| Terminal-Bench 2.0 | 77.3% | #1 |
| Cybersecurity CTF | 77.6% | #1 |
| SWE-Lancer IC-Diamond | 81% | #2 |
| OSWorld-Verified | 65% | #2 |
| SWE-Bench Pro | 57% | #2 |

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

### Claude Opus 4.6
| Метрика | Результат |
|---------|-----------|
| Chat Arena ELO | 1629 (#1) |

### По новым моделям

- Для **Claude Opus 4.7** и **GPT-5.5** в этот апдейт я не добавлял отдельные self-reported таблицы, потому что хотел держать документ на одной независимой шкале и не смешивать неполные vendor snapshots с AA как будто они эквивалентны.

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
1. **GPT-5.5** — новый независимый лидер этого документа: **60.24** по AA Intelligence Index.
2. **Claude Opus 4.7** возвращает Anthropic в верхний эшелон, но не меняет тезис про слабый price/performance у Opus-линии.
3. **Gemini 3.1 Pro** по-прежнему самый выгодный pragmatic pick: лучший ROI и лучший measured throughput.
4. **GPT-5.4** всё ещё очень силён, но latency trade-off у него экстремальный.
5. **GPT-5.5** пока нельзя честно сравнивать по speed/TTFT с остальными: current AA payload ещё не отдал эти performance-поля.

---

## Рекомендации для проекта

Для текущего Godot-first workspace:

| Задача | Рекомендация | Почему |
|--------|-------------|--------|
| **Daily coding (IDE)** | GPT-5.5 или GPT-5.3 Codex | GPT-5.5 = максимум capability; Codex = cheaper specialized default для повседневной разработки |
| **Сложный рефакторинг** | GPT-5.5 или GPT-5.4 | Лучший reasoning-class; у GPT-5.4 ещё и 1.05M контекст |
| **Code review** | Claude Opus 4.7 | Сильный analysis balance без чудовищного TTFT, как у GPT-5.4 |
| **Архитектурный анализ** | GPT-5.5 | Лидер по AA Intelligence + Agentic Index |
| **Быстрый прототип** | Gemini 3.1 Pro | Самый быстрый measured output и лучший ROI |
| **Low-latency chat loop** | Claude Sonnet 4.6 | Если важнее мгновенный отклик, чем frontier-level intelligence |
| **Devil's advocate** | GPT-5.5 + Claude Opus 4.7 | Самая сильная пара из разных vendor-styles |
| **Consilium (аналитика)** | GPT-5.5 + Gemini 3.1 Pro + Claude Opus 4.7 | Лучший треугольник: intelligence / science / review-balance |

---

## Источники

1. [Artificial Analysis — Intelligence Index](https://artificialanalysis.ai/intelligence)
2. [Artificial Analysis — GPT-5.5](https://artificialanalysis.ai/models/gpt-5-5)
3. [Artificial Analysis — Claude Opus 4.7](https://artificialanalysis.ai/models/claude-opus-4-7)
4. [Artificial Analysis — Gemini 3.1 Pro Preview](https://artificialanalysis.ai/models/gemini-3-1-pro-preview)
5. [Artificial Analysis — GPT-5.4](https://artificialanalysis.ai/models/gpt-5-4)
6. [Artificial Analysis — GPT-5.3 Codex](https://artificialanalysis.ai/models/gpt-5-3-codex)
7. [Artificial Analysis — Claude Opus 4.6](https://artificialanalysis.ai/models/claude-opus-4-6)
8. [Artificial Analysis — Claude Sonnet 4.6](https://artificialanalysis.ai/models/claude-sonnet-4-6)
9. [LLM Stats — Claude Sonnet 4.6](https://llmstats.net/models/claude-sonnet-4-6)
10. [LLM Stats — GPT-5.3 Codex](https://llmstats.net/models/gpt-5.3-codex)
11. [LMArena — Chat Arena Leaderboard](https://lmarena.ai/?leaderboard)
12. [Anthropic — Claude Models](https://docs.anthropic.com/en/docs/about-claude/models)
