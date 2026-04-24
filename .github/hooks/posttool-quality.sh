#!/usr/bin/env bash
set -euo pipefail

payload="$(cat)"

readarray -t files < <(
  printf '%s' "$payload" | python3 - <<'PY'
import json, sys

def emit(path):
    if isinstance(path, str) and path.strip():
        print(path.strip())

try:
    data = json.load(sys.stdin)
except Exception:
    sys.exit(0)

tool = str(data.get("tool_name", ""))
if "edit" not in tool.lower():
    sys.exit(0)

ti = data.get("tool_input", {})

if isinstance(ti, dict):
    if isinstance(ti.get("filePath"), str):
        emit(ti.get("filePath"))
    if isinstance(ti.get("filePaths"), list):
        for item in ti.get("filePaths"):
            emit(item)
    if isinstance(ti.get("files"), list):
        for item in ti.get("files"):
            if isinstance(item, str):
                emit(item)
            elif isinstance(item, dict):
                for key in ("filePath", "path", "target", "newPath"):
                    emit(item.get(key))
PY
)

if [[ ${#files[@]} -eq 0 ]]; then
  printf '%s\n' '{"continue":true}'
  exit 0
fi

existing_files=()
for file_path in "${files[@]}"; do
  if [[ -f "$file_path" ]]; then
    existing_files+=("$file_path")
  fi
done

if [[ ${#existing_files[@]} -eq 0 ]]; then
  printf '%s\n' '{"continue":true}'
  exit 0
fi

prettier_bin="./node_modules/.bin/prettier"

prettier_failed=0
checks_run=()

if [[ -x "$prettier_bin" ]]; then
  checks_run+=("prettier")
  "$prettier_bin" --check "${existing_files[@]}" >/tmp/posttool_prettier.log 2>&1 || prettier_failed=1
fi

if [[ ${#checks_run[@]} -eq 0 ]]; then
  printf '%s\n' '{"continue":true,"hookSpecificOutput":{"hookEventName":"PostToolUse","additionalContext":"PostToolUse quality hook skipped: prettier binary not found in ./node_modules/.bin."}}'
  exit 0
fi

if [[ $prettier_failed -eq 0 ]]; then
  printf '%s\n' '{"continue":true}'
  exit 0
fi

msg="PostToolUse quality checks found issues after edit tool."
if [[ $prettier_failed -eq 1 ]]; then
  msg+=" prettier --check failed;"
fi
msg+=" run formatter on changed files before finalizing."

python3 - <<'PY' "$msg"
import json, sys
message = sys.argv[1]
print(json.dumps({
  "continue": True,
  "hookSpecificOutput": {
    "hookEventName": "PostToolUse",
    "additionalContext": message
  }
}, ensure_ascii=False))
PY
