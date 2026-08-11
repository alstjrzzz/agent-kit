param(
    [string]$Title = "Claude Code",
    [string]$Body = ""
)

# Read stdin — Notification event provides a "message" field
try {
    $raw = [Console]::In.ReadToEnd()
    if ($raw.Trim() -and -not $Body) {
        $json = $raw | ConvertFrom-Json -ErrorAction Stop
        if ($json.message) { $Body = $json.message }
    }
} catch {}

if (-not $Body) { $Body = "Waiting for your input" }

# Modern WinRT toast (Windows 10/11)
try {
    [Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null
    [Windows.Data.Xml.Dom.XmlDocument, Windows.Data.Xml.Dom.XmlDocument, ContentType = WindowsRuntime] | Out-Null

    $t = [System.Security.SecurityElement]::Escape($Title)
    $b = [System.Security.SecurityElement]::Escape($Body)

    $xml = New-Object Windows.Data.Xml.Dom.XmlDocument
    $xml.LoadXml("<toast><visual><binding template=`"ToastGeneric`"><text>$t</text><text>$b</text></binding></visual></toast>")
    [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier("Claude Code").Show(
        [Windows.UI.Notifications.ToastNotification]::new($xml)
    )
} catch {
    # Fallback: system tray balloon (always available)
    Add-Type -AssemblyName System.Windows.Forms
    $ni = New-Object System.Windows.Forms.NotifyIcon
    $ni.Icon = [System.Drawing.SystemIcons]::Information
    $ni.Visible = $true
    $ni.ShowBalloonTip(5000, $Title, $Body, [System.Windows.Forms.ToolTipIcon]::Info)
    Start-Sleep -Seconds 4
    $ni.Dispose()
}
