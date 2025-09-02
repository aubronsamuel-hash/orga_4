$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

Write-Host "[smoke] Roadmap quick check..."
& "$PSScriptRoot\tools\roadmap_guard.ps1" -Quick

Write-Host "[smoke] Export employee spec..."
& "$PSScriptRoot\specs\export_employe.ps1"

Write-Host "[smoke] Email regex quick test..."
& "$PSScriptRoot\tests\spec_employee_email_regex.ps1"

Write-Host "[smoke] Export orgchart spec..."
& "$PSScriptRoot\specs\export_org.ps1"

Write-Host "[smoke] Org hierarchy quick test..."
& "$PSScriptRoot\tests\spec_org_hierarchy.ps1"

Write-Host "[smoke] OK"
Exit 0
