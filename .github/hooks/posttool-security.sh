#!/usr/bin/env bash
set -euo pipefail

payload="$(cat)"
tmp_dir="${TMPDIR:-/tmp}"
grep_log="$(mktemp "$tmp_dir/posttool_security.XXXXXX")"
trap 'rm -f "$grep_log"' EXIT

readarray -t files < <(
  PAYLOAD="$payload" python3 - <<'PY'
import json, os, sys

def emit(path):
    if isinstance(path, str) and path.strip():
        print(path.strip())

def emit_from_patch(patch_text):
  if not isinstance(patch_text, str):
    return
  for raw_line in patch_text.splitlines():
    line = raw_line.strip()
    if line.startswith("*** Update File: ") or line.startswith("*** Add File: "):
      path = line.split(": ", 1)[1].split(" -> ", 1)[0].strip()
      emit(path)

try:
  data = json.loads(os.environ["PAYLOAD"])
except Exception:
    sys.exit(0)

tool = str(data.get("tool_name", ""))
tool_lower = tool.lower()
if not any(token in tool_lower for token in ("edit", "patch", "create", "write")):
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
    emit_from_patch(ti.get("input"))
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
  "System\\.Diagnostics\\.Process"
  "Process\\.Start\\s*\\("
  "OS\\.execute\\s*\\("
  "OS\\.create_process\\s*\\("
  "JavaScriptBridge\\.eval\\s*\\("
  "SELECT\\s+.*\\+"
  "INSERT\\s+.*\\+"
  "UPDATE\\s+.*\\+"
  "DELETE\\s+.*\\+"
  "password\\s*=\\s*['\"].+['\"]"
  "api[_-]?key\\s*=\\s*['\"].+['\"]"
  "secret\\s*=\\s*['\"].+['\"]"
  "token\\s*=\\s*['\"].+['\"]"
)

hits=()
for file_path in "${files[@]}"; do
  [[ -f "$file_path" ]] || continue
  for pattern in "${risk_patterns[@]}"; do
    if grep -En -i "$pattern" "$file_path" >"$grep_log" 2>/dev/null; then
      hit_line="$(head -n 1 "$grep_log" | cut -d: -f1)"
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
