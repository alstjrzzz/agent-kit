#!/usr/bin/env python3
"""Emit a best-effort desktop notification for Codex stop events."""

import json
import shutil
import subprocess
import sys


def main() -> int:
    try:
        event = json.load(sys.stdin)
    except (json.JSONDecodeError, UnicodeDecodeError):
        event = {}

    notify_send = shutil.which("notify-send")
    if notify_send is None:
        return 0

    body = event.get("message") or "Task complete"
    subprocess.run(
        [notify_send, "Codex", str(body)],
        check=False,
        stdin=subprocess.DEVNULL,
        stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL,
    )
    return 0


if __name__ == "__main__":
    sys.exit(main())
