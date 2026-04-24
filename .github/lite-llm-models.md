# Сравнение 8 AI-моделей: китайские + западные (март 2026)

> **Дата анализа:** 9 марта 2026
> **Источники:** HuggingFace model cards, arXiv papers, бенчмарки вендоров, OpenAI/Google API docs
> **Важно:** Бенчмарки китайских моделей — self-reported вендорами. Для Gemini 3 Flash, Gemini 3.1 Flash-Lite и GPT-5.3 Instant бенчмарки SWE/HLE/GPQA **не опубликованы** вендорами — оценки экстраполированы (помечены ⁺).

---

## Модели в сравнении

| # | Модель | Вендор | Архитектура | Параметры (всего / active) | Контекст (вход / выход) | Мультимод. | Лицензия |
|:-:|--------|--------|:-----------:|:--------------------------:|:-----------------------:|:----------:|:--------:|
| 1 | **Qwen3.5-397B-A17B** | Alibaba (Qwen) | MoE + Gated DeltaNet | 397B / **17B** | **262K→1M** / 32K | ✅ Img+Vid | Apache-2.0 |
| 2 | **GLM-5** | Zhipu AI (Z.ai) | MoE + DSA | 744B / **40B** | ~200K / н/д | ❌ Текст | MIT |
| 3 | **GLM-4.7** | Zhipu AI (Z.ai) | MoE | ~355B / ~32B | 200K / 128K | ❌ Текст | API (bigmodel.cn) |
| 4 | **Kimi K2.5** | Moonshot AI | MoE + MLA | **1T** / 32B | 256K / н/д | ✅ Img+Vid | Modified MIT |
| 5 | **MiniMax M2.5** | MiniMax | MoE | **229B** / н/д | н/д | ❌ Текст | Modified MIT |
| 6 | **Gemini 3 Flash** | Google | н/д (closed) | н/д | **1M** / 65K | ✅ Img+Vid+Audio | API (ai.google.dev) |
| 7 | **Gemini 3.1 Flash-Lite** | Google | н/д (closed) | н/д | **1M** / 65K | ✅ Img+Vid+Audio | API (ai.google.dev) |
| 8 | **GPT-5.3 Instant** | OpenAI | н/д (closed) | н/д | 128K / 16K | ⚠️ Img (вход) | API (ChatGPT)¹ |

