#!/usr/bin/env python3
import sys, json, subprocess, datetime, os

os.environ["GIT_OPTIONAL_LOCKS"] = "0"

try:
    data = json.load(sys.stdin)
except Exception:
    data = {}

def get(path, default=""):
    cur = data
    for k in path.split("."):
        if not isinstance(cur, dict) or k not in cur:
            return default
        cur = cur[k]
    return cur if cur not in (None, "") else default

model = get("model.display_name", "unknown")
effort = get("effort.level")
effort_str = f" [{effort}]" if effort else ""

cwd = get("cwd") or get("workspace.current_dir") or "?"
dir_name = cwd.rstrip("/").split("/")[-1] or cwd

branch = ""
try:
    out = subprocess.run(
        ["git", "-C", cwd, "rev-parse", "--abbrev-ref", "HEAD"],
        capture_output=True, text=True, timeout=2,
    )
    if out.returncode == 0:
        branch = out.stdout.strip()
except Exception:
    pass
branch_str = f" | {branch}" if branch else ""

ESC = "\033"
RESET = f"{ESC}[0m"

used_pct = get("context_window.used_percentage")
if used_pct:
    used_int = round(float(used_pct))
    if used_int >= 90:
        color = f"{ESC}[31m"
    elif used_int >= 70:
        color = f"{ESC}[33m"
    else:
        color = f"{ESC}[32m"
    filled = int(used_int * 20 / 100)
    empty = 20 - filled
    context_str = f"{color}[{'#'*filled}{'-'*empty}]{RESET} {used_int}%"
else:
    context_str = "[--------------------] --%"

def rate_str(label, pct, resets_at):
    if not pct:
        return ""
    p = round(float(pct))
    reset_str = ""
    if resets_at:
        try:
            reset_time = datetime.datetime.fromtimestamp(int(resets_at)).astimezone()
            now = datetime.datetime.now().astimezone()
            fmt = "%H:%M" if reset_time.date() == now.date() else "%m/%d %H:%M"
            reset_str = f" (resets {reset_time.strftime(fmt)})"
        except Exception:
            pass
    return f" | {label}: {p}%{reset_str}"

rate = rate_str("5h", get("rate_limits.five_hour.used_percentage"), get("rate_limits.five_hour.resets_at"))
rate += rate_str("7d", get("rate_limits.seven_day.used_percentage"), get("rate_limits.seven_day.resets_at"))

print(f"{model}{effort_str} | {dir_name}{branch_str}")
print(f"ctx: {context_str}{rate}")
