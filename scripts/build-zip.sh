#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
EXT_DIR="$ROOT_DIR/extension"
DIST_DIR="$ROOT_DIR/dist"
ZIP_PATH="$DIST_DIR/twitch-ads-blocker-extension.zip"

mkdir -p "$DIST_DIR"
rm -f "$ZIP_PATH"

(
  cd "$EXT_DIR"
  zip -r "$ZIP_PATH" . -x '*.DS_Store'
)

echo "Built extension zip: $ZIP_PATH"
