# Agent Registry

Полный реестр агентов проекта. Все агенты определены в `.github/agents/`.

## Иерархия

```
User
├── @Conductor (Claude Opus 4.6 (copilot)) ─────── Оркестратор полного цикла
│   ├── Planning-subagent (Claude Opus 4.6 (copilot))
│   ├── Implement-subagent (GPT-5.4 (copilot))
│   ├── Code-review-subagent (GPT-5.3-Codex (copilot))
│   ├── Proscons-devils-advocate (GPT-5.4 (copilot))
│   └── UI-Governor (Gemini 3.1 Pro (Preview) (copilot))
│
├── @Consilium-Boss (Claude Opus 4.6 (copilot)) ── Мультимодельный анализ
│   ├── Consilium-Sonnet (Claude Sonnet 4.6 (copilot)) — архитектура, системные паттерны
│   ├── Consilium-Opus (Claude Opus 4.6 (copilot)) — глубокий reasoning, скрытые допущения
│   ├── Consilium-Gemini (Gemini 3.1 Pro (Preview) (copilot)) — кросс-система, ops, security
│   ├── Consilium-Codex (GPT-5.3-Codex (copilot)) — трассировка исполнения кода
│   ├── Consilium-Devil (GPT-5.3-Codex (copilot)) — атака с угла кода
│   ├── Consilium-Devil-GPT (GPT-5.4 (copilot)) — атака с угла логики
│   ├── Consilium-Devil-Sonnet (Claude Sonnet 4.6 (copilot)) — атака с угла архитектуры
│   └── Consilium-Devil-Gemini (Gemini 3.1 Pro (Preview) (copilot)) — атака с угла ops/security
│
└── @Security-Boss (Claude Opus 4.6 (copilot)) ─── Автономный аудит безопасности
    ├── Security-Injection (GPT-5.3-Codex (copilot)) — SQL/ORM, command, template injection, SSRF
    ├── Security-Auth (Claude Opus 4.6 (copilot)) — auth bypass, IDOR, privilege escalation, JWT
    ├── Security-Web (Claude Sonnet 4.6 (copilot)) — XSS, CSRF, open redirect, unsafe HTML
    └── Security-Infra (Gemini 3.1 Pro (Preview) (copilot)) — secrets, dependencies, webhooks, config
```

## Агенты пользователя (user-invocable: true)

| Агент | Модель | Когда использовать |
|---|---|---|
| **Conductor** | Claude Opus 4.6 (copilot) | Полный цикл: Planning → Implement → Review → Commit. Любая задача с кодом. |
| **Consilium-Boss** | Claude Opus 4.6 (copilot) | Архитектурные решения, споры, мультимодельный анализ. 4 аналитика + 4 дьявола + Boss Verdict. |
| **Security-Boss** | Claude Opus 4.6 (copilot) | Security-аудит: 4 OWASP-аналитика параллельно → Boss верификация + proof → отчёт. |

## Субагенты Conductor

| Агент | Модель | Роль | Режим |
|---|---|---|---|
| **Planning-subagent** | Claude Opus 4.6 (copilot) | Исследование, сбор контекста | Read-only |
| **Implement-subagent** | GPT-5.4 (copilot) | Реализация кода | Write (scoped) |
| **Code-review-subagent** | GPT-5.3-Codex (copilot) | 7-area code review + E2E chain validation | Read-only |
| **Proscons-devils-advocate** | GPT-5.4 (copilot) | Адверсариальное ревью, скрытые допущения | Read-only |
| **UI-Governor** | Gemini 3.1 Pro (Preview) (copilot) | UI consistency gate (только fb-front) | Read-only |

## Субагенты Consilium

### 4 Аналитика (изолированные, не видят друг друга)

| Агент | Модель | Угол анализа |
|---|---|---|
| **Consilium-Sonnet** | Claude Sonnet 4.6 (copilot) | Архитектура, системные паттерны, monorepo-wide scan |
| **Consilium-Opus** | Claude Opus 4.6 (copilot) | Глубокий reasoning, скрытые допущения, edge cases |
| **Consilium-Gemini** | Gemini 3.1 Pro (Preview) (copilot) | Кросс-система, ops, security, инфра-риски |
| **Consilium-Codex** | GPT-5.3-Codex (copilot) | Трассировка исполнения, LSP-based code execution |

### 4 Дьявола (атакуют Boss Verdict)

| Агент | Модель | Угол атаки |
|---|---|---|
| **Consilium-Devil** | GPT-5.3-Codex (copilot) | Код: конкретные execution paths, баги, missed callers |
| **Consilium-Devil-GPT** | GPT-5.4 (copilot) | Логика: противоречия, ложные предпосылки, hidden assumptions |
| **Consilium-Devil-Sonnet** | Claude Sonnet 4.6 (copilot) | Архитектура: масштабируемость, coupling, migration risk |
| **Consilium-Devil-Gemini** | Gemini 3.1 Pro (Preview) (copilot) | Ops/Security: deployment risk, secret hygiene, failure modes |

## Субагенты Security-Boss

### 4 OWASP-аналитика (параллельные, изолированные)

| Агент | Модель | Домен OWASP |
|---|---|---|
| **Security-Injection** | GPT-5.3-Codex (copilot) | A03 Injection: SQL/ORM, command, template, SSRF, path traversal |
| **Security-Auth** | Claude Opus 4.6 (copilot) | A01/A07 Auth: broken auth, IDOR, privilege escalation, JWT, multi-tenant |
| **Security-Web** | Claude Sonnet 4.6 (copilot) | A03/A07 Web: XSS, CSRF, open redirect, clickjacking, CSP, headers |
| **Security-Infra** | Gemini 3.1 Pro (Preview) (copilot) | A05/A06/A09 Infra: secrets, dependencies, webhooks, rate limiting, Docker/Nginx |

## Инфраструктура

### Skills (14 шт.)
| Skill | Триггер |
|---|---|
| `feature-dev` | Medium/large feature implementation |
| `pr-review-toolkit` | Code review, pre-merge check |
| `security-guidance` | Auth, secrets, validation, SQL/ORM |
| `docker-diagnostics` | Runtime/incident/infra config |
| `web-artifacts-builder` | Artifact/prototype/demo |
| `octocode-code-forensics` | Code navigation, impact analysis |
| `orchestration-qa` | Agent/skill/MCP config changes |
| `facebook-observability-lab` | Facebook env tuning, run comparison, markdown experiment ledger, runtime evidence |
| `playwright-ui-evidence` | UI visual evidence |
| `fb-front-datetime-timezone` | Date/time в fb-front |
| `fb-front-design-system-builder` | Новые UI components в fb-front |
| `fb-front-theme-darkmode` | Theme/dark mode в fb-front |
| `fb-front-ui-consistency` | Visual/layout в fb-front |
| `fb-front-react-practices` | React code в fb-front/whatsapp |

### MCP Servers (16 шт.)
- **Core**: crash, task-manager, memory
- **Evidence**: postgres, pgtuner, octocode, context7, chrome-devtools, playwright
- **Platform**: github, github-support-docs, github-copilot, kaggle, apify
- **Utility**: filesystem, mcp-files

### Hooks (4 файла)
- `pretool-guard.sh` — блокирует destructive commands (rm -rf, git reset, docker build)
- `posttool-quality.sh` — advisory prettier check on changed files
- `posttool-security.sh` — advisory scan на XSS, eval, SQL injection, hardcoded secrets
