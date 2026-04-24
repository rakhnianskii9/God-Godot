#!/usr/bin/env bash
set -euo pipefail

payload="$(cat)"
tmp_dir="${TMPDIR:-/tmp}"

resolve_dotnet_target() {
  local file_path="$1"
  local dir
  local candidate

  case "$file_path" in
    *.csproj|*.sln)
      printf '%s\n' "$file_path"
      return 0
      ;;
  esac

  dir="$(dirname "$file_path")"
  while [[ -n "$dir" && "$dir" != "/" ]]; do
    while IFS= read -r candidate; do
      printf '%s\n' "$candidate"
      return 0
    done < <(find "$dir" -maxdepth 1 -type f -name '*.csproj' | sort)

    while IFS= read -r candidate; do
      printf '%s\n' "$candidate"
      return 0
    done < <(find "$dir" -maxdepth 1 -type f -name '*.sln' | sort)

    if [[ "$dir" == "$(dirname "$dir")" ]]; then
      break
    fi
    dir="$(dirname "$dir")"
  done

  return 1
}

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

json_log="$(mktemp "$tmp_dir/posttool_json.XXXXXX")"
shell_log="$(mktemp "$tmp_dir/posttool_shell.XXXXXX")"
python_log="$(mktemp "$tmp_dir/posttool_python.XXXXXX")"
dotnet_log="$(mktemp "$tmp_dir/posttool_dotnet.XXXXXX")"
trap 'rm -f "$json_log" "$shell_log" "$python_log" "$dotnet_log"' EXIT

json_files=()
shell_files=()
python_files=()
gdscript_files=()
csharp_inputs=()
csharp_targets=()

json_failed=0
shell_failed=0
python_failed=0
dotnet_failed=0
checks_run=()
notes=()

for file_path in "${existing_files[@]}"; do
  case "$file_path" in
    *.json)
      json_files+=("$file_path")
      ;;
    *.sh|*.bash)
      shell_files+=("$file_path")
      ;;
    *.py)
      python_files+=("$file_path")
      ;;
    *.cs|*.csproj|*.sln)
      csharp_inputs+=("$file_path")
      ;;
    *.gd|*.gdshader|*.tscn|*.tres|*.godot)
      gdscript_files+=("$file_path")
      ;;
  esac
done

if command -v jq >/dev/null 2>&1 && [[ ${#json_files[@]} -gt 0 ]]; then
  checks_run+=("json")
  for file_path in "${json_files[@]}"; do
    if ! jq empty "$file_path" >"$json_log" 2>&1; then
      json_failed=1
      break
    fi
  done
fi

if [[ ${#shell_files[@]} -gt 0 ]]; then
  checks_run+=("shell")
  for file_path in "${shell_files[@]}"; do
    if ! bash -n "$file_path" >"$shell_log" 2>&1; then
      shell_failed=1
      break
    fi
  done
fi

if command -v python3 >/dev/null 2>&1 && [[ ${#python_files[@]} -gt 0 ]]; then
  checks_run+=("python")
  for file_path in "${python_files[@]}"; do
    if ! python3 -m py_compile "$file_path" >"$python_log" 2>&1; then
      python_failed=1
      break
    fi
  done
fi

if [[ ${#csharp_inputs[@]} -gt 0 ]]; then
  if command -v dotnet >/dev/null 2>&1; then
    for file_path in "${csharp_inputs[@]}"; do
      target="$(resolve_dotnet_target "$file_path" || true)"
      if [[ -z "$target" ]]; then
        notes+=("C# validation skipped for $file_path: no nearby .csproj or .sln found")
        continue
      fi

      seen_target=0
      for existing_target in "${csharp_targets[@]}"; do
        if [[ "$existing_target" == "$target" ]]; then
          seen_target=1
          break
        fi
      done

      if [[ $seen_target -eq 0 ]]; then
        csharp_targets+=("$target")
      fi
    done

    dotnet_attempted=0
    for target in "${csharp_targets[@]}"; do
      if [[ "$target" == *.csproj ]]; then
        assets_file="$(dirname "$target")/obj/project.assets.json"
        if [[ ! -f "$assets_file" ]]; then
          notes+=("dotnet validation skipped for $(basename "$target"): restore artifacts not found")
          continue
        fi
      fi

      dotnet_attempted=1
      if ! dotnet build "$target" --no-restore --nologo -v quiet >"$dotnet_log" 2>&1; then
        if grep -q 'project.assets.json' "$dotnet_log"; then
          notes+=("dotnet validation skipped for $(basename "$target"): restore artifacts not found")
          : >"$dotnet_log"
          continue
        fi
        dotnet_failed=1
        break
      fi
    done

    if [[ $dotnet_attempted -eq 1 ]]; then
      checks_run+=("dotnet")
    fi
  else
    notes+=("C# validation skipped: dotnet not found")
  fi
fi

if [[ ${#gdscript_files[@]} -gt 0 ]]; then
  if command -v gdlint >/dev/null 2>&1; then
    checks_run+=("gdlint")
    if ! gdlint "${gdscript_files[@]}" >/dev/null 2>&1; then
      notes+=("gdlint found issues in Godot files")
    fi
  else
    notes+=("Godot file validation skipped: gdlint not found")
  fi
fi

if [[ ${#checks_run[@]} -eq 0 ]]; then
  message="PostToolUse quality hook skipped: no applicable local validators found for edited files."
  if [[ ${#notes[@]} -gt 0 ]]; then
    message+=" ${notes[*]}."
  fi
  python3 - <<'PY' "$message"
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
  exit 0
fi

if [[ $json_failed -eq 0 && $shell_failed -eq 0 && $python_failed -eq 0 && $dotnet_failed -eq 0 ]]; then
  if [[ ${#notes[@]} -eq 0 ]]; then
    printf '%s\n' '{"continue":true}'
    exit 0
  fi

  message="PostToolUse quality checks passed with limited validation. ${notes[*]}."
  python3 - <<'PY' "$message"
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
  printf '%s\n' '{"continue":true}'
  exit 0
fi

msg="PostToolUse quality checks found issues after edit tool."
if [[ $json_failed -eq 1 ]]; then
  msg+=" JSON syntax validation failed;"
fi
if [[ $shell_failed -eq 1 ]]; then
  msg+=" bash -n failed;"
fi
if [[ $python_failed -eq 1 ]]; then
  msg+=" python3 -m py_compile failed;"
fi
if [[ $dotnet_failed -eq 1 ]]; then
  msg+=" dotnet build --no-restore failed;"
fi
if [[ ${#notes[@]} -gt 0 ]]; then
  msg+=" ${notes[*]};"
fi
msg+=" review the reported files before finalizing."

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
