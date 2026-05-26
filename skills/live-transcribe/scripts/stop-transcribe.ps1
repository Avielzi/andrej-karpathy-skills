# Stop the running realtime transcription (Windows)
$PidFile = "$env:TEMP\realtime-transcribe.pid"
$StopFile = "$env:TEMP\realtime-transcribe.stop"

if (Test-Path $PidFile) {
    $PID = Get-Content $PidFile
    $proc = Get-Process -Id $PID -ErrorAction SilentlyContinue
    if ($proc) {
        New-Item -Path $StopFile -ItemType File -Force | Out-Null
        # Wait up to 5 seconds for graceful stop
        for ($i = 0; $i -lt 10; $i++) {
            Start-Sleep -Milliseconds 500
            if (-not (Get-Process -Id $PID -ErrorAction SilentlyContinue)) { break }
        }
        # Force kill if still running
        if (Get-Process -Id $PID -ErrorAction SilentlyContinue) {
            Stop-Process -Id $PID -Force
        }
        Remove-Item -Path $PidFile, $StopFile -ErrorAction SilentlyContinue
        Write-Host "Transcription stopped."
    } else {
        Remove-Item -Path $PidFile -ErrorAction SilentlyContinue
        Write-Host "Transcription process not running (stale PID file removed)."
    }
} else {
    Write-Host "No active transcription found."
}
