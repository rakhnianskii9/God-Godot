#!/usr/bin/env bash
set -euo pipefail

if [[ -z "${1:-}" ]]; then
  echo "Usage: bash .github/skills/web-artifacts-builder/scripts/init-artifact.sh <project-name>"
  exit 1
fi

project_name="$1"
base_url="https://raw.githubusercontent.com/anthropics/skills/main/skills/web-artifacts-builder"
work_dir="$(mktemp -d)"
script_dir="$work_dir/scripts"
mkdir -p "$script_dir"

cleanup() {
  rm -rf "$work_dir"
}
trap cleanup EXIT

echo "[web-artifacts-builder] Fetching upstream init assets..."
curl -fsSL "$base_url/scripts/init-artifact.sh" -o "$script_dir/init-artifact.sh"
curl -fsSL "$base_url/scripts/shadcn-components.tar.gz" -o "$script_dir/shadcn-components.tar.gz"

chmod +x "$script_dir/init-artifact.sh"

echo "[web-artifacts-builder] Running upstream initializer..."
(
  cd "$(pwd)"
  PROJECT_NAME="$project_name" bash "$script_dir/init-artifact.sh" "$project_name"
)

echo "[web-artifacts-builder] Done: $project_name"
