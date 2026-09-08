#!/bin/bash
# agent-kit skill copy script (macOS / Linux)
# Works regardless of clone location or current working directory.
#
# Usage:
#   ./install.sh <agent> <global|path> [skill1 skill2 ...]
#
# Examples:
#   ./install.sh claude /path/to/my-project readme-writing tech-writing
#   ./install.sh claude global

set -e

# Physical location of this script (not the invocation directory)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

AGENT=$1
TARGET_ARG=$2
shift 2 || true
SKILLS=("$@")

if [ -z "$AGENT" ] || [ -z "$TARGET_ARG" ]; then
  echo "Usage: ./install.sh <agent> <global|path> [skill1 skill2 ...]"
  exit 1
fi

case "$AGENT" in
  claude) DIR=".claude/skills" ;;
  codex)  DIR=".codex/skills" ;;
  *) echo "Unsupported agent: $AGENT (claude or codex)"; exit 1 ;;
esac

if [ "$TARGET_ARG" = "global" ]; then
  TARGET="$HOME/$DIR"
else
  if [ ! -d "$TARGET_ARG" ]; then
    echo "Path does not exist: $TARGET_ARG"
    exit 1
  fi
  # Normalize to an absolute path via a subshell cd. Does not affect this script's cwd.
  TARGET_ABS="$(cd "$TARGET_ARG" && pwd)"
  TARGET="$TARGET_ABS/$DIR"
fi

mkdir -p "$TARGET"

if [ ${#SKILLS[@]} -eq 0 ]; then
  # Copy only skill directories -- this script and README.md live alongside them
  for d in "$SCRIPT_DIR"/*/; do
    [ -d "$d" ] && cp -r "$d" "$TARGET"/
  done
  echo "Installed all skills: $TARGET"
else
  for s in "${SKILLS[@]}"; do
    if [ -d "$SCRIPT_DIR/$s" ]; then
      cp -r "$SCRIPT_DIR/$s" "$TARGET"/
    else
      echo "Skill not found: $s (skipped)"
    fi
  done
  echo "Installed: $TARGET"
fi
