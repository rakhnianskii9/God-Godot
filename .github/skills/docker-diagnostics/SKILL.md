---
name: docker-diagnostics
description: 'Use when backend/runtime/container health must be verified with evidence: Docker CLI status, logs, compose services, collector bundle, and post-change runtime checks without rebuilding images.'
user-invocable: true
disable-model-invocation: false
---

# Docker Diagnostics Skill

**Domain:** Runtime diagnostics via Docker CLI (containers, logs, compose services)  
**Scope:** Evidence-first runtime health checks for deployment, service failures, and post-implementation validation  
**Tool:** Docker CLI (`docker`, `docker-compose`) via terminal  
**Preferred collector:** `/home/projects/new-flowise/packages/vladislav/pnpm/collect-logs.sh`  
**Reference docs:** `/home/projects/new-flowise/docs/facebook/facebook-marketing-production-setup.md` L646-687

---

## When to Use (Triggers)

Invoke this skill when:
- 🔴 **Bug fix / косяк исправление**: user reports specific runtime failure (500 errors, service down, queue stuck)
- 🔴 **Implementation phase complete**: after code changes that touch server/worker/queue/db
- 🟡 **Code review phase**: validating that changes didn't break running services
- 🟡 **Performance issue**: slow response, memory leak, CPU spike
- 🟡 **Deployment validation**: after a non-Docker build, service restart, or other runtime-affecting validation step
- ⚪ **Devil's advocate review**: assessing runtime risk of proposed changes

**Important:**
- Never require or suggest Docker image rebuild as part of this skill. Use read-only Docker CLI evidence and container/runtime checks only.

**NOT for:**
- Static code analysis (use octocode-code-forensics instead)
- UI-only changes with no backend impact (use playwright-ui-evidence for visual evidence in the built-in browser on `cd /home/projects/new-flowise/packages/fb-front && pnpm dev`)
- Documentation-only updates

## Output Contract

Return:
- collection path used: collector or manual fallback
- artifact path when produced
- container health summary
- key error lines or explicit clean result
- follow-up recommendation: none | deeper drill-down needed | rollback discussion required

---

## Preferred Execution Path

If available, prefer the project collector script:

```bash
bash /home/projects/new-flowise/packages/vladislav/pnpm/collect-logs.sh
```

What it collects into `/home/projects/new-flowise/Zlogs.md`:
- docker logs for: `fb-front`, `wa-portal`, `wa-chat`, `wa-builder`, `flowise-main`, `flowise-worker`, `gupshup-worker`, `postgres`, `redis`
- `redis-cli INFO`
- latest `.flowise/logs/server.log.*` tail when present

Use this script as the default runtime-evidence bundle for:
- Planning-subagent runtime triage
- Implement-subagent post-change validation
- Code-review-subagent runtime gate
- Proscons-devils-advocate and Consilium runtime-risk review

Fallback policy:
- If the script is missing, fails, or deeper targeted inspection is needed, fall back to the manual protocol below.
- Do not edit the script from an agent unless the user explicitly asked to change diagnostics tooling.

Recommended evidence handoff:
```markdown
### Docker Diagnostics Bundle
- Collector: `bash /home/projects/new-flowise/packages/vladislav/pnpm/collect-logs.sh`
- Artifact: `/home/projects/new-flowise/Zlogs.md`
- Result: {success | partial | failed}
- Follow-up: {none | manual container drill-down required}
```

Handoff rule:
- When the preferred collector is used, the phase/review handoff MUST explicitly reference `/home/projects/new-flowise/Zlogs.md` as the evidence artifact.
- If the artifact was not produced, state why and switch to manual evidence collection explicitly.

---

## Evidence Collection Protocol

### Phase 1: Container Health Check (ALWAYS first)

Preferred path:

```bash
bash /home/projects/new-flowise/packages/vladislav/pnpm/collect-logs.sh
```

Manual fallback:

```bash
# 1. Check all project containers status
docker ps --filter "name=flowise" --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

# 2. Check for recently stopped/failed containers
docker ps -a --filter "name=flowise" --filter "status=exited" --format "table {{.Names}}\t{{.Status}}\t{{.ExitCode}}"
```

**Expected output:**
- `flowise-main`: Up (healthy)
- `flowise-worker`: Up (healthy)
- `flowise-postgres`: Up (healthy)
- `flowise-redis`: Up (healthy)

**Evidence format:**
```markdown
### Container Health
- flowise-main: {UP | DOWN | RESTARTING} (uptime: {duration})
- flowise-worker: {UP | DOWN | RESTARTING} (uptime: {duration})
- flowise-postgres: {UP | DOWN | RESTARTING} (uptime: {duration})
- flowise-redis: {UP | DOWN | RESTARTING} (uptime: {duration})
```

### Phase 2: Logs Diagnosis (when Phase 1 shows issues OR task involves runtime bug)

Preferred path:

```bash
bash /home/projects/new-flowise/packages/vladislav/pnpm/collect-logs.sh
# then inspect /home/projects/new-flowise/Zlogs.md
```

Manual fallback:

```bash
# 3. Check main server logs (last 50 lines + errors)
docker logs flowise-main --tail 50 2>&1 | grep -E "ERROR|WARN|FATAL|Exception|failed"

# 4. Check worker logs (last 50 lines + errors)
docker logs flowise-worker --tail 50 2>&1 | grep -E "ERROR|WARN|FATAL|Exception|failed"

# 5. Check postgres logs (last 30 lines + errors)
docker logs flowise-postgres --tail 30 2>&1 | grep -E "ERROR|FATAL|connection refused"

# 6. Check redis logs (last 20 lines)
docker logs flowise-redis --tail 20
```

