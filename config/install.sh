#!/bin/bash
# agent-kit config copy script (macOS / Linux)
# Works regardless of clone location or current working directory.
#
# Usage:
#   ./install.sh <agent>
#
# Examples:
#   ./install.sh claude

set -e

# Physical location of this script (not the invocation directory)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

AGENT=$1

if [ -z "$AGENT" ]; then
  echo "Usage: ./install.sh <agent>"
  exit 1
fi

SOURCE="$SCRIPT_DIR/$AGENT"
TARGET="$HOME/.$AGENT"

mkdir -p "$TARGET"
cp -r "$SOURCE"/* "$TARGET"/
echo "Installed config: $TARGET"
