---
name: security-guidance
description: 'Use when code touches auth, secrets, input validation, HTML rendering, SQL/ORM, webhooks, logs, tokens, or trust boundaries in the Flowise monorepo.'
user-invocable: true
disable-model-invocation: false
---

# Security Guidance

Use this skill when implementing or reviewing risky code paths in this repository.

## Trigger Phrases

Load this skill when the task involves:
- auth, OAuth, sessions, tokens, credentials
- secrets, env values, webhook signatures, API keys
- SQL/ORM queries, migrations, filters, dynamic query construction
- user input, external payloads, JSON bodies, query params, uploads
- HTML rendering, rich text, templating, browser script generation
- logging of user/provider payloads, identifiers, phone/email, access data

## Repository-Specific Focus

- `packages/server/**` — auth flows, routes, services, TypeORM, webhooks, queue jobs
- `packages/fb-front/**` and `packages/whatsapp/**` — unsafe HTML, token exposure, over-trusting client state
- `.github/**`, `docker/**`, `nginx/**` — secret/config hygiene and least privilege

## High-Priority Checks

- SQL/ORM query safety: no string-concatenated SQL where parameters should be used
- Input validation for external and user-provided payloads
- XSS paths: `dangerouslySetInnerHTML`, unsanitized HTML, dynamic script generation
- Secrets/config hygiene: no secret literals, no leaked env values, no logging of sensitive config
- Auth/session/token handling: avoid over-trusting client input, stale tokens, silent privilege escalation
- Webhook trust boundaries: verify signatures/origin assumptions before treating input as trusted
- Logging hygiene: redact or avoid raw payloads containing identifiers, contact data, or tokens

## Operational Checks

- Rollback path for risky DB/infra changes
- Principle of least privilege for automation scripts/hooks
- No broad auto-approval for destructive or privileged operations
- No accidental exposure of security-sensitive findings in user-facing examples

## Output Contract

Return a concise risk matrix with:
- risk
- impact
- evidence (file/function/path)
- mitigation
- residual risk

If no meaningful security issue is found, say so explicitly and note what surfaces were checked.
