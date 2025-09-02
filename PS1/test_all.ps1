$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

Write-Host "[test_all] Running roadmap guard..."
& "$PSScriptRoot\tools\roadmap_guard.ps1"

Exit 0
