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

risk_patterns=(
  "dangerouslySetInnerHTML"
  "eval\\s*\\("
  "new\\s+Function\\s*\\("
  "child_process\\.(exec|execSync|spawn)"
  "SELECT\\s+.*\\+"
  "INSERT\\s+.*\\+"
  "UPDATE\\s+.*\\+"
  "DELETE\\s+.*\\+"
  "password\\s*=\\s*['\"].+['\"]"
  "api[_-]?key\\s*=\\s*['\"].+['\"]"
  "secret\\s*=\\s*['\"].+['\"]"
)

hits=()
for file_path in "${files[@]}"; do
  [[ -f "$file_path" ]] || continue
  for pattern in "${risk_patterns[@]}"; do
    if grep -En -i "$pattern" "$file_path" >/tmp/posttool_security_grep.log 2>/dev/null; then
      hit_line="$(head -n 1 /tmp/posttool_security_grep.log | cut -d: -f1)"
      hits+=("$file_path:$hit_line")
      break
    fi
  done
done

if [[ ${#hits[@]} -eq 0 ]]; then
  printf '%s\n' '{"continue":true}'
  exit 0
fi

summary="Security guidance hook: review potential risk patterns at "
for hit in "${hits[@]}"; do
  summary+="$hit; "
done
summary+="confirm validation/sanitization and secret hygiene before finalize."

python3 - <<'PY' "$summary"
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
