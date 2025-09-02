$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

Write-Host "[smoke] Roadmap quick check..."
& "$PSScriptRoot\tools\roadmap_guard.ps1" -Quick

Exit 0
