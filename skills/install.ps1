# agent-kit skill copy script (Windows PowerShell)
# Works regardless of clone location or current working directory.
#
# Usage:
#   .\install.ps1 <agent> <global|path> [skill1 skill2 ...]
#
# Examples:
#   .\install.ps1 claude C:\path\to\my-project readme-writing tech-writing
#   .\install.ps1 claude global

param(
    [Parameter(Mandatory=$true)][string]$Agent,
    [Parameter(Mandatory=$true)][string]$TargetArg,
    [Parameter(ValueFromRemainingArguments=$true)][string[]]$Skills
)

# Physical location of this script (not the invocation directory)
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

switch ($Agent) {
    "claude" { $Dir = ".claude\skills" }
    "codex"  { $Dir = ".codex\skills" }
    default  { Write-Error "Unsupported agent: $Agent (claude or codex)"; exit 1 }
}

if ($TargetArg -eq "global") {
    $Target = "$env:USERPROFILE\$Dir"
} else {
    if (-not (Test-Path $TargetArg)) {
        Write-Error "Path does not exist: $TargetArg"
        exit 1
    }
    $TargetAbs = (Resolve-Path $TargetArg).Path
    $Target = Join-Path $TargetAbs $Dir
}

New-Item -ItemType Directory -Force -Path $Target | Out-Null

if (-not $Skills -or $Skills.Count -eq 0) {
    # Copy only skill directories -- this script and README.md live alongside them
    Get-ChildItem -Path $ScriptDir -Directory | ForEach-Object {
        Copy-Item -Recurse -Force $_.FullName $Target
    }
    Write-Host "Installed all skills: $Target"
} else {
    foreach ($s in $Skills) {
        $src = Join-Path $ScriptDir $s
        if (Test-Path $src) {
            Copy-Item -Recurse -Force $src $Target
        } else {
            Write-Host "Skill not found: $s (skipped)"
        }
    }
    Write-Host "Installed: $Target"
}