> **Ценовой контекст (за 1M токенов input/output):**
> - **MiniMax M2.5:** $0.30/$2.40 (Lightning, 100 tok/s) или $0.15/$1.20 (Standard, 50 tok/s)
> - **Gemini 3.1 Flash-Lite:** $0.25/$1.50, cached $0.025/M — **самый дешёвый кеш**
> - **Gemini 3 Flash:** $0.50/$3.00, cached $0.05/M
> - **GLM-4.7:** ~$0.41/$1.92 (bigmodel.cn); FlashX: ~$0.07/$0.41; Flash: бесплатно
> - **GLM-5:** ~$0.55/$2.47 (bigmodel.cn, [0,32K) tier); [32K+): ~$0.82/$3.01
> - **Qwen3.5:** DashScope API, Apache-2.0 (self-hosting бесплатно, 17B active = минимальные ресурсы)
> - **Kimi K2.5:** platform.moonshot.ai
> - **GPT-5.3 Instant:** $1.75/**$14.00** — **самый дорогой output** в списке
>
> ¹ ChatGPT-модель. OpenAI рекомендует GPT-5.2 для API. API ID: `gpt-5.3-chat-latest`

---

## Технические особенности

### Qwen3.5-397B-A17B
- **Unified Vision-Language Foundation:** ранняя фьюжн-тренировка на мультимодальных токенах — единая модель для текста, изображений, видео
- **Gated DeltaNet + MoE:** гибридная архитектура — 512 экспертов (10 routed + 1 shared), 60 слоёв с чередованием DeltaNet и Attention
- **MTP (Multi-Token Prediction):** ускорение инференса через спекулятивное декодирование
- **201 язык**, включая редкие диалекты
- **Qwen3.5-Plus:** hosted-версия с 1M контекстом по умолчанию, встроенными tools, адаптивным tool use

### GLM-5
- **DeepSeek Sparse Attention (DSA):** длинноконтекстная обработка, sparse activation для эффективности
- **744B / 40B active** — крупнейшая модель Zhipu, MoE + DSA, MIT License (open-weight)
- **28.5T pretrain tokens,** Slime RL (async reinforcement learning)
- **HLE+tools 50.4%** — **#1 среди ВСЕХ моделей** (выше GPT-5.4 45.8, Opus 4.6 40.8, Kimi K2.5 50.2)
- **Terminal-Bench 2.0: 56.2-60.7%** — значительно выше конкурентов (Qwen3.5 54.0, Kimi 50.8, GLM-4.7 41.0)
- **MCP-Atlas 67.8, τ²-Bench 89.7** — одни из лучших агентных результатов
- **3 варианта:** GLM-5 (flagship), GLM-5-Flash (быстрый)

### GLM-4.7
- **Базируется на GLM-4.5** (355B/32B active), улучшенный пост-трейнинг для кодинга и агентных задач
- **200K контекст / 128K max output** — один из наибольших лимитов вывода среди китайских моделей
- **Structured Output (JSON):** нативная поддержка — прямая совместимость с JSON-pipelines
- **Thinking Mode:** встроенный режим рассуждений (think-before-acting)
- **LiveCodeBench V6: 84.9** — SOTA среди open-source, превосходит Claude Sonnet 4.5
- **Code Arena #1** среди open-source и китайских моделей, обходит GPT-5.2
- **3 варианта:** GLM-4.7 (flagship), GLM-4.7-FlashX (быстрый/дешёвый), GLM-4.7-Flash (бесплатный)

### Kimi K2.5
- **MLA (Multi-Latent Attention):** 384 эксперта, 8 selected + 1 shared
- **MoonViT:** визуальный энкодер 400M параметров для нативной мультимодальности
- **Agent Swarm:** уникальная возможность — декомпозиция задач на параллельные подзадачи с динамическим созданием доменных агентов
- **15T смешанных визуально-текстовых токенов** continual pretraining поверх Kimi-K2-Base
- **Thinking + Instant** режимы с interleaved tool calling

### MiniMax M2.5
- **229B — самая компактная** среди open-weight моделей в списке
- **100 tok/s** (Lightning) — в 2 раза быстрее других фронтирных моделей
- **Forge:** agent-native RL фреймворк с ~40x ускорением тренировки
- **CISPO алгоритм** для стабильности MoE при масштабном RL
- **80% нового кода MiniMax** генерируется M2.5; 30% задач компании выполняются автономно
- **$1/час** непрерывной работы при 100 tok/s

### Gemini 3 Flash
- **Самая мощная Flash-модель Google** — "для агентного анализа и vibe coding"
- **1M контекста** вход / 65K выход, Context Caching ($0.05/M cached)
- **Computer Use:** нативная поддержка управления десктопом/браузером
- **Thinking mode:** thinking_level по умолчанию "high"
- **Поддержка:** Batch API, Code Execution, File Search, Function Calling, Structured Output, URL context
- **Preview-статус:** `gemini-3-flash-preview`, Knowledge cutoff: Jan 2025, Updated: Dec 2025
- **Бенчмарки SWE/GPQA/HLE:** не опубликованы Google — оценки экстраполированы

### Gemini 3.1 Flash-Lite
- **Рабочая лошадка Google** — для экономичной работы и больших объёмов
- **1M контекста** вход / 65K выход, Context Caching ($0.025/M cached) — **самый дешёвый кеш в сравнении**
- **$0.25/$1.50** — одна из самых дешёвых моделей с 1M контекстом
- **Thinking mode:** поддерживается (в отличие от предыдущих Lite-моделей)
- **НЕТ Computer Use** (в отличие от Gemini 3 Flash)
- **Поддержка:** Batch API, Code Execution, File Search, Function Calling, Structured Output, URL context
- **Preview-статус:** `gemini-3.1-flash-lite-preview`, Updated: Mar 2026
- **Бенчмарки SWE/GPQA/HLE:** не опубликованы — оценки экстраполированы

### GPT-5.3 Instant
- **ChatGPT-модель** — оптимизирована для повседневных диалогов, **НЕ рекомендуется** OpenAI для API
- **128K контекст / 16K max output** — **наименьшие лимиты** среди всех 8 моделей
- **Цена:** $1.75/$14.00 — **самый дорогой output** среди всех моделей в списке
- **26.8% меньше галлюцинаций** с web search (vs GPT-5.2 Instant), 19.7% без поиска
- **Image Input:** только вход (фото → текст), нет видео/аудио
- **Function Calling + Structured Output** поддерживаются
- **API ID:** `gpt-5.3-chat-latest`, дата: 3 марта 2026
- **Бенчмарки SWE/GPQA/HLE:** не публикуются — модель не оценивается академическими тестами

---

## Сводная таблица: оценки по 10-балльной шкале

Критерии основаны на бенчмарках + практических особенностях. 10 = лучший в классе, 1 = худший.
**⚠ Оценки с пометкой ⁺ — экстраполированы из продуктового позиционирования (бенчмарки не опубликованы вендором).**

| Критерий | Qwen3.5 | GLM-5 | GLM-4.7 | Kimi K2.5 | MiniMax M2.5 | Gemini 3 Flash | Gemini 3.1 FL | GPT-5.3 Inst |
|----------|:-------:|:-----:|:-------:|:---------:|:------------:|:--------------:|:-------------:|:------------:|
| **Intelligence Index** | **10** | 9 | 7 | 8 | 9 | 8⁺ | 6⁺ | 7⁺ |
| **Кодинг / SWE** | 9 | 9 | 7 | 8 | 9 | 8⁺ | 6⁺ | 6⁺ |
| **Глубокое рассуждение** | **10** | 8 | 7 | 8 | 9 | 7⁺ | 6⁺ | 7⁺ |
| **Следование инструкциям** | **9** | 7 | 7 | 7 | **9** | 8⁺ | 7⁺ | 8⁺ |
| **Научные задачи (GPQA/HLE)** | **10** | 9 | 7 | 8 | 8 | 7⁺ | 5⁺ | 6⁺ |
| **Скорость генерации** | 7 | 5 | 6 | 6 | **10** | 8⁺ | **9⁺** | 7⁺ |
| **Латентность (TTFT)** | 7 | 5 | 6 | 6 | **9** | 8⁺ | **9⁺** | 7⁺ |
| **Контекстное окно** | **10** | 8 | 8 | 9 | 7 | **10** | **10** | 5 |
| **Цена / качество** | 9 | 7 | **9** | 8 | **10** | 8 | **10** | 3 |
| **Безопасность / отказы** | 8 | 8 | 8 | 7 | 7 | **9** | **9** | **9** |
| **Работа с агентами** | 8 | **10** | 7 | **10** | 9 | 9⁺ | 7⁺ | 5⁺ |
| **Мультимодальность** | **10** | 4 | 4 | 9 | 3 | 9 | 9 | 5 |
| | | | | | | | | |
| **ИТОГО (из 120)** | **107** | **89** | **83** | **94** | **99** | **99⁺** | **93⁺** | **75⁺** |
| **Средний балл** | **8.9** | **7.4** | **6.9** | **7.8** | **8.3** | **8.3⁺** | **7.8⁺** | **6.3⁺** |

---

## Расшифровка критериев

### Intelligence Index (композитный)
Совокупность самых сложных бенчмарков: GPQA Diamond, HLE, SWE-bench, AIME, HMMT, IMOAnswerBench.

- **Qwen3.5 = 10** — GPQA 92.4 (#1), HMMT Feb 99.4, **HMMT Nov 100**, AIME26 96.7, HLE 35.5, SWE 80.0
- **GLM-5 = 9** — HLE+tools **50.4% (#1 среди всех!)**, SWE 77.8%, τ²-Bench 89.7, GPQA 86.0
- **MiniMax M2.5 = 9** — AIME25 98.0, SWE 80.2, GPQA 90.0, HLE 31.4
- **Kimi K2.5 = 8** — AIME 96.1, GPQA 87.6, SWE 76.8, HLE 30.1
- **Gemini 3 Flash = 8⁺** — позиционируется как "самая мощная Flash-модель Google", предположительно на уровне Kimi/GLM-5
- **GLM-4.7 = 7** — GPQA 85.7, HLE 24.8, SWE 73.8, LiveCodeBench V6 84.9
- **GPT-5.3 Instant = 7⁺** — GPT-5.x lineage, но ChatGPT-модель без reasoning tokens
- **Gemini 3.1 Flash-Lite = 6⁺** — Lite-класс, оптимизирована для скорости/цены, не для intelligence

### Кодинг / SWE
SWE-Bench Verified, Multilingual, Pro, Terminal-Bench 2.0, LiveCodeBench, CyberGym.

- **MiniMax M2.5 = 9** — SWE-bench 80.2% (#1), Multi-SWE 51.3%, cross-scaffold стабильность, runtime 22.8 мин
- **Qwen3.5 = 9** — SWE-bench 80.0%, SWE-ML 72.0% **(#1 multilingual!)**, LiveCodeBench v6 87.7, SecCodeBench 68.3

> **⚠️ Аудит 13.03.2026 — Кодинг MiniMax vs Qwen:** Обе модели получают **9**. Разница SWE-bench = 0.2% (80.2 vs 80.0 — статистический шум). Qwen доминирует в SWE-ML (72.0% vs 51.3% — на 40% лучше) и LiveCodeBench (87.7). MiniMax сильнее в cross-scaffold стабильности и runtime (22.8 мин). Для сравнения: GPT-5.3 Codex = 10 за ДОМИНИРУЮЩИЕ позиции (TB2.0 77.3% #1, SWE-Lancer 81% #2, OSWorld 65% #2) — уровень, которого ни MiniMax, ни Qwen не достигают.
- **GLM-5 = 9** — SWE 77.8%, **TB2.0 56.2-60.7% (#1 в этом сравнении; абсолютный #1 = GPT-5.3 Codex 77.3%)**, CyberGym 43.2, BrowseComp w/ctx 75.9
- **Kimi K2.5 = 8** — SWE 76.8%, SWE-ML 73.0%, SWE-Pro 50.7%, LiveCodeBench 85.0
- **Gemini 3 Flash = 8⁺** — Google позиционирует как "vibe coding" модель, предположительно на уровне Kimi
- **GLM-4.7 = 7** — SWE 73.8%, LiveCodeBench V6 84.9 (SOTA open-source), Code Arena #1, TB2.0 41.0%
- **Gemini 3.1 Flash-Lite = 6⁺** — Lite-класс, для простых задач кодинга
- **GPT-5.3 Instant = 6⁺** — ChatGPT-модель, не оптимизирована для SWE/IDE задач

### Глубокое рассуждение
GPQA Diamond, AIME, HMMT, IMOAnswerBench, Humanity's Last Exam.

- **Qwen3.5 = 10** — HMMT Feb 99.4, **HMMT Nov 100**, AIME26 96.7, IMO 86.3, GPQA 92.4
- **MiniMax M2.5 = 9** — AIME25 98.0, GPQA 90.0
- **GLM-5 = 8** — GPQA 86.0, HLE+tools 50.4% (#1) — сильное reasoning через tools
- **Kimi K2.5 = 8** — AIME 96.1, HMMT Feb 95.4, IMO 81.8, GPQA 87.6
- **GLM-4.7 = 7** — HMMT Nov 93.5, AIME26 92.9, IMO 82.0, GPQA 85.7
- **Gemini 3 Flash = 7⁺** — thinking_level "high", но Flash-класс
- **GPT-5.3 Instant = 7⁺** — GPT-5.x reasoning базис, но нет reasoning tokens
- **Gemini 3.1 Flash-Lite = 6⁺** — thinking поддерживается, но Lite-уровень

### Следование инструкциям
IFEval, IFBench, MultiChallenge.

- **Qwen3.5 = 9** — IFEval 94.8, IFBench 75.4, MultiChallenge 57.9
- **MiniMax M2.5 = 9** — IFBench 75.0 (выше Opus 4.6 = 70.0 и Gemini = 58.0)
- **Gemini 3 Flash = 8⁺** — Structured Output нативно, Function Calling, Computer Use
- **GPT-5.3 Instant = 8⁺** — ChatGPT-специализация: полировка диалогов, instruction following
- **GLM-5 = 7** — нет публичных IFBench данных, но structured output поддерживается
- **GLM-4.7 = 7** — Structured Output (JSON) нативно, нет данных по IFBench/IFEval
- **Kimi K2.5 = 7** — нет специфичных данных по instruction-following
- **Gemini 3.1 Flash-Lite = 7⁺** — Structured Output поддерживается

### Научные задачи
GPQA Diamond, Humanity's Last Exam, HLE-Verified, SciCode, SuperGPQA.

- **Qwen3.5 = 10** — GPQA 92.4 (#1), HLE 35.5, HLE-Verified 43.3, SuperGPQA 67.9
- **GLM-5 = 9** — HLE+tools **50.4% (#1!)**, GPQA 86.0 — доминирует в scientific tool use
- **MiniMax M2.5 = 8** — GPQA 90.0, HLE 31.4, SciCode 52.0
- **Kimi K2.5 = 8** — GPQA 87.6, HLE-Full 30.1, HLE+tools 50.2
- **GLM-4.7 = 7** — HLE+tools 42.8, GPQA 85.7
- **Gemini 3 Flash = 7⁺** — Flash-класс, предположительно уровень GLM-4.7
- **GPT-5.3 Instant = 6⁺** — 26.8% меньше галлюцинаций, но нет scientific бенчмарков
- **Gemini 3.1 Flash-Lite = 5⁺** — Lite-класс, не для научных задач

### Скорость генерации
Tokens per second при инференсе.

- **MiniMax M2.5 = 10** — 100 tok/s (Lightning), 50 tok/s (Standard); "в 2 раза быстрее других"
- **Gemini 3.1 Flash-Lite = 9⁺** — Lite = максимальная оптимизация скорости, Google инфраструктура
- **Gemini 3 Flash = 8⁺** — Flash-класс, быстрее Pro, Google TPU инфраструктура
- **Qwen3.5 = 7** — 17B active (минимум среди open-weight), MTP ускорение, точная скорость не раскрыта
- **GPT-5.3 Instant = 7⁺** — "Instant" в названии подразумевает быструю генерацию
- **Kimi K2.5 = 6** — 32B active, MLA для эффективности, скорость не раскрыта
- **GLM-4.7 = 6** — ~32B active, 30-50 tok/s (документировано)
- **GLM-5 = 5** — 40B active, 744B total — самая тяжёлая модель (кроме Kimi)

### Латентность (Time to First Token)
Время до первого токена. Критично для интерактивных сценариев.

- **MiniMax M2.5 = 9** — компактная модель (229B) + оптимизированный инференс
- **Gemini 3.1 Flash-Lite = 9⁺** — Lite = минимальная латентность
- **Gemini 3 Flash = 8⁺** — Flash-класс на Google TPU
- **Qwen3.5 = 7** — 17B active обеспечивают быстрый старт
- **GPT-5.3 Instant = 7⁺** — OpenAI инфраструктура, "Instant" позиционирование
- **Kimi K2.5 = 6** — 32B active + thinking mode увеличивает латентность
- **GLM-4.7 = 6** — ~32B active, быстрее GLM-5
- **GLM-5 = 5** — 40B active, 744B total — наибольшая латентность

> ⚠️ Точные TTFT для большинства моделей недоступны. Оценки основаны на размерах active-части и позиционировании.

### Контекстное окно
Нативный контекст модели + расширение.

- **Qwen3.5 = 10** — 262K нативно, **до 1.01M с YaRN**. Qwen3.5-Plus: 1M по умолчанию
- **Gemini 3 Flash = 10** — **1M нативно** / 65K output
- **Gemini 3.1 Flash-Lite = 10** — **1M нативно** / 65K output
- **Kimi K2.5 = 9** — 256K нативно
- **GLM-5 = 8** — ~200K (DSA для длинного контекста)
- **GLM-4.7 = 8** — 200K, max output 128K. Context caching поддерживается
- **MiniMax M2.5 = 7** — не раскрыт. Предшественник MiniMax-M1 поддерживал 1M
- **GPT-5.3 Instant = 5** — **128K** — наименьший в сравнении. Max output 16K

### Цена / качество
Стоимость API, self-hosting, соотношение к производительности.

- **MiniMax M2.5 = 10** — $0.30/$2.40 (Lightning). **$1/час.** 10-20x дешевле Opus/GPT-5. 229B = самый дешёвый self-host
- **Gemini 3.1 Flash-Lite = 10** — $0.25/$1.50 + **1M контекст** — лучшее соотношение $/контекст. Cached: $0.025/M
- **Qwen3.5 = 9** — Apache-2.0 (бесплатный self-hosting), 17B active = минимальные ресурсы
- **GLM-4.7 = 9** — ~$0.41/$1.92; FlashX: ~$0.07/$0.41; **Flash: бесплатно**
- **Gemini 3 Flash = 8** — $0.50/$3.00 — умеренная цена, 1M контекст, cached $0.05/M
- **Kimi K2.5 = 8** — Modified MIT, 32B active, 1T total = дорогой self-hosting
- **GLM-5 = 7** — ~$0.55/$2.47 — дороже GLM-4.7, MIT license для self-host
- **GPT-5.3 Instant = 3** — $1.75/**$14.00** output — **самый дорогой** в списке. 128K контекст. Не оптимизирован для API

### Безопасность / минимизация отказов

- **Gemini 3 Flash = 9** — Google safety pipeline, масштабное тестирование, прозрачные safety reports
- **Gemini 3.1 Flash-Lite = 9** — аналогично Gemini 3 Flash, Google safety
- **GPT-5.3 Instant = 9** — OpenAI safety, **26.8% меньше галлюцинаций**, system card опубликована
- **Qwen3.5 = 8** — 201 язык, масштабный safety pipeline, Apache-2.0 позволяет аудит
- **GLM-5 = 8** — MIT license, Tsinghua/Zhipu академический фон
- **GLM-4.7 = 8** — Z.ai API с базовыми safety-гарантиями
- **Kimi K2.5 = 7** — Modified MIT, базовый safety
- **MiniMax M2.5 = 7** — Modified MIT, фокус на производительности

### Работа с агентами
Tool calling, agentic loops, browse/search, multi-step task completion, computer use.

- **GLM-5 = 10** — HLE+tools **50.4% (#1!)**, τ²-Bench 89.7, MCP-Atlas 67.8, BrowseComp w/ctx 75.9, CyberGym 43.2
- **Kimi K2.5 = 10** — **Agent Swarm (уникален!)**: BrowseComp Swarm 78.4, WideSearch Swarm 79.0, Seal-0 57.4
- **MiniMax M2.5 = 9** — BrowseComp 76.3, Forge RL, 20% меньше шагов, runtime 22.8 мин
- **Gemini 3 Flash = 9⁺** — **Computer Use** (уникально в Flash-классе!), Function Calling, Thinking, Code Execution
- **Qwen3.5 = 8** — τ²-Bench 87.1, Tool-Decathlon 43.8-46.3, MCP-Mark 57.5
- **GLM-4.7 = 7** — HLE+tools 42.8, τ²-Bench 87.4, Function Calling + Structured Output нативно
- **Gemini 3.1 Flash-Lite = 7⁺** — Function Calling, Thinking, но **нет Computer Use**, Lite-уровень
- **GPT-5.3 Instant = 5⁺** — Function Calling + Structured Output, но нет Computer Use / tools / MCP

### Мультимодальность
Нативная работа с изображениями, видео, аудио.

- **Qwen3.5 = 10** — полная мультимодальность: нативная early-fusion для Img+Vid+Text. MMMU 85.0, VideoMME 87.5, 201 язык
- **Kimi K2.5 = 9** — MoonViT (400M), Image+Video. MMMU-Pro 78.5, MathVision 84.2, VideoMME 87.4
- **Gemini 3 Flash = 9** — Image+Video+Audio+PDF нативно, Google multimodal pipeline
- **Gemini 3.1 Flash-Lite = 9** — аналогично Gemini 3 Flash (Image+Video+Audio+PDF)
- **GPT-5.3 Instant = 5** — **только Image input** (фото → текст), нет видео/аудио
- **GLM-5 = 4** — **только текст** (визуальные модели — отдельная серия GLM-V)
- **GLM-4.7 = 4** — **только текст**
- **MiniMax M2.5 = 3** — **только текст**. Нет vision encoder

---

## Рейтинг по сценариям использования

### 1. Кодинг / разработка (IDE, агенты, code review)
1. **MiniMax M2.5** — SWE-bench #1 (80.2%), кросс-скаффолд стабильность, $1/час, 100 tok/s
2. **Qwen3.5** — SWE-bench 80.0%, LiveCodeBench 87.7, 17B active — лучший для self-hosted
3. **GLM-5** — SWE 77.8%, TB2.0 56.2-60.7% (#1), CyberGym 43.2
4. **Gemini 3 Flash** ⁺ — "vibe coding", 1M контекст для больших кодовых баз, Computer Use
5. **GLM-4.7** — LiveCodeBench V6 84.9 (SOTA open-source), Code Arena #1, бесплатный Flash-вариант
6. **Kimi K2.5** — SWE-Pro 50.7%, Agent Swarm для multi-file задач
7. **Gemini 3.1 Flash-Lite** ⁺ — для массовых простых задач ($0.25/$1.50)
8. **GPT-5.3 Instant** ⁺ — не предназначен для IDE/SWE, дорог ($14/M output)

### 2. Научные исследования / сложные вопросы
1. **Qwen3.5** — GPQA 92.4 (#1), HMMT 100%, мультимодальность для диаграмм/формул
2. **GLM-5** — HLE+tools 50.4% (#1) — лучший в научном tool use
3. **Kimi K2.5** — визуальный анализ статей, HLE+tools 50.2, GPQA 87.6
4. **MiniMax M2.5** — GPQA 90.0, SciCode 52.0, но нет мультимодальности
5. **GLM-4.7** — HLE+tools 42.8, GPQA 85.7
6. **Gemini 3 Flash** ⁺ — 1M контекст для длинных документов, multimodal
7. **GPT-5.3 Instant** ⁺ — меньше галлюцинаций, но 128K контекст и нет бенчмарков
8. **Gemini 3.1 Flash-Lite** ⁺ — Lite-класс, не для фронтирной науки

### 3. Агентные задачи / search / tool use
1. **Kimi K2.5** — **Agent Swarm — единственная модель с multi-agent.** BrowseComp Swarm 78.4
2. **GLM-5** — HLE+tools 50.4% (#1), τ²-Bench 89.7, MCP-Atlas 67.8
3. **MiniMax M2.5** — BrowseComp 76.3, эффективные циклы (20% меньше шагов)
4. **Gemini 3 Flash** ⁺ — Computer Use + Function Calling + Thinking = сильный агент
5. **Qwen3.5** — MCP-Mark 57.5, Tool-Decathlon 43.8, τ²-Bench 87.1
6. **GLM-4.7** — HLE+tools 42.8, τ²-Bench 87.4, BrowseComp w/ctx 67.5
7. **Gemini 3.1 Flash-Lite** ⁺ — Function Calling + Thinking, но нет Computer Use
8. **GPT-5.3 Instant** ⁺ — Function Calling есть, но ChatGPT-модель без agent-оптимизации

### 4. Мультимодальные задачи (UI, видео, документы)
1. **Qwen3.5** — early-fusion мультимодальность, MMMU 85.0, VideoMME 87.5, OSWorld 62.2
2. **Kimi K2.5** — MoonViT, Visual Agentic Intelligence, ScreenSpot Pro, VideoMMMU 86.6
3. **Gemini 3 Flash** ⁺ — Image+Video+Audio+PDF нативно, Computer Use для UI
4. **Gemini 3.1 Flash-Lite** ⁺ — Image+Video+Audio+PDF, но Lite-уровень
5. **GPT-5.3 Instant** — Image input only, ограниченно
6. ~~GLM-5~~ — text-only
7. ~~GLM-4.7~~ — text-only
8. ~~MiniMax M2.5~~ — text-only

### 5. Производственные задачи / масштабирование / бюджет
1. **Gemini 3.1 Flash-Lite** — **$0.25/$1.50 + 1M контекст** — лучшее $/качество для объёмных задач
2. **MiniMax M2.5** — $0.30/$2.40, 100 tok/s, 229B = минимальные HW-ресурсы
3. **GLM-4.7** — FlashX: $0.07/$0.41; **Flash: бесплатно** — идеально для прототипирования
4. **Qwen3.5** — Apache-2.0, 17B active, бесплатный self-hosting
5. **Gemini 3 Flash** — $0.50/$3.00, 1M контекст, Context Caching
6. **GLM-5** — ~$0.55/$2.47, MIT license для self-host
7. **Kimi K2.5** — 1T total = требует серьёзных ресурсов
8. **GPT-5.3 Instant** — $1.75/$14.00 — **наименее экономичен** среди всех

---

## Детальные бенчмарки (cross-reference таблица)

Данные из model cards китайских моделей. Для Gemini/GPT-5.3 Instant бенчмарки не опубликованы вендорами.

### Reasoning & Knowledge

| Бенчмарк | Qwen3.5 | GLM-5 | GLM-4.7 | Kimi K2.5 | MiniMax M2.5 | _Ref: Opus 4.6_ | _Ref: GPT-5.4_ |
|-----------|:-------:|:-----:|:-------:|:---------:|:------------:|:----------------:|:---------------:|
| **GPQA Diamond** | **92.4** | 86.0 | 85.7 | 87.6 | 90.0 | ~82-91¹ | 91.9 |
| **HLE** | **35.5** | — | 24.8 | 30.1² | 31.4 | 25.1 | 37.2 |
| **HLE w/ Tools** | 45.5 | **50.4** | 42.8 | 50.2 | — | 40.8 | 45.8 |
| **AIME 2025** | — | — | — | **96.1** | 98.0³ | ~93 | ~96 |
| **AIME 2026 I** | **96.7** | 92.9⁴ | 92.9 | — | — | 92.7 | 90.6 |
| **HMMT Feb 2025** | **99.4** | — | — | 95.4 | — | ~93 | ~97 |
| **HMMT Nov 2025** | **97.1** | — | 93.5 | 91.1 | — | 90.2 | 93.0 |
| **IMOAnswerBench** | **86.3** | 82.0 | 82.0 | 81.8 | — | 78.3 | 83.3 |
| **MMLU-Pro** | 87.4 | — | — | 87.1 | — | ~87 | ~90 |
| **IFBench** | **75.4** | — | — | — | 75.0 | 70.0⁵ | 53.0⁵ |

¹ Разброс из-за разных версий (Opus 4.5 vs 4.6)
² HLE-Full (включая визуальные задачи)
³ AIME 2025, не 2026
⁴ GLM-5 blog (AIME 2026)
⁵ По данным MiniMax appendix

> **Gemini 3 Flash, Gemini 3.1 Flash-Lite, GPT-5.3 Instant** — данные по этим бенчмаркам не опубликованы.

### Coding & Engineering

| Бенчмарк | Qwen3.5 | GLM-5 | GLM-4.7 | Kimi K2.5 | MiniMax M2.5 | _Ref: Opus 4.6_ | _Ref: GPT-5.4_ |
|-----------|:-------:|:-----:|:-------:|:---------:|:------------:|:----------------:|:---------------:|
| **SWE-bench Verified** | 80.0 | 77.8 | 73.8 | 76.8 | **80.2** | ~73-79¹ | 76.2 |
| **SWE-bench Multilingual** | 72.0 | — | 66.7 | **73.0** | — | 70.2 | 65.0 |
| **SWE-bench Pro** | — | — | — | **50.7** | — | — | — |
| **Multi-SWE-bench** | — | — | — | — | **51.3** | — | — |
| **Terminal-Bench 2.0** | 54.0 | **56.2-60.7** | 41.0 | 50.8 | — | 39.3-46.4 | 54.2 |
| **LiveCodeBench v6** | **87.7** | — | 84.9 | 85.0 | — | — | ~87 |
| **CyberGym** | — | **43.2** | 23.5 | 41.3 | — | 17.3 | 39.9 |
| **SecCodeBench** | **68.3** | — | — | — | — | — | — |
| **PaperBench** | — | — | — | **63.5** | — | — | — |

¹ Разные scaffolding дают разные результаты

> **Gemini 3 Flash, Gemini 3.1 Flash-Lite, GPT-5.3 Instant** — SWE/coding бенчмарки не опубликованы.

### Agentic & Search

| Бенчмарк | Qwen3.5 | GLM-5 | GLM-4.7 | Kimi K2.5 | MiniMax M2.5 | _Ref: Gemini 3.1 Pro_ |
|-----------|:-------:|:-----:|:-------:|:---------:|:------------:|:---------------------:|
| **BrowseComp (basic)** | **65.8** | 62.0 | 52.0 | 60.6 | — | 37.0 |
| **BrowseComp (w/ ctx mgmt)** | 65.8 | 75.9 | 67.5 | 74.9 | **76.3** | 67.8 |
| **BrowseComp (Agent Swarm)** | — | — | — | **78.4** | — | — |
| **BrowseComp-Zh** | **76.1** | — | — | 62.3 | — | 62.4 |
| **WideSearch** | — | — | — | 72.7/79.0¹ | — | — |
| **τ²-Bench** | 85.5 | **89.7** | 87.4 | 80.2 | — | 91.6² |
| **MCP-Atlas** | — | **67.8** | 52.0 | 63.8 | — | 65.2 |
| **MCP-Mark** | **57.5** | — | — | — | — | — |
| **Tool-Decathlon** | **43.8-46.3** | — | 23.8 | 27.8 | — | 43.5 |
| **Seal-0** | 45.0³ | — | — | **57.4** | — | 47.7 |

¹ 79.0 с Agent Swarm
² Gemini 3.1 Pro — сильнейший в τ²-Bench
³ Из GLM-4.7 blog

> **Gemini 3 Flash** поддерживает Computer Use + Function Calling + Thinking, но без опубликованных бенчмарков.
> **Gemini 3.1 Flash-Lite** поддерживает Function Calling + Thinking (без Computer Use).
> **GPT-5.3 Instant** поддерживает Function Calling, без агентных бенчмарков.

### Vision & Multimodal (Qwen3.5, Kimi K2.5 + Reference)

| Бенчмарк | Qwen3.5 | Kimi K2.5 | _Ref: Gemini 3.1 Pro_ |
|-----------|:-------:|:---------:|:---------------------:|
| **MMMU** | **85.0** | — | 80.7 |
| **MMMU-Pro** | 79.0 | **78.5** | 70.6 |
| **MathVision** | 83.0 | **84.2** | 74.3 |
| **VideoMME (w/ sub)** | **87.5** | 87.4 | 77.6 |
| **VideoMMMU** | 84.7 | **86.6** | 84.4 |
| **ScreenSpot Pro** | 65.6 | — | 45.7 |
| **OSWorld-Verified** | 62.2 | — | 66.3¹ |
| **OCRBench** | **93.1** | 92.3 | 80.7 |
| **OmniDocBench 1.5** | **90.8** | 88.8 | 85.7 |

¹ Gemini лидирует в OSWorld

> **Gemini 3 Flash / 3.1 Flash-Lite:** мультимодальные (Img+Vid+Audio+PDF), но vision-бенчмарки не опубликованы.
> **GPT-5.3 Instant:** только Image input, vision-бенчмарки не опубликованы.
> **GLM-5, GLM-4.7, MiniMax M2.5:** text-only, таблица не применима.

---

## Ключевые выводы

### 1. Китайские модели vs западные
Китайские frontier-модели закрыли разрыв и превосходят западных лидеров в ряде бенчмарков:
- **SWE-bench:** MiniMax M2.5 (80.2) > Opus 4.6 (~73-80) > GPT-5.4 (76.2)
- **HLE+tools:** GLM-5 (50.4) > Kimi K2.5 (50.2) > GPT-5.4 (45.8) > Opus 4.6 (40.8)
- **Математика:** Qwen3.5 HMMT Nov = **100%** — идеальный результат
- **TB2.0:** GLM-5 (56.2-60.7) > Qwen3.5 (54.0) > GPT-5.4 (54.2)
- **Цена:** MiniMax (100 tok/s, $1/час) и GLM-4.7-Flash (бесплатно) — в 10-100x дешевле западных

### 2. Западные модели: уникальные преимущества
- **Gemini 3 Flash / 3.1 FL:** **1M нативный контекст** — единственные в списке с таким контекстом без YaRN
- **Gemini 3 Flash:** **Computer Use в Flash-классе** — уникальная возможность
- **Gemini 3.1 Flash-Lite:** **$0.25/$1.50 + 1M** — лучший $/контекст ratio
- **GPT-5.3 Instant:** лучший в **минимизации галлюцинаций** для диалогов (26.8% improvement)

### 3. Главная проблема: отсутствие бенчмарков у западных fast-моделей
Google и OpenAI **не публикуют** SWE/GPQA/HLE бенчмарки для Flash/Lite/Instant моделей, что делает прямое сравнение невозможным. Оценки для них — экстраполяция.

### 4. Специализация — ключевой дифференциатор

| Сильная сторона | Лидер | Детали |
|-----------------|-------|--------|
| **Мультимодальность** | Qwen3.5 | Early-fusion, 201 язык, видео нативно |
| **Агенты / tools** | GLM-5 / Kimi K2.5 | GLM-5: HLE+tools #1. Kimi: Agent Swarm |
| **Эффективность / скорость** | MiniMax M2.5 | 100 tok/s, $1/час, 229B |
| **Контекст + бюджет** | Gemini 3.1 Flash-Lite | 1M + $0.25/$1.50 |
| **Computer Use** | Gemini 3 Flash | Единственная Flash-модель с Computer Use |
| **Математика / reasoning** | Qwen3.5 | HMMT 100%, GPQA 92.4, IMO 86.3 |
| **Self-hosting** | Qwen3.5 (Apache-2.0) | 17B active = минимальные ресурсы |
| **Диалоги / антигаллюц.** | GPT-5.3 Instant | 26.8% меньше галлюцинаций |

### 5. Ограничения

| Модель | Ограничения |
|--------|------------|
| **Qwen3.5** | Точная скорость не раскрыта; hosted-версия (Plus) not fully open |
| **GLM-5** | Text-only; 744B → медленнее GLM-4.7; дороже |
| **GLM-4.7** | Text-only; слабее GLM-5 в агентных бенчмарках |
| **Kimi K2.5** | 1T — самые высокие HW-ресурсы для self-host |
| **MiniMax M2.5** | Text-only; контекстное окно не раскрыто |
| **Gemini 3 Flash** | Preview-статус; бенчмарки не опубликованы |
| **Gemini 3.1 FL** | Preview-статус; нет Computer Use; бенчмарки не опубликованы |
| **GPT-5.3 Instant** | $14/M output; 128K/16K — наименьшие лимиты; ChatGPT-модель; нет бенчмарков |

### 6. Общие тенденции
1. **MoE доминирует** — все 5 китайских моделей используют MoE (17-40B active из 229B-1T)
2. **RL-масштабирование** — Forge (MiniMax), Scalable RL (Qwen), Slime RL (GLM-5)
3. **Цена обрушилась** — MiniMax $1/час, GLM-4.7-Flash бесплатно, Gemini 3.1 FL $0.25/$1.50
4. **1M контекст = новый стандарт** — Gemini нативно, Qwen3.5 через YaRN, остальные 200-256K
5. **Western fast-models = black box** — нет бенчмарков, невозможно сравнить объективно

---

## Доступность на NVIDIA Build (март 2026)

> **Источник:** https://build.nvidia.com — скрейпинг 13 марта 2026
> **Фильтр:** издатели Qwen, Moonshot, MiniMax, Z.ai, ByteDance, Baidu

Все 5 китайских frontier-моделей из этого сравнения доступны на NVIDIA Build (NIM API / Downloadable).
ByteDance и Baidu **НЕ имеют** frontier general-purpose LLM на платформе.

### Сводка по издателям

| Издатель | Всего моделей | Frontier в нашем сравнении | Прочие модели на NVIDIA Build |
|----------|:-------------:|:--------------------------:|-------------------------------|
| **Qwen** (Alibaba) | 10 | **Qwen3.5-397B-A17B** ✅ | Qwen3.5-122B-A10B¹, Qwen3-Coder-480B-A35B², Qwen3-Next-80B (×2), QwQ-32B, Qwen2.5 (×3), Qwen2-7B |
| **Moonshotai** | 4 | **Kimi K2.5** ✅ | Kimi-K2-Thinking, Kimi-K2-Instruct-0905, Kimi-K2-Instruct |
| **MinimaxAI** | 2 | **MiniMax M2.5** ✅ | MiniMax-M2.1 |
| **Z.ai** (Zhipu) | 2 | **GLM-5** ✅, **GLM-4.7** ✅ | — |
| **ByteDance** | 1 | — | Seed-OSS-36B-Instruct³ |
| **Baidu** | 1 | — | PaddleOCR⁴ |

¹ **Qwen3.5-122B-A10B** — малый сиблинг Qwen3.5: 122B total / 10B active. Рейтинг: 1.49M загрузок, 1 неделя назад. Потенциально интересен для бюджетного self-hosting (7B меньше active чем основной 17B)
² **Qwen3-Coder-480B-A35B** — специализированный кодер: 480B MoE / 35B active, 256K контекст. Для agentic coding и browser use. НЕ general-purpose
³ **Seed-OSS-36B** — 36B dense, не frontier (6 месяцев назад). Для long-context reasoning — не конкурент frontier MoE
⁴ **PaddleOCR** — модель распознавания текста в изображениях. Не LLM

### Модели НЕ на NVIDIA Build

| Модель | Почему нет на NVIDIA Build | Где доступна |
|--------|---------------------------|---------------|
| **Gemini 3 Flash** | Google не публикует на сторонних платформах | ai.google.dev API |
| **Gemini 3.1 Flash-Lite** | Google не публикует на сторонних платформах | ai.google.dev API |
| **GPT-5.3 Instant** | OpenAI не публикует на сторонних платформах | api.openai.com (ChatGPT-модель) |

### Вывод по NVIDIA Build

- **100% покрытие** китайских frontier-моделей из этого сравнения на NVIDIA Build
- **ByteDance Doubao / ERNIE 4.0** — отсутствуют. У ByteDance только мелкая Seed-OSS-36B, у Baidu только OCR
- **Дополнительный интерес:** Qwen3.5-122B-A10B (10B active = ещё легче для self-host) и Qwen3-Coder-480B-A35B (спец. кодер)
- **NIM API** доступен для: Qwen3.5-397B, Kimi K2.5, MiniMax M2.5, GLM-5, GLM-4.7 (бесплатный serverless endpoint для разработки)

---

## Общая таблица: максимальные параметры под нашу GTM CAPI задачу

Профиль нашей задачи одинаковый для `analyze-site`, `suggest-parameters`, `analyze-events`, `pre-publish-check`:
- **System prompt reserve:** 4K
- **User/business context reserve:** 6K
- **Structured JSON output reserve:** 5K
- **Safety reserve:** 1K
- **Итого постоянный резерв:** **16K токенов**

Формула для сырого полезного входа:

$$
usable\_payload\_tokens = context\_window - 16000
$$

Практический лимит HTML в проекте:

$$
max\_html\_chars \approx usable\_payload\_tokens \times 4
$$

Сверху всё равно имеет смысл держать **cap около 800K символов**, чтобы не раздувать latency и цену без полезного прироста качества.

| Модель | Контекст окна | Полезный payload после резерва 16K | Практический max HTML для `analyze-site` | Запас под JSON 0.5-5K | Что это значит для нашей задачи |
|--------|:-------------:|:----------------------------------:|:----------------------------------------:|:----------------------:|---------------------------------|
| **Gemini 3 Flash** | **1M** | **984K токенов** | **800K cap** | Очень высокий | Лучший запас для больших сайтов, длинных dataLayer dumps и многошагового анализа |
| **Gemini 3.1 Flash-Lite** | **1M** | **984K токенов** | **800K cap** | Очень высокий | Лучший бюджетный вариант для массового `analyze-site` и batch-задач |
| **Qwen3.5** | 262K нативно, до 1M с YaRN/Plus | **246K токенов** нативно | **800K cap** (теор. ~984K chars) | Высокий | Оптимален для self-host / гибридного режима; хватает на тяжёлые страницы даже без 1M |
| **Kimi K2.5** | 256K | **240K токенов** | **800K cap** (теор. ~960K chars) | Высокий | Хорошо подходит для `analyze-site` и сложного `analyze-events`, особенно если нужен multimodal контекст |
| **GLM-5** | ~200K | **184K токенов** | **~736K chars** | Высокий | Комфортно тянет весь наш pipeline, но для очень тяжёлых HTML уступает 1M-моделям |
| **GLM-4.7** | 200K | **184K токенов** | **~736K chars** | Очень высокий | Практичный компромисс: хватает под все 4 endpoint, плюс огромный запас по output |
| **GPT-5.3 Instant** | 128K | **112K токенов** | **~448K chars** | Нормальный | Подходит для `suggest-parameters`, `pre-publish-check`, средних `analyze-site`; слабый выбор для очень больших страниц |
| **MiniMax M2.5** | н/д публично | н/д | н/д | Вероятно достаточный | Силен по качеству/скорости, но без публичного контекстного лимита я бы не ставил его основным для тяжёлого `analyze-site` без принудительного trim |

### Практический вывод именно под наш модуль

| Endpoint | Лучший класс моделей | Почему |
|----------|----------------------|--------|
| **`analyze-site`** | Gemini 3 Flash / Gemini 3.1 Flash-Lite / Qwen3.5 | Самая чувствительная точка к размеру HTML, schema.org, scripts, forms, dataLayer |
| **`suggest-parameters`** | Почти все, кроме дорогого GPT-5.3 Instant по бюджету | Здесь вход уже уже, и 128K обычно достаточно |
| **`analyze-events`** | GLM-5 / Qwen3.5 / Kimi K2.5 | Важны reasoning + JSON discipline, а не только сырой контекст |
| **`pre-publish-check`** | GLM-4.7 / Gemini 3.1 Flash-Lite / GPT-5.3 Instant | Небольшой вход, нужен аккуратный структурированный ответ |

### Если свести к одному числу для нашей задачи

| Модель | Итог по GTM CAPI fit |
|--------|:--------------------:|
| **Gemini 3 Flash** | **10/10** |
| **Gemini 3.1 Flash-Lite** | **9.5/10** |
| **Qwen3.5** | **9.5/10** |
| **Kimi K2.5** | **9/10** |
| **GLM-5** | **8.5/10** |
| **GLM-4.7** | **8/10** |
| **MiniMax M2.5** | **7.5/10** |
| **GPT-5.3 Instant** | **6.5/10** |

> Если критерий номер один — **не резать большие страницы**, то топ-3 для нашего GTM CAPI модуля: **Gemini 3 Flash**, **Gemini 3.1 Flash-Lite**, **Qwen3.5**.

---

## Кросс-референс с топовыми моделями (top-llm-models.md)

Для сопоставления оценок lite-моделей с western frontier (из [top-llm-models.md](top-llm-models.md)):

| Критерий | _Qwen3.5_ | _MiniMax M2.5_ | Gemini 3.1 Pro | GPT-5.4 | Claude Opus 4.6 | GPT-5.3 Codex |
|----------|:---------:|:--------------:|:--------------:|:-------:|:---------------:|:-------------:|
| **Intelligence Index** | **10** | 9 | **10** (AA 57) | **10** (AA 57) | 8 (AA 53) | 9 (AA 54) |
| **Кодинг / SWE** | **9** | 9 | 8 | 9 | 9 | **10** |
| **Глубокое рассуждение** | **10** | 9 | 9 | **10** | **10** | 8 |
| **Следование инструкциям** | **9** | **9** | 9 | 8 | **10** | 8 |
| **Научные задачи** | **10** | 8 | **10** | 9 | 9 | 7 |
| **Скорость генерации** | 7 | **10** | **10** | 8 | 5 | 7 |
| **Латентность (TTFT)** | 7 | **9** | 8 | 3 | **10** | 5 |
| **Контекстное окно** | **10** ¹ | 7 | 5 ² | **10** ² | 7 ² | **10** ² |
| **Цена / качество** | 9 | **10** | **10** | 8 | 5 | 9 |
| **Безопасность / отказы** | 8 | 7 | 7 | 8 | **10** | 8 |
| **Работа с агентами** | 8 | 9 | 9 | 8 | 9 | **10** |
| **Мультимодальность** | **10** | 3 | **10** | 9 | 7 | 6 |
| | | | | | | |
| **ИТОГО (из 120)** | **107** | **99** | **105** | **100** | **99** | **97** |
| **Средний балл** | **8.9** | **8.25** | **8.8** | **8.3** | **8.3** | **8.1** |

¹ Контекстное окно lite-моделей = нативный API-контекст модели
² Контекстное окно top-моделей = реальный VS Code лимит (см. top-llm-models.md). **Шкалы разные!** Gemini 3.1 Pro API = 1M, но VS Code = 173K → 5 баллов

> **⚠ ВНИМАНИЕ:** Оценки контекстного окна НЕСОПОСТАВИМЫ между документами. lite-models.md измеряет нативный контекст API (1M Gemini = 10), top-llm-models.md измеряет реальный VS Code контекст (173K Gemini = 5). Для честного сравнения нужно выбрать одну линейку.

> **Рейтинг по итогам:** Qwen3.5 (107) > Gemini 3.1 Pro (105) > GPT-5.4 (100) > MiniMax M2.5 / Claude Opus 4.6 / Gemini 3 Flash (99) > GPT-5.3 Codex (97)

---

## Рекомендации для проекта

Для текущего Godot-first workspace:

| Задача | Рекомендация | Почему |
|--------|-------------|--------|
| **Daily coding (IDE)** | MiniMax M2.5 | SWE #1, 100 tok/s, $1/час |
| **Сложный рефакторинг** | Qwen3.5 / MiniMax M2.5 | Qwen: 17B active + 262K. MiniMax: SWE 80.2% |
| **Научный анализ** | Qwen3.5 | GPQA 92.4, мультимодальность, 1M контекст |
| **Агентные пайплайны** | GLM-5 / Kimi K2.5 | GLM-5: HLE+tools #1. Kimi: Agent Swarm |
| **UI/визуальный анализ** | Qwen3.5 / Gemini 3 Flash | Qwen: MMMU 85.0. Gemini: Computer Use + 1M |
| **Анализ длинных документов** | Gemini 3 Flash / Gemini 3.1 FL | 1M нативный контекст |
| **Массовая обработка (batch)** | Gemini 3.1 Flash-Lite | $0.25/$1.50, 1M контекст, Batch API |
| **Production at scale** | MiniMax M2.5 | $1/час, 100 tok/s, 229B |
| **Бюджетный self-host** | Qwen3.5 (17B active) | Apache-2.0, минимальные ресурсы |
| **Прототипирование (free)** | GLM-4.7-Flash | **Бесплатно**, 200K контекст |
| **Повседневные вопросы** | GPT-5.3 Instant | Меньше галлюцинаций, хороший тон ответов |

---

## Источники

1. [Qwen3.5-397B-A17B — HuggingFace Model Card](https://huggingface.co/Qwen/Qwen3.5-397B-A17B)
2. [GLM-5 — Z.ai Blog](https://z.ai/blog/glm-5)
3. [GLM-4.7 — Z.ai API Docs](https://docs.z.ai/guides/llm/glm-4.7)
4. [Kimi K2.5 — HuggingFace Model Card](https://huggingface.co/moonshotai/Kimi-K2.5)
5. [MiniMax M2.5 — HuggingFace Model Card](https://huggingface.co/MiniMaxAI/MiniMax-M2.5)
6. [Gemini 3 Flash — Google AI Docs](https://ai.google.dev/gemini-api/docs/models/gemini-3-flash-preview)
7. [Gemini 3.1 Flash-Lite — Google AI Docs](https://ai.google.dev/gemini-api/docs/models/gemini-3.1-flash-lite-preview)
8. [Gemini API Pricing](https://ai.google.dev/gemini-api/docs/pricing)
9. [GPT-5.3 Instant — OpenAI Blog](https://openai.com/index/gpt-5-3-instant/)
10. [GPT-5.3 Chat — OpenAI Developers](https://developers.openai.com/api/docs/models/gpt-5.3-chat-latest)
11. [OpenAI API Pricing](https://openai.com/api/pricing/)
12. [GLM-4.7 API Pricing — BigModel.cn](https://open.bigmodel.cn/pricing)
13. [Kimi K2.5 — arXiv:2602.02276](https://arxiv.org/abs/2602.02276)
14. [Kimi K2.5 Tech Blog](https://www.kimi.com/blog/kimi-k2-5.html)
15. [MiniMax M2.5 — Forge: Scalable Agent RL Framework](https://huggingface.co/MiniMaxAI/MiniMax-M2.5)
16. [Qwen3.5 Blog](https://qwen.ai/blog?id=qwen3.5)
