# agent-kit config copy script (Windows PowerShell)
# Works regardless of clone location or current working directory.
#
# Usage:
#   .\install.ps1 <agent>
#
# Examples:
#   .\install.ps1 claude

param(
    [Parameter(Mandatory=$true)][string]$Agent
)

# Physical location of this script (not the invocation directory)
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

$Source = Join-Path $ScriptDir $Agent
$Target = "$env:USERPROFILE\.$Agent"

New-Item -ItemType Directory -Force -Path $Target | Out-Null
Copy-Item -Recurse -Force "$Source\*" $Target

# Substitute the {{HOME}} placeholder with this machine's actual home path
# (JSON-escaped: single backslashes become double backslashes)
$escapedHome = $env:USERPROFILE.Replace('\', '\\')
Get-ChildItem -Path $Target -Recurse -File | Where-Object {
    (Get-Content -Raw $_.FullName) -match '\{\{HOME\}\}'
} | ForEach-Object {
    (Get-Content -Raw $_.FullName).Replace('{{HOME}}', $escapedHome) |
        Set-Content -Path $_.FullName -NoNewline
}

Write-Host "Installed config: $Target"