**Evidence format:**
```markdown
### Logs Snapshot (last 50 lines each)
**flowise-main errors:**
{paste ERROR/WARN lines or "No errors"}

**flowise-worker errors:**
{paste ERROR/WARN lines or "No errors"}

**flowise-postgres errors:**
{paste ERROR/FATAL lines or "No errors"}

**flowise-redis status:**
{paste relevant lines or "Healthy"}
```

### Phase 3: Compose Services Status (when compose-level changes made)

```bash
# 7. Check docker-compose services
cd /home/projects/new-flowise/docker && docker-compose ps

# 8. Check compose logs (aggregated)
cd /home/projects/new-flowise/docker && docker-compose logs --tail=30 --timestamps
```

---

---

## Integration Points

### Planning-subagent (research phase)
**When:** User reports runtime bug / косяк
**Steps:**
1. Prefer `bash /home/projects/new-flowise/packages/vladislav/pnpm/collect-logs.sh`
2. If issues found → run Phase 2 (logs diagnosis)
3. Include evidence in research findings → pass to Conductor

### Implement-subagent (post-implementation validation)
**When:** Phase involves server/worker/queue/db changes
**Steps:**
1. After code changes + build → prefer `bash /home/projects/new-flowise/packages/vladislav/pnpm/collect-logs.sh`
2. If Phase 1 shows restarts/failures → run Phase 2
3. Include evidence in phase handoff → pass to Conductor

### Code-review-subagent (runtime validation)
**When:** Review phase for server/backend/db changes
**Steps:**
1. Prefer `bash /home/projects/new-flowise/packages/vladislav/pnpm/collect-logs.sh` — MANDATORY for backend changes
2. If any container DOWN or recent restarts → FAIL review (needs revision)
3. If Phase 1 clean → check Phase 2 logs for new ERROR/WARN patterns
4. Include evidence in review output and reference `/home/projects/new-flowise/Zlogs.md` when collector path was used → pass to Conductor

### Proscons-devils-advocate (risk assessment)
**When:** High-risk scope (DB schema, auth, payments, infra)
**Steps:**
1. Prefer `bash /home/projects/new-flowise/packages/vladislav/pnpm/collect-logs.sh` for baseline health evidence
2. If proposing changes → identify rollback commands
3. Include rollback plan in second-opinion output and reference `/home/projects/new-flowise/Zlogs.md` when collector path was used

---

## Rollback Detection (CRITICAL for bug fixes)

If container health check shows failures AFTER implementation:

**Immediate rollback triggers:**
- Any container stuck in `Restarting` loop
- `flowise-postgres` or `flowise-redis` down (data layer failure)
- `flowise-main` exit code != 0 (server crash)

**Rollback commands (copy-ready):**
```bash
# 1. Stop current containers
cd /home/projects/new-flowise/docker && docker-compose down

# 2. Verify git status (staged changes)
cd /home/projects/new-flowise && git status

# 3. STOP — DO NOT proceed with git rollback without user confirmation
# Report failure + rollback proposal to user
```

**NEVER execute git rollback commands (`git reset`, `git restore`, `git checkout`) without user verification** (per code-rules.instructions.md).

---

## Example Evidence Block (for handoff to Conductor)

```markdown
## Docker Diagnostics Evidence

**Trigger:** Implementation phase complete (server/Entity changes)

**Phase 1: Container Health**
- flowise-main: UP (uptime: 2h 15m)
- flowise-worker: UP (uptime: 2h 15m)
- flowise-postgres: UP (uptime: 5h 32m)
- flowise-redis: UP (uptime: 5h 32m)

**Phase 2: Logs Snapshot (last 50 lines)**
- flowise-main errors: No errors
- flowise-worker errors: No errors
- flowise-postgres errors: No errors
- flowise-redis status: Healthy

**Verdict:** ✅ No runtime issues detected post-implementation

**Tools used:** `docker ps`, `docker logs flowise-main`, `docker logs flowise-worker`
```

Or, when using the preferred collector:

```markdown
## Docker Diagnostics Evidence

**Trigger:** Runtime triage / post-implementation validation

**Collector:** `bash /home/projects/new-flowise/packages/vladislav/pnpm/collect-logs.sh`
**Artifact:** `/home/projects/new-flowise/Zlogs.md`

**Bundle contents:**
- Container logs: fb-front, wa-portal, wa-chat, wa-builder, flowise-main, flowise-worker, gupshup-worker, postgres, redis
- Redis INFO
- Latest `.flowise/logs/server.log.*` tail (if present)

**Verdict:** {✅ evidence collected | ⚠ partial | ❌ failed}
```

---

## Maintenance Notes

- Keep commands in sync with `/home/projects/new-flowise/docs/facebook/facebook-marketing-production-setup.md` L646-687
- Keep the preferred collector path in sync with `/home/projects/new-flowise/packages/vladislav/pnpm/collect-logs.sh`
- If new services added (e.g., `flowise-nginx`, `flowise-queue`) → update Phase 1 checklist
- If the collector script adds/removes services, update the evidence description in this skill
- If docker-compose.yml location changes → update commands
- Log retention: docker keeps last 1000 lines by default; for deeper history use project logs in `.flowise/storage/logs/` (if exists)

---

**Last Updated:** 2026-02-16  
**Owned by:** Conductor + all subagents (Planning/Implement/Review/Devil)  
**Dependencies:** Docker CLI, docker-compose
