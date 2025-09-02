$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

Write-Host "[test_all] Running roadmap guard..."
& "$PSScriptRoot\tools\roadmap_guard.ps1"

Write-Host "[test_all] Exporting employee spec..."
& "$PSScriptRoot\specs\export_employe.ps1"

Write-Host "[test_all] Running spec email regex tests..."
& "$PSScriptRoot\tests\spec_employee_email_regex.ps1"

Write-Host "[test_all] DONE"
Exit 0
