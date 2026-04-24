#!/usr/bin/env bash
set -euo pipefail

base_url="https://raw.githubusercontent.com/anthropics/skills/main/skills/web-artifacts-builder"
work_dir="$(mktemp -d)"
script_path="$work_dir/bundle-artifact.sh"

cleanup() {
  rm -rf "$work_dir"
}
trap cleanup EXIT

echo "[web-artifacts-builder] Fetching upstream bundler..."
curl -fsSL "$base_url/scripts/bundle-artifact.sh" -o "$script_path"
chmod +x "$script_path"

echo "[web-artifacts-builder] Running upstream bundler in $(pwd)..."
bash "$script_path"

echo "[web-artifacts-builder] Done: bundle.html"
