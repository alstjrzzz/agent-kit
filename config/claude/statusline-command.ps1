$inputJson = [Console]::In.ReadToEnd()
$ESC = [char]27

function Get-JsonValue([string]$json, [string]$path) {
    try {
        $obj = $json | ConvertFrom-Json
        $val = $obj
        foreach ($k in ($path -split '\.')) {
            if ($null -eq $val) { return '' }
            $val = $val.$k
        }
        if ($null -ne $val) { return [string]$val } else { return '' }
    } catch { return '' }
}

$model = Get-JsonValue $inputJson 'model.display_name'
if (-not $model) { $model = 'unknown' }

$effort = Get-JsonValue $inputJson 'effort.level'
$effortStr = if ($effort) { " [$effort]" } else { '' }

$cwd = Get-JsonValue $inputJson 'cwd'
if (-not $cwd) { $cwd = Get-JsonValue $inputJson 'workspace.current_dir' }
if (-not $cwd) { $cwd = '?' }
$dir = Split-Path $cwd -Leaf

$branch = ''
try {
    $env:GIT_OPTIONAL_LOCKS = '0'
    $branch = & git -C $cwd rev-parse --abbrev-ref HEAD 2>$null
    if ($LASTEXITCODE -ne 0) { $branch = '' }
} catch { $branch = '' }
$branchStr = if ($branch) { " | $branch" } else { '' }

# PR info is already shown in Claude Code's own status row below — not duplicated here

$usedPct = Get-JsonValue $inputJson 'context_window.used_percentage'
if ($usedPct) {
    $usedInt = [int][Math]::Round([double]$usedPct)
    $barColor = if ($usedInt -ge 90) { "${ESC}[31m" } elseif ($usedInt -ge 70) { "${ESC}[33m" } else { "${ESC}[32m" }
    $reset = "${ESC}[0m"
    $filled = [int]($usedInt * 20 / 100)
    $empty = 20 - $filled
    $contextStr = "${barColor}[$('#' * $filled)$('-' * $empty)]${reset} ${usedInt}%"
} else {
    $contextStr = '[--------------------] --%'
}

function Get-RateStr([string]$label, [string]$pct, [string]$resetsAt) {
    if (-not $pct) { return '' }
    $p = [int][Math]::Round([double]$pct)
    $resetStr = ''
    if ($resetsAt) {
        try {
            $resetTime = [DateTimeOffset]::FromUnixTimeSeconds([long]$resetsAt).ToLocalTime()
            $fmt = if ($resetTime.Date -eq (Get-Date).Date) { 'HH:mm' } else { 'MM/dd HH:mm' }
            $resetStr = " (resets $($resetTime.ToString($fmt)))"
        } catch {}
    }
    return " | ${label}: ${p}%${resetStr}"
}

$fivePct = Get-JsonValue $inputJson 'rate_limits.five_hour.used_percentage'
$fiveResetsAt = Get-JsonValue $inputJson 'rate_limits.five_hour.resets_at'
$sevenPct = Get-JsonValue $inputJson 'rate_limits.seven_day.used_percentage'
$sevenResetsAt = Get-JsonValue $inputJson 'rate_limits.seven_day.resets_at'
$rateStr = (Get-RateStr '5h' $fivePct $fiveResetsAt) + (Get-RateStr '7d' $sevenPct $sevenResetsAt)

[Console]::Out.WriteLine("${model}${effortStr} | ${dir}${branchStr}${prStr}")
[Console]::Out.WriteLine("ctx: ${contextStr}${rateStr}")
