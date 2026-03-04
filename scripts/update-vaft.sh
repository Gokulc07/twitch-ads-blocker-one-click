#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET="$ROOT_DIR/extension/injected/vaft.js"
META="$ROOT_DIR/extension/injected/upstream.txt"
URL="https://raw.githubusercontent.com/pixeltris/TwitchAdSolutions/master/vaft/vaft.user.js"
TMP_FILE="$(mktemp)"

cleanup() {
  rm -f "$TMP_FILE"
}
trap cleanup EXIT

curl -fsSL "$URL" -o "$TMP_FILE"

VERSION="$(grep -Eo '@version[[:space:]]+[0-9.]+' "$TMP_FILE" | awk '{print $2}' | head -n 1 || true)"
COMMIT="$(
  curl -fsSL https://api.github.com/repos/pixeltris/TwitchAdSolutions/commits/master 2>/dev/null \
    | grep -Eo '"sha"[[:space:]]*:[[:space:]]*"[a-f0-9]{40}"' \
    | head -n 1 \
    | sed -E 's/.*"([a-f0-9]{40})"/\1/' \
    | head -n 1 \
    || true
)"

awk '
BEGIN { in_meta=0 }
/^\/\/ ==UserScript==/ { in_meta=1; next }
/^\/\/ ==\/UserScript==/ { in_meta=0; next }
in_meta { next }
{ print }
' "$TMP_FILE" > "$TARGET"

{
  echo "source=$URL"
  echo "version=${VERSION:-unknown}"
  echo "commit=${COMMIT:-unknown}"
  echo "updated_utc=$(date -u +%Y-%m-%dT%H:%M:%SZ)"
} > "$META"

echo "Updated VAFT engine"
echo "  version: ${VERSION:-unknown}"
echo "  commit:  ${COMMIT:-unknown}"
echo "  target:  $TARGET"
