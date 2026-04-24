#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../../../.." && pwd)"
TEMPLATE="$ROOT/.github/skills/facebook-observability-lab/templates/iteration-report.template.md"
TARGET="${1:-$ROOT/plans/facebook-observability-lab.md}"

if [[ ! -f "$TEMPLATE" ]]; then
  echo "Template not found: $TEMPLATE" >&2
  exit 1
fi

if [[ -e "$TARGET" ]]; then
  echo "Refusing to overwrite existing file: $TARGET" >&2
  exit 1
fi

mkdir -p "$(dirname "$TARGET")"
GENERATED_AT="$(TZ=Asia/Ho_Chi_Minh date '+%Y-%m-%d %H:%M:%S %Z')"

sed "s/{{GENERATED_AT}}/$GENERATED_AT/g" "$TEMPLATE" > "$TARGET"

echo "Created ledger: $TARGET"