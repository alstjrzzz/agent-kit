#!/usr/bin/env bash
# Desktop notification for Claude Code (WSL/Linux, via WSLg + notify-send).
title="${1:-Claude Code}"
body="${2:-}"

if [ -z "$body" ]; then
    stdin_json="$(cat 2>/dev/null)"
    if [ -n "$stdin_json" ]; then
        body="$(python3 -c '
import json, sys
try:
    data = json.load(sys.stdin)
    print(data.get("message", ""))
except Exception:
    pass
' <<<"$stdin_json")"
    fi
fi

[ -z "$body" ] && body="Waiting for your input"

if command -v notify-send >/dev/null 2>&1; then
    notify-send "$title" "$body"
fi
