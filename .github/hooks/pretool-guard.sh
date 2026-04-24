#!/usr/bin/env bash
set -euo pipefail

payload="$(cat)"
tool_name="$(printf '%s' "$payload" | python3 -c 'import json,sys; d=json.load(sys.stdin); print(d.get("tool_name",""))')"
command_line="$(printf '%s' "$payload" | python3 -c 'import json,sys; d=json.load(sys.stdin); ti=d.get("tool_input",{}); task=ti.get("task") or {}; print(ti.get("command") or ti.get("cmd") or task.get("command") or "")' 2>/dev/null || true)"

destructive_regex='(^|[[:space:]])(rm[[:space:]]+-rf|sudo[[:space:]]+rm|mkfs|dd[[:space:]]+if=|shutdown|reboot|halt|init[[:space:]]+0|drop[[:space:]]+database|git[[:space:]]+(reset|restore|clean|revert)|git[[:space:]]+checkout[[:space:]]+--)([[:space:]]|$)'
container_build_regex='(^|[;&|[:space:]])((docker|podman)[[:space:]]+(build|buildx[[:space:]]+build)|docker-compose[[:space:]]+build|(docker|podman)[[:space:]]+compose([[:space:]]+[^;&|[:space:]]+)*[[:space:]]+build)([[:space:]]|$)'

if [[ "$tool_name" == *"runInTerminal"* || "$tool_name" == *"terminal"* || "$tool_name" == *"createAndRunTask"* || "$tool_name" == *"create_and_run_task"* ]]; then
  if [[ "$command_line" =~ $destructive_regex ]]; then
    printf '%s\n' '{"continue":true,"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"deny","permissionDecisionReason":"Blocked by workspace security hook: destructive terminal command."}}'
    exit 0
  fi

  if [[ "$command_line" =~ $container_build_regex ]]; then
    printf '%s\n' '{"continue":true,"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"deny","permissionDecisionReason":"Blocked by workspace security hook: container image builds are not allowed from this workspace."}}'
    exit 0
  fi
fi

printf '%s\n' '{"continue":true}'
