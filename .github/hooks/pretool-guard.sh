#!/usr/bin/env bash
set -euo pipefail

payload="$(cat)"
tool_name="$(printf '%s' "$payload" | python3 -c 'import json,sys; d=json.load(sys.stdin); print(d.get("tool_name",""))')"
command_line="$(printf '%s' "$payload" | python3 -c 'import json,sys; d=json.load(sys.stdin); ti=d.get("tool_input",{}); print(ti.get("command") or ti.get("cmd") or "")' 2>/dev/null || true)"

destructive_regex='(^|[[:space:]])(rm[[:space:]]+-rf|sudo[[:space:]]+rm|mkfs|dd[[:space:]]+if=|shutdown|reboot|halt|init[[:space:]]+0|drop[[:space:]]+database|git[[:space:]]+(reset|restore|clean|revert)|git[[:space:]]+checkout[[:space:]]+--)([[:space:]]|$)'

# Запретить ТОЛЬКО docker build workflow, который запускается через `pnpm build:compose`.
# Разрешаем обычный `pnpm build` и любые другие команды.
# Важно: ловим и случаи с обёртками вроде `cd ... && pnpm ... build:compose` или `sudo -E pnpm ... build:compose`.
pnpm_token_regex='(^|[^[:alnum:]_])pnpm([^[:alnum:]_]|$)'
build_compose_token_regex='(^|[^[:alnum:]_])build:compose([^[:alnum:]_]|$)'
docker_compose_build_regex='(^|[^[:alnum:]_])docker([^[:alnum:]_]|$).*compose([^[:alnum:]_]|$).*build([^[:alnum:]_]|$)'

if [[ "$tool_name" == *"runInTerminal"* || "$tool_name" == *"terminal"* ]]; then
  if [[ "$command_line" =~ $destructive_regex ]]; then
    printf '%s\n' '{"continue":true,"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"deny","permissionDecisionReason":"Blocked by workspace security hook: destructive terminal command."}}'
    exit 0
  fi

  if [[ ("$command_line" =~ $pnpm_token_regex && "$command_line" =~ $build_compose_token_regex) || "$command_line" =~ $docker_compose_build_regex ]]; then
    printf '%s\n' '{"continue":true,"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"deny","permissionDecisionReason":"Blocked by workspace security hook: docker build via build:compose is not allowed."}}'
    exit 0
  fi
fi

printf '%s\n' '{"continue":true}'
